# FS-54 measurement environment

Set up 2026-09-16 on the **desktop** (16 physical cores / 32 threads, 125 GiB RAM), right after
Kooshi's `pacman -Syu` and reboot. Python 3.14.7 (system), gcc/g++ 16.2.1, cmake 4.4.3, openmpi 5.0.11,
nauty 2.9.3 (system), GAP 4.16.1 with `gap-packages` 4.16.1.

Two things in this machine's environment break ordinary builds, and both are recorded below with their mechanism:
**`LIBRARY_PATH` from `scripts/dev-env.sh` breaks every C/C++ link outside Lean**, and **OR-Tools and cvxpy's HiGHS
dependency ship two incompatible copies of one shared library**.

## 1. The Python venv — `/home/kooshi/source/lean-dir/.venv`

Standard `venv` (so `pip` lives inside it), ignored by git (`/.venv/` in `.gitignore`).

### Rebuild from scratch

```bash
cd /home/kooshi/source/lean-dir
rm -rf .venv
python3 -m venv .venv
.venv/bin/python -m pip install --upgrade pip
# LIBRARY_PATH must be unset: see "Build failure 1" below
env -u LIBRARY_PATH .venv/bin/python -m pip install \
    numpy scipy sympy networkx python-sat ortools pynauty cvxpy scs numba
# pin highspy to the HiGHS version OR-Tools bundles: see "Build failure 2" below
env -u LIBRARY_PATH .venv/bin/python -m pip install "highspy==1.12.0"
```

### `pip freeze` (pip 26.2.1)

```
absl-py==2.5.0
cffi==2.1.1
clarabel==0.11.1
cloudpickle==3.1.2
cvxpy==1.9.2
highspy==1.12.0
immutabledict==4.3.1
Jinja2==3.1.6
joblib==1.6.0
llvmlite==0.49.0
MarkupSafe==3.0.3
mpmath==1.3.0
networkx==3.6.1
numba==0.67.0
numpy==2.5.3
ortools==9.15.6755
osqp==1.1.3
pandas==3.0.5
protobuf==6.33.6
pycparser==3.0
pynauty==2.8.8.1
python-dateutil==2.9.0.post0
python-sat==1.9.dev15
qdldl==0.1.9.post1
scipy==1.18.1
scs==3.3.1
setuptools==84.0.0
six==1.17.0
sparsediffpy==0.3.0
sympy==1.14.0
typing_extensions==4.16.0
```

Notes on what is installed:
- **pynauty 2.8.8.1 is built from source and carries its own nauty 2.8.8**, not the system nauty 2.9.3.
- **numba 0.67.0 has a cp314 wheel** and works (with llvmlite 0.49.0).
- **SCS here is the CPU wheel (3.3.1).** The GPU build is the separate `build/venv-sdp-gpu`, which this setup did not
  touch.
- `pip check` reports `cvxpy 1.9.2 has requirement highspy>=1.14.0, but you have highspy 1.12.0`. That is the
  deliberate pin below, not an accident.

### Functional tests (every package does one computation with a known answer)

The script is standalone; a copy of what was run is reproduced at the end of this file (§6). Result, 2026-09-16:
**19 of 19 checks passed, no import errors**:

| package | test | result |
|---|---|---|
| pynauty | automorphism group of the Petersen graph; orbit count | 120; 1 orbit |
| ortools CP-SAT | max independent set of C5 and of Petersen, `num_workers = 8` | 2 (OPTIMAL); 4 |
| numpy | Petersen spectrum | {3, 1⁵, −2⁴} |
| scipy | sparse `eigsh` top eigenvalue; `linprog` fractional α(C5) | 3; 2.5 |
| sympy | t³ − t − 1 irreducible over F₃; exact √3² | True; 3 |
| networkx | Petersen edges, girth, α via cliques of the complement | 15, 5, 4 |
| python-sat (`pysat`, CaDiCaL 1.5.3) | Petersen 3-colourable / 2-colourable | True / False |
| numba | `@njit` sum of range(10⁶) against pure Python | equal |
| cvxpy + SCS | 2×2 SDP min tr(CX), tr X = 1, X ⪰ 0 (optimum λ_min = 1); Lovász ϑ(C5) = √5 | 1.0; 2.23607 |

And the import-order test after the highspy pin (both orders): CP-SAT α(C5) = 2; cvxpy LP via HiGHS 2.5, MILP via
HiGHS 2, SDP via SCS 1.0.

### Build failure 1 — `LIBRARY_PATH` breaks C links (fixed by unsetting it)

First attempt, `pip install … pynauty …`:

```
checking whether the C compiler works... no
configure: error: in `/tmp/pip-install-…/pynauty_…/src/nauty2_8_8':
configure: error: C compiler cannot create executables
```

Mechanism, reproduced on a one-line C file:

```
/usr/bin/ld: /home/kooshi/.elan/toolchains/leanprover--lean4---v4.32.0/lib/../lib/Scrt1.o: in function `_start':
/build/glibc-2.26/csu/../sysdeps/x86_64/start.S:101:(.text+0x12): undefined reference to `__libc_csu_fini'
```

`scripts/dev-env.sh` puts the Lean toolchain's `lib/` on `LIBRARY_PATH` so Lean's link can find its bundled
`libc++`. That directory also holds a **glibc 2.26 `Scrt1.o`**, and gcc searches `LIBRARY_PATH` for startup files
ahead of the system ones, so every non-Lean C or C++ link on this machine picks up a startup object from a 2017
glibc and fails. The same compile links fine under `env -u LIBRARY_PATH`. Because pip builds every wheel before
installing any, this one failure installed nothing.
**Rule: any non-Lean native build here runs under `env -u LIBRARY_PATH`** (pip source builds, cmake projects,
KaMIS). The KaMIS build below was run that way from the start, so it was never seen failing for this reason.

### Build failure 2 — OR-Tools and highspy ship incompatible `libhighs.so.1` (fixed by pinning highspy 1.12.0)

With cvxpy's default `highspy` 1.15.1:
- **cvxpy imported first, then CP-SAT → OR-Tools cannot be imported at all:**
  ```
  ImportError: …/ortools/.libs/libortools.so.9: undefined symbol: _Z19setLocalOptionValueRK15HighsLogOptions…
  ```
- OR-Tools imported first, then cvxpy → cvxpy prints
  `ImportError('…/highspy/_core…so: undefined symbol: _ZN5Highs13releaseMemoryEv')` and drops its HIGHS backend.

Mechanism: OR-Tools 9.15 bundles **HiGHS 1.12.0** as `ortools/.libs/libhighs.so.1`, while highspy 1.15.1 bundles
its own `libhighs.so.1`. Both have the same SONAME, so the dynamic loader satisfies the second importer's
dependency with whichever copy was loaded first, and the two versions do not share symbols. highspy imported
alone works. **Fix: `highspy==1.12.0`**, the version OR-Tools bundles; both import orders then work (tests above).
Cost: cvxpy 1.9.2 declares `highspy>=1.14.0`. Only LP and MILP through cvxpy's HIGHS interface were tested at
1.12.0. **If a cvxpy HIGHS call ever fails oddly, suspect the pin first**; SCS and Clarabel are unaffected. A later
`pip install` that re-resolves cvxpy's dependencies may quietly upgrade highspy and bring the trap back:
re-check with `pip freeze | grep highspy`.

## 2. KaMIS — `/home/kooshi/source/KaMIS`

A sibling repository, deliberately outside `lean-dir/build/`.

- **Commit `7f3e2579ab8449e7ff4036d36a4305ee32e1088a`** (2026-04-15, "Add Python interface note linking to
  CHSZLabLib"), KaMIS v3.2.
- Submodule `mmwis/extern/KaHIP` at `b6bedee5fdef49108ad8400389497192b6b23f64` (v3.16-13-gb6bedee).
- Binaries in `deploy/`: `redumis`, `online_mis`, `graphchecker`, `sort_adjacencies`, `mmwis`, `struction`,
  `weighted_branch_reduce`, `weighted_local_search`.
- OpenMP 5.2 found. The whole build is compiled with **`-march=native` on the the desktop's processor**, so the binaries may not run
  on the laptop or the server; rebuild there.
- Build log: `/home/kooshi/source/KaMIS/compile-2026-09-16.log` (431 lines, exit 0; 4 compiler warnings, all harmless:
  two deprecated `std::binary_function`, two `const` discards in argtable3; plus CMake's deprecation notice for
  `wmis`'s old `cmake_minimum_required`).

### Rebuild from scratch

```bash
cd /home/kooshi/source
git clone https://github.com/KarlsruheMIS/KaMIS.git
cd KaMIS
git checkout 7f3e2579ab8449e7ff4036d36a4305ee32e1088a
git submodule update --init --recursive
env -u LIBRARY_PATH CMAKE_POLICY_VERSION_MINIMUM=3.5 ./compile_withcmake.sh
```

`CMAKE_POLICY_VERSION_MINIMUM=3.5` is **required** with CMake 4.x: `wmis/CMakeLists.txt` declares
`cmake_minimum_required(VERSION 2.8.9)`. Tested without it (configure only):

```
CMake Error at wmis/CMakeLists.txt:1 (cmake_minimum_required):
  Compatibility with CMake < 3.5 has been removed from CMake.
```

`compile_withcmake.sh` runs `make -j` with one job per logical CPU (32 here). The build finished within a few
minutes (not timed) and is not memory-heavy.

### Petersen test (α = 4)

`/home/kooshi/source/KaMIS/smoke/petersen.graph` (METIS format, 1-indexed, sorted adjacency; `graphchecker`:
"The graph format seems correct."):

| binary | seeds | size found |
|---|---|---|
| `redumis --time_limit=5` | 0, 1, 2 | 4, 4, 4 |
| `online_mis --time_limit=5` | 0 | 4 |

Output format of both: one line per vertex in METIS order, `1` if the vertex is in the set, else `0`.

### What `redumis` does with a time limit — read before budgeting a run

**`redumis` is not an anytime search: it converges once and exits, and `--time_limit` is only a ceiling.** From
`lib/mis/evolutionary/reduction_evolution.cpp` (`perform_evolutionary`): after `reduction_threshold` = 350 rounds of
local search without improvement, it fixes vertices from its best solution, re-kernelizes and recurses, and it
stops when the kernel is empty (`remaining_size == 0`). On UD(F₂₇,2) this takes 22–28 s of a 300 s limit. **To spend
a budget, restart with new seeds** (or raise `--red_thres`; untested). The `Time found:` in its final "Best" block
is the time of that last recombination step, not when the best size was first reached. `online_mis`, by contrast,
runs until `--time_limit`.

`redumis` kernelization (ParFastKer) uses OpenMP; runs here set `OMP_NUM_THREADS=1` to hold them to one core. On
this graph the kernel is the whole graph (`Kernel size: 729`), as expected for a 28-regular vertex-transitive graph.

## 3. The METIS exporter — `tools/fplane_export_metis.py`

Standard library only. Its own field arithmetic, never imported from `tools/fplane_review_verify.py`, so that script
stays an independent check. It refuses a reducible modulus (the verifier does not check this).

```bash
python3 tools/fplane_export_metis.py export --q 27 --modulus 't^3-t-1' --out data/fs54/kamis-smoke/ud-q27.graph \
    --expect-sha b15ae514ce55dddda7e21f8923ae86c678f032421914fc91e138ca0f24e7ff3d
python3 tools/fplane_export_metis.py record --q 27 --modulus 't^3-t-1' --kamis-output <0/1 file> --out <record.json> \
    --tool "<commit + command line>" --seconds S --seed N [--extra KEY=JSON]
python3 tools/fplane_export_metis.py self-test      # GREEN on 2026-09-16: 5 controls, 5 plants
```

Checks on the exported graph, all passing on 2026-09-16:
- edges_sha256 `b15ae514ce55dddda7e21f8923ae86c678f032421914fc91e138ca0f24e7ff3d`, reproduced three ways: the
  exporter's own `--expect-sha`, `tools/fplane_review_verify.py graph --q 27 --modulus t^3-t-1 --expect-sha …`, and
  a hash recomputed by **reading back the written METIS file** (729 rows, 10,206 undirected edges, every row
  sorted);
- KaMIS `graphchecker`: "The graph format seems correct.";
- file sha256 of `ud-q27.graph`: `9628e984eee6d7dbecb0bd586c7b5d474ee8a05d09cc4f38cea290a337e955e4`.

## 4. System packages: GAP and nauty (not part of the ask; checked because FS-54 will likely use them)

- `geng -c 5 -u` → 21 connected graphs on 5 vertices (correct). `dreadnaut` is at `/usr/bin/dreadnaut`.
- GAP 4.16.1: `Size(SymmetricGroup(5))` = 120; `LoadPackage("grape")` = true.
- **GRAPE's `AutGroupGraph` fails out of the box** with `Error, <cmd> must be a file path` at
  `grape/lib/grape.g:64`. Mechanism: GAP reports architecture `x86_64-pc-linux-gnu-default64-kv11`, but the Arch
  `gap-packages` build puts GRAPE's `dreadnaut` symlink under `grape/bin/x86_64-pc-linux-gnu-default64-kv8/`, so
  `DirectoriesPackagePrograms("grape")` never finds it (GRAPE is the only package with a `kv8` directory; 29
  others have `kv11`). **Workaround, no root needed**, after `LoadPackage("grape");`:
  `GRAPE_DREADNAUT_EXE := "/usr/bin/dreadnaut";` → |Aut(Petersen)| = 120 through GRAPE, tested. (It could go in
  `~/.gap/gaprc`; not done, since that is user configuration.)
- **`LoadPackage("digraphs")` fails** ("the kernel module is not compiled"). Mechanism: `digraphs.so` is present for
  `kv11`, but `ldd` shows `libbliss.so => not found` and `libplanarity.so.4 => not found`. Both are optional
  dependencies of `gap-packages`. **Arch packages: `bliss` and `planarity`** (`sudo pacman -S bliss planarity`).
  Caveat: the local pacman *file* database is stale (it lists planarity's library as `.so.2`, while the sync
  database has planarity 5.1.0.0), so whether `planarity` 5.1 provides `libplanarity.so.4` exactly is unconfirmed.
  Check with `ldd /usr/lib/gap/pkg/digraphs/bin/x86_64-pc-linux-gnu-default64-kv11/digraphs.so` after installing.

## 5. The smoke run on UD(F₂₇,2)

Files, all under `data/fs54/kamis-smoke/`:
- `ud-q27.graph`: the METIS export (§3);
- **`alpha-q27-kamis.json`: the record** (size 117, seed 0; `all_runs` lists every run below with its exact command);
- `runs/`: each run's raw 0/1 output (`.out`), console log (`.log`) and wall seconds (`.wall`);
- `runs.done`: the completion marker of the restart script.

One process at a time, `OMP_NUM_THREADS=1`, desktop, 294.0 s of wall time in total. The time limit is in seconds; "first
reached" is when the final size first appeared in the log.

| finder | seed | time limit | wall s | size | first reached, s |
|---|---|---|---|---|---|
| `redumis` | 0 | 300 | 21.9 | 117 | 1.51 |
| `redumis` | 1 | 300 | 24.6 | 117 | 5.41 |
| `redumis` | 2 | 300 | 22.6 | 117 | 3.33 |
| `redumis` | 3 | 300 | 28.1 | 117 | 9.33 |
| `redumis` | 4 | 300 | 22.7 | 117 | 1.43 |
| `redumis` | 5 | 300 | 31.6 | 117 | 11.97 |
| `redumis` | 6 | 300 | 22.3 | 117 | 1.30 |
| `online_mis` | 0 | 120 | 120.0 | 104 | 0.03 |

Each `.out` file was re-read and checked for independence on every edge (0 internal edges in all eight).

**Independent verification of the record** (`python3 tools/fplane_review_verify.py indep --q 27 --modulus t^3-t-1
--json data/fs54/kamis-smoke/alpha-q27-kamis.json --path set --expect-sha b15ae514…7ff3d`), exit 0:

```
q = 27 (F_27 by t^3-t-1): 729 vertices, degree 28, 10206 edges
  edges_sha256 (python tools) b15ae514ce55dddda7e21f8923ae86c678f032421914fc91e138ca0f24e7ff3d
  edges_sha256 (descent-engine) ff23c2bba87f23962f1d63dab92575a60cd54a7f84a2adbd8460fd46dbc1e9da
  independent set of size 117; internal edges 0
  INDEPENDENT — verified from the definition; alpha(729 vertices) >= 117
    a 5-colouring needs alpha >= ceil(729/5) = 146 — short by 29: SOME class of a 5-colouring must be that big, and no set that big is known here — nothing is refuted, the search is simply not there yet
    a 6-colouring needs alpha >= ceil(729/6) = 122 — short by 5: SOME class of a 6-colouring must be that big, and no set that big is known here — nothing is refuted, the search is simply not there yet
    a 7-colouring needs alpha >= ceil(729/7) = 105 — this set is at or above that size
    (the threshold is necessary and never sufficient: the classes must still partition; and a lower
     bound on alpha bounds chi from BELOW nowhere — that needs a certified upper bound on alpha)
```

Negative control, run the same way: the record with one neighbour (vertex 1) of member 10 added → `independent set of
size 118; internal edges 26`, `NOT INDEPENDENT: e.g. [(1, 10), (1, 35), (1, 62)]`, exit 1.

**Observed structure (exploratory, not part of the record's claim).** The seven 117-sets are pairwise distinct and
no two are translates of each other, yet **each is invariant under translation by an additive subgroup H of order
9** (seven different subgroups; none lies in an F₂₇-line; none contains a unit vector). So each set is 13 cosets of
its H. For seed 0's H the quotient Cayley graph (81 cosets, 810 edges, no loops) has α = 13 exactly (CP-SAT,
OPTIMAL in 0.06 s), so **117 is the true maximum over sets periodic under that H**. This agrees with the
parallel exhaustive sweep in `data/fs54/periodic-alpha-q27-dim2.json` (not part of this setup): best periodic α
over all order-9 subspaces = 117. The heuristic, which knows nothing of the group, landed exactly on that
periodic ceiling seven times. Scratch script `quotient.py`, not kept in the repository.

## 6. The functional test script

Run as `.venv/bin/python venv_functional_tests.py` (it exits nonzero if any check fails):

```python
"""Functional tests for the lean-dir venv: each package does one real computation with a known answer.
Every test prints its observed value next to the expected one, and the script exits nonzero if any differs."""
import sys, time

results = []


def check(name, got, want):
    ok = got == want
    results.append(ok)
    print(f"[{'PASS' if ok else 'FAIL'}] {name}: got {got!r}, expected {want!r}")


def petersen_edges():
    outer = [(i, (i + 1) % 5) for i in range(5)]
    spokes = [(i, i + 5) for i in range(5)]
    inner = [(5 + i, 5 + (i + 2) % 5) for i in range(5)]
    return outer + spokes + inner


# pynauty: |Aut(Petersen)| = 120
import pynauty
adj = {v: [] for v in range(10)}
for u, v in petersen_edges():
    adj[u].append(v)
g = pynauty.Graph(10, directed=False, adjacency_dict=adj)
gens, grpsize1, grpsize2, orbits, numorbits = pynauty.autgrp(g)
check("pynauty |Aut(Petersen)|", round(grpsize1 * 10 ** grpsize2), 120)
check("pynauty Petersen orbit count (vertex-transitive)", numorbits, 1)

# ortools CP-SAT: maximum independent set of C5 = 2, with 8 workers
from ortools.sat.python import cp_model
m = cp_model.CpModel()
x = [m.NewBoolVar(f"x{i}") for i in range(5)]
for i in range(5):
    m.AddBoolOr([x[i].Not(), x[(i + 1) % 5].Not()])
m.Maximize(sum(x))
s = cp_model.CpSolver()
s.parameters.num_workers = 8
st = s.Solve(m)
check("CP-SAT status on MIS(C5)", s.StatusName(st), "OPTIMAL")
check("CP-SAT alpha(C5)", int(s.ObjectiveValue()), 2)
# and alpha(Petersen) = 4, a second instance
m2 = cp_model.CpModel()
y = [m2.NewBoolVar(f"y{i}") for i in range(10)]
for u, v in petersen_edges():
    m2.AddBoolOr([y[u].Not(), y[v].Not()])
m2.Maximize(sum(y))
s2 = cp_model.CpSolver()
s2.parameters.num_workers = 8
s2.Solve(m2)
check("CP-SAT alpha(Petersen)", int(s2.ObjectiveValue()), 4)

# numpy: Petersen spectrum {3, 1^5, -2^4}
import numpy as np
A = np.zeros((10, 10))
for u, v in petersen_edges():
    A[u, v] = A[v, u] = 1
ev = sorted(int(round(e)) for e in np.linalg.eigvalsh(A))
check("numpy Petersen spectrum", ev, [-2] * 4 + [1] * 5 + [3])

# scipy: sparse eigenvalue and an LP (the fractional independence LP of C5 is 5/2)
import scipy.sparse, scipy.sparse.linalg, scipy.optimize
lam = scipy.sparse.linalg.eigsh(scipy.sparse.csr_matrix(A), k=1, which="LA")[0][0]
check("scipy.sparse eigsh largest Petersen eigenvalue", int(round(lam)), 3)
c = -np.ones(5)
Aub = np.zeros((5, 5))
for i in range(5):
    Aub[i, i] = Aub[i, (i + 1) % 5] = 1
lp = scipy.optimize.linprog(c, A_ub=Aub, b_ub=np.ones(5), bounds=[(0, 1)] * 5)
check("scipy linprog fractional alpha(C5)", round(-lp.fun, 9), 2.5)

# sympy: exact arithmetic, x^3 - x - 1 irreducible over F_3 (the modulus of F_27)
import sympy
t = sympy.symbols("t")
check("sympy t^3-t-1 irreducible mod 3", sympy.Poly(t**3 - t - 1, t, modulus=3).is_irreducible, True)
check("sympy exact sqrt identity", sympy.nsimplify(sympy.sqrt(3) ** 2), sympy.Integer(3))

# networkx: Petersen is 3-regular, girth 5, alpha by exact clique of complement = 4
import networkx as nx
G = nx.petersen_graph()
check("networkx Petersen edges", G.number_of_edges(), 15)
check("networkx Petersen girth", nx.girth(G), 5)
check("networkx alpha(Petersen) via max clique of complement", max(len(c) for c in nx.find_cliques(nx.complement(G))), 4)

# python-sat: Petersen is 3-colourable and not 2-colourable
from pysat.solvers import Cadical153


def colourable(edges, n, k):
    var = lambda v, c: v * k + c + 1
    with Cadical153() as sol:
        for v in range(n):
            sol.add_clause([var(v, c) for c in range(k)])
        for u, v in edges:
            for c in range(k):
                sol.add_clause([-var(u, c), -var(v, c)])
        return sol.solve()


check("pysat Petersen 3-colourable", colourable(petersen_edges(), 10, 3), True)
check("pysat Petersen 2-colourable", colourable(petersen_edges(), 10, 2), False)

# numba: jit a loop and compare with pure Python
try:
    import numba

    @numba.njit(cache=False)
    def tri(n):
        s = 0
        for i in range(n):
            s += i
        return s

    check("numba njit sum(range(10**6))", int(tri(10 ** 6)), sum(range(10 ** 6)))
except ImportError as e:
    print(f"[SKIP] numba not importable: {e}")

# cvxpy + SCS (CPU): the Lovasz theta of C5 is sqrt(5); and a 2x2 SDP with a known optimum
import cvxpy as cp
X = cp.Variable((2, 2), symmetric=True)
# minimise trace(C X) s.t. trace(X) = 1, X PSD: optimum is lambda_min(C); C = [[2,1],[1,2]] has lambda_min = 1
C = np.array([[2.0, 1.0], [1.0, 2.0]])
prob = cp.Problem(cp.Minimize(cp.trace(C @ X)), [cp.trace(X) == 1, X >> 0])
val = prob.solve(solver=cp.SCS, eps=1e-8)
check("cvxpy+SCS 2x2 SDP lambda_min([[2,1],[1,2]]) (6 d.p.)", round(val, 6), 1.0)
check("cvxpy solver used", prob.solver_stats.solver_name, "SCS")
n5 = 5
B = cp.Variable((n5, n5), symmetric=True)
cons = [B >> 0, cp.trace(B) == 1] + [B[i, (i + 1) % n5] == 0 for i in range(n5)]
theta = cp.Problem(cp.Maximize(cp.sum(B)), cons).solve(solver=cp.SCS, eps=1e-9)
check("cvxpy+SCS Lovasz theta(C5) = sqrt 5 (5 d.p.)", round(theta, 5), round(5 ** 0.5, 5))

print(f"\n{sum(results)} of {len(results)} checks passed")
sys.exit(0 if all(results) else 1)
```

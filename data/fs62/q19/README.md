# FS-62 §2a — the two measurements at `q = 19`, and what they decided

*Run 2026-09-18 on the desktop, at Kooshi's instruction, to test the reading in `CLAUDE.md` G59 that `c = α/q^{3/2}`
is bounded by about 0.92 across the family. The falsifiers were committed to git BEFORE these ran (commit `b2beeef`,
G59 and `plans/STUB-six-is-not-a-value.md` §2a(3)), which is why they could be run ad hoc rather than under a
milestone.*

## The verdict, in one line

**`α(19) ∈ [76, 80]`, so `c(19) ∈ [0.918, 0.966]`, and the deciding threshold 0.933 lies inside.** The reading
survived its cheapest falsifier and was not confirmed.

## What was run

| # | instrument | asked | answered | file |
|---|---|---|---|---|
| 1 | `plane-independent` (Rust, 24 threads, 1 h) | an independent set of **78** | **not found**; best 76, verified | `alpha-q19-target78.json` |
| 2 | `fs54_d4_quad.py solve`, GLV level 3 | an upper bound on `α(19)` | **80.59** (converging; ratio bound is 99.50) | `l3.log`, `l3-q19-solve.json` |
| 3 | KaMIS `weighted_branch_reduce` (exact) | `α(19)` exactly | **failed** — 70 at its limit, no optimality proof | (stdout only) |
| 4 | KaMIS `struction` (exact, `--struction_degree=20`) | `α(19)` exactly | **failed** — 66 | `struction.log`, `struction-q19.set` |

**Run 1 is a null at a budget and never a refusal** (G21), and the record says so in its own words: *"it can exhibit
a set but it cannot bound alpha from above."* 521,874 restarts, 104.4 billion cycles, 24 threads, the full hour,
seeded from the verified 76-set. The instrument's positive control was run first: it attains the true `α(11) = 28`
in 0.05 s.

**Run 2 is the first time the level-3 relaxation has been pointed at 19.** It converges to `80.588…`, i.e.
**`α(19) ≤ 80`**, against 99 from the ratio bound. That is ~6 % above the best known set — against **exact** at
`q = 7` (14.000) and `q = 11` (28.07), and ~20 % loose at 23. **So 19 is where this instrument stops being exact**,
which is worth more to the certificate programme than it was to the question it was run for.

## Why runs 3 and 4 failed, which is a fact about the graphs and not about the solvers

`UD(𝔽₁₉,2)` is 361 vertices, 20-regular, 3,610 edges, 5.6 % density — which *looks* easy for branch-and-reduce.

1. **No reduction can ever fire.** Every rule these solvers own (degree-1, degree-2 folding, domination, twins,
   unconfined) works by finding a vertex that differs from its neighbours. A **vertex-transitive** graph has none.
   Measured directly: branch-and-reduce reported `reduction_time 0.003`, `struction` finished its reduction phase in
   26 ms, both having removed nothing, then fell through to blind branching on 361 undifferentiated vertices.
2. **The pruning bound is destroyed by triangle-freeness, and that is arithmetic.** At `q = 19`, 3 is a non-residue,
   so the graph is triangle-free (G57) and its only cliques are single edges. The clique-cover bound is then at best a
   matching: `n/2 = 180` against a truth `≤ 80`, off by 2.3×, so nothing prunes.
3. **Symmetry multiplies the tree.** `|Aut| ≥ 361 · 40 = 14,440` and no off-the-shelf MIS solver breaks it.

*Untried and the only live class: a symmetry-aware exact method — orbital branching, or Schreier–Sims cuts in a MIP.*

## The backend measurement, which was the real defect found

The level-3 solve was first launched on the **GPU** backend, because that was 10× faster on the FS-50 certificate at
`q = 83`. Measured here on one chunk each, resumed from the same 500-iteration checkpoint:

| backend | s/iteration | |
|---|---:|---|
| `gpu_indirect` | 2.750 | what was launched |
| **`cpu_indirect`** | **0.773** | **3.6× faster**; what it was moved to |
| `qdldl` | — | no chunk in 240 s; the fill-in is hopeless at this shape |
| `cudss` | — | not built in this venv |

Controls: the GPU figure agrees with the 2.52 s/it inferred independently from the first run's checkpoint timestamps,
and the two backends that completed agree on the objective to six figures (81.332703 / 81.332712), so they are
solving the same programme. **`q = 83` level 2 has 43 blocks; `q = 19` level 3 has 182 blocks and a 1.17-million-row
cone — the number did not travel across that gap, and carrying it cost a day's projected runtime.** Logs in `probe/`.

A second defect, found the same way: the solve's progress is written with plain `print`, which Python block-buffers to
a file, so **31 minutes produced an empty log while the job was healthy**. Relaunched under `python3 -u`. A monitor
armed on that log reported nothing for 30 minutes and the silence was indistinguishable from a hang.

## The decision problem in SAT (FS-65 D1), run 2026-09-18 — a characterised negative

Asked at Kooshi's instruction: *is there an independent set of 78?* — one yes/no question, because a
refutation puts `α(19) ≤ 77`, `c(19) ≤ 0.930` under the 0.933 threshold, and the reading survives with a
proof instead of a null. **It did not resolve.** What is worth keeping is *why*, which is measured.

**The instrument is correct and controlled.** `tools/fs65_indep_sat.py` encodes the question with two
symmetry breaks, each argued and verified in code: the origin pinned in (translations act simply
transitively) and the lex-least member of each orbit of the 40 maps fixing the origin. At `q = 11`, where
the value is known exactly and kernel-checked, it reproduces it **from both sides** — `k = 28` SAT with a
verified set in 0.2 s, `k = 29` UNSAT in 22.1 s. `tools/fs65_indep_cube.py` passes the same two-sided
control (18 s / 0.08 s).

**At `q = 19` the positive control returned UNKNOWN, and that was not the alarm it looked like.** Breaking
symmetry keeps one set per orbit of 14,440, so it makes SATISFIABLE instances much harder while making
refutations easier — the solver was hunting a needle the encoding had deliberately shrunk. The soundness
question was then settled **without a solver**: the known 76-set, translated to contain the origin and
mapped to the lex-least member of its orbit, is *accepted* by the encoding. So the encoding admits a
genuine 76-set and no refutation it produced could have been an artifact of the symmetry break.

**Why the route fails, in two measurements.**

| level | cubes | split rate | multiplier `2f` | |
|---|---:|---:|---:|---|
| 1 | 1,024 | 23.3 % | 0.47 | converging |
| 2 | 478 | 49.2 % | 0.98 | on the line |
| 3 | 470 | 62 %+ | **1.25** | **diverging** |

1. **Splitting stops paying.** Difficulty concentrates with depth: level 1 clears the easy space and what
   remains resists division, so by level 3 a split produces more work than it removes and the frontier grows.
2. **And a bigger budget is not the fix.** Three of the 239 level-1 cubes that survived 90 s were re-run at
   **420 s each: 0 of 3 resolved.** So the cap was never the binding constraint — those cubes are hard, not
   marginal, and restarting at a higher cap would have bought nothing for about half an hour of re-work.

**Standing result: undecided.** 1,109 cubes refuted and **no set of 78 found anywhere**, which is weak
evidence in the reading's direction and nothing more — a refutation needs *every* cube. `α(19) ∈ [76, 80]`
and `c(19) ∈ [0.918, 0.966]` are unchanged, with the deciding 0.933 still inside.

The single undivided run is the calibration: **UNKNOWN after a full hour**, holding nothing. The cube run
banked 1,109 durable refutations in the same period, survived a kill and a code change mid-flight, and its
785 top-level cubes are reusable by any future attempt. That durability, not the 28× in cores, is what
parallelising actually bought.

## Files

| file | what it is |
|---|---|
| `alpha-q19-target78.json` | run 1's record, complete and self-describing (rerun line, edge digest, verified set) |
| `seed-76.txt` | the verified 76-set from `data/fplane/alpha-p19.json`, as the search's start |
| `ud-q19.graph` | the plane in METIS format with unit weights; controls in the generator, see below |
| `struction.log`, `struction-q19.set` | run 4 |
| `l3.log` | run 2's chunk trace (live, unbuffered) |
| `probe/*.log` | the four backend timings |

`ud-q19.graph` was built here rather than reused, so it carries its own controls: 361 vertices, every degree exactly
20, 3,610 edges, **the independently verified 76-set is independent in it**, and KaMIS's `graphchecker` accepts the
format. The level-3 checkpoint (`l3-q19.ckpt`, 19.6 MB) is regenerable and is not committed.

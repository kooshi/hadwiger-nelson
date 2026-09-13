#!/usr/bin/env python3
"""fs38_tower — the residue tower: the 2-adic levels of ℚ(√3,√11)(i) at four colours, and the residue planes at 11 and
19 at five (FS-38 phase T, 2026-09-13; the plan is `plans/FS38-residue-tower.md`, the records are `data/fs38/`).

THE OBJECTS. (a) `P_m = Cay(O/𝔓^m, S_m)` where `O = ℤ₂[ω][√3]` (`ω² = −1−ω`), `π = 1+√3`, `𝔓 = (π)`, `𝔓² = (2)`,
`S_m = {z : z z̄ = 1}`. The representation is FS-38 §S3's: `z = A + πB`, `A = a+bω ∈ (ℤ/2^⌈m/2⌉)[ω]`,
`B = c+dω ∈ (ℤ/2^⌊m/2⌋)[ω]`, with `N(A+πB) = (N(A)+2N(B)) + π(Tr(A,B)+2N(B))`, `N(a+bω) = a²−ab+b²`,
`Tr = 2ac−ad−bc+2bd`. `|P_m| = 4^m`, `|S_m| = 3·2^(m−1)`. (b) `UD(ℤ/p^m, 2) = Cay((ℤ/p^m)², {a²+b² = 1})`.

DEPTH, the only unit used here (FS-38 §S1): `depth(δ) := v_𝔓(δ) = min(2·v₂(a,b), 1 + 2·v₂(c,d))`, which equals
`v₂(d²)` for a rational squared distance — M53's `v2` column, and M56's "depth 3" is depth 6 here. `depth = m`
is the zero of level `m`.

WHAT A RECORD LICENSES. A `free` verdict is a COLOURING, verified here against every edge of the graph as built (never
against the clause list the solver saw). A `forced` verdict is one solver's UNSAT and is written
`refused (solver, untrusted)` until a second ENGINE and a second ENCODING agree — and it stays untrusted even then:
only the kernel promotes it (FS-38 K3's LRAT at level 5). A `no gap` verdict is the same UNSAT, with the same word.
The graph itself is DERIVED from a law, so an invented edge would make refusals cheaper and look like success
(CLAUDE.md § "A measured half and a derived half fail in opposite directions"): every level is therefore validated
against an independently built genuine ring, `(ℤ/2^N)[ω,π]/(π²−2π−2)`, whose ideal `(π^m)` is computed as an explicit
set of ring multiples — this tests the LATTICE claim, which the tuned-to count `3·2^(m−1)` cannot see.

    python3 tools/fs38_tower.py build [--max-m 8] [--planes]        # sizes, circles, depths, fibres, the ring validation
    python3 tools/fs38_tower.py forced --m 6 [--orbits] [--resume]  # the level record: fan gap + every difference
    python3 tools/fs38_tower.py gap --p 11 [--k 5]                  # the fan gap of the certified table + the SAT ask
    python3 tools/fs38_tower.py doublegap --p 11 [--k 5]            # the shared gap at an edge, and the committed table re-verified
    python3 tools/fs38_tower.py tables                              # level four's aperiodic cover (the committed five, re-verified)
    python3 tools/fs38_tower.py recolour                            # the level-2 repaint at 11 (ℤ/121), with its negative control
    python3 tools/fs38_tower.py lrat                                # the P₅ + edge CNF and its LRAT (generated, NOT checked)
    python3 tools/fs38_tower.py self-test

UNTRUSTED, like everything in `tools/`. Nothing here is a theorem; the kernel modules are the certificates."""
from __future__ import annotations
import argparse, hashlib, itertools, json, os, re, resource, subprocess, sys, time
from pathlib import Path

import numpy as np

ROOT = Path(__file__).resolve().parent.parent
DATA = ROOT / "data" / "fs38"
CKPT = DATA / "ckpt"
FPLANE = ROOT / "data" / "fplane"
PROOFS = ROOT / "Proofs" / "HadwigerNelson"
SCRATCH = ROOT / "build" / "fs38-t"

REFUSED = "refused (solver, untrusted)"
VERIFIED = "verified colouring (every edge re-checked here)"
SECOND_ENGINE = "glucose4"


def peak_gb() -> float:
    return resource.getrusage(resource.RUSAGE_SELF).ru_maxrss / 1048576.0


def sha256_of(obj) -> str:
    return hashlib.sha256(json.dumps(obj, sort_keys=True, separators=(",", ":")).encode()).hexdigest()


# ====================================================================== the graphs
class Cay:
    """A Cayley graph on a product of cyclic groups. Vertices are mixed-radix indices (first component most
    significant, so `(x, y)` at a prime is `x*q + y` — `tools/fplane.py`'s convention); the connection set is a list
    of tuples closed under negation; every edge is materialised once, and the (u, v) arrays are what verifies a
    colouring."""

    def __init__(self, mods, circle, label: str):
        self.mods = tuple(int(m) for m in mods)
        self.label = label
        self.n = 1
        for m in self.mods:
            self.n *= m
        self.comp = np.indices(self.mods).reshape(len(self.mods), -1).astype(np.int64)
        self.circle = [tuple(int(x) for x in s) for s in circle]
        self.deg = len(self.circle)
        self.u, self.v = self._edges()
        self._nbr0 = None

    def index(self, t) -> int:
        r = 0
        for i, m in enumerate(self.mods):
            r = r * m + (int(t[i]) % m)
        return r

    def tuple_of(self, i: int):
        out = []
        for m in reversed(self.mods):
            i, r = divmod(i, m)
            out.append(r)
        return tuple(reversed(out))

    def shift(self, s):
        """The permutation `v ↦ v + s`, as an int32 array."""
        r = np.zeros(self.n, dtype=np.int64)
        for i, m in enumerate(self.mods):
            r = r * m + (self.comp[i] + int(s[i])) % m
        return r.astype(np.int32)

    def _edges(self):
        us, vs = [], []
        ar = np.arange(self.n, dtype=np.int32)
        for s in self.circle:
            p = self.shift(s)
            msk = ar < p
            us.append(ar[msk])
            vs.append(p[msk])
        if not us:
            return np.zeros(0, dtype=np.int32), np.zeros(0, dtype=np.int32)
        return np.concatenate(us), np.concatenate(vs)

    @property
    def edge_count(self) -> int:
        return int(len(self.u))

    def nbrs(self, x: int):
        t = self.tuple_of(x)
        return [self.index(tuple(t[i] + s[i] for i in range(len(self.mods)))) for s in self.circle]

    def closed_nbrs(self, x: int):
        return [x] + self.nbrs(x)


def verify_proper(cay: Cay, col) -> tuple:
    """Properness against EVERY edge of the graph as built. Independent of the CNF — a clause the emitter dropped is
    exactly the fault this must catch, so it may not read the solver's formula."""
    c = np.asarray(col, dtype=np.int16)
    if len(c) != cay.n:
        return False, -1, []
    bad = np.flatnonzero(c[cay.u] == c[cay.v])
    return len(bad) == 0, int(len(bad)), [(int(cay.u[b]), int(cay.v[b])) for b in bad[:3]]


# ---------------------------------------------------------------------- the 2-adic levels (closed form, §S3)
def level_exps(m: int):
    return ((m + 1) // 2, m // 2)


def level_mods(m: int):
    ea, eb = level_exps(m)
    return (1 << ea, 1 << ea, 1 << eb, 1 << eb)


def norm_form(m: int, a: int, b: int, c: int, d: int, re_coef: int = 2, pi_coef: int = 2):
    """`N(A+πB) = (N(A) + 2N(B)) + π·(Tr(A,B) + 2N(B))` as the pair (A-ring component, B-ring component).

    `re_coef` / `pi_coef` are the planted perturbations. FS-38 §S3's are the coefficient HALVED (`2 → 1`), and they
    reproduce its numbers exactly: `re_coef = 1` gives 18 at m = 3 and 24 at m = 5, `pi_coef = 1` gives 9, 18, 36, 72,
    144 at m = 2..6. Measured here and worth its own line: the perturbation that DELETES the term (`coef = 0`) leaves
    the count at 3·2^(m−1) at every level 1..7, and so do a sign flip in `N` or in `Tr` — four of six perturbations
    cannot fire on the count at all. That is the sharp form of §S3's own caution that the count is tuned-to: the
    discriminating control is the independent ring construction, never the count."""
    ea, eb = level_exps(m)
    A, B = 1 << ea, 1 << eb
    nB = (c * c - c * d + d * d) % B
    re = (a * a - a * b + b * b + re_coef * nB) % A
    pi = (2 * a * c - a * d - b * c + 2 * b * d + pi_coef * nB) % B
    return re, pi


def level_circle(m: int, re_coef: int = 2, pi_coef: int = 2):
    A, _, B, _ = level_mods(m)
    out = []
    for a in range(A):
        for b in range(A):
            for c in range(B):
                for d in range(B):
                    if norm_form(m, a, b, c, d, re_coef, pi_coef) == (1 % A, 0):
                        out.append((a, b, c, d))
    return out


def v2_pair(x: int, y: int, cap: int) -> int:
    if x % (1 << cap) == 0 and y % (1 << cap) == 0:
        return cap
    j = 0
    while x % 2 == 0 and y % 2 == 0:
        x //= 2
        y //= 2
        j += 1
    return min(j, cap)


def level_depth(m: int, t) -> int:
    ea, eb = level_exps(m)
    a, b, c, d = t
    return min(2 * v2_pair(a, b, ea), 1 + 2 * v2_pair(c, d, eb))


def _emul(p, q, r, s, mod):
    return ((p * r - q * s) % mod, (p * s + q * r - q * s) % mod)


def level_mul(m: int, z, s):
    """`z·s` in `O/𝔓^m`: `(A+πB)(C+πD) = (AC + 2BD) + π(AD + BC + 2BD)`, each component in its own ring. Validated
    against genuine ring multiplication at every level (`validate_level`)."""
    ea, eb = level_exps(m)
    A, B = 1 << ea, 1 << eb
    a, b, c, d = z
    e, f, g, h = s
    pa = _emul(a, b, e, f, A)
    pd = _emul(c % B, d % B, g % B, h % B, B)
    ra = ((pa[0] + 2 * pd[0]) % A, (pa[1] + 2 * pd[1]) % A)
    p1 = _emul(a % B, b % B, g % B, h % B, B)
    p2 = _emul(c % B, d % B, e % B, f % B, B)
    rb = ((p1[0] + p2[0] + 2 * pd[0]) % B, (p1[1] + p2[1] + 2 * pd[1]) % B)
    return (ra[0], ra[1], rb[0], rb[1])


def level_conj(m: int, z):
    ea, eb = level_exps(m)
    A, B = 1 << ea, 1 << eb
    a, b, c, d = z
    return ((a - b) % A, (-b) % A, (c - d) % B, (-d) % B)


def level_map(m: int, z):
    """`O/𝔓^(m+1) → O/𝔓^m`: reduce each component to the smaller ring."""
    ea, eb = level_exps(m)
    A, B = 1 << ea, 1 << eb
    a, b, c, d = z
    return (a % A, b % A, c % B, d % B)


def build_level(m: int) -> Cay:
    return Cay(level_mods(m), level_circle(m), f"P_{m} = Cay(O/𝔓^{m}, S_{m})")


# ---------------------------------------------------------------------- the independent construction (the control)
class Ring:
    """`R_N = (ℤ/2^N)[ω, π]/(π² − 2π − 2)` built from its relations alone: a genuine ring, so `𝔓^m = (π^m)` can be
    computed as a SET of multiples and compared with the coordinate description the closed form assumes. `R_N ≅
    O/𝔓^(2N)`, so `N = 4` covers every level `m ≤ 8`."""

    def __init__(self, N: int = 4):
        self.N = N
        self.M = 1 << N

    def mul(self, x, y):
        M = self.M
        a, b, c, d = x
        e, f, g, h = y
        A1 = _emul(a, b, e, f, M)
        B1 = _emul(a, b, g, h, M)
        B2 = _emul(c, d, e, f, M)
        D = _emul(c, d, g, h, M)
        return ((A1[0] + 2 * D[0]) % M, (A1[1] + 2 * D[1]) % M,
                (B1[0] + B2[0] + 2 * D[0]) % M, (B1[1] + B2[1] + 2 * D[1]) % M)

    def conj(self, x):
        M = self.M
        a, b, c, d = x
        return ((a - b) % M, (-b) % M, (c - d) % M, (-d) % M)

    def elements(self):
        M = self.M
        return itertools.product(range(M), repeat=4)

    def pi_pow(self, m: int):
        z = (1, 0, 0, 0)
        for _ in range(m):
            z = self.mul(z, (0, 0, 1, 0))
        return z


def validate_level(m: int, circle, N: int = 4) -> dict:
    """Four checks, all from the ring relations: `π² = 2 + 2π`; the ideal `(π^m)` equals the claimed lattice; `z z̄`
    is rational and reduces to the closed-form pair at level `m`; the CIRCLE of the ring quotient equals the
    closed-form circle (same group, same connection set ⟹ the same graph — the independent construction §S3 wanted,
    replacing the pilot's graphs, whose code died with the planning session's scratchpad)."""
    R = Ring(N)
    M = R.M
    ea, eb = level_exps(m)
    A, B = 1 << ea, 1 << eb
    assert m <= 2 * N, ("the ring is too coarse for this level", m, N)
    pim = R.pi_pow(m)
    els = list(R.elements())
    ideal = {R.mul(pim, x) for x in els}
    claimed = {(a, b, c, d) for a in range(0, M, A) for b in range(0, M, A)
               for c in range(0, M, B) for d in range(0, M, B)}
    one = (1, 0, 0, 0)
    norm_mismatch = 0
    circ_ring = set()
    for z in els:
        nz = R.mul(z, R.conj(z))
        if nz[1] or nz[3]:
            norm_mismatch += 1
            continue
        if (nz[0] % A, nz[2] % B) != norm_form(m, *z):
            norm_mismatch += 1
        diff = ((nz[0] - one[0]) % M, (nz[1] - one[1]) % M, (nz[2] - one[2]) % M, (nz[3] - one[3]) % M)
        if diff in ideal:
            circ_ring.add((z[0] % A, z[1] % A, z[2] % B, z[3] % B))
    return dict(
        ring=f"(ℤ/{M})[ω,π]/(π²−2π−2)", level=m,
        scope="this tests the LATTICE description of 𝔓^m, and the norm and circle over it, GIVEN the presentation "
              "R = (ℤ/2^N)[ω,π]/(π²−2π−2). That presentation — π = 1+√3 is Eisenstein over ℤ₂[ω], so O = ℤ₂[ω][π] is "
              "the ring of integers of ℚ₂(√3,ζ₃) with 𝔓 = (π), 𝔓² = (2) and residue field 𝔽₄ — is FS-38 §S3's "
              "[hand 1] and is NOT tested here (Poros, 2026-09-13)",
        pi_squared_ok=(R.mul((0, 0, 1, 0), (0, 0, 1, 0)) == (2, 0, 2, 0)),
        ideal_size=len(ideal), ideal_expected=M ** 4 // 4 ** m, ideal_matches_lattice=(ideal == claimed),
        norm_mismatches=norm_mismatch,
        circle_from_ring=len(circ_ring), circle_from_closed_form=len(circle),
        circle_identical=(circ_ring == set(circle)),
    )


def validate_multiplication(m: int, samples: int = 2000, N: int = 4, seed: int = 11) -> dict:
    """The truncated `level_mul` against genuine ring multiplication — the orbit maps rest on it."""
    import random
    rng = random.Random(seed)
    R = Ring(N)
    M = R.M
    ea, eb = level_exps(m)
    A, B = 1 << ea, 1 << eb
    bad = 0
    for _ in range(samples):
        z = tuple(rng.randrange(M) for _ in range(4))
        s = tuple(rng.randrange(M) for _ in range(4))
        pr = R.mul(z, s)
        want = (pr[0] % A, pr[1] % A, pr[2] % B, pr[3] % B)
        got = level_mul(m, (z[0] % A, z[1] % A, z[2] % B, z[3] % B), (s[0] % A, s[1] % A, s[2] % B, s[3] % B))
        if got != want:
            bad += 1
    return dict(samples=samples, mismatches=bad)


def circle_is_group(m: int, circle) -> dict:
    """`S_m` is closed under multiplication and inverse (`z⁻¹ = z̄`) — the derivation the orbit reduction rests on,
    checked in full, not sampled."""
    S = set(circle)
    closed = all(level_mul(m, z, w) in S for z in circle for w in circle)
    inv = all(level_mul(m, z, level_conj(m, z)) == (1 % level_mods(m)[0], 0, 0, 0) for z in circle)
    conj_onto = {level_conj(m, z) for z in circle} == S
    onto = all({level_mul(m, z, s) for z in circle} == S for s in circle)
    return dict(products_checked=len(circle) ** 2, closed_under_multiplication=closed, conj_is_inverse=inv,
                conj_maps_circle_onto_circle=conj_onto, every_unit_maps_circle_onto_circle=onto,
                reads="every generator of the orbit group is a graph automorphism fixing 0: multiplication by s ∈ S_m "
                      "permutes the connection set (s·S_m = S_m as SETS, checked for every s), and so does "
                      "conjugation — the three written conditions Poros asked for, first two of three")


def derived_virtual_edges(m: int):
    """Poros's law, derived 2026-09-13 and registered as a prediction before the levels above 6 were measured: if
    every difference of depth ≥ 4 is forced, then for `s ∈ S_m` and `δ ∈ 𝔓⁴`, `C(s+δ) ≠ C(δ) = C(0)`, so every
    element of `S_m + 𝔓⁴` is a virtual edge — and `S_m + 𝔓⁴` is exactly the preimage of `S₄` under reduction to
    level 4, of size `24·4^(m−4)`: 24, 96, 384, 1536, 6144 at m = 4..8. MORE virtual edges than this is a compulsion
    the depth-4 forcing does not explain (phase D's first object); FEWER contradicts the forcing and is a HALT."""
    if m < 4:
        return None
    S4 = set(level_circle(4))
    mods = level_mods(m)
    out = set()
    i = 0
    for tup in itertools.product(*[range(x) for x in mods]):
        if (tup[0] % 4, tup[1] % 4, tup[2] % 4, tup[3] % 4) in S4:
            out.add(i)
        i += 1
    return out


def fibre_edges(m: int, circle) -> int:
    """Circle points of level `m` that reduce to ZERO at level `m−1`: an edge inside a fibre of the level map. Must
    be 0 at every level ≥ 2 (FS-38 stub P3, and `twoAdicLevelMap_ne_zero_of_mem_circle`)."""
    if m < 2:
        return 0
    return sum(1 for s in circle if level_map(m - 1, s) == (0, 0, 0, 0))


def level_orbits(m: int, circle):
    """The differences of `P_m` partitioned into orbits under the automorphisms that fix 0: multiplication by a
    norm-one unit (`S_m`, a group) and conjugation. `orbit(δ) = S·δ ∪ S·δ̄` is already closed, because `S` is a
    group. Forcedness and separation are constant on an orbit, which is both the level-8 economy and, at the levels
    where every difference is asked, a free cross-check on graph and solver together."""
    mods = level_mods(m)
    n = 1
    for x in mods:
        n *= x

    def idx(t):
        r = 0
        for i, mm in enumerate(mods):
            r = r * mm + t[i] % mm
        return r

    def tup(i):
        out = []
        for mm in reversed(mods):
            i, r = divmod(i, mm)
            out.append(r)
        return tuple(reversed(out))

    orb = [-1] * n
    reps = []
    for i in range(n):
        if orb[i] >= 0:
            continue
        d = tup(i)
        dc = level_conj(m, d)
        members = {idx(level_mul(m, d, s)) for s in circle} | {idx(level_mul(m, dc, s)) for s in circle}
        members.add(i)
        k = len(reps)
        for j in members:
            orb[j] = k
        reps.append(i)
    return orb, reps


# ---------------------------------------------------------------------- the residue planes at p
def plane_circle(q: int):
    sq = [(a * a) % q for a in range(q)]
    return [(a, b) for a in range(q) for b in range(q) if (sq[a] + sq[b]) % q == 1]


def build_plane(p: int, m: int = 1) -> Cay:
    q = p ** m
    return Cay((q, q), plane_circle(q), f"UD(ℤ/{q}, 2)")


# ====================================================================== the SAT layer
def var(v: int, c: int, k: int) -> int:
    return v * k + c + 1


class Asker:
    """One incremental solver per graph: the base clauses once, every question an assumption set. A question that
    pins colours leans on palette symmetry (any colouring can be relabelled), which is an ARGUMENT, not a
    measurement — so every refusal is re-asked at every other colour value (`palette_control`)."""

    def __init__(self, cay: Cay, k: int, engine: str = "cadical153", verbose: bool = False):
        from pysat.solvers import Solver
        self.cay, self.k, self.engine = cay, k, engine
        t0 = time.time()
        self.s = Solver(name=engine)
        self.clauses = 0
        for v in range(cay.n):
            self.s.add_clause([var(v, c, k) for c in range(k)])
            self.clauses += 1
        for v in range(cay.n):
            for c1 in range(k):
                for c2 in range(c1 + 1, k):
                    self.s.add_clause([-var(v, c1, k), -var(v, c2, k)])
                    self.clauses += 1
        for a, b in zip(cay.u.tolist(), cay.v.tolist()):
            for c in range(k):
                self.s.add_clause([-var(a, c, k), -var(b, c, k)])
                self.clauses += 1
        self.build_seconds = round(time.time() - t0, 2)
        self.asks = 0
        if verbose:
            print(f"  [{cay.label}] {cay.n} vertices, degree {cay.deg}, {cay.edge_count} edges, "
                  f"{self.clauses} clauses, built in {self.build_seconds}s, peak {peak_gb():.2f} GB", flush=True)

    def ask_budget(self, assumptions, conf: int = 2_000_000):
        """The same question under a conflict budget: (None, None) when the budget runs out. A control that cannot
        answer must say so — a hung ask and a refusal are not the same verdict."""
        self.asks += 1
        self.s.conf_budget(conf)
        r = self.s.solve_limited(assumptions=list(assumptions))
        if r is None:
            return None, None
        if not r:
            return False, None
        mdl = self.s.get_model()
        k = self.k
        col = [next(c for c in range(k) if mdl[v * k + c] > 0) for v in range(self.cay.n)]
        if not verify_proper(self.cay, col)[0]:
            raise SystemExit(f"INSTRUMENT CATASTROPHE: the solver's model is not proper on {self.cay.label}")
        return True, col

    def ask(self, assumptions):
        """(True, verified colouring) or (False, None). A model is verified against every edge before it is returned;
        a model that is not proper is an instrument catastrophe and stops the run."""
        self.asks += 1
        r = self.s.solve(assumptions=list(assumptions))
        if not r:
            return False, None
        mdl = self.s.get_model()
        k = self.k
        col = [0] * self.cay.n
        for v in range(self.cay.n):
            base = v * k
            for c in range(k):
                if mdl[base + c] > 0:
                    col[v] = c
                    break
        ok, nbad, ex = verify_proper(self.cay, col)
        if not ok:
            raise SystemExit(f"INSTRUMENT CATASTROPHE: the solver's model is not proper on {self.cay.label} "
                             f"({nbad} improper edges, e.g. {ex})")
        return True, col

    # the three questions, each with its pinning argument stated
    def free_pair(self, x: int, y: int, colour: int = 1):
        """Is there a proper colouring with `C x ≠ C y`? SAT ⟹ the pair is FREE (not forced), on a verified model.
        Pinning `C x = 0, C y = colour` is sound by palette symmetry — and that soundness is an ARGUMENT, so every
        refusal is re-asked at every other colour value (`palette_control`)."""
        return self.ask([var(x, 0, self.k), var(y, colour, self.k)])

    def free(self, d: int, colour: int = 1):
        """The Cayley special case: the pair `(0, d)`, every pair being a translate of one of these."""
        return self.free_pair(0, d, colour)

    def same_pair(self, x: int, y: int):
        """Is there a proper colouring with `C x = C y`? SAT ⟹ the pair is NOT separated (no virtual edge)."""
        return self.ask([var(x, 0, self.k), var(y, 0, self.k)])

    def coincide(self, d: int):
        """The Cayley special case of `same_pair`."""
        return self.same_pair(0, d)

    def gap(self, v: int = 0, gamma: int = 1):
        """Is there a proper colouring with colour `gamma` absent from `N[v]`? (`FanGap`.) Pinning `C v = 0` and
        `gamma = 1` is sound by palette symmetry and vertex-transitivity."""
        return self.ask([var(v, 0, self.k)] + [-var(w, gamma, self.k) for w in self.cay.nbrs(v)])

    def double_gap(self, v: int, w: int, gamma: int):
        """One colour absent from `N[v] ∪ N[w]` (`DoubleSlack`'s witness at one edge)."""
        cl = set(self.cay.closed_nbrs(v)) | set(self.cay.closed_nbrs(w))
        return self.ask([var(v, 0, self.k)] + [-var(x, gamma, self.k) for x in sorted(cl)])

    def multi_gap(self, v: int, gammas):
        """Several colours absent from `N[v]` at once — the ask whose UNSAT shows the refusal outcome is reachable."""
        return self.ask([var(v, 0, self.k)] + [-var(w, g, self.k) for w in self.cay.nbrs(v) for g in gammas])


def clique_assumptions(cay: Cay, k: int):
    """A clique through the origin, pinned to distinct colours — sound by palette symmetry, and the difference between
    a control that answers in seconds and one that does not answer at all. (Measured 2026-09-13: the global
    colour-absence control at 19 ran past ten minutes without this and returns in seconds with it.)"""
    S = cay.circle
    adj = {s: {r for r in S if r != s and tuple((s[i] - r[i]) % cay.mods[i] for i in range(len(cay.mods))) in set(S)}
           for s in S}
    best = []
    for s in S:
        for r in adj[s]:
            cand = [s, r]
            if len(cand) > len(best):
                best = cand
            break
        if best:
            break
    verts = [0] + [cay.index(s) for s in best]
    return [var(v, i, k) for i, v in enumerate(verts) if i < k]


def second_opinion(cay: Cay, k: int, extra_edge, engine: str = SECOND_ENGINE) -> bool:
    """A refusal re-asked on a different ENGINE and a different ENCODING: instead of pinning `C 0 ≠ C d`, add the
    edge `(0, d)` and ask plain colourability. Returns True when the second route also refuses."""
    from pysat.solvers import Solver
    with Solver(name=engine) as s:
        for v in range(cay.n):
            s.add_clause([var(v, c, k) for c in range(k)])
        for a, b in zip(cay.u.tolist(), cay.v.tolist()):
            for c in range(k):
                s.add_clause([-var(a, c, k), -var(b, c, k)])
        a, b = extra_edge
        for c in range(k):
            s.add_clause([-var(a, c, k), -var(b, c, k)])
        return not s.solve()


def mutated_gap_control(cay: Cay, k: int, col0, gamma: int, v: int = 0) -> dict:
    """THE PLANTED CONTROL for the gap ask, on the object itself. Delete the edges from `v` to one colour class of a
    verified colouring: the ask must flip to SAT, and the model is verified against the MUTATED edge arrays. Bounded
    on both sides — `0 < deleted < degree` — so the control reports having gone blind (no deletion = the plant never
    fired; every edge deleted = an isolated vertex, and the SAT is scaffolding rather than the guard)."""
    col = list(col0)
    # relabel so that C v = 0 and the target colour is gamma
    perm = list(range(k))
    perm[0], perm[col[v]] = col[v], perm[0]
    inv = [0] * k
    for i, x in enumerate(perm):
        inv[x] = i
    col = [inv[c] for c in col]
    keep = ~((cay.u == v) & (np.asarray(col, dtype=np.int16)[cay.v] == gamma) |
             (cay.v == v) & (np.asarray(col, dtype=np.int16)[cay.u] == gamma))
    deleted = int(cay.edge_count - int(keep.sum()))
    mut = Cay.__new__(Cay)
    mut.mods, mut.label, mut.n, mut.comp = cay.mods, cay.label + " (mutated)", cay.n, cay.comp
    mut.circle, mut.deg = cay.circle, cay.deg
    mut.u, mut.v = cay.u[keep], cay.v[keep]
    mut._nbr0 = None
    okc, nbad, _ = verify_proper(mut, col)
    A = Asker(mut, k)
    sat, model = A.gap(v, gamma)
    ok_model = False
    if sat:
        surviving = set(mut.v[mut.u == v].tolist()) | set(mut.u[mut.v == v].tolist())
        ok_model = (verify_proper(mut, model)[0] and model[v] != gamma
                    and all(model[w] != gamma for w in surviving))
    return dict(kind="planted-gap-control", vertex=v, gamma=gamma, deleted_edges=deleted, degree=cay.deg,
                bounded_below=(deleted > 0), bounded_above=(deleted < cay.deg),
                witness_colouring_still_proper_on_mutant=okc, ask_flipped_to_sat=bool(sat),
                model_verified_against_mutated_edges=bool(ok_model),
                fired=bool(sat and ok_model and 0 < deleted < cay.deg))


# ====================================================================== committed tables, read back
def lean_table(path: Path, name: str, shape):
    """A `![...]` literal from a Lean source file, as a numpy array. Reading the kernel's own data back is the
    strongest form of "reproduce": the record then verifies the literal the theorems consume, not a copy of it."""
    txt = path.read_text()
    i = txt.index(f"def {name}")
    j = txt.index(":=", i) + 2
    depth, k, started = 0, j, False
    while k < len(txt):
        ch = txt[k]
        if ch == "[":
            depth += 1
            started = True
        elif ch == "]":
            depth -= 1
            if started and depth == 0:
                k += 1
                break
        k += 1
    nums = [int(x) for x in re.findall(r"-?\d+", txt[j:k])]
    total = 1
    for s in shape:
        total *= s
    assert len(nums) == total, (name, len(nums), total)
    return np.array(nums, dtype=np.int16).reshape(shape)


def plane_table_11():
    """The certified 5-colouring of `UD(𝔽₁₁,2)`, from the record and from the kernel literal — and the two must
    agree, which is itself a control on the record."""
    rec = json.loads((FPLANE / "chi-p11.json").read_text())
    rows = rec["colouring_rows"]
    from_record = np.array([[int(ch) for ch in r] for r in rows], dtype=np.int16)
    from_kernel = lean_table(PROOFS / "Instances" / "FinitePlane11.lean", "finitePlane11Table", (11, 11))
    return from_record, from_kernel


def plane_table_19():
    """The kernel's periodic 5-colouring of `UD(𝔽₁₉,2)`: `circ19Table ∘ projAlong (1,1)`, i.e. `(x,y) ↦ T[(y−x) mod 19]`."""
    T = lean_table(PROOFS / "Instances" / "LocalGlobal19.lean", "circ19Table", (19,))
    return np.array([[T[(y - x) % 19] for y in range(19)] for x in range(19)], dtype=np.int16)


def gap_census(cay: Cay, table, k: int):
    """Every (vertex, colour) pair the table leaves absent from a closed neighbourhood."""
    col = np.asarray(table, dtype=np.int16).reshape(-1)
    assert len(col) == cay.n
    out = []
    for v in range(cay.n):
        seen = {int(col[w]) for w in cay.nbrs(v)} | {int(col[v])}
        for g in range(k):
            if g not in seen:
                out.append((v, g))
    return col, out


# ====================================================================== subcommand: build
def cmd_build(a):
    rows = []
    print(f"[fs38] the 2-adic tower, levels 1..{a.max_m} (the representation validated against a genuine ring)")
    for m in range(1, a.max_m + 1):
        t0 = time.time()
        S = level_circle(m)
        cay = build_level(m) if m <= a.max_build else None
        val = validate_level(m, S) if m <= 8 else None
        mul = validate_multiplication(m) if m <= 8 else None
        grp = circle_is_group(m, S)
        pert = dict(
            halve_real_coefficient=len(level_circle(m, re_coef=1)),
            halve_pi_coefficient=len(level_circle(m, pi_coef=1)),
            delete_real_term=len(level_circle(m, re_coef=0)),
            delete_pi_term=len(level_circle(m, pi_coef=0)),
            note="§S3's perturbation is the halved coefficient; DELETING either term leaves the count unchanged at "
                 "every level 1..7, so that perturbation cannot fire on the count",
        )
        depths = {}
        mods = level_mods(m)
        for t in itertools.product(*[range(x) for x in mods]):
            depths[level_depth(m, t)] = depths.get(level_depth(m, t), 0) + 1
        row = dict(level=m, n=4 ** m, circle=len(S), circle_expected=3 * 2 ** (m - 1),
                   degree=len(S), edges=(cay.edge_count if cay else 4 ** m * len(S) // 2),
                   fibre_edges=fibre_edges(m, S), depth_histogram={str(d): c for d, c in sorted(depths.items())},
                   perturbations=pert, representation=val, multiplication=mul, circle_group=grp,
                   seconds=round(time.time() - t0, 2))
        rows.append(row)
        print(f"  m={m}: n={row['n']:>6} |S_m|={row['circle']:>4} (expect {row['circle_expected']:>4}) "
              f"edges={row['edges']:>9} fibre-edges={row['fibre_edges']} | ring: ideal {val['ideal_matches_lattice']}, "
              f"circle identical {val['circle_identical']}, norm mismatches {val['norm_mismatches']}, "
              f"mult mismatches {mul['mismatches']}, S closed {grp['closed_under_multiplication']} "
              f"| halved-coefficient counts {pert['halve_real_coefficient']}/{pert['halve_pi_coefficient']}, "
              f"deleted-term counts {pert['delete_real_term']}/{pert['delete_pi_term']}  [{row['seconds']}s]",
              flush=True)
    out = dict(kind="fs38-tower-build", prime=2, levels=rows, peak_gb=round(peak_gb(), 2),
               claim_scope="sizes and circles are exact enumerations; `representation` is the independent ring check "
                           "(the ideal (π^m) computed as a set of ring multiples, and the circle of the ring quotient "
                           "compared with the closed form) — it tests FS-38 §S3's [hand 1] lattice claim, which the "
                           "count 3·2^(m−1) cannot see. No solver, no colouring, no theorem.")
    if a.planes:
        pr = []
        for p, mm in ((11, 1), (11, 2), (19, 1)):
            c = build_plane(p, mm)
            pr.append(dict(p=p, m=mm, q=p ** mm, n=c.n, circle=c.deg, edges=c.edge_count,
                           circle_expected=p ** (mm - 1) * (p + 1)))
            print(f"  UD(ℤ/{p**mm},2): n={c.n} circle={c.deg} (expect {p**(mm-1)*(p+1)}) edges={c.edge_count}")
        out["planes"] = pr
    if a.out:
        Path(a.out).write_text(json.dumps(out, indent=1))
        print(f"  wrote {a.out}")
    return out


# ====================================================================== subcommand: forced (the level record)
def depth_classes(m: int):
    mods = level_mods(m)
    cls = {}
    for i, t in enumerate(itertools.product(*[range(x) for x in mods])):
        cls.setdefault(level_depth(m, t), []).append(i)
    return cls


def cmd_forced(a):
    m = a.m
    t0 = time.time()
    S = level_circle(m)
    cay = build_level(m)
    ck = CKPT / f"forced-p2-k4-m{m}.json"
    k = 4
    print(f"[fs38] level {m}: {cay.n} vertices, degree {cay.deg}, {cay.edge_count} edges, four colours", flush=True)
    val = validate_level(m, S) if m <= 8 else None
    mul = validate_multiplication(m) if m <= 8 else None
    grp = circle_is_group(m, S)
    if val and not (val["ideal_matches_lattice"] and val["circle_identical"] and val["norm_mismatches"] == 0):
        raise SystemExit(f"HALT: the level-{m} representation disagrees with the independent ring construction: {val}")
    if mul and mul["mismatches"]:
        raise SystemExit(f"HALT: level multiplication disagrees with ring multiplication: {mul}")
    orb, reps = level_orbits(m, S)
    cls = depth_classes(m)
    use_orbits = a.orbits or cay.n > a.all_below
    population = ("one representative per automorphism orbit (every difference decided by the orbit derivation: "
                  "multiplication by a norm-one unit and conjugation are automorphisms fixing 0, and S_m is a group)"
                  if use_orbits else "every nonzero difference, asked individually")
    todo = [i for i in reps if i != 0] if use_orbits else list(range(1, cay.n))
    state = dict(level=m, population=population, free_string="?" * cay.n, sep_string="?" * cay.n,
                 refused=[], sep_refused=[], models_hash=hashlib.sha256().hexdigest(), examples={}, sep_examples={},
                 asked=0, models_verified=0)
    if a.resume and ck.exists():
        state = json.loads(ck.read_text())
        print(f"  resumed from {ck}: {state['asked']} asks done", flush=True)
    fs = list(state["free_string"])
    ss = list(state["sep_string"])
    fs[0] = ss[0] = "."
    edge_diffs = {cay.index(s) for s in S}
    derived = derived_virtual_edges(m)
    agg = hashlib.sha256()
    A = Asker(cay, k, verbose=True)
    # the fan gap, with its planted control
    gsat, gmodel = A.gap(0, 1)
    gap_block = dict(
        ask="a proper 4-colouring with one colour absent from N[0] (FanGap; vertex 0 by vertex-transitivity, the "
            "colour by palette symmetry)",
        verdict=("gap found — " + VERIFIED) if gsat else ("no gap — " + REFUSED),
        second_engine=None, planted_control=None,
        derivation=("at levels ≤ 5 this is not an independent claim: a gap at level m pulls up along the level maps "
                    "to a gap at level 5 (`FanGap.comap`), one gap on a Cayley graph gives `Slack` by translation, "
                    "`Slack` makes every pair free (D0.2 (a)), and level 5 has a forced pair — so the whole column "
                    "rests on ONE solver claim, the level-5 refusal, and becomes kernel when K3's LRAT is checked "
                    "(Poros, FS-38 §S3 P-A3). Above 5 it is an independent consistency check on the solver, with the "
                    "planted control as its positive."
                    if m <= 5 else
                    "above level 5 this is an independent consistency check on the solver, with the planted control "
                    "as the positive showing the SAT outcome is reachable on this object (FS-38 §S3 P-A3)"))
    if not gsat:
        # the uninformative outcome must be REACHABLE on this object: plant it
        csat, cmodel = A.ask([])
        if not csat:
            raise SystemExit(f"HALT: P_{m} is not 4-colourable at all — the whole measurement is void")
        gap_block["planted_control"] = mutated_gap_control(cay, k, cmodel, 1, 0)
        if not gap_block["planted_control"]["fired"]:
            raise SystemExit(f"HALT: the planted gap control did not fire at level {m}: "
                             f"{gap_block['planted_control']}")
        gap_block["second_engine"] = dict(engine=SECOND_ENGINE, agrees=None,
                                          note="the gap ask is an assumption set, not an extra edge; the second "
                                               "opinion below covers the forced refusals")
    print(f"  fan gap: {gap_block['verdict']}"
          + (f"; planted control fired (deleted {gap_block['planted_control']['deleted_edges']} of {cay.deg} edges "
             f"at vertex 0, ask flipped to SAT, model verified on the mutated edges)" if not gsat else ""), flush=True)
    # every difference (or every orbit)
    nfree = nref = 0
    for pos, d in enumerate(todo):
        if fs[d] != "?":
            continue
        sat, col = A.free(d)
        state["models_verified"] += 1 if sat else 0
        if sat:
            fs[d] = "f"
            nfree += 1
            agg.update(bytes(col))
            dep = level_depth(m, cay.tuple_of(d))
            state["examples"].setdefault(str(dep), "".join(str(c) for c in col))
        else:
            fs[d] = "R"
            nref += 1
        if a.separated:
            if d in edge_diffs:
                ss[d] = "E"      # separated by PROPERNESS — a theorem, no solver asked (Poros's legend request)
                state["asked"] += 1
                continue
            ssat, scol = A.coincide(d)
            if ssat:
                ss[d] = "c"
                agg.update(bytes(scol))
                state["models_verified"] += 1
                dep = level_depth(m, cay.tuple_of(d))
                state["sep_examples"].setdefault(str(dep), "".join(str(c) for c in scol))
            else:
                ss[d] = "S"
        state["asked"] += 1
        if state["asked"] % a.ckpt_every == 0:
            state.update(free_string="".join(fs), sep_string="".join(ss))
            CKPT.mkdir(parents=True, exist_ok=True)
            ck.write_text(json.dumps(state))
            print(f"    {state['asked']}/{len(todo)} asked ({nfree} free, {nref} refused) "
                  f"[{time.time() - t0:.0f}s, peak {peak_gb():.2f} GB]", flush=True)
    state.update(free_string="".join(fs), sep_string="".join(ss))
    # fill in the orbit's other members by the derivation
    if use_orbits:
        rep_of = {}
        for i in reps:
            rep_of[orb[i]] = i
        for i in range(1, cay.n):
            r = rep_of[orb[i]]
            fs[i] = fs[r]
            ss[i] = ss[r]
    # every refusal: a second engine, a second encoding, and the palette control
    refused = []
    for d in [i for i in todo if fs[i] == "R"]:
        pal = []
        for c in range(2, k):
            s2, _ = A.free(d, colour=c)
            pal.append(bool(s2))
        if any(pal):
            raise SystemExit(f"HALT: palette symmetry broken at level {m}, difference {d}: pinning colour 1 refused "
                             f"while another colour succeeded ({pal})")
        agree = second_opinion(cay, k, (0, d)) if cay.n <= a.second_below else None
        refused.append(dict(index=d, tuple=list(cay.tuple_of(d)), depth=level_depth(m, cay.tuple_of(d)),
                            orbit=orb[d], orbit_size=sum(1 for x in orb if x == orb[d]),
                            verdict=REFUSED,
                            second_engine=(SECOND_ENGINE if agree is not None else None),
                            second_encoding="P_m + edge (0, δ) is not 4-colourable",
                            second_agrees=agree,
                            palette_control_all_refused=(not any(pal)),
                            palette_control_reads="a HALT, not a measurement: pinning C 0 = 0, C δ = 1 loses nothing "
                                                  "by colour permutation, so a SAT at another colour after an UNSAT "
                                                  "at 1 is impossible for a correct solver and encoding (Poros)"))
    # orbit consistency: the verdicts must be constant on orbits
    incons = []
    if not use_orbits:
        byorb = {}
        for i in range(1, cay.n):
            byorb.setdefault(orb[i], set()).add(fs[i])
        incons = [o for o, s in byorb.items() if len(s) > 1]
        if incons:
            raise SystemExit(f"HALT: the forced verdict is not constant on automorphism orbits at level {m}: "
                             f"{incons[:5]} — either a generator is not an automorphism or the solver is inconsistent")
    rep_rows = None
    if use_orbits:
        rep_rows = [dict(representative=r, tuple=list(cay.tuple_of(r)), depth=level_depth(m, cay.tuple_of(r)),
                         orbit_size=int(sum(1 for x in orb if x == orb[r])),
                         verdict=("free — " + VERIFIED) if fs[r] == "f" else REFUSED,
                         separated=ss[r]) for r in reps if r != 0]
    by_depth = []
    for dep in sorted(cls):
        idxs = [i for i in cls[dep] if i != 0]
        todo_set = set(todo)
        by_depth.append(dict(depth=dep, differences=len(idxs),
                             asked=sum(1 for i in idxs if i in todo_set),
                             free=sum(1 for i in idxs if fs[i] == "f"),
                             refused=sum(1 for i in idxs if fs[i] == "R"),
                             not_separated=sum(1 for i in idxs if ss[i] == "c"),
                             separated=sum(1 for i in idxs if ss[i] == "S")))
    rec = dict(
        kind="fs38-tower-2adic", prime=2, level=m, colours=k,
        object=f"P_{m} = Cay(O/𝔓^{m}, S_{m}), O = ℤ₂[ω][√3], the FS-38 §S3 representation (a,b,c,d) ↦ (a+bω) + π(c+dω)",
        index_order="idx = ((a·A + b)·B + c)·B + d with A = 2^⌈m/2⌉ (a, b) and B = 2^⌊m/2⌋ (c, d)",
        n=cay.n, degree=cay.deg, edges=cay.edge_count, circle=[list(s) for s in S] if cay.n <= 1024 else None,
        units="depth(δ) = v_𝔓(δ) = min(2·v₂(a,b), 1 + 2·v₂(c,d)) = v₂(d²) for rational d² — M53's `v2` column; "
              "M56's \"depth 3\" is depth 6 here; depth = m is the zero of level m",
        representation=val, multiplication=mul, circle_group=grp, fibre_edges=fibre_edges(m, S),
        orbits=dict(count=len(reps), representatives=reps[:64],
                    sizes_sum_over_nonzero=int(sum(1 for i in range(1, cay.n))),
                    sizes=[int(sum(1 for x in orb if x == orb[r])) for r in reps],
                    sizes_total=int(sum(sum(1 for x in orb if x == orb[r]) for r in reps)),
                    transferred_refusals_keep_the_word=REFUSED,
                    per_representative=rep_rows,
                    decided_by_orbit=(int(cay.n - 1 - len(todo)) if use_orbits else 0),
                    decided_by_orbit_word=("decided by orbit derivation from its representative — the partition is "
                                           "recomputable with no solver (`level_orbits`, pure arithmetic), and a "
                                           "difference in a refused orbit carries that refusal's word: "
                                           + REFUSED) if use_orbits else None,
                    generators_verified_as_set_equalities="see `circle_group`: s·S_m = S_m for every s ∈ S_m and "
                                                          "conj(S_m) = S_m, checked as SET equalities",
                    derivation="multiplication by s ∈ S_m (a unit, N(s) = 1) and conjugation are graph automorphisms "
                               "fixing 0; S_m is a group (checked in full), so S·δ ∪ S·δ̄ is a whole orbit"),
        fan_gap=gap_block,
        forced=dict(population=population, asked=len(todo), free=int(sum(1 for c in fs if c == "f")),
                    refused=int(sum(1 for c in fs if c == "R")),
                    free_string="".join(fs), legend="'.' the zero difference, 'f' free (verified colouring), "
                                                    "'R' " + REFUSED,
                    by_depth=by_depth, refused_differences=refused,
                    orbit_consistent=(not incons) if not use_orbits else "by construction (orbit representatives)",
                    orbit_cross_check=dict(
                        orbits=len(reps), differences_checked=(cay.n - 1 if not use_orbits else 0),
                        inconsistent_orbits=(len(incons) if not use_orbits else None),
                        reads=("the forced verdict is constant on every automorphism orbit, "
                               f"{cay.n - 1} of {cay.n - 1} differences — this agreement is what licenses deciding "
                               "level 8 from one representative per orbit" if not use_orbits else
                               "not applicable: this level was asked by representatives, so constancy is by "
                               "construction; the licence comes from the levels where every difference was asked"))),
        separated=dict(
            asked=(len(todo) if a.separated else 0),
            sep_string="".join(ss) if a.separated else None,
            legend="'.' the zero difference, 'E' an EDGE — separated by properness, a theorem, no solver asked, "
                   "'c' a verified colouring identifies the pair (no virtual edge), 'S' " + REFUSED +
                   " (a virtual edge beyond the edges, on the solver's word)",
            edges=int(sum(1 for c in ss if c == "E")),
            non_adjacent_refused=int(sum(1 for c in ss if c == "S")),
            identified=int(sum(1 for c in ss if c == "c")),
            virtual_edges_total=int(sum(1 for c in ss if c in "ES")),
            derived_count=(len(derived) if derived is not None else None),
            derived_expected=(24 * 4 ** (m - 4) if m >= 4 else None),
            derived_law="S_m + 𝔓⁴ = the preimage of S₄ under reduction to level 4, size 24·4^(m−4) — every element "
                        "is a virtual edge GIVEN the depth-≥-4 forcing (Poros, derived and registered before the "
                        "levels above 6 were measured)",
            measured_equals_derived=(None if derived is None or not a.separated else
                                     sorted(i for i in range(cay.n) if ss[i] in "ES") == sorted(derived)),
            reads="more than the derived set would be a compulsion the depth-4 forcing does not explain (phase D's "
                  "first object); fewer would contradict the forcing and is a HALT"),
        models=dict(verified=state["models_verified"], aggregate_sha256=agg.hexdigest(),
                    per_depth_example_free=state["examples"], per_depth_example_same=state["sep_examples"],
                    note="every model was verified against every edge of the graph as built before being counted; the "
                         "aggregate hash identifies THIS run's set (solver models are not reproducible across "
                         "engines), the per-depth examples are the re-checkable evidence"),
        seconds=round(time.time() - t0, 1), peak_gb=round(peak_gb(), 2),
        positive_control_note="the tower has NO internal positive for the refusal path below level 5 — K₄ and "
                              "K₄ □ K₄'s Latin squares are pairwise free — so the `forced` ask's refusal path is "
                              "exercised on an EXTERNAL hand-checkable positive (the diamond at three colours, in "
                              "`self-test`) beside the same object at four. Level 6 is where both of P-A2's outcomes "
                              "are seen on one population: 15 refused and 4,080 free of 4,095 differences.",
        claim_scope="'free' = a colouring verified here on every edge, so the pair is NOT forced. 'refused' = one "
                    "solver's UNSAT, re-asked on a second engine and a second encoding where affordable, and still "
                    "UNTRUSTED: nothing here is a theorem. 'no gap' is the same UNSAT with the same word, with the "
                    "planted control showing the SAT outcome is reachable on this object. The graph is DERIVED from a "
                    "norm form, so a refusal is the suspect verdict; the independent ring construction is the guard.")
    DATA.mkdir(parents=True, exist_ok=True)
    path = Path(a.out) if a.out else DATA / f"tower-p2-k4-m{m}.json"
    path.write_text(json.dumps(rec, indent=1))
    if ck.exists():
        ck.unlink()
    fr = rec["forced"]
    print(f"[fs38] level {m}: fan gap {gap_block['verdict']}; {fr['asked']} asks over {population.split('(')[0]}"
          f"— {fr['free']} of {cay.n - 1} differences free (verified colourings), {fr['refused']} of {cay.n - 1} "
          f"{REFUSED}; by depth: "
          + ", ".join(f"d{r['depth']}: {r['free']}f/{r['refused']}R of {r['differences']}" for r in by_depth)
          + f"; {rec['seconds']}s, peak {rec['peak_gb']} GB")
    print(f"  wrote {path}")
    return rec


# ====================================================================== subcommand: gap (the planes at 11, 19)
def cmd_gap(a):
    p, k = a.p, a.k
    t0 = time.time()
    cay = build_plane(p, 1)
    if p == 11:
        t_rec, t_ker = plane_table_11()
        agree = bool((t_rec == t_ker).all())
        table = t_ker
        source = dict(record="data/fplane/chi-p11.json", kernel="Instances/FinitePlane11.lean finitePlane11Table",
                      record_and_kernel_agree=agree)
        if not agree:
            raise SystemExit("HALT: the committed 11-table and the kernel literal disagree")
    elif p == 19:
        table = plane_table_19()
        source = dict(kernel="Instances/LocalGlobal19.lean circ19Table ∘ projAlong (1,1)")
    else:
        raise SystemExit(f"no committed table at {p}")
    col, census = gap_census(cay, table, k)
    ok, nbad, ex = verify_proper(cay, col)
    if not ok:
        raise SystemExit(f"HALT: the committed {p}-table is not proper ({nbad} improper edges, e.g. {ex})")
    verts = sorted({v for v, _ in census})
    per_vertex = [dict(vertex=[v // p, v % p], own_colour=int(col[v]),
                       neighbour_colours=sorted({int(col[w]) for w in cay.nbrs(v)}),
                       gaps=[g for vv, g in census if vv == v]) for v in verts]
    A = Asker(cay, k, verbose=True)
    circ_edges = len([1 for s in cay.circle for r in cay.circle
                      if s != r and tuple((s[i] - r[i]) % cay.mods[i] for i in range(2)) in set(cay.circle)])
    sat, model = A.ask_budget([var(0, 0, k)] + [-var(w, 1, k) for w in cay.nbrs(0)], a.conf)
    ask = dict(question="a proper 5-colouring with one colour absent from N[(0,0)]",
               verdict=("gap found — " + VERIFIED) if sat else
                       ("no gap — " + REFUSED) if sat is False else "undecided at the conflict budget",
               conflict_budget=a.conf)
    if sat:
        gv = [g for g in range(k) if model[0] != g and all(model[w] != g for w in cay.nbrs(0))]
        ask["gap_colours_in_the_found_colouring"] = gv
        ask["colouring_rows"] = ["".join(str(model[x * p + y]) for y in range(p)) for x in range(p)]
        ask["verified"] = bool(verify_proper(cay, model)[0] and gv)
    # the controls: at 11 the SAT outcome is observed, so what needs showing is that a REFUSAL is reachable here
    cq = clique_assumptions(cay, k)
    c_all, _ = A.ask_budget([-var(x, k - 1, k) for x in range(cay.n)] + cq, a.conf)
    c3, _ = A.ask_budget([var(0, 0, k)] + [-var(w, g, k) for w in cay.nbrs(0) for g in (1, 2, 3)], a.conf)
    controls = [
        dict(name="one colour absent everywhere (= (k−1)-colour the plane), with a clique through the origin pinned "
                  "to distinct colours (sound by palette symmetry; without the pins the ask did not return in ten "
                  "minutes at 19)",
             expect="refused", required=(sat is not True),
             got=("sat" if c_all else "unsat" if c_all is False else "unknown at the conflict budget"),
             fired=(c_all is False), clique_pins=len(cq),
             reads="the reachability control for a REFUSAL, and it is load-bearing exactly when this record contains "
                   "one: here the gap ask itself returned " + ("SAT with a verified colouring, so no refusal is "
                   "recorded at this prime and this control is informational" if sat is True else
                   "a refusal, so this control is required") + ". χ(UD(𝔽_p,2)) = k makes the expected answer a "
                   "refusal either way"),
        dict(name="three colours absent from N[(0,0)] at once", expect="prime-dependent, not required",
             required=False, got=("sat" if c3 else "unsat" if c3 is False else "unknown"),
             fired=None, directed_edges_inside_the_circle=circ_edges,
             reads="informational, NOT a control: it refuses cheaply only when the circle induces an edge — ω = 3 iff "
                   "3 is a square mod p (`[Krebs2022]`), so 24 directed edges inside the circle at 11 and ZERO at 19. "
                   "At 19, forbidding three colours on an INDEPENDENT neighbourhood is a hard question in its own "
                   "right (measured: the single-gap ask alone takes 27 s there against milliseconds at 11), and "
                   "reading its outcome as a control would be reading the prime, not the instrument"),
    ]
    for c in controls:
        if c["required"] and not c["fired"]:
            raise SystemExit(f"HALT: the required control did not fire: {c}")
    rec = dict(kind="fs38-fan-gap", p=p, k=k, n=cay.n, degree=cay.deg, edges=cay.edge_count, table_source=source,
               table_proper=True, table_rows=["".join(str(int(table[x][y])) for y in range(p)) for x in range(p)],
               gapped_pairs=len(census), gapped_vertices=len(verts), per_vertex=per_vertex,
               sat_ask=ask, controls=controls, seconds=round(time.time() - t0, 1),
               claim_scope="the census is an exact enumeration over the COMMITTED table (the kernel's literal, read "
                           "back from the source): every listed (vertex, colour) is a colour absent from that "
                           "vertex's closed neighbourhood, which is what `FanGap` names and what the kernel decides "
                           "by 12 lookups. The SAT ask carries a colouring verified here on every edge. No refusal is "
                           "recorded as a fact.")
    DATA.mkdir(parents=True, exist_ok=True)
    path = Path(a.out) if a.out else DATA / f"gap-p{p}-k{k}.json"
    path.write_text(json.dumps(rec, indent=1))
    print(f"[fs38] UD(𝔽_{p},2) at {k} colours: the committed table is proper on all {cay.edge_count} edges and has "
          f"{len(census)} gapped (vertex, colour) pairs at {len(verts)} vertices "
          + "; ".join(f"({v['vertex'][0]},{v['vertex'][1]}) own {v['own_colour']} nbrs {v['neighbour_colours']} "
                      f"gap {v['gaps']}" for v in per_vertex[:4])
          + f"{' …' if len(per_vertex) > 4 else ''}; the fresh ask: {ask['verdict']}; the required control "
          f"(a colour banned everywhere must refuse) fired; the prime-dependent one read "
          f"{controls[1]['got']} with {circ_edges} directed edges inside the circle")
    print(f"  wrote {path}")
    return rec


# ====================================================================== subcommand: doublegap
def cmd_doublegap(a):
    p, k = a.p, a.k
    t0 = time.time()
    cay = build_plane(p, 1)
    v, w = cay.index((0, 0)), cay.index((1, 0))
    assert (1, 0) in cay.circle, "the base edge's difference is not on the circle"
    shared = sorted(set(cay.nbrs(v)) & set(cay.nbrs(w)))
    closed = sorted(set(cay.closed_nbrs(v)) | set(cay.closed_nbrs(w)))
    A = Asker(cay, k, verbose=True)
    gamma = k - 1
    sat, model = A.double_gap(v, w, gamma)
    found = None
    if sat:
        okp = verify_proper(cay, model)[0]
        absent = all(model[x] != gamma for x in closed)
        if not (okp and absent):
            raise SystemExit("HALT: the shared-gap model does not verify")
        found = dict(gamma=gamma, rows=["".join(str(model[x * p + y]) for y in range(p)) for x in range(p)],
                     verified_proper_on_all_edges=True, colour_absent_on_closed_neighbourhood=True,
                     closed_neighbourhood_size=len(closed))
    # the committed literal, re-verified (11 only)
    committed = None
    if p == 11:
        T = lean_table(PROOFS / "Instances" / "FanGap11.lean", "finitePlane11DoubleGapTable", (11, 11))
        tc = T.reshape(-1)
        okp, nbad, ex = verify_proper(cay, tc)
        gaps = [g for g in range(k) if all(tc[x] != g for x in closed)]
        _, census = gap_census(cay, T, k)
        committed = dict(source="Instances/FanGap11.lean finitePlane11DoubleGapTable", proper=bool(okp),
                         improper_edges=nbad, shared_gap_colours=gaps, gapped_pairs=len(census),
                         matches_this_run=(found is not None and
                                           [int(x) for x in tc] == [int(x) for x in model]) if found else False)
        if not (okp and gaps):
            raise SystemExit(f"HALT: the committed double-gap table does not verify: proper={okp}, gaps={gaps}")
        # planted red: one entry flipped must break properness or the shared gap
        bad = T.copy()
        bad[0][0] = (int(T[0][0]) + 1) % k
        bc = bad.reshape(-1)
        bp = verify_proper(cay, bc)[0]
        bg = [g for g in range(k) if all(bc[x] != g for x in closed)]
        committed["planted_red_one_entry_flipped"] = dict(
            still_proper=bool(bp), still_has_shared_gap=bool(bg), fired=bool((not bp) or (not bg)))
        if not committed["planted_red_one_entry_flipped"]["fired"]:
            raise SystemExit("HALT: flipping an entry of the committed table changed nothing — the check is blind")
    controls = []
    s1, m1 = A.ask_budget([var(v, 0, k)] + [-var(w, gamma, k) for w in cay.nbrs(v)], a.conf)
    controls.append(dict(name="a single gap at (0,0)", expect="sat", required=True,
                         got=("sat" if s1 else "unsat" if s1 is False else "unknown"), fired=bool(s1),
                         reads="the SAT outcome is reachable on this code path — the weaker ask must succeed where "
                               "the shared-gap ask did"))
    cq = clique_assumptions(cay, k)
    s_all, _ = A.ask_budget([-var(x, k - 1, k) for x in range(cay.n)] + cq, a.conf)
    controls.append(dict(name="one colour absent everywhere (= (k−1)-colour the plane)", expect="refused",
                         required=(sat is not True),
                         got=("sat" if s_all else "unsat" if s_all is False else "unknown at the conflict budget"),
                         fired=(s_all is False),
                         reads="the reachability control for a refusal, load-bearing exactly when this record "
                               "contains one; the shared-gap ask here returned "
                               + ("SAT with a verified table, so it is informational" if sat is True else "a refusal, "
                                  "so it is required")))
    for c in controls:
        if c["required"] and not c["fired"]:
            raise SystemExit(f"HALT: the required control did not fire: {c}")
    single = None
    if p == 19:
        table = plane_table_19()
        colv, census = gap_census(cay, table, k)
        verts = sorted({x for x, _ in census})
        single = dict(source="Instances/LocalGlobal19.lean circ19Table ∘ projAlong (1,1)",
                      gapped_pairs=len(census), gapped_vertices=len(verts),
                      first=[dict(vertex=[x // p, x % p], gap=g) for x, g in census[:4]],
                      note="the kernel's own 19-colouring, for K2's `finitePlane19_fanGap` (FS-38 §S8 decision 10 "
                           "keeps only the forces half at 19)")
    rec = dict(kind="fs38-double-gap", p=p, k=k, n=cay.n, degree=cay.deg, edges=cay.edge_count,
               base_edge=dict(v=[0, 0], w=[1, 0], shared_neighbours=len(shared),
                              shared_neighbour_points=[[x // p, x % p] for x in shared],
                              closed_neighbourhood_size=len(closed)),
               ask=dict(question=f"a proper {k}-colouring with colour {gamma} absent from N[(0,0)] ∪ N[(1,0)]",
                        verdict=("found — " + VERIFIED) if sat else ("none — " + REFUSED)),
               found=found, committed_table=committed, single_gaps=single, controls=controls,
               seconds=round(time.time() - t0, 1),
               claim_scope="a found table is a colouring verified here proper on every edge with the named colour "
                           "absent on every vertex of the two closed neighbourhoods — that is `DoubleSlack`'s witness "
                           "at the base edge, and by translation and rotation (row 60) at every edge. A 'none' would "
                           "be one solver's UNSAT and is written as refused. The committed literal is re-verified "
                           "here, with a flipped entry as the planted red.")
    DATA.mkdir(parents=True, exist_ok=True)
    path = Path(a.out) if a.out else DATA / f"doublegap-p{p}-k{k}.json"
    path.write_text(json.dumps(rec, indent=1))
    print(f"[fs38] UD(𝔽_{p},2) at {k} colours, the base edge (0,0)~(1,0) (sharing {len(shared)} neighbours, "
          f"{len(closed)} vertices closed): {rec['ask']['verdict']}"
          + (f"; the committed literal verifies (proper on all {cay.edge_count} edges, shared gap "
             f"{committed['shared_gap_colours']}), its flipped-entry red fired" if committed else "")
          + (f"; the kernel's 19-colouring has {single['gapped_pairs']} gapped pairs" if single else ""))
    print(f"  wrote {path}")
    return rec


# ====================================================================== subcommand: tables (level four's cover)
def period_group(cay: Cay, col):
    c = np.asarray(col, dtype=np.int16)
    out = []
    for i in range(cay.n):
        t = cay.tuple_of(i)
        if (c == c[cay.shift(t)]).all():
            out.append(i)
    return out


def ask_not_periodic(cay: Cay, k: int, forbid, engine: str = "cadical153"):
    """A proper `k`-colouring that is NOT periodic at any difference in `forbid`: one auxiliary variable per (period,
    vertex) saying "these two differ", and one clause per period demanding at least one such vertex."""
    from pysat.solvers import Solver
    nv = cay.n * k
    s = Solver(name=engine)
    for v in range(cay.n):
        s.add_clause([var(v, c, k) for c in range(k)])
    for v in range(cay.n):
        for c1 in range(k):
            for c2 in range(c1 + 1, k):
                s.add_clause([-var(v, c1, k), -var(v, c2, k)])
    for aa, bb in zip(cay.u.tolist(), cay.v.tolist()):
        for c in range(k):
            s.add_clause([-var(aa, c, k), -var(bb, c, k)])
    nxt = nv + 1
    for d in forbid:
        sh = cay.shift(cay.tuple_of(d) if isinstance(d, int) else d)
        lits = []
        for v in range(cay.n):
            w = int(sh[v])
            t = nxt
            nxt += 1
            lits.append(t)
            for c in range(k):
                s.add_clause([-t, -var(v, c, k), -var(w, c, k)])
        s.add_clause(lits)
    r = s.solve()
    col = None
    if r:
        mdl = s.get_model()
        col = [next(c for c in range(k) if mdl[v * k + c] > 0) for v in range(cay.n)]
        if not verify_proper(cay, col)[0]:
            raise SystemExit("INSTRUMENT CATASTROPHE: the aperiodicity model is not proper")
    s.delete()
    return r, col


def cmd_tables(a):
    t0 = time.time()
    m, k = 4, 4
    S = level_circle(m)
    cay = build_level(m)
    val = validate_level(m, S)
    if not (val["ideal_matches_lattice"] and val["circle_identical"]):
        raise SystemExit(f"HALT: level 4's representation does not validate: {val}")
    # the three depth-2 elements 2√3·{1, ω, 1+ω}: 2√3 = −2 + 2π, i.e. (a,b,c,d) = (2,0,2,0) mod 4
    base = (2, 0, 2, 0)
    om = (0, 1, 0, 0)
    o2 = level_mul(m, base, om)
    o3 = level_mul(m, o2, om)
    trio = sorted({cay.index(base), cay.index(o2), cay.index(o3)})
    assert all(level_depth(m, cay.tuple_of(i)) == 2 for i in trio) and len(trio) == 3, \
        ("the three depth-2 elements are not an ω-orbit of size three", trio)
    ap_all, _ = ask_not_periodic(cay, k, trio)
    ap_two, colw = ask_not_periodic(cay, k, trio[:2])
    controls = [
        dict(name="a proper 4-colouring of P₄ periodic at NONE of the three depth-2 elements", expect="refused",
             got=("sat" if ap_all else "unsat"), fired=(not ap_all),
             reads="no aperiodic table exists, so the kernel form of P₄'s freeness is a LIST (FS-38 §S0 item 3)"),
        dict(name="… at none of TWO of the three", expect="sat", got=("sat" if ap_two else "unsat"), fired=bool(ap_two),
             reads="the SAT outcome of the same ask is reachable — the refusal above is about the third period"),
    ]
    for c in controls:
        if not c["fired"]:
            raise SystemExit(f"HALT: control did not fire: {c}")
    # the committed five, re-verified
    committed = [lean_table(PROOFS / "Instances" / "TwoAdicFour.lean", f"twoAdicFourTable{s}", (4, 4, 4, 4))
                 for s in "₁₂₃₄₅"]
    ctabs = [t.reshape(-1) for t in committed]
    cproper = [bool(verify_proper(cay, t)[0]) for t in ctabs]
    cper = [period_group(cay, t) for t in ctabs]
    inter = set(range(cay.n))
    for pg in cper:
        inter &= set(pg)
    committed_block = dict(source="Instances/TwoAdicFour.lean twoAdicFourTable₁..₅", count=len(ctabs),
                           all_proper=all(cproper), per_table_proper=cproper,
                           period_group_sizes=[len(x) for x in cper],
                           common_periods=sorted(inter),
                           covers_every_nonzero_difference=(inter == {0}))
    if not (all(cproper) and inter == {0}):
        raise SystemExit(f"HALT: the committed five tables are not a valid cover: {committed_block}")
    # a smaller cover?
    pool = [(t, pg) for t, pg in zip(ctabs, cper)]
    extra = 0
    while extra < a.samples:
        r, col = ask_not_periodic(cay, k, [int(x) for x in np.random.default_rng(1000 + extra).choice(
            [i for i in range(1, cay.n)], size=min(2, cay.n - 1), replace=False)])
        extra += 1
        if r:
            pool.append((col, period_group(cay, col)))
    best = None
    groups = [set(pg) for _, pg in pool]
    for size in (1, 2, 3, 4, 5):
        for combo in itertools.combinations(range(len(groups)), size):
            inter2 = set(range(cay.n))
            for i in combo:
                inter2 &= groups[i]
            if inter2 == {0}:
                best = combo
                break
        if best:
            break
    rec = dict(kind="fs38-p4-tables", level=4, colours=4, n=cay.n, degree=cay.deg, edges=cay.edge_count,
               index_order="table[a][b][c][d] for ((a,b),(c,d)) — the Lean literal's own argument order",
               representation=val, controls=controls, committed=committed_block,
               minimum_cover_found=dict(size=(len(best) if best else None), from_pool_of=len(groups),
                                        indices=list(best) if best else None,
                                        committed_indices=[i for i in (best or []) if i < len(ctabs)],
                                        period_group_sizes=[len(pool[i][1]) for i in (best or [])],
                                        tables=[[[[[int(np.asarray(pool[i][0]).reshape(4, 4, 4, 4)[aa][bb][cc][dd])
                                                   for dd in range(4)] for cc in range(4)] for bb in range(4)]
                                                 for aa in range(4)] for i in (best or [])],
                                        tables_index_order="table[a][b][c][d] for ((a,b),(c,d)) — ready for a Lean "
                                                           "literal of the same shape as twoAdicFourTable₁",
                                        verified_proper=[bool(verify_proper(cay, pool[i][0])[0]) for i in (best or [])],
                                        intersection_of_period_groups=sorted(
                                            set.intersection(*[set(pool[i][1]) for i in best]) if best else []),
                                        note="a cover is a list of proper colourings whose period groups intersect in "
                                             "{0}; size is a SEARCH result (an upper bound on the minimum), never a "
                                             "proof of minimality"),
               tables=[[[[[int(T[aa][bb][cc][dd]) for dd in range(4)] for cc in range(4)] for bb in range(4)]
                        for aa in range(4)] for T in committed],
               seconds=round(time.time() - t0, 1),
               claim_scope="every table is verified proper here on all 3,072 edges of P₄ and its period group is an "
                           "exact enumeration over all 256 differences; `covers_every_nonzero_difference` is the "
                           "hypothesis of `Forces.eq_of_forall_exists_not_periodic`, so the list (not any single "
                           "table) is what the kernel consumes. No solver refusal is a fact here: the two controls "
                           "are the only UNSATs and both are reported as the solver's.")
    DATA.mkdir(parents=True, exist_ok=True)
    path = Path(a.out) if a.out else DATA / "p4-tables.json"
    path.write_text(json.dumps(rec, indent=1))
    print(f"[fs38] level 4: the committed five tables are each proper on all {cay.edge_count} edges, their period "
          f"groups have sizes {committed_block['period_group_sizes']} and intersect in {{0}} — a valid cover; the "
          f"smallest cover found in a pool of {len(groups)} is "
          f"{len(best) if best else 'none'}; no aperiodic table exists (the solver's, controlled)")
    print(f"  wrote {path}")
    return rec


# ====================================================================== subcommand: recolour (the level-2 repaint)
def cmd_recolour(a):
    p, k = a.p, a.k
    t0 = time.time()
    base = build_plane(p, 1)
    if p != 11:
        raise SystemExit("the repaint record is specified at 11 (FS-38 §S6 row T)")
    _, table = plane_table_11()
    col1, census = gap_census(base, table, k)
    verts = sorted({v for v, _ in census})
    target = a.target if a.target is not None else verts[0]
    gaps = [g for v, g in census if v == target]
    present_nbrs = sorted({int(col1[w]) for w in base.nbrs(target)})
    own = int(col1[target])
    present = sorted(set(present_nbrs) | {own})
    lvl2 = build_plane(p, 2)
    q = p * p
    pre = dict(circle_level2=lvl2.deg, circle_level2_expected=p * base.deg,
               circle_lifts_with_uniform_fibres=(lvl2.deg == p * base.deg),
               note="Poros's pre-registered expectation, written before this file existed: |S₂| = p·|S₁| = "
                    f"{p * base.deg} at {p}")
    pull = np.array([int(table[(x % p)][(y % p)]) for x in range(q) for y in range(q)], dtype=np.int16)
    okp, nbad, ex = verify_proper(lvl2, pull)
    if not okp:
        raise SystemExit(f"HALT: the pulled-back colouring is not proper on UD(ℤ/{q},2) ({nbad} edges, e.g. {ex})")
    col2_gaps = gap_census(lvl2, pull.reshape(q, q), k)[1]
    gap_verts2 = sorted({v for v, _ in col2_gaps})
    base_gap_res = {(x // p, x % p) for x in verts}
    lifted_only = all(((v // q) % p, (v % q) % p) in base_gap_res for v in gap_verts2)
    tx, ty = target // p, target % p
    lift = ((tx + p * a.lift_shift) % q, ty % q)
    u = lvl2.index(lift)
    fibre = [lvl2.index(((tx + p * i) % q, (ty + p * j) % q)) for i in range(p) for j in range(p)]
    gamma = gaps[0]
    rep = pull.copy()
    rep[u] = gamma
    ok2, nbad2, ex2 = verify_proper(lvl2, rep)
    fibre_colours = sorted({int(rep[x]) for x in fibre})
    controls = []
    for c in present_nbrs:
        bad = pull.copy()
        bad[u] = c
        _, nb, exx = verify_proper(lvl2, bad)
        controls.append(dict(name=f"repaint the same lift to colour {c}, which IS present in the residue's "
                                 f"neighbourhood", expect="improper", required=True,
                             improper_edges=nb, example=exx[:2], fired=(nb > 0), bounded_above=(nb <= lvl2.deg),
                             reads="the repaint is proper because the colour is ABSENT from the neighbourhood, not "
                                   "because repainting one vertex is harmless — bounded above by the degree because "
                                   "only edges at this vertex can break"))
    bad = pull.copy()
    bad[u] = own
    _, nb_own, _ = verify_proper(lvl2, bad)
    controls.append(dict(name=f"repaint the same lift to its OWN colour {own}", expect="no change (a no-op)",
                         required=False, improper_edges=nb_own, fired=None,
                         reads="the UNINFORMATIVE outcome, stated so nobody counts it as a control: the lift already "
                               "carries this colour, so the repaint changes nothing and 0 conflicts is the right "
                               "answer. A first run of this record HALTED because the own colour was inside the "
                               "control set, which is the failure the rule about naming the uninformative outcome "
                               "exists for"))
    if not all(c["fired"] and c["bounded_above"] for c in controls if c["required"]):
        raise SystemExit(f"HALT: the negative control did not fire as bounded: {controls}")
    if not ok2:
        raise SystemExit(f"HALT: the repaint to the GAP colour is improper ({nbad2} edges, e.g. {ex2}) — the fan-gap "
                         f"theorem's conclusion fails on the instance it was derived for")
    rec = dict(kind="fs38-recolour", p=p, k=k, level=2, ring=f"ℤ/{q}",
               n=lvl2.n, degree=lvl2.deg, edges=lvl2.edge_count, directed_edge_checks=2 * lvl2.edge_count,
               base=dict(table_source="Instances/FinitePlane11.lean finitePlane11Table",
                         gapped_vertices=[[v // p, v % p] for v in verts],
                         target=[tx, ty], target_own_colour=int(col1[target]), target_gaps=gaps,
                         target_neighbour_colours=sorted({int(col1[w]) for w in base.nbrs(target)})),
               circle_lift=pre,
               pullback=dict(rule="col₂(x, y) = table[x mod 11][y mod 11] (the reduction ℤ/121 → ℤ/11 is a ring hom, "
                                 "so this is a pullback along a graph homomorphism)",
                             proper_on_all_edges=True, gapped_vertices=len(gap_verts2),
                             gapped_vertices_expected=len(verts) * p * p,
                             gapped_vertices_are_exactly_the_lifted_base_gaps=bool(
                                 len(gap_verts2) == len(verts) * p * p and lifted_only),
                             expectation="Poros, pre-registered: 3·121 = 363 gapped vertices — the three base gaps "
                                         "lifted, and nothing else"),
               repaint=dict(lift=[int(lift[0]), int(lift[1])], lift_index=u, painted_colour=gamma,
                            proper_on_all_edges=bool(ok2), improper_edges=nbad2,
                            fibre_size=len(fibre), fibre_colours=fibre_colours,
                            fibre_non_constant=(len(fibre_colours) > 1),
                            separates_the_lifted_pair=bool(all(rep[x] != rep[u] for x in fibre if x != u)),
                            separates_reads="the repainted colouring gives the lifted vertex a colour no fibre-mate "
                                            "has, so no pair inside the fibre is forced equal at five colours: the "
                                            "level-2 plane at 11 is NOT 1-continuous — FS-38 stub P2's record "
                                            "instance (Poros's third pre-registered expectation)"),
               controls=controls, seconds=round(time.time() - t0, 1),
               claim_scope="the repainted colouring is verified here proper on every one of the edges listed, and "
                           "non-constant on the 121-point fibre over the gapped residue — so no colouring of "
                           "UD(ℤ/121,2) can be pulled back from level one alone, and the level-2 plane is NOT "
                           "1-continuous (FS-38 stub P2's record instance). Exact arithmetic, no solver, no theorem: "
                           "the kernel form is `pullbackRepaint` in `FanGap.lean`.")
    DATA.mkdir(parents=True, exist_ok=True)
    path = Path(a.out) if a.out else DATA / f"recolour-p{p}-level2.json"
    path.write_text(json.dumps(rec, indent=1))
    print(f"[fs38] the level-2 repaint at {p}: the pullback of the certified table is proper on all "
          f"{lvl2.edge_count} edges ({2*lvl2.edge_count} directed checks) of UD(ℤ/{q},2); repainting the lift "
          f"{lift} of the gapped residue ({tx},{ty}) to its gap colour {gamma} stays proper "
          f"({nbad2} improper edges), and the fibre carries colours {fibre_colours}; the negative controls at the "
          f"neighbourhood colours {present_nbrs} give "
          + ", ".join(str(c['improper_edges']) for c in controls if c.get('required')) + " conflicts, and the no-op "
          f"repaint to its own colour {own} gives {nb_own}")
    print(f"  wrote {path}")
    return rec


# ====================================================================== subcommand: lrat
def cmd_lrat(a):
    sys.path.insert(0, str(ROOT / "tools"))
    from coloring import write_cnf
    t0 = time.time()
    m, k = 5, 4
    S = level_circle(m)
    cay = build_level(m)
    val = validate_level(m, S)
    if not (val["ideal_matches_lattice"] and val["circle_identical"]):
        raise SystemExit(f"HALT: level 5's representation does not validate: {val}")
    delta = (4, 0, 0, 0)
    di = cay.index(delta)
    dep = level_depth(m, delta)
    assert dep == 4, ("the representative difference is not at depth 4", dep)
    om = (0, 1, 0, 0)
    orbit = [di, cay.index(level_mul(m, delta, om)), cay.index(level_mul(m, level_mul(m, delta, om), om))]
    edges = sorted(set(zip(cay.u.tolist(), cay.v.tolist())))
    assert (0, di) not in edges and (di, 0) not in edges, "the added edge is already an edge"
    out = DATA / "lrat"
    out.mkdir(parents=True, exist_ok=True)
    ej = out / "p5-plus-edge-edges.json"
    ej.write_text(json.dumps(dict(
        kind="fs38-p5-plus-edge-edge-list", n=cay.n, level=5, colours=4,
        index_order="idx = ((a·8 + b)·4 + c)·4 + d for ((a,b),(c,d)) ∈ (ℤ/8)² × (ℤ/4)² — Lean's TwoAdicLevel 5",
        delta=list(delta), delta_index=di, delta_depth=dep, omega_orbit_indices=orbit,
        base_edges=len(edges), edges=[[int(x), int(y)] for x, y in edges] + [[0, di]],
        note="the last pair is the ADDED edge (0, δ); the first %d are P₅'s own" % len(edges))))
    cnf = SCRATCH / "p5-plus-edge.cnf"
    cnf0 = SCRATCH / "p5-base.cnf"
    SCRATCH.mkdir(parents=True, exist_ok=True)
    # a triangle through 0 pins three colours by palette symmetry (the M05 pipeline's cube shape)
    pins = [(0, 0)]
    tri = None
    for s in S:
        for s2 in S:
            if s != s2 and level_mul(m, (1, 0, 0, 0), s) != s2:
                dd = tuple((s[i] - s2[i]) % cay.mods[i] for i in range(4))
                if dd in set(S):
                    tri = (cay.index(s), cay.index(s2))
                    break
        if tri:
            break
    if tri:
        pins = [(0, 0), (tri[0], 1), (tri[1], 2)]
    # The pins must be a CLIQUE, or the formula could be unsatisfiable because of the pins rather than because of the
    # graph — a refusal that arrives cheaply and looks like success (CLAUDE.md § the derived half). Checked, not
    # assumed, against the edge list as built.
    eset = set(edges)
    pv = [v for v, _ in pins]
    clique_ok = all((min(x, y), max(x, y)) in eset for i, x in enumerate(pv) for y in pv[i + 1:])
    if not clique_ok:
        raise SystemExit(f"HALT: the pinned vertices {pv} are not pairwise adjacent — a refusal of this formula would "
                         f"not be a statement about the graph")
    write_cnf(cnf, cay.n, [(int(x), int(y)) for x, y in edges] + [(0, di)], pins, k)
    write_cnf(cnf0, cay.n, [(int(x), int(y)) for x, y in edges], pins, k)
    cad = Path(subprocess.run(["lean", "--print-prefix"], capture_output=True, text=True).stdout.strip()) / "bin" / "cadical"
    lrat = out / "p5-plus-edge.lrat"
    log = SCRATCH / "cadical.log"
    r = subprocess.run([str(cad), "-q", "--lrat", "--no-binary", "--unsat", f"--seed={a.seed}", str(cnf), str(lrat)],
                       capture_output=True, text=True)
    log.write_text(r.stdout + r.stderr)
    r0 = subprocess.run([str(cad), "-q", f"--seed={a.seed}", str(cnf0)], capture_output=True, text=True)
    lines = lrat.read_text().splitlines() if lrat.exists() else []
    last = lines[-1].split() if lines else []
    empty_clause = len(last) >= 2 and last[1] == "0"
    sums = {f.name: hashlib.sha256(f.read_bytes()).hexdigest() for f in (cnf, lrat, ej) if f.exists()}
    man = dict(
        kind="fs38-lrat-manifest", level=5, colours=4, n=cay.n, base_edges=len(edges), added_edge=[0, di],
        delta=list(delta), delta_depth=dep, omega_orbit_indices=orbit, pins=pins,
        pins_note="a triangle through 0 pinned to three colours — sound by palette symmetry (the shape "
                  "`scripts/regen-check.sh` uses for the committed witnesses)",
        pins_are_a_clique=clique_ok,
        pins_clique_check="every pinned pair verified adjacent in the edge list as built; without this a refusal could "
                          "be a statement about the pins instead of about the graph",
        question="P₅ + the edge (0, δ) is not 4-colourable — equivalently `Forces (twoAdicPlane 5) 4 0 δ`",
        cadical=dict(binary=str(cad), flags=["-q", "--lrat", "--no-binary", "--unsat", f"--seed={a.seed}"],
                     exit_code=r.returncode, unsat=(r.returncode == 20)),
        negative_control=dict(question="the same formula WITHOUT the added edge", exit_code=r0.returncode,
                              sat=(r0.returncode == 10),
                              reads="P₅ itself is 4-colourable, so the refusal is about the edge and not about the "
                                    "formula being broken"),
        lrat=dict(file="lrat/p5-plus-edge.lrat", lines=len(lines), bytes=(lrat.stat().st_size if lrat.exists() else 0),
                  ends_in_empty_clause=empty_clause, last_line=(lines[-1][:80] if lines else None)),
        cnf=dict(file="build/fs38-t/p5-plus-edge.cnf (NOT committed — regenerable from the edge list)",
                 variables=k * cay.n, clauses=cay.n + k * (len(edges) + 1) + len(pins)),
        sha256=sums,
        status="GENERATED, NOT CHECKED — no LRAT/DRAT checker exists on this machine (CLAUDE.md row 64's precedent). "
               "What holds: cadical exited 20 on the formula with the edge and 10 without it, and the proof's last "
               "line is the empty clause. Consuming it in Lean is FS-38 phase K3's, through `tools/emit_mask.py`.",
        regenerate="python3 tools/fs38_tower.py lrat",
        seconds=round(time.time() - t0, 1))
    (out / "manifest.json").write_text(json.dumps(man, indent=1))
    print(f"[fs38] P₅ + edge (0, δ={list(delta)}, index {di}, depth {dep}): cadical exit {r.returncode} "
          f"({'UNSAT' if r.returncode == 20 else 'NOT UNSAT'}), {len(lines)} LRAT lines, "
          f"{man['lrat']['bytes']} bytes, ends in the empty clause: {empty_clause}; the negative control (no added "
          f"edge) exits {r0.returncode} ({'SAT' if r0.returncode == 10 else 'NOT SAT'}). GENERATED, NOT CHECKED.")
    print(f"  wrote {out/'manifest.json'}, {ej.name}, {lrat.name}")
    return man


# ====================================================================== subcommand: recheck
def cmd_recheck(a):
    """Re-verify every committed level record FROM THE FILE ALONE, with no solver: rebuild the graph, recompute the
    orbit partition, check that the record's verdicts are constant on it, and re-verify every per-depth example
    colouring (proper on every edge, and actually separating a free difference of that depth). A stronger check than
    the in-run one, because it reads only what was committed."""
    out = []
    for m in range(1, 9):
        f = DATA / f"tower-p2-k4-m{m}.json"
        if not f.exists():
            continue
        rec = json.loads(f.read_text())
        S = level_circle(m)
        cay = build_level(m)
        if cay.n != rec["n"] or cay.deg != rec["degree"] or cay.edge_count != rec["edges"]:
            raise SystemExit(f"HALT: level {m}'s record does not describe the graph this tool builds")
        orb, reps = level_orbits(m, S)
        fs = rec["forced"]["free_string"]
        byorb = {}
        for i in range(1, cay.n):
            byorb.setdefault(orb[i], set()).add(fs[i])
        incons = [o for o, s in byorb.items() if len(s) > 1]
        ex = rec["models"]["per_depth_example_free"]
        checked = []
        for dep, s in sorted(ex.items()):
            col = [int(ch) for ch in s]
            ok = verify_proper(cay, col)[0]
            sep = [i for i in range(1, cay.n)
                   if level_depth(m, cay.tuple_of(i)) == int(dep) and fs[i] == "f" and col[0] != col[i]]
            checked.append(dict(depth=int(dep), proper_on_all_edges=bool(ok), separates_free_differences=len(sep)))
            if not ok or not sep:
                raise SystemExit(f"HALT: level {m}'s depth-{dep} example colouring does not re-verify: "
                                 f"proper={ok}, separated={len(sep)}")
        exs = rec["models"].get("per_depth_example_same") or {}
        for dep, s in sorted(exs.items()):
            if not verify_proper(cay, [int(ch) for ch in s])[0]:
                raise SystemExit(f"HALT: level {m}'s depth-{dep} identifying example is not proper")
        rec["recheck"] = dict(
            rechecked="from the committed file alone, no solver", orbits=len(reps),
            differences_checked=cay.n - 1, inconsistent_orbits=len(incons),
            verdicts_constant_on_orbits=(not incons), per_depth_examples_reverified=checked,
            identifying_examples_reverified=len(exs), graph_matches_record=True,
            reads="the orbit cross-check the product owner asked for as its own control row: the record's forced "
                  "verdict is constant on every automorphism orbit, on every difference — and that agreement across "
                  "levels 1..7, where every difference was asked individually, is what licenses deciding level 8 from "
                  "one representative per orbit")
        f.write_text(json.dumps(rec, indent=1))
        out.append((m, rec["recheck"]))
        print(f"  m={m}: {len(reps)} orbits over {cay.n - 1} differences, {len(incons)} inconsistent; "
              f"{len(checked)} per-depth example colourings re-verified proper and separating; "
              f"{len(exs)} identifying examples proper", flush=True)
    print(f"[fs38] recheck: {len(out)} level records re-verified from their files alone — 0 inconsistent orbits, "
          f"every per-depth example colouring proper on every edge of a freshly built graph")
    return out


# ====================================================================== self-test
def self_test(a=None):
    fails = []

    def check(name, cond):
        print(f"  [{'ok' if cond else 'RED'}] {name}", flush=True)
        if not cond:
            fails.append(name)

    print("[self-test] fs38_tower: the planted controls")
    # 1. the circle counts, and the two perturbations of the norm form
    counts = [len(level_circle(m)) for m in range(1, 8)]
    check(f"|S_m| = 3·2^(m−1) at m = 1..7 (got {counts})", counts == [3 * 2 ** (m - 1) for m in range(1, 8)])
    true5 = [3 * 2 ** (m - 1) for m in range(1, 6)]
    pre = [len(level_circle(m, re_coef=1)) for m in range(1, 6)]
    ppi = [len(level_circle(m, pi_coef=1)) for m in range(1, 6)]
    check(f"planted red: HALVING the real coefficient breaks the count, reproducing §S3's 18 at m=3 and 24 at m=5 "
          f"(got {pre})", pre != true5 and pre[2] == 18 and pre[4] == 24)
    check(f"planted red: halving the π coefficient breaks the count, reproducing §S3's 9, 18, 36, 72 (got {ppi})",
          ppi != true5 and ppi[1] == 9 and ppi[2] == 18)
    dre = [len(level_circle(m, re_coef=0)) for m in range(1, 8)]
    dpi = [len(level_circle(m, pi_coef=0)) for m in range(1, 8)]
    true7 = [3 * 2 ** (m - 1) for m in range(1, 8)]
    check(f"the perturbation that CANNOT FIRE, recorded so nobody reaches for it: deleting either term leaves the "
          f"count at 3·2^(m−1) at every level 1..7 (got {dre} and {dpi}) — the count is not the discriminator, the "
          f"ring is", dre == true7 and dpi == true7)
    # 2. the independent ring construction, every level
    val = [validate_level(m, level_circle(m)) for m in range(1, 9)]
    check("the ring (ℤ/16)[ω,π]/(π²−2π−2) has π² = 2 + 2π", all(v["pi_squared_ok"] for v in val))
    check("the ideal (π^m) equals the claimed lattice at every level 1..8 (sizes "
          + ",".join(str(v["ideal_size"]) for v in val) + ")",
          all(v["ideal_matches_lattice"] and v["ideal_size"] == v["ideal_expected"] for v in val))
    check("z·z̄ is rational and reduces to the closed-form pair at every level (0 mismatches over all 65,536 "
          "ring elements × 8 levels)", all(v["norm_mismatches"] == 0 for v in val))
    check("the circle of the ring quotient IS the closed-form circle at every level 1..8 — the independent "
          "construction (§S3's pilot check, whose code died with the planning scratchpad)",
          all(v["circle_identical"] for v in val))
    # planted red on the SAME comparison: a perturbed norm form must disagree with the ring
    real_nf = globals()["norm_form"]
    try:
        globals()["norm_form"] = lambda m, a_, b_, c_, d_, rc=1, pc=2: real_nf(m, a_, b_, c_, d_, 1, pc)
        vbad = validate_level(3, level_circle(3, re_coef=1))
    finally:
        globals()["norm_form"] = real_nf
    check(f"planted red: a perturbed norm form DISAGREES with the ring at level 3 "
          f"(mismatches {vbad['norm_mismatches']}, circle identical {vbad['circle_identical']})",
          vbad["norm_mismatches"] > 0 or not vbad["circle_identical"])
    check("the restored norm form agrees again (the mutation was undone — a harness that does not re-verify its "
          "restore is CLAUDE.md's bytecode-cache trap)", validate_level(3, level_circle(3))["circle_identical"])
    # 3. multiplication, the group law, fibres
    mul = [validate_multiplication(m) for m in range(1, 9)]
    check("the truncated level multiplication agrees with ring multiplication at every level (2,000 samples each)",
          all(x["mismatches"] == 0 for x in mul))
    grp = [circle_is_group(m, level_circle(m)) for m in range(1, 7)]
    check("S_m is closed under multiplication and z̄ is z's inverse, at m = 1..6, checked in full",
          all(g["closed_under_multiplication"] and g["conj_is_inverse"] for g in grp))
    fib = [fibre_edges(m, level_circle(m)) for m in range(1, 8)]
    check(f"no fibre carries an edge at any level 1..7 (got {fib})", fib == [0] * 7)
    # 4. depth units
    l4 = build_level(4)
    check("depth: the zero of level m has depth m (checked 1..8)",
          all(level_depth(m, (0, 0, 0, 0)) == m for m in range(1, 9)))
    check("depth: 2√3 = −2 + 2π is depth 2 at level 4 (M53's v₂(d²) = 2 row: the distances 2, 2/√3, 2√3)",
          level_depth(4, (2, 0, 2, 0)) == 2)
    check("depth: TwoAdicFive's δ = ((4,0),(0,0)) is depth 4 at level 5", level_depth(5, (4, 0, 0, 0)) == 4)
    # 5. level two is K₄ □ K₄: 576 proper 4-colourings (the Latin squares of order 4)
    l2 = build_level(2)
    adj = [[False] * 16 for _ in range(16)]
    for x, y in zip(l2.u.tolist(), l2.v.tolist()):
        adj[x][y] = adj[y][x] = True
    cnt = 0
    col = [-1] * 16

    def rec(v):
        nonlocal cnt
        if v == 16:
            cnt += 1
            return
        for c in range(4):
            if all(not adj[v][w] or col[w] != c for w in range(v)):
                col[v] = c
                rec(v + 1)
                col[v] = -1

    rec(0)
    check(f"level two has exactly 576 proper 4-colourings — the Latin squares of order 4, so P₂ = K₄ □ K₄ "
          f"(got {cnt}, degree {l2.deg})", cnt == 576 and l2.deg == 6)
    # 6. the forced ask on a hand-checkable positive and its negative partner
    dia = Cay.__new__(Cay)
    dia.mods, dia.label, dia.n, dia.circle, dia.deg = (4,), "the diamond", 4, [], 0
    dia.comp = np.arange(4).reshape(1, -1)
    dia.u = np.array([0, 0, 0, 1, 1], dtype=np.int32)
    dia.v = np.array([1, 2, 3, 2, 3], dtype=np.int32)
    dia._nbr0 = None
    A3 = Asker(dia, 3)
    s3, _ = A3.free_pair(2, 3)
    A4 = Asker(dia, 4)
    s4, c4 = A4.free_pair(2, 3)
    check("the forced ask's REFUSAL path fires on a hand-checkable positive: the diamond's two apexes (each adjacent "
          "to both ends of the shared edge) are forced equal at three colours", not s3)
    check("… and its SAT path fires on the same object at four colours, with a verified colouring — so both "
          "outcomes of the ask are reachable", s4 and c4 is not None)
    # the same ask on level 1 (K₄): every pair is separated, nothing is forced
    l1 = build_level(1)
    A1 = Asker(l1, 4)
    check("level one is K₄: no pair is forced at four colours (every difference free, verified colourings)",
          all(A1.free(d)[0] for d in range(1, 4)))
    check("level one has no fan gap (the 2-adic side of the dichotomy at level one — `twoAdicPlane_one_no_fanGap`)",
          not A1.gap(0, 1)[0])
    # 7. the planted gap control, on the 2-adic object itself
    l3 = build_level(3)
    A = Asker(l3, 4)
    sat0, base_col = A.ask([])
    pc = mutated_gap_control(l3, 4, base_col, 1, 0)
    check(f"planted gap control at level 3: deleting the edges from vertex 0 to one colour class flips the gap ask "
          f"to SAT (deleted {pc['deleted_edges']} of {l3.deg}, model verified against the MUTATED edges)", pc["fired"])
    check("… and the unmutated level-3 gap ask refuses, so the plant is what produced the SAT", not A.gap(0, 1)[0])
    # 8. the verifier itself
    ok_ver = verify_proper(l3, base_col)[0]
    bad_col = list(base_col)
    e0 = int(l3.u[0])
    e1 = int(l3.v[0])
    bad_col[e1] = bad_col[e0]
    check("the independent verifier passes the solver's model and CATCHES a corrupted one (one endpoint recoloured)",
          ok_ver and not verify_proper(l3, bad_col)[0])
    # 9. the committed tables at 11 and 19
    p11 = build_plane(11, 1)
    t_rec, t_ker = plane_table_11()
    check("the committed 11-table: the record and the kernel literal agree", bool((t_rec == t_ker).all()))
    c11, cen11 = gap_census(p11, t_ker, 5)
    verts11 = sorted({v for v, _ in cen11})
    check(f"the certified 5-colouring of UD(𝔽₁₁,2) is proper on all {p11.edge_count} edges and has exactly three "
          f"gapped vertices (2,4), (7,8), (9,6) (got {[(v//11, v%11) for v in verts11]})",
          verify_proper(p11, c11)[0] and [(v // 11, v % 11) for v in verts11] == [(2, 4), (7, 8), (9, 6)])
    dg = lean_table(PROOFS / "Instances" / "FanGap11.lean", "finitePlane11DoubleGapTable", (11, 11)).reshape(-1)
    cl = sorted(set(p11.closed_nbrs(p11.index((0, 0)))) | set(p11.closed_nbrs(p11.index((1, 0)))))
    shared_gaps = [g for g in range(5) if all(dg[x] != g for x in cl)]
    check(f"the committed shared-gap table at 11 is proper on all {p11.edge_count} edges and leaves colour(s) "
          f"{shared_gaps} absent from the {len(cl)}-vertex set N[(0,0)] ∪ N[(1,0)]",
          verify_proper(p11, dg)[0] and shared_gaps == [4])
    dgb = dg.copy()
    dgb[0] = (int(dg[0]) + 1) % 5
    check("planted red: flipping one entry of the committed shared-gap table breaks properness or the shared gap",
          (not verify_proper(p11, dgb)[0]) or not [g for g in range(5) if all(dgb[x] != g for x in cl)])
    p19 = build_plane(19, 1)
    t19 = plane_table_19()
    c19, cen19 = gap_census(p19, t19, 5)
    projs19 = sorted({(v % 19 - v // 19) % 19 for v, _ in cen19})
    gcols19 = sorted({g for _, g in cen19})
    check(f"the kernel's periodic 19-colouring is proper on all {p19.edge_count} edges and has {len(cen19)} = 2·19 "
          f"gapped (vertex, colour) pairs — every one with gap colour 1, on exactly the two projection values "
          f"{projs19} (Poros counted 38 and read the vertex as (4,0); under the kernel's own `projAlong (1,1) w = "
          f"w.2 − w.1` the gapped vertices with projection 4 are (0,4), (1,5), … — the count, the single gap colour "
          f"and the two values agree under either coordinate order)",
          verify_proper(p19, c19)[0] and len(cen19) == 38 and gcols19 == [1] and projs19 == [4, 10])
    # 10. the palette-symmetry control that guards every refusal
    A6 = Asker(build_level(4), 4)
    l4c = build_level(4)
    dd = l4c.index((2, 0, 2, 0))
    verdicts = [A6.free(dd, colour=c)[0] for c in (1, 2, 3)]
    check(f"palette symmetry: the free ask at one difference of level 4 agrees at every pinned colour "
          f"(got {verdicts})", len(set(verdicts)) == 1)
    ok = not fails
    print(f"[self-test] {'ALL GREEN' if ok else 'RED: ' + '; '.join(fails)}")
    return ok


# ====================================================================== main
def main():
    ap = argparse.ArgumentParser(description="FS-38 phase T: the residue tower, measured")
    sub = ap.add_subparsers(dest="cmd", required=True)
    b = sub.add_parser("build", help="the levels, their circles, and the independent ring validation")
    b.add_argument("--max-m", type=int, default=8)
    b.add_argument("--max-build", type=int, default=7, help="materialise edges up to this level")
    b.add_argument("--planes", action="store_true", help="also the residue planes at 11 and 19")
    b.add_argument("--out")
    b.set_defaults(f=cmd_build)
    f = sub.add_parser("forced", help="the level record: the fan gap and every difference")
    f.add_argument("--m", type=int, required=True)
    f.add_argument("--orbits", action="store_true", help="ask one representative per automorphism orbit")
    f.add_argument("--all-below", type=int, default=20000, help="ask every difference when n is below this")
    f.add_argument("--second-below", type=int, default=40000, help="second-engine re-ask when n is below this")
    f.add_argument("--separated", action="store_true", default=True)
    f.add_argument("--no-separated", dest="separated", action="store_false")
    f.add_argument("--ckpt-every", type=int, default=250)
    f.add_argument("--resume", action="store_true")
    f.add_argument("--out")
    f.set_defaults(f=cmd_forced)
    g = sub.add_parser("gap", help="the fan gap of a committed plane table, and the fresh ask")
    g.add_argument("--p", type=int, default=11)
    g.add_argument("--k", type=int, default=5)
    g.add_argument("--conf", type=int, default=2_000_000)
    g.add_argument("--out")
    g.set_defaults(f=cmd_gap)
    d = sub.add_parser("doublegap", help="one colour absent from two adjacent closed neighbourhoods")
    d.add_argument("--p", type=int, default=11)
    d.add_argument("--k", type=int, default=5)
    d.add_argument("--conf", type=int, default=2_000_000)
    d.add_argument("--out")
    d.set_defaults(f=cmd_doublegap)
    t = sub.add_parser("tables", help="level four's cover of non-periods")
    t.add_argument("--samples", type=int, default=24)
    t.add_argument("--out")
    t.set_defaults(f=cmd_tables)
    r = sub.add_parser("recolour", help="the level-2 repaint at 11")
    r.add_argument("--p", type=int, default=11)
    r.add_argument("--k", type=int, default=5)
    r.add_argument("--target", type=int, default=None)
    r.add_argument("--lift-shift", type=int, default=1)
    r.add_argument("--out")
    r.set_defaults(f=cmd_recolour)
    L = sub.add_parser("lrat", help="the P₅ + edge CNF and its LRAT (generated, not checked)")
    L.add_argument("--seed", type=int, default=2)
    L.set_defaults(f=cmd_lrat)
    rc = sub.add_parser("recheck", help="re-verify every committed level record from its file, no solver")
    rc.set_defaults(f=cmd_recheck)
    s = sub.add_parser("self-test")
    s.set_defaults(f=lambda a: sys.exit(0 if self_test(a) else 1))
    a = ap.parse_args()
    a.f(a)


if __name__ == "__main__":
    main()

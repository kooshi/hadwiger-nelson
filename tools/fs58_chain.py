#!/usr/bin/env python3
"""fs58_chain -- FS-58 phase B, route C at ℚ(√D): the direction pool W₃(N) and the direction-set screen (plan §2 D3.7).

Plan: plans/FS58-four-colours.md §3 "Phase B in detail", §M3 "Tool surfaces", §G rows B. Records: data/fs58/chain-D/.
UNTRUSTED like everything in tools/: every edge, membership and group computation is exact integer arithmetic; a
`Separable (colouring verified)` verdict is certified by a colouring file re-read and re-checked on every quotient edge before
its record line is written; a `Forced (solver claim)` verdict is CaDiCaL's word; spectral numbers are float readings.

Conventions.
  A vector (a, b, c, e) over N is the plane point ((a + b√D)/N, (c + e√D)/N); a unit vector has a² + D·b² + c² + D·e² = N²
  and ab + ce = 0. W₀ = W₃(N) = every unit vector with denominator dividing N (tools/fs58_local.units_d), 3 ∤ N, N even.
  Λ₀ = the ℤ-span of W₀ (rank 4). Lattice coordinates are coordinates in the recorded basis of Λ₀ (pool-N.json, `basis`).
  A quotient is a full-rank sublattice L ⊂ Λ₀ given by a 4 × 4 integer matrix M whose ROWS generate L in basis coordinates.
  Smith normal form: unimodular P, Q with P·M·Q = diag(n₁, …, n₄); then x ↦ (x·Q) mod (n₁, …, n₄) is an isomorphism
  ℤ⁴/L → ⊕ ℤ/nᵢ (x ∈ L ⟺ x·Q ∈ ℤ⁴·diag(n)). Group enumeration: the element with digits (x₁, x₂, x₃, x₄), 0 ≤ xᵢ < nᵢ, is
  vertex k = ((x₁·n₂ + x₂)·n₃ + x₃)·n₄ + x₄ (C order; trivial factors nᵢ = 1 included). The quotient graph is
  Cay(Λ₀/L, image of W₀). The pair for u ∈ W₀ is (vertex 0, image of 3u).
  The screen (D3.7): if no generator lies in L and some proper 3-colouring c of the quotient has c(0) ≠ c(3ū), then no graph
  whose edge vectors all lie in W₀ forces a pair at difference 3u — such a hit KILLS W₀ for u.

  pool D N                        -> data/fs58/chain-D/pool-N.json: W₀ (asserted unit when written and on re-read), counts,
                                     an LLL-reduced ℤ-basis of Λ₀ (trace form), each generator's coordinates, rank (asserted
                                     4), index in ℤ⁴, covolume, least odd cycle of Cay(Λ₀, W₀) by breadth-first search to a cap
  control D N [--wall S]          -> data/fs58/chain-D/control-N.out: the Smith-form self-test; the trivial pairs (L = 3Λ₀
                                     identical; a lattice with 3u ≡ w an edge); the planted rhombus reads Forced and its
                                     unplanted twin Separable (host: L = m·ker κ with the ℚ(i) directions only, since on full
                                     quotients no pair is free); the non-affine ask reads none on 3Λ₀ and exists on that
                                     host; the colouring-file verifier passes a faithful file and refuses three planted faults.
                                     Prints CONTROL PASS per part or a named failure; `screen` refuses to run without it
  screen D N --lattices K --wall S -> data/fs58/chain-D/screen-N.jsonl, one line per (L, u), and screen-N.lattices.jsonl, one
                                     line per L (Hoffman reading, admissible affine forms mod 3 that descend to the quotient,
                                     and on a 3-colourable quotient whether a NON-affine 3-colouring exists: the pinned affine
                                     colourings are blocked and the solver asked again); colourings under colourings/.
                                     Lattices: L = mΛ₀ for m in PRINCIPAL, then K random loop-free Hermite-normal-form
                                     sublattices (seeded). Resume = rerun the same command (finished lines are skipped)
  verify D N                      -> re-reads every Separable line of screen-N.jsonl and re-verifies its colouring file

Verdicts: "Separable (colouring verified)", "Forced (solver claim)", "Unknown (budget)", "identical" (3u ∈ L: one vertex, no
question), "loop" (a generator lies in L: the quotient has no proper colouring, no question). A line also records `pair`
(identical / edge / non-edge) and `quotient` (whether the quotient itself is 3-colourable), so a Forced verdict on a quotient
that has no 3-colouring at all is visibly vacuous.
SAT: pysat's Cadical195 (CaDiCaL 1.9.5), one incremental solver per quotient. Symmetry: c(0) = 0 and one neighbour = 1 for
the colourability ask; c(0) = 0 and c(3ū) = 1 for a separation ask (the colours are then all fixed). pysat cannot interrupt
CaDiCaL (its `interrupt` raises NotImplementedError), so the wall is a loop of conflict-budgeted calls stopped at S seconds;
the overshoot is at most one chunk and every line records its measured seconds.
"""
import argparse
import base64
import hashlib
import itertools
import json
import math
import os
import random
import sys
import time
import zlib
from fractions import Fraction
from pathlib import Path

import numpy as np

sys.path.insert(0, str(Path(__file__).resolve().parent))
from fs58_local import units_d  # noqa: E402

ROOT = Path(__file__).resolve().parent.parent
PRINCIPAL = (2, 4, 5, 7, 8, 10, 11, 13, 14, 16, 17)
MAX_INDEX = 10 ** 5
RANDOM_INDEX_RANGE = (10 ** 3, MAX_INDEX)        # log-uniform
CONFLICT_CHUNK = 5000
BFS_CAP = 1_000_000
SEP, FORCED, UNKNOWN, IDENTICAL, LOOP = ("Separable (colouring verified)", "Forced (solver claim)", "Unknown (budget)",
                                         "identical", "loop")
QUOTIENT_COLOURABLE, QUOTIENT_REFUSED, QUOTIENT_UNKNOWN = ("3-colourable (colouring verified)",
                                                          "not 3-colourable (solver claim)", "Unknown (budget)")


# ============================================================ exact integer linear algebra
def det(M):
    A = [[Fraction(x) for x in row] for row in M]
    n, d = len(A), Fraction(1)
    for c in range(n):
        p = next((r for r in range(c, n) if A[r][c] != 0), None)
        if p is None:
            return 0
        if p != c:
            A[c], A[p] = A[p], A[c]
            d = -d
        d *= A[c][c]
        for r in range(c + 1, n):
            f = A[r][c] / A[c][c]
            if f:
                A[r] = [x - f * y for x, y in zip(A[r], A[c])]
    assert d.denominator == 1
    return int(d)


def matmul(A, B):
    return [[sum(a * b for a, b in zip(row, col)) for col in zip(*B)] for row in A]


def inverse(M):
    n = len(M)
    A = [[Fraction(x) for x in row] + [Fraction(int(i == j)) for j in range(n)] for i, row in enumerate(M)]
    for c in range(n):
        p = next(r for r in range(c, n) if A[r][c] != 0)
        A[c], A[p] = A[p], A[c]
        A[c] = [x / A[c][c] for x in A[c]]
        for r in range(n):
            if r != c and A[r][c]:
                f = A[r][c]
                A[r] = [x - f * y for x, y in zip(A[r], A[c])]
    return [row[n:] for row in A]


def smith(M):
    """Smith normal form of a nonsingular square integer matrix: (n, P, Q) with P·M·Q = diag(n), P and Q unimodular,
    n₁ | n₂ | … , nᵢ > 0.  Row operations act on A and P, column operations on A and Q, so A = P·M·Q throughout."""
    k = len(M)
    A = [list(map(int, row)) for row in M]
    P = [[int(i == j) for j in range(k)] for i in range(k)]
    Q = [[int(i == j) for j in range(k)] for i in range(k)]

    def row_sub(i, j, q):                        # row_i -= q·row_j
        A[i] = [x - q * y for x, y in zip(A[i], A[j])]
        P[i] = [x - q * y for x, y in zip(P[i], P[j])]

    def col_sub(i, j, q):                        # col_i -= q·col_j
        for R in (A, Q):
            for row in R:
                row[i] -= q * row[j]
    for t in range(k):
        while True:
            piv = min(((abs(A[i][j]), i, j) for i in range(t, k) for j in range(t, k) if A[i][j]), default=None)
            assert piv is not None, 'smith: singular matrix'
            _, i, j = piv
            A[t], A[i] = A[i], A[t]
            P[t], P[i] = P[i], P[t]
            for R in (A, Q):
                for row in R:
                    row[t], row[j] = row[j], row[t]
            clean = True
            for i in range(t + 1, k):
                q = A[i][t] // A[t][t]
                if q:
                    row_sub(i, t, q)
                clean &= A[i][t] == 0
            for j in range(t + 1, k):
                q = A[t][j] // A[t][t]
                if q:
                    col_sub(j, t, q)
                clean &= A[t][j] == 0
            if not clean:
                continue
            bad = next((i for i in range(t + 1, k) for j in range(t + 1, k) if A[i][j] % A[t][t]), None)
            if bad is not None:                  # enforce divisibility: row_t += row_bad, then reduce again
                row_sub(t, bad, -1)
                continue
            break
        if A[t][t] < 0:
            A[t] = [-x for x in A[t]]
            P[t] = [-x for x in P[t]]
    n = [A[i][i] for i in range(k)]
    assert all(A[i][j] == 0 for i in range(k) for j in range(k) if i != j)
    return n, P, Q


def check_quotient_map(M, n, Q):
    """None if x ↦ (x·Q) mod n is an isomorphism ℤ⁴/rowspace(M) → ⊕ℤ/nᵢ, else the named reason.  Proof: Q unimodular makes
    the map onto; every row of M maps to 0, so L ⊆ kernel; |⊕ℤ/nᵢ| = ∏nᵢ = |det M| = [ℤ⁴ : L] forces kernel = L."""
    if abs(det(Q)) != 1:
        return 'isomorphism check: Q is not unimodular'
    MQ = matmul(M, Q)
    if any(x % m for row in MQ for x, m in zip(row, n)):
        return 'isomorphism check: a row of M does not map to 0'
    if math.prod(n) != abs(det(M)) or det(M) == 0:
        return 'isomorphism check: the group order is not |det M|'
    return None


def lll(B, form, delta=Fraction(3, 4)):
    """exact LLL of the rows of B under the diagonal quadratic form `form`"""
    B = [list(b) for b in B]
    n = len(B)
    ip = lambda u, v: sum(f * a * b for f, a, b in zip(form, u, v))

    def gso():
        Bs, mu = [], [[Fraction(0)] * n for _ in range(n)]
        for i in range(n):
            v = [Fraction(x) for x in B[i]]
            for j in range(i):
                mu[i][j] = Fraction(ip(B[i], Bs[j])) / ip(Bs[j], Bs[j])
                v = [x - mu[i][j] * y for x, y in zip(v, Bs[j])]
            Bs.append(v)
        return Bs, mu
    k = 1
    while k < n:
        for j in range(k - 1, -1, -1):
            Bs, mu = gso()
            q = round(mu[k][j])
            if q:
                B[k] = [x - q * y for x, y in zip(B[k], B[j])]
        Bs, mu = gso()
        if ip(Bs[k], Bs[k]) >= (delta - mu[k][k - 1] ** 2) * ip(Bs[k - 1], Bs[k - 1]):
            k += 1
        else:
            B[k], B[k - 1] = B[k - 1], B[k]
            k = max(k - 1, 1)
    return B


def hnf_basis(vectors):
    """a ℤ-basis of the span of integer 4-vectors, by integer row reduction (echelon form)"""
    work = [list(v) for v in vectors if any(v)]
    basis = []
    for col in range(4):
        while len([r for r in work if r[col]]) > 1:
            nz = sorted((r for r in work if r[col]), key=lambda r: abs(r[col]))
            p = nz[0]
            for r in nz[1:]:
                q = r[col] // p[col]
                for j in range(4):
                    r[j] -= q * p[j]
            work = [r for r in work if any(r)]
        p = next((r for r in work if r[col]), None)
        if p is not None:
            basis.append(p[:])
            work = [r for r in work if r is not p]
    return basis


# ============================================================ files
def write_json_atomic(path, obj):
    path = Path(path)
    path.parent.mkdir(parents=True, exist_ok=True)
    tmp = path.with_name(path.name + '.tmp')
    with open(tmp, 'w') as f:
        json.dump(obj, f, indent=1)
        f.write('\n')
        f.flush()
        os.fsync(f.fileno())
    os.replace(tmp, path)
    dfd = os.open(path.parent, os.O_RDONLY)
    os.fsync(dfd)
    os.close(dfd)


def append_line(path, obj):
    with open(path, 'a') as f:
        f.write(json.dumps(obj, separators=(',', ':')) + '\n')
        f.flush()
        os.fsync(f.fileno())


def read_lines(path):
    """the finished lines of a JSONL record.  A line is finished only when its newline is on disk; a torn tail after the last
    newline (a crash mid-write) is cut off and reported; an unparseable finished line is corruption and stops the run."""
    path = Path(path)
    if not path.exists():
        return []
    raw = path.read_bytes()
    *complete, tail = raw.split(b'\n')
    lines = []
    for i, chunk in enumerate(complete):
        try:
            lines.append(json.loads(chunk))
        except json.JSONDecodeError as exc:
            raise SystemExit(f'{path}: finished line {i + 1} does not parse ({exc}); refusing to resume over corruption')
    good_bytes = len(raw) - len(tail)
    if tail:
        print(f"  resume: cutting a torn tail of {len(raw) - good_bytes} bytes from {path}", flush=True)
        with open(path, 'r+b') as f:
            f.truncate(good_bytes)
            f.flush()
            os.fsync(f.fileno())
    return lines


def chain_dir(D):
    return ROOT / 'data' / 'fs58' / f'chain-{D}'


def rel(path):
    return str(Path(path).resolve().relative_to(ROOT))


# ============================================================ the pool
def is_unit(w, D, N):
    a, b, c, e = w
    return a * a + D * b * b + c * c + D * e * e == N * N and a * b + c * e == 0


def build_pool(D, N, cap=BFS_CAP):
    assert N % 3 != 0, 'W₃(N) needs 3 ∤ N'
    assert N % 2 == 0, 'the bipartite screen (D3.3): a forcer needs an even denominator'
    t0 = time.time()
    W = units_d(N, D)
    assert all(is_unit(w, D, N) for w in W)
    Wset = set(W)
    assert all(tuple(-x for x in w) in Wset for w in W), 'W₀ must be symmetric'
    form = (1, D, 1, D)
    echelon = hnf_basis(W)
    rank = len(echelon)
    assert rank == 4, f'rank of Λ₀ is {rank}, not 4'
    basis = lll(echelon, form)
    index = abs(det(basis))
    assert index == abs(det(echelon))
    Binv = inverse(basis)
    coords = []
    for w in W:
        c = [sum(Fraction(x) * Binv[i][j] for i, x in enumerate(w)) for j in range(4)]
        assert all(x.denominator == 1 for x in c), 'a generator is not in the ℤ-span of the basis'
        coords.append([int(x) for x in c])
        assert [sum(ci * basis[i][j] for i, ci in enumerate(coords[-1])) for j in range(4)] == list(w)
    span = hnf_basis([list(c) for c in coords])
    assert len(span) == 4 and abs(det(span)) == 1, 'the generators do not span the basis lattice'
    gram = [[Fraction(2 * sum(f * x * y for f, x, y in zip(form, u, v)), N * N) for v in basis] for u in basis]
    cov2 = _det_frac(gram)
    reps = [i for i, w in enumerate(W) if w > tuple(-x for x in w)]
    inv3 = pow(N, -1, 3)
    kappa = [((a + b + c) * inv3) % 3 for a, b, c, e in W]
    canon = sorted(tuple((Fraction(x, N).numerator, Fraction(x, N).denominator) for x in w) for w in W)
    forms = [list(f) for f in itertools.product(range(3), repeat=4)
             if all(sum(a * b for a, b in zip(f, c)) % 3 for c in coords)]
    kappa_form = [((b[0] + b[1] + b[2]) * inv3) % 3 for b in basis]
    assert (kappa_form in forms) == all(kappa)
    odd = least_odd_cycle(coords, cap)
    return {
        'D': D, 'N': N,
        'convention': f'(a, b, c, e) over N is ((a + b√{D})/N, (c + e√{D})/N); unit: a² + {D}b² + c² + {D}e² = N², ab + ce = 0',
        'directions': len(W),
        'directions_outside_Q(i)': sum(1 for w in W if w[1] or w[3]),
        'directions_in_Q(i)': sum(1 for w in W if not (w[1] or w[3])),
        'vector_set_sha256': hashlib.sha256(json.dumps(canon).encode()).hexdigest(),
        'W0': [list(w) for w in W],
        'u_representatives': reps,
        'rank': rank,
        'basis': basis,
        'basis_reduction': 'LLL (δ = 3/4, exact) under the trace form a·a′ + D·b·b′ + c·c′ + D·e·e′ (the Minkowski form up to 2/N²)',
        'coords': coords,
        'index_in_Z4': index,
        'covolume_squared': str(cov2),
        'covolume': math.sqrt(float(cov2)),
        'covolume_note': 'the 4-volume of Λ₀ under both real embeddings, (x, y) ↦ (σ₁x, σ₁y, σ₂x, σ₂y); a unit vector has length √2',
        'kappa_nonzero_on_every_generator': all(kappa),
        'admissible_forms_mod3': forms,
        'admissible_forms_note': 'every linear form Λ₀ → ℤ/3 (in basis coordinates) nonzero on every generator: each gives an '
                                 'affine 3-colouring of Cay(Λ₀, W₀), which never separates a pair at difference 3u; '
                                 'κ = (a + b + c)·N⁻¹ is one of them',
        'kappa_form': kappa_form,
        'least_odd_cycle': odd,
        'seconds': round(time.time() - t0, 2),
    }


def _det_frac(M):
    A = [row[:] for row in M]
    n, d = len(A), Fraction(1)
    for c in range(n):
        p = next((r for r in range(c, n) if A[r][c] != 0), None)
        if p is None:
            return Fraction(0)
        if p != c:
            A[c], A[p] = A[p], A[c]
            d = -d
        d *= A[c][c]
        for r in range(c + 1, n):
            f = A[r][c] / A[c][c]
            A[r] = [x - f * y for x, y in zip(A[r], A[c])]
    return d


def least_odd_cycle(coords, cap):
    """odd girth of Cay(ℤ⁴, coords) by breadth-first search from 0 (vertex-transitive, so the root suffices): the first
    level L holding an edge inside itself gives 2L + 1.  Points are packed into int64 keys (exact while |coordinate| < 2¹⁴,
    asserted).  Stops before a level would push the explored count past `cap`."""
    OFF, BASE = 1 << 14, 1 << 15
    G = np.array(coords, dtype=np.int64)
    keyof = lambda P: (((P[:, 0] + OFF) * BASE + P[:, 1] + OFF) * BASE + P[:, 2] + OFF) * BASE + P[:, 3] + OFF
    gk = keyof(G) - keyof(np.zeros((1, 4), dtype=np.int64))
    prev, cur, explored, L = np.array([], dtype=np.int64), keyof(np.zeros((1, 4), dtype=np.int64)), 1, 0
    maxc = int(np.abs(G).max())
    while True:
        assert (L + 1) * maxc < OFF, 'least_odd_cycle: key packing would overflow'
        nb = np.unique((cur[:, None] + gk[None, :]).ravel())
        if np.isin(nb, cur, assume_unique=True).any():
            return {'length': 2 * L + 1, 'levels_complete': L, 'points_explored': explored, 'cap': cap}
        new = nb[~np.isin(nb, prev, assume_unique=True)]
        if explored + len(new) > cap:
            return {'length': None, 'statement': f'none of length ≤ {2 * L + 1} (levels 0..{L} complete) at cap {cap}',
                    'levels_complete': L, 'points_explored': explored, 'cap': cap}
        prev, cur, explored, L = cur, new, explored + len(new), L + 1


def pool_path(D, N):
    return chain_dir(D) / f'pool-{N}.json'


def cmd_pool(D, N):
    print(f"pool D={D} N={N}: building W₃(N), Λ₀ and its least odd cycle", flush=True)
    pool = build_pool(D, N)
    assert pool['rank'] == 4
    for w in pool['W0']:                          # re-asserted unit when written
        assert is_unit(tuple(w), D, N), f'not a unit vector: {w}'
    write_json_atomic(pool_path(D, N), pool)
    back = json.loads(pool_path(D, N).read_text())
    assert back['rank'] == 4 and all(is_unit(tuple(w), D, N) for w in back['W0']), 'pool file failed its re-read'
    odd = pool['least_odd_cycle']
    print(f"  |W₀| = {pool['directions']} ({pool['directions_outside_Q(i)']} outside ℚ(i), {pool['directions_in_Q(i)']} in "
          f"ℚ(i)); rank {pool['rank']}; index in ℤ⁴ {pool['index_in_Z4']}; covolume {pool['covolume']:.6g}; "
          f"κ nonzero on every generator: {pool['kappa_nonzero_on_every_generator']}; admissible linear forms mod 3: "
          f"{len(pool['admissible_forms_mod3'])}", flush=True)
    print(f"  least odd cycle: {odd['length'] if odd['length'] else odd['statement']} ({odd['points_explored']} points)")
    print(f"  vector set sha256 {pool['vector_set_sha256'][:16]}; wrote {rel(pool_path(D, N))} and re-read it "
          f"({pool['seconds']} s)", flush=True)


def load_pool(D, N):
    """the recorded pool, checked against a rebuild (W₀, basis and coordinates must agree exactly)"""
    p = pool_path(D, N)
    if not p.exists():
        raise SystemExit(f"no pool record at {rel(p)}: run `tools/fs58_chain.py pool {D} {N}` first")
    rec = json.loads(p.read_text())
    W = units_d(N, D)
    assert [list(w) for w in W] == rec['W0'], 'pool record W₀ disagrees with units_d'
    assert all(is_unit(tuple(w), D, N) for w in rec['W0'])
    for w, c in zip(rec['W0'], rec['coords']):
        assert [sum(ci * rec['basis'][i][j] for i, ci in enumerate(c)) for j in range(4)] == w
    assert abs(det(rec['basis'])) == rec['index_in_Z4'] and rec['rank'] == 4
    forms = [list(f) for f in itertools.product(range(3), repeat=4)
             if all(sum(a * b for a, b in zip(f, c)) % 3 for c in rec['coords'])]
    assert rec.get('admissible_forms_mod3') == forms, 'pool record admissible forms missing or disagree: rerun `pool`'
    return rec


# ============================================================ quotients
class Quotient:
    """Cay(Λ₀/L, image of W₀) for L = rowspace(M) in basis coordinates"""

    def __init__(self, pool, M):
        self.M = [list(map(int, r)) for r in M]
        self.n, self.P, self.Q = smith(self.M)
        reason = check_quotient_map(self.M, self.n, self.Q)
        assert reason is None, reason
        self.order = math.prod(self.n)
        assert self.order == abs(det(self.M))
        self.coords = pool['coords']
        self.gen = [self.element(c) for c in self.coords]
        self.loops = [i for i, g in enumerate(self.gen) if g == 0]
        self.S = sorted(set(self.gen) - {0})
        self._digits = None

    def digits_of(self, v):
        return [sum(v[i] * self.Q[i][j] for i in range(4)) % self.n[j] for j in range(4)]

    def element(self, v):
        x = self.digits_of(v)
        return ((x[0] * self.n[1] + x[1]) * self.n[2] + x[2]) * self.n[3] + x[3]

    def pair(self, u_index):
        return self.element([3 * x for x in self.coords[u_index]])

    def pair_kind(self, u_index):
        p = self.pair(u_index)
        return 'identical' if p == 0 else 'edge' if p in set(self.S) else 'non-edge'

    @property
    def digits(self):
        if self._digits is None:
            self._digits = np.stack(np.unravel_index(np.arange(self.order), self.n), axis=1).astype(np.int64)
        return self._digits

    def edges(self, S=None):
        """every undirected edge {x, y} once, as (x, y) with x < y: y − x is a unique element, so it is found once.
        S (default: every generator image) must be closed under negation"""
        n = np.array(self.n, dtype=np.int64)
        idx = np.arange(self.order, dtype=np.int64)
        out = []
        for s in (self.S if S is None else S):
            sd = np.array(np.unravel_index(s, self.n), dtype=np.int64)
            nb = np.ravel_multi_index(tuple(((self.digits + sd) % n).T), self.n)
            keep = idx < nb
            out.append(np.stack([idx[keep], nb[keep]], axis=1))
        return np.concatenate(out) if out else np.zeros((0, 2), dtype=np.int64)

    def hoffman_min_mean(self):
        """least mean of a nontrivial character over the connection set S (float reading); a proper 3-colouring needs an
        independent set of |G|/3, which the ratio bound permits only if this is ≤ −1/2"""
        if not self.S or self.order == 1:
            return None
        Sd = np.stack([np.array(np.unravel_index(s, self.n), dtype=np.float64) / np.array(self.n) for s in self.S])
        best = 9.0
        for j in range(0, self.order, 20000):
            k = self.digits[j:j + 20000].astype(np.float64)
            means = np.cos(2 * np.pi * (k @ Sd.T)).mean(axis=1)
            if j == 0:
                means[0] = 9.0
            best = min(best, float(means.min()))
        return best

    def affine_colourings(self, pool):
        """the admissible linear forms λ (pool `admissible_forms_mod3`) that vanish on every row of M, each as a colour array
        over the group enumeration: a vertex with digits x has preimage x·Q⁻¹, so its colour is x·(Q⁻¹λ) mod 3, well defined
        exactly because λ vanishes on L (asserted: nᵢ·(Q⁻¹λ)ᵢ ≡ 0 mod 3)"""
        Qinv = inverse(self.Q)
        out = []
        for f in pool['admissible_forms_mod3']:
            if any(sum(r[i] * f[i] for i in range(4)) % 3 for r in self.M):
                continue
            g = [sum(Qinv[i][j] * f[j] for j in range(4)) for i in range(4)]
            assert all(x.denominator == 1 for x in g)
            g = [int(x) % 3 for x in g]
            assert all((ni * gi) % 3 == 0 for ni, gi in zip(self.n, g)), 'a descending form is not well defined on digits'
            out.append(((self.digits @ np.array(g, dtype=np.int64)) % 3).astype(np.uint8))
        return out


# ============================================================ SAT
def var(v, c):
    return 3 * v + c + 1


def walled_solve(solver, assumptions, wall):
    t = time.monotonic()
    while True:
        solver.conf_budget(CONFLICT_CHUNK)
        r = solver.solve_limited(assumptions=assumptions)
        if r is not None or time.monotonic() - t >= wall:
            return r, time.monotonic() - t


def decode(model, nverts):
    lits = np.array(model[:3 * nverts], dtype=np.int64).reshape(nverts, 3) > 0
    assert lits.any(axis=1).all(), 'INSTRUMENT CATASTROPHE: a vertex without a colour in the model'
    return lits.argmax(axis=1).astype(np.uint8)


def proper_on(colours, edges):
    return bool((colours[edges[:, 0]] != colours[edges[:, 1]]).all()) if len(edges) else True


def decide_pairs(nverts, edges, pairs, wall, affine=None):
    """the forcing question for each pair (0, p) on a graph given by its vertex count and undirected edge array, as a stream:
    first ('quotient', status, timing), then one (p, verdict, model or None, how, seconds) per pair AS SOON AS IT IS DECIDED,
    so a consumer can checkpoint per pair.  Every model is verified proper on every edge in memory before it is used, and a
    separation read off a model is read on that model.  If `affine` (colour arrays of the quotient's affine colourings) is
    given, each is verified proper, and on a 3-colourable graph a last event ('nonaffine', status, model, seconds, blocked)
    asks for a colouring that is none of them: the pinned affine colourings are blocked by one clause each."""
    from pysat.solvers import Cadical195
    s = Cadical195()
    try:
        t = time.monotonic()
        for v in range(nverts):
            s.add_clause([var(v, 0), var(v, 1), var(v, 2)])
        nb0 = None
        for a, b in edges.tolist():
            s.add_clause([-(3 * a + 1), -(3 * b + 1)])
            s.add_clause([-(3 * a + 2), -(3 * b + 2)])
            s.add_clause([-(3 * a + 3), -(3 * b + 3)])
            if nb0 is None and 0 in (a, b):
                nb0 = b if a == 0 else a
        build = time.monotonic() - t
        assumptions = [var(0, 0)] + ([var(nb0, 1)] if nb0 is not None else [])
        for arr in affine or []:
            assert proper_on(arr, edges), 'INSTRUMENT CATASTROPHE: an affine colouring is improper (the descent is wrong)'
        st, secs = walled_solve(s, assumptions, wall)
        timing = {'build_seconds': round(build, 3), 'colourability_seconds': round(secs, 3)}
        if st is None:
            yield 'quotient', QUOTIENT_UNKNOWN, timing
            for p in pairs:
                yield p, UNKNOWN, None, 'not asked: the colourability ask reached the wall', 0.0
            return
        if st is False:
            if affine:
                raise SystemExit('INSTRUMENT CATASTROPHE: the solver refuses a graph with a verified affine 3-colouring')
            yield 'quotient', QUOTIENT_REFUSED, timing
            for p in pairs:
                yield p, FORCED, None, 'vacuous: the graph has no proper 3-colouring (solver claim)', 0.0
            return
        col = decode(s.get_model(), nverts)
        assert proper_on(col, edges), 'INSTRUMENT CATASTROPHE: improper model'
        models = [col]
        yield 'quotient', QUOTIENT_COLOURABLE, timing
        for p in pairs:
            k = next((i for i, m in enumerate(models) if m[0] != m[p]), None)
            if k is not None:
                yield p, SEP, models[k], f'model {k}', 0.0
                continue
            st, secs = walled_solve(s, [var(0, 0), var(p, 1)], wall)
            if st is None:
                yield p, UNKNOWN, None, 'pinned ask c(0)=0, c(3u)=1 reached the wall', secs
            elif st is False:
                yield p, FORCED, None, 'pinned ask c(0)=0, c(3u)=1 refused', secs
            else:
                col = decode(s.get_model(), nverts)
                assert proper_on(col, edges) and col[0] != col[p], 'INSTRUMENT CATASTROPHE: separating model fails'
                models.append(col)
                yield p, SEP, col, f'pinned ask c(0)=0, c(3u)=1 (model {len(models) - 1})', secs
        if affine is not None and nb0 is not None:
            pinned = [arr for arr in affine if arr[0] == 0 and arr[nb0] == 1]
            for arr in pinned:
                s.add_clause([-(3 * v + int(c) + 1) for v, c in enumerate(arr.tolist())])
            st, secs = walled_solve(s, assumptions, wall)
            if st is None:
                yield 'nonaffine', UNKNOWN, None, secs, len(pinned)
            elif st is False:
                yield 'nonaffine', 'none (solver claim)', None, secs, len(pinned)
            else:
                col = decode(s.get_model(), nverts)
                assert proper_on(col, edges) and all((col != arr).any() for arr in pinned), \
                    'INSTRUMENT CATASTROPHE: the non-affine model is improper or affine'
                yield 'nonaffine', 'exists (colouring verified)', col, secs, len(pinned)
    finally:
        s.delete()


def decide_all(nverts, edges, pairs, wall):
    """decide_pairs collected: (status, {p: (verdict, model, how, seconds)}, timing)"""
    stream = decide_pairs(nverts, edges, pairs, wall)
    _, status, timing = next(stream)
    return status, {ev[0]: ev[1:] for ev in stream if ev[0] != 'nonaffine'}, timing


# ============================================================ colouring files
def colouring_record(pool, q, colours):
    raw = bytes(colours.astype(np.uint8).tolist())
    return {
        'D': pool['D'], 'N': pool['N'], 'lattice': q.M, 'snf_invariants': q.n, 'snf_Q': q.Q, 'order': q.order,
        'enumeration': 'vertex k has digits (x1, x2, x3, x4), 0 <= xi < ni, k = ((x1*n2 + x2)*n3 + x3)*n4 + x4; a vector v in '
                       'basis coordinates (pool record `coords`) maps to digits (v·Q)_i mod n_i',
        'colours_encoding': 'base64 of zlib-compressed bytes, one byte per vertex in enumeration order, values 0, 1, 2',
        'colours': base64.b64encode(zlib.compress(raw, 9)).decode(),
    }


def write_colouring(directory, pool, q, colours):
    rec = colouring_record(pool, q, colours)
    digest = hashlib.sha256(json.dumps([rec['lattice'], rec['colours']]).encode()).hexdigest()[:20]
    path = Path(directory) / f"N{pool['N']}-{digest}.json"
    if not path.exists():
        write_json_atomic(path, rec)
    return path


def verify_colouring_file(path, pool, lattice, pair_vector=None):
    """None if the file at `path` is a proper 3-colouring of Cay(Λ₀/L, W₀) for L = rowspace(lattice) with c(0) ≠ c(v̄), v the
    pair vector in basis coordinates (the screen passes v = 3u, recomputed from the pool); otherwise the named reason.  Rebuilds the quotient map from the file's own (M, n, Q), checks it is the isomorphism,
    and recomputes every edge from the pool's generator coordinates, independently of the solver's CNF."""
    try:
        rec = json.loads(Path(path).read_text())
    except (OSError, json.JSONDecodeError) as exc:
        return f'unreadable colouring file: {exc}'
    if (rec.get('D'), rec.get('N')) != (pool['D'], pool['N']) or rec.get('lattice') != lattice:
        return 'the file is for another field, denominator or lattice'
    M, n, Q = rec['lattice'], rec['snf_invariants'], rec['snf_Q']
    reason = check_quotient_map(M, n, Q)
    if reason:
        return reason
    order = math.prod(n)
    col = np.frombuffer(zlib.decompress(base64.b64decode(rec['colours'])), dtype=np.uint8)
    if len(col) != order:
        return f'colour string has {len(col)} entries for a group of order {order}'
    if (col > 2).any():
        return 'a colour outside {0, 1, 2}'
    Qa, na = np.array(Q, dtype=np.int64), np.array(n, dtype=np.int64)
    gd = (np.array(pool['coords'], dtype=np.int64) @ Qa) % na
    if (gd == 0).all(axis=1).any():
        return 'loop: a generator lies in L'
    allx = np.stack(np.unravel_index(np.arange(order), tuple(n)), axis=1).astype(np.int64)
    for g in np.unique(gd, axis=0):
        nb = np.ravel_multi_index(tuple(((allx + g) % na).T), tuple(n))
        if (col == col[nb]).any():
            x = int(np.argmax(col == col[nb]))
            return f'improper edge: vertex {x} and vertex {int(nb[x])} share colour {int(col[x])}'
    if pair_vector is None:
        return None
    pd = (np.array(pair_vector, dtype=np.int64) @ Qa) % na
    p = int(np.ravel_multi_index(tuple(pd), tuple(n)))
    if p == 0:
        return 'pair is identical: the pair vector lies in L'
    if col[0] == col[p]:
        return f'pair not separated: c(0) = c(v) = {int(col[0])}'
    return None


def three_u(pool, u):
    return [3 * x for x in pool['coords'][u]]


# ============================================================ lattices
def random_hnf(rng, lo, hi):
    """a full-rank row-style Hermite normal form: upper triangular, positive diagonal, entries above a pivot reduced mod it.
    Index log-uniform in [lo, hi]; each prime-power factor of the index assigned to a uniformly random row."""
    n = int(round(math.exp(rng.uniform(math.log(lo), math.log(hi)))))
    n = max(lo, min(hi, n))
    diag, m, p = [1, 1, 1, 1], n, 2
    while m > 1:
        if p * p > m:
            p = m
        while m % p == 0:
            diag[rng.randrange(4)] *= p
            m //= p
        p += 1
    M = [[0] * 4 for _ in range(4)]
    for i in range(4):
        M[i][i] = diag[i]
        for j in range(i + 1, 4):
            M[i][j] = rng.randrange(diag[j])
    return M


def lattice_sequence(pool, K):
    """the screen's lattices, deterministic: the principal family, then K loop-free random HNF sublattices"""
    for m in PRINCIPAL:
        yield {'family': 'principal', 'm': m}, [[m * int(i == j) for j in range(4)] for i in range(4)]
    seed = f"fs58_chain screen D={pool['D']} N={pool['N']}"
    rng = random.Random(seed)
    found = draw = 0
    while found < K:
        draw += 1
        M = random_hnf(rng, *RANDOM_INDEX_RANGE)
        n, _, Q = smith(M)
        gd = [[sum(c[i] * Q[i][j] for i in range(4)) % n[j] for j in range(4)] for c in pool['coords']]
        if any(not any(g) for g in gd):
            continue                              # a loop: rejected, visible as a gap in `draw`
        found += 1
        yield {'family': 'random', 'k': found, 'draw': draw, 'seed': seed,
               'index_distribution': f'log-uniform in [{RANDOM_INDEX_RANGE[0]}, {RANDOM_INDEX_RANGE[1]}]'}, M


# ============================================================ control
def cmd_control(D, N, wall):
    pool = load_pool(D, N)
    out_path = chain_dir(D) / f'control-{N}.out'
    out_path.unlink(missing_ok=True)              # a control that dies midway must not leave an earlier PASS for `screen`
    log, failures = [], []

    def say(msg):
        print(msg, flush=True)
        log.append(msg)

    def part(name, ok, detail):
        say(f"{'CONTROL PASS' if ok else 'CONTROL FAIL'} [{name}] {detail}")
        if not ok:
            failures.append(name)
    say(f"control D={D} N={N}: |W₀| = {pool['directions']}, {len(pool['u_representatives'])} u up to sign, wall {wall} s")

    # (0) Smith normal form self-test, with sympy's invariants as an independent oracle and a planted wrong Q
    from sympy import Matrix, ZZ
    from sympy.matrices.normalforms import smith_normal_form
    rng = random.Random('fs58_chain control smith')
    bad, tested = 0, 0
    while tested < 300:
        M = [[rng.randint(-40, 40) for _ in range(4)] for _ in range(4)]
        if det(M) == 0:
            continue
        tested += 1
        n, P, Q = smith(M)
        PMQ = matmul(matmul(P, M), Q)
        ok = (PMQ == [[n[i] * int(i == j) for j in range(4)] for i in range(4)] and abs(det(P)) == 1
              and check_quotient_map(M, n, Q) is None and all(n[i + 1] % n[i] == 0 for i in range(3))
              and math.prod(n) == abs(det(M)))
        sym = [abs(int(x)) for x in smith_normal_form(Matrix(M), domain=ZZ).diagonal()]
        ok &= sorted(sym) == sorted(n)
        bad += not ok
    part('smith', bad == 0, f'{tested} random nonsingular 4×4 matrices: P·M·Q = diag(n), P and Q unimodular, n₁|n₂|n₃|n₄, '
         f'every row of M maps to 0, |G| = |det M|, invariants equal sympy\'s; failures {bad}')
    M = [[2, 1, 0, 0], [0, 3, 0, 0], [0, 0, 5, 1], [0, 0, 0, 7]]
    n, _, Q = smith(M)
    planted = check_quotient_map(M, n, [[int(i == j) for j in range(4)] for i in range(4)])
    part('smith planted', planted is not None and check_quotient_map(M, n, Q) is None,
         f'on a non-diagonal M the true Q passes the isomorphism check and the identity in its place is refused: {planted!r}')

    reps = pool['u_representatives']
    # (c) identical: L = 3Λ₀
    q3 = Quotient(pool, [[3 * int(i == j) for j in range(4)] for i in range(4)])
    kinds3 = {q3.pair_kind(u) for u in reps}
    part('identical', kinds3 == {'identical'},
         f'L = 3Λ₀ (|G| = 81, loops {len(q3.loops)}): pair kinds over all u {sorted(kinds3)}; the screen asks nothing there')

    # (c) edge: L = ℤ(3u − w) + mΛ₀
    edge_done = None
    for u in reps:
        for wi in range(len(pool['coords'])):
            for m in (5, 7, 8, 10, 11, 13):
                v = [3 * a - b for a, b in zip(pool['coords'][u], pool['coords'][wi])]
                basis = hnf_basis([v] + [[m * int(i == j) for j in range(4)] for i in range(4)])
                if len(basis) < 4:
                    continue
                q = Quotient(pool, basis)
                if q.loops or q.pair_kind(u) != 'edge':
                    continue
                edge_done = (u, wi, m, q)
                break
            if edge_done:
                break
        if edge_done:
            break
    if edge_done is None:
        part('edge', False, 'no loop-free lattice ℤ(3u − w) + mΛ₀ found')
    else:
        u, wi, m, q = edge_done
        status, res, timing = decide_all(q.order, q.edges(), [q.pair(u)], wall)
        verdict, _, how, _ = res[q.pair(u)]
        part('edge', q.pair_kind(u) == 'edge' and (verdict == SEP or status != QUOTIENT_COLOURABLE),
             f'L = ℤ(3u − w) + {m}Λ₀, u = #{u}, w = #{wi}, |G| = {q.order}: pair kind {q.pair_kind(u)!r}; quotient {status}; '
             f'verdict {verdict!r} ({how}) — on a 3-colourable quotient every colouring separates an edge')

    # (a)/(b) the planted rhombus.  Step 1: a host 3-colourable by construction, L = m·ker κ (κ colours it), with what
    # its 3u twins read, and a pair v = w_i + w_j that a verified colouring of the FULL quotient separates (the verifier's
    # faithful case, part (d)).  Step 2: the plant needs a pair that some colouring separates AND some colouring leaves equal,
    # or the planted graph has no colouring and Forced is vacuous; on the same group with only the directions in ℚ(i) as
    # generators (the same ask code, a smaller edge array) the 3u pairs are asked until one twin reads Separable, then the
    # rhombus is planted on it and must read Forced on a planted graph that is still 3-colourable.
    host, colourable_seen, forced_3u_twins = None, 0, 0
    kb = pool['kappa_form']
    j0 = next(i for i in range(4) if kb[i])
    inv_j = pow(kb[j0], -1, 3)
    ker = hnf_basis([[int(i == t) - (((kb[i] * inv_j) % 3) if t == j0 else 0) for t in range(4)] for i in range(4) if i != j0]
                    + [[3 * int(t == j0) for t in range(4)]])
    assert len(ker) == 4 and abs(det(ker)) == 3 and all(sum(r[t] * kb[t] for t in range(4)) % 3 == 0 for r in ker)
    for m in (2, 4, 5, 7, 8, 10, 11, 13):
        spec, M = {'family': 'control host', 'm': m, 'lattice': f'{m}·ker κ'}, [[m * x for x in r] for r in ker]
        q = Quotient(pool, M)
        if q.loops or q.order > 20000:
            continue
        E = q.edges()
        us = [u for u in reps if q.pair_kind(u) == 'non-edge']
        if not us:
            continue
        status, res, timing = decide_all(q.order, E, sorted({q.pair(u) for u in us}), wall)
        say(f"  host: L = {m}·ker κ (3-colourable by κ), |G| = {q.order} {q.n}: quotient {status}; non-edge 3u pairs "
            f"{len(us)}, verdicts {sorted({r[0] for r in res.values()})}")
        if status != QUOTIENT_COLOURABLE:
            part('host colourable', False, f'L = {m}·ker κ reads {status!r} though κ colours it')
            break
        colourable_seen += 1
        forced_3u_twins += sum(1 for u in us if res[q.pair(u)][0] == FORCED)
        S = set(q.S)
        cand = {}
        for i, gi in enumerate(pool['coords']):
            for j in range(i + 1, len(pool['coords'])):
                v = [a + b for a, b in zip(gi, pool['coords'][j])]
                e = q.element(v)
                if e and e not in S:
                    cand.setdefault(e, (v, f'v = w#{i} + w#{j}'))
        cand = dict(list(cand.items())[:30])
        _, res2, _ = decide_all(q.order, E, sorted(cand), wall)
        sep2 = [e for e in cand if res2[e][0] == SEP]
        say(f"    3u twins on this 3-colourable quotient: {sorted({res[q.pair(u)][0] for u in us})}; pairs v = w_i + w_j: "
            f"{len(sep2)} of {len(cand)} Separable, {sum(1 for e in cand if res2[e][0] == FORCED)} Forced")
        if sep2:
            v, label = cand[sep2[0]]
            host = (spec, q, E, v, label, res2[sep2[0]][1])
            break
    plant = None
    if host is not None:
        spec, q, E, v, label, twin_col = host
        qi = [i for i, w in enumerate(pool['W0']) if not (w[1] or w[3])]
        Sq = sorted({q.gen[i] for i in qi} - {0})
        Eq = q.edges(Sq)
        for u in reps:
            pu = q.pair(u)
            if pu == 0 or pu in Sq:
                continue
            _, r, _ = decide_all(q.order, Eq, [pu], wall)
            if r[pu][0] != SEP:
                continue
            x, y = q.order, q.order + 1
            planted = np.concatenate([Eq, np.array([[0, x], [0, y], [pu, x], [pu, y], [x, y]], dtype=np.int64)])
            pstatus, pres, _ = decide_all(q.order + 2, planted, [pu], wall)
            if pstatus != QUOTIENT_COLOURABLE:
                continue                          # the twin separates this pair in every colouring: not a free pair
            plant = (u, r[pu], pstatus, pres[pu], len(Eq))
            break
    if host is None:
        part('planted rhombus', False, f'no host found among L = m·ker κ (|G| ≤ 20000): '
             f'{colourable_seen} 3-colourable quotients, none separating any tested pair')
    elif plant is None:
        part('planted rhombus', False, f'on {spec_label(spec)} with the ℚ(i) directions only, no 3u pair is free (separable '
             f'by one colouring and equal in another), so a plant cannot be read non-vacuously')
    else:
        u, (tv, tcol, thow, _), pstatus, (pv, _, phow, psecs), ne = plant
        pu = q.pair(u)
        part('unplanted twin', tv == SEP and tcol[0] != tcol[pu],
             f'{spec_label(spec)}, |G| = {q.order}, generators the {len(qi)} directions in ℚ(i) ({ne} edges), pair 3u for '
             f'u = #{u}: the twin reads {tv!r} ({thow}; c(0) = {int(tcol[0])}, c(3u) = {int(tcol[pu])})')
        part('planted rhombus', pv == FORCED and pstatus == QUOTIENT_COLOURABLE,
             f'the same graph plus two vertices adjacent to each other and to 0 and 3u: planted graph {pstatus} (so the '
             f'refusal is not vacuous); verdict {pv!r} ({phow}, {psecs:.2f} s)')
    # (e) the non-affine ask, both outcomes: on L = 3Λ₀ (the residue plane at 3, whose colourings are all affine, plan §0 O1)
    # it must read none; on the plant's host graph (directions in ℚ(i) only), with the full quotient's affine colourings
    # blocked, it must find one
    affine3 = q3.affine_colourings(pool)
    ev3 = [ev for ev in decide_pairs(q3.order, q3.edges(), [], wall, affine=affine3) if ev[0] == 'nonaffine']
    part('non-affine none', len(ev3) == 1 and ev3[0][1] == 'none (solver claim)' and len(affine3) == len(pool['admissible_forms_mod3']),
         f'L = 3Λ₀: {len(affine3)} affine colourings (every admissible form descends), {ev3[0][4] if ev3 else None} pinned '
         f'ones blocked: non-affine colouring {ev3[0][1] if ev3 else None!r}')
    if host is not None and plant is not None:
        affh = q.affine_colourings(pool)
        evh = [ev for ev in decide_pairs(q.order, Eq, [], wall, affine=affh) if ev[0] == 'nonaffine']
        part('non-affine exists', len(evh) == 1 and evh[0][1] == 'exists (colouring verified)',
             f'{spec_label(spec)} with the ℚ(i) directions only: {len(affh)} affine colourings of the full quotient, '
             f'{evh[0][4] if evh else None} pinned ones blocked: non-affine colouring {evh[0][1] if evh else None!r}')
    if host is not None:
        say(f"  full quotients in the host search: {colourable_seen} 3-colourable; their non-edge 3u twins read Forced "
            f"{forced_3u_twins} times")

    if host is not None:
        # (d) the verifier on a scratch copy of the full quotient's colouring separating v: faithful passes, three planted
        # faults refused
        spec, q, E, v, label, twin_col = host
        import tempfile
        with tempfile.TemporaryDirectory() as tmpd:
            path = write_colouring(tmpd, pool, q, twin_col)
            faithful = verify_colouring_file(path, pool, q.M, v)
            part('verifier faithful', faithful is None, f'the twin colouring written and re-read verifies for its pair: '
                 f'{faithful!r}')
            rec = json.loads(Path(path).read_text())
            bad_col = twin_col.copy()
            a, b = (int(z) for z in E[len(E) // 2])
            bad_col[b] = bad_col[a]
            rec1 = dict(rec, colours=base64.b64encode(zlib.compress(bytes(bad_col.tolist()), 9)).decode())
            write_json_atomic(Path(tmpd) / 'fault1.json', rec1)
            r1 = verify_colouring_file(Path(tmpd) / 'fault1.json', pool, q.M, v)
            part('verifier planted improper', r1 is not None and r1.startswith('improper edge'),
                 f'one endpoint of edge ({a}, {b}) recoloured to match: {r1!r}')
            other = next((three_u(pool, u) for u in reps if q.pair(u) != 0 and twin_col[q.pair(u)] == twin_col[0]), None)
            if other is None:
                part('verifier planted pair', False, 'no 3u pair this colouring leaves equal: the refusal is unreachable here')
            else:
                r2 = verify_colouring_file(path, pool, q.M, other)
                part('verifier planted pair', r2 is not None and r2.startswith('pair not separated'),
                     f'the faithful file checked against a 3u pair it leaves equal: {r2!r}')
            rec3 = dict(rec, snf_Q=[[int(i == j) for j in range(4)] for i in range(4)])
            write_json_atomic(Path(tmpd) / 'fault3.json', rec3)
            r3 = verify_colouring_file(Path(tmpd) / 'fault3.json', pool, q.M, v)
            part('verifier planted map', q.Q != rec3['snf_Q'] and r3 is not None and r3.startswith('isomorphism check'),
                 f'the file\'s Q replaced by the identity: {r3!r}')
    verdict_line = 'CONTROL PASS (all parts)' if not failures else f'CONTROL FAIL: {", ".join(failures)}'
    say(verdict_line)
    out_path.parent.mkdir(parents=True, exist_ok=True)
    tmp = out_path.with_name(out_path.name + '.tmp')
    tmp.write_text('\n'.join(log) + '\n')
    os.replace(tmp, out_path)
    return 0 if not failures else 1


# ============================================================ screen
def cmd_screen(D, N, K, wall):
    pool = load_pool(D, N)
    ctrl = chain_dir(D) / f'control-{N}.out'
    if not ctrl.exists() or 'CONTROL PASS (all parts)' not in ctrl.read_text():
        raise SystemExit(f"refusing to screen: {rel(ctrl)} does not record CONTROL PASS (all parts); run `control {D} {N}`")
    rec_path = chain_dir(D) / f'screen-{N}.jsonl'
    lat_path = chain_dir(D) / f'screen-{N}.lattices.jsonl'
    cdir = chain_dir(D) / 'colourings'
    cdir.mkdir(parents=True, exist_ok=True)
    done = {(json.dumps(r['lattice']), r['u']['index']) for r in read_lines(rec_path)}
    lat_done = {json.dumps(r['lattice']) for r in read_lines(lat_path)}
    reps = pool['u_representatives']
    print(f"screen D={D} N={N}: |W₀| = {pool['directions']}, {len(reps)} u up to sign; lattices: {len(PRINCIPAL)} principal "
          f"mΛ₀ then {K} random loop-free HNF (index log-uniform in {RANDOM_INDEX_RANGE}); wall {wall} s in conflict chunks "
          f"of {CONFLICT_CHUNK}; resume: {len(done)} (L, u) lines and {len(lat_done)} lattice lines already recorded",
          flush=True)
    for spec, M in lattice_sequence(pool, K):
        key = json.dumps(M)
        todo = [u for u in reps if (key, u) not in done]
        if not todo and key in lat_done:
            continue
        t0 = time.monotonic()
        q = Quotient(pool, M)
        base = {'D': D, 'N': N, **spec, 'lattice': q.M, 'group': q.n, 'order': q.order, 'degree': len(q.S),
                'loops': len(q.loops), 'wall': wall, 'conflict_chunk': CONFLICT_CHUNK}
        tally = {}

        def commit(line):
            append_line(rec_path, line)
            tally[line['verdict']] = tally.get(line['verdict'], 0) + 1
        ubase = lambda u: {**base, 'u': {'index': u, 'vector': pool['W0'][u], 'coords': pool['coords'][u]},
                           'pair': q.pair_kind(u)}
        if q.loops:
            for u in todo:
                commit({**ubase(u), 'verdict': LOOP, 'quotient': 'loop', 'colouring_file': None})
            append_line(lat_path, {**base, 'quotient': 'loop'})
            print(f"  {spec_label(spec)} |G| = {q.order}: {len(q.loops)} generators in L — loop, nothing asked", flush=True)
            continue
        hoff = q.hoffman_min_mean()
        affine = q.affine_colourings(pool)
        base.update({'hoffman_min_mean_reading': hoff, 'hoffman_permits_three': hoff is not None and hoff <= -0.5 + 1e-9,
                     'affine_forms_descending': len(affine)})
        files = {}
        for u in todo:
            if q.pair_kind(u) == 'identical':
                commit({**ubase(u), 'verdict': IDENTICAL, 'quotient': 'not asked', 'colouring_file': None})
        by_pair = {}
        for u in reps:
            if q.pair_kind(u) != 'identical':
                by_pair.setdefault(q.pair(u), []).append(u)
        status, timing, nonaffine = 'not asked', {}, {'nonaffine': 'not asked'}
        stream = decide_pairs(q.order, q.edges(), sorted(by_pair), wall, affine=affine)
        _, status, timing = next(stream)
        for ev in stream:
            if ev[0] == 'nonaffine':
                _, nstatus, model, secs, blocked = ev
                nonaffine = {'nonaffine': nstatus, 'nonaffine_seconds': round(secs, 3), 'affine_blocked': blocked,
                             'nonaffine_colouring_file': None}
                if model is not None:
                    path = write_colouring(cdir, pool, q, model)
                    reason = verify_colouring_file(path, pool, q.M)
                    if reason is not None:
                        raise SystemExit(f'VERIFICATION FAILED on re-read of {rel(path)} (non-affine colouring): {reason}')
                    nonaffine['nonaffine_colouring_file'] = rel(path)
                continue
            p, verdict, model, how, secs = ev
            if verdict == SEP and hoff is not None and hoff > -0.5 + 1e-6:
                raise SystemExit(f'INSTRUMENT CATASTROPHE: a verified 3-colouring of a quotient the ratio bound refuses ({hoff})')
            for u in by_pair[p]:
                if (key, u) in done:
                    continue
                line = {**ubase(u), 'quotient': status, **timing, 'verdict': verdict, 'how': how,
                        'ask_seconds': round(secs, 3), 'colouring_file': None}
                if verdict == SEP:
                    mkey = model.tobytes()
                    if mkey not in files:
                        files[mkey] = write_colouring(cdir, pool, q, model)
                    reason = verify_colouring_file(files[mkey], pool, q.M, three_u(pool, u))
                    if reason is not None:
                        raise SystemExit(f'VERIFICATION FAILED on re-read of {rel(files[mkey])} for u = #{u}: {reason}')
                    line['colouring_file'] = rel(files[mkey])
                commit(line)
        if status == QUOTIENT_COLOURABLE and not affine:
            print(f"  NOTE {spec_label(spec)}: a 3-colourable quotient with no descending affine form", flush=True)
        append_line(lat_path, {**base, 'quotient': status, **timing, **nonaffine,
                               'seconds': round(time.monotonic() - t0, 3)})
        print(f"  {spec_label(spec)} |G| = {q.order} {q.n} deg {len(q.S)}: Hoffman min mean {hoff:.4f}; affine forms "
              f"descending {len(affine)}; quotient {status}; non-affine colouring {nonaffine['nonaffine']}; {tally}; "
              f"{time.monotonic() - t0:.1f} s", flush=True)
    summarize(pool, rec_path, lat_path)
    return 0


def spec_label(spec):
    if spec['family'] == 'control host':
        return f"L = {spec['m']}·ker κ"
    return f"m={spec['m']}" if spec['family'] == 'principal' else f"random #{spec['k']} (draw {spec['draw']})"


def summarize(pool, rec_path, lat_path):
    lines, lats = read_lines(rec_path), read_lines(lat_path)
    reps = pool['u_representatives']
    by_u = {u: [ln for ln in lines if ln['u']['index'] == u] for u in reps}
    print(f"summary {rel(rec_path)}: {len(lines)} (L, u) lines over {len(lats)} lattices", flush=True)
    counts = {}
    for ln in lines:
        k = ln['verdict'] + (' on a 3-colourable quotient' if ln['verdict'] == FORCED and ln['quotient'] == QUOTIENT_COLOURABLE
                             else ' (vacuous: quotient not 3-colourable)' if ln['verdict'] == FORCED else '')
        counts[k] = counts.get(k, 0) + 1
    print(f"  verdicts: {counts}")
    table = {}
    for la in lats:
        k = (la['quotient'], la.get('affine_forms_descending', 0) > 0, la.get('nonaffine', 'not asked'))
        table[k] = table.get(k, 0) + 1
    print("  lattices by (quotient, some affine form descends, non-affine colouring):")
    for k, v in sorted(table.items()):
        print(f"    {k}: {v}")
    killed = [u for u in reps if any(ln['verdict'] == SEP for ln in by_u[u])]
    print(f"  u killed (some quotient separates (0, 3u)): {len(killed)} of {len(reps)}")
    for u in reps:
        hit = next((ln for ln in by_u[u] if ln['verdict'] == SEP), None)
        if hit:
            print(f"    u #{u} {pool['W0'][u]}: killed by {spec_label(hit)} |G| = {hit['order']} pair {hit['pair']} "
                  f"-> {hit['colouring_file']}")
        else:
            vs = {}
            for ln in by_u[u]:
                vs[ln['verdict']] = vs.get(ln['verdict'], 0) + 1
            print(f"    u #{u} {pool['W0'][u]}: NOT killed at budget ({vs})")


def cmd_verify(D, N):
    pool = load_pool(D, N)
    rec_path = chain_dir(D) / f'screen-{N}.jsonl'
    lines = read_lines(rec_path)
    ok = bad = 0
    for la in read_lines(chain_dir(D) / f'screen-{N}.lattices.jsonl'):
        if la.get('nonaffine_colouring_file'):
            reason = verify_colouring_file(ROOT / la['nonaffine_colouring_file'], pool, la['lattice'])
            ok, bad = (ok + 1, bad) if reason is None else (ok, bad + 1)
            if reason:
                print(f"  FAILED: {la['nonaffine_colouring_file']} (non-affine): {reason}")
    for ln in lines:
        if ln['verdict'] != SEP:
            continue
        reason = verify_colouring_file(ROOT / ln['colouring_file'], pool, ln['lattice'], three_u(pool, ln['u']['index']))
        if reason is None:
            ok += 1
        else:
            bad += 1
            print(f"  FAILED: {ln['colouring_file']} u = #{ln['u']['index']}: {reason}")
    print(f"verify {rel(rec_path)}: {ok} colouring references (Separable lines and non-affine colourings) re-verified "
          f"from their files, {bad} failures "
          f"({len(lines)} lines in all)")
    return 1 if bad or not lines else 0


def main():
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    sub = ap.add_subparsers(dest='cmd', required=True)
    for name in ('pool', 'control', 'screen', 'verify'):
        p = sub.add_parser(name)
        p.add_argument('D', type=int)
        p.add_argument('N', type=int)
        if name in ('control', 'screen'):
            p.add_argument('--wall', type=float, default=60.0)
        if name == 'screen':
            p.add_argument('--lattices', type=int, default=50)
    a = ap.parse_args()
    if a.cmd == 'pool':
        cmd_pool(a.D, a.N)
        return 0
    if a.cmd == 'control':
        return cmd_control(a.D, a.N, a.wall)
    if a.cmd == 'screen':
        return cmd_screen(a.D, a.N, a.lattices, a.wall)
    return cmd_verify(a.D, a.N)


if __name__ == '__main__':
    sys.exit(main())

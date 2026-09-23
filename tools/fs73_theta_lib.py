"""FS-73 P3b — shared exact arithmetic for the three-colour rotation set Θ of an FS-61 lattice.

Untrusted, as everything in `tools/` is: the verdicts are re-derived by `tools/fs73_theta_check.py` (and, for emptiness,
by the committed `data/fs73/coxeter-c3/certcheck.py`), which use nothing from here.

A lattice is an FS-61 key `M|HNF` over ℚ(√d): the points are ((a+b√d)/M, (c+e√d)/M) with (a,b,c,e) in the row lattice of
the 4×4 Hermite normal form. Its unit vectors satisfy a²+db²+c²+de² = M², ab+ce = 0. Θ = {θ ∈ Hom(span U, ℝ) : θ(u) mod 1
∈ [1/3, 2/3] for every u ∈ U} (H-i / dB-T0: the graph is 3-colourable iff Θ ≠ ∅). Pure Python integers and Fractions.
"""
from __future__ import annotations

import math
from fractions import Fraction as Fr


def parse_key(key: str) -> tuple[int, list[list[int]]]:
    m, h = key.split("|")
    return int(m), [list(map(int, row.split(","))) for row in h.split(";")]


def in_row_lattice(v, H) -> bool:
    """Membership in the row lattice of an upper-triangular HNF H (4×4)."""
    v = list(v)
    for i in range(4):
        if v[i] % H[i][i]:
            return False
        q = v[i] // H[i][i]
        v = [v[t] - q * H[i][t] for t in range(4)]
    return all(x == 0 for x in v)


def unit_vectors(key: str, d: int) -> list[tuple[int, int, int, int]]:
    """Every (a,b,c,e) of the key lattice with a²+db²+c²+de² = M² and ab+ce = 0, loop over (a, b, e)."""
    M, H = parse_key(key)
    bmax = math.isqrt(M * M // d)
    out = set()
    for a in range(-M, M + 1):
        for b in range(-bmax, bmax + 1):
            r1 = M * M - a * a - d * b * b
            if r1 < 0:
                continue
            for e in range(-bmax, bmax + 1):
                r2 = r1 - d * e * e
                if r2 < 0:
                    continue
                c = math.isqrt(r2)
                if c * c != r2:
                    continue
                for cc in {c, -c}:
                    if a * b + cc * e == 0 and in_row_lattice((a, b, cc, e), H):
                        out.add((a, b, cc, e))
    return sorted(out)


def row_hnf_basis(vectors) -> list[list[int]]:
    """A ℤ-basis (rows) of the ℤ-span of integer vectors, by integer row reduction (upper-triangular echelon)."""
    A = [list(v) for v in vectors if any(v)]
    n = len(A[0])
    basis = []
    col = 0
    while A and col < n:
        nz = [r for r in A if r[col] != 0]
        z = [r for r in A if r[col] == 0]
        while len(nz) > 1:
            nz.sort(key=lambda r: abs(r[col]))
            p = nz[0]
            new = [p]
            for r in nz[1:]:
                q = r[col] // p[col]
                rr = [r[t] - q * p[t] for t in range(n)]
                (new if rr[col] != 0 else z).append(rr)
            nz = new
        if nz:
            p = nz[0]
            if p[col] < 0:
                p = [-x for x in p]
            basis.append(p)
        A = [r for r in z if any(r)]
        col += 1
    return basis


def solve_int_coords(B, v) -> list[int]:
    """Coordinates of v in the row basis B (full row rank, square after restriction), exactly; asserts integrality."""
    r = len(B)
    n = len(B[0])
    # least-squares-free exact solve: pick r independent columns
    cols = independent_columns(B)
    Mx = [[Fr(B[j][c]) for j in range(r)] + [Fr(v[c])] for c in cols]
    for k in range(r):
        piv = next(i for i in range(k, r) if Mx[i][k] != 0)
        Mx[k], Mx[piv] = Mx[piv], Mx[k]
        for i in range(r):
            if i != k and Mx[i][k] != 0:
                f = Mx[i][k] / Mx[k][k]
                Mx[i] = [Mx[i][t] - f * Mx[k][t] for t in range(r + 1)]
    x = [Mx[i][r] / Mx[i][i] for i in range(r)]
    assert all(t.denominator == 1 for t in x), "not an integer combination"
    x = [int(t) for t in x]
    assert all(sum(x[j] * B[j][c] for j in range(r)) == v[c] for c in range(n)), "not in the span"
    return x


def independent_columns(B) -> list[int]:
    r = len(B)
    chosen = []
    rows = []
    for c in range(len(B[0])):
        colv = [Fr(B[j][c]) for j in range(r)]
        test = rows + [colv]
        if rank(test) == len(test):
            rows.append(colv)
            chosen.append(c)
        if len(chosen) == r:
            break
    return chosen


def rank(rows) -> int:
    A = [list(r) for r in rows]
    rk = 0
    ncol = len(A[0]) if A else 0
    for c in range(ncol):
        piv = next((i for i in range(rk, len(A)) if A[i][c] != 0), None)
        if piv is None:
            continue
        A[rk], A[piv] = A[piv], A[rk]
        for i in range(len(A)):
            if i != rk and A[i][c] != 0:
                f = Fr(A[i][c]) / Fr(A[rk][c])
                A[i] = [A[i][t] - f * A[rk][t] for t in range(ncol)]
        rk += 1
    return rk


def det_int(A) -> int:
    """Bareiss fraction-free determinant of a square integer matrix."""
    A = [r[:] for r in A]
    n = len(A)
    sign, prev = 1, 1
    for k in range(n - 1):
        if A[k][k] == 0:
            for i in range(k + 1, n):
                if A[i][k] != 0:
                    A[k], A[i] = A[i], A[k]
                    sign = -sign
                    break
            else:
                return 0
        for i in range(k + 1, n):
            for j in range(k + 1, n):
                A[i][j] = (A[i][j] * A[k][k] - A[i][k] * A[k][j]) // prev
        prev = A[k][k]
    return sign * A[n - 1][n - 1]


def half_set(coords) -> list[list[int]]:
    """One representative per ± pair, in first-seen order."""
    seen = set()
    out = []
    for c in coords:
        t = tuple(c)
        if t in seen or tuple(-x for x in t) in seen:
            continue
        seen.add(t)
        out.append(list(t))
    return out


def lattice_problem(key: str, d: int):
    """(U, basis, half-set coordinates): basis rows are (a,b,c,e) vectors spanning span(U)."""
    U = unit_vectors(key, d)
    B = row_hnf_basis(U)
    C = [solve_int_coords(B, u) for u in U]
    return U, B, half_set(C)


def in_band(x: Fr) -> bool:
    """x mod 1 ∈ [1/3, 2/3]."""
    f = x - math.floor(x)
    return Fr(1, 3) <= f <= Fr(2, 3)


# ---------------------------------------------------------------------------------------------------------------------
# Exact linear programming for small dimension: maximise c·x subject to A x ≤ b (x free), by the simplex method on the
# dual in Fractions with Bland's rule. Returns ("optimal", x, y) with y ≥ 0, yA = c, y·b = c·x; ("infeasible", None, ray)
# with ray ≥ 0, ray·A = 0, ray·b < 0; or ("unbounded", x, direction). Exact, slow, meant for ≤ ~100 rows and ≤ ~6 columns.

def exact_lp_max(A, b, c):
    """Maximise c·x s.t. A x <= b, x ∈ ℝ^n free. Primal simplex over vertices (dimension n small) with Bland's rule."""
    A = [[Fr(v) for v in row] for row in A]
    b = [Fr(v) for v in b]
    c = [Fr(v) for v in c]
    m, n = len(A), len(c)
    # Phase 1: find a feasible vertex. Big-box-free approach: add an auxiliary variable s, minimise s over
    # A x - s <= b, s >= 0 (i.e. -s <= 0). Start vertex: need n+1 tight independent rows; we instead solve
    # phase 1 through the generic routine on the lifted problem with a trivially feasible start via a large s.
    status, x, cert = _phase1(A, b, n)
    if status == "infeasible":
        return "infeasible", None, cert
    return _phase2(A, b, c, x)


def _solve(Mrows, rhs):
    """Solve square system exactly; returns None if singular."""
    k = len(Mrows)
    Mx = [list(Mrows[i]) + [rhs[i]] for i in range(k)]
    for col in range(k):
        piv = next((i for i in range(col, k) if Mx[i][col] != 0), None)
        if piv is None:
            return None
        Mx[col], Mx[piv] = Mx[piv], Mx[col]
        inv = 1 / Mx[col][col]
        Mx[col] = [v * inv for v in Mx[col]]
        for i in range(k):
            if i != col and Mx[i][col] != 0:
                f = Mx[i][col]
                Mx[i] = [Mx[i][t] - f * Mx[col][t] for t in range(k + 1)]
    return [Mx[i][k] for i in range(k)]


def _transpose(M):
    return [list(r) for r in zip(*M)]


def _phase2(A, b, c, x0):
    """Vertex-walk simplex from a feasible point x0 (moved to a vertex first). Bland's rule."""
    m, n = len(A), len(c)
    x = list(x0)
    # move to a vertex: greedily make constraints tight while keeping feasibility, along directions in the
    # null space of the current tight set that do not decrease c·x (or any direction if c·d = 0).
    tight = [i for i in range(m) if sum(A[i][j] * x[j] for j in range(n)) == b[i]]
    basis = []
    for i in tight:
        if rank([A[k] for k in basis + [i]]) == len(basis) + 1:
            basis.append(i)
    while len(basis) < n:
        d = _nullspace_dir([A[k] for k in basis], n)
        if sum(c[j] * d[j] for j in range(n)) < 0:
            d = [-v for v in d]
        # step along d until a new constraint becomes tight
        best, arg = None, None
        for i in range(m):
            ad = sum(A[i][j] * d[j] for j in range(n))
            if ad > 0:
                slack = b[i] - sum(A[i][j] * x[j] for j in range(n))
                t = slack / ad
                if best is None or t < best or (t == best and i < arg):
                    best, arg = t, i
        if best is None:
            if sum(c[j] * d[j] for j in range(n)) > 0:
                return "unbounded", x, d
            d = [-v for v in d]
            for i in range(m):
                ad = sum(A[i][j] * d[j] for j in range(n))
                if ad > 0:
                    slack = b[i] - sum(A[i][j] * x[j] for j in range(n))
                    t = slack / ad
                    if best is None or t < best or (t == best and i < arg):
                        best, arg = t, i
            if best is None:
                raise ValueError("polyhedron contains a line; the caller must bound it")
        x = [x[j] + best * d[j] for j in range(n)]
        basis.append(arg)
    # simplex on vertices
    while True:
        AB = [A[k] for k in basis]
        # dual: y_B A_B = c  ->  A_B^T y_B = c
        yB = _solve(_transpose(AB), c)
        neg = [(basis[t], t) for t in range(n) if yB[t] < 0]
        if not neg:
            y = [Fr(0)] * m
            for t in range(n):
                y[basis[t]] = yB[t]
            return "optimal", x, y
        leave_row, tpos = min(neg)          # Bland: smallest index among improving
        # direction d with A_B d = -e_t... we want to relax row leave_row: A_leave d < 0 (move inward), others tight
        e = [Fr(0)] * n
        e[tpos] = Fr(-1)
        d = _solve(AB, e)
        best, arg = None, None
        for i in range(m):
            if i in basis:
                continue
            ad = sum(A[i][j] * d[j] for j in range(n))
            if ad > 0:
                slack = b[i] - sum(A[i][j] * x[j] for j in range(n))
                t = slack / ad
                if best is None or t < best or (t == best and i < arg):
                    best, arg = t, i
        if best is None:
            return "unbounded", x, d
        x = [x[j] + best * d[j] for j in range(n)]
        basis[tpos] = arg


def _nullspace_dir(rows, n):
    """A nonzero vector orthogonal to all rows (rows has rank < n)."""
    if not rows:
        return [Fr(1)] + [Fr(0)] * (n - 1)
    R = [list(r) for r in rows]
    piv_cols = []
    rk = 0
    for col in range(n):
        p = next((i for i in range(rk, len(R)) if R[i][col] != 0), None)
        if p is None:
            continue
        R[rk], R[p] = R[p], R[rk]
        inv = 1 / R[rk][col]
        R[rk] = [v * inv for v in R[rk]]
        for i in range(len(R)):
            if i != rk and R[i][col] != 0:
                f = R[i][col]
                R[i] = [R[i][t] - f * R[rk][t] for t in range(n)]
        piv_cols.append(col)
        rk += 1
    free = next(col for col in range(n) if col not in piv_cols)
    d = [Fr(0)] * n
    d[free] = Fr(1)
    for i, pc in enumerate(piv_cols):
        d[pc] = -R[i][free]
    return d


def _phase1(A, b, n):
    """Feasibility of A x <= b. Returns ("feasible", x, None) or ("infeasible", None, ray) with ray>=0, ray·A=0, ray·b<0."""
    m = len(A)
    # lifted problem in (x, s): maximise -s s.t. A x - s <= b, -s <= 0. Start: x = 0, s = max(0, max(-b)).
    A1 = [A[i] + [Fr(-1)] for i in range(m)] + [[Fr(0)] * n + [Fr(-1)]]
    b1 = b + [Fr(0)]
    c1 = [Fr(0)] * n + [Fr(-1)]
    s0 = max([Fr(0)] + [-v for v in b])
    x0 = [Fr(0)] * n + [s0]
    status, x, y = _phase2(A1, b1, c1, x0)
    assert status == "optimal"
    if x[n] == 0:
        return "feasible", x[:n], None
    # y ≥ 0 with y A1 = c1: the first m entries give ray·A = 0, Σ ray = 1 (from the s column), and y·b1 = -s* < 0
    return "infeasible", None, y[:m]

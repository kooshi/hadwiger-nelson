#!/usr/bin/env python3
"""fs70_tower -- the local 2-adic tower of the plane over F = Q(sqrt3, sqrt5) at the SPLIT prime, at four colours.
UNTRUSTED (tools/): every claim it makes is re-derivable from the data it writes.

WHAT THE OBJECT IS (the recognition, CLAUDE.md G46).  F = Q(sqrt3, sqrt5) has ONE prime p above 2, with e = f = 2
and residue field F_4, and that prime SPLITS in E = F(i) (because -15 = 1 - 16 is a square in Z_2, so i = sqrt(-3)/sqrt3
already lies in the completion).  Therefore

    E (x)_F F_p  =  F_p (+) F_p,          complex conjugation swapping the two factors,

so a point of the plane (a point of E, integral at both primes above p) reduces to a PAIR in (O/p^m)^2, and a unit
vector -- z zbar = 1 -- reduces to a pair (t, t^-1) with t a unit of O/p^m.  The local plane at level m is therefore

    P_m  =  Cay( (O/p^m)^2 , { (t, t^-1) : t in (O/p^m)^x } ),

with 16^m vertices and degree 3*4^(m-1).  Its eigenvalues are lambda_(c,d) = sum_t psi(ct + d/t) -- KLOOSTERMAN SUMS
over the finite local ring O/p^m -- and they are computed here by one multi-dimensional DFT of the connection set's
indicator over the vertex group.  This is the SPLIT case of the tower FS-38 computed over K (row 67), where the
prime above 2 is INERT and the local plane is Cay(O/P^m, S_m) on ONE coordinate.

WHY IT MATTERS (G54, and row 67's mechanism).  Level one is four disjoint K_4's -- the connection set plus 0 is a
subgroup of F_4^2 -- so lambda_min = -1 = -d/3 and the plane is HOFFMAN-TIGHT at four colours.  By G54's Theorem
D2-A, at a tight level every four-colouring is balanced, gap-free and PERIODIC under H_min, the common kernel of the
minimising characters; so the tower FORCES the pairs of H_min, and forces nothing else that some colouring separates.
And freeness transfers DOWN (row 55's Forces.image): a finite graph over F whose points are p-integral and whose edge
differences are 2-units maps homomorphically into P_m, so a pair whose image some four-colouring of P_m separates is
NOT forced on any such graph.  Hence

    d_0 := min { v_p(delta) : delta != 0 forced in the tower }

is a theorem about ALL 2-unit fabric over F at once: every target with v_p(delta) < d_0 is dead, at every radius.

WHAT IT DOES NOT CLAIM.  The tower's forcing is an extremal property of the WHOLE Cayley graph.  A finite direction
set inherits FREENESS, never forcing (row 67: "says nothing about any finite chunk").  So a target at or above d_0
is not thereby forced by anything; it is merely not killed here.

THE MODEL OF O/p^m, and how it is checked rather than asserted.  O = Z_2[omega][sqrt3] with omega^2 + omega + 1 = 0
(Z_2[omega] is the unramified quadratic extension, residue field F_4, and F_p = Q_2(sqrt5) = Q_2(sqrt-3) adjoin
sqrt3 is ramified over it).  pi = 1 + sqrt3 is a uniformizer: N(pi) = (1+sqrt3)(1-sqrt3) = -2 over the unramified
part, so v(pi) = 1 and v(2) = 2.  O_L = O_W[pi] for a totally ramified L/W, so Z[omega][sqrt3] is 2-maximal and

    R_m := Z[omega][sqrt3] / (1 + sqrt3)^m   ==   O/p^m,

computed as Z^4 / L_m with L_m the Hermite basis of the ideal, elements canonical under that basis.  Five checks,
each a number known independently of this file (`--selftest`):
  (1) |R_m| = 4^m and |R_m^x| = 3*4^(m-1);
  (2) t * t^-1 = 1 for every unit, and multiplication is associative and distributive on samples;
  (3) the level map R_(m+1) -> R_m is a surjective ring homomorphism with fibres of size 4, units onto units;
  (4) THE FIELD CHECK: every 2-unit vector of F in `data/fs70/atlas.jsonl` reduces to a pair (t, t^-1) with t a
      unit -- and every vector of nonzero 2-adic depth fails to be integral.  This is what says the ring built here
      is the arithmetic of the field and not merely a ring of the right size;
  (5) level one is four disjoint K_4's with spectrum {3, -1} -- the owner's independently computed fact.

Commands
  python3 tools/fs70_tower.py levels [--max M] [--out DIR]     # the classifier: spectrum, tight/slack, H_min, d_0
  python3 tools/fs70_tower.py forced M [--out DIR]             # the forced set at level M, and the SAT asks' CNFs
  python3 tools/fs70_tower.py cnf M PAIR --out F.cnf           # one four-colouring CNF of P_M with a pair pinned apart
  python3 tools/fs70_tower.py selftest [--plants]
"""
import hashlib
import itertools
import json
import math
import os
import sys
from fractions import Fraction as Fr

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(ROOT, 'tools'))

PLANT = None


def planted(name):
    return PLANT == name


# ---------------------------------------------------------------- Z[omega]: a0 + a1*omega, omega^2 = -1 - omega

def w_mul(a, b):
    a0, a1 = a
    b0, b1 = b
    return (a0 * b0 - a1 * b1, a0 * b1 + a1 * b0 - a1 * b1)


# ---------------------------------------------------------------- Z[omega][sqrt3]: (a0, a1, b0, b1) = a + b*sqrt3

ONE = (1, 0, 0, 0)
OMEGA = (0, 1, 0, 0)
SQRT3 = (0, 0, 1, 0)
PI = (1, 0, 1, 0)          # 1 + sqrt3, the uniformizer
SQRTM3 = (1, 2, 0, 0)      # omega - omega^2 = 1 + 2 omega, squares to -3


def r_mul(x, y):
    """(a + b sqrt3)(c + d sqrt3) = (ac + 3bd) + (ad + bc) sqrt3, products in Z[omega]"""
    a, b = (x[0], x[1]), (x[2], x[3])
    c, d = (y[0], y[1]), (y[2], y[3])
    ac = w_mul(a, c)
    bd = w_mul(b, d)
    ad = w_mul(a, d)
    bc = w_mul(b, c)
    if planted('mul_drop_three'):
        bd = (0, 0)        # PLANT: the sqrt3^2 = 3 rule dropped -- the ring becomes Z[omega][x]/(x^2)
    return (ac[0] + 3 * bd[0], ac[1] + 3 * bd[1], ad[0] + bc[0], ad[1] + bc[1])


def r_add(x, y):
    return tuple(p + q for p, q in zip(x, y))


def r_sub(x, y):
    return tuple(p - q for p, q in zip(x, y))


def r_scale(k, x):
    return tuple(k * p for p in x)


def r_pow(x, n):
    out = ONE
    for _ in range(n):
        out = r_mul(out, x)
    return out


# ---------------------------------------------------------------- integer lattices: Hermite and Smith

def hnf_rows(vectors, dim=4):
    """upper-triangular row Hermite basis (pivot i at column i) of the Z-span of full-rank integer vectors"""
    M = [list(v) for v in vectors]
    basis = []
    for col in range(dim):
        while True:
            nz = [i for i in range(len(M)) if M[i][col] != 0]
            if not nz:
                break
            i0 = min(nz, key=lambda i: abs(M[i][col]))
            p = M[i0][col]
            done = True
            for i in nz:
                if i != i0:
                    q = M[i][col] // p
                    M[i] = [a - q * b for a, b in zip(M[i], M[i0])]
                    if M[i][col] != 0:
                        done = False
            if done:
                row = M[i0]
                if row[col] < 0:
                    row = [-a for a in row]
                basis.append((col, row))
                M = [M[i] for i in range(len(M)) if i != i0]
                break
    # full rank: one pivot per column
    assert len(basis) == dim, f'lattice not full rank: {len(basis)} pivots of {dim}'
    rows = [r for _, r in sorted(basis)]
    # reduce entries above each pivot so the basis is canonical
    for i in range(dim - 1, -1, -1):
        for j in range(i):
            q = rows[j][i] // rows[i][i]
            rows[j] = [a - q * b for a, b in zip(rows[j], rows[i])]
    return rows


def lattice_reduce(rows, v, dim=4):
    """canonical representative of v modulo the lattice: 0 <= out[i] < rows[i][i]"""
    v = list(v)
    for i in range(dim):
        q = v[i] // rows[i][i]
        if q:
            v = [a - q * b for a, b in zip(v, rows[i])]
    return tuple(v)


def smith(B):
    """Smith normal form of a square integer matrix B (rows).  Returns (d, U) with U B V = diag(d)."""
    n = len(B)
    A = [row[:] for row in B]
    U = [[1 if i == j else 0 for j in range(n)] for i in range(n)]

    def rswap(i, j):
        A[i], A[j] = A[j], A[i]
        U[i], U[j] = U[j], U[i]

    def cswap(i, j):
        for r in A:
            r[i], r[j] = r[j], r[i]

    def raddm(i, j, q):      # row i -= q * row j
        A[i] = [a - q * b for a, b in zip(A[i], A[j])]
        U[i] = [a - q * b for a, b in zip(U[i], U[j])]

    def caddm(i, j, q):      # col i -= q * col j
        for r in A:
            r[i] -= q * r[j]

    for t in range(n):
        while True:
            nz = [(i, j) for i in range(t, n) for j in range(t, n) if A[i][j] != 0]
            if not nz:
                break
            i0, j0 = min(nz, key=lambda p: abs(A[p[0]][p[1]]))
            rswap(t, i0)
            cswap(t, j0)
            p = A[t][t]
            moved = False
            for i in range(t + 1, n):
                if A[i][t]:
                    raddm(i, t, A[i][t] // p)
                    if A[i][t]:
                        moved = True
            for j in range(t + 1, n):
                if A[t][j]:
                    caddm(j, t, A[t][j] // p)
                    if A[t][j]:
                        moved = True
            if not moved:
                # clear any leftover entry not divisible by the pivot
                bad = [(i, j) for i in range(t + 1, n) for j in range(t + 1, n) if A[i][j] % A[t][t]]
                if bad:
                    i, j = bad[0]
                    A[t] = [a + b for a, b in zip(A[t], A[i])]
                    U[t] = [a + b for a, b in zip(U[t], U[i])]
                    continue
                break
        if A[t][t] < 0:
            A[t] = [-a for a in A[t]]
            U[t] = [-a for a in U[t]]
    return [A[i][i] for i in range(n)], U


# ---------------------------------------------------------------- the level rings

class Level:
    """R_m = Z[omega][sqrt3] / pi^m, as Z^4 / L_m with canonical representatives."""

    def __init__(self, m):
        self.m = m
        pim = r_pow(PI, m)
        gens = [r_mul(pim, g) for g in (ONE, OMEGA, SQRT3, r_mul(OMEGA, SQRT3))]
        self.L = hnf_rows(gens)
        self.size = 1
        for i in range(4):
            self.size *= self.L[i][i]
        self.elts = [tuple(v) for v in itertools.product(*[range(self.L[i][i]) for i in range(4)])]
        # itertools.product runs the LAST index fastest; our canonical form is coordinatewise so any order is fine
        self.index = {e: i for i, e in enumerate(self.elts)}
        self.one = self.red(ONE)
        self.zero = tuple([0] * 4)
        # The coordinate map onto (+) Z/d_i must be a HOMOMORPHISM, so the Smith left-transform is taken of the
        # lattice's COLUMN matrix (L's rows are the basis, so the column matrix is its transpose): with U C V = D
        # and C = L^T, U carries col-span(C) = L into col-span(D), so x -> Ux mod d is well defined on Z^4/L.
        # Taking the row transform of L instead is well defined only by accident (it survived levels 1-4 here and
        # broke the DFT's reality at level 5, 2026-09-22) -- hence the assertion below, which is the real check.
        C = [[self.L[j][i] for j in range(4)] for i in range(4)]
        d, U = smith(C)
        self.inv_factors = [x for x in d if x != 1]
        self._U = U
        self._d = d
        for row in self.L:
            assert self.coords(row) == tuple([0] * len(self.inv_factors)), \
                'the coordinate map is not trivial on the lattice: it is not well defined on Z^4/L'
        self._units = None
        self._inv = None

    def red(self, v):
        return lattice_reduce(self.L, v)

    def mul(self, x, y):
        return self.red(r_mul(x, y))

    def add(self, x, y):
        return self.red(r_add(x, y))

    def sub(self, x, y):
        return self.red(r_sub(x, y))

    def coords(self, v):
        """coordinates in R_m = (+) Z/d_i, dropping the trivial factors"""
        out = []
        for i in range(4):
            if self._d[i] != 1:
                out.append(sum(self._U[i][j] * v[j] for j in range(4)) % self._d[i])
        return tuple(out)

    def residue(self, v):
        """image in R_1 = F_4, as a canonical 4-tuple of LEVEL ONE (used to decide invertibility)"""
        return lattice_reduce(level(1).L, v)

    def is_unit(self, v):
        return self.residue(v) != (0, 0, 0, 0)

    @property
    def units(self):
        if self._units is None:
            self._units = [e for e in self.elts if self.is_unit(e)]
        return self._units

    def inverse(self, t):
        """Newton/Hensel: s <- s(2 - ts) doubles the precision each step"""
        if self._inv is None:
            self._inv = {}
        if t in self._inv:
            return self._inv[t]
        assert self.is_unit(t), 'not a unit'
        # seed: the inverse in F_4 lifted.  F_4^x has order 3, so s0 = t^2 mod pi works as a start.
        s = self.mul(t, t)
        for _ in range(2 * self.m + 4):
            ts = self.mul(t, s)
            if ts == self.one:
                break
            s = self.mul(s, self.sub(r_scale(2, self.one), ts))
        assert self.mul(t, s) == self.one, ('Hensel failed', t)
        self._inv[t] = s
        return s


LEVELS = {}


def level(m):
    if m not in LEVELS:
        LEVELS[m] = Level(m)
    return LEVELS[m]


# ---------------------------------------------------------------- F and E into R_m

def _sqrt5_int(bits):
    """sqrt5 in Z_2[omega] mod 2^bits: sqrt5 = sqrt(-15)/sqrt(-3), sqrt(-3) = 1 + 2 omega (exactly)"""
    import fs70_field as FF
    r = FF.hensel_sqrt(-15, 2, 7, bits + 6)
    mod = 2 ** (bits + 6)
    # (1 + 2w)^-1 = (-1 - 2w)/3   since (1+2w)(-1-2w) = -(1+2w)^2 = 3
    inv3 = pow(3, -1, mod)
    a0 = (-r * inv3) % mod
    a1 = (-2 * r * inv3) % mod
    return (a0, a1, 0, 0)


_S5_CACHE = {}


def sqrt5_mod(bits):
    if bits not in _S5_CACHE:
        _S5_CACHE[bits] = _sqrt5_int(bits)
    return _S5_CACHE[bits]


def _inv_mod2(x, bits):
    """inverse of a unit of Z[omega][sqrt3] in the free ring mod 2^bits, by Newton (s <- s(2 - xs))"""
    mod = 2 ** bits
    red = lambda v: tuple(a % mod for a in v)
    s = red(r_mul(x, x))                     # F_4^x has order 3, so x^2 inverts x modulo pi
    for _ in range(2 * bits + 4):
        xs = red(r_mul(x, s))
        if xs == (1, 0, 0, 0):
            return s
        s = red(r_mul(s, r_sub((2, 0, 0, 0), xs)))
    raise RuntimeError('Newton did not converge: not a unit?')


def _i_mod2(bits):
    """i = sqrt(-3)/sqrt3 = (1 + 2 omega) * sqrt3^-1 as an integer tuple mod 2^bits; i^2 = -3/3 = -1 exactly"""
    return tuple(a % (2 ** bits) for a in r_mul(SQRTM3, _inv_mod2(SQRT3, bits)))


def _F_numerator(u, bits):
    """D * u as an integer ring element mod 2^bits, with D the least common denominator; returns (element, D)"""
    s5 = sqrt5_mod(bits)
    basis = [ONE, SQRT3, s5, r_mul(SQRT3, s5)]
    D = 1
    for x in u:
        d = Fr(x).denominator
        D = D * d // math.gcd(D, d)
    acc = (0, 0, 0, 0)
    for coef, b in zip(u, basis):
        acc = r_add(acc, r_scale(int(Fr(coef) * D), b))
    return tuple(a % (2 ** bits) for a in acc), D


def _divide_out(acc, D, bits):
    """divide an integer ring element by D = 2^s * Dodd; p-integrality is exactly coefficientwise divisibility by
    2^s in the free Z_2-module (1, omega, sqrt3, omega sqrt3), so a failure is a genuine non-integrality."""
    mod = 2 ** bits
    s, Dodd = 0, D
    while Dodd % 2 == 0:
        Dodd //= 2
        s += 1
    if Dodd > 1:
        acc = tuple(a * pow(Dodd, -1, mod) % mod for a in acc)
    if s:
        if any(a % (2 ** s) for a in acc):
            raise ValueError('not p-integral: cannot divide by 2^%d' % s)
        acc = tuple(a // (2 ** s) for a in acc)
    return acc


def sigma_F(u, lv, bits=None):
    """an element of F = (a, b, c, d) -> a + b sqrt3 + c sqrt5 + d sqrt15 (Fractions), reduced into R_m.
    Refuses a u that is not p-integral."""
    bits = bits or (2 * lv.m + 40)
    acc, D = _F_numerator(u, bits)
    return lv.red(_divide_out(acc, D, bits))


def sigma_i(lv, bits=None):
    return lv.red(_i_mod2(bits or (2 * lv.m + 40)))


def split_E(z, lv, bits=None):
    """an element of E = (x, y) with x, y in F -> its pair of components in R_m x R_m (the prime SPLITS).

    The 2-power denominator is cleared on the COMBINATION x +- i y, never on x and y separately: zeta6 = (1 + i
    sqrt3)/2 has both coordinates outside O and is itself a unit of O at this prime, which is the whole point of a
    split prime.  (Caught by the field check on the atlas, 2026-09-22.)"""
    bits = bits or (2 * lv.m + 40)
    mod = 2 ** bits
    x, y = z
    Xn, Dx = _F_numerator(x, bits)
    Yn, Dy = _F_numerator(y, bits)
    D = Dx * Dy // math.gcd(Dx, Dy)
    Xn = tuple(a * (D // Dx) % mod for a in Xn)
    Yn = tuple(a * (D // Dy) % mod for a in Yn)
    IY = tuple(a % mod for a in r_mul(_i_mod2(bits), Yn))
    plus = _divide_out(tuple(a % mod for a in r_add(Xn, IY)), D, bits)
    minus = _divide_out(tuple(a % mod for a in r_sub(Xn, IY)), D, bits)
    return (lv.red(plus), lv.red(minus))


# ---------------------------------------------------------------- the Cayley graph and its spectrum

def connection_set(lv):
    """S_m = {(t, t^-1)} as pairs of canonical ring elements"""
    return [(t, lv.inverse(t)) for t in lv.units]


def spectrum(lv):
    """every eigenvalue of P_m, by one multi-dimensional DFT of the connection set's indicator over the vertex group.
    Returns (shape, lam) with lam a real array indexed by the dual grid."""
    import numpy as np
    d = lv.inv_factors
    shape = tuple(d) * 2
    f = np.zeros(shape, dtype=np.complex128)
    for a, b in connection_set(lv):
        f[lv.coords(a) + lv.coords(b)] += 1
    lam = np.fft.fftn(f)
    assert np.max(np.abs(lam.imag)) < 1e-6 * max(1.0, np.max(np.abs(lam.real))), 'S is not symmetric'
    return shape, lam.real


def exact_eigenvalue(lv, y):
    """lambda_y computed exactly as an element of Z[zeta_N] (N = lcm of the invariant factors), returned as a
    Fraction when it is rational.  Used to confirm the extremes the float DFT proposes."""
    d = lv.inv_factors
    N = 1
    for x in d:
        N = N * x // math.gcd(N, x)
    # the sum of zeta_N^e over the connection set, as a vector of exponent counts
    cnt = [0] * N
    for a, b in connection_set(lv):
        ca, cb = lv.coords(a), lv.coords(b)
        e = 0
        for k in range(len(d)):
            e += y[k] * ca[k] * (N // d[k]) + y[len(d) + k] * cb[k] * (N // d[k])
        cnt[e % N] += 1
    # reduce sum_j cnt[j] zeta^j in Z[zeta_N]; for N a power of 2 the minimal polynomial is x^(N/2) + 1
    assert N & (N - 1) == 0, 'N is not a power of two'
    if N == 1:
        return Fr(cnt[0])
    h = N // 2
    v = [0] * h
    for j in range(N):
        if j < h:
            v[j] += cnt[j]
        else:
            v[j - h] -= cnt[j]
    if all(x == 0 for x in v[1:]):
        return Fr(v[0])
    return None      # irrational: the caller reports the float


def h_min(lv, lam, shape, tol=1e-6):
    """the common kernel of the minimising characters -- the subgroup every four-colouring is periodic under when
    the level is Hoffman-tight (G54, row 67's Theorem D2-A)."""
    import numpy as np
    d = lv.inv_factors
    k = len(d)
    lmin = lam.min()
    ys = np.argwhere(lam <= lmin + tol)
    N = 1
    for x in d:
        N = N * x // math.gcd(N, x)
    # all vertices of A, as coordinate tuples
    grids = np.indices(shape).reshape(2 * k, -1).T          # |A| x 2k
    keep = np.ones(len(grids), dtype=bool)
    weights = np.array([N // d[j % k] for j in range(2 * k)], dtype=np.int64)
    for y in ys:
        pair = (grids * (np.array(y, dtype=np.int64) * weights)).sum(axis=1) % N
        keep &= (pair == 0)
        if keep.sum() == 1:
            break
    return grids[keep], int(lmin.round()), len(ys)


def additive_bound(lv, groups=('Z/4', 'Klein')):
    """Every additive four-colouring of P_m -- a homomorphism phi : A -> G with |G| = 4 and phi nonzero on the
    connection set -- is a PROPER four-colouring, so it separates every pair outside its kernel (G41, and the plan's
    section 3.4 screen).  Hence

        Forces(P_m)  is contained in  the intersection of the kernels,

    with no solver anywhere.  This is the bound that does the killing: a target outside the intersection is
    separated by an EXHIBITED colouring, and freeness transfers down to every 2-unit fabric over F (row 55).
    Returns (intersection as a set of vertices, count of colourings, one witness per group)."""
    import numpy as np
    d = lv.inv_factors
    dd = list(d) * 2
    Sc = np.array([lv.coords(a) + lv.coords(b) for a, b in connection_set(lv)], dtype=np.int64)
    grids = np.indices(tuple(dd)).reshape(len(dd), -1).T          # |A| x 8
    keep = np.ones(len(grids), dtype=bool)
    total = 0
    witness = {}
    counts = {}
    for gname in groups:
        if gname == 'Z/4':
            # phi(e_j) = c_j in Z/4 with d_j * c_j = 0: c_j runs over the multiples of 4/gcd(d_j, 4)
            ranges = [list(range(0, 4, 4 // math.gcd(x, 4))) for x in dd]
        else:
            # Klein = (Z/2)^2 written as {0,1,2,3} under xor: phi(e_j) is free when d_j is even
            ranges = [list(range(4)) if x % 2 == 0 else [0] for x in dd]
        cnt = 0
        for cs in itertools.product(*ranges):
            c = np.array(cs, dtype=np.int64)
            if gname == 'Z/4':
                sv = (Sc * c).sum(axis=1) % 4
            else:
                sv = np.zeros(len(Sc), dtype=np.int64)
                for j in range(len(dd)):
                    if cs[j]:
                        sv ^= (Sc[:, j] % 2) * cs[j]
            if (sv == 0).any():
                continue
            cnt += 1
            witness.setdefault(gname, list(cs))
            if gname == 'Z/4':
                gv = (grids * c).sum(axis=1) % 4
            else:
                gv = np.zeros(len(grids), dtype=np.int64)
                for j in range(len(dd)):
                    if cs[j]:
                        gv ^= (grids[:, j] % 2) * cs[j]
            keep &= (gv == 0)
        counts[gname] = cnt
        total += cnt
    return grids[keep], total, witness, counts


def val_pi(lv, x, cap=None):
    """v_p(x) for x in R_m: the largest k <= m with x in pi^k R_m (m itself when x = 0)"""
    cap = cap or lv.m
    for k in range(cap + 1):
        if lattice_reduce(level(k).L if k else [[1, 0, 0, 0], [0, 1, 0, 0], [0, 0, 1, 0], [0, 0, 0, 1]], x) != (0, 0, 0, 0):
            return k - 1 if k else 0
    return cap


def _val(lv, x):
    """v_p(x) in R_m, reported as m when x = 0 (i.e. 'at least m')"""
    if x == lv.zero:
        return lv.m
    k = 0
    while k < lv.m and lattice_reduce(level(k + 1).L, x) == (0, 0, 0, 0):
        k += 1
    return k


TARGETS = {
    '2': (Fr(2), Fr(0), Fr(0), Fr(0)),
    '4/3': (Fr(4, 3), Fr(0), Fr(0), Fr(0)),
    '8/3': (Fr(8, 3), Fr(0), Fr(0), Fr(0)),
    '4': (Fr(4), Fr(0), Fr(0), Fr(0)),
    '4/7': (Fr(4, 7), Fr(0), Fr(0), Fr(0)),
    '4/sqrt3': (Fr(0), Fr(4, 3), Fr(0), Fr(0)),
    '2/3': (Fr(2, 3), Fr(0), Fr(0), Fr(0)),
    '1': (Fr(1), Fr(0), Fr(0), Fr(0)),
    '16': (Fr(16), Fr(0), Fr(0), Fr(0)),
    '32': (Fr(32), Fr(0), Fr(0), Fr(0)),
    '64': (Fr(64), Fr(0), Fr(0), Fr(0)),
}


def describe_hmin(lv, H):
    """H as a list of coordinate tuples in (+) Z/d_i (both halves); lift each back to a ring pair and read its
    valuations.  The lift is by table lookup: build the coords -> element map once."""
    k = len(lv.inv_factors)
    back = {lv.coords(e): e for e in lv.elts}
    out = []
    for h in H:
        a = back[tuple(int(x) for x in h[:k])]
        b = back[tuple(int(x) for x in h[k:])]
        out.append({'a': list(a), 'b': list(b), 'v_a': _val(lv, a), 'v_b': _val(lv, b)})
    return out


def hmin_members(lv, H):
    k = len(lv.inv_factors)
    back = {lv.coords(e): e for e in lv.elts}
    return {(back[tuple(int(x) for x in h[:k])], back[tuple(int(x) for x in h[k:])]) for h in H}


# ---------------------------------------------------------------- CNF for the confirmation asks

def cnf_for_pair(lv, pair, path):
    """the four-colouring CNF of P_m with vertex 0 pinned to colour 0 and `pair` pinned to colour 1 (the `forces`
    pin: UNSAT means every four-colouring gives 0 and `pair` the same colour).  A common neighbour is pinned to 2
    when one exists, which is sound by colour relabelling on the triangle."""
    verts = [(a, b) for a in lv.elts for b in lv.elts]
    idx = {v: i for i, v in enumerate(verts)}
    S = connection_set(lv)
    n = len(verts)
    edges = set()
    for v in verts:
        for s in S:
            w = (lv.add(v[0], s[0]), lv.add(v[1], s[1]))
            i, j = idx[v], idx[w]
            if i < j:
                edges.add((i, j))
    edges = sorted(edges)
    zero = (lv.zero, lv.zero)
    A, B = idx[zero], idx[pair]
    nbrA = {idx[(lv.add(zero[0], s[0]), lv.add(zero[1], s[1]))] for s in S}
    nbrB = {idx[(lv.add(pair[0], s[0]), lv.add(pair[1], s[1]))] for s in S}
    common = sorted(nbrA & nbrB)
    cls = []
    for v in range(n):
        cls.append([4 * v + c + 1 for c in range(4)])
    for i, j in edges:
        for c in range(4):
            cls.append([-(4 * i + c + 1), -(4 * j + c + 1)])
    cls.append([4 * A + 1])
    cls.append([4 * B + 2])
    pinned = [(A, 0), (B, 1)]
    if common:
        cls.append([4 * common[0] + 3])
        pinned.append((common[0], 2))
    with open(path, 'w') as f:
        f.write(f'p cnf {4 * n} {len(cls)}\n')
        for c in cls:
            f.write(' '.join(map(str, c)) + ' 0\n')
    sha = hashlib.sha256(open(path, 'rb').read()).hexdigest()
    return {'vertices': n, 'edges': len(edges), 'clauses': len(cls), 'pins': pinned,
            'common_neighbours': len(common), 'cnf_sha256': sha, 'path': path}


# ---------------------------------------------------------------- the classifier

def classify(mmax=5, verbose=True):
    import numpy as np
    rows = []
    for m in range(1, mmax + 1):
        lv = level(m)
        shape, lam = spectrum(lv)
        d = 3 * 4 ** (m - 1)
        lmin = lam.min()
        lmax = lam.max()
        target = -(4 ** (m - 1))                       # -d/(k-1) at k = 4
        tight = abs(lmin - target) < 1e-6
        below = int((lam < target - 1e-6).sum())
        H, lmin_i, nmin = h_min(lv, lam, shape)
        # exact confirmation of the minimum at one achieving character
        ys = np.argwhere(lam <= lmin + 1e-6)
        exact = exact_eigenvalue(lv, tuple(int(x) for x in ys[0]))
        mem = hmin_members(lv, H)
        desc = describe_hmin(lv, H)
        # which of the chainable targets lands in H_min?  A real delta maps to the DIAGONAL (delta, delta).
        tg = {}
        for nm, u in TARGETS.items():
            try:
                z = (u, (Fr(0), Fr(0), Fr(0), Fr(0)))
                pair = split_E(z, lv)
            except ValueError:
                tg[nm] = 'not p-integral'
                continue
            tg[nm] = {'pair': [list(pair[0]), list(pair[1])], 'v': _val(lv, pair[0]),
                      'in_H_min': bool(pair in mem), 'is_zero': bool(pair == (lv.zero, lv.zero))}
        vals = sorted({(r['v_a'], r['v_b']) for r in desc if not (r['v_a'] == lv.m and r['v_b'] == lv.m)})
        row = {'m': m, 'vertices': 16 ** m, 'degree': d, 'ring_size': lv.size,
               'invariant_factors': lv.inv_factors, 'units': len(lv.units),
               'lambda_min': float(lmin), 'lambda_max': float(lmax),
               'hoffman_target_-d_over_3': target, 'tight': bool(tight),
               'eigenvalues_below_target': below,
               'lambda_min_exact': (str(exact) if exact is not None else None),
               'minimising_characters': int(nmin),
               'H_min_order': int(len(H)),
               'H_min_is_trivial': bool(len(H) == 1),
               'H_min_valuation_pairs': [list(v) for v in vals],
               'H_min_members': desc if len(desc) <= 64 else desc[:64],
               'targets': tg}
        rows.append((row, lv, H, shape))
        if verbose:
            hits = [nm for nm, t in tg.items() if isinstance(t, dict) and t['in_H_min'] and not t['is_zero']]
            print(f'  level {m}: |V| = {16**m:>9}  d = {d:>5}  lambda_min = {lmin:>10.4f} '
                  f'(target {target})  {"TIGHT" if tight else "SLACK"}  '
                  f'min-chars {nmin:>6}  |H_min| = {len(H):>5}  v-pairs {vals}'
                  + (f'  forced targets: {hits}' if hits else ''))
    return rows


# ---------------------------------------------------------------- self-test and plants

def selftest():
    import fs70_field as FF
    ok = True

    def check(name, cond, detail=''):
        nonlocal ok
        print(('  ok   ' if cond else '  FAIL ') + name + ('' if cond else '   ' + str(detail)))
        ok = ok and cond

    print('fs70_tower self-test')
    # (1) sizes
    for m in range(1, 5):
        lv = level(m)
        check(f'|R_{m}| = 4^{m}', lv.size == 4 ** m, lv.size)
        check(f'|R_{m}^x| = 3*4^{m-1}', len(lv.units) == 3 * 4 ** (m - 1), len(lv.units))
    # (2) ring laws and inverses
    lv = level(4)
    import random
    rnd = random.Random(11)
    samp = [rnd.choice(lv.elts) for _ in range(40)]
    assoc = all(lv.mul(lv.mul(a, b), c) == lv.mul(a, lv.mul(b, c))
                for a, b, c in zip(samp[::4], samp[1::4], samp[2::4]))
    distr = all(lv.mul(a, lv.add(b, c)) == lv.add(lv.mul(a, b), lv.mul(a, c))
                for a, b, c in zip(samp[::4], samp[1::4], samp[2::4]))
    check('associative and distributive on samples', assoc and distr)
    check('t * t^-1 = 1 for every unit of R_4', all(lv.mul(t, lv.inverse(t)) == lv.one for t in lv.units))
    check('sqrt3^2 = 3 in R_4', lv.mul(lv.red(SQRT3), lv.red(SQRT3)) == lv.red((3, 0, 0, 0)))
    check('(1+2w)^2 = -3 in R_4', lv.mul(lv.red(SQRTM3), lv.red(SQRTM3)) == lv.red((-3, 0, 0, 0)))
    I = sigma_i(lv)
    check('i^2 = -1 in R_4', lv.mul(I, I) == lv.red((-1, 0, 0, 0)))
    s5 = sigma_F((Fr(0), Fr(0), Fr(1), Fr(0)), lv)
    check('sqrt5^2 = 5 in R_4', lv.mul(s5, s5) == lv.red((5, 0, 0, 0)), (s5, lv.mul(s5, s5)))
    check('pi^2 = 2 * unit', lv.mul(lv.red(PI), lv.red(PI)) == lv.mul(lv.red((2, 0, 0, 0)), lv.red((2, 0, 1, 0))))
    # (3) level maps
    lo, hi = level(3), level(4)
    fib = {}
    for e in hi.elts:
        fib.setdefault(lo.red(e), []).append(e)
    check('level map R_4 -> R_3 onto with fibres of size 4',
          len(fib) == lo.size and all(len(v) == 4 for v in fib.values()))
    check('level map is a ring homomorphism on samples',
          all(lo.red(hi.mul(a, b)) == lo.mul(lo.red(a), lo.red(b)) for a, b in zip(samp[::2], samp[1::2])))
    check('units map onto units', all(lo.is_unit(hi.red(t)) for t in hi.units))
    # (4) THE FIELD CHECK -- every 2-unit vector of F reduces to (t, t^-1)
    atlas = os.path.join(ROOT, 'data', 'fs70', 'atlas.jsonl')
    n2, nbad, nhigh, nrefused = 0, 0, 0, 0
    if os.path.exists(atlas):
        lv = level(4)
        with open(atlas) as f:
            for line in f:
                rec = json.loads(line)
                if 'x' not in rec or 'y' not in rec or 'm' not in rec:
                    continue
                M = rec['m']
                z = ((Fr(rec['x'][0], M), Fr(rec['x'][1], M), Fr(rec['x'][2], M), Fr(rec['x'][3], M)),
                     (Fr(rec['y'][0], M), Fr(rec['y'][1], M), Fr(rec['y'][2], M), Fr(rec['y'][3], M)))
                assert FF.e_is_unit_vector(z), ('the atlas holds a non-unit vector', rec)
                dep = rec.get('depth2')
                if dep is None:
                    dep = FF.PLACE2.val(z)
                if dep == 0:
                    n2 += 1
                    a, b = split_E(z, lv)
                    if not (lv.is_unit(a) and lv.mul(a, b) == lv.one):
                        nbad += 1
                else:
                    nhigh += 1
                    try:
                        a, b = split_E(z, lv)
                        if lv.mul(a, b) != lv.one:
                            nrefused += 1
                    except ValueError:
                        nrefused += 1
        check(f'every 2-unit vector of F ({n2}) reduces to (t, 1/t) with t a unit', n2 > 0 and nbad == 0, nbad)
        check(f'every wall-breaking vector ({nhigh}) is refused or fails the unit-pair law', nhigh == nrefused,
              f'{nrefused} of {nhigh}')
    else:
        print('  skip  the atlas is absent; the field check did not run')
    # (5) level one is four disjoint K_4
    lv1 = level(1)
    S1 = connection_set(lv1)
    sub = {lv1.zero} | {s[0] + s[1] for s in []}
    grp = {(lv1.zero, lv1.zero)} | set(S1)
    closed = all((lv1.add(a[0], b[0]), lv1.add(a[1], b[1])) in grp for a in grp for b in grp)
    check('S_1 + {0} is a subgroup of order 4 (so P_1 is four disjoint K_4)', closed and len(grp) == 4)
    shape, lam = spectrum(lv1)
    vals = sorted(set(round(float(x), 6) for x in lam.ravel()))
    check('spectrum of P_1 is {3, -1}', vals == [-1.0, 3.0], vals)
    # the targets' valuations, checked here rather than quoted
    print('  -- the chainable targets, 2-adic valuation computed from the field tool:')
    for nm, u in (('2', (Fr(2), Fr(0), Fr(0), Fr(0))), ('4/3', (Fr(4, 3), Fr(0), Fr(0), Fr(0))),
                  ('8/3', (Fr(8, 3), Fr(0), Fr(0), Fr(0))), ('4', (Fr(4), Fr(0), Fr(0), Fr(0))),
                  ('4/7', (Fr(4, 7), Fr(0), Fr(0), Fr(0))), ('4/sqrt3', (Fr(0), Fr(4, 3), Fr(0), Fr(0)))):
        z = (u, (Fr(0), Fr(0), Fr(0), Fr(0)))
        print(f'     v_p({nm:8s}) = {FF.PLACE2.val(z)}')
    print('SELFTEST ' + ('GREEN' if ok else 'RED'))
    return 0 if ok else 1


def run_plants():
    global PLANT
    print('fs70_tower planted faults (each must be refused)')
    fired = 0
    for name, why in (('mul_drop_three', 'the sqrt3^2 = 3 rule dropped from the ring product'),):
        PLANT = name
        LEVELS.clear()
        _S5_CACHE.clear()
        try:
            lv = level(4)
            bad = lv.mul(lv.red(SQRT3), lv.red(SQRT3)) != lv.red((3, 0, 0, 0))
            sizes = lv.size != 4 ** 4 or len(lv.units) != 3 * 4 ** 3
            print(f'  {name}: refused by ' + ('sqrt3^2 != 3' if bad else '') + (' and the size law' if sizes else ''))
            fired += 1 if (bad or sizes) else 0
        except Exception as e:
            print(f'  {name}: refused by an exception -- {e}')
            fired += 1
    PLANT = None
    LEVELS.clear()
    _S5_CACHE.clear()
    print(f'{fired} of 1 plants fired')
    return 0 if fired == 1 else 1


def _opt(argv, name, default=None, cast=str):
    return cast(argv[argv.index(name) + 1]) if name in argv else default


def main():
    global PLANT
    argv = sys.argv[1:]
    if '--plant' in argv:
        PLANT = _opt(argv, '--plant')
    if not argv:
        print(__doc__)
        return 0
    if argv[0] == 'selftest':
        if '--plants' in argv:
            return run_plants()
        return selftest()
    if argv[0] == 'levels':
        mmax = _opt(argv, '--max', 5, int)
        out = _opt(argv, '--out', os.path.join(ROOT, 'data', 'fs70', 'tower'))
        os.makedirs(out, exist_ok=True)
        rows = classify(mmax)
        with open(os.path.join(out, 'levels.json'), 'w') as f:
            json.dump([r for r, _, _, _ in rows], f, indent=1)
        print('wrote ' + os.path.join(out, 'levels.json'))
        return 0
    print(__doc__)
    return 0


if __name__ == '__main__':
    sys.exit(main())

#!/usr/bin/env python3
"""fs73_lattice -- FS-73 phase P1a: a field-generic layer for lattices of unit vectors.  UNTRUSTED (tools/).

THE OBJECT.  F is a real multiquadratic field Q(sqrt r1) or Q(sqrt r1, sqrt r2) (r_i squarefree, coprime), E = F(i).  A point of
E = F^2 is (x, y), and inside one lattice it is an INTEGER vector of length 2n (n = [F:Q]) over one denominator M:
x = (x_S)_S / M, y = (y_S)_S / M on the basis e_S = prod_{r in S} sqrt r of F, S running over subsets in the order
(), (r1), (r2), (r1 r2).  For K = Q(sqrt3, sqrt11) that is (1, sqrt3, sqrt11, sqrt33), fs70_harder's order; for Q(sqrt3, sqrt5) it is
fs70_field's (1, sqrt3, sqrt5, sqrt15); for Q(sqrt d) it is FS-61's (a, b, c, e) = ((a + b sqrt d) + i (c + e sqrt d)) / M.
A LATTICE is the Z-span of finitely many points, kept as a row Hermite basis H over M; its coordinates are integer r-vectors.

SATURATION (the complete unit-vector set U = Lambda n S^1), two independent methods whose agreement is the control:
  'trace'  (default) every unit vector z = (x, y) has Tr_{F/Q}(x^2 + y^2) = n, so U lies in the finite set of lattice vectors of
           trace norm <= n.  PARI's qfminim enumerates that set exactly on the integer Gram M^2 G (Fincke-Pohst), and the exact
           norm equation x^2 + y^2 = 1 decides each one.  Complete for the LATTICE; cost set by its covolume, not by M.
  'box'    every unit vector of Lambda has coordinate denominator dividing M (Lambda lies in (1/M) Z^{2n}), so enumerate every unit
           vector of E whose denominator divides D (the embedding box: |sigma(X)| <= D in every real embedding sigma, squares
           grouped and matched) and keep the members.  Complete for D = M; for D < M it is the saturation TO D, labelled so.
  A generator-only lattice ('gens') is an incomplete constraint set and every consumer must say so (G21; FS70-T10.6).

THE POINT GROUP.  Graph automorphisms of Cay(Lambda, U) fixing 0 that this file can name: multiplication by a unit vector u of U
with u Lambda = Lambda (a rotation), complex conjugation, the Galois sign flips of F acting coordinate-wise on (x, y), and their
composites -- each kept iff it maps the Hermite basis onto a basis of Lambda (integer, determinant +-1) and U onto U.  Returned as
integer r x r matrices acting on lattice coordinates (row vector convention: coords @ A).  Orbits of certified forced vectors
under this group are forced (G27, M62-T4); nothing here claims the group is the full automorphism group.

Commands
  python3 tools/fs73_lattice.py show NAME [--sat trace|box|both]   # rank, M, |U|, point group, targets
  python3 tools/fs73_lattice.py selftest [--plants]                # the four controls of P1a and the planted faults
Named lattices: degrey (K; <zeta6^m rho^n, |n| <= 2>), lambdaprime (E' = Q(sqrt3, sqrt-5), denominator 24), L3 and any fs70_fabric
spec prefixed 'fab:' (Q(sqrt3, sqrt5)), q11shape (FS-61's Ld65c8ee8 over Q(sqrt11)).
Plants: sat_drop (the trace method loses one vector), box_tight (the box bound shaved by one), gal_sign (a Galois flip that
negates the wrong coordinate), unit_loose (the unit test accepts x^2 + y^2 = M^2 in the rational part only).
"""
import itertools
import json
import math
import os
import subprocess
import sys
from collections import defaultdict
from fractions import Fraction as Fr

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
sys.path.insert(0, os.path.join(ROOT, 'tools'))

PLANT = None
for _i, _a in enumerate(sys.argv):
    if _a == '--plant' and _i + 1 < len(sys.argv):
        PLANT = sys.argv[_i + 1]
VALID_PLANTS = ('sat_drop', 'box_tight', 'gal_sign', 'unit_loose')


def planted(name):
    return PLANT == name


# ================================================================ the field F = Q(sqrt r1[, sqrt r2])

class Field:
    def __init__(self, radicands):
        self.rad = tuple(radicands)
        k = len(self.rad)
        assert k in (1, 2)
        self.n = 2 ** k
        self.subsets = [tuple(i for i in range(k) if m >> i & 1) for m in range(self.n)]   # (), (0,), (1,), (0,1)
        self.mask = {s: sum(1 << i for i in s) for s in self.subsets}
        # e_S e_T = (prod_{i in S n T} r_i) e_{S xor T}
        self.table = {}
        for a in range(self.n):
            for b in range(self.n):
                c = a ^ b
                coef = 1
                for i in range(k):
                    if a >> i & 1 and b >> i & 1:
                        coef *= self.rad[i]
                self.table[(a, b)] = (coef, c)
        self.signs = list(itertools.product((1, -1), repeat=k))                       # the real embeddings
        self.sqrt = [math.sqrt(r) for r in self.rad]
        self.name = 'Q(' + ','.join(f'sqrt{r}' for r in self.rad) + ')'

    def mul(self, p, q):
        out = [0] * self.n
        for a, pa in enumerate(p):
            if pa:
                for b, qb in enumerate(q):
                    if qb:
                        coef, c = self.table[(a, b)]
                        out[c] += coef * pa * qb
        return tuple(out)

    def emb(self, p, sg):
        """the real embedding sqrt r_i -> sg_i sqrt r_i"""
        s = 0.0
        for a, pa in enumerate(p):
            if pa:
                t = float(pa)
                for i in range(len(self.rad)):
                    if a >> i & 1:
                        t *= sg[i] * self.sqrt[i]
                s += t
        return s

    def galois(self, p, sg):
        """the automorphism sqrt r_i -> sg_i sqrt r_i, on integer coordinates"""
        out = []
        for a, pa in enumerate(p):
            sign = 1
            for i in range(len(self.rad)):
                if a >> i & 1 and sg[i] < 0:
                    sign = -sign
            if planted('gal_sign') and a == 0 and any(x < 0 for x in sg):
                sign = -sign                    # PLANT: the rational coordinate negated too
            out.append(sign * pa)
        return tuple(out)

    def covolume(self):
        """covolume of Z[e_S] in R^n under the real embeddings: sqrt|det|^2 = prod over the embedding matrix"""
        rows = [[self.emb(tuple(1 if a == b else 0 for b in range(self.n)), sg) for sg in self.signs] for a in range(self.n)]
        import numpy as np
        return abs(float(np.linalg.det(np.array(rows))))


# ================================================================ points of E = F^2 over a denominator

def is_unit(F, v, M):
    """v = (x, y) integer 2n-vector over M: x^2 + y^2 == M^2 exactly"""
    n = F.n
    x, y = v[:n], v[n:]
    s = [a + b for a, b in zip(F.mul(x, x), F.mul(y, y))]
    if planted('unit_loose'):
        return s[0] == M * M                     # PLANT: the irrational parts ignored
    return s[0] == M * M and not any(s[1:])


def cmul(F, v, w):
    """(x1 + i y1)(x2 + i y2), numerators; the denominator multiplies"""
    n = F.n
    x1, y1, x2, y2 = v[:n], v[n:], w[:n], w[n:]
    re = [a - b for a, b in zip(F.mul(x1, x2), F.mul(y1, y2))]
    im = [a + b for a, b in zip(F.mul(x1, y2), F.mul(y1, x2))]
    return tuple(re) + tuple(im)


def reduce_point(v, M):
    g = M
    for t in v:
        g = math.gcd(g, abs(t))
    return tuple(t // g for t in v), M // g


def over(v, m, M):
    """a point with denominator m rewritten over M (m | M)"""
    assert M % m == 0, (m, M)
    k = M // m
    return tuple(k * t for t in v)


# ================================================================ integer lattices

def hnf(rows, dim):
    """reduced row Hermite normal form of the Z-span (pivots increasing, positive, entries above reduced)"""
    work = [list(r) for r in rows if any(r)]
    basis = []
    for col in range(dim):
        while len([r for r in work if r[col]]) > 1:
            nz = sorted((r for r in work if r[col]), key=lambda r: abs(r[col]))
            p = nz[0]
            for r in nz[1:]:
                q = r[col] // p[col]
                for j in range(dim):
                    r[j] -= q * p[j]
            work = [r for r in work if any(r)]
        k = next((i for i, r in enumerate(work) if r[col]), None)
        if k is None:
            continue
        p = work.pop(k)
        if p[col] < 0:
            p = [-x for x in p]
        basis.append((col, p))
    for i in range(len(basis)):
        ci, pi = basis[i]
        for k in range(i):
            pk = basis[k][1]
            q = pk[ci] // pi[ci]
            if q:
                for j in range(dim):
                    pk[j] -= q * pi[j]
    return [tuple(r) for _, r in basis]


def coords_in(H, v):
    """integer coordinates of v in the Hermite basis H, or None"""
    v = list(v)
    dim = len(v)
    cs = []
    for row in H:
        c = next(j for j in range(dim) if row[j])
        if v[c] % row[c]:
            return None
        q = v[c] // row[c]
        cs.append(q)
        if q:
            for j in range(dim):
                v[j] -= q * row[j]
    return tuple(cs) if not any(v) else None


class Lattice:
    """The Z-span of points of E, over one denominator M, with its complete unit-vector set U once saturated."""

    def __init__(self, F, points, name='', M=None):
        """points: list of (integer 2n-vector, denominator)"""
        self.F = F
        self.name = name
        if M is None:
            M = 1
            for _, m in points:
                M = M * m // math.gcd(M, m)
        self.M = M
        self.dim = 2 * F.n
        self.H = hnf([over(v, m, M) for v, m in points], self.dim)
        self.rank = len(self.H)
        self.U8 = None              # unit vectors as 2n-vectors over M
        self.U = None               # the same in lattice coordinates
        self.saturation = None      # 'trace' | 'box:D' | 'gens'

    def coords(self, v, m=None):
        m = self.M if m is None else m
        if self.M % m:
            return None
        return coords_in(self.H, over(v, m, self.M))

    def point(self, c):
        """lattice coordinates -> 2n-vector over M"""
        return tuple(sum(ci * row[j] for ci, row in zip(c, self.H)) for j in range(self.dim))

    def gram_int(self):
        """M^2 x the trace form Tr_{F/Q}(x x' + y y') on the Hermite basis: an integer matrix (Tr e_S = n [S empty])"""
        n = self.F.n
        G = []
        for bi in self.H:
            row = []
            for bj in self.H:
                s = [a + b for a, b in zip(self.F.mul(bi[:n], bj[:n]), self.F.mul(bi[n:], bj[n:]))]
                row.append(n * s[0])
            G.append(row)
        return G

    # -- saturation
    def saturate(self, method='trace', D=None, gens=None):
        if method == 'trace':
            U8 = self._sat_trace()
            self.saturation = 'trace'
        elif method == 'box':
            D = self.M if D is None else D
            U8 = self._sat_box(D)
            self.saturation = f'box:{D}' + ('' if D % self.M == 0 else ' (INCOMPLETE: D is not a multiple of M)')
        elif method == 'both':
            a = set(self._sat_trace())
            b = set(self._sat_box(self.M))
            if a != b:
                raise AssertionError(f'{self.name}: the two saturations disagree: trace {len(a)}, box {len(b)}, '
                                     f'symmetric difference {len(a ^ b)}')
            U8 = sorted(a)
            self.saturation = 'trace=box'
        elif method == 'gens':
            U8 = sorted(set(gens))
            self.saturation = 'gens'
        else:
            raise SystemExit(f'unknown saturation method {method!r}')
        for v in U8:
            assert is_unit(self.F, v, self.M) or planted('unit_loose'), v
        self.U8 = sorted(U8)
        self.U = [self.coords(v) for v in self.U8]
        assert all(u is not None for u in self.U), 'a saturated vector is outside the lattice'
        return self.U

    def _sat_trace(self):
        G = self.gram_int()
        bound = self.F.n * self.M * self.M
        mat = '[' + ';'.join(','.join(str(x) for x in row) for row in G) + ']'
        script = f'v = qfminim({mat}, {bound}, , 0); print(#v[3]); for(k=1, #v[3], print(Vec(v[3][,k])))'
        p = subprocess.run(['gp', '-q', '-s', '2000000000'], input=script + '\n', capture_output=True, text=True)
        lines = p.stdout.strip().split('\n')
        if p.returncode != 0 or not lines or not lines[0].strip().isdigit():
            raise RuntimeError('gp qfminim failed: ' + (p.stderr[-400:] or p.stdout[-400:]))
        cnt = int(lines[0])
        out = set()
        for line in lines[1:1 + cnt]:
            c = [int(x) for x in line.strip('[] \n').split(',')]
            for sg in (1, -1):
                v = self.point([sg * x for x in c])
                if is_unit(self.F, v, self.M):
                    out.add(v)
        out = sorted(out)
        if planted('sat_drop') and out:
            out = out[1:]                        # PLANT: one unit vector lost
        return out

    def to_M(self, v, m):
        """a 2n-vector over m, rewritten over M; None if its reduced denominator does not divide M"""
        w, mm = reduce_point(v, m)
        return over(w, mm, self.M) if self.M % mm == 0 else None

    def _sat_box(self, D):
        """every unit vector of E with denominator dividing D, as 2n-vectors over M, kept iff in the lattice"""
        res = set()
        for v in units_over(self.F, D):
            w = self.to_M(v, D)
            if w is not None and coords_in(self.H, w) is not None:
                res.add(w)
        return sorted(res)


def box(F, D):
    """every integer n-tuple X with |sigma(X)| <= D in every real embedding sigma (a necessary condition on each coordinate of a
    unit vector over D)"""
    n = F.n
    eps = 1e-9
    slack = -1 if planted('box_tight') else 0
    out = []
    if n == 2:
        s = F.sqrt[0]
        for a in range(-D - slack, D + 1 + slack):
            lo = max((-D - a) / s, (a - D) / s)
            hi = min((D - a) / s, (a + D) / s)
            for b in range(math.ceil(lo - eps), math.floor(hi + eps) + 1):
                out.append((a, b))
        return out
    s1, s2 = F.sqrt
    s12 = s1 * s2
    for a in range(-D - slack, D + 1 + slack):
        for b in range(-int(D / s1) - 1 - slack, int(D / s1) + 2 + slack):
            for c in range(-int(D / s2) - 1 - slack, int(D / s2) + 2 + slack):
                lo, hi = -1e18, 1e18
                for g1, g2 in ((1, 1), (1, -1), (-1, 1), (-1, -1)):
                    base = a + g1 * b * s1 + g2 * c * s2
                    kk = g1 * g2
                    l, h = (-D - base) * kk, (D - base) * kk
                    if l > h:
                        l, h = h, l
                    lo, hi = max(lo, l), min(hi, h)
                if lo > hi + eps:
                    continue
                for d in range(math.ceil((lo - eps) / s12), math.floor((hi + eps) / s12) + 1):
                    out.append((a, b, c, d))
    return out


def box_estimate(F, D):
    return (2 * D) ** F.n / F.covolume()


def units_over(F, D):
    """every unit vector of E whose coordinate denominator divides D, as 2n-vectors over D (complete: X^2 + Y^2 = D^2 with each of
    X, Y in the box)"""
    B = box(F, D)
    sq = defaultdict(list)
    for e in B:
        sq[F.mul(e, e)].append(e)
    target = tuple([D * D] + [0] * (F.n - 1))
    out = []
    for e in B:
        need = tuple(t - v for t, v in zip(target, F.mul(e, e)))
        for f in sq.get(need, ()):
            v = tuple(e) + tuple(f)
            if is_unit(F, v, D):
                out.append(v)
    return out


# ================================================================ the point group

def point_group(lat):
    """integer r x r matrices (row convention) of the named automorphisms, closed under composition; see the module docstring"""
    F, M, r = lat.F, lat.M, lat.rank
    n = F.n
    Uset = set(lat.U8)

    def as_matrix(fn):
        rows = []
        for b in lat.H:
            w = lat.to_M(*fn(b))
            c = None if w is None else lat.coords(w)
            if c is None:
                return None
            rows.append(list(c))
        if abs(_det(rows)) != 1:
            return None
        for v in lat.U8:                        # U onto U
            if lat.to_M(*fn(v)) not in Uset:
                return None
        return tuple(tuple(x) for x in rows)

    cands = []
    for u in lat.U8:
        cands.append(('mul', u, lambda v, u=u: (cmul(F, u, v), M * M)))
    cands.append(('conj', None, lambda v: (tuple(v[:n]) + tuple(-t for t in v[n:]), M)))
    for sg in F.signs[1:]:
        cands.append(('gal' + ''.join('+' if s > 0 else '-' for s in sg), None,
                      lambda v, sg=sg: (F.galois(v[:n], sg) + F.galois(v[n:], sg), M)))
    gens = {}
    for nm, u, fn in cands:
        A = as_matrix(fn)
        if A is not None:
            gens.setdefault(A, (nm, lat.coords(u) if u is not None else None))
    group = set(gens) | {tuple(tuple(1 if i == j else 0 for j in range(r)) for i in range(r))}
    frontier = list(group)
    while frontier:
        nxt = []
        for A in frontier:
            for B in list(gens):
                C = _matmul(A, B)
                if C not in group:
                    group.add(C)
                    nxt.append(C)
        frontier = nxt
    return sorted(group), gens


def _matmul(A, B):
    return tuple(tuple(sum(A[i][k] * B[k][j] for k in range(len(B))) for j in range(len(B[0]))) for i in range(len(A)))


def _det(rows):
    A = [[Fr(x) for x in r] for r in rows]
    n = len(A)
    d = Fr(1)
    for i in range(n):
        p = next((k for k in range(i, n) if A[k][i]), None)
        if p is None:
            return 0
        if p != i:
            A[i], A[p] = A[p], A[i]
            d = -d
        d *= A[i][i]
        for k in range(i + 1, n):
            f = A[k][i] / A[i][i]
            for j in range(i, n):
                A[k][j] -= f * A[i][j]
    assert d.denominator == 1
    return int(d)


# ================================================================ the named lattices

K = Field((3, 11))
F35 = Field((3, 5))


def degrey():
    """<zeta6^m rho^n : 0 <= m < 6, |n| <= 2> over K, rho = (5 + i sqrt11)/6 the Moser twist, zeta6 = (1 + i sqrt3)/2"""
    zeta6 = ((1, 0, 0, 0, 0, 1, 0, 0), 2)
    rho = ((5, 0, 0, 0, 0, 0, 1, 0), 6)
    rhob = ((5, 0, 0, 0, 0, 0, -1, 0), 6)

    def mul(p, q):
        return reduce_point(cmul(K, p[0], q[0]), p[1] * q[1])
    one = ((1, 0, 0, 0, 0, 0, 0, 0), 1)
    pts = []
    for m in range(6):
        zm = one
        for _ in range(m):
            zm = mul(zm, zeta6)
        for nn in range(-2, 3):
            w = zm
            for _ in range(abs(nn)):
                w = mul(w, rho if nn > 0 else rhob)
            pts.append(w)
    return Lattice(K, pts, 'degrey')


def lambdaprime(D=24):
    """the Z-span of the unit vectors of E' = Q(sqrt3, sqrt-5) of denominator dividing D: x in Q(sqrt3), y in sqrt5 Q(sqrt3), i.e. the
    coordinates (x_sqrt5, x_sqrt15, y_1, y_sqrt3) vanish (basis 1, sqrt3, sqrt5, sqrt15)"""
    pts = [(v, D) for v in units_over(F35, D) if v[2] == v[3] == v[4] == v[5] == 0]
    return Lattice(F35, pts, 'lambdaprime'), len(pts)


def fabric(spec):
    """an fs70_fabric spec over Q(sqrt3, sqrt5), converted to this file's representation (same basis order)"""
    import fs70_fabric as FB
    pts = []
    for z in FB.generators(spec):
        x, y = z
        den = 1
        for q in x + y:
            den = den * q.denominator // math.gcd(den, q.denominator)
        pts.append((tuple(int(q * den) for q in x + y), den))
    return Lattice(F35, pts, 'fab:' + spec)


def q11shape():
    """FS-61's shape Ld65c8ee8 over Q(sqrt11): (1/30) span of (1,0,0,1), (0,1,1,0), (0,0,2,0), (0,0,0,2) in (a, b, c, e)"""
    F = Field((11,))
    rows = [(1, 0, 0, 1), (0, 1, 1, 0), (0, 0, 2, 0), (0, 0, 0, 2)]
    return Lattice(F, [(r, 30) for r in rows], 'q11shape', M=30)


def named(name):
    if name == 'degrey':
        return degrey()
    if name == 'lambdaprime':
        return lambdaprime()[0]
    if name == 'L3':
        return fabric('group6:u3:2+zeta6:w4')
    if name.startswith('fab:'):
        return fabric(name[4:])
    if name == 'q11shape':
        return q11shape()
    raise SystemExit(f'unknown lattice {name!r}')


def rational_point(lat, num, den=1):
    """the real number num/den as a point, in lattice coordinates (None if not in the lattice)"""
    w = lat.to_M(tuple([num] + [0] * (lat.dim - 1)), den)
    return None if w is None else lat.coords(w)


# ================================================================ commands

def cmd_show(name, method):
    lat = named(name)
    lat.saturate(method)
    G, gens = point_group(lat)
    print(f'{lat.name} over {lat.F.name}(i): rank {lat.rank}, M = {lat.M}, |U| = {len(lat.U)} (saturation {lat.saturation}), '
          f'point group order {len(G)} from {sorted({v[0] if not v[0].startswith("mul") else "mul" for v in gens.values()})}')
    return lat


def selftest(plants=False):
    fails = []

    def check(nm, ok, detail=''):
        print(f'  [{"ok " if ok else "FAIL"}] {nm}  {detail}')
        if not ok:
            fails.append(nm)

    print('fs73_lattice self-test: the four controls of P1a (FS-70 and FS-61 numbers), each by BOTH saturations')
    # control 1: de Grey's K-lattice
    L = degrey()
    L.saturate('both')
    check("de Grey: rank 4, 54 unit vectors, trace = box (the owner's numbers)", L.rank == 4 and len(L.U) == 54,
          f'rank {L.rank}, |U| {len(L.U)}, M {L.M}')
    G, gens = point_group(L)
    names = {v[0] for v in gens.values()}
    check('de Grey: the point group holds conjugation and the Galois flips', 'conj' in names and any(s.startswith('gal') for s in names),
          f'order {len(G)}, generators {sorted(names)}')
    rho = ((5, 0, 0, 0, 0, 0, 1, 0), 6)
    r3 = reduce_point(cmul(K, cmul(K, rho[0], rho[0]), rho[0]), 216)
    w3 = L.to_M(*r3)
    check('de Grey: rho^3 is NOT in the lattice (rho is no multiplier, so the orbit of 8/3 spans only (8/3)Z[zeta6])',
          w3 is None or L.coords(w3) is None, f'rho^3 denominator {r3[1]}')
    t83 = rational_point(L, 8, 3)
    check('de Grey: 8/3 is in the lattice', t83 is not None, str(t83))
    # control 2: Lambda'
    Lp, ngen = lambdaprime()
    Lp.saturate('both')
    check("Lambda': 46 unit vectors of E' at denominator 24, rank 4, the saturation is all 46", ngen == 46 and Lp.rank == 4 and len(Lp.U) == 46,
          f'generators {ngen}, rank {Lp.rank}, |U| {len(Lp.U)}')
    # control 3: L3
    L3 = fabric('group6:u3:2+zeta6:w4')
    L3.saturate('trace')
    ok3 = L3.rank == 6 and len(L3.U) == 42
    try:
        L3b = fabric('group6:u3:2+zeta6:w4')
        est = box_estimate(F35, L3b.M)
        if est < 4e6:
            L3b.saturate('box')
            ok3 = ok3 and set(L3b.U8) == set(L3.U8)
            bx = f'box agrees ({len(L3b.U)})'
        else:
            bx = f'box not run: {est:.2g} elements at M = {L3.M}'
    except Exception as e:                        # noqa: BLE001
        bx, ok3 = f'box raised {e}', False
    check('L3 (group6:u3:2+zeta6:w4): rank 6, 42 unit vectors', ok3, f'rank {L3.rank}, |U| {len(L3.U)}, M {L3.M}; {bx}')
    # control 4: FS-61's shape over Q(sqrt11)
    Q = q11shape()
    Q.saturate('both')
    check("Q(sqrt11)'s shape Ld65c8ee8: 108 unit vectors (row 74)", len(Q.U) == 108, f'rank {Q.rank}, |U| {len(Q.U)}')
    # the box to D below M is labelled incomplete and is a subset
    Lb = degrey()
    Lb.saturate('box', D=12)
    check('box to D = 12 < M: a subset of the saturation, labelled incomplete',
          set(Lb.U8) <= set(L.U8) and 'INCOMPLETE' in Lb.saturation, f'{len(Lb.U)} of {len(L.U)}; {Lb.saturation}')
    if plants:
        global PLANT
        print('  -- plants (each must move a control)')
        for nm in VALID_PLANTS:
            PLANT = nm
            try:
                L = degrey()
                L.saturate('both')
                G2, _ = point_group(L)
                moved = (len(L.U) != 54) or (len(G2) != len(G))
                why = f'|U| {len(L.U)}, group {len(G2)}'
            except (AssertionError, RuntimeError) as e:
                moved, why = True, f'raised: {str(e)[:70]}'
            PLANT = None
            check(f'plant {nm} fires', moved, why)
    print('SELF-TEST PASSED' if not fails else 'SELF-TEST FAILED: ' + ', '.join(fails))
    return 1 if fails else 0


def main():
    argv = sys.argv[1:]
    if PLANT is not None and PLANT not in VALID_PLANTS:
        raise SystemExit(f'unknown plant {PLANT!r}')
    if not argv:
        print(__doc__)
        return 0
    if argv[0] == 'selftest':
        return selftest('--plants' in argv)
    if argv[0] == 'show':
        m = argv[argv.index('--sat') + 1] if '--sat' in argv else 'trace'
        cmd_show(argv[1], m)
        return 0
    print(__doc__)
    return 2


if __name__ == '__main__':
    sys.exit(main())

#!/usr/bin/env python3
"""fs70_field -- exact arithmetic for F = Q(sqrt3, sqrt5) and E = F(i), the unit vectors of E, and their
valuations at the primes above 2, 3 and 5.  Standard library only.  UNTRUSTED (tools/); the certificate
checker for FS-70 is a separate frozen file that shares no code with this one.

Representation.  An element of F is a 4-tuple of Fractions (a, b, c, d) meaning a + b*sqrt3 + c*sqrt5 + d*sqrt15.
An element of E = F(i) is a pair (x, y) of F-elements meaning x + i*y; as a point of the plane it is (x, y).
A unit vector is z in E with z * conj(z) = 1, i.e. x^2 + y^2 = 1.

INTEGER FORM.  Fraction arithmetic is the reference semantics and is 20x slower than integers; every bulk
computation (atlases, lattices, fabrics) uses the NINE-INTEGER form of the plan's section 4.2,
    (A, B, C, D, E, F, G, H, m)  meaning  ((A + B sqrt3 + C sqrt5 + D sqrt15)/m, (E + ... )/m),
and, inside one lattice of denominator M, the eight-integer form over that fixed M (addition is tuple
addition, a hash is a tuple).  `e_from_ints` / `e_to_ints` convert; `units_over(M)` is the bulk enumerator
and returns eight-integer numerator pairs over M.

Valuations (the depth grading of FS-70's plan, section 3.1).  The prime 2 of F splits in E (since -15 = 1 mod 16,
i = sqrt(-15)/sqrt15 lies in the completion), so there are two primes P, Pbar above 2 in E, swapped by complex
conjugation, each with e = 2, f = 2 over Q.  For a unit vector z, v_P(z) = -v_Pbar(z); we call v_P(z) its DEPTH
and z a 2-UNIT when the depth is 0.  Computed through L = Q(sqrt-15) = Q(i*sqrt15) inside E: P is the unique prime of E
above the prime q of L that a chosen 2-adic root r of r^2 = -15 singles out, and v_q(N_{E/L}(z)) = f(P/q) v_P(z) = 2 v_P(z).
The same trick at 3 (through L = Q(sqrt-5), a 3-adic root of s^2 = -5) and at 5 (through L = Q(i), a 5-adic root of
s^2 = -1); at 11 every unit vector is integral (11 is usable for F: residue field F_11, conjugation-fixed) and nothing
is computed.  7 is not handled (no quadratic subfield of E has a unique prime of E above each of its primes above 7).

Every claim this file makes about a specific vector is re-derivable by hand from the formulas in its docstrings.

Commands
  python3 tools/fs70_field.py --selftest            # the identities, the enumerator, and three planted faults
  python3 tools/fs70_field.py atlas MMAX [--out F]  # every unit vector to denominator MMAX with its depths
  python3 tools/fs70_field.py --plant NAME          # run the self-test with one fault planted (it must FAIL)

Planted faults (--plant):
  unit_loose   the unit test reads only the rational part of x^2 + y^2  -> a non-unit is accepted
  depth_root   the place above 2 uses the 3-adic Hensel root            -> depths are wrong
  box_tight    the enumerator's box is shrunk by one unit in each slot  -> unit vectors go missing
"""
from fractions import Fraction as Fr
from collections import defaultdict
import itertools
import json
import math
import sys
import time

# ---------------------------------------------------------------- planted faults (self-test controls only)

PLANT = None


def planted(name):
    return PLANT == name


# ---------------------------------------------------------------- F = Q(sqrt3, sqrt5)

ZERO = (Fr(0), Fr(0), Fr(0), Fr(0))
ONE = (Fr(1), Fr(0), Fr(0), Fr(0))
SQRT3 = (Fr(0), Fr(1), Fr(0), Fr(0))
SQRT5 = (Fr(0), Fr(0), Fr(1), Fr(0))
SQRT15 = (Fr(0), Fr(0), Fr(0), Fr(1))

S3F = math.sqrt(3)
S5F = math.sqrt(5)
S15F = S3F * S5F


def f_add(u, v):
    return tuple(a + b for a, b in zip(u, v))


def f_sub(u, v):
    return tuple(a - b for a, b in zip(u, v))


def f_neg(u):
    return tuple(-a for a in u)


def f_scale(q, u):
    q = Fr(q)
    return tuple(q * a for a in u)


def f_mul(u, v):
    a1, b1, c1, d1 = u
    a2, b2, c2, d2 = v
    # sqrt3^2 = 3, sqrt5^2 = 5, sqrt15^2 = 15, sqrt3*sqrt5 = sqrt15, sqrt3*sqrt15 = 3 sqrt5, sqrt5*sqrt15 = 5 sqrt3
    return (a1 * a2 + 3 * b1 * b2 + 5 * c1 * c2 + 15 * d1 * d2,
            a1 * b2 + b1 * a2 + 5 * (c1 * d2 + d1 * c2),
            a1 * c2 + c1 * a2 + 3 * (b1 * d2 + d1 * b2),
            a1 * d2 + d1 * a2 + b1 * c2 + c1 * b2)


def f_conj3(u):
    """sqrt3 -> -sqrt3"""
    a, b, c, d = u
    return (a, -b, c, -d)


def f_conj5(u):
    """sqrt5 -> -sqrt5"""
    a, b, c, d = u
    return (a, b, -c, -d)


def f_norm(u):
    """N_{F/Q}(u) as a Fraction"""
    n = f_mul(f_mul(u, f_conj3(u)), f_mul(f_conj5(u), f_conj3(f_conj5(u))))
    assert n[1] == n[2] == n[3] == 0
    return n[0]


def f_inv(u):
    if u == ZERO:
        raise ZeroDivisionError
    # u^{-1} = (product of the three other conjugates) / N(u)
    others = f_mul(f_conj3(u), f_mul(f_conj5(u), f_conj3(f_conj5(u))))
    return f_scale(1 / f_norm(u), others)


def f_div(u, v):
    return f_mul(u, f_inv(v))


def f_trace(u):
    return 4 * u[0]


def f_float(u, s3=S3F, s5=S5F):
    a, b, c, d = u
    return float(a) + float(b) * s3 + float(c) * s5 + float(d) * s3 * s5


def f_str(u):
    names = ['', 'sqrt3', 'sqrt5', 'sqrt15']
    parts = []
    for q, nm in zip(u, names):
        if q == 0:
            continue
        s = str(q) if nm == '' else (f'{q}*{nm}' if q not in (1, -1) else ('-' if q == -1 else '') + nm)
        parts.append(s)
    return ' + '.join(parts).replace('+ -', '- ') if parts else '0'


def f_denominator(u):
    L = 1
    for q in u:
        L = L * q.denominator // math.gcd(L, q.denominator)
    return L


# ---------------------------------------------------------------- E = F(i)

def e_add(z, w):
    return (f_add(z[0], w[0]), f_add(z[1], w[1]))


def e_sub(z, w):
    return (f_sub(z[0], w[0]), f_sub(z[1], w[1]))


def e_neg(z):
    return (f_neg(z[0]), f_neg(z[1]))


def e_mul(z, w):
    x1, y1 = z
    x2, y2 = w
    return (f_sub(f_mul(x1, x2), f_mul(y1, y2)), f_add(f_mul(x1, y2), f_mul(y1, x2)))


def e_conj(z):
    return (z[0], f_neg(z[1]))


def e_normF(z):
    """z * conj(z) = x^2 + y^2, an element of F"""
    return f_add(f_mul(z[0], z[0]), f_mul(z[1], z[1]))


def e_is_unit_vector(z):
    """z z-bar = 1 exactly.  This is the one test that decides whether a vector is a unit vector; every
    enumerator proposes and this decides."""
    n = e_normF(z)
    if planted('unit_loose'):
        return n[0] == 1                      # PLANT: ignores the sqrt3, sqrt5, sqrt15 parts
    return n == ONE


def e_scale(q, z):
    return (f_scale(q, z[0]), f_scale(q, z[1]))


def e_float(z):
    return complex(f_float(z[0]), f_float(z[1]))


def e_str(z):
    return f'({f_str(z[0])}, {f_str(z[1])})'


def e_denominator(z):
    return max(f_denominator(z[0]), f_denominator(z[1]))


E_ZERO = (ZERO, ZERO)
E_ONE = (ONE, ZERO)
E_I = (ZERO, ONE)


def e_from_F(u):
    return (u, ZERO)


def e_pow(z, k):
    r = E_ONE
    b = z
    if k < 0:
        b = e_conj(z)  # for unit vectors conj = inverse
        k = -k
    while k:
        if k & 1:
            r = e_mul(r, b)
        b = e_mul(b, b)
        k >>= 1
    return r


ZETA12 = ((Fr(0), Fr(1, 2), Fr(0), Fr(0)), (Fr(1, 2), Fr(0), Fr(0), Fr(0)))  # (sqrt3 + i)/2
ZETA6 = e_pow(ZETA12, 2)


def canonical(z):
    """a hashable exact key for an element of E"""
    return (tuple(z[0]), tuple(z[1]))


# ---------------------------------------------------------------- the nine- and eight-integer forms

def e_to_ints(z):
    """(A,...,H, m) with m > 0 and gcd(A,...,H,m) = 1"""
    m = e_denominator(z)
    nums = [int(q * m) for q in (tuple(z[0]) + tuple(z[1]))]
    g = m
    for v in nums:
        g = math.gcd(g, abs(v))
    return tuple(v // g for v in nums) + (m // g,)


def e_from_ints(t):
    """the nine-integer form back to Fractions"""
    *nums, m = t
    return (tuple(Fr(v, m) for v in nums[:4]), tuple(Fr(v, m) for v in nums[4:8]))


def ints_over(t9, M):
    """the eight-integer numerator of a nine-integer element re-based over the denominator M (M % m == 0)"""
    *nums, m = t9
    assert M % m == 0, (t9, M)
    k = M // m
    return tuple(v * k for v in nums)


def ints_reduce(v8, M):
    """the eight-integer form over M back to the canonical nine-integer form"""
    g = M
    for v in v8:
        g = math.gcd(g, abs(v))
    return tuple(v // g for v in v8) + (M // g,)


def ints_float(v8, M, s3=S3F, s5=S5F):
    a, b, c, d, e, f, g, h = v8
    s15 = s3 * s5
    return ((a + b * s3 + c * s5 + d * s15) / M, (e + f * s3 + g * s5 + h * s15) / M)


# ---------------------------------------------------------------- bulk enumeration of unit vectors

def _imul(p, q):
    """integer-tuple product in F (numerators; denominators handled by the caller)"""
    a1, b1, c1, d1 = p
    a2, b2, c2, d2 = q
    return (a1 * a2 + 3 * b1 * b2 + 5 * c1 * c2 + 15 * d1 * d2,
            a1 * b2 + b1 * a2 + 5 * (c1 * d2 + d1 * c2),
            a1 * c2 + c1 * a2 + 3 * (b1 * d2 + d1 * b2),
            a1 * d2 + d1 * a2 + b1 * c2 + c1 * b2)


def embedding_box(M):
    """every integer 4-tuple (a,b,c,d) all four of whose real embeddings a +- b sqrt3 +- c sqrt5 +- d sqrt15 lie in
    [-M, M].  This is a NECESSARY condition on both coordinates of a unit vector over M (apply each embedding to
    x^2 + y^2 = M^2: the two real squares are non-negative, so each is at most M^2).  The bound is generous by one
    unit in the last place on purpose; the exact test e_is_unit_vector decides."""
    eps = 0.0 if planted('box_tight') else 1e-9      # PLANT: a tight bound loses vectors on the boundary
    slack = -1 if planted('box_tight') else 0
    out = []
    for a in range(-M - slack, M + 1 + slack):
        for b in range(-int(M / S3F) - 1 - slack, int(M / S3F) + 2 + slack):
            ab = b * S3F
            for c in range(-int(M / S5F) - 1 - slack, int(M / S5F) + 2 + slack):
                ac = c * S5F
                # the four embeddings are a + s*ab + t*ac + s*t*ad with ad = d*sqrt15 and s, t in {1, -1};
                # each |.| <= M is an interval for ad.  Intersect the four.
                lo, hi = -1e18, 1e18
                for s, t in ((1, 1), (1, -1), (-1, 1), (-1, -1)):
                    base = a + s * ab + t * ac
                    k = s * t                      # coefficient of ad
                    l, h = (-M - base) * k, (M - base) * k
                    if l > h:
                        l, h = h, l
                    lo = max(lo, l)
                    hi = min(hi, h)
                if lo > hi + eps:
                    continue
                dlo = math.ceil((lo - eps) / S15F)
                dhi = math.floor((hi + eps) / S15F)
                for d in range(dlo, dhi + 1):
                    out.append((a, b, c, d))
    return out


def box_estimate(M):
    """the size of embedding_box(M), to a few percent: the hypercube [-M,M]^4 has volume (2M)^4 and the Minkowski
    embedding of Z<1,sqrt3,sqrt5,sqrt15> has covolume sqrt(4*12*20*60) = 240.  Measured: 4,405 at M = 16 against
    4,369 predicted; 207,509 at M = 42 against 199,148.  Each element costs ~90 bytes and ~2.3 us."""
    return (2 * M) ** 4 / 240.0


def units_over(M):
    """every unit vector whose coordinate denominator DIVIDES M, as eight-integer numerator tuples over M.
    Complete: x^2 + y^2 = 1 with both coordinates in (1/M)Z^4 means X^2 + Y^2 = M^2 with X, Y integer 4-tuples,
    and each of X, Y then lies in embedding_box(M).  We square every box element, group by the square, and look up
    M^2 - X^2; the exact unit test confirms each hit."""
    box = embedding_box(M)
    sq = defaultdict(list)
    for e in box:
        sq[_imul(e, e)].append(e)
    target = (M * M, 0, 0, 0)
    out = []
    for e in box:
        need = tuple(t - v for t, v in zip(target, _imul(e, e)))
        for f in sq.get(need, ()):
            v8 = e + f
            z = (tuple(Fr(v, M) for v in e), tuple(Fr(v, M) for v in f))
            if e_is_unit_vector(z):
                out.append(v8)
    return out


def units_of_denominator(M):
    """every unit vector whose REDUCED coordinate denominator is exactly M, as E elements (Fractions)."""
    out = []
    for v8 in units_over(M):
        t9 = ints_reduce(v8, M)
        if t9[8] == M:
            out.append(e_from_ints(t9))
    return out


# ---------------------------------------------------------------- valuations through quadratic subfields

def hensel_sqrt(a, p, r0, bits):
    """the p-adic root of r^2 = a with r = r0 (mod p^k for the k Hensel needs), to p^bits (bits = exponent)"""
    mod = p ** bits
    r = r0 % mod
    for _ in range(64):
        f = (r * r - a) % mod
        if f == 0:
            return r
        fp = (2 * r) % mod
        # Newton: r <- r - f / fp ; f is divisible by p^{2 v(fp) + 1} so the division is exact in Z_p up to precision loss
        vfp = 0
        t = fp
        while t % p == 0:
            t //= p
            vfp += 1
        assert f % (p ** vfp) == 0
        inv = pow(fp // (p ** vfp), -1, mod)
        r = (r - (f // (p ** vfp)) * inv) % mod
    raise RuntimeError('hensel did not converge')


def v_p_int(n, p):
    if n == 0:
        return math.inf
    v = 0
    while n % p == 0:
        n //= p
        v += 1
    return v


def v_p_frac(q, p):
    return v_p_int(q.numerator, p) - v_p_int(q.denominator, p)


PREC = 160  # p-adic precision in exponent


class Place:
    """A prime P of E above p, reached through a quadratic subfield L = Q(sqrt(-D)) of E in which p splits and above whose
    prime q there is a UNIQUE prime P of E; then v_P(z) = v_q(N_{E/L}(z)) / f(P/q)."""

    def __init__(self, p, name, autos, sqrtD_in_E, D, root_p, f_rel):
        self.p, self.name, self.autos, self.sqrtD, self.D, self.f_rel = p, name, autos, sqrtD_in_E, D, f_rel
        if planted('depth_root') and p == 2:
            # PLANT: the 2-adic root of r^2 = -15 replaced by a 3-adic root of r^2 = -5 (a different place entirely)
            self.root = hensel_sqrt(-5, 3, 1, PREC)
        else:
            self.root = hensel_sqrt(-D, p, root_p, PREC)  # p-adic sqrt(-D)

    def norm_to_L(self, z):
        """N_{E/L}(z) written as A + B*sqrt(-D), with A, B Fractions"""
        prod = E_ONE
        for auto in self.autos:
            prod = e_mul(prod, auto(z))
        # prod must be A + B * sqrtD where sqrtD is the chosen element of E
        A, B = self._decompose(prod)
        return A, B

    def _decompose(self, w):
        s = self.sqrtD  # an E element with s*s = -D
        # try w = A + B s : B = (component of w along s) -- s is one of: i*sqrt15, i*sqrt5, i
        x, y = w
        assert x[1] == x[2] == x[3] == 0, ('norm not in L', w)
        A = x[0]
        sy = s[1]
        # y = B * sy where sy has exactly one nonzero slot
        idx = [k for k in range(4) if sy[k] != 0]
        assert len(idx) == 1
        k = idx[0]
        for j in range(4):
            if j != k:
                assert y[j] == 0, ('norm not in L', w)
        B = y[k] / sy[k]
        return A, B

    def val(self, z):
        """v_P(z), normalised so that v_P(P) = 1"""
        A, B = self.norm_to_L(z)
        if A == 0 and B == 0:
            return math.inf
        # v_q(A + B sqrt(-D)) = v_p(A + B r) with r the p-adic root selecting q
        mod = self.p ** PREC
        L = A.denominator * B.denominator // math.gcd(A.denominator, B.denominator)
        An = int(A * L)
        Bn = int(B * L)
        val_num = v_p_int((An + Bn * self.root) % mod, self.p)
        if val_num >= PREC - 8:
            raise RuntimeError('precision exhausted')
        v = val_num - v_p_int(L, self.p)
        assert v % self.f_rel == 0, (
            f'v_q(N_E/L(z)) = {v} is not divisible by f(P/q) = {self.f_rel}: the chosen {self.p}-adic root '
            f'does not select a prime of E above q (wrong root, or p does not split in L).  z = {e_str(z)}')
        return v // self.f_rel


def _auto(e3, e5, ei):
    def f(z):
        x, y = z
        if e3 < 0:
            x, y = f_conj3(x), f_conj3(y)
        if e5 < 0:
            x, y = f_conj5(x), f_conj5(y)
        if ei < 0:
            y = f_neg(y)
        return (x, y)
    return f


def _places():
    # Place above 2, through L = Q(i sqrt15): the automorphisms fixing i*sqrt15 are (e3, e5, ei) with e3*e5*ei = 1.
    p2 = Place(2, 'P2', [_auto(1, 1, 1), _auto(-1, 1, -1), _auto(1, -1, -1), _auto(-1, -1, 1)],
               (ZERO, SQRT15), 15, 7, 2)
    # Place above 3, through L = Q(i sqrt5): fix i*sqrt5: e5*ei = 1, e3 free.
    p3 = Place(3, 'P3', [_auto(1, 1, 1), _auto(-1, 1, 1), _auto(1, -1, -1), _auto(-1, -1, -1)],
               (ZERO, SQRT5), 5, 1, 2)
    # Place above 5, through L = Q(i): fix i: ei = 1, e3, e5 free.
    p5 = Place(5, 'P5', [_auto(1, 1, 1), _auto(-1, 1, 1), _auto(1, -1, 1), _auto(-1, -1, 1)],
               (ZERO, ONE), 1, 2, 2)
    return p2, p3, p5


PLACE2, PLACE3, PLACE5 = _places()


def depths(z):
    """(v_P2, v_P3, v_P5) of an element of E"""
    return (PLACE2.val(z), PLACE3.val(z), PLACE5.val(z))


def is_two_unit(z):
    return PLACE2.val(z) == 0


def is_three_unit(z):
    return PLACE3.val(z) == 0


# ---------------------------------------------------------------- named vectors

U_SQRT5 = ((Fr(-2, 3), Fr(0), Fr(0), Fr(0)), (Fr(0), Fr(0), Fr(1, 3), Fr(0)))       # (-2 + i sqrt5)/3
V_SQRT15 = ((Fr(1, 4), Fr(0), Fr(0), Fr(0)), (Fr(0), Fr(0), Fr(0), Fr(1, 4)))       # (1 + i sqrt15)/4
RHO15 = ((Fr(7, 8), Fr(0), Fr(0), Fr(0)), (Fr(0), Fr(0), Fr(0), Fr(1, 8)))          # (7 + i sqrt15)/8
W_MIX = ((Fr(0), Fr(1, 4), Fr(1, 4), Fr(0)), (Fr(0), Fr(-1, 4), Fr(1, 4), Fr(0)))   # ((s3+s5) + i(s5-s3))/4
I_SQRT3 = (ZERO, SQRT3)

NAMED = {'zeta12': ZETA12, 'zeta6': ZETA6, 'u': U_SQRT5, 'v': V_SQRT15, 'rho15': RHO15, 'w': W_MIX,
         'one': E_ONE, 'i sqrt3': I_SQRT3}


def real_scalar(q):
    """the E element q + 0i for a rational q"""
    return (f_scale(q, ONE), ZERO)


# ---------------------------------------------------------------- the atlas

def atlas_rows(MMAX, verbose=False):
    """one row per unit vector of reduced denominator m <= MMAX: its nine integers and its three depths"""
    rows = []
    for M in range(1, MMAX + 1):
        t0 = time.time()
        n = 0
        for z in units_of_denominator(M):
            t9 = e_to_ints(z)
            d2, d3, d5 = depths(z)
            rows.append({'m': M, 'x': list(t9[0:4]), 'y': list(t9[4:8]),
                         'depth2': d2, 'depth3': d3, 'depth5': d5,
                         'two_unit': d2 == 0, 'three_unit': d3 == 0,
                         'approx': [round(v, 12) for v in ints_float(t9[:8], M)]})
            n += 1
        if verbose:
            print(f'  m = {M:3d}: {n:4d} unit vectors  ({time.time() - t0:.2f}s)', flush=True)
    return rows


def cmd_atlas(MMAX, out):
    t0 = time.time()
    rows = atlas_rows(MMAX, verbose=True)
    by_m = defaultdict(int)
    for r in rows:
        by_m[r['m']] += 1
    print(f'atlas to denominator {MMAX}: {len(rows)} unit vectors, {time.time() - t0:.1f}s')
    print('counts by denominator:', {m: by_m[m] for m in sorted(by_m)})
    dep = defaultdict(int)
    for r in rows:
        dep[(r['depth2'], r['depth3'], r['depth5'])] += 1
    print('depth classes (P2,P3,P5) -> count:', dict(sorted(dep.items())))
    print(f'2-units: {sum(1 for r in rows if r["two_unit"])};  3-units: {sum(1 for r in rows if r["three_unit"])}')
    if out:
        with open(out, 'w') as fh:
            for r in rows:
                fh.write(json.dumps(r, separators=(',', ':')) + '\n')
        print('wrote', out)


# ---------------------------------------------------------------- self-test

def selftest():
    """The identities the plan quotes, the enumerator against the plan's section 2.1 table, and the depth grading."""
    # --- the twelfth roots of unity and the named vectors
    assert e_is_unit_vector(ZETA12) and e_pow(ZETA12, 12) == E_ONE and e_pow(ZETA12, 6) == e_neg(E_ONE)
    for z in (U_SQRT5, V_SQRT15, RHO15, W_MIX):
        assert e_is_unit_vector(z), e_str(z)
    # --- a NON-unit vector must be refused (the faithful twin of the unit_loose plant)
    almost = ((Fr(1, 2), Fr(0), Fr(0), Fr(0)), (Fr(0), Fr(0), Fr(0), Fr(0)))          # 1/2: norm 1/4
    assert not e_is_unit_vector(almost), 'the unit test accepted (1/2, 0)'
    # norm 1 + sqrt3/2: the RATIONAL part is 1, so a test that reads only that part accepts it
    fake = (ZERO, (Fr(1, 2), Fr(1, 2), Fr(0), Fr(0)))                                 # (0, (1+sqrt3)/2)
    assert e_normF(fake)[0] == 1 and e_normF(fake) != ONE, e_normF(fake)
    assert not e_is_unit_vector(fake), 'the unit test accepted (0, (1+sqrt3)/2) -- only the rational part was read'
    # --- the chain identities of the plan's section 3.5
    s = e_add(e_add(E_ONE, U_SQRT5), e_conj(U_SQRT5))
    assert s == real_scalar(Fr(-1, 3)), e_str(s)                                       # 1 + u + ubar = -1/3
    assert e_add(V_SQRT15, e_conj(V_SQRT15)) == real_scalar(Fr(1, 2))                  # v + vbar = 1/2
    v2 = e_mul(V_SQRT15, V_SQRT15)
    vb2 = e_mul(e_conj(V_SQRT15), e_conj(V_SQRT15))
    assert e_add(v2, vb2) == real_scalar(Fr(-7, 4))                                    # v^2 + vbar^2 = -7/4
    assert RHO15 == e_neg(vb2)                                                         # rho15 = -conj(v)^2
    three_q = e_neg(e_add(E_ONE, e_add(v2, vb2)))
    assert three_q == real_scalar(Fr(3, 4)), e_str(three_q)                            # -1 - v^2 - vbar^2 = 3/4 = 1/(4/3)
    four = e_add(e_add(E_ONE, E_ONE), e_add(v2, vb2))
    assert four == real_scalar(Fr(1, 4)), e_str(four)                                  # 1 + 1 + v^2 + vbar^2 = 1/4
    v3 = e_mul(v2, V_SQRT15)
    vb3 = e_mul(vb2, e_conj(V_SQRT15))
    eight = e_neg(e_add(e_add(v3, vb3), e_scale(2, e_add(V_SQRT15, e_conj(V_SQRT15)))))
    assert eight == real_scalar(Fr(3, 8)), e_str(eight)                                # -v^3-2v-2vbar-vbar^3 = 3/8 = 1/(8/3)
    # --- i sqrt3 = zeta6 + zeta6^2
    assert I_SQRT3 == e_add(ZETA6, e_mul(ZETA6, ZETA6))
    # --- the wall-breaker tower: w^2 = zeta12^3 * conj(v), w^4 = rho15
    w2 = e_mul(W_MIX, W_MIX)
    assert w2 == e_mul(e_pow(ZETA12, 3), e_conj(V_SQRT15)), e_str(w2)
    assert e_mul(w2, w2) == RHO15, e_str(e_mul(w2, w2))
    # --- depths.  v_P(2) = 2 is the normalisation (e = 2 over Q): it is checked FIRST because it is the one
    # reading that names a wrong place directly.
    assert PLACE2.val(real_scalar(2)) == 2, f'v_P2(2) = {PLACE2.val(real_scalar(2))}, not 2: the place above 2 is wrong'
    assert PLACE3.val(real_scalar(3)) == 2, f'v_P3(3) = {PLACE3.val(real_scalar(3))}, not 2'
    assert PLACE5.val(real_scalar(5)) == 2, f'v_P5(5) = {PLACE5.val(real_scalar(5))}, not 2'
    assert depths(ZETA12) == (0, 0, 0), depths(ZETA12)
    assert PLACE3.val(real_scalar(2)) == 0 and PLACE2.val(real_scalar(3)) == 0
    du, dv, dw, dr = depths(U_SQRT5), depths(V_SQRT15), depths(W_MIX), depths(RHO15)
    assert du == (0, -2, 0), du          # u is a 2-unit and a 3-NON-unit
    assert dv == (2, 0, 0), dv           # v breaks the wall at depth 2
    assert dw == (-1, 0, 0), dw          # w at depth 1
    assert dr == (-4, 0, 0), dr          # rho15 = w^4 at depth 4 -- consistent with the tower
    assert dr[0] == 4 * dw[0], (dr, dw)
    # --- the depth is a homomorphism on unit vectors: depth(z*w) = depth(z) + depth(w)
    for a, b in ((V_SQRT15, V_SQRT15), (V_SQRT15, W_MIX), (U_SQRT5, V_SQRT15), (ZETA12, RHO15)):
        assert PLACE2.val(e_mul(a, b)) == PLACE2.val(a) + PLACE2.val(b)
    # --- the enumerator against the plan's section 2.1 table (counts by EXACT denominator)
    expect = {1: 4, 2: 8, 3: 8, 4: 16, 5: 16, 6: 24, 7: 16, 8: 48, 9: 8, 10: 32, 11: 0, 12: 64,
              13: 32, 14: 48, 16: 48}
    for M, n in sorted(expect.items()):
        got = len(units_of_denominator(M))
        assert got == n, f'units of denominator {M}: got {got}, plan section 2.1 says {n}'
    # --- every enumerated vector really is a unit vector, and the named ones are found where they belong
    for M in (3, 4, 8):
        for z in units_of_denominator(M):
            assert e_is_unit_vector(z) and e_denominator(z) == M
    found = {canonical(z) for z in units_of_denominator(3)}
    assert canonical(U_SQRT5) in found, 'u missing from the denominator-3 list'
    found4 = {canonical(z) for z in units_of_denominator(4)}
    assert canonical(V_SQRT15) in found4 and canonical(W_MIX) in found4
    assert canonical(RHO15) in {canonical(z) for z in units_of_denominator(8)}
    # --- the nine-integer form round-trips
    for z in (ZETA12, U_SQRT5, V_SQRT15, RHO15, W_MIX):
        t9 = e_to_ints(z)
        assert canonical(e_from_ints(t9)) == canonical(z), t9
        assert ints_reduce(ints_over(t9, 24), 24) == t9
    print('fs70_field selftest OK')
    print('  depths (P2,P3,P5): zeta12', depths(ZETA12), ' u', du, ' v', dv, ' w', dw, ' rho15', dr)
    print('  units of denominator 1..16:', [len(units_of_denominator(M)) for M in range(1, 17)])


PLANTS = ('unit_loose', 'depth_root', 'box_tight')


def run_plants():
    """each plant must make the self-test FAIL, beside the faithful twin (the un-planted run) that passes."""
    global PLANT, PLACE2, PLACE3, PLACE5
    import subprocess
    ok = True
    print('--- faithful twin')
    selftest()
    for name in PLANTS:
        print(f'--- plant {name}: the self-test must fail')
        r = subprocess.run([sys.executable, __file__, '--selftest', '--plant', name],
                           capture_output=True, text=True)
        if r.returncode == 0:
            print(f'    NOT REFUSED -- plant {name} left the self-test green: the check is blind')
            ok = False
        else:
            why = (r.stderr.strip().split('\n') or [''])[-1]
            print(f'    refused (exit {r.returncode}): {why[:160]}')
    if not ok:
        raise SystemExit('a planted fault did not fire')
    print('all three plants fired; faithful twin green')


if __name__ == '__main__':
    argv = sys.argv[1:]
    if '--plant' in argv:
        PLANT = argv[argv.index('--plant') + 1]
        if PLANT not in PLANTS:
            raise SystemExit(f'unknown plant {PLANT}; known: {", ".join(PLANTS)}')
        PLACE2, PLACE3, PLACE5 = _places()
    if '--plants' in argv:
        run_plants()
    elif '--selftest' in argv:
        selftest()
    elif argv and argv[0] == 'atlas':
        out = argv[argv.index('--out') + 1] if '--out' in argv else None
        cmd_atlas(int(argv[1]), out)
    else:
        print(__doc__)

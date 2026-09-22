#!/usr/bin/env python3
"""fs70_field -- exact arithmetic for F = Q(sqrt3, sqrt5) and E = F(i), the unit vectors of E, and their
valuations at the primes above 2, 3 and 5.  Standard library only.  UNTRUSTED (tools/); the certificate
checker for FS-70 is a separate frozen file that shares no code with this one.

Representation.  An element of F is a 4-tuple of Fractions (a, b, c, d) meaning a + b*sqrt3 + c*sqrt5 + d*sqrt15.
An element of E = F(i) is a pair (x, y) of F-elements meaning x + i*y; as a point of the plane it is (x, y).
A unit vector is z in E with z * conj(z) = 1, i.e. x^2 + y^2 = 1.

Valuations (the depth grading of FS-70's plan, section 3).  The prime 2 of F splits in E (since -15 = 1 mod 8,
i = sqrt(-15)/sqrt15 lies in the completion), so there are two primes P, Pbar above 2 in E, swapped by complex
conjugation, each with e = 2, f = 2 over Q.  For a unit vector z, v_P(z) = -v_Pbar(z); we call v_P(z) its DEPTH
and z a 2-UNIT when the depth is 0.  Computed through L = Q(sqrt-15) = Q(i*sqrt15) inside E: P is the unique prime of E
above the prime q of L that a chosen 2-adic root r of r^2 = -15 singles out, and v_q(N_{E/L}(z)) = f(P/q) v_P(z) = 2 v_P(z).
The same trick at 3 (through L = Q(sqrt-5), a 3-adic root of s^2 = -5) and at 5 (through L = Q(i), a 5-adic root of
s^2 = -1); at 11 every unit vector is integral (11 is usable for F: residue field F_11, conjugation-fixed) and nothing
is computed.  7 is not handled (no quadratic subfield of E has a unique prime of E above each of its primes above 7).

Every claim this file makes about a specific vector is re-derivable by hand from the formulas in its docstrings; the
self-test (`python3 tools/fs70_field.py --selftest`) checks the identities the plan quotes.
"""
from fractions import Fraction as Fr
import itertools
import math
import sys

# ---------------------------------------------------------------- F = Q(sqrt3, sqrt5)

ZERO = (Fr(0), Fr(0), Fr(0), Fr(0))
ONE = (Fr(1), Fr(0), Fr(0), Fr(0))
SQRT3 = (Fr(0), Fr(1), Fr(0), Fr(0))
SQRT5 = (Fr(0), Fr(0), Fr(1), Fr(0))
SQRT15 = (Fr(0), Fr(0), Fr(0), Fr(1))


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


def f_float(u, s3=math.sqrt(3), s5=math.sqrt(5)):
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
    return e_normF(z) == ONE


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


# ---------------------------------------------------------------- unit vectors of E, by the rational parametrisation

def unit_from_t(t):
    """t in F (a Fraction 4-tuple) -> ((1 - t^2)/(1 + t^2), 2t/(1 + t^2)); every unit vector but (-1, 0) arises once."""
    t2 = f_mul(t, t)
    den = f_add(ONE, t2)
    return (f_div(f_sub(ONE, t2), den), f_div(f_scale(2, t), den))


def enumerate_units(height, denom_cap=None):
    """All unit vectors z = unit_from_t(t) with t = (a + b sqrt3 + c sqrt5 + d sqrt15)/N, |a|,|b|,|c|,|d| <= height,
    1 <= N <= height, gcd = 1, plus (-1, 0); deduplicated; optionally keep only those whose coordinate
    denominator is <= denom_cap.  This is complete for t of that height, NOT for unit vectors of a given denominator."""
    seen = {}
    rng = range(-height, height + 1)
    for N in range(1, height + 1):
        for a, b, c, d in itertools.product(rng, repeat=4):
            if math.gcd(math.gcd(abs(a), abs(b)), math.gcd(math.gcd(abs(c), abs(d)), N)) != 1:
                continue
            t = (Fr(a, N), Fr(b, N), Fr(c, N), Fr(d, N))
            z = unit_from_t(t)
            if denom_cap is not None and e_denominator(z) > denom_cap:
                continue
            seen.setdefault(canonical(z), z)
    seen.setdefault(canonical(e_neg(E_ONE)), e_neg(E_ONE))
    return list(seen.values())


def units_of_denominator(M):
    """All unit vectors whose coordinates are (A + B sqrt3 + C sqrt5 + D sqrt15)/M, (E + Fs3 + G s5 + H s15)/M with integer
    numerators: solve the four component equations of x^2 + y^2 = 1 by enumerating the rational parts first.  Complete
    for the denominator M (not only dividing M: callers pass each M).  Cost grows like M^4-M^5; fine to ~40."""
    out = []
    # bounds: A^2 + 3B^2 + 5C^2 + 15D^2 + E^2 + 3F^2 + 5G^2 + 15H^2 = M^2
    bA = M
    bB = int(math.isqrt(M * M // 3))
    bC = int(math.isqrt(M * M // 5))
    bD = int(math.isqrt(M * M // 15))
    for A in range(-bA, bA + 1):
        for B in range(-bB, bB + 1):
            for C in range(-bC, bC + 1):
                for D in range(-bD, bD + 1):
                    rest = M * M - (A * A + 3 * B * B + 5 * C * C + 15 * D * D)
                    if rest < 0:
                        continue
                    # y-part must satisfy: E^2+3F^2+5G^2+15H^2 = rest; 2(AB+5CD) + 2(EF+5GH) = 0 ; 2(AC+3BD) + 2(EG+3FH) = 0;
                    # 2(AD+BC) + 2(EH+FG) = 0
                    s3 = -(A * B + 5 * C * D)
                    s5 = -(A * C + 3 * B * D)
                    s15 = -(A * D + B * C)
                    eE = int(math.isqrt(rest))
                    for E in range(-eE, eE + 1):
                        r2 = rest - E * E
                        eF = int(math.isqrt(r2 // 3))
                        for Fv in range(-eF, eF + 1):
                            r3 = r2 - 3 * Fv * Fv
                            eG = int(math.isqrt(r3 // 5))
                            for G in range(-eG, eG + 1):
                                r4 = r3 - 5 * G * G
                                if r4 % 15:
                                    continue
                                h2 = r4 // 15
                                H = int(math.isqrt(h2))
                                if H * H != h2:
                                    continue
                                for Hv in ({H, -H}):
                                    if E * Fv + 5 * G * Hv != s3:
                                        continue
                                    if E * G + 3 * Fv * Hv != s5:
                                        continue
                                    if E * Hv + Fv * G != s15:
                                        continue
                                    if math.gcd(math.gcd(math.gcd(abs(A), abs(B)), math.gcd(abs(C), abs(D))),
                                                math.gcd(math.gcd(abs(E), abs(Fv)), math.gcd(math.gcd(abs(G), abs(Hv)), M))) != 1:
                                        continue
                                    z = ((Fr(A, M), Fr(B, M), Fr(C, M), Fr(D, M)),
                                         (Fr(E, M), Fr(Fv, M), Fr(G, M), Fr(Hv, M)))
                                    assert e_is_unit_vector(z)
                                    out.append(z)
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
        self.root = hensel_sqrt(-D, p, root_p, PREC)  # p-adic sqrt(-D)

    def norm_to_L(self, z):
        """N_{E/L}(z) written as A + B*sqrt(-D), with A, B Fractions"""
        prod = E_ONE
        for auto in self.autos:
            prod = e_mul(prod, auto(z))
        # prod must be A + B * sqrtD where sqrtD is the chosen element of E
        # solve: prod = A*1 + B*sqrtD.  sqrtD is either (0, i*something) or in F; read off by the shape.
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
        assert v % self.f_rel == 0, (v, z)
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


# Place above 2, through L = Q(i sqrt15): the automorphisms fixing i*sqrt15 are (e3, e5, ei) with e3*e5*ei = 1.
PLACE2 = Place(2, 'P2', [_auto(1, 1, 1), _auto(-1, 1, -1), _auto(1, -1, -1), _auto(-1, -1, 1)],
               (ZERO, SQRT15), 15, 7, 2)
# Place above 3, through L = Q(i sqrt5): fix i*sqrt5: e5*ei = 1, e3 free.
PLACE3 = Place(3, 'P3', [_auto(1, 1, 1), _auto(-1, 1, 1), _auto(1, -1, -1), _auto(-1, -1, -1)],
               (ZERO, SQRT5), 5, 1, 2)
# Place above 5, through L = Q(i): fix i: ei = 1, e3, e5 free.
PLACE5 = Place(5, 'P5', [_auto(1, 1, 1), _auto(-1, 1, 1), _auto(1, -1, 1), _auto(-1, -1, 1)],
               (ZERO, ONE), 1, 2, 2)


def depths(z):
    """(v_P2, v_P3, v_P5) of an element of E"""
    return (PLACE2.val(z), PLACE3.val(z), PLACE5.val(z))


# ---------------------------------------------------------------- named vectors

U_SQRT5 = ((Fr(-2, 3), Fr(0), Fr(0), Fr(0)), (Fr(0), Fr(0), Fr(1, 3), Fr(0)))       # (-2 + i sqrt5)/3
V_SQRT15 = ((Fr(1, 4), Fr(0), Fr(0), Fr(0)), (Fr(0), Fr(0), Fr(0), Fr(1, 4)))       # (1 + i sqrt15)/4
RHO15 = ((Fr(7, 8), Fr(0), Fr(0), Fr(0)), (Fr(0), Fr(0), Fr(0), Fr(1, 8)))          # (7 + i sqrt15)/8
W_MIX = ((Fr(0), Fr(1, 4), Fr(1, 4), Fr(0)), (Fr(0), Fr(-1, 4), Fr(1, 4), Fr(0)))   # ((s3+s5) + i(s5-s3))/4
I_SQRT3 = (ZERO, SQRT3)


def selftest():
    assert e_is_unit_vector(ZETA12) and e_pow(ZETA12, 12) == E_ONE and e_pow(ZETA12, 6) == e_neg(E_ONE)
    for z in (U_SQRT5, V_SQRT15, RHO15, W_MIX):
        assert e_is_unit_vector(z), e_str(z)
    # the FS-48 chain identity 1 + u + ubar = -1/3
    s = e_add(e_add(E_ONE, U_SQRT5), e_conj(U_SQRT5))
    assert s == ((Fr(-1, 3), Fr(0), Fr(0), Fr(0)), ZERO), e_str(s)
    # 1/2 = v + vbar
    assert e_add(V_SQRT15, e_conj(V_SQRT15)) == ((Fr(1, 2), Fr(0), Fr(0), Fr(0)), ZERO)
    # rho15 = -conj(v)^2
    assert RHO15 == e_neg(e_mul(e_conj(V_SQRT15), e_conj(V_SQRT15)))
    # i sqrt3 = zeta6 + zeta6^2
    assert I_SQRT3 == e_add(ZETA6, e_mul(ZETA6, ZETA6))
    # depths: roots of unity are units everywhere; 2 has depth 2 at P2; u is a 2-unit and a 3-non-unit
    assert depths(ZETA12) == (0, 0, 0)
    assert PLACE2.val((f_scale(2, ONE), ZERO)) == 2
    assert PLACE3.val((f_scale(3, ONE), ZERO)) == 2 and PLACE5.val((f_scale(5, ONE), ZERO)) == 2
    du = depths(U_SQRT5)
    assert du[0] == 0 and du[1] != 0, du
    dv = depths(V_SQRT15)
    assert dv[0] != 0 and dv[1] == 0 and dv[2] == 0, dv
    # the parametrisation reproduces u
    assert canonical(unit_from_t((Fr(0), Fr(0), Fr(1), Fr(0)))) != canonical(E_ZERO)
    print('selftest OK')
    print('depths (P2, P3, P5): zeta12', depths(ZETA12), ' u', du, ' v', dv, ' rho15', depths(RHO15), ' w', depths(W_MIX))


if __name__ == '__main__':
    if '--selftest' in sys.argv:
        selftest()

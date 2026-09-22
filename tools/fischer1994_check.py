#!/usr/bin/env python3
"""Exact-arithmetic check of [Fischer1994] (K. G. Fischer, Congr. Numer. 104 (1994) 73-79), read first-hand
2026-09-22 (`~/source/library/papers/fischer-1994-planar-geometric-graph-chromatic-number-four-congr-numer-104-pp73-79.pdf`).

His theorem: for squarefree coprime p = 3 (mod 16), q = 11 (mod 16), pq = 1 (mod 32), write a unit vector
(complex norm 1) of F(i), F = Q(sqrt p, sqrt q), in lowest terms

    xi = (alpha_0 + alpha_1 sqrt p + alpha_2 sqrt q + alpha_3 sqrt pq) / c,   alpha_k = a_k + b_k i in Z[i],

gcd(a_0..b_3, c) = 1, c > 0.  With S = a_0 + b_0 + a_3 + b_3 the map v(xi) = 2S/c is 2-integral and nonzero
mod 4, so v : Sigma -> Z/4 (Sigma the group the unit vectors generate) is an additive 4-colouring of F^2.
His proof is six lemmas of 2-adic congruences; each was verified by hand at the reading (the notes file beside
the PDF).  This script is the computational half:

  (1) the algebraic identities of his Lemma 2 (i) and (ii), symbolically, as polynomial identities modulo the
      norm equations (1)-(4);
  (2) the key mod-16 step of Lemma 1 (alpha_0^2 = p alpha_1^2 (mod 16) forces alpha_0 even), by brute force
      over Z[i]/16;
  (3) every lemma's conclusion and the theorem itself on every unit vector z / conj(z) with z in Z[sqrt p, sqrt q, i]
      of coefficients in [-R, R] (Hilbert 90: every unit vector is of this form), plus his own Moser-spindle and
      Golomb-graph points;
  (4) the same over fields OUTSIDE his family as controls: Q(sqrt 3, sqrt 5) (wall broken - no additive
      4-colouring can exist, G41/L7) must produce a unit vector with v = 0 or v non-2-integral; fields with
      p, q = 3 (mod 8) but pq != 1 (mod 32) show whether that hypothesis is load-bearing for HIS map.

Nothing here is trusted by the kernel; it is the owner's check that the paper's theorem is true as stated.
"""
from fractions import Fraction as Fr
from itertools import product
from math import gcd, lcm
import sys, random

# --- Q(sqrt p, sqrt q) as 4-tuples over the basis 1, sqrt p, sqrt q, sqrt pq ------------------------------------
class Biquad:
    def __init__(self, p, q):
        self.p, self.q = p, q
    def mul(self, x, y):
        p, q = self.p, self.q
        x0, x1, x2, x3 = x; y0, y1, y2, y3 = y
        return (x0*y0 + p*x1*y1 + q*x2*y2 + p*q*x3*y3,
                x0*y1 + x1*y0 + q*(x2*y3 + x3*y2),
                x0*y2 + x2*y0 + p*(x1*y3 + x3*y1),
                x0*y3 + x3*y0 + x1*y2 + x2*y1)
    def add(self, x, y): return tuple(a + b for a, b in zip(x, y))
    def sub(self, x, y): return tuple(a - b for a, b in zip(x, y))
    def sp(self, x): return (x[0], -x[1], x[2], -x[3])     # sqrt p -> -sqrt p
    def sq(self, x): return (x[0], x[1], -x[2], -x[3])     # sqrt q -> -sqrt q
    def inv(self, x):
        # 1/x = (product of the three conjugates) / N(x), N(x) rational
        c1 = self.sp(x); c2 = self.sq(x); c3 = self.sp(self.sq(x))
        num = self.mul(self.mul(c1, c2), c3)
        n = self.mul(x, num)
        assert n[1] == n[2] == n[3] == 0 and n[0] != 0
        return tuple(Fr(t, 1) / n[0] for t in num)

def unit_vectors(B, R):
    """xi = z / conj(z) = z^2 / |z|^2 for z = x + i y, x, y in Z[sqrt p, sqrt q] with coefficients in [-R, R].
    Returned as (re, im) with re, im 4-tuples of Fractions.  Deduplicated."""
    seen = set()
    rng = range(-R, R + 1)
    for coeffs in product(rng, repeat=8):
        x, y = coeffs[:4], coeffs[4:]
        if all(t == 0 for t in coeffs): continue
        nn = B.add(B.mul(x, x), B.mul(y, y))          # |z|^2, real
        inv = B.inv(nn)
        re = B.sub(B.mul(x, x), B.mul(y, y)); im = tuple(2 * t for t in B.mul(x, y))
        xi = (tuple(Fr(t) * 1 for t in B.mul(tuple(Fr(t) for t in re), inv)),
              tuple(Fr(t) * 1 for t in B.mul(tuple(Fr(t) for t in im), inv)))
        if xi in seen: continue
        seen.add(xi)
        yield xi

def reduced(xi):
    """Fischer's representation: Gaussian-integer numerators alpha_k = a_k + b_k i over one positive c, gcd 1."""
    re, im = xi
    c = 1
    for t in re + im: c = lcm(c, t.denominator)
    a = [int(t * c) for t in re]; b = [int(t * c) for t in im]
    g = c
    for t in a + b: g = gcd(g, t)
    return [t // g for t in a], [t // g for t in b], c // g

def v_of(xi, u=1, k=3):
    """2S/c as a Fraction, S = a_0 + b_0 + u (a_k + b_k); None if not 2-integral, else its residue mod 4.
    k = 3, u = 1 is Fischer's map (trace to Q(sqrt pq, i), then sqrt pq |-> 1); u = a 2-adic square root of the
    kept radicand (index k: 1 = p, 2 = q, 3 = pq) mod 16 is the owner's generalisation - the trace to the
    subfield the OTHER two radicals are conjugated out of, read in the 2-adic embedding."""
    a, b, c = reduced(xi)
    S = a[0] + b[0] + u * (a[k] + b[k])
    val = Fr(2 * S, c)
    if val.denominator % 2 == 0: return a, b, c, S, val, None
    return a, b, c, S, val, (val.numerator * pow(val.denominator, -1, 4)) % 4

def is_unit(B, xi):
    re, im = xi
    n = B.add(B.mul(re, re), B.mul(im, im))
    return n == (1, 0, 0, 0)

def check_field(p, q, R, label, expect_ok, extra=(), u=1, k=3):
    B = Biquad(p, q)
    fails = {'L1': 0, 'L3': 0, 'L4': 0, 'L5': 0, 'L6': 0, 'integral': 0, 'nonzero': 0}
    n = 0; first_bad = None
    vecs = list(unit_vectors(B, R)) + list(extra)
    for xi in vecs:
        assert is_unit(B, xi)
        n += 1
        a, b, c, S, val, r = v_of(xi, u, k)
        if c % 8 == 0: fails['L1'] += 1
        if S % 2 == 1 and c % 4 == 0: fails['L3'] += 1
        if S % 8 in (2, 6) and c % 2 == 1: fails['L4'] += 1
        if S % 8 in (0, 4) and c % 8 != 4: fails['L5'] += 1
        if S % 8 == 0: fails['L6'] += 1
        if r is None: fails['integral'] += 1
        elif r == 0: fails['nonzero'] += 1
        if (r is None or r == 0) and first_bad is None: first_bad = (a, b, c, S, val)
    ok = all(f == 0 for f in fails.values())
    verdict = 'OK' if ok == expect_ok else 'FAIL'
    print(f"[{verdict}] Q(sqrt{p},sqrt{q}) k={k} u={u} {label}: {n} unit vectors at R={R}; lemma/theorem violations {fails}"
          + (f"; first bad: alpha={list(zip(first_bad[0], first_bad[1]))} c={first_bad[2]} S={first_bad[3]} 2S/c={first_bad[4]}" if first_bad else ''))
    return ok == expect_ok

def lemma2_identities():
    import sympy as sp
    a0, a1, a2, a3, b0, b1, b2, b3, p, q, c = sp.symbols('a0 a1 a2 a3 b0 b1 b2 b3 p q c')
    eq1 = a0**2 + b0**2 + p*(a1**2 + b1**2) + q*(a2**2 + b2**2) + p*q*(a3**2 + b3**2) - c**2
    eq2 = (a0*a1 + b0*b1) + q*(a2*a3 + b2*b3)
    eq3 = (a0*a2 + b0*b2) + p*(a1*a3 + b1*b3)
    eq4 = (a0*a3 + b0*b3) + (a1*a2 + b1*b2)
    A, Bb, C, D = a0 + a3, b0 + b3, p*a1 + a2, p*b1 + b2
    # (i): p c^2 - [p(A^2+B^2) + C^2 + D^2]  ==  (pq-1)(|alpha_2|^2 + p|alpha_3|^2) - 2p*eq4 - p*eq1
    lhs_i = p*c**2 - (p*(A**2 + Bb**2) + C**2 + D**2)
    rhs_i = (p*q - 1)*(a2**2 + b2**2 + p*(a3**2 + b3**2)) - 2*p*eq4 - p*eq1
    ok_i = sp.expand(lhs_i - rhs_i) == 0
    # (ii): A C + B D  ==  p*eq2 + eq3 + (1 - pq)(a2 a3 + b2 b3)
    ok_ii = sp.expand(A*C + Bb*D - (p*eq2 + eq3 + (1 - p*q)*(a2*a3 + b2*b3))) == 0
    print(f"[{'OK' if ok_i and ok_ii else 'FAIL'}] Lemma 2 identities: (i) {ok_i}, (ii) {ok_ii} "
          "(so with (1)-(4) both hold mod pq-1, i.e. mod 32; (i) mod 64 when |alpha_2|^2+|alpha_3|^2 is even)")
    return ok_i and ok_ii

def lemma1_mod16(p_res):
    """alpha_0^2 = p_res * alpha_1^2 (mod 16) in Z[i]  ==>  alpha_0 = 0 (mod 2)?  Brute force over Z[i]/16."""
    def sq(a, b): return ((a*a - b*b) % 16, (2*a*b) % 16)
    bad = 0; sols = 0
    for a0, b0, a1, b1 in product(range(16), repeat=4):
        s0 = sq(a0, b0); s1 = sq(a1, b1)
        if s0 == ((p_res * s1[0]) % 16, (p_res * s1[1]) % 16):
            sols += 1
            if a0 % 2 or b0 % 2: bad += 1
    print(f"[{'OK' if bad == 0 else 'FAIL'}] Lemma 1 step at p = {p_res} (mod 16): {sols} solutions of alpha_0^2 = {p_res} alpha_1^2 mod 16, "
          f"{bad} with alpha_0 odd (then alpha_0 = 0 mod 2 forces alpha_1^2 = 0 mod 4, i.e. alpha_1 even)")
    return bad == 0

if __name__ == '__main__':
    R = int(sys.argv[1]) if len(sys.argv) > 1 else 2
    allok = True
    allok &= lemma2_identities()
    allok &= lemma1_mod16(3)
    allok &= lemma1_mod16(11)
    # His own points (p. 74): Moser spindle P, Q and Golomb R, as unit vectors from the origin are NOT unit
    # (they are vertices); the spindle's unit edges are differences.  Use the direction of P's first edge:
    # P = ((5 sqrt3 - sqrt11)/12, (5 + sqrt33)/12) has |P|^2 = (75 - 10 sqrt33 + 11 + 25 + 10 sqrt33 + 33)/144 = 1,
    # so P itself is a unit vector; likewise Q.
    # basis order (1, sqrt p, sqrt q, sqrt pq) with p = 3, q = 11: index 1 <-> sqrt3, 2 <-> sqrt11, 3 <-> sqrt33
    P = ((Fr(0), Fr(5, 12), Fr(-1, 12), Fr(0)), (Fr(5, 12), Fr(0), Fr(0), Fr(1, 12)))     # re: 5 sqrt3/12 - sqrt11/12 ; im: 5/12 + sqrt33/12
    Q = ((Fr(0), Fr(5, 12), Fr(1, 12), Fr(0)), (Fr(-5, 12), Fr(0), Fr(0), Fr(1, 12)))     # re: 5 sqrt3/12 + sqrt11/12 ; im: -5/12 + sqrt33/12
    for name, xi in (('P', P), ('Q', Q)):
        a, b, c, S, val, r = v_of(xi)
        print(f"   his point {name}: alpha = {list(zip(a, b))}, c = {c}, S = {S}, v = 2S/c = {val} = {r} (mod 4)")
    allok &= check_field(3, 11, R, "(his field; p=3,q=11,pq=33=1 mod 32) - the theorem", True, extra=(P, Q))
    allok &= check_field(3, 43, R, "(in his family: 129 = 1 mod 32)", True)
    allok &= check_field(35, 11, R, "(in his family: 385 = 1 mod 32; p composite squarefree)", True)
    # controls: outside the family
    allok &= check_field(3, 5, R, "(CONTROL, wall broken: no additive 4-colouring exists - his map must fail)", False)
    check_field(19, 11, R, "(p,q = 3 mod 8 but pq = 209 = 17 mod 32: is pq = 1 mod 32 load-bearing for HIS map?)", True)
    check_field(3, 59, R, "(q = 59 = 11 mod 16, pq = 177 = 17 mod 32)", True)
    check_field(3, 19, R, "(q = 19 = 3 mod 16, not 11: pq = 57 = 25 mod 32)", True)
    # the owner's reading: his rho is the 2-adic embedding sqrt(pq) |-> u with u = 1 (mod 8), available iff pq = 1 (mod 16);
    # elsewhere use the actual 2-adic root mod 16 (u^2 = pq mod 32)
    check_field(3, 19, R, "(pq = 57: u = 5, 5^2 = 25 = 57 mod 32)", True, u=5)
    check_field(3, 11, R, "(WRONG u for pq = 33: control - must fail)", False, u=5)
    check_field(11, 43, R, "(p = q = 11 mod 16, pq = 473 = 25 mod 32; u = 5)", True, u=5)
    check_field(11, 43, R, "(same field, u = 1: his rho)", True, u=1)
    check_field(11, 59, R, "(pq = 649 = 9 mod 32; u = 3)", True, u=3)
    check_field(11, 59, R, "(same field, u = 1)", True, u=1)
    check_field(3, 35, R, "(p=3, q=35 = 3 mod 16: pq = 105 = 9 mod 32; u = 3)", True, u=3)
    check_field(19, 11, R, "(pq = 209 = 17 mod 32; u = 7, 49 = 17 mod 32)", True, u=7)
    # beyond his shape: q = 1 (mod 8), where sqrt q (not sqrt pq) is the 2-adically rational radical - trace out sqrt p
    check_field(3, 17, R, "(q = 17 = 1 mod 8: keep sqrt17, u = 7, 49 = 17 mod 32)", True, u=7, k=2)
    check_field(3, 17, R, "(same field, his k = 3: sqrt51 is no 2-adic square - control, expect failure)", False, u=1, k=3)
    check_field(3, 11, R, "(his field, keep sqrt3 instead: not 2-adically rational - control, expect failure)", False, u=1, k=1)
    check_field(3, 41, R, "(q = 41 = 9 mod 32: keep sqrt41, u = 3)", True, u=3, k=2)
    check_field(11, 17, R, "(p = 11, q = 17: keep sqrt17, u = 7)", True, u=7, k=2)
    print("VERDICT:", "OK" if allok else "FAIL")
    sys.exit(0 if allok else 1)

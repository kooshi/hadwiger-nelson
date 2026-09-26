#!/usr/bin/env python3
"""J51V: exact checks of derived claims (no search). FS-100 stage 4, blind verifier.

Checks, over F = Q, L = Q(i), R = Z[i][1/q : q = 1 mod 4], U = unit vectors = { z / conj(z) : z in Z[i] \\ 0 }:

  C1  theta, the dyadic parity character  theta(x + iy) = ((x + y) mod (1+i)) / 2,  has theta(u) = 1/2 on every sampled u.
  C2  psi_w(u) := frac_5(iota(u)),  psi_wbar(u) := frac_5(iota(conj u)),  iota : Q(i) -> Q_5 with iota(i) = 3 (mod 5), so that
      2 + i is the uniformiser at w.  For every sampled u, at least one of psi_w(u), psi_wbar(u) is exactly 0.
      Hence Theta(u) := (theta(u) + psi_w(u), theta(u) + psi_wbar(u)) has a coordinate exactly 1/2.
  C3  W(t1, t2) = 2*floor(2 t1) + floor(2 t2) makes x -> W(Theta(x) + t) proper on sampled edges (x, x + u), x in R, t rational.
  C4  psi_w(pi^-k) has exact order 5^k and psi_wbar(pi^-k) = 0 (pi = 2 + i), and symmetrically for conj(pi): the input to
      "no non-zero m has m1 psi_w + m2 psi_wbar in T + A" (the hand proof in plans/FS100-J51V-verification.md, stage 2).
  C5  (the KS-4/KS-5 control's arithmetic) row 94's C9: on the 8 points of x^2 + y^2 = 1 over F_7, (2x + 3y)/7 lies in {2,..,5}/7.

Every check is exact (fractions, modular arithmetic). The sample is a complete enumeration of z = m + ni with |m|, |n| <= B fixed in
advance (the derivation proves the claims for all u; the sample only checks the derivation's arithmetic).

Plants (each must make the run exit 1):
  --plant same-prime   second coordinate reads w instead of wbar   (C2/C3 must fire)
  --plant no-parity    theta dropped                               (C1/C2/C3 must fire)
  --plant c9-shift     C9 read as (x + y)/7                        (C5 must fire)
  (A first plant, (2x + 4y)/7, could NOT fire: exactly 8 linear forms put the F_7 circle in {2,..,5}/7 -- (2,3), (2,4), (3,2),
   (3,5), (4,2), (4,5), (5,3), (5,4) -- the orbit of (2,3) under the circle's symmetries. Kept here as a recorded unreachable plant.)
"""
from __future__ import annotations

import argparse
import random
import sys
from fractions import Fraction as Fr
from math import gcd, floor

P = 5
N_PREC = 40  # 5-adic precision for iota


def v_p(q: Fr, p: int) -> int:
    if q == 0:
        return 10**9
    v = 0
    a, b = q.numerator, q.denominator
    while a % p == 0:
        a //= p
        v += 1
    while b % p == 0:
        b //= p
        v -= 1
    return v


def iota_mod(k: int) -> int:
    """sqrt(-1) in Z_5 mod 5^k with iota = 3 mod 5 (Hensel)."""
    x = 3
    m = P
    while m < P**k:
        m2 = min(m * m, P**k)
        # Newton step for x^2 + 1 = 0
        x = (x - (x * x + 1) * pow(2 * x, -1, m2)) % m2
        m = m2
    x %= P**k
    assert (x * x + 1) % P**k == 0 and x % P == 3
    return x


IOTA = iota_mod(N_PREC)


def frac5(a: Fr, b: Fr) -> Fr:
    """frac_5(a + b*iota) in Z[1/5]/Z, as a Fraction in [0, 1)."""
    k = max(0, -min(v_p(a, P), v_p(b, P)))
    if k == 0:
        return Fr(0)
    assert k < N_PREC - 2
    mod = P**k
    A, B = a * mod, b * mod  # 5-integral rationals
    def red(q: Fr) -> int:
        return (q.numerator * pow(q.denominator, -1, mod)) % mod
    val = (red(A) + red(B) * (IOTA % mod)) % mod
    return Fr(val, mod)


class GI:
    """x + i y with x, y rational."""
    __slots__ = ("x", "y")

    def __init__(self, x, y):
        self.x, self.y = Fr(x), Fr(y)

    def __add__(self, o):
        return GI(self.x + o.x, self.y + o.y)

    def __mul__(self, o):
        return GI(self.x * o.x - self.y * o.y, self.x * o.y + self.y * o.x)

    def conj(self):
        return GI(self.x, -self.y)

    def norm(self):
        return self.x * self.x + self.y * self.y

    def inv(self):
        n = self.norm()
        return GI(self.x / n, -self.y / n)


def theta(z: GI) -> Fr:
    """dyadic parity: (x + y) mod (1 + i), as 0 or 1/2. Requires x, y 2-integral."""
    s = z.x + z.y
    assert v_p(z.x, 2) >= 0 and v_p(z.y, 2) >= 0, "not 2-integral"
    r = (s.numerator * pow(s.denominator, -1, 2)) % 2
    return Fr(r, 2)


def Theta(z: GI, plant: str) -> tuple[Fr, Fr]:
    t = Fr(0) if plant == "no-parity" else theta(z)
    a = frac5(z.x, z.y)
    zb = z if plant == "same-prime" else z.conj()
    b = frac5(zb.x, zb.y)
    return ((t + a) % 1, (t + b) % 1)


def W(t1: Fr, t2: Fr) -> int:
    return 2 * floor(2 * (t1 % 1)) + floor(2 * (t2 % 1))


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--B", type=int, default=40)
    ap.add_argument("--plant", default="none", choices=["none", "same-prime", "no-parity", "c9-shift"])
    ap.add_argument("--seed", type=int, default=51)
    args = ap.parse_args()
    plant = args.plant
    fails = []

    # the unit vectors z / conj z, z = m + n i, |m|, |n| <= B, gcd = 1
    U = []
    for m in range(-args.B, args.B + 1):
        for n in range(-args.B, args.B + 1):
            if (m, n) == (0, 0) or gcd(m, n) != 1:
                continue
            z = GI(m, n)
            u = z * z.conj().inv()
            assert u.norm() == 1
            U.append(u)
    print(f"sample: {len(U)} unit vectors (z = m + ni, |m|,|n| <= {args.B}, primitive)")

    # C1, C2
    n_neg_w = 0
    for u in U:
        if plant != "no-parity" and theta(u) != Fr(1, 2):
            fails.append(("C1", u.x, u.y))
        a, b = Theta(u, plant)
        if Fr(1, 2) not in (a, b):
            fails.append(("C2", u.x, u.y, a, b))
        if v_p(u.x, 5) < 0 or v_p(u.y, 5) < 0:
            n_neg_w += 1
    print(f"C1/C2 checked on {len(U)} unit vectors ({n_neg_w} with a pole above 5); failures so far: {len(fails)}")

    # C3: properness on edges (x, x + u), x a sum of up to 4 unit vectors (plus 0), t rational
    rng = random.Random(args.seed)
    n_edges = 0
    for _ in range(4000):
        x = GI(0, 0)
        for _ in range(rng.randint(0, 4)):
            x = x + rng.choice(U)
        u = rng.choice(U + [GI(1, 0)])
        t = (Fr(rng.randint(0, 10**6), 10**6), Fr(rng.randint(0, 10**6), 10**6))
        a = Theta(x, plant)
        b = Theta(x + u, plant)
        if W(a[0] + t[0], a[1] + t[1]) == W(b[0] + t[0], b[1] + t[1]):
            fails.append(("C3", x.x, x.y, u.x, u.y, t))
        n_edges += 1
    print(f"C3 properness checked on {n_edges} edges; failures so far: {len(fails)}")

    # C4: orders at pi^-k and conj(pi)^-k
    pi = GI(2, 1)
    for k in range(1, 9):
        z = GI(1, 0)
        for _ in range(k):
            z = z * pi.inv()
        a = frac5(z.x, z.y)
        zb = z.conj()
        b = frac5(zb.x, zb.y)
        if not (a.denominator == P**k and b == 0):
            fails.append(("C4", k, a, b))
        # symmetric: conj(pi)^-k
        a2 = frac5(zb.x, zb.y)
        b2 = frac5(z.x, z.y)
        if not (a2 == 0 and b2.denominator == P**k):
            fails.append(("C4bar", k, a2, b2))
    print(f"C4 orders checked for k = 1..8; failures so far: {len(fails)}")

    # C5: C9 on the circle over F_7
    circ = [(x, y) for x in range(7) for y in range(7) if (x * x + y * y) % 7 == 1]
    cx, cy = (1, 1) if plant == "c9-shift" else (2, 3)
    vals = sorted({(cx * x + cy * y) % 7 for (x, y) in circ})
    if len(circ) != 8 or not set(vals) <= {2, 3, 4, 5}:
        fails.append(("C5", circ, vals))
    print(f"C5: {len(circ)} circle points over F_7, values of 7*theta_C9: {vals}")

    if fails:
        print(f"FAIL: {len(fails)} failures; first: {fails[0]}")
        return 1
    print("ALL CHECKS PASS")
    return 0


if __name__ == "__main__":
    sys.exit(main())

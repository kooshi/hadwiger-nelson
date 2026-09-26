#!/usr/bin/env python3
"""X12B exact check (seconds): the usable multipliers of the Einsiedler-Fish transfer.

Derived claim checked: the unit vectors of Q(i) (u = (a+bi)/c, a^2+b^2=c^2, gcd(a,b,c)=1) with denominator c <= X
number at least X at each checkpoint X in {5,...,1500} below (asymptotically 4X/pi, the classical
count of primitive Pythagorean triples, 8 vectors each, plus the 4 units), and each has |u|_v = 1 at every archimedean place
(a^2+b^2 = c^2 exactly). Over a real field F of degree d these lie in U_F with height H_L(u) = c^d, so
#{u in U_F : H(u) <= M} >= M^(1/d) -- the count the transfer uses.

Planted fault (--plant): count only a>0, b>0 (drop the sign/swap orbit); the >= X bound must then FAIL, and the
script exits 1 on a failed check, so a plant that did not fire is itself reported.
"""
import sys
from math import gcd, isqrt, pi

def count(X, plant=False):
    n = 0
    for c in range(1, X + 1):
        for a in range(-c, c + 1):
            b2 = c * c - a * a
            b = isqrt(b2)
            if b * b != b2:
                continue
            for bb in ({b, -b} if b else {0}):
                if plant and (a <= 0 or bb <= 0):
                    continue
                if gcd(gcd(abs(a), abs(bb)), c) == 1:
                    n += 1
    return n

def main():
    plant = "--plant" in sys.argv
    XMAX = 1500
    ok = True
    # direct evaluation at checkpoints (exact, seconds)
    for X in (5, 10, 25, 50, 100, 250, 500, 1000, XMAX):
        n = count(X, plant)
        good = n >= X
        ok &= good
        print(f"X={X:5d}  #unit vectors of Q(i) with den<=X = {n:6d}   4X/pi = {4*X/pi:9.1f}   >= X: {good}")
    print("PLANT" if plant else "SHIPPED", "RESULT:", "ALL CHECKS PASS" if ok else "A CHECK FAILED")
    sys.exit(0 if ok else 1)

if __name__ == "__main__":
    main()

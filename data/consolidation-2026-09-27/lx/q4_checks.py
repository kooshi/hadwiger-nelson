#!/usr/bin/env python3
"""Job LX, stage 1: exact arithmetic checks of the hand derivation of the Q^4 compulsion law.

Nothing here searches for a witness; every check is an identity or a finite exact verification
of a derived statement (seconds). Exits non-zero on any failure, and plants two faults that must
fire (a wrong gadget point, Zaks's uncorrected point D) so that a pass is seen to mean something.

Quaternion convention: x = (x0, x1, x2, x3) = x0 + x1 i + x2 j + x3 k, N(x) = sum x_i^2.
"""
from fractions import Fraction as Fr
from itertools import product
import sys

F = Fr
FAILS = []


def check(cond, msg):
    if not cond:
        FAILS.append(msg)
        print("FAIL:", msg)
    return cond


def N(x):
    return sum(c * c for c in x)


def sub(x, y):
    return tuple(a - b for a, b in zip(x, y))


def add(x, y):
    return tuple(a + b for a, b in zip(x, y))


def qmul(x, y):
    a1, b1, c1, d1 = x
    a2, b2, c2, d2 = y
    return (a1 * a2 - b1 * b2 - c1 * c2 - d1 * d2,
            a1 * b2 + b1 * a2 + c1 * d2 - d1 * c2,
            a1 * c2 - b1 * d2 + c1 * a2 + d1 * b2,
            a1 * d2 + b1 * c2 - c1 * b2 + d1 * a2)


def v2(r):
    r = Fr(r)
    if r == 0:
        return float("inf")
    n, d, v = r.numerator, r.denominator, 0
    while n % 2 == 0:
        n //= 2
        v += 1
    while d % 2 == 0:
        d //= 2
        v -= 1
    return v


def w(x):
    return v2(N(x))


h = F(1, 2)

# 1. The five-point gadget: K5 minus one edge; the missing pair is at squared distance 2.
def gadget_ok(pts):
    O, one, v, a, b = pts
    unit_pairs = [(O, one), (O, v), (one, v), (a, O), (a, one), (a, v), (b, O), (b, one), (b, v)]
    return all(N(sub(p, q)) == 1 for p, q in unit_pairs), N(sub(a, b))

G = [(0, 0, 0, 0), (1, 0, 0, 0), (h, h, h, h), (h, h, h, -h), (h, h, -h, h)]
G = [tuple(F(c) for c in p) for p in G]
ok, nab = gadget_ok(G)
check(ok and nab == 2, "gadget: nine unit edges and N(a-b) = 2")
# (1/2,-1/2,1/2,1/2) is NOT a fault: it is a third apex on the same circle (adjacent to 0, 1, v),
# so a plant must leave the circle. Planted fault: b = (1/2,1/2,-1/2,-1/2), at N = 2 from v.
Gother = G[:4] + [tuple(F(c) for c in (h, -h, h, h))]
check(gadget_ok(Gother)[0], "third apex (1/2,-1/2,1/2,1/2) also adjacent to 0, 1, v")
Gbad = G[:4] + [tuple(F(c) for c in (h, h, -h, -h))]
okb, nabb = gadget_ok(Gbad)
check(not okb, "planted gadget fault fires")
print("gadget: ok =", ok, "N(a-b) =", nab, "| planted: ok =", okb)

# 2. Zaks 1999 p. 91: A, B, C, D mutually at distance 1; E at distance 1 from B, C, D; |A-E|^2 = 2.
A = (h, 0, 0, h); B = (h, 0, 0, -h); C = (0, h, h, 0); D = (0, h, -h, 0); E = (-h, 0, 0, -h)
A, B, C, D, E = [tuple(F(c) for c in p) for p in (A, B, C, D, E)]
check(all(N(sub(p, q)) == 1 for p, q in [(A, B), (A, C), (A, D), (B, C), (B, D), (C, D)]),
      "Zaks: A,B,C,D a unit K4")
check(all(N(sub(E, q)) == 1 for q in (B, C, D)), "Zaks: E adjacent to B, C, D")
check(N(sub(A, E)) == 2, "Zaks: |A-E|^2 = 2")

# 3. Zaks p. 92 first proof of Lemma 2: A=0, C=(2,0,0,0); printed D=(0,1,0,0) vs Johnson's correction (1,1,0,0).
A2, C2 = (0, 0, 0, 0), (2, 0, 0, 0)
Dp, Dc = (0, 1, 0, 0), (1, 1, 0, 0)
print("Zaks printed D: N(D-A) =", N(sub(Dp, A2)), "N(D-C) =", N(sub(Dp, C2)))
print("Johnson-corrected D: N(D-A) =", N(sub(Dc, A2)), "N(D-C) =", N(sub(Dc, C2)))
check(not (N(sub(Dp, A2)) == 2 and N(sub(Dp, C2)) == 2), "printed D is NOT at distance sqrt2 from both (planted-style fault fires)")
check(N(sub(Dc, A2)) == 2 and N(sub(Dc, C2)) == 2, "corrected D at distance sqrt2 from both")

# 4. Zaks p. 92 second proof: the matrix is a similarity by sqrt 2 (M M^T = 2 I).
M = [[1, 0, 0, 1], [1, 0, 0, -1], [0, 1, 1, 0], [0, 1, -1, 0]]
MMt = [[sum(M[i][k] * M[j][k] for k in range(4)) for j in range(4)] for i in range(4)]
check(MMt == [[2 if i == j else 0 for j in range(4)] for i in range(4)], "Zaks matrix: M M^T = 2 I")

# 5. The valuation w = v2 o N on a box of rationals: multiplicative, and ultrametric.
vals = [F(n, d) for n in range(-4, 5) for d in (1, 2, 3, 4, 6)]
box = list({tuple(x) for x in product(vals[::3], repeat=4)})
box = [x for x in box if any(x)][:900]
mult_ok = all(w(qmul(x, y)) == w(x) + w(y) for x in box[:120] for y in box[:120])
ultra_ok = all(w(add(x, y)) >= min(w(x), w(y)) for x in box[:200] for y in box[:200])
check(mult_ok, "w multiplicative on sample")
check(ultra_ok, "w ultrametric on sample")
# the key step of the hand proof: N(z) in Z_(2) forces 2 z0 in Z_(2)
check(all(v2(2 * z[0]) >= 0 for z in box if w(z) >= 0), "w(z) >= 0 implies tr z = 2 z0 in Z_(2)")

# 6. R/P has four classes, and the K4 {0, 1, v, a} meets each (pairwise differences all of w = 0).
K4 = G[:4]
check(all(w(sub(p, q)) == 0 for p in K4 for q in K4 if p != q), "K4 differences are units (w = 0)")
# index count on a finite model: R/P = (H/2H... ) use Hurwitz elements with coordinates in {0,1/2,1,3/2}
reps = []
cands = [x for x in product([F(0), h, F(1), F(3, 2)], repeat=4)
         if len({c.denominator for c in x}) == 1]  # all integral or all half-odd: Hurwitz
for x in cands:
    if not any(w(sub(x, r)) >= 1 for r in reps):
        reps.append(x)
check(len(reps) == 4, "R/P has exactly 4 classes on the Hurwitz sample (got %d)" % len(reps))

# 7. 1/p in the ring Z[S]: u = ((p-1) + b i + c j + d k)/p with b^2+c^2+d^2 = 2p-1 is a unit quaternion,
#    and u + conj(u) = 2(p-1)/p. (b, c, d found by direct arithmetic; Legendre guarantees existence.)
def three_squares(n):
    r = int(n ** 0.5) + 1
    for b in range(r + 1):
        for c in range(b, r + 1):
            d2 = n - b * b - c * c
            if d2 < c * c:
                break
            d = int(round(d2 ** 0.5))
            if d * d == d2:
                return b, c, d
    return None

primes = [p for p in range(3, 400) if all(p % q for q in range(2, int(p ** 0.5) + 1))]
for p in primes:
    t = three_squares(2 * p - 1)
    check(t is not None, "2p-1 sum of three squares, p=%d" % p)
    b, c, d = t
    u = (F(p - 1, p), F(b, p), F(c, p), F(d, p))
    check(N(u) == 1, "unit quaternion for p=%d" % p)
    check(2 * u[0] == F(2 * (p - 1), p), "trace for p=%d" % p)
    # 1/p = ((p+1)/2) * (2 - (u + conj u)) - 1
    check(F(p + 1, 2) * (2 - 2 * u[0]) - 1 == F(1, p), "1/p identity for p=%d" % p)

# 8. The scaling map x -> q x multiplies squared distances by N(q) (N multiplicative).
q = (F(1), F(1), F(0), F(0))  # N(q) = 2
check(all(N(qmul(q, x)) == 2 * N(x) for x in box[:300]), "N(qx) = N(q) N(x)")

print("checks:", "PASS" if not FAILS else "FAIL (%d)" % len(FAILS))
sys.exit(1 if FAILS else 0)

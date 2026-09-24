"""Verifier 2: the 90 characters of Theta_5 on one component M = L5 = (1/3)O_E, classified by locality at the primes above 2 and 5."""
from collections import Counter
from lat import *
from theta import theta_set, order, value, annihilated

# M-coordinates: y = (Lambda-coords)/3 ; basis of M is 3*(Lambda basis) = (1/3)(1, z, w, zw)
UM = {key: tuple(c // 3 for c in v) for key, v in ULAM.items() if abs(key[1]) <= 2}
assert all(all(c % 3 == 0 for c in ULAM[key]) for key in UM)
Th = theta_set(range(-2, 3), UM, [0, 1, -1, 2])
print("|Theta_5 on M| =", len(Th), "orders", sorted(Counter(order(t) for t in Th).items()), "P =", annihilated(Th))

BETA = scal(Fr(1, 2), add(scal(5, ONE), scal(-1, mul(SQRTm3, SQRTm11))))    # (5 + sqrt33)/2
BETAb = scal(Fr(1, 2), add(scal(5, ONE), mul(SQRTm3, SQRTm11)))             # (5 - sqrt33)/2
assert mul(BETA, BETAb) == scal(-2, ONE)
def mcoords(x):
    y = [3 * a for a in x]
    assert all(a.denominator == 1 for a in y), x
    return tuple(int(a) for a in y)
basisOE = [ONE, Z6, W, mul(Z6, W)]
def ideal_gens(gen):
    """M-coordinates of (1/3) gen O_E."""
    return [mcoords(scal(Fr(1, 3), mul(gen, b))) for b in basisOE]
Pp = ideal_gens(power(BETA, 3)); Pm = ideal_gens(power(BETAb, 3)); F5 = ideal_gens(scal(5, ONE))
def trivial_on(t, gens):
    return all(value(t, g) == 0 for g in gens)
cls = Counter()
table = {}
for t in Th:
    key = (order(t), trivial_on(t, Pp), trivial_on(t, Pm), trivial_on(t, F5))
    cls[key] += 1
    table.setdefault(key, []).append(t)
print("(order, trivial on (1/3)beta^3 O, trivial on (1/3)beta'^3 O, trivial on 5M) -> count")
for k, v in sorted(cls.items()):
    print("  ", k, v)

# ---- the order-10 characters: 2-part and 5-part ----
def part(t, p):
    """p-primary part of a character t (all orders here are 2^a 5^b)."""
    o = order(t)
    q = 1
    while o % p == 0:
        o //= p; q *= p
    # e * t with e = 1 mod q, e = 0 mod o
    e = next(e for e in range(q * o) if e % q == 1 % q and e % o == 0)
    return tuple((e * a) % 1 for a in t)
by2 = {}
for t in table[(10, False, False, False)]:
    t2, t5 = part(t, 2), part(t, 5)
    by2.setdefault(t2, []).append(t5)
print("order-10 characters grouped by 2-part:", {k: len(v) for k, v in by2.items()})
loc = {t: ("P+" if trivial_on(t, Pp) else "P-" if trivial_on(t, Pm) else "mixed") for t in by2}
print("locality of those 2-parts:", loc)
print("are those 2-parts in Theta? ", [t in Th for t in by2])
# 5-parts: for each 2-part, the set of 5-parts in F5^4 (as integer vectors 5t mod 5); check they are 2 lines through 0
for t2, fives in by2.items():
    vs = [tuple(int(5 * a) % 5 for a in t5) for t5 in fives]
    lines = set()
    for v in vs:
        # normalise the line spanned by v: first nonzero coordinate 1
        i = next(i for i in range(4) if v[i]); inv5 = pow(v[i], -1, 5)
        lines.add(tuple((inv5 * c) % 5 for c in v))
    closed = all(tuple((s * c) % 5 for c in v) in set(vs) for v in vs for s in range(1, 5))
    print(" 2-part", t2, "->", len(vs), "5-parts on", len(lines), "lines", sorted(lines), "closed under F5*:", closed)

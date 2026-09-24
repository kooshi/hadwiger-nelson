"""Verifier 2 -- exact facts for W4, W5 and W (each asserted; --plant N plants fault N).

 G1  sqrt-3 * eta^k lies in L5 = (1/3)O for |k| <= 3 and in L7 = (sqrt-3/9)O for |k| <= 4: every alternate triple of families
     +-3 lies in one coset of L5, of families +-4 in one coset of L7 (both ideals are zeta_6-stable).
 G2  Theta_all (42) = 21 characters trivial on P+ = (1/9)beta^3 O  +  21 trivial on P- = (1/9)beta~^3 O; none mixed.
 G3  Theta_{|k|<=3} on the group L7: its characters (reported; the W4 route below does not depend on it).
 G4  Z[zeta_6] meets P+ in 8 Z[zeta_6]; the 54 unit vectors reduce mod P+ to exactly the 12 classes {+-1, +-3} * {1, w, w^2}
     (w = zeta_6^2) of Z[zeta_6]/8; the same mod P-.  eta mod P+ and mod P- (the chirality).
"""
import sys
from collections import Counter
from lat import *
from theta import theta_set, order, value, annihilated
PLANT = int(sys.argv[sys.argv.index("--plant") + 1]) if "--plant" in sys.argv else 0

basisOE = [ONE, Z6, W, mul(Z6, W)]
def ideal_H(gen, scale):
    return hnf_rows([list(lam(scal(scale, mul(gen, b)))) for b in basisOE])
H5 = ideal_H(ONE, Fr(1, 3)); H7 = ideal_H(SQRTm3, Fr(1, 9))
# G1
for k in range(-3, 4):
    v = lam(mul(SQRTm3, power(ETA, k))); assert v is not None and in_lattice(v, H5), k
for k in range(-4, 5):
    v = lam(mul(SQRTm3, power(ETA, k))); assert v is not None and in_lattice(v, H7), k
if PLANT == 1:
    v = lam(mul(SQRTm3, power(ETA, 4))); assert in_lattice(v, H5), "plant 1: family 4 is not inside L5 (expected to fire)"
print("G1 ok: alternate triples of families +-3 lie in L5-cosets, of families +-4 in L7-cosets")

# G2
BETA = scal(Fr(1, 2), add(scal(5, ONE), scal(-1, mul(SQRTm3, SQRTm11))))
BETAt = scal(Fr(1, 2), add(scal(5, ONE), mul(SQRTm3, SQRTm11)))
Pp = [lam(scal(Fr(1, 9), mul(power(BETA, 3), b))) for b in basisOE]
Pm = [lam(scal(Fr(1, 9), mul(power(BETAt, 3), b))) for b in basisOE]
if PLANT == 2:
    Pm = [lam(scal(Fr(1, 9), mul(power(BETAt, 2), b))) for b in basisOE]
ThA = theta_set(range(-4, 5), ULAM, [0, 1, -1, 2])
tp = [t for t in ThA if all(value(t, g) == 0 for g in Pp)]
tm = [t for t in ThA if all(value(t, g) == 0 for g in Pm)]
assert len(ThA) == 42 and len(tp) == 21 and len(tm) == 21 and not set(tp) & set(tm), (len(ThA), len(tp), len(tm))
print("G2 ok: Theta_all = 21 (P+-local) + 21 (P- local), none mixed")
# the brief's P- = (1/9) beta^-3 O contains Lambda:
bad = [scal(Fr(1, 9), mul(power(conj(BETA), 0), b)) for b in basisOE]   # placeholder to keep names
Binv3 = power(scal(Fr(-1, 2), BETAt), 3)          # beta^-1 = -beta~/2
assert mul(Binv3, power(BETA, 3)) == ONE
contains = all(lam(x) is not None for x in [scal(Fr(1, 9), b) for b in basisOE]) and \
    all(all(a.denominator == 1 for a in mul(scal(9, scal(Fr(1, 9), b)), power(BETA, 3))) for b in basisOE)
print("   the brief's (1/9) beta^-3 O contains Lambda (Lambda * beta^3 inside (1/9)O... i.e. 9x beta^3 integral):", contains)

# G3
L7basis = H7
L7i = inv([[Fr(a) for a in r] for r in L7basis])
U7 = {key: tuple(int(sum(Fr(v[i]) * L7i[i][j] for i in range(4))) for j in range(4)) for key, v in ULAM.items() if abs(key[1]) <= 3}
# check the coordinates really are integral and reproduce
for key, v in ULAM.items():
    if abs(key[1]) <= 3:
        c = [sum(Fr(v[i]) * L7i[i][j] for i in range(4)) for j in range(4)]
        assert all(x.denominator == 1 for x in c)
Th7 = theta_set(range(-3, 4), U7, [0, 1, -1, 2])
print("G3: |Theta_{|k|<=3} on L7| =", len(Th7), "orders", sorted(Counter(order(t) for t in Th7).items()), "P =", annihilated(Th7))

# G4
Zz = [ONE, Z6]
def mod_Pplus_rep(u, P):
    """the class of u mod the lattice P (Lambda-coords rows), searched among Z[z6]/8 representatives a + b z6, 0 <= a, b < 8."""
    HP = hnf_rows([list(p) for p in P])
    reps = [(a, b) for a in range(8) for b in range(8) if in_lattice(tuple(x - y for x, y in zip(ULAM_or(u), lam(add(scal(a, ONE), scal(b, Z6))))), HP)]
    return reps
def ULAM_or(u):
    return u if isinstance(u[0], int) else lam(u)
for name, P in (("P+", Pp), ("P-", Pm)):
    HP = hnf_rows([list(p) for p in P])
    # Z[z6] n P = 8 Z[z6]: 8 and 8 z6 are in P, and no a + b z6 with (a, b) != 0 mod 8 is
    assert in_lattice(lam(scal(8, ONE)), HP) and in_lattice(lam(scal(8, Z6)), HP)
    zero = [(a, b) for a in range(8) for b in range(8) if in_lattice(lam(add(scal(a, ONE), scal(b, Z6))), HP)]
    assert zero == [(0, 0)], zero
    img = Counter()
    for key, u in ULAM.items():
        r = mod_Pplus_rep(u, P); assert len(r) == 1; img[r[0]] += 1
    # expected: {+-1, +-3} * {1, w, w^2}, w = z6^2 = z6 - 1  ->  w = (-1, 1), w^2 = -z6 = (0, -1)
    def ez(a, b): return (a % 8, b % 8)
    expect = set()
    for t in (1, 3, 5, 7):
        expect |= {ez(t, 0), ez(-t, t), ez(0, -t)}
    assert set(img) == expect, (name, sorted(img))
    eta_r = mod_Pplus_rep(ETA, P)[0]
    print(f"G4 ok at {name}: Z[z6] n {name} = 8Z[z6]; U mod {name} = the 12 classes {{+-1,+-3}}*mu3 (multiplicities {sorted(img.values())}); "
          f"eta = {eta_r[0]} + {eta_r[1]} z6 mod {name}")

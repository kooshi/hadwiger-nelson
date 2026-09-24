"""Verifier 2: basic exact facts about Lambda, U and its family sublattices (checks of derived claims only)."""
from lat import *

# unit vectors are unit, in Lambda, and 54 distinct
assert all(sqnorm(u) == 1 for u in U.values())
assert all(v is not None for v in ULAM.values()), [k for k, v in ULAM.items() if v is None]
assert len(set(ULAM.values())) == 54
print("eta Lambda-coords", lam(ETA), "eta^2", lam(power(ETA, 2)), "eta^3", lam(power(ETA, 3)))
# eta^5 not in Lambda (control that membership can fail)
assert lam(power(ETA, 5)) is None and lam(power(ETA, -5)) is None
# eta^2 = (5 + sqrt-11)/6
assert power(ETA, 2) == scal(Fr(1, 6), add(scal(5, ONE), SQRTm11))

def span_index(keys):
    return index_of([ULAM[k] for k in keys])

for name, K in [("all", range(-4, 5)), ("L7 |k|<=3", range(-3, 4)), ("L5 |k|<=2", range(-2, 3)), ("L3 |k|<=1", range(-1, 2))]:
    idx, H = span_index([(j, k) for k in K for j in range(6)])
    print(name, "index in Lambda:", idx, "HNF:", H)

# identify L5 and L7 with ideals: (1/3)O_E has Lambda-coords 3Z^4; (1/(3 sqrt-3))O_E ...
idx5, H5 = span_index([(j, k) for k in range(-2, 3) for j in range(6)])
H3 = hnf_rows([[3 if i == j else 0 for j in range(4)] for i in range(4)])
print("L5 == (1/3)O_E:", H5 == H3)
# (1/(3 sqrt-3)) O_E = (1/9) sqrt-3 O_E  (since 1/(3 sqrt-3) = -sqrt-3/9)
basisOE = [ONE, Z6, W, mul(Z6, W)]
rows = [lam(scal(Fr(1, 9), mul(SQRTm3, b))) for b in basisOE]
idx7, H7 = span_index([(j, k) for k in range(-3, 4) for j in range(6)])
print("L7 == (sqrt-3/9) O_E:", H7 == hnf_rows(rows), "index", idx7)

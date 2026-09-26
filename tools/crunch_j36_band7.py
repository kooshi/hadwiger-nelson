"""J36 exact check: does Gamma_7 = Cay(F_49, mu_8) carry a band-k character?
A character psi_a(x) = e(Tr(a x)/7) of (F_49,+) is band-k iff Tr(a u) mod 7, read as j/7 in [0,1), lies in
[1/k, 1 - 1/k] for every u in mu_8 (the norm-one group, the unit vectors mod 7).  Complete enumeration of the 48 non-zero a.
F_49 = F_7[i], i^2 = -1 (7 = 3 mod 4); Tr(x + y i) = 2x.  Plant: PLANT=1 replaces the band by [0,1) (every character passes),
which must make the 'no band character' verdict fail loudly."""
import os, sys
from fractions import Fraction as Q
p = 7
def mul(a, b):
    return ((a[0]*b[0] - a[1]*b[1]) % p, (a[0]*b[1] + a[1]*b[0]) % p)
def tr(a):
    return (2*a[0]) % p
F = [(x, y) for x in range(p) for y in range(p)]
mu = [z for z in F if (z[0]*z[0] + z[1]*z[1]) % p == 1]
assert len(mu) == p + 1, len(mu)
plant = os.environ.get("PLANT") == "1"
out = []
for k in (3, 4, 5):
    lo, hi = Q(1, k), Q(k - 1, k)
    good = []
    for a in F:
        if a == (0, 0):
            continue
        vals = [Q(tr(mul(a, u)), p) for u in mu]
        if plant or all(lo <= v <= hi for v in vals):
            good.append(a)
    out.append(f"k={k}: band-{k} characters of Gamma_7 at level one: {len(good)}")
print("\n".join(out))
four = [l for l in out if l.startswith("k=4")][0]
if not four.endswith(": 0"):
    print("VERDICT: Gamma_7 HAS a band-4 character" + (" (PLANT fired)" if plant else ""))
    sys.exit(1 if plant else 0)
print("VERDICT: Gamma_7 has NO band-4 character at level one")

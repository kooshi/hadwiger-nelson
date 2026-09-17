#!/usr/bin/env python3
"""fs58_subpool -- survey unions of direction classes (axis, the (3/5,4/5) family, the sqrt-d vectors of given denominators) of Q(sqrt d)(i) over a
common denominator M: pairs, covolume in the Minkowski embedding, largest reduced coordinate. Usage: D M DENS (comma list). FS-58 §R-B4.
"""
import sys, itertools, math, json
sys.path.insert(0, str(__import__('pathlib').Path(__file__).resolve().parent))
from fs58_chain import hnf_basis, lll, det, inverse, _det_frac
from fs58_local import units_d
from fractions import Fraction
d = int(sys.argv[1]); M = int(sys.argv[2]); dens = [int(x) for x in sys.argv[3].split(',')]
# every class as vectors over the common denominator M
def scaled(N):
    return [tuple(x * (M // N) for x in w) for w in units_d(N, d)]
classes = {'axis': [w for w in scaled(M) if w in {(M,0,0,0),(-M,0,0,0),(0,0,M,0),(0,0,-M,0)}]}
qi5 = [w for w in scaled(5 if M % 5 == 0 else M) if w[1] == 0 and w[3] == 0 and 0 not in (w[0], w[2])] if M % 5 == 0 else []
if qi5: classes['qi5'] = [tuple(x * (M // 5) for x in w) for w in units_d(5, d) if w[1] == 0 and w[3] == 0 and 0 not in (w[0], w[2])]
for N in dens:
    classes[f'W{N}*'] = [w for w in scaled(N) if w[1] or w[3]]
names = list(classes)
print(f"d={d} M={M} classes: " + ", ".join(f"{n}:{len(classes[n])}" for n in names))
form = (1, d, 1, d)
rows = []
for r in range(1, len(names) + 1):
    for combo in itertools.combinations(names, r):
        W = sorted(set(itertools.chain.from_iterable(classes[n] for n in combo)))
        if len(W) < 10: continue
        ech = hnf_basis(W)
        if len(ech) < 4: continue
        B = lll(ech, form)
        Binv = inverse(B)
        co = [[sum(Fraction(x) * Binv[i][j] for i, x in enumerate(w)) for j in range(4)] for w in W]
        mc = max(abs(int(x)) for c in co for x in c)
        gram = [[Fraction(2 * sum(f * x * y for f, x, y in zip(form, u, v)), M * M) for v in B] for u in B]
        cov = math.sqrt(float(_det_frac(gram)))
        rows.append((mc, -len(W), combo, len(W) // 2, cov))
rows.sort()
for mc, _, combo, pairs, cov in rows[:10]:
    print(f"  max coord {mc:3d}  pairs {pairs:3d}  covolume {cov:.3g}  {'+'.join(combo)}")

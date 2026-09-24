"""Verifier 2: every Z-linear map phi: L5 -> Lambda with phi(U5) inside U5 (injective or not); which family receives family 0."""
from lat import *
U5keys = [key for key in ULAM if abs(key[1]) <= 2]
vecs = [ULAM[k] for k in U5keys]
fam = {ULAM[k]: k[1] for k in U5keys}
B = [ULAM[(0, 0)], ULAM[(1, 0)], ULAM[(0, 1)], ULAM[(1, 1)]]
Bi = inv([list(b) for b in B])
coef = {v: [sum(Fr(v[i]) * Bi[i][j] for i in range(4)) for j in range(4)] for v in vecs}
T = set(vecs)
def img(v, im):
    c = coef[v]; o = [sum(c[j] * im[j][i] for j in range(4)) for i in range(4)]
    return tuple(int(x) for x in o) if all(x.denominator == 1 for x in o) else None
res = {}
for a in vecs:
    for b in vecs:
        if any(img(v, [a, b, a, a]) not in T for v in vecs if fam[v] == 0): continue
        for c in vecs:
            for d in vecs:
                im = [a, b, c, d]
                ims = [img(v, im) for v in vecs]
                if all(x in T for x in ims):
                    key = (fam[a], len(set(ims)))
                    res[key] = res.get(key, 0) + 1
print("(family receiving family 0, number of distinct images of U5) -> count:", res)

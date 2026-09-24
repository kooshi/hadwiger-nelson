"""AIMING ONLY (logged in the search log): where does the weighted symbol p_w(theta) = sum_u w_u cos(2 pi theta.u) of
Cay(Lambda, U) go below -d_w/3 on the continuous torus? Coordinates: u in the O_E basis times 9 (integer 4-vectors), theta in R^4/Z^4
acting as theta.(9 coords)/9 ... we use theta on Lambda's basis (1/9)(1,z6,w,z6w)."""
import numpy as np, itertools
from lam import *
from twoadic import emb
from collections import Counter
U = load_U()
UC = np.array([[int(9*x) for x in coords(u)] for u in U])      # Lambda-coordinates (basis (1/9)O_E basis)
key = [(emb(u,1)[0]%8, emb(u,1)[1]%8, emb(u,-1)[0]%8, emb(u,-1)[1]%8) for u in U]
cnt = Counter(key)
w_half = np.array([1.0/cnt[k] for k in key])
w_one = np.ones(len(U))
def p(theta, w):  # theta: (n,4)
    return (np.cos(2*np.pi*theta @ UC.T) * w).sum(axis=1)
rng = np.random.default_rng(1)
for name, w in [('unweighted', w_one), ('collision-halved', w_half)]:
    d = w.sum()
    th = rng.random((200000, 4))
    v = p(th, w)
    i = v.argmin()
    # local refine by crude coordinate descent
    t = th[i].copy(); best = v[i]; step = 0.01
    for it in range(4000):
        cand = t + rng.normal(0, step, (64,4))
        vv = p(cand, w); j = vv.argmin()
        if vv[j] < best: best = vv[j]; t = cand[j]
        else: step *= 0.97
        if step < 1e-9: break
    print(name, 'd=%.1f  -d/3=%.4f  random-min=%.4f  refined-min=%.6f at theta=%s' % (d, -d/3, v.min(), best, np.round(t % 1, 5)))
    # torsion points of small order
    for n in [2,3,4,5,6,7,8,9,10,12,16]:
        grid = np.array(list(itertools.product(range(n), repeat=4)))/n
        vv = p(grid, w)
        print('   order |', n, ': min %.5f' % vv.min(), ' count <= -d/3+1e-9:', int((vv <= -d/3 + 1e-9).sum()))

import sys, itertools, numpy as np
sys.path.insert(0, '/home/kooshi/source/lean-dir/tools')
import fs73_q167 as T
d = np.load('ball14.npz'); X, col, E = d['X'], d['col'], d['E']
coords = [tuple(c) for c in d['coords']]
res = T.circular_search(coords, 47, nmin=23)
perms = [np.array(p) for p in itertools.permutations(range(3))]
def best_fit(Xs, cs, forms):
    best = (0, None)
    for N, phi in forms:
        v = (Xs @ np.array(phi)) % N
        for sh in range(N):
            base = (3 * ((v + sh) % N)) // N
            for p in perms:
                a = (p[base] == cs).mean()
                if a > best[0]: best = (a, (N, phi, sh, tuple(p)))
    return best
forms = [(N, phi) for N, sols in res for phi in sols]
print(len(forms), 'forms at N in', [N for N,_ in res])
for N, sols in res: print(N, sols)
b = best_fit(X, col, forms)
print('global best', round(b[0], 4), b[1])
# patches: sub-balls of radius ~0.35 in both embeddings about random centres
from fs58_search import embed_matrix
B = d['B']
Y = X @ embed_matrix(167, 120, [list(r) for r in B])
rng = np.random.default_rng(1)
for t in range(10):
    c = Y[rng.integers(len(X))]
    sel = (np.hypot(*(Y[:, :2] - c[:2]).T) < 0.4) & (np.hypot(*(Y[:, 2:] - c[2:]).T) < 0.4)
    bb = best_fit(X[sel], col[sel], forms)
    print('patch', t, 'points', int(sel.sum()), 'best local agreement', round(bb[0], 4), bb[1])

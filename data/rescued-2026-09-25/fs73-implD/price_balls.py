import sys, time, json, numpy as np
sys.path.insert(0, 'tools')
import fs73_screen as S
spec = sys.argv[1]; tgt = sys.argv[2]; R = int(sys.argv[3])
lat, r, U, T = S.rich_setup(spec)
d = T[tgt]
t0 = time.time()
B = S.word_ball(U, R)
Bs = set(B)
pts = sorted(Bs | {tuple(a + b for a, b in zip(p, d)) for p in B})
idx, E = S.ball_graph(pts, U)
n = len(pts)
deg = np.bincount(E.ravel(), minlength=n)
# word length of each point w.r.t. the nearer centre, by BFS from {0, d}
from collections import deque
wl = {tuple([0]*r): 0, tuple(d): 0}; q = deque(wl)
adj = {}
while q:
    p = q.popleft()
    for u in U:
        y = tuple(a + b for a, b in zip(p, u))
        if y in idx and y not in wl:
            wl[y] = wl[p] + 1; q.append(y)
shell = [idx[p] for p in pts if wl.get(p) == R]
cores = {}
for m in (4, 8, 12, 14, 16):
    c = S.core(n, E, m, keep=(idx[tuple([0]*r)], idx[tuple(d)]))
    cores[m] = len(c)
print(json.dumps({'spec': spec, 'target': tgt, 'R': R, 'points': n, 'edges': int(len(E)), 'avg_degree': round(2 * len(E) / n, 2),
                  'outer_shell': len(shell), 'outer_shell_mean_degree': round(float(deg[shell].mean()), 2) if shell else None,
                  'k_core_sizes': cores, 'seconds': round(time.time() - t0, 1)}))

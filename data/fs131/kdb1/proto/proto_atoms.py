"""FS131-KDB1 prototype (untrusted planning instrument): the atom check L(S) <= w_T + nu over every nonempty
independent S of G23, by a DFS over vertices 0..22 that adds each term when its highest vertex is decided.
Counts the work a kernel run would do; writes the Lean data for the probe."""
import sys, json
from fractions import Fraction as Fr
from pathlib import Path
sys.path.insert(0, 'tools')
import j26_ambrus_check as J
pts = J.read_points(Path('data/pa-ambrus2023/verification23.nb'))
w0, wT, w1, w2, wc = J.read_coeffs(Path('data/pa-ambrus2023/g23.csv'))
N = 23
edges = [(i, j) for i in range(N) for j in range(i + 1, N) if J.sqdist(pts[i], pts[j]) == (Fr(1), Fr(0), Fr(0), Fr(0))]
print("edges", len(edges))
adj = [0] * N
for i, j in edges:
    adj[i] |= 1 << j; adj[j] |= 1 << i
WS = 10**20
terms = [(1 << 0, int(w1 * WS))]
for v, i, j in w2:
    terms.append(((1 << (i - 1)) | (1 << (j - 1)), int(v * WS)))
for v, I, Jx in wc:
    mI = sum(1 << (i - 1) for i in I); mJ = sum(1 << (j - 1) for j in Jx)
    terms.append((mI, -int(v * WS))); terms.append((mJ, int(v * WS)))
assert all(Fr(c, WS) * WS == c for _, c in terms)
groups = [[] for _ in range(N)]
for m, c in terms:
    groups[m.bit_length() - 1].append((m, c))
bound = int((wT + Fr(1, 10**6)) * WS)
work = [0]; leaves = [0]; best = [None]
def dfs(v, S, acc):
    if v == N:
        leaves[0] += 1
        if S and (best[0] is None or acc > best[0]): best[0] = acc
        return
    # v out
    dfs(v + 1, S, acc)
    if not (adj[v] & S):
        S2 = S | (1 << v)
        a = acc
        for m, c in groups[v]:
            work[0] += 1
            if m & S2 == m: a += c
        dfs(v + 1, S2, a)
dfs(0, 0, 0)
print("leaves (independent sets incl. empty)", leaves[0], "subset tests", work[0])
print("max L", best[0] / WS, "bound", bound / WS, "ok", best[0] <= bound, "min V", (bound - best[0]) / WS - 1e-6)
print("group sizes", [len(g) for g in groups])
json.dump({'adj': adj, 'groups': groups, 'bound': bound, 'edges': edges}, open(sys.argv[1], 'w'))

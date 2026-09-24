"""Window-state graph of G(Z, D) at k colours: states = admissible colourings of an interval of length m = max D,
modulo colour permutation (canonical first-occurrence labelling); edge s -> s' when s + one more colour is admissible.
Reports: #states, #essential states (on a bi-infinite walk = in the core after iteratively removing sources/sinks),
and, for D2, K4-freeness and the independence density mod small periods."""
import sys, itertools, time
from collections import defaultdict
sys.setrecursionlimit(10000)
def canon(w):
    mp = {}; out = []
    for c in w:
        if c not in mp: mp[c] = len(mp)
        out.append(mp[c])
    return tuple(out)
def states(D, k, cap=3_000_000):
    m = max(D)
    res = []
    def dfs(w):
        if len(res) > cap: raise RuntimeError("cap")
        if len(w) == m:
            res.append(tuple(w)); return
        i = len(w)
        used = max(w) + 1 if w else 0
        for c in range(min(k, used + 1)):          # canonical: new colour = next unused
            if all(i - d < 0 or w[i - d] != c for d in D):
                w.append(c); dfs(w); w.pop()
    dfs([])
    return res
def graph(D, k, S):
    idx = {s: j for j, s in enumerate(S)}
    out = defaultdict(set); inn = defaultdict(set)
    m = max(D)
    for s in S:
        for c in range(k):
            w = s + (c,)
            if all(w[m - d] != c for d in D):
                t = canon(w[1:])
                out[s].add(t); inn[t].add(s)
    return out, inn
def core(S, out, inn):
    alive = set(S)
    changed = True
    while changed:
        changed = False
        for s in list(alive):
            if not (out[s] & alive) or not (inn[s] & alive):
                alive.discard(s); changed = True
    return alive
for D in ([1, 6, 8, 11, 12], [1, 3, 7, 12, 17, 22]):
    t = time.time()
    try:
        S = states(D, 4)
    except RuntimeError:
        print(D, "state count exceeds cap 3e6 (mod colour permutation)"); continue
    out, inn = graph(D, 4, S)
    A = core(S, out, inn)
    print(D, "states (mod colour perm):", len(S), " essential:", len(A), f" {time.time()-t:.1f}s")
D2 = [1, 6, 8, 11, 12]
# K4-free: no 4 integers with all 6 differences in D
Dset = set(D2)
k4 = [(0, a, b, c) for a in range(1, 13) for b in range(a+1, 25) for c in range(b+1, 37)
      if {a, b, c, b - a, c - a, c - b} <= Dset]
print("K4 in G(Z,{1,6,8,11,12}):", k4[:3] if k4 else "none")
# independence density: best periodic independent set for periods up to 40
best = (0, 1)
for p in range(2, 41):
    forb = {d % p for d in D2} | {(-d) % p for d in D2}
    if 0 in forb: continue
    # max independent set in circulant C_p(forb) by brute force on small p via greedy+exact for p<=24
    if p <= 28:
        n = p; bestsz = 0
        adj = [[((i - j) % p) in forb for j in range(p)] for i in range(p)]
        def mis(cands, size):
            global bestsz
            if size + len(cands) <= bestsz: return
            if not cands:
                bestsz = max(bestsz, size); return
            v = cands[0]
            mis([u for u in cands[1:] if not adj[v][u]], size + 1)
            mis(cands[1:], size)
        mis(list(range(p)), 0)
        if bestsz * best[1] > best[0] * p: best = (bestsz, p)
print("best periodic independent density found (period <= 28):", best, "=", best[0] / best[1])

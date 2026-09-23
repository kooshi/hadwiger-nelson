# Test H-i in rank 1: G(Z,D) 3-colourable  <=>  exists theta with ||theta*d|| >= 1/3 for all d in D.
# 3-colourability of G(Z,D): 1-D SFT; states = proper words of length m=max(D); colourable iff the
# transition graph has a cycle (a bi-infinite path exists iff a cycle exists in a finite graph).
import itertools, sys
from fractions import Fraction as Fr
sys.setrecursionlimit(100000)
def colourable(D, k):
    m = max(D)
    # states: words w[0..m-1] with w[i] != w[j] when j-i in D; canonical: w[0]=0, first-occurrence order
    states = {}
    def ok(w):
        L = len(w)
        return all(w[L-1] != w[L-1-d] for d in D if d <= L-1)
    # build all proper words of length m (up to colour perm: canonical first-occurrence)
    words = []
    def rec(w, used):
        if len(w) == m:
            words.append(tuple(w)); return
        for c in range(min(used+1, k)):
            w.append(c)
            if ok(w): rec(w, max(used, c+1))
            w.pop()
    rec([], 0)
    def canon(w):
        mp = {}; out = []
        for c in w:
            if c not in mp: mp[c] = len(mp)
            out.append(mp[c])
        return tuple(out)
    idx = {w: i for i, w in enumerate(words)}
    adj = [[] for _ in words]
    for i, w in enumerate(words):
        for c in range(k):
            w2 = w + (c,)
            if all(w2[m] != w2[m-d] for d in D):
                adj[i].append(idx[canon(w2[1:])])
    # cycle detection (iterative)
    color = [0]*len(words)
    for s in range(len(words)):
        if color[s]: continue
        stack = [(s, 0)]; color[s] = 1
        while stack:
            v, j = stack[-1]
            if j < len(adj[v]):
                stack[-1] = (v, j+1); u = adj[v][j]
                if color[u] == 1: return True
                if color[u] == 0: color[u] = 1; stack.append((u, 0))
            else:
                color[v] = 2; stack.pop()
    return False
def theta_ok(D):
    cands = set()
    for d in D:
        for j in range(3*d):
            cands.add(Fr(j, 3*d))
    for t in cands:
        if all(Fr(1,3) <= (t*d) % 1 <= Fr(2,3) for d in D):
            return t
    return None
bad = 0; tot = 0
for size in (2,3,4):
    for D in itertools.combinations(range(1, int(sys.argv[1])+1), size):
        from math import gcd
        g = 0
        for d in D: g = gcd(g, d)
        if g != 1: continue
        tot += 1
        a = colourable(D, 3); b = theta_ok(D)
        if a != (b is not None):
            bad += 1; print("MISMATCH", D, a, b)
print("tested", tot, "mismatches", bad)

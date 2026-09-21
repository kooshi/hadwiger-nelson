#!/usr/bin/env python3
"""FS-66 conjecture note, section 3.5: enumerate every maximum independent set of UD(F_7, 2) through the origin (exact
backtracking with the bound: each of the seven cycles x -> x+(1,0) holds at most 3), and check each is a union of two
parallel lines of a non-square direction.  Usage: fs66_conj_maxsets7.py"""
import sys, time
p = 7
S = [(a, b) for a in range(p) for b in range(p) if (a*a + b*b) % p == 1]
V = [(x, y) for x in range(p) for y in range(p)]; idx = {v: i for i, v in enumerate(V)}
n = len(V); adj = [0]*n
for (x, y) in V:
    for (a, b) in S: adj[idx[(x, y)]] |= 1 << idx[((x+a) % p, (y+b) % p)]
# columns of c = 2x+3y: independent lines; a clique-cover-free bound: use a cover of V by the 7 columns of c; any independent
# set meets... no bound there (columns are independent). Use the 49 = 7 x 7 single-direction cycles of direction (1,0): each holds <= 3.
lines = []
for y in range(p): lines.append(sum(1 << idx[(x, y)] for x in range(p)))
def ub(c): return sum(min(3, bin(c & L).count("1")) for L in lines)
count = 0; sols = []; t0 = time.time()
def rec(cur, size, cands):
    global count
    if size == 14: count += 1; sols.append(cur); return
    if size + ub(cands) < 14: return
    while cands:
        v = cands & -cands; cands ^= v
        rec(cur | v, size + 1, cands & ~adj[v.bit_length() - 1])
        if size + 1 + ub(cands) < 14 and False: return
o = idx[(0, 0)]
rec(1 << o, 1, ((1 << n) - 1) & ~adj[o] & ~(1 << o))
print(f"maximum independent sets through the origin: {count}; total = 49*{count}/14 = {49*count/14}; {time.time()-t0:.1f}s")
# are they all unions of two adjacent parallel lines of a non-square direction?  check: each solution is a union of 2 cosets of a line
def is_two_lines(mask):
    pts = [V[i] for i in range(n) if mask >> i & 1]
    for d in [(1, t) for t in range(p)] + [(0, 1)]:
        if (d[0]*d[0] + d[1]*d[1]) % p in (1, 2, 4): continue          # square norm -> not independent
        cos = {(d[1]*x - d[0]*y) % p for (x, y) in pts}
        if len(cos) == 2: return True
    return False
print("all are unions of two parallel lines of a non-square direction:", all(is_two_lines(s) for s in sols))

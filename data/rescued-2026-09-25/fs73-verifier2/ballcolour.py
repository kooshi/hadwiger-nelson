# ⟸ sanity for the colourable control: colour a word ball by floor(3θ(x)) mod 3 and check every edge exactly
import json, sys, math, itertools
from fractions import Fraction as F
cert = json.load(open(sys.argv[1]))
th = [F(n, m) for n, m in cert['theta_abce_dual']]
U = [tuple(u) for u in cert['units']]
U = U + [tuple(-x for x in u) for u in U]
ball = {(0,0,0,0)}
frontier = {(0,0,0,0)}
for _ in range(int(sys.argv[2])):
    nxt = set()
    for p in frontier:
        for u in U:
            q = tuple(a+b for a,b in zip(p,u))
            if q not in ball: nxt.add(q)
    ball |= nxt; frontier = nxt
col = {p: math.floor(3*sum(t*x for t,x in zip(th,p))) % 3 for p in ball}
edges = bad = 0
for p in ball:
    for u in U:
        q = tuple(a+b for a,b in zip(p,u))
        if q in col:
            edges += 1
            if col[p] == col[q]: bad += 1
print(f'ball {len(ball)} points, {edges//2} edges, monochromatic {bad//2}, colours used {sorted(set(col.values()))}')

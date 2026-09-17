#!/usr/bin/env python3
"""fs58_span -- span-box probe (FS-58 §R-B4): for each direction u (up to sign) of a pool, the box [min(0,3u_i) - s, max(0,3u_i) + s] in reduced coordinates;
queries: separate (0,3u) [UNSAT = forced], identify (0,2u) [UNSAT = virtual edge], identify (0,3u) [control, must be SAT]."""
import json, sys, itertools, time
from fractions import Fraction
sys.path.insert(0, str(__import__('pathlib').Path(__file__).resolve().parent))
from fs58_chain import inverse, lll, hnf_basis
from pysat.solvers import Cadical195
f = sys.argv[1]; spans = [int(x) for x in sys.argv[2].split(',')]; maxdirs = int(sys.argv[3]); cap = int(sys.argv[4]) if len(sys.argv) > 4 else 400000
p = json.load(open(f)); d = p['D']; B = p['basis']; W0 = [tuple(w) for w in p['W0']]
Binv = inverse(B)
G = []
for w in W0:
    c = [sum(Fraction(x) * Binv[i][j] for i, x in enumerate(w)) for j in range(4)]
    assert all(t.denominator == 1 for t in c); G.append(tuple(int(t) for t in c))
reps = []
for g in G:
    if tuple(-x for x in g) not in reps: reps.append(g)
reps.sort(key=lambda g: sum(abs(x) for x in g))
half = [g for g in G if g > tuple(-x for x in g)]
print(f"{f}: d={d} |W0|={len(W0)} max coord {max(max(map(abs, g)) for g in G)}", flush=True)
summary = {'forced': 0, 'vedge': 0, 'asked': 0}
for u in reps[:maxdirs]:
    for s in spans:
        lo = [min(0, 3*x) - s for x in u]; hi = [max(0, 3*x) + s for x in u]
        sizes = [h - l + 1 for l, h in zip(lo, hi)]
        n = sizes[0]*sizes[1]*sizes[2]*sizes[3]
        if n > cap: print(f"  u={u} s={s}: {n} points > cap"); continue
        idx = lambda x: (((x[0]-lo[0])*sizes[1] + (x[1]-lo[1]))*sizes[2] + (x[2]-lo[2]))*sizes[3] + (x[3]-lo[3])
        inside = lambda x: all(l <= c <= h for c, l, h in zip(x, lo, hi))
        var = lambda v, c: 3*v + c + 1
        sv = Cadical195()
        for v in range(n): sv.add_clause([var(v,0), var(v,1), var(v,2)])
        for x in itertools.product(*[range(l, h+1) for l, h in zip(lo, hi)]):
            i = idx(x)
            for g in half:
                y = tuple(a+b for a, b in zip(x, g))
                if inside(y):
                    for c in range(3): sv.add_clause([-var(i,c), -var(idx(y),c)])
        z = idx((0,0,0,0)); sv.add_clause([var(z, 0)])
        res = []
        nxt = 3*n + 1
        for k, mode in ((3, 'sep'), (2, 'id'), (3, 'id')):
            q = idx(tuple(k*c for c in u)); sel = nxt; nxt += 1
            for c in range(3):
                sv.add_clause([-sel, -var(z,c), var(q,c)] if mode == 'id' else [-sel, -var(z,c), -var(q,c)])
            res.append(sv.solve(assumptions=[sel]))
        forced = not res[0]; vedge = not res[1]; ctl = res[2]
        summary['asked'] += 1; summary['forced'] += forced; summary['vedge'] += vedge
        print(f"  u={u} span {s}: {n} points; separate 3u {'UNSAT (forced)' if forced else 'SAT'}; identify 2u {'UNSAT (virtual edge)' if vedge else 'SAT'}; control identify 3u {'SAT' if ctl else 'UNSAT!'}", flush=True)
        if forced: break
print("  summary", summary)


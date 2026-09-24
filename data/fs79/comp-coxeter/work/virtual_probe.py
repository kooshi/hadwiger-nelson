"""For the 3 perpendicular pairs of L21cc6506 where only rainbow squares were seen: is c(0) = c(s+t) possible in a periodic colouring
(N=4, 8)?  And the same for c(s) = c(t)."""
import sys, itertools, collections, math
import numpy as np
from language import colourings, reps
from missing_pairs import present, cplx
from pysat.solvers import Solver
cands = [p for p, ts in present.items() if ts == {'abcd'}]
print('rainbow-only pairs:', len(cands))
for (i, j) in cands:
    s_, t_ = reps[i], reps[j]
    for N in (4, 8):
        verts = list(itertools.product(range(N), repeat=4)); vid = {v: q for q, v in enumerate(verts)}
        var = lambda v, c: 4*v + c + 1
        from language import UC
        gens = sorted({tuple(x % N for x in c) for c in UC})
        cls = [[var(v, c) for c in range(4)] for v in range(len(verts))]
        for vv in verts:
            for g in gens:
                w = tuple((a+b) % N for a, b in zip(vv, g)); a1, b1 = vid[vv], vid[w]
                if a1 < b1:
                    for c in range(4): cls.append([-var(a1, c), -var(b1, c)])
        st = vid[tuple((a+b) % N for a, b in zip(s_, t_))]; sv = vid[tuple(x % N for x in s_)]; tv = vid[tuple(x % N for x in t_)]
        r1 = Solver(name='cadical153', bootstrap_with=cls + [[var(0, 0)], [var(st, 0)]]).solve()
        r2 = Solver(name='cadical153', bootstrap_with=cls + [[var(sv, 0)], [var(tv, 0)]]).solve()
        z1, z2 = cplx(s_), cplx(t_)
        print(f'pair {i},{j}: s={z1:.4f} t={z2:.4f} |s+t|={abs(z1+z2):.4f} N={N}: c(0)=c(s+t) {"SAT" if r1 else "UNSAT"}; c(s)=c(t) {"SAT" if r2 else "UNSAT"}', flush=True)

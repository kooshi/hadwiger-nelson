"""Is the Theta_4 cell of L21cc6506's linear colourings full-dimensional?  Exact LP: maximise eps s.t. theta(u) - n_u in [1/4+eps, 3/4-eps]."""
import sys, json, math
from fractions import Fraction as Fr
sys.path.insert(0, '/home/kooshi/source/lean-dir/tools')
from fs79_p0_check import units_be, coords_in
from scipy.optimize import linprog
import numpy as np
M, d = 420, 167
U = sorted(units_be(M, d))
for f in ['L21cc6506-linear.json', 'L21cc6506-linear-probe.json']:
    w = json.load(open('/home/kooshi/source/lean-dir/data/fs79/phase0/witnesses/'+f))
    B = w['basis']; th = [Fr(x) for x in w['theta_on_basis']]
    rows = [coords_in(B, u) for u in U]
    vals = [sum(Fr(x)*y for x, y in zip(r, th)) for r in rows]
    n = [math.floor(v - Fr(1,4)) for v in vals]   # integer shift so v - n in [1/4, 5/4); proper means v - n in [1/4, 3/4]
    fr = [v - k for v, k in zip(vals, n)]
    assert all(Fr(1,4) <= x <= Fr(3,4) for x in fr)
    slack = min(min(x - Fr(1,4), Fr(3,4) - x) for x in fr)
    # LP over (t1..t4, eps): maximise eps; for each u: r.t - n_u - eps >= 1/4 ; r.t - n_u + eps <= 3/4
    A = []; b = []
    for r, k in zip(rows, n):
        A.append([-x for x in r] + [1]); b.append(-(k + 0.25))
        A.append([x for x in r] + [1]); b.append(k + 0.75)
    res = linprog(c=[0,0,0,0,-1], A_ub=np.array(A, float), b_ub=np.array(b, float), bounds=[(None,None)]*4+[(0,1)], method='highs')
    print(f, 'slack at the witness point', slack, float(slack), '| LP max eps in its cell', res.x[-1] if res.success else res.status)
    print('   witness theta values mod 1 at the boundary:', sum(1 for x in fr if x in (Fr(1,4), Fr(3,4))), 'of', len(fr))

import sys, json, math, os
sys.path.insert(0, '/home/kooshi/source/lean-dir/tools')
from fractions import Fraction as Fr
import fs79_p3_theta4 as T
from fs79_p0_check import coords_in
R = '/home/kooshi/source/lean-dir/data/fs79/p3'
U, half, B, C, QD = T.frame()
rational = [i for i in range(30) if half[i][1] == 0 and half[i][3] == 0]
out = {}
for name in ('L21cc6506-linear.json', 'L21cc6506-linear-probe.json'):
    w = json.load(open(os.path.join(T.WIT, name)))
    Bp = [tuple(t) for t in w['basis']]; th = [Fr(t) for t in w['theta_on_basis']]
    x = [T.dot(coords_in(Bp, b_), th) for b_ in B]
    assert T.in_theta(x, C, 4)
    js = [math.floor(T.dot(c, x)) for c in C]
    rec = T.cell_analysis(C, js, 4, x)
    out[name] = {'order': math.lcm(*[t.denominator for t in th]), 'dim': rec['dim'], 'n_const': rec['n_const'],
                 'const_is_rational_layer': sorted(rec['const_half']) == rational, 'n_edge_at_barycentre': rec['n_edge']}
    print(name, out[name], flush=True)
json.dump(out, open(os.path.join(R, 'known-points-cells.json'), 'w'), indent=1)

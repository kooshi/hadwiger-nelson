#!/usr/bin/env python3
"""fs58_box_indep -- an independent re-derivation of one box query: points rebuilt as exact vectors x·basis (the pool's own
basis, no reduction), edges from a fresh units_d enumeration by exact membership (no generator coordinates), the query written as
DIMACS and solved by the CaDiCaL binary and by Glucose4; SAT models verified proper.
Usage: fs58_box_indep.py R COORDS K MODE (K = 0: COORDS is the target point; MODE identify|separate). Pool: chain-11/pool-10.json.
"""
import sys, json, itertools, subprocess, glob, os
sys.path.insert(0, str(__import__('pathlib').Path(__file__).resolve().parent))
from fs58_local import units_d
R = int(sys.argv[1]); ucoord = tuple(int(x) for x in sys.argv[2].split(',')); k = int(sys.argv[3]); mode = sys.argv[4]  # identify|separate
B = json.load(open('data/fs58/chain-11/pool-10.json'))['basis']
W = units_d(10, 11)
assert len(W) == 36
pt = lambda x: tuple(sum(x[i]*B[i][j] for i in range(4)) for j in range(4))
pts = {}
for x in itertools.product(range(-R, R+1), repeat=4):
    pts[pt(x)] = len(pts)
edges = set()
for p, i in pts.items():
    for w in W:
        j = pts.get(tuple(a+b for a, b in zip(p, w)))
        if j is not None and i < j: edges.add((i, j))
n = len(pts)
p0 = pts[(0,0,0,0)]
wstar = pt(ucoord)
if k > 0:
    assert wstar in set(W), 'the given coordinates are not a unit vector'
    q = pts[tuple(k*c for c in wstar)]
else:
    q = pts[wstar]   # k = 0: the target is the lattice point with these coordinates
# a neighbour of p0 for the pin
nb = pts[tuple(W[0])] if tuple(W[0]) in pts else None
var = lambda v, c: 3*v + c + 1
cl = [[var(v,0), var(v,1), var(v,2)] for v in range(n)]
for a, b in edges: cl += [[-var(a,c), -var(b,c)] for c in range(3)]
cl.append([var(p0, 0)])
if mode == 'identify':
    cl.append([var(q, 0)])                       # c(q) = c(p0) = 0 (at-least-one semantics: q carries colour 0)
    if nb is not None and (min(p0, nb), max(p0, nb)) in edges: cl.append([var(nb, 1)])
else:
    cl.append([-var(q, 0)])                      # c(q) != c(p0)
    for c in range(3): pass
path = f'box-R{R}-{mode}-k{k}.cnf'
with open(path, 'w') as f:
    f.write(f'p cnf {3*n} {len(cl)}\n')
    for c in cl: f.write(' '.join(map(str, c)) + ' 0\n')
print(f"independent build R={R}: {n} points, {len(edges)} edges; query {mode} (0, {k}·w) with w = {wstar}")
cad = sorted(glob.glob(os.path.expanduser('~/.elan/toolchains/*/bin/cadical')))[0]
r = subprocess.run([cad, '-q', path], capture_output=True, text=True)
print('  CaDiCaL binary exit', r.returncode, '(10 SAT, 20 UNSAT)')
from pysat.solvers import Glucose4
g = Glucose4(bootstrap_with=cl); res = g.solve()
print('  Glucose4:', 'SAT' if res else 'UNSAT')
if res:
    m = set(x for x in g.get_model() if x > 0)
    col = [next(c for c in range(3) if var(v, c) in m) for v in range(n)]
    assert all(col[a] != col[b] for a, b in edges)
    print('  model verified proper; c(p0) =', col[p0], 'c(q) =', col[q])
os.remove(path)

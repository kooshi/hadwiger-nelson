"""Dimension of the Theta_4 cells containing phase 0's two linear colourings of L21cc6506 (Poros's question on C8).
Cell = {t : r_u . t - n_u in [1/4, 3/4] for all u}, n_u fixed at the witness.  Width in each coordinate by LP (float), then the
tight rows' rank exactly (Fractions): dimension = 4 - rank(rows tight at every point of the cell)."""
import sys, json, math
from fractions import Fraction as Fr
sys.path.insert(0, '/home/kooshi/source/lean-dir/tools')
from fs79_p0_check import units_be, coords_in
from scipy.optimize import linprog
import numpy as np, sympy
U = sorted(units_be(420, 167))
for f in ['L21cc6506-linear.json', 'L21cc6506-linear-probe.json']:
    w = json.load(open('/home/kooshi/source/lean-dir/data/fs79/phase0/witnesses/'+f))
    B = w['basis']; th = [Fr(x) for x in w['theta_on_basis']]
    rows = [coords_in(B, u) for u in U]
    vals = [sum(Fr(x)*y for x, y in zip(r, th)) for r in rows]
    n = [math.floor(v - Fr(1,4)) for v in vals]
    A = []; b = []
    for r, k in zip(rows, n):
        A.append([-x for x in r]); b.append(-(k + 0.25)); A.append(list(r)); b.append(k + 0.75)
    A = np.array(A, float); b = np.array(b, float)
    widths = []
    for i in range(4):
        c = np.zeros(4); c[i] = 1
        lo = linprog(c, A_ub=A, b_ub=b, bounds=[(None, None)]*4, method='highs')
        hi = linprog(-c, A_ub=A, b_ub=b, bounds=[(None, None)]*4, method='highs')
        widths.append(-hi.fun - lo.fun)
    # implicit equalities: each constraint row's range over the cell
    tight = []
    for r in rows:
        c = np.array(r, float)
        lo = linprog(c, A_ub=A, b_ub=b, bounds=[(None, None)]*4, method='highs').fun
        hi = -linprog(-c, A_ub=A, b_ub=b, bounds=[(None, None)]*4, method='highs').fun
        if hi - lo < 1e-9: tight.append(r)
    rk = sympy.Matrix(tight).rank() if tight else 0
    print(f, '| coordinate widths', [f'{x:.2e}' for x in widths], '| rows fixed on the cell', len(tight), '| their exact rank', rk,
          '| cell dimension', 4 - rk)
# which unit vectors are fixed on the 2-dimensional cell (the probe)?
f = 'L21cc6506-linear-probe.json'
w = json.load(open('/home/kooshi/source/lean-dir/data/fs79/phase0/witnesses/'+f))
B = w['basis']; th = [Fr(x) for x in w['theta_on_basis']]
rows = [coords_in(B, u) for u in U]; vals = [sum(Fr(x)*y for x, y in zip(r, th)) for r in rows]
n = [math.floor(v - Fr(1,4)) for v in vals]
A = []; b = []
for r, k in zip(rows, n):
    A.append([-x for x in r]); b.append(-(k + 0.25)); A.append(list(r)); b.append(k + 0.75)
A = np.array(A, float); b = np.array(b, float)
fixed = []
for u, r in zip(U, rows):
    c = np.array(r, float)
    lo = linprog(c, A_ub=A, b_ub=b, bounds=[(None, None)]*4, method='highs').fun
    hi = -linprog(-c, A_ub=A, b_ub=b, bounds=[(None, None)]*4, method='highs').fun
    if hi - lo < 1e-9: fixed.append(u)
print('fixed unit vectors (a,b,c,e over 420):', fixed)
print('all rational (b = e = 0)?', all(u[1] == 0 and u[3] == 0 for u in fixed))

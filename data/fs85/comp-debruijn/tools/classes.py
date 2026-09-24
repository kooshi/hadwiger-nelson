"""Read the committed census of de Grey's lattice (FS-73, K-8Lambda-classes.json) and express each class in E-arithmetic.
Reading a committed record: no solver, no enumeration of colourings."""
import json, itertools
from lam import *
D = json.load(open('/home/kooshi/source/lean-dir/data/fs73/census/lattice-degrey.json'))
H = [from_fs73(v, D['M']) for v in D['H']]
C = json.load(open('/home/kooshi/source/lean-dir/data/fs73/census/K-8Lambda-classes.json'))
import sympy
# basis matrix: columns = coords (in O_E basis, times 9) of H vectors
Hc = [tuple(9*x for x in coords(h)) for h in H]
M = sympy.Matrix([[int(h[i]) for h in Hc] for i in range(4)])   # 9*coords(H_j) as columns
Minv = M.inv()
def lat(a):
    """lattice coordinates of a in the basis H (must be integral for a in Lambda)"""
    v = sympy.Matrix([sympy.Rational(int((9*x).numerator), int((9*x).denominator)) for x in coords(a)])
    r = Minv * v
    assert all(x.q == 1 for x in r), (a, r)
    return tuple(int(x) for x in r)
def idx(t):  # big-endian mixed radix mod 8
    t = [x % 8 for x in t]
    return ((t[0]*8 + t[1])*8 + t[2])*8 + t[3]
def untidx(i):
    return ((i>>9)&7, (i>>6)&7, (i>>3)&7, i&7)
if __name__ == '__main__':
    print('det(9*coords(H)) =', M.det(), '(81 means H spans (1/9)O_E? index of span in (1/9)O_E = |det|/1)')
    U = load_U()
    UL = [lat(u) for u in U]
    print('U in H-coords, first 6:', UL[:6])
    print('1 ->', lat(ONE), ' zeta6 ->', lat(Z6))
    reps = C['orbit_representatives']
    for k, s in reps.items():
        col = [int(ch) for ch in s]
        # proper check
        ok = all(col[i] != col[idx(tuple(a+b for a,b in zip(untidx(i), u)))] for i in range(4096) for u in UL)
        # period group mod 8
        per = [t for t in itertools.product(range(8), repeat=4)
               if all(col[i] == col[idx(tuple(a+b for a,b in zip(untidx(i), t)))] for i in range(4096))]
        print('rep', k, 'proper', ok, '|Per mod 8Lambda| =', len(per), ' index', 4096//len(per))

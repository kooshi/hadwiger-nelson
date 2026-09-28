#!/usr/bin/env python3
"""FS114-N2 exact checks (stage N2-2). Each check is a derived identity or a derived
configuration's metric claims at named values, in exact arithmetic (sympy).

  count  : NB-COUNT's p_k and the edge-end identity N2-ENDS on symbolic vertex counts
  crown  : N2-CROWN's arithmetic (chord <= 1 iff gap <= 60 or >= 300; five gaps cannot close)
  strip  : the strip's non-tactic edge ends per column (N2-ENDS's residual on CAL-STRIP)
  beta   : the all-beta quadrilateral configuration's unit distances and far pairs
Plants (--plant NAME) must each make exactly their own check fail:
  k7     : use 18 = 3(k-1) at k = 7 in place of 15            -> count fails
  crown6 : claim d = 6 is excluded too                         -> crown fails
  thin   : rhombus of angle 40 deg (a diagonal < 1)            -> beta fails
"""
import sys
from sympy import Rational as Q, symbols, expand, sqrt, sin, pi, simplify, Matrix, nsimplify, cos, acos, atan2, Symbol

PLANT = sys.argv[sys.argv.index('--plant') + 1] if '--plant' in sys.argv else None
fails = []

def check(name, ok, detail=''):
    print(('PASS ' if ok else 'FAIL ') + name + (': ' + detail if detail else ''))
    if not ok:
        fails.append(name)

# ---- count -------------------------------------------------------------------
def count():
    K = 18 if PLANT == 'k7' else 15          # 3(k-1) at k = 6 is 15
    V3, V4, V5, V6, U = symbols('V3 V4 V5 V6 U', nonnegative=True)
    V = {3: V3, 4: V4, 5: V5, 6: V6}
    Ep = sum(Q(d, 2) * V[d] for d in V)       # E' = sum d V_d / 2
    Vp = sum(V.values())
    F = Ep - Vp                                # torus Euler, degree-2 points removed
    # per tile: sum_{v in x}(d-3) = A_x + B_x,  B_x = 3 a(x) - u_x,  a(x) = 5 - s(x)
    # summed: sum_v d(d-3) V_d = A + 3(5F - 2E') - U
    A = sum(d * (d - 3) * V[d] for d in V) - 3 * (K // 3 * F - 2 * Ep) + U
    target = Ep - V4 + 3 * V6 + U              # NB-ARCS with its slack made exact
    check('A = E\' - V4 + 3V6 + U (NB-ARCS, exact)', expand(A - target) == 0, str(expand(A - target)))
    N = Ep - A                                 # non-tactic edges
    ends = 2 * V4 - 6 * V6 - 2 * U
    check('2N = 2V4 - 6V6 - 2U (N2-ENDS)', expand(2 * N - ends) == 0, str(expand(2 * N - ends)))
    for d in (3, 4, 5, 6):
        p5 = 2 * d * d + (2 - 15) * d + 30 - 6
        p6 = 2 * d * d + (2 - 18) * d + 36 - 6
        check(f'p5({d}) > 0', p5 > 0, str(p5))
        check(f'p6({d}) = 2(d-3)(d-5)', p6 == 2 * (d - 3) * (d - 5), str(p6))
        lhs = Q(d * d) - Q(15, 2) * d + 15
        rhs = Q(d, 2) - (1 if d == 4 else 0) + (3 if d == 6 else 0)
        check(f'd^2 - 7.5d + 15 = d/2 - [d=4] + 3[d=6] at d={d}', lhs == rhs, f'{lhs} vs {rhs}')

# ---- crown -------------------------------------------------------------------
def crown():
    for g in (Q(59), Q(60), Q(61), Q(299), Q(300), Q(301)):
        c = 2 * sin(g * pi / 360)
        ok = (c <= 1) == (g <= 60 or g >= 300)
        check(f'chord({g} deg) <= 1 iff gap <= 60 or >= 300', bool(ok), str(c.evalf(8)))
    excluded = [5, 6] if PLANT == 'crown6' else [3, 4, 5]
    for d in excluded:
        check(f'd={d}: d gaps of <= 60 deg cannot close 360', d * 60 < 360, f'{d*60}')
    # one gap >= 300: all ends in a 60-degree arc; sectors lie within 90 deg of some end: 60 + 180 = 240 < 360
    check('one long gap: sectors confined to 240 deg < 360', 60 + 180 < 360)

# ---- strip -------------------------------------------------------------------
def strip():
    # CAL-STRIP ([AxenovichEtAl2014]; plans/FS112-Y-construction.md 1.3): per column j,
    # P_j (degree 4): sides x = x_j above and below, midline segments to P_{j-1}, P_{j+1}: 4 straight edges;
    # valleys (x_j, +-sqrt3/2): the side x = x_j is straight, the two arcs are tactic: n = 1 each;
    # apexes (x_j + 1/4, +-sqrt15/4): the side x = x_j + 1/4 between C_j, C_{j+1} straight: n = 1 each.
    n_P, n_valley, n_apex = 4, 1, 1
    residual = (n_P - 2) + 2 * n_valley + 2 * n_apex   # N2-ENDS terms per column (U >= 0 only adds)
    check('strip column violates N2-ENDS (residual > 0)', residual > 0, f'residual {residual} per column')

# ---- beta --------------------------------------------------------------------
def beta():
    ang = 40 if PLANT == 'thin' else 90
    th = Q(ang, 180) * pi
    # unit rhombus w1..w4 centred at v = 0, side 1, angle th at w_1
    h1, h2 = cos(th / 2), sin(th / 2)          # half diagonals
    W = [Matrix([h1, 0]), Matrix([0, h2]), Matrix([-h1, 0]), Matrix([0, -h2])]
    if ang == 90:                              # the square, rotated to the example's frame
        W = [Matrix([Q(1, 2), Q(1, 2)]), Matrix([-Q(1, 2), Q(1, 2)]),
             Matrix([-Q(1, 2), -Q(1, 2)]), Matrix([Q(1, 2), -Q(1, 2)])]
    d = lambda P, R: sqrt(((P - R).T * (P - R))[0])
    for i in range(4):
        check(f'|w{i} w{i+1}| = 1', simplify(d(W[i], W[(i + 1) % 4]) - 1) == 0)
    # far pairs r_i, r_{i+2} and o_i, o_{i+2}: both diagonals >= 1
    check('diagonal w0 w2 >= 1', bool(d(W[0], W[2]).evalf(20) >= 1), str(d(W[0], W[2]).evalf(8)))
    check('diagonal w1 w3 >= 1', bool(d(W[1], W[3]).evalf(20) >= 1), str(d(W[1], W[3]).evalf(8)))
    if ang != 90:
        return
    # t_1 between w_4 = (1/2, -1/2) and w_1 = (1/2, 1/2): a_1 on w(v) and w(w_4), b_1 on w(v) and w(w_1)
    v = Matrix([0, 0])
    phi = acos(sqrt(2) / 4)                     # half-angle: |v - w| = 1/sqrt2, circles of radius 1
    a1 = Matrix([cos(-pi / 4 + phi), sin(-pi / 4 + phi)])
    b1 = Matrix([cos(pi / 4 - phi), sin(pi / 4 - phi)])
    w1, w0 = W[0], W[3]
    for nm, P, R in (('v a1', v, a1), ('v b1', v, b1), ('w0 a1', w0, a1), ('w1 b1', w1, b1), ('w0 w1', w0, w1)):
        check(f'|{nm}| = 1 (the five diagonals of t_1)', simplify(d(P, R) - 1) == 0, str(d(P, R).evalf(10)))
    for nm, P, R in (('a1 b1', a1, b1), ('w1 a1', w1, a1), ('w0 b1', w0, b1), ('v w1', v, w1), ('v w0', v, w0)):
        check(f'|{nm}| <= 1 (the sides of t_1)', bool(d(P, R).evalf(20) <= 1), str(d(P, R).evalf(10)))

sel = [a for a in sys.argv[1:] if a in ('count', 'crown', 'strip', 'beta')] or ['count', 'crown', 'strip', 'beta']
for s in sel:
    print(f'== {s}')
    globals()[s]()
print('RESULT', 'ALL PASS' if not fails else 'FAILED: ' + '; '.join(fails))
sys.exit(1 if fails else 0)

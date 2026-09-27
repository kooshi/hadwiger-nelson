#!/usr/bin/env python3
"""FS110-N3 exact checks for the merge lemma's clearance steps (plans/FS110-N-proof.md, N3 stage 2).

Frame: v = 0, a = +x (a horn's direction), n = +y, N = (0, 1), S' = (0, -1).  Checks, all exact (sympy):
  C1  p in closed B(N, 1)  <=>  |p|^2 <= 2 p_y            (lens bound: in-type tiles at N have p_y >= 0, |p|^2 <= 2 p_y)
  C2  p outside open B(0,1) and in closed B(S',1)  ==>  p_y <= -1/2   (lune bound: out-type tiles at S')
  C3  the lower boundary of B(N,1) near v is y = x^2/2 + x^4/8 + O(x^6)   (a horn inside B(N,1) needs kappa_1 >= 1)
  C4  envelope of the unit circles about horn points (x, k x^2/2) near N: max_x [k x^2/2 - (X - x)^2/2] = k X^2 / (2(1 - k)), k < 1
  C5  Prop. 17 geometry: at x_1 = (1, 0) the unit circles about x_2 = (1/2, sqrt3/2) and x_6 pass through x_1 with tangents at
      +-30 degrees from the outward radial
Planted faults (--plant K): each flips one ingredient and must make exactly its check fail.
"""
import sys
import sympy as sp

x, y, X, px, py, k = sp.symbols('x y X p_x p_y k', real=True)
PLANT = int(sys.argv[sys.argv.index('--plant') + 1]) if '--plant' in sys.argv else 0


def c1():
    lhs = px**2 + (py - 1)**2 - 1          # <= 0 inside closed B(N,1)
    rhs = (px**2 + py**2) - 2*py           # <= 0 iff |p|^2 <= 2 p_y
    if PLANT == 1:
        rhs = (px**2 + py**2) - py
    return sp.simplify(lhs - rhs) == 0


def c2():
    # |p|^2 >= 1 and px^2 + (py+1)^2 <= 1  => 2 py <= -|p|^2 <= -1.  Identity: px^2+(py+1)^2-1 = |p|^2 + 2 py.
    ident = sp.simplify(px**2 + (py + 1 if PLANT != 2 else py + 2)**2 - 1 - (px**2 + py**2 + 2*py)) == 0
    return ident


def c3():
    lower = 1 - sp.sqrt(1 - x**2)
    ser = sp.series(lower, x, 0, 6).removeO()
    want = x**2/2 + x**4/8 if PLANT != 3 else x**2/2 + x**4/4
    return sp.simplify(ser - want) == 0


def c4():
    f = k*x**2/2 - (X - x)**2/2
    crit = sp.solve(sp.diff(f, x), x)
    val = sp.simplify(f.subs(x, crit[0]))
    want = k*X**2/(2*(1 - k)) if PLANT != 4 else k*X**2/(2*(1 + k))
    concave = sp.simplify(sp.diff(f, x, 2)) == k - 1   # max iff k < 1
    return sp.simplify(val - want) == 0 and concave


def c5():
    s3 = sp.sqrt(3)
    x1 = sp.Matrix([1, 0])
    x2 = sp.Matrix([sp.Rational(1, 2), s3/2]) if PLANT != 5 else sp.Matrix([sp.Rational(1, 2), s3/3])
    on = sp.simplify((x1 - x2).dot(x1 - x2)) == 1
    tang = sp.Matrix([-(x1 - x2)[1], (x1 - x2)[0]])       # tangent of omega(x2) at x1
    cosang = sp.simplify(abs(tang.dot(x1)) / sp.sqrt(tang.dot(tang)))   # angle with outward radial (1,0)
    return on and sp.simplify(cosang - s3/2) == 0


checks = [('C1', c1), ('C2', c2), ('C3', c3), ('C4', c4), ('C5', c5)]
fails = [name for name, f in checks if not f()]
for name, f in checks:
    pass
print('plant', PLANT, 'failing:', fails if fails else 'none')
if PLANT == 0:
    sys.exit(1 if fails else 0)
# under a plant exactly the planted check must fail
want = ['C%d' % PLANT]
sys.exit(0 if fails == want else 1)

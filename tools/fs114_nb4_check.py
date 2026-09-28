#!/usr/bin/env python3
"""FS114-NB4: exact checks (sympy, over Q(sqrt3)) of the metric facts behind
NB4's blind derivations of N4-TOP and N4-D.  Every point is given by formula;
small angles are rational rotations (Pythagorean), so every comparison is exact.
--plant moves the colour-1 witness point to alpha = 0 (direction exactly 90 deg
from q1), where the derivation says the exclusion FAILS; the check D4 must then
go red, and only D4.
"""
import sys
import sympy as sp

r3 = sp.sqrt(3)
P = sp.Matrix([0, 0]); q1 = sp.Matrix([r3/2, sp.Rational(1, 2)]); q2 = sp.Matrix([r3/2, -sp.Rational(1, 2)])
q3 = sp.Matrix([-r3/2, sp.Rational(1, 2)]); top = sp.Matrix([0, 1]); Rs = q1 + top

def d2(a, b):
    v = a - b
    return sp.nsimplify(sp.expand(v.dot(v)))

def rot(m, n):            # rational unit vector at a small angle atan(2mn/(m^2-n^2)) ~ 2n/m rad
    c = sp.Rational(m*m - n*n, m*m + n*n); s = sp.Rational(2*m*n, m*m + n*n)
    return c, s

def e_add(base, c, s):    # rotate the unit vector base by the angle (c, s)
    return sp.Matrix([base[0]*c - base[1]*s, base[0]*s + base[1]*c])

def e_sub(base, c, s):
    return sp.Matrix([base[0]*c + base[1]*s, -base[0]*s + base[1]*c])

def lt(x, y):  # exact x < y
    return bool(sp.simplify(y - x) > 0)

results = []
def check(name, ok):
    results.append((name, ok)); print(("OK   " if ok else "FAIL ") + name)

plant = "--plant" in sys.argv
E90 = sp.Matrix([0, 1]); E180 = sp.Matrix([-1, 0]); E300 = sp.Matrix([sp.Rational(1, 2), -r3/2])

# D0: the named distances
check("D0 |q1-top|=|q1-q2|=|R*-q1|=|R*-top|=1, |R*|^2=3",
      all(d2(a, b) == 1 for a, b in [(q1, top), (q1, q2), (Rs, q1), (Rs, top)]) and d2(Rs, P) == 3)

# D1: Z4-W Siamese series |e(phi)+e(-psi)-1|^2 = 1 - 2 phi psi + O(3)
f, g = sp.symbols('phi psi')
ex = (sp.cos(f) + sp.cos(g) - 1)**2 + (sp.sin(f) - sp.sin(g))**2
ser = sp.series(sp.series(ex, f, 0, 3).removeO(), g, 0, 3).removeO()
check("D1 |e(phi)+e(-psi)-1|^2 = 1 - 2 phi psi + O(3)", sp.expand(ser - (1 - 2*f*g)) .as_poly(f, g) is None
      or all(sum(mon) >= 3 for mon in sp.Poly(sp.expand(ser - (1 - 2*f*g)), f, g).monoms()))

# D2: U cannot hold R*: a lune-part point q1 + t e(180) (in Lambda_up) is > 1 from R*
t = sp.Rational(1, 10); x = q1 + t*E180
check("D2 q1+t e(180): in B(p,1), outside B(q2,1), |x-R*|>1",
      lt(d2(x, P), 1) and lt(1, d2(x, q2)) and lt(1, d2(x, Rs)))

# D3: T_cap cannot hold R*: a point just outside t1's cap near q1 (direction 300+zeta) is > 1 from R*
cz, sz = rot(20, 1); y = q1 + sp.Rational(1, 20)*e_add(E300, cz, sz)
check("D3 q1+t e(300+z): outside B(p,1), |y-R*|>1", lt(1, d2(y, P)) and lt(1, d2(y, Rs)))

# D4: colour 1 excluded just outside omega(q1) near R* (alpha > beta > 0)
ca, sa = rot(20, 1); cb, sb = rot(40, 1)
dirw = E90 if plant else e_add(E90, ca, sa)                 # e(90 + alpha)
w = q1 + (1 + sp.Rational(1, 10000))*dirw
xt = q1 + sp.Rational(1, 20)*e_add(E180, cb, sb)             # q1 + eta e(180 + beta), a point of t1
in_t1 = lt(d2(xt, P), 1) and lt(d2(xt, q1), 1) and lt(d2(xt, q2), 1)
check("D4a t1-point inside t1; w outside B(q1,1)", in_t1 and lt(1, d2(w, q1)))
check("D4b |w-x|<1 (the exclusion itself)", lt(d2(w, xt), 1))
wa = q1 + (1 + sp.Rational(1, 10000))*e_add(E90, ca, sa)   # the unplanted witness, for the top-disc fact
check("D4c the witness w(alpha) lies inside B(top,1)", lt(d2(wa, top), 1))

# D5: the branch of omega(R*) leaving top at 120 deg lies in W's region near top
cg, sg = rot(40, 1); E210 = sp.Matrix([-r3/2, -sp.Rational(1, 2)])
z = Rs + e_sub(E210, cg, sg)                                 # R* + e(210 - gamma)
check("D5 R*+e(210-g): on omega(R*); outside B(q1,1), B(q3,1), B(p,1); inside B(top,1)",
      d2(z, Rs) == 1 and lt(1, d2(z, q1)) and lt(1, d2(z, q3)) and lt(1, d2(z, P)) and lt(d2(z, top), 1))

# D6: the open lens B(q1,1) cap B(top,1) has corners p and R* (both at distance 1 from q1 and top)
check("D6 lens corners p, R*", d2(P, q1) == 1 and d2(P, top) == 1 and d2(Rs, q1) == 1 and d2(Rs, top) == 1)

bad = [n for n, ok in results if not ok]
print(f"SUMMARY: {len(results) - len(bad)} of {len(results)} OK; plant={'on' if plant else 'off'}; failing={bad}")
sys.exit(1 if bad else 0)

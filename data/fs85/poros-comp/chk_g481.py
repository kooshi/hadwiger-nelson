# Do the orbit representatives of Parts's G481 (Table 3), and their orbits under the order-24 group
# (rotations by pi/3, reflections in the axes, conjugation b,c -> -b,-c), lie in Lambda = (1/9)O_E?
# Also: are Parts's 30 unit vectors exactly mu6 * eta^{-2..2}?  Exact arithmetic in sympy.
import re, sympy as sp
txt = open('parts-hv.txt').read()
reps = sorted(set(tuple(map(int, m)) for m in re.findall(r'^\s*\((-?\d+),(-?\d+),(-?\d+),(-?\d+)\)', txt, re.M)))
print(len(reps), "orbit reps")
s3, s11, s33, I = sp.sqrt(3), sp.sqrt(11), sp.sqrt(33), sp.I
def val(t):
    a,b,c,d = t
    return (a + b*s33 + I*c*s3 + I*d*s11)/12
# O_E membership of x: x = (p + q*s33 + i(r*s3 + t*s11)) ; O_E = Z[zeta6, w]; basis coords via linear solve over Q.
z = sp.Rational(1,2) + I*s3/2; w = sp.Rational(1,2) + I*s11/2
B = [sp.Integer(1), z, w, sp.expand(z*w)]
def comps(x):
    x = sp.expand(x); re_, im_ = sp.expand(sp.re(x)), sp.expand(sp.im(x))
    cr = sp.collect(re_, [s33], evaluate=False); ci = sp.collect(im_, [s3, s11], evaluate=False)
    return [cr.get(sp.S(1),0), cr.get(s33,0), ci.get(s3,0), ci.get(s11,0)]
M = sp.Matrix([comps(b) for b in B]).T   # columns = basis elements in (1, s33, i s3, i s11) coords
Minv = M.inv()
def in_Lambda(x):
    v = Minv * sp.Matrix(comps(9*x))
    return all(sp.nsimplify(e).is_integer for e in v)
zeta = z
bad = []
for t in reps:
    x = val(t)
    orb = set()
    for k in range(6):
        for conj in (False, True):
            y = sp.expand(zeta**k * (sp.conjugate(x) if conj else x))
            orb.add(y)
    for y in orb:
        if not in_Lambda(y): bad.append((t, y))
print("orbit points outside Lambda:", len(bad), bad[:3])
# the 30 unit vectors
eta = (s33 + I*s3)/6
U30 = set()
for sgn in (1,-1):
  for pat in [(12,0,0,0),(10,0,0,2),(10,0,0,-2),(6,0,6,0),(6,0,-6,0),(0,2,2,0),(0,2,-2,0)]:
    U30.add(sp.expand(sgn*val(pat)))
import itertools
for base in [(5,1,5,1),(3,1,1,3)]:
    for signs in itertools.product((1,-1), repeat=4):
        if sum(1 for s in signs if s<0) % 2 == 1:
            U30.add(sp.expand(val(tuple(s*b for s,b in zip(signs,base)))))
print(len(U30), "Parts unit vectors; all |u|=1:", all(sp.simplify(u*sp.conjugate(u)-1)==0 for u in U30))
target = set(sp.expand(zeta**k * eta**e) for k in range(6) for e in range(-2,3))
print("equal to mu6*eta^{-2..2}:", all(any(sp.simplify(u-t)==0 for t in target) for u in U30))
print("all in Lambda:", all(in_Lambda(u) for u in U30))

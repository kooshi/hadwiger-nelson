# Is Parts's base-graph coordinate lattice P = {(a + b*sqrt33 + i c sqrt3 + i d sqrt11)/12 : a-b+c+d in 4Z}
# contained in de Grey's Lambda = (1/9) O_E, O_E = Z[zeta6, w], w=(1+sqrt(-11))/2 ?  Exact: express 9*v in basis 1, z, w, z*w.
import sympy as sp
s3, s11 = sp.sqrt(3), sp.sqrt(11)
I = sp.I
z = sp.Rational(1,2) + I*s3/2          # zeta6
w = sp.Rational(1,2) + I*s11/2
basis = [sp.Integer(1), z, w, sp.expand(z*w)]
def coords(x):
    # solve x = sum c_k basis_k over Q using real/imag parts in Q-basis {1, sqrt33, sqrt3, sqrt11} (x = p + q sqrt33 + i(r sqrt3 + t sqrt11))
    c = sp.symbols('c0:4')
    e = sp.expand(sum(ci*bi for ci,bi in zip(c,basis)) - x)
    re, im = sp.expand(sp.re(e)), sp.expand(sp.im(e))
    eqs = []
    for part in (re, im):
        part = sp.expand(part)
        # collect over 1, sqrt33, sqrt3, sqrt11
        d = sp.collect(part, [sp.sqrt(33), s3, s11], evaluate=False)
        eqs += list(d.values())
    sol = sp.solve(eqs, c, dict=True)
    return [sp.nsimplify(sol[0][ci]) for ci in c]
gens = [(4,0,0,0),(1,1,0,0),(1,0,-1,0),(1,0,0,-1)]   # Z-basis of {a-b+c+d = 0 mod 4}
for g in gens:
    a,b,cc,d = g
    v = (a + b*sp.sqrt(33) + I*cc*s3 + I*d*s11)/12
    co = coords(9*v)
    print(g, "9v coords:", co, "in O_E" if all(x.is_integer for x in co) else "NOT in O_E")
# control that must land outside: v/2
v = (1 + sp.sqrt(33))/24
print("control (1,1,0,0)/24:", coords(9*v))

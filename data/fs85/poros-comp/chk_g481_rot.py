# For k in -4..4: does the rotated base graph eta^k * G481 lie in Lambda (all 481 points), and are its edges in U (|exp| <= 4)?
import re, sympy as sp
txt=open('parts-hv.txt').read()
reps=sorted(set(tuple(map(int,m)) for m in re.findall(r'^\s*\((-?\d+),(-?\d+),(-?\d+),(-?\d+)\)\s+[\d.]', txt, re.M)))
s3,s11,s33,I=sp.sqrt(3),sp.sqrt(11),sp.sqrt(33),sp.I
z=sp.Rational(1,2)+I*s3/2; w=sp.Rational(1,2)+I*s11/2
B=[sp.Integer(1),z,w,sp.expand(z*w)]
def comps(x):
    x=sp.expand(x); r,i=sp.expand(sp.re(x)),sp.expand(sp.im(x))
    cr=sp.collect(r,[s33],evaluate=False); ci=sp.collect(i,[s3,s11],evaluate=False)
    return [cr.get(sp.S(1),0),cr.get(s33,0),ci.get(s3,0),ci.get(s11,0)]
Minv=sp.Matrix([comps(b) for b in B]).T.inv()
def inL(x): return all(sp.nsimplify(e).is_integer for e in Minv*sp.Matrix(comps(9*x)))
def val(t):
    a,b,c,d=t; return (a+b*s33+I*c*s3+I*d*s11)/12
def flip(x):  # Galois sqrt3 -> -sqrt3 (so sqrt33 -> -sqrt33), i fixed
    return sp.expand(x.subs({s33:-s33}).subs({s3:-s3}))
pts=set()
for t in reps:
    x=val(t)
    for kk in range(6):
        for cj in (0,1):
            for fl in (0,1):
                y=x
                if fl: y=flip(y)
                if cj: y=sp.conjugate(y)
                pts.add(sp.expand(z**kk*y))
print(len(pts),"points of G481 (expect 481)")
eta=(s33+I*s3)/6
for k in [1,2,3,4]:
    r=sp.expand(eta**k)
    bad=sum(1 for p in pts if not inL(sp.expand(r*p)))
    print("k=",k," points of eta^k*G481 outside Lambda:",bad)

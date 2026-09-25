from fractions import Fraction as Fr
import math, itertools
X=[(Fr(1),Fr(0)),(Fr(0),Fr(1)),(Fr(4,5),Fr(3,5)),(Fr(-3,5),Fr(4,5)),(Fr(4,5),Fr(-3,5)),(Fr(3,5),Fr(4,5))]
def band(t): f=t-math.floor(t); return Fr(1,3)<=f<=Fr(2,3)
def ok(p,q): return all(band(p*a+q*b) for a,b in X)
P=5
lines=[]
for (a,b) in X:
    # values of a p + b q over [0,5]^2
    vals=[a*p+b*q for p in (0,P) for q in (0,P)]
    for k in range(math.floor(3*min(vals))-1, math.ceil(3*max(vals))+2):
        if k%3: lines.append((a,b,Fr(k,3)))
V=set()
for (a1,b1,c1),(a2,b2,c2) in itertools.combinations(lines,2):
    det=a1*b2-a2*b1
    if det==0: continue
    p=(c1*b2-c2*b1)/det; q=(a1*c2-a2*c1)/det
    if 0<=p<P and 0<=q<P and ok(p,q): V.add((p,q))
print(len(V),"vertices of Theta_R in [0,5)^2")
for v in sorted(V): print(v, [float(x) for x in v])

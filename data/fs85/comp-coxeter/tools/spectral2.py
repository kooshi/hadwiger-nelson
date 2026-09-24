"""Values of the family symbols lambda_k on Theta_{-2..2} (exact: cos of rational multiples of 2pi, evaluated numerically
at high precision and rounded; the points are torsion of order <= 30)."""
from spectral import *
import math, collections
from math import lcm
def lamk(t,k):
    return sum(2*math.cos(2*math.pi*float(sum(Q(a)*x for a,x in zip(v,t)))) for v in fam[k])
sols,_,_=theta([-2,-1,0,1,2])
sols=sorted(sols)
for k in range(-4,5):
    vals=collections.Counter(round(lamk(t,k),9) for t in sols)
    print(k, sorted(vals.items())[:12], '...' if len(vals)>12 else '')

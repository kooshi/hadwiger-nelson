from spectral import *
from math import lcm
import collections
from sympy import Matrix
from sympy.matrices.normalforms import hermite_normal_form, smith_normal_form
def order(t): return lcm(*[x.denominator for x in t])
def period_lattice(S):
    den=lcm(*[order(t) for t in S])
    rows=[[int(den*x) for x in t] for t in S]
    A=Matrix(rows+[[den if i==j else 0 for j in range(4)] for i in range(4)])
    H=hermite_normal_form(A.T).T
    Hs=Matrix([r for r in H.tolist() if any(r)])
    Pm=(Hs.inv()*den).T
    return Pm, den
S5,_,_=theta([-2,-1,0,1,2]); S9,_,_=theta(list(range(-4,5)))
Pm,den=period_lattice(sorted(S5))
print('Theta_{-2..2}: lcm of orders',den,'; period lattice index',abs(Pm.det()),'; Smith form of period lattice basis:',smith_normal_form(Pm).tolist())
c=collections.Counter(order(t) for t in S5); print('orders:',sorted(c.items()))
T8=[t for t in S5 if 8%order(t)==0]
print('8-torsion points in Theta_{-2..2}:',len(T8),'; of which in Theta_all:',len(set(T8)&S9))

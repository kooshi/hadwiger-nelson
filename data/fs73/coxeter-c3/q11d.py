from theta2 import *
from exact_tree import exact_theta
from sympy import Rational
U=[]
for p in range(-10,11):
  for q in range(-10,11):
    for r_ in range(-3,4):
      for s in range(-3,4):
        if p*p+q*q+11*(r_*r_+s*s)==100 and p*r_+q*s==0: U.append((p,q,r_,s))
B, C = lattice_coords(U); S = halfset(C); r = B.shape[1]
D, sub, M, Minv, Cu, leaves = enumerate_theta(S, r, verbose=False)
pts, nodes, reps = exact_theta(S, r, D, sub, M, Minv, Cu)
print("exact nodes", nodes, "leaves", len(pts))
thetas = []
for k, ext in pts:
    assert all(a == b for a, b in ext), ext
    t = [a + k[i] for i, (a, b) in enumerate(ext)]
    th = [sum(Rational(int(Minv[a_,b_].p), int(Minv[a_,b_].q))*t[b_] for b_ in range(r)) for a_ in range(r)]
    thetas.append(th)
# checks: each theta in (1/3)Z^4, fully tight, isolated (the 1/3-set positively spans)
from sympy import floor
ok = True
phis = []
for th in thetas:
    assert all((3*x).q == 1 for x in th), th
    vals = [sum(th[a]*u[a] for a in range(r)) for u in S]
    fr = [v - floor(v) for v in vals]
    assert all(x in (Rational(1,3), Rational(2,3)) for x in fr)
    phi = [int(3*x) % 3 for x in th]
    phis.append(phi)
import json; json.dump({"phis":phis,"S":S,"thetas":[[str(x) for x in t] for t in thetas]}, open("q11_exact.json","w"))
print("all", len(thetas), "points are additive (theta in (1/3)Z^4) and fully tight")
# F = intersection of ker phi over the 16 phis, as a subgroup of Lambda / 3Lambda = F_3^4
from sympy import Matrix as SM
K = SM(phis)
print("rank over F_3 of the phis:", SM(phis).rank(iszerofunc=lambda x: x % 3 == 0))
import itertools
common = [v for v in itertools.product(range(3), repeat=r) if all(sum(p[i]*v[i] for i in range(r)) % 3 == 0 for p in phis)]
print("common kernel in Lambda/3Lambda:", common)

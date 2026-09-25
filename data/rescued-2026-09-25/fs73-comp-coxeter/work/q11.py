from theta import *
from fractions import Fraction as Fr
U=[]
for p in range(-10,11):
  for q in range(-10,11):
    for r in range(-3,4):
      for s in range(-3,4):
        if p*p+q*q+11*(r*r+s*s)==100 and p*r+q*s==0: U.append((p,q,r,s))
print(len(U))
B = hnf_basis([list(u) for u in U]); print("basis",B)
Uc=[coords(B,list(u)) for u in U]
Up=[]; 
for u in Uc:
    if tuple(-x for x in u) not in [tuple(v) for v in Up]: Up.append(u)
print("U+",len(Up))
V = vertices(Up, 4)
print("vertices mod Z^4:", len(V))
allt = 0
for th in V:
    vals=[sum(th[a]*u[a] for a in range(4))%1 for u in Up]
    tight = all(v in (Fr(1,3),Fr(2,3)) for v in vals)
    allt += tight
print("fully tight vertices:", allt)
import json; json.dump({"basis":B,"Up":Up,"V":[[str(x) for x in th] for th in V]}, open("q11_theta.json","w"))

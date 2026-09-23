# Unit vectors of Q(sqrt11)(i) with denominator | 10, coords (p,q,r,s): z = (p + r*sqrt11)/10 + i (q + s*sqrt11)/10
import itertools, json
from fractions import Fraction
U=[]
for p in range(-10,11):
  for q in range(-10,11):
    for r in range(-3,4):
      for s in range(-3,4):
        if p*p+q*q+11*r*r+11*s*s==100 and p*r+q*s==0: U.append((p,q,r,s))
print(len(U))
# lattice basis via HNF of integer vectors (these are 10*z coordinates)
import sympy
M=sympy.Matrix(U)
from sympy.matrices.normalforms import hermite_normal_form
H=hermite_normal_form(M.T).T  # rows?
print(H)
json.dump(U,open('q11_U.json','w'))

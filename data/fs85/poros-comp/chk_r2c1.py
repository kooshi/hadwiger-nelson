# Poros: check Coxeter's NO answer to card R2-C1 (exact witness).
import sympy as sp
from fractions import Fraction as Fr
src=open('chk_c8.py').read().split("for K in [")[0]
exec(src)
S,_=theta_K(list(range(-2,3)))
U={k:[lam(mul(zs_,pw(k))) for zs_ in [one,z,mul(z,z),mul(z,mul(z,z)),mul(mul(z,z),mul(z,z)),mul(z,mul(mul(z,z),mul(z,z)))]] for k in range(-4,5)}
def lamk(t,k): return sum(sp.cos(2*sp.pi*sum(sp.Rational(x.numerator,x.denominator)*c for x,c in zip(t,u))) for u in U[k])
def A(t,m): return sp.nsimplify(sp.simplify(lamk(t,m)+lamk(t,-m)+4))
th1=(Fr(11,12),Fr(1,2),Fr(7,12),Fr(7,12))
print("theta1 in Theta_{-2..2}:", th1 in S, " lam_k for |k|<=2:", [sp.simplify(lamk(th1,k)) for k in range(-2,3)])
print("A3,A4 at theta1:", A(th1,3), A(th1,4))
import math
o6=[t for t in S if sp.ilcm(*[x.denominator for x in t])==6]
hits=[t for t in o6 if abs(float(lamk(t,3)+lamk(t,-3)+4)-3)<1e-9 and abs(float(lamk(t,4)+lamk(t,-4)+4)-3)<1e-9]
print("order-6 chars in Theta_{-2..2}:",len(o6)," with A3=A4=3:",len(hits), hits[:1])
if hits: print("exact A3,A4:",A(hits[0],3),A(hits[0],4))

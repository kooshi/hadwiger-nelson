import json,sys,math
sys.path.insert(0,'/home/kooshi/source/lean-dir/tools')
from fractions import Fraction as Fr
from fs73_theta_lib import unit_vectors, in_band, exact_lp_max, half_set
key="348|1,0,0,1;0,1,1,0;0,0,2,0;0,0,0,2"
J=json.load(open('data/fs73/q167/coxeter-Ld14c588b-linear-3colouring.json'))
psi=[Fr(x) for x in J['psi']]
U=unit_vectors(key,167); H=half_set([list(u) for u in U])
print(len(U), all(in_band(sum(p*x for p,x in zip(psi,u))) for u in U))
A=[];b=[]
for u in H:
    v=sum(p*x for p,x in zip(psi,u)); j=math.floor(v)
    A.append([Fr(x) for x in u]+[Fr(1)]); b.append(j+Fr(2,3))
    A.append([Fr(-x) for x in u]+[Fr(1)]); b.append(-(j+Fr(1,3)))
st,x,y=exact_lp_max(A,b,[0,0,0,0,1])
print(st, "max slack", x[4], "point", x[:4])

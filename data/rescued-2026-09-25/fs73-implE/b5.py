# the product structure U = {b x : b in B5, x in U_R} for L21cc6506, exact
import sys, json
sys.path.insert(0,'/home/kooshi/source/lean-dir/tools')
from fractions import Fraction as Fr
from fs73_theta_lib import unit_vectors
M=420; d=167
U=unit_vectors("420|1,0,0,1;0,1,1,0;0,0,2,0;0,0,0,2",d)
def mul(u,v):   # product in E of (a,b,c,e)/M elements, returned *M (must be integral)
    a1,b1,c1,e1=u; a2,b2,c2,e2=v
    # x = (a+b s) , y=(c+e s), s^2=d ; (x1+iy1)(x2+iy2)
    xr=(a1*a2+d*b1*b2)-(c1*c2+d*e1*e2); xs=(a1*b2+b1*a2)-(c1*e2+e1*c2)
    yr=(a1*c2+d*b1*e2)+(c1*a2+d*e1*b2); ys=(a1*e2+b1*c2)+(c1*b2+e1*a2)
    t=[xr,xs,yr,ys]; assert all(x%M==0 for x in t); return tuple(x//M for x in t)
UR=[u for u in U if u[1]==0 and u[3]==0]
B5={'1':(420,0,0,0),'v':(415,0,0,5),'vbar':(415,0,0,-5),'z':(225,15,225,-15),'zc':(225,15,-225,15)}
prods={}
for n,b in B5.items():
    for x in UR: prods[mul(b,x)]=(n,x)
print(len(UR),"rational units;", len(prods),"products; equal to U:", set(prods)==set(U))
# order: v-units, rational (4,3)&(3,4) first, then the rest rational, then z, zc, vbar
def half(lst):
    out=[]; 
    for u in lst:
        if tuple(-t for t in u) not in out and u not in out: out.append(u)
    return out
def units_of(n, xs): return [mul(B5[n],x) for x in xs]
Rord=[(336,0,252,0),(252,0,336,0),(420,0,0,0),(0,0,420,0),(336,0,-252,0),(252,0,-336,0)]
order=half(units_of('v',Rord))+half(Rord)+half(units_of('z',Rord))+half(units_of('zc',Rord))+half(units_of('vbar',Rord))
print(len(order))
json.dump([list(u) for u in order],open('order_structured.json','w'))

#!/usr/bin/env python3
"""FS116-S1 EXPLORATION, not a control and not a proof: a discretised reachable set of curves gamma from p (heading 0,
|kappa| <= 1, Euler steps of 0.002, kappa in {-1, -1/2, 0, 1/2, 1}) under the two cluster constraints |P - y_3| <= 1 and
|Q - y_5| <= 1 only (P = gamma + nu, Q = gamma - nu), for the non-Siamese (Q)-free ring with change points psi + 60k.
It omits dist(P, T_IV) >= 1 and dist(Q, T_I) >= 1 on purpose: it shows where FS116-S1-EXIT has to bite. Prints the
state count, the largest |gamma|, the least angular margins to the lens sides beyond |gamma| = 0.05, and the exits found.
Run: python3 tools/fs116_s1_reach.py PSI [PSI ...]   (minutes per value)
"""
import math, sys
def e(d): r=math.radians(d); return (math.cos(r),math.sin(r))
def dist(a,b): return math.hypot(a[0]-b[0],a[1]-b[1])
def run(psi,ds,H,B):
    y2,y3,y6=e(psi+60),e(psi+120),e(psi-60); y5=(-y2[0],-y2[1])
    key=lambda x,y,b:(round(x/H),round(y/H),round(math.degrees(b)/B))
    exits=[]; seen={key(0,0,0)}; frontier=[(0.0,0.0,0.0)]; mr=0; m2=99; m6=99; ex=0; steps=0; arg=None
    while frontier and steps<5000:
        steps+=1; nf=[]
        for (x,y,b) in frontier:
            for k in (-1.0,-0.5,0.0,0.5,1.0):
                b2=b+k*ds; x2=x+math.cos(b+k*ds/2)*ds; y2_=y+math.sin(b+k*ds/2)*ds
                nu=(-math.sin(b2),math.cos(b2))
                if dist((x2+nu[0],y2_+nu[1]),y3)>1 or dist((x2-nu[0],y2_-nu[1]),y5)>1: continue
                d2=1-dist((x2,y2_),y2); d6=1-dist((x2,y2_),y6)
                if d2<0 or d6<0: ex+=1; exits.append((round(x2,4),round(y2_,4),round(math.degrees(b2),2),round(math.degrees(math.atan2(y2_-y2[1],x2-y2[0]))+90,2))); continue
                kk=key(x2,y2_,b2)
                if kk in seen: continue
                seen.add(kk); nf.append((x2,y2_,b2))
                r=math.hypot(x2,y2_)
                if r>mr: mr=r; arg=(x2,y2_,math.degrees(b2))
                if r>0.05:
                    ph=math.degrees(math.atan2(y2_,x2)); al=math.degrees(math.acos(r/2))
                    m2=min(m2,ph-(psi+60-al)); m6=min(m6,(psi-60+al)-ph)
        frontier=nf
    return len(seen),mr,arg,m2,m6,ex,exits[:4]
for psi in [float(a) for a in sys.argv[1:]]:
    print(psi, run(psi,0.002,0.002,0.5))

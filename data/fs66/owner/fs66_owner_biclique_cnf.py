#!/usr/bin/env python3
"""Owner's exploratory encoder: k-colourability of UD(Z/p^2,2) in the BICLIQUE encoding.
Between the fibres over two adjacent level-one points the graph is p disjoint K_{p,p} (lines to lines), so each
biclique's p^2 conflict clauses become ONE clause on 'line' variables plus 2p implications.
  usage: fs66_owner_biclique_cnf.py P K out.cnf [--naive] [--nopin]
Decoding/verification of a model is done by tools/fs66_owner_verify.py (which shares nothing with this file)."""
import sys, json
p=int(sys.argv[1]); k=int(sys.argv[2]); out=sys.argv[3]
naive='--naive' in sys.argv; nopin='--nopin' in sys.argv
n=p*p
S2=[(a,b) for a in range(n) for b in range(n) if (a*a+b*b)%n==1]
assert len(S2)==p*(p+1)
S1=sorted({(a%p,b%p) for a,b in S2})
# canonical representative of each direction class {s,-s}
canon=[]
for s in S1:
    m=((-s[0])%p,(-s[1])%p)
    if s<=m: canon.append(s)
D=len(canon); assert D==(p+1)//2
lift={}
for a,b in S2: lift.setdefault((a%p,b%p),(a,b))      # one lift per level-one direction
vid=lambda X,Y: X*n+Y
cvar=lambda v,c: v*k+c+1
NV=n*n*k
def line(d,X,Y):
    s=canon[d]; return (s[0]*(X//p)+s[1]*(Y//p))%p
zbase=NV
def zvar(x0,x1,d,t,c): return zbase+((((x0*p+x1)*D+d)*p+t)*k+c)+1
clauses=[]
for X in range(n):
    for Y in range(n):
        v=vid(X,Y)
        clauses.append([cvar(v,c) for c in range(k)])
if naive:
    for X in range(n):
        for Y in range(n):
            for a,b in S2:
                X2,Y2=(X+a)%n,(Y+b)%n
                if vid(X,Y)<vid(X2,Y2):
                    for c in range(k): clauses.append([-cvar(vid(X,Y),c),-cvar(vid(X2,Y2),c)])
    total=NV
else:
    total=NV+p*p*D*p*k
    for X in range(n):
        for Y in range(n):
            v=vid(X,Y)
            for d in range(D):
                t=line(d,X,Y)
                for c in range(k): clauses.append([-cvar(v,c),zvar(X%p,Y%p,d,t,c)])
    for x0 in range(p):
        for x1 in range(p):
            for d,s in enumerate(canon):
                a,b=lift[s]
                y0,y1=(x0+s[0])%p,(x1+s[1])%p
                seen={}
                for u0 in range(p):
                    for u1 in range(p):
                        X,Y=x0+p*u0,x1+p*u1
                        X2,Y2=(X+a)%n,(Y+b)%n
                        assert (X2%p,Y2%p)==(y0,y1)
                        t,t2=line(d,X,Y),line(d,X2,Y2)
                        assert seen.setdefault(t,t2)==t2       # the matching of lines is well defined
                assert len(set(seen.values()))==p
                for t,t2 in seen.items():
                    for c in range(k): clauses.append([-zvar(x0,x1,d,t,c),-zvar(y0,y1,d,t2,c)])
pins=[]
if not nopin:
    # a triangle through the origin (if one exists): 0, s, s' with s - s' on the circle
    tri=None
    S2set=set(S2)
    for s in S2:
        for t in S2:
            if ((s[0]-t[0])%n,(s[1]-t[1])%n) in S2set: tri=(s,t); break
        if tri: break
    pins=[(0,0,0)]
    if tri: pins+= [(tri[0][0],tri[0][1],1),(tri[1][0],tri[1][1],2)] if k>=3 else []
    else: pins+=[(S2[0][0],S2[0][1],1)]
    for X,Y,c in pins: clauses.append([cvar(vid(X,Y),c)])
with open(out,'w') as f:
    f.write(f"p cnf {total} {len(clauses)}\n")
    for cl in clauses: f.write(' '.join(map(str,cl))+' 0\n')
print(json.dumps({"p":p,"k":k,"n":n,"vars":total,"clauses":len(clauses),"encoding":"naive" if naive else "biclique","pins":pins}))

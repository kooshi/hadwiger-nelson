#!/usr/bin/env python3
"""Owner's verifier for a phase-1 ask at fabric scale, exact and independent of tools/fs70_*:
all unit vectors with denominator dividing the file's M are enumerated (numpy box over the four real embeddings, exact
integer squares, hash-paired), every point's translates by them are looked up in the point set -- that is the complete
unit-distance graph on the points -- compared with the file's edge list, and the colouring checked on MY edges and the pin.
Usage: po_verify_ask.py GRAPH.json COLOURING.json 'PIN_JSON'"""
import json, sys, numpy as np
g=json.load(open(sys.argv[1])); M=g['M']; P=[tuple(p) for p in g['points']]; E=set(map(tuple,g['edges']))
S3,S5,S15=3**.5,5**.5,15**.5
def units_over(M):
    a=np.arange(-M,M+1); b=np.arange(-int(M/S3)-1,int(M/S3)+2); c=np.arange(-int(M/S5)-1,int(M/S5)+2); d=np.arange(-int(M/S15)-1,int(M/S15)+2)
    A,B,C,D=[x.astype(np.int64).ravel() for x in np.meshgrid(a,b,c,d,indexing='ij')]
    ok=np.ones(A.shape,bool)
    for sb in (1,-1):
        for sc in (1,-1):
            ok&=np.abs(A+sb*B*S3+sc*C*S5+sb*sc*D*S15)<=M+1e-9
    A,B,C,D=A[ok],B[ok],C[ok],D[ok]
    # exact square: (a+b√3+c√5+d√15)^2 = (a²+3b²+5c²+15d²) + (2ab+10cd)√3 + (2ac+6bd)√5 + (2ad+2bc)√15
    r=A*A+3*B*B+5*C*C+15*D*D; s3=2*A*B+10*C*D; s5=2*A*C+6*B*D; s15=2*A*D+2*B*C
    key=lambda r,s3,s5,s15: ((r*4096+ (s3+2048))*4096 + (s5+2048))*4096 + (s15+2048)   # ranges are small; injective
    K=key(r,s3,s5,s15); T=M*M
    need=key(T-r,-s3,-s5,-s15)
    order=np.argsort(K); Ks=K[order]
    lo=np.searchsorted(Ks,need,'left'); hi=np.searchsorted(Ks,need,'right')
    out=[]
    for i in np.nonzero(hi>lo)[0]:
        for j in order[lo[i]:hi[i]]:
            out.append((int(A[i]),int(B[i]),int(C[i]),int(D[i]),int(A[j]),int(B[j]),int(C[j]),int(D[j])))
    return out
U=units_over(M)
print(f"unit vectors over denominator {M}: {len(U)}")
idx={p:i for i,p in enumerate(P)}
mine=set()
for i,p in enumerate(P):
    for u in U:
        q=tuple(x+y for x,y in zip(p,u))
        j=idx.get(q)
        if j is not None and j>i: mine.add((i,j))
print(f"points {len(P)}; file edges {len(E)}; my edges {len(mine)}; equal: {mine==E}; missing-from-file {len(mine-E)} extra-in-file {len(E-mine)}")
c=json.load(open(sys.argv[2])); col=c['colour']; vmap=c.get('vmap')
def colour_of(v): return col[v] if len(col)==len(P) else col[vmap[v] if isinstance(vmap,list) else vmap[str(v)]]
bad=sum(1 for i,j in mine if colour_of(i)==colour_of(j))
print(f"monochromatic edges under my derivation: {bad}; colours used: {sorted(set(colour_of(v) for v in range(len(P))))}")
if len(sys.argv)>3:
    pin=json.loads(sys.argv[3])
    for v,k in pin['pins']: print(f"  pin vertex {v} -> colour {k}: {'ok' if colour_of(v)==k else 'VIOLATED'}")
    if pin['kind']=='forces':
        A,B=pin['pins'][0][0],pin['pins'][1][0]; print(f"  pair ({A},{B}) colours {colour_of(A)},{colour_of(B)} -> {'separated: NOT forced on this fabric' if colour_of(A)!=colour_of(B) else 'EQUAL?!'}")

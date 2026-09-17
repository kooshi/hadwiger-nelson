#!/usr/bin/env python3
"""fs58_sat_classes -- FS-58 B5: for every 3-non-integral orbit class c of unit vectors over Q(sqrt D) with least denominator N <= NMAX,
the saturated lattice of {axis, c} (with the (3/5, 4/5) family when 5 | N, the (5/13, 12/13) family when 13 | N): every orbit class of
denominator dividing the pool's denominator that lies in the lattice joins the pool. Prints, for every such lattice of covolume >= MINCOV,
its size, covolume, the point count of a ball of physical radius 1.5 (50 / covolume) and the least odd cycle within a 20,000-point
breadth-first cap. UNTRUSTED (tools/); exact lattice membership; the covolume is a float. Usage: D NMAX MINCOV.
"""
import sys, math
sys.path.insert(0,'tools')
from fs58_search import *
from fs58_local import units_d
from fractions import Fraction as Fr
D=int(sys.argv[1]); NM=int(sys.argv[2]); mincov=float(sys.argv[3])
t=time.time()
C=classes(D,NM)
print(len(C),'classes up to',NM, round(time.time()-t,1),'s', flush=True)
cands=[n for n in C if not n.startswith('q') and C[n][0]%3==0]
rows=[]
for c in cands:
    N=C[c][0]
    for base in (['q1','q5'] if N%5==0 else [], ['q1','q13'] if N%13==0 else [], ['q1']):
        if not base: continue
        names=base+[c]
        M,W=pool_vectors(D,C,names)
        ech=hnf_basis(W)
        if len(ech)<4: continue
        Bi=inverse(ech)
        extra=[]
        for n,(Nn,vecs) in C.items():
            if n in names or M%Nn: continue
            v=[Fr(x*M,Nn) for x in vecs[0]]
            cc=[sum(v[i]*Bi[i][j] for i in range(4)) for j in range(4)]
            if all(tt.denominator==1 for tt in cc): extra.append(n)
        sat=names+extra
        M2,W2=pool_vectors(D,C,sat); B,co,cov,mc=reduce_pool(D,M2,W2)
        if cov<mincov: continue
        bip=bool(forms_mod(co,2))
        og=odd_girth(co,20000) if not bip else {'bipartite':True}
        rows.append((cov,'+'.join(sat),len(W2),og))
        print(f"{'+'.join(sat)}: |W| {len(W2)} cov {cov:.3g} pts@1.5 {50/cov:.0f} odd {og.get('length', og)} {og.get('none_up_to','')}", flush=True)

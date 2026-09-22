#!/usr/bin/env python3
"""Owner's independent Kempe screen (phase-1 record §4): for a named lattice and target delta, over every proper additive
Z/4 colouring phi with phi(delta) = 0 and every colour b in {1,2,3}, compute the (0,b)-Kempe reach of the origin --
the Z-span of {z + w : z, w unit vectors of the lattice, phi(z) = b, phi(w) = -b} -- and test delta in it.
One escape (delta not in the reach) means no finite graph in the lattice forces (0, delta) at four colours.
Usage: po_kempe_screen.py NAME[+NAME...] DELTA_NAME   (delta names: 4/3 8/3 4/7 2 4)"""
import sys, itertools
from math import gcd
sys.path.insert(0, 'data/fs70/owner')
import po_screen_lattice as L   # runs its own screen on import for sys.argv[1]; we reuse its lattice objects

def hnf_cols(vectors, dim=8):
    """integer column-echelon (Hermite) basis of the Z-span of the given integer vectors"""
    rows=[list(v) for v in vectors]
    basis=[]
    piv=0
    M=[r[:] for r in rows]
    for col in range(dim):
        # find rows with nonzero entry in col among remaining
        while True:
            nz=[i for i in range(len(M)) if M[i][col]!=0]
            if not nz: break
            i0=min(nz, key=lambda i: abs(M[i][col]))
            p=M[i0][col]
            done=True
            for i in nz:
                if i!=i0:
                    q=M[i][col]//p
                    M[i]=[a-q*b for a,b in zip(M[i],M[i0])]
                    if M[i][col]!=0: done=False
            if done:
                basis.append(M[i0]); M=[M[i] for i in range(len(M)) if i!=i0]
                break
    return basis   # echelon rows (each with a pivot strictly to the right of the previous)

def member(basis, v):
    v=list(v)
    for b in basis:
        p=next(i for i,x in enumerate(b) if x!=0)
        if v[p]%b[p]!=0: return False
        q=v[p]//b[p]; v=[a-q*c for a,c in zip(v,b)]
    return all(x==0 for x in v)

def main():
    LU=L.LU; rank=L.rank
    dn=sys.argv[2]
    num,den={'4/3':(4,3),'8/3':(8,3),'4/7':(4,7),'2':(2,1),'4':(4,1)}[dn]
    tgt=L.coords(L.vec(((num,0,0,0),(0,0,0,0),den)))
    assert tgt is not None, "target not in lattice"
    escapes={1:0,2:0,3:0}; proper=0; zero_at=0; first=None
    for phi in itertools.product(range(4),repeat=rank):
        vals=[sum(c*p for c,p in zip(cv,phi))%4 for cv in LU]
        if any(v==0 for v in vals): continue
        proper+=1
        if sum(c*p for c,p in zip(tgt,phi))%4!=0: continue
        zero_at+=1
        for b in (1,2,3):
            Z=[cv for cv,v in zip(LU,vals) if v==b]; W=[cv for cv,v in zip(LU,vals) if v==(-b)%4]
            sums=[[x+y for x,y in zip(z,w)] for z in Z for w in W]
            B=hnf_cols(sums)
            if not member(B,tgt):
                escapes[b]+=1
                if first is None: first=(phi,b,len(B))
    print(f"{sys.argv[1]} delta={dn}: proper Z/4 colourings {proper}; with phi(delta)=0: {zero_at}; escapes by colour b: {escapes}")
    if first: print("  first escape: phi=",first[0]," b=",first[1]," reach rank",first[2], "-> KILLED at every radius")
    else: print("  no escape: LIVE under this screen")
main()

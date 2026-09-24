"""Build every pinned pair-linear colouring on Lambda/8Lambda from the linear algebra, check properness directly on
Cay(Lambda/8Lambda, U), and compare with the committed census.  A check of a derived family, not a search."""
import numpy as np, itertools
from fast import *
from zlin import *
def c9(z): return [int(x*9) for x in z.c]
Uv=[c9(u) for u in UNITS]
ADM=[(0,1,1,0),(0,1,1,1),(1,0,0,1),(1,0,1,1),(1,1,0,1),(1,1,1,0)]
# vertices of Lambda/8Lambda: DIG rows = 9z mod 8 (basis 1,zeta,w,zeta w)
d,allc=load(True)
census=set(allc)
U8=[tuple(x%8 for x in v) for v in Uv]
def proper(c):
    return all((c[sh(u)]!=c).all() for u in U8)
built=set(); nproper=0; nbuilt=0
for pv in ADM:
    piv=(DIG@np.array(pv))%2
    U0=[v for v in Uv if sum(a*b for a,b in zip(pv,v))%2==0]
    Hp=hnf([v+[1] for v in U0]); P=pivots(Hp)
    HL=hnf(U0)
    # coset label of z mod L0: Lambda/L0 = Z/8; find functional kappa: Lambda -> Z/8 with kernel L0 via Smith form
    import sympy
    from sympy.matrices.normalforms import smith_normal_form
    # brute: kappa determined by a vector k with k.v = 0 mod 8 for all v in U0 and k.e generating
    ks=[k for k in itertools.product(range(8),repeat=4) if all(sum(a*b for a,b in zip(k,v))%8==0 for v in U0) and any(x%2 for x in k)]
    kap=ks[0]
    kz=(DIG@np.array(kap))%8
    # ell-values: sigma(z) = h[kappa(z)] + ell(z - r(kappa(z))) ; compute ell on each vertex relative to coset rep
    # ell(z - r): represent by solving; simpler: BFS over U0 edges from coset reps (sigma flips along each U0 edge)
    lvl=-np.ones(4096,dtype=np.int64)
    reps={}
    for i in range(4096):
        if lvl[i]>=0: continue
        lvl[i]=0; reps[int(kz[i])]=i; stack=[i]
        while stack:
            x=stack.pop()
            for u in U0:
                u8=tuple(t%8 for t in u)
                y=int(sh(u8)[x])
                if lvl[y]<0: lvl[y]=lvl[x]^1; stack.append(y)
                else: assert lvl[y]==lvl[x]^1, 'ell inconsistent'
    assert len(reps)==8, len(reps)
    for h in itertools.product(range(2),repeat=8):
        sg=(lvl+np.array(h)[kz])%2
        # pin: c(0)=0, c(1)=1, c(zeta)=2  -> beta
        one=kidx(tuple(x%8 for x in c9(E(1)))); zt=kidx(tuple(x%8 for x in c9(Z)))
        beta={}
        beta[(piv[0],sg[0])]=0
        k1=(piv[one],sg[one])
        if k1 in beta: continue
        beta[k1]=1
        kzeta=(piv[zt],sg[zt])
        if kzeta in beta: continue
        beta[kzeta]=2
        rest=[k for k in itertools.product(range(2),repeat=2) if k not in beta]
        if len(rest)!=1: continue
        beta[rest[0]]=3
        c=np.array([beta[(int(p),int(s))] for p,s in zip(piv,sg)],dtype=np.int8)
        nbuilt+=1
        if proper(c): nproper+=1
        built.add(''.join(map(str,c)))
print('pinned pair-linear colourings built:',nbuilt,' proper:',nproper,' distinct:',len(built))
print('in census:',len(built&census),' census size:',len(census),' census not built:',len(census-built))
perm=np.zeros(4096,dtype=np.int64)
from census import HB
for idx in range(4096):
    n=[(idx>>9)&7,(idx>>6)&7,(idx>>3)&7,idx&7]
    z=sum((HB[i]*n[i] for i in range(4)),E(0))
    perm[kidx(key8(z))]=idx       # my index -> census index
cen2=set()
for s in allc:
    a=np.frombuffer(s.encode(),dtype=np.uint8)-48
    cen2.add(''.join(map(str,a[perm])))
print('census re-indexed to O_E/8:',len(cen2),' equal to the pair-linear family:',cen2==built, ' overlap:',len(cen2&built))
one=kidx(tuple(x%8 for x in c9(E(1)))); zt=kidx(tuple(x%8 for x in c9(Z)))
cen3=set()
for s in cen2:
    a=np.array(list(map(int,s)))
    m={a[0]:0,a[one]:1,a[zt]:2}; m[[x for x in range(4) if x not in m][0]]=3
    cen3.add(''.join(str(m[x]) for x in a))
print('census re-pinned at (0,1,zeta):',len(cen3),'; equal to the pair-linear family:',cen3==built)

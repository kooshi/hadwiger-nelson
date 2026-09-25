# Per-lattice arithmetic profile of Lambda_M over Q(sqrt D): denominators, and at every prime of F with residue field F_p (p <= P)
# at which Lambda_M is integral, the level-one image target's circle coverage and its Hoffman ratio (float; aiming only).
import sys, math, numpy as np
from sympy import factorint, isprime, legendre_symbol, sqrt_mod
from units_fast import units_fast
from units import true_den
D=int(sys.argv[1]); P=int(sys.argv[2])
for M in map(int, sys.argv[3:]):
    U=units_fast(M,D); dens=set(true_den(v,M) for v in U); dp=sorted(set(q for t in dens for q in factorint(t)))
    print('== M',M,factorint(M),'|U|',len(U),'denominator primes',dp)
    for p in range(3,P):
        if not isprime(p) or p in dp: continue
        if D%p==0: roots=[0]
        elif legendre_symbol(D%p,p)==1: roots=sorted(set(sqrt_mod(D%p,p,all_roots=True)))
        else: print('  p',p,'inert in F (q = p^2): not profiled'); continue
        stable = (p%4==3)
        inv=pow(M,-1,p); x=np.arange(p); X,Y=np.meshgrid(x,x,indexing='ij')
        for s in roots:
            img=sorted(set(((a+b*s)*inv%p,(c+e*s)*inv%p) for (a,b,c,e) in U)); d=len(img)
            circ=p+1 if p%4==3 else p-1
            ev=np.zeros((p,p))
            for a,b in img: ev+=np.cos(2*np.pi*(a*X+b*Y)/p)
            lm=ev.min(); r=-lm/(d-lm)
            print('  p',p,'stable' if stable else 'nonstable','s',s,'image',d,'/',circ,'Hoffman %.4f'%r,'REFUSES-4' if r<0.25-1e-9 else 'open')

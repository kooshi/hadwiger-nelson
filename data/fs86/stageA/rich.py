# Spec check: the saturated-chain lattice Lambda_M over Q(sqrt d): |U_M|, rank, primes in true denominators,
# odd-prime integrality, circle coverage at the stable odd primes (level one only), 2-adic index of Lambda in O.
import math, sys, time
from fractions import Fraction as Fr
from sympy import Matrix, factorint, sqrt_mod, isprime, legendre_symbol
from units import units, true_den
D=int(sys.argv[1]); M=int(sys.argv[2])
t0=time.time(); U=units(M,D); print('d',D,'M',M,'|U_M|',len(U),'time %.1fs'%(time.time()-t0))
dens=sorted(set(true_den(v,M) for v in U)); primes=sorted(set(p for td in dens for p in factorint(td)))
print('true denominators',dens); print('primes in denominators',primes)
# O-coordinates of z = x+iy, basis {1, i, w, i w}, w=(1+i sqrt d)/2 (valid for d = 3 mod 4, -d = 1 mod 4)
Ovec=[tuple(Fr(t,M) for t in (a-e, b+c, 2*e, -2*b)) for (a,b,c,e) in U]
B=Matrix(Ovec); r=B.rank(); print('rank',r)
# Z-basis via HNF of the integer matrix M*Ovec, then det
Mi=Matrix([[int(x*M) for x in v] for v in Ovec])
from sympy.matrices.normalforms import hermite_normal_form
H=hermite_normal_form(Mi.T).T  # rows span the lattice (times M)
H=Matrix([row for row in H.tolist() if any(row)])
det=abs(Fr(int(H.det()), M**4)) if H.shape==(4,4) else None
print('HNF shape',H.shape,'det of Lambda in O-coords',det, 'factor', (factorint(det.numerator),factorint(det.denominator)) if det else None)
# circle coverage at stable odd primes (p = 3 mod 4, d a square mod p, or p | d)
for p in [q for q in range(3,80) if isprime(q) and q%4==3 and (D%q==0 or legendre_symbol(D%q,q)==1)]:
    roots=[0] if D%p==0 else sorted(set(sqrt_mod(D%p,p,all_roots=True)))
    for s in roots:
        inv=pow(M,-1,p)
        img=set(((a+b*s)*inv%p,(c+e*s)*inv%p) for (a,b,c,e) in U)
        circ=sum(1 for x in range(p) for y in range(p) if (x*x+y*y)%p==1)
        print('  p',p,'sqrt->',s,'image',len(img),'of circle',circ, 'FULL' if len(img)==circ else '')

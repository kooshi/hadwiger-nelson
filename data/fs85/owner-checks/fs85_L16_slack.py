# Owner's check: Cay(Λ/16Λ, U mod 16) is slack at four colours (λ_min < −d/3), while Cay(Λ/8Λ, U mod 8) is tight (λ_min = −d/3).
from sympy import sqrt, I, expand, symbols, linsolve
import itertools, numpy as np
z6=(1+I*sqrt(3))/2; w=(1+I*sqrt(11))/2; B=[1,z6,w,expand(z6*w)]
eta=(sqrt(33)+I*sqrt(3))/6; etab=(sqrt(33)-I*sqrt(3))/6
a,b,c,d=symbols('a b c d',real=True)
def coords(x):
    e=expand(9*x-(a*B[0]+b*B[1]+c*B[2]+d*B[3])); re,im=e.as_real_imag(); eqs=[]
    for part in (expand(re),expand(im)):
        for s in (sqrt(33),sqrt(11),sqrt(3)):
            co=part.coeff(s); eqs.append(co); part=expand(part-co*s)
        eqs.append(part)
    (sol,)=linsolve(eqs,[a,b,c,d]); return [int(v) for v in sol]
U=[coords(expand(z6**k*(eta**j if j>=0 else etab**(-j)))) for k in range(6) for j in range(-4,5)]
for m in (8,16):
    S=np.array(sorted({tuple(v%m for v in u) for u in U}))
    ks=np.array(list(itertools.product(range(m),repeat=4)),dtype=np.int64)
    ev=np.zeros(len(ks))
    for s in S: ev+=np.cos(2*np.pi*((ks@s)%m)/m)
    dg=len(S); lm=ev.min()
    print(f'mod {m}: distinct generators {dg}, lambda_min {lm:.6f}, -d/3 {-dg/3:.6f}, ',
          'TIGHT' if abs(lm+dg/3)<1e-9 else ('SLACK' if lm< -dg/3 else 'refuses 4 colours (ratio bound)'))

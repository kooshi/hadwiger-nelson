# Owner's independent check of FS85-dB5: the spectrum of Cay(Λ/8Λ, U mod 8), Λ = (1/9)O_E, U = {ζ6^a η^b : |b| ≤ 4}.
from sympy import sqrt, I, expand, symbols, linsolve, Rational
import itertools, numpy as np
z6=(1+I*sqrt(3))/2; w=(1+I*sqrt(11))/2
B=[1,z6,w,expand(z6*w)]
eta=(sqrt(33)+I*sqrt(3))/6; etab=(sqrt(33)-I*sqrt(3))/6
a,b,c,d=symbols('a b c d',real=True)
def coords(x):   # coordinates of x in the Λ-basis (1/9)B
    e=expand(9*x-(a*B[0]+b*B[1]+c*B[2]+d*B[3])); re,im=e.as_real_imag(); eqs=[]
    for part in (expand(re),expand(im)):
        for s in (sqrt(33),sqrt(11),sqrt(3)):
            co=part.coeff(s); eqs.append(co); part=expand(part-co*s)
        eqs.append(part)
    (sol,)=linsolve(eqs,[a,b,c,d]); return tuple(sol)
U=[]
for k in range(6):
    for j in range(-4,5):
        x=expand(z6**k*(eta**j if j>=0 else etab**(-j)))
        U.append(coords(x))
assert all(all(v.is_integer for v in u) for u in U), 'a unit vector outside Λ'
assert len(set(U))==54
# unit check: |x|^2 = 1 for each (sanity) -- via coordinates is implicit in construction
S=sorted({tuple(int(v)%8 for v in u) for u in U})
print('unit vectors',len(U),' distinct mod 8Λ:',len(S),' 0 in S:',(0,0,0,0) in S)
Sarr=np.array(S)
ks=np.array(list(itertools.product(range(8),repeat=4)))
ev=np.cos(2*np.pi*(ks@Sarr.T)/8).sum(axis=1)
deg=len(S); lmin=ev.min()
print('degree',deg,' lambda_min %.9f'%lmin,' -deg/3 =',-deg/3,' multiplicity of min:',int(np.sum(np.abs(ev-lmin)<1e-9)))
print('Hoffman alpha bound n/(1-d/lmin) =', 4096/(1-deg/lmin), ' vs n/4 =',4096/4)
# control: drop one generator pair -> tightness must break
S2=[s for s in S if s!=S[1] and s!=tuple((-v)%8 for v in S[1])]
ev2=np.cos(2*np.pi*(ks@np.array(S2).T)/8).sum(axis=1)
print('control (one ± pair dropped): degree',len(S2),' lambda_min %.6f'%ev2.min(),' -deg/3 =',-len(S2)/3)

# Owner's check of FS85-C8 on the 8-torsion: characters θ of Λ/8Λ with, for each family k, some j in {0,1,2} with θ(ζ^j η^k) = 1/2.
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
    (sol,)=linsolve(eqs,[a,b,c,d]); return np.array([int(v) for v in sol])
ep=lambda k: eta**k if k>=0 else etab**(-k)
V={(k,j):coords(expand(z6**j*ep(k))) for k in range(-4,5) for j in range(3)}
th=np.array(list(itertools.product(range(8),repeat=4)))          # θ = t/8
def theta_set(K):
    ok=np.ones(len(th),bool)
    for k in K:
        hit=np.zeros(len(th),bool)
        for j in range(3): hit|= ((th@V[(k,j)])%8)==4             # θ(v) = 1/2  <=>  t·v ≡ 4 (mod 8)
        ok&=hit
    return th[ok]
S9=theta_set(range(-4,5)); S5=theta_set(range(-2,3))
print('8-torsion characters, all nine families:',len(S9),'  five inner families:',len(S5))
print('the two sets equal:', set(map(tuple,S9))==set(map(tuple,S5)))
# do the 42 generate Hom(Λ/8Λ, Z/8)? rank over Z/8 via Smith invariants of the 42x4 integer matrix
from sympy import Matrix
from sympy.matrices.normalforms import smith_normal_form
from sympy.polys.domains import ZZ
M=Matrix(S9.tolist()+[[8,0,0,0],[0,8,0,0],[0,0,8,0],[0,0,0,8]])
print('Smith invariants of <42 characters> + 8Z^4:',[smith_normal_form(M,domain=ZZ)[i,i] for i in range(4)],' (all 1 means they generate (Z/8)^4)')
orders=[8//np.gcd.reduce(np.append(t,8)) for t in S9]
import collections; print('orders:',sorted(collections.Counter(orders).items()))

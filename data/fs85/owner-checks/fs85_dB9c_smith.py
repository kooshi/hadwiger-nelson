# Owner's check of FS85-dB9(c): for each choice of one stripe direction eps_k (a sixth root of unity up to sign) in each of the five
# orientations eta^k T0, |k| <= 2, the period lattice L = <2 eta^k eps_k> has finite index in Λ = (1/9)O_E; report the Smith invariants.
from sympy import sqrt, I, expand, symbols, linsolve, Matrix, lcm
from sympy.matrices.normalforms import smith_normal_form
from sympy.polys.domains import ZZ
import itertools, collections
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
ep=lambda k: eta**k if k>=0 else etab**(-k)
gen={(k,j):coords(expand(2*ep(k)*z6**j)) for k in range(-2,3) for j in range(3)}
counts=collections.Counter(); exps=[]; bad=0
for choice in itertools.product(range(3),repeat=5):
    M=Matrix([gen[(k,choice[k+2])] for k in range(-2,3)])
    S=smith_normal_form(M,domain=ZZ)
    inv=[abs(S[i,i]) for i in range(4)]
    if 0 in inv: bad+=1; continue
    counts[tuple(inv)]+=1; exps.append(inv[-1] if inv[-1]!=0 else 0)
print('choices',3**5,' infinite index:',bad)
for k,v in sorted(counts.items(),key=lambda t:-t[1])[:12]: print(' invariants',k,'x',v)
print('lcm of exponents:',lcm(exps))

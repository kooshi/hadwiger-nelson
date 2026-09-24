# Owner's check of FS85-C15's exact inputs: with Λ_K = <U_{|k|<=K}>, the alternate triples ζ^{2i}η^k (i=0,1,2) and ζ^{2i+1}η^k
# of families ±4 lie in one coset of Λ_7 = <U_{|k|<=3}>, and those of families ±3 in one coset of Λ_5 = <U_{|k|<=2}>; indices odd.
from sympy import sqrt, I, expand, symbols, linsolve, Matrix
from sympy.matrices.normalforms import smith_normal_form, hermite_normal_form
from sympy.polys.domains import ZZ
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
U={(k,j):coords(expand(z6**j*ep(k))) for k in range(-4,5) for j in range(6)}
def sub(K): return Matrix([U[(k,j)] for k in range(-K,K+1) for j in range(6)])
def index(M):
    S=smith_normal_form(M,domain=ZZ); inv=[abs(S[i,i]) for i in range(4)]; return inv
def member(v,M):
    # v in row lattice of M ?  (compare indices of M and M+v)
    return index(M)==index(M.col_join(Matrix([v])))
for K,fams in ((3,(4,-4)),(2,(3,-3))):
    M=sub(K); inv=index(M); import math
    print(f'Λ_{2*K+1} = <U_|k|<={K}>: Smith invariants {inv}, index {math.prod(inv)}')
    for k in fams:
        for par in (0,1):
            tri=[U[(k,(2*i+par)%6)] for i in range(3)]
            diffs=[[tri[i][t]-tri[0][t] for t in range(4)] for i in (1,2)]
            print(f'  family {k:+d}, {"even" if par==0 else "odd"} triple in one coset:', all(member(dv,M) for dv in diffs))
# control: a family-±4 unit vector itself should NOT lie in Λ_7 if the index is nontrivial (else the coset claim is vacuous)
M7=sub(3); print('control: η^4 in Λ_7:', member(U[(4,0)],M7), '  η^3 in Λ_5:', member(U[(3,0)],sub(2)))

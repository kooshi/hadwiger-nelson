# Owner's independent check of FS85-R3a step 4(a)/F5: order-10 characters of Λ5 = <U_{|k|<=2}> meeting the five family conditions
# split as (order-2 pair index π) + θ5; for each π the 5-parts are the nonzero points of two lines of F5^4; the three planes at one prime
# (π's closed under addition) meet pairwise only in 0.
from sympy import sqrt, I, expand, symbols, linsolve, Matrix
from sympy.matrices.normalforms import hermite_normal_form
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
ep=lambda k: eta**k if k>=0 else etab**(-k)
G={(k,j):coords(expand(z6**j*ep(k))) for k in range(-2,3) for j in range(6)}
M=Matrix([G[key] for key in sorted(G)])            # 30 x 4, coordinates in Λ
H=hermite_normal_form(M.T).T                        # rows: a Z-basis of Λ5 (in Λ coordinates)
Bs=Matrix([list(H.row(i)) for i in range(H.rows) if any(H.row(i))])
assert Bs.rows==4, Bs
print('Λ5 basis det (index in Λ):',abs(Bs.det()))
Binv=Bs.inv()
def inb(v):                                         # coordinates of v in the Λ5 basis (must be integral)
    r=(Matrix([v])*Binv); assert all(x.is_integer for x in r); return np.array([int(x) for x in r])
V={key:inb(G[key]) for key in G}
th=np.array(list(itertools.product(range(10),repeat=4)))   # θ = t/10 on the Λ5 basis
ok=np.ones(len(th),bool)
for k in range(-2,3):
    hit=np.zeros(len(th),bool)
    for j in range(3): hit|=((th@V[(k,j)])%10)==5
    ok&=hit
S=th[ok]
order=lambda t: 10//np.gcd.reduce(np.append(t,10))
o10=[t for t in S if order(t)==10]; o2=[t for t in S if order(t)==2]
print('characters of order | 10 meeting all five families:',len(S),' of order 2:',len(o2),' of order 10:',len(o10))
groups={}
for t in o10:
    pi=tuple((5*t)%10); th5=tuple(int(x) for x in (6*t)%10//2*0+ (t%5))   # 2-part and 5-part (θ mod 5)
    groups.setdefault(pi,set()).add(th5)
def span5(vecs):
    Mx=Matrix([list(v) for v in vecs]); return Mx.rank(iszerofunc=lambda x: x%5==0) if False else rank_mod5(vecs)
def rank_mod5(vecs):
    A=[list(v) for v in vecs]; r=0; cols=4
    for col in range(cols):
        piv=next((i for i in range(r,len(A)) if A[i][col]%5),None)
        if piv is None: continue
        A[r],A[piv]=A[piv],A[r]; inv=pow(A[r][col],-1,5); A[r]=[(x*inv)%5 for x in A[r]]
        for i in range(len(A)):
            if i!=r and A[i][col]%5: f=A[i][col]; A[i]=[(x-f*y)%5 for x,y in zip(A[i],A[r])]
        r+=1
    return r
print('pair indices π with order-10 characters:',len(groups))
for pi,pts in groups.items():
    lines=set(); 
    for p in pts: lines.add(min(tuple((m*x)%5 for x in p) for m in range(1,5)))
    print(' π',pi,': 5-parts',len(pts),' lines',len(lines),' plane dim',rank_mod5(list(pts)))
pis=list(groups)
triples=[t for t in itertools.combinations(pis,3) if tuple((x+y)%10 for x,y in zip(t[0],t[1]))==t[2] or tuple((x+y+z)%10 for x,y,z in zip(*t))==(0,0,0,0)]
print('triples closed under addition (one prime each):',len(triples))
for T in triples:
    for i,j in itertools.combinations(T,2):
        print('  dim(Π_i + Π_j) =',rank_mod5(list(groups[i])+list(groups[j])))

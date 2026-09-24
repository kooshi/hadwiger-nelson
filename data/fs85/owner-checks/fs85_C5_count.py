# Owner's independent check of Coxeter's C5 by counting, no re-pinning:
# build every "pair-linear" colouring of Cay(Λ/8Λ, U mod 8) BY FORMULA (a homomorphism π: Λ→F2 for the pair worn,
# a parity character on <U∩ker π> for the colour within the pair), check each is proper, count the distinct ones,
# and compare with FS-73's certified census count (9,120 in all). If PL ⊆ proper and |PL| = 9,120 = |census|, PL = census.
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
    (sol,)=linsolve(eqs,[a,b,c,d]); return tuple(int(v) for v in sol)
U=[coords(expand(z6**k*(eta**j if j>=0 else etab**(-j)))) for k in range(6) for j in range(-4,5)]
Um=np.array(sorted({tuple(v%8 for v in u) for u in U}))
N=8**4
pts=np.array(list(itertools.product(range(8),repeat=4)))
idx=lambda P: ((P[:,0]%8)*512+(P[:,1]%8)*64+(P[:,2]%8)*8+(P[:,3]%8))
nbr=np.stack([idx(pts+u) for u in Um],axis=1)          # 4096 x 36
def proper(col): return bool(np.all(col[:,None]!=col[nbr]))
fam=set(); admissible=[]
for avec in itertools.product(range(2),repeat=4):
    if not any(avec): continue
    pi=(pts@np.array(avec))%2
    U0=[u for u in Um if (np.dot(avec,u)%2)==0]
    # parity character on <U0> + 8Λ: 2-colour the U0-graph on Λ/8Λ by propagation (a bipartiteness check, no search)
    U0i=np.stack([idx(pts+u) for u in U0],axis=1) if U0 else None
    sig=-np.ones(N,int); comp=-np.ones(N,int); ok=True; ncomp=0
    for s in range(N):
        if sig[s]>=0: continue
        sig[s]=0; comp[s]=ncomp; stack=[s]
        while stack and ok:
            x=stack.pop()
            for y in U0i[x]:
                if sig[y]<0: sig[y]=1-sig[x]; comp[y]=ncomp; stack.append(y)
                elif sig[y]==sig[x]: ok=False; break
        ncomp+=1
        if not ok: break
    if not ok: continue
    admissible.append((avec,len(U0),ncomp))
    # every colouring with this π: 4 colours split into two ordered pairs on the two π-halves, a phase per U0-component
    comps=[np.where(comp==k)[0] for k in range(ncomp)]
    compPi=[int(pi[cc[0]]) for cc in comps]
    for perm in itertools.permutations(range(4)):
        for phases in itertools.product(range(2),repeat=ncomp):
            col=np.empty(N,np.int8)
            for k,cc in enumerate(comps):
                p=compPi[k]; col[cc]=np.array([perm[2*p+0],perm[2*p+1]])[(sig[cc]+phases[k])%2]
            fam.add(col.tobytes())
print('admissible π:',len(admissible),[(''.join(map(str,a)),n0,nc) for a,n0,nc in admissible])
print('distinct pair-linear colourings (labelled):',len(fam),'  census (row 78): 9,120')
allproper=all(proper(np.frombuffer(bs,np.int8)) for bs in fam)
print('every one proper:',allproper)
# control: a non-admissible π must fail properness or bipartiteness; and a planted recolouring must be caught
bs=next(iter(fam)); col=np.frombuffer(bs,np.int8).copy(); col[0]=(col[0]+1)%4
print('control, one vertex recoloured -> improper:', not proper(col))

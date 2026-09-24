"""Consequences of the pair-linear classification, by exact integer linear algebra (Coxeter, FS-85):
K_pi = ker(ell) in L0 (the group of translations preserving every colouring with pair-map pi); F = intersection of the K_pi;
kappa(T0); the chirality: which Eisenstein unit m has (eta^2 - m) T0 inside K_pi."""
from efield import *
from zlin import *
import itertools, math
def c9(z): return [int(x*9) for x in z.c]
Uv=[c9(u) for u in UNITS]
ADM=[(0,1,1,0),(0,1,1,1),(1,0,0,1),(1,0,1,1),(1,1,0,1),(1,1,1,0)]
def data(pv):
    U0=[v for v in Uv if sum(a*b for a,b in zip(pv,v))%2==0]
    Hp=hnf([v+[1] for v in U0])
    def in_L0(w): return in_span(w,U0)
    def ell(w):
        v=list(w)+[0]
        for r,p in zip(Hp,pivots(Hp)):
            if p==4: break
            assert v[p]%r[p]==0
            q=v[p]//r[p]
            for j in range(5): v[j]-=q*r[j]
        assert not any(v[:4]); return (-v[4])%2
    def in_K(w): return in_L0(w) and ell(w)==0
    return U0,in_L0,ell,in_K
Ks=[]
for pv in ADM:
    U0,in_L0,ell,in_K=data(pv)
    # generators of K_pi: L0 basis adjusted: K = {x in L0: ell(x)=0}; basis: HNF(L0) rows b_i, fix parity
    B=hnf(U0); par=[ell(b) for b in B]
    odd=[b for b,p in zip(B,par) if p]; even=[b for b,p in zip(B,par) if not p]
    gens=even[:]
    if odd:
        o0=odd[0]; gens+= [[x+y for x,y in zip(o,o0)] for o in odd[1:]] + [[2*x for x in o0]]
    Ks.append(gens)
    kT0=[in_L0(c9(E(1))), in_L0(c9(Z))]
    # chirality: m in mu6 with (eta^2 - m) and (eta^2 - m) zeta in K_pi
    chir=[j for j in range(6) if in_K(c9(ETA**2-Z**j)) and in_K(c9((ETA**2-Z**j)*Z))]
    chir1=[j for j in range(6) if in_K(c9(ETA-Z**j)) and in_K(c9((ETA-Z**j)*Z))]
    chir1c=[j for j in range(6) if all(in_K(c9(ETA*t - Z**j*t.conj())) for t in (E(1),Z))]
    # direction of stripes: j with pi(zeta^j)=0
    dirn=[j for j in range(3) if sum(a*b for a,b in zip(pv,c9(Z**j)))%2==0]
    # index of kappa(T0) in Z/8: [L0 + T0 : L0]
    idxT=index_full(U0+[c9(E(1)),c9(Z)],4)
    print('pi',pv,'direction zeta^%s'%dirn,' [Lambda:K]=%d'%index_full(gens,4),' [Lambda:L0+T0]=%d'%idxT,
          ' eta^2 ~ zeta^%s'%chir,' eta ~ zeta^%s'%chir1, ' eta ~ zeta^j.conj: %s'%chir1c)
allg=[g for gs in Ks for g in gs]
print('[Lambda : intersection of all K_pi] check: 8Lambda inside each K:', all(all(in_span([8 if i==j else 0 for j in range(4)],gs) for i in range(4)) for gs in Ks))
# intersection: y in all K_pi, test on Lambda/8Lambda representatives
cnt=0
for y in itertools.product(range(8),repeat=4):
    if all(in_span(list(y),gs) for gs in Ks): cnt+=1
print('number of y in Lambda/8Lambda lying in every K_pi:',cnt,'(1 means F = 8 Lambda exactly)')

# Hoffman ratio floor chi_f >= 1 + d/|lambda_min| for Gamma_q = Cay(F_q^2, {x^2+y^2=1}), q = p (prime) or 27.
import cmath, itertools, sys
def prime_plane(p):
    S=[(x,y) for x in range(p) for y in range(p) if (x*x+y*y)%p==1]
    w=[cmath.exp(2j*cmath.pi*t/p) for t in range(p)]
    lam=[]
    for a in range(p):
        for b in range(p):
            if a==0 and b==0: continue
            lam.append(sum(w[(a*x+b*y)%p] for x,y in S).real)
    return len(S),min(lam)
# GF(27) = F_3[t]/(t^3 - t + 1); elements as tuples (c0,c1,c2)
def gmul(u,v):
    r=[0]*5
    for i in range(3):
        for j in range(3): r[i+j]+=u[i]*v[j]
    # t^3 = t - 1 ; t^4 = t^2 - t
    for k in (4,3):
        c=r[k]; r[k]=0
        # t^k = t^{k-3} * t^3 = t^{k-3}*(t - 1)
        r[k-2]+=c; r[k-3]-=c
    return tuple(x%3 for x in r[:3])
def gadd(u,v): return tuple((a+b)%3 for a,b in zip(u,v))
F=[tuple(c) for c in itertools.product(range(3),repeat=3)]
one=(1,0,0)
def tr(z):  # trace F_27 -> F_3: z + z^3 + z^9
    z3=gmul(gmul(z,z),z); z9=gmul(gmul(z3,z3),z3)
    return gadd(gadd(z,z3),z9)
def plane27():
    S=[(x,y) for x in F for y in F if gadd(gmul(x,x),gmul(y,y))==one]
    w=[cmath.exp(2j*cmath.pi*t/3) for t in range(3)]
    T={z:tr(z) for z in F}
    assert all(T[z][1]==0 and T[z][2]==0 for z in F)
    lam=[]
    for a in F:
        for b in F:
            if a==(0,0,0) and b==(0,0,0): continue
            lam.append(sum(w[T[gadd(gmul(a,x),gmul(b,y))][0]] for x,y in S).real)
    return len(S),min(lam)
for q in [3,7,11,19,23,27,31,43,47,59,67,71,79,83]:
    d,l = plane27() if q==27 else prime_plane(q)
    print(q, 'deg',d,'lam_min %.4f'%l, 'Hoffman chi_f floor %.4f'%(1+d/abs(l)))

# Unit vectors of Q(sqrt d)^2 with coordinates in (1/M) Z[sqrt d]: ((a+b r)/M, (c+e r)/M), a^2+d b^2+c^2+d e^2 = M^2, ab+ce = 0.
import math, sys
from fractions import Fraction as Fr
from sympy import Matrix, factorint
def units(M, D):
    out=set(); MM=M*M
    for a in range(-M,M+1):
        cm=math.isqrt(MM-a*a)
        for c in range(-cm,cm+1):
            s=MM-a*a-c*c
            if s% D: continue
            t=s//D
            if a==0 and c==0:
                for b in range(-math.isqrt(t),math.isqrt(t)+1):
                    e2=t-b*b
                    if e2>=0 and math.isqrt(e2)**2==e2:
                        out.add((0,b,0,math.isqrt(e2))); out.add((0,b,0,-math.isqrt(e2)))
                continue
            if t==0: out.add((a,0,c,0)); continue
            g=math.gcd(a,c); base=(a*a+c*c)//(g*g)
            if t%base: continue
            k=math.isqrt(t//base)
            if k*k*base!=t: continue
            for kk in (k,-k): out.add((a,kk*(-c)//g,c,kk*a//g))
    W=sorted(out)
    assert all(a*a+D*b*b+c*c+D*e*e==MM and a*b+c*e==0 for a,b,c,e in W)
    return W
def true_den(v,M):
    g=math.gcd(math.gcd(*[abs(x) for x in v]),M); return M//g
if __name__=='__main__':
    D=int(sys.argv[1]); Mmax=int(sys.argv[2])
    seen=set(); bydens={}
    for M in range(1,Mmax+1):
        for v in units(M,D):
            td=true_den(v,M); vv=tuple(Fr(x,M) for x in v)
            if vv in seen: continue
            seen.add(vv); bydens.setdefault(td,[]).append(vv)
    for td in sorted(bydens):
        irr=sum(1 for v in bydens[td] if v[1]!=0 or v[3]!=0)
        print(td, factorint(td), 'count',len(bydens[td]),'with sqrt-d part',irr)

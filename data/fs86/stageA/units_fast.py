# U_M over Q(sqrt D) by the (b,e) loop, numpy-vectorised over e. ((a+b r)/M, (c+e r)/M): a^2+c^2 = M^2 - D(b^2+e^2), (a,c) = k(-e,b)/g.
import numpy as np, math, sys
def units_fast(M, D):
    MM=M*M; out=set()
    # b = e = 0: rational points a^2 + c^2 = M^2
    for a in range(-M, M+1):
        c2=MM-a*a; c=math.isqrt(c2)
        if c*c==c2: out.add((a,0,c,0)); out.add((a,0,-c,0))
    B=math.isqrt(MM//D)
    for b in range(-B,B+1):
        E=math.isqrt(max(0,(MM-D*b*b)//D))
        e=np.arange(-E,E+1,dtype=np.int64)
        n=b*b+e*e
        mask=(n>0)&(MM-D*n>=0)
        e=e[mask]; n=n[mask]
        g=np.gcd(abs(b),np.abs(e)).astype(np.int64)
        base=n//(g*g)
        rem=MM-D*n
        ok=(rem%base==0)
        e,n,g,base,rem=e[ok],n[ok],g[ok],base[ok],rem[ok]
        k2=rem//base
        k=np.floor(np.sqrt(k2.astype(np.float64))).astype(np.int64)
        for dk in (-1,0,1):
            kk=k+dk; hit=(kk>=0)&(kk*kk==k2)
            for ei,gi,ki in zip(e[hit],g[hit],kk[hit]):
                ei=int(ei); gi=int(gi); ki=int(ki)
                for s in ((ki,-ki) if ki else (0,)):
                    out.add((s*(-ei)//gi, b, s*b//gi, ei))
    W=sorted(out)
    assert all(a*a+D*b*b+c*c+D*e*e==MM and a*b+c*e==0 for a,b,c,e in W)
    return W
if __name__=='__main__':
    from units import units
    for M in (30,210,2730):
        assert set(units_fast(M,59))==set(units(M,59)), M
    print('cross-check OK')

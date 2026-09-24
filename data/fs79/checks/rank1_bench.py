# Is there a K4-free distance graph G(Z,D), D subset {1..m}, with chi = 5 (not 4-colourable)
# and an independent set of density >= 1/4 (chi_f <= 4)?  Rank-1 inhabitant check for (Q-obs)'s benchmark.
import itertools, sys
from pysat.solvers import Cadical153
def k4free(D):
    Ds=set(D)
    # K4 on {0,a,b,c}, 0<a<b<c, all pairwise differences in D
    for a in D:
        for b in D:
            if b<=a or (b-a) not in Ds: continue
            for c in D:
                if c<=b or (c-a) not in Ds or (c-b) not in Ds: continue
                return False
    return True
def colourable(D,k,L):
    s=Cadical153(); v=lambda i,c:i*k+c+1
    for i in range(L):
        s.add_clause([v(i,c) for c in range(k)])
        for d in D:
            if i+d<L:
                for c in range(k): s.add_clause([-v(i,c),-v(i+d,c)])
    s.add_clause([v(0,0)])
    r=s.solve(); s.delete(); return r
def dens_quarter(D,maxp=40):
    # periodic independent set of density >= 1/4: period p, set A subset Z/p with |A|>=p/4, A-A avoids D mod p
    for p in range(1,maxp+1):
        Dm={d%p for d in D}|{(-d)%p for d in D}
        if 0 in Dm: continue
        need=-(-p//4)
        # greedy/exact small search for independent set size need in circulant C_p(Dm)
        best=[]
        def bt(start,cur):
            nonlocal best
            if len(cur)>=need: best=cur[:]; return True
            for x in range(start,p):
                if all(((x-y)%p) not in Dm for y in cur):
                    cur.append(x)
                    if bt(x+1,cur): return True
                    cur.pop()
            return False
        if bt(0,[]): return p,best
    return None
if __name__=="__main__":
    m=int(sys.argv[1]); size=int(sys.argv[2])
    found=0
    for D in itertools.combinations(range(1,m+1),size):
        if not k4free(D): continue
        if colourable(D,4,6*m): continue
        dq=dens_quarter(D)
        if dq:
            print("D=",D,"not 4-col (window",6*m,") ; density-1/4 periodic indep set:",dq); found+=1
            if found>=5: break
    print("done m=",m,"size=",size,"found",found)

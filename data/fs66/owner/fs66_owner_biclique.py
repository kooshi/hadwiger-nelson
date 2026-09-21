# Check: between the fibres over two adjacent level-one points, UD(Z/p^2,2) is a disjoint union of p complete
# bipartite graphs K_{p,p}, matching the lines of one fibre (direction s*i) to the lines of the other.
import itertools, sys
p=int(sys.argv[1]); n=p*p
S1=[(a,b) for a in range(p) for b in range(p) if (a*a+b*b)%p==1]
def adj(z,w): return ((z[0]-w[0])**2+(z[1]-w[1])**2)%n==1
bad=0; checked=0
for x in [(0,0),(3,7),(p-1,p-1),(5,0)]:
    for s in S1:
        y=((x[0]+s[0])%p,(x[1]+s[1])%p)
        fx=[(x[0]+p*a,x[1]+p*b) for a in range(p) for b in range(p)]
        fy=[(y[0]+p*a,y[1]+p*b) for a in range(p) for b in range(p)]
        # neighbourhoods in fy of each point of fx
        nb={z:frozenset(w for w in fy if adj(z,w)) for z in fx}
        classes={}
        for z,N in nb.items(): classes.setdefault(N,[]).append(z)
        ok = len(classes)==p and all(len(N)==p and len(zs)==p for N,zs in classes.items())
        # the classes on the x side are lines in direction s*i = (-s1, s0): constant value of  s0*a + s1*b  (the s-component)
        for N,zs in classes.items():
            vals={ (s[0]*((z[0]-x[0])//p) + s[1]*((z[1]-x[1])//p))%p for z in zs }
            ok &= len(vals)==1
        # disjointness of the neighbourhoods
        allN=list(classes.keys())
        ok &= sum(len(N) for N in allN)==n and len(frozenset().union(*allN))==n
        checked+=1; bad+= (not ok)
print(f"p={p}: {checked} level-one edges checked, {bad} failed the 'p disjoint K_(p,p), lines to lines' structure")

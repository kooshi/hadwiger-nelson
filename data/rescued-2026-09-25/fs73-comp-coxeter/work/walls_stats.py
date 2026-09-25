import itertools, math, sys
from walls1d import analyse
k=int(sys.argv[1]); M=int(sys.argv[2]); dmax=int(sys.argv[3])
multi=0; forcedany=0; tot=0
for size in range(2, M+1):
    for D in itertools.combinations(range(1,M+1), size):
        if math.gcd(*D)!=1 or max(D)<M: continue
        n,nt,sP,sF=analyse(D,k,dmax)
        if nt==0: continue
        tot+=1
        fP=[d for d in range(1,dmax+1) if d not in sP]; fF=[d for d in range(1,dmax+1) if d not in sF]
        if nt>1: multi+=1
        if fP: forcedany+=1; print(D, "SCCs",nt,"P",fP[:8],"F",fF[:8])
        if fP!=fF: print("   GAP!!", D)
print("max D =",M,"colourable",tot,"multiSCC",multi,"with P nonzero",forcedany)

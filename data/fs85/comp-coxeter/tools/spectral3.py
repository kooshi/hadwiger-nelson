from spectral import *
from math import lcm
import sys
for K in ([-3,-2,-1,0,1,2,3],[-2,-1,0,1,2,3],[-2,-1,0,1,2,4],[-2,-1,0,1,2,-4,4],[-3,-1,0,1,3],[-4,-2,0,2,4],[-4,-3,-2,-1,0,1,2,3,4]):
    sols,tori,emp=theta(K)
    orders=sorted(set(lcm(*[x.denominator for x in t]) for t in sols))
    print('K=%s: |Theta|=%d, tori %d; orders %s'%(K,len(sols),len(tori),orders)); sys.stdout.flush()

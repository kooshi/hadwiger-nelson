import sys, time, math
from units_fast import units_fast
from sympy import factorint
D=int(sys.argv[1]); p=int(sys.argv[2])
for M in map(int, sys.argv[3:]):
    t=time.time(); U=units_fast(M,D); inv=pow(M,-1,p)
    img=set(((a)*inv%p,(c)*inv%p) for (a,b,c,e) in U)
    print('M',M,factorint(M),'|U|',len(U),'image at ramified',p,':',len(img),'of',p+1,'(%.0fs)'%(time.time()-t)); sys.stdout.flush()

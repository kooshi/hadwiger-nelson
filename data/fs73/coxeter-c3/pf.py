import sys, time
from walls1d import analyse
D=tuple(map(int,sys.argv[1].split(','))); dmax=int(sys.argv[2])
t=time.time()
n,nt,sP,sF=analyse(D,4,dmax)
fP=[d for d in range(1,dmax+1) if d not in sP]; fF=[d for d in range(1,dmax+1) if d not in sF]
print(D,"states",n,"recurrent",nt,"P-forced",fP,"F-forced",fF,"GAP" if fP!=fF else "no gap", round(time.time()-t,1),"s",flush=True)

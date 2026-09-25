import numpy as np, sys
from units import units
D=int(sys.argv[1]); M=int(sys.argv[2]); p=int(sys.argv[3]); s=int(sys.argv[4])
U=units(M,D); inv=pow(M,-1,p)
img=sorted(set(((a+b*s)*inv%p,(c+e*s)*inv%p) for (a,b,c,e) in U)); d=len(img)
A=np.array(img)
x=np.arange(p); X,Y=np.meshgrid(x,x,indexing='ij'); ev=np.zeros((p,p))
for a,b in img: ev+=np.cos(2*np.pi*(a*X+b*Y)/p)
lmin=ev.min(); ratio=-lmin/(d-lmin)
print('p',p,'s',s,'d',d,'lambda_min %.6f'%lmin,'-d/3 %.4f'%(-d/3),'Hoffman alpha/n <= %.5f'%ratio,'(1/4 = 0.25)', 'REFUSES 4' if ratio<0.25-1e-9 else 'does not refuse 4')
# full circle control
circ=[(a,b) for a in range(p) for b in range(p) if (a*a+b*b)%p==1]
ev2=np.zeros((p,p))
for a,b in circ: ev2+=np.cos(2*np.pi*(a*X+b*Y)/p)
l2=ev2.min(); print('control full circle d',len(circ),'lambda_min %.4f'%l2,'ratio %.5f'%(-l2/(len(circ)-l2)))

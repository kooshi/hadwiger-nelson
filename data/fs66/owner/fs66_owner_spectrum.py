import numpy as np
p=11; n=p*p
# level one spectrum
def spectrum(m):
    ind=np.zeros((m,m))
    a=np.arange(m)
    ind[((a[:,None]**2+a[None,:]**2)%m)==1]=1
    return ind.sum(), np.real(np.fft.fft2(ind))
d1,e1=spectrum(p); d2,e2=spectrum(n)
print("level1: degree",d1,"lambda_min",e1.min(),"Hoffman ratio",-e1.min()/(d1-e1.min()))
print("level2: degree",d2,"lambda_min",e2.min(),"Hoffman ratio",-e2.min()/(d2-e2.min()), "p*lambda_min1",p*e1.min())
vals=np.round(e2.flatten(),6)
# classify characters: w=(c,d); pulled back iff p|c and p|d
c=np.arange(n)
pb=(c[:,None]%p==0)&(c[None,:]%p==0)
norm=(c[:,None]**2+c[None,:]**2)%p
sq={(x*x)%p for x in range(1,p)}
issq=np.isin(norm,list(sq)); unit=norm!=0
print("non-pulled-back, nonunit-norm (norm=0 mod p but not in pA): count",int((~pb&~unit).sum()), "distinct eig", np.unique(np.round(e2[~pb&~unit],6))[:5])
print("unit, nonsquare norm: max |eig|", np.abs(e2[unit&~issq]).max())
print("unit, square norm: eig range", e2[unit&issq].min(), e2[unit&issq].max(), " 2p =",2*p)
# line neighbourhood at level one: L = {(j,0)}; which parallel lines (0-th coord free, second coord = c) are hit
hit={}
for cc in range(p):
    cnt=0
    for j in range(p):
        if any(((j-jj)**2+cc**2)%p==1 for jj in range(p)): cnt+=1
    hit[cc]=cnt
print("points of line y=c adjacent to some point of line y=0:",hit)

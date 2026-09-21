# eigenvalues of UD(Z/p^k,2) by character depth: depth j = the character factors through level j and no lower
import numpy as np, sys
def run(p,k):
    m=p**k
    b=np.arange(m)
    ind=np.zeros((m,m)); ind[((b[:,None]**2+b[None,:]**2)%m)==1]=1
    deg=int(ind.sum())
    e=np.real(np.fft.fft2(ind))
    # depth of character (c,d): smallest j with p^(k-j) | c and d
    def vp(a):
        v=np.full(a.shape,k)
        for j in range(k-1,-1,-1):
            v[(a%(p**j)==0)&(a%(p**(j+1))!=0)]=j
        v[a==0]=k
        return v
    v=np.minimum(vp(b)[:,None],vp(b)[None,:])   # p-adic valuation of the pair
    depth=k-v                                     # 0 = trivial character
    print(f"p={p} level {k}: {m*m} vertices, degree {deg} (p^(k-1)(p+1) = {p**(k-1)*(p+1)})")
    for j in range(0,k+1):
        sel=depth==j
        if sel.any():
            print(f"   depth {j}: {int(sel.sum())} characters, eig in [{e[sel].min():.4f}, {e[sel].max():.4f}];  2p^(k-1) = {2*p**(k-1)},  2p^(k-j/2) = {2*p**(k-j/2):.4f}")
for p,k in ((3,2),(3,3),(3,4),(7,2),(7,3),(11,2)):
    run(p,k)

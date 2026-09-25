# Level-one image target at a prime p inert in Q(sqrt D) (residue F_{p^2} = F_p[t]/(t^2 - D)): Hoffman ratio of Cay(F_{p^2}^2, image of U).
import sys, numpy as np, itertools
from units_fast import units_fast
D=int(sys.argv[1]); M=int(sys.argv[2])
U=units_fast(M,D)
for p in map(int, sys.argv[3:]):
    if M%p==0: print('p',p,'divides M: skip'); continue
    inv=pow(M,-1,p)
    # element u + v t, t^2 = D; coordinates x=(a+b t)/M, y=(c+e t)/M
    img=sorted(set(((a*inv%p,b*inv%p),(c*inv%p,e*inv%p)) for (a,b,c,e) in U)); d=len(img)
    # circle size: x^2+y^2=1 over F_{p^2} with p^2 = 1 mod 4: p^2 - 1
    V=np.array([[x0,x1,y0,y1] for (x0,x1),(y0,y1) in img],dtype=np.int64)
    # additive characters of F_p^4 (coordinate dual); spectrum set is the same up to relabelling
    r=np.arange(p); grids=np.stack(np.meshgrid(r,r,r,r,indexing='ij'),-1).reshape(-1,4)
    ev=np.zeros(len(grids))
    for v in V: ev+=np.cos(2*np.pi*((grids@v)%p)/p)
    lm=ev.min(); ratio=-lm/(d-lm)
    print('p',p,'q',p*p,'image',d,'of circle',p*p-1,'lambda_min %.4f'%lm,'Hoffman %.4f'%ratio,'REFUSES-4' if ratio<0.25-1e-9 else 'open'); sys.stdout.flush()

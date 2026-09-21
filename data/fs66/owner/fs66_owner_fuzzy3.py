import numpy as np, sys, collections
exec(open('fs66_owner_fuzzy2.py').read().split("rng=np.random.default_rng(seed)")[0].replace("p=int(sys.argv[1]); k=int(sys.argv[2]); starts=int(sys.argv[3]); seed=int(sys.argv[4]) if len(sys.argv)>4 else 1","p,k,starts,seed=11,4,12,7"))
rng=np.random.default_rng(seed)
best=1e18
for s in range(starts):
    Phi=bcd(rng.dirichlet(np.ones(k),n),rng); q=Q(Phi)
    if q<best: best=q; B=Phi.copy()
print("best Q/budget",best/budget)
rows=collections.Counter(tuple(sorted(np.round(r,4),reverse=True)) for r in B)
for r,cnt in sorted(rows.items(),key=lambda t:-t[1]): print(cnt,r)
# energy split
mono=float(np.einsum('ij,ij->',B,A@B)); sq=float((B**2).sum())
print("sum over ordered adjacent pairs <phi_x,phi_y> =",round(mono,4)," sum ||phi||^2 =",round(sq,4)," n =",n)
# colour class weights
print("colour weights",np.round(B.sum(axis=0),4))

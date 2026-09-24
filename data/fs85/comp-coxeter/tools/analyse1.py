from census import *
d,a=load(True)
reps=d['orbit_representatives']
keys=list(itertools.product(range(8),repeat=4))
def add(k,l): return tuple((x+y)%8 for x,y in zip(k,l))
def kz(z): return key8(z)
eis=[kz(Z**j) for j in range(6)]
def periods(c):
    return [t for t in keys if all(c[k]==c[add(k,t)] for k in keys)]
def coset_stripe(c, x):
    """restriction of c to x+T0 (T0 mod 8 = 64 points): directions j (0..2) with period 2 along zeta^j"""
    pts=[add(x,(a,b,0,0)) for a in range(8) for b in range(8)]
    dirs=[j for j in range(3) if all(c[p]==c[add(p,kz(2*Z**j))] for p in pts)]
    ncol=len(set(c[p] for p in pts))
    return dirs,ncol
for name,s in reps.items():
    c=colouring_map(s)
    P=periods(c)
    # coset representatives of Lambda/T0 mod 8: keys (0,0,c3,c4) -- since T0 mod 8 = (a,b,0,0)
    stripes={}
    for c3 in range(8):
        for c4 in range(8):
            dirs,ncol=coset_stripe(c,(0,0,c3,c4))
            stripes[(c3,c4)]=(tuple(dirs),ncol)
    from collections import Counter
    print('rep',name,'#periods mod 8:',len(P),' coset stripe-direction census:',Counter(v for v in stripes.values()))

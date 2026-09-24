from census import *
from collections import Counter
d,a=load(False)
reps=d['orbit_representatives']
keys=list(itertools.product(range(8),repeat=4))
def add(k,l): return tuple((x+y)%8 for x,y in zip(k,l))
def neg(k): return tuple((-x)%8 for x in k)
kz=key8
one=kz(E(1)); zt=kz(Z)
U8=[kz(u) for u in UNITS]
for name,s in reps.items():
    c=colouring_map(s)
    pairs=Counter(frozenset((c[k],c[add(k,one)])) for k in keys)
    parts=set()
    for p in pairs:
        q=frozenset(range(4))-p
        parts.add(frozenset([p,q]))
    # pi : pair index relative to the pair containing colour of origin
    P0=frozenset((c[(0,0,0,0)],c[one]))
    pi={k:(0 if c[k] in P0 else 1) for k in keys}
    # is pi affine (additive)? test pi(x+y)=pi(x)+pi(y)-pi(0) on generators
    gens=[kz(E(1)),kz(Z),kz(ETA),kz(Z*ETA),kz(W),kz(Z*W)]
    lin=all((pi[add(k,g)]-pi[k]-pi[g]+pi[(0,0,0,0)])%2==0 for k in keys for g in [kz(E(1)),kz(Z),kz(W),kz(Z*W),kz(E(Q(1,9))),kz(Z*E(Q(1,9))),kz(W*E(Q(1,9))),kz(Z*W*E(Q(1,9)))])
    piU={ (j,k): pi[kz(Z**j*ETA**k)] for j in range(6) for k in range(-4,5)}
    print('rep',name,'#pairs',len(pairs),'#partitions',len(parts),'pi affine:',lin)
    print('   pi on eta^k (j=0..5):',[''.join(str(piU[(j,k)]) for j in range(6)) for k in range(-4,5)])

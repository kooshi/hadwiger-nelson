import sys, math, time; sys.path.insert(0,'tools')
import numpy as np
import fs73_lattice as FL, fs73_screen as S
for s in ['twounits:14','twounits:30','twounits:42']:
    t=time.time()
    lat = FL.fabric(s)
    import fs70_fabric as FB
    gens = []
    for z in FB.generators(s):
        x,y = z
        den=1
        for q in x+y: den = den*q.denominator//math.gcd(den,q.denominator)
        gens.append((tuple(int(q*den) for q in x+y), den))
    U8 = [lat.to_M(v,m) for v,m in gens]
    U = [lat.coords(w) for w in U8]
    assert all(u is not None for u in U)
    r = lat.rank
    for N in (2,3,4,5,6,7,8,9,10,11,12,13,14,15):
        Q = S.Quot(S.NW(N,r), r)
        c = Q.cls(np.array(U))
        adm = not (c==0).any()
        print(s, 'N', N, 'classes', Q.n, 'admissible', adm, 'distinct gen classes', len(set(c.tolist())), flush=True)
    print(time.time()-t)

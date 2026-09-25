import sys, math; sys.path.insert(0,'tools')
import fs73_lattice as FL, fs70_fabric as FB
from fractions import Fraction as Fr
def load(s):
    lat = FL.fabric(s)
    gens=[]
    for z in FB.generators(s):
        x,y=z
        den=1
        for q in x+y: den=den*q.denominator//math.gcd(den,q.denominator)
        gens.append((tuple(int(q*den) for q in x+y), den))
    return lat, gens
def fmt(v, m):
    names=['1','r3','r5','r15']
    def part(p):
        t=[f'{Fr(a,m)}*{n}' for a,n in zip(p,names) if a]
        return ' + '.join(t) or '0'
    return f'({part(v[:4])}) + i({part(v[4:])})'
for s in ['twounits:14','twounits:30','twounits:42']:
    lat, gens = load(s)
    print(s, 'M =', lat.M, 'factor:', end=' ')
    M=lat.M; f={}
    p=2
    while p*p<=M:
        while M%p==0: f[p]=f.get(p,0)+1; M//=p
        p+=1
    if M>1: f[M]=f.get(M,0)+1
    print(f)
    for N in (3,5,7,9,13):
        hits=[]
        for v,m in gens:
            c = lat.coords(lat.to_M(v,m))
            if all(x % N == 0 for x in c):
                hits.append((v,m,c))
        if hits:
            v,m,c = hits[0]
            # verify: c/N is an integer vector, point(c/N) is in the lattice, times N equals u
            h = tuple(x//N for x in c)
            w = lat.point(h)
            assert tuple(N*x for x in w) == lat.to_M(v,m)
            print(f'  N={N}: {len(hits)} generators in N*Lambda; e.g. u = {fmt(v,m)}, denominator {m}; u/{N} = lattice coords {h}')
        else:
            print(f'  N={N}: none')

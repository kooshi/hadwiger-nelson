# Owner's independent re-check of FS85-dB2's derived claims (own code; no colouring or graph search).
import itertools
def myc(V,E,tag):
    # Mycielskian: vertices x, copies (tag,x), apex (tag,'apex')
    V2=list(V)+[(tag,x) for x in V]+[(tag,'apex')]
    E2=set(E)
    for (a,b) in E:
        E2.add(frozenset({a,(tag,b)})); E2.add(frozenset({(tag,a),b}))
    for x in V: E2.add(frozenset({(tag,x),(tag,'apex')}))
    return V2,E2
C5V=[('v',i) for i in range(5)]; C5E={frozenset({('v',i),('v',(i+1)%5)}) for i in range(5)}
GrV,GrE=myc(C5V,C5E,'u')          # Grötzsch: copies ('u',('v',i)), apex ('u','apex')
MV,ME=myc(GrV,GrE,'y')            # M(Gr): copies ('y',x), apex ('y','apex')
g=('u','apex'); A=('y','apex'); yg=('y',g)
def tri(V,E):
    adj={v:set() for v in V}
    for e in E:
        a,b=tuple(e); adj[a].add(b); adj[b].add(a)
    return any(adj[a]&adj[b] for e in E for a,b in [tuple(e)])
print('Gr',len(GrV),len(GrE),'triangle',tri(GrV,GrE),' M(Gr)',len(MV),len(ME),'triangle',tri(MV,ME))
HE=ME-{frozenset({A,yg})}
# the formula colouring t
t={}
for i,c in enumerate([0,1,0,1,2]):
    t[('v',i)]=c; t[('u',('v',i))]=c
t[g]=3
for x in GrV: t[('y',x)]=t[x]
t[yg]=3; t[A]=3
assert all(t[a]!=t[b] for a,b in map(tuple,HE)), 't not proper on H'
print('t proper on H: True;  t proper on M(Gr):', all(t[a]!=t[b] for a,b in map(tuple,ME)))
# mu: A=0, y_g=1, others distinct powers of 8 (any order)
others=[v for v in MV if v not in (A,yg)]
mu={A:0,yg:1}; mu.update({v:8**(k+1) for k,v in enumerate(others)})
lam={v:4*mu[v]+t[v] for v in MV}
assert len(set(lam.values()))==len(MV)
D=sorted({abs(lam[a]-lam[b]) for a,b in map(tuple,HE)})
S=set(D)|{-d for d in D}
print('|D|',len(D),' D mod 4',sorted({d%4 for d in D}),' lam(yg)-lam(A)',lam[yg]-lam[A],' 4 in S',4 in S)
print('triangle-free (no s+t in S):', not any((s+u) in S for s in S for u in S))
# control 1: add an element making a triangle -> must be detected
S2=S|{D[0]+D[1],-(D[0]+D[1])}; print('control, added D0+D1 -> triangle detected:', any((s+u) in S2 for s in S2 for u in S2))
# control 2: the mod-4 colouring must break if 4 is added
print('control, 4 added -> mod-4 colouring improper:', 4%4==0)
from math import gcd; from functools import reduce
print('gcd(D)',reduce(gcd,D),' max D',max(D))
# B3 on a random sample is implied by the base-8 argument; spot-check exhaustively on the 23 values
vals=sorted(lam.values()); sums={}
bad=0
for c in itertools.combinations_with_replacement(vals,3):
    s=sum(c)
    if s in sums and sums[s]!=c: bad+=1
    sums[s]=c
print('B3 violations among all 3-multisets:',bad)

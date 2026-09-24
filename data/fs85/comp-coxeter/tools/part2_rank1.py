"""FS-85 Part 2, the rank-1 'free embedding' instance (Coxeter).  Everything here is a check of an object given by formula:
no search, no solver.  The one fact not checked here is Mycielski's theorem chi(M(G)) = chi(G) + 1 (1955), which with
chi(C5) = 3 gives chi(G3) = 5 for G3 = M(M(C5))."""
import itertools
def mycielski(n, edges):
    E=set()
    for (u,v) in edges:
        E.add((u,v)); E.add((u+n,v)); E.add((v+n,u))
    for u in range(n): E.add((u+n,2*n))
    return 2*n+1, {tuple(sorted(e)) for e in E}
C5=(5,{(i,(i+1)%5) for i in range(5)})
n2,E2=mycielski(*C5)          # Groetzsch graph, 11 vertices, apex 10
n3,E3=mycielski(n2,E2)        # 23 vertices, apex 22; shadow of 10 is 21
assert n2==11 and len(E2)==20 and n3==23 and len(E3)==71
u_,v_=21,22                   # the removed edge {x', w} with x = apex of the Groetzsch graph
assert (u_,v_) in E3
EH=E3-{(u_,v_)}
adj={i:set() for i in range(n3)}
for a,b in EH: adj[a].add(b); adj[b].add(a)
# triangle-free (a check of the given 23-vertex graph)
assert not any(adj[a]&adj[b] for a,b in EH), 'triangle'
# the explicit 4-colouring f of H = G3 - {21,22}: a proper 3-colouring of C5, copied to shadows; apexes and 21 get colour 3
g0=[0,1,0,1,2]
f=[g0[i] for i in range(5)]+[g0[i] for i in range(5)]+[3]      # Groetzsch: C5, shadows, apex 10 -> 3
f=f+[f[i] for i in range(10)]+[3]+[3]                          # shadows 11..20 copy 0..9, 21 (shadow of 10) -> 3, apex 22 -> 3
assert len(f)==23 and all(f[a]!=f[b] for a,b in EH), 'f not proper'
# the embedding: n_i = f(i) + 20 * 7^i  (balanced base-7 digits |c|<=3 are unique; 4*5 > 18 >= |sum c_i f(i)|)
N=[f[i]+20*7**i for i in range(n3)]
D=sorted({abs(N[a]-N[b]) for a,b in EH})
assert len(D)==len(EH)==70
Dset=set(D)
# sum-free: no d1+d2 = d3 (covers every triangle of Cay(Z, +-D))
assert not any(d1+d2 in Dset for d1 in D for d2 in D), 'D not sum-free'
# x mod 4 is a proper colouring of G(Z, D)
assert all(d%4 for d in D)
# H sits inside G(Z,D) at the points N_i: each edge of H is a difference in D
assert all(abs(N[a]-N[b]) in Dset for a,b in EH)
delta=N[v_]-N[u_]
import math
g=math.gcd(*D)
print('H: 23 vertices, 70 edges, triangle-free; f proper; D: 70 distances, sum-free, all nonzero mod 4; gcd(D) =',g)
print('max D = %d (%.3e); delta = n_22 - n_21 = %d (%.3e); delta/g = %d'%(max(D),max(D),delta,delta,delta//g))
print('delta in D?', delta in Dset, '; delta mod 4 =', delta%4)

"""Route 1: a triangle-free distance graph G(Z, D) with chi = 4 whose every proper 4-colouring is 4-periodic.
Every check here verifies a DERIVED claim on an explicit object; nothing searches for a colouring or a graph.
H = Mycielski(Grotzsch) minus the edge {A, y_g} (A the outer apex, g the Grotzsch apex, y_g its copy).
chi(Mycielski(G)) = chi(G) + 1 (Mycielski's theorem, hand), so every 4-colouring of H gives A and y_g one colour."""
import itertools, sys

def mycielski(n, edges):
    # vertices 0..n-1 originals, n..2n-1 copies (copy of i is n+i), 2n the apex
    E = set()
    for (a,b) in edges:
        E.add(frozenset((a,b))); E.add(frozenset((n+a,b))); E.add(frozenset((a,n+b)))
    for i in range(n): E.add(frozenset((n+i, 2*n)))
    return 2*n+1, E

C5 = [(i,(i+1)%5) for i in range(5)]
nG, EG = mycielski(5, C5)                    # Grotzsch: 11 vertices; its apex is 10
EGl = [tuple(sorted(e)) for e in EG]
nM, EM = mycielski(nG, EGl)                  # Mycielski(Grotzsch): 23 vertices; apex 22; copy of g=10 is 21
A, yg, g = 22, 21, 10
assert nG == 11 and len(EG) == 20 and nM == 23 and len(EM) == 71
EH = set(EM); EH.discard(frozenset((A, yg)))
assert len(EH) == 70

def triangle_free(n, E):
    adj = {v:set() for v in range(n)}
    for e in E:
        a,b = tuple(e); adj[a].add(b); adj[b].add(a)
    return all(not (adj[a] & adj[b]) for e in E for a,b in [tuple(e)])
assert triangle_free(nM, EM), 'Mycielski(Grotzsch) must be triangle-free'

# the 4-colouring t of H, by formula (hand-derived): 3-colour Grotzsch minus its apex g, copy colours, colour 3 on g, y_g, A.
# Grotzsch vertices: 0..4 = C5 (v_i), 5..9 = copies (u_i, u_i ~ v_{i-1}, v_{i+1}), 10 = apex g ~ all u_i.
c3 = {0:0, 1:1, 2:0, 3:1, 4:2,  5:0, 6:1, 7:0, 8:1, 9:2}   # u_i avoids colours of v_{i-1}, v_{i+1}
t = {}
for x in range(11):
    t[x] = c3[x] if x != g else 3
    t[nG + x] = c3[x] if x != g else 3
t[A] = 3
def proper(col, E): return all(col[a] != col[b] for e in E for a,b in [tuple(e)])
assert proper(t, EH), 't must be a proper 4-colouring of H'
assert not proper(t, EM), 'sanity: t does not colour the full Mycielskian (A and y_g share colour 3)'
assert t[A] == t[yg]

# lambda: mu(A) = 0, mu(y_g) = 1, the other 21 vertices get distinct powers 8^1..8^21; lambda = 4 mu + t
others = [v for v in range(nM) if v not in (A, yg)]
mu = {A: 0, yg: 1}
for k, v in enumerate(others, start=1): mu[v] = 8**k
lam = {v: 4*mu[v] + t[v] for v in range(nM)}
assert len(set(lam.values())) == nM
D = sorted({abs(lam[a]-lam[b]) for e in EH for a,b in [tuple(e)]})
S = set(D) | {-d for d in D}
print('|D| =', len(D), ' max D =', max(D), ' (~%.2e)' % max(D))
# (i) triangle-free: no s, t in S with s + t in S
bad = [(s,u) for s in S for u in S if s+u in S]
print('triangle-free (no s,t,s+t in S):', not bad)
# (ii) x -> x mod 4 is proper: no d = 0 mod 4
print('x mod 4 proper:', all(d % 4 for d in D), '  residues of D mod 4:', sorted({d % 4 for d in D}))
# (iii) a -> lambda_a embeds H: edges go to S
print('H embeds:', all((lam[a]-lam[b]) in S for e in EH for a,b in [tuple(e)]))
# (iv) the forced difference
print('lambda_{y_g} - lambda_A =', lam[yg]-lam[A], ' (not in S:', (lam[yg]-lam[A]) not in S, ')')
from math import gcd
from functools import reduce
print('gcd(D) =', reduce(gcd, D))
# (v) control: plant a triangle-closing value and watch (i) go red; plant a multiple of 4 and watch (ii) go red
S2 = S | {D[0]+D[1], -(D[0]+D[1])}
print('control (i) with D0+D1 added -> triangle found:', any(s+u in S2 for s in S2 for u in S2))
print('control (ii) with 4 added -> mod-4 colouring improper:', not all(d % 4 for d in D + [4]))

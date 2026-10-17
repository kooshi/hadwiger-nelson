"""FS131-ISF1 probe: the G27 certificate's DFS cost (mask tests) under vertex orders, and the graph's shape."""
import json, sys, itertools
from fractions import Fraction as Fr
d = json.load(open('data/fs56/g27/cert-g27-mrvz.json'))
P = d['points']; N = d['denominator']; n = len(P)
R = {0:1,1:3,2:11,3:33}
def mul(a, b):  # basis 1, √3, √11, √33
    a0,a1,a2,a3 = a; b0,b1,b2,b3 = b
    return (a0*b0+3*a1*b1+11*a2*b2+33*a3*b3, a0*b1+a1*b0+11*(a2*b3+a3*b2), a0*b2+a2*b0+3*(a1*b3+a3*b1), a0*b3+a3*b0+a1*b2+a2*b1)
def sub(a,b): return tuple(x-y for x,y in zip(a,b))
def add(a,b): return tuple(x+y for x,y in zip(a,b))
def sqd(p,q):
    dx = sub(p[0],q[0]); dy = sub(p[1],q[1])
    return add(mul(dx,dx), mul(dy,dy))
E = [(i,j) for i in range(n) for j in range(i+1,n) if sqd(P[i],P[j]) == (N*N,0,0,0)]
print('edges', len(E))
adj = [set() for _ in range(n)]
for i,j in E: adj[i].add(j); adj[j].add(i)
# connectivity
seen={0}; st=[0]
while st:
    v=st.pop()
    for u in adj[v]:
        if u not in seen: seen.add(u); st.append(u)
print('connected', len(seen)==n, 'degrees', sorted(len(a) for a in adj))
W = [(frozenset(w['set']), Fr(w['y'])) for w in d['weights']]
def cost(order):
    pos = {v:k for k,v in enumerate(order)}
    groups = [[] for _ in range(n)]
    for s,y in W:
        groups[max(pos[v] for v in s)].append(sum(1<<pos[v] for v in s))
    A = [0]*n
    for i,j in E: A[pos[i]] |= 1<<pos[j]; A[pos[j]] |= 1<<pos[i]
    tests = 0; nodes = 0
    perlevel=[0]*n
    def rec(k, S):
        nonlocal tests, nodes
        if k == n: nodes += 1; return
        rec(k+1, S)
        if A[k] & S == 0:
            tests_here = len(groups[k]); 
            tests += tests_here; perlevel[k]+=tests_here
            rec(k+1, S | (1<<k))
    rec(0, 0)
    return tests, nodes, [len(g) for g in groups], perlevel
t, nodes, gs, pl = cost(list(range(n)))
print('identity order: tests', t, 'leaves', nodes, 'groups', gs)
print('perlevel', pl)

def filt_cost(order):
    """the filtered-list DFS: each node partitions its live term list (terms whose decided part is inside S)"""
    pos = {v:k for k,v in enumerate(order)}
    terms = [sum(1<<pos[v] for v in s) for s,y in W]
    A = [0]*n
    for i,j in E: A[pos[i]] |= 1<<pos[j]; A[pos[j]] |= 1<<pos[i]
    tot = 0; nodes = 0
    def rec(k, S, L):
        nonlocal tot, nodes
        nodes += 1
        if k == n: return
        tot += len(L)
        bit = 1<<k
        Lout = [t for t in L if not t & bit]
        rec(k+1, S, Lout)
        if A[k] & S == 0:
            Lin = [t for t in L if (t >> k) != 1]  # drop the completed ones (max = k)
            rec(k+1, S | bit, Lin)
    rec(0, 0, terms)
    return tot, nodes
for name, order in [('identity', list(range(n))), ('reverse', list(range(n))[::-1]),
                    ('deg-desc', sorted(range(n), key=lambda v: -len(adj[v])))]:
    t, nodes, gs, pl = cost(order)
    ft, fn = filt_cost(order)
    print(name, 'scan tests', t, 'filtered work', ft, 'dfs nodes', fn)
# BFS orders from each start
best=None
for s0 in range(n):
    order=[s0]; seen={s0}; i=0
    while i < len(order):
        v=order[i]; i+=1
        for u in sorted(adj[v], key=lambda u: -len(adj[u])):
            if u not in seen: seen.add(u); order.append(u)
    t,_,_,_ = cost(order)
    if best is None or t < best[0]: best=(t,s0,order)
print('best BFS scan', best[0], 'start', best[1])
ft, fn = filt_cost(best[2]); print('  its filtered work', ft, 'nodes', fn)

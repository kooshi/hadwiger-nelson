"""FS131-ISF1 probe: the residual-list DFS cost (sum over nodes of the live list length), integer weights."""
import json, sys, math
from fractions import Fraction as Fr
d = json.load(open('data/fs56/g27/cert-g27-mrvz.json'))
P = d['points']; N = d['denominator']; n = len(P)
def mul(a, b):
    a0,a1,a2,a3 = a; b0,b1,b2,b3 = b
    return (a0*b0+3*a1*b1+11*a2*b2+33*a3*b3, a0*b1+a1*b0+11*(a2*b3+a3*b2), a0*b2+a2*b0+3*(a1*b3+a3*b1), a0*b3+a3*b0+a1*b2+a2*b1)
def sub(a,b): return tuple(x-y for x,y in zip(a,b))
def add(a,b): return tuple(x+y for x,y in zip(a,b))
def sqd(p,q):
    dx = sub(p[0],q[0]); dy = sub(p[1],q[1]); return add(mul(dx,dx), mul(dy,dy))
E = [(i,j) for i in range(n) for j in range(i+1,n) if sqd(P[i],P[j]) == (N*N,0,0,0)]
adj = [set() for _ in range(n)]
for i,j in E: adj[i].add(j); adj[j].add(i)
fr = [(w['set'], Fr(w['y'])) for w in d['weights']]
D = 1
for _, y in fr: D = D * y.denominator // math.gcd(D, y.denominator)
W = [(s, int(y * D)) for s, y in fr]
def run(order, merge=True, prune=False):
    pos = {v:k for k,v in enumerate(order)}
    A = [0]*n
    for i,j in E: A[pos[i]] |= 1<<pos[j]; A[pos[j]] |= 1<<pos[i]
    D0 = {}
    for s,y in W:
        m = sum(1<<pos[v] for v in s); D0[m] = D0.get(m,0)+y
    tot = 0; nodes = 0; worst = None; leaves = 0
    stack = [(0, 0, sorted(D0.items()), 0)]
    while stack:
        k, S, L, acc = stack.pop()
        nodes += 1; tot += len(L)
        if k == n:
            leaves += 1; v = acc + sum(c for _, c in L)
            worst = v if worst is None else max(worst, v); continue
        bit = 1 << k
        stack.append((k+1, S, [(t,c) for t,c in L if not t & bit], acc))
        if A[k] & S == 0:
            a2 = acc
            if merge:
                NL = {}
                for t,c in L:
                    if prune and (t & A[k]): continue
                    t2 = t & ~bit
                    if t2 == 0: a2 += c; continue
                    NL[t2] = NL.get(t2,0)+c
                NL = sorted(NL.items())
            else:
                NL = []
                for t,c in L:
                    if prune and (t & A[k]): continue
                    t2 = t & ~bit
                    if t2 == 0: a2 += c; continue
                    NL.append((t2,c))
            stack.append((k+1, S|bit, NL, a2))
    return tot, nodes, leaves, worst <= D
orders = {'identity': list(range(n)), 'reverse': list(range(n))[::-1],
          'deg-desc': sorted(range(n), key=lambda v: (-len(adj[v]), v))}
which = sys.argv[1:] or list(orders)
for name in which:
    for merge, prune in [(False,False),(True,False),(True,True)]:
        print(name, 'merge' if merge else '-', 'prune' if prune else '-', run(orders[name], merge, prune), flush=True)

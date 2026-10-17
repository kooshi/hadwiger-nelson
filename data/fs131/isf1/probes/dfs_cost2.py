"""FS131-ISF1 probe: residual-list DFS with merging (and optional neighbour pruning)."""
import json
from fractions import Fraction as Fr
exec(open('data/fs131/isf1/probes/dfs_cost.py').read().split("def cost(order)")[0])
def resid_cost(order, merge=True, prune=False):
    pos = {v:k for k,v in enumerate(order)}
    A = [0]*n
    for i,j in E: A[pos[i]] |= 1<<pos[j]; A[pos[j]] |= 1<<pos[i]
    D = {}
    for s,y in W:
        m = sum(1<<pos[v] for v in s); D[m] = D.get(m,0)+y
    L0 = sorted(D.items())
    tot = 0; nodes = 0; maxlen=0; leaves=0; worst=Fr(-10**9)
    def rec(k, S, L, acc):
        nonlocal tot, nodes, maxlen, leaves, worst
        nodes += 1
        tot += len(L); maxlen=max(maxlen,len(L))
        if k == n:
            leaves += 1
            assert all(t==0 for t,_ in L)
            v = acc + sum(c for _,c in L)
            worst = max(worst, v)
            return
        bit = 1<<k
        rec(k+1, S, [(t,c) for t,c in L if not t & bit], acc)
        if A[k] & S == 0:
            NL = {} if merge else []
            a2 = acc
            for t,c in L:
                if prune and (t & A[k]): continue
                t2 = t & ~bit
                if t2 == 0: a2 += c; continue
                if merge: NL[t2] = NL.get(t2,0)+c
                else: NL.append((t2,c))
            NL = sorted(NL.items()) if merge else NL
            rec(k+1, S|bit, NL, a2)
    rec(0,0,L0,Fr(0))
    return tot, nodes, maxlen, leaves, worst
orders = {'identity': list(range(n)), 'reverse': list(range(n))[::-1],
          'deg-desc': sorted(range(n), key=lambda v: -len(adj[v]))}
for name, order in orders.items():
    for merge, prune in [(False,False),(True,False),(True,True)]:
        print(name, 'merge' if merge else '', 'prune' if prune else '', resid_cost(order, merge, prune)[:4])
print('worst leaf value (should be <= 1):', float(resid_cost(orders['deg-desc'], True, True)[4]))

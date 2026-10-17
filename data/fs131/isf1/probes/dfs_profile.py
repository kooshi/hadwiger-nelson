"""FS131-ISF1 probe: per-depth profile of the residual DFS (nodes, sum of list lengths) for one order."""
import sys
exec(open('data/fs131/isf1/probes/dfs_cost3.py').read().split("def run(order")[0])
def profile(order, merge=True, prune=True):
    pos = {v:k for k,v in enumerate(order)}
    A = [0]*n
    for i,j in E: A[pos[i]] |= 1<<pos[j]; A[pos[j]] |= 1<<pos[i]
    D0 = {}
    for s,y in W:
        m = sum(1<<pos[v] for v in s); D0[m] = D0.get(m,0)+y
    nodes=[0]*(n+1); tot=[0]*(n+1); mx=[0]*(n+1)
    stack = [(0, 0, sorted(D0.items()))]
    while stack:
        k, S, L = stack.pop()
        nodes[k]+=1; tot[k]+=len(L); mx[k]=max(mx[k],len(L))
        if k == n: continue
        bit = 1 << k
        stack.append((k+1, S, [(t,c) for t,c in L if not t & bit]))
        if A[k] & S == 0:
            if merge:
                NL = {}
                for t,c in L:
                    if prune and (t & A[k]): continue
                    t2 = t & ~bit
                    NL[t2] = NL.get(t2,0)+c
                NL = sorted(NL.items())
            else:
                NL = [(t & ~bit, c) for t,c in L if not (prune and (t & A[k]))]
            stack.append((k+1, S|bit, NL))
    return nodes, tot, mx
order = sorted(range(n), key=lambda v: (-len(adj[v]), v))
merge = sys.argv[1] == 'merge'
nodes, tot, mx = profile(order, merge, True)
print('order', order)
cum = 0
for k in range(n+1):
    cum += tot[k]
    print(k, 'nodes', nodes[k], 'sumL', tot[k], 'maxL', mx[k], 'cum', cum, flush=True)

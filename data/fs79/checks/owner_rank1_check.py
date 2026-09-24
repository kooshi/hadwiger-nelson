# Owner's independent check (not Poros's script): for G(Z, D), k colours, build the de Bruijn-style transfer graph on
# windows of length m = max D (states: proper colourings of a length-m window; edges: shift by one with a new colour that
# differs from the colours at distances in D). Colourings of Z = bi-infinite walks. Periodic colourings = cycles.
# A pattern occurring in some colouring but in no periodic one exists iff some bi-infinite walk uses an edge between two
# distinct SCCs (both endpoints' SCCs must lie on bi-infinite paths: the source SCC reachable backward from a cycle... here:
# an edge u->v with u in a nontrivial SCC-closure that can be reached from a cycle and v can reach a cycle, and scc(u)!=scc(v)).
import sys, itertools
from collections import defaultdict
sys.setrecursionlimit(10**7)
def analyse(D, k):
    m = max(D); D = sorted(D)
    # states: tuples of length m (positions 0..m-1), proper w.r.t. D inside the window
    def ok_window(w):
        for i in range(len(w)):
            for d in D:
                if i + d < len(w) and w[i] == w[i+d]: return False
        return True
    # build by extension, canonical: fix nothing (need full graph)
    states = [()]
    for L in range(m):
        new = []
        for w in states:
            for c in range(k):
                w2 = w + (c,)
                if all(w2[-1-d] != c for d in D if d <= len(w2)-1):
                    new.append(w2)
        states = new
    idx = {s:i for i,s in enumerate(states)}
    adj = [[] for _ in states]
    for s,i in idx.items():
        for c in range(k):
            t = s + (c,)
            if all(t[-1-d] != c for d in D):   # distances d <= m
                adj[i].append(idx[t[1:]])
    n = len(states)
    # Tarjan SCC (iterative)
    index=[-1]*n; low=[0]*n; onst=[False]*n; st=[]; comp=[-1]*n; ci=0; cnt=0
    for s0 in range(n):
        if index[s0]!=-1: continue
        stack=[(s0,0)]; index[s0]=low[s0]=cnt; cnt+=1; st.append(s0); onst[s0]=True
        while stack:
            v,pi=stack[-1]
            if pi<len(adj[v]):
                stack[-1]=(v,pi+1); w=adj[v][pi]
                if index[w]==-1:
                    index[w]=low[w]=cnt; cnt+=1; st.append(w); onst[w]=True; stack.append((w,0))
                elif onst[w]: low[v]=min(low[v],index[w])
            else:
                stack.pop()
                if stack: u=stack[-1][0]; low[u]=min(low[u],low[v])
                if low[v]==index[v]:
                    while True:
                        w=st.pop(); onst[w]=False; comp[w]=ci
                        if w==v: break
                    ci+=1
    size=defaultdict(int)
    for v in range(n): size[comp[v]]+=1
    nontriv=set(c for c in size if size[c]>1) | set(comp[v] for v in range(n) if v in adj[v])
    # forward-reach-a-cycle and backward-reach-a-cycle
    radj=[[] for _ in range(n)]
    for v in range(n):
        for w in adj[v]: radj[w].append(v)
    def reach(start, g):
        seen=[False]*n; q=[v for v in range(n) if comp[v] in start]
        for v in q: seen[v]=True
        while q:
            v=q.pop()
            for w in g[v]:
                if not seen[w]: seen[w]=True; q.append(w)
        return seen
    fwd_to_cycle = reach(nontriv, radj)   # v can reach a cycle  <=> v backward-reachable from cycle states
    from_cycle   = reach(nontriv, adj)    # v reachable from a cycle
    trans = 0
    for v in range(n):
        if not from_cycle[v]: continue
        for w in adj[v]:
            if fwd_to_cycle[w] and comp[v]!=comp[w]: trans+=1
    return n, len(nontriv), trans
for D,k in [((1,5,7,10),4), ((3,5,9,10),4), ((1,2,4,8),4), ((1,3,4,5),4), ((1,5,7,10),3), ((1,4),3)]:
    n, nc, tr = analyse(D,k)
    print(D, 'k=',k, 'states',n, 'nontrivial SCCs',nc, 'transient edges on bi-infinite walks', tr)

# Rank-1 check: is the periodic-point set dense in X_4(D) = Hom(Cay(Z,D),K4)?
# 1-D SFT; states = proper colourings of a window of length L = max D (canonical up to colour permutation).
# Density fails iff the essential state graph has an edge between two distinct SCCs.
import sys, itertools
sys.setrecursionlimit(1000000)
def canon(w):
    m={}; out=[]
    for c in w:
        if c not in m: m[c]=len(m)
        out.append(m[c])
    return tuple(out)
def analyse(D,k=4):
    L=max(D)
    # enumerate canonical proper windows of length L by DFS
    states=[]
    def dfs(w):
        if len(w)==L: states.append(tuple(w)); return
        used=max(w)+1 if w else 0
        for c in range(min(k,used+1)):
            i=len(w)
            if all(not(i-d>=0 and w[i-d]==c) for d in D):
                w.append(c); dfs(w); w.pop()
    dfs([])
    idx={s:i for i,s in enumerate(states)}
    succ=[[] for _ in states]
    for i,s in enumerate(states):
        for c in range(k):
            if all(s[L-d]!=c for d in D):   # new position L; differences d with L-d>=0
                t=canon(s[1:]+(c,))
                succ[i].append(idx[t])
    pred=[[] for _ in states]
    for i in range(len(states)):
        for j in succ[i]: pred[j].append(i)
    # prune to essential (infinite future and past)
    alive=[True]*len(states)
    outdeg=[len(set(x)) for x in succ]; indeg=[0]*len(states)
    for i in range(len(states)):
        for j in set(succ[i]): indeg[j]+=1
    from collections import deque
    q=deque([i for i in range(len(states)) if outdeg[i]==0 or indeg[i]==0])
    while q:
        i=q.popleft()
        if not alive[i]: continue
        alive[i]=False
        for j in set(succ[i]):
            if alive[j]:
                indeg[j]-=1
                if indeg[j]==0: q.append(j)
        for j in set(pred[i]):
            if alive[j]:
                outdeg[j]-=1
                if outdeg[j]==0: q.append(j)
    V=[i for i in range(len(states)) if alive[i]]
    if not V: return dict(D=D,states=len(states),essential=0)
    # Tarjan SCC (iterative)
    index={}; low={}; onst=set(); st=[]; comp={}; cidx=0; counter=0
    for v0 in V:
        if v0 in index: continue
        work=[(v0,iter([j for j in succ[v0] if alive[j]]))]
        index[v0]=low[v0]=counter; counter+=1; st.append(v0); onst.add(v0)
        while work:
            v,it=work[-1]
            adv=False
            for w in it:
                if w not in index:
                    index[w]=low[w]=counter; counter+=1; st.append(w); onst.add(w)
                    work.append((w,iter([j for j in succ[w] if alive[j]]))); adv=True; break
                elif w in onst: low[v]=min(low[v],index[w])
            if adv: continue
            work.pop()
            if work: low[work[-1][0]]=min(low[work[-1][0]],low[v])
            if low[v]==index[v]:
                while True:
                    w=st.pop(); onst.discard(w); comp[w]=cidx
                    if w==v: break
                cidx+=1
    cross=sum(1 for v in V for w in succ[v] if alive[w] and comp[v]!=comp[w])
    sizes={}
    for v in V: sizes[comp[v]]=sizes.get(comp[v],0)+1
    nontriv=[c for c,s in sizes.items() if s>1 or any(comp.get(w)==c and w==v for v in V if comp[v]==c for w in succ[v])]
    return dict(D=D,states=len(states),essential=len(V),sccs=len(sizes),cyclic_sccs=len(nontriv),cross_edges=cross)
if __name__=="__main__":
    for arg in sys.argv[1:]:
        D=tuple(int(x) for x in arg.split(','))
        print(analyse(D))

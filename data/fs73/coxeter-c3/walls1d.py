# Rank-1 laboratory: G(Z,D) at k colours as a 1-D SFT. Compare P (forced by every periodic colouring) with F (forced by every colouring).
import itertools, sys, math
sys.setrecursionlimit(1000000)
def analyse(D, k, dmax):
    m = max(D)
    words = []
    def rec(w):
        if len(w) == m: words.append(tuple(w)); return
        for c in range(k):
            if all(c != w[len(w)-d] for d in D if d <= len(w)):
                w.append(c); rec(w); w.pop()
    rec([])
    idx = {w:i for i,w in enumerate(words)}
    n = len(words)
    adj = [[] for _ in range(n)]
    for i,w in enumerate(words):
        for c in range(k):
            if all(c != w[m-d] for d in D):
                adj[i].append(idx[w[1:]+(c,)])
    # Tarjan SCC (iterative)
    index = [None]*n; low=[0]*n; onst=[False]*n; st=[]; comp=[-1]*n; ncomp=0; cnt=0
    for s in range(n):
        if index[s] is not None: continue
        work=[(s,0)]; index[s]=low[s]=cnt; cnt+=1; st.append(s); onst[s]=True
        while work:
            v,j=work[-1]
            if j<len(adj[v]):
                work[-1]=(v,j+1); u=adj[v][j]
                if index[u] is None:
                    index[u]=low[u]=cnt; cnt+=1; st.append(u); onst[u]=True; work.append((u,0))
                elif onst[u]: low[v]=min(low[v],index[u])
            else:
                work.pop()
                if work: low[work[-1][0]]=min(low[work[-1][0]],low[v])
                if low[v]==index[v]:
                    while True:
                        x=st.pop(); onst[x]=False; comp[x]=ncomp
                        if x==v: break
                    ncomp+=1
    size=[0]*ncomp
    for v in range(n): size[comp[v]]+=1
    nontriv=[False]*ncomp
    for v in range(n):
        if size[comp[v]]>1 or v in adj[v]: nontriv[comp[v]]=True
    # core: reachable from a nontrivial SCC and reaching one
    fwd=[False]*n; stack=[v for v in range(n) if nontriv[comp[v]]]
    for v in stack: fwd[v]=True
    while stack:
        v=stack.pop()
        for u in adj[v]:
            if not fwd[u]: fwd[u]=True; stack.append(u)
    radj=[[] for _ in range(n)]
    for v in range(n):
        for u in adj[v]: radj[u].append(v)
    bwd=[False]*n; stack=[v for v in range(n) if nontriv[comp[v]]]
    for v in stack: bwd[v]=True
    while stack:
        v=stack.pop()
        for u in radj[v]:
            if not bwd[u]: bwd[u]=True; stack.append(u)
    core=[fwd[v] and bwd[v] for v in range(n)]
    def separated(allowed_pred, dm):
        # returns set of delta in 1..dm separated by some walk inside allowed states
        sep=set()
        for j in range(k):
            cur={v for v in range(n) if allowed_pred(v, v) and words[v][0]==j}
            # walks must stay in same allowed class: allowed_pred(start, v)
            layer={(v,v) for v in cur}
            # track start component only via predicate
            curset=cur
            for dlt in range(1,dm+1):
                nxt=set()
                for v in curset:
                    for u in adj[v]:
                        if allowed_pred(None,u) and (u not in nxt): nxt.add(u)
                curset=nxt
                if any(words[u][0]!=j for u in curset): sep.add(dlt)
        return sep
    # periodic: within each nontrivial SCC separately
    sepP=set()
    for cidx in range(ncomp):
        if not nontriv[cidx]: continue
        pred=lambda s,u,c=cidx: comp[u]==c
        sepP |= separated(pred, dmax)
    sepF = separated(lambda s,u: core[u], dmax)
    return n, sum(nontriv), sepP, sepF
if __name__=="__main__":
    k=int(sys.argv[1]); M=int(sys.argv[2]); dmax=int(sys.argv[3])
    found=0
    for size in range(2, M+1):
        for D in itertools.combinations(range(1,M+1), size):
            if math.gcd(*D)!=1: continue
            n,nt,sP,sF=analyse(D,k,dmax)
            if nt==0: continue
            forcedP=[d for d in range(1,dmax+1) if d not in sP]
            forcedF=[d for d in range(1,dmax+1) if d not in sF]
            if forcedP!=forcedF:
                found+=1; print("GAP D=",D,"states",n,"SCCs",nt,"P-forced",forcedP[:10],"F-forced",forcedF[:10])
    print("done; gaps:",found)

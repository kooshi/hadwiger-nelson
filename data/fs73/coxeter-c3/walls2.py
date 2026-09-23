# Count distance sets whose 4-colouring shift has one-way walls (core edges between distinct recurrent classes, or transient core states)
import itertools, math, sys
sys.setrecursionlimit(10**6)
from walls1d import analyse
def structure(D, k):
    m=max(D); words=[]
    def rec(w):
        if len(w)==m: words.append(tuple(w)); return
        for c in range(k):
            if all(c!=w[len(w)-d] for d in D if d<=len(w)): w.append(c); rec(w); w.pop()
    rec([])
    idx={w:i for i,w in enumerate(words)}; n=len(words)
    adj=[[idx[w[1:]+(c,)] for c in range(k) if all(c!=w[m-d] for d in D)] for w in words]
    import sys
    index=[None]*n; low=[0]*n; onst=[False]*n; st=[]; comp=[-1]*n; nc=0; cnt=0
    for s in range(n):
        if index[s] is not None: continue
        work=[(s,0)]; index[s]=low[s]=cnt; cnt+=1; st.append(s); onst[s]=True
        while work:
            v,j=work[-1]
            if j<len(adj[v]):
                work[-1]=(v,j+1); u=adj[v][j]
                if index[u] is None: index[u]=low[u]=cnt; cnt+=1; st.append(u); onst[u]=True; work.append((u,0))
                elif onst[u]: low[v]=min(low[v],index[u])
            else:
                work.pop()
                if work: low[work[-1][0]]=min(low[work[-1][0]],low[v])
                if low[v]==index[v]:
                    while True:
                        x=st.pop(); onst[x]=False; comp[x]=nc
                        if x==v: break
                    nc+=1
    size=[0]*nc
    for v in range(n): size[comp[v]]+=1
    nt=[False]*nc
    for v in range(n):
        if size[comp[v]]>1 or v in adj[v]: nt[comp[v]]=True
    # core
    def closure(start, g):
        seen=[False]*n; stack=list(start)
        for v in stack: seen[v]=True
        while stack:
            v=stack.pop()
            for u in g[v]:
                if not seen[u]: seen[u]=True; stack.append(u)
        return seen
    rec_states=[v for v in range(n) if nt[comp[v]]]
    fwd=closure(rec_states, adj)
    radj=[[] for _ in range(n)]
    for v in range(n):
        for u in adj[v]: radj[u].append(v)
    bwd=closure(rec_states, radj)
    core=[fwd[v] and bwd[v] for v in range(n)]
    transient=sum(1 for v in range(n) if core[v] and not nt[comp[v]])
    cross=sum(1 for v in range(n) if core[v] for u in adj[v] if core[u] and comp[u]!=comp[v])
    return sum(nt), transient, cross
if __name__=="__main__":
    k=int(sys.argv[1]); M=int(sys.argv[2])
    for size in range(2,M+1):
        for D in itertools.combinations(range(1,M+1),size):
            if math.gcd(*D)!=1 or max(D)!=M: continue
            ncomp,tr,cr=structure(D,k)
            if ncomp and (tr or cr): print(D,"recurrent classes",ncomp,"transient core states",tr,"cross edges",cr, flush=True)
    print("done M=",M)

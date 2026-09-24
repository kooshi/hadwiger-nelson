# Independent check (planner's own code) of Poros's claim: in rank 1 at k colours, a pattern occurs in no periodic colouring
# iff it lies on an edge between different strongly connected components of the window-state graph restricted to essential states.
import sys, numpy as np
from scipy.sparse import csr_matrix
from scipy.sparse.csgraph import connected_components
def canon(w):
    m={}; return tuple(m.setdefault(c,len(m)) for c in w)
def analyse(D,k):
    L=max(D)
    states={}; order=[]
    def ok(w):  # w proper on its own window
        n=len(w)
        return all(w[i]!=w[i+d] for d in D for i in range(n-d))
    # enumerate canonical proper words of length L by DFS
    stack=[()]
    while stack:
        w=stack.pop()
        if len(w)==L:
            states[w]=len(order); order.append(w); continue
        mx=max(w)+1 if w else 0
        for c in range(min(k,mx+1)):
            x=w+(c,)
            if all(x[-1]!=x[-1-d] for d in D if d<len(x)):
                stack.append(x)
    rows=[];cols=[]
    for w,i in states.items():
        for c in range(k):
            x=w+(c,)
            if all(x[-1]!=x[-1-d] for d in D if d<=L):
                j=states[canon(x[1:])]; rows.append(i); cols.append(j)
    n=len(order); A=csr_matrix((np.ones(len(rows)),(rows,cols)),shape=(n,n))
    # essential states: iterate removing states with no in- or out-edge
    alive=np.ones(n,bool)
    while True:
        B=A[alive][:,alive]
        outd=np.asarray(B.sum(1)).ravel(); ind=np.asarray(B.sum(0)).ravel()
        idx=np.where(alive)[0]; bad=idx[(outd==0)|(ind==0)]
        if len(bad)==0: break
        alive[bad]=False
    idx=np.where(alive)[0]
    if len(idx)==0: return 'not colourable',0
    B=A[alive][:,alive].tocoo()
    nc,lab=connected_components(A[alive][:,alive],directed=True,connection='strong')
    cross=int(sum(1 for a,b in zip(B.row,B.col) if lab[a]!=lab[b]))
    return f'essential={len(idx)} scc={nc}', cross
for D in ([1,5,7,10],[3,5,9,10],[3,7,9,10],[5,7,9,10],[1,3,4,5],[1,2,4,8],[2,3,5,9]):
    print(D, 'k=4', analyse(D,4))
for D in ([1,4],[1,2,4,8],[2,3,5,9]):
    print(D, 'k=3', analyse(D,3))

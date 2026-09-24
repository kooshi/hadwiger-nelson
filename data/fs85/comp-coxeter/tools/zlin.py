"""small exact integer lattice tools (row HNF, index) -- Coxeter FS-85"""
import math
def hnf(rows):
    rows=[list(r) for r in rows if any(r)]
    if not rows: return []
    n=len(rows[0]); out=[]; col=0
    while rows and col<n:
        nz=[r for r in rows if r[col]!=0]
        if not nz: col+=1; continue
        while True:
            nz=[r for r in rows if r[col]!=0]
            if len(nz)<=1: break
            p=min(nz,key=lambda r:abs(r[col]))
            for r in nz:
                if r is not p:
                    q=r[col]//p[col]
                    for i in range(n): r[i]-=q*p[i]
        p=[r for r in rows if r[col]!=0][0]
        if p[col]<0:
            for i in range(n): p[i]=-p[i]
        rows=[r for r in rows if r is not p and any(r)]
        out.append(p); col+=1
    # reduce above pivots
    for i,r in enumerate(out):
        pc=next(j for j in range(n) if r[j]!=0)
        for s in out[:i]:
            q=s[pc]//r[pc]
            for j in range(n): s[j]-=q*r[j]
    return out
def pivots(H): return [next(j for j in range(len(r)) if r[j]!=0) for r in H]
def index_full(rows,n):
    H=hnf(rows)
    if len(H)<n: return 0
    return math.prod(r[p] for r,p in zip(H,pivots(H)))
def in_span(v,rows):
    """is v in the Z-span of rows?"""
    H=hnf(rows); v=list(v); n=len(v)
    for r,p in zip(H,pivots(H)):
        if v[p]%r[p]!=0: return False
        q=v[p]//r[p]
        for j in range(n): v[j]-=q*r[j]
    return not any(v)

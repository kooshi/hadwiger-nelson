# Independent re-derivation (Poros, P3) of Coxeter's parity-free cube lemma, the input to C4's gluing.
# Face-local 2-forms on the 3-cube, values depending only on a face's four colours (parity-free), 4 colours.
import itertools, sys
K=4
P=[2**31-1, 2**61-1]
V=list(itertools.product((0,1),repeat=3))
idx={v:n for n,v in enumerate(V)}
def add(v,m): w=list(v); w[m]^=1; return tuple(w)
edges=[(v,add(v,m)) for v in V for m in range(3) if v[m]==0]
cols=[c for c in itertools.product(range(K),repeat=8) if all(c[idx[a]]!=c[idx[b]] for a,b in edges)]
assert len(cols)==2652, len(cols)
# monopoles: every vertex coloured like its antipode
anti=lambda v: tuple(1-x for x in v)
mono=[c for c in cols if all(c[idx[v]]==c[idx[anti(v)]] for v in V)]
print("proper cube colourings", len(cols), "monopoles", len(mono))
sq=[p for p in itertools.product(range(K),repeat=4) if p[0]!=p[1] and p[1]!=p[2] and p[2]!=p[3] and p[3]!=p[0]]
assert len(sq)==84
sqi={p:n for n,p in enumerate(sq)}
pairs=[(0,1),(0,2),(1,2)]
def face_pattern(c, i, j, base):
    x=base; a=c[idx[x]]; b=c[idx[add(x,i)]]; cc=c[idx[add(add(x,i),j)]]; d=c[idx[add(x,j)]]
    return (a,b,cc,d)
# boundary of the cube: sum_m (-1)^m [F_m^1 - F_m^0], F_m spanned by the other two coords in increasing order
def cube_row(c):
    row={}
    for m in range(3):
        i,j=[q for q in range(3) if q!=m]
        pi=pairs.index((i,j))
        sgn=(-1)**m
        for t,s2 in ((1,1),(0,-1)):
            base=tuple(t if q==m else 0 for q in range(3))
            key=(pi,sqi[face_pattern(c,i,j,base)])
            row[key]=row.get(key,0)+sgn*s2
    return row
nunk=3*84
def col_of(key): return key[0]*84+key[1]
def rank_mod(rows, ncols, p):
    # rows: list of dict col->int
    piv={}
    r=0
    for rw in rows:
        v={col_of(k) if isinstance(k,tuple) else k:(val%p) for k,val in rw.items() if val%p}
        # reduce
        while v:
            lead=min(v)
            if lead in piv:
                prow=piv[lead]; f=v[lead]
                for kk,vv in prow.items():
                    v[kk]=(v.get(kk,0)-f*vv)%p
                    if v[kk]==0: del v[kk]
            else:
                inv=pow(v[lead],p-2,p)
                v={kk:(vv*inv)%p for kk,vv in v.items()}
                piv[lead]=v; r+=1; break
    return r
# exact forms: images of eta (3 directions x 12 ordered pairs) and kappa (3)
ordp=[(a,b) for a in range(K) for b in range(K) if a!=b]
def d_eta_vector(direction, ab):
    vec={}
    for pi,(i,j) in enumerate(pairs):
        for p in sq:
            c0,c1,c2,c3=p; val=0
            if direction==i:
                val+= (1 if (c0,c1)==ab else 0) - (1 if (c3,c2)==ab else 0)
            if direction==j:
                val+= (1 if (c1,c2)==ab else 0) - (1 if (c0,c3)==ab else 0)
            if val: vec[pi*84+sqi[p]]=val
    return vec
gens=[d_eta_vector(dr,ab) for dr in range(3) for ab in ordp]
gens+=[{pi*84+sqi[p]:1 for p in sq} for pi in range(3)]
# control: every exact form is closed (d o d = 0)
def dot(row, vec): return sum(val*vec.get(col_of(k),0) for k,val in row.items())
rows_all=[cube_row(c) for c in cols]
bad=sum(1 for g in gens for rw in rows_all if dot(rw,g)!=0)
print("control d(d eta + kappa) != 0 count:", bad)
monoset=set(mono)
rows_nomono=[cube_row(c) for c in cols if c not in monoset]
for p in P:
    rz_all=rank_mod(rows_all,nunk,p); rz_nm=rank_mod(rows_nomono,nunk,p)
    rb=rank_mod([{k:v for k,v in g.items()} for g in gens],nunk,p)
    print(f"p={p}: closed dim (all cubes) = {nunk-rz_all}, closed dim (no monopoles) = {nunk-rz_nm}, exact dim = {rb}, H2 all = {nunk-rz_all-rb}, H2 no-mono = {nunk-rz_nm-rb}")

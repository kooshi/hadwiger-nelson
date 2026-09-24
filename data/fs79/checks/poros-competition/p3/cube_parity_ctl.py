# Positive control for cube_parityfree.py: the same instrument with sheet (parity) dependence must show H2 = 0 with monopoles, 1 without.
exec(open('cube_parityfree.py').read().split('# exact forms')[0])
NU=3*84*2
def col(pi,pat,par): return (pi*84+sqi[pat])*2+par
def cube_row_par(c,beta):
    row={}
    for m in range(3):
        i,j=[q for q in range(3) if q!=m]; pi=pairs.index((i,j)); sgn=(-1)**m
        for t,s2 in ((1,1),(0,-1)):
            base=tuple(t if q==m else 0 for q in range(3))
            k=col(pi,face_pattern(c,i,j,base),(beta+t)%2)
            row[k]=row.get(k,0)+sgn*s2
    return row
def rank_int_keys(rows,p):
    piv={}; r=0
    for rw in rows:
        v={k:val%p for k,val in rw.items() if val%p}
        while v:
            lead=min(v)
            if lead in piv:
                prow=piv[lead]; f=v[lead]
                for kk,vv in prow.items():
                    v[kk]=(v.get(kk,0)-f*vv)%p
                    if v[kk]==0: del v[kk]
            else:
                inv=pow(v[lead],p-2,p); v={kk:(vv*inv)%p for kk,vv in v.items()}; piv[lead]=v; r+=1; break
    return r
ordp=[(a,b) for a in range(K) for b in range(K) if a!=b]
gens=[]
for dr in range(3):
    for ab in ordp:
        for epar in (0,1):
            vec={}
            for pi,(i,j) in enumerate(pairs):
                for pat in sq:
                    c0,c1,c2,c3=pat
                    for par in (0,1):
                        val=0
                        if dr==i:
                            val+=(1 if ((c0,c1)==ab and par==epar) else 0)-(1 if ((c3,c2)==ab and (par+1)%2==epar) else 0)
                        if dr==j:
                            val+=(1 if ((c1,c2)==ab and (par+1)%2==epar) else 0)-(1 if ((c0,c3)==ab and par==epar) else 0)
                        if val: vec[col(pi,pat,par)]=val
            gens.append(vec)
for pi in range(3):
    gens.append({col(pi,pat,par):1 for pat in sq for par in (0,1)})
rows_all=[cube_row_par(c,b) for c in cols for b in (0,1)]
ms=set(mono)
rows_nm=[cube_row_par(c,b) for c in cols if c not in ms for b in (0,1)]
bad=sum(1 for g in gens for rw in rows_all if sum(v*g.get(k,0) for k,v in rw.items())!=0)
print("control d(d eta) != 0 on 400 rows:", bad)
p=2**31-1
za=NU-rank_int_keys(rows_all,p); zn=NU-rank_int_keys(rows_nm,p); b=rank_int_keys(gens,p)
print(f"parity-dependent: closed(all)={za} closed(no mono)={zn} exact={b} H2 all={za-b} H2 no-mono={zn-b}")

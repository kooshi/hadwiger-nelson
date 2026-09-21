import sys, json
p=int(sys.argv[1]); k=int(sys.argv[2]); sol=sys.argv[3]; out=sys.argv[4]
n=p*p; NV=n*n*k
pos=set()
for ln in open(sol):
    if ln.startswith('v '):
        for t in ln.split()[1:]:
            i=int(t)
            if 0<i<=NV: pos.add(i)
col=[]
for v in range(n*n):
    cs=[c for c in range(k) if v*k+c+1 in pos]
    assert cs, v
    col.append(cs[0])
json.dump({"n":n,"k":k,"colours":col},open(out,'w'))
print("decoded",len(col),"vertices")

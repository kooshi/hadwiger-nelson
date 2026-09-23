# Rank-1, 4 colours, triangle chains: D = {1,2,M} + up to `extra` more distances. Walls, then P/F for walled sets.
import sys, os, json, itertools, math, time
from walls2 import structure
from walls1d import analyse
Mlo,Mhi,extra,out,tcap=int(sys.argv[1]),int(sys.argv[2]),int(sys.argv[3]),sys.argv[4],float(sys.argv[5])
done=set()
if os.path.exists(out):
    for line in open(out):
        if line.startswith('{'): done.add(tuple(json.loads(line)['D']))
t0=time.time()
with open(out,'a') as f:
    for M in range(Mlo,Mhi+1):
        for e in range(0,extra+1):
            for mid in itertools.combinations(range(3,M),e):
                D=tuple(sorted({1,2,M}|set(mid)))
                if D in done: continue
                if time.time()-t0>tcap: f.write("CAP reached\n"); f.flush(); sys.exit(0)
                nc,tr,cr=structure(D,4)
                rec={"D":list(D),"recurrent":nc,"transient":tr,"cross":cr}
                if nc and (tr or cr):
                    n,nt,sP,sF=analyse(D,4,3*M)
                    rec["P_forced"]=[d for d in range(1,3*M+1) if d not in sP]
                    rec["F_forced"]=[d for d in range(1,3*M+1) if d not in sF]
                    rec["GAP"]=rec["P_forced"]!=rec["F_forced"]
                f.write(json.dumps(rec)+"\n"); f.flush()
    f.write("DONE\n"); f.flush()

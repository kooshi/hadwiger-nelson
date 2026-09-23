# Rank-1, k colours: for each D with max(D)=M, report walls (cross edges / transient core states); for walled D compute
# P-forced and F-forced deltas up to dmax. Resumable: skips D already recorded in the output file. Always writes a DONE line.
import sys, os, json, itertools, math, time
from walls2 import structure
from walls1d import analyse
k=int(sys.argv[1]); Ms=list(map(int,sys.argv[2].split(','))); out=sys.argv[3]; tcap=float(sys.argv[4])
done=set()
if os.path.exists(out):
    for line in open(out):
        if line.startswith('{'): done.add(tuple(json.loads(line)['D']))
t0=time.time()
with open(out,'a') as f:
    for M in Ms:
        for size in range(2,M+1):
            for D in itertools.combinations(range(1,M+1),size):
                if math.gcd(*D)!=1 or max(D)!=M or D in done: continue
                if time.time()-t0>tcap: f.write("CAP reached\n"); f.flush(); sys.exit(0)
                nc,tr,cr=structure(D,k)
                rec={"D":list(D),"k":k,"recurrent":nc,"transient":tr,"cross":cr}
                if nc and (tr or cr):
                    n,nt,sP,sF=analyse(D,k,3*M)
                    rec["P_forced"]=[d for d in range(1,3*M+1) if d not in sP]
                    rec["F_forced"]=[d for d in range(1,3*M+1) if d not in sF]
                f.write(json.dumps(rec)+"\n"); f.flush()
    f.write("DONE %s\n" % Ms); f.flush()

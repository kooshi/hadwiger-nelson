import itertools, sys
from rank1_density import analyse
from rank1_bench import k4free
def sumfree(D):
    s=set(D); return not any(a+b in s for a in D for b in D)
k=int(sys.argv[1]); m=int(sys.argv[2]); maxsize=int(sys.argv[3])
tot=0; colourable=0; fails=[]
for r in range(2,maxsize+1):
    for D in itertools.combinations(range(1,m+1),r):
        if D[-1]!=m and m>0 and False: pass
        res=analyse(D,k); tot+=1
        if res['essential']>0:
            colourable+=1
            if res['cross_edges']>0: fails.append((D,res['cross_edges'],k4free(D),sumfree(D)))
print(f"k={k} D subset of 1..{m}, |D| 2..{maxsize}: {tot} sets, {colourable} {k}-colourable, {len(fails)} with transient (non-periodic) patterns")
for f in fails[:12]: print("  D=",f[0],"cross",f[1],"K4-free",f[2],"triangle-free",f[3])
print("  K4-free fails:",sum(1 for f in fails if f[2]),"; triangle-free fails:",sum(1 for f in fails if f[3]))
tf=[f for f in fails if f[3]]
for f in tf[:5]: print("  TF:",f)

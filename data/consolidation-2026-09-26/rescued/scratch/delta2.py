import sys
sys.path.insert(0,'tools')
import crunch_j18_phases as T
A=T.analyse([1,5,7,10])
rig={i for i,p in A['phases'].items() if p['rigid']}
rr=[(i,j) for i,j in A['walls'] if i in rig and j in rig]
for (i,j) in rr:
    seq,jn=T.wall_point(A,i,j)
    n=len(seq); M=100
    Delta={d for x in range(n) for d in range(1,M+1) if x+d<n and seq[x]==seq[x+d]}
    print((i,j),'D_c(100)=',[d for d in range(1,M+1) if d not in Delta], 'junction word', ''.join(map(str,seq[jn-25:jn+25])))

import sys; sys.path.insert(0,'tools')
import crunch_j18_phases as T
D=[1,5,7,10]
A=T.analyse(D)
for (i,j) in [(65,55),(65,23),(67,23),(81,49)]:
    seq,jn=T.wall_point(A,i,j)
    # locate departure: first x where seq deviates from its left periodic pattern (period 20)
    P=20
    dep=next(x for x in range(jn-200,len(seq)) if seq[x]!=seq[x-P])
    # arrival: last x where seq deviates from right periodic
    arr=max(x for x in range(0,len(seq)-P) if seq[x]!=seq[x+P])
    print((i,j),'dep',dep-jn,'arr',arr-jn,'len',len(seq),'jn',jn)
    print(' ', ''.join(map(str,seq[dep-40:dep])),'|',''.join(map(str,seq[dep:arr+1])),'|',''.join(map(str,seq[arr+1:arr+41])))

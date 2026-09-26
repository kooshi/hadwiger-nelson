import sys
sys.path.insert(0,'tools')
import crunch_j18_phases as T
A=T.analyse([1,5,7,10])
for (i,j) in [(65,23),(67,23),(81,49)]:
    seq,jn=T.wall_point(A,i,j)
    n=len(seq)
    for M in (20,40,60,100):
        Delta=set()
        for x in range(n):
            for d in range(1,M+1):
                if x+d<n and seq[x]==seq[x+d]: Delta.add(d)
        Dp=[d for d in range(1,M+1) if d not in Delta]
        print(i,j,'M',M,'D_c(M) =',Dp)
    wp=T.periodic_colouring(A,i); wq=T.periodic_colouring(A,j)
    def prof(w,M):
        P=len(w); return sorted({d for d in range(1,M+1) for x in range(P) if w[x]==w[(x+d)%P]})
    print(' p period',len(wp),'q period',len(wq))
    print(' D_p(40)=',[d for d in range(1,41) if d not in prof(wp,40)],' D_q(40)=',[d for d in range(1,41) if d not in prof(wq,40)])

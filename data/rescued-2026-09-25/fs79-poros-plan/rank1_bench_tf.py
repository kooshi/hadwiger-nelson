import itertools, sys
exec(open('rank1_bench.py').read().split("m=int(sys.argv[1])")[0])
def trifree(D):
    Ds=set(D); return not any((a+b) in Ds for a in D for b in D)
m=int(sys.argv[1]); size=int(sys.argv[2]); found=0; tested=0
for D in itertools.combinations(range(1,m+1),size):
    if not trifree(D): continue
    tested+=1
    if colourable(D,4,8*m): continue
    dq=dens_quarter(D,60)
    print("D=",D,"not 4-col (window",8*m,"); quarter-density set:",dq); found+=1
    if found>=6: break
print("done m=",m,"size=",size,"sum-free tested",tested,"non-4-col found",found)

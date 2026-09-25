import math, sys
from fractions import Fraction as Fr
def parse(key):
    M=int(key.split('|')[0]); H=[list(map(int,x.split(','))) for x in key.split('|')[1].split(';')]; return M,H
def inlat(v,H):
    v=list(v)
    for i in range(4):
        if v[i]%H[i][i]: return False
        q=v[i]//H[i][i]; v=[v[t]-q*H[i][t] for t in range(4)]
    return all(x==0 for x in v)
def units(key,d):
    M,H=parse(key); U=[]
    bm=math.isqrt(M*M//d)
    for a in range(-M,M+1):
        for b in range(-bm,bm+1):
            r1=M*M-a*a-d*b*b
            if r1<0: continue
            for e in range(-bm,bm+1):
                r2=r1-d*e*e
                if r2<0: continue
                c=math.isqrt(r2)
                if c*c!=r2: continue
                for cc in ({c,-c}):
                    if a*b+cc*e==0 and inlat((a,b,cc,e),H): U.append((a,b,cc,e))
    return M,sorted(set(U))
if __name__=="__main__":
    key=sys.argv[1]; d=int(sys.argv[2])
    M,U=units(key,d); print(len(U))
    sd=math.sqrt(d)
    for u in U:
        a,b,c,e=u
        print(u, round(math.degrees(math.atan2((c+e*sd)/M,(a+b*sd)/M)),3), round(math.degrees(math.atan2((c-e*sd)/M,(a-b*sd)/M)),3))

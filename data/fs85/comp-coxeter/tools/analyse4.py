from fast import *
d,a=load(False)
reps=d['orbit_representatives']
one=key8(E(1)); zt=key8(Z)
for name,s in reps.items():
    c=arr(s)
    P0=(c[0],c[kidx(one)]); P1=(c[kidx(zt)],c[kidx(tuple(x+y for x,y in zip(zt,one)))])
    pi=np.isin(c,P1).astype(np.int8)
    sg=np.where(pi==0,(c==P0[1]).astype(np.int8),(c==P1[1]).astype(np.int8))
    A=[];Per=[]
    for y in range(4096):
        k=tuple(DIG[y]); sy=sh(k)
        dd=(sg[sy]-sg)%2
        if dd.min()==dd.max(): A.append(y)
        if (c[sy]==c).all(): Per.append(y)
    As=set(A); Ps=set(Per)
    two=[i for i in range(4096) if (DIG[i]%2==0).all()]; four=[i for i in range(4096) if (DIG[i]%4==0).all()]
    print('rep %3s |Per|=%4d |A|=%4d  A>=2L:%s A>=4L:%s Per>=4L:%s Per>=2L:%s'%(name,len(Per),len(A),set(two)<=As,set(four)<=As,set(four)<=Ps,set(two)<=Ps))

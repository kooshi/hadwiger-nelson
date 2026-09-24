"""Exact witness for 'no': bad characters of order 6 have rational cosines, so (A3, A4) is rational there."""
import io, contextlib, math, collections, itertools
with contextlib.redirect_stdout(io.StringIO()):
    from spectral import *
    from spectral5 import order
S5,_,_=theta([-2,-1,0,1,2]); S9,_,_=theta(list(range(-4,5))); S9=set(S9)
def ev(t,v): return sum(Q(a)*x for a,x in zip(v,t))%1
COS={Q(0):Q(1),Q(1,6):Q(1,2),Q(1,3):Q(-1,2),Q(1,2):Q(-1),Q(2,3):Q(-1,2),Q(5,6):Q(1,2)}
def lamQ(t,k): return sum(2*COS[ev(t,v)] for v in fam[k])
o6=[t for t in S5 if order(t)==6]
V=collections.Counter((lamQ(t,3)+lamQ(t,-3)+4, lamQ(t,4)+lamQ(t,-4)+4) for t in o6)
print('order-6 bad characters:',len(o6),' distinct (A3,A4):',sorted(V.items()))

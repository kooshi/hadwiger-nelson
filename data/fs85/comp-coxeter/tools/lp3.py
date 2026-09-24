"""Symmetry-reduced form of Poros's LP: on Theta_{-2..2}, lambda_k = -2 for |k|<=2, so the 54 equalities reduce (after averaging w
over the point group, which preserves feasibility and bad weight) to  sum_theta w_theta A_m(theta) = 0 for m = 3, 4, where
A_m = lambda_m + lambda_{-m} + 4.  Bad weight can be positive iff 0 is in the convex hull of {(A3,A4)(theta): theta bad}."""
import io, contextlib, math, collections
with contextlib.redirect_stdout(io.StringIO()):
    from spectral import *
S5,_,_=theta([-2,-1,0,1,2]); S9,_,_=theta(list(range(-4,5))); S9=set(S9)
def ev(t,v): return sum(Q(a)*x for a,x in zip(v,t))%1
def lam(t,k): return sum(2*math.cos(2*math.pi*float(ev(t,v))) for v in fam[k])
pts=[]; 
for t in S5:
    a3=lam(t,3)+lam(t,-3)+4; a4=lam(t,4)+lam(t,-4)+4
    pts.append((t in S9,a3,a4))
good=[(a,b) for g,a,b in pts if g]; bad=[(a,b) for g,a,b in pts if not g]
print('good: max |A3|,|A4| =',max(abs(a) for a,b in good),max(abs(b) for a,b in good))
print('bad: min A3 =',min(a for a,b in bad),' min A4 =',min(b for a,b in bad),' min A3+A4 =',min(a+b for a,b in bad))
print('bad with A3<0:',sum(a<-1e-9 for a,b in bad),' with A4<0:',sum(b<-1e-9 for a,b in bad),' with both <=0:',sum(a<=1e-9 and b<=1e-9 for a,b in bad))
print('bad with (A3,A4)=(0,0):',sum(abs(a)<1e-9 and abs(b)<1e-9 for a,b in bad))
# which half-plane directions work: need y.(A3,A4) > 0 for all bad; check angles
angs=sorted(math.atan2(b,a) for a,b in bad if abs(a)+abs(b)>1e-9)
gaps=[(angs[(i+1)%len(angs)]-angs[i])%(2*math.pi) for i in range(len(angs))]
print('largest angular gap between bad vectors (need > pi for a certificate):',max(gaps))

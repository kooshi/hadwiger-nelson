# Poros round 2: independent check of Coxeter's FS85-C8 (Theta_K by exact solving; period lattices).
# theta in Hom(Lambda, R/Z) as t in (Q/Z)^4 against Lambda-coordinates (basis (1/9)(1,z,w,zw)).
from fractions import Fraction as Fr
import itertools, sys
from sympy import Matrix, ZZ, Rational, ilcm
from sympy.matrices.normalforms import smith_normal_decomp, smith_normal_form
exec(open('chk_db9_smith.py').read().split('zs=[one')[0])   # reuse mul, pw, lam, one, z
zs=[one,z,mul(z,z)]
def theta_K(K):
    sols=set(); inf=0
    for choice in itertools.product(range(3),repeat=len(K)):
        M=Matrix([lam(mul(zs[choice[i]],pw(k))) for i,k in enumerate(K)])
        D,U,V=smith_normal_decomp(M,domain=ZZ)
        assert U*M*V==D
        b=Matrix([Rational(1,2)]*len(K)); c=U*b
        ok=all((c[i]%1)==0 for i in range(4,len(K)))
        if not ok: continue
        ds=[D[i,i] for i in range(4)]
        if any(d==0 for d in ds): inf+=1; continue
        for ns in itertools.product(*[range(abs(d)) for d in ds]):
            s=Matrix([(c[i]+ns[i])/ds[i] for i in range(4)])
            t=V*s
            sols.add(tuple(Fr(int((x%1).p),int((x%1).q)) for x in t))
    return sols,inf
def period_index(sols):
    # period lattice P = {x in Z^4 : <t,x> in Z for all t}; generated group G of sols; P = dual; index [Z^4:P] = |G|
    N=1
    for t in sols:
        for x in t: N=ilcm(N,x.denominator)
    rows=[[int(x*N) for x in t] for t in sols]+[[N if i==j else 0 for j in range(4)] for i in range(4)]
    S=smith_normal_form(Matrix(rows),domain=ZZ)
    inv=[abs(S[i,i]) for i in range(4)]
    # G = (rows lattice)/N Z^4 ; its invariants are N/inv_i
    return N,[N//d for d in inv]
for K in [list(range(-4,5)), list(range(-3,4)), list(range(-2,3))]:
    sols,inf=theta_K(K)
    orders=sorted({max(x.denominator for x in t) if any(t) else 1 for t in sols})
    # order of t = lcm of denominators
    ords=sorted({int(ilcm(*[x.denominator for x in t])) for t in sols})
    N,G=period_index(sols)
    print(f"K={K[0]}..{K[-1]}: |Theta|={len(sols)} infinite_systems={inf} orders={ords} dual-group invariants={G}")

import sys
from fractions import Fraction as Fr
from sympy import Matrix, factorint
from sympy.matrices.normalforms import hermite_normal_form
from units_fast import units_fast
D=int(sys.argv[1]); M=int(sys.argv[2])
U=units_fast(M,D)
rows=[[a-e, b+c, 2*e, -2*b] for (a,b,c,e) in U]   # M * O-coordinates, basis {1, i, w, iw}, w=(1+i sqrt D)/2
H=hermite_normal_form(Matrix(rows).T).T
H=Matrix([r for r in H.tolist() if any(r)]); assert H.shape==(4,4)
det=Fr(abs(int(H.det())), M**4); print('M',M,'|U|',len(U),'rank 4; covolume in O-coordinates',det,'=',factorint(det.numerator),'/',factorint(det.denominator))
Hinv=H.inv()
for q in [1]+list(factorint(M)):
    # is 1/q in Lambda? coordinates of 1/q in O-basis = (1/q,0,0,0); times M, solve against H rows
    v=Matrix([[Fr(M,q),0,0,0]])
    c=v*Hinv
    print('  1/%d in Lambda:'%q, all(x.q==1 for x in c) if hasattr(c[0],'q') else all(Fr(str(x)).denominator==1 for x in c))

import sys; sys.path.insert(0, '.')
import fs73_lattice as FL
from fractions import Fraction as Fr
lat = FL.degrey(); lat.saturate('trace')
M = lat.M; print('M', M, 'rank', lat.rank, '|U|', len(lat.U)); print('H', lat.H)
# O_E basis / 9, as 8-vectors over M=36: (x on 1,s3,s11,s33 ; y on same)
B = {'1/9': (4,0,0,0, 0,0,0,0), 'z6/9': (2,0,0,0, 0,2,0,0), 'w/9': (2,0,0,0, 0,0,2,0), 'z6w/9': (1,0,0,-1, 0,1,1,0)}
C = {k: lat.coords(v) for k, v in B.items()}
print(C)
det = FL._det([list(c) for c in C.values()]); print('det of (1/9)O_E basis in Lambda coords:', det)
# v = -(4/9)(1+sqrt-11) = -(8/9) w  ; vbar = -(4/9)(1-sqrt-11)
v8 = (-16,0,0,0, 0,0,-16,0); vb8 = (-16,0,0,0, 0,0,16,0)
cv, cvb = lat.coords(v8), lat.coords(vb8); print('v', cv, 'vbar', cvb, 'v+vbar', tuple(a+b for a,b in zip(cv,cvb)), '8/9', FL.rational_point(lat, 8, 9))
import fs73_screen as S
G, gens = FL.point_group(lat)
print('point group order', len(G), sorted({g[0] if not g[0].startswith('mul') else 'mul' for g in gens.values()}))
orb = sorted({tuple(sum(cv[k]*A[k][j] for k in range(4)) for j in range(4)) for A in G})
print('orbit of v:', len(orb))
Hs = S.hnf([list(o) for o in orb], 4); print('span of v-orbit HNF', Hs)
H8 = S.hnf([[8 if i==j else 0 for j in range(4)] for i in range(4)], 4); print('8Lambda HNF', H8, 'equal:', [list(r) for r in Hs]==[list(r) for r in H8])
# the Z[zeta6]-span of v and vbar only (rotations and conj): 
z6 = next(A for A,(nm,u) in gens.items() if nm=='mul' and u == lat.coords((18,0,0,0,0,18,0,0)))

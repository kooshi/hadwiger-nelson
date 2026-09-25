# Independent check (Poros): de Grey's lattice as (1/9) O_E, E = Q(sqrt-3, sqrt-11), O_E = Z[zeta6, w], w = (1+sqrt-11)/2.
# Elements Z = a + b*z + c*w + d*z*w with z = zeta6 (z^2 = z - 1), w^2 = w - 3. A lattice point is Z/9.
import numpy as np, cmath, math, itertools
from fractions import Fraction as Fr
def mul(P, Q):
    # basis 1, z, w, zw ; represent as polynomial in z,w then reduce
    a1,b1,c1,d1 = P; a2,b2,c2,d2 = Q
    # terms: coefficients over monomials z^i w^j, i,j in {0,1,2}
    t = {}
    A = {(0,0):a1,(1,0):b1,(0,1):c1,(1,1):d1}
    B = {(0,0):a2,(1,0):b2,(0,1):c2,(1,1):d2}
    for (i1,j1),x in A.items():
        for (i2,j2),y in B.items():
            t[(i1+i2,j1+j2)] = t.get((i1+i2,j1+j2),0) + x*y
    # reduce z^2 = z - 1, w^2 = w - 3
    changed = True
    while changed:
        changed = False
        for (i,j),x in list(t.items()):
            if x == 0: continue
            if i >= 2:
                t[(i,j)] -= x; t[(i-1,j)] = t.get((i-1,j),0)+x; t[(i-2,j)] = t.get((i-2,j),0)-x; changed=True
            elif j >= 2:
                t[(i,j)] -= x; t[(i,j-1)] = t.get((i,j-1),0)+x; t[(i,j-2)] = t.get((i,j-2),0)-3*x; changed=True
    return (t.get((0,0),0), t.get((1,0),0), t.get((0,1),0), t.get((1,1),0))
def conj(P):  # complex conjugation: z -> 1 - z, w -> 1 - w
    a,b,c,d = P
    # a + b(1-z) + c(1-w) + d(1-z)(1-w) = a+b+c+d + (-b-d) z + (-c-d) w + d zw
    return (a+b+c+d, -b-d, -c-d, d)
def emb(P, s):  # s = +1 identity embedding (zeta6 = e^{i pi/3}); s = -1: sqrt-3 -> -sqrt-3 (z -> conj z, w fixed)
    z = cmath.exp(1j*math.pi/3) if s == 1 else cmath.exp(-1j*math.pi/3)
    w = (1 + 1j*math.sqrt(11))/2
    a,b,c,d = P
    return a + b*z + c*w + d*z*w
# U: Z with Z * conj(Z) = 81 exactly (i.e. |z|^2 = 1 for z = Z/9)
R = 40
rng = np.arange(-R, R+1)
A,B,C,D = np.meshgrid(rng,rng,rng,rng, indexing='ij')
z1 = cmath.exp(1j*math.pi/3); w1 = (1+1j*math.sqrt(11))/2
for s in (1,-1):
    z = z1 if s==1 else z1.conjugate()
    val = A + B*z + C*w1 + D*z*w1
    m = np.abs(np.abs(val)**2 - 81) < 1e-6
    if s == 1: M1 = m
    else: M2 = m
cand = np.argwhere(M1 & M2) - R
U = []
for a,b,c,d in cand:
    P = (int(a),int(b),int(c),int(d))
    if mul(P, conj(P)) == (81,0,0,0):
        U.append(P)
print('U size', len(U))
# is the box big enough? max coefficient
print('max |coef| in U', max(max(abs(x) for x in u) for u in U))
# generators zeta6^m rho^n, rho = (2+w)/3 -> 9 rho = 6 + 3w
rho9 = (6,0,3,0)
def pw(P, n):
    r = (1,0,0,0)
    for _ in range(n): r = mul(r,P)
    return r
zeta = (0,1,0,0)
gens = []
for m in range(6):
    zm = pw(zeta, m)
    for n in range(-2,3):
        if n >= 0:
            X = mul(zm, pw(rho9, n)); den = 9**n    # zeta^m * (9rho)^n / 9^n  -> times 9: zeta^m (9 rho)^n * 9 / 9^n
        else:
            X = mul(zm, pw(conj(rho9), -n)); den = 9**(-n)
        # point = X/den ; as Z = 9*point = 9X/den
        Z = tuple(Fr(9*x, den) for x in X)
        assert all(q.denominator == 1 for q in Z), (m,n,Z)
        gens.append(tuple(int(q) for q in Z))
print('generators', len(set(gens)), 'all in U:', all(g in set(U) for g in gens))
# HNF of the Z-span of the 30 generators (as Z-vectors in basis 1,z,w,zw of O_E); compare with O_E = Z^4 (i.e. Lambda = (1/9) O_E)
import sympy
Mg = sympy.Matrix(gens)
from sympy.matrices.normalforms import hermite_normal_form
H = hermite_normal_form(Mg.T).T
print('HNF of span (rows):', H.tolist(), ' det', Mg.T.rank(), )

v9 = (0,0,-8,0)          # 9 v = -4(1+sqrt-11) = -8 w
e9 = (8,0,0,0)           # 9 * (8/9)
print('conj(9v) =', conj(v9), ' -(9v + conj 9v) =', tuple(-(a+b) for a,b in zip(v9, conj(v9))), ' == 9*(8/9):', tuple(-(a+b) for a,b in zip(v9, conj(v9))) == e9)
print('9v embeddings', emb(v9,1)/9, emb(v9,-1)/9)
# word lengths by BFS
targets = {'8/9': e9, 'v': v9, '8/3': (24,0,0,0), 'vbar': conj(v9)}
seen = {(0,0,0,0): 0}; front = [(0,0,0,0)]
found = {}
for depth in range(1, 6):
    nxt = []
    for p in front:
        for u in U:
            q = (p[0]+u[0], p[1]+u[1], p[2]+u[2], p[3]+u[3])
            if q not in seen:
                seen[q] = depth; nxt.append(q)
    front = nxt
    for k,t in targets.items():
        if k not in found and t in seen: found[k] = seen[t]
    print('depth', depth, 'ball size', len(seen), 'found', found, flush=True)
    if len(found) == len(targets) or len(seen) > 3_000_000: break

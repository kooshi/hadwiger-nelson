"""Adversarial attempt (C1 item 4), a hand-built partial object -- checked, not searched.
Coset z0+T0 residue (rho_0 = 0); coset at eta^2 non-residue striped, direction 1, 'all-wall' phases:
rho_1(m + n zeta) = zeta if n mod 4 in {0,1} else zeta^2.  The other cosets take the values the proof forces.
We check: (1) every unit-distance pair among the built points is properly coloured, including every pair the
wiki's Prop. 7 part 1 uses, its (2/3)(1+w)eta^2 cosets set to rho = 0; (2) every T0-coset built is striped;
(3) the orientation-2 cosets (columns) are NOT striped in any direction -- the failure the proof names."""
from field import *
z, eta = ZETA, ETA
e2 = power(eta, 2)
F4add = f4_add
Z1, ZZ, ZZ2, Z0 = (1,0), (0,1), (1,1), (0,0)
def T(M, N): return add(E(M), smul(N, z))
def p(M, N): return ZZ if N % 4 in (0, 1) else ZZ2
def pshift(dM, dN): return lambda M, N: p(M + dM, N + dN)
const = lambda k: (lambda M, N: k)
sq3 = (-1, 2)                                  # sqrt(-3) = -1 + 2 zeta
w = z
bases = {                                       # base point -> rho function on T0 (M, N)
 '0': (ZERO, const(Z0)), 'e2': (e2, p),
 'z e2': (mul(z, e2), const(Z1)), 'z^-1 e2': (mul(power(z,5), e2), const(Z1)),
 '(1+z)e2': (mul(add(ONE,z), e2), const(Z0)), '(2-z)e2': (mul(sub(E(2),z), e2), const(Z0)),
 '2e2': (smul(2, e2), const(Z1)),
 '2z e2': (smul(2, mul(z, e2)), pshift(*sq3)), '-2z^2 e2': (smul(-2, mul(power(z,2), e2)), pshift(1, -2)),
 'X: 2/3(1+w)e2': (smul(Fr(2,3), mul(add(ONE,w), e2)), const(Z0)),
 "X': 2/3(1-w^2)e2": (smul(Fr(2,3), mul(sub(ONE,power(w,2)), e2)), const(Z0)),
}
R = 7
pts = {}
for name, (b, rho) in bases.items():
    for M in range(-R, R+1):
        for N in range(-R, R+1):
            x = add(b, T(M, N))
            col = F4add(rho(M, N), (M % 2, N % 2))
            assert x not in pts
            pts[x] = (col, name, M, N)
U = {mul(power(z,a), power(eta,b)) for a in range(6) for b in range(-4,5)}
keys = list(pts)
bad = 0; nedges = 0
for i, x in enumerate(keys):
    for u in U:
        y = add(x, u)
        if y in pts:
            nedges += 1
            if pts[y][0] == pts[x][0]: bad += 1
print(f"points {len(pts)}, directed unit edges among them {nedges}, monochromatic edges {bad}")
# (2) T0-cosets striped: c(t + 2 eps) = c(t) for some eps in {1, zeta, zeta^2} throughout the window
def striped_dirs(get, R):
    dirs = []
    for (dM, dN) in ((2,0), (0,2), (-2,2)):
        ok = all(get(M,N) == get(M+dM, N+dN) for M in range(-R, R+1-2) for N in range(-R+2, R+1-2)
                 if get(M+dM,N+dN) is not None)
        if ok: dirs.append((dM, dN))
    return dirs
for name, (b, rho) in bases.items():
    get = lambda M, N, b=b: pts.get(add(b, T(M, N)), (None,))[0]
    print(f"  T0-coset at {name:16s}: 2eps-periodic directions {striped_dirs(get, R)}")
# (3) orientation-2 column through t: colours at u*eta^2 + t for the built u's
us = {'0': T(0,0), '1': T(1,0), 'z': T(0,1), 'z^-1': T(1,-1), '1+z': T(1,1), '2-z': T(2,-1), '2': T(2,0)}
viol = {}
for M in range(-2, 3):
    for N in range(-2, 3):
        t = T(M, N)
        col = {k: pts[add(mul(u, e2), t)][0] for k, u in us.items()}
        for d, (a, b) in {'1': ('0','2'), 'zeta': ('z^-1','1+z'), 'zeta^2': ('z','2-z')}.items():
            if col[a] != col[b]: viol[d] = viol.get(d, 0) + 1
print("columns (orientation-2 cosets) checked: 25; pairs at 2*eta^2*delta with different colours, by delta:", viol)

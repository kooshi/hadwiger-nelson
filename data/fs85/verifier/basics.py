from field import *
import numpy as np, itertools, math

z, eta = ZETA, ETA
eta2 = power(eta, 2)
assert eta2 == E(Fr(5,6), 0, Fr(1,6), 0), eta2
assert norm_rel(eta) == ONE
# identities (8),(9) with omega = zeta6: omega^4+omega^5 = -(zeta+zeta^2); omega+omega^2 = zeta+zeta^2
s = add(z, power(z,2))
assert s == SQ3  # zeta + zeta^2 = sqrt(-3)
assert eta == add(mul(neg(s), eta2), s)                       # (8)
assert power(eta,3) == add(mul(smul(Fr(2,3), neg(s)), eta2), s)  # (9)
print("identities (8),(9) hold with omega = zeta6 = e^{i pi/3}")
# with omega = e^{2 pi i/3} = zeta^2 they should fail
om = power(z,2); s2 = add(om, power(om,2)); t2 = add(power(om,4), power(om,5))
print("(8) with omega=e^{2pi i/3}:", eta == add(mul(t2, eta2), s2))

# --- all unit vectors of Lambda: y = 9x in O_E, y conj(y) = 81 ---
basis = [from_OE(*e) for e in np.eye(4, dtype=int).tolist()]
def emb(x, sgn):
    a = complex(0, 3**0.5); b = complex(0, sgn*11**0.5)
    return float(x[0]) + float(x[1])*a + float(x[2])*b + float(x[3])*a*b
V = np.array([[emb(bv, 1) for bv in basis], [emb(bv, -1) for bv in basis]])  # 2x4 complex
G = np.real(V.conj().T @ V)   # Q(c) = c^T G c = |s1 y|^2 + |s2 y|^2
Gi = np.linalg.inv(G)
bnd = [int(math.floor(math.sqrt(162*Gi[i,i]) + 1e-9)) for i in range(4)]
print("coordinate bounds", bnd)
rng = [np.arange(-b, b+1) for b in bnd]
P,Q,R,S = np.meshgrid(*rng, indexing='ij')
C = np.stack([P.ravel(),Q.ravel(),R.ravel(),S.ravel()],1)
vals = np.einsum('ij,jk,ik->i', C, G, C)
cand = C[np.abs(vals-162) < 1e-6]
units = []
for c in cand:
    y = from_OE(*[int(v) for v in c])
    if norm_rel(y) == E(81):
        units.append(smul(Fr(1,9), y))
print("unit vectors of Lambda found:", len(units), "(candidates with Q=162:", len(cand), ")")
Uspec = {mul(power(z,a), power(eta,b)) for a in range(6) for b in range(-4,5)}
print("|U_spec| =", len(Uspec), " U_spec == all units:", Uspec == set(units))
for b in (5,6,-5,-6):
    print(f"eta^{b} in Lambda:", in_Lambda(power(eta,b)))

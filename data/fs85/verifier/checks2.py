from field import *
from lattice import *
z, eta = ZETA, ETA
U = [mul(power(z,a), power(eta,b)) for a in range(6) for b in range(-4,5)]
names = {(0,0):'0',(1,0):'1',(0,1):'zeta',(1,1):'zeta^2'}
for q in ('p', "p'"):
    print(f"red_{q}: eta^k ->", {k: names[red(power(eta,k), q)] for k in range(-4,5)},
          " zeta ->", names[red(z,q)])
# residue colouring proper: red(u) != 0 for all u in U, both primes; and U mod 2 image
for q in ('p', "p'"):
    assert all(red(u,q) != (0,0) for u in U)
img = {(red(u,'p'), red(u,"p'")) for u in U}
print("pairs (red_p u, red_p' u) over U:", len(img), "of 9 nonzero pairs")
# Lambda/2Lambda: is (red_p, red_p') : Lambda/2Lambda -> F4 x F4 an isomorphism? check on the basis 1/9(1,zeta,w,zeta w)
basisL = [smul(Fr(1,9), from_OE(*e)) for e in [(1,0,0,0),(0,1,0,0),(0,0,1,0),(0,0,0,1)]]
import itertools
imgs = set()
for cs in itertools.product([0,1], repeat=4):
    x = ZERO
    for c, b in zip(cs, basisL):
        if c: x = add(x, b)
    imgs.add((red(x,'p'), red(x,"p'")))
print("|image of Lambda/2Lambda| =", len(imgs), "(16 means (red_p, red_p') is an isomorphism Lambda/2Lambda -> F4^2)")

# ---- the lattices M = T0 + eta^2 T0, N+ = T0 + T0 theta, theta = eta^2/sqrt(-3) ----
theta = div(power(eta,2), SQ3)
print("theta in Lambda:", in_Lambda(theta), "; 9*theta coords:", lam_coords(theta))
print("eta == sqrt(-3) + 3 theta:", eta == add(SQ3, smul(3, theta)),
      "; eta^3 == sqrt(-3) + 2 theta:", power(eta,3) == add(SQ3, smul(2, theta)),
      "; eta^2 == sqrt(-3) theta:", power(eta,2) == mul(SQ3, theta))
def span_rows(gens): return hnf([list(lam_coords(g)) for g in gens])
T0 = [ONE, z]
M = T0 + [power(eta,2), mul(power(eta,2), z)]
Np = T0 + [theta, mul(theta, z)]
HM = span_rows(M); HN = span_rows(Np)
print("[Lambda : M] =", det_of_hnf(HM), "; [Lambda : N+] =", det_of_hnf(HN))
def in_lat(x, H): return hnf(H + [list(lam_coords(x))]) == H
print("U cap M:", sorted({b for a in range(6) for b in range(-4,5) if in_lat(mul(power(z,a),power(eta,b)), HM)}),
      "(exponents b of zeta^a eta^b in M)")
print("U cap N+:", sorted({b for a in range(6) for b in range(-4,5) if in_lat(mul(power(z,a),power(eta,b)), HN)}))
# rotated/conjugated wiki point sets: eta^m N+ (m=-4..1) and eta^m conj(N+) (m=-1..4) inside Lambda?
for m in range(-4, 5):
    for tag, base in (('+', Np), ('-', [conj(g) for g in Np])):
        ok = all(in_Lambda(mul(power(eta,m), g)) for g in base)
        Hb = span_rows([mul(power(eta,m), g) for g in base]) if ok else None
        exps = sorted({b for a in range(6) for b in range(-4,5)
                       if ok and in_lat(mul(power(z,a),power(eta,b)), Hb)}) if ok else None
        print(f"  eta^{m} N{tag}: inside Lambda={ok}; unit-vector exponents inside: {exps}")

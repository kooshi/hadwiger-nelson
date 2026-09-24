from field import *
from lattice import *
from math import gcd
z, eta = ZETA, ETA
U = [mul(power(z,a), power(eta,b)) for a in range(6) for b in range(-4,5)]
LU = [list(lam_coords(u)) for u in U]
H = hnf(LU)
print("HNF of U in Lambda coords:", H, " index [Lambda:<U>] =", det_of_hnf(H))

def orient_basis(k):
    ek = power(eta,k)
    return [ek, mul(ek, z)]

def in_span(x, gens):
    """is x in the Z-span of gens (all in Lambda)? via HNF index comparison"""
    Hg = hnf([list(lam_coords(g)) for g in gens])
    Hx = hnf([list(lam_coords(g)) for g in gens] + [list(lam_coords(x))])
    return Hg == Hx

def same_coset(x, y, gens):
    return in_span(sub(x, y), gens)

# rank-2 sublattice membership: solve exactly  x = alpha*e + beta*(e zeta)
def orient_coords(x, k):
    """x = eta^k (m + n zeta) with m, n rational; return (m, n) as Fractions"""
    t = div(x, power(eta,k))   # should be in Q(sqrt-3): b and ab parts zero
    if t[2] != 0 or t[3] != 0: return None
    c = to_OE(t)
    return (c[0], c[1])

def in_orient(x, k):
    c = orient_coords(x, k)
    return c is not None and all(v.denominator == 1 for v in c)

for k in range(-2,3):
    sizes = {}
    Uk = [u for u in U if in_orient(u, k)]
    others = [u for u in U if not in_orient(u, k)]
    classes = []
    for u in others:
        for cl in classes:
            if in_orient(sub(u, cl[0]), k):
                cl.append(u); break
        else:
            classes.append([u])
    hist = {}
    for cl in classes: hist[len(cl)] = hist.get(len(cl),0)+1
    print(f"orientation {k}: |U cap eta^k T0| = {len(Uk)}, other unit vectors fall into cosets of sizes {hist}")

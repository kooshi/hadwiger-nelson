# Exact enumeration of the linear-circular-3-colouring set Theta for a lattice given by generators U (integer vectors in Z^N).
# Theta = { theta in Hom(Lambda,R) : theta(u) mod 1 in [1/3,2/3] for all u in U }.
import itertools, sys
from fractions import Fraction as Fr
from sympy import Matrix
def hnf_basis(vecs):
    # integer row-HNF basis of the Z-span of vecs (list of int lists)
    from sympy.matrices.normalforms import hermite_normal_form
    M = Matrix(vecs).T  # columns = vectors
    H = hermite_normal_form(M)  # columns span same lattice
    cols = [list(H[:,j]) for j in range(H.shape[1]) if any(H[:,j])]
    return cols
def coords(basis, v):
    B = Matrix(basis).T
    x = B.solve(Matrix(v)) if B.shape[0]==B.shape[1] else B.pinv()*Matrix(v)
    x = [Fr(int(t.p), int(t.q)) for t in x]
    assert all(t.denominator==1 for t in x), (v, x)
    return [int(t) for t in x]
def vertices(Uc, r):
    """All theta mod Z^r that are vertices of cells of Theta. Uc: coordinates (ints) of U^+ in a Z-basis of Lambda."""
    found = {}
    for sub in itertools.combinations(range(len(Uc)), r):
        M = Matrix([Uc[i] for i in sub])
        d = M.det()
        if d == 0: continue
        Minv = M.inv()
        D = abs(int(d))
        # theta = Minv * t, t in (1/3)Z^r with t_i mod 1 in {1/3,2/3}; theta mod Z^r:
        # enumerate t over (1/3)*{1,2} + Z, modulo the lattice M Z^r ... simpler: enumerate theta in (1/(3D))Z^r / Z^r? too many.
        # Instead: theta mod Z^r determined by t mod (M Z^r). Enumerate t = (s + 3k)/3, s in {1,2}^r, k in Z^r mod M^T-lattice...
        # Use: theta in (1/3) M^{-1} Z^r; reps of (1/3)M^{-1}Z^r / Z^r: cosets of Z^r in (1/3)M^{-1}Z^r, count 3^r * D.
        # Enumerate k in Z^r modulo M Z^r (D reps via Smith-like brute force on box [0,D)^r filtered) -- fine for small D.
        reps = coset_reps(M, D)
        for s in itertools.product((1,2), repeat=r):
            for k in reps:
                t = [Fr(s[i],3) + k[i] for i in range(r)]
                th = [sum(Fr(int(Minv[a,b].p), int(Minv[a,b].q))*t[b] for b in range(r)) for a in range(r)]
                th = tuple(x - (x.numerator//x.denominator) for x in th)  # mod 1
                if th in found: continue
                if all(Fr(1,3) <= (sum(th[a]*u[a] for a in range(r)) % 1) <= Fr(2,3) for u in Uc):
                    found[th] = sub
    return found
def coset_reps(M, D):
    # representatives of Z^r / (M^T Z^r)?? we need k in Z^r with theta = (1/3)Minv (s+3k) distinct mod Z^r:
    # (1/3)Minv*3k = Minv k; Minv k in Z^r iff k in M Z^r (columns of M). reps of Z^r / M Z^r.
    from sympy.matrices.normalforms import smith_normal_form
    r = M.shape[0]
    # brute force: box [0,D)^r reduced by membership
    reps = []; seen = set()
    Minv = M.inv()
    for k in itertools.product(range(D), repeat=r):
        v = Minv*Matrix(k)
        key = tuple((Fr(int(x.p),int(x.q)) % 1) for x in v)
        if key not in seen:
            seen.add(key); reps.append(list(k))
        if len(reps) == D: break
    return reps

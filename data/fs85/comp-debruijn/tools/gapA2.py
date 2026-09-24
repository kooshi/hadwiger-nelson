"""Gap A, iterated: grow the residue region's lattice M_i by every class of U mod M_i whose members' reductions (at the region's
prime) cover all of F4^x (three residue-type neighbours with distinct reductions force a bordering coset to be residue-type).
Both primes are tried (the global residue colouring lives at one of them)."""
import sympy
from lam import *
from twoadic import emb
from collections import defaultdict
eta=(Fr(0),Fr(1,6),Fr(0),Fr(-1,6))
def pw(a,k):
    r=ONE
    if k<0: a=inv(a); k=-k
    for _ in range(k): r=mul(r,a)
    return r
def lc(a): return [int(9*x) for x in coords(a)]
U = [(mul(pw(Z6,k), pw(eta,b)), (k,b)) for b in range(-4,5) for k in range(6)]
from sympy.matrices.normalforms import hermite_normal_form
def span_index(gens):
    Mx = sympy.Matrix(gens)
    from sympy.matrices.normalforms import smith_normal_form
    D = smith_normal_form(Mx, domain=sympy.ZZ)
    ds = [abs(D[i,i]) for i in range(min(D.shape))]
    return sympy.prod(ds) if all(ds) and len(ds) == 4 else 0
def same_class(gens, a, b):
    # a - b in span(gens)?  solve over Q then check integrality via Smith: use sympy linear solve on the lattice basis
    Mx = sympy.Matrix(gens).T
    # reduce gens to a basis via HNF of the 4 x k matrix
    H = hermite_normal_form(Mx)
    H = H[:, [j for j in range(H.shape[1]) if any(H[i,j] != 0 for i in range(4))]]
    sol = H.solve(sympy.Matrix(lc(sub(a, b)))) if H.shape[1] == 4 else None
    return sol is not None and all(x.q == 1 for x in sol)
for s, name in [(1, 'p'), (-1, "p'")]:
    red = {kb: (emb(u, s)[0] % 2, emb(u, s)[1] % 2) for u, kb in U}
    gens = [lc(ONE), lc(Z6), lc(mul(eta,eta)), lc(mul(Z6,mul(eta,eta)))]
    for it in range(6):
        classes = []
        for u, kb in U:
            for cl in classes:
                if same_class(gens, u, cl[0][0]): cl.append((u, kb)); break
            else: classes.append([(u, kb)])
        full = [cl for cl in classes if len({red[kb] for _, kb in cl}) == 3]
        idx = span_index(gens)
        print(name, 'iteration', it, ': index of region lattice', idx, ', classes met', len(classes), ', full classes', len(full))
        added = False
        for cl in full:
            v = lc(cl[0][0])
            if not same_class(gens, cl[0][0], (Fr(0),)*4):
                gens.append(v); added = True
        if not added: break
    two = [cl for cl in classes if len({red[kb] for _, kb in cl}) == 2]
    print(name, ' final: classes with exactly two reductions:', len(two), ' single-reduction classes:', sum(1 for cl in classes if len({red[kb] for _, kb in cl}) == 1))

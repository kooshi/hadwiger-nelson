"""OBS-N3 control for C3: on the triangular lattice (generators e1=1, e2=zeta, e3=zeta^2=zeta-1, so e1+e3=e2), closed edge-local
four-colour forms modulo trivial ones.  Closedness asked on every proper colouring of every relation cycle's induced subgraph:
the triangles (x, x+e1, x+e2) and (x, x+e3, x+e2)... generated here by all 3-cycles and 4-cycles among the vertices {0, e_i, e_j, e_i+e_j}.
Expected: 2 extra dimensions (Moore-Newman's E : V4\\0 -> Q with E(alpha)+E(beta)+E(gamma)=0).  Also the grid Z^2 control: 0 extra."""
import itertools
from local_forms import rank
def run(gens, name):
    k = 4
    G = gens + [tuple(-x for x in g) for g in gens]
    Gs = set(G)
    pairs = [(a,b) for a in range(k) for b in range(k) if a != b]
    idx = {(i, ab): n for n, (i, ab) in enumerate(itertools.product(range(len(gens)), pairs))}
    n = len(idx)
    def val(step, a, b):                       # F along a generator step (possibly negative)
        v = [0]*n
        if step in gens: v[idx[(gens.index(step), (a, b))]] += 1
        else: v[idx[(gens.index(tuple(-x for x in step)), (b, a))]] -= 1
        return v
    # relation cycles: all closed walks of length 3 and 4 using generator steps, based at 0
    eqs = []
    for L in (3, 4):
        for steps in itertools.product(G, repeat=L):
            if tuple(sum(z) for z in zip(*steps)) != (0, 0): continue
            pts = [(0, 0)]
            for st in steps[:-1]: pts.append(tuple(a+b for a, b in zip(pts[-1], st)))
            if len(set(pts)) != L: continue
            # induced subgraph constraints: all pairs among pts at a generator difference must differ
            prs = [(p, q) for p, q in itertools.combinations(range(L), 2) if tuple(a-b for a, b in zip(pts[q], pts[p])) in Gs]
            for cols in itertools.product(range(k), repeat=L):
                if any(cols[p] == cols[q] for p, q in prs): continue
                v = [0]*n
                for m, st in enumerate(steps):
                    w = val(st, cols[m], cols[(m+1) % L])
                    v = [x+y for x, y in zip(v, w)]
                eqs.append(v)
    closed = n - rank(eqs, n)
    # trivial: delta g (3 dims modulo constants... use all 4 g's) + constants per generator
    triv = []
    for col in range(k):
        triv.append([ (1 if ab[1] == col else 0) - (1 if ab[0] == col else 0) for (i, ab) in idx])
    for i in range(len(gens)):
        triv.append([1 if key[0] == i else 0 for key in idx])
    # closed trivial: those combinations that are closed; here constants closed iff they sum to 0 on relations
    import sympy
    T = sympy.Matrix(triv).T; E = sympy.Matrix(eqs)
    K = (E*T).nullspace(); td = sympy.Matrix.hstack(*[T*kv for kv in K]).rank() if K else 0
    print(f'{name}: unknowns {n}, closed {closed}, closed-trivial {td}, extra classes {closed - td}')
run([(1, 0), (0, 1), (-1, 1)], 'triangular lattice (e1, e2, e2-e1)')
run([(1, 0), (0, 1)], 'grid Z^2')

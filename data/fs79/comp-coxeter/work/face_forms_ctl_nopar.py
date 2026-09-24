"""Face-local 2-forms (parity-dependent allowed) closed on every proper k-colouring of an induced 3-cube Q3, modulo d(edge-local 1-forms) + constants."""
import itertools
from local_forms import rank
import sys
k = int(sys.argv[1]) if len(sys.argv) > 1 else 4
MONO = len(sys.argv) > 2
P = [0]
# face type (i,j), i<j, oriented i then j; pattern (a,b,c,d) at x, x+s_i, x+s_i+s_j, x+s_j ; parity p of x
pats = [q for q in itertools.product(range(k), repeat=4) if q[0]!=q[1] and q[1]!=q[2] and q[2]!=q[3] and q[3]!=q[0]]
ftypes = [(0,1),(0,2),(1,2)]
idx = {}
for ft in ftypes:
    for q in pats:
        for p in P: idx[(ft,q,p)] = len(idx)
n = len(idx)
def omega(i, j, cols, p):
    """oriented face value for face at x spanned by s_i then s_j with vertex colours cols=(x, x+s_i, x+s_i+s_j, x+s_j)"""
    v = [0]*n
    if i < j: v[idx[((i,j),tuple(cols),p)]] += 1
    else:
        a,b,c,d = cols           # reversed orientation: (x, x+s_j, ..., x+s_i) = (a,d,c,b) for type (j,i)
        v[idx[((j,i),(a,d,c,b),p)]] -= 1
    return v
# cube vertices: subsets of {0,1,2}; parity = |subset| + p
verts = [frozenset(S) for r in range(4) for S in itertools.combinations(range(3), r)]
edges = [(u, u|{i}) for u in verts for i in range(3) if i not in u]
def cube_eq(col, p):
    """sum of outward-oriented faces = 0 (boundary of the cube)"""
    tot = [0]*n
    def face(base, i, j, sgn):
        c = (col[base], col[base|{i}], col[base|{i,j}], col[base|{j}])
        par = 0
        w = omega(i, j, c, par)
        for t in range(n): tot[t] += sgn*w[t]
    E = frozenset()
    # boundary of [0,1]^3 with orientation: faces (i,j) at base 0 with sign -(-1)^?; use standard: d(e_i∧e_j∧e_k)
    # boundary of cube (0,1,2) = sum over k in {0,1,2} of (-1)^k [ face omitting k at x+s_k  -  face omitting k at x ]
    for kk in range(3):
        i, j = [t for t in range(3) if t != kk]
        sg = (-1)**kk
        face(frozenset({kk}), i, j, sg)
        face(E, i, j, -sg)
    return tot
eqs = []
for p in P:
    for cs in itertools.product(range(k), repeat=8):
        col = dict(zip(verts, cs))
        if any(col[u] == col[w] for u, w in edges): continue
        if MONO and all(col[u] == col[frozenset({0,1,2})-u] for u in verts): continue
        eqs.append(cube_eq(col, p))
print('k', k, 'unknowns', n, 'cube colourings x parities', len(eqs))
closed_dim = n - rank(eqs, n)
# trivial: d(eta) for edge-local eta(dir, a, b, parity of tail) and constants per face type (parity-free), and parity-dependent constants
triv = []
for dr in range(3):
    for a in range(k):
        for b in range(k):
            if a == b: continue
            for p0 in P:
                v = [0]*n
                # face (i,j) at x: eta(x->x+s_i) + eta(x+s_i -> x+s_i+s_j) - eta(x+s_j -> x+s_i+s_j) - eta(x -> x+s_j)
                for (ft, q, p), t in idx.items():
                    i, j = ft; A, B, C, D = q
                    if dr == i and (A, B) == (a, b) and p == p0: v[t] += 1
                    if dr == j and (B, C) == (a, b) and p == p0: v[t] += 1
                    if dr == i and (D, C) == (a, b) and p == p0: v[t] -= 1
                    if dr == j and (A, D) == (a, b) and p == p0: v[t] -= 1
                triv.append(v)
for ft in ftypes:
    for p0 in P:
        triv.append([1 if (key[0] == ft and key[2] == p0) else 0 for key in idx])
# dimension of closed ∩ span(triv): rank of triv vectors that are closed-combinations; compute rank([eqs]) and rank of eqs restricted
import sympy
T = triv
# closed-trivial dim = dim span(T) - rank(E T)
ET = [[sum(e[i]*t[i] for i in range(n)) for t in T] for e in eqs]
spanT = rank(T, n)
rET = rank(ET, len(T))
# dim of {combinations y : E T y = 0} images = dim span(T) - rank(E restricted to span T)
# rank(E restricted to span T) = rank(E T) (as a map on coefficient space) -> image dimension
print('closed dim', closed_dim, '| trivial span dim', spanT, '| rank of cube equations on the trivial span', rET, '| closed trivial dim', spanT - rET)
print('H^2 (closed modulo closed-trivial):', closed_dim - (spanT - rET))

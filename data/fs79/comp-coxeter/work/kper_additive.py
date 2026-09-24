"""Kempe period groups of additive Z/4 colourings: KPer(phi) = <U2> ∩ <U1 - U1>  (Coxeter, FS-79).
Standalone except for importing the frozen-in-spirit phase-0 checker's unit enumeration (read-only)."""
import sys, itertools
sys.path.insert(0, '/home/kooshi/source/lean-dir/tools')
from fs79_p0_check import units_be, units_ac, hnf, coords_in
from sympy import Matrix, Rational

def span_hnf(vecs):
    return hnf([list(v) for v in vecs])

def rank(B):
    return Matrix(B).rank() if B else 0

def intersect(A, B):
    """intersection of two sublattices of Z^4 given by row bases (any ranks): integer kernel of [A; -B]^T"""
    if not A or not B: return []
    MA, MB = Matrix(A), Matrix(B)
    K = Matrix.vstack(MA, -MB).T          # 4 x (a+b); kernel vectors (y,z) with y A = z B
    # integer kernel via sympy's nullspace + clearing denominators then saturating with HNF of the lattice of solutions
    ns = K.nullspace()
    if not ns: return []
    # the rational kernel; its integer points form a lattice: compute saturation by LLL-free method:
    # take rational basis, scale to integers, then the integer lattice = kernel ∩ Z^{a+b}; compute via Smith-free trick:
    from sympy.matrices.normalforms import hermite_normal_form
    N = Matrix.hstack(*ns).T
    N = N * Matrix.diag(*([1]*N.shape[1]))
    den = 1
    for x in N: den = den * Rational(x).q // __import__('math').gcd(den, Rational(x).q)
    N = (N * den).applyfunc(int)
    # saturate: integer points of the rational row space of N
    # row space ∩ Z^m = {v in Z^m : v in rowspace}; compute via the kernel of the kernel
    Kp = N.nullspace()  # orthogonal complement (rational)
    # integer lattice orthogonal to Kp: build integer matrix of Kp and take its integer kernel via HNF of the transpose
    import math
    rows = []
    for v in Kp:
        dd = 1
        for x in v: dd = dd*Rational(x).q//math.gcd(dd, Rational(x).q)
        rows.append([int(x*dd) for x in v])
    m = N.shape[1]
    if not rows:
        sat = [[1 if i==j else 0 for j in range(m)] for i in range(m)]
    else:
        sat = int_kernel(rows, m)
    pts = [list(Matrix([s]) * MA.col_join(Matrix.zeros(0,4)) ) for s in []]
    a = len(A)
    out = []
    for s in sat:
        y = s[:a]
        v = [sum(y[i]*A[i][j] for i in range(a)) for j in range(4)]
        out.append(v)
    return span_hnf(out)

def int_kernel(rows, m):
    """integer kernel {x in Z^m : rows x = 0} via column-style HNF with a unimodular transform"""
    A = [list(r) for r in rows]
    n = len(A)
    # work on columns: transform T (m x m) unimodular with A T in column echelon form
    T = [[1 if i==j else 0 for j in range(m)] for i in range(m)]
    cols = list(range(m))
    piv_col = 0
    for r in range(n):
        # gcd-reduce entries A[r][piv_col:] into column piv_col
        while True:
            nz = [j for j in range(piv_col, m) if A[r][j] != 0]
            if len(nz) <= 1: break
            j0 = min(nz, key=lambda j: abs(A[r][j]))
            for j in nz:
                if j == j0: continue
                q = A[r][j] // A[r][j0]
                for i in range(n): A[i][j] -= q*A[i][j0]
                for i in range(m): T[i][j] -= q*T[i][j0]
        nz = [j for j in range(piv_col, m) if A[r][j] != 0]
        if nz:
            j0 = nz[0]
            # swap j0 into piv_col
            for i in range(n): A[i][j0], A[i][piv_col] = A[i][piv_col], A[i][j0]
            for i in range(m): T[i][j0], T[i][piv_col] = T[i][piv_col], T[i][j0]
            piv_col += 1
    # columns piv_col.. of T span the kernel
    return [[T[i][j] for i in range(m)] for j in range(piv_col, m)]

def index_in(sub, full):
    """index of sub in full if same rank, else None"""
    if rank(sub) != rank(full): return None
    return abs(Matrix(sub).det() / Matrix(full).det()) if len(sub)==len(full)==4 else None

M, d = 420, 167
U = units_be(M, d); assert U == units_ac(M, d) and len(U) == 60
U = sorted(U)
H = [list(h) for h in span_hnf(U)]
print('H', H)
# all phi: Lambda -> Z/4 via values on H rows
phis = []
for vals in itertools.product(range(4), repeat=4):
    def phi(v, vals=vals):
        c = coords_in(H, v); return sum(ci*vi for ci, vi in zip(c, vals)) % 4
    if all(phi(u) != 0 for u in U): phis.append((vals, phi))
print('additive Z/4 colourings:', len(phis))
tot = None
if __name__ != "__main__": phis = []
for vals, phi in phis:
    U1 = [u for u in U if phi(u) == 1]; U2 = [u for u in U if phi(u) == 2]
    G2 = span_hnf(U2)
    D1 = span_hnf([[a-b for a,b in zip(u,w)] for u in U1 for w in U1 if u != w])
    K = intersect([list(x) for x in G2], [list(x) for x in D1])
    print(vals, '|U1|,|U2|=', len(U1), len(U2), 'rank<U2>=', rank([list(x) for x in G2]), 'rank D1=', rank([list(x) for x in D1]),
          'KPer rank', rank(K), 'index', index_in(K, H) if K else None)
    tot = K if tot is None else intersect(tot, K)
if phis: print('intersection over all additive colourings: rank', rank(tot), 'basis', tot, 'index', index_in(tot, H) if tot else None)

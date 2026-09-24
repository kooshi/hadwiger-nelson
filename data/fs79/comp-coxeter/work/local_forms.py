"""Local closed forms for k-colourings: edge-local 1-forms on an induced square, face-local 2-forms on an induced 3-cube.
Exact rank by modular elimination at two large primes (rank over Q = rank mod p unless p divides a minor; two primes agree)."""
import itertools, sys
PR = [2147483629, 2147483587]
def rank_mod(rows, ncols, p):
    rows = [[x % p for x in r] for r in rows if any(r)]
    rk = 0; col = 0; piv_rows = []
    A = rows
    for c in range(ncols):
        pr = None
        for i in range(rk, len(A)):
            if A[i][c]: pr = i; break
        if pr is None: continue
        A[rk], A[pr] = A[pr], A[rk]
        inv = pow(A[rk][c], p-2, p)
        A[rk] = [(x*inv) % p for x in A[rk]]
        for i in range(len(A)):
            if i != rk and A[i][c]:
                f = A[i][c]
                A[i] = [(x - f*y) % p for x, y in zip(A[i], A[rk])]
        rk += 1
        if rk == len(A): break
    return rk
def rank(rows, n):
    r = [rank_mod(rows, n, p) for p in PR]
    assert r[0] == r[1], r
    return r[0]

def edge_local(k, parity):
    # unknowns F[dir][(a,b)][p], dir in {0,1}; relation: square x, x+s0, x+s0+s1, x+s1
    pairs = [(a,b) for a in range(k) for b in range(k) if a != b]
    P = [0,1] if parity else [0]
    idx = {}
    for dr in range(2):
        for ab in pairs:
            for p in P: idx[(dr,ab,p)] = len(idx)
    n = len(idx)
    def F(dr, a, b, p):   # oriented value; reverse edge = -F(dr,b,a,p') where p' parity of the other end
        v = [0]*n; v[idx[(dr,(a,b),p % 2 if parity else 0)]] = 1; return v
    def add(*vs):
        out = [0]*n
        for sgn, v in vs:
            for i, x in enumerate(v): out[i] += sgn*x
        return out
    eqs = []
    for p in P:
        for a,b,c,d in itertools.product(range(k), repeat=4):
            if a==b or b==c or c==d or d==a: continue
            # x(a,p) -s0-> x+s0 (b,p+1) -s1-> x+s0+s1 (c,p) ; x -s1-> x+s1 (d,p+1) -s0-> (c)
            eqs.append(add((1,F(0,a,b,p)), (1,F(1,b,c,p+1)), (-1,F(1,a,d,p)), (-1,F(0,d,c,p+1))))
    closed_dim = n - rank(eqs, n)
    # trivial: coboundaries of vertex functions g(colour, parity) and constants per direction (and per parity? only if closed)
    triv = []
    for col in range(k):
        for p in P:
            v = [0]*n
            for (dr,(a,b),pp), i in idx.items():
                # F(x->y) = g(c(y),p(y)) - g(c(x),p(x)); edge from parity pp to pp+1
                if b == col and ((pp+1) % 2 if parity else 0) == p: v[i] += 1
                if a == col and pp == p: v[i] -= 1
            triv.append(v)
    for dr in range(2):
        for p in P:
            triv.append([1 if (key[0]==dr and key[2]==p) else 0 for key in idx])
    # keep only trivial vectors that are closed
    def closed(v): return all(sum(e[i]*v[i] for i in range(n)) == 0 for e in eqs)
    triv_closed = [v for v in triv if closed(v)]
    # the span of trivial ∩ closed: compute rank of trivial vectors combined, then check the closed part
    # (constants per direction-parity: include combos that are closed) -> compute kernel of eqs restricted to span(triv)
    import sympy
    T = sympy.Matrix(triv).T              # n x t
    E = sympy.Matrix(eqs)
    K = (E*T).nullspace()
    triv_dim = sympy.Matrix.hstack(*[T*kv for kv in K]).rank() if K else 0
    return n, closed_dim, triv_dim

for k in (3, 4):
    for parity in (False, True):
        print('edge-local 1-forms on an induced square: k=%d parity-dependent=%s -> unknowns, closed dim, trivial dim:' % (k, parity), edge_local(k, parity))

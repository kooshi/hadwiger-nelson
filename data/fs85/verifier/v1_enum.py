"""V1 checked against an exact enumeration of stripe DATA on a window (no colouring of any graph is searched).
Eisenstein integers as (M, N) = M + N*zeta.  A stripe pattern in direction eps (brief's pinned form):
  t = eps (m' + n' zeta),  c(t) = P[n' mod 2][(m' + phi[n']) mod 2].
Window W for directions e1 != e2: the 16 points on lines n'_1 in 0..3 and n'_2 in 0..3.
Claim V1 (window form): if f (direction e1) and g (direction e2) differ at every point of W, then f|W or g|W is
2T0-periodic on W; and if f's and g's pair partitions coincide, both are.   'plant' drops one point from the f != g test.
"""
import itertools, sys
PLANT = sys.argv[1:] == ['plant']
def coords(M, N, e):          # (m', n') with M + N zeta = zeta^e (m' + n' zeta)
    if e == 0: return M, N
    if e == 1: return M + N, -M
    if e == 2: return N, -(M + N)
PERMS = list(itertools.permutations(range(4)))
def pattern(e, perm, phi):     # perm: (P0[0],P0[1],P1[0],P1[1])
    P = ((perm[0], perm[1]), (perm[2], perm[3]))
    def col(M, N):
        m, n = coords(M, N, e)
        return P[n % 2][(m + phi[n]) % 2]
    return col
def window(e1, e2):
    W = [(M, N) for M in range(-12, 13) for N in range(-12, 13)
         if 0 <= coords(M, N, e1)[1] <= 3 and 0 <= coords(M, N, e2)[1] <= 3]
    assert len(W) == 16, len(W)
    return W
def periodic2(vals, W):
    for (a, b) in itertools.combinations(range(len(W)), 2):
        (M1, N1), (M2, N2) = W[a], W[b]
        if (M1 - M2) % 2 == 0 and (N1 - N2) % 2 == 0 and vals[a] != vals[b]: return False
    return True
def partition(perm): return frozenset([frozenset(perm[:2]), frozenset(perm[2:])])
tot_bad = 0
for e1, e2 in itertools.product(range(3), repeat=2):
    W = window(e1, e2) if e1 != e2 else window(e1, (e1 + 1) % 3)
    test = W[1:] if PLANT else W
    def data(e):
        out = []
        for perm in PERMS:
            for ph in itertools.product((0, 1), repeat=4):
                phi = {k: ph[k] for k in range(4)}
                col = pattern(e, perm, phi)
                vals = tuple(col(*p) for p in W)
                out.append((perm, vals, periodic2(vals, W)))
        return out
    D1, D2 = data(e1), data(e2)
    idx = [W.index(p) for p in test]
    n_disjoint = n_nonres_pair = bad_eq = 0
    for p1, v1, r1 in D1:
        for p2, v2, r2 in D2:
            if any(v1[i] == v2[i] for i in idx): continue
            n_disjoint += 1
            if not r1 and not r2: n_nonres_pair += 1
            if partition(p1) == partition(p2) and not (r1 and r2): bad_eq += 1
    viol = n_nonres_pair if e1 != e2 else 0
    tot_bad += viol + (bad_eq if e1 != e2 else 0)
    print(f"directions ({e1},{e2}): pointwise-disjoint pairs {n_disjoint}; both non-residue {n_nonres_pair}; "
          f"equal partitions but not both residue {bad_eq}")
print("V1 window-claim violations (distinct directions):", tot_bad)

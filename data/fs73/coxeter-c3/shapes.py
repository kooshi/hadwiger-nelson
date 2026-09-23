import math, sys, itertools
from theta2 import *
def in_lattice(v, H):
    # H: HNF rows (upper triangular, integer). v integer vector. Solve by back-substitution.
    v = list(v); n = len(H)
    for i in range(n):
        piv = H[i][i]
        if v[i] % piv: return False
        q = v[i] // piv
        v = [v[j] - q*H[i][j] for j in range(n)]
    return all(x == 0 for x in v)
def units(M, H, d):
    U = []
    bmax = int(math.isqrt(M*M // d)) + 1
    for a in range(-M, M+1):
        for b in range(-bmax, bmax+1):
            r1 = M*M - a*a - d*b*b
            if r1 < 0: continue
            for e in range(-bmax, bmax+1):
                r2 = r1 - d*e*e
                if r2 < 0: continue
                c = math.isqrt(r2)
                for cc in {c, -c}:
                    if cc*cc == r2 and a*b + cc*e == 0 and in_lattice((a,b,cc,e), H): U.append((a,b,cc,e))
    return sorted(set(U))
def analyse(M, H, d, verbose=True):
    U = units(M, H, d)
    B, C = lattice_coords(U); S = halfset(C); r = B.shape[1]
    D, sub, Mx, Minv, Cu, leaves = enumerate_theta(S, r, verbose=False)
    pts = fat = 0; sample = None
    for (k, A) in leaves:
        ext = leaf_extent(r, A)
        if ext is None: continue
        w = max(b - a for a, b in ext)
        if w < 1e-9: pts += 1
        else: fat += 1
        if sample is None: sample = (k, ext)
    if verbose: print(f"d={d} M={M} |U|={len(U)} rank={r} frameD={D} leaves={len(leaves)} point-cells={pts} fat-cells={fat}")
    return U, pts, fat, sample
if __name__ == "__main__":
    M = int(sys.argv[1]); H = [list(map(int, row.split(','))) for row in sys.argv[2].split(';')]
    for d in map(int, sys.argv[3:]):
        analyse(M, H, d)

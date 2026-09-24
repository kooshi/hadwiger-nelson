"""Integer lattice helpers (Hermite normal form, index, membership) -- standard library only."""
from fractions import Fraction as Fr

def hnf(rows):
    """Row-style HNF of an integer matrix (list of lists); returns nonzero rows (upper triangular)."""
    A = [list(r) for r in rows]
    m = len(A); n = len(A[0]) if A else 0
    r = 0
    for c in range(n):
        # gcd-reduce column c among rows r..m-1
        while True:
            nz = [i for i in range(r, m) if A[i][c] != 0]
            if not nz: break
            piv = min(nz, key=lambda i: abs(A[i][c]))
            A[r], A[piv] = A[piv], A[r]
            done = True
            for i in range(r+1, m):
                if A[i][c]:
                    q = A[i][c] // A[r][c]
                    A[i] = [a - q*b for a, b in zip(A[i], A[r])]
                    if A[i][c]: done = False
            if done: break
        if r < m and A[r][c] != 0:
            if A[r][c] < 0: A[r] = [-a for a in A[r]]
            for i in range(r):
                q = A[i][c] // A[r][c]
                A[i] = [a - q*b for a, b in zip(A[i], A[r])]
            r += 1
        if r == m: break
    return [row for row in A if any(row)]

def det_of_hnf(H):
    d = 1
    for i, row in enumerate(H):
        piv = next(x for x in row if x != 0)
        d *= piv
    return abs(d)

def smith_exponent_invariants(rows, n):
    """Smith invariants of Z^n / span(rows) (requires full rank). Returns list of invariant factors."""
    import copy
    A = [list(r) for r in rows]
    m = len(A)
    inv = []
    # simple Smith via repeated row/col ops
    A = [r[:] for r in A]
    rows_, cols = m, n
    t = 0
    while t < min(rows_, cols):
        # find nonzero with min abs in submatrix
        best = None
        for i in range(t, rows_):
            for j in range(t, cols):
                if A[i][j] and (best is None or abs(A[i][j]) < abs(A[best[0]][best[1]])):
                    best = (i, j)
        if best is None: break
        i, j = best
        A[t], A[i] = A[i], A[t]
        for r in A: r[t], r[j] = r[j], r[t]
        changed = True
        while changed:
            changed = False
            for i in range(t+1, rows_):
                if A[i][t]:
                    q = A[i][t] // A[t][t]
                    A[i] = [a - q*b for a, b in zip(A[i], A[t])]
                    if A[i][t]:
                        A[t], A[i] = A[i], A[t]; changed = True
            for j in range(t+1, cols):
                if A[t][j]:
                    q = A[t][j] // A[t][t]
                    for r in A: r[j] -= q*r[t]
                    if A[t][j]:
                        for r in A: r[t], r[j] = r[j], r[t]
                        changed = True
            if not changed:
                # divisibility condition
                bad = None
                for i in range(t+1, rows_):
                    for j in range(t+1, cols):
                        if A[i][j] % A[t][t]:
                            bad = (i, j); break
                    if bad: break
                if bad:
                    A[t] = [a + b for a, b in zip(A[t], A[bad[0]])]
                    changed = True
        inv.append(abs(A[t][t]))
        t += 1
    return inv

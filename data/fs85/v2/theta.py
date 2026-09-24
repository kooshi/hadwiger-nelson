"""Verifier 2: the character sets Theta_K, computed from their definition.

A character of a lattice M with Z-basis b_1..b_4 is t in (Q/Z)^4, theta(x) = sum t_i x_i in the b-coordinates of x.
Theta_K = { theta : for every family k in K some j in {0,1,2} has theta(z^j eta^k) = 1/2 }.
Method: pick four families whose chosen vectors are independent for every choice of j (asserted); for each of the 81 choices solve
A4 t = 1/2 (mod 1) exactly -- |det A4| solutions mod 1 -- then keep a solution iff every remaining family has some j with
theta(z^j eta^k) = 1/2.  Everything is integer arithmetic over the common denominator 2|det|.
"""
from itertools import product
from math import lcm
from fractions import Fraction as Fr
from lat import hnf_rows, det, inv, ULAM

def adjugate(M):
    n = len(M)
    def minor(i, j):
        return [[M[r][c] for c in range(n) if c != j] for r in range(n) if r != i]
    return [[int((-1) ** (i + j) * det(minor(j, i))) for j in range(n)] for i in range(n)]

def solve_first4(A4):
    """All t (as tuples of Fractions in [0,1)) with A4 t = 1/2 mod 1."""
    D = int(det(A4)); assert D != 0
    adj = adjugate(A4)       # A4^{-1} = adj / D
    AT = [[A4[i][j] for i in range(4)] for j in range(4)]
    H = hnf_rows(AT)
    diag = [H[i][i] for i in range(4)]
    assert abs(diag[0] * diag[1] * diag[2] * diag[3]) == abs(D)
    M = 2 * abs(D)
    sols = []
    for n in product(*[range(d) for d in diag]):
        # t = adj (1/2 + n) / D = adj (1 + 2n) / (2D)
        num = [sum(adj[i][j] * (1 + 2 * n[j]) for j in range(4)) for i in range(4)]
        if D < 0:
            num = [-x for x in num]
        sols.append(tuple(Fr(x % M, M) for x in num))
    return sols

def theta_set(K, coords, first=None):
    K = list(K)
    first = first or K[:4]
    rest = [k for k in K if k not in first]
    out = set()
    for js in product(range(3), repeat=4):
        A4 = [list(coords[(j, k)]) for j, k in zip(js, first)]
        for t in solve_first4(A4):
            ok = True
            for k in rest:
                if not any(sum(Fr(coords[(j, k)][i]) * t[i] for i in range(4)) % 1 == Fr(1, 2) for j in range(3)):
                    ok = False; break
            if ok:
                out.add(t)
    return out

def annihilated(Theta):
    """P(Theta) = { x in Z^4 : theta(x) in Z for all theta }, as a row HNF."""
    N = 1
    for t in Theta:
        for a in t:
            N = lcm(N, a.denominator)
    rows = [[int(a * N) for a in t] for t in Theta] + [[N * int(i == j) for j in range(4)] for i in range(4)]
    HL = hnf_rows(rows)
    assert len(HL) == 4
    HLi = inv(HL)
    Pcols = [[N * HLi[i][j] for i in range(4)] for j in range(4)]
    assert all(a.denominator == 1 for r in Pcols for a in r)
    return hnf_rows([[int(a) for a in r] for r in Pcols])

def order(t):
    o = 1
    for a in t:
        o = lcm(o, a.denominator)
    return o

def value(t, x):
    return sum(Fr(x[i]) * t[i] for i in range(4)) % 1

if __name__ == "__main__":
    from collections import Counter
    import time
    for name, K, first in [("|k|<=2", range(-2, 3), [0, 1, -1, 2]), ("all", range(-4, 5), [0, 1, -1, 2])]:
        t0 = time.time()
        Th = theta_set(K, ULAM, first)
        P = annihilated(Th)
        print(f"Theta_{name} on Lambda: |Theta| = {len(Th)}; P(Theta) = {P} (index {abs(det(P))}); "
              f"orders {sorted(Counter(order(t) for t in Th).items())}; {time.time() - t0:.1f}s")
        # direct re-check of the definition on every element (independent of the solving route)
        for t in Th:
            assert all(any(value(t, ULAM[(j, k)]) == Fr(1, 2) for j in range(3)) for k in K)

#!/usr/bin/env python3
"""J27V (FS-67 blind verifier): exact checks behind V-DB-2's level-one half.

UD(F_9, 2) = Cay(F_9^2, S), S = {(x, y) : x^2 + y^2 = 1}.  F_9 = F_3[i], i^2 = -1; an element is (a, b) = a + b i.
Checks, all exact integer arithmetic:
  C1  |S| = 8 and the F_3-span of S is all of F_9^2 (4-dimensional), so the Cayley graph is connected;
  C2  every eigenvalue lambda_psi = sum_{s in S} psi(s) (psi running over the 81 additive characters
      psi_{(a,b)}(x,y) = w^{Tr(a x + b y)}) is an integer n0 - n1 (S = -S), and lambda_min = -4 = -d/2
      (Hoffman-tight at three colours, d = 8);
  C3  the derived linear colouring c(x, y) = Tr((1 - i) u + i v), u = x + i y, v = x - i y, is nonzero on every
      point of S, hence a proper 3-colouring;
  C4  that colouring is gap-free (every closed neighbourhood meets all three colours), as G54 predicts.
--plant replaces the colouring by Tr(u + v), which the derivation says vanishes at t = i (u = i, v = -i); C3 must fail.
"""
import itertools, sys

P = 3
F9 = [(a, b) for a in range(3) for b in range(3)]
def add(z, w): return ((z[0] + w[0]) % P, (z[1] + w[1]) % P)
def neg(z): return ((-z[0]) % P, (-z[1]) % P)
def mul(z, w): return ((z[0] * w[0] - z[1] * w[1]) % P, (z[0] * w[1] + z[1] * w[0]) % P)
def frob(z): return (z[0], (-z[1]) % P)            # z^3 = conjugate
def tr(z):                                          # Tr(z) = z + z^3 = 2a in F_3
    t = add(z, frob(z)); assert t[1] == 0; return t[0]
ONE, I = (1, 0), (0, 1)
S = [(x, y) for x in F9 for y in F9 if add(mul(x, x), mul(y, y)) == ONE]

def span_dim(vecs):                                 # F_3-rank of vectors in F_9^2 viewed in F_3^4
    rows = [[v[0][0], v[0][1], v[1][0], v[1][1]] for v in vecs]
    r, col = 0, 0
    rows = [row[:] for row in rows]
    while r < len(rows) and col < 4:
        piv = next((j for j in range(r, len(rows)) if rows[j][col] % 3), None)
        if piv is None: col += 1; continue
        rows[r], rows[piv] = rows[piv], rows[r]
        inv = 1 if rows[r][col] == 1 else 2
        rows[r] = [(x * inv) % 3 for x in rows[r]]
        for j in range(len(rows)):
            if j != r and rows[j][col]:
                f = rows[j][col]; rows[j] = [(a - f * b) % 3 for a, b in zip(rows[j], rows[r])]
        r += 1; col += 1
    return r

def main(plant):
    ok = True
    d = len(S)
    c1 = d == 8 and span_dim(S) == 4
    print(f"C1 |S| = {d}, F_3-span dimension {span_dim(S)}: {'PASS' if c1 else 'FAIL'}"); ok &= c1
    eig = {}
    for a in F9:
        for b in F9:
            counts = [0, 0, 0]
            for (x, y) in S: counts[tr(add(mul(a, x), mul(b, y)))] += 1
            assert counts[1] == counts[2], "S = -S forces a real eigenvalue"
            eig[(a, b)] = counts[0] - counts[1]
    lmin = min(eig.values())
    spec = sorted(eig.values())
    c2 = eig[((0, 0), (0, 0))] == d and lmin * 2 == -d
    print(f"C2 spectrum {dict((v, spec.count(v)) for v in sorted(set(spec)))}; lambda_min = {lmin}: {'PASS' if c2 else 'FAIL'}"); ok &= c2
    def col(p):
        x, y = p; u = add(x, mul(I, y)); v = add(x, neg(mul(I, y)))
        if plant: return tr(add(u, v))
        return tr(add(mul(add(ONE, neg(I)), u), mul(I, v)))
    bad = [s for s in S if col(s) == 0]
    c3 = not bad
    print(f"C3 colouring nonzero on S (edges proper): {'PASS' if c3 else 'FAIL, zero at ' + str(bad)}"); ok &= c3
    pts = [(x, y) for x in F9 for y in F9]
    gaps = [p for p in pts if len({col(p)} | {col((add(p[0], s[0]), add(p[1], s[1]))) for s in S}) < 3]
    c4 = not gaps
    print(f"C4 gap-free: {'PASS' if c4 else f'FAIL at {len(gaps)} vertices'}"); ok &= c4
    return ok

if __name__ == "__main__":
    plant = "--plant" in sys.argv
    ok = main(plant)
    print("ALL PASS" if ok else "SOME CHECK FAILED")
    sys.exit(0 if ok else 1)

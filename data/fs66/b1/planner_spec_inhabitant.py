#!/usr/bin/env python3
"""PLANNER'S SCRATCH, NOT THE CHECKER.  Shows that the specification of plans/FS66-phase2-certificate.md §C (format
fs66-b1-cert-v2) has an inhabitant: it evaluates the identity (*) and the positive-definiteness condition on a prototype file,
straight from the specification's formulas.  It has no refusal codes, no controls and no self-test, and it was written by the
same agent as the producer prototype -- so its "OK" is evidence that the SPEC and the TEST INPUTS agree, nothing more.
IMPLEMENTER: do not port this; write tools/fs66_b1_cert_check.py from §C and §K.  Afterwards this file is a third program to
diff yours against.  Standard library only.  Usage: planner_spec_inhabitant.py CERT.json"""
import json, sys, itertools
from collections import defaultdict
c = json.load(open(sys.argv[1])); p = c["p"]; n = p * p
pts = [(a, b) for a in range(p) for b in range(p)]; ix = {z: i for i, z in enumerate(pts)}
S = [i for i, z in enumerate(pts) if (z[0] * z[0] + z[1] * z[1]) % p == 1]
add = [[ix[((a[0] + b[0]) % p, (a[1] + b[1]) % p)] for b in pts] for a in pts]
sub = [[ix[((a[0] - b[0]) % p, (a[1] - b[1]) % p)] for b in pts] for a in pts]
lin = []
for s in S:
    sa, sb = pts[s]
    lin.append([ix[((sa * a - sb * b) % p, (sa * b + sb * a) % p)] for (a, b) in pts])
    lin.append([ix[((sa * a + sb * b) % p, (-sa * b + sb * a) % p)] for (a, b) in pts])      # rotation after conjugation
for h in lin:                                                                                   # each is a symmetry
    assert sorted(h) == list(range(n)) and all(sub[h[add[x][s]]][h[x]] in S for x in range(n) for s in S)
memo = {}
def canon(m):
    m = tuple(sorted(m))
    if m not in memo:
        memo[m] = min((tuple(sorted(h[sub[i][b]] for i in m)) for b in set(m) for h in lin), default=())
    return memo[m]
def Y1(m): return {canon(m): 1}
qmemo = {}
def Yq(m):
    k = canon(m)
    if k not in qmemo:
        f = defaultdict(int)
        for x in range(n):
            f[canon(k + (x,))] += 2; f[canon(k + (x, x))] -= 2
            for s in S: f[canon(k + (x, add[x][s]))] -= 1
        qmemo[k] = dict(f)
    return qmemo[k]
reps = {"1": [(0,)] + [(sub[0][h], h) for h in range(n) if h <= sub[0][h]], "q": [(0,)]}
def pd(M):
    A = [r[:] for r in M]; prev = 1
    for k in range(len(A)):
        if A[k][k] <= 0: return False
        for i in range(k + 1, len(A)):
            for j in range(k + 1, len(A)): A[i][j] = (A[i][j] * A[k][k] - A[i][k] * A[k][j]) // prev
        prev = A[k][k]
    return True
assert c["scale"] > 0
rhs = defaultdict(int)
def put(form, coef):
    if coef:
        for k, v in form.items(): rhs[k] += coef * v
for bi, blk in enumerate(c["blocks"]):
    R, rp, Y = blk["R"], reps[blk["times"]], (Y1 if blk["times"] == "1" else Yq)
    assert len(R) == 1 + len(rp) and all(R[i][j] == R[j][i] for i in range(len(R)) for j in range(len(R))) and pd(R), f"block {bi}"
    for wi in blk["weights"]:
        w = c["weights"][wi]; c0, wv = w[0], w[1:]; sigma = sum(wv)
        kap = [sum(wv[x] * wv[add[x][t]] for x in range(n)) for t in range(n)]
        put(Y(()), R[0][0] * c0 * c0)
        for ia, a in enumerate(rp):
            put(Y(a), 2 * R[0][1 + ia] * c0 * sigma)
            for ib, b in enumerate(rp):
                if R[1 + ia][1 + ib]:
                    for t in range(n): put(Y(a + tuple(add[i][t] for i in b)), R[1 + ia][1 + ib] * kap[t])
for A, B, lam in c["rows"]:
    assert lam >= 0 and len(A) + len(B) <= 4
    for r in range(len(B) + 1):
        for T in itertools.combinations(range(len(B)), r):
            rhs[canon(tuple(A) + tuple(B[i] for i in T))] += (-1) ** r * lam
lhs = defaultdict(int); lhs[()] += c["U_num"]; lhs[canon((0,))] -= c["scale"] * n
bad = [k for k in set(lhs) | set(rhs) if lhs.get(k, 0) != rhs.get(k, 0)]
print(f"p={p}: blocks {len(c['blocks'])} all positive definite; rows {len(c['rows'])}; canonical monomials touched {len(rhs)}; "
      f"identity mismatches {len(bad)}{' first: ' + str(bad[0]) + ' ' + str(lhs.get(bad[0], 0)) + ' vs ' + str(rhs.get(bad[0], 0)) if bad else ''}; U = {c['U_num'] / c['scale']:.6f}")
print("OK: the specification has an inhabitant" if not bad else "MISMATCH")

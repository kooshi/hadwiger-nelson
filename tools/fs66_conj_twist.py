#!/usr/bin/env python3
"""FS-66 conjecture note, falsifier for Lemma T (twist-independence of the fibre-density inequality).

A *twisted level-two cover* of G_1 = UD(F_p,2): vertices (x,u) in F_p^2 x F_p^2; for each level-one edge x -> x+s,
(x,u) ~ (x+s,v) iff <v-u, s> = gamma(x,s), with gamma(x+s,-s) = -gamma(x,s).  gamma = the integer-addition carry gives
UD(Z/p^2, 2) itself (asserted below against a direct construction); gamma = 0 gives the equal-characteristic graph
UD(F_p[e]/e^2, 2), which contains G_1 as a section.  Lemma T says: for EVERY gamma the adjacency operator restricted to
the orthogonal complement of the fibre-constant functions has spectrum in [-2p, 2p].  This script checks that on random
gammas (numpy eigvalsh), and prints the extreme eigenvalues.  Usage: fs66_conj_twist.py P NTWISTS [seed]"""
import sys, random
import numpy as np

p = int(sys.argv[1]); nt = int(sys.argv[2]); rng = random.Random(int(sys.argv[3]) if len(sys.argv) > 3 else 0)
S = [(a, b) for a in range(p) for b in range(p) if (a*a + b*b) % p == 1]
half = []
for s in S:
    if ((-s[0]) % p, (-s[1]) % p) not in half: half.append(s)
V1 = [(x, y) for x in range(p) for y in range(p)]
def vid(x, u): return ((x[0]*p + x[1])*p + u[0])*p + u[1]
n = p**4

def build(gamma):
    A = np.zeros((n, n), dtype=np.float32)
    for x in V1:
        for s in half:
            y = ((x[0]+s[0]) % p, (x[1]+s[1]) % p); g = gamma[(x, s)]
            for u in V1:
                for v in V1:
                    if ((v[0]-u[0])*s[0] + (v[1]-u[1])*s[1] - g) % p == 0:
                        A[vid(x, u), vid(y, v)] = 1; A[vid(y, v), vid(x, u)] = 1
    return A

def direct():
    q = p*p
    S2 = [(a, b) for a in range(q) for b in range(q) if (a*a + b*b) % q == 1]
    A = np.zeros((n, n), dtype=np.float32)
    for x in V1:
        for u in V1:
            z = (x[0] + p*u[0], x[1] + p*u[1])
            for s in S2:
                w = ((z[0]+s[0]) % q, (z[1]+s[1]) % q)
                A[vid(x, u), vid((w[0] % p, w[1] % p), (w[0]//p, w[1]//p))] = 1
    return A

def carry_gamma():
    # integer representatives: x~ = x in [0,p)^2; s~ = any lift of s in S_2; carry from x~ + s~ = y~ + p*c
    q = p*p; gam = {}
    S2 = [(a, b) for a in range(q) for b in range(q) if (a*a + b*b) % q == 1]
    for s in half:
        st = next(t for t in S2 if t[0] % p == s[0] and t[1] % p == s[1])
        for x in V1:
            w = (x[0] + st[0], x[1] + st[1])                      # = y~ + p*c  (as integers, before reduction mod p^2)
            c = ((w[0] // p), (w[1] // p))                        # y~ = w mod p componentwise
            # (y~ + p v) - (x~ + p u) = st + p(v - u - c); unit iff <v-u-c, s> = 0 mod p
            gam[(x, s)] = (c[0]*s[0] + c[1]*s[1]) % p
    return gam

def report(name, A):
    assert (A.sum(axis=1) == p*(p+1)).all(), "not p(p+1)-regular"
    ev = np.linalg.eigvalsh(A.astype(np.float64))
    # level-one part: eigenvalues p*lambda_1 with multiplicities of G_1; remove them by projecting out fibre-constants
    P = np.zeros((n, p*p));
    for x in V1:
        for u in V1: P[vid(x, u), x[0]*p + x[1]] = 1/p
    Q = np.eye(n) - P @ P.T
    B = Q @ A.astype(np.float64) @ Q
    evB = np.linalg.eigvalsh(B)
    print(f"{name}: full spectrum in [{ev[0]:.4f}, {ev[-1]:.4f}]; off-level-one part in [{evB[0]:.4f}, {evB[-1]:.4f}]  (bound +-{2*p})", flush=True)
    assert evB[0] >= -2*p - 1e-6 and evB[-1] <= 2*p + 1e-6, "LEMMA T VIOLATED"

Aw = build(carry_gamma()); Ad = direct()
assert (Aw == Ad).all(), "carry twist does not reproduce UD(Z/p^2,2)"
print(f"p={p}: the carry twist reproduces UD(Z/{p*p},2) exactly ({int(Ad.sum())//2} edges)")
report("Witt/carry twist", Aw)
report("zero twist (equal characteristic)", build({(x, s): 0 for x in V1 for s in half}))
for t in range(nt):
    report(f"random twist {t}", build({(x, s): rng.randrange(p) for x in V1 for s in half}))
print("no violation")

#!/usr/bin/env python3
"""FS-86 verifier B1: an independent build of the dyadic local plane P_m = Cay(O/P^m, S_m), O = Z_2[zeta12], at EVEN levels
m = 2j (O/P^{2j} = O/2^j O = (Z/2^j)^4 in the basis 1, z, z^2, z^3; z^4 = z^2 - 1), which are the only levels a finite quotient
R/nR of Q(sqrt d)'s unit-vector ring produces (O/nO = O/P^{2 v_2(n)}).
S_m = {x : x * conj(x) = 1 mod 2^j}: the dyadic place is inert in L/F, the norm-one torus is smooth, so this is the image of
the local norm-one group (Hensel).  conj: z -> z^{-1} = z - z^3.
Checks (claims used by verifier B1's V3/VK, sourced independently of FS38-L1):
  (a) |S_m| = 3 * 2^(m-1);
  (b) lambda_min = -|S_m|/3 exactly (Hoffman ratio exactly 1/4: with four-colourability, alpha(P_m) = |P_m|/4);
  (c) every eigenvalue >= -|S_m|/3 (the unconditional half of FS38-L2 at every level up to m);
  (d) the minimising characters' common kernel H_min: {0} at m = 4 (45 minimisers), 4O/2^jO (= P^4/P^m) at m >= 6.
Plants: --plant  drops one +-pair from S (a reachable defect: the degree and the least eigenvalue move); (a) and (b) must FAIL.
        --plant5 uses z -> z^5 (the norm to Q_2(i) instead of Q_2(sqrt3)) -- recorded as an UNREACHABLE plant: that circle is
        another smooth unramified norm-one torus, with the same counts and the same tightness, so (a)-(d) all pass on it; kept
        to document that the plant was tried and why it cannot fire (G21: a control whose failure mode is unreachable)."""
import sys, itertools
import numpy as np

def mul(a, b, M):
    # a, b: length-4 int arrays of coefficients in basis 1,z,z^2,z^3 with z^4 = z^2 - 1
    c = [0]*7
    for i in range(4):
        for k in range(4):
            c[i+k] += a[i]*b[k]
    for e in range(6, 3, -1):   # z^e = z^(e-2) - z^(e-4)
        c[e-2] += c[e]; c[e-4] -= c[e]; c[e] = 0
    return tuple(x % M for x in c[:4])

def conj(a, M, plant=False):
    # z^-1 = z - z^3 ; powers: conj(z^k) = (z^-1)^k
    zi = (0, 1, 0, M-1)
    if plant == "z5":  # z -> z^5 = -z^{-1}: fixes i = z^3, negates sqrt3
        zi = (0, M-1, 0, 1)
    pw = [(1, 0, 0, 0)]
    for _ in range(3): pw.append(mul(pw[-1], zi, M))
    out = [0, 0, 0, 0]
    for k in range(4):
        for t in range(4):
            out[t] += a[k]*pw[k][t]
    return tuple(x % M for x in out)

def build(j, plant=False):
    M = 2**j
    S = []
    one = (1 % M, 0, 0, 0)
    for a in itertools.product(range(M), repeat=4):
        if mul(a, conj(a, M, plant), M) == one:
            S.append(a)
    if plant == "drop":
        s0 = next(x for x in S if x != one)
        neg = tuple((-c) % M for c in s0)
        S = [x for x in S if x not in (s0, neg)]
    ind = np.zeros((M,)*4)
    for s in S: ind[s] = 1.0
    lam = np.real(np.fft.fftn(ind))
    return M, S, lam

if __name__ == "__main__":
    plant = "drop" if "--plant" in sys.argv else ("z5" if "--plant5" in sys.argv else False)
    for j in ([1, 2] if plant else [1, 2, 3, 4]):
        m = 2*j
        M, S, lam = build(j, plant)
        d = len(S); thr = -d/3
        a_ok = d == 3 * 2**(m-1)
        lmin = lam.min()
        b_ok = abs(lmin - thr) < 1e-7
        c_ok = lmin >= thr - 1e-7
        mins = np.argwhere(np.abs(lam - lmin) < 1e-7)
        # common kernel of the minimising characters: x in (Z/M)^4 with <k, x> = 0 mod M for all minimisers k
        # (character k(x) = exp(-2 pi i <k,x>/M) in the FFT's convention; the dual pairing is the coefficient dot product)
        ker = [x for x in itertools.product(range(M), repeat=4) if all(int(np.dot(k, x)) % M == 0 for k in mins)]
        print(f"level m={m:2d} (O/2^{j}O, {M**4} vertices): |S|={d} (a){'PASS' if a_ok else 'FAIL'} "
              f"lambda_min={lmin:.9f} vs -d/3={thr:.9f} (b){'PASS' if b_ok else 'FAIL'} (c){'PASS' if c_ok else 'FAIL'} "
              f"#minimisers={len(mins)} |H_min|={len(ker)}"
              + (f" H_min==4O/2^jO:{'PASS' if set(ker)==set(x for x in itertools.product(range(M), repeat=4) if all(c % 4 == 0 for c in x)) else 'FAIL'}" if j >= 3 else ""))

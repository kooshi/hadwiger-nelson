#!/usr/bin/env python3
"""X26B: U_Q = Cay(F_{Q^2}, mu_{Q+1}) is 4-colourable at Q = 2, 4, 8, 16, 32 by an F_4-linear colouring.

A colouring by the four cosets of an F_4-hyperplane H_a = {x : Tr_{F_{Q^2}/F_4}(a x) = 0} is proper iff H_a meets mu_{Q+1} nowhere
(an edge x ~ x + u stays in one coset iff u in H_a). The extent is fixed by that derivation: the (Q^2 - 1)/3 hyperplanes, each counted
once (a and a*F_4^* give the same H). Complete enumeration at the ban's edge (logged); control: at Q = 32 the count must be 11 (G54:
eleven four-colourings, every maximum independent set an F_4-hyperplane). PLANT=1 uses mu_{Q-1}, which contains 1 in every... 
(1 lies in every mu_m, so the plant must use a set missing 1: the non-trivial coset g*mu_{Q+1}); it must change the Q = 32 count.
"""
import os, sys
sys.path.insert(0, os.path.dirname(__file__))
from x26b_spectra import field, add
PLANT = os.environ.get("PLANT") == "1"

def count(f):
    Q = 2 ** f
    n = 2 * f
    _, exp = field(2, n)
    N1 = 4 ** f - 1
    # Tr_{F_{Q^2}/F_4}(y) = sum_{i < f} y^{4^i}; F_4 = {0} U {g^{k N1/3}}
    def tr4(k):  # trace of g^k, as an element (tuple)
        s = tuple([0] * n)
        for i in range(f):
            s = add(s, exp[(k * 4 ** i) % N1], 2)
        return s
    zero = tuple([0] * n)
    T = [tr4(k) for k in range(N1)]
    step = Q - 1
    mu = [(m * step) % N1 for m in range(N1 // step)]
    if PLANT:
        mu.append(1)            # the plant: an extra element g (not in mu_{Q+1} for Q > 2); must change the Q = 32 count
    third = N1 // 3
    good = 0
    for j in range(third):          # a = g^j, j mod N1/3 represents a*F_4^*
        if all(T[(j + m) % N1] != zero for m in mu):
            good += 1
    # every F_2-codimension-2 subspace: V = <alpha, beta> in the dual (via x -> Tr_{F_{Q^2}/F_2}(v x)); proper iff for each u the
    # functional v -> Tr(v u) is non-zero on V, i.e. not both Tr(alpha u) = Tr(beta u) = 0. Each 2-dim V is counted once (3 bases up to order).
    good2 = 0
    if f <= 4:
        tr2 = [0] * N1
        for k in range(N1):
            s = tuple([0] * n)
            for i in range(n):
                s = add(s, exp[(k * 2 ** i) % N1], 2)
            tr2[k] = s[0]
        cnt = 0
        for ia in range(N1):
            for ib in range(ia + 1, N1):
                # skip V already counted: require ia < ib < index of alpha+beta
                sab = add(exp[ia], exp[ib], 2)
                ic = exp.index(sab)
                if ic < ib:
                    continue
                if all(tr2[(ia + m) % N1] or tr2[(ib + m) % N1] for m in mu):
                    good2 += 1
    return Q, good, good2

res = [count(f) for f in range(1, 6)]
for Q, g, g2 in res:
    print(f"Q={Q:3d}: F_4-hyperplanes avoiding mu_(Q+1): {g};  all F_2 codim-2 subspaces avoiding it: {g2 if Q <= 16 else 'not enumerated'}")
d = {Q: (g, g2) for Q, g, g2 in res}
ok = d[32][0] == 11 and all((g > 0) or (g2 not in (0, None) and g2 > 0) for Q, g, g2 in res)
print("CONTROL (Q=32 F_4-count = 11, G54):", ok)
print("ALL PASS" if ok else "FAILED")
sys.exit(0 if ok else 1)

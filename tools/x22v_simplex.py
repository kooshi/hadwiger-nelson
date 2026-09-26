#!/usr/bin/env python3
"""X22V exact check of the k-colour simplex identities used in SEL-k (stage 2), k = 2..8.

Claims checked, in exact rational arithmetic:
 (a) the Gram matrix G_k = (k/(k-1)) I - (1/(k-1)) J is positive semidefinite of rank k - 1 with unit diagonal,
     so unit vectors e_0..e_{k-1} in R^{k-1} with <e_i, e_j> = G_k[i][j] exist (the regular simplex);
 (b) for probability vectors p, q: <sum p_i e_i, sum q_j e_j> = (k/(k-1)) <p, q> - 1/(k-1);
 (c) hence, with h = E[g | A], sigma_hat(u) - sigma_E_hat(u) = -(k/(k-1)) E<p(0), p(u)> when c(0) != c(u)
     (sigma_hat(u) = -1/(k-1)), and sigma(R^) - sigma_E(R^) = (k/(k-1)) (1 - E<p(0), p(0)>):
     checked on random finite joint laws of (c(0), c(u), A-label) with c(0) != c(u), computing both sides exactly.

--plant uses off-diagonal -1/k in place of -1/(k-1); (a) or (c) must then fail, else the check is blind.
"""
import random
import sys
from fractions import Fraction as Fr


def gram(k, plant):
    off = Fr(-1, k) if plant else Fr(-1, k - 1)
    return [[Fr(1) if i == j else off for j in range(k)] for i in range(k)]


def rank_psd(G):
    # exact LDL^T; returns (rank, psd)
    n = len(G)
    A = [row[:] for row in G]
    rank, psd = 0, True
    for i in range(n):
        piv = A[i][i]
        if piv < 0:
            psd = False
        if piv == 0:
            if any(A[i][j] != 0 for j in range(i, n)):
                psd = False
            continue
        rank += 1
        for r in range(i + 1, n):
            f = A[r][i] / piv
            for c in range(i, n):
                A[r][c] -= f * A[i][c]
    return rank, psd


def ip(G, p, q):
    return sum(p[i] * G[i][j] * q[j] for i in range(len(p)) for j in range(len(q)))


def randprob(k, rng):
    w = [Fr(rng.randint(0, 5)) for _ in range(k)]
    if sum(w) == 0:
        w[rng.randrange(k)] = Fr(1)
    s = sum(w)
    return [x / s for x in w]


def main():
    plant = "--plant" in sys.argv
    rng = random.Random(22)
    fails = 0
    for k in range(2, 9):
        G = gram(k, plant)
        r, psd = rank_psd(G)
        if not (r == k - 1 and psd and all(G[i][i] == 1 for i in range(k))):
            print(f"k={k}: (a) FAILS: rank {r}, psd {psd}")
            fails += 1
        for _ in range(50):
            p, q = randprob(k, rng), randprob(k, rng)
            lhs = ip(G, p, q)
            rhs = Fr(k, k - 1) * sum(a * b for a, b in zip(p, q)) - Fr(1, k - 1)
            if lhs != rhs:
                fails += 1
                break
        # (c): a finite joint law: A-label a in {0..m-1}; given a, c(0) ~ p0[a], c(u) ~ p1[a] independently
        # is NOT enough (it need not have c(0) != c(u)); instead draw a joint law of (a, c0, c1) with c0 != c1,
        # and compute p0[a] = law(c0 | a), p1[a] = law(c1 | a).
        for _ in range(20):
            m = rng.randint(1, 3)
            joint = {}
            for a in range(m):
                for c0 in range(k):
                    for c1 in range(k):
                        if c0 != c1:
                            joint[(a, c0, c1)] = Fr(rng.randint(0, 3))
            tot = sum(joint.values())
            if tot == 0:
                continue
            joint = {key: v / tot for key, v in joint.items()}
            sigma_hat_u = sum(v * G[c0][c1] for (a, c0, c1), v in joint.items())      # E<g(0), g(u)>
            if not plant and sigma_hat_u != Fr(-1, k - 1):
                fails += 1
            pa = {a: sum(v for (b, _, _), v in joint.items() if b == a) for a in range(m)}
            E_hh, E_pp, E_pp0 = Fr(0), Fr(0), Fr(0)
            for a in range(m):
                if pa[a] == 0:
                    continue
                p0 = [sum(v for (b, c0, _), v in joint.items() if b == a and c0 == j) / pa[a] for j in range(k)]
                p1 = [sum(v for (b, _, c1), v in joint.items() if b == a and c1 == j) / pa[a] for j in range(k)]
                E_hh += pa[a] * ip(G, p0, p1)
                E_pp += pa[a] * sum(x * y for x, y in zip(p0, p1))
                E_pp0 += pa[a] * sum(x * x for x in p0)
            nonE_u = sigma_hat_u - E_hh
            if nonE_u != -Fr(k, k - 1) * E_pp:
                fails += 1
            # mass: E|g(0)|^2 - E|h(0)|^2 with h(0) = sum p0_j e_j
            mass_nonE = Fr(1) - (Fr(k, k - 1) * E_pp0 - Fr(1, k - 1))
            E_hh0 = Fr(0)
            for a in range(m):
                if pa[a] == 0:
                    continue
                p0 = [sum(v for (b, c0, _), v in joint.items() if b == a and c0 == j) / pa[a] for j in range(k)]
                E_hh0 += pa[a] * ip(G, p0, p0)
            if Fr(1) - E_hh0 != mass_nonE and not plant:
                fails += 1
    print("simplex identities:", "ALL HOLD" if fails == 0 else f"{fails} FAILURES")
    sys.exit(0 if fails == 0 else 1)


if __name__ == "__main__":
    main()

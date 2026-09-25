#!/usr/bin/env python3
"""J22 (crunch 2026-09-25), phase B2: exact checks behind the verdicts on J21's lemma statements.

Every check is exact integer or rational arithmetic; floats appear only in printed summaries.

  girth  Exoo's circulant F = Cay(Z_83, {+-2, +-22, +-25, +-34}) ([Zhu2025] Sec. 3) has odd girth exactly 7:
         the number of words of length L over S summing to 0 mod 83 is 0 for L = 1, 3, 5 and positive for L = 7
         (an odd closed walk of length L contains an odd cycle of length <= L).
  lex    F[K_q] equals Cay(Z_83 x Z_q, (S x Z_q) u ({0} x (Z_q - 0))), pair by pair, at q = 41.
  ratio  alpha(F[K_41]) / |F[K_41]| = alpha(F) / 3403 < 1/125 given alpha(F) = 27 (external: Exoo, via [Zhu2025]).
  h43    the fibre-share inequality's spectral relaxation at 43 is Hoffman's ratio, and B_1(43) is strictly below it:
         alpha(Gamma_43) <= 365 (row 69) < 1849 * Hoffman; and 365/1849 > 0.1974 (the displayed bound truncates).
  ng1    the geometry of the NG1 counterexample: hexagonal discs of radius r = 1/2 - d at spacing a = 2 + 2d, d = 1/100,
         are independent in UD(R^2) (a - 2r > 1), have density > 1/5 after removing one 7-disc cluster in every
         11 x 11 supercell, and the two small discs H1 = B(c0, 1/10), H2 = B(c0 + e1, 1/10) placed in a removed
         cluster are at distance > 1 from every remaining disc.

Usage: crunch_j22_b2_checks.py [--plant NAME]   (NAME in girth, lex, ratio, h43, ng1; exit 2 when a check fails)
"""
import sys
from fractions import Fraction as Q

N83 = 83
S0 = [2, 22, 25, 34]


def conn(S):
    return sorted({s % N83 for s in S} | {(-s) % N83 for s in S})


def zero_sum_words(S, L, n=N83):
    dist = [0] * n
    dist[0] = 1
    for _ in range(L):
        new = [0] * n
        for x, c in enumerate(dist):
            if c:
                for s in S:
                    new[(x + s) % n] += c
        dist = new
    return dist[0]


def check_girth(S):
    counts = {L: zero_sum_words(S, L) for L in (1, 3, 5, 7)}
    print(f"girth: connection set {S}; zero-sum words by length {counts}")
    ok = counts[1] == counts[3] == counts[5] == 0 and counts[7] > 0
    print("girth:", "PASS (odd girth exactly 7)" if ok else "CHECK girth FAILED (odd girth not 7)")
    return ok


def check_lex(S, q=41, drop_clique=False):
    Sset = set(S)
    # Cayley connection set on Z_83 x Z_q
    C = {(s, j) for s in Sset for j in range(q)}
    if not drop_clique:
        C |= {(0, j) for j in range(1, q)}
    bad = 0
    for x in range(N83):
        for i in range(q):
            for y in range(N83):
                dx = (y - x) % N83
                in_S = dx in Sset
                for j in range(q):
                    lex = in_S or (dx == 0 and i != j)
                    cay = (dx, (j - i) % q) in C
                    if lex != cay:
                        bad += 1
    sym = all(((-a) % N83, (-b) % q) in C for (a, b) in C) and (0, 0) not in C
    print(f"lex: q = {q}, |C| = {len(C)}, symmetric and loopless: {sym}, mismatched ordered pairs: {bad}")
    ok = bad == 0 and sym
    print("lex:", "PASS (F[K_q] is an abelian Cayley graph)" if ok else "CHECK lex FAILED")
    return ok


def check_ratio(alphaF=27, q=41, n=125):
    lhs, rhs = alphaF * n, N83 * q
    print(f"ratio: alpha(F[K_{q}])/|F[K_{q}]| = {alphaF}/{N83 * q}; compare {alphaF}*{n} = {lhs} with {rhs}")
    ok = lhs < rhs
    print("ratio:", "PASS (< 1/125)" if ok else "CHECK ratio FAILED")
    return ok


def check_h43(alpha_cert=365):
    # lambda_min(Gamma_43) in [-11.9622301225972, -11.9622301225971] (data/m3/j22/spectrum-p43.out, exact isolating
    # interval); Hoffman ratio h = |l|/(44 + |l|) is increasing in |l|, so the lower end gives a lower bound.
    l_lo = Q(119622301225971, 10 ** 13)
    h_lo = l_lo / (44 + l_lo)
    n = 43 * 43
    strict = alpha_cert < n * h_lo
    trunc = Q(alpha_cert, n) > Q(1974, 10000)
    print(f"h43: Hoffman ratio >= {float(h_lo):.12f}, 1849*Hoffman >= {float(n * h_lo):.4f}; certified alpha <= {alpha_cert}")
    print(f"h43: {alpha_cert}/1849 = {float(Q(alpha_cert, n)):.8f}; exceeds the displayed 0.1974: {trunc}")
    ok = strict and trunc
    print("h43:", "PASS (B_1(43) < Hoffman strictly; the display truncates)" if ok else "CHECK h43 FAILED")
    return ok


def check_ng1(d=Q(1, 100), Nsup=11):
    PI_LO, R3_LO, R3_HI = Q(314159, 100000), Q(17320, 10000), Q(17321, 10000)
    a, r = 2 + 2 * d, Q(1, 2) - d
    indep = a - 2 * r > 1 and 2 * r < 1
    # hexagonal lattice cell area (sqrt3/2) a^2; density pi r^2 / cell, lower bound with pi low and sqrt3 high
    dens_lo = PI_LO * r * r / (R3_HI / 2 * a * a)
    dens_after = dens_lo * (1 - Q(7, Nsup * Nsup))
    # after removing the centre disc and its six neighbours, the nearest remaining centres are at sqrt3 * a;
    # points of H1 u H2 lie within 1 + 1/10 of c0
    gap_lo = R3_LO * a - r - Q(11, 10)
    ok = indep and dens_after > Q(1, 5) and gap_lo > 1
    print(f"ng1: a = {a}, r = {r}; a - 2r = {a - 2 * r} (> 1: {a - 2 * r > 1}); density >= {float(dens_lo):.5f}, "
          f"after 7/{Nsup * Nsup} removal >= {float(dens_after):.5f} (> 1/5: {dens_after > Q(1, 5)}); "
          f"H-to-disc distance >= {float(gap_lo):.4f} (> 1: {gap_lo > 1})")
    print("ng1:", "PASS" if ok else "CHECK ng1 FAILED")
    return ok


def main(argv):
    plant = None
    if len(argv) == 3 and argv[1] == "--plant":
        plant = argv[2]
    elif len(argv) != 1:
        print(__doc__)
        return 2
    S = conn(S0 + ([4] if plant == "girth" else []))  # plant: 2 + 2 - 4 = 0 is a triangle
    results = [
        check_girth(S),
        check_lex(conn(S0), drop_clique=(plant == "lex")),
        check_ratio(alphaF=28 if plant == "ratio" else 27),
        check_h43(alpha_cert=396 if plant == "h43" else 365),
        check_ng1(d=Q(1, 10) if plant == "ng1" else Q(1, 100)),
    ]
    ok = all(results)
    print("ALL PASS" if ok else "SOME CHECK FAILED", f"(plant: {plant})")
    return 0 if ok else 2


if __name__ == "__main__":
    sys.exit(main(sys.argv))

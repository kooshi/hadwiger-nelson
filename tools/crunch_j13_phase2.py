#!/usr/bin/env python3
"""Crunch job J13, phase 2: exact checks of J12's stated lemmas that phase 1 did not already cover.

Record: plans/FS91-S1V-one-prime.md (Stage 3).  Output: data/fs91/j13/phase2.txt (written even on a null).
Reuses the arithmetic of tools/crunch_j13_check.py (J13's own tool).

  E1  J12-B1's centre set at p = 5: the admissible centres (those c with Q0 meeting R_c^{-1}(Q0)) among the whole
      lattice ((1-i)/6) Z[i] -- which is exactly the set of centres of steps with digit in pi^{-1} Z[i] -- within the
      only range that can meet Q0 (|X|, |Y| <= 4 in units of 1/6), by exact separating-axis tests.  Expect C9.
  E2  J12-C3's instance list: every pair 1 <= a, b <= 10, the two inequalities exactly; the orders; J12-C4's divisibility;
      and, independently, the band on U_5 mod N for each listed character.  Compare with J12's printed list.
Plants: E1 with the rotation (3+4i)/5 (a small angle) in place of omega must admit more centres than C9;
(the first plant tried, w-bar in place of omega, returned C9 as well: it could not fire, and was replaced);
E2 with the first inequality's radius 1/12 replaced by 1/13 must drop pairs.
"""
import sys, os
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
from crunch_j13_check import G, F, I, P, V0, QUARTER, prime_data, check_member, in_band, fracpart, lcm, reduce_mod, torsion_value

J12_PAIRS = [(1, 5), (1, 10), (2, 5), (2, 10), (3, 5), (4, 5), (4, 10), (6, 5), (6, 10), (7, 5), (7, 10), (9, 5), (9, 10), (10, 5)]
J12_ORDERS = [234, 9111, 498, 20592, 224, 3834, 152886, 6074, 236096, 20592, 848643, 50962, 2029123, 56142]

def square(c=G(0)):
    q = QUARTER
    return [c + G(q, q), c + G(-q, q), c + G(-q, -q), c + G(q, -q)]

def polys_meet(A, B):
    """Exact separating-axis test for two convex polygons (vertex lists)."""
    for poly in (A, B):
        n = len(poly)
        for j in range(n):
            e = poly[(j + 1) % n] - poly[j]
            ax = G(-e.im, e.re)
            pa = [(ax.conj() * v).re for v in A]; pb = [(ax.conj() * v).re for v in B]
            if max(pa) < min(pb) or max(pb) < min(pa):
                return False
    return True

def admissible_centres(omega):
    out = []
    for X in range(-4, 5):
        for Y in range(-4, 5):
            if (X - Y) % 2: continue
            c = G(F(X, 6), F(Y, 6))
            # R_c(z) = c + omega (z - c); R_c^{-1}(Q0) = c + omega^{-1}(Q0 - c)
            pre = [c + omega.inv() * (v - c) for v in square()]
            if polys_meet(square(), pre):
                out.append(c)
    return out

def pair_data(a, b, d, r1=F(1, 12)):
    om = d["betabar"]; c0 = V0
    x = om ** a; y = om ** b
    # composite of c0^a then 0^b: z -> y*(c0 + x (z - c0)); fixed point Q''
    Qpp = (y * (1 - x) * c0) / (1 - x * y)
    Ra = c0 + x * (Qpp - c0)
    ok1 = (Qpp - c0).norm() <= r1 * r1
    ok2 = Ra.norm() <= F(1, 16)
    return Qpp, Ra, ok1, ok2

def main():
    out = []; say = out.append
    d5 = prime_data(5)
    C9 = sorted([(F(0), F(0)), (F(1, 6), F(1, 6)), (F(1, 6), F(-1, 6)), (F(-1, 6), F(1, 6)), (F(-1, 6), F(-1, 6)),
                 (F(1, 3), F(0)), (F(-1, 3), F(0)), (F(0), F(1, 3)), (F(0), F(-1, 3))])
    got = sorted([(c.re, c.im) for c in admissible_centres(d5["betabar"])])
    e1 = (got == C9)
    say(f"E1 admissible centres at p=5 (omega = {d5['betabar']}): {[(str(a), str(b)) for a, b in got]}")
    say(f"E1 equals J12's C9: {e1}")
    say("== E2: J12-C3 instances, 1 <= a, b <= 10 ==")
    found = []
    for a in range(1, 11):
        for b in range(1, 11):
            Qpp, Ra, ok1, ok2 = pair_data(a, b, d5)
            if ok1 and ok2:
                found.append((a, b))
    say(f"pairs found: {found}")
    same_pairs = (found == J12_PAIRS)
    say(f"equal to J12's list: {same_pairs}")
    orders_ok = True; band_ok = True; div_ok = True
    for (a, b), Nj in zip(J12_PAIRS, J12_ORDERS):
        Qpp, Ra, ok1, ok2 = pair_data(a, b, d5)
        e0 = P + Qpp
        N = lcm(e0.re.denominator, e0.im.denominator)
        L = a + b
        pi = d5["pi"]
        DL = pi ** L - ((-I) ** L) * (pi.conj() ** L)
        nm = int(DL.norm())
        div = (2 * nm) % N == 0
        # independent band check on U_5 mod N (J13's own routine, orbit model not used)
        # iterate w until the pair (tau(w^m), tau(i w^m)) returns
        wN = reduce_mod(d5["w"], N, 5)
        def mul(u, v): return ((u[0]*v[0] - u[1]*v[1]) % N, (u[0]*v[1] + u[1]*v[0]) % N)
        xx = (1 % N, 0); iN = (0, 1 % N)
        start = (torsion_value(e0, xx, N), torsion_value(e0, mul(iN, xx), N)); per = None; bnd = True
        for m in range(0, 50 * L + 100):
            vals = (torsion_value(e0, xx, N), torsion_value(e0, mul(iN, xx), N))
            if m > 0 and vals == start: per = m; break
            bnd = bnd and all(in_band(v) for v in vals)
            xx = mul(wN, xx)
        say(f"(a,b)=({a},{b}): N={N} J12 says {Nj} {'=' if N == Nj else 'DIFFERS'}; N | 2Nm(D_L): {div}; "
            f"band on U mod N: {bnd and per is not None} (tau-period {per}); N^2 > a+b: {N * N > a + b}")
        orders_ok = orders_ok and N == Nj; band_ok = band_ok and bnd and per is not None; div_ok = div_ok and div
    say(f"E2 orders equal: {orders_ok}; all band: {band_ok}; C4 divisibility: {div_ok}")
    # plants
    got_bad = sorted([(c.re, c.im) for c in admissible_centres(G(F(3, 5), F(4, 5)))])
    p1 = (got_bad != C9)
    say(f"PLANT E1' (rotation (3+4i)/5, angle 53 deg in place of omega's 143 deg): centres {[(str(a), str(b)) for a, b in got_bad]}; differs from C9: {p1}")
    found13 = [(a, b) for a in range(1, 11) for b in range(1, 11) if all(pair_data(a, b, d5, r1=F(1, 13))[2:])]
    p2 = set(found13) < set(J12_PAIRS)
    say(f"PLANT E2' (radius 1/13): pairs {found13}; a proper subset of J12's: {p2}")
    verdict = e1 and same_pairs and orders_ok and band_ok and div_ok and p1 and p2
    say(f"OVERALL: {'PASS' if verdict else 'FAIL'}")
    os.makedirs("data/fs91/j13", exist_ok=True)
    with open("data/fs91/j13/phase2.txt", "w") as f:
        f.write("\n".join(out) + "\n")
    print("\n".join(out))
    return 0 if verdict else 1

if __name__ == "__main__":
    sys.exit(main())

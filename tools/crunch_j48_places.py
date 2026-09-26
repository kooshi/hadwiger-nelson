#!/usr/bin/env python3
"""J48 (FS-100 stage 1 blind check): the stable places of Q(sqrt 167) and Q(sqrt 11) and their level-one mixing constants.

What it checks (each a derived claim of plans/FS100-BC-verification.md, stage 2):

  (P1) the splitting of every prime p < BOUND in F = Q(sqrt d) and then in L = F(i): a place v of F is STABLE iff i is not in F_v.
       For odd p not dividing d: v | p has residue field F_p (p split in F) or F_{p^2} (p inert); i lies in F_v iff -1 is a square in
       the residue field, i.e. iff p = 1 (mod 4) or the residue field is F_{p^2}.  For p | d (odd, ramified in F): residue field F_p,
       stable iff p = 3 (mod 4).  At 2 (d = 3 mod 4, so 2 ramifies in F): i in Q_2(sqrt d) iff -d is a 2-adic square iff -d = 1 (mod 8).
  (P2) for every stable place with residue field F_p of F (p = 3 mod 4), the level-one mixing constant
       lambda*_1(p) = max_{a != 0} |sum_{t in mu_{p+1}} e(Tr(a t)/p)| / (p+1)   on  Gamma_p = Cay(F_{p^2}, mu_{p+1}),
       computed with RIGOROUS interval arithmetic (mpmath.iv), compared with 1/3 (k = 4) and 1/4 (k = 5).  The value depends on a only
       through N(a) (the circle is invariant under multiplication by mu_{p+1}), so one a per norm class suffices; all p^2 - 1 values of a
       are enumerated anyway for p <= 43 as a cross-check of that reduction.
  (P3) the higher-level bound 2/(p+1) (FS86-LP / M3-J22-T8 as an input) against the same thresholds.

Controls: the values at 23, 43, 59 must reproduce M3-J22-T2's recorded 0.3317, 0.2719 and M3-J22-T1's 0.2486262833630 to the digits
printed; the dyadic place of Q(sqrt 11) must come out stable and of Q(sqrt 167) split (J21-D1-2: F_v = Q_2(i)).

Plants (--plant NAME): each must make the run FAIL, at its own check.
  drop-point   remove one point of the circle before summing  -> the recorded-value controls fail
  wrong-trace  drop the -beta*y term of Tr(a t) = 2(alpha x - beta y) -> the recorded-value controls fail
               (a first version dropped the factor 2 instead; that plant could not fire, because a -> 2a permutes the non-zero a and
               the maximum is unchanged -- kept here as a record of an unreachable plant, G21)
  dyadic-167   claim -d = 1 (mod 8) is tested as d = 1 (mod 8)  -> the dyadic control fails
Exit status 0 iff every check passes.  Run: python3 tools/crunch_j48_places.py [--plant NAME]
"""
import sys
from mpmath import iv, mpf

iv.dps = 40
BOUND = 200
PLANT = sys.argv[sys.argv.index("--plant") + 1] if "--plant" in sys.argv else None


def legendre(a, p):
    a %= p
    if a == 0:
        return 0
    return 1 if pow(a, (p - 1) // 2, p) == 1 else -1


def primes(n):
    s = [True] * n
    s[0] = s[1] = False
    for i in range(2, int(n ** 0.5) + 1):
        if s[i]:
            for j in range(i * i, n, i):
                s[j] = False
    return [i for i in range(n) if s[i]]


def places(d):
    """Return a list of (p, count, residue_size_of_F, stable) for p < BOUND."""
    out = []
    for p in primes(BOUND):
        if p == 2:
            # d = 3 (mod 4): 2 ramifies in Q(sqrt d); one place, residue F_2.
            assert d % 4 == 3
            test = (d % 8 == 1) if PLANT == "dyadic-167" else ((-d) % 8 == 1)
            out.append((2, 1, 2, not test))
            continue
        if d % p == 0:
            out.append((p, 1, p, p % 4 == 3))
            continue
        if legendre(d, p) == 1:
            out.append((p, 2, p, p % 4 == 3))
        else:
            out.append((p, 1, p * p, False))  # residue F_{p^2} contains i
    return out


def circle(p):
    """The norm-one elements x + iy of F_{p^2} = F_p[i] (p = 3 mod 4)."""
    pts = [(x, y) for x in range(p) for y in range(p) if (x * x + y * y) % p == 1]
    assert len(pts) == p + 1
    if PLANT == "drop-point":
        pts = pts[1:]
    return pts


def eigen_iv(p, a, pts):
    """sum_t e(Tr(a t)/p) with Tr(a t) = 2 Re(a t) = 2(alpha x - beta y); returns an mpmath interval (real part; imag is 0 by t -> conj t)."""
    al, be = a
    s = iv.mpf(0)
    for (x, y) in pts:
        if PLANT == "wrong-trace":
            tr = (2 * al * x) % p
        else:
            tr = (2 * (al * x - be * y)) % p
        s += iv.cos(2 * iv.pi * tr / p)
    return s


def lam_star(p, full=False):
    pts = circle(p)
    best = iv.mpf(0)
    by_norm = {}
    rng = [(al, be) for al in range(p) for be in range(p) if (al, be) != (0, 0)]
    for a in rng:
        n = (a[0] ** 2 + a[1] ** 2) % p
        if n in by_norm and not full:
            continue
        v = abs(eigen_iv(p, a, pts))
        if n in by_norm and full:
            # the reduction to norm classes: every a of one norm gives the same |value| (up to interval width)
            w = by_norm[n]
            assert abs(float(v.mid) - float(w.mid)) < 1e-20 or PLANT is not None, (p, a, v, w)
        by_norm.setdefault(n, v)
    # max over classes, as an interval upper/lower bound
    lo = max(float(v.a) for v in by_norm.values())
    hi = max(float(v.b) for v in by_norm.values())
    return lo / (p + 1), hi / (p + 1)


def main():
    ok = True
    report = []
    for d in (167, 11):
        pl = places(d)
        stable = [(p, c, q) for (p, c, q, s) in pl if s]
        report.append(f"Q(sqrt {d}): stable places below {BOUND} (p, number of places, residue size of F): {stable}")
        dy = [s for (p, c, q, s) in pl if p == 2][0]
        want = (d == 11)  # stable at 2 for Q(sqrt 11), split for Q(sqrt 167)
        if dy != want:
            ok = False
            report.append(f"  FAIL dyadic control for d = {d}: stable = {dy}, expected {want}")
    # P2 at the stable residue-degree-one primes of both fields that matter, plus 67 (Weil region) and 7, 11, 19
    recorded = {23: 0.3317, 43: 0.2719, 59: 0.2486262833630}
    for p in (7, 11, 19, 23, 43, 59, 67):
        lo, hi = lam_star(p, full=(p <= 43))
        t4 = "< 1/3 (4-thick at level one)" if hi < 1 / 3 else ("> 1/3" if lo > 1 / 3 else "UNDECIDED vs 1/3")
        t5 = "< 1/4 (5-thick at level one)" if hi < 1 / 4 else ("> 1/4" if lo > 1 / 4 else "UNDECIDED vs 1/4")
        report.append(f"  lambda*_1({p}) in [{lo:.12f}, {hi:.12f}]   {t4};  {t5};  higher levels <= 2/(p+1) = {2/(p+1):.4f}")
        if p in recorded:
            r = recorded[p]
            digits = 4 if p != 59 else 12
            if abs(round(lo, digits) - r) > 10 ** (-digits) * 0.6:
                ok = False
                report.append(f"  FAIL control: recorded {r}, computed {lo}")
    print("\n".join(report))
    print("ALL CHECKS PASS" if ok else "SOME CHECK FAILED")
    sys.exit(0 if ok else 1)


if __name__ == "__main__":
    main()

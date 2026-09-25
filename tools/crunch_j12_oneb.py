#!/usr/bin/env python3
"""J12 (FS-91, crunch 2026-09-25) -- ONE-b: the rotating-frame nine-centre model of Theta_4(R_5), and the first levels of the
hierarchy of band periodic orbits whose limit carries a minimal set outside T + A.

Derived claims checked (plans/FS91-S1D-one-prime.md, Stage 3):
  B1  In the frame e'_m = conj(i)^m e_m (generator u = i w, w = (3+4i)/5, pi = 2+i), z_m := lift(e'_m) - P in
      Q0 = [-1/4, 1/4]^2 satisfies z_{m+1} = c_m + omega (z_m - c_m), omega = conj(u) = (-4-3i)/5, with c_m in the nine
      centres C9 = {0, (+-1+-i)/6, +-1/3, +-i/3}.  Checked: (i) the complete set of kicks g in pi^{-1}Z[i] with |g|^2 <= 1/2
      (a in Z[i], |a|^2 <= 2: 9 elements) maps to exactly C9 under g -> g/(1-omega); (ii) (1-omega)P in pi^{-1}Z[i];
      (iii) the ONE-a heteroclinic at p = 5 (tools/crunch_j12_onea.py's construction, re-derived here with pi = 2+i),
      converted to the rotating frame, has centre sequence -(1+i)/6 on m >= 0 and 0 on m < 0.
  CL  (closing lemma, two-leaf form) For leaves with phase-0 points Q_n, Q_{n-1}, margins r_n, r_{n-1} and block rotations
      Omega_n = omega^{|W_n|}, the word W_n^a W_{n-1}^b closes at Q = fixed point of R_{n-1}^b R_n^a; if |Q - Q_n| <= r_n and
      |R_n^a Q - Q_{n-1}| <= r_{n-1}, the periodic orbit is admissible (a band torsion character).
      Checked: for every (a, b) in the box 2 <= a, b <= B (a complete enumeration of a finite set the derivation fixes), the
      sufficient condition is evaluated exactly; every pair it admits is then verified DIRECTLY (the orbit iterated exactly,
      every point in Q0, exact return to Q); its exact margin is recorded.  Levels 2 and 3 of the hierarchy.
Plants:
  P1  frame plant: the non-rotating frame (e_m not rotated, omega replaced by conj(w)): the heteroclinic's forward centre sequence is no
      longer constant (the X3 leaf moves in that frame) -- the B1(iii) check must fail on the forward side only.
  P2  margin plant: the X3 leaf's margin taken as 1/6 (true value 1/12): the sufficient condition admits pairs whose direct
      orbit check fails -- the direct check must fire on at least one admitted pair, and no pair admitted with the true
      margin may fail it.
Exit 0 iff all faithful checks pass and both plants fire for their reasons.
"""
from fractions import Fraction as Fr
import sys, time

sys.path.insert(0, __file__.rsplit("/", 1)[0])
from crunch_j12_onea import G, I, re_pair, frac1  # exact Gaussian rationals (J12's own tool)

PI = G(2, 1)
W = PI / PI.conj()                 # (3+4i)/5
U = I * W                          # generator of the rotating frame
OMEGA = U.conj()                   # (-4-3i)/5
P = G(Fr(1, 2), Fr(1, 2))
QUARTER = Fr(1, 4)


def centres_from_kicks():
    ks = []
    for x in range(-2, 3):
        for y in range(-2, 3):
            if x * x + y * y <= 2:
                ks.append(G(x, y) / PI)
    return sorted({(c.a, c.b) for c in (g / (G(1) - OMEGA) for g in ks)})


C9 = sorted({(Fr(0), Fr(0))} | {(Fr(s, 6), Fr(t, 6)) for s in (-1, 1) for t in (-1, 1)}
            | {(Fr(1, 3), Fr(0)), (Fr(-1, 3), Fr(0)), (Fr(0), Fr(1, 3)), (Fr(0), Fr(-1, 3))})


def in_pi_inv_lattice(x):
    return (PI * x).is_gauss_int()


def lift_sym(x):  # representative of x mod 1 in [-1/2, 1/2)
    y = frac1(x + Fr(1, 2)) - Fr(1, 2)
    return y


def heteroclinic_centres(omega, rotate=True, M=30):
    """ONE-a's character at p=5 with pi=2+i; its layer data e_m (original frame), rotated by conj(i)^m, z_m, centres."""
    C = G(Fr(1, 3), Fr(1, 3))
    d_back = C - P
    p = 5

    def mod3(u):
        n, y = 0, u
        while not y.is_gauss_int():
            y, n = y * p, n + 1
        f = pow(pow(p % 3, -1, 3), n, 3)
        return G((int(y.a) * f) % 3, (int(y.b) * f) % 3)

    def theta(u, m):
        return frac1(re_pair(C, mod3(u))) if m >= 0 else frac1(Fr(1, 2) + re_pair(d_back, u))

    z = {}
    for m in range(-M, M + 1):
        wm = W ** m
        e = G(theta(wm, m), theta(I * wm, m))
        ep = (I.conj() ** m) * e if rotate else e
        zz = G(lift_sym(ep.a - P.a), lift_sym(ep.b - P.b))
        assert abs(zz.a) <= QUARTER and abs(zz.b) <= QUARTER, (m, zz)
        z[m] = zz
    cs = {}
    for m in range(-M, M):
        g = z[m + 1] - omega * z[m]
        cs[m] = (g / (G(1) - omega), in_pi_inv_lattice(g))
    return cs


def compose(word):
    """composite of the rotations about the centres in `word` (applied left to right): z -> A z + t."""
    A, t = G(1), G(0)
    for c in word:
        cc = G(c[0], c[1])
        A, t = OMEGA * A, OMEGA * t + (G(1) - OMEGA) * cc
    return A, t


def orbit(word, z0):
    pts, z = [], z0
    for c in word:
        pts.append(z)
        cc = G(c[0], c[1])
        z = cc + OMEGA * (z - cc)
    return pts, z


def margin(pts):
    return min(QUARTER - max(abs(q.a), abs(q.b)) for q in pts)


def level(prev, cur, B, r_override=None):
    """enumerate (a, b), 2 <= a, b <= B, for W = cur.word^a prev.word^b; return admitted pairs with direct checks."""
    Wn, Qn, rn = cur
    Wm, Qm, rm = prev
    if r_override is not None:
        rn, rm = r_override(rn, rm)
    An, tn = compose(Wn)
    out = []
    for a in range(2, B + 1):
        Ana = An ** a
        for b in range(2, B + 1):
            word = Wn * a + Wm * b
            A, t = compose(word)
            Q = t / (G(1) - A)
            RaQ = Qn + Ana * (Q - Qn)
            suff = (Q - Qn).norm() <= rn * rn and (RaQ - Qm).norm() <= rm * rm
            if not suff:
                continue
            pts, back = orbit(word, Q)
            direct = (back == Q) and all(abs(q.a) <= QUARTER and abs(q.b) <= QUARTER for q in pts)
            out.append((a, b, Q, direct, margin(pts) if direct else None, len(word)))
    return out


def main():
    lines, ok = [], True
    # B1 (i), (ii)
    cfk = centres_from_kicks()
    b1i = cfk == C9
    b1ii = in_pi_inv_lattice((G(1) - OMEGA) * P)
    b1pi = (PI * (G(1) - OMEGA)) == G(3, 3)
    lines.append(f"B1(i) kicks |a|^2<=2 -> centres == C9: {b1i} ({len(cfk)} centres)")
    lines.append(f"B1(ii) (1-omega)P in pi^-1 Z[i]: {b1ii};  pi(1-omega) = 3(1+i): {b1pi}")
    ok &= b1i and b1ii and b1pi
    # B1 (iii)
    cs = heteroclinic_centres(OMEGA)
    c0 = G(Fr(-1, 6), Fr(-1, 6))
    fwd = all(cs[m][0] == c0 and cs[m][1] for m in cs if m >= 0)
    bwd = all(cs[m][0] == G(0) and cs[m][1] for m in cs if m < 0)
    lines.append(f"B1(iii) heteroclinic centres: forward all -(1+i)/6: {fwd}; backward all 0: {bwd}")
    ok &= fwd and bwd
    # P1: frame plant
    cs1 = heteroclinic_centres(W.conj(), rotate=False)
    fwd1 = all(cs1[m][0] == cs1[0][0] for m in cs1 if m >= 0)
    bwd1 = all(cs1[m][0] == cs1[-1][0] for m in cs1 if m < 0)
    p1 = (not fwd1) and bwd1
    lines.append(f"P1 frame plant (non-rotating frame): forward constant: {fwd1}; backward constant: {bwd1} -> "
                 f"{'FIRES (forward only, its reason)' if p1 else 'DID NOT FIRE AS NAMED'}")
    ok &= p1
    # hierarchy: level 0 parity, level 1 X3
    L0 = ([(Fr(0), Fr(0))], G(0), QUARTER)
    L1 = ([(Fr(-1, 6), Fr(-1, 6))], c0, Fr(1, 12))
    t0 = time.time()
    lev2 = level(L0, L1, 12)
    good2 = [x for x in lev2 if x[3]]
    lines.append(f"level 2 (W2 = c^a 0^b, 2<=a,b<=12): admitted {len(lev2)}, direct-verified {len(good2)}, "
                 f"failed {len(lev2) - len(good2)}")
    ok &= len(good2) == len(lev2) and len(good2) > 0
    for (a, b, Q, d, mg, L) in good2[:8]:
        lines.append(f"   a={a} b={b} |W|={L} Q={Q} margin={mg}")
    # level 3 from the first level-2 member with the largest exact margin
    best = max(good2, key=lambda x: x[4])
    a2, b2, Q2, _, r2, L2 = best
    W2 = L1[0] * a2 + L0[0] * b2
    lines.append(f"level-2 member used for level 3: a={a2} b={b2} |W2|={L2} margin={r2}")
    L2t = (W2, Q2, r2)
    lev3 = level(L1, L2t, 6)
    good3 = [x for x in lev3 if x[3]]
    lines.append(f"level 3 (W3 = W2^a W1^b, 2<=a,b<=6): admitted {len(lev3)}, direct-verified {len(good3)}, "
                 f"failed {len(lev3) - len(good3)}")
    ok &= len(good3) == len(lev3) and len(good3) > 0
    for (a, b, Q, d, mg, L) in good3[:6]:
        lines.append(f"   a={a} b={b} |W3|={L} margin={mg}")
    # P2: margin plant on level 2 (X3 margin 1/6)
    lev2p = level(L0, L1, 12, r_override=lambda rn, rm: (Fr(1, 6), rm))
    bad = [x for x in lev2p if not x[3]]
    true_admitted = {(x[0], x[1]) for x in lev2}
    bad_true = [x for x in bad if (x[0], x[1]) in true_admitted]
    p2 = len(bad) > 0 and not bad_true
    lines.append(f"P2 margin plant (X3 margin 1/6): admitted {len(lev2p)}, direct failures {len(bad)}, "
                 f"of which admitted under the true margin {len(bad_true)} -> {'FIRES (its reason)' if p2 else 'DID NOT FIRE AS NAMED'}")
    ok &= p2
    lines.append(f"time {time.time() - t0:.1f}s")
    lines.append("ALL PASS" if ok else "SOME CHECK FAILED")
    out = "\n".join(lines)
    print(out)
    if len(sys.argv) > 1:
        open(sys.argv[1], "w").write(out + "\n")
    sys.exit(0 if ok else 1)


if __name__ == "__main__":
    main()

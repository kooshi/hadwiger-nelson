#!/usr/bin/env python3
"""FS114-Y5 stage 2: exact checks at named values of the inequalities FS114-Y5-PIN120-60 rests on (plans/FS114-Y5-construction.md §2.2).
The proofs are the derivations (for every small germ); these checks confirm the inequalities at named points with germ WEDGES: a wedge at a vertex q
with sector [d1, d2] (counter-clockwise) and radius 1/5 is the region q -> q + d1/5 -> (arc about q) -> q + d2/5 -> q.  A probe is a triangle of size
1/1000 at a named point.  Every verdict is FS114-YB's pair() (REJECT iff min < 1 < max), imported unedited.  Coordinates (all in Q(sqrt3), h = sqrt3/2):
p = 0, q_a = e(300), q_b = e(60), q_c = e(120), q_d = e(240), r = q_a + q_b = e(0); the probes near r are r + e(psi)/100 at the sector midpoints
S0 (0), S_b (60), S_pb (120), S_pab (180), S_pa (240), S_a (300).

Predictions registered here before the first run:
STEP 1 (tiles at p near r)
  A1  |p + e(210)/100 - r|^2 > 1  (t_B, with direction 210 at p, cannot contain r)                                 -> TRUE
  A2  probes S0, S_a, S_b vs the t_B-wedge [210, 330] at p                                                          -> REJECT each
  A3  the same three probes vs the t_C-wedge [330, 30] and the t_D-wedge [30, 150] at p                            -> REJECT each
  A4  control: the same three probes vs the t_A-wedge [150, 210] at p (alternating member: A free near r)          -> ACCEPT each
STEP 3 (q_b's inner gap has one colour, alpha_C = 60)
  B1  the G-wedge [150, 270] at q_b vs the I_c-wedge [210, 216.87] at q_c (one colour)                              -> REJECT
  B2  control: a wedge [300, 330] at q_b (away from q_c) vs the I_c-wedge                                           -> ACCEPT
  B3  probes S0, S_pa, S_pab, S_b vs the G-wedge (g blocked at every sector of r)                                   -> REJECT each
  B4  control: the away-only wedge [150, 196.26] at q_b vs probe S_pa (outside B(q_b, 1))                           -> ACCEPT
STEP 5 (O_b)
  C1  the O_b-wedge [330, 337.38] at q_b vs probe S_pa (O_b of K's colour straddles K)                            -> REJECT
  C2  the O_b-wedge vs probe S0 (colour A blocked in S0 by O_b)                                                     -> REJECT
  C3  control: the O_b-wedge vs probe S_b (inside B(q_b, 1): A allowed there, as O_b itself)                        -> ACCEPT
  C4  alpha_A = 90: the t_A-wedge [120, 210] at p vs a probe at q_b + e(343.74)/100 (colour A blocked at q_b's gap) -> REJECT
  C5  control, alpha_A = 60: the t_A-wedge [150, 210] vs the same probe                                             -> ACCEPT
STEP 6 (I_a)
  D1  the I_a-wedge [30, 36.87] at q_a vs probe S0 (outside B(q_a, 1))                                               -> REJECT
  D2  control: the I_a-wedge vs probe S_pa (inside B(q_a, 1))                                                       -> ACCEPT
STEP 7 (points 60 degrees apart, one just inside the ring, one just outside)
  E1  f(d, d') = (1-d)^2 + (1+d')^2 - (1-d)(1+d') at d = 1/100: f(d, 0) < 1 < f(d, 2/100) (distance exactly 1 between) -> TRUE
STEP 10 (the crescent)
  F1  |w_b - w_c|^2 < 1 at beta_b = beta_c = 30 degrees  (w_b = q_b + e(270), w_c = q_c + e(330))                   -> TRUE
  F2  |w_b - w_c|^2 < 1 at beta_b = beta_c = 53.13 degrees (w_b = q_b + e(293.13), w_c = q_c + e(353.13))            -> TRUE
  F3  |w_b - w_c|^2 < 1 at beta_b = 53.13, beta_c = 16.26 degrees                                                   -> TRUE
PLANT (beside the faithful twin): the G-wedge replaced by the away-only wedge makes B3's probe S0 ACCEPT (the "both" block is what fires), and
F1 with q_c moved to e(90) (alpha_C = 30, not a pinwheel) is registered only as arithmetic: |w_b - w_c|^2 changes, the verdict is not claimed.
Run: python3 tools/fs114_y5_pin.py
"""
from __future__ import annotations
import os
import sys
from fractions import Fraction as Fr

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs114_yb_exact as X   # noqa: E402  (FS114-YB's checker, unedited)

Seg, Arc, Tile = X.Seg, X.Arc, X.Tile
vadd, vmul, vsub, n2 = X.vadd, X.vmul, X.vsub, X.n2
T = X.Tower.base().extend(3, "3")
r3 = T.gen(1)
h = r3 / 2
H = Fr(1, 2)


def P(x, y):
    return (x if isinstance(x, X.Num) else T(x), y if isinstance(y, X.Num) else T(y))


def rot(v, c, s):
    """rotate the vector v by the angle with cosine c and sine s (exact)."""
    return (v[0] * c - v[1] * s, v[0] * s + v[1] * c)


E = {0: P(1, 0), 30: P(h, H), 60: P(H, h), 90: P(0, 1), 120: P(-H, h), 150: P(-h, H), 180: P(-1, 0), 210: P(-h, -H), 240: P(-H, -h),
     270: P(0, -1), 300: P(H, -h), 330: P(h, -H)}
p, qa, qb, qc, qd, r = P(0, 0), E[300], E[60], E[120], E[240], E[0]


def wedge(name, q, d1, d2, rad=Fr(1, 5)):
    R = T(rad)
    a, b = vadd(q, vmul(R, d1)), vadd(q, vmul(R, d2))
    return Tile(name, 0, [Seg(q, a), Arc(q, R, a, b, True), Seg(b, q)])


def probe(at, s=Fr(1, 1000)):
    return Tile("probe", 0, [Seg(vadd(at, P(s, 0)), vadd(at, P(0, s))), Seg(vadd(at, P(0, s)), vadd(at, P(-s, -s))),
                             Seg(vadd(at, P(-s, -s)), vadd(at, P(s, 0)))])


def verdict(A, B):
    return "REJECT" if X.pair(A, B).reject else "ACCEPT"


def main(plant=None):
    out = []
    ok_all = True

    def rec(tag, got, want):
        nonlocal ok_all
        ok = got == want
        ok_all &= ok
        out.append(f"{tag}: {got} (registered {want}) {'as registered' if ok else '*** NOT AS REGISTERED ***'}")

    c = Fr(1, 100)
    pr = {k: probe(vadd(r, vmul(T(c), E[a]))) for k, a in (("S0", 0), ("S_b", 60), ("S_pb", 120), ("S_pab", 180), ("S_pa", 240), ("S_a", 300))}
    # step 1
    z = vmul(T(c), E[210])
    rec("A1 |p + e(210)/100 - r|^2 > 1", "TRUE" if (n2(vsub(z, r)) - 1).sign() > 0 else "FALSE", "TRUE")
    tB = wedge("tB", p, E[210], E[330])
    tC = wedge("tC", p, E[330], E[30])
    tD = wedge("tD", p, E[30], E[150])
    tA = wedge("tA", p, E[150], E[210])
    for k in ("S0", "S_a", "S_b"):
        rec(f"A2 probe {k} vs t_B-wedge", verdict(pr[k], tB), "REJECT")
        rec(f"A3 probe {k} vs t_C-wedge", verdict(pr[k], tC), "REJECT")
        rec(f"A3 probe {k} vs t_D-wedge", verdict(pr[k], tD), "REJECT")
        rec(f"A4 probe {k} vs t_A-wedge (control)", verdict(pr[k], tA), "ACCEPT")
    # step 3
    d19626 = P(Fr(-24, 25), Fr(-7, 25))            # 196.26 degrees
    d21687 = P(Fr(-4, 5), Fr(-3, 5))               # 216.87 degrees
    G = wedge("G", qb, E[150], E[270])
    Gaway = wedge("Gaway", qb, E[150], d19626)
    Ic = wedge("Ic", qc, E[210], d21687)
    rec("B1 G-wedge vs I_c-wedge", verdict(G, Ic), "REJECT")
    rec("B2 wedge [300,330] at q_b vs I_c-wedge (control)", verdict(wedge("w", qb, E[300], E[330]), Ic), "ACCEPT")
    Guse = Gaway if plant == "g_away" else G
    for k in ("S0", "S_pa", "S_pab", "S_b"):
        rec(f"B3 probe {k} vs G-wedge", verdict(pr[k], Guse), "REJECT")
    rec("B4 away-only wedge vs probe S_pa (control)", verdict(pr["S_pa"], Gaway), "ACCEPT")
    # step 5
    d33738 = P(Fr(12, 13), Fr(-5, 13))            # 337.38 degrees
    d34374 = P(Fr(24, 25), Fr(-7, 25))             # 343.74 degrees
    Ob = wedge("Ob", qb, E[330], d33738)
    rec("C1 O_b-wedge vs probe S_pa", verdict(pr["S_pa"], Ob), "REJECT")
    rec("C2 O_b-wedge vs probe S0", verdict(pr["S0"], Ob), "REJECT")
    rec("C3 O_b-wedge vs probe S_b (control)", verdict(pr["S_b"], Ob), "ACCEPT")
    pgap = probe(vadd(qb, vmul(T(c), d34374)))
    rec("C4 alpha_A = 90: t_A-wedge [120,210] vs probe at q_b's gap", verdict(pgap, wedge("tA90", p, E[120], E[210])), "REJECT")
    rec("C5 alpha_A = 60: t_A-wedge [150,210] vs the same probe (control)", verdict(pgap, tA), "ACCEPT")
    # step 6
    Ia = wedge("Ia", qa, E[30], P(Fr(4, 5), Fr(3, 5)))
    rec("D1 I_a-wedge vs probe S0", verdict(pr["S0"], Ia), "REJECT")
    rec("D2 I_a-wedge vs probe S_pa (control)", verdict(pr["S_pa"], Ia), "ACCEPT")
    # step 7
    d = Fr(1, 100)

    def f(dd):
        return (1 - d) ** 2 + (1 + dd) ** 2 - (1 - d) * (1 + dd)
    rec("E1 f(d,0) < 1 < f(d,2/100)", "TRUE" if f(Fr(0)) < 1 < f(Fr(2, 100)) else "FALSE", "TRUE")
    # step 10
    c3, s3 = Fr(3, 5), Fr(4, 5)                     # 53.13 degrees
    c1, s1 = Fr(24, 25), Fr(7, 25)                  # 16.26 degrees
    qc_use = E[90] if plant == "qc90" else qc
    for tag, wb, wc in (("F1 beta 30/30", vadd(qb, E[270]), vadd(qc_use, E[330])),
                        ("F2 beta 53.13/53.13", vadd(qb, rot(E[240], c3, s3)), vadd(qc_use, rot(E[300], c3, s3))),
                        ("F3 beta 53.13/16.26", vadd(qb, rot(E[240], c3, s3)), vadd(qc_use, rot(E[300], c1, s1)))):
        v = n2(vsub(wb, wc))
        rec(f"{tag}: |w_b - w_c|^2 = {float(v):.6f} < 1", "TRUE" if (v - 1).sign() < 0 else "FALSE", "TRUE")
    return out, ok_all


if __name__ == "__main__":
    pl = sys.argv[1] if len(sys.argv) > 1 else None
    lines, ok = main(pl)
    print(f"plant: {pl}")
    print("\n".join(lines))
    print("ALL AS REGISTERED" if ok else "NOT ALL AS REGISTERED")
    sys.exit(0 if ok else 1)

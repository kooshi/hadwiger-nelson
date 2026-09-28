#!/usr/bin/env python3
"""FS114-Y5 stage 4: exact checks at named values of the inequalities FS114-Y5-PXKILL rests on (plans/FS114-Y5-construction.md §4), in P_90's
frame for k = 1: p = 0, q_1 = e(90) = (0, 1), q_2 = e(180), q_4 = e(0), v_1 = e(60), v_2 = e(150); all points in Q(sqrt3).  Tiles are germ WEDGES
(sector of radius 1/5 at a vertex, counter-clockwise) or small named polygons with one unit arc; probes are triangles of size 1/1000.  Verdicts are
FS114-YB's pair(), imported unedited: REJECT iff min < 1 < max.  The proofs are the derivations; these checks confirm them at named values.

Predictions registered here before the first run:
PX-1 (just outside the ring clockwise of q_1, at angle 90 - 11.42 degrees, only colour k - 1 = 4 is free)
  P1  the probe vs the t_1-, t_2-, t_3-wedges at p ([270,360], [0,90], [90,180])                                   -> REJECT each
  P2  control: the probe vs the t_4-wedge at p ([180,270])                                                         -> ACCEPT
LAMBDA (v_1 = e(60)):
  L1  |q_4 - v_1|^2 = 1 exactly (T_4 and O_1 tight); |q_1 - v_1|^2 < 1 (colour m-bar excluded at q_1's outside)      -> TRUE, TRUE
V2 (the sectors at v_2 = e(150): (60,120) inside B(q_1, 1) outside the ring; (120,240) outside both)
  V1  a T_1-wedge at q_1, sector [36.87, 120], vs a probe at v_2 + e(90)/100                                        -> REJECT (colour 1 blocked there)
  V2  control: the same wedge vs a probe at v_2 + e(180)/100                                                         -> ACCEPT (colour 1 free: O_2)
KILL (T_1 borders mu_1 along omega(v_2) from q_1 outward; O_2 borders mu_1 along omega(q_1) from v_2 outward; both colour 1)
  K1  T = q_1 -> Q -> P -> (arc of omega(v_2), clockwise) -> q_1 with P = v_2 + e(46.26), Q = q_1 + e(60)/5;
      O = v_2 -> (arc of omega(q_1), clockwise) -> P' -> Q' -> v_2 with P' = q_1 + e(193.74), Q' = v_2 + e(180)/5          -> REJECT
  K2  control: T against a wedge at v_2 with sector [150, 210] (pointing away from q_1)                              -> ACCEPT
PLANT (beside the faithful twin): O's arc taken INTO the disc (P' = q_1 + e(226.26), arc counter-clockwise from v_2): the pair (T, O)
  is registered ACCEPT -- the outward direction of both arcs is what fires (distance^2 = 1 + 2tt' inward, 1 - 2tt' outward).
Run: python3 tools/fs114_y5_px.py [inward]
"""
from __future__ import annotations
import os
import sys
from fractions import Fraction as Fr

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs114_yb_exact as X   # noqa: E402  (FS114-YB's checker, unedited)
import fs114_y5_pin as Y     # noqa: E402  (this job's stage-2 helpers: P, E, rot, wedge, probe)

Seg, Arc, Tile = X.Seg, X.Arc, X.Tile
vadd, vmul, vsub, n2 = X.vadd, X.vmul, X.vsub, X.n2
T, P, E, rot, wedge, probe = Y.T, Y.P, Y.E, Y.rot, Y.wedge, Y.probe
p = P(0, 0)
q1, q2, q4, v1, v2 = E[90], E[180], E[0], E[60], E[150]


def verdict(A, B):
    return "REJECT" if X.pair(A, B).reject else "ACCEPT"


def main(plant=None):
    out, ok_all = [], True

    def rec(tag, got, want):
        nonlocal ok_all
        ok = got == want
        ok_all &= ok
        out.append(f"{tag}: {got} (registered {want}) {'as registered' if ok else '*** NOT AS REGISTERED ***'}")

    # PX-1
    dsm = rot(E[90], Fr(99, 101), Fr(-20, 101))                 # 90 - 11.42 degrees
    pr = probe(vmul(T(Fr(101, 100)), dsm))
    for nm, a, b in (("t_1", 270, 0), ("t_2", 0, 90), ("t_3", 90, 180)):
        rec(f"P1 probe vs {nm}-wedge", verdict(pr, wedge(nm, p, E[a], E[b])), "REJECT")
    rec("P2 probe vs t_4-wedge (control)", verdict(pr, wedge("t_4", p, E[180], E[270])), "ACCEPT")
    # LAMBDA
    rec("L1 |q_4 - v_1|^2 = 1", "TRUE" if (n2(vsub(q4, v1)) - 1).is0() else "FALSE", "TRUE")
    rec("L1 |q_1 - v_1|^2 < 1", "TRUE" if (n2(vsub(q1, v1)) - 1).sign() < 0 else "FALSE", "TRUE")
    # V2
    T1w = wedge("T1w", q1, P(Fr(4, 5), Fr(3, 5)), E[120])
    rec("V1 T_1-wedge vs probe v_2 + e(90)/100", verdict(probe(vadd(v2, vmul(T(Fr(1, 100)), E[90]))), T1w), "REJECT")
    rec("V2 T_1-wedge vs probe v_2 + e(180)/100 (control)", verdict(probe(vadd(v2, vmul(T(Fr(1, 100)), E[180]))), T1w), "ACCEPT")
    # KILL
    c1, s1 = Fr(24, 25), Fr(7, 25)                             # 16.26 degrees
    Pp = vadd(v2, rot(E[30], c1, s1))                          # v_2 + e(46.26): on omega(v_2)
    Q = vadd(q1, vmul(T(Fr(1, 5)), E[60]))
    Ttile = Tile("T", 1, [Seg(q1, Q), Seg(Q, Pp), Arc(v2, T(1), Pp, q1, False)])
    if plant == "inward":
        Pq = vadd(q1, rot(E[210], c1, s1))                     # q_1 + e(226.26): into the disc
        Oarc = Arc(q1, T(1), v2, Pq, True)
    else:
        Pq = vadd(q1, rot(E[210], c1, -s1))                    # q_1 + e(193.74): outward
        Oarc = Arc(q1, T(1), v2, Pq, False)
    Qp = vadd(v2, vmul(T(Fr(1, 5)), E[180]))
    Otile = Tile("O", 1, [Oarc, Seg(Pq, Qp), Seg(Qp, v2)])
    want = "ACCEPT" if plant == "inward" else "REJECT"
    r = X.pair(Ttile, Otile)
    rec(f"K1 T vs O (both colour 1){' [plant inward]' if plant else ''}", "REJECT" if r.reject else "ACCEPT", want)
    out.append(f"   K1 detail: min<1 {r.min_lt1}, max>1 {r.max_gt1}, min=1 {r.min_eq1}")
    rec("K2 T vs wedge at v_2 [150,210] (control)", verdict(Ttile, wedge("aw", v2, E[150], E[210])), "ACCEPT")
    return out, ok_all


if __name__ == "__main__":
    pl = sys.argv[1] if len(sys.argv) > 1 else None
    lines, ok = main(pl)
    print(f"plant: {pl}")
    print("\n".join(lines))
    print("ALL AS REGISTERED" if ok else "NOT ALL AS REGISTERED")
    sys.exit(0 if ok else 1)

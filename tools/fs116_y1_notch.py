#!/usr/bin/env python3
"""FS116-Y1 stage 3: the exact facts FS116-Y1-NOTCH rests on (Y-QRING's strip family: the notch colours are forced).

  Q_0 = (1/4, Y), Q_-1 = (-1/4, Y), Y = sqrt3/2 + sqrt15/4, the capped strip's stop points next to P_0 (|Q| = phi^2/sqrt2).
  (1) |Q_0 - V_0| = |Q_0 - V_1| = 1 and |Q_-1 - V_-1| = |Q_-1 - V_0| = 1, exactly (the valleys whose wedges carry the forced colours R, O, M);
  (2) the direction u from a valley V to its notch point has dot(u, e(30)) > 0 and dot(u, e(150)) > 0 (so every direction of the valley's wedge,
      (30, 150) degrees, lies within 90 degrees of u), and dot(u, t) = 0 for the cone's edge direction t at the notch (the tangent of the unit circle
      about V there), with dot(u, e(90)) > 0 (so every direction strictly inside the notch's cone lies within 90 degrees of u);
  (3) at the named notch points n = Q + (0, 1/200) (inside the cone, and within distance phi^2/sqrt2 + 1/100 of P_0), the three arch colours are
      blocked by arches of the strip: a named point of the closed arch at distance < 1 from n and one at distance > 1 (U_0, U_1, U_-1 at Q_0;
      U_-1, U_0, U_-2 at Q_-1); the near witnesses of U_1, U_-1 (and their mirrors) sit just inside the top arc, at 0.995 of the way from the
      arc's centre toward the notch, where the arc passes within 0.99 of n;
  (4) the colours of the two valley wedges at each notch are the strip's R and O at Q_0 and M and R at Q_-1, so the forced notch colours are M at Q_0
      and O at Q_-1 (the sixth colour each time).
Plant (--plant high): the named notch points raised to height Y + 1/20, above the height (about 1.854) where U_-1's and U_1's nearest points pass
distance 1: fact (3) fails at Q_0 (B and G no longer blocked there).
Run: python3 tools/fs116_y1_notch.py [--plant high]
"""
from __future__ import annotations
import os
import sys
from fractions import Fraction as Fr

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs114_yb_exact as X      # noqa: E402  (unedited)
import fs114_yb_objects as O    # noqa: E402  (unedited)

vadd, vsub, n2, dot = X.vadd, X.vsub, X.n2, X.dot


def blocks(n, t, wn, wf):
    inn = X.inside(wn, t) >= 0 and X.inside(wf, t) >= 0
    return inn and (n2(vsub(n, wn)) - 1).sign() < 0 and (n2(vsub(n, wf)) - 1).sign() > 0


def main():
    plant = sys.argv[sys.argv.index("--plant") + 1] if "--plant" in sys.argv else None
    S = O.Strip(capped=True)
    T, q = S.T, S.q
    tiles = {t.name: t for t in S.tiles(-4, 3)}
    r3 = T.gen(1)
    Y = S.Y
    Q0, Qm = (q(Fr(1, 4)), Y), (q(Fr(-1, 4)), Y)
    ok = True
    f1 = all((n2(vsub(a, b)) - 1).is0() for a, b in ((Q0, S.V(0)), (Q0, S.V(1)), (Qm, S.V(-1)), (Qm, S.V(0))))
    print(f"(1) |Q_0 - V_0| = |Q_0 - V_1| = |Q_-1 - V_-1| = |Q_-1 - V_0| = 1 exactly: {f1}")
    ok &= f1
    e30, e150, e90 = (r3 / 2, q(Fr(1, 2))), (-r3 / 2, q(Fr(1, 2))), (q(0), q(1))
    f2 = True
    for Qn, V in ((Q0, S.V(0)), (Q0, S.V(1)), (Qm, S.V(-1)), (Qm, S.V(0))):
        u = vsub(Qn, V)
        tng = (-u[1], u[0])
        f2 &= dot(u, e30).sign() > 0 and dot(u, e150).sign() > 0 and dot(u, tng).is0() and dot(u, e90).sign() > 0
    print(f"(2) every wedge direction and every cone direction within 90 degrees of the valley-to-notch direction: {f2}")
    ok &= f2
    h = Fr(1, 20) if plant == "high" else Fr(1, 200)
    n0, nm = (Q0[0], Y + h), (Qm[0], Y + h)
    # witnesses: near = on the arch's top arc facing the notch (exact points of the tower), far = near the arch's bottom corner, inside
    W0 = {"U0": ((q(Fr(1, 4)), S.g - Fr(1, 100)), (q(Fr(1, 100)), q(Fr(1, 100)))),
          "U1": ((q(Fr(623, 1000)), q(Fr(921, 1000))), (q(Fr(99, 100)), q(Fr(1, 100)))),
          "U-1": ((q(Fr(-123, 1000)), q(Fr(921, 1000))), (q(Fr(-49, 100)), q(Fr(1, 100))))}
    Wm = {"U-1": ((q(Fr(-1, 4)), S.g - Fr(1, 100)), (q(Fr(-1, 100)), q(Fr(1, 100)))),
          "U0": ((q(Fr(123, 1000)), q(Fr(921, 1000))), (q(Fr(49, 100)), q(Fr(1, 100)))),
          "U-2": ((q(Fr(-623, 1000)), q(Fr(921, 1000))), (q(Fr(-99, 100)), q(Fr(1, 100))))}
    for lbl, n, Wd in (("Q_0", n0, W0), ("Q_-1", nm, Wm)):
        cols = set()
        for nm_, (wn, wf) in Wd.items():
            b = blocks(n, tiles[nm_], wn, wf)
            print(f"(3) at {lbl} + (0, {h}): {nm_} ({tiles[nm_].colour}) {'blocks' if b else 'DOES NOT BLOCK'}")
            ok &= b
            if b:
                cols.add(tiles[nm_].colour)
        ok &= cols == {"P", "G", "B"}
        print(f"    arch colours blocked at {lbl}: {sorted(cols)}; within phi^2/sqrt2 + 1/100 of P_0: {(n2(n) - (Y * Y + Fr(1, 16) + Fr(1, 25))).sign() < 0}")
    # (4) wedge colours: the strip's top tiles over the valleys carry the forced wedge colours (FS114-Y-STRIPRIGID)
    wc = {m: tiles[f"T{m}"].colour for m in (-1, 0, 1)}
    f4 = wc[0] == "R" and wc[1] == "O" and wc[-1] == "M"
    rest0 = {"M", "R", "O"} - {wc[0], wc[1]}
    restm = {"M", "R", "O"} - {wc[-1], wc[0]}
    print(f"(4) wedge colours V_-1 {wc[-1]}, V_0 {wc[0]}, V_1 {wc[1]}; forced notch colour at Q_0: {sorted(rest0)}, at Q_-1: {sorted(restm)}")
    ok &= f4 and rest0 == {"M"} and restm == {"O"}
    print(f"=> {'ALL HOLD' if ok else 'FAILS'}")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())

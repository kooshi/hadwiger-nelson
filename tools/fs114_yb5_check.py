#!/usr/bin/env python3
"""FS114-YB5: exact checks, at named values, of the inequalities my stage-1b derivations rest on (E1 of the pinwheel, E2's 60-degree
lemma, the Reuleaux half).  Arithmetic is exact in Q(sqrt 3): a number is a + b*sqrt3 with Fraction a, b; its sign is decided exactly
(a^2 against 3 b^2).  Directions are e(30 k degrees) times rational Pythagorean rotations R40 = (399/401, 40/401) (about 5.72 deg),
R20 = (99/101, 20/101) (about 11.42 deg), R37 = (4/5, 3/5) (about 36.87 deg).  Every verdict compares a squared distance with 1 and prints
'<1', '=1' or '>1'; a check PASSES iff the verdict is the one registered below, written before the first run.

Registered predictions (frame of stage 1a.3: phi_1 = 0, q1 = e(0), q4 = w1 = e(300), C = e(240); E2 lemma and HALF frames as named):
  CTL-brick   diagonal of a 4/5 x 3/5 cell                                           =1
  CTL-hex     diameter of the side-1/2 hexagon                                        =1
  CTL-reul    |q1 - q4| (the width-1 Reuleaux triangle p, q4, q1)                      =1
  F1a/F1b     p + e(240 -+ 5.72)/100 against q1: in the cap, outside B(q1,1)           >1, >1
  F1c         p + e(270 + 5.72)/100 against q1 (inside B(q1,1): not t_1's)             <1
  F1d         p + e(210 - 5.72)/100 against q4 (outside the cap's corner cone)         >1
  F2          alpha_2 = 120: edge-2 point q2 + e(300 + 5.72), q2 = e(120), against q4  >1
  O1          Z = q4 + e(210 + 5.72)/100 against w4 = q4 + e(120 + 36.87)             <1
  O2          Z against t_3's point p + e(0 + 5.72)/10 (alpha_2 = 90: t_3 starts at 0) <1
  O3          Z against q1  (q1 not in cl Omega)                                       >1
  K1          Z1 = q1 + e(270 + 5.72)/100 against q4                                  <1
  K2a/K2b     (101/100) e(330) against q4 and q1 (in the lens)                         <1, <1
  K2c         (101/100) e(330) against q1 + q4 (lens minus B(p,1) inside B(q1+q4,1))   <1
  K3a         t_4 direction 90 - 5.72: p + e(84.28)/100 against q1                     <1
  K3b         t_4 direction 210 + 5.72: p + e(215.72)/100 against q4                   <1
  K3c         control, direction 150: p + e(150)/100 against q1 and q4                 >1, >1
  X1a/X1b     X = q1 + e(60)/100 against q4 and against Omega's point Z               >1, >1
  X2          V = q4 + e(330 + 5.72)/100 against q1                                   <1
  X3a/X3b     alpha_2 = 90: |v2 - q2|, |v2 - v3|, v2 = e(60), q2 = e(90), v3 = e(150)  <1, >1
  R1          E2 lemma, Reul(p, qc, r), qc = e(60), r = e(0): the midpoints of the
              arcs p-qc (centre r) and qc-r (centre p), both non-corners               <1
  R2          corner r against the arc p-qc's midpoint                                =1
  H1a/H1b     HALF, t2 with cone 60 (edge about q1): s e(120 - 5.72), s = 1/4,
              against q1 (outside B(q1,1): not in t2) and q3 = e(210) (outside B(q3,1)) >1, >1
  H2          theta_3 = 240: t4's point e(240 + 5.72)/4 against q2 = e(-30)          >1
  H3          theta_3 = 240 + 11.42: t4's point e(270)/100 against q2                  <1
  H4          colour 3 near q2: t3's point e(240 + 5.72)/10 against W's point q2 + e(60 - 5.72)/100  <1
              (run 1 probed (101/100) e(-30 + 5.72), whose direction differs from t3's by exactly 90 degrees: a probe-design
              error of mine, recorded in data/fs114/fs114-yb5/check-run1.out; this probe registered before run 2)

Plants (the registered values stay fixed; a planted run must FAIL exactly the checks named, each for its own reason):
  --plant ell0     O1 with w4's edge length 36.87 replaced by 5.72, Z's own angle: sin(l4 - delta) = 0, so 1 + s^2 > 1   -> fails {O1}
  --plant q4wrong  K1 with q4 moved to e(300 - 11.42) (alpha_1 = 71.42, not E1's 60): |q1 - q4| = 1.167 > 1         -> fails {K1}
  --plant near     H1a with s = 1/20 < 2 sin(5.72): the curvature argument needs s > 2 sin delta                    -> fails {H1a}
  --plant side     K3b with t_4's direction 210 - 5.72 instead of 210 + 5.72 (the wrong side of edge 4's tangent)   -> fails {K3b}
Run: python3 tools/fs114_yb5_check.py [--plant NAME]   (exit 0 iff the set of failing checks is exactly the plant's predicted set)
"""
from __future__ import annotations
import sys
from fractions import Fraction as F


class Q3:
    __slots__ = ("a", "b")

    def __init__(self, a, b=0):
        self.a, self.b = F(a), F(b)

    def __add__(s, o):
        o = o if isinstance(o, Q3) else Q3(o)
        return Q3(s.a + o.a, s.b + o.b)

    __radd__ = __add__

    def __neg__(s):
        return Q3(-s.a, -s.b)

    def __sub__(s, o):
        return s + (-(o if isinstance(o, Q3) else Q3(o)))

    def __mul__(s, o):
        o = o if isinstance(o, Q3) else Q3(o)
        return Q3(s.a * o.a + 3 * s.b * o.b, s.a * o.b + s.b * o.a)

    __rmul__ = __mul__

    def sign(s):
        a, b = s.a, s.b
        if a >= 0 and b >= 0:
            return 0 if (a == 0 and b == 0) else 1
        if a <= 0 and b <= 0:
            return -1
        d = a * a - 3 * b * b  # a, b of opposite signs
        if d == 0:
            return 0
        return (1 if d > 0 else -1) * (1 if a > 0 else -1)


H = Q3(0, F(1, 2))  # sqrt3 / 2
COS30 = {0: (Q3(1), Q3(0)), 1: (H, Q3(F(1, 2))), 2: (Q3(F(1, 2)), H), 3: (Q3(0), Q3(1))}


def e30(k):
    k %= 12
    q, r = divmod(k, 3)
    c, s = COS30[r]
    for _ in range(q):
        c, s = -s, c
    return (c, s)


R40 = (F(399, 401), F(40, 401))
R20 = (F(99, 101), F(20, 101))
R37 = (F(4, 5), F(3, 5))


def rot(v, r, sgn=1):
    c, s = r
    s = s * sgn
    return (v[0] * c - v[1] * s, v[0] * s + v[1] * c)


def e(k30, *rs):
    v = e30(k30)
    for r, sg in rs:
        v = rot(v, r, sg)
    return v


def add(u, v):
    return (u[0] + v[0], u[1] + v[1])


def sc(t, v):
    return (Q3(t) * v[0], Q3(t) * v[1])


def cmp1(u, v):
    d = (u[0] - v[0]) * (u[0] - v[0]) + (u[1] - v[1]) * (u[1] - v[1]) - 1
    return {-1: "<1", 0: "=1", 1: ">1"}[d.sign()]


P = (Q3(0), Q3(0))


def checks(plant=None):
    out = []
    q1, q4, C = e(0), e(10), e(8)
    out.append(("CTL-brick", cmp1((Q3(F(4, 5)), Q3(F(3, 5))), P), "=1"))
    out.append(("CTL-hex", cmp1(sc(F(1, 2), e(0)), sc(F(1, 2), e(6))), "=1"))
    out.append(("CTL-reul", cmp1(q1, q4), "=1"))
    out.append(("F1a", cmp1(sc(F(1, 100), e(8, (R40, -1))), q1), ">1"))
    out.append(("F1b", cmp1(sc(F(1, 100), e(8, (R40, 1))), q1), ">1"))
    out.append(("F1c", cmp1(sc(F(1, 100), e(9, (R40, 1))), q1), "<1"))
    out.append(("F1d", cmp1(sc(F(1, 100), e(7, (R40, -1))), q4), ">1"))
    out.append(("F2", cmp1(add(e(4), e(10, (R40, 1))), q4), ">1"))
    Z = add(q4, sc(F(1, 100), e(7, (R40, 1))))
    w4 = add(q4, e(4, (R40, 1)) if plant == "ell0" else e(4, (R37, 1)))
    out.append(("O1", cmp1(Z, w4), "<1"))
    out.append(("O2", cmp1(Z, sc(F(1, 10), e(0, (R40, 1)))), "<1"))
    out.append(("O3", cmp1(Z, q1), ">1"))
    q4k = e(10, (R20, -1)) if plant == "q4wrong" else q4
    out.append(("K1", cmp1(add(q1, sc(F(1, 100), e(9, (R40, 1)))), q4k), "<1"))
    m = sc(F(101, 100), e(11))
    out.append(("K2a", cmp1(m, q4), "<1"))
    out.append(("K2b", cmp1(m, q1), "<1"))
    out.append(("K2c", cmp1(m, add(q1, q4)), "<1"))
    out.append(("K3a", cmp1(sc(F(1, 100), e(3, (R40, -1))), q1), "<1"))
    out.append(("K3b", cmp1(sc(F(1, 100), e(7, (R40, -1 if plant == "side" else 1))), q4), "<1"))
    c150 = sc(F(1, 100), e(5))
    out.append(("K3c-q1", cmp1(c150, q1), ">1"))
    out.append(("K3c-q4", cmp1(c150, q4), ">1"))
    X = add(q1, sc(F(1, 100), e(2)))
    out.append(("X1a", cmp1(X, q4), ">1"))
    out.append(("X1b", cmp1(X, Z), ">1"))
    out.append(("X2", cmp1(add(q4, sc(F(1, 100), e(11, (R40, 1)))), q1), "<1"))
    v2, q2b, v3 = e(2), e(3), e(5)
    out.append(("X3a", cmp1(v2, q2b), "<1"))
    out.append(("X3b", cmp1(v2, v3), ">1"))
    # E2 lemma: Reul(p, qc, r), qc = e(60), r = e(0); arc p-qc has centre r, arc qc-r has centre p
    qc, r = e(2), e(0)
    mid_pqc = add(r, e(5))          # r + e(150): midpoint of arc p-qc (centre r)
    mid_qcr = e(1)                  # e(30): midpoint of arc qc-r (centre p)
    out.append(("R1", cmp1(mid_pqc, mid_qcr), "<1"))
    out.append(("R2", cmp1(r, mid_pqc), "=1"))
    s = F(1, 20) if plant == "near" else F(1, 4)
    h = sc(s, e(4, (R40, -1)))
    out.append(("H1a", cmp1(h, e(1)), ">1"))
    out.append(("H1b", cmp1(h, e(7)), ">1"))
    out.append(("H2", cmp1(sc(F(1, 4), e(8, (R40, 1))), e(11)), ">1"))
    out.append(("H3", cmp1(sc(F(1, 100), e(9)), e(11)), "<1"))
    out.append(("H4", cmp1(sc(F(1, 10), e(8, (R40, 1))), add(e(11), sc(F(1, 100), e(2, (R40, -1))))), "<1"))
    return out


PLANT_FLIPS = {None: set(), "ell0": {"O1"}, "q4wrong": {"K1"}, "near": {"H1a"}, "side": {"K3b"}}


def main():
    plant = None
    if "--plant" in sys.argv:
        plant = sys.argv[sys.argv.index("--plant") + 1]
        if plant not in PLANT_FLIPS:
            print(f"unknown plant {plant}")
            return 2
    res = checks(plant)
    failed = set()
    for name, got, want in res:
        ok = got == want
        if not ok:
            failed.add(name)
        print(f"{name:10s} {got}  registered {want}  {'PASS' if ok else 'FAIL'}")
    want = PLANT_FLIPS[plant]
    print(f"-- plant={plant}: {len(res) - len(failed)} of {len(res)} as registered; failed {sorted(failed)}, predicted {sorted(want)}: "
          f"{'AS PREDICTED' if failed == want else 'NOT AS PREDICTED'}")
    return 0 if failed == want else 1


if __name__ == "__main__":
    sys.exit(main())

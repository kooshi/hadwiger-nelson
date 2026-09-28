#!/usr/bin/env python3
"""FS114-YB4: exact checks at named points for the pinwheel statements (FS114-Y5-*), written blind (no FS114-Y5 file read).

ARITHMETIC: exact, in Q(sqrt 3) only -- a number is a + b*sqrt(3) with Fraction a, b; its sign is decided exactly (a and b of one sign, or
a^2 against 3 b^2).  No floats anywhere in a verdict.  Points are pairs of such numbers; unit vectors e(30 k) lie in Q(sqrt 3)^2, and small
angles are rational rotations (cos, sin) = ((1 - t^2)/(1 + t^2), 2t/(1 + t^2)).  A DIFFERENT METHOD from FS114-YB3's checker (intervals and
minimal polynomials over sympy) and from FS114-YB2's towers, on purpose.

WHAT IS CHECKED: the inequalities my stage-1b derivations rest on, at named points (instances, not proofs; the proofs are the derivations in
plans/FS114-YB4-verification.md stage 1b).  Every prediction is in PRED below, written before the first run.

PLANTS (each fires through its own path; predicted flips in PLANT_PRED): `signflip` (the mixed-sign branch of the exact sign returns the
opposite), `firstorder` (PXKILL's pair read along straight rays at first order instead of along the two unit arcs), `far` (O's point pushed out
by 1/20 from the arc), `wrongv` (v taken 90 degrees from q instead of 60).

Run: python3 tools/fs114_yb4_pin.py            (exit 0 iff every verdict as predicted, and every plant flips exactly as predicted)
"""
from __future__ import annotations
import sys
from fractions import Fraction as F

PLANT: set[str] = set()
MIXED = [False]


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

    def __rsub__(s, o):
        return Q3(o) - s

    def __mul__(s, o):
        o = o if isinstance(o, Q3) else Q3(o)
        return Q3(s.a * o.a + 3 * s.b * o.b, s.a * o.b + s.b * o.a)

    __rmul__ = __mul__

    def sign(s) -> int:
        a, b = s.a, s.b
        if a >= 0 and b >= 0:
            return 0 if (a == 0 and b == 0) else 1
        if a <= 0 and b <= 0:
            return -1
        MIXED[0] = True
        d = a * a - 3 * b * b          # mixed signs: the larger in absolute value wins
        r = (1 if d > 0 else -1 if d < 0 else 0) * (1 if a > 0 else -1)
        return -r if "signflip" in PLANT else r

    def __float__(s):
        return float(s.a) + float(s.b) * 3 ** 0.5


H = Q3(0, F(1, 2))          # sqrt(3)/2


def e30(k: int):
    k %= 12
    c = [Q3(1), H, Q3(F(1, 2)), Q3(0), Q3(F(-1, 2)), -H, Q3(-1), -H, Q3(F(-1, 2)), Q3(0), Q3(F(1, 2)), H][k]
    s = [Q3(0), Q3(F(1, 2)), H, Q3(1), H, Q3(F(1, 2)), Q3(0), Q3(F(-1, 2)), -H, Q3(-1), -H, Q3(F(-1, 2))][k]
    return (c, s)


def rat(t):
    t = F(t)
    return (Q3((1 - t * t) / (1 + t * t)), Q3(2 * t / (1 + t * t)))


def rot(v, r):          # rotate v by the angle whose (cos, sin) is r
    return (v[0] * r[0] - v[1] * r[1], v[0] * r[1] + v[1] * r[0])


def inv(r):
    return (r[0], -r[1])


def add(u, v):
    return (u[0] + v[0], u[1] + v[1])


def sub(u, v):
    return (u[0] - v[0], u[1] - v[1])


def sm(k, v):
    return (v[0] * k, v[1] * k)


def n2(v):
    return v[0] * v[0] + v[1] * v[1]


def cmp1(x) -> str:      # compare a squared distance with 1
    MIXED[0] = False
    s = (x - 1).sign()
    return "<1" if s < 0 else ">1" if s > 0 else "=1"


RESULTS: dict[str, str] = {}
USED_MIXED: set[str] = set()


def rec(key, val, note=""):
    RESULTS[key] = val
    if MIXED[0]:
        USED_MIXED.add(key)
    print(f"  {key:34s} {val:4s} {note}")


# ------------------------------------------------------------------ controls of the evaluator (known values)
def controls():
    rec("C.brick_diagonal", cmp1(Q3(F(4, 5)) * Q3(F(4, 5)) + Q3(F(3, 5)) * Q3(F(3, 5))), "(4/5, 3/5): the brick's cell diagonal is exactly 1")
    rec("C.reuleaux_width", cmp1(n2(sub(e30(0), e30(2)))), "|e(0) - e(60)|^2")
    q1, q2 = e30(1), e30(-1)
    z1 = add(q2, (Q3(F(-3, 5)), Q3(F(4, 5))))
    z2 = add(q1, (Q3(F(-3, 5)), Q3(F(-4, 5))))
    d = n2(sub(z1, z2))
    rec("C.sides_9_25", "=" if (d - Q3(F(9, 25))).sign() == 0 else "!=", "YB3's SIDES identity at cos eps = 4/5")
    for lab, x in [("7-4r3", Q3(7, -4)), ("26-15r3", Q3(26, -15)), ("97-56r3", Q3(97, -56)), ("56r3-97", Q3(-97, 56))]:
        MIXED[0] = False
        sg = x.sign()
        rec("C.sign_" + lab, "+" if sg > 0 else "-" if sg < 0 else "0")
    rec("C.hex_side_half_diameter", cmp1(n2(sm(Q3(1), sub(sm(Q3(F(1, 2)), e30(0)), sm(Q3(F(1, 2)), e30(6)))))),
        "a hexagon of side 1/2 has diameter exactly 1")


# ------------------------------------------------------------------ REGION: a blade's cone is at least 60 degrees
def region():
    qj = e30(3)
    for lab, r in [("alpha60", e30(2)), ("alpha_11.4", rat(F(1, 10))), ("alpha_90", e30(3))]:
        qn = rot(qj, r)
        rec("R.q_j_vs_q_j+1_" + lab, cmp1(n2(sub(qj, qn))), "q_j must be >= 1 from q_{j+1}; < 1 means no blade of that cone")


# ------------------------------------------------------------------ PXKILL: the pair T_k, O_{k+1} (frame q = e(90), v = e(150))
def pxkill():
    q, v = e30(3), e30(5)
    if "wrongv" in PLANT:
        v = e30(6)                      # 90 degrees from q: |q - v| = sqrt 2
    rec("P.|q-v|", cmp1(n2(sub(q, v))))
    for lab, (t1, t2) in {"t=1/10,1/10": (F(1, 10), F(1, 10)), "t=1/10,1/50": (F(1, 10), F(1, 50)),
                          "t=1/50,1/200": (F(1, 50), F(1, 200))}.items():
        r1, r2 = rat(t1), rat(t2)
        u_v_to_q = sub(q, v)            # e(30): T_k's arc is omega(v), starting at q, running counter-clockwise (outward, direction 120)
        u_q_to_v = sub(v, q)            # e(210): O's arc is omega(q), starting at v, running clockwise (outward, direction 120)
        A = add(v, rot(u_v_to_q, r1))
        B = add(q, rot(u_q_to_v, inv(r2)))
        if "far" in PLANT:
            B = add(q, sm(Q3(F(21, 20)), rot(u_q_to_v, inv(r2))))
        if "firstorder" in PLANT:       # straight rays from q and v in the tangent direction 120, same arc length parameter
            dirn = e30(4)
            A = add(q, sm(r1[1], dirn))
            B = add(v, sm(r2[1], dirn))
        d = n2(sub(A, B))
        rec("P.arcs_" + lab, cmp1(d), "points ON the two arcs")
        c1, s1, c2, s2 = r1[0], r1[1], r2[0], r2[1]
        formula = 1 + 2 * (1 - c1) * (1 - c2) - 2 * s1 * s2
        rec("P.formula_" + lab, "=" if (d - formula).sign() == 0 else "!=", "|A-B|^2 = 1 + 2(1-c)(1-c') - 2 s s'")
        eta = s1 * s2 * Q3(F(1, 4))     # interior points: pushed off the arcs by eta = s s'/4 each, away from v resp. q
        Ai = add(v, sm(1 + eta, rot(u_v_to_q, r1)))
        Bi = add(q, sm(1 + eta, rot(u_q_to_v, inv(r2))))
        if "far" in PLANT:
            Bi = add(q, sm(Q3(F(21, 20)), rot(u_q_to_v, inv(r2))))
        if "firstorder" in PLANT:
            Ai, Bi = A, B
        rec("P.interior_" + lab, cmp1(n2(sub(Ai, Bi))), "interior points of T_k and O_{k+1}")
        rec("P.Ai_outside_omega_v_" + lab, cmp1(n2(sub(Ai, v))), "T_k's point lies outside B(v,1): consistent with T_k avoiding B(v,1)")
        rec("P.Bi_outside_omega_q_" + lab, cmp1(n2(sub(Bi, q))), "O's point lies outside B(q,1)")
    # the first-order control, always run: straight rays inside the sectors [.., 120] at q and [120, ..] at v are MORE than 1 apart
    for lab, (t, dl) in {"s=1/10": (F(1, 10), F(1, 10)), "s=1/100": (F(1, 100), F(1, 50))}.items():
        s = Q3(t)
        dq = rot(e30(4), inv(rat(dl)))  # 120 - delta
        dv = rot(e30(4), rat(dl))       # 120 + delta
        rec("P.rays_" + lab, cmp1(n2(sub(add(q, sm(s, dq)), add(v, sm(s, dv))))), "first order alone gives no conflict")


# ------------------------------------------------------------------ blocking at q_k and v_{k+1} in P_x (frame d_k = 0, q_k = e(90))
def cones():
    th = (Q3(F(12, 13)), Q3(F(5, 13)))          # theta ~ 22.62 deg
    return {"x=90": (e30(3), e30(3)),            # (e(alpha_k), e(alpha_{k+1}))
            "a_k=112.6": (rot(e30(3), th), rot(e30(3), inv(th))),
            "a_k=67.4": (rot(e30(3), inv(th)), rot(e30(3), th))}


def blocking():
    small = rat(F(1, 20))                         # ~5.7 degrees
    for lab, (eak, eak1) in cones().items():
        qk = e30(3)
        Po = (Q3(F(1, 2000)), Q3(F(2001, 2000)))  # just outside the ring, clockwise of q_k (run 2: 1/2000, run 1 had 1/50)
        s = Q3(F(1, 20))
        w_k1 = sm(s, (Q3(F(3, 5)), Q3(F(4, 5))))  # t_{k+1}: direction ~53.1 deg, inside (0, alpha_{k+1}) for every case
        w_k2 = sm(s, rot(eak1, small))            # t_{k+2}: just past alpha_{k+1}
        w_k = sm(s, (Q3(F(4, 5)), Q3(F(-3, 5))))  # t_k: direction ~ -36.9 deg, inside (-alpha_k, 0)
        rec(f"B.{lab}.q_k.out.colour_k+1", cmp1(n2(sub(Po, w_k1))), "blocked (t_{k+1})")
        rec(f"B.{lab}.q_k.out.colour_k+2", cmp1(n2(sub(Po, w_k2))), "blocked (t_{k+2})")
        rec(f"B.{lab}.q_k.out.colour_k", cmp1(n2(sub(Po, w_k))), "t_k's near-p points do not block outside (T_k is excluded by U1's side cone)")
        # v_{k+1} = e(150) in this frame; probe just outside, on the clockwise side (toward q_k)
        v = e30(5)
        Pv = add(sm(Q3(F(20001, 20000)), v), sm(Q3(F(1, 20000)), e30(2)))   # outward and toward direction 60 (run 2: 1/20000)
        w_km1 = sm(s, rot(e30(6), rat(F(1, 20))))  # t_{k-1}: direction just past 180, inside (180, 360 - alpha_k)
        wv = sm(s, rot(e30(2), rat(F(1, 40))))     # run 2: direction 60 + 2.86 deg, inside (60, alpha_{k+1}) in every case (run 1 used 53.1 deg at x = 90)
        rec(f"B.{lab}.v.out.colour_k+1", cmp1(n2(sub(Pv, wv))), "blocked (t_{k+1}, a direction in (60, alpha_{k+1}))")
        rec(f"B.{lab}.v.out.colour_k-1", cmp1(n2(sub(Pv, w_km1))), "blocked (t_{k-1})")
        qk1 = rot(qk, eak1)                        # q_{k+1} = e(90 + alpha_{k+1})
        rec(f"B.{lab}.|v-q_k+1|", cmp1(n2(sub(v, qk1))), "< 1 iff alpha_{k+1} < 120: colour m_{k+1} blocked at v via mu_{k+1}")
        qkm1 = rot(qk, inv(eak))                   # q_{k-1} = e(90 - alpha_k)
        vk = rot(qkm1, e30(2))                     # v_k = e(phi_{k-1} + 60)
        rec(f"B.{lab}.|v_k-q_k|", cmp1(n2(sub(vk, qk))), "< 1 iff alpha_k > 60: colour m_{k-1} blocked at q_k (wrap or not)")
        # colour k-1 blocked at q_k when alpha_{k-1} + alpha_k > 180: probe with alpha_{k-1} + alpha_k = 180 + 11.4 deg
        wbig = sm(s, rot(e30(6), inv(rat(F(1, 20)))))  # direction 180 - 5.7 (i.e. -185.7): inside t_{k-1}'s sector when alpha_{k-1} + alpha_k > 185.7
        rec(f"B.{lab}.q_k.out.colour_k-1_sum>180", cmp1(n2(sub(Po, wbig))), "blocked when alpha_{k-1} + alpha_k > 180")


PRED = {
    "C.brick_diagonal": "=1", "C.reuleaux_width": "=1", "C.sides_9_25": "=", "C.sign_7-4r3": "+", "C.sign_26-15r3": "+",
    "C.sign_97-56r3": "+", "C.sign_56r3-97": "-", "C.hex_side_half_diameter": "=1",
    "R.q_j_vs_q_j+1_alpha60": "=1", "R.q_j_vs_q_j+1_alpha_11.4": "<1", "R.q_j_vs_q_j+1_alpha_90": ">1",
    "P.|q-v|": "=1",
}
for _l in ["t=1/10,1/10", "t=1/10,1/50", "t=1/50,1/200"]:
    PRED.update({f"P.arcs_{_l}": "<1", f"P.formula_{_l}": "=", f"P.interior_{_l}": "<1",
                 f"P.Ai_outside_omega_v_{_l}": ">1", f"P.Bi_outside_omega_q_{_l}": ">1"})
PRED.update({"P.rays_s=1/10": ">1", "P.rays_s=1/100": ">1"})
for _l in ["x=90", "a_k=112.6", "a_k=67.4"]:
    PRED.update({f"B.{_l}.q_k.out.colour_k+1": "<1", f"B.{_l}.q_k.out.colour_k+2": "<1", f"B.{_l}.q_k.out.colour_k": ">1",
                 f"B.{_l}.v.out.colour_k+1": "<1", f"B.{_l}.v.out.colour_k-1": "<1", f"B.{_l}.|v-q_k+1|": "<1",
                 f"B.{_l}.|v_k-q_k|": "<1", f"B.{_l}.q_k.out.colour_k-1_sum>180": "<1"})

# which verdicts each plant must flip (and nothing else)
PLANT_PRED = {
    "signflip": None,   # structural prediction (run 2): exactly the verdicts whose decisive sign went through the mixed branch
    "firstorder": {f"P.{k}_{l}" for l in ["t=1/10,1/10", "t=1/10,1/50", "t=1/50,1/200"] for k in ["arcs", "interior", "formula"]},
    "far": {f"P.{k}_{l}" for l in ["t=1/10,1/10", "t=1/10,1/50", "t=1/50,1/200"] for k in ["arcs", "interior", "formula"]},
    "wrongv": {"P.|q-v|"} | {f"P.{k}_{l}" for l in ["t=1/10,1/10", "t=1/10,1/50", "t=1/50,1/200"] for k in ["arcs", "interior", "formula"]},
}


def run_all():
    RESULTS.clear()
    USED_MIXED.clear()
    print("controls"); controls()
    print("region"); region()
    print("pxkill"); pxkill()
    print("blocking"); blocking()
    return dict(RESULTS)


def main():
    PLANT.clear()
    faithful = run_all()
    mixed_in_faithful = set(USED_MIXED)
    PLANT_PRED["signflip"] = {k for k in mixed_in_faithful if faithful[k] not in ("=1", "=", "0")}
    bad = [k for k, v in PRED.items() if faithful.get(k) != v]
    missing = [k for k in faithful if k not in PRED]
    print(f"FAITHFUL: {len(PRED) - len(bad)} of {len(PRED)} as predicted; unpredicted keys: {missing}")
    ok = not bad and not missing
    for k in bad:
        print("  NOT AS PREDICTED:", k, faithful.get(k), "predicted", PRED[k])
    for p, want in PLANT_PRED.items():
        PLANT.clear(); PLANT.add(p)
        print(f"--- plant {p}")
        got = run_all()
        flipped = {k for k in faithful if got.get(k) != faithful[k]}
        good = flipped == want
        print(f"PLANT {p}: flipped {sorted(flipped)}; predicted {sorted(want)}: {'AS PREDICTED' if good else 'NOT AS PREDICTED'}")
        ok = ok and good
    PLANT.clear()
    print("ALL AS PREDICTED" if ok else "SOME VERDICT NOT AS PREDICTED")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())

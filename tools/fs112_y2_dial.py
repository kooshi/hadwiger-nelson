#!/usr/bin/env python3
"""FS112-Y2 stage 6: the dial (E6), aimed at the named unsaved seams of the two held positives, by formula, checked exactly.

Sections (python3 tools/fs112_y2_dial.py [section ...] [--plant NAME]):
  pin    -- the pinned-corner reading at each positive's stop point (the strip's edge vertex Q = (1/4, top); the disk's rim corner C_0):
            for every tile, exactly, whether it straddles distance 1 at the stop point itself (min < 1 < max), and for the tiles AT the stop
            point, their farthest point (the pinned partner, at distance exactly 1); then, at named points Q + e(theta)/100 outside the object,
            the colours no tile forbids (exact straddle tests).
  move   -- the disk with one move per rim corner, derived (plans/FS112-Y-construction.md stage 6): R_k's straight sides C_kZ^L_k and
            Z^R_kD_k replaced by the unit arcs of omega(D_k) and omega(C_k) through the same ends (the only arcs through those ends that put
            U'_{k-1} outside B(C_k, 1) and U_k outside B(D_k, 1)); the lenses go to R_k.  Exact validity check of the modified disk (every
            same-colour pair), the new arcs' kinds, and the free colours beyond C_0 at the same named points as `pin`.
Plant (--plant move_wrongside): the left arcs drawn through C_k and Z^L_k about the reflection D'_k of D_k in the chord (bulging into R_k
instead of U_k): U_k then crosses the chord toward D_k, and its points there are farther than 1 from its own corner B_k -- predicted
REJECT at exactly the five (U_k, U_k) self pairs.
"""
from __future__ import annotations
import sys, os, math
from fractions import Fraction as Fr

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import fs112_y_check as Y          # noqa: E402  (FS112-Y's checker: run, never edited)
import fs112_y2_disk as DK         # noqa: E402

OK = True
PLANT = None
COLS = ["R", "Bl", "G", "Yw", "O", "P"]


def say(ok, msg):
    global OK
    OK &= bool(ok)
    print(("ok       " if ok else "MISMATCH ") + msg)


def classify(z, prims):
    cs = DK.point_range(z, prims)
    lo = any(Y.lt1(*c) for c in cs)
    hi = any(Y.gt1(*c) for c in cs)
    return lo, hi


def free_colours(T, z, colset):
    out = []
    for c in colset:
        if not any(DK.straddles(z, prims) for nm, (cc, prims) in T.items() if cc == c):
            out.append(c)
    return out


def pin_report(lab, T, Q, colset, dirs, e, eps, outside):
    print(f"-- {lab}: tiles straddling distance 1 at the stop point itself (colour blocked in a whole neighbourhood of it)")
    at = [nm for nm, (c, prims) in T.items() if any(Y.is0(Y.sub(Q, x)) for p in prims for x in p.ends())]
    rows = []
    for nm, (c, prims) in sorted(T.items()):
        lo, hi = classify(Q, prims)
        if nm in at:
            rows.append(f"{nm}({c}) AT the point")
        elif lo and hi:
            rows.append(f"{nm}({c}) straddles")
    print("   " + "; ".join(rows))
    blocked_at = {T[r.split('(')[0]][0] for r in rows if r.endswith("straddles")}
    own = {T[nm][0] for nm in at}
    print(f"   colours of the tiles at the point: {sorted(own)}; colours blocked at the point itself by a straddling tile: {sorted(blocked_at)}")
    res = {}
    for d in dirs:
        z = Y.add(Q, Y.mul(eps, e(d)))
        if not outside(z):
            res[d] = None; continue
        res[d] = free_colours(T, z, colset)
    print("   free colours at Q + e(theta)/100 outside the object: " +
          "; ".join(f"{d}: {'-' if v is None else (v if v else 'NONE')}" for d, v in res.items()))
    return own, blocked_at, res


def pin():
    print("== the pinned-corner reading at the two stop points (exact)")
    # the strip: Q = (1/4, top), outside = above the top line
    F, T, top = Y.strip(-6, 8)
    r3, r5 = F.gen(1), F.gen(2)
    one = F(1)
    def e30(deg):
        c = {0: (one, F(0)), 30: (r3 / 2, F(Fr(1, 2))), 60: (F(Fr(1, 2)), r3 / 2), 90: (F(0), one), 120: (F(Fr(-1, 2)), r3 / 2),
             150: (-r3 / 2, F(Fr(1, 2))), 180: (-one, F(0))}
        return c[deg]
    Q = (F(Fr(1, 4)), top)
    own, blk, res = pin_report("strip, Q = (1/4, top) [the pair (V_0, A_1)]", T, Q, [1, 2, 3, 4, 5, 6], [0, 30, 60, 90, 120, 150, 180],
                               e30, F(Fr(1, 100)), lambda z: z[1] > top)
    say(own == {5, 6} and blk == {1, 2, 3, 4} and all(v == [] for d, v in res.items() if v is not None and 30 < d < 165),
        "strip: Q's own colours {5, 6}; every other colour straddles at Q; no colour at the named directions strictly inside (30, 165.52) deg")
    # partners: the tiles at Q reach distance exactly 1 at V_0 (colour 5) and A_1 (colour 6)
    V0, A1 = (F(0), r3 / 2), (F(Fr(3, 4)), r3 * r5 / 4)
    say(Y.n2(Y.sub(Q, V0)) == 1 and Y.n2(Y.sub(Q, A1)) == 1 and 5 in Y.closure_type(T, V0) and 6 in Y.closure_type(T, A1),
        "strip: the pinned partners V_0 (colour 5 at it) and A_1 (colour 6 at it) are at distance exactly 1 from Q")
    # the disk: C_0, outside = beyond the rim
    Dk = DK.Disk()
    T, P = Dk.T, Dk.P
    C0 = P[("C", 0)]
    own, blk, res = pin_report("disk, C_0 [the pair (B_0, Z^R_0)]", T, C0, COLS, [18, 36, 54, 72, 90, 108, 126, 144, 162, 180],
                               Dk.e, Dk.F(Fr(1, 100)), lambda z: Y.n2(z) > Dk.r * Dk.r)
    say(own == {"R", "P"}, "disk: C_0's own colours {R, P}")
    say(Y.n2(Y.sub(C0, P[("ZR", 0)])) == 1 and Y.n2(Y.sub(C0, P[("B", 0)])) == 1 and Y.n2(Y.sub(C0, P[("D", 0)])) == 1,
        "disk: at distance exactly 1 from C_0: Z^R_0 (in R_0), B_0 (in U_0) and D_0 (a corner of U'_4)")
    return res


# ------------------------------------------------------------------ the move
class MovedDisk(DK.Disk):
    def __init__(self, plant=None):
        super().__init__()
        F, P, T = self.F, self.P, self.T
        one = F(1)
        g = lambda nm, k: P[(nm, k % 5)]
        def arc(Cn, rad, p, q):
            a1, a2 = Y.sub(p, Cn), Y.sub(q, Cn)
            return Y.Arc(Cn, rad, p, q) if Y.cross(a1, a2) > 0 else Y.Arc(Cn, rad, q, p)
        self.new_arcs = []
        for k in range(5):
            C, D, ZL, ZR = g("C", k), g("D", k), g("ZL", k), g("ZR", k)
            cL = D
            if plant == "move_wrongside":
                d = Y.sub(ZL, C); t = Y.dot(Y.sub(D, C), d) / Y.n2(d)
                foot = Y.add(C, Y.mul(t, d)); cL = Y.sub(Y.mul(F(2), foot), D)
            aR = arc(C, one, ZR, D)             # right side: omega(C_k) from Z^R_k to D_k
            aL = arc(cL, one, C, ZL)            # left side: omega(D_k) from C_k to Z^L_k
            self.new_arcs.append((k, aR, aL))
            def swap(prims, old_ends, new):
                out, hit = [], False
                for p in prims:
                    if isinstance(p, Y.Seg) and {Y.pkey(p.P), Y.pkey(p.Q)} == {Y.pkey(old_ends[0]), Y.pkey(old_ends[1])}:
                        out.append(new); hit = True
                    else:
                        out.append(p)
                assert hit
                return out
            c, pr = T[f"R_{k}"]
            pr = swap(pr, (ZR, D), aR); pr = swap(pr, (C, ZL), aL)
            T[f"R_{k}"] = (c, pr)
            c, pr = T[f"U_{k}"]
            T[f"U_{k}"] = (c, swap(pr, (C, ZL), aL))
            km = (k - 1) % 5
            c, pr = T[f"Up_{km}"]
            T[f"Up_{km}"] = (c, swap(pr, (ZR, D), aR))


def move():
    print(f"== the move: R_k's straight sides replaced by unit arcs of omega(C_k), omega(D_k){'  [PLANT ' + PLANT + ']' if PLANT else ''}")
    M = MovedDisk(PLANT)
    T = M.T
    pairs = Y.all_pairs(T)
    v, bad, n = Y.check_pairs(T, pairs)
    print(f"   same-colour pairs examined {n} of {n}; VERDICT {v}; REJECT pairs {bad}")
    if PLANT:
        return
    say(v == "ACCEPT", f"the moved disk: {v} on {n} pairs")
    Y.PLANT = "closed_interval"
    v2, bad2, _ = Y.check_pairs(T, pairs)
    Y.PLANT = None
    print(f"   closed_interval: {sum(1 for p in bad2 if p[0] == p[1])} self contacts, cross contacts {[p for p in bad2 if p[0] != p[1]]}")
    # kinds of the ten new arcs (after the move, before any tile beyond the rim)
    kinds = []
    for k, aR, aL in M.new_arcs:
        for a, cname in ((aR, "C"), (aL, "D")):
            Cn = a.C
            Pcl = Y.closure_type(T, Cn)
            sides = [(nm, c) for nm, (c, prims) in T.items() if any(p is a for p in prims)]
            inner = [(nm, c) for nm, c in sides if c in Y.closure_type({nm: T[nm]}, Cn)]
            outer = [(nm, c) for nm, c in sides if (nm, c) not in inner]
            kd = ("both" if (inner[0][1] in Pcl and outer[0][1] in Pcl) else "in" if inner[0][1] in Pcl else
                  "out" if outer[0][1] in Pcl else "inert")
            kinds.append((f"{cname}_{k}", inner[0][0], outer[0][0], kd, sorted(Pcl)))
    for kd in kinds[:2]:
        print(f"   new arc centred {kd[0]}: inner {kd[1]}, outer {kd[2]}, kind {kd[3]} (P_cl at the centre {kd[4]})")
    say(all(k[3] == "in" for k in kinds), f"the ten new unit arcs are all of kind 'in' (self in-contact only): {sorted({k[3] for k in kinds})}")
    Q = M.P[("C", 0)]
    own, blk, res = pin_report("moved disk, C_0", T, Q, COLS, [18, 36, 54, 72, 90, 108, 126, 144, 162, 180], M.e, M.F(Fr(1, 100)),
                               lambda z: Y.n2(z) > M.r * M.r)
    Q = M.P[("D", 0)]
    own2, blk2, res2 = pin_report("moved disk, D_0", T, Q, COLS, [0, 18, 36, 54, 72, 90, 108, 126, 144, 162], M.e, M.F(Fr(1, 100)),
                                  lambda z: Y.n2(z) > M.r * M.r)
    return res, res2


if __name__ == "__main__":
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    if "--plant" in sys.argv:
        PLANT = sys.argv[sys.argv.index("--plant") + 1]
        args = [a for a in args if a != PLANT]
    for s in (args or ["pin", "move"]):
        {"pin": pin, "move": move}[s]()
    print("ALL AS EXPECTED" if OK else "SOME MISMATCH")
    sys.exit(0 if OK else 1)

#!/usr/bin/env python3
"""FS114-Y stage 2, C114-DIAL: the strip with caps, checked exactly by FS112-YB2's tower checker (tools/fs112_yb2_check.py and the strip builder
tools/fs112_yb2_objects.py Strip: imported and run, never edited).

THE OBJECT (by formula).  [AxenovichEtAl2014] Thm 4.2's strip, as FS112-YB2 rebuilt it (midline vertices P_j = (j/2, 0), valleys
V_m = (m/2, sqrt3/2), apexes (j/2 + 1/4, sqrt15/4), half-height Y = sqrt3/2 + sqrt15/4), with ONE change: the top edge of every top tile T_m
(the segment from its top-right corner TR = (m/2 + 1/4, Y) to its top-left corner TL = (m/2 - 1/4, Y)) is replaced by the arc of the unit circle
about its own valley V_m from TR to TL (the cap K_m: TL and TR lie on omega(V_m) because |V_m - TL|^2 = 1/16 + 15/16 = 1); the bottom tiles B_m
likewise with the mirror arc about V'_m = (m/2, -sqrt3/2).  Colours unchanged.  Each capped tile keeps diameter exactly 1 (V_m to the arc).

THE CLAIM.  (i) The capped strip is a valid fragment: every same-colour pair (a tile with itself included) with its first tile in one period
(columns 0..2) and its second in columns [-W, W+2] ACCEPTs, and tiles beyond are dismissed by an exact x-gap > 1 (the caps' x-ranges are their
tiles').  (ii) For every R with R^2 < (7 + 3 sqrt5)/4 = phi^4/2 (R < 1.85123) the closed disc B(P_1, R) lies in the interior of the union:
points with |y| < Y are interior to the strip; a point z of the disc with y >= Y has |z - V_1|^2 = |z - P_1|^2 - sqrt3 y + 3/4
<= R^2 - sqrt3 Y + 3/4 < 1 exactly when R^2 < 1/4 + sqrt3 Y = (7 + 3 sqrt5)/4, and its x lies within 1/2 +- sqrt(R^2 - Y^2), inside (1/4, 3/4)
since R^2 - Y^2 < 1/16 (the same identity); the bottom by the mirror.  At R^2 = (7 + 3 sqrt5)/4 = |P_1 - Q|^2, Q = (1/4, Y) the strip's stop
(FS112-EDGE), and no valid extension of the strip holds a neighbourhood of Q.
Plant (--plant cap_high): every cap lifted by 1/20 (the arc about V_m + (0, 1/20), joined to the corners by two vertical segments), so each
capped tile reaches 1.05 from its valley: registered REJECT at exactly the six capped self-pairs of the representative period (T0, T1, T2, B0,
B1, B2) and at no other pair (the lifted caps of T_m and T_{m+3} stay an exact 1 apart horizontally).  The faithful twin ACCEPTs beside it.
Run: python3 tools/fs114_y_dial.py [check] [disc] [--plant NAME]
"""
from __future__ import annotations
import os
import sys
from fractions import Fraction as Fr

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
import fs112_yb2_check as K          # noqa: E402  (FS112-YB2's checker: run, never edited)
import fs112_yb2_objects as O        # noqa: E402  (FS112-YB2's strip builder: run, never edited)

Seg, Arc = K.Seg, K.Arc
PLANT = None
OK = True


def say(ok, msg):
    global OK
    OK &= bool(ok)
    print(("ok       " if ok else "MISMATCH ") + msg, flush=True)


class CappedStrip(O.Strip):
    def capped(self, m, s):
        """the top (s = 1) or bottom (s = -1) tile over V_m with its straight far edge replaced by the cap arc about V_m (radius 1)."""
        pieces = self.cap(m, s)
        T = self.T
        xl, xr = T(Fr(m, 2) - Fr(1, 4)), T(Fr(m, 2) + Fr(1, 4))
        TL, TR = (xl, self.Y * s), (xr, self.Y * s)
        V = self.V(m, s)
        out, hit = [], 0
        for p in pieces:
            if p.kind == "S" and ((K.veq(p.P, TR) and K.veq(p.Q, TL)) or (K.veq(p.P, TL) and K.veq(p.Q, TR))):
                hit += 1
                if PLANT == "cap_high":        # the cap lifted by 1/20 (arc about V_m + (0, s/20)), joined to the corners by two segments
                    d = (T(0), T(Fr(1, 20)) * s)
                    Vh, TLh, TRh = K.vadd(V, d), K.vadd(TL, d), K.vadd(TR, d)
                    if s == 1:
                        out += [Seg(TR, TRh), Arc(Vh, self.one, TRh, TLh), Seg(TLh, TL)]
                    else:
                        out += [Seg(TL, TLh), Arc(Vh, self.one, TLh, TRh), Seg(TRh, TR)]
                elif s == 1:
                    out.append(Arc(V, self.one, TR, TL))      # counter-clockwise about V_m from TR (75.5 deg) to TL (104.5 deg)
                else:
                    out.append(Arc(V, self.one, TL, TR))      # counter-clockwise about V'_m from TL (255.5 deg) to TR (284.5 deg)
            else:
                out.append(p)
        assert hit == 1, "the far edge was not found exactly once"
        return out

    def tiles(self, lo, hi):
        out = {}
        for j in range(lo, hi + 1):
            out[f"U{j}"] = (self.ARCH[j % 3], self.arch(j, 1))
            out[f"D{j}"] = (self.INV[j % 3], self.arch(j, -1))
            out[f"T{j}"] = (self.TOP[j % 3], self.capped(j, 1))
            out[f"B{j}"] = (self.BOT[j % 3], self.capped(j, -1))
        return out


def check(W=9):
    S = CappedStrip()
    allt = S.tiles(-W - 3, W + 5)
    reps = [f"{k}{j}" for j in range(3) for k in "UDTB"]
    seen, rows, bad = set(), [], []
    for a in reps:
        ka, ja = a[0], int(a[1:])
        for kb in "UDTB":
            for jb in range(-W, W + 3):
                b = f"{kb}{jb}"
                if allt[b][0] != allt[a][0]:
                    continue
                sh = 3 * (jb // 3)
                key = min((ka, ja, kb, jb), (kb, jb - sh, ka, ja - sh))
                if key in seen:
                    continue
                seen.add(key)
                r = K.pair_verdict(allt[a][1], allt[b][1], self_pair=(a == b))
                rows.append((a, b, allt[a][0], r))
                if r.verdict == "REJECT":
                    bad.append((a, b))
    xr = {nm: O.xrange_of(ps) for nm, (_, ps) in allt.items()}
    gaps = []
    for a in reps:
        for kb in "UDTB":
            for jb in (-W - 3, -W - 2, -W - 1, W + 3, W + 4, W + 5):
                b = f"{kb}{jb}"
                if allt[b][0] == allt[a][0]:
                    gaps.append(max(xr[b][0] - xr[a][1], xr[a][0] - xr[b][1]))
    g = min(gaps, key=float)
    tight = [(a, b) for a, b, c, r in rows if r.mcmp == "=" or (a == b and r.Mcmp == "=")]
    print(f"capped strip: orbit pairs examined {len(rows)} (each same-colour orbit pair with a tile in columns 0..2, the other in [-{W}, {W + 2}]);"
          f" REJECT {bad if bad else 'none'}; exact contacts at 1: {len(tight)}; x-gap beyond the window {float(g):.3f} (exact > 1: {g > 1})")
    for a, b, c, r in rows:
        if a[0] in "TB" and a == b:
            print(f"   self-pair {a}: {r}")
    return S, rows, bad, g


def disc():
    S = CappedStrip()
    T = S.T
    r3, r5 = T.gen(1), T.gen(2)
    Y = S.Y
    crit = Fr(1, 4) + r3 * Y                                    # 1/4 + sqrt3 Y
    target = (T(7) + 3 * r5) / 4
    say(crit == target, "1/4 + sqrt3 Y = (7 + 3 sqrt5)/4 exactly")
    P1 = S.P(1)
    Q = (T(Fr(1, 4)), Y)
    say(K.n2(K.vsub(Q, P1)) == target, "|P_1 - Q|^2 = (7 + 3 sqrt5)/4: the critical radius is the distance to the stop point Q")
    say(Y * Y + Fr(1, 16) == target, "Y^2 + 1/16 = (7 + 3 sqrt5)/4 (so R^2 < it gives R^2 - Y^2 < 1/16: the cap's x-range stays inside (1/4, 3/4))")
    for R in (Fr(37, 20), Fr(1851, 1000)):
        R2 = T(R * R)
        print(f"   R = {float(R):.4f}: R^2 = {float(R2):.6f} < (7 + 3 sqrt5)/4 = {float(target):.6f}: {R2 < target}")
        say(R2 < target, f"the closed disc of radius {R} about P_1 lies in the interior of the capped strip")
    R = Fr(1852, 1000)
    say(not (T(R * R) < target), "R = 1.852 is beyond the critical radius (the disc reaches Q's colourless cone)")


if __name__ == "__main__":
    args = sys.argv[1:]
    if "--plant" in args:
        PLANT = args[args.index("--plant") + 1]
    which = [a for a in args if a in ("check", "disc")] or ["check", "disc"]
    if "check" in which:
        S, rows, bad, g = check()
        if PLANT is None:
            say(not bad and g > 1, "the capped strip ACCEPTs")
        elif PLANT == "cap_high":
            want = sorted((f"{k}{j}", f"{k}{j}") for j in range(3) for k in "TB")
            say(sorted(bad) == want, f"PLANT cap_high: REJECT at exactly the six capped self-pairs (got {sorted(bad)})")
        print("VERDICT:", "REJECT" if bad else "ACCEPT")
    if "disc" in which:
        disc()
    print("ALL AS REGISTERED" if OK else "SOME MISMATCH")
    sys.exit(0 if OK else 1)

#!/usr/bin/env python3
"""FS112-YB2's calibration of tools/fs112_yb2_check.py, in the order the brief and instance file set (claim list §7):

  1. FS-110's fragments, built by the FROZEN builders (tools/fs110_y_fragments.py, tools/fs110_y_cone.py, data/fs110/fs110-a6/a6_c2_single_horn.py;
     imported, never edited), converted exactly into my tower Q(sqrt 3), every same-colour pair (self included) checked by my checker AND by the
     frozen checker (tools/fs110_y_check.py) in the same process: the verdicts must agree PAIR BY PAIR, on the fragments, the frozen builders'
     planted faults, the tip tests, A6-C2's runs, and under the closed_interval plant in both checkers (same rejected pairs: tightness).
  2. CAL-7: row 33's brick seven-colouring (Proofs/HadwigerNelson/Instances/Seven.lean: 4/5 x 3/5 cells, row shear 2/5, colour (i + 3j) mod 7),
     with the variants the Lean module records as failing (c = 2, 4, 6; h = 1/2; w = 1; shear 0) and passing (c = 5 at shears 2/5 and 4/15);
     and the frozen checker's own hexagonal controls.
  3. YB's strip object (tools/fs112_yb_strip.py, run, never edited), converted exactly into my tower Q(sqrt 3)(sqrt 5): every orbit pair YB's
     checker examines, verdict pair by pair against YB's checker in the same process; YB's four object plants likewise; closed_interval in both.
Run: python3 tools/fs112_yb2_calib.py [frag|cal7|strip ...]   (default: all).  Exit status 0 iff every comparison agrees.
"""
from __future__ import annotations
import os
import sys
from fractions import Fraction as Fr

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
sys.path.insert(0, os.path.join(HERE, "..", "data", "fs110", "fs110-a6"))
import fs112_yb2_check as K2   # noqa: E402

T3 = K2.Tower.base().extend(3, "3")
R3 = T3.gen()


# ------------------------------------------------------------------ conversion from the frozen Q(sqrt 3) objects
def from_q3(x):
    return T3(x.a) + R3 * x.b


def _pt3(p):
    return (from_q3(p[0]), from_q3(p[1]))


def split_arc(C, rho, S, E, full=False):
    """my Arc pieces for the ccw arc S -> E (split exactly at quarter turns while the span is >= 180 degrees)."""
    out = []
    a = K2.vsub(S, C)
    if full or K2.veq(S, E):
        pts = [K2.vadd(C, a), K2.vadd(C, K2.perp(a)), K2.vadd(C, K2.vmul(-1, a)), K2.vadd(C, K2.vmul(-1, K2.perp(a)))]
        return [K2.Arc(C, rho, pts[i], pts[(i + 1) % 4]) for i in range(4)]
    while K2.cross(K2.vsub(S, C), K2.vsub(E, C)).sign() <= 0:      # span >= 180: peel a quarter turn
        M = K2.vadd(C, K2.perp(K2.vsub(S, C)))
        out.append(K2.Arc(C, rho, S, M))
        S = M
    out.append(K2.Arc(C, rho, S, E))
    return out


def conv_frozen(prims, Cmod):
    out = []
    for p in prims:
        if isinstance(p, Cmod.Seg):
            out.append(K2.Seg(_pt3(p.P), _pt3(p.Q)))
        else:
            out.extend(split_arc(_pt3(p.C), from_q3(p.r), _pt3(p.S), _pt3(p.E)))
    return out


def compare_fragment(label, T, Cmod, plant=None):
    """T: {name: (colour, frozen prims)}.  Returns (ok, n_pairs, my_bad, frozen_bad)."""
    names = sorted(T)
    pairs = [(a, b) for i, a in enumerate(names) for b in names[i:] if T[a][0] == T[b][0]]
    mine = {k: (c, conv_frozen(ps, Cmod)) for k, (c, ps) in T.items()}
    K2.PLANT = plant
    Cmod.PLANT = plant
    try:
        rows, bad, npres = K2.check_object(mine, pairs)
        fb = [(a, b) for (a, b) in pairs if Cmod.pair_verdict(T[a][1], T[b][1], self_pair=(a == b)) == "REJECT"]
    finally:
        K2.PLANT = None
        Cmod.PLANT = None
    ok = sorted(bad) == sorted(fb) and len(rows) == len(pairs) == npres
    print(f"  {'agree' if ok else 'DISAGREE':8s} {label:44s} pairs {len(rows)}/{npres}  mine {'REJECT ' + str(sorted(bad)) if bad else 'ACCEPT'}"
          f"  frozen {'REJECT ' + str(sorted(fb)) if fb else 'ACCEPT'}")
    return ok, len(rows), bad, fb


def run_fragments():
    import fs110_y_check as C
    import fs110_y_fragments as Fg
    import fs110_y_cone as Cn
    import a6_c2_single_horn as A6
    ok, npairs, nrej = True, 0, 0

    def tally(res):
        nonlocal ok, npairs, nrej
        ok &= res[0]
        npairs += res[1]
        nrej += len(res[2])

    print("== 1a. FS110-Y2's fragments (tools/fs110_y_fragments.py)")
    for name, f in Fg.FRAGS.items():
        tally(compare_fragment(name, f(), C))
    for pl in ("s1_flat", "t2_flip", "t2_flat", "t2_six", "bb_rot"):
        Fg.PLANT = pl
        try:
            for name, f in Fg.FRAGS.items():
                T = f()
                tally(compare_fragment(f"{name} under builder plant {pl}", T, C))
        finally:
            Fg.PLANT = None
    print("== 1b. FS110-Y4's cone fragments and tip tests (tools/fs110_y_cone.py)")
    for name, f in Cn.FRAGS.items():
        tally(compare_fragment(name, f(), C))
    for (name, f, want) in Cn.TIPS:
        tally(compare_fragment(f"{name} (frozen record: {want})", f(), C))
    print("== 1c. FS110-A6's card A6-C2 and its runs (data/fs110/fs110-a6/a6_c2_single_horn.py)")
    x = Cn.AM[0]
    runs = [("A6-C2", A6.frag())] + [(f"A6-C2 tip -> {j}", A6.frag(tipcol=j)) for j in (2, 3, 4, 5, 6)]
    runs += [("A6-C2 split y = 0", A6.split(A6.frag(tipcol=2), C.q(0))),
             ("A6-C2 split below Sigma(-1/3)", A6.split(A6.frag(tipcol=2), -x * x / 5)),
             ("A6-C2 split above Sigma(+1/3)", A6.split(A6.frag(tipcol=2), x * x / 5)),
             ("control: WC1H split y = 0", A6.split(Cn.build_trivalent_hard(tipcol=2), C.q(0))),
             ("A6-C2 plant deep", A6.frag(plant="deep"))]
    for name, T in runs:
        tally(compare_fragment(name, T, C))
    print("== 1d. both checkers under closed_interval (every exact contact at 1 becomes a REJECT: the fragments are tight)")
    for name, f in list(Fg.FRAGS.items()) + list(Cn.FRAGS.items()):
        tally(compare_fragment(f"{name} closed_interval", f(), C, plant="closed_interval"))
    print(f"== fragments: {npairs} pairs compared, {nrej} REJECT verdicts on my side, {'ALL AGREE' if ok else 'SOME DISAGREE'}")
    return ok


# ------------------------------------------------------------------ CAL-7
def brick_cell(i, j, w, h, s):
    q = T3
    x0 = q(w * i + s * j)
    y0 = q(h * j)
    P = [(x0, y0), (x0 + w, y0), (x0 + w, y0 + h), (x0, y0 + h)]
    return [K2.Seg(P[k], P[(k + 1) % 4]) for k in range(4)]


def brick_check(c, w, h, s, R=5):
    """cell (0,0) against itself and every same-colour cell with |i|, |j| <= R; beyond the window every cell is dismissed by an exact gap."""
    w, h, s = Fr(w), Fr(h), Fr(s)
    tiles = {"0,0": (0, brick_cell(0, 0, w, h, s))}
    pairs = [("0,0", "0,0")]
    for i in range(-R, R + 1):
        for j in range(-R, R + 1):
            if (i, j) != (0, 0) and (i + c * j) % 7 == 0:
                nm = f"{i},{j}"
                tiles[nm] = (0, brick_cell(i, j, w, h, s))
                pairs.append(("0,0", nm))
    rows, bad, _ = K2.check_object(tiles, pairs)
    # dismissal (exact): a cell outside the window has |j| > R, hence a vertical gap >= h R, or |j| <= R < |i|, hence a horizontal gap
    # >= w(|i| - 1) - s|j| >= R (w - s)  (0 <= s < w in every case run).  The squared bound is returned and must exceed 1.
    assert 0 <= s < w
    b = min(h * R, R * (w - s))
    return rows, bad, b * b


def run_cal7():
    ok = True
    print("== 2. CAL-7: row 33's brick seven-colouring and the variants its Lean module records")
    cases = [("sevenBrick c=3, 4/5 x 3/5, shear 2/5", 3, Fr(4, 5), Fr(3, 5), Fr(2, 5), "ACCEPT", None),
             ("closed_interval on sevenBrick (tight)", 3, Fr(4, 5), Fr(3, 5), Fr(2, 5), "REJECT", "closed_interval"),
             ("h = 1/2 (Lean: check false)", 3, Fr(4, 5), Fr(1, 2), Fr(2, 5), "REJECT", None),
             ("w = 1, shear 1/2 (Lean: check false)", 3, Fr(1), Fr(3, 5), Fr(1, 2), "REJECT", None),
             ("c = 2 (Lean: check false)", 2, Fr(4, 5), Fr(3, 5), Fr(2, 5), "REJECT", None),
             ("c = 4 (Lean: check false)", 4, Fr(4, 5), Fr(3, 5), Fr(2, 5), "REJECT", None),
             ("c = 6 (Lean: check false)", 6, Fr(4, 5), Fr(3, 5), Fr(2, 5), "REJECT", None),
             ("shear 0 (Lean: check false)", 3, Fr(4, 5), Fr(3, 5), Fr(0), "REJECT", None),
             ("c = 5, shear 2/5 (Lean: check true)", 5, Fr(4, 5), Fr(3, 5), Fr(2, 5), "ACCEPT", None),
             ("c = 5, shear 4/15 (Lean: check true)", 5, Fr(4, 5), Fr(3, 5), Fr(4, 15), "ACCEPT", None)]
    for label, c, w, h, s, want, plant in cases:
        K2.PLANT = plant
        try:
            rows, bad, g2 = brick_check(c, w, h, s)
        finally:
            K2.PLANT = None
        got = "REJECT" if bad else "ACCEPT"
        tight = [(a, b) for a, b, col, r in rows if r.mcmp == "=" or (a == b and r.Mcmp == "=")]
        good = got == want and g2 > 1
        ok &= good
        print(f"  {'ok' if good else 'MISMATCH':8s} {label:42s} want {want} got {got} {sorted(bad) if bad else ''}  pairs {len(rows)};"
              f" exact contacts at 1: {sorted(tight)}; beyond-window gap^2 >= {float(g2):.3f}")
    import fs110_y_check as C
    print("   the frozen checker's hexagonal and curved controls, converted:")
    q = C.q
    for (label, want, tiles, pairs) in frozen_controls(C):
        mine = {k: (0, conv_frozen(v, C)) for k, v in tiles.items()}
        rows, bad, _ = K2.check_object(mine, pairs)
        got = "REJECT" if bad else "ACCEPT"
        ok &= got == want
        print(f"  {'ok' if got == want else 'MISMATCH':8s} {label:42s} want {want} got {got}  pairs {len(rows)}")
    return ok


def frozen_controls(C):
    Fr_ = Fr
    out = []
    t, p = C.hex_colouring(Fr_(1, 2), lambda m, n: (m + 3 * n) % 7 == 0)
    out.append(("hex7 tight (side 1/2)", "ACCEPT", t, p))
    t, p = C.hex_colouring(Fr_(11, 20), lambda m, n: (m + 3 * n) % 7 == 0)
    out.append(("hex7 side 11/20 (diameter 1.1)", "REJECT", t, p))
    t, p = C.hex_colouring(Fr_(1, 2), lambda m, n: m % 2 == 0 and n % 2 == 0)
    out.append(("hex4 (index-4 sublattice)", "REJECT", t, p))
    return out


# ------------------------------------------------------------------ YB's strip
T35 = T3.extend(5, "5")


class YBConv:
    """exact conversion of YB's multiquadratic elements into the tower Q(sqrt p : p used), primes in YB's PRIMES order."""

    def __init__(self, KB, tiles):
        used = set()
        for (_, ps) in tiles.values():
            for p in ps:
                for x in self._elems(p):
                    for mask in x.c:
                        for i, pr in enumerate(KB.PRIMES):
                            if mask >> i & 1:
                                used.add(pr)
        T = K2.Tower.base()
        for pr in KB.PRIMES:
            if pr in used:
                T = T.extend(pr, str(pr))
        self.T, self.KB = T, KB
        self.gens = {pr: T.gen(i + 1) for i, pr in enumerate([p for p in KB.PRIMES if p in used])}

    @staticmethod
    def _elems(p):
        if p.kind == "S":
            return [p.P[0], p.P[1], p.Q[0], p.Q[1]]
        return [p.C[0], p.C[1], p.S[0], p.S[1], p.E[0], p.E[1], p.r]

    def num(self, x):
        v = self.T(0)
        for mask, a in x.c.items():
            term = self.T(a)
            for i, pr in enumerate(self.KB.PRIMES):
                if mask >> i & 1:
                    term = term * self.gens[pr]
            v = v + term
        return v

    def pieces(self, pieces):
        out = []
        pt = lambda p: (self.num(p[0]), self.num(p[1]))
        for p in pieces:
            if p.kind == "S":
                out.append(K2.Seg(pt(p.P), pt(p.Q)))
            else:
                out.extend(split_arc(pt(p.C), self.num(p.r), pt(p.S), pt(p.E), full=p.full))
        return out


def run_strip():
    import fs112_yb_strip as YS
    KB = YS.K
    ok = True
    print("== 3. YB's strip object (tools/fs112_yb_strip.py), pair by pair against YB's checker")
    cases = [("the strip (rho = 1)", dict(), None, None, "ACCEPT"),
             ("closed_interval (both checkers)", dict(), "closed_interval", "closed_interval", "REJECT"),
             ("YB plant rho11", dict(rho=Fr(11, 10)), None, None, "REJECT"),
             ("YB plant rho9", dict(rho=Fr(9, 10)), None, None, "REJECT"),
             ("YB plant tall", dict(plant="tall"), None, None, "REJECT"),
             ("YB plant colswap", dict(plant="colswap"), None, None, "REJECT")]
    for label, kw, myplant, ybplant, want in cases:
        S = YS.Strip(**kw)
        old = getattr(KB, "PLANT", None)
        KB.PLANT = ybplant
        try:
            rows, ybbad, gmin = YS.check_strip(S)
        finally:
            KB.PLANT = old
        allt = S.tiles(-12, 14)
        cv = YBConv(KB, {nm: allt[nm] for (a, b, c_, r_) in rows for nm in (a, b)})
        K2.PLANT = myplant
        try:
            mine_bad, nr, eq1 = [], 0, 0
            for (a, b, col, r) in rows:
                t1 = cv.pieces(allt[a][1])
                t2 = cv.pieces(allt[b][1])
                pr = K2.pair_verdict(t1, t2, self_pair=(a == b))
                nr += 1
                eq1 += (pr.mcmp == "=" or (a == b and pr.Mcmp == "="))
                if pr.verdict == "REJECT":
                    mine_bad.append((a, b))
        finally:
            K2.PLANT = None
        agree = sorted(mine_bad) == sorted(ybbad)
        got = "REJECT" if mine_bad else "ACCEPT"
        good = agree and got == want
        ok &= good
        print(f"  {'agree' if good else 'DISAGREE':8s} {label:34s} tower {cv.T}; orbit pairs {nr}; mine {got} ({len(mine_bad)} pairs) YB "
              f"{'REJECT' if ybbad else 'ACCEPT'} ({len(ybbad)} pairs); my exact contacts at 1: {eq1}; x-gap beyond window {float(gmin):.3f}")
        if not agree:
            print("     mine only:", sorted(set(mine_bad) - set(ybbad)), " YB only:", sorted(set(ybbad) - set(mine_bad)))
    return ok


if __name__ == "__main__":
    which = sys.argv[1:] or ["frag", "cal7", "strip"]
    ok = True
    if "frag" in which:
        ok &= run_fragments()
    if "cal7" in which:
        ok &= run_cal7()
    if "strip" in which:
        ok &= run_strip()
    print("CALIBRATION:", "ALL AGREE" if ok else "SOME DISAGREEMENT")
    sys.exit(0 if ok else 1)

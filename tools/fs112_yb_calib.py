#!/usr/bin/env python3
"""FS112-YB's calibration of its checker (tools/fs112_yb_check.py) in the claim list's order (data/fs112/claims.md §7):

  1. CAL-FRAGS: FS-110's fragments S1, T2, BB, MX (tools/fs110_y_fragments.py), WC, WC1, WCEQ, WCH, WC1H (tools/fs110_y_cone.py) and A6-C2
     (data/fs110/fs110-a6/a6_c2_single_horn.py), built by the FROZEN builders (imported, never edited), converted exactly into this checker's
     field, and checked PAIR BY PAIR against the frozen checker tools/fs110_y_check.py on the same pairs; also every planted fault of those
     builders and every tip/shave run, each of which must reproduce the frozen verdict and rejected-pair set.
  2. CAL-7: row 33's boundary-tight brick seven-colouring (Proofs/HadwigerNelson/Instances/Seven.lean: half-open 4/5 x 3/5 cells, each row
     shifted 2/5, colour (column + 3*row) mod 7), every same-colour pair of the cell (0,0) within reach; the rest dismissed by an exact gap bound.
     Plants beside it: cells of 4/5 x 3/5 with shear 2/5 but colour (column + 2*row) mod 7 (the kernel is then no ideal: a same-colour cell at
     offset (1, 3) lies at ... REJECT predicted), and cells enlarged to 81/100 x 3/5 (diagonal above 1: self-pair REJECT predicted).
Run: python3 tools/fs112_yb_calib.py
"""
from __future__ import annotations
import os
import sys
import itertools
from fractions import Fraction as Fr

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)
sys.path.insert(0, os.path.join(HERE, "..", "data", "fs110", "fs110-a6"))
import fs112_yb_check as K          # noqa: E402  (this job's checker)
import fs110_y_check as FC          # noqa: E402  (frozen: the calibration target)
import fs110_y_fragments as FF      # noqa: E402  (frozen builder)
import fs110_y_cone as FY           # noqa: E402  (frozen builder)
import a6_c2_single_horn as A6      # noqa: E402  (frozen builder)

R3 = K.F.sqrt(3)


def cv(x):
    """frozen Q3 (a + b sqrt3) -> this checker's field."""
    return K.F.of(x.a) + K.F.of(x.b) * R3


def cpt(p):
    return (cv(p[0]), cv(p[1]))


def cprim(p):
    if isinstance(p, FC.Seg):
        return K.Seg(cpt(p.P), cpt(p.Q))
    full = (p.S[0] == p.E[0] and p.S[1] == p.E[1])
    return K.Arc(cpt(p.C), cv(p.r), cpt(p.S), cpt(p.E), full=full)


def convert(T):
    return {k: (c, [cprim(p) for p in prims]) for k, (c, prims) in T.items()}


def compare(label, T, want=None, want_bad=None):
    """run the frozen checker and this one on every same-colour pair of T; report any per-pair disagreement."""
    names = sorted(T)
    pairs = [(a, b) for a, b in itertools.combinations_with_replacement(names, 2) if T[a][0] == T[b][0]]
    KT = convert(T)
    mine = K.check_fragment(KT)
    frozen_bad = []
    for a, b in pairs:
        v = FC.pair_verdict(T[a][1], T[b][1], self_pair=(a == b))
        if v == "REJECT":
            frozen_bad.append((a, b))
    my_bad = sorted(mine["bad"])
    agree = sorted(frozen_bad) == my_bad
    fv = "REJECT" if frozen_bad else "ACCEPT"
    ok = agree and (want is None or mine["verdict"] == want) and (want_bad is None or sorted(want_bad) == my_bad)
    ncontact = sum(1 for (_, _, _, r) in mine["rows"] if r.contacts)
    print(f"  {'ok' if ok else 'MISMATCH':8s} {label:48s} tiles {mine['tiles']:3d}  pairs examined {mine['examined']:3d} of "
          f"{mine['expected']:3d}  frozen {fv:6s} mine {mine['verdict']:6s}  pairs with an exact contact at 1: {ncontact}"
          + (f"  rejected {my_bad}" if my_bad else ""))
    if not agree:
        print("     frozen rejects", sorted(frozen_bad), " mine rejects", my_bad)
    assert mine["examined"] == mine["expected"] or K.PLANT == "noself"
    return ok


def cal_frags():
    ok = True
    print("== CAL-FRAGS: FS-110's fragments, pair by pair against the frozen checker")
    for name, f in FF.FRAGS.items():
        ok &= compare(f"{name} (fs110_y_fragments)", f(), "ACCEPT")
    for name, f in FY.FRAGS.items():
        ok &= compare(f"{name} (fs110_y_cone)", f(), "ACCEPT")
    ok &= compare("A6-C2 (a6_c2_single_horn)", A6.frag(), "ACCEPT")
    print("== the frozen builders' planted faults (each REJECT in the frozen record), rebuilt and compared")
    for plant, fr in [("s1_flat", "S1"), ("t2_flip", "T2"), ("t2_flat", "T2"), ("t2_six", "T2"), ("bb_rot", "BB")]:
        FF.PLANT = plant
        ok &= compare(f"{fr} plant {plant}", FF.FRAGS[fr](), "REJECT")
    FF.PLANT = None
    for plant, fr in [("wc_flat", "WC"), ("wc_fat", "WC"), ("wc_col2", "WC"), ("wch_ywide", "WCH"), ("eq_steep", "WCEQ")]:
        FY.PLANT = plant
        ok &= compare(f"{fr} plant {plant}", FY.FRAGS[fr](), "REJECT")
    FY.PLANT = None
    ok &= compare("WC1H plant wc1h_ylow", FY.build_trivalent_hard(plant="wc1h_ylow"), "REJECT")
    print("== the frozen tip tests and A6-C2's runs (verdicts and rejected pairs as recorded)")
    for (name, f, want) in FY.TIPS:
        ok &= compare(f"tip test {name}", f(), want)
    x = FY.AM[0]
    runs = [("A6-C2 tip -> 2", A6.frag(tipcol=2), "REJECT", [("tip", "xS")]),
            ("A6-C2 tip -> 3", A6.frag(tipcol=3), "REJECT", [("tip", "yN")]),
            ("A6-C2 tip -> 4", A6.frag(tipcol=4), "REJECT", [("r2", "tip"), ("r5", "tip"), ("r8", "tip")]),
            ("A6-C2 tip -> 5", A6.frag(tipcol=5), "REJECT", [("r1", "tip"), ("r4", "tip"), ("r7", "tip")]),
            ("A6-C2 tip -> 6", A6.frag(tipcol=6), "REJECT", [("r0", "tip"), ("r3", "tip"), ("r6", "tip")]),
            ("A6-C2 shave split y = 0", A6.split(A6.frag(tipcol=2), FC.q(0)), "REJECT", [("tipL", "yN"), ("tipU", "xS")]),
            ("A6-C2 shave split below", A6.split(A6.frag(tipcol=2), -x * x / 5), "REJECT", [("tipU", "xS")]),
            ("A6-C2 shave split above", A6.split(A6.frag(tipcol=2), x * x / 5), "REJECT", [("tipL", "yN")]),
            ("A6-C2 control: unbent WC1H split", A6.split(FY.build_trivalent_hard(tipcol=2), FC.q(0)), "ACCEPT", []),
            ("A6-C2 plant: curvature -1/2", A6.frag(plant="deep"), "REJECT", [("v2", "xS"), ("v3", "yN")])]
    for (name, T, want, wb) in runs:
        ok &= compare(name, T, want, wb)
    print("== the frozen checker's own planted faults, applied to IT, against this checker (closed_interval: every exact contact rejects)")
    FC.PLANT = "closed_interval"
    K.PLANT = "closed_interval"
    for name, f in list(FF.FRAGS.items()) + list(FY.FRAGS.items()):
        compare(f"{name} under closed_interval (both checkers)", f(), None)
    FC.PLANT = None
    K.PLANT = None
    return ok


# ------------------------------------------------------------------ CAL-7
def brick(i, j, w, h, s):
    x0 = i * w + j * s
    y0 = j * h
    a, b, c, d = K.pt(x0, y0), K.pt(x0 + w, y0), K.pt(x0 + w, y0 + h), K.pt(x0, y0 + h)
    return [K.Seg(a, b), K.Seg(b, c), K.Seg(c, d), K.Seg(d, a)]


def cal7(coef=3, w=Fr(4, 5), h=Fr(3, 5), s=Fr(2, 5), N=4, label="CAL-7"):
    """the cell (0,0) against every same-colour cell (i, j), |i|, |j| <= N, and itself. Beyond the window the cells are more than 1 away:
    exact bound printed. Every same-colour pair of the colouring is a translate of one of these (translation by a cell vector maps the
    colouring to itself up to a colour shift)."""
    col = lambda i, j: (i + coef * j) % 7
    T = {"c0,0": (0, brick(0, 0, w, h, s))}
    prs = [("c0,0", "c0,0")]
    for i in range(-N, N + 1):
        for j in range(-N, N + 1):
            if (i, j) != (0, 0) and col(i, j) == 0:
                nm = f"c{i},{j}"
                T[nm] = (0, brick(i, j, w, h, s))
                prs.append(("c0,0", nm))
    res = K.check_fragment(T, prs)
    # exact gap bound for cells outside the window: row gap (|j| - 1) h, or column gap (|i| - 1) w - |j| s
    gaps = []
    for j in range(-N - 1, N + 2):
        if abs(j) > N:
            gaps.append((abs(j) - 1) * h)
    for j in range(-N, N + 1):
        gaps.append((N + 1 - 1) * w - abs(j) * s)
    gmin = min(gaps)
    far_ok = gmin > 1
    contacts = sum(1 for (_, _, _, r) in res["rows"] if r.contacts)
    print(f"  {label:48s} pairs examined {res['examined']} (the cell (0,0) with itself and every same-colour cell with |i|,|j| <= {N}); "
          f"beyond: every cell at gap >= {gmin} ({'> 1: dismissed exactly' if far_ok else 'NOT > 1'}); verdict {res['verdict']}; "
          f"pairs with an exact contact at 1: {contacts}" + (f"; rejected {res['bad']}" if res['bad'] else ""))
    return res, far_ok


def cal_7():
    print("== CAL-7: row 33's boundary-tight brick seven-colouring, and two plants beside it")
    ok = True
    r, far = cal7()
    ok &= r["verdict"] == "ACCEPT" and far
    r2, _ = cal7(coef=2, label="plant: colour (i + 2j) mod 7")
    ok &= r2["verdict"] == "REJECT"
    r3, _ = cal7(w=Fr(81, 100), label="plant: cell 81/100 x 3/5 (diagonal > 1)")
    ok &= r3["verdict"] == "REJECT" and ("c0,0", "c0,0") in r3["bad"]
    K.PLANT = "closed_interval"
    r4, _ = cal7(label="CAL-7 under closed_interval (tightness)")
    K.PLANT = None
    ok &= r4["verdict"] == "REJECT"
    return ok


if __name__ == "__main__":
    a = cal_frags()
    b = cal_7()
    print("CALIBRATION", "ALL AS PREDICTED" if (a and b) else "SOME MISMATCH")
    sys.exit(0 if (a and b) else 1)

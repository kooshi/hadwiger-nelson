#!/usr/bin/env python3
"""J49 (FS-100 KT-1), part 2 of 2: [AmbrusEtAl2023]'s obligation H4 -- phi(t) >= 1 - mu on [0, 10^4] -- checked on J26's
own covering in BALL ARITHMETIC (arb, via python-flint).  Run with build/venv-flint/bin/python (flint + stdlib only).

Inputs, read directly: data/pa-ambrus2023/g23.csv (the certificate's weights, as exact rationals) and
data/fs100/kt1/j26-grid.json (written by tools/fs100_kt1_grid.py from J26's own code: which k J26 refined, and the exact
squared distances of the 26 w2 pairs).  The point list is regenerated here in Python floats and must reproduce the
exporter's sha256 bit for bit, or nothing is checked (exit 3).

What is certified (plans/FS100-KT1-ambrus-ball.md §1.4):
  W(t) = w0 J0(t) + w1 + sum w2 J0(t d)  -- an arb ball at every grid point t (an exact dyadic).
  Lipschitz constants, J26's formulas (J26-T2) with every factor enclosed:
    L_a = Lambda1 * (|w0| + sum |w2| d)                  on t >= 0     (used on cells with a < 100)
    L_b = C/sqrt(100)  * (|w0| + sum |w2| sqrt d)        on t >= 100   (cells with 100 <= a < 1000)
    L_c = C/sqrt(1000) * (|w0| + sum |w2| sqrt d)        on t >= 1000  (cells with a >= 1000)
  where C = sqrt(10 (J1(10)^2 + Y1(10)^2)) (|J1(u)| <= C/sqrt(u) for u >= 10: Watson §13.74, cited, as J26) and
  Lambda1 >= sup_{u >= 0} |J1(u)|, certified here: C/sqrt(10) on u >= 10; on [0, 10] a ball grid with the remainder
  |f| <= max(|f(a)|, |f(b)|) + M h^2/8, M = sup|J1''| <= 1 (J1'' = (J3 - 3 J1)/4, |Jn| <= 1 by Bessel's integral).
  Every cell a < b: LB = (W_lo(a) + W_lo(b))/2 - L (b - a)/2, exactly, from the balls' endpoints.

Verdicts and exit codes:
  0  CERTIFIED      every cell's LB >= 1 - mu
  1  INCONCLUSIVE   some cell's LB enclosure straddles 1 - mu (balls too wide)
  2  VIOLATED       a cell's LB is certified below 1 - mu (the covering fails; whether a POINT value is certified below
                    1 - mu -- H4 itself false -- is reported beside it), OR a Lipschitz constant supplied to the covering is
                    below its derived bound (INVALID-LIPSCHITZ), OR a cell's difference quotient certifiably exceeds the
                    constant (REFUTED-LIPSCHITZ)
  3  NOT RUN        the inputs are not J26's covering (sha256 mismatch, a malformed file): nothing was checked
Failures print a banner to stderr; success prints one line.

  build/venv-flint/bin/python tools/fs100_kt1_ball.py [--prec 80] [--jobs 16] [--window LO HI ...] [--plant NAME]
  build/venv-flint/bin/python tools/fs100_kt1_ball.py --self-test
Exact evaluation of a fixed finite set on an existing certificate: in under the 2026-09-24..10-01 ban (no search).
"""
from __future__ import annotations

import argparse
import csv
import hashlib
import json
import struct
import sys
import time
from fractions import Fraction
from multiprocessing import get_context
from pathlib import Path

from flint import arb, ctx, fmpq

ROOT = Path(__file__).resolve().parent.parent
CSV = ROOT / "data/pa-ambrus2023/g23.csv"
GRID = ROOT / "data/fs100/kt1/j26-grid.json"
MU = Fraction(6, 100000)
TARGET = 1 - MU                      # 0.99994: what Proposition 1 consumes after dividing by 1 - mu
CONST_PREC = 128                     # the constants are cheap; derive them at a fixed high precision
REFINE_AT = Fraction(5818, 10000)    # Lambda1: cells whose coarse bound reaches this are re-cut (fixed before running)
H0, H1 = Fraction(1, 1000), Fraction(1, 100000)


class NotRun(Exception):
    pass


# ---------------- exact data ----------------

def read_coeffs(path: Path):
    """w0, w1 (at vertex 1 only), and [(w2, i, j)], as exact rationals from the decimal strings of g23.csv."""
    w0 = w1 = None
    w2 = []
    n_w1 = 0
    for r in csv.reader(path.read_text().replace("\r", "").splitlines()):
        v, kind = Fraction(r[0]), r[1]
        if kind == "w_0":
            w0 = v
        elif kind == "w_1":
            if r[2] != "1":
                raise NotRun(f"w_1 at vertex {r[2]}; the paper has it at vertex 1 only")
            w1 = v
            n_w1 += 1
        elif kind == "w_2":
            w2.append((v, int(r[2]), int(r[3])))
        elif kind not in ("w_T", "w_C"):
            raise NotRun(f"unknown coefficient kind {kind!r}")
    if w0 is None or w1 is None or n_w1 != 1 or len(w2) != 26:
        raise NotRun(f"coefficients incomplete: w0={w0}, w1={w1}, #w2={len(w2)}")
    return w0, w1, w2


def regen_points(sel):
    """J26's grid (j26_ambrus_check.py lines 278-281, 314-316) in Python floats: the same IEEE operations as numpy's."""
    s = {0.0}
    s.update(k * 0.001 for k in range(1, 100001))
    for k in sel:
        s.update((k - 1) * 0.001 + j * 0.00001 for j in range(201))
    s.update(100 + k * 0.1 for k in range(1, 9001))
    s.update(1000 + k * 1.0 for k in range(1, 9001))
    return sorted(s)


def q2arb(q: Fraction) -> arb:
    return arb(fmpq(q.numerator, q.denominator))


def field2arb(t4) -> arb:
    """a + b sqrt3 + c sqrt11 + d sqrt33 from four rational strings."""
    a, b, c, d = (Fraction(x) for x in t4)
    return q2arb(a) + q2arb(b) * arb(3).sqrt() + q2arb(c) * arb(11).sqrt() + q2arb(d) * arb(33).sqrt()


def exact(x: arb) -> Fraction:
    """An exact arb (a dyadic) as a Fraction."""
    if not x.is_exact():
        raise AssertionError("exact() on a ball with nonzero radius")
    m, e = (int(v) for v in x.man_exp())
    return Fraction(m << e) if e >= 0 else Fraction(m, 1 << -e)


def upper(x: arb) -> Fraction:
    return exact(x.upper())


def lower(x: arb) -> Fraction:
    return exact(x.lower())


# ---------------- the constants ----------------

def derive_constants(w0, w2, d2):
    """Enclosures of J26's Lipschitz constants; returns dict of Fractions (upper endpoints) and a report."""
    ctx.prec = CONST_PREC
    rep = {}
    ds = []
    for v, i, j in w2:
        sq = field2arb(d2[f"{i},{j}"])
        if not sq > q2arb(Fraction(1, 100)):
            raise NotRun(f"d({i},{j})^2 not certified > 1/100: {sq}")
        ds.append(sq.sqrt())
    rep["d_min_lower"] = float(min(lower(d) for d in ds))
    ten = arb(10)
    C = (ten * (ten.bessel_j(1) ** 2 + ten.bessel_y(1) ** 2)).sqrt()
    # Lambda1 >= sup_{u >= 0} |J1(u)|
    tail = upper(C / ten.sqrt())                               # u >= 10
    vals = [upper(arb(fmpq(k, 1000)).bessel_j(1).abs_upper()) for k in range(10001)]
    lam = tail
    refined = 0
    for k in range(10000):
        cb = max(vals[k], vals[k + 1]) + H0 * H0 / 8
        if cb >= REFINE_AT:
            refined += 1
            sub = [upper(arb(fmpq(100 * k + m, 100000)).bessel_j(1).abs_upper()) for m in range(101)]
            cb = max(max(sub[m], sub[m + 1]) for m in range(100)) + H1 * H1 / 8
        lam = max(lam, cb)
    rep["Lambda1"] = float(lam)
    rep["Lambda1_refined_cells"] = refined
    rep["C_upper"] = float(upper(C))
    w0a = q2arb(abs(w0))
    S1 = w0a + sum(q2arb(abs(v)) * d for (v, _, _), d in zip(w2, ds))
    Sh = w0a + sum(q2arb(abs(v)) * d.sqrt() for (v, _, _), d in zip(w2, ds))
    L = {"a": upper(q2arb(lam) * S1),
         "b": upper(C / arb(10) * Sh),
         "c": upper(C / arb(1000).sqrt() * Sh)}
    rep["S1_upper"], rep["Sh_upper"] = float(upper(S1)), float(upper(Sh))
    # region validity: L_b, L_c need t*d >= 10 for t >= 100 (d_min >= 0.1 certified above; d = 1 for w0)
    return L, rep


# ---------------- the ball evaluation (workers) ----------------

_G: dict = {}


def _init(prec, w0s, w1s, terms):
    ctx.prec = prec
    _G["w0"] = q2arb(Fraction(w0s))
    _G["w1"] = q2arb(Fraction(w1s))
    _G["terms"] = [(q2arb(Fraction(v)), field2arb(d2).sqrt()) for v, d2 in terms]


def W_ball(t: float) -> arb:
    x = arb(t)
    if not x.is_exact():
        raise AssertionError("a grid point is not an exact dyadic")
    s = _G["w1"] + _G["w0"] * x.bessel_j(0)
    for w, d in _G["terms"]:
        s += w * (x * d).bessel_j(0)
    return s


def _eval_chunk(chunk):
    out = []
    for t in chunk:
        s = W_ball(t)
        lo, hi = s.lower(), s.upper()
        if not (lo <= s and s <= hi):
            raise AssertionError(f"endpoint enclosure failed at t = {t!r}")
        (m1, e1), (m2, e2) = lo.man_exp(), hi.man_exp()
        out.append((int(m1), int(e1), int(m2), int(e2)))
    return out


def _dy(m, e):
    return Fraction(m << e) if e >= 0 else Fraction(m, 1 << -e)


def dW_ball(t, w0, w2, d2, prec=CONST_PREC):
    """W'(t) = -w0 J1(t) - sum w2 d J1(t d) as a ball (supplementary checks)."""
    ctx.prec = prec
    x = arb(t) if isinstance(t, float) else q2arb(Fraction(t))
    s = -q2arb(w0) * x.bessel_j(1)
    for v, i, j in w2:
        d = field2arb(d2[f"{i},{j}"]).sqrt()
        s -= q2arb(v) * d * (x * d).bessel_j(1)
    return s


def supplementary(w0, w1, w2, d2, plant=None):
    """Two single-point ball checks beside H4 (not part of its exit code).
    S-H5: the tail t > 10^4 (paper eq. (23)): phi(t) >= w1 - (|w0| + sum|w2|) |J0(s)| for any zero s of J1 with
      s <= T d_min (Watson §15.31, cited); s is isolated in [999.8114, 999.8116] by a certified sign change of J1 and
      |J0| is enclosed over that whole interval.  Needs d_min >= 0.1 (certified in derive_constants).
    S-NB: the notebook's "Derivative is less than 0.03" on [1000, 10^4] (it bounds W' by max|J1(t)|, t > 1000): is
      |W'(1289.72)| certifiably above 0.03?  (t located by a double-precision scan -- a measurement; the claim is
      checked here by one ball.)"""
    ctx.prec = CONST_PREC
    w1p = w1 - Fraction(11, 1000) if plant == "h5_w1" else w1
    s1, s2 = arb(fmpq(9998114, 10000)), arb(fmpq(9998116, 10000))
    a1, a2 = s1.bessel_j(1), s2.bessel_j(1)
    sign_change = bool((a1 > 0 and a2 < 0) or (a1 < 0 and a2 > 0))
    J0I = s1.union(s2).bessel_j(0).abs_upper()
    S0 = q2arb(abs(w0) + sum(abs(v) for v, _, _ in w2))
    tail = q2arb(w1p) - S0 * J0I
    thr = Fraction(302, 10000) if plant == "nb_thr" else Fraction(3, 100)
    dW = dW_ball(1289.72, w0, w2, d2)
    nb_false = bool(dW.abs_lower() > q2arb(thr))
    return {"H5_sign_change_certified": sign_change, "H5_absJ0_upper": float(upper(J0I)),
            "H5_tail_enclosure": [float(lower(tail)), float(upper(tail))], "H5_tail_gt_1": bool(sign_change and tail > 1),
            "_tail_lo": lower(tail), "_tail_hi": upper(tail),
            "NB_dW_1289_72": [float(lower(dW)), float(upper(dW))], "NB_threshold": float(thr),
            "NB_constant_refuted": nb_false}


# ---------------- one run ----------------

def run(prec=80, jobs=16, windows=None, plant=None, grid_path=GRID, quiet=False):
    t0 = time.time()
    g = json.loads(Path(grid_path).read_text())
    pts = regen_points(g["sel"])
    digest = hashlib.sha256(struct.pack(f"<{len(pts)}d", *pts)).hexdigest()
    if digest != g["points_sha256"] or len(pts) != g["n_points"]:
        raise NotRun(f"regenerated grid sha256 {digest[:16]}… (n = {len(pts)}) != the exporter's "
                     f"{g['points_sha256'][:16]}… (n = {g['n_points']}): these are not J26's points")
    w0, w1, w2 = read_coeffs(CSV)
    if sorted([i, j] for _, i, j in w2) != sorted(g["w2_pairs"]):
        raise NotRun("the w2 pairs of g23.csv differ from the exporter's")
    target = TARGET
    if plant == "lowprec":
        prec = 12
    if plant == "target_past_min":
        target = Fraction(99996, 100000)
    if plant == "target_between":
        target = Fraction(999945, 1000000)

    L_der, rep = derive_constants(w0, w2, g["d2"])
    supp = supplementary(w0, w1, w2, g["d2"], plant)
    L_used = dict(L_der)
    if plant == "halfL":
        L_used["a"] = L_der["a"] / 2
    if plant == "tinyL":
        L_used["a"] = L_der["a"] / 16
    if plant == "notebookL":
        L_used = {"a": Fraction(1), "b": Fraction(1, 10), "c": Fraction(3, 100)}
    invalid = [r for r in "abc" if L_used[r] < L_der[r]]

    if windows:
        segs = [[t for t in pts if lo <= t <= hi] for lo, hi in windows]
    else:
        segs = [pts]
        if not (pts[0] == 0.0 and pts[-1] == 10000.0):
            raise NotRun("the grid does not span [0, 10000]")
    flat = [t for s in segs for t in s]
    terms = [(str(v), g["d2"][f"{i},{j}"]) for v, i, j in w2]
    chunks = [flat[k:k + 2000] for k in range(0, len(flat), 2000)]
    with get_context("fork").Pool(jobs, initializer=_init, initargs=(prec, str(w0), str(w1), terms)) as pool:
        res = [r for part in pool.imap(_eval_chunk, chunks) for r in part]
    if len(res) != len(flat):
        raise NotRun("a worker returned the wrong number of values")
    Wlo = {t: _dy(m1, e1) for t, (m1, e1, _, _) in zip(flat, res)}
    Whi = {t: _dy(m2, e2) for t, (_, _, m2, e2) in zip(flat, res)}
    t_eval = time.time() - t0

    best = None          # (LB_lo, a, b, LB_hi, region)
    min_hi = None        # min over cells of LB_hi
    refuted = []
    ncell = {"a": 0, "b": 0, "c": 0}
    wmax = {"a": Fraction(0), "b": Fraction(0), "c": Fraction(0)}
    for seg in segs:
        for a, b in zip(seg, seg[1:]):
            fa, fb = Fraction(a), Fraction(b)
            r = "a" if fa < 100 else ("b" if fa < 1000 else "c")
            ncell[r] += 1
            h = fb - fa
            wmax[r] = max(wmax[r], h)
            slack = L_used[r] * h / 2
            lb_lo = (Wlo[a] + Wlo[b]) / 2 - slack
            lb_hi = (Whi[a] + Whi[b]) / 2 - slack
            if best is None or lb_lo < best[0]:
                best = (lb_lo, a, b, lb_hi, r)
            if min_hi is None or lb_hi < min_hi:
                min_hi = lb_hi
            dq = max(Wlo[b] - Whi[a], Wlo[a] - Whi[b], Fraction(0))
            if dq > L_used[r] * h:
                refuted.append((a, b, r, float(dq / h)))
    below_pts = [t for t in flat if Whi[t] < target]
    tmin = min(flat, key=lambda t: Wlo[t])
    maxrad = max(Whi[t] - Wlo[t] for t in flat) / 2

    margin_lo = best[0] - target               # certified: every cell's LB >= target + margin_lo
    margin_hi = min_hi - target                # the covering's minimum lies in [margin_lo, margin_hi] + target
    reasons = []
    if invalid:
        reasons.append("INVALID-LIPSCHITZ")
    if refuted:
        reasons.append("REFUTED-LIPSCHITZ")
    if margin_hi < 0:
        reasons.append("VIOLATED")
    if reasons:
        verdict, code = "violated", 2
    elif margin_lo >= 0:
        verdict, code = "certified", 0
    else:
        verdict, code = "inconclusive", 1
    out = {
        "verdict": verdict, "exit": code, "reasons": reasons, "plant": plant, "prec": prec,
        "windows": windows, "target": str(target), "n_points": len(flat), "n_cells": ncell,
        "margin_certified_lower": float(margin_lo), "margin_enclosure": [float(margin_lo), float(margin_hi)],
        "margin_certified_lower_exact": str(margin_lo),
        "worst_cell": [best[1], best[2]], "worst_cell_region": best[4],
        "worst_cell_LB_enclosure": [float(best[0]), float(best[3])],
        "min_point_W_lower": float(Wlo[tmin]), "min_point_t": tmin, "min_point_W_upper": float(Whi[tmin]),
        "points_certified_below_target": len(below_pts), "first_point_below": below_pts[:3],
        "max_ball_radius": float(maxrad),
        "L_derived_upper": {r: float(v) for r, v in L_der.items()}, "L_used": {r: float(v) for r, v in L_used.items()},
        "L_invalid_regions": invalid, "refuted_cells": len(refuted), "refuted_examples": refuted[:3],
        "cell_width_max": {r: float(v) for r, v in wmax.items()},
        "constants_report": rep, "supplementary": {k: v for k, v in supp.items() if not k.startswith("_")},
        "grid_sha256": digest, "seconds": round(time.time() - t0, 1),
        "seconds_eval": round(t_eval, 1),
        "_exact": {"supp": supp, "margin_lo": margin_lo, "margin_hi": margin_hi, "L_der": L_der, "L_used": L_used, "wmax": wmax,
                   "target": target},
    }
    if not quiet:
        report(out)
    return out


def report(o):
    show = {k: v for k, v in o.items() if not k.startswith("_")}
    print(json.dumps(show, indent=1, default=str))
    if o["exit"] == 0:
        print(f"CERTIFIED: min certified margin {o['margin_certified_lower']:.6e} on cell {o['worst_cell']}")
        return
    bar = "!" * 100
    msg = [bar, f"!!! H4 NOT CERTIFIED -- verdict {o['verdict'].upper()} (exit {o['exit']}); reasons {o['reasons'] or ['balls straddle the target']}"]
    if "INVALID-LIPSCHITZ" in o["reasons"]:
        msg.append(f"!!! Lipschitz constant(s) supplied for region(s) {o['L_invalid_regions']} are BELOW the derived bound: "
                   f"used {o['L_used']} vs derived {o['L_derived_upper']} -- the covering argument as supplied is invalid")
    if "REFUTED-LIPSCHITZ" in o["reasons"]:
        msg.append(f"!!! {o['refuted_cells']} cell(s) have a difference quotient certifiably above the constant used, "
                   f"e.g. {o['refuted_examples']} -- that constant is not a Lipschitz constant of W")
    if "VIOLATED" in o["reasons"]:
        msg.append(f"!!! the covering's lower bound is certified BELOW the target {o['target']} at cell {o['worst_cell']}: "
                   f"LB in {o['worst_cell_LB_enclosure']}")
    if o["points_certified_below_target"]:
        msg.append(f"!!! {o['points_certified_below_target']} grid point(s) have W(t) certified below the target, e.g. "
                   f"t = {o['first_point_below']} -- H4 itself is FALSE at this mu")
    if o["verdict"] == "inconclusive":
        msg.append(f"!!! margin enclosure {o['margin_enclosure']} straddles 0; max ball radius {o['max_ball_radius']:.3e}")
    msg.append(bar)
    print("\n".join(msg), file=sys.stderr)


# ---------------- self-test ----------------

SELF_WINDOWS = [(0.85, 0.95), (3.70, 3.85)]


def self_test(jobs, grid_planted):
    fails = []

    def expect(cond, what):
        print(("  ok   " if cond else "  FAIL ") + what)
        if not cond:
            fails.append(what)

    print("--- faithful run on the self-test windows (must certify) ---")
    g = run(80, jobs, SELF_WINDOWS, None, quiet=True)
    expect(g["exit"] == 0 and not g["reasons"], f"faithful: exit {g['exit']}, margin {g['margin_certified_lower']:.3e}")
    gx = g["_exact"]

    print("--- plant halfL: L_a halved (must go red for INVALID-LIPSCHITZ, region a only) ---")
    p = run(80, jobs, SELF_WINDOWS, "halfL", quiet=True)
    px = p["_exact"]
    expect(p["exit"] == 2 and p["reasons"] == ["INVALID-LIPSCHITZ"] and p["L_invalid_regions"] == ["a"],
           f"halfL: exit {p['exit']}, reasons {p['reasons']}, regions {p['L_invalid_regions']}")
    expect(px["L_der"]["a"] / px["L_used"]["a"] == 2, "halfL: derived/used == 2 exactly")
    rise = px["margin_lo"] - gx["margin_lo"]
    expect(0 < rise <= px["L_used"]["a"] * gx["wmax"]["a"] / 2,
           f"halfL: 0 < margin rise {float(rise):.3e} <= (L_a/2) * max width / 2 = {float(px['L_used']['a'] * gx['wmax']['a'] / 2):.3e}")

    print("--- plant notebookL: the notebook's constants 1, 0.1, 0.03 (must be INVALID in all three regions) ---")
    p = run(80, jobs, SELF_WINDOWS, "notebookL", quiet=True)
    expect(p["exit"] == 2 and "INVALID-LIPSCHITZ" in p["reasons"] and p["L_invalid_regions"] == ["a", "b", "c"],
           f"notebookL: exit {p['exit']}, reasons {p['reasons']}, regions {p['L_invalid_regions']}")

    print("--- plant tinyL: L_a / 16 ~ 0.096 < max|W'| ~ 0.15 near t = 0.9 (must be REFUTED by difference quotients) ---")
    p = run(80, jobs, SELF_WINDOWS, "tinyL", quiet=True)
    expect(p["exit"] == 2 and "REFUTED-LIPSCHITZ" in p["reasons"] and "INVALID-LIPSCHITZ" in p["reasons"],
           f"tinyL: exit {p['exit']}, reasons {p['reasons']}")
    expect(0 < p["refuted_cells"] <= p["n_cells"]["a"] and all(0.85 <= e[0] <= 0.95 for e in p["refuted_examples"]),
           f"tinyL: 0 < {p['refuted_cells']} refuted cells <= {p['n_cells']['a']}, examples in [0.85, 0.95]")

    for name, tgt, pts_below in (("target_past_min", Fraction(99996, 100000), True),
                                 ("target_between", Fraction(999945, 1000000), False)):
        print(f"--- plant {name}: target {float(tgt)} (must be VIOLATED; points below target: {pts_below}) ---")
        p = run(80, jobs, SELF_WINDOWS, name, quiet=True)
        px = p["_exact"]
        expect(p["exit"] == 2 and p["reasons"] == ["VIOLATED"], f"{name}: exit {p['exit']}, reasons {p['reasons']}")
        expect((p["points_certified_below_target"] > 0) == pts_below,
               f"{name}: {p['points_certified_below_target']} points certified below target")
        drop = gx["margin_lo"] - px["margin_lo"]
        expect(0 < drop <= tgt - TARGET and drop == tgt - TARGET,
               f"{name}: margin drop {float(drop):.3e} == target shift {float(tgt - TARGET):.3e}")

    print("--- plant lowprec: 12-bit balls (must be INCONCLUSIVE, exit 1) ---")
    p = run(80, jobs, SELF_WINDOWS, "lowprec", quiet=True)
    px = p["_exact"]
    expect(p["exit"] == 1 and not p["reasons"], f"lowprec: exit {p['exit']}, reasons {p['reasons']}, "
           f"enclosure {p['margin_enclosure']}")
    wg, wp = gx["margin_hi"] - gx["margin_lo"], px["margin_hi"] - px["margin_lo"]
    expect(wg < wp and px["margin_lo"] <= gx["margin_hi"] and gx["margin_lo"] <= px["margin_hi"],
           f"lowprec: enclosure width {float(wp):.2e} > guarded {float(wg):.2e}, and the two enclosures overlap")

    sg = gx["supp"]
    expect(sg["H5_tail_gt_1"] and sg["NB_constant_refuted"],
           f"faithful supplementary: H5 tail {sg['H5_tail_enclosure']} > 1, notebook's 0.03 refuted at 1289.72 ({sg['NB_dW_1289_72']})")
    print("--- plant h5_w1: w1 lowered by 0.011 (the tail check must fail; its tail must drop by 0.011) ---")
    p = run(80, jobs, SELF_WINDOWS, "h5_w1", quiet=True)
    sp_ = p["_exact"]["supp"]
    d_lo, d_hi = sg["_tail_lo"] - sp_["_tail_hi"], sg["_tail_hi"] - sp_["_tail_lo"]
    expect(not sp_["H5_tail_gt_1"] and p["exit"] == 0, f"h5_w1: tail {sp_['H5_tail_enclosure']} not > 1; H4 unaffected (exit {p['exit']})")
    expect(d_lo <= Fraction(11, 1000) <= d_hi and d_hi - d_lo < Fraction(1, 10**20),
           "h5_w1: the tail's drop encloses exactly 0.011")
    print("--- plant nb_thr: threshold 0.0302 above |W'(1289.72)| ~ 0.03011 (the refutation must NOT fire) ---")
    p = run(80, jobs, SELF_WINDOWS, "nb_thr", quiet=True)
    expect(not p["_exact"]["supp"]["NB_constant_refuted"] and p["exit"] == 0, "nb_thr: not refuted at 0.0302; H4 unaffected")

    print("--- plant sel_drop: the exporter's grid with one refined k dropped (must be NOT RUN, exit 3) ---")
    try:
        run(80, jobs, SELF_WINDOWS, None, grid_path=grid_planted, quiet=True)
        expect(False, "sel_drop: ran on a grid that is not J26's")
    except NotRun as e:
        expect("not J26's points" in str(e), f"sel_drop: NotRun ({str(e)[:60]}…)")

    if fails:
        print("\n" + "!" * 100 + f"\n!!! SELF-TEST FAILED: {len(fails)} control(s): {fails}\n" + "!" * 100, file=sys.stderr)
        return 1
    print("\nSELF-TEST OK: the faithful windows certify, and every plant fired for its own reason with its bounds")
    return 0


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--prec", type=int, default=80)
    ap.add_argument("--jobs", type=int, default=16)
    ap.add_argument("--window", type=float, nargs=2, action="append")
    ap.add_argument("--plant", choices=["halfL", "notebookL", "tinyL", "target_past_min", "target_between", "lowprec",
                                        "h5_w1", "nb_thr"])
    ap.add_argument("--grid", default=str(GRID))
    ap.add_argument("--json-out")
    ap.add_argument("--self-test", action="store_true")
    ap.add_argument("--grid-planted", default=str(ROOT / "data/fs100/kt1/j26-grid-plant-sel_drop.json"))
    a = ap.parse_args()
    if a.self_test:
        sys.exit(self_test(a.jobs, a.grid_planted))
    try:
        o = run(a.prec, a.jobs, a.window, a.plant, grid_path=a.grid)
    except NotRun as e:
        print("!" * 100 + f"\n!!! NOT RUN (exit 3): {e}\n" + "!" * 100, file=sys.stderr)
        sys.exit(3)
    if a.json_out:
        Path(a.json_out).write_text(json.dumps({k: v for k, v in o.items() if not k.startswith("_")},
                                               indent=1, default=str) + "\n")
    sys.exit(o["exit"])


if __name__ == "__main__":
    main()

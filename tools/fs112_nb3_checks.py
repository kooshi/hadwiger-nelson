#!/usr/bin/env python3
"""FS112-NB3 exact checks of derived claims (blind stage 1). Exact rational arithmetic only; no search for objects.

Each check returns (verdict, reason). A plant must turn exactly its own check red with its own reason.

  RAYR  f~^k(-1) = -1/(k+1) exactly (k <= 60), f~ = f^{-1}, f~ increasing: the lower bound of N3-RAYR.
  STEP  f(l) <= l and f~(u) >= u on a rational grid of (-1,1), equality only at 0; a step with both
        bounds unchanged forces l = u = 0 (N3-STEP).
  LEN   longest sequence of pairs (l_k < u_k) from K with l_k <= f(l_{k+1}), f~(u_k) <= u_{k+1}: <= 2|K|-3
        (hence <= 2|K|-1, N3-LEN), exhaustive dynamic programme over pairs for each K listed.
  FAIL  first-order vote model at a leaving centre q of a cubic u (one or two arcs of u on w(q)):
        the strip fails exactly in the middle configurations, and there inside allows only inner colours of
        M, outside only outer colours (N3-FAIL).
  COR3  side-cone forcing at a crossing w of w(u), w(v) (close complementary pair): (a) if v's strip holds
        on either side, some probe direction has no admissible colour; (b) if both strips fail, the probes
        force an inner and an outer colour of u's arcs and of v's arcs: >= 4 colours at w (N3-COR3).

Usage: python3 tools/fs112_nb3_checks.py [--plant NAME] | --selftest
"""
from fractions import Fraction as Fr
import itertools
import sys

PLANTS = {"rayr_f", "step_flip", "len_nonstrict", "fail_vote", "cor3_nou1"}


def f(x):
    return x / (1 + x)


def ft(x):
    return x / (1 - x)


def check_rayr(plant=None):
    g = ft if plant != "rayr_f" else f
    lam = Fr(-1)
    for k in range(0, 61):
        if lam != Fr(-1, k + 1):
            return "RED", f"MISMATCH at k={k}: {lam} != {Fr(-1, k + 1)}"
        if plant == "rayr_f" and k == 0:
            try:
                lam = g(lam)
            except ZeroDivisionError:
                return "RED", "POLE: f(-1) undefined (f used in place of f~)"
            continue
        lam = g(lam)
    # f~ is f^{-1}
    for x in [Fr(n, 37) for n in range(-36, 37)]:
        if f(ft(x)) != x:
            return "RED", f"NOT_INVERSE at {x}"
    return "GREEN", "EXACT (f~^k(-1) = -1/(k+1), k<=60; f(f~(x)) = x on 73 rationals)"


def check_step(plant=None):
    grid = [Fr(n, 41) for n in range(-40, 41)]
    for x in grid:
        fx, ftx = f(x), ft(x)
        le = (fx <= x) if plant != "step_flip" else (fx >= x)
        if not le:
            return "RED", f"F_NOT_BELOW at {x}"
        if (fx == x) != (x == 0):
            return "RED", f"F_EQUALITY_OFF_ZERO at {x}"
        if not (ftx >= x) or ((ftx == x) != (x == 0)):
            return "RED", f"FT_NOT_ABOVE at {x}"
    # both unchanged along a step: l_k = l_{k+1} needs l = 0, u_k = u_{k+1} needs u = 0, against l < u
    return "GREEN", "EXACT (81 rationals): f(x) <= x, f~(x) >= x, equality only at 0"


def longest_chain(K, strict=True, relations=True):
    pairs = [(l, u) for l in K for u in K if (l < u if strict else l <= u)]

    def ok(p, q):  # p = (l_k, u_k), q = (l_{k+1}, u_{k+1})
        (l0, u0), (l1, u1) = p, q
        if relations:
            return l1 > -1 and u0 < 1 and l0 <= f(l1) and ft(u0) <= u1
        return l0 <= l1 and u0 <= u1 and (l0 < l1 or u0 < u1)

    best = {}
    # order by potential: relations imply l, u non-decreasing with one strict, so sort by (l+u)
    for p in sorted(pairs, key=lambda t: (t[0] + t[1], t)):
        best[p] = 1 + max([best[q] for q in best if ok(q, p)], default=0)
    return max(best.values(), default=0)


def check_len(plant=None):
    Ks = [
        [Fr(-1, 2), Fr(0)],
        [Fr(-1, 2), Fr(-1, 3), Fr(0)],
        [Fr(-1), Fr(-1, 2), Fr(-1, 3), Fr(-1, 4), Fr(0)],
        [Fr(-1, 2), Fr(-1, 5), Fr(0), Fr(1, 5), Fr(1, 2)],
        [Fr(n, 7) for n in range(-6, 7)],
    ]
    for K in Ks:
        m = len(K)
        if plant == "len_nonstrict":
            L = longest_chain(K, strict=False, relations=False)
        else:
            L = longest_chain(K)
        if L > 2 * m - 1:
            return "RED", f"OVER_N3_BOUND |K|={m}: {L} > {2*m-1}"
        if L > 2 * m - 3:
            return "RED", f"OVER_NB3_BOUND |K|={m}: {L} > {2*m-3} (N3's 2|K|-1 holds)"
    return "GREEN", "EXACT: longest chain <= 2|K|-3 on 5 sets (so <= 2|K|-1)"


# ---- FAIL: first-order vote model. u = 0, q = (1,0); the leaving arc 45 leaves u at 90 deg on w(q),
# sector 5 on its right (inner, toward q), 4 on its left (outer). Sectors: 4 = (90, t46), 6 = (t46, t56),
# 5 = (t56, 450). Seen from outside Omega (|z-u| > 1): a sector with a direction in (270, 450) mod 360;
# from inside: a sector with a direction in (90, 270). The leaving arc itself gives no vote.
def seen(sectors, side):
    out = set()
    for col, (a, b) in sectors.items():
        # open interval (a, b) of directions, degrees, a < b <= a + 360
        lo, hi = (Fr(270), Fr(450)) if side == "out" else (Fr(90), Fr(270))
        for shift in (-360, 0, 360):
            if max(a, lo + shift) < min(b, hi + shift):
                out.add(col)
    return out


def check_fail(plant=None):
    M = {4, 5, 6}
    res = []
    # single leaving arc: t46 in (90, 450), t56 in (t46, 450), neither at 270 (generic first order)
    angles = [Fr(n) for n in (100, 150, 200, 260, 280, 330, 400, 440)]
    for t46, t56 in itertools.combinations(angles, 2):
        sectors = {4: (Fr(90), t46), 6: (t46, t56), 5: (t56, Fr(450))}
        if plant == "fail_vote":  # the leaving arc bent off w(q) into B(q,1): its direction moves to 89 deg and it votes
            sectors = {4: (Fr(89), t46), 6: (t46, t56), 5: (t56, Fr(360) + Fr(89))}
        allow_in = M - seen(sectors, "in")
        allow_out = M - seen(sectors, "out")
        fails = bool(allow_in) and bool(allow_out)
        middle = t46 < 270 < t56
        if fails != middle:
            return "RED", f"FAIL_NOT_MIDDLE t46={t46} t56={t56} in={allow_in} out={allow_out}"
        if fails and (allow_in != {5} or allow_out != {4}):
            return "RED", f"NOT_INNER_OUTER t46={t46} t56={t56} in={allow_in} out={allow_out}"
        res.append(fails)
    # double leaving arcs on w(q): case A: 45 up (90) and 46 down (270): 4 = (90,270), 6 = (270, t56), 5 = (t56, 450)
    for t56 in (Fr(300), Fr(360), Fr(420)):
        sectors = {4: (Fr(90), Fr(270)), 6: (Fr(270), t56), 5: (t56, Fr(450))}
        ai, ao = M - seen(sectors, "in"), M - seen(sectors, "out")
        if not (ai == {5, 6} and ao == {4}):
            return "RED", f"DOUBLE_A in={ai} out={ao}"
    # case B: 45 up (90) and 56 down (270): 5 = (270, 450) inner, 4 = (90, t46), 6 = (t46, 270)
    for t46 in (Fr(120), Fr(180), Fr(240)):
        sectors = {4: (Fr(90), t46), 6: (t46, Fr(270)), 5: (Fr(270), Fr(450))}
        ai, ao = M - seen(sectors, "in"), M - seen(sectors, "out")
        if not (ai == {5} and ao == {4, 6}):
            return "RED", f"DOUBLE_B in={ai} out={ao}"
    return "GREEN", f"EXACT (first order): {sum(res)} of {len(res)} single configurations fail, exactly the middle ones, inner in / outer out; both doubles as derived"


# ---- COR3: w = 0, u at 180 deg, v at 180 - theta (unit distance each). Directions in degrees mod 360.
def inopen(d, a, b):
    d = d % 360
    for s in (-360, 0, 360):
        if a + s < d < b + s:
            return True
    return False


def inclosed(d, a, b):
    d = d % 360
    for s in (-360, 0, 360):
        if a + s <= d <= b + s:
            return True
    return False


def arc_cones(base, orient, ell):
    """unit arc of w(w) from the point at angle `base` going cw (-) or ccw (+), angular length ell.
    returns (F, A, S1, S2): facing closed, away closed, side cones open."""
    if orient == "cw":
        F = (base - 90, base + 90 - ell)
        A = (base + 90, base + 270 - ell)
        S = [(base - 90 - ell, base - 90), (base + 90 - ell, base + 90)]
    else:
        F = (base - 90 + ell, base + 90)
        A = (base + 90 + ell, base + 270)
        S = [(base - 90, base - 90 + ell), (base + 90, base + 90 + ell)]
    return F, A, S


def configs(cols):
    i, o, j = cols  # inner, outer, third
    return {
        "single_cw": ([("cw", i, o)], {i}, {o}),
        "single_ccw": ([("ccw", i, o)], {i}, {o}),
        "double_A": ([("cw", i, o), ("ccw", j, o)], {i, j}, {o}),
        "double_B": ([("cw", i, o), ("ccw", i, j)], {i}, {o, j}),
    }


def admissible(d, uarcs, varcs, Xu, Xv, theta, ell, ellv, vmode, plant):
    in_u = inopen(d, 90, 270)
    in_v = inopen(d, 90 - theta, 270 - theta)
    part_u = Xu[0] if in_u else Xu[1]
    if vmode == "fail":
        part_v = Xv[0] if in_v else Xv[1]
        cand = set(part_u) | set(part_v)
    else:  # v's strip holds on side vmode ('in' or 'out'): colours there lie in M = u's colours
        cand = set(part_u)
    for (arcs, base, L) in ((uarcs, 180, ell), (varcs, 180 - theta, ellv)):
        if arcs is None:
            continue
        for (orient, s_in, s_out) in arcs:
            F, A, S = arc_cones(base, orient, L)
            if plant == "cor3_nou1":  # drop N112-U1 at w altogether (side cones and facing/away cones)
                continue
            if any(inopen(d, *s) for s in S):
                cand -= {s_in, s_out}
            if not inclosed(d, *F):
                cand.discard(s_in)
            if not inclosed(d, *A):
                cand.discard(s_out)
    return cand


def check_cor3(plant=None):
    eps = Fr(1, 100)
    thetas = [Fr(n) for n in (3, 30, 60, 90, 120, 150, 177)]
    ells, ellvs = [Fr(5), Fr(20), Fr(50)], [Fr(7), Fr(30)]
    U, V = configs((5, 4, 6)), configs((2, 1, 3))
    n_fail = n_hold = n_empty = n_overlap = 0
    for theta in thetas:
        for ell in ells:
            for ellv in ellvs:
                probes_u = [Fr(90) - eps, Fr(90) + eps, Fr(270) - eps, Fr(270) + eps]
                probes_v = [p - theta for p in probes_u]
                for un, (uarcs, Xui, Xuo) in U.items():
                    # (a) v's strip holds on a side: some probe near t_u inside that side is empty
                    for side in ("in", "out"):
                        ps = [p for p in probes_u if inopen(p, 90 - theta, 270 - theta) == (side == "in")]
                        empties = [p for p in ps if not admissible(p, uarcs, None, (Xui, Xuo), None, theta, ell, ellv, side, plant)]
                        if not empties:
                            return "RED", f"HOLD_NO_EMPTY u={un} theta={theta} ell={ell} side={side}"
                        n_hold += 1
                    # (b) both fail
                    for vn, (varcs, Xvi, Xvo) in V.items():
                        ukind = "cw" in [a[0] for a in uarcs] and "ccw" in [a[0] for a in uarcs]
                        # skip configurations whose arcs would overlap on w(w)
                        spans = []
                        for (o, _, _) in uarcs:
                            spans.append((Fr(180) - ell, Fr(180)) if o == "cw" else (Fr(180), Fr(180) + ell))
                        vspans = []
                        for (o, _, _) in varcs:
                            b = Fr(180) - theta
                            vspans.append((b - ellv, b) if o == "cw" else (b, b + ellv))
                        if any(max(a[0], b[0]) < min(a[1], b[1]) for a in spans for b in vspans):
                            n_overlap += 1
                            continue
                        adm = {p: admissible(p, uarcs, varcs, (Xui, Xuo), (Xvi, Xvo), theta, ell, ellv, "fail", plant)
                               for p in probes_u + probes_v}
                        if any(not s for s in adm.values()):
                            n_empty += 1
                            continue  # the configuration is itself impossible: stronger than needed
                        forced = {
                            "u_in": any(s <= Xui for s in adm.values()),
                            "u_out": any(s <= Xuo for s in adm.values()),
                            "v_in": any(s <= Xvi for s in adm.values()),
                            "v_out": any(s <= Xvo for s in adm.values()),
                        }
                        if not all(forced.values()):
                            return "RED", f"NOT_FOUR u={un} v={vn} theta={theta} ell={ell} ellv={ellv} forced={forced}"
                        n_fail += 1
    return "GREEN", (f"EXACT (angles): {n_hold} strip-holds cases each with an empty probe; {n_fail} both-fail cases each forcing an inner "
                     f"and an outer colour of u and of v; {n_empty} both-fail cases impossible outright (an empty probe); {n_overlap} skipped (arcs overlap)")


CHECKS = {"RAYR": check_rayr, "STEP": check_step, "LEN": check_len, "FAIL": check_fail, "COR3": check_cor3}
PLANT_OF = {"rayr_f": "RAYR", "step_flip": "STEP", "len_nonstrict": "LEN", "fail_vote": "FAIL", "cor3_nou1": "COR3"}


def run(plant=None):
    out = {}
    for name, fn in CHECKS.items():
        out[name] = fn(plant)
    return out


def main():
    args = sys.argv[1:]
    if args and args[0] == "--selftest":
        faithful = run()
        ok = all(v == "GREEN" for v, _ in faithful.values())
        print("faithful:", "PASS" if ok else "FAIL")
        for n, (v, r) in faithful.items():
            print(f"  {n}: {v} {r}")
        bad = not ok
        for p, target in PLANT_OF.items():
            res = run(p)
            reds = [n for n, (v, _) in res.items() if v == "RED"]
            status = "FIRES" if reds == [target] else "DEFECT"
            bad |= status != "FIRES"
            print(f"plant {p}: {status} -> {target}: {res[target][1]}; reds={reds}")
        print("SELFTEST", "PASS" if not bad else "FAIL")
        sys.exit(1 if bad else 0)
    plant = args[1] if args and args[0] == "--plant" else None
    res = run(plant)
    for n, (v, r) in res.items():
        print(f"{n}: {v} {r}")
    sys.exit(0 if all(v == "GREEN" for v, _ in res.values()) else 1)


if __name__ == "__main__":
    main()

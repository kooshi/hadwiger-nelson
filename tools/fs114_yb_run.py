#!/usr/bin/env python3
"""FS114-YB's drivers.  Every verdict is exact (tools/fs114_yb_exact.py); every ACCEPT prints the pairs examined against the pairs the object has.

Run:  python3 tools/fs114_yb_run.py selftest           the checker's controls and its four checker plants
      python3 tools/fs114_yb_run.py calib              brick, hexagonal 7, strip, disk, FS112-BOWTIE (+ object plants beside faithful twins)
      python3 tools/fs114_yb_run.py capped             object 1: the capped strip (self-pairs first), its disc, its plants
      python3 tools/fs114_yb_run.py pent               object 2: the disk's identities and PENT's geometry
      python3 tools/fs114_yb_run.py move               object 3: the moved disk, ROUTES at my own points
      python3 tools/fs114_yb_run.py straddle-strip     the strip's straddle relation on a window (statements 4, 5)
      python3 tools/fs114_yb_run.py straddle-disk      the disk's straddle relation, all 325 pairs (statement 6)
"""
from __future__ import annotations
import os
import sys
import time
from fractions import Fraction as Fr

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import fs114_yb_exact as X      # noqa: E402
import fs114_yb_objects as O    # noqa: E402

Seg, Arc, Tile = X.Seg, X.Arc, X.Tile


def verdict_line(r):
    tags = []
    if r.min_eq1:
        tags.append("min=1")
    if r.max_eq1:
        tags.append("max=1")
    if r.touch and r.A is not r.B:
        tags.append("touch")
    return f"{'REJECT' if r.reject else 'ACCEPT'} {r.A.name}|{r.B.name} ({r.n} cands{'; ' + ', '.join(tags) if tags else ''})"


def check_finite(tiles, label, show=False, plant=None):
    """every same-colour pair of a finite object, a tile with itself included."""
    X.PLANT = plant
    t0 = time.time()
    pairs = []
    for i, a in enumerate(tiles):
        for b in tiles[i:]:
            if a.colour == b.colour:
                pairs.append((a, b))
    examined = dismissed = 0
    rej, tight_min, tight_max = [], [], []
    for a, b in pairs:
        if (plant == "noself") and a is b:
            dismissed += 1
            continue
        if a is not b and X.bbox_gap_ge1(a, b):
            dismissed += 1
            continue
        r = X.pair(a, b)
        examined += 1
        if r.reject:
            rej.append(r)
        if r.min_eq1:
            tight_min.append(r)
        if r.max_eq1:
            tight_max.append(r)
        if show:
            print("   " + verdict_line(r))
    X.PLANT = None
    ok = not rej
    print(f"{label}: {'ACCEPT' if ok else 'REJECT'} -- same-colour pairs the object has: {len(pairs)} (a tile with itself included); examined exactly "
          f"{examined}; dismissed by an exact bounding-box gap >= 1: {dismissed - (len([1 for a, b in pairs if a is b]) if plant == 'noself' else 0)}"
          f"{'; self-pairs skipped (plant noself): ' + str(len([1 for a, b in pairs if a is b])) if plant == 'noself' else ''}; "
          f"tight at 1: {len(tight_max)} maxima, {len(tight_min)} minima; {time.time() - t0:.1f} s")
    for r in rej:
        print("   " + verdict_line(r))
    return rej, tight_min, tight_max


def check_periodic(base, window, label, key=None, plant=None, show=False):
    """each base tile against every same-colour tile of the window (itself included), deduplicated by `key` (an orbit key of a pair)."""
    X.PLANT = plant
    t0 = time.time()
    seen = {}
    examined = dismissed = 0
    rej, tmin, tmax = [], [], []
    for a in base:
        for b in window:
            if a.colour != b.colour:
                continue
            k = key(a, b) if key else (a.name, b.name)
            if k in seen:
                continue
            seen[k] = True
            if plant == "noself" and a is b:
                continue
            if a is not b and X.bbox_gap_ge1(a, b):
                dismissed += 1
                continue
            r = X.pair(a, b)
            examined += 1
            if r.reject:
                rej.append(r)
            if r.min_eq1:
                tmin.append(r)
            if r.max_eq1:
                tmax.append(r)
            if show:
                print("   " + verdict_line(r))
    X.PLANT = None
    ok = not rej
    print(f"{label}: {'ACCEPT' if ok else 'REJECT'} -- orbit pairs in the window: {len(seen)}; examined exactly {examined}; dismissed by an exact "
          f"bounding-box gap >= 1: {dismissed}; tight at 1: {len(tmax)} maxima, {len(tmin)} minima; {time.time() - t0:.1f} s")
    for r in rej:
        print("   " + verdict_line(r))
    return rej, tmin, tmax


# =================================================================================== self-test
def selftest():
    Tq = X.Tower.base()
    T3 = Tq.extend(3, "3")
    r3 = T3.gen(1)

    def P(x, y, T=Tq):
        return (T(Fr(x)), T(Fr(y)))
    one = Tq(1)
    # arithmetic
    T2 = Tq.extend(2, "2")
    s2 = T2.gen(1)
    assert (s2 * s2 - 2).is0() and (s2 - Fr(14142, 10000)).sign() > 0 and (s2 - Fr(14143, 10000)).sign() < 0
    Tn = T2.extend(3 + s2, "3+s2")
    g = Tn.gen(2)
    assert (g * g - 3 - Tn(s2)).is0() and abs(float(g) - (3 + 2 ** 0.5) ** 0.5) < 1e-12
    assert (g.inv() * g - 1).is0()
    print("arithmetic: sqrt2 bounds, sqrt(3 + sqrt2) squared, inversion -- exact")
    ctr = []
    # 1 Reuleaux triangle of width 1
    a, b, c = P(0, 0, T3), P(1, 0, T3), (T3(Fr(1, 2)), r3 / 2)
    o3 = T3(1)
    reu = Tile("reuleaux", 1, [Arc(c, o3, a, b, True), Arc(a, o3, b, c, True), Arc(b, o3, c, a, True)])
    ctr.append(("Reuleaux triangle, width 1, against itself", reu, reu, "ACCEPT"))
    # 2, 3 rectangles of diagonal 99/100 and 106/100
    def rect(x0, y0, w, h, nm, col=1):
        return Tile(nm, col, O.poly([P(x0, y0), P(x0 + w, y0), P(x0 + w, y0 + h), P(x0, y0 + h)]))
    r99 = rect(0, 0, Fr(3, 5) * Fr(99, 100), Fr(4, 5) * Fr(99, 100), "rect-0.99")
    r106 = rect(0, 0, Fr(3, 5) * Fr(106, 100), Fr(4, 5) * Fr(106, 100), "rect-1.06")
    ctr.append(("rectangle of diagonal 0.99 against itself", r99, r99, "ACCEPT"))
    ctr.append(("rectangle of diagonal 1.06 against itself", r106, r106, "REJECT"))
    # 4, 5 squares at gap 9/10 and exactly 1
    s1 = rect(0, 0, Fr(1, 2), Fr(1, 2), "sq-a")
    s9 = rect(Fr(1, 2) + Fr(9, 10), 0, Fr(1, 2), Fr(1, 2), "sq-gap0.9")
    s10 = rect(Fr(1, 2) + 1, 0, Fr(1, 2), Fr(1, 2), "sq-gap1")
    ctr.append(("two squares at gap 9/10", s1, s9, "REJECT"))
    ctr.append(("two squares at gap exactly 1 (tight)", s1, s10, "ACCEPT"))
    # 6 crossing bars, every critical candidate at least 1.9
    bar1 = rect(-2, Fr(-1, 20), 4, Fr(1, 10), "bar-h")
    bar2 = rect(Fr(-1, 20), -2, Fr(1, 10), 4, "bar-v")
    ctr.append(("two long bars crossing (a crossing only the intersection test sees)", bar1, bar2, "REJECT"))
    # 7 a unit cap facing a bar: the nearest pair interior to the arc and to the bar's side
    cap = Tile("cap", 1, [Arc(P(0, 0), one, P(Fr(3, 5), Fr(4, 5)), P(Fr(-3, 5), Fr(4, 5)), True), Seg(P(Fr(-3, 5), Fr(4, 5)), P(Fr(3, 5), Fr(4, 5)))])
    barc = rect(Fr(-1, 5), Fr(19, 10), Fr(2, 5), Fr(1, 10), "bar-above-cap")
    ctr.append(("a cap facing a bar, nearest pair interior to both (0.9)", cap, barc, "REJECT"))
    barw = rect(-2, Fr(19, 10), 4, Fr(1, 10), "wide-bar-above-cap")
    ctr.append(("a cap facing a wide bar: only the interior-interior pair is below 1", cap, barw, "REJECT"))
    results = {}
    PL = (None, "noself", "closed_interval", "no_intersect", "endpoints_only", "no_interior")
    for plant in PL:
        X.PLANT = plant
        row = []
        for lbl, A, B, exp in ctr:
            if plant == "noself" and A is B:
                v = "ACCEPT"      # the driver skips self pairs under noself
            else:
                v = "REJECT" if X.pair(A, B).reject else "ACCEPT"
            row.append(v)
        results[plant] = row
        X.PLANT = None
    print("control | expected | faithful | noself | closed_interval | no_intersect | endpoints_only | no_interior")
    ok = True
    for i, (lbl, A, B, exp) in enumerate(ctr):
        vs = [results[p][i] for p in PL]
        print(f"  {lbl} | {exp} | " + " | ".join(vs))
        ok &= vs[0] == exp
    # the plants' predicted flips (registered here before the first run; see the record)
    pred = {"noself": {2}, "closed_interval": {0, 4}, "no_intersect": {5}, "endpoints_only": {6, 7}, "no_interior": {7}}
    for plant, flips in pred.items():
        got = {i for i in range(len(ctr)) if results[plant][i] != results[None][i]}
        print(f"  plant {plant}: flips {sorted(got)}, predicted {sorted(flips)} -- {'as predicted' if got == flips else 'NOT AS PREDICTED'}")
        ok &= got == flips
    # point routine
    z = P(0, 0)
    lt, gt, eq, ins = X.point_tile(z, rect(Fr(1, 2), 0, 1, Fr(1, 2), "far-rect"))
    assert lt and gt and ins < 0
    z2 = (T3(Fr(1, 2)), T3(Fr(1, 3)))
    assert X.inside(z2, reu) == 1 and X.inside((T3(Fr(1, 2)), T3(-Fr(1, 10))), reu) == 1 and X.inside((T3(Fr(1, 2)), T3(-Fr(2, 10))), reu) == -1
    print("point routine: straddle and the ray-cast inside test on the Reuleaux triangle (a point in the lens below the chord is inside) -- exact")
    print(f"SELF-TEST {'PASSED' if ok else 'FAILED'}")
    return ok


# =================================================================================== calibration
def strip_key(a, b):
    """orbit key of a pair of strip tiles under the colour period 3/2 (index shift 3)."""
    def parse(t):
        return t.name[0], int(t.name[1:])
    (x, i), (y, j) = parse(a), parse(b)
    forms = []
    for base in (i, j):
        s = 3 * (base // 3)
        forms.append(tuple(sorted([(x, i - s), (y, j - s)])))
    return min(forms)


def strip_run(capped=False, plant=None, show=False, label=None):
    S = O.Strip(capped=capped, plant=plant)
    window = S.tiles(-9, 11)
    base = [t for t in window if int(t.name[1:]) in (0, 1, 2)]
    lab = label or ("capped strip" if capped else "strip")
    return S, window, base, check_periodic(base, window, lab + (f" [plant {plant}]" if plant else ""), key=strip_key, show=show)


def calib():
    print("== the brick (row 33): cell (0,0) against every same-colour cell with |i|, |j| <= 5")
    br = O.brick()
    base = [t for t in br if t.name == "b0,0"]
    check_periodic(base, br, "brick")
    br2 = O.brick(w=Fr(1, 2))
    check_periodic([t for t in br2 if t.name == "b0,0"], br2, "brick plant (mine): cells 1/2 wide, the cosets (-3,1), (3,-1) at distance 0.6")
    print("== the hexagonal seven-colouring, side 1/2: hexagon (0,0) against every same-colour hexagon of the window")
    hx = O.hex7()
    check_periodic([t for t in hx if t.name == "h0,0"], hx, "hex7")
    hx2 = O.hex7(side=Fr(11, 20))
    check_periodic([t for t in hx2 if t.name == "h0,0"], hx2, "hex7 plant: side 11/20 (diameter 11/10)")
    print("== the strip (rebuilt by rule)")
    S, window, base, _ = strip_run()
    bad, unm = X.consistency(base + [t for t in window if int(t.name[1:]) in (-1, 3)],
                             open_ok=lambda pc: True)
    inner = [t for t in window if int(t.name[1:]) in (0, 1, 2)]
    print(f"   map consistency on the base period (pieces of the base tiles matched in the window): "
          f"{sum(1 for t in inner for pc in t.pieces if any(X._same_piece_rev(pc, q) for u in window for q in u.pieces if u is not t))} of "
          f"{sum(len(t.pieces) for t in inner)} base pieces shared with a window tile in the opposite direction; the rest lie on y = +-Y")
    area = sum(t.area_float() for t in inner)
    print(f"   float guard: the 12 base tiles' areas sum to {area:.9f}; period x height = {1.5 * 2 * float(S.Y):.9f}")
    strip_run(plant="swap_U0_U1", label="strip")
    print("== the disk (rebuilt by rule, Y2's labels)")
    Dk = O.Disk()
    ids = O.disk_identities(Dk)
    print(f"   identities: {sum(ok for _, ok in ids)} of {len(ids)} exact" + ("" if all(ok for _, ok in ids) else " -- FAILED: " + str([l for l, ok in ids if not ok])))
    tiles = Dk.tiles()
    bad, unm = X.consistency(tiles, open_ok=lambda pc: pc.kind == "A" and pc.C[0].is0() and pc.C[1].is0())
    print(f"   map consistency: {len(bad)} pieces unmatched off the rim; {unm} rim pieces; pieces {sum(len(t.pieces) for t in tiles)}")
    import math
    area = sum(t.area_float() for t in tiles)
    print(f"   float guard: 26 tile areas sum to {area:.9f}; pi r^2 = {math.pi * float(Dk.r) ** 2:.9f}")
    check_finite(tiles, "disk")
    check_finite(Dk.tiles(), "disk under the checker plant closed_interval (tight contacts shown as REJECT)", plant="closed_interval")
    for pl in ("swap", "chords"):
        check_finite(O.Disk(plant=pl).tiles(), f"disk plant {pl}")
    print("== FS112-BOWTIE (FS112-YB3's builder, converted exactly)")
    bt = O.bowtie_held()
    check_finite(bt, "BOWTIE")
    check_finite(bt, "BOWTIE under closed_interval", plant="closed_interval")
    check_finite(O.bowtie_held(plant="h_is_g"), "BOWTIE plant h_is_g (H given G's colour 1)")


if __name__ == "__main__":
    what = sys.argv[1] if len(sys.argv) > 1 else "selftest"
    if what == "selftest":
        sys.exit(0 if selftest() else 1)
    elif what == "calib":
        calib()
    else:
        import fs114_yb_run2 as R2   # noqa: E402  (the instance's objects; written after calibration)
        R2.main(what)

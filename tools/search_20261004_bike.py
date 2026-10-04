#!/usr/bin/env python3
"""SEARCH-2026-10-04, queue row 6 (C-T-BIKE): the bicycle's arc ansatz.

The bicycle: u = (0, 0), v = (d, 0), 1 < d < 2, and the two unit circles T1(u), T1(v); edges join points of one circle 60 degrees apart and
cross pairs x in T1(u), y in T1(v) with |x - y| = 1.  Angles: theta on T1(u) about u, eta on T1(v) about v, degrees, from the +x axis.

T1(u) is coloured 1, 2 on the alternating half-open arcs [phi + 60k, phi + 60(k+1)), colour 1 at even k.

  TS1     (FS106-TS's reduction, C-T-BIKE (iii)): T1(v) free in three colours.  Each y in T1(v) gets a list from its partners' colours:
          no partner -> {1,2,3} (type N); partners of different colours -> {3} (type F); both 1 -> {2,3} (type P1); both 2 -> {1,3} (type P2).
          T1(v)'s 60-degree edges split it into hexagons {t + 60k}; T1(v) is colourable iff every hexagon is list-colourable (table below,
          by brute force over 3^6 colourings).  Generic answer: every open cell of the folded breakpoint partition passes.
  FS107-2 (FS-107's two-offset ansatz, the queue row as worded): T1(v) alternating {1, 3} with offset psi, colour 1 at even arcs.  Proper iff
          the colour-1 arcs of T1(v) miss S = {eta : some partner has colour 1} = cells of type F or P1.

Breakpoints of the list function on T1(v), closed form: the two points where T1(v) meets the unit circle about each arc boundary
x_k = (cos(phi + 60k), sin(phi + 60k)) of T1(u), and the two points of T1(v) at distance exactly 2 from u (where partners appear).

Usage:
  search_20261004_bike.py controls                      # C1 (FS-107's hand numbers), C2 (symmetries), C3 (hexagon table vs hand rule)
  search_20261004_bike.py plant <name>                  # run controls with a planted fault; must FAIL
  search_20261004_bike.py scan OUTDIR D0 D1 ND NPHI W [PHI0 PHI1]   # d in [D0, D1] (ND values) x phi in [PHI0, PHI1) (default [0, 120)), W workers;
                                                      # resumable: rerun the same command, finished d files are skipped
  search_20261004_bike.py summary OUTDIR
Floats (double precision) throughout: a scan is a search, and its nulls are stated with their resolution and margins.
"""
import json
import math
import multiprocessing
import os
import sys
import time

N_T, F_T, P1_T, P2_T = 0, 1, 2, 3
LISTS = {N_T: (1, 2, 3), F_T: (3,), P1_T: (2, 3), P2_T: (1, 3)}
PLANT = os.environ.get("BIKE_PLANT", "")

# ---------------------------------------------------------------- the hexagon table (brute force; never by hand)

def build_hex_table():
    import itertools
    table = {}
    for types in itertools.product(range(4), repeat=6):
        ok = False
        for col in itertools.product(*(LISTS[t] for t in types)):
            if all(col[i] != col[(i + 1) % 6] for i in range(6)):
                ok = True
                break
        table[types] = ok
    if PLANT == "hextable":   # planted: an antipodal F pair flanked by two P1 marked colourable
        table[(F_T, P1_T, P1_T, F_T, N_T, N_T)] = True
    return table


HEX = build_hex_table()


def hand_rule(types):
    """The rule derived by hand (record § 1.5, C3): F independent at 60 degrees, and an antipodal pair of F flanked on one side by two P1 or two P2
    fails; every other pattern passes."""
    for i in range(6):
        if types[i] == F_T and types[(i + 1) % 6] == F_T:
            return False
    for i in range(6):
        if types[i] == F_T and types[(i + 3) % 6] == F_T:
            for a, b in (((i + 1) % 6, (i + 2) % 6), ((i + 4) % 6, (i + 5) % 6)):
                if types[a] == types[b] and types[a] in (P1_T, P2_T):
                    return False
    return True

# ---------------------------------------------------------------- geometry

def u_colour(theta, phi):
    k = math.floor(((theta - phi) % 360.0) / 60.0)
    return 1 if k % 2 == 0 else 2


def y_type(d, eta, phi):
    e = math.radians(eta)
    yx, yy = d + math.cos(e), math.sin(e)
    r = math.hypot(yx, yy)
    if r > 2.0:
        return N_T
    tc = math.degrees(math.atan2(yy, yx))
    b = math.degrees(math.acos(min(1.0, r / 2.0)))
    if PLANT == "partner":   # planted: partners computed at the wrong half-angle (a 1% error is invisible: cells are classified at midpoints)
        b *= 1.2
    c1, c2 = u_colour(tc + b, phi), u_colour(tc - b, phi)
    if c1 != c2:
        return F_T
    return P1_T if c1 == 1 else P2_T


def breakpoints(d, phi):
    """Angles eta in [0, 360) where the list function on T1(v) can change."""
    out = []
    vx, vy = d, 0.0
    for k in range(6):
        a = math.radians(phi + 60.0 * k)
        xx, xy = math.cos(a), math.sin(a)
        dx, dy = xx - vx, xy - vy
        D = math.hypot(dx, dy)
        if D <= 2.0:
            mx, my = (xx + vx) / 2.0, (xy + vy) / 2.0
            h = math.sqrt(max(0.0, 1.0 - D * D / 4.0))
            px, py = -dy / D, dx / D
            for s in (1.0, -1.0):
                yx, yy = mx + s * h * px, my + s * h * py
                out.append(math.degrees(math.atan2(yy - vy, yx - vx)) % 360.0)
                if PLANT == "breakpoint":   # planted: one family of breakpoints displaced by 0.3 degrees
                    out[-1] = (out[-1] + 0.3) % 360.0
    c = (3.0 - d * d) / (2.0 * d)
    if -1.0 <= c <= 1.0:
        t = math.degrees(math.acos(c))
        out += [t % 360.0, (-t) % 360.0]
    return sorted(out)


def cells(points, period):
    """Open cells (lo, hi) of [0, period) cut at the given points (cyclic)."""
    pts = sorted(set(p % period for p in points))
    if not pts:
        return [(0.0, period)]
    res = []
    for i in range(len(pts)):
        lo = pts[i]
        hi = pts[i + 1] if i + 1 < len(pts) else pts[0] + period
        res.append((lo, hi))
    return res

# ---------------------------------------------------------------- TS1

DEGEN = 1e-9


def ts1(d, phi):
    """Return (failing measure of t in [0, 60), number of failing cells, number of degenerate cells skipped)."""
    bp = breakpoints(d, phi)
    fail, nfail, ndeg = 0.0, 0, 0
    for lo, hi in cells(bp, 60.0):
        if hi - lo < DEGEN:
            ndeg += 1
            continue
        t = (lo + hi) / 2.0
        types = tuple(y_type(d, t + 60.0 * k, phi) for k in range(6))
        if not HEX[types]:
            fail += hi - lo
            nfail += 1
    return fail, nfail, ndeg

# ---------------------------------------------------------------- FS107-2

def s_intervals(d, phi):
    """S = {eta : some partner has colour 1}, as open intervals (lo, hi) with 0 <= lo < 360, hi > lo (may exceed 360)."""
    bp = breakpoints(d, phi)
    raw = []
    for lo, hi in cells(bp, 360.0):
        if hi - lo < DEGEN:
            continue
        if y_type(d, (lo + hi) / 2.0, phi) in (F_T, P1_T):
            raw.append([lo, hi])
    # merge cyclically adjacent cells
    merged = []
    for iv in raw:
        if merged and abs(merged[-1][1] - iv[0]) < DEGEN:
            merged[-1][1] = iv[1]
        else:
            merged.append(iv)
    if len(merged) > 1 and abs(merged[-1][1] - 360.0 - merged[0][0]) < DEGEN:
        merged[0][0] = merged[-1][0] - 360.0
        merged.pop()
    return [(a, b) for a, b in merged]


def largest_gap(blocked, period):
    """blocked: list of open intervals (a, b) on a circle of the given period (b - a may be >= period). Largest uncovered gap length."""
    segs = []
    for a, b in blocked:
        L = b - a
        if L >= period:
            return 0.0
        a %= period
        b = a + L
        if b <= period:
            segs.append((a, b))
        else:
            segs.append((a, period))
            segs.append((0.0, b - period))
    if not segs:
        return period
    segs.sort()
    gaps = []
    cur_end = segs[0][1]
    first_start = segs[0][0]
    for a, b in segs[1:]:
        if a > cur_end:
            gaps.append(a - cur_end)
        cur_end = max(cur_end, b)
    gaps.append(first_start + period - cur_end)   # wrap-around gap
    return max(0.0, max(gaps))


def fs107_margin(d, phi, S=None):
    """Signed margin in degrees: > 0 is the clearance of the best psi (half the admissible psi-window); < 0 is minus the least uniform
    penetration delta of colour-1 arcs into S that some psi achieves."""
    if S is None:
        S = s_intervals(d, phi)
    blocked0 = [(a - 60.0, b) for a, b in S]
    g = largest_gap(blocked0, 120.0)
    if g > 0.0:
        return g / 2.0
    lo, hi = 0.0, 60.0
    for _ in range(40):
        mid = (lo + hi) / 2.0
        bl = [(a + mid - 60.0, b - mid) for a, b in S if b - mid > a + mid]
        if largest_gap(bl, 120.0) > 0.0:
            hi = mid
        else:
            lo = mid
    return -hi


def best_psi(d, phi):
    """If FS107-2 is feasible at (d, phi): the centre of the largest admissible psi window."""
    S = s_intervals(d, phi)
    segs = []
    for a, b in S:
        a2, b2 = (a - 60.0) % 120.0, None
        b2 = a2 + (b - a + 60.0)
        segs.append((a2, b2))
    # sample-free: find the gap explicitly
    flat = []
    for a, b in segs:
        if b <= 120.0:
            flat.append((a, b))
        else:
            flat.append((a, 120.0))
            flat.append((0.0, b - 120.0))
    flat.sort()
    best = (0.0, None)
    cur_end = flat[0][1]
    for a, b in flat[1:]:
        if a > cur_end and a - cur_end > best[0]:
            best = (a - cur_end, (a + cur_end) / 2.0)
        cur_end = max(cur_end, b)
    wrap = flat[0][0] + 120.0 - cur_end
    if wrap > best[0]:
        best = (wrap, ((cur_end + flat[0][0] + 120.0) / 2.0) % 120.0)
    return best

# ---------------------------------------------------------------- controls

def branch_gap(d, lo, hi, n=20001):
    """FS-107's quantity: min over theta in [lo, hi] of (alpha + beta) minus max of (alpha - beta), where alpha = arg(x - v), beta = arccos(|x - v|/2)."""
    plus, minus = [], []
    for i in range(n):
        th = math.radians(lo + (hi - lo) * i / (n - 1))
        xx, xy = math.cos(th) - d, math.sin(th)
        r = math.hypot(xx, xy)
        a = math.degrees(math.atan2(xy, xx)) % 360.0
        b = math.degrees(math.acos(min(1.0, r / 2.0)))
        plus.append(a + b)
        minus.append(a - b)
    return min(plus) - max(minus)


def controls():
    ok = True
    # C3: the hexagon table against the hand rule, on all 4096 patterns
    bad = [t for t, v in HEX.items() if v != hand_rule(t)]
    print(f"C3 hexagon table vs hand rule: {len(bad)} disagreements of 4096; colourable patterns {sum(HEX.values())}")
    if bad:
        ok = False
        print("   first:", bad[:3])
    # C1: FS-107's hand numbers at d = 1.9
    g0 = branch_gap(1.9, -30.0, 30.0)
    gp, gm = branch_gap(1.9, -21.0, 39.0), branch_gap(1.9, -39.0, 21.0)
    print(f"C1 branch gap at d=1.9, arc [-30,30): {g0:.2f} (FS-107: 58.4); shifted +9: {gp:.2f}, -9: {gm:.2f} (FS-107: 59.3)")
    # FS-107's 58.4 is hand arithmetic; my own hand value (record § 1.4's working) was 58.3, so the first is held to 0.15 and the second to 0.05
    if not (abs(g0 - 58.4) < 0.15 and abs(max(gp, gm) - 59.3) < 0.05):
        ok = False
        print("   C1 FAIL")
    # the tool's own margin at those offsets: the colour-1 arc [-30, 30) is phi = -30 (mod 120) = 90
    for phi, g in ((90.0, g0), (99.0, gp), (81.0, gm)):
        m = fs107_margin(1.9, phi)
        print(f"   FS107-2 margin at d=1.9, phi={phi}: {m:+.3f}  (if the branch gap binds: {-(60.0 - g) / 2.0:+.3f})")
        if not (m < 0.0 and abs(m + (60.0 - g) / 2.0) < 0.05):
            ok = False
            print("   C1 margin FAIL")
    # C2: symmetries, at 200 pseudo-random (d, phi)
    import random
    rng = random.Random(20261004)
    worst_r, worst_s, worst_t = 0.0, 0.0, 0.0
    for _ in range(200):
        d = 1.0 + rng.random()
        phi = 120.0 * rng.random()
        # reflection in the line uv maps the colour-1 arc [phi, phi + 60) to (-phi - 60, -phi]: offset -phi - 60 (mod 120)
        m1, m2 = fs107_margin(d, phi), fs107_margin(d, (-phi - 60.0) % 120.0)
        worst_r = max(worst_r, abs(m1 - m2))
        f1, f2, f3 = ts1(d, phi)[0], ts1(d, (-phi - 60.0) % 120.0)[0], ts1(d, (phi + 60.0) % 120.0)[0]
        worst_s = max(worst_s, abs(f1 - f2))
        worst_t = max(worst_t, abs(f1 - f3))
    print(f"C2 reflection phi<->-phi-60: FS107-2 margin max diff {worst_r:.2e}; TS1 failing measure max diff {worst_s:.2e}; "
          f"colour swap phi<->phi+60 (TS1): {worst_t:.2e}")
    if max(worst_r, worst_s, worst_t) > 1e-6:
        ok = False
        print("   C2 FAIL")
    # C4: y_type against an independent partner finder (sign changes of |x(theta) - y| - 1 on a 0.01-degree grid of theta), 400 random points
    mism = 0
    for _ in range(400):
        d = 1.0 + rng.random()
        phi = 120.0 * rng.random()
        eta = 360.0 * rng.random()
        yx, yy = d + math.cos(math.radians(eta)), math.sin(math.radians(eta))
        roots = []
        prev = None
        for i in range(36001):
            th = i / 100.0
            g = math.hypot(math.cos(math.radians(th)) - yx, math.sin(math.radians(th)) - yy) - 1.0
            if prev is not None and (prev < 0.0) != (g < 0.0):
                roots.append(th - 0.005)
            prev = g
        cols = {u_colour(r, phi) for r in roots}
        indep = N_T if not roots else (F_T if len(cols) > 1 else (P1_T if cols == {1} else P2_T))
        if indep != y_type(d, eta, phi):
            mism += 1
    print(f"C4 y_type vs independent root-bracketing partner finder: {mism} mismatches of 400 (a few near arc boundaries are possible)")
    if mism > 4:
        ok = False
        print("   C4 FAIL")
    print("CONTROLS", "PASS" if ok else "FAIL")
    return ok

# ---------------------------------------------------------------- the scan

def scan_one(args):
    import numpy as np
    outdir, i, d, nphi, phi0, phi1 = args
    path = os.path.join(outdir, "raw", f"d{i:05d}.npy")
    if os.path.exists(path):
        return path, True
    arr = np.zeros((nphi, 4), dtype=np.float64)   # columns: TS1 failing measure, TS1 failing cells, degenerate cells, FS107-2 margin
    for j in range(nphi):
        phi = phi0 + (phi1 - phi0) * j / nphi
        fail, nfail, ndeg = ts1(d, phi)
        arr[j] = (fail, nfail, ndeg, fs107_margin(d, phi))
    tmp = path + ".tmp.npy"
    np.save(tmp, arr)
    os.replace(tmp, path)
    return path, False


def grid(meta):
    d0, d1, nd, nphi, phi0, phi1 = meta["d0"], meta["d1"], meta["nd"], meta["nphi"], meta["phi0"], meta["phi1"]
    ds = [d0 + (d1 - d0) * i / (nd - 1) for i in range(nd)]
    phis = [phi0 + (phi1 - phi0) * j / nphi for j in range(nphi)]
    return ds, phis


def scan(outdir, d0, d1, nd, nphi, workers, phi0=0.0, phi1=120.0):
    os.makedirs(os.path.join(outdir, "raw"), exist_ok=True)
    meta = {"d0": d0, "d1": d1, "nd": nd, "nphi": nphi, "phi0": phi0, "phi1": phi1}
    mpath = os.path.join(outdir, "meta.json")
    if os.path.exists(mpath):
        old = json.load(open(mpath))
        if old != meta:
            sys.exit(f"REFUSED: {mpath} holds a different grid {old}; resume needs the same command")
    else:
        json.dump(meta, open(mpath, "w"))
    ds, _ = grid(meta)
    jobs = [(outdir, i, ds[i], nphi, phi0, phi1) for i in range(nd)]
    t0 = time.time()
    ctx = multiprocessing.get_context("fork")
    done = skipped = 0
    with ctx.Pool(workers) as pool:
        for path, sk in pool.imap_unordered(scan_one, jobs):
            done += 1
            skipped += sk
            if done % 200 == 0 or done == nd:
                print(f"{done}/{nd} d-values ({skipped} resumed) {time.time() - t0:.0f}s", flush=True)
    with open(os.path.join(outdir, "DONE"), "w") as fh:
        fh.write(f"{nd} d-values x {nphi} phi; d in [{d0}, {d1}], phi in [{phi0}, {phi1}); {time.time() - t0:.0f}s wall\n")
    print("SCAN COMPLETE", outdir)


def summary(outdir):
    import numpy as np
    meta = json.load(open(os.path.join(outdir, "meta.json")))
    ds, phis = grid(meta)
    best_m, best_f = (-1e9, None, None), (1e9, None, None)
    n_fs = n_ts = degen_total = 0
    per_d = []
    for i, d in enumerate(ds):
        path = os.path.join(outdir, "raw", f"d{i:05d}.npy")
        if not os.path.exists(path):
            sys.exit(f"MISSING {path}: the scan is incomplete")
        arr = np.load(path)
        jm, jf = int(np.argmax(arr[:, 3])), int(np.argmin(arr[:, 0]))
        degen_total += int(arr[:, 2].sum())
        nts_d = int((arr[:, 0] == 0.0).sum())
        nfs_d = int((arr[:, 3] > 0.0).sum())
        n_ts += nts_d
        n_fs += nfs_d
        per_d.append((d, arr[jm, 3], phis[jm], nfs_d, arr[jf, 0], phis[jf], nts_d))
        if arr[jm, 3] > best_m[0]:
            best_m = (arr[jm, 3], d, phis[jm])
        if arr[jf, 0] < best_f[0]:
            best_f = (arr[jf, 0], d, phis[jf])
    lines = [f"grid {meta}; degenerate cells skipped (all) {degen_total}",
             f"FS107-2: best signed margin {best_m[0]:+.5f} deg at d={best_m[1]:.5f}, phi={best_m[2]:.4f}; feasible grid points {n_fs} of {len(ds) * len(phis)}",
             f"TS1: least failing measure {best_f[0]:.5f} deg at d={best_f[1]:.5f}, phi={best_f[2]:.4f}; generically feasible grid points {n_ts} of {len(ds) * len(phis)}"]
    ts_d = [r[0] for r in per_d if r[6] > 0]
    fs_d = [r[0] for r in per_d if r[3] > 0]
    lines.append(f"TS1 feasible d-range on the grid: {(min(ts_d), max(ts_d)) if ts_d else None}, {len(ts_d)} of {len(ds)} d-values")
    lines.append(f"FS107-2 feasible d-range on the grid: {(min(fs_d), max(fs_d)) if fs_d else None}, {len(fs_d)} of {len(ds)} d-values")
    print("\n".join(lines))
    with open(os.path.join(outdir, "summary.txt"), "w") as fh:
        fh.write("\n".join(lines) + "\n")
    with open(os.path.join(outdir, "per_d.tsv"), "w") as fh:
        fh.write("d\tfs107_best_margin\tat_phi\tfs107_feasible_phis\tts1_least_fail\tat_phi\tts1_feasible_phis\n")
        for r in per_d:
            fh.write(f"{r[0]:.6f}\t{r[1]:+.6f}\t{r[2]:.4f}\t{r[3]}\t{r[4]:.6f}\t{r[5]:.4f}\t{r[6]}\n")
    return per_d


# ---------------------------------------------------------------- TS1-E: T1(u) any finite-arc proper two-colouring (a stage-4 extension)
#
# A proper two-colouring of T1(u) at 60 degrees satisfies c(theta + 60) = 3 - c(theta), so it is fixed by E = {t in [0, 60) : c(t) = 1}.
# E is given as a sorted list of boundary points in (0, 60), colour 1 on alternate pieces starting with colour `first` on [0, e1).
# The uniform alternating pattern with offset phi is E = [phi, 60): boundaries [phi], first = 2.

def u_colour_E(theta, bnds, first):
    t = theta % 360.0
    k = int(t // 60.0) % 6
    r = t - 60.0 * int(t // 60.0)
    j = sum(1 for e in bnds if e <= r)
    base = first if j % 2 == 0 else 3 - first
    return base if k % 2 == 0 else 3 - base


def y_type_E(d, eta, bnds, first):
    e = math.radians(eta)
    yx, yy = d + math.cos(e), math.sin(e)
    r = math.hypot(yx, yy)
    if r > 2.0:
        return N_T
    tc = math.degrees(math.atan2(yy, yx))
    b = math.degrees(math.acos(min(1.0, r / 2.0)))
    c1, c2 = u_colour_E(tc + b, bnds, first), u_colour_E(tc - b, bnds, first)
    if c1 != c2:
        return F_T
    return P1_T if c1 == 1 else P2_T


def breakpoints_E(d, bnds):
    out = []
    for e0 in [0.0] + list(bnds):
        for k in range(6):
            a = math.radians(e0 + 60.0 * k)
            xx, xy = math.cos(a), math.sin(a)
            dx, dy = xx - d, xy
            D = math.hypot(dx, dy)
            if D <= 2.0:
                mx, my = (xx + d) / 2.0, xy / 2.0
                h = math.sqrt(max(0.0, 1.0 - D * D / 4.0))
                px, py = -dy / D, dx / D
                for s_ in (1.0, -1.0):
                    out.append(math.degrees(math.atan2(my + s_ * h * py, mx + s_ * h * px - d)) % 360.0)
    c = (3.0 - d * d) / (2.0 * d)
    if -1.0 <= c <= 1.0:
        t = math.degrees(math.acos(c))
        out += [t % 360.0, (-t) % 360.0]
    return sorted(out)


def ts1_E(d, bnds, first):
    fail = 0.0
    for lo, hi in cells(breakpoints_E(d, bnds), 60.0):
        if hi - lo < DEGEN:
            continue
        t = (lo + hi) / 2.0
        if not HEX[tuple(y_type_E(d, t + 60.0 * k, bnds, first) for k in range(6))]:
            fail += hi - lo
    return fail


def scanE_one(args):
    d, k, step = args
    import itertools
    pts = [step * i for i in range(1, int(round(60.0 / step)))]
    best = (1e9, None)
    nfeas = 0
    feas = []
    for nb in range(1, 2 * k + 1):
        for bnds in itertools.combinations(pts, nb):
            for first in (1, 2):
                f = ts1_E(d, bnds, first)
                if f < best[0]:
                    best = (f, (bnds, first))
                if f == 0.0:
                    nfeas += 1
                    if len(feas) < 20:
                        feas.append((bnds, first))
    return d, best, nfeas, feas


def scanE(out, ds, k, step, workers):
    ctx = multiprocessing.get_context("fork")
    res = []
    t0 = time.time()
    with ctx.Pool(workers) as pool:
        for d, best, nfeas, feas in pool.imap(scanE_one, [(d, k, step) for d in ds]):
            line = f"d={d:.4f}: least failing measure {best[0]:.4f} at boundaries {best[1]}; feasible patterns {nfeas}; first {feas[:3]}"
            print(line, f"[{time.time() - t0:.0f}s]", flush=True)
            res.append({"d": d, "best": best[0], "at": best[1], "nfeas": nfeas, "feas": feas})
            json.dump({"k": k, "step": step, "rows": res}, open(out, "w"))
    print("SCAN-E COMPLETE", out)


if __name__ == "__main__":
    cmd = sys.argv[1]
    if cmd == "controls":
        sys.exit(0 if controls() else 1)
    elif cmd == "plant":
        # the plant is read from BIKE_PLANT at import; re-exec with it set
        name = sys.argv[2]
        if PLANT != name:
            os.execvpe(sys.executable, [sys.executable, __file__, "plant", name], dict(os.environ, BIKE_PLANT=name))
        ok = controls()
        print(f"PLANT {name}: controls {'PASSED — the plant did NOT fire' if ok else 'FAILED — the plant fired'}")
        sys.exit(1 if ok else 0)
    elif cmd == "scan":
        extra = [float(x) for x in sys.argv[8:10]]
        scan(sys.argv[2], float(sys.argv[3]), float(sys.argv[4]), int(sys.argv[5]), int(sys.argv[6]), int(sys.argv[7]), *extra)
    elif cmd == "scan-e":   # scan-e OUT.json K STEP W d1 d2 ...  (patterns with up to 2K boundary points in (0, 60) on a STEP-degree grid)
        scanE(sys.argv[2], [float(x) for x in sys.argv[6:]], int(sys.argv[3]), float(sys.argv[4]), int(sys.argv[5]))
    elif cmd == "check-e":  # control: TS1-E with E = [phi, 60) reproduces TS1 at offset phi
        import random
        rng = random.Random(5)
        worst = 0.0
        for _ in range(300):
            d, phi = 1.0 + rng.random(), 0.5 + 59.0 * rng.random()
            worst = max(worst, abs(ts1(d, phi)[0] - ts1_E(d, [phi], 2)))
        print(f"TS1-E vs TS1 on 300 random (d, phi): max difference {worst:.2e}")
        sys.exit(0 if worst < 1e-9 else 1)
    elif cmd == "summary":
        summary(sys.argv[2])
    else:
        sys.exit(f"unknown command {cmd}")

#!/usr/bin/env python3
"""FS116-V2 — RING-GERM (data/fs116/claims.md § 10) read on the uncapped strip, a held non-Siamese valid fragment.

The strip is `[AxenovichEtAl2014]` Thm 4.2's, as FS-112 rebuilt it (LEDGER.md row 136; the listing
data/fs112/fs112-yb/strip-objects.txt, from tools/fs112_yb_strip.py's exact check). It is rebuilt here BY FORMULA, from the
listing's description only:
  midline vertices P_j = (j/2, 0); above the midline the tile U_j is the column j/2 < x < j/2 + 1/2 cut by the two unit discs
  about P_j and P_{j+1} (a rectangle of height sqrt3/2 with a pointed cap, apex (j/2 + 1/4, sqrt15/4)); above the caps the top
  tile T_k is the band k/2 - 1/4 < x < k/2 + 1/4 (its bottom the valley at (k/2, sqrt3/2)); below the midline the mirror images
  D_j, B_k. Colours: U_j = (P,G,B)[j mod 3], D_j = (M,R,O), T_k = (R,O,M), B_k = (G,B,P).
Only the disc of radius 3/2 about P_0 is read (the strip's half-height is sqrt15/4 + sqrt3/2 ~ 1.834).

The colour oracle is exact: sample points are rationals, and every comparison is of rationals (|z - P_j|^2 against 1, y^2
against 3/4). A sample point on a boundary raises OnGamma — never a silent colour. Positions on the ring (which germ, which
direction at a vertex) are chosen in floating point with margins of at least 0.1 degree against every feature of the strip.

Modes:
  --listing        compare the rebuild with every non-edge vertex sector of the FS-112 listing (the rebuild's own control)
  --summary        RING-GERM at every change point of the ring of P_0, under reading L (the author's) and reading G
  --cw             FAULT: read "y + 60 deg" clockwise (the orientation the author ruled out)
  --plant          FAULT for --listing: recolour U_1 from G to P
Exit 0 on a completed run whatever it finds; exit 2 when the run could not complete (a sample on a boundary, an unstable germ).
"""
import math
import re
import sys
from fractions import Fraction as Fr

COL_U, COL_D, COL_T, COL_B = "PGB", "MRO", "ROM", "GBP"
PLANT = "--plant" in sys.argv
CW = "--cw" in sys.argv
ETA = 1e-12          # radial offset of a germ's side samples from the ring (a tangent edge at P_{+-2} needs sqrt(2 ETA) << 0.1 deg)
RAD = 1e-4           # radius of the direction samples about a vertex


class OnGamma(Exception):
    pass


def rat(v):
    return Fr(round(v * 10**14), 10**14)


def colour(x, y):
    """(label, colour) of the tile holding the rational point (x, y); OnGamma if (x, y) lies on the boundary set."""
    if y == 0:
        raise OnGamma("midline")
    if abs(y) >= Fr(3, 2):
        raise ValueError("outside the disc read")
    up = y > 0
    ay2 = y * y
    j = math.floor(2 * x)
    if 2 * x == j and ay2 <= Fr(3, 4):
        raise OnGamma("vertical edge between columns")
    d1 = (x - Fr(j, 2)) ** 2 + ay2
    d2 = (x - Fr(j + 1, 2)) ** 2 + ay2
    if (d1 == 1 and d2 <= 1) or (d2 == 1 and d1 <= 1):
        raise OnGamma("cap arc")
    if d1 < 1 and d2 < 1:
        c = (COL_U if up else COL_D)[j % 3]
        if PLANT and up and j == 1:
            c = "P"
        return (("U" if up else "D") + str(j), c)
    k = math.floor(2 * x + Fr(1, 2))
    if 2 * x + Fr(1, 2) == k:
        raise OnGamma("vertical edge above an apex")
    return (("T" if up else "B") + str(k), (COL_T if up else COL_B)[k % 3])


def at(px, py, r, deg):
    a = math.radians(deg)
    return colour(rat(px + r * math.cos(a)), rat(py + r * math.sin(a)))


# ---------------------------------------------------------------- the rebuild against FS-112's listing
def listing():
    path = "data/fs112/fs112-yb/strip-objects.txt"
    import os
    here = os.path.dirname(os.path.abspath(__file__))
    txt = open(os.path.join(here, "..", path)).read()
    ys = {0.0: 0.0, 0.8660: math.sqrt(3) / 2, 0.9682: math.sqrt(15) / 4}
    nv = ns = bad = 0
    for line in txt.splitlines():
        m = re.match(r"\s+\(([-\d.]+), ([-+\d.]+)\)\s+(edge)?\s*P_cl=\{([A-Z,]+)\}.*?sectors (.*)$", line)
        if not m or m.group(3):
            continue
        x = round(float(m.group(1)) * 4) / 4
        yv = float(m.group(2))
        y = math.copysign(ys[round(abs(yv), 4)], yv)
        nv += 1
        for a, b, c in re.findall(r"\[([\d.]+),([\d.]+)\]:([A-Z-])", m.group(5)):
            a, b = float(a), float(b)
            if b <= a:
                b += 360
            ns += 1
            got = at(x, y, RAD, (a + b) / 2)[1]
            if got != c:
                bad += 1
                print(f"  disagree at ({x}, {y:.4f}) sector [{a},{b}]: listing {c}, rebuild {got}")
    print(f"listing: vertices compared {nv}, sectors compared {ns}, disagreements {bad}")


# ---------------------------------------------------------------- the ring of P_0
P0_TILES = set()
P0_COLS = set()


def p0_tiles():
    for d in (45, 135, 225, 315):
        lab, c = at(0, 0, RAD, d)
        P0_TILES.add(lab)
        P0_COLS.add(c)


def germ(theta, side):
    """The germ of the ring of P_0 just counter-clockwise (side +1) or clockwise (-1) of angle theta: (inner, outer)."""
    got = []
    for s in (0.1, 0.2):
        a = theta + side * s
        got.append((at(0, 0, 1 - ETA, a), at(0, 0, 1 + ETA, a)))
    if got[0] != got[1]:
        raise RuntimeError(f"unstable germ at {theta} side {side}: {got}")
    return got[0]


def on_gamma(g):
    return g[0][0] != g[1][0]


def is_q(g):
    return on_gamma(g) and g[0][1] in P0_COLS and g[1][1] in P0_COLS


def ring_segments():
    """Breakpoints of the ring's germ pattern, found by a 0.25-degree scan and bisection; each with the germs on its two sides."""
    def key(a):
        try:
            g = (at(0, 0, 1 - ETA, a), at(0, 0, 1 + ETA, a))
        except OnGamma:          # a sample landed on an edge the side samples cross near a breakpoint: count it as a change
            return None
        return (g[0][0], g[1][0])
    grid = [i * 0.25 + 0.125 for i in range(1440)]
    keys = [key(a) for a in grid]
    bps = []
    for i in range(1440):
        a, b = grid[i], grid[i] + 0.25
        ka, kb = keys[i], keys[(i + 1) % 1440]
        if ka == kb:
            continue
        lo, hi = a, b
        for _ in range(34):
            mid = (lo + hi) / 2
            if key(mid) == ka:
                lo = mid
            else:
                hi = mid
        bps.append(((lo + hi) / 2) % 360)
    # the inner and outer samples cross a feature at angles O(ETA) apart: merge breakpoints within 0.01 degree
    bps.sort()
    merged = []
    for b in bps:
        if merged and b - merged[-1][-1] < 0.01:
            merged[-1].append(b)
        else:
            merged.append([b])
    if len(merged) > 1 and (merged[0][0] + 360) - merged[-1][-1] < 0.01:
        merged[0] = [x - 360 for x in merged.pop()] + merged[0]
    return [(sum(m) / len(m)) % 360 for m in merged]


def cone_tiles(y, centre_deg):
    """Tiles at the ring point y in the open 60-degree cone about the direction centre_deg (every 0.5 degree, offset 0.25 from it)."""
    out = []
    for i in range(120):
        d = centre_deg - 29.75 + 0.5 * i
        out.append(at(y[0], y[1], RAD, d))
    return out


def ring_germ_at(theta, reading, bps_sorted):
    """RING-GERM's clauses at the ring point of angle theta; returns a dict, or None if theta is no change point in this reading."""
    ccw, cw = germ(theta, +1), germ(theta, -1)
    if reading == "L":
        if on_gamma(ccw) or on_gamma(cw) or ccw[0][1] == cw[0][1]:
            return None
        X, Xb = ccw[0][1], cw[0][1]
    else:  # G: nearest off-Gamma ring colour on each side
        def nearest(side):
            t = theta
            for _ in range(len(bps_sorted) + 2):
                g = germ(t, side)
                if not on_gamma(g):
                    return g[0][1]
                nxt = [b for b in bps_sorted if (side * (b - t)) % 360 > 1e-7]
                t = min(nxt, key=lambda b: (side * (b - t)) % 360)
            raise RuntimeError("ring entirely on Gamma")
        X, Xb = nearest(+1), nearest(-1)
        if X == Xb:
            return None
    s = -1 if CW else +1
    up, vp = theta + s * 60, theta - s * 60          # "y + 60" and "y - 60"
    u_m, u_p = germ(up, -1), germ(up, +1)
    v_m, v_p = germ(vp, -1), germ(vp, +1)
    y = (math.cos(math.radians(theta)), math.sin(math.radians(theta)))
    absent = set("PGBMRO") - P0_COLS
    r = {"theta": theta, "X": X, "Xb": Xb, "four": len(P0_COLS) == 4, "absent": {X, Xb} == absent}
    r["hyp_i"] = not is_q(v_m) and not is_q(u_p)
    r["hyp_ii"] = not is_q(u_m) and not is_q(v_p)
    r["hyp_iii"] = r["hyp_i"] and r["hyp_ii"]
    inward = cone_tiles(y, theta + 180)
    outward = cone_tiles(y, theta)
    r["concl_i"] = all(lab in P0_TILES for lab, _ in inward)
    r["concl_ii"] = all(c in P0_COLS and lab not in P0_TILES for lab, c in outward)
    around = {at(y[0], y[1], RAD, 0.5 * i + 0.25)[1] for i in range(720)}
    r["concl_iii"] = len(around) >= 4
    r["ncol_y"] = len(around)
    r["viol"] = [k for k in ("i", "ii", "iii") if r["hyp_" + k] and not r["concl_" + k]]
    return r


def summary(verbose):
    p0_tiles()
    bps = sorted(ring_segments())
    # candidate points: every breakpoint, and one interior point of every arc of Gamma on the ring (reading G reads those too)
    cands = list(bps)
    for i, b in enumerate(bps):
        nb = bps[(i + 1) % len(bps)]
        mid = (b + ((nb - b) % 360) / 2) % 360
        if on_gamma(germ(mid, +1)):
            cands.append(mid)
    out = []
    for reading in ("L", "G"):
        res = [r for r in (ring_germ_at(t, reading, bps) for t in sorted(cands)) if r]
        nviol = sum(len(r["viol"]) for r in res)
        where = sorted({round(r["theta"] % 360, 1) % 360 for r in res if r["viol"]})
        base = (f"{reading}: change points {len(res)}, (0a) {sum(r['four'] for r in res)}, (0b) {sum(r['absent'] for r in res)}, "
                f"hypotheses (i) {sum(r['hyp_i'] for r in res)} (ii) {sum(r['hyp_ii'] for r in res)} "
                f"(iii) {sum(r['hyp_iii'] for r in res)}, violations {nviol} at {where}, "
                f"(i) failing where its hypothesis fails {sum((not r['hyp_i']) and not r['concl_i'] for r in res)}")
        out.append(base)
        if verbose:
            for r in res:
                print(f"  [{reading}] theta={r['theta']:.4f} X={r['X']} Xb={r['Xb']} hyp(i,ii,iii)="
                      f"{int(r['hyp_i'])}{int(r['hyp_ii'])}{int(r['hyp_iii'])} concl(i,ii,iii)="
                      f"{int(r['concl_i'])}{int(r['concl_ii'])}{int(r['concl_iii'])} colours at y {r['ncol_y']} viol={r['viol']}")
    print(f"P_0: colours {''.join(sorted(P0_COLS))}, tiles {sorted(P0_TILES)}; ring breakpoints {len(bps)}")
    for line in out:
        print(line)


def main():
    try:
        if "--listing" in sys.argv:
            listing()
        elif "--summary" in sys.argv:
            summary(verbose="--verbose" in sys.argv)
        else:
            print(__doc__)
            return 2
    except (OnGamma, RuntimeError) as e:
        print(f"INCOMPLETE: {type(e).__name__}: {e}")
        return 2
    return 0


if __name__ == "__main__":
    sys.exit(main())

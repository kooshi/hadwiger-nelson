#!/usr/bin/env python3
"""FS136-P1 — two readings of the held objects at the common unit points of their covering pairs ([tools], floats, one
mind; a reading of objects by formula; nothing is searched; it proves nothing about a colouring not read).

  python3 data/fs136/p1/germs_read.py <object> ... [--fault]
  objects: strip disk bowtie sixfrag kept T2 r7      (loaders and the whole-tile table: data/fs136/e1/rings_read.py)

READING 1 — GERMS.  The deriver's table reads WHOLE tiles (a tile is inner / outer / crossing at w by its least and
greatest distance from w).  Here the same table is read from the GERM of each tile at its member z: the part of the
tile within rho of z, sampled on the circles of radius rho, rho/2, rho/4 about z (NA directions each).  A germ "has an
inside point" if a sample of the tile is more than TOL inside the unit circle about w, "an outside point" likewise.
For each common unit point w that the whole-tile table classes L0 or L1 with an empty cell (a stop), and each rho in
RHOS: is some cell still empty when only germs are kept?  And for each bar the empty cell uses, its depth at each rho
and the exponent  log(depth(rho_max)/depth(rho_min)) / log(rho_max/rho_min)  (1 = first order, 2 = second order).
What it cannot see: a germ's point between sampled directions (a horn narrower than 2 pi rho / NA at radius rho — the
flower's horn has width about rho^2 at radius rho and is seen at rho = 0.2, 0.05 with NA = 5760); exactness.

READING 2 — PAYMENTS.  At each common unit point w INSIDE the object (the whole-tile table has no empty cell), for each
of the four cells and each tile Q of the object met in that cell on the circle of radius rr about w, and each member z:
   free    the label of Q is not a label of any tile at z;
   same    Q itself is a tile at z (z and w, one unit apart, are both on the boundary of one tile: a unit diameter);
   facing  another tile at z has Q's label, and every tile at z with that label is inner at w;
   backing another tile at z has Q's label, and every tile at z with that label is outer at w;
   BAD     a tile at z with Q's label is crossing at w, or the side does not match the cell (a table violation).
And for each member z of each such w: how many of z's labels are barred (crossing) at w, and whether those are labels
absent at w.

--scan: the control of reading 1 (see scan): whole-tile class against germ class at directions that are not stops.
--fault: reading 1 keeps the whole tile in place of its germ (every stop must then stay a stop at every rho, with no
exponent defined); reading 2 swaps the two members' sides (BAD must appear).
"""
import sys, os, math, itertools
HERE = os.path.dirname(os.path.abspath(__file__))
FAULT = "--fault" in sys.argv
SCAN = "--scan" in sys.argv
ARGS = [a for a in sys.argv[1:] if not a.startswith("--")]
sys.argv = [sys.argv[0]]
sys.path.insert(0, os.path.join(HERE, "..", "e1"))
import rings_read as RR
TAU = 2 * math.pi
RHOS = (0.2, 0.05, 0.0125)
NA = 5760
TOL = 1e-10
dist = RR.dist


def germ_samples(tile, z, rho):
    out = []
    for s in (rho, rho / 2, rho / 4):
        for i in range(NA):
            a = TAU * (i + 0.5) / NA
            p = (z[0] + s * math.cos(a), z[1] + s * math.sin(a))
            out.append((p, tile(p)))
    return out


def scan(name, TF, tile, at, members):
    """CONTROL for reading 1 — can the germ reading differ from the whole-tile reading at all?  For every member z and
    every w = z + e(theta), theta = 0.5, 1.5, ..., 359.5 degrees (w is NOT a common unit point of anything): each tile at z
    classed by the whole tile and by its germ at rho = 0.0125 (720 directions on the circles of radius rho and rho/2)."""
    rho = RHOS[-1]; tally = {}
    for z in members:
        smp = []
        for sr in (rho, rho / 2):
            for i in range(720):
                a = TAU * (i + 0.5) / 720; p = (z[0] + sr * math.cos(a), z[1] + sr * math.sin(a)); smp.append((p, tile(p)))
        for k in range(360):
            th = TAU * (k + 0.5) / 360; w = (z[0] + math.cos(th), z[1] + math.sin(th))
            for nm in at[z]:
                whole = RR.side(TF, tile, nm, w)[0]
                din = max([1 - dist(p, w) for p, t in smp if t == nm] or [0.0]); dout = max([dist(p, w) - 1 for p, t in smp if t == nm] or [0.0])
                g = "crossing" if (din > TOL and dout > TOL) else ("inner" if din > TOL else ("outer" if dout > TOL else "none"))
                tally[(whole, g)] = tally.get((whole, g), 0) + 1
    print(f"== {name} SCAN (control): (whole tile, germ at rho={rho}) over {len(members)} members x 360 directions: " +
          " ".join(f"{a}/{b}:{n}" for (a, b), n in sorted(tally.items())))
    return 0


def read(name):
    TF = RR.load(name); col, tile, verts = RR.tiles_col(TF)
    palette = frozenset(c for c, ps in TF.values())
    V = {}
    for v in verts:
        A, B = RR.circle_labels(col, v, RR.R1), RR.circle_labels(col, v, RR.R2)
        V[v] = None if (A is None or B is None) else frozenset(A) | frozenset(B)
    at = {v: [nm for nm, (c, ps) in TF.items() if min(RR.piece_dist(pc, v) for pc in ps) < 1e-7] for v, labs in V.items() if labs is not None}
    members = sorted(v for v, labs in V.items() if labs is not None and len(labs) >= 3)
    cache = {}
    def germ(z, rho):
        if (z, rho) not in cache: cache[(z, rho)] = germ_samples(tile, z, rho)
        return cache[(z, rho)]
    def germ_side(z, nm, w, rho):
        if FAULT:
            sd, dp = RR.side(TF, tile, nm, w)
            return (1.0 if sd != "outer" else 0.0), (1.0 if sd != "inner" else 0.0)
        din = dout = 0.0
        for p, t in germ(z, rho):
            if t != nm: continue
            d = dist(p, w) - 1
            if -d > din: din = -d
            if d > dout: dout = d
        return din, dout
    stops = dict(n=0); germ_stop = {r: 0 for r in RHOS}; orders = []; stop_lines = []
    sing_hist = {}; tight = [0, 0]
    pay = {}; barred_hist = {}; barred_absent = [0, 0]; inside_n = 0; lab_hist = {}; pay_lines = []; sep_hist = {}
    for x, y in itertools.combinations(members, 2):
        d = dist(x, y)
        if not (1e-9 < d < 2 - 1e-9) or (V[x] | V[y]) != palette: continue
        mid = ((x[0] + y[0]) / 2, (x[1] + y[1]) / 2); h = math.sqrt(1 - d * d / 4); nrm = ((y[1] - x[1]) / d, -(y[0] - x[0]) / d)
        for sg in (1, -1):
            w = (mid[0] + sg * h * nrm[0], mid[1] + sg * h * nrm[1])
            A = RR.circle_labels(col, w, RR.R2); B = RR.circle_labels(col, w, RR.R1)
            inside = A is not None and B is not None
            st, cells, sep, empty, cls, eta = RR.table(TF, tile, x, y, w, palette, at)
            if empty and not inside:
                # ---------------- reading 1: the stop, from germs
                stops["n"] += 1
                line = f"   stop w=({w[0]:.5f},{w[1]:.5f}) x=({x[0]:.5f},{x[1]:.5f})[{len(V[x])}] y=({y[0]:.5f},{y[1]:.5f})[{len(V[y])}] whole-tile class={cls}"
                depth = {}
                for rho in RHOS:
                    gst = {}
                    for z in (x, y):
                        by = {}
                        for nm in at[z]:
                            din, dout = germ_side(z, nm, w, rho)
                            sd = "crossing" if (din > TOL and dout > TOL) else ("inner" if din > TOL else ("outer" if dout > TOL else "none"))
                            by.setdefault(TF[nm][0], []).append(sd); depth[(z, nm, rho)] = (din, dout)
                        gst[z] = {l: ("in" if all(s == "inner" for s in ss) else ("out" if all(s == "outer" for s in ss) else "bar")) for l, ss in by.items()}
                    gcells = {(sx, sy): {l for l in palette if gst[x].get(l, sx) == sx and gst[y].get(l, sy) == sy} for sx in ("in", "out") for sy in ("in", "out")}
                    gempty = [f"{a}/{b}" for (a, b), c in sorted(gcells.items()) if not c]
                    if gempty: germ_stop[rho] += 1
                    line += f" | rho={rho}: empty-by-germs={','.join(gempty) or 'NONE'}"
                # the order of each germ's two depths, between the largest and the least rho
                ords = []
                for z, zn in ((x, "x"), (y, "y")):
                    for nm in at[z]:
                        for k, side in ((0, "in"), (1, "out")):
                            a, b = depth[(z, nm, RHOS[0])][k], depth[(z, nm, RHOS[-1])][k]
                            if a > TOL and b > TOL:
                                e = math.log(a / b) / math.log(RHOS[0] / RHOS[-1]); ords.append(f"{zn}:{nm}:{side}:{e:.2f}"); orders.append(round(e))
                            elif a > TOL or b > TOL: ords.append(f"{zn}:{nm}:{side}:only-at-{'large' if a > TOL else 'small'}-rho")
                stop_lines.append(line + " | orders " + " ".join(ords))
            if inside and not empty:
                # ---------------- reading 2: how each cell of a coloured point is paid for
                inside_n += 1
                wl = frozenset(A) | frozenset(B); lab_hist[len(wl)] = lab_hist.get(len(wl), 0) + 1
                sep_hist[sep] = sep_hist.get(sep, 0) + 1
                for z in (x, y):
                    nb = sorted(l for l, s in st[z].items() if s == "bar")
                    barred_hist[len(nb)] = barred_hist.get(len(nb), 0) + 1
                    barred_absent[0] += len(nb); barred_absent[1] += sum(1 for l in nb if l not in wl)
                rr = min(RR.R2, 0.9 * eta); seen = set()
                nsing = sum(1 for c in cells.values() if len(c) == 1); sing_hist[nsing] = sing_hist.get(nsing, 0) + 1
                present = {k: set() for k in cells}
                for i in range(RR.NS):
                    q = (w[0] + rr * math.cos(TAU * (i + 0.5) / RR.NS), w[1] + rr * math.sin(TAU * (i + 0.5) / RR.NS))
                    dx, dy = dist(q, x) - 1, dist(q, y) - 1
                    if abs(dx) < 1e-4 * rr or abs(dy) < 1e-4 * rr: continue
                    Q = tile(q)
                    if Q is None: continue
                    cell = ("in" if dx < 0 else "out", "in" if dy < 0 else "out")
                    present[cell].add(TF[Q][0])
                    if FAULT: cell = (cell[1], cell[0]) if False else ("out" if cell[0] == "in" else "in", cell[1])
                    for zi, z in enumerate((x, y)):
                        key = (cell, Q, zi)
                        if key in seen: continue
                        seen.add(key)
                        lab = TF[Q][0]; mine = [nm for nm in at[z] if TF[nm][0] == lab]
                        if not mine: kind = "free"
                        else:
                            s = st[z][lab]
                            if s == "bar" or s != cell[zi]: kind = "BAD"
                            elif Q in mine: kind = "same"
                            else: kind = "facing" if s == "in" else "backing"
                        pay[kind] = pay.get(kind, 0) + 1
                        if kind in ("facing",) and len(pay_lines) < 12:
                            pay_lines.append(f"   facing: w=({w[0]:.5f},{w[1]:.5f}) z=({z[0]:.5f},{z[1]:.5f}) tile-at-w={Q} tiles-at-z={','.join(mine)} label={lab}")
                for k in cells:
                    tight[1] += 1; tight[0] += (present[k] == cells[k])
    if SCAN: return scan(name, TF, tile, at, members)
    print(f"== {name}{' (FAULT)' if FAULT else ''}: labels={len(palette)} members={len(members)}")
    print(f"   READING 1 (germs): stops with an empty cell by whole tiles, not inside: {stops['n']} | still with an empty cell by germs: " +
          " ".join(f"rho={r}:{germ_stop[r]}" for r in RHOS) + " | orders of the germ depths (rounded): " +
          (" ".join(f"{k}:{orders.count(k)}" for k in sorted(set(orders))) or "none"))
    print(f"   READING 2 (payments): coloured common unit points inside: {inside_n} | labels at the point " + " ".join(f"{k}:{v}" for k, v in sorted(lab_hist.items())) +
          " | which member separates " + " ".join(f"{k}:{v}" for k, v in sorted(sep_hist.items())))
    print("   payments (cell, tile at w, member): " + (" ".join(f"{k}:{v}" for k, v in sorted(pay.items())) or "none") +
          " | labels barred at a member, per (point, member): " + " ".join(f"{k}:{v}" for k, v in sorted(barred_hist.items())) +
          f" | barred labels that are absent at w: {barred_absent[1]} of {barred_absent[0]}")
    print("   singleton cells per coloured point (cells with exactly one unbarred label; such a cell is a.e. that label): " +
          " ".join(f"{k}:{v}" for k, v in sorted(sing_hist.items())) + f" | cells whose unbarred labels are exactly the labels present there: {tight[0]} of {tight[1]}")
    os.makedirs(os.path.join(HERE, "out"), exist_ok=True)
    if not FAULT:
        open(os.path.join(HERE, "out", f"{name}.txt"), "w").write("\n".join(stop_lines + pay_lines) + "\n")
    return 0


if __name__ == "__main__":
    for n in (ARGS or ["sixfrag", "disk", "bowtie", "strip", "kept", "T2", "r7"]): read(n)

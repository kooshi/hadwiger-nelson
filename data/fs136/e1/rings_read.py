#!/usr/bin/env python3
"""FS136-E1 — C136-RINGS-READ: every held six-coloured object read at its covering pairs and their common unit points.
A reading by formula from each object's own tiles ([tools], floats, one mind); it proves nothing about a colouring not read.

  python3 data/fs136/e1/rings_read.py <object> ... [--fault] [--brief] [--list]
  objects: strip disk capped bowtie sixfrag T2 S1 MX BB kept r7

Copied from data/fs124/e2/saves_read.py (FS124-E2's reader, not edited there): tiles_col, arc_angles, from_q3 and the
loaders of strip, disk, capped, T2, BB, S1, MX, sixfrag, kept.  Added here: the bowtie fragment (tools/fs114_y2_k1.py),
vertices kept at full precision (the source rounds them to nine decimals), R7 as tiles (unit Reuleaux triangles on the triangular lattice and the concave triangles between them, labels read from
data/fs124/e1/tight_checks.py's r7col at each tile's centroid), whole tiles as pieces, and the table.

What it reads (floats from the objects' exact pieces; nothing is searched):
  vertices   every end point of a boundary piece; the labels on circles of radius 2e-2 and 1e-2 about it (1440 samples
             each); a vertex with an unread sample is "on the cut" and is neither a member nor a centre;
  members    vertices with three or more labels; centres: vertices with four or more labels;
  pairs      COVERING PAIRS: two members with 0 < distance < 2 whose labels together are all the labels of the object;
             "on a ring" if some centre is at distance 1 from both;
  at w       for each pair and each of its two common unit points w: inside (both small circles about w read) or not;
             THE TABLE from WHOLE TILES: the pieces of a member z are the tiles with z on their boundary; a tile is inner
             at w if its greatest distance from w is <= 1 + 1e-9, outer if its least distance is >= 1 - 1e-9, crossing
             otherwise; a label of z is inner-pure / outer-pure / barred as its tiles are all inner / all outer / else;
             the four cells (inside or outside each member's unit circle) with the labels no state bars there;
             class L0 = neither member separates by labels, L1 = one separates and some cell is empty, L2 = no cell empty;
             if w is inside: every sample on the circle of radius 1e-2 about w checked against its cell's labels
             (a violation would refute C136-TABLE on a held object, or the reader);
  rings      for each centre p: its members at distance 1, the covering pairs among them, each point across x + y - p with
             its distance from p, inside or not, and its class; the least distance of a point across not inside.
What it cannot see: a member that is no end of a piece; a pair neither of whose common unit points matters to a ring is
still listed under "pairs"; anything beyond the object's own tiles; exactness (the three radii are checked exactly by
stop_check.py).
--fault moves every member of every pair by 0.01 before the table is read: violations at inside points must appear.
"""
import sys, os, math, itertools
HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, "..", "..", ".."))
sys.path.insert(0, os.path.join(ROOT, "tools")); sys.path.insert(0, os.path.join(ROOT, "data", "fs124", "e1"))
sys.path.insert(0, os.path.join(ROOT, "data", "search", "2026-10-07"))
ARGS = [a for a in sys.argv[1:] if not a.startswith("--")]
FAULT, BRIEF, LIST = "--fault" in sys.argv, "--brief" in sys.argv, "--list" in sys.argv
sys.argv = [sys.argv[0]]
import fs116_n1_ring as RG
TAU = 2 * math.pi
R1, R2, NS, TOL = 2e-2, 1e-2, 1440, 1e-9


def dist(p, q): return math.hypot(p[0] - q[0], p[1] - q[1])
def rnd(p): return (round(p[0], 9) + 0.0, round(p[1], 9) + 0.0)


# ------------------------------------------------------------------ copied from data/fs124/e2/saves_read.py
def arc_angles(pc, n):
    _, C, rho, S, E = pc
    a0 = math.atan2(S[1] - C[1], S[0] - C[0]); a1 = math.atan2(E[1] - C[1], E[0] - C[0])
    return [a0 + ((a1 - a0) % TAU) * (i + 0.5) / n for i in range(n)]


def tiles_col(TF):
    box = {}
    for nm, (c, ps) in TF.items():
        xs, ys = [], []
        for pc in ps:
            if pc[0] == "S": pts = [pc[1], pc[2]]
            else: pts = [(pc[1][0] + sx * pc[2], pc[1][1] + sy * pc[2]) for sx in (-1, 1) for sy in (-1, 1)] if pc[2] < 0.3 else [pc[3], pc[4]] + [
                (pc[1][0] + pc[2] * math.cos(a), pc[1][1] + pc[2] * math.sin(a)) for a in arc_angles(pc, 12)]
            xs += [p[0] for p in pts]; ys += [p[1] for p in pts]
        box[nm] = (min(xs) - 0.02, max(xs) + 0.02, min(ys) - 0.02, max(ys) + 0.02)
    def tile(p):
        cand = [nm for nm, b in box.items() if b[0] <= p[0] <= b[1] and b[2] <= p[1] <= b[3]]
        out = []
        for a in (0.1234567, 2.345678, 4.0123, 5.31, 1.0471):
            d = (math.cos(a), math.sin(a))
            out.append(tuple(sorted(nm for nm in cand if sum(RG.ray_hits(pc, p, d) for pc in TF[nm][1]) % 2 == 1)))
            if len(out) >= 3 and out.count(out[-1]) >= 3: break
        ts = max(out, key=out.count)
        return ts[0] if len(ts) == 1 else None
    def col(p):
        t = tile(p)
        return TF[t][0] if t is not None else None
    seen = {}
    for c, ps in TF.values():
        for pc in ps:
            for p in ((pc[1], pc[2]) if pc[0] == "S" else (pc[3], pc[4])): seen.setdefault(rnd(p), (float(p[0]), float(p[1])))
    verts = [seen[k] for k in sorted(seen)]          # CHANGED from the source: full precision kept, rounding only merges duplicates
    return col, tile, verts


def from_q3(T):
    import fs110_y_check as C
    f = lambda p: (C.q(p[0]).f(), C.q(p[1]).f())
    out = {}
    for nm, (col, ps) in T.items():
        out[nm] = (col, [("S", f(p.P), f(p.Q)) if isinstance(p, C.Seg) else ("A", f(p.C), C.q(p.r).f(), f(p.S), f(p.E)) for p in ps])
    return out


def load(name):
    if name in ("strip", "disk"):
        for lab, T, p in RG.objects():
            if lab.split()[0] == name: return RG.fl_tiles(T)
    if name == "capped":
        import fs114_y_dial as D, fs114_yb3_run as XR
        return RG.fl_tiles(XR.conv_tiles(D.CappedStrip().tiles(-4, 6)))
    if name in ("T2", "BB", "S1", "MX"):
        import fs110_y_fragments as F
        return from_q3(F.FRAGS[name]())
    if name == "sixfrag":
        import fs116_y2_six as Y2
        f = lambda p: (float(p[0]), float(p[1]))
        return {t.name: (t.colour, [("S", f(pc.P), f(pc.Q)) if pc.kind == "S" else ("A", f(pc.C), float(pc.rho), f(pc.S), f(pc.E))
                                    for pc in t.pieces]) for t in Y2.fragment()[3]}
    if name == "kept":
        import json, turning_ring as TR
        from fractions import Fraction as Fr
        m = json.load(open(os.path.join(ROOT, "data", "search", "2026-10-07", "KEEP-turning-4label-arcs.json")))
        ta = Fr(1, 8); T = {}
        for k in range(6):
            for i, prims in enumerate(TR.ring_flower(k, ta)): T[f"y{k}_{i}"] = (m["ring"][k][i], prims)
        for j in range(12): T[f"x_{j}"] = (m["x"][j], TR.x_subtile(j, m["K"][TR.crit_of(j)[1]], ta))
        return from_q3(T)
    # ---------------------------------------------------------------- added by this job
    if name == "bowtie":
        import fs114_y2_k1 as K1
        f = lambda p: (float(p[0]), float(p[1]))
        return {t.name: (t.colour, [("S", f(pc.P), f(pc.Q)) if pc.kind == "S" else ("A", f(pc.C), float(pc.rho), f(pc.S), f(pc.E))
                                    for pc in t.pieces]) for t in K1.build()}
    if name == "r7":
        import tight_checks as TC
        L = lambda m, n: (m + n / 2.0, n * math.sqrt(3) / 2)
        T = {}
        for m in range(-2, 3):
            for n in range(-2, 3):
                A, B, C = L(m, n), L(m + 1, n), L(m, n + 1)
                g = ((A[0] + B[0] + C[0]) / 3, (A[1] + B[1] + C[1]) / 3)
                T[f"u{m},{n}"] = (TC.r7col(g), [("A", A, 1.0, B, C), ("A", B, 1.0, C, A), ("A", C, 1.0, A, B)])
                D1, D2, D3 = L(m + 1, n), L(m, n + 1), L(m + 1, n + 1)
                g = ((D1[0] + D2[0] + D3[0]) / 3, (D1[1] + D2[1] + D3[1]) / 3)
                T[f"d{m},{n}"] = (TC.r7col(g), [("A", L(m, n), 1.0, D1, D2), ("A", L(m + 2, n), 1.0, D3, D1), ("A", L(m, n + 2), 1.0, D2, D3)])
        return T
    raise SystemExit(f"unknown object {name}")


# ------------------------------------------------------------------ geometry of whole tiles
def piece_minmax(pc, w):
    if pc[0] == "S":
        a, b = pc[1], pc[2]
        e = (b[0] - a[0], b[1] - a[1]); L2 = e[0] * e[0] + e[1] * e[1]
        t = max(0.0, min(1.0, ((w[0] - a[0]) * e[0] + (w[1] - a[1]) * e[1]) / L2)) if L2 > 0 else 0.0
        return dist(w, (a[0] + t * e[0], a[1] + t * e[1])), max(dist(w, a), dist(w, b))
    _, C, rho, S, E = pc
    ds = [dist(w, S), dist(w, E)]
    dc = dist(w, C)
    if dc < 1e-12: return rho, rho
    a0 = math.atan2(S[1] - C[1], S[0] - C[0]); span = (math.atan2(E[1] - C[1], E[0] - C[0]) - a0) % TAU
    aw = math.atan2(w[1] - C[1], w[0] - C[0])
    lo, hi = min(ds), max(ds)
    if (aw - a0) % TAU <= span: lo = min(lo, abs(dc - rho))
    if (aw + math.pi - a0) % TAU <= span: hi = max(hi, dc + rho)
    return lo, hi


def piece_dist(pc, v): return piece_minmax(pc, v)[0]


def side(TF, tile, nm, w):
    """(side, depth): depth is the witness depth C124-TYPE's radius comes from (eta = depth / 2): how far the tile reaches
    strictly inside the unit circle about w (inner), outside it (outer), or the lesser of the two (crossing)."""
    mm = [piece_minmax(pc, w) for pc in TF[nm][1]]
    hi = max(m[1] for m in mm); lo = 0.0 if tile(w) == nm else min(m[0] for m in mm)
    if hi <= 1 + TOL: return "inner", 1 - lo
    if lo >= 1 - TOL: return "outer", hi - 1
    return "crossing", min(1 - lo, hi - 1)


def circle_labels(col, v, r):
    seq = [col((v[0] + r * math.cos(TAU * (i + 0.5) / NS), v[1] + r * math.sin(TAU * (i + 0.5) / NS))) for i in range(NS)]
    return None if None in seq else seq


def table(TF, tile, x, y, w, palette, at):
    """states[z][label] in {'in','out','bar'}; cells[(sx, sy)] = set of labels not barred there (sx, sy in {'in','out'})."""
    st = {}; eta = 1.0
    for z in (x, y):
        by = {}
        for nm in at[z]:
            sd, dp = side(TF, tile, nm, w); eta = min(eta, dp / 2)
            by.setdefault(TF[nm][0], []).append(sd)
        st[z] = {l: ("in" if all(s == "inner" for s in ss) else ("out" if all(s == "outer" for s in ss) else "bar")) for l, ss in by.items()}
    cells = {}
    for sx in ("in", "out"):
        for sy in ("in", "out"):
            cells[(sx, sy)] = {l for l in palette if st[x].get(l, sx) == sx and st[y].get(l, sy) == sy}
    sep = "".join(n for n, z in (("x", x), ("y", y)) if "in" in st[z].values() and "out" in st[z].values()) or "-"
    empty = sum(1 for c in cells.values() if not c)
    cls = "L0" if sep == "-" else ("L1" if empty else "L2")
    return st, cells, sep, empty, cls, eta


def fmt_state(st, z): return ",".join(f"{l}:{s}" for l, s in sorted(st[z].items(), key=lambda t: str(t[0])))
def fmt_cells(cells): return " ".join(f"{a}/{b}=" + ("".join(sorted(map(str, c))) or "EMPTY") for (a, b), c in sorted(cells.items()))


def read(name):
    TF = load(name); col, tile, verts = tiles_col(TF)
    palette = frozenset(c for c, ps in TF.values())
    V = {}
    for v in verts:
        A, B = circle_labels(col, v, R1), circle_labels(col, v, R2)
        V[v] = None if (A is None or B is None) else frozenset(A) | frozenset(B)
    at = {v: [nm for nm, (c, ps) in TF.items() if min(piece_dist(pc, v) for pc in ps) < 1e-7] for v, labs in V.items() if labs is not None}
    members = sorted(v for v, labs in V.items() if labs is not None and len(labs) >= 3)
    centres = sorted(v for v, labs in V.items() if labs is not None and len(labs) >= 4)
    hist = {}
    for v, labs in V.items():
        k = "on-the-cut" if labs is None else f"{len(labs)}-label"
        hist[k] = hist.get(k, 0) + 1
    lines = [f"== {name}: tiles={len(TF)} labels={len(palette)} vertices={len(V)} " + " ".join(f"{k}:{n}" for k, n in sorted(hist.items())) +
             f" | members(>=3)={len(members)} centres(>=4)={len(centres)}"]
    # ---- covering pairs, from the members
    pairs = []; detail = []
    tally = dict(pairs=0, ring=0, inside=0, notin=0, viol=0, checked=0, eta=1.0, thin=0)
    cls_in = {}; cls_out = {}; labs_at_inside = {}
    for x, y in itertools.combinations(members, 2):
        d = dist(x, y)
        if not (1e-9 < d < 2 - 1e-9) or (V[x] | V[y]) != palette: continue
        tally["pairs"] += 1
        mid = ((x[0] + y[0]) / 2, (x[1] + y[1]) / 2); h = math.sqrt(1 - d * d / 4); nrm = ((y[1] - x[1]) / d, -(y[0] - x[0]) / d)
        ws = [(mid[0] + sg * h * nrm[0], mid[1] + sg * h * nrm[1]) for sg in (1, -1)]
        onring = [p for p in centres if abs(dist(p, x) - 1) < 1e-7 and abs(dist(p, y) - 1) < 1e-7]
        tally["ring"] += bool(onring)
        xx, yy = (x, y) if not FAULT else ((x[0] + 0.01, x[1]), (y[0], y[1] + 0.01))
        rec = []
        for w in ws:
            A = circle_labels(col, w, R2); B = circle_labels(col, w, R1)
            inside = A is not None and B is not None
            atf = at if not FAULT else {xx: at[x], yy: at[y]}
            st, cells, sep, empty, cls, eta = table(TF, tile, xx, yy, w, palette, atf)
            viol = 0; wl = None
            if inside:
                tally["inside"] += 1; wl = frozenset(A) | frozenset(B)
                rr = min(R2, 0.9 * eta); tally["eta"] = min(tally["eta"], eta)      # the table is claimed within eta of w only
                if rr < 1e-7: tally["thin"] += 1
                for i in range(NS if rr >= 1e-7 else 0):
                    z = (w[0] + rr * math.cos(TAU * (i + 0.5) / NS), w[1] + rr * math.sin(TAU * (i + 0.5) / NS))
                    dx, dy = dist(z, xx) - 1, dist(z, yy) - 1
                    if abs(dx) < 1e-4 * rr or abs(dy) < 1e-4 * rr: continue
                    tally["checked"] += 1
                    if col(z) not in cells[("in" if dx < 0 else "out", "in" if dy < 0 else "out")]: viol += 1
                tally["viol"] += viol
                cls_in[cls] = cls_in.get(cls, 0) + 1
                labs_at_inside[len(wl)] = labs_at_inside.get(len(wl), 0) + 1
            else:
                tally["notin"] += 1; cls_out[cls] = cls_out.get(cls, 0) + 1
            rec.append((w, inside, wl, st, cells, sep, empty, cls, viol))
            detail.append(f"   pair x=({x[0]:.5f},{x[1]:.5f})[{''.join(sorted(map(str, V[x])))}] y=({y[0]:.5f},{y[1]:.5f})[{''.join(sorted(map(str, V[y])))}] d={d:.5f} "
                          f"w=({w[0]:.5f},{w[1]:.5f}) {'inside labels=' + ''.join(sorted(map(str, wl))) if inside else 'NOT-INSIDE'} class={cls} sep={sep} "
                          f"x[{fmt_state(st, xx)}] y[{fmt_state(st, yy)}] cells(x/y): {fmt_cells(cells)}" + (f" VIOLATIONS={viol}" if viol else ""))
        pairs.append((x, y, d, ws, rec))
    lines.append(f"   covering-pairs={tally['pairs']} on-the-ring-of-a-centre={tally['ring']} | common-unit-points: inside={tally['inside']} not-inside={tally['notin']}")
    lines.append("   inside: classes " + (" ".join(f"{k}:{v}" for k, v in sorted(cls_in.items())) or "none") + " | labels-at-the-point " +
                 (" ".join(f"{k}:{v}" for k, v in sorted(labs_at_inside.items())) or "none") +
                 f" | table-violations={tally['viol']} of {tally['checked']} samples (least eta {tally['eta']:.2e}; points too thin to sample {tally['thin']})")
    lines.append("   not-inside: classes " + (" ".join(f"{k}:{v}" for k, v in sorted(cls_out.items())) or "none"))
    # ---- rings
    least = {}; stopcls = {}
    for p in centres:
        ring = [m for m in members if abs(dist(m, p) - 1) < 1e-7]
        rp = [(x, y, d, ws, rec) for (x, y, d, ws, rec) in pairs if abs(dist(p, x) - 1) < 1e-7 and abs(dist(p, y) - 1) < 1e-7]
        acr = []
        for x, y, d, ws, rec in rp:
            k = 0 if dist(ws[0], p) > dist(ws[1], p) else 1          # the point across is the common unit point that is not p
            w, inside, wl, st, cells, sep, empty, cls, viol = rec[k]
            acr.append((dist(w, p), inside, cls, w, x, y, wl))
        out = sorted(a for a in acr if not a[1])
        ins = [a for a in acr if a[1]]
        row = (f"   centre p=({p[0]:.5f},{p[1]:.5f}) labels={''.join(sorted(map(str, V[p])))} ring-members={len(ring)} "
               f"(by labels {' '.join(str(len(V[m])) for m in ring)}) covering-pairs-on-ring={len(rp)} across-inside={len(ins)} "
               f"(classes {' '.join(sorted(a[2] for a in ins)) or '-'}) across-not-inside={len(out)}")
        if out:
            dmin = out[0][0]
            near = [a for a in out if a[0] < dmin + 1e-6]
            row += f" least-distance={dmin:.6f} at " + " ".join(f"({a[3][0]:.5f},{a[3][1]:.5f}):{a[2]}" for a in near)
            key = round(dmin, 4); least[key] = least.get(key, 0) + 1
            for a in near: stopcls[a[2]] = stopcls.get(a[2], 0) + 1
        detail.append(row)
    lines.append("   rings: centres=" + str(len(centres)) + " least-distance-of-a-point-across-not-inside " +
                 (" ".join(f"{k}:{v}" for k, v in sorted(least.items())) or "none") + " | class-at-that-point " +
                 (" ".join(f"{k}:{v}" for k, v in sorted(stopcls.items())) or "none"))
    if BRIEF:
        print(f"{name}: labels={len(palette)} members={len(members)} centres={len(centres)} covering-pairs={tally['pairs']} on-a-ring={tally['ring']} "
              f"inside={tally['inside']}[" + ",".join(f"{k}:{v}" for k, v in sorted(cls_in.items())) + f"] violations={tally['viol']} "
              f"not-inside={tally['notin']}[" + ",".join(f"{k}:{v}" for k, v in sorted(cls_out.items())) + "] least=" +
              (",".join(f"{k}:{v}" for k, v in sorted(least.items())) or "none") + " stop-class=" + (",".join(f"{k}:{v}" for k, v in sorted(stopcls.items())) or "none"))
        return 0
    print("\n".join(lines))
    if LIST: print("\n".join(detail))
    os.makedirs(os.path.join(HERE, "out"), exist_ok=True)
    if not FAULT: open(os.path.join(HERE, "out", f"{name}.txt"), "w").write("\n".join(lines + detail) + "\n")
    return 0


if __name__ == "__main__":
    if not ARGS: print(__doc__); sys.exit(2)
    sys.exit(max(read(n) for n in ARGS))

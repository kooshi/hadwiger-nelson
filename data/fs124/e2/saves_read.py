#!/usr/bin/env python3
"""FS124-E2 — C124-READ-SAVES: every held six-coloured object read at its three-label vertices, their close complementary
pairs and the pairs' common unit points.  A reading by formula from each object's own tiles; controls, never theorems.

  python3 data/fs124/e2/saves_read.py <object> ... [--fault] [--list] [--brief]   (--brief: one line per object, for the record's controls)
  objects: strip disk capped T2 BB S1 MX sixfrag kept r7 hex7

How it reads (floats from the objects' exact pieces; nothing is searched):
  vertices   every end point of a boundary piece (for r7 / hex7: the lattice points / hexagon corners of a window);
  sectors    the labels on circles of radius 2e-2 and 1e-2 about a vertex, 1440 samples, every change of label refined by
             bisection to 1e-13 rad; a vertex with an unread sample is "on the cut" and is no member;
  members    vertices with exactly three labels and three sectors ("sector") or four sectors a, b, a, c ("bowtie");
  pairs      two members with disjoint label triples, 0 < distance < 2; their two common unit points w, each kept if every sample
             on both circles about it is read ("inside");
  at w       the labels on the two circles; for each member z: the edges at z (the refined boundary points at both radii) lying
             on S(w) to 1e-9 — the PATTERN; each piece of z (sectors merged by label) by SIDE: inner, outer or crossing, from
             sampled points of its sectors at both radii with | |p - w| - 1 | > 1e-10; z SEPARATES if it has an inner and an
             outer piece; for pattern (1, 1): the two other edges of each member strictly on opposite sides of S(w) (C124-HALF-TWO's
             hypothesis); where each member has one inner, one outer and one crossing piece, whether the labels at w are exactly the four
             labels of the inner and outer pieces;
  arcs       every boundary piece of radius 1 whose centre is inside: its side labels at the midpoint; "kind both" if both are
             labels at its centre; "edge of a save" if a member of a pair with that centre as common unit point has an edge on
             that circle running into the piece.
What it cannot see: a sector narrower than 0.25 degrees at radius 1e-2; a vertex that is no end of a piece; anything of the
kept model, T2, BB, S1, MX beyond their small flowers.
--fault moves every common unit point by 0.01 before it is read: every pattern must read (0, 0) and no member separate.
"""
import sys, os, math, itertools
HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, "..", "..", ".."))
sys.path.insert(0, os.path.join(ROOT, "tools")); sys.path.insert(0, os.path.join(ROOT, "data", "fs124", "e1"))
sys.path.insert(0, os.path.join(ROOT, "data", "search", "2026-10-07"))
ARGS = [a for a in sys.argv[1:] if not a.startswith("--")]
FAULT, LIST, BRIEF = "--fault" in sys.argv, "--list" in sys.argv, "--brief" in sys.argv
sys.argv = [sys.argv[0]]
import fs116_n1_ring as RG
TAU = 2 * math.pi
R1, R2, NS = 2e-2, 1e-2, 1440


def e(t): return (math.cos(t), math.sin(t))
def dist(p, q): return math.hypot(p[0] - q[0], p[1] - q[1])
def rnd(p): return (round(p[0], 9), round(p[1], 9))


# ------------------------------------------------------------------ objects -> ({tile: (label, pieces)} | None, col, vertices)
def tiles_col(TF):
    box = {}
    for nm, (c, ps) in TF.items():
        xs, ys = [], []
        for pc in ps:
            if pc[0] == "S": pts = [pc[1], pc[2]]
            else: pts = [(pc[1][0] + sx * pc[2], pc[1][1] + sy * pc[2]) for sx in (-1, 1) for sy in (-1, 1)] if pc[2] < 0.3 else [pc[3], pc[4]] + [
                (pc[1][0] + pc[2] * math.cos(a), pc[1][1] + pc[2] * math.sin(a)) for a in arc_angles(pc, 12)]
            xs += [p[0] for p in pts]; ys += [p[1] for p in pts]
        box[nm] = (min(xs) - 0.02, max(xs) + 0.02, min(ys) - 0.02, max(ys) + 0.02)   # 0.02 exceeds the sagitta of a twelfth of any arc
    def col(p):
        cand = [nm for nm, b in box.items() if b[0] <= p[0] <= b[1] and b[2] <= p[1] <= b[3]]
        out = []
        for a in (0.1234567, 2.345678, 4.0123, 5.31, 1.0471):      # ray parity; a ray through a vertex miscounts, so five rays vote
            d = (math.cos(a), math.sin(a))
            out.append(tuple(sorted(nm for nm in cand if sum(RG.ray_hits(pc, p, d) for pc in TF[nm][1]) % 2 == 1)))
            if len(out) >= 3 and out.count(out[-1]) >= 3: break
        ts = max(out, key=out.count)
        return TF[ts[0]][0] if len(ts) == 1 else None
    verts = sorted({rnd(p) for c, ps in TF.values() for pc in ps for p in ((pc[1], pc[2]) if pc[0] == "S" else (pc[3], pc[4]))})
    return col, verts


def arc_angles(pc, n):
    _, C, rho, S, E = pc
    a0 = math.atan2(S[1] - C[1], S[0] - C[0]); a1 = math.atan2(E[1] - C[1], E[0] - C[0])
    return [a0 + ((a1 - a0) % TAU) * (i + 0.5) / n for i in range(n)]


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
    raise SystemExit(f"unknown object {name}")


def formula(name):
    import tight_checks as TC
    if name == "r7":
        verts = [rnd((m + n / 2.0, n * math.sqrt(3) / 2)) for m in range(-3, 4) for n in range(-3, 4)]
        return TC.r7col, verts
    r = 0.4; ap = math.sqrt(3) * r / 2
    cen = [(m * 2 * ap + n * ap, n * 1.5 * r) for m in range(-6, 7) for n in range(-6, 7)]
    verts = sorted({rnd((c[0] + r * math.cos(TAU * (k + 0.5) / 6), c[1] + r * math.sin(TAU * (k + 0.5) / 6))) for c in cen for k in range(6)
                    if abs(c[0]) < 1.6 and abs(c[1]) < 1.6})
    return (lambda p: TC.hexcol(p, r)), verts


# ------------------------------------------------------------------ the reading
def circle(col, v, r):
    """runs [(a0, a1, label)] on the circle of radius r about v, boundaries refined; None if some sample is unread."""
    seq = [col((v[0] + r * math.cos(TAU * (i + 0.5) / NS), v[1] + r * math.sin(TAU * (i + 0.5) / NS))) for i in range(NS)]
    if None in seq: return None
    if len(set(seq)) == 1: return [(0.0, TAU, seq[0])]
    cuts = []
    for i in range(NS):
        if seq[i] != seq[i - 1]:
            lo, hi = TAU * (i - 0.5) / NS, TAU * (i + 0.5) / NS
            for _ in range(46):
                mid = (lo + hi) / 2
                if col((v[0] + r * math.cos(mid), v[1] + r * math.sin(mid))) == seq[i - 1]: lo = mid
                else: hi = mid
            cuts.append(((lo + hi) / 2, seq[i]))
    return [(cuts[k][0], cuts[(k + 1) % len(cuts)][0], cuts[k][1]) for k in range(len(cuts))]


def side_of(runs_by_r, v, w, label):
    has_in = has_out = False
    for r, runs in runs_by_r:
        for a0, a1, l in runs:
            if l != label: continue
            span = (a1 - a0) % TAU or TAU
            offs = [span * (i + 0.5) / 40 for i in range(40)] + [x for d in (1e-4, 1e-3, 1e-2) if d < span / 2 for x in (d, span - d)]
            for o in offs:
                d = dist((v[0] + r * math.cos(a0 + o), v[1] + r * math.sin(a0 + o)), w) - 1
                has_in |= d < -1e-10; has_out |= d > 1e-10
    return "crossing" if has_in and has_out else ("inner" if has_in else ("outer" if has_out else "on"))


def edges_on(runs_by_r, v, w):
    """indices k of edges of v (the boundary beginning run k) whose refined boundary points at both radii lie on S(w);
    and for every edge the sign pair of |p - w| - 1 at the two radii."""
    (r1, A), (r2, B) = runs_by_r
    if len(A) != len(B): return None, None
    on, signs = [], []
    for k in range(len(A)):
        d = [dist((v[0] + r * math.cos(a), v[1] + r * math.sin(a)), w) - 1 for r, a in ((r1, A[k][0]), (r2, B[k][0]))]
        if all(abs(x) < 1e-9 for x in d): on.append(k)
        signs.append(tuple(0 if abs(x) < 1e-9 else (1 if x > 0 else -1) for x in d))
    return on, signs


def read(name):
    if name in ("r7", "hex7"): TF = None; col, verts = formula(name)
    else: TF = load(name); col, verts = tiles_col(TF)
    V = {}
    for v in verts:
        A, B = circle(col, v, R1), circle(col, v, R2)
        if A is None or B is None: V[v] = ("cut", None, None); continue
        labs = frozenset(l for _, _, l in A) | frozenset(l for _, _, l in B)
        V[v] = ("in", labs, [(R1, A), (R2, B)])
    members = {}
    for v, (st, labs, rr) in V.items():
        if st != "in" or len(labs) != 3: continue
        n = (len(rr[0][1]), len(rr[1][1]))
        members[v] = "sector" if n == (3, 3) else ("bowtie" if n == (4, 4) else f"other{n}")
    palette = frozenset(l for st, labs, rr in V.values() if st == "in" for l in labs)
    kinds = {}
    for st, labs, rr in V.values():
        k = "on-the-cut" if st != "in" else f"{len(labs)}-label/{len(rr[0][1])}-sector"
        kinds[k] = kinds.get(k, 0) + 1
    lines = [f"== {name}: vertices={len(V)} " + " ".join(f"{k}:{n}" for k, n in sorted(kinds.items())) +
             f" | members: sector={sum(k == 'sector' for k in members.values())} bowtie={sum(k == 'bowtie' for k in members.values())}"
             f" other={sum(k.startswith('other') for k in members.values())} labels={len(palette)}"]
    tally = dict(pairs=0, inside=0, notin=0); pat = {}; sep = {}; four = [0, 0]; half = [0, 0]; saves = []; detail = []
    M = sorted(members)
    for x, y in itertools.combinations(M, 2):
        d = dist(x, y)
        if (V[x][1] & V[y][1]) or not (1e-9 < d < 2 - 1e-9): continue
        tally["pairs"] += 1
        mid = ((x[0] + y[0]) / 2, (x[1] + y[1]) / 2); h = math.sqrt(1 - d * d / 4); nrm = ((y[1] - x[1]) / d, -(y[0] - x[0]) / d)
        for sg in (1, -1):
            w = (mid[0] + sg * h * nrm[0], mid[1] + sg * h * nrm[1])
            if FAULT: w = (w[0] + 0.01, w[1])
            WA, WB = circle(col, w, R1), circle(col, w, R2)
            if WA is None or WB is None: tally["notin"] += 1; continue
            tally["inside"] += 1
            wl = frozenset(l for _, _, l in WA) | frozenset(l for _, _, l in WB)
            row = []; io = set(); p = []; ok_half = True
            for z in (x, y):
                on, signs = edges_on(V[z][2], z, w)
                sides = {l: side_of(V[z][2], z, w, l) for l in sorted(V[z][1], key=str)}
                s = "inner" in sides.values() and "outer" in sides.values()
                io |= {l for l, t in sides.items() if t in ("inner", "outer")}
                p.append(len(on) if on is not None else -1)
                if on is not None and len(on) == 1 and len(signs) == 3:
                    oth = [signs[k] for k in range(3) if k != on[0]]
                    ok_half &= {oth[0], oth[1]} == {(1, 1), (-1, -1)}
                else: ok_half = False
                row.append((z, members[z], sides, s, on))
                if on:
                    for k in on: saves.append((w, z, V[z][2][0][1][k][0]))
            pat[tuple(p)] = pat.get(tuple(p), 0) + 1
            key = (("x" if row[0][3] else "-") + ("y" if row[1][3] else "-"), row[0][1][0] + row[1][1][0])
            sep[key] = sep.get(key, 0) + 1
            if all(sorted(r[2].values()) == ["crossing", "inner", "outer"] for r in row): four[1] += 1; four[0] += (wl == frozenset(io))
            if tuple(p) == (1, 1): half[1] += 1; half[0] += ok_half
            detail.append(f"   w=({w[0]:.5f},{w[1]:.5f}) labels={''.join(sorted(map(str, wl)))} pattern={tuple(p)} " + " ; ".join(
                f"{kd}({z[0]:.4f},{z[1]:.4f}) " + ",".join(f"{l}:{t}" for l, t in sides.items()) + (" SEP" if s else " no") for z, kd, sides, s, on in row))
    lines.append(f"   close-complementary-pairs={tally['pairs']} common-unit-points: inside={tally['inside']} on-the-cut-or-outside={tally['notin']}")
    lines.append("   patterns: " + (" ".join(f"{k}:{v}" for k, v in sorted(pat.items())) or "none") +
                 " | separating(member kinds): " + (" ".join(f"{k[0]}({k[1]}):{v}" for k, v in sorted(sep.items())) or "none"))
    lines.append(f"   both-members-one-inner-one-outer-one-crossing={four[1]}, labels-at-w-exactly-those-four={four[0]} | pattern-(1,1)-with-HALF-TWO's-hypothesis: {half[0]} of {half[1]}")
    if TF is not None:
        arcs = {}
        for c, ps in TF.values():
            for pc in ps:
                if pc[0] == "A" and abs(pc[2] - 1) < 1e-9: arcs[tuple(sorted((rnd(pc[3]), rnd(pc[4])))) + (rnd(pc[1]),)] = pc
        nb = ns = nc = 0; rest = []
        for key, pc in sorted(arcs.items()):
            C = pc[1]; a = arc_angles(pc, 1)[0]
            CA = circle(col, C, R2)
            if CA is None: nc += 1; continue
            cl = {l for _, _, l in CA}
            i_, o_ = col((C[0] + (1 - 1e-6) * math.cos(a), C[1] + (1 - 1e-6) * math.sin(a))), col((C[0] + (1 + 1e-6) * math.cos(a), C[1] + (1 + 1e-6) * math.sin(a)))
            if i_ == o_ or i_ not in cl or o_ not in cl: continue
            nb += 1
            a0 = math.atan2(pc[3][1] - C[1], pc[3][0] - C[0]); span = (math.atan2(pc[4][1] - C[1], pc[4][0] - C[0]) - a0) % TAU
            hit = False
            for w, z, beta in saves:
                if dist(w, C) > 1e-6: continue
                p = (z[0] + R1 * math.cos(beta), z[1] + R1 * math.sin(beta))
                hit |= (math.atan2(p[1] - C[1], p[0] - C[0]) - a0) % TAU <= span + 1e-9
            ns += hit
            if not hit: rest.append(f"centre=({C[0]:.4f},{C[1]:.4f}) {i_}|{o_} ends=({pc[3][0]:.4f},{pc[3][1]:.4f}),({pc[4][0]:.4f},{pc[4][1]:.4f}) labels-at-centre={''.join(sorted(map(str, cl)))}")
        lines.append(f"   unit-arc-pieces={len(arcs)} centre-on-the-cut={nc} of-kind-both={nb} edge-of-a-save={ns} not={nb - ns}")
        detail += ["   arc not an edge of a save: " + r for r in rest]
    if BRIEF:
        print(f"{name}: members={sum(k == 'sector' for k in members.values())}s+{sum(k == 'bowtie' for k in members.values())}b pairs={tally['pairs']} "
              f"inside={tally['inside']} patterns=" + (",".join(f"{k[0]}{k[1]}:{v}" for k, v in sorted(pat.items())) or "none") + " separating=" +
              (",".join(f"{k[0]}({k[1]}):{v}" for k, v in sorted(sep.items())) or "none") + f" four={four[0]}/{four[1]} half-two={half[0]}/{half[1]}" +
              (f" arcs-of-kind-both={nb} edges-of-saves={ns}" if TF is not None else ""))
        return 0
    print("\n".join(lines))
    if LIST: print("\n".join(detail))
    os.makedirs(os.path.join(HERE, "out"), exist_ok=True)
    if not FAULT: open(os.path.join(HERE, "out", f"{name}.txt"), "w").write("\n".join(lines + detail) + "\n")
    return 0


if __name__ == "__main__":
    if not ARGS: print(__doc__); sys.exit(2)
    sys.exit(max(read(n) for n in ARGS))

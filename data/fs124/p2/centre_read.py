#!/usr/bin/env python3
"""FS124-P2 — a reading of the held objects at their centres, by formula.  Controls, never theorems.

  python3 data/fs124/p2/centre_read.py r7      # R7 at the lattice point (0, 0)
  python3 data/fs124/p2/centre_read.py maps    # FS-112's strip at (0,0) and (1/2,0); its disk at the corner A0
  python3 data/fs124/p2/centre_read.py rhombi  # close complementary pairs among the arcs' three-label ends, and their common unit points
  python3 data/fs124/p2/centre_read.py ends    # the strip's and the disk's unit-arc ends: what each is, and what it is one unit from
  add --fault to plant: r7 -> the up tiles coloured by n mod 2 (the windows' pairs collapse); maps -> the centre moved by 0.01;
                        ends -> every end moved by 0.01

For a centre q it prints
  sectors : the labels met on small circles about q, each with its angular run(s) in degrees at two radii (a run whose width
            shrinks in proportion to the radius is a cusp: a label present along a ray)
  ring    : the runs of (inside label | outside label) on the unit circle about q, read at radial offset 1e-5, step 0.25 deg
  windows : the runs whose two labels differ and are both among the labels at q ("tight, of kind both")
  for each window (a|b) on (t1, t2): the polar of the window, [t2-90, t1+90], against the sector of a; what the ring carries on
            the antipodal arc (t1+180, t2+180); whether (b|a) is tight there
  digraph : the ordered pairs (inside -> outside) over all windows read at all centres of the object
Nothing here searches: every number is a colouring given by formula, read at stated points.
"""
import sys, os, math
HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, "..", "..", ".."))
sys.path.insert(0, os.path.join(ROOT, "data", "fs124", "e1"))
sys.path.insert(0, os.path.join(ROOT, "tools"))
import tight_checks as TC
TAU = 2 * math.pi
FAULT = "--fault" in sys.argv
e, add, dist = TC.e, TC.add, TC.dist


def runs(seq, step):
    """cyclic runs of equal entries: [(start_deg, end_deg, value)]"""
    n = len(seq)
    if all(s == seq[0] for s in seq): return [(0.0, 360.0, seq[0])]
    i0 = next(i for i in range(n) if seq[i] != seq[i - 1])
    out, cur, start = [], seq[i0], i0
    for k in range(1, n + 1):
        i = (i0 + k) % n
        if seq[i] != cur:
            out.append((round(start * step, 3), round(((i0 + k - 1) % n + 1) * step, 3), cur)); cur, start = seq[i], i
    return out


def sectors(col, q, r, n=7200):
    seq = [col(add(q, tuple(r * c for c in e(TAU * (i + 0.5) / n)))) for i in range(n)]
    return runs(seq, 360.0 / n)


def ring(col, q, t=1e-5, n=1440):
    seq = []
    for i in range(n):
        th = TAU * (i + 0.5) / n
        seq.append((col(add(q, tuple((1 - t) * c for c in e(th)))), col(add(q, tuple((1 + t) * c for c in e(th))))))
    return runs(seq, 360.0 / n)


def width(rs, lab):
    return round(sum((b - a) % 360.0 or 360.0 for a, b, v in rs if v == lab), 2)


def fmt(rs):
    return " ".join(f"[{a:g},{b:g}]:{v}" for a, b, v in rs)


def read_centre(name, col, q, digraph):
    s1, s2 = sectors(col, q, 2e-2), sectors(col, q, 2e-3)
    labs = sorted({v for _, _, v in s1 + s2 if v is not None}, key=str)
    fat = [l for l in labs if width(s2, l) > 2.0]
    thin = [l for l in labs if l not in fat]
    print(f"== {name} centre=({q[0]:.4f},{q[1]:.4f})")
    print(f"   labels-at-centre={labs} with-a-sector={fat} along-a-ray={thin}")
    print("   sectors(r=2e-3): " + " ".join(f"{l}:{width(s2, l)}" for l in labs) + "   sectors(r=2e-2): " + " ".join(f"{l}:{width(s1, l)}" for l in labs))
    print("   sector-runs(r=2e-3): " + fmt([x for x in s2 if (x[1] - x[0]) % 360 > 2.0]))
    rg = ring(col, q)
    print("   ring: " + " ".join(f"[{a:g},{b:g}]:{i}|{o}" for a, b, (i, o) in rg))
    wins = [(a, b, i, o) for a, b, (i, o) in rg if i != o and i in labs and o in labs and (b - a) % 360 > 1.0]
    tight = round(sum((b - a) % 360 for a, b, _, _ in wins), 2)
    free = sorted({i for a, b, (i, o) in rg if i == o and i is not None and i not in labs}, key=str)
    print(f"   windows-of-kind-both={len(wins)} tight-degrees={tight} labels-on-the-ring-absent-at-centre={free}")
    for a, b, i, o in wins:
        digraph.add((i, o))
        mid = (a + ((b - a) % 360) / 2 + 180.0) % 360.0
        anti = [(x, y, v) for x, y, v in rg if ((mid - x) % 360.0) < ((y - x) % 360.0)]
        av = anti[0][2] if anti else None
        runs_i = [(x, y) for x, y, v in s2 if v == i and (y - x) % 360 > 2.0]
        print(f"   window [{a:g},{b:g}] {i}|{o}: polar-of-window=[{(b - 90) % 360:g},{(a + 90) % 360:g}] sector-of-{i}={runs_i} "
              f"antipodal-arc-carries={av[0]}|{av[1]} reversed-there={av == (o, i)}")
    return labs, wins


def r7():
    col = (lambda p: TC.r7col(p, plant=True)) if FAULT else TC.r7col
    dg = set()
    labs, wins = read_centre("R7 (seven labels)", col, (0.0, 0.0), dg)
    ins, outs = {a for a, _ in dg}, {b for _, b in dg}
    print(f"   digraph={sorted(dg)} labels-both-inside-and-outside={sorted(ins & outs)}")
    ok = len(wins) == 3 and not (ins & outs) and len(ins) == 3 and len(outs) == 3
    print("r7: " + ("OK" if ok else "FAULT-SEEN"))
    return 0 if ok else 1


def load_maps():
    import fs116_n3_semi as N3
    RG = N3.RG; out = []
    for lab, T, p in RG.objects():
        TF = RG.fl_tiles(T)
        def col(pt, TF=TF):
            ts = N3.locate2(TF, pt)
            return TF[ts[0]][0] if len(ts) == 1 else None
        out.append((lab, TF, col, p))
    return out


def maps():
    bad = 0
    per = {}
    for lab, TF, col, p in load_maps():
        key = lab.split()[0]
        q = (p[0] + 0.01, p[1]) if FAULT else p
        dg = per.setdefault(key, set())
        labs, wins = read_centre(lab, col, q, dg)
        bad += (len(wins) != 4)
    for key, dg in per.items():
        ins, outs = {a for a, _ in dg}, {b for _, b in dg}
        print(f"   {key}: digraph={sorted(dg)} labels-both-inside-and-outside={sorted(ins & outs)} pairs-disjoint={len({x for p in {frozenset(p) for p in dg} for x in p}) == 2 * len({frozenset(p) for p in dg})}")
    print("maps: " + ("OK" if not bad else "FAULT-SEEN"))
    return 1 if bad else 0


def ends():
    import fs116_n3_semi as N3
    done = set(); rc = 0
    shift = 0.01 if FAULT else 0.0
    for lab, TF, col, p in load_maps():
        key = lab.split()[0]
        if key in done: continue
        done.add(key)
        pieces = {}
        for nm, (c, ps) in TF.items():
            for pc in ps:
                if pc[0] == "A" and abs(pc[2] - 1) < 1e-12:
                    _, C, rho, S, E_ = pc
                    k = tuple(sorted([(round(S[0], 6), round(S[1], 6)), (round(E_[0], 6), round(E_[1], 6))])) + (round(C[0], 6), round(C[1], 6))
                    pieces[k] = (C, S, E_)
        centres = sorted({(round(C[0], 6), round(C[1], 6)) for C, _, _ in pieces.values()})
        pts = {}
        for C, S, E_ in pieces.values():
            for P in (S, E_):
                P = (P[0] + shift, P[1])
                pts.setdefault((round(P[0], 6), round(P[1], 6)), []).append((round(C[0], 6), round(C[1], 6)))
        kinds = {}
        rows = []
        for P, cs in sorted(pts.items()):
            ball = [col(add(P, tuple(3e-4 * c for c in e(TAU * i / 48)))) for i in range(48)]
            cut = sum(b is None for b in ball)
            labs = sorted({b for b in ball if b is not None}, key=str)
            one = sorted(Q for Q in centres if abs(dist(P, Q) - 1.0) < 1e-6)
            iscentre = any(dist(P, Q) < 1e-6 for Q in centres)
            kind = ("on-the-cut" if cut >= 6 else "interior") + f"/labels={len(labs)}/unit-from-{len(one)}-centres" + ("/is-a-centre" if iscentre else "")
            kinds[kind] = kinds.get(kind, 0) + 1
            rows.append((P, kind, labs, one))
        print(f"== {key}: unit-arc-pieces={len(pieces)} centres={len(centres)} distinct-end-points={len(pts)}")
        for k, v in sorted(kinds.items()): print(f"   {v:3d}  {k}")
        for P, kind, labs, one in rows[:400]:
            if "interior" in kind: print(f"      end ({P[0]:.4f},{P[1]:.4f}) {kind} labels={labs} one-unit-from={one}")
        if FAULT and not any("unit-from-0" in k for k in kinds): rc = 0
        if FAULT and all("unit-from-0" in k or "on-the-cut" in k for k in kinds): rc = 1
    print("ends: " + ("OK" if rc == 0 else "FAULT-SEEN"))
    return rc


def rhombi():
    """close complementary pairs among the three-label ends of the unit arcs: for each pair (x, y) with complementary label triples
    and 0 < |x - y| < 2, its two common unit points w: is w a centre of unit arcs; which labels are present at w; and, read on the
    unit circle about w just before and just after x (and y), whether an edge at x (at y) lies on that circle (inside|outside labels).
    --fault exchanges two labels of every triple's complement test (pairs must then vanish)."""
    done = set(); rc = 0
    for lab, TF, col, p in load_maps():
        key = lab.split()[0]
        if key in done: continue
        done.add(key)
        pieces = {}
        for nm, (c, ps) in TF.items():
            for pc in ps:
                if pc[0] == "A" and abs(pc[2] - 1) < 1e-12:
                    _, C, rho, S, E_ = pc
                    pieces[(round(S[0], 6), round(S[1], 6), round(E_[0], 6), round(E_[1], 6), round(C[0], 6), round(C[1], 6))] = (C, S, E_)
        centres = sorted({(round(C[0], 6), round(C[1], 6)) for C, _, _ in pieces.values()})
        alll = sorted({c for c, _ in TF.values()}, key=str)
        pts = {}
        for C, S, E_ in pieces.values():
            for P in (S, E_):
                P = (round(P[0], 6), round(P[1], 6))
                ball = [col(add(P, tuple(3e-4 * c for c in e(TAU * i / 48)))) for i in range(48)]
                if None in ball: continue
                labs = frozenset(ball)
                if len(labs) == 3: pts[P] = labs
        npair = both = one = zero = 0; pat = {}; wl = {}; ends_in_pair = set(); match_ok = match_n = 0
        P = sorted(pts)
        for i in range(len(P)):
            for j in range(i + 1, len(P)):
                x, y = P[i], P[j]
                comp = (pts[x] | pts[y]) == frozenset(alll) and not (pts[x] & pts[y])
                if FAULT: comp = len(pts[x] & pts[y]) == 3
                d = dist(x, y)
                if not comp or not (1e-9 < d < 2 - 1e-9): continue
                npair += 1; ends_in_pair.update((x, y))
                m = ((x[0] + y[0]) / 2, (x[1] + y[1]) / 2); h = math.sqrt(1 - d * d / 4); n = ((y[1] - x[1]) / d, -(y[0] - x[0]) / d)
                saved = 0
                for sg in (1, -1):
                    w = (m[0] + sg * h * n[0], m[1] + sg * h * n[1])
                    isc = any(dist(w, Q) < 1e-6 for Q in centres)
                    if not isc: continue
                    saved += 1
                    wl_ = frozenset(b for b in [col(add(w, tuple(3e-4 * c for c in e(TAU * k / 48)))) for k in range(48)] if b is not None)
                    on = []
                    for z in (x, y):
                        th = math.atan2(z[1] - w[1], z[0] - w[0])
                        for dl in (-0.02, 0.02):
                            pr = TC.tight_at(col, w, th + dl, t=(1e-5, 3e-5), jit=(-2e-3, 0.0, 2e-3))
                            if pr is not None and pr[0] in pts[z] and pr[1] in pts[z]: on.append((z is x, frozenset(pr)))
                    nx = len({pr for isx, pr in on if isx}); ny = len({pr for isx, pr in on if not isx})
                    pat[(nx, ny)] = pat.get((nx, ny), 0) + 1
                    if nx == 1 and ny == 1:
                        ex = next(pr for isx, pr in on if isx); ey = next(pr for isx, pr in on if not isx)
                        match_n += 1
                        match_ok += (wl_ == (ex | ey)) and ((pts[x] - ex) | (pts[y] - ey)) == (frozenset(alll) - wl_)
                both += saved == 2; one += saved == 1; zero += saved == 0
        print(f"== {key}: three-label-ends={len(pts)} close-complementary-pairs={npair} ends-in-some-pair={len(ends_in_pair)} "
              f"pairs-with-both-common-unit-points-centres={both} with-one={one} with-none={zero}")
        print("   at a common unit point that is a centre, (edges of x, edges of y) lying on its unit circle: " + " ".join(f"{k}:{v}" for k, v in sorted(pat.items())))
        print(f"   with one edge of each: labels-at-the-centre = the-four-labels-of-the-two-edges and absent-pair = the-two-third-labels in {match_ok} of {match_n}")
        if FAULT and npair: rc = 1
    print("rhombi: " + ("OK" if rc == 0 else "FAULT-SEEN"))
    return rc


if __name__ == "__main__":
    cmd = next((a for a in sys.argv[1:] if not a.startswith("--")), None)
    fn = {"r7": r7, "maps": maps, "ends": ends, "rhombi": rhombi}.get(cmd)
    if fn is None: print(__doc__); sys.exit(2)
    sys.exit(fn())

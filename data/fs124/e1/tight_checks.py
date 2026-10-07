#!/usr/bin/env python3
"""FS124-E1 controls (plans/FS124-E1-derivation.md).  One subcommand per control; each prints ONE line; --fault plants one fault.

  radius    C124-RADIUS-GRAPH: random rigid motions of the Moser spindle into a disc under the hexagonal seven-colouring at
            circumradius 2/5 — monochromatic unit pairs; fault: circumradius 3/5 (tiles of diameter 6/5, not a weak colouring).
  geometry  C124-CENTRE / -STRADDLE / -ANTIPODE as predicates on circles (no colouring): for sampled points p' near q, near eleven
            points one unit from z, and near 2z - q, whether S(p') meets each collar, against the claims; fault: an arc of radius 0.9.
  r7        the tight seven-colouring R7 by formula at a lattice point: its tight windows, C124-CENTRE, C124-COMPLETION,
            C124-ANTIPODE on them, and which points centre tight arcs (ends against completions); fault: ups coloured by n mod 2.
  hexhalf   the hexagonal seven-colouring at circumradius 1/2: tight directions on a vertex's ring (must be 0); fault: R7's ring.
  maps      the held six-coloured maps (FS-112's strip and disk, via tools/fs116_n1_ring.objects()): every unit-arc piece read from
            the tiles as a tight pair; C124-CENTRE at its centre, C124-COMPLETION at its completions; fault: the tile at one
            completion recoloured with the pair's inside label, and the centre read with the two labels exchanged.
  kind      C124-KIND: the capped honeycomb's margins in exact arithmetic, and the tight pair read by formula; fault: circumradius 1/2.
  cones     C124-SIX-CONES: the angles left to a label by three tight pairs 120 degrees apart, all sign patterns; fault: 90 degrees apart.
  half      C124-HALF: the side patterns of x's two other sets against the labels left in the two quadrants outside S(y);
            fault: only one of y's sets with a point strictly inside S(w).
"""
import math, os, random, sys
from fractions import Fraction as Fr
FAULT = "--fault" in sys.argv
TAU = 2 * math.pi
R3 = math.sqrt(3.0)


def e(t): return (math.cos(t), math.sin(t))
def add(p, q): return (p[0] + q[0], p[1] + q[1])
def sub(p, q): return (p[0] - q[0], p[1] - q[1])
def dist(p, q): return math.hypot(p[0] - q[0], p[1] - q[1])
def rot(v, t): c, s = math.cos(t), math.sin(t); return (c * v[0] - s * v[1], s * v[0] + c * v[1])


# ---------- the hexagonal seven-colouring (pointy-top hexagons, circumradius r; colour (m + 3n) mod 7) ----------
def hexcell(p, r):
    a1, a2 = (R3 * r, 0.0), (R3 * r / 2, 1.5 * r)
    n = p[1] / (1.5 * r); m = (p[0] - n * R3 * r / 2) / (R3 * r)
    best = None
    for mm in (math.floor(m) - 1, math.floor(m), math.floor(m) + 1, math.floor(m) + 2):
        for nn in (math.floor(n) - 1, math.floor(n), math.floor(n) + 1, math.floor(n) + 2):
            c = (mm * a1[0] + nn * a2[0], mm * a1[1] + nn * a2[1])
            d = dist(p, c)
            if best is None or d < best[0]: best = (d, mm, nn)
    return best[1], best[2]


def hexcol(p, r):
    m, n = hexcell(p, r)
    return (m + 3 * n) % 7


# ---------- R7 (plans/FS111-M-regularity.md § 2.4, as tools/fs121_db1_r7cones.py states it) ----------
def cart(a, b): return (a + b / 2.0, b * R3 / 2.0)


def r7col(p, plant=False):
    b = p[1] / (R3 / 2.0); a = p[0] - b / 2.0
    m0, n0 = math.floor(a), math.floor(b)
    for m in (m0 - 1, m0, m0 + 1):
        for n in (n0 - 1, n0, n0 + 1):
            if all(dist(p, cart(*v)) <= 1.0 for v in ((m, n), (m + 1, n), (m, n + 1))):
                return (n % 2) if plant else 2 * (m % 2) + (n % 2)
    fa, fb = a - m0, b - n0            # a point in no Reuleaux triangle lies in the down triangle of its lattice cell
    return 4 + ((m0 - n0) % 3)


# ---------- generic readings on a colouring given by a function col(point) -> label or None ----------
def tight_at(col, q, th, t=(1e-6, 3e-6), jit=(-1e-2, -5e-3, 0.0, 5e-3, 1e-2)):
    """tight for (a, b) at direction th, read at radial offsets t (small: a cusp of width phi^2 at angle phi from an arc's end must not
    hide the outside label) over an angular spread jit much wider than t (a boundary merely crossing the ring must not read as tight)."""
    ins = {col(add(q, tuple((1 - s) * c for c in e(th + j)))) for s in t for j in jit}
    out = {col(add(q, tuple((1 + s) * c for c in e(th + j)))) for s in t for j in jit}
    if len(ins) == 1 and len(out) == 1 and None not in ins and None not in out and ins != out:
        return (ins.pop(), out.pop())
    return None


def windows(col, q, n=720):
    """maximal runs of tight directions on S(q), read at n directions offset by half a step; returns [(start_deg, end_deg, (a, b))]."""
    seq = [tight_at(col, q, TAU * (i + 0.5) / n) for i in range(n)]
    if all(s is None for s in seq): return []
    if all(s == seq[0] for s in seq): return [(0.0, 360.0, seq[0])]
    i0 = next(i for i in range(n) if seq[i] != seq[i - 1])
    out, cur, start = [], seq[i0], i0
    for k in range(1, n + 1):
        i = (i0 + k) % n
        if seq[i] != cur:
            if cur is not None: out.append((round(360.0 * start / n, 1), round(360.0 * ((i0 + k) / n), 1) % 360.0 or 360.0, cur))
            cur, start = seq[i], (i0 + k) % n
    return out


def centre_read(col, q, z, a, b, radii=(2e-4, 5e-4, 1e-3), n=360):
    """samples near q: (samples with a label, with label a, with label b, violations of C124-CENTRE)."""
    seen = na = nb = bad = 0
    for r in radii:
        for i in range(n):
            w = add(q, tuple(r * c for c in e(TAU * i / n)))
            c = col(w)
            if c is None: continue
            seen += 1; d = dist(w, z)
            if c == a: na += 1; bad += d > 1 + 1e-12
            if c == b: nb += 1; bad += d < 1 - 1e-12
    return seen, na, nb, bad


def ball_read(col, p, r=3e-4, n=24):
    labs = [col(p)] + [col(add(p, tuple(rr * c for c in e(TAU * i / n)))) for rr in (r / 3, r) for i in range(n)]
    return [c for c in labs if c is not None]


# ---------- radius ----------
def radius():
    r = 0.6 if FAULT else 0.4
    d = 2 * math.asin(1 / (2 * R3)); t1, t2 = 0.3, 0.3 + d
    O = (0.0, 0.0)
    A, B, A2, B2 = e(t1), e(t1 + TAU / 6), e(t2), e(t2 + TAU / 6)
    C, C2 = add(A, B), add(A2, B2)
    V = [O, A, B, C, A2, B2, C2]
    E = [(0, 1), (0, 2), (1, 2), (1, 3), (2, 3), (0, 4), (0, 5), (4, 5), (4, 6), (5, 6), (3, 6)]
    assert all(abs(dist(V[i], V[j]) - 1) < 1e-12 for i, j in E)
    rng = random.Random(124); R = 2.0; motions = mono = 0
    while motions < 20000:
        ph = rng.uniform(0, TAU); t = (rng.uniform(-R, R), rng.uniform(-R, R))
        W = [add(rot(v, ph), t) for v in V]
        if any(math.hypot(*w) >= R for w in W): continue
        motions += 1
        cs = [hexcol(w, r) for w in W]
        mono += sum(cs[i] == cs[j] for i, j in E)
    print(f"circumradius={r} disc-radius={R} motions={motions} unit-pairs-per-motion={len(E)} monochromatic-pairs={mono}")


# ---------- geometry ----------
def geometry():
    r0 = 0.9 if FAULT else 1.0                 # the radius of the interface arc about q
    q, z, rho = (0.0, 0.0), (r0, 0.0), 0.05
    def arcs(p):
        d = dist(p, z); cz = (1 + d * d - rho * rho) / (2 * d)
        hz = 0.0 if cz >= 1 else (math.pi if cz <= -1 else math.acos(cz))
        D = dist(p, q); cq = (1 + D * D - r0 * r0) / (2 * D)
        hq = 0.0 if cq >= 1 else (math.pi if cq <= -1 else math.acos(cq))
        tz = math.atan2(z[1] - p[1], z[0] - p[0]); tq = math.atan2(q[1] - p[1], q[0] - p[0])
        dl = abs((tz - tq + math.pi) % TAU - math.pi)
        Pa = hz > 0 and hq > 0 and dl < hz + hq             # S(p) meets the inner collar
        Pb = hz > 0 and not (hq > 0 and dl + hz <= hq)      # S(p) meets the outer collar
        return Pa, Pb
    rng = random.Random(7); bad = 0; counts = {}
    def ball(c, eta, k=4000):
        for _ in range(k):
            rr, tt = eta * math.sqrt(rng.random()), rng.uniform(0, TAU)
            yield add(c, (rr * math.cos(tt), rr * math.sin(tt)))
    n = m = 0
    for p in ball(q, 2e-3):                    # C124-CENTRE
        Pa, Pb = arcs(p); d = dist(p, z)
        if d > 1: n += 1; bad += not Pa
        if d < 1: m += 1; bad += not Pb
    counts["centre"] = (n, m)
    n = 0
    for deg in (10, 30, 60, 90, 120, 150, 170, 190, 240, 300, 350):   # C124-STRADDLE; 120 and 240 are the completions
        c = add(z, e(math.radians(deg)))
        for p in ball(c, 1e-4, 1000):
            Pa, Pb = arcs(p); n += 1; bad += not (Pa and Pb)
    counts["straddle"] = (n,)
    n = m = 0
    for p in ball(sub((2 * z[0], 2 * z[1]), q), 2e-3):   # C124-ANTIPODE
        Pa, Pb = arcs(p); n += 1; bad += not Pb
        if dist(p, q) < 2 * r0: m += 1; bad += not Pa
    counts["antipode"] = (n, m)
    print(f"arc-radius={r0} centre-samples-far,near={counts['centre'][0]},{counts['centre'][1]} straddle-samples={counts['straddle'][0]} "
          f"antipode-samples,inside-radius-2={counts['antipode'][0]},{counts['antipode'][1]} disagreements={bad}")


# ---------- r7 ----------
def r7():
    col = lambda p: r7col(p, FAULT)
    v = (0.0, 0.0)
    W = windows(col, v)
    cs = ca = cb = cbad = 0; comp_labels = set(); comp_bad = 0; anti_bad = 0; anti_n = 0
    # the cusp of the outside label lies on one direction: read the centre on rays too
    for (s, t, (a, b)) in W:
        for th in [math.radians(s + (t - s) * f) for f in (0.2, 0.5, 0.8)]:
            z = add(v, e(th))
            x = centre_read(col, v, z, a, b); cs += x[0]; ca += x[1]; cb += x[2]; cbad += x[3]
            for sg in (1, -1):
                L = ball_read(col, add(v, e(th + sg * TAU / 6))); comp_labels |= set(L); comp_bad += sum(c in (a, b) for c in L)
            p = add(v, tuple(2 * c for c in e(th)))
            for i in range(120):
                w = add(p, tuple(3e-4 * c for c in e(TAU * i / 120))); c = col(w); anti_n += 1
                anti_bad += (c == b) or (c == a and dist(w, v) < 2 - 1e-12)
    ends = [cart(1, 0), cart(0, 1), cart(-1, 1), cart(-1, 0), cart(0, -1), cart(1, -1)]
    ends_centring = sum(1 for p in ends if windows(col, p))
    comps = [add(v, e(math.radians(d))) for d in (80, 90, 105, -40, -30, -15)]
    comps_centring = sum(1 for p in comps if windows(col, p))
    wtxt = " ".join(f"({s:g},{t:g}):{a}|{b}" for s, t, (a, b) in W)
    print(f"windows={len(W)} {wtxt} centre-samples={cs} with-inside-label={ca} with-outside-label={cb} centre-violations={cbad} "
          f"completion-labels={sorted(comp_labels)} completion-violations={comp_bad} antipode-samples={anti_n} antipode-violations={anti_bad} "
          f"ends-centring-tight-arcs={ends_centring}/6 completions-centring-tight-arcs={comps_centring}/6")


# ---------- hexhalf ----------
def hexhalf():
    if FAULT:
        n = sum(1 for i in range(720) if tight_at(r7col, (0.0, 0.0), TAU * (i + 0.5) / 720))
        print(f"colouring=R7 point=lattice ring-directions=720 tight-directions={n}"); return
    r = 0.5; x = (R3 * r / 2, r / 2)          # a vertex of the hexagon about the origin
    col = lambda p: hexcol(p, r)
    labs = sorted(set(ball_read(col, x, 1e-3)))
    on_ring = sum(1 for k in range(6) if len(set(ball_read(col, add(x, e(math.radians(30 + 60 * k))), 1e-3))) == 3)
    n = sum(1 for i in range(720) if tight_at(col, x, TAU * (i + 0.5) / 720))
    print(f"colouring=hex7 circumradius={r} labels-at-vertex={len(labs)} three-label-points-on-its-ring={on_ring} ring-directions=720 tight-directions={n}")


# ---------- maps ----------
def maps():
    root = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", ".."))
    sys.path.insert(0, os.path.join(root, "tools"))
    import fs116_n3_semi as N3
    RG = N3.RG
    done = set(); out = []
    for lab, T, _ in RG.objects():
        key = lab.split()[0]
        if key in done: continue
        done.add(key)
        TF = RG.fl_tiles(T)
        def col(p, TF=TF):
            ts = N3.locate2(TF, p)
            return TF[ts[0]][0] if len(ts) == 1 else None
        arcs = {}
        for nm, (c, ps) in TF.items():
            for pc in ps:
                if pc[0] == "A" and abs(pc[2] - 1) < 1e-12:
                    _, C, rho, S, E_ = pc
                    a0 = math.atan2(S[1] - C[1], S[0] - C[0]); sp = (math.atan2(E_[1] - C[1], E_[0] - C[0]) - a0) % TAU
                    if sp > math.pi: a0, sp = a0 + sp, TAU - sp      # the piece is the short arc between its ends
                    arcs[(round(C[0], 7), round(C[1], 7), round(a0 + sp / 2, 5) % round(TAU, 5))] = (C, a0 + sp / 2)
        tight = cov = both = sa = sb = cbad = ccov = csamp = cmpbad = 0; first = None; fbad = fcen = 0
        for (C, th) in arcs.values():
            pr = tight_at(col, C, th, t=(1e-5, 3e-5), jit=(-2e-3, 0.0, 2e-3))
            if pr is None: continue
            tight += 1; a, b = pr; z = add(C, e(th))
            x = centre_read(col, C, z, a, b, radii=(2e-4, 5e-4), n=72)
            if x[0]: cov += 1; both += (x[1] > 0 and x[2] > 0); sa += x[1]; sb += x[2]; cbad += x[3]
            if FAULT and x[0]: fcen += centre_read(col, C, z, b, a, radii=(2e-4, 5e-4), n=72)[3]
            for sg in (1, -1):
                w = add(C, e(th + sg * TAU / 6)); L = ball_read(col, w, 2e-4, 12)
                if L:
                    ccov += 1; csamp += len(L); cmpbad += sum(c in (a, b) for c in L)
                    if first is None: first = (w, a, b)
        if FAULT and first is not None:
            w, a, b = first; nm = N3.locate2(TF, w)[0]
            TF2 = dict(TF); TF2[nm] = (a, TF[nm][1])
            col2 = lambda p: (lambda ts: TF2[ts[0]][0] if len(ts) == 1 else None)(N3.locate2(TF2, p))
            fbad = sum(c in (a, b) for c in ball_read(col2, w, 2e-4, 12))
        s = (f"{key}: unit-arcs={len(arcs)} tight={tight} centres-in-fragment={cov} of-kind-both={both} centre-samples-inside-label,outside-label={sa},{sb} "
             f"centre-violations={cbad} completions-in-fragment={ccov} completion-samples={csamp} completion-violations={cmpbad}")
        if FAULT: s += f" planted:completion-violations={fbad} planted:centre-violations={fcen}"
        out.append(s)
    print(" ; ".join(out))


# ---------- kind ----------
def kind_at(r):
    h, s, d = Fr(1, 61), Fr(11, 61), Fr(60, 61)
    assert s * s + d * d == 1 and h == 1 - d
    lo3, hi3 = Fr(17320508, 10 ** 7), Fr(17320509, 10 ** 7); assert lo3 * lo3 < 3 < hi3 * hi3
    cap_in_edge = s < r / 2                               # the cap's chord lies inside the edge (half-length r/2)
    # every hexagon vertex P has q - P pointing away from the cap (x-component < 0: the largest is 2 ap - d), so the distance from P
    # is largest, over the cap, at an end of its chord - a point of the hexagon: the enlarged tile has the hexagon's diameter 2r
    far_at_chord = hi3 * r < d
    diam = 2 * r if (cap_in_edge and far_at_chord) else None
    gap_ok = 21 * r * r > (1 + 2 * r + h) ** 2            # centres of one colour are sqrt(21) r apart: other tiles of the colour > 1 away
    centre_ok = (3 * hi3 * r / 2 - d) < lo3 * r / 2 and (3 * lo3 * r / 2 - d) > -lo3 * r / 2   # q strictly inside the opposite hexagon
    rf = float(r); ap = R3 * rf / 2; q = (ap - float(d), 0.0)
    def col(p):
        if p[0] > ap and dist(p, q) < 1.0 and abs(p[1]) < float(s) + 1e-9: return 0
        return hexcol(p, rf)
    pr = tight_at(col, q, 0.0)
    ntight = sum(1 for i in range(3600) if tight_at(col, q, TAU * (i + 0.5) / 3600))
    at_q = sorted(set(ball_read(col, q, 1e-3)))
    comp = sorted(set(ball_read(col, add(q, e(TAU / 6)), 1e-3)) | set(ball_read(col, add(q, e(-TAU / 6)), 1e-3)))
    rng = random.Random(61); mono = pairs = 0
    while pairs < 200000:
        pt = (rng.uniform(-1.2, 1.6), rng.uniform(-1.2, 1.2)); w = add(pt, e(rng.uniform(0, TAU)))
        pairs += 1; mono += col(pt) == col(w)
    return (f"circumradius={r}: cap-inside-edge={cap_in_edge} enlarged-tile-diameter={diam} weakly-proper-by-margins={diam is not None and diam <= 1 and gap_ok} "
            f"centre-inside-opposite-tile={centre_ok} tight-pair={pr} tight-directions={ntight}/3600 labels-at-centre={at_q} labels-at-completions={comp} "
            f"monochromatic-of-{pairs}-unit-pairs={mono}")


def kind():
    print("cap:height=1/61,half-chord=11/61(2*asin=20.78deg) ; " + (kind_at(Fr(3, 5)) if FAULT else kind_at(Fr(2, 5)) + " ; " + kind_at(Fr(1, 2))))


# ---------- cones ----------
def cones():
    step = math.radians(90 if FAULT else 120)
    grid = [math.radians(0.05 + 0.1 * i) for i in range(3600)]
    def width(signs, t=1e-4):   # degrees of directions phi with q + t e(phi) in the region of the inside label
        n = 0
        for ph in grid:
            w = (t * math.cos(ph), t * math.sin(ph)); ok = True
            for j, sg in enumerate(signs):
                dz = dist(w, e(j * step))
                ok = ok and (dz <= 1 if sg else dz >= 1)
            n += ok
        return round(n * 0.1)
    widths = {sg: width(sg) for sg in [(a, b, c) for a in (1, 0) for b in (1, 0) for c in (1, 0)]}
    agree = [widths[(1, 1, 1)], widths[(0, 0, 0)]]
    mixed = sorted({w for sg, w in widths.items() if len(set(sg)) == 2})
    most = 4 * max(widths.values())
    print(f"angle-between-far-ends={round(math.degrees(step))} equal-signs={agree} mixed-signs-widths={mixed} most-covered-by-two-pairs={most} of 360")


# ---------- half ----------
def half():
    T = ("t0", "t1", "t2"); labels_out_y = set() if not FAULT else {"t'2"}   # labels of y left outside S(y) near w
    pats = []
    for s1 in ("in", "out", "both"):
        for s2 in ("in", "out", "both"):
            excl = {"in-x": set(), "out-x": set()}
            for side, labs in ((s1, {"t1", "t2"}), (s2, {"t2", "t0"})):
                if side in ("in", "both"): excl["out-x"] |= labs      # a point strictly inside S(w) excludes outside S(x) near w
                if side in ("out", "both"): excl["in-x"] |= labs
            left = {k: (set(T) - v) | labels_out_y for k, v in excl.items()}
            if all(left.values()): pats.append((s1, s2, tuple(sorted(left["in-x"])), tuple(sorted(left["out-x"]))))
    print(f"side-patterns=9 consistent={len(pats)} " + " ".join(f"K1={a},K2={b}:inside-x={','.join(c)};outside-x={','.join(d)}" for a, b, c, d in pats))


# ---------- ends ----------
def ends():
    """the held maps: for every boundary piece of radius 1, are its two end points themselves centres of boundary pieces of radius 1?"""
    root = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", ".."))
    sys.path.insert(0, os.path.join(root, "tools"))
    import fs116_n3_semi as N3
    RG = N3.RG; done = set(); out = []
    shift = 0.01 if FAULT else 0.0
    for lab, T, _ in RG.objects():
        key = lab.split()[0]
        if key in done: continue
        done.add(key); TF = RG.fl_tiles(T)
        pieces = {}
        for nm, (c, ps) in TF.items():
            for pc in ps:
                if pc[0] == "A" and abs(pc[2] - 1) < 1e-12:
                    _, C, rho, S, E_ = pc
                    k = tuple(sorted([(round(S[0], 6), round(S[1], 6)), (round(E_[0], 6), round(E_[1], 6))])) + (round(C[0], 6), round(C[1], 6))
                    pieces[k] = (C, S, E_)
        centres = [C for C, _, _ in pieces.values()]
        n = hit = 0
        for C, S, E_ in pieces.values():
            for P in (S, E_):
                n += 1; hit += any(dist((P[0] + shift, P[1]), Q) < 1e-6 for Q in centres)
        out.append(f"{key}: unit-arc-pieces={len(pieces)} ends={n} ends-that-centre-a-unit-arc={hit}")
    print(" ; ".join(out))


if __name__ == "__main__":
    cmd = next((a for a in sys.argv[1:] if not a.startswith("--")), None)
    fn = {"radius": radius, "geometry": geometry, "r7": r7, "hexhalf": hexhalf, "maps": maps, "kind": kind, "cones": cones, "half": half, "ends": ends}.get(cmd)
    if fn is None: print(__doc__); sys.exit(2)
    fn()

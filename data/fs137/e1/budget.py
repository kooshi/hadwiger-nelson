#!/usr/bin/env python3
"""FS137-E1 — the controls of the six claims C137-BUDGET, -THREE, -SIXTY, -OWN, -MEET, -RING.  EXACT classes.

  python3 data/fs137/e1/budget.py scan   [--fault=cross]   C137-BUDGET: the scan of whole unit circles, summed
  python3 data/fs137/e1/budget.py repeat                   C137-BUDGET: two fans by formula (a repeated label; a reflex corner)
  python3 data/fs137/e1/budget.py three  [--fault=bend]    C137-THREE: every vertex of the held objects, every direction
  python3 data/fs137/e1/budget.py forced [--fault=bar]     C137-SIXTY, C137-OWN: the sets N_in, N_out of every label at rich vertices
  python3 data/fs137/e1/budget.py meet   [--fault=bar]     C137-MEET: R7's 432 cells, the alternative that saves each
  python3 data/fs137/e1/budget.py ring   [--fault=cross]   C137-RING: every unit pair of vertices of R7 and of the held objects

ENGINE.  data/fs137/e1/engine.py is data/fs136/e2/closure.py copied unchanged (FS136-E2's; `cmp` identical): its towers, its
curves and corners, its classifier klass_exact (C136-CLASS) and its loaders are used as they are.  Added here: the scan of a
whole unit circle at EVERY vertex (the engine scans only vertices with k - 1 labels), the count of crossing corners, the sets
N_in / N_out, and the reading of a pair of vertices one unit apart.  Nothing is searched: every number is a reading of corners
somebody keeps.  A direction is read once per open arc between critical directions (an edge direction turned by a quarter) and
once at each critical direction; on an arc every class is constant (C137-BUDGET's argument), so the scan is the whole circle.
FLOATS are used for the lengths of arcs (printed), to locate vertices, and in the control `fl` (each class re-read by sampling).
FAULTS.  cross: the first corner at each vertex is read as crossing wherever it is inner.  bend: the engine's (curves ordered by
direction only).  bar: the engine's planted bar (first corner of the first family read as crossing wherever inner).
"""
import sys, os, math, functools
HERE = os.path.dirname(os.path.abspath(__file__))
MODE = [a for a in sys.argv[1:] if not a.startswith("--")]
MYOPT = {a[2:].split("=")[0]: (a.split("=", 1)[1] if "=" in a else True) for a in sys.argv[1:] if a.startswith("--")}
MYFAULT = MYOPT.get("fault")
sys.path.insert(0, HERE)
sys.argv = [sys.argv[0]] + (["--fault=" + MYFAULT] if MYFAULT in ("bend", "bar") else [])
import engine as E
from fractions import Fraction as Fr
K = E.K
TAU = 2 * math.pi


# ------------------------------------------------------------------------------------------------ objects, with their vertices
def load(name):
    """the engine's object, and the list of its exact vertices (end points of boundary pieces)."""
    if name == "r7":
        ob = E.obj_r7(-3, 4)
        ob["verts"] = [ob["L"](m, n) for m in range(-1, 3) for n in range(-1, 3)]
        return ob
    cap = {}
    o1, o2 = E.conv_native, E.top_tower
    def cn(nat):
        T = o1(nat); cap["pts"] = [v for c, ps in T.values() for pc in ps for v in (pc.P, pc.Q)]; return T
    def tt(tiles):
        cap["pts"] = [v for t in tiles for pc in t.pieces for v in (pc.P, pc.Q)]; return o2(tiles)
    E.conv_native, E.top_tower = cn, tt
    try: ob = E.obj_tiles(name)
    finally: E.conv_native, E.top_tower = o1, o2
    reg = E.Pts(); seen = []
    for p in cap["pts"]:
        i = reg.id(p)
        if i == len(seen): seen.append(reg.P[i])
    ob["verts"] = seen
    return ob


def corners(ob, v):
    try: return ob["corners"](v)
    except AssertionError: return None, False


# ------------------------------------------------------------------------------------------------ directions
def rot(d, co, si): return (d[0] * co - d[1] * si, d[0] * si + d[1] * co)
def ray(d): return E.Curve(d, 0)
def deg(d): return math.degrees(math.atan2(float(d[1]), float(d[0]))) % 360


def critical(fam):
    cs = []
    for g in fam:
        for cv in (g.lo, g.hi):
            for e in ((-cv.d[1], cv.d[0]), (cv.d[1], -cv.d[0])):
                c = ray(e)
                if not any(E.cmp_dir(c, o) == 0 for o in cs): cs.append(c)
    cs.sort(key=functools.cmp_to_key(E.cmp_dir))
    return cs


def components(fam):
    """the whole circle of directions: ('arc', sample e, lo, hi, length in degrees) for each open arc between critical directions,
    and ('point', e, e, e, 0) for each critical direction."""
    cs = critical(fam); out = []
    for j, c1 in enumerate(cs):
        c2 = cs[(j + 1) % len(cs)]
        for k in range(1, 60):
            u = Fr(1, 2 ** k); co, si = (1 - u * u) / (1 + u * u), 2 * u / (1 + u * u)
            e = rot(c1.d, co, si); ce = ray(e)
            if E.cmp_dir(c1, ce) != 0 and (len(cs) == 1 or E.cle(c1, ce, c2, E.cmp_dir, True)): break
        ln = (deg(c2.d) - deg(c1.d)) % 360 if len(cs) > 1 else 360.0
        out.append(("arc", e, c1.d, c2.d, ln))
    for c1 in cs: out.append(("point", c1.d, c1.d, c1.d, 0.0))
    return out


NCLS = [0, 0]
def klass(g, x, e, first=None):
    """the class of the corner g at x in the direction e (C136-CLASS), exact; counted against a float re-read."""
    c = E.klass_exact(g.lo, g.hi, x, E.add(x, e))
    xf = E.fl(x); n = math.hypot(float(e[0]), float(e[1])); wf = (xf[0] + float(e[0]) / n, xf[1] + float(e[1]) / n)
    v = [(q[0] - wf[0]) ** 2 + (q[1] - wf[1]) ** 2 - 1 for q in E.samples(g.lo, g.hi, x)]
    f = "inner" if all(a < 1e-12 for a in v) else ("outer" if all(a > -1e-12 for a in v) else "crossing")
    NCLS[0] += 1; NCLS[1] += c != f
    if MYFAULT == "cross" and g is first and c == "inner": c = "crossing"
    return c


def angle_class(g):
    """'cusp', 'lt' (less than 180), 'eq' (180), 'gt' (more than 180), by exact signs."""
    cr, dt = E.crs(g.lo.d, g.hi.d).sign(), E.dot(g.lo.d, g.hi.d).sign()
    if cr > 0: return "lt"
    if cr < 0: return "gt"
    if dt < 0: return "eq"
    return "cusp" if E.cmp_curve(g.lo, g.hi) < 0 else "gt"


def along(cv, x, e):
    """does the curve cv from x lie along the unit circle about x + e/|e| ?  (a unit arc whose centre is in the direction e)"""
    if cv.s == 0 or cv.c is None or (cv.r2 - 1).sign() != 0: return False
    r = E.sub(cv.c, x)
    return E.crs(r, e).sign() == 0 and E.dot(r, e).sign() > 0


def edges_of(fam):
    out = []
    for g in fam:
        if not any(E.cmp_curve(g.lo, o) == 0 for o in out): out.append(g.lo)
    return out


def pure(fam, cls):
    inn, out = set(), set()
    for lab in {g.label for g in fam}:
        ks = {cls[id(g)] for g in fam if g.label == lab}
        if ks == {"inner"}: inn.add(lab)
        if ks == {"outer"}: out.add(lab)
    return inn, out


def rich(ob, least):
    for v in ob["verts"]:
        fam, full = corners(ob, v)
        if fam and full and len({g.label for g in fam}) >= least: yield v, fam


# ------------------------------------------------------------------------------------------------ C137-BUDGET
def scan_vertex(x, fam):
    c = len(fam); labs = {g.label for g in fam}; m = len(labs); one = (c == m)
    acls = [angle_class(g) for g in fam]; flat = all(a in ("cusp", "lt", "eq") for a in acls)
    win = 0.0; bad = 0; narc = 0; purecounts = set(); anti = 0
    for kind, e, lo, hi, ln in components(fam):
        if kind != "arc": continue
        narc += 1
        cls = {id(g): klass(g, x, e, fam[0]) for g in fam}; ncr = sum(v == "crossing" for v in cls.values())
        inn, out = pure(fam, cls); win += ln * len(inn); purecounts.add(len(inn) + len(out))
        opp = {id(g): klass(g, x, (-e[0], -e[1])) for g in fam}
        anti += any((cls[id(g)] == "inner") != (opp[id(g)] == "outer") for g in fam) and MYFAULT != "cross"
        if flat: bad += (ncr != 2) + (len(inn) + len(out) > c - 2) + (one and len(inn) + len(out) != m - 2)
        else: bad += ncr not in (1, 2)
    return dict(c=c, m=m, one=one, flat=flat, win=win, bad=bad, arcs=narc, pure=purecounts, anti=anti)


def scan():
    for name, least, pick in (("r7", 1, lambda ob: ob["verts"][5:6]), ("bowtie", 5, None), ("flower", 6, None), ("strip", 3, None), ("disk", 3, None)):
        ob = load(name); k = len(ob["labels"]); rows = []
        vs = [(v, corners(ob, v)[0]) for v in pick(ob)] if pick else list(rich(ob, least))
        for x, fam in vs: rows.append(scan_vertex(x, fam))
        flat = [r for r in rows if r["flat"]]; one = [r for r in flat if r["one"]]
        sums = sorted({round(r["win"], 6) for r in rows}); means = sorted({round(k - r["m"] + r["win"] / 360, 6) for r in one})
        print(f"{name}: k={k} vertices={len(rows)} (labels>={least}) arcs={sum(r['arcs'] for r in rows)} violations={sum(r['bad'] for r in rows)} antipode-mismatches={sum(r['anti'] for r in rows)} | "
              f"one-corner-per-label={len(one)} pure-per-arc-minus-(m-2)={sorted({p - r['m'] + 2 for r in one for p in r['pure']})} | windows-sum-minus-180(c-2)={sorted({round(r['win'] - 180 * (r['c'] - 2), 6) for r in flat})} | "
              f"windows-sums={sums[:4]}{'...' if len(sums) > 4 else ''} mean-palette(one-corner)={means[:4]} | fl={NCLS[0]} mismatches={NCLS[1]}")
    return 0


def fan(dirs, labels):
    """a fan of straight sectors at the origin: rays in the directions dirs (counter-clockwise), sector i from ray i to ray i+1."""
    E.F.T = K.Tower.base(); rs = [E.Curve((E.F.T(a), E.F.T(b)), 0) for a, b in dirs]
    return (E.F.T(0), E.F.T(0)), [E.Corner(l, rs[i], rs[(i + 1) % len(rs)], f"s{i}") for i, l in enumerate(labels)]


def repeat():
    for nm, dirs, labels in (("a,c,b,c (c twice)", [(1, 0), (12, 5), (-1, 0), (-12, -5)], "acbc"),
                              ("reflex (270, 45, 45 degrees)", [(1, 0), (1, 1), (0, 1)], "abc"),
                              ("control: four labels, the same four rays", [(1, 0), (12, 5), (-1, 0), (-12, -5)], "abcd")):
        x, fam = fan(dirs, labels); r = scan_vertex(x, fam)
        print(f"{nm}: corners={r['c']} labels={r['m']} all-angles<=180={r['flat']} windows-sum={r['win']:.4f} 180(c-2)={180 * (r['c'] - 2)} 180(m-2)={180 * (r['m'] - 2)} "
              f"pure-per-arc={sorted(r['pure'])} violations={r['bad']}")
    return 0


# ------------------------------------------------------------------------------------------------ C137-THREE
def three():
    for name in ("strip", "disk", "flower", "bowtie"):
        ob = load(name); nv = nd = sep = sep_along = viol = worse = 0
        for x, fam in rich(ob, 1):
            if len(fam) != 3: continue
            nv += 1; eds = edges_of(fam)
            for kind, e, lo, hi, ln in components(fam):
                nd += 1
                cls = {id(g): klass(g, x, e) for g in fam}; ncr = sum(v == "crossing" for v in cls.values())
                s = sum(1 for cv in eds if along(cv, x, e)); inn, out = pure(fam, cls)
                worse += ncr > 2 - s
                if inn and out:
                    sep += 1; sep_along += s >= 1; viol += s == 0
        print(f"{name}: three-corner vertices={nv} directions read={nd} crossing>2-s:{worse} | directions with an inner-pure and an outer-pure label={sep}, with an edge along the far circle={sep_along}, WITHOUT={viol} | fl={NCLS[0]} mismatches={NCLS[1]}")
    print("r7: no three-corner vertex (every lattice point has six corners) - silent")
    return 0


# ------------------------------------------------------------------------------------------------ C137-SIXTY, C137-OWN
def meets(a, b):
    """do two components of directions (arc: (lo, hi) open; point: lo == hi) share a direction?  exact."""
    (k1, l1, h1), (k2, l2, h2) = a, b; r = lambda d: ray(d)
    if k1 == "point" and k2 == "point": return E.cmp_dir(r(l1), r(l2)) == 0
    if k1 == "point": return meets(b, a)
    inside = lambda d: E.cmp_dir(r(l1), r(d)) != 0 and E.cle(r(l1), r(d), r(h1), E.cmp_dir, True)
    if k2 == "point": return inside(l2)
    if E.cmp_dir(r(l1), r(l2)) == 0: return True
    return inside(l2) or (E.cmp_dir(r(l2), r(l1)) != 0 and E.cle(r(l2), r(l1), r(h2), E.cmp_dir, True))


def forced():
    for name, least in (("bowtie", 5), ("flower", 6), ("r7", 6), ("strip", 4), ("disk", 4)):
        ob = load(name); k = len(ob["labels"]); T = E.F.T; half, r3h = T(Fr(1, 2)), E.tsqrt(T(3)) / 2
        nv = 0; pairs = pairs_in = 0; arcs = []; own_arcs = own_pts = 0; mx = tot = 0.0; lines = []; agree = [0, 0]
        vs = [(v, corners(ob, v)[0]) for v in ob["verts"][5:6]] if name == "r7" else list(rich(ob, least))
        for x, fam in vs:
            nv += 1; labs = {g.label for g in fam}; comp = components(fam); first = fam[0] if E.FAULT == "bar" else None
            cl = [{id(g): (("crossing" if (first is g and c == "inner") else c)) for g in fam for c in [klass(g, x, e)]} for kind, e, lo, hi, ln in comp]
            for lab in sorted(ob["labels"], key=str):
                if not (ob["labels"] - {lab}) <= labs: continue
                N = {}
                for side in ("inner", "outer"):
                    N[side] = [comp[i] for i in range(len(comp)) if all(any(cl[i][id(g)] != side for g in fam if g.label == o) for o in labs - {lab})]
                    la = [c[4] for c in N[side] if c[0] == "arc"]
                    if la: mx = max(mx, max(la)); tot = max(tot, sum(la))
                    if lab in labs: own_arcs += len(la); own_pts += sum(c[0] == "point" for c in N[side])
                    for c in N[side]:                      # float control: the object's own colour just on that side of the arc
                        if c[0] != "arc" or name == "r7": continue
                        a0 = math.radians(deg(c[2])); sp = math.radians(c[4]); rr = 1 - 2e-3 if side == "inner" else 1 + 2e-3
                        for t in range(1, 60):
                            q = (float(x[0]) + rr * math.cos(a0 + sp * t / 60), float(x[1]) + rr * math.sin(a0 + sp * t / 60)); col = ob["col"](q)
                            if col is None: continue
                            agree[0] += 1; agree[1] += col == lab
                    if N[side]: lines.append(f"   {name} at ({float(x[0]):.5f},{float(x[1]):.5f}) labels={len(labs)} label {lab} ({'own' if lab in labs else 'absent'}) {side}: " +
                                             " ".join(f"({deg(c[2]):.1f},{deg(c[3]):.1f})" if c[0] == "arc" else f"[{deg(c[2]):.1f}]" for c in N[side]))
                allc = N["inner"] + N["outer"]
                for a in allc:
                    ra = (a[0], rot(a[2], half, r3h), rot(a[3], half, r3h))
                    for b in allc:
                        if meets(ra, (b[0], b[2], b[3])):
                            pairs += 1
                            e1 = a[1]; n1 = math.hypot(float(e1[0]), float(e1[1])); e2 = rot(e1, half, r3h)
                            w1 = (float(x[0]) + float(e1[0]) / n1, float(x[1]) + float(e1[1]) / n1); w2 = (float(x[0]) + float(e2[0]) / n1, float(x[1]) + float(e2[1]) / n1)
                            ins = lambda w: math.hypot(*w) < 1.5 if name == "flower" else (True if name == "r7" else ob["inU"](w))
                            pairs_in += bool(ins(w1) and ins(w2))
        print(f"{name}: k={k} vertices read={nv} (labels>={least}) | longest arc of one N={mx:.4f} largest total of one N={tot:.4f} | pairs of N-directions 60 apart (one label)={pairs}, with both ring points in the object={pairs_in} | "
              f"own-label: arcs={own_arcs} single directions={own_pts} | the object has the forced label at {agree[1]} of {agree[0]} samples beside the arcs | fl={NCLS[0]} mismatches={NCLS[1]}")
        if MYOPT.get("list"): print("\n".join(lines))
    return 0


# ------------------------------------------------------------------------------------------------ C137-MEET
def meet():
    ob = E.obj_r7(-4, 5); tiles = ob["tiles"]; L = ob["L"]
    W = [(m, n) for m in range(-1, 3) for n in range(-1, 3)]
    tot = dict(pairs=0, points=0, cells=0, empty=0, none=0); alt = {}
    cache = {}
    def cor(mn):
        if mn not in cache: cache[mn] = E.corners_at(tiles, L(*mn))[0]
        return cache[mn]
    for a in range(len(W)):
        for b in range(a + 1, len(W)):
            x, y = L(*W[a]), L(*W[b])
            if float(E.n2(E.sub(x, y))) > 3.5: continue
            tot["pairs"] += 1
            run = E.Run(ob["labels"]); ix = run.add(x, [E.Corner(g.label, g.lo, g.hi, g.src) for g in cor(W[a])]); iy = run.add(y, [E.Corner(g.label, g.lo, g.hi, g.src) for g in cor(W[b])])
            lx, ly = {g.label for g in run.fam[ix]}, {g.label for g in run.fam[iy]}
            assert len(ob["labels"] - lx) == 1 and len(ob["labels"] - ly) == 1 and lx != ly
            for w in E.cups(x, y):
                wi = run.R.id(w); mem, tab = run.table(wi); tot["points"] += 1
                for c in tab:
                    tot["cells"] += 1; tot["empty"] += not c["left"]
                    ways = set()
                    for lab in c["left"]:
                        ways.add("a-pure-for-y" if lab not in lx else ("b-pure-for-x" if lab not in ly else "one-label-pure-for-both"))
                    tot["none"] += not ways
                    key = "+".join(sorted(ways)) or "NONE"; alt[key] = alt.get(key, 0) + 1
    print("r7 cells: " + " ".join(f"{k}={v}" for k, v in tot.items()) + " | saved by: " + " ".join(f"{k}={v}" for k, v in sorted(alt.items())))
    # the held stop, read in the same words: FS114-Y2-BOWTIE, q2 and q1, at (sqrt 3, 0) and at the origin
    ob = load("bowtie"); p, x, y = (ob["locate"](q) for q in E.STOPS["bowtie"])
    run = E.Run(ob["labels"]); ix = run.add(x, ob["corners"](x)[0]); iy = run.add(y, ob["corners"](y)[0])
    lx, ly = {g.label for g in run.fam[ix]}, {g.label for g in run.fam[iy]}
    for nm, w in (("(sqrt3,0)", E.sub(E.add(x, y), p)), ("origin", p)):
        wi = run.R.id(w); mem, tab = run.table(wi); res = []
        for c in tab:
            sd = "/".join(c["sides"][i] for i in mem)
            res.append(f"{sd}=" + (",".join(f"{lab}:{'a-pure-for-y' if lab not in lx else ('b-pure-for-x' if lab not in ly else 'both')}" for lab in sorted(c["left"], key=str)) or "EMPTY"))
        print(f"bowtie at {nm} (q2 lacks {sorted(ob['labels'] - lx)}, q1 lacks {sorted(ob['labels'] - ly)}; sides q2/q1): " + " ".join(res))
    return 0


# ------------------------------------------------------------------------------------------------ C137-RING
def ring():
    for name in ("r7", "strip", "disk", "flower", "bowtie"):
        ob = load(name); k = len(ob["labels"]); V = []
        for v in ob["verts"]:
            fam, full = corners(ob, v)
            if fam: V.append((v, fam, full, {g.label for g in fam}))
        npair = ncross = labviol = cntviol = nform = eq = 0; slack = {}; centres = 0; ringmin = None; best = None
        for x, fam, full, lx in V:
            if not full: continue
            form = len(fam) == len(lx) and all(angle_class(g) in ("cusp", "lt") for g in fam); eds = edges_of(fam)
            tot = n = a = 0
            for y, gam, fy, ly in V:
                if y is x or not E.is_unit(x, y): continue
                npair += 1; e = E.sub(y, x)
                cls = {id(g): klass(g, x, e, fam[0]) for g in fam}; cr = [g for g in fam if cls[id(g)] == "crossing"]
                ncross += len(cr); labviol += sum(g.label in ly for g in cr)
                s = sum(1 for cv in eds if along(cv, x, e))
                if form:
                    nform += 1; sl = k - 2 + s - len(ly); slack[sl] = slack.get(sl, 0) + 1
                    cntviol += (len(cr) != 2 - s) + (sl < 0); eq += sl == 0
                    tot += len(ly); n += 1; a += s
            if form and n:
                centres += 1; d = (k - 2) * n + a - tot
                if ringmin is None or d < ringmin or (d == ringmin and n > best[0]): ringmin, best = d, (n, tot, a, len(lx))
        print(f"{name}: k={k} cornered vertices={len(V)} unit pairs (x full)={npair} crossing corners={ncross} WITH A LABEL OF THE FAR POINT={labviol} | x one-corner, angles<180: pairs={nform} count-violations={cntviol} "
              f"slack k-2+s-|L(G)|={dict(sorted(slack.items()))} | ring sums: centres={centres} least (k-2)n+a-sum={ringmin}" + (f" at n={best[0]}: sum={best[1]} a={best[2]} m={best[3]}" if best else "") +
              f" | fl={NCLS[0]} mismatches={NCLS[1]}")
    return 0


if __name__ == "__main__":
    m = MODE[0] if MODE else ""
    f = dict(scan=scan, repeat=repeat, three=three, forced=forced, meet=meet, ring=ring).get(m)
    if not f: print(__doc__); sys.exit(2)
    sys.exit(f())

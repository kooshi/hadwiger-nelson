#!/usr/bin/env python3
"""FS136-E1 — the exact checks behind C136-RINGS-READ's three radii and C136-STOP: at a named point across w of a named
covering pair (x, y) on the ring of a named centre p of a held object, in the object's own exact numbers (the towers of
tools/fs114_yb_exact.py and tools/fs112_yb2_check.py; every comparison is an exact sign):

  1. w = x + y - p, |w - x|^2 = |w - y|^2 = 1, 0 < |x - y|^2 < 4, and |w - p|^2 against the filed radius
     (strip: (4 d^2 - 7)^2 = 45 and 4 d^2 > 7, i.e. d^2 = (7 + 3 sqrt5)/4 = phi^4 / 2; disk: (2 d^2 - 3)^2 = 5 and
     2 d^2 > 3, i.e. d^2 = phi^2; flower and bowtie fragment: d^2 = 3);
  2. the kept tiles: every tile of the object with x, or y, as an end point of one of its boundary pieces;
  3. for each kept tile T at a member z, WITNESSES among exact points of T's own boundary pieces (their end points, and
     rational points along them: boundary_points), which lie in the closure of T: one, v, with |v - w|^2 < 1 shows T has
     points strictly inside the unit circle about w (an open condition at a point of the closure), one with
     |v - w|^2 > 1 shows it has points strictly outside;
     by C124-TYPE the first bars T's label near w outside the unit circle about z, the second inside it;
  4. the cells: for each of the four cells (inside / outside the unit circle about x, about y), the labels NOT shown
     barred there; a cell with none is PROVED EMPTY: no weak six-colouring of an open set containing w keeps the kept
     tiles.  (A label left in a cell is not thereby allowed: witnesses can only prove bars.)
  horn   for the flower: the point e(-30) + (1/4) e(300) lies in the gap tile G5 (its three defining inequalities and
         the cut, exact) and is strictly outside the unit circle about (sqrt3, 0): the witness that survives when only
         a germ of G5 at e(-30) is kept (the tangent ray: 1 + t^2 > 1).

  python3 data/fs136/e1/stop_check.py [flower|disk|strip|bowtie|horn] [--fault]
--fault reads the point w + (1/50, 0): step 1 must fail and nothing is concluded.
"""
import sys, os, math
from fractions import Fraction as Fr
HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, "..", "..", ".."))
sys.path.insert(0, os.path.join(ROOT, "tools"))
ARGS = [a for a in sys.argv[1:] if not a.startswith("--")]
FAULT = "--fault" in sys.argv
sys.argv = [sys.argv[0]]


def fl(p): return (float(p[0]), float(p[1]))
def sub(a, b): return (a[0] - b[0], a[1] - b[1])
def add(a, b): return (a[0] + b[0], a[1] + b[1])
def n2(a): return a[0] * a[0] + a[1] * a[1]
def sgn(v): return v.sign() if hasattr(v, "sign") else (v > 0) - (v < 0)
def ends(pc): return (pc.P, pc.Q) if pc.kind == "S" else (pc.S, pc.E)
def crs(a, b): return a[0] * b[1] - a[1] * b[0]


def boundary_points(pc):
    """exact points of the closed piece: its ends; on a segment the points P + (k/8)(Q - P); on an arc (counter-clockwise
    from S to E about C, under 180 degrees) the points C + R_u (S - C), R_u the rotation with tan(angle/2) = u = j/16,
    kept when they lie on the arc (two exact cross products).  All lie in the closure of every tile the piece bounds."""
    out = list(ends(pc))
    if pc.kind == "S":
        d = sub(pc.Q, pc.P)
        return out + [(pc.P[0] + d[0] * Fr(k, 8), pc.P[1] + d[1] * Fr(k, 8)) for k in range(1, 8)]
    a, e = sub(pc.S, pc.C), sub(pc.E, pc.C)
    for j in range(1, 17):
        u = Fr(j, 16); c, sn = (1 - u * u) / (1 + u * u), 2 * u / (1 + u * u)
        v = (a[0] * c - a[1] * sn, a[0] * sn + a[1] * c)
        if sgn(crs(a, v)) >= 0 and sgn(crs(v, e)) >= 0: out.append(add(pc.C, v))
    return out


def tiles_of(name):
    if name == "flower":
        import fs116_y2_six as Y2
        return {t.name: (t.colour, t.pieces) for t in Y2.fragment()[3]}
    if name == "bowtie":
        import fs114_y2_k1 as K1
        return {t.name: (t.colour, t.pieces) for t in K1.build()}
    import fs114_yb3_run as XR, fs112_yb2_objects as O
    return XR.conv_tiles(O.Strip().tiles(-4, 6)) if name == "strip" else XR.conv_tiles(O.Disk().tiles())


SPEC = {   # object: (p, x, y) as floats locating exact vertices; the radius test
    "flower": ((0.0, 0.0), (math.cos(-math.pi / 6), math.sin(-math.pi / 6)), (math.cos(math.pi / 6), math.sin(math.pi / 6)), "d^2 = 3"),
    "bowtie": ((0.0, 0.0), (math.sqrt(3) / 2, -0.5), (math.sqrt(3) / 2, 0.5), "d^2 = 3"),
    "strip": ((0.0, 0.0), (-0.25, math.sqrt(15) / 4), (0.5, math.sqrt(3) / 2), "d^2 = phi^4/2"),
    "disk": ((-0.5, 0.16245984811645317), (-1.5, 0.16245984811645317), (-0.80901699437, 1.11351636441), "d^2 = phi^2"),
}


def radius_ok(kind, d2):
    if kind == "d^2 = 3": return sgn(d2 - 3) == 0
    if kind == "d^2 = phi^4/2": u = 4 * d2 - 7; return sgn(u * u - 45) == 0 and sgn(u) > 0
    if kind == "d^2 = phi^2": u = 2 * d2 - 3; return sgn(u * u - 5) == 0 and sgn(u) > 0
    raise SystemExit(kind)


def check(name):
    T = tiles_of(name)
    V = {}
    for nm, (c, ps) in T.items():
        for pc in ps:
            for v in ends(pc): V.setdefault((round(float(v[0]), 7), round(float(v[1]), 7)), v)
    def locate(q):
        k = min(V, key=lambda k: (k[0] - q[0]) ** 2 + (k[1] - q[1]) ** 2)
        assert math.hypot(k[0] - q[0], k[1] - q[1]) < 1e-6, f"no vertex at {q}"
        return V[k]
    pf, xf, yf, kind = SPEC[name]
    p, x, y = locate(pf), locate(xf), locate(yf)
    w = sub(add(x, y), p)
    if FAULT: w = (w[0] + Fr(1, 50), w[1])
    one = [sgn(n2(sub(w, z)) - 1) == 0 for z in (x, y, p)]
    dxy = n2(sub(x, y))
    step1 = one[0] and one[1] and sgn(dxy) > 0 and sgn(dxy - 4) < 0 and radius_ok(kind, n2(sub(w, p)))
    out = [f"{name}: p=({pf[0]:.5f},{pf[1]:.5f}) x=({xf[0]:.5f},{xf[1]:.5f}) y=({yf[0]:.5f},{yf[1]:.5f}) w=x+y-p=({float(w[0]):.5f},{float(w[1]):.5f})",
           f"  1. |w-x|=1:{one[0]} |w-y|=1:{one[1]} 0<|x-y|<2:{sgn(dxy) > 0 and sgn(dxy - 4) < 0} |w-p|: {kind}:{radius_ok(kind, n2(sub(w, p)))}"]
    if not step1:
        print("\n".join(out)); print(f"{name}: STEP 1 FAILS - nothing concluded"); return 1
    bars = {"x": {"in": set(), "out": set()}, "y": {"in": set(), "out": set()}}   # labels barred inside / outside S(z) near w
    labels = set(); kept = []
    for zn, z in (("x", x), ("y", y)):
        for nm, (c, ps) in sorted(T.items()):
            if not any(sgn(n2(sub(v, z))) == 0 for pc in ps for v in ends(pc)): continue
            vs = [v for pc in ps for v in boundary_points(pc)]
            win = [v for v in vs if sgn(n2(sub(v, w)) - 1) < 0]; wout = [v for v in vs if sgn(n2(sub(v, w)) - 1) > 0]
            if win: bars[zn]["out"].add(c)
            if wout: bars[zn]["in"].add(c)
            labels.add(c); kept.append(nm)
            out.append(f"  3. tile {nm} label {c} at {zn}: " + (f"inside-witness ({float(win[0][0]):.4f},{float(win[0][1]):.4f}) " if win else "no witness strictly inside ") +
                       (f"outside-witness ({float(wout[0][0]):.4f},{float(wout[0][1]):.4f})" if wout else "no witness strictly outside") +
                       " -> barred " + ("on both sides" if win and wout else ("outside" if win else "inside")) + f" S({zn})")
    out.insert(2, f"  2. kept tiles: {' '.join(kept)} | labels of the kept tiles: {len(labels)}")
    empty = []
    for sx in ("in", "out"):
        for sy in ("in", "out"):
            left = sorted(str(l) for l in labels if l not in bars["x"][sx] and l not in bars["y"][sy])
            out.append(f"  4. cell {sx} S(x), {sy} S(y): labels not shown barred: {' '.join(left) or 'NONE - PROVED EMPTY'}")
            if not left: empty.append(f"{sx}/{sy}")
    ok = len(labels) == 6 and bool(empty)
    print("\n".join(out))
    print(f"{name}: kept-tiles={len(kept)} labels={len(labels)} cells-proved-empty={','.join(empty) or 'none'} " + ("EXCLUDED" if ok else "NOT EXCLUDED BY THESE WITNESSES"))
    return 0 if ok else 1


def horn():
    import fs114_yb_exact as K
    T = K.Tower.base().extend(3, "3"); r3 = T.gen(1)
    t = Fr(1, 100) if FAULT else Fr(1, 4)
    xm = (r3 / 2, T(Fr(-1, 2)))                                   # e(-30)
    q = (xm[0] + t * Fr(1, 2), xm[1] - t * r3 / 2) if not FAULT else (xm[0] + t * r3 / 2, xm[1] - t * Fr(1, 2))   # fault: direction 330
    w = (r3, T(0)); em90 = (T(0), T(-1)); e30 = (r3 / 2, T(Fr(1, 2)))
    inG = [sgn(n2(q) - 1) > 0, sgn(n2(sub(q, em90)) - 1) > 0, sgn(n2(sub(q, e30)) - 1) > 0, sgn(n2(q) - Fr(9, 4)) < 0]
    outw = sgn(n2(sub(q, w)) - 1) > 0
    print(f"horn: q=e(-30)+t*e({'330' if FAULT else '300'}), t={t}: outside-S(p)={inG[0]} outside-S(e(-90))={inG[1]} outside-S(e(30))={inG[2]} inside-the-cut={inG[3]} "
          f"strictly-outside-S(w)={outw} " + ("HORN WITNESS OK" if all(inG) and outw else "NOT A WITNESS"))
    return 0 if all(inG) and outw else 1


if __name__ == "__main__":
    names = ARGS or ["flower", "disk", "strip", "bowtie", "horn"]
    sys.exit(max(horn() if n == "horn" else check(n) for n in names))

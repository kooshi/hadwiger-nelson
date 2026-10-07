#!/usr/bin/env python3
"""FS132-E4 — the ring card's controls.  Each subcommand checks one derived shape; --fault plants one fault in it.

  crossing   C132-CROSS: two unit circles about centres at distance D, 0 < D < 2, cross transversally at their common
             unit points, so each of the four quadrants there is non-empty.  Fault: D = 2 (tangent circles).
  hex7       C132-CROSS at seven labels: in the hexagonal seven-colouring (circumradius 2/5), for every two vertices
             less than 2 apart, no label of either vertex's triangle occurs near a common unit point, and the two outside
             sets always share a label.  Fault: circles of radius 7/10 instead of 1.
  fragments  C132-CROSS against the four held seam fragments S1, T2, BB, MX (FS110-FRAGS): the blocking rule read off
             each fragment's own primitives at u and v, against the colours found near both common unit points, beside
             the verdict of FS110-Y's checker (imported, not edited).  Fault: the checker's own plant t2_flat (in T2,
             u's arcs of the unit circle about w replaced by their chords).
  wedges     C132-PLACE: the chart Z(a, d) = e(a) + e(a - 2pi/3 - d): which side of the ring and of the two unit circles
             about the ring neighbours a point lies on, against the signs the argument uses; then the label sets the
             transfer leaves in the four wedges for the two six-sector rings.  Fault: the inside test reversed.
  shift      the unit-pair shift eps(d, d') of FS132-E3's M7 in all four sign quadrants: its sign and its ratio to d d'.
             Fault: the pair is put at distance 1.001.
  edge       C132-TURN-EDGE: the unit circles about the two ring neighbours of a ring point y meet at x and y only, and the
             four regions the argument reads lie outside the ring, on the stated side of the unit circle about y.
             Fault: a ring point 0.3 radians off in place of y.
  pairs      C132-ALT and the turning ring: for the two six-sector step rings and the four patterns of pure sides at two
             adjacent ring points, how many sampled unit pairs join two points whose labels the transfer forces to one
             label.  Fault: the turning ring's states in place of the alternating ring's.
"""
import sys, os, math
from fractions import Fraction as Fr

FAULT = "--fault" in sys.argv
ROOT = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "..", ".."))


def e(t):
    return (math.cos(t), math.sin(t))


def dist(p, q):
    return math.hypot(p[0] - q[0], p[1] - q[1])


# ---------------------------------------------------------------------------------------------- crossing
def crossing():
    Ds = [Fr(1, 10), Fr(1, 2), Fr(1), Fr(3, 2), Fr(19, 10)]
    if FAULT:
        Ds[-1] = Fr(2)
    least = None
    allfour = True
    for D in Ds:
        det2 = D * D * (1 - D * D / 4)        # (cross(w - x, w - y))^2, the squared Jacobian of z -> (|z-x|, |z-y|) at w
        least = det2 if least is None else min(least, det2)
        x, y = (0.0, 0.0), (float(D), 0.0)
        w = (float(D) / 2, math.sqrt(max(0.0, 1 - float(D) ** 2 / 4)))
        seen = set()
        n = 60
        for i in range(-n, n + 1):
            for j in range(-n, n + 1):
                z = (w[0] + 0.01 * i / n + 1e-7, w[1] + 0.01 * j / n + 2e-7)
                seen.add((dist(z, x) > 1, dist(z, y) > 1))
        allfour &= (len(seen) == 4)
    print(f"least-squared-jacobian={least} all-four-quadrants={allfour}")


# ---------------------------------------------------------------------------------------------- hex7
R7 = 0.4
A1 = (math.sqrt(3) * R7, 0.0)
A2 = (math.sqrt(3) * R7 / 2, 1.5 * R7)


def centre(m, n):
    return (m * A1[0] + n * A2[0], m * A1[1] + n * A2[1])


def hexcol(z):
    """colour of the hexagon (pointy-top, circumradius 2/5) containing z: (3m + n) mod 7 at the nearest centre (m, n)."""
    n0 = z[1] / A2[1]
    m0 = (z[0] - n0 * A2[0]) / A1[0]
    best = None
    for m in range(math.floor(m0) - 1, math.floor(m0) + 3):
        for n in range(math.floor(n0) - 1, math.floor(n0) + 3):
            d = dist(z, centre(m, n))
            if best is None or d < best[0]:
                best = (d, (3 * m + n) % 7)
    return best[1]


def hex7():
    rad = Fr(7, 10) if FAULT else Fr(1)
    r = float(rad)
    verts = {}
    for m in range(-9, 10):
        for n in range(-9, 10):
            c = centre(m, n)
            for k in range(6):
                v = (c[0] + R7 * math.cos(math.pi / 2 + k * math.pi / 3), c[1] + R7 * math.sin(math.pi / 2 + k * math.pi / 3))
                if math.hypot(*v) < 3.2:
                    verts[(round(v[0], 6), round(v[1], 6))] = v
    vs = list(verts.values())
    typ = {}
    for v in vs:
        typ[v] = frozenset(hexcol((v[0] + 0.02 * math.cos(a), v[1] + 0.02 * math.sin(a))) for a in [k * math.pi / 12 for k in range(24)])
        assert len(typ[v]) == 3
    pairs = crossings = bad = 0
    shared = 7
    for x in vs:
        if math.hypot(*x) > 0.75:
            continue
        for y in vs:
            D = dist(x, y)
            if D < 1e-9 or D >= 2 * r - 1e-9:
                continue
            pairs += 1
            shared = min(shared, len(set(range(7)) - typ[x] - typ[y]))
            mid = ((x[0] + y[0]) / 2, (x[1] + y[1]) / 2)
            h = math.sqrt(r * r - D * D / 4)
            nx, ny = -(y[1] - x[1]) / D, (y[0] - x[0]) / D
            for sgn in (1, -1):
                w = (mid[0] + sgn * h * nx, mid[1] + sgn * h * ny)
                crossings += 1
                near = {hexcol(w)} | {hexcol((w[0] + 0.01 * math.cos(a), w[1] + 0.01 * math.sin(a))) for a in [k * math.pi / 12 for k in range(24)]}
                if near & (typ[x] | typ[y]):
                    bad += 1
    print(f"vertex-pairs={pairs} crossings={crossings} least-shared-outside={shared} own-label-near-crossing={bad}")


# ---------------------------------------------------------------------------------------------- fragments
def fragments():
    sys.path.insert(0, os.path.join(ROOT, "tools"))
    import fs110_y_fragments as F
    if FAULT:
        F.PLANT = "t2_flat"
    cen = {"u": (0.0, 0.0), "v": (1.0, 0.0)}
    cross = {"w": (0.5, math.sqrt(3) / 2), "w'": (0.5, -math.sqrt(3) / 2)}

    def fpt(P):
        return (P[0].f(), P[1].f())

    def pts(prim):
        if isinstance(prim, F.Seg):
            (ax, ay), (bx, by) = fpt(prim.P), fpt(prim.Q)
            return [(ax + (bx - ax) * i / 96, ay + (by - ay) * i / 96) for i in range(97)]
        return [q for ch in F.polyline([prim], 96) for q in ch]

    def pdist(z, prim):
        if isinstance(prim, F.Seg):
            (ax, ay), (bx, by) = fpt(prim.P), fpt(prim.Q)
            L2 = (bx - ax) ** 2 + (by - ay) ** 2
            s = max(0.0, min(1.0, ((z[0] - ax) * (bx - ax) + (z[1] - ay) * (by - ay)) / L2))
            return dist(z, (ax + s * (bx - ax), ay + s * (by - ay)))
        return min(dist(z, q) for q in pts(prim)) if abs(dist(z, fpt(prim.C)) - prim.r.f()) > 1e-9 else \
            min(abs(dist(z, fpt(prim.C)) - prim.r.f()) + 0.0 if _on_arc(z, prim) else dist(z, q) for q in [fpt(prim.S), fpt(prim.E)])

    def _on_arc(z, prim):
        cx, cy = fpt(prim.C)
        a0 = math.atan2(fpt(prim.S)[1] - cy, fpt(prim.S)[0] - cx)
        a1 = math.atan2(fpt(prim.E)[1] - cy, fpt(prim.E)[0] - cx)
        az = math.atan2(z[1] - cy, z[0] - cx)
        return (az - a0) % (2 * math.pi) <= (a1 - a0) % (2 * math.pi) + 1e-12

    out, verdicts, oncircle = [], [], 0
    for name, build in F.FRAGS.items():
        T = build()
        rows, rej = F.check_fragment(T)
        verdicts.append("REJECT" if rej else "ACCEPT")
        viol = 0
        for wn, w in cross.items():
            excl = {}
            for cn, c in cen.items():
                tiles = [(k, v) for k, v in T.items() if k.startswith(cn + "_")]
                ex = {"out": set(), "in": set()}
                for i in range(len(tiles)):
                    for j in range(i + 1, len(tiles)):
                        (ki, (ci, pi)), (kj, (cj, pj)) = tiles[i], tiles[j]
                        if ci == cj:
                            continue
                        # the common edge at the centre: points of tile i's boundary near the centre that lie on tile j's boundary
                        edge = [q for prim in pi for q in pts(prim)
                                if 1e-9 < dist(q, c) < 0.12 and min(pdist(q, pr) for pr in pj) < 1e-9]
                        if not edge:
                            continue
                        lo, hi = min(dist(q, w) for q in edge), max(dist(q, w) for q in edge)
                        if lo < 1 - 1e-9:
                            ex["out"] |= {ci, cj}
                        if hi > 1 + 1e-9:
                            ex["in"] |= {ci, cj}
                        if lo >= 1 - 1e-9 and hi <= 1 + 1e-9 and name == "T2" and wn == "w":
                            oncircle += 1
                excl[cn] = ex
            pre = "w_" if wn == "w" else ("W_", "w'_")
            wt = [(k, v) for k, v in T.items() if k.startswith(pre)]
            for a in range(24):
                z = (w[0] + 0.013 * math.cos(0.11 + a * math.pi / 12), w[1] + 0.013 * math.sin(0.11 + a * math.pi / 12))
                cols = [col for k, (col, prims) in wt if F.inside(prims, z[0], z[1])]
                if len(cols) != 1:
                    continue
                su = "out" if dist(z, cen["u"]) > 1 else "in"
                sv = "out" if dist(z, cen["v"]) > 1 else "in"
                viol += cols[0] in (excl["u"][su] | excl["v"][sv])
        out.append(f"{name}={viol}")
    print("excluded-labels-seen-near-the-common-unit-points:" + ",".join(out)
          + f" checker={','.join(verdicts)} sets-of-T2-on-the-unit-circle-about-w={oncircle}")


# ---------------------------------------------------------------------------------------------- the chart
def Z(a, d):
    p, q = e(a), e(a - 2 * math.pi / 3 - d)
    return (p[0] + q[0], p[1] + q[1])


def wedges():
    psi = 0.37
    f, b = psi + math.pi / 3, psi - math.pi / 3          # the forward and backward ring neighbours of the ring point e(psi)
    bad = n = 0
    for i in range(-20, 21):
        for j in range(-20, 21):
            th, d = 0.003 * i + 1e-5, 0.003 * j + 2e-5        # a = f + th
            z = Z(f + th, d)
            n += 1
            inside_ring = math.hypot(*z) < 1
            in_f = dist(z, e(f)) < 1
            in_b = dist(z, e(b)) < 1
            if FAULT:
                in_f = not in_f
            # the argument's signs: inside the ring iff d > 0; inside C(forward hub) iff th > 0; inside C(backward hub) iff th - d < 0
            bad += (inside_ring != (d > 0)) + (in_f != (th > 0)) + (in_b != (th - d < 0))
    N = "abc"

    def table(L):
        # a six-sector ring: the sector before psi_k carries L[k], the one after carries L[k+1]; at the ring point k = 0
        fm, fp = L[1], L[2]              # the state before / after psi_1
        gm, gp = L[-1], L[0]             # the state before / after psi_{-1}
        cell = lambda u, v: "".join(sorted(set(N) - {u, v}))
        return f"far={cell(fm, gp)} lens={cell(fp, gm)} cw={cell(fm, gm)} ccw={cell(fp, gp)}"

    turning = ["a", "b", "c", "a", "b", "c"]     # L[0] before psi_0, L[1] after it, ..., L[-1] = c before psi_{-1}
    alternating = ["a", "b", "a", "b", "a", "b"]
    print(f"chart-samples={n} sign-mismatches={bad} turning:{table(turning)} alternating:{table(alternating)}")


def edge():
    """C132-TURN-EDGE: the two unit circles about the ring neighbours e(psi +- pi/3) meet at x = 0 and y = e(psi) only; and
    the four regions the argument reads lie outside the ring and on the stated side of the unit circle about y."""
    psi = 0.37
    y0 = e(psi + (0.3 if FAULT else 0.0))
    yp, ym = e(psi + math.pi / 3), e(psi - math.pi / 3)
    mid = ((yp[0] + ym[0]) / 2, (yp[1] + ym[1]) / 2)
    D = dist(yp, ym)
    h = math.sqrt(1 - D * D / 4)
    nrm = ((ym[1] - yp[1]) / D, -(ym[0] - yp[0]) / D)
    P = [(mid[0] + sg * h * nrm[0], mid[1] + sg * h * nrm[1]) for sg in (1, -1)]
    meets = all(min(dist(q, (0.0, 0.0)), dist(q, y0)) < 1e-12 for q in P)
    bad = n = 0
    for i in range(1, 13):
        for j in range(1, 13):
            d = -0.002 * j
            for base, th, inside_y in (
                    (psi + 2 * math.pi / 3, d * i / 13, False),          # far wedge at y_1: d < th < 0
                    (psi + 2 * math.pi / 3, d * (1 + i / 3), True),      # outer part of the cw wedge at y_1: th < d
                    (psi, d * i / 13, False),                            # far wedge at y_-1: d < th < 0
                    (psi, 0.002 * i, True)):                             # outer part of the ccw wedge at y_-1: th > 0
                z = Z(base + th, d)
                n += 1
                bad += (math.hypot(*z) <= 1) + ((dist(z, y0) < 1) != inside_y)
    print(f"circles-meet-at-x-and-y={meets} region-samples={n} side-mismatches={bad}")


def partner(z, dp):
    """the point z' = Z(a', d') at distance 1 from z, counterclockwise of it; returns (a', z')."""
    r, rp = math.hypot(*z), 2 * math.cos(math.pi / 3 + dp / 2)
    target = 1.001 if FAULT and sys.argv[1] == "shift" else 1.0
    ang = math.atan2(z[1], z[0]) + math.acos((r * r + rp * rp - target ** 2) / (2 * r * rp))
    zp = (rp * math.cos(ang), rp * math.sin(ang))
    return ang + math.pi / 3 + dp / 2, zp


def shift():
    lo, hi, wrong = None, None, 0
    for sd in (1, -1):
        for sdp in (1, -1):
            for i in range(1, 9):
                for j in range(1, 9):
                    d, dp = sd * 0.004 * i, sdp * 0.004 * j
                    a = 1.1
                    ap, zp = partner(Z(a, d), dp)
                    eps = ap - a - math.pi / 3 - dp
                    ratio = eps / (d * dp)
                    lo = ratio if lo is None else min(lo, ratio)
                    hi = ratio if hi is None else max(hi, ratio)
                    wrong += (eps > 0) != (d * dp > 0)
                    wrong += abs(eps) > min(abs(d), abs(dp)) / 16
    print(f"ratio-min={lo:.3f} ratio-max={hi:.3f} limit={2 / math.sqrt(3):.4f} sign-or-size-violations={wrong}")


def pairs():
    """Two adjacent ring points y_0 = e(psi_0), y_1 = e(psi_1) of a six-sector step ring with sectors L[k] before psi_k.
    A point near y_0 is Z(psi_1 + th, d); its partner near y_1 is Z(a', d'), a' = psi_1 + th + pi/3 + d' + eps."""
    N = set("abc")
    rings = {"alternating": ["a", "b", "a", "b", "a", "b"], "turning": ["a", "b", "c", "a", "b", "c"]}
    if FAULT:
        rings["alternating"] = rings["turning"]
    psi1 = 0.9
    out = []
    for name in ("alternating", "turning"):
        L = rings[name]
        st = lambda k, t: L[k % 6] if t < 0 else L[(k + 1) % 6]      # the state at psi_k + t
        res = []
        for side0 in ("O", "I"):
            for side1 in ("O", "I"):
                hits = 0
                for i in range(1, 7):
                    for j in range(1, 7):
                        d = (-1 if side0 == "O" else 1) * 0.004 * i
                        dp = (-1 if side1 == "O" else 1) * 0.004 * j
                        eps0 = (2 / math.sqrt(3)) * d * dp
                        for th in [t * abs(eps0) for t in (-3, -0.5, 0.5, 3)] + [t * abs(d) for t in (-2, -0.5, 0.5, 2)] + [t * abs(dp) for t in (-2, -0.5, 0.5, 2)]:
                            a = psi1 + th
                            z = Z(a, d)
                            ap, zp = partner(z, dp)
                            eps = ap - a - math.pi / 3 - dp
                            c0 = N - {st(1, th), st(-1, th - d)}                 # the labels left at z on the pure side of y_0
                            c1 = N - {st(2, th + dp + eps), st(0, th + eps)}       # the labels left at z' on the pure side of y_1
                            if len(c0) == 1 and c0 == c1:
                                hits += 1
                res.append(f"{side0}{side1}={hits}")
        out.append(name + ":" + ",".join(res))
    print(" ".join(out))


if __name__ == "__main__":
    {"crossing": crossing, "hex7": hex7, "fragments": fragments, "wedges": wedges, "shift": shift, "pairs": pairs, "edge": edge}[sys.argv[1]]()

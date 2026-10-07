#!/usr/bin/env python3
"""FS132-E6 — checks for C132-SHADOW, C132-LENS and the entries beside them (plans/FS132-E6-derivation.md).

Setting: x = (0, 0), ring points y_k = e(k*60 deg) (the orbit's angle psi put at 0; `shadow --psi` turns the whole figure,
the answer must not move).  The six wedges at a ring point y_k, cut by the unit circles about x, y_{k+1} and y_{k-1}, are
classified BY DISTANCES, never by a chart:
    0 O_cw   outside x, outside y_{k+1}, inside  y_{k-1}        3 I_ccw  inside x, inside  y_{k+1}, outside y_{k-1}
    1 O_far  outside y_{k+1}, outside y_{k-1}                   4 I_lens inside y_{k+1}, inside y_{k-1}
    2 O_ccw  outside x, inside  y_{k+1}, outside y_{k-1}        5 I_cw   inside x, outside y_{k+1}, inside  y_{k-1}
(the search's numbering, data/search/2026-10-07/turning_ring.py).  arcs(z, k, kappa) returns, for a point z, the length of
the part of the unit circle about z that lies in each wedge at y_k within the ball B(y_k, kappa): the breakpoints are the
exact crossing angles with the four circles (unit about x, y_{k+1}, y_{k-1}; radius kappa about y_k) and each piece is
classified at its midpoint, so a length is exact up to rounding — no sampling of the circle.

  shadow [--fault]   the card's falsifier, computed: points near y_0 (polar grid in B(y_0, eta)) whose unit circle misses,
                     in length, the far wedge at y_1 (resp. y_-1).  Also (W): the chart's wedges at y_1 against distances.
                     --fault: the target wedge at each neighbour is O_cw / O_ccw (the outer wedge on the other side of
                     the unit circle about y_0) instead of O_far.
  seeing [--fault]   which wedge at y_0 has EVERY point's unit circle meeting which wedge at y_1 (and back), at two sizes;
                     for the pairs of the search's steps 3 and 4, the fraction of the looking wedge that sees the other,
                     against the size kappa of the wedge seen (it falls with kappa).  --fault: y_2 in place of y_1.
  sides  [--fault]   patterns of pure sides: witnesses near x (three inside, three outside), and witnesses far from x.
                     --fault: the near witnesses at distance 3/2 instead of 1/10.
  model  [--fault]   the search's kept four-label model read against the first-order pairs, its labels and its sides.
                     --fault: its lens at y_1 relabelled b.
  hexcross [--fault] the honeycomb at circumradius 1/2: at every common unit point of two vertices where a label of one of
                     them is seen, on which side of that vertex's unit circle.  --fault: circumradius 0.45.
"""
import sys, math, json, pathlib, itertools

FAULT = "--fault" in sys.argv
ROOT = pathlib.Path(__file__).resolve().parents[3]
WN = ["O_cw", "O_far", "O_ccw", "I_ccw", "I_lens", "I_cw"]
PSI = 0.0


def e(t):
    return (math.cos(t), math.sin(t))


def Y(k):
    return e(PSI + k * math.pi / 3)


def dist(p, q):
    return math.hypot(p[0] - q[0], p[1] - q[1])


def wedge(z, k):
    """index of the wedge at y_k containing z (None on a boundary, to rounding)."""
    sx, sp, sm = math.hypot(*z) - 1, dist(z, Y(k + 1)) - 1, dist(z, Y(k - 1)) - 1
    if min(abs(sx), abs(sp), abs(sm)) < 1e-13:
        return None
    if sp > 0 and sm > 0:
        return 1
    if sp < 0 and sm < 0:
        return 4
    if sp < 0 < sm:
        return 2 if sx > 0 else 3
    return 0 if sx > 0 else 5


def crossings(z, p, r):
    """angles phi with |z + e(phi) - p| = r."""
    D = dist(z, p)
    if D < 1e-15:
        return []
    c = (r * r - 1 - D * D) / (2 * D)
    if abs(c) > 1:
        return []
    a0, a = math.atan2(z[1] - p[1], z[0] - p[0]), math.acos(c)
    return [a0 + a, a0 - a]


def arcs(z, k, kappa):
    """lengths of the unit circle about z in the six wedges at y_k, inside B(y_k, kappa)."""
    yk = Y(k)
    phc = math.atan2(yk[1] - z[1], yk[0] - z[0])
    W = 3 * kappa + 3 * abs(dist(z, yk) - 1) + 1e-9
    bps = [-W, W]
    for p, r in ((( 0.0, 0.0), 1.0), (Y(k + 1), 1.0), (Y(k - 1), 1.0), (yk, kappa)):
        for a in crossings(z, p, r):
            t = (a - phc + math.pi) % (2 * math.pi) - math.pi
            if -W < t < W:
                bps.append(t)
    bps.sort()
    out = [0.0] * 6
    for t0, t1 in zip(bps, bps[1:]):
        if t1 - t0 < 1e-15:
            continue
        m = phc + (t0 + t1) / 2
        w = (z[0] + math.cos(m), z[1] + math.sin(m))
        if dist(w, yk) < kappa:
            j = wedge(w, k)
            if j is not None:
                out[j] += t1 - t0
    return out


def grid(k, rho, nr=12, na=72):
    """polar grid about y_k, radii rho*(j+1/2)/nr, angles offset so that no point lies on a wedge boundary direction."""
    yk = Y(k)
    for j in range(nr):
        r = rho * (j + 0.5) / nr
        for i in range(na):
            a = PSI + 2 * math.pi * (i + 0.37) / na
            yield (yk[0] + r * math.cos(a), yk[1] + r * math.sin(a))


# ------------------------------------------------------------------------------------------------ shadow
def shadow():
    global PSI
    if "--psi" in sys.argv:
        PSI = float(sys.argv[sys.argv.index("--psi") + 1])
    kappa, eta = 0.2, 0.02
    tp, tm = (0, 2) if FAULT else (1, 1)          # target wedge at y_1, at y_-1
    lens = in1 = inm = miss_a = miss_b = miss1 = missm = 0
    least = 9e9                                   # least (arc in the target wedge) / (depth of z inside the neighbour's unit circle)
    for z in grid(0, eta, nr=20, na=180):
        a1, am = arcs(z, 1, kappa)[tp], arcs(z, -1, kappa)[tm]
        if dist(z, Y(1)) < 1:
            in1 += 1
            miss1 += a1 <= 1e-12
        if dist(z, Y(-1)) < 1:
            inm += 1
            missm += am <= 1e-12
        if wedge(z, 0) == 4:
            lens += 1
            miss_a += a1 <= 1e-12
            miss_b += am <= 1e-12
            least = min(least, a1 / (1 - dist(z, Y(1))), am / (1 - dist(z, Y(-1))))
    # (W) at y_1: the chart Z(psi_2 + t, d) against distances; far = d < t < 0, cw = t < 0, t < d; ccw = t > 0, t > d; lens = 0 < t < d
    mism = n = 0
    for i in range(-20, 21):
        for j in range(-20, 21):
            t, d = 0.004 * i + 0.0013, 0.004 * j + 0.0007
            al = PSI + 2 * math.pi / 3 + t
            z = (math.cos(al) + math.cos(al - 2 * math.pi / 3 - d), math.sin(al) + math.sin(al - 2 * math.pi / 3 - d))
            if d < t < 0:
                want = 1
            elif 0 < t < d:
                want = 4
            elif t < 0:
                want = 0 if d < 0 else 5
            else:
                want = 2 if d < 0 else 3
            n += 1
            mism += wedge(z, 1) != want
    print(f"lens-points={lens} missing-the-wedge-at-y1={miss_a} missing-the-wedge-at-y-1={miss_b} "
          f"points-inside-y1={in1} missing={miss1} points-inside-y-1={inm} missing={missm} "
          f"least-arc-over-depth={least:.0f} chart-samples={n} chart-mismatches={mism}")


# ------------------------------------------------------------------------------------------------ seeing
def frac(kf, wf, kt, wt, rho, kappa):
    """fraction of grid points of wedge wf at y_kf (radius < rho) whose unit circle meets wedge wt at y_kt in B(., kappa)."""
    tot = hit = 0
    for z in grid(kf, rho):
        if wedge(z, kf) == wf:
            tot += 1
            hit += arcs(z, kt, kappa)[wt] > 1e-12
    return hit / tot


def seeing():
    k1 = 2 if FAULT else 1
    full = {(0, 1): [], (1, 0): []}
    for (kf, kt), name in (((0, k1), (0, 1)), ((k1, 0), (1, 0))):
        for wf in range(6):
            for wt in range(6):
                if all(frac(kf, wf, kt, wt, kappa / 10, kappa) == 1.0 for kappa in (0.2, 0.05)):
                    full[name].append((wf, wt))
    def side(ws):
        return "+".join(sorted({WN[w] for w in ws}))
    fw = full[(0, 1)]
    A = sorted({a for a, b in fw if a in (2, 3, 4)}); B = sorted({b for a, b in fw if a in (2, 3, 4)})
    C = sorted({a for a, b in fw if a in (0, 1, 5)}); D = sorted({b for a, b in fw if a in (0, 1, 5)})
    prod = sorted(fw) == sorted([(a, b) for a in A for b in B] + [(a, b) for a in C for b in D])
    sym = sorted(full[(1, 0)]) == sorted((b, a) for a, b in fw)
    ks = (0.2, 0.05, 0.0125)                       # the size of the wedge seen; the points looking are within kappa/10
    s3 = [frac(k1, 4, 0, 2, kappa / 10, kappa) for kappa in ks]     # lens at y_1 -> O_ccw at y_0   (the search's step 3)
    s4 = [frac(k1, 1, 0, 1, kappa / 10, kappa) for kappa in ks]     # far at y_1  -> far at y_0     (the search's step 4)
    print(f"full-pairs={len(fw)} [{side(A)}]x[{side(B)}] and [{side(C)}]x[{side(D)}] product={prod} same-pairs-back={sym} "
          f"lens1-seeing-Occw0={s3[0]:.3f},{s3[1]:.3f},{s3[2]:.3f} far1-seeing-far0={s4[0]:.3f},{s4[1]:.3f},{s4[2]:.3f}")


# ------------------------------------------------------------------------------------------------ sides
def pattern(qs):
    """for witness points qs (one per edge): the string of sides at y_0..y_5: O outer-pure only, I inner-pure only, B both, - none."""
    s = ""
    for k in range(6):
        o = sum(dist(q, Y(k)) < 1 - 1e-12 for q in qs)
        i = sum(dist(q, Y(k)) > 1 + 1e-12 for q in qs)
        s += "B" if o >= 2 and i >= 2 else "O" if o >= 2 else "I" if i >= 2 else "-"
    return s


def sides():
    rad = 1.5 if FAULT else 0.1
    n = 36
    cons = alt = other = 0
    for i, j, l in itertools.product(range(n), repeat=3):
        qs = [(rad * math.cos(2 * math.pi * (m + 0.31) / n), rad * math.sin(2 * math.pi * (m + 0.31) / n)) for m in (i, j, l)]
        p = pattern(qs)
        if any(p == ("OOOIII" * 2)[r:r + 6] for r in range(6)):
            cons += 1
        elif p in ("OIOIOI", "IOIOIO"):
            alt += 1
        else:
            other += 1
    far = pattern([(3 * math.cos(t), 3 * math.sin(t)) for t in (0.4, 2.5, 4.6)])
    one = pattern([(1.5, 0.0), (1.4, 0.0), (3.0, 0.0)])
    # sets of outer-pure ring points with no point whose two neighbours are both outer-pure and inner-pure excluded:
    # by (i), a set with two members at cyclic distance 2 forces the point between to be outer-pure; closed sets without three in a row:
    left = [S for r in range(7) for S in itertools.combinations(range(6), r)
            if not any(((a - b) % 6) in (2, 4) for a in S for b in S)]
    print(f"near-witness-triples={n ** 3} three-in-a-row={cons} alternating={alt} other={other} "
          f"far-witnesses={far} one-outer={one} outer-sets-left-open={len(left)}")


# ------------------------------------------------------------------------------------------------ model
def model():
    d = json.loads((ROOT / "data/search/2026-10-07/KEEP-turning-4label-arcs.json").read_text())
    ring = [list(r) for r in d["ring"]]
    if FAULT:
        ring[1][4] = 1
    pos, posn, neg, negn = (2, 3, 4), (1, 2, 3), (0, 1, 5), (4, 5, 0)
    pairs = bad = 0
    for k in range(6):
        a, b = ring[k], ring[(k + 1) % 6]
        for A, B in ((pos, posn), (neg, negn)):
            for i in A:
                for j in B:
                    pairs += 1
                    bad += a[i] == b[j]
    labs = ["".join(str(v) for v in sorted(set(r))) for r in ring]
    posed = [k for k in range(6) if {0, 1, 2} <= set(ring[k]) and len(set(ring[k])) == 4]
    lensT = [k for k in range(6) if ring[k][4] >= 3]
    # the interfaces of the x flower and the sides
    x, K = d["x"], d["K"]
    qs, on = [], []
    for j in range(12):
        if x[j - 1] != x[j]:
            ang = math.radians(30 * j)
            typ = K[(j - 1) // 2] if j % 2 else "S"
            if typ == "S":
                qs.append((0.1 * math.cos(ang), 0.1 * math.sin(ang)))
            else:
                k = ((30 * j - 90) // 60) % 6
                if typ == "B":
                    k = (k + 3) % 6
                yk = Y(k)
                best = None
                for sg in (1, -1):                       # the arc of the unit circle about y_k leaving x in direction ang
                    t = math.atan2(-yk[1], -yk[0]) + sg * 0.1
                    q = (yk[0] + math.cos(t), yk[1] + math.sin(t))
                    if best is None or q[0] * math.cos(ang) + q[1] * math.sin(ang) > best[0]:
                        best = (q[0] * math.cos(ang) + q[1] * math.sin(ang), q)
                qs.append(best[1])
                on.append(k)
    pat = pattern(qs)
    both = [k for k in range(6) if pat[(k - 1) % 6] in "OB" and pat[(k + 1) % 6] in "OB"]
    print(f"first-order-pairs={pairs} equal-labels={bad} labels={','.join(labs)} lens-in-T-at={lensT} "
          f"points-with-a-b-n-and-one-of-T={posed} interfaces-of-x={len(qs)} on-unit-circles-about={sorted(on)} sides={pat} "
          f"points-with-both-neighbours-outer-pure={both}")


# ------------------------------------------------------------------------------------------------ hexcross
def hexcross():
    R = 0.45 if FAULT else 0.5
    S3 = math.sqrt(3.0)
    A1, A2 = (S3 * R, 0.0), (S3 * R / 2, 1.5 * R)

    def centre(m, n):
        return (m * A1[0] + n * A2[0], m * A1[1] + n * A2[1])

    def hexcol(z):
        n0 = z[1] / A2[1]
        m0 = (z[0] - n0 * A2[0]) / A1[0]
        best = None
        for m in range(math.floor(m0) - 1, math.floor(m0) + 3):
            for n in range(math.floor(n0) - 1, math.floor(n0) + 3):
                dd = dist(z, centre(m, n))
                if best is None or dd < best[0]:
                    best = (dd, (3 * m + n) % 7)
        return best[1]

    verts = {}
    for m in range(-9, 10):
        for n in range(-9, 10):
            c = centre(m, n)
            for k in range(6):
                v = (c[0] + R * math.cos(math.pi / 2 + k * math.pi / 3), c[1] + R * math.sin(math.pi / 2 + k * math.pi / 3))
                if math.hypot(*v) < 3.2:
                    verts[(round(v[0], 6), round(v[1], 6))] = v
    vs = list(verts.values())
    typ = {v: frozenset(hexcol((v[0] + 0.02 * math.cos(a), v[1] + 0.02 * math.sin(a))) for a in [k * math.pi / 12 for k in range(24)])
           for v in vs}
    cross = own = samples = wrong = 0
    for xx in vs:
        if math.hypot(*xx) > 0.75:
            continue
        for yy in vs:
            D = dist(xx, yy)
            if D < 1e-9 or D >= 2 - 1e-9:
                continue
            mid = ((xx[0] + yy[0]) / 2, (xx[1] + yy[1]) / 2)
            h = math.sqrt(1 - D * D / 4)
            nx, ny = -(yy[1] - xx[1]) / D, (yy[0] - xx[0]) / D
            for sgn in (1, -1):
                w = (mid[0] + sgn * h * nx, mid[1] + sgn * h * ny)
                cross += 1
                seen = False
                for rr in (0.004, 0.008):
                    for a in [(k + 0.41) * math.pi / 60 for k in range(120)]:
                        z = (w[0] + rr * math.cos(a), w[1] + rr * math.sin(a))
                        lab = hexcol(z)
                        for c in (xx, yy):
                            if lab in typ[c]:
                                seen = True
                                samples += 1
                                wrong += dist(z, c) > 1          # a label of a vertex found OUTSIDE that vertex's unit circle
                own += seen
    print(f"radius={R} crossings={cross} crossings-with-an-own-label={own} own-label-samples={samples} "
          f"own-label-samples-outside-the-vertex's-unit-circle={wrong}")


{"shadow": shadow, "seeing": seeing, "sides": sides, "model": model, "hexcross": hexcross}[sys.argv[1]]()

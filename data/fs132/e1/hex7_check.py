#!/usr/bin/env python3
"""FS132-E1 — the two calibration colourings at seven, read against C132-EXT-DISC's conclusion. No search: colourings by
formula, sampled on sets fixed below.

  hex7_check.py model   [--fault]   the hexagonal seven-colouring (circumradius 2/5): at a vertex x, three labels, three
                                    edges K_j = edge ∩ B̄(x, 0.3); clause (3) on a grid sample of Δ(K_j); clause (4) on K_j.
                                    --fault: test the exclusion of the label NOT on the edge (must find violations).
  hex7_check.py islands [--fault]   the island colouring (EXT-OAI2-SLACK7-L): a disc of radius 1.05 free of islands and its
                                    vertex count; clause (4) for the straight 1-2 edge at the accumulation centre v; clauses
                                    (3), (4) for three continua at the isolated centre b+ of island 6.
                                    --fault: plant no islands (the plain hexagonal colouring).
"""
import sys, math

R = 0.4
S3 = math.sqrt(3.0)
U = (S3 * R, 0.0)
W = (S3 * R / 2, 1.5 * R)


def nearest(z):
    """lattice coordinates (m, n) of the hexagon holding z, and the margin to the next nearest centre"""
    b = z[1] / (1.5 * R)
    a = (z[0] - b * S3 * R / 2) / (S3 * R)
    best = []
    for m in (math.floor(a) - 1, math.floor(a), math.floor(a) + 1, math.floor(a) + 2):
        for n in (math.floor(b) - 1, math.floor(b), math.floor(b) + 1, math.floor(b) + 2):
            cx, cy = m * U[0] + n * W[0], m * U[1] + n * W[1]
            best.append((math.hypot(z[0] - cx, z[1] - cy), m, n))
    best.sort()
    return best[0][1], best[0][2], best[1][0] - best[0][0]


def hexcol(z):
    m, n, margin = nearest(z)
    return (m + 3 * n) % 7, margin


X = (0.0, R)                                   # a vertex: hexagons (0,0), (0,1), (-1,1) meet here
DA = (S3 / 2, -0.5)                            # edge between (0,0) [colour 0] and (0,1) [colour 3]
DB = (-S3 / 2, -0.5)                           # edge between (0,0) [0] and (-1,1) [2]
DC = (0.0, 1.0)                                # edge between (0,1) [3] and (-1,1) [2]
EDGES = [(DA, (0, 3), 2), (DB, (0, 2), 3), (DC, (3, 2), 0)]   # direction, its two labels, the third label


def seg_minmax(z, p, d, rho):
    t = max(0.0, min(rho, (z[0] - p[0]) * d[0] + (z[1] - p[1]) * d[1]))
    dmin = math.hypot(z[0] - p[0] - t * d[0], z[1] - p[1] - t * d[1])
    dmax = max(math.hypot(z[0] - p[0], z[1] - p[1]), math.hypot(z[0] - p[0] - rho * d[0], z[1] - p[1] - rho * d[1]))
    return dmin, dmax


def model(fault):
    rho, viol, nsamp, c4 = 0.3, 0, 0, True
    labels_at_x = {hexcol((X[0] + 1e-3 * math.cos(a), X[1] + 1e-3 * math.sin(a)))[0] for a in (-1.57, 0.52, 2.62)}
    for d, labs, third in EDGES:
        tested = (third,) if fault else labs
        for i in range(-70, 71):
            for j in range(-70, 71):
                z = (X[0] + 0.02 * i + 0.00123, X[1] + 0.02 * j + 0.00077)
                dmin, dmax = seg_minmax(z, X, d, rho)
                if dmin < 1 - 1e-9 and dmax > 1 + 1e-9:
                    col, margin = hexcol(z)
                    if margin > 1e-9:
                        nsamp += 1
                        viol += col in tested
        nrm = (-d[1], d[0])
        for s in range(1, 31):
            q = (X[0] + rho * s / 30 * d[0], X[1] + rho * s / 30 * d[1])
            sides = {hexcol((q[0] + e * nrm[0], q[1] + e * nrm[1]))[0] for e in (1e-6, -1e-6)}
            c4 = c4 and sides == set(labs)
    print(f"vertex-labels={len(labels_at_x)} edges={len(EDGES)} delta-samples={nsamp} violations={viol} clause4={c4}")


def islands(fault):
    ns = [] if fault else list(range(6, 41))

    def col(z):
        for n in ns:
            if math.hypot(z[0] - X[0] - 2.0 ** -n * DA[0], z[1] - X[1] - 2.0 ** -n * DA[1]) < 4.0 ** -n:
                return 2
        return hexcol(z)[0]

    # (i) a closed disc of radius 1.05 that meets no island, and its honeycomb vertices
    cen, rad = (X[0] + 1.2, X[1]), 1.05
    free = 1.2 - rad > 2.0 ** -6 + 4.0 ** -6
    verts = set()
    for m in range(-12, 13):
        for n in range(-12, 13):
            cx, cy = m * U[0] + n * W[0], m * U[1] + n * W[1]
            for k in range(6):
                v = (cx + R * math.cos(math.pi / 2 + k * math.pi / 3), cy + R * math.sin(math.pi / 2 + k * math.pi / 3))
                if math.hypot(v[0] - cen[0], v[1] - cen[1]) <= rad:
                    verts.add((round(v[0], 9), round(v[1], 9)))
    # (ii) clause (4) for the straight edge at the accumulation centre v = X: is every point of it in H_0 ∩ H_3?
    nrm = (-DA[1], DA[0])
    ts = [0.3 * s / 30 for s in range(1, 31)] + [2.0 ** -n for n in range(6, 12)]
    c4v = all({col((X[0] + t * DA[0] + e * nrm[0], X[1] + t * DA[1] + e * nrm[1])) for e in (1e-9, -1e-9)} == {0, 3}
              for t in ts)
    # (iii) the isolated centre b+ of island 6: the edge beyond it, and the two arcs of the island's boundary
    r6, rho = 4.0 ** -6, 0.0004
    c6 = (X[0] + 2.0 ** -6 * DA[0], X[1] + 2.0 ** -6 * DA[1])
    b = (c6[0] + r6 * DA[0], c6[1] + r6 * DA[1])
    phimax = 2 * math.asin(rho / (2 * r6))
    cont = [([(b[0] + rho * s / 200 * DA[0], b[1] + rho * s / 200 * DA[1]) for s in range(201)], (0, 3))]
    for sgn, labs in ((-1, (0, 2)), (1, (3, 2))):          # -nrm is the side of hexagon (0,0)
        cont.append(([(c6[0] + r6 * (math.cos(phimax * s / 200) * DA[0] + sgn * math.sin(phimax * s / 200) * nrm[0]),
                       c6[1] + r6 * (math.cos(phimax * s / 200) * DA[1] + sgn * math.sin(phimax * s / 200) * nrm[1]))
                      for s in range(201)], labs))
    viol, c4b = 0, True
    for pts, labs in cont:
        for a in range(720):
            th = (a + 0.37) * math.pi / 360
            for s in range(-4, 5):
                z = (b[0] + (1 + 0.2 * rho * s) * math.cos(th), b[1] + (1 + 0.2 * rho * s) * math.sin(th))
                ds = [math.hypot(z[0] - p[0], z[1] - p[1]) for p in pts]
                if min(ds) < 1 - 1e-7 and max(ds) > 1 + 1e-7:
                    viol += col(z) in labs
        for s in range(20, 200, 20):                       # clause (4): both labels on the two sides of the continuum
            p, q = pts[s], pts[s + 1]
            tx, ty = q[0] - p[0], q[1] - p[1]
            L = math.hypot(tx, ty)
            nx, ny = -ty / L, tx / L
            c4b = c4b and {col((p[0] + e * nx, p[1] + e * ny)) for e in (1e-9, -1e-9)} == set(labs)
    print(f"island-free-disc={free} vertices-in-disc={len(verts)} clause4-at-v={c4v} clause3-at-b={viol} clause4-at-b={c4b}")


if __name__ == "__main__":
    fault = "--fault" in sys.argv
    {"model": model, "islands": islands}[sys.argv[1]](fault)

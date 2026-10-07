#!/usr/bin/env python3
"""FS132-E5 — the hexagonal seven-colouring (circumradius 2/5) and the two slack colourings at seven, read for margins.
No search: colourings by formula, sampled on sets fixed below. The colouring and the vertex X are those of
data/fs132/e1/hex7_check.py (label (m + 3n) mod 7 on the hexagon with lattice coordinates (m, n); X = (0, 2/5) is a vertex
of the hexagons of labels 0, 3, 2; the edge between labels 3 and 2 leaves X in the direction (0, 1)).

  margin_check.py witness [--fault]  for the plain, island and stripe colourings and 13 points p within 0.01 of X: the labels
                                     seen on the annulus 0.988 <= |z - p| <= 1.012 (7 radii x 3600 angles). The three vertex
                                     labels must not occur. --fault: the 13 points are taken about the centre of a hexagon.
  margin_check.py grundy  [--fault]  (a) the hexagons of label 0 thickened by mu = 0.016: unit pairs between 60 points at
                                     mu/2 outside the hexagon (0,0) and the thickened class (3600 angles each);
                                     (b) the labels on the unit circle about a point of island 6 and about a point of the
                                     label-3 hexagon near X, in the island colouring. --fault: mu = 0.1.
"""
import sys, math

R, S3 = 0.4, math.sqrt(3.0)
U, W = (S3 * R, 0.0), (S3 * R / 2, 1.5 * R)
X = (0.0, R)
VLAB = (0, 3, 2)

def hexcol(z):
    b = z[1] / (1.5 * R); a = (z[0] - b * S3 * R / 2) / (S3 * R)
    best = None
    for m in range(math.floor(a) - 1, math.floor(a) + 3):
        for n in range(math.floor(b) - 1, math.floor(b) + 3):
            d = math.hypot(z[0] - m * U[0] - n * W[0], z[1] - m * U[1] - n * W[1])
            if best is None or d < best[0]:
                best = (d, m, n)
    return (best[1] + 3 * best[2]) % 7

def island(z):
    """discs of label 0 on the 3-2 edge: centre X + 2^-n (0,1), radius 4^-n, n >= 6"""
    dx, dy = z[0] - X[0], z[1] - X[1]
    if 0 < dy < 0.03 and abs(dx) < 0.001:
        n = max(6, round(-math.log2(dy)))
        for k in (n - 1, n, n + 1):
            if k >= 6 and math.hypot(dx, dy - 2.0 ** -k) < 4.0 ** -k:
                return 0
    return hexcol(z)

XS = (X[0] + 1.0, X[1])                          # the stripe colouring's centre: |XS - X| = 1
def stripe(z):
    if math.hypot(z[0] - X[0], z[1] - X[1]) < 0.03:
        rho = math.hypot(z[0] - XS[0], z[1] - XS[1])
        if rho > 1.0:
            n = math.floor(-math.log2(rho - 1.0))
            theta = math.atan2(z[1] - XS[1], z[0] - XS[0]) % (2 * math.pi)
            return VLAB[math.floor(3 * 2 ** n * theta) % 3]
    return hexcol(z)

def witness(fault):
    base = (0.0, 0.0) if fault else X
    pts = [base] + [(base[0] + r * math.cos(a), base[1] + r * math.sin(a))
                    for r in (0.005, 0.01) for a in (0.3, 1.35, 2.4, 3.45, 4.5, 5.55)]
    own, seen, ns = 0, set(), 0
    for col in (hexcol, island, stripe):
        for p in pts:
            for j in range(7):
                rad = 0.988 + 0.004 * j
                for t in range(3600):
                    a = 2 * math.pi * (t + 0.37) / 3600
                    lab = col((p[0] + rad * math.cos(a), p[1] + rad * math.sin(a)))
                    ns += 1; seen.add(lab); own += lab in VLAB
    print(f"colourings=3 points={len(pts)} samples={ns} vertex-labels-on-annulus={own} labels-seen={''.join(map(str, sorted(seen)))}")

def grundy(fault):
    mu = 0.1 if fault else 0.016
    def thick(z):
        if hexcol(z) == 0:
            return True
        return any(hexcol((z[0] + mu * math.cos(2 * math.pi * s / 12), z[1] + mu * math.sin(2 * math.pi * s / 12))) == 0
                   for s in range(12))
    pairs = 0
    for s in range(60):
        a = 2 * math.pi * (s + 0.5) / 60
        # the boundary point of the hexagon (0,0) in direction a (pointy-top, apothem R*sqrt(3)/2), pushed out by mu/2
        rb = (R * S3 / 2) / math.cos(((a + math.pi / 6) % (math.pi / 3)) - math.pi / 6)
        y = ((rb + mu / 2) * math.cos(a), (rb + mu / 2) * math.sin(a))
        assert hexcol(y) != 0
        for t in range(3600):
            b = 2 * math.pi * (t + 0.37) / 3600
            pairs += thick((y[0] + math.cos(b), y[1] + math.sin(b)))
    m1, m2 = 0.8 + 2 * mu < 1, (math.sqrt(21) - 2) * 0.4 - 2 * mu > 1
    def ring(y):
        return ''.join(map(str, sorted({island((y[0] + math.cos(2 * math.pi * (t + 0.37) / 3600),
                                                y[1] + math.sin(2 * math.pi * (t + 0.37) / 3600))) for t in range(3600)})))
    y_island = (X[0] + 0.0001, X[1] + 2.0 ** -6); y_tile = (X[0] + 0.005, X[1] + 0.004)
    assert island(y_island) == 0 and island(y_tile) == 3
    print(f"thickened-unit-pairs={pairs} margins={m1},{m2} ring-labels-at-island-point={ring(y_island)} ring-labels-at-tile-point={ring(y_tile)}")

if __name__ == "__main__":
    {"witness": witness, "grundy": grundy}[sys.argv[1]]("--fault" in sys.argv)

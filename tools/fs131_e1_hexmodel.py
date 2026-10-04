#!/usr/bin/env python3
"""fs131_e1_hexmodel.py — FS131-E1: a model check of L-SEE and L-CROSS on the standard hexagonal 7-colouring.

The model: closed regular hexagons of circumradius s = 0.45 (diameter 0.9 < 1), centred on the triangular lattice
Λ = { i·a + j·b }, a = (√3 s, 0), b = (√3 s/2, 3s/2), coloured c(i, j) = (i + 3j) mod 7. Same-coloured centres are at
distance √21·s ≈ 2.06, so same-coloured hexagons are more than 1 apart: the colouring is proper everywhere, hence
almost-everywhere proper, and it is an arc map (segments) in normal form at its vertices (three sectors of 2π/3).

P is the vertex shared by the hexagons at (0,0), (1,0), (0,1). For Y = P + e(ψ), ψ = 2πm/M, the check reads:
  L-SEE   — the colours of the regions at Y (hexagons met by a small circle about Y) avoid the colours of the region
            points of ω(Y) near P (two points on each branch of ω(Y) at P);
  L-CROSS — when the points Y − δe(ψ) (inside ω(P)) and Y + δe(ψ) (outside) lie in one hexagon, that hexagon's colour
            is none of P's three sector colours.
A point's hexagon is its nearest centre, accepted only when the nearest centre beats the second by a margin (1e-7 in
distance); a sample with an ambiguous point is skipped and counted, so the run prints a positive signal for what it
checked. Floats with margins: a model check, not a certificate.

--fault uses c(i, j) = (i + 2j) mod 7, which is proper on adjacent hexagons but puts one colour on hexagons √3·(√3 s)
= 1.35 apart centre to centre, two hexagons that are 0.78 apart across the one between them: not almost-everywhere
proper. The check must report violations there.
Also printed (E1-BAD on the model): two_sector, the number of Y whose two branches of ω(Y) near P meet two different
sectors of P (straight edges, angles 2π/3: every Y is non-exceptional, so all of them).
"""
import math, sys

S = 0.45
A = (math.sqrt(3) * S, 0.0)
B = (math.sqrt(3) * S / 2, 1.5 * S)
FAULT = "--fault" in sys.argv


def colour(i, j):
    return (i + (2 if FAULT else 3) * j) % 7


def centre(i, j):
    return (i * A[0] + j * B[0], i * A[1] + j * B[1])


def hexagon(p):
    """(i, j) of the nearest lattice centre, or None when the nearest two are within the margin."""
    x, y = p
    jf = y / B[1]
    i_f = (x - jf * B[0]) / A[0]
    best = []
    for i in range(math.floor(i_f) - 2, math.floor(i_f) + 4):
        for j in range(math.floor(jf) - 2, math.floor(jf) + 4):
            cx, cy = centre(i, j)
            best.append((math.hypot(x - cx, y - cy), i, j))
    best.sort()
    if best[1][0] - best[0][0] < 1e-7:
        return None
    return best[0][1], best[0][2]


def main():
    c0, c1, c2 = centre(0, 0), centre(1, 0), centre(0, 1)
    P = ((c0[0] + c1[0] + c2[0]) / 3, (c0[1] + c1[1] + c2[1]) / 3)
    p_cols = {colour(0, 0), colour(1, 0), colour(0, 1)}
    assert len(p_cols) == 3, "P must have three distinct sector colours"
    M = 3600
    see_checked = see_viol = cross_checked = cross_viol = skipped = two_sector = 0
    for m in range(M):
        psi = 2 * math.pi * m / M
        Y = (P[0] + math.cos(psi), P[1] + math.sin(psi))
        # colours of the regions at Y
        at_Y, amb = set(), False
        for k in range(24):
            th = 2 * math.pi * (k + 0.5) / 24
            h = hexagon((Y[0] + 1e-5 * math.cos(th), Y[1] + 1e-5 * math.sin(th)))
            if h is None:
                amb = True
                break
            at_Y.add(colour(*h))
        # colours of region points of ω(Y) near P: Y + e(ψ + π ± φ), small φ
        seen, branch = set(), {1: set(), -1: set()}
        for phi in (1e-3, 2e-3, -1e-3, -2e-3):
            q = (Y[0] + math.cos(psi + math.pi + phi), Y[1] + math.sin(psi + math.pi + phi))
            h = hexagon(q)
            if h is None:
                amb = True
                break
            seen.add(colour(*h))
            branch[1 if phi > 0 else -1].add(colour(*h))
        if amb:
            skipped += 1
            continue
        see_checked += 1
        if len(branch[1]) == 1 and len(branch[-1]) == 1 and branch[1] != branch[-1]:
            two_sector += 1
        if at_Y & seen:
            see_viol += 1
        # L-CROSS
        d = 1e-6
        hi = hexagon((Y[0] - d * math.cos(psi), Y[1] - d * math.sin(psi)))
        ho = hexagon((Y[0] + d * math.cos(psi), Y[1] + d * math.sin(psi)))
        if hi is not None and hi == ho:
            cross_checked += 1
            if colour(*hi) in p_cols:
                cross_viol += 1
    print(f"see_checked={see_checked} two_sector={two_sector} see_violations={see_viol} cross_checked={cross_checked} "
          f"cross_violations={cross_viol} skipped={skipped}")


if __name__ == "__main__":
    main()

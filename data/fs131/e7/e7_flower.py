#!/usr/bin/env python3
"""FS131-E7 §§ 3-5: the four-petal flower F0 (ArcMap 6 on B(0, 5/4)) and F1 = F0 with one rectangle recoloured.

Nothing here searches: both maps are given by formula and each mode checks a derived claim.

  exact   the constants the hand argument uses, in exact arithmetic (sympy): signs of the margins
  valid   random unit pairs (z, z + e(phi)) in the domain: none may be monochromatic        [control of § 3.2, § 4.1]
  ring    the hypotheses read on the ring of 0: colours at 0, where a and b are carried, Gamma on the ring
  orbit   F1: the change point at 1, its 60-degree orbit, the centres of the map's unit arcs  [Q2, Q3a, Q3c]

Planted faults: --plant-wide (the outer a/b windows 31 degrees wide in place of 22.5: an outer tile of diameter above 1),
--plant-cell (the cell moved 12 degrees clockwise, within 60 degrees of the b-tile at 270), --plant-swap (outside the ring
the gap windows take the other absent colour, so every gap stretch of the ring carries both a and b: covering pairs).
"""
import sys, math
import numpy as np

ARGS = set(sys.argv[2:])
HW = 31.0 if "--plant-wide" in ARGS else 22.5          # half-width in degrees of the outer a/b windows
CELL_IM = (-0.26, -0.21) if "--plant-cell" in ARGS else (-0.05, 0.0)
SWAP = "--plant-swap" in ARGS
R_DOM = 1.25
A, B = 4, 5

def e(deg):
    return np.exp(1j * np.deg2rad(deg))

def col0(z):
    """Colour of F0 at z (array of complex); -1 outside the domain."""
    z = np.asarray(z, dtype=complex)
    r = np.abs(z)
    th = np.mod(np.rad2deg(np.angle(z)), 360.0)
    m = np.rint(th / 90.0).astype(int)                 # nearest axis 90m
    phi = th - 90.0 * m
    j = np.floor(th / 90.0).astype(int) % 4            # quadrant
    u = e(90.0 * j + 15.0); w = e(90.0 * j + 75.0)
    petal = (np.abs(z - u) < 1.0) & (np.abs(z - w) < 1.0)
    gap = A + (m % 2)
    inner = np.where(petal, j, gap)
    outer = np.where(np.abs(phi) < HW, (A + ((m + 1) % 2)) if SWAP else gap, (j + 2) % 4)
    c = np.where(r < 1.0, inner, outer)
    return np.where(r < R_DOM, c, -1)

def col1(z):
    """F1: F0 with the open rectangle 19/20 < Re < 21/20, -1/20 < Im < 0 recoloured b."""
    z = np.asarray(z, dtype=complex)
    c = col0(z)
    cell = (z.real > 0.95) & (z.real < 1.05) & (z.imag > CELL_IM[0]) & (z.imag < CELL_IM[1])
    return np.where(cell & (c >= 0), B, c)

def unit_pairs(col, n, rng, rlo=0.0, rhi=R_DOM):
    r = np.sqrt(rng.uniform(rlo * rlo, rhi * rhi, n)); t = rng.uniform(0, 2 * np.pi, n)
    z = r * np.exp(1j * t)
    w = z + np.exp(1j * rng.uniform(0, 2 * np.pi, n))
    ok = np.abs(w) < R_DOM
    cz, cw = col(z[ok]), col(w[ok])
    return int(ok.sum()), int((cz == cw).sum())

def mode_valid():
    out = []
    for name, col in (("F0", col0), ("F1", col1)):
        rng = np.random.default_rng(20261006)
        tot = bad = 0
        for (lo, hi) in ((0.0, R_DOM), (0.85, R_DOM), (0.0, 0.6), (0.93, 1.07)):
            for _ in range(3):
                a, b = unit_pairs(col, 1_000_000, rng, lo, hi); tot += a; bad += b
        out.append(f"{name}: unit pairs {tot // 1000}k monochromatic {'0' if bad == 0 else 'SOME'}")
    print(" | ".join(out))

def mode_ring():
    col = col1 if "--f1" in ARGS else col0
    eps = 1e-6
    c0 = sorted(set(col(1e-3 * e(np.arange(0, 360, 0.25) + 0.123)).tolist()))
    th = np.arange(0, 360, 0.01) + 0.005
    inner, outer, on = col((1 - eps) * e(th)), col((1 + eps) * e(th)), col(e(th))
    a_set = (inner == A) | (outer == A); b_set = (inner == B) | (outer == B)
    both = int((a_set & b_set).sum())
    gamma = float((inner != outer).sum()) * 0.01
    def gap(sa, sb):                                   # least angular distance between the two sets, in degrees
        ta, tb = th[sa], th[sb]
        if len(ta) == 0 or len(tb) == 0: return float("inf")
        d = np.abs(ta[:, None] - tb[None, ::7]); d = np.minimum(d, 360 - d)
        return float(d.min())
    g = gap(a_set, b_set)
    print(f"colours at 0: {c0}; ring angles carrying both a and b: {both}; "
          f"least angle between a-carrying and b-carrying ring points: {g:.1f}; Gamma on the ring: {gamma:.0f} deg")

def mode_orbit():
    # F1 at v = 0, psi = 0: germs at the change point 1; the orbit e(60 j); centres of the unit arcs of the map
    t = 1e-4
    ccw, cw = int(col1(np.array([e(np.rad2deg(t))]))[0]), int(col1(np.array([e(-np.rad2deg(t))]))[0])
    centres = [0j] + [complex(e(90.0 * j + 15.0)) for j in range(4)] + [complex(e(90.0 * j + 75.0)) for j in range(4)]
    orbit = [complex(e(60.0 * j)) for j in range(6)]
    dmin = min(abs(c - y) for c in centres for y in orbit)
    eps = 1e-6
    on_ring_arc = [j for j in range(6) if col1(np.array([(1 - eps) * orbit[j]]))[0] != col1(np.array([(1 + eps) * orbit[j]]))[0]]
    y = e(-60.0)
    i_col, o_col = int(col1(np.array([(1 - eps) * y]))[0]), int(col1(np.array([(1 + eps) * y]))[0])
    print(f"germs at 1: ccw {ccw}, cw {cw}; least distance from an orbit point to the centre of a unit arc of the map: {dmin:.3f}; "
          f"orbit points on a ring arc of Gamma: {on_ring_arc}; at e(-60): inner {i_col}, outer {o_col}")

def mode_exact():
    import sympy as sp
    s15 = sp.sin(sp.pi / 12); rho0 = 2 * s15
    rows = [
        ("apex radius rho0 = 2 sin 15 = (sqrt6 - sqrt2)/2", sp.simplify(rho0 - (sp.sqrt(6) - sp.sqrt(2)) / 2) == 0),
        ("opposite gap tiles: 2 rho0 - 1 > 0", sp.simplify(2 * rho0 - 1) > 0),
        ("outer tile, window of half-width HW at radius 5/4: 1 - (5/2) sin HW > 0",
         (1 - sp.Rational(5, 2) * sp.sin(sp.rad(sp.Rational(int(HW * 10), 10)))) > 0),
        ("gap tile's hull, corner (1/2, -(1/2)tan 22.5) to (5/4)e(22.5): below 1",
         sp.sqrt((sp.Rational(5, 4) * sp.cos(sp.pi / 8) - sp.Rational(1, 2)) ** 2
                 + (sp.Rational(5, 4) * sp.sin(sp.pi / 8) + sp.tan(sp.pi / 8) / 2) ** 2) < 1),
        ("petal against its outer tile: cos 112.5 < 0", sp.cos(5 * sp.pi / 8) < 0),
        ("the ray at 90j leaves the petal at rho0 < 1", rho0 < 1),
        ("b-tiles are at least sqrt(2 - 2 cos 67.5) from 1, and 3 - sqrt 3 >= 2 - 2 cos 67.5",
         (3 - sp.sqrt(3)) - (2 - 2 * sp.cos(3 * sp.pi / 8)) > 0),
        ("cell in B(1, sqrt2/20) against the b-tiles: sqrt(2 - 2 cos 67.5) - sqrt2/20 > 1",
         sp.sqrt(2 - 2 * sp.cos(3 * sp.pi / 8)) - sp.sqrt(2) / 20 - 1 > 0),
    ]
    bad = [n for n, v in rows if v is not sp.true and v is not True]
    for n, v in rows: print(("ok   " if (v is sp.true or v is True) else "FAIL ") + n)
    print(f"exact margins: {len(rows) - len(bad)} of {len(rows)} hold")

if __name__ == "__main__":
    {"valid": mode_valid, "ring": mode_ring, "orbit": mode_orbit, "exact": mode_exact}[sys.argv[1]]()

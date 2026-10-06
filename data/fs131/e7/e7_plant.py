#!/usr/bin/env python3
"""FS131-E7 §§ 6-7: the two planted pictures, checked numerically on their own formulas (no search: every set is given
by inequalities, every witness by a closed formula).  Coordinates are relative to the vertex v; N = v + i, S' = v - i.

  q4   the doubly shadowed band under Condition 5 (flanks of curvature 1/2..3/4 and -3/4..-1/2 at v; the g-source a horn
       of curvatures 1/10..1/5 at S', the h-source its mirror at N; band -1/8..1/8)
  q5   the planted bowtie (G_v, H_v, C_v in B(v, 1/10); quarter-disc wedges of slope 1 in B(N, 1/20) and B(S', 1/20))

Planted faults: q4 --plant-curv (the g-source's upper curvature 2/3 in place of 1/5: its shadow reaches the g-flank),
q4 --plant-band (the band moved to curvatures 1/4..3/8, above the g-shadow); q5 --plant-wedge (wedges of slope 1/50).
"""
import sys
import numpy as np

ARGS = set(sys.argv[2:])
rng = np.random.default_rng(20261006)

def arc_pt(x, kappa):
    """The point of abscissa x on the circle through 0 tangent to the x-axis with upward curvature kappa (kappa != 0)."""
    return x + 1j * (1 - np.sqrt(1 - (kappa * x) ** 2)) / kappa

def tan_height(kappa, w):
    return w.imag - kappa * (w.real ** 2 + w.imag ** 2) / 2

def mode_q4():
    tg_hi = 2 / 3 if "--plant-curv" in ARGS else 1 / 5
    band = (1 / 4, 3 / 8) if "--plant-band" in ARGS else (-1 / 8, 1 / 8)
    n = 2000
    # the g-flank at v and the g-source at S' = -i
    zf = arc_pt(rng.uniform(1e-4, 0.07, n), rng.uniform(0.5, 0.75, n)); zf = zf[np.abs(zf) < 0.1]
    ps = -1j + arc_pt(rng.uniform(1e-4, 0.045, n), rng.uniform(0.1, tg_hi, n)); ps = ps[np.abs(ps + 1j) < 0.05]
    d = np.abs(zf[:, None] - ps[None, :])
    below = int((d < 1).sum())
    chain_ok = bool((np.abs(zf - 4j) < 4).all() and (np.abs(ps - 4j) > 5).all()) if tg_hi == 1 / 5 else False
    # the band at v: each point gets the g-source point p+ on the circle of curvature 1/6 at S' (centre 5i, radius 6)
    m = 20000
    zb = arc_pt(rng.uniform(1e-5, 0.02, m), rng.uniform(band[0], band[1], m) + 1e-9)
    good = 0
    for sign, col in ((+1, "g"), (-1, "h")):
        z = zb if sign > 0 else np.conj(zb)                     # the h-half is the mirror image
        dd = np.abs(z - 5j)
        ok = (dd > 5) & (dd < 7)
        with np.errstate(invalid="ignore"):
            delta = np.arccos(np.clip((dd ** 2 + 35) / (12 * dd), -1, 1))
        psi = np.arctan2(z.real, 5 - z.imag) + delta
        p = 5j + 6 * (np.sin(psi) - 1j * np.cos(psi))
        w = p + 1j                                              # frame at S'
        ok &= np.abs(np.abs(z - p) - 1) < 1e-12
        ok &= (w.real > 0) & (np.abs(w) < 0.05) & (tan_height(0.1, w) > 0) & (tan_height(0.2, w) < 0)
        good += int(ok.sum())
    print(f"q4: flank-source pairs closer than 1: {below} of {d.size}; concentric chain |z-4i|<4<5<|p-4i|: {chain_ok}; "
          f"band points with a g-source and an h-source at distance exactly 1: {good} of {2 * m}")

def mode_q5():
    s = 0.02 if "--plant-wedge" in ARGS else 1.0
    n = 3000
    def disc(c, r, k):
        rr = r * np.sqrt(rng.uniform(0, 1, k)); t = rng.uniform(0, 2 * np.pi, k)
        return c + rr * np.exp(1j * t)
    zv = disc(0, 0.1, 4 * n)
    Gv = zv[np.abs(zv - 1j) < 1]
    Cv = zv[(np.abs(zv - 1j) > 1) & (np.abs(zv + 1j) > 1)]
    wN = disc(0, 0.05, 4 * n)
    DN = 1j + wN[wN.imag < -s * np.abs(wN.real)]                # the g-wedge at N, pointing at v
    UN = 1j + wN[wN.imag > s * np.abs(wN.real)]                 # the c-wedge at N, pointing away
    # boundary-heavy samples: points just inside omega(N) (in G_v) and just outside it (in C_v), where the margins are least
    xs = rng.uniform(-0.099, 0.099, n); arc = 1 - np.sqrt(1 - xs ** 2)
    Gv = np.concatenate([Gv, xs + 1j * arc * (1 + 1e-9) + 1e-12j])
    Cv = np.concatenate([Cv, xs + 1j * arc * (1 - 1e-9) - 1e-12j])
    Gv = Gv[(np.abs(Gv) < 0.1) & (np.abs(Gv - 1j) < 1)]
    Cv = Cv[(np.abs(Cv) < 0.1) & (np.abs(Cv - 1j) > 1) & (np.abs(Cv + 1j) > 1)]
    g_far = int((np.abs(Gv[:, None] - DN[None, :]) >= 1).sum())
    c_near = int((np.abs(Cv[:, None] - UN[None, :]) <= 1).sum())
    # every point of the right horn is at distance exactly 1 from a point of the g-wedge and from a point of the h-wedge
    m = 20000
    x = rng.uniform(1e-4, 0.05, m); z = arc_pt(x, rng.uniform(-0.999, 0.999, m))
    beta_g = (1 - np.sqrt(1 - z.real ** 2)) - z.imag          # q = N - i beta_g
    beta_h = z.imag + (1 - np.sqrt(1 - z.real ** 2))          # q = S' + i beta_h
    ok = (beta_g > 0) & (beta_g < 0.05) & (beta_h > 0) & (beta_h < 0.05)
    ok &= np.abs(np.abs(z - (1j - 1j * beta_g)) - 1) < 1e-12
    ok &= np.abs(np.abs(z - (-1j + 1j * beta_h)) - 1) < 1e-12
    print(f"q5: g pairs (flank, wedge at N) at distance 1 or more: {g_far}; c pairs (horn, wedge at N) at distance 1 or less: {c_near}; "
          f"horn points shadowed by the g-wedge and by the h-wedge: {int(ok.sum())} of {m}")

if __name__ == "__main__":
    {"q4": mode_q4, "q5": mode_q5}[sys.argv[1]]()

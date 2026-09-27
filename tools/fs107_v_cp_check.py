#!/usr/bin/env python3
"""FS107-V: numerical check of the exclusion lemma behind R's Lemma CP (FS-107), on explicit configurations.

What it checks (a derived claim on given objects; no search):
  Two junctions u, v of complementary colour types {1,2,3}, {4,5,6}, each an annulus B(c, s) minus B(c, r) cut into
  angular sectors that are filled by one colour each. For a point z, colour j is *excluded* at z when some point of j's
  sector is at distance exactly 1 from z (the sector is connected, so this is  mindist_j(z) < 1 < maxdist_j(z)).
  Band-properness at any eps >= 0 forces every excluded point off colour j (up to a null set), so the set F of points
  excluded from all six colours is uncovered in EVERY band-proper colouring containing the sectors, and conversely the
  local colouring (sectors + every other point near w coloured by a colour not excluded there) is band-proper for small
  eps. So area(F ∩ B(w, rho)) is exactly the least hole area near w that the two junctions force (the eps -> 0 value).

  It reports that area beside R's claimed bound (t1 - 2r)(t1' - 2r'), t1 = s sin(mu/2)/3, and the linear-projection
  "blocking" length, for configurations named on the command line.

Grade of its numbers: [tools, float64 grid integration], checked at two grid resolutions. The min/max distances are closed
forms, checked against brute-force sampling of the sector (the faithful stub); `--plant` breaks the closed-form max
distance and the self-test must go red for that reason.

Usage:  python3 tools/fs107_v_cp_check.py            (self-test, then every configuration)
        python3 tools/fs107_v_cp_check.py --plant    (self-test must FAIL on the planted max-distance fault)
"""
from __future__ import annotations

import math
import sys

import numpy as np

PLANT = "--plant" in sys.argv


def _wrap(x):
    """Angle to (-pi, pi]."""
    return (x + np.pi) % (2 * np.pi) - np.pi


class Sector:
    """Annular sector {c + rho*e^{i th} : r <= rho <= s, th in [a, a + w]}, 0 < w < 2 pi."""

    def __init__(self, c, r, s, a, w):
        assert 0 <= r < s and 0 < w < 2 * math.pi
        self.c = np.asarray(c, float)
        self.r, self.s, self.a, self.w = r, s, a, w

    def _in_range(self, phi):
        return _wrap(phi - self.a) % (2 * np.pi) <= self.w

    def mindist(self, px, py):
        x, y = px - self.c[0], py - self.c[1]
        R = np.hypot(x, y)
        phi = np.arctan2(y, x)
        inside = self._in_range(phi)
        d_in = np.abs(R - np.clip(R, self.r, self.s))
        best = np.full_like(R, np.inf)
        for th in (self.a, self.a + self.w):
            ex, ey = math.cos(th), math.sin(th)
            t = np.clip(x * ex + y * ey, self.r, self.s)
            best = np.minimum(best, np.hypot(x - t * ex, y - t * ey))
        return np.where(inside, d_in, best)

    def maxdist(self, px, py):
        x, y = px - self.c[0], py - self.c[1]
        phi = np.arctan2(y, x)
        best = np.zeros_like(x)
        rhos = (self.s,) if PLANT else (self.r, self.s)  # PLANT drops the inner radius (wrong when r is large)
        thetas = [np.full_like(x, self.a), np.full_like(x, self.a + self.w)]
        anti = phi + np.pi
        anti_ok = self._in_range(anti)
        for rho in rhos:
            for th in thetas:
                best = np.maximum(best, np.hypot(x - rho * np.cos(th), y - rho * np.sin(th)))
            d_anti = np.hypot(x - rho * np.cos(anti), y - rho * np.sin(anti))
            best = np.where(anti_ok, np.maximum(best, d_anti), best)
        return best

    def brute(self, px, py, n=500):
        rho = np.linspace(self.r, self.s, n)
        th = self.a + np.linspace(0, self.w, n)
        RR, TT = np.meshgrid(rho, th)
        sx = self.c[0] + (RR * np.cos(TT)).ravel()
        sy = self.c[1] + (RR * np.sin(TT)).ravel()
        d = np.hypot(sx[None, :] - px[:, None], sy[None, :] - py[:, None])
        return d.min(axis=1), d.max(axis=1)

    def linear_projection(self, e):
        """(min, max) of (a - c).e over the sector, e a unit vector (exact: extreme at corners or at th = arg e)."""
        vals = []
        for rho in (self.r, self.s):
            for th in (self.a, self.a + self.w):
                vals.append(rho * (math.cos(th) * e[0] + math.sin(th) * e[1]))
            for tgt in (math.atan2(e[1], e[0]), math.atan2(-e[1], -e[0])):
                if self._in_range(np.array(tgt)):
                    vals.append(rho * (math.cos(tgt) * e[0] + math.sin(tgt) * e[1]))
        return min(vals), max(vals)


def self_test():
    """Closed forms against brute force, on sectors with a large inner radius (where the plant bites)."""
    rng = np.random.default_rng(107)
    worst = 0.0
    for k in range(40):
        c = rng.uniform(-1, 1, 2)
        r = rng.uniform(0.0, 0.4)
        s = r + rng.uniform(0.05, 0.6)
        sec = Sector(c, r, s, rng.uniform(-math.pi, math.pi), rng.uniform(0.1, 2 * math.pi - 0.1))
        pts = rng.uniform(-2.5, 2.5, (60, 2))
        mn, mx = sec.mindist(pts[:, 0], pts[:, 1]), sec.maxdist(pts[:, 0], pts[:, 1])
        bmn, bmx = sec.brute(pts[:, 0], pts[:, 1])
        tol = 4 * (s - r) / 500 + 4 * s * (2 * math.pi) / 500
        # closed form must never exceed brute min / fall below brute max, and must be within the sampling tolerance
        e1 = np.max(mn - bmn)          # > 0 would mean the closed min is too large
        e2 = np.max(bmx - mx)          # > 0 would mean the closed max is too small
        e3 = np.max(np.abs(mn - bmn)) - tol
        e4 = np.max(np.abs(mx - bmx)) - tol
        worst = max(worst, e1, e2, e3, e4)
    ok = worst <= 1e-9
    print(f"self-test: closed-form min/max distance vs brute force, worst excess {worst:.3e} -> {'PASS' if ok else 'FAIL'}")
    return ok


def junction(c, r, s, psi, sectors_deg):
    """Sectors at centre c, each (start, end) in degrees relative to direction psi (end > start)."""
    return [Sector(c, r, s, psi + math.radians(a), math.radians(b - a)) for a, b in sectors_deg]


def ring(cuts_deg):
    """Three sectors covering the full circle, cut at the given angles (degrees, increasing)."""
    a, b, c = cuts_deg
    return [(a, b), (b, c), (c, a + 360)]


def forced_area(secs, w, rad, n):
    """Area of {z in B(w, rad): every sector j has mindist < 1 < maxdist} on an n x n grid (tight limit eps -> 0)."""
    xs = np.linspace(w[0] - rad, w[0] + rad, n)
    ys = np.linspace(w[1] - rad, w[1] + rad, n)
    X, Y = np.meshgrid(xs, ys)
    X, Y = X.ravel(), Y.ravel()
    keep = np.hypot(X - w[0], Y - w[1]) <= rad
    X, Y = X[keep], Y[keep]
    forced = np.ones_like(X, dtype=bool)
    for sec in secs:
        forced &= (sec.mindist(X, Y) < 1.0) & (sec.maxdist(X, Y) > 1.0)
    cell = (2 * rad / (n - 1)) ** 2
    return forced.sum() * cell, X[forced], Y[forced]


def config(d, s, r, mu_deg, cuts_u, cuts_v, rad=None, n=(801, 1601), label=""):
    u = np.array([-d / 2, 0.0])
    v = np.array([d / 2, 0.0])
    w = np.array([0.0, math.sqrt(1 - d * d / 4)])
    eu, ev = w - u, w - v
    psi_u, psi_v = math.atan2(eu[1], eu[0]), math.atan2(ev[1], ev[0])
    mu = math.radians(mu_deg)
    rad = mu / 4 if rad is None else rad
    su = junction(u, r, s, psi_u, cuts_u)
    sv = junction(v, r, s, psi_v, cuts_v)
    # linear blocking: common interval of the three linear projections at each junction
    def common(secs, e):
        lo = max(sec.linear_projection(e)[0] for sec in secs)
        hi = min(sec.linear_projection(e)[1] for sec in secs)
        return lo, hi
    lu, hu = common(su, eu)
    lv, hv = common(sv, ev)
    t1 = s * math.sin(mu / 2) / 3
    claim = max(t1 - 2 * r, 0) ** 2
    areas = [forced_area(su + sv, w, rad, k)[0] for k in n]
    sin_theta = d * math.sqrt(4 - d * d) / 2
    print(f"[{label}] d={d:.4f} s={s} r={r} mu={mu_deg}deg  sin(theta)={sin_theta:.3f}")
    print(f"   linear common projection: u ({lu:.4f},{hu:.4f}) len {hu - lu:.4f};  v ({lv:.4f},{hv:.4f}) len {hv - lv:.4f};"
          f"  s*sin(mu/2) = {s * math.sin(mu / 2):.4f}")
    print(f"   R's bound (t1-2r)^2 = {claim:.3e}  (t1 = {t1:.4f});  forced area in B(w, {rad:.4f}) at grids {n}: "
          + ", ".join(f"{a:.3e}" for a in areas))
    return claim, areas


def main():
    ok = self_test()
    if PLANT:
        print("PLANT active: the self-test must be FAIL above;", "OK (fired)" if not ok else "NOT FIRED -- the control is blind")
        sys.exit(0 if not ok else 1)
    if not ok:
        sys.exit(1)
    d = math.sqrt(2)
    narrow = ring([-80, 80, 100])     # colour 1: (-80,80), colour 2: (80,100) [the 20-degree cone], colour 3: (100,280)
    # on-axis cross-check of the grid method: u's three sectors alone, z = u + (1 + rho) e_u, s = 0.33, r = 0.0005.
    # Closed forms: colours 2, 3 excluded iff (1 + rho) sin 80 < 1; colour 1 excluded iff one of its corners rc e^{i80},
    # rc in {r, s}, is beyond distance 1, i.e. (1 + rho)^2 - 2 (1 + rho) rc cos 80 + rc^2 > 1 (the INNER corner decides
    # when r is small: the far points of a junction are the ones next to its void).
    s, r = 0.33, 0.0005
    su = junction(np.array([0.0, 0.0]), r, s, 0.0, narrow)
    rho = np.linspace(-0.05, 0.05, 200001)
    X, Y = 1 + rho, np.zeros_like(rho)
    ok_all = np.ones_like(rho, dtype=bool)
    for sec in su:
        ok_all &= (sec.mindist(X, Y) < 1) & (sec.maxdist(X, Y) > 1)
    lo_grid, hi_grid = rho[ok_all].min(), rho[ok_all].max()
    c80 = math.cos(math.radians(80))
    hi_cf = 1 / math.sin(math.radians(80)) - 1
    lo_cf = min(rc * c80 + math.sqrt((rc * c80) ** 2 - rc * rc + 1) for rc in (r, s)) - 1
    axis_ok = abs(lo_grid - lo_cf) < 2e-6 and abs(hi_grid - hi_cf) < 2e-6
    print(f"\non-axis cross-check (u alone, s=0.33): grid ({lo_grid:.6f}, {hi_grid:.6f}) vs closed form ({lo_cf:.6f}, {hi_cf:.6f})"
          f" -> {'PASS' if axis_ok else 'FAIL'};  band length {hi_cf - lo_cf:.5f} vs R's t1 - 2r = {s * math.sin(math.radians(10)) / 3 - 2 * r:.5f}")
    print("\n== C1: narrow cone mu = 20 deg, s = 0.33 (curvature window 1.5 sin(mu/2) < s < 2 sin(mu/2)) ==")
    c1 = config(d, 0.33, 0.0005, 20, narrow, narrow, label="C1")
    print("\n== C1b: same, s = 0.45 (beyond the window: the lower end drops and the area grows again) ==")
    c1b = config(d, 0.45, 0.001, 20, narrow, narrow, label="C1b")
    print("\n== C2: same angles, s = 0.02 (small-scale regime) ==")
    c2 = config(d, 0.02, 0.0001, 20, narrow, narrow, label="C2")
    print("\n== C3: same angles, s = 0.1 ==")
    c3 = config(d, 0.10, 0.0005, 20, narrow, narrow, label="C3")
    print("\n== C4: blocking broken -- sectors (-70,70), (110,150), (210,250) at u leave a large void; no common projection ==")
    c4 = config(d, 0.10, 0.0005, 20, [(-70, 70), (110, 150), (210, 250)], narrow, label="C4")
    print("\n== C5: tangent Y-junction at u (cuts -90,30,150: an interface along e_u-perp), s = 0.1 ==")
    c5 = config(d, 0.10, 0.0005, 20, ring([-90, 30, 150]), narrow, label="C5")
    verdicts = {
        "on-axis grid = closed form": axis_ok,
        "C1 (s = 0.33, in the curvature window) forced < R's bound": c1[1][-1] < c1[0],
        "C1b (s = 0.45) forced >= R's bound": c1b[1][-1] >= c1b[0],
        "C2 (s = 0.02) forced >= R's bound": c2[1][-1] >= c2[0],
        "C3 (s = 0.1) forced >= R's bound": c3[1][-1] >= c3[0],
        "C4 (blocking broken) forced == 0": c4[1][-1] == 0.0,
        "C5 (tangent) forced > 0 though the linear blocking length is 0": c5[1][-1] > 0.0,
    }
    print("\nsummary:")
    for k, val in verdicts.items():
        print(f"   {k}: {val}")
    sys.exit(0 if all(verdicts.values()) else 1)


if __name__ == "__main__":
    main()

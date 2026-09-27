#!/usr/bin/env python3
"""FS106-SB: check of the hand-built C5 configuration (S-V Prop. 5 without Condition 5).

Configuration (plans/FS106-SB-verification.md, section 2.8):
  u = (0,0), x = (1,0), y = (1/2, sqrt(3)/2); |u-x| = |u-y| = |x-y| = 1.
  Near x (disc of radius r): colour 1 where |p - y| < 1, colour 2 where |p - y| > 1
    (the boundary is an arc of the unit circle about y: a "unit arc").
  Near y (disc of radius r), by the direction psi of p - y in degrees:
    colour 1 on (-140, 20), colour 3 on (20, 40), colour 2 on (40, 200), colour 4 on (200, 220).
What is checked (a check of a derived claim, not a search):
  (P) Prop. 5's hypothesis: on the unit circle about u, at x the half-arc toward y lies in colour 1 and the
      other half in colour 2; at y the half-arc toward x lies in colour 1 and the other in colour 2.
  (C) every pairwise constraint: for each colour j, the sign of |a - b| - 1 over sampled pairs
      a in colour j near x, b in colour j near y is constant and nonzero (so no pair at distance 1
      can occur by continuity on the connected sampled sectors).
  (F) Prop. 5's conclusion fails: near x only colours 1 and 2 occur (by construction; asserted).
Plants (--plant N) must make the check go red for their own stated reason.
"""
import argparse
import math
import sys

import numpy as np

R = 0.02
X = np.array([1.0, 0.0])
Y = np.array([0.5, math.sqrt(3) / 2])
U = np.array([0.0, 0.0])

SECTORS_Y = [(-140.0, 20.0, 1), (20.0, 40.0, 3), (40.0, 200.0, 2), (200.0, 220.0, 4)]


def colour_x(p):
    d = np.linalg.norm(p - Y, axis=-1)
    return np.where(d < 1.0, 1, np.where(d > 1.0, 2, 0))


def colour_y(p, sectors):
    v = p - Y
    psi = np.degrees(np.arctan2(v[..., 1], v[..., 0]))
    out = np.zeros(psi.shape, dtype=int)
    for lo, hi, c in sectors:
        for shift in (-360.0, 0.0, 360.0):
            m = (psi > lo + shift) & (psi < hi + shift)
            out[m] = c
    return out


def disc_samples(centre, n_ang=720, radii=None):
    if radii is None:
        radii = np.concatenate([np.geomspace(1e-6, R, 60)])
    ang = np.linspace(0, 2 * math.pi, n_ang, endpoint=False) + 1e-7
    rr, aa = np.meshgrid(radii, ang)
    pts = np.stack([centre[0] + rr * np.cos(aa), centre[1] + rr * np.sin(aa)], axis=-1)
    return pts.reshape(-1, 2)


def sign_range(A, B):
    lo, hi = math.inf, -math.inf
    for i in range(0, len(A), 200):
        d = np.linalg.norm(A[i:i + 200, None, :] - B[None, :, :], axis=-1) - 1.0
        lo = min(lo, float(d.min()))
        hi = max(hi, float(d.max()))
    return lo, hi


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--plant", type=int, default=0,
                    help="1: colour 1 at y widened into the side cone (to 35 deg); "
                         "2: colour 2 at y given the side cone (20,40); 3: Prop.5 hypothesis broken at y")
    a = ap.parse_args()
    sectors = [list(s) for s in SECTORS_Y]
    if a.plant == 1:
        sectors = [(-140.0, 35.0, 1), (35.0, 40.0, 3), (40.0, 200.0, 2), (200.0, 220.0, 4)]
    elif a.plant == 2:
        sectors = [(-140.0, 20.0, 1), (20.0, 200.0, 2), (200.0, 220.0, 4)]
    elif a.plant == 3:
        sectors = [(-140.0, 20.0, 2), (20.0, 40.0, 3), (40.0, 200.0, 1), (200.0, 220.0, 4)]
    ok = True
    # (P) Prop. 5's hypothesis on the unit circle about u
    eps = np.geomspace(1e-6, 0.9 * R, 50)
    toward_y_at_x = np.stack([np.cos(eps), np.sin(eps)], -1)
    away_at_x = np.stack([np.cos(-eps), np.sin(-eps)], -1)
    th_y = math.pi / 3
    toward_x_at_y = np.stack([np.cos(th_y - eps), np.sin(th_y - eps)], -1)
    away_at_y = np.stack([np.cos(th_y + eps), np.sin(th_y + eps)], -1)
    hyp = (np.all(colour_x(toward_y_at_x) == 1) and np.all(colour_x(away_at_x) == 2)
           and np.all(colour_y(toward_x_at_y, sectors) == 1) and np.all(colour_y(away_at_y, sectors) == 2))
    print(f"(P) Prop. 5 hypothesis holds: {hyp}")
    ok &= bool(hyp)
    # (C) pairwise constraints
    PX = disc_samples(X)
    PY = disc_samples(Y)
    cx = colour_x(PX)
    cy = colour_y(PY, sectors)
    for j in sorted(set(cx.tolist()) | set(cy.tolist())):
        if j == 0:
            continue
        A = PX[cx == j]
        B = PY[cy == j]
        if len(A) == 0 or len(B) == 0:
            print(f"(C) colour {j}: present on one side only ({len(A)} near x, {len(B)} near y): no constraint")
            continue
        lo, hi = sign_range(A, B)
        good = (hi < 0) or (lo > 0)
        print(f"(C) colour {j}: |a-b|-1 in [{lo:.3e}, {hi:.3e}] over {len(A)}x{len(B)} pairs -> "
              f"{'constant sign' if good else 'SIGN CHANGE (a unit pair exists)'}")
        ok &= good
    # (F) conclusion fails at x: only colours 1, 2 near x
    fx = set(cx.tolist()) - {0}
    print(f"(F) colours near x: {sorted(fx)}; Prop. 5 conclusion fails at x: {fx <= {1, 2}}")
    ok &= fx <= {1, 2}
    # (I) the swap: complementary translate curves g1(t) = x + t d, g2(t) = y + t d, d at -70 deg
    d = np.array([math.cos(math.radians(-70)), math.sin(math.radians(-70))])
    ts = np.linspace(-R / 2, R / 2, 4001)
    ts = ts[np.abs(ts) > 1e-9]
    g1 = X[None, :] + ts[:, None] * d[None, :]
    g2 = Y[None, :] + ts[:, None] * d[None, :]
    t1 = colour_x(g1)
    t2 = colour_y(g2, sectors)
    def index(tr):
        # lift: +1 for a cyclic step 1->2->3->1, -1 for the reverse (S-V Def. 6)
        steps = [(b - a) % 3 for a, b in zip(tr[:-1], tr[1:]) if a != b]
        return sum(1 if s_ == 1 else -1 for s_ in steps)
    same = bool(np.any((t1 == t2) & (t1 > 0)))
    unit = float(np.max(np.abs(np.linalg.norm(g1 - g2, axis=1) - 1.0)))
    print(f"(I) traces: g1 {t1[0]}->{t1[-1]}, g2 {t2[0]}->{t2[-1]}; complementary (max ||g1-g2|-1| = {unit:.1e}); "
          f"same colour at some t: {same}; Ind g1 = {index(t1)}, Ind g2 = {index(t2)}, "
          f"|difference| = {abs(index(t1) - index(t2))}")
    print("RESULT:", "PASS" if ok else "FAIL")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())

#!/usr/bin/env python3
"""FS116-V3: GERM-R's open intervals are sharp — two tiles of one colour, given by formula, meeting a boundary direction.

p = 0, psi = 0, y = r(0) = (1, 0), z0 = r(-60 deg); u0 = z0 - y = r(-120 deg). Two germ tiles, each holding a germ at z0 in its closure:
  T_out = { rho * r(-60deg - tau) : 0 < tau < H, 1 < rho < 1 + H }   holds v- (just clockwise of z0) in its closure; outside omega(y)
  T_in  = { rho * r(-60deg + tau) : 0 < tau < H, 1 - H < rho < 1 }   holds v+ (just counter-clockwise of z0) in its closure; inside omega(y)
and a horn at y along a boundary direction beta (beta - psi = 150 or 330 deg, the ends of v-'s interval (150, 330); 150 is also an end of
v+'s interval (-30, 150)):
  horn(beta, lo, hi) = { y + s * r(beta + phi) : 0 < s < S, lo*s < sin phi < hi*s }   (between two circles tangent to the ray at y:
                        |sin phi| < s/4 is outside both circles of radius 2; s < sin phi < 2s is inside the circle of radius 1/2 and
                        outside the circle of radius 1/4 on one side)
Models (each pair must be at no distance exactly 1, i.e. F = |z - a|^2 - 1 of one sign on all of T x horn):
  outer150: T_out with horn(150, -1/4, 1/4)   hand bound F >= r(1 - 2s) + tau(1.7 - 2s) + s^2/2 > 0   (record § 2.3)
  outer330: T_out with horn(330, -1/4, 1/4)   the same bound
  inner150: T_in  with horn(150, 1, 2)        hand bound F <= -r(0.8 - 2s) - tau(1.28 - 2s) - s^2 < 0
  inner330: T_in  with horn(330, -2, -1)      the same bound (-30 deg is the other end of v+'s interval)
The tool samples T x horn on grids dense near the corner (log-spaced) and prints, per model, the sign found and the hand bound's margin.
--plant: each horn is replaced by the wrong one (outer models: s < |sin phi| < 2s on the side toward z0; inner: |sin phi| < s/4); every
model must then show both
signs of F (a unit pair between the two tiles, by the intermediate value theorem).
"""
import math
import sys

H, S = 0.2, 0.2


def pts_log(lo, hi, n):
    return [lo * (hi / lo) ** (i / (n - 1)) for i in range(n)]


def model(name, plant):
    inner = name.startswith("inner")
    beta = math.radians(150 if name.endswith("150") else 330)
    if inner:
        right = (1.0, 2.0) if name.endswith("150") else (-2.0, -1.0)   # curving toward z0 at each end
        lo, hi = (-0.25, 0.25) if plant else right
    else:
        wrong = (1.0, 2.0) if name.endswith("150") else (-2.0, -1.0)   # the side toward z0 at each end
        lo, hi = wrong if plant else (-0.25, 0.25)
    taus = pts_log(1e-7, H * 0.999, 30)
    rs = [0.0] + pts_log(1e-7, H * 0.999, 25)
    ss = pts_log(1e-6, S * 0.999, 30)
    fr = [0.001, 0.25, 0.5, 0.75, 0.999]
    pos = neg = 0
    margin = float("inf")
    for tau in taus:
        for r in rs:
            rho = 1 - r if inner else 1 + r
            ang = math.radians(-60) + (tau if inner else -tau)
            zx, zy = rho * math.cos(ang), rho * math.sin(ang)
            for s in ss:
                for f in fr:
                    sphi = (lo + (hi - lo) * f) * s
                    phi = math.asin(sphi)
                    ax, ay = 1 + s * math.cos(beta + phi), s * math.sin(beta + phi)
                    F = (zx - ax) ** 2 + (zy - ay) ** 2 - 1
                    pos += F > 0
                    neg += F < 0
                    if not plant:
                        if inner:
                            margin = min(margin, (-r * (0.8 - 2 * s) - tau * (1.28 - 2 * s) - s * s) - F)
                        else:
                            margin = min(margin, F - (r * (1 - 2 * s) + tau * (1.7 - 2 * s) + s * s / 2))
    sign = "both signs" if pos and neg else ("all positive" if pos else "all negative")
    line = f"{name}: F {sign} over {pos + neg} samples"
    if not plant:
        line += f"; hand bound {'holds' if margin >= -1e-15 else 'FAILS'} at every sample"
    return line, sign


def main(plant):
    signs = []
    for name in ("outer150", "outer330", "inner150", "inner330"):
        line, sign = model(name, plant)
        print(line)
        signs.append(sign)
    one_sign = sum(s != "both signs" for s in signs)
    print(f"models with F of one sign (no unit pair): {one_sign} of {len(signs)}")


if __name__ == "__main__":
    main("--plant" in sys.argv)

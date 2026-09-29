#!/usr/bin/env python3
"""FS116-V3: the first-order bookkeeping of FS116-N1-GERM-R and FS116-N1-GERM-S, checked on formulas (no search).

Setting (wlog by rotation): p = 0, y = r(psi) with psi = 0, r(theta) = (cos theta, sin theta).
A germ g of omega(p) at r(sigma*60deg), on side tau (tau = -1 just clockwise, +1 just counter-clockwise), is z_g(t) = r(sigma*60 + tau*t).
  s_g   = sign of d/dt |z_g(t) - y|^2 at t = 0+   (+1: the germ lies just outside the unit circle about y; -1: just inside)
  u_g   = z_g(0) - y (a unit vector: |r(+-60) - r(0)| = 1)
The derivation's forbidden set for colour c (the germ in the closure of a c-tile) is F_g = {beta : s_g * <e(beta), u_g> > 0}.

mode intervals: compare F_g with the statement's open interval I_g, exactly (sympy) at the endpoints and on a 0.05-degree grid elsewhere.
mode cones:     GERM-S's pairing — each germ at y +- 60 is 60 degrees from one ring germ at y (clockwise side colour Xbar,
                counter-clockwise side colour X), so off (Q) arcs it carries the other absent colour; check that the inward cone
                (150, 210) lies in the forbidden sets of v-minus and u-plus, the outward cone (-30, 30) in those of u-minus and
                v-plus, and that each pair carries both absent colours.
--plant: intervals — the statement's intervals for v+ and u- are exchanged; cones — u+ is paired with the wrong ring germ and takes
         v-'s colour; each must then report a failure.
"""
import sys
import sympy as sp

STATED = {  # germ: (sigma, tau, (lo, hi)) with the statement's open interval for beta - psi, in degrees
    "v-": (-1, -1, (150, 330)),
    "v+": (-1, +1, (-30, 150)),
    "u-": (+1, -1, (-150, 30)),
    "u+": (+1, +1, (30, 210)),
}


def rr(deg):
    a = sp.pi * sp.Rational(deg) / 180 if not isinstance(deg, sp.Expr) else deg
    return sp.Matrix([sp.cos(a), sp.sin(a)])


def germ_data(sigma, tau):
    t = sp.symbols("t", real=True)
    y = rr(0)
    z = sp.Matrix([sp.cos(sp.pi * sigma / 3 + tau * t), sp.sin(sp.pi * sigma / 3 + tau * t)])
    d2 = sp.simplify(((z - y).T * (z - y))[0])
    slope = sp.nsimplify(sp.diff(d2, t).subs(t, 0))
    s = 1 if slope > 0 else -1
    u = sp.simplify(z.subs(t, 0) - y)
    return s, u, slope


def in_open(beta, lo, hi):
    b = (beta - lo) % 360
    return 0 < b < (hi - lo)


def intervals(plant):
    stated = dict(STATED)
    if plant:
        stated["v+"], stated["u-"] = (stated["v+"][0], stated["v+"][1], STATED["u-"][2]), (stated["u-"][0], stated["u-"][1], STATED["v+"][2])
    bad = 0
    for g, (sigma, tau, (lo, hi)) in stated.items():
        s, u, slope = germ_data(sigma, tau)
        # endpoints exactly: <e(beta), u> = 0 there
        ends = [sp.simplify((rr(lo).T * u)[0]), sp.simplify((rr(hi).T * u)[0])]
        if any(e != 0 for e in ends):
            bad += 1
            print(f"{g}: endpoint inner products {ends} are not 0")
        ux, uy = float(u[0]), float(u[1])
        import math
        mism = 0
        n = 7200
        for i in range(n):
            beta = -180 + 360 * i / n
            if min(abs(((beta - lo + 180) % 360) - 180), abs(((beta - hi + 180) % 360) - 180)) < 1e-9:
                continue
            ip = math.cos(math.radians(beta)) * ux + math.sin(math.radians(beta)) * uy
            forb = s * ip > 0
            if forb != in_open(beta, lo, hi):
                mism += 1
        bad += mism > 0
        side = "outside" if s > 0 else "inside"
        print(f"{g}: germ just {side} omega(y) (slope {slope}); u = ({sp.nsimplify(u[0])}, {sp.nsimplify(u[1])}); "
              f"forbidden set vs stated ({lo}, {hi}): {mism} grid mismatches")
    print(f"intervals mismatched: {bad} of 4")


def cones(plant=False):
    # ring germs at y: clockwise side colour 'Xbar', counter-clockwise side colour 'X'.
    # germ g = r(sigma*60 + tau*t) is 60 degrees from the ring germ r(tau*t), which lies on side tau of y.
    colour = {}
    for g, (sigma, tau, _) in STATED.items():
        ring = "X" if tau > 0 else "Xbar"
        colour[g] = "Xbar" if ring == "X" else "X"   # N-E1 at the germ point: not the ring germ's colour; absent at p
    def covers(g, lo, hi):
        _, _, (glo, ghi) = STATED[g]
        return all(in_open(b, glo, ghi) for b in [lo + (hi - lo) * i / 1000 for i in range(1, 1000)])
    if plant:
        colour["u+"] = colour["v-"]   # u+ paired with the wrong ring germ: it takes v-'s absent colour
    ok = 0
    for label, (lo, hi), pair in (("inward", (150, 210), ("v-", "u+")), ("outward", (-30, 30), ("u-", "v+"))):
        cov = all(covers(g, lo, hi) for g in pair)
        both = {colour[pair[0]], colour[pair[1]]} == {"X", "Xbar"}
        ok += cov and both
        print(f"{label} cone ({lo}, {hi}): germs {pair} carry {colour[pair[0]]}, {colour[pair[1]]}; "
              f"cone inside both forbidden sets: {cov}; both absent colours excluded: {both}")
    print(f"cones closed: {ok} of 2")


if __name__ == "__main__":
    mode = sys.argv[1] if len(sys.argv) > 1 else "intervals"
    if mode == "intervals":
        intervals("--plant" in sys.argv)
    elif mode == "cones":
        cones("--plant" in sys.argv)
    else:
        print("mode: intervals | cones")
        sys.exit(2)

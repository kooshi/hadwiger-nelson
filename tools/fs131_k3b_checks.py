#!/usr/bin/env python3
"""FS131-K3b, stage 4: three geometric statements of wave 3 checked by computer algebra before they are written in Lean.

  A  FS116-N1-GERM-R's four open intervals (v-, v+, u-, u+) — the first-order motion of the ring point at distance 1 from
     y + h through r(psi -+ 60deg), symbolically, and the existence of the distance-1 point on the germ at concrete configurations.
  B  FS116-Y4-FLANK — the tangent cones of the two unit discs (exactly [psi+30, psi+210] and [psi+210, psi+390]); a segment and an
     arc curving away leave the disc; arcs of radius 1 (TWOCIRC) and 1/2 curving inward give a pair below 1.
  C  FS116-S1-EXIT — P = y_b at the tangent heading, |y_b - y_3| = 1, d|P - y_3|^2/dbeta = -2 cos(phi - b + 150deg) (and mirrors),
     the signs on the whole parameter box, and a concrete exit where the feasible heading arc meets the exit window in tau only.

Exact symbolic identities with sympy; signs on boxes by exact interval reasoning; concrete configurations at rational multiples of
pi evaluated exactly where sympy can and at 60 digits otherwise (margins printed). No search (standing rule 5).

Usage: python3 tools/fs131_k3b_checks.py [A|B|C|all] [--plant A|B|C]
Each plant breaks what its check guards (A: a wrong interval end; B: an arc curving away claimed inside; C: y_3 at e(b - 60deg));
the check must then print FAIL.
"""
import sys
import sympy as sp

PLANT = sys.argv[sys.argv.index("--plant") + 1] if "--plant" in sys.argv else None
deg = sp.pi / 180
I = sp.I


def e(t):
    return sp.exp(I * t)


def re_(z):
    return sp.re(sp.expand_complex(z))


def ok(msg, cond):
    print(("  ok    " if cond else "  FAIL  ") + msg)
    return bool(cond)


# ---------------------------------------------------------------------------------------------------------------------
def check_A():
    """GERM-R. y = e(psi) on the unit circle about 0. For z = y + h near y, the ring point r(phi) with |z - r(phi)| = 1 near
    phi0 = psi -+ 60deg moves by dphi = -(grad_z f . h)/(df/dphi), f(z, phi) = |z - e(phi)|^2 - 1. A germ on side s at phi0
    in the closure of the class of c excludes every direction beta with s * dphi(beta) > 0 (the distance-1 point then lies
    on the germ, so z, an interior point of the class, is at distance 1 from a closure point: N-E1)."""
    print("A  FS116-N1-GERM-R")
    psi, beta, phi, s = sp.symbols("psi beta phi s", real=True)
    x, yv = sp.symbols("x y", real=True)
    z = x + I * yv
    f = sp.expand(sp.simplify((x - sp.cos(phi)) ** 2 + (yv - sp.sin(phi)) ** 2 - 1))
    good = True
    # stated intervals, relative to psi, in degrees: (germ centre offset, side, lo, hi)
    rows = {"v-": (-60, -1, 150, 330), "v+": (-60, 1, -30, 150), "u-": (60, -1, -150, 30), "u+": (60, 1, 30, 210)}
    if PLANT == "A":
        rows["v+"] = (-60, 1, -30, 170)
    for name, (off, side, lo, hi) in rows.items():
        phi0 = psi + off * deg
        at = {x: sp.cos(psi), yv: sp.sin(psi), phi: phi0}
        fphi = sp.simplify(sp.diff(f, phi).subs(at))
        fx = sp.simplify(sp.diff(f, x).subs(at))
        fy = sp.simplify(sp.diff(f, yv).subs(at))
        # h = e(beta): dphi per unit |h|
        dphi = sp.simplify(-(fx * sp.cos(beta) + fy * sp.sin(beta)) / fphi)
        g = sp.simplify(side * dphi)  # > 0 exactly on the excluded directions
        # g is A cos(beta - psi - c0): its zeros are the interval ends, its sign inside is positive
        z1 = sp.simplify(g.subs(beta, psi + lo * deg))
        z2 = sp.simplify(g.subs(beta, psi + hi * deg))
        mid = sp.simplify(g.subs(beta, psi + sp.Rational(lo + hi, 2) * deg))
        outside = sp.simplify(g.subs(beta, psi + (sp.Rational(lo + hi, 2) + 180) * deg))
        good &= ok(f"{name}: s*dphi vanishes at psi{lo:+d}deg and psi{hi:+d}deg  ({z1}, {z2})", z1 == 0 and z2 == 0)
        good &= ok(f"{name}: s*dphi > 0 at the interval's middle ({mid}) and < 0 opposite ({outside})",
                   sp.simplify(mid).is_positive and sp.simplify(outside).is_negative)
        # the interval has length 180deg, so these two facts pin it (g = A cos(beta - c), A > 0)
        good &= ok(f"{name}: interval length is 180deg", hi - lo == 180)
        # concrete configuration (psi = 0): z = 1 + t e(beta) at beta = the middle, t = 1/50; the distance-1 point
        # phi = arg z + side' * arccos(|z|/2) nearest phi0 lies strictly on the germ's side of phi0, within 1 degree
        t = sp.Rational(1, 50)
        bm = sp.Rational(lo + hi, 2) * deg
        zc = 1 + t * e(bm)
        r = sp.sqrt(sp.expand(zc * sp.conjugate(zc)))
        argz = sp.atan2(sp.im(sp.expand_complex(zc)), sp.re(sp.expand_complex(zc)))
        cands = [argz + sp.acos(r / 2), argz - sp.acos(r / 2)]
        target = off * deg
        phic = min(cands, key=lambda c: abs(sp.re(sp.N(c - target, 60))))
        disp = sp.re(sp.N(phic - target, 60))
        dist1 = sp.re(sp.N(sp.Abs(zc - e(phic)) - 1, 60))
        pred = float(2 / sp.sqrt(3) * t)  # first order: |dphi| = (2/sqrt 3)|h| at the middle direction
        good &= ok(f"{name}: at psi=0, beta=middle, |h|=1/50 the distance-1 ring point is {float(disp / deg):.6f}deg from "
                   f"phi0 (side {side:+d}; first order predicts {pred * 180 / float(sp.pi):.6f}deg); "
                   f"| |z - r(phi)| - 1 | = {abs(float(dist1)):.1e}",
                   (float(disp) * side > 0) and abs(abs(float(disp)) - pred) < 0.05 * pred and abs(float(dist1)) < 1e-50)
    return good


# ---------------------------------------------------------------------------------------------------------------------
def check_B():
    """FLANK at psi = 0 (rotation invariance): p = 0, y = 1, y' = e(60deg), y' - y = e(120deg)."""
    print("B  FS116-Y4-FLANK")
    good = True
    psi, beta, sv = sp.symbols("psi beta s", real=True)
    y, yp = e(psi), e(psi + 60 * deg)
    good &= ok("y' - y = e(psi + 120deg)", sp.simplify(sp.expand_complex(yp - y - e(psi + 120 * deg))) == 0)
    # tangent cone of the closed disc B(y', 1) at y: first order of |y + s e(beta) - y'|^2 - 1 is 2 s Re(e(beta) conj(y - y'))
    lin = sp.simplify(re_(e(beta) * sp.conjugate(y - yp)))
    good &= ok(f"cone of B(y',1) at y: first order {lin} vanishes at psi+30, psi+210 and is < 0 at psi+120",
               sp.simplify(lin.subs(beta, psi + 30 * deg)) == 0 and sp.simplify(lin.subs(beta, psi + 210 * deg)) == 0
               and sp.simplify(lin.subs(beta, psi + 120 * deg)).is_negative)
    lin2 = sp.simplify(re_(e(beta) * sp.conjugate(yp - y)))
    good &= ok(f"cone of B(y,1) at y': first order {lin2} vanishes at psi+210, psi+390 and is < 0 at psi+300",
               sp.simplify(lin2.subs(beta, psi + 210 * deg)) == 0 and sp.simplify(lin2.subs(beta, psi + 390 * deg)) == 0
               and sp.simplify(lin2.subs(beta, psi + 300 * deg)).is_negative)
    # concrete: psi = 0
    y, yp = sp.Integer(1), e(60 * deg)
    d = 210 * deg
    seg = sp.simplify(sp.expand(sp.Abs(sp.expand_complex(y + sv * e(d) - yp)) ** 2) - 1)
    good &= ok(f"a segment leaving y along 210deg: |seg(s) - y'|^2 - 1 = {seg} > 0 for s > 0", sp.simplify(seg - sv ** 2) == 0)

    def arc(start, rho, phi0, sigma, t):  # InitialPiece's circular case: centre c, start = c + rho e(phi0)
        c = start - rho * e(phi0)
        return c + rho * e(phi0 + sigma * t)

    # the inward arc at y: sigma = -1, phi0 = d + 90deg (so e(d) = e(phi0 - 90deg)); centre y + rho e(120deg)
    for rho in (sp.Integer(1), sp.Rational(1, 2)):
        sig_in, sig_out = -1, 1
        if PLANT == "B":
            sig_in = 1  # an arc curving away, claimed to stay inside
        phi_in = d - sig_in * 90 * deg
        tt = sp.pi / 12
        pa = arc(y, rho, phi_in, sig_in, tt)
        gap = sp.N(sp.Abs(pa - yp) - 1, 60)
        good &= ok(f"radius {rho}: the arc leaving y along 210deg curving toward y' stays in B(y',1) at turn 15deg "
                   f"(|z - y'| - 1 = {float(sp.re(gap)):.3e})", float(sp.re(gap)) <= 1e-50)
        phi_out = d - sig_out * 90 * deg
        po = arc(y, rho, phi_out, sig_out, tt)
        gapo = sp.N(sp.Abs(po - yp) - 1, 60)
        good &= ok(f"radius {rho}: the arc curving away leaves B(y',1) at turn 15deg (|z - y'| - 1 = {float(sp.re(gapo)):.3e})", float(sp.re(gapo)) > 0)
    # both unit arcs: a(s) about y' from y, b(s) about y from y', both leaving along 210deg (TWOCIRC):
    # |a(s) - b(s)|^2 - 1 = -8 sin^2(s/2) cos s
    phi_a = d + 90 * deg  # sigma = -1 at y
    phi_b = d - 90 * deg  # at y', the inward turn toward y is sigma = +1: e(d) = e(phi_b + 90deg)
    a_s = arc(y, 1, phi_a, -1, sv)
    b_s = arc(yp, 1, phi_b, 1, sv)
    ca, cb = sp.simplify(sp.expand_complex(y - e(phi_a))), sp.simplify(sp.expand_complex(yp - e(phi_b)))
    good &= ok(f"the unit arcs' centres are y' and y ({ca}, {cb})",
               sp.simplify(sp.expand_complex(ca - yp)) == 0 and sp.simplify(sp.expand_complex(cb - y)) == 0)
    ident = sp.simplify(sp.expand(sp.expand_complex(sp.Abs(sp.expand_complex(a_s - b_s)) ** 2)) - 1
                        + 8 * sp.sin(sv / 2) ** 2 * sp.cos(sv))
    good &= ok(f"TWOCIRC at equal turns: |a(s) - b(s)|^2 - 1 + 8 sin^2(s/2) cos s = {sp.simplify(ident)}",
               sp.simplify(sp.expand_trig(ident)) == 0)
    return good


# ---------------------------------------------------------------------------------------------------------------------
def check_C():
    """EXIT. y_b = e(b), y_a = e(a), y_3 = e(b + 60deg), y_5 = e(a - 60deg)."""
    print("C  FS116-S1-EXIT")
    good = True
    a, b, phi, g, beta = sp.symbols("a b phi g beta", real=True)
    yb, ya = e(b), e(a)
    y3 = e(b + 60 * deg) if PLANT != "C" else e(b - 60 * deg)
    y5 = e(a - 60 * deg)
    # on omega(y_b): x = y_b + e(phi); heading beta, nu = e(beta + 90deg); tau = phi + 90deg
    xb = yb + e(phi)
    P = xb + e(beta + 90 * deg)
    tau = phi + 90 * deg
    good &= ok("P = y_b at beta = tau", sp.simplify(sp.expand_complex(P.subs(beta, tau) - yb)) == 0)
    good &= ok("|y_b - y_3| = 1", sp.simplify(sp.expand_complex(sp.Abs(sp.expand_complex(yb - y3)) ** 2)) == 1)
    q = sp.expand_complex(sp.Abs(sp.expand_complex(P - y3)) ** 2)
    dq = sp.simplify(sp.diff(q, beta).subs(beta, tau))
    good &= ok(f"d|P - y_3|^2/dbeta at tau = -2 cos(phi - b + 150deg)  (got {dq})",
               sp.simplify(sp.expand_trig(dq + 2 * sp.cos(phi - b + 150 * deg))) == 0)
    # sign: phi - b in (180, a - b + 360] with a - b in (-180, -60): phi - b + 150 in (330, 450): cos > 0 there
    lo, hi = 330, 450  # open at both ends (hi is approached only as a - b -> -60, excluded)
    good &= ok("phi - b + 150deg ranges in (330deg, 450deg) on the box, where cos > 0, so the derivative is < 0",
               (180 + 150 == lo) and (-60 + 360 + 150 == hi) and all(sp.cos(t * deg) > 0 for t in (331, 360, 390, 449)))
    # on omega(y_a): x = y_a + e(g), tau' = g - 90deg, Q = x - nu
    xa = ya + e(g)
    Q = xa - e(beta + 90 * deg)
    taup = g - 90 * deg
    good &= ok("Q = y_a at beta = tau'", sp.simplify(sp.expand_complex(Q.subs(beta, taup) - ya)) == 0)
    good &= ok("|y_a - y_5| = 1", sp.simplify(sp.expand_complex(sp.Abs(sp.expand_complex(ya - y5)) ** 2)) == 1)
    qa = sp.expand_complex(sp.Abs(sp.expand_complex(Q - y5)) ** 2)
    dqa = sp.simplify(sp.diff(qa, beta).subs(beta, taup))
    good &= ok(f"d|Q - y_5|^2/dbeta at tau' = 2 cos(g - a - 150deg)  (got {dqa})",
               sp.simplify(sp.expand_trig(dqa - 2 * sp.cos(g - a - 150 * deg))) == 0)
    # g - a in (60, 180): g - a - 150 in (-90, 30): cos > 0
    good &= ok("g - a - 150deg ranges in (-90deg, 30deg), where cos > 0, so the derivative is > 0",
               all(sp.cos(t * deg) > 0 for t in (-89, -45, 0, 29)))
    # concrete exit: b = 60, a = -60, x_e on omega(y_b) at phi = 270deg (inside (240, 300]); feasible headings for the y_3
    # condition: cos(beta + 90 - arg(x - y_3)) <= -|x - y_3|/2, an arc [c - w/2, c + w/2] around c = arg(x - y_3) + 90deg
    bb, aa, ph = 60 * deg, -60 * deg, 270 * deg
    yb_, y3_ = e(bb), (e(bb + 60 * deg) if PLANT != "C" else e(bb - 60 * deg))
    x = sp.expand_complex(yb_ + e(ph))
    dvec = sp.expand_complex(x - y3_)
    dd = sp.sqrt(sp.simplify(sp.expand(dvec * sp.conjugate(dvec))))
    good &= ok(f"|x_e - y_3| = {sp.N(dd, 12)} >= 1 (the row's hypothesis)", sp.N(dd, 60) >= 1)
    centre = sp.atan2(sp.im(dvec), sp.re(dvec)) + sp.pi - 90 * deg  # cos(beta + 90 - arg) = -1 at beta = arg + 90
    half = sp.acos(dd / 2)
    width = sp.N(2 * (sp.pi - half) / deg, 30)  # the arc where cos <= -dd/2 has half-width pi - acos(-dd/2)... recomputed:
    # cos(u) <= -dd/2  iff  |u - pi| <= pi - acos(-dd/2) = acos(dd/2)
    w = sp.N(2 * half / deg, 30)
    tau_c = ph + 90 * deg
    lo_arc, hi_arc = centre - half, centre + half
    mod = lambda t: sp.N(((t - tau_c) / deg + 180) % 360 - 180, 40)  # signed offset from tau, in degrees
    good &= ok(f"the feasible heading arc has width {sp.N(w, 8)}deg <= 120deg", w <= 120)
    good &= ok(f"tau is its lower end (offset {sp.N(mod(lo_arc), 6)}deg) and its upper end is tau + {sp.N(mod(hi_arc), 8)}deg",
               abs(mod(lo_arc)) < 1e-30 and 0 < mod(hi_arc) <= 120)
    good &= ok("so it meets the exit window [tau - 180deg, tau] in tau alone: P = y_b", abs(mod(lo_arc)) < 1e-30)
    return good


def main():
    which = [a for a in sys.argv[1:2] if a in ("A", "B", "C", "all")] or ["all"]
    res = {}
    for name, fn in (("A", check_A), ("B", check_B), ("C", check_C)):
        if which[0] in (name, "all"):
            res[name] = fn()
    line = "; ".join(f"{k}: {'PASS' if v else 'FAIL'}" for k, v in res.items())
    print("=> " + line + (f"   [plant {PLANT}]" if PLANT else ""))
    sys.exit(0 if all(res.values()) else 1)


main()

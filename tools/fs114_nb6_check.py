#!/usr/bin/env python3
"""FS114-NB6: exact checks of the metric facts in the blind derivations of plans/FS114-NB6-verification.md.

Frame (the pinwheel lemma NB6-P60, theta_j = 0): p = 0, q_j = e(90), q_{j+1} = e(90 + a1) with a1 = alpha_{j+1} (60 unless
--plant), w0 = e(30) = q_j - 60 deg on the ring, q_{j+2} = e(90 + a1 + a2).  Directions are in degrees, multiples of 15, so
every coordinate lies in Q(sqrt2, sqrt3) and every sign is decided by sympy on an exact expression.

Each line is tagged with what it rests on: GAP60 lines are computed in the frame alpha_{j+1} = 60 (some are exact unit-gap
identities, some stay true for nearby alpha); BASE lines do not use alpha_{j+1}.  --plant sets a1 = 75 (no unit gap between
q_j and q_{j+1}): the unit-gap identities among the GAP60 lines must then fail (recorded run: 5 of 13) and no BASE line may
fail -- the plant fires for its own reason.
Exit 0 iff every line passes (without --plant), or iff some GAP60 line and no BASE line fails (with --plant).
"""
import sys
import sympy as sp

PLANT = "--plant" in sys.argv


def e(deg):
    t = sp.pi * sp.Rational(deg, 180)
    return sp.Matrix([sp.cos(t), sp.sin(t)])


def d2(u, v):
    w = u - v
    return sp.nsimplify(sp.simplify(w.dot(w)))


def dot(u, v):
    return sp.simplify(u.dot(v))


def sgn(x):
    x = sp.nsimplify(sp.simplify(x))
    if x == 0:
        return 0
    return 1 if x.is_positive else (-1 if x.is_negative else None)


rows = []


def check(tag, name, ok):
    rows.append((tag, name, bool(ok)))


a1 = 75 if PLANT else 60
p = sp.Matrix([0, 0])
qj = e(90)
qj1 = e(90 + a1)
w0 = e(30)

# --- KAPPA / WIN: the 60-degree chord, and the straddle of case (c) --------------------------------------------------
check("BASE", "KAPPA: |e(0) - e(60)| = 1 (ring points 60 deg apart are at distance 1)", d2(e(0), e(60)) == 1)
s = sp.Rational(1, 1000)
for eta, want in ((sp.Rational(1, 20), 1), (-sp.Rational(1, 20), -1)):
    # points (1-s)e(0) and (1-s)e(60 deg + eta rad): distance^2 - 1 has the sign of eta for s << eta
    u = (1 - s) * e(0)
    v = (1 - s) * sp.Matrix([sp.cos(sp.pi / 3 + eta), sp.sin(sp.pi / 3 + eta)])
    w = u - v
    val = sp.N(w.dot(w) - 1, 50)
    check("BASE", f"KAPPA (c): inner points 60 deg + eta apart straddle 1 (eta = {eta}): sign {want}", (val > 0) == (want > 0))
check("BASE", "WIN: window points e(1) and e(-1) + 60 deg - 2: chord of 58 deg < 1",
      sp.N(2 * sp.sin(sp.pi * sp.Rational(58, 360)), 30) < 1)
check("BASE", "WIN: V0 and V1 points e(-1) and e(61): chord of 62 deg > 1",
      sp.N(2 * sp.sin(sp.pi * sp.Rational(62, 360)), 30) > 1)

# --- NB6-P60 (the pinwheel lemma) -------------------------------------------------------------------------------------
check("GAP60", "P60: |q_j - q_{j+1}| = 1 (alpha_{j+1} = 60)", d2(qj, qj1) == 1)
check("BASE", "P60: |q_j - w0| = 1 (w0 = q_j - 60 deg on the ring)", d2(qj, w0) == 1)
check("BASE", "P60: |p - q_j| = 1", d2(qj, p) == 1)
# U (A-tile at q_j, far from U3 at w0): cone at q_j in {v.(w0 - q_j) <= 0}; w0 - q_j is the unit vector e(-30)
check("BASE", "P60: w0 - q_j = e(-30)", sp.simplify(w0 - qj - e(-30)) == sp.zeros(2, 1))
for d in (255, 270, 285):
    check("BASE", f"P60: direction {d} at q_j faces w0 (U cannot hold it)", sgn(dot(e(d), w0 - qj)) == 1)
for d in (180, 225, 240):
    check("BASE", f"P60: direction {d} at q_j does not face w0 (U may hold it)", sgn(dot(e(d), w0 - qj)) in (-1, 0))
# t_{j+1}: p-facing ([180, 360]) and away from q_{j+1}; with alpha_{j+1} = 60, q_{j+1} - q_j = e(210)
check("GAP60", "P60: q_{j+1} - q_j = e(210)", sp.simplify(qj1 - qj - e(210)) == sp.zeros(2, 1))
for d in (255, 270, 285):
    check("GAP60", f"P60: direction {d} at q_j faces q_{{j+1}} (t_{{j+1}} cannot hold it)", sgn(dot(e(d), qj1 - qj)) == 1)
for d in (300, 330, 345):
    check("BASE", f"P60: direction {d} at q_j is p-facing (t_{{j+1}} may hold it)", sgn(dot(e(d), p - qj)) == 1)
# directions (240, 300) at q_j point into B(p, 1): q_j + r e(d), r = 1/10
r = sp.Rational(1, 10)
for d in (255, 270, 285):
    check("BASE", f"P60: q_j + r e({d}) lies in B(p, 1)", sgn(d2(qj + r * e(d), p) - 1) == -1)
# the Reuleaux corner at q_j: the side toward p along omega(q_{j+1}) leaves q_j at 300 (tangent perpendicular to q_j - q_{j+1})
check("GAP60", "P60: the side's tangent at q_j is perpendicular to q_j - q_{j+1} (direction 300)",
      sgn(dot(e(300), qj - qj1)) == 0)
# t_{j+3} never reaches q_j: |q_j - q_{j+2}| >= sqrt3 for alpha_{j+2} in {60, 120, 180}
for a2 in (60, 120, 180):
    qj2 = e(90 + a1 + a2)
    check("GAP60", f"P60: |q_j - q_{{j+2}}|^2 >= 3 at alpha_{{j+2}} = {a2}", sgn(d2(qj, qj2) - 3) in (0, 1))
# the open side (arc of omega(q_{j+1}) from p to q_j) lies in B(w0, 1): its midpoint q_{j+1} + e(0)
m = qj1 + e(0)
check("GAP60", "P60: the side's midpoint q_{j+1} + e(0) is on omega(q_{j+1}) between p and q_j, inside B(w0, 1)",
      sgn(d2(m, w0) - 1) == -1 and d2(m, qj1) == 1)
check("GAP60", "P60: p and q_j are the two points of omega(w0) meeting omega(q_{j+1})",
      d2(p, w0) == 1 and d2(qj, w0) == 1 and d2(p, qj1) == 1 and d2(qj, qj1) == 1)
# the open side lies outside closed B(q_{j+2}, 1): midpoint test at alpha_{j+2} = 60, 120
for a2 in (60, 120):
    qj2 = e(90 + a1 + a2)
    check("GAP60", f"P60: the side's midpoint lies outside closed B(q_{{j+2}}, 1) at alpha_{{j+2}} = {a2}",
          sgn(d2(m, qj2) - 1) == 1)
# N4-OPP: the branch of omega(q_j) at p along 180 bends toward q_j: its point q_j + e(270 - 15) has direction in (60, 180)
b = qj + e(255)
ang = sp.atan2(b[1], b[0]) * 180 / sp.pi
check("BASE", "OPP: the omega(q_j) branch at p, point q_j + e(255), has direction in (120, 180) from p",
      120 < sp.N(ang, 30) < 180 and d2(b, qj) == 1)

# --- PIN180: a 180-degree cone puts T_{j+1}'s sector outside closed B(q_j, 1) beside e_{j+1} -------------------------
for deg in (181, 185):
    x = sp.Rational(1, 10) * sp.Matrix([sp.cos(sp.pi * sp.Rational(deg, 180)), sp.sin(sp.pi * sp.Rational(deg, 180))])
    check("BASE", f"PIN180: r e({deg}) (r = 1/10) lies outside closed B(q_j, 1)", sp.N(d2(x, qj) - 1, 40) > 0)

# --- QE1: omega(q_j) crosses omega(p) at u = e(150) (phi_j + 60) at 60 degrees ---------------------------------------
u = e(150)
check("BASE", "QE1: |u - q_j| = 1 and |u - p| = 1 at u = e(phi_j + 60)", d2(u, qj) == 1 and d2(u, p) == 1)
# angle between the radii u - p and u - q_j is 60 degrees (so the circles cross at 60)
check("BASE", "QE1: the radii at u meet at 60 degrees (transversal crossing)",
      sp.simplify(dot(u - p, u - qj) - sp.Rational(1, 2)) == 0)

bad_base = [r_ for r_ in rows if r_[0] == "BASE" and not r_[2]]
bad_gap = [r_ for r_ in rows if r_[0] == "GAP60" and not r_[2]]
n_gap = sum(1 for r_ in rows if r_[0] == "GAP60")
for tag, name, ok in rows:
    print(f"{'OK ' if ok else 'BAD'}\t{tag}\t{name}")
print(f"SUMMARY: {len(rows)} lines; BASE failures {len(bad_base)}; GAP60 failures {len(bad_gap)} of {n_gap}; plant={'on' if PLANT else 'off'}")
if PLANT:
    ok = (not bad_base) and len(bad_gap) >= 1
    print("PLANT " + ("FIRES for its own reason (only GAP60 lines fail)" if ok else "DID NOT FIRE as designed"))
    sys.exit(0 if ok else 1)
sys.exit(0 if not (bad_base or bad_gap) else 1)

#!/usr/bin/env python3
"""FS110-CC: exact checks of the hand derivations in plans/FS110-CC-verification.md § Stage 2 (cusp vertices in FS110-CB's route).

Checks (each an exact check of a derived claim, seconds; no search for a witness):
  C2   the sign along a cusp's normal.  A circle arc of signed radius R (curvature 1/R toward n; R < 0 bends toward -n) tangent to
       tau = (1,0) at u = 0, rationally parametrised x(m) = (2Rm/(1+m^2), 2Rm^2/(1+m^2)), has
           |u + n - x(m)|^2 - 1 = 4 R (R - 1) m^2/(1+m^2),     |u - n - x(m)|^2 - 1 = 4 R (R + 1) m^2/(1+m^2)
       (sympy identity), so its sign is sign(1 - kappa), resp. sign(1 + kappa), at every point of the arc: never 0 when |kappa| != 1.
       Segment (kappa = 0): |u +- n - (s,0)|^2 - 1 = s^2.  Instances: the a6 horn (kappa = +1/2, -1/2, segment along -tau) and a horn
       straddling 1 (kappa = 3, 1/2).
  C4   a horn at the centre u meets omega(z), z = u + (1+t) e, when <tau, e> > 0: an exact certificate on the a6 horn with e = (3/5, 4/5):
       a vertical segment {r} x [-w, w] strictly inside the horn (outside both boundary discs) on which |p - z|^2 - 1 changes sign.
  C4'  along the normal (<tau, e> = 0): omega((0, 1+t)) meets the circle of curvature kappa tangent to tau at u, near u, iff kappa > 1
       (exact intersection: y = t(2+t) kappa / (2(kappa(1+t) - 1)), x^2 = y (2/kappa - y); a point exists iff x^2 >= 0 and y small).
  C5   no hexagon vertex x_i of D5 item 5 is a cusp, and its q-sector holds both +-30 deg branches and the outward normal: exhaustion of
       every placement of three boundary tangents on the 12 positions {0, 30, ..., 330 deg} (odd = a branch tangent, where a branch may
       enter any sector adjacent there; even = an open cell), every colour order, every branch choice.
Plants (--plant NAME), each predicted to make its check report a failure for the reason named:
  kappa1   C2 at kappa = 1 (R = 1): the normal's number is 0 identically -- the arc lies on omega(u + n); Condition 5 excluded.
  noOmega  C5 without the two Omega-branch constraints ((P) from u and the pseudo-colours): a cusp or a non-outer q becomes admissible.
"""
from __future__ import annotations
import sys
from fractions import Fraction as Fr
import itertools
import sympy as sp

PLANT = sys.argv[sys.argv.index("--plant") + 1] if "--plant" in sys.argv else None
FAIL = []


def say(ok, msg):
    print(("ok    " if ok else "FAIL  ") + msg)
    if not ok:
        FAIL.append(msg)


# ---------- C2 ----------
R, m, s = sp.symbols("R m s", real=True)
x = sp.Matrix([2 * R * m / (1 + m**2), 2 * R * m**2 / (1 + m**2)])
on_circle = sp.simplify(x[0]**2 + (x[1] - R)**2 - R**2)
say(on_circle == 0, "C2: x(m) lies on the circle centred (0,R) of radius |R| through u, tangent to tau")
for sgn, want in ((1, 4 * R * (R - 1) * m**2 / (1 + m**2)), (-1, 4 * R * (R + 1) * m**2 / (1 + m**2))):
    val = (x[0])**2 + (sgn - x[1])**2 - 1
    say(sp.simplify(val - want) == 0, f"C2: |u {'+' if sgn > 0 else '-'} n - x(m)|^2 - 1 = {want}")
seg = sp.simplify((-s)**2 + (1 - 0)**2 - 1)
say(seg == s**2, "C2: segment along -tau: |u + n - (-s,0)|^2 - 1 = s^2")


def normal_number(Rv, mv, sgn):
    """exact |u + sgn n - x(m)|^2 - 1 on the arc of signed radius Rv."""
    Rv, mv = Fr(Rv), Fr(mv)
    px, py = 2 * Rv * mv / (1 + mv * mv), 2 * Rv * mv * mv / (1 + mv * mv)
    return px * px + (sgn - py)**2 - 1


def horn_signs(name, radii, want_plus, want_minus):
    ms = [Fr(1, k) for k in (2, 3, 5, 10, 100, 1000, 10**6)]
    for sgn, want in ((1, want_plus), (-1, want_minus)):
        got = []
        for Rv in radii:
            vals = [normal_number(Rv, mv, sgn) for mv in ms] if Rv is not None else [Fr(1, k)**2 for k in (2, 10, 1000)]
            sg = {(v > 0) - (v < 0) for v in vals}
            got.append(sg.pop() if len(sg) == 1 else None)
        say(got == want, f"C2 {name}: signs along {'+' if sgn > 0 else '-'}n = {got} (want {want}; None = mixed or zero)")


horn_signs("a6 horn (kappa +1/2, -1/2, segment)", [2, -2, None], [1, 1, 1], [1, 1, 1])
horn_signs("straddling horn (kappa 3, 1/2, segment)", [Fr(1, 3), 2, None], [-1, 1, 1], [1, 1, 1])
if PLANT == "kappa1":
    horn_signs("PLANT kappa = 1", [1, -2, None], [1, 1, 1], [1, 1, 1])

# ---------- C4 ----------
t = Fr(1, 1000)
e = (Fr(3, 5), Fr(4, 5))
z = ((1 + t) * e[0], (1 + t) * e[1])
f = lambda p: (p[0] - z[0])**2 + (p[1] - z[1])**2 - 1
r = Fr(5, 3) * t
for _ in range(40):                                   # Newton on f(r, 0) = r^2 - (6/5)(1+t) r + 2t + t^2, kept rational
    g = r * r - Fr(6, 5) * (1 + t) * r + 2 * t + t * t
    r = (r - g / (2 * r - Fr(6, 5) * (1 + t))).limit_denominator(10**30)
w = r * r / 8
out_up = lambda p: p[0]**2 + (p[1] - 2)**2 > 4          # outside the upper boundary disc (centre (0,2), radius 2)
out_lo = lambda p: p[0]**2 + (p[1] + 2)**2 > 4
lo, hi = (r, -w), (r, w)
inside_horn = all(out_up(p) and out_lo(p) for p in (lo, hi, (r, Fr(0))))
say(inside_horn and 0 < r < Fr(1, 100), f"C4: the segment {{r}} x [-w, w], r = {float(r):.6g}, w = r^2/8, lies strictly inside the a6 horn")
say(f(lo) * f(hi) < 0, f"C4: |p - z|^2 - 1 changes sign on it ({float(f(lo)):.3g}, {float(f(hi)):.3g}): omega(z) meets the horn, <tau,e> = 3/5")

# ---------- C4' ----------
for kap in (Fr(3), Fr(2), Fr(3, 2), Fr(11, 10), Fr(9, 10), Fr(1, 2), Fr(-1, 2), Fr(-3)):
    for tt in (Fr(1, 100), Fr(1, 10**4)):
        y = tt * (2 + tt) * kap / (2 * (kap * (1 + tt) - 1))
        x2 = y * (2 / kap - y)
        meets = x2 >= 0 and abs(y) < Fr(1, 10)
        say(meets == (kap > 1), f"C4': kappa = {kap}, t = {tt}: omega((0,1+t)) meets the arc near u: {meets} (want {kap > 1})")

# ---------- C5 ----------
CM, CI, Q = "c_{i-1}", "c_i", "q"
BR = {3: (CI,), 9: (CM,), 1: (CM, Q), 7: (CM, Q), 5: (CI, Q), 11: (CI, Q)}   # position (x30 deg) -> allowed colours
if PLANT == "noOmega":
    BR = {1: (CM, Q), 7: (CM, Q), 5: (CI, Q), 11: (CI, Q)}


def sectors(p):
    """three boundary positions p1 <= p2 <= p3 on Z12 -> sectors as (start, end) lifts, end >= start, end - start <= 12."""
    p1, p2, p3 = p
    return [(p1, p2), (p2, p3), (p3, p1 + 12)]


def options(d, secs, cols):
    """colours a branch with tangent position d (odd) may enter."""
    opts = set()
    for (a, b), c in zip(secs, cols):
        for dd in (d, d + 12, d - 12):
            if a < dd < b:
                opts.add(c)
            if dd == a or dd == b:
                opts.add(c)                              # adjacent along a boundary tangent (curvature decides): allowed either way
    return opts


n_adm, bad = 0, []
for p in itertools.combinations_with_replacement(range(12), 3):
    secs = sectors(p)
    for cols in itertools.permutations((CM, CI, Q)):
        opt = {d: options(d, secs, cols) & set(allowed) for d, allowed in BR.items()}
        if any(not o for o in opt.values()):
            continue
        n_adm += 1
        thin = any(a == b for a, b in secs) or any(b - a == 12 for a, b in secs)
        qa, qb = secs[cols.index(Q)]
        q_has_0 = any(qa < dd < qb for dd in (0, 12, 24))
        forced30 = opt.get(1) == {Q} and opt.get(11) == {Q}
        if thin or not q_has_0 or not forced30:
            bad.append((p, cols, {d: sorted(o) for d, o in opt.items()}))
say(n_adm > 0 and not bad, f"C5: {n_adm} admissible placements; none has a cusp/thin sector, a q-sector missing 0 deg, "
    f"or a +-30 deg branch outside q ({len(bad)} violations)")
for b in bad[:3]:
    print("      e.g.", b)

print("ALL AS PREDICTED" if not FAIL else f"{len(FAIL)} FAILURE(S)")
sys.exit(0 if not FAIL else 1)

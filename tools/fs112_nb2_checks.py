#!/usr/bin/env python3
"""FS112-NB2 exact checks of derived identities (blind round-2 verifier of FS-112's proof side).

Each check verifies an identity or inequality my stage-1 derivations use, at named values, in exact arithmetic
(fractions / sympy).  Nothing here searches: every input is a named value or a formula.  Each check has a planted
twin that must FAIL for the reason named in its docstring; `--self-test` runs every faithful check (must pass) and
every plant (must fail with its own named reason).  Exit status: 0 iff every faithful check passes and, under
--self-test, every plant fires.

Checks
  RAY      the one-sided chain lambda_k = -1/(k+1), upsilon_k = 0 satisfies N4-FIN's two inequalities for k >= 0 with
           equality in lambda (f(lambda_{k+1}) = lambda_k), lies in [-1, 0) with -1 only at k = 0, and is the family of
           concentric circles of radius k+1 about P_{-1} (upward curvature 1/(C - j) with C = -1, j = k).
           Plant: extend the ray to k = -1; the downward step needs f(lambda_0) = f(-1), a pole -> fires.
  R2       f(-1/2) = -1: a tile at P_{k+1} bounded by the radius-2 circle about P_{k-1} shadows at P_k exactly the unit
           circle omega(P_{k-1}).  Plant: f(-1/3) = -1 -> fires (it is -1/2).
  SIGN     |P + 2e_w - (P + e_{w'})|^2 = 5 - 4cos(theta) >= 1, equality only at theta = 0 (a point on the radius-2 circle
           is >= 1 from the whole unit circle).  Plant: a point at radius 1.9 is < 1 from w and > 1 from w' at 60 deg
           (a sign change) -> fires.
  INTYPE   a point of T_out just outside alpha near an end A lies outside the closed unit disc about Q_A = A + e_A
           (so an in-type s_out tile at Q_A would break N-E2's Siamese branch).  Plant: a point just below
           omega(Q_A) (inside the disc) instead -> fires.
  ENV      exact |y - w_{phi+theta}|^2 against the second-order forms used in N2-ENV's derivation (toward and away
           lenses), error third order at named values; and the two minimisation identities
           min_t [2t sin b + t^2 (1 - cos b)] = -(1 + cos b) at t = -cot(b/2)   (toward),
           min_t [-2t sin b + t^2 (1 + cos b)] = -(1 - cos b) at t = tan(b/2)    (away).
           Plant: the away form with the linear term's sign flipped -> first-order error, fires.
"""
from __future__ import annotations

import sys
from fractions import Fraction as Fr

import sympy as sp


class CheckFailed(Exception):
    pass


def f(lam):
    """Shadow map going down: an arc of upward curvature lam at P_{k+1} gives curvature lam/(1+lam) at P_k."""
    if lam == -1:
        raise CheckFailed("pole: f(-1) undefined (downward step from a unit arc centred at the next point)")
    return lam / (1 + lam)


def ftilde(ups):
    if ups == 1:
        raise CheckFailed("pole: ftilde(1) undefined")
    return ups / (1 - ups)


# ---------------------------------------------------------------- RAY
def check_ray(k_start: int = 0, k_end: int = 60) -> str:
    lam = {k: Fr(-1, k + 1) if k + 1 != 0 else None for k in range(k_start, k_end + 1)}
    ups = {k: Fr(0) for k in range(k_start, k_end + 1)}
    for k in range(k_start, k_end):
        if lam[k] is None or lam[k + 1] is None:
            raise CheckFailed(f"pole: lambda_{k} = -1/0 (the ray cannot be extended to k = {k})")
        if not lam[k] <= f(lam[k + 1]):
            raise CheckFailed(f"FIN lambda inequality fails at k={k}")
        if lam[k] != f(lam[k + 1]):
            raise CheckFailed(f"lambda equality (concentric) fails at k={k}")
        if not ftilde(ups[k]) <= ups[k + 1]:
            raise CheckFailed(f"FIN upsilon inequality fails at k={k}")
        if not lam[k] < ups[k]:
            raise CheckFailed(f"lambda_k < upsilon_k fails at k={k}")
    for k in range(k_start, k_end + 1):
        if not (Fr(-1) <= lam[k] < 0):
            raise CheckFailed(f"range fails at k={k}")
        if lam[k] == -1 and k != 0:
            raise CheckFailed(f"closed end -1 at an interior index k={k}")
        # concentric: circle about P_{-1} = v + C n with C = -1, read at P_k (j = k): curvature 1/(C - j)
        if Fr(1, -1 - k) != lam[k]:
            raise CheckFailed(f"concentric identity fails at k={k}")
    # the downward FIN step below k_start: lambda_{k_start - 1} <= f(lambda_{k_start}) needs f at -1 when k_start = 0
    try:
        f(lam[k_start])
        below = "defined"
    except CheckFailed:
        below = "pole"
    if k_start == 0 and below != "pole":
        raise CheckFailed("expected the downward step at the ray's end to hit the pole")
    return f"RAY ok: k={k_start}..{k_end}, lambda_k=-1/(k+1) equality, lambda_0=-1, downward step at k=0 is a pole"


def plant_ray() -> str:
    return check_ray(k_start=-1, k_end=10)  # must fire: lambda_{-1} = -1/0


# ---------------------------------------------------------------- R2
def check_r2(lam=Fr(-1, 2)) -> str:
    if f(lam) != -1:
        raise CheckFailed(f"R2 shadow: f({lam}) = {f(lam)} != -1")
    # radius-2 circle about P_{k-1} read at P_{k+1}: centre C = k-1 relative, j = k+1 -> curvature 1/(C-j) = -1/2
    if Fr(1, (0 - 1) - 1) != Fr(-1, 2):
        raise CheckFailed("radius-2 curvature bookkeeping")
    return "R2 ok: f(-1/2) = -1 (the radius-2 tile's shadow is the unit circle itself)"


def plant_r2() -> str:
    return check_r2(lam=Fr(-1, 3))


# ---------------------------------------------------------------- SIGN
def dist2(p, q):
    return sp.nsimplify((p[0] - q[0]) ** 2 + (p[1] - q[1]) ** 2)


def check_sign(radius=2) -> str:
    th = sp.symbols("theta", real=True)
    x = (sp.nsimplify(radius), sp.Integer(0))  # P = origin, w = e_0
    vals = []
    for t in (sp.Integer(0), sp.pi / 6, sp.pi / 3, sp.pi / 4):
        w2 = (sp.cos(t), sp.sin(t))
        d2 = sp.simplify(dist2(x, w2))
        vals.append((t, d2))
    if radius == 2:
        expr = sp.simplify(dist2(x, (sp.cos(th), sp.sin(th))) - (5 - 4 * sp.cos(th)))
        if expr != 0:
            raise CheckFailed("identity 5 - 4 cos theta fails")
    lt = [t for t, d in vals if sp.simplify(d - 1) < 0]
    gt = [t for t, d in vals if sp.simplify(d - 1) > 0]
    if lt and gt:
        raise CheckFailed(f"sign change: point at radius {radius} is <1 from theta in {lt} and >1 from theta in {gt}")
    eq = [t for t, d in vals if sp.simplify(d - 1) == 0]
    if radius == 2 and eq != [0]:
        raise CheckFailed(f"equality set {eq} != [0]")
    return "SIGN ok: |2e_0 - e_theta|^2 = 5 - 4cos theta >= 1, equality only at theta = 0"


def plant_sign() -> str:
    return check_sign(radius=sp.Rational(19, 10))


# ---------------------------------------------------------------- INTYPE
def check_intype(plant: bool = False) -> str:
    # frame at the end vertex A = origin; e_A = (0,1) (outward normal of alpha at A); tau = (1,0); P = (0,-1);
    # alpha near A: y = -1 + sqrt(1 - x^2) ~ -x^2/2 ; Q_A = (0, 1).
    s = Fr(1, 10)
    eps = Fr(1, 1000)
    Q = (Fr(0), Fr(1))
    if not plant:
        y = -s * s / 2 + eps  # just above alpha (T_out side), second order
    else:
        y = s * s / 2 + eps  # just above omega(Q_A) (which is y ~ x^2/2 near A): inside B(Q_A, 1)
    d2 = (s - Q[0]) ** 2 + (y - Q[1]) ** 2
    if not d2 > 1:
        raise CheckFailed(f"point ({s},{y}) is inside the closed unit disc about Q_A (|p-Q|^2 = {d2})")
    # the point really is outside B(P,1) (T_out side of alpha): |p - P|^2 > 1
    dP = s * s + (y + 1) ** 2
    if not dP > 1:
        raise CheckFailed("faithful point not outside B(P,1)")
    return f"INTYPE ok: T_out point at (s,y)=({s},{y}) has |p-Q_A|^2={d2} > 1"


def plant_intype() -> str:
    return check_intype(plant=True)


# ---------------------------------------------------------------- ENV
def check_env(flip_sign: bool = False) -> str:
    # P = origin, w_phi = e_phi; toward: y = w_phi + (1+s) u, u = -rot(e_phi, b); away: u = +rot(e_phi, b).
    phi = sp.Rational(3, 10)
    out = []
    for b, th, s in ((sp.Rational(1, 7), sp.Rational(-1, 20), sp.Rational(1, 500)),
                     (sp.Rational(-1, 5), sp.Rational(1, 25), sp.Rational(1, 300))):
        e = lambda a: sp.Matrix([sp.cos(a), sp.sin(a)])
        for mode in ("toward", "away"):
            u = (-1 if mode == "toward" else 1) * e(phi + b)
            y = e(phi) + (1 + s) * u
            w = e(phi + th)
            exact = (y - w).dot(y - w)
            if mode == "toward":
                approx = 1 + 2 * s + 2 * th * sp.sin(b) + th ** 2 * (1 - sp.cos(b))
            else:
                lin = (2 if flip_sign else -2) * th * sp.sin(b)
                approx = 1 + 2 * s + lin + th ** 2 * (1 + sp.cos(b))
            err = abs(sp.N(exact - approx, 40))
            scale = max(abs(th), abs(s), abs(b) * abs(th)) ** 3 * 20 + abs(s) ** 2 * 5 + abs(s * th) * 5
            if not err <= sp.N(scale, 40):
                raise CheckFailed(f"ENV {mode} expansion error {err} exceeds third-order scale {sp.N(scale)} (b={b}, th={th}, s={s})")
            out.append(f"{mode} b={b} th={th}: err={float(err):.2e}")
    bb, t = sp.symbols("b t", real=True)
    tow = 2 * t * sp.sin(bb) + t ** 2 * (1 - sp.cos(bb))
    awy = -2 * t * sp.sin(bb) + t ** 2 * (1 + sp.cos(bb))
    for name, g, tstar, val in (("toward", tow, -sp.cot(bb / 2), -(1 + sp.cos(bb))),
                                ("away", awy, sp.tan(bb / 2), -(1 - sp.cos(bb)))):
        for bv in (sp.Rational(1, 3), sp.Rational(-2, 5), sp.Rational(7, 10)):
            if abs(sp.N(sp.diff(g, t).subs(t, tstar).subs(bb, bv), 50)) > 1e-40:
                raise CheckFailed(f"ENV {name}: t* not stationary at b={bv}")
            if abs(sp.N((g.subs(t, tstar) - val).subs(bb, bv), 50)) > 1e-40:
                raise CheckFailed(f"ENV {name}: minimum value identity fails at b={bv}")
    return "ENV ok: " + "; ".join(out) + "; minimisation identities hold"


def plant_env() -> str:
    return check_env(flip_sign=True)


CHECKS = [("RAY", check_ray, plant_ray, "pole"),
          ("R2", check_r2, plant_r2, "R2 shadow"),
          ("SIGN", check_sign, plant_sign, "sign change"),
          ("INTYPE", check_intype, plant_intype, "inside the closed unit disc"),
          ("ENV", check_env, plant_env, "expansion error")]


def main(argv) -> int:
    self_test = "--self-test" in argv
    ok = True
    for name, chk, plant, reason in CHECKS:
        try:
            print(chk())
        except CheckFailed as exc:
            ok = False
            print(f"FAIL {name}: {exc}")
        if self_test:
            try:
                msg = plant()
                ok = False
                print(f"PLANT {name} DID NOT FIRE (returned: {msg})")
            except CheckFailed as exc:
                if reason in str(exc):
                    print(f"plant {name} fired for its own reason: {exc}")
                else:
                    ok = False
                    print(f"PLANT {name} fired for the WRONG reason: {exc}")
    print("ALL CHECKS PASS" if ok else "SOME CHECK FAILED")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))

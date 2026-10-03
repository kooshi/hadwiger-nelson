#!/usr/bin/env python3
"""FS116-V5 — exact checks of the plane geometry the hand derivations of stage 2 consume (sympy, exact).

Subcommands (each prints one line; a planted fault is a changed argument, and must print something else):
  dist <spacing>        hubs y_k = e(spacing*k), q_1 = y_1 + y_2: the distance facts used (unit neighbours, sqrt3 at two steps,
                        2 antipodal, |q_1 - y_1| = |q_1 - y_2| = 1, |q_1 - y_0| = |q_1 - y_3| = 2, |q_1 - y_4| = |q_1 - y_5| = sqrt7);
                        prints "exact 10/10" when all hold, else the count and the failures
  germ <shift>          first-order motion of the two points of w(z) ∩ w(p) for z = y_0 + t e(beta): d/dt of the upper angle is
                        (2/sqrt3) sin(beta - shift) and of the lower (2/sqrt3) sin(beta + shift); true at shift = 30
  astar <c>             the arc A* = w(q_1) ∩ B(p,1): |q_1 + e(th)|^2 = 4 + 2 sqrt3 cos(th - 90) is below 1 exactly on (240, 300);
                        |q_1 + e(th) - y_0|^2 = 5 + 4 cos(th - 120) and |q_1 + e(th) - y_3|^2 = 5 + 4 cos(th - 60), each >= 1 with equality
                        only at th = 300, resp. 240 (external tangency); <c> is the constant term checked (5 is true)
  out <k>               |e(psi) + s e(gam) - s' e(del)|^2 = 1 + 2 s cos(gam - psi) - 2 s' cos(del - psi) + (quadratic in s, s'); <k> the linear coefficient checked (2 is true)
"""
import sys
import sympy as sp

D = sp.pi / 180


def e(th):
    return sp.Matrix([sp.cos(th * D), sp.sin(th * D)])


def nrm2(v):
    return sp.nsimplify(sp.simplify(v.dot(v)))


def cmd_dist(spacing):
    y = [e(spacing * k) for k in range(6)]
    q1 = y[1] + y[2]
    facts = [
        ("|y0-y1|^2", nrm2(y[0] - y[1]), 1), ("|y0-y2|^2", nrm2(y[0] - y[2]), 3), ("|y0-y3|^2", nrm2(y[0] - y[3]), 4),
        ("|q1|^2", nrm2(q1), 3), ("|q1-y1|^2", nrm2(q1 - y[1]), 1), ("|q1-y2|^2", nrm2(q1 - y[2]), 1),
        ("|q1-y0|^2", nrm2(q1 - y[0]), 4), ("|q1-y3|^2", nrm2(q1 - y[3]), 4), ("|q1-y4|^2", nrm2(q1 - y[4]), 7),
        ("|q1-y5|^2", nrm2(q1 - y[5]), 7),
    ]
    bad = [f"{n}={sp.simplify(v)}" for n, v, w in facts if sp.simplify(v - w) != 0]
    print(f"exact {len(facts) - len(bad)}/{len(facts)}" + ("" if not bad else " FAIL " + " ".join(bad)))


def cmd_germ(shift):
    t, b = sp.symbols("t beta", real=True)
    z = sp.Matrix([1 + t * sp.cos(b), t * sp.sin(b)])
    rho = sp.sqrt(z.dot(z))
    phi = sp.atan2(z[1], z[0])
    alpha = sp.acos(rho / 2)
    up, lo = phi + alpha, phi - alpha
    dup = sp.simplify(sp.diff(up, t).subs(t, 0))
    dlo = sp.simplify(sp.diff(lo, t).subs(t, 0))
    s = shift * D
    eu = sp.simplify(dup - 2 / sp.sqrt(3) * sp.sin(b - s))
    el = sp.simplify(dlo - 2 / sp.sqrt(3) * sp.sin(b + s))
    ok = (sp.simplify(sp.expand_trig(eu)) == 0) and (sp.simplify(sp.expand_trig(el)) == 0)
    # also confirm the zeroth order: the two points are at +-60 degrees
    z0 = [sp.simplify(up.subs(t, 0) - sp.pi / 3), sp.simplify(lo.subs(t, 0) + sp.pi / 3)]
    print("germ first-order " + ("exact" if ok and z0 == [0, 0] else f"FAIL residues {eu} ; {el} ; {z0}"))


def cmd_astar(c):
    th = sp.symbols("theta", real=True)
    q1 = sp.Matrix([0, sp.sqrt(3)])
    y0, y3 = e(0), e(180)
    f = sp.simplify(nrm2(q1 + e(th)) - (4 + 2 * sp.sqrt(3) * sp.cos((th - 90) * D)))
    g0 = sp.simplify(sp.expand_trig(nrm2(q1 + e(th) - y0) - (c + 4 * sp.cos((th - 120) * D))))
    g3 = sp.simplify(sp.expand_trig(nrm2(q1 + e(th) - y3) - (c + 4 * sp.cos((th - 60) * D))))
    # |q1 + e(th)|^2 = 1 exactly at 240 and 300, below between, above outside (exact values at named points)
    vals = {a: sp.nsimplify(sp.simplify(4 + 2 * sp.sqrt(3) * sp.cos((a - 90) * D))) for a in (230, 240, 270, 300, 310)}
    pts = (vals[240] == 1 and vals[300] == 1 and vals[270] < 1 and vals[230] > 1 and vals[310] > 1)
    ok = (f == 0 and g0 == 0 and g3 == 0 and pts)
    print("astar " + ("exact" if ok else f"FAIL f={f} g0={g0} g3={g3} vals={vals}"))


def cmd_out(k):
    s, s2, psi, gam, dl = sp.symbols("s s2 psi gam del", real=True)
    E = lambda a: sp.Matrix([sp.cos(a), sp.sin(a)])
    v = E(psi) + s * E(gam) - s2 * E(dl)
    expr = sp.expand(v.dot(v))
    lin = sp.simplify(sp.expand_trig(expr.coeff(s, 1).subs(s2, 0) - k * sp.cos(gam - psi)))
    lin2 = sp.simplify(sp.expand_trig(expr.coeff(s2, 1).subs(s, 0) + k * sp.cos(dl - psi)))
    const = sp.simplify(expr.subs({s: 0, s2: 0}))
    print("out " + ("exact" if lin == 0 and lin2 == 0 and const == 1 else f"FAIL {lin} {lin2} {const}"))


def main():
    a = sys.argv[1:]
    if not a:
        print(__doc__)
        sys.exit(2)
    if a[0] == "dist":
        cmd_dist(sp.Integer(a[1]))
    elif a[0] == "germ":
        cmd_germ(sp.Integer(a[1]))
    elif a[0] == "astar":
        cmd_astar(sp.Integer(a[1]))
    elif a[0] == "out":
        cmd_out(sp.Integer(a[1]))
    else:
        print("unknown subcommand", a[0])
        sys.exit(2)


if __name__ == "__main__":
    main()

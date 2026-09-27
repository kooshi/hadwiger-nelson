#!/usr/bin/env python3
"""FS110-N4: exact checks of the shadow calculus on the normal line (plans/FS110-N-proof.md, stage N4-2).

Frame: v = (0,0), n = (0,1), N = (0,1), S' = (0,-1), a = (1,0).  An arc tangent to a at a point P = (0,p) of the normal
line is a circle with centre (0, C) on that line (C = oo: the tangent line).  Its "upward curvature" at P is 1/(C - p).

C1  the shadow at v of the far side of an arc at N with centre C (N4-SHADOW): for named points z near v with z_x > 0,
    dist(z, far side) < 1  <=>  z on the N-side of the circle through v with centre C; and the nearest point of the
    circle of the arc to z has positive x (it lies on the +a half of the arc).  Exact (sympy, algebraic numbers).
C2  the curvature maps: the circle through P_k concentric with an arc at P_{k+1} of curvature lam has curvature
    f(lam) = lam/(1+lam) at P_k; concentric with an arc at P_{k-1} of curvature ups: ft(ups) = ups/(1-ups); ft(f(x)) = x;
    1/f(x) = 1/x + 1, 1/ft(x) = 1/x - 1.  Symbolic.
C3  N4-FIN at named values: the extremal recursions ups -> ft(ups) (ups > 0) and lam -> f(lam) (lam < 0, going down)
    leave (-1, 1) within the step bounds of the proof.
C4  the Townsend exclusion: C = v (arc of radius 1 at N) is the only centre at which the shadow circle through v
    degenerates (radius 0).

Planted faults (--plant NAME), each must make its own check fail:
    wrongf     C2 with f(lam) = lam/(1-lam)            -> C2 fails (the concentric-curvature identity breaks)
    nearside   C1 with the arc's far side replaced by its near side -> C1 fails (the equivalence breaks)
    downward   C3 iterating f instead of ft upward      -> C3 fails (the sequence never leaves (-1, 1))
Exit status 0 iff every check passes (with no plant) ; with a plant, exit 0 iff the targeted check FAILS.
"""
import sys
import sympy as sp

PLANT = None
if len(sys.argv) == 3 and sys.argv[1] == "--plant":
    PLANT = sys.argv[2]
elif len(sys.argv) != 1:
    print("usage: fs110_n_shadow.py [--plant wrongf|nearside|downward]")
    sys.exit(2)


def check_c1():
    """N4-SHADOW at named centres and named points."""
    ok = True
    # named centres (heights on the normal line) of an out-type arc at N; C must lie outside [0, 1]
    centres = [sp.Integer(3), sp.Rational(5, 2), sp.Integer(-2), sp.Rational(-7, 3), sp.Rational(9, 4)]
    # named points z near v with positive x
    pts = [(sp.Rational(1, 50), sp.Rational(1, 10**4)), (sp.Rational(1, 40), sp.Rational(-1, 10**3)),
           (sp.Rational(1, 30), sp.Rational(1, 10**3)), (sp.Rational(1, 60), sp.Rational(3, 10**4)),
           (sp.Rational(1, 45), sp.Rational(-3, 10**4)), (sp.Rational(1, 35), sp.Rational(5, 10**4))]
    N = sp.Matrix([0, 1])
    for C in centres:
        c = sp.Matrix([0, C])
        R = abs(C - 1)                       # radius of the arc at N
        for (x, y) in pts:
            z = sp.Matrix([x, y])
            dz = sp.sqrt((z - c).dot(z - c))
            # far side of the arc (away from v): inside the arc's disc if C > 1, outside it if C < 0
            far_inside = C > 1
            if PLANT == "nearside":
                far_inside = not far_inside
            # z is inside the arc's disc iff |z - c| < R ; distance from z to the far side
            z_inside = sp.simplify(dz - R) < 0
            if far_inside:
                dist = 0 if z_inside else dz - R
            else:
                dist = 0 if not z_inside else R - dz
            in_shadow = sp.simplify(dist - 1) < 0 and dist != 0
            # N-side of the circle through v with centre c: inside it if C > 0, outside if C < 0
            r0 = abs(C)
            nside = (sp.simplify(dz - r0) < 0) if C > 0 else (sp.simplify(dz - r0) > 0)
            # nearest point of the arc's circle to z: c + R (z - c)/|z - c| ; its x must be positive
            foot_x = sp.simplify(R * (z - c)[0] / dz)
            if bool(in_shadow) != bool(nside) or not (foot_x > 0):
                ok = False
                print(f"  C1 FAIL: C={C} z=({x},{y}) shadow={in_shadow} N-side={nside} foot_x={foot_x}")
    return ok


def f(x):
    if PLANT == "wrongf":
        return x / (1 - x)
    return x / (1 + x)


def ft(x):
    return x / (1 - x)


def check_c2():
    lam, ups, k = sp.symbols("lam ups k", real=True)
    ok = True
    # arc at P_{k+1} with curvature lam: centre at height (k+1) + 1/lam; circle through P_k: curvature 1/(centre - k)
    conc_down = 1 / ((k + 1 + 1 / lam) - k)
    if sp.simplify(conc_down - f(lam)) != 0:
        ok = False
        print("  C2 FAIL: concentric curvature going down is not f")
    conc_up = 1 / ((k - 1 + 1 / ups) - k)
    if sp.simplify(conc_up - ft(ups)) != 0:
        ok = False
        print("  C2 FAIL: concentric curvature going up is not ft")
    if sp.simplify(ft(f(lam)) - lam) != 0:
        ok = False
        print("  C2 FAIL: ft(f(x)) != x")
    if sp.simplify(1 / f(lam) - (1 / lam + 1)) != 0 or sp.simplify(1 / ft(ups) - (1 / ups - 1)) != 0:
        ok = False
        print("  C2 FAIL: reciprocal identities")
    return ok


def check_c3():
    ok = True
    up = f if PLANT == "downward" else ft
    for u0 in [sp.Rational(1, 2), sp.Rational(1, 3), sp.Rational(1, 10), sp.Rational(3, 7)]:
        u, steps, bound = u0, 0, sp.ceiling(1 / u0)
        while -1 < u < 1 and steps <= bound + 1:
            u = up(u) if (1 - u) != 0 else sp.oo
            steps += 1
        if -1 < u < 1:
            ok = False
            print(f"  C3 FAIL: ups0={u0} still in (-1,1) after {steps} steps")
        elif steps > bound:
            ok = False
            print(f"  C3 FAIL: ups0={u0} left (-1,1) only after {steps} > {bound} steps")
    for l0 in [sp.Rational(-1, 2), sp.Rational(-1, 10), sp.Rational(-2, 7)]:
        l, steps, bound = l0, 0, sp.ceiling(-1 / l0)
        while -1 < l < 1 and steps <= bound + 1:
            l = f(l) if (1 + l) != 0 else -sp.oo
            steps += 1
        if -1 < l < 1 or steps > bound:
            ok = False
            print(f"  C3 FAIL: lam0={l0} steps={steps} last={l}")
    return ok


def check_c4():
    # shadow circle through v concentric with an arc at N of centre C has radius |C|; it degenerates only at C = 0 (= v),
    # i.e. an arc of radius |0 - 1| = 1 at N: the unit arc Condition 5 forbids (Townsend's sector lives there).
    C = sp.symbols("C", real=True)
    sols = sp.solve(sp.Eq(sp.Abs(C), 0), C)
    return sols == [0] and abs(0 - 1) == 1


RESULTS = {"C1": check_c1(), "C2": check_c2(), "C3": check_c3(), "C4": check_c4()}
for name, res in RESULTS.items():
    print(f"{name}: {'PASS' if res else 'FAIL'}")

TARGET = {"wrongf": "C2", "nearside": "C1", "downward": "C3"}
if PLANT is None:
    sys.exit(0 if all(RESULTS.values()) else 1)
if PLANT not in TARGET:
    print("unknown plant")
    sys.exit(2)
fired = not RESULTS[TARGET[PLANT]]

print(f"plant {PLANT}: target {TARGET[PLANT]} {'FIRED' if fired else 'DID NOT FIRE'}")
sys.exit(0 if fired else 1)

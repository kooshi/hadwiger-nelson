#!/usr/bin/env python3
"""FS129-SR1-TWOCIRC: two unit circles about a unit pair.

Frame: p = 0, y0 = e(0), y1 = e(60 deg) (so |y0 - y1| = 1 and p is the apex at distance 1 from both).
a(s) = y0 + e(120 + s) is the point of omega(y0) at angle s from y1 toward p (a(0) = y1, a(60) = p);
b(t) = y1 + e(300 - t) is the point of omega(y1) at angle t from y0 toward p (b(0) = y0, b(60) = p).

Checks, exactly (sympy):
  1. |a(s) - b(t)|^2 - 1 == -8 sin(s/2) sin(t/2) cos((s+t)/2)            (FS116-V6-HUG's display)
  2. the same == 2(1 - cos s)(1 - cos t) - 2 sin s sin t                    (FS114-YB4-2ND's form of PXKILL's pair)
  3. on the diagonal s = t = phi: |a - b| == 2 cos(phi) - 1 for 0 <= phi <= 60   (FS116-Y4-FLANK's model)
  4. the sign: < 1 for s, t in (0, 180) with s + t < 180, = 1 on s + t = 180, > 1 for s + t in (180, 360) — on a rational grid of
     angles, by exact evaluation of the product form's sign (each factor's sign decided exactly)
  5. the other Reuleaux triangle (V6-ADJ's arcs run outward, a = y1 + e(-60 + s), b = y0 + e(120 - t)) is the mirror: the same identity
Faults: --fault-sign (a(s) built with e(120 - s): the identity fails); --fault-diag (2 cos phi + 1 in check 3: fails).
Prints 'twocirc ok' on success; exits 1 otherwise.
"""
import sys
import sympy as sp

s, t, phi = sp.symbols('s t phi', real=True)
deg = sp.pi / 180


def e(theta):
    return sp.Matrix([sp.cos(theta), sp.sin(theta)])


def main():
    fault_sign = '--fault-sign' in sys.argv
    fault_diag = '--fault-diag' in sys.argv
    y0 = e(0)
    y1 = e(60 * deg)
    a = y0 + e((120 * deg) + (-s if fault_sign else s))
    b = y1 + e(300 * deg - t)
    d2 = sp.expand((a - b).dot(a - b))
    lhs = d2 - 1
    prod = -8 * sp.sin(s / 2) * sp.sin(t / 2) * sp.cos((s + t) / 2)
    expd = 2 * (1 - sp.cos(s)) * (1 - sp.cos(t)) - 2 * sp.sin(s) * sp.sin(t)
    ok = True
    if sp.simplify(sp.expand_trig(lhs - prod)) != 0:
        print('identity (product form): FAIL'); ok = False
    if sp.simplify(sp.expand_trig(prod - expd)) != 0:
        print('identity (expanded form): FAIL'); ok = False
    # 3. the diagonal
    diag = sp.sqrt(sp.simplify(d2.subs({s: phi, t: phi})))
    target = 2 * sp.cos(phi) + (1 if fault_diag else -1)
    for k in range(0, 61, 5):
        val = sp.nsimplify(k) * deg
        if sp.simplify(sp.expand_trig((diag.subs(phi, val)) ** 2 - target.subs(phi, val) ** 2)) != 0 or target.subs(phi, val) < 0:
            print('diagonal at', k, 'deg: FAIL'); ok = False; break
    # 4. the sign on a grid of angles (degrees, step 15), exact
    for si in range(15, 360, 15):
        for ti in range(15, 360 - si, 15):
            v = sp.nsimplify(lhs.subs({s: si * deg, t: ti * deg}))
            v = sp.simplify(v)
            want = -1 if si + ti < 180 else (0 if si + ti == 180 else 1)
            if sp.sign(v) != want:
                print('sign at', si, ti, ': got', sp.sign(v), 'want', want); ok = False
                break
        if not ok:
            break
    # 5. the mirror (V6-ADJ)
    a2 = y1 + e(-60 * deg + s)
    b2 = y0 + e(120 * deg - t)
    lhs2 = sp.expand((a2 - b2).dot(a2 - b2)) - 1
    if sp.simplify(sp.expand_trig(lhs2 - prod)) != 0:
        print('mirror (V6-ADJ): FAIL'); ok = False
    if ok:
        print('twocirc ok')
        return 0
    return 1


if __name__ == '__main__':
    rc = main()
    # a planted fault must run cleanly and print its failure (the derive gate's rule); only the unfaulted run exits non-zero on failure
    sys.exit(0 if any(a.startswith('--fault') for a in sys.argv[1:]) else rc)

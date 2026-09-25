#!/usr/bin/env python3
"""FS-89 S1D: exact checks of the finite claims behind the corner lemma (D1-L4, D1-L5 in plans/FS89-S1D-derivation.md).

Not a search: every check is a finite exact computation over digit classes (5 or 13 of them) that a derived lemma
quantifies over.  Model (D0-T1): arrays e_{m,n} in Q = [1/4,3/4]^2 (mod Z[i]) with
    e_{m+1,n} - wb5  e_{m,n} in pi5^{-1} Z[i],     e_{m,n+1} - wb13 e_{m,n} in pi13^{-1} Z[i],
pi5 = 2+i, pi13 = 3+2i, w = pi/pibar, wb = conj(w).  Backward steps: e_{m-1,n} in w5 e_{m,n} + pibar5^{-1} Z[i], etc.

Checks:
  A  the corner characters: e0 in (1+i)/4 + (1/2)Z[i]; w5 = -1, w13 = 1 mod 4; their arrays are (-1)^m c0.
  B  D0-L3 (unique square completion) on every configuration used below.
  C  right/left exit: two vertically adjacent corner sites; every nonzero 5-digit deviation of the right (left)
     neighbours leaves Q at one of the two completed sites.
  D  up/down exit: three horizontally adjacent corner sites; every nonzero 13-digit deviation of the row above
     (below) leaves Q at one of the three sites.
  E  digit separation: the least length of a representative of a nonzero class of pi^{-1}Z[i]/Z[i].
  F  planted controls, each derived to fire: (i) right exit with wb13 replaced by 1 (the column recursion
     delta_{n+1} = wb13*delta_n becomes the identity: the rank-one freedom), must find admissible exits;
     (ii) up exit with wb5 replaced by -1 (eps -> -eps preserves the alternating admissible sets), must find exits;
     (iii) right exit with the band widened to [1/20, 19/20], must find exits.
  (A first version planted w13 -> 1 in the up exit and a 1/20 widening; neither can fire -- the up exit's multiplier
  is wb5 acting on the 13-digit, and a 1/20 widening leaves one admissible 5-class -- and both stayed silent.)
Usage: python3 tools/fs89_s1d_corner_check.py [--out data/fs89/s1d/corner-check.txt]
"""
from __future__ import annotations

import argparse
import sys
from fractions import Fraction as Fr
from itertools import product

G = tuple  # Gaussian rational (re, im)


def mul(a, b):
    return (a[0] * b[0] - a[1] * b[1], a[0] * b[1] + a[1] * b[0])


def add(a, b):
    return (a[0] + b[0], a[1] + b[1])


def neg(a):
    return (-a[0], -a[1])


def conj(a):
    return (a[0], -a[1])


def inv(a):
    n = a[0] ** 2 + a[1] ** 2
    return (a[0] / n, -a[1] / n)


def is_gauss_int(a):
    return a[0].denominator == 1 and a[1].denominator == 1


def red(a):
    """Representative mod Z[i] in [0,1)^2."""
    return (a[0] - (a[0].numerator // a[0].denominator), a[1] - (a[1].numerator // a[1].denominator))


def c(x, y=0):
    return (Fr(x), Fr(y))


PI5, PI13 = c(2, 1), c(3, 2)
W5 = mul(PI5, inv(conj(PI5)))
W13 = mul(PI13, inv(conj(PI13)))
WB5, WB13 = conj(W5), conj(W13)
assert W5 == (Fr(3, 5), Fr(4, 5)) and W13 == (Fr(5, 13), Fr(12, 13))


def in_lattice_inv(z, pi):
    """z in pi^{-1} Z[i] + Z[i] (= pi^{-1} Z[i])."""
    return is_gauss_int(mul(z, pi))


def classes(pi):
    """Representatives of pi^{-1}Z[i]/Z[i] (norm p elements), as k * conj(pi)/p, k = 0..p-1."""
    p = pi[0] ** 2 + pi[1] ** 2
    g = (conj(pi)[0] / p, conj(pi)[1] / p)
    out = [red(mul(c(k), g)) for k in range(int(p))]
    assert len(set(out)) == int(p)
    return out


LO, HI = Fr(1, 4), Fr(3, 4)


def in_Q(a, lo=None, hi=None):
    lo = LO if lo is None else lo
    hi = HI if hi is None else hi
    r = red(a)
    ok = lambda t: (lo <= t <= hi) or (lo <= t + 1 <= hi) or (lo <= t - 1 <= hi)
    return ok(r[0]) and ok(r[1])


def complete(A, B, wq, piq, wp, pip):
    """Unique D (mod Z[i]) with D - wq*A in piq^{-1}Z[i] and D - wp*B in pip^{-1}Z[i] (D0-L3).  Returns the list of
    solutions among the pip-classes; D0-L3 says exactly one."""
    sols = []
    for g in classes(pip):
        D = add(mul(wp, B), g)
        if in_lattice_inv(add(D, neg(mul(wq, A))), piq):
            sols.append(red(D))
    return sols


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--out", default=None)
    args = ap.parse_args()
    lines = []
    log = lines.append
    fails = 0

    # A: corners
    corners = [red(add(c(Fr(1, 4), Fr(1, 4)), c(Fr(a, 2), Fr(b, 2)))) for a, b in product(range(2), repeat=2)]
    inv5mod4 = pow(5, -1, 4)
    inv13mod4 = pow(13, -1, 4)
    w5mod4 = ((3 * inv5mod4) % 4, (4 * inv5mod4) % 4)
    w13mod4 = ((5 * inv13mod4) % 4, (12 * inv13mod4) % 4)
    log(f"A  corners {corners}; w5 mod 4 = {w5mod4} (= -1), w13 mod 4 = {w13mod4} (= 1)")
    fails += (w5mod4 != (3, 0)) + (w13mod4 != (1, 0))
    for c0 in corners:
        # corner array: e_{m,n} = (-1)^m c0; check both step rules and the band on |m|,|n| <= 3
        for m, n in product(range(-3, 4), repeat=2):
            e = red(c0 if m % 2 == 0 else neg(c0))
            e5 = red(c0 if (m + 1) % 2 == 0 else neg(c0))
            fails += not in_Q(e)
            fails += not in_lattice_inv(add(e5, neg(mul(WB5, e))), PI5)
            fails += not in_lattice_inv(add(e, neg(mul(WB13, e))), PI13)
    log(f"A  corner arrays satisfy both step rules and the band on |m|,|n|<=3: fails so far {fails}")

    def right_exit(lo=None, hi=None, wb13=WB13):
        """Sites (0,0),(0,1) = c0 (corner, same corner in the column). Right neighbours: (1,0) = -c0 + delta,
        (1,1) = completion.  Count nonzero delta keeping both in Q."""
        bad = []
        for c0 in corners:
            base = red(neg(c0))
            for d in classes(PI5)[1:]:
                A = red(add(base, d))           # e_{1,0}
                sols = complete(A, c0, wb13, PI13, WB5, PI5)  # e_{1,1} from e_{1,0} (13-step) and e_{0,1}=c0 (5-step)
                if wb13 == WB13:
                    assert len(sols) == 1, sols
                if in_Q(A, lo, hi) and any(in_Q(s, lo, hi) for s in sols):
                    bad.append((c0, d))
        return bad

    def left_exit():
        bad = []
        for c0 in corners:
            base = red(neg(c0))  # e_{-1,n} of the corner array
            for d in classes(conj(PI5))[1:]:
                A = red(add(base, d))           # e_{-1,0} = -c0 + delta, delta in pibar5^{-1}Z[i]
                # e_{-1,1}: 13-step from e_{-1,0}, and backward 5-step from e_{0,1} = c0: e_{-1,1} in W5*c0 + pibar5^{-1}
                sols = complete(A, c0, WB13, PI13, W5, conj(PI5))
                assert len(sols) == 1, sols
                if in_Q(A) and in_Q(sols[0]):
                    bad.append((c0, d))
        return bad

    def up_exit(wb5=WB5, wb13=WB13):
        """Row n = 0 corner at m = 0,1,2; row 1 at m=0 is c0 + eps (eps in pi13^{-1}); complete along the row."""
        bad = []
        for c0 in corners:
            row0 = [red(c0 if m % 2 == 0 else neg(c0)) for m in range(3)]
            for eps in classes(PI13)[1:]:
                r1 = [red(add(row0[0], eps))]
                for m in range(2):
                    sols = complete(r1[m], row0[m + 1], wb5, PI5, wb13, PI13)
                    # e_{m+1,1}: 5-step from e_{m,1}, 13-step from e_{m+1,0}
                    assert len(sols) == 1, sols
                    if not in_Q(sols[0]):
                        break
                    r1.append(sols[0])
                if len(r1) == 3 and all(in_Q(x) for x in r1):
                    bad.append((c0, eps))
        return bad

    def down_exit():
        bad = []
        for c0 in corners:
            row0 = [red(c0 if m % 2 == 0 else neg(c0)) for m in range(3)]
            for eps in classes(conj(PI13))[1:]:
                r1 = [red(add(row0[0], eps))]   # e_{0,-1} = c0 + eps, eps in pibar13^{-1}
                for m in range(2):
                    sols = complete(r1[m], row0[m + 1], WB5, PI5, W13, conj(PI13))
                    assert len(sols) == 1, sols
                    r1.append(sols[0])
                if all(in_Q(x) for x in r1):
                    bad.append((c0, eps))
        return bad

    for name, fn in (("C right", right_exit), ("C left", left_exit), ("D up", up_exit), ("D down", down_exit)):
        b = fn()
        log(f"{name}-exit: admissible nonzero deviations = {len(b)} (expected 0)")
        fails += len(b) != 0

    # per-site admissible counts (the hand computation in the record: 1 for 5-steps, 3 for 13-steps)
    for c0 in corners[:1]:
        n5 = sum(in_Q(add(neg(c0), d)) for d in classes(PI5)[1:])
        n13 = sum(in_Q(add(c0, d)) for d in classes(PI13)[1:])
        log(f"   single-site admissible nonzero classes at corner {c0}: 5-step {n5}, 13-step {n13}")

    # E: digit separation
    for pi in (PI5, conj(PI5), PI13, conj(PI13)):
        mn = min(min((d[0] + a) ** 2 + (d[1] + b) ** 2 for a in (-1, 0) for b in (-1, 0)) for d in classes(pi)[1:])
        log(f"E  least squared length of a nonzero class of pi^-1 Z[i]/Z[i], pi={pi}: {mn}")

    # F: planted controls (must go red: admissible exits appear)
    bF1 = right_exit(wb13=(Fr(1), Fr(0)))
    bF2 = up_exit(wb5=(Fr(-1), Fr(0)))
    bF3 = right_exit(lo=Fr(1, 20), hi=Fr(19, 20))
    log(f"F  plant (i) wb13 -> 1 in the right exit: admissible exits {len(bF1)} (must be > 0)")
    log(f"F  plant (ii) wb5 -> -1 in the up exit: admissible exits {len(bF2)} (must be > 0)")
    log(f"F  plant (iii) band [1/20, 19/20] in the right exit: admissible exits {len(bF3)} (must be > 0)")
    fails += (len(bF1) == 0) + (len(bF2) == 0) + (len(bF3) == 0)

    log(f"RESULT: {'PASS' if fails == 0 else 'FAIL'} (fails = {fails})")
    text = "\n".join(lines) + "\n"
    sys.stdout.write(text)
    if args.out:
        with open(args.out, "w") as f:
            f.write(text)
    return 0 if fails == 0 else 1


if __name__ == "__main__":
    sys.exit(main())

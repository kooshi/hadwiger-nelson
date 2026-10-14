#!/usr/bin/env python3
"""FS131-ICM2: a floating-point reading of the child `circleCos_bound` (ClassRatio), as stated — for each Q, the least over
(alpha, beta) in [0, Q)^2 minus (0, 0) of  sum over the circle {(a, b) in (Z/Q)^2 : a^2 + b^2 = 1} of
cos(2*pi*((alpha*a + beta*b) mod Q)/Q),  divided by Q + 1 (the normalised least eigenvalue). The child holds at Q exactly
when this is above -1/3 (then kappa = -min/(Q+1) serves, and kappa >= 2/(Q+1) is checked too).

Not a proof and not a search: an evaluation of the stated formula, a spec check. Control (--plant): Q = 11 and 19, where
Hoffman's bound is known to fail (FS131-KR1 § 2.6 (d): ratios 0.2855, 0.2756 > 1/4), must read FAILS.
"""
import math
import sys


def least(Q):
    circle = [(a, b) for a in range(Q) for b in range(Q) if (a * a + b * b) % Q == 1]
    assert len(circle) == Q + 1, (Q, len(circle))
    best = None
    for al in range(Q):
        for be in range(Q):
            if al == 0 and be == 0:
                continue
            s = sum(math.cos(2 * math.pi * ((al * a + be * b) % Q) / Q) for a, b in circle)
            if best is None or s < best[0]:
                best = (s, al, be)
    return best, len(circle)


def main(argv):
    qs = [11, 19] if "--plant" in argv else [23, 31]
    verdicts = []
    for Q in qs:
        (s, al, be), n = least(Q)
        norm = s / (Q + 1)
        holds = norm > -1 / 3 and -norm >= 2 / (Q + 1)
        verdicts.append(holds)
        print(f"Q={Q} circle={n} least={s:.9f} at (alpha,beta)=({al},{be}) normalised={norm:.9f} "
              f"margin={norm + 1/3:.3e} -> {'HOLDS' if holds else 'FAILS'}")
    if "--plant" in argv:
        ok = not any(verdicts)
        print("plant: " + ("both FAIL, as they must" if ok else "SILENT"))
        return 0 if ok else 1
    return 0 if all(verdicts) else 1


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))

#!/usr/bin/env python3
"""FS-81 stage C (the verifier's adversarial check of the gluing step): brute force over the layer torsion values
along one orbit of the type-M rotation.

For theta in Theta_3(Q(sqrt d)) the verifier's proof defines tau(x) = lim theta(25^{-k} x), a character of R_F with
tau(u) in {1/2, 1/3, 2/3} for every unit vector u (1/2 on a parity-type layer, 1/3 or 2/3 on an order-3 layer).
The type-M relation 1 = 2n - n v - n vbar, v = ((2n-1) + i sqrt d)/(2n), n = (d+1)/4, multiplied by any unit u gives
    tau(u) = 2n tau(u) - n tau(uv) - n tau(u vbar)      in Z/6 (values counted in sixths).
Along the orbit u_k = u0 v^k, k in [-W, W], this script enumerates EVERY assignment tau_k in {3, 2, 4} (sixths) and
keeps those satisfying the relation at every interior k (|k| <= W-1).  It is an attempt to build a slope with a
parity-type layer: the proof predicts
  * d = 11 (mod 12): no assignment at all (order-3 killed because 3 | n; then all-parity killed at the parity step);
  * d = 3, 7 (mod 12): every surviving assignment is order-3 at every interior k (Section F.5);
and it reports, for each rejected assignment with a parity-type interior layer, WHICH relation (the tau_2 or the tau_3
component) rejects it first, so that a failure "for a different reason" would show.
This checks the torsion bookkeeping only; L2's classification is an input, not tested here.
"""
from __future__ import annotations

import sys
from itertools import product


def analyse(d: int, W: int = 3):
    assert d % 4 == 3
    n = (d + 1) // 4
    ks = list(range(-W, W + 1))
    survivors = []
    reasons = {"tau2": 0, "tau3": 0}
    for vals in product((3, 2, 4), repeat=len(ks)):
        t = dict(zip(ks, vals))
        ok = True
        first = None
        for k in range(-W + 1, W):
            lhs, rhs = t[k], (2 * n * t[k] - n * t[k + 1] - n * t[k - 1]) % 6
            if lhs % 6 != rhs:
                ok = False
                # which CRT component fails: tau2 = 3*tau (mod 6 in {0,3}), tau3 = 4*tau (mod 6 in {0,2,4})
                if (3 * lhs) % 6 != (3 * rhs) % 6:
                    first = "tau2"
                else:
                    first = "tau3"
                break
        if ok:
            survivors.append(vals)
        elif any(t[k] == 3 for k in range(-W + 1, W)):
            reasons[first] += 1
    interior = lambda s: s[1:-1]
    parity_interior = sum(1 for s in survivors if 3 in interior(s))
    return n, survivors, parity_interior, reasons


def main() -> int:
    ds = [3, 7, 11, 15, 19, 23, 31, 35, 43, 47, 51, 59, 67, 71, 83, 167, 179, 191]
    bad = 0
    print(f"{'d':>5} {'d%12':>4} {'n':>4} {'survivors':>9} {'with parity interior':>21}  rejections of parity attempts (tau2 / tau3)")
    for d in ds:
        n, surv, par, reasons = analyse(d)
        cls = d % 12
        print(f"{d:>5} {cls:>4} {n:>4} {len(surv):>9} {par:>21}  {reasons['tau2']} / {reasons['tau3']}")
        if cls == 11 and surv:
            bad += 1
        if cls in (3, 7) and (par or not surv):
            bad += 1
    print("VERDICT:", "as the proof predicts" if bad == 0 else f"{bad} PREDICTION FAILURES")
    return 0 if bad == 0 else 1


if __name__ == "__main__":
    sys.exit(main())

#!/usr/bin/env python3
"""FS106-QB: exact checks of the constants in C-Q-REM (i) ("kept points of one colour avoid the band").

The derivation (plans/FS106-QB-verification.md, stage 2, section 2.1): x, y kept at scale eps (balls of radii eps/2 and 2*eps
(1-eta)-full of one class D), |x - y| = d in [1-eps, 1+eps].  For y' in B(y, eps/2) the unit circle S(y',1) crosses B(x, 2*eps)
in an arc of length >= L_min; any unit circle meets B(y, eps/2) in an arc of length <= L_max; the pairs (y', z), y' in D near y,
z in D near x, |y' - z| = 1, then have (Leb x H^1)-measure >= (1-eta)*pi*(eps/2)^2*L_min - eta*pi*(2*eps)^2*L_max, and this is
> 0 exactly when the checked inequality holds.  Everything below is rational arithmetic with rigorous arcsin bounds.

Run: python3 tools/fs106_qb_rem_constants.py        -> checks pass, then every planted fault is refused for its own reason.
"""
from fractions import Fraction as Fr
import sys


def arcsin_upper(t: Fr) -> Fr:
    """Rigorous upper bound of arcsin(t), 0 <= t <= 1/2: t + t^3/6 + (3/40) t^5 / (1 - t^2) (Taylor coefficients decrease)."""
    assert 0 <= t <= Fr(1, 2)
    return t + t**3 / 6 + Fr(3, 40) * t**5 / (1 - t**2)


def arcsin_lower(t: Fr) -> Fr:
    """arcsin(t) >= t for t >= 0."""
    return t


def check(eps_max: Fr, eta: Fr, rho_small: Fr, rho_big: Fr, label: str) -> tuple[bool, str]:
    """rho_small, rho_big are the two radii as multiples of eps (the claim: 1/2 and 2)."""
    # (a) geometry: circles from y' in B(y, rho_small*eps) pass within (1 + rho_small)*eps of x; need that < rho_big*eps.
    closest = 1 + rho_small  # in units of eps: |d - 1| <= eps plus the displacement rho_small*eps
    if not closest < rho_big:
        return False, f"{label}: no arc guaranteed: circles pass up to {closest}*eps from x, ball radius {rho_big}*eps"
    # (b) arc inside B(x, rho_big*eps): (s-1)^2 + 4 s sin^2(theta/2) <= (rho_big*eps)^2 with |s-1| <= closest*eps, s <= smax.
    smax = 1 + closest * eps_max
    budget = rho_big**2 - closest**2  # in units of eps^2, for 4 s sin^2(theta/2)
    # choose sin(theta/2) <= a*eps with 4*smax*a^2 <= budget; take the largest rational a we can certify: a^2 = budget/(4 smax)
    a2 = budget / (4 * smax)
    # arc length >= 4*theta0/2... theta ranges over |theta| <= 2 arcsin(a*eps); arc length = 4 arcsin(a*eps) >= 4*a*eps.
    # we need a rational lower bound of a = sqrt(a2): bisect.
    lo, hi = Fr(0), Fr(1)
    for _ in range(60):
        mid = (lo + hi) / 2
        if mid * mid <= a2:
            lo = mid
        else:
            hi = mid
    a = lo
    if a * eps_max > Fr(1, 2):
        return False, f"{label}: arcsin argument out of range"
    L_min_over_eps = 4 * a  # arc length >= 4 * arcsin(a*eps) >= 4*a*eps
    # (c) L_max: a unit circle meets a disc of radius rho_small*eps in one arc of chord <= 2*rho_small*eps: length <= 2 arcsin(rho_small*eps).
    t = rho_small * eps_max
    if t > Fr(1, 2):
        return False, f"{label}: L_max bound out of range (t = {t})"
    # arcsin(t)/t is increasing on [0, 1/2], so 2 arcsin(rho_small*eps) <= eps * 2*rho_small * arcsin(t)/t for eps <= eps_max
    L_max_over_eps = 2 * rho_small * arcsin_upper(t) / t
    # (d) positivity: (1-eta) * pi * rho_small^2 * L_min > eta * pi * rho_big^2 * L_max   (pi cancels; common eps^3)
    good = (1 - eta) * rho_small**2 * L_min_over_eps
    bad = eta * rho_big**2 * L_max_over_eps
    ok = good > bad
    return ok, (f"{label}: L_min >= {float(L_min_over_eps):.6f} eps, L_max <= {float(L_max_over_eps):.6f} eps, "
                f"good {float(good):.6f} vs bad {float(bad):.6f} -> {'POSITIVE' if ok else 'NOT POSITIVE'}; "
                f"eta threshold {float(rho_small**2 * L_min_over_eps / (rho_small**2 * L_min_over_eps + rho_big**2 * L_max_over_eps)):.6f}")


def main() -> int:
    failures = 0
    ok, msg = check(Fr(1, 2), Fr(1, 10), Fr(1, 2), Fr(2), "CLAIM eta=1/10, eps<=1/2, radii eps/2, 2eps")
    print(msg)
    if not ok:
        print("FAIL: the claimed constants do not certify positivity")
        failures += 1
    # sanity: the text's figures (L_min >= 2 eps, L_max <= 1.0108 eps)
    # planted faults, each must be refused, for its own reason
    plants = [
        (Fr(1, 2), Fr(12, 100), Fr(1, 2), Fr(2), "PLANT eta=0.12 (above threshold)", "NOT POSITIVE"),
        (Fr(1, 2), Fr(1, 10), Fr(1), Fr(1), "PLANT one common radius eps", "no arc guaranteed"),
        (Fr(9, 10), Fr(1, 10), Fr(1, 2), Fr(2), "PLANT eps up to 0.9", "NOT POSITIVE|out of range"),
    ]
    for eps_max, eta, rs, rb, label, reason in plants:
        ok, msg = check(eps_max, eta, rs, rb, label)
        print(msg)
        if ok or not any(r in msg for r in reason.split("|")):
            print(f"FAIL: plant '{label}' was not refused for its own reason")
            failures += 1
        else:
            print(f"  refused as planted ({reason})")
    print("ALL CHECKS PASS" if failures == 0 else f"{failures} FAILURE(S)")
    return 1 if failures else 0


if __name__ == "__main__":
    sys.exit(main())

#!/usr/bin/env python3
"""FS103-M: exact checks behind the controls of question 1 (C-FMT (c)).

Nothing here proves the theorem; each check confirms one arithmetic fact a control of
`plans/FS103-M-derivation.md` Stage 2 rests on, in exact arithmetic (Fraction / integers).

  C1  positive control: the hexagonal 7-colouring with side s = 2/5 has slack on both sides:
      diameter 2s < 1 and same-colour hexagons (centres sqrt(21)*s apart, circumradius s)
      are more than 1 apart, by the crude disc bound sqrt(21)*s - 2s > 1.
  C2  negative control A-E3: the edge measure of Cay(R, {+-1, +-sqrt2}) has no Fourier decay:
      sigma_hat(2*pi*q) = (1 + cos(2*pi*(sqrt2*q - p)))/2 -> 1 along Pell pairs (p, q).
  C3  negative control for step D (no decay): on Cay(R^2, {+-e1}) the stripe colouring
      f(x, y) = (floor x + floor(N {x})) mod 2 is proper at every e1-edge, and its
      window averages tend to 1/2 as N grows -- so a weak-* limit is (1/2, 1/2), not proper.
  C4  the rounding lemma: threshold rounding with a common U picks a colour in the support,
      and the U-measure of {c(0) != c(h)} is at most sum_j |S_j(0) - S_j(h)|.

Every check has a planted fault (--plant NAME) that must fire for its own reason.
Run: python3 tools/fs103_m_controls.py            (all checks; exit 0 iff all pass)
     python3 tools/fs103_m_controls.py --plant C1  (etc.; exit 0 iff the plant is caught)
"""
from __future__ import annotations

import random
import sys
from fractions import Fraction as Q
from math import floor, isqrt


def c1_hexagon(s: Q) -> tuple[bool, str]:
    # diameter 2s < 1
    if not 2 * s < 1:
        return False, f"diameter 2s = {2*s} not < 1"
    # sqrt(21)*s - 2s > 1  <=>  sqrt(21) > (1 + 2s)/s  <=>  21 > ((1+2s)/s)^2  (both sides positive)
    t = (1 + 2 * s) / s
    if not Q(21) > t * t:
        return False, f"gap: 21 <= ((1+2s)/s)^2 = {t*t}"
    return True, f"s = {s}: 2s = {2*s} < 1 and 21 > ((1+2s)/s)^2 = {t*t}"


def pell_pairs(n: int) -> list[tuple[int, int]]:
    out, p, q = [], 1, 1
    for _ in range(n):
        p, q = p + 2 * q, p + q  # (p + q sqrt2)(1 + sqrt2)
        out.append((p, q))
    return out


def c2_no_decay(pairs: list[tuple[int, int]]) -> tuple[bool, str]:
    # |sqrt2 q - p| = |2q^2 - p^2| / (sqrt2 q + p) <= |2q^2 - p^2| / p ; cos(x) >= 1 - x^2/2.
    # So sigma_hat(2 pi q) >= 1 - (2 pi^2) * (|2q^2-p^2|/p)^2 / 2 ... we bound with pi^2 < 10.
    last = None
    for p, q in pairs:
        d = abs(2 * q * q - p * p)
        if d != 1:
            return False, f"({p},{q}) is not a Pell pair: |2q^2 - p^2| = {d}"
        x_bound = Q(d, p)  # >= |sqrt2 q - p|
        # sigma_hat = (1 + cos(2 pi x))/2 >= 1 - (2 pi x)^2 / 4 = 1 - pi^2 x^2 > 1 - 10 x^2
        lower = 1 - 10 * x_bound * x_bound
        last = (q, lower)
    q, lower = last
    if not lower > Q(999, 1000):
        return False, f"lower bound {float(lower)} at q = {q} not above 0.999"
    return True, f"sigma_hat(2 pi q) > 1 - {float(1 - lower):.3e} at q = {q} (Pell); no decay"


def stripe_f(x: Q, N: int, plant: bool = False) -> int:
    if plant:  # plant: drop the floor(x) term -- then f(x + 1) = f(x) for even N
        return floor(N * x) % 2
    fx = floor(x)
    frac = x - fx
    return (fx + floor(N * frac)) % 2


def c3_stripes(N_values: list[int], samples: int = 400, seed: int = 1, plant: bool = False) -> tuple[bool, str]:
    rng = random.Random(seed)
    for N in N_values:
        for _ in range(samples):
            x = Q(rng.randrange(-10**6, 10**6), rng.randrange(1, 10**4))
            if stripe_f(x, N, plant) == stripe_f(x + 1, N, plant):
                return False, f"improper e1-edge at x = {x}, N = {N}"
    # exact window average of 1[f = 0] over [a, a + 1/2] at the largest N:
    # measure of {f = 0} in the window, computed exactly on the stripe grid.
    N = max(N_values)
    a = Q(1, 3)
    b = a + Q(1, 2)
    pts = sorted({a, b} | {Q(k, N) for k in range(floor(a * N), floor(b * N) + 2) if a < Q(k, N) < b})
    zero = sum((r - l) for l, r in zip(pts, pts[1:]) if stripe_f((l + r) / 2, N) == 0)
    avg = zero / (b - a)
    if not abs(avg - Q(1, 2)) <= Q(2, N):
        return False, f"window average {avg} not within 2/N of 1/2"
    return True, f"proper at {samples*len(N_values)} sampled e1-edges; window average at N = {N}: {float(avg):.6f} (-> 1/2)"


def threshold(vec: list[Q], u: Q) -> int:
    acc = Q(0)
    for j, v in enumerate(vec):
        acc += v
        if acc > u:
            return j
    raise ValueError("vector sums to <= u")


def disagreement_measure(a: list[Q], b: list[Q]) -> Q:
    # exact Lebesgue measure of {u in [0,1): threshold(a,u) != threshold(b,u)}
    cuts = sorted({Q(0), Q(1)} | {sum(a[: j + 1]) for j in range(len(a))} | {sum(b[: j + 1]) for j in range(len(b))})
    cuts = [c for c in cuts if 0 <= c <= 1]
    m = Q(0)
    for l, r in zip(cuts, cuts[1:]):
        if r > l and threshold(a, (l + r) / 2) != threshold(b, (l + r) / 2):
            m += r - l
    return m


def rand_simplex(rng: random.Random, k: int, zeros: int) -> list[Q]:
    w = [Q(rng.randrange(1, 50)) for _ in range(k)]
    for j in rng.sample(range(k), zeros):
        w[j] = Q(0)
    s = sum(w)
    return [x / s for x in w]


def c4_rounding(trials: int = 3000, k: int = 5, seed: int = 7, plant: bool = False) -> tuple[bool, str]:
    rng = random.Random(seed)
    for _ in range(trials):
        a = rand_simplex(rng, k, rng.randrange(0, k - 1))
        b = rand_simplex(rng, k, rng.randrange(0, k - 1))
        u = Q(rng.randrange(0, 10**6), 10**6)
        j = threshold(a, u)
        if a[j] == 0:
            return False, f"threshold picked a colour outside the support: {a}, u = {u}"
        m = disagreement_measure(a, b)
        bound = sum(abs(sum(a[: i + 1]) - sum(b[: i + 1])) for i in range(k - 1))
        if plant:
            bound = bound / 2  # plant: the bound halved must fail somewhere
        if m > bound:
            return False, f"disagreement {m} > bound {bound} at a = {a}, b = {b}"
    return True, f"{trials} exact trials: support respected; disagreement <= sum_j |S_j(0) - S_j(h)|"


def run(plant: str | None) -> int:
    checks = {
        "C1": lambda: c1_hexagon(Q(1, 2) if plant == "C1" else Q(2, 5)),
        "C2": lambda: c2_no_decay(pell_pairs(2) if plant == "C2" else pell_pairs(12)),
        "C3": lambda: c3_stripes([2, 8, 64, 1024], plant=(plant == "C3")),
        "C4": lambda: c4_rounding(plant=(plant == "C4")),
    }
    if plant is not None:
        ok, msg = checks[plant]()
        print(f"PLANT {plant}: check returned {'PASS' if ok else 'FAIL'} -- {msg}")
        if ok:
            print(f"PLANT {plant} NOT CAUGHT", file=sys.stderr)
            return 1
        print(f"PLANT {plant} caught")
        return 0
    bad = 0
    for name, fn in checks.items():
        ok, msg = fn()
        print(f"{name} {'PASS' if ok else 'FAIL'}: {msg}")
        bad += not ok
    print("ALL PASS" if bad == 0 else f"{bad} FAILED")
    return 1 if bad else 0


if __name__ == "__main__":
    args = sys.argv[1:]
    p = args[1] if len(args) == 2 and args[0] == "--plant" else None
    if args and p is None:
        print(__doc__)
        sys.exit(2)
    sys.exit(run(p))

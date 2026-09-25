#!/usr/bin/env python3
"""Crunch job J01 (FS-91 stage 0): exact checks behind the band steps of `plans/FS91-S0V-band-to-nine.md`.

Exact arithmetic of seconds, checking derived claims (the ban's "in" column); no witness is sought.

Part A -- the sweep (Lemma SW) realised in the adelic chart of R_{5,13} at the place v = (2 - i) above 5.
    A pure v-adic element c-bar is the character x -> -psi_v(c x).  For the ball c + 5^s Z_5 and the unit vector
    u = w_5^t (w_5 = (3+4i)/5, |w_5|_v = 5), the values (x' + c'-bar)(u) = x'(u) - psi_v(c u) - psi_v(b u), b in 5^s Z_5,
    fill a full coset of (1/5^m)Z/Z when t = s + m.  Claims checked:
      A1  the coset is full (every j/5^m occurs) for m = 1, 2, 3;
      A2  with m = 1 (the lemma as written, one digit) a value lies in the open arc (-1/k, 1/k) for every offset iff k < 2*5;
          at k = 10 an explicit offset keeps all five values in the band [1/10, 9/10] (the single-digit sweep is sharp);
      A3  with m = m(k) = least m with 5^m > k/2 a value lies in the open arc for every offset, k = 3..60.
Part B -- the parity (doubling) line at k = 6..9.
      B1  {t : t in B_k and t + 1/2 in B_k} doubles onto B'_k = [2/k, 1 - 2/k];
      B2  the doubling chain from band 1/k reaches a band wider than 1/4 (antipodal refusal) or the singleton band 1/2.

Planted faults (each must fire, beside the faithful run that must pass):
      P1  wrong place: iota = 3 (mod 5), where 2 - i is a unit, so w_5 contracts at v and the sweep collapses (A1 must fail);
      P2  closed arc [-1/k, 1/k] in place of the open one (A2's sharpness at k = 10 must fail);
      P3  B1 with the half-turn 1/2 replaced by 1/3 (the doubled band must no longer be B'_k).
Run: python3 tools/crunch_j01_sweep_check.py   (exit 0 iff the faithful run passes and every plant fires)
"""
from fractions import Fraction as Fr
import sys

N = 20  # 5-adic precision (digits); every quantity below needs at most t + m <= 12 digits


def sqrt_minus_one_mod(p, n, root0):
    """Hensel-lift root0 (root0^2 = -1 mod p) to Z/p^n."""
    mod = p ** n
    r = root0
    for _ in range(n + 2):
        r = (r - (r * r + 1) * pow(2 * r, -1, mod)) % mod
    assert (r * r + 1) % mod == 0 and r % p == root0 % p
    return r


def frac_part_5adic(a, e):
    """psi_v(a / 5^e) for an integer a: the 5-adic fractional part, as a Fraction in [0, 1)."""
    return Fr(a % 5 ** e, 5 ** e) if e > 0 else Fr(0)


def dist0(x):
    """Distance from x mod 1 to 0."""
    x = x % 1
    return min(x, 1 - x)


def in_open_arc(x, k, closed=False):
    return dist0(x) <= Fr(1, k) if closed else dist0(x) < Fr(1, k)


def sweep_values(iota, s, m, offset):
    """Values x'(u) - psi_v(c u) - psi_v(b u) over b in 5^s Z_5 mod 5^(s+m), c = 1, u = w_5^t, t = s + m.

    `offset` stands for x'(u) (any real; the claim is for every offset).  In Z_5 via i -> iota,
    w_5 = (3 + 4 iota)/5, so w_5^t = U^t / 5^t with U = 3 + 4 iota.  Returns (values, whether |w_5|_v = 5)."""
    t = s + m
    mod = 5 ** N
    U = (3 + 4 * iota) % mod
    expanding = U % 5 != 0  # U a unit <=> w_5 has valuation -1 at v
    Ut = pow(U, t, mod)
    if expanding:
        cu = frac_part_5adic(Ut, t)  # psi_v(c u), c = 1
        vals = []
        for beta in range(5 ** m):
            # b = 5^s * beta, so b u = beta * U^t / 5^(t - s) = beta * U^t / 5^m
            vals.append(offset - cu - frac_part_5adic(beta * Ut, m))
        return vals, True
    # U divisible by 5: w_5 = U/5 is a v-unit or smaller, so b u is 5-integral and psi_v(b u) = 0 (the sweep collapses).
    return [offset - Fr(0) - Fr(0) for _ in range(5 ** m)], False


def check_part_A(iota, closed=False):
    out = []
    ok = True
    # A1: fullness of the coset
    for m in (1, 2, 3):
        vals, expanding = sweep_values(iota, 2, m, Fr(0))
        residues = sorted({(v % 1) * 5 ** m for v in vals})
        full = expanding and len(residues) == 5 ** m
        out.append(f"A1 m={m}: expanding={expanding} distinct={len(residues)} of {5**m} -> {'full' if full else 'NOT full'}")
        ok &= full
    # A2: one digit, every offset, k < 10 <=> always meets the open arc; the worst offset is 1/(2*5) after the shift.
    for k in range(3, 13):
        # worst case over offsets: the coset whose nearest point to 0 is farthest, i.e. at 1/10 (half the step).
        vals, _ = sweep_values(iota, 2, 1, Fr(0))
        cu_shift = vals[0]  # = -psi(cu); choose the offset so that the coset becomes 1/10 + (1/5)Z
        worst_offset = Fr(1, 10) - cu_shift
        wvals, _ = sweep_values(iota, 2, 1, worst_offset)
        meets = any(in_open_arc(v, k, closed) for v in wvals)
        expect = k < 10
        out.append(f"A2 k={k}: worst one-digit coset meets arc: {meets} (expected {expect})")
        ok &= (meets == expect)
    # A2 sharpness at k = 10: the explicit offset keeps all five values in the band [1/10, 9/10]
    vals, _ = sweep_values(iota, 2, 1, Fr(0))
    wvals, _ = sweep_values(iota, 2, 1, Fr(1, 10) - vals[0])
    in_band = all(Fr(1, 10) <= (v % 1) <= Fr(9, 10) for v in wvals) and not any(in_open_arc(v, 10, closed) for v in wvals)
    out.append(f"A2 k=10 sharpness: all five one-digit values in [1/10, 9/10] and none in the arc: {in_band}")
    ok &= in_band
    # A3: m(k) digits suffice at every k, for every offset (worst offset = half the step)
    for k in range(3, 61):
        m = 1
        while 5 ** m <= Fr(k, 2):
            m += 1
        vals, _ = sweep_values(iota, 2, m, Fr(0))
        worst_offset = Fr(1, 2 * 5 ** m) - vals[0]
        wvals, _ = sweep_values(iota, 2, m, worst_offset)
        meets = any(in_open_arc(v, k, closed) for v in wvals)
        if not meets:
            out.append(f"A3 k={k} m={m}: FAILS")
        ok &= meets
    out.append("A3 k=3..60 with m(k) digits: " + ("all meet the open arc" if ok else "see failures"))
    return ok, out


def doubled_band(k, half=Fr(1, 2), grid=2520):
    """Exact image under t -> 2t of {t in B_k : t + half in B_k}, sampled on the rational grid (1/(grid*k))Z, as (min, max)."""
    lo, hi = Fr(1, k), 1 - Fr(1, k)
    pts = []
    den = grid * k
    for a in range(den):
        t = Fr(a, den)
        if lo <= t <= hi and lo <= (t + half) % 1 <= hi:
            pts.append((2 * t) % 1)
    return min(pts), max(pts), pts


def check_part_B(half=Fr(1, 2)):
    out = []
    ok = True
    for k in (6, 7, 8, 9):
        mn, mx, pts = doubled_band(k, half)
        target = (Fr(2, k), 1 - Fr(2, k))
        good = (mn, mx) == target and all(target[0] <= x <= target[1] for x in pts)
        out.append(f"B1 k={k}: doubled band [{mn}, {mx}] (expected [{target[0]}, {target[1]}]) -> {good}")
        ok &= good
        # B2: chain of doublings of the band edge beta = 1/k
        beta, steps, chain = Fr(1, k), 0, [Fr(1, k)]
        while beta <= Fr(1, 4) and beta != Fr(1, 4):
            beta *= 2
            steps += 1
            chain.append(beta)
        if beta == Fr(1, 4):
            end = "band 1/4: one more doubling gives the singleton band 1/2 = {theta_2}"
            steps += 1
            chain.append(Fr(1, 2))
        else:
            end = "band edge > 1/4: case 1 refused outright (antipodal values cannot both lie in an arc shorter than 1/2)"
        out.append(f"B2 k={k}: band edges {[str(c) for c in chain]} ({steps} doublings); {end}")
    return ok, out


def main():
    iota = sqrt_minus_one_mod(5, N, 2)   # i -> iota, iota = 2 mod 5, so 2 - iota = 0 mod 5: v = (2 - i)
    report = []
    okA, outA = check_part_A(iota)
    okB, outB = check_part_B()
    report += ["== faithful run"] + outA + outB
    faithful = okA and okB
    report.append(f"FAITHFUL: {'PASS' if faithful else 'FAIL'}")

    # Plants: each must make its check fail, for the stated reason.
    iota_bad = sqrt_minus_one_mod(5, N, 3)  # 2 - iota is a unit here: the conjugate place, where w_5 contracts
    okP1, outP1 = check_part_A(iota_bad)
    p1_fires = (not okP1) and any("NOT full" in line and "expanding=False" in line for line in outP1)
    okP2, outP2 = check_part_A(iota, closed=True)
    p2_fires = (not okP2) and any(line.startswith("A2 k=10 sharpness") and line.endswith("False") for line in outP2)
    okP3, outP3 = check_part_B(half=Fr(1, 3))
    p3_fires = (not okP3)
    report += ["== plants",
               f"P1 wrong place (iota = 3 mod 5, w_5 contracts): fires={p1_fires}",
               f"P2 closed arc: fires={p2_fires}",
               f"P3 half-turn replaced by 1/3: fires={p3_fires}"]
    allgood = faithful and p1_fires and p2_fires and p3_fires
    report.append(f"OVERALL: {'PASS' if allgood else 'FAIL'}")
    print("\n".join(report))
    return 0 if allgood else 1


if __name__ == "__main__":
    sys.exit(main())

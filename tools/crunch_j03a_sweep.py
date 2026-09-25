#!/usr/bin/env python3
"""J03a (FS-91 crunch): exact check of the arithmetic of Lemma SW-m, the multi-digit sweep.

The derivation (plans/FS91-S0V2-SWm-second-reading.md, Stage 2) fixes what is checked, and the extent is fixed before the run:

  S1. At a split prime p = pi*conj(pi), in the two embeddings Z[i] -> Z_p (i -> +iota, i -> -iota), the unit w_p = pi/conj(pi)
      has valuation +1 at one place and -1 at the other (so a power of w_p has any prescribed valuation at v).
  S2. For u = w_p^t with v(u) = -(m + s), the ball c0 + p^s Z_p maps under c -> psi_v(u c) ONTO a full coset of (1/p^m)Z/Z
      (psi_v the p-adic fractional part), computed by enumeration of c = c0 + p^s j, j = 0..p^m - 1, in exact p-adic arithmetic.
  S3. A coset a + (1/p^m)Z of R/Z meets the open arc (-1/k, 1/k) for EVERY shift a iff 2 p^m > k; checked exactly at the worst
      shift a = 1/(2 p^m) and by enumeration, for k = 2..K_MAX and p in PRIMES, and the least such m is recorded (m = 1 iff k < 2p).
  S4. The two combined: the enumerated image of S2, shifted adversarially, has a point in the open arc at m = m_k.
  S5. Lemma JC's radius: for p' != p, w_{p'} is a unit at v, and g = w_{p'}^(p-1) = 1 + p^j * unit with j finite, so the closure
      of <w_{p'}> contains 1 + p^j Z_p; the ball VB1 produces has radius p^-(v(c) + j).

Plants (standing rule 7), each paired with the faithful computation that must pass:
  P1. the one-digit sweep (m = 1) at k = 2p, worst shift a = 1/(2p): the coset lies in the band (distance exactly 1/k), so
      "the sweep leaves the band" must come back False -- for that reason, not an index error; faithful twin m = m_k passes.
  P2. the sweep with u = w_{p'} (a unit at v) in place of w_p^t: the ball's image is one point, so "full coset" must fail with
      image size 1; faithful twin passes.
  P3. Lemma JC with p' = p: w_p is not a unit at v, and the radius computation must refuse on the valuation; faithful twin passes.

Exit status 0 iff every check passes and every plant fires for its stated reason.
"""
from fractions import Fraction
import sys

PRIMES = [5, 13, 17, 29, 37]
K_MAX = 200
PREC = 60  # p-adic digits carried


def two_squares(p):
    for a in range(1, p):
        b2 = p - a * a
        if b2 <= 0:
            break
        b = int(round(b2 ** 0.5))
        for bb in (b - 1, b, b + 1):
            if bb > 0 and bb * bb == b2:
                return a, bb
    raise ValueError(p)


def sqrt_minus_one(p, n):
    """A root of x^2 = -1 in Z/p^n (Hensel)."""
    r = next(x for x in range(p) if (x * x + 1) % p == 0)
    mod = p
    for _ in range(1, n):
        mod *= p
        # Newton step: r <- r - (r^2+1)/(2r)
        r = (r - (r * r + 1) * pow(2 * r, -1, mod)) % mod
    assert (r * r + 1) % (p ** n) == 0
    return r


def val(x, p):
    if x == 0:
        return None
    v = 0
    while x % p == 0:
        x //= p
        v += 1
    return v


class Padic:
    """p^e * unit, unit known mod p^prec."""

    def __init__(self, p, e, unit, prec):
        assert unit % p != 0
        self.p, self.e, self.prec = p, e, prec
        self.unit = unit % (p ** prec)

    def __mul__(self, o):
        prec = min(self.prec, o.prec)
        return Padic(self.p, self.e + o.e, self.unit * o.unit, prec)

    def __pow__(self, t):
        if t >= 0:
            return Padic(self.p, self.e * t, pow(self.unit, t, self.p ** self.prec), self.prec)
        inv = pow(self.unit, -1, self.p ** self.prec)
        return Padic(self.p, self.e * t, pow(inv, -t, self.p ** self.prec), self.prec)


def from_int(x, p, prec):
    v = val(x, p)
    return Padic(p, v, x // p ** v, prec)


def w_at_place(p, sign, a, b, iota):
    """w_p = (a + b i)/(a - b i) in the embedding i -> sign*iota, as a Padic."""
    mod = p ** PREC
    num = (a + sign * b * iota) % mod
    den = (a - sign * b * iota) % mod
    vn, vd = val(num, p), val(den, p)
    # exactly one of num, den is divisible by p, and only once (p exactly divides a^2 + b^2)
    assert {vn, vd} == {0, 1}, (vn, vd)
    un, ud = num // p ** vn, den // p ** vd
    prec = PREC - 1
    return Padic(p, vn - vd, un * pow(ud, -1, p ** prec), prec)


def psi(y):
    """p-adic fractional part of y (a Padic), as a Fraction in [0, 1)."""
    if y.e >= 0:
        return Fraction(0)
    d = -y.e
    assert d <= y.prec, "precision exhausted"
    return Fraction(y.unit % (y.p ** d), y.p ** d)


def ball_image(p, u, c0, s, m):
    """{psi(u c) : c = c0 + p^s j, j = 0..p^m - 1}, c0 and the ball given as Fractions with p-power denominators."""
    out = []
    for j in range(p ** m):
        c = Fraction(c0) + Fraction(p) ** s * j
        if c == 0:
            out.append(Fraction(0))
            continue
        num, den = c.numerator, c.denominator
        vd = val(den, p)
        assert den == p ** vd
        y = from_int(num, p, u.prec) * Padic(p, -vd, 1, u.prec)
        out.append(psi(u * y))
    return out


def is_full_coset(image, p, m):
    base = image[0]
    shifted = {(z - base) % 1 for z in image}
    target = {Fraction(r, p ** m) for r in range(p ** m)}
    return shifted == target, len(set(image))


def circ(x):
    x = x % 1
    return min(x, 1 - x)


def nearest_distance_formula(a, p, m):
    step = Fraction(1, p ** m)
    r = a % step
    return min(r, step - r)


def nearest_distance_enum(a, p, m):
    return min(circ(a + Fraction(j, p ** m)) for j in range(p ** m))


def meets_open_arc(dist, k):
    return dist < Fraction(1, k)


def least_m(p, k):
    m = 1
    while 2 * p ** m <= k:
        m += 1
    return m


def jc_radius(p, pprime, sign, iota_p, prec_check=4):
    """j with w_{p'}^(p-1) = 1 + p^j * unit at the place i -> sign*iota of Q_p; refuses if w_{p'} is not a unit there."""
    a, b = two_squares(pprime)
    mod = p ** PREC
    num = (a + sign * b * iota_p) % mod
    den = (a - sign * b * iota_p) % mod
    vn, vd = val(num, p), val(den, p)
    if vn != 0 or vd != 0:
        return None, f"w_{pprime} has valuation {vn - vd} at this place of Q_{p}: not a unit, JC does not apply"
    g = num * pow(den, -1, mod) % mod
    g = pow(g, p - 1, mod)
    j = val((g - 1) % mod, p)
    if j is None or j >= PREC - 5:
        return None, "g = 1 to working precision (would mean w_p' of finite order)"
    # the closure of <g> is 1 + p^j Z_p: g^(p^r) - 1 has valuation exactly j + r
    for r in range(prec_check):
        assert val((pow(g, p ** r, mod) - 1) % mod, p) == j + r
    return j, "ok"


def main():
    lines, ok = [], True

    def say(s):
        lines.append(s)
        print(s)

    say("J03a sweep check -- exact p-adic and rational arithmetic")
    # S1
    for p in PRIMES:
        a, b = two_squares(p)
        iota = sqrt_minus_one(p, PREC)
        vals = [w_at_place(p, sg, a, b, iota).e for sg in (+1, -1)]
        good = sorted(vals) == [-1, 1]
        ok &= good
        say(f"S1 p={p}: pi={a}+{b}i, v(w_p) at the two places = {vals}  {'OK' if good else 'FAIL'}")
    # S2 and S4
    for p in PRIMES:
        a, b = two_squares(p)
        iota = sqrt_minus_one(p, PREC)
        for sign in (+1, -1):
            w = w_at_place(p, sign, a, b, iota)
            for (c0, s) in ((Fraction(7), 0), (Fraction(3, p), -1), (Fraction(2 + p * p), 2), (Fraction(1, p ** 2), -3)):
                for m in (1, 2) if p ** 2 <= 2000 else (1,):
                    t = -(m + s) // w.e if w.e != 0 else None  # v(w^t) = t * w.e = -(m + s)
                    assert t * w.e == -(m + s)
                    u = w ** t
                    img = ball_image(p, u, c0, s, m)
                    full, size = is_full_coset(img, p, m)
                    ok &= full
                    say(f"S2 p={p} place={'+' if sign > 0 else '-'} c0={c0} s={s} m={m} t={t}: image full coset of step 1/{p**m}: {full} (size {size})")
                    # S4: adversarial shift at every k whose least m is this m (tested at the largest such k)
                    k_top = 2 * p ** m - 1 if m >= 1 else None
                    base = img[0]
                    # values are a - psi(u c); choose a so that a - base = 1/(2 p^m): the worst case
                    worst = Fraction(1, 2 * p ** m)
                    vals_ = [(worst + base - z) for z in img]
                    hit = any(circ(v_) < Fraction(1, k_top) for v_ in vals_)
                    ok &= hit
                    say(f"S4   k={k_top} (largest k with m_k={m}), worst shift: some value in (-1/k,1/k): {hit}")
    # S3
    thresholds = {}
    for p in PRIMES:
        for k in range(2, K_MAX + 1):
            m = least_m(p, k)
            worst = Fraction(1, 2 * p ** m)
            d_formula = nearest_distance_formula(worst, p, m)
            if p ** m <= 5000:
                d_enum = nearest_distance_enum(worst, p, m)
                assert d_enum == d_formula
            assert d_formula == worst  # the worst shift sits exactly half a step from the coset
            meets = meets_open_arc(d_formula, k)
            ok &= meets
            if m > 1:  # tightness: one fewer digit leaves the coset inside the band at its worst shift
                w1 = Fraction(1, 2 * p ** (m - 1))
                tight = not meets_open_arc(nearest_distance_formula(w1, p, m - 1), k)
                ok &= tight
            thresholds.setdefault(p, []).append((k, m))
        one_digit_max = max(k for k, m in thresholds[p] if m == 1)
        good = one_digit_max == 2 * p - 1
        ok &= good
        say(f"S3 p={p}: every k in 2..{K_MAX} met with m_k = least m, 2p^m > k; one digit suffices exactly for k <= {one_digit_max} (= 2p-1: {good}); "
            f"m_k at k={K_MAX}: {least_m(p, K_MAX)}")
    # k = 2 explicitly
    say(f"S3 k=2: band B_2 = {{1/2}}; m_2 = {least_m(5, 2)} at p=5; worst distance 1/10 < 1/2: {meets_open_arc(Fraction(1, 10), 2)}")
    # S5
    for p in (5, 13, 17):
        iota = sqrt_minus_one(p, PREC)
        for pp in (5, 13, 17):
            if pp == p:
                continue
            for sign in (+1, -1):
                j, why = jc_radius(p, pp, sign, iota)
                ok &= j is not None
                say(f"S5 v|{p} (place {'+' if sign > 0 else '-'}), p'={pp}: closure of <w_p'> contains 1 + {p}^{j} Z_{p}  [{why}]")
    # Plants
    say("PLANTS")
    for p in PRIMES:
        k = 2 * p
        d1 = nearest_distance_formula(Fraction(1, 2 * p), p, 1)
        fired = (not meets_open_arc(d1, k)) and d1 == Fraction(1, k)
        twin = meets_open_arc(nearest_distance_formula(Fraction(1, 2 * p ** 2), p, 2), k)
        ok &= fired and twin
        say(f"P1 p={p} k={k}: one-digit sweep at worst shift stays in the band (distance {d1} = 1/k): fired={fired}; faithful m=2 meets the arc: {twin}")
    p, pp = 5, 13
    iota = sqrt_minus_one(p, PREC)
    a2, b2 = two_squares(pp)
    num = (a2 + b2 * iota) % p ** PREC
    den = (a2 - b2 * iota) % p ** PREC
    u_bad = Padic(p, 0, num * pow(den, -1, p ** PREC), PREC)
    img_bad = ball_image(p, u_bad, Fraction(7), 0, 1)
    full_bad, size_bad = is_full_coset(img_bad, p, 1)
    fired2 = (not full_bad) and size_bad == 1
    a, b = two_squares(p)
    w = w_at_place(p, +1, a, b, iota)
    t = -1 // w.e
    full_good, _ = is_full_coset(ball_image(p, w ** t, Fraction(7), 0, 1), p, 1)
    ok &= fired2 and full_good
    say(f"P2 u = w_13 (a unit at v|5) in place of w_5^t: image size {size_bad}, full coset {full_bad}: fired={fired2}; faithful twin full coset: {full_good}")
    j3, why3 = jc_radius(5, 5, +1, iota)
    fired3 = j3 is None and "not a unit" in why3
    j3t, _ = jc_radius(5, 13, +1, iota)
    ok &= fired3 and j3t is not None
    say(f"P3 JC with p' = p = 5: refused ({why3}): fired={fired3}; faithful twin p'=13 gives j={j3t}")
    say("ALL CHECKS PASS" if ok else "SOME CHECK FAILED")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())

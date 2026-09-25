#!/usr/bin/env python3
"""J07 (FS-91 crunch, M1): exact checks of four derived claims of `plans/FS91-S1D-character.md`.

Every check is a complete enumeration of a finite set that a derivation fixed first (standing rule 3's edge): no search.

  A. Lemma LB / CLG-e (level bound).  At the stable place of Q(i) above an odd p (e = 1, q = p), every character of Z[i]/p^m is
     lambda_{a,b}(x, y) = (a x + b y)/p^m, and S_m = {(x, y) mod p^m : x^2 + y^2 = 1} (Hensel: the image of the local norm-one group).
     Derived: a band-k character has exact level 1 if k < 2p, and level <= 2r + 1 if 2p^r <= k < 2p^(r+1).  Checked at p = 3, m = 4
     (levels up to 4) for k = 3..20 and at p = 7, m = 3 for k in {4, 13, 14, 20}.  Also reported: the largest level that occurs
     (sharpness of the allowance).
  B. Level-one inputs of the corollaries (Stage 4): at prime q = 3 (mod 4), Gamma_q = Cay(F_q^2, {x^2 + y^2 = 1}) has no band-4
     character for q in {11, 19, 23, 31, 43, 47, 59} (the middle half against Weil: CL4, HD1) and no band-5 character for
     q in {23, 43, 59} (CL5 without FS-53's or FS-66's certificates).  Positive controls: q = 7 carries C9's (2x + 3y)/7 at band 4;
     q = 3 carries (x + y)/3 at band 3.
  C. The stable places of the exposed real quadratic fields Q(sqrt d): an odd prime q is under a stable place iff q = 3 (mod 4) and
     (d/q) = 1 or q | d; the least such q, and the dyadic type (d = 7 mod 8: split, wall broken; d = 3 mod 8: inert stable).
  D. CLG-b (the peeling lemma) on Z/N, every symmetric X and every Y, N = 12 and 13, bands 1/k for k = 3, 4, 5.

Plants (--plant NAME; each must make its check go red, for the reason named):
  subS    : in A, test the band only on the part of S_m with y = 0 mod p^(m-1) (drops the tangent directions the sweep uses):
            spurious high-level band characters appear.
  dropS   : in B, drop the two points (0, +-1) from the circle: a spurious band-4 character appears at some q >= 11.
  asym    : in D, allow non-symmetric X: the peeling conclusion fails.
Run: python3 tools/crunch_j07_checks.py [--plant NAME]   (about 10 s; numpy).
"""
import sys
from math import gcd
import numpy as np

PLANT = None
if "--plant" in sys.argv:
    PLANT = sys.argv[sys.argv.index("--plant") + 1]
    assert PLANT in ("subS", "dropS", "asym"), PLANT

fails = []


def check(cond, msg):
    print(("ok   " if cond else "FAIL ") + msg)
    if not cond:
        fails.append(msg)


def circle(n):
    """All (x, y) mod n with x^2 + y^2 = 1 mod n."""
    xs = np.arange(n)
    sq = (xs * xs) % n
    pts = [(x, y) for x in range(n) for y in range(n) if (sq[x] + sq[y]) % n == 1 % n]
    return np.array(pts, dtype=np.int64)


def band_ok(vals, n, k):
    """vals: residues mod n (array, last axis = points).  Band 1/k: k * min(r, n - r) >= n for every point."""
    d = np.minimum(vals, n - vals)
    return np.all(k * d >= n, axis=-1)


def vp(a, p):
    if a == 0:
        return 99
    v = 0
    while a % p == 0:
        a //= p
        v += 1
    return v


def allowed_level(p, k):
    """Lemma LB' at e = 1 (Stage 4 refinement): exact level L >= 2 needs k (p^(L-a) - 1) >= 2 p^L, a = floor(L/2) (the sweep's
    coset of step p^-a sits in p^-L Z, so its point nearest 0 is within (p^(L-a) - 1)/(2 p^L)).  Largest allowed L (>= 1)."""
    return max([1] + [L for L in range(2, 12) if k * (p ** (L - L // 2) - 1) >= 2 * p ** L])


# ---------- A. level bound ----------
def level_check(p, m, ks):
    n = p ** m
    S = circle(n)
    if PLANT == "subS":
        S = S[(S[:, 1] % p ** (m - 1)) == 0]
    check(len(circle(n)) == p ** (m - 1) * (p + 1), f"A p={p} m={m}: |S_m| = p^(m-1)(p+1) = {p**(m-1)*(p+1)}")
    a = np.arange(n, dtype=np.int64)
    worst = {}
    for k in ks:
        maxlev = 0
        count = 0
        for av in range(n):  # rows of characters with first coefficient av, all b at once
            vals = (av * S[:, 0][None, :] + a[:, None] * S[:, 1][None, :]) % n  # shape (n_b, |S|)
            ok = band_ok(vals, n, k)
            for bv in np.nonzero(ok)[0]:
                lev = m - min(vp(av, p), vp(int(bv), p), m)
                count += 1
                maxlev = max(maxlev, lev)
        worst[k] = (maxlev, count)
        allow = allowed_level(p, k)
        check(maxlev <= allow, f"A p={p} m={m} k={k}: {count} band characters, largest exact level {maxlev} <= allowed {allow}")
        if k <= 2 * p:
            check(maxlev == 1, f"A p={p} m={m} k={k} <= 2p: level one (CLG-e at the boundary k = 2p included)")
    return worst


print("== A. level bound (Lemma LB, CLG-e) ==")
wA3 = level_check(3, 4, list(range(3, 21)))
wA7 = level_check(7, 3, [4, 13, 14, 20]) if PLANT != "subS" else {}
print("   sharpness at p = 3:", {k: v[0] for k, v in wA3.items()})


# ---------- B. level-one targets ----------
def has_band(q, k, drop=False):
    S = circle(q)
    if drop:
        S = S[S[:, 0] != 0]
    a = np.arange(q, dtype=np.int64)
    found = []
    for av in range(q):
        vals = (av * S[:, 0][None, :] + a[:, None] * S[:, 1][None, :]) % q
        ok = band_ok(vals, q, k)
        for bv in np.nonzero(ok)[0]:
            found.append((av, int(bv)))
    return found


print("== B. level-one inputs ==")
f7 = has_band(7, 4)
check((2, 3) in f7, f"B q=7 k=4: C9's (2x+3y)/7 is a band-4 character ({len(f7)} in all)")
check((1, 1) in has_band(3, 3), "B q=3 k=3: (x+y)/3 is a band-3 character")
drop = PLANT == "dropS"
for q in (11, 19, 23, 31, 43, 47, 59):
    f = has_band(q, 4, drop)
    check(len(f) == 0, f"B q={q} k=4: no band-4 character (found {len(f)})")
for q in (23, 43, 59):
    f = has_band(q, 5, drop)
    check(len(f) == 0, f"B q={q} k=5: no band-5 character (found {len(f)})")
# the middle-half coefficient against Weil, the step that covers every larger q at k = 4 (S0A-8): 1/sin(pi/2q) > 2 sqrt q from q = 11
import math
check(all(1 / math.sin(math.pi / (2 * q)) > 2 * math.sqrt(q) for q in range(11, 2000)), "B middle-half 1/sin(pi/2q) > 2 sqrt(q), 11 <= q < 2000 (float; margin grows)")
check(all(8 * math.sqrt(q) < q + 1 for q in range(67, 5000)), "B Weil-Hoffman ratio 2sqrt(q)/(q+1+2sqrt(q)) < 1/5 for q >= 67 (8 sqrt q < q + 1)")


# ---------- C. stable places of the exposed fields ----------
def legendre(a, q):
    a %= q
    if a == 0:
        return 0
    return 1 if pow(a, (q - 1) // 2, q) == 1 else -1


def primes(n):
    s = bytearray([1]) * (n + 1)
    s[0:2] = b"\x00\x00"
    for i in range(2, int(n ** 0.5) + 1):
        if s[i]:
            s[i * i::i] = bytearray(len(s[i * i::i]))
    return [i for i in range(n + 1) if s[i]]


print("== C. stable places ==")
expect = {47: (11, "split"), 167: (23, "split"), 59: (11, "inert"), 83: (19, "inert"), 131: (19, "inert"), 11: (7, "inert")}
for d, (qmin, dy) in expect.items():
    st = [q for q in primes(200) if q % 4 == 3 and (legendre(d, q) == 1 or d % q == 0)]
    dyad = "split" if d % 8 == 7 else ("inert" if d % 8 == 3 else "other")
    check(st[0] == qmin and dyad == dy, f"C Q(sqrt {d}): least stable odd q = {st[0]} (expect {qmin}); dyadic {dyad}; stable q < 200: {st[:8]}...")
st167 = [q for q in primes(200) if q % 4 == 3 and (legendre(167, q) == 1 or 167 % q == 0)]
check(st167[:5] == [23, 43, 59, 67, 71], f"C Q(sqrt 167): stable q begin {st167[:6]} (S0A-9's table: 23, 43, 59, 67, 71, ...)")

# ---------- D. peeling lemma ----------
print("== D. peeling lemma (CLG-b) ==")


def peel_check(N, k):
    def inB(z):
        z %= N
        return k * min(z, N - z) >= N
    bad = 0
    tested = 0
    Xs = []
    for mask in range(1, 1 << N):
        X = [z for z in range(N) if mask >> z & 1]
        if PLANT != "asym" and any(((-z) % N) not in X for z in X):
            continue
        Xs.append(X)
    for X in Xs:
        outside = [z for z in X if not inB(z)]
        if not outside:
            continue
        for y in range(N):  # Y may be taken one point at a time: the claim is pointwise in y
            if all(inB(x + y) for x in X):
                tested += 1
                yy = min(y, N - y)
                # the conclusion holds for every outside x, so test the largest ||x||
                dmax = max(min(z % N, N - z % N) for z in outside)
                if not (k * yy >= N + k * dmax):
                    bad += 1
    return bad, tested


for N in (12, 13):
    for k in (3, 4, 5):
        bad, tested = peel_check(N, k)
        check(bad == 0, f"D N={N} k={k}: {tested} (X, y) pairs with X + y in B_k and X leaving B_k; violations {bad}")

print()
if fails:
    print(f"RED: {len(fails)} check(s) failed" + (f" under plant {PLANT}" if PLANT else ""))
    sys.exit(1)
print("GREEN: every check passed" + (f" (plant {PLANT} did NOT fire)" if PLANT else ""))
sys.exit(0)

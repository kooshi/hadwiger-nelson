#!/usr/bin/env python3
"""J09v (FS-91 crunch): exact checks of the derived claim J4 ("no mixing") on named fields.

Every check here tests a claim the derivation in plans/FS91-S1V-no-mixing.md (stage 2) fixed first; nothing here searches for
a witness.  Four parts, each an exact computation of seconds:

  A. field arithmetic (PARI/gp): for each named real field F, the primes of F above 3 with residue field F_3 (N_3), and the
     primes above 2 with their behaviour in L = F(i)/F (split = not stable; inert or ramified = stable).
  B. level one: the band-3 characters of Cay(F_{q^2}, mu_{q+1}) at q in {3, 7, 11, 19, 23, 27} and U_Q at Q in {2, 4, 8}
     (derivation step 6b predicts 4 at q = 3 and 0 elsewhere; q >= 19 is also Hoffman-Weil's).
  C. higher levels, one stable place at a time, in explicit local rings O = A[j] mod p^k: every band-3 character of the
     level-p^k target, and whether it factors through level one (step 6a predicts: only at the F_3 places, 4 each, all level one;
     none at the inert dyadic place; many at a ramified stable dyadic place, which the hypothesis excludes).
  D. no mixing: every character of the product of the local rings of the stable places above N, on the product of the local
     unit-circle images (the joint image, Lemma (J)/(W)); step 7 predicts exactly 4 N_3 band-3 characters when no stable
     dyadic place is ramified in L/F.

Plants (each paired with its faithful run; a plant must move the count, for its own reason):
  P1  the joint image replaced by the diagonal {(s, s)} at Q(sqrt7)'s two 3-places -> mixed characters appear (the proof's
      independence input removed);
  P2  complex conjugation replaced by the identity in the local circle (S = {1}) -> the level-one count at q = 3 leaves 4;
  P3  the unit i dropped from mu_4 at q = 3 (the circle loses a generator) -> the count leaves 4.

Usage: python3 tools/crunch_j09v_check.py [--out data/fs91/j09v/check.txt]
"""
from __future__ import annotations

import argparse
import itertools
import subprocess
import sys

import numpy as np

# ----------------------------------------------------------------------------------------------------------------------
# A. field arithmetic through gp

FIELDS = {
    # name: (defining polynomial of F in y, remark)
    "Q": ("y-1", "ramified stable dyadic (contrast)"),
    "Q(sqrt3)": ("y^2-3", ""),
    "Q(sqrt5)": ("y^2-5", "ramified stable dyadic (contrast)"),
    "Q(sqrt7)": ("y^2-7", "two F_3 places"),
    "Q(sqrt11)": ("y^2-11", ""),
    "Q(sqrt2,sqrt3)": ("polcompositum(y^2-2,y^2-3)[1]", ""),
    "Q(sqrt3,sqrt7)": ("polcompositum(y^2-3,y^2-7)[1]", "two F_3 places, ramified over Q"),
}

GP_TEMPLATE = r"""
nf=nfinit(%s); rnf=rnfinit(nf,x^2+1);
P3=idealprimedec(nf,3); n3=0; for(k=1,#P3, if(P3[k].f==1, n3++));
s3=""; for(k=1,#P3, s3=Str(s3, "(e=",P3[k].e,",f=",P3[k].f,")"));
P2=idealprimedec(nf,2); s2="";
for(k=1,#P2, Q=rnfidealprimedec(rnf,P2[k]); if(#Q==2, s2=Str(s2,"split;"), \
  re=Q[1].e/P2[k].e; rf=Q[1].f/P2[k].f; s2=Str(s2, if(re==2,"RAMIFIED","inert"), "(eF=",P2[k].e,",Q=2^",P2[k].f,");")));
print(n3, "|", s3, "|", s2);
"""


def field_table() -> dict[str, tuple[int, str, str]]:
    out = {}
    for name, (pol, _) in FIELDS.items():
        res = subprocess.run(["gp", "-q", "--default", "parisize=64000000"], input=GP_TEMPLATE % pol,
                             capture_output=True, text=True, check=True)
        line = res.stdout.strip().splitlines()[-1]
        n3, s3, s2 = (t.strip() for t in line.split("|"))
        out[name] = (int(n3), s3, s2)
    return out


# ----------------------------------------------------------------------------------------------------------------------
# B. level one over finite fields

def gf_q2_prime(q: int):
    """F_{q^2} = F_q[i] for a prime q = 3 mod 4: elements (x, y) = x + y i."""
    elts = [(x, y) for x in range(q) for y in range(q)]
    circle = [(x, y) for (x, y) in elts if (x * x + y * y) % q == 1]
    return elts, circle


def band3_level_one_prime(q: int, drop_i: bool = False) -> int:
    elts, circle = gf_q2_prime(q)
    assert len(circle) == q + 1, (q, len(circle))
    if drop_i:  # P3: remove i and -i from the circle
        circle = [s for s in circle if s not in ((0, 1), (0, q - 1))]
    count = 0
    for (a, b) in elts:  # character lambda_a(s) = Tr(a s)/q = 2 Re(a s)/q, a = a + b i
        ok = True
        for (x, y) in circle:
            v = (2 * (a * x - b * y)) % q
            if not (3 * v >= q and 3 * v <= 2 * q):
                ok = False
                break
        count += ok
    return count


def band3_level_one_27() -> int:
    """q = 27: F_27 = F_3[t]/(t^3 - t + 1), F_729 = F_27[i]; lambda_a(s) = Tr_{F27/F3}(2 Re(a s)) / 3."""
    p = 3

    def mul27(u, v):
        c = [0] * 5
        for i in range(3):
            for j in range(3):
                c[i + j] += u[i] * v[j]
        for d in (4, 3):  # t^3 = t - 1
            if c[d]:
                c[d - 2] += c[d]
                c[d - 3] -= c[d]
                c[d] = 0
        return tuple(x % p for x in c[:3])

    def add(u, v):
        return tuple((a + b) % p for a, b in zip(u, v))

    def neg(u):
        return tuple((-a) % p for a in u)

    f27 = list(itertools.product(range(3), repeat=3))
    # trace F27 -> F3 of 1, t, t^2: roots of t^3 - t + 1 sum to 0 (coeff of t^2), Tr(t) = 0; Tr(1) = 3 = 0;
    # Tr(t^2) = (sum r)^2 - 2 (sum r r') = 0 - 2(-1) = 2.
    tr = (0, 0, 2)

    def trace(u):
        return sum(a * b for a, b in zip(u, tr)) % p

    circle = [(x, y) for x in f27 for y in f27 if add(mul27(x, x), mul27(y, y)) == (1, 0, 0)]
    assert len(circle) == 28, len(circle)
    count = 0
    for a in f27:
        for b in f27:
            ok = True
            for (x, y) in circle:
                re = add(mul27(a, x), neg(mul27(b, y)))
                v = trace(add(re, re))
                if v == 0:
                    ok = False
                    break
            count += ok
    return count


def band3_UQ(f: int) -> int:
    """U_Q at Q = 2^f: Cay(F_{Q^2}, mu_{Q+1}); characters take values in {0, 1/2}; band 3 needs 1/2 on all of mu_{Q+1}."""
    n = 2 * f  # F_{2^n} by a fixed irreducible polynomial
    polys = {2: 0b111, 4: 0b10011, 6: 0b1000011}
    mod = polys[n]
    size = 1 << n

    def mul(a, b):
        r = 0
        while b:
            if b & 1:
                r ^= a
            b >>= 1
            a <<= 1
            if a & size:
                a ^= mod
        return r

    def power(a, e):
        r = 1
        while e:
            if e & 1:
                r = mul(r, a)
            a = mul(a, a)
            e >>= 1
        return r

    Q = 1 << f
    circle = [x for x in range(1, size) if power(x, Q + 1) == 1]
    assert len(circle) == Q + 1
    count = 0
    for a in range(1, size):  # characters x -> parity(popcount(a & x)) (all of them, as a runs over F_2^n)
        if all(bin(a & s).count("1") % 2 == 1 for s in circle):
            count += 1
    return count


# ----------------------------------------------------------------------------------------------------------------------
# C, D. explicit local rings O = A[j] mod p^k

class Local:
    """O = A[j]/(j^2 - sj*j + nj), A = Z_p[t]/(t^2 - g1 t - g0) (rankA = 2) or Z_p (rankA = 1); c fixes A, c(j) = sj - j.
    Elements mod M = p^k as tuples (a0, a1, b0, b1) meaning (a0 + a1 t) + (b0 + b1 t) j (a1 = b1 = 0 when rankA = 1).
    `ram_uniformizer_ratio`: for a place ramified in L/F, pi_L / c(pi_L) as an element (so S = S_units u ratio * S_units)."""

    def __init__(self, name, p, rankA, g, sj, nj, residue_q, level_one_ideal_gens, ram_ratio=None):
        self.name, self.p, self.rankA, self.g, self.sj, self.nj = name, p, rankA, g, sj, nj
        self.residue_q = residue_q          # size of the residue field of O (so units: z mod P != 0)
        self.P_gens = level_one_ideal_gens  # generators of the maximal ideal P of O, as elements (additively with O)
        self.ram_ratio = ram_ratio

    # A arithmetic
    def amul(self, x, y, M):
        (x0, x1), (y0, y1) = x, y
        g1, g0 = self.g
        c0 = x0 * y0 + x1 * y1 * g0
        c1 = x0 * y1 + x1 * y0 + x1 * y1 * g1
        return (c0 % M, c1 % M)

    def aadd(self, x, y, M):
        return ((x[0] + y[0]) % M, (x[1] + y[1]) % M)

    def mul(self, u, v, M):
        a, b = (u[0], u[1]), (u[2], u[3])
        c, d = (v[0], v[1]), (v[2], v[3])
        ac, bd = self.amul(a, c, M), self.amul(b, d, M)
        ad_bc = self.aadd(self.amul(a, d, M), self.amul(b, c, M), M)
        # j^2 = sj j - nj
        r0 = self.aadd(ac, self.amul(bd, ((-self.nj) % M, 0), M), M)
        r1 = self.aadd(ad_bc, self.amul(bd, (self.sj % M, 0), M), M)
        return (r0[0], r0[1], r1[0], r1[1])

    def conj(self, u, M, identity=False):
        if identity:
            return u
        a, b = (u[0], u[1]), (u[2], u[3])
        # c(a + b j) = (a + b sj) - b j
        a2 = self.aadd(a, self.amul(b, (self.sj % M, 0), M), M)
        return (a2[0], a2[1], (-b[0]) % M, (-b[1]) % M)

    def elements(self, M):
        r = range(M)
        if self.rankA == 1:
            return [(a, 0, b, 0) for a in r for b in r]
        return list(itertools.product(r, r, r, r))

    def rank(self):
        return 2 * self.rankA

    def vec(self, u):
        return (u[0], u[2]) if self.rankA == 1 else u

    def is_unit(self, u, M):
        """u is a unit of O/M iff multiplication by u is invertible on O/pO, i.e. its determinant is non-zero mod p."""
        p = self.p
        basis = [self.unit_vec(i) for i in range(self.rank())]
        mat = [self.vec(self.mul(u, e, p)) for e in basis]
        return _det_int(mat) % p != 0

    def unit_vec(self, i):
        v = [0] * 4
        idx = [0, 2][i] if self.rankA == 1 else i
        v[idx] = 1
        return tuple(v)

    def inverse(self, u, M):
        # u^{-1} = u^(e-1) with e the exponent of (O/M)^x; |(O/M)^x| = |O/M| (1 - 1/residue_q)
        order = (M ** self.rank()) // self.residue_q * (self.residue_q - 1)
        return self.power(u, order - 1, M)

    def power(self, u, e, M):
        r = self.one()
        while e:
            if e & 1:
                r = self.mul(r, u, M)
            u = self.mul(u, u, M)
            e >>= 1
        return r

    def one(self):
        return (1, 0, 0, 0)

    def circle(self, M, conj_identity=False):
        """Image of T(F_p) = {z / c(z)} in O/M: z over the units (unramified in L/F), and also ratio * those (ramified)."""
        S = set()
        for z in self.elements(M):
            if not self.is_unit(z, M):
                continue
            u = self.mul(z, self.inverse(self.conj(z, M, conj_identity), M), M)
            S.add(u)
        if self.ram_ratio is not None:
            S |= {self.mul(self.ram_ratio, s, M) for s in S}
        return sorted(S)

    def kills_level_one(self, chi, M):
        """Does the character chi (a vector mod M) kill P/M, i.e. factor through O/P?  P generated as an O-module by P_gens:
        additively by P_gens times the Z_p-basis."""
        basis = [self.unit_vec(i) for i in range(self.rank())]
        for gen in self.P_gens:
            for e in basis:
                w = self.vec(self.mul(gen, e, M))
                if sum(c * x for c, x in zip(chi, w)) % M:
                    return False
        return True


def _det_int(m):
    m = [list(r) for r in m]
    n = len(m)
    # Bareiss fraction-free determinant
    sign, prev = 1, 1
    for k in range(n - 1):
        if m[k][k] == 0:
            for r in range(k + 1, n):
                if m[r][k]:
                    m[k], m[r] = m[r], m[k]
                    sign = -sign
                    break
            else:
                return 0
        for i in range(k + 1, n):
            for j in range(k + 1, n):
                m[i][j] = (m[i][j] * m[k][k] - m[i][k] * m[k][j]) // prev
        prev = m[k][k]
    return sign * m[n - 1][n - 1]


# the local types
U3 = Local("Z3[i] (F_p = Q_3; e=1, q=3)", 3, 1, (0, 0), 0, 1, 9, [(3, 0, 0, 0)])
R3 = Local("Z3[sqrt3][i] (F_p = Q_3(sqrt3); e=2, q=3)", 3, 2, (0, 3), 0, 1, 9, [(0, 1, 0, 0)])
D3 = Local("Z2[sqrt3][omega] (F_p = Q_2(sqrt3); inert in L/F, Q=2)", 2, 2, (0, 3), -1, 1, 4, [(0, 1, 0, 0), (1, 1, 0, 0)])
# D3's maximal ideal: 2 = unit * (1+sqrt3)^2 in Z2[sqrt3], P = (1 + sqrt3) O; generators (1+t) (and t-1 = (1+t) - 2); we give
# (1 + t) and t + ... -- the additive span of {(1+t) * basis} is the ideal; the second generator is redundant but harmless.
D3.P_gens = [(1, 1, 0, 0)]
R2 = Local("Z2[i] (F_p = Q_2; RAMIFIED in L/F)", 2, 1, (0, 0), 0, 1, 2, [(1, 0, 1, 0)], ram_ratio=(0, 0, 1, 0))
# R2's uniformizer 1+i; (1+i)/(1-i) = i, so S = S_units u i*S_units.
R2p = Local("Z2[zeta3][i] (F_p = Q_2(sqrt5)=Q_2(zeta3); RAMIFIED in L/F)", 2, 2, (-1, -1), 0, 1, 4, [(1, 0, 1, 0)],
            ram_ratio=(0, 0, 1, 0))
# A = Z2[zeta3]: t^2 = -t - 1 (g1 = -1, g0 = -1).


def band_mask(vals: np.ndarray, M: int) -> np.ndarray:
    v = vals % M
    return (3 * v >= M) & (3 * v <= 2 * M)


def local_band3(loc: Local, k: int, conj_identity=False):
    M = loc.p ** k
    S = loc.circle(M, conj_identity)
    Svec = np.array([loc.vec(s) for s in S], dtype=np.int64)
    chars = np.array(list(itertools.product(range(M), repeat=loc.rank())), dtype=np.int64)
    vals = chars @ Svec.T
    ok = band_mask(vals, M).all(axis=1)
    band = chars[ok]
    lvl1 = sum(loc.kills_level_one(tuple(int(x) for x in c), M) for c in band)
    orders = sorted({int(M // np.gcd.reduce(np.append(c, M))) for c in band})
    return len(S), len(band), lvl1, orders


def product_band3(locs, ks, diagonal=False):
    """Characters of prod O_i / p_i^{k_i} on the product of the circles (the joint image); count the band-3 ones.  N = lcm."""
    Ms = [loc.p ** k for loc, k in zip(locs, ks)]
    circles = [np.array([loc.vec(s) for s in loc.circle(M)], dtype=np.int64) for loc, M in zip(locs, Ms)]
    charsets = [np.array(list(itertools.product(range(M), repeat=loc.rank())), dtype=np.int64) for loc, M in zip(locs, Ms)]
    # values as fractions with common denominator N
    N = int(np.lcm.reduce(Ms))
    locvals = [((cs @ ci.T) % M) * (N // M) for cs, ci, M in zip(charsets, circles, Ms)]  # [n_chars_i, n_circle_i] in Z/N
    if diagonal:
        assert len(locs) == 2 and locs[0] is locs[1] and ks[0] == ks[1]
        # joint image replaced by {(s, s)}: value = v0[c0, s] + v1[c1, s]
        v0, v1 = locvals
        tot = (v0[:, None, :] + v1[None, :, :]) % N  # [c0, c1, s]
        ok = band_mask(tot, N).all(axis=2)
        return int(ok.sum())
    # product image: the value set of (c_1, c_2) is the Minkowski sum of the local value sets.  Encode each local value set
    # as a bitmask over Z/N; (A + B) lies in the band iff B is inside allowed(A) = the intersection over a in A of (band - a).
    if len(locs) == 1:
        return int(band_mask(locvals[0], N).all(axis=1).sum())
    assert len(locs) == 2
    band = [v for v in range(N) if 3 * v >= N and 3 * v <= 2 * N]

    def masks(vals):
        out = {}
        for row in vals:
            m = 0
            for v in set(int(x) for x in row):
                m |= 1 << v
            out[m] = out.get(m, 0) + 1
        return out

    mA, mB = masks(locvals[0]), masks(locvals[1])
    full = (1 << N) - 1
    count = 0
    for a_mask, a_mult in mA.items():
        allowed = full
        for a in range(N):
            if a_mask >> a & 1:
                shifted = 0
                for b in band:
                    shifted |= 1 << ((b - a) % N)
                allowed &= shifted
        for b_mask, b_mult in mB.items():
            if b_mask & ~allowed == 0:
                count += a_mult * b_mult
    return count


# ----------------------------------------------------------------------------------------------------------------------

def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--out", default=None)
    args = ap.parse_args()
    lines: list[str] = []
    fails: list[str] = []

    def say(s=""):
        print(s)
        lines.append(s)

    def expect(cond, msg):
        if not cond:
            fails.append(msg)
            say("  !! FAIL: " + msg)

    say("J09v exact checks of J4 (plans/FS91-S1V-no-mixing.md stage 2)")
    say()
    say("A. field arithmetic (gp): N_3 = #primes of F above 3 with residue field F_3; primes above 2 in L = F(i)/F")
    ft = field_table()
    for name, (n3, s3, s2) in ft.items():
        say(f"  {name:16s} N_3 = {n3}   primes over 3: {s3:22s} primes over 2 in L/F: {s2}   {FIELDS[name][1]}")
    expect(ft["Q(sqrt3)"][0] == 1 and ft["Q(sqrt7)"][0] == 2 and ft["Q(sqrt11)"][0] == 0, "N_3 at Q(sqrt3), Q(sqrt7), Q(sqrt11)")
    expect(ft["Q(sqrt2,sqrt3)"][0] == 0 and ft["Q(sqrt3,sqrt7)"][0] == 2, "N_3 at the biquadratics")
    expect("RAMIFIED" in ft["Q"][2] and "RAMIFIED" in ft["Q(sqrt5)"][2], "contrast fields have a ramified stable dyadic prime")
    for nm in ("Q(sqrt3)", "Q(sqrt7)", "Q(sqrt11)", "Q(sqrt2,sqrt3)", "Q(sqrt3,sqrt7)"):
        expect("RAMIFIED" not in ft[nm][2], f"{nm} satisfies the hypothesis")

    say()
    say("B. level one: band-3 characters of Cay(F_{q^2}, mu_{q+1}) and of U_Q")
    for q in (3, 7, 11, 19, 23):
        c = band3_level_one_prime(q)
        say(f"  q = {q:2d}: {c}")
        expect(c == (4 if q == 3 else 0), f"level one at q = {q}")
    c27 = band3_level_one_27()
    say(f"  q = 27: {c27}")
    expect(c27 == 0, "level one at q = 27")
    for f in (1, 2, 3):
        c = band3_UQ(f)
        say(f"  U_Q, Q = {2 ** f}: {c}")
        expect(c == 0, f"U_{2 ** f}")

    say()
    say("C. higher levels, one stable place: (|S| at level p^k, #band-3 characters, #of those factoring through level one, orders)")
    cases = [(U3, 1), (U3, 2), (U3, 3), (R3, 1), (R3, 2), (D3, 1), (D3, 2), (D3, 3), (R2, 1), (R2, 2), (R2, 3),
             (R2p, 1), (R2p, 2), (R2p, 3)]
    for loc, k in cases:
        nS, nb, l1, orders = local_band3(loc, k)
        say(f"  {loc.name:55s} mod {loc.p}^{k}: |S| = {nS:4d}  band-3 = {nb:3d}  level-one = {l1:3d}  orders = {orders}")
        if loc in (U3, R3):
            expect(nb == 4 and l1 == 4 and orders == [3], f"{loc.name} mod {loc.p}^{k}")
        if loc is D3:
            expect(nb == 0, f"{loc.name} mod {loc.p}^{k}")
        if loc in (R2, R2p):
            expect(nb >= 1, f"{loc.name} mod {loc.p}^{k} (contrast: a band character exists)")

    say()
    say("D. no mixing: band-3 characters of prod_P O_P/N on the product circle, against 4 N_3")
    mix = [
        ("Q(sqrt7)", [U3, U3], [1, 1]), ("Q(sqrt7)", [U3, U3], [2, 2]),
        ("Q(sqrt3,sqrt7)", [R3, R3], [1, 1]), ("Q(sqrt3,sqrt7)", [R3, R3], [2, 2]),
        ("Q(sqrt3)", [R3, D3], [2, 1]), ("Q(sqrt3)", [R3, D3], [2, 2]), ("Q(sqrt3)", [R3, D3], [1, 3]),
        ("Q(sqrt11)", [D3], [3]),
        ("Q", [U3, R2], [1, 1]), ("Q", [U3, R2], [1, 3]), ("Q(sqrt5)", [R2p], [3]),
    ]
    for name, locs, ks in mix:
        N = int(np.lcm.reduce([l.p ** k for l, k in zip(locs, ks)]))
        c = product_band3(locs, ks)
        want = 4 * ft[name][0]
        tag = "" if name not in ("Q", "Q(sqrt5)") else "  (hypothesis fails: expected to exceed 4 N_3)"
        say(f"  {name:16s} N = {N:3d} places {[l.name.split(' ')[0] for l in locs]}: {c}   4 N_3 = {want}{tag}")
        if name in ("Q", "Q(sqrt5)"):
            expect(c > want, f"contrast {name} N = {N}")
        else:
            expect(c == want, f"no mixing at {name}, N = {N}")

    say()
    say("Plants (each must move its count; the faithful partner is the run above)")
    p1 = product_band3([U3, U3], [1, 1], diagonal=True)
    say(f"  P1 diagonal joint image at Q(sqrt7), N = 3: {p1} (faithful 8)")
    expect(p1 > 8, "P1 must fire")
    _, p2, _, _ = local_band3(U3, 1, conj_identity=True)
    say(f"  P2 conjugation := identity, Z3[i] mod 3: {p2} (faithful 4)")
    expect(p2 != 4, "P2 must fire")
    p3 = band3_level_one_prime(3, drop_i=True)
    say(f"  P3 i dropped from mu_4 at q = 3: {p3} (faithful 4)")
    expect(p3 != 4, "P3 must fire")

    say()
    say("VERDICT: " + ("ALL CHECKS PASS" if not fails else f"{len(fails)} FAILURES: " + "; ".join(fails)))
    if args.out:
        with open(args.out, "w") as fh:
            fh.write("\n".join(lines) + "\n")
    return 0 if not fails else 1


if __name__ == "__main__":
    sys.exit(main())

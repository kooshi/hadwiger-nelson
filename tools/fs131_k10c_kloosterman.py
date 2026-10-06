#!/usr/bin/env python3
"""FS131-K10c: the sentence about to be assumed, checked by exact arithmetic where it can be computed.

[Weil1948] p. 207: k a finite field of q elements, characteristic not 2, psi a character of the additive group of k
not everywhere equal to 1, 4cd = a != 0:   | sum_{x != 0} psi(c x + d x^-1) | <= 2 sqrt(q).

What this tool checks, at each field named (default: 7 and 9, the brief's two; --all adds 3, 5, 11, 13, 25, 27, 49):

  (B)  for EVERY additive character psi != 1 (all q - 1 of them, enumerated as the F_p-linear functionals of k, which
       are all the characters of an elementary abelian p-group) and EVERY pair c != 0, d != 0:
       |K|^2 <= 4q, where K = sum_{x != 0} psi(c x + d x^-1) is held as a vector of exponent counts in Z[zeta_p];
  (I)  the page's "elementary transformation": sum_x psi(x) chi(x^2 - a) = K(psi; c, d) whenever 4cd = a != 0, chi the
       character of order 2 with chi(0) = 0 — as an identity in Z[zeta_p];
  (C)  the page's condition against the Lean statement's: {(c, d) : 4cd != 0} = {(c, d) : c != 0 and d != 0}.

No floats.  |K|^2 = K * conj(K) is an element sum_d e_d zeta^d of Z[zeta_p] with e_d = e_{-d}; its sign against 4q is
decided in exact rational interval arithmetic: x = 2cos(2 pi/p) is the largest root of Psi_p(x) = 1 + sum_{d<=m} P_d(x)
(m = (p-1)/2, P_0 = 2, P_1 = x, P_{d+1} = x P_d - P_{d-1}, so P_d(zeta + 1/zeta) = zeta^d + zeta^-d); the m roots are
isolated by sign changes on a rational grid (exactly m intervals found, asserted), the top one bisected to width 2^-80,
and 4q - |K|^2 = (4q - e_0) - sum_{d=1..m} e_d P_d(x) evaluated on that interval.  An interval straddling 0 is decided
by exact division by Psi_p (zero remainder: equality) — otherwise the tool exits 3, never guessing.

  --fault trivial    also admit psi = 1                 (must find a violation: K = q - 1)
  --fault zero       also admit c = d = 0               (must find a violation: K = q - 1)
  --fault const      test |K| <= sqrt(q), constant 1    (must find a violation: the check sees the constant)
  --fault transform  test the transformation at 2cd = a (must find a mismatch: the check sees the 4)
  --char2            also run q = 4, 8, 16 (outside the page's hypothesis; reported, never part of the verdict)

exit 0: every check passed (or, under --fault, exit 1 with the violation printed).
"""
import itertools
import sys
from fractions import Fraction


# ---------- finite fields F_q, q = p^f, as tuples over F_p modulo a monic irreducible ----------

def poly_mulmod(a, b, mod, p):
    f = len(mod) - 1
    res = [0] * (2 * f - 1)
    for i, ai in enumerate(a):
        if ai:
            for j, bj in enumerate(b):
                res[i + j] = (res[i + j] + ai * bj) % p
    for k in range(2 * f - 2, f - 1, -1):
        c = res[k]
        if c:
            for j in range(f + 1):
                res[k - f + j] = (res[k - f + j] - c * mod[j]) % p
    return tuple(res[:f])


def find_irreducible(p, f):
    """A monic irreducible of degree f over F_p, by exhausting monic divisors of degree <= f/2 (low-order first)."""
    if f == 1:
        return (0, 1)

    def divides(d, g):
        g = list(g)
        dd = len(d) - 1
        for k in range(len(g) - 1, dd - 1, -1):
            c = g[k]
            if c:
                for j in range(dd + 1):
                    g[k - dd + j] = (g[k - dd + j] - c * d[j]) % p
        return not any(g[:dd])

    for low in itertools.product(range(p), repeat=f):
        g = tuple(low) + (1,)
        if all(not divides(tuple(dl) + (1,), g)
               for dd in range(1, f // 2 + 1) for dl in itertools.product(range(p), repeat=dd)):
            return g
    raise RuntimeError("no irreducible found")


class Field:
    def __init__(self, p, f):
        self.p, self.f, self.q = p, f, p ** f
        self.mod = find_irreducible(p, f)
        self.elems = [tuple(reversed(t)) for t in itertools.product(range(p), repeat=f)]
        self.zero = tuple([0] * f)
        self.one = tuple([1] + [0] * (f - 1))
        self.idx = {e: i for i, e in enumerate(self.elems)}
        n = self.q
        self.mul = [[self.idx[poly_mulmod(a, b, self.mod, p)] for b in self.elems] for a in self.elems]
        self.add = [[self.idx[tuple((x + y) % p for x, y in zip(a, b))] for b in self.elems] for a in self.elems]
        self.i0, self.i1 = self.idx[self.zero], self.idx[self.one]
        self.inv = [None] * n
        for a in range(n):
            if a != self.i0:
                (b,) = [b for b in range(n) if self.mul[a][b] == self.i1]   # exactly one inverse: it is a field
                self.inv[a] = b
        # field sanity: no zero divisors
        assert all(self.mul[a][b] != self.i0 for a in range(n) for b in range(n) if a != self.i0 and b != self.i0)
        self.squares = {self.mul[a][a] for a in range(n) if a != self.i0}

    def chi(self, a):
        """the character of order 2, with chi(0) = 0 (the page: 'by agreeing that chi(0) = 0')."""
        return 0 if a == self.i0 else (1 if a in self.squares else -1)

    def scalar(self, n):
        r = self.i0
        for _ in range(n % self.p):
            r = self.add[r][self.i1]
        return r


# ---------- exact sign of a real element of Z[zeta_p] ----------

def P_polys(m):
    """P_d as integer coefficient lists (low order first), d = 0..m."""
    P = [[2], [0, 1]]
    for d in range(1, m):
        nxt = [0] + P[d]
        for i, c in enumerate(P[d - 1]):
            nxt[i] -= c
        P.append(nxt)
    return P[:m + 1]


def peval(c, x):
    r = Fraction(0)
    for a in reversed(c):
        r = r * x + a
    return r


def ieval(c, lo, hi):
    """interval Horner on [lo, hi], exact Fractions."""
    rl, rh = Fraction(0), Fraction(0)
    for a in reversed(c):
        cands = [rl * lo, rl * hi, rh * lo, rh * hi]
        rl, rh = min(cands) + a, max(cands) + a
    return rl, rh


class RealCyclotomic:
    def __init__(self, p):
        self.p = p
        self.m = m = (p - 1) // 2
        self.P = P_polys(max(m, 1))
        if p == 2:
            self.lo = self.hi = Fraction(-2)       # zeta = -1: x = zeta + 1/zeta = -2, exact
            self.psi = None
            return
        psi = [1]
        for d in range(1, m + 1):
            psi = [a + b for a, b in itertools.zip_longest(psi, self.P[d], fillvalue=0)]
        self.psi = psi                              # monic of degree m, roots 2cos(2 pi k/p), k = 1..m
        if p == 3:
            assert psi == [1, 1]                    # Psi_3 = x + 1: 2cos(2 pi/3) = -1, rational and exact
            self.lo = self.hi = Fraction(-1)
            return
        grid = [Fraction(k, 256) for k in range(-2 * 256, 2 * 256 + 1)]
        vals = [peval(psi, g) for g in grid]
        assert all(v != 0 for v in vals), "a grid point is a root"
        changes = [(grid[i], grid[i + 1]) for i in range(len(grid) - 1) if vals[i] * vals[i + 1] < 0]
        assert len(changes) == m, f"expected {m} isolating intervals, found {len(changes)}"
        lo, hi = changes[-1]                        # the largest root is 2cos(2 pi/p)
        slo = peval(psi, lo)
        while hi - lo > Fraction(1, 2 ** 80):
            mid = (lo + hi) / 2
            v = peval(psi, mid)
            assert v != 0
            if (v < 0) == (slo < 0):
                lo = mid
            else:
                hi = mid
        self.lo, self.hi = lo, hi

    def sign(self, e):
        """e[d], d = 0..p-1, integers with e[d] = e[-d]: the sign of sum_d e[d] zeta^d, exactly (-1, 0, 1)."""
        p, m = self.p, self.m
        assert all(e[d] == e[(-d) % p] for d in range(p)), "not a real element in symmetric form"
        if p == 2:
            v = e[0] - e[1]
            return (v > 0) - (v < 0)
        poly = [e[0]]
        for d in range(1, m + 1):
            poly = [a + e[d] * b for a, b in itertools.zip_longest(poly, self.P[d], fillvalue=0)]
        lo, hi = ieval(poly, self.lo, self.hi)
        if lo > 0:
            return 1
        if hi < 0:
            return -1
        # straddles 0: exact test for zero, by remainder modulo the monic Psi_p
        r = list(poly)
        dm = len(self.psi) - 1
        for k in range(len(r) - 1, dm - 1, -1):
            c = r[k]
            if c:
                for j in range(dm + 1):
                    r[k - dm + j] -= c * self.psi[j]
        if not any(r[:dm]):
            return 0
        print("UNDECIDED: interval straddles zero and the element is not zero — raise the precision")
        sys.exit(3)


# ---------- the checks ----------

def run_field(p, f, fault=None, verdict=True):
    F = Field(p, f)
    q, n = F.q, F.q
    R = RealCyclotomic(p)
    nonzero = [a for a in range(n) if a != F.i0]
    four = F.scalar(4)
    bad = 0
    # (C) the two conditions on the coefficients
    cond_page = {(c, d) for c in range(n) for d in range(n) if F.mul[four][F.mul[c][d]] != F.i0}
    cond_lean = {(c, d) for c in nonzero for d in nonzero}
    c_ok = cond_page == cond_lean
    # characters: psi_l(x) = zeta^(l . x), l in F_p^f
    functionals = list(itertools.product(range(p), repeat=f))
    chars = [l for l in functionals if any(l)] + ([tuple([0] * f)] if fault == "trivial" else [])
    pairs = [(c, d) for c in nonzero for d in nonzero] + ([(F.i0, F.i0)] if fault == "zero" else [])
    triples = equalities = mismatches = 0
    worst = None
    tdiv = 2 if fault == "transform" else 4
    tscalar = F.scalar(tdiv)
    for l in chars:
        ex = [sum(li * xi for li, xi in zip(l, F.elems[x])) % p for x in range(n)]     # exponent of psi at x
        # the left-hand sums S(a) = sum_x psi(x) chi(x^2 - a), as vectors in Z[zeta]
        S = {}
        for a in range(n):
            v = [0] * p
            for x in range(n):
                t = F.mul[x][x]
                # x^2 - a
                neg_a = [b for b in range(n) if F.add[a][b] == F.i0][0]
                v[ex[x]] += F.chi(F.add[t][neg_a])
            S[a] = v
        for (c, d) in pairs:
            cnt = [0] * p
            for x in nonzero:
                y = F.add[F.mul[c][x]][F.mul[d][F.inv[x]]]
                cnt[ex[y]] += 1
            triples += 1
            # |K|^2 = sum_d e_d zeta^d, e_d = sum_j cnt[j] cnt[j - d]
            e = [sum(cnt[j] * cnt[(j - dd) % p] for j in range(p)) for dd in range(p)]
            bound = q if fault == "const" else 4 * q
            g = [-x for x in e]
            g[0] += bound                                         # bound - |K|^2
            s = R.sign(g)
            if s < 0:
                bad += 1
                if bad <= 3:
                    print(f"  VIOLATION q={q}: l={l} c={F.elems[c]} d={F.elems[d]} exponent counts {cnt}: "
                          f"|K|^2 > {bound}")
            elif s == 0:
                equalities += 1
            # (I) the transformation, at a = 4cd (the fault: 2cd)
            if (c, d) in cond_lean and any(l):
                a = F.mul[tscalar][F.mul[c][d]]
                diff = [u - w for u, w in zip(S[a], cnt)]
                if len(set(diff)) != 1:                           # equal in Z[zeta_p] iff the difference is constant
                    mismatches += 1
                    if mismatches <= 2:
                        print(f"  MISMATCH q={q}: l={l} c={F.elems[c]} d={F.elems[d]}: "
                              f"sum psi(x)chi(x^2 - {tdiv}cd) = {S[a]} against K = {cnt}")
    ok = bad == 0 and mismatches == 0 and (c_ok or p == 2)
    tag = "" if verdict else "   [outside the page's hypothesis: reported only]"
    print(f"q={q:3d} (p={p}, modulus {F.mod}): {len(chars)} characters x {len(pairs)} pairs = {triples} sums; "
          f"violations of the bound {bad}; equalities {equalities}; transformation mismatches {mismatches}; "
          f"4cd != 0 <=> c, d != 0: {c_ok}  ->  {'PASS' if ok else 'FAIL'}{tag}")
    return ok


def main():
    args = sys.argv[1:]
    fault = None
    if "--fault" in args:
        fault = args[args.index("--fault") + 1]
        assert fault in ("trivial", "zero", "const", "transform")
    fields = [(7, 1), (3, 2)]
    if "--all" in args:
        fields = [(3, 1), (5, 1), (7, 1), (3, 2), (11, 1), (13, 1), (5, 2), (3, 3), (7, 2)]
    ok = True
    for (p, f) in fields:
        ok &= run_field(p, f, fault)
    if "--char2" in args:
        for (p, f) in [(2, 2), (2, 3), (2, 4)]:
            run_field(p, f, fault, verdict=False)
    print("RESULT:", "PASS — the bound, the transformation and the coefficient condition hold at every field named"
          if ok else "FAIL")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())

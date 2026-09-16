"""Independent checks of the two outside responses to reference/wall-at-six/WALL-AT-SIX.md (FS-54).

The responses (reference/wall-at-six/responses/) prove their claims by hand; this script checks the finite
instances with code that shares nothing with the responses' own appendix script: a different irreducible
polynomial, trial-division irreducibility, field elements as bit masks with a trace mask for the characters,
and the tower levels built over (Z/p^j)^2 and the Galois ring GR(9,3) with characters k.x / p^j.

  python3 tools/fs54_wall_feedback_verify.py            # all sections, about a minute
  python3 tools/fs54_wall_feedback_verify.py char2      # section A only
  python3 tools/fs54_wall_feedback_verify.py tower      # section B only

Every line printed is an assertion that held; a failed claim raises.
"""
import itertools
import sys
import time

import numpy as np


# ---------------------------------------------------------------- A. characteristic 2: U_Q, Q = 2^m

def pdeg(a):
    return a.bit_length() - 1


def pmod(a, b):
    db = pdeg(b)
    while a and pdeg(a) >= db:
        a ^= b << (pdeg(a) - db)
    return a


def irreducible_by_trial_division(f):
    n = pdeg(f)
    return all(pmod(f, g) != 0 for g in range(2, 1 << (n // 2 + 1)))


class GF2m:
    """F_{2^n} as bit masks modulo the LARGEST-integer irreducible polynomial of degree n (the responses' script
    and tools/fs54_char2_spectra.py take small ones, so the representations differ)."""

    def __init__(self, n):
        self.n = n
        self.size = 1 << n
        self.poly = next(f for f in range((1 << (n + 1)) - 1, 1 << n, -1) if irreducible_by_trial_division(f))
        # multiplication table by log/antilog over a primitive element found by order check
        order = self.size - 1
        primes = [r for r in range(2, order + 1) if order % r == 0 and all(r % s for s in range(2, int(r ** 0.5) + 1))]
        g = next(x for x in range(2, self.size) if self._pow_slow(x, order) == 1
                 and all(self._pow_slow(x, order // r) != 1 for r in primes))
        self.exp = [0] * (2 * order)
        self.log = [0] * self.size
        x = 1
        for i in range(order):
            self.exp[i] = x
            self.log[x] = i
            x = self._mul_slow(x, g)
        assert x == 1
        for i in range(order, 2 * order):
            self.exp[i] = self.exp[i - order]
        # trace to F_2 is linear: tmask bit i = Tr(t^i)
        self.tmask = sum(self._trace_slow(1 << i) << i for i in range(n))

    def _mul_slow(self, a, b):
        r = 0
        while b:
            if b & 1:
                r ^= a
            b >>= 1
            a <<= 1
            if a >> self.n:
                a ^= self.poly
        return r

    def _pow_slow(self, a, e):
        r = 1
        while e:
            if e & 1:
                r = self._mul_slow(r, a)
            a = self._mul_slow(a, a)
            e >>= 1
        return r

    def _trace_slow(self, a):
        s, x = 0, a
        for _ in range(self.n):
            s ^= x
            x = self._mul_slow(x, x)
        assert s in (0, 1)
        return s

    def mul(self, a, b):
        if a == 0 or b == 0:
            return 0
        return self.exp[self.log[a] + self.log[b]]

    def pow(self, a, e):
        if a == 0:
            return 0 if e else 1
        return self.exp[(self.log[a] * e) % (self.size - 1)]

    def inv(self, a):
        return self.exp[(-self.log[a]) % (self.size - 1)]

    def tr2(self, a):
        return (a & self.tmask).bit_count() & 1


def section_char2():
    print("== A. characteristic 2 ==")
    for m in range(1, 7):
        t0 = time.time()
        Q = 1 << m
        E = GF2m(2 * m)
        S = [u for u in range(1, E.size) if E.pow(u, Q + 1) == 1]
        assert len(S) == Q + 1
        Sset = set(S)
        norm = lambda d: E.pow(d, Q + 1)

        def trFQ(x):  # Tr_{F_Q/F_2}(x) for x in F_Q (x^{2^i}, i < m)
            s = 0
            for _ in range(m):
                s ^= x
                x = E.mul(x, x)
            assert s in (0, 1)
            return s

        # A1. Sidon: distinct unordered pairs of units have distinct sums
        sums = [u ^ v for u, v in itertools.combinations(S, 2)]
        assert len(set(sums)) == len(sums) and 0 not in sums
        # A2. common neighbours: |S ∩ (d+S)| = 2 Tr(1/N(d)) for every d != 0
        cn = {}
        for s in sums:
            cn[s] = cn.get(s, 0) + 2
        for d in range(1, E.size):
            assert cn.get(d, 0) == 2 * trFQ(E.inv(norm(d))), (Q, d)
        tri = sum(cn.get(u, 0) for u in S)
        assert (tri == 0) == (m % 2 == 0)
        line = ""
        if m % 2 == 1:
            w = next(x for x in S if x != 1 and E.pow(x, 3) == 1)  # F_4^* inside S iff 3 | Q+1
            for u in S:
                common = sorted(v for v in S if (u ^ v) in Sset)
                assert common == sorted([E.mul(w, u), E.mul(E.mul(w, w), u)])
            line = "; every edge {x, x+u} lies in exactly one K4, x + u.F4"
        else:
            assert all(E.pow(x, 3) != 1 for x in S if x != 1)
        # spectrum by the trace pairing: lambda_a = sum_u (-1)^Tr(a u)
        lam = [sum(1 - 2 * E.tr2(E.mul(a, u)) for u in S) for a in range(E.size)]
        lmin = min(lam[1:])
        print(f"Q={Q:3d}: Sidon; |S∩(d+S)| = 2·Tr(1/N(d)) for all {E.size - 1} d; "
              f"{'triangle-free' if tri == 0 else 'triangles'}{line}; lambda_min = {lmin} "
              f"(poly {E.poly:#x}, {time.time() - t0:.1f} s)")
        if m == 5:
            section_q32(E, S, lam)
        if m == 6:
            section_q64(E, S, lam)


def section_q32(E, S, lam):
    Sset = set(S)
    assert min(lam[1:]) == -11
    low = {a for a in range(1, E.size) if lam[a] == -11}
    assert low == Sset, "least-eigenvalue characters are exactly the unit circle under the trace pairing"

    def tr4(x):  # Tr_{E/F_4}: x + x^4 + x^16 + x^64 + x^256
        s = 0
        for _ in range(5):
            s ^= x
            x = E.pow(x, 4)
        return s
    F4 = [0] + [x for x in range(1, E.size) if E.pow(x, 3) == 1]
    assert len(F4) == 4
    T = [tr4(x) for x in range(E.size)]
    assert all(t in F4 for t in T)
    assert all(T[u] != 0 for u in S), "Tr_{E/F4} vanishes on no unit"
    assert all(T[x] != T[x ^ u] for x in range(E.size) for u in S), "x -> Tr_{E/F4}(x) is a proper 4-colouring"
    # lambda_a = 4 M_a - 11 with M_a the number of F4*-orbits of S killed by Tr_{E/F4}(a.)
    orbits = {min(E.mul(z, u) for z in F4[1:]) for u in S}
    assert len(orbits) == 11
    for a in range(1, E.size):
        M = sum(1 for o in orbits if tr4(E.mul(a, o)) == 0)
        assert lam[a] == 4 * M - 11
    # the 44 hyperplanes {x : Tr_{E/F4}(a x) = c}, a in S/F4*, c in F4: independent, size 256, 11 parallel classes
    classes = set()
    for o in orbits:
        vals = [tr4(E.mul(o, x)) for x in range(E.size)]
        for c in F4:
            A = frozenset(x for x in range(E.size) if vals[x] == c)
            assert len(A) == 256 and all((x ^ u) not in A for x in A for u in S)
            classes.add(A)
    assert len(classes) == 44
    # a binary codim-2 subspace W is a proper 4-colouring kernel iff lambda_a + lambda_b + lambda_{a+b} = -33,
    # i.e. {a, b, a+b} within the least eigenspace; count those planes
    planes = {frozenset((a, b, a ^ b)) for a in S for b in S if a != b and (a ^ b) in Sset}
    assert len(planes) == 11
    print("   Q=32: least-eigenvalue characters = S exactly (33); lambda_a = 4M_a - 11 for all a; Tr_{E/F4} is a "
          "proper 4-colouring; the 44 F4-hyperplanes are independent 256-sets in 11 parallel classes; exactly 11 "
          "binary planes {a,b,a+b} lie in S")


def section_q64(E, S, lam):
    lam = np.array(lam, dtype=np.int64)
    assert all(((x - 1) % 4) == 0 for x in lam[1:]), "lambda_a = 1 mod 4 for every nontrivial character"
    assert lam[1:].min() == -15
    # Walsh (mask) spectrum: the multiset over characters agrees with the trace-pairing one
    ind = np.zeros(E.size, dtype=np.int64)
    ind[S] = 1
    wal = ind.copy()
    h = 1
    while h < E.size:
        blk = wal.reshape(-1, 2 * h)
        left, right = blk[:, :h].copy(), blk[:, h:].copy()
        blk[:, :h], blk[:, h:] = left + right, left - right
        h *= 2
    assert sorted(wal.tolist()) == sorted(lam.tolist())
    # min over binary codim-2 subspaces of |S ∩ W| = (65 + w_a + w_b + w_{a^b}) / 4
    best = 10 ** 9
    idx = np.arange(1, E.size)
    for a in range(1, E.size):
        b = idx[idx > a]
        c = b ^ a
        vals = 65 + wal[a] + wal[b] + wal[c]
        vals = vals[c > b]  # each unordered plane once per choice of its smallest element... enough for the minimum
        if vals.size:
            best = min(best, int(vals.min()))
    assert best % 4 == 0 and best // 4 == 5
    print("   Q=64: lambda_a = 1 (mod 4) for all 4095 nontrivial characters; lambda_min = -15; the minimum of "
          "|S ∩ W| over binary codimension-2 subspaces W is exactly 5 (exhaustive over all pairs)")


# ---------------------------------------------------------------- B. inert towers over (Z/p^j)^2 and GR(9,3)

def tower_spectrum(points_mod, modulus, dim, chunk=16384):
    """Eigenvalues of Cay((Z/modulus)^dim, S) for S given as an int array (|S|, dim): lambda_k = sum_s cos(2 pi k.s/M)."""
    S = np.asarray(points_mod, dtype=np.int64)
    grid = np.indices((modulus,) * dim, dtype=np.int64).reshape(dim, -1).T
    out = np.empty(grid.shape[0])
    for i in range(0, grid.shape[0], chunk):
        dots = grid[i:i + chunk] @ S.T
        out[i:i + chunk] = np.cos(2 * np.pi * (dots % modulus) / modulus).sum(axis=1)
    return out


def check_level(label, Q, j, lam, degree, lmin1, new_bound):
    assert abs(lam.max() - degree) < 1e-6 and degree == Q ** (j - 1) * (Q + 1), (label, lam.max(), degree)
    got = lam.min()
    want = Q ** (j - 1) * lmin1
    assert abs(got - want) < 1e-6 * max(1, abs(want)), (label, got, want)
    print(f"   {label}: level {j}: |V| = {Q ** (2 * j)}, degree {degree} = Q^{j - 1}(Q+1), lambda_min = {got:.6f} "
          f"= Q^{j - 1}·({lmin1:.6f}); Hoffman 1 + d/|lambda_min| = {1 + degree / abs(got):.6f}")
    return got


def section_tower():
    print("== B. inert towers ==")
    # odd prime q = 3 mod 4: A_j = (Z/q^j)^2, norm x^2 + y^2
    for q, top in ((3, 4), (7, 3), (11, 2), (19, 2), (23, 2)):
        lmin1 = None
        for j in range(1, top + 1):
            M = q ** j
            r = np.arange(M, dtype=np.int64)
            X, Y = np.meshgrid(r, r, indexing="ij")
            mask = (X * X + Y * Y) % M == 1
            S = np.stack([X[mask], Y[mask]], axis=1)
            lam = tower_spectrum(S, M, 2)
            if j == 1:
                lmin1 = lam.min()
            else:
                # characters nontrivial on the last layer: k not divisible by q
                grid = np.indices((M, M)).reshape(2, -1).T
                new = (grid % q != 0).any(axis=1)
                assert np.abs(lam[new]).max() <= 2 * q ** (j - 1) + 1e-6
            check_level(f"q={q}", q, j, lam, len(S), lmin1, None)
    # q = 27: GR(9,3) = (Z/9)[t]/(t^3 - t - 1); level 1 is F_27 itself (mod 3), level 2 mod 9
    for j in (1, 2):
        M = 3 ** j
        def rmul(a, b):  # a, b coefficient triples mod M, reduce t^3 = t + 1, t^4 = t^2 + t
            c = [0] * 5
            for i in range(3):
                for k in range(3):
                    c[i + k] += a[i] * b[k]
            c0, c1, c2 = c[0] + c[3], c[1] + c[3] + c[4], c[2] + c[4]
            return (c0 % M, c1 % M, c2 % M)
        R = list(itertools.product(range(M), repeat=3))
        sq = {a: rmul(a, a) for a in R}
        by_sq = {}
        for a in R:
            by_sq.setdefault(sq[a], []).append(a)
        S = []
        for x in R:
            need = tuple((((1, 0, 0)[i] - sq[x][i]) % M) for i in range(3))
            for y in by_sq.get(need, []):
                S.append(x + y)
        lam = tower_spectrum(np.array(S), M, 6)
        if j == 1:
            lmin27 = lam.min()
            assert abs(lmin27 + 8) < 1e-9
        check_level("q=27 (GR(9,3))", 27, j, lam, len(S), lmin27, None)
    # dyadic Q = 2: A_j = (Z/2^j)[omega] = (Z/2^j)^2, norm x^2 - xy + y^2
    lmin1 = None
    for j in range(1, 7):
        M = 2 ** j
        r = np.arange(M, dtype=np.int64)
        X, Y = np.meshgrid(r, r, indexing="ij")
        mask = (X * X - X * Y + Y * Y) % M == 1
        S = np.stack([X[mask], Y[mask]], axis=1)
        lam = tower_spectrum(S, M, 2)
        if j == 1:
            lmin1 = lam.min()
        check_level("Q=2 (Z_2[omega])", 2, j, lam, len(S), lmin1, None)


if __name__ == "__main__":
    which = sys.argv[1:] or ["char2", "tower"]
    t0 = time.time()
    if "char2" in which:
        section_char2()
    if "tower" in which:
        section_tower()
    print(f"ALL CHECKS HELD ({time.time() - t0:.0f} s)")

#!/usr/bin/env python3
"""fplane_cert_check — the independent checker for an exact upper bound on the independence number
of a finite Euclidean plane UD(F_p, 2).

WHAT THIS PROGRAM IS FOR.  A certificate file says: "every set of points of F_p^2 with no two at
quadrance 1 has at most N points".  This program decides, in exact arithmetic, whether the file
proves that.  It runs no solver, reads no float, and imports nothing outside the Python standard
library.  `plans/FS50-certificate-soundness.md` is the one-page derivation of why the checks below
imply the claim; read it first if you are the stranger this file was written for.

WHAT IT TRUSTS.  Python's arbitrary-precision integers, `fractions.Fraction`, and the JSON parser's
reading of integers and strings.  Nothing else.  In particular it trusts NOTHING in the certificate
file: the group, its orbits on pairs, and the entire constraint system are rebuilt here from the
single number `p`, and the file's own copies are compared against them and a mismatch is refused by
name.  What the file genuinely supplies is only the list of multipliers, the two positive
semidefinite matrices, and the number N.

WHAT IT CHECKS, in the order of marginal evidence (each printed, silence is never a pass):
  1. the group and its orbits rebuilt from p, and the canonical constraint list, against the file;
  2. every multiplier attached to an inequality is >= 0;
  3. every positive semidefinite block: by a rational Gram factor (Z = B^T B, positive semidefinite
     for ANY rational B) or, when the block is given as a dense matrix, by an exact LDL^T with
     nonnegative pivots;
  4. the affine identity, coefficient by coefficient over the orbits and in the constant term:

         N - tr Y(y)  =  <Z1, Y(y)> + <Z2, M(y) - Y(y)> + sum_i lambda_i c_i(y) + sum_j nu_j e_j(y)

     as functions of the orbit variables y.  Every term on the right is >= 0 at the orbit variables
     of a genuine independent set S, and tr Y(y_S) = |S|; so |S| <= N.  That implication is the
     derivation, and it is the only step this program does not perform.

USAGE
  python3 tools/fplane_cert_check.py data/fs50/cert-p11-N29.json [--k 4] [--ldl]
  python3 tools/fplane_cert_check.py --self-test

`--k K` adds the colouring sentence when K * floor(N) < p^2.  `--ldl` additionally runs the exact
LDL^T on a block that came with a Gram factor (redundant, and slow at p = 11: minutes).
`--self-test` plants faults and watches each one refuse; it is described at `self_test`.
"""

from __future__ import annotations

import argparse
import json
import math
import sys
from fractions import Fraction

# --------------------------------------------------------------------------------------------
# exact reading: a float anywhere a number is expected is a refusal, not a rounding
# --------------------------------------------------------------------------------------------


class Refusal(Exception):
    """The certificate is refused; the message names the site."""


def as_int(x, where: str) -> int:
    if isinstance(x, bool) or not isinstance(x, int):
        raise Refusal(f"{where}: expected an integer, found {type(x).__name__} {x!r}")
    return x


def as_frac(x, where: str) -> Fraction:
    """A rational is an integer or a string "a" / "a/b".  A JSON float is refused by name: the wire
    form has no floats, and silently rounding one would put a reading where a proof belongs."""
    if isinstance(x, bool):
        raise Refusal(f"{where}: expected a rational, found the boolean {x!r}")
    if isinstance(x, int):
        return Fraction(x)
    if isinstance(x, float):
        raise Refusal(f"{where}: expected a rational as an integer or a string, found the float {x!r}")
    if isinstance(x, str):
        try:
            return Fraction(x)
        except (ValueError, ZeroDivisionError):
            raise Refusal(f"{where}: {x!r} does not parse as a rational a/b")
    raise Refusal(f"{where}: expected a rational, found {type(x).__name__} {x!r}")


def need(d, key, where):
    if not isinstance(d, dict) or key not in d:
        raise Refusal(f"{where}: the field {key!r} is missing")
    return d[key]


# --------------------------------------------------------------------------------------------
# the plane, its symmetry group, and the orbits of the group on ordered pairs
# --------------------------------------------------------------------------------------------


def is_prime(p: int) -> bool:
    if p < 2:
        return False
    d = 2
    while d * d <= p:
        if p % d == 0:
            return False
        d += 1
    return True


def build_orbits(p: int, plant_translation: bool = False) -> dict:
    """Everything the checker derives from `p` alone.

    Points of F_p^2 carry the vertex index v = x*p + y.  The quadrance of (x, y) is x^2 + y^2 mod p,
    and two points are adjacent when their difference has quadrance 1.

    The relaxation's variable y_k is indexed by an orbit of ORDERED PAIRS (u, v) of points under the
    group generated by
        (u, v) -> (g u, g v)   for every g in O(2, p)  (every rotation by a point of the unit circle,
                                                        and the reflection (x, y) -> (x, -y)),
        (u, v) -> (v, u),                              (the swap)
        (u, v) -> (-u, v - u),                         (relabelling a triple's base point: S3)
    because the matrix Y_S of an independent set is invariant under all of them once averaged over
    O(2, p) -- the last two hold exactly, before any averaging.  See the derivation, section 2.

    Returned: n, orb (orbit index per flat pair index u*n+v), K, rep (one representative pair per
    orbit, the lexicographically first), killed (does the orbit touch a unit vector), g_orbit[u] =
    the orbit of (0, u), t[k] = #{u : orbit of (u, u) is k} (the objective's coefficients), k0 = the
    orbit of (0, 0), sub[u][v] = the index of the difference of two points.
    """
    n = p * p
    pts = [(v // p, v % p) for v in range(n)]

    def vid(x, y):
        return (x % p) * p + (y % p)

    quad = [(x * x + y * y) % p for (x, y) in pts]
    circle = [(x, y) for (x, y) in pts if (x * x + y * y) % p == 1 % p]
    # the maps, as permutations of the n points
    maps = []
    for (a, b) in circle:                                   # every rotation, not a generator: the
        maps.append([vid(a * x - b * y, b * x + a * y) for (x, y) in pts])   # group needs no search
    maps.append([vid(x, -y) for (x, y) in pts])             # the reflection
    if plant_translation:                                   # FOR THE CONTROL ONLY, never for a
        maps.append([vid(x + 1, y + 1) for (x, y) in pts])   # certificate: translating a PAIR is not
        # a symmetry of the triple counts (the shift z -> z - w leaves S), so adding it here merges
        # orbits whose variables are genuinely different, and the soundness control must go red.
    neg = [vid(-x, -y) for (x, y) in pts]
    sub = [[vid(pts[u][0] - pts[v][0], pts[u][1] - pts[v][1]) for v in range(n)] for u in range(n)]

    parent = list(range(n * n))

    def find(i):
        while parent[i] != i:
            parent[i] = parent[parent[i]]
            i = parent[i]
        return i

    def union(i, j):
        i, j = find(i), find(j)
        if i != j:
            parent[i] = j

    for u in range(n):
        for v in range(n):
            i = u * n + v
            for m in maps:
                union(i, m[u] * n + m[v])
            union(i, v * n + u)                # swap
            union(i, neg[u] * n + sub[v][u])   # S3

    # orbits numbered by their least flat index: independent of the union-find's internals
    label = {}
    orb = [0] * (n * n)
    rep = []
    for i in range(n * n):
        r = find(i)
        if r not in label:
            label[r] = len(label)
            rep.append((i // n, i % n))
        orb[i] = label[r]
    K = len(label)

    one = 1 % p
    killed = [False] * K
    for u in range(n):
        for v in range(n):
            if quad[u] == one or quad[v] == one or quad[sub[v][u]] == one:
                killed[orb[u * n + v]] = True

    g_orbit = [orb[0 * n + v] for v in range(n)]
    t = [0] * K
    for u in range(n):
        if orb[u * n + u] != g_orbit[u]:
            raise Refusal(f"internal: the S3 relation does not tie Y[{u},{u}] to Y[0,{u}]")
        t[g_orbit[u]] += 1
    return dict(p=p, n=n, quad=quad, sub=sub, orb=orb, K=K, rep=rep, killed=killed,
                g_orbit=g_orbit, t=t, k0=orb[0], maps=maps, circle=circle)


def build_orbits_fast(p: int) -> dict:
    """The SAME object as `build_orbits`, built through the ROTATION orbits instead of the n^2 pairs.

    `build_orbits` unions n^2 flat pair indices under p+2 permutations; at p = 83 that is 47 million
    nodes and four billion unions, which no checker can run.  This function uses the one structural
    fact that makes the plane small: for p = 3 mod 4 every nonzero quadrance c occurs, its circle
    C_c = {Q = c} has exactly p+1 points, and the rotation group -- cyclic of order m = p+1,
    generated by some zeta on the unit circle -- acts SIMPLY TRANSITIVELY on each circle.  So fix
    the base point u_c (the least vertex index of the circle) and write every nonzero point as
    u_c zeta^theta.  Then:

      * the rotation orbits of ordered pairs of nonzero points are exactly the triples (c, c', d),
        d in Z/m, each of size m -- the pair (u_c zeta^t, u_c' zeta^(t+d)) for t in Z/m;
      * the pairs touching the origin fall into 2(p-1) + 1 further orbits: (0, C_c), (C_c, 0), (0,0);
      * the remaining generators of the full group act on those orbits by arithmetic:
            swap        (c, c', d) -> (c', c, -d),                (0,C_c) <-> (C_c,0)
            reflection  (c, c', d) -> (c, c', a_c' - a_c - d),    where sigma(u_c) = u_c zeta^(a_c)
            S3          (c, c', d) -> (c, c'', e - m/2),          where u_c' zeta^d - u_c = u_c'' zeta^e
                                      and -> (C_c, 0) when that difference is 0 (c = c', d = 0).

    So the union-find runs over (p-1)^2 (p+1) + 2(p-1) + 1 nodes -- 565 thousand at p = 83 against 47
    million -- and every other quantity follows.  The orbit NUMBERING is preserved exactly: orbits are
    numbered by ascending least flat pair index u*n + v, and the least flat index of the rotation orbit
    (c, c', d) is `base_index(c) * n + point(c', d)`, because the base point is the least index on its
    circle and n separates the u's.  `self_test` checks this function against `build_orbits` at
    p = 3, 7, 11, 19, 23 -- every orbit, every representative, every derived array.
    """
    if p % 4 != 3:
        raise Refusal(f"build_orbits_fast: p = {p} is not 3 mod 4")
    n, m = p * p, p + 1
    pts = [(v // p, v % p) for v in range(n)]

    def vid(x, y):
        return (x % p) * p + (y % p)

    def mul(a, b):
        return ((a[0] * b[0] - a[1] * b[1]) % p, (a[0] * b[1] + a[1] * b[0]) % p)

    quad = [(x * x + y * y) % p for (x, y) in pts]
    circle = [(x, y) for (x, y) in pts if (x * x + y * y) % p == 1 % p]
    if len(circle) != m:
        raise Refusal(f"build_orbits_fast: the unit circle has {len(circle)} points, expected {m}")
    zeta = None
    for cpt in circle:                      # a generator of the rotation group: order exactly m
        z, k = cpt, 1
        while z != (1, 0):
            z = mul(z, cpt)
            k += 1
        if k == m:
            zeta = cpt
            break
    if zeta is None:
        raise Refusal(f"build_orbits_fast: the rotation group at p = {p} has no generator of order {m}")
    classes = sorted({quad[v] for v in range(n)} - {0})
    C = len(classes)
    if C != p - 1:
        raise Refusal(f"build_orbits_fast: {C} circles, expected {p - 1}")
    ci = {c: i for i, c in enumerate(classes)}
    base = {}
    for v in range(n):
        c = quad[v]
        if c and c not in base:
            base[c] = pts[v]
    pt = [[0] * m for _ in range(C)]        # pt[ci][theta] = vertex index of u_c zeta^theta
    ang = [None] * n                        # ang[v] = (ci, theta) for v != 0
    for c in classes:
        w = base[c]
        for th in range(m):
            v = vid(*w)
            pt[ci[c]][th] = v
            ang[v] = (ci[c], th)
            w = mul(w, zeta)
        if pt[ci[c]][0] != vid(*base[c]):
            raise Refusal("build_orbits_fast: the circle did not close")
    for i in range(C):
        if any(ang[pt[i][th]] != (i, th) for th in range(m)):
            raise Refusal("build_orbits_fast: the angular coordinate is not injective")
    half = m // 2
    if mul(zeta, (1, 0)) == (1, 0) or pow_pt(zeta, half, mul) != ((-1) % p, 0):
        raise Refusal(f"build_orbits_fast: zeta^{half} is not -1")
    a_off = [0] * C                         # sigma(u_c) = u_c zeta^{a_c}, sigma(x, y) = (x, -y)
    for c in classes:
        x, y = base[c]
        a_off[ci[c]] = ang[vid(x, -y)][1]

    # ---- the node numbering of the rotation orbits
    NP = C * C * m

    def nz(a, b, d):
        return (a * C + b) * m + (d % m)

    def ZL(a):
        return NP + a

    def ZR(a):
        return NP + C + a

    ZZ = NP + 2 * C
    NR = NP + 2 * C + 1

    parent = list(range(NR))

    def find(i):
        while parent[i] != i:
            parent[i] = parent[parent[i]]
            i = parent[i]
        return i

    def union(i, j):
        i, j = find(i), find(j)
        if i != j:
            parent[i] = j

    # the S3 image, and the difference class, of every nonzero-nonzero rotation orbit
    s3 = [0] * NP
    diffq = [0] * NP                        # the quadrance of v - u (0 when v = u)
    for a in range(C):
        ua = pts[pt[a][0]]
        for b in range(C):
            row = pt[b]
            for d in range(m):
                v = pts[row[d]]
                w = ((v[0] - ua[0]) % p, (v[1] - ua[1]) % p)
                i = nz(a, b, d)
                if w == (0, 0):
                    s3[i] = ZR(a)
                    diffq[i] = 0
                else:
                    cpp, e = ang[vid(*w)]
                    s3[i] = nz(a, cpp, e - half)
                    diffq[i] = classes[cpp]
    for a in range(C):
        for b in range(C):
            for d in range(m):
                i = nz(a, b, d)
                union(i, nz(b, a, -d))                              # swap
                union(i, nz(a, b, a_off[b] - a_off[a] - d))          # the reflection
                union(i, s3[i])                                     # S3
    for a in range(C):
        union(ZL(a), ZR(a))                                          # swap
        union(ZR(a), nz(a, a, 0))                                    # S3: (u, 0) -> (-u, -u)

    # ---- the least flat pair index of each rotation orbit, and hence the orbit numbering
    least = [0] * NR
    for a in range(C):
        ba = pt[a][0]
        for b in range(C):
            row = pt[b]
            base_flat = ba * n
            off = (a * C + b) * m
            for d in range(m):
                least[off + d] = base_flat + row[d]
    for a in range(C):
        least[ZL(a)] = pt[a][0]
        least[ZR(a)] = pt[a][0] * n
    least[ZZ] = 0

    best = {}
    for i in range(NR):
        r = find(i)
        if r not in best or least[i] < best[r]:
            best[r] = least[i]
    order = sorted(best, key=lambda r: best[r])
    index = {r: k for k, r in enumerate(order)}
    K = len(order)
    rep = [(best[r] // n, best[r] % n) for r in order]
    rot_orb = [index[find(i)] for i in range(NR)]

    one = 1 % p
    killed = [False] * K
    for a in range(C):
        ca = classes[a]
        for b in range(C):
            cb = classes[b]
            off = (a * C + b) * m
            for d in range(m):
                if ca == one or cb == one or diffq[off + d] == one:
                    killed[rot_orb[off + d]] = True
    for a in range(C):
        if classes[a] == one:
            killed[rot_orb[ZL(a)]] = True
            killed[rot_orb[ZR(a)]] = True

    k0 = rot_orb[ZZ]
    zorb = [rot_orb[ZL(a)] for a in range(C)]
    g_orbit = [k0] * n
    for a in range(C):
        for th in range(m):
            g_orbit[pt[a][th]] = zorb[a]
    t = [0] * K
    t[k0] += 1
    for a in range(C):
        t[zorb[a]] += m

    rot_diff = [0] * NR                     # the orbit of (0, v - u) for the pairs of this rotation orbit
    for i in range(NP):
        q = diffq[i]
        rot_diff[i] = k0 if q == 0 else zorb[ci[q]]
    for a in range(C):
        rot_diff[ZL(a)] = zorb[a]
        rot_diff[ZR(a)] = zorb[a]
    rot_diff[ZZ] = k0

    return dict(p=p, n=n, m=m, C=C, K=K, classes=classes, ci=ci, pt=pt, ang=ang, quad=quad,
                zeta=zeta, a_off=a_off, rep=rep, killed=killed, g_orbit=g_orbit, t=t, k0=k0,
                zorb=zorb, rot_orb=rot_orb, rot_diff=rot_diff, NP=NP, NR=NR, circle=circle,
                nz=nz, ZL=ZL, ZR=ZR, ZZ=ZZ, fast=True)


def pow_pt(z, k, mul):
    r = (1, 0)
    for _ in range(k):
        r = mul(r, z)
    return r


def canonical_constraints(B: dict) -> list:
    """The relaxation's affine constraints, in a fixed order, rebuilt from `p` alone.

    Each row is (kind, sense, coeffs, rhs) and stands for the affine function
    f(y) = sum_k coeffs[k] * y_k - rhs, required to be >= 0 (sense ">=") or = 0 (sense "==").
    Every one of them holds at the orbit variables of a genuine independent set; the derivation's
    section 3 proves each.  Order: g0, then the killed orbits, then nonnegativity, then the
    entry-below-diagonal rows -- all ascending in the orbit index.
    """
    K, k0 = B["K"], B["k0"]
    rows = [("g0", "==", {k0: Fraction(1)}, Fraction(1))]
    for k in range(K):
        if B["killed"][k]:
            rows.append(("killed", "==", {k: Fraction(1)}, Fraction(0)))
    for k in range(K):
        rows.append(("nonneg", ">=", {k: Fraction(1)}, Fraction(0)))
    for k in range(K):
        if B["killed"][k] or k == k0:
            continue
        u, _v = B["rep"][k]
        d = B["g_orbit"][u]
        rows.append(("le_diag", ">=", {d: Fraction(1), k: Fraction(-1)}, Fraction(0)))
    return rows


# --------------------------------------------------------------------------------------------
# matrices: exact, and positive semidefinite for a reason the reader can see
# --------------------------------------------------------------------------------------------


def parse_int_matrix(obj, where: str):
    """A matrix as {"den": D, "num": [[integers]]} (its entries are num/D) or as a list of rows of
    rationals.  Returns (rows, cols, flat list of integer numerators, common denominator)."""
    if isinstance(obj, dict):
        den = as_frac(need(obj, "den", where), f"{where}.den")
        if den <= 0 or den.denominator != 1:
            raise Refusal(f"{where}.den: expected a positive integer, found {den}")
        den = int(den)
        num = need(obj, "num", where)
        if not isinstance(num, list) or not num:
            raise Refusal(f"{where}.num: expected a nonempty list of rows")
        cols = None
        flat = []
        for i, row in enumerate(num):
            if not isinstance(row, list):
                raise Refusal(f"{where}.num[{i}]: expected a list")
            if cols is None:
                cols = len(row)
            elif len(row) != cols:
                raise Refusal(f"{where}.num[{i}]: {len(row)} entries, expected {cols}")
            for j, e in enumerate(row):
                flat.append(as_int(e, f"{where}.num[{i}][{j}]"))
        return len(num), cols, flat, den
    if isinstance(obj, list):
        if not obj:
            raise Refusal(f"{where}: expected a nonempty list of rows")
        fr = []
        cols = None
        for i, row in enumerate(obj):
            if not isinstance(row, list):
                raise Refusal(f"{where}[{i}]: expected a list")
            if cols is None:
                cols = len(row)
            elif len(row) != cols:
                raise Refusal(f"{where}[{i}]: {len(row)} entries, expected {cols}")
            for j, e in enumerate(row):
                fr.append(as_frac(e, f"{where}[{i}][{j}]"))
        den = 1
        for f in fr:
            den = den * f.denominator // _gcd(den, f.denominator)
        return len(obj), cols, [int(f * den) for f in fr], den
    raise Refusal(f"{where}: expected a matrix, found {type(obj).__name__}")


def _gcd(a, b):
    while b:
        a, b = b, a % b
    return a


def gram_to_dense(rows, cols, flat, den):
    """Z = B^T B for the r-by-n integer matrix B/den: the n-by-n integer numerators over den^2.
    Positive semidefinite for ANY rational B -- that is the whole PSD argument in this form."""
    r, n = rows, cols
    cols_of_B = [[flat[i * n + u] for i in range(r)] for u in range(n)]
    out = [0] * (n * n)
    for u in range(n):
        bu = cols_of_B[u]
        for v in range(u, n):
            bv = cols_of_B[v]
            s = 0
            for i in range(r):
                s += bu[i] * bv[i]
            out[u * n + v] = s
            out[v * n + u] = s
    return out, den * den


def ldl_psd(flat, den, n):
    """Exact LDL^T on the symmetric rational matrix flat/den.  Returns (True, None) when it is
    positive semidefinite, else (False, the first pivot or entry that says it is not).

    The test is complete: a symmetric matrix is positive semidefinite exactly when this elimination
    runs with every pivot >= 0 and every row of a zero pivot identically zero."""
    # SYMMETRY FIRST, before any elimination. The elimination below reads only the upper triangle,
    # so without this an asymmetric matrix would be judged by its upper half alone -- and the
    # identity in section 3 of the derivation pairs Z with a SYMMETRIC Y, so what soundness needs is
    # that Z's symmetric part is positive semidefinite. Checking the whole matrix is the honest
    # version and costs one pass.
    for i in range(n):
        for j in range(i):
            if flat[i * n + j] != flat[j * n + i]:
                return False, (f"the matrix is not symmetric: entry ({i},{j}) = "
                               f"{Fraction(flat[i * n + j], den)} but ({j},{i}) = {Fraction(flat[j * n + i], den)}")
    A = [[Fraction(flat[i * n + j], den) for j in range(n)] for i in range(n)]
    for i in range(n):
        d = A[i][i]
        if d < 0:
            return False, f"pivot {i} is negative: {d}"
        if d == 0:
            for j in range(i + 1, n):
                if A[i][j] != 0:
                    return False, f"pivot {i} is zero but entry ({i},{j}) = {A[i][j]} is not"
            continue
        row = A[i]
        for j in range(i + 1, n):
            f = row[j] / d
            if f == 0:
                continue
            Aj = A[j]
            for m in range(j, n):
                Aj[m] -= f * row[m]
            for m in range(j, n):          # keep the lower triangle in step, so the symmetry test
                A[m][j] = Aj[m]            # above stays meaningful at every later pivot
    return True, None


def load_psd(obj, n, name, force_ldl, log):
    """One of the two matrices of the identity, as a sum of blocks Z = sum_b U_b Z_b U_b^T.  Each
    U_b is a rational n-by-m matrix (or absent, meaning the identity) and Z_b is an m-by-m block
    given either by a Gram factor or densely.  Z is positive semidefinite whatever the U_b are, so
    the block maps are never on the trust surface -- a wrong one can only weaken the certificate."""
    blocks = need(obj, "blocks", name)
    if not isinstance(blocks, list) or not blocks:
        raise Refusal(f"{name}.blocks: expected a nonempty list")
    total = [0] * (n * n)
    total_den = 1
    notes = []
    for b, blk in enumerate(blocks):
        where = f"{name}.blocks[{b}]"
        if "gram" in blk:
            r, m, flat, den = parse_int_matrix(blk["gram"], f"{where}.gram")
            zflat, zden = gram_to_dense(r, m, flat, den)
            note = f"a rational Gram factor B of shape {r}x{m} (Z = B^T B, positive semidefinite by construction)"
            if "Z" in blk:
                r2, c2, f2, d2 = parse_int_matrix(blk["Z"], f"{where}.Z")
                if (r2, c2) != (m, m):
                    raise Refusal(f"{where}.Z: shape {r2}x{c2}, expected {m}x{m}")
                for i in range(m * m):
                    if Fraction(f2[i], d2) != Fraction(zflat[i], zden):
                        raise Refusal(f"{where}: the dense block disagrees with B^T B at entry "
                                      f"({i // m},{i % m}): {Fraction(f2[i], d2)} against {Fraction(zflat[i], zden)}")
                note += "; the dense copy agrees with B^T B"
            if force_ldl:
                ok, why = ldl_psd(zflat, zden, m)
                if not ok:
                    raise Refusal(f"{where}: the Gram block fails the exact LDL test -- {why}")
                note += "; LDL^T re-run and clean"
        elif "Z" in blk:
            m, c, zflat, zden = parse_int_matrix(blk["Z"], f"{where}.Z")
            if m != c:
                raise Refusal(f"{where}.Z: shape {m}x{c} is not square")
            ok, why = ldl_psd(zflat, zden, m)
            if not ok:
                raise Refusal(f"{where}: the block is NOT positive semidefinite -- {why}")
            note = f"a dense {m}x{m} block, positive semidefinite by exact LDL^T (every pivot >= 0)"
        else:
            raise Refusal(f"{where}: neither a 'gram' factor nor a dense 'Z'")
        U = blk.get("U")
        if U is None:
            if m != n:
                raise Refusal(f"{where}: the block is {m}x{m} and carries no map U, but the matrix is {n}x{n}")
            uflat, uden = None, 1
        else:
            ur, uc, uflat, uden = parse_int_matrix(U, f"{where}.U")
            if ur != n or uc != m:
                raise Refusal(f"{where}.U: shape {ur}x{uc}, expected {n}x{m}")
        # accumulate U Z U^T over a common denominator
        if uflat is None:
            contrib, cden = zflat, zden
        else:
            tmp = [0] * (n * m)                       # tmp = U Z
            for i in range(n):
                urow = uflat[i * m:(i + 1) * m]
                for j in range(m):
                    s = 0
                    for l in range(m):
                        if urow[l]:
                            s += urow[l] * zflat[l * m + j]
                    tmp[i * m + j] = s
            contrib = [0] * (n * n)
            for i in range(n):
                trow = tmp[i * m:(i + 1) * m]
                for j in range(i, n):
                    urow = uflat[j * m:(j + 1) * m]
                    s = 0
                    for l in range(m):
                        if urow[l]:
                            s += trow[l] * urow[l]
                    contrib[i * n + j] = s
                    contrib[j * n + i] = s
            cden = zden * uden * uden
        g = _gcd(total_den, cden)
        lcm = total_den // g * cden
        fa, fb = lcm // total_den, lcm // cden
        total = [total[i] * fa + contrib[i] * fb for i in range(n * n)]
        total_den = lcm
        notes.append(note)
    log(f"           {name}: {len(blocks)} block(s) -- " + "; ".join(notes))
    return total, total_den


def _parse_weight_vector(obj, m, den, where):
    """A weight vector: m integer numerators over the common denominator `den`."""
    if not isinstance(obj, list) or len(obj) != m:
        raise Refusal(f"{where}: expected {m} integers (one per angle), found "
                      f"{len(obj) if isinstance(obj, list) else type(obj).__name__}")
    return [as_int(x, f"{where}[{i}]") for i, x in enumerate(obj)]


def load_circulant(obj, F, name, force_ldl, log):
    """One of the two matrices of the identity, in the CIRCULANT BLOCK form -- the only form that fits
    at p = 83, where the matrix has 6,889 rows and writing it out is out of the question.

    THE FORM.  Index the points of the plane by the origin and by the pairs (circle c, angle theta);
    a block carries three rational weight vectors -- `a` and `b` over the angles, and one number `o`
    at the origin -- and a positive semidefinite matrix `Z` over 2C + 1 slots (a cosine slot and a
    sine slot per circle, and the origin).  The block's map U is

        U[(c, theta), c]     = a[theta],   U[(c, theta), C + c] = b[theta],   U[origin, 2C] = o,

    and the block contributes U Z U^T.  The matrix of the certificate is the sum of the blocks.

    WHY THE WEIGHTS ARE NOT ON THE TRUST SURFACE.  U Z U^T is positive semidefinite for ANY rational U
    once Z is, so nothing about these weights has to be checked, or even be sensible: a wrong weight
    can only make the bound N weaker.  (The producer takes them to be rounded cosines and sines, which
    is what makes N small -- that is a fact about the producer, not a premise of this check.)

    WHAT IT RETURNS, and why it never builds the matrix.  The identity needs the matrix only through
    its sums over the orbits, and those follow from the weights' CORRELATIONS.  Over the rotation orbit
    (c, c', d) -- the m pairs (u_c zeta^t, u_c' zeta^(t+d)) -- the sum of U Z U^T is

        Z[c,c'] Aaa[d] + Z[c,C+c'] Aab[d] + Z[C+c,c'] Aba[d] + Z[C+c,C+c'] Abb[d],
        Axy[d] = sum over t of x[t] y[t+d],

    which costs m multiplications per block per ordered pair of circles instead of the n^2 the matrix
    would.  So this returns the list of those sums, one per rotation orbit, as integers over a common
    denominator."""
    blocks = need(obj, "blocks", name)
    if not isinstance(blocks, list) or not blocks:
        raise Refusal(f"{name}.blocks: expected a nonempty list")
    wden = as_frac(need(obj, "weight_den", name), f"{name}.weight_den")
    if wden <= 0 or wden.denominator != 1:
        raise Refusal(f"{name}.weight_den: expected a positive integer, found {wden}")
    wden = int(wden)
    m, C, NP, NR = F["m"], F["C"], F["NP"], F["NR"]
    W = 2 * C + 1
    parsed, notes = [], []
    zden_lcm = 1
    for i, blk in enumerate(blocks):
        where = f"{name}.blocks[{i}]"
        a = _parse_weight_vector(need(blk, "a", where), m, wden, f"{where}.a")
        b = _parse_weight_vector(need(blk, "b", where), m, wden, f"{where}.b")
        o = as_int(need(blk, "o", where), f"{where}.o")
        if "gram" in blk:
            r, mm, flat, den = parse_int_matrix(blk["gram"], f"{where}.gram")
            if mm != W:
                raise Refusal(f"{where}.gram: {mm} columns, but the plane at p = {F['p']} has "
                              f"{C} circles, so a block has {W} slots")
            zflat, zden = gram_to_dense(r, mm, flat, den)
            note = f"block {i}: a rational Gram factor of shape {r}x{W} (Z = B^T B)"
            if force_ldl:
                ok, why = ldl_psd(zflat, zden, W)
                if not ok:
                    raise Refusal(f"{where}: the Gram block fails the exact LDL test -- {why}")
                note += ", LDL^T re-run and clean"
        elif "Z" in blk:
            rr, cc, zflat, zden = parse_int_matrix(blk["Z"], f"{where}.Z")
            if rr != W or cc != W:
                raise Refusal(f"{where}.Z: shape {rr}x{cc}, expected {W}x{W}")
            ok, why = ldl_psd(zflat, zden, W)
            if not ok:
                raise Refusal(f"{where}: the block is NOT positive semidefinite -- {why}")
            note = f"block {i}: a dense {W}x{W} block, positive semidefinite by exact LDL^T"
        else:
            raise Refusal(f"{where}: neither a 'gram' factor nor a dense 'Z'")
        parsed.append((a, b, o, zflat, zden))
        zden_lcm = zden_lcm * zden // _gcd(zden_lcm, zden)
        notes.append(note)
    # one common denominator: weight_den^2 * lcm(block denominators)
    total_den = wden * wden * zden_lcm
    rot = [0] * NR
    for (a, b, o, zflat, zden) in parsed:
        scale = zden_lcm // zden
        Aaa = [0] * m
        Aab = [0] * m
        Aba = [0] * m
        Abb = [0] * m
        for d in range(m):
            saa = sab = sba = sbb = 0
            for th in range(m):
                t2 = (th + d) % m
                at, bt, a2, b2 = a[th], b[th], a[t2], b[t2]
                saa += at * a2
                sab += at * b2
                sba += bt * a2
                sbb += bt * b2
            Aaa[d], Aab[d], Aba[d], Abb[d] = saa * scale, sab * scale, sba * scale, sbb * scale
        Sa, Sb = sum(a) * scale, sum(b) * scale
        for ca in range(C):
            rowa = ca * W
            rowsa = (C + ca) * W
            off0 = ca * C * m
            for cb in range(C):
                z1 = zflat[rowa + cb]
                z2 = zflat[rowa + C + cb]
                z3 = zflat[rowsa + cb]
                z4 = zflat[rowsa + C + cb]
                if z1 == 0 and z2 == 0 and z3 == 0 and z4 == 0:
                    continue
                off = off0 + cb * m
                seg = rot[off:off + m]
                rot[off:off + m] = [x + z1 * p1 + z2 * p2 + z3 * p3 + z4 * p4
                                    for x, p1, p2, p3, p4 in zip(seg, Aaa, Aab, Aba, Abb)]
            # the origin's rows and columns
        if o:
            for ca in range(C):
                v = o * (zflat[(2 * C) * W + ca] * Sa + zflat[(2 * C) * W + C + ca] * Sb)
                rot[F["ZL"](ca)] += v
                v2 = o * (zflat[ca * W + 2 * C] * Sa + zflat[(C + ca) * W + 2 * C] * Sb)
                rot[F["ZR"](ca)] += v2
            rot[F["ZZ"]] += o * o * zflat[(2 * C) * W + 2 * C]
    log(f"           {name}: {len(blocks)} circulant block(s) over {W} slots ({C} cosine, {C} sine, "
        f"1 origin), weights over the denominator {wden}; " + "; ".join(notes[:2])
        + (f"; ... ({len(notes) - 2} more, each checked the same way)" if len(notes) > 2 else ""))
    return rot, total_den


def orbit_sums_from_rot(F, rot, den):
    """Aggregate per-rotation-orbit sums into the two per-orbit sums the identity needs:
    S[k] = the sum of the matrix over orbit k, and D[k] = its sum over the pairs whose DIFFERENCE
    lies in class k.  Every pair of a rotation orbit has its difference in one class, so both are
    plain bucketed sums."""
    K = F["K"]
    S = [0] * K
    D = [0] * K
    ro, rd = F["rot_orb"], F["rot_diff"]
    for i in range(F["NR"]):
        v = rot[i]
        if v:
            S[ro[i]] += v
            D[rd[i]] += v
    return S, D


def dense_orbit_sums(B, Z, K):
    """The same two sums, read off an assembled n-by-n matrix -- the reference path, and the control
    that `orbit_sums_from_rot` agrees with it."""
    n, orb, g_orbit, sub = B["n"], B["orb"], B["g_orbit"], B["sub"]
    S = [0] * K
    D = [0] * K
    for u in range(n):
        base = u * n
        for v in range(n):
            i = base + v
            S[orb[i]] += Z[i]
            D[g_orbit[sub[v][u]]] += Z[i]
    return S, D


def circulant_to_dense(obj, F):
    """Assemble the n-by-n matrix a circulant block form stands for.  FOR THE CONTROLS ONLY: it is
    quadratic in the number of points and exists so that a small plane can be checked both ways."""
    blocks = need(obj, "blocks", "psd")
    wden = int(as_frac(need(obj, "weight_den", "psd"), "weight_den"))
    n, m, C = F["n"], F["m"], F["C"]
    W = 2 * C + 1
    acc = [Fraction(0)] * (n * n)
    for blk in blocks:
        a = [Fraction(x, wden) for x in blk["a"]]
        b = [Fraction(x, wden) for x in blk["b"]]
        o = Fraction(blk["o"], wden)
        if "gram" in blk:
            r, mm, flat, den = parse_int_matrix(blk["gram"], "gram")
            zflat, zden = gram_to_dense(r, mm, flat, den)
        else:
            _r, mm, zflat, zden = parse_int_matrix(blk["Z"], "Z")
        Zb = [[Fraction(zflat[i * W + j], zden) for j in range(W)] for i in range(W)]
        U = [[Fraction(0)] * W for _ in range(n)]
        for ca in range(C):
            for th in range(m):
                v = F["pt"][ca][th]
                U[v][ca] = a[th]
                U[v][C + ca] = b[th]
        U[0][2 * C] = o
        for u in range(n):
            ru = U[u]
            nzu = [(k, ru[k]) for k in range(W) if ru[k]]
            if not nzu:
                continue
            tmp = [sum((val * Zb[k][j] for k, val in nzu), Fraction(0)) for j in range(W)]
            for v in range(n):
                rv = U[v]
                sv = sum((tmp[k] * rv[k] for k in range(W) if rv[k]), Fraction(0))
                if sv:
                    acc[u * n + v] += sv
    lcm = 1
    for x in acc:
        lcm = lcm * x.denominator // _gcd(lcm, x.denominator)
    return [int(x * lcm) for x in acc], lcm


# --------------------------------------------------------------------------------------------
# the check
# --------------------------------------------------------------------------------------------

KIND = "fplane-alpha-certificate"


def check(cert: dict, k: int | None = None, force_ldl: bool = False, out=sys.stdout) -> str:
    """Run every check and return the final sentence.  Raises `Refusal` at the first failure."""
    def log(s):
        print(s, file=out, flush=True)

    kind = need(cert, "kind", "certificate")
    if kind != KIND:
        raise Refusal(f"the file's kind is {kind!r}, not {KIND!r} -- this is not a certificate "
                      f"(a solver's record, {kind!r}, carries readings and proves nothing)")
    p = as_int(need(cert, "p", "certificate"), "certificate.p")
    if not is_prime(p):
        raise Refusal(f"certificate.p: {p} is not prime")
    if p % 4 != 3:
        raise Refusal(f"certificate.p: {p} is not 3 mod 4 -- the plane then has isotropic vectors "
                      f"and this checker's orbit construction has never been exercised there")
    N = as_frac(need(cert, "N", "certificate"), "certificate.N")
    alpha = as_int(need(cert, "alpha_bound", "certificate"), "certificate.alpha_bound")
    if N < 0:
        raise Refusal(f"certificate.N: {N} is negative; a bound on a cardinality is not")
    if alpha != math.floor(N):
        raise Refusal(f"certificate.alpha_bound: {alpha}, but floor(N) = {math.floor(N)}")

    # ---- 1. the group, its orbits, and the constraint system, rebuilt from p alone
    psd = need(cert, "psd", "certificate")
    z1obj = need(psd, "Z1", "certificate.psd")
    z2obj = need(psd, "Z2", "certificate.psd")
    circ = "circulant" in z1obj
    if circ != ("circulant" in z2obj):
        raise Refusal("certificate.psd: one matrix is in the circulant block form and the other is "
                      "not; both must be, or neither")
    if circ:
        B = build_orbits_fast(p)
    elif p > 29:
        raise Refusal(f"certificate.psd: at p = {p} the dense form would need a {p * p}-by-{p * p} "
                      f"matrix; use the circulant block form")
    else:
        B = build_orbits(p)
    n, K = B["n"], B["K"]
    reps = need(cert, "orbits", "certificate")
    if not isinstance(reps, list) or len(reps) != K:
        raise Refusal(f"certificate.orbits: {len(reps) if isinstance(reps, list) else '?'} entries, "
                      f"but p = {p} has {K} orbits")
    for i, r in enumerate(reps):
        if not (isinstance(r, list) and len(r) == 2):
            raise Refusal(f"certificate.orbits[{i}]: expected a pair [u, v]")
        got = (as_int(r[0], f"certificate.orbits[{i}][0]"), as_int(r[1], f"certificate.orbits[{i}][1]"))
        if got != B["rep"][i]:
            raise Refusal(f"certificate.orbits[{i}]: representative {got}, but orbit {i} of the plane "
                          f"at p = {p} is represented by {B['rep'][i]}")
    rows = canonical_constraints(B)
    fcons = need(cert, "constraints", "certificate")
    if not isinstance(fcons, list) or len(fcons) != len(rows):
        raise Refusal(f"certificate.constraints: {len(fcons) if isinstance(fcons, list) else '?'} rows, "
                      f"but the canonical system at p = {p} has {len(rows)}")
    for i, (kind_i, sense_i, coeffs_i, rhs_i) in enumerate(rows):
        f = fcons[i]
        w = f"certificate.constraints[{i}]"
        if need(f, "kind", w) != kind_i or need(f, "sense", w) != sense_i:
            raise Refusal(f"{w}: the file says ({f.get('kind')!r}, {f.get('sense')!r}); "
                          f"the canonical row {i} is ({kind_i!r}, {sense_i!r})")
        fc = need(f, "coeffs", w)
        if not isinstance(fc, dict) or len(fc) != len(coeffs_i):
            raise Refusal(f"{w}.coeffs: {len(fc) if isinstance(fc, dict) else '?'} entries, "
                          f"the canonical row has {len(coeffs_i)}")
        for key, val in fc.items():
            try:
                kk = int(key)
            except ValueError:
                raise Refusal(f"{w}.coeffs: the key {key!r} is not an orbit index")
            if kk not in coeffs_i or as_frac(val, f"{w}.coeffs[{key}]") != coeffs_i[kk]:
                raise Refusal(f"{w}.coeffs: the file has {key}: {val!r}; the canonical row {i} "
                              f"({kind_i}) has {dict((str(a), str(b)) for a, b in coeffs_i.items())}")
        if as_frac(need(f, "rhs", w), f"{w}.rhs") != rhs_i:
            raise Refusal(f"{w}.rhs: the file has {f['rhs']!r}, the canonical row has {rhs_i}")
    nk = sum(1 for k in range(K) if B["killed"][k])
    log(f"check 1/4  group and orbits rebuilt from p = {p} alone: {n} points, {K} orbits of ordered "
        f"pairs under O(2,{p}) x swap x S3, {nk} killed by a unit vector; the file's {K} "
        f"representatives agree, and the canonical constraint list ({len(rows)} rows: 1 g0, {nk} killed, "
        f"{K} nonneg, {len(rows) - 1 - nk - K} le_diag) agrees row for row")

    # ---- 2. the multipliers
    mults = need(cert, "multipliers", "certificate")
    if not isinstance(mults, list) or len(mults) != len(rows):
        raise Refusal(f"certificate.multipliers: {len(mults) if isinstance(mults, list) else '?'} entries, "
                      f"one per constraint would be {len(rows)}")
    m = [as_frac(x, f"certificate.multipliers[{i}]") for i, x in enumerate(mults)]
    nineq = 0
    for i, (kind_i, sense_i, _c, _r) in enumerate(rows):
        if sense_i == ">=":
            nineq += 1
            if m[i] < 0:
                raise Refusal(f"multiplier {i} (an inequality of kind {kind_i!r}) is negative: {m[i]}")
    log(f"check 2/4  multipliers: {len(m)} rationals, the {nineq} attached to inequalities are all >= 0, "
        f"the {len(m) - nineq} attached to equalities are free")

    # ---- 3. the positive semidefinite matrices
    log("check 3/4  positive semidefiniteness:")
    if circ:
        rot1, d1 = load_circulant(z1obj["circulant"], B, "Z1", force_ldl, log)
        rot2, d2 = load_circulant(z2obj["circulant"], B, "Z2", force_ldl, log)
        s1, _d1 = orbit_sums_from_rot(B, rot1, d1)
        s2y, s2m = orbit_sums_from_rot(B, rot2, d2)
    else:
        Z1, d1 = load_psd(z1obj, n, "Z1", force_ldl, log)
        Z2, d2 = load_psd(z2obj, n, "Z2", force_ldl, log)
        s1, _d1 = dense_orbit_sums(B, Z1, K)
        s2y, s2m = dense_orbit_sums(B, Z2, K)

    # ---- 4. the affine identity, coefficient by coefficient over the orbits
    t = B["t"]
    lhs_const = N
    rhs_const = -sum((m[i] * rows[i][3] for i in range(len(rows))), Fraction(0))
    if lhs_const != rhs_const:
        raise Refusal(f"the identity's constant term disagrees: left side {lhs_const}, right side {rhs_const}")
    for kk in range(K):
        lhs = Fraction(-t[kk])
        rhs = Fraction(s1[kk], d1) + Fraction(s2m[kk], d2) - Fraction(s2y[kk], d2)
        for i, (_kind, _sense, coeffs_i, _rhs) in enumerate(rows):
            c = coeffs_i.get(kk)
            if c is not None and m[i] != 0:
                rhs += m[i] * c
        if lhs != rhs:
            u, v = B["rep"][kk]
            raise Refusal(f"identity fails at orbit {kk}, representative pair "
                          f"({u} = ({u // p},{u % p}), {v} = ({v // p},{v % p})): "
                          f"lhs {lhs}, rhs {rhs}, difference {lhs - rhs}")
    log(f"check 4/4  the affine identity N - tr Y(y) = <Z1,Y(y)> + <Z2,M(y)-Y(y)> + sum lambda_i c_i(y) "
        f"+ sum nu_j e_j(y): all {K} orbit coefficients and the constant term agree exactly")

    tail = "" if N.denominator == 1 else f", hence at most {alpha} (a cardinality is an integer)"
    sentence = (f"CERTIFIED: every independent set of UD(F_{p}, 2) has at most {N} points{tail} "
                f"-- exact arithmetic, no solver trusted")
    log(sentence)
    if k is not None:
        if k * alpha < n:
            log(f"hence UD(F_{p}, 2) is not {k}-colourable ({k} * {alpha} = {k * alpha} < {n}); "
                f"kernel consumer: add_one_le_chromaticNumber_of_indepNum_le")
        else:
            log(f"this says nothing about {k}-colourability: {k} * {alpha} = {k * alpha} >= {n}")
    return sentence


# --------------------------------------------------------------------------------------------
# the negative controls
# --------------------------------------------------------------------------------------------


def _rank_one_blocks(n: int, idx: list, c: Fraction):
    """Present `c * sum_i E_ii` over the given indices as blocks `U_b Z_b U_b^T` with `U_b` the
    column `e_i` (an n-by-1 rational matrix, written out as rational STRINGS) and `Z_b = [[c]]`.

    It exists to exercise, at a size a human can read, the two code paths the certificates at larger
    primes will need and the one at 11 does not: a block map `U`, and a matrix given as a list of
    rationals rather than as integers over a common denominator."""
    blocks = []
    for i in idx:
        U = [["1" if r == i else "0"] for r in range(n)]
        blocks.append(dict(U=U, Z=[[str(c)]]))
    flat = [0] * (n * n)
    den = c.denominator
    for i in idx:
        flat[i * n + i] = c.numerator
    return dict(blocks=blocks), flat, den


def trivial_certificate(p: int, form: str = "gram", scale: Fraction = Fraction(0)) -> dict:
    """A COMPLETE, valid certificate built with no solver, for the controls to mutate.

    It is the rounding rule of `tools/fplane_cert_round.py` run at Z1 = scale * I, Z2 = 0: any
    rational positive semidefinite pair yields a valid certificate for SOME N, and the solver's only
    job is to make N small.  At scale = 0 this proves the true and useless bound |S| <= p^2, which is
    exactly what a control wants: a faithful certificate that must PASS, beside the planted ones that
    must fail."""
    B = build_orbits(p)
    n, K, k0 = B["n"], B["K"], B["k0"]
    rows = canonical_constraints(B)
    Z2 = [0] * (n * n)
    if form == "blocks":
        psd1, Z1, den = _rank_one_blocks(n, [0, 1, 2], scale if scale else Fraction(1, 4))
        psd2 = _block(Z2, 1, n, "dense")
    else:
        Z1 = [0] * (n * n)
        den = scale.denominator
        for i in range(n):
            Z1[i * n + i] = int(scale * den)
        psd1, psd2 = _block(Z1, den, n, form), _block(Z2, 1, n, form)
    mult, N = solve_multipliers(B, rows, Z1, den, Z2, 1)
    cert = dict(kind=KIND, p=p, N=str(N), alpha_bound=N.numerator // N.denominator,
                claim=f"every independent set of UD(F_{p}, 2) has at most {N} points",
                vertex_index="v = x*p + y for the point (x, y) of F_p^2",
                edge_rule="two points are adjacent iff their difference has quadrance x^2 + y^2 = 1 in F_p",
                symmetry="O(2,p) x swap x S3 on ordered pairs",
                orbits=[[u, v] for (u, v) in B["rep"]],
                constraints=[dict(kind=a, sense=b, coeffs={str(x): str(y) for x, y in c.items()},
                                  rhs=str(d)) for (a, b, c, d) in rows],
                multipliers=[str(x) for x in mult],
                psd=dict(Z1=psd1, Z2=psd2),
                derivation="plans/FS50-certificate-soundness.md")
    return cert


def trivial_circulant_certificate(p: int) -> dict:
    """A COMPLETE, valid certificate in the CIRCULANT BLOCK form, built with no solver.

    Three blocks with deliberately DIFFERENT weight vectors -- the constant one, the alternating one,
    and an arbitrary rational pattern -- so that a control which swaps two blocks changes the matrix
    and must be caught.  Each block's matrix is (1/4) times the identity over the slots, whose Gram
    factor (1/2) I is rational.  As always, any rational positive semidefinite pair is a valid
    certificate for SOME N; this one proves a true and useless bound, which is exactly what a control
    wants beside the planted ones."""
    F = build_orbits_fast(p)
    rows = canonical_constraints(F)
    m, C = F["m"], F["C"]
    W = 2 * C + 1
    wden = 1000
    pats = [[wden] * m,
            [wden if th % 2 == 0 else -wden for th in range(m)],
            [wden - 7 * th for th in range(m)]]
    def gram_i(i):
        """(i+1) I over the denominator 2, so block i carries ((i+1)^2/4) I -- DIFFERENT matrices, so
        that the control which swaps two blocks actually changes the sum.  With one matrix repeated a
        swap is a no-op and the plant could never fire: a control whose failure mode is unreachable
        has not been tested by passing."""
        g = [[0] * W for _ in range(W)]
        for r in range(W):
            g[r][r] = i + 1
        return dict(den="2", num=g)

    blocks = [dict(a=pat, b=[0] * m, o=wden if i == 0 else 0, gram=gram_i(i))
              for i, pat in enumerate(pats)]
    psd1 = dict(circulant=dict(weight_den=str(wden), blocks=blocks))
    zero = [dict(a=[0] * m, b=[0] * m, o=0, gram=dict(den="1", num=[[0] * W]))]
    psd2 = dict(circulant=dict(weight_den=str(wden), blocks=zero))
    quiet = lambda _s: None
    rot1, d1 = load_circulant(psd1["circulant"], F, "Z1", False, quiet)
    rot2, d2 = load_circulant(psd2["circulant"], F, "Z2", False, quiet)
    s1, _ = orbit_sums_from_rot(F, rot1, d1)
    s2y, s2m = orbit_sums_from_rot(F, rot2, d2)
    mult, N = multipliers_from_sums(F, rows, s1, d1, s2y, s2m, d2)
    return dict(kind=KIND, p=p, N=str(N), alpha_bound=N.numerator // N.denominator,
                claim=f"every independent set of UD(F_{p}, 2) has at most {N} points",
                vertex_index="v = x*p + y for the point (x, y) of F_p^2",
                edge_rule="two points are adjacent iff their difference has quadrance x^2 + y^2 = 1 in F_p",
                symmetry="O(2,p) x swap x S3 on ordered pairs",
                orbits=[[u, v] for (u, v) in F["rep"]],
                constraints=[dict(kind=a, sense=b, coeffs={str(x): str(y) for x, y in c.items()},
                                  rhs=str(d)) for (a, b, c, d) in rows],
                multipliers=[str(x) for x in mult],
                psd=dict(Z1=psd1, Z2=psd2),
                derivation="plans/FS50-certificate-soundness.md")


def _block(flat, den, n, form):
    import math as _math
    if form == "dense":
        return dict(blocks=[dict(U=None, Z=dict(den=str(den), num=[flat[i * n:(i + 1) * n] for i in range(n)]))])
    # a Gram factor of a nonnegative diagonal matrix c*I is sqrt(c)*I, which is rational only for a
    # square c; the controls use c = 0 or c = 1/4, whose factors are 0 and (1/2) I.
    rows_ = []
    for i in range(n):
        d = Fraction(flat[i * n + i], den)
        r = Fraction(_math.isqrt(d.numerator), _math.isqrt(d.denominator)) if d != 0 else Fraction(0)
        if r * r != d:
            raise ValueError("the control's diagonal is not a rational square; use form='dense'")
        rows_.append([0] * n)
        rows_[i][i] = r
    lcm = 1
    for row in rows_:
        for x in row:
            lcm = lcm * x.denominator // _gcd(lcm, x.denominator)
    return dict(blocks=[dict(U=None, gram=dict(den=str(lcm), num=[[int(x * lcm) for x in row] for row in rows_]))])


def solve_multipliers(B, rows, Z1, d1, Z2, d2):
    """Given the two matrices as DENSE flat lists, the multipliers and N.  A thin wrapper that reads
    off the orbit sums and hands them to `multipliers_from_sums`."""
    K = B["K"]
    s1, _d = dense_orbit_sums(B, Z1, K)
    s2y, s2m = dense_orbit_sums(B, Z2, K)
    return multipliers_from_sums(B, rows, s1, d1, s2y, s2m, d2)


def multipliers_from_sums(B, rows, s1, d1, s2y, s2m, d2):
    """Given the two matrices only through their orbit sums, the multipliers and N are DETERMINED --
    the rounding rule of `plans/FS50-certificate-soundness.md` section 5, shared by the producer, the
    controls, and both of the checker's paths (the dense one and the circulant one).
    Returns (multipliers in the canonical row order, N)."""
    K, k0, g_orbit, t = B["K"], B["k0"], B["g_orbit"], B["t"]
    # a_k: what the identity's coefficient at orbit k still needs from the multipliers
    a = [Fraction(-t[k]) - Fraction(s1[k], d1) - Fraction(s2m[k], d2) + Fraction(s2y[k], d2)
         for k in range(K)]
    ld = {}                      # the le_diag multiplier of each orbit that carries one
    diag_of = {}
    for k in range(K):
        if B["killed"][k] or k == k0:
            continue
        diag_of[k] = B["g_orbit"][B["rep"][k][0]]
    classes = set(g_orbit)
    for k, d in diag_of.items():
        if k not in classes:                       # a non-class orbit: its row is local
            ld[k] = max(Fraction(0), -a[k])
    T = {c: Fraction(0) for c in classes}
    for k, v in ld.items():
        T[diag_of[k]] += v
    for k in sorted(classes):                      # the class orbits other than k0
        if k == k0 or B["killed"][k]:
            continue
        ld[k] = max(Fraction(0), T[k] - a[k])
    T = {c: Fraction(0) for c in classes}
    for k, v in ld.items():
        T[diag_of[k]] += v
    N = T[k0] - a[k0]
    if N < 0:
        N = Fraction(0)
    nn = {}
    for k in range(K):
        if B["killed"][k]:
            nn[k] = Fraction(0)
            continue
        val = a[k] + ld.get(k, Fraction(0)) - T.get(k, Fraction(0)) + (N if k == k0 else 0)
        nn[k] = val
        if val < 0:
            raise ValueError(f"internal: residual {val} at orbit {k}")
    nu_killed = {k: a[k] for k in range(K) if B["killed"][k]}
    out = []
    for (kind, sense, coeffs, rhs) in rows:
        if kind == "g0":
            out.append(-N)
        elif kind == "killed":
            out.append(nu_killed[next(iter(coeffs))])
        elif kind == "nonneg":
            out.append(nn[next(iter(coeffs))])
        else:
            k = [x for x, c in coeffs.items() if c < 0][0]
            out.append(ld.get(k, Fraction(0)))
    return out, N


def brute_force_soundness(p: int, limit: int | None = None, plant_translation: bool = False) -> tuple:
    """THE control with teeth: take genuine independent sets of UD(F_p, 2), build their orbit
    variables exactly, and check that every canonical constraint holds, that tr Y = |S|, and that
    both matrices are positive semidefinite.  That is what the derivation claims and what the whole
    certificate rests on, tested rather than assumed.  Returns (sets checked, the largest seen)."""
    B = build_orbits(p, plant_translation=plant_translation)
    n, K = B["n"], B["K"]
    rows = canonical_constraints(B)
    quad, sub, orb, g_orbit, t = B["quad"], B["sub"], B["orb"], B["g_orbit"], B["t"]
    one = 1 % p
    adj = [[u != v and quad[sub[u][v]] == one for v in range(n)] for u in range(n)]
    add = [[((u // p + z // p) % p) * p + ((u % p + z % p) % p) for z in range(n)] for u in range(n)]
    sets = []

    def grow(start, cur):
        if cur:
            sets.append(list(cur))
        for w in range(start, n):
            if all(not adj[w][x] for x in cur):
                cur.append(w)
                grow(w + 1, cur)
                cur.pop()

    grow(0, [])
    population = len(sets)
    if limit is not None and len(sets) > limit:
        step = len(sets) // limit + 1
        sets = sets[::step]
    size = [0] * K
    for i in range(n * n):
        size[orb[i]] += 1
    biggest = 0
    for S in sets:
        s = len(S)
        biggest = max(biggest, s)
        Sset = set(S)
        acc = [0] * K
        for z in S:
            members = [u for u in range(n) if add[u][z] in Sset]
            for u in members:
                bu = u * n
                for v in members:
                    acc[orb[bu + v]] += 1
        y = [Fraction(acc[k], size[k] * s) for k in range(K)]
        for idx, (kind, sense, coeffs, rhs) in enumerate(rows):
            val = sum((c * y[k] for k, c in coeffs.items()), Fraction(0)) - rhs
            if (sense == ">=" and val < 0) or (sense == "==" and val != 0):
                raise Refusal(f"SOUNDNESS CONTROL FAILED: constraint {idx} ({kind}) is violated by "
                              f"the independent set {S}: value {val}")
        tr = sum((Fraction(t[k]) * y[k] for k in range(K)), Fraction(0))
        if tr != s:
            raise Refusal(f"SOUNDNESS CONTROL FAILED: tr Y = {tr} but |S| = {s} for {S}")
        lcm = 1
        for k in range(K):
            lcm = lcm * y[k].denominator // _gcd(lcm, y[k].denominator)
        Y = [int(y[orb[i]] * lcm) for i in range(n * n)]
        MY = [int((y[g_orbit[sub[i % n][i // n]]] - y[orb[i]]) * lcm) for i in range(n * n)]
        ok, why = ldl_psd(Y, lcm, n)
        if not ok:
            raise Refusal(f"SOUNDNESS CONTROL FAILED: Y is not positive semidefinite for {S}: {why}")
        ok, why = ldl_psd(MY, lcm, n)
        if not ok:
            raise Refusal(f"SOUNDNESS CONTROL FAILED: M - Y is not positive semidefinite for {S}: {why}")
    return (len(sets), population), biggest


def evaluate_at_set(cert: dict, S: list, out=sys.stdout) -> bool:
    """Evaluate the certificate's identity at a GENUINE independent set and print it term by term.

    This proves nothing the four checks do not already prove; what it does is show a reviewer the
    argument working on a real object -- the set is re-verified independent from the definition, its
    orbit variables are built from the triple counts, and every term on the right of the identity is
    displayed with its sign. The slack `N - |S|` is how far the certificate is from that set."""
    def log(s):
        print(s, file=out, flush=True)

    p = as_int(need(cert, "p", "certificate"), "certificate.p")
    B = build_orbits(p)
    n, K = B["n"], B["K"]
    rows = canonical_constraints(B)
    quad, sub, orb, g_orbit, t = B["quad"], B["sub"], B["orb"], B["g_orbit"], B["t"]
    one = 1 % p
    S = sorted(set(int(v) for v in S))
    if any(v < 0 or v >= n for v in S):
        raise Refusal(f"the set has a vertex outside 0..{n - 1}")
    bad = [(u, v) for u in S for v in S if u != v and quad[sub[u][v]] == one]
    if bad:
        raise Refusal(f"the set is NOT independent: {bad[0]} are at quadrance 1")
    log(f"           the set: {len(S)} points, re-verified independent from the definition "
        f"(no two differ by a vector of quadrance 1)")
    add = [[((u // p + z // p) % p) * p + ((u % p + z % p) % p) for z in range(n)] for u in range(n)]
    Sset, acc = set(S), [0] * K
    for z in S:
        mem = [u for u in range(n) if add[u][z] in Sset]
        for u in mem:
            bu = u * n
            for v in mem:
                acc[orb[bu + v]] += 1
    size = [0] * K
    for i in range(n * n):
        size[orb[i]] += 1
    y = [Fraction(acc[k], size[k] * len(S)) for k in range(K)]
    tr = sum((Fraction(t[k]) * y[k] for k in range(K)), Fraction(0))
    if tr != len(S):
        raise Refusal(f"trace Y = {tr} but the set has {len(S)} points")
    Z1, d1 = load_psd(need(need(cert, "psd", "certificate"), "Z1", "certificate.psd"), n, "Z1", False, lambda _s: None)
    Z2, d2 = load_psd(need(need(cert, "psd", "certificate"), "Z2", "certificate.psd"), n, "Z2", False, lambda _s: None)
    m = [as_frac(x, "multiplier") for x in need(cert, "multipliers", "certificate")]
    N = as_frac(need(cert, "N", "certificate"), "certificate.N")
    Yv = [y[orb[i]] for i in range(n * n)]
    Mv = [y[g_orbit[sub[i % n][i // n]]] for i in range(n * n)]
    t1 = sum((Fraction(Z1[i], d1) * Yv[i] for i in range(n * n)), Fraction(0))
    t2 = sum((Fraction(Z2[i], d2) * (Mv[i] - Yv[i]) for i in range(n * n)), Fraction(0))
    t3 = t4 = Fraction(0)
    for i, (_kind, sense, co, rhs) in enumerate(rows):
        val = sum((c * y[k] for k, c in co.items()), Fraction(0)) - rhs
        if sense == ">=":
            t3 += m[i] * val
        else:
            t4 += m[i] * val
    log(f"           trace Y(y) = {tr} = the number of points, as the derivation's P7 says")
    log(f"           <Z1, Y>          = {float(t1): .9f}   (nonnegative: two positive semidefinite matrices)")
    log(f"           <Z2, M - Y>      = {float(t2): .9f}   (nonnegative: likewise)")
    log(f"           sum lambda * c   = {float(t3): .9f}   (nonnegative: lambda >= 0 and c >= 0 here)")
    log(f"           sum nu * e       = {float(t4): .9f}   (exactly zero: the equations hold here)")
    lhs = N - tr
    ok = (t1 >= 0 and t2 >= 0 and t3 >= 0 and t4 == 0 and lhs == t1 + t2 + t3 + t4)
    log(f"           N - |S|          = {float(lhs): .9f}   = the four terms summed"
        f"{'' if ok else '   *** MISMATCH ***'}")
    if not ok:
        raise Refusal("the identity does not hold at this set, or a term is negative")
    return True


def _mutate(cert: dict) -> dict:
    return json.loads(json.dumps(cert))


def self_test(out=sys.stdout, shipped: str | None = None) -> bool:
    """Break the checker on purpose and watch it refuse, naming the site.

    `CLAUDE.md` "Make the gate fail, and watch it fail": a check is not known to work until it has
    been seen to fail, and a control whose failure mode is unreachable has not been tested by
    passing.  So every plant below is PAIRED with the faithful certificate it was made from, which
    must still be accepted, and the faithful one is re-run at the end to confirm the mutations left
    nothing behind.

    The plants: an altered matrix coefficient (the identity must fail, naming the orbit); a flipped
    pivot (the positive-semidefinite test must fail, naming the block and the pivot); a negated
    multiplier; a certificate whose `p` is another plane's; a float where a rational belongs; and a
    file whose `kind` is the semidefinite solver's record rather than a certificate.  Beside them,
    two controls that are not about the file at all: the constraint system checked against GENUINE
    independent sets of the plane (the derivation's claim, tested), and the same control under a
    planted symmetry that is not one -- which must go red, or the control proves nothing."""
    def log(s):
        print(s, file=out, flush=True)

    quiet = open("/dev/null", "w")
    failures = []

    def expect_refusal(name, cert, fragment, k=None):
        try:
            check(cert, k=k, out=quiet)
        except Refusal as e:
            msg = str(e).replace("\n", " ")
            if fragment.lower() in msg.lower():
                log(f"  RED (as designed)  {name}\n                     -> {msg[:190]}")
                return
            failures.append(f"{name}: refused, but for the wrong reason: {msg}")
            log(f"  RED, WRONG REASON  {name} -> {msg[:190]}")
            return
        except Exception as e:                      # noqa: BLE001 -- any other exception is a defect
            failures.append(f"{name}: raised {type(e).__name__} instead of refusing: {e}")
            log(f"  BROKE              {name} -> {type(e).__name__}: {e}")
            return
        failures.append(f"{name}: ACCEPTED a planted fault")
        log(f"  GREEN — NOT OK     {name} accepted a planted fault")

    def expect_pass(name, cert, k=None):
        try:
            s = check(cert, k=k, out=quiet)
            log(f"  GREEN (as designed) {name}\n                      -> {s[:170]}")
        except Exception as e:                      # noqa: BLE001
            failures.append(f"{name}: the faithful certificate was refused: {e}")
            log(f"  RED — NOT OK        {name} -> {e}")

    log("=== the constraint system against genuine independent sets (the derivation, tested) ===")
    for p in (3, 7):
        (cnt, pop), big = brute_force_soundness(p, limit=None if p == 3 else 120)
        log(f"  p = {p}: {cnt} of the plane's {pop} independent sets, the largest checked {big} points; every canonical constraint "
            f"holds at each, tr Y = |S| at each, and Y and M - Y are positive semidefinite at each")
    log("  planted: a map that is NOT a symmetry of the triple counts added to the group "
        "(the translation (u,v) -> (u+1,v+1)), which merges orbits that are not equal")
    try:
        brute_force_soundness(3, plant_translation=True)
        failures.append("the planted non-symmetry left every constraint satisfied: "
                        "the soundness control cannot detect a coarsened orbit map")
        log("  GREEN — NOT OK      the planted non-symmetry was not detected")
    except Refusal as e:
        log(f"  RED (as designed)   -> {str(e)[:190]}")

    log("=== the faithful certificates, which must pass ===")
    gram7 = trivial_certificate(7, form="gram", scale=Fraction(1, 4))
    dense7 = trivial_certificate(7, form="dense", scale=Fraction(1, 4))
    gram3 = trivial_certificate(3, form="gram")
    expect_pass("p = 7, Gram form, Z1 = I/4", gram7)
    expect_pass("p = 7, dense form (the exact LDL path)", dense7)
    expect_pass("p = 3, Gram form, Z1 = 0", gram3)
    blocks7 = trivial_certificate(7, form="blocks", scale=Fraction(1, 3))
    expect_pass("p = 7, three rank-one blocks U Z U^T with U written as rationals "
                "(the path 23 and 83 will use)", blocks7)

    log("=== the scalable orbit construction against the reference one (p = 3, 7, 11, 19, 23) ===")
    for q in (3, 7, 11, 19, 23):
        Bs, Fs = build_orbits(q), build_orbits_fast(q)
        agree = (Bs["K"] == Fs["K"] and Bs["rep"] == Fs["rep"] and Bs["killed"] == Fs["killed"]
                 and Bs["g_orbit"] == Fs["g_orbit"] and Bs["t"] == Fs["t"] and Bs["k0"] == Fs["k0"])
        maps = True
        nfast = Bs["n"]
        for ca in range(Fs["C"]):
            for cb in range(Fs["C"]):
                for d in range(Fs["m"]):
                    u, v = Fs["pt"][ca][0], Fs["pt"][cb][d]
                    i = Fs["nz"](ca, cb, d)
                    if Fs["rot_orb"][i] != Bs["orb"][u * nfast + v]:
                        maps = False
                    if Fs["rot_diff"][i] != Bs["g_orbit"][Bs["sub"][v][u]]:
                        maps = False
        for ca in range(Fs["C"]):
            if Fs["rot_orb"][Fs["ZL"](ca)] != Bs["orb"][Fs["pt"][ca][0]]:
                maps = False
            if Fs["rot_orb"][Fs["ZR"](ca)] != Bs["orb"][Fs["pt"][ca][0] * nfast]:
                maps = False
        if Fs["rot_orb"][Fs["ZZ"]] != Bs["orb"][0]:
            maps = False
        if agree and maps:
            log(f"  GREEN (as designed) p = {q}: {Bs['K']} orbits, every representative, every killed "
                f"flag, every class and trace weight, and the orbit and difference class of every "
                f"rotation orbit, identical to the n^2 construction")
        else:
            failures.append(f"build_orbits_fast disagrees with build_orbits at p = {q} "
                            f"(derived arrays {agree}, rotation-orbit maps {maps})")
            log(f"  RED — NOT OK        p = {q}: the scalable construction disagrees with the reference")

    log("=== the circulant block form: the same matrix read two ways ===")
    circ7 = trivial_circulant_certificate(7)
    expect_pass("p = 7, circulant block form (the path 83 uses)", circ7)
    F7, R7 = build_orbits_fast(7), build_orbits(7)
    both = True
    for nm in ("Z1", "Z2"):
        ob = circ7["psd"][nm]["circulant"]
        rot, den = load_circulant(ob, F7, nm, False, lambda _s: None)
        Sf, Df = orbit_sums_from_rot(F7, rot, den)
        Zd, dd = circulant_to_dense(ob, F7)
        Sd, Dd = dense_orbit_sums(R7, Zd, R7["K"])
        if any(Fraction(Sf[k], den) != Fraction(Sd[k], dd) for k in range(R7["K"])):
            both = False
        if any(Fraction(Df[k], den) != Fraction(Dd[k], dd) for k in range(R7["K"])):
            both = False
        ok, why = ldl_psd(Zd, dd, F7["n"])
        if not ok:
            both = False
    if both:
        log("  GREEN (as designed) the orbit sums the checker reads off the weights' correlations equal "
            "those read off the assembled 49-by-49 matrix, for both matrices and for the difference "
            "sums too; and the assembled matrix is positive semidefinite by an exact LDL^T that the "
            "circulant path never performs")
    else:
        failures.append("the circulant path and the assembled matrix disagree")
        log("  RED — NOT OK        the circulant path and the assembled matrix disagree")

    log("=== the planted faults on the synthetic certificates, each refused by name ===")
    c = _mutate(gram7)
    c["psd"]["Z1"]["blocks"][0]["gram"]["num"][0][1] += 1
    expect_refusal("1. one matrix coefficient altered", c, "identity fails at orbit")

    c = _mutate(dense7)
    c["psd"]["Z1"]["blocks"][0]["Z"]["num"][3][3] = -c["psd"]["Z1"]["blocks"][0]["Z"]["num"][3][3] - 1
    expect_refusal("2. one positive-semidefinite pivot flipped", c, "pivot 3 is negative")

    c = _mutate(gram7)
    idx = next(i for i, x in enumerate(c["multipliers"]) if Fraction(x) > 0)
    c["multipliers"][idx] = str(-Fraction(c["multipliers"][idx]))
    expect_refusal("3. one multiplier negated", c, f"multiplier {idx}")

    c = _mutate(gram7)
    c["p"] = 11
    expect_refusal("4. a certificate for a foreign p (the data is p = 7, the field says 11)", c, "orbits")

    c = _mutate(gram7)
    c["multipliers"][idx] = 0.5
    expect_refusal("5. a float where a rational belongs", c, "found the float")

    c = _mutate(dense7)
    c["psd"]["Z1"]["blocks"][0]["Z"]["num"][2][5] += 7      # one side only
    expect_refusal("2b. a dense block made asymmetric on one side", c, "not symmetric")

    c = _mutate(blocks7)
    c["psd"]["Z1"]["blocks"][1]["Z"][0][0] = "-1/3"
    expect_refusal("6b. a rank-one block made negative", c, "pivot 0 is negative")

    c = _mutate(gram7)
    c["kind"] = "fplane-sdp"
    expect_refusal("6. the semidefinite solver's record handed to the checker", c, "is not a certificate")

    log("--- and the same on the circulant block form, whose failure modes are its own ---")
    c = _mutate(circ7)
    c["psd"]["Z1"]["circulant"]["blocks"][1]["gram"]["num"][2][2] += 1
    expect_refusal("12. one coefficient of a block's Gram factor altered", c, "identity fails at orbit")
    c = _mutate(circ7)
    c["psd"]["Z1"]["circulant"]["blocks"][0]["a"][3] += 1
    expect_refusal("13. one Fourier weight altered", c, "identity fails at orbit")
    c = _mutate(circ7)
    bl = c["psd"]["Z1"]["circulant"]["blocks"]
    for fld in ("a", "b", "o"):                      # the WEIGHTS swapped, the matrices left in place
        bl[0][fld], bl[2][fld] = bl[2][fld], bl[0][fld]
    # (swapping the whole block dictionaries is a no-op -- the sum over blocks does not know their
    # order -- so the plant has to separate a block's weights from its matrix, or it cannot fire.)
    expect_refusal("14. two blocks' weights swapped, their matrices left in place", c,
                   "identity fails at orbit")
    c = _mutate(circ7)
    W7 = 2 * F7["C"] + 1
    dense = [[0] * W7 for _ in range(W7)]
    for i in range(W7):
        dense[i][i] = 1
    dense[2][2] = -1
    c["psd"]["Z1"]["circulant"]["blocks"][1] = dict(
        a=c["psd"]["Z1"]["circulant"]["blocks"][1]["a"],
        b=c["psd"]["Z1"]["circulant"]["blocks"][1]["b"],
        o=c["psd"]["Z1"]["circulant"]["blocks"][1]["o"],
        Z=dict(den="4", num=dense))
    expect_refusal("15. a block given densely with one negative pivot", c, "pivot 2 is negative")
    c = _mutate(circ7)
    c["psd"]["Z1"]["circulant"]["blocks"][0]["a"][1] = 0.5
    expect_refusal("16. a float where a weight belongs", c, "found float")
    c = _mutate(circ7)
    c["psd"]["Z1"]["circulant"]["blocks"][0]["a"].pop()
    expect_refusal("17. a weight vector of the wrong length", c, "expected 8 integers")
    c = _mutate(circ7)
    c["psd"]["Z1"]["circulant"]["blocks"][0]["gram"]["num"] = [[1] * (W7 - 1)]
    expect_refusal("18. a block whose matrix has the wrong number of slots", c, "slots")
    c = _mutate(circ7)
    c["p"] = 11
    expect_refusal("19. a circulant certificate for a foreign p", c, "orbits")
    c = _mutate(circ7)
    c["psd"]["Z2"] = dict(blocks=[dict(U=None, gram=dict(den="1", num=[[0] * 49]))])
    expect_refusal("20. one matrix in the circulant form and the other not", c,
                   "one matrix is in the circulant block form")

    if shipped:
        log(f"=== the same plants on the SHIPPED certificate {shipped} ===")
        with open(shipped) as fh:
            real = json.load(fh)
        expect_pass("the shipped certificate, unaltered", real)
        c = _mutate(real)
        blk = c["psd"]["Z1"]["blocks"][0]
        key = "gram" if "gram" in blk else "Z"
        blk[key]["num"][0][0] += 1
        expect_refusal("7. one matrix coefficient altered", c, "identity fails at orbit")
        c = _mutate(real)
        c["N"] = str(Fraction(c["N"]) - 1)
        c["alpha_bound"] -= 1
        expect_refusal("8. the claim strengthened by one, the proof left alone", c, "constant term")
        c = _mutate(real)
        c["constraints"][0]["rhs"] = "2"
        expect_refusal("9. a constraint row rewritten in the file", c, "constraints[0]")
        c = _mutate(real)
        c["orbits"][17] = [0, 0]
        expect_refusal("10. an orbit representative rewritten in the file", c, "orbits[17]")

    log("=== the identity at a real independent set, and at a set that is not one ===")
    B7 = build_orbits(7)
    S7 = []                                             # a greedy independent set, computed not recalled
    for v in range(B7["n"]):
        if all(B7["quad"][B7["sub"][v][w]] != 1 for w in S7):
            S7.append(v)
    try:
        evaluate_at_set(gram7, S7, out=quiet)
        log(f"  GREEN (as designed) the identity holds term by term at the {len(S7)}-point set {S7} of UD(F_7, 2)")
    except Refusal as e:
        failures.append(f"the identity at a genuine independent set: {e}")
        log(f"  RED — NOT OK        {e}")
    nbr = next(v for v in range(B7["n"]) if B7["quad"][B7["sub"][v][0]] == 1)
    try:
        evaluate_at_set(gram7, [0, nbr], out=quiet)
        failures.append("a set with an adjacent pair was accepted by --against")
        log("  GREEN — NOT OK      a set with an adjacent pair was accepted")
    except Refusal as e:
        log(f"  RED (as designed)  11. a set with an adjacent pair handed to --against\n"
            f"                     -> {str(e)[:150]}")

    log("=== after every mutation, the faithful certificates again (the restore, verified) ===")
    expect_pass("p = 7, Gram form", trivial_certificate(7, form="gram", scale=Fraction(1, 4)))
    expect_pass("p = 7, dense form", trivial_certificate(7, form="dense", scale=Fraction(1, 4)))
    expect_pass("p = 7, circulant block form", trivial_circulant_certificate(7))

    quiet.close()
    if failures:
        log("")
        log(f"SELF-TEST FAILED: {len(failures)} control(s) did not behave as designed")
        for f in failures:
            log(f"  - {f}")
        return False
    log("")
    log("SELF-TEST PASSED: every faithful certificate accepted, every planted fault refused by "
        "name, the derivation's constraint system verified against every independent set of UD(F_3, 2) "
        "and an even sample of those of UD(F_7, 2), and a planted non-symmetry caught by that control")
    return True


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("certificate", nargs="?", help="the certificate file to check")
    ap.add_argument("--k", type=int, help="also say whether the bound refutes a k-colouring")
    ap.add_argument("--ldl", action="store_true",
                    help="also run the exact LDL^T on blocks given by a Gram factor (redundant, slow)")
    ap.add_argument("--against", metavar="SETFILE",
                    help="also evaluate the identity at a verified independent set (a JSON record "
                         "carrying `independent_set` or `best_set`), term by term")
    ap.add_argument("--self-test", action="store_true",
                    help="plant faults and watch each one refuse; with a certificate given as well, "
                         "plant them in THAT file too")
    a = ap.parse_args()
    if a.self_test:
        return 0 if self_test(shipped=a.certificate) else 1
    if not a.certificate:
        ap.error("give a certificate file, or --self-test")
    print(f"[cert] file: {a.certificate}", flush=True)
    try:
        with open(a.certificate) as fh:
            cert = json.load(fh)
    except json.JSONDecodeError as e:
        print(f"NOT A CERTIFICATE: {a.certificate} is not valid JSON ({e})")
        return 1
    if not isinstance(cert, dict):
        print("NOT A CERTIFICATE: the file's top level is not an object")
        return 1
    print(f"[cert] kind {cert.get('kind')!r}, p = {cert.get('p')}, N = {cert.get('N')!r}, "
          f"alpha_bound = {cert.get('alpha_bound')}", flush=True)
    if cert.get("derivation"):
        print(f"[cert] the derivation it points at: {cert['derivation']}", flush=True)
    try:
        check(cert, k=a.k, force_ldl=a.ldl)
        if a.against:
            with open(a.against) as fh:
                rec = json.load(fh)
            S = rec.get("independent_set") or rec.get("best_set")
            if S is None:
                print(f"NOT A CERTIFICATE: {a.against} carries no `independent_set` or `best_set`")
                return 1
            print(f"the identity at the verified set in {a.against}:")
            evaluate_at_set(cert, S)
    except Refusal as e:
        print(f"NOT A CERTIFICATE: {e}")
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())

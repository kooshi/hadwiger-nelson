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
    psd = need(cert, "psd", "certificate")
    log("check 3/4  positive semidefiniteness:")
    Z1, d1 = load_psd(need(psd, "Z1", "certificate.psd"), n, "Z1", force_ldl, log)
    Z2, d2 = load_psd(need(psd, "Z2", "certificate.psd"), n, "Z2", force_ldl, log)

    # ---- 4. the affine identity, coefficient by coefficient over the orbits
    orb, g_orbit, sub, t = B["orb"], B["g_orbit"], B["sub"], B["t"]
    s1 = [0] * K              # <Z1, Y(y)>  : sum of Z1 over each orbit
    s2y = [0] * K             # <Z2, Y(y)>
    s2m = [0] * K             # <Z2, M(y)>  : M[u,v] = y[orbit of (0, v-u)]
    for u in range(n):
        base = u * n
        for v in range(n):
            i = base + v
            s1[orb[i]] += Z1[i]
            s2y[orb[i]] += Z2[i]
            s2m[g_orbit[sub[v][u]]] += Z2[i]
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
    """Given the two matrices, the multipliers and N are DETERMINED -- the rounding rule of
    `plans/FS50-certificate-soundness.md` section 5, shared by the producer and by the controls.
    Returns (multipliers in the canonical row order, N)."""
    n, K, k0, orb, g_orbit, sub, t = (B["n"], B["K"], B["k0"], B["orb"], B["g_orbit"], B["sub"], B["t"])
    s1 = [0] * K
    s2y = [0] * K
    s2m = [0] * K
    for u in range(n):
        base = u * n
        for v in range(n):
            i = base + v
            s1[orb[i]] += Z1[i]
            s2y[orb[i]] += Z2[i]
            s2m[g_orbit[sub[v][u]]] += Z2[i]
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

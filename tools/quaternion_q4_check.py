#!/usr/bin/env python3
"""Exact-arithmetic sanity check: is chi(Q^4) = 4 an instance of Theorem A?

Theorem A (`colorable_of_residue`, ResidueColouring.lean:235) needs, for a graph drawn by
`f : V -> M` into an abelian group M:

    A : AddSubgroup M          psi : A ->+ G (G finite abelian)
    every edge difference lies in A
    every edge difference has nonzero residue

Claim under test, for the unit-distance graph on Q^4 = H (x) Q (rational quaternions):

    M = (Q^4, +)
    A = H_(2), the Hurwitz order localized away from 2 (odd denominators)
    G = H/P ~ F_4, P = (1+i)H the unique prime above 2, |G| = 4
    psi = reduction mod P

  (H1) every rational quaternion of norm 1 lies in A
  (H2) every rational quaternion of norm 1 has nonzero residue
  (H3) psi is well defined and additive on A, and |G| = 4
  (LB) four rational points pairwise at distance 1 exist  -> chi >= 4

Everything is exact (integers / fractions).  Controls at the end, including the planted
fault a person would actually make: run the same argument over the LIPSCHITZ order.
"""

from fractions import Fraction as F
from itertools import product
import math

# --------------------------------------------------------------------------- quaternions
# standard basis (1, i, j, k); coordinates are Fractions or ints


def qmul(x, y):
    a1, b1, c1, d1 = x
    a2, b2, c2, d2 = y
    return (
        a1 * a2 - b1 * b2 - c1 * c2 - d1 * d2,
        a1 * b2 + b1 * a2 + c1 * d2 - d1 * c2,
        a1 * c2 - b1 * d2 + c1 * a2 + d1 * b2,
        a1 * d2 + b1 * c2 - c1 * b2 + d1 * a2,
    )


def qconj(x):
    return (x[0], -x[1], -x[2], -x[3])


def qnorm(x):
    return x[0] * x[0] + x[1] * x[1] + x[2] * x[2] + x[3] * x[3]


def qsub(x, y):
    return tuple(a - b for a, b in zip(x, y))


ONE = (F(1), F(0), F(0), F(0))
I = (F(0), F(1), F(0), F(0))
J = (F(0), F(0), F(1), F(0))
K = (F(0), F(0), F(0), F(1))
OMEGA = (F(1, 2), F(1, 2), F(1, 2), F(1, 2))

# --------------------------------------------------------------------- Hurwitz coordinates
# q = a*1 + b*i + c*j + d*omega   with omega = (1+i+j+k)/2
#   q0 = a + d/2, q1 = b + d/2, q2 = c + d/2, q3 = d/2


def hcoords(q):
    d = 2 * q[3]
    return (q[0] - q[3], q[1] - q[3], q[2] - q[3], d)


def from_h(v):
    a, b, c, d = (F(t) for t in v)
    return (a + d / 2, b + d / 2, c + d / 2, d / 2)


def is_integral_vec(v):
    return all(F(t).denominator == 1 for t in v)


HBASIS = [ONE, I, J, OMEGA]

# ------------------------------------------------------------------ integer linear algebra


def mat_det4(M):
    # exact Laplace expansion, integers
    def det(m):
        n = len(m)
        if n == 1:
            return m[0][0]
        s = 0
        for c in range(n):
            minor = [row[:c] + row[c + 1 :] for row in m[1:]]
            s += ((-1) ** c) * m[0][c] * det(minor)
        return s

    return det([list(r) for r in M])


def mat_inv4(M):
    """exact inverse of a 4x4 integer matrix, entries Fraction"""
    n = 4
    A = [[F(M[r][c]) for c in range(n)] + [F(1 if r == c else 0) for c in range(n)] for r in range(n)]
    for col in range(n):
        piv = next(r for r in range(col, n) if A[r][col] != 0)
        A[col], A[piv] = A[piv], A[col]
        pv = A[col][col]
        A[col] = [x / pv for x in A[col]]
        for r in range(n):
            if r != col and A[r][col] != 0:
                f = A[r][col]
                A[r] = [x - f * y for x, y in zip(A[r], A[col])]
    return [row[n:] for row in A]


def vec_mat(v, M):
    return tuple(sum(F(v[i]) * F(M[i][c]) for i in range(4)) for c in range(4))


# =========================================================================== the checks

fails = []
notes = []


def check(name, ok, detail=""):
    print(f"  [{'PASS' if ok else 'FAIL'}] {name}" + (f"  -- {detail}" if detail else ""))
    if not ok:
        fails.append(name)


print("=" * 78)
print("STEP 0  quaternion arithmetic and the Hurwitz coordinate change")
print("=" * 78)

check("omega is a unit", qnorm(OMEGA) == 1)
check(
    "coordinate round-trip",
    all(hcoords(from_h(v)) == tuple(F(t) for t in v) for v in product(range(-3, 4), repeat=4)),
)
check(
    "H is closed under multiplication",
    all(
        is_integral_vec(hcoords(qmul(from_h(u), from_h(v))))
        for u in product(range(-2, 3), repeat=4)
        for v in product(range(-2, 3), repeat=4)
    ),
)

# the 24 units of H
units = []
for v in product(range(-2, 3), repeat=4):
    q = from_h(v)
    if qnorm(q) == 1:
        units.append(q)
check("H has exactly 24 units (the 24-cell)", len(units) == 24, f"found {len(units)}")

print()
print("=" * 78)
print("STEP 1  the prime above 2:  P = (1+i)H,  index 4, quotient (Z/2)^2 ~ F_4")
print("=" * 78)

one_plus_i = qmul(ONE, ONE)  # placeholder
one_plus_i = tuple(a + b for a, b in zip(ONE, I))
check("N(1+i) = 2", qnorm(one_plus_i) == 2)

Mrows_left = [hcoords(qmul(one_plus_i, b)) for b in HBASIS]  # (1+i)*H
Mrows_right = [hcoords(qmul(b, one_plus_i)) for b in HBASIS]  # H*(1+i)
M = [[int(x) for x in row] for row in Mrows_left]
Mr = [[int(x) for x in row] for row in Mrows_right]

det = mat_det4(M)
check("[H : P] = 4", abs(det) == 4, f"det = {det}")

Minv = mat_inv4(M)


def in_lattice(v):
    """is the integer Hurwitz-coordinate vector v in P?"""
    return all(x.denominator == 1 for x in vec_mat(v, Minv))


check("P is two-sided (H(1+i) = (1+i)H)", all(in_lattice(r) for r in Mr) and abs(mat_det4(Mr)) == 4)
check("2H subset P  (so the quotient has exponent 2)", all(in_lattice([2 * (i == c) for i in range(4)]) for c in range(4)))


def psi_int(v):
    """residue of an integral Hurwitz-coordinate vector, as a tuple in (Q/Z)^4"""
    return tuple(x - math.floor(x) for x in vec_mat(v, Minv))


ZERO_RES = psi_int([0, 0, 0, 0])
res_values = {psi_int(v) for v in product(range(-4, 5), repeat=4)}
check("psi takes exactly 4 values on H", len(res_values) == 4, f"{sorted(map(str, res_values))}")
check(
    "psi is additive (sampled, 10^4 pairs)",
    all(
        psi_int([a + b for a, b in zip(u, v)])
        == tuple((x + y) % 1 for x, y in zip(psi_int(u), psi_int(v)))
        for u in product(range(-2, 3), repeat=4)
        for v in product(range(-1, 2), repeat=4)
    ),
)
check("psi(v) = 0 iff v in P", all((psi_int(v) == ZERO_RES) == in_lattice(v) for v in product(range(-4, 5), repeat=4)))

print()
print("=" * 78)
print("STEP 2  the arithmetic lemma:  N(a) odd  <=>  a is a unit mod P")
print("=" * 78)

box = list(product(range(-6, 7), repeat=4))
bad = [v for v in box if ((qnorm(from_h(v)) % 2 == 1) != (psi_int(v) != ZERO_RES))]
check(f"N odd <=> psi nonzero, over {len(box)} elements of H", not bad, f"{len(bad)} counterexamples")

bad4 = [v for v in box if qnorm(from_h(v)) % 4 == 0 and not all(int(x) % 2 == 0 for x in v)]
check(f"N(a) = 0 mod 4  =>  a in 2H, over {len(box)} elements", not bad4, f"{len(bad4)} counterexamples")

print()
print("=" * 78)
print("STEP 3  (H1)  every rational quaternion of norm 1 has ODD denominator over H")
print("=" * 78)

# exhaustive: q with N(q) = m^2, q in H, for m = 1..8; a rational unit quaternion in lowest
# terms is q/m with q in H primitive.  Claim: m even forces q in 2H (so it was not lowest terms).
print("  enumerating all q in H with N(q) = m^2 (half-integer coordinates, |coord| <= m):")
for m in range(1, 9):
    sols = []
    rng = [F(t, 2) for t in range(-2 * m, 2 * m + 1)]
    for q in product(rng, repeat=4):
        if qnorm(q) != m * m:
            continue
        v = hcoords(q)
        if not is_integral_vec(v):
            continue
        sols.append(tuple(int(x) for x in v))
    prim = [v for v in sols if not all(x % 2 == 0 for x in v)]
    ok = (m % 2 == 1) or (len(prim) == 0)
    print(
        f"    m = {m:>2}: {len(sols):>5} solutions, {len(prim):>5} not in 2H"
        f"   {'(m odd)' if m % 2 else '(m EVEN -> must be 0)'}  {'ok' if ok else 'FAIL'}"
    )
    if not ok:
        fails.append(f"H1 at m={m}")
check("no rational unit quaternion has even denominator over H (m <= 8)", not [f for f in fails if f.startswith("H1")])

print()
print("=" * 78)
print("STEP 4  (H2)  every rational unit quaternion has nonzero residue")
print("=" * 78)


def psi_rational(q):
    """residue of a rational quaternion with odd Hurwitz denominator.
    Well defined because 2H is inside P, so psi(k*a) = psi(a) for odd k."""
    v = hcoords(q)
    den = 1
    for x in v:
        den = den * F(x).denominator // math.gcd(den, F(x).denominator)
    if den % 2 == 0:
        return None  # not in A
    return psi_int([int(F(x) * den) for x in v])


# a generous supply of rational unit quaternions: a*conj(b)/n with N(a) = N(b) = n
by_norm = {}
for v in product(range(-4, 5), repeat=4):
    q = from_h(v)
    by_norm.setdefault(int(qnorm(q)), []).append(q)

sample = []
for n, qs in sorted(by_norm.items()):
    if n == 0 or n > 60:
        continue
    for a in qs[:14]:
        for b in qs[:14]:
            u = tuple(F(x, n) for x in qmul(a, qconj(b)))
            if qnorm(u) == 1:
                sample.append(u)
sample = list(dict.fromkeys(sample))
dens = sorted({max(F(x).denominator for x in u) for u in sample})
print(f"  {len(sample)} distinct rational unit quaternions, denominators seen: {dens[:14]}{' ...' if len(dens) > 14 else ''}")

check("all have norm exactly 1", all(qnorm(u) == 1 for u in sample))
check("all lie in A (odd denominator)", all(psi_rational(u) is not None for u in sample))
check("all have nonzero residue", all(psi_rational(u) != ZERO_RES for u in sample if psi_rational(u) is not None))
check(
    "psi independent of the odd clearing factor",
    all(psi_rational(u) == psi_int([int(F(x) * k) for x in hcoords(u)])
        for u in sample[:300]
        for k in (1, 3, 5, 9, 15)
        if all((F(x) * k).denominator == 1 for x in hcoords(u))),
)

print()
print("=" * 78)
print("STEP 5  (LB)  a unit-edge tetrahedron with rational coordinates")
print("=" * 78)

tet = [
    (F(0), F(0), F(0), F(0)),
    (F(1), F(0), F(0), F(0)),
    (F(1, 2), F(1, 2), F(1, 2), F(1, 2)),
    (F(1, 2), F(1, 2), F(1, 2), F(-1, 2)),
]
dists = [(p, q, qnorm(qsub(tet[p], tet[q]))) for p in range(4) for q in range(p + 1, 4)]
for p, q, d2 in dists:
    print(f"    |p{p} - p{q}|^2 = {d2}")
check("all six squared distances are exactly 1", all(d2 == 1 for _, _, d2 in dists))
check("the four points are rational", all(all(isinstance(x, F) for x in p) for p in tet))
check("its four residues are pairwise distinct (the colouring uses all 4)",
      len({psi_rational(qsub(p, tet[0])) for p in tet}) == 4)

print()
print("=" * 78)
print("STEP 6  closing the gaps in the checks above")
print("=" * 78)

# (a) psi must be a homomorphism on A itself, not merely on H.
pairs = [(sample[i], sample[(3 * i + 7) % len(sample)]) for i in range(2000)]
addok = True
for u, v in pairs:
    s = tuple(a + b for a, b in zip(u, v))
    pu, pv, ps = psi_rational(u), psi_rational(v), psi_rational(s)
    if ps is None or ps != tuple((x + y) % 1 for x, y in zip(pu, pv)):
        addok = False
        break
check("(a) psi is additive on A (2000 pairs of rational unit quaternions)", addok)

# (b) cross the two independent families: the EXHAUSTIVE list of step 3 must also pass (H2).
#     step 4's sample came from a generator (a*conj(b)/n); step 3's came from solving N(q) = m^2.
exhaustive = []
for m in range(1, 8, 2):
    rng = [F(t, 2) for t in range(-2 * m, 2 * m + 1)]
    for q in product(rng, repeat=4):
        if qnorm(q) == m * m and is_integral_vec(hcoords(q)):
            exhaustive.append(tuple(F(x, m) for x in q))
check(f"(b) the exhaustive family ({len(exhaustive)} unit quaternions, m <= 7) lies in A",
      all(psi_rational(u) is not None for u in exhaustive))
check("(b) the exhaustive family all has nonzero residue",
      all(psi_rational(u) != ZERO_RES for u in exhaustive))
gen_set, exh_set = set(sample), set(exhaustive)
print(f"    the two families overlap in {len(gen_set & exh_set)} elements; "
      f"generator-only {len(gen_set - exh_set)}, exhaustive-only {len(exh_set - gen_set)}")

# (c) completeness control on the enumeration: the Hurwitz order's theta series is
#     r(n) = 24 * sigma(odd part of n).  If my enumeration were dropping solutions this fails.
def sigma(n):
    return sum(d for d in range(1, n + 1) if n % d == 0)


thok = True
for m in range(1, 9):
    n = m * m
    odd = n
    while odd % 2 == 0:
        odd //= 2
    rng = [F(t, 2) for t in range(-2 * m, 2 * m + 1)]
    cnt = sum(1 for q in product(rng, repeat=4) if qnorm(q) == n and is_integral_vec(hcoords(q)))
    if cnt != 24 * sigma(odd):
        thok = False
        print(f"    m = {m}: found {cnt}, theta series says {24 * sigma(odd)}")
check("(c) enumeration matches the Hurwitz theta series 24*sigma(odd part) for m <= 8", thok)

print()
print("=" * 78)
print("CONTROLS")
print("=" * 78)

# C1 discrimination: psi is NOT constantly nonzero
zero_res = [v for v in box if psi_int(v) == ZERO_RES]
check("C1 psi vanishes somewhere (1+i has residue 0)", psi_int(hcoords(one_plus_i)) == ZERO_RES and len(zero_res) > 0,
      f"{len(zero_res)} of {len(box)} elements of the box have residue 0")
check("C1b all four residue classes occur in the box (the STEP 2 test could have failed)",
      len({psi_int(v) for v in box}) == 4)

# C2 planted fault: the LIPSCHITZ order, the mistake a person actually makes
lip_units = [u for u in sample if all(F(x).denominator == 1 for x in u)]
lip_half = [u for u in sample if any(F(x).denominator == 2 for x in u)]
check("C2 planted fault: over the Lipschitz order the same argument FAILS",
      len(lip_half) > 0,
      f"{len(lip_half)} of {len(sample)} unit quaternions have a denominator-2 coordinate, "
      f"so they are NOT in Z<1,i,j,k> localized at odd primes")
check("C2b and the fault is exactly Benda-Perles's index 2", mat_det4([[int(x) for x in hcoords(b)] for b in [ONE, I, J, K]]) in (2, -2),
      "[H : Lipschitz] = 2")

# C3 the residue really is F_4 as a RING (not just a group): multiplication is well defined
ringok = True
for u in product(range(-3, 4), repeat=4):
    for v in product(range(-1, 2), repeat=4):
        if psi_int(u) == ZERO_RES or psi_int(v) == ZERO_RES:
            continue
        pr = hcoords(qmul(from_h(u), from_h(v)))
        if psi_int([int(x) for x in pr]) == ZERO_RES:
            ringok = False
            break
check("C3 P is prime: a product of two units mod P is a unit mod P", ringok)

print()
print("=" * 78)
print(f"RESULT: {'ALL CHECKS PASS' if not fails else 'FAILURES: ' + ', '.join(fails)}")
print("=" * 78)

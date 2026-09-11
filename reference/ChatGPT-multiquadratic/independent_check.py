#!/usr/bin/env python3
"""independent_check.py -- an independent re-derivation of the claims in handoff.md (FS-36, 2026-09-11).

Written for VERIFICATION.md without reusing handoff_check.py's helpers. The two scripts encode the same
mathematics differently, so an encoding error in one is unlikely to be repeated in the other:

  * handoff_check.py reads a 2-adic square class off d mod 8 as a tuple of bits; this script DECIDES
    squareness in Q_2 by brute force modulo 2^3 ... 2^12 (re-verifying the mod-8 criterion on the way)
    and names a local class by its representative in {1, 3, 5, 7, 2, 6, 10, 14};
  * handoff_check.py stores a square-class group as a set of prime-sets closed under symmetric
    difference; this script stores it as an F_2 row space over the prime basis (bitmasks), with ranks
    from Gaussian elimination.

It also checks three things handoff_check.py does not: the screening rule on ALL 256 patterns of local
classes (a proof, not a sample), the ramification claim behind the two-colour criterion on all 16
subgroups of the local group, and the exact set of fields on which the field-wall note's old two-colour
condition (Proposition 6.4) and the corrected one disagree.

Exact integer arithmetic only. Exit status 0 iff every check passes.
"""
import itertools
import random
import sys

checks = 0


def check(name, cond):
    global checks
    if not cond:
        print(f"FAILED: {name}")
        sys.exit(1)
    checks += 1


# ---------------------------------------------------------------- the global side: bitmasks on primes
LIMIT = 1000
_sieve = bytearray([1]) * (LIMIT + 1)
_sieve[0] = _sieve[1] = 0
for _i in range(2, int(LIMIT ** 0.5) + 1):
    if _sieve[_i]:
        _sieve[_i * _i::_i] = bytearray(len(_sieve[_i * _i::_i]))
PRIMES = [i for i in range(LIMIT + 1) if _sieve[i]]
BIT = {p: 1 << k for k, p in enumerate(PRIMES)}


def mask(n):
    """The square class of 0 < n <= LIMIT: the set of primes dividing n to an odd power, as a bitmask."""
    m, x = 0, n
    for p in PRIMES:
        if p * p > x:
            break
        e = 0
        while x % p == 0:
            x //= p
            e += 1
        if e % 2:
            m ^= BIT[p]
    if x > 1:
        m ^= BIT[x]
    return m


def primes_of(m):
    return [p for p in PRIMES if m & BIT[p]]


def value(m):
    """The squarefree positive integer whose square class is m."""
    r = 1
    for p in primes_of(m):
        r *= p
    return r


def reduced_basis(vectors):
    """A reduced row-echelon basis of the F_2-span, as {pivot bit: row}."""
    basis = {}
    for v in vectors:
        for piv, row in basis.items():
            if v >> piv & 1:
                v ^= row
        if v:
            piv = v.bit_length() - 1
            for q in basis:
                if basis[q] >> piv & 1:
                    basis[q] ^= v
            basis[piv] = v
    return basis


def rank(vectors):
    return len(reduced_basis(vectors))


def span_elements(vectors):
    rows = list(reduced_basis(vectors).values())
    out = []
    for coeffs in range(1 << len(rows)):
        m = 0
        for i, r in enumerate(rows):
            if coeffs >> i & 1:
                m ^= r
        out.append(m)
    return out


def is_subgroup(elems):
    """A set of distinct classes is a subgroup iff it has exactly 2^(rank) elements."""
    return len(set(elems)) == len(elems) == 1 << rank(elems)


# ---------------------------------------------------------------- the local side: Q_2 by brute force
ODD_SQUARES = {k: {x * x % (1 << k) for x in range(1, 1 << k, 2)} for k in range(3, 13)}


def is_q2_square(n):
    """Is the nonzero integer n a square in Q_2?  Its 2-adic valuation must be even and its odd part a
    square modulo 2^k for k = 3..12 (Hensel: modulo 8 already decides, which the loop below re-verifies)."""
    e = 0
    while n % 2 == 0:
        n //= 2
        e += 1
    return e % 2 == 0 and all(n % (1 << k) in ODD_SQUARES[k] for k in range(3, 13))


for u in range(-(1 << 12) + 1, 1 << 12, 2):
    check(f"the mod-8 criterion at the odd unit {u}", is_q2_square(u) == (u % 8 == 1))

REPS = (1, 3, 5, 7, 2, 6, 10, 14)


def lclass(n):
    """The representative r of n's class in Q_2^x / Q_2^x2: the unique r in REPS with n * r a square."""
    hits = [r for r in REPS if is_q2_square(n * r)]
    check(f"exactly one 2-adic class for {n}", len(hits) == 1)
    return hits[0]


check("the eight representatives are eight distinct classes", sorted(lclass(r) for r in REPS) == sorted(REPS))
MUL = {(a, b): lclass(a * b) for a in REPS for b in REPS}
check("the local group has exponent two", all(MUL[r, r] == 1 for r in REPS))
check("the class of -1 is [7]", lclass(-1) == 7)
check("the class of -3 is [5] (the unramified class)", lclass(-3) == 5)


def lspan(gens):
    S = {1}
    for g in gens:
        S |= {MUL[s, g] for s in S}
    return frozenset(S)


LP = {p: lclass(p) for p in PRIMES}
_loc_cache = {}


def loc(m):
    """The 2-adic class of a global class, as a product of its primes' classes (a homomorphism; checked below)."""
    if m not in _loc_cache:
        r = 1
        for p in primes_of(m):
            r = MUL[r, LP[p]]
        _loc_cache[m] = r
    return _loc_cache[m]


SQUAREFREE = [n for n in range(1, LIMIT + 1) if value(mask(n)) == n]
for n in SQUAREFREE:
    check(f"localization is multiplicative at {n}", loc(mask(n)) == lclass(n))

U_A, U_B, FULL = lspan([3, 2]), lspan([3, 10]), frozenset(REPS)
check("U_A = {1, 3, 2, 6}", U_A == {1, 3, 2, 6})
check("U_B = {1, 3, 10, 14}", U_B == {1, 3, 10, 14})
check("neither block contains the class of -1", 7 not in U_A and 7 not in U_B)
check("the two blocks generate the whole local group", lspan(list(U_A | U_B)) == FULL)

# ---------------------------------------------------------------- 1. the decomposition
POOL = [n for n in range(2, 71) if n in SQUAREFREE]
check("43 squarefree radicands in 2..70", len(POOL) == 43)


def decomposition_ok(extra, adjoin_two=True):
    gens = [mask(g) for g in [3, 11, *extra] + ([2] if adjoin_two else [])]
    W = span_elements(gens)
    WA = [w for w in W if loc(w) in U_A]
    WB = [w for w in W if loc(w) in U_B]
    V = {loc(w) for w in W}
    return (U_A <= V if adjoin_two else True,
            is_subgroup(WA) and is_subgroup(WB),
            all(mask(q) in WA and mask(q) in WB for q in (3, 11)),
            all(loc(w) != 7 for w in WA + WB),
            rank(WA + WB) == rank(W))


n_dec = 0
for r in range(4):
    for extra in itertools.combinations(POOL, r):
        check(f"decomposition over K{extra}", all(decomposition_ok(extra)))
        n_dec += 1
rng = random.Random(911)
BIG = [n for n in SQUAREFREE if n > 1]
for _ in range(2000):
    extra = rng.sample(BIG, rng.randint(4, 8))
    check(f"decomposition over K{extra}", all(decomposition_ok(extra)))
    n_dec += 1

red = [e for e in POOL if not decomposition_ok((e,), adjoin_two=False)[4]]
check("adjoining sqrt2 is load-bearing: without it K(sqrt7) does not split", 7 in red)

# ---------------------------------------------------------------- 2. the two-colour criterion
def two_colour_local(W):
    V = {loc(w) for w in W}
    return 7 not in V and 3 not in V


def two_colour_global(W):
    """No odd element of the square-class group is 3 mod 4."""
    return all(value(w) % 4 == 1 for w in W if value(w) % 2 == 1)


n_two = 0
for r in range(1, 4):
    for gens in itertools.combinations(POOL, r):
        W = span_elements([mask(g) for g in gens])
        check(f"two-colour criterion, local form = global form, at {gens}", two_colour_local(W) == two_colour_global(W))
        n_two += 1

for N in range(2, 1000):
    if N in SQUAREFREE:
        check(f"two-colour criterion vs Fischer 1990 Thm 8 at N = {N}", two_colour_local(span_elements([mask(N)])) == (N % 4 != 3))

SUBGROUPS = {lspan(T) for k in range(4) for T in itertools.combinations(REPS, k)}
check("the local group has 16 subgroups", len(SUBGROUPS) == 16)


def f_residue(V):
    """Residue degree of Q_2(sqrt V): 2 iff it contains Q_2(sqrt 5), the unique unramified quadratic extension."""
    return 2 if 5 in V else 1


def e_ram(V):
    return len(V) // f_residue(V)


for V in SUBGROUPS:
    if 7 in V:
        continue
    Vi = lspan(list(V) + [7])
    check(f"E(i)/E is ramified exactly when [3] is absent, at V = {sorted(V)}", (e_ram(Vi) // e_ram(V) == 2) == (3 not in V))

old_differs = sorted(sorted(V) for V in SUBGROUPS
                     if 7 not in V and (f_residue(lspan(list(V) + [7])) == 1) != (3 not in V))
check("Prop 6.4's old two-colour condition and the corrected one differ exactly on the V containing [5]",
      old_differs == sorted(sorted(V) for V in SUBGROUPS if 7 not in V and 5 in V))
check("Prop 6.4's old condition is still sufficient",
      all((3 not in V) for V in SUBGROUPS if 7 not in V and f_residue(lspan(list(V) + [7])) == 1))

# ---------------------------------------------------------------- 3. the screening rule, on every pattern
def rule(T):
    odd = [t for t in T if t % 2]
    even = {t for t in T if t % 2 == 0}
    return all(t in (1, 3) for t in odd) and (even <= {2, 6} or even <= {10, 14})


for k in range(len(REPS) + 1):
    for T in itertools.combinations(REPS, k):
        check(f"screening rule on the local pattern {T}", rule(T) == (7 not in lspan(list(T) + [3])))
for d in SQUAREFREE:
    if d % 2:
        check(f"odd d = {d}: class in {{1,3}} iff d = 1, 3 mod 8", (lclass(d) in (1, 3)) == (d % 8 in (1, 3)))
    else:
        check(f"even d = {d}: class in {{2,6}} iff d = 2, 6 mod 16", (lclass(d) in (2, 6)) == (d % 16 in (2, 6)))
        check(f"even d = {d}: class in {{10,14}} iff d = 10, 14 mod 16", (lclass(d) in (10, 14)) == (d % 16 in (10, 14)))

# ---------------------------------------------------------------- 4. odd primes, the examples, the tables
def euler_residue(u, p):
    return pow(u % p, (p - 1) // 2, p) == 1


def usable(W, p):
    """A prime p = 3 mod 4 is usable for Q(sqrt W) iff every class in W prime to p is a square mod p
    (otherwise the unramified quadratic extension, which contains i at p, lies inside the completion)."""
    for w in W:
        if not w & BIT[p]:
            u = 1
            for q in primes_of(w):
                u = u * q % p
            if not euler_residue(u, p):
                return False
    return True


def W_of(*rads):
    return span_elements([mask(r) for r in rads])


def contains(W, n):
    return mask(n) in W


rows = [((), 4), ((5,), 5), ((247,), 5), ((5, 247), 5), ((5, 23), 5), ((5, 14), 5), ((35,), 4), ((2, 35), 4), ((10, 35), 4)]
for extra, claimed in rows:
    W = W_of(3, 11, *extra)
    wall = all(loc(w) != 7 for w in W)
    lower5 = contains(W, 5) or contains(W, 247)
    derived = 4 if wall else (5 if usable(W, 11) and lower5 else None)
    check(f"example K{extra} = {claimed} (derived {derived})", derived == claimed)

W14, W70, W1470 = W_of(3, 11, 14), W_of(3, 11, 70), W_of(3, 11, 14, 70)
check("K(sqrt14) and K(sqrt70) keep the wall; their compositum holds sqrt5 and is usable at 11",
      all(loc(w) != 7 for w in W14 + W70) and contains(W1470, 5) and usable(W1470, 11))

WD = W_of(2, 3, 5, 7, 11)
WA_D = sorted(w for w in WD if loc(w) in U_A)
WB_D = sorted(w for w in WD if loc(w) in U_B)
check("de Grey's A-piece is K(sqrt2, sqrt35)", WA_D == sorted(W_of(3, 11, 2, 35)))
check("de Grey's B-piece is K(sqrt10, sqrt35)", WB_D == sorted(W_of(3, 11, 10, 35)))
check("sqrt5 = sqrt10 sqrt2 / 2 and sqrt7 = sqrt35 sqrt5 / 5, as integer identities", 10 * 2 == 4 * 5 and 35 * 5 == 25 * 7)
check("de Grey's field breaks the wall", any(loc(w) == 7 for w in W_of(3, 5, 7, 11)))

PR3 = [p for p in PRIMES if p % 4 == 3 and p < 200]
check("usable primes 3 mod 4 below 100 for K are 11 and 83", [p for p in PR3 if p < 100 and usable(W_of(3, 11), p)] == [11, 83])
check("usable primes 3 mod 4 below 100 for K(sqrt5) are only 11", [p for p in PR3 if p < 100 and usable(W_of(3, 5, 11), p)] == [11])
check("de Grey's field has no usable prime 3 mod 4 below 100", [p for p in PR3 if p < 100 and usable(W_of(3, 5, 7, 11), p)] == [])
check("K(sqrt7) is usable at 83 and not at 11", usable(W_of(3, 7, 11), 83) and not usable(W_of(3, 7, 11), 11))
blocked = {(3, 23, 47, 83): 5, (7, 19, 31, 43, 67, 79): 3, (59, 71): 11}
check("the blocking table covers every prime 3 mod 4 below 100 except 11",
      sorted(p for ps in blocked for p in ps) == [p for p in PR3 if p < 100 and p != 11])
for ps, u in blocked.items():
    for p in ps:
        check(f"{u} is a non-residue mod {p} and its root lies in K(sqrt5)", not euler_residue(u, p) and contains(W_of(3, 5, 11), u))
cut = [p for p in PR3 if (p + 1) ** 2 <= 4 * p * 25]
check("Weil + Hoffman leave six colours possible only up to 83 among primes 3 mod 4", max(cut) == 83 and 103 not in cut)
check("de Grey's field: 7 is a non-residue mod 11, so the 11-plane bound is lost", not euler_residue(7, 11))

# ---------------------------------------------------------------- 5. the splitting needs only [2] (FS-36 §M1)
def splits(V):
    """Is V the sum of its parts inside the two blocks?"""
    return lspan(list((V & U_A) | (V & U_B))) == V


for V in SUBGROUPS:
    if 2 in V:
        check(f"a local subgroup holding [2] splits along the two blocks: V = {sorted(V)}", splits(V))
check("the local subgroups that do not split are exactly {1,5}, {1,7} and {1,3,5,7}",
      sorted(sorted(V) for V in SUBGROUPS if not splits(V)) == [[1, 3, 5, 7], [1, 5], [1, 7]])

print(f"all {checks} checks passed ({n_dec} decomposition instances, {n_two} two-colour instances)")

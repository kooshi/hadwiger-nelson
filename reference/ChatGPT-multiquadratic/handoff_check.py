#!/usr/bin/env python3
"""Exact re-check of the 2026-09-11 multiquadratic handoff (square-class arithmetic only, no floats).

A real multiquadratic field is given by radicands; its global square classes are the F2-span of their
squarefree parts (a squarefree integer is stored as the frozenset of its primes; product = symmetric
difference). Local classes: Q2*/Q2*^2 = F2^3 with basis [-1], [5], [2]; Qp*/Qp*^2 = F2^2 as
(p-adic valuation parity, Legendre symbol of the unit part), where [-1] = (0, 1) for p = 3 mod 4.
"""
import itertools
import random

def primeset(n):
    fs, p = set(), 2
    while p * p <= n:
        c = 0
        while n % p == 0:
            n //= p
            c += 1
        if c % 2:
            fs.add(p)
        p += 1
    if n > 1:
        fs.add(n)
    return frozenset(fs)

def value(fs):
    r = 1
    for p in fs:
        r *= p
    return r

def span(gens):
    S = {frozenset()}
    for g in gens:
        g = primeset(g) if isinstance(g, int) else g
        S |= {s ^ g for s in S}
    return S

# ---- 2-adic
def rho2(fs):
    d = value(fs)
    v = d % 2 == 0
    u = (d // 2 if v else d) % 8
    return (u % 4 == 3, u in (3, 5), v)

def add(x, y):
    return tuple(a ^ b for a, b in zip(x, y))

def vspan(vs):
    S = {(False, False, False)}
    for v in vs:
        S |= {add(s, v) for s in S}
    return frozenset(S)

MINUS1, C3, C2, C10 = rho2(primeset(7)), rho2(primeset(3)), rho2(primeset(2)), rho2(primeset(10))
UA, UB, FULL = vspan([C3, C2]), vspan([C3, C10]), vspan([MINUS1, C3, C2])
assert len(UA) == len(UB) == 4 and len(FULL) == 8 and MINUS1 not in UA | UB and (UA | UB) != FULL
assert vspan(list(UA | UB)) == FULL

def wall_stands(S):
    return MINUS1 not in {rho2(s) for s in S}

def two_colour_criterion(S):
    cls = {rho2(s) for s in S}
    return MINUS1 not in cls and C3 not in cls

# ---- odd p = 3 mod 4
def legendre_nonresidue(u, p):
    return pow(u % p, (p - 1) // 2, p) == p - 1

def usable(S, p):
    for s in S:
        d = value(s)
        e = d % p == 0
        u = d // p if e else d
        if (not e) and legendre_nonresidue(u, p):
            return False
    # ramified classes: two with different unit Legendre symbols multiply to a nonresidue unit, which
    # is already an element of S and was caught above, since S is a group
    return True

K = [3, 11]
checks = 0

def check(name, cond):
    global checks
    if not cond:
        raise SystemExit(f"FAILED: {name}")
    checks += 1

# ---- the decomposition theorem, exhaustively over small radicand sets
def decomposition_holds(extra):
    W = span(K + list(extra) + [2])
    V = frozenset(rho2(w) for w in W)
    if V not in (UA, FULL):
        return "V neither UA nor FULL"
    WA = {w for w in W if rho2(w) in UA}
    WB = {w for w in W if rho2(w) in UB}
    if not all(primeset(q) in WA and primeset(q) in WB for q in K):
        return "K not inside A and B"
    if not (wall_stands(WA) and wall_stands(WB)):
        return "a piece breaks the wall"
    if span(list(WA | WB)) != W:
        return "AB != F(sqrt2)"
    return None

pool = [n for n in range(2, 71) if value(primeset(n)) == n]
n_dec = 0
for r in range(0, 4):
    for extra in itertools.combinations(pool, r):
        err = decomposition_holds(extra)
        check(f"decomposition at K{extra}: {err}", err is None)
        n_dec += 1
rng = random.Random(20260911)
big = [n for n in range(2, 400) if value(primeset(n)) == n]
for _ in range(3000):
    extra = rng.sample(big, rng.randint(4, 6))
    err = decomposition_holds(extra)
    check(f"decomposition at K{extra}: {err}", err is None)
    n_dec += 1

# ---- the named pieces for de Grey's field
W = span([3, 11, 5, 7, 2])
WA = {w for w in W if rho2(w) in UA}
WB = {w for w in W if rho2(w) in UB}
check("A = K(sqrt2, sqrt35)", WA == span([3, 11, 2, 35]))
check("B = K(sqrt10, sqrt35)", WB == span([3, 11, 10, 35]))
check("de Grey's field breaks the wall and has no usable prime 3 mod 4 below 100",
      not wall_stands(span([3, 5, 7, 11])) and
      not any(usable(span([3, 5, 7, 11]), p) for p in range(3, 100, 4) if all(p % q for q in range(2, p))))

# ---- the practical rules for extensions of K, against the direct criteria
def rule16(ds):
    if any(d % 8 not in (1, 3) for d in ds if d % 2):
        return False
    groups = {d % 16 in (2, 6) for d in ds if d % 2 == 0}
    return len(groups) <= 1

def rule11(ds):
    return all(not legendre_nonresidue(d // 11 if d % 11 == 0 else d, 11) for d in ds)

n_rule = 0
for r in range(0, 4):
    for ds in itertools.combinations(pool, r):
        S = span(K + list(ds))
        check(f"mod-16 rule at K{ds}", rule16(ds) == wall_stands(S))
        check(f"mod-11 rule at K{ds}", rule11(ds) == usable(S, 11))
        n_rule += 1

# ---- the example table: (radicands over K, claimed value, the reason the claim rests on)
def contains(S, n):
    return primeset(n) in S

table = [((), 4), ((5,), 5), ((247,), 5), ((5, 247), 5), ((5, 23), 5), ((5, 14), 5),
         ((35,), 4), ((2, 35), 4), ((10, 35), 4)]
for ds, claimed in table:
    S = span(K + list(ds))
    if wall_stands(S):
        derived = 4
    elif usable(S, 11) and (contains(S, 5) or contains(S, 247)):
        derived = 5
    else:
        derived = None
    check(f"table row K{ds} = {claimed} (derived {derived})", derived == claimed)

S14, S70, S1470 = span(K + [14]), span(K + [70]), span(K + [14, 70])
check("K(sqrt14), K(sqrt70) each keep the wall; their compositum contains sqrt5 and is 11-usable",
      wall_stands(S14) and wall_stands(S70) and contains(S1470, 5) and usable(S1470, 11))

# ---- the two-colour criterion against Fischer's Theorem 8 on real quadratic fields
for N in range(2, 1000):
    if value(primeset(N)) == N:
        check(f"two-colour criterion vs Fischer Thm 8 at N = {N}", two_colour_criterion(span([N])) == (N % 4 != 3))

# ---- the prime table and the six-colour Weil-Hoffman cutoff
primes3 = [p for p in range(3, 200, 4) if all(p % q for q in range(2, int(p ** 0.5) + 1))]
check("usable primes 3 mod 4 below 100 for K are 11 and 83",
      [p for p in primes3 if p < 100 and usable(span(K), p)] == [11, 83])
check("usable primes 3 mod 4 below 100 for H = K(sqrt5) are only 11",
      [p for p in primes3 if p < 100 and usable(span(K + [5]), p)] == [11])
check("K(sqrt7) is usable at 83", usable(span(K + [7]), 83))
cut = [p for p in primes3 if (p + 1) ** 2 <= 4 * p * 25]
check("Weil-Hoffman leaves six colours possible only up to p = 83 among p = 3 mod 4", max(cut) == 83 and 103 not in cut)

print(f"all {checks} checks passed ({n_dec} decomposition instances, {n_rule} rule instances)")

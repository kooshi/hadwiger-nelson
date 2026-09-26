#!/usr/bin/env python3
"""X21V exact checks (crunch 2026-09-26, wave 3) for list X21's arithmetic.

Every check here verifies a claim derived by hand in plans/FS100-X21V-verification.md stage 2; none searches.

C1  Q-0: for squarefree d, the dyadic place of Q(sqrt d) is stable (-1 not a square in F_v) iff d is not 7 mod 8.
    Checked two independent ways: (a) the hand rule "-1 in F_v^2 iff -d is a 2-adic square", -d tested by brute force
    mod 2^12; (b) PARI: #primes of L=Q(sqrt d, i) above 2 == #primes of F above 2 (stable) or twice it (split).
    Also records ramified-vs-unramified in L/F for the stable ones (row 100's exception is 'ramified stable dyadic').
C2  the class: the residues r mod 168 with r = 7 (8), r = 2 (3), r a non-residue mod 7 are exactly {47, 143, 167}
    (complete enumeration of the 168 residues; the extent fixed by the derivation).
C3  stable odd places below a bound, by the hand rule (p = 3 mod 4 and (p | d or (d/p) = 1)) against PARI's
    decomposition counts, for the named fields and the controls.
C4  A-2: 11 is stable with residue field F_11 in Q(sqrt d) for d = 47, 143, 311, 335 (so L <= chi(Gamma_11) = 5).
C5  J48-N4's number at 23 and J39's at 43, 59: max |lambda| / degree over the nontrivial characters of Gamma_p
    (level one; higher levels are <= 2/(p+1) by row 75's fibre bound), float with the target values.

Plants (--plant NAME) must each make the run exit nonzero:
  dyadic-rule  : the hand rule is replaced by 'd = 3 mod 8 is split'
  class        : 71 replaces 47 in the expected class
  circle       : Gamma_p's circle loses one point
Exit 0 all checks pass, 1 a check failed.
"""
import math
import subprocess
import sys

PLANT = sys.argv[sys.argv.index("--plant") + 1] if "--plant" in sys.argv else None
FAIL = []


def check(ok, msg):
    print(("PASS " if ok else "FAIL ") + msg)
    if not ok:
        FAIL.append(msg)


def squarefree(n):
    k = 2
    while k * k <= n:
        if n % (k * k) == 0:
            return False
        k += 1
    return True


def legendre(a, p):
    a %= p
    if a == 0:
        return 0
    return 1 if pow(a, (p - 1) // 2, p) == 1 else -1


def is_2adic_square(a, k=12):
    """a an odd integer: brute force, is a a square mod 2^k (k >= 3 decides it for odd a)."""
    m = 1 << k
    a %= m
    return any((x * x - a) % m == 0 for x in range(1, m, 2))


def gp(cmd):
    out = subprocess.run(["gp", "-q", "-f"], input=cmd + "\n", capture_output=True, text=True, timeout=60)
    return out.stdout.strip()


def pari_counts(d, p):
    """(#primes of F above p, #primes of L above p, ramification index of L/F at them)."""
    r = gp(
        f"F=nfinit(x^2-{d}); L=nfinit(polcompositum(x^2-{d},x^2+1)[1]); "
        f"a=idealprimedec(F,{p}); b=idealprimedec(L,{p}); print([#a,#b,b[1].e/a[1].e])"
    )
    return eval(r)


# ---------- C1 ----------
def dyadic_stable_hand(d):
    if d % 2 == 0:
        return True  # even d: F_v = Q2(sqrt 2), Q2(sqrt 6), ...; -d = -2, -6 mod squares is not 1, so -1 not a square
    if PLANT == "dyadic-rule" and d % 8 == 3:
        return False
    return not is_2adic_square(-d)


print("== C1: the dyadic place (Q-0)")
for d in [n for n in range(2, 400) if squarefree(n)]:
    hand = dyadic_stable_hand(d)
    nf, nl, e = pari_counts(d, 2)
    pari_stable = nl == nf
    if hand != pari_stable:
        check(False, f"d={d}: hand stable={hand} PARI stable={pari_stable}")
    if d % 8 == 7 and pari_stable:
        check(False, f"d={d} = 7 mod 8 has a stable dyadic place")
check(not FAIL, "C1 hand rule == PARI on squarefree d < 400; no d = 7 mod 8 has a stable dyadic place")
for d, expect in [(5, "ramified"), (17, "ramified"), (59, "unramified"), (47, "split"), (167, "split"), (143, "split")]:
    nf, nl, e = pari_counts(d, 2)
    kind = "split" if nl == 2 * nf else ("ramified" if e == 2 else "unramified")
    check(kind == expect, f"C1 control d={d}: dyadic place of F in L/F is {kind} (expect {expect})")

# ---------- C2 ----------
print("== C2: the class mod 168")
cls = sorted(r for r in range(168) if r % 8 == 7 and r % 3 == 2 and legendre(r, 7) == -1)
expect = [47, 143, 167] if PLANT != "class" else [71, 143, 167]
check(cls == expect, f"C2 residues = {cls} (expect {expect})")


# ---------- C3 ----------
def stable_odd_hand(d, bound):
    return [p for p in range(3, bound, 2) if all(p % q for q in range(2, int(p ** 0.5) + 1))
            and p % 4 == 3 and (d % p == 0 or legendre(d, p) == 1)]


print("== C3: stable odd places (hand rule vs PARI)")
for d in [47, 143, 167, 311, 335, 23, 31, 59]:
    hand = stable_odd_hand(d, 70)
    pari = [p for p in range(3, 70, 2) if all(p % q for q in range(2, int(p ** 0.5) + 1))
            and (lambda c: c[0] == c[1])(pari_counts(d, p))]
    check(hand == pari, f"C3 d={d}: stable odd p < 70 = {hand} (PARI {pari})")

# ---------- C4 ----------
print("== C4: 11 stable with residue F_11 (A-2's upper bound)")
for d in [47, 143, 311, 335]:
    nf, nl, e = pari_counts(d, 11)
    f = eval(gp(f"F=nfinit(x^2-{d}); print(idealprimedec(F,11)[1].f)"))
    check(nf == nl and f == 1, f"C4 d={d}: F-primes above 11 stable={nf == nl}, residue degree f={f}")
nf, nl, e = pari_counts(167, 11)
check(nf != nl, "C4 control d=167: 11 is NOT stable (so L(Q(sqrt 167)) >= 6 is not contradicted)")


# ---------- C5 ----------
def lam_star(p):
    pts = [(x, y) for x in range(p) for y in range(p) if (x * x + y * y - 1) % p == 0]
    if PLANT == "circle":
        pts = pts[1:]
    deg = len(pts)
    best, lmin = 0.0, 0.0
    for a in range(p):
        for b in range(p):
            if a == 0 and b == 0:
                continue
            lam = sum(math.cos(2 * math.pi * ((a * x + b * y) % p) / p) for x, y in pts)
            best = max(best, abs(lam))
            lmin = min(lmin, lam)
    return deg, best / deg, -lmin / deg


print("== C5: level-one mixing constants")
for p, target in [(23, 0.331695), (43, 0.271869), (59, 0.248626)]:
    deg, ls, lm = lam_star(p)
    check(deg == p + 1 and abs(ls - target) < 5e-7,
          f"C5 p={p}: degree {deg}, max|lambda|/d = {ls:.7f}, -lambda_min/d = {lm:.7f} (J39 table {target}); 2/(p+1) = {2/(p+1):.4f}")
deg, ls, lm = lam_star(23)
check(ls < 1 / 3 and abs((1 / 3 - ls) - 1.6e-3) < 1e-4, f"C5 23 is 4-thick: 1/3 - {ls:.7f} = {1/3 - ls:.6f} (J48-N4 margin 1.6e-3)")

print("RESULT:", "ALL PASS" if not FAIL else f"{len(FAIL)} FAIL")
sys.exit(1 if FAIL else 0)

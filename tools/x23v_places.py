#!/usr/bin/env python3
"""X23V — stable places of real multiquadratic fields, and the class condition (exact; seconds).

Checks two derived claims of list X23 (plans/CRUNCH-2026-09-26-x2x3-queue.md §7), blind to X23D:

  CTL: the class condition "every stable place of L = F(i) has all-levels four-colour ratio < 1/4"
       fails at K = Q(sqrt3,sqrt11), Q(sqrt2,sqrt3), Q(sqrt11), Q(sqrt23) and holds at Q(sqrt47);
  Q35: the stable places of Q(sqrt3,sqrt5) are exactly those above primes p = 11, 59 (mod 60); the dyadic
       place is split in L (so F is outside row 100's exception); 3,7,19,23,31,43,47 are not stable.

The derivation (plans/FS100-X23V-verification.md §2.2) fixes the finite extent: among stable places only
residue fields F_3, F_7 (odd) and dyadic places (ramified in L/F, or inert with Q <= 32) can have
all-levels ratio >= 1/4; every odd usable q >= 11 and every inert dyadic Q >= 64 has ratio < 1/4 (FS-66 at
11 and 19; Hoffman + Lemma P at 23, 27, 31, 43, 47; Weil from 37; G56/G59 at U_64, U_128). So the class
condition at a field is decided by the primes 2, 3, 7 alone: a complete finite check, no search.

Two independent routes: (A) Kummer theory over Q_p (square classes, Legendre symbols) in pure Python;
(B) PARI's idealprimedec on F and on L. They must agree. Plants must fire.
"""
import subprocess, sys

# ---------- route A: Kummer theory ----------

def sqclass2(n):
    """square class of a nonzero integer in Q_2^x / squares: (v mod 2, odd part mod 8)."""
    v = 0
    while n % 2 == 0:
        n //= 2; v += 1
    return (v % 2, n % 8)

def mul2(a, b):
    return ((a[0] + b[0]) % 2, (a[1] * b[1]) % 8)

def span2(gens):
    H = {(0, 1)}
    for g in gens:
        H |= {mul2(h, g) for h in H}
    return H

UNR2 = {(0, 1), (0, 5)}  # {1, 5}: the unramified class of Q_2 is 5 (Q_2(sqrt5) = Q_2(sqrt-3))

def dyadic(rads, minus1=(0, 7)):
    """classification of the dyadic places of F = Q(sqrt rads) in L = F(i)."""
    H = span2([sqclass2(r) for r in rads])
    f = len(H & UNR2); e = len(H) // f
    if minus1 in H:
        return ("split", None, e, f)
    H2 = span2(list(H) + [minus1])
    f2 = len(H2 & UNR2)
    if f2 == 2 * f:
        return ("inert", 2 ** f, e, f)
    return ("ramified", 2 ** f, e, f)

def legendre(a, p):
    a %= p
    if a == 0:
        return 0
    return 1 if pow(a, (p - 1) // 2, p) == 1 else -1

def odd_local(rads, p):
    """(e, f) of p in F = Q(sqrt rads), p odd, via the image of the Kummer group in Q_p^x/squares."""
    # classes in Q_p^x/sq for odd p: (valuation mod 2, unit residue-ness in {1,-1})
    def cls(n):
        v = 0
        while n % p == 0:
            n //= p; v += 1
        return (v % 2, legendre(n, p))
    H = {(0, 1)}
    for r in rads:
        c = cls(r)
        H |= {((h[0] + c[0]) % 2, h[1] * c[1]) for h in H}
    f = len(H & {(0, 1), (0, -1)})
    e = len(H) // f
    return e, f

def stable_odd(rads, p):
    e, f = odd_local(rads, p)
    return (p % 4 == 3) and (f % 2 == 1), e, f

# ---------- route B: PARI ----------

def pari_table(rads, primes):
    pol = "x^2-%d" % rads[0]
    for r in rads[1:]:
        pol = "polcompositum(%s,x^2-%d)[1]" % (pol, r)
    polL = "polcompositum(%s,x^2+1)[1]" % pol
    script = "F=nfinit(%s);L=nfinit(%s);" % (pol, polL)
    script += "foreach(%s,p,dF=idealprimedec(F,p);dL=idealprimedec(L,p);print(p,\" \",#dF,\" \",dF[1].e,\" \",dF[1].f,\" \",#dL))" % (str(primes))
    out = subprocess.run(["gp", "-q", "-f"], input=script + "\nquit\n", capture_output=True, text=True, check=True).stdout
    tab = {}
    for line in out.strip().splitlines():
        p, nF, e, f, nL = map(int, line.split())
        tab[p] = dict(nF=nF, e=e, f=f, stable=(nL == nF))  # L/Q abelian: all primes above p alike
    return tab

# ---------- the class condition ----------

def class_condition(rads):
    """True iff every stable place has all-levels ratio < 1/4; decided by 2, 3, 7 (derivation §2.2)."""
    bad = []
    kind, Q, e, f = dyadic(rads)
    if kind == "ramified":
        bad.append(("2", "ramified in L/F: ratio 1/2"))
    elif kind == "inert" and Q <= 32:
        bad.append(("2", "inert, U_%d four-colourable: ratio >= 1/4" % Q))
    for p in (3, 7):
        st, e_, f_ = stable_odd(rads, p)
        if st and f_ == 1:
            bad.append((str(p), "stable, residue field F_%d (chi(Gamma_%d) = %d)" % (p, p, 3 if p == 3 else 4)))
    return (len(bad) == 0), bad, (kind, Q, e, f)

FIELDS = {
    "K=Q(sqrt3,sqrt11)": [3, 11],
    "Q(sqrt2,sqrt3)": [2, 3],
    "Q(sqrt11)": [11],
    "Q(sqrt23)": [23],
    "Q(sqrt47)": [47],
    "Q(sqrt3,sqrt5)": [3, 5],
}
EXPECT = {"K=Q(sqrt3,sqrt11)": False, "Q(sqrt2,sqrt3)": False, "Q(sqrt11)": False, "Q(sqrt23)": False,
          "Q(sqrt47)": True, "Q(sqrt3,sqrt5)": True}

def primes_upto(n):
    return [p for p in range(3, n + 1) if all(p % d for d in range(2, int(p ** 0.5) + 1))]

def run(plant=None):
    fails = []
    # route A vs route B on stability and residue degree, every odd prime < 400, every field
    ps = primes_upto(400)
    for name, rads in FIELDS.items():
        tab = pari_table(rads, [2] + ps)
        kind, Q, e, f = dyadic(rads)
        if plant == "dyadic-minus1-as-3":
            kind, Q, e, f = dyadic(rads, minus1=(0, 3))
        if tab[2]["stable"] != (kind != "split") or tab[2]["f"] != f or tab[2]["e"] != e:
            fails.append("%s: dyadic route A %s (e=%d,f=%d) vs PARI %s" % (name, kind, e, f, tab[2]))
        for p in ps:
            st, e_, f_ = stable_odd(rads, p)
            if plant == "flip-legendre-7" and p == 7:
                st = not st
            if tab[p]["stable"] != st or tab[p]["f"] != f_ or tab[p]["e"] != e_:
                fails.append("%s: p=%d route A (st=%s,e=%d,f=%d) vs PARI %s" % (name, p, st, e_, f_, tab[p]))
        ok, bad, dy = class_condition(rads if plant != "swap-47-23" or name != "Q(sqrt47)" else [23])
        print("%-20s dyadic=%s  class condition=%s  failing places=%s" % (name, dy, ok, bad))
        if ok != EXPECT[name]:
            fails.append("%s: class condition %s, expected %s" % (name, ok, EXPECT[name]))
    # Q35: stable odd places of Q(sqrt3,sqrt5) are exactly p = 11, 59 (mod 60), all of residue degree one
    rads = [3, 5]
    tab = pari_table(rads, ps)
    stable = [p for p in ps if tab[p]["stable"]]
    predicted = [p for p in ps if p % 60 in (11, 59)]
    if plant == "q35-wrong-congruence":
        predicted = [p for p in ps if p % 60 in (11, 59, 23)]
    print("Q(sqrt3,sqrt5): stable odd primes < 400:", stable)
    if stable != predicted:
        fails.append("Q35: stable %s != predicted %s" % (stable, predicted))
    if any(tab[p]["f"] != 1 for p in stable):
        fails.append("Q35: a stable place of residue degree > 1")
    for p in (3, 7, 19, 23, 31, 43, 47):
        if tab[p]["stable"]:
            fails.append("Q35: %d is stable" % p)
    return fails

if __name__ == "__main__":
    plant = sys.argv[1] if len(sys.argv) > 1 else None
    fails = run(plant)
    if fails:
        print("FAIL (%d):" % len(fails))
        for x in fails[:12]:
            print("  ", x)
        sys.exit(1)
    print("ALL CHECKS PASS")

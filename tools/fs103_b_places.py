#!/usr/bin/env python3
"""FS103-B stage 3: exact place checks for the fractional shadow's instances.

For F = Q(sqrt d) (d = 635087, and d = 47 as the second instance) this lists every
stable place below BOUND, with residue field size q, by two independent routes:

  route A (criterion): an odd prime p gives a stable place of F iff p = 3 (mod 4)
      and the place has odd residue degree f (i.e. p split or ramified in F);
      for the dyadic place, i in F_v is decided by the 2-adic square class of d.
  route B (PARI):     idealprimedec over F and over the absolute field of L = F(i);
      a place v of F is stable iff exactly one prime of L lies above it
      (L/F inert or ramified at v), counted by comparing e*f sums.

The two routes must agree place by place.  Then it bounds the all-levels ratio of
every stable place by the two-point (Hoffman) bound lam/(1+lam), lam = 2 sqrt(q)/(q+1)
(Weil at level one; X26B-L1's 2/(q+1) above it is smaller), and for q < 60 also by the
exact level-one Hoffman ratio -lmin/(1-lmin) (lmin = least normalised eigenvalue of
UD(F_q, 2), computed to 50 digits with mpmath).

PLANT=1 plants a fault (route A's rule flipped to p = 1 (mod 4)); the agreement
assertion must fire.  PLANT=2 plants d = 635083 (not the claim's d); the primality
assertion must fire.  Exit 0 = all checks pass; 1 = a check failed.
"""
import os
import subprocess
import sys

import mpmath

mpmath.mp.dps = 50
BOUND = 2000
CROFT = mpmath.mpf("0.22936")  # delta_Croft = 0.22936..., a lower bound for m1(R^2)
PLANT = os.environ.get("PLANT", "0")


def gp(cmd: str) -> str:
    out = subprocess.run(["gp", "-q", "-f", "-D", "parisizemax=2G"], input=cmd,
                         capture_output=True, text=True, check=True)
    return out.stdout.strip()


def stable_route_a(d: int, p: int) -> bool:
    if p == 2:
        # F_v contains i iff -1 is a square in F_v; for d = 3 mod 4, F_v = Q_2(sqrt d),
        # and Q_2(sqrt d) = Q_2(i) iff -d is a square in Q_2 iff -d = 1 (mod 8).
        assert d % 4 == 3
        return (-d) % 8 != 1
    rule = (p % 4 == 1) if PLANT == "1" else (p % 4 == 3)
    kr = int(gp(f"print(kronecker({d},{p}))"))
    return rule and kr in (0, 1)  # split (kr = 1) or ramified (kr = 0): residue degree 1


def stable_route_b(d: int, primes: list[int]) -> dict[int, list[int]]:
    """For each p, the list of residue-field sizes of stable places of F above p."""
    script = f"""
F = nfinit(x^2 - {d});
L = nfinit(polcompositum(x^2 - {d}, x^2 + 1)[1]);
{{
foreach({primes}, p,
  dF = idealprimedec(F, p); dL = idealprimedec(L, p);
  \\\\ each prime of F above p: count the primes of L above it via ef-totals.
  \\\\ F quadratic: one or two primes above p.  L/F quadratic.
  res = [];
  if(#dF == 1,
     P = dF[1]; efF = P.e * P.f;
     \\\\ one prime of F above p: L has 1 prime above it iff L has 1 prime above p
     res = if(#dL == 1, [p^P.f], []),
     \\\\ two primes of F above p (split in F): each has efF = 1; stable iff #dL == 2
     res = if(#dL == 2, [p^dF[1].f, p^dF[2].f], []));
  print(p, " ", res));
}}
"""
    out = {}
    for line in gp(script).splitlines():
        p_str, rest = line.split(" ", 1)
        rest = rest.strip().strip("[]")
        out[int(p_str)] = [int(t) for t in rest.split(",") if t.strip()]
    return out


def hoffman_level_one(q: int) -> mpmath.mpf:
    """Exact-to-50-digits level-one Hoffman ratio of UD(F_q, 2), q prime = 3 mod 4."""
    circ = [(x, y) for x in range(q) for y in range(q) if (x * x + y * y) % q == 1]
    assert len(circ) == q + 1
    zeta = [mpmath.exp(2j * mpmath.pi * k / q) for k in range(q)]
    lmin = mpmath.mpf(1)
    for a in range(q):
        for b in range(q):
            if a == 0 and b == 0:
                continue
            s = mpmath.fsum(zeta[(a * x + b * y) % q] for x, y in circ).real / (q + 1)
            lmin = min(lmin, s)
    return -lmin / (1 - lmin)


def main() -> int:
    ok = True
    d = 635083 if PLANT == "2" else 635087
    if gp(f"print(isprime({d}))") != "1":
        print(f"FAIL: {d} is not prime"); return 1
    print(f"d = {d}: prime; d mod 8 = {d % 8}, d mod 16 = {d % 16}")
    primes = [int(t) for t in gp(f"print(primes([2,{BOUND}]))").strip("[]").split(",")]
    for dd in (d, 47):
        rb = stable_route_b(dd, primes + ([dd] if dd > BOUND else []))
        stable = []
        for p in primes + ([dd] if dd > BOUND else []):
            a = stable_route_a(dd, p)
            b = len(rb.get(p, [])) > 0
            if a != b:
                print(f"FAIL: routes disagree at d = {dd}, p = {p}: A={a} B={b} ({rb.get(p)})")
                ok = False
            if b:
                stable.extend(rb[p])
        print(f"\nF = Q(sqrt {dd}): stable places below {BOUND} (residue field sizes), "
              f"{'ramified place ' + str(dd) + ' included' if dd > BOUND else ''}")
        print("  ", stable[:40], "..." if len(stable) > 40 else "")
        print(f"   count = {len(stable)}; smallest q = {min(stable)}")
        worst = mpmath.mpf(0)
        for q in stable:
            lam = 2 * mpmath.sqrt(q) / (q + 1)
            worst = max(worst, lam / (1 + lam))
        if dd == 635087:
            # every stable place above BOUND has q > BOUND, so its bound is below the q = BOUND value
            tail = 2 * mpmath.sqrt(BOUND) / (BOUND + 1)
            print(f"   Weil two-point bound, max over listed places: {mpmath.nstr(worst, 12)}; "
                  f"tail (q > {BOUND}) < {mpmath.nstr(tail / (1 + tail), 6)}")
            if not worst < CROFT:
                print("FAIL: a stable place's bound reaches Croft's 0.22936"); ok = False
            if min(stable) != 103:
                print(f"FAIL: smallest stable q is {min(stable)}, not 103"); ok = False
        else:
            print("   exact level-one Hoffman ratios for q < 60 (all levels: X26B-L1's 2/(q+1) is smaller):")
            for q in sorted(set(stable)):
                if q < 60:
                    h = hoffman_level_one(q)
                    lam = 2 * mpmath.sqrt(q) / (q + 1)
                    print(f"     q = {q}: Hoffman {mpmath.nstr(h, 15)}  Weil two-point "
                          f"{mpmath.nstr(lam / (1 + lam), 8)}")
                    if q == 31:
                        gap = mpmath.mpf(1) / 4 - h
                        print(f"     q = 31: 1/4 - Hoffman = {mpmath.nstr(gap, 12)}; "
                              f"1/Hoffman = {mpmath.nstr(1 / h, 15)}")
                        if not (1 / h > mpmath.mpf("4.0000439")):
                            print("FAIL: 1/Hoffman(31) <= 4.0000439"); ok = False
    print("\nALL CHECKS PASS" if ok else "\nSOME CHECK FAILED")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())

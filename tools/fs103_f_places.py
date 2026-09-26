#!/usr/bin/env python3
"""FS103-F: the stable places of a real quadratic field Q(sqrt d) and a Hoffman bound on each one's all-levels ratio.

What it checks (exact integer arithmetic; floats only for the final ratio bounds, printed with the inequality they must meet):

  * d is squarefree, d = 7 (mod 8): the place above 2 is F_v = Q_2(sqrt 7) = Q_2(i), which contains i, so it is NOT stable
    (the 2-adic wall is broken; no stable dyadic place, so the field is outside row 100's exception).
  * An odd prime p gives a stable place of F iff p = 3 (mod 4) and p splits or ramifies in F (Legendre (d/p) in {0, 1}):
    p = 1 (mod 4) puts i in Q_p; p inert in F gives the residue field F_{p^2}, which contains i.  Residue field of F_v: F_p.
  * At a stable place with F-residue field F_q the normalised least eigenvalue of the compact local plane, at every level, is at
    least -w(q), w(q) = max(2 sqrt q, 2)/(q + 1)  (Weil at level one; the two-point bound 2/(q+1) at new levels, X26B-L1, any base
    ramification).  Hoffman (measurable form, BDOV Thm 2.2) then bounds the all-levels ratio by h(q) = w/(1 + w).
  * h is decreasing in q for q >= 3, so the maximum over stable places above a bound B is at most h(next prime = 3 mod 4 above B).

Target (FS103-F stage 3): for the field named, every stable place has h < 0.22936 (Croft's lower bound for m_1(R^2)), so the best
local ratio of F is m_1(R^2) itself.  Exit status 1 if the target fails.

PLANT=1 runs the check on d = 47 (whose stable place above 11 has h = 0.356 > 0.22936) and must exit 1 for that reason.
PLANT=2 corrupts the Legendre test to Euler's criterion with the wrong exponent and must exit 1 on the self-test of the symbol.
"""
import math
import os
import sys

CROFT = 0.22936  # [Croft1967], as restated in [MatolcsiEtAl2025] (14): 0.22936... <= m_1(R^2)
PLANT = os.environ.get("PLANT", "0")


def is_prime(n):
    if n < 2:
        return False
    if n % 2 == 0:
        return n == 2
    r = int(math.isqrt(n))
    f = 3
    while f <= r:
        if n % f == 0:
            return False
        f += 2
    return True


def legendre(a, p):
    """Legendre symbol (a/p) for an odd prime p, by Euler's criterion (exact integers)."""
    a %= p
    if a == 0:
        return 0
    e = (p - 1) // 2 if PLANT != "2" else (p + 1) // 2
    t = pow(a, e, p)
    return 1 if t == 1 else -1


def squarefree(n):
    f = 2
    while f * f <= n:
        if n % (f * f) == 0:
            return False
        f += 1
    return True


def w(q):
    return max(2 * math.sqrt(q), 2) / (q + 1)


def h(q):
    return w(q) / (1 + w(q))


def self_test():
    # quadratic residues mod 11: 1, 3, 4, 5, 9
    got = [legendre(a, 11) for a in range(1, 11)]
    want = [1, -1, 1, 1, 1, -1, -1, -1, 1, -1]
    assert got == want, f"Legendre self-test failed: {got}"
    # Weil/Hoffman sanity: at q = 103 the claims list's number 2*sqrt(103)/104 = 0.19518
    assert abs(w(103) - 0.195176) < 1e-5, w(103)


def run(d, bound):
    assert squarefree(d), f"{d} not squarefree"
    assert d % 8 == 7, f"d = {d} is not 7 (mod 8): a dyadic place could be stable"
    stable = []
    for p in range(3, bound + 1, 2):
        if not is_prime(p) or p % 4 != 3:
            continue
        s = legendre(d, p)
        if s in (0, 1):
            stable.append((p, "ramified" if s == 0 else "split", h(p)))
    # the ramified primes above the bound (p | d, p = 3 mod 4)
    extra = []
    m = d
    for f in range(3, int(math.isqrt(d)) + 2, 2):
        while m % f == 0:
            m //= f
            if f > bound and f % 4 == 3:
                extra.append((f, "ramified", h(f)))
    if m > 1 and m > bound and m % 4 == 3:
        extra.append((m, "ramified", h(m)))
    nxt = bound + 1
    while not (is_prime(nxt) and nxt % 4 == 3):
        nxt += 1
    tail = h(nxt)
    worst = max([x[2] for x in stable + extra] + [tail])
    return stable, extra, nxt, tail, worst


def main():
    self_test()
    d = 47 if PLANT == "1" else int(sys.argv[1]) if len(sys.argv) > 1 else 635087
    bound = int(sys.argv[2]) if len(sys.argv) > 2 else 1000
    print(f"d = {d}, prime: {is_prime(d)}, d mod 8 = {d % 8}; stable odd places below {bound}:")
    stable, extra, nxt, tail, worst = run(d, bound)
    for p, kind, hv in stable + extra:
        print(f"  p = {p:>7} ({kind:8}) w = {w(p):.6f}  h = {hv:.6f}")
    print(f"  tail: every stable place above {bound} has h <= h({nxt}) = {tail:.6f}")
    print(f"max h over all stable places <= {worst:.6f}; Croft's lower bound for m_1 = {CROFT}")
    ok = worst < CROFT
    print("TARGET MET: best local ratio is m_1(R^2)" if ok else "TARGET FAILED: some stable place may beat m_1")
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())

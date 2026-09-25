#!/usr/bin/env python3
"""J11 (FS-91 S1V-six): band k-characters of the finite planes Gamma_q = Cay(F_{q^2}, mu_{q+1}), q prime = 3 (mod 4).

Exact integer arithmetic only.  Written from the statements, blind to J08's route and tools.

Derivation (plans/FS91-S1V-six.md, stage 2):
  * every character of (F_{q^2}, +) is lambda_a(x) = Tr(a x)/q  (trace form nondegenerate);
  * lambda_a(mu_{q+1}) = {t/q : t in V_c},  c = N(a),  V_c = {t : t^2 - 4c is a non-square or 0}
    (a mu_{q+1} is the norm-c circle; w with Tr w = t, N w = c is a root of X^2 - tX + c);
  * lambda_a is band k  iff  every t in V_c has |t| >= q/k  (t centred in (-q/2, q/2));
  * Weil (|nontrivial eigenvalue| <= 2 sqrt q) with Hoffman on the colour class {lambda in [0, 1/k)}, of size q*ceil(q/k):
    band k  ==>  q + 1 <= 2 (k - 1) sqrt q,  i.e.  (q + 1)^2 <= 4 (k - 1)^2 q.

So the parameter enumerated is c in F_q^x, over primes q fixed by that inequality.  The direct enumeration of every character
(u, v) on the circle {x^2 + y^2 = 1} is the independent control (sets compared, not only verdicts).

Usage:  crunch_j11_band.py run [--qmax N] [--direct-qmax N] [--plant NAME] [--out PATH]
        crunch_j11_band.py self-test        (runs every plant; each must fire for its own reason; a faithful run must pass)
Exit 0 on success, 1 on a failed assertion.
"""
import argparse
import json
import sys
from fractions import Fraction
from math import isqrt

PLANTS = ("none", "drop_disc_zero", "uncentred", "weil_k_not_k_minus_1", "skip_t_zero", "norm_without_quarter")


def is_prime(n):
    if n < 2:
        return False
    if n % 2 == 0:
        return n == 2
    r = isqrt(n)
    f = 3
    while f <= r:
        if n % f == 0:
            return False
        f += 2
    return True


def eta(x, q):
    """Quadratic character of F_q (q odd prime), eta(0) = 0, by Euler's criterion."""
    x %= q
    if x == 0:
        return 0
    return 1 if pow(x, (q - 1) // 2, q) == 1 else -1


def centred(t, q):
    t %= q
    return t - q if t > q // 2 else t


def V(c, q, plant="none"):
    """V_c = {t in F_q : t^2 - 4c is a non-square or 0}, as residues 0..q-1."""
    out = []
    for t in range(q):
        e = eta(t * t - 4 * c, q)
        if plant == "drop_disc_zero":
            ok = e == -1
        else:
            ok = e in (-1, 0)
        if plant == "skip_t_zero" and t == 0:
            ok = False
        if ok:
            out.append(t)
    return out


def absrep(t, q, plant="none"):
    return (t % q) if plant == "uncentred" else abs(centred(t, q))


def d_of(c, q, plant="none"):
    """min |t| over V_c (the band depth numerator: lambda_a is band k iff k*d >= q)."""
    return min(absrep(t, q, plant) for t in V(c, q, plant))


def weil_allows(q, k, plant="none"):
    """Necessary condition for a band k-character (derived): (q+1)^2 <= 4 (k-1)^2 q."""
    kk = k if plant == "weil_k_not_k_minus_1" else k - 1
    return (q + 1) ** 2 <= 4 * kk * kk * q


def reduction_table(q, plant="none"):
    """For every c in F_q^x: d(c).  Returns dict c -> d."""
    return {c: d_of(c, q, plant) for c in range(1, q)}


def direct_table(q):
    """Direct enumeration: every character (u, v) != 0 of F_q^2 on the circle x^2 + y^2 = 1.
    Returns dict (u, v) -> (value set as sorted residues, min |value|)."""
    circle = [(x, y) for x in range(q) for y in range(q) if (x * x + y * y) % q == 1]
    assert len(circle) == q + 1, (q, len(circle))
    out = {}
    for u in range(q):
        for v in range(q):
            if u == 0 and v == 0:
                continue
            vals = sorted({(u * x + v * y) % q for (x, y) in circle})
            out[(u, v)] = (vals, min(abs(centred(t, q)) for t in vals))
    return out


def run(qmax, direct_qmax, plant="none", ks=(6, 7, 8)):
    inv2 = None
    primes = [q for q in range(3, qmax + 1) if is_prime(q) and q % 4 == 3]
    res = {"kind": "j11-band-characters-v1", "plant": plant, "qmax": qmax, "direct_qmax": direct_qmax,
           "ks": list(ks), "planes": {}, "checks": []}
    failures = []
    for q in primes:
        tab = reduction_table(q, plant)
        D = max(tab.values())
        kappa = Fraction(D, q)
        chichar = -(-q // D) if D > 0 else None  # ceil(q/D) = ceil(1/kappa)
        bands = {k: sorted(c for c, d in tab.items() if k * d >= q) for k in ks}
        # the square class of each band c (a band character needs c a non-square: t = 0 lies in V_c iff -4c is a non-square or 0)
        entry = {"q": q, "D": D, "kappa": f"{kappa.numerator}/{kappa.denominator}", "chi_char": chichar,
                 "band": {str(k): bands[k] for k in ks},
                 "nonsquare_c": sorted(c for c in range(1, q) if eta(c, q) == -1),
                 "d_of_c": {str(c): d for c, d in sorted(tab.items())},
                 "chi_char_witnesses": sorted(c for c, d in tab.items() if d == D)}
        # (i) every band c is a non-square
        for k in ks:
            bad = [c for c in bands[k] if eta(c, q) != -1]
            if bad:
                failures.append(f"q={q} k={k}: band c not a non-square: {bad}")
        # (ii) the Weil necessary condition (derived theorem): band k  ==>  weil_allows(q, k)
        for k in range(2, 20):
            has = any(k * d >= q for d in tab.values())
            if has and not weil_allows(q, k, plant):
                failures.append(f"q={q} k={k}: band character exists but the Weil inequality refuses it")
        # (iii) chi_char consistency: band at chi_char, none at chi_char - 1
        if chichar is not None:
            if not any(chichar * d >= q for d in tab.values()):
                failures.append(f"q={q}: no band at chi_char={chichar}")
            if chichar > 1 and any((chichar - 1) * d >= q for d in tab.values()):
                failures.append(f"q={q}: band at chi_char-1")
        # (iv) the direct control: value sets and band status, character by character
        if q <= direct_qmax:
            dt = direct_table(q)
            inv4 = 1 if plant == "norm_without_quarter" else pow(4, -1, q)
            nset = nband = 0
            for (u, v), (vals, m) in dt.items():
                c = (u * u + v * v) * inv4 % q
                if c == 0:
                    failures.append(f"q={q}: character ({u},{v}) has norm 0 (impossible for q = 3 mod 4)")
                    continue
                if vals != sorted(V(c, q, plant)):
                    nset += 1
                red_min = d_of(c, q, plant)
                if red_min != m:
                    nband += 1
            if nset or nband:
                failures.append(f"q={q}: direct control disagrees: {nset} value sets, {nband} minima")
            res["checks"].append({"q": q, "characters": len(dt), "set_mismatches": nset, "min_mismatches": nband})
        res["planes"][str(q)] = entry
    res["failures"] = failures
    return res


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("mode", choices=("run", "self-test"))
    ap.add_argument("--qmax", type=int, default=199)
    ap.add_argument("--direct-qmax", type=int, default=143)
    ap.add_argument("--plant", default="none", choices=PLANTS)
    ap.add_argument("--out", default=None)
    a = ap.parse_args()
    if a.mode == "run":
        res = run(a.qmax, a.direct_qmax, a.plant)
        if a.out:
            with open(a.out, "w") as f:
                json.dump(res, f, indent=1, sort_keys=True)
        print(f"planes={len(res['planes'])} failures={len(res['failures'])}")
        for fl in res["failures"][:20]:
            print("FAIL", fl)
        sys.exit(1 if res["failures"] else 0)
    # self-test: the faithful run passes; each plant fires, and for its own reason
    ok = True
    faithful = run(47, 47)
    if faithful["failures"]:
        print("SELF-TEST: faithful run FAILED", faithful["failures"][:3]); ok = False
    else:
        print("SELF-TEST: faithful run passes (q <= 47)")
    expect = {
        # a plant and the failure text it must produce (its own reason)
        "drop_disc_zero": "value sets",          # misses t = +-2 sqrt(c) at square c: only the set comparison can see it
        "skip_t_zero": "not a non-square",       # admits square c as band characters
        "uncentred": None,                       # |t| read in [0, q): UNREACHABLE, since V_c = -V_c makes min t = min |t| (found by running it)
        "norm_without_quarter": "value sets",    # c = u^2 + v^2 for the character (u, v): V_{4c} = 2 V_c, a different set
        "weil_k_not_k_minus_1": None,            # the wrong inequality is WEAKER, so it can never fire: an unreachable plant, kept and labelled
    }
    for p, needle in expect.items():
        r = run(47, 47, p)
        fired = [f for f in r["failures"]]
        if needle is None:
            print(f"SELF-TEST: plant {p}: {'FIRED (unexpected)' if fired else 'silent, as derived (unreachable, kept and labelled)'}")
            if fired:
                ok = False
            continue
        own = [f for f in fired if needle in f]
        print(f"SELF-TEST: plant {p}: {len(fired)} failures, {len(own)} for its own reason ({needle!r})")
        if not own:
            ok = False
    # a reachable Weil plant: the inequality with (k-2) is STRONGER than the truth and must refuse a real band character
    r = run(47, 0, "none")
    strong_hits = []
    for qs, e in r["planes"].items():
        q = int(qs)
        for k in range(3, 20):
            if any(k * d >= q for d in reduction_table(q).values()) and not ((q + 1) ** 2 <= 4 * (k - 2) ** 2 * q):
                strong_hits.append((q, k))
    print(f"SELF-TEST: stronger-Weil plant refuses real band characters at {len(strong_hits)} (q, k), e.g. {strong_hits[:3]}")
    if not strong_hits:
        ok = False
    print("SELF-TEST", "PASS" if ok else "FAIL")
    sys.exit(0 if ok else 1)


if __name__ == "__main__":
    main()

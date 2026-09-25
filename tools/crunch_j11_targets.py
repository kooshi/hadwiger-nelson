#!/usr/bin/env python3
"""J11 (FS-91 S1V-six, W4): the residue targets of three real multiquadratic fields, and chi_char at each.

A stable place of L = F(i) is a prime P with c(P) = P; for Galois L/Q that is: the prime p = P n F is not split in L/F.
Derivation (plans/FS91-S1V-six.md, stage 2):
  * odd p: p is never ramified in L/F (the relative discriminant of F(sqrt -1)/F divides 4), so P is stable iff the residue
    field F_{p^f} of p in F lacks i, i.e. p = 3 (mod 4) and f odd.  For multiquadratic F = Q(sqrt D), f in {1, 2}, and f = 1 iff
    every radicand d in the group <D> with p not dividing d (squarefree representative) is a square mod p (the inertia field is
    Q(sqrt D_0)).  The level-one target is then Gamma_p.
  * p = 2: every prime above 2 splits in L/F when some d in <D> is 7 (mod 8) (Q_2(sqrt d) = Q_2(i), since -d = 1 (mod 8) is a
    2-adic square), so no dyadic place is stable.
Cross-check: PARI's idealprimedec on F and on L (g_L(p) = g_F(p) iff stable), for p below --pari-bound.

Usage:  crunch_j11_targets.py run [--bound N] [--pari-bound N] [--plant NAME] [--out PATH]
        crunch_j11_targets.py self-test
"""
import argparse
import json
import subprocess
import sys
from itertools import combinations
from math import isqrt

sys.path.insert(0, __file__.rsplit("/", 1)[0])
from crunch_j11_band import eta, is_prime, reduction_table  # noqa: E402

FIELDS = {
    "Q(sqrt167)": [167],
    "K(sqrt7)": [3, 7, 11],
    "deGrey K(sqrt5,sqrt7)": [3, 5, 7, 11],
}
PLANTS = ("none", "forget_ramified_rule", "p1mod4_allowed", "no_dyadic_check")


def squarefree(n):
    out = 1
    m = n
    f = 2
    while f * f <= m:
        while m % (f * f) == 0:
            m //= f * f
        if m % f == 0:
            out *= f
            m //= f
        f += 1
    return out * m


def radicand_group(D):
    g = set()
    for r in range(len(D) + 1):
        for sub in combinations(D, r):
            prod = 1
            for d in sub:
                prod *= d
            g.add(squarefree(prod))
    return sorted(g)


def dyadic_all_split(D, plant="none"):
    if plant == "no_dyadic_check":
        return True
    return any(d % 8 == 7 for d in radicand_group(D))


def stable_odd(p, D, plant="none"):
    """(stable?, residue degree f) for odd p."""
    grp = radicand_group(D)
    ramified = any(d % p == 0 for d in D)
    if plant == "forget_ramified_rule":
        D0 = [d for d in grp if d != 1]  # wrongly demand every radicand (incl. those divisible by p) be a nonzero square
        f = 1 if all(eta(d, p) == 1 for d in D0) else 2
    else:
        D0 = [d for d in grp if d % p != 0]
        f = 1 if all(eta(d, p) == 1 for d in D0) else 2
    ok_mod4 = (p % 4 == 3) or (plant == "p1mod4_allowed")
    return (ok_mod4 and f % 2 == 1), f, ramified


def pari_stable(D, primes):
    """PARI: for each p, (g_F, f_F, g_L).  Stable iff g_L == g_F."""
    pol_F = "x"
    for d in D:
        pol_F = f"polcompositum({pol_F}, x^2-{d})[1]" if pol_F != "x" else f"x^2-{d}"
    script = (
        f"F=nfinit(polredbest({pol_F}));"
        f"L=nfinit(polredbest(polcompositum(F.pol, x^2+1)[1]));"
        f"P={primes};"
        "for(j=1,#P,p=P[j];dF=idealprimedec(F,p);dL=idealprimedec(L,p);"
        "print(p,\" \",#dF,\" \",dF[1].f,\" \",#dL))"
    )
    out = subprocess.run(["gp", "-q", "-D", "parisizemax=2000000000"], input=script, capture_output=True, text=True,
                         timeout=600)
    res = {}
    for line in out.stdout.split("\n"):
        parts = line.split()
        if len(parts) == 4:
            p, gF, fF, gL = map(int, parts)
            res[p] = (gF, fF, gL)
    if not res:
        raise RuntimeError("PARI returned nothing: " + out.stderr[:500])
    return res


def weil_floor(q):
    """least k allowed by (q+1)^2 <= 4 (k-1)^2 q: a lower bound for chi_char(Gamma_q)."""
    k = 2
    while (q + 1) ** 2 > 4 * (k - 1) ** 2 * q:
        k += 1
    return k


def run(bound, pari_bound, plant="none", fields=FIELDS):
    res = {"kind": "j11-targets-v1", "plant": plant, "bound": bound, "pari_bound": pari_bound, "fields": {}}
    failures = []
    chi_cache = {}

    def chichar(q):
        if q not in chi_cache:
            D = max(reduction_table(q).values())
            chi_cache[q] = -(-q // D)
        return chi_cache[q]

    for name, D in fields.items():
        entry = {"radicands": D, "dyadic_all_split": dyadic_all_split(D, plant), "targets": []}
        odd = [p for p in range(3, bound + 1) if is_prime(p)]
        stab = {p: stable_odd(p, D, plant) for p in odd}
        targets = [p for p in odd if stab[p][0]]
        # PARI control on p < pari_bound (and p = 2)
        if pari_bound:
            ps = [2] + [p for p in odd if p < pari_bound]
            try:
                pr = pari_stable(D, ps)
            except Exception as e:  # noqa: BLE001
                entry["pari"] = f"unavailable: {e}"
                failures.append(f"{name}: PARI control did not run")
                pr = None
            if pr is not None:
                mism = []
                for p in ps:
                    gF, fF, gL = pr[p]
                    pari_st = gL == gF
                    if p == 2:
                        if pari_st == entry["dyadic_all_split"]:  # stable dyadic place <=> not all split
                            mism.append((2, "dyadic"))
                        continue
                    mine = stab[p][0]
                    if mine != pari_st:
                        mism.append((p, "stable", mine, pari_st))
                    if pari_st and fF != stab[p][1]:
                        mism.append((p, "f", stab[p][1], fF))
                entry["pari_checked_below"] = pari_bound
                entry["pari_mismatches"] = mism
                if mism:
                    failures.append(f"{name}: PARI disagrees at {mism[:5]}")
        if not entry["dyadic_all_split"]:
            failures.append(f"{name}: a stable dyadic place may exist (not handled)")
        best = None
        for p in targets:
            q = p  # f = 1 at every stable odd place (asserted above)
            if stab[p][1] != 1:
                failures.append(f"{name}: stable place at {p} with f={stab[p][1]}")
                continue
            wf = weil_floor(q)
            if best is not None and wf > best[0]:
                entry["targets"].append({"p": p, "ramified": stab[p][2], "chi_char_ge_weil": wf})
                continue
            cc = chichar(q)
            entry["targets"].append({"p": p, "ramified": stab[p][2], "chi_char": cc, "weil_floor": wf})
            if best is None or cc < best[0]:
                best = (cc, p)
        # completeness of the min: every target beyond the bound has weil_floor > best
        if best is not None:
            qnext = bound + 1
            if weil_floor(qnext) <= best[0]:
                failures.append(f"{name}: bound {bound} too small to certify the minimum {best}")
            entry["min_chi_char"] = best[0]
            entry["argmin"] = best[1]
            entry["band6_targets"] = [t["p"] for t in entry["targets"] if t.get("chi_char", 99) <= 6]
            entry["band7_targets"] = [t["p"] for t in entry["targets"] if t.get("chi_char", 99) <= 7]
        res["fields"][name] = entry
    res["failures"] = failures
    return res


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("mode", choices=("run", "self-test"))
    ap.add_argument("--bound", type=int, default=1800)
    ap.add_argument("--pari-bound", type=int, default=300)
    ap.add_argument("--plant", default="none", choices=PLANTS)
    ap.add_argument("--out", default=None)
    a = ap.parse_args()
    if a.mode == "run":
        r = run(a.bound, a.pari_bound, a.plant)
        if a.out:
            with open(a.out, "w") as f:
                json.dump(r, f, indent=1, sort_keys=True)
        for n, e in r["fields"].items():
            print(n, "min", e.get("min_chi_char"), "at", e.get("argmin"), "first targets",
                  [t["p"] for t in e["targets"][:8]], "band<=7 targets", e.get("band7_targets"))
        print("failures", len(r["failures"]))
        for fl in r["failures"]:
            print("FAIL", fl)
        sys.exit(1 if r["failures"] else 0)
    ok = True
    small = {"Q(sqrt167)": [167], "K(sqrt7)": [3, 7, 11]}
    f0 = run(1100, 200, "none", small)
    print("SELF-TEST faithful:", "pass" if not f0["failures"] else f0["failures"])
    ok &= not f0["failures"]
    for p, needle in (("forget_ramified_rule", "PARI disagrees"), ("p1mod4_allowed", "PARI disagrees")):
        r = run(400, 200, p, small)
        own = [f for f in r["failures"] if needle in f]
        print(f"SELF-TEST plant {p}: {len(r['failures'])} failures, {len(own)} for its own reason")
        ok &= bool(own)
    # the dyadic plant is unreachable on these fields (every one holds a radicand = 7 mod 8): run it on Q(sqrt 3), where 2 is stable
    r = run(50, 60, "no_dyadic_check", {"Q(sqrt3)": [3]})
    own = [f for f in r["failures"] if "dyadic" in str(f)]
    print(f"SELF-TEST plant no_dyadic_check on Q(sqrt3): {len(own)} dyadic failures")
    ok &= bool(own)
    print("SELF-TEST", "PASS" if ok else "FAIL")
    sys.exit(0 if ok else 1)


if __name__ == "__main__":
    main()

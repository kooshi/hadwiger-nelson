#!/usr/bin/env python3
"""J08 stages 4-5: the Weil threshold Q_k, the complete lists below it, and chi_char at the fields' level-one targets.

DERIVED (plans/FS91-S1D-six.md stage 4, J08-4): if Gamma_q (q prime, q = 3 mod 4) has a band k-character then, with
L = ceil(q/k),   L (q + 1) <= 2 sqrt(q) (q - L)      [Fejer kernel of an L-interval against |mu_h| <= 2 sqrt(q), Weil],
exactly:  L^2 (q+1)^2 <= 4 q (q - L)^2.  Hence q < 4(k-1)^2 =: Q_k.
This tool:
  (1) computes chi_char(Gamma_q) and kappa exactly for every prime q = 3 (mod 4) below QMAX (a complete enumeration of
      c in F_q^x per q, by SIX-a's law; m(c) found by scanning t = 0, 1, ... up to the first t in V_c);
  (2) checks the derived necessary condition against every exact value: the least band k must pass the Fejer test
      (a violation would refute the derivation or the Weil input), and prints the slack;
  (3) the complete lists (q, c) of band 6- and band 7-characters for q < Q_6 = 100, Q_7 = 144;
  (4) each field's stable level-one targets up to the derived bound 4(m-2)^2 (m the running minimum of chi_char),
      so that the minimum over ALL targets is decided (every q >= 4(m-2)^2 has chi_char >= m by (2)'s inequality).
PLANT: the Fejer test with sqrt(q) in place of 2 sqrt(q) (too strong) must be violated by some exact value (fires at the
consistency check, naming q); its faithful twin passes.  Writes data/fs91/j08/threshold.json always.
"""
from __future__ import annotations

import json
import sys
from fractions import Fraction
from itertools import combinations
from math import ceil, isqrt, prod
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
OUT = ROOT / "data" / "fs91" / "j08" / "threshold.json"
QMAX = 3000


def is_prime(n: int) -> bool:
    if n < 2:
        return False
    for p in range(2, isqrt(n) + 1):
        if n % p == 0:
            return False
    return True


def legendre(n: int, q: int) -> int:
    n %= q
    if n == 0:
        return 0
    return 1 if pow(n, (q - 1) // 2, q) == 1 else -1


def m_of(q: int, c: int) -> int:
    """min |t| over V_c = {t : t^2 - 4c a non-square or 0}; V_c is symmetric so scan t >= 0."""
    for t in range(0, q // 2 + 1):
        if legendre(t * t - 4 * c, q) != 1:
            return t
    raise AssertionError("V_c empty")  # impossible: |V_c| >= (q+1)/2


def kappa(q: int) -> tuple[Fraction, int, list[int], dict]:
    ms = {c: m_of(q, c) for c in range(1, q)}
    best = max(ms.values())
    return Fraction(best, q), ceil(Fraction(q, best)), sorted(c for c in ms if ms[c] == best), ms


def fejer_allows(q: int, k: int, weil_factor: int = 2) -> bool:
    """Necessary for a band k-character: L(q+1) <= f sqrt(q) (q-L), L = ceil(q/k); exact in integers."""
    L = -(-q // k)
    if L >= q:
        return True
    return L * L * (q + 1) ** 2 <= weil_factor * weil_factor * q * (q - L) ** 2


def fejer_kmin(q: int, weil_factor: int = 2) -> int:
    k = 2
    while not fejer_allows(q, k, weil_factor):
        k += 1
    return k


def usable(q: int, radicands: list[int]) -> bool:
    """Level-one residue field F_q (q = 3 mod 4) of a place of a multiquadratic field, unramified at q:
    every radicand a non-zero square mod q."""
    return q % 4 == 3 and all(legendre(d, q) == 1 for d in radicands)


def ramified_stable(p: int, radicands: list[int]) -> bool:
    """p odd dividing some radicand: the residue field above p is F_p iff every square class prime to p (products of
    radicands with p-part removed as squares) is a residue mod p; the place is stable iff that holds and p = 3 (4)."""
    classes = set()
    for r in range(1, len(radicands) + 1):
        for sub in combinations(radicands, r):
            n = prod(sub)
            # squarefree part
            sf, x = 1, n
            f = 2
            while f * f <= x:
                while x % (f * f) == 0:
                    x //= f * f
                if x % f == 0:
                    sf *= f
                    x //= f
                f += 1
            sf *= x
            if sf % p != 0:
                classes.add(sf)
    return p % 4 == 3 and all(legendre(d, p) == 1 for d in classes)


FIELDS = {
    "Q(sqrt167)": [167],
    "K(sqrt7)=Q(sqrt3,sqrt7,sqrt11)": [3, 7, 11],
    "deGrey K(sqrt5,sqrt7)=Q(sqrt3,sqrt5,sqrt7,sqrt11)": [3, 5, 7, 11],
}


def main() -> int:
    ok = True
    rep: dict = {"kind": "fs91-j08-threshold", "QMAX": QMAX, "table": [], "lists": {}, "fields": {}, "plant": None}
    primes = [q for q in range(3, QMAX) if q % 4 == 3 and is_prime(q)]
    table = {}
    worst_slack = None
    for q in primes:
        kap, cc, arg, ms = kappa(q)
        kmin = fejer_kmin(q)
        good = fejer_allows(q, cc) and cc >= kmin
        ok &= good
        table[q] = (kap, cc, arg, ms)
        rep["table"].append({"q": q, "kappa": str(kap), "chi_char": cc, "argmax_c": arg, "fejer_kmin": kmin,
                             "consistent": good})
        slack = cc - kmin
        if worst_slack is None or slack < worst_slack[0]:
            worst_slack = (slack, q)
    print(f"(1)-(2) {len(primes)} primes q = 3 (4) below {QMAX}: derived Fejer/Weil condition "
          f"{'consistent with every exact chi_char' if ok else 'VIOLATED'}; least slack chi_char - kmin = {worst_slack}")
    print("   q : chi_char (kappa) [Fejer kmin]")
    print("   " + "; ".join(f"{q}:{table[q][1]}({table[q][0]})[{fejer_kmin(q)}]" for q in primes if q < 200))
    for k in (6, 7):
        Qk = 4 * (k - 1) ** 2
        above = [q for q in primes if q >= Qk and table[q][1] <= k]
        ok &= not above
        lst = {q: sorted(c for c, m in table[q][3].items() if k * m >= q) for q in primes if q < Qk}
        lst = {q: cs for q, cs in lst.items() if cs}
        rep["lists"][str(k)] = {"Q_k": Qk, "band_k_below_Q_k": lst, "any_at_or_above_Q_k_up_to_QMAX": above}
        print(f"(3) k={k}: Q_k = {Qk}; band {k}-characters below Q_k at (q: c list): {lst}; at or above Q_k: {above}")
    for name, rad in FIELDS.items():
        ram = sorted({p for d in rad for p in range(3, d + 1) if d % p == 0 and is_prime(p)})
        stable_ram = [p for p in ram if ramified_stable(p, rad)]
        targets = [q for q in primes if q not in ram and usable(q, rad)] + stable_ram
        targets = sorted(set(targets))
        m, rows, bound = None, [], None
        for q in targets:
            if bound is not None and q >= bound:
                break
            rows.append({"q": q, "ramified": q in ram, "chi_char": table[q][1], "kappa": str(table[q][0])})
            if m is None or table[q][1] < m:
                m = table[q][1]
                bound = 4 * (m - 2) ** 2
        decided = bound is not None and bound <= QMAX
        ok &= decided
        rep["fields"][name] = {"radicands": rad, "ramified_odd": ram, "stable_ramified": stable_ram,
                               "targets_examined": rows, "min_chi_char": m, "derived_bound_4(m-2)^2": bound,
                               "decided": decided}
        print(f"(4) {name}: odd ramified {ram} (stable: {stable_ram}); targets below 4(m-2)^2 = {bound}: "
              + ", ".join(f"{r['q']}{'(ram)' if r['ramified'] else ''}:{r['chi_char']}" for r in rows)
              + f"  => min chi_char over level-one targets = {m} {'DECIDED' if decided else 'NOT DECIDED'}")
    # plant: sqrt(q) in place of 2 sqrt(q)
    viol = [q for q in primes if not fejer_allows(q, table[q][1], weil_factor=1)]
    twin = [q for q in primes if not fejer_allows(q, table[q][1], weil_factor=2)]
    rep["plant"] = {"name": "Weil constant 1 instead of 2", "fired": bool(viol), "first_q": viol[:5],
                    "twin_violations": twin}
    ok &= bool(viol) and not twin
    print(f"plant (constant 1): fired={bool(viol)} at q={viol[:5]}; twin violations={twin}")
    rep["ok"] = bool(ok)
    OUT.write_text(json.dumps(rep, indent=1, default=str) + "\n")
    print("ALL OK" if ok else "FAILED", "->", OUT)
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())

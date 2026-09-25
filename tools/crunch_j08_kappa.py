#!/usr/bin/env python3
"""J08 stage 3: the character parameter kappa(Gamma_q) and the complete band lists at q = 23, 43 (k = 6, 7, 8).

By SIX-a (derived in plans/FS91-S1D-six.md stage 2, checked by tools/crunch_j08_sixa.py) the band characters of
Gamma_q are the lambda_a, a != 0, and lambda_a is band k iff min_{t in V_c} |t| >= q/k, c = N(a), with
V_c = {t : t^2 - 4c a non-square or 0}.  So kappa(Gamma_q) = max_c m(c)/q, m(c) = min_{t in V_c} |t| (centred), and
chi_char(Gamma_q) = ceil(1/kappa) = min k with k*m(c) >= q for some c.  The set enumerated is c in F_q^x -- (q-1)
values, fixed by the derivation; nothing is sampled.

Controls:
  * MEASURED cross-check at 23 and 43: for every c, m(c) is recomputed from the circle directly (a with N(a) = c,
    min over x^2+y^2=1 of |2(a1 x - a2 y)|).
  * data/fplane/periodic-below-71.json (row 69): each row's one-direction circulant D must be V_c for some
    non-square c (so Cay(F_p, D) = Cay(F_p, V_c)), and every band k-character gives a circular k-colouring of it, so
    chi_char(Gamma_p) >= chi(C_p) >= chi_circ_lo (the last inequality is that file's UNTRUSTED solver refusal: the
    comparison is a consistency statement, not a proof).
  * PLANT: the law with t^2 + 4c replacing t^2 - 4c must make the measured cross-check fail at 23 (fires at the
    m(c) comparison, naming c); its faithful twin passes.
Writes data/fs91/j08/kappa-23-43.json always.
"""
from __future__ import annotations

import json
import sys
from fractions import Fraction
from math import ceil
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
OUT = ROOT / "data" / "fs91" / "j08" / "kappa-23-43.json"
PERIODIC = ROOT / "data" / "fplane" / "periodic-below-71.json"


def legendre(n: int, q: int) -> int:
    n %= q
    if n == 0:
        return 0
    return 1 if pow(n, (q - 1) // 2, q) == 1 else -1


def centred(t: int, q: int) -> int:
    t %= q
    return t - q if t > q // 2 else t


def V(q: int, c: int, sign: int = -1) -> list[int]:
    """V_c by the law (sign=-1); sign=+1 is the planted t^2 + 4c."""
    return [t for t in range(q) if legendre(t * t + sign * 4 * c, q) in (-1, 0)]


def m_law(q: int, c: int, sign: int = -1) -> int:
    return min(abs(centred(t, q)) for t in V(q, c, sign))


def m_direct(q: int, c: int) -> int:
    circ = [(x, y) for x in range(q) for y in range(q) if (x * x + y * y) % q == 1]
    a = next((a1, a2) for a1 in range(q) for a2 in range(q) if (a1 * a1 + a2 * a2) % q == c)
    return min(abs(centred(2 * (a[0] * x - a[1] * y), q)) for x, y in circ)


def kappa_table(q: int, sign: int = -1) -> dict:
    m = {c: m_law(q, c, sign) for c in range(1, q)}
    best = max(m.values())
    kap = Fraction(best, q)
    chi_char = ceil(Fraction(q, best)) if best > 0 else None
    return {"q": q, "m": m, "kappa": kap, "chi_char": chi_char,
            "argmax_c": sorted(c for c in m if m[c] == best)}


def band_list(q: int, m: dict, k: int) -> list[int]:
    return sorted(c for c, v in m.items() if k * v >= q)


def main() -> int:
    ok = True
    rep = {"kind": "fs91-j08-kappa-23-43", "targets": [], "periodic_file": [], "plant": None}
    for q in (23, 43):
        tab = kappa_table(q)
        md = {c: m_direct(q, c) for c in range(1, q)}
        cross_ok = md == tab["m"]
        ok &= cross_ok
        lists = {k: band_list(q, tab["m"], k) for k in (6, 7, 8)}
        nonsq = [c for c in range(1, q) if legendre(c, q) == -1]
        sq_all_zero = all(tab["m"][c] == 0 for c in range(1, q) if legendre(c, q) == 1)
        ok &= sq_all_zero
        row = {"q": q, "kappa": str(tab["kappa"]), "kappa_float": float(tab["kappa"]), "chi_char": tab["chi_char"],
               "argmax_c": tab["argmax_c"], "m_by_nonsquare_c": {c: tab["m"][c] for c in nonsq},
               "band_lists": lists, "measured_cross_check": cross_ok, "squares_have_m0": sq_all_zero,
               "V_argmax": {c: sorted(centred(t, q) for t in V(q, c)) for c in tab["argmax_c"]}}
        rep["targets"].append(row)
        print(f"q={q}: kappa={tab['kappa']} ({float(tab['kappa']):.5f}), chi_char={tab['chi_char']}, argmax c={tab['argmax_c']}")
        print(f"   m(c) over non-squares: {[tab['m'][c] for c in nonsq]} (c = {nonsq})")
        for k in (6, 7, 8):
            print(f"   band {k}: c in {lists[k]}  (need m(c) >= {q}/{k} = {q/k:.3f})")
        print(f"   measured cross-check (direct circle) {'AGREES' if cross_ok else 'DISAGREES'}; squares m=0: {sq_all_zero}")
    # the periodic-colouring file
    per = json.loads(PERIODIC.read_text())
    for r in per["rows"]:
        p, D = r["p"], set(r["D"])
        if p % 4 != 3:
            continue
        cs = [c for c in range(1, p) if set(V(p, c)) == D]
        tab = kappa_table(p)
        consistent = tab["chi_char"] is None or tab["chi_char"] >= r["chi_circ_lo"]
        ok &= bool(cs) and all(legendre(c, p) == -1 for c in cs)
        rep["periodic_file"].append({"p": p, "D_equals_V_c_for_c": cs, "chi_circ_lo_untrusted": r["chi_circ_lo"],
                                     "chi_circ_verified": r["chi_circ"], "chi_char": tab["chi_char"],
                                     "kappa": str(tab["kappa"]), "chi_char_ge_chi_circ_lo": consistent})
        print(f"file p={p}: D = V_c for c={cs}; chi_circ in [{r['chi_circ_lo']},{r['chi_circ']}] (lo untrusted); "
              f"chi_char={tab['chi_char']} kappa={tab['kappa']} {'consistent' if consistent else 'INCONSISTENT'}")
    # plant
    q = 23
    planted = kappa_table(q, sign=+1)["m"]
    twin = kappa_table(q, sign=-1)["m"]
    md = {c: m_direct(q, c) for c in range(1, q)}
    fired = [c for c in range(1, q) if planted[c] != md[c]]
    twin_ok = twin == md
    rep["plant"] = {"name": "law with t^2+4c at q=23", "fired": bool(fired), "first_c": fired[:3], "twin_passed": twin_ok}
    ok &= bool(fired) and twin_ok
    print(f"plant t^2+4c at 23: fired={bool(fired)} at c={fired[:3]}; twin passed={twin_ok}")
    rep["ok"] = bool(ok)
    OUT.write_text(json.dumps(rep, indent=1, default=str) + "\n")
    print("ALL OK" if ok else "FAILED", "->", OUT)
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())

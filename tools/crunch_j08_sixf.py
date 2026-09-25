#!/usr/bin/env python3
"""J08 stage 6 (SIX-f): band-1/6 torsion characters of Q = Z[i][1/p : p = 1 (4)] -- the finite data the derivation needs.

The derivation (plans/FS91-S1D-six.md stage 6, J08-9) reduces theta = tau + alpha in Theta_6(Q) to a SUMSET condition
    [-r, r] + sum_v C_v  subset  B_6 = [1/6, 5/6],     C_v = tau_v(T(Z_v)),
over the stable places v of Q(i) (weak approximation on the rational torus x^2 + y^2 = 1), with tau_2 of order | 8,
tau_3 of level <= 3 (order | 27), tau_q of level 1 at odd q >= 7, and q in {7, 11, 19} or in the ANTI-BAND list below.
This tool computes, exactly:
  (1) the anti-band list: q = 3 (4) prime < 100 and c in F_q with V_c inside {t : ||t/q|| <= 1/3} (a parity-shifted
      level-one character, 1/2 + C_q in B_6);
  (2) T(Z_2) mod 8 (reduced from the solutions mod 64, which all lift) and T(Z_3) mod 27;
  (3) the value-set classes of every character of Z[i]/8, Z[i]/27, Z[i]/q (q in the place list);
  (4) the complete list of place-tuples (one class per place, zero allowed) whose sumset lies in B_k, with r_max =
      min ||s|| - 1/k, by exhaustive product with early exit -- for k = 4 (the CONTROL: must return exactly Lemma N0's
      types, FS89-S0A-3) and for k = 6 (the result).
Plants: (P1) T mod 8 taken as all congruence solutions (32 points, not the 8 that lift) -- the lift check must refuse it;
(P2) the k = 4 control run with the band [1/5, 4/5] must NOT reproduce N0 (fires by the type list differing).
Writes data/fs91/j08/sixf.json always.
"""
from __future__ import annotations

import itertools
import json
import sys
from fractions import Fraction
from math import gcd
from pathlib import Path

OUT = Path(__file__).resolve().parent.parent / "data" / "fs91" / "j08" / "sixf.json"


def legendre(n, q):
    n %= q
    return 0 if n == 0 else (1 if pow(n, (q - 1) // 2, q) == 1 else -1)


def is_prime(n):
    return n > 1 and all(n % p for p in range(2, int(n ** 0.5) + 1))


def V(q, c):
    return [t for t in range(q) if legendre(t * t - 4 * c, q) in (-1, 0)]


def anti_band(q):
    return [c for c in range(1, q) if all(3 * min(t, q - t) <= q for t in V(q, c))]


def circle_mod(M):
    return [(x, y) for x in range(M) for y in range(M) if (x * x + y * y) % M == 1]


def T_mod8(planted=False):
    if planted:
        return circle_mod(8)
    return sorted({(x % 8, y % 8) for x, y in circle_mod(64)})


def classes(M, pts, D):
    """characters (u, v) of (Z/M)^2, value set on pts as residues mod D -> class -> list of (u, v)."""
    out: dict = {}
    for u in range(M):
        for v in range(M):
            vals = frozenset(((u * x + v * y) % M) * (D // M) % D for x, y in pts)
            out.setdefault(vals, []).append((u, v))
    return out


def order(M, u, v):
    return M // gcd(gcd(u, v), M)


def run(k, places, D):
    """All tuples of classes (one per place, the zero class allowed) whose full sumset avoids the open arc
    (-1/k, 1/k), i.e. lies in the closed band B_k; exhaustive over the product, a DFS with early exit on the first
    sum inside the arc.  Returns (combo, r_max = min ||s|| - 1/k)."""
    lo_num = D  # compare k*min(s, D-s) >= D
    keys = [sorted(cl.keys(), key=len) for _, cl in places]
    lists = [[sorted(c) for c in kk] for kk in keys]
    passing = []
    n = len(places)
    for idx in itertools.product(*[range(len(kk)) for kk in keys]):
        sets = [lists[i][j] for i, j in enumerate(idx)]
        best = [D]
        fail = False
        stack = [(0, 0)]
        while stack:
            depth, acc = stack.pop()
            if depth == n:
                d = min(acc, D - acc)
                if k * d < lo_num:
                    fail = True
                    break
                if d < best[0]:
                    best[0] = d
                continue
            for x in sets[depth]:
                stack.append((depth + 1, (acc + x) % D))
        if not fail:
            combo = tuple(keys[i][j] for i, j in enumerate(idx))
            passing.append((combo, Fraction(best[0], D) - Fraction(1, k)))
    return passing


def describe(combo, places, M_of):
    parts = []
    for (name, cl), cset in zip(places, combo):
        chars = cl[cset]
        if cset == frozenset({0}):
            continue
        M = M_of[name]
        orders = sorted({order(M, u, v) for u, v in chars})
        parts.append(f"{name}:ord{orders}x{len(chars)}")
    return " + ".join(parts) if parts else "0"


def main():
    ok = True
    rep = {"kind": "fs91-j08-sixf"}
    ab = {q: anti_band(q) for q in range(3, 108) if q % 4 == 3 and is_prime(q)}
    ab = {q: cs for q, cs in ab.items() if cs}
    rep["anti_band"] = ab
    print("(1) anti-band list (q < 108, c with V_c inside ||t/q|| <= 1/3):", ab)
    t8 = T_mod8()
    t8_ok = set(t8) == {(1, 0), (7, 0), (1, 4), (7, 4), (0, 1), (0, 7), (4, 1), (4, 7)}
    t8p = T_mod8(planted=True)
    p1_fired = set(t8p) != set(t8)
    t27 = circle_mod(27)
    print(f"(2) T mod 8 = {t8} (N0's list: {t8_ok}); plant P1 (all 32 congruence solutions) fired: {p1_fired}; |T mod 27| = {len(t27)}")
    ok &= t8_ok and p1_fired and len(t27) == 36
    odd = sorted({7, 11, 19} | set(ab) - {3})
    moduli = {"2": 8, "3": 27, **{str(q): q for q in odd}}
    D = 1
    for M in moduli.values():
        D = D * M // gcd(D, M)
    pts = {"2": t8, "3": t27, **{str(q): circle_mod(q) for q in odd}}
    places = [(n, classes(M, pts[n], D)) for n, M in moduli.items()]
    rep["places"] = {n: {"modulus": moduli[n], "classes": len(cl)} for n, cl in places}
    print("(3) places and value-set classes:", {n: len(cl) for n, cl in places}, "D =", D)
    ncombo = 1
    for _, cl in places:
        ncombo *= len(cl)
    print(f"    product of class counts: {ncombo}")
    rep["product"] = ncombo
    M_of = moduli
    results = {}
    for k in (4, 5, 6):
        passing = run(k, places, D)
        rows = []
        for combo, rmax in passing:
            desc = describe(combo, places, M_of)
            nchars = 1
            for (name, cl), cset in zip(places, combo):
                nchars *= len(cl[cset])
            repr_chars = {name: list(cl[cset][0]) for (name, cl), cset in zip(places, combo) if cset != frozenset({0})}
            peel = [name for (name, cl), cset in zip(places, combo)
                    if cset != frozenset({0}) and all(k * min(x, D - x) >= D for x in cset)]
            rows.append({"type": desc, "characters": nchars, "r_max": str(rmax), "r_max_float": float(rmax),
                         "representative": repr_chars, "moduli": {n: M_of[n] for n in repr_chars},
                         "band_summands": peel})
        rows.sort(key=lambda r: (-r["r_max_float"], r["type"]))
        peel_ok = all(r["band_summands"] for r in rows)
        ok &= peel_ok
        print(f"    band 1/{k}: every passing tuple has a summand whose value set lies in the band (the n-fold peeling lemma's conclusion): {peel_ok}")
        results[k] = rows
        print(f"(4) band 1/{k}: {len(rows)} passing class-tuples ({sum(r['characters'] for r in rows)} torsion characters tau != 0 up to the zero tuple)")
        for r in rows:
            print(f"      {r['type']:<60} chars={r['characters']:<6} r_max={r['r_max']}")
    rep["results"] = {str(k): v for k, v in results.items()}
    # CONTROL: band 1/4 must be exactly Lemma N0's types (FS89-S0A-3): 2-part of order | 8, order 3 at 3 (r <= 1/12),
    # order 7 at 7 (r <= 1/28); nothing mixed, nothing at 11, 19, nothing of 3-level >= 2.
    def n0_check(rows):
        types = {r["type"] for r in rows}
        shape = all(("+" not in t) and (t.startswith("2:") or t.startswith("3:ord[3]") or t.startswith("7:ord[7]"))
                    for t in types)
        present = all(any(t.startswith(p) for t in types) for p in ("2:", "3:", "7:"))
        r3 = all(Fraction(r["r_max"]) == Fraction(1, 12) for r in rows if r["type"].startswith("3:"))
        r7 = all(Fraction(r["r_max"]) == Fraction(1, 28) for r in rows if r["type"].startswith("7:"))
        return shape and present and r3 and r7
    n0_ok = n0_check(results[4])
    print(f"CONTROL band 1/4 == Lemma N0's types (2-part | 8; order 3 with r=1/12; order 7 with r=1/28; nothing mixed): {n0_ok}")
    rep["control_N0"] = n0_ok
    ok &= n0_ok
    # PLANT P2: the same test applied to the band-1/5 list must fail (it is not N0's list)
    p2_fired = not n0_check(results[5])
    print(f"plant P2 (band 1/5 in place of 1/4 must not pass as N0): fired={p2_fired}")
    rep["plant_P2_fired"] = p2_fired
    ok &= p2_fired
    # the middle-third Fejer cut: for every prime q = 3 (4) in [107, 10^6], no c can have V_c inside ||t/q|| <= 1/3,
    # because V_c would miss L' consecutive residues (q/3 < t < 2q/3) and Fejer with |A| = floor((L'+1)/2) forbids it.
    viol = []
    for q in range(107, 10**6):
        if q % 4 != 3:
            continue
        Lp = -(-2 * q // 3) - (q // 3) - 1          # integers t with q/3 < t < 2q/3
        LA = (Lp + 1) // 2
        if LA * LA * (q + 1) ** 2 <= 4 * q * (q - LA) ** 2:   # the Fejer inequality would ALLOW it
            viol.append(q)
    print(f"middle-third Fejer cut holds for every q = 3 (4) in [107, 10^6]: {not viol} (first exceptions {viol[:5]})")
    rep["middle_third_cut_107_to_1e6"] = not viol
    ok &= not viol
    # zero tuple must never pass (tau = 0 impossible needs alpha; here r_max would be -1/k) -- positive signal
    rep["ok"] = bool(ok)
    OUT.write_text(json.dumps(rep, indent=1, default=str) + "\n")
    print("ALL OK" if ok else "FAILED", "->", OUT)
    return 0 if ok else 1


if __name__ == "__main__":
    sys.exit(main())

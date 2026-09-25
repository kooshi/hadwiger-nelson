#!/usr/bin/env python3
"""J08 stage 2: check SIX-a's value-set law against a direct enumeration of the unit circle.

SIX-a (plans/FS91-character-local-global.md §S "J08"): for a prime q = 3 (mod 4), every band k-character of
Gamma_q = Cay(F_{q^2}, mu_{q+1}) is lambda_a(x) = Tr(a x)/q for some a != 0, and lambda_a is band k iff no
t in V_{N(a)} has |t| < q/k (t read in (-q/2, q/2)), where V_c = {t in F_q : t^2 - 4c is a non-square or 0}.

This tool is the MEASURED half: F_{q^2} = F_q[i], mu_{q+1} = {(x, y) : x^2 + y^2 = 1}, Tr(w) = 2 Re(w), so for
a = a1 + i a2 and z = x + i y, Tr(a z) = 2 (a1 x - a2 y). For every a != 0 it compares, exactly:
  (1) the multiset {Tr(a z) : z in mu_{q+1}} with the DERIVED law m_c(t) = 2 / 1 / 0 as t^2 - 4c is a non-square /
      zero / a non-zero square, c = N(a) = a1^2 + a2^2;
  (2) the direct band-k test (min over the circle of |Tr(a z)| >= q/k) with the law's band test, k = 3..12;
  (3) that a -> (u, v) = (2 a1, -2 a2) is a bijection onto Hom(F_q^2, Z/q) = {(x, y) -> u x + v y}.
Plants (each must fire, at the value-set comparison, naming (q, a, t)): P1 the law with t^2 + 4c; P3 the direct
enumeration with the wrong trace a1 x + a2 y. Each plant is paired with a faithful twin that must pass.
Also printed (float, sanity only; the Weil input used above the threshold in stage 4): max over a != 0 of the
modulus of sum_z e(Tr(a z)/q), against 2 sqrt(q).

Writes data/fs91/j08/sixa-check.json always (the positive signal, null or not). Exit 0 iff every check passed and
every plant fired; 1 otherwise.
"""
from __future__ import annotations

import cmath
import json
import math
import sys
from pathlib import Path

OUT = Path(__file__).resolve().parent.parent / "data" / "fs91" / "j08" / "sixa-check.json"
PRIMES = [3, 7, 11, 19, 23, 31, 43, 47, 59, 67]


def legendre(n: int, q: int) -> int:
    n %= q
    if n == 0:
        return 0
    return 1 if pow(n, (q - 1) // 2, q) == 1 else -1


def circle(q: int) -> list[tuple[int, int]]:
    return [(x, y) for x in range(q) for y in range(q) if (x * x + y * y) % q == 1]


def centred(t: int, q: int) -> int:
    t %= q
    return t - q if t > q // 2 else t


def law_mult(q: int, c: int, sign: int = -1) -> list[int]:
    """Derived multiplicity of t; sign=-1 is SIX-a's t^2 - 4c, sign=+1 the planted t^2 + 4c."""
    out = []
    for t in range(q):
        d = (t * t + sign * 4 * c) % q
        leg = legendre(d, q)
        out.append(2 if leg == -1 else (1 if leg == 0 else 0))
    return out


def direct_mult(q: int, circ, a1: int, a2: int, wrong_trace: bool = False) -> list[int]:
    m = [0] * q
    for x, y in circ:
        t = (a1 * x + a2 * y) % q if wrong_trace else (2 * (a1 * x - a2 * y)) % q
        m[t] += 1
    return m


def band_direct(q: int, circ, a1: int, a2: int, k: int) -> bool:
    return all(k * abs(centred(2 * (a1 * x - a2 * y), q)) >= q for x, y in circ)


def band_law(q: int, c: int, k: int) -> bool:
    m = law_mult(q, c)
    return all(k * abs(centred(t, q)) >= q for t in range(q) if m[t] > 0)


def first_mismatch(q, circ, law_sign, wrong_trace):
    for a1 in range(q):
        for a2 in range(q):
            if a1 == 0 and a2 == 0:
                continue
            c = (a1 * a1 + a2 * a2) % q
            dm = direct_mult(q, circ, a1, a2, wrong_trace)
            lm = law_mult(q, c, law_sign)
            if dm != lm:
                t = next(t for t in range(q) if dm[t] != lm[t])
                return {"q": q, "a": [a1, a2], "c": c, "t": t, "direct": dm[t], "law": lm[t]}
    return None


def main() -> int:
    report = {"kind": "fs91-j08-sixa-check", "primes": PRIMES, "per_q": [], "plants": {}, "ok": False}
    all_ok = True
    for q in PRIMES:
        assert q % 4 == 3
        circ = circle(q)
        assert len(circ) == q + 1, (q, len(circ))
        mism = first_mismatch(q, circ, -1, False)
        band_checks = band_bad = band_pos = 0
        for a1 in range(q):
            for a2 in range(q):
                if a1 == 0 and a2 == 0:
                    continue
                c = (a1 * a1 + a2 * a2) % q
                for k in range(3, 13):
                    band_checks += 1
                    bd = band_direct(q, circ, a1, a2, k)
                    band_pos += bd
                    if bd != band_law(q, c, k):
                        band_bad += 1
        uv = {((2 * a1) % q, (-2 * a2) % q) for a1 in range(q) for a2 in range(q)}
        bijective = len(uv) == q * q
        # Weil sanity (float): max_{a != 0} |sum_z e(Tr(az)/q)|
        mx = 0.0
        for a1 in range(q):
            for a2 in range(q):
                if a1 == 0 and a2 == 0:
                    continue
                s = sum(cmath.exp(2j * math.pi * (2 * (a1 * x - a2 * y) % q) / q) for x, y in circ)
                mx = max(mx, abs(s))
        row = {"q": q, "circle_points": len(circ), "a_checked": q * q - 1, "value_set_mismatch": mism,
               "band_checks": band_checks, "band_true_direct": band_pos, "band_mismatches": band_bad, "hom_bijection": bijective,
               "max_eigen_abs": round(mx, 6), "two_sqrt_q": round(2 * math.sqrt(q), 6),
               "weil_margin": round(2 * math.sqrt(q) - mx, 6)}
        report["per_q"].append(row)
        ok = mism is None and band_bad == 0 and bijective and mx <= 2 * math.sqrt(q) + 1e-9
        all_ok &= ok
        print(f"q={q:3d} a={q*q-1:5d} value-set {'OK' if mism is None else 'MISMATCH '+str(mism)} "
              f"band {band_checks - band_bad}/{band_checks} (true {band_pos}) bij={bijective} max|mu|={mx:.4f} <= 2sqrt(q)={2*math.sqrt(q):.4f}")
    # plants, each with a faithful twin; fired = mismatch found AT the value-set comparison
    for name, sign, wrong in [("P1_law_t2_plus_4c", +1, False), ("P3_wrong_trace", -1, True)]:
        fired_at = None
        twin_pass = True
        for q in [7, 11, 23]:
            circ = circle(q)
            m = first_mismatch(q, circ, sign, wrong)
            if m is not None and fired_at is None:
                fired_at = m
            twin_pass &= first_mismatch(q, circ, -1, False) is None
        report["plants"][name] = {"fired": fired_at is not None, "first_mismatch": fired_at, "faithful_twin_passed": twin_pass}
        all_ok &= fired_at is not None and twin_pass
        print(f"plant {name}: fired={fired_at is not None} at {fired_at}; twin passed={twin_pass}")
    report["ok"] = bool(all_ok)
    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text(json.dumps(report, indent=1) + "\n")
    print("ALL OK" if all_ok else "FAILED", "->", OUT)
    return 0 if all_ok else 1


if __name__ == "__main__":
    sys.exit(main())

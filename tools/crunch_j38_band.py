#!/usr/bin/env python3
"""J38 (crunch 2026-09-25): does the tight dyadic place of a type-(B) field carry four-colour band characters?

Question (owner item 3 of J38's launch): is ℚ(√59)'s ring a four-colourable unit-distance lattice with Θ₄ = ∅?
By CLG (row 100) a band 4-character of R_F exists iff some stable place carries one at some level; FS86-C-deBruijn
§7.2 names one at the dyadic place (the ℤ/4 colouring, G41). This script checks that exactly, at the local level.

Setting (fixed by derivation, not searched): for F = ℚ(√59), ℚ(√83), ℚ(√131) (d ≡ 3 mod 8, 2 ramified in F),
F_𝔭 = ℚ₂(√d) = ℚ₂(√3) and L_𝔓 = F_𝔭(i) = ℚ₂(ζ₁₂), unramified over F_𝔭. O = ℤ₂[ζ₁₂] = ℤ₂[x]/(x⁴ − x² + 1),
conjugation x ↦ x⁻¹ = x − x³ (fixes x + x⁻¹ = √3). 𝔓⁴ = 4O, so O/𝔓⁴ = (ℤ/4)⁴. The norm-one units are
{w/w̄ : w ∈ O^×} (Hilbert 90 for units in an unramified extension), so S_N := T(O) mod N = {w·w̄⁻¹ mod N}.
Row 88 (π₄ : R → O/𝔓⁴ onto, U onto S₄ by weak approximation) makes S₄ the image of the global unit vectors.
A character of (ℤ/N)⁴ is θ_c(a) = c·a / N; it is band-4 iff θ_c(s) ∈ [1/4, 3/4] mod 1 for every s ∈ S_N.

A complete exact enumeration over a finite set a derivation fixed (standing rule 3, "at the edge"): N⁴ characters
against |S_N| elements, N ∈ {2, 4, 8}. Seconds.

Controls and plant:
- asserts |S₄| = 24 (row 111's "8 of the 24 residue classes of U mod 𝔓⁴") and that (2x − x³)² = 3;
- control: at N = 2 (O/2O = O/𝔓², its quotient 𝔽₄ being K₄ = U₂) the parity argument predicts 0 band characters;
- plant (--plant): puts 0 into S₄; the band count must drop to 0, else the band test is not reading S.
"""
import itertools
import math
import sys


def mul(a, b, n):
    # (a0 + a1 x + a2 x^2 + a3 x^3)(b...) with x^4 = x^2 - 1, x^5 = x^3 - x, x^6 = -1
    c = [0] * 7
    for i in range(4):
        for j in range(4):
            c[i + j] += a[i] * b[j]
    # reduce x^6 = -1, x^5 = x^3 - x, x^4 = x^2 - 1
    r = c[:4]
    r[0] -= c[6]           # x^6 -> -1
    r[3] += c[5]; r[1] -= c[5]   # x^5 -> x^3 - x
    r[2] += c[4]; r[0] -= c[4]   # x^4 -> x^2 - 1
    return tuple(v % n for v in r)


def bar(a, n):
    # x̄ = x - x^3, x̄^2 = 1 - x^2, x̄^3 = -x^3
    a0, a1, a2, a3 = a
    r = [a0 + a2, a1, -a2, -a1 - a3]
    return tuple(v % n for v in r)


def ring(n):
    return list(itertools.product(range(n), repeat=4))


def circle(n):
    els = ring(n)
    one = (1 % n, 0, 0, 0)
    g = n ** 4 * 3 // 4  # |(O/nO)^x| for n a power of 2: the residue field is F_4

    def pw(a, e):
        r, b = one, a
        while e:
            if e & 1:
                r = mul(r, b, n)
            b = mul(b, b, n)
            e >>= 1
        return r

    inv = {}
    for a in els:
        if pw(a, g) == one:
            inv[a] = pw(a, g - 1)
    return sorted({mul(w, inv[bar(w, n)], n) for w in inv})


def band_count(S, n):
    lo, hi = n / 4, 3 * n / 4
    out = []
    for c in ring(n):
        if all(lo <= (sum(ci * si for ci, si in zip(c, s)) % n) <= hi for s in S):
            out.append(c)
    return out


def main():
    plant = "--plant" in sys.argv
    sq = mul((0, 2, 0, -1), (0, 2, 0, -1), 64)
    assert sq == (3, 0, 0, 0), sq
    for n in (2, 4, 8):
        S = circle(n)
        if plant and n == 4:
            S = S + [(0, 0, 0, 0)]
        B = band_count(S, n)
        orders = sorted({n // math.gcd(n, *c) for c in B})
        print(f"N={n}: |S_N|={len(S)}  band-4 characters of O/NO: {len(B)}  orders: {orders}")
        if n == 2:
            assert len(B) == 0, "control: parity predicts no band character at O/2O"
        if n == 4:
            if plant:
                assert len(B) == 0, "PLANT DID NOT FIRE: 0 in S4 must kill every band character"
                print("plant fired: 0 in S4 leaves no band character")
                return
            assert len(S) == 24, f"|S4| = {len(S)}, row 111 says 24"
            assert len(B) > 0, "no band-4 character at the dyadic level 4"
    print("OK")


if __name__ == "__main__":
    main()

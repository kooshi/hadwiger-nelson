# FS-8 — The Haugland 7-adic check: does the heptagonal 5-forcer live in a 4-sealed field? (STUB, 2026-09-06)

*Minted on the finite-plane pivot (`reference/Chat-analysis/analysis.txt` corollary (3), VERIFIED framework in
`reference/Chat-analysis/VERIFICATION.md`). Read beside this: `plans/M58-field-sieve.md` (the theorem and the sieve),
`BIBLIOGRAPHY.md` [Haugland2026], `CLAUDE.md` G3/G7/G11 (what the project believes about his construction).*

## 1. Mission context, in plain language

Haugland (arXiv:2608.04542, 2026) claims a 2,131-vertex 5-chromatic unit-distance graph on a HEPTAGONAL fabric (ring
radii 1/sin(2kπ/7), a cubic field ℚ(cos 2π/7) with square roots adjoined by the detuning), verified by floating-point
geometry plus an uncertified SAT refutation. The finite-plane bound says: if all his coordinates lie in a field F with a
prime above 7 of odd residue degree (7 is totally ramified in ℚ(ζ₇), so its real subfield has a degree-one prime above
7; adjoining square roots either keeps a degree-one prime or makes 7's residue degree 2), then every unit-distance graph
in F² maps into UD(𝔽₇, 2), whose chromatic number is 4 (Vinh 2005 by computer; reproduced here) — and his graph would be
4-colourable, contradicting the claim. So either his detuning adjoins a radical that is a non-square mod 7 (making 7
have residue degree 2, the theorem silent), or the verification is wrong. Either outcome is worth knowing before any
import of his object (G3's falsifier, G11's scope).

## 2. What we know

| fact | where |
|---|---|
| χ(UD(𝔽₇, 2)) = 4: k = 3 refused, a verified 4-colouring | `tools/fplane.py self-test`; Vinh 2005 |
| the theorem needs p ≡ 3 (mod 4) and ODD residue degree; for a cubic field with square roots adjoined the residue degree at 7 is 1, 2, 3 or 6 — odd iff no adjoined radical is a non-square mod 7 (7 ramifies in the cubic part, residue degree 1 there) | `reference/Chat-analysis/VERIFICATION.md` §1; D1 below |
| Haugland's construction is G₁ (a virtual edge at √3, 740 vertices) → G₂ (a forced-equal pair at distance 2) → a ρ₁₅ spindle; ρ₁₅ = (7 + i√15)/8 adjoins √15 — 15 ≡ 1 (mod 7), a square: it does NOT break the 7-adic seal | `CLAUDE.md` G7; 15 mod 7 = 1 = 1² |
| his coordinates are NOT held here (the paper's data must be fetched) | `BIBLIOGRAPHY.md` [Haugland2026] |

## 3. Derivations first

**D1 — the residue degree at 7 of his field.** Write his field as ℚ(cos 2π/7)(√d₁, …, √d_m). In ℚ(cos 2π/7), 7 = 𝔭³
totally ramified with residue field 𝔽₇. Each √dᵢ (dᵢ ∈ ℚ(cos 2π/7) — the ring radii and the detuning) either keeps 𝔭's
residue field (dᵢ a square mod 𝔭, or dᵢ ∈ 𝔭) or doubles it. So compute each dᵢ modulo 𝔭 (reduce cos 2π/7 to its residue:
Φ₇ ≡ (x − 1)⁶ mod 7, so ζ₇ ≡ 1 and cos 2π/7 ≡ 1 mod 𝔭) and take the Legendre symbol mod 7. The seal stands iff every
dᵢ is a square or zero mod 𝔭.

**D2 — the direct test, if the coordinates are in hand.** Reduce every vertex modulo 𝔭 (denominators must be prime to
7 after translating a vertex to 0 — the theorem guarantees it if the field is sealed; a denominator divisible by 7 is
itself the sign that the field is not sealed), check every listed unit edge lands on the circle of 𝔽₇², and pull back
the 4-colouring of UD(𝔽₇,2): a proper 4-colouring of his 2,131 vertices refutes his claim outright, with a certificate
he can check by hand.

## 4. Phases

| phase | what | cost |
|---|---|---|
| 0 | fetch the paper's data (coordinates, edges) into `~/source/library/`; D1 on his stated field | an hour |
| A | if sealed: D2 — the reduction and pullback (`tools/fplane.py reduce` needs a frame for his cubic field: an exact representation over ℚ(cos 2π/7)(√…)); the verified 4-colouring or the failure of the homomorphism | half a day |
| B | if not sealed: record which radical breaks the seal (the detuning parameter θ ≈ 0.4236's field), and whether his field has a usable prime at all | an hour |

## 5. Registered predictions

| # | prediction | confidence |
|---|---|---|
| P1 | his field is NOT 7-sealed: the detuning adjoins a radical that is a non-square mod 7 (his construction is a 5-forcer built by people who checked it, and the ρ₁₅ step alone does not break the seal, so the break must be in the detuning) | medium |
| P2 | if it IS sealed, the pulled-back 4-colouring is proper on his edge list and his verification is wrong | conditional, high |

## 6. Failure clauses

P1 refuted and P2 met: report to Kooshi before anything else — an external claim falsified with a hand-checkable
certificate is a publication-bar event in his sense ("interesting enough"), and a courtesy to the author. P1 met: G11
stands; note the seal-breaking radical in the bibliography entry.

## 7. Bearing on 6, honestly

Low-medium. It is a check of the finite-plane theorem's reach on an external object and a scope correction for G3/G7/G11;
it produces no 6-object. Cheap.

## 8. Addresses

`tools/fplane.py` (`chi --p 7`, `reduce` — a cubic-field frame to add), `reference/Chat-analysis/`, `BIBLIOGRAPHY.md`.

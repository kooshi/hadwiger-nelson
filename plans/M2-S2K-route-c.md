# M2-S2K — FS-39 route C in the kernel: transcendence is free (crunch job J15)

*Kernel engineer: de Bruijn (Opus 5.5), 2026-09-25. Brief: `data/crunch-2026-09-25/briefs/J15-M2-route-c-kernel.md` (with
`STANDING-RULES.md`). Plan: `plans/M2-kernel-lane.md` §2.1–2.2, §3.2, §4.4. Skeleton: `data/m2/j04/K2Transcendental.lean`. Working files:
`data/m2/j15/`.*

## Theorems this phase proved

| theorem | grade | address |
|---|---|---|
| `zeroIntegral` is a subring of `RatFunc F` (rational functions whose reduced denominator does not vanish at `0`) and `evalZero` is a ring hom from it onto `F` (evaluation at `t = 0`) | kernel (scratch, `lake env lean`) | `data/m2/j15/PriceRouteII.lean` |

## Stage 1 — SAVED

### 1.1 The quotation check (standing rule 5)

| # | quoted in the brief | source | result |
|---|---|---|---|
| Q1 | G63: "For any `F ⊆ ℝ` and any `t` transcendental over `F`, **`χ(F(t)²) = χ(F²)`**." | `CLAUDE.md` G63 | verbatim |
| Q2 | Fischer's Thm 6 (held PDF, p. 188): "F^d can be k-colored (has an additive k-coloring) iff F(α)^d can" | `~/source/library/papers/1-s2.0-0012365X9090324B-main.pdf`, p. 188, read by `pdftotext` | a faithful truncation. The full sentence: "Theorem 6. Let α be a real number transcendental over the field F ⊂ ℝ. Then F^d can be k-colored (has an additive k-coloring) iff F(α)^d can be k-colored (has an additive k-coloring)." Its proof is "Setting x = 0 …" on `C₀(F(α)^d)`, as the plan says |
| Q3 | "`data/m2/j04/K2Transcendental.lean` (elaborates today; `planeOverIso` and `unitQuadrance_colorable_of_subring` closed)" | the file, elaborated at stage 1 (`slot.py --mem 8 --cpus 4 -- lake env lean`, 2.54 s wall, 3.37 GB peak) | true: no error; `sorry` warnings on the seven J15 declarations only |
| Q4 | "the core theorem is `chromaticNumber_unitQuadrance_ratFunc {F} [Field F] [IsFormallyReal F]`" (inhabitant `F = ℚ`); "`chromaticNumber_planeOver_adjoin_transcendental_eq` its corollary, the adjunction defined with no proof argument"; "the Liouville inhabitant (π's transcendence is not in Mathlib)" | `plans/M2-kernel-lane.md` §4.4 domain items 4–5, experience item 1; §2.2 | verbatim (item 4's statement; item 5's "no proof in a definition"); π: §2.2's query row |
| Q5 | "`colorable_unitDistance_induce_of_valuationSubring` does not fit: its colours are a finite ring's elements; the route is `cosetResidue` + `unitQuadrance_colorable_of_ringHom`" | `plans/M2-kernel-lane.md` §2.1 row; `Proofs/HadwigerNelson/ResidueColouring.lean:599` | true: its conclusion is `Colorable (Fintype.card G)` with `[Fintype G]` |
| Q6 | §4.4 obligation item 3: "the general valuation lemma, 15 lines, and the one named leaf: a residue ring hom `B →+* F` from the `X`-adic valuation subring of `RatFunc F` whose kernel is `B.nonunits`" | `plans/M2-kernel-lane.md` §4.4 obligation item 3 | verbatim in substance (the plan says "whose kernel is `B.nonunits`"; the brief quotes it) |
| Q7 | Mathlib names: `polynomialValuationX`, `powerSeriesRingEquiv`, `coe_coe`, `liftRingHom`, `liftRingHom_injective`, `IsFormallyReal`, `ValuationSubring` | pinned Mathlib: `RingTheory/LaurentSeries.lean:462, 1179, 375`; `FieldTheory/RatFunc/Basic.lean:435, 468`; `Algebra/Ring/IsFormallyReal.lean:104`; `RingTheory/Valuation/ValuationSubring.lean:41` | all exist at those addresses |
| Q8 | "`χ(ℚ²) = 2` is **not** in the kernel (row 63)" | `LEDGER.md` row 63: "its plane and valuation forms have **no instance over a real field yet**" | true |
| Q9 | owner's news: J17 found `ℚ(π, √(π³ − π))`, a finitely generated real field that is not purely transcendental over a number field, whose plane is two-colourable | `plans/M2-S1D-bridge.md` §2.3 (C3, C3′) | true as quoted. **Bearing on J15:** none on the statement — route C is stated for `F(t)`, `t` transcendental over `F`, and never mentions Remark 1 or "purely transcendental". J17's C3′ is the same valuation argument at a degree-one place of an elliptic function field, so J15 states the valuation lemma for **any** valuation subring whose residue ring has no square root of `−1` (§1.4), which covers C3′'s integrality step as a special case |

**A correction owed** (to `plans/M2-kernel-lane.md` §2.2, row "K2: `F(t)` as rational functions"): the row reads "not found: an
`IntermediateField.adjoin F {t} ≃ RatFunc F` equivalence (queried `RatFunc` in `FieldTheory/IntermediateField`, `Adjoin*`: none)". It exists:
**`RatFunc.algEquivOfTranscendental (f : L) (h : Transcendental K f) : RatFunc K ≃ₐ[K] K⟮f⟯`** (`FieldTheory/RatFunc/AsPolynomial.lean:229`),
with `algEquivOfTranscendental_X` and `_algebraMap`. The query looked in the wrong directory. Consequence: the adjunction is
`(IntermediateField.adjoin F {t}).toSubfield` — no proof argument, no `fieldRange` — and its lift equivalence is Mathlib's.

### 1.2 C0 — the registered predictions, before any derivation

| id | registered (`plans/M2-kernel-lane.md` §4.3, verbatim) | p (planner) | J15's prior now | scored |
|---|---|---|---|---|
| P-J15a | "J15 closes the integrality leaf with no hypothesis left (else lands the residue iso as a named hypothesis, 0.35; else neither, 0.10)" | 0.55 | 0.85, after §1.3's pricing | at stage 4 |
| P-J15b | "Mathlib already holds an identification of the residue field of the `X`-adic valuation subring of `RatFunc K` with `K` (through `powerSeriesRingEquiv` or directly)" | 0.30 | — | **FALSE, scored now.** Queries at the pinned Mathlib: `grep -rln ResidueField Mathlib \| xargs grep -ln 'RatFunc\|idealX\|LaurentSeries\|PowerSeries'` returns only `EllipticCurve/LFunction`, `PowerSeries/WeierstrassPreparation`, `PowerSeries/Inverse`, `QuasiFinite/*`, `LocalRing/ResidueField/Polynomial` — the last is `κ(I[X]) ≃ κ(I)(X)`, the generic point, not the place `X = 0`; `grep -n residue` in `LaurentSeries.lean`, `FieldTheory/RatFunc/*`, `PowerSeries/*`: Weierstrass preparation only. `powerSeriesRingEquiv` identifies `K⟦X⟧` with the integers of the **completion** of `K⟮X⟯`, not of `K⟮X⟯` itself. Both outcomes were reachable (a `residueFieldEquiv` could have existed) |

### 1.3 The residue-hom leaf, priced from its first two sub-leaves by two routes

Both routes' sub-leaf 1 is "the `t`-integral subring and why an element lies in it"; sub-leaf 2 is "evaluation at `0` as a ring hom on it".

| route | file | sub-leaf 1 | sub-leaf 2 | elaborations | verdict |
|---|---|---|---|---|---|
| (i) Laurent series: Mathlib's `(polynomialValuationX F).valuationSubring`, coerce into `F⸨X⸩`, land in `powerSeries_as_subring`, then `(powerSeriesEquivSubring F).symm` and `PowerSeries.constantCoeff` | `data/m2/j15/PriceRouteI.lean` | **one `sorry` left after two elaborations** (the negative coefficients of `ofPowerSeries`); the first elaboration also met a `Valued.v` / `idealX.valuation` instance mismatch (repaired by `LaurentSeries.valuation_def`) and the membership shape of `Subring.map _ ⊤` | **fails to elaborate**: `Algebra (RatFunc F) F⸨X⸩` not synthesised in a `def` body (the coercion that works in a `theorem` statement is not an instance found there) | 2 (stopped) | dearer; and after the hom it still needs the kernel = maximal ideal, through `valuation_le_iff_coeff_lt_eq_zero` again |
| (ii) polynomials: `zeroIntegral F := {f \| (denom f).eval 0 ≠ 0}` (closure from `RatFunc.denom_add_dvd`, `denom_mul_dvd` and a divisor lemma); `evalZero := RatFunc.eval (RingHom.id F) 0` (additivity and multiplicativity are Mathlib's `RatFunc.eval_add`, `eval_mul`, whose hypotheses are exactly membership) | `data/m2/j15/PriceRouteII.lean` | **closed, first elaboration** | **closed, first elaboration** (the spec example needed one `show`) | 2 (1.9 s wall, 2.9 GB peak) | **chosen** |

**The choice, in four parts.** *Choice:* route (ii), a hand-built `t`-integral subring with evaluation at `0`, promoted to a `ValuationSubring`
at stage 2 by the one lemma both remaining leaves need — *if `f` has a pole at `0` then `f⁻¹` has none and vanishes there* (`X ∣ denom f`, so
`X ∤ num f` by `RatFunc.isCoprime_num_denom`, and `f⁻¹ = denom f · (num f)⁻¹` with `denom((num f)⁻¹) ∣ num f`). *Alternative weighed:* route (i),
which would reach Mathlib's own `X`-adic valuation subring (the canonical object). *Why (ii) won:* measured — its two sub-leaves closed on the
first elaboration where route (i) had one `sorry` and one instance failure after two; and the core theorem needs *a* place at `0` with
residue `F`, not Mathlib's name for it. *Confidence:* high on the price; the cost is that the kernel does not say `zeroIntegral F` equals
`(polynomialValuationX F).valuationSubring` — true, not needed, and not claimed.

**The remaining leaves, re-priced from these two:** the inverse lemma (~20 lines), the `ValuationSubring` (5), "the maximal ideal lies in
`ker evalZero`" (~10), the general valuation lemma (~20), the coset step to colourability (~10, J04's `unitQuadrance_colorable_of_subring`), the
core theorem (~15), the adjunction and corollary through `algEquivOfTranscendental` and `planeOverIso` (~30), the Liouville inhabitant (~10).
About 120 lines; stage 2 as briefed.

### 1.4 The shape carried into stage 2 (domain pass, applied)

- **The general valuation lemma is stated at its proof's level**: for a field `K`, `B : ValuationSubring K`, any ring `S` in which
  `1 + s² ≠ 0` for every `s`, and `φ : B →+* S` killing `IsLocalRing.maximalIdeal B`: every `a² + b² = 1` in `K` has `a, b ∈ B`, and every
  colouring of `unitQuadrance S` pulls back to `unitQuadrance K`. The hypothesis is "−1 is not a square in `S`", not formal reality: it is
  what the proof uses, it covers J17's C3′ (a degree-one place of an elliptic function field) and Theorem A's residue fields `𝔽_q`,
  `q ≡ 3 (mod 4)`. Formal reality enters once, as `IsFormallyReal S ∧ Nontrivial S → 1 + s² ≠ 0`.
- **The core theorem** keeps the plan's name and hypothesis: `chromaticNumber_unitQuadrance_ratFunc {F} [Field F] [IsFormallyReal F]`.

### 1.5 Would-have-searched log

| # | the move a search would have made | what was done instead |
|---|---|---|
| X1 | none — the stage is statement reading, two pricing elaborations and `grep` over Mathlib's source | — |

# M2-S2K — FS-39 route C in the kernel: transcendence is free (crunch job J15)

*Kernel engineer: de Bruijn (Opus 5.5), 2026-09-25. Brief: `data/crunch-2026-09-25/briefs/J15-M2-route-c-kernel.md` (with
`STANDING-RULES.md`). Plan: `plans/M2-kernel-lane.md` §2.1–2.2, §3.2, §4.4. Skeleton: `data/m2/j04/K2Transcendental.lean`. Working files:
`data/m2/j15/`.*

## Theorems this phase proved

| theorem | grade | address |
|---|---|---|
| `zeroIntegral` is a subring of `RatFunc F` (rational functions whose reduced denominator does not vanish at `0`) and `evalZero` is a ring hom from it onto `F` (evaluation at `t = 0`) | kernel (scratch at stage 1; in the module at stage 2) | `data/m2/j15/PriceRouteII.lean`; `Proofs/HadwigerNelson/Transcendental.lean` |
| `planeOverIso` (moved in): the plane over `L ⊆ ℝ` is `unitQuadrance L` as graphs; `chromaticNumber_eq_of_iso`, `chromaticNumber_planeOver_eq` | kernel (`lake env lean`; the gated build at stage 4) | `Proofs/HadwigerNelson/Transcendental.lean` |
| `unitQuadrance_colorable_of_subring` (moved in): colourability pulls back through any subring holding every unit vector's coordinates, along any ring hom out of it | kernel (as above) | same |
| `mem_valuationSubring_of_sq_add_sq_eq_one` — **the valuation lemma**: if `1 + x²` is a unit of the valuation subring `B` for every `x ∈ B`, then `a² + b² = 1` forces `a, b ∈ B` | kernel (as above) | same |
| `one_add_sq_ne_zero`: in a nontrivial formally real ring, `1 + s² ≠ 0` | kernel (as above) | same |
| `unitQuadrance_colorable_of_valuationSubring`: a ring hom out of a valuation subring of `K`, killing its maximal ideal, into a ring with no square root of `−1`, pulls every colouring of `S²` back to `K²` | kernel (as above) | same |
| `inv_mem_zeroIntegral_of_not_mem` — **the inverse lemma**: a rational function with a pole at `0` has an inverse with no pole at `0`, vanishing there | kernel (as above) | same |
| `zeroPlace` (a `ValuationSubring (RatFunc F)`), `evalZero : zeroPlace F →+* F`, `evalZero_eq_zero_of_mem_maximalIdeal` — **the residue hom, closed**: evaluation at `t = 0` kills the maximal ideal | kernel (as above) | same |
| `chromaticNumber_unitQuadrance_ratFunc_of_one_add_sq_ne_zero` — the engine: `χ(F(t)²) = χ(F²)` for every field `F` in which `−1` is not a square | kernel (as above) | same |
| **`chromaticNumber_unitQuadrance_ratFunc`** — `χ(unitQuadrance (RatFunc F)) = χ(unitQuadrance F)` for every formally real field `F` (`[Fischer1990]` Thm 6's statement at `d = 2`, in the kernel); inhabitant `chromaticNumber_unitQuadrance_ratFunc_rat` (`F = ℚ`) | kernel (as above; axioms `[propext, Classical.choice, Quot.sound]` from a scratch copy) | same |

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

## Stage 2 — SAVED

### 2.1 The module

`Proofs/HadwigerNelson/Transcendental.lean` (new; not yet in `Proofs.lean`, which stage 4 does with the gate). Elaborated with
`scripts/slot.py --mem 8 --cpus 4 -- lake env lean -Dlinter.missingDocs=true -DautoImplicit=false -DrelaxedAutoImplicit=false` (the lakefile's
options passed by hand, since `lake env lean` does not apply them): **no error, no warning**, 2.58 s wall, 3.39 GB peak (desktop, one run).
`#print axioms` on the core theorem, its `ℚ` instance and the valuation-subring colouring lemma, from a scratch copy: the standard three.

| leaf | lines | elaborations | note |
|---|---|---|---|
| the two J04 leaves, moved in | 60 | 1 | unchanged |
| `chromaticNumber_eq_of_iso`, `chromaticNumber_planeOver_eq` | 10 | 1 | the corollary's plumbing, minted now |
| the valuation lemma | 25 | 2 | first try's only issues were `zero_le'` deprecation (→ `zero_le`) |
| `one_add_sq_ne_zero` | 4 | 3 | an import (`Mathlib.Algebra.Ring.IsFormallyReal`) and a `simpa` lint |
| the colouring form of the valuation lemma | 20 | 2 | `ValuationSubring.add_mem` takes its elements explicitly; the generic `add_mem` does not |
| the place `t = 0`: subring, inverse lemma, `ValuationSubring`, `evalZero`, maximal ideal killed | 95 | 2 | `isUnit_of_mul_eq_one` is now `IsUnit.of_mul_eq_one` |
| the engine and the core theorem, the `ℚ` inhabitant | 25 | 1 | — |
| spec examples: `X ∈ zeroPlace ℚ`, `X⁻¹ ∉ zeroPlace ℚ` (through `evalZero` itself: `evalZero(X·X⁻¹) = 0 ≠ 1`), `evalZero 3 = 3`, `evalZero X = 0` | 20 | 2 | the first `X⁻¹` proof through `denom_div` and `gcd` did not close; replaced |

**The residue hom closed in about 15 minutes of work from stage 2's start, with no hypothesis left.** The stop rule (2 hours) did not fire.

### 2.2 Decisions this stage, in four parts

1. **The engine is stated for any field in which `−1` is not a square; the named theorem keeps `[IsFormallyReal F]`.** *Alternative:* only the
   formally real form, as the plan's §4.4 item 4 has it. *Why:* the proof uses formal reality at one step (`1 + s² ≠ 0`), and the sharper
   statement costs one declaration and covers residue fields `𝔽_q`, `q ≡ 3 (mod 4)`. *Confidence:* high.
2. **The `𝔽₃` inhabitant of the engine was dropped.** *Alternative:* `chromaticNumber_unitQuadrance_ratFunc_zmod_three`, tried. *Why dropped:*
   `RatFunc (ZMod 3)`'s field instance timed out at `whnf` in the module (200,000 heartbeats) and failed to synthesise in a probe (`IsDomain (ZMod
   3)` not found under a minimal import); chasing it is gold-plating, and the engine's hypothesis is a `Prop`, inhabited by `ℚ` through the named
   theorem. *Confidence:* high that nothing is lost; the instance failure is a Mathlib-instance question, not recorded as a defect.
3. **`zeroPlace F` is hand-built, not Mathlib's `(polynomialValuationX F).valuationSubring`** (stage 1's pricing). The two are the same valuation
   subring; the kernel does not say so, and nothing here claims it.

### 2.3 Would-have-searched log (stage 2)

| # | the move a search would have made | what was done instead |
|---|---|---|
| X2 | none — derivation and elaboration only; the one `decide` (over the three elements of `ZMod 3`) was removed with its theorem | — |

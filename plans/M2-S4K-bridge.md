# M2-S4K — the bridge in the kernel, conditional on real algebraic descent; `ℝ` and `R_alg` real closed (crunch job J17K)

*Kernel job J17K of the 2026-09-25 crunch, milestone M2 (FS-39 phases B0–B1 and C). Brief:
`data/crunch-2026-09-25/briefs/J17K-M2-bridge-kernel.md` (with `STANDING-RULES.md`). Opus 5.5, de Bruijn. Started 22:30 UTC
from the green gate at `b1ec47a9`.*

## Theorems this phase proved

All **[kernel]**, on axioms exactly `[propext, Classical.choice, Quot.sound]`; the `_of_descent` ones conditional on the named
hypothesis `RealAlgebraicDescent` (true — Tarski; Artin–Lang — and unproved here).

| theorem | grade | address |
|---|---|---|
| `realAlgebraicDescent_one` — the hypothesis in one variable (partial inhabitant) | kernel | `Proofs/HadwigerNelson/Bridge.lean` |
| `not_rationalDescent` — the rational twin is false (`X₀² − 2`) | kernel | same |
| `RealAlgebraicDescent.of_finite` — the hypothesis for any finite variable type | kernel | same |
| `numberField_adjoinReal` — finitely many real algebraic numbers generate a number field | kernel | same |
| `exists_numberField_drawing_of_descent` — **C1** | kernel, conditional | same |
| `iSup_numberField_le_chromaticNumber_plane` — the free half of C2 | kernel | same |
| `chromaticNumber_plane_eq_iSup_numberField_of_descent` — **C2** | kernel, conditional | same |
| `exists_numberField_chromaticNumber_eq_plane_of_descent` — attainment | kernel, conditional | same |
| `numberField_sup` — the compositum of two real number fields | kernel | same |
| `chromaticNumber_plane_ne_six_iff_of_descent` — **C4** (FS62-T2) | kernel, conditional | same |
| `Polynomial.exists_isRoot_of_odd_natDegree_real` — odd-degree real polynomials have real roots | kernel | `Proofs/HadwigerNelson/RealClosed.lean` |
| `Real.isRealClosed` — **B0**, `IsRealClosed ℝ` | kernel | same |
| `algebraicClosure.isRealClosed` — **B0**, general: the relative algebraic closure in a real closed field is real closed | kernel | same |
| `isRealClosed_algebraicClosure_rat_real` — **B0**, `IsRealClosed (algebraicClosure ℚ ℝ)` | kernel | same |
| `IsSumSq.map`, `IsSemireal.of_ringHom` — sums of squares along ring homs; semireality pulls back along any ring hom | kernel | same |

## Stage 1 — SAVED

### 1.1 The quotation check (standing rule 5)

| quotation in the brief | source | verdict |
|---|---|---|
| C1 "For every finite graph `H` … on every edge." | `plans/M2-kernel-lane.md` line 436 | verbatim |
| C2 "`χ(ℝ²) = sup { χ(F²) : F ⊂ ℝ a number field }`, …" | same, line 438 | verbatim |
| C4 "`χ(ℝ²) ≠ 6` if and only if every real number field …" | same, line 441, citing `plans/STUB-plane-bridge.md` §5 | verbatim at the kernel lane; the stub's own words are "`χ(ℝ²) ≠ 6` ⟺ every real number field `F` with `χ(F²) = 6` has a finite real extension `F′` with `χ(F′²) = 7`" — same claim, different words |
| B0, B1 ("**B0 — (RC)**, … needed by every route.", "**B1 — the bridge as a conditional theorem**: …") | `plans/M2-S1D-bridge.md` §3.2 items 1–2 | verbatim; the "`VACUITY DECLARED`" clause is marked corrected in the source itself |
| (∃T) "a system of polynomial equations over a real closed `R` …" | same, §2.1 | verbatim |
| Lemma NP, its proof skeleton, "`α⁴ = β⁴ + (γδ)²`", "`deg γ + deg δ … ≤ 2D`" | same, §2.3 | verbatim; the ellipsis stands for "`= (deg(p − q) + deg(p + q))/2`" |
| "Any real transcendental `x > 1` in place of `π` works — e.g. `x = 2 + L`" | same, §2.3 | verbatim |
| "every term is at most 7, `S` is finite, and **the supremum is a maximum**" | same, §2.2 step 1 | verbatim |
| `CLAUDE.md` § The gate: "`DECLARED` (deliberate emptiness, named with its reason in the docstring as `VACUITY DECLARED:` and printed every run)" | `CLAUDE.md` | verbatim |
| J14: "the gate reads `VACUITY DECLARED:` as a checked claim that a hypothesis's domain is **provably empty** … `G4` is unproved, not empty" | `plans/M2-S1K-chain.md` lines 144–146 | verbatim |
| Mathlib TODO "TODO (Artie Khovanov) : real numbers, real algebraic numbers, hyperreals form a real closed field" | `FieldTheory/IsRealClosed/Basic.lean:26` | verbatim, line correct |
| `IsRealClosed.of_linearOrderedField …` | same file, line 60 | verbatim (the file is a `module` file) |
| `protected theorem Polynomial.abc …` | `NumberTheory/FLT/MasonStothers.lean:55` | verbatim, line correct |
| `nonempty_hom_of_forall_finite_subgraph_hom` (`Finsubgraph.lean:154`), `Finset.rado_selection` (`Compactness.lean:64`), `ENat.exists_eq_iSup_of_lt_top` / `sSup_mem_of_nonempty_of_lt_top` (`Data/ENat/Lattice.lean:108–118`), `algebraicClosure` (`AlgebraicClosure.lean:40`), `exists_associated_pow_of_mul_eq_pow'` (`PrincipalIdealDomain.lean:482`) | Mathlib at the pin | all present at the stated lines |
| `Instances/Interval.lean:35`, `Reduction.lean:51`, `SquareClass.lean:63`, `Chain.lean:182`, `Kempe.lean` ~131, `SevenConditional.lean` | the repository | present; `SquareClass.lean`'s `planeOver` is at line 63 |
| the brief's `Mathlib.Data.Real.Irrational` (implicit, `irrational_sqrt_two`) | — | the module is `Mathlib.NumberTheory.Real.Irrational` at this pin |

No quotation was found paraphrased in a way that changes a claim.

### 1.2 C0 — the order, stated honestly

The brief asks for C0 before the leaves. **Slip, mine:** I priced the skeleton's first two leaves by writing them, and both closed
at once — the whole of B1, C4 and both B0 instances elaborated under `lake env lean` (17:38–17:42) before C0 was written. So
probabilities for those products would be post hoc and are not given. C0 for the products not yet attempted, written before any
attempt:

| product | p |
|---|---|
| the real build accepts `Bridge.lean` and `RealClosed.lean` unchanged or with lint-only edits | 0.85 |
| Lemma NP via `Polynomial.abc` in this job's budget | 0.35 |
| C3 one-variable form | 0.25 |
| C3⁺ | 0.05 |

### 1.3 The price, from the first two leaves

| leaf | `plans/M2-S1D-bridge.md` §3.2's price | measured |
|---|---|---|
| C1's encoding (`exists_numberField_drawing_of_descent`: a drawing as a `Finset` of rational `MvPolynomial`s in variables `ι ⊕ ι`, renamed to `Fin n`; the generated field a number field by `IntermediateField.finiteDimensional_adjoin`) | inside B1's "~1 day" | ~6 minutes of elaboration cycles, first try up to three one-line fixes |
| `IsRealClosed ℝ` | inside B0's "~1 day" | ~3 minutes: Mathlib's `Analysis/Polynomial/Order.lean` (2026) gives the eventual sign below and above all roots; a root-free odd-degree polynomial would have opposite signs at `0` |

**§3.2's day-prices for B0 and B1 were high by about two orders of magnitude**, because Mathlib at this pin already holds
the two non-obvious inputs (the eventual-sign lemmas, and `algebraicClosure_eq_bot`'s tower integrality). Iteration peak:
3.4 GB per `lake env lean` of `Bridge.lean` (2.4 s wall), so `--mem 10` is honest.

## Stage 2 — SAVED

`Proofs/HadwigerNelson/Bridge.lean` (namespace `HadwigerNelson.Bridge`). Every statement of the brief landed; changes from the
brief's proposed Lean, each with its reason:

| change | reason |
|---|---|
| `RealAlgebraicDescent` kept verbatim (over `Fin n`); a lemma `RealAlgebraicDescent.of_finite` gives it for any finite variable type | the drawing's variables are `ι ⊕ ι` (real and imaginary parts); renaming along `σ ≃ Fin n` (`MvPolynomial.aeval_rename`) keeps the hypothesis in the brief's shape |
| added `adjoinReal S := (IntermediateField.adjoin ℚ S).toSubfield`, `numberField_adjoinReal` | "finitely many real algebraic numbers generate a number field" as a reusable lemma; `NumberField ↥(E.toSubfield)` is accepted from `FiniteDimensional ℚ ↥E` by defeq (`exact ⟨⟩` after `show`), no instance transport needed |
| added `numberField_sup` (the compositum), via `Subfield.toIntermediateField` and `IntermediateField.sup_toSubfield` | C4's (⟹) takes `F′ := F ⊔ E` |
| added `chromaticNumber_complex_le_seven`, `iSup_numberField_le_seven`, `nonempty_numberField` | the supremum is finite and its index nonempty, the two inputs of attainment |
| the free half and C2's `≤` half stated separately | the free half has no hypothesis and is its own theorem |

**Read aloud against the informal claims.**
- `exists_numberField_drawing_of_descent`: for a finite vertex type `ι`, a graph `G` on it and a map `f : ι → ℂ` with every edge
  at distance exactly 1, there are a subfield `F ⊆ ℝ` that is a number field and a map `g : ι → ℂ` with both coordinates of every
  `g i` in `F` and every edge at distance exactly 1. That is C1 ("non-injective `g` allowed": nothing asks `g` injective). ✓
- `chromaticNumber_plane_eq_iSup_numberField_of_descent`: the chromatic number of the unit-distance graph on `ℂ` (= `ℝ²`,
  `chromaticNumber_plane_eq_complex`) equals the supremum, over subfields `F ⊆ ℝ` that are number fields, of the chromatic number
  of the unit-distance graph induced on `F × F` (`planeOver F`). That is C2. ✓
- `exists_numberField_chromaticNumber_eq_plane_of_descent`: one real number field attains it. §2.2's attainment. ✓
- `chromaticNumber_plane_ne_six_iff_of_descent`: `χ(ℝ²) ≠ 6` iff for every real number field `F` with `χ(F²) = 6` there is a real
  number field `F′ ⊇ F` with `χ(F′²) = 7`. C4 says "a finite extension `F′ ⊂ ℝ`": a number field containing `F` is a finite
  extension of it, and conversely, so the two read the same. ✓
- Each carries the hypothesis `hD : RealAlgebraicDescent`; its docstring says "Conditional, and not vacuous" and why, with no
  `VACUITY DECLARED:` marker (the brief's ruling; J14's precedent).

**Controls.** `realAlgebraicDescent_one` (the partial inhabitant: if a nonzero member vanishes at `x`, `x` is not algebraically
independent, so by `algebraicIndependent_unique_type_iff` its coordinate is algebraic; else `0`); `not_rationalDescent` (the twin
with rational coordinates, refuted by `{X₀² − 2}`: a rational `q` with `q² = 2` makes `√2 = |q|` rational, against
`irrational_sqrt_two`). Spec examples: `edgePoly` vanishing at a unit segment and not at a length-two one; `ofCoords`; `adjoinReal`
holding `√2`.

**Why the conditional statement cannot be cheated.** The only way `RealAlgebraicDescent` enters is through
`exists_numberField_drawing_of_descent`; the free half, the `≤ 7` and the compositum are unconditional. The twin shows that a
hypothesis of this exact shape is not automatically consistent.

### Would-have-searched log (stages 1–2)
- None. No move here would have been a search; the one candidate (checking a drawing numerically before encoding it) was replaced
  by the exact identity `dist_ofCoords_eq_one_iff`.

## Stage 3 — SAVED

`Proofs/HadwigerNelson/RealClosed.lean`, Mathlib style, imports Mathlib only (upstream candidate; docstrings say delete when
Mathlib gains them).

- `Polynomial.exists_isRoot_of_odd_natDegree_real` — a root-free odd-degree real polynomial would be, at `0`, of the sign of
  its leading coefficient (as `0` lies above all roots, `zero_lt_eval_of_roots_lt_of_leadingCoeff_nonneg`) and of the opposite
  sign (as `0` lies below all roots, `zero_lt_negOnePow_mul_eval_of_lt_roots_of_leadingCoeff_nonneg` with `(−1)^odd = −1`).
- `Real.isRealClosed` — by `IsRealClosed.of_linearOrderedField` with `√x`.
- **Stronger than the brief asked:** `algebraicClosure.isRealClosed` — for any fields `F`, `E` with `E` real closed, the relative
  algebraic closure of `F` in `E` is real closed (semireal by the ring map into `E`; a square root, or a root of the odd-degree
  polynomial mapped to `E`, is integral over the closure and so, by `isIntegral_trans`, in it). No order on the closure is used.
  At `ℚ ⊆ ℝ`: `isRealClosed_algebraicClosure_rat_real`.
- Two general lemmas on the way: `IsSumSq.map` (ring homs preserve sums of squares) and `IsSemireal.of_ringHom` (a ring with a
  ring hom into a semireal ring is semireal — no injectivity needed; the draft asked for it and the unused-variable linter caught it).
- Spec: `2` is a square and `−1` is not among the real algebraic numbers; `2` has a real algebraic cube root; `X² + 1` has no real
  root (the odd-degree hypothesis is not idle).

## Stage 4 — SAVED (not attempted: the budget stop rule)

Lemma NP, the genus-0 plant, C3 one-variable and C3⁺ were **not attempted**. The obstruction is budget, not mathematics: at the end of
stage 3 this job stood at about 325k of the harness's count against the brief's 350k stop rule and 420k hand-back, and NP is the one
leaf of this brief with real proof effort (a polynomial core, the Fermat-quartic step against `Polynomial.abc`, the `RatFunc`
wrapper). Priority order followed as briefed (B1 → C4 → B0 → NP → C3 → C3⁺). The remainder is proposed as **J17K2**, with its brief
at `data/crunch-2026-09-25/briefs/J17K2-M2-lemma-NP-kernel.md` (every statement quoted from its source; a suggested decomposition
marked untested; the genus-0 plant carried over). **Leaves left:** NP (budget), C3 one-variable (needs NP), C3⁺ (needs NP and the
restriction to a line), and B2 — `(∃T)` in the kernel, months, named as a leaf only, not a job.

## Stage 5 — SAVED

### 5.1 The gate (at the stage-3 commit `0b5dcc96`)
- **Build:** `scripts/slot.py --mem 60 --cpus 16 -- env MEMMAX=60G ./scripts/build.sh` — OK, 178 of 178 batches, 3 modules rebuilt
  (`RealClosed`, `Bridge`, `Proofs`), **0 modules with warnings**, 3 m 36 s (`build/gate/build/20260925T224250Z-122689.log`).
- **`sorry`:** 0 in both new modules.
- **Axioms:** OK — **1091 clean, 11 axiom-free, 5 declared purchases** (was 1077 / 11 / 5; +14, the 14 new `#print axioms` lines,
  every one exactly the standard three) (`build/gate/axioms/20260925T224649Z-141964.log`).
- **Vacuity:** OK — `declarations=7019 refutations-skipped=294 sites=279`, `vacuous=0 stale=0 declared=3 witnessed=17 generic=257
  unknown=2` (was declarations 6986, refutations 293; sites and generic unchanged). **No theorem of this job is a site**: a `Prop`
  hypothesis (`hD : RealAlgebraicDescent`) is not a `Coloring` binder, as the brief expected; `not_rationalDescent` is the one new
  skipped refutation; `nonempty_numberField` registers as new evidence (a witness of `Nonempty {F // NumberField F}`)
  (`build/gate/vacuity/20260925T224656Z-142309.log`).
- **Architecture:** `python3 tools/check_architecture.py` — PASS, with rows for `RealClosed` and `Bridge` in the module map.
- `lake lint`: not run (owner ruling: once, at M2's close).

### 5.2 The registered predictions, scored
| id | prediction | p | outcome |
|---|---|---|---|
| P-J17Ka | B1 and C4 land green, conditional on `RealAlgebraicDescent`, inside 2 hours | 0.60 | **HELD** — elaborated at 17:38 (about 8 minutes in), real build green at 17:46 |
| P-J17Kb | both B0 instances land | 0.60 | **HELD**, and in a stronger form (any relative algebraic closure in a real closed field) |
| P-J17Kc | Lemma NP lands via `Polynomial.abc` in at most 200 lines | 0.50 | **not scorable** — not attempted (budget); passed to J17K2 unscored |
| C0 (mine) | the real build accepts both modules unchanged or with lint-only edits | 0.85 | HELD (unchanged, 0 warnings) |

### 5.3 Proposed edits (standing rule 7; the front-page lane writes them)
- `CLAUDE.md` § The gate, the recorded counts: `declarations=7019 refutations-skipped=294 sites=279`, `vacuous=0 stale=0 declared=3
  witnessed=17 generic=257 unknown=2` (the recorded line reads 6795 / 278 / 275 / 253 — stale before this job).
- `CLAUDE.md` § Trust ledger: "the current audit reads 1034 clean" → 1091 clean, 11 axiom-free, 5 declared purchases.
- `plans/STUB-plane-bridge.md` (FS-39): phases B0–B1 and C's C1, C2 (attained) and C4 are in the kernel, conditional on the one named
  hypothesis `RealAlgebraicDescent`; left, B2 (months) and C3/NP (J17K2).
- `plans/M2-S1D-bridge.md` §3.2: B0's and B1's "~1 day" were each under half an hour at this Mathlib pin.
- `LEDGER.md`: a row for the conditional bridge (C2 with attainment, C4) and the two real-closed instances, `[kernel]`, addresses above.

### 5.4 Would-have-searched log (stages 3–5)
- None.

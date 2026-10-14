# FS133-ICD1 — the one-class transfer's last two lanes: `Plane/OneClass/Algebraic`, `Fractional`, `Pair`

*de Bruijn, the implementer; job FS133-ICD1 (brief: `data/fs133/briefs/FS133-ICD1-plane-pairs.md`, on `main`).
Branch `fs133-wcd`, cut from `572bc6b57` (the last implementer's head, branch `fs133-wb2`) in the worktree
`.claude/worktrees/fs133-wk1`. The plan is `plans/FS133-kernel-plan.md` § 5.3 (lane C: A1–A5, C1–C3) and § 5.4
(lane D: Q1–Q5), with § 5.5. Working files: `data/fs133/icd1/`. Files this job writes: the three modules (proofs and
private helpers only), and in `Plane/OneClass/Defs` two edits by rulings 1 and 4 of inventory item 752.*

## Theorems this phase proved

(Filled at the build of record; until then, none.)

## Stage 1 — SAVED: the readback, the leaves restated, the stored statements dumped before any edit

**1.1 The brief's quotations.** `tools/fs133_icd1_readback.py` (FS133-IB2's reader with this job's brief; each quoted
line a substring of its source, read in the coordinator's tree): **4 matched, 0 mismatched**, exit 0
(`data/fs133/icd1/readback-brief.out`) — W2 against `data/fs131/REQUEST-2026-10-13.md`; K133-ONE and K133-NC-ONE
against `data/fs133/claims-K1.md`; inventory item 752 against `plans/FS131-close-inventory.md`. With `--fault` (the
last character of each quoted line changed): 0 matched, 4 mismatched, exit 1 (`readback-brief-fault.out`). No
finding about the brief's quotations. One naming note: the plan's § 5.3 and § 5.5 call A2
`IsInvariantLaw.measure_zero_le_mOne`; the file (and the skeleton FS133-K1 built) names it
`IsInvariantLaw.measure_origin_le_mOne`. The file's name is the statement's; nothing to rule.

**1.2 What was read.** The brief; `plans/STANDING-RULES.md`; `LEAN.md` whole; `RUNNING.md` § Building and § Make the
gate fail; the plan's §§ 4.1, 5.0–5.5; FS133-IB2's record whole and FS133-IA1's drafts; the three files, `Defs`, the
statements of `SectionDensity`, `Field` (`exists_field`) and `InvariantLaw`; the library around periodisation and
density points (`Plane/Slack`: `exists_squareWin_dense`, `periodize`, `bandFree_periodize`; `Plane/DensityPoints`;
`Plane/UnitPairs`).

**1.3 Each leaf, in one line, beside the plan's route.** Thirteen `sorry`s. The file's text is the statement; the
line is a reading.

| leaf | the statement, in one line | the plan's route |
|---|---|---|
| **A1** `exists_measurable_indep_of_field` | a measurable `[0,1]`-valued `H` on `ℂ × Ω` with mean `≥ δ` everywhere and a.s. zero products at unit distance gives a Borel independent `A` with `ofReal δ ≤ d̄(A)` | Tonelli for a.e. `ω` with null unit pairs of `{H(·,ω) > 0}`; the section density along `ball 0 (n+1)`; `densitySet` of the section |
| **A2** `IsInvariantLaw.measure_origin_le_mOne` | an invariant law of `unitDistance E` has `P{I 0} ≤ m₁` | `exists_field` at `ι := Unit`, clause (c) at `z := 1`, then A1 |
| **A3** `mOne_le_finIndepRatio` | `m₁ ≤ ᾱ(unitDistance ℂ)` | `le_finIndepRatio_iff`; average over translates `t ∈ ball 0 R` of `#{g ∈ S : g + t ∈ A}` |
| **A4** `one_seventh_le_mOne` | `7⁻¹ ≤ m₁` | `inv_le_finIndepRatio_of_colorable` at the seven-colouring, rewritten by `finIndepRatio_plane_eq_mOne` |
| **A5** `tendsto_minIndepNum_div_finIndepRatio` | `f(n)/n → ᾱ(unitDistance ℂ)` in `ℝ≥0∞` | Fekete for the subadditive `f` (far translates), its infimum the ratio |
| **C1** `exists_periodic_indep` | `c < m₁` gives a Borel independent `L`-periodic `A`, `L ≥ 1` an integer, with `c L² < vol(A ∩ [0,L)²)` | a dense square window, copies cut apart (the library's `periodize`) |
| **C2** `exists_fold_cover` | `c < m₁` gives `N` independent sets covering every point at least `b > 0` times with `c N ≤ b` | regularise C1's set (`3/4`-dense discs: open, independent), grid squares inside, `N = M²` translates |
| **C3** `fractionalChromaticNumber_plane_le` | `χ_f(unitDistance ℂ) ≤ m₁⁻¹` | C2 gives a `b`-fold `N`-colouring for each `c < m₁`; let `c ↑ m₁` |
| **Q1** `admissibleOn_colourPattern_iff` | admissible for the colouring pattern iff proper on `X` | unfold |
| **Q2** `isAlgPattern_colourPattern` | the colouring pattern is an algebraic pattern | `{1}` countable; `1 > 0`; `isAlgebraic_one` |
| **Q3** `exists_admissible_colourPattern_seven` | a Borel `ℓ : ℂ → Fin 7` admissible at every pair and almost everywhere | the library's Borel seven-colouring |
| **Q4** `exists_measurable_admissibleAe` | admissible on `E` gives a labelling with Borel fibres admissible a.e. | invariant law on the closed admissible labellings, `exists_field` at `ι := Λ`, Tonelli, a positive selection |
| **Q5** `exists_admissibleOn_of_ae` | null-measurable fibres admissible a.e. give a labelling admissible at every pair | density-point cores, a two-set radius-`r` density-point lemma, translates, `Finset.rado_selection` |

**1.4 The stored statements before any edit.** The build as the last implementer left it: `lake build --no-build`
under the slot reads `All targets up-to-date (6047 jobs)`, exit 0 (`data/fs133/icd1/nobuild-before.log`; it replays
the thirteen `sorry` warnings of the three files). `data/fs133/icd1/lean/StatementDump.lean` (FS133-IB2's dumper,
its body unchanged, the module list `Defs`, `Algebraic`, `Fractional`, `Pair`) prints every named constant of the
four modules from their compiled data, in the full print and the print with instance and proof arguments erased:
`data/fs133/icd1/moved/before.out.xz` (sha256 in `before.sha256`) — **`Defs` 50 named and 7 private, `Algebraic`
9, `Fractional` 7, `Pair` 19 named, 92 in all**; no `ABSENT`. (`Defs` reads 50 named here where FS133-IB2's stage 1
read 49: its dump was made before `countable_algPlane` moved in.)

## Stage 2 — SAVED: the Defs edits (rulings 1 and 4, Amendment 1), two imports, ten leaves proved

**2.1 `Defs`.** Made public, statements unchanged: `Plane.upperDensity_congr_ae` (ruling 1),
`SimpleGraph.card_le_indepNum_induce` and `SimpleGraph.exists_indep_card_eq_indepNum` (Amendment 1, which answered
this job's question of 06:30 UTC: A5 needs the bridge; a private copy declined). The section comment above the bridge
said "two private lemmas" and now says "two lemmas". The docstring of `Plane.isIndepSet_ball_half` rewritten
(ruling 4): it now says the disc holds no two points at distance one, and that its measurability is Mathlib's
`measurableSet_ball`. No other edit; no name of the three is declared elsewhere in this tree or on `main` (grep of
`Proofs/` and Mathlib's source).

**2.2 Imports added to `Algebraic`.** `Proofs.HadwigerNelson.Instances.Seven` (A4's route as the plan names it;
accepted by Amendment 1) and **`Mathlib.Analysis.Subadditive`** (A5's route: the plan names
`Subadditive.tendsto_lim` as confirmed, but `Subadditive` is outside the module's closure; a Mathlib leaf importing
four order and topology modules). Both for the coordinator's record (the report lists them; the ARCHITECTURE draft
names both). Whether either moved a stored statement is stage 4's comparison.

**2.3 A build after the `Defs` edits** (to compile the public lemmas for iteration). A first run (`build-defs`) was
stopped by its process group at batch 217 of 249 when Amendment 1 arrived — it was building under a `Defs` about to
change — verified by effect (no process of the group, log digest static across ten seconds;
`data/fs133/icd1/build-defs-stopped.log`); it forfeited nothing. The second (`build-a1`, after the Amendment's edits
and the `Instances.Seven` import): **`build: OK — 249 of 249 batches, 7 module(s) rebuilt`** (`Defs`, `InvariantLaw`,
`Field`, `Algebraic`, `Fractional`, `Pair`, `Proofs`; full log `data/fs133/icd1/build-a1-full.log`), warnings only
the thirteen `sorry`s. A dump of the four modules from that build: `data/fs133/icd1/moved/mid.out.xz` (`Defs` 53
named and 4 private: the three made public moved from one count to the other).

**2.4 The leaves.** Each written in a copy under `data/fs133/icd1/work/` and elaborated with the lakefile's options
(`lean1.sh`), then installed; each on the plan's route unless said.
- **A1** `exists_measurable_indep_of_field` — **proved**: (i) the set of `(ω, (x, θ))` with both values positive is
  null for `P ⊗ (Leb ⊗ arc)` by `Measure.prod_apply_symm` (each `(x, θ)`-section is null by `hunit`), so almost every
  `ω` has null unit pairs (`Measure.measure_ae_null_of_prod_null`); (ii) `sectionDensity_setOf_pos` along
  `ball 0 (n + 1)` and its fourth clause at that event; (iii) the window limsup is a limsup along a sequence tending to
  `∞` (`Filter.limsup_comp`, `limsup_le_limsup_of_le`); (iv) `densitySet` of the support, by
  `upperDensity_congr_ae` and `dist_ne_one_of_mem_densitySet`.
- **A2** `IsInvariantLaw.measure_origin_le_mOne` — **proved**: `exists_field` at `ι := Unit` with the indicator of
  `{I 0}`; clause (c) at `z := 1` (`dist 0 1 = 1` in `E`); A1 at `δ := (P {I 0}).toReal` (`integral_indicator_one`).
- **A3** `mOne_le_finIndepRatio` — **proved**: for `c' < d̄(A)`, if every translate met `S` in fewer than `c' |S|`
  points, integrating the count over `B(0, R)` (`lintegral_finsetSum`, `measure_preimage_add`) would give
  `|A ∩ B(0, R − r)| ≤ c' |B(0, R)|` for all `R > r`, so `d̄(A) ≤ c'` (a private helper,
  `upperDensity_le_of_forall_ball`: the disc ratio tends to `1`, `tendsto_sq_add_div`).
- **A4** `one_seventh_le_mOne` — **proved**: `inv_le_finIndepRatio_of_colorable` at `plane_colorable_seven`.
- **A5** `tendsto_minIndepNum_div_finIndepRatio` — **proved**: `f` attained (`Nat.sInf_mem`), subadditive (a set for
  `a` and a translate of a set for `b` off the finite difference set, `Infinite.exists_notMem_finset`; the bridge
  lemmas for a translate and a union), `Subadditive.tendsto_lim`, and the limit is the ratio both ways
  (`Subadditive.lim_le_div`; `finIndepRatio` read as its infimum).
- **C1** `exists_periodic_indep` — **proved by a route the plan's sketch leaves open**: the library's window lemma
  `exists_squareWin_dense` at an integer side `ℓ` with `a (ℓ + 2)² ≤ b ℓ²`, the window's part moved to `1 + i`, and
  `periodize` at `ℓ + 2` (`bandFree_periodize` at `ε = 0` for independence) — the copies are cut `2` apart instead
  of the plan's trimmed square; `L = ℓ + 2`.
- **C3** `fractionalChromaticNumber_plane_le` — **proved from C2's statement**: the fold cover is a `b`-fold
  `N`-colouring, `N / b ≤ c⁻¹`, and `c ↑ m₁` by `exists_between` and `ENNReal.inv_lt_iff_inv_lt`.
- **Q1** `admissibleOn_colourPattern_iff`, **Q2** `isAlgPattern_colourPattern` — **proved** (unfold; `{1}` countable,
  `isAlgebraic_one`).
- **Q3** `exists_admissible_colourPattern_seven` — **proved with the brick colouring** (`sevenBrick.color`,
  `Instances/Seven`, proper at every pair by `Brick.avoids`; Borel because it is a table read at two floors of affine
  functions, `Int.measurable_floor`, `measurable_of_countable`). The plan pointed to `Plane/CoverExamples`' `r7Col`,
  which is proper only almost everywhere; the statement asks every pair.

**2.5 Re-pricing (Done, item 2).** The plan priced A1 at 3–5 h and A3 at 4–6 h; both closed in the first three
elaborations of the file, and all five of `Algebraic` in five. What is left: **C2** `exists_fold_cover` (the plan's
12–20 h; the library's `eventually_le_muPer` already assembles the windowing, keeping and tiling for `k` classes, so
what is new is the count of translates of a periodic grid union — re-priced at one long stage), **Q4** and **Q5**
(6–10 h each by the plan; not begun).

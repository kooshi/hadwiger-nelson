# FS133-ICD1 — the one-class transfer's last two lanes: `Plane/OneClass/Algebraic`, `Fractional`, `Pair`

*de Bruijn, the implementer; job FS133-ICD1 (brief: `data/fs133/briefs/FS133-ICD1-plane-pairs.md`, on `main`).
Branch `fs133-wcd`, cut from `572bc6b57` (the last implementer's head, branch `fs133-wb2`) in the worktree
`.claude/worktrees/fs133-wk1`. The plan is `plans/FS133-kernel-plan.md` § 5.3 (lane C: A1–A5, C1–C3) and § 5.4
(lane D: Q1–Q5), with § 5.5. Working files: `data/fs133/icd1/`. Files this job writes: the three modules (proofs and
private helpers only), and in `Plane/OneClass/Defs` two edits by rulings 1 and 4 of inventory item 752.*

## Theorems this phase proved

Each [kernel], printed from the built tree (stage 4.3; `data/fs133/icd1/axioms-built.out`); statements FS133-K1's,
unchanged (stage 4.2); proofs this job's. "Std" is `[propext, Classical.choice, Quot.sound]`; "Std + RF" is those and
the declared outside theorem `HadwigerNelson.Outside.OAI158.Spectral.residual_fourier`.

`Proofs/HadwigerNelson/Plane/OneClass/Algebraic.lean`:
- `OneClass.exists_measurable_indep_of_field` — a `[0,1]` field with mean `≥ δ` and a.s. zero products at unit
  distance gives a Borel independent set of upper density `≥ δ`. Std.
- `OneClass.IsInvariantLaw.measure_origin_le_mOne` — C133-ALG: an invariant random independent set of the algebraic
  plane has density at most `m₁(ℝ²)`. Std + RF.
- `OneClass.mOne_le_finIndepRatio` — C133-EASY: `m₁(ℝ²) ≤ α₁(ℝ²)`. Std.
- `OneClass.one_seventh_le_mOne` — `1/7 ≤ m₁(ℝ²)`. Std + RF.
- `OneClass.tendsto_minIndepNum_div_finIndepRatio` — `f(n)/n → α₁(ℝ²)` (Fekete). Std.
- With these, the skeleton's assembled headlines now have no `sorry` beneath them: `finIndepRatio_algPlane_le_mOne`,
  `finIndepRatio_plane_eq_mOne`, `finIndepRatio_algPlane_eq_mOne` (C133-ONE, first line), `tendsto_minIndepNum_div`
  (C133-FN) — each Std + RF.

`Proofs/HadwigerNelson/Plane/OneClass/Fractional.lean`:
- `OneClass.exists_periodic_indep` — periodisation below `m₁`. Std.
- `OneClass.exists_fold_cover` — `N` independent sets covering every point at least `b ≥ cN > 0` times. Std.
- `OneClass.fractionalChromaticNumber_plane_le` — C133-CHIF: `χ_f(ℝ²) ≤ 1/m₁(ℝ²)`. Std.
- With these: `fractionalChromaticNumber_plane`, `iSup_fractionalChromaticNumber_plane`,
  `fractionalChromaticNumber_algPlane` (C133-ONE, second line) — each Std + RF.

`Proofs/HadwigerNelson/Plane/OneClass/Pair.lean`:
- `OneClass.admissibleOn_colourPattern_iff`, `OneClass.isAlgPattern_colourPattern`,
  `OneClass.exists_admissible_colourPattern_seven` — the drift check and the two models. Std.
- **Not proved: Q4 `exists_measurable_admissibleAe`, Q5 `exists_admissibleOn_of_ae`**, so C133-PAIR's two clauses
  (`exists_admissibleOn_univ_iff_ae`, `…_iff_algPlane`) still print `sorryAx`.

`Proofs/HadwigerNelson/Plane/OneClass/Defs.lean`: no proof changed; three lemmas made public (stage 2.1).

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

## Stage 3 — SAVED: C2, the fold cover — lane C complete

**C2** `exists_fold_cover` — **proved**, no `sorry` in `Algebraic` or `Fractional`. Route: the windowing, keeping and
tiling of `Plane.eventually_le_muPer` (`Plane/Slack`), run for one class with its data kept — `exists_squareWin_dense`
at an integer side `ℓ`, `ae_eventually_keptAt` and continuity from below on the window, `exists_tiled_kept` at pixel
`h = 1/M`, `keptAt_band`, and `periodize` at `ℓ + 2 = K h` with `K = (ℓ + 2) M` (so the pixel divides the period,
which `muPer`'s definition does not record) — then the count, which is new here, in private helpers:
`card_sub_mem` (every point lies in the same number `n'` of the `K²` translates of the periodized grid union by the
lattice points `(i h, j h)`, `i, j ∈ ZMod K`: membership depends only on the square, the square's corner reduces
modulo `K` by the period, and `p ↦ (⌊x/h⌋, ⌊y/h⌋) − p` is a bijection of `(ZMod K)²`), and
`volume_le_card_corners` (the kept squares' area is at most `n' h²`: they lie in a window of fewer than `K` squares a
side, so distinct squares have distinct corners modulo `K`). Then `a K² < n'`, so `c K² ≤ n'`, `n' > 0`. The plan's
route (regularise by `3/4`-dense discs, grid squares inside an open set) was not needed: the library's kept squares
are already a grid union.

## Stage 4 — SAVED: the build of record, and every receipt from the built tree

**4.1 The build** (Done, item 4). `build-record`: OK, 249 of 249 batches, 4 modules rebuilt (`Algebraic`, `Fractional`,
`Pair`, `Proofs`), warnings only `Pair`'s two `sorry`s. Its dump showed one generated constant in `Algebraic`,
**`Subadditive.lim.congr_simp`**, made by a `simp only [SimpleGraph.finIndepRatio]` that rewrote under `hsub.lim`
(`LEAN.md`: a generated lemma in a module that asks; two other worktrees, `fs131-wch` and `fs131-wq1`, read
`Subadditive` and could generate the same name — a `GENERATED` dupnames row at a join). Replaced by `rw`; a footer dump
of the old text lists it (10 named constants) and of the new one does not (9) — the control fired. The build of
record is **`build-record2`: `build: OK — 249 of 249 batches, 3 module(s) rebuilt, 1 module(s) with warnings, 7m30s`**
(`data/fs133/icd1/build-record2-full.log`): `✔ Built … Algebraic (2.8s)`, `✔ Built … Fractional (17s)` — **no
warning from either**; `Pair` replays its two `declaration uses 'sorry'` (Q4, Q5) and nothing else. `sorry` in the
files: `Algebraic` 0, `Fractional` 0, `Pair` 2.

**4.2 No statement changed** (Done, item 4), from the kernel's side. `tools/fs133_icd1_moved.py` (FS133-IB2's reader,
its verdicts unchanged, with `--made-public`: the private constant gone, the public one in the same module, full print
identical), `--strict`: `moved/before.out.xz` (stage 1) against `moved/built2.out.xz`
(`moved/before-to-built.txt`): **92 constants — 89 IDENTICAL, 3 MADE-PUBLIC-IDENTICAL (`card_le_indepNum_induce`,
`exists_indep_card_eq_indepNum`, `upperDensity_congr_ae`); `MOVED OK`**; new: twelve private helpers of `Algebraic` and
`Fractional`, nothing public. The same against the dump after the `Defs` edits and the first import (`mid.out.xz`,
`before-to-mid.txt`): the same verdicts, so neither the visibility changes nor `Instances.Seven` moved a stored
statement, and the final dump (after `Mathlib.Analysis.Subadditive`) is identical in all 92. **Controls**:
`moved/control-built.txt` — eleven plants (per made-public constant its public print changed and its private copy left
in; a constant changed in both prints, in the full print only under `--strict`, removed, made an axiom, moved to
another module), each fails the run and is named; unplanted, no failure. **End to end** (`plant/`): a copy of `Pair`
elaborated with FS133-IB2's footer at another path reads **19 of 19 IDENTICAL** to the compiled module
(`copy-verdict.txt`); the same copy with `(_hplant : (0 : ℕ) = 0)` added to `admissibleOn_colourPattern_iff` reads
`DIFFERENT … admissibleOn_colourPattern_iff`, `MOVED FAILED: 1`, exit 1 (`planted-verdict.txt`). **No ruled
difference** of the standing word's kind: two binders of a private helper of mine were dropped as unread, and no binder
of a statement of the three files is unread.

**4.3 The axioms of every public declaration of the module** (Done, item 4). `lean/Axioms.lean` (the eight files and
the ported module; the earlier implementers' tables joined with this job's, `axioms-expect.tsv`) →
`axioms-built.out`; `tools/fs133_icd1_axioms.py` (FS133-IB2's reader with two kinds for outstanding leaves): **125
records — 110 on the standard three, 11 on those and `Spectral.residual_fourier` (`residual_fourier_cross`,
`exists_field` and this job's nine), 4 on `sorryAx` (Q4, Q5 and the two clauses of C133-PAIR, listed as OPEN); `AXIOMS
OK`** (`axioms-verdict.out`) — every record matches the plan's § 5.5, and no record of its standard-three list prints
the import. Controls: a `sorryAx` in a clean record, the import in a clean record, the import missing from an imported
record and a record removed are each reported (`axioms-control.out`); end to end, a theorem on `sorry` planted beside
the 125 prints `[sorryAx]` and is reported, exit 1 (`axioms-planted-verdict.out`).

**4.4 Not run here** (the landing's, on the joined tree): `scripts/axioms.sh`, `vacuity.sh`, `dupnames.sh`,
`assumptions.sh`, `lake lint`. Every private helper's name carries its module.

**4.5 What is left.** **Q5** `exists_admissibleOn_of_ae`: the library's extension lemma
(`exists_proper_ae_eq_of_proper_on_conull`, `Plane/LebesgueNumber`) concludes `f x ≠ f y` for one relation and cannot
express a pattern of forbidden pairs, and `dist_ne_one_of_mem_densitySet` is for one set at distance one; Q5 needs both
generalised — a two-set, radius-`r` density-point lemma (`Plane/DensityPoints` ll. 45–165 rerun) and the Rado
extension for a pair pattern (`exists_proper_ae_eq_of_proper_on_conull`'s proof rerun) — priced from this job's rate
at one long stage. **Q4** `exists_measurable_admissibleAe`: `exists_invariant_of_closed` on the closed set of
admissible labellings of `E`, `exists_field` at `ι := Λ` (local discrete instances on `Λ`), Tonelli over the countable
`(r, a, b)` as in A1, and a positive selection — one to two long stages. Neither begun.

## Drafts for the landing (files this job does not write; each names its slot)

**DD1. `scripts/Axioms.lean`.** Under CLEAN, appended after FS133-IB2's block DC1: its three new lines
`#print axioms SimpleGraph.card_le_indepNum_induce`, `#print axioms SimpleGraph.exists_indep_card_eq_indepNum`,
`#print axioms HadwigerNelson.Plane.upperDensity_congr_ae` (made public here; `Defs`'s block then holds 28 records),
and this job's CLEAN block, `data/fs133/icd1/axioms-block.txt`'s first part (15 records of the three files). Under
IMPORTED, after FS133-IA1's lines for `Spectral.residual_fourier`: the block's second part (9 records), each resting
on `HadwigerNelson.Outside.OAI158.Spectral.residual_fourier` and on nothing else outside the standard three. **The
four records of `Pair` that wait on Q4 and Q5** (`exists_measurable_admissibleAe`, `exists_admissibleOn_of_ae`,
`exists_admissibleOn_univ_iff_ae`, `exists_admissibleOn_univ_iff_algPlane`) print `sorryAx` on this branch: their
lines are in the block, commented, and are filed only when those leaves are proved (the first, third and fourth under
IMPORTED, the second under CLEAN, by the plan's § 5.5).

**DD2. The model for each hypothesis** (`LEAN.md` § The gate). No model was added as a declaration (a public
declaration is outside this job's touches); each note names a library theorem or a term.
- `exists_measurable_indep_of_field` (`hH`, `h01`, `hmean`, `hunit`, all at once, with `δ > 0`): the field that
  `exists_field` gives at the law of `exists_isInvariantLaw_unitDistance` with the indicator of the origin — built
  inside the proof of `IsInvariantLaw.measure_origin_le_mOne`, not as a named term; `δ` is that law's density, the
  ratio of `unitDistance E`, at least `1/7`. With `δ ≤ 0`, `H = 0` meets every hypothesis.
- `IsInvariantLaw.measure_origin_le_mOne` (`h`): the law of `exists_isInvariantLaw_unitDistance` (positive density);
  `isInvariantLaw_dirac` (density `0`).
- `exists_periodic_indep`, `exists_fold_cover` (`hc : c < mOne`): every `c < 1/7`, by `one_seventh_le_mOne`; `c = 0`
  in particular.
- `IsAlgPattern N`: `isAlgPattern_colourPattern`. `AdmissibleOn N univ ℓ` with `AdmissibleAe N ℓ` and Borel fibres:
  `exists_admissible_colourPattern_seven` (the brick colouring, `Λ = Fin 7`) — the model, at once, of
  `exists_admissibleOn_of_ae`'s hypotheses (`hcount`, `hpos` from `isAlgPattern_colourPattern`; `hm` from
  `Measurable`), of `exists_measurable_admissibleAe`'s (`h` by `AdmissibleOn.mono`) and of both clauses of C133-PAIR.
- The vacuity scan will read the binders `GENERIC` (no colouring binder of a tracked predicate); no hypothesis of the
  three files stands for an outside theorem or a hand result (the assumptions step has nothing to declare).

**DD3. `ARCHITECTURE.md` § 3, the row of `Plane/OneClass/Algebraic`**: its imports cell gains
`Instances/Seven` and Mathlib's `Analysis.Subadditive` (Amendment 1 accepted the first; the second is A5's route).
The rows of `Algebraic`, `Fractional` and `Pair`: "**FS-133 (FS133-K1; a skeleton).**" → "**FS-133 (FS133-K1's
statements, FS133-ICD1's proofs; no `sorry` in `Algebraic` and `Fractional`; `Pair` two leaves, Q4 and Q5).**".
The row of `Plane/OneClass/Defs` gains "three lemmas made public by FS133-ICD1 (`upperDensity_congr_ae`,
`card_le_indepNum_induce`, `exists_indep_card_eq_indepNum`; rulings of inventory items 752 and 753)".

**DD4. `CLAUDE.md` § Where the problem stands, "What the kernel holds, beyond the interval"**, a sentence following
the three-and-four-colours sentence (its grade [kernel] on one declared outside theorem, until the port lands it on
the standard three): "**The density equality for the plane** (FS-133): `α₁(ℝ²) = α₁(𝒜²) = m₁(ℝ²)` — the infimum of
`α(G)/|G|` over finite point sets of the plane, and of the algebraic plane, is the supremum of the upper densities of
the Borel (equivalently Lebesgue-measurable) sets with no two points at distance one — and `χ_f,0(ℝ²) = χ_f(ℝ²) =
χ_f(𝒜²) = 1/m₁(ℝ²)`, and `f(n)/n → m₁(ℝ²)` (`[DuczVarga2026]` Conjecture 1, first clause), on the declared outside
theorem `Outside.OAI158.Spectral.residual_fourier` (`OneClass.finIndepRatio_plane_eq_mOne`, `…_algPlane_eq_mOne`,
`fractionalChromaticNumber_plane`, `iSup_fractionalChromaticNumber_plane`, `fractionalChromaticNumber_algPlane`,
`tendsto_minIndepNum_div`); with no import, `m₁(ℝ²) ≤ α₁(ℝ²)`, `χ_f(ℝ²) ≤ 1/m₁(ℝ²)` and `f(n)/n → α₁(ℝ²)`
(`mOne_le_finIndepRatio`, `fractionalChromaticNumber_plane_le`, `tendsto_minIndepNum_div_finIndepRatio`). Not
claimed: any value of `m₁(ℝ²)` or of a chromatic number (only `1/7 ≤ m₁(ℝ²)`); `m₁(ℝ²) = δ_Croft`; that a finite
graph attains `sup χ_f`; anything at a number field's plane; anything at six colours; that the release states any of
this." **C133-PAIR is not yet in the kernel**: its two clauses wait on Q4 and Q5 and are not drafted as held.

**DD5. `LEAN.md` § Searching — Lean**, new bullets.
- "A module that opens `SimpleGraph` reads `ball` as `SimpleGraph.ball`: write `Metric.ball` there (the error is a
  type mismatch at the centre, 'expected `SimpleGraph ?`') (FS133-ICD1)."
- "A private lemma whose statement filters a `Finset` by an undecidable predicate needs `open Classical in` above it;
  a proof that calls it after `classical` elaborates the same instance (FS133-ICD1)."
- "Core's names for `a % b + a / b * b = a` are `Int.emod_add_ediv_mul` and `Int.mul_ediv_add_emod`; there is no
  `Int.emod_add_ediv` or `Int.ediv_add_emod` at the pin (FS133-ICD1)."
- "`Plane.muPer`'s definition records a grid side and a period with no relation between them; the construction of
  `eventually_le_muPer` has the pixel `1/M` dividing the period `ℓ + 2`. A consumer that counts translates of a
  periodic grid union reruns the construction (`OneClass.exists_fold_cover`) (FS133-ICD1)."
- "The brick seven-colouring `sevenBrick.color` is Borel and proper at every pair: a table read at two floors of
  affine functions (`Int.measurable_floor`, `measurable_of_countable` on `ℤ × ℤ`, `Brick.avoids` at `q = 1`);
  `Plane.r7Col` is proper only almost everywhere (FS133-ICD1, `exists_admissible_colourPattern_seven`)."

**DD6. `plans/FS133-kernel-plan.md`**, notes for the planner's record (its §§ 5.3–5.5): A2 is named
`IsInvariantLaw.measure_origin_le_mOne` in the file; A5's route needs `Mathlib.Analysis.Subadditive`; C1 is proved
by a window and copies cut `2` apart (not a trimmed square); C2 by the library's kept squares (not `3/4`-dense
discs); Q3's model is the brick colouring (the plan's pointer is to an a.e.-proper one); `finIndepRatio_algPlane_le_mOne`
rests on the import (§ 5.5 lists it under neither list; it is IMPORTED by its route through C133-ALG).

# FS131-IFR1 — the density form of the collapse: the independence ratio of the plane over every real number field

*de Bruijn, the implementer (Opus 5.5), 2026-10-16. Brief `data/fs131/briefs/FS131-IFR1-density.md` (on `main` at
`eeec277b7`). Worktree `.claude/worktrees/kcl1`, branch `fs131-kfr1` at `a0600cf37` (the planner's skeleton with `main`
merged in). Plan: `plans/FS131-KFR1-density-plan.md` (FS131-KFR1, the planner). Nothing in this milestone is blind.*

## Theorems this phase proved

Seventy-five kernel theorems, each with its axioms as `#print axioms` printed them on the gated library
(`data/fs131/ifr1/axioms-all.txt`; the list is `data/fs131/ifr1/theorems-proved.txt`). Fifty-four rest on the standard three
`[propext, Classical.choice, Quot.sound]`; twenty-one also rest on declared imports, named per line. The list leaves out
`IndepLaw`'s field projections and constructor lemmas, the generated `condOne.congr_simp`, and `Rigidity.ratioAtMost_of_charBound`,
which FS131-ICM1 proved and which this job only made public.

- `HadwigerNelson.Collapse.chromaticNumber_planeOver_sqrt635087_le_seven` (Collapse.Headline) — [kernel], standard three + no_proper_five_coloring, positive_entropy_rigidity, kloosterman_bound
- `HadwigerNelson.Collapse.exists_model_seven` (Collapse.Headline) — [kernel], standard three + kloosterman_bound
- `HadwigerNelson.Collapse.six_le_chromaticNumber_planeOver_sqrt635087` (Collapse.Headline) — [kernel], standard three + no_proper_five_coloring, positive_entropy_rigidity, kloosterman_bound
- `HadwigerNelson.Collapse.stablePrime_F7` (Collapse.Headline) — [kernel], standard three
- `HadwigerNelson.Collapse.weil_142_lt_sixth` (Collapse.Headline) — [kernel], standard three
- `HadwigerNelson.Collapse.card_div_le_finIndepRatio_of_hom` (Collapse.Density.Defs) — [kernel], standard three
- `HadwigerNelson.Collapse.card_div_le_stableRatio` (Collapse.Density.Defs) — [kernel], standard three
- `HadwigerNelson.Collapse.disc7_le_mOne` (Collapse.Density.Defs) — [kernel], standard three
- `HadwigerNelson.Collapse.finIndepRatio_planeOver_le_half` (Collapse.Density.Defs) — [kernel], standard three
- `HadwigerNelson.Collapse.half_le_stableRatio_of_isRamified` (Collapse.Density.Defs) — [kernel], standard three
- `HadwigerNelson.Collapse.isClosed_indepSets` (Collapse.Density.Defs) — [kernel], standard three
- `HadwigerNelson.Collapse.levelTarget_adj_add` (Collapse.Density.Defs) — [kernel], standard three
- `HadwigerNelson.Collapse.localRatio_le_finIndepRatio` (Collapse.Density.Defs) — [kernel], standard three
- `HadwigerNelson.Collapse.localRatio_le_iff` (Collapse.Density.Defs) — [kernel], standard three
- `HadwigerNelson.Collapse.mOne_le_finIndepRatio_planeOver` (Collapse.Density.Defs) — [kernel], standard three
- `HadwigerNelson.Collapse.mOne_le_localRatio` (Collapse.Density.Defs) — [kernel], standard three
- `HadwigerNelson.Collapse.measurableSet_indepSets` (Collapse.Density.Defs) — [kernel], standard three
- `HadwigerNelson.Collapse.nonempty_indepLaw` (Collapse.Density.Defs) — [kernel], standard three
- `HadwigerNelson.Collapse.ratioAtMost_of_stableRatio_le` (Collapse.Density.Defs) — [kernel], standard three
- `HadwigerNelson.Collapse.ratioAtMost_of_thickAt` (Collapse.Density.Defs) — [kernel], standard three
- `HadwigerNelson.Collapse.setEdgeNull_empty` (Collapse.Density.Defs) — [kernel], standard three
- `HadwigerNelson.Collapse.sixth_lt_mOne` (Collapse.Density.Defs) — [kernel], standard three
- `HadwigerNelson.Collapse.stableRatio_le_finIndepRatio` (Collapse.Density.Defs) — [kernel], standard three
- `HadwigerNelson.Collapse.stableRatio_le_localRatio` (Collapse.Density.Defs) — [kernel], standard three
- `HadwigerNelson.Collapse.stableRatio_le_of_ratioAtMost` (Collapse.Density.Defs) — [kernel], standard three
- `HadwigerNelson.Collapse.stableRatio_le_of_thickAt` (Collapse.Density.Defs) — [kernel], standard three
- `HadwigerNelson.Collapse.stableRatio_le_one` (Collapse.Density.Defs) — [kernel], standard three
- `HadwigerNelson.Collapse.IndepLaw.density_le_finIndepRatio` (Collapse.Density.Upper) — [kernel], standard three
- `HadwigerNelson.Collapse.IndepLaw.density_le_localRatio` (Collapse.Density.Upper) — [kernel], standard three + positive_entropy_rigidity
- `HadwigerNelson.Collapse.IndepLaw.density_le_max_of_unramified` (Collapse.Density.Upper) — [kernel], standard three + positive_entropy_rigidity
- `HadwigerNelson.Collapse.IndepLaw.measurePreserving_shift` (Collapse.Density.Upper) — [kernel], standard three
- `HadwigerNelson.Collapse.IsIndicatorSpectral.integral_unit` (Collapse.Density.Upper) — [kernel], standard three
- `HadwigerNelson.Collapse.IsIndicatorSpectral.rotInv` (Collapse.Density.Upper) — [kernel], standard three
- `HadwigerNelson.Collapse.exists_extension_one` (Collapse.Density.Upper) — [kernel], standard three
- `HadwigerNelson.Collapse.exists_indepLaw` (Collapse.Density.Upper) — [kernel], standard three
- `HadwigerNelson.Collapse.exists_indepLaw_TA` (Collapse.Density.Upper) — [kernel], standard three + positive_entropy_rigidity
- `HadwigerNelson.Collapse.exists_isIndicatorSpectral` (Collapse.Density.Upper) — [kernel], standard three
- `HadwigerNelson.Collapse.exists_slice_set` (Collapse.Density.Upper) — [kernel], standard three
- `HadwigerNelson.Collapse.exists_window_bound` (Collapse.Density.Upper) — [kernel], standard three
- `HadwigerNelson.Collapse.finIndepRatio_planeOver_le_cayR` (Collapse.Density.Upper) — [kernel], standard three
- `HadwigerNelson.Collapse.integral_condOne_mul_eq_zero` (Collapse.Density.Upper) — [kernel], standard three + positive_entropy_rigidity
- `HadwigerNelson.Collapse.ratioLe_levR_range_of_unramified` (Collapse.Density.Upper) — [kernel], standard three
- `HadwigerNelson.Collapse.rowsEdgeNull_levelRows_set` (Collapse.Density.Upper) — [kernel], standard three
- `HadwigerNelson.Collapse.setIntegral_compl_TA_re_one` (Collapse.Density.Upper) — [kernel], standard three
- `HadwigerNelson.Collapse.tendsto_measure_ne_one` (Collapse.Density.Upper) — [kernel], standard three
- `HadwigerNelson.Collapse.IndepLaw.density_le_notThick` (Collapse.Density.Headline) — [kernel], standard three + positive_entropy_rigidity, kloosterman_bound
- `HadwigerNelson.Collapse.cliqueFree_three_planeOver_of_sqrt_three_notMem` (Collapse.Density.Headline) — [kernel], standard three
- `HadwigerNelson.Collapse.exists_finite_triangleFree_six_chromatic` (Collapse.Density.Headline) — [kernel], standard three + no_proper_five_coloring, positive_entropy_rigidity, kloosterman_bound
- `HadwigerNelson.Collapse.exists_triangleFree_ratio_lt` (Collapse.Density.Headline) — [kernel], standard three + positive_entropy_rigidity, kloosterman_bound
- `HadwigerNelson.Collapse.finIndepRatio_planeOver_deGrey` (Collapse.Density.Headline) — [kernel], standard three + positive_entropy_rigidity, kloosterman_bound
- `HadwigerNelson.Collapse.finIndepRatio_planeOver_eq_iSup_density` (Collapse.Density.Headline) — [kernel], standard three + positive_entropy_rigidity
- `HadwigerNelson.Collapse.finIndepRatio_planeOver_eq_localRatio` (Collapse.Density.Headline) — [kernel], standard three + positive_entropy_rigidity
- `HadwigerNelson.Collapse.finIndepRatio_planeOver_eq_mOne_of_thick` (Collapse.Density.Headline) — [kernel], standard three + positive_entropy_rigidity
- `HadwigerNelson.Collapse.finIndepRatio_planeOver_eq_plane_of_thick` (Collapse.Density.Headline) — [kernel], standard three + positive_entropy_rigidity
- `HadwigerNelson.Collapse.finIndepRatio_planeOver_sqrt635087` (Collapse.Density.Headline) — [kernel], standard three + positive_entropy_rigidity, kloosterman_bound
- `HadwigerNelson.Collapse.fractionalChromaticNumber_le_card_div` (Collapse.Density.Headline) — [kernel], standard three
- `HadwigerNelson.Collapse.fractionalChromaticNumber_planeOver_deGrey` (Collapse.Density.Headline) — [kernel], standard three + positive_entropy_rigidity, kloosterman_bound
- `HadwigerNelson.Collapse.fractionalChromaticNumber_planeOver_eq` (Collapse.Density.Headline) — [kernel], standard three + positive_entropy_rigidity
- `HadwigerNelson.Collapse.fractionalChromaticNumber_planeOver_eq_plane_of_thick` (Collapse.Density.Headline) — [kernel], standard three + positive_entropy_rigidity
- `HadwigerNelson.Collapse.fractionalChromaticNumber_planeOver_sqrt635087` (Collapse.Density.Headline) — [kernel], standard three + positive_entropy_rigidity, kloosterman_bound
- `HadwigerNelson.Collapse.inv_le_localRatio_of_colorable` (Collapse.Density.Headline) — [kernel], standard three + positive_entropy_rigidity
- `HadwigerNelson.Collapse.inv_localRatio_lt_five` (Collapse.Density.Headline) — [kernel], standard three
- `HadwigerNelson.Collapse.le_volume_selection` (Collapse.Density.Headline) — [kernel], standard three
- `HadwigerNelson.Collapse.localRatio_eq_mOne_of_thick` (Collapse.Density.Headline) — [kernel], standard three
- `HadwigerNelson.Collapse.sqrt_three_notMem_F635087` (Collapse.Density.Headline) — [kernel], standard three
- `HadwigerNelson.Plane.fifth_lt_mOne` (Plane.TriangularPacking) — [kernel], standard three
- `HadwigerNelson.Plane.isIndepSet_triPacking` (Plane.TriangularPacking) — [kernel], standard three
- `HadwigerNelson.Plane.linearIndependent_triLattice` (Plane.TriangularPacking) — [kernel], standard three
- `HadwigerNelson.Plane.measurableSet_triPacking` (Plane.TriangularPacking) — [kernel], standard three
- `HadwigerNelson.Plane.pi_div_le_mOne` (Plane.TriangularPacking) — [kernel], standard three
- `HadwigerNelson.Plane.triCentre_sub` (Plane.TriangularPacking) — [kernel], standard three
- `HadwigerNelson.Plane.triPacking_periodic` (Plane.TriangularPacking) — [kernel], standard three
- `HadwigerNelson.Plane.two_le_dist_triCentre` (Plane.TriangularPacking) — [kernel], standard three
- `HadwigerNelson.Plane.upperDensity_triPacking` (Plane.TriangularPacking) — [kernel], standard three
- `HadwigerNelson.Plane.zero_mem_triPacking` (Plane.TriangularPacking) — [kernel], standard three

## Stage 1 — SAVED: the readback

### 1.1 The quotations

`data/fs131/ifr1/quote_check.py` (a copy of FS131-KFR1's checker) reads every block quotation of the brief (a run of `> `
lines closed by `> — source:`) and looks for it, verbatim, in its named source, in this worktree at `a0600cf37`. **All
fourteen are verbatim** (`data/fs131/ifr1/quote_check.out`, exit 0): W2 (`data/fs131/REQUEST-2026-10-13.md`); ledger row 129
(`LEDGER.md`); the six head statements (`Collapse/Density/Headline.lean`); `localRatio` (`Collapse/Density/Defs.lean`);
FS103-F-TJ (`plans/FS103-derivation.md`); inventory items 1008, 1017, 1021 and 1022 (`plans/FS131-close-inventory.md`).
Control: `--plant` changes one character of the first quotation and the check reports `MISMATCHES: 1`, exit 1
(`data/fs131/ifr1/quote_check_plant.out`). Run against `main`'s tree the skeleton's files are absent, as they should be (the
skeleton lives on this branch only). No mismatch; no finding about the brief.

### 1.2 The target

Four modules typed by the planner, 81 `sorry` leaves (22 in `Collapse/Density/Defs`, 18 in `Collapse/Density/Upper`, 22 in
`Collapse/Density/Headline`, 9 in `Plane/TriangularPacking` — the coordinator's count, item 1021; to be recounted at the first
build). The head statement, at every real number field with no hypothesis but `[NumberField F]`:

> theorem finIndepRatio_planeOver_eq_localRatio [NumberField F] :
>     ((unitDistance ℂ).induce (planeOver F)).finIndepRatio = localRatio F := by
> — source: Proofs/HadwigerNelson/Collapse/Density/Headline.lean

with `localRatio F = max mOne (⨆ P : StablePrime F, stableRatio P)`: `α₁(F²) = max(m₁(ℝ²), ⨆_P r_P)`. Beside it B-AMEN
(`α₁(F²)` is the best density of an invariant random independent set), `χ_f(F²) = 1/α_loc(F)`, the fractional collapse at
`Thick F c`, `0 ≤ c < 1/5` and at the two fields, TJ's first clause, ROUND, TF, the finite triangle-free six-chromatic
unit-distance graph, and the model at `k = 7`.

### 1.3 The three rulings (item 1021), each a ruled change in the statement comparison

1. **TJ's second clause is added** (about 110 lines): "as a construction the mixing selection per class keeps only density
   `≥ (δ − ϑ)/(1 − ϑ)`, `ϑ = λ*/(1 + λ*)`" (FS103-F-TJ). Its statement is mine to type; it is a new public theorem, listed in
   the comparison. If it needs machinery far past 110 lines I stop at it and message the coordinator.
2. **`ratioAtMost_of_charBound` is made public** in `Rigidity/ClassRatio` (l. 92): the word `private` removed and a docstring
   added, nothing else; the new modules call it by name. Done in the first build, since its dependents recompile. In the
   comparison: the constant moves from `_private.…ratioAtMost_of_charBound` to `HadwigerNelson.Rigidity.ratioAtMost_of_charBound`
   with the same stored type, and every internal constant under it is renamed (LEAN.md, FS131-LCH1: compare by prefix).
3. **Item 1005's two splits and the model at `k = 7` go into `Collapse/Headline`** beside
   `chromaticNumber_planeOver_sqrt635087_six_or_seven`, unless that needs an import `Collapse/Headline` lacks. The splits need
   nothing new. The model at `k = 7` needs the plane's seven-colouring (`Instances.Seven`, which the skeleton imported into
   `Collapse/Density/Headline`): whether `Collapse/Headline`'s closure holds it is checked at the move; the record says which.
   In the comparison: the moved constants leave `Collapse/Density/Headline` and appear in `Collapse/Headline` with the same
   stored type up to the module name in hygienic binder names (LEAN.md, FS131-ITT1).

### 1.4 The order of work

The plan's order (§ 3.4): D1 (`Collapse/Density/Defs`) and D4 (`Plane/TriangularPacking`), which hold no MR and no spectral
theory; then D2's count and Følner leaves; then D2's dichotomy and extension; then D3. Ruling 2 goes into the first build,
with D1. A saved stage after each module.

### 1.5 The statement dump, before the first proof edit

`data/fs131/ifr1/lean/StatementDump.lean` (a copy of FS131-ICO2's dumper with this job's six modules: the four new ones,
`Rigidity/ClassRatio`, `Collapse/Headline`) printed the compiled skeleton's every constant — the build checked current first
(`lake build --no-build Proofs`, exit 0, "All targets up-to-date", `data/fs131/ifr1/uptodate0.log`) — before any edit:
`data/fs131/ifr1/statements-before.txt.gz` (530 constants: 184, 230, 49, 28, 26, 13).

## Stage 2 — SAVED: the leaves

Every `sorry` of the skeleton is replaced by a proof, in the plan's order (D1 and D4, then D2, then D3), each module
elaborated by `lake env lean` (iteration only) before the build; ruling 2 went into the first build
(`data/fs131/ifr1/build1.log`: `build: OK — 738 of 738 batches, 21 module(s) rebuilt`, 22 m 50 s, the skeleton's `sorry`
warnings only). Commit `1eea2ae5f` holds the proofs.

### 2.1 What each module holds now (lines: skeleton → proved)

| module | lines | the leaves, and what the proofs added |
|---|---|---|
| D1 `Collapse/Density/Defs` | 207 → 399 | all 22 leaves; private helpers `finite_quot`, `card_quot_ne`, `not_mem_interior_disc7`, `indepSets_eq_iInter`; the owed spec example `localRatio ⊥ = 2⁻¹` (an `example`, at `UpperHalf.exists_stablePrime_rat`) |
| D4 `Plane/TriangularPacking` | 71 → 218 | all 9 leaves; one public helper `triCentre_sub` (see § 2.3) and private `triPacking_add`, `volume_ball_half` |
| D2 `Collapse/Density/Upper` | 191 → 1460 | all 18 leaves; private helpers, each the one-class copy of a held colouring proof named in its comment (`Collapse/Colouring`'s two-step invariant law, `OneClass/InvariantLaw`'s Følner averages and `abs_sum_add_sub_sum_le`, `Collapse/Dichotomy`'s indicator correlations, conditional laws, rotation of the factor and support set, `Collapse/Slice`'s extension, `Rigidity/CountDescent`'s rows and `false_of_three_quarters`); Mathlib's `tendsto_measure_of_ae_tendsto_indicator_of_isFiniteMeasure` re-proved privately (its module is outside the closure; an import would move stored instances) |
| D3 `Collapse/Density/Headline` | 203 → 551 | all leaves but the moved block (§ 2.2); TJ's second clause `le_volume_selection` (ruling 1); private `eventually_stableRatio_le` (`r_P → 0` by Weil, `thick_of_forall_thickAt`'s choice of residue size) and `iSup_stableRatio_lt` for TJ's first clause |
| `Collapse/Headline` | 247 → 315 | the moved block (ruling 3) with its proofs; private `isSquare_d7`, `le_of_isSquare_d7` (`decide +kernel` at the eighteen primes) |
| `Rigidity/ClassRatio` | +5 −1 | `private` removed from `ratioAtMost_of_charBound`, a docstring added (ruling 2) |

### 2.2 The three rulings, as done

1. **TJ's second clause** is `Collapse.le_volume_selection` in D3, about 75 lines — inside the ruling's 110. The mixing
   selection keeps the points `z` whose fibre `W_z` has Haar mass above `ϑ`; the clause is that it keeps only Markov's
   density: if `W ⊆ ℂ × K` holds at least `δ` of a window `Q × K`, the selected points fill at least `(δ − ϑ)/(1 − ϑ)` of `Q`
   (`0 ≤ ϑ < 1`). The threshold's role (above `λ*/(1 + λ*)` two heavy fibres one unit edge apart cannot carry null edges) is
   `Collapse.not_both_ge_of_mixing`, held; the docstring says so. Its statement is mine (the ruling's), listed in the
   comparison's `ALLOWED_PUBLIC`.
2. **`ratioAtMost_of_charBound` public**, called by name in `Collapse.ratioAtMost_of_thickAt`. Its statement still names the
   private `CharBound`; D1 inhabits it by a lambda that the elaborator unfolds (`CharBound P m κ` is a `∀`), with no
   `open private`.
3. **The splits and the model at `k = 7` are in `Collapse/Headline`**, right after
   `chromaticNumber_planeOver_sqrt635087_six_or_seven`: `Collapse/Headline`'s closure holds everything they need (the plane's
   seven-colouring is `Bridge.chromaticNumber_complex_le_seven`, read through `chromaticNumber_le_iff_colorable`; no
   `Instances/Seven`). D3 keeps its import of `Instances/Seven` unchanged (dropping an import can move stored instances).

### 2.3 Choices, with the alternative

- **`triCentre_sub` is public in D4** (`triCentre m n − triCentre m' n' = triCentre (m − m') (n − n')`): the lattice's
  linearity, used twice; listed in the comparison. *Alternative:* private — declined, it is the lattice's API.
- **Every other helper is private**, each with a comment naming what it copies. The planner's `PatternLaw` refactor is not
  done: D2's copies came to about 1,270 lines against the plan's 1,370, written in one pass and elaborated in four rounds whose
  errors were names, the elaboration order of `measurable_pi_apply` against set-builder notation, and one lemma outside the
  closure — none in the mathematics; a pattern form would save under a third of that and would have to refactor landed modules.
  Recommendation unchanged: per class now; the refactor when someone next edits `Collapse/`.
- **`disc7_le_mOne` reads the interior of `disc7 0`**: `disc7_unitPair_mem_sphere` does not say which colour's sphere, so the
  proof shows directly that a boundary point of a class's disc is not interior to the class (two discs of one class are
  `√21/2 > 2` apart).
- **`exists_slice_set`'s sample is chosen by the first-moment method** (`exists_notMem_null_laverage_le` off the null set of
  samples whose edges are not null), not by Tonelli twice.

### 2.4 The re-price

The plan priced 2,650 lines (D1 380, D2 1,370, D4 250, D3 650) and TJ's second clause 110. Written: about 2,050 (D1 +192,
D2 +1,269, D4 +147, D3 +348 net of the moved block, `Collapse/Headline` +68, TJ's second clause included). By time: the first
copy leaf (D2's Følner step, `exists_shiftInvariant_indep`, 130 lines) and the first new leaf (D1's averaging lemma
`card_div_le_finIndepRatio_of_hom`, 40 lines) each elaborated after one round of name fixes; the whole of D2 took four
elaboration rounds. The total moved down, not up: no message to the coordinator was owed.

## Stage 3 — SAVED: the gate, on `e849029c3`

### 3.1 The way there

- **Spec examples** for every definition the skeleton left without one (`IndepSets`, `SetEdgeNull`, `indShift`,
  `IsIndicatorSpectral`, `condOne`, `setCol`, `triCentre`/`triPacking`, `d7`, `F7`): `86e176fc3`, built green
  (`build3.log`).
- **`main` merged** (the p-adic plane, `785a46e77`; inventory item 1032) at `57ef7d145`. `Proofs.lean` keeps both import
  blocks; the coordinator's files (`plans/FS131-close-inventory.md`, `plans/SESSION-HANDOFF-2026-10-16.md`,
  `data/fs131/briefs/scripts/mk-fs131-iqp3.py`) are taken as on `main`. The p-adic modules' `.olean`s were copied by checksum
  from `main`'s tree (only `PadicPlane/*` and `Arith/FibreCert7*`), then `build4.log`: green, three modules rebuilt
  (`PadicPlane.Tower`, `PadicPlane.Values`, the root); none of this job's modules was recompiled, so their stored terms are
  those the comparison read.
- **The first gate** (on `c28039837`; logs in `data/fs131/ifr1/gate-first/`, untracked) was red in two steps. The assumptions
  step had 40 `unlisted-consumer` rows, which `--write-ledger` writes. Lint was red: `unusedArguments` on
  `stableRatio_le_of_ratioAtMost` and `IndepLaw.density_le_finIndepRatio`, each with an unread `[NumberField ↥F]`. I messaged the
  coordinator. **The ruling (inventory item 1034): drop both**, ruled changes of items 993 and 998's kind, checked by the
  comparator's one-binder rule. Both binders were written in the theorems' own signatures, not in a section `variable`, so
  `omit … in` does not apply; the binder's text is deleted from the signature (`fb029ddc0`). Then `build5.log`: green, four
  modules rebuilt, 0 warnings.
- **`--write-ledger`** wrote the 40 `RESTS` rows (`write-ledger.log`; 25 on `positive_entropy_rigidity`, 12 on
  `kloosterman_bound`, 3 on `no_proper_five_coloring`; 21 public theorems and 7 private declarations). The second gate (on
  `6eb1e875c`, `data/fs131/ifr1/gate-second/`) was green in every step. Its digest flagged the vacuity baseline's header as stale;
  the header is updated in `e849029c3`. The full gate was run again on that commit, the commit of record.

### 3.2 The gate on `e849029c3` (`data/fs131/ifr1/gate/`, the steps of `data/fs131/clone1/run-gate.sh`)

| step | result | wall |
|---|---|---|
| uptodate (`lake build --no-build Proofs`) | exit 0 | 5 s |
| `sorry` (narrow scan) | 0 lines | — |
| line-initial `axiom` | 5 lines, as on `main`: the three declared imports, two inside doc comments (`Rigidity/Entropy`, `Sat/Lrat`) — none of this job's | — |
| dupnames / self-test | exit 0 / exit 0 (15 controls) | 5 s / 27 s |
| axioms / self-test | exit 0 / exit 0 (23 controls) | 14 s / 326 s |
| vacuity / self-test | exit 0 / exit 0 (65 controls) | 204 s / 161 s |
| assumptions / self-test | exit 0 / exit 0 (21 controls, 33 checks) | 147 s / 144 s |
| architecture (`tools/check_architecture.py`) | exit 0, `RESULT: PASS` | — |
| lint (`lake lint --no-build -- --no-build --trace`) | exit 0, 14 linters `(2/2) Passed!` | 15 s |
| digests (axioms, vacuity, assumptions) | exit 0; stale flags only for `CLAUDE.md`'s recorded counts (drafted, stage 5) | — |

The header reads `HEAD=e849029c3… tracked-modified=0`. At the end the pass saw one tracked file modified: this record, written
during the pass. No gate input changed.

### 3.3 The counts, against the latest landed gate (FS131-IQP3's, on `e3e1dbb73`; `data/fs131/iqp3/gate/` on `main`)

- **The axiom audit**: 11,466 → 11,572 records (+106 public records of the six modules, each filed by
  `tools/fs131_ifr1_audit_block.py` from the kernel's print `data/fs131/ifr1/axioms-all.txt`: D1 41, D4 12, D2 25, D3 20, the
  seven moved into `Collapse/Headline`, and `Rigidity.ratioAtMost_of_charBound`, public now). Clean 10,804 → 10,888 (+84).
  Axiom-free 574 → 575 (+1: `Collapse.d7`). Imported 83 → 104 (+21: one on Weil's bound alone, eleven on E–L alone, six on both,
  three on all three). Declared purchases 5 → 5. The audit's two state controls moved by the same 21
  (`scripts/axioms-controls.txt`: `imported=104`, `105`).
- **The assumptions step**: `rests` 105 → 145 (the 40 rows above). The rest are unchanged: `axioms=3 named=19 inline=14
  outside=7 ours=21 open=5 takes=109 mentions=2`. No hypothesis was added or retired. `IsIndicatorSpectral`, `SetEdgeNull` and
  `Thick`/`RatioAtMost` taken as hypotheses raise no `undeclared-never-concluded`: theorems conclude them
  (`exists_isIndicatorSpectral`, `setEdgeNull_empty`, `exists_slice_set`, `thick_sqrt635087`, `ratioAtMost_of_thickAt`).
- **The vacuity scan**: `declarations` 22,431 → 22,548 (+117: the four modules' 109, the 7 moved, and
  `ratioAtMost_of_charBound` now public; `data/fs131/ifr1/vacuity-new.txt` counts them by module). `refutations-skipped`
  243 → 245. The two are `Collapse.cliqueFree_three_planeOver_of_sqrt_three_notMem` (`CliqueFree 3` unfolds to `∀ t, ¬ …`) and
  `Plane.isIndepSet_triPacking` (independence unfolds to `… → ¬ Adj`); I read both, and neither refutes anything. `sites` stays
  1,458 and the rest stays `vacuous=0 stale=0 declared=3 witnessed=38 generic=1415 unknown=2`: the scan is silent on these
  modules. So, as `LEAN.md` § The gate asks, here is each structure of hypotheses with its model:
  - `μ : IndepLaw F` at every number field: `nonempty_indepLaw` (the point mass at the empty set, density 0), and a positive
    density from `exists_indepLaw`. At `ℚ(√635087)` that law's density lies between `α₁ = m₁ > 1/5` and `α_loc = m₁ ≤ 0.2470`.
    So it inhabits `density_le_notThick`'s `δ ∈ (0, 1/2)`; this is composed from kernel theorems, not stated as one.
  - `IsIndicatorSpectral μ σ`: `exists_isIndicatorSpectral`, for every `μ`.
  - "spectrum on `T + A`": every `σ` of the law `exists_indepLaw_TA` returns.
  - `SetEdgeNull F W`: `setEdgeNull_empty`; with positive measure, `exists_slice_set`.
  - "no ramified stable prime ∧ a uniform `RatioAtMost P c`": at `ℚ(√635087)`, by `thick_sqrt635087` with
    `not_isRamified_of_thickAt` and `ratioAtMost_of_thickAt`. This is composed, not stated.
  - `Thick F c`, `0 ≤ c < 1/5`: `thick_sqrt635087`, `weil_103_lt_fifth`.
  - `(F²).Colorable k`: at `k = 7` at every `F` (`exists_model_seven`'s last clause, and the plane's colouring restricted). At
    `k ≤ 5` it is empty at `ℚ(√635087)` given `Outside.OAI158.no_proper_five_coloring`.
  - `√3 ∉ F`: `sqrt_three_notMem_F635087`.
  - `le_volume_selection`'s window: `W = Q ×ˢ univ` at `δ = 1` (with `ϑ ∈ [0, 1)`), or `W = ∅` at `δ = 0`.
- **Dupnames**: no name declared twice. 31 generated on demand, as before; this landing's one generated constant,
  `Collapse.condOne.congr_simp` (from a `filter_upwards`/`simp` over `condOne`), is in one module only.
- **Lint**: 14 linters, `Linting passed for Proofs.`
- **Spec examples**: every `example` of the four modules and `Collapse/Headline` elaborates with the build. The skeleton's
  examples are unchanged in text.
- **The statement comparison** (`tools/fs131_ifr1_statements.py` against `data/fs131/ifr1/statements-before.txt.gz`, the
  skeleton's compiled library dumped before any edit; after-dump `data/fs131/ifr1/statements-after.txt.gz`, from `build5`, the
  build the gate ran on): **CLEAN** (`data/fs131/ifr1/statements.out`). The ruled changes:
  - PUBLICIZED `Rigidity.ratioAtMost_of_charBound` (ruling 2): the stored type is unchanged.
  - MOVED, to `Collapse/Headline` (ruling 3), each with its stored type and value unchanged: `six_le_…`, `…_le_seven`, `d7`,
    `F7`, `stablePrime_F7`, `weil_142_lt_sixth`, `exists_model_seven`.
  - RULED (item 1034): the two dropped binders, each removed exactly.
  - ADDED public: `le_volume_selection` (ruling 1) and `Plane.triCentre_sub`; everything else added is private or generated.

  Its six plants all fired: a changed type, a dropped constant, an unlisted public constant, a moved constant changed, the
  publicized constant changed, and a ruled binder a near miss.

### 3.4 Negative controls watched red

- The quotation checker's plant (stage 1).
- The comparator's six plants.
- The audit-block generator's three plants (an unknown axiom, a `sorryAx`, a misfiled record; `audit-block-plant.out`).
- Each self-test's own planted controls: dupnames 15, axioms 23, vacuity 65, and assumptions 21 controls with 33 checks.
- Lint, red on a real finding before the ruling (the first gate).
- The assumptions step, red on its 40 rows before they were written.
- The audit's state controls, red at their old counts against the new library (§ 3.5).
- Not run: a planted lint fault, as at FS131-ICO2. The lint step is the driver over the whole library, its control was watched
  at FS131-LGT1, and here its red was seen on a real finding.

### 3.5 The audit's state controls, red before their input moved

After the gate, in the working tree only: `scripts/axioms-controls.txt` was set back to its counts before this landing
(`imported=83`, `84`) and `./scripts/axioms.sh --self-test` was run against this library (`data/fs131/ifr1/state-controls-red.log`).
`baseline` and `imported_declared` both read red: "passed; expected COUNTS imported=83" (and `84`), got `imported=104` (`105`
with the plant). The other 21 controls behave as in the gate. Then the file was restored by `git checkout`; `git status`
confirms it matches `e849029c3`.

## Stage 4 — SAVED: the read-aloud

Each head statement is read as the kernel stores it (the dump `data/fs131/ifr1/statements-after.txt.gz`), against ledger row 129
and the entries of `plans/FS103-derivation.md`. The notation:
- `α₁(G)` is `G.finIndepRatio`: the infimum, over nonempty finite vertex sets `S`, of `α(G[S])/|S|`.
- `F²` is the induced unit-distance graph on `planeOver F`.
- `m₁` is `Plane.mOne`: the supremum of the upper densities of Borel sets of the plane with no unit pair. It is FS-133's
  constant, `= α₁(ℝ²)` by `OneClass.finIndepRatio_plane_eq_mOne`.
- `r_P = stableRatio P`: the supremum, over levels `m ≥ 1` and independent sets `s` of `levelTarget P m`, of `|s|/|𝓞 ⧸ P^m|`.
- `α_loc(F) = localRatio F = max(m₁, ⨆_P r_P)`.

- **FS103-F-FRAC, row 129's field clause.**
  `finIndepRatio_planeOver_eq_localRatio [NumberField F] : α₁(F²) = localRatio F` matches "`α₁(F²) = α_loc(F)`,
  `α_loc(F) = max(m₁(ℝ²), sup_v r_v)`" term for term. The per-law bound is `IndepLaw.density_le_localRatio`: "every
  `R ⋊ U`-invariant random independent set … has density `≤ α_loc(F)`".
  - **Wider than the entry and the row.** There is no MR hypothesis (MR⁺ is `Rigidity.mrPlus`, on the declared
    `positive_entropy_rigidity`), no "totally real", no `R = O′`, and no exception of row 100.
  - The entry's unconditional clause ("an invariant set of density `> α_loc(F)` gives an SP witness") has no statement. The
    kernel has no SP witness (`Collapse.not_isSPWitness`), so the clause would be a statement about nothing.
  - *Reading note (i).* `levelTarget P m` takes every norm-one residue as a connection; the derivation takes the image of `U`.
    The two agree at an unramified `P` (`image_levR_unitVectors_of_unramified`). At a ramified `P` both sides are `1/2`
    (`half_le_stableRatio_of_isRamified`, `finIndepRatio_planeOver_le_half`).
  - *Reading note (ii).* The invariant laws are laws on `ℤ[U_F] → Bool` carried by the independent sets of `Cay(ℤ[U], U)`
    (`IndepLaw`), as in F §2.3; the entry says "of `F²`". `α₁(F²)` is the same number either way:
    `α₁(F²) ≤ α₁(Cay(R, U))` (`finIndepRatio_planeOver_le_cayR`), and every bound in the chain is read at `F²`.
- **FS103-B-AMEN.** `finIndepRatio_planeOver_eq_iSup_density : α₁(F²) = ⨆ μ : IndepLaw F, μ.density` is "`α₁(F²) = α_inv(F²)`",
  with `α_inv` the best density of an invariant law.
  - Its two halves are `exists_indepLaw` (Følner) and `IndepLaw.density_le_finIndepRatio` (averaging; at every subfield of
    `ℝ`, after item 1034's drop).
  - "`α_inv(F²) ≥ α_loc(F)` (pullbacks)" is `localRatio_le_finIndepRatio` with the head statement.
  - The entry is "with no MR". The three inequalities (`exists_indepLaw`, `density_le_finIndepRatio`,
    `localRatio_le_finIndepRatio`) rest on the standard three, as the entry says. The equality is stated through the per-law
    bound, so it rests on `positive_entropy_rigidity`.
- **`χ_f`.** `fractionalChromaticNumber_planeOver_eq : χ_f(F²) = (localRatio F)⁻¹` is row 129's title, "the fractional
  local–global principle", for `χ_f` itself.
- **The fractional collapse.** `finIndepRatio_planeOver_eq_mOne_of_thick`, `…_eq_plane_of_thick` and
  `fractionalChromaticNumber_planeOver_eq_plane_of_thick` hold at `Thick F c` with `0 ≤ c < 1/5`, the collapse's own hypothesis:
  `α₁(F²) = m₁ = α₁(ℝ²)` and `χ_f(F²) = χ_f(ℝ²)`. At `ℚ(√635087)` and de Grey's field they hold with no hypothesis (`…_sqrt635087`,
  `…_deGrey`). `localRatio_eq_mOne_of_thick` rests on the standard three: Hoffman's bound with `m₁ > 1/6` needs no Weil. This is
  not in row 129 as filed; it is the planner's finding 2, ruled in by item 1008.
- **FS103-F-TJ, first clause.** `IndepLaw.density_le_notThick`: an invariant law of density `δ ∈ (0, 1/2)` has
  `δ ≤ max(m₁, ⨆_{P ∈ N_δ} r_P)`, where `N_δ` is the stable primes that are `c`-thick for no `c < δ/(1 − δ)`.
  - This is the entry's (A_δ), "`N_δ` the places with `λ*_v ≥ δ/(1−δ)`". The set of `c` at which `P` is `c`-thick is
    `[λ*_P, ∞)`, so "thick for no `c < t`" is `λ*_P ≥ t`.
  - Its case (B) is empty in the kernel (MR⁺ proved), and there is no "totally real".
  - It reads Weil's bound: the thick primes' ratios stay below `δ` together because `r_P → 0` (`eventually_stableRatio_le`).
- **FS103-F-TJ, second clause** (ruling 1). `le_volume_selection`: for measurable `W ⊆ ℂ × K` holding at least `δ` of `Q × K`,
  and `0 ≤ ϑ < 1`, the points of `Q` whose fibre mass exceeds `ϑ` fill at least `(δ − ϑ)/(1 − ϑ)` of `Q`. This is "the mixing
  selection per class keeps only density `≥ (δ − ϑ)/(1 − ϑ)`".
  - The entry's threshold is `ϑ = λ*/(1 + λ*)`. The theorem holds at every `ϑ ∈ [0, 1)`, that one included.
  - Why the selection needs `ϑ` above `λ*/(1 + λ*)` is `Collapse.not_both_ge_of_mixing` (held), named in the docstring, not
    restated.
  - "Only" is read as: the lower bound is all that is claimed. That the bound is sharp is not stated.
- **FS103-F-ROUND.** `inv_le_localRatio_of_colorable` (a `k`-colouring of `F²` gives `1/k ≤ α_loc(F)`, the integer reading of
  `χ(F²) ≥ ⌈1/α_loc⌉`) and `inv_localRatio_lt_five (F : Subfield ℝ) : (localRatio F)⁻¹ < 5`: "this route never gives six".
  - The entry's number, `1/δ_Croft ≤ 4.35987`, is not the kernel's. The kernel holds `m₁ ≥ π/(8√3) = 0.2267…`
    (`Plane.pi_div_le_mOne`, the triangular packing), so `1/α_loc ≤ 1/m₁ < 4.42 < 5`. That is enough for the clause.
  - Croft's `0.22936` is not formalized here.
- **FS103-F-TF.** `exists_triangleFree_ratio_lt : ∀ ε > 0, ∃ S : Finset ℂ, S.Nonempty ∧ CliqueFree 3 ∧ α(S) < (m₁ + ε)|S|`
  is "a finite unit-distance graph without triangles has independence ratio `≤ m₁(ℝ²) + ε`" (strict here), with no MR.
  - The entry's "`≤ 0.24699 + ε`" is `m₁ ≤ 0.2470` (`Plane.mOne_le_of_oneAvoidingDensityBound`), not restated.
  - "`χ_f ≥ 4.0487 − O(ε)`" is not stated.
- **The corollary.** `exists_finite_triangleFree_six_chromatic : ∃ S : Finset ℂ, CliqueFree 3 ∧ χ = 6` is a finite
  triangle-free unit-distance graph of chromatic number exactly six. It is read off `6 ≤ χ(ℚ(√635087)²)` by compactness and a
  minimal subset that is not five-colourable. `√3 ∉ ℚ(√635087)` is checked at `17` (`635087 ≡ 1`, `3` a non-residue).
- **Item 1005.**
  - The splits `six_le_chromaticNumber_planeOver_sqrt635087` and `chromaticNumber_planeOver_sqrt635087_le_seven`.
  - `exists_model_seven : ∃ c, Thick F7 c ∧ 0 ≤ c ∧ c·6 < 1 ∧ (F7²).Colorable 7` inhabits the joint hypotheses of
    `chromaticNumber_plane_le_of_thick` at `k = 7`, at once.

**Not claimed** anywhere:
- any value of `m₁(ℝ²)` or of `χ_f(ℝ²)` (the kernel holds `π/(8√3) ≤ m₁ ≤ 0.2470`);
- Croft's `δ_Croft`;
- anything at six colours beyond the corollary's `6`;
- that any of these forms is new. **Prior art not yet searched** (item 1021): the fractional forms and the triangle-free
  six-chromatic graph.

*A slip of mine, caught here.* The first text appended to this stage came from a scratch file of the same name in a
scratchpad that another job also writes to. It was another job's read-aloud, against row 79. I replaced it before committing.
From now on every text I commit is written to the record directly.

## Stage 5 — SAVED: the drafts for the front page

### Drafts for the front page

Each draft names its slot. Every count is the gate's on `e849029c3` (`data/fs131/ifr1/gate/`). None of the texts says
"new": the prior-art search for the fractional forms and for the triangle-free six-chromatic graph has not been run (item 1021).

**D-1. `CLAUDE.md` § Trust ledger, the audit sentence.** Replace "the current audit reads 10804 clean and 5 declared purchases,
and 83 imported (and 574 axiom-free; 11,466 records at FS131-IQP3, the p-adic plane, 2026-10-16)" with:

> the current audit reads 10888 clean and 5 declared purchases, and 104 imported (and 575 axiom-free; 11,572 records at
> FS131-IFR1, the density form of the collapse, 2026-10-16)

The per-import counts in the same paragraph move by the landing's 21 imported records. One rests on Weil's bound alone
(`Collapse.exists_model_seven`). Eleven rest on E–L alone. Six rest on E–L and Weil's bound (the four instances, TJ's first
clause, TF). Three rest on all three: the two splits and `Collapse.exists_finite_triangleFree_six_chromatic`. So Weil's bound
is 64 → 74, the five-colour theorem 7 → 10, and E–L 27 → 47. Records on E–L and Weil's bound are 14 → 23, four of them on the
five-colour theorem too. These are the totals `scripts/axioms-controls.txt` now records.

**D-2. `CLAUDE.md` § Trust ledger, the assumptions digest.** `axioms=3 rests=105 …` becomes
`axioms=3 rests=145 named=19 inline=14 outside=7 ours=21 open=5 takes=109 mentions=2`. In words: "with one hundred and forty-five
(axiom, theorem) rows resting on them". The 40 new `RESTS` rows are 25 on `positive_entropy_rigidity`, 12 on
`kloosterman_bound` and 3 on `no_proper_five_coloring`, over 21 public theorems and 7 private declarations (`eventually_stableRatio_le`, `iSup_stableRatio_lt`, `ae_condOne_mul_eq_zero`, `integral_condOne_mul_eq_zero_of_adj`, the private law `suppLaw`, `density_le_suppLaw`, `suppLaw_spectral_null`) (`scripts/assumptions-ledger.txt`).
No hypothesis was added or retired.

**D-3. `CLAUDE.md` § The gate, the vacuity counts.** `declarations=22431 refutations-skipped=243 sites=1458` becomes
`declarations=22548 refutations-skipped=245 sites=1458`. The second part stays
`vacuous=0 stale=0 declared=3 witnessed=38 generic=1415 unknown=2`.

**D-4. `plans/KERNEL-HOLDS.md`** (the paragraph moved there from `CLAUDE.md`, item 1032). After the collapse's clause, which ends
"the derivation FS-103's, the kernel's check this landing's;", insert:

> **the density form of the collapse** (FS-131, FS131-IFR1). The finitary independence ratio of the plane over every real number
> field is `α₁(F²) = α_loc(F) = max(m₁(ℝ²), ⨆_P r_P)`, with no hypothesis (`Collapse.finIndepRatio_planeOver_eq_localRatio`).
> Here `r_P` is the all-levels independence ratio of the residue targets at a conjugation-fixed prime `P` of `F(i)`. The same
> number is the best density of an invariant random independent set (`…_eq_iSup_density`), and `χ_f(F²) = 1/α_loc(F)`
> (`Collapse.fractionalChromaticNumber_planeOver_eq`). At every field that is uniformly `c`-thick with `c < 1/5`,
> `α₁(F²) = m₁(ℝ²)` and `χ_f(F²) = χ_f(ℝ²)`. At ℚ(√635087) and de Grey's field these hold with no hypothesis
> (`…_sqrt635087`, `…_deGrey`). At every subfield of ℝ, `1/α_loc(F) < 5` (`Collapse.inv_localRatio_lt_five`, through
> `m₁ ≥ π/(8√3)`, `Plane.pi_div_le_mOne`), so a density route never gives six. And there is a finite triangle-free unit-distance
> graph of chromatic number six (`Collapse.exists_finite_triangleFree_six_chromatic`, on `Outside.OAI158.no_proper_five_coloring`
> too). All of this rests on `[EinsiedlerLindenstrauss2022]` Thm 1.3 (`Rigidity.positive_entropy_rigidity`); the instances, TJ
> and TF rest also on Weil's bound. It is row 129's field clause, wider than the row: no MR hypothesis and no total reality.
> Prior art for the fractional forms and the six-chromatic graph: not yet searched. The derivation is FS-103's; the kernel's check
> is this landing's;

**D-5. `CLAUDE.md` § Frontier, the "Last updated" line.** Replace "Last filed: **the p-adic plane** (…)" with the following, and
move the p-adic plane's entry into the "before it" list:

> Last filed: **the density form of the collapse** (FS131-KFR1, FS131-IFR1, 2026-10-16: four modules through the gate on
> `e849029c3`, among them `α₁(F²) = max(m₁(ℝ²), ⨆_P r_P)` at every real number field with no hypothesis, `χ_f(F²) = 1/α_loc(F)`,
> the fractional collapse, and a finite triangle-free six-chromatic unit-distance graph. This is row 129's field clause; no value
> of `χ(ℝ²)` moved.)

**D-6. `LEDGER.md` row 129, the grade bracket.** Replace "the whole weight MR's (row 120);" with:

> the field clause **[kernel]** since FS131-IFR1, at every real number field and with no MR hypothesis (MR⁺ is
> `Rigidity.mrPlus`, on the declared `Rigidity.positive_entropy_rigidity`), each on `[propext, Classical.choice, Quot.sound]` and
> the imports named:
> - FRAC as `Collapse.finIndepRatio_planeOver_eq_localRatio` with the per-law bound `Collapse.IndepLaw.density_le_localRatio`
>   (E–L);
> - B-AMEN as `Collapse.finIndepRatio_planeOver_eq_iSup_density` (E–L), its halves `Collapse.exists_indepLaw`,
>   `Collapse.IndepLaw.density_le_finIndepRatio` and `Collapse.localRatio_le_finIndepRatio` on the standard three;
> - `χ_f(F²) = 1/α_loc(F)` as `Collapse.fractionalChromaticNumber_planeOver_eq` (E–L);
> - TJ as `Collapse.IndepLaw.density_le_notThick` (E–L, Weil) and `Collapse.le_volume_selection` (standard three);
> - ROUND as `Collapse.inv_le_localRatio_of_colorable` (E–L) and `Collapse.inv_localRatio_lt_five` (standard three, through
>   `m₁ ≥ π/(8√3)`, `Plane.pi_div_le_mOne` — not Croft's `0.22936`);
> - TF as `Collapse.exists_triangleFree_ratio_lt` (E–L, Weil);
> - the fractional collapse at uniformly `c`-thick fields, `c < 1/5`, and at ℚ(√635087) and de Grey's field (E–L; the instances
>   also Weil);
> - a finite triangle-free six-chromatic unit-distance graph, `Collapse.exists_finite_triangleFree_six_chromatic` (with
>   `no_proper_five_coloring`; prior art not yet searched).
>
> DV, 47, PL and B-CHIF stay [hand], and their weight is MR's (row 120);

**D-7. `README.md`, the table "Planes over number fields".** Add a row after the collapse's row:

> | `α₁(F²) = max(m₁(ℝ²), ⨆_P r_P)` for every real number field: the finitary independence ratio of `F²` is the larger of the plane's and the best all-levels independence ratio at a prime of `F(i)` that conjugation maps to itself. Also `χ_f(F²) = 1/α₁(F²)`, and at every uniformly `c`-thick field with `c < 1/5`, `χ_f(F²) = χ_f(ℝ²)` (so at ℚ(√635087) and ℚ(√3, √5, √7, √11)). And a finite triangle-free unit-distance graph has chromatic number six. | `Collapse.finIndepRatio_planeOver_eq_localRatio`, `Collapse.fractionalChromaticNumber_planeOver_eq`, `Collapse.fractionalChromaticNumber_planeOver_eq_plane_of_thick`, `Collapse.exists_finite_triangleFree_six_chromatic` | std3 + **EL**; + **W** (the two fields); + **O5** (the graph) | the derivation is this project's; prior art not yet searched | 129 |

**D-8. `ROADMAP.md` § 3's table, row 129.** No change: it reads "hand | yes", and both stay true (DV, 47, PL and B-CHIF are
[hand]; the plane's clause and now the field clause are in the kernel).

**D-9. The Proof Atlas.** Row 129: the field clause (FRAC, B-AMEN, TJ in both clauses, ROUND, TF) goes from [hand] to [kernel];
DV, 47, PL and B-CHIF stay [hand]. New in the kernel with no row of their own: the fractional collapse and the finite
triangle-free six-chromatic graph. The coordinator decides whether these need a row.

**D-10. `ARCHITECTURE.md`.** Done in this branch (my file by the brief): the four modules' rows, plus the notes on
`Collapse/Headline` and `Rigidity/ClassRatio`.

## What is left — for the successor FS131-IFR2 (the coordinator's ruling, inventory item 1048)

The proofs are done and gated on `e849029c3`. The coordinator told me not to merge `main` again or re-run the gate: the
three-colour criterion landed after my gate (`8ebb647bc`), and the five-colour fields land next. FS131-IFR2 merges `main`
into `fs131-kfr1`, keeps every landing's gate-input entries, and runs the full gate once on that merge commit. For that job:

**The gate-input files this branch edits, and how each block was made.**

1. **`scripts/Axioms.lean`** — four blocks, all generated by `tools/fs131_ifr1_audit_block.py` from the kernel's print
   `data/fs131/ifr1/axioms-all.txt`. The print comes from `data/fs131/ifr1/lean/AxiomsAll.lean`, run as
   `lake env lean data/fs131/ifr1/lean/AxiomsAll.lean > data/fs131/ifr1/axioms-all.txt` under a slot.
   - Under IMPORTED, after FS131-IQP3's `kloosterman_bound` block and before `declareImport ``…no_proper_five_coloring`: one line,
     `-- FS131-IFR1 (IMPORTED, on StandingFive.kloosterman_bound): the model at k = 7` (`exists_model_seven`).
   - After FS131-ICO2's `no_proper_five_coloring` block and before `declareImport ``…positive_entropy_rigidity`: three lines (the
     two splits, `exists_finite_triangleFree_six_chromatic`).
   - After FS131-ICO2's `positive_entropy_rigidity` block and before `=== CLEAN ===`: seventeen lines.
   - A CLEAN block `/-! ## FS131-IFR1 — … -/` with 85 lines, just before `=== PURCHASED ===`.

   Each block is a list of `#print axioms` lines with a comment header, so a merge should keep both sides' lines. To check after
   the merge: `python3 -I tools/fs131_ifr1_audit_block.py data/fs131/ifr1/axioms-all.txt scripts/Axioms.lean <prefix> --coverage`
   must print `COVERAGE OK` (every public record of the six modules filed under its class). Its `--plant` run must report three
   STOPs.
2. **`scripts/axioms-controls.txt`** — the two state controls move by this landing's 21 imported records: `imported=83 → 104`
   (`baseline`) and `84 → 105` (`imported_declared`), with the two `digest old` texts and the counting paragraph (a hundred and
   four records: Weil's bound 74, five-colour theorem 10, E–L 47, 23 on E–L and Weil's bound, four of them on all three). **After
   the merge, add the other landings' imported records to these numbers.** The audit self-test's `baseline` reports the true
   total in its "got:" line.
3. **`scripts/assumptions-ledger.txt`** — 40 `RESTS` rows and the header's `rests=145`, written by
   `./scripts/assumptions.sh --write-ledger` (under a slot). After the merge run it again: it rewrites the whole ledger from the
   merged library, and its header count then includes every landing's rows.
4. **`scripts/vacuity-baseline.txt`** — only the header's count line, `declarations=22548 refutations-skipped=245 sites=1458`.
   After the merge, set it from the merged gate's `digest-vacuity.txt` ("update it: …"), together with the other landings'
   deltas: this landing adds `+117` declarations and `+2` refutations-skipped, and no site.
5. **`ARCHITECTURE.md`** — the four modules' rows rewritten, plus the `Collapse/Headline` and `Rigidity/ClassRatio` rows' notes
   (by hand; `tools/check_architecture.py` passes).
6. **`Proofs.lean`** — the four imports, already present. At the `main` merge both import blocks were kept.

**Not gate inputs, but checks to run on the merge.**
- The statement comparison: `tools/fs131_ifr1_statements.py data/fs131/ifr1/statements-before.txt.gz <after-dump> --plant`.
  The after-dump comes from `data/fs131/ifr1/lean/StatementDump.lean` on the merged build. It must stay CLEAN, with six plants
  fired. A merge that recompiles these modules against a changed upstream could move instance terms. Note that a module the
  merge does not recompile keeps its `.olean`.
- The vacuity reading `data/fs131/ifr1/lean/VacuityNew.lean` (per-module counts).
- `build/gate/axioms-self-test/latest` in this worktree is my state-control red run (§ 3.5), not a gate run. The gated
  self-test's log is `data/fs131/ifr1/gate/axioms-selftest.log`.

**Not done here, owed elsewhere.**
- The front-file drafts (stage 5) are the coordinator's to file.
- The prior-art search for the fractional forms and the triangle-free six-chromatic graph (item 1021).
- The planner's `PatternLaw` refactor of `Collapse/`, which I do not recommend now (§ 2.3).

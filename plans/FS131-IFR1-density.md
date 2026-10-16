# FS131-IFR1 — the density form of the collapse: the independence ratio of the plane over every real number field

*de Bruijn, the implementer (Opus 5.5), 2026-10-16. Brief `data/fs131/briefs/FS131-IFR1-density.md` (on `main` at
`eeec277b7`). Worktree `.claude/worktrees/kcl1`, branch `fs131-kfr1` at `a0600cf37` (the planner's skeleton with `main`
merged in). Plan: `plans/FS131-KFR1-density-plan.md` (FS131-KFR1, the planner). Nothing in this milestone is blind.*

## Theorems this phase proved

*(Filled as the leaves close; one line per kernel theorem, its declaration and its axioms as printed.)*

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
  done: D2's copies came to about 1,270 lines against the plan's 1,370, written in one pass with eleven elaboration errors in
  all, none in the mathematics; a pattern form would save under a third of that and would have to refactor landed modules.
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

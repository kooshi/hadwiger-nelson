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

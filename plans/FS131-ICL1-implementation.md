# FS131-ICL1 — the count's plane lane (Λ1) and extension lane (Λ4), proved

*de Bruijn, the implementer. Brief: `data/fs131/briefs/FS131-ICL1-count-plane-extension.md` (on `main`). Branch `fs131-wcl`,
cut from the chain's joined commit `3ae198eac`, in the tree `.claude/worktrees/fs131-wch`. Working files: `data/fs131/icl1/`.
Report: `data/fs131/reports/FS131-ICL1.md`. Commits by explicit path, not pushed (the brief: the server is unreachable).*

## Theorems this phase proved

Sixteen leaves proved, every one with no `sorry` of its own; read from the built tree (`data/fs131/icl1/axioms.out`). Grade
[kernel] where the axioms are the standard three; "[kernel, over upstream leaves]" where `sorryAx` enters only through named
`sorry` leaves of other modules (stage 5.3), which is what the grade becomes [kernel] on when they land.

- `HadwigerNelson.Plane.densitySet_bandFree` — [kernel], the standard three — `Plane/WindowDensity`
- `HadwigerNelson.Plane.volume_inter_sq_le` — [kernel], the standard three — `Plane/WindowDensity`
- `HadwigerNelson.Plane.exists_periodic_near_mOne` — [kernel], the standard three — `Plane/WindowDensity`
- `HadwigerNelson.Plane.unitPairsNull_diff_essNbhd_union` — [kernel], the standard three — `Plane/WindowDensity`
- `HadwigerNelson.Plane.exists_nrWindow` — [kernel], the standard three — `Plane/WindowDensity`
- the spec `example : essNbhd ∅ = ∅` — elaborated — `Plane/WindowDensity`
- `HadwigerNelson.Rigidity.measurableSet_lonely` — [kernel], the standard three — `Rigidity/PlaneZhang`
- `HadwigerNelson.Rigidity.unitPairsNull_lonely` — [kernel], the standard three — `Rigidity/PlaneZhang`
- `HadwigerNelson.Rigidity.ae_sIndep_social` — [kernel], the standard three — `Rigidity/PlaneZhang`
- `HadwigerNelson.Rigidity.ae_disjoint_touched` — [kernel], the standard three — `Rigidity/PlaneZhang`
- `HadwigerNelson.Rigidity.sum_volume_inter_sq_le` — [kernel, over upstream leaves]: the standard three and `sorryAx` from
  `card_le_mul_card_closedNbhd` — `Rigidity/PlaneZhang`
- `HadwigerNelson.Rigidity.Counting.measure_ne_eq` — [kernel], the standard three — `Rigidity/CountExtension`
- `HadwigerNelson.Rigidity.Counting.comap_ιG_le_nhds_tauPrime` — [kernel, over upstream leaves] — `Rigidity/CountExtension`
- `HadwigerNelson.Rigidity.Counting.tendsto_measure_ne` — [kernel, over upstream leaves] — `Rigidity/CountExtension`
- `HadwigerNelson.Rigidity.Counting.exists_extension` — [kernel, over upstream leaves] — `Rigidity/CountExtension`
- `HadwigerNelson.Rigidity.Counting.exists_slice` — [kernel, over upstream leaves] — `Rigidity/CountExtension`

## Stage 1 — SAVED: the readback

### 1.1 The quotations (standing rule 3)

`tools/fs131_icl1_readback.py` (FS131-K12A's checker with this brief's path) requires each block quotation of the brief, the
`> ` prefix and a list marker removed, as one whole line of its source on `main`'s working tree. Output
`data/fs131/icl1/readback.out`: **5 quotations, 5 IDENTICAL** — W2 (`data/fs131/REQUEST-2026-10-13.md`), the two dated lines
of 2026-10-14 (`data/fs131/claims-NF2.md`), inventory items 832 and 854 (`plans/FS131-close-inventory.md`). Control
(`--plant`, `data/fs131/icl1/readback-plant.out`): one character changed in each quotation in memory, **5 of 5 reported**.

### 1.2 The branch, cut and built

`git checkout -b fs131-wcl 3ae198eac` in `fs131-wch` (clean, on `fs131-wk12` before). Build 1 under the slot
(`--mem 10 --cpus 4`, `MEMMAX=10G BATCH=8 ./scripts/build.sh`; `data/fs131/icl1/logs/build-1.log`, full output
`build/gate/build/20261014T145622Z-3507550.log`): **OK — 256 of 256 batches, 40 modules rebuilt, 20 with warnings, 9 m 27 s,
exit 0**; every warning in the log is `declaration uses 'sorry'`. One line sent to the coordinator.

### 1.3 The stored statements, dumped before any edit

`data/fs131/icl1/lean/StatementDump.lean` (after FS124-I2's dumper: every constant of the three modules' compiled data —
kind, stored type and its hash, a definition's stored value, and a pretty print with full names) run by `lake env lean` from the
built tree before any edit: `data/fs131/icl1/statements-before.txt`, **24 constants** (WindowDensity 9, PlaneZhang 9,
CountExtension 6), none internal. The comparator is `tools/fs131_icl1_statements.py` (stage 4 runs it, with its plants).

**Class binders against their sections** (item 847's defect; `fs131_icl1_statements.py --binders-only`). `Plane/WindowDensity`
has no section variable. `Rigidity/CountExtension`'s section declares `[NumberField F]`: **every one of its six constants names
`Subfield` and binds `NumberField ↥F`** — no miss. `Rigidity/PlaneZhang`'s section declares `[AddCommGroup Q] [Fintype Q]
[DecidableEq Q]`: every theorem binds all three; the four definitions bind only what their bodies read — `lonely` none,
`social` and `touched` `[Fintype Q]` (for `Finset.univ`), `RowsEdgeNull` `[AddCommGroup Q]` (for `q + s`). Nine misses, each a
definition omitting a binder it does not read, which is Lean's rule for definitions and no defect: **no stored statement lacks
a class binder its statement needs.**

**Unread binders the theorems carry** (pretty print: a binder printed without a name is not read by the stored type):
`measure_ne_eq` `[NumberField ↥F]`; `measurableSet_lonely`, `unitPairsNull_lonely` all three of `Q`'s; `ae_sIndep_social`,
`ae_disjoint_touched`, `sum_volume_inter_sq_le` `[DecidableEq Q]`. Whether a proof reads one decides whether the
`unusedSectionVars` linter warns; any it does not read is dropped by `omit … in` under item 726's word and listed at stage 4.
Of the statements in these files only `exists_slice` has a reader outside them (`Rigidity/CountDescent`), and it carries no
unread binder.

### 1.4 Each leaf, restated, beside its plan

| file | leaf | the statement, in one line | the plan (`plans/FS131-K12A-count.md` § 3.2) |
|---|---|---|---|
| WindowDensity | `densitySet_bandFree` | for measurable `A` with null unit pairs, its density points have no pair at distance exactly 1 and equal `A` a.e. | `dist_ne_one_of_mem_densitySet`, `upperDensityAt_pos_of_mem_densitySet`; `ae_eq_densitySet` |
| | `volume_inter_sq_le` | for such `A`, every window `squareWin a s`, `s > 0`, holds `|A ∩ W| ≤ m₁ (s + 2)²` | density set, trace on the window, periodised at `s + 2`; `upperDensity_periodize`; `le_iSup₂` |
| | `exists_periodic_near_mOne` | for `ε > 0` some measurable 1-avoiding set periodic under `Lℤ²` fills its cell `squareWin 0 L` to at least `m₁ − ε` | the supremum, a dense window, periodised |
| | `unitPairsNull_diff_essNbhd_union` | for `J` measurable 1-avoiding and `Z` measurable with null unit pairs, `(J ∖ N_e[Z]) ∪ Z` has null unit pairs | proved in scratch (`data/fs131/k12a/leaves/LeafP.lean`): fold in |
| | `exists_nrWindow` | for `ε > 0` there is `s₀ > 0` such that every measurable `Z` with null unit pairs has `|Z ∩ W| ≤ m₁ |N_e[Z] ∩ W| + ε s²` in every window of side `s ≥ s₀` | a near-optimal periodic `J`, its translates averaged over its cell (Tonelli) |
| | `essNbhd ∅ = ∅` (example) | the essential neighbourhood of the empty set is empty | `phi ∅ = 0` |
| PlaneZhang | `unitPairsNull_lonely` | the lonely points of a measurable row have null unit pairs | `pairSet_measure_eq_lintegral`: `phi = 0` on the lonely set |
| | `measurableSet_lonely` | the lonely points of a measurable row form a measurable set | `measurable_phi` |
| | `ae_sIndep_social` | with null edges and symmetric `S`, for a.e. `z` the rows in which `z` is social are independent in `Cay(Q, S)` | each `{z ∈ Y y : phi (Y x) z ≠ 0}`, `y − x ∈ S`, null by `RowsEdgeNull`; a finite union |
| | `ae_disjoint_touched` | for a.e. `z`, no row touched at `z` lies in the closed neighbourhood of the social rows | J28D (ii′)'s four cases, three by edge-nullity, one by the lonely slice swapped |
| | `sum_volume_inter_sq_le` | under `RatioLe S r`, `r ≥ 0`, null edges and `NRWindow ε s₀`, every window of side `s ≥ s₀` has `Σ_q |Y q ∩ W| ≤ (max(m₁, r) + ε) |Q| s²` | social and lonely points; `card_le_mul_card_closedNbhd` pointwise; `NRWindow` on each lonely set |
| CountExtension | `measure_ne_eq` | `P(c(0) ≠ c(y)) = (3/4)(1 − C(y))` for an invariant colouring | `tetra`'s two values |
| | `comap_ιG_le_nhds_tauPrime` | the completion's neighbourhoods of `0`, pulled back to `R`, are finer than `τ′_∅`'s | `nhds_inf`; profinite part by `exists_level_mem_nsmul`; archimedean part by the first coordinate |
| | `tendsto_measure_ne` | spectrum on `T + A` gives `P(c(0) ≠ c(y)) → 0` as `ιG y → 0` | proved in scratch over the two above (`LeafE.lean`): fold in |
| | `exists_extension` | spectrum on `T + A` gives a jointly measurable random colouring of `G_∅`, a.s. proper at every edge in the closure of `ι_G(U)` | approximants `π_n g` along neighbourhoods with summable error; Borel–Cantelli; the eventual value |
| | `exists_slice` | spectrum on `T + A` gives a measurable `φ : ℂ × K → Fin 4` whose monochromatic slice edges are null at every unit vector | Tonelli over the sample; `mem_closure_ιG`; countably many `u` |

**A route change, in advance of its build (Λ1, `exists_nrWindow`):** the plan averages a periodic `J` over its cell, which
needs "a periodic set fills every cell of its period alike" — no lemma of the library states it. Averaging one dense
*window* `T` (`T ⊆ squareWin 0 ℓ`, `|T| ≥ (m₁ − ε/4) ℓ²`) over the translates `T + t` that meet `W`, `t` in a square of side
`s + ℓ`, gives `|Z ∩ W| (s + ℓ)² + |T| |W ∖ N_e[Z]| ≤ m₁ (s + 2)² (s + ℓ)²` by Tonelli on `ℂ × ℂ` alone; choosing `ℓ ≥ 12 s/ε`
after `s` makes `|T|/(s + ℓ)² ≥ m₁ − ε/2`. The scale `s₀ = max(1, 16/ε)` still depends on `ε` only, as `NRWindow` asks.

## Stage 2 — SAVED: Λ1, `Plane/WindowDensity` — six leaves proved (elaborated; the build is stage 4's)

All six `sorry`s of `Plane/WindowDensity` replaced; `lake env lean` with `-DautoImplicit=false -DrelaxedAutoImplicit=false`
(iteration only): **exit 0, no warning, 8.5 s, 3.4 GB** (`data/fs131/icl1/logs/wd-3.log`; three elaborations, `wd-1` to
`wd-3`). **302 lines added** (proofs and five private helpers), against the planner's 300–450 for block P.

| leaf | how | lines |
|---|---|---|
| `densitySet_bandFree` | as planned: `dist_ne_one_of_mem_densitySet` at a pair of density points; `(ae_eq_densitySet hA).symm` | 7 |
| `volume_inter_sq_le` | as planned: the density set's trace on the window, `bandFree_periodize` at `ε = 0`, `upperDensity_periodize`, `le_iSup₂`, `ENNReal.div_le_iff` | 18 |
| `exists_periodic_near_mOne` | the private `exists_dense_window` at `δ = ε/2`, side `ℓ ≥ 16/ε + 1`, periodised at `ℓ + 2`; the cell holds the window's copy (`m = n = 0`); arithmetic in the private `arith_periodic` | 25 + 22 |
| `unitPairsNull_diff_essNbhd_union` | the scratch proof (`data/fs131/k12a/leaves/LeafP.lean`) folded in unchanged | 37 |
| `exists_nrWindow` | **another route than the plan's** (stage 1.4): one dense window averaged over its translates meeting `W` (private `lintegral_volume_translate_inter`, Tonelli on `ℂ × ℂ` with `Measure.prod_apply`, `prod_apply_symm`, `measurePreserving_sub_left`); `s₀ = max 1 (16/ε)`; side `ℓ = ⌈s⌉₊ + ⌈12 s/ε⌉₊ + 1`; arithmetic in the private `arith_nrWindow` | 85 + 37 + 33 |
| `essNbhd ∅ = ∅` (example) | `simp [essNbhd, phi]` | 2 |

Private helpers (none public; none another module needs): `mOne_ne_top`, `mOne_toReal_le_one`, `exists_dense_window` (a
measurable 1-avoiding `T ⊆ squareWin 0 ℓ` with `(m₁ − δ) ℓ² ≤ |T|`, for every positive integer `ℓ`: the supremum, a measurable
part of a near-optimal set by `NullMeasurableSet.exists_measurable_subset_ae_eq`, `exists_squareWin_dense`, translated),
`arith_periodic`, `lintegral_volume_translate_inter`, `arith_nrWindow`. `exists_periodic_near_mOne` is now read by no proof in
the count (`exists_nrWindow` no longer goes through it); it stays a theorem of the module, proved.

## Stage 3 — SAVED: Λ1, `Rigidity/PlaneZhang` — five leaves proved (elaborated in a farm; the build is stage 4's); Λ1 re-priced

All five `sorry`s of `Rigidity/PlaneZhang` replaced. Elaborated against a farm (`data/fs131/icl1/lean1.sh`: a symlink copy of
the tree's compiled library with this job's `WindowDensity` compiled over it, the lakefile's three options passed): **exit 0, no
warning, 5.1 s, 3.4 GB** (`data/fs131/icl1/logs/pz-3.log`; three elaborations). **209 lines added.**

| leaf | how | lines |
|---|---|---|
| `measurableSet_lonely` | `(hY b).inter (measurable_phi (hY b) (measurableSet_singleton 0))` | 2 |
| `unitPairsNull_lonely` | the unit pairs of the lonely set lie in its pairs into the row, null because `phi (Y b) = 0` on it (private `pairSet_lonely_null`) | 3 + 6 |
| `ae_sIndep_social` | a finite union of edge slices `{z ∈ Y y : phi (Y x) z ≠ 0}`, `x − y ∈ S`, each null (private `null_edge`, reading `RowsEdgeNull` at `(x, y − x)`) | 12 |
| `ae_disjoint_touched` | J28D (ii′)'s four cases: one contradicts pointwise, one is the lonely slice swapped (private `null_lonely_swap`), two are edge slices (one through `phi (lonely Y b) ≤ phi (Y b)`) | 30 |
| `sum_volume_inter_sq_le` | each row split into its social and lonely parts; `NRWindow` on each lonely set; the social and touched counts integrated over the window (`integral_finsetSum`, `integral_indicator_one`), bounded a.e. by `max(m₁, r) |Q|` through `card_le_mul_card_closedNbhd` and the disjointness | 92 |

Private helpers: `pairSet_lonely_null`, `pairSet_null_swap` (the scratch leaf's swap, made a lemma), `null_of_pairSet_null`,
`null_edge`, `null_lonely_swap`, `mem_social`, `mem_touched`, `volume_squareWin_le` (a window of negative side is empty, so
`ε ≥ 0` is never needed), `sum_indicator_eq_card`.

**Read from outside the lane:** `card_le_mul_card_closedNbhd` (`Rigidity/FiniteZhang`, lane Λ2), a `sorry` leaf there, read as
stated: `sum_volume_inter_sq_le` rests on `sorryAx` through it until Λ2 lands. Nothing else outside Λ1 is read.

**Unread binders dropped (item 726's word)**, by `omit … in` above each statement: `measurableSet_lonely` and
`unitPairsNull_lonely` read none of `[AddCommGroup Q] [Fintype Q] [DecidableEq Q]`; `ae_sIndep_social` and
`ae_disjoint_touched` do not read `[DecidableEq Q]`. `sum_volume_inter_sq_le` keeps all three. Listed again with the kernel's
dump at stage 4.

**Λ1 re-priced from its first two leaves** (`exists_nrWindow` with its two helpers, about 155 lines in three elaborations;
`sum_volume_inter_sq_le` with its helpers, about 140 lines in three): the lane is **done at 511 lines** (302 + 209) against the
planner's 800–1,150, in about 25 minutes of wall time from the first draft (written while build 1 walked) to the stage-3 commit, a six-minute slot wait included. No price message is owed (the lane is under a day).

## Stage 4 — SAVED: Λ4, `Rigidity/CountExtension` — five leaves proved (elaborated in the farm; the build is stage 5's); Λ4 re-priced

All five `sorry`s of `Rigidity/CountExtension` replaced. Farm elaboration (`data/fs131/icl1/lean1.sh`, the lakefile's options):
**exit 0, no warning, 7.8 s, 4.1 GB** (`data/fs131/icl1/logs/ce-5.log`; five elaborations, `ce-1` to `ce-5`). **295 lines
added.**

| leaf | how | lines |
|---|---|---|
| `measure_ne_eq` | `tetra (c 0) (c y) = 1 − (4/3)·1_{c 0 ≠ c y}`; `integral_sub`, `integral_indicator_const` | 22 |
| `comap_ιG_le_nhds_tauPrime` | as planned: `nhds_inf`, `nhds_iInf`; the profinite part through `exists_level_mem_nsmul` and the level kernel `univ ×ˢ {proj k = 0}` (`hasBasis_nhds_zero_K`), `pure_le_nhds` for the discrete quotient; the archimedean part through `continuous_fst` | 30 |
| `tendsto_measure_ne` | the scratch proof (`data/fs131/k12a/leaves/LeafE.lean`) folded in unchanged | 47 |
| `exists_extension` | as planned, every choice a `Nat.find`: neighbourhoods `W n` on whose triple differences `P(c 0 ≠ c y) ≤ 2⁻ⁿ` (from C1), `O n = ⋂_{k ≤ n} interior (W k)`; `π n g` the first `r` of an enumeration of `R` with `ιG r − g ∈ O n` (`denseRange_ιG`); `f c g = c (π N g)` at the first `N` from which `c ∘ π · g` is constant (`Measurable.find` twice, `measurable_from_prod_countable_left`); Borel–Cantelli (`measure_limsup_atTop_eq_zero`) for the eventual constancy; an edge `t` by a unit vector `u` with `ιG u − t ∈ O m` and the proper colourings (`μ.carried`), so `μ(f c g = f c (g + t)) ≤ inf_m 2⁻ᵐ` off a null set | 141 + 22 |
| `exists_slice` | Tonelli over `μ × ((volume × haarK) × arcLength)` at each unit vector (`Measure.prod_apply_symm`, `measure_prod_null`), the fibre by `exists_extension` at `t = (Δ(e^{iθ}), ιK u)` (`mem_closure_ιG`); `ae_all_iff` over the countably many unit vectors; one sample | 50 |

Private helpers: `measure_ne_shift` (shift invariance at a pair), `measure_eq_add_unit` (an edge is a.s. bichromatic).

**Read from outside the lane, as stated** (each a `sorry` leaf of its own module, so `sorryAx` reaches this module's theorems
through them until they land): `Rigidity.TA_subset_contChars` (M10, `Rigidity/ContinuityGroup`), `exists_level_mem_nsmul`
(`Rigidity/CountResidue`, Λ2), `hasBasis_nhds_zero_K`, `denseRange_ιG`, `mem_closure_ιG` and the instance
`CompactSpace (K F)` (`Rigidity/CountCompletion`, Λ3). Nothing of `CountTorus` is read.

**Unread binder dropped (item 726's word):** `measure_ne_eq` does not read `[NumberField F]` (`omit [NumberField F] in`); its
one reader, `tendsto_measure_ne`, is in this file.

**Λ4 re-priced from its first two leaves** (`exists_extension` about 165 lines in three elaborations, `exists_slice` 50 in
one): **done at 295 lines** against the planner's 700–1,100.

**The model the module's docstring owes is not built** (`InvariantColouring` at `F = ℚ` with its trace spectral measure on
`T + A`): a public declaration, which the brief does not allow this job to add. Its route is drafted at stage 6; held for the
coordinator.

## Stage 5 — SAVED: the build, no statement changed but five ruled, the axioms, the doubled names, the lint

### 5.1 Build 2

Under the slot (`--mem 10 --cpus 4`, `MEMMAX=10G BATCH=8`; `data/fs131/icl1/logs/build-2.log`, full output
`build/gate/build/20261014T152745Z-3620264.log`): **OK — 256 of 256 batches, 5 modules rebuilt (`Plane.WindowDensity` 8.1 s,
`Rigidity.PlaneZhang` 4.9 s, `Rigidity.CountExtension` 7.2 s, `Rigidity.CountDescent`, `Proofs`), 7 m 40 s, exit 0.** Of the 17
modules with warnings none is this job's: **no warning from the three files**, and every warning in the full log is
`declaration uses 'sorry'` (a grep for any other warning line finds none). The three files hold no `sorry`. On `Proofs/` the
branch differs from `3ae198eac` in these three files only (`git diff --stat`: 806 insertions, 18 deletions).

### 5.2 No statement and no definition changed but the five ruled, from the kernel's side

The dumper re-run on the built tree: `data/fs131/icl1/statements-after.txt` (69 constants: WindowDensity 22, PlaneZhang 30,
CountExtension 17). `tools/fs131_icl1_statements.py BEFORE AFTER --ruled <five>` (`data/fs131/icl1/statements-compare.out`):
**SAME=19 CHANGED=0 RULED=5 MISSING=0 ADDED-INTERNAL=43 ADDED-GENERATED=2 ADDED-PUBLIC=0 — PASS.** Every definition's stored
value is among the 19 SAME (`essNbhd`, `NRWindow`, `lonely`, `social`, `touched`, `RowsEdgeNull`, `SliceEdgeNull`). Unruled, the
same comparison reads exactly the five ruled statements CHANGED (`statements-compare-unruled.out`).

- **The five ruled** (item 726's word: an unread instance binder dropped, `omit … in`): `Rigidity.measurableSet_lonely` and
  `Rigidity.unitPairsNull_lonely` lose `[AddCommGroup Q] [Fintype Q] [DecidableEq Q]`; `Rigidity.ae_sIndep_social` and
  `Rigidity.ae_disjoint_touched` lose `[DecidableEq Q]`; `Rigidity.Counting.measure_ne_eq` loses `[NumberField ↥F]`.
  `tools/fs131_icl1_ruled.py` strips exactly those binders from each BEFORE type and finds the AFTER type **character for
  character, 5 EXACT** (`data/fs131/icl1/ruled.out`). Each only widens the statement; no reader outside the files.
- **ADDED-GENERATED**: `Rigidity.closedNbhd.congr_simp`, `Rigidity.Counting.Lev.congr_simp` — reserved names Lean generates where
  a tactic asks; no other module holds a copy (5.4).
- **ADDED-INTERNAL**: the 17 private helpers and Lean's `_proof_n`/auxiliary names.
- **Controls** (`--plant`, `data/fs131/icl1/statements-plant.out`): one character of a stored type → CHANGED; a constant dropped →
  MISSING; a public constant added → ADDED-PUBLIC; a `NumberField` binder renamed → BINDER-MISS — **all four fired**.
  `fs131_icl1_ruled.py --plant` (one class too few stripped): **5 DIFFERS, fired** (`ruled-plant.out`).
- **The class-binder reading after the proofs**: the same nine definition-level misses as stage 1.3 and none on a theorem.

### 5.3 The axioms of every declaration of the three files

`data/fs131/icl1/lean/Axioms.lean` (FS131-IN1's printer, which names the leaf each `sorryAx` comes from) over every constant of
the three modules' compiled data; read by `tools/fs131_icl1_axioms.py` (`data/fs131/icl1/axioms.out`, `axioms-read.out`):
**43 records — CLEAN 37, UPSTREAM 6, FAIL 0** (printed count 43 = records read). Every private helper is CLEAN.

| record | axioms | `sorryAx` from (each a leaf of another module) |
|---|---|---|
| all 15 of `Plane/WindowDensity` (9 public, 6 private) | the standard three | — |
| `Rigidity.lonely`, `social`, `touched`, `RowsEdgeNull`, `measurableSet_lonely`, `unitPairsNull_lonely`, `ae_sIndep_social`, `ae_disjoint_touched`, 9 private helpers, `closedNbhd.congr_simp` | the standard three | — |
| `Rigidity.sum_volume_inter_sq_le` | standard three + `sorryAx` | `card_le_mul_card_closedNbhd` (`FiniteZhang`, Λ2) |
| `Counting.measure_ne_eq`, 2 private helpers, `Lev.congr_simp` | the standard three | — |
| `Counting.SliceEdgeNull` (definition) | standard three + `sorryAx` | `instCompactSpaceK` (`CountCompletion`, Λ3), `toL_mem_localRing` (`CountResidue`, Λ2; read by the definitions `toLocal` → `resR` → `levR` → `ιK`) |
| `Counting.comap_ιG_le_nhds_tauPrime` | + `sorryAx` | `exists_level_mem_nsmul`, `hasBasis_nhds_zero_K`, `toL_mem_localRing` |
| `Counting.tendsto_measure_ne` | + `sorryAx` | the three above, `finite_quot`, `Rigidity.TA_subset_contChars` (M10) |
| `Counting.exists_extension` | + `sorryAx` | those, and `denseRange_ιG` |
| `Counting.exists_slice` | + `sorryAx` | those, and `instCompactSpaceK`, `instIsProbabilityMeasureKHaarK`, `mem_closure_ιG` |

**Control** (`data/fs131/icl1/lean/AxiomsPlant.lean`: a theorem with a `sorry` and one resting on a declared axiom, both counted as
this job's; `axioms-plant-read.out`): **2 of 2 read FAIL** — the planted axiom by name, the planted `sorry` as a `sorry` inside
the job's files.

### 5.4 The doubled names, and the lint (both whole-library; run for this tree, not required by the brief)

`./scripts/dupnames.sh` under the slot (`data/fs131/icl1/logs/dupnames.log`, full output
`build/gate/dupnames/20261014T154248Z-3696492.log`): **OK — no name is declared by two modules**; 24 generated on demand, none
of this job's (the two `congr_simp` of 5.2 have one copy each). The lint (`lake lint --no-build -- --no-build --trace`,
`data/fs131/icl1/logs/lint.log`): **exit 1, one finding, not in these files** — `unusedArguments` on
`Rigidity.archTop`'s `[NumberField ↥F]` (`Rigidity/ContinuityGroup.lean:42`, a file this branch does not change); 13 of 14
linters passed; nothing reported in the three files.

## Stage 6 — SAVED: drafts for the landing

### 6.1 The audit's block for these files (`scripts/Axioms.lean`, a new block in the CLEAN section, after the last FS-131 block)

Every public record of the three modules, one `#print axioms` line each. **It belongs in CLEAN only when the upstream leaves
land**: at this stage the records marked UPSTREAM in stage 5's table rest on `sorryAx` through leaves of other modules
(`card_le_mul_card_closedNbhd`; `TA_subset_contChars`; `exists_level_mem_nsmul`; `hasBasis_nhds_zero_K`, `denseRange_ιG`,
`mem_closure_ιG`, `CompactSpace (K F)`), and the audit fails on them until then.

```
-- FS131-ICL1 block: `Plane/WindowDensity` — 9 records (7 theorems, 2 definitions); the six leaves' proofs FS131-ICL1's
#print axioms HadwigerNelson.Plane.essNbhd
#print axioms HadwigerNelson.Plane.measurableSet_essNbhd
#print axioms HadwigerNelson.Plane.densitySet_bandFree
#print axioms HadwigerNelson.Plane.volume_inter_sq_le
#print axioms HadwigerNelson.Plane.exists_periodic_near_mOne
#print axioms HadwigerNelson.Plane.unitPairsNull_diff_essNbhd_union
#print axioms HadwigerNelson.Plane.NRWindow
#print axioms HadwigerNelson.Plane.exists_nrWindow
#print axioms HadwigerNelson.Plane.mOne_le_one
-- FS131-ICL1 block: `Rigidity/PlaneZhang` — 9 records (5 theorems, 4 definitions); the five leaves' proofs FS131-ICL1's
#print axioms HadwigerNelson.Rigidity.lonely
#print axioms HadwigerNelson.Rigidity.social
#print axioms HadwigerNelson.Rigidity.touched
#print axioms HadwigerNelson.Rigidity.RowsEdgeNull
#print axioms HadwigerNelson.Rigidity.measurableSet_lonely
#print axioms HadwigerNelson.Rigidity.unitPairsNull_lonely
#print axioms HadwigerNelson.Rigidity.ae_sIndep_social
#print axioms HadwigerNelson.Rigidity.ae_disjoint_touched
#print axioms HadwigerNelson.Rigidity.sum_volume_inter_sq_le
-- FS131-ICL1 block: `Rigidity/CountExtension` — 6 records (5 theorems, 1 definition); the five leaves' proofs FS131-ICL1's
#print axioms HadwigerNelson.Rigidity.Counting.measure_ne_eq
#print axioms HadwigerNelson.Rigidity.Counting.comap_ιG_le_nhds_tauPrime
#print axioms HadwigerNelson.Rigidity.Counting.tendsto_measure_ne
#print axioms HadwigerNelson.Rigidity.Counting.exists_extension
#print axioms HadwigerNelson.Rigidity.Counting.SliceEdgeNull
#print axioms HadwigerNelson.Rigidity.Counting.exists_slice
-- FS131-ICL1 block end
```

### 6.2 The models (`LEAN.md` § The gate: every theorem whose hypothesis is a structure ships a named inhabitant)

- **`Plane/WindowDensity`.** The hypotheses are sets: `MeasurableSet`, `UnitPairsNull`, `BandFree … 0`. Inhabited at once by
  `∅` and by the open disc of radius `1/3` (`Plane.unitPairsNull_of_dist_lt_one`; the disc's diameter is below `1`, so it is
  `BandFree … 0`), as the module docstring says. `NRWindow ε s₀` is inhabited at every `ε > 0` by the theorem
  `exists_nrWindow`.
- **`Rigidity/PlaneZhang`.** `sum_volume_inter_sq_le`'s hypotheses are inhabited together by library declarations: any finite
  group `Q` with `S = ∅` (symmetric), `RatioLe ∅ 1` (`Rigidity.ratioLe_one`), `r = 1 ≥ 0`, the empty rows (measurable; their
  `RowsEdgeNull` is the module's spec `example`), and `NRWindow ε s₀` from `Plane.exists_nrWindow`. A model with a non-empty
  row: `Q` one point, `S = ∅`, the row the disc of radius `1/3` (`RowsEdgeNull ∅ _` is vacuous in `s`; its edge sets are
  never asked). No declaration is added.
- **`Rigidity/CountExtension`.** Every theorem takes `(μ : InvariantColouring F)`, `IsTraceSpectral F μ.μ σ` and
  `σ (TA F)ᶜ = 0`. **No kernel model is in the library**, and the module's docstring says it is owed by this module's
  implementer. Not built: it is a public declaration, which this brief does not allow. **Its route** (the docstring's, made
  checkable): at `F = ⊥` (`ℚ`), (i) the residue map `ρ : unitRing ⊥ →+* ZMod 2` — every unit vector `(a + bi)/c` of a primitive
  triple has `c` odd and exactly one of `a`, `b` odd, so `U` lies in the ring `ℤ_(2)[i]` and `u ≡ 1` modulo `(1 + i)`;
  `ρ` is built on `Subring.closure` by `Subring.closure_induction` on the generators, or as the restriction of the residue map of
  `UpperHalf`'s local ring at the dyadic prime of `ℚ(i)` (`toLocal`, `P.residue 1`); (ii) `μ = ½(δ_{c₀} + δ_{c₁})`,
  `c_s(x) = ρ(x) + s ∈ Fin 4` through `ZMod 2 ↪ Fin 4`; `carried` since `ρ(x + u) = ρ(x) + 1`; `shift_inv` since
  `c_s(· + y) = c_{s + ρ(y)}` (the two atoms permuted); `rot_inv` since `ρ(u x) = ρ(x)`; (iii) `C(y) = 1` when `ρ(y) = 0` and
  `−1/3` otherwise, so `σ = ⅓ δ_1 + ⅔ δ_χ` with `χ(y) = (−1)^{ρ(y)}`, both 2-torsion, so `σ (TA ⊥)ᶜ = 0`
  (`one_mem_TA`; `χ ∈ torsionChars`). Priced at 150–300 lines from this job's rate; the count's contradiction itself is
  `Counting.false_of_slice`, which reads `TCA F` and is false at `ℚ` (the ramified dyadic prime), as the docstring says.

### 6.3 `LEAN.md` § Searching — Lean, four lines

- `rw [nhds_induced]` on a topology induced from `⊥` (`profTop`'s quotients) fails with "synthesized type class instance is
  not definitionally equal to expression inferred by typing rules": name the topology, `rw [@nhds_induced _ _ ⊥]`, and bound
  `@nhds _ ⊥ a` from below by `@pure_le_nhds _ ⊥ a` rather than rewriting with `nhds_discrete` (whose `⟨rfl⟩` instance argument
  meets the same error). `refine le_of_le_of_eq (le_inf ?_ ?_) (nhds_inf (t₁ := …) (t₂ := …)).symm` reads a neighbourhood
  filter of an infimum topology given by a reducible definition, where `rw [tauPrime, nhds_inf]` finds no pattern
  (`Counting.comap_ιG_le_nhds_tauPrime`, FS131-ICL1).
- A measurable choice from countably many candidates needs no measurable-selection theorem: `Measurable.find`
  (`Mathlib/MeasureTheory/MeasurableSpace/Constructions.lean`) makes `x ↦ f (Nat.find (h x)) x` measurable from measurable
  `f n` and measurable `{x | p n x}`, and `measurable_from_prod_countable_left` makes `(c, r) ↦ c r` measurable on
  `(R → Fin 4) × R` for a countable `R` with measurable singletons — together "the first element of an enumeration of `R`
  with `ιG r − g ∈ O`" and "the eventual value of `c (π n g)`" are jointly measurable, which replaces Doob–Cohn
  (`Counting.exists_extension`, FS131-ICL1).
- "Every cell of a periodic set's period holds the same measure" is in no lemma of the library; a window bound averaged over
  translates needs none: for `T ⊆ squareWin 0 ℓ` and every `t` with `T + t` meeting `E ⊆ W`, `t` lies in a square `D` of side
  `s + ℓ`, and `∫⁻ t in D, |(T + t) ∩ E| = |T| |E|` by `Measure.prod_apply`, `prod_apply_symm` and
  `measurePreserving_sub_left` on `ℂ × ℂ` (`Plane.exists_nrWindow`'s private `lintegral_volume_translate_inter`,
  FS131-ICL1).
- An indicator built as `(integrable_const 1).indicator h` elaborates the function as `fun _ => 1`, which `rw` with
  `integral_indicator_one` (stated at `1`) does not find: write `A.indicator (fun _ => (1 : ℝ))` and use
  `integral_indicator_const`. At the pin `integrable_finset_sum` and `integral_finset_sum` are deprecated for
  `integrable_finsetSum`, `integral_finsetSum` (FS131-ICL1).

### 6.4 `ARCHITECTURE.md` (this job's pen for its three rows)

The three rows' state cells changed from "skeleton" to "proved (FS131-ICL1)", each naming what its records read outside the
file; `tools/check_architecture.py`: **PASS** (392 rows, 0 import mismatches; `data/fs131/icl1/logs/architecture.log`).

### 6.5 For the landing to read

- The lint's one finding (`Rigidity.archTop`'s unread `[NumberField ↥F]`, `Rigidity/ContinuityGroup.lean:42`) is in a file this
  branch does not change: the join implementer's or the landing's.
- The vacuity scan was not run by this job. The three files' structure hypotheses are named in 6.2; the scan's reading of the
  binder `(μ : InvariantColouring F)` is the landing's to read.
- `exists_periodic_near_mOne` is now read by no proof (`exists_nrWindow` takes the dense window directly); it is a proved
  theorem of the module either way.

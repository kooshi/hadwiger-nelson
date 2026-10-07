# FS132-I2 — the port: the release's lemmas that FS-132's first theorem stands on, proved in this library with no new axiom

*Record of the implementer (de Bruijn, Opus 5.5). Brief: `data/fs132/briefs/FS132-I2-port.md` on `main` at `dcf89464e`.
Branch `fs132-wi2`, cut from `fs132-wk1` at `e3695302c`; worktree `.claude/worktrees/fs132-wi2`. Working files:
`data/fs132/i2/`. Tools: `tools/fs132_i2_port.py` (the generator and its check), `tools/fs132_i2_readback.py` (the
ported statements and definitions against the release's, as the kernel stores them at the two pins). The outside
clone (`/home/kooshi/source/math`, commit `adc7f1241b42e322a6451854ab7e4b4c146bf78a`) and the audit's compiled copy
(`~/.cache/ext-oai1/lean`) were read; nothing was written into either.*

## Theorems this phase proved

Namespace `HadwigerNelson.Outside.OAI158`. **Every one of the 163 declarations below prints exactly `[propext, Classical.choice,
Quot.sound]`** from the built modules (`data/fs132/i2/axioms/Print.out`, checked as sets by `tools/fs132_i2_axioms.py`), and
**none rests on either declared outside theorem** (`no_proper_five_coloring`, `proper_to_borel_weak`). Grade: [kernel], each
a proof of the release's (`[OAIMath2026]` family 158), ported, checked by this library's kernel at its pin. One line per
declaration, with its source line at the commit: `data/fs132/i2/theorems.tsv`.

**The four statements the brief names** (stage 3 reads each aloud):

| declaration | module | source | axioms |
|---|---|---|---|
| `palette_transfer_pair` | `Outside/OAI158PaletteDensity` | `PaletteDensity.lean:143` | the standard three |
| `palette_sixty_disjoint` | `Outside/OAI158PaletteTransport` | `PaletteTransport.lean:450` | the standard three |
| `two_state_impossible` | `Outside/OAI158States` | `States.lean:243` | the standard three |
| `mem_spatialSupport_ae` | `Outside/OAI158AngularBoundary` | `AngularBoundary.lean:309` | the standard three |

**All 163, by module** (kind: `d` a definition, `i` an instance, otherwise a theorem; each on the standard three):

- **`Outside/OAI158CircleMaps`** (63, from `CircleMaps.lean`): `RealPlane` (d), `circleSum` (d), `circleSumDeriv` (d), `circleSum_strict`, `circleSum_continuous`, `circleSumDeriv_injective`, `circleSumDerivEquiv` (d), `circleSum_local_antilipschitz`, `realDirection_lipschitz`, `circleInverseHomeo` (d), `circleInverse` (d), `circleInverse_measurable`, `circleInverse_eq`, `circleInverse_at`, `circleInverse_continuousAt`, `circleInverse_strict`, `circleInverse_right`, `circleInverse_regular`, `triangular_injective`, `triangular_surjective`, `strict_fiber_uniform_antilipschitz`, `CircleParameter` (d), `CircleJet` (d), `jetCenter` (d), `jetRadius` (d), `jetAngle` (d), `circleTarget` (d), `circleTargetDeriv` (d), `circleTarget_strict`, `circleTarget_continuous`, `circleEndpoint` (d), `circleEndpointDeriv` (d), `circleEndpoint_measurable`, `circleEndpoint_strict`, `inverse_tangent_first_ne`, `circleEndpoint_fiber_ne`, `circleEndpoint_uniform`, `circleEndpoint_good_neighborhood`, `angleChart` (d), `angleChartMeasure` (d), `angleChartMeas_le`, `instIsFiniteMeasureRealPlaneAngleChartMeasure` (i), `angleChart_preserving`, `angleChart_measure`, `integral_angular_eq_chart`, `direction_realPlane`, `circleSum_chart`, `volume_preimage_bound`, `map_restrict_volume_le`, `antilipschitz_small_perturbation`, `realDirection_norm_le`, `circleSum_decompose`, `circleSum_norm_le`, `circleSum_perturb_identity`, `circleSum_parameter_tendsto`, `circleSum_eventual_image`, `circleSum_limit_image`, `circleSum_eventual_antilipschitz`, `circleSum_limit_antilipschitz`, `measure_null_of_locally_null_on_conull`, `circleSum_regular_ae`, `circleSum_preimage_null`, `circleSum_quasiMeasurePreserving`.
- **`Outside/OAI158Expansion`** (8, from `Expansion.lean`): `line_volume_preimage_bound`, `line_map_restrict_volume_le`, `integrable_comp_of_map_le`, `integral_norm_comp_le`, `tendsto_integral_norm_comp_sub`, `tendsto_integral_norm_comp_sub_eventual`, `line_antilipschitz_qmp`, `line_indicator_pullback_L1`.
- **`Outside/OAI158CircleTransport`** (11, from `CircleTransport.lean`): `tendsto_integral_of_local_cover`, `bounded_difference_integrable`, `circleSum_tendsto_L1`, `angularSum_measurable`, `angularSum_chart`, `angularSum_quasiMeasurePreserving`, `angularSum_tendsto_L1`, `samplingParameter` (d), `samplingParameter_tendsto`, `circleTarget_sampling`, `circleInverse_sampling`.
- **`Outside/OAI158PaletteDensity`** (28, from `PaletteDensity.lean`): `weak_strong_disjoint`, `colorIndicator` (d), `colorIndicator_measurable`, `colorIndicator_bounds`, `sample_pair_disjoint`, `trace_pair_disjoint`, `palette_first_exclusion`, `palette_second_exclusion`, `palette_transfer_pair`, `angleMk_quasiMeasurePreserving`, `anglePair_quasiMeasurePreserving`, `FlatDensityZero` (d), `LineDensityZero` (d), `volume_image_bound`, `flatDensityZero_prod`, `tendsto_pos_mul_nhdsWithin`, `FlatDensityZero.image`, `FlatDensityZero.of_locally_le`, `FlatDensityZero.transport`, `circleSum_one_lipschitz`, `circleSum_densityZero`, `complex_ball_flat_ball`, `flat_to_complex_densityZero`, `ae_lineDensityZero_compl`, `liftPalette_measurable`, `palette_spatial_densityZero`, `palette_spatial_not_densityOne`, `palette_sample_branch_exclusion`.
- **`Outside/OAI158PaletteTransport`** (20, from `PaletteTransport.lean`): `angleRep_preserving`, `weak_lift_Ioc`, `weak_restrict`, `weak_lift_set`, `weak_strong_disjoint_single`, `weak_strong_disjoint_single_eventual`, `palette_trace_branch`, `palette_branch_local`, `circleInverse_left`, `circleEndpoint_eventuallyEq`, `ae_of_locally_ae`, `ae_restrict_of_locally_ae`, `palette_transport_real`, `sin_sixty_ne`, `sin_twice_sixty_ne`, `sixty_sum`, `ae_angular_of_ae_line`, `palette_sixty_real`, `palette_sixty`, `palette_sixty_disjoint`.
- **`Outside/OAI158BinaryPalettes`** (11, from `BinaryPalettes.lean`): `triangleAngle` (d), `triangleAngle_cos`, `triangleAngle_pos`, `triangleAngle_lt_pi`, `triangleAngle_ratio_irrational`, `triangle_rotation_ergodic`, `equal_triangleAngle_positive`, `circle_exp_sub_norm_sq`, `sourceTriangle` (d), `sourceTriangle_eq`, `sourceTriangle_pair`.
- **`Outside/OAI158States`** (21, from `States.lean`): `LineDensityZero.mono_ae`, `DensityZero` (d), `DensityZero.union`, `densityZero_empty`, `DensityZero.biUnion_finset`, `DensityZero.compl`, `state_densityZero`, `angularSum_swap`, `states_densityOne`, `DensityOne.compl`, `DensityOne.inter`, `DensityOne.measure_ne_zero`, `densityOne_univ`, `DensityOne.iInter`, `finite_density_realization`, `two_label_triangle_impossible`, `bool_flip_two`, `bool_flip_three`, `bool_flip_even`, `triangleAngle_nonparallel`, `two_state_impossible`.
- **`Outside/OAI158AngularBoundary`** (1, from `AngularBoundary.lean`): `mem_spatialSupport_ae`.

## Stage 1 — SAVED (FS132-I2): the readback, and the branch built as given

**The brief's quotations against their sources** (standing rule 3). `tools/fs132_i1_quotes.py` (FS132-I1's tool, run,
not edited) on the brief as it stands on `main`, relative paths read under `main`'s tree:
`data/fs132/i2/quotes.out` — **9 quotations, 9 matched, 0 mismatches**; its self-test on the same brief
(`data/fs132/i2/quotes-selftest.out`): a changed word, a wrong source and an empty quotation each refused.

| # | quotation (first words) | source | result |
|---|---|---|---|
| 1 | "I agree with all 3. let's keep the lean backlog paused. …" | `data/external/EXT-OAI1-request.md` | OK |
| 2 | "1. port or import: let's import and adopt parts piecemeal if needed. …" | `data/external/EXT-OAI1-request.md` | OK |
| 3 | "Do not consider Lean formalization a cost. …" | `CLAUDE.md` § Counter-priors | OK |
| 4 | `lemma palette_transfer_pair (hw : WeakColoring k c) (x : ℂ) :` | release `PaletteDensity.lean` (line 143) | OK |
| 5 | `lemma palette_sixty_disjoint (hw : WeakColoring k c) (x : ℂ) :` | release `PaletteTransport.lean` (line 450) | OK |
| 6 | `lemma two_state_impossible {k : ℕ} {c : ℂ → Fin k} (hc : Measurable c) (hw : WeakColoring k c)` | release `States.lean` (line 243) | OK |
| 7 | `lemma mem_spatialSupport_ae (hc : Measurable c) (i : Fin k) :` | release `AngularBoundary.lean` (line 309) | OK |
| 8 | "- **Port, declare nothing further.** C132-M-ORBIT, -M-EXCL, -DIAG-WIDE at `U = ℂ` need three release statements" | `plans/FS132-kernel-plan.md` § 3.6 (branch `fs132-wk1`) | OK |
| 9 | "Stands on two release statements only — `palette_sixty_disjoint`, `palette_transfer_pair` — and on the ported" | `plans/FS132-kernel-plan.md` § 3.3 | OK |

The brief's facts about the branch, checked: `fs132-wi2` is at `e3695302c`, the commit the brief names; the generated
module is 818 lines; `tools/fs132_k1_port.py --check` passes on it as given.

**Read for this stage**: the brief; `plans/STANDING-RULES.md`; `LEAN.md` in full; `RUNNING.md` § Building and § Make the
gate fail; the planner's `plans/FS132-kernel-plan.md` §§ 2.1, 2.4, 2.5, 2.6, 3.3, 3.4, 3.6, 3.7 whole; `tools/fs132_k1_port.py`
whole; `Outside/OAI158Palette.lean`'s header and its first 140 lines; `Outside/OAI158.lean` lines 1–95; the placeholders
of `Plane/SixRing/Orbit.lean` (their names and binders — the file is the planner's successor's, not edited). Of the
release: `Coloring.lean` whole; `PaletteDensity.lean` 1–20, 120–160; `PaletteTransport.lean` 380–458; `States.lean`
1–12, 85–100, 225–315; `AngularBoundary.lean` 140–150, 300–315; the import lines of fifteen files; the `LICENSE`
(Apache-2.0; no `NOTICE` file; the Lean files carry no copyright header).

**The four statements as the release has them** (each under `variable {k : ℕ} (c : ℂ → Fin k) (hc : Measurable c)` but
the third, which binds its own):

```lean
-- PaletteDensity.lean:143–150   (variable {k : ℕ} (c : ℂ → Fin k) (hc : Measurable c), line 79)
lemma palette_transfer_pair (hw : WeakColoring k c) (x : ℂ) :
    ∀ᵐ p ∂angularMeasure.prod angularMeasure,
      c (angularSum x 1 p) ∉ palette c hc x p.1 ∪ palette c hc x p.2 := by
-- PaletteTransport.lean:450–454 (variable {k : ℕ} (c : ℂ → Fin k) (hc : Measurable c), line 432)
lemma palette_sixty_disjoint (hw : WeakColoring k c) (x : ℂ) :
    ∀ᵐ f ∂angularMeasure, Disjoint (palette c hc x f) (palette c hc x (f+(sixty : Angles))) := by
-- States.lean:243–307
lemma two_state_impossible {k : ℕ} {c : ℂ → Fin k} (hc : Measurable c) (hw : WeakColoring k c)
    (x : ℂ) (J K : Finset (Fin k)) (hcard : (Finset.univ\(J∪K)).card≤2)
    (s : Angles → Bool) (hs : Measurable s)
    (hJ : RealState hc x {t : ℝ | s (t : Angles)=false} J)
    (hK : RealState hc x {t : ℝ | s (t : Angles)=true} K)
    (hflip : ∀ᵐt∂angularMeasure,s (t+(Real.pi/3 : ℝ))= !(s t)) : False := by
-- AngularBoundary.lean:309–312  (variable {k : ℕ} (c : ℂ → Fin k), line 306)
lemma mem_spatialSupport_ae (hc : Measurable c) (i : Fin k) :
    ∀ᵐz : ℂ∂volume,c z=i → z∈spatialSupport c i :=
```

The planner's placeholders in `Plane/SixRing/Orbit.lean` carry the same names in the namespace `HadwigerNelson.SixRing`,
with `open Outside.OAI158`; the ported theorems are `HadwigerNelson.Outside.OAI158.<same name>` with the release's
binders, so removing a placeholder leaves the name resolving to the ported theorem.

**The branch built as given.** `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh` from the worktree: **exit 0** (`data/fs132/i2/logs/build-0-as-given.exit`, read from the file the
command wrote, not through a pipe), "all 1849 modules already up to date, nothing built, 3 module(s) with warnings", 29
`declaration uses sorry` warnings, all in `Plane/SixRing/{Winding, Orbit, CyclicCentre}` — the planner's skeleton
(`data/fs132/i2/logs/build-0-as-given.out`).

Token count at this stage: own ≈ 135k (an estimate: this harness shows no meter).

## Stage 2 — SAVED (FS132-I2): the cone computed, the generator, the eight modules built

### 2.1 The cone, computed from the release's compiled constants

`data/fs132/i2/cone/ConeDump.lean`, run at the **release's** pin (Lean v4.34.1's own binary, `LEAN_PATH` the audit's
compiled copy of the release — `data/fs132/i2/leanrel.sh`; no `lake`; a marker file and `find -newer` read 0 files
written under `~/.cache/ext-oai1` and `~/source/math`): from each of the four statements it follows every constant
that the stored type or the stored proof names, keeps those declared in an `OAI.*` module, and prints each with the
source range of the declaration that owns it (`CONE` lines), every source declaration of every `OAI` module in the
import closure (`DECL` lines), and the dependencies (`EDGE` lines). `ConeDump.out`: **328 constants** (59 definitions,
269 theorems; no structure) **in 12 files, all under `OAI/Geometry/PlaneColoring/`**.

| release file | declarations | in the cone | source lines | where they are in this library |
|---|---|---|---|---|
| `Coloring.lean` | 11 | 10 | 15 | `Outside/OAI158` (FS132-I1, by hand) and `OAI158Palette`'s header (FS132-K1) |
| `WeakColoring.lean` | 19 | 18 | 147 | `OAI158Palette` (FS132-K1: lines 5–174, the whole file) |
| `Compactness.lean` | 51 | 39 | 230 | `OAI158Palette` (FS132-K1: 5–377, the whole file) |
| `Palettes.lean` | 16 | 9 | 19 | `OAI158Palette` (FS132-K1: 5–56) |
| `CircleMaps.lean` | 63 | **63** | 446 | **`OAI158CircleMaps`** (this job) |
| `Expansion.lean` | 37 | 8 | 134 | **`OAI158Expansion`** |
| `CircleTransport.lean` | 27 | 12 | 175 | **`OAI158CircleTransport`** (11; `angularSum` is in `OAI158Palette`) |
| `PaletteDensity.lean` | 31 | 29 | 396 | **`OAI158PaletteDensity`** (28; `liftPalette` is in `OAI158Palette`) |
| `PaletteTransport.lean` | 25 | 21 | 301 | **`OAI158PaletteTransport`** (20; `sixty` is in `OAI158Palette`) |
| `BinaryPalettes.lean` | 35 | 11 | 92 | **`OAI158BinaryPalettes`** |
| `States.lean` | 54 | 22 | 250 | **`OAI158States`** (21; `RealState` is in `OAI158Palette`) |
| `AngularBoundary.lean` | 55 | 2 | 6 | **`OAI158AngularBoundary`** (1; `spatialSupport` is in `OAI158Palette`) |

**Ported by this job: 163 declarations, 1,791 source lines, in eight generated modules.** Against the planner's
estimate (`plans/FS132-kernel-plan.md` § 3.6: "about 2,400 lines"):
- **No Fourier chain.** No constant of `OAI.Analysis.PlaneSpectrum.*` (`Fourier`, `CircleDecay`, `CircleOperator`), of
  `Transitions`, `BinaryDynamics`, `Rigidity` or `BoundaryTrace` is in the cone of any of the four statements.
- **One file the estimate lacks: `Expansion.lean`**, 8 of its 37 declarations — pulled in by
  `circleSum_tendsto_L1` (`CircleTransport`; it uses `tendsto_integral_norm_comp_sub_eventual`) and by
  `palette_trace_branch` (`PaletteTransport`; `line_antilipschitz_qmp`, `line_indicator_pullback_L1`).
- `CircleMaps` is needed whole; `BinaryPalettes` only for its triangle (11 of 35); `States` for 22 of 54.
- Per statement: `palette_transfer_pair` 183 constants, `palette_sixty_disjoint` 275, `two_state_impossible` 244,
  `mem_spatialSupport_ae` 2.

**The two lemmas the planner's successor asked for** (the coordinator's relay): `circleSum_quasiMeasurePreserving`
(`CircleMaps.lean:509`) and `angleMk_quasiMeasurePreserving` (`PaletteDensity.lean:158`) — **the cone held both**; they
are in `OAI158CircleMaps` and `OAI158PaletteDensity`, nothing was added for them.

The Mathlib imports of each module are not chosen by hand either: `ImportsDump.lean` (same pin) prints, per release
file, the modules declaring the Mathlib constants its cone's stored terms name, reduced to those no other of the
list imports (`ImportsDump.out`, 61 lines); every one exists at this library's pin, and the build needed none beyond
them.

### 2.2 The generator: `tools/fs132_i2_port.py`

Nothing is retyped. The generator copies each cone declaration by its line range from the clone (refusing a clone at
any other commit), keeps each section's scaffolding (`noncomputable section`, `open`, `namespace`, `variable`,
`include`, `omit … in`) and drops a section left with no declaration; it refuses a line it cannot classify, a cone
declaration it cannot place, a module whose imports do not cover what the cone's edges say it uses. What it changes
in the copied text, all of it listed in each module's header (the Apache-2.0 notice of change):

1. the namespace (`OAI.EuclideanFiveColor` → `HadwigerNelson.Outside.OAI158`);
2. a source address at the head of every declaration's docstring;
3. the selection (declarations outside the cone left out; those already in `OAI158Palette` replaced by a `--` comment);
4. **seven PATCHES, each to a proof** — the generator refuses a patch inside a definition or before a theorem's
   top-level `:=`:

| file:line | release's text → here | why |
|---|---|---|
| `CircleMaps.lean:385` | `)) K.2` → `)) K.coe_nonneg` | `K.2 : 0 ≤ K.val` names the coercion `ℝ≥0 → ℝ` as `Subtype.val`; `nlinarith` at v4.32.0 does not take it for the atom `(K : ℝ)` |
| `CircleMaps.lean:466` | `linarith [K.2]` → `linarith [K.coe_nonneg]` | the same |
| `PaletteDensity.lean:182` | `using 1; rfl` → `using 1 <;> rfl` | `convert … using 1` leaves two goals at v4.32.0 where the release's pin leaves one; each is `rfl` |
| `PaletteDensity.lean:480` | `ite_eq_right hi` → `if_neg hi` | core renamed `if_neg` on 2026-07-21; at v4.32.0 only the old name |
| `PaletteTransport.lean:447` | `Set.mem_ofPred_eq` → `Set.mem_setOf_eq` | Mathlib renamed `setOf` and its lemmas on 2026-07-09 |
| `States.lean:122` | `mem_ofPred_eq` → `mem_setOf_eq` | the same |
| `States.lean:183` | `preimage_ofPred_eq` → `preimage_setOf_eq` | the same |

5. **one RENAME, which reaches statements** — `Set.domRestrict` (Mathlib v4.34.1) is `Set.restrict` (v4.32.0): Mathlib
   renamed the function on 2026-07-19, the definition's text is the same at both tags
   (`Mathlib/Data/Set/Restrict.lean:32`), and at v4.34.1 the old name is a deprecated alias. The release writes it on
   **32 lines of the cone, 19 of them inside the statements of 16 intermediate lemmas**; none of the four target
   statements and no definition names it. The token is written `restrict` wherever it occurs, by a table separate
   from PATCHES; the generator refuses a rename inside a definition, and each header lists the lines. **Ruled by the
   coordinator** (its message of 2026-10-07, after my report of the finding): the table stands, and no shim that
   would declare `Set.domRestrict` in this library.
6. **one sentence added to a docstring** (the coordinator's ruling on the read-back): `two_state_impossible`'s names
   the set-builder constant that differs between the pins (stage 3).

**Its checks.** `--check` regenerates in memory and compares with the eight files, runs FS132-K1's check of
`OAI158Palette`, and checks that `scripts/Axioms.lean` holds this job's block as generated
(`data/fs132/i2/logs/port-check.out`: nine files OK, the block's 163 records, `CHECK OK`). `--self-test`
(`logs/port-selftest.out`): **eight plants refused** — a generated file changed by two spaces; a file absent; the four
`CONE` lines of `palette_transfer_pair` removed; a `CONE` line added; a patch that does not apply; a patch into a
statement; a patch into a definition; the clone at another commit — **and one partner accepted** (a patch into a proof
is generated, and the files then differ). *One plant was unreachable as first written and the self-test caught it*:
removing the single `CONE` line of `palette_transfer_pair` left its generated constants (`._simp_1_1`, …) in the cone,
which carry the declaration's range, so nothing changed and the plant read SILENT; it now removes every line of the
declaration and asserts that it removed something.

**FS132-K1's generator, extended in two places** (`tools/fs132_k1_port.py`; its docstring says so): a declaration
with the release's own docstring now carries its source address at the head of that docstring (four declarations:
`all_parameters_product_zero`, `exists_countable_essential_union`, `Straddle`, `spatialSupport`), and the header of
`OAI158Palette` names the licence and lists every change, its one patch included. The diff of the regenerated module
is those four docstrings and the header; no declaration, statement or proof moved.

### 2.3 The builds

All through `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`
from the worktree; each exit status read from the file the command wrote.

| build | what | result | log |
|---|---|---|---|
| 1 | the first three modules (`CircleMaps`, `Expansion`, `CircleTransport`) | exit 0; 3 modules rebuilt (2.7 s, 2.2 s, 2.0 s); 8m39s, nearly all of it the walk over 476 batches | `data/fs132/i2/logs/build-1-three-files.out` |
| 2 | all eight, registered in `Proofs.lean`, with `OAI158Palette` regenerated | **exit 0; 14 modules rebuilt** (`OAI158Palette`, the eight, the planner's four `Plane/SixRing/*`, `Proofs`); 9m25s; the only warnings are the 29 `declaration uses sorry` of the planner's skeleton, in 3 modules; **no warning from any generated module** | `logs/build-2-all.out` |
| 3 | again, nothing changed | exit 0, "all 1857 modules already up to date" — the compiled modules are the files `--check` reads | `logs/build-3-uptodate.out` |

Each ported module elaborates in 2–3 s. Registered: `Proofs.lean` (eight new lines), `ARCHITECTURE.md` (eight new
rows after `Outside/OAI158Palette`'s; `tools/check_architecture.py`: `RESULT: PASS`, `logs/arch-1.out`),
`scripts/Axioms.lean` (the block headed "FS132-I2", 163 records, above the PURCHASED banner).

### 2.4 The price, as measured

- **Lines**: 1,791 source lines, 163 declarations, 8 modules (2,620 lines with headers and docstrings).
- **Fixes**: 7 proof patches and 1 rename — one fix per about 220 lines; the planner measured one per 600 on its
  sample. The same order: nothing here took more than one attempt, and five of the eight fixes are three Mathlib/core
  renames.
- **Builds**: three runs of `build.sh` (8m39s, 9m25s, 2 s); iteration was `lean` on a scratch farm, 2–4 s a module.
- **What cost more than the port**: the read-back across pins (stage 3) — the port's text was green within the first
  hour.

Token count at this stage: own ≈ 330k (an estimate: this harness shows no meter).

## Stage 3 — SAVED (FS132-I2): the read-back across pins, the axioms, the statements read aloud, the registrations and the guarded lint

### 3.1 The four statements as this library holds them, read aloud

`data/fs132/i2/checks.lean` → `checks.out` (`lake env lean`, after the build; exit 0):

```
@palette_transfer_pair : ∀ {k : ℕ} (c : ℂ → Fin k) (hc : Measurable c), WeakColoring k c → ∀ (x : ℂ),
    ∀ᵐ (p : Angles × Angles) ∂angularMeasure.prod angularMeasure, c (angularSum x 1 p) ∉ palette c hc x p.1 ∪ palette c hc x p.2
@palette_sixty_disjoint : ∀ {k : ℕ} (c : ℂ → Fin k) (hc : Measurable c), WeakColoring k c → ∀ (x : ℂ),
    ∀ᵐ (f : Angles) ∂angularMeasure, Disjoint (palette c hc x f) (palette c hc x (f + ↑sixty))
@two_state_impossible : ∀ {k : ℕ} {c : ℂ → Fin k} (hc : Measurable c), WeakColoring k c → ∀ (x : ℂ) (J K : Finset (Fin k)),
    (Finset.univ \ (J ∪ K)).card ≤ 2 → ∀ (s : Angles → Bool), Measurable s →
      RealState hc x {t | s ↑t = false} J → RealState hc x {t | s ↑t = true} K →
        (∀ᵐ (t : Angles) ∂angularMeasure, s (t + ↑(Real.pi / 3)) = !s t) → False
@mem_spatialSupport_ae : ∀ {k : ℕ} (c : ℂ → Fin k), Measurable c → ∀ (i : Fin k), ∀ᵐ (z : ℂ), c z = i → z ∈ spatialSupport c i
```

Read against the release's lines (stage 1), each for every number of colours `k` and a Borel colouring `c` of the
plane proper at almost every unit pair:
- **`palette_transfer_pair`** (`PaletteDensity.lean:143`): fix a centre `x`. For almost every pair of directions
  `(s, t)` — product of the two normalized angle measures — the colour of the point `x + e(s) + e(t)`
  (`angularSum x 1 p = x + 1·e(p.1) + e(p.2)`) is in neither the palette of `x` at `s` nor the palette of `x` at `t`.
  Binders as the release's: `c` and `hc` explicit (its section variables), then `hw`, `x`.
- **`palette_sixty_disjoint`** (`PaletteTransport.lean:450`): for almost every direction `f`, the palette of `x` at `f`
  and the palette of `x` at `f + π/3` have no label in common (`sixty = π/3`).
- **`two_state_impossible`** (`States.lean:243`): there is no measurable two-valued function `s` on the circle of
  directions such that the directions where `s` is false lie, up to a null set of the line, in the lifted palette of
  every label of `J`, those where it is true in that of every label of `K`, at most two colours are outside `J ∪ K`,
  and `s` flips under rotation by `π/3` almost everywhere. Binders the release's: `k`, `c` implicit, `hc` explicit.
- **`mem_spatialSupport_ae`** (`AngularBoundary.lean:309`): almost every point of colour `i` lies in the essential
  support of the class of `i` (the support of Lebesgue measure restricted to it).

The planner's placeholders in `Plane/SixRing/Orbit.lean` have these names and binders; deleting them leaves
`open Outside.OAI158` resolving to the ported theorems. I did not edit that file.

### 3.2 Their axioms, with controls that fire

`tools/fs132_i2_axioms.py emit` → `data/fs132/i2/axioms/Print.lean` (163 records — the block of `scripts/Axioms.lean` —
and three controls); `lake env lean` on the final build (exit 0) → `Print.out`; `check` → `check.out`, **exit 0**:
**163 of 163 printed, each on exactly `[propext, Classical.choice, Quot.sound]`**; neither
`Outside.OAI158.no_proper_five_coloring` nor `Outside.OAI158.proper_to_borel_weak` is under any of them, the four
statements included. **The controls**, printed in the same run: `not_colorable_five` shows `no_proper_five_coloring`;
`chromaticNumber_plane_eq_chiM0` shows `proper_to_borel_weak`; a `sorry` stated in the file shows `sorryAx` — so the
print sees each of the three things it is trusted not to find. `--self-test` (`selftest.out`): an outside theorem,
`sorryAx` and a native axiom planted under a target, a record not printed, a control gone clean — 5 of 5 refused.

### 3.3 The read-back: the ported declarations against the release's, as the kernel stores them at the two pins

**What it is for** (the coordinator's ruling, 2026-10-07): a ported theorem is kernel-checked here, so nothing about
its truth rests on its being the release's term; the read-back is an instrument for the sentence "this is the
release's lemma", and for catching a definition that means something else at this pin. **It does not show the port
identical to the release term for term, and no check could**: the same text elaborates against a Mathlib 1,502
commits apart.

**The instrument**: `tools/fs132_i2_readback.py`. One dumper text, written into `ReleaseDump.lean` (run at the
release's pin, `data/fs132/i2/leanrel.sh`) and `HereDump.lean` (run by `lake env lean` on the built modules), prints
for each of the cone's 328 constants its stored type, and for a definition its stored value, twice: the **full** print
(FS132-I1's), and an **erased** print in which every instance argument and every proof argument is `_` (an argument
is erased when the applied function's own signature, read in `MetaM` at that pin, takes it instance-implicitly or at a
proposition). The prints are 17.8 MB and 18.2 MB; committed as `ReleaseDump.out.xz`, `HereDump.out.xz` (96 kB each;
`prints.sha256`; the print from the final build has the digest of the one compared).

**The declared map, all of it** — applied to the release's print, nothing else is normalised but the two namespaces
and the two anonymous instances FS132-I1 and FS132-K1 named by hand:

| what | release's pin → this pin | why it is not a difference in meaning | checked |
|---|---|---|---|
| rename | `Set.domRestrict` → `Set.restrict` | Mathlib renamed the function on 2026-07-19; in the ported text by the generator's RENAMES | level 1: one type, one value at the two pins — IDENTICAL |
| rename | `Set.ofPred` → `setOf` | Mathlib renamed it on 2026-07-09; **never in the text**: the set-builder notation `{x \| p x}` elaborates to the name of the pin | level 1: IDENTICAL |
| unfolding | `Filter.EventuallySubset l s t` → `Filter.EventuallyLE l s t` at `Prop` | Mathlib (2026-08-14) made `s ≤ᵐ[μ] t` on sets a definition of its own, `EventuallySubset l s t := EventuallyLE l (· ∈ s) (· ∈ t)`; at this pin the notation gives the right-hand side | a kernel `rfl` at the release's pin, and the notation's own `rfl` at each pin (`ReleaseLevel1.lean`, `HereLevel1.lean`; both exit 0) |

**The verdicts** (`data/fs132/i2/readback/compare.out`; `READBACK OK`, exit 0, on the built modules):

| class | IDENTICAL | UP-TO-INSTANCES | other |
|---|---|---|---|
| the four targets | **4** | 0 | — |
| definitions (58) | 44 | 14 | — |
| lemmas (181) | 158 | 23 | — |
| generated auxiliaries (85) | 68 | 8 | 6 absent here under the release's name, 3 another statement under it |

- **IDENTICAL**: the full stored terms agree after the map. **UP-TO-INSTANCES**: the erased prints agree and the full
  ones do not — the two terms differ only inside instance arguments and proof arguments. **No constant is DIFFERENT**
  in a target, a definition or a lemma.
- **The four targets are IDENTICAL as stored** — `two_state_impossible` after the map's second line (its two
  set-builders; its docstring says so), the other three with no entry of the map used.
- **The definitions, each by name with its verdict and its differing constants**:
  `data/fs132/i2/readback/targets-and-definitions.tsv` (62 rows). The 29 definitions of the eight release files this
  job ported from (24 ported here, 5 copied earlier by FS132-K1: `angularSum`, `liftPalette`, `sixty`, `RealState`,
  `spatialSupport`) are **all IDENTICAL**. The 14 UP-TO-INSTANCES are all in the chain FS132-K1 ported
  (`OAI158Palette`): `weakHilbert`, `WeakBall.Space`, `WeakBall.value`, `WeakBall.ofNorm`, `IsTrace`
  (`WeakDual.instAddCommMonoid` there, `instAddCommMonoidWeakDual` here — Mathlib's instance under two names — and
  the chain `Semifield → Semiring`); `sample`, `TraceVector`, `traceValue`, `sampleCode`, `RealL2`, `oneL2`,
  `tracePositive`, `paletteGenerators` (a generated proof under another name: the three release files are one module
  here and share `PlaneL2._proof_1`, the proof of `Fact (1 ≤ 2)`, where the release has one per file); `shiftL2`
  (Mathlib's additive structure on `Lp`, reached by another chain of instances).
- **The lemmas that are not IDENTICAL** (23; `lemmas.tsv`, with the auxiliaries): 9 in this job's modules — 7 where
  only the argument order of Mathlib's `Measure.instSMul` differs (the same constants on both sides:
  `angleChart_measure`, `map_restrict_volume_le`, `line_map_restrict_volume_le`, `integrable_comp_of_map_le`,
  `integral_norm_comp_le`, `tendsto_integral_norm_comp_sub`, `tendsto_integral_norm_comp_sub_eventual`) and 2 by the
  generated proof's name (`trace_pair_disjoint`, `palette_trace_branch`); 14 in `OAI158Palette`.
- **The sixteen statements that hold the rename**: 13 IDENTICAL; 3 UP-TO-INSTANCES (`map_restrict_volume_le`,
  `line_map_restrict_volume_le`, `palette_trace_branch`, by the two causes just named). With the rename withdrawn
  from the map, exactly those sixteen fail (the self-test's plant).
- **The constants that differ inside instance and proof arguments are a recorded set**: 47
  (`instance-constants.txt`: 39 of Mathlib and core, 8 generated proofs of the port); a constant not in the record
  fails the run, and so does a recorded one that no longer differs. One of the release's own constants there, other
  than a generated proof, is a DIFFERENT.
- **One level down** (`level1.out`, `LEVEL1 OK`): of the 94 Mathlib and core constants that the four targets and the 29
  definitions under them name outside instance and proof arguments, 81 are stored alike at the two pins (type, and
  value or constructors), 4 moved to another module, 9 differ inside Mathlib (`Bool.not`, a binder name;
  `InnerProductSpace`, `NormedAddCommGroup`, `LinearIsometryEquiv`, `MeasureTheory.Lp`, `Measure.restrict`,
  `InnerProductSpace.toDual`, `StrongDual.toWeakDual`, `WeakDual.toStrongDual`: instance paths and universe order in
  Mathlib's own definitions) — listed for reading, not failed.

**What the read-back leaves to trust**: that Mathlib's instances for one class on one type agree at each pin — the
content of every UP-TO-INSTANCES verdict — which no print across pins can check; and Mathlib itself below level one.

**Its controls** (`selftest.out`, 13 of 13 refused, the unplanted pair passing): a second constant differing in a
statement that also holds the declared rename (`NNReal` in `circleSum_local_antilipschitz` — the control the
coordinator asked for: a rename the map was not told about is refused); a constant renamed in a target; **an
undeclared constant inside an instance argument only** (refused: not in the record); one of the release's own
constants inside an instance argument; each rename withdrawn in turn (16 statements fail each time); a rename
pointing at another constant; a numeral in `sixty`'s value; a binder kind in a target; a target missing; a target
turned axiom; a truncated print; a stale record.

### 3.4 The registrations and the checks of the brief's item 6

| check | command | result | saved |
|---|---|---|---|
| the final build | `slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` | **exit 0**; 6 modules rebuilt (a header's wording); 29 `sorry` warnings, all the planner's skeleton; none from a generated module | `data/fs132/i2/logs/build-4-final.out` |
| no `sorry`, no `axiom`, no `native_decide` in the nine generated modules | `rg` | none (two hits are the headers' own words "no `sorry`") | — |
| the generated text | `tools/fs132_i2_port.py --check` | exit 0; **with a change planted in a real file** (`card≤2` → `card≤3` in `two_state_impossible`'s statement in `OAI158States.lean`): exit 1, "OAI158States.lean differs from the generated text"; regenerated, exit 0 | `logs/port-check-planted.out`, `logs/port-check.out` |
| the module map | `tools/check_architecture.py` | `RESULT: PASS` (eight new rows) | `logs/arch-2-final.out` |
| doubled names | `./scripts/dupnames.sh` (slot, 16 GiB) | **exit 0**: 1857 of 1857 package modules scanned, no name declared by two modules, no ported name among the 23 generated-on-demand names | `logs/dupnames.out` |
| the environment linters | `slot.py --mem 8 -- lake lint --no-build -- --no-build --trace` | **exit 0**, `-- Linting passed for Proofs.`, every linter `(2/2) Passed!` | `logs/lint.out` |

**Not run, by the brief**: the full gate (`axioms.sh`, `vacuity.sh`, `assumptions.sh` and their self-tests) — a landing
job's. For that job: the block in `scripts/Axioms.lean` adds 163 CLEAN records; the port adds no hypothesis-form
assumption and no axiom; `OAI158Palette`'s own declarations (FS132-K1's) are in no audit block yet — those in the
cone are under the four statements' prints, the others (`Straddle`, `TransitionEdge`, …) under none.

### 3.5 The instances the ported modules declare, and on whose type (the coordinator's question)

| instance | module | source | scope | the type it is an instance on |
|---|---|---|---|---|
| `instIsFiniteMeasureRealPlaneAngleChartMeasure : IsFiniteMeasure angleChartMeasure` | `OAI158CircleMaps` (**this job's only one**) | `CircleMaps.lean:301` | global | **the release's own**: `angleChartMeasure` is a definition of the release (a measure on `ℝ × ℝ`); the instance is found only for that constant |
| `angularMeasure.instIsProbabilityMeasure` | `OAI158` (on `main`) | `Coloring.lean:19` | global | the release's own (`angularMeasure`) |
| `angularMeasure.instIsAddHaarMeasure` | `OAI158Palette` (FS132-K1) | `Coloring.lean:20` | global | the release's own |
| `anglePeriodPositive : Fact (0 < 2*Real.pi)` | `OAI158` (on `main`) | `Coloring.lean:15` | **scoped** by FS132-I1 | Mathlib's (`ℝ`) |
| `WeakBall.instCompactSpaceSpace`, `WeakBall.instMetrizableSpaceSpace` | `OAI158Palette` (FS132-K1) | `Compactness.lean:160–162` | global | **Mathlib's, through a reducible abbreviation**: `WeakBall.Space E` is an `abbrev` for the subtype `{v : WeakDual ℝ E // WeakDual.toStrongDual v ∈ Metric.closedBall 0 1}`, so the two instances are on a subtype of Mathlib's weak dual and reach every module downstream |
| a private anonymous `Fact ((2 : ENNReal) ≠ ⊤)` | `OAI158Palette` (FS132-K1) | `Compactness.lean:250` | global (the name is private, the instance is not) | **Mathlib's** (`ENNReal`) |

No ported module declares a `@[simp]` lemma whose left-hand side is not headed by one of the release's own
definitions (six in `OAI158Palette`: `direction_norm`, `direction_real`, `weakHilbert_apply`, `value_ofNorm`,
`traceValue_sampleCode`, `mem_palette`; none in this job's eight modules). I changed none of these: the landing decides.

### 3.6 The price, final

| | |
|---|---|
| ported | 163 declarations (138 theorems, 24 definitions, 1 instance), 1,791 source lines, 8 modules |
| fixes | 7 proof patches, 1 rename (32 lines), 0 patches to a statement or a definition; 0 imports added to the computed list |
| builds | four runs of `build.sh` (8m39s, 9m25s, 2 s, 8m56s — the walk; each module is 2–3 s) |
| three statements + the small lemma | 4 of 4 green |
| own token count | ≈ 420k at this stage (an estimate; no meter) — of which the read-back, its two rulings and its controls are about a third |

## Drafts for the front page

*Each names its slot. Nothing here is filed by me.*

**D1 — `CLAUDE.md` § Trust ledger**, to follow the sentence ending "…its first import, `[Falconer1981]` Lemma 2 (i), is a
theorem since FS131-IF1." (when the branch lands; the counts are the landing's to read from its own `axioms.sh`):
> Three of the release's lemmas that FS-132's first theorem stands on — `Outside.OAI158.palette_transfer_pair`,
> `palette_sixty_disjoint` and `two_state_impossible`, with `mem_spatialSupport_ae` — are not imports: their proofs are
> ported from `[OAIMath2026]` family 158 (163 declarations in eight generated modules, FS132-I2), kernel-checked at this
> pin on the standard three, and rest on neither declared outside theorem.

**D2 — `CLAUDE.md` § Trust ledger, the audit's counts**: the block adds **163 clean records** (6533 → 6696 clean if
nothing else moves; 5 purchases and 18 imported unchanged; the landing reads the receipt).

**D3 — `LEAN.md` § Assumptions**, after the bullet "An imported theorem carries four things", a new bullet:
> - **An outside Lean proof may be ported instead of imported** (`Outside/OAI158CircleMaps` … `OAI158States`, FS132-I2):
>   compute the cone of the wanted statements from the source's own compiled constants at its pin, copy those
>   declarations by line range with a generator that refuses a patch to a statement or a definition
>   (`tools/fs132_i2_port.py`), and build. The kernel then checks every proof here and no axiom enters. A read-back
>   across pins (`tools/fs132_i2_readback.py`) is an instrument for "this is the source's lemma", never a gate on
>   truth, and it cannot read "term for term": the same text elaborates against another Mathlib. It reports IDENTICAL,
>   or identical up to instance and proof arguments with the differing constants recorded, under an explicit map of
>   Mathlib's renames between the pins; what it leaves to trust is that Mathlib's instances for one class on one type
>   agree at each pin.

**D4 — `LEAN.md` § Searching — Lean**, three new bullets:
> - Between Mathlib `v4.32.0` and `v4.34.1`: `Set.restrict` became `Set.domRestrict` (2026-07-19), `setOf` became
>   `Set.ofPred` (2026-07-09; the set-builder notation elaborates to the pin's name, so two prints of one text differ
>   by it), `s ≤ᵐ[μ] t` on sets became `Filter.EventuallySubset` (2026-08-14; here it is `Filter.EventuallyLE` at
>   `Prop`), and core's `if_neg` became `ite_eq_right` (2026-07-21). A text written at the later pin needs the earlier
>   names here (FS132-I2).
> - `K.2 : 0 ≤ K.val` for `K : ℝ≥0` is not the atom `(K : ℝ)` to `linarith`/`nlinarith` at the pin; `K.coe_nonneg` is.
> - `lean -o` writes no `.olean` when the file has an error, and a `LEAN_PATH` entry holding a `Proofs/` directory
>   hides every later entry's `Proofs`: a scratch farm is a symlink copy of the build's library with the modules under
>   work written over it (`data/fs132/i2/lean1.sh`).

**D5 — `ARCHITECTURE.md` § Trust**: no new row (no purchase, no import). Its § 3 rows for the eight modules are on the
branch.

**D6 — `BIBLIOGRAPHY.md`, `[OAIMath2026]`'s entry**, to add to what of ours rests on it and what of it is held:
> Ported into this library (FS132-I2, 2026-10-07; Apache-2.0, each generated module's header is the notice of change):
> of `lean/OAI/Geometry/PlaneColoring/` at commit `adc7f124`, `CircleMaps.lean` whole and parts of `Expansion`,
> `CircleTransport`, `PaletteDensity`, `PaletteTransport`, `BinaryPalettes`, `States`, `AngularBoundary` — 163
> declarations, 1,791 lines, with FS132-K1's 620 lines of `WeakColoring`, `Compactness`, `Palettes` — the cone of
> `palette_transfer_pair` (the manuscript's Lemma 5.2 (1)), `palette_sixty_disjoint` (Corollary 5.3),
> `two_state_impossible` (Lemma 6.4 at every `k`) and `mem_spatialSupport_ae`. Read for the port: those files' cone
> declarations as text (by the generator) and the four statements with their definitions by eye; the proofs were
> compiled, not read.

**D7 — the Frontier line and the Proof Atlas**: none from this job (no ledger row; no grade moves — the four statements
are the release's, now [kernel] here in place of the planner's placeholders).

## What was checked, and by whom

By the kernel at this pin: all 163 proofs (four builds, exit 0). By instruments of this job, each with a control
watched to fire: the quotations (3 plants), the generated text (8 plants and a partner, and a change planted in a real
file), the axioms (3 controls in the print, 5 plants), the read-back (13 plants). By one mind, by eye: the four
statements against the release's lines; the seven patches' reasons; the map's three entries against Mathlib's source at
the two tags. Not checked: the release's proofs were not read; Mathlib between the two tags below level one.

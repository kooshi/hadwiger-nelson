# FS132-I2 — the port: the release's lemmas that FS-132's first theorem stands on, proved in this library with no new axiom

*Record of the implementer (de Bruijn, Opus 5.5). Brief: `data/fs132/briefs/FS132-I2-port.md` on `main` at `dcf89464e`.
Branch `fs132-wi2`, cut from `fs132-wk1` at `e3695302c`; worktree `.claude/worktrees/fs132-wi2`. Working files:
`data/fs132/i2/`. Tools: `tools/fs132_i2_port.py` (the generator and its check), `tools/fs132_i2_readback.py` (the
ported statements and definitions against the release's, as the kernel stores them at the two pins). The outside
clone (`/home/kooshi/source/math`, commit `adc7f1241b42e322a6451854ab7e4b4c146bf78a`) and the audit's compiled copy
(`~/.cache/ext-oai1/lean`) were read; nothing was written into either.*

## Theorems this phase proved

*(Filled at the stage that builds them; none before stage 2.)*

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

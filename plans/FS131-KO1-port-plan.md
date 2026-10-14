# FS131-KO1 — the plan for porting `[OAIMath2026]`'s transfer proof, so that two declared outside theorems become theorems under their present names

*de Bruijn, the planner; job FS131-KO1 (brief: `data/fs131/briefs/FS131-KO1-port-plan.md`, committed on `main` at
`36a0ddd06`). Branch `fs131-wp1`, cut from `main` at `747e139d0` in the worktree `.claude/worktrees/fs132-wi1`.
Working files: `data/fs131/ko1/`. The outside release is `[OAIMath2026]` family 158 at commit
`adc7f1241b42e322a6451854ab7e4b4c146bf78a` of `/home/kooshi/source/math` (read, never written or run), compiled at its
own pin by the audit (`/home/kooshi/.cache/ext-oai1/lean`, read only).*

## Theorems this phase proved

None. A planning job: the cone, the overlap map, the switch, a trial of generated modules (the release's lemmas,
kernel-checked at this pin by elaboration, not this project's mathematics, and not part of the library), and the plan.

## Stage 1 — SAVED: the readback

**1.1 The branch.** The brief names `main` at `955b0bdda`; `main` had moved to `747e139d0` by launch (four commits:
FS131-FC3's filing and this brief's own commit `36a0ddd06`). No `.lean` file, `lakefile.toml`, `lake-manifest.json` or
`lean-toolchain` differs between `955b0bdda` and `747e139d0` (`git diff --stat … -- '*.lean' lakefile.toml
lake-manifest.json lean-toolchain`: empty), so the branch is cut from `747e139d0`, which holds the brief and the
current `LEAN.md` (sixteen lines filed by FC3, read in full at launch).

**1.2 The compiled library** — copied from `.claude/worktrees/fs131-wrc` (branch `fs131-f3` at `64ec24c16`, the tree
whose gate passed last; read only there). Its Lean sources are this branch's: `git diff --stat 64ec24c16 747e139d0 --
'*.lean' lakefile.toml lake-manifest.json lean-toolchain` is empty. `data/fs131/ko1/copy/copy-build.sh`: sha256 of
every file of the source's `.lake/build` before the copy, `cp -a`, sha256 of every file of the copy, sha256 of the
source again after; **20,712 files, the three listings identical** (`cmp` exit 0 twice; `data/fs131/ko1/copy/status.txt`;
the three listings hash alike, `listings.sha256`; one is kept, `build-files.sha256.xz`). `.lake/packages` is the main tree's,
by the tree's existing symlink.

**1.3 The brief's quotations** — `tools/fs131_ko1_readback.py` (each quotation, its lines joined, a substring of its
source; where the source names a section, the quotation lies under that heading): **5 matched, 0 mismatched**, exit 0
(`data/fs131/ko1/readback-brief.out`) — W4 against `data/fs131/REQUEST-2026-10-13.md`; the two rows of the audit's
table, each under `§ The pieces to adopt, and what each rests on (measured)` of `plans/EXT-OAI1-audit.md`; items 728
and 718 against `plans/FS131-close-inventory.md`. `--fault` (the last character of each quotation changed): 0 matched,
5 mismatched, exit 1 (`readback-brief-fault.out`). No finding about the brief.

**1.4 What was read.** The brief; `plans/STANDING-RULES.md`; `LEAN.md` whole; `RUNNING.md` § Building and § Make the
gate fail; the audit `plans/EXT-OAI1-audit.md` stages 3, 4, 6 and 8 whole (the cone by text, the build, the proof's
shape and module graph, the pieces to adopt); `Outside/OAI158.lean` whole (the declared module on `main`); on the
density equality's branch `fs133-wb1` (tree `.claude/worktrees/fs133-wk1`, at `8ed85e9b8`, read only)
`Outside/OAI158Rigidity.lean` ll. 1–200 (the six copied definitions, the axiom, `residual_fourier_cross`, the model's
first helpers) and the generator `tools/fs133_ia1_port.py` whole; the three earlier ports' records at the places below.

**1.5 What each earlier port did at this pin** (the pattern this plan extends).

| port | generator | what it copied | patches at this pin | what it added to the method |
|---|---|---|---|---|
| FS132-K1 → FS132-I2 (on `main`, landed by FS132-L2) | `tools/fs132_k1_port.py`, `tools/fs132_i2_port.py` | the cone of four palette lemmas: 163 + K1's declarations, 1,791 source lines, in nine modules `Outside/OAI158Palette` … `OAI158States`, one per release file (`OAI158Palette` holds three) | 7 proof patches and 1 rename (`Set.domRestrict` → `Set.restrict`, on 32 lines, 19 in statements of intermediate lemmas, by ruling) — one fix per ~220 lines | the cone from the release's compiled constants (`ConeDump.lean`: `DECL`, `CONE`, `EDGE` lines); copy by line range; refuse a patch to a statement or a definition; imports from `ImportsDump.lean`; the definitions already in `Outside/OAI158` replaced by a `--` comment; a read-back across pins (`tools/fs132_i2_readback.py`) as an instrument |
| FS133-IA1 (on `fs133-wb1`, not landed) | `tools/fs133_ia1_port.py` | the cone of 25 targets in three release files, 48 declarations, 314 lines, one module `Outside/OAI158Transfer` | 5 proof patches (two renames, an unused simp argument, one Mathlib lemma that gained a hypothesis) — one per ~60 lines; 11 min 32 s from the generator's first line to a clean elaboration | the two release namespaces made one, a collision refused; `UPSTREAM` definitions checked to be declared upstream; `AUX_UNPORTED` (a generated `._proof_n` the release's elaborator shares across a file); `SCOPED` / `GLOBAL_INSTANCES`, every instance in exactly one; and the finding that the import list, not only the pin, chooses a stored statement's instance path (the two `CStarAlgebra` imports); leaf R: the release's stored statement rebuilt at this pin and checked by this kernel to be definitionally the declared one |
| FS131-IE1 (family 015, on `fs131-we1`) | `tools/fs131_ie1_port.py` | three whole files and three declarations, 72 declarations, 947 lines | 7 one-token renames, predicted exactly by its planner's trial | whole files read off the text (a declaration starts at a column-0 keyword); a scan for anything that runs code at elaboration before any copy; imports measured per module (`--mathlib-whole`, then the import dump, then elaboration); `DROP_OPEN` for namespaces absent under the module's imports |

Prices against practice in all three: the port's text was green within the first hour each time; what cost more was
the read-back across pins (FS132-I2) and the instance-path question (FS133-IA1).

## Stage 2 — SAVED: the cone and the overlap map

**2.1 The cone, from the release's compiled constants.** `data/fs131/ko1/cone/ConeDump.lean` — FS133-IA1's dumper
(itself FS132-I2's) with this job's import (`OAI.Geometry.PlaneColoring.Five`, so the whole 70-module cone is in the
environment) and three targets, one bit each: the transfer `OAI.EuclideanFiveColor.proper_to_borel_weak` (bit 0), the
rigidity lemma `OAI.PlaneFiveColor.Spectral.residual_fourier` (bit 1), the headline
`OAI.EuclideanFiveColor.no_proper_five_coloring` (bit 2, for the record only). Run at the release's pin (Lean
v4.34.1's own binary, `LEAN_PATH` the audit's compiled copy, no `lake`; `data/fs131/ko1/leanrel.sh`): exit 0, 6 min
41 s, 6.9 GiB; `SUMMARY targets=3 cone-constants=3520 decl-lines=2684`. No file was written under
`~/.cache/ext-oai1` or `~/source/math` (`find -newer` on a marker made before the run: none). The reader is
`tools/fs131_ko1_overlap.py` (`data/fs131/ko1/overlap.out`); its control (`--control`, `overlap-control.out`) reports
each of three plants — a cone name planted in a listing, the axiom removed from the density listing, one `CONE` line
dropped.

| target | constants | source declarations | source lines | release files |
|---|---|---|---|---|
| the transfer `proper_to_borel_weak` | 1,995 (+ 2 below) | 1,299 | **12,005** | 32 |
| the rigidity lemma `residual_fourier` | 1,800, **every one in the transfer's cone** | 1,165 | 11,310 | 30 |
| the headline (stays declared) | 3,518 | 2,390 | 24,156 | 70 |

The audit's 1,997 for the transfer is these 1,995 and the two `NORANGE` constants, both generated by the elaborator for
the private `PhaseEncoding.fromPowers` (`….fromPowers.match_1._arg_pusher`, `….match_1.splitter`), whose owner is in
the cone; the generator must accept such a generated auxiliary of a ported declaration. The audit's "about 16,600
lines" was its estimate at 8.6 lines per constant; the measured source is **12,005 lines**. **So the brief's statement
that the rigidity lemma's cone lies inside the transfer's is confirmed**: porting the transfer's cone ports both.

**2.2 The cone per release file**, in dependency order (depth: 1 + the deepest file whose cone constants this file's
name; the order is the release's own import order restricted to what the cone uses):

| depth | release file | in the cone | lines | uses (within the cone) |
|---|---|---|---|---|
| 1 | `PlaneSpectrum/Basic` | 96 of 112 | 611 | — |
| 1 | `PlaneSpectrum/InvariantMean` | 115 of 134 | 823 | — |
| 1 | `PlaneSpectrum/NumberFields` | 40 of 43 | 451 | — |
| 1 | `PlaneSpectrum/PhaseEncoding` | 24 of 24 | 193 | — |
| 1 | `PlaneSpectrum/SmallArcs` | 19 of 19 | 242 | — |
| 1 | `PlaneColoring/Coloring` | 8 of 11 | 13 | — (all eight already here: 2.3) |
| 1 | `CompactFactors/Amenability` | 41 of 58 | 276 | — |
| 1 | `CompactFactors/Centers` | 90 of 103 | 537 | — |
| 2 | `PlaneSpectrum/Characters` | 42 of 42 | 492 | Basic |
| 2 | `PlaneSpectrum/PhaseCollision` | 21 of 23 | 368 | PhaseEncoding |
| 2 | `PlaneSpectrum/Selections` | 22 of 22 | 352 | NumberFields |
| 2 | `CompactFactors/RelativeCenters` | 38 of 42 | 422 | Basic, Centers |
| 3 | `PlaneSpectrum/Multipliers` | 29 of 30 | 230 | Basic, Characters, InvariantMean |
| 3 | `CompactFactors/ConditionalSelection` | 18 of 19 | 350 | PhaseCollision, PhaseEncoding |
| 4 | `PlaneSpectrum/FourierTests` | 15 of 16 | 224 | Basic, Characters, InvariantMean, Multipliers |
| 5 | `PlaneSpectrum/ConditionalSpectrum` | 33 of 36 | 398 | Basic, ConditionalSelection, FourierTests, Multipliers, PhaseEncoding, SmallArcs |
| 6 | `CompactFactors/Approximation` | 14 of 14 | 396 | Basic, ConditionalSpectrum, FourierTests, PhaseEncoding, RelativeCenters |
| 7 | `CompactFactors/ConditionalLimits` | 18 of 21 | 474 | Approximation, Basic, ConditionalSelection, ConditionalSpectrum, FourierTests, PhaseEncoding, RelativeCenters, SmallArcs |
| 8 | `CompactFactors/Kernels` | 33 of 34 | 603 | ConditionalLimits, ConditionalSelection, RelativeCenters |
| 9 | `CompactFactors/BoundedFunctions` | 41 of 54 | 132 | ConditionalSelection, Kernels |
| 9 | `CompactFactors/Functions` | 31 of 32 | 735 | ConditionalSelection, Kernels |
| 10 | `CompactFactors/Factors` | 63 of 83 | 387 | ConditionalLimits, Functions, Kernels |
| 10 | `CompactFactors/RelativeProducts` | 49 of 72 | 277 | Amenability, BoundedFunctions, Kernels, RelativeCenters |
| 11 | `CompactFactors/Separability` | 47 of 53 | 403 | Amenability, BoundedFunctions, Kernels, RelativeProducts |
| 11 | `CompactFactors/Stationary` | 22 of 23 | 164 | Approximation, Basic, ConditionalLimits, Factors, FourierTests, Functions, InvariantMean, Kernels, RelativeCenters |
| 12 | `CompactFactors/AlgebraModels` | 37 of 43 | 449 | Amenability, BoundedFunctions, ConditionalSelection, Kernels, RelativeProducts, Separability |
| 13 | `PlaneSpectrum/Representations` | 76 of 88 | 366 | AlgebraModels, Basic, Stationary |
| 14 | `PlaneSpectrum/Energy` | 45 of 49 | 334 | Representations and ten more |
| 14 | `PlaneSpectrum/SpectralMeasure` | 52 of 57 | 305 | Basic, BoundedFunctions, ConditionalSpectrum, Representations |
| 15 | `PlaneSpectrum/RadialEnergy` | 27 of 28 | 363 | Energy, Selections and twelve more |
| 16 | `PlaneSpectrum/Ergodicity` | 40 of 52 | 298 | RadialEnergy, SpectralMeasure and fifteen more |
| 17 | `PlaneColoring/BorelTransfer` | 53 of 54 | 337 | Basic, Coloring, Ergodicity, Representations |

Seven leaves of the dependency graph import only Mathlib (Basic, InvariantMean, NumberFields, PhaseEncoding,
SmallArcs, Amenability, Centers); the longest chain is 17 files, through the `CompactFactors` arm
(Centers → RelativeCenters → Approximation → ConditionalLimits → Kernels → … → AlgebraModels → Representations →
Energy → RadialEnergy → Ergodicity → BorelTransfer). `residual_fourier` is in `Ergodicity`, at depth 16.

**2.3 The overlap map** — every name of the transfer's cone, under the one-namespace map
(`OAI.EuclideanFiveColor.X`, `OAI.PlaneFiveColor.X` → `HadwigerNelson.Outside.OAI158.X`; no two cone names collide
under it), against every constant this library compiles (`data/fs131/ko1/lean/NamesDump.lean`, at this pin: `main`'s
library in this tree, 25,286 constants, `names-main.out.xz`; the density branch `fs133-wb1` from its own tree's
compiled `.olean`s by `LEAN_PATH`, read only, 25,187 constants, `names-fs133wb1.out.xz`; the hashes of the oleans read
there, `fs133wb1-oleans.sha256`).

| module | holds, of the cone | how the full port treats it |
|---|---|---|
| `Outside/OAI158` (main) | the six `Coloring.lean` definitions copied by FS132-I1 — `ProperColoring`, `anglePeriodPositive` (scoped here), `Angles`, `angularMeasure`, `direction`, `WeakColoring` — and the axiom `proper_to_borel_weak` | **definitions kept and imported** (upstream, as for the palette port); **the axiom deleted**: the ported theorem takes its name in `Outside/OAI158BorelTransfer`, and the axiom's five consumers move, unchanged, to one new module downstream (the switch, stage 3; ruled in Amendment 1) |
| `Outside/OAI158Palette` (main, FS132-K1) | `direction_continuous` and the instance of `Coloring.lean:20`, anonymous there and named `angularMeasure.instIsAddHaarMeasure` here | **kept and imported**; the ported `BorelTransfer` imports this module (so the theorem cannot be upstream of `Outside/OAI158`, which is why the switch moves the consumers and not the definitions) |
| the eight other palette modules (main) | nothing | untouched |
| `Outside/OAI158Rigidity` (`fs133-wb1`) | the six copied definitions `Spectral.E`, `Spectral.K`, `Spectral.DiscreteE` (with the derived `instCommGroupDiscreteE`), `Spectral.kCoeff`, `ContinuousVectors.op`, `ContinuousVectors.space`, and the axiom `Spectral.residual_fourier` | at that branch's join: **the copies deleted and replaced by their ported originals** (`OAI158Basic`, `OAI158Representations`, same names), **the axiom deleted** (the ported theorem, same name, in `OAI158Ergodicity`); the branch's own `residual_fourier_cross`, `residual_fourier_model` and the model's helpers kept |
| `Outside/OAI158Transfer` (`fs133-wb1`, FS133-IA1) | all 48 of its declarations (63 constants with the generated ones) | at that branch's join: **the module deleted** — each of the 48 is generated from its original, under the same name, in `OAI158Basic`, `OAI158Representations` or `OAI158BorelTransfer` |

**No other name of the library is a name of the cone.** The 1,299 source declarations less the 8 of `Coloring.lean`
(all already here) are **1,291 declarations in 31 generated modules**, every name new on `main`.

**2.4 The headline's residual, for the record** (Done item 6): of the headline's 2,390 source declarations, those in
neither the transfer's cone nor this library (`main`, the palette ports counted) are **843 declarations, 9,885 source
lines, in 35 release files** — the five-colour obstruction arm: `DiskExtension` 518, `Expansion` 475,
`BinaryDynamics` 460, `Interfaces` 451, `FourContinuity` 442, `AngularBoundary` 433, `States` 425, `Sectors` 406,
`Moser` 399, `Rigidity` 396, `FourTransport` 388, and 24 more (`overlap.out` lists all). It stays declared; with this
port, porting it would retire the library's last declared theorem of the release, and its price would be measured from
this port's practice.

## Stage 3 — SAVED: the trial — three modules generated and elaborated, the shared definitions compared, the exposure measured

*Amendment 1 of the brief (2026-10-14 04:33 UTC, on `main`) ruled proposal (a) — the port lands on `main` first, one
module per release file, and the density equality's branch takes it at its join — and the switch for the transfer
theorem; it asks this trial to report any stored statement of ours that moves in more than instance arguments under the
port's import closure, and any ported definition whose stored term differs from that branch's copy. **Neither
happened** (3.4, 3.5).*

**3.1 The generator** — `tools/fs131_ko1_port.py` (this job's; FS133-IA1's `tools/fs133_ia1_port.py` is the pattern
and is not edited; FS131-IE1's scan is folded in). One module `Outside/OAI158<Stem>` per release file; what it changes
in the copied text is its docstring's list (namespaces, imports, docstring addresses, the scoped instances, patches,
renames, `open` tokens) and nothing else; the per-module tables are data, one JSON file per module under
`data/fs131/ko1/port/` (so lanes that port different modules write different files). Its file reader treats a file
as a stack of scopes (nested `noncomputable section`s, named sections, namespaces), a multi-line `omit … in` /
`include … in` with its declaration, a reserved name made on demand in another module (`f.eq_1`, `f.congr_simp`)
with its owner, and an attribute's companion (`@[ext]`'s `ext_iff`, `@[simps]`'s `_apply`) inside its declaration;
`--parse-all` reads **all 31 files with no line unclassified**. A structure field with no docstring gets its source
address as one (this library's `linter.missingDocs` reads public fields; met in `Centers`). `--self-test`
(`data/fs131/ko1/trial/port-selftest.out`): **17 plants refused, 2 partners accepted** — a generated file changed by two
spaces, absent; a declaration's `DECL` line removed; a `CONE` line in a file outside the plan; a `NORANGE` constant
that is no generated auxiliary; a patch that does not apply, into a statement, into a definition; a `scoped` entry and
a `global_instances` entry withdrawn; the scan's `set_option` and `IO.` in copied lines; an unclassified `#eval` line;
an `UPSTREAM` entry removed; the licence copy changed by a byte, absent; the clone at another commit — and the two
partners: a patch into a proof is generated and the file then differs; the `CONE` lines of a copied declaration
removed change nothing (whole files, 3.2). `--check` on the three modules: `CHECK OK`.

**3.2 A finding about the method: the cone misses what proofs use only definitionally — so the port copies whole
files.** Generated from the cone alone, the three modules' first elaboration (`trial/*-try1.out`) gave **53 errors**,
of which the largest class was `unknown identifier` for release lemmas the cone did not hold — `embed_mul`,
`shift_apply`, `cshift_apply`, `circlePull_apply`, `circleMean_apply`, `lift_fst`, `lift_snd`, `embedF_mul` — each
an `@[simp]` lemma proved by `rfl`, and most of the `unsolved goals` after them. A `simp` that rewrites with an `rfl`
lemma leaves no constant of it in the proof term, so no cone computed from compiled constants can see it. Across the
31 files only **129 declarations, 462 source lines** are outside the cone (73 of them `@[simp]`-tagged, 27 named in
the copied text); and the 31 files import nothing of the release but each other and `Coloring.lean`. So **every
declaration of each of the 31 files is copied** (12,005 + 462 lines of declarations; the files are 15,964 lines with
their scaffolding), the cone stays the check that nothing it holds is missed (it must lie inside the files'
declarations, and each module's cone edges inside its imports), and the module imports are the release file's own
`import OAI.…` lines, mapped (`Coloring` → `Outside/OAI158Palette`, which imports `Outside/OAI158`). The 129 add no
name that the library holds on `main`; on `fs133-wb1` they add one, `Koopman.unitary_apply`, which
`Outside/OAI158Transfer` holds and the join retires with that module (`tools/fs131_ko1_overlap.py`'s check, re-run on
the whole files). The Mathlib import dump over every constant of the 31 files (`cone/ImportsDumpWhole.lean`, at the
release's pin) is **byte-identical** to the dump over the cone (`ImportsDump.out`, 195 lines, 67 Mathlib modules): the
whole files name no Mathlib module the cone does not. With whole files, the second elaboration of `InvariantMean` had
no error at all.

**3.3 The three modules** (each from its whole file; `data/fs131/ko1/farm1.sh` — `lean -o` into the scratch farm
`build/ko1-farm`, the lakefile's three options by flag, `--root=.` so module and private names are the library's).

| module | release file | declarations | generated lines | patches at this pin | elaboration | state |
|---|---|---|---|---|---|---|
| `Outside/OAI158Basic` | `PlaneSpectrum/Basic.lean`, 735 lines | 110 (96 of the cone) | 928 | **4**: `isAlgebraic_natCast` → `isAlgebraic_nat`, `isAlgebraic_ratCast` → `isAlgebraic_rat` (renames); twice `first \| rfl \| (…)` → `all_goals first \| rfl \| (…)` after `convert h using 1`, which leaves two goals at v4.32.0 where the release's pin leaves one (FS132-I2 met the same) | 17 s, 3.5 GiB | **0 errors, 0 warnings** |
| `Outside/OAI158InvariantMean` | `PlaneSpectrum/InvariantMean.lean`, 1,078 lines | 134 (115) | 1,234 | **0** | 11 s, 3.5 GiB | **0 errors, 0 warnings** |
| `Outside/OAI158Centers` | `CompactFactors/Centers.lean`, 703 lines | 103 (90) | 872 | 5 renames applied (`Set.mem_ofPred_eq` → `Set.mem_setOf_eq` ×3, `ite_eq_right` → `if_neg` ×2) | 6 s, 3.4 GiB | **13 errors left, one class** (below); not finished in this trial |

**Centers' class: Mathlib changed `Measure.map` and `ProbabilityMeasure.map` between the pins.** At v4.32.0 (here)
`Measure.map f μ` is `0` when `f` is not almost-everywhere measurable, and `ProbabilityMeasure.map (ν) {f}
(f_aemble : AEMeasurable f ν)` takes the measurability as its explicit argument; at v4.34.1 (the release)
`Measure.map` is a non-zero measure of the same mass even then, and `ProbabilityMeasure.map (ν) (f)` takes the map and
no proof (`⟨ν.map f, inferInstance⟩`) — read in both pins' `Mathlib/MeasureTheory/Measure/Map.lean` and
`…/ProbabilityMeasure.lean`. The release writes `μ.map (fun point => point + v)` for a probability measure **inside
statements** (`center_translate`, `center_orthogonal`, `frequencyLaw_translate`, `frequencyLaw_orthogonal`,
`center_equivariant`: five sites) and builds a probability measure as `⟨….map …, inferInstance⟩` **inside a
definition** (`frequencyLaw`, its proof component); `Measure.map_smul` takes one more argument in proofs. Each is
refused by the generator's rules as they stand, rightly: they are not renames. Each has the same meaning at the two
pins **for a measurable map**, which every site's map is (a translation, a linear isometry, a continuous coordinate) —
so the repair is an *adaptation*: `μ.map (f := g) h` with `h` the map's measurability, and `isProbabilityMeasure_map h`
for the `inferInstance`. The plan (stage 4) makes this a ruled class of its own.

**3.4 The shared definitions, against the density branch's copies** — `data/fs131/ko1/lean/SharedPorted.lean` (the
ported `OAI158Basic` from the farm) and `SharedDensity.lean` (`fs133-wb1`'s compiled `OAI158Rigidity` and
`OAI158Transfer` by `LEAN_PATH`, read only), each printing FS132-I2's full and instance-erased prints, compared by
`tools/fs131_ko1_exposure.py`'s reader (`data/fs131/ko1/shared/`): **8 of 8 IDENTICAL**, types and the six values —
`Spectral.E`, `Spectral.K`, `Spectral.DiscreteE`, `Spectral.instCommGroupDiscreteE` (the copies of `OAI158Rigidity`),
`Spectral.E_countable`, `Spectral.imagUnit`, `Spectral.kCoeff_ne_zero` (of `OAI158Transfer`) and `Spectral.kCoeff`.
Run again after the import change of 3.5: still 8 of 8 (`ported-noCPO.out`). *What is not yet compared*:
`ContinuousVectors.op`, `ContinuousVectors.space` and the 45 other declarations of `OAI158Transfer` from
`Representations.lean` and `BorelTransfer.lean` — those modules sit at depths 13 and 17 and need the chain below them;
their comparison is a check of the lane that ports them (stage 4, the join recipe's step 0).

**3.5 The exposure: does a stored statement of ours move when it sees the port's imports?** —
`tools/fs131_ko1_exposure.py`. For each module that would see the port's import closure — on `main`, `Outside/OAI158`
(its five consumers of the transfer move, unchanged, to a module that imports the port), `Plane/RadiusOutside`,
`Plane/LebesgueNumber`; on `fs133-wb1` at its join, `Outside/OAI158Rigidity` and every density module, read from that
tree's build — two scratch copies are elaborated at this pin under the module's own name: the text as it stands, and
the text with one block of imports added (the 67 Mathlib modules of the port's dump and `Outside/OAI158Palette`'s).
Exactly one thing differs. The reader classes each named constant IDENTICAL, INSTANCES-ONLY (full prints differ,
prints with instance and proof arguments erased agree), DIFFERENT or MISSING; its control (`--control`,
`exposure/`) classes a planted instance-only change, a real change and a removed constant as planted. *An instrument
fault of mine, caught by that control*: its first reader matched `DUMP   type ?=` with one optional space where the
print has two, so it read no type and called every constant IDENTICAL; the control's assertion that it had three
constants with a type fired, the pattern was repaired, and every comparison in this section is from the repaired
reader.

| module | constants | with the port's imports | without `Mathlib.Order.CompletePartialOrder` |
|---|---|---|---|
| `Outside/OAI158` (main) | 29 | **1 INSTANCES-ONLY**: `seven_le_chromaticNumber_plane_iff` | 29 IDENTICAL |
| `Plane/RadiusOutside` (main) | 8 | 8 IDENTICAL | 8 IDENTICAL |
| `Plane/LebesgueNumber` (main) | 34 | 34 IDENTICAL | 34 IDENTICAL |
| `Outside/OAI158Rigidity` (wb1) | 10 | 10 IDENTICAL | 10 IDENTICAL |
| `Plane/OneClass/Defs` (wb1) | 50 | **3 INSTANCES-ONLY**: `mOne`, `mOne_eq_iSup_nullMeasurableSet`, `SimpleGraph.inv_finIndepRatio_le_iSup_fractionalChromaticNumber` | 50 IDENTICAL |
| `Plane/OneClass/Field` (wb1) | 1 | 1 IDENTICAL | 1 IDENTICAL |
| `Plane/OneClass/InvariantLaw` (wb1) | 9 | 9 IDENTICAL | 9 IDENTICAL |
| `Plane/OneClass/Algebraic` (wb1) | 9 | 9 IDENTICAL | 9 IDENTICAL |
| `Plane/OneClass/Fractional` (wb1) | 7 | **1 INSTANCES-ONLY**: `OneClass.iSup_fractionalChromaticNumber_plane` | 7 IDENTICAL |
| `Plane/OneClass/Pair` (wb1) | 19 | 19 IDENTICAL | 19 IDENTICAL |
| `Plane/OneClass/SectionDensity` (wb1; *not exposed*: it imports four Mathlib modules and nothing the join changes) | 9 | 2 INSTANCES-ONLY | 2 INSTANCES-ONLY: `ofReal_integral_le_measure_pos`, `sectionDensity_setOf_pos` |

**No constant is DIFFERENT and none MISSING, with or without that module.** Every move is in instance arguments
only, and every move in an exposed module is one mechanism: a supremum `⨆` whose `SupSet` is reached through
`CompletePartialOrder.toSupSet` when `Mathlib.Order.CompletePartialOrder` is imported, in place of the
`ConditionallyCompletePartialOrderSup` path (the constants by which the two prints differ, named in
`exposure/OAI158-*`); FS131-IE1 met the same module and left it out of its port. **Left out of the port's imports
(`drop_imports` in each module's table), nothing of ours moves in any exposed module**, and the three trial modules
elaborate without it (`trial/*-try7.out`: Basic and InvariantMean 0 errors, Centers the same 13) with the shared
definitions still identical. The variant adds the whole 67-module union to every module, a superset of what each will
import; the landing's own before-and-after dump of the real modules is the check that decides. SectionDensity's two
moves (the `NormedSpace ℝ ℝ` of a Bochner integral reached through `RCLike` when inner-product modules are loaded) are
in a module the join does not touch; they say that the union, added where it is not imported, would move them.

**3.6 Prices from the trial, not from line counts.** Patches per release line: Basic 4 in 735, InvariantMean 0 in
1,078, Centers 5 renames and one adaptation class (about ten sites) in 703 — against FS133-IA1's one per 60 lines and
FS132-I2's one per 220. Elaboration is 6–17 s and 3.5 GiB a module; a first try and its patches took under ten minutes
per module once the generator ran. The known renames recur across the 31 files (by text: `ofPred` 8 lines,
`ite_eq_right`/`ite_eq_left` 16, `lipschitzWith` 5, `isAlgebraic_…Cast` 6, `summable_norm_of_tsum_eLpNorm_ne_top`
1); `convert … using` 29 lines (two-goal risk); and the adaptation class lives where `ProbabilityMeasure` does —
**264 lines in 26 of the 31 files** — with `isProbabilityMeasure_map` 9 and `Measure.map_smul` 3 lines. That class,
not the renames, is the cost of this port.

**3.7 Where the trial's files are.** The three generated modules are kept as the trial's evidence under
`data/fs131/ko1/trial/generated/` (with `SHA256SUMS`), **not** under `Proofs/` and not in `Proofs.lean`: they were
elaborated by `lean -o` with the lakefile's three options by flag, not built by `./scripts/build.sh`, and `Centers` does
not elaborate yet. The lane that owns them regenerates them into `Proofs/HadwigerNelson/Outside/` from the same
generator and tables (`--check` then compares). The elaboration logs are `trial/*-try1.out` … `*-try7.out` (each
attempt kept); the shared-definition comparison is `shared/compare.txt` (both runs 8 of 8 IDENTICAL, every print with
its type read); the exposure dumps are compressed (`exposure/*.out.xz`, `prints.sha256` for the uncompressed bytes)
and `exposure/compare-all.txt` is the reader's verdict on all 22 runs.

## Stage 4 — SAVED: the plan

*Under the brief's two amendments: (a) the port lands on `main` first and the density branch takes it at its join;
the switch for the transfer as stage 2.3 has it; whole files; `Mathlib.Order.CompletePartialOrder` out of every
module's imports; and (Amendment 2, the coordinator's message of 2026-10-14) the adaptations table, on the conditions
of 4.3.*

### 4.1 What is ported, and how

**31 generated modules**, `Proofs/HadwigerNelson/Outside/OAI158<Stem>.lean`, one per release file of 2.2, each the
**whole file** (3.2), by **one generator**, `tools/fs131_ko1_port.py` at this stage's commit, with **one table per
module**, `data/fs131/ko1/port/<Module>.json` (keys: `patches`, `renames`, `adaptations`, `scoped`,
`global_instances`, `drop_open`, `drop_imports`, `more_imports`). A lane changes only the tables of its own modules;
**the generator is frozen** for the lanes — a defect in it is a `tool defect` for the coordinator, and the planner (or a
job the coordinator names) changes it between lanes, never two lanes at once. Every table carries
`drop_imports: [["Mathlib.Order.CompletePartialOrder", …]]` when the dump lists that module for its file (the
generator refuses a `drop_imports` entry the dump does not list, so the entry is written exactly where it applies).
The `Coloring.lean` declarations stay this library's copies (`UPSTREAM`: six in `Outside/OAI158`, five in
`Outside/OAI158Palette`); nothing of `main` is replaced.

**Instances**, by the tables' rule as in the trial: `scoped` for an instance on a Mathlib type (`Spectral.E_countable`
on `algebraicClosure ℚ ℂ`, FS133-IA1's ruling); global for an instance on a type built from the release's own
definitions (`DiscreteE`, `K`, `D`, `PeriodGroup`, …), each listed with its reason; `local instance` needs no entry.

**Every lane elaborates in a scratch farm**, never through `Proofs.lean`: `data/fs131/ko1/farm1.sh <Module>` (the
lakefile's three options by flag, `--root=.`, `lean -o` into `build/ko1-farm`), every earlier lane's modules
regenerated from their tables and compiled first, in the order of 2.2 (about 10 s and 3.5 GiB each). **Lane D alone
registers** (`Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`) and runs `./scripts/build.sh` — so no two lanes
share a file.

### 4.2 The lanes

| lane | modules (release files, whole) | lines | needs | writes | price, from the trial |
|---|---|---|---|---|---|
| **A** — the spectral base | `Basic` ✓ and `InvariantMean` ✓ (the trial's: tables written, 0 errors), `SmallArcs`, `PhaseEncoding`, `Characters`, `PhaseCollision`, `Multipliers`, `ConditionalSelection`, `FourierTests`, `ConditionalSpectrum` | 5,035 (3,222 new) | this plan | its ten modules and tables; its record and `data/fs131/<job>/` | 2–3 h: renames and `convert` cases (about 18 lines of known tokens), `ProbabilityMeasure` on 45 lines (19 in `ConditionalSpectrum`) |
| **B** — the factor base | `Centers` (the trial's: 5 renames in its table, the adaptations to write), `Amenability`, `NumberFields`, `Selections`, `RelativeCenters` | 2,668 | this plan (`Basic` regenerated from its table) | its five modules and tables; record; data | 2–3 h: `Centers` is the heaviest file of the cone for the adaptation class (47 `ProbabilityMeasure` lines, about ten sites), `RelativeCenters` 18 |
| **C** — the compact factors | `Approximation`, `ConditionalLimits`, `Kernels`, `BoundedFunctions`, `Functions`, `Factors`, `RelativeProducts`, `Separability`, `Stationary`, `AlgebraModels` | 5,574 | A and B | its ten modules and tables; record; data | 4–6 h: the adaptation class is densest here (`ConditionalLimits` 23, `AlgebraModels` 19, `Kernels` 18, `Functions` 16, `RelativeProducts` 15 lines) |
| **D** — the spectral top, the switch, the registration | `Representations`, `Energy`, `SpectralMeasure`, `RadialEnergy`, `Ergodicity`, `BorelTransfer`; the switch (4.4); the join recipe's step 0 (4.5) | 2,656 | C | its six modules and tables; **the switch's edits** (`Outside/OAI158`, the new module `Outside/OAI158Collapse`, one import line each in `Plane/RadiusOutside` and `Plane/LebesgueNumber`); `Proofs.lean` (32 lines), `ARCHITECTURE.md` (32 rows, two rows' text), `scripts/Axioms.lean` (the generated block, T's records moved to CLEAN, T's `declareImport` removed); record; data | 4–6 h with the build (the switch edits `Outside/OAI158`, so its whole downstream recompiles: about 30 modules, 15–50 minutes on the laptop) |

**Order**: A and B in parallel (each from this branch; they share no file); C from their merge (clean: no shared
file); D from C. Then the landing (Keryx's) with the gate. **Every price above is from the trial's three files** —
Basic 4 patches in 735 lines, InvariantMean 0 in 1,078, Centers 5 renames and about ten adaptation sites in 703 — and
the per-file counts of the class's text (3.6); the adaptation sites elsewhere are an estimate scaled from one file
(about one per five `ProbabilityMeasure` lines in `Centers`: some 55 in all), and the lane that meets the first file
denser than that re-prices. **Every lane's receipts**, for its own modules:
1. `tools/fs131_ko1_port.py --check --modules <its>`: `CHECK OK`;
2. each module elaborated by `farm1.sh` with **0 errors and 0 warnings**, the log kept;
3. `#print axioms` of every declaration of its modules, from the farm's oleans: a subset of the standard three, none
   `sorryAx` (the generator's `--axioms-block` lists them), with a planted `sorry` in a scratch copy watched to fire;
4. the read-back across pins of its modules' stored statements (FS132-I2's comparator `tools/fs132_i2_readback.py`
   imported as a module, as FS133-IA1 did, with this port's name map): each IDENTICAL, UP-TO-INSTANCES, or **ADAPTED**
   with the strip check of 4.3; none DIFFERENT;
5. its tables' every entry with its reason; and a statement in its record that no table entry touches a protected
   declaration (the generator refuses, and the record says it was not asked to).

### 4.3 The adaptation class (Amendment 2)

**What it is.** Mathlib changed `Measure.map` and `ProbabilityMeasure.map` between the pins (3.3). An *adaptation*
is a token of a release-internal statement or definition rewritten so that the same object is named at this pin:
`ν.map g` (a `ProbabilityMeasure`) → `ν.map (f := g) h`, and `⟨μ.map g, inferInstance⟩` → `⟨μ.map g,
isProbabilityMeasure_map h⟩`, with `h` the measurability of `g`. **The conditions** (the coordinator's ruling):
- **No adaptation adds a hypothesis or a binder.** `h` is a closed term built from what the statement's context
  already has — a translation (`(measurable_add_const v).aemeasurable`), an isometry (`O.continuous.aemeasurable`), a
  continuous coordinate. A site that would need a new hypothesis goes to the coordinator; the lane stops that module.
- **Refused** on the target statements (`proper_to_borel_weak`, `Spectral.residual_fourier`, and every constant the
  declared axioms' stored statements name — all of them `UPSTREAM` copies or shared declarations here); on every
  declaration the density branch shares (the generator reads that branch's names; its plant is refused,
  `trial/port-selftest.out`); and on anything a statement of ours names (lane D's check: every ported constant named by
  a stored statement of a non-generated module, listed, none ADAPTED).
- **Listed** in the module's header with its reason (the generator does it: item "Adaptations — ADAPTED"); the
  read-back flags each ADAPTED; and **the strip check**: the adapted declaration's instance-erased print at this pin,
  with the inserted measurability argument removed at each adapted site, is the release's erased print — and a planted
  control (another argument changed at an adapted site) is refused. The lane that writes the first adaptation writes
  this check as `tools/<its prefix>_strip.py`; the later lanes import it.

**The line for `LEAN.md` § Assumptions** (the coordinator's filing; slot: the bullet "An outside Lean proof may be
ported instead of imported", following its sentence ending "…the generator refuses a patch to a statement or a
definition (`tools/fs132_i2_port.py`), and build."): *"One exception, by ruling: an* adaptation *— a release-internal
statement or definition whose Mathlib API changed between the pins (`Measure.map`, `ProbabilityMeasure.map` between
v4.32.0 and v4.34.1), rewritten to name the same object here by inserting a closed measurability argument, never a
hypothesis or a binder; refused on the target statements, on any declaration another branch holds a copy of, and on
anything a statement of ours names; listed in the module's header, flagged ADAPTED by the read-back, and checked
mechanically to differ from the source's print only by the inserted argument (FS131-KO1). The refusal holds for
everything else."*

### 4.4 The switch for the transfer, on `main` (lane D, in one commit with `OAI158BorelTransfer`'s registration)

The ported `BorelTransfer` declares `HadwigerNelson.Outside.OAI158.proper_to_borel_weak` and imports
`Outside/OAI158Palette`, hence `Outside/OAI158`: the axiom of that name must be gone from `Outside/OAI158` before the
ported module is elaborated against the real library (the farm, which holds no `Proofs` module but the ported ones,
elaborates it before).

| step | what | check |
|---|---|---|
| 0 | before any edit: dump every named constant of `Outside/OAI158`, `Plane/RadiusOutside`, `Plane/LebesgueNumber` from the build as it stands (`tools/fs131_ko1_exposure.py`'s footer and reader on the compiled modules, or FS124-L2's `StatementDump`), and of every module downstream of `Outside/OAI158` | the dump exists, its count matches the module's named constants |
| 1 | `Outside/OAI158`: delete the `axiom proper_to_borel_weak`; move `nonempty_aeColouring_of_colorable`, `colorable_iff_nonempty_aeColouring`, `chiM0_le_chromaticNumber_plane`, `chromaticNumber_plane_eq_chiM0`, `seven_le_chromaticNumber_plane_iff` and the `example` that applies the transfer, **character for character with their docstrings**, into the new module `Outside/OAI158Collapse` (imports `Outside/OAI158BorelTransfer` and `Plane/YesLimit`, namespace `HadwigerNelson.Outside.OAI158`); the module docstring of `OAI158` rewritten to say T is a theorem of the port | the moved text is the same bytes (a script compares the declarations' text before and after) |
| 2 | `Plane/RadiusOutside` and `Plane/LebesgueNumber`: `import Proofs.HadwigerNelson.Outside.OAI158` → `import Proofs.HadwigerNelson.Outside.OAI158Collapse`; nothing else | the diff is those two lines |
| 3 | build (`./scripts/build.sh` under the slot) | exit 0, no warning from any changed or generated module |
| 4 | dump again; compare with step 0 | **every named constant IDENTICAL** (full prints), the five moved ones included and now in `OAI158Collapse`; `proper_to_borel_weak` has kind `theorem` where it had `axiom`, its stored type IDENTICAL. If it is INSTANCES-ONLY (the ported module's imports reach `Measurable`'s instances otherwise), the kernel check of FS133-IA1's leaf R (`tools/fs133_ia1_rebuild.py`, its `Rebuild.lean`): the axiom's printed type rebuilt in the new environment and `rebuilt = (type of the theorem) := Eq.refl _` accepted, with its two plants |
| 5 | `#print axioms` of the twelve records that rested on T | each the standard three, no import |

The exposure test (3.5) predicts step 4: under the port's imports without `CompletePartialOrder`, the 29 constants of
`OAI158` and those of the two leaf modules are IDENTICAL. Stored binder names of instance arguments carry their
module (`LEAN.md`); the canonical print erases macro scopes, so a moved declaration compares equal.

### 4.5 The join recipe — the density equality's branch taking the port (for its landing brief to quote)

*On a tree holding `fs133-wb1` merged with `main` after this port has landed.*

| step | what | check |
|---|---|---|
| 0 | **before the join** (lane D, on `main`'s port): compare every declaration `fs133-wb1` copies or ports — the six definitions and derived instance of `Outside/OAI158Rigidity`, the 48 of `Outside/OAI158Transfer` — with the ported ones, from that branch's build (read only) and the port's (`data/fs131/ko1/lean/SharedPorted.lean` / `SharedDensity.lean`, the name list extended to the 55) | **every one IDENTICAL**, type and value (Basic's 8: done, 3.4); one that is not stops the join and goes to the coordinator |
| 1 | before the merge, on `fs133-wb1`'s build: dump every named constant of its eight modules (FS133-IA1's `StatementDumpErased.lean`, its `before`) | the dump's count |
| 2 | merge `main` into the branch | git reports conflicts only in files both changed (`Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`); resolve by keeping both sides' lines |
| 3 | delete `Outside/OAI158Transfer.lean`, its `Proofs.lean` line, its `ARCHITECTURE.md` row, its block in `scripts/Axioms.lean` | `rg -uu OAI158Transfer Proofs scripts ARCHITECTURE.md` finds only prose |
| 4 | `Outside/OAI158Rigidity`: delete the six copied definitions (with the `deriving` clause) and the `axiom residual_fourier`; add `import Proofs.HadwigerNelson.Outside.OAI158Ergodicity`; keep `residual_fourier_cross`, `residual_fourier_model` and their private helpers, character for character; rewrite the module docstring (the import is gone) | the kept declarations' text is the same bytes |
| 5 | `Plane/OneClass/Field`: `import …Outside.OAI158Transfer` → `import …Outside.OAI158BorelTransfer` | the diff is that line |
| 6 | `./scripts/dupnames.sh` on the joined tree, **before the audit** | green: no name declared twice (the 63 constants of 2.3 are each declared once) |
| 7 | build | exit 0 |
| 8 | dump again (step 1's dumper); compare | every named constant of the eight modules IDENTICAL (the exposure test, 3.5, predicts it); the axiom is gone and `Spectral.residual_fourier` is a theorem of `OAI158Ergodicity`: its stored type compared with the axiom's step-1 print — IDENTICAL, or INSTANCES-ONLY and then FS133-IA1's leaf R kernel check (`rebuilt = theorem's type := Eq.refl _`, with its plants) |
| 9 | `#print axioms` of `residual_fourier_cross`, `OneClass.exists_field` and every record of the density module | the standard three; `scripts/Axioms.lean` declares no `residual_fourier` import |

### 4.6 What the landings then read

**The port's landing (after lane D).** `scripts/Axioms.lean`: T's `declareImport` line removed; T's twelve records
(5 of `OAI158Collapse`, 4 of `Plane/RadiusOutside`, 3 of `Plane/LebesgueNumber`) move from IMPORTED to CLEAN; the
generated block of the 31 modules (about 1,400 records) under CLEAN. The audit's counts: **imported 26 → 14** (8 on
Weil's bound, 6 on the headline), **clean +12 +the port's records**; the library's axioms **3 → 2**
(`StandingFive.kloosterman_bound`, `Outside.OAI158.no_proper_five_coloring`). The assumptions digest:
`axioms=3 rests=26` → **`axioms=2 rests=14`**, the other seven counts unchanged (no hypothesis is added or retired);
`ARCHITECTURE.md` § Trust: T's line removed. `CLAUDE.md` § Trust ledger and § The aim's "on the declared outside
theorem `Outside.OAI158.proper_to_borel_weak`" (several sentences) become "on the standard three" — Keryx's filing.
The vacuity scan's `declarations=` count rises by the port's; its sites are read by the landing (`LEAN.md` § The gate:
a module whose theorems range over the release's own structures adds sites that read `GENERIC`).
**The density landing (after its join).** No new axiom: the axiom it declared is a theorem of the port;
`residual_fourier_cross` and `exists_field` print the standard three; `scripts/assumptions.sh` sees no new import.

### 4.7 Open risks, each with what would show it

1. **A site of the adaptation class that needs a hypothesis** (a map whose measurability the context does not give):
   the lane stops the module and writes to the coordinator (the ruling's condition).
2. **A Mathlib definition other than `Measure.map` that changed between the pins** and reaches a definition of the
   release (FS133-IA1's level-one comparison found 13 Mathlib signatures differing one level down, `MeasureTheory.Lp`
   among them): a lane's elaboration shows it as a type mismatch in a definition; the generator refuses to patch it;
   the coordinator rules. The pricing dump `data/fs131/ko1/lean/MathlibUses.lean` (every Mathlib constant the 31
   files' stored terms name, with its stored type at the release's pin, for the same print at this pin) was started
   and **had not finished when this stage was saved**; lane A may finish it to list such constants in advance.
3. **The superset assumption of the exposure test**: the variant added the whole 67-module union to each module, a
   superset of what each will import; instance resolution is not monotone in principle. Steps 4.4 (4) and 4.5 (8)
   compare the real modules before and after and decide.
4. **`Representations` and `BorelTransfer`'s shared declarations** (op, space, the 45 others) are not yet compared
   (4.5, step 0, is the check).

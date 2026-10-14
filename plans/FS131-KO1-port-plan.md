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

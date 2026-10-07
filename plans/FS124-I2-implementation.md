# FS-124 — the second module's first two files: the circle geometry and what one piece of one colour forces (job FS124-I2)

*De Bruijn, the implementer. Brief: `data/fs124/briefs/FS124-I2-one-piece.md` (on `main`). Skeleton and plan: the planner's,
`plans/FS124-kernel-plan-2.md` on this branch (`fs124-wk2`, at `92f09e14` when this job began). Files of this job:
`Proofs/HadwigerNelson/Plane/CircleCrossing.lean`, `Proofs/HadwigerNelson/Plane/OnePiece.lean` (proofs only; no statement and
no definition is changed). Working files: `data/fs124/i2/`. The record is written in stages; each is committed before the
next starts.*

## Theorems this phase proved

*(filled at each stage; nothing here is on `main`)*

## Stage 1 — SAVED (FS124-I2): the readback and the build as given

**The brief's quotations against their sources.** `data/fs124/i2/readback.py <brief>` (the planner's script, copied; two
changes, both to how a source address is read: a trailing "Stage n" after a file name is dropped, and a relative source is
looked up in this worktree **and** on the main working tree) takes every quoted block with its `— source:` line and looks
for it, whitespace-normalized, in the file named: **16 of 16 found** (`data/fs124/i2/logs/readback.txt`, exit 0). Control:
`--control` changes the case of one letter in each quotation and must find none of the sixteen — it found none
(`data/fs124/i2/logs/readback-control.txt`, exit 0).

One note on the brief, which changes nothing: the quotation of the inventory's item 34 (`plans/FS124-close-inventory.md
§ Items`) is found on the main working tree only. This branch holds an older copy of that file, without item 34; the
script's first run, which read the branch's copy alone, reported it missing (5,915 of 5,915 characters then matched
against `main`'s copy by hand). The claim list `data/fs124/claims-K2.md` is on `main` only, as the planner's record says.

**Read whole**: the brief; `plans/STANDING-RULES.md`; `LEAN.md`; `RUNNING.md` § Building and § Make the gate fail, and
watch it fail; `data/fs124/claims-K2.md` with its dated line; the planner's record (Stages 1–5); my two files; of what they
import, `Plane/Basic` and `Plane/WeakColouringOn` whole, and of `Plane/Radius`, `Plane/Cover`, `Plane/DensityPoints`,
`Plane/UnitPairs` the declarations my files name (`unitShadow`, `exists_angle_of_norm_eq_one`,
`preconnected_dist_lt_or_gt`, `continuous_e`).

**The build as given**: `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the
worktree, exit 0 — `build: OK — all 1853 modules already up to date, nothing built, 6 module(s) with warnings, 2s`
(`data/fs124/i2/logs/build-0-as-given.log`; the full output copied to `build-0-as-given-full.log`). The full log holds
**130 distinct `declaration uses sorry` warnings and no other warning**: 23 in `Plane/CircleCrossing`, 40 in
`Plane/OnePiece`, 29 in `Plane/ThreePiece`, 32 in `Plane/ClosePair`, 3 in `Plane/ClosePairModel`, 3 in
`Plane/SectorPoint` — the planner's count.

**My leaves, counted from the files**: 23 `sorry` in `Plane/CircleCrossing` (21 named theorems and 2 spec examples) and
40 in `Plane/OnePiece` (36 named theorems and 4 spec examples).

**How I iterate** (never evidence): `lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false
-Dlinter.missingDocs=true <file>` against this worktree's build, about 2 s a run for `Plane/CircleCrossing`. The built
`.olean` of `Plane/CircleCrossing` holds the statements `Plane/OnePiece` reads, and no statement changes, so the second
file elaborates against it as it stands; a helper added to the first file and used in the second needs the first rebuilt
(or the planner's overlay, `build/k2-iter.sh`).

## Stage 2 — SAVED (FS124-I2): `Plane/CircleCrossing` — 23 of 23 leaves proved, in the build

**In the build**: `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`, exit 0 — `build: OK — 477 of
477 batches, 7 module(s) rebuilt, 5 module(s) with warnings, 9m29s` (`data/fs124/i2/logs/build-1-circlecrossing.log`; the
full output, `build-1-circlecrossing-full.log`). The full log holds **107 distinct `declaration uses sorry` warnings** (40
`Plane/OnePiece`, 29 `Plane/ThreePiece`, 32 `Plane/ClosePair`, 3 `Plane/ClosePairModel`, 3 `Plane/SectorPoint`), **none in
`Plane/CircleCrossing`, and no other warning**; its one line holding the word `error` is the build script's up-to-date probe
(line 3, `target is out-of-date and needs to be rebuilt`), as in the as-given log's shape.

**The leaves, each against its planned route** (`plans/FS124-kernel-plan-2.md` § 3.2):

| leaf | route |
|---|---|
| `CircleSide.mem_region_inside` | `Iff.rfl` (the plan: `simp`) |
| `CircleSide.mem_region_outside`, `mem_region_iff`, `disjoint_region_flip`, `mem_region_or_of_dist_ne`, `flip_flip` | as planned |
| `CircleSide.ball_antipode_subset_outside` | as planned (`dist (2 z − q) q = 2`, the triangle inequality) |
| `CrossAt.symm`, `CrossAt.antipode`, `crossAt_of_dist_lt_two`, `CrossAt.abs_inner_lt_one` | as planned; the algebra by `linear_combination` |
| `CrossAt.quadPt_mem_region_left` | as planned, with the sign step as a real-variable lemma of its own, `quadrant_sign_pos` (`LEAN.md` on `nlinarith`): closed by `one_lt_sq_iff₀`, `sq_lt_one_iff₀` and `linarith` — no `nlinarith` |
| `CrossAt.quadPt_mem_region_right`, `dist_quadPt_le`, `CrossAt.exists_mem_quadrant`, `CrossAt.volume_quadrant_pos` | as planned |
| `CrossAt.exists_mem_sphere_region` | as planned; its inside half is the named helper `CrossAt.exists_mem_sphere_inside` |
| `exists_ball_inter_spheres_subset` | as planned, **but for one name**: `Complex.finrank_real_complex` is not in scope under this module's imports (it is in `Mathlib.LinearAlgebra.Complex.FiniteDimensional`). I did not add the import — by `LEAN.md` it changes the instance `volume : Measure ℂ` is elaborated with, hence the stored term of `CrossAt.volume_quadrant_pos` — and wrote `Module.finrank_eq_card_basis Complex.basisOneI` with `Fintype.card_fin` |
| `exists_convex_subset_region`, `exists_dist_ne_of_isOpen` | as planned |
| `crossAt_zero_one_add_I`, the two spec examples | as planned |

**Helpers added** (four, each searched in `Proofs/` of `main` and of every worktree before it was named — no other
module declares the name; for each the statement's shape was looked for first):
- `CircleSide.sign_eq : σ.sign = 1 ∨ σ.sign = -1`, `CircleSide.abs_sign : |σ.sign| = 1` — facts of the skeleton's own
  definition; nothing to find.
- `quadrant_sign_pos` — the sign of `N − 1` from `N² − 1 = 2 ε (1 + s t r) (s + ε)`; its two ends are Mathlib's
  `one_lt_sq_iff₀` and `sq_lt_one_iff₀`, which it uses.
- `CrossAt.exists_mem_sphere_inside` — the inside half of `CrossAt.exists_mem_sphere_region`, which the outside half
  cites at the antipode; the intermediate value is `IsPreconnected.intermediate_value` on a convex set (`LEAN.md`'s line).

**No statement and no definition changed** — checked on the kernel's side, with a control. `data/fs124/i2/lean/StatementDump.lean`
prints every constant stored in the compiled data of my two modules (kind, full name, stored type; for a definition its
stored value). `statements-before.txt` is its output on the build as given (172 constants: 72 and 100);
`statements-after-1.txt` on this stage's build. `data/fs124/i2/statement_diff.py` compares them, and the `example` heads of the
two files as text against the base commit `92f09e141`: **133 named constants compared (types; values of definitions), 9
example heads, no difference; 4 new named constants, the helpers above** (`logs/statement-diff-1.txt`, exit 0). Control
(`--control`): one stored statement, one definition's value and one example's head changed in the second input — 3 of 3
reported (`logs/statement-diff-1-control.txt`). What the check does not see: a docstring or a comment (none was changed;
`git diff` on the file removes 23 lines, each `  sorry`).

**The price, as measured.** 23 leaves; 179 lines added, 23 removed (the 23 `sorry`); one first pass and three further
`lean` runs of about 2 s (the sign of one `linear_combination` coefficient; one `<;>` the linter called unnecessary; one
numeral goal left by `simp` in an example); one build, 9m29s — the walk over 477 batches, as the planner measured.

## Stage 3 — SAVED (FS124-I2): `Plane/OnePiece` — 40 of 40 leaves proved, in the build; the five claims' axioms printed

**In the build**: the same command, exit 0 — `build: OK — 477 of 477 batches, 6 module(s) rebuilt, 4 module(s) with
warnings, 9m29s` (`data/fs124/i2/logs/build-2-onepiece.log`; the full output, `build-2-onepiece-full.log`). The full log
holds **67 distinct `declaration uses sorry` warnings** — 29 `Plane/ThreePiece`, 32 `Plane/ClosePair`, 3
`Plane/ClosePairModel`, 3 `Plane/SectorPoint`: the other implementer's files and the third job's — **none in
`Plane/CircleCrossing` or `Plane/OnePiece`, and no other warning** (its one line with the word `error` is the up-to-date
probe, line 3). **My 63 leaves are all proved; none is left `sorry`.**

**The axioms, printed from that build** (`data/fs124/i2/lean/PrintAxioms.lean`, generated by `data/fs124/i2/make_audit.py`
from the two source files, each `theorem` line resolved against the stored constants; output `data/fs124/i2/axioms.txt`;
read by `data/fs124/i2/read_axioms.py`, `logs/read-axioms.txt`, exit 0): **80 records — every theorem of the two files —
77 on axioms within `[propext, Classical.choice, Quot.sound]` and 3 axiom-free; no other axiom; 83 asked, 83 printed.**
The five claims' lines:

```
'HadwigerNelson.Plane.shadow_open' depends on axioms: [propext, Classical.choice, Quot.sound]
'HadwigerNelson.Plane.piece_type' depends on axioms: [propext, Classical.choice, Quot.sound]
'HadwigerNelson.Plane.centre_half' depends on axioms: [propext, Classical.choice, Quot.sound]
'HadwigerNelson.Plane.tight_centre' depends on axioms: [propext, Classical.choice, Quot.sound]
'HadwigerNelson.Plane.tight_straddle' depends on axioms: [propext, Classical.choice, Quot.sound]
```

**The control fired, three ways**: a theorem planted in the scratch file on `sorry` (`FS124I2.control_planted`), a theorem
planted there that cites it (`FS124I2.control_cites`), and a theorem of the other implementer's file that this branch
still holds as a skeleton (`HadwigerNelson.Plane.closePair_forced_pieces`) — each prints `sorryAx`, and the reader fails
if one does not. **No theorem of my two files rests on a `sorry`, mine or the other implementer's**: my files are upstream
of theirs and cite none of their leaves.

**The leaves, each against its planned route** (§ 3.2 of the plan):

| leaf | route |
|---|---|
| `unitShadow_mono`, `mem_unitShadow_iff_exists_e`, `eq_empty_of_isOpen_of_ae` | as planned (`measure_eq_zero_iff_ae_notMem` is the pin's name for "null iff almost every point is off it") |
| `not_innerAt_iff`, `not_outerAt_iff`, `crossingAt_iff`, `innerAt_or_outerAt_or_crossingAt` | as planned |
| `OnSide.subset_region`, `onSide_of_subset_region`, `not_innerAt_and_outerAt`, `InnerAt.closure_inter_closure_subset` | as planned |
| `IsPieceAt.nonempty`, `.isConnected`, `.disjoint`, `.inter_eq_empty`, `.ae_unitShadow_ne` | as planned |
| `IsPieceAt.ae_ne_of_crossingAt`, `IsPieceAt.innerAt_self` | as planned |
| `piece_type` (**C124-TYPE**) | as planned: `IsPieceAt.ae_ne_region` at the outside (from `not_outerAt_iff`) and at the inside (from `not_innerAt_iff`) |
| `AeProperOn.ae_ne_of_ae_region`, `centre_half` (**C124-CENTRE-HALF**) | as planned: the tangent disc of `exists_convex_subset_region` is a piece at `z`, not on the other closed side; its type at `w := q` |
| `IsTightWith.mem`, `.mono`, `isOpen_innerCollar`, `isOpen_outerCollar`, `.ae_innerCollar`, `.ae_outerCollar`, `isTight_of_ae_of_isOpen` | as planned |
| `IsTight.ae_ne_centre`, `tight_centre` (**C124-CENTRE**) | as planned: the two sides, the least radius |
| `IsTight.ae_ne_straddle`, `tight_straddle` (**C124-STRADDLE**) | as planned: `CrossAt p q z`, a point of `S(p)` in each collar, the two shadows open |
| `isOpen_tightModelDom`, `measurable_tightModel`, `isWeakColouringOn_tightModel`, `isTight_tightModel` | as planned; the nine pairs of discs through five small facts about the model (below) |
| the four spec examples | as planned |

No planned route failed in either file; nothing was dispatched to a companion. (`debruijn-meta` was loaded once, for
the read-only dump of the stored constants.)

**Helpers added** (five, about the model only; each name searched in `Proofs/` of `main` and of every worktree):
`tightModel_of_not_lt`, `tightModel_ne_two_of_lt` (the definition's two branches), `tightModel_far` (`6/5 < dist (1 + i)
0`, from `‖1 + i‖² = 2`), `tightModel_eq_two_of_mem`, `tightModel_ne_two_of_mem` (the label on the three discs).

**Two spec examples added, not in the skeleton** (said here because they are new text in a statement file; they change
no statement). The docstrings of `piece_type` and `centre_half` each name an inhabitant of their hypotheses in the model,
and no declaration of the skeleton ran either theorem on it (`LEAN.md`: "'inhabitant of the hypotheses' is a claim and
is checked like one"). The two examples do: `piece_type` on `tightModel` with `P` the inner collar of the tight pair
`(0, 1)`, `x = 1`, `w = 0`, `i = 0` (its first clause, through the point `19/20`); `centre_half` with `q = 0`, `z = 1`,
`ρ = 1/10`, at `a = 0` (first clause) and `a = 1` (second clause). So every one of the five claims' theorems is now run
on the model by a declaration of the file. The landing may drop them without touching anything else.

**No statement and no definition changed**: `statements-after-2.txt` against `statements-before.txt` and the base commit —
**133 named constants compared, 9 example heads of the base all present in order, no difference; 9 new named constants
(the helpers of both files) and 2 new examples** (`logs/statement-diff-2.txt`, exit 0); control, 3 of 3 planted faults
reported (`logs/statement-diff-2-control.txt`). `git diff` on the file removes 40 lines, each `  sorry`. The five claims'
theorems as the kernel holds them, every binder: `data/fs124/i2/claim-sigs.txt` (`#check`, from the build).

**Unused hypotheses**: none found in a leaf of mine beyond what the planner's § 2.3 already records (`a ≠ b` in a tight
pair is a field no proof reads, its G8; `IsConnected P` in `piece_type` is read as preconnected, its G3). The build
prints no `unused variable` warning for either file.

**`tools/check_architecture.py`**: exit 0, `RESULT: PASS` (`logs/check-architecture.txt`).

**The price, as measured.** 40 leaves; 270 lines added, 40 removed (the 40 `sorry`); written in one pass in a scratch
copy while the first file's build ran, then two `lean` runs to green (one implicit argument, `c`, that
`eq_empty_of_isOpen_of_ae` cannot infer from an expected type alone — two call sites), two more for line lengths and the
added examples; one build, 9m29s. **Both files: 63 leaves, 449 lines added, 3 builds (one as given), 0 leaves left, 0
routes failed.** The planner priced the two files at about 380 lines; they came in at 449 with nine helpers and two
added examples.

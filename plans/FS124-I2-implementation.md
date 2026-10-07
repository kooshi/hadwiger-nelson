# FS-124 — the second module's first two files: the circle geometry and what one piece of one colour forces (job FS124-I2)

*De Bruijn, the implementer. Brief: `data/fs124/briefs/FS124-I2-one-piece.md` (on `main`). Skeleton and plan: the planner's,
`plans/FS124-kernel-plan-2.md` on this branch (`fs124-wk2`, at `92f09e14` when this job began). Files of this job:
`Proofs/HadwigerNelson/Plane/CircleCrossing.lean`, `Proofs/HadwigerNelson/Plane/OnePiece.lean` (proofs only; no statement and
no definition is changed). Working files: `data/fs124/i2/`. The record is written in stages; each is committed before the
next starts.*

## Theorems this phase proved

On branch `fs124-wk2` only: **kernel-checked on a branch, not through the gate** — nothing here is on `main`, and the
branch's other four modules of the skeleton still hold 67 `sorry`. Axioms as printed from the build of Stage 3
(`data/fs124/i2/axioms.txt`; the control fired).

**The claims' theorems** (`Proofs/HadwigerNelson/Plane/OnePiece.lean`), each read against `data/fs124/claims-K2.md` in
Stage 4:
- **C124-TYPE** — `HadwigerNelson.Plane.piece_type` — `[propext, Classical.choice, Quot.sound]`. Proved in this phase,
  over the planner's core `IsPieceAt.ae_ne_region`.
- **C124-CENTRE-HALF** — `HadwigerNelson.Plane.centre_half` — `[propext, Classical.choice, Quot.sound]`. This phase;
  core `AeProperOn.ae_ne_of_ae_region`.
- **C124-CENTRE** — `HadwigerNelson.Plane.tight_centre` — `[propext, Classical.choice, Quot.sound]`. This phase; core
  `IsTight.ae_ne_centre`.
- **C124-STRADDLE** — `HadwigerNelson.Plane.tight_straddle` — `[propext, Classical.choice, Quot.sound]`. This phase;
  core `IsTight.ae_ne_straddle`.
- **C124-SHADOW-OPEN** — `HadwigerNelson.Plane.shadow_open` — `[propext, Classical.choice, Quot.sound]`. **Proved by the
  planner (FS124-K2), not by this phase**; printed here from the same build, with this phase's spec example on the model.

No one of the five takes an assumption: no declared outside theorem, no hypothesis standing for a hand result. Each
is for a weak `k`-colouring; its core under it is for any function proper at almost every unit pair, at any label type.

**Every theorem this phase proved** — 66: 57 leaves of the skeleton and 9 helpers; with them 6 spec examples of the
skeleton and 2 added ones (anonymous, so not records). The other 14 theorems of the two files are the planner's.

**`Plane/CircleCrossing`** — 25 theorems of this phase (4 of them helpers, marked †), each [kernel] on a branch:
- on `[propext, Classical.choice, Quot.sound]` (24): `CircleSide.mem_region_inside`, `CircleSide.mem_region_outside`, `CircleSide.mem_region_iff`, `CircleSide.disjoint_region_flip`, `CircleSide.mem_region_or_of_dist_ne`, `CircleSide.ball_antipode_subset_outside`, `CrossAt.symm`, `CrossAt.antipode`, `crossAt_of_dist_lt_two`, `CrossAt.abs_inner_lt_one`, `CircleSide.sign_eq`†, `CircleSide.abs_sign`†, `quadrant_sign_pos`†, `CrossAt.quadPt_mem_region_left`, `CrossAt.quadPt_mem_region_right`, `dist_quadPt_le`, `CrossAt.exists_mem_quadrant`, `CrossAt.volume_quadrant_pos`, `CrossAt.exists_mem_sphere_inside`†, `CrossAt.exists_mem_sphere_region`, `exists_ball_inter_spheres_subset`, `exists_convex_subset_region`, `exists_dist_ne_of_isOpen`, `crossAt_zero_one_add_I`.
- on no axiom (1): `CircleSide.flip_flip`.
**`Plane/OnePiece`** — 41 theorems of this phase (5 of them helpers, marked †), each [kernel] on a branch:
- on `[propext, Classical.choice, Quot.sound]` (41): `unitShadow_mono`, `mem_unitShadow_iff_exists_e`, `eq_empty_of_isOpen_of_ae`, `not_innerAt_iff`, `not_outerAt_iff`, `crossingAt_iff`, `OnSide.subset_region`, `onSide_of_subset_region`, `not_innerAt_and_outerAt`, `innerAt_or_outerAt_or_crossingAt`, `InnerAt.closure_inter_closure_subset`, `IsPieceAt.nonempty`, `IsPieceAt.isConnected`, `IsPieceAt.disjoint`, `IsPieceAt.inter_eq_empty`, `IsPieceAt.ae_unitShadow_ne`, `IsPieceAt.ae_ne_of_crossingAt`, `IsPieceAt.innerAt_self`, `piece_type`, `AeProperOn.ae_ne_of_ae_region`, `centre_half`, `IsTightWith.mem`, `IsTightWith.mono`, `isOpen_innerCollar`, `isOpen_outerCollar`, `IsTightWith.ae_innerCollar`, `IsTightWith.ae_outerCollar`, `isTight_of_ae_of_isOpen`, `IsTight.ae_ne_centre`, `tight_centre`, `IsTight.ae_ne_straddle`, `tight_straddle`, `tightModel_of_not_lt`†, `tightModel_ne_two_of_lt`†, `tightModel_far`†, `tightModel_eq_two_of_mem`†, `tightModel_ne_two_of_mem`†, `isOpen_tightModelDom`, `measurable_tightModel`, `isWeakColouringOn_tightModel`, `isTight_tightModel`.

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

## Stage 4 — SAVED (FS124-I2): names and linters on the built tree; the five claims' theorems read aloud; the drafts

### 4.1 Names, linters, architecture — on the tree of Stage 3's build

- **`./scripts/dupnames.sh`** under the slot: exit 0 — `dupnames: OK — no name is declared by two modules (23 generated
  on demand, listed above)`; `scanned 7465 modules, 1853 of them the package's (1853 source files)`
  (`data/fs124/i2/logs/dupnames.txt`). None of the 23 generated names is of my two modules. **`--self-test`**: exit 0, `all
  15 controls behaved: every planted fault fired, and every partner passed` (`logs/dupnames-selftest.txt`). **This is the
  scan of this branch alone**: the join of the two implementers' branches makes the tree on which a doubled name could
  first exist, and runs it again (`LEAN.md` § The gate). My nine helper names were searched in `Proofs/` of `main` and of
  every worktree, the other implementer's among them, when each was named and again at 17:06 UTC (its branch then still
  at the planner's tip): no other declaration.
- **The environment linters**, run once as a probe (not the gate): `lake lint --no-build -- --no-build --trace` under the
  slot, exit 0, `-- Linting passed for Proofs.`, 14 linters and 14 `(2/2) Passed!` (`logs/lint.txt`) — `unusedArguments`,
  `simpNF` and `docBlame` among them, on the whole library as this branch builds it.
- **`tools/check_architecture.py`**: exit 0, `RESULT: PASS` (Stage 3).
- **Not run, by the brief**: the full gate (`scripts/axioms.sh`, `scripts/assumptions.sh`, `scripts/vacuity.sh`), which
  reads `scripts/Axioms.lean` — the joining job's file.

### 4.2 Read aloud: each claim's theorem against the claim list's words, and against its *not claimed* line

Three readings hold for all five and are said once.
1. **The class.** The list's weak `k`-colouring is "a measurable map `c` from `U` to `k` labels"; the theorems take the
   first module's `IsWeakColouringOn U c` — a total `c : ℂ → Fin k`, measurable, proper at almost every unit pair of `U`
   (`volume ⊗ arcLength`-null monochromatic pairs inside `U`), read on `U` alone. That is the reading the first module
   fixed and its landing carries; nothing here adds to it. A map given on `U` only is extended by a constant: every
   hypothesis below reads `c` at points of `U`, and every conclusion is about almost every point of a disc `ball w η`
   whose centre is in the open set `U` and is monotone in `η`, so the radius may be taken with the disc inside `U` (the
   proofs take it so). That step from a map on `U` to a total map is not a theorem of these files.
2. **"Almost every"** is `∀ᵐ z` for plane Lebesgue measure `volume` on `ℂ`; `|a − b|` is `dist a b`; `B(p, r)` is
   `ball p r`; `S(p)` is the unit circle about `p`.
3. **As the kernel holds them**: `data/fs124/i2/claim-sigs.txt` is `#check` on the five from the build — the binders
   below are the stored ones, and `k`, `U`, `c` are implicit in each.

**C124-SHADOW-OPEN** — `shadow_open` (the planner's proof; read here because the brief names it among the five).

> Let U be an open set of the plane, c a measurable map from U to a finite set of labels with c(z) ≠ c(z + u) for almost every pair of a point z of U and a unit vector u with z + u in U, i a label, and W an open subset of U almost every point of which has the label i. Then the set of points of U at distance exactly 1 from some point of W is open, and almost every point of it has a label other than i.
> — source: data/fs124/claims-K2.md

"Let U be an open set of the plane" — `hU : IsOpen U`. "c a measurable map from U to a finite set of labels with c(z) ≠
c(z + u) for almost every pair of a point z of U and a unit vector u with z + u in U" — `hc : IsWeakColouringOn U c`, the
finite set being `Fin k` (reading 1). "i a label" — `i : Fin k`. "W an open subset of U" — `hW : IsOpen W`, `hWU : W ⊆ U`.
"almost every point of which has the label i" — `hi : ∀ᵐ z, z ∈ W → c z = i`. "Then the set of points of U at distance
exactly 1 from some point of W" — `U ∩ unitShadow W`, with `unitShadow W = {z | ∃ y ∈ W, dist z y = 1}` (`Plane/Cover`) —
"is open" — `IsOpen (U ∩ unitShadow W)` — "and almost every point of it has a label other than i" — `∀ᵐ z, z ∈ U ∩
unitShadow W → c z ≠ i`. Every clause has its conjunct; no hypothesis is added.

> anything for a set W that is not open; anything at a point whose unit circle meets only the boundary of W; that any weak colouring has an open one-label set
> — source: data/fs124/claims-K2.md

A set that is not open: `hW` is a hypothesis, of the core lemma too. A point whose unit circle meets only the boundary
of `W`: the conclusion is on the shadow of `W` itself, not of its closure. That a weak colouring has an open one-label
set: `W` and `hi` are hypotheses. The theorem claims none of the three.

**C124-TYPE** — `piece_type`.

> Let c be a weak k-colouring of an open set U, P a connected open subset of U almost every point of which has the label i, x a point of the closure of P, and w a point of U with |w − x| = 1. If P has a point strictly inside S(w), there is η > 0 such that almost every point z of B(w, η) with |z − x| > 1 has a label other than i; if P has a point strictly outside S(w), there is η > 0 such that almost every point z of B(w, η) with |z − x| < 1 has a label other than i.
> — source: data/fs124/claims-K2.md

"Let c be a weak k-colouring of an open set U" — `hU`, `hc`. "P a connected open subset of U" — `hPo : IsOpen P`, `hPc :
IsConnected P`, `hPU : P ⊆ U`. "almost every point of which has the label i" — `hi : ∀ᵐ z, z ∈ P → c z = i`. "x a point
of the closure of P" — `hx : x ∈ closure P`. "w a point of U" — `hw : w ∈ U`. **"with |w − x| = 1" — not a hypothesis of
the theorem**: it is stated at every `w ∈ U`, and the claim is its case `dist w x = 1`. The statement is the planner's
(its G3, in the list's dated line of 16:33 UTC); the proof never reads the distance, and the kernel has checked the wide
form. "If P has a point strictly inside S(w)" — `∃ y ∈ P, dist y w < 1` — "there is η > 0 such that almost every point z
of B(w, η) with |z − x| > 1 has a label other than i" — `∃ η > 0, ∀ᵐ z, z ∈ ball w η → 1 < dist z x → c z ≠ i`. "if P
has a point strictly outside S(w)" — `∃ y ∈ P, 1 < dist y w` — "there is η > 0 such that almost every point z of B(w, η)
with |z − x| < 1 has a label other than i" — `∃ η > 0, ∀ᵐ z, z ∈ ball w η → dist z x < 1 → c z ≠ i`. The two clauses are
the two conjuncts, each an implication with its own `η`.

> anything for a piece that is not connected or not open; a uniform η over pieces or over the point of P chosen; anything on the side not named; that any weak colouring has such a piece
> — source: data/fs124/claims-K2.md

Not connected or not open: both are hypotheses (the proof reads connected as preconnected, the planner's G3; the
hypothesis stays `IsConnected`). A uniform `η`: each clause has its own `∃ η`, after `P` and the two points are fixed.
The side not named: each clause concludes on one side of `S(x)` only. Existence of a piece: `P` is a hypothesis.

**C124-CENTRE-HALF** — `centre_half`.

> Let c be a weak k-colouring of an open set U, q and z points of U with |q − z| = 1, ρ > 0 with B(z, ρ) ⊂ U, and a a label. If almost every point of B(z, ρ) with distance less than 1 from q has the label a, there is η > 0 such that almost every point p of B(q, η) with |p − z| > 1 has a label other than a; if almost every point of B(z, ρ) with distance more than 1 from q has the label a, there is η > 0 such that almost every point p of B(q, η) with |p − z| < 1 has a label other than a.
> — source: data/fs124/claims-K2.md

"Let c be a weak k-colouring of an open set U" — `hU`, `hc`. "q and z points of U" — `hq : q ∈ U`; `z ∈ U` is not a
binder: it follows from `hρ` and `hball` (the centre of a disc inside `U`). "with |q − z| = 1" — `hqz : dist q z = 1`.
"ρ > 0 with B(z, ρ) ⊂ U" — `hρ : 0 < ρ`, `hball : ball z ρ ⊆ U`. "a a label" — `(a : Fin k)`, explicit. "If almost every
point of B(z, ρ) with distance less than 1 from q has the label a" — `∀ᵐ w, w ∈ ball z ρ → dist w q < 1 → c w = a` —
"there is η > 0 such that almost every point p of B(q, η) with |p − z| > 1 has a label other than a" — `∃ η > 0, ∀ᵐ p,
p ∈ ball q η → 1 < dist p z → c p ≠ a`. "if almost every point of B(z, ρ) with distance more than 1 from q has the label
a" — `∀ᵐ w, w ∈ ball z ρ → 1 < dist w q → c w = a` — "there is η > 0 such that almost every point p of B(q, η) with
|p − z| < 1 has a label other than a" — `∃ η > 0, ∀ᵐ p, p ∈ ball q η → dist p z < 1 → c p ≠ a`. Two conjuncts, one per
collar; no hypothesis is added.

> anything about the other collar; that (q, z) is tight
> — source: data/fs124/claims-K2.md

The other collar: each implication's hypothesis reads one collar, and its conclusion one side of `S(z)`. Tightness: no
clause asks or concludes it.

**C124-CENTRE** — `tight_centre`.

> Let c be a weak k-colouring of an open set U, q and z points of U with |q − z| = 1, and (q, z) tight for (a, b). Then there is η > 0 such that almost every point w of B(q, η) with |w − z| > 1 has a label other than a, and almost every point w of B(q, η) with |w − z| < 1 has a label other than b.
> — source: data/fs124/claims-K2.md

"Let c be a weak k-colouring of an open set U" — `hU`, `hc`. "q and z points of U" — `hq : q ∈ U`; `z ∈ U` is carried by
`ht` (`IsTightWith.mem`: the far end is the centre of a disc inside `U`). "with |q − z| = 1" — the field `dist_eq : dist q
z = 1` of `ht`. "(q, z) tight for (a, b)" — `ht : IsTight U c q z a b`, which is `∃ ρ, IsTightWith U c q z a b ρ`; read
against the list's object ("there is ρ > 0 with B(z, ρ) ⊂ U such that almost every point w of B(z, ρ) with |w − q| < 1
has the label a and almost every point w of B(z, ρ) with |w − q| > 1 has the label b", with "a ≠ b two labels") the
fields are `ne : a ≠ b`, `pos : 0 < ρ`, `ball_subset : ball z ρ ⊆ U`, `ae_inside : ∀ᵐ w, w ∈ ball z ρ → dist w q < 1 → c
w = a`, `ae_outside : ∀ᵐ w, w ∈ ball z ρ → 1 < dist w q → c w = b`. "Then there is η > 0 such that almost every point w
of B(q, η) with |w − z| > 1 has a label other than a, and almost every point w of B(q, η) with |w − z| < 1 has a label
other than b" — `∃ η > 0, (∀ᵐ w, w ∈ ball q η → 1 < dist w z → c w ≠ a) ∧ (∀ᵐ w, w ∈ ball q η → dist w z < 1 → c w ≠
b)`: one `η` for both, as the claim says.

> that a or b is present at q (C124-KIND: neither need be); anything about the other labels near q; that this is all a tight pair forces at q — with a second tight far end z′ for the same (a, b) the conclusions intersect, and near q the label a is confined to B̄(z, 1) ∩ B̄(z′, 1), a region with angle π − ∠zqz′ at q
> — source: data/fs124/claims-K2.md

Presence of `a` or `b` at `q`: the conclusion only excludes labels. Other labels near `q`: only `a` and `b` are named.
That this is all a tight pair forces: nothing of the kind is stated.

**C124-STRADDLE** — `tight_straddle`.

> Let c be a weak k-colouring of U, (q, z) tight for (a, b), and p a point of U with |p − z| = 1, p ≠ q and p ≠ 2z − q. Then there is η > 0 such that almost every point of B(p, η) has a label other than a and other than b.
> — source: data/fs124/claims-K2.md

"Let c be a weak k-colouring of U" — `hU : IsOpen U` (the class is of open sets) and `hc`. "(q, z) tight for (a, b)" —
`ht : IsTight U c q z a b`. "p a point of U" — `hp : p ∈ U`. "with |p − z| = 1" — `hpz : dist p z = 1`. "p ≠ q" — `hpq`.
"p ≠ 2z − q" — `hanti : p ≠ 2 * z - q`. "Then there is η > 0 such that almost every point of B(p, η) has a label other
than a and other than b" — `∃ η > 0, ∀ᵐ w, w ∈ ball p η → c w ≠ a ∧ c w ≠ b`. Every clause has its binder or conjunct;
no hypothesis is added.

> a uniform η as p tends to q or to 2z − q (it tends to 0); anything at those two points (C124-CENTRE, C124-ANTIPODE); anything that reads the radius of the interface — for an interface of any shape the statement at a point whose unit circle crosses it is C132-WITNESS's
> — source: data/fs124/claims-K2.md

A uniform `η`: the `∃ η` comes after `p`. The two points `q` and `2z − q`: excluded by `hpq` and `hanti`. The radius of
the interface: the statement is about a tight pair, whose interface is the unit circle about `q`.

**What the read-aloud found.** No clause of the five is missing, none is added, and no theorem claims an item of its
*not claimed* line. One theorem is wider than its claim, as the list's dated line already says: `piece_type` has no
hypothesis `|w − x| = 1`. Each docstring's named inhabitant is now run by a declaration of the file (Stage 3).

### 4.3 Drafts for the landing (the joining job's files; none is written by this job)

- **`scripts/Axioms.lean`, CLEAN section, after the block `-- FS124-I1 block end`**: the file
  `data/fs124/i2/audit-block.txt`, whole — a header, `-- FS124-I2: Plane/CircleCrossing` with 31 `#print axioms` lines,
  `-- FS124-I2: Plane/OnePiece` with 49, `-- FS124-I2 block end`. **80 records, each expected CLEAN** (77 on a subset of
  the standard three that is not empty, 3 on no axiom: `CircleSide.flip_inside`, `CircleSide.flip_outside`,
  `CircleSide.flip_flip`). It is generated from the two files' `theorem` lines and regenerates if a file changes
  (`data/fs124/i2/make_audit.py <a dump of the stored constants>`).
- **`scripts/Assumptions.lean`**: no entry. No theorem of the two modules takes a hypothesis standing for an outside
  theorem, a hand result or an open question; `IsTight`, `IsPieceAt`, `CrossAt` are conditions on a theorem's own
  parameters, each with its model.
- **Vacuity, for the landing's note on models** (`LEAN.md`: the scan is silent on colourings under a predicate it does
  not track): the structures of hypotheses and their inhabitants, all in the kernel on this branch — `IsWeakColouringOn
  U c` with `IsTight U c q z a b`: `isWeakColouringOn_tightModel`, `isTight_tightModel` (three labels on three discs;
  the pair `(0, 1)` tight for `(0, 1)`); `CrossAt p q z`: `crossAt_zero_one_add_I`; `IsPieceAt` and the hypotheses of
  `piece_type`: the added example (the inner collar, `x = 1`, `w = 0`). The five claims' theorems are each run on the
  model by an `example` of `Plane/OnePiece`.
- **`Proofs.lean`, `ARCHITECTURE.md`**: not touched; the planner registered the modules, and its rows say "a skeleton
  on branch `fs124-wk2`" — the landing rewrites them.
- **`LEAN.md` § Searching — Lean**, three lines:
  - "`Complex.finrank_real_complex` is in `Mathlib.LinearAlgebra.Complex.FiniteDimensional`, which `Plane/Basic` does not
    import; without it `finrank ℝ ℂ = 2` is `Module.finrank_eq_card_basis Complex.basisOneI` with `Fintype.card_fin`. In
    a module whose statements name `volume : Measure ℂ` the import is not a free edit: it changes the instance the
    statement stores (the line above on imports) (FS124-I2)."
  - "An implementer shows it changed no statement from the kernel's side: print every constant of its modules' compiled
    data (kind, name, stored type, a definition's value) from the build as given — **before the first rebuild replaces
    the `.olean`s** — print again after, and compare, with a planted difference that must be reported; an `example` is not
    stored, so its head is compared as text against the base commit (`data/fs124/i2/lean/StatementDump.lean`,
    `data/fs124/i2/statement_diff.py`) (FS124-I2)."
  - "At the pin 'null exactly when almost every point is off it' is `measure_eq_zero_iff_ae_notMem` (FS124-I2)."

## Drafts for the front page

*Each names its slot. None is filed by this job; the landing's own gate run supplies the counts.*

- **`CLAUDE.md` § The gate and § Trust ledger — the counts**: not measured here (the brief: no full gate; the audit
  script is the joining job's). What this job fixes for them: **80 records to add under CLEAN** for `Plane/CircleCrossing`
  (31) and `Plane/OnePiece` (49), none IMPORTED, none PURCHASED; no declared hypothesis, so the assumptions step's nine
  counts do not move for these two modules; the vacuity scan's site count is the landing's to read.
- **`LEDGER.md` row 162, its `**Grade:**` sentence** — replacing "[hand] or derived from [hand] entries, one mind each,
  kernel pending; C124-SHADOW-OPEN, C124-TYPE, C124-CENTRE-HALF, C124-CENTRE and C124-STRADDLE are in the kernel lane's
  second module, being planned." — at the landing: "C124-SHADOW-OPEN, C124-TYPE, C124-CENTRE-HALF, C124-CENTRE and
  C124-STRADDLE **[kernel]**: `HadwigerNelson.Plane.shadow_open`, `piece_type`, `centre_half`, `tight_centre`,
  `tight_straddle` (`Proofs/HadwigerNelson/Plane/OnePiece.lean`), each on `[propext, Classical.choice, Quot.sound]` and
  resting on no assumption — no declared outside theorem, no hypothesis standing for a hand result; each holds for any
  function proper at almost every unit pair of `U`, at any label type (`AeProperOn.ae_unitShadow_ne`,
  `IsPieceAt.ae_ne_region`, `AeProperOn.ae_ne_of_ae_region`, `IsTight.ae_ne_centre`, `IsTight.ae_ne_straddle`), and
  C124-TYPE at every `w ∈ U`, with no hypothesis `|w − x| = 1`. The row's other entries: [hand] or derived from [hand]
  entries, one mind each, kernel pending." **Until the landing** the five are "kernel-checked on branch `fs124-wk2`
  (`bc5bb0da2`), not through the gate".
- **`CLAUDE.md` § Frontier, the sentence on FS-124's second module** ("its second is being planned") — once this branch
  is joined: "of its second, the circle geometry and the first five claims are proved on branch `fs124-wk2` (80
  theorems; kernel-checked on a branch, not through the gate)".
- **Proof Atlas**: row 162's five statements named above change grade [hand] → [kernel] at the landing, not before; no
  other grade moves by this job.

## Stage 5 — SAVED (FS124-I2): the tree as committed, and the hand-back

**The build as committed** (`169c8511f`): the same command, exit 0 — `build: OK — all 1853 modules already up to date,
nothing built, 4 module(s) with warnings, 2s` (`data/fs124/i2/logs/build-3-as-committed.log`): the four modules with
warnings are the other four of the skeleton. The build of Stage 3 is the build of the committed files.

**The price of the job, as measured.** 63 leaves of 63 (57 named theorems, 6 spec examples), 9 helpers, 2 added
examples; 449 lines added to the two files, 63 removed (each `  sorry`); two builds that compiled (9m29s each: the walk
over 477 batches, six or seven modules to compile at 2 to 3 s each) and two that found nothing to build; about ten `lean`
runs of 2 s. **Wall clock: 16:38 to 17:10 UTC, 32 minutes, 19 of them the two walks.** No leaf took a second route; no
leaf is left `sorry`; no statement came back through the coordinator. What made it short is the plan: every leaf had its
route and its Mathlib names, and the two leaves that carry the mathematics were proved when I began.

**Left for others, by name.** Nothing of my two files. On the branch: `Plane/ThreePiece` (29) and `Plane/ClosePair` (32)
are the other implementer's; `Plane/ClosePairModel` (3) and `Plane/SectorPoint` (3) the third job's and the θ-lemma's.

**The report**: `data/fs124/reports/FS124-I2.md`.

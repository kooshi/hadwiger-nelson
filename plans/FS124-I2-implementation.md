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

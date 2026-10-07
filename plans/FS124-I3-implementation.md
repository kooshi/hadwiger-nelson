# FS-124 — the second module's last two files: three-piece points, and a close complementary pair at a common unit point (job FS124-I3)

*De Bruijn, the implementer. Brief: `data/fs124/briefs/FS124-I3-close-pair.md` (on `main`). Skeleton and plan: the planner's,
`plans/FS124-kernel-plan-2.md` on this branch (`fs124-wi3`, at `ab669747` when this job began: the planner's tip
fast-forwarded to the first implementer's hand-back). Files of this job: `Proofs/HadwigerNelson/Plane/ThreePiece.lean`,
`Proofs/HadwigerNelson/Plane/ClosePair.lean` (proofs only; no statement and no definition is changed). Working files:
`data/fs124/i3/`. The record is written in stages; each is committed before the next starts.*

## Theorems this phase proved

On branch `fs124-wi3` only: **kernel-checked on a branch, not through the gate** — nothing here is on `main`, and the
branch's last two modules of the skeleton (`Plane/ClosePairModel`, `Plane/SectorPoint`: the third job's and the θ-lemma's)
still hold 6 `sorry`. Axioms as printed from the build of Stage 3 (`data/fs124/i3/axioms.txt`; the control fired four
ways). Every record with its kind and its axioms, one line each: `data/fs124/i3/theorems-proved.txt`.

**The claims' theorems** (`Proofs/HadwigerNelson/Plane/ClosePair.lean`), each read against `data/fs124/claims-K2.md` in
Stage 3:
- **C124-FORCED-PIECES** — `HadwigerNelson.Plane.closePair_forced_pieces` — `[propext, Classical.choice, Quot.sound]`.
  Core, at any label type from the hypothesis "every label is the label of a piece of `x` or of `y`":
  `ClosePair.separatesAt_or`, over `exists_inner_outer_of_cover` and the quadrant lemma `exists_onSide_of_cover`.
- **C124-LONE** — `HadwigerNelson.Plane.closePair_lone` — `[propext, Classical.choice, Quot.sound]`. Core
  `ClosePair.lone_of_cover`.
- **C124-BOTH, first clause** — `HadwigerNelson.Plane.closePair_both_separate` — `[propext, Classical.choice,
  Quot.sound]`. Core `ClosePair.separatesAt_right_of_isFull` (a full member makes the other member separate).
- **C124-BOTH, second clause, for arc-edged decompositions** — `HadwigerNelson.Plane.closePair_both_saved` —
  `[propext, Classical.choice, Quot.sound]`. **Not the clause in the list's words**: for the list's sector points it is
  `closePair_both_saved_of_isSector` (`Plane/SectorPoint`), which rests on the unproved θ-curve leaf
  `ThreePiece.IsSector.hasArcEdges` and prints `sorryAx`.
- **C124-FOUR** — `HadwigerNelson.Plane.closePair_four` — `[propext, Classical.choice, Quot.sound]`. Core
  `ClosePair.presentAt_eq`, `ClosePair.ncard_inner_outer`.

No one of the five takes an assumption: no declared outside theorem, no hypothesis standing for a hand result. **No
inhabitant of their hypotheses is in the kernel yet**: the two models their docstrings name are `sorry` in
`Plane/ClosePairModel` (Stage 3, the read-aloud).

**Every theorem this phase proved** — 87, and the proof fields of two definitions: 52 leaves of the skeleton that are
theorems, 35 helpers (marked †), the nine fields each of `sectorPoint` and `petalPoint`; with them 7 spec examples of the
skeleton and 1 added one (anonymous, so not records). The other two records of the two files are the planner's proofs:
`sectorPoint_isFull` (a term over `sectorPoint_hasArcEdges`, on `sorry` until Stage 3) and the definition
`ClosePair.symm`.

**`Plane/ThreePiece`** — 56 theorems of this phase (33 of them helpers) and 2 definitions, each [kernel] on a branch:
- on `[propext, Classical.choice, Quot.sound]` (55 theorems, 2 definitions): `HasUnitArcFrom.mem`, `HasUnitArcFrom.mem_closure_diff`, `ThreePiece.isPieceAt`, `ThreePiece.mem`, `ThreePiece.isConnected_piece`, `ThreePiece.disjoint_piece`, `ThreePiece.ae_mem_piece`, `ThreePiece.ae_label_of_forall_onSide`, `ThreePiece.mem_edge`, `ThreePiece.edge_comm`, `ThreePiece.edge_subset_sphere`, `ThreePiece.not_separatesAt_iff`, `ThreePiece.OneOfEach.eq_of_innerAt`, `ThreePiece.OneOfEach.eq_of_outerAt`, `ThreePiece.OneOfEach.separatesAt`, `ThreePiece.HasArcEdges.isFull`, `ThreePiece.hasUnitArcFrom_of_arc_subset_sphere`, `measurable_sectorCol`, `isWeakColouringOn_ball_quarter`, `sectorPoint_hasArcEdges`, `measurable_petalCol`, `petalPoint_edge`, `petalPoint_not_isFull`; the definitions `sectorPoint`, `petalPoint` (their nine proof fields each); `mem_closure_of_forall_add_ofReal_mul_mem`†, `mem_closure_inter_ball`†, `mem_ball_zero_of_abs_re_add_abs_im_lt`†, `mem_ball_zero_of_sq_lt`†, `ofReal_mul_mem_ball_quarter`†, `volume_setOf_re_im_eq`†, `combo_lt`†, `exists_arc_of_ray_subset`†, `mem_sectorSet_zero`†, `mem_sectorSet_one`†, `mem_sectorSet_two`†, `isOpen_sectorSet`†, `convex_sectorSet`†, `sectorCol_of_mem`†, `mem_closure_sectorSet_zero`†, `mem_closure_sectorSet_one`†, `mem_closure_sectorSet_two`†, `zero_mem_closure_sectorSet`†, `volume_ball_diff_iUnion_sectorSet`†, `mem_sectorPoint_edge`†, `mem_petalSet_zero`†, `mem_petalSet_one`†, `mem_petalSet_two`†, `isOpen_petalSet`†, `petalCol_of_mem`†, `convex_petalSet_one`†, `convex_petalSet_two`†, `convex_setOf_abs_re_lt_mul_im`†, `convex_setOf_lt_mul_re`†, `isPreconnected_petalSea`†, `zero_mem_closure_petalSet`†, `volume_ball_diff_iUnion_petalSet`†.
- on `[propext]` (1): `fin_three_cases`†.
**`Plane/ClosePair`** — 31 theorems of this phase (2 of them helpers), each [kernel] on a branch:
- on `[propext, Classical.choice, Quot.sound]` (31): `mem_presentAt_iff`, `not_mem_presentAt_of_ae_ne`, `not_mem_presentAt_iff`, `mem_presentAt_of_ae_eq`, `presentAt_nonempty`, `IsCommonUnitPoint.symm`, `exists_isCommonUnitPoint`, `ClosePair.crossAt`, `ClosePair.exists_label_eq`, `ae_onSide_of_label`, `exists_onSide_of_cover`, `exists_inner_outer_of_cover`, `ae_label_left_of_forall_not_onSide`, `exists_isTight_of_ae_side`, `IsTight.closure_inter_closure_eq`, `ThreePiece.exists_second_unit_point_of_ae_side`, `ThreePiece.not_isFull_of_ae_side`, `ThreePiece.exists_ne_not_onSide_of_ae_side`, `ClosePair.separatesAt_or`, `ClosePair.lone_of_cover`, `ClosePair.separatesAt_right_of_isFull`, `ClosePair.label_mem_presentAt_of_isFull_right`, `ClosePair.presentAt_eq`, `ClosePair.ncard_inner_outer`, `closePair_forced_pieces`, `closePair_lone`, `closePair_both_separate`, `closePair_both_saved`, `closePair_four`, `exists_perm_fin_three`†, `ThreePiece.HasArcEdges.saves_of_separatesAt`†.

## Stage 1 — SAVED (FS124-I3): the readback and the build as given

**The brief's quotations against their sources.** `data/fs124/i3/readback.py <brief>` (the first implementer's script,
copied unchanged: every quoted block with its `— source:` line is looked for, whitespace-normalized, in the file named,
in this worktree and on the main working tree): **15 of 15 found** (`data/fs124/i3/logs/readback.txt`, exit 0) — Kooshi's
two passages, the inventory's item 34, the four claims' first lines against `data/fs124/claims-K2.md`, the five theorem
heads against `Plane/ClosePair`, the planner's three passages. Control: `--control` changes the case of one letter in
each quotation and must find none — it found none (`data/fs124/i3/logs/readback-control.txt`, exit 0).

One note on the brief, which changes nothing: the claim list `data/fs124/claims-K2.md` is on `main` only (this branch
holds `claims-K1.md` and `claims.md`); I read it there, with its dated line of 16:33 UTC.

**Read whole**: the brief; `plans/STANDING-RULES.md`; `LEAN.md`; `RUNNING.md` § Building and § Make the gate fail, and watch
it fail; `data/fs124/claims-K2.md`; the planner's record (Stages 1–5); my two files; the two files they import that the
first implementer proved (`Plane/CircleCrossing` whole, `Plane/OnePiece` to the model), and of `Plane/WeakColouringOn`
the definitions; the first implementer's record, Stages 1–4 (its tools are the ones I copy below).

**The build as given**: `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the
worktree, exit 0 — `build: OK — 477 of 477 batches, 7 module(s) rebuilt, 4 module(s) with warnings, 9m26s`
(`data/fs124/i3/logs/build-0-as-given.log`; the full output, `build-0-as-given-full.log`). The full log holds **67
distinct `declaration uses sorry` warnings and no other warning** — 29 in `Plane/ThreePiece`, 32 in `Plane/ClosePair`,
3 in `Plane/ClosePairModel`, 3 in `Plane/SectorPoint`: the brief's count. Its one line with the word `error` is the
build script's up-to-date probe (line 3, `target is out-of-date and needs to be rebuilt`).

**A slip of mine during that build, with no effect on it.** About five minutes into the walk I applied my first patch to
`Plane/ThreePiece` in place, saw that the build had not yet reached the module, and put the file back (`git checkout`)
within a minute, some two hundred batches before the batch that compiles it. The log's 29 warnings for the module are the
as-given count (a file with sixteen leaves proved would have printed 13). From then on nothing under `Proofs/` is edited
while a build runs: I work in a scratch copy and copy in when the build has ended.

**The statements as the kernel holds them, before any proof** (for the comparison after each file):
`data/fs124/i3/lean/StatementDump.lean` (the first implementer's dumper, aimed at my two modules) prints every constant
stored in the compiled data of `Plane/ThreePiece` and `Plane/ClosePair` — kind, full name, stored type, a definition's
stored value — from the build as given: `data/fs124/i3/statements-before.txt`, 126 constants (70 and 56). **One thing the
copied check could not do as it stood**: `sectorPoint` and `petalPoint` are definitions that hold nine proofs as fields,
so their stored values move when a field is proved. The dumper now also prints, for a `ThreePiece` given by its
sixteen arguments, the three data fields (neighbourhood, pieces, labels) on a `DATA` line, and
`data/fs124/i3/statement_diff.py` compares that line in place of the value for those definitions (2 in the dump), with
a planted fault of its own.

**How I iterate** (never evidence): `data/fs124/i3/lean1.sh <file>` — `lake env lean -DautoImplicit=false
-DrelaxedAutoImplicit=false -Dlinter.missingDocs=true` against this worktree's build, about 3 s a run. `Plane/ClosePair`
elaborates against the built `.olean` of `Plane/ThreePiece` as it stands, since no statement changes; the two helpers it
needs are stated in `Plane/ClosePair` itself. Leaves are written into patch files (`data/fs124/i3/patch-*.txt`, applied
by `data/fs124/i3/patch.py`, which refuses an anchor that is missing or doubled).

## Stage 2 — SAVED (FS124-I3): `Plane/ThreePiece`'s interface and `Plane/ClosePair` whole — 49 of 61 leaves, in the build; the four claims proved

**In the build**: the same command, exit 0 — `build: OK — 477 of 477 batches, 5 module(s) rebuilt, 3 module(s) with
warnings, 9m42s` (`data/fs124/i3/logs/build-1-claims.log`; the full output, `build-1-claims-full.log`). The full log holds
**18 distinct `declaration uses sorry` warnings and no other warning**: 12 in `Plane/ThreePiece` (its two constructions
with their measurability leaves and examples — Stage 3), 3 in `Plane/ClosePairModel`, 3 in `Plane/SectorPoint` (the third
job's). **None in `Plane/ClosePair`: its 32 leaves are all proved; so are the 17 leaves of `Plane/ThreePiece` down to and
including `hasUnitArcFrom_of_arc_subset_sphere`.** Its one line with the word `error` is the up-to-date probe (line 3).

**The five theorems of the four claims, printed from that build** (`data/fs124/i3/lean/PrintClaims.lean`, output
`data/fs124/i3/claims-axioms.txt`; sent to the coordinator at 17:38 UTC):

```
'HadwigerNelson.Plane.closePair_forced_pieces' depends on axioms: [propext, Classical.choice, Quot.sound]
'HadwigerNelson.Plane.closePair_lone' depends on axioms: [propext, Classical.choice, Quot.sound]
'HadwigerNelson.Plane.closePair_both_separate' depends on axioms: [propext, Classical.choice, Quot.sound]
'HadwigerNelson.Plane.closePair_both_saved' depends on axioms: [propext, Classical.choice, Quot.sound]
'HadwigerNelson.Plane.closePair_four' depends on axioms: [propext, Classical.choice, Quot.sound]
```

**The control fired, four ways** (each prints `sorryAx`): a theorem planted in the scratch file on `sorry`, a theorem
planted there that cites it, `sectorPoint_isFull` (a theorem of my own file that at this stage still rests on a `sorry` of
mine: the sector point's fields), and `exists_closePair_full` (the third job's skeleton). No one of the five rests on a
`sorry`, mine or another job's: `Plane/ClosePair` cites nothing of the two constructions, and the first implementer's
two files are proved.

**The leaves, each against its planned route** (`plans/FS124-kernel-plan-2.md` § 3.2). No planned route failed; nothing
was dispatched to a companion.

| leaf | route |
|---|---|
| `HasUnitArcFrom.mem` | as planned (`t = 0`) |
| `HasUnitArcFrom.mem_closure_diff` | the plan's conclusion by a route of mine, shorter to state: the arc `t ↦ w + (x − w) e(s t)` is continuous and starts at `x` (`Metric.continuous_iff` in place of the chord bound `norm_e_sub_e_le`); a point at a small positive angle is not `x` because `cos (s t) = 1` forces `s t = 0` on `(−2π, 2π)` (`Real.cos_eq_one_iff_of_lt_of_lt`) |
| `ThreePiece.isPieceAt`, `mem`, `isConnected_piece`, `disjoint_piece`, `mem_edge`, `edge_comm`, `edge_subset_sphere`, `OneOfEach.separatesAt` | as planned (terms) |
| `ThreePiece.ae_mem_piece`, `ae_label_of_forall_onSide`, `not_separatesAt_iff` | as planned |
| `OneOfEach.eq_of_innerAt`, `eq_of_outerAt` | as planned (`σ` onto; the three values of `Fin 3` by `decide`) |
| `HasArcEdges.isFull` | as planned (continuity of `γ` at `0`, injectivity) |
| `hasUnitArcFrom_of_arc_subset_sphere` | the plan's route, **without the monotonicity step**: with `φ u = (γ u − w)/(x − w)` on the line (the arc extended by `Set.projIcc`), on a stretch `[0, u₀]` where `φ` stays in `Complex.slitPlane` the argument is continuous, it is `0` at `0` and not `0` at `u₀` (injectivity), and the intermediate value theorem alone (`intermediate_value_uIcc`) gives every angle between — `ContinuousOn.strictMonoOn_of_injOn_Icc'` is not needed. 68 lines against 45 planned |
| `mem_presentAt_iff` (`Iff.rfl`), `not_mem_presentAt_of_ae_ne`, `not_mem_presentAt_iff`, `mem_presentAt_of_ae_eq`, `presentAt_nonempty` | as planned |
| `IsCommonUnitPoint.symm`, `ClosePair.crossAt` | as planned |
| `exists_isCommonUnitPoint` | as planned, written as `x + n ζ`, `x + n ζ̄` with `n` the unit vector from `x` to `y` and `ζ = d/2 + h i` of norm `1` (`Complex.norm_add_mul_I`): the four distances are one line each; exactly two by `EuclideanGeometry.eq_of_dist_eq_of_dist_eq_of_finrank_eq_two`, with the first implementer's way to `finrank ℝ ℂ = 2` (no new import) |
| `ClosePair.exists_label_eq` | as planned (`Fintype.bijective_iff_injective_and_card` on `Sum.elim`) |
| `ae_onSide_of_label` | as planned; the least radius over the pieces only (the two sides by hand: `CircleSide` has no `Finite` instance and needs none) |
| `exists_onSide_of_cover`, `exists_inner_outer_of_cover`, `ae_label_left_of_forall_not_onSide` | as planned |
| `exists_isTight_of_ae_side`, `IsTight.closure_inter_closure_eq` | as planned |
| `ThreePiece.exists_second_unit_point_of_ae_side`, `.not_isFull_of_ae_side`, `.exists_ne_not_onSide_of_ae_side` | as planned |
| `ClosePair.separatesAt_or` | as planned |
| `ClosePair.lone_of_cover` | § 3.3's five children, in order; the middle step as one sentence used twice — *no closed side of `S(w)` holds all the pieces of `x` but one* (`hstar`, from `exists_ne_not_onSide_of_ae_side`) — at the inside against the outer piece and at the outside against the inner one, which names the third piece as crossing |
| `ClosePair.separatesAt_right_of_isFull` | by contradiction through `lone_of_cover`, closed by `ThreePiece.not_isFull_of_ae_side` (3 lines) |
| `ClosePair.label_mem_presentAt_of_isFull_right` | as planned, as one statement per side `s` of `S(x)` (*if one piece of `x` only is on the closed side `s` of `S(w)`, its label is present*), used at the two sides |
| `ClosePair.presentAt_eq`, `ncard_inner_outer` | as planned |
| `closePair_forced_pieces`, `closePair_lone`, `closePair_both_separate`, `closePair_four` | as planned (the general statement at `C.exists_label_eq`) |
| `closePair_both_saved` | as planned, through one helper (below) |
| the three spec examples of `Plane/ClosePair` | as planned |

**Helpers added** (two, both in `Plane/ClosePair`; each name searched in `Proofs/` of `main` and of every worktree: no
other declaration; for each the statement's shape was looked for first):
- `exists_perm_fin_three : i ≠ j → i ≠ k → j ≠ k → ∃ σ : Equiv.Perm (Fin 3), σ 0 = i ∧ σ 1 = j ∧ σ 2 = k` — what
  `lone_of_cover` needs to hand `OneOfEach` its permutation; `Equiv.ofBijective` on `![i, j, k]`, injective by `decide`.
- `ThreePiece.HasArcEdges.saves_of_separatesAt : D.HasArcEdges → D.SeparatesAt w → D.Saves w` — the one-member form of
  C124-BOTH's second clause (the edge of the inner and the outer piece lies on `S(w)` and holds an arc from the point).
  A consumer holding one arc-edged member that separates has its saving without the pair.

**No statement and no definition changed** — on the kernel's side, with a control: `statements-after-1.txt` (the dump on
this stage's build) against `statements-before.txt`, and the `example` heads of the two files as text against the base
commit `ab6697478`: **111 named constants compared (types; values of definitions; the three data fields of the two
decompositions given as data), 9 example heads, no difference; 2 new named constants, the helpers above**
(`data/fs124/i3/logs/statement-diff-1.txt`, exit 0). Control (`--control`): one stored statement, one definition's value,
one data field of `sectorPoint` and one example's head changed in the second input — 4 of 4 reported
(`logs/statement-diff-1-control.txt`). `git diff` on the two files removes 49 lines, each a `sorry`.

**Unused hypotheses, reported and not dropped** (each is a binder of a statement of the skeleton; the build prints no
`unused variable` warning, since each is named in a term or is an instance-free binder the linter does not flag at a
`theorem`):
- `ThreePiece.exists_second_unit_point_of_ae_side` and `.not_isFull_of_ae_side`: every hypothesis is read.
- `closePair_forced_pieces` … `closePair_four`: `hc.measurable` is not read (the planner's G1); `hU`, `hw`, `hwu` are.
- `exists_isTight_of_ae_side`: `hU` and `hw` are read (the disc inside `U`).
- `ClosePair.ncard_inner_outer`: no hypothesis beyond the pair.
Nothing beyond what the planner's § 2.3 already records.

**The price, as measured.** 49 leaves; 649 lines added, 49 removed; the interface in one pass and one further `lean` run
(three errors: a `simp` normal form of `cos`, two `decide +revert` that reverted too much), `Plane/ClosePair` in two
passes of 16 leaves, the first with one error (`zero_le` takes no explicit argument at the pin) and the second with one
linter note (an unused `simp` argument); each `lean` run about 3 s; one build, 9m42s.

## Stage 3 — SAVED (FS124-I3): `Plane/ThreePiece`'s two constructions — 61 of 61 leaves, in the build; every record's axioms printed; the claims read aloud

### 3.1 The constructions, the build, the checks

**In the build**: the same command, exit 0 — `build: OK — 477 of 477 batches, 5 module(s) rebuilt, 2 module(s) with
warnings, 9m4s` (`data/fs124/i3/logs/build-2-constructions.log`; the full output, `build-2-constructions-full.log`). The
full log holds **6 distinct `declaration uses sorry` warnings** — 3 in `Plane/ClosePairModel`, 3 in `Plane/SectorPoint`:
the third job's files — **none in `Plane/ThreePiece` or `Plane/ClosePair`, and no other warning** (its one line with the
word `error` is the up-to-date probe, line 3). **My 61 leaves are all proved; none is left `sorry`.** Then one spec
example was added (below) and the tree built again: exit 0, `477 of 477 batches, 1 module(s) rebuilt, 2 module(s) with
warnings, 8m32s` (`build-3-final.log`, `build-3-final-full.log`: the same 6 warnings and no other) — `Plane/ThreePiece`
alone re-elaborated, its dependents not rebuilt (an `example` stores nothing; the two dumps of the stored constants are
byte-identical: `statements-after-2.txt`, `statements-after-3.txt`). Everything below is read from that last build, which
is the build of the files as committed.

**The leaves, each against its planned route** (§ 3.2 of the plan). No planned route failed; nothing was dispatched to
a companion.

| leaf | route |
|---|---|
| `measurable_sectorCol`, `measurable_petalCol`, `isWeakColouringOn_ball_quarter` | as planned |
| `sectorPoint` (nine fields) | as planned for the neighbourhood, openness, convexity, closure and labels (each through a small lemma on `sectorSet`); **the null clause by lines of the plane**: what the disc leaves outside the three sectors lies on `re = 0`, `im = 0` or `re = im`, and a line `a re + b im = c` is null (`volume_setOf_re_im_eq`: the kernel of a non-zero real-linear form by `Measure.addHaar_submodule`, moved by a measure-preserving translation) — the plan named `Measure.addHaar_affineSubspace`; this needs no affine subspace built |
| `sectorPoint_hasArcEdges` | as planned: the radius between two sectors, as the straight arc `t ↦ t d` (`exists_arc_of_ray_subset`), is in the closure of both (a point of a closed sector is a limit along the sector's inner direction: `mem_closure_sectorSet_zero`, `_one`, `_two`); `edge_comm` halves the cases |
| `petalPoint` (nine fields) | as planned: the sea is the union of two wedges and two caps, each convex in the disc, chained by `IsPreconnected.union` at the three points `(13/100, 14/100)`, `(13/100, −14/100)`, `(−13/100, 14/100)` (`isPreconnected_petalSea`); the null clause on the four lines `re = ± im`, `re = ± 1/8` |
| `petalPoint_edge`, `petalPoint_not_isFull` | as planned (`closure_minimal` into `{|im| ≤ re}` and `{|im| ≤ −re}`) |
| the four spec examples of `Plane/ThreePiece` | as planned (the outer piece through `|Im (z + i)| ≤ ‖z + i‖`; the crossing piece through the points `−i/8` and `1/5 − i/100`) |

**Helpers added** (33 in `Plane/ThreePiece`, listed under "Theorems this phase proved"; each name searched in `Proofs/`
of `main` and of every worktree before it was typed — no other module declares it; for each general one the statement's
shape was looked for first). The nine that are not about `sectorSet` or `petalSet`, with what was found:
- `fin_three_cases`, `combo_lt` (a positive combination of two strict inequalities: `add_lt_add` of two
  `mul_lt_mul_of_pos_left`) — one-line conveniences.
- `mem_closure_of_forall_add_ofReal_mul_mem` (a point from which a short segment runs into `S` is in the closure of
  `S`), `mem_closure_inter_ball` (`IsOpen.inter_closure` with the factors in this file's order).
- `mem_ball_zero_of_abs_re_add_abs_im_lt` (`Complex.norm_le_abs_re_add_abs_im`), `mem_ball_zero_of_sq_lt`,
  `ofReal_mul_mem_ball_quarter` — membership in a disc about `0` read on real and imaginary parts.
- `volume_setOf_re_im_eq` — **a line of the plane is null.** The library held this for a segment
  (`volume_segment_eq_zero`, `Plane/LocalStructure`, through an affine subspace) and for a line in an edge frame
  (`volume_hcFrame_line`, `Plane/CoverExamples`), not for a line given by its equation in `re`, `im`.
- `exists_arc_of_ray_subset` — a straight arc from `0` as a `C(unitInterval, ℂ)`.

**One spec example added, not in the skeleton** (new text in a statement file; it changes no statement). The skeleton's
example "Both models are three-piece points of weak colourings" proves the two decompositions and not the two weak
colourings, and without it `measurable_sectorCol`, `measurable_petalCol` and `isWeakColouringOn_ball_quarter` had no
consumer in the file. The added example states `IsWeakColouringOn (ball 0 (1/4)) sectorCol ∧ IsWeakColouringOn (ball 0
(1/4)) petalCol` from those three. The landing may drop it without touching anything else.

**No statement and no definition changed**: `statements-after-3.txt` against `statements-before.txt` and the base commit
— **111 named constants compared (types; values of definitions; for `sectorPoint` and `petalPoint` their three data
fields), 9 example heads of the base all present in order, no difference; 35 new named constants (the helpers of both
files) and 1 new example** (`data/fs124/i3/logs/statement-diff-3.txt`, exit 0); control, 4 of 4 planted faults reported
(`logs/statement-diff-3-control.txt`). `git diff ab6697478` on the two files removes 77 lines, each a `sorry` (49 in
Stage 2, 28 here: 18 fields and 10 leaves). The five claims' theorems as the kernel holds them, every binder, and the
definitions their statements name: `data/fs124/i3/claim-sigs.txt` (`#check`, `#print`, from the build).

**A defect in the copied check, found on my own text and repaired in my copy.** The reader of `example` heads
(`statement_diff.py`, from `data/fs124/i2/`) takes every line that begins with the word `example`; a docstring line of
mine began with it and was counted as a second new example. My copy now blanks block comments and docstrings before it
looks (`data/fs124/i3/statement_diff.py`); the first implementer's copy is not mine to edit and its two runs are not
affected (no docstring line of its files begins with the word).

**The axioms, printed from the build** (`data/fs124/i3/lean/PrintAxioms.lean`, generated by `data/fs124/i3/make_audit.py`
from the two source files — each `theorem` line resolved against the stored constants, and the three definitions that
hold proofs as fields; output `data/fs124/i3/axioms.txt`; read by `data/fs124/i3/read_axioms.py`, `logs/read-axioms.txt`,
exit 0): **91 records — the 88 theorems of the two files and the definitions `sectorPoint`, `petalPoint`,
`ClosePair.symm` — 90 on `[propext, Classical.choice, Quot.sound]` and 1 on `[propext]` (`fin_three_cases`); no other
axiom; 95 asked, 95 printed.** The five claims' lines are those of Stage 2, unchanged. **The control fired, four ways**:
a theorem planted in the scratch file on `sorry`, a theorem planted there that cites it, and two theorems of the third
job's skeleton — `exists_closePair_full` (`Plane/ClosePairModel`) and `closePair_both_saved_of_isSector`
(`Plane/SectorPoint`) — each prints `sorryAx`, and the reader fails if one does not. **No theorem of my two files rests
on a `sorry`, mine or another job's.**

**Names, linters, architecture — on the tree of the last build.**
- `./scripts/dupnames.sh` under the slot: exit 0 — `dupnames: OK — no name is declared by two modules (23 generated on
  demand, listed above)`; `scanned 7465 modules, 1853 of them the package's (1853 source files)`
  (`data/fs124/i3/logs/dupnames.txt`). None of the 23 generated names is of my two modules. `--self-test`: exit 0, `all 15
  controls behaved: every planted fault fired, and every partner passed` (`logs/dupnames-selftest.txt`). **This is the
  scan of this branch alone**: a join with another line makes the tree on which a doubled name could first exist.
- The environment linters, run once as a probe on the build of the 61 leaves (not the gate): `lake lint --no-build --
  --no-build --trace` under the slot, exit 0, `-- Linting passed for Proofs.`, 14 linters and 14 `(2/2) Passed!`
  (`logs/lint.txt`) — `unusedArguments` and `docBlame` among them: **no hypothesis of a statement of the two files is
  unused by its proof**, beyond what a linter cannot see (`hc.measurable`: the five claims read `hc.aeProperOn` only,
  the planner's G1).
- `tools/check_architecture.py`: exit 0, `RESULT: PASS` (`logs/check-architecture.txt`).
- Not run, by the brief: the full gate (`scripts/axioms.sh`, `scripts/assumptions.sh`, `scripts/vacuity.sh`).

**The price, as measured.** The constructions: 12 leaves; 512 lines added, 28 removed; the sector point in one pass and
one further `lean` run (a `rw` that met its goals in the wrong order, replaced by `simp only`), the petal point in one
pass and two further runs (anonymous constructors under `IsPreconnected.union` with the second set not yet known; five
unused `simp` arguments and a deprecated name). **Both files: 61 leaves, 35 helpers, 1 added example; 1,161 lines added,
77 removed; four builds that compiled (9m26s as given, 9m42s, 9m4s, 8m32s — each the walk over 477 batches with one to
seven modules to compile at about 3 s each); about a dozen `lean` runs of 3 s; 0 leaves left, 0 routes failed, 0
statements back through the coordinator.** The planner priced the two files at about 810 lines; they came in at 1,161,
the difference being the two models (512 against 240) — convexity and closure of five regions written out, where the
plan's sizes counted the idea.

### 3.2 Read aloud: each claim's theorem against the claim list's words, and against its *not claimed* line

Four readings hold for all five theorems and are said once.
1. **The class.** The list's weak six-colouring is "a measurable map `c` from `U` to `k` labels"; the theorems take the
   first module's `IsWeakColouringOn U c` with `c : ℂ → Fin 6` — a total measurable `c`, proper at almost every unit pair
   of `U`, read on `U` alone — and `hU : IsOpen U` (the class is defined on an open set). That reading is the first
   module's; nothing here adds to it. No proof reads measurability (`hc.aeProperOn` only).
2. **The definitions are the planner's**, each read against the list's "Definitions, stated once" in its record (§ 2.1)
   and confirmed there by the coordinator where a reading was chosen (`N` any neighbourhood inside `U`, not asked
   open; `presentAt` through `essSupport (U ∩ c ⁻¹' {i})`). I read them again as the kernel prints them
   (`data/fs124/i3/claim-sigs.txt`: `#print` of the structures and definitions the five statements name).
3. **"Almost every"** is `∀ᵐ z` for plane Lebesgue measure on `ℂ`; `|a − b|` is `dist a b`; `B(p, r)` is `ball p r`,
   `B̄(p, r)` is `closedBall p r`, `S(p)` is `sphere p 1`; "inside `S(p)`" is `dist z p < 1`, "outside" is `1 < dist z p`,
   and "a side of `S(y)`" is `τ.region y` for `τ : CircleSide` (`ball y 1` or `(closedBall y 1)ᶜ`).
4. **The setting** of all four: "c a weak six-colouring of U" — `hU`, `hc`; "(x, y) a close complementary pair of
   three-piece points, each with a decomposition" — `C : ClosePair U c x y`, whose fields are the two decompositions
   (`left : ThreePiece U c x`, `right : ThreePiece U c y`), `ne : x ≠ y` and `dist_lt : dist x y < 2` ("0 < |x − y| < 2"),
   and `label_ne : ∀ i j, left.label i ≠ right.label j`, which with each decomposition's `label_injective` is "whose six
   labels are distinct"; "w a common unit point of the pair lying in U" — `hwu : IsCommonUnitPoint x y w` (`dist w x = 1
   ∧ dist w y = 1`) and `hw : w ∈ U`.

**C124-FORCED-PIECES** — `closePair_forced_pieces`.

> **C124-FORCED-PIECES** — statement: Let c be a weak six-colouring of U, (x, y) a close complementary pair of three-piece points, each with a decomposition, and w a common unit point of the pair lying in U. Then x or y separates at w: one of its pieces lies in the closed unit disc about w and another is disjoint from the open unit disc about w; the edge of those two pieces lies on S(w).
> — source: data/fs124/claims-K2.md

The setting: reading 4. "Then x or y separates at w" — the disjunction, its left member about `C.left` and its right
about `C.right`. "one of its pieces lies in the closed unit disc about w" — `InnerAt (C.left.piece i) w`, which is
`C.left.piece i ⊆ closedBall w 1`. "and another is disjoint from the open unit disc about w" — `OuterAt (C.left.piece j)
w`, which is `Disjoint (C.left.piece j) (ball w 1)`. "the edge of those two pieces lies on S(w)" — `C.left.edge i j ⊆
sphere w 1`, the edge being `closure (piece i) ∩ closure (piece j) ∩ nbhd`. Every clause has its conjunct; no hypothesis
is added. **One word of the claim is not a conjunct: "another".** The statement does not say `i ≠ j`; it follows, since a
piece is a non-empty open set and no such set is both inner and outer (`not_innerAt_and_outerAt`) — the helper
`ThreePiece.HasArcEdges.saves_of_separatesAt` derives it so. A consumer that wants `i ≠ j` has it in one line.

> *Not claimed (C124-FORCED-PIECES):* that a weak six-colouring has a three-piece point, or a close complementary pair; which member separates, or that both do (C124-BOTH needs full members; in fragment S1 one does not); that the edge of the two pieces is more than the member itself (at a bowtie it is not); anything with seven labels (C124-FORCED-SEVEN)
> — source: data/fs124/claims-K2.md

Existence: `C` is a hypothesis. Which member, or both: a disjunction. That the edge is more than the point: the
conclusion is an inclusion in the circle, nothing else. Seven labels: `c : ℂ → Fin 6`; under it `ClosePair.separatesAt_or`
holds at any label type from the hypothesis "every label is the label of a piece of `x` or of `y`", which seven labels
do not satisfy. The theorem claims none of the four.

**C124-LONE** — `closePair_lone`.

> **C124-LONE** — statement: In the setting of C124-FORCED-PIECES suppose y does not separate at w. Then x has exactly one inner piece, one outer piece and one crossing piece at w, with labels a and b for the inner and the outer one; there are a side of S(y) and η > 0 such that almost every point of B(w, η) on that side has the label a if it lies inside S(x) and the label b if it lies outside S(x); and there are a point w′ ≠ w of S(x) and η′ > 0 such that inside B(x, η′) the inner piece lies in B̄(w, 1) ∩ B̄(w′, 1), the outer piece is disjoint from B(w, 1) ∪ B(w′, 1), and their closures meet at x only.
> — source: data/fs124/claims-K2.md

"suppose y does not separate at w" — `hy : ¬ C.right.SeparatesAt w`, `SeparatesAt` being "an inner and an outer piece".
"Then x has exactly one inner piece, one outer piece and one crossing piece at w" — `∃ σ : Equiv.Perm (Fin 3),
C.left.OneOfEach w σ`: the piece `σ 0` inner, `σ 1` outer, `σ 2` crossing (`CrossingAt`: neither inner nor outer).
*Exactly* one of each: `σ` is a bijection of the three pieces, and the inner piece is the only inner one, the outer the
only outer one (`ThreePiece.OneOfEach.eq_of_innerAt`, `eq_of_outerAt`, proved in this job). "with labels a and b for
the inner and the outer one" — `C.left.label (σ 0)`, `C.left.label (σ 1)`. "there are a side of S(y) and η > 0" —
`∃ τ : CircleSide, ∃ η > 0`. "such that almost every point of B(w, η) on that side has the label a if it lies inside
S(x)" — `∀ᵐ z, z ∈ ball w η → z ∈ τ.region y → dist z x < 1 → c z = C.left.label (σ 0)`. "and the label b if it lies
outside S(x)" — the same with `1 < dist z x` and `C.left.label (σ 1)`. "and there are a point w′ ≠ w of S(x) and η′ > 0"
— `∃ w' ∈ sphere x 1, w' ≠ w ∧ ∃ η' > 0`. "such that inside B(x, η′) the inner piece lies in B̄(w, 1) ∩ B̄(w′, 1)" —
`C.left.piece (σ 0) ∩ ball x η' ⊆ closedBall w 1 ∩ closedBall w' 1`. "the outer piece is disjoint from B(w, 1) ∪
B(w′, 1)" — `Disjoint (C.left.piece (σ 1) ∩ ball x η') (ball w 1 ∪ ball w' 1)`. "and their closures meet at x only" —
`closure (C.left.piece (σ 0)) ∩ closure (C.left.piece (σ 1)) ∩ ball x η' = {x}`: read, as the sentence has it, inside
`B(x, η′)`. Every clause has its conjunct; no hypothesis is added.

> *Not claimed (C124-LONE):* that a weak six-colouring has a three-piece point, or a close complementary pair; that such a configuration is impossible — it is fragment S1's (C124-LONE-EXISTS); anything about the edges of the crossing piece (one of them may lie on S(w)); that (x, w′) is tight on both sides of S(y)
> — source: data/fs124/claims-K2.md

Existence: `C` and `hy` are hypotheses. Impossibility: the conclusion is not `False`. The crossing piece's edges: no
conjunct names `edge`. Tightness on both sides: the conclusion names one side `τ`; the proof passes through a pair
`(x, w')` tight on a disc about `w'` inside that one side (`exists_isTight_of_ae_side`), and the statement does not
export it. The theorem claims none of the four.

**C124-BOTH** — `closePair_both_separate` (first clause) and `closePair_both_saved` (second clause, **for arc-edged
decompositions**).

> **C124-BOTH** — statement: In the setting of C124-FORCED-PIECES, if x and y are full, both separate at w. If they are sector points, each has an edge that contains an arc of S(w) with an end at the member: no common unit point of a close complementary pair of sector points is saved by one member alone.
> — source: data/fs124/claims-K2.md

"if x and y are full" — `hfx : C.left.IsFull`, `hfy : C.right.IsFull`, `IsFull` being `∀ i j, i ≠ j → x ∈ closure
(D.edge i j \ {x})`: "for every two of its pieces x is a limit of points other than x of their edge". "both separate at
w" — `C.left.SeparatesAt w ∧ C.right.SeparatesAt w`. The first clause is the theorem, clause for clause.

**The second clause is not proved in the list's words, and this job does not say it is.** "If they are sector points" —
the theorem takes instead `hax : C.left.HasArcEdges`, `hay : C.right.HasArcEdges`: every edge contains an injective
continuous image of `[0, 1]` that starts at the point. That is what the clause reads of a sector point, by the
coordinator's ruling recorded in the planner's § 2.4; that the list's sector point *is* arc-edged is the θ-curve fact,
the leaf `ThreePiece.IsSector.hasArcEdges` of `Plane/SectorPoint`, **still `sorry` on this branch and owed as a kernel
job of its own**. "each has an edge that contains an arc of S(w) with an end at the member" — `C.left.Saves w ∧
C.right.Saves w`, `Saves w` being `∃ i j, i ≠ j ∧ HasUnitArcFrom (D.edge i j) w x` and `HasUnitArcFrom E w x` being: for
a turning sense `s = ±1` and some `δ > 0` the points `w + (x − w) e(s t)`, `0 ≤ t ≤ δ`, are in `E` — the arc of the unit
circle about `w` from `x`, turning by up to `δ`. "no common unit point … is saved by one member alone" — both conjuncts
hold. So: for arc-edged members every clause has its conjunct; for the list's sector points the clause is
`closePair_both_saved_of_isSector`, which prints `sorryAx` (the audit's fourth control).

> *Not claimed (C124-BOTH):* that a weak six-colouring has a full three-piece point, or a close complementary pair; that exactly one edge of each member lies on S(w) (T2, the kept model: two at one member); anything when a member is not full (S1: one member saves alone)
> — source: data/fs124/claims-K2.md

Existence: hypotheses. Exactly one edge: `Saves` is an existence. A member that is not full: fullness (or arc edges,
which give it: `ThreePiece.HasArcEdges.isFull`) is a hypothesis of both theorems. Neither claims any of the three.
**Finer than the claim, and in the file**: each member's fullness makes the *other* member separate
(`ClosePair.separatesAt_right_of_isFull`, the planner's G7), and one arc-edged member that separates saves by itself
(`ThreePiece.HasArcEdges.saves_of_separatesAt`).

**C124-FOUR** — `closePair_four`.

> **C124-FOUR** — statement: In the setting of C124-FORCED-PIECES let x and y be full, each with exactly one inner piece, one outer piece and one crossing piece at w. Then exactly four labels are present at w: those of the two inner and the two outer pieces.
> — source: data/fs124/claims-K2.md

"let x and y be full" — `hfx`, `hfy`. "each with exactly one inner piece, one outer piece and one crossing piece at w" —
`hσ : C.left.OneOfEach w σ`, `hτ : C.right.OneOfEach w τ`. "Then exactly four labels are present at w: those of the two
inner and the two outer pieces" — `presentAt U c w = {C.left.label (σ 0), C.left.label (σ 1), C.right.label (τ 0),
C.right.label (τ 1)} ∧ (presentAt U c w).ncard = 4`: the set of labels present is the set of those four, and it has four
elements. "present" — `presentAt U c w = {i | w ∈ essSupport (U ∩ c ⁻¹' {i})}`: every disc about `w` meets the class of
`i` in `U` in positive measure. Every clause has its conjunct; no hypothesis is added.

> *Not claimed (C124-FOUR):* that a weak six-colouring has a full three-piece point, or a close complementary pair; which label fills which of the four regions, or that each region carries one label; anything when a member has two inner or two outer pieces (T2: five labels allowed, four present)
> — source: data/fs124/claims-K2.md

Existence: hypotheses. Which label fills which region, or one label per region: the conclusion is the set of labels
present at `w` and its size. Two inner or two outer pieces: `hσ`, `hτ` are hypotheses. The theorem claims none.

**What the read-aloud found.**
- No clause of C124-FORCED-PIECES, C124-LONE, C124-FOUR or of C124-BOTH's first clause is missing, none is added, and no
  theorem claims an item of its *not claimed* line.
- **C124-BOTH's second clause is proved for arc-edged decompositions only.** In the list's words, for sector points, it
  rests on one leaf that is not proved (`ThreePiece.IsSector.hasArcEdges`). This is the planner's and the coordinator's
  recorded position, not a finding of mine; I repeat it because a reader of "the four claims are proved" would otherwise
  be told more than the kernel holds.
- **The four claims' hypotheses have no inhabitant in the kernel yet.** Each docstring names its model in
  `Plane/ClosePairModel` (`exists_closePair_not_separatesAt`, `exists_closePair_full`), and both are `sorry` on this
  branch — the third job's. Until they land, "not vacuous" is the planner's two sampled witnesses ([measured]: floats,
  its § 4.4), not a theorem. What this job does put in the kernel is the two models of *one* member: `sectorPoint`
  (arc-edged, hence full) and `petalPoint` (not full), each a decomposition of a weak colouring of a disc.
- "another" in C124-FORCED-PIECES is a consequence, not a conjunct (above).

### 3.3 Drafts for the landing (the joining job's files; none is written by this job)

- **`scripts/Axioms.lean`, CLEAN section, after the block `-- FS124-I2 block end`** (the first implementer's draft, itself
  after `-- FS124-I1 block end`): the file `data/fs124/i3/audit-block.txt`, whole — a header, `-- FS124-I3:
  Plane/ThreePiece` with 59 `#print axioms` lines, `-- FS124-I3: Plane/ClosePair` with 32, `-- FS124-I3 block end`. **91
  records, each expected CLEAN** (90 on the standard three, 1 on `[propext]`: `fin_three_cases`). Three of the 91 are
  definitions that hold proofs as fields (`sectorPoint`, `petalPoint`, `ClosePair.symm`); if the audit lists theorems
  only, the landing drops those three lines and counts 88. The block is generated from the two files' `theorem` lines
  and regenerates if a file changes (`data/fs124/i3/make_audit.py <a dump of the stored constants>`). With the first
  implementer's 80: **171 records for the four statement modules.**
- **`scripts/Assumptions.lean`**: no entry. No theorem of the two modules takes a hypothesis standing for an outside
  theorem, a hand result or an open question. `hcover` ("every label is the label of a piece of `x` or of `y`") is a
  condition on the theorem's own decompositions, discharged at six labels by `ClosePair.exists_label_eq`;
  `ThreePiece.HasArcEdges` in `closePair_both_saved` is a property of the decomposition, by the coordinator's ruling,
  with the bridge from the list's sector point owed by name (`ThreePiece.IsSector.hasArcEdges`) — a reader counting
  assumptions should find that owed bridge in the landing's report.
- **Vacuity, for the landing's note on models** (`LEAN.md`: the scan is silent on colourings under a predicate it does
  not track). In the kernel on this branch: `ThreePiece U c x` — `sectorPoint` (arc-edged: `sectorPoint_hasArcEdges`;
  full: `sectorPoint_isFull`) and `petalPoint` (not full: `petalPoint_not_isFull`), each on a weak colouring of the disc
  of radius `1/4` (the added example); `HasUnitArcFrom` — the unit circle from `1`, and the adversary `{1}`.
  **Not in the kernel**: any `ClosePair U c x y` with a common unit point in `U`. The five claims' docstrings each end
  "Inhabitant of the hypotheses: `exists_closePair_…` (`Plane/ClosePairModel`)", and those theorems are `sorry`. **A
  landing of `Plane/ClosePair` without `Plane/ClosePairModel` would land five notes that name nothing proved**: it
  waits for the models, or the five notes are reworded for that landing (a docstring edit of `Plane/ClosePair`, which
  rebuilds its dependents and changes no statement).
- **`Proofs.lean`, `ARCHITECTURE.md`**: not touched; the planner registered the modules, and its rows say "a skeleton
  on branch `fs124-wk2`" — the landing rewrites them. **This branch holds all four statement modules proved**: it is the
  planner's tip, then the first implementer's five commits, then mine; no join of two lines is needed for them.
- **`LEAN.md` § Searching — Lean**, lines offered (each measured in this job):
  - "`decide +revert` reverts every hypothesis in scope and asks the whole context to be decidable; for a fact about
    `k : Fin 3` state it closed (`∀ k : Fin 3, k = 0 ∨ k = 1 ∨ k = 2 := by decide`) and apply it (FS124-I3)."
  - "At the pin `zero_le` takes its argument implicitly (`zero_le _` is 'function expected');
    `nonpos_iff_eq_zero` turns `μ s ≤ 0` into `μ s = 0`. `Set.diff_self` is deprecated for `Set.sdiff_self`
    (FS124-I3)."
  - "`IsPreconnected.union x ⟨…⟩ ⟨…⟩ hs ht` with the two memberships as anonymous constructors does not elaborate ('the
    expected type of this term could not be determined'): state each membership as a `have` with its set, and build a
    union's membership with `mem_union_left`/`mem_union_right`, not `Or.inl` (FS124-I3)."
  - "A line of the plane given by its equation is null: `volume_setOf_re_im_eq : a ≠ 0 ∨ b ≠ 0 → volume {z : ℂ | a *
    z.re + b * z.im = c} = 0` (`Plane/ThreePiece`), by `Measure.addHaar_submodule` on the kernel of the form and a
    translation; a set cut out of a disc by finitely many strict linear inequalities leaves a null remainder this way
    (FS124-I3)."
  - "An injective path on a circle from `x` contains an arc of the circle from `x` with no monotonicity argument: the
    argument of `(γ u − w)/(x − w)` is continuous while it stays in `Complex.slitPlane`, and `intermediate_value_uIcc`
    gives every angle between `0` and its value at a later point; a path on `unitInterval` is carried to the line by
    `Set.projIcc` (`ThreePiece.hasUnitArcFrom_of_arc_subset_sphere`) (FS124-I3)."
  - "A definition that holds proofs as fields moves its stored value when a field is proved: an implementer's statement
    check compares its data fields in place of its value, and a reader of `example` heads blanks block comments and
    docstrings first — a docstring line beginning with the word `example` was counted as one
    (`data/fs124/i3/lean/StatementDump.lean`, `data/fs124/i3/statement_diff.py`) (FS124-I3)."

## Drafts for the front page

*Each names its slot. None is filed by this job; the landing's own gate run supplies the counts.*

- **`CLAUDE.md` § The gate and § Trust ledger — the counts**: not measured here (the brief: no full gate; the audit
  script is the joining job's). What this job fixes for them: **91 records to add under CLEAN** for `Plane/ThreePiece`
  (59) and `Plane/ClosePair` (32) — 88 if definitions are not listed — none IMPORTED, none PURCHASED; no declared
  hypothesis, so the assumptions step's nine counts do not move for these two modules; the vacuity scan's site count is
  the landing's to read.
- **`LEDGER.md` row 163, its `**Grade:**` sentence** — replacing "[hand] or derived from [hand] entries, one mind each,
  kernel pending; **a second mind is owed on C124-LONE's Step II**, on which C124-BOTH, C124-FOUR and C124-SECOND rest
  (its deriver's line; the kernel lane's second module is that mind, blind first); one topological input of C124-FORCED
  is recalled, not read." — at the landing: "C124-FORCED-PIECES, C124-LONE, C124-BOTH's first clause and C124-FOUR
  **[kernel]**: `HadwigerNelson.Plane.closePair_forced_pieces`, `closePair_lone`, `closePair_both_separate`,
  `closePair_four` (`Proofs/HadwigerNelson/Plane/ClosePair.lean`), each on `[propext, Classical.choice, Quot.sound]` and
  resting on no assumption — no declared outside theorem, no hypothesis standing for a hand result; each holds for any
  function proper at almost every unit pair of `U`, at any label type, from the one hypothesis that every label is the
  label of a piece of `x` or of `y` (`ClosePair.separatesAt_or`, `ClosePair.lone_of_cover`,
  `ClosePair.separatesAt_right_of_isFull`, `ClosePair.presentAt_eq`), which six distinct labels among six give
  (`ClosePair.exists_label_eq`). **C124-BOTH's second clause [kernel] for decompositions each of whose edges contains an
  arc from the point** (`closePair_both_saved`, `ThreePiece.HasArcEdges`); for the list's sector points it rests on the
  θ-curve fact (`ThreePiece.IsSector.hasArcEdges`), not proved. **C124-LONE's Step II has its second mind, the kernel**
  (`exists_isTight_of_ae_side`, `IsTight.closure_inter_closure_eq`, `ThreePiece.exists_second_unit_point_of_ae_side`).
  The inhabitants of the four statements' hypotheses are [measured] (two sampled witnesses, the planner's) until
  `Plane/ClosePairModel` lands. The row's other entries: [hand] or derived from [hand] entries, one mind each, kernel
  pending; one topological input of C124-FORCED is recalled, not read." **Until the landing** the four are
  "kernel-checked on branch `fs124-wi3`, not through the gate".
- **`CLAUDE.md` § Frontier and § Paths forward, the sentence on FS-124's second module** ("its second is being
  planned") — at this hand-back: "of its second, the four statement modules are proved on branch `fs124-wi3` — the nine
  claims, 171 records, kernel-checked on a branch, not through the gate; C124-BOTH's second clause for arc-edged
  decompositions; the three models and the sector-point bridge are owed".
- **Proof Atlas**: row 163's C124-FORCED-PIECES, C124-LONE, C124-FOUR and C124-BOTH's first clause change grade [hand]
  → [kernel] at the landing, not before; C124-BOTH's second clause changes for arc-edged decompositions only. No other
  grade moves by this job.

## Stage 4 — SAVED (FS124-I3): the tree as committed, and the hand-back

**The build as committed** (`9f138a204`): the same command, exit 0 — `build: OK — all 1853 modules already up to date,
nothing built, 2 module(s) with warnings, 2s` (`data/fs124/i3/logs/build-4-as-committed.log`): the two modules with
warnings are the third job's (`Plane/ClosePairModel`, `Plane/SectorPoint`). The last build of Stage 3 is the build of the
committed files.

**The price of the job, as measured.** 61 leaves of 61 (52 named theorems, 2 decompositions of nine proof fields each, 7
spec examples), 35 helpers, 1 added example; 1,161 lines added to the two files, 77 removed (each a `sorry`); four builds
that compiled (9m26s, 9m42s, 9m4s, 8m32s) and one that found nothing to build; about a dozen `lean` runs of 3 s.
**Wall clock: 17:05 to 18:05 UTC, an hour, 37 minutes of it the four walks** — the proofs were written while the walks
ran, in patch files and a scratch copy. No leaf took a second route in the sense of a failed first one; three leaves
were proved by a route shorter than the planned one (`HasUnitArcFrom.mem_closure_diff`, the arc on a circle, the null
clause of the two models: Stages 2 and 3); no leaf is left `sorry`; no statement came back through the coordinator. As
for the first implementer, what made it an hour is the plan: every leaf had its route and its Mathlib names at the pin.

**Left for others, by name.** Nothing of my two files. On the branch: `Plane/ClosePairModel` — `exists_closePair_seven_not_separatesAt`,
`exists_closePair_not_separatesAt`, `exists_closePair_full` — and `Plane/SectorPoint` — `sectorPoint_isSector`,
`exists_closePair_sector` (the third job's), `ThreePiece.IsSector.hasArcEdges` (the θ-lemma, a kernel job of its own).
For the third job, from what these two files now hold: `sectorPoint`'s tools are stated for the disc of radius `1/4`
about `0` (`sectorSet`, the three closure lemmas, `volume_setOf_re_im_eq` for the null clause, `exists_arc_of_ray_subset`
for a straight edge, `isPreconnected_petalSea`'s chaining for a piece that is not convex); a translated copy is a new
decomposition, not a corollary.

**The report**: `data/fs124/reports/FS124-I3.md`.

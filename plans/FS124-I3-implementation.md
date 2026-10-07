# FS-124 — the second module's last two files: three-piece points, and a close complementary pair at a common unit point (job FS124-I3)

*De Bruijn, the implementer. Brief: `data/fs124/briefs/FS124-I3-close-pair.md` (on `main`). Skeleton and plan: the planner's,
`plans/FS124-kernel-plan-2.md` on this branch (`fs124-wi3`, at `ab669747` when this job began: the planner's tip
fast-forwarded to the first implementer's hand-back). Files of this job: `Proofs/HadwigerNelson/Plane/ThreePiece.lean`,
`Proofs/HadwigerNelson/Plane/ClosePair.lean` (proofs only; no statement and no definition is changed). Working files:
`data/fs124/i3/`. The record is written in stages; each is committed before the next starts.*

## Theorems this phase proved

*Filled at Stage 3 (the claims) and Stage 4 (the constructions); until then: none through a build.*

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

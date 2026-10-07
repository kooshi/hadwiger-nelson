# FS-124 — the witnesses: three colourings by formula that inhabit the close-pair theorems (job FS124-I4)

*De Bruijn, the implementer. Brief: `data/fs124/briefs/FS124-I4-witnesses.md` (on `main`). Skeleton and plan: the planner's,
`plans/FS124-kernel-plan-2.md` on this branch (`fs124-wi3`, at `fb515b25a` when this job began). Files of this job:
`Proofs/HadwigerNelson/Plane/ClosePairWitness.lean` (new: the witnesses, constructed),
`Proofs/HadwigerNelson/Plane/ClosePairModel.lean` (the three existence proofs), and in
`Proofs/HadwigerNelson/Plane/SectorPoint.lean` the proofs of `sectorPoint_isSector` and `exists_closePair_sector`. No
statement and no definition of the skeleton is changed. Working files: `data/fs124/i4/`. The record is written in stages.*

## Theorems this phase proved

On branch `fs124-wi3` only: **kernel-checked on a branch, not through the gate** — nothing here is on `main`, and
`Plane/SectorPoint` still holds one `sorry`, the θ-leaf `ThreePiece.IsSector.hasArcEdges`, which is not this job's.
Axioms as printed from the build of Stage 4 (`data/fs124/i4/axioms.txt`; five controls fired). Every record with its
kind, its module and its axioms, one line each: `data/fs124/i4/theorems-proved.txt` (130 records).

**The five leaves of the skeleton**, each read against the informal statement beside it (Stage 4, § 4.3):
- `HadwigerNelson.Plane.exists_closePair_seven_not_separatesAt` (`Plane/ClosePairModel`) — `[propext, Classical.choice,
  Quot.sound]`. *With seven colours there is a weak colouring of an open set with a close complementary pair and a
  common unit point in the set at which neither member separates.* Witness: `sevenPair`.
- `HadwigerNelson.Plane.exists_closePair_not_separatesAt` (`Plane/ClosePairModel`) — `[propext, Classical.choice,
  Quot.sound]`. *A weak six-colouring of an open set with a close complementary pair and a common unit point in the set
  at which the second member does not separate.* Witness: `lonePair`.
- `HadwigerNelson.Plane.exists_closePair_full` (`Plane/ClosePairModel`) — `[propext, Classical.choice, Quot.sound]`. *A
  weak six-colouring of an open set with a close complementary pair of arc-edged members and a common unit point in the
  set at which each has one inner, one outer and one crossing piece.* Witness: `squarePair`.
- `HadwigerNelson.Plane.sectorPoint_isSector` (`Plane/SectorPoint`) — `[propext, Classical.choice, Quot.sound]`. *The
  ordinary three-sector point is a sector point in the claim list's words: its pieces are the three components of the
  disc of radius 1/4 cut along the radii along 1, i and −1 − i.*
- `HadwigerNelson.Plane.exists_closePair_sector` (`Plane/SectorPoint`) — `[propext, Classical.choice, Quot.sound]`. *A
  weak six-colouring of an open set with a close complementary pair of sector points and a common unit point in the
  set.* Witness: `squarePair` again.

None of the five takes an assumption: no declared outside theorem, no hypothesis standing for a hand result.

**Every record of this phase** — 121 theorems (113 written in `Plane/ClosePairWitness`, 3 that Lean generated there on
demand — `planeMotion.congr_simp`, `labLo.congr_simp`, `labHi.congr_simp` —, the 5 leaves above) and 9 definitions of
`Plane/ClosePairWitness` that hold proofs (`planeMotion`, `ThreePiece.transport`, `labLo`, `labHi`, `threeDiscPair`,
`sevenPair`, `lonePair`, `splitPoint`, `squarePair`), each [kernel] on a branch:
- on `[propext, Classical.choice, Quot.sound]`: 126 records — all but the three below;
- on `[propext]`: `labHi_injective`;
- on no axiom: `labHi`, `labHi.congr_simp`.

The theorems of `Plane/ClosePairWitness` that carry the content: the transport (`ThreePiece.transport`;
`ThreePiece.separatesAt_iff_of_image`, `oneOfEach_iff_of_image`, `edge_eq_image`, `HasArcEdges.of_image`); the three
discs (`threeDisc_aeProperOn`, `threeDiscPair`, `isWeakColouringOn_pairCol`); the control (`sevenPair`,
`isWeakColouringOn_sevenCol`, `sevenPair_left_not_separatesAt`, `sevenPair_right_not_separatesAt`,
`sectorPoint_not_separatesAt_one`, `sectorPoint_not_separatesAt_neg_I`); the lone witness (`lonePair`,
`isWeakColouringOn_loneCol`, `lonePair_right_not_separatesAt`, `petal_inner_lt`, `petal_outer_gt`); the split point
(`splitPoint`, `isPreconnected_splitOuter`, `splitPoint_hasArcEdges`, `splitPoint_oneOfEach`); the unit-square witness
(`squarePair`, `isWeakColouringOn_squareCol`, `split_inner_lt`, `split_outer_gt`, `squarePair_left_hasArcEdges`,
`squarePair_right_hasArcEdges`, `squarePair_left_oneOfEach`, `squarePair_right_oneOfEach`); the sector point from
three arcs (`ThreePiece.ArcCut`, `ThreePiece.exists_eq_connectedComponentIn`, `ThreePiece.ArcCut.sector`,
`ThreePiece.ArcCut.of_image`, `ThreePiece.arcCut_of_radii`, `sectorPoint_arcCut`, `splitPoint_arcCut`,
`squarePair_left_arcCut`, `squarePair_right_arcCut`).

**Not proved, and not this job's**: `ThreePiece.IsSector.hasArcEdges` (the θ-leaf) stays `sorry`; over it
`ThreePiece.IsSector.isFull` and `closePair_both_saved_of_isSector` print `sorryAx`. **No leaf of this job is left
`sorry`.**

## Stage 1 — SAVED (FS124-I4): the readback, the build as given, the statements dumped, the witnesses sampled

**The brief's quotations against their sources.** `data/fs124/i4/readback.py <brief>` (the earlier implementers' script,
copied unchanged): **14 of 14 found** (`data/fs124/i4/logs/readback.txt`, exit 0). Control (`--control`, one letter's case
changed in each quotation): none found, as it must be (`logs/readback-control.txt`, exit 0).

**Read whole**: the brief; `plans/STANDING-RULES.md`; `LEAN.md`; `RUNNING.md` § Building and § Make the gate fail, and watch
it fail; the planner's record § 2.5, § 3.2's last two tables, § 4.4, § 4.6, Stage 5; `data/fs124/k2/square_model_check.py`;
my two files; `Plane/ThreePiece` and `Plane/ClosePair` whole, of `Plane/OnePiece` the definitions and the model, of
`Plane/WeakColouringOn` the definitions and `aeProperOn_of_proper_off_null`; the last implementer's record, Stages 1–3.

**The build as given**: `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the
worktree, exit 0 — `build: OK — all 1853 modules already up to date, nothing built, 2 module(s) with warnings, 2s`
(`data/fs124/i4/logs/build-0-as-given-full.log`, `build-0-as-given.exit`). **6 `declaration uses sorry` warnings and no
other**: 3 in `Plane/ClosePairModel`, 3 in `Plane/SectorPoint` — the brief's count.

**The statements before any proof** (for the comparison after each stage). The check is the last implementer's, copied
and re-aimed (`data/fs124/i4/statement_diff.py`), with one change of method, said here: the first dump is not read from a
build. It is the base commit's text of each module (`git show fb515b25a:<file>`), elaborated now with
`data/fs124/i4/lean/DumpTail.lean.txt` appended, which prints every constant that text declares as the kernel holds it:
`data/fs124/i4/statements-before.txt`, 9 constants (3 theorems of `Plane/ClosePairModel`; 5 theorems and the definition
`ThreePiece.IsSector` of `Plane/SectorPoint`). The second dump is `data/fs124/i4/lean/StatementDump.lean` on the built
modules. What the method does not see is what the copied one did not: a docstring, a comment, an `example` moved past
one of identical head.

**The witnesses, sampled before any Lean** (`data/fs124/i4/witness_check.py`; floats; an instrument, not a proof — the
formulas as this job formalizes them, which are not the planner's: Stage 2 and Stage 3 say why):
`lone: unit-pairs-sampled=875190 monochromatic=0`, `square: unit-pairs-sampled=875281 monochromatic=0`, and the two
inequalities of the unit-square witness on 118,695 and 145,657 sampled cases with no violation (least slack `1.5e-3`,
`2.8e-3`) — `logs/witness-check.txt`. With the fault planted (`--fault`: two labels exchanged near `w`; for the
inequalities the hypothesis `Im t ≤ 0` dropped): 74,648 and 53,387 monochromatic pairs, 1,384 and 1,322 violations
(`logs/witness-check-fault.txt`).

**How I iterate** (never evidence): `data/fs124/i4/lean1.sh <file>` — `lake env lean -DautoImplicit=false
-DrelaxedAutoImplicit=false -Dlinter.missingDocs=true` against this worktree's build. New text for the helper module is
written as part files under `data/fs124/i4/lean/` and checked in a scratch file made of the module plus the parts
(`data/fs124/i4/assemble.py`); nothing under `Proofs/` is edited while a build runs.

**A slip of order, disclosed.** Standing rule 2 asks that a stage be committed before the next starts. This stage's
commit was made after Stage 2's work was in the tree (the two commits follow one another, each by explicit path); a
halt between them would have cost both stages' work. Nothing was lost.

## Stage 2 — SAVED (FS124-I4): the seven-colour control and the lone witness, in the build

**In the build**: the same command, exit 0 — `build: OK — 477 of 477 batches, 3 module(s) rebuilt, 2 module(s) with
warnings, 8m54s` (`data/fs124/i4/logs/build-1-two-witnesses-full.log`, `.exit`; the tool's full output,
`build-1-two-witnesses-gate.log`). Rebuilt: `Plane/ClosePairWitness` (new), `Plane/ClosePairModel`, `Proofs`. The full
output holds **4 distinct `declaration uses sorry` warnings and no other warning**: `exists_closePair_full`
(`Plane/ClosePairModel`, line 42) and the three of `Plane/SectorPoint`; its one line with the word `error` is the
up-to-date probe (line 3).

**Axioms, printed from that build** (`data/fs124/i4/lean/PrintStage2.lean`, output `logs/axioms-stage2.txt`):

```
'HadwigerNelson.Plane.exists_closePair_seven_not_separatesAt' depends on axioms: [propext, Classical.choice, Quot.sound]
'HadwigerNelson.Plane.exists_closePair_not_separatesAt' depends on axioms: [propext, Classical.choice, Quot.sound]
```

and so `sevenPair`, `lonePair`, `isWeakColouringOn_sevenCol`, `isWeakColouringOn_loneCol`. **The control fired**:
`exists_closePair_full`, still `sorry` at this stage, prints `sorryAx`.

**No statement and no definition changed**: `statements-after-1.txt` (the dump on this build) against
`statements-before.txt`, and the `example` heads as text against `fb515b25a` — **9 named constants compared, 3 example
heads, no difference, no new named constant in the two modules** (`logs/statement-diff-1.txt`, exit 0). Control: one
stored statement, the definition `ThreePiece.IsSector` and one example's head changed in the second input — 3 of 3
reported (`logs/statement-diff-1-control.txt`).

### 2.1 The frame, and why it is not the planner's letter

All three witnesses stand in one frame: **`x = 0`, `w = 1`, `y = T 0` for a rigid motion `T z = y + u z`**, on
`threeDisc y` — three discs of radius `1/4` about `0`, `1`, `y`. A disc of radius `1/4` holds no unit pair, the discs
about `0` and `y` carry the labels `0, 1, 2` and `3, 4, 5`, so the colouring is proper as soon as the disc about `1` is
separated from the other two (`threeDisc_aeProperOn`, `isWeakColouringOn_pairCol`). The pair is built once, for any two
decompositions at `0` of colourings of the disc of radius `1/4` (`threeDiscPair`): the first as it stands, the second
moved by `T` (`ThreePiece.transport`: a decomposition moved by a homeomorphism whose inverse preserves Lebesgue measure,
relabelled injectively). The kinds of the moved pieces at `T w₀` are the kinds at `w₀`
(`ThreePiece.separatesAt_iff_of_image`, `oneOfEach_iff_of_image`), and arc edges move with the pieces
(`ThreePiece.HasArcEdges.of_image`).

- **The seven-colour control** is the planner's construction: two ordinary three-sector points (`sectorPoint` at `0`;
  `sectorPoint` translated to `1 + i`), the label `6` on the disc about `1` (`sevenCol`, `sevenPair`). Neither separates
  at `1`: each sector has a point strictly outside the unit circle about `1`, and about `−i`
  (`sectorPoint_not_separatesAt_one`, `sectorPoint_not_separatesAt_neg_I`; `1 = (1 + i) + (−i)`).
- **The lone witness is the planner's construction with the last implementer's `petalPoint` in place of "a petal, a
  sector away, the rest"** (`loneCol`, `lonePair`): the planned route did not fail — `petalPoint` was already a proved
  decomposition, and its two petals are inner and outer at `1` and meet at `0` only, which is what `closePair_lone`
  concludes. At `0`: the right petal (label `1`), the left petal (label `2`), the sea (label `0`); near `1`: the label
  `1` inside the unit circle about `0` and `2` elsewhere; at `1 + i` an ordinary three-sector point, which does not
  separate at `1`. Properness is the planner's two crude inequalities, each a real-variable lemma: a point near `1`
  inside `S(0)` is less than `1` from the right petal (`petal_inner_lt`), one not inside it is more than `1` from the
  left petal (`petal_outer_gt`).

### 2.2 The leaves

| leaf | route | lines |
|---|---|---|
| `exists_closePair_seven_not_separatesAt` | the tuple `sevenPair`, `isWeakColouringOn_sevenCol`, the two non-separations | 2 (its section of the helper: 40) |
| `exists_closePair_not_separatesAt` | the tuple `lonePair`, `isWeakColouringOn_loneCol`, `lonePair_right_not_separatesAt` | 2 (its section of the helper: 85) |

The shared part of `Plane/ClosePairWitness` — the motions, the transport, the three discs, the pair, distances in
coordinates, the frame — is 510 lines and serves the third witness too.

**Attempts.** One repair round of the transport's API: the lemmas were first stated on the term
`D.transport T hT f hf hx hU hc` and could not be applied to `(threeDiscPair …).right` with the proof arguments left
to unification — proofs unify by proof irrelevance and assign nothing. They are now stated for any two decompositions
the pieces of one of which are the images of the pieces of the other, which is also the more general statement. Three
smaller repairs (an `if` over `dist` rewritten by membership in a ball; a rewrite of `y` that took every occurrence; a
composition under a binder). No companion was dispatched.

**Touched beyond the letter of the brief's list, each necessary and each one line**: an `import` of the new module in
`Plane/ClosePairModel` (the existing import line kept); in `ARCHITECTURE.md`, besides the new module's whole line, the
imports cell of `Plane/ClosePairModel`'s row (the map checker reads the import graph). `Proofs.lean`: one whole new
line. `tools/check_architecture.py`: `RESULT: PASS` (`logs/check-architecture-1.txt`).

**Helper names** — 68 declared by `Plane/ClosePairWitness` at this stage; each looked for as a declaration under the
same full name in `Proofs/` of `main` and of all 75 worktrees (`data/fs124/i4/name_clash.py`, a text scan:
`logs/name-clash-2.txt`, PASS; its control adds a name `Plane/ThreePiece` declares). `scripts/dupnames.sh` on the built
tree is run at the last stage.

**The price of the third witness, measured from its first inequality** (the brief's item 3). The first inequality
(`split_inner_lt`: `z` near `1` inside `S(0)` and outside `S(1 + i)`, `t` near `0` inside `S(1)` and not above the real
axis, are less than `1` apart) is 30 lines and elaborated on its first `lean` run; the second (`split_outer_gt`) is 35
lines and took two attempts — the first, one `nlinarith` per case, exhausted its heartbeats; the second states each
product as a `have` and closes each case with `linarith only`. With them the whole third witness is written and
elaborates in a scratch file (`data/fs124/i4/lean/part-split.lean.txt`, `part-square.lean.txt`: 608 lines; `lean` runs
only, not a build, not evidence): **about 610 lines against the plan's 500 to 700, and I go on.** The witness is **not
the planner's unit square to the letter**: at `x = 0` the third piece is the half-disc above the real axis, not the
inside of the unit circle about `i` — one non-convex piece per member in place of two, and two inequalities in place
of the lens duality and its cusp; the members' edges are two real radii and an arc of `S(w)`, not three arcs of unit
circles. Stage 3 states it.

## Stage 3 — SAVED (FS124-I4): the third witness, in the build — `Plane/ClosePairModel` holds no `sorry`

**In the build**: the same command, exit 0 — `build: OK — 477 of 477 batches, 3 module(s) rebuilt, 1 module(s) with
warnings, 9m10s` (`data/fs124/i4/logs/build-2-third-witness-full.log`, `.exit`; the tool's full output,
`build-2-third-witness-gate.log`). The full output holds **3 distinct `declaration uses sorry` warnings — the three of
`Plane/SectorPoint` — and no other warning** (its one line with the word `error` is the up-to-date probe, line 3).
**`Plane/ClosePairModel`: its three leaves are proved.**

**Axioms, printed from that build** (`data/fs124/i4/lean/PrintStage3.lean`, output `logs/axioms-stage3.txt`):

```
'HadwigerNelson.Plane.exists_closePair_seven_not_separatesAt' depends on axioms: [propext, Classical.choice, Quot.sound]
'HadwigerNelson.Plane.exists_closePair_not_separatesAt' depends on axioms: [propext, Classical.choice, Quot.sound]
'HadwigerNelson.Plane.exists_closePair_full' depends on axioms: [propext, Classical.choice, Quot.sound]
```

and so `squarePair`, `isWeakColouringOn_squareCol`, `splitPoint`, `split_inner_lt`, `split_outer_gt`. **The control
fired**: `exists_closePair_sector`, still `sorry` at this stage, prints `sorryAx`.

**No statement and no definition changed**: `statements-after-2.txt` against `statements-before.txt` and the base
commit — 9 named constants, 3 example heads, no difference (`logs/statement-diff-2.txt`, exit 0); control, 3 of 3
planted faults reported (`logs/statement-diff-2-control.txt`). `tools/check_architecture.py`: `RESULT: PASS`
(`logs/check-architecture-2.txt`).

### 3.1 The witness: the planner's unit square with a straight cut (kept, by the coordinator's reply to this job's stage-2 message)

`squarePair`, of `squareCol`, on `threeDisc (1 − i)`: `x = 0`, `w = 1`, `y = 1 − i`.

- **At `0`, the split point** (`splitPoint`, of `splitCol`): the half-disc above the real axis (label `2`), and the
  half-disc below it cut by the unit circle about `1` — inside (label `0`), outside (label `1`). Its edges are the
  radius along `1` (pieces `0`, `2`), the radius along `−1` (pieces `1`, `2`) and the lower arc of `S(1)` (pieces `0`,
  `1`): `splitPoint_hasArcEdges`. At `1`: piece `0` inner, piece `1` outer, piece `2` crossing
  (`splitPoint_oneOfEach`, the permutation the identity).
- **At `1 − i`, the split point turned by a quarter about `1`** (`T z = (1 − i) + i z`, which fixes `1`): the same
  kinds at `1` and arc edges, by the transport lemmas.
- **Near `1`**, the four regions cut by `S(0)` and `S(1 − i)`: label `0` inside both, `4` inside `S(0)` only, `3`
  inside `S(1 − i)` only, `1` inside neither (`squareW`) — the labels of the two inner and the two outer pieces, as
  `closePair_four` says they must be.
- **Properness** off the null set of the three unit circles about `0`, `1`, `1 − i` (`aeProperOn_of_proper_off_null`):
  a pair of labels `0`, `0` is excluded by `split_inner_lt`, a pair `1`, `1` by `split_outer_gt`; a pair `3`, `3` or
  `4`, `4` is one of those turned back by the quarter (`quarterTurn_symm_zero`, `_one`, `_right`), where "inside
  `S(1 − i)`" reads "outside `S(1 + i)`" and conversely (`one_lt_dist_of_dist_lt_one`: the two discs touch at `1`).

**What differs from the planner's § 2.5**: the third piece at `x` is the half-disc `Im z > 0`, not the inside of the
unit circle about `i`. With it one piece per member is non-convex (the outer one: `isPreconnected_splitOuter`, by
horizontal segments to the mirror image in the imaginary axis) instead of two, and the two inequalities need only the
sign of `Im t`: below the axis the two ordinates have one sign; what is left is one thin sliver each, where being
outside the tangent circle gives `b < (1 − a)²`. The planner's sampled check does not cover this witness; mine does
(Stage 1).

### 3.2 The leaves

| leaf | route | lines |
|---|---|---|
| `exists_closePair_full` | the tuple `squarePair`, `isWeakColouringOn_squareCol`, the two arc-edge lemmas, the two `OneOfEach` | 3 |
| its section of `Plane/ClosePairWitness` | the split point (343 lines: the three sets, their closures, the outer piece connected, the null clause, the decomposition, the arc, arc edges, the kinds at `1`); the two inequalities and the frame (265 lines) | 608 |

**Attempts.** `split_inner_lt`: first run. `split_outer_gt`: second (Stage 2). The split point: three errors on its
first run (a `by … ;` broken across two lines; a `simp` normal form of a cast under `.re`; an unused `simp`
argument), none on its second. The assembly: one repair (a rewrite of `1` that took every occurrence). No planned
route failed in a way that needed a companion; nothing was dispatched.

**The price, as measured**: 608 lines for the third witness against the plan's 500 to 700; with the shared part (510)
and the first two witnesses (125), `Plane/ClosePairWitness` stands at 1,251 lines and `Plane/ClosePairModel`'s three
proofs at 7. Three builds of about nine minutes; the work between them in `lean` runs of a few seconds.

## Stage 4 — SAVED (FS124-I4): the two leaves of `Plane/SectorPoint`; every record's axioms printed; the closing checks; the read-aloud; the drafts

### 4.1 The two leaves, the build, the checks

**In the build**: the same command, exit 0 — `build: OK — 478 of 478 batches, 4 module(s) rebuilt, 1 module(s) with
warnings, 9m14s` (`data/fs124/i4/logs/build-3-sector-full.log`, `.exit`; the tool's full output,
`build-3-sector-gate.log`). Rebuilt: `Plane/ClosePairWitness`, `Plane/SectorPoint`, `Plane/ClosePairModel`, `Proofs`.
The full output holds **one `declaration uses sorry` warning — `Plane/SectorPoint`, line 52, the θ-leaf
`ThreePiece.IsSector.hasArcEdges` — and no other warning** (its one line with the word `error` is the up-to-date
probe, line 3). This is the build of the files as committed at this stage.

| leaf | route | lines |
|---|---|---|
| `sectorPoint_isSector` | the planner's route, through one general statement: three arcs given by their distance from `0` (`ThreePiece.arcCut_of_radii`) at the radii `ρ ↦ ρ d`, `d = 1, i, (−1 − i)/√2` (`sectorPoint_arcCut`); each piece is a component because three disjoint open connected sets that fill a set are its components (`ThreePiece.exists_eq_connectedComponentIn`, by `IsPreconnected.subset_connectedComponentIn` and `IsPreconnected.subset_left_of_subset_union`) | 2 in the module; 95 for `sectorPoint_arcCut` |
| `exists_closePair_sector` | `squarePair` again: the split point is cut out of its disc by the radii along `1` and `−1` and the lower arc of `S(1)`, each parametrized by its distance from `0` (`splitPoint_arcCut`); the cut moves with the pieces under an isometry (`ThreePiece.ArcCut.of_image`) | 5 in the module; 95 for `splitPoint_arcCut` |

The sector part of `Plane/ClosePairWitness` is 383 lines (the plan: about 80 and about 150 beyond the third witness)
and elaborated on its first `lean` run, one deprecation apart (`Set.image_diff`, now `Set.image_sdiff`).

**Why `ThreePiece.ArcCut` exists.** `ThreePiece.IsSector` is defined in `Plane/SectorPoint`, downstream of where the
witness can live, and in that module I write two proofs only. So the helper states, IsSector-free: `ArcCut D r J` (the
five clauses on the arcs and the union clause) and `ArcCut.sector`, whose conclusion is the body of
`ThreePiece.IsSector` written out; the two proofs in `Plane/SectorPoint` are `exact hJ.sector _`, which the kernel
accepts only if the written-out statement is that definition's body. A change to the definition would break the two
proofs, not pass them.

**Axioms of every record, printed from that build**: `data/fs124/i4/make_audit.py` (from
`data/fs124/i4/audit-dump.txt`, every constant the three modules store) writes the block and the scratch file
`data/fs124/i4/lean/PrintAxioms.lean`; its output is `data/fs124/i4/axioms.txt`, read by
`data/fs124/i4/read_axioms.py` (`logs/read-axioms.txt`, exit 0): **asked 135 (130 records, 5 controls), printed 135;
128 records with axioms and 2 axiom-free, all within the standard three; controls fired 5 of 5** — two theorems
planted on `sorry` in the scratch file, and the three records of `Plane/SectorPoint` that rest on the θ-leaf
(`ThreePiece.IsSector.hasArcEdges`, `.isFull`, `closePair_both_saved_of_isSector`), each printing `sorryAx`.

**No statement and no definition changed**: `statements-after-3.txt` against `statements-before.txt` and the base
commit — **9 named constants compared, 3 example heads, no difference; no new named constant in the two modules; 1 new
example** (`logs/statement-diff-3.txt`, exit 0); control, 3 of 3 (`logs/statement-diff-3-control.txt`). `git diff
fb515b25a` on `Plane/SectorPoint`: one added import line, two `sorry` lines replaced by proofs, nothing else. On
`Plane/ClosePairModel`: one added import line, three `sorry` lines replaced, one added example, and the module
docstring's description of the witnesses reworded to the witnesses as built.

**One spec example added, not in the skeleton** (`Plane/ClosePairModel`; it changes no statement; the landing may drop
it): the control read through `ClosePair.separatesAt_or` — some weak seven-colouring has a close complementary pair for
which "every label is the label of a piece of `x` or of `y`" fails. It is the contrapositive of the general theorem
run on the control, so the kernel holds the sentence of § 4.3's last paragraph and not only the model.

**The closing checks** (brief, item 6): `tools/check_architecture.py` — `RESULT: PASS`, exit 0
(`logs/check-architecture-4.txt`); `./scripts/dupnames.sh` on the built tree — `OK — no name is declared by two
modules`, exit 0 (`logs/dupnames.txt`), and `--self-test` — 15 of 15 controls (`logs/dupnames-selftest.txt`); the text
scan of every tree for a second declaration of one of the helper's 136 declared names — none in 76 trees
(`logs/name-clash-4.txt`; its control finds the planted name and no other, `logs/name-clash-4-control.txt`). As a
probe, not asked: the environment linters on the built tree, exit 0, 14 of 14 passed, `-- Linting passed for Proofs.`
(`logs/lint.txt`). **Not run, by the brief**: the full gate (`scripts/axioms.sh`, `vacuity.sh`, `assumptions.sh`); no
merge of `main`; `scripts/Axioms.lean` and `scripts/Assumptions.lean` untouched.

**The audit block, as a file**: `data/fs124/i4/audit-block.txt` — 130 `#print axioms` lines under one header, for the
CLEAN section of `scripts/Axioms.lean` at the landing.

### 4.2 The price, as measured

| | planned (§ 3.2 of the plan) | measured |
|---|---|---|
| the control | about 120 lines | 40 in its section, over a shared part of 510 |
| the lone witness | about 250 | 85 in its section (it reuses `petalPoint`) |
| the unit-square witness | 500 to 700 | 608 |
| the two leaves of `Plane/SectorPoint` | about 80 and about 150 | 383 together |
| in all | 900 to 1,100 for the models, 230 for the sector leaves | `Plane/ClosePairWitness` 1,634 lines; 7 lines of proof in `Plane/ClosePairModel`, 7 in `Plane/SectorPoint` |

Four compiling builds of about nine minutes each (and the as-given one, which built nothing); the rest in `lean` runs
of a few seconds. Attempts: one leaf took two (`split_outer_gt`); one design was repaired once (the transport's API,
Stage 2); nothing reached three, nothing was dispatched to a companion. Working time: about an hour — the as-given
build at 18:18 UTC, the last check at 19:12 UTC.

### 4.3 The read-aloud: each witness against the hypotheses of the theorem it inhabits

**`closePair_forced_pieces`** — `(hU : IsOpen U) (hc : IsWeakColouringOn U c) (C : ClosePair U c x y) (hw : w ∈ U)
(hwu : IsCommonUnitPoint x y w)`, at `c : ℂ → Fin 6`. On `lonePair` (`exists_closePair_not_separatesAt`):

| hypothesis | on the witness |
|---|---|
| `IsOpen U` | `U = threeDisc (1 + i)`, three open discs (`isOpen_threeDisc`) |
| `IsWeakColouringOn U c` | `c = loneCol`: measurable (three measurable parts glued on two discs), and proper at **every** unit pair of `U` — within one disc there is none, the discs about `0` and `1 + i` carry `{0, 1, 2}` and `{3, 4, 5}`, the disc about `1` carries `{1, 2}`, and its pairs with the disc about `0` are separated by `petal_inner_lt`, `petal_outer_gt` (`isWeakColouringOn_loneCol`) |
| `ClosePair U c x y` | `lonePair`: at `x = 0` the petal point with labels `0, 1, 2`; at `y = 1 + i` the three-sector point translated, labels `3, 4, 5`; `0 ≠ 1 + i`; `|x − y| = √2 < 2`; no label shared |
| `w ∈ U` | `w = 1`, the centre of the middle disc |
| `IsCommonUnitPoint x y w` | `|1 − 0| = 1 = |1 − (1 + i)|` (`isCommonUnitPoint_zero_one_add_I`) |

The same five hold of `squarePair`. On `lonePair` the conclusion can only be the first disjunct, since `y` does not
separate; by hand, the inner piece is the right petal and the outer one the left petal.

**`closePair_lone`** — the five above and `(hy : ¬ C.right.SeparatesAt w)`: `lonePair_right_not_separatesAt` — each
of the three sectors at `1 + i` has a point strictly outside the unit circle about `1`, so no piece of `y` is inner.
All six hold at once of `lonePair`, and the module's first spec example runs the theorem on it. The model is not
degenerate for the conclusion: its inner and outer pieces are the two petals, whose closures meet at `0` only
(`petalPoint_edge`).

**`closePair_both_separate`** — the five and `(hfx : C.left.IsFull) (hfy : C.right.IsFull)`. On `squarePair`
(`exists_closePair_full`): `U = threeDisc (1 − i)` open; `c = squareCol` measurable and proper at every unit pair of
`U` off the three unit circles about `0`, `1`, `1 − i`, a null set (`isWeakColouringOn_squareCol`, by
`split_inner_lt` and `split_outer_gt`, each once as it stands and once turned by the quarter about `1`); the pair is
the split point at `0` and the split point turned at `1 − i`, labels `0, 1, 2` and `3, 4, 5`, `|x − y| = √2`; `w = 1`;
`|1 − 0| = 1 = |1 − (1 − i)|`. Fullness: both members have arc edges (`squarePair_left_hasArcEdges`,
`squarePair_right_hasArcEdges`), and an arc-edged decomposition is full (`ThreePiece.HasArcEdges.isFull`).

**`closePair_both_saved`** — the five and `(hax : C.left.HasArcEdges) (hay : C.right.HasArcEdges)`: the two lemmas
just named. At `0` the three arcs are the radius along `1` (pieces `0`, `2`), the radius along `−1` (pieces `1`, `2`)
and the lower arc of the unit circle about `1` (pieces `0`, `1`); at `1 − i` their images under the quarter turn.

**`closePair_four`** — the five, the two fullness hypotheses, and `(hσ : C.left.OneOfEach w σ) (hτ : C.right.OneOfEach
w τ)`: `squarePair_left_oneOfEach`, `squarePair_right_oneOfEach`, with `σ = τ` the identity — piece `0` inner at `1`
(it lies inside `S(1)`), piece `1` outer (it lies outside), piece `2` crossing (the points `(1/10, 1/10)` and
`(−1/10, 1/10)` of the upper half-disc). All nine hold at once of `squarePair`; the module's spec examples run
`closePair_four`, `closePair_both_separate` and `closePair_both_saved` on it. The conclusion on the model: the labels
present at `1` are `0, 1, 3, 4`, which are the four labels `squareW` gives the four regions.

**`closePair_both_saved_of_isSector`** (`Plane/SectorPoint`; itself over the θ-leaf) — the five and `(hsx :
C.left.IsSector) (hsy : C.right.IsSector)`: `exists_closePair_sector`, on `squarePair`. **The members of the
unit-square witness are sector points in the claim list's sense**, with `r = 1/4` and, as the three arcs, at `0` the
radius along `1`, the radius along `−1` and the lower arc of the unit circle about `1` from `0` to the circle of
radius `1/4`, and at `1 − i` their images under the quarter turn about `1` (`squarePair_left_arcCut`,
`squarePair_right_arcCut`, `ThreePiece.ArcCut.sector`).

**No hypothesis of the five theorems is left without a model**: every binder above is named with the fact that
discharges it, on one object per theorem, all at once. What the witnesses are not: maps of the plane, or fragments of
one — each is a colouring of three discs of radius `1/4`, and nothing here says that a colouring of the plane has such
a pair.

**The seven-colour control, and the sentence it shows cannot be dropped.** `sevenPair`
(`exists_closePair_seven_not_separatesAt`) satisfies every hypothesis of `ClosePair.separatesAt_or` — the statement of
C124-FORCED-PIECES at any label type — but one: its set is open, `sevenCol` is a weak colouring (the disc about `1`
has the seventh label, so no inequality is needed), the pair is two ordinary three-sector points with six different
labels at distance `√2`, `1` is a common unit point in the set. Its conclusion fails: neither member separates at `1`.
The hypothesis that fails is `hcover` — *"every label is the label of a piece of `x` or of a piece of `y`"* — which at
six colours is `ClosePair.exists_label_eq`, "six distinct labels among six", the one line where the six-colour proof
spends the number six. The label `6` is the label of no piece; it fills a neighbourhood of `w`, so nothing forces a
piece of either member onto a side of `S(w)`. The added spec example states it through the theorem.

### 4.4 Slips, disclosed

- Stage 1's commit was made after Stage 2's work was in the tree (Stage 1).
- The stage-4 build was started in the same command as a scratch check of the added example, not gated on it; the
  check had passed, and the build is the evidence either way.
- My first name scan read every file of 76 trees in Python and took four and a half minutes per run; the second
  prefilters with ripgrep and takes nine seconds. Both logs are kept.

### 4.5 Drafts for the landing (each names its slot; none is written by this job)

1. **`scripts/Axioms.lean`, CLEAN section**: `data/fs124/i4/audit-block.txt`, whole — 130 records. The three other
   records of `Plane/SectorPoint` join when the θ-leaf is proved.
2. **`Proofs/HadwigerNelson/Plane/ClosePair.lean`, docstring of `closePair_both_saved`, its last sentence** — replace
   "Inhabitant of the hypotheses: `exists_closePair_full` (`Plane/ClosePairModel`), whose members' edges are arcs of
   unit circles by construction." by: "Inhabitant of the hypotheses: `exists_closePair_full` (`Plane/ClosePairModel`),
   whose members' edges are two radii and an arc of the unit circle about the common unit point, by construction
   (`squarePair`, `Plane/ClosePairWitness`)."
3. **The same file, module docstring, the paragraph "Inhabitants"**: it stands as written; if the landing wants the
   objects named, append "— constructed in `Plane/ClosePairWitness` (`lonePair`, `squarePair`; the control,
   `sevenPair`)."
4. **The five claims' docstring notes** ("Inhabitant of the hypotheses: …" in `closePair_forced_pieces`,
   `closePair_lone`, `closePair_both_separate`, `closePair_both_saved`, `closePair_four`): **no witness is missing; the
   notes stand**, each naming a theorem that is now proved. `closePair_both_saved_of_isSector`'s note
   (`exists_closePair_sector`) stands too.
5. **`plans/FS124-kernel-plan-2.md` § 3.2, the row of `exists_closePair_sector`**, a dated note beside "the
   unit-square witness again, its pieces as the components of a disc cut along three arcs of unit circles": "as built
   (FS124-I4): cut along two radii and one arc of the unit circle about the common unit point
   (`squarePair_left_arcCut`, `squarePair_right_arcCut`)". And § 2.5, beside "The witness I planned" for BOTH and FOUR:
   "as built: the third piece at `x` is the half-disc above the real axis, not the inside of `S(i)`
   (`plans/FS124-I4-implementation.md` § 3.1)."
6. **`ARCHITECTURE.md` § 3, the rows of `Plane/ClosePairModel` and `Plane/SectorPoint`**: their words "a skeleton on
   branch `fs124-wk2`" are the planner's; at the landing: for `Plane/ClosePairModel`, "its three leaves proved
   (FS124-I4)"; for `Plane/SectorPoint`, "its two model leaves proved (FS124-I4); the θ-leaf owed". This job changed
   only their imports cells and added the row of `Plane/ClosePairWitness`.
7. **`LEAN.md` § Searching — Lean**, three lines:
   - "A lemma stated on a term built with proof arguments (`D.transport T hT f hf hx hU hc`) cannot be applied with
     those arguments left to unification: proofs unify by proof irrelevance and assign nothing ('don't know how to
     synthesize placeholder'). State it for any object whose data fields are the images (`hp : ∀ i, D'.piece i =
     T '' D.piece i`) and discharge the hypothesis by `rfl` (`ThreePiece.separatesAt_iff_of_image`, FS124-I4)."
   - "`linarith` multiplies out products of atoms (its preprocessing is polynomial arithmetic over monomials): a
     nonlinear inequality whose certificate is a few products of hypotheses is closed at once by stating each product
     as a `have` (`mul_pos`, `mul_nonneg`) and `linarith only […]`, where one `nlinarith` per case exhausts its
     heartbeats (`split_outer_gt`, FS124-I4)."
   - "At the pin `Set.image_diff` is deprecated: `Set.image_sdiff`. A definition living downstream of where its models
     can be built is met by a theorem upstream whose conclusion is the definition's body written out, and `exact` in
     the downstream proof (`ThreePiece.ArcCut.sector` for `ThreePiece.IsSector`, FS124-I4)."

## Drafts for the front page

*Each names its slot. This job did not run the gate (the brief, item 6): the counts are the landing's.*

- **`CLAUDE.md` § The gate and § Trust ledger, the counts**: not computed here. What this job adds to them when the
  module lands: 130 records, all CLEAN (no purchase, no import); no hypothesis standing for an outside theorem, a hand
  result or an open question; one new module of 136 declared names.
- **`CLAUDE.md` § Paths forward, Open milestones, the sentence on FS-124's second module** (it now reads "its second
  is being planned") — draft: "its second module — the close pair: C124-FORCED-PIECES, -LONE, -BOTH, -FOUR — is
  complete on branch `fs124-wi3` but for one leaf: the four statement modules, the witnesses' module and the models'
  module hold no `sorry` (kernel-checked on a branch, not through the gate), the hypotheses of the four claims'
  theorems are inhabited by colourings given by formula (`exists_closePair_not_separatesAt`, `exists_closePair_full`,
  `exists_closePair_sector`), the control at seven is in the kernel (`exists_closePair_seven_not_separatesAt`), and
  `Plane/SectorPoint` holds the θ-leaf `ThreePiece.IsSector.hasArcEdges`, owed."
- **`LEDGER.md`, row 163, at the landing** (the row FS-124 filed for the close pair; its regrade is the landing's and
  rests on the earlier implementers' theorems) — the sentence this job contributes: "Hypotheses inhabited in the
  kernel: `Plane.exists_closePair_not_separatesAt` (one member alone), `Plane.exists_closePair_full` (both arc-edged,
  one piece of each kind), `Plane.exists_closePair_sector` (both sector points); the number six is needed:
  `Plane.exists_closePair_seven_not_separatesAt`. No assumption." C124-BOTH's second clause in the list's words stays
  at its GAP until the θ-leaf lands (ruling (a) of inventory item 42).
- **The Frontier line** — no change of state by this job alone: a branch, not a landing. At the landing: "the close
  pair's four claims [kernel], their hypotheses inhabited".
- **The Proof Atlas** — at the landing, the nodes of C124-FORCED-PIECES, -LONE, -BOTH (first clause; second clause for
  arc-edged decompositions) and -FOUR move from [hand] to [kernel], each with its inhabitant named; C124-BOTH's
  second clause for sector points stays [hand] at one step. Nothing moves before the landing.

## The build as committed, and the report (added with the report's commit)

After Stage 4's commit (`99e179aaf`) the same build command, on the tree as committed: exit 0 — `build: OK — all 1854
modules already up to date, nothing built, 1 module(s) with warnings, 2s`; the one warning is the θ-leaf
(`data/fs124/i4/logs/build-4-as-committed.log`). The report: `data/fs124/reports/FS124-I4.md`.

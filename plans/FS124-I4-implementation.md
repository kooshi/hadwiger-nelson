# FS-124 — the witnesses: three colourings by formula that inhabit the close-pair theorems (job FS124-I4)

*De Bruijn, the implementer. Brief: `data/fs124/briefs/FS124-I4-witnesses.md` (on `main`). Skeleton and plan: the planner's,
`plans/FS124-kernel-plan-2.md` on this branch (`fs124-wi3`, at `fb515b25a` when this job began). Files of this job:
`Proofs/HadwigerNelson/Plane/ClosePairWitness.lean` (new: the witnesses, constructed),
`Proofs/HadwigerNelson/Plane/ClosePairModel.lean` (the three existence proofs), and in
`Proofs/HadwigerNelson/Plane/SectorPoint.lean` the proofs of `sectorPoint_isSector` and `exists_closePair_sector`. No
statement and no definition of the skeleton is changed. Working files: `data/fs124/i4/`. The record is written in stages.*

## Theorems this phase proved

On branch `fs124-wi3` only: **kernel-checked on a branch, not through the gate.** Axioms as printed from the build named
in each stage. (Completed at the last stage; until then the stages below are the list.)

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

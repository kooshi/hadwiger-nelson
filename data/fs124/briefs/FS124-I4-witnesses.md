# Brief FS124-I4 — the witnesses: three colourings by formula that show the pair theorems are about something, on `fs124-wi3`

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), at Kooshi's word of this morning. Launch line: "Your brief is on disk: read it in full first."*

brief: FS124-I4
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus
  role: the third implementer of the second module of the milestone derived today — prove three existence statements, each a colouring by formula on three small discs, that inhabit the hypotheses of four theorems already proved; then two leaves of the module that states the claim list's sector point; changing no statement
  launch: now, in the worktree of the branch that holds the four statement modules proved — both earlier implementers have handed back and nobody else writes there; a planner of the kernel lane starts beside you in another worktree on one leaf you do not touch (the θ-lemma); a deriver works under `plans/` and `data/` on `main`; no landing is in flight
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage — **when the first two witnesses are proved, with the third's price as you measure it from its first inequality (lines, and whether you would go on), before you go on**; at once for a statement that is false as stated or cannot be inhabited by any colouring you can write down (say what fails); and for a question you cannot work around. The report goes to `data/fs124/reports/FS124-I4.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS124-I4-implementation.md` (new, on branch `fs124-wi3`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs124-wi3` (branch `fs124-wi3`, at `fb515b25`; its `.lake/build` is its own, built by the last implementer an hour ago): `Proofs/HadwigerNelson/Plane/ClosePairModel.lean` (proofs; helpers under names no other module declares) and, in `Proofs/HadwigerNelson/Plane/SectorPoint.lean`, the proofs of `sectorPoint_isSector` and `exists_closePair_sector` only; a new helper module beside them if a witness's geometry wants one, with whole new lines in `Proofs.lean` and `ARCHITECTURE.md`; `plans/FS124-I4-implementation.md`, `data/fs124/i4/`, `data/fs124/reports/FS124-I4.md`; **not** any statement or definition; **not** the four proved modules (a lemma you need there in another form is a helper in your file, and a line in your report); **not** `ThreePiece.IsSector.hasArcEdges` — it stays `sorry`: it is the planner's job beside you; **not** `scripts/Axioms.lean`, `scripts/Assumptions.lean` (a later landing registers everything: you draft your audit block as a file under `data/fs124/i4/`), `CLAUDE.md`, `LEAN.md`, `LEDGER.md`, `main`
  budget: about 350k by the harness's count, as guidance; you cannot read that count, so use this: **a saved stage after each witness; a leaf on which three attempts fail stays `sorry` with a note, and you go on; after the second witness you message me the third's price and wait for nothing — go on unless your own measure says it is more than about twice the plan's 700 lines, in which case stop at that saved stage and hand back**

Hello. Today two derivers worked out by hand what a measurable six-colouring must do one unit from two nearby meeting
points of three colours each; a planner stated nine statements of it in Lean; and two implementers proved all of them this
afternoon — 124 leaves, the standard three axioms, no statement changed. Four of those theorems speak about a pair of
meeting points whose six colours are all different. Their proofs are checked; what is not yet in the kernel is that such a
pair exists in any colouring of any open set at all — and a theorem about nothing is the one thing this library's gate
exists to keep out. The planner wrote down three small colourings by formula that would show it. They are yours.

## Why this job

The four statement modules do not land until their hypotheses have inhabitants in the kernel (my ruling, with what was
weighed: read the item whole):

> 42. **FS124-I3 done (18:07 UTC logged; hand-back 18:05 UTC; 506k by the harness's count — not resumed): all 61 leaves of `Plane/ThreePiece` and `Plane/ClosePair` proved, no statement changed; with the first implementer's 63, the four statement modules of the second module hold no `sorry`** (branch `fs124-wi3`, tip `fb515b25`; record `plans/FS124-I3-implementation.md` there, Stages 1–4; report `data/fs124/reports/FS124-I3.md` there). **By claim, in its words**: C124-FORCED-PIECES, C124-LONE, C124-BOTH's first clause, C124-FOUR — "TRUE [kernel, on a branch]", each on the standard three axioms, each read against the claim list's words in its record § 3.2; **"C124-BOTH, second clause — TRUE for arc-edged decompositions [kernel, on a branch]; GAP for the list's sector points at one named step"** (the θ-curve leaf, "not proved, not this job's"). C124-LONE's Step II is in the kernel as three named theorems. **"What is not shown: that the four claims' hypotheses are inhabited"** — their models are the third job's; "until they land, non-vacuity is the planner's two sampled witnesses, [measured]". Two models of one member proved: the three-sector point (arc-edged, full) and the petal point (not full). **Its generalizations**: one arc-edged member that separates saves the point by itself, with no pair and no colouring hypothesis; the arc lemma reads injectivity at one pair of points only; a line given by its equation is null. **Its tool notes**: the first implementer's statement check counted a docstring line beginning with "example" as an example head (repaired in its copy; the earlier runs unaffected), and compared a definition's whole stored value, which moves when a proof field of a decomposition given as data is proved (its copy compares the data fields, with its own plant). **Its slip, disclosed**: a patch applied to one file five minutes into the as-given build and put back within a minute. **The price**: 61 leaves, 1,161 lines, four compiling builds, one hour; "no planned route failed". **My receipt**: the tip read on `origin`; **against the planner's skeleton, no `sorry` is left in the four statement modules and the only lines removed are placeholders — bare `sorry` lines, and in `Plane/ThreePiece` the eighteen `field := by sorry` lines of the two constructions (my diff, read line by line)**; its axiom print holds 95 lines, four of them `sorryAx` (its controls); its statement check's last line "PASS: no statement and no definition changed"; the two remaining files hold three `sorry` each, as planned. Not checked by me: its read-aloud; the build logs. **Rulings on what it holds for me.** (a) **Whoever writes "the nine are proved" owes the qualifier**: C124-BOTH's second clause is kernel-checked for decompositions whose edges contain an arc from the point, not for the list's sector points. Kept in every report since item 34. (b) **The statement modules land with the witnesses' module, in one landing** — a theorem whose hypotheses have no kernel inhabitant does not go through the gate here when its inhabitant is a planned leaf; weighed: landing the four now with the models named by hand and the five docstring notes reworded, as the first night's landing did for carriers the scan cannot see. Why not: there the inhabitants were theorems; here they are `sorry`. Confidence: medium-high; if the unit-square witness prices out of reach, the landing goes with the two smaller witnesses and that one model named as measured, by a ruling then. (c) The three definitions that hold proofs stay in the audit block (91 records), as ruling 40 (a). (d) `fs124-wi3` is the module's branch; `fs124-wk2` is behind it and retired. **Launched on this hand-back** (item 43): the third job on the witnesses, and a planner on the θ-lemma.
> — source: plans/FS124-close-inventory.md § Items

Kooshi's word of this morning, and what he has said of formalizing:

> > I agree with all 3. let's keep the lean backlog paused. We move to the standard workflow, attacking 6/7. During the lean phase of the workflow, if any dependencies need to be formalized, have those done as well.
> — source: data/external/EXT-OAI1-request.md

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

One of the three is more than an inhabitant: at seven colours, a pair at whose common unit point neither member separates.
The pair theorems spend the number six in one sentence; that witness is the kernel's proof that the sentence is needed.

## The statements

**In your worktree**: `/home/kooshi/source/lean-dir/.claude/worktrees/fs124-wi3/Proofs/HadwigerNelson/Plane/ClosePairModel.lean` (three statements) and `/home/kooshi/source/lean-dir/.claude/worktrees/fs124-wi3/Proofs/HadwigerNelson/Plane/SectorPoint.lean` (two of its three
`sorry` are yours). First lines; read each whole in its file, with its docstring:

> theorem exists_closePair_seven_not_separatesAt :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wi3/Proofs/HadwigerNelson/Plane/ClosePairModel.lean

> theorem exists_closePair_not_separatesAt :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wi3/Proofs/HadwigerNelson/Plane/ClosePairModel.lean

> theorem exists_closePair_full :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wi3/Proofs/HadwigerNelson/Plane/ClosePairModel.lean

> theorem sectorPoint_isSector : sectorPoint.IsSector := by
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wi3/Proofs/HadwigerNelson/Plane/SectorPoint.lean

> theorem exists_closePair_sector :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wi3/Proofs/HadwigerNelson/Plane/SectorPoint.lean

**The planner's record**, `/home/kooshi/source/lean-dir/.claude/worktrees/fs124-wi3/plans/FS124-kernel-plan-2.md` — read it whole for these: § 2.5 (no statement is empty: the models, and what they
cost), § 3.2's last two tables, § 4.4 (the derivers' models beside its own, and its sampled check of the two six-colour
witnesses, `/home/kooshi/source/lean-dir/.claude/worktrees/fs124-wi3/data/fs124/k2/square_model_check.py` — the formulas, in floats: an instrument, not a proof),
Stage 5 (where an implementer starts; § 4.6 on iterating with `lean` against a copy of the build). What it says of your
leaves (first lines):

> | `exists_closePair_seven_not_separatesAt` | two translated copies of `sectorPoint`'s construction with no inner piece; the label `6` on the disc about `w` | about 120 |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wi3/plans/FS124-kernel-plan-2.md § 3.2

> | `exists_closePair_not_separatesAt` | the petal at `x` and its sea (connected as a union of convex sets); two crude distance inequalities | about 250 |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wi3/plans/FS124-kernel-plan-2.md § 3.2

> | `exists_closePair_full` | four distance inequalities, sharp along the shared edges (the lens duality, then a cusp); two non-convex pieces at each member (connected by segments toward a quadrant); six arcs of unit circles as edges | 500 to 700 |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wi3/plans/FS124-kernel-plan-2.md § 3.2

> | `exists_closePair_sector` | the unit-square witness again, its pieces as the components of a disc cut along three arcs of unit circles — about 150 beyond `exists_closePair_full` |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wi3/plans/FS124-kernel-plan-2.md § 3.2

> **What is hard, in order.** (1) The θ-lemma — out of this plan. (2) `exists_closePair_full`: the one leaf where a
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wi3/plans/FS124-kernel-plan-2.md § 3.2

**The two implementers' records** (`/home/kooshi/source/lean-dir/.claude/worktrees/fs124-wi3/plans/FS124-I2-implementation.md`, `/home/kooshi/source/lean-dir/.claude/worktrees/fs124-wi3/plans/FS124-I3-implementation.md`):
what they proved that you will use — the three-sector point and the petal point as decompositions with every field
proved, the three-disc model of a tight pair, the lemma that a colouring proper on a set with no unit pair inside each
piece is a weak colouring — and the helper names you must not reuse (each record's "Theorems this phase proved").

**A second candidate for the third witness, should the unit square price badly** — a reading by a deriver, floats, one
mind, nothing in the kernel: on the Searcher's kept model the centre has three partners at distance exactly 1, each pair
with both common unit points inside (read the item for what was read and where):

> 4. **FS136-E1, verdicts through its Stage 3 (16:48 UTC logged; commit `f4e13b20`; record `plans/FS136-E1-derivation.md`, its gate exit 0 by its message): the reading, the table, the count for two members and for one — each derived, one mind; "No value of the chromatic number is touched by any of it."** **The reading** (C136-RINGS-READ; the counts [tools], floats, one mind; four named points exact): on the strip, the disk and the flower the least distance of a point across that is not inside the object is `1.8512`, `1.618`, `1.7321` — "exactly `φ²/√2`, `φ`, `√3` at the named points"; **the fourth held object, the bowtie fragment, "is the same kind of point"** — its stop is the point across of two five-label points; "No held object breaks the card's frame". **"Every held stop is excluded by its own pair's tiles alone", in two kinds**: on the strip and the disk neither member separates (the count); on the flower and the bowtie fragment a member separates and a cell is still empty — "the count is necessary and not sufficient". (The exclusions themselves are its Stage 5, whose verdict is not yet saved.) **A defect in the stub's control at seven**: "R7 has no covering pair" is "false as reasoned" — adjacent lattice points lack different labels, so two carry all seven; "the count is not special to six: it holds whenever the pair's labels are all the labels". **A finding against the card's frame**: "'four or more labels at `p`' is not read by anything at the point across", and a coloured common unit point of a covering pair can carry two labels, paid for by one member alone (10 points of the disk, 6 of the flower, 4 of the bowtie fragment) — which the both-members theorem forbids for two three-label sector points and which occurs with a four-label member; for maps this is an entry of FS-112's (one mind). **C136-TABLE — derived** ([hand] over C124-TYPE): for any finite family of points on the unit circle about `w`, each with a finite family of pieces, almost every point near `w` has a label that is, at every member carrying it, wholly on that member's matching side. "For maps nothing" new (FS110-N-SEAM (b)); in measure: any number of members, pieces and labels, repeated labels, a conclusion on labels. **C136-COVER and C136-ONE — derived from it**, in the label form. **My relay answered** (its § 3.0): the table "is the planner's G6 over a finite set of members, and no more … Two minds, one route … not two independent derivations"; the count is the planner's G5 "with the conclusion on labels" — and the planner's declaration concludes a piece on each closed side, "the posed conclusion, which one region cut along the circle satisfies": **the label form is a statement for the kernel lane**; the planner's unit-square witness is not the local picture of a held map "as far as the readers see" (its members are `√2` apart; no held close complementary pair is). **Two reader defects of its own, repaired before any count was kept** and disclosed (rounding; samples outside the table's radius). **My receipt**: the commit on `main`; the two entries' arguments read whole — the table's step (a piece with a point strictly inside the far circle bars its label outside the member's circle, by connectedness and the one lemma) and the identity `(A ∨ C)(A ∨ D)(B ∨ C)(B ∨ D) = AB ∨ CD` redone by hand; **two controls re-run by me**: the count over states prints 0 and its fault 5,369; the reader on the seven-colouring prints its expected line (54 pairs, 96 points, 0 violations) and with the fault 34,161 violations; the three distances against `φ²/√2`, `φ`, `√3` by arithmetic. Not checked by me: the reading's other counts; the exactness at the four named points (its Stage 5 control); the prior-art lines. **Filed**: the four entries into the claim list by script, with the corrected control; a dated correction under the stub's control at seven. **Rulings.** (a) The four verdicts stand as logged: derived, one mind each, kernel pending; the table is not counted as two minds (its own word; weighed: counting the planner's blind statement as a second mind — declined, one route, and under Workflow 3.1 the planner's blindness carries no grade). Confidence: high. (b) **The label form goes to this milestone's kernel claim list, when its planner is briefed — not to FS-124's implementers**: their contract is that no statement changes, their planner has handed back past its line, and a statement nobody has read back would enter a module whose every other statement was. Weighed: an amendment adding one theorem to the second implementer's brief (cheaper by one job; it is three lines over `ae_onSide_of_label`). Confidence: medium-high; if FS-124's third job (the join) is briefed before this milestone's planner, it may take the one statement with a readback of its own. (c) **For the asking lane, at this job's hand-back**: the card's clause "about a point of four or more labels" is not read by any statement so far; the control at seven was wrong; two-label common unit points exist with a four-label member — the frame's object may be the covering pair alone. (d) No push to Kooshi: nothing here fixes a value; he is told in the next report, with the exclusions marked as run and not yet a verdict.
> — source: plans/FS136-close-inventory.md § Items

The three statements are existence statements: any colouring that inhabits them will do.

## Done means

1. **Your readback first**: the quotations against their sources; the planner's sections; your two files whole and what
   they import. Build the branch once as given, under the slot (it should end with 6 `declaration uses sorry` warnings
   and no other). Open your record. Commit and push.
2. **The seven-colour control, then the lone witness**, each by the planner's construction unless it fails — then yours,
   said in your record. After each: build under the slot, commit by explicit path, push, a saved stage.
3. **The price of the third**: state its first distance inequality as a small real-variable lemma carrying only its own
   hypotheses, prove it, and from that measure the rest. **Message me the price.** Then the witness, or the other
   candidate, or a stop at the saved stage by the budget's rule.
4. **`sectorPoint_isSector` and `exists_closePair_sector`**, last, if the third witness is in; the θ-lemma stays `sorry`.
5. **Statements**: unchanged; the statement check the last implementer left (`/home/kooshi/source/lean-dir/.claude/worktrees/fs124-wi3/data/fs124/i3/statement_diff.py`) run on
   your two files, with its control.
6. **When your last leaf is in**: the axioms of every theorem of your files printed, with a control that fires; your
   audit block as a file; `tools/check_architecture.py` exit 0; `./scripts/dupnames.sh`. You do not run the full gate,
   merge `main`, or touch `main`.
7. **Read aloud**, in your record: each witness against the hypotheses of the theorem it inhabits — hypothesis by
   hypothesis, so that a reader sees no hypothesis of `closePair_forced_pieces`, `closePair_lone`, `closePair_both_separate`,
   `closePair_both_saved` or `closePair_four` is left without a model — and for the seven-colour control, the one
   sentence of the six-colour proof it shows cannot be dropped.
8. **Your record**, in stages headed "Stage n — SAVED (FS124-I4)", with "Theorems this phase proved", the price as
   measured, every leaf left `sorry` by name with what was tried, and drafts for the landing (the audit block; what the
   five claims' docstring notes should say if a witness is missing). The report in standing rule 11's form. **Stopping at
   a saved stage with the first two witnesses proved and the third priced is a good report.**

## What is yours to decide

The witnesses themselves, their geometry, the helpers, how you iterate. Three failed attempts on one route is a dispatch
to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.

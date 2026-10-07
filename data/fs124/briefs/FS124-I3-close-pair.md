# Brief FS124-I3 — what two meeting points of complementary colours force one unit from both: two modules of a planner's skeleton, sixty-one leaves, on `fs124-wi3`

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), at Kooshi's word of this morning. Launch line: "Your brief is on disk: read it in full first."*

brief: FS124-I3
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus
  role: one of two implementers of the second module of the milestone derived today — replace every `sorry` in two files of a planner's skeleton with a proof, changing no statement; print the axioms; draft what a landing will need
  launch: into the next free slot, in a worktree of your own cut from the planner's tip; the other implementer (FS124-I2) works in another worktree on the other two statement files and writes none of yours; a landing of this milestone's first module is in flight on `main`, and a deriver works under `plans/` and `data/` on `main` — you touch neither
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** for a leaf that is false as stated, vacuous, or provable only with a hypothesis it lacks (say which: the *statement* needs it, or your *route* does) — and for a leaf of the other implementer's files that you need in a different form; **with one line when the five theorems quoted below print their axioms**; and for a question you cannot work around; the report goes to `data/fs124/reports/FS124-I3.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS124-I3-implementation.md` (new, on branch `fs124-wi3`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs124-wi3` (branch `fs124-wi3`, at `92f09e14`; its `.lake/build` is its own, copied today from the planner's tree after its last build): `Proofs/HadwigerNelson/Plane/ThreePiece.lean`, `Proofs/HadwigerNelson/Plane/ClosePair.lean` (proofs only; helpers under names no other module declares, in these two files); `plans/FS124-I3-implementation.md`, `data/fs124/i3/`, `data/fs124/reports/FS124-I3.md`; **not** any statement or definition (a statement that will not go through comes back through me); **not** the other four modules of the skeleton — two are the other implementer's, and the two that hold the models are a third job's; **not** `scripts/Axioms.lean`, `scripts/Assumptions.lean`, `Proofs.lean` or `ARCHITECTURE.md` (two implementers work at once, and one job joins the branches and registers everything: you draft your audit block as a file under `data/fs124/i3/`); the planner's record, `CLAUDE.md`, `LEAN.md`, `LEDGER.md`, `main`
  budget: about 350k by the harness's count, as guidance; you cannot read that count, so use this: **save a stage after each file; a leaf on which three attempts fail stays `sorry` with a note in your record, and you go on; if three leaves are so left, stop at the next saved stage and hand back**

Hello. The Hadwiger–Nelson problem — how many colours the plane needs so that no two points at distance 1 share one — stands
at six or seven, and by an outside theorem this library declares, the plane's number is that of measurable colourings proper
at almost every unit pair. Today two derivers of this project worked out by hand what such a colouring is forced to do
wherever it has a region of one colour: one lemma about the points at distance exactly 1 from an open one-colour set, and
from it nine statements, ending with what two nearby meeting points of three colours each must show one unit away. A
planner then stated the nine in Lean, working blind from the statements; it reached each by a route of its own (three by a
shorter one than the derivers'), found that none uses measurability, and left a skeleton that builds, with fourteen leaves
proved and a route written for every other. Two implementers take the statement files. This brief is for
the last two: the last four claims: at a point one unit from two three-piece points whose six labels are all different, a piece of one of them lies inside and another outside that point's unit circle; what it forces when one member pays alone; that both pay when both are full; and that exactly four labels are then present.

## Why this job

These nine are, so far, the only statements this project holds about measurable six-colourings that cross a boundary
running along a unit circle — the configuration every earlier exclusion stopped at — and the milestone opened after this
one cites them in its first claims. They are held by hand, one mind each; the kernel is the second check, and until it has
run nobody may build on them as held. A leaf proved by changing what it says would be worse than a leaf left open:
consumers will cite these statements by name. Kooshi's word of this morning, and what he has said of formalizing:

> > I agree with all 3. let's keep the lean backlog paused. We move to the standard workflow, attacking 6/7. During the lean phase of the workflow, if any dependencies need to be formalized, have those done as well.
> — source: data/external/EXT-OAI1-request.md

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

How the skeleton came to be, as I logged it (read the item whole):

> 34. **FS124-K2 done (16:37 UTC logged; hand-back 16:29 UTC): the nine statements of the second module are typed with no defect, one is proved in its claim form, and a route is written for every other leaf** (branch `fs124-wk2`, tip `92f09e14`; record `plans/FS124-kernel-plan-2.md` there, Stages 1–5; report `data/fs124/reports/FS124-K2.md` there). **The skeleton**: six modules under `Proofs/HadwigerNelson/Plane/` — `CircleCrossing`, `OnePiece`, `ThreePiece`, `ClosePair`, `ClosePairModel`, `SectorPoint` — 144 declarations with a body, 14 proved, 130 `sorry`; its last build exit 0 with no warning but those; the architecture check passing. **In the kernel on that branch, standard three axioms**: C124-SHADOW-OPEN in its claim form (`shadow_open`), "for any function proper at almost every unit pair", and the core of C124-TYPE (`IsPieceAt.ae_ne_region`). **Routes**: for C124-CENTRE-HALF, C124-CENTRE and C124-STRADDLE a second route found blind (the type of a tangent disc; an intermediate value on a convex set) — "the route an implementer builds"; for the other six "my blind route is the derivers'". **Generalizations, the planner's own** (its § 2.3; G1–G8): measurability of the colouring is idle in all nine; finiteness of the label set idle in the first five; C124-TYPE does not use `|w − x| = 1`, and at `w = x` a piece at a point lies in the closed unit disc about it; the two clauses of C124-TYPE are one statement in a side; the last four hold at any label type from the one sentence "every label is the label of a piece of x or of y"; **the lemma under the forcing needs no cover hypothesis, and at seven labels "says what the seventh must fill"**; if one member is full the other separates; `a ≠ b` idle in two statements. **A control on six planned as a leaf**: at seven colours a close complementary pair at whose common unit point neither member separates. **The gap**: C124-BOTH's second clause for the list's sector points needs the θ-curve fact, not in Mathlib — by my ruling of item 29 the clause is stated for decompositions whose edges contain an arc from the point, and the bridge is one leaf, `ThreePiece.IsSector.hasArcEdges`, owed as a kernel job of its own ("not short"). **The price**: about 2,400 lines of proof — 1,200 for the four statement modules, the rest for three witnesses by formula, of which the unit-square one (both members full, four labels) is "the one leaf I cannot price from a leaf tried". **Two six-colour witnesses sampled in floats** (271,594 and 272,133 unit pairs, none monochromatic; a planted fault found 17,155 and 41,426): [measured], "not a proof". **Its reading, one mind, by hand**: the six-coloured map the kernel holds has no close complementary pair of three-tile vertices. **Disclosed**: three touches of fenced material (commit subjects shown at launch and by one history listing; an entry's name in the first module's record), "none carried a route". **My receipt**: the tip and its time read on `origin`; the build log's last line (`EXIT 0`) and its one line that is not a `sorry` warning (the build script's up-to-date probe, as in the last landing's receipt); my own count of `sorry` in the six files, 146 — its 130 is by declaration, and two constructions hold nine fields each; the axiom print (ten proved leaves on the standard three, `piece_type` on `sorryAx`: the print tells them apart); **`closePair_lone` and `closePair_four` read by me against C124-LONE and C124-FOUR in the kernel claim list, clause by clause: each clause has its conjunct, and no hypothesis is added**. Not checked by me: the other seven statements against the list; any route; the witnesses' inequalities. **Filed from its drafts** (its § 4.6): the dated line in `data/fs124/claims-K2.md`; **the correction under Step II of C124-LONE in `plans/FS124-E2-derivation.md`** (the bound `η ≤ 1`; the hypothesis the step uses) — the derive gate passes on the file; of its two lines for `LEAN.md` one sentence is new and filed, and two facts are declined as already there (filed from the first night's implementer). **Rulings.** (a) **Two implementers on disjoint files, able to run at once**: FS124-I2 on `CircleCrossing` and `OnePiece` in the planner's worktree, FS124-I3 on `ThreePiece` and `ClosePair` in `fs124-wi3` (cut by me from the same tip, its build copied while the planner's tree was idle). Weighed: one implementer on all four in the planner's order, which is its own recommendation. Why two: 124 leaves is more than twice what one implementer carried inside its line today (49 leaves; 33 theorems; the one job that carried more ended near 590k by the harness's count), the statements are fixed, so a file is proved against another file's `sorry`, and the files do not overlap; neither writes the audit script or the module list — one job joins and registers. Confidence: medium-high; a leaf that needs a statement changed in the other's file would make me sequence them. (b) **The witnesses are a third job** (`ClosePairModel`, and `SectorPoint`'s two planned leaves), after the statement files; weighed: with the statement files. The nine do not need them; a landing does, to name an inhabitant of the full pair — whether a landing may go with that one model named by hand, as the first night's landing did, is decided when the unit-square witness has been priced from its first inequality. Confidence: medium. (c) **The θ-lemma is a kernel job by name**, not a declared hypothesis (Kooshi's word of this morning: what a module rests on is formalized); `SectorPoint` stays off `main` until it lands. Confidence: high. (d) The planner's question for the derive lane (is its unit-square witness the local picture of a held map, the strip at one of its common unit points?) goes with G1–G8 to the deriver now running on the successor, as optional. (e) The planner ended at 637k by the harness's count: not resumed; a successor on these files reads its record.
> — source: plans/FS124-close-inventory.md § Items

## The statements

**The claims**, in the kernel lane's claim list `data/fs124/claims-K2.md` (read it whole, with its dated line of today on how the skeleton
states them): the first lines of yours —

> **C124-FORCED-PIECES** — statement: Let c be a weak six-colouring of U, (x, y) a close complementary pair of three-piece points, each with a decomposition, and w a common unit point of the pair lying in U. Then x or y separates at w: one of its pieces lies in the closed unit disc about w and another is disjoint from the open unit disc about w; the edge of those two pieces lies on S(w).
> — source: data/fs124/claims-K2.md

> **C124-LONE** — statement: In the setting of C124-FORCED-PIECES suppose y does not separate at w. Then x has exactly one inner piece, one outer piece and one crossing piece at w, with labels a and b for the inner and the outer one; there are a side of S(y) and η > 0 such that almost every point of B(w, η) on that side has the label a if it lies inside S(x) and the label b if it lies outside S(x); and there are a point w′ ≠ w of S(x) and η′ > 0 such that inside B(x, η′) the inner piece lies in B̄(w, 1) ∩ B̄(w′, 1), the outer piece is disjoint from B(w, 1) ∪ B(w′, 1), and their closures meet at x only.
> — source: data/fs124/claims-K2.md

> **C124-BOTH** — statement: In the setting of C124-FORCED-PIECES, if x and y are full, both separate at w. If they are sector points, each has an edge that contains an arc of S(w) with an end at the member: no common unit point of a close complementary pair of sector points is saved by one member alone.
> — source: data/fs124/claims-K2.md

> **C124-FOUR** — statement: In the setting of C124-FORCED-PIECES let x and y be full, each with exactly one inner piece, one outer piece and one crossing piece at w. Then exactly four labels are present at w: those of the two inner and the two outer pieces.
> — source: data/fs124/claims-K2.md

**The skeleton**, in your worktree under `/home/kooshi/source/lean-dir/.claude/worktrees/fs124-wi3/Proofs/HadwigerNelson/Plane/` — six files; yours are `Proofs/HadwigerNelson/Plane/ThreePiece.lean`, `Proofs/HadwigerNelson/Plane/ClosePair.lean`. The theorems your two files are for (first
lines; read each whole in its file, with its docstring — the planner states wide forms as the cores and the claims' words
as corollaries under them):

> theorem closePair_forced_pieces {U : Set ℂ} {c : ℂ → Fin 6} (hU : IsOpen U) (hc : IsWeakColouringOn U c) {x y w : ℂ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wi3/Proofs/HadwigerNelson/Plane/ClosePair.lean

> theorem closePair_lone {U : Set ℂ} {c : ℂ → Fin 6} (hU : IsOpen U) (hc : IsWeakColouringOn U c) {x y w : ℂ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wi3/Proofs/HadwigerNelson/Plane/ClosePair.lean

> theorem closePair_both_separate {U : Set ℂ} {c : ℂ → Fin 6} (hU : IsOpen U) (hc : IsWeakColouringOn U c) {x y w : ℂ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wi3/Proofs/HadwigerNelson/Plane/ClosePair.lean

> theorem closePair_both_saved {U : Set ℂ} {c : ℂ → Fin 6} (hU : IsOpen U) (hc : IsWeakColouringOn U c) {x y w : ℂ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wi3/Proofs/HadwigerNelson/Plane/ClosePair.lean

> theorem closePair_four {U : Set ℂ} {c : ℂ → Fin 6} (hU : IsOpen U) (hc : IsWeakColouringOn U c) {x y w : ℂ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wi3/Proofs/HadwigerNelson/Plane/ClosePair.lean

**The planner's record**, `/home/kooshi/source/lean-dir/.claude/worktrees/fs124-wi3/plans/FS124-kernel-plan-2.md` — read it whole: Stage 2 (the definitions with a model each; the nine typed and read back;
§ 2.3 what the typing found), Stage 3 (§ 3.1 the routes; **§ 3.2 every leaf with its route, its Mathlib names checked at
this pin, and its size**; §§ 3.3–3.5 the three passes), Stage 4 (its routes beside the derivers'; § 4.6 how to iterate
with `lean` against a copy of the build), Stage 5 (the price from fourteen leaves, and where an implementer starts). What
it says the job costs, its order for one implementer, and what is hard (first lines):

> **What the module costs.** The leaves proved include the two that carry the mathematics of the first five claims
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wi3/plans/FS124-kernel-plan-2.md Stage 5

> 2. Order: `Plane/CircleCrossing` top to bottom (23 left); `Plane/OnePiece` (40 left: the API, TYPE's corollaries,
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wi3/plans/FS124-kernel-plan-2.md Stage 5

> **What is hard, in order.** (1) The θ-lemma — out of this plan. (2) `exists_closePair_full`: the one leaf where a
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wi3/plans/FS124-kernel-plan-2.md § 3.2

**Your order**: `Plane/ThreePiece`'s interface (every leaf down to and including `hasUnitArcFrom_of_arc_subset_sphere`); then `Plane/ClosePair` whole — the four claims are then proved; then `Plane/ThreePiece`'s two constructions (the three-sector point and the petal point, with their measurability leaves and examples), last. Your two files have 29 and 32 leaves left. A leaf of the other implementer's files is used as it
stands — its statement is fixed, and its `sorry` is theirs.

**The hand arguments**, should a leaf's route fail and you want the other side's wording: `/home/kooshi/source/lean-dir/plans/FS124-E2-derivation.md`, Stage 4 (§ Argument — four regions, six pieces) and Stage 5 (§ Argument — the save by one member: the half-collar, Steps I and II, Both, Four labels) — a dated correction stands under Step II, filed today from the planner's second look: read it with the step.

## Done means

1. **Your readback first**: the quotations against their sources; the planner's record; your two files whole and the
   files they import. Build the branch once as given, under the slot (it should end with 130 `declaration uses sorry`
   warnings and no other). Open your record. Commit and push.
2. **Your two files, in the order above**, each leaf by its route in § 3.2 unless it fails — then yours, said in your
   record. **Before you prove a helper, search this library and Mathlib for its statement's shape, not for a name.**
   After each file: build under the slot, commit by explicit path, push, a saved stage.
3. **Statements**: unchanged. An unused hypothesis is reported, not dropped; anything that must change is a message to me.
4. **When your last leaf is in**: the axioms of every theorem of your two files printed (a scratch file under
   `data/fs124/i3/`, its output saved), with a control that fires — a theorem that still rests on a `sorry`
   of yours or of the other implementer's prints it, and you say which; **message me the lines of the five theorems quoted below**. Your
   audit block drafted as a file; `tools/check_architecture.py` exit 0; `./scripts/dupnames.sh`. You do not run the
   full gate, merge another branch, or touch `main`.
5. **Read aloud**, in your record: each of your claims' theorems against the claim list's words, clause by clause, and
   against its *not claimed* line.
6. **Your record**, in stages headed "Stage n — SAVED (FS124-I3)", with "Theorems this phase proved", the price as measured
   (leaves, lines, builds), every leaf left `sorry` by name with what was tried, and drafts for the landing (the audit
   block; the count of records; any line for `LEAN.md`). The report in standing rule 11's form. **Stopping at a saved stage with the interface and the four claims proved and the two constructions left is a good report** — say
   exactly which leaves are left.

## What is yours to decide

The route for a leaf whose planned route fails; the helpers; how you iterate. The planner's routes were each checked
against the pin and fourteen of them through the build; where one does not go, change it and say so. Three failed attempts
on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.

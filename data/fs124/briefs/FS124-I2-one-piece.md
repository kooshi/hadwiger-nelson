# Brief FS124-I2 — what one piece of one colour forces: two modules of a planner's skeleton, sixty-three leaves, on `fs124-wk2`

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), at Kooshi's word of this morning. Launch line: "Your brief is on disk: read it in full first."*

brief: FS124-I2
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus
  role: one of two implementers of the second module of the milestone derived today — replace every `sorry` in two files of a planner's skeleton with a proof, changing no statement; print the axioms; draft what a landing will need
  launch: now, in the planner's own worktree — the planner has handed back and nobody else writes there; the other implementer (FS124-I3) works in another worktree on the other two statement files and writes none of yours; a landing of this milestone's first module is in flight on `main`, and a deriver works under `plans/` and `data/` on `main` — you touch neither
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** for a leaf that is false as stated, vacuous, or provable only with a hypothesis it lacks (say which: the *statement* needs it, or your *route* does) — and for a leaf of the other implementer's files that you need in a different form; **with one line when the five claims' theorems print their axioms**; and for a question you cannot work around; the report goes to `data/fs124/reports/FS124-I2.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS124-I2-implementation.md` (new, on branch `fs124-wk2`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs124-wk2` (branch `fs124-wk2`, at `92f09e14`; its `.lake/build` is its own, built by the planner today): `Proofs/HadwigerNelson/Plane/CircleCrossing.lean`, `Proofs/HadwigerNelson/Plane/OnePiece.lean` (proofs only; helpers under names no other module declares, in these two files); `plans/FS124-I2-implementation.md`, `data/fs124/i2/`, `data/fs124/reports/FS124-I2.md`; **not** any statement or definition (a statement that will not go through comes back through me); **not** the other four modules of the skeleton — two are the other implementer's, and the two that hold the models are a third job's; **not** `scripts/Axioms.lean`, `scripts/Assumptions.lean`, `Proofs.lean` or `ARCHITECTURE.md` (two implementers work at once, and one job joins the branches and registers everything: you draft your audit block as a file under `data/fs124/i2/`); the planner's record, `CLAUDE.md`, `LEAN.md`, `LEDGER.md`, `main`
  budget: about 350k by the harness's count, as guidance; you cannot read that count, so use this: **save a stage after each file; a leaf on which three attempts fail stays `sorry` with a note in your record, and you go on; if three leaves are so left, stop at the next saved stage and hand back**

Hello. The Hadwiger–Nelson problem — how many colours the plane needs so that no two points at distance 1 share one — stands
at six or seven, and by an outside theorem this library declares, the plane's number is that of measurable colourings proper
at almost every unit pair. Today two derivers of this project worked out by hand what such a colouring is forced to do
wherever it has a region of one colour: one lemma about the points at distance exactly 1 from an open one-colour set, and
from it nine statements, ending with what two nearby meeting points of three colours each must show one unit away. A
planner then stated the nine in Lean, working blind from the statements; it reached each by a route of its own (three by a
shorter one than the derivers'), found that none uses measurability, and left a skeleton that builds, with fourteen leaves
proved and a route written for every other. Two implementers take the statement files. This brief is for
the first two: the circle geometry every later statement stands on, and the first five claims: what an open set of one colour forbids at distance exactly 1, and what follows for a piece, for a centre, and for a pair of points one unit apart.

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

> **C124-SHADOW-OPEN** — statement: Let U be an open set of the plane, c a measurable map from U to a finite set of labels with c(z) ≠ c(z + u) for almost every pair of a point z of U and a unit vector u with z + u in U, i a label, and W an open subset of U almost every point of which has the label i. Then the set of points of U at distance exactly 1 from some point of W is open, and almost every point of it has a label other than i.
> — source: data/fs124/claims-K2.md

> **C124-TYPE** — statement: Let c be a weak k-colouring of an open set U, P a connected open subset of U almost every point of which has the label i, x a point of the closure of P, and w a point of U with |w − x| = 1. If P has a point strictly inside S(w), there is η > 0 such that almost every point z of B(w, η) with |z − x| > 1 has a label other than i; if P has a point strictly outside S(w), there is η > 0 such that almost every point z of B(w, η) with |z − x| < 1 has a label other than i.
> — source: data/fs124/claims-K2.md

> **C124-CENTRE-HALF** — statement: Let c be a weak k-colouring of an open set U, q and z points of U with |q − z| = 1, ρ > 0 with B(z, ρ) ⊂ U, and a a label. If almost every point of B(z, ρ) with distance less than 1 from q has the label a, there is η > 0 such that almost every point p of B(q, η) with |p − z| > 1 has a label other than a; if almost every point of B(z, ρ) with distance more than 1 from q has the label a, there is η > 0 such that almost every point p of B(q, η) with |p − z| < 1 has a label other than a.
> — source: data/fs124/claims-K2.md

> **C124-CENTRE** — statement: Let c be a weak k-colouring of an open set U, q and z points of U with |q − z| = 1, and (q, z) tight for (a, b). Then there is η > 0 such that almost every point w of B(q, η) with |w − z| > 1 has a label other than a, and almost every point w of B(q, η) with |w − z| < 1 has a label other than b.
> — source: data/fs124/claims-K2.md

> **C124-STRADDLE** — statement: Let c be a weak k-colouring of U, (q, z) tight for (a, b), and p a point of U with |p − z| = 1, p ≠ q and p ≠ 2z − q. Then there is η > 0 such that almost every point of B(p, η) has a label other than a and other than b.
> — source: data/fs124/claims-K2.md

**The skeleton**, in your worktree under `/home/kooshi/source/lean-dir/.claude/worktrees/fs124-wk2/Proofs/HadwigerNelson/Plane/` — six files; yours are `Proofs/HadwigerNelson/Plane/CircleCrossing.lean`, `Proofs/HadwigerNelson/Plane/OnePiece.lean`. The theorems your two files are for (first
lines; read each whole in its file, with its docstring — the planner states wide forms as the cores and the claims' words
as corollaries under them):

> theorem shadow_open {U : Set ℂ} {c : ℂ → Fin k} (hU : IsOpen U) (hc : IsWeakColouringOn U c) {W : Set ℂ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wk2/Proofs/HadwigerNelson/Plane/OnePiece.lean

> theorem piece_type {U : Set ℂ} {c : ℂ → Fin k} (hU : IsOpen U) (hc : IsWeakColouringOn U c) {P : Set ℂ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wk2/Proofs/HadwigerNelson/Plane/OnePiece.lean

> theorem centre_half {U : Set ℂ} {c : ℂ → Fin k} (hU : IsOpen U) (hc : IsWeakColouringOn U c) {q z : ℂ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wk2/Proofs/HadwigerNelson/Plane/OnePiece.lean

> theorem tight_centre {U : Set ℂ} {c : ℂ → Fin k} (hU : IsOpen U) (hc : IsWeakColouringOn U c) {q z : ℂ} (hq : q ∈ U)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wk2/Proofs/HadwigerNelson/Plane/OnePiece.lean

> theorem tight_straddle {U : Set ℂ} {c : ℂ → Fin k} (hU : IsOpen U) (hc : IsWeakColouringOn U c) {q z : ℂ} {a b : Fin k}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wk2/Proofs/HadwigerNelson/Plane/OnePiece.lean

**The planner's record**, `/home/kooshi/source/lean-dir/.claude/worktrees/fs124-wk2/plans/FS124-kernel-plan-2.md` — read it whole: Stage 2 (the definitions with a model each; the nine typed and read back;
§ 2.3 what the typing found), Stage 3 (§ 3.1 the routes; **§ 3.2 every leaf with its route, its Mathlib names checked at
this pin, and its size**; §§ 3.3–3.5 the three passes), Stage 4 (its routes beside the derivers'; § 4.6 how to iterate
with `lean` against a copy of the build), Stage 5 (the price from fourteen leaves, and where an implementer starts). What
it says the job costs, its order for one implementer, and what is hard (first lines):

> **What the module costs.** The leaves proved include the two that carry the mathematics of the first five claims
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wk2/plans/FS124-kernel-plan-2.md Stage 5

> 2. Order: `Plane/CircleCrossing` top to bottom (23 left); `Plane/OnePiece` (40 left: the API, TYPE's corollaries,
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wk2/plans/FS124-kernel-plan-2.md Stage 5

> **What is hard, in order.** (1) The θ-lemma — out of this plan. (2) `exists_closePair_full`: the one leaf where a
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wk2/plans/FS124-kernel-plan-2.md § 3.2

**Your order**: `Plane/CircleCrossing` top to bottom, then `Plane/OnePiece` in its file's order (the interface, the type of a piece and its corollaries, the centre, the tight pairs, the three-disc model and its examples). Your two files have 23 and 40 leaves left. A leaf of the other implementer's files is used as it
stands — its statement is fixed, and its `sorry` is theirs.

**The hand arguments**, should a leaf's route fail and you want the other side's wording: `/home/kooshi/source/lean-dir/plans/FS124-E1-derivation.md`, Stage 4 (the unit shadow of an open piece; the centre, the straddle), and `/home/kooshi/source/lean-dir/plans/FS124-E2-derivation.md`, § Argument — one piece, one side.

## Done means

1. **Your readback first**: the quotations against their sources; the planner's record; your two files whole and the
   files they import. Build the branch once as given, under the slot (it should end with 130 `declaration uses sorry`
   warnings and no other). Open your record. Commit and push.
2. **Your two files, in the order above**, each leaf by its route in § 3.2 unless it fails — then yours, said in your
   record. **Before you prove a helper, search this library and Mathlib for its statement's shape, not for a name.**
   After each file: build under the slot, commit by explicit path, push, a saved stage.
3. **Statements**: unchanged. An unused hypothesis is reported, not dropped; anything that must change is a message to me.
4. **When your last leaf is in**: the axioms of every theorem of your two files printed (a scratch file under
   `data/fs124/i2/`, its output saved), with a control that fires — a theorem that still rests on a `sorry`
   of yours or of the other implementer's prints it, and you say which; **message me the lines of the five claims' theorems**. Your
   audit block drafted as a file; `tools/check_architecture.py` exit 0; `./scripts/dupnames.sh`. You do not run the
   full gate, merge another branch, or touch `main`.
5. **Read aloud**, in your record: each of your claims' theorems against the claim list's words, clause by clause, and
   against its *not claimed* line.
6. **Your record**, in stages headed "Stage n — SAVED (FS124-I2)", with "Theorems this phase proved", the price as measured
   (leaves, lines, builds), every leaf left `sorry` by name with what was tried, and drafts for the landing (the audit
   block; the count of records; any line for `LEAN.md`). The report in standing rule 11's form. **Stopping at a saved stage with the first module proved is a good report** — say
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

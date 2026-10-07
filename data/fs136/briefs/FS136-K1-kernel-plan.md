# Brief FS136-K1 — the kernel module for which side of a unit circle a label may sit on, and what follows where one label is left: seven statements, planned blind, then open

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), at Kooshi's word of this morning. Launch line: "Your brief is on disk: read it in full first."*

brief: FS136-K1
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow: blind first from the claim list, then open
  role: the kernel lane's planner for the first module of the milestone opened this afternoon — state in Lean seven statements claimed by hand today about measurable colourings of an open set that are proper at almost every unit pair; find your own route to each, or to its failure, before you see the derivers'; then, with the derivations open, give an implementer a skeleton and a plan per leaf
  launch: now, in a tree of your own cut from the branch that holds the module these statements stand on; an implementer works on another branch, a record job works under `plans/` and `data/` on `main` — you touch neither; no landing is in flight
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: § Fences
  channel: message the coordinator ("main") by SendMessage **when your phase-1 plan is committed** (the fence lifts by my reply, dated by that commit); **at once** for a statement defect (a statement that does not survive typing — untrue as written, vacuous, or narrower than it need be), for a step you can see no route to, for a generalization, or for a definition that should be shared with the module below; and for a question you cannot work around; the report goes to `data/fs136/reports/FS136-K1.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS136-kernel-plan.md` (new, on branch `fs136-wk1`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs136-wk1` (branch `fs136-wk1`, cut from branch `fs124-wi3` at `e33b5088`; the tree is a retired one moved here, so **its `.lake/build` is older than the branch and your first build recompiles several modules**): new modules of this milestone under `Proofs/HadwigerNelson/Plane/` (statements, definitions, and `sorry` at every leaf you do not close — nothing with a `sorry` reaches `main`), whole new lines in `Proofs.lean` and `ARCHITECTURE.md`; `plans/FS136-kernel-plan.md`, `data/fs136/k1/`, `data/fs136/reports/FS136-K1.md`; **not** the modules already on the branch (their statements are fixed; a lemma you need added or widened there is a message), the claim lists (`data/fs136/claims-K1.md` is the coordinator's), `CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `main`, the outside clone at `/home/kooshi/source/math`
  budget: about 300k by the harness's count, as guidance; you cannot read that count, so: save a stage after the definitions, after the statements are typed, and at the phase-1 commit; in phase 2 a stage per three statements; hand back when the plan per leaf is final, or earlier at a saved stage if a statement will not type after three attempts

Hello. The Hadwiger–Nelson problem — how many colours the plane needs so that no two points at distance 1 share one — stands
at six or seven, and the plane's number is that of measurable colourings proper at almost every unit pair. Today this
project put into the kernel, on the branch you stand on, a module about what an open region of one colour forces one unit
away. This afternoon a second milestone was opened on top of it: what the regions at several points, each one unit from a
common point, leave possible near that point. Seven statements of it are in your claim list — a head statement, two counts
under it, two lemmas of plane geometry, and two statements that conclude a colour where the others conclude a restriction.
Each is one mind's, by hand, written today. Nobody outside their authors' lane has looked at them. Your blind phase is the
second look, in the strongest form there is: a route found without seeing theirs.

## Why this job

Two of the seven are the first statements of this project that put a region of one colour where nobody assumed one; the
last of them gives that region a definite length. Later questions will be posed on them. If one does not survive typing —
if a hypothesis is missing, a conclusion is met by a degenerate case, a "connected" is not earned — the cheapest moment to
learn it is now, and a statement defect found by you is worth more than the module. Kooshi's word of this morning, and what
he has said of formalizing:

> > I agree with all 3. let's keep the lean backlog paused. We move to the standard workflow, attacking 6/7. During the lean phase of the workflow, if any dependencies need to be formalized, have those done as well.
> — source: data/external/EXT-OAI1-request.md

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

His last sentence binds you: what a planned statement rests on that this library does not hold is planned too — stated as a
leaf, or ported — and nothing becomes a new hypothesis or a new axiom without a message to me first.

## The statements

The kernel claim list is `data/fs136/claims-K1.md`: three paragraphs of definitions, then the seven statements with their not-claimed lines,
copied by script, in the order to take them. Read it whole. Their first lines:

> **C136-TABLE** — statement: Let c be a weak k-colouring of an open set U, w a point of U, x_1, …, x_m distinct points with |x_i − w| = 1, and 𝒫_i a family of pieces at x_i. Then there is η > 0 such that almost every point z of B(w, η) has a label a with the property: for every i such that a is a label of 𝒫_i, a is inner-pure at w for 𝒫_i if |z − x_i| < 1, and outer-pure at w for 𝒫_i if |z − x_i| > 1.
> — source: data/fs136/claims-K1.md

> **C136-COVER** — statement: Let c be a weak six-colouring of U, x, y points with 0 < |x − y| < 2, 𝒫_x, 𝒫_y families of pieces at x and at y such that each of the six labels is a label of 𝒫_x or of 𝒫_y, and w a point of U with |w − x| = |w − y| = 1. Then x or y separates at w by labels: one of the two families has a label all of whose pieces are inner at w and another label all of whose pieces are outer at w.
> — source: data/fs136/claims-K1.md

> **C136-ONE** — statement: Let c be a weak six-colouring of U, p a point with a family 𝒫 of pieces at p whose labels are all six, and w a point of U with |w − p| = 1. Then there is η > 0 such that almost every point of B(w, η) inside the unit circle about p has a label inner-pure at w, and almost every point of B(w, η) outside it a label outer-pure at w; so p separates at w by labels, and no label is present near w on both sides of that circle.
> — source: data/fs136/claims-K1.md

> **C136-CORNERS** — statement: Let w be a point and x_1, …, x_m (m ≥ 1) distinct points with |x_i − w| = 1. There is ρ₀ > 0 such that for every 0 < ρ ≤ ρ₀ the disc B(w, ρ) less w and the circles S(x_i) is the disjoint union of 2m connected open sets, each with w in its closure and each lying inside or outside each S(x_i) — the sets Σ_ρ of the 2m corners at w cut by those circles; and two of them lie on the same side of every S(x_i) exactly when m = 2, x_1 + x_2 = 2w, and they are the two outside both circles.
> — source: data/fs136/claims-K1.md

> **C136-CLASS** — statement: Let Σ = (x; γ₁, γ₂) be a corner and w a point with |w − x| = 1. Order the curves from x that are rays or circular arcs cyclically, counter-clockwise by direction at x and, for one direction, by signed curvature (positive when the centre is to the left). Let β₋, β₊ be the two branches of S(w) at x, β₋ the one whose counter-clockwise neighbours are inside S(w). Then Σ is inner at w exactly when β₋ ≤ γ₁ < γ₂ ≤ β₊ in that order counted from β₋, and outer at w exactly when β₊ ≤ γ₁ < γ₂ ≤ β₋ counted from β₊.
> — source: data/fs136/claims-K1.md

> **C136-FORCED** — statement: About weak colourings that have the named pieces; no weak six-colouring is known to have one. Let c be a weak k-colouring of an open set U, w a point of U, x_1, …, x_m (m ≥ 1) distinct points with |x_i − w| = 1, 𝒫_i a family of pieces at x_i, Σ one of the corners at w cut by S(x_1), …, S(x_m), and ℓ a label such that every label other than ℓ is a label of some 𝒫_i that is not inner-pure at w for 𝒫_i if Σ is inside S(x_i), and not outer-pure at w for 𝒫_i if Σ is outside S(x_i). Then there is η > 0 such that Σ_η is a connected open subset of U with w in its closure and almost every point of Σ_η has the label ℓ: c has the labelled corner (w, Σ, ℓ). If two such corners, with labels ℓ ≠ ℓ′, are adjacent along a branch β of some S(x_i), then for some η > 0 the set Σ_η ∪ Σ′_η ∪ (β ∩ B(w, η)) is open, almost every point of it on one side of S(x_i) has the label ℓ, and almost every point of it on the other side the label ℓ′.
> — source: data/fs136/claims-K1.md

> **C136-COLLAR** — statement: About weak colourings that have the named corners; no weak six-colouring is known to have one. Let c be a weak k-colouring of an open set U, x a point, F a finite set of labelled corners at x that c has, whose labels are all the labels but one, ℓ, and A an open arc of S(x) lying in U such that at every point w of A each label of F has a corner in F that is not inner at w. Then there is a connected open subset V of U inside S(x), almost every point of which has the label ℓ, such that every point w of A has a radius η > 0 with every point of B(w, η) inside S(x) in V. With "outer" in place of "inner" there is such a V outside S(x), holding the points of B(w, η) outside S(x).
> — source: data/fs136/claims-K1.md

The last three are written in a language of *corners* — a germ of a region between two curves from a point. Whether the
kernel statement should speak of corners, or of pieces as the module below does, or of something a proof suggests, is
yours: the list's words fix what must be true, not the type it is said in. Say for each which you chose and what, if
anything, the other form would add.

**What they are stated over** (none of it fenced — read all of it): the module on your branch — pieces at a point, the
side of a unit circle a piece lies on, and the two statements nearest yours:

> structure IsPieceAt (U : Set ℂ) (c : ℂ → α) (x : ℂ) (P : Set ℂ) (i : α) : Prop where
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs136-wk1/Proofs/HadwigerNelson/Plane/OnePiece.lean

> theorem IsPieceAt.ae_ne_region {U : Set ℂ} {c : ℂ → α} (hU : IsOpen U) (hc : AeProperOn U c) {x : ℂ} {P : Set ℂ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs136-wk1/Proofs/HadwigerNelson/Plane/OnePiece.lean

> theorem ae_onSide_of_label {U : Set ℂ} {c : ℂ → α} (hU : IsOpen U) (hc : AeProperOn U c) {x w : ℂ} (hw : w ∈ U)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs136-wk1/Proofs/HadwigerNelson/Plane/ClosePair.lean

> theorem exists_inner_outer_of_cover {U : Set ℂ} {c : ℂ → α} (hU : IsOpen U) (hc : AeProperOn U c) {x y w : ℂ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs136-wk1/Proofs/HadwigerNelson/Plane/ClosePair.lean

Also open: every module on the main line and on your branch (search by the shape of a statement before you state a
helper), `LEAN.md`, and that module's planner's and implementers' records on your branch
(`/home/kooshi/source/lean-dir/.claude/worktrees/fs136-wk1/plans/FS124-kernel-plan-2.md`, `/home/kooshi/source/lean-dir/.claude/worktrees/fs136-wk1/plans/FS124-I2-implementation.md`, `/home/kooshi/source/lean-dir/.claude/worktrees/fs136-wk1/plans/FS124-I3-implementation.md`,
`/home/kooshi/source/lean-dir/.claude/worktrees/fs136-wk1/plans/FS124-I4-implementation.md`) for how its definitions were shaped and what its leaves cost.

## Fences

**Until your phase-1 plan is committed and I have replied, do not read** — by file, by `git show`, `git log -p`, or search
output — any of: `plans/FS136-E1-derivation.md`, `plans/FS136-E2-derivation.md`, `plans/FS136-the-point-across.md`,
`plans/FS136-derivation.md` and `plans/FS136-Z1-record.md` (the derivers' records and plan, and the record job's files, some
still being written), `plans/FS136-close-inventory.md` and `plans/FS124-close-inventory.md` (my receipts describe the
routes), `data/fs136/claims.md` (its dated lines do too), `plans/STUB-covering-pairs.md` and
`plans/POROS-2026-10-07-fs136-round1.md` (the asking lane's cards name what it expects each statement to use),
`plans/SEARCH-QUEUE.md`, `plans/SESSION-HANDOFF-2026-10-07.md`, everything under `data/fs136/e1/`, `data/fs136/e2/`,
`data/fs136/p1/`, `data/fs136/z1/`, `data/fs136/reports/` and `data/fs136/briefs/` but this brief, and the commit bodies
that touch those paths. The session transcripts and the shared scratch directory are closed to you throughout. Commit
subjects on the main line from this afternoon name some of these statements and say how their authors' work came out;
you will be shown a few at launch: say so in your record — they carry no route. If you touch a fenced file by accident,
say so with what you saw: a disclosed touch costs the second route for that statement and nothing else — the blindness
serves discovery and carries no grade. The kernel claim list, the module below with its records, and every module on
the main line are open.

## Done means

1. **Your readback**: this brief's quotations against their sources; `LEAN.md` whole; the module below (six files) and its
   planner's record. Build your branch once as given, under the slot (it should end with one `declaration uses sorry`
   warning — a leaf another job holds — and no other). Open your record. Commit and push.
2. **Phase 1, blind — the statements in Lean and your own routes.** In the list's order:
   - **the definitions first**, each with a model, so that no statement is empty by accident: a family of pieces at a
     point and a label's purity at a far point; and whatever you state the last three over;
   - **each statement typed and read back aloud against its words**, clause by clause, with the *not claimed* line as the
     list of what your Lean statement must not say; for each, whether it reads the number of labels, and where;
   - **your own route to each**, as a plan per leaf. Where you see no route to a statement, or to one clause of it, say
     where you stop, what you can reach, and what is missing. Where a statement does not survive typing, that is a
     message to me at once;
   - **the skeleton**: a module, or more, that builds with `sorry` at every leaf you have not closed, under the slot.
   **Commit the phase-1 plan and message me.** That commit dates your blindness.
3. **Phase 2, open — after my reply.** Read the derivers' entries for these statements with their arguments. For each:
   where your route and theirs part, which an implementer should build and why, and a plan per leaf in final form — each
   leaf with the Mathlib and library names it will use, found by shape at this pin and checked under the module's own
   imports, and its size. **Any step of theirs you cannot make a leaf of is a message to me with the step's address.**
4. **The price, from leaves tried**: take two leaves of your choice through the kernel to measure the rate, and say what
   the module costs and in what order an implementer should take it.
5. Your record in stages headed "Stage n — SAVED (FS136-K1)", committed by explicit path and pushed; no `axiom`, no
   `native_decide`; you merge nothing and nothing with a `sorry` reaches `main`. The report in standing rule 11's form.
   **Stopping at a saved stage with phase 1 committed is a good report** — say exactly where a successor takes over.

## What is yours to decide

The form of every definition and statement within what its words say; the module's names and places; your routes; what
of the seven you judge plannable now and what should wait for a consumer. The statements are two minds', written in one
afternoon: a difference you find between a statement's words and what can be typed is the most valuable thing this job
can report. Three failed attempts on one route is a dispatch to the companion your identity names, never a fourth.
You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.

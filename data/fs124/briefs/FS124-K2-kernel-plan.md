# Brief FS124-K2 — the kernel module for what one piece of a colour forces at distance 1, and for a close complementary pair: nine statements, planned blind, then open

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), at Kooshi's word of this morning. Launch line: "Your brief is on disk: read it in full first."*

brief: FS124-K2
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow: blind first from the claim list, then open
  role: the kernel lane's planner for the second module of the milestone opened today — state in Lean nine statements claimed by hand this afternoon about measurable colourings of an open set that are proper at almost every unit pair; find your own route to each, or to its failure, before you see the derivers'; then, with the derivations open, give an implementer a skeleton and a plan per leaf
  launch: now, in a tree of your own cut from the branch that holds this milestone's first module, complete; a landing of another milestone is in flight on `main`, and the asking lane works under `plans/` and `data/` there — you touch neither
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: § Fences
  channel: message the coordinator ("main") by SendMessage **when your phase-1 plan is committed** (the fence lifts by my reply, dated by that commit); **at once** for a statement defect (a statement that does not survive typing — untrue as written, vacuous, or narrower than it need be), for a step you can see no route to, for a generalization, or for a definition that should be shared; and for a question you cannot work around; the report goes to `data/fs124/reports/FS124-K2.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS124-kernel-plan-2.md` (new, on branch `fs124-wk2`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs124-wk2` (branch `fs124-wk2`, cut from branch `fs124-wk1` at `80ee1983`; its `.lake/build` is its own copy, made today from a tree built today): new modules of this milestone under `Proofs/HadwigerNelson/Plane/` (statements, definitions, and `sorry` at every leaf — nothing with a `sorry` reaches `main`), `Proofs.lean`, `ARCHITECTURE.md`; `plans/FS124-kernel-plan-2.md`, `data/fs124/k2/`, `data/fs124/reports/FS124-K2.md`; **not** the three modules of the first module (their statements are fixed; a lemma you need added there is a message), the import module's two axioms, any statement on the main line, the claim lists (`data/fs124/claims-K2.md` is the coordinator's: a statement you find wrong is a message), `CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `main`, the outside clone at `/home/kooshi/source/math`
  budget: about 350k by the harness's count, as guidance; you cannot read that count, so: save a stage after the definitions, after the statements are typed, and at the phase-1 commit; in phase 2 a stage per three statements; hand back when the plan per leaf is final, or earlier at a saved stage if a statement will not type after three attempts

Hello. The Hadwiger–Nelson problem — how many colours the plane needs so that no two points at distance 1 share one — stands
at six or seven, and the plane's number is that of measurable colourings proper at almost every unit pair. Today this project
opened a milestone on what such a six-colouring is made of. Its first module — that the problem is a statement about discs —
was planned by a colleague of yours this afternoon and is complete in the kernel on the branch you stand on. The second module
is the milestone's local theory: what one open piece of a colour forces on the points one unit away, and what that does to a
pair of three-colour points that between them use all six colours. Nine statements, by hand, by two derivers, each one
mind's. The last four are where the number six is spent. Nobody but their authors has looked at any of the nine; your
blind phase is the second look, in the strongest form there is: a route found without seeing theirs.

## Why this job

These statements are the first of the milestone that hold at six and fail at seven. If they stand, a pair of three-colour
points of the ordinary kind, less than 2 apart and using all six colours, forces a boundary along a unit circle at each of
the two points one unit from both — from both members, with exactly four colours present there. If one of them does not
stand, everything the asking lane poses next is built on sand, and the cheapest moment to learn that is before more is
derived on top. A statement defect found by you is worth more than the module. Kooshi's word of this morning, and what he
has said of formalizing:

> > I agree with all 3. let's keep the lean backlog paused. We move to the standard workflow, attacking 6/7. During the lean phase of the workflow, if any dependencies need to be formalized, have those done as well.
> — source: data/external/EXT-OAI1-request.md

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

His last sentence binds you: what a planned statement rests on that this library does not hold is planned too — stated as a
leaf, or ported — and nothing becomes a new hypothesis or a new axiom without a message to me first.

## The statements

The kernel claim list is `data/fs124/claims-K2.md`: definitions, then the nine statements with their not-claimed lines, copied by script, in the
order you take them. Read it whole. Their first lines:

> **C124-SHADOW-OPEN** — statement: Let U be an open set of the plane, c a measurable map from U to a finite set of labels with c(z) ≠ c(z + u) for almost every pair of a point z of U and a unit vector u with z + u in U, i a label, and W an open subset of U almost every point of which has the label i. Then the set of points of U at distance exactly 1 from some point of W is open, and almost every point of it has a label other than i.
> — source: data/fs124/claims-K2.md

> **C124-CENTRE-HALF** — statement: Let c be a weak k-colouring of an open set U, q and z points of U with |q − z| = 1, ρ > 0 with B(z, ρ) ⊂ U, and a a label. If almost every point of B(z, ρ) with distance less than 1 from q has the label a, there is η > 0 such that almost every point p of B(q, η) with |p − z| > 1 has a label other than a; if almost every point of B(z, ρ) with distance more than 1 from q has the label a, there is η > 0 such that almost every point p of B(q, η) with |p − z| < 1 has a label other than a.
> — source: data/fs124/claims-K2.md

> **C124-CENTRE** — statement: Let c be a weak k-colouring of an open set U, q and z points of U with |q − z| = 1, and (q, z) tight for (a, b). Then there is η > 0 such that almost every point w of B(q, η) with |w − z| > 1 has a label other than a, and almost every point w of B(q, η) with |w − z| < 1 has a label other than b.
> — source: data/fs124/claims-K2.md

> **C124-STRADDLE** — statement: Let c be a weak k-colouring of U, (q, z) tight for (a, b), and p a point of U with |p − z| = 1, p ≠ q and p ≠ 2z − q. Then there is η > 0 such that almost every point of B(p, η) has a label other than a and other than b.
> — source: data/fs124/claims-K2.md

> **C124-TYPE** — statement: Let c be a weak k-colouring of an open set U, P a connected open subset of U almost every point of which has the label i, x a point of the closure of P, and w a point of U with |w − x| = 1. If P has a point strictly inside S(w), there is η > 0 such that almost every point z of B(w, η) with |z − x| > 1 has a label other than i; if P has a point strictly outside S(w), there is η > 0 such that almost every point z of B(w, η) with |z − x| < 1 has a label other than i.
> — source: data/fs124/claims-K2.md

> **C124-FORCED-PIECES** — statement: Let c be a weak six-colouring of U, (x, y) a close complementary pair of three-piece points, each with a decomposition, and w a common unit point of the pair lying in U. Then x or y separates at w: one of its pieces lies in the closed unit disc about w and another is disjoint from the open unit disc about w; the edge of those two pieces lies on S(w).
> — source: data/fs124/claims-K2.md

> **C124-LONE** — statement: In the setting of C124-FORCED-PIECES suppose y does not separate at w. Then x has exactly one inner piece, one outer piece and one crossing piece at w, with labels a and b for the inner and the outer one; there are a side of S(y) and η > 0 such that almost every point of B(w, η) on that side has the label a if it lies inside S(x) and the label b if it lies outside S(x); and there are a point w′ ≠ w of S(x) and η′ > 0 such that inside B(x, η′) the inner piece lies in B̄(w, 1) ∩ B̄(w′, 1), the outer piece is disjoint from B(w, 1) ∪ B(w′, 1), and their closures meet at x only.
> — source: data/fs124/claims-K2.md

> **C124-BOTH** — statement: In the setting of C124-FORCED-PIECES, if x and y are full, both separate at w. If they are sector points, each has an edge that contains an arc of S(w) with an end at the member: no common unit point of a close complementary pair of sector points is saved by one member alone.
> — source: data/fs124/claims-K2.md

> **C124-FOUR** — statement: In the setting of C124-FORCED-PIECES let x and y be full, each with exactly one inner piece, one outer piece and one crossing piece at w. Then exactly four labels are present at w: those of the two inner and the two outer pieces.
> — source: data/fs124/claims-K2.md

**What they are stated over** (none of it fenced — read all of it): the first module on your branch — the weak colouring of a
set, for a total function, with its bridges, and the radius clause — whose definition yours must use:

> def AeProperOn (U : Set ℂ) (c : ℂ → α) : Prop := (volume.prod arcLength) (monoPairSet U c) = 0
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wk2/Proofs/HadwigerNelson/Plane/WeakColouringOn.lean

> theorem radius_graph {U : Set ℂ} {c : ℂ → Fin k} (hU : IsOpen U) (hc : IsWeakColouringOn U c) {V : Set ℂ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs124-wk2/Proofs/HadwigerNelson/Plane/Radius.lean

Also open: every module on the main line and on your branch (search by the shape of a statement before you state a helper:
this library holds theorems on unit circles, on two circles through a point, on Fubini over unit pairs), `LEAN.md`, and the
first module's planner's and implementer's records on your branch (`/home/kooshi/source/lean-dir/.claude/worktrees/fs124-wk2/plans/FS124-kernel-plan.md`,
`/home/kooshi/source/lean-dir/.claude/worktrees/fs124-wk2/plans/FS124-I1-implementation.md`) for how the definition was shaped and what it cost.

## Fences

**Until your phase-1 plan is committed and I have replied, do not read** — by file, by `git show`, `git log -p`, or search
output — any of: `plans/FS124-E1-derivation.md`, `plans/FS124-E2-derivation.md` and `plans/FS124-tight-pairs.md` (the derivers'
records and plan), `plans/FS124-close-inventory.md` (my receipts describe the routes), `data/fs124/claims.md` (its dated lines
do too), `plans/STUB-q-ring.md` and every file whose name begins `plans/POROS-2026-10-07-fs124` (the asking lane's cards name
what it expects each statement to use), `plans/SESSION-HANDOFF-2026-10-07.md`, everything under `data/fs124/e1/`,
`data/fs124/e2/`, `data/fs124/p1/`, `data/fs124/p2/`, `data/fs124/p3/`, `data/fs124/reports/` and `data/fs124/briefs/` but
this brief, and the commit bodies that touch those paths. The session transcripts and the shared scratch directory are
closed to you throughout. If you touch one by accident, say so in your record with what you saw: a disclosed touch costs the
second route for that statement and nothing else — the blindness serves discovery and carries no grade. The kernel claim
list, the first module and its two records, and every module on the main line are open.

## Done means

1. **Your readback**: this brief's quotations against their sources; `LEAN.md` whole; the first module's three files and
   its planner's record. Build your branch once as given, under the slot (it should build with no `sorry` and no warning).
   Open your record. Commit and push.
2. **Phase 1, blind — the statements in Lean and your own routes.** In the list's order:
   - **the definitions first**: a tight pair with its collars; a three-piece point with a decomposition and its edges;
     a close complementary pair and its common unit points; a piece inner, outer or crossing at a point; a member that
     separates; a full member; a sector point. Each with a model, so that no statement is empty by accident — and for the
     three-piece point say exactly what a model of each kind is (an ordinary three-sector point; one that is three-piece
     only by the letter): the claim list's own definitions distinguish them, and two of the statements turn on it;
   - **each statement typed and read back aloud against its words**, clause by clause, with the *not claimed* line as the
     list of what your Lean statement must not say; for each, whether it spends the number six, and where;
   - **your own route to each**, as a plan per leaf. Where you see no route to a statement, or to one clause of it, say
     where you stop, what you can reach, and what is missing. Where a statement does not survive typing, that is a message to me at once;
   - **the skeleton**: modules that build with `sorry` at every leaf, statements only, under the slot.
   **Commit the phase-1 plan and message me.** That commit dates your blindness.
3. **Phase 2, open — after my reply.** Read the derivers' entries for these statements with their arguments. For each: where
   your route and theirs part, which is the better route for an implementer and why, and a plan per leaf in final form —
   each leaf with the Mathlib statements it will use, found by shape at this pin and `#check`ed, and its size. **Any step
   of theirs you cannot make a leaf of is a message to me with the step's address.**
4. **The price, from leaves tried**: take two leaves of your choice through the kernel to measure the rate, and say what
   the module costs and in what order an implementer should take it.
5. Your record in stages headed "Stage n — SAVED (FS124-K2)", committed by explicit path and pushed; no `axiom`, no
   `native_decide`; you merge nothing and nothing with a `sorry` reaches `main`. The report in standing rule 11's form.
   **Stopping at a saved stage with phase 1 committed is a good report** — say exactly where a successor takes over.

## What is yours to decide

The form of every definition and statement within what its words say; the module's names and places; your routes; what of
the nine you judge plannable now and what should wait. The statements are two minds', written in one afternoon, and their
definitions were corrected once already by the deriver who took them: a difference you find between a statement's words and
what can be typed is the most valuable thing this job can report. Three failed attempts on one route is a dispatch to the
companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.

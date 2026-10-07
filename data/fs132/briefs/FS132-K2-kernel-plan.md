# Brief FS132-K2 — the kernel planner's successor: the first night's exclusion as leaves an implementer can take, then the rest of the module's plan

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session), at Kooshi's word of this morning. Launch line: "Your brief is on disk: read it in full first."*

brief: FS132-K2
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow; nothing is blind to you: you succeed a planner whose blind phase is committed, and you start in its open phase
  role: successor of the kernel lane's planner for FS-132, from its record's stage 4 — turn the hand argument that no four-way meeting point of a measurable six-colouring can have a clean unit circle into Lean leaves, each stated, read back against its step and planned, so that implementers can start on them today; then finish what your predecessor left open, and say what else this milestone's module must state before the milestone can close
  launch: now, in the planner's own worktree; an implementer (FS132-I2) is porting the outside lemmas on a branch cut from yours, and a record job works on `main` — neither writes a file you write
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind any longer
  channel: message the coordinator ("main") by SendMessage **as soon as the exclusion's leaves are committed and the branch builds** (an implementer's slot waits on that message); **at once** for a statement defect — a leaf that is false as stated, vacuous, or not what its step says once typed — for a step of the hand argument that does not go into a leaf, for a generalization, or for a dependency that would be a new axiom; and for a question you cannot work around; the report goes to `data/fs132/reports/FS132-K2.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS132-kernel-plan.md` (on branch `fs132-wk1`; you append stages from "Stage 4 — SAVED (FS132-K2)")
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wk1` (branch `fs132-wk1`, at `e3695302`): `Proofs/HadwigerNelson/Plane/SixRing/` (the three skeleton modules and new modules of the skeleton — statements, definitions, `sorry` at every leaf), `Proofs.lean` and `ARCHITECTURE.md` (whole new lines only: the implementer adds lines to both on its branch, and the merge must be mechanical), `plans/FS132-kernel-plan.md`, `data/fs132/k2/`, `data/fs132/reports/FS132-K2.md`; **not** anything under `Proofs/HadwigerNelson/Outside/` nor the port script under `tools/` (the implementer's from today, on branch `fs132-wi2`: a definition or lemma you need ported is a message to me), the import module's two axioms, any landed statement, the claim lists (a statement you find wrong is a message), `CLAUDE.md`, `LEDGER.md`, `LEAN.md`, `main`, the outside clone at `/home/kooshi/source/math` (read it; write nothing into it)
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 550k — read your token count at every saved stage

Hello. You are taking over from a colleague who did something worth knowing about before you read its record. Working blind
from seven statements, it found its own route to the central one — that in a measurable six-colouring of the plane, a point
where four colour classes meet in a cycle cannot have the unit circle about it show the two remaining colours almost
everywhere — and stopped honestly at the one lemma it could not see. Then, with the derivation open, it read that lemma and
the final step line by line, found no gap, said what the text leaves implicit, and wrote a plan per leaf. It ran out of room
before it could put those leaves into Lean. That is where you start. This morning Kooshi decided that this statement is
formalized first.

## Why this job

The statement is, as far as this project can find, new: the outside proof that moved the Hadwiger–Nelson problem to "six or
seven" excludes a ring of two labels at a three-way point with five colours; this is the four-way point with six, by an
argument of this project's own that rests on two of that proof's lemmas. It is held by hand — one mind, with your
predecessor's checking reading of its last steps — and everything the next milestone does will cite it. The kernel is this
project's second check. A leaf you state wrongly is the expensive error here: an implementer will prove exactly what you
wrote, and a statement that is vacuous or that quietly assumes the conclusion passes the build. So each leaf is read back, in
your record, against the step of the hand argument it stands for, and each hypothesis gets a model.

Kooshi's word of this morning, and what it answers (verbatim in `data/external/EXT-OAI1-request.md` § Kooshi's sixth word):

> > I agree with all 3. let's keep the lean backlog paused. We move to the standard workflow, attacking 6/7. During the lean phase of the workflow, if any dependencies need to be formalized, have those done as well.
> — source: data/external/EXT-OAI1-request.md

> > 2. **What to formalize first.** I recommend the four-way exclusion, on the Lean planner's existing branch.
> — source: data/external/EXT-OAI1-request.md

His last sentence is an instruction for you: **what a planned statement rests on that this library does not hold is planned
too** — a lemma of the release's Lean is ported (the implementer beside you is doing exactly that for the lemmas the
exclusion needs), a hand result of this project's is stated and planned as a leaf — and nothing becomes a new hypothesis or
a new axiom without a message to me first. The Lean backlog of earlier milestones stays paused; a dependency of this module
that happens to sit in it is formalized here all the same.

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

**The kernel lane's claim list**, `data/fs132/claims-K1.md` — read it whole, with its dated line (the whole plane first). The two statements this
job starts with (first lines; each runs on in the file):

> **C132-M-ORBIT** — statement: let U be an open set of the plane containing the closed unit disc about a point p, let c be a weak measurable six-colouring of U (a measurable map from U to six labels with c(z) ≠ c(z + u) for almost every pair (z, u) of a point z of U and a unit vector u with z + u in U), let a_0, a_1, a_2, a_3 be four of the labels and X, Y the other two, and for each j modulo 4 let K_j be a compact set containing p and a point other than p with H_{a_j} ∩ Δ(K_j) = ∅ and H_{a_{j+1}} ∩ Δ(K_j) = ∅, where H_a is the closed essential support of the class of a and Δ(K) is the set of z with min over q ∈ K of |z − q| below 1 and max over q ∈ K of |z − q| above 1; then there are no angle ψ and number δ > 0 such that (i) for every integer k and almost every θ with |θ − ψ − kπ/3| < δ the palette P_p(e(θ)) (`[OAIMath2026]` Definition 5.1, read at the centre p with samplings inside U) contains X or Y, and (ii) for every η > 0 the set of θ in (ψ − η, ψ + η) whose palette contains X and the set of those whose palette contains Y both have positive measure
> — source: data/fs132/claims-K1.md

> **C132-M-EXCL** — statement: let U, p, c, the labels a_0, a_1, a_2, a_3, X, Y and the sets K_0, K_1, K_2, K_3 be as in C132-M-ORBIT; then it is not the case that for almost every unit vector e the palette P_p(e) contains X or Y
> — source: data/fs132/claims-K1.md

**Your predecessor's record**, `/home/kooshi/source/lean-dir/.claude/worktrees/fs132-wk1/plans/FS132-kernel-plan.md` — read Stages 1 to 3 whole. Where it says you resume, what the exclusion stands on, its
count of leaves, and its recommendation on the outside statements:

> At **stage 4**: (1) read `FS132-E1` Stage 3 S5–S7 against 2.3's route for C132-CORES-FREE and 3.5; (2) read the entries for
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs132-wk1/plans/FS132-kernel-plan.md Stage 3

> Stands on two release statements only — `palette_sixty_disjoint`, `palette_transfer_pair` — and on the ported
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs132-wk1/plans/FS132-kernel-plan.md Stage 3

> Fourteen leaves. Finite: M6. Geometry: M4, M5. Calculus: M7a, M7b. Analysis: the rest. **Hard, in order**: M7b, M7c, Lemma S
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs132-wk1/plans/FS132-kernel-plan.md Stage 3

> - **Port, declare nothing further.** C132-M-ORBIT, -M-EXCL, -DIAG-WIDE at `U = ℂ` need three release statements
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs132-wk1/plans/FS132-kernel-plan.md Stage 3

**What happened to that record since** (read each item whole in `plans/FS132-close-inventory.md`):

> 30. **FS132-K1 done at its Stage 3 (532k and 104 minutes by the task notice): the first night's exclusion has its second mind —
> — source: plans/FS132-close-inventory.md § Items

> 31. **FS132-Z1 done: the derivation file is written — 57 entries, each at its source's grade, each marked for which side of
> — source: plans/FS132-close-inventory.md § Items

> 32. **Kooshi's sixth word (2026-10-07, about 11:40 UTC; verbatim, with what "all 3" answers, in
> — source: plans/FS132-close-inventory.md § Items

**The derivation**, now in one file on `main`: `/home/kooshi/source/lean-dir/plans/FS132-derivation.md` (your worktree's copy predates it — read
the one at that path). Its § 1 is the exclusion with the account of who derived, reworked and read each of the steps M0 to M9
and a paragraph headed "What it stands on": at the whole plane, two kernel-checked statements of the release and the nine
steps; on an open set, also one mind's reading of two proofs as local. Its §§ 2 to 5 are the entries of the second and third
rounds; its § 8 the stalls and gaps, among them the square form of "centres exist" your predecessor posed. The steps
themselves are in `/home/kooshi/source/lean-dir/plans/FS132-E3-derivation.md`, Stage 3.

**The skeleton as it stands**, in your worktree under `Proofs/HadwigerNelson/Plane/SixRing/`: the module of the exclusion holds
five placeholders for the release's statements (each a `sorry` with the release's statement), of which your predecessor found
two are not needed; the four-point form `no_outside_orbit_points` is the one leaf that carries the whole argument.

## Done means

1. **Your readback**: the quotations above against their sources; your predecessor's record whole; the derivation file's § 1
   and the nine steps; the skeleton's three modules. Build the branch once as given, under the slot. Commit and push.
2. **The exclusion's leaves — first, because an implementer waits on them.** The fourteen leaves of your predecessor's table
   as Lean statements with `sorry`, in its chart, and the four-point form assembled from them — proved where the assembly is
   short, a leaf with its plan where it is not — so that every `sorry` left is a leaf and none is the theorem. For each leaf,
   in your record: the statement read back in words against its step; a model of its hypotheses where it has any that could
   be empty; the plan — the Mathlib statements it will use, **found by the statement's shape at this pin and `#check`ed**,
   and whether this library already holds it (search the tree by shape before stating a helper: the step lemma's four leaves
   are real analysis with no colouring in them, and one may exist); its size; and **whether it waits on the port or needs
   nothing ported**. Split the module where that lets two implementers work without sharing a file. Drop the two
   placeholders that are not needed; **keep the other three stated exactly as the release states them**, binder for binder
   (the statements are in the clone under `/home/kooshi/source/math/lean/OAI/Geometry/PlaneColoring/`), so that the port replaces them without a change to any leaf. The module
   states **the whole-plane form**; say so in each docstring, and leave the open-set form to a later statement. Build under
   the slot. **Message me when this is committed and green.**
3. **The two-pair ring** (an instance of the release's own theorem): its two rewording leaves, confirmed against the release's
   statement as the port will give it.
4. **The three comparisons your predecessor left**, now against the derivation file: its route for "centres exist" and its
   square form against the first deriver's steps — and say whether the square form can be planned as a kernel statement from
   this library's covering theorem directly (the record job entered it as a gap: a route, not re-derived; a kernel proof
   would close it); its one six-step lemma against the second deriver's two index entries (a difference in statement is a
   message); the four-point form against the witness card's restatement.
5. **What else this milestone's module must state.** A milestone closes when its module passes the gate, and the kernel claim
   list holds seven statements, all from the first round. Draft — for the coordinator to fix, in your record, the statements
   copied from the derivation file by script and never retyped — the list of second- and third-round entries the module
   should state, in order, each with one line: what it rests on (a ported lemma, a leaf of ours, an entry above it), its
   rough size, and whether it is a corollary of something already planned. The asking lane's ranking is your starting point,
   not your answer: `/home/kooshi/source/lean-dir/plans/POROS-2026-10-07-fs132-night.md` § What to formalize, ranked for
   Kooshi, and `/home/kooshi/source/lean-dir/plans/POROS-2026-10-07-fs132-round2.md` § 3.4. Say which entries you would
   leave out of the module and why (a stall has nothing to formalize; a result in a finite search family is a certificate,
   not a theorem of this module).
6. Your record's new stages, each headed "Stage n — SAVED (FS132-K2)", committed by explicit path and pushed; no `axiom`, no
   `native_decide`; nothing with a `sorry` reaches `main` and you merge nothing. The report in standing rule 11's form.
   **Stopping at a saved stage with the exclusion's leaves green and the message sent is a good report** — say exactly where
   a successor takes over.

## What is yours to decide

The form of each leaf, the split into modules, the order after the exclusion, and what you recommend the module state. Your
predecessor's plan is one mind's, written at the end of a long job: change what does not go, and say what you changed and
why. The hand argument is not yours to repair silently — a step that needs more than it says is a message to me, and the most
valuable thing this job can report, because the statement's grade rests on that step. Three failed attempts on one route is a
dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.

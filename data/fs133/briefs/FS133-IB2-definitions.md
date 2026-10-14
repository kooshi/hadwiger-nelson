# Brief FS133-IB2 — the definitions of the density equality's module: thirteen leaves, the model of its field theorem among them

*Written 2026-10-14 04:16 UTC by Keryx, the coordinator (the top-level session), at Kooshi's word of 2026-10-13. Launch line: "Your brief is on disk: read it in full first."*

brief: FS133-IB2
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: an implementer on a planned module of eight files, after two who took its outside side and two files of its lane on measure and laws — you take the lane's third file, the definitions and their basic lemmas, thirteen leaves; and you retire two private lemmas the last implementer wrote while this file was unproved
  launch: now, in the tree the last implementer handed back, on a new branch cut from its head; a planner works on the five-colour chain in `fs131-wq1` and another plans a port of the outside release in `fs132-wi1`; no landing is in flight; the build slot is shared
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing here is blind to you
  channel: message the coordinator ("main") by SendMessage **at once** if a leaf is false as stated or needs a hypothesis it lacks, or if a leaf's route does not go through and you take another (say which); the report goes to `data/fs133/reports/FS133-IB2.md` and to "main" as your hand-back
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS133-IB2-implementation.md` (new, on branch `fs133-wb2`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1` on a **new branch `fs133-wb2`** that you cut from its head (`8ed85e9b8`; its build is current for that commit): `Proofs/HadwigerNelson/Plane/OneClass/Defs.lean` — **proofs and private helpers only, no statement changes**; in `Proofs/HadwigerNelson/Plane/OneClass/InvariantLaw.lean` only the two private lemmas named in § Done means item 4 and the proofs that call them; `plans/FS133-IB2-implementation.md`; `data/fs133/ib2/`; `data/fs133/reports/FS133-IB2.md`. Nothing on `main`; nothing in the module's other files
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. This module is the density equality for the real plane: the largest density of a set with no two points at
distance one is the same whether the set is arbitrary or measurable. Four implementers' worth of it is done: the
outside side, the field theorem, the invariant laws and the section density, all on the standard three axioms. Yours
is the file the others read their definitions from.

## Why this job

Kooshi's rule for what goes out:

> W2: (2026-10-13, answering the choice between the two publishable forms) I choose the second form. Any finding of ours must be formalized. I'd prefer to formalize the entire chain, so at some point I'd like to price the EL theorem to see what it would take to formalize as well.
> — source: data/fs131/REQUEST-2026-10-13.md

The finding is ours by hand, one mind. The module's definitions file holds the finite independence ratio and its two
readings, the bound by colourings, and the model that shows the field theorem's hypotheses can be met; until its
leaves are proved, the module's headlines read them as unproved, and the field theorem has no model in the kernel.

## The statements

The claim the definitions serve, and what the module does not claim, from the claim list fixed before it was planned:

> K133-ONE: (entry at line 469 of the derivation file) `α₁(ℝ²) = α₁(𝒜²) = m₁(ℝ²)`, and `χ_f,0(ℝ²) = χ_f(ℝ²) = χ_f(𝒜²) = 1/m₁(ℝ²)`
> — source: data/fs133/claims-K1.md § Statements

> K133-NC-ONE: any value of `m₁(ℝ²)` or of a chromatic number; `m₁(ℝ²) = δ_Croft`; that some finite graph attains `sup χ_f(G)` (`[Johnson1996fcn]` Question 2); anything at a number field's plane (row 129's field form keeps "given MR"); anything at six colours — `1/m₁(ℝ²) ≤ 4.36`; that the release states any of this
> — source: data/fs133/claims-K1.md § Not claimed

**Your thirteen leaves** are the `sorry`s of `Proofs/HadwigerNelson/Plane/OneClass/Defs.lean` (the plan's G leaves,
with the model the field theorem's hypotheses need, `IsInvariantLaw.isPlaneSystem`). Their statements are the
file's; read them in the source. **The plan per leaf**: `/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1/plans/FS133-kernel-plan.md` § 5.2 (lane B), with § 5.5 (what each headline's
axioms must read: everything in this file rests on the standard three). The two earlier implementers' records,
`/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1/plans/FS133-IA1-implementation.md` and `/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1/plans/FS133-IB1-implementation.md`, end with what each learned that the plan does not say; the second also names the two private
lemmas that item 4 below retires.

## Done means

1. **Readback** (a saved stage): the three quoted lines checked against their sources; each leaf restated in one
   line beside the plan's route; the file's stored statements dumped from the built tree before any edit.
2. **The thirteen leaves**, without changing a statement; re-price what is left from the first two and say so.
3. **The model**: `IsInvariantLaw.isPlaneSystem` proved, and named in your record as the field theorem's model in
   the kernel (the last implementer's draft says which law exercises its third clause).
4. **The join**: the two private lemmas the last implementer wrote in `InvariantLaw` while this file was unproved
   (`card_le_indepNum_induce`, `exists_indep_subset`) re-pointed at this file's public lemmas, or deleted where a
   public lemma replaces them, with the proofs that call them adjusted — no duplicate proof goes to the landing.
5. **No statement changed**, shown from the kernel's side against item 1's dump and for `InvariantLaw` against its
   implementer's (the instrument `/home/kooshi/source/lean-dir/.claude/worktrees/fs133-wk1/tools/fs133_ib1_moved.py` is the pattern; a planted change watched
   firing); no `sorry` left in this file; one build under the slot with no warning from it; the axioms of every
   public declaration printed from the built tree — the standard three, with a planted record watched showing.
6. **Drafts for the landing**, in your record: the audit's block for this file; the model for each hypothesis.
7. The report in the standing rules' form. Leave no process running or queued. **Say whether this tree's compiled
   library is still needed after you**: two more lanes of this module will want a tree.

## What is yours to decide

The proofs; private helpers; another route for a leaf where the plan's does not go through (tell me which). An
unread binder of a statement in this file — a hypothesis or an instance that neither the statement nor its proof
reads — is dropped without asking, listed in your statement check as a ruled difference, and named in your report
(the standing word given to the last implementer, item 726). Anything else about a statement comes to me first.

## The machine

**This session is on the laptop: 12 cores, 31 GB; 330 GB of disk free.** One file through `lake env lean`: 3 to 24
seconds, 3.6 GB; a build with only small modules stale about 7 to 13 minutes.

`env SLOT_BUDGET_GB=22 SLOT_RESERVE_GB=6 python3 /home/kooshi/source/lean-dir/scripts/slot.py --mem <GiB> --cpus <n> --wait 7200 --name ib2 -- <command>`

One file (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`): `--mem 4 --cpus 2` from inside your worktree. The
build: `--mem 10 --cpus 4 -- env MEMMAX=10G BATCH=8 ./scripts/build.sh`; never `lake build`. On exit 75 wait ten
minutes and retry. Stop a process by its PID, never by matching its command line. `/tmp` is wiped at power-off:
anything your record cites lives under `data/fs133/ib2/`.

The remote is unreachable: **commit by explicit path on your branch and do not push**.

You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## Amendment 1 (2026-10-14 04:30 UTC) — option (a): one fact, one place

**Ruling: move `OneClass.countable_algPlane` into the definitions file**, its statement and docstring unchanged, with
your proof that needs no new import; delete the copy in `InvariantLaw` and your private `countable_E`, pointing their
uses at the one public lemma. *The alternative:* (b), leave both. *Why not:* item 4 of § Done means already says no
duplicate proof goes to the landing, and the definitions file is where a reader looks for a fact about the plane the
others read; the stored statement does not change and the name stays visible to every downstream file, which import
this one. Confidence: medium-high. Do **not** remove the import that `InvariantLaw` gained for it — an import removed
can move a stored statement; leave the imports as they are. Show in your statement check that the moved constant's
stored type is identical and that it is the only declaration whose module changed. Your touches are extended to that
lemma's two places. You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).

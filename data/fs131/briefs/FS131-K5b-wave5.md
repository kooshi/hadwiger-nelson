# Brief FS131-K5 — wave 5 of the Lean backlog: plan its foundation and skeleton (termination, the stuck chains' ends, row 134's base, density)

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-K5b
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow
  role: wave 5's second planner — state its last three rows (FS112-ROTHEX, FS114-BV-HEX, FS114-CVB-THOM), run the obligation-modeling pass, confirm the Mathlib names, and write the implementer's handoff; `row134BaseUA`'s leaves are a later planner's
  launch: now, beside FS131-I2k (wave 2's implementer) and FS131-I4g (wave 4's implementer), each in its own worktree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a statement defect, a generalization or shorter route, a missing lemma, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-K5b.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building before your first build
  record: `plans/FS131-w5-kernel-plan.md` (on branch `fs131-w5`; you continue it — standing rule 2's "Resuming")
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5` (branch `fs131-w5`): new modules under `Proofs/HadwigerNelson/` (the opening plan names `Plane/ValidMap/Dense` and `Plane/ValidMap/Terminal`; the layout is yours), supporting lemmas in the foundation modules under `Proofs/HadwigerNelson/Plane/` (statements unchanged), `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `plans/FS131-w5-kernel-plan.md`, `tools/fs131_k5_*.py`, `data/fs131/k5/`, `data/fs131/reports/FS131-K5b.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 480k

Hello. You are wave 5's second planner. Wave 5 is **termination and density**: the terminal valid map the moves reach, the ends of stuck chains, row 134's
base step and the density statements built on it. The first planner, FS131-K5, wrote the foundation (`Plane/ValidMap/Chain`, sorry-free), stated 10 of the
13 rows as a skeleton (24 `sorry` leaves in `Plane/ValidMap/Terminal` and `Plane/ValidMap/Dense`), read each back, gave a route per leaf, and found that the
base step is ours to formalize in full: no piece of Sokolov and Voronov's paper is used by statement (inventory items 196–198). Your job is the rest of the
plan except the base's leaves: the last three rows, the obligation-modeling pass, and the handoff, so wave 5's implementer can start on everything but the
base. A third planner (FS131-KB) lays out the base's leaves after you.

## Why this job

Since Workflow 3.1 a milestone closes only when its Lean module passes the gate; this milestone formalizes the hand results the milestones before
it left on paper. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

Your list is K5's § 5.1, items 1–5, in its order; item 0 (`row134BaseUA`'s leaves) is not yours. It begins:

> 1. **State FS112-ROTHEX** (read `plans/FS110-N-proof.md` l. 374, 393 for N2-ROT and N2-HEX; NB3 §1.4 step 10, §2.2 #7): the two ring lemmas with
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-w5-kernel-plan.md ### 5.1 The successor planner's list (in order)

and ends:

> 5. **Write § 14's handoff** (the form of wave 4's plan § 14): the vacuity carriers (recommendation: **IN** for `IsTerminalMap` and `QROnly` — refutable on
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-w5-kernel-plan.md ### 5.1 The successor planner's list (in order)

(items 2–4 between them: BV-HEX's four clauses from `plans/BASE-V-verification.md`, CVB-THOM from `plans/FS114-CVB-verification.md` § 1.9 with Thomassen's
Lemma 1 formalized or entered as an `axiom` with `LEAN.md` § Assumptions' four items, and the obligation pass with `#check`). The rows' statements, errata
and merge notes are in `plans/LEAN-BACKLOG.md` at each row's heading; read § 7.3 of `plans/FS131-kernel-plan.md` (the planner's six obligations) and K5's
record in full first — its § 2.2 (the definitions and their readings), § 3.2 (read-backs), § 3.4 (findings) and Stage 6 (the base's placement). The ruling
that places the base:

> (a) **`row134BaseUA` gets its own planner job inside FS-131 (FS131-KB)**, after wave 5's successor planner has stated ROTHEX and BV-HEX, which the walk
> — source: plans/FS131-close-inventory.md

In your handoff, the implementer may prove every leaf except `row134BaseUA` (which waits for KB's plan) and its consumers' dependence on it, which is a
single citation. If stating ROTHEX or BV-HEX shows the walk needs them in a different form than K5's § 4 assumes, say so in the record for KB.

## Done means

1. **Your readback first**: check the quotations above against their sources; build the branch once as given (`3f7b5a14`); restate in your record what is
   yours (§ 5.1 items 1–5) and what is not (item 0). Commit and push.
2. **The three rows stated** in Lean with `sorry` at every leaf, each read back against its row in the record; the branch building with only `sorry`
   warnings; `Proofs.lean`, `ARCHITECTURE.md` (`tools/check_architecture.py` exit 0) and `scripts/Axioms.lean` updated.
3. **The obligation-modeling pass** (`debruijn-obligation-modeling`, invoked fresh) over every wave-5 statement, with § 4's Mathlib names confirmed by `#check`
   and § 4 extended to the new rows.
4. **The handoff section** in the form of wave 4's plan § 14 (`.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md`): where it is and how the
   implementer works, what it may and may not change, the vacuity carriers and inhabitants, how the wave lands (after wave 4), and notes for the base's
   planner and for wave 6's.
5. The report, in standing rule 11's form. Stopping at a saved stage with items left, and naming them, is a good report.

## What is yours to decide

The representation of the three rows, their module (K5 planned `Dense`), the order, and Thomassen's Lemma 1's form (formalize it if it is under about an
hour of agent work, else an `axiom` with the four items — never one of our own hand results). If a row cannot be stated without a hypothesis its derivation
hid, or a term is never fixed, that is a finding: message me at once. A widening the kernel allows is a generalization: message me as well. You start no
agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).

## The machine, the branch, and the landing

- **The worktree is ready**: `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5`, branch `fs131-w5` at `3f7b5a14` (K5's foundation and skeleton over wave 4's branch as FS131-I4e left it), `.lake/packages` a symlink to the main tree's and `.lake/build` its own copy, made by the
  project's recipe. Never replace that copy with a symlink: two trees compiling into one build race on the same compiled files.
- **Builds** only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G
  BATCH=4 ./scripts/build.sh`; never `lake build`. Up to two such builds from different worktrees may run at once when the slot admits them — with two
  implementers building beside you, expect to wait on exit 75 (wait ten minutes and retry). The first build rebuilds what changed since the copied build.
  `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence that a module is green.
- **Nothing with a `sorry` reaches `main`** (the opening plan § 7.5): your work stays on `fs131-w5` and lands with the wave, after its implementer's gate,
  once wave 4 has landed. Wave 4's statements may still gain children as its implementer works on `fs131-w4`, but never change: build on them as committed;
  wave 5's implementer merges `fs131-w4` (or `main`, once wave 4 lands) before its gate.

# Brief FS131-K3b — wave 3 of the Lean backlog: write the designed skeleton of its 20 rows, the read-backs, the leaf plans, the handoff

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-K3b
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow
  role: the successor of FS131-K3 on wave 3's plan — merge the landed wave 1 in, write the skeleton K3 designed (the local-structure lemmas and the 20 rows), read each statement back, plan each leaf, run the obligation-modeling pass, and write the implementer's handoff
  launch: now, beside FS131-K2b (wave 2's planner) and FS131-T1 (a fix to the vacuity check, in the main tree)
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a statement defect, a generalization, a missing lemma, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-K3b.md`, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building before your first build
  record: `plans/FS131-w3-kernel-plan.md` (on branch `fs131-w3`; you continue it — standing rule 2's "Resuming")
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w3` (branch `fs131-w3`): the wave-3 modules (K3's three, and the new ones its design names, `Proofs/HadwigerNelson/Plane/LocalStructure.lean` among them), supporting lemmas in the foundation modules under `Proofs/HadwigerNelson/Plane/`, `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `plans/FS131-w3-kernel-plan.md`, `tools/fs131_k3_*.py`, `data/fs131/k3/`, `data/fs131/reports/FS131-K3b.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 480k

Hello. You are picking up wave 3's plan from a colleague who ran out of room. FS131-K3 (de Bruijn on Opus, like you) built wave 3's foundation —
the local geometry of an arc map around a point: tiles' colours, cones, germs, arcs of Γ on ω(p), (Q) arcs, change points, hubs, and RINGBAND's circle
colourings — sorry-free and green, found no statement defect among the 20 rows, and designed their whole skeleton before handing back at its context
line. Its design is in its record, in the section headed "For stage 3": every row's formal shape, the module layout, the supporting lemmas, the
inhabitants, the vacuity notes, and the order. Your job is mostly to write that design down in Lean and check it, not to redo it.

## Why this job

This milestone formalizes the hand results the milestones before Workflow 3.1 left on paper, wave by wave. Waves 4 to 9 stand on the vocabulary
of wave 3, so its statements are read by everything after it: a hypothesis wrongly dropped here propagates. Wave 1 has landed on `main` meanwhile
(`d59ffcdf`; 14 rows held in the kernel), so your skeleton can now build on wave 1's proofs, not its placeholders.

## The statements

Your rows are wave 3's 20 rows, each quoted with its errata and merge notes in `plans/LEAN-BACKLOG.md` at its heading and in K3's
`data/fs131/k3/rows.md`, their definitions in `plans/FS116-derivation.md` (and `data/fs116/claims.md`) at the addresses the backlog gives. Six more
rows merge into them and must be carried: FS116-N1-TOUCH into FS129-SR2-TOUCHW; FS116-RING-Q-PRIME into FS116-RING-Q-PRIME-S; FS110-N2-RING and
FS110-Y3-GP into FS129-SR1-RINGBAND; FS112-SIX into FS116-N2-FIVERING and FS129-SR1-SIXQ; FS116-RING-TRANSFER-C into FS116-N2-FIVERING and
FS116-N2-SIXRING (K3 found that the earlier brief listed only four — the coordinator's slip, inventory item 28). K3's handoff, which is your starting
point:

> HELD FOR THE COORDINATOR: stage 3 (the skeleton of the 20 rows with sorry leaves, the read-backs, the per-leaf plans) and stage 4 (the implementer's handoff) are not done — the job reached its budget line; a successor planner resumes from the record's section "For stage 3", which holds every row's formal shape, the module layout, the supporting lemmas and the order (SIXFRAG first)
> — source: .claude/worktrees/fs131-w3/data/fs131/reports/FS131-K3.md

The rulings in force for this wave, in `plans/FS131-close-inventory.md`: item 27 (wave 3 takes the three local-structure lemmas forward from wave 4,
as `Plane/LocalStructure`: finitely many tiles meet a small disc about any point; the germ dichotomy; in a simple map each tile's cone at a point is
one closed interval), item 26 (K3's generalizations — state each row at the class its argument reads, as the opening plan § 7.3 item 3 asks), and
caution C137 (RINGBAND carries FS129-OA1-RINGWIND's periodicity clauses as its clause (vi), as K3 designed).

## Done means

1. **`main` merged into `fs131-w3`** first (wave 1's proofs; `ARCHITECTURE.md`, `Proofs.lean` and `scripts/Axioms.lean` append-only lines kept from
   both sides), building green with only wave 3's own `sorry` warnings from then on.
2. **The three geometric statements K3 marked for a check before writing** (FS116-N1-GERM-R's four intervals, FS116-Y4-FLANK, FS116-S1-EXIT) checked
   by exact arithmetic or computer algebra on a concrete configuration (`plans/STANDING-RULES.md` rule 5 allows exact arithmetic; no search), each
   result in the record. A check that fails is a finding: message me.
3. **The skeleton**: `Plane/LocalStructure` and every wave-3 row in Lean with `sorry` at every leaf, in K3's order (FS116-Y2-SIXFRAG first, since it
   is FS129-SR1-SIXQ's inhabitant); building through the worktree's `./scripts/build.sh` with only the `sorry` warnings; `tools/check_architecture.py`
   exit 0; `Proofs.lean` and `scripts/Axioms.lean` updated.
4. **The read-backs** (each formal statement against its row and the rows merged into it) and **a plan per leaf** (route, Mathlib lemmas confirmed with
   `#check`, named children, what is hard), in the opening plan's § 6 form.
5. **The obligation-modeling pass** (`debruijn-obligation-modeling`, invoked fresh) over the skeleton, and a re-pricing.
6. **The handoff section** for wave 3's implementer, in the form of `plans/FS131-kernel-plan.md` § 6.1 (where it is, the build, what the implementer
   may and may not change, how the wave lands).
7. Your stages appended to the record, headed "Stage n — SAVED" from the next number; the report in standing rule 11's form. If your context runs
   short, save the skeleton and read-backs first and hand back with the rest named: that is a good report.

## What is yours to decide

How faithfully to follow K3's design: it is a design, and you are closer to the Lean than it was. Where you change it, say why in the record. If a row
cannot be stated without a hypothesis its derivation hid, or a definition K3 chose turns out to change what a row says, message me at once; a
widening the kernel allows is a generalization — message me as well.

## Stages

1. **The readback**: check the quotation above against its source; restate the rows, the six merged rows, and the rulings in your record. Merge `main`
   and build (one `./scripts/build.sh` run under the slot). Commit on the branch and push.
2. **The three checks.** Commit.
3. **The skeleton and the read-backs.** Commit, and message me the commit.
4. **The leaf plans and the obligation-modeling pass.** Commit.
5. **The handoff section**, then report.

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them (inventory ruling 5); on
exit 75, wait ten minutes and retry. `lake env lean <file>` is for iteration only. The worktree's `.lake/build` is its own copy; never replace it with a
symlink. Nothing with a `sorry` reaches `main`: the wave stays on `fs131-w3` until its implementer lands it.

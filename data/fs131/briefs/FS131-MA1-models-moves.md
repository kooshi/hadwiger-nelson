# Brief FS131-MA1 — the example maps built, half A: the general layer's open leaves (`Paint`) and the two painted pictures that are models of the four local moves (`Moves`)

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-MA1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: implementer A of the example maps — the general layer's open leaves (`Paint`) and the two painted pictures that are models of the four local moves (`Moves`): `hornModel` for SHAVE and OPEN, `twoHornModel` for MERGE-RAY and MERGE; every `sorry` leaf of your files proved without changing a statement, in the planner's order, saving after each group
  launch: when a slot frees, on `main`'s line, beside wave 5's jobs on other branches
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf whose statement is false or cannot be proved as stated (at once, with the reason: the planner named three places this is most likely), a hypothesis of a landed theorem that the model turns out not to satisfy (at once: that is the finding this lane exists to catch), or a question you cannot work around; the report goes to `data/fs131/reports/FS131-MA1.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-MA1-implementation.md` (new, on your branch)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wm`: `Proofs/HadwigerNelson/Plane/Models/Paint.lean`, `Proofs/HadwigerNelson/Plane/Models/Moves.lean`; new helpers as new declarations in your own files; `scripts/Axioms.lean` (a block of your own, headed "FS131-MA1", above the `=== PURCHASED ===` banner), `plans/FS131-MA1-implementation.md`, `tools/fs131_ma_*.py`, `data/fs131/ma/`, `data/fs131/reports/FS131-MA1.md`; **not** `Proofs/HadwigerNelson/Plane/Models/Stuck.lean`, `Proofs/HadwigerNelson/Plane/Models/Bends.lean` (implementer B's, later, on a branch cut from yours), any landed module (no statement, definition or docstring of a landed declaration is edited: the docstring lines that will name these models are applied when the lane lands), `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are building Lean objects that show this milestone's central theorems are about something. The milestone, FS-131, turns this project's
hand-derived results into kernel-checked ones, and its gate asks one thing the kernel cannot: that a theorem's hypotheses hold together on some real
object. An audit found that the four local moves the termination procedure runs on, the stuck vertex's family and the bends have no Lean object
satisfying their hypotheses at once — only hand models. A planner has since reduced all of them to one construction — the seven-colour brick map
read in more colours, with a small picture painted in spare colours — proved its general layer, and written a skeleton in which each model theorem
*is the landed theorem applied to the model*. What is left is the leaves: the local facts of each picture.

## Why this job

For the four moves this is an open gate item on results already on `main` (`LEAN.md` § The gate, the inhabitant bullet; inventory rulings 419 (d),
427 (d)): the theorems are kernel-checked, and until a model lands nothing in Lean shows their hypothesis sets are not empty. Kooshi, on pricing this
work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

The plan's hand-back and the rulings in force:

> 460. **FS131-KM1 done at its Stage 3: the example maps are one construction, with a skeleton whose model theorems are the moves applied; the
> — source: plans/FS131-close-inventory.md

> 461. **Rulings on KM1's held items, and its slot.** (a) **Two implementers, split by file as its § 3.9 has it — A: `Paint`, `Moves`; B:
> — source: plans/FS131-close-inventory.md

> 426. **FS131-QA4 done: the impossible-assumption audit, third pass** (harness ≈ 431k by the task notice; record `plans/FS131-QA4-audit.md`, Stages 1–6;
> — source: plans/FS131-close-inventory.md

> 427. **Rulings on QA4's list and the rule.** (a) **Before wave 5 lands, at its final sync** (one remedy pass, in the job that joins the branches, so no
> — source: plans/FS131-close-inventory.md

## The statements

No statement changes in this job. The heads of your files (each `sorry` at its leaves; read every leaf's docstring, which states its route):

> theorem hornModel_shave : ∃ ρ > 0, ∃ F' : ArcMap 8, F'.Valid ∧ F'.AgreesOff hornModel (closedBall plantPt ρ) ∧
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wm/Proofs/HadwigerNelson/Plane/Models/Moves.lean

> theorem hornModel_open : ∃ F' : ArcMap 8, F'.Valid ∧ F'.HasHornCount plantPt 0 := by
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wm/Proofs/HadwigerNelson/Plane/Models/Moves.lean

> theorem twoHornModel_rayMerge : ∃ ρ > 0, ∃ F' : ArcMap 8, F'.Valid ∧ F'.AgreesOff twoHornModel (closedBall plantPt ρ) ∧
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wm/Proofs/HadwigerNelson/Plane/Models/Moves.lean

> theorem twoHornModel_merge : ∃ ρ > 0, ∃ F' : ArcMap 8, F'.Valid ∧ F'.AgreesOff twoHornModel (closedBall plantPt ρ) ∧
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wm/Proofs/HadwigerNelson/Plane/Models/Moves.lean

The plan (read it whole; § 2 is the construction, § 3 the plan per leaf, § 3.9 the split, § 3.11 what is weak):

> ## Stage 3 — SAVED (FS131-KM1): the skeleton, its readback, the plan per leaf, the passes, the docstring lines, the handoff
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wm/plans/FS131-models-kernel-plan.md

## Done means

1. **Your readback first**: check every quotation above against its source; read the planner's record whole, the general layer in `Paint`, and the
   landed theorems your models apply. Build the branch once as given (expect it up to date: 59 distinct `sorry` warnings, all in the four model
   files). Open your record with what you may and may not change. Commit and push.
2. **The leaves**, in the planner's order, saving after each group (a build, the axioms print for the group, the statement check, commit, push).
   Re-price after your first two leaves and say so. The three brick facts are stated in coordinates and re-proved here (wave 5's `BrickMap` is not
   on `main`); after wave 5 lands they become three lines each — note the names for that tidy, do not wait for it.
3. **The receipt**: each model theorem — the landed theorem applied to the model — on the standard three, with a control that fires; no `sorry` in
   your files; `tools/check_architecture.py` exit 0.
4. No statement or definition changed anywhere; no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. You do not merge
   another branch into this one, run the gate, or touch `main`. Leave no background process running, and keep what your record cites under your
   `data/` folder.
5. **Your record**, stages headed "Stage n — SAVED (FS131-MA1)", "Theorems this phase proved"; the report in standing rule 11's form, ending with what
   is left and its route. Stopping at a saved stage with one model whole and the next begun is a good report — one model whole is worth more than
   two half done.

## What is yours to decide

The route inside each leaf, your helpers, and the order within the plan's dependencies. The plan's routes are one mind's, priced from three measured
models and not from proofs; change a route that does not go and say so. A leaf's statement is not yours to change: if one is false — the planner
names `hornArcs`' rim-piece angles, `brickBase_col_zero` and `stuckModel_terminal` as the likeliest — that is a message to me, and a finding. Three
failed attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.

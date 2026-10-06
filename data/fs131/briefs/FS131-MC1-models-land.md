# Brief FS131-MC1 — the example maps finished and landed: `main` merged in, the last model facts, the docstring lines on the theorems they serve, the gate, `main` fast-forwarded

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-MC1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the example maps' last implementer and their landing — merge `main` (wave 5 landed today) into the lane, prove its one open declaration, add the short applications that needed wave 5, apply the docstring lines that name the models on the theorems they serve, run the full gate on one commit, fast-forward `main`, and draft the counts
  launch: now, in the tree FS131-MB2 has handed back, beside the planners of waves 6 and 10 on branches of their own
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for `stuckModel_terminal` false or resisting (with what fails: I then rule whether the lane lands without it), a hypothesis of a landed theorem a model turns out not to satisfy (at once), a gate step red for a reason outside your touches, a merge conflict beyond `scripts/Axioms.lean` and `ARCHITECTURE.md`, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-MC1.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-MC1-landing.md` (new, on branch `fs131-wmb`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wmb` (branch `fs131-wmb`, at `b9b3a9e5`): the merge's files; the four modules of `Proofs/HadwigerNelson/Plane/Models/` and new modules beside them if the applications want one; **docstrings only** in the landed modules whose theorems gain a model's name (no statement, no definition); `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, the gate's controls and `scripts/vacuity-baseline.txt` as its procedures ask; `plans/FS131-MC1-landing.md`, `tools/fs131_mc_*.py`, `data/fs131/mc/`, `data/fs131/reports/FS131-MC1.md`; `main` only by the final fast-forward push; **not** `CLAUDE.md`, `LEAN.md`, `LEDGER.md` (you draft their lines; I file them)
  budget: about 450k by the harness's count, as guidance; hand back at a saved stage before about 550k — read your token count at every saved stage

Hello. You are landing the objects that show this milestone's central theorems are about something. The milestone, FS-131, turns this project's
hand-derived results into kernel-checked ones; waves 1–5 are on `main`. Its gate asks that every theorem's hypotheses hold together on some real
object, and for the four local moves, the stuck vertex's family, the doubly shadowed band and the bends there were only hand models. In two days a
planner and three implementers built Lean ones — one construction, the seven-colour brick map read in more colours with a picture painted in spare
colours — and they are whole on this branch but for one declaration. Wave 5 landed today, which unblocks the rest. You finish and land.

## Why this job

Sixty-two theorems on `main` say in their docstrings that their hypotheses have only a hand model (`data/fs131/l5/open-gate-items.txt`); for most of
them the Lean model is on this branch. Until it lands, the gate's inhabitant item on those results is open (`LEAN.md` § The gate; inventory rulings
419 (d), 427 (d)). Kooshi, on what the evidence must be:

> - **The artifact is the certificate plus the checker, never the search.** Commit the data a reviewer re-checks; never require them to
> — source: CLAUDE.md § The standard of evidence above rung B

The hand-backs and rulings in force:

> 479. **FS131-MB2 done: the example maps are whole on `fs131-wmb` but one declaration — `shadowModel` and `awayModel` built, the two halves
> — source: plans/FS131-close-inventory.md

> 480. **Rulings on MB2's held items, and its slot.** (a) **One job finishes the lane and lands it, FS131-MC1**, on `fs131-wmb`: merge
> — source: plans/FS131-close-inventory.md

> 472. **FS131-MA1 done: the four local moves have Lean inhabitants — `Paint` and `Moves` whole, each model theorem the landed move applied**
> — source: plans/FS131-close-inventory.md

> 474. **Wave 5 is on `main`** (FS131-L5, the landing; harness ≈ 578k by the task notice; record `plans/FS131-L5-landing.md` Stages 1–6 with
> — source: plans/FS131-close-inventory.md

> 475. **The landing's filing, and rulings** (Keryx, 2026-10-06). (a) **Filed, verbatim from L5's drafts 1, 2 and 4**: `CLAUDE.md` § Trust
> — source: plans/FS131-close-inventory.md

> 471. **Rulings on MB1's held items, and its slot.** (a) **Its order stands** (the cusp arc first: the one model whose receipt read the
> — source: plans/FS131-close-inventory.md

> 466. **FS131-T4 done: the law of a doubled name measured, `main` scanned clean but for the known pair, and the gate's check built and watched
> — source: plans/FS131-close-inventory.md

## The statements

No statement of a landed declaration changes. The lane's one open declaration, and the heads the docstring lines will name:

> theorem stuckModel_terminal : stuckModel.Terminal := by
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wmb/Proofs/HadwigerNelson/Plane/Models/Stuck.lean

> theorem stuckModel_hyps : stuckModel.Valid ∧ stuckModel.IsPlaneMap ∧ stuckModel.Covers plantPt 1 ∧ stuckModel.IsStuck plantPt :=
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wmb/Proofs/HadwigerNelson/Plane/Models/Stuck.lean

> theorem awayModel_hyps : awayModel.Valid ∧ awayModel.IsPlaneMap ∧
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wmb/Proofs/HadwigerNelson/Plane/Models/Bends.lean

> theorem hornModel_shave : ∃ ρ > 0, ∃ F' : ArcMap 8, F'.Valid ∧ F'.AgreesOff hornModel (closedBall plantPt ρ) ∧
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wmb/Proofs/HadwigerNelson/Plane/Models/Moves.lean

The plan's sections on what waited for wave 5 and on the docstring lines, and the last implementer's note on the applications:

> ## Stage 3 — SAVED (FS131-KM1): the skeleton, its readback, the plan per leaf, the passes, the docstring lines, the handoff
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wmb/plans/FS131-models-kernel-plan.md

> ### 8.4 What is left in the lane, and its route
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wmb/plans/FS131-MB1-implementation.md

## Done means

1. **Your readback first**: check every quotation above against its source; read the planner's §§ 3.8–3.10, the three implementers' records'
   closing sections (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wmb/plans/FS131-MA1-implementation.md` and
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wmb/plans/FS131-MB1-implementation.md`), wave 5's landing record for the
   gate's procedure (`plans/FS131-L5-landing.md` on `main`), and FS131-E7's § 7.4–7.5 for the terminal claim (`plans/FS131-E7-derivation.md`).
   Build the branch once as given (one `sorry` warning, at `stuckModel_terminal`). Open your record. Commit and push.
2. **`main` merged in** (wave 5 and the filings; trial it first with `git merge-tree` and name the conflicts — foreseen: `scripts/Axioms.lean`,
   `ARCHITECTURE.md`, keep-both). Build. **`./scripts/dupnames.sh` on the joined tree before anything else** (`LEAN.md` § The gate): a name this
   lane shares with wave 5 — the three brick facts were re-proved here in coordinates because `BrickMap` was not on `main` — is made one
   declaration; then tidy those facts to wave 5's (`sevenBrick_mem_interiorPts`, `sevenBrick_col_val`, `brickCell`).
3. **The last model facts**: `stuckModel_terminal` (the plan's route: every point of the plane off the three planted discs is a brick point, where
   wave 5's `sevenBrickMap_isTerminalMap` speaks; E7's § 7.4 table for the planted points) — if it resists after an honest attempt, message me
   with what fails; the sub-arc model of `bend_away_whole` (ruling 471 (c): `[1/5, 3/10]` lies in a gap of `awayModel`'s contacts; wave 5's
   `IsRingArc.mono`); `bend_away_part` applied to `awayModel` (MB2's one line), and the applications the plan's § 3.8 lists for wave 5's
   `exists_vertexStep` and `cvb_hole_disconnected`; the two folds of item 479. Each model theorem on the standard three, with a control.
4. **The docstring lines**: on each landed theorem a model now serves, the line naming it (the plan's § 3.10; MB1's and MB2's drafts; wave 5's
   stuck family names `stuckModel_hyps`; `cv_l0` and its like name `stuckModel_terminal` only if it is proved) — replacing the "hand model … open
   gate item" sentence where the Lean model meets **every** hypothesis of that theorem, and only there: read each theorem's hypotheses against the
   model before you write the line, and run `tools/fs131_qa4_notes.py` after. The `ARCHITECTURE.md` rows of the four model modules.
5. **The full gate on one commit**, in wave 5's landing's order (its record § 5): build with zero warnings; zero `sorry`; `./scripts/dupnames.sh`
   and `--self-test`; `scripts/axioms.sh` and `--self-test`, every new theorem registered — checked against the kernel's own list
   (`tools/fs131_l5_records.py`, ruling 475 (e)); `scripts/vacuity.sh` and `--self-test`, counts reconciled against `CLAUDE.md` § The gate's line —
   **say what the scan now reads at the sites these models inhabit** (a model is evidence only in the form the scan's procedure registers:
   follow `scripts/Vacuity.lean`'s docstring, and message me before changing how any carrier is classed); `tools/check_architecture.py`; the
   guarded lint (`lake lint --no-build -- --no-build --trace` under the slot with `--mem 8`); the notes check. Logs saved under `data/fs131/mc/`.
6. **The landing**: `main` merged again if it moved (exempt paths only: say so with the diff; else re-gate), then `git push origin HEAD:main`,
   a fast-forward only.
7. **Drafts for the filing**, in your record: `CLAUDE.md`'s two count sentences and the `GATE_CHANGES` entry, each from its log line; the list of
   open gate items that this landing closes and the ones that remain (E7's `F₀`, `F₁` theorems; anything a model did not fully meet).
8. **Your record**, stages headed "Stage n — SAVED (FS131-MC1)"; the report in standing rule 11's form. Leave no background process running.
   Stopping at a saved stage with the merge and the model facts done and the gate not yet run is a good report.

## What is yours to decide

The order of steps 3 and 4, where the applications live, the wording of each docstring line within what is true, and how the brick facts are
tidied. Do not weaken a check to pass it, and do not claim a model for a theorem it meets only in part — say which hypothesis is unmet and leave
the hand-model sentence. Three failed attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.

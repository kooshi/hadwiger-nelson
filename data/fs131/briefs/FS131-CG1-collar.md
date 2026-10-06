# Brief FS131-CG1 — the collar bend's lane G (geometry): G's block moved to `CollarMap`, then `RadialPush` and the map-level children, on `fs131-w5`

*Written 2026-10-05 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-CG1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: lane G of the collar bend — first move G's block of `BendCollar` into a new upstream module `Plane/ValidMap/CollarMap.lean`, statements verbatim and checked by script; then prove `RadialPush` and G's map-level children in FS131-KP2's order, saving after each
  launch: now, beside FS131-M6 (`fs131-w5` into `fs131-w5c`, on `fs131-w5c`) and FS131-IO2 (OPEN, on `fs131-wop`), each in its own tree; lane C (FS131-CC1) follows on a branch cut after your move commit
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a child that cannot be proved as written, a statement that looks false, a statement change lane C would need to know, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-CG1.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-collar-kernel-plan.md` (on branch `fs131-w5`; you append stages from Stage 7, headed as yours)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5` (branch `fs131-w5`): `Proofs/HadwigerNelson/Plane/ValidMap/RadialPush.lean`; a new module `Proofs/HadwigerNelson/Plane/ValidMap/CollarMap.lean` (G's block, moved verbatim, then proved); in `Proofs/HadwigerNelson/Plane/ValidMap/BendCollar.lean` only the deletion of the moved block and the import line; `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (the block headed "FS131-I5g", which you extend), `plans/FS131-collar-kernel-plan.md`, `tools/fs131_cg_*.py`, `data/fs131/cg/`, `data/fs131/reports/FS131-CG1.md`; **not** `Pushforward.lean` or C's declarations in `BendCollar` (lane C's), `BaseDense`, `HexRing`, `BaseWalk`, nor any statement (a change goes to me, then to the planner)
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are building the geometry of the collar bend, the strengthened bend wave 5's pre-bend step rests on, in the Lean backlog. The milestone, FS-131,
turns this project's hand-derived results into kernel-checked ones; waves 1–4, Woodall's chain and MERGE are on `main`, merged into this branch. FS131-KP2 has
just reduced `bend_toward_collar` to 53 named children in three modules and split them into two lanes. Lane G — the radial push, its homeomorphism, the
collar's arcs and the bent map's arcs and validity — is yours; lane C (the charts and sides) follows on its own branch.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and `exists_preBend`
rests on this construction. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

The leaf the lanes build, `sorry`-free as an assembly in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/Proofs/HadwigerNelson/Plane/ValidMap/BendCollar.lean` at `b2ccfb7b` over the children (read it whole there):

> theorem bend_toward_collar (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/Proofs/HadwigerNelson/Plane/ValidMap/BendCollar.lean

Your lane, in KP2's handoff — read the plan in full, §§ 2, 4 and 5 above all:

> | **G, the geometry** | all of `Plane/ValidMap/RadialPush`; in `BendCollar`: `kin_subset`, `kout_subset`, `homeo_eq_self`, `homeo_ringPt`, `homeo_fix_Γ`, `homeo_image_dom`, `collarArcs_nondegenerate`, `collarArcs_Γ`, `map_Γ`, `map_lens`, `map_agreesOff`, `map_valid` | 2,250 lines |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-collar-kernel-plan.md 5.2 The handoff (two implementers, split by file)

>   - G: `push1_push1` → `polarAngle_polar` (a new child) → the inverses → `continuous_pushFun` (hard) → the `tangRad` family →
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-collar-kernel-plan.md 5.2 The handoff (two implementers, split by file)

> - **Merging.** Both edit `BendCollar.lean`, in disjoint declarations: each fills in its own `sorry`s, and git merges such edits
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-collar-kernel-plan.md 5.2 The handoff (two implementers, split by file)

What KP2 and the jobs before it handed back, and the rulings that launch you:

> 394. **FS131-KP2 done: the collar bend planned** (planner; harness ≈ 452k by the task notice; record `fs131-w5`'s `plans/FS131-collar-kernel-plan.md`; report
> — source: plans/FS131-close-inventory.md

> 395. **Rulings on KP2's held items, and its slot.** (a) **G's block moves to `Plane/ValidMap/CollarMap.lean`** (upstream of `BendCollar`), statements verbatim,
> — source: plans/FS131-close-inventory.md

> 390. **FS131-KP2, by message: a generalization (planner's reading, not yet kernel)** — `bend_toward_collar`'s construction never reads `hmax`: maximality is
> — source: plans/FS131-close-inventory.md

> 378. **FS131-KB2 handed back** (Stage 46 SAVED, harness ≈ 420k by the task notice; record `fs131-w5`'s `plans/FS131-I5-implementation.md`, Stages 43–46;
> — source: plans/FS131-close-inventory.md

> 386. **FS131-M5 done: `main` merged into `fs131-w5`** (harness ≈ 368k by the task notice; record `fs131-w5`'s `plans/FS131-I5-implementation.md`, Stages 47–51;
> — source: plans/FS131-close-inventory.md

## Done means

1. **Your readback first**: check every quotation above against its source; read KP2's plan in full and KB2's design (record § 44 of
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-I5-implementation.md`); build `fs131-w5` once as given (`b2ccfb7b`) before editing
   anything. Commit and push.
2. **The move first**: G's block (from `CollarFit.kin_subset` to `map_valid`, every declaration KP2's row lists in `BendCollar`) moved into the new module
   `Proofs/HadwigerNelson/Plane/ValidMap/CollarMap.lean` upstream of `BendCollar`, statements and docstrings byte-identical (checked by a script with a plant, as
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/tools/fs131_kp2_stmt.py` checks), `BendCollar` importing it; `Proofs.lean`, `ARCHITECTURE.md` (`tools/check_architecture.py` exit 0) updated; build;
   **commit and push this as its own stage, and say its commit in a one-line message to me** — lane C's branch is cut from it.
3. **The proofs**, in KP2's order: `push1_push1`, `polarAngle_polar` (a new child), the inverses — re-price the lane in the record after these two — then
   `continuous_pushFun`, the `tangRad` family, `collarArcs_carrier`, then the map-level children in `CollarMap`. Save after each; no statement changed (a change
   lane C would need is a message to me); no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs.
4. **The handover**: your record's last stage says what is proved and what is left, with the build log and an axioms print against that build's oleans,
   including a control on `sorryAx`. You do not merge another branch into this one, run the gate, or touch `main`. Leave no background process running.
5. **Your record**, stages headed "Stage n — SAVED (FS131-CG1)", "Theorems this phase proved"; the report in standing rule 11's form. Stopping at a saved stage
   with children left, named, is a good report.

## What is yours to decide

The proofs, their children and order within the lane's dependencies, and where a supporting lemma lives within your touches. KP2's routes are a plan, not a
rule. If a child cannot be proved as written, stop it, message me with the smallest counterexample or the missing hypothesis, and go on. Three failed attempts
on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`.

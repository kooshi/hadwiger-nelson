# Brief FS131-CC1 — the collar bend's lane C (charts and sides): `Pushforward`, C's `BendCollar` children and the model B0, on `fs131-w5k`

*Written 2026-10-05 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-CC1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: lane C of the collar bend — prove `Pushforward` and C's children in `BendCollar` (and the model `collarModel`, B0) in FS131-KP2's order, against lane G's statements while they are still `sorry`, saving after each
  launch: when a slot frees (inventory item 395 (c)), beside lane G (FS131-CG1, on `fs131-w5`) and the other jobs then running, each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a child that cannot be proved as written, a statement that looks false, a change to a lane-G statement you need, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-CC1.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-collar-C-implementation.md` (new, on branch `fs131-w5k`; lane G keeps the planner's record on `fs131-w5`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5k` (branch `fs131-w5k`, cut from `fs131-w5` at `2736ab8c`): `Proofs/HadwigerNelson/Plane/ValidMap/Pushforward.lean`; in `Proofs/HadwigerNelson/Plane/ValidMap/BendCollar.lean` C's declarations (KP2's row) and children beside them; `collarModel` (B0) where KP2's plan puts it; `scripts/Axioms.lean` (a block of your own, headed "FS131-CC1", above the `=== PURCHASED ===` banner), `plans/FS131-collar-C-implementation.md`, `tools/fs131_cc_*.py`, `data/fs131/cc/`, `data/fs131/reports/FS131-CC1.md`; **not** `RadialPush.lean` or `CollarMap.lean` (lane G's), `BaseDense`, `HexRing`, `BaseWalk`, `Proofs.lean` and `ARCHITECTURE.md` unless you add a module, nor any statement (a change goes to me, then to the planner)
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are building the second half of the collar bend, the strengthened bend wave 5's pre-bend step rests on, in the Lean backlog. The milestone, FS-131,
turns this project's hand-derived results into kernel-checked ones; waves 1–4, Woodall's chain and MERGE are on `main`, merged into wave 5's branch. FS131-KP2
reduced `bend_toward_collar` to 53 named children in two lanes; lane G (the geometry) runs on `fs131-w5` and has just moved its block into a module of its own,
`CollarMap`, so the two lanes share no file. Lane C — the pushforward of a map under the homeomorphism, the charts and sides at the four kinds of point, R1–R3,
and a model map — is yours, on a branch cut from that move.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and `exists_preBend`
rests on this construction. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

Your lane, in KP2's handoff — read the plan in full, §§ 2, 4 and 5 above all (on this branch, `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5k/plans/FS131-collar-kernel-plan.md`):

> | **C, the charts and sides** | all of `Plane/ValidMap/Pushforward`; in `BendCollar`: `exists_collarFit`, `degree_openArc`, `map_degree_lensCurve`, `map_degree_end`, `map_hasDegree`, `map_hasRepeatedColour`, `map_ringArcsWithin`, `sides_end`, `map_R1`, `map_R2`, `map_R3`, `coloursAt_subset`, `side_ne_inner_of_mem_lens`, `map_inert`, and the new child B0 `collarModel` | 2,500 lines |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-collar-kernel-plan.md 5.2 The handoff (two implementers, split by file)

>   - C: `Pushforward` (with `hasDegree_iff_of_charts` first) → `degree_openArc` (the two-germ chart pattern) → `map_degree_lensCurve` →
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-collar-kernel-plan.md 5.2 The handoff (two implementers, split by file)

> - **Interfaces.** Both work against the signatures as stated. G's children are inputs to C's (C cites `map_Γ`, `map_lens`,
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-collar-kernel-plan.md 5.2 The handoff (two implementers, split by file)

What KP2 and lane G handed back, and the rulings that launch you:

> 394. **FS131-KP2 done: the collar bend planned** (planner; harness ≈ 452k by the task notice; record `fs131-w5`'s `plans/FS131-collar-kernel-plan.md`; report
> — source: plans/FS131-close-inventory.md

> 395. **Rulings on KP2's held items, and its slot.** (a) **G's block moves to `Plane/ValidMap/CollarMap.lean`** (upstream of `BendCollar`), statements verbatim,
> — source: plans/FS131-close-inventory.md

> 396. **FS131-CG1, by message: G's block moved** to `Plane/ValidMap/CollarMap` at commit `2736ab8c` on `fs131-w5` (pushed; build OK; statements checked by
> — source: plans/FS131-close-inventory.md

> 390. **FS131-KP2, by message: a generalization (planner's reading, not yet kernel)** — `bend_toward_collar`'s construction never reads `hmax`: maximality is
> — source: plans/FS131-close-inventory.md

> 378. **FS131-KB2 handed back** (Stage 46 SAVED, harness ≈ 420k by the task notice; record `fs131-w5`'s `plans/FS131-I5-implementation.md`, Stages 43–46;
> — source: plans/FS131-close-inventory.md

## Done means

1. **Your readback first**: check every quotation above against its source; read KP2's plan in full and KB2's design (record § 44 of
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-I5-implementation.md`); build `fs131-w5k` once as given (`2736ab8c`) before editing
   anything; open your record with what you may and may not change. Commit and push (`git push -u origin fs131-w5k`).
2. **The order of KP2's handoff, lane C's part**: `Pushforward` (with `hasDegree_iff_of_charts` first) — re-price the lane in the record after it and
   `degree_openArc` — then `map_degree_lensCurve`, `exists_collarFit`'s C4 with `map_degree_end`, `sides_end`, R1, R2, R3 and inert, the case splits of
   `map_hasDegree`/`map_hasRepeatedColour`, then B0 (`collarModel`). Save after each; no statement changed (a lane-G statement you need changed is a message to
   me); no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs.
3. **The handover**: your record's last stage says what is proved and what is left, with the build log and an axioms print against that build's oleans,
   including a control on `sorryAx`. You do not merge into `fs131-w5` (the merge of the two lanes is on my word), take `main` into this branch, run the gate, or
   touch `main`. Leave no background process running.
4. **Your record**, stages headed "Stage n — SAVED (FS131-CC1)", "Theorems this phase proved"; the report in standing rule 11's form. Stopping at a saved stage
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
worktree's `.lake/build` is its own copy (taken from an idle tree when the branch was cut); never replace it with a symlink. Nothing with a `sorry` reaches
`main`.

# Brief FS131-I5e — wave 5 of the Lean backlog, continued: `cor3` moved upstream, `n3_end`'s open case, and the lane's other leaves on `fs131-w5`

*Written 2026-10-05 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I5e
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: wave 5's fifth implementer — move `cor3` upstream of `HexRing` (unblocking `rot_noThird`, `rot_out`, `rot_in`), prove `n3_end_of_not_inType`, state `cor3_local`, then the lane's other leaves, saving after each; never the planar job's seven
  launch: now, beside FS131-G4 (wave 4's landing, on `fs131-w4`), FS131-IP2 (the planar chain, on `fs131-w5p`) and FS131-IX1 (the crossing lemma, on `fs131-w5x`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, a name `cor3`'s statement uses that is not upstream of `HexRing`, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I5e.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I5-implementation.md` (on branch `fs131-w5`; you continue it from Stage 19 — standing rule 2's "Resuming")
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5` (branch `fs131-w5`): the wave-5 modules (`Proofs/HadwigerNelson/Plane/ValidMap/Chain.lean`, `Terminal.lean`, `Dense.lean`, `HexRing.lean`, `FlankUA.lean`, `BrickMap.lean`, and `BaseWalk.lean`, `BaseDense.lean`, `MapGraph.lean` outside the planar job's seven), a new module for `cor3` if you choose one, supporting lemmas in wave 3–4's foundation modules as plan § 10.2 allows (statements unchanged), `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (your own block, headed "FS131-I5e", above the `=== PURCHASED ===` banner), `plans/FS131-I5-implementation.md`, `tools/fs131_i5_*.py`, `data/fs131/i5/`, `data/fs131/i5e/`, `data/fs131/reports/FS131-I5e.md`; not wave 4's modules (`Contact`, `UnitArc`, `BaseSteps`, `SVMap`, `StuckChain`, `Moves`, `Cone`, `Surgery`), which reach this branch only by merge
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are wave 5's fifth implementer, on Opus. Wave 5 is **termination and density**: the terminal valid map the moves reach, the ends of stuck chains,
row 134's base step with unit arcs, and the density results built on it. FS131-I5d proved `stuck_flanks_ua` (so `stuck_structure_ua` is a kernel theorem) in
a new module `Plane/ValidMap/FlankUA`, `cv_l0`, `n3_end_chain`, two NB3 steps, and half of `n3_end`; 33 `sorry` declarations are left on the branch, 26 of
them this lane's (the other seven are the planar job's, now on `fs131-w5p` and `fs131-w5x`, and you never edit them). Wave 4 is landing on `main` beside you;
merging it into this branch is a later job's, not yours.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`). Wave 5 lands after
wave 4 and after the planar job; you can prove its leaves now. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

Every `sorry` on `fs131-w5` at `a804de21` outside the planar job's seven, read back in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-w5-kernel-plan.md` §§ 3.2 and 8.2 and in
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-w5base-kernel-plan.md`. Where I5d left them:

> **What is left in this lane (26), and where it stands** (for wave 5's next implementer):
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-I5-implementation.md Stage 18 — SAVED: `n3_end` proved over one named child (its first case); the handoff

(the list follows there). What I5d handed back, and the rulings that launched you:

> 298. **FS131-I5d handed back** (Stage 18 SAVED, harness ≈ 599k by the task notice; record `fs131-w5`'s `plans/FS131-I5-implementation.md`, Stages 14–18;
> — source: plans/FS131-close-inventory.md

> 299. **Rulings on I5d's held items, and its slot.** (a) **`rot_noThird`'s block**: wave 5's next implementer moves `cor3` — statement, docstring and proof (a
> — source: plans/FS131-close-inventory.md

(its parts (a)–(d) are your first three tasks and your order). `n3_end`'s open case, as I5d left it:

> - **no in-type upper flank at `N`** (the first disjunct): the child `n3_end_of_not_inType`, `sorry` — NB3-END items 2–5 with item 2's premise read as I4m
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-I5-implementation.md Stage 18 — SAVED: `n3_end` proved over one named child (its first case); the handoff

(it continues there with what the case can start from). The reading of NB3-END it rests on:

> 288. **FS131-I4m handed back** (Stage 40 SAVED, harness 466k by the task notice; report `fs131-w4`'s `data/fs131/reports/FS131-I4m.md`; commits `70075915`,
> — source: plans/FS131-close-inventory.md

(the correction continues there; NB3-END itself is `plans/FS112-NB3-verification.md` l. 230–243). `cor3_local`:

> 218. **Rulings on KB's and IC1's held items** (four parts each, compressed where the alternative is plain).
> — source: plans/FS131-close-inventory.md

(its part (b)). The planar job's fence, which stands:

> 274. **Rulings on QA3's held items and the freed slot.** (a) **`InMK`**: restated when its first consumer is planned, not now (no theorem uses it; a definition
> — source: plans/FS131-close-inventory.md

What you may change:

> **It may**: add children anywhere in the wave's modules — every child §§ 4, 9.1 name is an expected addition, and the shared ones may go to the
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-w5-kernel-plan.md ### 10.2 What the implementer may and may not change

`exists_merge`'s colour clause is its vertex instance only (items 268–269), and `exists_merge` itself has left wave 4 (item 295): nothing in wave 5 may cite
it. `pair_i` carries `h3` (item 258, which `l3_base` discharges from `ht'`); when you reach `l3_base`, rewrite `linkage_dot_ne_zero`'s docstring as
`plans/FS131-QA3-audit.md` § 2.4 d drafts it (item 274 (b)).

## Done means

1. **Your readback first**: check every quotation above against its source; read I5d's Stages 14–18 and the inventory items named; build `fs131-w5` once as
   given (`a804de21`) before editing anything. Commit and push.
2. **`cor3` upstream** (ruling 299 (a)): moved verbatim, the move checked by script (statement, docstring and body byte-identical), `Dense` importing it, and
   `rot_noThird`'s docstring left as is; then `rot_noThird`, `rot_out`, `rot_in` when you reach them. If a name in `cor3`'s statement is not upstream of
   `HexRing`, stop this step and message me with the names.
3. **`n3_end_of_not_inType`** (ruling 299 (b)): NB3-END items 2–5; if a step fails as written, stop the leaf and message me with the step and the smallest
   counterexample or the missing hypothesis.
4. **`cor3_local`** stated (ruling 218 (b)) and used for `pseudo_ncard_le_two`; then the rest in the order you judge, saving after each; no statement changed,
   no new `axiom`, no `native_decide`; re-price from your first two hard leaves. Do not edit a file while a build of it runs. If you need
   `tools/fs131_i5_dupes.py`, repair its FORK first (item 284).
5. **Your record** (continue it), stages headed "Stage n — SAVED", "Theorems this phase proved"; the report in standing rule 11's form. The gate and the landing
   are a later implementer's. Stopping at a saved stage with leaves left, and naming them, is a good report.

## What is yours to decide

The proofs, their children and order after the first three tasks, where `cor3` goes (a new module or `HexRing`), where a supporting lemma lives within § 10.2's
allowance, and how the lane's remaining leaves could be split with a second wave-5 implementer in its own tree (say so in your report, by file: one may join
when a slot frees, ruling 299 (e)). If a leaf cannot be proved as written, stop that leaf, message me at once with the declaration, the reason, and the
smallest counterexample or the missing hypothesis, and go on with the others. Three failed attempts on one route is a dispatch to the companion your identity
names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows
exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; four agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence; I5d's
iteration script is `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/data/fs131/i5d/iter.sh` (it mirrors oleans in a scratch directory outside the repository — use your own directory, not I5d's). The
worktree's `.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`.

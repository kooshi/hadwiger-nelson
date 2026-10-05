# Brief FS131-I5d — wave 5 of the Lean backlog, continued: its 30 remaining own `sorry` declarations on `fs131-w5`

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I5d
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: wave 5's fourth implementer — `stuck_flanks_ua` first (unit-arc versions of wave 4's flank lemmas), then the shared child `exists_isRingArc_of_onRingArc`, then wave 5's other own leaves, saving after each; never the planar job's seven
  launch: now, beside FS131-I4m (wave 4, on `fs131-w4`), FS131-IMM1 (wave 4's MERGE, on `fs131-w4mm`) and FS131-IP1 (the planar implementer, on `fs131-w5p`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I5d.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I5-implementation.md` (on branch `fs131-w5`; you continue it — standing rule 2's "Resuming")
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5` (branch `fs131-w5`): the wave-5 modules (`Proofs/HadwigerNelson/Plane/ValidMap/Chain.lean`, `Terminal.lean`, `Dense.lean`, `HexRing.lean`, `MapGraph.lean`, and from the merge `BaseWalk.lean`, `BaseDense.lean`), supporting lemmas in wave 3–4's foundation modules as § 10.2 allows (statements unchanged), `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (your own block, headed "FS131-I5d"), `plans/FS131-I5-implementation.md`, `tools/fs131_i5_*.py`, `data/fs131/i5/`, `data/fs131/reports/FS131-I5d.md`; not wave 4's modules (`Contact`, `UnitArc`, `BaseSteps`, `SVMap`, `StuckChain`), which wave 4's implementers edit on their own branches
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k



Hello. You are wave 5's fourth implementer, on Opus. Wave 5 is **termination and density**: the terminal valid map the moves reach, the ends of stuck
chains, row 134's base step with unit arcs, and the density results built on it. FS131-I5c merged wave 4's `fs131-w4` into this branch, applied the sides
clause ruling to `stuck_structure_ua`, built the brick-map infrastructure (`Plane/ValidMap/BrickMap`), and proved seven leaves; 37 are left, 30 of them
this lane's (the other seven are the planar job's, on `fs131-w5p`, and you never edit them).

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`). Wave 5 lands after
wave 4 and after the planar job; you can prove its leaves now. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

Every `sorry` on `fs131-w5` at `728c3502` outside the planar job's seven, read back in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-w5-kernel-plan.md`
§§ 3.2 and 8.2 and in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-w5base-kernel-plan.md`. Where I5c left them:

> **What is left in this lane (30), and where it stands** (for wave 5's next implementer):
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-I5-implementation.md Stage 13 — SAVED: two wirings in the base, and `stuck_structure_ua` reduced to its flank step

(the list follows there). What I5c handed back, and your slot:

> 284. **FS131-I5c handed back** (Stage 13 SAVED, harness 525k by the task notice; report `fs131-w5`'s `data/fs131/reports/FS131-I5c.md`; commits `c10cf764`,
> — source: plans/FS131-close-inventory.md

> 287. **IM3's slot → wave 5's next implementer, FS131-I5d, on `fs131-w5`; IM3's MERGE findings relayed to IMM1 at once.** Choice: as the handoff queued (item 285):
> — source: plans/FS131-close-inventory.md

The planar job's fence, which stands:

> 274. **Rulings on QA3's held items and the freed slot.** (a) **`InMK`**: restated when its first consumer is planned, not now (no theorem uses it; a definition
> — source: plans/FS131-close-inventory.md

What you may change:

> **It may**: add children anywhere in the wave's modules — every child §§ 4, 9.1 name is an expected addition, and the shared ones may go to the
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-w5-kernel-plan.md ### 10.2 What the implementer may and may not change

`exists_merge`'s colour clause is its vertex instance only (items 268–269); `pair_i` carries `h3` (item 258, which `l3_base` discharges from `ht'`); when you
reach `l3_base`, rewrite `linkage_dot_ne_zero`'s docstring as `plans/FS131-QA3-audit.md` § 2.4 d drafts it (item 274 (b)).

## Done means

1. **Your readback first**: check every quotation above against its source; read I5c's Stages 10–13 and the inventory items named; build `fs131-w5` once as
   given (`728c3502`) before editing anything. Commit and push.
2. **`stuck_flanks_ua`** first: the unit-arc versions of `shaveAvailable_of_not_doublyShadowed`, `flank_ne_of_doublyShadowed` and `outType_*_of_shadow` (new
   lemmas beside them in wave 5's modules, wave 4's statements unchanged), then the flank step; then `exists_isRingArc_of_onRingArc`; then the rest in the order
   you judge; saving after each; no statement changed, no new `axiom`, no `native_decide`; re-price from your first two hard leaves. Do not edit a file while a
   build of it runs. If you need `tools/fs131_i5_dupes.py`, repair its FORK first (item 284).
3. **Your record** (continue it), stages headed "Stage n — SAVED", "Theorems this phase proved"; the report in standing rule 11's form. The gate and the landing
   are a later implementer's. Stopping at a saved stage with leaves left, and naming them, is a good report.

## What is yours to decide

The proofs, their children and order, where a supporting lemma lives within § 10.2's allowance, and whether a shared infrastructure gets its own module (say
so in your report: a second wave-5 implementer could then work beside you). If a leaf cannot be proved as written, stop that leaf, message me at once with the
declaration, the reason, and the smallest counterexample or the missing hypothesis, and go on with the others. Three failed attempts on one route is a dispatch
to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator
can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; four agents are building, so on exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never
evidence; if you mirror oleans for iteration, use a scratch directory of your own (wave 4's `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4/data/fs131/i4/iter.sh` reads it from the variable `S`). The worktree's
`.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`.


## Amendment, 2026-10-04 — `n3_end` moves to wave 5 (inventory item 289)

The ruling, whose first line is:

> 289. **Rulings on I4m's items: `n3_end` moves to wave 5; the next wave-4 job merges the moves branch and proves the bends.** (a) **`n3_end`'s reading** (Stage 38)
> — source: plans/FS131-close-inventory.md

So add `n3_end` (FS112-N3-END), statement and docstring verbatim from wave 4's `BaseSteps`, to wave 5's `Plane/ValidMap/Terminal` beside `n3_end_chain`, and
delete it from this branch's copy of `BaseSteps` (and its `#print axioms` line) in the same commit; it becomes one of your leaves. Its proof needs exactly the
unit-arc versions of `Contact`'s shadow and SHAVE lemmas your `stuck_flanks_ua` builds (item 288), and FS131-I4m's Stage 38 on `fs131-w4` gives its route (no
`hQR`; the split is on an in-type `g`-tile at `N`). You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can
only review work it knows exists).

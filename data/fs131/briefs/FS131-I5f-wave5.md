# Brief FS131-I5f — wave 5 of the Lean backlog, continued: the base's ring lemmas and the walk (`HexRing`, `Cor3`, `BaseWalk`, `Dense`, `BaseDense`) on `fs131-w5`

*Written 2026-10-05 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I5f
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: wave 5's sixth implementer — the non-`Terminal` half of the lane (I5e's split): `HexRing`'s six, `cor3_local`, `BaseWalk`'s four, `Dense`'s `disc1_local`, `BaseDense`'s three, saving after each; never `Terminal` and never the planar job's seven
  launch: now, beside FS131-G4 (wave 4's landing, on `fs131-w4`), FS131-IP3 (the planar chain, on `fs131-w5p`) and FS131-IT1 (T-GRAPH, on `fs131-w5t`), each in its own tree; a `Terminal` implementer joins later in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false (`cor3_local`'s hypotheses above all, item 310), or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I5f.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I5-implementation.md` (on branch `fs131-w5`; you continue it from Stage 22 — standing rule 2's "Resuming")
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5` (branch `fs131-w5`): `Proofs/HadwigerNelson/Plane/ValidMap/HexRing.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/Cor3.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/Dense.lean`, and `Proofs/HadwigerNelson/Plane/ValidMap/BaseWalk.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/BaseDense.lean` outside the planar job's declarations; supporting lemmas in `FlankUA`, `BrickMap`, `Chain` or wave 3–4's foundation modules as plan § 10.2 allows (statements unchanged); `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (your own block, headed "FS131-I5f", above the `=== PURCHASED ===` banner), `plans/FS131-I5-implementation.md`, `tools/fs131_i5_*.py`, `data/fs131/i5f/`, `data/fs131/reports/FS131-I5f.md`; **not** `Proofs/HadwigerNelson/Plane/ValidMap/Terminal.lean` (the later `Terminal` implementer's), `MapGraph.lean`, or wave 4's modules
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are wave 5's sixth implementer, on Opus. Wave 5 is **termination and density**: the terminal valid map the moves reach, the ends of stuck chains,
row 134's base step with unit arcs, and the density results built on it. FS131-I5e moved `cor3` upstream so the hexagonal-ring lemmas can cite it, stated
`cor3_local`, and proved `cor3`, `pseudo_ncard_le_two` and `rot_noThird` over it; it also found a GAP in a filed step behind `Terminal`'s `n3_end`, which an
Ephodos re-derivation (FS131-E5) takes next. So the lane is split by file: you take the base's ring lemmas and the walk; a `Terminal` implementer follows
the re-derivation in its own tree. 31 `sorry` declarations are left on the branch; yours are the 15 named below.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`). Wave 5 lands after
wave 4 and after the planar job; you can prove its leaves now. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

Your leaves, on `fs131-w5` at `6e38803d`, each read back in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-w5-kernel-plan.md` §§ 3.2 and 8.2 and in
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-w5base-kernel-plan.md`. Where I5e left them, and its split:

> **What is left in this lane (24), and where it stands** (for wave 5's next implementers):
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-I5-implementation.md Stage 21 — SAVED: `cor3_local` stated (ruling 218 (b)); `cor3`, `pseudo_ncard_le_two` and `rot_noThird` proved over it

> **A split for a second wave-5 implementer** (ruling 299 (e)), by file, so the two trees merge in disjoint hunks: one implementer on **`Terminal`**
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-I5-implementation.md Stage 21 — SAVED: `cor3_local` stated (ruling 218 (b)); `cor3`, `pseudo_ncard_le_two` and `rot_noThird` proved over it

(both lists continue there: yours is the second set of the split). What I5e handed back, and the ruling that launched you:

> 310. **FS131-I5e handed back** (Stage 21 SAVED, harness ≈ 401k by the task notice; record `fs131-w5`'s `plans/FS131-I5-implementation.md`, Stages 19–21;
> — source: plans/FS131-close-inventory.md

> 311. **Ruling: I5e's slot → FS131-I5f, wave 5's non-`Terminal` half; E5 takes the next slot, whatever wave 4's state.** Choice: I5f on `fs131-w5` takes I5e's
> — source: plans/FS131-close-inventory.md

`cor3_local`, as ruled:

> 218. **Rulings on KB's and IC1's held items** (four parts each, compressed where the alternative is plain).
> — source: plans/FS131-close-inventory.md

(its part (b)). The planar job's fence, which stands:

> 274. **Rulings on QA3's held items and the freed slot.** (a) **`InMK`**: restated when its first consumer is planned, not now (no theorem uses it; a definition
> — source: plans/FS131-close-inventory.md

What you may change:

> **It may**: add children anywhere in the wave's modules — every child §§ 4, 9.1 name is an expected addition, and the shared ones may go to the
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-w5-kernel-plan.md ### 10.2 What the implementer may and may not change

`exists_merge` has left wave 4 (item 295 below), so nothing in wave 5 may cite it:

> 295. **Ruling: MERGE leaves wave 4; the freed slot goes to FS131-IX1 as ruled.** Choice: (a) wave 4 lands without `exists_merge` — at wave 4's merge-and-gate,
> — source: plans/FS131-close-inventory.md

`pair_i` carries `h3` (item 258, which `l3_base` discharges from `ht'`); when you reach `l3_base`, rewrite `linkage_dot_ne_zero`'s docstring as
`plans/FS131-QA3-audit.md` § 2.4 d drafts it (item 274 (b)).

## Done means

1. **Your readback first**: check every quotation above against its source; read I5e's Stages 19–21 and the inventory items named; build `fs131-w5` once as
   given (`6e38803d`) before editing anything. Commit and push.
2. **`cor3_local`** early (five theorems wait on it): if its proof needs more than its hypotheses give, stop it and message me with what it needs — the statement
   comes back through me. Then `rot_out`, `rot_in` and the rest of your set in the order you judge, saving after each; no statement changed, no new `axiom`, no
   `native_decide`; re-price from your first two hard leaves. Do not edit a file while a build of it runs. If you need `tools/fs131_i5_dupes.py`, repair its
   FORK first (item 284).
3. **Your record** (continue it), stages headed "Stage n — SAVED", "Theorems this phase proved"; the report in standing rule 11's form. The gate and the landing
   are a later implementer's. Stopping at a saved stage with leaves left, and naming them, is a good report.

## What is yours to decide

The proofs, their children and order, and where a supporting lemma lives within § 10.2's allowance (never in `Terminal`). If a leaf cannot be proved as written,
stop that leaf, message me at once with the declaration, the reason, and the smallest counterexample or the missing hypothesis, and go on with the others.
Three failed attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1:
delegation is one level deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; four agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence; I5d's
iteration script is `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/data/fs131/i5d/iter.sh` (it mirrors oleans in a scratch directory outside the repository — use your own directory). The worktree's
`.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`.

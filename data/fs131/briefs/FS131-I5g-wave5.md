# Brief FS131-I5g — wave 5 of the Lean backlog, continued: the base's walk leaves and the hexagonal ring on `fs131-w5`

*Written 2026-10-05 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I5g
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: wave 5's seventh implementer — the non-`Terminal` half, continued: `row134BaseUA`'s four leaves first, then the hexagonal ring's five, then `exists_preBend` with the strengthened-bend child, saving after each; never `Terminal`, `cv_exists`, `disc1_local`, or the planar job's seven
  launch: now, beside FS131-G4 (wave 4's landing, on `fs131-w4`), FS131-IP4 (the planar chain, on `fs131-w5p`) and FS131-E5 (an Ephodos re-derivation, in the main tree)
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, a strengthened bend that needs more than wave 4's bend machinery, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I5g.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I5-implementation.md` (on branch `fs131-w5`; you continue it from Stage 25 — standing rule 2's "Resuming")
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5` (branch `fs131-w5`): `Proofs/HadwigerNelson/Plane/ValidMap/HexRing.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/Cor3.lean`, and `Proofs/HadwigerNelson/Plane/ValidMap/BaseWalk.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/BaseDense.lean` outside the planar job's declarations and outside `cv_exists`; supporting lemmas in `FlankUA`, `BrickMap`, `Chain` or wave 3–4's foundation modules as plan § 10.2 allows (statements unchanged); `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (your own block, headed "FS131-I5g", above the `=== PURCHASED ===` banner), `plans/FS131-I5-implementation.md`, `tools/fs131_i5_*.py`, `data/fs131/i5g/`, `data/fs131/reports/FS131-I5g.md`; **not** `Proofs/HadwigerNelson/Plane/ValidMap/Terminal.lean`, `Dense.lean`, `MapGraph.lean`, or wave 4's modules
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read the harness's count, not your own

Hello. You are wave 5's seventh implementer, on Opus. Wave 5 is **termination and density**: the terminal valid map the moves reach, the ends of stuck
chains, row 134's base step with unit arcs, and the density results built on it. FS131-I5f proved `cor3_local` (so `cor3` and four results over it are
kernel theorems) and `exists_pseudoCircle`, and wired `row134BaseUA` — the base step — over its leaves, which showed every leaf's statement composes with
the others as stated. 28 `sorry` declarations are left on the branch; yours are the ten named below. An Ephodos job is re-deriving a step behind
`Terminal`, whose implementer follows in its own tree.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`). Wave 5 lands after
wave 4 and after the planar job; you can prove its leaves now, and four of yours, with the planar job's three, are all `row134BaseUA` rests on. Kooshi, on
pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

Your leaves, on `fs131-w5` at `d61edefc`, each read back in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-w5-kernel-plan.md` §§ 3.2 and 8.2 and in
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-w5base-kernel-plan.md`. Where I5f left them — read the whole list there, with its construction for `reduce`:

> **What is left of my set (12), and where it stands** (for wave 5's next implementer on this half):
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-I5-implementation.md Stage 24 — SAVED: `exists_pseudoCircle` proved (a kernel theorem); the periodicity glue moved upstream to `BaseWalk`

> - **`exists_preBend`** (`n3_base`'s pre-bend): needs `bend_toward` (`sorry` on this branch, proved on `fs131-w4` by I4n) iterated over the finitely
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-I5-implementation.md Stage 24 — SAVED: `exists_pseudoCircle` proved (a kernel theorem); the periodicity glue moved upstream to `BaseWalk`

(it continues there). What I5f handed back, and the rulings that launched you:

> 316. **FS131-I5f handed back** (Stage 24 SAVED, harness ≈ 569k by the task notice; record `fs131-w5`'s `plans/FS131-I5-implementation.md`, Stages 22–24;
> — source: plans/FS131-close-inventory.md

> 317. **Rulings on I5f's questions, and its slot.** (a) **I5f's slot → FS131-I5g on `fs131-w5`**, the same half: `row134BaseUA`'s four first (`reduce` by I5f's
> — source: plans/FS131-close-inventory.md

(its parts (a)–(b) are your order and the strengthened bend; (c)–(d) are the leaves that are not yours). E4-BEND-UN, which fixes the strengthened bend's
content, is in FS131-E4's derivation:

> 226. **FS131-E4 done, harness ≈ 480k** (report `data/fs131/reports/FS131-E4.md`; record `plans/FS131-E4-derivation.md`; commits `fffe465f` … `e2928a7b`, checked;
> — source: plans/FS131-close-inventory.md

(read `plans/FS131-E4-derivation.md` for E4-BEND-UN in full). The planar job's fence, which stands:

> 274. **Rulings on QA3's held items and the freed slot.** (a) **`InMK`**: restated when its first consumer is planned, not now (no theorem uses it; a definition
> — source: plans/FS131-close-inventory.md

What you may change:

> **It may**: add children anywhere in the wave's modules — every child §§ 4, 9.1 name is an expected addition, and the shared ones may go to the
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-w5-kernel-plan.md ### 10.2 What the implementer may and may not change

`exists_merge` has left wave 4, so nothing in wave 5 may cite it:

> 295. **Ruling: MERGE leaves wave 4; the freed slot goes to FS131-IX1 as ruled.** Choice: (a) wave 4 lands without `exists_merge` — at wave 4's merge-and-gate,
> — source: plans/FS131-close-inventory.md

`pair_i` carries `h3` (item 258, which `l3_base` discharges from `ht'`); when you reach `l3_base`, rewrite `linkage_dot_ne_zero`'s docstring as
`plans/FS131-QA3-audit.md` § 2.4 d drafts it (item 274 (b)).

## Done means

1. **Your readback first**: check every quotation above against its source; read I5f's Stages 22–24 and the inventory items named; build `fs131-w5` once as
   given (`d61edefc`) before editing anything. Commit and push.
2. **The order of item 317 (a)**: `reduce`, `select`, `l3_base`, `bv_hex`; then `rot_out`, `rot_in`, `hex_regular`, `bv_nd`, `bv_l3`; then `exists_preBend`
   over the strengthened-bend child you state and read back against E4-BEND-UN. Save after each leaf; no statement changed, no new `axiom`, no `native_decide`;
   re-price from your first two hard leaves. Do not edit a file while a build of it runs. Run `tools/fs131_i5_stmt_check.py` against `d61edefc` before each
   stage commit.
3. **Your record** (continue it), stages headed "Stage n — SAVED", "Theorems this phase proved"; the report in standing rule 11's form. The gate and the landing
   are a later implementer's. Stopping at a saved stage with leaves left, and naming them, is a good report.

## What is yours to decide

The proofs, their children and order within item 317's, the strengthened bend's exact statement (read back against E4-BEND-UN), and where a supporting lemma
lives within § 10.2's allowance (never in `Terminal` or `Dense`). If a leaf cannot be proved as written, stop that leaf, message me at once with the
declaration, the reason, and the smallest counterexample or the missing hypothesis, and go on with the others. Three failed attempts on one route is a
dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level deep, because the
coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; several agents are building, so
on exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence; I5f's
iteration script is `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/data/fs131/i5f/iter.sh` (use your own scratch directory). The worktree's `.lake/build` is its own copy; never replace it with a
symlink. Nothing with a `sorry` reaches `main`.

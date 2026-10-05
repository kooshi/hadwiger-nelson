# Brief FS131-I5j — wave 5 of the Lean backlog, the non-`Terminal` half continued: `coneAt_of_cubic`, the hexagonal ring and the pre-bend on `fs131-w5`

*Written 2026-10-05 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I5j
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: wave 5's non-`Terminal` half, continued from FS131-I5g's Stage 29 — `coneAt_of_cubic`, then `bv_hex` and `hex_regular`, then `rot_out`, `rot_in`, `bv_nd`, `bv_l3`, then `exists_preBend`, saving after each; never `Terminal`, `cv_exists`, `disc1_local`, or the planar job's declarations
  launch: now, beside FS131-IP5 (the planar chain, on `fs131-w5p`) and FS131-I5i (wave 5's `Terminal` half, on `fs131-w5c`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, a strengthened bend that needs more than wave 4's bend machinery, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I5j.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I5-implementation.md` (on branch `fs131-w5`; you continue it from Stage 30)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5` (branch `fs131-w5`): `Proofs/HadwigerNelson/Plane/ValidMap/HexRing.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/Cor3.lean`, and `Proofs/HadwigerNelson/Plane/ValidMap/BaseWalk.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/BaseDense.lean` outside the planar job's declarations and outside `cv_exists`; supporting lemmas in `FlankUA`, `BrickMap`, `Chain` or wave 3–4's foundation modules as plan § 10.2 allows (statements unchanged; `coneAt_of_cubic` where plan § 9.1 puts it); `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (the block headed "FS131-I5g", which you extend, above the `=== PURCHASED ===` banner), `plans/FS131-I5-implementation.md`, `tools/fs131_i5_*.py`, `data/fs131/i5g/`, `data/fs131/i5j/`, `data/fs131/reports/FS131-I5j.md`; **not** `Proofs/HadwigerNelson/Plane/ValidMap/Terminal.lean`, `Dense.lean`, `MapGraph.lean`, or wave 4's modules
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are continuing wave 5's non-`Terminal` half, on Opus. Wave 5 is **termination and density**: the terminal valid map the moves reach, the ends of
stuck chains, row 134's base step with unit arcs, and the density results built on it. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones; waves 1–4 and Woodall's chain are on `main`. FS131-I5g has just proved `reduce`, `select` and `l3_base` (the last with no velocity
argument), so on this half `row134BaseUA` — the base step — now rests only on `bv_hex`, with the planar job's three. 25 `sorry` declarations are left on the
branch; yours are the seven named below.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and wave 5 lands only
when its three lanes finish. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

Your leaves, on `fs131-w5` at `f0c6ba67` — `bv_hex`, `rot_out`, `rot_in`, `hex_regular`, `bv_nd`, `bv_l3`, `exists_preBend` — each read back in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-w5-kernel-plan.md` §§ 3.2
and 8.2 and in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-w5base-kernel-plan.md`. Where I5g left them — read its Stage 29 in full,
the route notes above all:

> **What is left of my set (7)**, for wave 5's next implementer on this half:
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-I5-implementation.md Stage 29 — SAVED: the handoff (what is left of this half, and where it stands)

> - **`bv_hex`** (**H**; the last of this half on `row134BaseUA`'s path — with the planar job's three, all `row134BaseUA` now rests on). BASE-V § 1a.4
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-I5-implementation.md Stage 29 — SAVED: the handoff (what is left of this half, and where it stands)

> - **`rot_out`, `rot_in`** (M each), **`hex_regular`** (M, over `coneAt_of_cubic`), **`bv_nd`** (M–H: BASE-V § 1b.2 steps 2–4, the unit-arc tangency
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-I5-implementation.md Stage 29 — SAVED: the handoff (what is left of this half, and where it stands)

> - **`exists_preBend`** (H): needs the strengthened bend (ruling 317 (b): a child of `exists_preBend`, read back against E4-BEND-UN, citing
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-I5-implementation.md Stage 29 — SAVED: the handoff (what is left of this half, and where it stands)

What I5g handed back, and the rulings that launch you:

> 330. **FS131-I5g handed back** (Stage 29 SAVED, harness ≈ 715k by the task notice — its own estimate ≈ 330k; budgets are guidance; record `fs131-w5`'s
> — source: plans/FS131-close-inventory.md

> 331. **Rulings on I5g's held items, and its slot.** (a) **`set_option maxHeartbeats 400000 in` on `exists_linkage`: accepted.** Alternative weighed: splitting
> — source: plans/FS131-close-inventory.md

The strengthened bend (ruling 317 (b)), and E4-BEND-UN, which fixes its content:

> 317. **Rulings on I5f's questions, and its slot.** (a) **I5f's slot → FS131-I5g on `fs131-w5`**, the same half: `row134BaseUA`'s four first (`reduce` by I5f's
> — source: plans/FS131-close-inventory.md

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

## Done means

1. **Your readback first**: check every quotation above against its source; read I5g's Stages 25–29 and the inventory items named; build `fs131-w5` once as
   given (`f0c6ba67`) before editing anything. Commit and push.
2. **The order of item 331 (b)**: `coneAt_of_cubic` (with a spec example), then `bv_hex` and `hex_regular` over it; then `rot_out`, `rot_in`, `bv_nd`, `bv_l3`;
   then `exists_preBend` over the strengthened-bend child you state and read back against E4-BEND-UN, citing `bend_toward` as given. Fix `l3_base`'s docstring
   (item 330's correction) at your first build. Save after each leaf; no statement changed, no new `axiom`, no `native_decide`; re-price from your first two hard
   leaves. Do not edit a file while a build of it runs. Run `tools/fs131_i5_stmt_check.py` against `d61edefc` before each stage commit.
3. **Your record** (continue it), stages headed "Stage n — SAVED", "Theorems this phase proved", each with its build log and an axioms print against that build's
   oleans including a control on `sorryAx`; the report in standing rule 11's form. You do not merge into another branch, take `main` into this branch, run the
   gate, or touch `main`. Stopping at a saved stage with leaves left, and naming them, is a good report.

## What is yours to decide

The proofs, their children and order within item 331's, `coneAt_of_cubic`'s exact form, the strengthened bend's exact statement (read back against
E4-BEND-UN), and where a supporting lemma lives within § 10.2's allowance (never in `Terminal` or `Dense`). I5g's routes are notes, not rules. If a leaf cannot
be proved as written, stop that leaf, message me at once with the declaration, the reason, and the smallest counterexample or the missing hypothesis, and go
on with the others. Three failed attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own
(standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence; I5g's
`data/fs131/i5g/iter.sh` and its scratch mirror are yours to reuse. The worktree's `.lake/build` is its own copy; never replace it with a symlink. Nothing with
a `sorry` reaches `main`.

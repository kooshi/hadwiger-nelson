# Brief FS131-I5m — wave 5 of the Lean backlog, the non-`Terminal` half finished: `rot_in`, `bv_nd`, `bv_l3` and the pre-bend on `fs131-w5`

*Written 2026-10-05 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I5m
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: wave 5's non-`Terminal` half, continued from FS131-I5j's Stage 33 — `rot_in`, then `bv_nd`, `bv_l3`, then `exists_preBend` over the strengthened-bend child, saving after each; never `Terminal`, `cv_exists`, `disc1_local`, or the planar jobs' declarations
  launch: now, beside FS131-RW1 (the boundary walk's WALK lane, on `fs131-w5p`) and FS131-I5l (wave 5's `Terminal` half, on `fs131-w5c`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, a strengthened bend that needs more than wave 4's bend machinery, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I5m.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I5-implementation.md` (on branch `fs131-w5`; you continue it from Stage 34)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5` (branch `fs131-w5`): `Proofs/HadwigerNelson/Plane/ValidMap/HexRing.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/Cor3.lean`, and `Proofs/HadwigerNelson/Plane/ValidMap/BaseWalk.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/BaseDense.lean` outside the planar jobs' declarations and outside `cv_exists`; supporting lemmas in `FlankUA`, `BrickMap`, `Chain` or wave 3–4's foundation modules as plan § 10.2 allows (statements unchanged); `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (the block headed "FS131-I5g", which you extend, above the `=== PURCHASED ===` banner), `plans/FS131-I5-implementation.md`, `tools/fs131_i5_*.py`, `data/fs131/i5j/`, `data/fs131/i5m/`, `data/fs131/reports/FS131-I5m.md`; **not** `Proofs/HadwigerNelson/Plane/ValidMap/Terminal.lean`, `Dense.lean`, `MapGraph.lean`, or wave 4's modules
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are finishing wave 5's non-`Terminal` half, on Opus. Wave 5 is **termination and density**: the terminal valid map the moves reach, the ends of
stuck chains, row 134's base step with unit arcs, and the density results built on it. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones; waves 1–4 and Woodall's chain are on `main`. On this half FS131-I5j proved `coneAt_of_cubic`, `hex_regular`, `bv_hex` and `rot_out`, so
`row134BaseUA` — the base step — now rests only on the planar jobs' three. Four leaves are left here, none on the base step's path; they are yours.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and wave 5 lands only
when its lanes finish. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

Your leaves, on `fs131-w5` at `298a3c0b` — `rot_in`, `bv_nd`, `bv_l3`, `exists_preBend` — each read back in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-w5-kernel-plan.md` §§ 3.2 and 8.2 and in
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-w5base-kernel-plan.md`. Where I5j left them — read its Stage 33 in full, the route notes
above all:

> - **`rot_in`** (M): the mirror of `rot_out` (stage 32). Children to add, each a mirror of a stage-31 lemma: `hex_side_far` (a germ in the closure of
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-I5-implementation.md Stage 33 — SAVED: the handoff (what is left of this half, and where it stands)

> - **`bv_nd`** (M–H): BASE-V § 1b.2 steps 2–4. H at `x₀`, `y₀` (no four colours, no repeated colour) makes each cubic or interior; step 2 is
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-I5-implementation.md Stage 33 — SAVED: the handoff (what is left of this half, and where it stands)

> - **`bv_l3`** (H): I5g's note stands — with `RingProper` the rings are wave 3's `ringCircleColouring`s, `exists_linkage` and `link_path` apply as in
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-I5-implementation.md Stage 33 — SAVED: the handoff (what is left of this half, and where it stands)

> - **`exists_preBend`** (H): the strengthened bend (ruling 317 (b)), not attempted in this job; E4-BEND-UN not read here.
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-I5-implementation.md Stage 33 — SAVED: the handoff (what is left of this half, and where it stands)

What I5j handed back, and the ruling that launches you:

> 336. **FS131-I5j handed back** (Stage 33 SAVED, harness ≈ 440k by the task notice; record `fs131-w5`'s `plans/FS131-I5-implementation.md`, Stages 30–33; report
> — source: plans/FS131-close-inventory.md

> 344. **Rulings on IMM2's held items, and its slot.** (a) **`exists_gap`'s clause restated: accepted** — a child of this lane's own, not a backlog statement;
> — source: plans/FS131-close-inventory.md

The strengthened bend (ruling 317 (b)), and E4-BEND-UN, which fixes its content:

> 317. **Rulings on I5f's questions, and its slot.** (a) **I5f's slot → FS131-I5g on `fs131-w5`**, the same half: `row134BaseUA`'s four first (`reduce` by I5f's
> — source: plans/FS131-close-inventory.md

> 226. **FS131-E4 done, harness ≈ 480k** (report `data/fs131/reports/FS131-E4.md`; record `plans/FS131-E4-derivation.md`; commits `fffe465f` … `e2928a7b`, checked;
> — source: plans/FS131-close-inventory.md

(read `plans/FS131-E4-derivation.md` for E4-BEND-UN in full; `bend_toward` is `sorry` on this branch and proved on `main` — cite it by statement). The planar
job's fence, which stands:

> 274. **Rulings on QA3's held items and the freed slot.** (a) **`InMK`**: restated when its first consumer is planned, not now (no theorem uses it; a definition
> — source: plans/FS131-close-inventory.md

What you may change:

> **It may**: add children anywhere in the wave's modules — every child §§ 4, 9.1 name is an expected addition, and the shared ones may go to the
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-w5-kernel-plan.md ### 10.2 What the implementer may and may not change

`exists_merge` has left wave 4, so nothing in wave 5 may cite it:

> 295. **Ruling: MERGE leaves wave 4; the freed slot goes to FS131-IX1 as ruled.** Choice: (a) wave 4 lands without `exists_merge` — at wave 4's merge-and-gate,
> — source: plans/FS131-close-inventory.md

## Done means

1. **Your readback first**: check every quotation above against its source; read I5j's Stages 30–33 and I5g's Stage 29 route notes; build `fs131-w5` once as
   given (`298a3c0b`) before editing anything. Commit and push.
2. **The order**: `rot_in` (measured); then `bv_nd`, `bv_l3`; then `exists_preBend` over the strengthened-bend child you state and read back against
   E4-BEND-UN, citing `bend_toward` as given. Save after each leaf; no statement changed, no new `axiom`, no `native_decide`; re-price from your first two hard
   leaves. Run `tools/fs131_i5_stmt_check.py` against `d61edefc` before each stage commit. Do not edit a file while a build of it runs.
3. **Your record** (continue it), stages headed "Stage n — SAVED", "Theorems this phase proved", each with its build log and an axioms print against that build's
   oleans including a control on `sorryAx`; the report in standing rule 11's form. You do not merge into another branch, take `main` into this branch, run the
   gate, or touch `main`. Stopping at a saved stage with leaves left, and naming them, is a good report.

## What is yours to decide

The proofs, their children and order within the order's dependencies, the strengthened bend's exact statement (read back against E4-BEND-UN), and where a
supporting lemma lives within § 10.2's allowance (never in `Terminal` or `Dense`). I5j's routes are notes, not rules. If a leaf cannot be proved as written,
stop that leaf, message me at once with the declaration, the reason, and the smallest counterexample or the missing hypothesis, and go on with the others.
Three failed attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1:
delegation is one level deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence; I5g's
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/data/fs131/i5g/iter.sh` and its scratch mirror are yours to reuse. The worktree's `.lake/build` is its own copy; never replace it with a symlink. Nothing with
a `sorry` reaches `main`.

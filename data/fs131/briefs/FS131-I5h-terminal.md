# Brief FS131-I5h — wave 5 of the Lean backlog: the `Terminal` half (stuck chains' ends, the CV-HD cluster, the terminal map) on its own branch `fs131-w5c`

*Written 2026-10-05 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I5h
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: wave 5's `Terminal` implementer — FS131-E5's two lemmas as children, then `n3_end_of_not_inType`, `cv_class`, the CV-HD cluster, `exists_red`, `exists_terminal`, then `cv_exists`, on branch `fs131-w5c`, saving after each
  launch: now, beside FS131-WL1 (Woodall's landing, on `fs131-ww`), FS131-I5g (wave 5's other half, on `fs131-w5`) and FS131-IP4 (the planar chain, on `fs131-w5p`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, a step of E5's derivation that fails in Lean, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I5h.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I5-implementation.md` (on branch `fs131-w5c`; you continue it from Stage 27, headed as yours — I5g writes stages on `fs131-w5` meanwhile, and the merge keeps both)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c` (branch `fs131-w5c`): `Proofs/HadwigerNelson/Plane/ValidMap/Terminal.lean`; in `Proofs/HadwigerNelson/Plane/ValidMap/BaseDense.lean` only `cv_exists` and children beside it; supporting lemmas in `FlankUA` or a new module upstream of `Terminal` (statements of other files unchanged); `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (your own block, headed "FS131-I5h", above the `=== PURCHASED ===` banner), `plans/FS131-I5-implementation.md`, `tools/fs131_i5h_*.py`, `data/fs131/i5h/`, `data/fs131/reports/FS131-I5h.md`; **not** `HexRing`, `Cor3`, `BaseWalk`, `Dense`, `MapGraph` or `BaseDense` outside `cv_exists` (I5g's and the planar job's), nor wave 4's modules
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read the harness's count, not your own

Hello. You are taking the `Terminal` half of wave 5 of the Lean backlog. Wave 5 is **termination and density**: the terminal valid map the moves reach,
the ends of stuck chains, row 134's base step with unit arcs, and the density results built on it. The milestone, FS-131, turns this project's hand-derived
results into kernel-checked ones; waves 1–4 are on `main`. Two of your leaves stopped at a GAP in a filed hand step (NB3-END item 2, and the same one-line
exclusion in FS114-CVB § 1.4 item 5); FS131-E5 has now derived both, with no statement change, through two lemmas you formalize first. Your branch starts
from `fs131-w5` at `75689a4c`; wave 5's other half runs beside you on `fs131-w5`, in other files.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`). Wave 5 lands after
the planar job; you can prove its leaves now. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

Your leaves, on `fs131-w5c` at `75689a4c`, each read back in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-w5-kernel-plan.md` §§ 3.2 and 8.2. Where I5e left `Terminal`, and where I5f
left `cv_exists`:

> - **`Terminal` (9)**: `n3_end_of_not_inType` — **held for an Ephodos re-derivation** (stage 20's GAP at NB3-END item 2; the limit directions are in
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-I5-implementation.md Stage 21 — SAVED: `cor3_local` stated (ruling 218 (b)); `cor3`, `pseudo_ncard_le_two` and `rot_noThird` proved over it

> - **`cv_exists`**: over `exists_terminal` (`Terminal`, `sorry`) and `dense3`; but `exists_terminal`'s clause 3 lets a run end within `1` of an (R2)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-I5-implementation.md Stage 24 — SAVED: `exists_pseudoCircle` proved (a kernel theorem); the periodicity glue moved upstream to `BaseWalk`

(both continue there). E5's verdicts and the rulings that launched you:

> 320. **E5's Q1 verdict, by message: NB3-END item 2 and FS114-CVB § 1.4 item 5 are DERIVED** (FS131-E5, mid-job; record `plans/FS131-E5-derivation.md` § 3,
> — source: plans/FS131-close-inventory.md

> 321. **FS131-E5 done: both steps hold, no statement changes** (harness ≈ 491k by the task notice; record `plans/FS131-E5-derivation.md`, Stages 1–5; report
> — source: plans/FS131-close-inventory.md

> 322. **Rulings on E5's held items, and its slot.** (a) **D1–D3** are corrections to filed derivation records: held for the milestone's filing with the other
> — source: plans/FS131-close-inventory.md

(its part (c) is your order). E5's derivations, your route for the two leaves — read § 3 in full:

> ### 3.4 NB3-END item 2, derived
> — source: plans/FS131-E5-derivation.md

> ### 3.5 FS114-CVB § 1.4 item 5, and `cv_class`'s "None" case, derived
> — source: plans/FS131-E5-derivation.md

The planar job's fence, which stands:

> 274. **Rulings on QA3's held items and the freed slot.** (a) **`InMK`**: restated when its first consumer is planned, not now (no theorem uses it; a definition
> — source: plans/FS131-close-inventory.md

What you may change:

> **It may**: add children anywhere in the wave's modules — every child §§ 4, 9.1 name is an expected addition, and the shared ones may go to the
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-w5-kernel-plan.md ### 10.2 What the implementer may and may not change

`exists_merge` has left wave 4 (it lands later on its own), so nothing in wave 5 may cite it:

> 295. **Ruling: MERGE leaves wave 4; the freed slot goes to FS131-IX1 as ruled.** Choice: (a) wave 4 lands without `exists_merge` — at wave 4's merge-and-gate,
> — source: plans/FS131-close-inventory.md

## Done means

1. **Your readback first**: check every quotation above against its source; read E5's record § 3 in full and I5d's and I5e's notes under `n3_end` (record
   Stages 18 and 20.2); build `fs131-w5c` once as given (`75689a4c`) before editing anything. Commit and push.
2. **The order of item 322 (c)**: e5-sh and e5-sep as children (their statements read back against E5's § 3.1 and § 3.3 in your record), then
   `n3_end_of_not_inType`, `cv_class`, the CV-HD cluster (`cv_hd_main`, `y3_end_needs`, `cv_hd`, `c_double`, `c_ends`), `exists_red`, `exists_terminal`, then
   `cv_exists`. Save after each leaf; no statement changed, no new `axiom`, no `native_decide`; re-price from your first two hard leaves. Do not edit a file
   while a build of it runs.
3. **The handover**: your record's last stage says what is proved and what is left, with the build log and an axioms print against that build's oleans,
   including a control that must show `sorryAx`. You do not merge into `fs131-w5`, run the gate, or touch `main`; the merge happens on my word.
4. **Your record**, stages headed "Stage n — SAVED (FS131-I5h)", "Theorems this phase proved"; the report in standing rule 11's form. Stopping at a saved stage
   with leaves left, named, is a good report.

## What is yours to decide

The proofs, their children and order after the two lemmas, where a supporting lemma lives within your touches, and whether E5's lemmas take exactly its stated
form or a stronger one you find (say which). If a step of E5's derivation fails in Lean, stop that leaf and message me with the step and the smallest
counterexample or the missing hypothesis — it goes back to Ephodos. Three failed attempts on one route is a dispatch to the companion your identity names,
never a fourth. You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; several agents are building, so
on exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy (from `fs131-w5x`; the first build rebuilds what differs, which is much); never replace it with a symlink. Nothing
with a `sorry` reaches `main`.

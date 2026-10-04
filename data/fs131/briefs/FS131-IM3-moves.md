# Brief FS131-IM3 — wave 4's three moves (third implementer) (`exists_shave`, `exists_rayMerge`, `exists_merge`), in a module of their own upstream of `Contact`

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IM3
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: move the moves' machinery into a new module `Plane/ValidMap/Surgery` (inventory item 279), then prove wave 4's three simplifying moves as the `…_aux` lemmas in `Plane/ValidMap/Moves` — SHAVE's three cases, RAY, MERGE — on branch `fs131-w4m`; hand the branch over for merging
  launch: now, beside FS131-I4l (wave 4, on `fs131-w4`), FS131-I5c (wave 5, on `fs131-w5`) and FS131-KP (the planar planner, on `fs131-w5p`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a move that cannot be proved as written, a `Contact` lemma a move turns out to need, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-IM3.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IM-implementation.md` (on branch `fs131-w4m`; continue its stages from Stage 7)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4m` (branch `fs131-w4m`): modules `Proofs/HadwigerNelson/Plane/ValidMap/Moves.lean`, the new `Proofs/HadwigerNelson/Plane/ValidMap/Surgery.lean` (item 279), and (item 254) `Proofs/HadwigerNelson/Plane/ValidMap/Cone.lean` (importing what `Contact` imports — `Plane/ValidMap/Basic`, `Plane/Tiles`, `Plane/SVMap` — and never `Contact`), additions to `Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean` (engine 2's exact hunk, and supporting lemmas, statements unchanged), `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (the block headed "FS131-IM1", which you extend), `plans/FS131-IM-implementation.md`, `tools/fs131_im_*.py`, `data/fs131/im/`, `data/fs131/reports/FS131-IM3.md`; **not** `Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean` (FS131-IC5's) except the deletions of items 254 and 263 and the import and namespace lines they need, nor wave 4's other modules
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k



Hello. You are joining wave 4 of the Lean backlog, on Opus, at its longest path: the three simplifying moves — SHAVE, MERGE-RAY and MERGE — proved as
`…_aux` lemmas in `Plane/ValidMap/Moves`, upstream of `Contact`, which cites them at the merge. Two implementers have been here. FS131-IM1 created `Moves`
and `Cone` and designed one surgery for all three moves; FS131-IM2 finished moving `Contact`'s prefix into `Cone`, applied a statement fix to `exists_merge`,
and proved the shared machinery — 93 theorems and the cut, `Near.exists_cut` — all on the standard three axioms. None of the three moves is proved yet,
and IM2's record says exactly how each closes. Your tree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4m` is built at the branch head `9ffc2aba`.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`). Wave 4 gates Woodall's
landing and wave 5's, and its moves are the last thing between it and its gate: the rest of wave 4 is proved or being finished on `fs131-w4`.

## The statements

The three are `exists_shave_aux`, `exists_rayMerge_aux` and `exists_merge_aux` in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4m/Proofs/HadwigerNelson/Plane/ValidMap/Moves.lean`,
copied from `Contact`'s `exists_shave`, `exists_rayMerge`, `exists_merge` and checked by `tools/fs131_im_statements.py` against `d4f946ae` plus the table of
ruled amendments (`tools/fs131_im_amend.py`; item 269 is its one entry). You prove each under its exact statement. Where IM2 left them:

> **SHAVE (`exists_shave_aux`)**, three cases on the flank colours (one fewer than § 3.2's table: when `g = c` or `h = c` no recolouring is
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4m/plans/FS131-IM-implementation.md 6.3 What is left, in order, and the price

(the section continues there: SHAVE's three cases with their glue, RAY as the cut generalised to a run, MERGE without the full rim circle, and the split).
What IM2 handed back, and the ruling on your work:

> 278. **FS131-IM2 handed back** (Stage 6 SAVED, harness ≈ 505k; report `fs131-w4m`'s `data/fs131/reports/FS131-IM2.md`; commits `aee53d57`, `fe10562b`,
> — source: plans/FS131-close-inventory.md

> 279. **Ruling: the moves' machinery becomes `Plane/ValidMap/Surgery`, and FS131-IM3 continues on `fs131-w4m`.** Choice: IM3 first moves IM2's machinery (`Moves`
> — source: plans/FS131-close-inventory.md

RAY's route carries a correction to its hand proof:

> 262. **Corrections, slips and a tool defect from IM1's report.** (a) **Correction owed — N4-RAY's route**: recolouring the whole gap merges every `c`-sector
> — source: plans/FS131-close-inventory.md

(its part (a): merge `H₁` with the nearest `c`-horn above it, which the statement's `∃` allows). What wave 4's implementers may change:

> **It may**: add children anywhere in the wave's modules — the seven engines and every child § 13 names are expected additions (the engines in the
> — source: .claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md 14.2 What the implementer may and may not change

Their conclusions' form, as wave 5 will read them:

> - **The moves' form (G-MOVES-UA)**: `exists_shave`, `exists_rayMerge`, `exists_merge` hold with unit arcs and conclude `F'.RingArcsWithin F` (no unit arc
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md ### 14.5 Notes for wave 5's planner (from wave 4's planners; Keryx's rulings in brackets)

Wave 5 will also want strengthened forms (every point of four or more colours after a move had them before, `IsModification`): add them as new lemmas if they
come cheaply, never as a change to the three statements.

## Done means

1. **Your readback first**: check every quotation above against its source; read IM2's Stages 5–6 (§ 6.3 above all) and IM1's § 3; build the branch once as
   given (`9ffc2aba`). Commit and push.
2. **The split** (item 279): IM2's machinery, from `/-! ## The chart near its point` through `Near.exists_cut`, moved verbatim into
   `Proofs/HadwigerNelson/Plane/ValidMap/Surgery.lean` (importing what it reads, upstream of `Moves`), deleted from `Moves`, which imports it; checked byte for
   byte by a script with a negative control watched red; `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (records are by name, so unchanged) updated; a
   green build with only `Moves`' three `sorry` warnings. Commit — this stage alone is a good hand-back if nothing else lands.
3. **The moves**: SHAVE's three cases in § 6.3's order, then RAY, then MERGE; saving after each case or child; no statement changed, no new `axiom`, no
   `native_decide`; re-price from the first. Do not edit a file while a build of it runs.
4. **The handover**: your record's last stage says what is proved and what is left, with the build log and an axioms print against that build's oleans. You do not
   edit `Contact`, merge into another branch, or run wave 4's gate — the merge into `fs131-w4` and the three citations happen on my word (item 267: this branch now
   merges into `fs131-w4`, which holds the finished `Contact` lane). Never push to `main`.
5. **Your record**, stages headed "Stage n — SAVED", "Theorems this phase proved"; the report in standing rule 11's form. Stopping at a saved stage with a move
   left, named, is a good report.

## What is yours to decide

The proofs, their children and where they live (in `Surgery`, in `Moves`, or, statements unchanged, in `Basic`), and the order within each move. If a move turns
out to need a lemma that lives only in `Contact` below `woodallCone_isHorn`, message me; it then moves too, never a copy. If a move cannot be proved as written,
stop it, message me with the declaration, the reason, and the smallest counterexample or the missing hypothesis, and go on with the others. Three failed
attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one
level deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; on exit 75 wait ten minutes and
retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence; mirror oleans in a scratch directory of your
own. The worktree's `.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`.

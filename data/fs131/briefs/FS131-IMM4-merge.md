# Brief FS131-IMM4 — MERGE's last two clauses, so `exists_merge_aux` lands, on `fs131-w4mm`

*Written 2026-10-05 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IMM4
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: MERGE's fourth implementer — prove FS131-IMM3's two open leaves on `fs131-w4mm` (`merge_not_hasRepeatedColour_rim`, then `merge_allowedCone`), from its Stage 9, so `exists_merge_aux` carries no `sorryAx`
  launch: now, beside FS131-I5n (wave 5's `Terminal` half, on `fs131-w5c`) and FS131-RS1 (the boundary walk's SEP lane, on `fs131-w5p`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a hypothesis missing from a leaf, a defect that reaches `exists_merge_aux`'s statement, a lemma it needs that lives only in `Contact`, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-IMM4.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IMM-implementation.md` (on branch `fs131-w4mm`; you continue it from Stage 10, headed as yours)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4mm` (branch `fs131-w4mm`): `Proofs/HadwigerNelson/Plane/ValidMap/MergeMove.lean` (the two leaves, their children, and a leaf's restatement under item 354's terms); `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (the block headed "FS131-IMM1", which you extend), `plans/FS131-IMM-implementation.md`, `tools/fs131_imm_*.py`, `data/fs131/imm/`, `data/fs131/reports/FS131-IMM4.md`; **not** `Moves` (its `exists_merge_aux` body is assembled), `Contact`, `Surgery` (held byte for byte by `tools/fs131_im_split.py --check`), `exists_shave_aux` or `exists_rayMerge_aux`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are finishing MERGE, the third of wave 4's simplifying moves, in the Lean backlog. The milestone, FS-131, turns this project's hand-derived results
into kernel-checked ones; waves 1–4 and Woodall's chain are on `main`. MERGE is on wave 5's path: wave 5's last two `Terminal` leaves cite it, and wave 5's
landing waits for MERGE's. FS131-IMM3 built MERGE's map and proved six of its eight clauses, and assembled `exists_merge_aux` over two open leaves it stated
itself. Those two are yours — about 500–600 lines.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and wave 5's landing
waits for MERGE's (ruling 348 (b)). Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

The two leaves, `sorry` in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4mm/Proofs/HadwigerNelson/Plane/ValidMap/MergeMove.lean` at `8cae85bc` (read each whole there), their first lines:

> theorem merge_not_hasRepeatedColour_rim {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ') (h : X.Small ρ) (hab : a < b)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4mm/Proofs/HadwigerNelson/Plane/ValidMap/MergeMove.lean

> theorem merge_allowedCone (hF : F.Valid) (hv1 : F.Covers v 1) {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ') (h : X.Small ρ)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4mm/Proofs/HadwigerNelson/Plane/ValidMap/MergeMove.lean

over which `exists_merge_aux` (read it whole in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4mm/Proofs/HadwigerNelson/Plane/ValidMap/Moves.lean`) is assembled:

> theorem exists_merge_aux (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {c : Fin k} {n : ℕ} (hn1 : 1 ≤ n)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4mm/Proofs/HadwigerNelson/Plane/ValidMap/Moves.lean

IMM3's routes — read its Stages 7–9 and IMM2's § 5.2 in full:

> 1. **`¬ F'.HasRepeatedColour x` at rim points** — the sides lemma (§ 5.2): at a rim point on germ `j`, for small `r`, `sector (prev j) ∩ B(x, r)`
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4mm/plans/FS131-IMM-implementation.md 8.2 What is left: two clauses and the assembly

> 2. **`D_c(v′)` unchanged** for `v′ ∉ B̄(v, ρ)` (§ 5.2's route; note that a merged `c`-tile misses `ω(v′)` because the new map is valid
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4mm/plans/FS131-IMM-implementation.md 8.2 What is left: two clauses and the assembly

> Prove `merge_not_hasRepeatedColour_rim` (§ 8.2 item 1, about 200 lines: the sides lemma by convexity on one side and star-convexity on the other,
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4mm/plans/FS131-IMM-implementation.md 9.2 For whoever continues

What IMM3 handed back, the rulings on it and on MERGE's place in wave 5, and the colour clause:

> 353. **FS131-IMM3 handed back** (Stage 9 SAVED, harness ≈ 375k by the task notice; record `fs131-w4mm`'s `plans/FS131-IMM-implementation.md`, Stages 6–9;
> — source: plans/FS131-close-inventory.md

> 354. **Ruling on IMM3's slot: MERGE's continuation, FS131-IMM4, on `fs131-w4mm` from Stage 9** — the two leaves (`merge_not_hasRepeatedColour_rim`, then
> — source: plans/FS131-close-inventory.md

> 348. **Ruling on item 347: MERGE returns to wave 5's path; its continuation takes I5l's slot.** (a) **`exists_red` and `exists_terminal` may cite W-MERGE —
> — source: plans/FS131-close-inventory.md

> 269. **Ruling on item 268: `exists_merge` and `exists_merge_aux` take `F'.coloursAt v ⊆ F.coloursAt v` in place of the off-rim clause.** Choice: IM2 replaces the
> — source: plans/FS131-close-inventory.md

What wave 4's implementers may change:

> **It may**: add children anywhere in the wave's modules — the seven engines and every child § 13 names are expected additions (the engines in the
> — source: .claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md § 14.2 What the implementer may and may not change

## Done means

1. **Your readback first**: check every quotation above against its source; read IMM3's Stages 6–9 and IMM2's § 5.2; build the branch once as given
   (`8cae85bc`) before editing anything. Commit and push.
2. **The two leaves**: `merge_not_hasRepeatedColour_rim` (the sides lemma, then the three cases), then `merge_allowedCone`; children in `MergeMove`; save after
   each; re-price after the first; no backlog statement changed, no new `axiom`, no `native_decide`; a leaf restated only if a hypothesis is missing, with the
   counterexample in the record (and a message to me if the restatement would reach `exists_merge_aux`); `tools/fs131_im_statements.py --check`,
   `tools/fs131_im_split.py --check` and `tools/fs131_imm_decls.py --check` passing before each stage commit. Do not edit a file while a build of it runs.
3. **The handover**: your record's last stage says what is proved and what is left, with the build log and an axioms print against that build's oleans — if
   MERGE lands, `exists_merge_aux` and every `MergeMove` theorem on the standard three, with `exists_rayMerge_aux` (this branch's pre-RAY copy) as the control on
   `sorryAx`. You do not merge `main` or another branch into this one, apply `framePt → fromFrame`, or run the gate — MERGE's landing is a later job, on my word.
   Never push to `main`. Delete `data/fs131/imm/wip/C.lean` once its content is in `MergeMove`.
4. **Your record**, stages headed "Stage n — SAVED (FS131-IMM4)", "Theorems this phase proved"; the report in standing rule 11's form. Leave no background
   process running when you hand back. Stopping at a saved stage with a leaf left, named, is a good report.

## What is yours to decide

The proofs, their children and order, and a leaf's restatement under item 354's terms. IMM3's routes are notes, not rules. If MERGE needs a lemma that lives
only in `Contact`, message me; it then moves, never a copy. If a leaf is false as stated, stop it, message me with the smallest counterexample or the missing
hypothesis, and go on with the other. Three failed attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no
agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence; IMM3's
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4mm/data/fs131/imm/iter.sh` and its mirror are yours. The worktree's `.lake/build` is its own copy;
never replace it with a symlink. Nothing with a `sorry` reaches `main`.

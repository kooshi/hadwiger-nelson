# Brief FS131-IMM2 — MERGE, continued: `exists_merge_aux` proved from IMM1's plan on `fs131-w4mm`

*Written 2026-10-05 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IMM2
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: MERGE's second implementer — continue FS131-IMM1's work on `fs131-w4mm` from its stage 3, in its record § 4's order (the gap's choice, its clearness, the map `F'`, the clauses), saving after each part, and prove `exists_merge_aux` under its exact statement
  launch: now, beside FS131-RL1 (the boundary walk's planner, on `fs131-w5p`) and FS131-I5k (wave 5's `Terminal` half, on `fs131-w5c`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a clause that cannot be proved as written, a statement that looks false, a lemma it needs that lives only in `Contact`, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-IMM2.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IMM-implementation.md` (on branch `fs131-w4mm`; you continue it from Stage 4, headed as yours)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4mm` (branch `fs131-w4mm`): `Proofs/HadwigerNelson/Plane/ValidMap/MergeMove.lean`; in `Proofs/HadwigerNelson/Plane/ValidMap/Moves.lean` only `exists_merge_aux`'s proof body; `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (the block headed "FS131-IMM1", which you extend), `plans/FS131-IMM-implementation.md`, `tools/fs131_imm_*.py`, `data/fs131/imm/`, `data/fs131/reports/FS131-IMM2.md`; **not** `Contact`, `Surgery` (held byte for byte by `tools/fs131_im_split.py --check`), `exists_shave_aux` or `exists_rayMerge_aux`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are continuing MERGE, the third of wave 4's simplifying moves, in the Lean backlog. The milestone, FS-131, turns this project's hand-derived results
into kernel-checked ones; waves 1–4 and Woodall's chain are on `main`. Wave 4 landed without MERGE (nothing in Lean reads it yet), so MERGE lands later on its
own, from this branch. FS131-IMM1 built its module `Plane/ValidMap/MergeMove` — the push without a cusp horn, the gap's clearness at its ends, 15 theorems —
and wrote a plan for the rest in its record § 4. You prove the rest.

## Why this job

FS-131 closes only when every row of its backlog is formalized, and MERGE is one of them, with no other route to its landing. It runs independent of wave 5.
Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

`exists_merge_aux` in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4mm/Proofs/HadwigerNelson/Plane/ValidMap/Moves.lean`, its first line:

> theorem exists_merge_aux (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {c : Fin k} {n : ℕ} (hn1 : 1 ≤ n)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4mm/Proofs/HadwigerNelson/Plane/ValidMap/Moves.lean

(read the whole statement there; `tools/fs131_im_statements.py` checks it against `Contact`'s `exists_merge` with ruling 269's vertex clause). IMM1's verdict and
plan — read § 4 in full:

> **Verdict on the statement**: believed **TRUE** as written (ruling 269's form); no defect found. The rim clause
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4mm/plans/FS131-IMM-implementation.md 4. What is left, and the plan (for whoever continues; no statement changes)

> **4.1 The gap's choice and `K`'s geometry** (≈ 400 lines). If `K = univ`, any two consecutive `c`-sectors. Otherwise pick `e θ₀ ∈ int K`;
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4mm/plans/FS131-IMM-implementation.md 4. What is left, and the plan (for whoever continues; no statement changes)

> **4.3 The map `F'`** (≈ 500 lines; `Near.move` and `Near.exists_cut` add the whole circle `∂B(v, ρ)`, so they are not used). Radii: `ρ`
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4mm/plans/FS131-IMM-implementation.md 4. What is left, and the plan (for whoever continues; no statement changes)

What IMM1 handed back, the colour clause, the corrections it found, and the rulings on MERGE and on your slot:

> 294. **FS131-IMM1 done at its line, MERGE not yet proved** (harness ≈ 543k; record `fs131-w4mm`'s `plans/FS131-IMM-implementation.md`, stages 1–3 SAVED;
> — source: plans/FS131-close-inventory.md

> 269. **Ruling on item 268: `exists_merge` and `exists_merge_aux` take `F'.coloursAt v ⊆ F.coloursAt v` in place of the off-rim clause.** Choice: IM2 replaces the
> — source: plans/FS131-close-inventory.md

> 286. **FS131-IM3 handed back** (Stage 10 SAVED, harness 538k by the task notice; report `fs131-w4m`'s `data/fs131/reports/FS131-IM3.md`; commits `8ab4f838`,
> — source: plans/FS131-close-inventory.md

> 295. **Ruling: MERGE leaves wave 4; the freed slot goes to FS131-IX1 as ruled.** Choice: (a) wave 4 lands without `exists_merge` — at wave 4's merge-and-gate,
> — source: plans/FS131-close-inventory.md

> 337. **Ruling on I5j's slot: MERGE's continuation, FS131-IMM2, on `fs131-w4mm` from IMM1's stage 3.** In flight after it: 1 (RL1) + 1 (I5k) + 1 (IMM2) = 3.
> — source: plans/FS131-close-inventory.md

What wave 4's implementers may change:

> **It may**: add children anywhere in the wave's modules — the seven engines and every child § 13 names are expected additions (the engines in the
> — source: .claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md § 14.2 What the implementer may and may not change

## Done means

1. **Your readback first**: check every quotation above against its source; read IMM1's record in full and items 286 and 294; build the branch once as given
   (`7060fcc6`) before editing anything. Commit and push.
2. **MERGE proved**, in record § 4's order: 4.1 the gap's choice and `K`'s geometry; 4.2 its clearness; 4.3 the map `F'`; 4.4 the clauses; then
   `exists_merge_aux`'s body citing them. Children in `MergeMove`; save after each part; no statement changed, no new `axiom`, no `native_decide`; re-price
   from the first two parts; `tools/fs131_im_statements.py` re-run (empty diff) and `tools/fs131_im_split.py --check` passing before each stage commit. Do not
   edit a file while a build of it runs.
3. **The handover**: your record's last stage says what is proved and what is left, with the build log and an axioms print against that build's oleans,
   including a control on `sorryAx`. You do not merge `main` or another branch into this one, apply `framePt → fromFrame`, restore `Contact`'s declarations,
   or run the gate — MERGE's landing is a later job, on my word. Never push to `main`. Delete the scratch copies `data/fs131/imm/scratch/{Push,End,Gap}.lean`
   (they duplicate `MergeMove`) at your first commit.
4. **Your record**, stages headed "Stage n — SAVED (FS131-IMM2)", "Theorems this phase proved"; the report in standing rule 11's form. Stopping at a saved stage
   with parts left, named, is a good report.

## What is yours to decide

The proofs, their children and order within § 4's dependencies, and the construction's choices that are not hypotheses (radii, cuts). IMM1's plan is a route,
not a rule. If MERGE needs a lemma that lives only in `Contact`, message me; it then moves, never a copy. If a clause cannot be proved as written, stop it,
message me with the reason and the smallest counterexample or the missing hypothesis, and go on with the others. Three failed attempts on one route is a
dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level deep, because the
coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`.

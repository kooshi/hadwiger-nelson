# Brief FS131-IMM3 — MERGE, finished: the map `F'` and its clauses, so `exists_merge_aux` is proved, on `fs131-w4mm`

*Written 2026-10-05 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IMM3
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: MERGE's third implementer — continue FS131-IMM2's work on `fs131-w4mm` from its Stage 5, in its record § 5.2's order (the restated `exists_gap`, the definitions, 4.3 the map, 4.4 the clauses), saving after each part, and prove `exists_merge_aux` under its exact statement
  launch: now, beside FS131-I5m (wave 5's non-`Terminal` half, on `fs131-w5`) and FS131-RW2 (the boundary walk, on `fs131-w5p`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a clause that cannot be proved as written, a statement that looks false, a lemma it needs that lives only in `Contact`, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-IMM3.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IMM-implementation.md` (on branch `fs131-w4mm`; you continue it from Stage 6, headed as yours)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4mm` (branch `fs131-w4mm`): `Proofs/HadwigerNelson/Plane/ValidMap/MergeMove.lean` (including `exists_gap`'s restated clause, ruling 344 (a)); in `Proofs/HadwigerNelson/Plane/ValidMap/Moves.lean` only `exists_merge_aux`'s proof body; `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (the block headed "FS131-IMM1", which you extend), `plans/FS131-IMM-implementation.md`, `tools/fs131_imm_*.py`, `data/fs131/imm/`, `data/fs131/reports/FS131-IMM3.md`; **not** `Contact`, `Surgery` (held byte for byte by `tools/fs131_im_split.py --check`), `exists_shave_aux` or `exists_rayMerge_aux`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are finishing MERGE, the third of wave 4's simplifying moves, in the Lean backlog. The milestone, FS-131, turns this project's hand-derived results
into kernel-checked ones; waves 1–4 and Woodall's chain are on `main`. Wave 4 landed without MERGE, and until now nothing read it; FS131-I5l has just found that
wave 5's last two `Terminal` leaves (`exists_red`, `exists_terminal`) need it, so MERGE is back on wave 5's path, and its proof is now the longest chain to
wave 5's landing. FS131-IMM1 and FS131-IMM2 built `Plane/ValidMap/MergeMove` through the gap's choice and its clearness (`Near.exists_gap`), and IMM2 refined the
plan for the rest in its record § 5.2. You prove the rest.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and wave 5's landing
now waits for MERGE's (ruling 348 (b)). Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

`exists_merge_aux` in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4mm/Proofs/HadwigerNelson/Plane/ValidMap/Moves.lean`, its first line:

> theorem exists_merge_aux (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {c : Fin k} {n : ℕ} (hn1 : 1 ≤ n)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4mm/Proofs/HadwigerNelson/Plane/ValidMap/Moves.lean

(read the whole statement there; it carries ruling 269's vertex clause, and `tools/fs131_im_statements.py` checks it against `Contact`'s `exists_merge`). IMM2's
plan — read § 5.2 in full:

> **First, an easy strengthening of my own lemma**: `exists_gap` proves `b < X.n` in both cases; restate its clause `b < a + X.n` as `b < X.n`
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4mm/plans/FS131-IMM-implementation.md 5.2 What is left, and the plan (refined from

> **Definitions, on the chart's plain data** (so each can have a spec example; drafted, uncompiled against the new oleans, in
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4mm/plans/FS131-IMM-implementation.md 5.2 What is left, and the plan (refined from

> **4.3 the map** `F' = F.surgery v ρ (mergeArcs) (mergeCol) …`: (i) the arcs: non-degenerate, finite, inside `B̄(v, ρ)`, unit ones in `F.Γ`,
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4mm/plans/FS131-IMM-implementation.md 5.2 What is left, and the plan (refined from

What IMM2 handed back, the rulings on it, and why MERGE is back on wave 5's path:

> 343. **FS131-IMM2 handed back** (Stage 5 SAVED, harness ≈ 440k by the task notice; record `fs131-w4mm`'s `plans/FS131-IMM-implementation.md`, Stages 4–5;
> — source: plans/FS131-close-inventory.md

> 344. **Rulings on IMM2's held items, and its slot.** (a) **`exists_gap`'s clause restated: accepted** — a child of this lane's own, not a backlog statement;
> — source: plans/FS131-close-inventory.md

> 347. **FS131-I5l handed back** (Stage 38 SAVED, harness ≈ 381k by the task notice; record `fs131-w5c`'s `plans/FS131-I5-implementation.md`, Stages 35–38;
> — source: plans/FS131-close-inventory.md

> 348. **Ruling on item 347: MERGE returns to wave 5's path; its continuation takes I5l's slot.** (a) **`exists_red` and `exists_terminal` may cite W-MERGE —
> — source: plans/FS131-close-inventory.md

The colour clause, and IMM1's corrections to the hand proof:

> 269. **Ruling on item 268: `exists_merge` and `exists_merge_aux` take `F'.coloursAt v ⊆ F.coloursAt v` in place of the off-rim clause.** Choice: IM2 replaces the
> — source: plans/FS131-close-inventory.md

> 294. **FS131-IMM1 done at its line, MERGE not yet proved** (harness ≈ 543k; record `fs131-w4mm`'s `plans/FS131-IMM-implementation.md`, stages 1–3 SAVED;
> — source: plans/FS131-close-inventory.md

What wave 4's implementers may change:

> **It may**: add children anywhere in the wave's modules — the seven engines and every child § 13 names are expected additions (the engines in the
> — source: .claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md § 14.2 What the implementer may and may not change

## Done means

1. **Your readback first**: check every quotation above against its source; read IMM1's and IMM2's records in full (§§ 4 and 5 above all) and the draft
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4mm/data/fs131/imm/wip/B.lean`; build the branch once as given (`045c71c6`) before editing anything.
   Commit and push.
2. **MERGE proved**, in § 5.2's order: `exists_gap`'s clause restated (`b < X.n`, its diff in the record); the definitions with spec examples; 4.3 the map (arcs,
   membership, colouring, the rim's germ points, `hlc`); 4.4 the clauses (Valid, AgreesOff, RingArcsWithin, Condition 5, `v` gains no colour, HasSectors,
   the rim clause by the sides lemma, `D_c(v′)` unchanged); then `exists_merge_aux`'s body. Children in `MergeMove`; save after each part; re-price after the
   first two; no backlog statement changed, no new `axiom`, no `native_decide`; `tools/fs131_im_statements.py --check`, `tools/fs131_im_split.py --check` and
   `tools/fs131_imm_decls.py` passing before each stage commit. Do not edit a file while a build of it runs.
3. **The handover**: your record's last stage says what is proved and what is left, with the build log and an axioms print against that build's oleans,
   including a control on `sorryAx` while one remains. You do not merge `main` or another branch into this one, apply `framePt → fromFrame`, restore
   `Contact`'s declarations on `main`, or run the gate — MERGE's landing is a later job, on my word. Never push to `main`. Delete `data/fs131/imm/wip/B.lean`
   once its content is in `MergeMove`.
4. **Your record**, stages headed "Stage n — SAVED (FS131-IMM3)", "Theorems this phase proved"; the report in standing rule 11's form. Stopping at a saved stage
   with parts left, named, is a good report.

## What is yours to decide

The proofs, their children and order within § 5.2's dependencies, and the construction's choices that are not hypotheses. IMM2's plan is a route, not a rule.
If MERGE needs a lemma that lives only in `Contact`, message me; it then moves, never a copy. If a clause cannot be proved as written, stop it, message me
with the reason and the smallest counterexample or the missing hypothesis, and go on with the others. Three failed attempts on one route is a dispatch to the
companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can
only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`. Leave no background process running when you
hand back.

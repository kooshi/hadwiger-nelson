# Brief FS131-IMM1 — wave 4's MERGE move, in parallel: `exists_merge_aux` on its own branch `fs131-w4mm`

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IMM1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: prove wave 4's third simplifying move, MERGE, as `exists_merge_aux` under its exact statement, with its children in a new module `Plane/ValidMap/MergeMove`, on branch `fs131-w4mm`, beside FS131-IM3, which proves RAY on `fs131-w4m`
  launch: now, beside FS131-IM3 (wave 4's RAY, on `fs131-w4m`), FS131-I4m (wave 4, on `fs131-w4`) and FS131-IP1 (the planar implementer, on `fs131-w5p`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a move that cannot be proved as written, a lemma it needs that lives only in `Contact`, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-IMM1.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IMM-implementation.md` (new, on branch `fs131-w4mm`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4mm` (branch `fs131-w4mm`): the new module `Proofs/HadwigerNelson/Plane/ValidMap/MergeMove.lean` (importing `Plane/ValidMap/Surgery` and what it needs, never `Moves` or `Contact`); in `Proofs/HadwigerNelson/Plane/ValidMap/Moves.lean` only its import of `MergeMove` and `exists_merge_aux`'s proof body; supporting lemmas in `Proofs/HadwigerNelson/Plane/ValidMap/Surgery.lean` only by adding new declarations at its end (statements of existing ones unchanged); `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (your own block, headed "FS131-IMM1"), `plans/FS131-IMM-implementation.md`, `tools/fs131_imm_*.py`, `data/fs131/imm/`, `data/fs131/reports/FS131-IMM1.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are joining wave 4 of the Lean backlog, on Opus, at its longest path: the three simplifying moves, proved as `…_aux` lemmas in
`Plane/ValidMap/Moves` and cited by `Contact` at the merge. Three implementers built the ground: IM1 designed one surgery for all three moves, IM2 proved the
shared machinery (93 theorems and the cut, `Near.exists_cut`), and IM3 moved that machinery into `Plane/ValidMap/Surgery` and proved SHAVE. IM3 now takes
RAY on `fs131-w4m`; you take MERGE, on a branch of your own cut from IM3's at `73d31ad6`, so the two run side by side. Your branch merges back on my word.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`). Wave 4 gates Woodall's
landing and wave 5's, and MERGE, at about two sessions, is the longest of its last pieces.

## The statements

`exists_merge_aux` in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4mm/Proofs/HadwigerNelson/Plane/ValidMap/Moves.lean`, copied from `Contact`'s `exists_merge` with ruling 269's vertex clause and checked
by `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4mm/tools/fs131_im_statements.py` against the amendment table `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4mm/tools/fs131_im_amend.py`. Its first line:

> theorem exists_merge_aux (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {c : Fin k} {n : ℕ} (hn1 : 1 ≤ n)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4mm/Proofs/HadwigerNelson/Plane/ValidMap/Moves.lean

(read the whole statement there). The route, as IM1 planned it and IM2 priced it:

> Choose two `c`-sectors consecutive along `D_c(v)`'s arc of directions with the gap between them inside `D_c(v)` (the `c`-sectors' cones lie in `D_c(v)`,
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4mm/plans/FS131-IM-implementation.md 3.4 MERGE (`exists_merge_aux`)

> above it, item 262 (a)). About 1.5 sessions. **MERGE (`exists_merge_aux`)**: the run cut again, in a gap of `D_c(v)`, but **without** the full
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4mm/plans/FS131-IM-implementation.md 6.3 What is left, in order, and the price

The rulings: the colour clause, and your slot:

> 269. **Ruling on item 268: `exists_merge` and `exists_merge_aux` take `F'.coloursAt v ⊆ F.coloursAt v` in place of the off-rim clause.** Choice: IM2 replaces the
> — source: plans/FS131-close-inventory.md

> 285. **Ruling: I5c's slot → the parallel MERGE implementer FS131-IMM1 on a new branch `fs131-w4mm`; wave 5's next implementer takes the next slot.** Choice: as
> — source: plans/FS131-close-inventory.md

What wave 4's implementers may change:

> **It may**: add children anywhere in the wave's modules — the seven engines and every child § 13 names are expected additions (the engines in the
> — source: .claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md § 14.2 What the implementer may and may not change

## Done means

1. **Your readback first**: check every quotation above against its source; read the IM record's §§ 3, 6 and IM3's Stages 7–9 (on your branch); build the
   branch once as given (`73d31ad6`; its `.lake/build` comes from an older tree, so the first build rebuilds what differs). Commit and push.
2. **`MergeMove` created**, importing `Surgery`; `Moves` imports it; a green build with only `Moves`' remaining `sorry` warnings. Commit.
3. **MERGE proved**: its children in `MergeMove`, then `exists_merge_aux`'s body citing them, saving after each child; no statement changed, no new `axiom`, no
   `native_decide`; re-price from the first two children; `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4mm/tools/fs131_im_statements.py` re-run (empty diff). Do not edit a file while a build of it runs.
4. **The handover**: your record's last stage says what is proved and what is left, with the build log and an axioms print against that build's oleans. You do not
   edit `Contact`, `exists_shave_aux` or `exists_rayMerge_aux`, merge into another branch, or run wave 4's gate. Never push to `main`.
5. **Your record**, stages headed "Stage n — SAVED", "Theorems this phase proved"; the report in standing rule 11's form. Stopping at a saved stage with MERGE
   left, and naming what remains, is a good report.

## What is yours to decide

The proofs, their children and order, and whether a child belongs in `MergeMove` or (as a new declaration at its end) in `Surgery`. If MERGE needs a lemma
that lives only in `Contact` below `woodallCone_isHorn`, message me; it then moves, never a copy. If MERGE cannot be proved as written, stop, message me with
the reason and the smallest counterexample or the missing hypothesis. Three failed attempts on one route is a dispatch to the companion your identity names,
never a fourth. You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; four agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`.

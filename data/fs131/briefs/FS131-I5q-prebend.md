# Brief FS131-I5q — wave 5's non-`Terminal` lane, its last four leaves on `fs131-w5`: `exists_preBend`'s three children, and `bv_l3` with its move

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I5q
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: wave 5's non-`Terminal` implementer — prove the three children `exists_preBend` still rests on (`hfree_of_baseHyp`, `finite_maxRingArcs`, `maxRingArcs_subset_of_bend`), then move `bv_l3` to `BaseWalk` as ruled and prove it, saving after each leaf
  launch: now, beside FS131-IR1 (the procedure's last steps, on `fs131-w5c`) and FS131-LN1 (a linter measurement, on `fs131-wop`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I5q.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I5-implementation.md` (wave 5's record on branch `fs131-w5`; you continue it from Stage 56, headed as yours — Stages 52–55 are FS131-M6's, on `fs131-w5c`'s copy of this record, and the numbers stay apart so the later merge joins the two cleanly)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5` (branch `fs131-w5`, now at `3b120cd3`, the collar whole): `Proofs/HadwigerNelson/Plane/ValidMap/BaseDense.lean` (the three children and helpers beside them; not `cv_exists`, whose proof is on `fs131-w5c`); `Proofs/HadwigerNelson/Plane/ValidMap/HexRing.lean` (`bv_l3` removed by the move; its linkage children stay); `Proofs/HadwigerNelson/Plane/ValidMap/BaseWalk.lean` (`bv_l3` after `l3_base`, and `l3_base`'s argument extracted, `l3_base`'s statement unchanged); `Proofs/HadwigerNelson/Plane/ValidMap/BendCollar.lean` for `exists_collarFit`'s docstring only (ruling 417 (c)); `scripts/Axioms.lean` (a block of your own, headed "FS131-I5q", above the `=== PURCHASED ===` banner), `ARCHITECTURE.md` if a row's text names `bv_l3`'s home, `plans/FS131-I5-implementation.md`, `tools/fs131_i5_*.py`, `data/fs131/i5q/`, `data/fs131/reports/FS131-I5q.md`; **not** `Terminal.lean` (its lane is on `fs131-w5c`), `RadialPush`, `CollarMap`, `Pushforward`, `Proofs.lean`, nor any statement (a change goes to me)
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are closing the last four leaves of wave 5's half that does not touch `Terminal`, in the Lean backlog. The milestone, FS-131, turns this project's
hand-derived results into kernel-checked ones; waves 1–4, Woodall's chain, MERGE and OPEN are on `main`. On this branch the base case of row 134 with unit
arcs is wired: `row134BaseUA` is held, and `n3_base`, `localDense` and `dense3` rest on `exists_preBend`, the pre-bend step. `exists_preBend` is proved over
the collar bend — proved whole an hour ago, `bend_toward_collar` on the standard three — and six children, three of which are done. The other three are
yours. So is `bv_l3`, a theorem off the walk's path that nothing consumes yet, which sits in a module too far upstream for its own route.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`); with these four,
this branch's own modules hold no `sorry`. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

What the last jobs handed back, and the rulings that launch you:

> 416. **FS131-CC2 done: the collar bend is proved** (harness ≈ 514k by the task notice; record `fs131-w5k`'s `plans/FS131-collar-C-implementation.md`,
> — source: plans/FS131-close-inventory.md

> 417. **Rulings on CC2's held items, and its slot.** (a) **`fs131-w5` fast-forwarded to `fs131-w5k`** at `3b120cd3` (Keryx, in the `fs131-w5` tree, no build
> — source: plans/FS131-close-inventory.md

> 378. **FS131-KB2 handed back** (Stage 46 SAVED, harness ≈ 420k by the task notice; record `fs131-w5`'s `plans/FS131-I5-implementation.md`, Stages 43–46;
> — source: plans/FS131-close-inventory.md

> 386. **FS131-M5 done: `main` merged into `fs131-w5`** (harness ≈ 368k by the task notice; record `fs131-w5`'s `plans/FS131-I5-implementation.md`, Stages 47–51;
> — source: plans/FS131-close-inventory.md

> 369. **FS131-I5o handed back: `row134BaseUA` is held on `fs131-w5`** (Stage 42 SAVED, harness ≈ 384k by the task notice; record `fs131-w5`'s
> — source: plans/FS131-close-inventory.md

> 370. **Rulings on I5o's held items, and its slot.** (a) **`bv_l3` moves**, statement verbatim, to `BaseWalk` after `l3_base` (where its route's inputs live),
> — source: plans/FS131-close-inventory.md

## The statements

No statement changes in this job, and `bv_l3` moves verbatim. The four, as they stand on `fs131-w5` at `3b120cd3` (read each whole there), their first lines:

> theorem hfree_of_baseHyp (hF : F.Valid) {u P : ℂ} (hu : F.Covers u 2) (hH : F.BaseHyp u) (hP : P ∈ closedBall u 1)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/Proofs/HadwigerNelson/Plane/ValidMap/BaseDense.lean

> theorem finite_maxRingArcs (hF : F.Valid) {u : ℂ} (hu : F.Covers u 2) : (F.maxRingArcs u).Finite := by
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/Proofs/HadwigerNelson/Plane/ValidMap/BaseDense.lean

> theorem maxRingArcs_subset_of_bend (hF : F.Valid) {M : ArcMap k} (hM : M.Valid) {u P : ℂ} (hu : F.Covers u 2)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/Proofs/HadwigerNelson/Plane/ValidMap/BaseDense.lean

> theorem bv_l3 {F : ArcMap 6} (hF : F.Valid) {u₁ u₂ : ℂ} (hc₁ : F.Covers u₁ 1) (hc₂ : F.Covers u₂ 1)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/Proofs/HadwigerNelson/Plane/ValidMap/HexRing.lean

and the theorem the first three close:

> theorem exists_preBend {F : ArcMap 6} (hF : F.Valid) {u : ℂ} (hu2 : F.Covers u 2) (hu : F.IsCubicTrichromatic u) (hH : F.BaseHyp u)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/Proofs/HadwigerNelson/Plane/ValidMap/BaseDense.lean

The routes on record. For `hfree_of_baseHyp` (M5's, not attempted for budget), the paragraph that opens:

> **Left**: `hfree_of_baseHyp` — route, not attempted for budget: at `x = r(θ)`, `BaseHyp u` puts `x ∉ fourSet ∪ repSet` (`dist x u ≤ 2`), so
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-I5-implementation.md Theorems this phase proved (FS131-M5)

For `bv_l3`: why it must move, with three steps already compiled in a scratch file, and I5m's route with every input named — read both sections whole:

> `bv_l3` is in `Plane/ValidMap/HexRing`, which imports neither `Plane/RingBand` (`ringCircleColouring`, the band lemmas `hbig_of_noSwap`, `m0_const`, `D0_mod_ne`,
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-I5-implementation.md 41.4 `bv_l3`: its placement blocks the route as written

> - **`bv_l3`** (H; off the walk's path). The route, every input named:
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-I5-implementation.md What is left of this half (2), for the next implementer

`finite_maxRingArcs` and `maxRingArcs_subset_of_bend` have no route on record beyond KB2's Stage 45 (how `exists_preBend`'s induction uses them) and the
limit lane's sibling on `fs131-w5c`: `treatPts_inter_finite` and `badCount_lt_top` in `Procedure` prove a like finiteness (finitely many maximal arcs: side
changes happen at sites of a compact circle). That branch is not merged here; read its proof for the idea
(`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean`), and re-prove what you need — a shared
lemma is a tidy move for after the landing, not a copy to make now.

## Done means

1. **Your readback first**: check every quotation above against its source; read the record's Stages 37, 41, 45 and 49–51; build `fs131-w5` once as given
   (`3b120cd3`; the tree was fast-forwarded without a build, so expect the collar's modules and what imports them to compile) before editing anything; open
   Stage 56 with what you may and may not change. Commit and push.
2. **`exists_preBend`'s three children**, in the order you judge (M5's route makes `hfree_of_baseHyp` the readiest), saving after each; re-price in the
   record after the first two. Then an axioms print: `exists_preBend`, `n3_base`, `localDense`, `dense3`, `row134BaseUA` on the standard three, a control on
   `sorryAx`.
3. **`bv_l3`** (ruling 370 (a)): move it, statement verbatim, to `BaseWalk` after `l3_base`, with a cross-file statement check that has a plant (I5e's
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/tools/fs131_i5_cor3_move.py` is the model); extract `l3_base`'s band-and-linkage argument into one
   lemma over the two inputs that differ, `l3_base`'s statement unchanged; bring in the three compiled steps from
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/data/fs131/i5o/RingScratch.lean`; then prove it. This is the long leaf (about a session with the
   extraction); stopping before it, or inside it at a saved stage, is fine.
4. **In passing** (ruling 417 (c)): bring `exists_collarFit`'s docstring in `BendCollar` to the route CC2 proved (its record § 7.1 on this branch says what
   the proof uses); the statement is not touched.
5. No statement changed, no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. You do not merge `fs131-w5c` or `main` into this
   branch, run the gate, or touch `main`. Leave no background process running.
6. **Your record**, stages headed "Stage n — SAVED (FS131-I5q)", "Theorems this phase proved"; the report in standing rule 11's form, with the `sorry` count
   by file before and after. Stopping at a saved stage with leaves left, named, each with the route it is ready for, is a good report.

## What is yours to decide

The proofs, their children, the order, and the shape of the lemma extracted from `l3_base`. The routes above are plans, not rules; if you see a better one,
take it and say so in the record. If a leaf cannot be proved as written, stop it, message me with the smallest counterexample or the missing hypothesis, and
go on with the others. Three failed attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.

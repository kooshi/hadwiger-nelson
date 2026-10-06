# Brief FS131-CC2 — the collar bend's lane C, continued: lane G merged in, then the four open leaves and the model B0, on `fs131-w5k`

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-CC2
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: lane C's second implementer — merge lane G's finished proofs (`origin/fs131-w5`) into `fs131-w5k`, then prove lane C's four open leaves in `BendCollar` and state and prove the model `collarModel` (B0), continuing FS131-CC1's record from its Stage 3, saving after each
  launch: now, beside FS131-IR1 (the procedure's last steps, on `fs131-w5c`) and FS131-OL1 (OPEN's landing, on `fs131-wop`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, a merge conflict that is more than keeping both `scripts/Axioms.lean` blocks, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-CC2.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-collar-C-implementation.md` (on branch `fs131-w5k`; you append stages from Stage 4, headed as yours)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5k` (branch `fs131-w5k`): the merge's files; `Proofs/HadwigerNelson/Plane/ValidMap/BendCollar.lean` (lane C's declarations, children beside them, and `collarModel`); `Proofs/HadwigerNelson/Plane/ValidMap/Pushforward.lean` (supporting lemmas only); `scripts/Axioms.lean` (a block of your own, headed "FS131-CC2", above the `=== PURCHASED ===` banner; at the merge keep both sides' blocks), `plans/FS131-collar-C-implementation.md`, `tools/fs131_cc_*.py`, `data/fs131/cc/`, `data/fs131/reports/FS131-CC2.md`; **not** `RadialPush.lean` or `CollarMap.lean` beyond what the merge brings (lane G's, finished), `BaseDense`, `HexRing`, `BaseWalk`, `Proofs.lean` and `ARCHITECTURE.md` unless you add a module, nor any statement (a change goes to me, then to the planner)
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are finishing the collar bend, the strengthened bend that wave 5's pre-bend step rests on, in the Lean backlog. The milestone, FS-131, turns this
project's hand-derived results into kernel-checked ones; waves 1–4, Woodall's chain and MERGE are on `main`. FS131-KP2 reduced `bend_toward_collar` to 53 named
children in two lanes. Lane G (the geometry) is finished on `fs131-w5`: `RadialPush` and `CollarMap` hold no `sorry`. Lane C (the charts and sides) is yours,
on `fs131-w5k`: FS131-CC1 proved `Pushforward` whole, a reusable two-germ chart on a circle, and most of `BendCollar` over four open leaves. Those four, and
a model map, are what is left. The work stopped for a day at a halt; nothing was lost, and CC1's record is your starting point.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and `exists_preBend`
rests on this construction. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

No statement changes in this job. The four open leaves, as they stand on `fs131-w5k` at `bc168474` (read each whole there), their first lines:

> theorem CollarFit.map_degree_lensCurve (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {θ : ℝ} (hθ : θ ∈ Ioo θ₁ θ₂) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5k/Proofs/HadwigerNelson/Plane/ValidMap/BendCollar.lean

> theorem CollarFit.map_degree_end (hF : F.Valid) (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {v : ℂ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5k/Proofs/HadwigerNelson/Plane/ValidMap/BendCollar.lean

> theorem CollarFit.sides_end (hF : F.Valid) (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {Q x : ℂ} (hQ : Q ≠ P)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5k/Proofs/HadwigerNelson/Plane/ValidMap/BendCollar.lean

> theorem exists_collarFit (hF : F.Valid) (hA : F.IsRingArc P θ₁ θ₂ c c') (hout : c' ∉ F.coloursAt P)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5k/Proofs/HadwigerNelson/Plane/ValidMap/BendCollar.lean

and the theorem they close, which must come off `sorryAx` when they and B0 are done:

> theorem bend_toward_collar (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5k/Proofs/HadwigerNelson/Plane/ValidMap/BendCollar.lean

What CC1 left, with a route for each (read §§ 3.1–3.3 of its record in full; the table under this line is your work list):

> Four `sorry`s in `BendCollar` and the child B0, every other declaration of lane C proved over them and lane G's statements:
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5k/plans/FS131-collar-C-implementation.md 3.2 What is left in lane C, with the route each is ready for

Your lane in KP2's handoff (read the plan in full, §§ 2, 4 and 5 above all; after the merge it is in your tree):

> | **C, the charts and sides** | all of `Plane/ValidMap/Pushforward`; in `BendCollar`: `exists_collarFit`, `degree_openArc`, `map_degree_lensCurve`, `map_degree_end`, `map_hasDegree`, `map_hasRepeatedColour`, `map_ringArcsWithin`, `sides_end`, `map_R1`, `map_R2`, `map_R3`, `coloursAt_subset`, `side_ne_inner_of_mem_lens`, `map_inert`, and the new child B0 `collarModel` | 2,500 lines |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-collar-kernel-plan.md 5.2 The handoff (two implementers, split by file)

What the last jobs handed back, and the rulings that launch you:

> 405. **FS131-CC1 handed back** (Stage 3 SAVED, harness ≈ 464k by the task notice; record `fs131-w5k`'s `plans/FS131-collar-C-implementation.md`, Stages 1–3;
> — source: plans/FS131-close-inventory.md

> 406. **Rulings on CC1's items.** (a) The duplicate: **joins item 387 (a)'s tidy moves** (one copy to `Plane/LocalStructure` at wave 5's landing). (b)
> — source: plans/FS131-close-inventory.md

> 402. **FS131-CG1 done: the collar's lane G complete** (harness ≈ 478k by the task notice; record `fs131-w5`'s `plans/FS131-collar-kernel-plan.md`, Stages
> — source: plans/FS131-close-inventory.md

> 394. **FS131-KP2 done: the collar bend planned** (planner; harness ≈ 452k by the task notice; record `fs131-w5`'s `plans/FS131-collar-kernel-plan.md`; report
> — source: plans/FS131-close-inventory.md

> 390. **FS131-KP2, by message: a generalization (planner's reading, not yet kernel)** — `bend_toward_collar`'s construction never reads `hmax`: maximality is
> — source: plans/FS131-close-inventory.md

## Done means

1. **Your readback first**: check every quotation above against its source; read CC1's record (Stages 1–3) and KP2's plan; build `fs131-w5k` once as given
   (`bc168474`; expect it up to date) before editing anything; open Stage 4 with what you may and may not change. Commit and push.
2. **The merge** (item 406 (d)): `git merge origin/fs131-w5` (at `5059983d`) into `fs131-w5k`. Since the branch point `2736ab8c` the two sides changed
   disjoint files except `scripts/Axioms.lean`: keep both blocks. Build. Then an axioms print against the merged build: lane G's children on the standard
   three, and CC1's stage-3 lemmas on `sorryAx` only through lane C's four open leaves — say by name which still are, with a control. Check by script that no
   statement of either side changed in the merge. Commit the merge as its own stage and push.
3. **The leaves**, in CC1's § 3.2 order unless you find a cheaper one: `map_degree_lensCurve` (its route reuses `degree_of_circle`); the hard pair,
   `map_degree_end` with `exists_collarFit`'s C4, which share the end germ's identification; `sides_end`; the rest of `exists_collarFit` (C1–C3); then B0,
   `collarModel`, stated where KP2's plan § 4 puts it and proved, so that `CollarFit` has an inhabitant. Save after each; re-price in the record after the first
   two. No statement changed, no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs.
4. **The statement checker** (item 406 (c)): fix `tools/fs131_cc_stmt.py` so that it splits a declaration at the statement's top-level `:=` (a term-mode proof
   of an unchanged statement must read as unchanged), with a planted term-mode control that fires; CC1's two `:= by exact …` proofs may stay.
5. **The handover**: your record's last stage says what is proved and what is left, with the build log and an axioms print against that build's oleans —
   `bend_toward_collar` and `exists_collarFit` by name, and a control on `sorryAx`. Score KP2's reading that `hmax` is never used (item 390) against the
   leaves you proved. You do not merge into `fs131-w5` (that is on my word, after I have read your hand-back), take `main` into this branch, run the gate, or
   touch `main`. Leave no background process running.
6. **Your record**, stages headed "Stage n — SAVED (FS131-CC2)", "Theorems this phase proved"; the report in standing rule 11's form. Stopping at a saved stage
   with leaves left, named, is a good report.

## What is yours to decide

The proofs, their children and order within the lane's dependencies, and where a supporting lemma lives within your touches. KP2's and CC1's routes are
plans, not rules; if you see a better shape, take it and say so in the record. If a leaf cannot be proved as written, stop it, message me with the smallest
counterexample or the missing hypothesis, and go on with the others. Three failed attempts on one route is a dispatch to the companion your identity names,
never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.

# Brief FS131-I5c — wave 5 of the Lean backlog, continued: the 44 remaining `sorry` declarations on `fs131-w5`, less the planar core, after merging wave 4

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I5c
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: wave 5's third implementer — merge `fs131-w4` once it holds the `Contact` lane (inventory item 272), apply ruling 252 to `stuck_structure_ua`, and prove wave 5's remaining leaves except the planar job's seven (items 239, 247), saving after each
  launch: now, beside FS131-IM2 (wave 4's moves, on `fs131-w4m`), FS131-I4l (wave 4, on `fs131-w4`) and FS131-QA3 (a read-only definitions audit), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I5c.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I5-implementation.md` (on branch `fs131-w5`; you continue it — standing rule 2's "Resuming")
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5` (branch `fs131-w5`): the wave-5 modules (`Proofs/HadwigerNelson/Plane/ValidMap/Chain.lean`, `Terminal.lean`, `Dense.lean`, `HexRing.lean`, `MapGraph.lean`, and from the merge `BaseWalk.lean`, `BaseDense.lean`), supporting lemmas in wave 3–4's foundation modules as § 10.2 allows (statements unchanged), `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (your own block, headed "FS131-I5c"), `plans/FS131-I5-implementation.md`, `tools/fs131_i5_*.py`, `data/fs131/i5/`, `data/fs131/reports/FS131-I5c.md`; not wave 4's modules (`Contact`, `UnitArc`, `BaseSteps`, `SVMap`, `StuckChain`), which wave 4's implementers edit on their own branches
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k


Hello. You are wave 5's third implementer, on Opus. Wave 5 is **termination and density**: the terminal valid map the moves reach, the ends of stuck
chains, row 134's base step with unit arcs, and the density results built on it. FS131-I5 merged the base's branch, applied two ruled repairs and proved
nineteen leaves; FS131-I5b proved `Thomassen.lemma1` and the holed fragment and found `IsHoleOf` too weak. 44 leaves are left; seven belong to a separate
planar-infrastructure job, so 37 are yours. Since I5b, wave 4 proved the stuck structure your leaves read, and wave 2 landed on `main`.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`). Wave 5 lands after
wave 4 (its statements cite wave 4's); you can prove its leaves now. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

Every `sorry` on `fs131-w5` at `0db34854`, read back in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-w5-kernel-plan.md` §§ 3.2 and 8.2
and in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-w5base-kernel-plan.md`. Where I5b left it, read for pricing:

> **Re-pricing** (brief item 2). Both leaves proved were the plan's **M**: `lemma1` about 330 lines with children, six iterations; the holed fragment
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-I5-implementation.md Stage 8 — SAVED: `Thomassen.lemma1` and `exists_holed_valid_fragment` proved; a statement defect in `cvb_hole_disconnected`

(the paragraph continues there with the four infrastructures and `disc1_local`). The seven you skip:

> 239. **Ruling: the planar core goes to the planar-infrastructure job** — `cvb_thom_reduced`, `retArcs_nested`, `exists_endpoint`, `exists_eleventh`,
> — source: plans/FS131-close-inventory.md

> 247. **Rulings on I5b's held items and the slot.** (a) `IsHoleOf` / `cvb_hole_disconnected`: as item 242 (the planar job's first question). (b)
> — source: plans/FS131-close-inventory.md

(read items 239, 242 and 247 in full: `cvb_thom_reduced`, `retArcs_nested`, `exists_endpoint`, `exists_eleventh`, `exists_unenclosed_or_bad`,
`cvb_hole_disconnected`, `cvb_pinch_connected`, and `IsHoleOf`'s repair). Your slot and the merge:

> 272. **Wave 2's slot → wave 5's third implementer, FS131-I5c, on `fs131-w5`; it merges `fs131-w4` once that branch holds the `Contact` lane.** Choice: I5c works
> — source: plans/FS131-close-inventory.md

The sides clause, ruled for wave 4's `stuck_structure` and for your `stuck_structure_ua`:

> 252. **Ruling: the sides clause becomes form (b), in `stuck_structure` and in `stuck_structure_ua`.** Choice: (b), the point form outside the parabola. Alternative
> — source: plans/FS131-close-inventory.md

`pair_i`'s new hypothesis, which `l3_base` discharges from `ht'`:

> 258. **Ruling on item 257: `pair_i` gains `(h3 : dist u₁ u₂ < 3)`.** Choice: add the hypothesis `dist u₁ u₂ < 3`, which excludes exactly I4k's isolated configuration
> — source: plans/FS131-close-inventory.md

What you may change:

> **It may**: add children anywhere in the wave's modules — every child §§ 4, 9.1 name is an expected addition, and the shared ones may go to the
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-w5-kernel-plan.md ### 10.2 What the implementer may and may not change

`exists_merge`'s off-rim colour clause is being replaced by its vertex instance (items 268–269); if a wave 5 leaf reads `exists_merge`, use only
`F'.coloursAt v ⊆ F.coloursAt v`.

## Done means

1. **Your readback first**: check every quotation above against its source; read I5b's Stage 8 and the inventory items named; build `fs131-w5` once as given
   (`0db34854`) before editing anything. Commit and push.
2. **The merge**, when `git merge-base --is-ancestor f975677b origin/fs131-w4` succeeds (FS131-I4l pushes it early in its job; check after your readback and
   between leaves): `git merge origin/fs131-w4`; in shared bookkeeping files (`scripts/Axioms.lean`, `ARCHITECTURE.md`, `Proofs.lean`) keep both sides'
   additions; if a Lean file conflicts, stop and message me with the hunks. Then `tools/fs131_qa1_dupes.py`, a statement comparison against both parents
   (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4/tools/fs131_i4_stmts.py`, on `fs131-w4` and coming with the merge, works on any revision), and a green build with only `sorry` warnings. A merge commit is the one commit made without paths; say so
   in its message. Until the merge, work the brick map and sector-chart leaves, which do not read `Contact`.
3. **`stuck_structure_ua`** with ruling 252's form (b) once the merge is in (citing wave 4's proved `stuck_structure` and `stuck_structure_flanks` where they
   apply), then the leaves that read it; the other leaves in the order you judge; saving after each; no statement changed except item 252's, no new `axiom`, no
   `native_decide`; re-price from your first two hard leaves. Do not edit a file while a build of it runs.
4. **Your record** (continue it), stages headed "Stage n — SAVED", "Theorems this phase proved"; the report in standing rule 11's form. The gate and the landing
   are a later implementer's, after wave 4 lands. Stopping at a saved stage with leaves left, and naming them, is a good report.

## What is yours to decide

The proofs, their children and order, where a supporting lemma lives within § 10.2's allowance, and whether a shared infrastructure gets its own module (say
so in your report: a second wave-5 implementer could then work beside you). If a leaf cannot be proved as written, stop that leaf, message me at once with the
declaration, the reason, and the smallest counterexample or the missing hypothesis, and go on with the others: implementers on this milestone have found
several statements that needed a hypothesis the hand derivation hid, and each was a correction to the record. Three failed attempts on one route is a dispatch
to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator
can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; four agents are building, so on exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never
evidence; if you mirror oleans for iteration, use a scratch directory of your own (wave 4's `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4/data/fs131/i4/iter.sh` reads it from the variable `S`). The worktree's
`.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`.


## Amendment, 2026-10-04 — the planar job's fence, and one docstring (inventory item 274)

A planner for the planar-infrastructure job now works on branch `fs131-w5p`, cut from `fs131-w5` at `0db34854`. The ruling, whose first line is:

> 274. **Rulings on QA3's held items and the freed slot.** (a) **`InMK`**: restated when its first consumer is planned, not now (no theorem uses it; a definition
> — source: plans/FS131-close-inventory.md

So do not edit `IsHoleOf`, `fill`, `IsOuterTile`, `filledGraph` or the three `cvb_*` leaves in `MapGraph`, nor `retArcs_nested`, `exists_endpoint`,
`exists_eleventh` (`BaseWalk`) or `exists_unenclosed_or_bad` (`BaseDense`); add your children away from them. When you reach `l3_base`, rewrite
`linkage_dot_ne_zero`'s docstring as the definitions audit drafted it (`plans/FS131-QA3-audit.md` § 2.4 d; docstring only). You start no agents of your own
(standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).

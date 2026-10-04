# Brief FS131-I5b — wave 5 of the Lean backlog, continued: the 46 remaining `sorry` declarations on `fs131-w5`, less the planar core

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I5b
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: wave 5's second implementer — prove its remaining leaves in FS131-I5's Stage 6 order, except the five planar-core leaves (item 239), saving after each
  launch: now, beside FS131-I2n (wave 2), FS131-I4j and FS131-IC4 (wave 4), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I5b.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I5-implementation.md` (on branch `fs131-w5`; you continue it — standing rule 2's "Resuming")
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5` (branch `fs131-w5`): the wave-5 modules (`Proofs/HadwigerNelson/Plane/ValidMap/Chain.lean`, `Terminal.lean`, `Dense.lean`, `HexRing.lean`, `MapGraph.lean`, and from the merge `BaseWalk.lean`, `BaseDense.lean`), supporting lemmas in wave 3–4's foundation modules as § 10.2 allows (statements unchanged), `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (your own block, headed "FS131-I5b"), `plans/FS131-I5-implementation.md`, `tools/fs131_i5_*.py`, `data/fs131/i5/`, `data/fs131/reports/FS131-I5b.md`; not wave 4's modules (`Contact`, `UnitArc`, `BaseSteps`, `SVMap`, `StuckChain`), which wave 4's implementers edit on their own branches
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are wave 5's second implementer, on Opus. Wave 5 is **termination and density**: the terminal valid map the moves reach, the ends of stuck
chains, row 134's base step with unit arcs, and the density results built on it. The first implementer, FS131-I5, merged the base's branch, applied the two
ruled repairs (E4's `UnenclosedC`; `IsRetArc` with CD's β), ran the base's obligation pass (every statement derives), and proved ten leaves outright and nine
over open children; it also wrote out `Thomassen.lemma1`'s proof ready to transcribe. 46 leaves are left; five of them, the planar core, go to a separate job
(below), so 41 are yours.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`). Wave 5 lands after
wave 4 (its statements cite wave 4's); you can prove its leaves now. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

Every `sorry` on `fs131-w5` at `7b049700` (46: `Terminal` 12, `Dense` 3, `HexRing` 7, `MapGraph` 5, `BaseWalk` 15, `BaseDense` 4), read back in
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-w5-kernel-plan.md` §§ 3.2 and 8.2 and in FS131-KB's plan (merged, `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-w5base-kernel-plan.md`). Where I5 left it:

> **Left: 46 `sorry` declarations in wave 5** (`Terminal` 12, `Dense` 3, `HexRing` 7, `MapGraph` 5, `BaseWalk` 15, `BaseDense` 4), in § 10.1's order with the
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-I5-implementation.md ## Stage 6 — SAVED: what is left, for wave 5's next implementer

and `Thomassen.lemma1`'s proof, planned in full:

> **`Thomassen.lemma1`, the proof to transcribe** (`[Thomassen1999]` p. 850–851, read 2026-10-04 in the OCR copy
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-I5-implementation.md ## Stage 6 — SAVED: what is left, for wave 5's next implementer

The five you skip:

> 239. **Ruling: the planar core goes to the planar-infrastructure job** — `cvb_thom_reduced`, `retArcs_nested`, `exists_endpoint`, `exists_eleventh`,
> — source: plans/FS131-close-inventory.md

What you may change:

> **It may**: add children anywhere in the wave's modules — every child §§ 4, 9.1 name is an expected addition, and the shared ones may go to the
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5/plans/FS131-w5-kernel-plan.md ### 10.2 What the implementer may and may not change

(the section continues there with what you may not change). Two definitions were already repaired by ruling (E4's `UnenclosedC`, item 227; `IsRetArc`):

> 232. **Ruling: `IsRetArc` gains CD's β** — some connected `K` with `r(s), r(t) ∈ K ⊆ closure T₁ ∩ closure T₂ ∩ closedBall u 1`. Choice: I5 makes the definition
> — source: plans/FS131-close-inventory.md

`cor3_local`'s exact covering hypothesis needs NB3-COR3's argument read (`plans/FS112-NB3-verification.md` and the record it cites) before you state it.

## Done means

1. **Your readback first**: check the quotations above against their sources; build `fs131-w5` once as given (`7b049700`) before editing anything; restate in
   your record what you may and may not change. Commit and push.
2. **Leaves proved** in I5's Stage 6 order (yours to change), less the five planar-core leaves, saving after each; no statement changed, no new `axiom`, no
   `native_decide`; re-price from your first two hard leaves (no H leaf has been priced yet). Do not edit a file while a build of it runs.
3. **Your record** (continue it), stages headed "Stage n — SAVED", "Theorems this phase proved"; the report in standing rule 11's form. The gate and the landing
   are a later implementer's, after wave 4 lands. Stopping at a saved stage with leaves left, and naming them, is a good report.

## What is yours to decide

The proofs, their children and order, where a supporting lemma lives within § 10.2's allowance, and how you split the repair's children. If a leaf cannot be
proved as written, stop that leaf, message me at once with the declaration, the reason, and the smallest counterexample or the missing hypothesis, and go on
with the others. Three failed attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own
(standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; four agents are building
today, so on exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never
evidence; if you mirror oleans for iteration, use a scratch directory of your own (wave 4's `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4/data/fs131/i4/iter.sh` reads it from the variable `S`). The worktree's
`.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`.

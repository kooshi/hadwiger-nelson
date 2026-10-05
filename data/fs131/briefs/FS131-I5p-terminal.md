# Brief FS131-I5p — wave 5 of the Lean backlog, the `Terminal` half's last three leaves: `y3_end_needs_of_not_mem`, `exists_red`, `exists_terminal` on `fs131-w5c`

*Written 2026-10-05 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I5p
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: wave 5's sixth `Terminal` implementer — continue FS131-I5n's work on `fs131-w5c` from its Stage 42, in item 356's order, saving after each leaf
  launch: now, beside FS131-RS1 (the boundary walk's SEP lane, on `fs131-w5p`) and FS131-IMM4 (MERGE's last two clauses, on `fs131-w4mm`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, a step of a hand derivation that fails in Lean, a MERGE clause that ruling 269's form does not give, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I5p.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I5-implementation.md` (on branch `fs131-w5c`; you continue it from Stage 43, headed as yours)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c` (branch `fs131-w5c`): `Proofs/HadwigerNelson/Plane/ValidMap/Terminal.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/HornShadow.lean`; supporting lemmas in `FlankUA` or a new module upstream of `Terminal` (statements of other files unchanged); `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (the block headed "FS131-I5h", which you extend, above the `=== PURCHASED ===` banner), `plans/FS131-I5-implementation.md`, `tools/fs131_i5h_*.py`, `tools/fs131_i5p_*.py`, `data/fs131/i5n/`, `data/fs131/i5p/`, `data/fs131/reports/FS131-I5p.md`; **not** `Contact` (its `exists_merge` is item 348's, done), `HexRing`, `Cor3`, `BaseWalk`, `Dense`, `MapGraph`, `BaseDense`, nor any other declaration of wave 4's modules
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are taking the last three leaves of the `Terminal` half of wave 5 of the Lean backlog. Wave 5 is **termination and density**: the terminal valid map
the moves reach, the ends of stuck chains, row 134's base step with unit arcs, and the density results built on it. The milestone, FS-131, turns this
project's hand-derived results into kernel-checked ones; waves 1–4 and Woodall's chain are on `main`. FS131-I5n swapped MERGE's statement on this branch to its
corrected form, proved CV-HD's branch `G_N` (seven colours at `N`), and reduced `y3_end_needs` to its case `g ∉ P_cl(N)`. Left: that case, and the two limit
constructions, which cite MERGE.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and this half is the
longest lane to wave 5's landing. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

Your three leaves, `sorry` in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Terminal.lean` at `da09c260` (read each whole there; the last two are read back in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-w5-kernel-plan.md` §§ 3.2 and 8.2), their first lines:

> theorem y3_end_needs_of_not_mem {F : ArcMap 6} (hF : F.Valid) (hP : F.IsPlaneMap) (hT : F.Terminal) {E : ℂ} (hst : F.IsStuck E)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Terminal.lean

> theorem exists_red (hF : F.Valid) (hP : F.IsPlaneMap) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Terminal.lean

> theorem exists_terminal {F : ArcMap 6} (hF : F.Valid) (hP : F.IsPlaneMap) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Terminal.lean

Where they stand, in I5n's words — read its Stages 39–42 in full:

> 1. **`y3_end_needs_of_not_mem`** (H; YB3 § 3.1 Steps 3–4, `g ∉ P_cl(N)`). Step 3 with the Stage 41 toolkit: the chart at `N` with `Q±`
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-I5-implementation.md Stage 42 — SAVED (FS131-I5n): `y3_end_needs` reduced to its case `g ∉ P_cl(N)`; the handover

> 2. **`exists_red`, `exists_terminal`** (H, the limit constructions): may now cite `exists_merge` in ruling 269's form (ruling 348 (a)); not started.
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-I5-implementation.md Stage 42 — SAVED (FS131-I5n): `y3_end_needs` reduced to its case `g ∉ P_cl(N)`; the handover

What I5n handed back, the finding that MERGE is needed, and the rulings that launch you:

> 355. **FS131-I5n handed back** (Stage 42 SAVED, harness ≈ 429k by the task notice; record `fs131-w5c`'s `plans/FS131-I5-implementation.md`, Stages 39–42;
> — source: plans/FS131-close-inventory.md

> 347. **FS131-I5l handed back** (Stage 38 SAVED, harness ≈ 381k by the task notice; record `fs131-w5c`'s `plans/FS131-I5-implementation.md`, Stages 35–38;
> — source: plans/FS131-close-inventory.md

> 348. **Ruling on item 347: MERGE returns to wave 5's path; its continuation takes I5l's slot.** (a) **`exists_red` and `exists_terminal` may cite W-MERGE —
> — source: plans/FS131-close-inventory.md

> 356. **Ruling on I5n's slot: the `Terminal` continuation, FS131-I5p, on `fs131-w5c` from Stage 42** — `y3_end_needs_of_not_mem` (YB3 § 3.1 Steps 3–4, the
> — source: plans/FS131-close-inventory.md

The planar job's fence, which stands:

> 274. **Rulings on QA3's held items and the freed slot.** (a) **`InMK`**: restated when its first consumer is planned, not now (no theorem uses it; a definition
> — source: plans/FS131-close-inventory.md

What you may change:

> **It may**: add children anywhere in the wave's modules — every child §§ 4, 9.1 name is an expected addition, and the shared ones may go to the
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-w5-kernel-plan.md ### 10.2 What the implementer may and may not change

## Done means

1. **Your readback first**: check every quotation above against its source; read I5n's Stages 39–42, I5l's Stage 38, and the hand derivations the routes name
   (YB3 § 3.1, N2-RED, N2-TERM); build `fs131-w5c` once as given (`da09c260`) before editing anything. Commit and push.
2. **The order of item 356**: `y3_end_needs_of_not_mem`; then `exists_red`, `exists_terminal`, citing `exists_merge` in ruling 269's form only. Save after each
   leaf; no backlog statement changed, no new `axiom`, no `native_decide`; re-price from your first hard leaf. Run `tools/fs131_i5h_stmt_check.py 72149b07` and
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/tools/fs131_i5n_merge_swap.py` before each stage commit. Do not edit a file while a build of it runs.
3. **The handover**: your record's last stage says what is proved and what is left, with the build log and an axioms print against that build's oleans,
   including a control on `sorryAx` (`exists_merge` itself serves until MERGE lands). You do not merge into `fs131-w5`, take `main` into this branch, run the
   gate, or touch `main`. Stopping at a saved stage with leaves left, named, is a good report.
4. **Your record**, stages headed "Stage n — SAVED (FS131-I5p)", "Theorems this phase proved"; the report in standing rule 11's form. Leave no background process
   running when you hand back.

## What is yours to decide

The proofs, their children and order within the order's dependencies, and where a supporting lemma lives within your touches. I5n's notes are a route, not a
rule. If `exists_red` or `exists_terminal` needs a MERGE clause that ruling 269's form does not give, stop that leaf and message me with the clause — never use
the old form. If a step of a hand derivation fails in Lean, stop that leaf and message me with the step and the smallest counterexample or the missing
hypothesis, and go on with the others. Three failed attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no
agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`.

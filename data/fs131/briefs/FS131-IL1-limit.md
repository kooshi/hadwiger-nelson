# Brief FS131-IL1 — the limit of a sequence of `ArcMap`s, implemented (lane A): `Limit`, then `Procedure`'s finiteness lemmas, on `fs131-w5c`

*Written 2026-10-05 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IL1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: lane A of the limit constructions — prove FS131-KL1's `Limit` module in its plan's order (`LocalStep.mono`, `exists_stab`, `frozen`, its consumers, the locality lemmas, `limit_isTerminalMap`, the clean lemmas, `exists_clean`), then `Procedure`'s finiteness lemmas and `mergeAvailable_of_bothKind`, saving after each
  launch: now, beside FS131-ML1 (MERGE's landing, on `fs131-w4mm`) and FS131-KB2 (the strengthened bend, on `fs131-w5`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a child that cannot be proved as written, a statement that looks false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-IL1.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-limit-kernel-plan.md` (on branch `fs131-w5c`; you append stages from Stage 5, headed as yours)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c` (branch `fs131-w5c`): `Proofs/HadwigerNelson/Plane/ValidMap/Limit.lean`; in `Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean` only `badCount_eq_zero_iff`, `badCount_lt_top`, `treatPts_inter_finite`, `mergeAvailable_of_bothKind` and children beside them (with the spec examples owed for `badCount`, `IsMaxRingArc`, `treatPts`); `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (the block headed "FS131-I5h", which you extend, above the `=== PURCHASED ===` banner), `plans/FS131-limit-kernel-plan.md`, `tools/fs131_il_*.py`, `data/fs131/il/`, `data/fs131/reports/FS131-IL1.md`; **not** `Terminal.lean` (lane B's), `exists_vertexStep`, `exists_arcStep`, `exists_terminalSeq`, `Contact`, nor wave 4's modules on this branch
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are building the limit of a sequence of colour maps, the infrastructure wave 5's two last `Terminal` leaves stand on, in the Lean backlog. The
milestone, FS-131, turns this project's hand-derived results into kernel-checked ones; waves 1–4 and Woodall's chain are on `main`, and wave 5 (termination and
density) is nearly proved. FS131-KL1 has just planned the last two leaves, `exists_red` and `exists_terminal`, over one construction (`exists_terminalMap`: every
valid plane map has a modification that is a terminal valid map), which is infinitely many local moves whose limit is again a valid map. The `Limit` module is
yours — lane A of two.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and the limit is now
the longest chain to wave 5's landing. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

Your leaves are the `sorry` children of `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Limit.lean` at `8a42a2e0` and the four `Procedure` lemmas your touches name (read each whole there; KL1's plan § 3.1 reads
each back). Three of the shapes, their first lines:

> structure LocalSeq (k : ℕ) where
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Limit.lean

> theorem frozen {K : Set ℂ} (hK : IsCompact K) (hKd : K ⊆ (S.F 0).dom) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Limit.lean

> theorem limit_isModification (h : ∀ n, (S.F 0).IsModification (S.F n)) : (S.F 0).IsModification S.limit := by
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Limit.lean

KL1's handoff — read its plan in full, §§ 2.1, 3.1 and 4 above all:

> **What to prove** (the open children, § 3.1's routes; order cheapest re-pricing first): `LocalStep.mono`, `exists_stab` →
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-limit-kernel-plan.md Stage 4 — SAVED: the handoff to the implementer

> **What it may change**: add children anywhere in `Limit`, `Procedure`, `Terminal` (and § 3.3's lemmas in `Procedure` or a module between it
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-limit-kernel-plan.md Stage 4 — SAVED: the handoff to the implementer

> `Limit`: `frozen` and its five consumers — one session; the locality lemmas with `tile_subset_ball_or_disjoint` — half a session; `exists_clean` —
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-limit-kernel-plan.md 3.2 Price (re-price from the first two leaves; the brief's counter-priors stand)

What KL1 found and handed back, and the rulings that launch you:

> 371. **FS131-KL1 (the limit planner), by message: N4-TERM's count does not descend over `main`'s SHAVE as built; a clean step is owed; `exists_red` has a shorter
> — source: plans/FS131-close-inventory.md

> 372. **Rulings on item 371.** (a) **`ArcMap.clean` accepted** as the plan's repair, with the moves' new exported lemmas as **new declarations only** (no landed
> — source: plans/FS131-close-inventory.md

> 373. **FS131-KL1 done: the limit constructions planned** (planner; stage 4 SAVED, harness ≈ 418k by the task notice; record `fs131-w5c`'s
> — source: plans/FS131-close-inventory.md

> 374. **Rulings on KL1's held items, and its slot.** (a) **The moves' new lemmas** are proved on wave 5's branch after it merges `main` (ruling 372 (a)): in a
> — source: plans/FS131-close-inventory.md

## Done means

1. **Your readback first**: check every quotation above against its source; read KL1's plan in full; build `fs131-w5c` once as given (`8a42a2e0`) before
   editing anything. Commit and push.
2. **The order of KL1's handoff, lane A's part**: `LocalStep.mono`, `exists_stab`, then `frozen` (with `arc_origin`) — re-price the rest in the record after
   these — then `limitArcs_locallyFinite`, `limitCol_locallyConstant`, `eventually_agreesOn`, `limit_valid`, `limit_isModification`, the locality lemmas (with
   `tile_subset_ball_or_disjoint`), `limit_isTerminalMap`, `not_available_of_not_isSite`, `IsClean.eventually_not_isSite`, `exists_clean`; then
   `badCount_eq_zero_iff`, `badCount_lt_top`, `treatPts_inter_finite` (with the three spec examples), `mergeAvailable_of_bothKind`. Save after each; no statement
   of `exists_red`, `exists_terminal`, `exists_terminalMap`, `IsModification`, `IsTerminalMap` or any wave-4 definition changed; no new `axiom`, no
   `native_decide`. Do not edit a file while a build of it runs.
3. **The handover**: your record's last stage says what is proved and what is left, with the build log and an axioms print against that build's oleans,
   including a control on `sorryAx`. You do not merge into `fs131-w5`, take `main` into this branch, run the gate, or touch `main`. Stopping at a saved stage
   with children left, named, is a good report.
4. **Your record**, stages headed "Stage n — SAVED (FS131-IL1)", "Theorems this phase proved"; the report in standing rule 11's form. Leave no background
   process running when you hand back.

## What is yours to decide

The proofs, their children and order within the dependencies, and where a supporting lemma lives within your touches. KL1's routes are a plan, not a rule. If
`mergeAvailable_of_bothKind` (one mind's hand proof) fails, stop it and message me with the configuration — it goes to the deriver — and go on with the others.
If a child cannot be proved as written, stop it, message me with the smallest counterexample or the missing hypothesis, and go on. Three failed attempts on
one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level deep,
because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`.

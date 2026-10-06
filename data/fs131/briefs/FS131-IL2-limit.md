# Brief FS131-IL2 — the limit's lane A, finished: `exists_clean`, the three finiteness lemmas, and `mergeAvailable_of_bothKind`, on `fs131-w5c`

*Written 2026-10-05 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IL2
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: lane A of the limit constructions, continued from FS131-IL1's Stage 8 — `exists_clean`, then `treatPts_inter_finite`, `badCount_eq_zero_iff`, `badCount_lt_top` (each with `hP`, item 380), then `mergeAvailable_of_bothKind`, saving after each
  launch: now, beside FS131-E6 (an Ephodos derivation, in the main tree) and FS131-M5 (`main` into `fs131-w5`, on `fs131-w5`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a child that cannot be proved as written, a statement that looks false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-IL2.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-limit-kernel-plan.md` (on branch `fs131-w5c`; you append stages from Stage 9, headed as yours)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c` (branch `fs131-w5c`): `Proofs/HadwigerNelson/Plane/ValidMap/Limit.lean`; in `Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean` only `badCount_eq_zero_iff`, `badCount_lt_top`, `treatPts_inter_finite`, `mergeAvailable_of_bothKind` and children beside them (with the spec examples owed for `badCount`, `IsMaxRingArc`, `treatPts`); `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (the block headed "FS131-I5h", which you extend), `plans/FS131-limit-kernel-plan.md`, `tools/fs131_il_*.py`, `data/fs131/il/`, `data/fs131/reports/FS131-IL2.md`; **not** `exists_vertexStep` (its degree clause is held, item 383 (b)), `exists_arcStep`, `exists_terminalSeq`, `Terminal.lean`, `Contact`, nor wave 4's modules on this branch
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are finishing lane A of the limit constructions, in the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones; waves 1–4, Woodall's chain and MERGE are on `main`, and wave 5 is nearly proved. Wave 5's last two leaves rest on one construction,
`exists_terminalMap`, a limit of local moves. FS131-IL1 has just proved the limit itself — validity, the modification conditions and terminality pass to it —
and the locality lemmas; five children of lane A are left. They are yours. (An Ephodos job meanwhile found that the procedure needs a fifth move, OPEN, at a
lone horn; that touches `exists_vertexStep`, not your leaves.)

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and the limit is the
longest chain to wave 5's landing. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

Your leaves, `sorry` on `fs131-w5c` at `6a792494` (read each whole in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Limit.lean` and
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean`; the three finiteness lemmas carry `hP` since item 380).
Where each stands, in IL1's words — read its Stages 5–8 in full:

> - **`exists_clean`** (`Limit`, H). Design worked out, not built: `E := {x ∈ Γ | 2 ≤ ncard (coloursAt x)}`, closed in `dom` (a point of the
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-limit-kernel-plan.md 8.2 What is left (my brief's part), with routes

> - **`treatPts_inter_finite`** (now with `hP`, M): sites — `IsClean.eventually_not_isSite` at each point and `IsCompact.induction_on` (as in
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-limit-kernel-plan.md 8.2 What is left (my brief's part), with routes

> - **`badCount_eq_zero_iff`** (now with `hP`, M): `←` is immediate (no maximal arc is bad); `→` needs a maximal extension of each ring arc —
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-limit-kernel-plan.md 8.2 What is left (my brief's part), with routes

> - **`badCount_lt_top`** (now with `hP`, M): maximal arcs have disjoint interiors (same sides unite; different sides cannot overlap); their ends are
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-limit-kernel-plan.md 8.2 What is left (my brief's part), with routes

> - **`mergeAvailable_of_bothKind`** (M–H, one mind's hand proof): not started; read N2-RED/NB2-RED first (KL1 § 3.1).
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-limit-kernel-plan.md 8.2 What is left (my brief's part), with routes

What IL1 handed back, the finding on the three lemmas, the fifth move's finding, and the rulings that launch you:

> 381. **FS131-IL1 handed back** (Stage 8 SAVED, harness ≈ 437k by the task notice; record `fs131-w5c`'s `plans/FS131-limit-kernel-plan.md`, Stages 5–8; report
> — source: plans/FS131-close-inventory.md

> 380. **FS131-IL1, by message: three of `Procedure`'s finiteness children are false without a domain hypothesis** (KL1's own children, not backlog
> — source: plans/FS131-close-inventory.md

> 382. **FS131-E6, by message (mid-job): F6 is real; `exists_vertexStep`'s degree clause is false at an exact model; the repair is a fifth move.** (1) **Realized**
> — source: plans/FS131-close-inventory.md

> 383. **Rulings on items 381–382.** (a) **E6's finding accepted** (realized, controls firing): no backlog statement changes; N4-TERM as filed has a gap at a
> — source: plans/FS131-close-inventory.md

The plan and its rulings:

> 373. **FS131-KL1 done: the limit constructions planned** (planner; stage 4 SAVED, harness ≈ 418k by the task notice; record `fs131-w5c`'s
> — source: plans/FS131-close-inventory.md

> 374. **Rulings on KL1's held items, and its slot.** (a) **The moves' new lemmas** are proved on wave 5's branch after it merges `main` (ruling 372 (a)): in a
> — source: plans/FS131-close-inventory.md

## Done means

1. **Your readback first**: check every quotation above against its source; read KL1's plan §§ 2.1, 3.1 and 4 and IL1's Stages 5–8; build `fs131-w5c` once as
   given (start from `6a792494`, not an older commit) before editing anything. Commit and push.
2. **The order**: `exists_clean` (re-price the rest after it), then `treatPts_inter_finite`, `badCount_eq_zero_iff`, `badCount_lt_top` (with the three spec
   examples), then `mergeAvailable_of_bothKind` (N2-RED's parenthesis, one mind's hand proof — if it fails, stop it and message me with the configuration).
   Save after each; no statement of `exists_red`, `exists_terminal`, `exists_terminalMap`, `IsModification`, `IsTerminalMap` or any wave-4 definition changed;
   no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs.
3. **The handover**: your record's last stage says what is proved and what is left, with the build log and an axioms print against that build's oleans,
   including a control on `sorryAx`. You do not merge into `fs131-w5`, take `main` into this branch, run the gate, or touch `main`. Stopping at a saved stage
   with children left, named, is a good report.
4. **Your record**, stages headed "Stage n — SAVED (FS131-IL2)", "Theorems this phase proved"; the report in standing rule 11's form. Leave no background
   process running when you hand back.

## What is yours to decide

The proofs, their children and order within the dependencies, and where a supporting lemma lives within your touches. IL1's and KL1's routes are a plan, not
a rule. If a child cannot be proved as written, stop it, message me with the smallest counterexample or the missing hypothesis, and go on. Three failed
attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one
level deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`.

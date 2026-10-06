# Brief FS131-IR2 — the vertex step, `exists_vertexStep`, on `fs131-w5c`

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IR2
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the vertex step's implementer — prove `exists_vertexStep` in `Procedure` by E6's route (MERGE, else MERGE-RAY, else SHAVE, else OPEN, each followed by the kept-colour cleaning), continuing FS131-IR1's record from its Stage 17, saving after each move's case
  launch: now, beside FS131-I5q (wave 5's last non-`Terminal` leaves, on `fs131-w5`) and FS131-QA4 (an audit, read-only); FS131-IS1 (`stuckRun_ne_univ`) will start on `fs131-w5s`, a branch cut from this one, and edits `Terminal` only
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a case that cannot be proved as written, a clause of the statement that looks false at some move, a form you need that would change a landed definition or statement, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-IR2.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-limit-kernel-plan.md` (on branch `fs131-w5c`; you continue it from Stage 18, headed as yours)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c` (branch `fs131-w5c`, at `ebb0b292`): `Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean` (`exists_vertexStep` and children beside it; not `exists_arcStep`'s statement, nor `exists_terminalSeq`'s or `exists_terminalMap`'s); a new module between the move modules and `Procedure` for the moves' step forms, if you want one; **new declarations only** in `Proofs/HadwigerNelson/Plane/ValidMap/Moves.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/MergeMove.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/OpenMove.lean` and `Proofs/HadwigerNelson/Plane/ValidMap/Surgery.lean` (ruling 421 (c): named forms that expose an assembly's map and radius, or a `private` helper made public — no statement or definition changed); `Proofs/HadwigerNelson/Plane/ValidMap/FlankUA.lean` for supporting lemmas; `Proofs.lean` and `ARCHITECTURE.md` if you add a module; `scripts/Axioms.lean` (a block of your own, headed "FS131-IR2", above the `=== PURCHASED ===` banner), `plans/FS131-limit-kernel-plan.md`, `tools/fs131_ir_*.py`, `data/fs131/ir/`, `data/fs131/reports/FS131-IR2.md`; **not** `Terminal.lean` (FS131-IS1's, on its branch), `Limit.lean`, `BaseDense`, `BendCollar`, `HexRing`, `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are proving the vertex step of the termination procedure in the Lean backlog. The milestone, FS-131, turns this project's hand-derived results
into kernel-checked ones; waves 1–4, Woodall's chain, MERGE and OPEN are on `main`. On this branch `exists_terminalMap` — every valid map of the plane has a
modification that is a terminal valid map — now rests on exactly two open lemmas: the vertex step (one move at a point, then a cleaning) and the arc step (a
bend). FS131-IR1 proved the run of the procedure over them, proved that every move's surgery is a local step, and found that the cleaning must keep the
colour function. The vertex step is yours. It is about two sessions' work by IR1's price: take the moves one at a time and hand back at a saved stage.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`); `exists_red` and
`exists_terminal`, two of wave 5's backlog rows, are read off `exists_terminalMap`. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

What IR1 handed back, and the rulings that launch you:

> 420. **FS131-IR1 handed back** (Stage 17 SAVED, harness ≈ 505k by the task notice; record `fs131-w5c`'s `plans/FS131-limit-kernel-plan.md`, Stages 12–17;
> — source: plans/FS131-close-inventory.md

> 421. **Rulings on IR1's held items, and its slot.** (a) **`clean` and `cleanKeep` both stay** until wave 5 has landed; unifying them (one colour function)
> — source: plans/FS131-close-inventory.md

The finding the step's form comes from, and the earlier ruling that 421 (c) amends:

> 384. **FS131-E6 done: F6 is real, and repaired with no backlog statement changed** (harness ≈ 540k by the task notice; record `plans/FS131-E6-derivation.md`;
> — source: plans/FS131-close-inventory.md

> 372. **Rulings on item 371.** (a) **`ArcMap.clean` accepted** as the plan's repair, with the moves' new exported lemmas as **new declarations only** (no landed
> — source: plans/FS131-close-inventory.md

## The statements

No statement changes in this job. The step, as IR1 restated it (`fs131-w5c` at `ebb0b292`; read it whole there, with its docstring), its first line and the
two lines E6's repair changed:

> theorem exists_vertexStep (hF : F.Valid) (hc : F.IsClean) {v : ℂ} (hv : v ∈ F.dom)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean

>     (hhorn : F.HasHornCount v j) {δ : ℝ} (hδ : 0 < δ) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean

>       (∃ m' j', m' + j' < m + j ∧ F'.HasDegree v m' ∧ F'.HasHornCount v j') ∧
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean

Its route (read § 4.3 whole), which opens:

> At a site `v` of a clean valid map with an available move, for every `δ > 0`, a clean valid modification that is a local step on a disc of radius
> — source: plans/FS131-E6-derivation.md 4.3 E6-ROUTE — the vertex step repaired (priority form, F7)

What is ready and what is left, move by move — IR1's work list for you; read §§ 16–17 of the record whole:

> **Left 1 — `exists_vertexStep`** (`sorry`; H, two sessions). E6-ROUTE's case split (its docstring). For each move, with `F'` its surgery at radius
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-limit-kernel-plan.md 17.3 What is proved, and what is left (three leaves), each with the route it is ready for

OPEN, the one move whose statement already gives a radius below `δ`, as it stands on this branch:

> theorem exists_open (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ : ℝ} {c : Fin k}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/OpenMove.lean

## Done means

1. **Your readback first**: check every quotation above against its source; read the record's Stages 14–17 and E6's derivation §§ 4.1–4.5; build
   `fs131-w5c` once as given (`ebb0b292`; expect it up to date) and re-run IR1's axioms check (`data/fs131/ir/IRAxiomsFinal.lean` through
   `tools/fs131_ir_axsum.py` with Stage 17's expectation list; expect 40 and 8); open Stage 18 with what you may and may not change, and add the one-line
   pointers ruling 421 (b) asks for at the head of the record's §§ 3.1 and 3.3. Commit and push.
2. **The potential first** (IR1's (c)): the sectors of a kept-colour cleaning at a point with a sector chart are the maximal runs of consecutive chart
   sectors of one colour — state it and prove it, since every move's count reads it.
3. **The moves, one case at a time**, saving after each: for each, the four clauses IR1 left — `ρ < δ`; `IsModification`'s third clause strictly inside
   the disc; the potential `degree + horns` at `v` strictly lower; no other site in the closed disc. Where an assembly hides its map behind `∃ F'`, add
   the named form beside it (ruling 421 (c)) and say in the record which declarations you added to which landed module. Re-price in the record after the
   first two cases.
4. **The assembly**: `exists_vertexStep` with no `sorry` of its own, by E6-ROUTE's priority; then an axioms print: `exists_vertexStep` by name, and
   `exists_terminalMap` on `sorryAx` through `exists_arcStep` alone, with a control.
5. No statement or definition changed anywhere; no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. You do not touch
   `Terminal.lean`, merge anything into this branch, run the gate, or touch `main`. Leave no background process running, and keep what your record cites
   under `data/fs131/ir/`.
6. **Your record**, stages headed "Stage n — SAVED (FS131-IR2)", "Theorems this phase proved"; the report in standing rule 11's form. Stopping at a saved
   stage with cases left, named, each with what it still needs, is a good report.

## What is yours to decide

The proofs, their children, the order of the cases, and where the moves' step forms live. If a clause of the step fails at some move — a point strictly
inside a move's disc that is a site, a count that does not drop — stop that case, message me with the configuration, and go on with the others: the
statement was restated once already, and a second finding is welcome, not a failure. If a form you need would change a landed statement or definition,
message me first. Three failed attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.

## Amendment, 2026-10-06 — `exists_vertexStep` takes `F.Covers v 1` (inventory items 422–423)

FS131-QA4, an audit running beside you, read the step's signature against the four moves it composes and found a hypothesis missing. Nothing you have
proved is affected if you have not yet used `hv`; if you have, the change only gives you more. The finding and the ruling:

> 422. **Statement defect, found before any proof — `exists_vertexStep` assumes `v ∈ F.dom` where every move it composes assumes `F.Covers v 1`** (FS131-QA4,
> — source: plans/FS131-close-inventory.md

> 423. **Ruling on item 422: `exists_vertexStep` takes `(hv : F.Covers v 1)` in place of `(hv : v ∈ F.dom)`** — a statement change to an internal `sorry`
> — source: plans/FS131-close-inventory.md

For you: in `exists_vertexStep`, replace `(hv : v ∈ F.dom)` by `(hv : F.Covers v 1)` — what each of the four moves takes; it gives `v ∈ F.dom` back in one
line. Update the one call, in `exists_procStep`, with the lemma below (its `hG.plane` is the plane-map hypothesis), record the statement's diff in your
record beside IR1's, and go on. `exists_arcStep`, `exists_terminalSeq` and `exists_terminalMap` are unchanged.

> theorem covers_of_isPlaneMap (hP : F.IsPlaneMap) (x : ℂ) (R : ℝ) : F.Covers x R := by
> — source: Proofs/HadwigerNelson/Plane/ValidMap/Cone.lean

This is the third repair to this statement, each found before a proof was spent on it; if you meet a fourth, it is as welcome as this one. Your touches are
unchanged. You still start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).

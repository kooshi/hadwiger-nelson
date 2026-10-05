# Brief FS131-IO3 — OPEN's last leaf: `open_allowedCone`, the positive `HasHornCount` example and the inhabitant note, on `fs131-wop`

*Written 2026-10-05 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IO3
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: OPEN's third implementer — prove `open_allowedCone` over the margin (FS131-IO2's route), so `exists_open` carries no `sorryAx`; then the positive `HasHornCount` spec example and `exists_open`'s inhabitant note, saving after each
  launch: now, beside FS131-CG1 (the collar's lane G, on `fs131-w5`) and FS131-CC1 (the collar's lane C, on `fs131-w5k`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a step that cannot be proved as written, a statement that looks false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-IO3.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IO-implementation.md` (on branch `fs131-wop`; you continue it from Stage 11, headed as yours)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wop` (branch `fs131-wop`): `Proofs/HadwigerNelson/Plane/ValidMap/OpenMove.lean` (`open_allowedCone`, its children, the spec example, docstring notes; no statement changed); `scripts/Axioms.lean` (the block headed "FS131-IO1", which you extend), `plans/FS131-IO-implementation.md`, `tools/fs131_io_*.py`, `data/fs131/io/`, `data/fs131/reports/FS131-IO3.md`; **not** any existing declaration of `main`, `MergeMove`, `Moves`, `Contact`, nor `main` itself
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are finishing OPEN, the fifth move the Lean backlog's terminal procedure needs. FS131-IO2 proved four of its five leaves and repaired two that were
false as first stated (by the fields `margin` and `ray0` of `OpenConfig`); `open_allowedCone` — OPEN leaves every allowed cone off the disc unchanged — is
left, with its route written: every child a MERGE child with the wedge added. It is yours, with the spec example and a note.

## Why this job

A result counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and the procedure's
vertex step cites `exists_open`. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

The leaf and the move, in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-wop/Proofs/HadwigerNelson/Plane/ValidMap/OpenMove.lean` at `276aeaff` (read each whole there), their first lines:

> theorem open_allowedCone (hF : F.Valid) (cfg : X.OpenConfig c up s b ψ ρc) {ρ' : ℝ} (h' : X.Small ρ') (hρρ' : ρ < ρ')
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wop/Proofs/HadwigerNelson/Plane/ValidMap/OpenMove.lean

> theorem exists_open (hF : F.Valid) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ : ℝ} {c : Fin k}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wop/Proofs/HadwigerNelson/Plane/ValidMap/OpenMove.lean

What is left, in IO2's words — read its Stages 4–10 in full:

> 1. **`open_allowedCone`** (template `merge_allowedCone` and its children, MergeMove l. 2747–3480). The route, worked out (not written):
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wop/plans/FS131-IO-implementation.md 10.3 What is left, and the plan (for whoever continues; no statement changes, `OpenConfig` as it stands)

> 2. **The positive `HasHornCount` spec example** (`cuspFrag` has `HasHornCount 0 2`): not written. Route (IO1's § 2.1): `cuspFrag_partition` and
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wop/plans/FS131-IO-implementation.md 10.3 What is left, and the plan (for whoever continues; no statement changes, `OpenConfig` as it stands)

> 3. **Owed besides** (IO1's § 3.3, unchanged): an inhabitant note for `exists_open` (no Lean model satisfies its hypotheses at once; E6's model is
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-wop/plans/FS131-IO-implementation.md 10.3 What is left, and the plan (for whoever continues; no statement changes, `OpenConfig` as it stands)

What IO2 handed back, the two repairs, the derivation, and the rulings that launch you:

> 400. **FS131-IO2 handed back** (Stage 10 SAVED, harness ≈ 560k by the task notice — past its line; it stopped at Stage 9 to run the handover; record
> — source: plans/FS131-close-inventory.md

> 401. **Ruling on IO2's slot: OPEN's last leaf, FS131-IO3, on `fs131-wop`** — `open_allowedCone` by record § 10.3 item 1, the positive `HasHornCount` example
> — source: plans/FS131-close-inventory.md

> 393. **FS131-IO2, by message: `open_allowedCone` is false as stated; a one-field repair to `OpenConfig`.** Why: in OPEN's new map the closure of the
> — source: plans/FS131-close-inventory.md

> 397. **FS131-IO2, by message: `open_degree_horns` is also false as stated; a second one-field repair to `OpenConfig`.** `OpenConfig.ray` puts the ray strictly
> — source: plans/FS131-close-inventory.md

> 384. **FS131-E6 done: F6 is real, and repaired with no backlog statement changed** (harness ≈ 540k by the task notice; record `plans/FS131-E6-derivation.md`;
> — source: plans/FS131-close-inventory.md

MERGE, whose `merge_allowedCone` and children are the template:

> 367. **FS131-IMM4 done: MERGE is proved** (harness ≈ 472k by the task notice; record `fs131-w4mm`'s `plans/FS131-IMM-implementation.md`, Stages 10–12; report
> — source: plans/FS131-close-inventory.md

## Done means

1. **Your readback first**: check every quotation above against its source; read IO2's record Stages 4–10 and `merge_allowedCone`'s proof in `main`'s `MergeMove`;
   build `fs131-wop` once as given (`276aeaff`) before editing anything. Commit and push.
2. **`open_allowedCone`** by § 10.3 item 1 over the margin; then the positive `HasHornCount` example (`cuspFrag` has `HasHornCount 0 2`, § 10.3 item 2); then
   `exists_open`'s inhabitant note (§ 10.3 item 3). Save after each; no statement changed, no new `axiom`, no `native_decide`. Do not edit a file while a build of
   it runs.
3. **The handover**: your record's last stage says what is proved and what is left, with the build log and an axioms print against that build's oleans — if OPEN
   lands, `exists_open` and every `OpenMove` theorem within the standard three. You do not merge another branch into this one, run the gate, or touch `main`.
   Leave no background process running.
4. **Your record**, stages headed "Stage n — SAVED (FS131-IO3)", "Theorems this phase proved"; the report in standing rule 11's form. Stopping at a saved stage
   with work left, named, is a good report.

## What is yours to decide

The proofs, their children and order. IO2's route is a plan, not a rule. If `open_allowedCone` is false even with the margin, stop and message me with the
smallest counterexample. Three failed attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your
own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`.

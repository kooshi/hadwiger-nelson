# Brief FS131-IR3 — the vertex step's four cases on `fs131-w5c`: MERGE-RAY, SHAVE, MERGE and OPEN, each a local step that leaves no site behind

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IR3
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: FS131-IR2's successor on the vertex step — first two small edits its hand-back left for whoever next holds `Procedure.lean` (a ruled restatement of the arc step; a merge of a finished sibling branch), then the four cases `exists_rayStep`, `exists_shaveStep`, `exists_mergeStep`, `exists_openStep` from IR2's work list, in that order, saving after each
  launch: now, in the tree FS131-IR2 has handed back, beside FS131-IA1 (the arc step's groundwork, on `fs131-w5a`) and FS131-E7 (a deriver, on `main`)
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a clause of a case that looks false at a junction or at the vertex (at once, with the configuration), a merge conflict beyond the one named below, a private detail of a move you need exported and cannot reach by a new declaration, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-IR3.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-limit-kernel-plan.md` (on branch `fs131-w5c`; your stages from 22, headed FS131-IR3)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c` (branch `fs131-w5c`, at `a5a12a0b`): `Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean`; **new declarations only** in `Moves`, `MergeMove`, `OpenMove` and `Surgery` (a named form that exposes a move's map, or a `private` helper made public — no statement or definition changed; ruling 421 (c)); the merge's files; `scripts/Axioms.lean` (a block of your own, headed "FS131-IR3", above the `=== PURCHASED ===` banner), `ARCHITECTURE.md` (a row you change the imports of), `plans/FS131-limit-kernel-plan.md`, `tools/fs131_ir_*.py`, `data/fs131/ir/ir3/`, `data/fs131/reports/FS131-IR3.md`; **not** `Terminal.lean` beyond what the merge brings, `BendStep` (it lives on `fs131-w5a`), the arc step's proof (its assembly is a later job's), `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are taking over the vertex step of the termination procedure in the Lean backlog. The milestone, FS-131, turns this project's
hand-derived results into kernel-checked ones; waves 1–4, Woodall's chain, MERGE and OPEN are on `main`. On wave 5's `Terminal` line,
`exists_terminalMap` — every valid map of the plane has a modification that is a terminal valid map — runs a procedure of two steps. Your predecessor,
FS131-IR2, proved the vertex step `exists_vertexStep` as a case split over the four local moves and built the kit the cases share: a count at the vertex
that needs no chart of the new map, and lemmas that show a point of the step's disc is no site. Each case is stated and is a `sorry`. It left a work
list with a route per case. The cases are where the lines are.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and these
four cases are half of what stands between wave 5 and it; the other half, the arc step, is being prepared on a sibling branch. Kooshi, on pricing this
work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

What the last jobs handed back, and the rulings in force:

> 435. **FS131-IR2 done at its Stage 21: the vertex step proved over four stated cases; the kit the cases share is in the kernel** (implementer;
> — source: plans/FS131-close-inventory.md

> 436. **Rulings on IR2's held items, and its slot.** (a) **The four cases go to a successor, FS131-IR3**, on `fs131-w5c`, in IR2's order
> — source: plans/FS131-close-inventory.md

> 430. **Rulings on item 429** (sent to IA1 by message). (a) **D1**: the degree clause becomes `(∀ x ∈ T, ∀ m, F.HasDegree x m → ∃ m' ≤ m,
> — source: plans/FS131-close-inventory.md

> 431. **FS131-IS1 done: `stuckRun_ne_univ` proved as written; `Terminal` holds no `sorry` of its own** (implementer; harness ≈ 408k by the task notice;
> — source: plans/FS131-close-inventory.md

> 421. **Rulings on IR1's held items, and its slot.** (a) **`clean` and `cleanKeep` both stay** until wave 5 has landed; unifying them (one colour function)
> — source: plans/FS131-close-inventory.md

> 423. **Ruling on item 422: `exists_vertexStep` takes `(hv : F.Covers v 1)` in place of `(hv : v ∈ F.dom)`** — a statement change to an internal `sorry`
> — source: plans/FS131-close-inventory.md

## The statements

No statement changes in this job but one, which is ruled (below). The step, proved over the four cases, and the cases (each `sorry`; read each whole in
the file):

> theorem exists_vertexStep (hF : F.Valid) (hc : F.IsClean) {v : ℂ} (hv : F.Covers v 1)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean

> theorem exists_rayStep (hF : F.Valid) (hc : F.IsClean) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ κ₃ κ₄ : ℝ} {c : Fin k} {n : ℕ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean

> theorem exists_shaveStep (hF : F.Valid) (hc : F.IsClean) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ σ : ℝ} {c g h : Fin k} {n : ℕ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean

> theorem exists_mergeStep (hF : F.Valid) (hc : F.IsClean) {v : ℂ} (hv : F.Covers v 1) {c : Fin k} {n : ℕ} (hn1 : 1 ≤ n)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean

> theorem exists_openStep (hF : F.Valid) (hc : F.IsClean) {v : ℂ} (hv : F.Covers v 1) {α κ₁ κ₂ : ℝ} {c : Fin k}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean

IR2's work list and its cold-start steps (read §§ 19–21 whole):

> ### 20.2 What is left: the four cases, each with its route (the next implementer's work list)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-limit-kernel-plan.md

> ### 21.3 Next step for a successor starting cold
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/plans/FS131-limit-kernel-plan.md

The arc step as it stands in your file, and the ruled repair to its statement, written out whole with its caller's changed lines by the job that
found the defect (FS131-IA1; read that § 3.6 and copy from it):

> theorem exists_arcStep (hF : F.Valid) (hc : F.IsClean) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5c/Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean

> ### 3.6 The repaired statement of `exists_arcStep` (rulings on D1 and D2, by message, 2026-10-06), for the assembly
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5a/plans/FS131-arcstep-implementation.md

## Done means

1. **Your readback first**: check every quotation above against its source; read IR2's Stages 18–21 and IR1's § 17.3 in the same record, and E6's
   § 4.3 (`plans/FS131-E6-derivation.md`); follow § 21.3's cold start (the as-given build, IR2's axioms check re-run: expect 25 and 12). Open your
   stages in the record with what you may and may not change. Commit and push.
2. **Two small edits, one stage**, before the cases. (i) **The arc step's ruled restatement** (inventory items 429–430): `exists_arcStep` gains
   `(hP : F.IsPlaneMap)` and its degree clause becomes the `x ∈ T`, `∃ m' ≤ m` form, exactly as FS131-IA1's § 3.6 has it; its one caller in
   `exists_procStep` changes as written there. It stays `sorry`: you do not prove it. Fix its docstring to match ("changing no point's degree" is the
   withdrawn clause), add to it the line the inhabitant audit asked for — "no Lean model on file; `l60Frag` cleaned, its whole arc, at [hand]"
   (`plans/FS131-QA4-audit.md` § 6.2, rank 7) — and correct `exists_vertexStep`'s docstring, which still opens "each followed by `exists_clean`"
   where its body says `cleanKeep`. Check by script that no other statement changed. (ii) **The merge**: `git merge origin/fs131-w5s` (at
   `facdf1c2`: FS131-IS1 proved `stuckRun_ne_univ`, so `Terminal` arrives with no `sorry` of its own). A trial merge shows one conflict,
   `scripts/Axioms.lean` — keep both blocks; `ARCHITECTURE.md` merges by itself. A conflict beyond that is a message to me. Build; an axioms print
   (`stuckRun_ne_univ` now on the standard three; `exists_terminal` on `sorryAx` through the five open leaves; a control). Commit the merge as its own
   commit, the stage after it, and push.
3. **The cases**, in IR2's order — MERGE-RAY, SHAVE, MERGE, OPEN — saving after each (a build, the axioms print for that case, the statement check,
   commit, push). MERGE-RAY's first two children fix the forms the other three reuse: the named form of the move with its map exposed, and the
   junction lemma in its two-curve form. Each case's truth at its junctions is IR2's hand check, one mind: if a clause fails at a junction or at the
   vertex, stop that case and message me with the configuration.
4. No statement or definition changed anywhere but the ruled one; no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs.
   You do not run the gate or touch `main`. Leave no background process running, and keep what your record cites under `data/fs131/ir/ir3/`.
5. **Your record**, stages headed "Stage n — SAVED (FS131-IR3)", "Theorems this phase proved"; the report in standing rule 11's form, ending with
   what is left and its route for a successor. This is priced at two sessions: stopping at a saved stage with two cases proved and two left is a good
   report.

## What is yours to decide

The route inside each case, the helper lemmas and their homes, and the order if a later case turns out to fix a form an earlier one needs. IR2's
routes are one mind's plan from a quarter-session of work on the kit; where a route is longer than it looks, or the kit wants a lemma in a different
form, change it and say so. If the two-curve junction lemma generalizes to a statement the arc step's assembly could also read (a bend's new curve
meeting an old arc), say so in your report — do not build it for that. Three failed attempts on one route is a dispatch to the companion your
identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.

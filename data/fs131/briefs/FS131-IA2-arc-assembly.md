# Brief FS131-IA2 — the arc step's assembly, the part that needs neither `Procedure.lean` nor the missing bend: the step's clauses from what a collar bend exports, on `fs131-w5y`

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IA2
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: FS131-IA1's successor on the arc step — in a new module downstream of `BendStep` and not yet imported by `Procedure`, prove every clause of the repaired `exists_arcStep` that can be stated without `Procedure`'s own definitions, once over the clauses a collar bend exports and then for the toward bend, with the owed lemmas W1–W4, W6 and W7 of IA1's work list; and hand over the exact last lines for whoever holds `Procedure.lean`
  launch: when a slot frees, beside FS131-IR3 (the vertex step's cases, on `fs131-w5c`, which holds `Procedure.lean`) and FS131-KA1 (the outward bend's planner, on `fs131-w5a`, which holds `BendStep.lean`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a clause of the step that looks false for the collar bend, a private detail of the collar's modules you need exported, a change you want in the clause family the two bends share (the outward bend's planner is reading the same clauses now), or a question you cannot work around; the report goes to `data/fs131/reports/FS131-IA2.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-arcstep-implementation.md` (on branch `fs131-w5y`; IA1's record, your stages from 5, headed FS131-IA2)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5y` (branch `fs131-w5y`, cut from `fs131-w5a` at `78eba0b4`): **one new module** under `Proofs/HadwigerNelson/Plane/ValidMap/` (downstream of `BendStep`; the name is yours) holding everything you prove, helper lemmas about the collar's arcs included, with `Proofs.lean` and `ARCHITECTURE.md` for it; `scripts/Axioms.lean` (a block of your own, headed "FS131-IA2", above the `=== PURCHASED ===` banner), `plans/FS131-arcstep-implementation.md`, `tools/fs131_ia2_*.py`, `data/fs131/ia2/`, `data/fs131/reports/FS131-IA2.md`; **not** `Procedure.lean` (FS131-IR3's), `BendStep.lean` nor the collar's four modules (FS131-KA1 may be adding declarations to them on `fs131-w5a`: two branches appending to one file collide at the merge, so yours go in your own module), `Terminal.lean`, `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are taking the arc step of the termination procedure in the Lean backlog as far as it can go today. The milestone, FS-131, turns this
project's hand-derived results into kernel-checked ones. On wave 5, `exists_terminalMap` — every valid map of the plane has a terminal valid
modification — runs a procedure of two steps; the arc step, `exists_arcStep`, bends one bad unit arc off its circle. Your predecessor, FS131-IA1, read
that step against the bends in the library and found three things: two clauses of its statement were false as written (repaired by ruling); the step
is a collar bend — a homeomorphism of the plane supported near the arc — and needs no cleaning afterwards; and the outward half needs a bend proved
nowhere, `bend_away_part`, which a planner is laying out now. It proved the first pieces and left a work list. Most of that list waits on nothing.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and the arc
step is one of the two things wave 5 still waits on. Three jobs touch it at once, each in its own file: the planner of the outward bend
(`BendStep.lean` and new modules above it), the implementer of the vertex step's cases (`Procedure.lean`), and you. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

What the last job handed back, and the rulings in force:

> 437. **FS131-IA1 done at its Stage 4: wave 5's two lines joined on `fs131-w5a`; question (5) proved; the arc step's toward half prepared; one bend
> — source: plans/FS131-close-inventory.md

> 438. **Rulings on IA1's held items, and its slot.** (a) **`CollarFit.map_hornCount_le` goes to the outward bend's planner, FS131-KA1** (ruling
> — source: plans/FS131-close-inventory.md

> 430. **Rulings on item 429** (sent to IA1 by message). (a) **D1**: the degree clause becomes `(∀ x ∈ T, ∀ m, F.HasDegree x m → ∃ m' ≤ m,
> — source: plans/FS131-close-inventory.md

> 433. **FS131-IA1, by message: the arc step needs one bend that is proved nowhere, and its statement is fixed** (`bend_away_part`, `sorry`, in
> — source: plans/FS131-close-inventory.md

## The statements

No statement changes in this job. The arc step as it stands in this tree's `Procedure.lean` — **the old statement** — and the ruled one you prove
toward, written out whole by IA1 (read § 3.6 and work to that text: `(hP : F.IsPlaneMap)`, and the degree clause on `x ∈ T` as `∃ m' ≤ m`):

> theorem exists_arcStep (hF : F.Valid) (hc : F.IsClean) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5y/Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean

> ### 3.6 The repaired statement of `exists_arcStep` (rulings on D1 and D2, by message, 2026-10-06), for the assembly
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5y/plans/FS131-arcstep-implementation.md

IA1's work list, your starting point (read § 4 whole; § 4.3's table names each owed lemma W1–W7 with its route):

> ### 4.3 The assembly's work list — what `exists_arcStep`'s proof in `Procedure` still needs, clause by clause
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5y/plans/FS131-arcstep-implementation.md

The two bends' statements — the proved toward bend, and the open outward one whose conclusion is the clause family both share — and the horn clause
for the toward bend, open, which you may use as it stands (your theorems then rest on it and say so):

> theorem bend_toward_collar (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5y/Proofs/HadwigerNelson/Plane/ValidMap/BendCollar.lean

> theorem bend_away_part (hF : F.Valid) (hP : F.IsPlaneMap) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5y/Proofs/HadwigerNelson/Plane/ValidMap/BendStep.lean

> theorem CollarFit.map_hornCount_le (hF : F.Valid) (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {x : ℂ} {j : ℕ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5y/Proofs/HadwigerNelson/Plane/ValidMap/BendStep.lean

> structure CollarFit (F : ArcMap k) (P : ℂ) (θ₁ θ₂ : ℝ) (c c' : Fin k) (ε R' R R'' : ℝ) : Prop where
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5y/Proofs/HadwigerNelson/Plane/ValidMap/CollarMap.lean

Two definitions the step's count clauses use live in `Procedure.lean`, which you do not edit — this is what bounds your job:

> def IsMaxRingArc (P : ℂ) (θ₁ θ₂ : ℝ) (c c' : Fin k) : Prop :=
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5y/Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean

> noncomputable def badCount (P : ℂ) : ℕ∞ :=
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5y/Proofs/HadwigerNelson/Plane/ValidMap/Procedure.lean

## Done means

1. **Your readback first**: check every quotation above against its source; read IA1's record whole and `BendStep` whole; the collar's four modules
   as far as the work list names them (`collarArcs`, `cutArcs`, `collarK`, `lensSet`, `map_R1`–`map_R3`, `map_degree_end`). Build the branch once as
   given: the build was copied from `fs131-w5a`'s tree while a build was starting there, so if anything is not up to date, let it rebuild and say so.
   Open your stages in the record with what you may and may not change. Commit and push.
2. **The interface, written before the proofs**: IA1's item 4 — one assembly for both bends. State, as a structure or a hypothesis bundle of your
   choice, **the weakest clauses the step reads from a bend**: the map, the homeomorphism, the compact collar, the gaining colour as a parameter, and
   the horn clause in the `∃ j' ≤ j` form (the outward bend's planner may weaken its iff to that, by ruling 438 (b), and the toward bend has only
   that). Show in your record, clause by clause, that `bend_away_part`'s conclusion supplies it and that the toward bend's `CollarFit` does. If you
   change your mind about a clause after this stage, message me: the planner is working to the same family.
3. **The step's clauses from the interface**, saving after each group: validity and cleanness; `LocalStep` on the closed thickening and
   `IsModification`; no site created (with W6: a horn at a point iff its horn count is at least `1`, at a chart); the degree and horn clauses at the
   points of `T`; the colours at `Q ∈ T`, `Q ≠ P`. **The two count clauses stop at the ring-arc level**: prove what the bad count's proof will read —
   which constant-sided unit arcs about `P` and about `Q ≠ P` the new map has (R1–R3, W4), that (Q) and (R2) are kept (`isR2Arc_of_fixed`), and W7
   for the outward case — as statements about `IsRingArc`, `IsQArc` and `IsR2Arc`, and leave `IsMaxRingArc`, `badCount`, W5 and the `encard` step to
   the last lines in `Procedure`.
4. **The toward bend's instance**: W1–W3 and whatever else shows `CollarFit`'s map satisfies your interface, so that the toward case of the arc
   step is your abstract lemma applied.
5. No statement or definition changed anywhere; no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. You do not merge
   another branch into this one, run the gate, or touch `main`. Leave no background process running, and keep what your record cites under
   `data/fs131/ia2/`.
6. **Your record**, stages headed "Stage n — SAVED (FS131-IA2)", "Theorems this phase proved"; the report in standing rule 11's form, ending with
   **the last lines for `Procedure`**: the exact text, as far as you can write it without compiling it there, of `exists_arcStep`'s proof from your
   lemmas — the split, the choice of `ε`, W5, the `encard` step — for the job that will hold that file. Stopping at a saved stage with the interface
   fixed and part of the clauses proved is a good report.

## What is yours to decide

The module's name and layout, the interface's form, the statements of your lemmas, and the order. IA1's work list is one mind's, written at the end
of a long session; where a route is longer than it looks or an owed lemma is false as sketched, change it and say so. If you find the count clauses
can be stated cleanly upstream of `Procedure` after all — or that moving the two definitions into a small module of their own would save the last
job real work — say so in a message; that edit is not yours to make, and I can rule on it. Three failed attempts on one route is a dispatch to the
companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.

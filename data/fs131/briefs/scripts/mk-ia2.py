exec(open("/home/kooshi/source/lean-dir/data/fs131/briefs/scripts/mkbrief.py").read())
import subprocess
Y=WT+"fs131-w5y/"
TIP=subprocess.run(["git","-C",Y,"rev-parse","--short","HEAD"],capture_output=True,text=True).stdout.strip()
V=Y+"Proofs/HadwigerNelson/Plane/ValidMap/"
PR=V+"Procedure.lean"; BS=V+"BendStep.lean"; BC=V+"BendCollar.lean"; CM=V+"CollarMap.lean"
IA=Y+"plans/FS131-arcstep-implementation.md"
b=f'''# Brief FS131-IA2 — the arc step's assembly, the part that needs neither `Procedure.lean` nor the missing bend: the step's clauses from what a collar bend exports, on `fs131-w5y`

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IA2
  identity: {IDENT}
  role: FS131-IA1's successor on the arc step — in a new module downstream of `BendStep` and not yet imported by `Procedure`, prove every clause of the repaired `exists_arcStep` that can be stated without `Procedure`'s own definitions, once over the clauses a collar bend exports and then for the toward bend, with the owed lemmas W1–W4, W6 and W7 of IA1's work list; and hand over the exact last lines for whoever holds `Procedure.lean`
  launch: when a slot frees, beside FS131-IR3 (the vertex step's cases, on `fs131-w5c`, which holds `Procedure.lean`) and FS131-KA1 (the outward bend's planner, on `fs131-w5a`, which holds `BendStep.lean`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: {FENCE}
  channel: message the coordinator ("main") by SendMessage mid-job for a clause of the step that looks false for the collar bend, a private detail of the collar's modules you need exported, a change you want in the clause family the two bends share (the outward bend's planner is reading the same clauses now), or a question you cannot work around; the report goes to `data/fs131/reports/FS131-IA2.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: {STAND}
  record: `plans/FS131-arcstep-implementation.md` (on branch `fs131-w5y`; IA1's record, your stages from 5, headed FS131-IA2)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5y` (branch `fs131-w5y`, cut from `fs131-w5a` at `{TIP}`): **one new module** under `Proofs/HadwigerNelson/Plane/ValidMap/` (downstream of `BendStep`; the name is yours) holding everything you prove, helper lemmas about the collar's arcs included, with `Proofs.lean` and `ARCHITECTURE.md` for it; `scripts/Axioms.lean` (a block of your own, headed "FS131-IA2", above the `=== PURCHASED ===` banner), `plans/FS131-arcstep-implementation.md`, `tools/fs131_ia2_*.py`, `data/fs131/ia2/`, `data/fs131/reports/FS131-IA2.md`; **not** `Procedure.lean` (FS131-IR3's), `BendStep.lean` nor the collar's four modules (FS131-KA1 may be adding declarations to them on `fs131-w5a`: two branches appending to one file collide at the merge, so yours go in your own module), `Terminal.lean`, `main`
  budget: {BUDGET}

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

{KOOSHI}
What the last job handed back, and the rulings in force:

{item(437)}
{item(438)}
{item(430)}
{item(433)}
## The statements

No statement changes in this job. The arc step as it stands in this tree's `Procedure.lean` — **the old statement** — and the ruled one you prove
toward, written out whole by IA1 (read § 3.6 and work to that text: `(hP : F.IsPlaneMap)`, and the degree clause on `x ∈ T` as `∃ m' ≤ m`):

{Q(PR,"theorem exists_arcStep ")}
{Q(IA,"### 3.6 The repaired statement of `exists_arcStep`")}
IA1's work list, your starting point (read § 4 whole; § 4.3's table names each owed lemma W1–W7 with its route):

{Q(IA,"### 4.3 The assembly's work list")}
The two bends' statements — the proved toward bend, and the open outward one whose conclusion is the clause family both share — and the horn clause
for the toward bend, open, which you may use as it stands (your theorems then rest on it and say so):

{Q(BC,"theorem bend_toward_collar ")}
{Q(BS,"theorem bend_away_part ")}
{Q(BS,"theorem CollarFit.map_hornCount_le ")}
{Q(CM,"structure CollarFit ")}
Two definitions the step's count clauses use live in `Procedure.lean`, which you do not edit — this is what bounds your job:

{Q(PR,"def IsMaxRingArc ")}
{Q(PR,"noncomputable def badCount ")}
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
companion your identity names, never a fourth. {NOSPAWN}

{MACHINE}
## Amendment, 2026-10-06 (sent to the job by message the same hour; inventory item 442)

From the outward bend's planner, FS131-KA1, at its Stage 2 (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5a/plans/FS131-bendaway-kernel-plan.md`):

1. The horn clause both bends export is the arc step's form, as this brief already asks: KA1 took ruling 438 (b)'s weakening. Every other clause of
   `bend_away_part` stays as IA1 wrote it.
2. **W1 and W2 are stated once, by KA1, upstream of `BendStep`**, as one lemma: `LocalStep` for any map whose arcs are `F.cutArcs P θ₁ θ₂ ∪ S` with
   `S` inside `K`. State your `LocalStep` result for the toward bend as an instance of that general form, not as two lemmas. Its exact text comes to
   you by message when KA1's skeleton holds it; if you prove it first, write the general lemma in your own module, say so in your record, and match
   the text when it arrives — the proof moves to KA1's upstream home at the merge. Take the other groups of clauses first if your order allows.
3. KA1's construction bends the gaps one after another on the toward bend's own collar set, and the toward bend satisfies the same internal clause
   package: "one assembly for both" stands. {NOSPAWN}

## Second amendment, 2026-10-06 (sent by message; inventory item 443): the W1/W2 lemma's exact text

From FS131-KA1's message to the coordinator — its new module `BendAway` on `fs131-w5a` (imports `Limit`, `UnitArc`, `OpenMove`; namespace
`HadwigerNelson.Plane.ArcMap`, `variable {{k : ℕ}} {{F : ArcMap k}}`); the text is final by KA1's word, its commit pending at this writing:

```lean
theorem LocalStep.of_cutArcs {{M : ArcMap k}} {{K : Set ℂ}} {{S : Set Arc}} {{P : ℂ}} {{θ₁ θ₂ : ℝ}} (h12 : θ₁ < θ₂)
    (hag : M.AgreesOff F K) (harcs : M.arcs = F.cutArcs P θ₁ θ₂ ∪ S) (hS : ∀ a ∈ S, a.carrier ⊆ K)
    (hK : ringArc P θ₁ θ₂ ⊆ K) : LocalStep F M K := by
  sorry
```

State it in your module with exactly this signature (a `sorry` child you apply, or proved) and record which; at the merge the two are one
declaration and a proof of yours moves to `BendAway`. The toward instance, in KA1's words: `M := hfit.map`, `S := {{collarArcA P θ₁ θ₂ R,
collarArcB P θ₁ θ₂ R}}`, `K := collarK P θ₁ θ₂ R' R''` or any set holding it (`LocalStep.mono`), `hag` from `CollarFit.map_agreesOff` weakened to
`K`. KA1 also holds `LocalStep.union : LocalStep F M₁ K₁ → LocalStep M₁ M₂ K₂ → LocalStep F M₂ (K₁ ∪ K₂)` there. If the signature does not fit
the toward instance, message the coordinator with what is off; do not change it.
'''
open(ROOT+"data/fs131/briefs/FS131-IA2-arc-assembly.md","w").write(b)
print("written at tip",TIP)

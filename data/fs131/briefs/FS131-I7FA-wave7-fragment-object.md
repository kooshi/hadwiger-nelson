# Brief FS131-I7FA — wave 7, the bowtie fragment, first job — the object, on `fs131-w7f`

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I7FA
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the first of four implementers who put the wave's explicit example map in the kernel — define the twenty-tile six-colour map by formula from the tool that built it, prove its colour function locally constant, identify its twenty tiles, and prove it covers the closed disc of radius `3√3/5`; fix the names the other three jobs will prove things about
  launch: when a slot frees; the three jobs after you (validity; non-Siamese and simple; the bowtie predicates and the examples) start from your hand-back and run side by side
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf or a hypothesis that is false or cannot be met as stated (at once, with the configuration: a statement change goes back through me — and say which kind you have, a *statement* that needs a hypothesis it lacks, or a *route* that reads more than the statement needs), a helper you need that another of the wave's implementers would need too (so that one of you writes it), or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I7FA.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I7FA-implementation.md` (new, on branch `fs131-w7f`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7f` (branch `fs131-w7f`, at `b1101992`): the new module `Proofs/HadwigerNelson/Plane/FourColour/BowtieFragment.lean` (and a second beside it if the object and its tile lemmas want two), with `Proofs.lean` and `ARCHITECTURE.md` for it (`./scripts/dupnames.sh` before each push that adds names); `scripts/Axioms.lean` (a block of your own, headed "FS131-I7FA", above the `=== PURCHASED ===` banner), `plans/FS131-I7FA-implementation.md`, `tools/fs131_i7fa_*.py`, `data/fs131/i7fa/`, `data/fs131/reports/FS131-I7FA.md`; **not** any statement, `Proofs/HadwigerNelson/Plane/FourColour/Local.lean`, `Bowtie.lean`, `Basic.lean` (the wave's stated modules: other implementers', and the foundation), `Proofs/HadwigerNelson/Plane/SixFragment.lean` (landed: read it as the pattern, change nothing), `Proofs/HadwigerNelson/Plane/SimpleOn.lean` and `Proofs/HadwigerNelson/Plane/RingCalculus/` (wave 8's), any landed module, `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are proving part of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into kernel-checked
ones. Wave 7 is about a vertex where four colours meet in a tight six-colour map of the plane — what such a vertex forces within an
explicit radius. Three planners have worked on it: the first stated and an implementer proved the counting half; the second wrote the
four-colour foundation (the tactic edge, the Reuleaux cross and bowtie) and stated two modules of leaves; the third, today, read every
one of those leaves back from the kernel, corrected seven statements, split the longest leaf into eight, and settled which explicit map
the wave's examples are about. What none of them could do is exhibit the map itself: every hypothesis of the wave that is a structure — a tactic edge, a
Reuleaux cross, a bowtie — names one explicit twenty-tile map as its example, and that map exists today only as a Python tool's output.
Until it is a Lean object the wave cannot pass the gate, whatever is proved about it. Putting it there is four jobs; yours is the first,
and the other three build on the names you fix. `main` is not merged into your branch and need not be: nothing of yours reads wave 8.

## Why this job

A result counts as held only when its Lean module passes the gate. These leaves are the local half of the unit-arc question (`LEDGER.md`
rows 137–138; `CLAUDE.md` § Where the problem stands, item 31): the bowtie's stop says a Reuleaux bowtie at a four-colour vertex cannot
live in a disc of radius `√3`. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

What the planners handed back, and the rulings in force (read each item whole in the inventory, `plans/FS131-close-inventory.md`):

> 606. **FS131-K7c done at its Stage 14: wave 7's third planning pass — its three early answers given (items 601, 604), FS114-Y3-RSTOP stated at the class its argument reads, the wave's assumptions listed; the pinwheel not started, by its own judgment, with a fourth pass's reading list** (planner; harness 480k and 46 minutes by the task notice; record `fs131-w7`'s `plans/FS131-w7-kernel-plan.md` Stages 8–14; report `data/fs131/reports/FS131-K7c.md`; five commits, tip `b1101992`; pushed, tree clean).
> — source: plans/FS131-close-inventory.md

> 604. **FS131-K7c, by message mid-job (its Stages 11–13 saved at `02a11514`): wave 7's two stated modules are ready for implementers — four of the five (Q)-arc leaves proved on valid maps alone, one skeleton statement found false in a degenerate case and corrected, the bowtie's stop split into eight children with its "simple" hypothesis narrowed to two points, and the fragment's plan rewritten for the rebuild** (source: K7c's message to "main", 2026-10-07 about 01:10 UTC; record `fs131-w7`'s `plans/FS131-w7-kernel-plan.md` Stages 11–13).
> — source: plans/FS131-close-inventory.md

> 601. **FS131-K7c, by message mid-job (its Stage 10 saved at `9b13628a`): the discrepancy of ruling 553 (a) is settled — two different bowtie fragments are on file, and FS-116's ring survey read the second under the first's name** (source: K7c's message to "main", 2026-10-07 about 00:55 UTC; record `fs131-w7`'s `plans/FS131-w7-kernel-plan.md` Stage 10; `data/fs131/k7c/ring-both.out`).
> — source: plans/FS131-close-inventory.md

> 553. **FS131-K7b done at its Stage 7: wave 7's second planning pass — the four flags decided, the four-colour foundation
> — source: plans/FS131-close-inventory.md

> 564. **FS131-I7A done at its Stage 3: route T's count is proved — nineteen leaves and two models; four of the nineteen were false as the skeleton stated them, repaired as ruled; `anchor` not started** (implementer, Opus; harness 451k and 60 minutes by the task notice; record `fs131-w7a`'s `plans/FS131-I7A-implementation.md`; report `data/fs131/reports/FS131-I7A.md`; four commits, tip `5777e8e7`; pushed, tree clean).
> — source: plans/FS131-close-inventory.md

> 556. **FS131-I7A, by message mid-job: a defect of the skeleton — four leaves of route T's count are false as stated, because
> — source: plans/FS131-close-inventory.md

> 573. **FS131-L10B, by message mid-job: the gate is green at every step but the guarded lint — one unused instance argument; a word asked and given** (source: L10B's message to "main", 2026-10-06; its gated commit `e80221d3` on `fs131-w10m` — the artifact is read at its hand-back).
> — source: plans/FS131-close-inventory.md

> 596. **FS131-I8C, by message: three corrections to its note of item 593** (source: I8C's message to "main", 2026-10-06; nothing of its third stage is committed yet).
> — source: plans/FS131-close-inventory.md

**Which map**, since two are on file: the coordinator ruled this morning (inventory item 601, ruling (a)) that the kernel holds the
verifier's rebuild — `tools/fs114_yb2_run.py` — and not the original construction's (`tools/fs114_y2_k1.py`), because the rebuild is an
example for strictly more of what waves 7 and 8 state. The ruling carries a condition, and you are the one who checks it (item 1 below).

## The statements

There is no leaf to prove: you write the object and its first theorems. The structures the object must in the end inhabit (the fourth
job proves that it does; you make sure the object is the one that can), and the two predicates your own theorems are about:

> structure IsTacticAt (p q : ℂ) (x y z : Set ℂ) : Prop where
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7f/Proofs/HadwigerNelson/Plane/FourColour/Basic.lean

> structure IsReuleauxCross (p : ℂ) (φ : ℝ) (t₂ t₄ : Set ℂ) : Prop where
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7f/Proofs/HadwigerNelson/Plane/FourColour/Basic.lean

> structure IsReuleauxBowtie (p : ℂ) (φ : ℝ) (t₂ t₄ : Set ℂ) : Prop where
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7f/Proofs/HadwigerNelson/Plane/FourColour/Basic.lean

> def Covers (p : ℂ) (R : ℝ) : Prop := closedBall p R ⊆ F.dom
> — source: Proofs/HadwigerNelson/Plane/ArcMap.lean

> def Valid : Prop := ∀ x ∈ F.interiorPts, ∀ y ∈ F.interiorPts, dist x y = 1 → F.col x ≠ F.col y
> — source: Proofs/HadwigerNelson/Plane/ArcMap.lean


The plan — the third planner's Stage 13 and the second's § 7.5 in the wave's record, `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7f/plans/FS131-w7-kernel-plan.md`: read both whole; these are the first
lines of the paragraphs that are yours:

> **This section replaces § 7.5's paragraph "The object"; its route and its four jobs stand.**
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7f/plans/FS131-w7-kernel-plan.md

> **The object** — `tools/fs114_yb2_run.py` ll. 152–215 (`class Bowtie`; the points ll. 163–180, the seven base tiles ll. 190–198, the
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7f/plans/FS131-w7-kernel-plan.md

> - **Points**: `q₁ = e(30°)`, `q₂ = e(−30°)`, `q_C = e(150°)` (this record's `q₄`), `q_D = e(210°)` (`q₃`), `top = (0, 1)`,
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7f/plans/FS131-w7-kernel-plan.md

> - **Seven base tiles**, each a closed chain of unit arcs about `p, q₁, q₂, q_C, q_D, top, bot` and segments (no other centre):
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7f/plans/FS131-w7-kernel-plan.md

> - **Twenty tiles** by `D₂`: `σ_x : x ↦ −x` with colours `(1 3)(5 6)`, `σ_y : y ↦ −y` with `(2 4)(5 6)`; orbits `t1` 2 (`t1`, `t3`),
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7f/plans/FS131-w7-kernel-plan.md

> - **Same-colour pairs: 46** (20 a tile with itself; 3 + 10 + 3 + 10 + 10 + 10), **32 tight at 1** (12 self maxima, 20 minima), so, as
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7f/plans/FS131-w7-kernel-plan.md

> - **The rim**: 22 outer pieces, all segments, each farther than `3√3/5` from `p` (exact, against `27/25`): the fragment holds
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7f/plans/FS131-w7-kernel-plan.md

> - **At the named points**: `p` — `t1, t2, t3, t4`, colours 1–4; each `q_i` — five tiles, five colours (`q₁`: `t1, V, T1, Z, X`
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7f/plans/FS131-w7-kernel-plan.md

> **What the first job checks at its readback, and stops on** (the ruling's condition): that (b) meets each hypothesis the wave's
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7f/plans/FS131-w7-kernel-plan.md

> - **(A)** the object, its colour function by formula, local constancy, the twenty tiles identified, `Covers 0 (3√3/5)`. Serves:
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7f/plans/FS131-w7-kernel-plan.md

> - **(B)** validity: the 46 pair bounds under `D₂`. Serves: every `F.Valid`.
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7f/plans/FS131-w7-kernel-plan.md

> - **(C)** non-Siamese, connectedness, `SimpleOn {q₁, q₂}`, `SimpleOn {p}` (now two finite sets — the Jordan clause at the tiles
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7f/plans/FS131-w7-kernel-plan.md

> - **(D)** `IsReuleauxBowtie 0 0 t2 t4` with its four tactic edges, and the inhabitant examples: **for `Local`** — `lens_cone` (`t1` at
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7f/plans/FS131-w7-kernel-plan.md

> (A) fixes the names; (B), (C), (D) then run side by side. The module is `Plane/FourColour/BowtieFragment`, the object `bowtieFrag`.
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7f/plans/FS131-w7-kernel-plan.md

> **The route: the map by formula, as wave 3's `sixFrag`** (`Plane/SixFragment`, 2,229 lines: `sixCol` by inequalities, the local constancy,
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7f/plans/FS131-w7-kernel-plan.md

> **Price: about 5,500 lines, four implementer jobs, of its own line** — (A) the object, its colour function, local constancy, the tiles
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7f/plans/FS131-w7-kernel-plan.md


## Done means

1. **Your readback, and the ruling's condition.** Check the quotations against their sources. Read the tool (`tools/fs114_yb2_run.py`,
   ll. 152–215) and its description in words (`plans/FS114-YB2-verification.md` ll. 110–132), the foundation module, and wave 3's
   `Proofs/HadwigerNelson/Plane/SixFragment.lean` — the pattern you follow, a six-colour map by inequalities. Then, before any Lean: **check on paper and with
   the tool as it is that the rebuild meets each hypothesis the planner lists** — the Reuleaux cross at the centre, the four tactic
   edges with their partners, "simple" at the two corners and at the centre — and that its pair bounds do not price well above the
   plan's. **If one fails, stop and message me with which and why**: the ruling then turns to the other map, and nothing you would
   have built is lost. You may run the existing tools on the objects they hold; nothing that searches. Build the branch once as given.
   Open your record. Commit and push.
2. **The object**: the map by formula — its colour function by inequalities over `ℚ(√3)` data, as `sixFrag` is — named `bowtieFrag`,
   in the module the plan names, with its named points and its twenty tiles as declarations the next three jobs can cite. The two
   reflections are carried by hand (no isometry transport of an `ArcMap` exists in the library): the planner makes that small
   transport for this one map's colour function your first child.
3. **Its first theorems**: local constancy of the colour function, each of the twenty tiles identified with its region, and
   `bowtieFrag.Covers 0 (3 * √3 / 5)`. Save after each (a build, the axioms print for it with a control that fires, the wave's
   instruments are on your branch: `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7f/tools/fs131_i7a_stmt_check.py` and the third planner's kernel-signature reader
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7f/tools/fs131_k7c_kernelsig.py` with `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7f/data/fs131/k7c/kernel-sigs.lean` — commit, push). **Before you prove a helper, search the tree for its statement's shape, not for a name** (inventory item 596) —
   `SixFragment` and the example maps under `Proofs/HadwigerNelson/Plane/Models/` hold many of the lemmas a map by formula needs. Re-price after the object and
   its first theorem, and say so: about 1,400 lines by the planner, for this job of the four.
3a. **The hand-off to the three jobs after you** is part of this job: in your record, the names you fixed, each tile's defining
   inequalities in one table, the list of same-colour pairs by symmetry class (the planner leaves the dozen classes to you, from the
   tool's output), and what each of jobs (B), (C), (D) can cite — written so that three colleagues can start side by side from your
   last commit without asking you anything.
4. No statement or definition changed; no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. You do not
   merge another branch beyond what item 1 names, run the gate, or touch `main`. **After your last green build, the guarded lint** —
   `lake lint --no-build -- --no-build --trace` under the slot with `--mem 8` (`LEAN.md` § The gate), its output saved (inventory item
   573). Leave no background process running, and keep what your record cites under your `data/` folder.
5. **Your record**, stages headed "Stage n — SAVED (FS131-I7FA)", "Theorems this phase proved", each read against its row; the report in
   standing rule 11's form, ending with what is left and its route. Stopping at a saved stage with part of the work done is a good
   report.

## What is yours to decide

The form of the colour function, the layout of the module, the names, and the order after item 1. The plan is one mind's reading of a
tool and a verifier's record; it was not elaborated. If the rebuild is harder to state by formula than the plan expects, say what makes
it so — that is information the ruling wants. Three failed attempts on one route is a dispatch to the companion your identity names,
never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.

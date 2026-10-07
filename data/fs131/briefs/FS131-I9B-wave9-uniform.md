# Brief FS131-I9B — wave 9, the reductions: three leaves of the uniform bound, and three models the wave's gate asks for, on `fs131-w9b`

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I9B
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: wave 9's first implementer — prove the three open leaves of `Proofs/HadwigerNelson/Plane/Reduction/Uniform.lean` from the planner's plan, without changing a statement, and build the Lean models M1–M3 its plan names in a new module, saving after each leaf or model
  launch: when a slot frees, on a branch cut from the commit at which the wave's first planner handed back; the wave's second planner works on the wave's other two modules in a tree of its own at the same time
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf whose statement is false or cannot be proved as stated (at once, with the configuration: a statement change goes back through me — and say which kind you have, a *statement* that needs a hypothesis it lacks, or a *route* that reads more than the statement needs), a model that cannot be built as the plan names it (with what fails), or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I9B.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I9B-implementation.md` (new, on branch `fs131-w9b`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9b` (branch `fs131-w9b`, cut from `fs131-w9` at `50c0edc5`): `Proofs/HadwigerNelson/Plane/Reduction/Uniform.lean` — proofs, and new helper declarations under names no other module declares (`./scripts/dupnames.sh` before each push that adds names); a new module `Proofs/HadwigerNelson/Plane/Reduction/Models.lean`, with `Proofs.lean` and `ARCHITECTURE.md` for it; `scripts/Axioms.lean` (a block of your own, headed "FS131-I9B", above the `=== PURCHASED ===` banner), `plans/FS131-I9B-implementation.md`, `tools/fs131_i9b_*.py`, `data/fs131/i9b/`, `data/fs131/reports/FS131-I9B.md`; **not** any statement, `Proofs/HadwigerNelson/Plane/Reduction/Basic.lean` and `Proofs/HadwigerNelson/Plane/Reduction/Maps.lean` beyond new declarations (they are proved, and the models read them), anything under `Proofs/HadwigerNelson/Plane/Classes/` (the second planner's and a later implementer's), any landed module, `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are proving part of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into kernel-checked
ones. Wave 9 is the reductions: how a measurable colouring of the plane, proper at almost every unit pair, becomes a map, and what the
bound on holes says once it is uniform in a complexity bound. Its planner stated all eleven rows and proved five; of the five leaves left,
three are in one module and are yours, with three small models the planner found the wave's gate would ask for. A second planner is
splitting the wave's long leaf at the same time, in another tree; you share no file with it.

## Why this job

A result counts as held only when its Lean module passes the gate. The module you finish carries the sentence the project's direction
rests on in its sharpest form — seven colours are needed almost everywhere exactly when the hole bound stays positive uniformly in the
complexity (`CLAUDE.md` § The aim, item 5; `LEDGER.md` rows 131, 139) — as `seven_le_chiM0_iff_delta0`, already proved over your three
leaves and not a theorem until they are. And the gate's inhabitant rule asks, of every theorem whose hypotheses are structures, for a
Lean object meeting all of them at once: three of the wave's proved theorems have none yet. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

What the planner handed back, and the rulings in force (read each item whole in the inventory, `plans/FS131-close-inventory.md`):

> 536. **FS131-K9 done at its Stage 5: wave 9's first planning pass — all eleven rows disposed and stated, five proved; five
> — source: plans/FS131-close-inventory.md

> 556. **FS131-I7A, by message mid-job: a defect of the skeleton — four leaves of route T's count are false as stated, because
> — source: plans/FS131-close-inventory.md

> 573. **FS131-L10B, by message mid-job: the gate is green at every step but the guarded lint — one unused instance argument; a word asked and given** (source: L10B's message to "main", 2026-10-06; its gated commit `e80221d3` on `fs131-w10m` — the artifact is read at its hand-back).
> — source: plans/FS131-close-inventory.md

> 596. **FS131-I8C, by message: three corrections to its note of item 593** (source: I8C's message to "main", 2026-10-06; nothing of its third stage is committed yet).
> — source: plans/FS131-close-inventory.md

## The statements

No statement changes in this job. Your three leaves, as they stand in your tree (read each whole, with its docstring):

> theorem upperDensity_compl_of_latticePeriodic {S : Set ℂ} (hS : MeasurableSet S) {v₁ v₂ : ℂ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9b/Proofs/HadwigerNelson/Plane/Reduction/Uniform.lean

> theorem IsTiled.isArcDesign {C : Fin k → Set ℂ} (h : IsTiled C) : ∃ K, IsArcDesign K C := by
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9b/Proofs/HadwigerNelson/Plane/Reduction/Uniform.lean

> theorem iInf_delta0_le (k : ℕ) : ⨅ K, delta0 K k ≤ 1 - muZero k := by
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9b/Proofs/HadwigerNelson/Plane/Reduction/Uniform.lean


The three proved theorems the models are for (M1, M2, M3 in the plan's order):

> theorem exists_arcMap_of_arcBounded {C : Fin k → Set ℂ} {𝒜 : Set Arc} (h𝒜 : IsArcSystem 𝒜) (hfr : ArcBounded 𝒜 C)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9b/Proofs/HadwigerNelson/Plane/Reduction/Basic.lean

> theorem v0_clean {K : ℕ} {C : Fin k → Set ℂ} (hC : IsArcDesign K C) (hcov : ∀ᵐ x ∂(volume : Measure ℂ), x ∈ ⋃ j, C j)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9b/Proofs/HadwigerNelson/Plane/Reduction/Maps.lean

> theorem exists_arcMap_of_regular_cover {C : Fin k → Set ℂ} {𝒜 : Set Arc} (hC : IsAeCover C)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9b/Proofs/HadwigerNelson/Plane/Reduction/Maps.lean


The definitions they read (your tree, and `main`):

> def IsArcSystem (𝒜 : Set Arc) : Prop :=
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9b/Proofs/HadwigerNelson/Plane/Reduction/Basic.lean

> def ArcComplexity (K : ℕ) (𝒜 : Set Arc) : Prop :=
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9b/Proofs/HadwigerNelson/Plane/Reduction/Basic.lean

> def ArcBounded (𝒜 : Set Arc) (C : Fin k → Set ℂ) : Prop := ∀ j, frontier (C j) ⊆ ⋃ a ∈ 𝒜, a.carrier
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9b/Proofs/HadwigerNelson/Plane/Reduction/Basic.lean

> def IsArcDesign (K : ℕ) (C : Fin k → Set ℂ) : Prop :=
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9b/Proofs/HadwigerNelson/Plane/Reduction/Basic.lean

> def IsLatticePeriodic (C : Fin k → Set ℂ) : Prop :=
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9b/Proofs/HadwigerNelson/Plane/Reduction/Basic.lean

> noncomputable def holeInf (K k : ℕ) (ε : ℝ) : ENNReal :=
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9b/Proofs/HadwigerNelson/Plane/Reduction/Basic.lean

> noncomputable def delta0 (K k : ℕ) : ENNReal := ⨅ ε > (0 : ℝ), holeInf K k ε
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9b/Proofs/HadwigerNelson/Plane/Reduction/Basic.lean

> def IsTiled (C : Fin k → Set ℂ) : Prop := ∃ h > 0, ∀ j, IsGridUnion h (C j)
> — source: Proofs/HadwigerNelson/Plane/Suprema.lean

> noncomputable def upperDensity (S : Set ℂ) : ENNReal :=
> — source: Proofs/HadwigerNelson/Plane/Suprema.lean

> noncomputable def muZero (k : ℕ) : ENNReal :=
> — source: Proofs/HadwigerNelson/Plane/Suprema.lean


Landed lemmas and the landed map the plan's routes name:

> theorem upperDensity_of_periodic {v₁ v₂ : ℂ} (hv : LinearIndependent ℝ ![v₁, v₂]) {S : Set ℂ} (hS : MeasurableSet S)
> — source: Proofs/HadwigerNelson/Plane/Slack.lean

> theorem eventually_le_muPer (k : ℕ) {d : ENNReal} (hd : d < muZero k) : ∀ᶠ ε in 𝓝[>] (0 : ℝ), d ≤ muPer k ε := by
> — source: Proofs/HadwigerNelson/Plane/Slack.lean

> noncomputable def sevenBrickMap : ArcMap 7 where
> — source: Proofs/HadwigerNelson/Plane/SVMap.lean


The plan (the planner's record, `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9b/plans/FS131-w9-kernel-plan.md`, Stages 1–5: read it whole — its § 4.3 has a route per leaf and per model, its § 4.2 each
theorem read back against its row):

> | `Plane/Reduction/Uniform` | 3 | C1-UNIF over U1 `upperDensity_compl_of_latticePeriodic`, U2 `IsTiled.isArcDesign`, U3 `iInf_delta0_le` |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9b/plans/FS131-w9-kernel-plan.md

> **U. `Reduction/Uniform`'s three**: U1 `upperDensity_compl_of_latticePeriodic` from `upperDensity_of_periodic`† twice (about 60
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9b/plans/FS131-w9-kernel-plan.md

> **M. Models owed before the wave's gate** (`LEAN.md` § The gate's inhabitant rule), a new module `Plane/Reduction/Models`:
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9b/plans/FS131-w9-kernel-plan.md

> - **Two implementers split by file.** *I9A*: `Plane/Classes/Bend` (`bendAny`: B1–B5) and `Plane/Classes/QFree`'s leaf D.
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9b/plans/FS131-w9-kernel-plan.md

> **Re-priced from the first leaves proved here**: the face colouring (70 lines) and the five compositions elaborated at the first
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9b/plans/FS131-w9-kernel-plan.md

> - **FS111-C1-UNIF** — row: "1 − lim_{ε→0} µ₆(ε) = inf_K δ₀(K); hence χ_m⁰(ℝ²) ≥ 7 ⟺ inf_K δ₀(K) > 0". Lean: `c1_unif_tendsto
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9b/plans/FS131-w9-kernel-plan.md

> - **FS111-V0-CLEAN** — row: "the limit tiling W-EQ-K produces (a full tight a.e.-proper six-colouring by closed tiles of
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9b/plans/FS131-w9-kernel-plan.md

> - **FS111-M2-REDUCE-C** — row: "if some maximal k-cover has regular classes whose boundaries form a locally finite plane graph
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w9b/plans/FS131-w9-kernel-plan.md


## Done means

1. **Your readback first**: check the quotations against their sources; read the planner's record whole, the wave's three reduction
   modules and what they import, and the row's derivation entry at the address the record gives. `#check` each of your three leaves and
   the three theorems the models are for, and read the binders the kernel shows (inventory item 556: a section `variable` enters a
   theorem only if its statement mentions it — a leaf whose kernel statement lacks a hypothesis its row reads is a message to me before
   you prove it). Build the branch once as given (five `sorry` leaves in the wave, three yours). Open your record with what you may and
   may not change. Commit and push.
2. **The three leaves**, in the planner's order U1, U2, U3; saving after each (a build, the axioms print for it with a control that
   fires, a statement check on elaborated signatures against `50c0edc5` — the milestone's instrument is
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7m/tools/fs131_i7a_stmt_check.py`, on another wave's branch: copy it under a
   name of your own and say so — commit, push). **Before you prove a helper, search the tree for its statement's shape, not for a
   name** (item 596: an implementer wrote two weaker copies of landed theorems today). Re-price after U1 and say so: about 340 lines
   by the planner, the counting in U2 the work.
3. **The models M1, M2, M3**, in a new module `Proofs/HadwigerNelson/Plane/Reduction/Models.lean`: each a Lean object meeting every hypothesis of its theorem
   at once, with the theorem applied to it (`LEAN.md` § The gate, the inhabitant rule) — the plan names the brick map and its regions
   for all three. A model that cannot be built as named is a message to me with what fails, and an open gate item named in your report
   (ruling 536 (c)); it is not a reason to weaken a hypothesis. M4 and M5 are another job's.
4. No statement or definition changed; no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. You do not
   merge another branch, run the gate, or touch `main`. **After your last green build, the guarded lint** — `lake lint --no-build --
   --no-build --trace` under the slot with `--mem 8` (`LEAN.md` § The gate), its output saved (inventory item 573). Leave no background
   process running, and keep what your record cites under your `data/` folder.
5. **Your record**, stages headed "Stage n — SAVED (FS131-I9B)", "Theorems this phase proved", each read against its row; a draft of the
   lines the wave's landing will want for what you proved (the ledger's rows, the docstrings that named a model as owed); the report in
   standing rule 11's form, ending with what is left and its route. Stopping at a saved stage with part of the work done is a good
   report.

## What is yours to decide

The route inside each leaf, your helpers, the models' construction, and the order within the plan's dependencies. The plan is one
mind's, and it says of itself that its Mathlib names for your leaves were read, not elaborated against: change a route that does not go
and say so. A statement is not yours to change: one that is false, or true only with a hypothesis the plan did not see, is a message to
me, and a finding. Three failed attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.

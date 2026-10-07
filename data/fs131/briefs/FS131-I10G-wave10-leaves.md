# Brief FS131-I10G — wave 10's three open leaves, and the gate items its second landing left open, on `fs131-w10g`

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I10G
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: wave 10's remaining implementer — merge the third planner's tip into a branch cut from `main`; prove the level row's two leaves and the leaf that exhibits a usable place of the standing field, without changing a statement; then close what the wave's second landing left open: two small Lean models, and the docstrings that still describe them as owed
  launch: when a slot frees; the wave's fourth planner starts later, from the commit your first act makes
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job — **once, early, with the hash of your merge commit** (item 1: the wave's planning line is moved onto it, so that its fourth planner and you share one history); for a leaf whose statement is false or cannot be proved as stated (at once, with the configuration: a statement change goes back through me — and say which kind you have, a *statement* that needs a hypothesis it lacks, or a *route* that reads more than the statement needs); **before you take the plan's fallback on the usable place** (a named hypothesis in place of the irreducibility: the gate now lists every such hypothesis, so it is my ruling, with what you tried); or for a question you cannot work around; the report goes to `data/fs131/reports/FS131-I10G.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I10G-implementation.md` (new, on branch `fs131-w10g`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10g` (branch `fs131-w10g`, cut from `main` at `d38c118b`): after the merge, `Proofs/HadwigerNelson/Arith/LevelGraph.lean` and `Proofs/HadwigerNelson/Arith/UsablePlace.lean` — proofs, and new helper declarations under names no other module declares (`./scripts/dupnames.sh` before each push that adds names); **new declarations and docstrings only** in the landed `Proofs/HadwigerNelson/Arith/SpectralInputs.lean`, `Proofs/HadwigerNelson/Arith/StandingFive.lean` and `Proofs/HadwigerNelson/Arith/FloorPlanes.lean` (the two models, and the notes that call them owed), or a new module of your own for the models, with `Proofs.lean` and `ARCHITECTURE.md` for it; `scripts/Axioms.lean` (a block of your own, headed "FS131-I10G", above the `=== PURCHASED ===` banner, and the merge's conflict); `plans/FS131-I10G-implementation.md`, `tools/fs131_i10g_*.py`, `data/fs131/i10g/`, `data/fs131/reports/FS131-I10G.md`; **not** any statement, definition or proof of a landed module, `scripts/Assumptions.lean` (the landing's), `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are proving part of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into kernel-checked
ones. Wave 10 is the arithmetic: the floors on the chromatic numbers of the finite targets a number field's primes supply, and the
measure-theoretic inputs of the chain that carries them to a field's plane. It has landed twice. Its third planner then stated three more
leaves, which are yours, and the second landing named — honestly, in its record — the theorems on `main` whose hypotheses no Lean object
is yet known to satisfy; the cheap ones of those are yours too.

## Why this job

A result counts as held only when its Lean module passes the gate, and the gate's inhabitant rule asks more than truth: for every theorem
whose hypotheses are structures, a Lean object meeting all of them at once. Two landed theorems bound "every usable place of the
standing field" — a family the kernel does not yet know to be non-empty; the leaf `exists_usable_place` is the object that makes them say
something. The level row is the last stated row of the wave. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

What the planner and the landing handed back, and the rulings in force (read each item whole in the inventory,
`plans/FS131-close-inventory.md`):

> 555. **FS131-K10c done at its Stage 17: wave 10's third planning pass — the import whole, two of the four rows stated, the
> — source: plans/FS131-close-inventory.md

> 575. **FS131-L10B done: wave 10's second landing is on `main` through the full gate — the library declares exactly one outside axiom** (landing implementer, Opus; harness 545k and 103 minutes by the task notice; record `plans/FS131-L10B-landing.md`; report `data/fs131/reports/FS131-L10B.md`; gated commit `f0cc3018`, landed `3b2e9848`, a fast-forward).
> — source: plans/FS131-close-inventory.md

> 556. **FS131-I7A, by message mid-job: a defect of the skeleton — four leaves of route T's count are false as stated, because
> — source: plans/FS131-close-inventory.md

> 573. **FS131-L10B, by message mid-job: the gate is green at every step but the guarded lint — one unused instance argument; a word asked and given** (source: L10B's message to "main", 2026-10-06; its gated commit `e80221d3` on `fs131-w10m` — the artifact is read at its hand-back).
> — source: plans/FS131-close-inventory.md

> 596. **FS131-I8C, by message: three corrections to its note of item 593** (source: I8C's message to "main", 2026-10-06; nothing of its third stage is committed yet).
> — source: plans/FS131-close-inventory.md

## The statements

No statement changes in this job. Your three leaves, as they stand on `origin/fs131-w10k` at `e09209e4` (in your tree after the merge; read
each whole, with its docstring):

> theorem StationarySet.prob_mul_card_le_indepNum [CompactSpace Y] [SecondCountableTopology Y] (ν : Measure Y) [SFinite ν]
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10k/Proofs/HadwigerNelson/Arith/LevelGraph.lean

> theorem map_neg_conv_cosetAverage [CompactSpace Y] [SecondCountableTopology Y] (ν : Measure Y) [SFinite ν]
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10k/Proofs/HadwigerNelson/Arith/LevelGraph.lean

> theorem exists_usable_place :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10k/Proofs/HadwigerNelson/Arith/UsablePlace.lean


The landed heads whose open gate items you close (on `main`):

> theorem si4 [Countable V] (𝒜 : MeasurableSpace Ω) [m0 : MeasurableSpace Ω] (μ : Measure Ω) [IsProbabilityMeasure μ]
> — source: Proofs/HadwigerNelson/Arith/SpectralInputs.lean

> theorem spectral_carried_iff (t : TopologicalSpace R)
> — source: Proofs/HadwigerNelson/Arith/SpectralInputs.lean

> theorem contChars_haar_null (hBH : BochnerHerglotz R) (t : TopologicalSpace R) (hmeas : MeasurableSet (contChars t))
> — source: Proofs/HadwigerNelson/Arith/SpectralInputs.lean

> theorem usable_card_ge (w : Ideal (𝓞 standingField)) (hw : w.IsMaximal)
> — source: Proofs/HadwigerNelson/Arith/StandingFive.lean

> theorem no_small_usable (w : Ideal (𝓞 standingField)) (hw : w.IsMaximal)
> — source: Proofs/HadwigerNelson/Arith/StandingFive.lean


What the second landing left open, in its record's words:

> - **`contChars_haar_null`**, **`spectral_carried_iff`**, **`si4`** — no model of all hypotheses at once is a declaration; each
> — source: plans/FS131-L10B-landing.md

> - **`usable_card_ge`, `no_small_usable`** (landed earlier) — still bound a family the kernel does not know non-empty: the usable
> — source: plans/FS131-L10B-landing.md

> - **Not a gate item, a reading**: "every usable plane `Γ_Q` refuses six" is not a kernel sentence. The kernel's floors
> — source: plans/FS131-L10B-landing.md


The plan (the third planner's record, `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10k/plans/FS131-w10-kernel-plan.md`, Stages 14–17: read them whole — § 16.3 has the level row's children, § 16.1 the usable
place's, § 16.2 the models with their notes, § 16.5 its words to you):

> ### 16.3 The plan per leaf, `Arith/LevelGraph.lean` (`debruijn-obligation-modeling`'s question answered by hand: each child is one identity)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10k/plans/FS131-w10-kernel-plan.md

> `StationarySet.prob_mul_card_le_indepNum`. Write `κ = cosetAverage K`, `φ(ω) = ∫ 1_B(T_u ω) dκ(u)` (the share of the origin's
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10k/plans/FS131-w10-kernel-plan.md

> - L-a *for every `c` and every `s` with `ν(π⁻¹ s) > 0`: `∫ φ_c · φ_{c+s} dP = 0`* — the integrand is at most
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10k/plans/FS131-w10-kernel-plan.md

> - L-b `P(B) = ∫ φ dP ≤ P(φ > 0)` (`φ ≤ 1`). 30 lines.
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10k/plans/FS131-w10-kernel-plan.md

> - L-c `P(φ_c > 0) = P(φ > 0)` (measure preservation), so `|Y ⧸ K| · P(φ > 0) = ∫ |I_ω| dP ≤ α`
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10k/plans/FS131-w10-kernel-plan.md

> `map_neg_conv_cosetAverage`: `κ.map Neg.neg = κ` (Haar on a commutative group is negation-invariant —
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10k/plans/FS131-w10-kernel-plan.md

> ### 16.1 A usable place of the standing field — the leaf `exists_usable_place` (`Arith/UsablePlace.lean`)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10k/plans/FS131-w10-kernel-plan.md

> - U1 a maximal `w ∋ 83` (`Ideal.exists_le_maximal` ✓; `83` is no unit of `𝓞 F`), its residue field finite of `83^f`
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10k/plans/FS131-w10-kernel-plan.md

> - U2 **`7 ∣ f`** — *the residue field holds a root `η̄` of `g` and `𝔽₈₃` holds none*. What is hard: "no root in `𝔽₈₃`" gives
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10k/plans/FS131-w10-kernel-plan.md

> - U3 **at least three primes above 83** — *each prime above 83 contains exactly one of `√d ± r_d` for `d ∈ {3, 11, 33}`
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10k/plans/FS131-w10-kernel-plan.md

> - U4 `Σ e·f = 28` (`Ideal.sum_ramification_inertia` ✓, the primed API, as the landed dyadic leaves use it) with three primes
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10k/plans/FS131-w10-kernel-plan.md

> About 450 lines; U2 is the hard child. **If U2's irreducibility does not close in one job, the fallback is a named
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10k/plans/FS131-w10-kernel-plan.md

> | `si4` | "MODEL: a deterministic proper colouring — `μ` a point mass, `c ω = c₀` with `c₀ x ≠ c₀ y` across `adj`: each conditional law is a point mass and `hdisj` holds for every `𝒜`. A model with a non-trivial `𝒜` is J45-SI-C's noisy colouring with `𝒜 = σ(Φ)` (`GapSeven.supp_disjoint` is its `hdisj` on the finite plane), not built." | the point-mass model is about 25 lines; **to state and prove at the landing** (not stated here) |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10k/plans/FS131-w10-kernel-plan.md

> | `spectral_carried_iff` | "MODEL: the discrete topology (`bochnerOn_bot`), the trivial action `T y = id`, and `σ = ‖f‖² • δ₁`, the point mass at the trivial character — then both sides hold. At `τ′_S` the hypothesis `BochnerOn` is Bochner's theorem on `G′_S` with J45-N1 (b), not in the kernel." | `IsSpectralMeasureOf (fun _ => id) _ f (‖f‖² • δ₁)`, about 30 lines; **to state and prove at the landing** |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10k/plans/FS131-w10-kernel-plan.md

> | I-K10c-1 | `Arith/LevelGraph`, `Arith/UsablePlace` | 3 | 280 + 450 = 730 | one (half a job's lines; U2 may hand back) |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10k/plans/FS131-w10-kernel-plan.md

> No statement of this pass may be changed; a change comes back through Keryx. `Arith/WeilKloosterman` and `Arith/PlaceFilter`
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w10k/plans/FS131-w10-kernel-plan.md


## Done means

1. **Your readback, then the merge.** Check the quotations against their sources. Merge `origin/fs131-w10k` (at `e09209e4`) into your
   branch: my trial conflicts in `scripts/Axioms.lean` only — keep both sides' blocks. Build once; `./scripts/dupnames.sh`. Since the
   planner wrote, the second landing made `NumberField standingField` a global instance (ruling 555 (a)), so its § 16.5's `haveI`
   caution no longer binds: use the instance. `#check` your three leaves and read the binders the kernel shows (inventory item 556: a
   section `variable` enters a theorem only if its statement mentions it). Open your record with what you may and may not change.
   Commit, push, and **send me the merge commit's hash**.
2. **The level row** (`LevelGraph`, two leaves, about 280 lines by the planner): `map_neg_conv_cosetAverage`, then L-a, L-b, L-c for
   `StationarySet.prob_mul_card_le_indepNum`. Save after each (a build, the axioms print for it with a control that fires, a statement
   check on elaborated signatures — the milestone's instrument is
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7m/tools/fs131_i7a_stmt_check.py`, on another wave's branch: copy it under a
   name of your own and say so — commit, push). **Before you prove a helper, search the tree for its statement's shape, not for a
   name** (item 596). Re-price after the first leaf and say so.
3. **The usable place** (`UsablePlace`, one leaf, about 450 lines; the prime 83, children U1–U4; U2 is the hard child). The plan's
   fallback for U2 — a named hypothesis on the leaf, never an axiom — is a message to me first, with what you tried: the gate's new
   step lists every hypothesis of that kind, and a leaf proved over one still leaves the two landed bounds without a known object.
   When the leaf is proved, the docstrings of `usable_card_ge` and `no_small_usable` say so, and name it.
4. **The two models** the planner priced at about 55 lines together: the point-mass model for `si4` and the trivial-action model for
   `spectral_carried_iff`, each a Lean declaration meeting every hypothesis of its theorem at once, with the theorem applied to it;
   then each docstring's note, which today says "not a Lean declaration", names the declaration. `contChars_haar_null`'s model needs a
   classical theorem the library assumes by name and is not asked. And `FloorPlanes`' first docstring paragraph, which still reads the
   floor as a statement about "the plane": the kernel's floor is about the norm-one Cayley graph of the field of `Q²` elements, and no
   declaration yet links that graph to the finite plane (the fourth planner states that link as a row) — make the paragraph say what
   the kernel holds. Docstrings and new declarations only: no landed statement, definition or proof moves, and your statement check
   shows it.
5. No statement or definition changed; no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. You do not
   merge another branch beyond item 1's, run the gate, or touch `main`. **After your last green build, the guarded lint** — `lake lint
   --no-build -- --no-build --trace` under the slot with `--mem 8` (`LEAN.md` § The gate), its output saved (inventory item 573).
   Leave no background process running, and keep what your record cites under your `data/` folder.
6. **Your record**, stages headed "Stage n — SAVED (FS131-I10G)", "Theorems this phase proved", each read against its row; a list of the
   open gate items you closed and those you leave, by name; the report in standing rule 11's form, ending with what is left and its
   route. Stopping at a saved stage with part of the work done is a good report — the planner itself expects U2 may hand back.

## What is yours to decide

The route inside each leaf, your helpers, where the two models live, and the order after item 1. The plan is one mind's; its Mathlib
names marked with a tick were checked and the rest it leaves to you. Change a route that does not go and say so. A statement is not
yours to change: one that is false, or true only with a hypothesis the plan did not see, is a message to me, and a finding. Three failed
attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.

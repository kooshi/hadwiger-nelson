# Brief FS131-I8C — wave 8, the semi-hub rows' first module: the open leaves of the second planning pass, on `fs131-w8c`

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I8C
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: one of wave 8's two parallel implementers — prove the open leaves of `Proofs/HadwigerNelson/Plane/RingCalculus/SemiHub.lean` (17 leaves) from the second planner's plan and the shared lemmas a first job has proved, without changing a statement, saving after each leaf or group
  launch: when a slot frees, on a branch cut from the commit at which the wave's join job handed back; the other implementer works on `SemiHubPlaces` and `outerAdj` (FS131-I8D's) in a tree of its own, from the same commit
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf whose statement is false or cannot be proved as stated (at once, with the configuration: a statement change goes back through me — and say which kind you have, a *statement* that needs a hypothesis it lacks, or a *route* that reads more than the statement needs), a shared lemma that does not serve a use the plan names (with the use), a helper you need that the other implementer would need too (so that one of you writes it and the other takes it), or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I8C.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I8C-implementation.md` (new, on branch `fs131-w8c`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8c` (branch `fs131-w8c`, cut from `fs131-w8b` at `6e0cf10d`): `Proofs/HadwigerNelson/Plane/RingCalculus/SemiHub.lean` (17 leaves) — proofs, and new helper declarations under names no other module declares (`./scripts/dupnames.sh` before each push that adds names); a new module of your own beside them if your helpers want one, with `Proofs.lean` and `ARCHITECTURE.md` for it; `scripts/Axioms.lean` (a block of your own, headed "FS131-I8C", above the `=== PURCHASED ===` banner), `plans/FS131-I8C-implementation.md`, `tools/fs131_i8c_*.py`, `data/fs131/i8c/`, `data/fs131/reports/FS131-I8C.md`; **not** any statement, the shared module `StarChart` (it is both jobs': a change to it is a message to me), `SemiHubPlaces` and `outerAdj` (FS131-I8D's), the wave's other modules, any landed module, `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are proving part of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into kernel-checked
ones. Wave 8 is the *ring calculus*: what the unit circle about a vertex of a valid map (its *ring*) carries, in the class with no
Siamese pair (two tiles of one colour nearer than 1). Today its first theorem was proved — no four-colour vertex has a ring free of
boundary arcs — its second planner stated nine more rows about *semi-hubs* in two modules, and a join job proved the lemmas those two
modules share. One of the two modules is yours; a colleague has the other, from the same commit, at the same time.

## Why this job

A result counts as held only when its Lean module passes the gate. These rows are the calculus the frontier's next milestone — the ring
that carries boundary arcs — starts from (`CLAUDE.md` § Paths forward, the first ranked stub). Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

What the planner and the join job handed back, and the rulings in force (read each item whole in the inventory):

> 572. **FS131-K8b done at its Stage 10: wave 8's second planning pass — nine semi-hub rows stated in two new modules with no hypothesis from wave 7; two rows left for a third pass** (planner; harness 609k and 48 minutes by the task notice; record `fs131-w8`'s `plans/FS131-w8-kernel-plan.md` Stages 6–10; report `data/fs131/reports/FS131-K8b.md`; commits `5d4e4d12`, `8d979793`; pushed, tree clean).
> — source: plans/FS131-close-inventory.md

> 571. **FS131-K8b, by message mid-job: the nine semi-hub rows are stated with no hypothesis for FS114-N7-QOPP** (source: K8b's message to "main", 2026-10-06; by its word `Plane/RingCalculus/SemiHub`, 23 `sorry` leaves, elaborating, not yet built or committed — the artifact is read at its hand-back).
> — source: plans/FS131-close-inventory.md

> 568. **FS131-K8b, by message mid-job (its Stage 6 saved at `5d4e4d12`; no Lean of its own yet): three answers from the arguments — `star_anti`'s gap is a defect of the skeleton's hypothesis; `doubleTip`'s extra hypotheses were a route's; FS116-V5-OUT2 is `star_outer_cone`** (source: K8b's message to "main", 2026-10-06).
> — source: plans/FS131-close-inventory.md

> 584. **FS131-I8B, by message mid-job: the shared module is saved — `Plane/RingCalculus/StarChart`, commit `d635a30a` on `origin/fs131-w8b`, no `sorry`; the merge of the first implementer's branch made with no conflict** (source: I8B's message to "main", 2026-10-06 — the full review is at its hand-back).
> — source: plans/FS131-close-inventory.md

> 586. **FS131-I8B done: wave 8's join — the two branches merged, the shared lemmas proved, and `star_anti` proved at its ruled statement** (implementer, Opus; harness 497k and 56 minutes by the task notice; record `fs131-w8b`'s `plans/FS131-I8B-implementation.md`; report `data/fs131/reports/FS131-I8B.md`; commits `bd694259`, the merge `9ddc32d2`, `d635a30a`, `216baaa4`, `6e0cf10d`; pushed, tree clean).
> — source: plans/FS131-close-inventory.md

## The statements

No statement changes in this job. Your leaves, as they stand in your tree (read each whole, with its docstring):

> theorem qcol_inner_tile (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8c/Proofs/HadwigerNelson/Plane/RingCalculus/SemiHub.lean

> theorem GermOnQWith.exists_isRingArc_ccw {p : ℂ} {θ : ℝ} {a a' : Fin k} (h : F.GermOnQWith p θ .ccw a a') :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8c/Proofs/HadwigerNelson/Plane/RingCalculus/SemiHub.lean

> theorem GermOnQWith.exists_isRingArc_cw {p : ℂ} {θ : ℝ} {a a' : Fin k} (h : F.GermOnQWith p θ .cw a a') :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8c/Proofs/HadwigerNelson/Plane/RingCalculus/SemiHub.lean

> theorem qcol_not_one_arc (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hpd : p ∈ F.dom) {ψ : ℝ} (s : Side) {θ₁ θ₂ : ℝ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8c/Proofs/HadwigerNelson/Plane/RingCalculus/SemiHub.lean

> theorem germPair_inner_ne (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hpd : p ∈ F.dom) {ψ : ℝ} (s : Side)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8c/Proofs/HadwigerNelson/Plane/RingCalculus/SemiHub.lean

> theorem germPair_dicho (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hpd : p ∈ F.dom) (hS : F.SimpleOn {p})
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8c/Proofs/HadwigerNelson/Plane/RingCalculus/SemiHub.lean

> theorem ringTile_uMinus (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8c/Proofs/HadwigerNelson/Plane/RingCalculus/SemiHub.lean

> theorem ringTile_vMinus (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8c/Proofs/HadwigerNelson/Plane/RingCalculus/SemiHub.lean

> theorem ringTile_vPlus (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8c/Proofs/HadwigerNelson/Plane/RingCalculus/SemiHub.lean

> theorem ringTile_uPlus (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hp : F.Covers p 1)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8c/Proofs/HadwigerNelson/Plane/RingCalculus/SemiHub.lean

> theorem isRingArc_of_edge {y w : ℂ} (hyd : y ∈ F.dom) {T₁ T₂ : Set ℂ} {c₁ c₂ : Fin k} (hT₁ : F.TileOf c₁ T₁)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8c/Proofs/HadwigerNelson/Plane/RingCalculus/SemiHub.lean

> theorem four_le_of_bothKind (hF : F.Valid) (hN : F.NonSiamese) {w : ℂ} (hw : w ∈ F.dom) (hS : F.SimpleOn {w})
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8c/Proofs/HadwigerNelson/Plane/RingCalculus/SemiHub.lean

> theorem exists_isStar4 (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hpd : p ∈ F.dom) (hS : F.SimpleOn {p})
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8c/Proofs/HadwigerNelson/Plane/RingCalculus/SemiHub.lean

> theorem ringArc_star (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hpd : p ∈ F.dom) (hS : F.SimpleOn {p})
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8c/Proofs/HadwigerNelson/Plane/RingCalculus/SemiHub.lean

> theorem fullSemiHub_star_crossed (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hpd : p ∈ F.dom) (hS : F.SimpleOn {p})
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8c/Proofs/HadwigerNelson/Plane/RingCalculus/SemiHub.lean

> theorem fullSemiHub_star_parallel (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hpd : p ∈ F.dom) (hS : F.SimpleOn {p})
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8c/Proofs/HadwigerNelson/Plane/RingCalculus/SemiHub.lean

> theorem fullSemiHub_star_parallel_T (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} (hpd : p ∈ F.dom) (hS : F.SimpleOn {p})
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8c/Proofs/HadwigerNelson/Plane/RingCalculus/SemiHub.lean

The shared lemmas, proved — cite them, declare none of them again:

> theorem exists_int_of_angleIcc_subset {a b lo hi : ℝ} (hab : a ≤ b) (hlen : hi < lo + 2 * π)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8c/Proofs/HadwigerNelson/Plane/RingCalculus/StarChart.lean

> theorem int_eq_zero_of_two_pi_mul_lt {m : ℤ} (h₁ : -(2 * π) < 2 * π * (m : ℝ)) (h₂ : 2 * π * (m : ℝ) < 2 * π) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8c/Proofs/HadwigerNelson/Plane/RingCalculus/StarChart.lean

> theorem mem_closure_tile_of_near (hF : F.Valid) (hN : F.NonSiamese) {c : Fin k} {R : Set ℂ} (hR : F.TileOf c R)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8c/Proofs/HadwigerNelson/Plane/RingCalculus/StarChart.lean

> theorem IsSectorChart.tileAt_equiv {n : ℕ} {G : BranchGerms n} {x : ℂ} {r₀ : ℝ} (hC : F.IsSectorChart G x r₀)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8c/Proofs/HadwigerNelson/Plane/RingCalculus/StarChart.lean

> theorem exists_sectorChart_tileAt (hF : F.Valid) (hN : F.NonSiamese) {x : ℂ} (hx : x ∈ F.dom) (hS : F.SimpleOn {x})
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8c/Proofs/HadwigerNelson/Plane/RingCalculus/StarChart.lean

> theorem IsSectorChart.exists_initialPiece_between {n : ℕ} {G : BranchGerms n} {x : ℂ} {r₀ : ℝ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8c/Proofs/HadwigerNelson/Plane/RingCalculus/StarChart.lean

> theorem exists_initialPiece_of_ncard_le_three (hF : F.Valid) (hN : F.NonSiamese) {x : ℂ} (hx : x ∈ F.dom)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8c/Proofs/HadwigerNelson/Plane/RingCalculus/StarChart.lean

The plan (the planner's record, `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8c/plans/FS131-w8-kernel-plan.md`, Stages 6–10: read it whole; its § 9.2 has a route per leaf, and its § 9.8 the order: `qcol_inner_tile`, the sub-arc lemmas, `germPair_inner_ne`, `qcol_not_one_arc`, the four `ringTile_*`, then `exists_isStar4`, `ringArc_star`, the three stars, `germPair_dicho`, then `isRingArc_of_edge`, `four_le_of_bothKind`):

> ### 9.1 The statements the proofs derive from
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8c/plans/FS131-w8-kernel-plan.md

> ### 9.2 `Plane/RingCalculus/SemiHub` — seventeen leaves
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8c/plans/FS131-w8-kernel-plan.md

> ### 9.5 Prices
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8c/plans/FS131-w8-kernel-plan.md

> ### 9.6 Inhabitants and vacuity
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8c/plans/FS131-w8-kernel-plan.md

> ### 9.8 The handoff
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8c/plans/FS131-w8-kernel-plan.md

> - **Order inside a file**: `SemiHub` — `qcol_inner_tile`, the sub-arc lemmas, `germPair_inner_ne`, `qcol_not_one_arc`, the four
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8c/plans/FS131-w8-kernel-plan.md

## Done means

1. **Your readback first**: check the quotations against their sources; read the planner's record whole, the join job's record on the
   shared lemmas (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8c/plans/FS131-I8B-implementation.md` — its section for the two
   implementers who start from its tip), your module and those it imports, and each row's derivation entry at the address the record
   gives. `#check` every leaf of yours and read the binders the kernel shows (inventory item 556: a section `variable` enters a
   theorem only if its statement mentions it — a leaf whose kernel statement lacks a hypothesis its row reads is a message to me before
   you prove it). Build the branch once as given. Open your record with what you may and may not change. Commit and push.
2. **The leaves**, in the planner's order; saving after each leaf or group (a build, the axioms print for it with a control that
   fires, a statement check on elaborated signatures against `6e0cf10d` — the wave's tool is
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w8c/tools/fs131_i8a_stmt.py` — commit, push). Re-price after your first two leaves
   and say so: about 1,700 lines by the planner; expect to hand back with part of it and say what is left. This milestone's implementers have come in at a third to two thirds of their planners' line counts on leaves
   whose route exists, and the planner says of its own plans that they are one mind's and were not elaborated.
3. **The planner's own cautions, which are yours to test**: its plans for the shared lemmas' uses were written before those lemmas
   had Lean statements — where a route asks of a shared lemma something its statement does not give, write a corollary under a name of
   your own and say so, or message me if the other implementer needs it too; and no Lean model of a star or of a semi-hub exists, so
   each leaf's docstring keeps the planner's line on what is owed. **One model is owed by the join job and is yours, first** (ruling 586 (b)): a Lean object of the class the shared lemmas speak of — valid, non-Siamese, simple at a point — for `ncard_tileAt_eq`, `exists_sectorChart_tileAt` and `exists_initialPiece_of_ncard_le_three`; its record names the half-disc map at the origin, about 25 lines, as an `example` in a module of yours.
4. No statement or definition changed; no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. You do not
   merge another branch, run the gate, or touch `main`. **After your last green build, the guarded lint** — `lake lint --no-build --
   --no-build --trace` under the slot with `--mem 8` (`LEAN.md` § The gate), its output saved (inventory item 573). Leave no background
   process running, and keep what your record cites under your `data/` folder.
5. **Your record**, stages headed "Stage n — SAVED (FS131-I8C)", "Theorems this phase proved", each read against its row; the report in
   standing rule 11's form, ending with what is left and its route. Stopping at a saved stage with part of the leaves proved is a
   good report.

## What is yours to decide

The route inside each leaf, your helpers, and the order within the plan's dependencies. The plan is one mind's, written today; change
a route that does not go and say so. A statement is not yours to change: one that is false, or true only with a hypothesis the plan
did not see, is a message to me, and a finding. Three failed attempts on one route is a dispatch to the companion your identity names,
never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.

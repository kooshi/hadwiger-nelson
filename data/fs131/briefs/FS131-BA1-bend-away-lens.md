# Brief FS131-BA1 — the outward collar bend, its lens and its composition: lanes G and D of FS131-KA1's plan, on `fs131-w5a`

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-BA1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: implementer 1 of the outward bend — the outward push and its lens (`LensOut`), the bent map (`CollarMapOut`), and the clause package with its composition (`BendAway`): lanes G and D of the planner's handoff, in its order, saving after each group
  launch: now, beside FS131-BA2 (the other half, on `fs131-w5z`) and FS131-IR3 (the vertex step's cases, on `fs131-w5c`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a child whose statement is false or cannot be proved as stated (at once, with the configuration: a statement change goes back through me, never made in place), a statement of the other half's that you need changed, a private helper of the toward bend's modules you cannot reach by a new declaration, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-BA1.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-BA1-implementation.md` (new, on branch `fs131-w5a`; a record of your own — the two halves append to no shared file — which opens by pointing at the planner's)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5a` (branch `fs131-w5a`, at `dd8c2c33`): `Proofs/HadwigerNelson/Plane/ValidMap/LensOut.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/CollarMapOut.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/BendAway.lean`, and one line of `Proofs/HadwigerNelson/Plane/ValidMap/BendStep.lean` (the call of `AwayBend.idle` in `bend_away_subdiv`, for the ruled change below); new helpers as new declarations in your own files (a `private` helper of `BendCollar` or `CollarMap` that a mirror needs is re-proved in the mirror's file or made public by a new declaration there — ruling 421 (c)); `scripts/Axioms.lean` (a block of your own, headed "FS131-BA1", above the `=== PURCHASED ===` banner), `plans/FS131-BA1-implementation.md`, `tools/fs131_ba1_*.py`, `data/fs131/ba1/`, `data/fs131/reports/FS131-BA1.md`; **not** `R2Cap.lean`, `HornChart.lean`, `BendGap.lean` and the rest of `BendStep.lean` (FS131-BA2's, on `fs131-w5z`), `Procedure.lean`, `Terminal.lean`, the toward bend's modules beyond new declarations, `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are building half of the last construction on wave 5's path in the Lean backlog. The milestone, FS-131, turns this project's hand-derived
results into kernel-checked ones. Wave 5's termination procedure bends a bad unit arc off its circle; the bend toward the centre is proved (the collar
bend), and the bend away from it was missing in a form the procedure can read. A planner, FS131-KA1, has just laid it out: the outward bend is the
toward bend on the same collar with a different lens, applied gap by gap between the points where the inner colour's class touches the circle of
radius 2, and composed. `bend_away_part` is proved from 36 children, each a `sorry` with a route and a price. Two implementers take them, split by
file so that neither waits on the other. You are one.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and
`exists_terminalMap` — every valid map of the plane has a terminal valid modification — now waits on this bend more than on anything else: the arc
step's assembly over it is already proved on a sibling branch. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

The plan's hand-back and the rulings in force:

> 445. **FS131-KA1 done: the outward collar bend planned — its statement attacked and found true, `bend_away_part` proved from 36 open children
> — source: plans/FS131-close-inventory.md

> 446. **Rulings on KA1's held items, and its slot.** (a) **Two implementers, split by file as KA1's § 3.6 has it**: FS131-BA1 — `LensOut`,
> — source: plans/FS131-close-inventory.md

> 444. **FS131-IA2, by message at its Stage 6: the interface between the two bends and the arc step is fixed, and it asks less than
> — source: plans/FS131-close-inventory.md

> 442. **FS131-KA1, by message at its Stage 2: no clause of `bend_away_part` is false; one clause changes, the pre-ruled one** (source: KA1's message
> — source: plans/FS131-close-inventory.md

## The statements

No statement changes in this job but the one ruled below. The bend, proved from its children, and the heads of your lanes (read each whole in its file; every child's
docstring states its route):

> theorem bend_away_part (hF : F.Valid) (hP : F.IsPlaneMap) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5a/Proofs/HadwigerNelson/Plane/ValidMap/BendStep.lean

> noncomputable def pushOutHomeo (P : ℂ) (θ₁ θ₂ : ℝ) (a l b : ℝ → ℝ) (hp : PushOutProfiles θ₁ θ₂ a l b) : ℂ ≃ₜ ℂ where
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5a/Proofs/HadwigerNelson/Plane/ValidMap/LensOut.lean

> theorem dist_lt_one_of_thin {P : ℂ} {α₁ α₂ φ₁ φ₂ t₁ t₂ κ : ℝ} (hℓ : α₂ - α₁ ≤ π / 3) (h1 : α₁ < φ₁) (h12 : φ₁ ≤ φ₂)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5a/Proofs/HadwigerNelson/Plane/ValidMap/LensOut.lean

> structure CollarFitOut (F : ArcMap k) (P : ℂ) (θ₁ θ₂ : ℝ) (c c' : Fin k) (ε R' R R'' : ℝ) : Prop where
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5a/Proofs/HadwigerNelson/Plane/ValidMap/CollarMapOut.lean

> theorem CollarFitOut.map_valid (hF : F.Valid) (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') : hfit.map.Valid := by
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5a/Proofs/HadwigerNelson/Plane/ValidMap/CollarMapOut.lean

> structure AwayBend (F M : ArcMap k) (h : ℂ ≃ₜ ℂ) (K : Set ℂ) (P : ℂ) (a b : ℝ) (c : Fin k) (ε : ℝ) : Prop where
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5a/Proofs/HadwigerNelson/Plane/ValidMap/BendAway.lean

> theorem AwayBend.idle (hF : F.Valid) {P : ℂ} {a b : ℝ} {c c' : Fin k} (hA : F.IsRingArc P a b c c')
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5a/Proofs/HadwigerNelson/Plane/ValidMap/BendAway.lean

> theorem LocalStep.of_cutArcs {M : ArcMap k} {K : Set ℂ} {S : Set Arc} {P : ℂ} {θ₁ θ₂ : ℝ} (h12 : θ₁ < θ₂)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5a/Proofs/HadwigerNelson/Plane/ValidMap/BendAway.lean

The plan: the modules, what is reused as it stands, the plan per child, and the handoff that splits the work (read §§ 2–3 whole):

> ### 3.1 The modules (all new but `BendStep`; `Proofs.lean` and `ARCHITECTURE.md` rows in the same commit)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5a/plans/FS131-bendaway-kernel-plan.md

> ### 3.3 The plan per child
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5a/plans/FS131-bendaway-kernel-plan.md

> ### 3.6 The handoff: two implementers, split by file
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5a/plans/FS131-bendaway-kernel-plan.md

## Done means

1. **Your readback first**: check every quotation above against its source; read the planner's record whole and the modules you hold; the toward
   bend's four modules as far as your mirrors name them. Build the branch once as given (expect it up to date: 39 distinct `sorry` warnings). Open
   your record with what you may and may not change. Commit and push.
2. **One ruled statement change, first** (inventory item 446 (b)): `AwayBend.idle` loses `hA` and `hε`, which its proof will not read; change it
   and its one call in `BendStep`'s `bend_away_subdiv`, check by script that nothing else changed, build, commit.
3. **Lane G, then lane D**, in the planner's order (§ 3.6: G1, G2, G4 — independent; G3; G5–G7; then D1–D6), saving after each group (a build,
   the axioms print for the group, the statement check, commit, push). Re-price after G1 and G4 and say so in your record.
4. **`LocalStep.of_cutArcs` (D5) is already proved** — by FS131-IA2, with this exact signature, in
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5y/Proofs/HadwigerNelson/Plane/ValidMap/ArcStep.lean` (l. 584 on; branch `fs131-w5y` at
   `3f8270c0`). Copy that proof into `BendAway` (with any helper it uses, as new declarations there), credit it in the docstring, and do not
   re-derive it. At the final sync the copy in `ArcStep` is deleted.
5. No statement or definition changed anywhere beyond the ruled one (the planner's `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5a/tools/fs131_ka_stmt.py`, with `EDITABLE` extended to your files and the base
   moved to the skeleton's commit, is the check; watch a plant fire); no new `axiom`, no `native_decide`. Do not edit a file while a build of it
   runs. You do not merge another branch into this one, run the gate, or touch `main`. Leave no background process running, and keep what your
   record cites under `data/fs131/ba1/`.
6. **Your record**, stages headed "Stage n — SAVED (FS131-BA1)", "Theorems this phase proved"; the report in standing rule 11's form, ending with what
   is left and its route for a successor. This half is priced at about two sessions: stopping at a saved stage with part of your lanes proved is a
   good report.

## What is yours to decide

The route inside each child, your helpers and where in your files they live, and the order within the planner's dependency constraints. The plan's
routes are one mind's, priced from a table and not from proofs; where a mirror does not go through by flipping an inequality, or a child wants a
lemma in a different form, change the route and say so. A child's **statement** is not yours to change: if one is false or too weak to be used by
its parent, that is a message to me with the configuration, and it is a finding, not a failure. Three failed attempts on one route is a dispatch to
the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.

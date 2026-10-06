# Brief FS131-BA2 — the outward collar bend, its clearance, its charts and its horn count: lanes C and H of FS131-KA1's plan, on `fs131-w5z`

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-BA2
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: implementer 2 of the outward bend — the radius-2 crescent and the subdivision (`R2Cap`), the horn counts (`HornChart`, and the toward bend's open horn child), and the gap's bend with its one piece of new mathematics, the lens's clearance (`BendGap`): lanes C and H of the planner's handoff, in its order, saving after each group
  launch: now, beside FS131-BA1 (the other half, on `fs131-w5a`) and FS131-IR3 (the vertex step's cases, on `fs131-w5c`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a child whose statement is false or cannot be proved as stated (at once, with the configuration: a statement change goes back through me, never made in place), a statement of the other half's that you need changed, a private helper of the toward bend's modules you cannot reach by a new declaration, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-BA2.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-BA2-implementation.md` (new, on branch `fs131-w5z`; a record of your own — the two halves append to no shared file — which opens by pointing at the planner's)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5z` (branch `fs131-w5z`, at `dd8c2c33`): `Proofs/HadwigerNelson/Plane/ValidMap/R2Cap.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/HornChart.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/BendGap.lean`, and in `Proofs/HadwigerNelson/Plane/ValidMap/BendStep.lean` the one child `CollarFit.map_hornCount_le`; new helpers as new declarations in your own files (a `private` helper of `BendCollar` or `CollarMap` that a mirror needs is re-proved in the mirror's file or made public by a new declaration there — ruling 421 (c)); `scripts/Axioms.lean` (a block of your own, headed "FS131-BA2", above the `=== PURCHASED ===` banner), `plans/FS131-BA2-implementation.md`, `tools/fs131_ba2_*.py`, `data/fs131/ba2/`, `data/fs131/reports/FS131-BA2.md`; **not** `LensOut.lean`, `CollarMapOut.lean`, `BendAway.lean` (FS131-BA1's, on `fs131-w5a`; you read their **statements**, which stand in your tree as `sorry`, so you wait for nothing) and the rest of `BendStep.lean`, `Procedure.lean`, `Terminal.lean`, the toward bend's modules beyond new declarations, `main`
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

No statement changes in this job. The bend, proved from its children, and the heads of your lanes (read each whole in its file; every child's
docstring states its route):

> theorem bend_away_part (hF : F.Valid) (hP : F.IsPlaneMap) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5z/Proofs/HadwigerNelson/Plane/ValidMap/BendStep.lean

> theorem exists_r2_crescent_free (F : ArcMap k) {P : ℂ} {θE σ : ℝ} (hE : P + 2 * e θE ∈ F.dom) (hσ : σ = 1 ∨ σ = -1) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5z/Proofs/HadwigerNelson/Plane/ValidMap/R2Cap.lean

> theorem r2_side_dichotomy (hF : F.Valid) {P : ℂ} {θ₁ θ₂ θ₀ σ δ₀ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5z/Proofs/HadwigerNelson/Plane/ValidMap/R2Cap.lean

> theorem exists_lensOut_clear (hF : F.Valid) (hA : F.IsRingArc P θ₁ θ₂ c c') (hin : c ∉ F.coloursAt P)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5z/Proofs/HadwigerNelson/Plane/ValidMap/BendGap.lean

> theorem bend_away_gap (hF : F.Valid) (hA : F.IsRingArc P θ₁ θ₂ c c') (hin : c ∉ F.coloursAt P)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5z/Proofs/HadwigerNelson/Plane/ValidMap/BendGap.lean

> theorem hasHornCount_iff_of_germ_swap {M : ArcMap k} {x : ℂ} {β₀ κ₀ κ₀' r : ℝ} (hx : x ∈ F.dom) (hdom : M.dom = F.dom)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5z/Proofs/HadwigerNelson/Plane/ValidMap/HornChart.lean

> theorem CollarFit.map_hornCount_le (hF : F.Valid) (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {x : ℂ} {j : ℕ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5z/Proofs/HadwigerNelson/Plane/ValidMap/BendStep.lean

The plan: the modules, what is reused as it stands, the plan per child, and the handoff that splits the work (read §§ 2–3 whole, and § 4 for the horn child):

> ### 3.1 The modules (all new but `BendStep`; `Proofs.lean` and `ARCHITECTURE.md` rows in the same commit)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5z/plans/FS131-bendaway-kernel-plan.md

> ### 3.3 The plan per child
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5z/plans/FS131-bendaway-kernel-plan.md

> ### 3.6 The handoff: two implementers, split by file
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5z/plans/FS131-bendaway-kernel-plan.md

## Done means

1. **Your readback first**: check every quotation above against its source; read the planner's record whole and the modules you hold; the toward
   bend's four modules as far as your mirrors name them. Build the branch once as given (expect it up to date: 39 distinct `sorry` warnings). Open
   your record with what you may and may not change. Commit and push.
2. **Lanes H and C**, in the planner's order (§ 3.6: H1, H2, C1 — independent; H3, H4, C2, C3; C4; C5–C9), saving after each group (a build,
   the axioms print for the group, the statement check, commit, push). Re-price after C1 and H3 and say so in your record.
3. **C4, `exists_lensOut_clear`, is the new mathematics**: its hand proof (the plan's § 2.5) is the planner's own derivation over FS131-E5's two
   lemmas, one mind, read by nobody else — you are its first check. If a step of it fails, stop that child, write the configuration, and message
   me at once: a deriver takes it. Do not weaken its statement to get past.
4. **The horn child of the toward bend**, `CollarFit.map_hornCount_le` (the plan's § 4): after lane H. Two proved theorems on the sibling branch
   `fs131-w5y` rest on it alone, and the arc step with them. One lemma there may save you work — W6, `exists_hasHornCount_isHorn_iff` ("the
   horn count exists, and a horn has its tip there iff the count is at least 1"), in
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5y/Proofs/HadwigerNelson/Plane/ValidMap/ArcStep.lean`; it is downstream of your modules,
   so you can read it and not import it: if you need it, restate it identically in `HornChart` with its proof copied and credited, and say so
   (the final sync keeps one).
5. No statement or definition changed anywhere (the planner's `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5z/tools/fs131_ka_stmt.py`, with `EDITABLE` extended to your files and the base
   moved to the skeleton's commit, is the check; watch a plant fire); no new `axiom`, no `native_decide`. Do not edit a file while a build of it
   runs. You do not merge another branch into this one, run the gate, or touch `main`. Leave no background process running, and keep what your
   record cites under `data/fs131/ba2/`.
6. **Your record**, stages headed "Stage n — SAVED (FS131-BA2)", "Theorems this phase proved"; the report in standing rule 11's form, ending with what
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

## Amendment, 2026-10-06 (sent to the job by message the same hour; inventory item 452)

FS131-BA1, on `fs131-w5a`, proved `LensOut` and `CollarMapOut` (built, `66cb0314`) and `BendAway` (a later commit, sent by message when it is
built), and added public helpers the skeleton did not state. **Do not declare these names; merge `origin/fs131-w5a` into `fs131-w5z` and use
them** (ruling 452 (b)) — now at `66cb0314` if a child needs a `CollarFitOut` fact, and again or only at `BendAway`'s commit. Expected conflict:
`scripts/Axioms.lean`, keep both blocks; `BendStep.lean` merges by itself (BA1's hunk is l. 312, yours the horn child). The names, in BA1's words:
in `CollarMapOut`: `CollarFitOut.mem_interiorPts`, `kin_subset`, `kout_subset`, `homeo_eq_self`, `homeo_ringPt`, `homeo_fix_Γ`,
`lensOutCurve_subset`, `ringPt_mem_lensOutCurve`, `not_kept`, `homeo_image_Γ`; in `LensOut`: `PushOutProfiles.cases`, `.toward`, `.a_pos`,
`.push1_zero`, `.push1_pos`, `.push1_push1`, `tangRad_mono`, `tangRad_mul_cos_anti`, `tangentArc_image_out`, `collarOutMid_eq`,
`dist_collarOutMid_left`, `dist_collarOutMid_right`, `outerProf_le_left`, `outerProf_le_right`, `dist_lt_one_of_mem_lensOutSet`,
`two_sin_half_le_of_gap`, `sq_div_two_lt_sin`; in `BendAway`: `ringPt_inj_of_abs_sub_lt`, `AgreesOff.mem_Γ_iff_of_notMem`,
`AgreesOff.mem_region_iff_of_notMem`, `AwayBend.dist_centre`, `AwayBend.closure_region_iff`, `AwayBend.ringPt_notMem`. **Two ruled statement
changes of BA1's reach you with the merge** (the message said "three" by the coordinator's slip): `AwayBend.idle` lost `hA`, `hε` and the implicit
`c'` (item 446 (b)); `dist_lt_one_of_thin` lost `hκ0 : 0 ≤ κ` (item 452 (a)) — drop that argument where a child of yours calls it.

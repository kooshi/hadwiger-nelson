# Brief FS131-I6D — wave 6, the bridge: the fan at an isolated singular point exists — the open leaves of `FanBridge` (its existence half), on `fs131-w6f`

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I6D
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: one of the implementers of wave 6's bridge, split by file — prove the open leaves of `Proofs/HadwigerNelson/Plane/Saturated/FanBridge.lean` — its existence half: `gamma`, `IsUnitCurve.exists_polarGraph`, `beta`, `alpha`, `fan_of_isolated`, `regJLiteral_of_saturated`, `finite_arcs_of_isBounded` (seven leaves) — and the owed model `sq9.SingLocallyFinite` in `Proofs/HadwigerNelson/Plane/Saturated/FanExamples.lean` from the planner's plan and the deriver's argument, without changing a statement, saving after each leaf or group
  launch: when a slot frees, on a branch cut from the commit at which the wave's second planner handed back; other implementers work the wave's other files on branches of their own, and a third planner will add modules downstream
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf whose statement is false or cannot be proved as stated (at once, with the configuration: a statement change goes back through me, and three other jobs read these statements), a step of the deriver's argument that fails or does not formalize (with its address: it goes to a deriver), a definition or lemma of another file you need changed or exported, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I6D.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I6D-implementation.md` (new, on branch `fs131-w6f`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6f` (branch `fs131-w6f`, cut from `fs131-w6` at `32f2ab4c`): `Proofs/HadwigerNelson/Plane/Saturated/FanBridge.lean` — its existence half: `gamma`, `IsUnitCurve.exists_polarGraph`, `beta`, `alpha`, `fan_of_isolated`, `regJLiteral_of_saturated`, `finite_arcs_of_isBounded` (seven leaves) — and the owed model `sq9.SingLocallyFinite` in `Proofs/HadwigerNelson/Plane/Saturated/FanExamples.lean` — proofs, and new helper declarations under names no other module declares (`LEAN.md` § Searching — Lean, last bullet: two branches never state one lemma under one name); a new module of your own beside them if the helpers want one, with `Proofs.lean` and `ARCHITECTURE.md` for it; `scripts/Axioms.lean` (a block of your own, headed "FS131-I6D", above the `=== PURCHASED ===` banner), `plans/FS131-I6D-implementation.md`, `tools/fs131_i6d_*.py`, `data/fs131/i6d/`, `data/fs131/reports/FS131-I6D.md`; **not** `Basic`, `Pinch`, `MapColouring`, `Fan`, the planners' record, the wave's files that are not yours, any landed module beyond new declarations, `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are proving part of the bridge of wave 6 of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones; waves 1–5 are on `main`. Wave 6 is about *saturated* colourings — measurable colourings whose classes are carved by unit
circles about their own points. Every result of the wave about a singular point reads a *fan* there: finitely many curves leaving the point,
each with a direction, one colour between neighbours. This morning a deriver showed that the fan is no extra assumption — in a saturated
colouring it exists at every singular point that is isolated among the singular points — and the wave's second planner stated that argument in
Lean as three modules with `sorry` at the leaves, proving the bridge itself from the fan lemma. The leaves are the mathematics. This part is
yours: the fan at an isolated singular point exists.

## Why this job

A result counts as held only when its Lean module passes the gate. With the bridge in the kernel, every wave-6 result reads, under saturation,
one hypothesis — the singular set is locally finite — which is exactly what the frontier's next milestone asks; until then the wave rests on one
mind's hand argument. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

What the planner and the deriver handed back and the rulings in force (read each item whole in the inventory):

> 501. **FS131-K6b done at its Stage 12: wave 6's second planning pass — the foundation restated (item 495), the fan a library module with
> — source: plans/FS131-close-inventory.md

> 502. **Rulings on K6b's held items, and its slot.** (a) **The deriver's check runs now** (ruling 499): FS131-E8 resumed on a dated
> — source: plans/FS131-close-inventory.md

> 490. **FS131-E8, by message mid-job (its Stage 3 saved, `0310d854` on `main`, pushed): the bridge under REG-J′ is derived — the frozen
> — source: plans/FS131-close-inventory.md

> 499. **FS131-K6b, by message mid-job: findings on the bridge while stating it — none a refutation; the skeleton (`Curve`, `LocalGraph`,
> — source: plans/FS131-close-inventory.md

## The statements

No statement changes in this job. Your leaves, as they stand in your tree (read each whole, with its docstring):

> theorem gamma (h : c.IsolatedAt z R) {y : ℂ} (hy : y ∈ c.essBdry ∩ (ball z R \ {z})) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6f/Proofs/HadwigerNelson/Plane/Saturated/FanBridge.lean

> theorem IsUnitCurve.exists_polarGraph {γ : ℝ → ℂ} {ψ : ℝ → ℝ} {L : ℝ} (h : IsUnitCurve γ ψ (Icc 0 L)) (hL : 0 < L)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6f/Proofs/HadwigerNelson/Plane/Saturated/FanBridge.lean

> theorem beta (h : c.IsolatedAt z R) {y : ℂ} (hy : y ∈ c.essBdry ∩ (ball z R \ {z}))
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6f/Proofs/HadwigerNelson/Plane/Saturated/FanBridge.lean

> theorem alpha (h : c.IsolatedAt z R) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6f/Proofs/HadwigerNelson/Plane/Saturated/FanBridge.lean

> theorem fan_of_isolated (c : AeColouring k) {z : ℂ} {R : ℝ} (hR : 0 < R) (hS : c.singularSet ∩ ball z R ⊆ {z})
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6f/Proofs/HadwigerNelson/Plane/Saturated/FanBridge.lean

> theorem regJLiteral_of_saturated (c : AeColouring k) (hsat : Saturated c.cls) (hS : c.SingLocallyFinite) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6f/Proofs/HadwigerNelson/Plane/Saturated/FanBridge.lean

> theorem finite_arcs_of_isBounded (c : AeColouring k) (hsat : Saturated c.cls) (hS : c.SingLocallyFinite)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6f/Proofs/HadwigerNelson/Plane/Saturated/FanBridge.lean

The plan (the planners' record, `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6f/plans/FS131-w6-kernel-plan.md`: read Stages 9–12 whole —
§ 11.3 reads each statement against the deriver's entry, § 11.4 is the plan and the price per leaf, § 11.5 the planner's findings) and the
argument it formalizes (the deriver's record on `main`, `/home/kooshi/source/lean-dir/plans/FS131-E8-derivation.md`, Stage 3: read §§ 3.1–3.7
whole — it may gain a Stage 6 while you work, a check of the planner's statements):

> ## Stage 11 — SAVED: the bridge's eight rows — the curve notion, the skeleton, the plan and the price (`debruijn-obligation-modeling`, invoked fresh)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6f/plans/FS131-w6-kernel-plan.md

> ### 11.4 The plan per leaf
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6f/plans/FS131-w6-kernel-plan.md

> | `Plane/Saturated/FanBridge` (imports `LocalGraph`, `FanExamples`) | **FS131-E8-GAMMA, -BETA, -ALPHA, -FAN, -BRIDGE, -CLAUSE2**; FS121-V2-SECTOR, FS121-DB1-L3 (with FS111-W-NOREP) | `gamma`, `IsUnitCurve.exists_polarGraph`, `beta`, `alpha`, `fan_of_isolated`, `regJLiteral_of_saturated`, `finite_arcs_of_isBounded`, `Fan.two_le_n`, `Fan.col_ne`, `Fan.branch_outside_discs`, `Fan.branch_contacts`, `Fan.sector_alone` | `sq9_isolatedAt`; **`regJFan_of_saturated`** (BRIDGE, from `fan_of_isolated`), `regJFan_iff_singLocallyFinite`; `Fan.sector_unique` (DB1-L3, from `sector_alone`) |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6f/plans/FS131-w6-kernel-plan.md

> | `gamma` | E8 § 3.2, by its kernel note: no classification of one-manifolds. From a chart at `y`, the family of injective `IsUnitCurve`s through `y` inside the component, ordered by extension; lengths are at most `π/2` (`chord`: a sub-arc of length `π/2` has chord `≥ 1 > 2R`); the union of a chain is a curve (`ψ` extends: 1-Lipschitz); a maximal one is open and closed in the component (charts at its points; at an end inside the punctured disc the chart extends it — § 3.2 (3)) | gluing two charts along an overlap (two `IsUnitCurve`s with the same image near a point agree up to the parameter's shift and sign) | 4 d |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6f/plans/FS131-w6-kernel-plan.md

> | `alpha` | E8 § 3.4 (a)–(e): every component meeting the half disc meets the circle of radius `R/2` (continuity of the distance along `γ`); `essBdry ∩ sphere z (R/2)` compact (`closure_essBdry_subset`, no cusp there); each of its points has a chart lying in one component; finite subcover; the least distance of the finitely many components that miss `z` | (c): a chart's image is connected, so in one component | 1.5 d |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6f/plans/FS131-w6-kernel-plan.md

> | `fan_of_isolated` | E8 § 3.6 with `R' = min R (1/2)`: `alpha`'s `r`; the components with `z` in their closure are finitely many polar graphs (`beta`) pairwise disjoint; lifts ordered within `(φ₀, φ₀ + 2π)` (continuous and never equal mod `2π`); `Fin n` by sorting at one `t`; regions by `ae_one_colour_of_isConnected` (a polar region between two continuous graphs is open and connected) | the ordered lifts; connectedness of `polarRegion` | 3 d |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6f/plans/FS131-w6-kernel-plan.md

> ### 12.1 For implementers: the split by file (statements fixed; children under names of their own)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6f/plans/FS131-w6-kernel-plan.md

> ### 12.2 Vacuity and inhabitants (`LEAN.md` § The gate's form)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6f/plans/FS131-w6-kernel-plan.md


> ## Stage 3 — SAVED: the derivation — the four clauses, the fan, the bridge
> — source: plans/FS131-E8-derivation.md

## Done means

1. **Your readback first**: check the quotations against their sources; read the planners' record (Stages 9–12; the first pass's Stages 3 and
   5 for the foundation), the modules `Basic`, `Pinch`, `Fan`, `Curve`, `LocalGraph`, `FanBridge` as far as your leaves read them, and the
   deriver's Stage 3. Build the branch once as given (31 `sorry` leaves over five files: seven yours). Open your record with what you may and may not change. Commit and push.
2. **The leaves**, in this order — `IsUnitCurve.exists_polarGraph` (no colouring; it re-prices the rest), `gamma`, `beta`, `alpha`, `fan_of_isolated`, then the two corollaries, then the model; saving after each leaf or group (a build, the axioms print for it with a control that fires,
   a statement check against `32f2ab4c`, commit, push). Re-price after your first two leaves and say so: the planner expects its prices for
   the computational leaves to be high by a factor of two to three, and not for the large ones.
3. **The other five leaves of the file are not yours** (`two_le_n`, `col_ne`, `branch_outside_discs`, `branch_contacts`, `sector_alone` in the namespace `AeColouring.Fan`): a deriver is checking their statements now and another implementer takes them — leave their `sorry`s and do not add helpers between them; put your helpers above `gamma` or in a new module of your own, so the two branches merge without touching the same lines. Your leaves use `Curve`'s and `LocalGraph`'s statements, which a third implementer is proving on `fs131-w6c`: they are `sorry` on your branch and your theorems rest on them, which is expected and said in your record. **The model is part of done**: `sq9.SingLocallyFinite` (the vertex analysis of `FanExamples` at every grid vertex; the plan's § 10.3 says what is owed), which with `regJFan_of_saturated` gives `sq9.RegJFan`, the model of every theorem over `RegJFan`; name it in those docstrings. If `gamma` proves large — the plan says it may — stop at a saved stage and say so: every consumer still lands over a `Fan`.
4. No statement or definition changed; no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. You do not merge
   another branch, run the gate, or touch `main`. Leave no background process running, and keep what your record cites under your `data/`
   folder.
5. **Your record**, stages headed "Stage n — SAVED (FS131-I6D)", "Theorems this phase proved", each read against its entry; the report in
   standing rule 11's form, ending with what is left and its route. This is priced at more than one job: stopping at a saved stage with part
   of the leaves proved, and a work list a successor can start cold from, is a good report.

## What is yours to decide

The route inside each leaf, your helpers and where they live, and the order within the plan's dependencies. The plan is one mind's on paper
and the argument under it another's, each written today and neither yet compiled past its statements; change a route that does not go and say
so. A statement is not yours to change: one that is false, or true only with a hypothesis the plan did not see, is a message to me, and a
finding — the planner's mutation audit (its § 11.5, last paragraph) says which hypotheses it believes each statement needs. Three failed
attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.

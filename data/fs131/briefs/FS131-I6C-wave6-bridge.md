# Brief FS131-I6C — wave 6, the bridge: unit-speed curves with 1-Lipschitz tangent, and the local graph of an interface off the cusps — the open leaves of `Curve`, then `LocalGraph`, on `fs131-w6c`

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I6C
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: one of the implementers of wave 6's bridge, split by file — prove the open leaves of `Proofs/HadwigerNelson/Plane/Saturated/Curve.lean` (six leaves) and then `Proofs/HadwigerNelson/Plane/Saturated/LocalGraph.lean` (five leaves, `local_graph` the large one) from the planner's plan and the deriver's argument, without changing a statement, saving after each leaf or group
  launch: when a slot frees, on a branch cut from the commit at which the wave's second planner handed back; other implementers work the wave's other files on branches of their own, and a third planner will add modules downstream
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf whose statement is false or cannot be proved as stated (at once, with the configuration: a statement change goes back through me, and three other jobs read these statements), a step of the deriver's argument that fails or does not formalize (with its address: it goes to a deriver), a definition or lemma of another file you need changed or exported, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I6C.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I6C-implementation.md` (new, on branch `fs131-w6c`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6c` (branch `fs131-w6c`, cut from `fs131-w6` at `32f2ab4c`): `Proofs/HadwigerNelson/Plane/Saturated/Curve.lean` (six leaves) and then `Proofs/HadwigerNelson/Plane/Saturated/LocalGraph.lean` (five leaves, `local_graph` the large one) — proofs, and new helper declarations under names no other module declares (`LEAN.md` § Searching — Lean, last bullet: two branches never state one lemma under one name); a new module of your own beside them if the helpers want one, with `Proofs.lean` and `ARCHITECTURE.md` for it; `scripts/Axioms.lean` (a block of your own, headed "FS131-I6C", above the `=== PURCHASED ===` banner), `plans/FS131-I6C-implementation.md`, `tools/fs131_i6c_*.py`, `data/fs131/i6c/`, `data/fs131/reports/FS131-I6C.md`; **not** `Basic`, `Pinch`, `MapColouring`, `Fan`, the planners' record, the wave's files that are not yours, any landed module beyond new declarations, `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are proving part of the bridge of wave 6 of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones; waves 1–5 are on `main`. Wave 6 is about *saturated* colourings — measurable colourings whose classes are carved by unit
circles about their own points. Every result of the wave about a singular point reads a *fan* there: finitely many curves leaving the point,
each with a direction, one colour between neighbours. This morning a deriver showed that the fan is no extra assumption — in a saturated
colouring it exists at every singular point that is isolated among the singular points — and the wave's second planner stated that argument in
Lean as three modules with `sorry` at the leaves, proving the bridge itself from the fan lemma. The leaves are the mathematics. This part is
yours: unit-speed curves with 1-Lipschitz tangent, and the local graph of an interface off the cusps.

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

> theorem IsUnitCurve.chord {γ : ℝ → ℂ} {ψ : ℝ → ℝ} {ℓ : ℝ} (h : IsUnitCurve γ ψ (Icc 0 ℓ)) (hℓ0 : 0 ≤ ℓ)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6c/Proofs/HadwigerNelson/Plane/Saturated/Curve.lean

> theorem IsUnitCurve.sin_le_inner {γ : ℝ → ℂ} {ψ : ℝ → ℝ} {ℓ : ℝ} (h : IsUnitCurve γ ψ (Icc 0 ℓ))
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6c/Proofs/HadwigerNelson/Plane/Saturated/Curve.lean

> theorem IsUnitCurve.strictMonoOn_dist {γ : ℝ → ℂ} {ψ : ℝ → ℝ} {ℓ : ℝ} (h : IsUnitCurve γ ψ (Icc 0 ℓ))
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6c/Proofs/HadwigerNelson/Plane/Saturated/Curve.lean

> theorem IsUnitCurve.norm_sub_le {γ : ℝ → ℂ} {ψ : ℝ → ℝ} {ℓ : ℝ} (h : IsUnitCurve γ ψ (Icc 0 ℓ)) {s : ℝ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6c/Proofs/HadwigerNelson/Plane/Saturated/Curve.lean

> theorem IsUnitCurve.one_le_dist {γ : ℝ → ℂ} {ψ : ℝ → ℝ} {ℓ : ℝ} (h : IsUnitCurve γ ψ (Icc 0 ℓ))
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6c/Proofs/HadwigerNelson/Plane/Saturated/Curve.lean

> theorem lipschitzOnWith_of_chord {ψ : ℝ → ℝ} {I : Set ℝ} (hI : I.OrdConnected) (hc : ContinuousOn ψ I)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6c/Proofs/HadwigerNelson/Plane/Saturated/Curve.lean

> theorem AeColouring.notMem_essBdry_of_mem_densitySet (c : AeColouring k) {j : Fin k} {x : ℂ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6c/Proofs/HadwigerNelson/Plane/Saturated/LocalGraph.lean

> theorem AeColouring.ae_one_colour_of_isConnected (c : AeColouring k) {W : Set ℂ} (hW : IsOpen W)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6c/Proofs/HadwigerNelson/Plane/Saturated/LocalGraph.lean

> theorem AeColouring.closure_essBdry_subset (c : AeColouring k) : closure c.essBdry ⊆ c.essBdry ∪ cuspSet c.cls := by
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6c/Proofs/HadwigerNelson/Plane/Saturated/LocalGraph.lean

> theorem local_graph {A B N : Set ℂ} (hA : MeasurableSet A) (hAn : UnitPairsNull A) (hB : MeasurableSet B)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6c/Proofs/HadwigerNelson/Plane/Saturated/LocalGraph.lean

> theorem AeColouring.local_graph (c : AeColouring k) {U : Set ℂ} (hU : IsOpen U) (hS : Disjoint U c.singularSet)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6c/Proofs/HadwigerNelson/Plane/Saturated/LocalGraph.lean

The plan (the planners' record, `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6c/plans/FS131-w6-kernel-plan.md`: read Stages 9–12 whole —
§ 11.3 reads each statement against the deriver's entry, § 11.4 is the plan and the price per leaf, § 11.5 the planner's findings) and the
argument it formalizes (the deriver's record on `main`, `/home/kooshi/source/lean-dir/plans/FS131-E8-derivation.md`, Stage 3: read §§ 3.1–3.7
whole, with the dated erratum under its § 3.1; its Stage 6 is the deriver's check of the planner's statements, read-backs included):

> ## Stage 11 — SAVED: the bridge's eight rows — the curve notion, the skeleton, the plan and the price (`debruijn-obligation-modeling`, invoked fresh)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6c/plans/FS131-w6-kernel-plan.md

> ### 11.4 The plan per leaf
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6c/plans/FS131-w6-kernel-plan.md

> | `Plane/Saturated/Curve` (imports `Plane/Chord` only; no measure) | the curve part of FS131-E8-GAMMA, -BETA | `IsUnitCurve.chord` (C1), `.sin_le_inner` (C2), `.strictMonoOn_dist`, `.norm_sub_le`, `.one_le_dist` (the lens), `lipschitzOnWith_of_chord` | `isUnitCurve_segment` (the inhabitant), `IsUnitCurve.mono`, **`norm_sub_le_of_discs`** |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6c/plans/FS131-w6-kernel-plan.md

> | `Plane/Saturated/LocalGraph` (imports `Pinch`, `Curve`) | **FS131-E8-DELTA**; **FS131-E8-LOCAL** = FS111-M-C11 (ii) = FS111-W-NOBEND; FS121-V5-LOC (i), (ii) with V5-OFF | `AeColouring.ae_one_colour_of_isConnected`, `.closure_essBdry_subset`, `.notMem_essBdry_of_mem_densitySet`, `local_graph`, `AeColouring.local_graph` | the structure `IsInterfaceChart` |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6c/plans/FS131-w6-kernel-plan.md

> | `local_graph` | E8 § 3.1 (1)–(4). Children: (a) in `U`: `essBoundary A = essBoundary B = supp A ∩ supp B` (`TwoColourOn.essBoundary_inter_eq`; no cusp) — 3 h; (b) `c11_discs` at every such point, one `N` — given; (c) § 3.1 (3)(b) `|⟨x″ − x′, ν′⟩| ≤ δ²/2` — 2 h; (d) § 3.1 (3)(c), the crude `6δ` (the lens point; control `e8_lens.py`) — 5 h; (e) **sharp**: `norm_sub_le_of_discs`, the midpoint of the centres within `3.5δ` — 3 h; (f) existence on each normal segment (a segment is connected; its ends in the two open sets) — 4 h; (g) uniqueness and `|g u| ≤ u²` — 4 h; (h) the curve: `g` differentiable with `g' = −ν₁/ν₂`, arclength `s(u) = ∫√(1 + g'²)` strictly increasing with a `C¹` inverse, `γ = (u(s), g(u(s)))`, `ψ` a continuous lift of the tangent angle, `lipschitzOnWith_of_chord` with (e) — 2 d; (i) the two sides connected, their colours — 6 h | (h): Mathlib has no arclength reparametrization; **do not** follow § 3.1 (4)'s "where `g″` exists … absolutely continuous" (§ 11.5 (1)) | 5 d |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6c/plans/FS131-w6-kernel-plan.md

> ### 12.1 For implementers: the split by file (statements fixed; children under names of their own)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6c/plans/FS131-w6-kernel-plan.md

> ### 12.2 Vacuity and inhabitants (`LEAN.md` § The gate's form)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6c/plans/FS131-w6-kernel-plan.md


> ## Stage 3 — SAVED: the derivation — the four clauses, the fan, the bridge
> — source: plans/FS131-E8-derivation.md

## Done means

1. **Your readback first**: check the quotations against their sources; read the planners' record (Stages 9–12; the first pass's Stages 3 and
   5 for the foundation), the modules `Basic`, `Pinch`, `Fan`, `Curve`, `LocalGraph`, `FanBridge` as far as your leaves read them, and the
   deriver's Stage 3. Build the branch once as given (31 `sorry` leaves over five files: eleven yours). Open your record with what you may and may not change. Commit and push.
2. **The leaves**, in this order — `Curve`'s six first (they are short and re-price the rest), then `LocalGraph`'s three small leaves, then `local_graph` by its children (a)–(i), then the colouring's form of it; saving after each leaf or group (a build, the axioms print for it with a control that fires,
   a statement check against `32f2ab4c`, commit, push). Re-price after your first two leaves and say so: the planner expects its prices for
   the computational leaves to be high by a factor of two to three, and not for the large ones.
3. **`local_graph` is the wave's first large leaf** (the plan prices it at five days, its child (h) — the curve by arclength — at two): Mathlib has no arclength reparametrization, and the plan says not to follow the hand derivation's regularity step but the kernel-checked `norm_sub_le_of_discs` with `lipschitzOnWith_of_chord`. Two of its children are another implementer's leaves in `Pinch` (`c11_discs`, `TwoColourOn.essBoundary_inter_eq`): use them as stated — they are `sorry` on your branch and your theorems then rest on them, which is expected and said in your record. The unit circle as the sharpness example of `chord` is owed with its proof (the plan's § 12.2), and `local_graph`'s inhabitant note names one owed fact (no cusp in the edge ball of `sq9`): prove it if it is short.
4. No statement or definition changed; no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. You do not merge
   another branch, run the gate, or touch `main`. Leave no background process running, and keep what your record cites under your `data/`
   folder.
5. **Your record**, stages headed "Stage n — SAVED (FS131-I6C)", "Theorems this phase proved", each read against its entry; the report in
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

## Amendment 1 (2026-10-06, at launch) — what changed since this brief was written

Nothing above is withdrawn; one small addition to your report.

1. **The wave's third planner has handed back** (inventory item 531). It added four modules downstream of yours on `fs131-w6`, at commits
   after the one your branch is cut from; none of your files changed. Its new leaves read two of your statements as they stand —
   `AeColouring.local_graph` and `closure_essBdry_subset` — so a statement of yours that turns out false or needs a hypothesis is, as
   before, a message to me at once.
2. **One line asked of your report**: where your proof of `local_graph` reads that the two classes are disjoint (`TwoColourOn.disj`), by
   step. The third planner expects it is read at one step only (the lens step); a later planning pass wants to restate the lemma for two
   sets that may overlap, and your proof is the first place anyone will know. If the answer is "nowhere", that is a generalization: say so.
3. **A lesson from today, for your mid-job messages** (inventory item 526): when you report a defect, say which kind it is — a
   *statement* that needs a hypothesis it lacks, or a *route* that reads more than the statement needs (a shorter-route note, no defect).

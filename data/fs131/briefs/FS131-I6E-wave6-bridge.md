# Brief FS131-I6E — wave 6, the bridge: what every fan carries — two sides of two colours, branches outside the tangent unit discs, the contacts at a branch, one sector per colour — the open leaves of `FanBridge` (its five `Fan` lemmas), on `fs131-w6g`

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I6E
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: one of the implementers of wave 6's bridge, split by file — prove the open leaves of `Proofs/HadwigerNelson/Plane/Saturated/FanBridge.lean` — its five lemmas about any fan, in the namespace `AeColouring.Fan`: `two_le_n`, `col_ne`, `branch_outside_discs`, `branch_contacts`, `sector_alone` (five leaves; `sector_unique` is already proved from the last) from the planner's plan and the deriver's argument, without changing a statement, saving after each leaf or group
  launch: when a slot frees, on a branch cut from the commit at which the wave's second planner handed back; other implementers work the wave's other files on branches of their own, and a third planner will add modules downstream
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf whose statement is false or cannot be proved as stated (at once, with the configuration: a statement change goes back through me, and three other jobs read these statements), a step of the deriver's argument that fails or does not formalize (with its address: it goes to a deriver), a definition or lemma of another file you need changed or exported, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I6E.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I6E-implementation.md` (new, on branch `fs131-w6g`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6g` (branch `fs131-w6g`, cut from `fs131-w6` at `32f2ab4c`): `Proofs/HadwigerNelson/Plane/Saturated/FanBridge.lean` — its five lemmas about any fan, in the namespace `AeColouring.Fan`: `two_le_n`, `col_ne`, `branch_outside_discs`, `branch_contacts`, `sector_alone` (five leaves; `sector_unique` is already proved from the last) — proofs, and new helper declarations under names no other module declares (`LEAN.md` § Searching — Lean, last bullet: two branches never state one lemma under one name); a new module of your own beside them if the helpers want one, with `Proofs.lean` and `ARCHITECTURE.md` for it; `scripts/Axioms.lean` (a block of your own, headed "FS131-I6E", above the `=== PURCHASED ===` banner), `plans/FS131-I6E-implementation.md`, `tools/fs131_i6e_*.py`, `data/fs131/i6e/`, `data/fs131/reports/FS131-I6E.md`; **not** `Basic`, `Pinch`, `MapColouring`, `Fan`, the planners' record, the wave's files that are not yours, any landed module beyond new declarations, `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are proving part of the bridge of wave 6 of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones; waves 1–5 are on `main`. Wave 6 is about *saturated* colourings — measurable colourings whose classes are carved by unit
circles about their own points. Every result of the wave about a singular point reads a *fan* there: finitely many curves leaving the point,
each with a direction, one colour between neighbours. This morning a deriver showed that the fan is no extra assumption — in a saturated
colouring it exists at every singular point that is isolated among the singular points — and the wave's second planner stated that argument in
Lean as three modules with `sorry` at the leaves, proving the bridge itself from the fan lemma. The leaves are the mathematics. This part is
yours: what every fan carries — two sides of two colours, branches outside the tangent unit discs, the contacts at a branch, one sector per colour.

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

> 504. **FS131-E8's check done (its Stage 6): the planner's statements of the bridge stand — `Fan.branch_contacts`, `Fan.two_le_n` and
> — source: plans/FS131-close-inventory.md

> 505. **Rulings on the check, and the slot.** (a) **The five `Fan` lemmas go to an implementer as stated** (FS131-I6E), whose brief
> — source: plans/FS131-close-inventory.md

## The statements

No statement changes in this job. Your leaves, as they stand in your tree (read each whole, with its docstring):

> theorem two_le_n (hz : z ∈ c.singularSet) : 2 ≤ F.n := by
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6g/Proofs/HadwigerNelson/Plane/Saturated/FanBridge.lean

> theorem col_ne {i j : Fin F.n} (hij : (j : ℕ) + 1 = i ∨ ((i : ℕ) = 0 ∧ (j : ℕ) + 1 = F.n)) : F.col j ≠ F.col i := by
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6g/Proofs/HadwigerNelson/Plane/Saturated/FanBridge.lean

> theorem branch_outside_discs (hsat : SaturatedOn c.cls (ball z F.r \ {z})) (i : Fin F.n) {t : ℝ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6g/Proofs/HadwigerNelson/Plane/Saturated/FanBridge.lean

> theorem branch_contacts (hsat : SaturatedOn c.cls (ball z F.r \ {z})) {i j : Fin F.n}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6g/Proofs/HadwigerNelson/Plane/Saturated/FanBridge.lean

> theorem sector_alone (hsat : SaturatedOn c.cls (ball z F.r \ {z})) {i i' : Fin F.n} (hi : F.dir i < F.nextDir i)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6g/Proofs/HadwigerNelson/Plane/Saturated/FanBridge.lean

The plan (the planners' record, `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6g/plans/FS131-w6-kernel-plan.md`: read Stages 9–12 whole —
§ 11.3 reads each statement against the deriver's entry, § 11.4 is the plan and the price per leaf, § 11.5 the planner's findings) and the
argument it formalizes (the deriver's record on `main`, `/home/kooshi/source/lean-dir/plans/FS131-E8-derivation.md`, Stage 3: read §§ 3.1–3.7
whole, with the dated erratum under its § 3.1; its Stage 6 is the deriver's check of the planner's statements, read-backs included):

> ## Stage 11 — SAVED: the bridge's eight rows — the curve notion, the skeleton, the plan and the price (`debruijn-obligation-modeling`, invoked fresh)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6g/plans/FS131-w6-kernel-plan.md

> ### 11.4 The plan per leaf
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6g/plans/FS131-w6-kernel-plan.md

> | `Plane/Saturated/FanBridge` (imports `LocalGraph`, `FanExamples`) | **FS131-E8-GAMMA, -BETA, -ALPHA, -FAN, -BRIDGE, -CLAUSE2**; FS121-V2-SECTOR, FS121-DB1-L3 (with FS111-W-NOREP) | `gamma`, `IsUnitCurve.exists_polarGraph`, `beta`, `alpha`, `fan_of_isolated`, `regJLiteral_of_saturated`, `finite_arcs_of_isBounded`, `Fan.two_le_n`, `Fan.col_ne`, `Fan.branch_outside_discs`, `Fan.branch_contacts`, `Fan.sector_alone` | `sq9_isolatedAt`; **`regJFan_of_saturated`** (BRIDGE, from `fan_of_isolated`), `regJFan_iff_singLocallyFinite`; `Fan.sector_unique` (DB1-L3, from `sector_alone`) |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6g/plans/FS131-w6-kernel-plan.md

> | `Fan.two_le_n`, `Fan.col_ne` | § 11.5 (3): a continuous polar graph is null (the image of a graph in `(t, θ)` under the polar map, locally Lipschitz); near a branch point every point is on the branch or in one of the two neighbouring cells; so equal colours make it a density point, against `F.bdry` and `notMem_essBdry_of_mem_densitySet`; `n = 0`: `ae_one_colour_of_isConnected` on the punctured disc | the null graph (`MeasureTheory.addHaar_image_eq_zero_of_differentiableOn_of_addHaar_eq_zero` for the polar map) | 1 d each |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6g/plans/FS131-w6-kernel-plan.md

> | `Fan.branch_outside_discs` | a branch is a component with `z` in its closure (§ 10.2 (2)); `gamma`'s curve from `z`; `one_le_dist`; `F.dir i ≡ ψ 0` mod `2π` (`exists_polarGraph`'s limit and `F.tendsto`) | identifying the fan's `φ i` with the curve's polar angle | 1 d |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6g/plans/FS131-w6-kernel-plan.md

> | `Fan.branch_contacts` | at branch points `pinch_interface`'s two types; a split point makes the whole branch a unit arc (§ 11.5 (4)); else all tangent, the normals `i e(ψ s)` converge (`IsUnitCurve` on the closed interval), contacts `x ± ν(x)` converge, supports are closed | the propagation of the split type | 1.5 d |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6g/plans/FS131-w6-kernel-plan.md

> | `Fan.sector_alone` | `plans/FS121-V2-verification.md` §§ 2.2–2.3 verbatim: Lemma C is `half_dichotomy`; Lemma H from it on two cells of one colour (a cell is preconnected, in the density set: `subset_densitySet_of_isOpen_ae_subset`); the directions `D(W)` of a cell of positive angle are the open arc `(dir i, nextDir i)` (`F.tendsto`); the angular lemma; the zero-angle case by `branch_contacts`' three cases and `branch_outside_discs` | `D(W)` for a cell from the fan's fields; the angular case analysis (V2's control `fs121-v2-sectors` is a half-degree grid) | 2.5 d |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6g/plans/FS131-w6-kernel-plan.md

> ### 10.2 The two facts the design's `Fan` has no field for: lemmas about any fan, not fields (ruling 492 (b))
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6g/plans/FS131-w6-kernel-plan.md

> ### 12.1 For implementers: the split by file (statements fixed; children under names of their own)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6g/plans/FS131-w6-kernel-plan.md

> ### 12.2 Vacuity and inhabitants (`LEAN.md` § The gate's form)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6g/plans/FS131-w6-kernel-plan.md


> ## Stage 3 — SAVED: the derivation — the four clauses, the fan, the bridge
> — source: plans/FS131-E8-derivation.md

## Done means

1. **Your readback first**: check the quotations against their sources; read the planners' record (Stages 9–12; the first pass's Stages 3 and
   5 for the foundation), the modules `Basic`, `Pinch`, `Fan`, `Curve`, `LocalGraph`, `FanBridge` as far as your leaves read them, and the
   deriver's Stage 3. Build the branch once as given (31 `sorry` leaves over five files: five yours). Open your record with what you may and may not change. Commit and push.
2. **The leaves**, in this order — `two_le_n` and `col_ne` (no saturation; they re-price the rest), `branch_outside_discs`, `branch_contacts`, then `sector_alone` — the row FS121-V2-SECTOR, whose argument is `plans/FS121-V2-verification.md` §§ 2.2–2.3; saving after each leaf or group (a build, the axioms print for it with a control that fires,
   a statement check against `32f2ab4c`, commit, push). Re-price after your first two leaves and say so: the planner expects its prices for
   the computational leaves to be high by a factor of two to three, and not for the large ones.
3. **A deriver checked these five statements today, and its check is your second plan** (the deriver's record, Stage 6, §§ 6.1–6.3 and 6.5; inventory items 504–505, quoted above). Three things it found bind you: (i) `branch_contacts`' alternative is **inclusive** — a unit arc with a further contact at the antipode is of both types — so no proof may case-split on it as exclusive, and you amend that theorem's docstring to say so (a docstring line is not a statement change; your statement check says which lines it allows); (ii) the branch's tangent at `z` does not come from `beta` alone: go through `gamma` and `IsUnitCurve.exists_polarGraph`; (iii) `branch_contacts`' first alternative needs no bound `1/2` and no saturation beyond the one common contact. **The other seven leaves of the file are not yours** (`gamma`, `IsUnitCurve.exists_polarGraph`, `beta`, `alpha`, `fan_of_isolated`, `regJLiteral_of_saturated`, `finite_arcs_of_isBounded`): another implementer takes them on `fs131-w6f` — use them as stated (they are `sorry` on your branch and your theorems rest on them, expected and said in your record), leave their `sorry`s, and put your helpers directly above `namespace Fan` or between your own leaves, never above `gamma`, so the two branches merge without touching the same lines. Each of the five names its Lean model in its docstring (`sq9Fan`; the plan's § 12.2 says with which facts).
4. No statement or definition changed; no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. You do not merge
   another branch, run the gate, or touch `main`. Leave no background process running, and keep what your record cites under your `data/`
   folder.
5. **Your record**, stages headed "Stage n — SAVED (FS131-I6E)", "Theorems this phase proved", each read against its entry; the report in
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

# Brief FS131-I6L — wave 6, the pinch on a cover and the unit parallels — the ladder's base: open leaves of the third planning pass, on `fs131-w6l`

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I6L
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: one of three implementers of wave 6's third planning pass, split by file — prove the open leaves of `Proofs/HadwigerNelson/Plane/Saturated/CoverHull.lean` (four leaves) and then `Proofs/HadwigerNelson/Plane/Saturated/Parallel.lean` (thirteen leaves) from the planner's plan and the arguments it names, without changing a statement, saving after each leaf or group
  launch: when a slot frees, on a branch cut from the commit at which the wave's third planner handed back, beside the wave's other implementers on branches of their own
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf whose statement is false or cannot be proved as stated (at once, with the configuration: a statement change goes back through me, and other branches read these statements), a step of a hand argument that fails or does not formalize (with its address: it goes to a deriver), or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I6L.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I6L-implementation.md` (new, on branch `fs131-w6l`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l` (branch `fs131-w6l`, cut from `fs131-w6` at `6fc27fa1`): `Proofs/HadwigerNelson/Plane/Saturated/CoverHull.lean` (four leaves) and then `Proofs/HadwigerNelson/Plane/Saturated/Parallel.lean` (thirteen leaves) — proofs, and new helper declarations under names no other module declares (`LEAN.md` § Searching — Lean, last bullet: two branches never state one lemma under one name; run `./scripts/dupnames.sh` before each push that adds names); a new module of your own beside them if the helpers want one, with `Proofs.lean` and `ARCHITECTURE.md` for it; `scripts/Axioms.lean` (lines of your own in the block headed "FS131-K6c", or a block headed "FS131-I6L", above the `=== PURCHASED ===` banner), `plans/FS131-I6L-implementation.md`, `tools/fs131_i6l_*.py`, `data/fs131/i6l/`, `data/fs131/reports/FS131-I6L.md`; **not** the wave's other modules (other implementers', each on its own branch — a `sorry` you see there is theirs, and you use its statement), any statement, the planners' record, any landed module beyond new declarations, `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are proving part of wave 6 of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones; waves 1–5 are on `main`. Wave 6 is thirty-five rows about *saturated* colourings — classes carved by unit circles
about their own points — the regularity half of this project's route to the answer. Three planning passes have stated twenty-nine of
them; the third stated seventeen in four new files, each read from its argument, and reported nine generalizations on the way. This part is yours: the pinch on a cover and the unit parallels — the ladder's base.

## Why this job

A result counts as held only when its Lean module passes the gate. These rows are the ladder of unit parallels and what follows from it —
integer radii, sectors at the singular set, what cannot accumulate — which the frontier's next milestones cite most (`LEDGER.md` rows
139–148; `CLAUDE.md` § Where the problem stands, item 31). Until their leaves are proved they are hand results of one or two minds. Kooshi,
on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

What the planner handed back and the rulings in force (read each item whole in the inventory):

> 531. **FS131-K6c done at its Stage 15: wave 6's third planning pass — seventeen of the twenty-three rows left, and one clause of
> — source: plans/FS131-close-inventory.md

> 526. **FS131-K6c retracts item 522 (2): FS121-DB1-L7 stands as filed — "at every point off Σ", no REG-J′, no neighbourhood; the
> — source: plans/FS131-close-inventory.md

> 530. **FS131-I6B done: `sat_inP` proved (FS121-C1-SAT), at a wider class than filed, with its Lean model — the nine-colour grid as
> — source: plans/FS131-close-inventory.md

> 516. **FS131-I6A done: all seven leaves of wave 6's `Pinch` proved as stated — the pinch, its impossible case, the two tangent
> — source: plans/FS131-close-inventory.md

## The statements

No statement changes in this job. Your leaves, as they stand in your tree (read each whole, with its docstring):

> theorem pinch_of_cover {A B N : Set ℂ} (hA : MeasurableSet A) (hAn : UnitPairsNull A) (hB : MeasurableSet B)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/Proofs/HadwigerNelson/Plane/Saturated/CoverHull.lean

> theorem IsRegularMUA.exterior_ball {A : Set ℂ} (hA : IsRegularMUA A) {z x : ℂ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/Proofs/HadwigerNelson/Plane/Saturated/CoverHull.lean

> theorem IsRegularMUA.frontier_subset_infDist {A : Set ℂ} (hA : IsRegularMUA A) (z : ℂ) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/Proofs/HadwigerNelson/Plane/Saturated/CoverHull.lean

> theorem IsRegularMUA.frontier_subset_onLevel {A : Set ℂ} (hA : IsRegularMUA A) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/Proofs/HadwigerNelson/Plane/Saturated/CoverHull.lean

> theorem twoColourNhd_ball_of_open (c : AeColouring k) {N : Set ℂ} {a b : Fin k} (hN : TwoColourNhd c.cls N a b)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/Proofs/HadwigerNelson/Plane/Saturated/Parallel.lean

> theorem partner_point (c : AeColouring k) {U : Set ℂ} (hsat : SaturatedOn c.cls U) {a : Fin k} {x y : ℂ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/Proofs/HadwigerNelson/Plane/Saturated/Parallel.lean

> theorem tangent_parallel_out (c : AeColouring k) {w : ℂ} {n : ℝ} (hn : 0 < n) {α β : ℝ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/Proofs/HadwigerNelson/Plane/Saturated/Parallel.lean

> theorem tangent_parallel_in (c : AeColouring k) {w : ℂ} {n : ℝ} (hn : 1 < n) {α β : ℝ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/Proofs/HadwigerNelson/Plane/Saturated/Parallel.lean

> theorem tangent_parallel_line (c : AeColouring k) {p : ℂ} {φ s₁ s₂ : ℝ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/Proofs/HadwigerNelson/Plane/Saturated/Parallel.lean

> theorem finite_bad_directions (c : AeColouring k) (hS : c.SingLocallyFinite) (w : ℂ) {r₁ r₂ : ℝ} (hr : 0 < r₁)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/Proofs/HadwigerNelson/Plane/Saturated/Parallel.lean

> theorem out_family (c : AeColouring k) (hsat : Saturated c.cls) (hS : c.SingLocallyFinite) {w : ℂ} {n : ℝ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/Proofs/HadwigerNelson/Plane/Saturated/Parallel.lean

> theorem chain_in (c : AeColouring k) (hsat : Saturated c.cls) (hS : c.SingLocallyFinite) {w : ℂ} {n : ℕ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/Proofs/HadwigerNelson/Plane/Saturated/Parallel.lean

> theorem radius_integer (c : AeColouring k) (hsat : Saturated c.cls) (hS : c.SingLocallyFinite) {w : ℂ} {r : ℝ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/Proofs/HadwigerNelson/Plane/Saturated/Parallel.lean

> theorem curvature_integer_ae (c : AeColouring k) (hsat : Saturated c.cls) (hS : c.SingLocallyFinite) {a b : Fin k}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/Proofs/HadwigerNelson/Plane/Saturated/Parallel.lean

> theorem finite_pieces_of_radius (c : AeColouring k) (hsat : Saturated c.cls) (hS : c.SingLocallyFinite)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/Proofs/HadwigerNelson/Plane/Saturated/Parallel.lean

> theorem arc_interior (c : AeColouring k) {U : Set ℂ} (hU : IsOpen U) (hSU : Disjoint U c.singularSet)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/Proofs/HadwigerNelson/Plane/Saturated/Parallel.lean

> theorem segment_interior (c : AeColouring k) {U : Set ℂ} (hU : IsOpen U) (hSU : Disjoint U c.singularSet)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/Proofs/HadwigerNelson/Plane/Saturated/Parallel.lean

The plan (the planners' record, `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/plans/FS131-w6-kernel-plan.md`: read Stages 13–15
whole, and of the earlier stages what your files import; the rows for your leaves give a route, its children, what is hard, and a price on
the planners' scale):

> ### 15.1 For implementers: the split by file (statements fixed; children under names of their own)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/plans/FS131-w6-kernel-plan.md

> | H | `Plane/Saturated/CoverHull` | 4 | `pinch`'s proof (on `fs131-w6p`), `bound_iff` | § 14.5 |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/plans/FS131-w6-kernel-plan.md

> | L | `Plane/Saturated/Parallel` | 13 | `pinch`, `c11_split`, `AeColouring.local_graph`, `closure_essBdry_subset` | § 14.5 |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/plans/FS131-w6-kernel-plan.md

> - **Order within L**: `partner_point`, the three parallels, `finite_bad_directions`, `arc_interior`/`segment_interior`, then
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/plans/FS131-w6-kernel-plan.md

> - **Two branches never state one lemma under one name** (`LEAN.md` § Searching — Lean): the three cell lemmas of a fan (a cell is
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/plans/FS131-w6-kernel-plan.md

> ### 14.5 The plan per leaf (34 leaves; statements fixed; children under names of the implementer's own)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/plans/FS131-w6-kernel-plan.md

> The obligation-modeling pass's decisions: **(a)** the pointwise statement the parallels derive from is `partner_point` — `pinch` at the
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/plans/FS131-w6-kernel-plan.md

> | `pinch_of_cover` | FS131-I6A's proof of `pinch` with (H2) read weakly and every use of `disj` replaced as in § 14.2 item 1; at the join `pinch` becomes its one-line case | none | 3 h |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/plans/FS131-w6-kernel-plan.md

> | `IsRegularMUA.exterior_ball` | a component of the open `int F` is open, so its frontier misses `int F`; the shadow identity gives a contact `y ∈ F`; `component_side`: outside → `p = y`, inside → `p = 2x − y` | none | 2 h |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/plans/FS131-w6-kernel-plan.md

> | `.frontier_subset_infDist` | `≤ 1` from `exterior_ball`; `≥ 1`: every centre's disc misses `U` and `x ∈ closure U` | the infimum over a non-empty set | 1.5 h |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/plans/FS131-w6-kernel-plan.md

> | `.frontier_subset_onLevel` | `bound_iff` at `S = interior F`: `closure (interior F) = F` (`|F ∖ int F| = 0` and `F = supp A`), `UnitPairsNull (interior F)`, `frontier F ⊆ unitShadow F` (shadow identity) | `closure (interior F) = F` | 3 h |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/plans/FS131-w6-kernel-plan.md

> | `twoColourNhd_ball_of_open` | `local_graph`'s chart at `y`; for small `ρ` each side of the curve in `B(y, ρ)` is star-shaped about `y ± (ρ/2)ν` (`IsUnitCurve.norm_sub_le`), so connected; (H1) restricts | the two sides of a ball cut by a `C^{1,1}` arc | 1 d |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/plans/FS131-w6-kernel-plan.md

> | `partner_point` | § 14.2 item 2, steps (1)–(3): `dist_ne_one_of_mem_densitySet`; no cusp off `Σ`; `exists_twoColourNhd_of_mem_interfaceSet` with `a` one of the two colours (the others are null near `y`); `TwoColourNhd.mem_essBoundary` and saturation for the other colour's contact; `pinch` | bookkeeping of which colour is which | 3 h |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/plans/FS131-w6-kernel-plan.md

> | `tangent_parallel_out`, `_in`, `_line` | `partner_point` with `x ∈ essClosure` from the `a`-side disc (child: a tangent-type point has upper density `≥ 1/4` of each colour; model `upperDensityAt_pos_of_balls`); step (4): neighbours in `supp S_a`, not density points, strictly outside `closedBall x 1`; split with `a` inside puts them off `supp`, with `a` outside makes them density points (`subset_densitySet_of_isOpen_ae_subset`); child: the colours at neighbouring arc points are those at `θ` (two-colour balls overlap) | the neighbours' colours | 5 h, 2 h, 2 h |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/plans/FS131-w6-kernel-plan.md

> | `finite_bad_directions` | `Σ ∩ closedBall w r₂` finite (compact, locally finite); each of its points other than `w` has finitely many `θ ∈ [α, β]` | the finitely many `θ` of one direction | 3 h |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/plans/FS131-w6-kernel-plan.md

> | `out_family` | induction on `m`; step: `SingLocallyFinite.isClosed` gives a sub-window off `Σ` at the next radius, `tangent_parallel_out` at each of its directions; the circle clause by `arc_interior` at `U = Σᶜ` | none after the statement | 4 h |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/plans/FS131-w6-kernel-plan.md

> | `chain_in` | downward induction on `j` with a sub-window of essential boundary points off `Σ` as hypothesis: `arc_interior` (tangent for `j ≥ 2`), `tangent_parallel_in`; at `j = 1`: tangent type with normal `e θ` gives the contact `w` and `IsUnitArcPt` (`n = 1`: `pinch_interface`, split about `w` or tangent) | `IsUnitArcPt`'s outer half from the local structure | 1 d |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/plans/FS131-w6-kernel-plan.md

> | `radius_integer` | `⌊r⌋` steps of `tangent_parallel_in` at a good direction; a non-integer `r` leaves an interface arc of radius in `(0, 1)`, against `c11_discs` (a child: no interface arc of radius below 1) | the last step | 1 d |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/plans/FS131-w6-kernel-plan.md

> | `curvature_integer_ae` | `LipschitzOnWith.ae_differentiableWithinAt_of_mem_real` for `ψ`; then the derivation's step (2) at almost every point | **step (2) is two lines in the derivation and is not a kernel route yet**: the parallel of a general `C^{1,1}` chart at a.e. point; if the implementer stalls, a question for the deriver | 4 d |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/plans/FS131-w6-kernel-plan.md

> | `finite_pieces_of_radius` | the derivation's step (3): `f(s) = |γ s − p|² − n²` convex off the smaller radii, by induction on `n` | **one mind** (VM2-FIN′); terminal centres finitely many | 3 d |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/plans/FS131-w6-kernel-plan.md

> | `arc_interior`, `segment_interior` | `closure_essBdry_subset` (no cusp in `U`) puts the arc's points of `U` in `c.essBdry`; `AeColouring.local_graph`'s chart; a connected subset of an injective curve through an interior parameter contains a neighbourhood of it (monotone preimage); tangent for `r ≠ 1` by `pinch_interface` and `c11_split` | the one-dimensional invariance of domain | 1.5 d, 0.5 d |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/plans/FS131-w6-kernel-plan.md

> **The price**: `CoverHull` 1.2 d, `Parallel` 16 d, `Centre` 13 d, `Accumulation` 19 d — **about 49 agent-days on the two passes'
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/plans/FS131-w6-kernel-plan.md

> ### 14.6 Vacuity and inhabitants (`LEAN.md` § The gate's form)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/plans/FS131-w6-kernel-plan.md

## Done means

1. **Your readback first**: check the quotations against their sources; read the record's Stages 13–15, your files and the modules they
   import, and for each leaf the argument the plan's row names. Build the branch once as given (65 `sorry` leaves on the branch: seventeen yours (four in `CoverHull`, thirteen in `Parallel`)). Open your record with what
   you may and may not change. Commit and push.
2. **The leaves**, in this order — `CoverHull`'s four first (set algebra over held lemmas: they re-price the rest), then `Parallel` in the planner's order, quoted above — `curvature_integer_ae` and `finite_pieces_of_radius` last; saving after each leaf or group (a build, the axioms print for it with a control that
   fires, a statement check against `6fc27fa1`, commit, push). Re-price after your first two leaves and say so: the planner's prices are on
   a scale this wave's first two implementers beat by an order of magnitude on set-algebra leaves, and not on the hard ones.
3. **`pinch_of_cover` is a proof you adapt, not one you find**: `pinch` is proved, on another branch
   (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6p/Proofs/HadwigerNelson/Plane/Saturated/Pinch.lean`, at `43ea4886`; in your tree it is still a `sorry`, and you use
   its statement). Read that proof with the planner's note on where it uses disjointness, and write the cover's form in `CoverHull`; do not
   edit that file — at the join `pinch` becomes a one-line case of yours.
4. **Two leaves have no kernel route yet**: `curvature_integer_ae` (the derivation's step is two lines) and `finite_pieces_of_radius` (one
   mind). Three failed attempts on either is not a fourth: save what is proved and message me — the question for a deriver is already
   drafted (the planner's record § 15.4 item 3), and stopping there with the other eleven proved is a good report.
5. **You own one shared fact** (ruling 531 (c)): "a tangent-type point has positive upper density of each colour". The planner names it as
   a child of the parallels; declare it under a name of your choice as its own lemma, and name it in your report — another implementer
   (`Centre`) will take it from your branch by ancestry.
6. No statement or definition changed; no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. You do not merge
   another branch but as this brief says, run the gate, or touch `main`. Leave no background process running, and keep what your record
   cites under your `data/` folder.
7. **Your record**, stages headed "Stage n — SAVED (FS131-I6L)", "Theorems this phase proved", each read against its row; the report in standing
   rule 11's form, ending with what is left and its route. When you report a defect, say which kind: a *statement* that needs a hypothesis
   it lacks, or a *route* that reads more than the statement needs. Stopping at a saved stage with part of the leaves proved is a good
   report.

## What is yours to decide

The route inside each leaf, your helpers, and the order within the plan's dependencies. The plan is one mind's, written today and compiled
only as far as its statements; change a route that does not go and say so. A statement is not yours to change: one that is false, or true
only with a hypothesis the plan did not see, is a message to me, and a finding — the planner expected four such among these rows and found
none, so one you find is news. Three failed attempts on one route is a dispatch to the companion your identity names, never a fourth.
You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.

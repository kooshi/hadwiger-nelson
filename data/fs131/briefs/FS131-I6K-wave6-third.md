# Brief FS131-I6K — wave 6, accumulation of interface pieces — rays, large-radius arcs, symmetry, holes: open leaves of the third planning pass, on `fs131-w6k`

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I6K
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: one of three implementers of wave 6's third planning pass, split by file — prove the open leaves of `Proofs/HadwigerNelson/Plane/Saturated/Accumulation.lean` (ten leaves) from the planner's plan and the arguments it names, without changing a statement, saving after each leaf or group
  launch: when a slot frees, on a branch cut from the commit at which the wave's third planner handed back, beside the wave's other implementers on branches of their own
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf whose statement is false or cannot be proved as stated (at once, with the configuration: a statement change goes back through me, and other branches read these statements), a step of a hand argument that fails or does not formalize (with its address: it goes to a deriver), or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I6K.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I6K-implementation.md` (new, on branch `fs131-w6k`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6k` (branch `fs131-w6k`, cut from `fs131-w6` at `6fc27fa1`): `Proofs/HadwigerNelson/Plane/Saturated/Accumulation.lean` (ten leaves) — proofs, and new helper declarations under names no other module declares (`LEAN.md` § Searching — Lean, last bullet: two branches never state one lemma under one name; run `./scripts/dupnames.sh` before each push that adds names); a new module of your own beside them if the helpers want one, with `Proofs.lean` and `ARCHITECTURE.md` for it; `scripts/Axioms.lean` (lines of your own in the block headed "FS131-K6c", or a block headed "FS131-I6K", above the `=== PURCHASED ===` banner), `plans/FS131-I6K-implementation.md`, `tools/fs131_i6k_*.py`, `data/fs131/i6k/`, `data/fs131/reports/FS131-I6K.md`; **not** the wave's other modules (other implementers', each on its own branch — a `sorry` you see there is theirs, and you use its statement), any statement, the planners' record, any landed module beyond new declarations, `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are proving part of wave 6 of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones; waves 1–5 are on `main`. Wave 6 is thirty-five rows about *saturated* colourings — classes carved by unit circles
about their own points — the regularity half of this project's route to the answer. Three planning passes have stated twenty-nine of
them; the third stated seventeen in four new files, each read from its argument, and reported nine generalizations on the way. This part is yours: accumulation of interface pieces — rays, large-radius arcs, symmetry, holes.

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

> theorem ray_subset_singularSet (c : AeColouring k) (hsat : Saturated c.cls) (hcl : IsClosed c.singularSet)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6k/Proofs/HadwigerNelson/Plane/Saturated/Accumulation.lean

> theorem rays_false (c : AeColouring k) (hsat : Saturated c.cls) (hS : c.SingLocallyFinite) {x₀ u : ℂ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6k/Proofs/HadwigerNelson/Plane/Saturated/Accumulation.lean

> theorem not_lra_of_windowsGE (c : AeColouring k) (hsat : Saturated c.cls) (hS : c.SingLocallyFinite) {r : ℕ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6k/Proofs/HadwigerNelson/Plane/Saturated/Accumulation.lean

> theorem thin_arcs_of_lra (c : AeColouring k) (hsat : Saturated c.cls) (hS : c.SingLocallyFinite) (hL : c.LRA)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6k/Proofs/HadwigerNelson/Plane/Saturated/Accumulation.lean

> theorem cocompact_of_periods (c : AeColouring k) {u v : ℂ} (hu : c.IsPeriod u) (hv : c.IsPeriod v)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6k/Proofs/HadwigerNelson/Plane/Saturated/Accumulation.lean

> theorem windowsGE_of_cocompact (c : AeColouring k) (hsat : Saturated c.cls) (hS : c.SingLocallyFinite)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6k/Proofs/HadwigerNelson/Plane/Saturated/Accumulation.lean

> theorem finite_radii_of_cocompact (c : AeColouring k) (hsat : Saturated c.cls) (hS : c.SingLocallyFinite)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6k/Proofs/HadwigerNelson/Plane/Saturated/Accumulation.lean

> theorem ext (c : AeColouring k) (hsat : Saturated c.cls) (hS : c.SingLocallyFinite) {z : ℂ} {n m : ℕ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6k/Proofs/HadwigerNelson/Plane/Saturated/Accumulation.lean

> theorem frontier_hole_subset_singularSet (c : AeColouring k) (hsat : Saturated c.cls) {j : Fin k} {x₀ y : ℂ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6k/Proofs/HadwigerNelson/Plane/Saturated/Accumulation.lean

> theorem no_hole_of_singLocallyFinite (c : AeColouring k) (hsat : Saturated c.cls) (hS : c.SingLocallyFinite)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6k/Proofs/HadwigerNelson/Plane/Saturated/Accumulation.lean

The plan (the planners' record, `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6k/plans/FS131-w6-kernel-plan.md`: read Stages 13–15
whole, and of the earlier stages what your files import; the rows for your leaves give a route, its children, what is hard, and a price on
the planners' scale):

> ### 15.1 For implementers: the split by file (statements fixed; children under names of their own)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6k/plans/FS131-w6-kernel-plan.md

> | A | `Plane/Saturated/Accumulation` | 10 | `Parallel`'s; `finite_arcs_of_isBounded`; `pinch` | § 14.5 |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6k/plans/FS131-w6-kernel-plan.md

> - **Two branches never state one lemma under one name** (`LEAN.md` § Searching — Lean): the three cell lemmas of a fan (a cell is
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6k/plans/FS131-w6-kernel-plan.md

> ### 14.5 The plan per leaf (34 leaves; statements fixed; children under names of the implementer's own)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6k/plans/FS131-w6-kernel-plan.md

> The obligation-modeling pass's decisions: **(a)** the pointwise statement the parallels derive from is `partner_point` — `pinch` at the
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6k/plans/FS131-w6-kernel-plan.md

> | `ray_subset_singularSet` | at `x₁ = x₀ + t u ∉ Σ`: a chart in `U = Σᶜ`; for large `n` the piece of `γ n` about parameter `t` lies in the chart's arc with its ends on opposite sides of `x₁` (uniform convergence), so covers the middle (`intermediate_value_Icc` on the chart parameter); two indices then share a piece | the chart parameter as a continuous function on the arc | 2.5 d |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6k/plans/FS131-w6-kernel-plan.md

> | `rays_false` | the above with `SingLocallyFinite.isClosed`; a segment has infinitely many points in a ball | none | 2 h |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6k/plans/FS131-w6-kernel-plan.md

> | `not_lra_of_windowsGE` | V5 § 3.2's four steps: `radius_integer`; inward to radius `r` (`tangent_parallel_in` off `finite_bad_directions`, closure); `WindowsGE`; outward (`out_family`, closure); the arclength parametrizations converge to a segment; `rays_false` | "off finitely many directions, then closure" at each rung; the subsequence for `u_n` | 4 d |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6k/plans/FS131-w6-kernel-plan.md

> | `thin_arcs_of_lra` | `not_windowsGE_of_lra` gives an arc with no extension of window `θ₀`; its extensions are bounded and `cl 𝓘` is closed, so a maximal one exists | the supremum | 4 h |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6k/plans/FS131-w6-kernel-plan.md

> | `cocompact_of_periods` | `K` the closed parallelogram; translations as `IsometryEquiv`; integer parts of the coordinates in the basis `u, v` | none | 4 h |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6k/plans/FS131-w6-kernel-plan.md

> | `windowsGE_of_cocompact` | V5 § 3.4: `cl 𝓘` is invariant under a symmetry (child: density and essential boundary under an isometry and an a.e. equality); finitely many radius-`r` arcs meet `K` (`finite_pieces_of_radius`) | the invariance lemma's size; **rests on a one-mind step** | 4 d |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6k/plans/FS131-w6-kernel-plan.md

> | `finite_radii_of_cocompact` | D2 § 2.3: `not_lra_of_cocompact`; `finite_arcs_of_isBounded`; pieces of bounded radius finite per arc | none after the above | 2 d |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6k/plans/FS131-w6-kernel-plan.md

> | `ext` | induction on `|m − n|` with `tangent_parallel_out`/`_in` on one-sided sub-arcs shrunk off `Σ` (`arc_interior` for the type) | none | 1.5 d |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6k/plans/FS131-w6-kernel-plan.md

> | `frontier_hole_subset_singularSet` | D4 § 2.3 (a)–(d): `diam D ≤ 1`; `K ⊆ conv (cl D)`; `pinch` at `x ∉ Σ`, three cases | a bounded complementary component lies in the convex hull (separation) | 3 d |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6k/plans/FS131-w6-kernel-plan.md

> | `no_hole_of_singLocallyFinite` | the frontier of a bounded non-empty open set is infinite; `Σ` meets a bounded set finitely | none | 3 h |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6k/plans/FS131-w6-kernel-plan.md

> **The price**: `CoverHull` 1.2 d, `Parallel` 16 d, `Centre` 13 d, `Accumulation` 19 d — **about 49 agent-days on the two passes'
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6k/plans/FS131-w6-kernel-plan.md

> ### 14.6 Vacuity and inhabitants (`LEAN.md` § The gate's form)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6k/plans/FS131-w6-kernel-plan.md

## Done means

1. **Your readback first**: check the quotations against their sources; read the record's Stages 13–15, your files and the modules they
   import, and for each leaf the argument the plan's row names. Build the branch once as given (65 `sorry` leaves on the branch: ten yours). Open your record with what
   you may and may not change. Commit and push.
2. **The leaves**, in this order — the short ones first (`rays_false` after `ray_subset_singularSet`, `cocompact_of_periods`, `no_hole_of_singLocallyFinite`: they re-price the rest), then `ext`, `finite_radii_of_cocompact`, `thin_arcs_of_lra`, and the three the planner says carry the price — `not_lra_of_windowsGE`, `windowsGE_of_cocompact`, `frontier_hole_subset_singularSet` — last; saving after each leaf or group (a build, the axioms print for it with a control that
   fires, a statement check against `6fc27fa1`, commit, push). Re-price after your first two leaves and say so: the planner's prices are on
   a scale this wave's first two implementers beat by an order of magnitude on set-algebra leaves, and not on the hard ones.
3. **The accumulation rows share one local obligation and one covering lemma**, by the planner's obligation-modeling pass (its § 14.5,
   decision (d), quoted above): off the singular set the closure of the interface near a point is one simple arc, and a path inside a
   simple arc whose ends lie on opposite sides covers the middle. Prove each once, as lemmas of your own, before the rows that read them.
4. **Most of these theorems have no known object satisfying their hypotheses** — their docstrings say so, with the open question named
   (the planner's § 14.6). That is as ruled: do not strengthen or weaken a hypothesis to make a model exist, and do not delete a
   "satisfiability open" line. A refutation's docstring names the model of its other hypotheses; keep it.
5. No statement or definition changed; no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. You do not merge
   another branch but as this brief says, run the gate, or touch `main`. Leave no background process running, and keep what your record
   cites under your `data/` folder.
6. **Your record**, stages headed "Stage n — SAVED (FS131-I6K)", "Theorems this phase proved", each read against its row; the report in standing
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

## Amendment 1 (2026-10-06, at launch) — your branch now stands on wave 6's first half, landed and proved, and on the fourth planner's pass

Nothing above is withdrawn but where an item below says so; the base moved under you twice while this brief waited.

1. **Your branch was fast-forwarded** from `6fc27fa1` to `2aa3f720`: the wave's fourth planner merged `main` into the wave's line after
   the wave's first half landed there, then added four modules of its own and handed back (inventory items 558, 561, 566). Your tree
   was untouched and unstarted, and the third pass's four modules are byte-identical to `6fc27fa1` (`git diff`, mine). Every "statement
   check against `6fc27fa1`" above now reads **against `2aa3f720`**. The branch as given has **62** `sorry` leaves, not 65 — ten yours, in `Accumulation`;
   of the rest, twenty-eight are the fourth planner's in its new modules and not yours, and the thirty-one of the first two passes
   were proved by five implementers and passed the full gate. Your tree's build is a copy of the planner's at `2aa3f720`, so the build
   as given should rebuild nothing.
2. **The fourteen modules beneath you are theorems now — cite them, re-declare nothing, edit none.** Two names changed at the landing,
   and the plan and records you read may still use the old ones: `polarRegion_isOpen` and `polarRegion_isPreconnected` were folded
   into these two, the same statements binder for binder:

> theorem isOpen_polarRegion (z : ℂ) {r : ℝ} {φ ψ : ℝ → ℝ} (hφ : ContinuousOn φ (Ioo 0 r))
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6k/Proofs/HadwigerNelson/Plane/Saturated/FanBuild.lean

> theorem isPreconnected_polarRegion (z : ℂ) {r : ℝ} {φ ψ : ℝ → ℝ} (hφ : ContinuousOn φ (Ioo 0 r))
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6k/Proofs/HadwigerNelson/Plane/Saturated/FanBuild.lean

3. **Your statement check reads the kernel's statements** (inventory item 556; `LEAN.md` § Searching — Lean, last bullet): a section
   `variable` enters a theorem only if its statement mentions it, so a leaf can lack a hypothesis its file shows, and a comparison of
   text cannot see it. `#check` each leaf before you prove it — with `lake env lean` under the slot, the output saved under your
   `data/` folder — and each head again at your last stage. A leaf whose kernel statement lacks a binder its row reads is a message to
   me before you prove it: proving the wider statement is not the job. Another implementer of this milestone found four leaves false
   for exactly this reason today (item 564) and built a check that compares elaborated signatures, with controls; you may read it
   and use it: `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7a/tools/fs131_i7a_stmt_check.py`.
4. **The fourth planner's pass over the third pass's definitions found none of them wrong** (its record's Stages 17–25, in your tree's
   copy of the plan). Its four new modules — the fragment's six rows, the cover's two lemmas, a reduction, and owed inhabitants with
   two bridges between this pass's notions — are not yours: do not prove their leaves, and do not edit them but as item 6 says.
5. **A reading it settled, which you should hold too**: "saturated on a disc", for a map, is `SaturatedOn F.region U` and never wave
   3's pointwise `SaturatedAt` at every point of the disc — that is false at every interior point of a tile of a valid map, so a
   helper that assumes it is true of nothing.
6. **Nothing of your ten statements moved**, and the facts they read from the bridge — the fan at an isolated singular point, the
   local graph, the nine-colour map's locally finite singular set — are now theorems in your tree, on the standard three. The fourth
   planner's module of owed inhabitants imports yours and proves that a pointwise period is a period: read it before your
   periodicity leaves, and cite it if it serves.
7. **Your last stage runs the guarded lint on what you wrote** (inventory item 573: a landing's gate went red today on an instance
   argument a proof did not read — exactly what the build's own linters do not report, and no branch had linted that file): after
   your last green build, `lake lint --no-build -- --no-build --trace` under the slot with `--mem 8` (`LEAN.md` § The gate), its
   output saved; a line it reports in your module is yours to repair if the repair changes no statement, and a message to me if it
   does (an unused instance binder in a helper of your own is yours; in a leaf, mine to rule).
8. **Two sibling jobs have handed back since this brief was written** (items 576, 579), on branches of their own that yours does not
   hold: fifteen of the cover's and the parallels' seventeen leaves are proved on `origin/fs131-w6l`, four of the centres' seven on
   `origin/fs131-w6z`. In your tree those statements are still `sorry` leaves, and you use them as stated — do not merge either
   branch, and do not prove a leaf of theirs. If a leaf of yours needs a *helper* one of them added, tell me its name.

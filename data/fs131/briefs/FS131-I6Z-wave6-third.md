# Brief FS131-I6Z — wave 6, the centre of a chain and the sectors at a singular point: open leaves of the third planning pass, on `fs131-w6z`

*Written 2026-10-06 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I6Z
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: one of three implementers of wave 6's third planning pass, split by file — prove the open leaves of `Proofs/HadwigerNelson/Plane/Saturated/Centre.lean` (seven leaves) from the planner's plan and the arguments it names, without changing a statement, saving after each leaf or group
  launch: when a slot frees, on a branch cut from the commit at which the wave's third planner handed back, beside the wave's other implementers on branches of their own
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf whose statement is false or cannot be proved as stated (at once, with the configuration: a statement change goes back through me, and other branches read these statements), a step of a hand argument that fails or does not formalize (with its address: it goes to a deriver), or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I6Z.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I6Z-implementation.md` (new, on branch `fs131-w6z`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z` (branch `fs131-w6z`, cut from `fs131-w6` at `6fc27fa1`): `Proofs/HadwigerNelson/Plane/Saturated/Centre.lean` (seven leaves) — proofs, and new helper declarations under names no other module declares (`LEAN.md` § Searching — Lean, last bullet: two branches never state one lemma under one name; run `./scripts/dupnames.sh` before each push that adds names); a new module of your own beside them if the helpers want one, with `Proofs.lean` and `ARCHITECTURE.md` for it; `scripts/Axioms.lean` (lines of your own in the block headed "FS131-K6c", or a block headed "FS131-I6Z", above the `=== PURCHASED ===` banner), `plans/FS131-I6Z-implementation.md`, `tools/fs131_i6z_*.py`, `data/fs131/i6z/`, `data/fs131/reports/FS131-I6Z.md`; **not** the wave's other modules (other implementers', each on its own branch — a `sorry` you see there is theirs, and you use its statement), any statement, the planners' record, any landed module beyond new declarations, `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are proving part of wave 6 of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones; waves 1–5 are on `main`. Wave 6 is thirty-five rows about *saturated* colourings — classes carved by unit circles
about their own points — the regularity half of this project's route to the answer. Three planning passes have stated twenty-nine of
them; the third stated seventeen in four new files, each read from its argument, and reported nine generalizations on the way. This part is yours: the centre of a chain and the sectors at a singular point.

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

> theorem inner_support_near_centre {A : Set ℂ} (hA : MeasurableSet A) (hnull : UnitPairsNull A) {N : Set ℂ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/Proofs/HadwigerNelson/Plane/Saturated/Centre.lean

> theorem outer_support_near_centre {A : Set ℂ} (hA : MeasurableSet A) (hnull : UnitPairsNull A) {N : Set ℂ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/Proofs/HadwigerNelson/Plane/Saturated/Centre.lean

> theorem angle_le_pi (hsat : SaturatedOn c.cls (ball z F.r \ {z})) (i : Fin F.n) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/Proofs/HadwigerNelson/Plane/Saturated/Centre.lean

> theorem ends_centre (hsat : SaturatedOn c.cls (ball z F.r \ {z})) {α β : ℝ} (hαβ : α < β) {a b : Fin k}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/Proofs/HadwigerNelson/Plane/Saturated/Centre.lean

> theorem vt_w (c : AeColouring k) (hsat : Saturated c.cls) (hS : c.SingLocallyFinite) {a b : Fin k} {N Q : Set ℂ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/Proofs/HadwigerNelson/Plane/Saturated/Centre.lean

> theorem erosion (c : AeColouring k) (hsat : Saturated c.cls) (hS : c.SingLocallyFinite) {z : ℂ} {α β : ℝ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/Proofs/HadwigerNelson/Plane/Saturated/Centre.lean

> theorem pencil_window (c : AeColouring k) (hsat : Saturated c.cls) (hS : c.SingLocallyFinite)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/Proofs/HadwigerNelson/Plane/Saturated/Centre.lean

The plan (the planners' record, `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/plans/FS131-w6-kernel-plan.md`: read Stages 13–15
whole, and of the earlier stages what your files import; the rows for your leaves give a route, its children, what is hard, and a price on
the planners' scale):

> ### 15.1 For implementers: the split by file (statements fixed; children under names of their own)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/plans/FS131-w6-kernel-plan.md

> | Z | `Plane/Saturated/Centre` | 7 | `Parallel`'s; `Fan.branch_contacts`, `.branch_outside_discs`, `.sector_alone`, `fan_of_isolated`; `half_dichotomy` | § 14.5 |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/plans/FS131-w6-kernel-plan.md

> - **Two branches never state one lemma under one name** (`LEAN.md` § Searching — Lean): the three cell lemmas of a fan (a cell is
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/plans/FS131-w6-kernel-plan.md

> ### 14.5 The plan per leaf (34 leaves; statements fixed; children under names of the implementer's own)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/plans/FS131-w6-kernel-plan.md

> The obligation-modeling pass's decisions: **(a)** the pointwise statement the parallels derive from is `partner_point` — `pinch` at the
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/plans/FS131-w6-kernel-plan.md

> | `inner_support_near_centre`, `outer_…` | `half_dichotomy` at `q` on `P = B(y, 1) ∩ B(p, ρ)` (inner; convex) or `P = B(p + (ρ/2)u, ρ/2)` (outer); two explicit points of `P`, one within `1` of `q` and one beyond; `r = ρ/8` | none | 3 h each |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/plans/FS131-w6-kernel-plan.md

> | `Fan.angle_le_pi` | `branch_contacts` gives `y = z ± i e(dir i) ∈ supp` of the cell's colour; `half_dichotomy` on the cell; a cell of angle above `π` has rays on both sides. Children shared with `sector_alone`: the cell is preconnected, lies in the density set, and holds the initial part of each ray strictly between its directions | the three cell lemmas — **one statement each, to be taken from line F or as hypotheses, never stated twice** | 1 d |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/plans/FS131-w6-kernel-plan.md

> | `Fan.ends_centre` | DB1 §§ 2.2, 2.4: the cones by `inner_`/`outer_support_near_centre` through the cell lemmas; `z ∈ Σ` (a regular point would have a chart, each side a half-disc in the blow-up, against a cone of width below `π`); covering of the side cones by regions; split on `z ∈ supp S_a`; `sector_unique`, `angle_le_pi` | `z ∈ Σ`; the covering | 2.5 d |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/plans/FS131-w6-kernel-plan.md

> | `vt_w` | V2 §§ 2.5–2.6: F2 by `half_dichotomy` on the `a`-side disc at each chart point; F3 by `partner_point` and the arc exclusion along the parallel (`q < 1` keeps it an immersed `C¹` curve); the parallel's two halves are branches of the fan; the adjacent cells are `a`; no cusp gives `a` a region of positive angle (a horn has density 0: `branch_outside_discs`); `sector_alone` | identifying the halves of `L_Y` with branches; the corner case's wedge | 4 d |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/plans/FS131-w6-kernel-plan.md

> | `erosion` | `xcorner` (wave 1) for `Q`; a chart at `p₁` if `p₁ ∉ Σ`; `vt` at `Q`; the other parallel's half lies in that region and in the essential boundary | none after `vt` | 2 d |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/plans/FS131-w6-kernel-plan.md

> | `pencil_window` | rung 2's outer colour is rung 1's inner colour (`partner_point` at rung 1); no branch on the outer side at a singular point of rung 2 (`vt`'s argument with `sector_alone`); the outer layer is one region; `dist_le_one_of_mem_closure` on the chord | the layer's connectedness | 3 d |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/plans/FS131-w6-kernel-plan.md

> **The price**: `CoverHull` 1.2 d, `Parallel` 16 d, `Centre` 13 d, `Accumulation` 19 d — **about 49 agent-days on the two passes'
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/plans/FS131-w6-kernel-plan.md

> ### 14.6 Vacuity and inhabitants (`LEAN.md` § The gate's form)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/plans/FS131-w6-kernel-plan.md

## Done means

1. **Your readback first**: check the quotations against their sources; read the record's Stages 13–15, your files and the modules they
   import, and for each leaf the argument the plan's row names. Build the branch once as given (65 `sorry` leaves on the branch: seven yours). Open your record with what
   you may and may not change. Commit and push.
2. **The leaves**, in this order — `inner_support_near_centre` and `outer_support_near_centre` (facts about one measurable set: they re-price the rest), `angle_le_pi`, `ends_centre`, then `vt_w`, `erosion`, `pencil_window` — and before you prove those last two, `#check` them: the file's section variable `(F : c.Fan z)` appears in neither statement, so the kernel's `erosion` and `pencil_window` take no fan (`LEAN.md` § Searching — Lean, last bullet; inventory item 556). The planner says `erosion` reads none; confirm that `pencil_window` is meant so too, and message me if its row reads the fan; saving after each leaf or group (a build, the axioms print for it with a control that
   fires, a statement check against `6fc27fa1`, commit, push). Re-price after your first two leaves and say so: the planner's prices are on
   a scale this wave's first two implementers beat by an order of magnitude on set-algebra leaves, and not on the hard ones.
3. **The three cell lemmas of a fan are another implementer's** (ruling 531 (c)): a cell is preconnected, lies in its colour's density set,
   and holds the initial part of each ray strictly between its directions. `angle_le_pi`, `ends_centre` and `vt_w` read them. They are
   not in at this writing: take each as a hypothesis of your helpers under a name of your own (never the names another branch will
   declare), and say where, so the join discharges them in a line each. If I send you their commit mid-job, merge it then and drop the
   hypotheses.
4. **"A tangent-type point has positive upper density of each colour" is the `Parallel` implementer's** (ruling 531 (c)): the same — a
   hypothesis under a name of your own unless I send its commit.
5. No statement or definition changed; no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. You do not merge
   another branch but as this brief says, run the gate, or touch `main`. Leave no background process running, and keep what your record
   cites under your `data/` folder.
6. **Your record**, stages headed "Stage n — SAVED (FS131-I6Z)", "Theorems this phase proved", each read against its row; the report in standing
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

## Amendment 1 (2026-10-06, at launch) — your branch now stands on wave 6's first half, landed and proved

Nothing above is withdrawn but where an item below says so; the base moved under you while this brief waited.

1. **Your branch was fast-forwarded** from `6fc27fa1` to `4ae5bd36`: the wave's fourth planner merged `main` into the wave's line after
   the wave's first half landed there (inventory items 558, 561). Your tree was untouched and unstarted, and the third pass's four
   modules are byte-identical to `6fc27fa1` (`git diff`, mine). Every "statement check against `6fc27fa1`" above now reads **against
   `4ae5bd36`**. The branch as given has **34** `sorry` leaves, not 65 — seven yours, in `Centre`; the other thirty-one were proved by five implementers
   and passed the full gate. Your tree's build is a copy of the planner's at `4ae5bd36`, so the build as given should rebuild nothing.
2. **The fourteen modules beneath you are theorems now — cite them, re-declare nothing, edit none.** Two names changed at the landing,
   and the plan and records you read may still use the old ones: `polarRegion_isOpen` and `polarRegion_isPreconnected` were folded
   into these two, the same statements binder for binder:

> theorem isOpen_polarRegion (z : ℂ) {r : ℝ} {φ ψ : ℝ → ℝ} (hφ : ContinuousOn φ (Ioo 0 r))
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/Proofs/HadwigerNelson/Plane/Saturated/FanBuild.lean

> theorem isPreconnected_polarRegion (z : ℂ) {r : ℝ} {φ ψ : ℝ → ℝ} (hφ : ContinuousOn φ (Ioo 0 r))
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/Proofs/HadwigerNelson/Plane/Saturated/FanBuild.lean

3. **Your statement check reads the kernel's statements** (inventory item 556; `LEAN.md` § Searching — Lean, last bullet): a section
   `variable` enters a theorem only if its statement mentions it, so a leaf can lack a hypothesis its file shows, and a comparison of
   text cannot see it. `#check` each leaf before you prove it — with `lake env lean` under the slot, the output saved under your
   `data/` folder — and each head again at your last stage. A leaf whose kernel statement lacks a binder its row reads is a message to
   me before you prove it: proving the wider statement is not the job.
4. **The fourth planner is working on the wave's line now** — a fresh pass over the third pass's definitions and six more rows, in
   modules of its own. It does not edit your files. If its pass finds that a statement of yours should change, I send it to you as a
   second amendment; until then the statements stand as given.
5. **Item 3 of "Done means" is superseded: the three cell lemmas of a fan are in your tree, proved — cite them, declare none of them
   again, and take no hypothesis in their place** (they are the fifth implementer's, landed):

> theorem isPreconnected_cell (i : Fin F.n) : IsPreconnected (F.cell i) :=
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/Proofs/HadwigerNelson/Plane/Saturated/FanBridge.lean

> theorem cell_subset_densitySet (i : Fin F.n) : F.cell i ⊆ densitySet (c.cls (F.col i)) :=
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/Proofs/HadwigerNelson/Plane/Saturated/FanBridge.lean

> theorem exists_ray_subset_cell (i : Fin F.n) {θ : ℝ} (h1 : F.dir i < θ) (h2 : θ < F.nextDir i) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/Proofs/HadwigerNelson/Plane/Saturated/FanBridge.lean

   If one does not fit a leaf as stated, write a corollary under a name of your own and say so. Item 4 stands as written: the
   tangent-type fact is still the `Parallel` implementer's, a hypothesis under a name of your own unless I send its commit.

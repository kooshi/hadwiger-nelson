# Brief FS131-I6Z2 — wave 6, the centres continued: three sibling branches joined, then the three leaves left of `Centre`, on `fs131-w6z`

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I6Z2
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the continuation of wave 6's centre implementer, on its branch — join the third planning pass's three implementer branches into one line; then prove the three leaves left in `Proofs/HadwigerNelson/Plane/Saturated/Centre.lean` (`vt_w`, `erosion`, `pencil_window`) from your predecessor's route, without changing a statement, saving after each child
  launch: when a slot frees, in the tree your predecessor (FS131-I6Z) handed back; the other two branches of the pass are idle and whole
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job — **once, early, with the hash of the joined line** (item 1: three more implementers are cut from it); for a leaf whose statement is false or cannot be proved as stated (at once, with the configuration: a statement change goes back through me — and say which kind you have, a *statement* that needs a hypothesis it lacks, or a *route* that reads more than the statement needs); for a name two of the three branches both declare; or for a question you cannot work around; the report goes to `data/fs131/reports/FS131-I6Z2.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I6Z2-implementation.md` (new, on branch `fs131-w6z`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z` (branch `fs131-w6z`, at `94a98a58`): `Proofs/HadwigerNelson/Plane/Saturated/Centre.lean` — proofs, and new helper declarations under names no other module declares (`./scripts/dupnames.sh` before each push that adds names); new declarations in `Proofs/HadwigerNelson/Plane/Saturated/LocalGraph.lean` if the chart-restriction lemma belongs beside the structure it restricts (a proved module on this line: nothing existing in it changes); `Proofs.lean`, `ARCHITECTURE.md` and `scripts/Axioms.lean` for the join's conflicts and a block of your own, headed "FS131-I6Z2", above the `=== PURCHASED ===` banner; `plans/FS131-I6Z2-implementation.md`, `tools/fs131_i6z2_*.py`, `data/fs131/i6z2/`, `data/fs131/reports/FS131-I6Z2.md`; **not** any statement, the other modules of the wave beyond the join's mechanical conflicts (`Parallel`'s two open leaves are a deriver's question, and the fourth pass's three modules are three later implementers'), any landed module, `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are proving part of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into kernel-checked
ones. Wave 6 is the saturated class: what a measurable colouring's interfaces look like once every colour class is as large as it can
be — segments and unit-curvature arcs off a singular set, and what happens at the singular points. Its third planning pass stated
thirty-four leaves in four modules; three implementers proved twenty-nine of them on three sibling branches. Yours is the branch that
holds `Centre`: four of its seven leaves are proved, and the implementer who proved them stopped at a saved stage with the route to the
other three written out. You continue from that page.

## Why this job

A result counts as held only when its Lean module passes the gate. The three leaves are the wave's statements at a singular point —
`vt_w`, that the layer beyond a tangent interface is one region there, and its two consumers — and they are the part of route M's
regularity step the frontier calls "contact" (`CLAUDE.md` § The aim; `LEDGER.md` rows 140–144). And the wave cannot be finished from
three branches: the fourth planning pass's twenty-eight leaves are three more implementer jobs, each to be cut from a line that holds
all of the third pass's proofs. Your first act makes that line. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

What your predecessor and its two siblings handed back, and the rulings in force (read each item whole in the inventory,
`plans/FS131-close-inventory.md`):

> 579. **FS131-I6Z done at its Stage 4: wave 6's centres — four of seven leaves proved; three left, of a different kind** (implementer, Opus; harness 449k and 53 minutes by the task notice; record `fs131-w6z`'s `plans/FS131-I6Z-implementation.md`; report `data/fs131/reports/FS131-I6Z.md`; five commits, tip `94a98a58`; pushed, tree clean).
> — source: plans/FS131-close-inventory.md

> 576. **FS131-I6L done at its Stage 4: wave 6's cover hull and parallels — fifteen of seventeen leaves proved; the two left have no kernel route and are a deriver's question** (implementer, Opus; harness 588k and 61 minutes by the task notice; record `fs131-w6l`'s `plans/FS131-I6L-implementation.md`; report `data/fs131/reports/FS131-I6L.md`; seven commits, tip `b5b8f4be`; pushed, tree clean).
> — source: plans/FS131-close-inventory.md

> 590. **FS131-I6K done: wave 6's accumulation rows — all ten leaves proved as stated** (implementer, Opus; harness 513k and 95 minutes by the task notice; record `fs131-w6k`'s `plans/FS131-I6K-implementation.md`; report `data/fs131/reports/FS131-I6K.md`; five commits, tip `2a8ed9eb`; pushed, tree clean).
> — source: plans/FS131-close-inventory.md

> 566. **FS131-K6d done at its Stage 25: wave 6's fourth planning pass — the fragment's six rows stated with no statement defect, the cover's cell proved, and a gap in FS111-M-REDUCE-I now carried by a saved stage** (planner; harness 524k and 51 minutes by the task notice; record `fs131-w6`'s `plans/FS131-w6-kernel-plan.md` Stages 16–25; report `data/fs131/reports/FS131-K6d.md`; commits `59ce6b0c`, the merge `4ae5bd36`, `b79d4892`, `87e8968c`, `2aa3f720`; pushed, tree clean).
> — source: plans/FS131-close-inventory.md

> 556. **FS131-I7A, by message mid-job: a defect of the skeleton — four leaves of route T's count are false as stated, because
> — source: plans/FS131-close-inventory.md

> 573. **FS131-L10B, by message mid-job: the gate is green at every step but the guarded lint — one unused instance argument; a word asked and given** (source: L10B's message to "main", 2026-10-06; its gated commit `e80221d3` on `fs131-w10m` — the artifact is read at its hand-back).
> — source: plans/FS131-close-inventory.md

> 596. **FS131-I8C, by message: three corrections to its note of item 593** (source: I8C's message to "main", 2026-10-06; nothing of its third stage is committed yet).
> — source: plans/FS131-close-inventory.md

## The statements

No statement changes in this job. Your three leaves, and `vt`, which is proved from `vt_w` (each head's first line; read each whole in
your tree, with its docstring):

> theorem vt_w (c : AeColouring k) (hsat : Saturated c.cls) (hS : c.SingLocallyFinite) {a b : Fin k} {N Q : Set ℂ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/Proofs/HadwigerNelson/Plane/Saturated/Centre.lean

> theorem vt (c : AeColouring k) (hsat : Saturated c.cls) (hS : c.SingLocallyFinite) {a b : Fin k} {N Q : Set ℂ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/Proofs/HadwigerNelson/Plane/Saturated/Centre.lean

> theorem erosion (c : AeColouring k) (hsat : Saturated c.cls) (hS : c.SingLocallyFinite) {z : ℂ} {α β : ℝ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/Proofs/HadwigerNelson/Plane/Saturated/Centre.lean

> theorem pencil_window (c : AeColouring k) (hsat : Saturated c.cls) (hS : c.SingLocallyFinite)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/Proofs/HadwigerNelson/Plane/Saturated/Centre.lean


The chart your predecessor's route turns on, and the tangent-type fact that arrives with the join (the last two are on
`origin/fs131-w6l` at `b5b8f4be`, in your tree after item 1):

> structure IsInterfaceChart (A B N : Set ℂ) (y : ℂ) (Q : Set ℂ) (γ : ℝ → ℂ) (ψ : ℝ → ℝ) (h : ℝ) : Prop where
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/Proofs/HadwigerNelson/Plane/Saturated/LocalGraph.lean

> theorem AeColouring.local_graph (c : AeColouring k) {U : Set ℂ} (hU : IsOpen U) (hS : Disjoint U c.singularSet)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/Proofs/HadwigerNelson/Plane/Saturated/LocalGraph.lean

> theorem _root_.HadwigerNelson.Plane.HasTwoDiscsAt.mem_essClosure {A B N : Set ℂ} (hN : IsOpen N) {x ν : ℂ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/Proofs/HadwigerNelson/Plane/Saturated/Parallel.lean

> theorem IsTangentPt.mem_essClosure {c : AeColouring k} {x ν : ℂ} {a b : Fin k} (h : c.IsTangentPt x ν a b) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6l/Proofs/HadwigerNelson/Plane/Saturated/Parallel.lean


The planner's rows for the three (its record, `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/plans/FS131-w6-kernel-plan.md`: read §§ 13–15 whole):

> | Z | `Plane/Saturated/Centre` | 7 | `Parallel`'s; `Fan.branch_contacts`, `.branch_outside_discs`, `.sector_alone`, `fan_of_isolated`; `half_dichotomy` | § 14.5 |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/plans/FS131-w6-kernel-plan.md

> | `vt_w` | V2 §§ 2.5–2.6: F2 by `half_dichotomy` on the `a`-side disc at each chart point; F3 by `partner_point` and the arc exclusion along the parallel (`q < 1` keeps it an immersed `C¹` curve); the parallel's two halves are branches of the fan; the adjacent cells are `a`; no cusp gives `a` a region of positive angle (a horn has density 0: `branch_outside_discs`); `sector_alone` | identifying the halves of `L_Y` with branches; the corner case's wedge | 4 d |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/plans/FS131-w6-kernel-plan.md

> | `erosion` | `xcorner` (wave 1) for `Q`; a chart at `p₁` if `p₁ ∉ Σ`; `vt` at `Q`; the other parallel's half lies in that region and in the essential boundary | none after `vt` | 2 d |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/plans/FS131-w6-kernel-plan.md

> | `pencil_window` | rung 2's outer colour is rung 1's inner colour (`partner_point` at rung 1); no branch on the outer side at a singular point of rung 2 (`vt`'s argument with `sector_alone`); the outer layer is one region; `dist_le_one_of_mem_closure` on the chord | the layer's connectedness | 3 d |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/plans/FS131-w6-kernel-plan.md


**What is left and its route, in your predecessor's words** (its record, `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/plans/FS131-I6Z-implementation.md`, § 4.3 — read the record whole; these are the first
lines of the paragraphs that are yours):

> Three leaves, all in `Centre.lean`: **`vt_w`** (`vt` is proved from it), **`erosion`**, **`pencil_window`**. I read their arguments
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/plans/FS131-I6Z-implementation.md

> **`vt_w` is the keystone** (`erosion` and `pencil_window` both go through `vt`). Write `L s = γ s + i e(ψ s)`, `Y = L s₁`, `F` the fan
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/plans/FS131-I6Z-implementation.md

> 1. *(proved)* F2 at every chart point: `outer_support_near_partner` with `hch.discs s` — near `L s`, `supp S_a` is at least `1` from
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/plans/FS131-I6Z-implementation.md

> 2. `L` is constant on `[s₁, s₂]` (`hunit`: there `L' = (1 − ψ') e(ψ) = 0`).
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/plans/FS131-I6Z-implementation.md

> 3. Just after `s₂` (and just before `s₁`): `L s ≠ Y`, `L s → Y`, and the direction of `L s − Y` tends to `e(ψ s₂)` (to `−e(ψ s₁)`).
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/plans/FS131-I6Z-implementation.md

> 4. `L s ∈ ∂_e S_a` for such `s`: in `supp S_a` (`htan`); off `Σ` (`F.singular`), so no cusp; no density point of `a`, because the
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/plans/FS131-I6Z-implementation.md

> 5. Each half lies on **one** branch and covers its initial part: the branches are pairwise disjoint and each is relatively open in
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/plans/FS131-I6Z-implementation.md

> 6. The cell on the far side of each half has colour `a`: the half's point has an open set almost everywhere of the two cells' colours
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/plans/FS131-I6Z-implementation.md

> 7. One region: `hcusp` gives `a` positive upper density at `Y`, so some region of `a` has positive angle — a zero-angle region has
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/plans/FS131-I6Z-implementation.md

> **`erosion`**: suppose `L₁, L₂ > cot((β − α)/2)` and `p₁ ∉ Σ` (the other case is the mirror image). `xcorner` (`Plane/Chord`) for
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/plans/FS131-I6Z-implementation.md

> **`pencil_window`**: as the plan's row. It reads **no fan as a hypothesis** (the brief's question): its class is saturation with `Σ`
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/plans/FS131-I6Z-implementation.md

> **A cost both consumers of `vt` share, which the plan's rows do not price** (a *route* finding): `vt` takes an
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w6z/plans/FS131-I6Z-implementation.md


## Done means

1. **Your readback, then the join.** Check the quotations against their sources. Merge `origin/fs131-w6l` (at `b5b8f4be`), then
   `origin/fs131-w6k` (at `2a8ed9eb`), into your branch. My trials: yours with either is clean; the two with each other conflict in
   `scripts/Axioms.lean` only — keep every block. Build once; `./scripts/dupnames.sh` on the joined tree (three implementers minted
   helpers side by side: a doubled name is a message to me with both statements, and the later-minted one is renamed). Count the
   `sorry` leaves: by my arithmetic from the three hand-backs and the fourth pass's, 33 — three yours, two in `Parallel`, and
   nineteen, one and eight in `Fragment`, `ReduceI` and `Owed`; a different count is a finding. `#check` your three leaves and read
   the binders the kernel shows (inventory item 556). Commit, push, and **send me the hash with the line "wave 6's third pass is one
   line at this commit"**.
2. **The chart-restriction lemma first** (ruling 579 (a)): an `IsInterfaceChart` restricted to a shorter interval and a smaller
   domain — the cost both consumers of `vt` share, which no plan priced. Your predecessor names why it is not free (the `sides`
   field); prove it once, as a lemma of your own, before either consumer needs it.
3. **`vt_w`**, by the seven children as written (the first is proved); child 3 is the analytic core, and child 7 reads an area
   estimate the library does not hold. **A wider form is yours to make without asking, under a name of your own** — `htan` and
   `hcurv` on a neighbourhood of `[s₁, s₂]` only — **with `vt_w` as stated derived from it**: no statement changes that way, and the
   two consumers may cite whichever serves them. Changing `vt_w`'s own statement is a message to me first.
4. **`erosion`**, then **`pencil_window`**, each through `vt`. Save after each child or leaf (a build, the axioms print with a
   control that fires, a statement check on elaborated signatures against `94a98a58` — your predecessor's instruments are in `tools/`
   on your branch, and its record §§ 2.2 and 4.2 say how it ran them — commit, push). **Before you prove a helper, search the tree for
   its statement's shape, not for a name** (item 596) — after the join the tree holds two siblings' helpers on the same objects.
   Re-price after the restriction lemma and `vt_w`'s second child, and say so.
5. No statement or definition changed; no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. You do not
   merge another branch beyond item 1's two, run the gate, or touch `main`. `Parallel`'s two open leaves are not yours: they wait
   for a deriver. **After your last green build, the guarded lint** — `lake lint --no-build -- --no-build --trace` under the slot
   with `--mem 8` (`LEAN.md` § The gate), its output saved (inventory item 573). Leave no background process running, and keep what
   your record cites under your `data/` folder.
6. **Your record**, stages headed "Stage n — SAVED (FS131-I6Z2)", "Theorems this phase proved", each read against its row; the report in
   standing rule 11's form, ending with what is left and its route. **This may be more than one job holds**: your predecessor priced
   each leaf at several hundred lines and registered small odds of closing any in the context it had left. The join and the
   restriction lemma alone release other work; `vt_w` proved is a result. Stopping at a saved stage and saying exactly what is left
   is a good report — it is how you came to have a route at all.

## What is yours to decide

The route inside each child, your helpers, where the restriction lemma lives, whether to make the wider `vt_w`, and the order after
item 2. The route is one mind's, read against the statements and not proved: change a step that does not go and say so. A statement is
not yours to change: one that is false, or true only with a hypothesis the plan did not see, is a message to me, and a finding. Three
failed attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.

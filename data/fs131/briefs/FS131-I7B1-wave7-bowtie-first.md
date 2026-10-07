# Brief FS131-I7B1 — wave 7, the bowtie's first half — the lune, the side germs, the cap, on `fs131-w7b`

*Written 2026-10-07 (UTC) by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I7B1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: wave 7's first implementer for the bowtie — prove `own`, the two general lemmas about tiles approaching a point (`col_eq_of_tiles_toward`, `not_mem_dom_of_tiles_toward`), the side germs, the two absent-colour leaves, `lune` and the three cap leaves, from the planners' plan, without changing a statement, saving after each leaf or group
  launch: when a slot frees; the second half of the file (FS114-Y4-DIAG's leaves and the stop) is a later job's, on your branch after you
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf or a hypothesis that is false or cannot be met as stated (at once, with the configuration: a statement change goes back through me — and say which kind you have, a *statement* that needs a hypothesis it lacks, or a *route* that reads more than the statement needs), a helper you need that another of the wave's implementers would need too (so that one of you writes it), or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I7B1.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I7B1-implementation.md` (new, on branch `fs131-w7b`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7b` (branch `fs131-w7b`, at `b1101992`): `Proofs/HadwigerNelson/Plane/FourColour/Bowtie.lean` — proofs of your leaves, and new helper declarations under names no other module declares (`./scripts/dupnames.sh` before each push that adds names); `scripts/Axioms.lean` (a block of your own, headed "FS131-I7B1", above the `=== PURCHASED ===` banner), `plans/FS131-I7B1-implementation.md`, `tools/fs131_i7b1_*.py`, `data/fs131/i7b1/`, `data/fs131/reports/FS131-I7B1.md`; **not** any statement, the six leaves of the file's second half (`IsReuleauxBowtie.top_arc`, `IsReuleauxBowtie.top_arc'`, `IsReuleauxBowtie.corner_tiles_toward`, `IsReuleauxBowtie.partner_cone_of_far`, `IsReuleauxBowtie.rstopAll` — a later job's: leave their `sorry`), `Proofs/HadwigerNelson/Plane/FourColour/Local.lean` (another implementer's: its leaves are statements you may cite and may not prove), anything else under `Proofs/HadwigerNelson/Plane/FourColour/`, `Proofs/HadwigerNelson/Plane/SimpleOn.lean` and `Proofs/HadwigerNelson/Plane/RingCalculus/` (wave 8's), any landed module, `main`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are proving part of the Lean backlog. The milestone, FS-131, turns this project's hand-derived results into kernel-checked
ones. Wave 7 is about a vertex where four colours meet in a tight six-colour map of the plane — what such a vertex forces within an
explicit radius. Three planners have worked on it: the first stated and an implementer proved the counting half; the second wrote the
four-colour foundation (the tactic edge, the Reuleaux cross and bowtie) and stated two modules of leaves; the third, today, read every
one of those leaves back from the kernel, corrected seven statements, split the longest leaf into eight, and settled which explicit map
the wave's examples are about. One of those two modules' halves is yours. `main` is not merged into your branch and need not be: nothing of yours reads wave 8.

## Why this job

A result counts as held only when its Lean module passes the gate. These leaves are the local half of the unit-arc question (`LEDGER.md`
rows 137–138; `CLAUDE.md` § Where the problem stands, item 31): the bowtie's stop says a Reuleaux bowtie at a four-colour vertex cannot
live in a disc of radius `√3`. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

What the planners handed back, and the rulings in force (read each item whole in the inventory, `plans/FS131-close-inventory.md`):

> 606. **FS131-K7c done at its Stage 14: wave 7's third planning pass — its three early answers given (items 601, 604), FS114-Y3-RSTOP stated at the class its argument reads, the wave's assumptions listed; the pinwheel not started, by its own judgment, with a fourth pass's reading list** (planner; harness 480k and 46 minutes by the task notice; record `fs131-w7`'s `plans/FS131-w7-kernel-plan.md` Stages 8–14; report `data/fs131/reports/FS131-K7c.md`; five commits, tip `b1101992`; pushed, tree clean).
> — source: plans/FS131-close-inventory.md

> 604. **FS131-K7c, by message mid-job (its Stages 11–13 saved at `02a11514`): wave 7's two stated modules are ready for implementers — four of the five (Q)-arc leaves proved on valid maps alone, one skeleton statement found false in a degenerate case and corrected, the bowtie's stop split into eight children with its "simple" hypothesis narrowed to two points, and the fragment's plan rewritten for the rebuild** (source: K7c's message to "main", 2026-10-07 about 01:10 UTC; record `fs131-w7`'s `plans/FS131-w7-kernel-plan.md` Stages 11–13).
> — source: plans/FS131-close-inventory.md

> 601. **FS131-K7c, by message mid-job (its Stage 10 saved at `9b13628a`): the discrepancy of ruling 553 (a) is settled — two different bowtie fragments are on file, and FS-116's ring survey read the second under the first's name** (source: K7c's message to "main", 2026-10-07 about 00:55 UTC; record `fs131-w7`'s `plans/FS131-w7-kernel-plan.md` Stage 10; `data/fs131/k7c/ring-both.out`).
> — source: plans/FS131-close-inventory.md

> 553. **FS131-K7b done at its Stage 7: wave 7's second planning pass — the four flags decided, the four-colour foundation
> — source: plans/FS131-close-inventory.md

> 564. **FS131-I7A done at its Stage 3: route T's count is proved — nineteen leaves and two models; four of the nineteen were false as the skeleton stated them, repaired as ruled; `anchor` not started** (implementer, Opus; harness 451k and 60 minutes by the task notice; record `fs131-w7a`'s `plans/FS131-I7A-implementation.md`; report `data/fs131/reports/FS131-I7A.md`; four commits, tip `5777e8e7`; pushed, tree clean).
> — source: plans/FS131-close-inventory.md

> 556. **FS131-I7A, by message mid-job: a defect of the skeleton — four leaves of route T's count are false as stated, because
> — source: plans/FS131-close-inventory.md

> 573. **FS131-L10B, by message mid-job: the gate is green at every step but the guarded lint — one unused instance argument; a word asked and given** (source: L10B's message to "main", 2026-10-06; its gated commit `e80221d3` on `fs131-w10m` — the artifact is read at its hand-back).
> — source: plans/FS131-close-inventory.md

> 596. **FS131-I8C, by message: three corrections to its note of item 593** (source: I8C's message to "main", 2026-10-06; nothing of its third stage is committed yet).
> — source: plans/FS131-close-inventory.md

## The statements

No statement changes in this job. Your leaves, as they stand in your tree (each head's first line; read each whole, with its docstring):

> theorem own {k : ℕ} {F : ArcMap k} (hF : F.Valid) {p : ℂ} {φ : ℝ} {t : Set ℂ} {c : Fin k} (ht : F.TileOf c t)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7b/Proofs/HadwigerNelson/Plane/FourColour/Bowtie.lean

> theorem IsReuleauxCross.exists_side_germs {k : ℕ} {F : ArcMap k} (hF : F.Valid) {p : ℂ} {φ : ℝ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7b/Proofs/HadwigerNelson/Plane/FourColour/Bowtie.lean

> theorem IsReuleauxCross.side_colour_absent {k : ℕ} {F : ArcMap k} (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} {φ : ℝ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7b/Proofs/HadwigerNelson/Plane/FourColour/Bowtie.lean

> theorem IsReuleauxCross.side_colour_absent' {k : ℕ} {F : ArcMap k} (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} {φ : ℝ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7b/Proofs/HadwigerNelson/Plane/FourColour/Bowtie.lean

> theorem col_eq_of_tiles_toward {k : ℕ} {F : ArcMap k} (hF : F.Valid) {q : ℂ} {ψ : ℝ} {c₀ : Fin k}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7b/Proofs/HadwigerNelson/Plane/FourColour/Bowtie.lean

> theorem not_mem_dom_of_tiles_toward {k : ℕ} {F : ArcMap k} (hF : F.Valid) {q q' : ℂ} {ψ ψ' : ℝ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7b/Proofs/HadwigerNelson/Plane/FourColour/Bowtie.lean

> theorem IsReuleauxCross.lune (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} {φ : ℝ} (hcov : F.Covers p 1)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7b/Proofs/HadwigerNelson/Plane/FourColour/Bowtie.lean

> theorem IsReuleauxBowtie.cap_colour (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} {φ : ℝ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7b/Proofs/HadwigerNelson/Plane/FourColour/Bowtie.lean

> theorem IsReuleauxBowtie.cap_colour' (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} {φ : ℝ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7b/Proofs/HadwigerNelson/Plane/FourColour/Bowtie.lean

> theorem IsReuleauxBowtie.exists_cap_tile (hF : F.Valid) (hN : F.NonSiamese) {p : ℂ} {φ : ℝ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7b/Proofs/HadwigerNelson/Plane/FourColour/Bowtie.lean


The plan — the planners' record, `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7b/plans/FS131-w7-kernel-plan.md`: read Stages 5–7 (the second pass) and 11–13 (the third) whole; these are the first lines of
the paragraphs and rows that are yours:

> - **`Plane/FourColour/Bowtie`, first job** (about 1,250 lines): `own`, `not_mem_dom_of_tiles_toward`, `col_eq_of_tiles_toward`,
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7b/plans/FS131-w7-kernel-plan.md

> | `own` | the point `ringPt (cornerL p φ) (φ + 7π/6 − η)` lies in `luneGerm p φ δ` for small `η > 0` (it is outside `closedBall (cornerL p (φ + π)) 1`: the two circles are tangent at `p`; outside `closedBall (cornerR p φ) 1`: a chord of `π/3 + η`); `not_mem_coloursAt_of_mem_sphere`; the second corner by the mirror computation | `mem_luneGerm`, `dist_ringPt_ringPt_cmp_one` | two chord computations | 70 |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7b/plans/FS131-w7-kernel-plan.md

> | `IsReuleauxCross.lune` | YB3's steps (`plans/FS114-YB3-verification.md` ll. 160–172): (1) a tile meeting the open lune is `t₂` or has a colour absent at `p` (`NonSiamese.mem_closure_of_inter_ball`; the tiles of `p` are the four); (2) the side `S₁` minus `p` lies in `ball q₁ 1`, so an `a`-tile along it is `X₁`; `X₂` points at every point of `S₁ ∖ {q₁}` (`updown` at `(q₂, z)`, J1), so an `ā`-tile along it would be `X₂ ⊆ ball q₂ 1`, which misses the lune; (3) `S₁` is bordered from the lune by `t₂` near `p` and `X₁` near `q₁` and by nothing else, so `closure t₂ ∩ closure X₁` is infinite; likewise `X₄`; (4) `edge_rainbow hF ht₂ hX₁ hX₄ hne …` gives a Siamese pair | `sides`, `updown`, `edge_rainbow`, `Set.Infinite` to `encard` | step (3): the switch along `S₁` with no "simple" — a connectedness argument on the side arc (`IsPreconnected` of `Ioo`, two relatively closed sets covering it) in place of YB3's rotation at a vertex | 450 |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7b/plans/FS131-w7-kernel-plan.md

> | `cap_colour`, `cap_colour'`, `exists_cap_tile` | Y4 § 2.2: the cap tile at `q₁` is not `t₁` (outside `ball p 1`), not of `t₂`'s colour (`own`), not the partner `T₁` (FS112-U1's cone at the tactic edge `t₁ | t₄`: wave 4's U1 lemma in `Plane/ValidMap/UnitArc`, to be found by name), not `X₁` (`SimpleOn.coneAt_eq_angleIcc_sep` at `q₁`: `t₁`'s cone lies between); six colours leave `t₃`'s and `X₂`'s; if the two cap tiles differ, `updown` twice refuses | `own`, `sides`, `updown`, J1, J3 | the colour accounting at `q₁` (which six) | 400 |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7b/plans/FS131-w7-kernel-plan.md

> **The children** (`Bowtie.lean`; each `sorry`; frame `p = 0`, `φ = 0` in the comments, the statements in a general frame):
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7b/plans/FS131-w7-kernel-plan.md

> | `IsReuleauxCross.exists_side_germs` (any `k`) | each side of `t₁` is, near its far corner, an arc of `Γ` with constant sides, inner colour `t₁`'s | `germ_dichotomy` at `(q₂, φ + π/2, ccw)` and `(q₁, φ − π/2, cw)`; the germ is in `cl t₁ ∖ t₁` (the open side lies in `ball p 1 ∩ ball q₁ 1`, `mem_reulAt`), so not in a class; the inner colour is `t₁`'s | 90 |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7b/plans/FS131-w7-kernel-plan.md

> | `IsReuleauxCross.side_colour_absent`, `'` (any `k`) | `c(X₁), c(X₂) ∉ coloursAt p` (FS114-Y4-SIDES' second clause) | the outer side of the germ has points in `ball p 1`; if the colour were carried at `p` its tile is a tile of `p` (`NonSiamese.mem_closure_of_inter_ball`), one of the four (`reulAt`, `luneGerm` cover a punctured neighbourhood of `p` off four arcs); not `t₂` by `own` (the colour accumulates at `q₁`) | 110 |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7b/plans/FS131-w7-kernel-plan.md

> 1. **`outside_ring_colour` became `col_eq_of_tiles_toward`, a lemma about any valid map** (any `k`, no bowtie, Siamese pairs
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7b/plans/FS131-w7-kernel-plan.md

> 2. **`exists_side_germs` takes the two corners in the domain** (`hd₁`, `hd₂`) in place of `F.Covers p 1`: `germ_dichotomy` reads
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7b/plans/FS131-w7-kernel-plan.md

> And one row stated that the same reading gave whole: **FS114-Y3-RSTOP is `not_mem_dom_of_tiles_toward`** (`Bowtie.lean`, any valid
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7b/plans/FS131-w7-kernel-plan.md

> **Statement-level mutation audit of the children** (each mutation read against (b), one mind): `corner_tiles_toward` with the window
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7b/plans/FS131-w7-kernel-plan.md

> - **J1 `mem_coneAt_of_ringArc_subset_closure`** — a set whose closure holds `ringArc q θ₁ θ₂` (`θ₁ < θ₂`) approaches `r(θ₁)` along
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7b/plans/FS131-w7-kernel-plan.md

> - **J3 `exists_tile_mem_coneAt`** — at a point of the domain every direction lies in some tile's cone (`localSectors`). Read by
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7b/plans/FS131-w7-kernel-plan.md

> **D1 (N3-HALF's last clause).** The unexcepted sentence is not needed by the stop: in a bowtie no tile of `p` other than `t₁` has
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7b/plans/FS131-w7-kernel-plan.md


## Done means

1. **Your readback first**: check the quotations against their sources; read the record's stages named above, your module and those
   it imports, and each row's derivation entry at the address the record gives. Build the branch once as given. `#check` every leaf of yours and read the
   binders the kernel shows (inventory item 556) — the third planner did this for all of them an hour ago, so a difference is a
   finding. Open your record with what you may and may not change. Commit and push.
2. **The leaves**, in this order: `own`; the two general lemmas `col_eq_of_tiles_toward` and `not_mem_dom_of_tiles_toward` (statements about any valid map, about 130 lines each by the planner: they re-price the rest, and the second is a whole backlog row, FS114-Y3-RSTOP); `exists_side_germs`, then `side_colour_absent` and its mirror; `lune` (the planner's largest of yours: its step (3) wants a connectedness argument on the side arc in place of the hand proof's rotation at a vertex); then the three cap leaves. Save after each leaf or group (a build, the axioms print for it with a control that fires, a statement check on elaborated signatures against `b1101992` — the wave's
   instruments are on your branch: `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7b/tools/fs131_i7a_stmt_check.py` and the third planner's kernel-signature reader
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7b/tools/fs131_k7c_kernelsig.py` with `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w7b/data/fs131/k7c/kernel-sigs.lean` — commit, push). **Before you prove a helper, search the tree
   for its statement's shape, not for a name** (inventory item 596: an implementer wrote two weaker copies of landed theorems, and
   three lemmas a plan called missing were in the library). Re-price after your first two leaves and say so: about 1,250 lines by the third planner.
3. **The inhabitant is not yours, and its absence is not a defect**: every structure-valued hypothesis here names the bowtie fragment
   as its Lean model, and that map is being put in the kernel by four other jobs; each leaf's docstring keeps the planner's line on
   what is owed. A hypothesis you find no map can meet is a message to me — that would be a finding about the row.
4. No statement or definition changed; no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. You do not
   merge another branch beyond what item 1 names, run the gate, or touch `main`. **After your last green build, the guarded lint** —
   `lake lint --no-build -- --no-build --trace` under the slot with `--mem 8` (`LEAN.md` § The gate), its output saved (inventory item
   573). Leave no background process running, and keep what your record cites under your `data/` folder.
5. **Your record**, stages headed "Stage n — SAVED (FS131-I7B1)", "Theorems this phase proved", each read against its row; the report in
   standing rule 11's form, ending with what is left and its route. Stopping at a saved stage with part of the work done is a good
   report.

## What is yours to decide

The route inside each leaf, your helpers, and the order within the plan's dependencies. The plan is three minds', none of whom proved
your leaves: change a route that does not go and say so. A statement is not yours to change: one that is false, or true only with a
hypothesis the plan did not see, is a message to me, and a finding — the third planner found one that way this morning. Three failed
attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level
deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. `/tmp` on this machine is a tmpfs, wiped at power-off: keep anything your record
cites under your `data/` folder, never in `/tmp`. Nothing with a `sorry` reaches `main`.

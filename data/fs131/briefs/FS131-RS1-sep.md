# Brief FS131-RS1 — the boundary walk's SEP lane: `IsBoundaryWalk.sep`, the planar chain's last leaf, on `fs131-w5p`

*Written 2026-10-05 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-RS1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the SEP lane — prove `IsBoundaryWalk.sep` over FS131-RL1's six children (SEP-ROT, SEP-CHAIN, SEP-S, SEP-K1, SEP-CORE, SEP-REDUCE), in its plan § 4.1's order, saving after each, and re-price after the first two
  launch: now, beside FS131-IMM3 (MERGE, on `fs131-w4mm`) and FS131-I5n (wave 5's `Terminal` half, on `fs131-w5c`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a child that cannot be proved as written, a statement that looks false, a field of `IsBoundaryWalk` or `IsEdgeOf` that SEP needs and does not have, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-RS1.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-planar-implementation.md` (on branch `fs131-w5p`; you continue it from Stage 27, headed as yours)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p` (branch `fs131-w5p`): in `Proofs/HadwigerNelson/Plane/ValidMap/MapGraph.lean` `IsBoundaryWalk.sep` and its children beside it (before it); `Proofs/HadwigerNelson/Plane/ValidMap/MapTopology.lean` (pure-topology children, § F); `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (the block headed "FS131-KP", which you extend, above the `=== PURCHASED ===` banner), `plans/FS131-planar-implementation.md`, `tools/fs131_rs_*.py`, `data/fs131/rs/`, `data/fs131/reports/FS131-RS1.md`; **not** `IsBoundaryWalk`, `IsEdgeOf`, `IsPortGraph` or any other statement (a field SEP needs is a message to me), `exists_boundaryWalk`, `filledGraph_ringList`, `IsRing`, `PlanarLike`, `CurveGraph`, `Plane/PlaneTopology`, `BaseWalk`, `BaseDense`, or RL1's plan file
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are proving the last leaf of the plane topology that wave 5 of the Lean backlog needs. The milestone, FS-131, turns this project's hand-derived
results into kernel-checked ones; waves 1–4 and Woodall's chain are on `main`, and wave 5 (termination and density) is being proved on three branches. On
this branch every field of the filled map graph is proved but F-RING, and F-RING rests on two halves: WALK, which FS131-RW2 has just proved (every outer tile
has a boundary walk), and SEP, yours — a tile the walk lists twice separates the entries between its two positions from those outside. FS131-RL1 planned SEP
by the crossing lemma outside a small disc, which it proved.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and F-RING,
`filledGraph_planarLike` and `cvb_thom_reduced` now rest on this leaf alone. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

Your leaf, `sorry` on `fs131-w5p` at `e27da6c1` (read it whole, with `IsBoundaryWalk` and `IsEdgeOf`, in `MapGraph` § "The boundary walk"):

> theorem IsBoundaryWalk.sep {x : {T : Set ℂ // F.IsOuterTile T}} {r : List {T : Set ℂ // F.IsOuterTile T}} {z : ℕ → ℂ}
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/Proofs/HadwigerNelson/Plane/ValidMap/MapGraph.lean

RL1's plan for it — read §§ 2 and 4 in full:

> 2. **SEP** (`IsBoundaryWalk.sep`): two positions of `y` are edge entries; with `a` after appearance `s` and `b` after `t ≠ s` (cyclic arcs),
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-ringlist-kernel-plan.md 2.2 The route: a boundary walk, then the crossing lemma outside a disc

> - **Are `IsEdgeOf` / `IsBoundaryWalk` the statements SEP derives from?** Yes, field by field: SEP's `K₂` reads `hinge` (consecutive
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-ringlist-kernel-plan.md 4.1 The obligation pass (`debruijn-obligation-modeling`, invoked fresh, scoped to ADJ, SEP, WALK)

> - **SEP's space** is the cyclic arcs between consecutive appearances of `y`; the mod-`n` indexing is the incidental structure. Strengthen
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-ringlist-kernel-plan.md 4.1 The obligation pass (`debruijn-obligation-modeling`, invoked fresh, scoped to ADJ, SEP, WALK)

> **SEP** (M–H, 1.2–1.5 over its six children, § 4.1). Uses `inter_nonempty_of_interleaved_exterior` and `isPreconnected_diff_ball`
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-ringlist-kernel-plan.md 4.2 The plan per child (price in implementer sessions, Opus; to be re-priced from the first two leaves)

> **May**: add children (statements of § 4.2, with spec examples), add fields to `IsBoundaryWalk` or clauses to `IsEdgeOf` **if** the
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-ringlist-kernel-plan.md 4.4 The handoff to the implementer

What RL1 and RW2 handed back, and the rulings on the lanes and on your slot:

> 338. **FS131-RL1 done: the boundary walk planned** (planner; stage 4 SAVED, harness ≈ 395k by the task notice; record `fs131-w5p`'s
> — source: plans/FS131-close-inventory.md

> 339. **Rulings on RL1's held items, and its slot.** (a) **RL1's slot → the WALK lane, FS131-RW1, on `fs131-w5p`**: ADJ first (the warm-up, measured, since
> — source: plans/FS131-close-inventory.md

> 351. **FS131-RW2 done: WALK is held** (harness ≈ 477k by the task notice; record `fs131-w5p`'s `plans/FS131-planar-implementation.md`, Stages 23–26; report
> — source: plans/FS131-close-inventory.md

> 352. **Ruling on RW2's slot: the SEP lane, FS131-RS1, on `fs131-w5p` itself** (RW2 finished, so no new branch), from `e27da6c1`: SEP's six children in RL1's
> — source: plans/FS131-close-inventory.md

The definition of a hole, as ruled:

> 277. **Ruling on item 276: adopt KP's `IsHoleOf`; KP may rewrite `exists_holed_valid_fragment`'s proof.** Choice: the separated-part definition as sent; KP's
> — source: plans/FS131-close-inventory.md

## Done means

1. **Your readback first**: check every quotation above against its source; read RL1's plan in full and RW1's and RW2's Stages 20–26 (what WALK builds, and
   that it relies on SEP exactly as stated); build the branch once as given (`e27da6c1`) before editing anything; open Stage 27 in the record with what you
   may and may not change. Commit and push.
2. **The order of § 4.1**: SEP-ROT, SEP-CHAIN — re-price the rest in the record after them — then SEP-S, SEP-K1, SEP-CORE, SEP-REDUCE, then
   `IsBoundaryWalk.sep`'s body. Each child stated before it is proved; save after each; no statement outside this lane changed, no new `axiom`, no
   `native_decide`. Do not edit a file while a build of it runs. Use a build wrapper that writes its exit-status line (RW2's
   `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/data/fs131/rw/rw2-build.sh` is one).
3. **The handover**: your record's last stage says what is proved and what is left, with the build log and an axioms print against that build's oleans,
   including a control on `sorryAx` while one remains (if SEP lands, say which declarations of the branch still read `sorryAx` and why). You do not merge into
   another branch, take `main` into this branch, run the gate, or touch `main`. Stopping at a saved stage with children left, named, is a good report.
4. **Your record**, stages headed "Stage n — SAVED (FS131-RS1)", "Theorems this phase proved"; the report in standing rule 11's form. Leave no background process
   running when you hand back.

## What is yours to decide

The proofs, the exact statements of the six children within § 4.1's words, their order within the dependencies, and where a pure-topology child lives. RL1's
route is a plan, not a rule: a shorter one you find is yours, said in the record. If SEP looks false for some walk meeting `IsBoundaryWalk`'s fields, or needs
a field the structure lacks, stop and message me at once with the smallest counterexample or the missing field — the structure is WALK's output too, so a
change is mine to rule. Three failed attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your
own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`.

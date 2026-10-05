# Brief FS131-RW1 — the boundary walk, implemented: ADJ, then WALK (`exists_boundaryWalk`, children C1–C10) on `fs131-w5p`

*Written 2026-10-05 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-RW1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the boundary walk's WALK lane — prove ADJ (`filledGraph_adj_iff`), then WALK (`exists_boundaryWalk`) over FS131-RL1's children C1–C10, in its plan § 4.4's order, saving after each child, and re-price after C1–C4
  launch: now, beside FS131-I5k (wave 5's `Terminal` half, on `fs131-w5c`) and FS131-IMM2 (MERGE, on `fs131-w4mm`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a child that cannot be proved as written, a statement that looks false, a change you need to `IsBoundaryWalk` or `IsEdgeOf`, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-RW1.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-planar-implementation.md` (on branch `fs131-w5p`; you continue it from Stage 20, headed as yours)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p` (branch `fs131-w5p`): in `Proofs/HadwigerNelson/Plane/ValidMap/MapGraph.lean` `filledGraph_adj_iff`, `exists_boundaryWalk` and children beside them (§ "The boundary walk"), and `IsBoundaryWalk` / `IsEdgeOf` only as ruling 339 (c) allows; `Proofs/HadwigerNelson/Plane/ValidMap/MapTopology.lean` (pure-topology children, § F), `Proofs/HadwigerNelson/Plane/CurveGraph.lean` (children beside the handshake); `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (the block headed "FS131-KP", which you extend, above the `=== PURCHASED ===` banner), `plans/FS131-planar-implementation.md`, `tools/fs131_rw_*.py`, `data/fs131/rw/`, `data/fs131/reports/FS131-RW1.md`; **not** `IsBoundaryWalk.sep` or its children (the SEP lane's, item 339 (b)), `filledGraph_ringList`, `IsRing`, `PlanarLike`, `Plane/PlaneTopology`, `BaseWalk`, `BaseDense`, or RL1's plan file
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are building the boundary walk of a filled tile, the last leaf of the plane topology that wave 5 of the Lean backlog needs. The milestone, FS-131,
turns this project's hand-derived results into kernel-checked ones; waves 1–4 and Woodall's chain are on `main`, and wave 5 (termination and density) is
being proved on three branches. On this branch the planar infrastructure is proved but for one field of the filled map graph, F-RING, which FS131-IP5 reduced
to `filledGraph_ringList`. FS131-RL1 has just planned that leaf: two lanes, SEP (a tile listed twice separates) and WALK (every outer tile has a boundary
walk). WALK is the longer — it is now the longest path to wave 5's landing — and it is yours, with ADJ first.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and wave 5's
`cvb_thom_reduced` and `filledGraph_planarLike` rest on this leaf. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

Your two leaves, `sorry` on `fs131-w5p` at `f86e174e` (read each whole, with `IsBoundaryWalk` and `IsEdgeOf`, in `MapGraph` § "The boundary walk"):

> theorem exists_boundaryWalk (hF : F.Valid) (hP : F.IsPlaneMap) (x : {T : Set ℂ // F.IsOuterTile T}) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/Proofs/HadwigerNelson/Plane/ValidMap/MapGraph.lean

> theorem filledGraph_adj_iff (hP : F.IsPlaneMap) {x y : {T : Set ℂ // F.IsOuterTile T}} :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/Proofs/HadwigerNelson/Plane/ValidMap/MapGraph.lean

RL1's plan — read §§ 2 and 4 in full, the two traps of § 2.1 above all:

> **ADJ `filledGraph_adj_iff`** (E–M, 0.2). `←`: `cl x ⊆ cl x̂` (`subset_fill`). `→`: `z ∈ cl x̂ ∩ cl ŷ`. A hole `H` of `y` is open and misses
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-ringlist-kernel-plan.md 4.2 The plan per child (price in implementer sessions, Opus; to be re-priced from the first two leaves)

> **WALK** (H, 4–6). Children, each to be stated by the implementer before proving (statements fixed here in words):
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-ringlist-kernel-plan.md 4.2 The plan per child (price in implementer sessions, Opus; to be re-priced from the first two leaves)

> - **C5 the boundary structure**: ports at radius `ρ` (`port_pair` with `hreg`, `hP`, `hray`, `hsep` exactly as in `even_sum_deg`'s proof),
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-ringlist-kernel-plan.md 4.2 The plan per child (price in implementer sessions, Opus; to be re-priced from the first two leaves)

> **May**: add children (statements of § 4.2, with spec examples), add fields to `IsBoundaryWalk` or clauses to `IsEdgeOf` **if** the
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-ringlist-kernel-plan.md 4.4 The handoff to the implementer

What RL1 handed back, and the rulings that launch you:

> 338. **FS131-RL1 done: the boundary walk planned** (planner; stage 4 SAVED, harness ≈ 395k by the task notice; record `fs131-w5p`'s
> — source: plans/FS131-close-inventory.md

> 339. **Rulings on RL1's held items, and its slot.** (a) **RL1's slot → the WALK lane, FS131-RW1, on `fs131-w5p`**: ADJ first (the warm-up, measured, since
> — source: plans/FS131-close-inventory.md

The definition of a hole, as ruled:

> 277. **Ruling on item 276: adopt KP's `IsHoleOf`; KP may rewrite `exists_holed_valid_fragment`'s proof.** Choice: the separated-part definition as sent; KP's
> — source: plans/FS131-close-inventory.md

## Done means

1. **Your readback first**: check every quotation above against its source; read RL1's plan in full and IP5's Stages 17–19; build the branch once as given
   (`f86e174e`) before editing anything; open Stage 20 in the record with what you may and may not change. Commit and push.
2. **The order**: ADJ (measured); then WALK's C1, C2, C3, C4 — re-price the rest of WALK in the record after them; then C5 (the boundary structure), C6
   (cycles), C7 (W-CONN), C8–C9 (W-MERGE, W-DROP), C10 (W-COVER, W-APART), then `exists_boundaryWalk`'s body. Each child stated before it is proved (statements
   as § 4.2 fixes them in words, with spec examples); save after each; no statement outside this lane changed, no new `axiom`, no `native_decide`. Do not edit
   a file while a build of it runs.
3. **The handover**: your record's last stage says what is proved and what is left, with the build log and an axioms print against that build's oleans,
   including a control on `sorryAx`. You do not merge into another branch, take `main` into this branch, run the gate, or touch `main`. Stopping at a saved
   stage with children left, named, is a good report.
4. **Your record**, stages headed "Stage n — SAVED (FS131-RW1)", "Theorems this phase proved"; the report in standing rule 11's form.

## What is yours to decide

The proofs, the exact statements of C1–C10 within § 4.2's words, their order within the dependencies, and where a pure-topology child lives (`MapTopology` or
`CurveGraph`). RL1's route is a plan, not a rule: a shorter construction you find is yours, said in the record. If a child cannot be proved as written, or
WALK looks false for some valid plane map, stop it and message me at once with the smallest counterexample or the missing hypothesis, and go on with the
others. Three failed attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule
1: delegation is one level deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`.

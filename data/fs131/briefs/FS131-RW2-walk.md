# Brief FS131-RW2 — the boundary walk, finished: WALK's C5a–C5d, C7, C10 and `exists_boundaryWalk` on `fs131-w5p`

*Written 2026-10-05 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-RW2
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the WALK lane's second implementer — continue FS131-RW1's work on `fs131-w5p` from its Stage 22, in its record § 22.2's order, saving after each child, and prove `exists_boundaryWalk`
  launch: now, beside FS131-I5l (wave 5's `Terminal` half, on `fs131-w5c`) and FS131-I5m (wave 5's other half, on `fs131-w5`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a child that cannot be proved as written, a statement that looks false, a change you need to `IsBoundaryWalk` or `IsEdgeOf`, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-RW2.md` on your branch, and its text is your final message (if the harness refuses that file, say so and the coordinator files it from your hand-back)
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-planar-implementation.md` (on branch `fs131-w5p`; you continue it from Stage 23, headed as yours)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p` (branch `fs131-w5p`): in `Proofs/HadwigerNelson/Plane/ValidMap/MapGraph.lean` `exists_boundaryWalk` and children beside it, and `IsBoundaryWalk` / `IsEdgeOf` only as ruling 339 (c) allows; `Proofs/HadwigerNelson/Plane/CurveGraph.lean` (C5a's `port_arc` and `port_pair`'s proof over it, statement unchanged — ruling 346 (a)); `Proofs/HadwigerNelson/Plane/ValidMap/MapTopology.lean` (pure-topology children, § F); `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (the block headed "FS131-KP", which you extend, above the `=== PURCHASED ===` banner), `plans/FS131-planar-implementation.md`, `tools/fs131_rw_*.py`, `data/fs131/rw/`, `data/fs131/reports/FS131-RW2.md`; **not** `IsBoundaryWalk.sep` or its children (the SEP lane's), `filledGraph_ringList`, `IsRing`, `PlanarLike`, `Plane/PlaneTopology`, `BaseWalk`, `BaseDense`, or RL1's plan file
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage

Hello. You are finishing the boundary walk of a filled tile, the last construction of the plane topology that wave 5 of the Lean backlog needs. The
milestone, FS-131, turns this project's hand-derived results into kernel-checked ones; waves 1–4 and Woodall's chain are on `main`, and wave 5 (termination
and density) is being proved on three branches. FS131-RW1 proved ADJ, WALK's C1–C4 and the Euler circuit of a port structure (C6/C8), and found that WALK
needs only an Euler circuit of the boundary graph, because SEP reads no facial order. Its re-price of what is left — C5a–C5d, C7, C10 and the assembly — is
about one session. That is yours.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and wave 5's
`cvb_thom_reduced` and `filledGraph_planarLike` rest on this leaf. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

Your leaf, `sorry` on `fs131-w5p` at `515e28af` (read it whole, with `IsBoundaryWalk` and `IsEdgeOf`, in `MapGraph` § "The boundary walk"):

> theorem exists_boundaryWalk (hF : F.Valid) (hP : F.IsPlaneMap) (x : {T : Set ℂ // F.IsOuterTile T}) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/Proofs/HadwigerNelson/Plane/ValidMap/MapGraph.lean

What is left, in RW1's words — read its Stages 21–22 in full, § 21.2's shorter route above all:

> - **C5a `port_arc`** (`CurveGraph`, beside the handshake; `port_pair` re-proved through it, its statement unchanged): `port_pair`'s
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-planar-implementation.md 22.2 What is left of WALK, named, with the route (for the next session)

> - **C5b the port structure of `C = ∂ cl x̂`**: `V` = (`finite_frontier_fill_nonRegular`).toFinset ∪ {a point of `C`}; stars from
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-planar-implementation.md 22.2 What is left of WALK, named, with the route (for the next session)

> - **C5c the edges**: `R_d = closure (ray_d '' (0, ρ))`, with `w ∈ R_d, w ≠ v ⇒ w = ray_d ‖w − v‖` (sequential continuity at `‖w − v‖ ∈ (0, ρ]`);
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-planar-implementation.md 22.2 What is left of WALK, named, with the route (for the next session)

> - **C5d `IsEdgeOf`** for `E_d` from `vtx d` to `vtx (σ d)`: pure point `γ((a+b)/2)`; radius below the chart radius there, below the distance to
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-planar-implementation.md 22.2 What is left of WALK, named, with the route (for the next session)

> - **C7** `hconn` for the ports: a `σ`-closed set and its complement sharing no vertex give disjoint closed unions of edges covering `C`, against
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-planar-implementation.md 22.2 What is left of WALK, named, with the route (for the next session)

> - **C10** the assembly: entries = the edges of `exists_euler`'s list, then each neighbour with no edge (it touches `C` only at vertices)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-planar-implementation.md 22.2 What is left of WALK, named, with the route (for the next session)

What RW1 handed back, and the rulings that launch you:

> 345. **FS131-RW1 handed back** (Stage 22 SAVED, harness ≈ 463k by the task notice; record `fs131-w5p`'s `plans/FS131-planar-implementation.md`, Stages 20–22;
> — source: plans/FS131-close-inventory.md

> 346. **Rulings on RW1's held items, and its slot.** (a) **`port_pair` re-proved over `port_arc`: accepted** — its statement unchanged, the new proof checked
> — source: plans/FS131-close-inventory.md

The rulings on the lanes and on `IsBoundaryWalk` / `IsEdgeOf`:

> 339. **Rulings on RL1's held items, and its slot.** (a) **RL1's slot → the WALK lane, FS131-RW1, on `fs131-w5p`**: ADJ first (the warm-up, measured, since
> — source: plans/FS131-close-inventory.md

The definition of a hole, as ruled:

> 277. **Ruling on item 276: adopt KP's `IsHoleOf`; KP may rewrite `exists_holed_valid_fragment`'s proof.** Choice: the separated-part definition as sent; KP's
> — source: plans/FS131-close-inventory.md

## Done means

1. **Your readback first**: check every quotation above against its source; read RW1's Stages 20–22 and RL1's plan
   (`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-ringlist-kernel-plan.md`) §§ 2 and 4; build the branch once as given (`515e28af`) before editing anything; open Stage 23 in the record with what you may and may not
   change. Commit and push.
2. **The order of record § 22.2**: C5a (`port_arc`, `port_pair` re-proved over it), C5b, C5c, C5d, C7, C10, then `exists_boundaryWalk`'s body. Each child stated
   before it is proved, with a spec example where it carries a structure; save after each; re-price after the first two; no statement outside this lane
   changed, `port_pair`'s statement byte-identical, no new `axiom`, no `native_decide`. Do not edit a file while a build of it runs. Make your build wrapper
   write its exit-status line (RW1's did not at stage 22).
3. **The handover**: your record's last stage says what is proved and what is left, with the build log and an axioms print against that build's oleans,
   including a control on `sorryAx` (`IsBoundaryWalk.sep` serves). You do not merge into another branch, take `main` into this branch, run the gate, or touch
   `main`. Stopping at a saved stage with children left, named, is a good report.
4. **Your record**, stages headed "Stage n — SAVED (FS131-RW2)", "Theorems this phase proved"; the report in standing rule 11's form. Leave no background
   process running when you hand back.

## What is yours to decide

The proofs, the exact statements of the children within § 22.2's words, their order within the dependencies, and where a pure-topology child lives. RW1's
route is a plan, not a rule. If a child cannot be proved as written, or WALK looks false for some valid plane map, stop it and message me at once with the
smallest counterexample or the missing hypothesis, and go on with the others. Three failed attempts on one route is a dispatch to the companion your identity
names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows
exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`.

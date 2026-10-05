# Brief FS131-RL1 — the boundary walk of a filled tile (RING-LIST): plan `filledGraph_ringList`, the planar chain's last leaf, on `fs131-w5p`

*Written 2026-10-05 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-RL1
  identity: de Bruijn, the planner — your agent file (`.claude/agents/debruijn.md`) is your identity and your lane's workflow
  role: plan the boundary walk — choose its route through the plane topology already held on this branch, lay `filledGraph_ringList` out as named children with `sorry` at each, read each back, give a plan per child with a price, run the obligation pass, and write the implementer's handoff; prove a child yourself where it is short
  launch: now, beside FS131-I5i (wave 5's `Terminal` half, on `fs131-w5c`) and FS131-I5j (wave 5's other half, on `fs131-w5`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a statement defect (if `filledGraph_ringList` or `IsRing` looks false for some valid plane map), a piece of the literature you find used by statement, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-RL1.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building before your first build
  record: `plans/FS131-ringlist-kernel-plan.md` (new, on branch `fs131-w5p`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p` (branch `fs131-w5p`): `Proofs/HadwigerNelson/Plane/ValidMap/MapGraph.lean` (`filledGraph_ringList` and children beside it; no other statement), `Proofs/HadwigerNelson/Plane/ValidMap/MapTopology.lean`, `Proofs/HadwigerNelson/Plane/CurveGraph.lean` (pure-topology children), a new module upstream of `MapGraph` if your layout wants one; in `Proofs/HadwigerNelson/Thomassen.lean` only `PlanarLike`'s docstring (item 333 (c)); `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (the block headed "FS131-KP", which you extend, above the `=== PURCHASED ===` banner), `plans/FS131-ringlist-kernel-plan.md`, `tools/fs131_rl_*.py`, `data/fs131/rl/`, `data/fs131/reports/FS131-RL1.md`; **not** `Proofs/HadwigerNelson/Plane/PlaneTopology.lean` (held, finished), `BaseWalk`, `BaseDense`, any statement in `Thomassen`, or FS131-KP's plan file
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 480k — read your token count at every saved stage

Hello. You are planning the last leaf of the plane topology that wave 5 of the Lean backlog needs. The milestone, FS-131, turns this project's hand-derived
results into kernel-checked ones; waves 1–4 and Woodall's chain are on `main`, and wave 5 (termination and density) is being proved on three branches. This
branch, `fs131-w5p`, holds the planar infrastructure FS131-KP planned and five implementers proved: the plane's unicoherence, the pinch-and-hole theorem, the
crossing lemma, the boundary graph as a handshake (`Plane/CurveGraph`), one-sidedness along a continuum (`orient`), the D-cut at a circle point, Janiszewski's
theorem for holes, and all of the filled map graph's fields but one. FS131-IP5 reduced that last field, F-RING, to one child, `filledGraph_ringList`: the
boundary walk of a filled tile. Two minds price it as the chain's hardest piece, so it gets a plan before an implementer.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and wave 5's
`cvb_thom_reduced` and `filledGraph_planarLike` rest on this leaf. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

The leaf, `sorry` on `fs131-w5p` at `b6f9e761`:

> /-- **The boundary walk of a filled tile** (F-RING's remaining child; FS131-IP5's reduction of F-RING, by statement exactly F-RING's first
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/Proofs/HadwigerNelson/Plane/ValidMap/MapGraph.lean

> theorem filledGraph_ringList (hF : F.Valid) (hP : F.IsPlaneMap) (x : {T : Set ℂ // F.IsOuterTile T}) :
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/Proofs/HadwigerNelson/Plane/ValidMap/MapGraph.lean

(the docstring continues there), over Thomassen's ring:

> def IsRing (x : V) (r : List V) : Prop :=
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/Proofs/HadwigerNelson/Thomassen.lean

(read `IsRing` and `PlanarLike` in full there). What IP5 measured, and what it found about the ring field:

> - **Measured from its first child**: the reduction (quadrupling plus the non-neighbour clause) took about 10 minutes and about 90 lines, because the
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-planar-implementation.md 19.2 F-RING measured (done-means 4), and for the coordinator

> - **The ring field is weaker than its docstring reads** (a finding about the statement, harmless): any ring repeated in place makes every neighbour
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-planar-implementation.md 19.2 F-RING measured (done-means 4), and for the coordinator

What IP5 handed back, and the rulings that launch you:

> 332. **FS131-IP5 handed back** (Stage 19 SAVED, harness ≈ 472k by the task notice; record `fs131-w5p`'s `plans/FS131-planar-implementation.md`, Stages 16–19;
> — source: plans/FS131-close-inventory.md

> 333. **Rulings on IP5's held items, and its slot.** (a) **RING-LIST gets its own planner first, FS131-RL1** (de Bruijn's planner, on `fs131-w5p`), then an
> — source: plans/FS131-close-inventory.md

The definition of a hole, and the filled graph's separation field, as ruled:

> 277. **Ruling on item 276: adopt KP's `IsHoleOf`; KP may rewrite `exists_holed_valid_fragment`'s proof.** Choice: the separated-part definition as sent; KP's
> — source: plans/FS131-close-inventory.md

> 309. **Ruling on item 308: `PlanarLike` gains the field `finSep`, as proposed.** Choice: (a) the field added to `PlanarLike` (KP's foreseen shape: "if T-GRAPH
> — source: plans/FS131-close-inventory.md

What a planner on this branch may change (KP's plan):

> **May:** add children (with spec examples; shared ones in `PlaneTopology` / `MapTopology`), change imports (updating `ARCHITECTURE.md`'s
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-planar-kernel-plan.md 5.2 What the implementer may and may not change

## Done means

1. **Your readback first**: check every quotation above against its source; read IP5's Stages 17–19, KP's plan §§ 3–5, and `Plane/CurveGraph`, `MapTopology`'s
   `orient` and the crossing lemma's statements; build the branch once as given (`b6f9e761`); restate in your record what you are planning and what you may
   change. Commit and push.
2. **The route**: which walk — around the outer frontier of `x̂` and the frontiers of its non-hole bounded complementary components, joined at pinch points, as
   the docstring plans, or another — over which held tools (the finite boundary graph's local stars, `orient`, the crossing lemma, CHAIN and J of IP5's Stage
   18); what Mathlib has, confirmed with `#check`; an adversary or two (a tile whose neighbour appears twice; a tile with a non-hole pocket) checked against
   the statement on paper.
3. **The skeleton**: `filledGraph_ringList` reduced to named children with `sorry` at each, building through the worktree's `./scripts/build.sh` with only
   `sorry` warnings; `Proofs.lean`, `ARCHITECTURE.md` (`tools/check_architecture.py` exit 0) and `scripts/Axioms.lean` updated; `PlanarLike`'s docstring note.
   No statement other than your new children's changes; no new `axiom`, no `native_decide`.
4. **Your record**, `plans/FS131-ringlist-kernel-plan.md`: a plan per child (route, Mathlib lemmas confirmed with `#check`, what is hard, a price), the
   obligation-modeling pass (`debruijn-obligation-modeling`, invoked fresh), and a handoff for the implementer — with whether a second implementer could take
   a disjoint part. A child you can prove in about an hour, prove, and say so.
5. The report, in standing rule 11's form. You do not merge into `fs131-w5`, take `main` into this branch, run the gate, or touch `main`. Stopping at a saved
   stage with what is left named is a good report.

## What is yours to decide

The route, the cut into children, their names and where they live within your touches, and whether the walk is better built as a list or read off the finite
boundary graph. Formalize any outside fact under about an hour of agent work; else an `axiom` with `LEAN.md` § Assumptions' four items — never one of our own
hand results. If `filledGraph_ringList` is false for some valid plane map, that is a finding: message me at once with the smallest counterexample. You start
no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence. The
worktree's `.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`.

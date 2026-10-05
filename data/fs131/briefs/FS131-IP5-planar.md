# Brief FS131-IP5 — the planar infrastructure, finished: the filled graph's five fields, the two adversaries and F-RING on `fs131-w5p`

*Written 2026-10-05 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IP5
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the planar infrastructure's fifth implementer — continue FS131-IP4's work on `fs131-w5p` from its Stage 15, in item 325's order, saving after each leaf
  launch: at the next slot to free (inventory item 325), beside the jobs still running then (of FS131-WL1, Woodall's landing on `fs131-ww`; FS131-I5g, wave 5's non-`Terminal` half on `fs131-w5`; FS131-I5h, wave 5's `Terminal` half on `fs131-w5c`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-IP5.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-planar-implementation.md` (on branch `fs131-w5p`; you append stages from Stage 16)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p` (branch `fs131-w5p`): `Proofs/HadwigerNelson/Plane/ValidMap/MapGraph.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/MapTopology.lean`, `Proofs/HadwigerNelson/Plane/CurveGraph.lean`; in `Proofs/HadwigerNelson/Plane/ValidMap/BaseWalk.lean` only the three docstrings item 324 names (no statement, no proof); `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (the block headed "FS131-KP", which you extend, above the `=== PURCHASED ===` banner), `plans/FS131-planar-implementation.md`, `tools/fs131_ip_*.py`, `data/fs131/ip/`, `data/fs131/reports/FS131-IP5.md`; **not** `Proofs/HadwigerNelson/Plane/PlaneTopology.lean` (held, finished), not `Proofs/HadwigerNelson/Thomassen.lean` (held, FS131-IT1's), not `Proofs/HadwigerNelson/Plane/ValidMap/BaseDense.lean` (its three `sorry` are wave 5's lane), and not FS131-KP's plan file
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read your token count at every saved stage, so the line is not crossed inside a long leaf with nothing saveable

Hello. You are finishing the plane topology that wave 5 of the Lean backlog needs. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones; waves 1–4 are on `main`, and wave 5 (termination and density) is being proved on `fs131-w5` and `fs131-w5c`. Its planar leaves were
planned on this branch by FS131-KP, and four implementers have proved all but eight: the plane's unicoherence and the frontier lemma, both clauses of the
pinch-and-hole theorem, E4-OUTERMOST and E4-RIM, the crossing lemma, the boundary graph as a handshake, `exists_far_end`, and — FS131-IP4, just handed back —
one-sidedness (`orient`), the D-cut at a circle point (`circ_local`), `endpoint_of_far_end` and both `retArcs` leaves; T-GRAPH (Thomassen's reduction, the graph
side) is merged here and held. What is left is all in `MapGraph`: the filled graph's five fields, the two hole adversaries, and F-RING.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and wave 5 cannot
land with these open. This chain is still the longest path to wave 5's landing. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

Every `sorry` left on `fs131-w5p` at `aa753bb1` in `MapGraph` — `not_isHoleOf_chain`, `isHoleOf_cluster`, `filledGraph_locallyFinite` (F-LOC),
`filledGraph_connected` (F-CONN), `filledGraph_infinite` (F-INF), `filledGraph_rings` (F-RING), `filledGraph_oneInf` (F-ONE), `filledGraph_finSep` (F-SEP) —
each read back in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-planar-kernel-plan.md` §§ 3.2 and 4.1 (F-SEP in its own docstring, one mind). What IP4 handed back, and the ruling that launches you:

> 324. **FS131-IP4 handed back** (Stage 15 SAVED, harness ≈ 699k by the task notice — past its 500k line; budgets are guidance, so not a slip, though IP4 named it
> — source: plans/FS131-close-inventory.md

> 325. **Ruling on IP4's slot: not refilled** (item 323: the first slot to free stays empty). In flight: 1 (WL1) + 1 (I5g) + 1 (I5h) = 3, at the cap. **Queue for
> — source: plans/FS131-close-inventory.md

(item 324 names the three `BaseWalk` docstrings to fix; item 325 is your order). IP4's paper routes for the successor (one mind, not formalized) — read the
section in full:

> - **F-INF and F-CONN** read one lemma: *every point of the plane lies in the closure of an outer tile*. `exists_outermost` (E4-OUTERMOST steps 1–2, held)
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-planar-implementation.md 15.3 Leaves left (named), and for the coordinator (done-means 4)

> - **F-LOC**: `fill x ⊆ B̄(p, 1)` (as above), so a neighbour's filled closure meets `B̄(p, 1)` and its tile meets `B̄(p, 3)`; `finite_tiles_closure_inter`.
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-planar-implementation.md 15.3 Leaves left (named), and for the coordinator (done-means 4)

> - **The two adversaries** both need `(cl T)ᶜ ⊆ (B̄(0,1))ᶜ ∪ B(c₁, ¼) ∪ B(c₂, ¼)` for `T = B(0, 1) ∖ (B̄(c₁, ¼) ∪ B̄(c₂, ¼))` (every other point is a limit of
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-planar-implementation.md 15.3 Leaves left (named), and for the coordinator (done-means 4)

> - **F-RING: not reached, not measured** (done-means 4 asks for a measurement from its first child; I have none to give). One observation for the
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-planar-implementation.md 15.3 Leaves left (named), and for the coordinator (done-means 4)

The field F-SEP proves, as ruled:

> 309. **Ruling on item 308: `PlanarLike` gains the field `finSep`, as proposed.** Choice: (a) the field added to `PlanarLike` (KP's foreseen shape: "if T-GRAPH
> — source: plans/FS131-close-inventory.md

The definition of a hole, which both adversaries read:

> 277. **Ruling on item 276: adopt KP's `IsHoleOf`; KP may rewrite `exists_holed_valid_fragment`'s proof.** Choice: the separated-part definition as sent; KP's
> — source: plans/FS131-close-inventory.md

KP's plan, which still governs the order within each step and what you may change:

> **Work order** (each step unblocks the next; re-price after the first two):
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-planar-kernel-plan.md 5.1 Where it is, and how the implementer works

> **May:** add children (with spec examples; shared ones in `PlaneTopology` / `MapTopology`), change imports (updating `ARCHITECTURE.md`'s
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-planar-kernel-plan.md 5.2 What the implementer may and may not change

## Done means

1. **Your readback first**: check every quotation above against its source; read the record's Stages 12–15 and KP's plan §§ 3–5; build the branch once as given
   (`aa753bb1`) before editing anything; open Stage 16 in the record with what you may and may not change. Commit and push.
2. **The order**: F-INF and F-CONN over their shared lemma (every point lies in the closure of an outer tile); F-LOC; F-ONE and F-SEP; `not_isHoleOf_chain` and
   `isHoleOf_cluster`; F-RING. Save after each leaf; re-price in the record after the first two. Fix the three `BaseWalk` docstrings at your first build.
3. No statement changed, no new `axiom`, no `native_decide`; nothing edited in `Plane/PlaneTopology`, `Thomassen` or `BaseDense`. Do not edit a file while a
   build of it runs.
4. **For the coordinator**: measure F-RING from its first child, and say whether it deserves its own job, and what a second implementer could take beside you
   without sharing a file.
5. **Your record**, stages headed "Stage n — SAVED", "Theorems this phase proved", each with its build log and an axioms receipt checked by
   `tools/fs131_ip_axioms.py`; the report in standing rule 11's form. You do not merge into `fs131-w5`, take `main` into this branch, run the gate, or touch
   `main` — the merge back into `fs131-w5` happens on my word. Stopping at a saved stage with leaves left, named, is a good report.

## What is yours to decide

The proofs, their children and order within the order's dependencies, and where a shared child lives (`MapTopology` or `CurveGraph`). If a leaf cannot be
proved as written, stop that leaf, message me at once with the declaration, the reason, and the smallest counterexample or the missing hypothesis, and go on
with the others. If a later leaf turns out cheaper to take first, take it and say so in the record. IP4's routes are sketches by one mind: a better route is
yours to take. Three failed attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own
(standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; three agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) under a small slot is for iteration only, never
evidence. The worktree's `.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`.

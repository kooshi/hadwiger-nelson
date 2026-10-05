# Brief FS131-IP3 — the planar infrastructure, continued: the boundary graph, the far end, and the filled graph on `fs131-w5p`

*Written 2026-10-05 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IP3
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the planar infrastructure's third implementer — continue FS131-IP2's work on `fs131-w5p` from its Stage 8, in ruling 293 (b)'s remaining order (item 301), saving after each leaf
  launch: now, beside FS131-G4 (wave 4's landing, on `fs131-w4`), FS131-IX1 (the crossing lemma, on `fs131-w5x`) and FS131-I5e (wave 5's other leaves, on `fs131-w5`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, an orientation step that needs more than the crossing lemma gives, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-IP3.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-planar-implementation.md` (on branch `fs131-w5p`; you append stages from Stage 9)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p` (branch `fs131-w5p`): `Proofs/HadwigerNelson/Plane/ValidMap/MapTopology.lean`; in `Proofs/HadwigerNelson/Plane/ValidMap/MapGraph.lean` everything outside the `namespace HadwigerNelson.Thomassen` block (which a later job moves to its own module); in `Proofs/HadwigerNelson/Plane/ValidMap/BaseWalk.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/BaseDense.lean` only the declarations FS131-KP's plan § 5.1 lists and children beside them; a new module for the boundary graph if you choose one (importing nothing under `Plane/PlaneTopology` beyond what `MapTopology` imports); `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (the block headed "FS131-KP", which you extend, above the `=== PURCHASED ===` banner), `plans/FS131-planar-implementation.md`, `tools/fs131_ip_*.py`, `data/fs131/ip/`, `data/fs131/reports/FS131-IP3.md`; **not** `Proofs/HadwigerNelson/Plane/PlaneTopology.lean` (FS131-IX1's) and not FS131-KP's plan file
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are continuing the plane topology that wave 5 of the Lean backlog needs. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones; waves 1–3 are on `main`, wave 4 is landing now, and wave 5 (termination and density) is being proved on `fs131-w5` — all but seven
leaves that share plane topology Mathlib does not have, planned on this branch by FS131-KP. FS131-IP1 proved the foundation (unicoherence of the plane and
the frontier lemma) and both clauses of the pinch-and-hole theorem; FS131-IP2 proved E4-OUTERMOST whole and E4-RIM (up to `noBoth`, proved on wave 4's
branch and arriving with it), answered the 60° question yes, and showed that points with three tiles in their closure are isolated — which makes the
boundary graph's vertex set in a compact disc finite. You build the boundary graph and finish the chain; the crossing lemma runs beside you in its own tree.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and wave 5 cannot
land with these open. This chain is the longest path to wave 5's landing. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

Every `sorry` left on `fs131-w5p` at `02e85433` in the files your touches name, each read back in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-planar-kernel-plan.md` §§ 3.2 and 4.1. What IP2 handed back, and the
ruling that launched you:

> 300. **FS131-IP2 handed back** (Stage 8 SAVED, harness ≈ 460k by the task notice; record `fs131-w5p`'s `plans/FS131-planar-implementation.md`, Stages 6–8;
> — source: plans/FS131-close-inventory.md

> 301. **Ruling: IP2's slot → FS131-IP3 on `fs131-w5p`, the planar chain continued.** Choice: IP3 takes ruling 293 (b)'s remaining order — BG with PATH,
> — source: plans/FS131-close-inventory.md

The order you continue, from the ruling that split the chain:

> 293. **Rulings on IP1's held items, and its slot.** (a) The last exit's `hK`, `hR` → `_hK`, `_hR` **accepted** (rulings 185, 281 (a): a binder name is not part
> — source: plans/FS131-close-inventory.md

(its part (b); IP2 has done its first three leaves). IP2's re-price, and its two route findings for `endpoint_of_far_end` — read § 7.4 in full:

> Both leaves closed on iteration in well under a session's tenth each once the shared child (`exists_far_side`) existed; the child itself (≈ 130
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-planar-implementation.md 7.3 Re-priced after the first two leaves

> 1. `exists_far_end`'s second disjunct, `q ≠ r(θ) ∧ dist q u = 1`, also admits **spike touches** (CE's SPIKE and spike corners: the `a|c` boundary
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-planar-implementation.md 7.4 The 60° question (brief, done-means 3), read before `endpoint_of_far_end`

> 2. At a genuine exit `q = r(φ)`, `IsRetArc` needs the germs' pseudo-colours in the right orientation (`c` inside `[θ, φ]` at both ends): CD's step 2
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-planar-implementation.md 7.4 The 60° question (brief, done-means 3), read before `endpoint_of_far_end`

KP's plan, which still governs the order within each step and what you may change:

> **Work order** (each step unblocks the next; re-price after the first two):
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-planar-kernel-plan.md 5.1 Where it is, and how the implementer works

> **May:** add children (with spec examples; shared ones in `PlaneTopology` / `MapTopology`), change imports (updating `ARCHITECTURE.md`'s
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-planar-kernel-plan.md 5.2 What the implementer may and may not change

The definition of a hole, as ruled:

> 277. **Ruling on item 276: adopt KP's `IsHoleOf`; KP may rewrite `exists_holed_valid_fragment`'s proof.** Choice: the separated-part definition as sent; KP's
> — source: plans/FS131-close-inventory.md

## Done means

1. **Your readback first**: check every quotation above against its source; read the record's Stages 5–8 and KP's plan §§ 3–5; build the branch once as given
   (`02e85433`) before editing anything; open Stage 9 in the record with what you may and may not change. Commit and push.
2. **The order of item 301**: BG with PATH; `exists_far_end` with a strong child returning an odd vertex of the boundary graph (IP2's finding 1); then
   `endpoint_of_far_end` (finding 2's orientation step — by the crossing lemma cited as given, or any route you find; if it needs more than the crossing lemma
   gives, message me); F-LOC/CONN/INF/ONE; `not_isHoleOf_chain` and `isHoleOf_cluster`; F-RING; `retArcs_not_abut`, then `retArcs_not_interleaved` over the
   crossing lemma as given. Save after each leaf; re-price in the record after the first two.
3. No statement changed, no new `axiom`, no `native_decide`; nothing edited in `Plane/PlaneTopology` or inside the `HadwigerNelson.Thomassen` block. Do not edit
   a file while a build of it runs.
4. **For the coordinator**: once BG exists, record whether the crossing lemma's route (b) through BG is then cheap; measure F-RING from its first child.
5. **Your record**, stages headed "Stage n — SAVED", "Theorems this phase proved"; the report in standing rule 11's form. You do not merge into `fs131-w5`, take
   `main` into this branch, run the gate, or touch `main`. Stopping at a saved stage with leaves left, named, is a good report.

## What is yours to decide

The proofs, their children and order within the ruled order's dependencies, where the boundary graph lives (`MapTopology`, `MapGraph` outside the `Thomassen`
block, or a new module), and the orientation step's route. If a leaf cannot be proved as written, stop that leaf, message me at once with the declaration, the
reason, and the smallest counterexample or the missing hypothesis, and go on with the others. If a later leaf in the order turns out cheaper to take first, take
it and say so in the record. Three failed attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your
own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; four agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) under a small slot is for iteration only, never
evidence. The worktree's `.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`.

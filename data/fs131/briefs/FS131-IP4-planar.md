# Brief FS131-IP4 — the planar infrastructure, continued: PATH, the far end's endpoint, the two `retArcs`, and the filled graph on `fs131-w5p`

*Written 2026-10-05 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IP4
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the planar infrastructure's fourth implementer — continue FS131-IP3's work on `fs131-w5p` from its Stage 11, in item 313's order, saving after each leaf
  launch: now, beside FS131-G4 (wave 4's landing, on `fs131-w4`), FS131-IT1 (T-GRAPH, on `fs131-w5t`) and FS131-I5f (wave 5's non-`Terminal` half, on `fs131-w5`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, an orientation step no route you find closes, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-IP4.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-planar-implementation.md` (on branch `fs131-w5p`; you append stages from Stage 12)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p` (branch `fs131-w5p`): `Proofs/HadwigerNelson/Plane/ValidMap/MapTopology.lean`, `Proofs/HadwigerNelson/Plane/CurveGraph.lean`; in `Proofs/HadwigerNelson/Plane/ValidMap/MapGraph.lean` everything outside the `namespace HadwigerNelson.Thomassen` block (FS131-IT1 moves it to its own module, and adds `filledGraph_finSep` beside `filledGraph_oneInf` on its branch — leave the lines between `filledGraph_oneInf` and `filledGraph_planarLike` as they are); in `Proofs/HadwigerNelson/Plane/ValidMap/BaseWalk.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/BaseDense.lean` only the declarations FS131-KP's plan § 5.1 lists and children beside them; `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (the block headed "FS131-KP", which you extend, above the `=== PURCHASED ===` banner), `plans/FS131-planar-implementation.md`, `tools/fs131_ip_*.py`, `data/fs131/ip/`, `data/fs131/reports/FS131-IP4.md`; **not** `Proofs/HadwigerNelson/Plane/PlaneTopology.lean` (held, finished) and not FS131-KP's plan file
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k — read the harness's count, not your own

Hello. You are continuing the plane topology that wave 5 of the Lean backlog needs. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones; waves 1–3 are on `main`, wave 4 is landing now, and wave 5 (termination and density) is being proved on `fs131-w5`. Its seven planar
leaves were planned on this branch by FS131-KP. So far: the plane's unicoherence and the frontier lemma (FS131-IP1), both clauses of the pinch-and-hole
theorem, E4-OUTERMOST and E4-RIM (IP1, FS131-IP2), the crossing lemma (FS131-IX1, merged here), and the boundary graph as a handshake with
`exists_far_end` (FS131-IP3) — `PlaneTopology`, `CurveGraph` and `MapTopology` now have no `sorry`. What is left is PATH, the far end's endpoint, the
two `retArcs`, and the filled graph's four fields, the adversaries and F-RING; the graph theory of Thomassen's reduction runs beside you on `fs131-w5t`.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and wave 5 cannot
land with these open. This chain is still the longest path to wave 5's landing. Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

Every `sorry` left on `fs131-w5p` at `7b5e8ed6` in the files your touches name, each read back in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-planar-kernel-plan.md` §§ 3.2 and 4.1. What IP3 handed back, and the
ruling that launched you:

> 312. **FS131-IP3 handed back** (Stage 11 SAVED, harness ≈ 557k by the task notice — past its 500k line, at the first saved stage after it noticed; record
> — source: plans/FS131-close-inventory.md

> 313. **Rulings on IP3's held items, and its slot.** (a) `exists_far_end`'s `hF` → `_hF` **accepted** (rulings 185, 281 (a)). (b) **IP3's slot → FS131-IP4 on
> — source: plans/FS131-close-inventory.md

(its part (b) is your order). IP3's re-price, with its route for the orientation step, and IP2's finding it answers — read both sections in full:

> Wall clock from stage 10's commit (02:06Z) to this stage (02:44Z): about 40 minutes, about 1,770 lines (`CurveGraph` 1,199, `MapTopology` + 572), one
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-planar-implementation.md 11.3 Re-priced after the first two leaves (BG, `exists_far_end`)

> 2. At a genuine exit `q = r(φ)`, `IsRetArc` needs the germs' pseudo-colours in the right orientation (`c` inside `[θ, φ]` at both ends): CD's step 2
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-planar-implementation.md 7.4 The 60° question (brief, done-means 3), read before `endpoint_of_far_end`

IP2's other finding — the far end re-selected as an odd vertex of the boundary graph — is item 300's (1):

> 300. **FS131-IP2 handed back** (Stage 8 SAVED, harness ≈ 460k by the task notice; record `fs131-w5p`'s `plans/FS131-planar-implementation.md`, Stages 6–8;
> — source: plans/FS131-close-inventory.md

The filled graph gains a field on IT1's branch (you do not prove it; it arrives when that branch merges):

> 309. **Ruling on item 308: `PlanarLike` gains the field `finSep`, as proposed.** Choice: (a) the field added to `PlanarLike` (KP's foreseen shape: "if T-GRAPH
> — source: plans/FS131-close-inventory.md

KP's plan, which still governs the order within each step and what you may change:

> **Work order** (each step unblocks the next; re-price after the first two):
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-planar-kernel-plan.md 5.1 Where it is, and how the implementer works

> **May:** add children (with spec examples; shared ones in `PlaneTopology` / `MapTopology`), change imports (updating `ARCHITECTURE.md`'s
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-planar-kernel-plan.md 5.2 What the implementer may and may not change

The definition of a hole, as ruled:

> 277. **Ruling on item 276: adopt KP's `IsHoleOf`; KP may rewrite `exists_holed_valid_fragment`'s proof.** Choice: the separated-part definition as sent; KP's
> — source: plans/FS131-close-inventory.md

## Done means

1. **Your readback first**: check every quotation above against its source; read the record's Stages 6–11 and KP's plan §§ 3–5; build the branch once as given
   (`7b5e8ed6`) before editing anything; open Stage 12 in the record with what you may and may not change. Commit and push.
2. **The order of item 313 (b)**: PATH and the strong child of `exists_far_end` (an odd vertex); `endpoint_of_far_end` (the orientation step by IP3's route or
   another; the bi–bi exclusion of a chord exactly 1); `retArcs_not_interleaved` and `retArcs_not_abut`; F-LOC/CONN/INF/ONE; `not_isHoleOf_chain` and
   `isHoleOf_cluster`; F-RING. Save after each leaf; re-price in the record after the first two.
3. No statement changed, no new `axiom`, no `native_decide`; nothing edited in `Plane/PlaneTopology`, inside the `HadwigerNelson.Thomassen` block, or between
   `filledGraph_oneInf` and `filledGraph_planarLike`. Do not edit a file while a build of it runs.
4. **For the coordinator**: measure F-RING from its first child, and say whether it deserves its own job.
5. **Your record**, stages headed "Stage n — SAVED", "Theorems this phase proved"; the report in standing rule 11's form. You do not merge into `fs131-w5`, take
   `main` into this branch, run the gate, or touch `main`. Stopping at a saved stage with leaves left, named, is a good report.

## What is yours to decide

The proofs, their children and order within the ruled order's dependencies, where PATH lives (`CurveGraph` or `MapTopology`), and the orientation step's route.
If a leaf cannot be proved as written, stop that leaf, message me at once with the declaration, the reason, and the smallest counterexample or the missing
hypothesis, and go on with the others. If a later leaf in the order turns out cheaper to take first, take it and say so in the record. Three failed attempts on
one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level deep,
because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; four agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) under a small slot is for iteration only, never
evidence. The worktree's `.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`.

## Amendment, 2026-10-05 — T-GRAPH is held; merge its branch, and F-SEP joins your order (inventory items 314–315)

FS131-IT1 proved `reduced_props_of_planarLike` on `fs131-w5t` (`5604b532`), with `PlanarLike`'s new field `finSep`, and stated the map-side leaf
`ArcMap.filledGraph_finSep` (F-SEP) in `MapGraph` beside `filledGraph_oneInf`. The ruling:

> 315. **Rulings on IT1's held items, and its slot.** (a) **The merge**: FS131-IP4 merges `fs131-w5t` (at `5604b532`) into `fs131-w5p` at its next saved stage —
> — source: plans/FS131-close-inventory.md

For you: at your next saved stage, `git merge fs131-w5t` into `fs131-w5p` (keep both sides where IT1's `MapGraph` hunks — the import, the moved block's
deletion, `filledGraph_finSep` and the constructor line — meet yours; one import line in `Proofs.lean`, one block each in `scripts/Axioms.lean`, IT1's
`Thomassen` row and amended `MapGraph` row in `ARCHITECTURE.md`), fix `MapGraph`'s module docstring where it says the pure graph theory lives there, build,
and record it as its own stage. Then F-SEP is in your order beside F-LOC/CONN/INF/ONE, its sketch in its docstring (one mind). Your touches extend to the
merge's files and to `filledGraph_finSep`; the lines between `filledGraph_oneInf` and `filledGraph_planarLike` are now yours. You start no agents of your own
(standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).

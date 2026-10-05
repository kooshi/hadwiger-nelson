# Brief FS131-IP2 — the planar infrastructure, continued: the map-level leaves on `fs131-w5p` (`MapTopology`, `MapGraph` outside its `Thomassen` block, `BaseWalk`, `BaseDense`)

*Written 2026-10-05 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IP2
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the planar infrastructure's second implementer — continue FS131-IP1's work on `fs131-w5p` from its Stage 5, on the map-level leaves in the order ruled below, saving after each leaf
  launch: now, beside FS131-I4n (wave 4, on `fs131-w4`), FS131-IMM1 (wave 4's MERGE, on `fs131-w4mm`) and FS131-I5d (wave 5's other leaves, on `fs131-w5`), each in its own tree; a crossing-lemma job (FS131-IX1) will take the next free slot in its own tree, on `Plane/PlaneTopology` only
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, the answer to the 60° question below if it is no, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-IP2.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-planar-implementation.md` (IP1's record on branch `fs131-w5p`; you append stages from Stage 6)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p` (branch `fs131-w5p`): `Proofs/HadwigerNelson/Plane/ValidMap/MapTopology.lean`; in `Proofs/HadwigerNelson/Plane/ValidMap/MapGraph.lean` everything outside the `namespace HadwigerNelson.Thomassen` block (lines 36–595 at `01011037`, which a later job moves to its own module); in `Proofs/HadwigerNelson/Plane/ValidMap/BaseWalk.lean`, `Proofs/HadwigerNelson/Plane/ValidMap/BaseDense.lean` only the declarations FS131-KP's plan § 5.1 lists and children beside them; `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (the block headed "FS131-KP", which you extend, above the `=== PURCHASED ===` banner), `plans/FS131-planar-implementation.md`, `tools/fs131_ip_*.py`, `data/fs131/ip/`, `data/fs131/reports/FS131-IP2.md`; **not** `Proofs/HadwigerNelson/Plane/PlaneTopology.lean` (FS131-IX1's) and not FS131-KP's plan file
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are continuing the plane topology that wave 5 of the Lean backlog needs. The milestone, FS-131, turns this project's hand-derived results into
kernel-checked ones; waves 1–3 are landed on `main`, wave 4 is being finished, and wave 5 (termination and density) is being proved on `fs131-w5` — all but
seven leaves that share plane topology Mathlib does not have. FS131-KP planned those seven on this branch; FS131-IP1, the first implementer, proved
unicoherence of the plane from Mathlib's covering-space lifting theorem, the frontier lemma, both clauses of the pinch-and-hole theorem, and 28 more
declarations, all on the standard three axioms, and handed back at a saved Stage 5 with the leaves left named and priced. You pick up from there.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`), and wave 5 cannot
land with these open. This chain is the longest path to wave 5's landing, so it is now split three ways: you take the map-level leaves; the crossing lemma (the
only leaf left in `Plane/PlaneTopology`) goes to its own job in its own tree; the pure graph theory of Thomassen's reduction (T-GRAPH) goes to a later job.
Kooshi, on pricing this work:

> Do not consider Lean formalization a cost. It's practically mechanical for us, it's just a matter of time.
> — source: CLAUDE.md § Counter-priors — read before pricing anything (Kooshi, 2026-09-26)

## The statements

Every `sorry` left on `fs131-w5p` at `01011037` in the files your touches name, each read back in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-planar-kernel-plan.md` §§ 3.2 and 4.1, and listed by IP1:

> 292. **FS131-IP1 done** (harness ≈ 394k; record `fs131-w5p`'s `plans/FS131-planar-implementation.md`, stages 1–5 SAVED; report `data/fs131/reports/FS131-IP1.md`;
> — source: plans/FS131-close-inventory.md

(the item continues there with the receipt, the leaves left and the re-price). The ruling that launched you, with your order:

> 293. **Rulings on IP1's held items, and its slot.** (a) The last exit's `hK`, `hR` → `_hK`, `_hR` **accepted** (rulings 185, 281 (a): a binder name is not part
> — source: plans/FS131-close-inventory.md

(its part (b) is your work order; (c) and (d) are the jobs beside you). IP1's record — read it in full; its Stage 5 is your starting point. Its price for your
first leaf, and its worked argument for the second:

> | `unenclosed_of_rim_vertex` | 0.3 | `exists_sector_subset_tile` gives the three tiles; the one case needing geometry is `T' = Y` (the `T|X` branch near `v` misses `cl Y`: the sector of `Y` is bounded by the other two branches) — read `G.sector`'s definition first |
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-planar-implementation.md 5.3 Measured cost, and the chain re-priced

> If `T'` encloses `T` (`y ∈ T \ cl T'` in a bounded component `B'` of `(cl T')ᶜ`), then `T ≠ T'`, `T ⊆ B'`, and the unbounded component `W'`
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-planar-implementation.md 5.4 Worked on paper, for the successor (`exists_outermost`)

The crossing lemma is **not** yours; `retArcs_not_interleaved` cites it as given (it carries `sorryAx` until FS131-IX1's branch merges back), and IP1's note on
it is for your information only:

> `inter_nonempty_of_interleaved` (KP's H) is left for step 5. KP's sketch ("Phragmén–Brouwer from unicoherence … a line from infinity to
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-planar-implementation.md 2.3 The crossing lemma — a route question, not a statement question

KP's plan, which still governs the order within each step and what you may change:

> **Work order** (each step unblocks the next; re-price after the first two):
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-planar-kernel-plan.md 5.1 Where it is, and how the implementer works

> **May:** add children (with spec examples; shared ones in `PlaneTopology` / `MapTopology`), change imports (updating `ARCHITECTURE.md`'s
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w5p/plans/FS131-planar-kernel-plan.md 5.2 What the implementer may and may not change

The definition of a hole, as ruled:

> 277. **Ruling on item 276: adopt KP's `IsHoleOf`; KP may rewrite `exists_holed_valid_fragment`'s proof.** Choice: the separated-part definition as sent; KP's
> — source: plans/FS131-close-inventory.md

## Done means

1. **Your readback first**: check every quotation above against its source; read IP1's record in full and KP's plan §§ 3–5; build the branch once as given
   (`01011037`) before editing anything; open Stage 6 in the record with what you may and may not change. Commit and push.
2. **The order of ruling 293 (b)**: `unenclosed_of_rim_vertex`, `exists_outermost`, `exists_eleventh_of` (closing `exists_unenclosed_or_bad` and
   `exists_eleventh`); then the boundary graph BG with PATH, `exists_far_end`, and `endpoint_of_far_end`; F-LOC/CONN/INF/ONE; `not_isHoleOf_chain` and
   `isHoleOf_cluster`; F-RING after BG; `retArcs_not_abut`, then `retArcs_not_interleaved` over the crossing lemma as given. Save after each leaf; re-price in the
   record after the first two.
3. **The 60° question**, before `endpoint_of_far_end`: read FS110-CD Lemma E/R and FS110-CE R1–R4 (`plans/FS110-derivation.md` and the records it names) and
   record whether a two-colour exit returns within 60° of `r(θ)`; if it does not, stop that leaf and message me.
4. No statement changed, no new `axiom`, no `native_decide`; nothing edited in `Plane/PlaneTopology` or inside the `HadwigerNelson.Thomassen` block. Do not edit
   a file while a build of it runs.
5. **For the coordinator**: when BG exists, say in your record whether the crossing lemma's route (b) (through BG) is then cheap, so a stalled FS131-IX1 can be
   re-routed; and measure F-RING from its first child.
6. **Your record**, stages headed "Stage n — SAVED", "Theorems this phase proved"; the report in standing rule 11's form. You do not merge into `fs131-w5`, run
   the gate, or touch `main`. Stopping at a saved stage with leaves left, named, is a good report.

## What is yours to decide

The proofs, their children and order within the ruled order's dependencies, and where a shared child lives (`MapTopology`, or `MapGraph` outside the
`Thomassen` block). If a leaf cannot be proved as written, stop that leaf, message me at once with the declaration, the reason, and the smallest counterexample
or the missing hypothesis, and go on with the others. If a later leaf in the order turns out cheaper to take first, take it and say so in the record. Three
failed attempts on one route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation
is one level deep, because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; four agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) under a small slot is for iteration only, never
evidence. The worktree's `.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`.

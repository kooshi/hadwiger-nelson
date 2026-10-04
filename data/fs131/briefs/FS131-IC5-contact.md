# Brief FS131-IC5 — wave 4's `Contact`, continued: `stuck_structure`, on branch `fs131-w4c`

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IC5
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: wave 4's fifth `Contact` implementer — `stuck_structure`, `Contact`'s last leaf of its own (the moves are FS131-IM1's) (`flank_shadows`, the three moves, the stuck structure and chain), in its own worktree; then hand the branch over for merging into `fs131-w4`, saving after each; the gate and the landing when the last leaf is proved
  launch: now, beside FS131-I2n (wave 2), FS131-I4k (wave 4's `BaseSteps` and `UnitArc`, on `fs131-w4`) and FS131-IM1 (wave 4's moves, on `fs131-w4m`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-IC5.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IC-implementation.md` (on branch `fs131-w4c`; you continue it — standing rule 2's "Resuming"; `plans/FS131-I4-implementation.md` is FS131-I4i's)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4c` (branch `fs131-w4c`): `Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean`, supporting lemmas in a new module of your own if you need one (say `Proofs/HadwigerNelson/Plane/ValidMap/ContactAux.lean`, imported by `Contact`) and in the foundation `Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean` (statements unchanged; additions only), `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (your own block, headed "FS131-IC5"), `plans/FS131-IC-implementation.md`, `tools/fs131_ic_*.py`, `data/fs131/ic/`, `data/fs131/reports/FS131-IC5.md`; not `UnitArc`, `BaseSteps`, `SVMap` or `StuckChain`, which FS131-I4i edits on `fs131-w4`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are wave 4's fifth implementer on `Plane/ValidMap/Contact`, on Opus. Wave 4 is the valid-map machinery the frontier's local exclusion rests
on, split three ways: FS131-I4k works `BaseSteps` and `UnitArc` on `fs131-w4`; FS131-IM1 proves the three moves in a new module `Plane/ValidMap/Moves` on
`fs131-w4m`; and `Contact` is on `fs131-w4c`. The `Contact` implementers before you proved everything but `stuck_structure` and the moves — last, FS131-IC4
proved N4-FLANK (`flank_shadows`), so the shave criterion is sorry-free, and wrote out `stuck_structure`'s route. **Yours is `stuck_structure`**; leave the three
moves as `sorry` (they become citations of IM1's lemmas at the merge, on my word).

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`). Wave 4 now gates
Woodall's landing and wave 5's: your branch is half of what is left of it.

## The statements

`stuck_structure` in `Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean` on branch `fs131-w4c` at `addcfbf3` (4 `sorry` there; the other 3 are the moves), read back in
`.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md` §§ 3.2 and 7.2, planned in § 13, handoff § 14. What you may change:

> **It may**: add children anywhere in the wave's modules — the seven engines and every child § 13 names are expected additions (the engines in the
> — source: .claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md § 14.2 What the implementer may and may not change

Where IC4 left it:

> **`stuck_structure`, the route** (my reading for the successor; none changes a statement):
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4c/plans/FS131-IC-implementation.md ## Stage 12 — SAVED (FS131-IC4 stage 3): the hand-back

and its first step:

> 1. `stuck_horns` gives `H₊` (along `α`, `κ₁ < κ₂`), `H₋` (along `α + π`, `κ₃ < κ₄`), `HasSectors v c 2`, out-type `c` at `N` and `S′`. Flanks by
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4c/plans/FS131-IC-implementation.md ## Stage 12 — SAVED (FS131-IC4 stage 3): the hand-back

and the split of the moves:

> 236. **Ruling: `Contact` splits once more, when a slot frees** — the three moves (`exists_shave`, `exists_rayMerge`, `exists_merge`) to a parallel implementer in a
> — source: plans/FS131-close-inventory.md

(IC1's Stage 2 and IC2's Stage 5 notes still hold for the moves: `exists_shave`, the two merges — each needing a cut at `v`, every arc through `v` replaced by at most three pieces, since
`HasSectors` counts pieces and the plan's § 13.1 engine 3 claim that the moves never delete an arc is wrong for them).
`exists_shave` keeps its statement although it does not assume `g ≠ c` or `h ≠ c`: the case `g = c`, `σ < κ₂` needs the same cut (wave 5 applies SHAVE
wherever `ShaveAvailable` holds). The split:

> 194. **Ruling: wave 4 splits by file** (item 191's condition met: six leaves a session on wave 4's last two sessions, 39 left). Choice: the next wave-4 implementer
> — source: plans/FS131-close-inventory.md

The shared lemma `ringArcsWithin_of_Γ_subset` (engine 2) is written on `fs131-w4` by FS131-I4i (commit `3f7ea033`, `Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean` only; item 223): do not
write your own; when a move needs it, bring that exact hunk onto `fs131-w4c` (`git diff 3f7ea033~1 3f7ea033 -- Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean |
git apply`, then build), so the two copies are identical at the merge. Engines
the others built that you may want: the ray engine `eventually_ray_not_mem_hornSet` / `IsSector.disjoint_of_rays` (`BaseSteps`) and
`ArcMap.Valid.dist_ne_one_of_isOpen_subset_closure` (`UnitArc`). `stuck_structure` assumes Condition 5 (FS110-NB-4's conclusion, a named hypothesis, wave 4's
plan § 14.5): keep it so.

## Done means

1. **Your readback first**: check the four quotations against their sources; build the branch once as given (`addcfbf3`) before editing anything; restate
   in your record what you may and may not change. Commit and push.
2. **`stuck_structure`** by IC4's route (Stage 12; `g ≠ h` from `shadow_of_tangent_sector_S/_N`, not from `flank_shadows`' statement), saving after each; no statement changed, no new `axiom`, no `native_decide`; re-price from your first two hard leaves. Do not edit a file while a
   build of it runs.
3. **The handover**: when `stuck_structure` is proved (or at your hand-back line), your record's last stage says what is proved and what is left, with the build log and
   an axioms print against that build's oleans. You do not merge into `fs131-w4` or run wave 4's gate: whichever of you and FS131-I4i finishes second does
   that, on my word, so the two branches never race. Never push to `main`.
4. **Your record**, stages headed "Stage n — SAVED", "Theorems this phase proved"; the report in standing rule 11's form. Stopping at a saved stage with leaves
   left, and naming them, is a good report.

## What is yours to decide

The proofs, their children and order, and where a supporting lemma lives (the carriers and the gate are the merging implementer's). If a leaf cannot be
proved as written, stop that leaf, message me at once with the declaration, the reason, and the smallest counterexample or the missing hypothesis, and go
on with the others: implementers on this milestone have already found several statements that needed a hypothesis the hand derivation hid, and each was a correction to the record. Three failed attempts
on one route is a dispatch to the companion your identity names, never a fourth.

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them (inventory ruling 5), and
several trees are building today, so on exit 75 wait ten minutes and retry. `lake env lean` (with § 14.1's flags) is for iteration only, never evidence.
The worktree's `.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`. You start no agents of your own
(standing rule 1).

## Amendment 2026-10-04 (Keryx) — `stuck_structure`'s sides clause, ruled

Your finding is logged as `plans/FS131-close-inventory.md` item 251 and ruled in item 252: replace the sides clause of `stuck_structure` with form (b),
`(‖z − v‖ ^ 2 / 2 < frameY v α z → F.col z = g) ∧ (frameY v α z < -(‖z − v‖ ^ 2 / 2) → F.col z = h)` under the same `∀ᶠ ρ in 𝓝[>] 0, ∀ z ∈ F.interiorPts ∩ ball v ρ`,
with the docstring's sentence "the interior points near `v` above the axis of colour `g` or `c` and below it of colour `h` or `c`" rewritten to match and
citing item 252; record the change, the counterexample shape (`κ₂ < 0`) and the derivation's directional wording (`plans/FS110-N-proof.md` l. 846) in your record.
Your lemmas for forms (a) and (b) are welcome as children. Do not edit wave 5's `stuck_structure_ua` (another branch; its implementer applies the same ruling).
No other statement changes; you still start no agents of your own (standing rule 1: delegation is one level deep, because the coordinator can only review work
it knows exists).

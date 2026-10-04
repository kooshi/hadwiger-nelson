# Brief FS131-IM1 — wave 4's three moves (`exists_shave`, `exists_rayMerge`, `exists_merge`), in a module of their own upstream of `Contact`

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IM1
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: prove wave 4's three simplifying moves under their exact statements, as `…_aux` lemmas in a new module `Plane/ValidMap/Moves` upstream of `Contact`, on branch `fs131-w4m`; then hand the branch over for merging
  launch: now, beside FS131-I2n (wave 2), FS131-I4k (wave 4's `BaseSteps` and `UnitArc`, on `fs131-w4`) and FS131-IC4 (wave 4's `Contact`, on `fs131-w4c`), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a move that cannot be proved as written, a `Contact` lemma a move turns out to need, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-IM1.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IM-implementation.md` (new, on branch `fs131-w4m`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4m` (branch `fs131-w4m`): a new module `Proofs/HadwigerNelson/Plane/ValidMap/Moves.lean` (importing what `Contact` imports — `Plane/ValidMap/Basic`, `Plane/Tiles`, `Plane/SVMap` — and never `Contact`), additions to `Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean` (engine 2's exact hunk, and supporting lemmas, statements unchanged), `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (your own block, headed "FS131-IM1"), `plans/FS131-IM-implementation.md`, `tools/fs131_im_*.py`, `data/fs131/im/`, `data/fs131/reports/FS131-IM1.md`; **not** `Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean` (FS131-IC4's) nor wave 4's other modules
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are joining wave 4 of the Lean backlog, the valid-map machinery the frontier's local exclusion rests on, on Opus. 72 of its 86 leaves are proved.
It is split by file: FS131-I4k works `BaseSteps` and `UnitArc` on `fs131-w4`; FS131-IC4 works `Contact` on `fs131-w4c` (it has just proved `flank_shadows`;
`stuck_structure` is next). `Contact`'s last three leaves are the simplifying moves — SHAVE, MERGE-RAY and MERGE, each about a session — and they read nothing of
`Contact`'s own: their availability predicates (`ShaveAvailable`, `RayAvailable`, `MergeAvailable`) live in the foundation `Plane/ValidMap/Basic`. So I have split
them off to you, in a module upstream of `Contact`, so they run beside IC4 instead of after it. Your branch `fs131-w4m` starts from `fs131-w4c` at `d4f946ae`.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`). Wave 4 gates Woodall's
landing and wave 5's, and `Contact` is its longest path; the moves are three of its four remaining leaves.

## The statements

The three are `exists_shave`, `exists_rayMerge`, `exists_merge` in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4m/Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean` (lines 4019, 4033, 4049 at
`d4f946ae`), read back in `.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md` §§ 3.2 and 7.2, planned in § 13. You prove each under its **exact**
statement, copied by script into `Moves` as `exists_shave_aux`, `exists_rayMerge_aux`, `exists_merge_aux` (hypotheses, binders and conclusion verbatim); at the
merge, `Contact`'s three leaves become one-line citations of them. The ruling:

> 236. **Ruling: `Contact` splits once more, when a slot frees** — the three moves (`exists_shave`, `exists_rayMerge`, `exists_merge`) to a parallel implementer in a
> — source: plans/FS131-close-inventory.md

What wave 4's implementers may change:

> **It may**: add children anywhere in the wave's modules — the seven engines and every child § 13 names are expected additions (the engines in the
> — source: .claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md 14.2 What the implementer may and may not change

The routes, as `Contact`'s first implementer worked them out:

> 3. **`exists_shave`** (H, about a session). `F′ = F` plus two arcs — the branch of curvature `σ` from `v` to radius `ρ` (`Arc.circ` with explicit
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4c/plans/FS131-IC-implementation.md ## Stage 2 — SAVED: `woodallCone`, `woodallCone_strict`, `clear_of_subset_interior_allowedCone`; 7 `sorry` left in `Contact`

> 4. **`exists_rayMerge`, `exists_merge`** (H each, a session each). **The plan's claim (§ 13.1 engine 3: "the moves of Contact add arcs and recolour; they
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4c/plans/FS131-IC-implementation.md ## Stage 2 — SAVED: `woodallCone`, `woodallCone_strict`, `clear_of_subset_interior_allowedCone`; 7 `sorry` left in `Contact`

(both continue there: SHAVE adds two arcs from `v`; the merges each need **a cut at `v`** — every arc through `v` replaced by at most three pieces — because
`HasSectors` counts connected pieces and the plan's § 13.1 engine-3 claim that the moves never delete an arc is wrong for them; `exists_shave` keeps its statement
though it does not assume `g ≠ c` or `h ≠ c`, so the case `g = c`, `σ < κ₂` needs the same cut). Their conclusions' form, as wave 5 will read them:

> - **The moves' form (G-MOVES-UA)**: `exists_shave`, `exists_rayMerge`, `exists_merge` hold with unit arcs and conclude `F'.RingArcsWithin F` (no unit arc
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md ### 14.5 Notes for wave 5's planner (from wave 4's planners; Keryx's rulings in brackets)

Wave 5 will also need **strengthened** forms (every point of four or more colours after a move had them before, `IsModification`): add them as new lemmas if
they come cheaply, never as a change to the three statements. Engine 2, which the moves' "no unit arc created" clause needs:

> 223. **Engine 2 written once** (item 218 (g)): FS131-I4i wrote `ringArcsWithin_of_Γ_subset` in `Plane/ValidMap/Basic` on `fs131-w4` (`3f7ea033`, Basic.lean only,
> — source: plans/FS131-close-inventory.md

Bring that exact hunk onto your branch first (`git diff 3f7ea033~1 3f7ea033 -- Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean | git apply`, then build; if it
does not apply cleanly, copy the declarations verbatim from `git show 3f7ea033:Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean`), so the copies are identical
when the branches merge.

## Done means

1. **Your readback first**: check the quotations above against their sources; build the branch once as given (`d4f946ae`); open your record with what you may
   and may not change. Commit and push (`git push -u origin fs131-w4m`).
2. **Engine 2 brought over**, then **`Moves` created** with the three `…_aux` statements copied by script and checked identical to `Contact`'s (a diff of the
   statement text in your record); building with only `sorry` warnings. Commit.
3. **The three proved**, in the order you judge (IC1's: SHAVE first), saving after each; no statement changed, no new `axiom`, no `native_decide`; re-price from
   the first. Do not edit a file while a build of it runs.
4. **The handover**: your record's last stage says what is proved and what is left, with the build log and an axioms print against that build's oleans. You do not
   edit `Contact`, merge into `fs131-w4c` or `fs131-w4`, or run wave 4's gate — the merge and the three citations happen on my word, so no two branches race.
   Never push to `main`.
5. **Your record**, stages headed "Stage n — SAVED", "Theorems this phase proved"; the report in standing rule 11's form. Stopping at a saved stage with a move
   left, named, is a good report.

## What is yours to decide

The proofs, their children and where they live (in `Moves` or, statements unchanged, in `Basic`), and the order. If a move turns out to need a lemma that exists
only in `Contact`, message me: that lemma then moves to `Moves` too (by me, coordinating with IC4), never a copy. If a move cannot be proved as written, stop it,
message me with the declaration, the reason, and the smallest counterexample or the missing hypothesis, and go on with the others. Three failed attempts on one
route is a dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level deep,
because the coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; four agents are building, so on
exit 75 wait ten minutes and retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence; mirror
oleans in a scratch directory of your own. The worktree's `.lake/build` is its own copy (from `fs131-w5b`; the first build rebuilds what differs); never replace
it with a symlink. Nothing with a `sorry` reaches `main`.

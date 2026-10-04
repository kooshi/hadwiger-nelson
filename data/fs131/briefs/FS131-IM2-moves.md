# Brief FS131-IM2 — wave 4's three moves (second implementer) (`exists_shave`, `exists_rayMerge`, `exists_merge`), in a module of their own upstream of `Contact`

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IM2
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: move `Contact`'s next prefix into `Plane/ValidMap/Cone` (inventory item 263), then prove wave 4's three simplifying moves under their exact statements as the `…_aux` lemmas in `Plane/ValidMap/Moves`, SHAVE first, on branch `fs131-w4m`; hand the branch over for merging
  launch: now, beside FS131-I2n (wave 2, on `fs131-w2`), FS131-IC5 (wave 4's `Contact`, on `fs131-w4c`) and FS131-QA3 (a read-only definitions audit), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a move that cannot be proved as written, a `Contact` lemma a move turns out to need, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-IM2.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IM-implementation.md` (FS131-IM1's, on branch `fs131-w4m`; continue its stages from Stage 4)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4m` (branch `fs131-w4m`): new modules `Proofs/HadwigerNelson/Plane/ValidMap/Moves.lean` and (item 254) `Proofs/HadwigerNelson/Plane/ValidMap/Cone.lean` (importing what `Contact` imports — `Plane/ValidMap/Basic`, `Plane/Tiles`, `Plane/SVMap` — and never `Contact`), additions to `Proofs/HadwigerNelson/Plane/ValidMap/Basic.lean` (engine 2's exact hunk, and supporting lemmas, statements unchanged), `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (the block headed "FS131-IM1", which you extend), `plans/FS131-IM-implementation.md`, `tools/fs131_im_*.py`, `data/fs131/im/`, `data/fs131/reports/FS131-IM2.md`; **not** `Proofs/HadwigerNelson/Plane/ValidMap/Contact.lean` (FS131-IC5's) except the deletions of items 254 and 263 and the import and namespace lines they need, nor wave 4's other modules
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k


Hello. You are joining wave 4 of the Lean backlog, the valid-map machinery the frontier's local exclusion rests on, on Opus. Wave 4 is split by file across
three branches, and yours, `fs131-w4m`, holds its three simplifying moves — SHAVE, MERGE-RAY and MERGE — proved as `…_aux` lemmas in a module upstream of
`Contact`, which cites them at the merge. FS131-IM1 handed back at a saved stage: it created `Moves` and `Cone`, moved `Contact`'s head into `Cone`, proved the
germ arc and clearness at limits, and wrote one surgery design for all three moves (its record, Stage 3). The moves are now wave 4's longest path. Your tree
`/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4m` is built at `8d075e9c`'s state; the branch head is `dbedaf97`.

## Why this job

A wave counts as held only when its declarations pass the full gate (the milestone's announcement rule, `plans/FS131-close-inventory.md`). Wave 4 gates Woodall's
landing and wave 5's, and its moves are its longest path: IM1 re-priced them at about three implementer sessions for SHAVE, two more for RAY on SHAVE's
machinery, and two to three for MERGE.

## The statements

The three are `exists_shave_aux`, `exists_rayMerge_aux` and `exists_merge_aux` in `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4m/Proofs/HadwigerNelson/Plane/ValidMap/Moves.lean`,
copied by `tools/fs131_im_statements.py` from `Contact`'s `exists_shave`, `exists_rayMerge`, `exists_merge` (that tool reports an empty diff; run it again after
the second move). They are read back in `.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md` §§ 3.2 and 7.2 and planned there in § 13. You prove each
under its **exact** statement. The first move's ruling, whose premise turned out wrong twice:

> 236. **Ruling: `Contact` splits once more, when a slot frees** — the three moves (`exists_shave`, `exists_rayMerge`, `exists_merge`) to a parallel implementer in a
> — source: plans/FS131-close-inventory.md

What IM1 found, and the ruling on the second move — read both items in full there:

> 262. **Corrections, slips and a tool defect from IM1's report.** (a) **Correction owed — N4-RAY's route**: recolouring the whole gap merges every `c`-sector
> — source: plans/FS131-close-inventory.md

> 263. **Ruling: the second move is a prefix move, into `Cone`, by IM1's successor on `fs131-w4m`.** Choice: FS131-IM2 moves **every declaration of `Contact` from
> — source: plans/FS131-close-inventory.md

The surgery IM1 designed, and its handover:

> Every move builds `F'` with `F'.dom = F.dom`, `F'.col = F.col` off the recoloured region `R ⊆ B(v, ρ)`, and
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4m/plans/FS131-IM-implementation.md 3.1 One surgery, three instances

> **Proved**: the seven children listed under "Theorems this phase proved"; engine 2 brought over byte-identical; the `Cone` block moved and checked; the three
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4m/plans/FS131-IM-implementation.md 3.5 The handover: what is proved, what is left, the price

What wave 4's implementers may change:

> **It may**: add children anywhere in the wave's modules — the seven engines and every child § 13 names are expected additions (the engines in the
> — source: .claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md 14.2 What the implementer may and may not change

Their conclusions' form, as wave 5 will read them:

> - **The moves' form (G-MOVES-UA)**: `exists_shave`, `exists_rayMerge`, `exists_merge` hold with unit arcs and conclude `F'.RingArcsWithin F` (no unit arc
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4/plans/FS131-w4-kernel-plan.md ### 14.5 Notes for wave 5's planner (from wave 4's planners; Keryx's rulings in brackets)

Wave 5 will also need **strengthened** forms (every point of four or more colours after a move had them before, `IsModification`): add them as new lemmas if
they come cheaply, never as a change to the three statements.

## Done means

1. **Your readback first**: check the quotations above against their sources; read IM1's record in full (§ 3 above all); build the branch once as given
   (`dbedaf97`). Commit and push.
2. **The second move** (item 263): every declaration of `Contact` from `e_eq_of_mem_coneAt_hornSet` through `IsSectorChart.index_of_isSector_hornSet` (whole
   declarations, with their docstrings and the `namespace`/`variable` lines they sit under) moved verbatim into `Cone`, deleted from `Contact`, which reopens its
   namespace before `woodallCone_isHorn`; `tools/fs131_im_move_cone.py` extended to check the new range byte for byte, its negative control watched red; the
   statements tool re-run; a green build with only `sorry` warnings. Commit — this stage alone is a good hand-back if nothing else lands.
3. **The moves**, SHAVE first by record § 3.5's order of children, then RAY (merging `H₁` with the nearest `c`-horn above it, item 262 (a)), then MERGE; saving
   after each child; no statement changed, no new `axiom`, no `native_decide`; re-price from the first child. Do not edit a file while a build of it runs.
4. **The handover**: your record's last stage says what is proved and what is left, with the build log and an axioms print against that build's oleans. You do not
   edit `Contact` beyond item 263's deletion, merge into `fs131-w4c` or `fs131-w4`, or run wave 4's gate — the merge and the three citations happen on my word, so
   no two branches race. Never push to `main`.
5. **Your record**, stages headed "Stage n — SAVED", "Theorems this phase proved"; the report in standing rule 11's form. Stopping at a saved stage with a move
   left, named, is a good report.

## What is yours to decide

The proofs, their children and where they live (in `Moves`, in `Cone`, or, statements unchanged, in `Basic`), and the order within SHAVE. If the shared
machinery (the old-arc pieces outside the ball, the modified map, the sector-count partition, the rim-colour bound) settles into a module of its own, say so in
your report: once it lands I will weigh running RAY and MERGE in parallel downstream of it. If a move needs a lemma that lives only in `Contact` below
`woodallCone_isHorn`, message me; it then moves too (by my ruling, coordinating with IC5), never a copy. If a move cannot be proved as written, stop it, message me
with the declaration, the reason, and the smallest counterexample or the missing hypothesis, and go on with the others. Three failed attempts on one route is a
dispatch to the companion your identity names, never a fourth. You start no agents of your own (standing rule 1: delegation is one level deep, because the
coordinator can only review work it knows exists).

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them; on exit 75 wait ten minutes and
retry. `lake env lean` (with `-DautoImplicit=false -DrelaxedAutoImplicit=false`) is for iteration only, never evidence; mirror oleans in a scratch directory of your
own. The worktree's `.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`.

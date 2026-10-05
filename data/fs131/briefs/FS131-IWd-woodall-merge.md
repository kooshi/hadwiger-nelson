# Brief FS131-IWd — Woodall's chain in the kernel: the last three leaves of the localized step 3

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IWd
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the fourth implementer on Woodall's chain ("maps need six") — prove `niceAt_of_dirColourAt`, `wedgeMerge_niceAt` and `exists_merge_at` in `Plane/Woodall/Merge`, saving after each; then, once wave 4 has landed, the brick-map model (QA2-1), the merge of `main`, the gate and the landing
  launch: now, beside FS131-I2i (wave 2) and FS131-I4e (wave 4), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-IWd.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IW-implementation.md` (on branch `fs131-ww`; you continue it — standing rule 2's "Resuming")
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-ww` (branch `fs131-ww`): the four modules under `Proofs/HadwigerNelson/Plane/Woodall/` (children only; no definition or statement changes), supporting lemmas in the foundation modules (statements of other waves unchanged), `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `plans/FS131-IW-implementation.md`, `tools/fs131_iw_*.py`, `data/fs131/iw/`, `data/fs131/iwd/`, `data/fs131/reports/FS131-IWd.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are the fourth implementer on Woodall's chain, on Opus. The chain — "maps need six" over arc maps, route M's link to `χ_m⁰(ℝ²) ≥ 6` — is proved
as a composition down to three leaves of the localized step 3 (E3-BALL). The last implementer, FS131-IWc, proved 20 of 23, including E3-W, the composition
`exists_woodallMerged` itself (so the children are known to fit together), and every inhabitant; `Plane/Woodall/Basic`, `Steps`, `NoFourFive` and `Collar` are
sorry-free.

## Why this job

`CLAUDE.md` § The aim, item 4, and `LEDGER.md` row 132 hold "maps need six for arc maps" at [hand]; this chain is its Lean check (Kooshi, inventory item 111).
These three leaves are all that stands between the chain and its landing, once wave 4 lands.

## The statements

The three `sorry` declarations in `.claude/worktrees/fs131-ww/Proofs/HadwigerNelson/Plane/Woodall/Merge.lean` at `ca6ec757`, planned in
`.claude/worktrees/fs131-ww/plans/FS131-W-kernel-plan.md` §§ 14–15. IWc's state, as logged:

> 180. **FS131-IWc handed back at stage 12, harness ≈ 494k** (report on its branch; `fs131-ww` at `ca6ec757`, checked): **20 of its 23 leaves proved**, statements unchanged,
> — source: plans/FS131-close-inventory.md

and its routes, its record's Stage 11, which opens:

> **Proved (children of `exists_merge_at`, in `Merge` after `dirColourAt_wedgeMerge`)**: `mem_coneAt_inter_annSector` (cones are local in direction:
> — source: /home/kooshi/source/lean-dir/.claude/worktrees/fs131-ww/plans/FS131-IW-implementation.md § Stage 11

(the stage gives a route and a truth reading for each of the three; `exists_merge_at` by the simpler measure `μ = ∑_{δ ∈ D} (colours whose cone holds δ) − 1`;
`wedgeMerge_niceAt` needs a curvilinear form of `coneAt_annSector_eq` — the cone at a point where a circle crosses a line or another circle transversally — which
you state as a child). The rule from § 9.5 holds: no statement or definition of the chain changes; a statement that cannot be proved as written comes back
through me.

## Done means

1. **Your readback first**: check the two quotations against their sources; build the worktree once as given (`ca6ec757`) before editing anything; restate in your
   record what you may and may not change. Commit and push.
2. **`niceAt_of_dirColourAt`, `wedgeMerge_niceAt`, `exists_merge_at`** proved, with any children you need stated and recorded (`tools/fs131_w3_decls.py --check`);
   no statement changed, no new `axiom`, no `native_decide`; save after each.
3. **After wave 4 lands on `main`** (it may not during your session): merge `main`, run `tools/fs131_qa1_dupes.py` — this branch lands second, so delete its
   identical copies of `abs_dot_le`, `dot_add_left`, `dot_e_e`, `isOpen_shadow` and use wave 4's — then the plane-map model of the normal forms (QA2-1, the
   amendment below), then the gate (warnings counted — `scripts/build.sh` exits 0 with warnings) and the landing (`git push origin HEAD:main` from the worktree;
   never force-push). If wave 4 has not landed, stop after item 2 with a saved stage.
4. **Your record** (continue it), stages headed "Stage n — SAVED", "Theorems this phase proved"; the report in standing rule 11's form.

## Amendment carried from FS131-IWc's brief — a plane-map model of the normal forms, before the landing

From FS131-QA2 (`plans/FS131-close-inventory.md` item 172, QA2-1): Woodall's normal forms are modelled only on small discs, never on a plane map. Before the chain's
gate, once `fs131-ww` has merged wave 4's `sevenBrickMap`, add the plane-map model — `sevenBrickMap.WoodallNormal univ` (with `WoodallMerged univ`), or an
`ArcMap 7` that is valid, a plane map, in normal form on `closedBall 0 3` and with a point of three colours there; the T-junction at a brick corner is the witness
(`plans/FS131-QA2-audit.md` § 2.2; wave 4's `sevenBrick_corner_isCubicTrichromatic`). No statement changes.

## What is yours to decide

The proofs, their children and order within § 15.3's, and where a supporting lemma lives. If a leaf cannot be proved as written, stop that leaf, message me
at once with the declaration, the reason, and the smallest counterexample or the missing hypothesis, and go on with the others. Three failed attempts on
one route is a dispatch to the companion your identity names, never a fourth.

## The machine

Build only from inside the worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`. Up to two builds from different worktrees may run at once when the slot admits them (inventory ruling 5), and
several trees are building today, so on exit 75 wait ten minutes and retry. `lake env lean` (with § 9.5's flags) is for iteration only, never evidence.
The worktree's `.lake/build` is its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`. You start no agents of your own
(standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).

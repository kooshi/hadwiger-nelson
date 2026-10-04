# Brief FS131-IWc — Woodall's chain in the kernel: the localized step 3 (`Plane/Woodall/Merge`) and the inhabitants

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-IWc
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: the third implementer on Woodall's chain ("maps need six") — prove `Plane/Woodall/Merge`'s 18 leaves (E3-BALL, the localized step 3) and `Plane/Woodall/Basic`'s five inhabitant leaves in the planner's order, saving after each; the gate and the landing wait for wave 4
  launch: now, beside FS131-I4c (wave 4), FS131-I3i (`localSectors`, landing) and FS131-QA2 (an audit, read-only), each in its own tree
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job for a leaf that cannot be proved as written, a statement that looks false, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-IWc.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-IW-implementation.md` (on branch `fs131-ww`; you continue it — standing rule 2's "Resuming")
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-ww` (branch `fs131-ww`): the four modules under `Proofs/HadwigerNelson/Plane/Woodall/` (children only; no definition or statement changes), supporting lemmas in the foundation modules (statements of other waves unchanged), `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean`, `plans/FS131-IW-implementation.md`, `tools/fs131_iw_*.py`, `data/fs131/iw/`, `data/fs131/iwc/`, `data/fs131/reports/FS131-IWc.md`
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. You are the third implementer on Woodall's chain, on Opus. Today the chain was found to rest on two definitions no real map could satisfy; a deriver
(FS131-E3) repaired step 3 in the form the chain reads — a picture in NiceAt form at every point of three or more colours in a ball — and a planner (FS131-W3)
put the repair into Lean: the chain's theorems, `aeMap6` among them, are now proved as compositions over the localized step 3 (E3-BALL) and five small facts
about the real example maps. What is left is those: 18 leaves in `Plane/Woodall/Merge` and 5 in `Plane/Woodall/Basic`. None needs `localSectors`; wave 3's
landed `GoodAt` engine supplies every local fact.

## Why this job

"Maps need six, almost everywhere" (`CLAUDE.md` § The aim, item 4; `LEDGER.md` row 132) is route M's link to `χ_m⁰(ℝ²) ≥ 6`, and this chain is its Lean check
(Kooshi, inventory item 111). Closing these leaves leaves only wave 4's statements, which land with wave 4.

## The statements

The leaves are the `sorry` declarations of `Plane/Woodall/Merge` and `Plane/Woodall/Basic` on branch `fs131-ww` at `8488ad82`, read back and planned in
`.claude/worktrees/fs131-ww/plans/FS131-W-kernel-plan.md` §§ 13–15. The planner's state, as logged:

> 167. **FS131-W3 done, harness ≈ 442k** (report on its branch; `fs131-ww` at `8488ad82`, checked): E3's drafts in the chain, statements verbatim, each elaborating on the
> — source: plans/FS131-close-inventory.md

and its handoff (§ 15.3; read it whole):

> - `Woodall/Merge`: new; 18 `sorry` leaves; `recolour` and four small lemmas proved;
> — source: .claude/worktrees/fs131-ww/plans/FS131-W-kernel-plan.md § 15.3

The rule from § 9.5 still holds: no statement of the chain, no definition of `Plane/Woodall/Basic` or `Plane/Woodall/Merge`, changes; a statement that cannot be
proved as written comes back through me. One ruling to apply first (item 167 (b)): make `NiceAt.normal` private, its docstring saying why (a public statement
over valid five-coloured plane maps must conclude `False`).

## Done means

1. **Your readback first**: check the two quotations against their sources; build the worktree once as given (`8488ad82`) before editing anything; restate in your
   record what you may and may not change. Commit and push.
2. **The leaves proved in § 15.3's order** — the easy `Merge` leaves, then the composition `exists_woodallMerged` first among the hard ones (it checks that the
   children fit together), then the rest, and the five inhabitant leaves T1–T5 — no statement changed, no new `axiom`, no `native_decide`; save after each;
   re-price from your first two hard leaves. Records via `tools/fs131_w3_decls.py --check` (it covers all five modules).
3. **The gate and the landing wait for wave 4** (its `ts_t`, `lemmaL` and others sit on this branch as skeleton until wave 4 lands); when it has, merge `main`,
   run `tools/fs131_qa1_dupes.py` (`abs_dot_le` collides with wave 4's), then the gate.
4. **Your record** (continue `plans/FS131-IW-implementation.md`), stages headed "Stage n — SAVED", "Theorems this phase proved"; the report in standing rule 11's
   form. Stopping at a saved stage with leaves left, and naming them, is a good report.

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

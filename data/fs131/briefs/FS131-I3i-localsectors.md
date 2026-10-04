# Brief FS131-I3i — the sector structure at a point (`localSectors`), the separation lemma, and the cusp-free four-colour clause, landed on `main`

*Written 2026-10-04 by Keryx, the coordinator (the top-level session). Launch line: "Your brief is on disk: read it in full first."*

brief: FS131-I3i
  identity: de Bruijn, the implementer — your agent file (`.claude/agents/debruijn-implementer.md`) is your identity and your lane's workflow; you run on Opus, as every implementer now does (inventory item 137)
  role: state and prove `localSectors` in `Plane/LocalStructure` from FS131-I3h's draft, then `Simple.coneAt_eq_angleIcc_sep`, then `four_of_bothKind_simple` without `hnc`; run the full gate on branch `fs131-w3b` and land it on `main`
  launch: now, beside FS131-T3 (gate tooling, in the main tree) and FS131-E3 (a deriver, no Lean)
  mission: § Why this job
  statements: § The statements
  acceptance: § Done means
  yours: § What is yours to decide
  fences: none — nothing in this milestone is blind (`plans/FS131-close-inventory.md` § Rulings in force, ruling 1)
  channel: message the coordinator ("main") by SendMessage mid-job when `localSectors` is committed (wave 4 waits on it), for a statement that cannot be proved as written, or a question you cannot work around; the report goes to `data/fs131/reports/FS131-I3i.md` on your branch, and its text is your final message
  standing rules: plans/STANDING-RULES.md — part of this brief; read it in full. Also `LEAN.md` in full, and `RUNNING.md` § Building and § Make the gate fail, and watch it fail
  record: `plans/FS131-I3i-implementation.md` (on branch `fs131-w3b`)
  touches: in the worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w3b` (branch `fs131-w3b`, made for you from `origin/main` at `0ff8f659`, wave 3 landed): `Proofs/HadwigerNelson/Plane/LocalStructure.lean` (new declarations only), `Proofs/HadwigerNelson/Plane/RingGerm.lean` (`four_of_bothKind_simple` alone), `Proofs.lean`, `ARCHITECTURE.md`, `scripts/Axioms.lean` (records for your declarations), `scripts/Vacuity.lean` and `scripts/vacuity-controls.lean` (only if a new structure needs registering), `plans/FS131-I3i-implementation.md`, `data/fs131/i3i/`, `tools/fs131_i3i_*.py`, `data/fs131/reports/FS131-I3i.md`; and, at the landing only, `origin/main` by fast-forward
  budget: about 400k by the harness's count, as guidance; hand back at a saved stage before about 500k

Hello. Wave 3 of the Lean backlog landed on `main` an hour ago — the second wave held in the kernel. One piece its plan specified was never stated: the
sector structure at a point (`localSectors`), the description of how a map's arcs fan out from one point, branch by branch. Wave 4 needs it for about twenty
leaves, and two more results wait on it: the separation lemma a deriver found today (FS131-E2) and, through it, the four-colour clause of FS116-V5-U1 without
the "no cusp" hypothesis item 112 added. FS131-I3h, who landed wave 3, left a draft statement that elaborates against the landed module with one `sorry`, and
the route. You build it, on its own branch from the landed `main`, and land it.

## Why this job

Twenty of wave 4's 54 open leaves (`woodallCone`, `exists_hasDegree_of_mem_dom`, `noBoth`'s repeated-colour clause, engine 5, `stuck_structure` and their
dependents) read the sector structure; Woodall's chain may use it too. Kooshi's standing word: formalization is never a cost that ranks routes.

## The statements

I3h's handoff, its Stage 11:

> **Not done: `localSectors`, `Simple.coneAt_eq_angleIcc_sep`, `four_of_bothKind_simple` without `hnc`** (brief item 8; the budget's hand-back line was reached at
> — source: .claude/worktrees/fs131-w3b/plans/FS131-I3-implementation.md § Stage 11

(the paragraph continues there with the draft's definitions — `branchPt`, `sectorBetween`, `BranchGerms`, `ArcMap.IsSectorChart` — and the route on `GoodAt`).
The draft is `.claude/worktrees/fs131-w3b/data/fs131/i3/h/LS.lean`; wave 4's need is inventory item 136 (branch germs with direction and signed curvature; sectors between consecutive
branches, finite and constant in `r`; each sector's cone an interval). The separation lemma is FS131-E2's, stated in its record `plans/FS131-E2-derivation.md`
§ 2.7 (`Simple.coneAt_eq_angleIcc_sep`), with its proof's shape in § 2.4; the cusp-free four-colour clause is `four_of_bothKind_simple` at its `05cb0a3e`
statement (no `hnc`), as ruled at item 139.

## Done means

1. **Your readback first**: check the quotation against its source; build the branch once as given (`0ff8f659`; the build directory was copied from wave 3's
   tree, so it should be current); confirm the draft elaborates. Commit and push (`git push -u origin fs131-w3b`).
2. **`localSectors` stated and proved** in `Plane/LocalStructure` (new declarations only; the landed statements of wave 3 do not change), with its
   definitions' spec examples and an inhabitant; message me the commit at once.
3. **`Simple.coneAt_eq_angleIcc_sep`** stated as E2's § 2.7 gives it and proved; then **`four_of_bothKind_simple`'s `hnc` removed** (its statement restored
   to `05cb0a3e`'s), by E2's § 2.4 route — a strengthening the ruling permits, so record it with the item number.
4. **The gate on `fs131-w3b`**: the build with zero warnings, `scripts/axioms.sh` clean (every record the standard three or fewer), `scripts/vacuity.sh` and
   `--self-test` green with any new carrier registered under FS131-T1's procedure, `tools/check_architecture.py` exit 0, each negative control watched going
   red. Then **the landing**: merge `origin/main`, re-run the gate, fast-forward `origin/main` (`git push origin HEAD:main`), never force-push. FS131-T3 is
   changing the axiom gate in the main tree at the same time; if it has landed first, merge it and run its version of the gate.
5. **Your record** with stages headed "Stage n — SAVED", "Theorems this phase proved" (declaration, axioms from the saved audit log, the row or ruling), and
   drafts for the front page (the new counts); the report in standing rule 11's form.

## What is yours to decide

The proofs and their order; whether I3h's draft shape is the right one (if not, message me before you land a different one: wave 4 builds on it). If a
statement cannot be proved as written, message me with the counterexample.

## The machine

Build only from inside your worktree, under the slot: `/home/kooshi/source/lean-dir/scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4
./scripts/build.sh`; never `lake build`; on exit 75 wait ten minutes and retry. `lake env lean` is for iteration only. The worktree's `.lake/packages` is a
symlink to the main tree's and its `.lake/build` its own copy; never replace it with a symlink. Nothing with a `sorry` reaches `main`. You start no agents of
your own (standing rule 1: delegation is one level deep, because the coordinator can only review work it knows exists).

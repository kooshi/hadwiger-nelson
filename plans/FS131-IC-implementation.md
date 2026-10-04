# FS131-IC — wave 4's `Contact` implementation record (branch `fs131-w4c`)

Implementer: de Bruijn on Opus 5.5 (job FS131-IC1). Brief `data/fs131/briefs/FS131-IC1-contact.md` (on `main`); plan
`plans/FS131-w4-kernel-plan.md` (§§ 3.2, 13, 14). Worktree `/home/kooshi/source/lean-dir/.claude/worktrees/fs131-w4c`, branched from `fs131-w4`
at `68f34f18`. Iteration tools (never evidence): `data/fs131/ic/iter.sh <module…>` (compile oleans into the scratch mirror
`/home/kooshi/scratch-w4c`), `data/fs131/ic/chk.sh <abs .lean path>`.

## Theorems this phase proved

(None yet. Axioms will be read from `#print axioms` against a real build's oleans, never from a scratch compile.)

## Stage 1 — SAVED: the readback, the as-given build

**The brief's four quotations against their sources** (standing rule 3):
1. "**It may**: add children anywhere in the wave's modules — the seven engines and every child § 13 names are expected additions (the engines in the"
   — `plans/FS131-w4-kernel-plan.md` § 14.2 (in this tree at `68f34f18`): **matches as a truncation** (the source continues "… foundation
   `Plane/ValidMap/Basic` where § 13.1 puts them, sorry-free, each with a spec example); …").
2. "**What is left (50) and the order I would take it.** Contact 10: `clear_of_subset_interior_allowedCone`, `woodallCone`, `woodallCone_strict` (now has"
   — `plans/FS131-I4-implementation.md` Stage 8, last paragraph: **matches as a truncation**.
3. "194. **Ruling: wave 4 splits by file** (item 191's condition met: six leaves a session on wave 4's last two sessions, 39 left). Choice: the next wave-4 implementer"
   — `plans/FS131-close-inventory.md` on `main`, line 1358: **matches as a truncation**.
4. "Confidence: high. (b) The carriers' in/out recommendation goes to wave 5's implementer at its gate, under T1's procedure (no ruling now). (c) **K5b's slot"
   — `plans/FS131-close-inventory.md` on `main`, item 208, line 1487: **matches as a truncation**; the item continues as the brief says (worktree
   `fs131-w4c` from `fs131-w4` at `68f34f18`, record `plans/FS131-IC-implementation.md`, merge into `fs131-w4` before wave 4's gate).

**A slip in the brief (not a quotation):** its first line reads "# Brief FS131-I4h — wave 4 of the Lean backlog, continued: the 24 remaining `sorry`
declarations in `UnitArc` and `BaseSteps` on branch `fs131-w4`" — the title of I4h's brief; the header block below it (`brief: FS131-IC1`, role, touches)
and the body are this job's. I worked from the header and body.

**A finding about the plan's routing (not a statement):** the brief says `exists_merge` and FS131-I4h's `n3_end` read `woodallCone`. No module imports
`Plane/ValidMap/Contact` today except `Proofs.lean` (`BaseSteps` imports `Basic`, `SVMap`, `LocalMapExamples`, `UnitArc`); if `n3_end`'s proof needs
`woodallCone`, `BaseSteps` must import `Contact` (no cycle: `Contact` imports `Basic`, `Tiles`, and from this job `Sectors`, none of which imports
`BaseSteps` or `UnitArc`). I keep `Contact`'s imports free of `UnitArc` and `BaseSteps` so that import stays possible.

**What I may change** (§ 14.2 and the brief's `touches`): add children anywhere in `Contact` and in a new module of my own (`Plane/ValidMap/ContactAux`,
imported by `Contact`) and additions to the foundation `Plane/ValidMap/Basic` (statements unchanged); `Proofs.lean`, `ARCHITECTURE.md`,
`scripts/Axioms.lean` (my own block, headed "FS131-IC1"), this record, `tools/fs131_ic_*.py`, `data/fs131/ic/`, `data/fs131/reports/FS131-IC1.md`;
imports of `Contact` (with `ARCHITECTURE.md`'s Imports cell). A strengthened form of a move (wave 5's "every point of four or more colours after a move
had them before") only as a new lemma beside the move. **What I may not change**: any statement of §§ 3.2, 7.2 (the ten leaves' hypotheses and
conclusions, `stuck_structure`'s Condition 5 and three-colour hypotheses included), any definition of `Plane/ValidMap/Basic`, the read-back conventions;
`UnitArc`, `BaseSteps`, `SVMap`, `StuckChain` (FS131-I4h's, on `fs131-w4`); no new `axiom`, no `native_decide`; no merge into `fs131-w4`, no gate of
wave 4, no push to `main`. A leaf that cannot be proved as written goes to Keryx at once with the declaration, the reason and the counterexample or
missing hypothesis.

**The worktree as given** (`68f34f18`, nothing edited): `./scripts/build.sh` under `scripts/slot.py --mem 40 --cpus 8` (`MEMMAX=40G BATCH=4`): "build: OK —
444 of 444 batches, 3 module(s) rebuilt, 3 module(s) with warnings, 9m21s", exit 0 (`build/gate/build/20261004T185251Z-1528718.log`; driver log
`data/fs131/ic/build-readback.log`). 34 `declaration uses sorry` warnings: `Contact` 10 (the ten leaves), `UnitArc` and `BaseSteps` 24 (I4h's).

# FS-124 — the radius clause in the kernel: the implementation (job FS124-I1)

*De Bruijn, the implementer. Brief: `data/fs124/briefs/FS124-I1-radius.md` (on `main`). The planner's record:
`plans/FS124-kernel-plan.md`. Claim list: `data/fs124/claims-K1.md`. Branch `fs124-wk1`, taken at `28a82429`. Working
files: `data/fs124/i1/`. The record is written in stages; each is committed before the next starts.*

## Theorems this phase proved

*Filled at Stage 3, from the build's own print of each theorem's axioms.*

## Stage 1 — SAVED (FS124-I1): the readback, the build as given, the statements as stored

**The brief's quotations against their sources.** `data/fs124/i1/readback.py <brief>` (the planner's reader, copied
and changed in two places: the path is the first token after `— source:`, since this brief writes `<path> Stage 5`;
a relative path is resolved in the main working tree, where the brief lives) takes every quoted block with its
`— source:` line and looks for it, whitespace-normalized, in the file named: **15 of 15 found**, exit 0
(`data/fs124/i1/logs/readback.txt`) — Kooshi's two passages; the three claims' first lines; `AeProperOn`; the seven
theorem heads; the planner's two sentences. Control: `--control` swaps the case of one letter in each quotation and
must find none — it found none of the fifteen, exit 0 (`data/fs124/i1/logs/readback-control.txt`).

**One difference between the two copies of the claim list, not in any statement**: `main`'s
`data/fs124/claims-K1.md` carries a dated line at its end (2026-10-07, 14:44 UTC, the planner's draft filed, with the
two join theorems named) that this branch's copy does not; the five statements and their not-claimed lines are
identical in the two (`diff`: the one hunk is that line).

**Read whole**: the brief; `plans/STANDING-RULES.md`; `LEAN.md`; `RUNNING.md` § Building and § Make the gate fail, and
watch it fail; `data/fs124/claims-K1.md`; the planner's record, all five stages; the three modules with their
docstrings; `Plane/AeColouring`, `Plane/UnitPairs`; of `Plane/Basic` the definitions of `e` and `arcLength` and their
lemmas; of `Outside/OAI158` lines 150–354 (the bridge and the forms this library cites); of `Plane/YesLimit` the proof
of `chromaticNumber_plane_le_chiM0`; `UnitDistance`'s `unitDistance_adj` and
`add_one_le_chromaticNumber_iff_not_colorable`; the planner's `checks1.lean`, `checks2.lean`.

**The build as given**: `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`, exit 0 —
`build: OK — all 1847 modules already up to date, nothing built, 3 module(s) with warnings, 2s`; **49** lines
`declaration uses sorry` (27 in `Plane/WeakColouringOn`, 14 in `Plane/Radius`, 8 in `Plane/RadiusOutside`) and no
other warning (`data/fs124/i1/logs/build-0-as-given.log`).

**The statements as the kernel stores them, before any change.** `data/fs124/i1/lean/Statements.lean` prints, for
every constant the three modules declare, its kind, its full name, `Expr.hash` of its stored type, `Expr.hash` of its
value where it is a definition, and the type pretty-printed: 74 constants (64 theorems — the 57 leaves and seven the
elaborator generates — 7 definitions, the structure with its constructor and recursor), in
`data/fs124/i1/statements-before.txt`. Stage 3 prints the same from the build after the last leaf and compares
(`tools/fs124_i1_statements.py`): "no statement changed" is then a check on stored terms, not on the files' text.

**The iteration instrument** (never evidence): `data/fs124/i1/iter.sh <file> [keep]` elaborates one file against an
overlay of this worktree's build (`build/fs124-i1-olean`, ignored by git; a symlink copy of the library, with the
edited modules' object files written over their links — the link is removed first, so the build is never written
through). Options as the lakefile's: `autoImplicit`, `relaxedAutoImplicit` off, `linter.missingDocs` on. Control: a
copy of `Plane/Radius` with one argument of `radius_graph`'s last line replaced (`hmaps hv` for `hmaps hw`) is
reported at its line with exit 1; the file itself exits 0.

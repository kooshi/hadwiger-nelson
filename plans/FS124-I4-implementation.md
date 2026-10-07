# FS-124 — the witnesses: three colourings by formula that inhabit the close-pair theorems (job FS124-I4)

*De Bruijn, the implementer. Brief: `data/fs124/briefs/FS124-I4-witnesses.md` (on `main`). Skeleton and plan: the planner's,
`plans/FS124-kernel-plan-2.md` on this branch (`fs124-wi3`, at `fb515b25a` when this job began). Files of this job:
`Proofs/HadwigerNelson/Plane/ClosePairWitness.lean` (new: the witnesses, constructed),
`Proofs/HadwigerNelson/Plane/ClosePairModel.lean` (the three existence proofs), and in
`Proofs/HadwigerNelson/Plane/SectorPoint.lean` the proofs of `sectorPoint_isSector` and `exists_closePair_sector`. No
statement and no definition of the skeleton is changed. Working files: `data/fs124/i4/`. The record is written in stages.*

## Theorems this phase proved

On branch `fs124-wi3` only: **kernel-checked on a branch, not through the gate.** Axioms as printed from the build named
in each stage. (Completed at the last stage; until then the stages below are the list.)

## Stage 1 — SAVED (FS124-I4): the readback, the build as given, the statements dumped, the witnesses sampled

**The brief's quotations against their sources.** `data/fs124/i4/readback.py <brief>` (the earlier implementers' script,
copied unchanged): **14 of 14 found** (`data/fs124/i4/logs/readback.txt`, exit 0). Control (`--control`, one letter's case
changed in each quotation): none found, as it must be (`logs/readback-control.txt`, exit 0).

**Read whole**: the brief; `plans/STANDING-RULES.md`; `LEAN.md`; `RUNNING.md` § Building and § Make the gate fail, and watch
it fail; the planner's record § 2.5, § 3.2's last two tables, § 4.4, § 4.6, Stage 5; `data/fs124/k2/square_model_check.py`;
my two files; `Plane/ThreePiece` and `Plane/ClosePair` whole, of `Plane/OnePiece` the definitions and the model, of
`Plane/WeakColouringOn` the definitions and `aeProperOn_of_proper_off_null`; the last implementer's record, Stages 1–3.

**The build as given**: `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the
worktree, exit 0 — `build: OK — all 1853 modules already up to date, nothing built, 2 module(s) with warnings, 2s`
(`data/fs124/i4/logs/build-0-as-given-full.log`, `build-0-as-given.exit`). **6 `declaration uses sorry` warnings and no
other**: 3 in `Plane/ClosePairModel`, 3 in `Plane/SectorPoint` — the brief's count.

**The statements before any proof** (for the comparison after each stage). The check is the last implementer's, copied
and re-aimed (`data/fs124/i4/statement_diff.py`), with one change of method, said here: the first dump is not read from a
build. It is the base commit's text of each module (`git show fb515b25a:<file>`), elaborated now with
`data/fs124/i4/lean/DumpTail.lean.txt` appended, which prints every constant that text declares as the kernel holds it:
`data/fs124/i4/statements-before.txt`, 9 constants (3 theorems of `Plane/ClosePairModel`; 5 theorems and the definition
`ThreePiece.IsSector` of `Plane/SectorPoint`). The second dump is `data/fs124/i4/lean/StatementDump.lean` on the built
modules. What the method does not see is what the copied one did not: a docstring, a comment, an `example` moved past
one of identical head.

**The witnesses, sampled before any Lean** (`data/fs124/i4/witness_check.py`; floats; an instrument, not a proof — the
formulas as this job formalizes them, which are not the planner's: Stage 2 and Stage 3 say why):
`lone: unit-pairs-sampled=875190 monochromatic=0`, `square: unit-pairs-sampled=875281 monochromatic=0`, and the two
inequalities of the unit-square witness on 118,695 and 145,657 sampled cases with no violation (least slack `1.5e-3`,
`2.8e-3`) — `logs/witness-check.txt`. With the fault planted (`--fault`: two labels exchanged near `w`; for the
inequalities the hypothesis `Im t ≤ 0` dropped): 74,648 and 53,387 monochromatic pairs, 1,384 and 1,322 violations
(`logs/witness-check-fault.txt`).

**How I iterate** (never evidence): `data/fs124/i4/lean1.sh <file>` — `lake env lean -DautoImplicit=false
-DrelaxedAutoImplicit=false -Dlinter.missingDocs=true` against this worktree's build. New text for the helper module is
written as part files under `data/fs124/i4/lean/` and checked in a scratch file made of the module plus the parts
(`data/fs124/i4/assemble.py`); nothing under `Proofs/` is edited while a build runs.

**A slip of order, disclosed.** Standing rule 2 asks that a stage be committed before the next starts. This stage's
commit was made after Stage 2's work was in the tree (the two commits follow one another, each by explicit path); a
halt between them would have cost both stages' work. Nothing was lost.

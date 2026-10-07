# FS-124 — the second module's last two files: three-piece points, and a close complementary pair at a common unit point (job FS124-I3)

*De Bruijn, the implementer. Brief: `data/fs124/briefs/FS124-I3-close-pair.md` (on `main`). Skeleton and plan: the planner's,
`plans/FS124-kernel-plan-2.md` on this branch (`fs124-wi3`, at `ab669747` when this job began: the planner's tip
fast-forwarded to the first implementer's hand-back). Files of this job: `Proofs/HadwigerNelson/Plane/ThreePiece.lean`,
`Proofs/HadwigerNelson/Plane/ClosePair.lean` (proofs only; no statement and no definition is changed). Working files:
`data/fs124/i3/`. The record is written in stages; each is committed before the next starts.*

## Theorems this phase proved

*Filled at Stage 3 (the claims) and Stage 4 (the constructions); until then: none through a build.*

## Stage 1 — SAVED (FS124-I3): the readback and the build as given

**The brief's quotations against their sources.** `data/fs124/i3/readback.py <brief>` (the first implementer's script,
copied unchanged: every quoted block with its `— source:` line is looked for, whitespace-normalized, in the file named,
in this worktree and on the main working tree): **15 of 15 found** (`data/fs124/i3/logs/readback.txt`, exit 0) — Kooshi's
two passages, the inventory's item 34, the four claims' first lines against `data/fs124/claims-K2.md`, the five theorem
heads against `Plane/ClosePair`, the planner's three passages. Control: `--control` changes the case of one letter in
each quotation and must find none — it found none (`data/fs124/i3/logs/readback-control.txt`, exit 0).

One note on the brief, which changes nothing: the claim list `data/fs124/claims-K2.md` is on `main` only (this branch
holds `claims-K1.md` and `claims.md`); I read it there, with its dated line of 16:33 UTC.

**Read whole**: the brief; `plans/STANDING-RULES.md`; `LEAN.md`; `RUNNING.md` § Building and § Make the gate fail, and watch
it fail; `data/fs124/claims-K2.md`; the planner's record (Stages 1–5); my two files; the two files they import that the
first implementer proved (`Plane/CircleCrossing` whole, `Plane/OnePiece` to the model), and of `Plane/WeakColouringOn`
the definitions; the first implementer's record, Stages 1–4 (its tools are the ones I copy below).

**The build as given**: `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the
worktree, exit 0 — `build: OK — 477 of 477 batches, 7 module(s) rebuilt, 4 module(s) with warnings, 9m26s`
(`data/fs124/i3/logs/build-0-as-given.log`; the full output, `build-0-as-given-full.log`). The full log holds **67
distinct `declaration uses sorry` warnings and no other warning** — 29 in `Plane/ThreePiece`, 32 in `Plane/ClosePair`,
3 in `Plane/ClosePairModel`, 3 in `Plane/SectorPoint`: the brief's count. Its one line with the word `error` is the
build script's up-to-date probe (line 3, `target is out-of-date and needs to be rebuilt`).

**A slip of mine during that build, with no effect on it.** About five minutes into the walk I applied my first patch to
`Plane/ThreePiece` in place, saw that the build had not yet reached the module, and put the file back (`git checkout`)
within a minute, some two hundred batches before the batch that compiles it. The log's 29 warnings for the module are the
as-given count (a file with sixteen leaves proved would have printed 13). From then on nothing under `Proofs/` is edited
while a build runs: I work in a scratch copy and copy in when the build has ended.

**The statements as the kernel holds them, before any proof** (for the comparison after each file):
`data/fs124/i3/lean/StatementDump.lean` (the first implementer's dumper, aimed at my two modules) prints every constant
stored in the compiled data of `Plane/ThreePiece` and `Plane/ClosePair` — kind, full name, stored type, a definition's
stored value — from the build as given: `data/fs124/i3/statements-before.txt`, 126 constants (70 and 56). **One thing the
copied check could not do as it stood**: `sectorPoint` and `petalPoint` are definitions that hold nine proofs as fields,
so their stored values move when a field is proved. The dumper now also prints, for a `ThreePiece` given by its
sixteen arguments, the three data fields (neighbourhood, pieces, labels) on a `DATA` line, and
`data/fs124/i3/statement_diff.py` compares that line in place of the value for those definitions (2 in the dump), with
a planted fault of its own.

**How I iterate** (never evidence): `data/fs124/i3/lean1.sh <file>` — `lake env lean -DautoImplicit=false
-DrelaxedAutoImplicit=false -Dlinter.missingDocs=true` against this worktree's build, about 3 s a run. `Plane/ClosePair`
elaborates against the built `.olean` of `Plane/ThreePiece` as it stands, since no statement changes; the two helpers it
needs are stated in `Plane/ClosePair` itself. Leaves are written into patch files (`data/fs124/i3/patch-*.txt`, applied
by `data/fs124/i3/patch.py`, which refuses an anchor that is missing or doubled).

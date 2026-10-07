# FS-124 — the second module's first two files: the circle geometry and what one piece of one colour forces (job FS124-I2)

*De Bruijn, the implementer. Brief: `data/fs124/briefs/FS124-I2-one-piece.md` (on `main`). Skeleton and plan: the planner's,
`plans/FS124-kernel-plan-2.md` on this branch (`fs124-wk2`, at `92f09e14` when this job began). Files of this job:
`Proofs/HadwigerNelson/Plane/CircleCrossing.lean`, `Proofs/HadwigerNelson/Plane/OnePiece.lean` (proofs only; no statement and
no definition is changed). Working files: `data/fs124/i2/`. The record is written in stages; each is committed before the
next starts.*

## Theorems this phase proved

*(filled at each stage; nothing here is on `main`)*

## Stage 1 — SAVED (FS124-I2): the readback and the build as given

**The brief's quotations against their sources.** `data/fs124/i2/readback.py <brief>` (the planner's script, copied; two
changes, both to how a source address is read: a trailing "Stage n" after a file name is dropped, and a relative source is
looked up in this worktree **and** on the main working tree) takes every quoted block with its `— source:` line and looks
for it, whitespace-normalized, in the file named: **16 of 16 found** (`data/fs124/i2/logs/readback.txt`, exit 0). Control:
`--control` changes the case of one letter in each quotation and must find none of the sixteen — it found none
(`data/fs124/i2/logs/readback-control.txt`, exit 0).

One note on the brief, which changes nothing: the quotation of the inventory's item 34 (`plans/FS124-close-inventory.md
§ Items`) is found on the main working tree only. This branch holds an older copy of that file, without item 34; the
script's first run, which read the branch's copy alone, reported it missing (5,915 of 5,915 characters then matched
against `main`'s copy by hand). The claim list `data/fs124/claims-K2.md` is on `main` only, as the planner's record says.

**Read whole**: the brief; `plans/STANDING-RULES.md`; `LEAN.md`; `RUNNING.md` § Building and § Make the gate fail, and
watch it fail; `data/fs124/claims-K2.md` with its dated line; the planner's record (Stages 1–5); my two files; of what they
import, `Plane/Basic` and `Plane/WeakColouringOn` whole, and of `Plane/Radius`, `Plane/Cover`, `Plane/DensityPoints`,
`Plane/UnitPairs` the declarations my files name (`unitShadow`, `exists_angle_of_norm_eq_one`,
`preconnected_dist_lt_or_gt`, `continuous_e`).

**The build as given**: `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the
worktree, exit 0 — `build: OK — all 1853 modules already up to date, nothing built, 6 module(s) with warnings, 2s`
(`data/fs124/i2/logs/build-0-as-given.log`; the full output copied to `build-0-as-given-full.log`). The full log holds
**130 distinct `declaration uses sorry` warnings and no other warning**: 23 in `Plane/CircleCrossing`, 40 in
`Plane/OnePiece`, 29 in `Plane/ThreePiece`, 32 in `Plane/ClosePair`, 3 in `Plane/ClosePairModel`, 3 in
`Plane/SectorPoint` — the planner's count.

**My leaves, counted from the files**: 23 `sorry` in `Plane/CircleCrossing` (21 named theorems and 2 spec examples) and
40 in `Plane/OnePiece` (36 named theorems and 4 spec examples).

**How I iterate** (never evidence): `lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false
-Dlinter.missingDocs=true <file>` against this worktree's build, about 2 s a run for `Plane/CircleCrossing`. The built
`.olean` of `Plane/CircleCrossing` holds the statements `Plane/OnePiece` reads, and no statement changes, so the second
file elaborates against it as it stands; a helper added to the first file and used in the second needs the first rebuilt
(or the planner's overlay, `build/k2-iter.sh`).

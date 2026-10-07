# FS-124 — the kernel plan for the second module: what one piece of a colour forces at distance 1, and a close complementary pair (job FS124-K2)

*De Bruijn, the planner. Brief: `data/fs124/briefs/FS124-K2-kernel-plan.md` (on `main`). Claim list: `data/fs124/claims-K2.md`
(on `main`; nine statements: C124-SHADOW-OPEN, -CENTRE-HALF, -CENTRE, -STRADDLE, -TYPE, -FORCED-PIECES, -LONE, -BOTH, -FOUR).
Branch `fs124-wk2`, cut from `fs124-wk1` at `80ee1983`. Working files: `data/fs124/k2/`. The record is written in stages; each
is committed before the next starts.*

## Theorems this phase proved

None yet (a planning job; Stage 5 will list the leaves taken through the build to measure the price).

## Stage 1 — SAVED (FS124-K2): the readback and the build as given

**The brief's quotations against their sources.** `data/fs124/k2/readback.py <brief>` (the first module's script, with
sources looked up in this worktree, then in the main working tree) takes every quoted block with its `— source:` line and
looks for it, whitespace-normalized, in the file named: **13 of 13 found** (Kooshi's two passages; the nine statements' first
lines against `data/fs124/claims-K2.md`; `def AeProperOn`; `theorem radius_graph`). Control: `--control` changes the case of
one letter in each quotation and must find none of the thirteen — it found none (exit 0 on both runs).

**Read whole**: the brief; `plans/STANDING-RULES.md`; `LEAN.md`; `RUNNING.md` § Building and § Make the gate fail, and watch
it fail; `data/fs124/claims-K2.md`; the first module's three files (`Plane/WeakColouringOn`, `Plane/Radius`,
`Plane/RadiusOutside`) and its planner's record (`plans/FS124-kernel-plan.md`); of the library, by the shape of what the
nine statements need: `Plane/Basic`, `Plane/UnitPairs`, `Plane/DensityPoints`, `Plane/Closure`, the declaration lists of
`Plane/Cover`, `Plane/Chord`, `Plane/PlaneTopology`, `Plane/LocalMap`, `Plane/LocalStructure`, `Plane/ArcMap`, `Plane/Tiles`.

**The build as given**: `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from inside the
worktree, exit 0 — `build: OK — all 1847 modules already up to date, nothing built, 0 module(s) with warnings, 3s`
(`data/fs124/k2/logs/build-0-as-given.log`). No `sorry`, no warning.

**Two notes on the brief** (neither changes the job):
1. The claim list `data/fs124/claims-K2.md` and the brief are on `main` only; this branch does not hold them. I read them
   there and quote them from there.
2. The brief's `touches:` does not name `scripts/Axioms.lean` or `scripts/Assumptions.lean`; I leave both alone and list
   what a landing adds.

**Touches of fenced material, disclosed** (standing rule 8):
- At launch, the harness's context showed five commit subjects of `main`. Two are of this milestone's fenced lanes. The
  first: "FS124-P3: stage 1 — the re-read: thirteen expectations scored (five and a half missed); the map-class steps after
  the rhombus sorted by what each reads; six surprises with addresses — every held stop is the second common unit point of
  two pieced ring points whose labels are all six". What it carried: that the asking lane's re-read found, in the map class,
  stops at "the second common unit point of two pieced ring points whose labels are all six" — the configuration the last
  four statements are about, and no route to any of the nine. The second: "FS124-P3: stage 0 — the readback (11 of 11
  quotations) and thirteen expectations written before the items they are about were opened" — nothing of a route.
- 15:34 UTC, `git log --oneline -1 -- data/fs124/claims-K2.md` on `main`, run to date the claim list: it printed the first
  sixty characters of the subject "FS-124: inventory item 24 (the first module's impl…", which the launch context had
  already shown in full ("…implementer back); the kernel claim list for the second module; its planner's brief (FS124-K2),
  gate exit 0"). Nothing of a route.
- The first module's planner's record (open to me by the brief) names, in its § 4.2, the derivers' entry
  C124-EVERY-DIRECTION and its statement ("for a measurable weak colouring of a measurable `U`, every direction is good, not
  almost every one"), with the remark that its proof needs the continuity of translation in `L²`. That entry is not one of
  the nine; I note it because it is a statement of the derivers' that I have seen before phase 2.

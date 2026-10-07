# FS-124 — the kernel plan for the radius clause (job FS124-K1)

*De Bruijn, the planner. Brief: `data/fs124/briefs/FS124-K1-kernel-plan.md`. Claim list: `data/fs124/claims-K1.md` (five
statements: C124-RADIUS-GRAPH, -COUNTABLE, -UP, -DOWN, -FIVE). Branch `fs124-wk1`, cut from `main` at `596100d4`. Working
files: `data/fs124/k1/`. The record is written in stages; each is committed before the next starts.*

## Theorems this phase proved

None in the library: this is a planning job, and every leaf of the three skeleton modules is a `sorry`. Three leaves were
taken through `lean` outside the library to validate the model (`data/fs124/k1/lean/Probe1.lean`, Stage 2); they are
evidence for the plan, not theorems of the library.

## Stage 1 — SAVED (FS124-K1): the readback and the build as given

**The brief's quotations against their sources.** `data/fs124/k1/readback.py <brief>` takes every quoted block of the brief
with its `— source:` line and looks for it, whitespace-normalized, in the file named: **12 of 12 found** (Kooshi's two
passages; the five statements' first lines against `data/fs124/claims-K1.md`; `structure AeColouring`,
`AeColouring.exists_motion`, `chromaticNumber_plane_le_chiM0`; the two axioms). Control: `--control` changes the case of one
letter in each quotation and must find none of the twelve — it found none (exit 0 on both runs). The claim list in this
worktree is byte-identical to `main`'s copy (`diff`).

**Read whole**: the brief; `plans/STANDING-RULES.md`; `LEAN.md`; `RUNNING.md` § Building and § Make the gate fail, and watch
it fail; `data/fs124/claims-K1.md`; `Plane/AeColouring`, `Plane/UnitPairs`, `Plane/YesLimit`, `Outside/OAI158`,
`Plane/Basic`, `UnitDistance`; of the release (read-only, `/home/kooshi/source/math/lean/OAI/Geometry/PlaneColoring/`):
`Coloring.lean`, `WeakColoring.lean`, `MeasurableProper.lean`, `Basic.lean`, `Seven.lean` to line 70, and the declaration
headers of `BorelTransfer.lean`, `Compactness.lean`, `Five.lean`.

**The build as given**: `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh`, exit 0 —
`build: OK — 474 of 474 batches, 136 module(s) rebuilt, 0 module(s) with warnings, 20m37s`
(`data/fs124/k1/logs/build-0-as-given.log`).

**Three notes on the brief** (none changes the job):
1. The worktree's `.lake/build`, "its own copy, made today", was behind the branch by 136 modules; the first build took
   20m37s where a current copy takes about three minutes.
2. The list says "weak `k`-colouring" in GRAPH and COUNTABLE and "weak measurable `k`-colouring" in UP, DOWN and FIVE. By
   the list's own definition a weak colouring is measurable, so the two phrases name one notion; I read them so.
3. The brief's `touches:` does not name `scripts/Axioms.lean` or `scripts/Assumptions.lean`. I leave both alone; § the plan
   lists what the landing adds to them.

**Touches of fenced material, disclosed** (standing rule 8):
- 13:41 UTC, `git log --oneline | head -3` in the worktree, run to confirm the branch point. It printed the **subject** of
  commit `1eb1aa603`: "FS124-E1: stage 3 — C124-RADIUS derived: a random rigid motion on one open set per finite graph
  (C124-RADIUS-GRAPH), up, down at every k over the declared outside theorem, the five-colour corollary; gate exit 0, one
  control fired on its fault". What it carried: that the deriver's GRAPH moves one open set's colouring by a random rigid
  motion (the statement itself says "for almost every one of them"), that DOWN is over the declared outside theorem (the
  list's not-claimed line: "anything without that import"), that FIVE is a corollary. No body was read. The launch
  context also showed five subjects of FS-124 commits (FS124-P2 stage 0; inventory items 9 and 10; the re-posing brief;
  FS124-E1's report), none naming a route.
- 13:54 UTC, the session's shared scratch directory: I wrote one object file of my own under
  `scratchpad/olean/Proofs/HadwigerNelson/Plane/` and the listing I printed showed that the directory already held
  symbolic links, named after existing `Plane` modules, into worktree `fs132-wk1`'s build. Nothing of FS-124 was in what
  I saw. I removed my file and have used `build/` inside this worktree since (ignored by git).

*Instance file for job **FS112-YB2**, the round-2 blind verifier of FS-112's construction side. Its brief is
`data/fs112/briefs/YB112-verify-construction.md`; this file is part of it and overrides it where they differ. Filled in by the owner on 2026-09-27,
when FS112-Y2 handed back. The side's verdicts are withheld.*

## Overrides of the brief for this instance

- **Your job id** is FS112-YB2; **your record** `plans/FS112-YB2-verification.md`; **your working directory** `data/fs112/fs112-yb2/`; **your tools**
  `tools/fs112_yb2_*.py`; **your commit subjects** "FS112-YB2: stage n"; **your report** `data/fs112/reports/FS112-YB2.md`; **your scratch**
  `scratchpad/fs112-yb2/`.
- **The side verified:** round 2 of the construction side, FS112-Y2 — the section "§ Continuation — FS112-Y2" of `plans/FS112-Y-construction.md`, its tools
  `tools/fs112_y2_*` and its outputs `data/fs112/fs112-y/y2_*`. **All fenced until your step 3 is committed.** Open to you: the earlier sections of
  `plans/FS112-Y-construction.md` (round 1), round 1's verifier record `plans/FS112-YB-verification.md` and report `data/fs112/reports/FS112-YB.md`, and
  YB's tools `tools/fs112_yb_*.py` (run, never edit). Also fenced: `data/fs112/fs112-a2/`, `data/fs112/fs112-a3/`, with the rest of your brief's list.
- **Your checker must go beyond YB's.** The disk's coordinates need `sin 72°` (a cyclic quartic over ℚ); YB's checker is multiquadratic and cannot
  represent them. Build `tools/fs112_yb2_check.py` over a tower of square-root extensions (for instance ℚ(√5)(√(10 + 2√5))), with exact comparisons, and
  calibrate it first on the strip (it must reproduce YB's verdict on YB's own strip object), then on CAL-PLANT-style faults beside faithful twins.
- **The D5 conditions** (the owner's ruling) bind your rebuild: transcribe `[Polymath2021]` Fig. 10's combinatorics **by eye, yourself**, and commit the
  transcription before any solve; report an ambiguity, never resolve it by trying alternatives with a solver; no pixel fitting.

## The objects

**O1. The six-coloured disk** (CAL-DISK; claims §7). From `[Polymath2021]` pp. 197–200 and its Fig. 10
(`~/source/library/geombinatorics/geombinatorics-v30-n4-2021-04.pdf`), with the thread extracts `data/fs112/fs112-pa/extracts.md` [11.34] (*"a skeleton
from five connected regular pentagons with unit edges"*, radius `√((25 + 9√5)/10)`) and [07.49], [16.346]. Rebuild it by formula; check it; report its
radius exactly (the printed value is the control), every vertex's colour set, every boundary arc of radius 1 with its centre and contact kind (claims §0),
whether each arc's end vertices lie inside the coloured interior (C-ARC-END), every close complementary pair and its common unit points, and every point of
the disk's rim near which no colour can be given to the points just outside with the disk's colouring unchanged.

**O2. The stopping points of both positives.** On the strip (your own rebuild or YB's object) and on your disk: for each close complementary pair of vertices
whose common unit points include a four-colour unit-arc centre, report its **other** common unit point — where it lies, and whether any colour can be given
there (or just outside the object near it) with the object's colouring unchanged. State whether the two positives stop for the same reason.

**O3. A move at the disk's rim.** At a rim point of O1 where no colour is available: bend a straight side of an adjacent tile that is a chord of that point's
unit circle into the unit arc of the same circle through the chord's ends (and the mirror move at the symmetric point), in all five sectors. Report: is the
moved disk valid (check it); the kinds of its new unit arcs; which colours become available at the rim point, in which directions; and whether a colourless
set of directions remains, with its exact angular width before and after the move.

**O4. The strip's forced sectors.** At the strip's valley `V₀ = (0, √3/2)` and apex `A₁ = (3/4, √15/4)` (YB's O3 placing): which colours are forced in which
directions by the neighbouring four-colour midline vertices, how many directions stay free, and whether any change confined to those free directions (or to
the neighbourhoods of `V₀`, `A₁`) can make a colour available at the edge point where YB found none.

**O5. The largest vertex-centred disc.** The radius of the largest closed disc centred at a vertex that lies wholly inside the coloured disk of O1; and
whether any valid extension of O1 can hold a larger one.

**Then** (your brief's step 4): read Y2's section and tools, and list every divergence with both addresses.

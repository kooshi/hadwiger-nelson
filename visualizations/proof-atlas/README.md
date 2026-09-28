# The Proof Atlas

Published artifact (private until shared): **https://claude.ai/artifact/7zzeXoXvTLHzqf4mTQujzx** (Version 1, 2026-09-27).

An explorable map of the logic of the Hadwiger–Nelson hunt, built for Kooshi by job VIZ-ATLAS on 2026-09-27; its theme control and dark palette
by VIZ-ATLAS-2. The three possible answers, `χ(ℝ²) = 5, 6, 7`, sit at the centre, each ringed by its two halves; every key theorem, missing step
and no-go lies outward in the sector of the answer it serves, so a route reads as a path inward. Solidity is the grade (solid is kernel, hollow
red with a question mark is missing, octagons are no-gos with a blocked edge). Click any mark for its card: the statement in plain words and in
the source's words, the grade as the source writes it, the source address, and what it rests on and what rests on it. The Routes tab gives each
route's distance to its answer in **bits** (the sum of `−log₂ p` over its links) and its distance to publication (links not yet in Lean); the
Credences tab lets you move every credence and watch the distances recompute. The Theme control at the top right picks System (the viewer's or
the device's setting), Light or Dark, and remembers the choice in this browser. The design, the alternatives it was chosen against, the distance
measure and the palette review are in `DESIGN.md`.

## Files

| file | what |
|---|---|
| `DESIGN.md` | the frame and two alternatives, the encodings, the grade fold, the distance measure and its defaults, the scope, stage records |
| `page.tmpl.html` | the page, with a `/*FACTS*/null` marker |
| `build.py` | runs the checker and the palette review, checks the two dark token blocks agree, refuses on any failure, inlines the facts → `index.html` |
| `index.html` | the built page, the file to publish |
| `../../data/viz/proof-atlas/facts.json` | the one table every mark is drawn from: statement, verbatim quote, address, the source's grade words, registered probabilities |
| `../../tools/viz_proof_atlas_facts.py` | writes the table from hand-authored entries; prints a label-overlap lint for the layout |
| `../../tools/viz_proof_atlas_check.py` | re-reads every quote and grade from its address; `--self-test` plants seven faults, each must fire exactly once |
| `../../tools/viz_proof_atlas_common.py` | normalisation, the grade fold, source addressing, and the fence (files never opened) |
| `../../tools/viz_proof_atlas_contrast.py` | the palette review at both themes: contrast of text and marks, separation of the hues that meet; `--self-test` plants a pale text token and a confusable pair |

## Build, check, publish

```
python3 tools/viz_proof_atlas_facts.py              # writes the table; prints a label-overlap lint ("layout lint: 0 overlaps")
python3 tools/viz_proof_atlas_check.py              # "checked 169, failed 0, errors 0" after FS-112's close
python3 tools/viz_proof_atlas_check.py --self-test  # "SELF-TEST PASSED": eight plants, each fires once
python3 tools/viz_proof_atlas_contrast.py           # "palette review: 0 failed"
python3 tools/viz_proof_atlas_contrast.py --self-test
python3 visualizations/proof-atlas/build.py         # refuses unless the checker and the palette review pass
```

## Updating at a close

Kooshi wants the page kept current: it is refreshed at every milestone close, and the owner republishes `index.html` to the same link
(https://claude.ai/artifact/7zzeXoXvTLHzqf4mTQujzx), so viewers keep their theme and credence settings.

1. **Re-run the checker first**, before editing anything: `python3 tools/viz_proof_atlas_check.py`. It names every quote that no longer stands at its
   address. Ranked-stub rows are addressed by rank number (`PF(n)` in the table's builder), so a re-rank moves them.
2. **Re-read, from disk, what the close changed**: the close's new `LEDGER.md` rows and their § B lines (§ B lines are addressable as rows, e.g.
   `{"file": "LEDGER.md", "row": "FS112-N3-DENSE3"}`); the milestone's `plans/FSnn-derivation.md` and its plan's §R-close; the stubs it minted or
   re-aimed; `plans/FRONTIER-STUBS.md`; `CLAUDE.md` § The aim, § Where the problem stands, § Paths forward, ranked and any new grokking; and the
   advisor's notes for the atlas keeper, if the close had one.
3. **Fold it into `tools/viz_proof_atlas_facts.py`**: every node and edge a verbatim quote at an address, every grade the source's own words (the
   page status is computed from them). A missing step takes the registered probability its stub gives *for that event*; a registration for a
   different event (for example "decided either way") goes on the card as the stub's words, not into the distance. Mark every question posed in
   print that the close answers or reduces (`posed=`, with the words that say so; the checker refuses "answered" when the words do not say it).
4. **Fence** any file another job is writing that night (`FENCED` in `tools/viz_proof_atlas_common.py`): the checker refuses an address inside it
   before reading.
5. **Build and check**: the commands above; fix the layout lint's overlaps by moving marks, then look once at each theme (a headless screenshot of the
   page wrapped in the publish skeleton, network off) and make one pass of edits.
6. **Record** the close in `DESIGN.md` (a stage section: what moved, the distances at the defaults, what was left out), commit by explicit path,
   push, and tell the owner, who republishes.

## Three questions to ask it

1. *How far is seven, and what is missing?* Click the 7 tile: the regularity wall lights up. Two things are missing — FS-114's global step, which is
   the whole remaining unit-arc question, and FS-111's cone scale — and one link, the meeting of the two doors, is held only as a one-mind reading.
   The stuck ray (FS-115) sits beside the route, needed only by the four-colour form of the NO.
2. *Why does five look nearer than seven?* Read the counts under the bits: five's distance is one open question (a stationary five-colouring of the
   plane); seven's is one open question, one named step and one reading. Bits count only what somebody has named.
3. *What would it take to publish?* The "links still to put in Lean" count on each tile, and the square marks (FS-113, FS-101, the wall's own chain).

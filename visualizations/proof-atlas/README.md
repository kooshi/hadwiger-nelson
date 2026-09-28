# The Proof Atlas

An explorable map of the logic of the Hadwiger–Nelson hunt, built for Kooshi by job VIZ-ATLAS on 2026-09-27. The three possible answers,
`χ(ℝ²) = 5, 6, 7`, sit at the centre, each ringed by its two halves; every key theorem, missing step and no-go lies outward in the sector of the
answer it serves, so a route reads as a path inward. Solidity is the grade (solid is kernel, hollow red with a question mark is missing,
octagons are no-gos with a blocked edge). Click any mark for its card: the statement in plain words and in the source's words, the grade as the
source writes it, the source address, and what it rests on and what rests on it. The Routes tab gives each route's distance to its answer in
**bits** (the sum of `−log₂ p` over its links) and its distance to publication (links not yet in Lean); the Credences tab lets you move every
credence and watch the distances recompute. The design, the alternatives it was chosen against, and the distance measure are in `DESIGN.md`.

Published artifact: not yet (the owner publishes `index.html`).

## Files

| file | what |
|---|---|
| `DESIGN.md` | the frame and two alternatives, the encodings, the grade fold, the distance measure and its defaults, the scope, stage records |
| `page.tmpl.html` | the page, with a `/*FACTS*/null` marker |
| `build.py` | runs the checker, refuses on any failure, inlines the facts → `index.html` |
| `index.html` | the built page, the file to publish |
| `../../data/viz/proof-atlas/facts.json` | the one table every mark is drawn from: statement, verbatim quote, address, the source's grade words, registered probabilities |
| `../../tools/viz_proof_atlas_facts.py` | writes the table from hand-authored entries; prints a label-overlap lint for the layout |
| `../../tools/viz_proof_atlas_check.py` | re-reads every quote and grade from its address; `--self-test` plants seven faults, each must fire exactly once |
| `../../tools/viz_proof_atlas_common.py` | normalisation, the grade fold, source addressing, and the fence (files never opened) |

## Build, check, publish

```
python3 tools/viz_proof_atlas_facts.py
python3 tools/viz_proof_atlas_check.py              # "checked 151, failed 0, errors 0" on 2026-09-27
python3 tools/viz_proof_atlas_check.py --self-test  # "SELF-TEST PASSED"
python3 visualizations/proof-atlas/build.py
```

When a source moves (a ledger row rewritten, FS-112's close landing), rerun the checker first: it names every quote that no longer stands at its
address, and the build refuses until the table is corrected.

## Three questions to ask it

1. *How far is seven, and what is missing?* Click the 7 tile: the regularity wall lights up; four named missing steps (the global step, the stuck
   ray, how they compose into a NO, and the cone scale) sit hollow and red in the top sector, everything outward of them solid.
2. *Why does five look nearer than seven?* Read the counts under the bits: five's distance is one open question nobody has reduced (a stationary
   five-colouring of the plane); seven's is four named steps. Bits count only named steps.
3. *What would it take to publish?* The "links still to put in Lean" count on each tile, and the square marks (FS-113, FS-101, the wall's own chain).

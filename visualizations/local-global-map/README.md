# The Local–Global Map

Published artifact (private until shared): **https://claude.ai/artifact/EpJZ2qMLnqEJtuKEXNEKHu** (Version 1, 2026-09-26).

One map of what the Hadwiger–Nelson workspace knows after the crunch of 2026-09-25, built for Kooshi by crunch job J43. Unlike the
three atlases beside it (one object or one question at a time), it is a single frame: **every field is a row, every place is a column,
and height inside a row is the number of colours.** A bar is the fewest colours a place's finite plane is proven to need; a dot is a
colouring that exists there, one we own. Past a horizon ("infinitely many places") stands the whole plane over the field, with its proven
range. The local–global conjecture is then a picture: the last column should stand exactly at the lowest column. Violet **shadows** are
the four wanted posters — a four-colouring over ℚ(√47), a non-pullback four-colouring over the type-(B) fields, a five-colouring over
ℚ(√167), a six-colouring of the plane — drawn dotted where the records carve them away, solid where a door is left open, fading past the
horizon. **Walls** are drawn where they stand (dark, a padlock: its card says what getting past it would take) or where they were broken
(teal, dashed: its card names what broke it — an invariant every colouring carries, or a construction; G79). Solidity is the grade.
The design, the alternatives it was chosen against, and the encodings are `DESIGN.md`.

## Files

| file | what |
|---|---|
| `DESIGN.md` | the frame (four parts, three alternatives), the encodings, what "standing" and "broken" mean, the fact list, the experience pass, stage records |
| `page.tmpl.html` | the page, with a `/*FACTS*/null` marker |
| `build.py` | runs the checker, refuses on a failure, inlines the facts → `index.html` |
| `index.html` | the built page, the published file |
| `../../data/viz/local-global-map/facts.json` | the one table every mark is drawn from: value, grade, the source's own grade words, source address, pattern |
| `../../tools/viz_local_global_map_build.py` | assembles the table (hand-authored facts with verbatim patterns; the ledger's 829 theorems; the place rule) |
| `../../tools/viz_local_global_map_check.py` | re-reads every fact from its source; recomputes places by brute-force square roots and controls them against `data/fplane/map.json`; `--self-test` plants a wrong grade, a wrong number, an unreadable source, a wrong theorem grade and a wrong place state, each of which must fire exactly once, naming its fact |
| `../../tools/viz_local_global_map_common.py` | normalisation, the grade fold, the ledger parser, the keyword tag rule |

## Build, check, publish

```
python3 tools/viz_local_global_map_build.py
python3 tools/viz_local_global_map_check.py            # "checked 1593, failed 0, errors 0" on 2026-09-26
python3 tools/viz_local_global_map_check.py --self-test
python3 visualizations/local-global-map/build.py
```
Then republish `index.html` to the URL above.

## Where its values come from

`data/fs53/window.md` and `data/fplane/map.json` (the finite planes' floors and caps, with their trust tags); `LEDGER.md` rows 33, 52, 53,
57, 64, 69, 70, 73, 75, 80, 82, 85, 88, 89, 91, 94, 96, 98, 99, 101, 102, 103, 110, 112, 113 (the fields' values, the colourings owned,
the carves, the walls) and all of § B (density); `CLAUDE.md` G22, G34, G38, G44, G55, G61 and the mission text; the Poros wanted posters
`plans/POROS-2026-09-25-wanted-poster-{47,59,167}.md` and `plans/POROS-2026-09-25-infinitely-many-primes.md`; FS-100's stub and
`plans/FS100-KT1-ambrus-ball.md` (the real place's `m₁(ℝ²) ≤ 0.246989`).

**Three rules the page keeps.** Grades are the source's own words folded to seven steps (`DESIGN.md` §1.3; exact arithmetic inside a hand
proof does not lower it). Theorem density counts *mentions* found by a keyword rule, not coverage: 618 of the 829 theorems name no field in
the map. The field list is every field the records name as an example, a test or a prediction, not every field.

## Three questions to ask it

1. *Why is ℚ(√47) the cheapest test of the conjecture, and what would a counterexample have to be?* Its row: every bar at 5 or more, the
   whole plane at 4–5, the violet line at four carved at every column and surviving only past the horizon.
2. *Where does the real place matter, and why does it stop at five?* The ∞ column: a standing wall at four (m₁ < 1/4, certified) pushes
   the four-colour shadows right; ℚ(√167)'s five-colour shadow keeps an open door there.
3. *Where is the knowledge thin?* The density bars under the names and above the columns; hatched where nothing mentions a field or place.

**Not yet done:** a look at the rendered page by a human eye — no browser is installed on this machine, so the first visual review is
Kooshi's; a fix pass follows what he reports.

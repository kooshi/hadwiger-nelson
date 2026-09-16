# Controls for `tools/fplane_sat_cube.py` — the adaptive cube-and-conquer decider

The tool's own controls, kept because **a check is not known to work until it has been seen to fail**, and
because two of these were written after the first pair passed without exercising the path they were meant
to test.

| file | what it controls | result |
|---|---|---|
| `cube-ctl-adapt-13-4.json` | `(13,4)` through the adaptive path must be exhaustively UNSAT | UNSAT, 16 cubes, **0 splits** |
| `cube-ctl-adapt-13-5.json` | `(13,5)` must be SAT with a colouring whose self-check is clean | SAT, **0 monochromatic edges** in the extracted colouring |
| `cube-ctl-split.json`, `cube-ctl-split.jsonl` | **the splitting path, forced.** The first control passed with zero splits, so it had not tested splitting at all. `(17,4)` — whose monolithic solve takes 11.6 s — under a **1 s** cap at depth 2 must split and must still reach the right answer | **3 splits fired**, deepest 3, verdict still exhaustive UNSAT |
| `cube-ctl-split2.json` | **resume.** Half the checkpoint deleted; the rerun must rebuild the frontier and reach the identical verdict | rebuilt 6 decided + 2 split → 7 outstanding; identical verdict, 15 decided / 3 split |

A fifth control has no artifact because its output is a refusal, not a file: a checkpoint written for a
different vertex order is **REFUSED by name** (`--q 17 --k 5` against a `--q 17 --k 4` checkpoint prints the
two digests and exits) rather than silently misread.

The encoding's own controls — `(11,4)` UNSAT, `(11,5)` SAT, `(13,4)` UNSAT, `(13,5)` SAT, `(17,4)` UNSAT —
run with `python3 tools/fplane_sat_cube.py control`. Measured 3.51 s and 11.58 s on the last two, against
3.48 s and 11.55 s recorded independently the day before: within 1 %.

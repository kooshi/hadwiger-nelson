# FS-61 — the paired controls on the census instrument (gate 0.4)

*Produced by `python3 tools/fs61_census.py regress controls`. Source of truth: `data/fs61/regress/controls.jsonl`
and the per-field `data/fs61/fields/<d>/balls.jsonl`. Machine: desktop (16 physical cores / 32 threads, 128 GB).*

Seven fields whose plane needs two or three colours (prior art: `[Johnson1987]`, `[Fischer1990]` Thms 8-9) are
scanned with the 3-integrality filter OFF, so every rank-4 lattice under the point cap is asked whatever its
certificate. None of them may contain a ball that refuses three colours, and over the two-chromatic ones no
lattice may be non-bipartite. Beside them, the identical command on `d = 47`, where a ball must refuse: a
control that cannot go red has not been tested by passing.

| d | role | chi | lattices (bipartite) | balls asked | verdicts | result |
|---|---|---|---|---|---|---|
| 2 | negative control | 2 | 174 (174) | 348 | 125 Colourable (colouring verified), 218 Over cap (not asked), 5 Unknown (budget) | **PASS** |
| 5 | negative control | 2 | 133 (133) | 266 | 91 Colourable (colouring verified), 169 Over cap (not asked), 6 Unknown (budget) | **PASS** |
| 7 | negative control | 3 | 143 (32) | 286 | 111 Colourable (colouring verified), 171 Over cap (not asked), 4 Unknown (budget) | **PASS** |
| 13 | negative control | 2 | 65 (65) | 130 | 47 Colourable (colouring verified), 80 Over cap (not asked), 3 Unknown (budget) | **PASS** |
| 19 | negative control | 3 | 56 (25) | 112 | 52 Colourable (colouring verified), 59 Over cap (not asked), 1 Unknown (budget) | **PASS** |
| 31 | negative control | 3 | 75 (18) | 150 | 72 Colourable (colouring verified), 76 Over cap (not asked), 2 Unknown (budget) | **PASS** |
| 43 | negative control | 3 | 29 (10) | 58 | 27 Colourable (colouring verified), 27 Over cap (not asked), 4 Unknown (budget) | **PASS** |
| 47 | positive control | at least 4 | 55 (8) | 110 | 47 Colourable (colouring verified), 59 Over cap (not asked), 3 Refused (solver claim), 1 Unknown (budget) | **PASS** |

Any `FAIL` row is an instrument defect and one of the plan's five halts (§5 rule 15): stop and report, never repair and continue.

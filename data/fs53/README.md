# FS-53 — the sixth colour: records (one row per file; the milestone's plan is `plans/STUB-sixth-colour.md`)

*Every record here says what produced it and what it can claim. A local search's `not_found` is a null with a budget, never
a refusal; a `found` colouring is verified proper by the tool's independent sweep from the definition (and is a certificate
of χ ≤ k once re-verified here). All runs below: the Rust `plane-colour` (`~/source/descent-engine`, tabu local search,
12 threads, seed 1) on the desktop, 2026-09-15, during FS-53's subplanning (the advisor's card 1: nobody had asked a window
plane for six colours). The GPUs were busy with FS-50's solves; these are CPU runs.*

| file | plane, k | budget | verdict | claim scope |
|---|---|---|---|---|
| `colour-p23-k8-control.json` | 23, 8 | 60 s | **found** in 1.5 s | positive control (a line-periodic 8-colouring exists, `data/fplane/periodic-below-71.json`): the instrument finds colourings that exist at this size |
| `colour-p19-k5-control.json` | 19, 5 | 60 s | **found** in 8.7 s | positive control (χ(19) = 5 on the solver's word, `data/fplane/chi-p19-k5.json`) |
| `colour-p23-k6.json` | 23, 6 | 300 s | not found; best 116 of 6,348 edges monochromatic (1.83 %) | a null at the budget; six at 23 is neither found nor refused |
| `colour-p23-k7.json` | 23, 7 | 120 s | not found; best 38 of 6,348 (0.60 %) | a null; χ(23) ≤ 8 stands from the periodic colouring |
| `colour-p31-k6.json` | 31, 6 | 120 s | not found; best 208 of 15,376 (1.35 %) | a null |
| `colour-p43-k6.json` | 43, 6 | 120 s | not found; best 1,167 of 40,678 (2.87 %) | a null |
| `colour-p47-k6.json` | 47, 6 | 120 s | not found; best 1,867 of 53,016 (3.52 %) | a null |

Logs (not committed): job tmp `fs53/colour-p<p>-k<k>.log`. Rerun: `plane-colour --p <p> --k <k> --threads 12 --max-seconds <s> --out <file>`.

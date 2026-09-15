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

## The row format, fixed at subplanning (2026-09-15, the planner; `plans/STUB-sixth-colour.md` §S)

Every file gets one row, and a row carries **five things or it is not a row**:

| column | what it must say |
|---|---|
| **file** | the committed path, never a log under `build/` or a job's tmp |
| **what it is** | the plane (`q`) and the question (`k` colours, or a target independent-set size `N`) |
| **budget** | wall-clock seconds, threads, seed — and for a semidefinite solve, the iteration count and both residuals |
| **verdict** | `found` / `not_found` / `CERTIFIED` / `unsat` / `unknown`. **`not_found` and `unknown` are nulls at a budget and are written in those words**; neither is ever "refused" |
| **claim scope** | one sentence naming what the row licenses *and what it does not* — in particular which of `[exact]`, `[cert]`, `[solver]`, `[search]`, `[kernel]` it is, in `data/fs53/window.md`'s vocabulary |

Two standing rules, from the failure modes this milestone's instruments actually have.

**Every graph carries an `edges_sha256`.** The finding side and the refusing side fail in opposite directions: a
*missing* edge makes a colouring easier and a refusal safer, an *invented* edge does the reverse. A hash in the record is
what lets a later row be compared against an earlier one instead of against a description of it.

**An iterate is never a bound.** A semidefinite solver's objective at iteration `m` is a number in flight; only a
rounded, exactly checked dual is an upper bound on `α`, and only the untouched checker's `CERTIFIED` line decides. FS-50
measured the trap: a rounding taken from a long-run iterate landed 200 above the objective because the solver's adaptive
scale is not checkpointed, where a fresh short continuation's own dual rounded to within 9.

## The subgroup-quotient sweep at q = 27 (the planner, 2026-09-15)

| file | plane, k | budget | verdict | claim scope |
|---|---|---|---|---|
| `periodic-q27.json` | 𝔽₂₇, 6 | exhaustive at subgroup index 9 and 27; 40 DSATUR restarts at index 81 and 243; 234 s, one core | **none six-colourable**; best found **7**, at index 27 | a colouring constant on the cosets of a subgroup pulls back to the plane, so the 7 is a **verified** upper bound: `χ(UD(𝔽₂₇,2)) ≤ 7`, the first of any kind at 27, and with the ratio bound's floor `⌈729/162⌉ = 5` the bracket is `χ ∈ {5,6,7}`. The six-colour null is **exact** at index 9 (11,011 subspaces, 2,100 usable) and index 27 (33,880, 20,216) and a **null at a budget** at index 81 (11,011, 9,408) and 243 (364, 350). It refuses nothing about the plane: a colouring of the plane need not be periodic |

Rerun: `python3 tools/fplane_periodic_subgroups.py --q 27 --k 6 --out data/fs53/periodic-q27.json` (controls:
`--self-test`). The record is rewritten after every dimension and carries `partial` and `dims_done`, so a killed run
leaves what it finished and `--dims` names the redo. Over a **prime** field this family is only the `p + 1` lines
(`data/fplane/periodic-below-71.json`); over `𝔽₂₇` the additive group is `(ℤ/3)⁶` and every `𝔽₃`-subspace is a subgroup,
which is why the family is 56,266 subspaces rather than 28.

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

| `colour-q27-k7-quotient.json` | 27, 7 | — | **found**: a 7-colouring of UD(𝔽₂₇,2) constant on the cosets of a 3-dimensional 𝔽₃-subspace, for BOTH bases named in the record (`periodic-q27.json`'s dim-3 `best.basis`) and in the subplan §S3 (the scratch run's) — each quotient 27 vertices, connection set 12, 7-colourable and not 6-colourable by exhaustive backtracking; pulled back and verified proper on every one of the 10,206 edges by an independent rebuild of the field (de Bruijn's review script, sharing nothing with `tools/fplane_periodic_subgroups.py`) | **χ(UD(𝔽₂₇,2)) ≤ 7, exact-rational trust** (a colouring table; kernel form waits on K1's certificate over 𝔽₂₇, which `finitePlane 27` is NOT — ℤ/27 is a different ring) |

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

Since FS-53 phase A0 (`data/fs53/PHASE-A0.md`) every row also carries `best_witness`: the quotient colouring behind
`best_k_found` AND its pullback to the plane, 729 entries under `data/fplane/chi-q27.json`'s vertex index, verified on
all 10,206 plane edges before the record is written — so the record's own ceilings (9 / 7 / 9 / 11 at index 9 / 27 / 81 /
243) are re-checkable from the file alone. All four re-verified through `tools/fplane.py`'s independently built edge
list: 0 monochromatic edges of 10,206 each. The dimension-3 witness sits on the same basis as
`colour-q27-k7-quotient.json` above and carries a different, equally proper 7-colouring on it.

Rerun: `python3 tools/fplane_periodic_subgroups.py --q 27 --k 6 --out data/fs53/periodic-q27.json` (controls:
`--self-test`). The record is rewritten after every dimension and carries `partial` and `dims_done`, so a killed run
leaves what it finished and `--dims` names the redo. Over a **prime** field this family is only the `p + 1` lines
(`data/fplane/periodic-below-71.json`); over `𝔽₂₇` the additive group is `(ℤ/3)⁶` and every `𝔽₃`-subspace is a subgroup,
which is why the family is 56,266 subspaces rather than 28.

## The first exact certificate at a prime-power plane — α(UD(𝔽₂₇,2)) ≤ 147 (FS-53 phase A0.4, 2026-09-15)

| file | plane | budget | verdict | claim scope |
|---|---|---|---|---|
| `cert-q27-N147.json` | 𝔽₂₇ (`q = 27 = 3³`, modulus `t³ − t − 1`, named explicitly and never inferred) | the rounding and the check: 62 s of one core | **CERTIFIED** by the untouched `tools/fplane_cert_check.py`: `N = 368945166004872794530764081061/2500000000000000000000000000`, so **α ≤ 147** | an **exact rational** bound on the independence number, re-checkable by a stranger: the checker rebuilds the group, its 1,847 pair orbits and the 3,694 canonical rows from the number 27 and the modulus alone, checks the multipliers' signs, the rational Gram factors and the affine identity exactly, and confirms the file's `edges_sha256` is the hash of the plane it rebuilt. Nothing here is the solver's word |
| `sdp-q27.json` | 𝔽₂₇ | 79 s, real blocks, SCS | the relaxation's optimum **147.5779** `[solver]` | a **float reading**, never a bound. Measured twice through formulations sharing only the field — 147.5779 in real blocks (79 s) and 147.5780 unreduced (398 s) — and the certificate above was rounded from a third solver's dual (CLARABEL, float bound 147.5774). Three solvers, agreeing to 5 × 10⁻⁴ |

**What it decides, and what it does not.** `⌈729/147⌉ = 5`, so the floor stays `χ(UD(𝔽₂₇,2)) ≥ 5` — the certificate does
**not** move it. Six needs `α ≥ 122` and is untouched. **Five needs `α ≥ 146`, and the certificate says `α ≤ 147`** — so
five at 27 is not refused, but it survives in a window **two integers wide**: a five-colouring of the 27-plane requires
its independence number to be 146 or 147, within one of the certified maximum. That is the narrowest any five-question
has been anywhere in this project, and the finding side at 27 now has a second, sharper target than the six-threshold.

**The instrument's reach at 27 is 147.578 / 162.000 = 0.9110 of the ratio bound — the worst measured anywhere**
(0.8445 at 11, 0.8238 at 23, 0.8836 at 83). It is the first reach measured at a **prime power**; it is *not* the first
at a window member — **23 is in the window and was measured at FS-50** (0.8238, the best of the four). Both the phase's
implementer and the product owner wrote "first at a window member" before checking; the four measurements split two in
the window (23, 27) and two outside it (11, 83), and the window half alone already spans 0.8238 to 0.9110. It is a converged value, not a
compute artifact: two formulations and three solvers agree. `plans/STUB-sixth-colour.md` §S6 P3 predicted the
certificate would refuse five at 27; **it does not, and P3 is falsified there.**


## Two `edges_sha256` conventions, and the bridge between them (the product owner, 2026-09-15)

`data/fs53/window.md`'s cells are filled from **two** toolchains, and both write a field named
`edges_sha256` **computed differently**, so the same graph carries two different digests:

| written by | convention | at `q = 23` |
|---|---|---|
| `tools/fplane.py`, `tools/fplane_periodic_subgroups.py`, `tools/fplane_cert_check.py` | sha256 of `repr(sorted [(min, max)])` over the undirected edge list | `9e7c0a81f67cb8c2…901e6613b3` |
| `~/source/descent-engine`'s `plane-colour` and `plane-independent` | sha256 of each endpoint as a **little-endian u32**, same sorted undirected list | `4321f5f1880fff97…49aa25bb3` |

Standing rule 5 exists so that "a later record can be compared against" an earlier one, and across the tool boundary
that comparison silently fails: two honest records of one graph disagree. **The bridge is committed rather than
documented:** `tools/fplane_review_verify.py` now computes **both**, prints both, accepts either under
`--expect-sha`, and carries a control that reproduces `plane-colour`'s own digest at `q = 23` from the definition —
so the two toolchains are confirmed to build **the same graph**, and the difference is serialisation only. Run
`python3 tools/fplane_review_verify.py graph --q <q>` to get both numbers for any member. **Confirmed from three
independent rebuilds** — `plane-colour`'s own, the product owner's, and the Rust engineer's re-derivation in Python from
the claimed convention alone — that the 6,348 edges at `q = 23` are the same set under both digests.

**The ruling, and the fix when the wire form is next opened** (the product owner, 2026-09-15, on the engineer's
doctrinal point): the records already carry `vertex_index` and `edge_rule` **because a reader who indexes `y·p + x`
would call a correct colouring improper**, and then `edges_sha256` shipped one paragraph later with no statement of how
it was computed — the same rule, unapplied to the field that needed it most. A stranger holding one record cannot
reproduce its digest. **Both toolchains add a self-describing `edges_sha256_rule` string** (e.g. *"sha256 of u,v as
little-endian u32 over the ascending edge list"*) **when their record shape is next amended, and the Rust side's
deadline is before phase A.2 writes the milestone's colouring records**, so every FS-53 artifact carries it. Not done
now, and deliberately: a field added mid-phase would split the milestone's own records into two shapes, which is the
trap one level up. Filed as the engine's D95.

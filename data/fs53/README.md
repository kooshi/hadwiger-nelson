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

## Phase B — the certificate side (de Bruijn, 2026-09-15)

### The certificates

| file | plane | cost | what it says | trust |
|---|---|---|---|---|
| `cert-q79-N1023.json` (13.1 MB) | 𝔽₇₉ | graphics card A; the producer reached 6,500 iterations, and the certificate is from a **2,000**-iteration iterate resumed +500 in a fresh solver (796 s including the 183 s data build) | **CERTIFIED** by the untouched `tools/fplane_cert_check.py` (`--k 6`): `N = 2558455072391901331428007922088014151122727/2.5·10³⁹ = 1023.382029`, so **α(UD(𝔽₇₉,2)) ≤ 1023**, and `6 × 1023 = 6138 < 6241`: **six is refused at 79**, `χ(UD(𝔽₇₉,2)) ≥ 7` | an **exact rational** bound. The checker rebuilds the group, its 42,693 pair orbits and the 85,386 canonical rows from the number 79 alone, checks the multipliers' signs, the rational Gram factors and the affine identity exactly. Nothing is the solver's word. `--ldl` green, all 82 blocks re-run clean (`ldl-q79-N1023.log`). **Every one of the 18 cuts in the sweep gives ⌊N⌋ = 1023** (1023.382029–1023.413092 over thresholds 10⁻⁹, 10⁻⁸, 10⁻⁶ × gram denominators 10⁶, 10⁸, 10¹⁰ × weight denominators 10⁸, 10¹⁰) |

**79 leaves the window.** It was the largest live member and carried `frac6 = 0.9471`; it is now `χ ≥ 7`, and the window
for an exactly six-chromatic finite Euclidean plane is **seven members: 23, 27, 31, 43, 47, 59, 67**.

**The margin, so the reader can see how little the instrument had to work for it.** The ratio bound gives 1099.19 and six
needs 1040; the certificate lands at 1023, which is **17 integers inside the threshold and 76 below the ratio bound** —
and it came from an iterate of 2,000 iterations whose primal residual was still 7.1 × 10⁻¹. 79 was never the hard one.

### The `le_diag` experiment: the whole constraint class is inactive, not just the extra rows (phase B item 0)

**The question.** Two relaxations exist. The **certified** one carries the `le_diag` row `y[k] ≤ y[diag]` **once per pair
orbit** — the frozen checker's canonical list, the only form it verifies. The **tighter** one
(`tools/fplane_sdp_blocks.py`, `tools/fplane_sdp_scs.py`) imposes it at **every** diagonal class the orbit meets. At 83
the two solves were never comparable (they ended 435× apart in primal residual, `data/fs50/README.md`'s last section),
and the predicted six-refusal at 67 has only 0.9 % of margin — so if the extra rows bind, extending the canonical list
could be what closes 67.

**The design.** One module (`fplane_sdp_blocks`), one solve path (real blocks), one solver (SCS), one tolerance
(`eps_abs = eps_rel = 1e-8`), one backend (CPU, two threads). **The constraint list is the only thing that differs.**
Script: `/home/kooshi/.claude/jobs/b1507518/tmp/phaseB/relax_exp.py`; records `exp-q{11,23,27}.json`.

| q | pair orbits | `all` — le_diag at every diagonal class | `one` — one row per orbit (the certified shape) | difference | `none` — **the plant**: no le_diag at all | reachability control: the *killed-orbit equalities* dropped instead |
|---|---|---|---|---|---|---|
| 11 | 151 | 257 rows → **29.176799** | 105 rows → **29.176799** | −8.5 × 10⁻⁸ | 0 rows → **29.176799** — **did not fire** | 121.000000 = 11², **fired** (rose by 91.82) |
| 23 | 1,167 | 2,741 rows → **108.546073** | 1,001 rows → **108.546073** | −1.5 × 10⁻⁷ | 0 rows → **108.546073** — **did not fire** | 529.000000 = 23², **fired** (rose by 420.45) |
| 27 | 1,847 | 4,513 rows → **147.577433** | 1,625 rows → **147.577433** | +4.8 × 10⁻⁷ | 0 rows → **147.577433** — **did not fire** | 728.999996 = 27², **fired** (rose by 581.42) |

(Every number is the optimum of the block-diagonalised triple-level SDP over the **same** variable set, at the **same**
tolerance, on the **same** backend; the differences are at the solver's own tolerance, 10⁻⁷ against an optimum of order
10², not a gap.)

**The finding, and it is not the one the question expected.** The extra rows are inactive — but so is *every* `le_diag`
row: dropping the entire class leaves the optimum unchanged to six decimals at all three members. The class is
**redundant given the positive-semidefinite blocks and the killed-orbit equalities**. So:

* **The answer to "could extending the canonical list close 67?" is no, and for a stronger reason than "the extra rows
  happen not to bind here":** the rows the checker already verifies are themselves doing nothing, so no enlargement of
  that class can move any bound. The route is a measured dead end, and 67 must be closed by converging the solve.
* **The earlier readings at 11 and 23 — "the extra rows were measured inactive" — were true and empty.** They measured a
  constraint class that contributes nothing at all. Recorded here so the next reader does not take them as evidence that
  the *certified* relaxation is close to the tighter one for a reason to do with the extra rows.
* **This is exactly what standing rule 9 is for.** The plant (drop every `le_diag` row; the optimum must rise) **did not
  fire** at any member, which would have left the verdict empty. The reachability control — drop the killed-orbit
  equalities instead, which must and does collapse the bound to the trivial `q²` — fires at all three, so the instrument
  demonstrably detects a dropped constraint class. The null is therefore a fact about the relaxation, not about the
  instrument.
* **What it does not say.** It does not say the 83 comparison is explained: those two runs differed in formulation *and*
  in convergence, and the 40-point objective gap there is still unaccounted for by anything measured here. Nothing here
  was run at 83.

| `cert-q47-N402.json` (2.6 MB) | 𝔽₄₇ | graphics card A shared with its own producer; certificate from a **2,000**-iteration iterate resumed +500 in a fresh solver, 94 s | **CERTIFIED** (`--k 5`): `N = 100701620496835012188100202147162478941/2.5·10³⁵ = 402.806482`, so **α(UD(𝔽₄₇,2)) ≤ 402**, and `5 × 402 = 2010 < 2209`: **five is refused at 47**, `χ(UD(𝔽₄₇,2)) ≥ 6` | exact rational; 9,247 pair orbits and 18,494 canonical rows rebuilt from the number 47 alone. `--ldl` green (`ldl-q47-N402.log`). All 18 cuts give ⌊N⌋ = 402 (402.806482–402.810220). Six is **not** refused: `6 × 402 = 2412 ≥ 2209`, and six at 47 would need α ≤ 368 |
| `cert-q43-N365.json` (1.6 MB) | 𝔽₄₃ | the same card; certificate from a **500**-iteration iterate resumed +500 in a fresh solver, 50 s | **CERTIFIED** (`--k 5`): `N = 45739578027246880185150958981840496503/1.25·10³⁵ = 365.916624`, so **α(UD(𝔽₄₃,2)) ≤ 365**, and `5 × 365 = 1825 < 1849`: **five is refused at 43**, `χ(UD(𝔽₄₃,2)) ≥ 6` | exact rational, `--ldl` green (`ldl-q43-N365.log`). All 18 cuts give ⌊N⌋ = 365 (365.916624–365.919743). Six at 43 would need α ≤ 308 against a float optimum of 363.8 still falling at 8,500 iterations — 55 integers away, so six at 43 is **out of this instrument's reach**, not refused |

**What the three easy members cost, and what that says about 67.** 79, 47 and 43 were each certified from an iterate of
**500 to 2,000 iterations** whose primal residual was still of order 10⁻¹ — the bound had 17, 39 and 4 integers of margin
against its threshold. The instrument did not have to converge for any of them. 67 is the one that does: its threshold
(α ≤ 748) sits 0.9 % below the ratio bound, and its first polish, from iterate 8,500, gave ⌊N⌋ = 750 — **two integers
short**.

| `cert-q67-N745.json` (7.6 MB) | 𝔽₆₇ | graphics card B; the producer reached 38,000 iterations over 65 minutes, and the certificate is from its **37,000**-iteration iterate resumed **+2,000** in a fresh solver (404 s) | **CERTIFIED** (`--k 6`): `N = 181942132667989711844836116511294223/2.44140625·10³³ = 745.234975`, so **α(UD(𝔽₆₇,2)) ≤ 745**, and `6 × 745 = 4470 < 4489`: **six is refused at 67**, `χ(UD(𝔽₆₇,2)) ≥ 7` | exact rational; 26,225 pair orbits and 52,450 canonical rows rebuilt from the number 67 alone. `--ldl` green (`ldl-q67-N745.log`). All 17 cuts give ⌊N⌋ = 745 (745.234975–745.294498) |

**67 was the marginal member and it took the whole instrument.** Its threshold sits 0.9 % below the ratio bound — `α ≤
748` against 813.78 — where 79's sat 5.4 % below. The first polish, from iterate 8,500, gave 750 (two short); at 33,500
it gave 749 (one short); the certificate came only at 37,000, and then only because of the continuation length below.

### The continuation length is a lever, and +500 was leaving a whole integer on the table

FS-50's recipe says: resume the producer's checkpoint for **+500** iterations in a fresh solver and round *that* run's
own dual. At 67 that recipe lands exactly on the threshold and nearly missed it. Two arms were run from **one** parent
iterate (37,000), on the same card, same backend, same tolerance, same 18-candidate sweep — **the continuation length the
only thing differing**:

| arm | continuation | the continuation's own float bound | exact `N` | ⌊N⌋ | rounding loss (exact `N` minus that arm's own float bound) |
|---|---|---|---|---|---|
| a | **+500** (the FS-50 recipe) | 744.807736 | 748.829896 | **748** — clears `748` by nothing at all | **4.022** |
| b | **+2,000** | 743.602143 | **745.234975** | **745** | **1.633** |

The longer continuation wins twice over: its own float bound is 1.21 lower *and* its dual rounds 2.5× more tightly, so
the exact bound improves by 3.6 — **three integers**, where the member had one to give. The mechanism is unchanged (a
fresh short continuation's own dual, never a long-run iterate, never `--round-only`'s nudge); what changes is that
"short" should be read as a few thousand iterations and not as 500. The 47 and 59 polish loops were switched to +2,000
after this measurement.

*What this does not establish:* the comparison is one parent iterate at one member. It does not say +2,000 is optimal,
and it does not say anything about 83, where nothing here was re-run.

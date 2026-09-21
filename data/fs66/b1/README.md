# FS-66 phase 2 — the go/no-go reading for the all-levels certificate (planner, 2026-09-20)

**Verdict: GO.** The second-level moment (sum-of-squares) relaxation of the single-class fibre-density problem reads
**14.00–14.52 at `p = 7`** (needed: below `49/3 = 16.33`) and **28.2016 at `p = 11`** (needed: below `121/4 = 30.25`), in floating
point, on two solver code bases. Everything here is a **floating-point reading — never a certificate**; the certificate is the
subplan's job (`plans/FS66-phase2-certificate.md`).

Machine: the desktop, beside a running Lean build, so every run was held to 2–8 threads. Times are single runs —
prices, not benchmarks. Venv: `~/venvs/fs66` (outside `build/`; `pip install clarabel scs`, system numpy/scipy).

## The problem read

`B₁(p) = max Σφ` over `φ ∈ [0,1]^{p²}` with `q(φ) := c·Σ_x φ_x(1 − φ_x) − Σ_x Σ_{s ∈ S} φ_x φ_{x+s} ≥ 0`, **`c = 2` exactly** (the
hand-proved constant), optionally with the edge cuts `φ_x + φ_y ≤ 1` and triangle cuts. The relaxation (script:
`tools/fs66_b1_probe.py`): one moment variable per orbit of monomials of degree ≤ 4 under the group `G` of translations, rotations
and conjugation (order 784 at 7, 2,904 at 11); the moment matrix in the translation-Fourier basis, **one real block per norm class
of characters** (real because the monomial representatives are centred — `φ_0` and `φ_{−h}φ_h` — and moments are invariant under
negation); the localiser of `q` (a 2 × 2 block and one scalar per norm class); and the scalar "box" rows `y_α ≥ 0` and
`y_{α∖x} − y_α ≥ 0` for every monomial orbit `α` and point `x ∈ α`.

## Readings (`probe-records.jsonl`, one JSON record per run; logs `probe-*.log`)

| `p` | what is in the relaxation | value | solver, cost |
|---|---|---|---|
| 7 | everything: moment blocks + box localisers (50 × 50) + edge-cut localiser + `q` localiser + box rows | **14.0034** | Clarabel, 6.7 s |
| 7 | control — `q` dropped entirely | 24.5000 (= 49/2: nothing but the edge cuts binds) | Clarabel, 3.3 s |
| 7 | control — `φ² = φ` added (the 0/1 problem, i.e. the second Lasserre level for `α`) | 14.0000 (= `α(UD(𝔽₇,2))`) | Clarabel, 3.9 s |
| 7 | box rows dropped | 14.3451 | Clarabel |
| 7 | `q` kept only as the scalar `L(q) ≥ 0` | 14.0652 | Clarabel |
| 7 | edge-cut localiser dropped | 14.0039 | Clarabel |
| 7 | box rows, `q` localiser AND edge localiser dropped (moment blocks + box localisers + `L(q) ≥ 0`) | 14.5190 | Clarabel |
| 7 | **minimal: moment blocks + `q` localiser + box rows — no matrix localiser of any linear constraint, no cuts** | **14.0149** | Clarabel 2.9 s; SCS 14.0149, 2.0 s |
| 7 | minimal + every box product of degree ≤ 4 as a scalar row | 14.0126 | Clarabel |
| 7 | minimal + box products + the edge cut times every monomial of degree ≤ 3 as scalar rows | 14.0000 | Clarabel |
| 7 | control — minimal with the box rows dropped too (nothing encodes `φ ≤ 1`) | 1649.7 | Clarabel |
| **11** | **minimal** (11 blocks: 63, then ten of 62; a 2 × 2; 18,223 scalar rows; 3,759 moment variables) | **28.2016** (primal 28.20158, dual 28.20160) | Clarabel, 4 threads: 16 s build, 635 s solve, 7.3 GB |
| **11** | the same, second code base | **28.2015** (primal 28.201477, dual 28.201470) | SCS 3.3.1, 2 threads: 17 s build, **82 s** solve, 5,425 iterations |
| 11 | minimal + 122 × 122 localisers of `φ_0` and `1 − φ_0`, not symmetry-reduced | **killed by the planner at 6 min: 24 GB and no first iteration** — over the light-measurement budget; nothing forfeited but the reading itself, which the minimal form made unnecessary | Clarabel, 8 threads |

**What the table says.** (1) The route lives, with room: at 11 the margin is `30.25 − 28.20 = 2.05`, **6.8 % of the value** — the
rounding does not have to be delicate. (2) The reading is *below* the three-point bound for `α` (29.18): the second level is
stronger than the triple level, and the owner's floor "cannot read below about 29.18" was too pessimistic — the true floor is the
second Lasserre level for `α(UD(𝔽₁₁,2))`, which is at most this 28.20 and at least 28. (3) **The cuts are not needed** by the moment
relaxation (at 7 the edge localiser moves the fourth decimal), so the certificate can be built for the *bare* problem — a larger
feasible set — and still bounds the problem with cuts. (4) The matrix localisers of the box are not needed either; **the box lives
in the scalar rows**, which are also exactly the rows that let a rounded certificate absorb a residual of either sign. (5) Both
controls came out right: without `q` the relaxation reads 24.5, and with `φ² = φ` it reads `α`.

## Local search at `c = 2` exactly, with the cuts (`localsearch-c2.jsonl`; `tools/fs66_b1_localsearch.py`; SLSQP, three kinds of start)

| `p` | cuts | starts (feasible) | best `Σφ` | note |
|---|---|---|---|---|
| 7 | edges (no triangles exist) | 60 (47) | **14.0000** | the best point has 7 full and 14 half entries: at `c = 2` exactly a half-half edge ties a full vertex, so there are fractional ties AT 14, none above |
| 7 | none | 60 (59) | 14.0000 | local maxima at 13.333, 13.0 |
| 11 | 726 edges + 484 triangles | 200 (138) | **28.0000** | local maxima at 27.998, 27.986, 27.705, …; a 25-full + 6-fractional tie at 28.0 |
| 11 | none | 200 (200) | 28.0000 | local maxima at 27.0, 26.857, 26.667 |

So at the hand-proved constant `B₁` still reads `α(G₁)` numerically — nulls at a budget, never refusals.

## The exact-rounding PROTOTYPE (planner, same evening) — a measurement of the design, NOT a certificate

`tools/fs66_b1_probe.py … --round D --wdigits W --shift S --cert-out FILE` rounds the solver's dual to the certificate shape the
subplan specifies (format `fs66-b1-cert-v1`: rational cosine/sine weights, one positive-definite integer matrix per character
class, the `q` localiser, and the box rows, with the remainder of either sign absorbed by a cascade so that **the bound `U` is an
output and the rounding cannot fail to produce an identity**) and computes the bound in exact rational arithmetic; positive
definiteness is checked by fraction-free elimination (Sylvester). Records: `round-records.jsonl`; logs `round-*.log`.

| `p` | solver | digits `D` / weights `W` / shift | exact `U` | loss against the float value | all blocks positive definite? | exact arithmetic |
|---|---|---|---|---|---|---|
| 7 | SCS `1e-7` | 12 / 9 / `1e-6` | **14.01758** (need < 16.33) | 0.0027 | yes | 0.1 s |
| 7 | SCS `1e-7` | 12 / 9 / `1e-7` | 14.01520 | 0.0003 | yes | 0.1 s |
| 7 | SCS `1e-7` | 6 / 6 / `1e-6` | 14.16 | 0.15 | **no — six blocks fail** | — |
| 7 | SCS `1e-7` | 9 / 9 / `0` | 14.0150 | 0.0001 | **no — every block fails** (the solver's dual sits on the boundary) | — |
| **11** | SCS `1e-7`, 2 threads, 83 s | 12 / 9 / `1e-6` | **28.22513** (need < 30.25; `4U = 112.90 < 121`) | 0.0237 | yes, all 12 | 1.5 s |

`proto-cert-p7.json` (87 KB) and `proto-cert-p11.json` (775 KB) are the prototype's outputs, committed as **test inputs for the
independent checker** the subplan's first phase builds. **They are not certificates until that checker says so**: the prototype
checks its own work with its own bookkeeping, which is exactly what a certificate must not rest on. One independent control was
run on the bookkeeping (`round-p7-selfcheck.log`, an earlier revision of the prototype): at a pure independent set and at a random
fractional feasible point, a block's linear form evaluated on moments averaged over all 784 group elements equals the brute-force
quadratic form to nine digits (0.390881637 and 0.004280977, both ways).

## After the domain-modeling pass: format v2, and the specification run by a second program

The prototype files were re-emitted in the collapsed format `fs66-b1-cert-v2` (one block type, one row type, integers over one
scale; subplan §C), and `planner_spec_inhabitant.py` — the planner's scratch, standard library, written from §C's formulas alone,
**not the checker** — evaluated the identity on them: **7: 0 mismatches over 495 canonical monomials, 14 blocks positive definite,
1.6 s. 11: 0 mismatches over 3,760, 22 blocks positive definite, 36 s, `U = 28.225133`.** Lowering `U_num` by 1 (one part in 10³⁰)
is caught at the constant monomial. Log of the re-emission: `round-p11-scs-d12-v2.log`.

## After the obligation-modeling pass: the tightened reading, and a falsifier of the hand links

* **The tightened relaxation at 11** (every box product of degree ≤ 4, and the edge and triangle cuts times every monomial of
  degree ≤ 3, as 198,501 scalar rows; `probe-p11-scs-tight.log`): **28.0427** (SCS `1e-6`, 2 threads, 59 s build, 204 s solve) —
  tighter than the minimal 28.2015 and **not exact** (at 7 the same tightening reads 14.0000). The planner's prediction "28.00 ±
  0.02" was NOT met.
* **`tools/fs66_b1_links_test.py`** (`links-test.out`): the fibre-density inequality checked in exact integers on 803 explicit
  independent sets of `UD(ℤ/9,2)`, `UD(ℤ/27,2)` and `UD(ℤ/49,2)` — greedy sets, the pull-back of a level-one set, and random
  independence-preserving perturbations of it. **No violation; the pull-back is tight (`q = 0` exactly).** A falsifier, never a
  proof. Consequence recorded in the subplan §S.7: the bound at 7 gives `α(UD(ℤ/49,2)) = 686` exactly.

## After the experience-modeling pass: the instance a person can read whole

`proto-cert-p3.json` — the same prototype at `p = 3` (9 points, 28 canonical monomials, six blocks of size ≤ 7, 27 rows, 4 KB):
`U = 3.00011` against `α(UD(𝔽₃,2)) = 3`, so two colours are refused at every level of the 3-adic tower (true and trivial — which
is what a worked example should be). The from-the-spec evaluator agrees (0 mismatches). It is the soundness page's worked
example and the input of the checker's assembled twin.

## Files

| file | what it is | trust word |
|---|---|---|
| `probe-records.jsonl`, `probe-*.log` | floating-point readings of the relaxation | float reading (untrusted) |
| `round-records.jsonl`, `round-*.log` | the rounding prototype's runs | prototype bound (producer's own arithmetic, untrusted) |
| `proto-cert-p3.json`, `proto-cert-p7.json`, `proto-cert-p11.json` | prototype outputs in format `fs66-b1-cert-v2` — **test inputs for the checker, not certificates** | prototype bound (untrusted) |
| `planner_spec_inhabitant.py` | the planner's scratch evaluator of the specification — not the checker; do not port it | — |
| `localsearch-c2.jsonl` | local maxima at `c = 2` with the cuts | nulls at a budget |
| `links-test.out` | the falsifier of the hand links, run | tested (falsifier): no violation |

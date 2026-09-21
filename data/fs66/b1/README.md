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

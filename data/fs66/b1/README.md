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

---

# Phase 2B — the production certificates (implementer, 2026-09-21)

**The prototype above is superseded as an artifact.** `tools/fs66_b1_cert_make.py` — the production
producer, written from the subplan's §R′ — made the two certificates this milestone ships, and
`tools/fs66_b1_cert_check.py` (Phase 2A's, frozen, standard library only, sharing no code with the
producer) says **`CERTIFIED`** on both. Everything the prototype files were for — being the checker's first
test inputs — they have now done; they stay as test inputs and are not the milestone's statement.

| | `cert-p7.json` | `cert-p11.json` |
|---|---|---|
| exact bound `U = U_num / scale` | **14.015224…** | **28.204320…** |
| `U_num` | `14015224526962403621588626098460` | `28204320001863099628721379861820` |
| `scale` | `10^30` | `10^30` |
| refuses | `3·U = 42.045673… < 49` | **`4·U = 112.817280… < 121`** |
| does not refuse | `4·U = 56.060898… ≥ 49` | `5·U = 141.021600… ≥ 121` |
| blocks / rows / weight vectors | 14 / 524 / 13 | 22 / 3,821 / 21 |
| size | 97 KB | 707 KB |
| sha256 | `f4b2ffa7c42727f3…` | `683236677e0d55a4…` |
| checker's wall time | 0.6 s | 6.6 s |
| what the prototype had | 14.017576… | 28.225133… |

The gain came from the **rounding scan**, not from a better solve: the prototype rounded at one diagonal
shift (`1e-6`); the scan rounds at six (shift × digits) in parallel and keeps the smallest `U` whose blocks
are all positive definite, and `1e-7` wins. At 11 the rounding loss against the float reading falls from
0.024 to **0.0028**.

## The statement these license — §ST of `plans/FS66-phase2-certificate.md`, with these files' numbers

> **At `p = 11`: for every `k ≥ 1`, every independent set of `UD(ℤ/11^k, 2)` has at most `U·121^{k−1}`
> points with `U = 28.204320…` (the exact rational in the file); hence no level of the tower is
> four-colourable, the chromatic number of every level is exactly 5, the clopen chromatic number of `ℤ₁₁²`
> is 5 (main plan §S2), the fractional chromatic number of every level lies in
> `[121/U, 121/28] = [4.2901, 4.3215]`, and the supremum of the Haar measure of a measurable independent
> set of `ℤ₁₁²` lies in `[28/121, U/121] = [0.231404, 0.233093]`.** At `p = 7` the same with
> `U = 14.015224…`, three colours, `χ = 4`, `χ_f ∈ [3.4961, 3.5]`.

**The Borel clause** (§ST's owner addendum, unchanged in substance): a Borel colour class of `ℚ_p²` meets
`ℤ_p²` in a measurable independent set, of Haar measure at most `U/p²`, so `χ_Bor ≥ ⌈p²/U⌉`; a level-one
colouring pulled back is clopen, hence Borel, and extends over the countably many cosets of `ℤ_p²` in
`ℚ_p²`. Hence **`χ_Bor(ℚ₇²) = 4` and `χ_Bor(ℚ₁₁²) = 5`** — exact values for the problem
`[BardestaniMallahiKarai2017]` pose and bound only by `O(p²)`.

**And the level-two independence numbers**, with the explicit sets below: `α(UD(ℤ/49, 2)) = **686** exactly`
(`14·49 = 686 = ⌊14.015224·49⌋`), and **`3,388 ≤ α(UD(ℤ/121, 2)) ≤ 3,412`** — the upper end three below the
`3,415` the subplan records, which was computed from the prototype's weaker `U`.

**Trust word for every sentence above: `CERTIFIED (fs66_b1_cert_check)` + the hand-proved links L1, L2, L6
of `SOUNDNESS.md`. Never the Lean kernel.** The checker establishes only the polynomial bound `Σφ ≤ U`; the
whole tower is carried by the hand links, which is why its own last line names them in capitals.
`SOUNDNESS.md` §8 states the same clauses with the prototype's `U = 28.225133…` and `14.017576…`; every one
of them is implied by the tighter values here, and only the `≤ 3,415` changes.

## The rounding scan, and the law it gives the next prime (`scan.out`)

One solve per prime; then independent exact rounding attempts, one per (shift, digits `D`), across the
cores. **Positive definiteness survives exactly when `shift ≥ 10^(3−D)`** — the same threshold at 7 and at
11, in every one of the 42 attempts — and above that threshold `U` is linear in the shift down to a floor
set by the rounding itself:

| shift | `U` at 7 (`D = 12`) | `U` at 11 (`D = 12`) |
|---|---|---|
| `1e-10` | not positive definite | not positive definite |
| `1e-9` | 14.014996… | 28.202108… |
| `1e-8` | 14.015011… | 28.202299… |
| **`1e-7`** | **14.015224…** (shipped) | **28.204320…** (shipped) |
| `1e-6` | 14.017579… | 28.225276… (the prototype's) |
| `1e-5` | 14.041342… | 28.436113… |
| `1e-4` | 14.278973… | 30.544473… — **no longer refuses four colours at 11** |

So the recipe for `p = 19`: solve, then round at `shift = 10^(3−D)` for the largest `D` affordable, and
expect `U` to land within about `10⁻⁴` of the float reading. Rounding is scored by the bound it proves,
never by a residual (`plans/FS50-certificate-soundness.md` §5): the six shipped attempts differ by 0.23 in
`U` and not one of them is "more nearly correct" than another.

## Files added by Phase 2B

| file | what it is | trust word |
|---|---|---|
| `cert-p7.json`, `cert-p11.json` | **the milestone's certificates**, format `fs66-b1-cert-v2`, integers only | **`CERTIFIED (fs66_b1_cert_check)`** + the hand links L1, L2, L6 |
| `records.jsonl` | one flat record per producer attempt and per checker run: solver, tolerance, digits, shift, `U`, digests | provenance; the `trust` field of each row says which |
| `scan.out` | the widened rounding scan at 7 and 11, 42 attempts | float reading / producer bound (untrusted) |
| `controls.out` | plants 9 (`c = 1`) and 12 (arbitrary weights) with their faithful twins and digests; the colour-count controls; the three float controls at 7 | controls, each red or green for a named reason |
| `level-one-sets.json` | an explicit 14-set of `UD(𝔽₇,2)` and 28-set of `UD(𝔽₁₁,2)`, each point written as a pair and as an index | **`VERIFIED (fs66_b1_sets_check)`** — independent, from the definition |
| `tools/fs66_b1_cert_make.py` | the production producer | **untrusted by design**; a wrong weight or table in it can only weaken `U` |
| `tools/fs66_b1_sets_check.py` | the sets' verifier, standard library only, `--self-test` with 18 controls | the verifier of the row above |

## The controls, and the one that fired (`controls.out`)

* **Float controls at 7, all three exact.** `q` dropped with the edge cut kept → **24.5** = `n/2` (the
  planner's B2); `q` dropped with nothing kept → **49** = `n`, so in the *minimal* relaxation `q` is the only
  thing that binds; `φ² = φ` added → **14.0** = `α(UD(𝔽₇,2))`.
* **Plant 9** — a certificate produced for the wrong problem (`c = 1`, a stronger and false constraint, whose
  bound 14.002121… *looks better*) → **`REFUSED IDENTITY_MISMATCH`** at 156 of 495 canonical monomials. The
  checker has no `c` to read; it rebuilds `q` with 2.
* **Plant 12** — every entry of every weight vector replaced by arbitrary integers, the constant entry `c`
  included → **`BOUND ONLY`** with `U = 7.16 × 10¹⁹`: sound and useless, which is the point. Registered
  prediction **P-B4 (`U > 40` at 11) MET.**
* **Plant 12 went red the first time, and the fault was the producer's.** The linear form of a block was
  written three ways — the all-ones block, a character block, a `q` block — instead of once, and the padded
  constant row's term `R[0][0]·c²` was omitted from the character and `q` blocks. With the real cosine and
  sine weights `c = 0`, so the omitted term is zero and the production certificates were never affected;
  only a control that makes `c` nonzero could see it. The accumulation is now **one** loop over
  (block × weight vector) applying the three terms of (★) as §C.2 states them.
* **`--self-test` of the frozen checker, run against `cert-p7.json` rather than the prototype: 25 of 25**,
  97 s, `git status` clean afterwards.

---

# Phase 2C — `p = 19` at four colours (implementer, 2026-09-21)

**The reading: the minimal second-level relaxation at `p = 19` reads about `77.4`, against the
`361/4 = 90.25` a four-colour certificate needs** — a margin of about 14 %, wider than 11's 6.8 %. Floating
point, untrusted, recorded before any rounding. The best explicit independent set of level one is 76, so the
relaxation's own optimum is pinned in roughly `[76, 78]`.

**The certificate: PENDING** — filled in when the frozen checker has spoken.

## What is new at 19, and what it cost

Two symmetries of the product table, verified on 300 random `(ia, ib, t)` before being used:
`a' · τ_{−t}(a)` is a translate of `a · τ_t(a')`, and `z ↦ −z` is a symmetry under which every
representative is stable. Together they make the table a **quarter** of its naive size.

| | |
|---|---|
| whole build | **26 s** (the subplan's §19 priced 30–60 min) |
| product table | 3,014,193 canonical forms on 16 forked workers, against 11,957,764 naively |
| orbits / blocks / scalar rows | 52,370 / 183 + 18 × 182 + 2 × 2 / 259,271 |
| constraint matrix | 575,864 × 52,369, **53.7 M nonzeros** (§19 priced "near 10⁸") |
| build cache | `../ckpt/b1-p19/build-p19-c2.npz`, 12 MB, reload 0.4 s |
| one exact rounding attempt | **243 s** (§R′.3 predicted ≈ 50 s) |
| the frozen checker on a 19-sized certificate | **8 min 21 s, 3.17 GB**, all seven steps, 52,370 monomials |

**GPU against CPU, 50 iterations at the real size on a quiet machine:** `gpu_indirect` on graphics card A
**0.675 s/iteration**, `cpu_indirect` on 16 threads **2.037 s/iteration** — 3.0×, agreeing on the objective to
five digits. 2.4 GB of GPU memory. This is the one place in the milestone a GPU earns its keep, and it does.

## The finding that decides how this method is used: `U` tracks the DUAL residual

From three duals of one solve at 19:

| dual | `res_pri` | `res_dual` | rounded `U` |
|---|---|---|---|
| 605 iterations (after a 5-iteration warm-started continuation) | 1.95 | 4.7e−01 | 192.574282 |
| 1,200 iterations | 1.75e−04 | 6.0e−01 | **213.926704** — worse, on a far better primal |
| `p = 11`, converged | < 1e−07 | < 1e−07 | loss over the reading 0.0028 |

The cascade pays for the dual's infeasibility in box rows, so at `res_dual ≈ 0.6` that costs more than 100 in
`U`. **A bound from this method travels with its dual residual as well as its shift.**

Two mechanical consequences, both measured:

1. **Re-entering SCS to reach a checkpoint destroys the dual you came for** — five warm-started iterations
   took `res_pri` from 1.33e−03 to 1.95. `tools/fs66_b1_cert_make.py --round-only` loads the dual out of the
   checkpoint and calls no solver; at `p = 11` it reproduces the normal path's certificate byte for byte.
2. **Chunk size is not free.** At 11, 4,000-iteration chunks give `U = 28.204515…` against the committed
   `28.204320…` from one uninterrupted call. At 19, 300-iteration chunks left `res_dual` flat at ~0.6 over
   five chunks while `res_pri` fell two orders of magnitude; that run was killed (checkpoint and log kept) and
   relaunched with 3,000-iteration chunks. The solver class is not at fault: at 11 the **indirect** solver
   converges cleanly in 6,125 iterations (`status solved`, `res_dual` 5.4e−06).

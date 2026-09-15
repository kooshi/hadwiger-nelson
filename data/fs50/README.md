# data/fs50 — records of FS-50, the independence number at the threshold

*Every file is a measurement or a relaxation on the solver's/LP's word; the certificate, if one lands, is the Lean module
(`Instances/…`) and not anything here. `plans/FS50-prior-art.md` §3 is the reading of the `lp-*` files.*

| file | what | claim scope |
|---|---|---|
| `lp-p83-k6.json` | `tools/fplane_lp.py --p 83 --k 6` with the full graph library: Delsarte's LP (`ϑ′` = 1,199.459) strengthened by [KMOR2016] Lemma 3.2 (2) rows over every translate of nine small unit-distance graphs (each `α_V` exact), Székely's rows and the atom LP of [AmbrusEtAl2023] on the wheel and the spindle, at the six-colour threshold 1,149 | max `|S|` with subgraph rows **1,197.064**; size 1,149 **feasible** under every family — the relaxation certifies nothing at 83; a float LP (HiGHS) |
| `lp-p11-k5.json`, `lp-p23-k5.json` | the same at 11 (threshold 25) and 23 (threshold 106) | 30.392 at 11 against the verified `α = 28`; 126.755 at 23; both feasible at their thresholds |
| `alpha-p23-ge87.json` | a verified 87-point independent set of UD(𝔽₂₃, 2) — the Rust engineer's WO-18 planning prototype found it in 0.03 s on one core (2026-09-14); re-verified here from the definition and through `fplane.ud_edges` | `α(23) ≥ 87` (was ≥ 69 in `data/fplane/alpha-p23.json`); the five-colour threshold 106 is still not met, nothing decided |
| `race23/` | `tools/fs50_race.py` pricing runs at 23, size 106 (FS-50 stub D2/D3): six cardinality encodings on the monolith, the class-cube profile, the controls; `SUMMARY.json` has the reading | every encoding undecided at 900 s; cubes 0–10 undecided at 840 s, cube 11 refuted in 132 s, cube 12 in 12 s, cube 20 in 0.1 s — the orbit split alone does not tame the low classes; **and `nscale/`: the monolith at N = 140, 130, 125, 120, 115, 110 is undecided at 840 s at every size, including sizes above the ratio bound 131.76 that the spectral argument refutes on paper — resolution does not find the spectral bound at any size**; the solver's word, floats nowhere |
| `race19/` | the same class-cube profile at 19 for size 77 (α(19) ≥ 76 verified; 77 undecided since M61): cubes 0, 2–6 undecided at 840 s, cube 8 refuted in 28 s, 10–18 instantly; cube 7 not run | α(19) = 76 exactly would follow from every cube refuting; the low classes stay open — the solver's word |
| `maxsat/` | `tools/fs50_maxsat.py`: α as a MaxSAT optimum (RC2, core-guided) — 28 at 11 in 0.44 s; at 19 and 23 interrupted after ~20 min with upper bounds 110 and 151, above the ratio bound | not the lever; the solver's word, no proof |
| `wo18/` | the Rust `plane-independent` finder's records (WO-18, `~/source/descent-engine/crates/plane-independent/`, outcome `plans/WO-18-outcome.md`; each record carries `vertex_index`, `edge_rule`, `edges_sha256`, `rerun`, the trace and the verified set; **every set re-verified here from the definition**): the ladder at 83 (16 threads, 120 s per rung) — rotation orders 2/3/4/6/7/12/14/21/28/42/84 → 566/543/541/**595**/589/541/589/589/533/589/505, the line quotient 581, the plane 574 in 600 s (`p83-plane-600s.json`, the plateau curve in its `trace`); the chain `p83-chain.json` (the order-6 set through `--start` to the plane): **597**; `p83-k6.json` (target 1,149) `not_found`; `p23-k5.json` (target 106) `not_found` at 87; the controls at 11 (28 found, 29 not found), 19 (76), 23 (87) | **α(UD(𝔽₈₃,2)) ≥ 597** — 49.8% of the ratio bound, 52% of the 1,149 a six-colouring needs; the orders 84/42/28 and the line quotient are the engineer's exact class optima (branch and bound, planning session) hit and never exceeded; a plateau is a statement about the search, never about α |
| `nscale/` | the refutation time against the target size N at 11 (N = 29–36) and 19 (N = 77–110), one core, 840 s walls | at 11 smooth (0.3 s → 32 s); at 19 undecided at every N, including sizes above the ratio bound 99.5 — the spectral argument is beyond resolution's reach from 361 vertices on; the solver's word |
| `sdp-p11-linear.json`, `sdp-p19-linear.json`, `sdp-p23-linear.json` | `tools/fplane_sdp.py` (venv `build/venv-sdp`, SCS): the triple-level semidefinite bound — Schrijver 2005's shape on the orbit algebra of `O(2,p)` × swap × S₃ (151 / 673 / 1,167 orbits), one solve each; controls in every record: the verified set's raw triple matrix satisfies the swap and S₃ identities exactly and, averaged, every constraint; the bisection form feasible at the true size and infeasible with the second matrix mis-signed | **29.18 / 85.67 / 108.55** against Hoffman 34.55 / 99.50 / 131.76 and the truth 28 / ≥ 76 / ≥ 87 — 82% / 59% / 52% of the Hoffman-to-best-set gap closed; the subgraph rows add nothing on top; at 23 the five-colour threshold 106 is missed by 2.5 (FS-17's digit stays open); **float readings, not bounds** — a bound is a certificate file checked by `fplane_cert_check.py` |
| `sdp-p23-blocks.json` | `tools/fplane_sdp_blocks.py`: the block-diagonalised form (DFT blocks of the angular profiles; 1,167 classes at 23, the same count as the direct orbit tool) — the control that the reduction is right before it runs at 83 | 108.5464 against the direct 108.5461 — agreement at the solver's tolerance; at 11 the block form gives 29.1768 exactly |
| `cert-p11-N29.json` | **the first exact bound below the eigenvalue bound for any finite Euclidean plane**: a rational dual of the triple-level relaxation at 11, produced by `tools/fplane_cert_round.py` (untrusted: Clarabel proposes, exact arithmetic disposes) and accepted by `tools/fplane_cert_check.py` — a standard-library, float-free program that rebuilds the group, its 151 pair orbits and all 302 constraint rows from the number 11 alone and refuses any disagreement. 152 KB: the multipliers, two rational Gram factors (66×121 and 83×121, so `Z = BᵀB` is positive semidefinite by construction), and `N`. The one-page derivation it points at is `plans/FS50-certificate-soundness.md`; the transcript is below | **α(UD(𝔽₁₁, 2)) ≤ 291768068882684687/10000000000000000 = 29.176807, hence ≤ 29** — exact rational arithmetic, no solver trusted, against Hoffman 34.55 and the truth 28. `N` cannot be the integer 29: 29.1768 is the relaxation's own optimum, so 29 is reached only through ⌊N⌋. Also re-proves `χ(UD(𝔽₁₁, 2)) ≥ 5` (4·29 = 116 < 121), which the kernel already holds by another route (`chromaticNumber_finitePlane11`) — a check on the pipeline, not a new result. Kernel consumer: `add_one_le_chromaticNumber_of_indepNum_le` (`LocalGlobal.lean`), instances in `Instances/IndependenceThreshold.lean` |
| `cert-p23-N108.json` | **the second row of that table, and the first at a prime where the true value is unknown**: the same rounding at 23 — 529 points, 1,167 pair orbits, 2,334 constraint rows, two rational Gram factors (220×529 and 250×529), 1.67 MB. Produced from a cached SCS dual (`ckpt/dual-p23.npz`) by `tools/fplane_cert_round.py`; accepted by `tools/fplane_cert_check.py`, and **also by the checker as it stood before this milestone extended it** (`git show 95ff153:tools/fplane_cert_check.py`, the last commit before this milestone touched it, 5.2 s) — the extension for the block form did not move the dense path's verdict | **α(UD(𝔽₂₃, 2)) ≤ 1085461828989727987/10000000000000000 = 108.546183, hence ≤ 108** — against Hoffman 131.76 and the best verified set 87, so the bracket is **[87, 108]**. The rounding costs 1.1·10⁻⁴ against the float optimum 108.546073, and ⌊N⌋ = 108 is the best any dual of this relaxation can give (its own optimum is 108.5461 > 108). **The five-colour threshold 106 is NOT reached** (5 × 108 = 540 ≥ 529), so FS-17's first digit at 23 stays open exactly where M61 left it; the certificate refutes four colours, which was already known. Kernel consumer: `add_one_le_chromaticNumber_of_indepNum_le` |
| `cert-p23-blocks-N108.json` | **the control that phase E's pipeline is right, at the largest prime where the answer is independently known**: the same bound at 23 produced through the CIRCULANT BLOCK form — 13 blocks over 45 slots (22 cosine, 22 sine, 1 origin), weights over 10⁸, the matrix never assembled — by `tools/fplane_cert_round.py --p 23 --blocks` and accepted by the checker's circulant path | `N = 108.546198` against the dense certificate's `108.546183` and the solver's own `108.546073` — **the same ⌊N⌋ = 108**, in **0.40 MB against 1.67 MB**. That ratio is what makes 83 possible at all: there the dense form would need a 6,889 × 6,889 matrix and the block form needs 43 blocks over 165 slots. The block solve took 882.9 s against the direct form's 447.7 s — slower at 23, and the only one that exists at 83 |
| `sdp-p23-blocks-real.json` | `tools/fplane_sdp_blocks.py --real`: base points on the two reflection axes make every DFT block real (the Hermitian block is a diagonal unitary conjugate of a real one, so PSD-ness is preserved) — half the embedded block size | 108.5467 at 23 in **5.4 s** against 208 s for the Hermitian embedding (29.1769 at 11 in 0.6 s against 5.5 s): the lever that makes 83 minutes rather than hours |
| `cert-p11-real-N29.json` | the same certificate at 11 through the **REAL** block form (the per-circle Fourier phase; the solve's blocks are 7 of size 10–11 against the 42-row embedding the Hermitian form uses, 9,142 map entries), the reduced dual pushed back onto the identical wire form by the congruence `T` — `tools/fplane_cert_round.py --p 11 --blocks --real`, accepted by the **unmodified** checker | `N = 911775245913368821483035055323/31250000000000000000000000000 = 29.176808`, hence `α ≤ 29` — **better than the Hermitian block form's 29.176927** and equal to the dense certificate's 29.176807 to 10⁻⁶; float bound 29.176798848 in 6.4 s; 0.05 MB. At the verified 28-point maximum set: `⟨Z1,Y⟩ = 1.145807`, `⟨Z2,M−Y⟩ = 0`, `Σλ·c = 0.031001`, `N − |S| = 1.176808` |
| `cert-p23-real-N108.json` | the same at 23 — 13 blocks of size 22–23 against 90 embedded, 157,390 map entries; the control that the real form's dual rounds to the same bound at the largest prime where an independent answer exists | `N = 5427303765430670819917620005903959012847/50000000000000000000000000000000000000 = 108.546075`, hence `α ≤ 108` — the same `⌊N⌋` as the dense (108.546183) and the Hermitian block (108.546198) certificates and **the tightest of the three**, 2·10⁻⁶ above the relaxation's own float optimum 108.546073; 0.37 MB; **the solve fell from 882.9 s to 146.9 s at the same tolerance**. At the verified 87-point set: `⟨Z1,Y⟩ = 21.421644`, `Σλ·c = 0.124431`, `N − |S| = 21.546075`. `--ldl` — the redundant exact `LDLᵀ` the dense path could not afford at 23 (36 min, killed) — costs **0.5 s** here, because the circulant path factors the 45 × 45 blocks and never the 529 × 529 matrix |
| `sdp-p83-scs-real.json` (when it lands), `ckpt/scs-p83-real.npz` | `tools/fplane_sdp_scs.py`: the real-block SDP through SCS's own API in warm-started chunks of 2,000 iterations, the iterate checkpointed after every chunk and one residual line per chunk — written after two eight-hour Hermitian-form solves at 83 were lost on 2026-09-15 (their `timeout` walls; **and killing a `timeout` wrapper to lift its wall kills the child too** — do not); control at 23: solved in 2,050 iterations / 3 s, and a relaunch resumes from the checkpoint | the value at 83 as a reading, resumable: the resume command is the launch command (the checkpoint path is the state) |
| `lp-attribution.json` | the single-graph maxima at 11, 23, 83 — which graph's rows carry the drop | at 83 only the triangle bites (1,197.064); the spindle bites at 11 (30.392) and not at 83 |

## The certificate at 11, checked

Produced (about four minutes, of which 134 s is the floating-point solve):

```
build/venv-sdp/bin/python tools/fplane_cert_round.py --p 11 --out data/fs50/cert-p11-N29.json \
    --thresholds 1e-8,1e-6,1e-5,1e-4,1e-3 --denominators 10000,1000000,100000000
```

Checked — 0.18 s, plain `python3`, nothing outside the standard library, no floating-point number read:

```
$ python3 tools/fplane_cert_check.py data/fs50/cert-p11-N29.json --k 4
[cert] file: data/fs50/cert-p11-N29.json
[cert] kind 'fplane-alpha-certificate', p = 11, N = '291768068882684687/10000000000000000', alpha_bound = 29
[cert] the derivation it points at: plans/FS50-certificate-soundness.md
check 1/4  group and orbits rebuilt from p = 11 alone: 121 points, 151 orbits of ordered pairs under
           O(2,11) x swap x S3, 36 killed by a unit vector; the file's 151 representatives agree, and the
           canonical constraint list (302 rows: 1 g0, 36 killed, 151 nonneg, 114 le_diag) agrees row for row
check 2/4  multipliers: 302 rationals, the 265 attached to inequalities are all >= 0, the 37 attached to
           equalities are free
check 3/4  positive semidefiniteness:
           Z1: 1 block(s) -- a rational Gram factor B of shape 66x121 (Z = B^T B, positive semidefinite by construction)
           Z2: 1 block(s) -- a rational Gram factor B of shape 83x121 (Z = B^T B, positive semidefinite by construction)
check 4/4  the affine identity N - tr Y(y) = <Z1,Y(y)> + <Z2,M(y)-Y(y)> + sum lambda_i c_i(y) + sum nu_j e_j(y):
           all 151 orbit coefficients and the constant term agree exactly
CERTIFIED: every independent set of UD(F_11, 2) has at most 291768068882684687/10000000000000000 points,
           hence at most 29 (a cardinality is an integer) -- exact arithmetic, no solver trusted
hence UD(F_11, 2) is not 4-colourable (4 * 29 = 116 < 121); kernel consumer: add_one_le_chromaticNumber_of_indepNum_le
```

`--ldl` re-runs the redundant exact `LDLᵀ` on the two assembled 121 × 121 matrices instead of accepting the
Gram factors on sight: 13.2 s, both clean. So the dense path is affordable here, and the Gram form is the
faster of two checks that both pass.

And `--against data/fplane/alpha-p11.json` evaluates the identity at the verified **28-point maximum
independent set**, term by term, after re-verifying it independent from the definition:

```
the set: 28 points, re-verified independent from the definition (no two differ by a vector of quadrance 1)
trace Y(y) = 28 = the number of points, as the derivation's P7 says
<Z1, Y>          =  1.145813467   (nonnegative: two positive semidefinite matrices)
<Z2, M - Y>      =  0.000000629   (nonnegative: likewise)
sum lambda * c   =  0.030992792   (nonnegative: lambda >= 0 and c >= 0 here)
sum nu * e       =  0.000000000   (exactly zero: the equations hold here)
N - |S|          =  1.176806888   = the four terms summed
```

— the argument working on a real object, with the slack `N − 28 = 1.1768` showing exactly how far the
relaxation sits above the truth.

The controls — `python3 tools/fplane_cert_check.py data/fs50/cert-p11-N29.json --self-test`, 19 s — are (i) the
derivation's constraint system verified against **genuine** independent sets: all 33 of `UD(𝔽₃, 2)` and an even
sample of the 6,027,056 of `UD(𝔽₇, 2)`, each one checked to satisfy every canonical row, to have `tr Y = |S|`,
and to give two positive semidefinite matrices; (ii) that same control under a planted map that is *not* a
symmetry (the translation `(u,v) ↦ (u+1,v+1)`), which must and does go red; and (iii) thirteen planted faults, four of
them in the shipped certificate itself — an altered matrix coefficient, a claim strengthened by one with the
proof left alone, a rewritten constraint row, a rewritten orbit representative, a flipped semidefinite pivot in each of the two matrix forms, a dense
matrix made asymmetric on one side only, a negated multiplier, a foreign `p`, a float where a rational belongs, and the semidefinite solver's own record
handed to the checker by mistake, and a set with an adjacent pair handed to `--against` — each refused naming the site, beside the faithful certificates that must pass
and are re-run afterwards to verify the restore.

## The certificate at 23, checked

Produced in two steps, because the rounding sweep is worth checkpointing at this size. The semidefinite
solve (SCS at tolerance 10⁻⁹, `optimal`, 108.546073) took **447.7 s** and the sweep 4.5 min, **while the
block-form solve at 83 held one core and 25.9 GB of the desktop** — so both figures are contended:

```
build/venv-sdp/bin/python tools/fplane_cert_round.py --p 23 --solver SCS --eps 1e-9 --max-iters 300000 \
    --dual-cache data/fs50/ckpt/dual-p23.npz --ckpt data/fs50/ckpt/round-p23.jsonl \
    --thresholds 1e-8,1e-6,1e-5,1e-4,1e-3 --denominators 10000,1000000,100000000 \
    --out data/fs50/cert-p23-N108.json
```

**Resume.** Re-run that exact command. The float duals are read back from `data/fs50/ckpt/dual-p23.npz`
(1.9 MB) instead of being re-solved, and every candidate already in `data/fs50/ckpt/round-p23.jsonl`
(one JSON line each: signs, eigenvalue cut, denominator, the exact `N` it proves) is skipped. A kill
therefore costs only the candidates in flight — at most one — and never the 448-second solve.

The sweep, scored by the exact bound each candidate proves rather than by any residual:

| eigenvalue cut | denominator 10⁴ | 10⁶ | 10⁸ |
|---|---|---|---|
| 10⁻⁸, 10⁻⁶, 10⁻⁵ | 109.5438 | 108.5560 | **108.546183** |
| 10⁻⁴ | 109.5440 | 108.5679 | 108.5656 |
| 10⁻³ | 121.2150 | 121.2340 | 121.2352 |

Checked — 11.2 s, plain `python3`, standard library only, no floating-point number read:

```
$ python3 tools/fplane_cert_check.py data/fs50/cert-p23-N108.json --k 5
check 1/4  group and orbits rebuilt from p = 23 alone: 529 points, 1167 orbits of ordered pairs under
           O(2,23) x swap x S3, 144 killed by a unit vector; the file's 1167 representatives agree, and
           the canonical constraint list (2334 rows: 1 g0, 144 killed, 1167 nonneg, 1022 le_diag) agrees
           row for row
check 2/4  multipliers: 2334 rationals, the 2189 attached to inequalities are all >= 0, the 145 attached
           to equalities are free
check 3/4  positive semidefiniteness:
           Z1: 1 block(s) -- a rational Gram factor B of shape 220x529 (Z = B^T B, positive semidefinite by construction)
           Z2: 1 block(s) -- a rational Gram factor B of shape 250x529 (Z = B^T B, positive semidefinite by construction)
check 4/4  the affine identity N - tr Y(y) = <Z1,Y(y)> + <Z2,M(y)-Y(y)> + sum lambda_i c_i(y) + sum nu_j e_j(y):
           all 1167 orbit coefficients and the constant term agree exactly
CERTIFIED: every independent set of UD(F_23, 2) has at most 1085461828989727987/10000000000000000 points,
           hence at most 108 (a cardinality is an integer) -- exact arithmetic, no solver trusted
this says nothing about 5-colourability: 5 * 108 = 540 >= 529
```

That last line is the honest negative and the reason FS-17 stays open: five colours at 23 would need
`α ≤ 105`, and the relaxation's own optimum is 108.55, so **no dual of the triple level can reach it**.
What the certificate settles is the upper end of the bracket, from 131 (Hoffman) to 108.

`--ldl` — the redundant exact `LDLᵀ` on the assembled 529 × 529 matrices, instead of accepting the Gram
factors on sight — is **not affordable at 23**: it was still inside the first of the two matrices after
36 minutes and was killed there (it costs 13.2 s at 11). It proves nothing the Gram form does not, since
`BᵀB` is positive semidefinite for any rational `B` whatever; what it guards against is a bug in the
assembly, and that guard runs at `p = 3, 7, 11` and in the planted faults. Take the absence of an `--ldl`
run at 23 as a statement about the cost of that redundancy, not about the certificate.

`--against data/fs50/alpha-p23-ge87.json` evaluates the identity at the verified 87-point set, term by
term, after re-verifying it independent from the definition: `trace Y = 87`, `⟨Z1, Y⟩ = 21.4216`,
`⟨Z2, M − Y⟩ = 0.0000`, `Σ λ·c = 0.1245`, `Σ ν·e = 0` and `N − |S| = 21.5462` — the slack showing how far
the relaxation sits above the best set anyone has found.

The controls — `python3 tools/fplane_cert_check.py data/fs50/cert-p23-N108.json --self-test`, 39.9 s —
are the eleven of the 11 row plus four planted in **this** file: one matrix coefficient altered (refused
naming orbit 0 and the difference 10⁻¹⁶), the claim strengthened by one with the proof left alone
(refused at the constant term), a constraint row rewritten, and an orbit representative rewritten. Each
went red naming its site, the faithful certificate passed before and after, and the restore was
re-verified.

## Phase E at 83, priced before it is run

Two measurements and one finding, all made while the block-form solve at 83 was still running.

**The checker at 83 costs 31 seconds and 410 MB.** Measured on a synthetic certificate — no solver, junk
blocks of the shape a real one will have (43 blocks, 165 slots, full rank 165, weights over 10⁶, Gram
factors over 10⁸), so the timing is the checker's and nothing else's: the orbit structure and the 98,894
canonical rows in 1.5 s, the two matrices' orbit sums in 13.0 s each, the multipliers and `N` in 0.6 s,
and the file 33.7 MB (at rank 60: 20.6 s and 19.8 MB). **The stub's worry — 49k classes × 86 blocks might
cost days — does not materialise**, for the reason section 7 of the derivation gives: the sums the
identity needs are the weights' correlations, so the work is `m` products per block per ordered pair of
circles, about 24 million steps, and never the 47 million-entry matrix.

One change was needed to get there, and it is worth naming because it was invisible at 23. The identity
check scanned every constraint row for every orbit — `O(orbits × rows)`, which is 2,724 steps at 11 and
**4.9 billion at 83**. Every row has at most two coefficients, so indexing the rows by the orbit they
touch makes it `O(orbits + rows)`. The 23 check went from 11.2 s to 5.1 s and both certificates verify
identically; at 83 it is the difference between half a minute and a week.

**The finding: the running block solve cannot feed a certificate.** `tools/fplane_sdp_blocks.py` writes
`value`, `status` and metadata — its `solve()` returns the primal `y` and main() does not store it, and
it never asks cvxpy for the dual matrices at all. So `sdp-p83-blocks.json`, when it lands, is **one float**:
decisive for the reading (is the triple-level bound below 1,149?) and unusable as a certificate's input.
The certificate at 83 needs its own solve, keeping the duals — `tools/fplane_cert_round.py --p 83 --blocks`,
which sets the problem up in exactly the convention `fplane_cert_check.load_circulant` reads, caches the
duals to `--dual-cache` so the rounding sweep never re-pays the solve, and is expected to want what the
running one wants (≈ 26 GB, single-threaded, hours).

That producer is controlled end to end at 11, where the answer is known: **N = 29.176927** from the block
form against **29.176807** from the dense certificate and **29.176799** from the solver — CERTIFIED by the
checker through the circulant path, in a 0.05 MB file, and evaluating correctly term by term at the
verified 28-point maximum independent set (`--against data/fplane/alpha-p11.json`: `⟨Z1,Y⟩ = 1.1458`,
`⟨Z2,M−Y⟩ = 0`, `Σλ·c = 0.0311`, `N − |S| = 1.1769`).

Regenerate: `python3 tools/fplane_lp.py --self-test` (controls: `ϑ′` reproduced with no rows; 28 feasible at 11 and 76 at
19 under every family; a planted `α` moves the bound, two-sided), then the three commands above.

## The real block form — the producer's solve at a quarter the block size, on the same wire and the same checker

Phase E's producer had one expensive step: the floating-point solve. A wire block (the form
`fplane_cert_check.load_circulant` reads, and the only form that fits at 83) carries **one** cosine and
**one** sine weight vector shared by every circle, so a block spans `2C + 1` slots — 165 at 83. The
block-diagonalisation that makes the solve small wants a **per-circle phase** instead: with the base
points fixed, the reflection forces every angular profile to satisfy `f_{cc'}(d) = f_{cc'}(a_{c'} − a_c − d)`
(where `a_c` is the angle of circle `c`'s reflected base point, which `build_orbits_fast` already
computes), and that makes `exp(i π j (a_c − a_{c'}) / m) · B_j[c, c']` **real**. So the Hermitian Fourier
block of size `C` — which the wire form carries as a real embedding of *twice* its spectrum — is a
diagonal-unitary conjugate of a real symmetric block of size `C`, and the solve can use the small one.

**A per-circle weight cannot be written on the wire. It does not have to be.** With
`phi_c = π j a_c / m`, the wanted weight is `w_c = cos(phi_c)·a + sin(phi_c)·b` — a combination of the two
weights the wire already carries — so the reduced map is `V_j = U_j T_j` for an explicit `(2C+1) × d`
matrix `T_j`, and

    <W, T_j^T (U_j^T Y U_j) T_j>  =  <T_j W T_j^T, U_j^T Y U_j>          identically in Y.

The producer therefore **solves with the reduced blocks and pushes each reduced dual back through the
congruence**, `Z_j = T_j W_j T_j^T`, before rounding. Nothing downstream changes: the sign probe, the
rounding sweep, the wire form, the file, and **the checker** are the same code and the same bytes
(`git diff tools/fplane_cert_check.py` is empty across this work). And nothing here reaches the trust
surface: `T W T^T` is positive semidefinite whenever `W` is, whatever `T` is — the same sentence section 4
of the derivation already makes about the block maps — so a wrong phase can only make `N` bigger.
At `j = 0` and `j = m/2` the sine weight is identically zero, so `T_j` is a plain selection of the cosine
slots (plus the origin at `j = 0`) and the reduction is trimming provable zeros.

**The controls** (`tools/fplane_cert_round.py --p P --check-real`, run at 11, 23 and **83**):

| check | 11 | 23 | 83 |
|---|---|---|---|
| (1) the vectorised wire arrays equal `block_setup`'s map, entry by entry | green | green | skipped by cost, with the reason printed |
| (2) the reduced map equals `T^T A T` | 5.3·10⁻¹⁵ | 2.1·10⁻¹⁴ | 3.7·10⁻¹³ |
| (3) **the wire block's whole spectrum is the reduced block's with each eigenvalue doubled** — so the reduction loses *nothing* | 5.0·10⁻¹⁴ | 9.1·10⁻¹³ | 2.4·10⁻¹¹ |
| (4) a planted reflection angle, and the flipped phase sign, both LOSE (3) | off by 6.3 / 12.8 | 20.6 / 49.7 | 107.6 / 575.0 |

Check (3) is the one that matters and it is an equality, not an inequality: the `2C`-dimensional wire
block and the `C`-dimensional real block impose the **same** condition. Check (4) is there because (3)
passing proves nothing unless a wrong phase can fail it.

### What it bought, with the two numbers kept apart

| at | solve, Hermitian blocks | solve, real blocks | ratio | tolerance |
|---|---|---|---|---|
| `fplane_sdp_blocks.py` (a reading; no duals kept), 11 | 5.5 s | 0.6 s | 9× | SCS default (10⁻⁴) |
| `fplane_sdp_blocks.py`, 23 | 208.0 s | 5.4 s | **38×** | SCS default (10⁻⁴) |
| `fplane_cert_round.py` (the producer; duals kept), 23 | 882.9 s | **146.9 s** | **6.0×** | `--eps 1e-9` |

The 38× and the 6.0× are different measurements and only one of them prices phase E: the reading tool at
its default tolerance against the producer at the tolerance a certificate wants. **The producer's figure
is 6.0×**, at 23, same tool, same tolerance, same machine, one thing differing.

**And the tolerance is nearly free**, which is worth recording because it was the reason to fear the
tight setting at 83 (23, real blocks, the whole rounding sweep re-run at each tolerance):

| `--eps` | solve | float bound | best exact `N` | `N` − float |
|---|---|---|---|---|
| 10⁻⁴ | 143.5 s | 108.621145 | 108.624183 | 3.0·10⁻³ |
| 10⁻⁵ | 190.4 s | 108.545615 | 108.575118 | 3.0·10⁻² |
| 10⁻⁶ | 168.0 s | 108.546095 | 108.548232 | 2.1·10⁻³ |
| 10⁻⁷ | 172.2 s | 108.546075 | 108.546226 | 1.5·10⁻⁴ |
| 10⁻⁸ | 196.1 s | 108.546073 | 108.546103 | 3.0·10⁻⁵ |

The solve time is flat in the tolerance at this size — SCS reaches 10⁻⁸ for a third more iterations, not
for an order of magnitude — and the whole spread of `N` is 0.08, far inside the one-unit granularity of
`⌊N⌋`. So the tolerance is not what decides the digit; the relaxation's own optimum is.

### The phase is load-bearing, and the first plant could not fire

Dropping the phase altogether — `T` = the cosine slots, which is what one gets by ignoring the reflection
angles — is a genuinely weaker relaxation: the optimum rises from **29.176799 to 29.893909** at 11 and from
**108.546073 to 113.377707** at 23. A single circle's angle shifted by one rises it to 29.285445 and
108.971608. That is the theorem behind the control: `T^T A T ⪰ 0` is implied by `A ⪰ 0` for *any* `T`, so
a planted `T` is a weaker constraint and the **optimum** can only rise.

**Two corrections to what was expected, both recorded rather than smoothed.**

*First, the plant this work was asked to watch could not fire.* Planting circle **0** left the optimum at
11 unchanged to eight decimals (−1.2·10⁻⁸, solver noise) and at 23 likewise (−5.3·10⁻⁸) — because circle 0
is the circle of quadrance 1, **the unit circle, every one of whose orbits is killed**, so its phase
multiplies nothing. A control whose failure mode is unreachable has not been tested by passing. The
producer now **refuses a plant on a dead circle by name**, printing the live ones:

```
$ ... --p 11 --blocks --real --plant-phase 0,1
[blocks] --plant-phase 0,1: every orbit of circle 0 (quadrance 1) is killed by a unit vector, so the
plant moves NOTHING and the control cannot fire.  Live circles: [1, 2, 3, 4, 5, 6, 7, 8] ...
```

*Second, "a wrong phase must make `N` larger" is not a theorem, and at 11 it was false by 3·10⁻⁶.* With
circle 0 planted (the dead plant), `N` came out **29.176805** against the faithful **29.176808** — smaller,
and both CERTIFIED, because `N` is the optimum plus a rounding error of order 10⁻⁴…10⁻⁶ that is not
monotone in anything. The sound statement is the one above: the **optimum** rises, and the certificate
stays sound whatever `T` is. On a live circle the end-to-end effect is visible as expected: circle 3
planted at 11 gives float 29.285445 and `N` = **29.285452**, weaker than 29.176808 and still CERTIFIED.
The tool now prints that sentence beside the plant so the next reader scores it against the float bound
and not against `N`.

### At 83: what the real form costs, what the solve has said so far, and the first certificate the checker has read there

**The setup is affordable and controlled.** 6,889 points, 82 circles, 564,981 rotation orbits, 49,447
pair orbits (1,764 killed), 98,894 canonical rows, in 1.3 s. The real blocks are **43 of size 82–83**
against the 330-row embedding the Hermitian form would need, 24,576,550 map entries, built in 11.6 s;
the cone data cvxpy hands SCS is `A` of shape 391,718 × 49,447 with 18,552,972 nonzeros and 86
positive semidefinite blocks of size ≤ 83, built in 127 s. `--check-real` runs **at 83** (check (1)
skipped by cost, with the reason printed): the reduced map equals `TᵀAT` to 3.7·10⁻¹³, the wire block's
whole spectrum is the reduced block's doubled to 2.4·10⁻¹¹, and both negative controls are reachable
there (off by 107.6 and 575.0).

**The solve is the whole cost, and the linear-system backend is the whole lever.** SCS picks its
backend by a *string* keyword, `linear_solver=` (`qdldl`, `mkl`, `cpu_indirect`, `cpu_dense`,
`gpu_indirect`, `cudss`); passing nothing leaves the wheel's auto choice, which in `build/venv-sdp` is
a **sequential** MKL Pardiso. Measured on this problem:

| backend | seconds per 500 iterations | per iteration | machine conditions |
|---|---|---|---|
| auto (sequential MKL Pardiso, `build/venv-sdp`) | 1,679 and 1,798 | ≈ 3.5 s | **contended** — three other semidefinite solves on the box |
| the same, uncontended | — | ≈ 1.4 s | measured separately once the box was clear |
| `gpu_indirect` (graphics card A, `build/venv-sdp-gpu`) | 98–99 | ≈ 0.20 s | one other solve |

**The two sequential figures are the same backend under different load**, and the honest ratio for the
GPU is therefore about **7×**, not the 17× the contended number gives. The 3.5 s is a real measurement
of a real situation — it is what the run actually cost while four solves shared the memory bandwidth —
but it is not the backend's cost, and a ratio built from it is a ratio of two different things.

**The backend does not move the answer** — controlled at 11, where `auto`, `qdldl` and `cpu_indirect`
all give the float bound 29.176799 and `⌊N⌋ = 29`, the exact `N` agreeing to 10⁻⁶ (the duals differ in
their last digits, as they must). `cpu_indirect` is the precedent that matters, because it is the same
*kind* of method as the GPU backend: an iterative solve of each step's linear system rather than a
factorisation, which can change the iterate sequence and not merely its speed.

**The trajectory, chunk by chunk**, each line a checkpoint on disk. It is an ADMM iterate and **not a
bound**: SCS's iterates are neither feasible nor monotone, and the objective can move.

| iterations | backend | pobj | res_pri | res_dual |
|---|---|---|---|---|
| 500 | auto | −1085.752190 | 4.73 | 9.83 |
| 1,000 | auto | −1073.968923 | 2.94 | 3.77·10⁻¹ |
| 1,500 | gpu | −1072.999847 | 1.25 | 8.86·10⁻¹ |
| 2,500 | gpu | −1071.110024 | 1.48 | 7.51·10⁻² |
| 3,500 | gpu | −1070.813018 | 1.53 | 6.69·10⁻² |
| 4,500 | gpu | −1070.561505 | 1.58 | 6.18·10⁻² |

**Two exact bounds at 83, from iterates, hours before convergence.** `--round-only` reads the running
solve's checkpoint and rounds from it without advancing or rewriting it; **any** dual gives a sound
certificate (section 4 of the derivation), so a half-converged iterate gives a real exact bound:

| from the iterate at | res_pri | res_dual | float objective | exact `N` | `⌊N⌋` | `N` − objective |
|---|---|---|---|---|---|---|
| 500 iterations | 6.16 | 12.9 | 1085.72 | 2466.274139 | 2466 | 1380.6 |
| 1,000 iterations | 1.34 | 26.7 | 1073.97 | **2232.886881** | **2232** | 1158.9 |
| 6,000 iterations | — | — | 1070.25 | 1379.804227 | 1379 | 309.6 |
| 19,500 iterations | — | — | 1067.79 | 1285.910286 | 1285 | 218.1 |

The gap between the bound and the objective is the **dual's** inaccuracy, and it is what has to close:
the objective has been within half a unit of 1,070 since 3,000 iterations, while `N` has come down from
2,466 to 1,380 as the dual residual fell. The six-colour threshold is 1,148, so what decides the
milestone is whether that gap closes past about 78 before the solve converges — and every reading is a
sound bound whatever it says.

Both are far above the ratio bound 1,199.46 and neither is a result — they are what a dual at those
residuals proves. **What they establish is the machinery**, and the second one establishes it
completely: the **unmodified** checker read a real 15.28 MB certificate at 83 and accepted it **in 17.9
seconds** — the group, its 49,447 orbits and all 98,894 canonical rows rebuilt from the number 83 alone
and agreeing with the file row for row; 98,894 multipliers with the 97,129 attached to inequalities
non-negative; 43 circulant blocks over 165 slots per matrix, each a rational Gram factor; and the affine
identity exact over every one of the 49,447 orbit coefficients and the constant term. At `⌊N⌋ = 2232`
the strongest colouring sentence it can add is `k = 3` (3 × 2232 = 6,696 < 6,889); the six-colour
sentence needs `⌊N⌋ ≤ 1,148`. Until this file the checker had only ever seen a *synthetic* certificate
at 83.

The artefact is `build/fs50/cert-p83-iter1000-N2232.json`, untracked — it says less than a character sum
does. **It is not reproducible from the checkpoint**, and that is worth stating because the obvious
assumption is wrong: `scs-p83-cert-real.npz` is rewritten every 500 iterations, so the 1,000-iteration
iterate exists nowhere on disk any more. A fresh `--round-only` yields a *different, tighter* bound from
a *later* iterate; this file is the only record of this one.

**Resume.** The iterate lives in `data/fs50/ckpt/scs-p83-cert-real.npz` and is rewritten after every
chunk; a relaunch continues from it, across backends, and refuses a checkpoint whose shape belongs to
another prime. The rounding sweep's own checkpoint is `data/fs50/ckpt/round-p83-real.jsonl`, and every
row in it now carries a fingerprint of the dual that scored it.

```
build/venv-sdp-gpu/bin/python tools/fplane_cert_round.py --p 83 --blocks --real --chunk 500 \
    --scs-ckpt data/fs50/ckpt/scs-p83-cert-real.npz --linear-solver gpu_indirect \
    --eps 1e-8 --max-iters 400000 --dual-cache data/fs50/ckpt/dual-p83-real.npz \
    --ckpt data/fs50/ckpt/round-p83-real.jsonl --thresholds 1e-9,1e-8,1e-6,1e-4 \
    --denominators 1000000,100000000,10000000000 --weight-denominators 100000000,10000000000 \
    --out data/fs50/cert-p83.json
```

An exact bound from the iterate as it stands, at any moment, without touching that run:

```
build/venv-sdp/bin/python tools/fplane_cert_round.py --p 83 --blocks --real --chunk 500 \
    --scs-ckpt data/fs50/ckpt/scs-p83-cert-real.npz --round-only --eps 1e-8 \
    --ckpt data/fs50/ckpt/round-p83-anytime.jsonl --thresholds 1e-8 \
    --denominators 10000000000 --weight-denominators 10000000000 --out <a file>
```

**The `--linear-solver` flag, and the control that it does not move the answer.**
`tools/fplane_cert_round.py --linear-solver <backend>` passes the string straight to SCS's constructor
in the chunked path (default `auto`, so every existing command line is unchanged). The backend changes
only how each iteration's linear system is solved, never the problem or the iterate, so a warm start
carries across backends — but `gpu_indirect` and `cpu_indirect` are *iterative* solves of that system
rather than factorisations, which can change the iterate sequence and not merely its speed, so the
claim was controlled rather than assumed. **At 11, `auto`, `qdldl` and `cpu_indirect` all give the float
bound 29.176799 and `⌊N⌋ = 29`, with the exact `N` agreeing to 10⁻⁶** (the duals differ in their last
digits, as they must). `cpu_indirect` is the precedent that matters, being the same kind of method as
the GPU backend.

**A valid strengthening that does not bind, measured rather than assumed.** `canonical_constraints`
emits one dominance row per orbit, `y_k ≤ y_{d(k)}` with `d(k)` the class of the representative's first
endpoint. P6 is a containment of counting sets and holds at **each of the triangle's three edges**: the
`z ∈ S` with `z + u, z + v ∈ S` inject into `{z : z + u ∈ S}` (class `Q(u)`), into `{z : z + v ∈ S}`
(class `Q(v)`), and — by `z ↦ z + u` — into `{w : w + (v − u) ∈ S}` (class `Q(v − u)`). The other two
rows are valid and are **not** implied by the S₃ identification: the orbit does contain representatives
with each of the three classes at the first endpoint, but only one representative gets a row. The
reading drivers impose all three; the certificate proves only one, so the certified relaxation is
formally the weaker of the two.

It makes no difference at either prime where both can be solved. Both formulations, in one tool at one
tolerance (SCS, `eps 1e-9`, `optimal`):

| p | canonical (what the certificate proves) | all three edges (what the readings solve) | further rows |
|---|---|---|---|
| 11 | 29.176799 | 29.176799 | 152 over 96 orbits |
| 23 | 108.546073 | 108.546073 | 1,740 over 980 orbits |

The rows are simply not active at the optimum. **The comparison that appeared to show otherwise differed
in two things**: the reading tool's 108.5467 against the producer's 108.546073 is the tolerance, not the
rows — at SCS's default 10⁻⁴ the producer's own formulation reads 108.621145. So the extra rows stay
recorded as a known unexploited strengthening, not built: certifying them touches the multiplier
construction (steps 1–3 of the derivation assume one row per orbit pointing at one target), the wire
format's row list, and both existing certificates, for no measured gain.

### The refusal of six at 83 (2026-09-15, 06:05): α(UD(𝔽₈₃, 2)) ≤ 1082, two independent exact certificates

**The claim, at the exact-rational level:** every independent set of UD(𝔽₈₃, 2) has at most **1076** points (the tightest
certificate in the table below; 1082 was the first pair), so 6 × 1076 = 6,456 < 6,889 and **the plane is not six-colourable**; with `add_one_le_chromaticNumber_of_indepNum_le` (kernel) that is
χ(UD(𝔽₈₃, 2)) ≥ 7. The certificate is checked by `tools/fplane_cert_check.py`, which rebuilds the group, its 49,447 orbits and
the 98,894 canonical rows from the number 83 and trusts no solver; the kernel form of the certificate itself is FS-52.

| file (`data/fs50/p83-refusal/`) | exact N | ⌊N⌋ | produced from | checker `--k 6` | `--ldl` |
|---|---|---|---|---|---|
| `cert-p83-N1082-pardiso-arm.json` (15.1 MB) | 54145768919878014998796452705507433877093 / 5·10³⁷ = 1082.915378 | **1082** | the 5,000-iteration iterate resumed for +500 in a fresh solver on sequential MKL Pardiso (`build/venv-sdp`), its own dual at the chunk end | CERTIFIED, "not 6-colourable", 15.2 s | CERTIFIED, 1 m 55 s |
| `cert-p83-N1082-gpu-arm.json` (15.1 MB) | 676848530876231948246514932098797470489039 / 6.25·10³⁸ = 1082.957649 | **1082** | the same parent iterate resumed for +500 in a fresh solver on `gpu_indirect` (graphics card A, `build/venv-sdp-gpu`) | CERTIFIED, "not 6-colourable", 15.2 s | CERTIFIED, 1 m 55 s |
| `cert-p83-N1076-polish-40500.json` (15.1 MB) | 42045564621001773194639845780964924918379 / 3.90625·10³⁷ = **1076.366454** | **1076** | the live run's 40,500-iteration checkpoint resumed for +500 in a fresh solver on `gpu_indirect`, its own dual at the chunk end — the polish loop's first output, the recipe reproduced | CERTIFIED, "not 6-colourable" | CERTIFIED, 2 m 10 s |
| `cert-p83-N1252-pardiso-arm-nudged.json`, `cert-p83-N1250-gpu-arm-nudged.json` | 1252.08, 1250.03 | 1252, 1250 | `--round-only` on the two 5,500-iterates (one nudge iteration from a fresh solver object, cut 10⁻⁶, denominators 10⁸) | CERTIFIED, say nothing about six | — |

**How they came to exist, because the mechanism is the finding.** The two arms were the backend-honesty control: the same
5,000-iteration checkpoint (`iterate-5000-common-parent.npz`) resumed for 500 iterations on each backend, to compare the
chunk lines with one thing differing. They agree — pobj −1074.201411 against −1074.213493, res_pri 7.39e-1 both, res_dual
1.64 both — and each arm's own rounding sweep then rounded its dual to ⌊N⌋ = 1082, **while the live run's iterates at
19,500–33,500 rounded to 1286–1260 with an objective near 1,067**. The difference is SCS's adaptive scale, which is not in
the checkpoint: a long run's scale drifts (its reported residuals are in the scaled space), and a resumed run restarts it at
the default and, 500 iterations later, holds a dual that rounds to within 9 of its objective instead of 200. The nudged
certificates above measure the other half of the same mechanism: `--round-only`'s one iteration from a fresh solver object
moved the dual residual from 1.64 to 3.19 and cost ≈ 170 in the bound. **So the exact bound is read from a fresh short
continuation's own dual at its chunk end, never from a long-run iterate and never through a nudge**; the live loop now does
that (`anytime-loop2.sh` in the session's scratch). Reproducibility: a deterministic rerun of the Pardiso arm from the same
parent with a dual cache and three cuts is recorded beside this table when it lands (its 10⁻⁸ / 10¹⁰ candidate must reproduce
1082.915378 to every digit; the other cuts round the identical dual).

**Reproduce** (each ≈ 30 min on the CPU wheel, ≈ 6 min on the GPU wheel): `tools/fplane_cert_round.py --p 83 --blocks --real
--chunk 500 --scs-ckpt data/fs50/p83-refusal/iterate-5000-common-parent.npz --linear-solver mkl --eps 1e-8 --max-iters 5500
--thresholds 1e-8 --denominators 10000000000 --weight-denominators 10000000000 --out <file>` (copy the iterate first: the run
advances it), then `tools/fplane_cert_check.py <file> --k 6 --ldl`.

**Not claimed:** the converged value of the relaxation (the producer's iterate reads 1,064.5 at 38,500 iterations and is
still moving; the exact bound will tighten toward it, and the table's entry is whatever the last certificate says); anything
about seven-colourability (a 7-colouring of the plane has not been sought); the kernel form (FS-52).

**The checker changed once, 2026-09-15 05:05, under a recorded decision** (`plans/STUB-independence-threshold.md` §M3):
`--against` decides the display's affordability (`p ≤ 29`) from `p` alone before any quadratic work, re-verifies the set's
independence straight from coordinates at every `p`, treats a bad or missing set as a fault in the SET (exit 2, `THE --against
SET IS NOT USABLE`) and never as a refusal of the certificate, and restates the CERTIFIED sentence as the last line of every
path. Before the change a run at 83 spent 34 minutes in the orbit construction and then ended a certified run on `NOT A
CERTIFICATE`. Self-test green with three new controls (12–14); the 1,000-iteration certificate re-checked with `--against` in
16.9 s, exit 0, ending on CERTIFIED; the four checks themselves are untouched.

**Two traps this phase paid for, both now mechanisms rather than scars.** (i) **A `timeout` wrapper
cannot be detached after the fact on this machine**: GNU coreutils 9.11's `timeout` arms
`PR_SET_PDEATHSIG` on the command it monitors, so `kill -KILL <timeout-pid>` takes the child with it —
tested twice on `sleep`, with and without `--foreground`. Wrapping a multi-hour solve in a wall and
planning to lift the wall later does not work; the shape that does is no wrapper plus an in-process
checkpoint. (ii) **SCS ends every chunk with the status `solved (inaccurate - reached max_iters)`**,
because `max_iters` *is* the chunk size — so a `startswith("solved")` break stops after one chunk and
reports whatever the iterate happened to be, with nothing to warn a reader. At 11 that read 29.2729
against the true 29.1768 and looked like a clean success.

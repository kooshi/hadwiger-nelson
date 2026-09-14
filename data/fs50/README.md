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

Regenerate: `python3 tools/fplane_lp.py --self-test` (controls: `ϑ′` reproduced with no rows; 28 feasible at 11 and 76 at
19 under every family; a planted `α` moves the bound, two-sided), then the three commands above.

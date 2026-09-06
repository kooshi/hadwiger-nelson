# data/fplane — the finite-plane bound (the pivot of 2026-09-06; `reference/Chat-analysis/VERIFICATION.md`; the milestone is M58, `plans/M58-field-sieve.md`)

A real number field F with a prime 𝔭 above p ≡ 3 (mod 4) whose residue field is 𝔽_p (or 𝔽_{p^f}, f odd) sends every
finite unit-distance graph in F² homomorphically into the finite Euclidean plane UD(𝔽_p, 2) = Cay(𝔽_p², {a² + b² = 1}),
so χ(F²) ≤ χ(UD(𝔽_p, 2)). The records here are the computable halves of that statement. Regenerate with
`tools/fplane.py` (`self-test` first: 11 controls, including a planted wrong residue for √3 that must break the homomorphism).

**What a record licenses.** *A `chi-p<P>` record's `colouring` is verified proper here — a certificate that χ(UD(𝔽_P,2)) ≤ chi;
its `unsat` rows are the solver's claim (untrusted) — `exact: true` means chi − 1 was refused by the solver and chi carries
a verified colouring. A `reduce-<stage>-p<P>` record's `edges_on_circle = edges` is an exact finite check that the stage's
reduction is a homomorphism (a certificate for THAT stage); its `pullback_proper: true` is a verified colouring of the stage
(a certificate that χ(stage) ≤ k). Neither record says anything about χ(ℝ²).*

| artifact | what | what a reader may conclude |
|---|---|---|
| `chi-p11.json` | UD(𝔽₁₁, 2): 121 vertices, 726 edges (the circle has 12 points); k = 2, 3, 4 refused (solver), k = 5 found and verified; the colouring as 11 rows | χ(UD(𝔽₁₁,2)) ≤ 5 certified by the colouring; = 5 given the solver's refusal at 4 — or, solver-free, given Heule-510's kernel-certified refusal of four colours and its reduction below |
| `reduce-heule510-p11.json` | Heule-510 (ℚ(√3,√5,√11), denominator 96) reduced with √3 ↦ 5, √5 ↦ 4, √11 ↦ 0: 510 points onto all 121 residues, 2,504 / 2,504 edges on the circle, the pulled-back 5-colouring proper | the reduction is a homomorphism; χ(Heule-510) ≤ 5 by pullback; with the kernel's χ(Heule-510) ≥ 5, χ(UD(𝔽₁₁,2)) ≥ 5 without any solver |
| `reduce-W-core-8over3-p11.json` | the T20 witness W (K(√247)): √247 ↦ 4 (247 ≡ 5 mod 11); 5,773 / 5,773 on the circle; pullback proper | χ(K(√247)²) = 5 exactly (W is 5-chromatic) |
| `reduce-EI-seed-unit-p11.json` | the Exoo–Ismailescu seed's unit part (K): 214 points onto 51 residues; 1,004 / 1,004; pullback proper | consistent with Theorem B's 4 (the 11-bound is the weaker one on K) |

Not here: the sieve's outputs (`fplane.py usable --rads …`, printed, not written), the planes at p = 13–23 and 83/107/131
(running at the compaction, logs under `build/m57/`; M58 writes their records here as `chi-p<P>.json`), and the shadow
sieve's records (`shadow-<stage>-p<P>.json`, M58).

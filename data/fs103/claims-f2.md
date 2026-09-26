# FS-103 — claims for the blind check of the fractional shadow (statements only)

*Copied verbatim by the product owner from `plans/FS103-F-fractional-shadow.md` (job FS103-F, one mind): the definitions block of §2.3 and the
statement column of its "Theorems this phase proved" table. **No proof, no route.** Give each claim one verdict — TRUE (with your derivation),
FALSE (with a counterexample), GAP at a named step, or MISSTATED (with the corrected statement) — with your grade and count of minds.*

## Definitions and the main statement (verbatim, FS103-F §2.3)

**FS103-F-FRAC — the fractional local–global principle, given MR [hand; one mind (this job); grade note trimmed by the owner].** Let `F` be a real number field with `R_F = O′` (row 100's scope). Define:
- `r_v` = the all-levels independence ratio at a stable place `v`: the measurable independence ratio of its compact local plane, equal to
  `sup_k α(G_{v,k})/|G_{v,k}|` by X25B-L1 and pullback;
- `m₁ = m₁(ℝ²)`;
- `ρ(F) = max(m₁, sup_v r_v)`. The supremum is a maximum: by Weil and the two-point bound, `r_v ≤ w/(1 + w)` with `w = 2√q/(q+1) → 0`.

**Then, given MR(F):** every `R ⋊ U`-invariant random independent set `I` of `Cay(R, U)` has `P(0 ∈ I) ≤ ρ(F)`. Consequently:
- **`α₁(F²) = α_inv(F²) = ρ(F)`.** Here `α₁(F²)` is the infimum of `α(G)/|G|` over finite unit-distance graphs `G` with vertices in
  `F²`, and `α_inv(F²)` is the supremum of `P(0 ∈ I)` over `R ⋊ U`-invariant random independent sets.
- **Unconditionally:** an `R ⋊ U`-invariant random independent set of density `> ρ(F)` gives an SP witness over `F`, so MR(F) fails.

## The claims (verbatim, the statement column)

- **FS103-F-FRAC.** given MR(F) (`R_F = O′`): every `R ⋊ U`-invariant random independent set of `F²` has density `≤ ρ(F) = max(m₁(ℝ²), sup_v r_v)`; so `α₁(F²) = α_inv(F²) = ρ(F)`; unconditionally, density `> ρ(F)` gives an SP witness
- **FS103-F-TJ.** T-J39-3 per class: a density-`δ` invariant independent set gives `max(m₁, max_{v∈N_δ} r_v) ≥ δ` or an SP witness, `N_δ` the places with `λ*_v ≥ δ/(1−δ)`; the mixing selection per class keeps only density `≥ (δ−ϑ)/(1−ϑ)`
- **FS103-F-ROUND.** row 123's lower bound is `χ(F²) ≥ ⌈1/ρ(F)⌉`: the colour count enters only as the pigeonhole on the densest class; `1/ρ(F) ≤ 4.36` at every field, so this route never gives six
- **FS103-F-DV.** given MR(ℚ(√635087)): `α₁(ℝ²) = m₁(ℝ²)`, i.e. `f(n)/n → m₁(ℝ²)` (`[DuczVarga2026]` Conjecture 1, first clause); `χ_f,0(ℝ²) = χ_f(ℝ²) = 1/m₁(ℝ²) ≥ 4.04876`
- **FS103-F-TF.** given MR(ℚ(√635087)): for every `ε > 0` a finite **triangle-free** unit-distance graph has independence ratio `≤ m₁(ℝ²) + ε ≤ 0.24699 + ε`
- **FS103-F-47.** given MR(ℚ(√47)) (row 121's own hypothesis), with only held certificates: `α₁(ℚ(√47)²) ≤ 1/4 − 2.745·10⁻⁶` (31's Hoffman bound binds), a triangle-free finite graph with `χ_f ≥ 4.0000439`

## Known inputs (by statement; open to you with their proofs)

- MR(F): `LEDGER.md` row 120, verbatim there. SP witness: `data/fs103/claims.md` D-SP. `m₁(ℝ²) ≤ 0.246989` (`[AmbrusEtAl2023]` Thm 1; row 92); Croft's `m₁ ≥ 0.22936` (`BIBLIOGRAPHY.md` `[Croft1967]`).
- Row 123 and the derivations it addresses (`plans/FS100-derivation.md` §4, the X23/X25B/X26B records), rows 116–127, J45's lemmas (`plans/FS84-SI-D-derivation.md`), R88-TC-ext (`plans/R88-derivation.md`).
- `[MatolcsiEtAl2025]` (arXiv:2311.10069) and `[DuczVarga2026]` (arXiv:2606.28157), both held (paths in `BIBLIOGRAPHY.md`): read their conjectures in their own words.

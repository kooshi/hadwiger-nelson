# FS-103 — claims for the blind check of Phase 3 (statements only)

*Copied verbatim by the product owner from `plans/FS103-M-derivation.md` (job FS103-M, one mind), its "Theorems this phase proved" list,
with grade notes and section addresses trimmed (they name the route). **No proof, no route.** One verdict per claim — TRUE (with your
derivation), FALSE (counterexample), GAP at a named step, or MISSTATED (corrected statement) — with your grade and count of minds.*

## Definitions

- `χ_CP(ℝ²)`: `data/fs103/claims.md` D-CP (b), verbatim there. `χ_m(ℝ²)`, `χ_m⁰(ℝ²)`, `χ_B(ℝ²)`: `data/fs103/claims.md` D-M, verbatim there.
- `χ(A_σ)`: the operator chromatic number of `[BachocEtAl2014]` (Bachoc–DeCorte–Oliveira–Vallentin 2014, held; path in `BIBLIOGRAPHY.md`), for the
  unit-distance operator of the circle measure `σ`; read its definition there (§2.4, §2.6).
- A **Rajchman** measure: one whose Fourier transform tends to 0 at infinity.

## The claims (verbatim)

- **M1** — C-FMT (c): `χ_CP(ℝ²) ≤ χ_m⁰(ℝ²)`; general form for Rajchman edge measures on `ℝⁿ`. [grade note trimmed by the owner]
- **M1′** — `χ_CP(ℝ²) = χ_m⁰(ℝ²) = χ(A_σ)` (`[BachocEtAl2014]`'s operator chromatic number). [grade note trimmed by the owner]
- **M1″** — C-CPM with no MR: `χ_CP(ℝ²) ≤ χ_m(ℝ²) ≤ χ_B(ℝ²)`. [grade note trimmed by the owner]
- **M1.1, M1.2** — continuity in probability is free for invariant measures on fractional colourings; properness survives weak-* limits when `σ̂ → 0`, not otherwise (C3). [grade note trimmed by the owner]
- **A-E3′** — `χ_m⁰(Cay(ℝ, {±1, ±√2})) = 3`. [grade note trimmed by the owner]
- **Q4** — given MR: `χ(ℝ²) = χ_m⁰(ℝ²) = χ(A_σ) = χ(ℚ(√635087)²)`. [grade note trimmed by the owner]

## Held, by statement (two blind minds, FS-103 verifiers): every CP `k`-colouring of `UD(ℝ²)` has a jointly measurable version; hence `χ_m⁰(ℝ²) ≤ χ_CP(ℝ²)` (C-FMT (a), (b)).
## Given MR (row 120) and FS-103's collapse (two blind minds): `χ(ℝ²) = χ_CP(ℝ²) = χ(ℚ(√635087)²)`.

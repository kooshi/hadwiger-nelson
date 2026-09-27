# FS-104 — the stationary chromatic number at six: is `χ_CP(ℝ²) ≥ 6`? (stub)

> **Re-aimed at the reframe (2026-09-26, job RF1; `plans/FRONTIER-STUBS.md`'s re-rank note; `plans/STUB-regularity-wall.md`): rank 1 → 3,
> below the program Kooshi adopted (`CLAUDE.md` § The aim) — FS-106, the regular half (rank 1), and FS-107, regularity against pathology
> (rank 2). Re-aimed, not demoted.** Its **null-set step** — item (1) of the banner below, "colour the metrical boundary", C-FMT (d),
> `χ_m⁰ = χ_m` (`plans/FS103-derivation.md` FS103-M-D) — **folds into FS-107 as one of its sub-questions** (the regularity-wall stub: "the
> null-set step is one sub-question of FS-107"). **Its other items stand here:** (2) `χ_B` against `χ_m`, (3) the ZF + DC audit, (4) the
> prior-art debts; the density family, Falconer's mechanism in CP form, `k`-point correlation constraints, `χ_g(H)` (post-ban) and the mirror
> (routes (0)–(d) below). The text below is the stub as it stood before the reframe: its "Rank 2" line is as minted, and its "Bearing on
> χ ≥ 6" is read, since the reframe, as a bearing on the answer (`CLAUDE.md` § Counter-priors, rule 1).

> **Re-aimed at FS-103's close (2026-09-26; `plans/FS103-collapse-cp-plane.md` §R-close).** `χ_CP(ℝ²) = χ_m⁰(ℝ²) = χ(A_σ)` with no MR (row 130,
> two minds), and given MR it is `χ(ℝ²)` (rows 128, 130). So the question is now: **is the plane's measurable chromatic number, null sets of
> unit pairs ignored, at least six?** In order: (1) **colour the metrical boundary** — `χ_m⁰ = χ_m` iff some a.e.-proper colouring's null set
> `E` (`[Falconer1981]` Lemma 2) is list-colourable from lists of size ≥ 2 (FS103-M-D, one mind), with M's hunch first (two adjacent points of
> `E` cannot have `P(x) = P(y) = {a, b}`; killing test: an a.e.-proper colouring with such a pair); slack colourings need six (`χ^{sl} ≥ 6`), so
> a five would be tight; (2) `χ_B` against `χ_m` (the same step with a Borel choice); (3) the ZF + DC audit of the chain (MR, the load-bearing
> step, M1): with (1) it would make `χ(ℝ²)` absolute and answer Soifer's Open AC Problem 62.14 at `n = 2` (a reading, not claimed); (4) the
> prior-art debts: "a.e.-proper measurable colouring + Rajchman edge measure ⟹ stationary CP colouring" (N), and a gate under
> descriptive-combinatorics names for "finitary = measurable independence ratio" (FS103-F §3.6); then the density family and correlation
> constraints as before. The advisor's A-E5 has its second mind (FS103-N). Bearing on six: decisive, given MR; success very low.

*Minted 2026-09-26 by job R3 from R1's N2 (`plans/RERANK-2026-09-26.md` §2.2) and the advisor's top-three item 2
(`plans/POROS-2026-09-26-rerank.md` stage 1). Rank 2 in `plans/FRONTIER-STUBS.md`. **Solver column:** none for routes (a)–(c) (reading,
derivation, in-ban); (d) is an LP on a finite configuration, post-ban. Written for a session with zero conversation memory.*

**Kooshi's words** (2026-09-26): *"We now have a real foundation to reach for 6 (or prove that no field is 6 colorable, which would be
fascinating) and potentially answer the HN problem definitively."* — and *"If we end up at a wall which collapses HN to another known open
problem, that in itself would be a writeup."*

## The question

`χ_CP(ℝ²)` is the least `k` for which the unit-distance graph of the plane carries a stationary random `k`-colouring, continuous in
probability, proper almost surely on every unit pair (FS100-BC's definition, quoted in full in FS-103). **Is it at least six?**

- **What is held** (row 125, [hand, two blind]): `χ(F²) ≤ χ_CP(ℝ²)` for every countable `F ⊆ ℝ`, so `χ(ℝ²) ≤ χ_CP(ℝ²) ≤ 7`; and given MR,
  six at ℚ(√167) contains `χ_CP(ℝ²) ≥ 6` as a conjunct. **No held result gives `χ_CP(ℝ²) ≥ 6`, and no one-point density bound can**
  (row 125: Croft's `m₁ ≥ 0.2293 > 1/5`, `[Croft1967]`).
- **What it would be, given FS-103's F1 (a candidate, not held):** rung D itself — `χ(ℝ²) ≥ 6` ⟺ `χ_CP(ℝ²) ≥ 6` — and six at every field with
  no non-6-thick stable place. Without F1 it is `χ_CP ≥ 6`, which implies `χ_m(ℝ²) ≥ 6` for Falconer's measurable chromatic number since
  `χ_CP ≤ χ_m` (the advisor), open since 1981 (`5 ≤ χ_m ≤ 7`; `[Falconer1981]`, **not held**).

## Routes, cheapest first (R1's N2; the advisor's stage 1)

- **(0) Read `[Falconer1981]` first, as a CP statement** — the advisor: continuity in probability lets a forced pair's distance vary
  continuously, which may be Falconer's mechanism. Owed before any route is ranked (G50). With it: Soifer's measurability chapter, the
  Polymath16 measurable page, Bachoc–Nebe–Oliveira–Vallentin (arXiv:0801.1059), `[AmbrusEtAl2023]`.
- **(a) The density family.** A CP five-colouring needs `m_j(ℝ²) ≥ j/5` for every `j ≤ 4` (X21D-Y). R1's reading, **unchecked**: disjoint
  translates of Croft's set into its lattice's deep holes give `m₂ > 2/5` and `m₃ > 3/5`, so `j = 2, 3` die as `j = 1` did; `j = 4` unknown
  (`m₄(ℝ²) < 4/5`?). [reading, R1; the advisor: "a check on Croft's parameters, not a derivation"]. The route to six, if any, is integrality
  (G24; X21D's B-3 answer: "a non-density (integrality) argument").
- **(b) Falconer's mechanism in CP form** (the advisor): a forced pair whose distance moves continuously.
- **(c) `k`-point correlation constraints** on stationary colourings — the tetrahedral embedding at five colours, three- and four-point Bessel
  kernels à la Bachoc–Oliveira–Vallentin; FS-80's averaged certificate at the real place (FS-80 re-aimed). An optimisation: post-ban unless its
  shape is derived first (the advisor).
- **(d) The integral geometric chromatic number `χ_g(H)`** of a finite configuration — `χ(ℝ²) ≥ χ_g(H)` by amenability alone, no MR — whose LP
  is a finite witness (post-ban).
- **The mirror** (FS-44 at the real place): what a CP five-colouring of the plane would have to look like.

## Registered expectations (both outcomes reachable)

- R1: `χ_CP(ℝ²) ≥ 6` proved — 0.02; the density family closed at `j = 2, 3` by Croft translates — 0.70; a no-go of another named format — 0.40;
  a CP five-colouring of the plane — below 0.01.
- **The advisor's prior** (its stage 1, verbatim): *"**Six itself:** won, near-term, P ≈ 0.03 (it is `χ_m`-strength, open 45 years); shown
  impossible for fields (S), P ≈ 0.02. The realistic product is the collapse — a reduction of HN to a named open problem — which is the
  write-up Kooshi named."* Its hunch `no-bound-on-chi-cp-this-cycle`: the next milestone on `χ_CP(ℝ²)` proves no bound beyond five in either
  direction (basis: prior); falsifier: `m_j(ℝ²) < j/5` for some `j ∈ {2,3,4}`, or a measurable "+1" mechanism from a finite forced pair.

## Provisional bearings

G24 (the step to seven in the cell family is integrality; a relaxation that sees the gap is open), G60 (the fractional cap 4.36 and the real
place's `J₀` minimum), G64 (six in the gap; skipping is not evidence), G48, G59, G80, G73 (averaged certificates are one of the formats left),
G72 and G79 (pose the structural form; hunt the invariant every CP colouring carries), G21, G49/G50 (Falconer not held). Stubs: FS-103 (whose
F1 makes this rung D), FS-44 (the mirror), FS-80 (route (c)), FS-49 (the finite-graph route to the same rung, post-ban), FS-102.

## Bearing on χ ≥ 6

Derived-decisive if FS-103's F1 holds (it is rung D); success per milestone very low; a no-go of a named format, or a reading that ties
`χ_CP` to `χ_m`, is the likely product.

*Would have searched here:* nothing for (0)–(c); (d) is a finite LP and waits for 2026-10-01.

# Poros — FS-81, HELD items (for the owner only; never sent to the planner or to stage C)

*Candidate routes to the family / T4 derivation, held under the brief's rule so that stage C's first routes stay independent.*

## H1. The invariant-measure form of the whole-field criterion (a candidate route to T4 by a Delsarte-type LP)

Let `Θ₃(F) ⊂ Hom(F², ℝ/ℤ)` be the characters banding every unit vector in [1/3, 2/3]. It is compact and invariant under the unit
vectors U(F) acting by rotation (ψ ↦ ψ(u·)). U(F) is abelian, hence amenable, so `Θ₃(F) ≠ ∅` iff it carries a U(F)-invariant
probability measure μ (Markov–Kakutani). The Fourier transform of μ is a positive-definite function φ on the discrete group F², and
U(F)-invariance makes it radial: φ(x) = Φ(|x|²) (U(F) acts transitively on each circle of F², since y/x ∈ U(F) when |x| = |y|). The
support condition "ψ(u) ∈ [1/3, 2/3] μ-a.s. for every u" (countably many u) is, for each u, that the pushforward of μ under ψ ↦ ψ(u) —
whose Fourier coefficients are φ(ku) = Φ(k²), the same for every u — is supported in [1/3, 2/3]. So:

> **χ(F²) ≤ 3 iff there is Φ with Φ(0) = 1, x ↦ Φ(|x|²) positive definite on F², and k ↦ Φ(k²) the Fourier–Stieltjes transform of a
> probability measure on ℝ/ℤ supported in [1/3, 2/3].**

(⟸ needs the joint support to be in Θ₃(F); the countable intersection of full-measure sets gives it.) A proof of T4 is then an
infeasibility certificate for this conic program, which lives on finite configurations of F² (compactness again) and could be uniform
in d. This is the averaging move of G72 (3) made exact rather than approximate — the invariance is exact here — and it is the field-level
form of FS-80's window-frequency LP at k = 3. Unverified beyond this sketch; the step "certificate on a finite configuration" needs
care (conic duality in infinite dimension).

## H2. Local reading of T40's pieces, as a route (the planner reached the ℚ-level half independently)

T40's `Θ_R = (5/2, 5/2) + (D0 ∪ F4) + 5ℤ²`: (5/2, 5/2) is the 2-adic parity character θ₂ (θ₂(x + iy) = {(x + y)/2}₂ on the 2-integral
ring ℤ[i][1/p : p ≡ 1 (4)], 1/2 on every rational unit vector), D0 the archimedean perturbations of it, F4 the order-3 characters of the
3-adic barrier (row 72). Route: classify `Θ₃(F)` as "a finite-place character local at 2 or at a 3-adic place, plus an archimedean part
of size ≤ 1/6", then show that at d ≡ 11 (mod 12) the layers' 2- and 3-adic denominators and the archimedean density of U(F) kill every
piece. **The planner's first note guesses the ℚ-level classification itself** (Θ₃(ℚ) = (θ₂ + D̄(1/6)) ∪ F4) and frames T41 as "the finite
shadow of a gluing problem across layers", so this is no longer mine to hold at the ℚ level; the field-level classification step and H1's
measure form are.

## H3. What I would tell stage C's agent (or a competition's advisor)

- The T41 family question is a two-parameter question about one fixed planar periodic set (Θ_R), with d entering only through the
  realised (α, β) — shared with the planner (record §0.5 item 3), so not held.
- Expect the N = 2 shape to be finite; the infinite families, if any, will come from choosing layers per d (the torus's layer group),
  not from one fixed shape.
- The d ≡ 3 (mod 8) half needs a different second layer (N = 5, 13, 29, …); the 2-adic parity piece is killed differently there (prime
  above 2 inert in F(i)/F).

## Status after the planner's T4 sketch (2026-09-24)

The planner independently turned H2's local reading into a proof sketch of T4 for every d ≡ 11 (mod 12) (C1(5) + the type-M relation
1 = n(2 − v − v̄)), which I attacked and could not break. H2 is therefore no longer a held route; it is the planner's argument. H1 (the
invariant-measure / radial Delsarte form) is not needed for T4 if the sketch holds; it remains a candidate route at four and five
colours (FS-80, FS-64), where no C1-type classification of layers is available. Nothing from HELD.md was sent to the planner.

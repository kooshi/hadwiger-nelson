import Mathlib.Combinatorics.SimpleGraph.Coloring.Vertex
import Mathlib.Algebra.BigOperators.Finprod
import Mathlib.Data.Real.Basic

/-!
# No affine identity survives a gapped target (FS-131 wave 1)

Row: **FS129-SA1-NOAFF-K** (carrying FS84-S1-S1e, FS129-OA1-NOLIN5, FS129-MA1-NOAFF5 and MA2's `k = 4` note; SA1 item 1).
Plan: `plans/FS131-kernel-plan.md` § 6. Its two-vertex case is row 66's `Slack.forces_iff_of_hom`.

A **gap** at a vertex `w` of `T` in a proper colouring `C'` is a colour absent from the closed neighbourhood `N_T[w]`.
Route (the row's `uses only:`): pull `C'` back along `ρ`, permute the palette, and repaint `u` alone with the permuted gap —
both are proper colourings of `G` differing only at `u`, so the identity forces `φ_u` to agree on every ordered pair of
distinct colours.
-/

namespace HadwigerNelson.Arith

open SimpleGraph

/-- **FS129-SA1-NOAFF-K**: let `k ≥ 2`, `ρ : G →g T`, and `φ_v : Fin k → ℝ` (all but finitely many identically zero) with
`Σ_v φ_v(C(v)) = b` for every proper `k`-colouring `C` of `G`. Then `φ_u` is constant at every `u` such that some proper
`k`-colouring of `T` leaves a colour absent from `N_T[ρ(u)]`; and if every vertex of `T` has such a colouring, every
`φ_v` is constant and `b` is the sum of their values. -/
theorem noAffine {V W : Type*} {G : SimpleGraph V} {T : SimpleGraph W} {k : ℕ} (hk : 2 ≤ k) (ρ : G →g T)
    (φ : V → Fin k → ℝ) (hφ : (Function.support φ).Finite) (b : ℝ)
    (hconst : ∀ C : G.Coloring (Fin k), ∑ᶠ v, φ v (C v) = b) :
    (∀ u, (∃ C' : T.Coloring (Fin k), ∃ γ : Fin k, ∀ x, (x = ρ u ∨ T.Adj (ρ u) x) → C' x ≠ γ) →
      ∀ i j, φ u i = φ u j) ∧
    ((∀ w, ∃ C' : T.Coloring (Fin k), ∃ γ : Fin k, ∀ x, (x = w ∨ T.Adj w x) → C' x ≠ γ) →
      (∀ v i j, φ v i = φ v j) ∧ b = ∑ᶠ v, φ v ⟨0, by omega⟩) := by
  sorry

end HadwigerNelson.Arith

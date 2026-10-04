import Proofs.HadwigerNelson.Plane.ValidMap.Basic

/-!
# Stuck chains: the curvature inequalities (FS110-N4-FIN, FS112-N2-RAY)

Wave 4's skeleton (`plans/FS131-w4-kernel-plan.md` § 3). Along a stuck chain `P_k = v + kn` the horn of `P_k` has lower and
upper upward curvatures `λ_k < υ_k` in `(−1, 1)`, and the shadows of the neighbouring horns give `λ_k ≤ f(λ_{k+1})` and
`f̃(υ_{k−1}) ≤ υ_k` (`curvDown`, `curvUp`). **FS110-N4-FIN**: no bi-infinite sequence satisfies them. **FS112-N2-RAY** (ruling
R9, its mathematics only): the one-sided chain `λ_k = −1/(k+1)`, `υ_k = 0` satisfies every inequality with every shadow tight,
so FIN's contradiction does not reach a chain with an end; its lower arcs are the pencil of circles of radius `k + 1` about
`P_{−1}`.
-/

namespace HadwigerNelson.Plane

open Complex Real Set

/-- **FS110-N4-FIN**: no bi-infinite sequence `−1 < λ_k < υ_k < 1` with `λ_k ≤ f(λ_{k+1})` and `f̃(υ_{k−1}) ≤ υ_k`. -/
theorem n4_fin : ¬ ∃ l u : ℤ → ℝ, ∀ k, -1 < l k ∧ l k < u k ∧ u k < 1 ∧ l k ≤ curvDown (l (k + 1)) ∧
    curvUp (u (k - 1)) ≤ u k := by
  sorry

/-- `f̃` inverts `f` on `(−1, ∞)` (FS110-N4-SHADOW's bookkeeping: the centre stays put, the radius changes by `1`). -/
theorem curvUp_curvDown {l : ℝ} (hl : -1 < l) : curvUp (curvDown l) = l := by
  sorry

/-- The one-sided chain of FS112-N2-RAY: `λ_k = −1/(k + 1)`. -/
noncomputable def rayLower (k : ℕ) : ℝ := -1 / ((k : ℝ) + 1)

/-- **FS112-N2-RAY**, the chain: `λ_0 = −1` (the end's horn bound), `−1 < λ_k < υ_k = 0 < 1` past the end, every lower
shadow tight (`λ_k = f(λ_{k+1})`) and every upper inequality met (`f̃(υ_{k−1}) ≤ υ_k`). -/
theorem ray_chain :
    rayLower 0 = -1 ∧ (∀ k, 1 ≤ k → -1 < rayLower k ∧ rayLower k < 0) ∧
      (∀ k, rayLower k = curvDown (rayLower (k + 1))) ∧ curvUp (0 : ℝ) = 0 := by
  sorry

/-- **FS112-N2-RAY**, FIN's argument stops at an end: a one-sided sequence satisfies FIN's inequalities wherever both indices
are in range, with `−1 < λ_k` past its end — so no contradiction follows without the bi-infinite hypothesis. -/
theorem exists_oneSided_chain : ∃ l u : ℕ → ℝ, (∀ k, -1 < l (k + 1)) ∧ (∀ k, l k < u k ∧ u k < 1) ∧
    (∀ k, l k ≤ curvDown (l (k + 1))) ∧ ∀ k, curvUp (u k) ≤ u (k + 1) := by
  sorry

/-- **FS112-N2-RAY**, the pencil: in the frame at `P_k = v + kn` (`n = e(α + π/2)`), the arc of upward curvature
`λ_k = −1/(k + 1)` tangent to `e α` is the circle of radius `k + 1` about `P_{−1} = v − n`. -/
theorem rayLower_pencil (v : ℂ) (α : ℝ) (k : ℕ) (z : ℂ) :
    tanHeight (rayLower k) (frameX (v + (k : ℂ) * e (α + π / 2)) α z)
        (frameY (v + (k : ℂ) * e (α + π / 2)) α z) = 0 ↔ dist z (v - e (α + π / 2)) = (k : ℝ) + 1 := by
  sorry

end HadwigerNelson.Plane

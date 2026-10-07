import OAI.Geometry.PlaneColoring.Five
/-! EXT-OAI1: the headline restated, each restatement checked by the kernel against the release's theorem.
Nothing here is the release's; every line is the audit's. -/

/-! ## 1. The challenge's own text, in a namespace of its own, closed by the solution's theorem -/
namespace AuditChallenge
-- copied character for character from ComparatorChallenges/EuclideanFiveColor.lean, lines 7–10
def ProperColoring (colorCount : ℕ) (coloring : ℂ → Fin colorCount) : Prop :=
  ∀ point otherPoint : ℂ, ‖point - otherPoint‖ = 1 → coloring point ≠ coloring otherPoint

theorem no_proper_five_coloring : ¬ ∃ coloring : ℂ → Fin 5, ProperColoring 5 coloring :=
  OAI.EuclideanFiveColor.no_proper_five_coloring
end AuditChallenge

/-- the two definitions are one term -/
example : @AuditChallenge.ProperColoring = @OAI.EuclideanFiveColor.ProperColoring := rfl

/-! ## 2. Unfolded: Mathlib's vocabulary only -/
theorem audit_unfolded : ¬ ∃ c : ℂ → Fin 5, ∀ x y : ℂ, ‖x - y‖ = 1 → c x ≠ c y :=
  OAI.EuclideanFiveColor.no_proper_five_coloring

/-- the norm in the statement is the Euclidean modulus -/
theorem audit_norm (z : ℂ) : ‖z‖ = Real.sqrt (z.re ^ 2 + z.im ^ 2) := by
  rw [Complex.norm_eq_sqrt_sq_add_sq]

/-- the hypothesis of `ProperColoring` is not vacuous: it constrains the pair `0, 1` -/
example (k : ℕ) (c : ℂ → Fin k) (h : OAI.EuclideanFiveColor.ProperColoring k c) : c 0 ≠ c 1 :=
  h 0 1 (by simp)

/-! ## 3. The positive form: every five-colouring has a monochromatic unit pair -/
theorem audit_mono (c : ℂ → Fin 5) : ∃ x y : ℂ, ‖x - y‖ = 1 ∧ c x = c y := by
  by_contra h
  exact audit_unfolded ⟨c, fun x y hxy hc => h ⟨x, y, hxy, hc⟩⟩

/-! ## 4. In real coordinates, with no norm, no `ℂ` and no square root in the statement -/
theorem audit_real (c : ℝ × ℝ → Fin 5) :
    ∃ p q : ℝ × ℝ, (p.1 - q.1) ^ 2 + (p.2 - q.2) ^ 2 = 1 ∧ c p = c q := by
  obtain ⟨x, y, hxy, hc⟩ := audit_mono (fun z => c (z.re, z.im))
  refine ⟨(x.re, x.im), (y.re, y.im), ?_, hc⟩
  have h2 : ‖x - y‖ ^ 2 = 1 := by rw [hxy]; norm_num
  rw [Complex.sq_norm, Complex.normSq_apply] at h2
  simp only [Complex.sub_re, Complex.sub_im] at h2
  nlinarith [h2]

/-! ## 5. In `EuclideanSpace ℝ (Fin 2)` with `dist`: the model of the release's own seven-colour theorem
(`OAI.Problem160.ProperColoring`) and of lean-dir's row 33 -/
theorem audit_euclidean :
    ¬ ∃ c : EuclideanSpace ℝ (Fin 2) → Fin 5, ∀ x y : EuclideanSpace ℝ (Fin 2), dist x y = 1 → c x ≠ c y := by
  rintro ⟨c, hc⟩
  let e := Complex.orthonormalBasisOneI.repr.toIsometryEquiv
  exact audit_unfolded ⟨fun z => c (e z), fun x y hxy => hc (e x) (e y) (by rw [e.dist_eq, dist_eq_norm, hxy])⟩

/-! ## 6. As a chromatic number: lean-dir's `unitDistance` (Proofs/HadwigerNelson/UnitDistance.lean:40), copied -/
def unitDistance (V : Type*) [MetricSpace V] : SimpleGraph V where
  Adj x y := dist x y = 1
  symm := ⟨fun _ _ h => by rwa [dist_comm]⟩
  loopless := ⟨fun x h => by rw [dist_self] at h; exact zero_ne_one h⟩

theorem audit_not_colorable : ¬ (unitDistance (EuclideanSpace ℝ (Fin 2))).Colorable 5 := by
  rintro ⟨C⟩
  exact audit_euclidean ⟨C, fun x y hxy => C.valid hxy⟩

theorem audit_chromaticNumber : 6 ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber := by
  have h : ((5 + 1 : ℕ) : ℕ∞) ≤ (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber := by
    rw [Nat.cast_add, Nat.cast_one, ENat.add_one_le_iff (ENat.natCast_ne_top 5), ← not_le,
      SimpleGraph.chromaticNumber_le_iff_colorable]
    exact audit_not_colorable
  exact_mod_cast h

#print axioms AuditChallenge.no_proper_five_coloring
#print axioms audit_unfolded
#print axioms audit_real
#print axioms audit_euclidean
#print axioms audit_chromaticNumber

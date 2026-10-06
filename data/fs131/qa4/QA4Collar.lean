/-
FS131-QA4 scratch (read-only against `fs131-w5k`'s oleans at `3b120cd3`; run with `lake env lean` from that tree, nothing built).
The known case `bend_toward_collar` (brief, Done means 4), hypothesis by hypothesis.
`hout`'s proof is copied from `collarModel`'s body (`BendCollar.lean` l. 635–651); everything else is by name.
-/
import Proofs.HadwigerNelson.Plane.ValidMap.BendCollar

open Complex Real Set Filter Topology Metric

namespace HadwigerNelson.Plane.ArcMap

/-- **QA4-C1**: every hypothesis of `bend_toward_collar` but `hmax` holds at once on `l60Frag`'s sub-arc `r([π/8, 5π/24])`
(`hF`, `hA`, `hout`, `hlen`, `hfree`; `hε` is a parameter). -/
theorem qa4_collar_hyps :
    l60Frag.Valid ∧ l60Frag.IsRingArc 0 (π / 8) (5 * π / 24) 0 1 ∧ (1 : Fin 4) ∉ l60Frag.coloursAt 0 ∧
      (5 * π / 24 - π / 8 < 2 * π) ∧
      (∀ θ ∈ Ioo (π / 8) (5 * π / 24), ∃ r > 0, l60Frag.Γ ∩ ball (ringPt 0 θ) r ⊆ sphere 0 1) := by
  have hπ := Real.pi_pos
  obtain ⟨R', R, R'', hfit⟩ := collarModel (ε := 1) one_pos
  have hout : (1 : Fin 4) ∉ l60Frag.coloursAt 0 := by
    intro h
    have hreg : l60Frag.region 1 ⊆ closedBall (1 + e (π / 3)) 1 := by
      rintro x ⟨hx, hc⟩
      have hc' : l60Frag.col x = 1 := hc
      rcases l60_interior_cases hx with h0 | h1 | h2 | h3
      · rw [hc'] at h0; exact absurd h0.1 (by decide)
      · exact ball_subset_closedBall h1.2.2
      · rw [hc'] at h2; exact absurd h2.1 (by decide)
      · rw [hc'] at h3; exact absurd h3.1 (by decide)
    have h0 : (0 : ℂ) ∈ closedBall (1 + e (π / 3)) 1 := closure_minimal hreg isClosed_closedBall h
    rw [mem_closedBall, dist_eq_norm, zero_sub, norm_neg] at h0
    have h3 : ‖(1 : ℂ) + e (π / 3)‖ ^ 2 = 3 := by
      rw [sq_norm_eq_re_im]
      simp only [Complex.add_re, Complex.one_re, re_e, Complex.add_im, Complex.one_im, im_e, Real.cos_pi_div_three,
        Real.sin_pi_div_three]
      nlinarith [Real.sq_sqrt (show (0 : ℝ) ≤ 3 by norm_num)]
    nlinarith [norm_nonneg ((1 : ℂ) + e (π / 3))]
  exact ⟨l60Frag_valid, hfit.ring, hout, by linarith, hfit.free_open⟩

/-- **QA4-C2**: `hmax` fails on that sub-arc — the whole arc `r([0, π/3])` is a ring arc with the same sides and a larger carrier. -/
theorem qa4_collar_not_hmax :
    ¬ (∀ θ₁' θ₂', ringArc (0 : ℂ) (π / 8) (5 * π / 24) ⊆ ringArc 0 θ₁' θ₂' → l60Frag.IsRingArc 0 θ₁' θ₂' 0 1 →
      ringArc (0 : ℂ) θ₁' θ₂' = ringArc 0 (π / 8) (5 * π / 24)) := by
  intro h
  have hπ := Real.pi_pos
  have hsub : ringArc (0 : ℂ) (π / 8) (5 * π / 24) ⊆ ringArc 0 0 (π / 3) :=
    image_mono (Icc_subset_Icc (by linarith) (by linarith))
  have heq := h 0 (π / 3) hsub l60Frag_isRingArc
  have h0 : ringPt (0 : ℂ) 0 ∈ ringArc (0 : ℂ) 0 (π / 3) := ⟨0, ⟨le_rfl, by linarith⟩, rfl⟩
  rw [heq] at h0
  obtain ⟨θ, hθ, hθ0⟩ := h0
  have hre := congrArg Complex.re hθ0
  simp only [ringPt, zero_add, re_e, Real.cos_zero] at hre
  have := (Real.cos_eq_one_iff_of_lt_of_lt (by linarith [hθ.1]) (by linarith [hθ.2])).mp hre
  linarith [hθ.1]

/-- **QA4-C3**: `bend_toward_collar`'s conclusion without `hlen` and `hmax` (its own proof with the two idle `have`s removed): the
kernel confirms neither is read. -/
theorem qa4_bend_toward_collar_weak {k : ℕ} {F : ArcMap k} (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k}
    (hA : F.IsRingArc P θ₁ θ₂ c c') (hout : c' ∉ F.coloursAt P)
    (hfree : ∀ θ ∈ Ioo θ₁ θ₂, ∃ r > 0, F.Γ ∩ ball (ringPt P θ) r ⊆ sphere P 1) {ε : ℝ} (hε : 0 < ε) :
    ∃ (M : ArcMap k) (h : ℂ ≃ₜ ℂ), M.Valid ∧ M.dom = F.dom ∧
      (∀ z ∉ thickening ε (ringArc P θ₁ θ₂), h z = z) ∧
      (∀ z ∈ F.Γ, z ∉ ringPt P '' Ioo θ₁ θ₂ → h z = z) ∧
      (∀ z, (h z ∈ M.interiorPts ↔ z ∈ F.interiorPts) ∧ (z ∈ F.interiorPts → M.col (h z) = F.col z)) ∧
      (∀ z, M.coloursAt (h z) = F.coloursAt z) ∧
      (∀ z n, M.HasDegree (h z) n ↔ F.HasDegree z n) ∧
      (∀ z, M.HasRepeatedColour (h z) ↔ F.HasRepeatedColour z) ∧
      (∀ Q a b d d', M.IsRingArc Q a b d d' → F.IsRingArc Q a b d d') ∧
      (∀ Q a b d d', F.IsRingArc Q a b d d' → Disjoint (ringPt Q '' Ioo a b) (ringPt P '' Ioo θ₁ θ₂) →
        M.IsRingArc Q a b d d') ∧
      (∀ θ ∈ Ioo θ₁ θ₂, ¬ M.OnRingArc P (ringPt P θ)) ∧
      (∀ Q a b, M.Inert Q a b → F.Inert Q a b) := by
  obtain ⟨R', R, R'', hfit⟩ := exists_collarFit hF hA hout hfree hε
  exact ⟨hfit.map, hfit.homeo, hfit.map_valid hF, rfl, fun z hz => (hfit.homeo_eq_self fun hK => hz (hfit.sub_thick hK)).1,
    fun z hz hzO => hfit.homeo_fix_Γ hz hzO, fun z => ⟨pushforward_mem_interiorPts_iff z, fun _ => pushforward_col_apply z⟩,
    fun z => pushforward_coloursAt z, fun z n => hfit.map_hasDegree hF z n, fun z => hfit.map_hasRepeatedColour hF z,
    fun Q a b d d' h => hfit.map_R1 hF h, fun Q a b d d' h hd => hfit.map_R2 hF h hd, fun θ hθ => hfit.map_R3 hθ,
    fun Q a b h => hfit.map_inert hF h⟩

/-- **QA4-C4**: the weakened theorem at the model — its conclusion on `l60Frag`'s sub-arc, from QA4-C1's hypotheses alone. -/
example : ∃ (M : ArcMap 4) (h : ℂ ≃ₜ ℂ), M.Valid ∧ M.dom = l60Frag.dom ∧
    (∀ θ ∈ Ioo (π / 8) (5 * π / 24), ¬ M.OnRingArc 0 (ringPt 0 θ)) := by
  obtain ⟨hF, hA, hout, -, hfree⟩ := qa4_collar_hyps
  obtain ⟨M, φ, hv, hd, -, -, -, -, -, -, -, -, h3, -⟩ := qa4_bend_toward_collar_weak hF hA hout hfree one_pos
  exact ⟨M, φ, hv, hd, h3⟩

end HadwigerNelson.Plane.ArcMap

#print axioms HadwigerNelson.Plane.ArcMap.qa4_collar_hyps
#print axioms HadwigerNelson.Plane.ArcMap.qa4_collar_not_hmax
#print axioms HadwigerNelson.Plane.ArcMap.qa4_bend_toward_collar_weak

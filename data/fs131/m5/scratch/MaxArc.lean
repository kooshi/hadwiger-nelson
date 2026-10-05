import Proofs.HadwigerNelson.Plane.ValidMap.BaseWalk
import Proofs.HadwigerNelson.Plane.ValidMap.BendCollar

open Set Metric Complex Real

namespace HadwigerNelson.Plane

/-- A closed arc of a circle inside a shorter-than-a-turn arc of it lies there in one lift: shifting the outer arc's ends by a
multiple of `2π` makes the parameter intervals nested. -/
theorem exists_shift_of_ringArc_subset {P : ℂ} {a b s t : ℝ} (hab : a ≤ b) (hlen : t - s < 2 * π)
    (h : ringArc P a b ⊆ ringArc P s t) : ∃ n : ℤ, s + 2 * π * n ≤ a ∧ b ≤ t + 2 * π * n := by
  have hπ := Real.pi_pos
  have lift : ∀ φ ∈ Icc a b, ∃ m : ℤ, φ + 2 * π * m ∈ Icc s t := by
    intro φ hφ
    obtain ⟨ψ, hψ, he⟩ := h ⟨φ, hφ, rfl⟩
    have he' : e ψ = e φ := by simpa [ringPt] using he
    obtain ⟨m, hm⟩ := e_eq_e_iff.mp he'
    exact ⟨m, by rw [show φ + 2 * π * m = ψ by rw [hm]; ring]; exact hψ⟩
  obtain ⟨m, hm⟩ := lift a ⟨le_rfl, hab⟩
  refine ⟨-m, by push_cast; linarith [hm.1], ?_⟩
  by_contra hb
  push Not at hb
  push_cast at hb
  set δ := (2 * π - (t - s)) / 2 with hδ
  have hδ0 : 0 < δ := by rw [hδ]; linarith
  set φ := min b (t - 2 * π * m + δ) with hφ
  have hφ1 : t - 2 * π * m < φ := lt_min (by linarith) (by linarith)
  have hφ2 : φ ≤ t - 2 * π * m + δ := min_le_right _ _
  have hφa : a ≤ φ := by linarith [hm.2]
  obtain ⟨m', hm'⟩ := lift φ ⟨hφa, min_le_left _ _⟩
  -- `φ + 2π m' ∈ [s, t]` and `φ + 2π m ∈ (t, t + δ]`
  have h1 : t < φ + 2 * π * m := by linarith
  have h2 : φ + 2 * π * m ≤ t + δ := by linarith
  have hlt : (m' : ℝ) < m := by
    by_contra hge; push Not at hge
    have := mul_le_mul_of_nonneg_left hge (by linarith : (0 : ℝ) ≤ 2 * π)
    linarith [hm'.2]
  have hle : (m' : ℝ) ≤ m - 1 := by
    have : m' ≤ m - 1 := by exact_mod_cast (show m' < m by exact_mod_cast hlt) |> Int.le_sub_one_of_lt
    exact_mod_cast this
  have := mul_le_mul_of_nonneg_left hle (by linarith : (0 : ℝ) ≤ 2 * π)
  linarith [hm'.1]

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- A ring arc read in another lift: shifting both ends by a multiple of `2π` keeps it. -/
theorem IsRingArc.shift {P : ℂ} {s t : ℝ} {c c' : Fin k} (hA : F.IsRingArc P s t c c') (n : ℤ) :
    F.IsRingArc P (s + 2 * π * n) (t + 2 * π * n) c c' := by
  refine ⟨by linarith [hA.1], by rw [ringArc_add_two_pi_mul]; exact hA.2.1, fun θ hθ => ?_⟩
  have h := hA.2.2 (θ - 2 * π * n) ⟨by linarith [hθ.1], by linarith [hθ.2]⟩
  have hr : ringPt P (θ - 2 * π * n) = ringPt P θ := by
    rw [show θ - 2 * π * n = θ + 2 * π * ((-n : ℤ) : ℝ) by push_cast; ring, ringPt_add_int_mul]
  rwa [hr] at h

theorem exists_maxRingArc' (hF : F.Valid) {u P : ℂ} (hu : F.Covers u 2) (hP : P ∈ closedBall u 1) {θ₁ θ₂ : ℝ} {c c' : Fin k}
    (hA : F.IsRingArc P θ₁ θ₂ c c') :
    ∃ a b, ringArc P θ₁ θ₂ ⊆ ringArc P a b ∧ F.IsRingArc P a b c c' ∧
      ∀ θ₁' θ₂', ringArc P a b ⊆ ringArc P θ₁' θ₂' → F.IsRingArc P θ₁' θ₂' c c' → ringArc P θ₁' θ₂' = ringArc P a b := by
  have hπ := Real.pi_pos
  have h12 := hA.1
  -- the lifts of ring arcs with these sides containing `[θ₁, θ₂]`: their left and right ends
  set L : Set ℝ := {s | ∃ t, F.IsRingArc P s t c c' ∧ s ≤ θ₁ ∧ θ₂ ≤ t} with hL
  set R : Set ℝ := {t | ∃ s, F.IsRingArc P s t c c' ∧ s ≤ θ₁ ∧ θ₂ ≤ t} with hR
  have hLne : L.Nonempty := ⟨θ₁, θ₂, hA, le_rfl, le_rfl⟩
  have hRne : R.Nonempty := ⟨θ₂, θ₁, hA, le_rfl, le_rfl⟩
  have hLbdd : BddBelow L := ⟨θ₂ - π / 3, fun s ⟨t, hst, _, ht⟩ => by have := l60_le hF hst; linarith⟩
  have hRbdd : BddAbove R := ⟨θ₁ + π / 3, fun t ⟨s, hst, hs, _⟩ => by have := l60_le hF hst; linarith⟩
  set a := sInf L with ha
  set b := sSup R with hb
  have haθ : a ≤ θ₁ := csInf_le hLbdd ⟨θ₂, hA, le_rfl, le_rfl⟩
  have hbθ : θ₂ ≤ b := le_csSup hRbdd ⟨θ₁, hA, le_rfl, le_rfl⟩
  have hab : a < b := by linarith
  -- every interior parameter lies inside one member
  have hin : ∀ φ ∈ Ioo a b, ∃ s t, F.IsRingArc P s t c c' ∧ φ ∈ Ioo s t := by
    intro φ hφ
    by_cases h1 : φ ≤ θ₁
    · obtain ⟨s, ⟨t, hst, hs, ht⟩, hsφ⟩ := exists_lt_of_csInf_lt hLne hφ.1
      exact ⟨s, t, hst, hsφ, by linarith⟩
    by_cases h2 : θ₂ ≤ φ
    · obtain ⟨t, ⟨s, hst, hs, ht⟩, htφ⟩ := exists_lt_of_lt_csSup hRne hφ.2
      exact ⟨s, t, hst, by linarith, htφ⟩
    push Not at h1 h2
    exact ⟨θ₁, θ₂, hA, h1, h2⟩
  have hdom : ringArc P a b ⊆ F.dom := by
    rintro _ ⟨φ, -, rfl⟩
    apply hu
    rw [mem_closedBall] at hP ⊢
    have : dist (ringPt P φ) P = 1 := by simp [ringPt, dist_eq_norm, norm_e]
    linarith [dist_triangle (ringPt P φ) P u]
  have hAab : F.IsRingArc P a b c c' := by
    refine ⟨hab, ringArc_subset_Γ_of_finite hab hdom (toFinite {ringPt P a, ringPt P b}) ?_, fun φ hφ => ?_⟩
    · rintro _ ⟨⟨φ, hφ, rfl⟩, hne⟩
      have hφ' : φ ∈ Ioo a b := ⟨lt_of_le_of_ne hφ.1 (fun h => hne (by rw [← h]; exact mem_insert _ _)),
        lt_of_le_of_ne hφ.2 (fun h => hne (by rw [h]; exact mem_insert_of_mem _ (mem_singleton _)))⟩
      obtain ⟨s, t, hst, hφst⟩ := hin φ hφ'
      exact hst.2.1 ⟨φ, Ioo_subset_Icc_self hφst, rfl⟩
    · obtain ⟨s, t, hst, hφst⟩ := hin φ hφ
      exact hst.2.2 φ hφst
  refine ⟨a, b, ?_, hAab, fun θ₁' θ₂' hsub hA' => ?_⟩
  · rintro _ ⟨φ, hφ, rfl⟩
    exact ⟨φ, ⟨by linarith [hφ.1], by linarith [hφ.2]⟩, rfl⟩
  · have hl' := l60_le hF hA'
    obtain ⟨n, hn1, hn2⟩ := exists_shift_of_ringArc_subset hab.le (by linarith) hsub
    have hsh := hA'.shift n
    have hmemL : θ₁' + 2 * π * n ∈ L := ⟨θ₂' + 2 * π * n, hsh, by linarith, by linarith⟩
    have hmemR : θ₂' + 2 * π * n ∈ R := ⟨θ₁' + 2 * π * n, hsh, by linarith, by linarith⟩
    have e1 : θ₁' + 2 * π * n = a := le_antisymm hn1 (csInf_le hLbdd hmemL)
    have e2 : θ₂' + 2 * π * n = b := le_antisymm (le_csSup hRbdd hmemR) hn2
    rw [← ringArc_add_two_pi_mul P θ₁' θ₂' n, e1, e2]

end ArcMap

end HadwigerNelson.Plane

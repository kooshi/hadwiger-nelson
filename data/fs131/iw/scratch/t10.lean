import Proofs.HadwigerNelson.Plane.Woodall.NoFourFive
namespace HadwigerNelson.Plane
open Complex Real Set Filter Topology Metric

/-- The widths of the sectors telescope. -/
theorem sum_width_aux : ∀ (n : ℕ) (d : Fin (n + 1) → ℝ), ∑ i : Fin n, (d i.succ - d i.castSucc) = d (Fin.last n) - d 0
  | 0, d => by simp
  | n + 1, d => by
    rw [Fin.sum_univ_castSucc]
    have ih := sum_width_aux n (fun i => d i.castSucc)
    simp only [Fin.succ_castSucc] at ih ⊢
    rw [ih]
    simp [Fin.castSucc_zero]

/-- The widths of the sectors of a picture sum to `2π`. -/
theorem sum_width {n : ℕ} {d : Fin (n + 1) → ℝ} (hlast : d (Fin.last n) = d 0 + 2 * π) :
    ∑ i : Fin n, (d i.succ - d i.castSucc) = 2 * π := by
  rw [sum_width_aux, hlast]; ring

/-- With `n ≥ 3` positive widths summing to `2π`, at most one sector has width `π`. -/
theorem width_eq_pi_unique {n : ℕ} {d : Fin (n + 1) → ℝ} (hlast : d (Fin.last n) = d 0 + 2 * π) (hn : 3 ≤ n)
    (hpos : ∀ j : Fin n, 0 < d j.succ - d j.castSucc) {i j : Fin n} (hi : d i.succ - d i.castSucc = π)
    (hj : d j.succ - d j.castSucc = π) : i = j := by
  by_contra hij
  have hcard : ({i, j} : Finset (Fin n)).card < (Finset.univ : Finset (Fin n)).card := by
    rw [Finset.card_univ, Fintype.card_fin]
    exact lt_of_le_of_lt (Finset.card_le_two) (by omega)
  obtain ⟨k, -, hk⟩ := Finset.exists_mem_notMem_of_card_lt_card hcard
  have hk' : k ≠ i ∧ k ≠ j := by simpa using hk
  have hsub : ({i, j, k} : Finset (Fin n)) ⊆ Finset.univ := Finset.subset_univ _
  have hsum := Finset.sum_le_sum_of_subset_of_nonneg hsub (f := fun l : Fin n => d l.succ - d l.castSucc) (fun l _ _ => (hpos l).le)
  rw [Finset.sum_insert (by simp [hij, hk'.1.symm]), Finset.sum_insert (by simp [hk'.2.symm]), Finset.sum_singleton, hi, hj,
    sum_width hlast] at hsum
  have := hpos k
  linarith


namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

theorem SectorsAt.exists_two_absent' (hF : F.Valid) (hP : F.IsPlaneMap) {v : ℂ} {n : ℕ} {d : Fin (n + 1) → ℝ} {c : Fin n → Fin k}
    (h : F.SectorsAt v n d c) (hn : 3 ≤ n) (hc : Function.Injective c) (hpos : ∀ i : Fin n, 0 < d i.succ - d i.castSucc)
    (hπ : ∀ i : Fin n, d i.succ - d i.castSucc ≤ π) :
    ∃ K : Finset ℝ, K.card ≤ n ∧ ∀ ψ : ℝ, (∀ κ ∈ K, ∀ m : ℤ, ψ ≠ κ + 2 * π * m) →
      ∃ i j : Fin n, c i ≠ c j ∧ c i ∉ F.coloursAt (v + e ψ) ∧ c j ∉ F.coloursAt (v + e ψ) := by
  classical
  have hn2 : 2 ≤ n := by omega
  have hlast := h.2.2.1
  have hpi := Real.pi_pos
  choose σ hσ hcol using fun i : Fin n => SectorsAt.exists_normal_collarAt hP h hn2 hpos i
  -- the cut angles
  let g : Fin n → ℝ := fun i =>
    if d i.succ - d i.castSucc = π then d i.castSucc + π / 2
    else if d ((finRotate n).symm i).succ - d ((finRotate n).symm i).castSucc = π then d ((finRotate n).symm i).castSucc - π / 2
    else d i.castSucc - σ i * (π / 2)
  refine ⟨Finset.univ.image g, Finset.card_image_le.trans (by simp), fun ψ hoff => ?_⟩
  have hoff' : ∀ i : Fin n, ∀ m : ℤ, ψ ≠ g i + 2 * π * m := fun i m => hoff (g i) (Finset.mem_image_of_mem g (Finset.mem_univ i)) m
  -- both normals of both edges of a `π`-sector are cut angles
  have hnormals : ∀ i : Fin n, d i.succ - d i.castSucc = π → ∀ m : ℤ, ψ ≠ d i.castSucc + π / 2 + 2 * π * m ∧
      ψ ≠ d i.castSucc - π / 2 + 2 * π * m := by
    intro i hi m
    refine ⟨?_, ?_⟩
    · have hgi := hoff' i m
      simp only [g, if_pos hi] at hgi
      exact hgi
    · have hne : finRotate n i ≠ i := by
        obtain ⟨m', rfl⟩ : ∃ m', n = m' + 1 := ⟨n - 1, by omega⟩
        intro hh
        rw [finRotate_apply] at hh
        have : (1 : Fin (m' + 1)) = 0 := by simpa using hh
        rw [Fin.one_eq_zero_iff] at this
        omega
      have hprev : (finRotate n).symm (finRotate n i) = i := (finRotate n).symm_apply_apply i
      generalize hj' : finRotate n i = j at hne hprev
      have hj : d j.succ - d j.castSucc ≠ π := fun hj => hne (width_eq_pi_unique hlast hn hpos hj hi)
      have hgj := hoff' j m
      simp only [g, if_neg hj, hprev, if_pos hi] at hgj
      exact hgj
  -- every branch direction `ψ ± π/2` of `ω(v + e ψ)` at `v` kills a colour of a sector holding it
  have hkill : ∀ D : ℝ, (D = ψ + π / 2 ∨ D = ψ - π / 2) → ∃ i : Fin n,
      (∃ m : ℤ, D + 2 * π * m ∈ Icc (d i.castSucc) (d i.succ)) ∧ c i ∉ F.coloursAt (v + e ψ) := by
    intro D hD
    obtain ⟨i, m, hm⟩ := h.exists_mem_Ico D
    rcases hm.1.eq_or_lt with hedge | hint
    · -- `D` is the start of sector `i`: `ψ` is a normal of the edge
      obtain ⟨s, hs, hψ⟩ : ∃ s : ℝ, (s = 1 ∨ s = -1) ∧ ψ = d i.castSucc + s * (π / 2) + 2 * π * ((-m : ℤ) : ℝ) := by
        rcases hD with hD | hD
        · exact ⟨-1, Or.inr rfl, by push_cast; linarith⟩
        · exact ⟨1, Or.inl rfl, by push_cast; linarith⟩
      by_cases hw : d i.succ - d i.castSucc = π
      · exfalso
        obtain ⟨h1, h2⟩ := hnormals i hw (-m)
        rcases hs with rfl | rfl
        · exact h1 (by rw [hψ]; ring)
        · exact h2 (by rw [hψ]; ring)
      by_cases hw' : d ((finRotate n).symm i).succ - d ((finRotate n).symm i).castSucc = π
      · exfalso
        obtain ⟨ε, hε, hdε⟩ : ∃ ε : ℤ, (ε = 0 ∨ ε = 1) ∧ d ((finRotate n).symm i).succ = d i.castSucc + 2 * π * ε := by
          rcases d_prev_succ hlast i with ⟨h1, -⟩ | ⟨h1, -⟩
          · exact ⟨0, Or.inl rfl, by rw [h1]; simp⟩
          · exact ⟨1, Or.inr rfl, by rw [h1]; simp⟩
        obtain ⟨h1a, -⟩ := hnormals _ hw' (-m - ε)
        obtain ⟨-, h2b⟩ := hnormals _ hw' (1 - m - ε)
        have hb : d ((finRotate n).symm i).castSucc = d i.castSucc + 2 * π * ε - π := by linarith
        rcases hs with rfl | rfl
        · exact h2b (by rw [hψ, hb]; push_cast; ring)
        · exact h1a (by rw [hψ, hb]; push_cast; ring)
      · -- the generic edge: the uncertified normal is a cut angle, so `ψ` is the certified one
        have hσs : σ i = s := by
          by_contra hne
          have hσ' : σ i = -s := by rcases hσ i with h1 | h1 <;> rcases hs with h2 | h2 <;> [exact absurd (h1.trans h2.symm) hne; linarith; linarith; exact absurd (h1.trans h2.symm) hne]
          have := hoff' i (-m)
          simp only [g, if_neg hw, if_neg hw'] at this
          exact this (by rw [hψ, hσ']; ring)
        have habs := SectorsAt.absent_at_normal hF h hn2 hpos i (hσ i) (hcol i)
        have hψe : v + e ψ = v + e (d i.castSucc + σ i * (π / 2)) := by
          rw [hψ, ← hσs, e_add_int_mul_two_pi]
        rw [hψe]
        rcases habs with hprev | hcur
        · obtain ⟨ε, hdε, hmε⟩ : ∃ ε : ℤ, d ((finRotate n).symm i).succ = d i.castSucc + 2 * π * ε ∧ (ε = 0 ∨ ε = 1) := by
            rcases d_prev_succ hlast i with ⟨h1, -⟩ | ⟨h1, -⟩
            · exact ⟨0, by rw [h1]; simp, Or.inl rfl⟩
            · exact ⟨1, by rw [h1]; simp, Or.inr rfl⟩
          refine ⟨(finRotate n).symm i, ⟨m + ε, ?_, ?_⟩, hprev⟩
          · have := hpos ((finRotate n).symm i)
            push_cast; linarith
          · push_cast; linarith
        · exact ⟨i, ⟨m, by rw [← hedge], by rw [← hedge]; linarith [hpos i]⟩, hcur⟩
    · exact ⟨i, ⟨m, hm.1, hm.2.le⟩, SectorsAt.not_mem_coloursAt_of_mem_Ioo hF h i hD ⟨hint, hm.2⟩⟩
  obtain ⟨i₁, ⟨m₁, h₁⟩, hk₁⟩ := hkill (ψ + π / 2) (Or.inl rfl)
  obtain ⟨i₂, ⟨m₂, h₂⟩, hk₂⟩ := hkill (ψ - π / 2) (Or.inr rfl)
  have hne : i₁ ≠ i₂ := by
    rintro rfl
    have hw := hπ i₁
    have ht1 : (-1 : ℝ) ≤ ((m₁ - m₂ : ℤ) : ℝ) := by push_cast; nlinarith [h₁.1, h₁.2, h₂.1, h₂.2]
    have ht2 : ((m₁ - m₂ : ℤ) : ℝ) ≤ 0 := by push_cast; nlinarith [h₁.1, h₁.2, h₂.1, h₂.2]
    have ht1' : -1 ≤ m₁ - m₂ := by exact_mod_cast ht1
    have ht2' : m₁ - m₂ ≤ 0 := by exact_mod_cast ht2
    have hcase : m₁ - m₂ = 0 ∨ m₁ - m₂ = -1 := by omega
    obtain ⟨hwπ, hx⟩ : d i₁.succ - d i₁.castSucc = π ∧ (ψ - π / 2 + 2 * π * m₂ = d i₁.castSucc ∨
        ψ - π / 2 + 2 * π * m₂ = d i₁.castSucc + π) := by
      rcases hcase with hc0 | hc1
      · have : (m₁ : ℝ) = m₂ := by exact_mod_cast (by omega : m₁ = m₂)
        rw [this] at h₁
        refine ⟨by nlinarith [h₁.1, h₁.2, h₂.1, h₂.2], Or.inl ?_⟩
        nlinarith [h₁.1, h₁.2, h₂.1, h₂.2]
      · have : (m₁ : ℝ) = m₂ - 1 := by exact_mod_cast (by omega : m₁ = m₂ - 1)
        rw [this] at h₁
        refine ⟨by nlinarith [h₁.1, h₁.2, h₂.1, h₂.2], Or.inr ?_⟩
        nlinarith [h₁.1, h₁.2, h₂.1, h₂.2]
    rcases hx with hx | hx
    · exact (hnormals i₁ hwπ (-m₂)).1 (by push_cast; linarith)
    · exact (hnormals i₁ hwπ (1 - m₂)).2 (by push_cast; linarith)
  exact ⟨i₁, i₂, fun heq => hne (hc heq), hk₁, hk₂⟩

end ArcMap

end HadwigerNelson.Plane

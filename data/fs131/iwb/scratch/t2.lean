import Proofs.HadwigerNelson.Plane.Woodall.Steps

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

theorem collarAt_iInter' {ι : Type*} (T : Finset ι) (S : ι → Set ℂ) {u : ℂ} {s : Rim} {θ : ℝ}
    (h : ∀ i ∈ T, CollarAt (S i) u s θ) : CollarAt {z | ∀ i ∈ T, z ∈ S i} u s θ := by
  classical
  induction T using Finset.induction_on with
  | empty => exact ⟨1, one_pos, fun z _ i hi => absurd hi (Finset.notMem_empty i)⟩
  | insert a T ha ih =>
    have h1 := h a (Finset.mem_insert_self a T)
    have h2 := ih (fun i hi => h i (Finset.mem_insert_of_mem hi))
    refine (h1.inter h2).mono ?_
    rintro z ⟨hz1, hz2⟩ i hi
    rcases Finset.mem_insert.mp hi with rfl | hi
    · exact hz1
    · exact hz2 i hi

theorem CollarAt.of_near' {S : Set ℂ} {u : ℂ} {s : Rim} {y h : ℝ} (hh : 0 < h) (hsub : collar u s (y - h) (y + h) h ⊆ S)
    {y' : ℝ} (hy : |y' - y| < h / 2) : CollarAt S u s y' := by
  obtain ⟨h1, h2⟩ := abs_lt.mp hy
  exact ⟨h / 2, by linarith, (collar_subset_collar u s (by linarith) (by linarith) (by linarith)).trans hsub⟩

theorem false_of_cos_eq_zero_Icc' {a b θ : ℝ} (hab : a < b) (h : ∀ γ ∈ Icc a b, Real.cos (γ - θ) = 0) : False := by
  set t := min (b - a) 1 with ht
  have ht0 : 0 < t := lt_min (by linarith) one_pos
  have htb : a + t ≤ b := by linarith [min_le_left (b - a) 1]
  have htπ : t < π := by linarith [min_le_right (b - a) 1, Real.two_le_pi]
  have h1 := h a ⟨le_rfl, hab.le⟩
  have h2 := h (a + t) ⟨by linarith, htb⟩
  rw [show a + t - θ = (a - θ) + t by ring, Real.cos_add, h1, zero_mul, zero_sub, neg_eq_zero] at h2
  have hs : Real.sin (a - θ) ^ 2 = 1 := by have := Real.sin_sq_add_cos_sq (a - θ); rw [h1] at this; linarith
  have hst : Real.sin t = 0 := by
    rcases mul_eq_zero.mp h2 with h3 | h3
    · rw [h3] at hs; norm_num at hs
    · exact h3
  exact absurd hst (Real.sin_pos_of_pos_of_lt_pi ht0 htπ).ne'

theorem exists_of_cos_eq_zero' {e θ : ℝ} (h : Real.cos (e - θ) = 0) :
    ∃ σ : ℝ, (σ = 1 ∨ σ = -1) ∧ ∃ m : ℤ, θ = e + σ * (π / 2) + 2 * π * m := by
  obtain ⟨n, hn⟩ := Real.cos_eq_zero_iff.mp h
  obtain ⟨m, rfl | rfl⟩ := Int.even_or_odd' n
  · exact ⟨-1, Or.inr rfl, -m, by push_cast at hn ⊢; linear_combination -hn⟩
  · exact ⟨1, Or.inl rfl, -m - 1, by push_cast at hn ⊢; linear_combination -hn⟩

theorem cos_neg_of_mem' {x : ℝ} (h1 : π / 2 < x) (h2 : x < 3 * π / 2) : Real.cos x < 0 :=
  Real.cos_neg_of_pi_div_two_lt_of_lt h1 (by linarith)

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

theorem Valid.region_dist_ne_one' (hF : F.Valid) (j : Fin k) : ∀ x ∈ F.region j, ∀ y ∈ F.region j, dist x y ≠ 1 :=
  fun x hx y hy hd => hF x hx.1 y hy.1 hd ((show F.col x = j from hx.2).trans (show F.col y = j from hy.2).symm)

theorem exists_two_cover' (hk : k ≤ 5) {T : Finset (Fin k)} (hT : 3 ≤ T.card) :
    ∃ X Y : Fin k, ∀ c ∉ T, c = X ∨ c = Y := by
  classical
  obtain ⟨x₀, -⟩ := Finset.card_pos.mp (by omega : 0 < T.card)
  have hc : Tᶜ.card ≤ 2 := by rw [Finset.card_compl, Fintype.card_fin]; omega
  interval_cases h : Tᶜ.card
  · exact ⟨x₀, x₀, fun c hc' => absurd (Finset.mem_compl.mpr hc') (by rw [Finset.card_eq_zero.mp h]; simp)⟩
  · obtain ⟨a, ha⟩ := Finset.card_eq_one.mp h
    exact ⟨a, a, fun c hc' => Or.inl (by simpa [ha] using Finset.mem_compl.mpr hc')⟩
  · obtain ⟨a, b, -, hab⟩ := Finset.card_eq_two.mp h
    exact ⟨a, b, fun c hc' => by simpa [hab] using Finset.mem_compl.mpr hc'⟩

theorem collarAt_closure_of_forall_shadow' (hF : F.Valid) (hP : F.IsPlaneMap) {T : Finset (Fin k)} {X Y : Fin k}
    (hXY : ∀ c ∉ T, c = X ∨ c = Y) {v : ℂ} {s : Rim} {θ : ℝ}
    (hT : ∀ c ∈ T, CollarAt (shadow (F.region c)) v s θ) :
    CollarAt (closure (F.region X ∪ F.region Y)) v s θ := by
  obtain ⟨h, hh, hsub⟩ := collarAt_iInter' T (fun c => shadow (F.region c)) hT
  have hh'0 : 0 < min h 1 := lt_min hh one_pos
  have hW : collar v s (θ - min h 1) (θ + min h 1) (min h 1) ⊆ collar v s (θ - h) (θ + h) h :=
    collar_subset_collar v s (by linarith [min_le_left h 1]) (by linarith [min_le_left h 1]) (min_le_left _ _)
  refine ⟨min h 1, hh'0, ?_⟩
  have := subset_closure_of_subset_shadow hF hP (T := T) (isOpen_collar v s _ _ (min_le_right h 1))
    (fun c hc z hz => hsub (hW hz) c hc)
  refine this.trans (closure_mono ?_)
  intro z hz
  obtain ⟨c, hc, hzc⟩ := mem_iUnion₂.mp hz
  rcases hXY c (Finset.mem_compl.mp hc) with rfl | rfl
  · exact Or.inl hzc
  · exact Or.inr hzc

theorem SectorsAt.collarAt_opposite' {v : ℂ} {n : ℕ} {d : Fin (n + 1) → ℝ} {c : Fin n → Fin k}
    (h : F.SectorsAt v n d c) (i : Fin n) {ψ : ℝ} (hψ : ψ ∈ Ioo (d i.succ - 3 * π / 2) (d i.castSucc - π / 2)) :
    ∀ x ∈ ({c i, c (finRotate n i), c ((finRotate n).symm i)} : Finset (Fin k)), CollarAt (shadow (F.region x)) v .inner ψ := by
  have hv : v ∈ F.dom := h.2.2.2.2.1
  have hle : d i.castSucc ≤ d i.succ := h.2.1 (Fin.castSucc_le_succ i)
  have hc1 : Real.cos (d i.castSucc - ψ) < 0 := cos_neg_of_mem' (by linarith [hψ.2]) (by linarith [hψ.1])
  have hc2 : Real.cos (d i.succ - ψ) < 0 := cos_neg_of_mem' (by linarith [hψ.2]) (by linarith [hψ.1])
  have hi1 : d i.castSucc ∈ coneAt (F.region (c i)) v := h.mem_coneAt_of_mem_Icc i ⟨le_rfl, hle⟩
  have hp : d i.castSucc ∈ coneAt (F.region (c ((finRotate n).symm i))) v := by
    have hm := h.mem_coneAt_of_mem_Icc ((finRotate n).symm i) ⟨h.2.1 (Fin.castSucc_le_succ _), le_rfl⟩
    rcases d_prev_succ h.2.2.1 i with ⟨he, -⟩ | ⟨he, -⟩
    · rwa [he] at hm
    · rw [he] at hm; exact mem_coneAt_add_two_pi.mp hm
  have hnx : d i.succ ∈ coneAt (F.region (c (finRotate n i))) v := by
    have hm := h.mem_coneAt_of_mem_Icc (finRotate n i) ⟨le_rfl, h.2.1 (Fin.castSucc_le_succ _)⟩
    have hpi : (finRotate n).symm (finRotate n i) = i := (finRotate n).symm_apply_apply i
    rcases d_prev_succ h.2.2.1 (finRotate n i) with ⟨he, -⟩ | ⟨he, -⟩
    · rw [hpi] at he; rwa [he]
    · rw [hpi] at he; rw [he]; exact mem_coneAt_add_two_pi.mpr hm
  intro x hx
  simp only [Finset.mem_insert, Finset.mem_singleton] at hx
  rcases hx with rfl | rfl | rfl
  · exact collarAt_shadow_inner_of_mem_coneAt hv hi1 hc1
  · exact collarAt_shadow_inner_of_mem_coneAt hv hnx hc2
  · exact collarAt_shadow_inner_of_mem_coneAt hv hp hc1

theorem step5_lt' (hk : k ≤ 5) (hF : F.Valid) (hP : F.IsPlaneMap) {v : ℂ} {n : ℕ} {d : Fin (n + 1) → ℝ}
    {c : Fin n → Fin k} (h : F.SectorsAt v n d c) (hn : 3 ≤ n) (i : Fin n) (hang : d i.succ - d i.castSucc < π / 3)
    (hnb : c (finRotate n i) ≠ c ((finRotate n).symm i)) : False := by
  classical
  have hadj := h.2.2.2.1 (by omega)
  have h1 : c i ≠ c (finRotate n i) := hadj i
  have h2 : c i ≠ c ((finRotate n).symm i) := by
    have := hadj ((finRotate n).symm i)
    rw [(finRotate n).apply_symm_apply i] at this
    exact Ne.symm this
  have hT : ({c i, c (finRotate n i), c ((finRotate n).symm i)} : Finset (Fin k)).card = 3 :=
    Finset.card_eq_three.mpr ⟨_, _, _, h1, h2, hnb, rfl⟩
  obtain ⟨X, Y, hXY⟩ := exists_two_cover' hk hT.ge
  exact woodall_step4 (F.isOpen_region X) (F.isOpen_region Y) (hF.region_dist_ne_one' X) (hF.region_dist_ne_one' Y)
    (u := v) .inner (θ₁ := d i.succ - 3 * π / 2) (θ₂ := d i.castSucc - π / 2) (by linarith)
    (fun ψ hψ => collarAt_closure_of_forall_shadow' hF hP hXY (h.collarAt_opposite' i hψ))

example : (finRotate 3).symm 0 = 2 := by decide

theorem step6' (hk : k ≤ 5) (hF : F.Valid) (hP : F.IsPlaneMap) {v : ℂ} {d : Fin 4 → ℝ} {c : Fin 3 → Fin k}
    (h : F.SectorsAt v 3 d c) (hc : Function.Injective c) (hang : ∀ i : Fin 3, π / 3 ≤ d i.succ - d i.castSucc) : False := by
  classical
  have hv : v ∈ F.dom := h.2.2.2.2.1
  have hpi := Real.pi_pos
  have hlast : d 3 = d 0 + 2 * π := h.2.2.1
  have ha0 : π / 3 ≤ d 1 - d 0 := hang 0
  have ha1 : π / 3 ≤ d 2 - d 1 := hang 1
  have ha2 : π / 3 ≤ d 3 - d 2 := hang 2
  have hS0 : d 0 < d 1 := by linarith
  have hS1 : d 1 < d 2 := by linarith
  have hS2 : d 2 < d 3 := by linarith
  have hc3 : ∀ θ, Real.cos (d 3 - θ) = Real.cos (d 0 - θ) := fun θ => by
    rw [hlast, show d 0 + 2 * π - θ = (d 0 - θ) + 2 * π by ring, Real.cos_add_two_pi]
  -- the three colours, and the two others
  have hT : ({c 0, c 1, c 2} : Finset (Fin k)).card = 3 :=
    Finset.card_eq_three.mpr ⟨_, _, _, fun h' => absurd (hc h') (by decide), fun h' => absurd (hc h') (by decide),
      fun h' => absurd (hc h') (by decide), rfl⟩
  obtain ⟨X, Y, hXY⟩ := exists_two_cover' hk hT.ge
  -- first order: a direction of every sector on the far (near) side of `ψ` gives an inner (outer) collar
  have hin : ∀ ψ : ℝ, ((∃ γ ∈ Icc (d 0) (d 1), Real.cos (γ - ψ) < 0) ∧ (∃ γ ∈ Icc (d 1) (d 2), Real.cos (γ - ψ) < 0) ∧
        (∃ γ ∈ Icc (d 2) (d 3), Real.cos (γ - ψ) < 0)) → CollarAt (closure (F.region X ∪ F.region Y)) v .inner ψ := by
    rintro ψ ⟨⟨γ₀, h₀, c₀⟩, ⟨γ₁, h₁, c₁⟩, ⟨γ₂, h₂, c₂⟩⟩
    refine collarAt_closure_of_forall_shadow' hF hP hXY fun x hx => ?_
    simp only [Finset.mem_insert, Finset.mem_singleton] at hx
    rcases hx with rfl | rfl | rfl
    · exact collarAt_shadow_inner_of_mem_coneAt hv (h.mem_coneAt_of_mem_Icc 0 h₀) c₀
    · exact collarAt_shadow_inner_of_mem_coneAt hv (h.mem_coneAt_of_mem_Icc 1 h₁) c₁
    · exact collarAt_shadow_inner_of_mem_coneAt hv (h.mem_coneAt_of_mem_Icc 2 h₂) c₂
  have hout : ∀ ψ : ℝ, ((∃ γ ∈ Icc (d 0) (d 1), 0 < Real.cos (γ - ψ)) ∧ (∃ γ ∈ Icc (d 1) (d 2), 0 < Real.cos (γ - ψ)) ∧
        (∃ γ ∈ Icc (d 2) (d 3), 0 < Real.cos (γ - ψ))) → CollarAt (closure (F.region X ∪ F.region Y)) v .outer ψ := by
    rintro ψ ⟨⟨γ₀, h₀, c₀⟩, ⟨γ₁, h₁, c₁⟩, ⟨γ₂, h₂, c₂⟩⟩
    refine collarAt_closure_of_forall_shadow' hF hP hXY fun x hx => ?_
    simp only [Finset.mem_insert, Finset.mem_singleton] at hx
    rcases hx with rfl | rfl | rfl
    · exact collarAt_shadow_outer_of_mem_coneAt hv (h.mem_coneAt_of_mem_Icc 0 h₀) c₀
    · exact collarAt_shadow_outer_of_mem_coneAt hv (h.mem_coneAt_of_mem_Icc 1 h₁) c₁
    · exact collarAt_shadow_outer_of_mem_coneAt hv (h.mem_coneAt_of_mem_Icc 2 h₂) c₂
  -- the cut angles: the normals of the three edges
  set K : Set ℝ := (fun p : Fin 3 × ℝ => d p.1.castSucc + p.2 * (π / 2)) '' (univ ×ˢ {1, -1}) with hK
  have hKfin : K.Finite := (Set.finite_univ.prod (Set.toFinite _)).image _
  have hKmem : ∀ (j : Fin 3) (σ : ℝ), (σ = 1 ∨ σ = -1) → d j.castSucc + σ * (π / 2) ∈ K :=
    fun j σ hσ => ⟨(j, σ), ⟨mem_univ _, by rcases hσ with rfl | rfl <;> simp⟩, rfl⟩
  -- off the cut angles, one side works at first order (two sectors failing on opposite sides share an edge whose normal is `θ`)
  have hside : ∀ θ : ℝ, (∀ κ ∈ K, ∀ m : ℤ, θ ≠ κ + 2 * π * m) →
      ((∃ γ ∈ Icc (d 0) (d 1), Real.cos (γ - θ) < 0) ∧ (∃ γ ∈ Icc (d 1) (d 2), Real.cos (γ - θ) < 0) ∧
        (∃ γ ∈ Icc (d 2) (d 3), Real.cos (γ - θ) < 0)) ∨
      ((∃ γ ∈ Icc (d 0) (d 1), 0 < Real.cos (γ - θ)) ∧ (∃ γ ∈ Icc (d 1) (d 2), 0 < Real.cos (γ - θ)) ∧
        (∃ γ ∈ Icc (d 2) (d 3), 0 < Real.cos (γ - θ))) := by
    intro θ hθ
    have hne : ∀ j : Fin 3, Real.cos (d j.castSucc - θ) ≠ 0 := by
      intro j hcos
      obtain ⟨σ, hσ, m, hm⟩ := exists_of_cos_eq_zero' hcos
      exact hθ _ (hKmem j σ hσ) m hm
    have key : ∀ a b : ℝ, a < b → (∀ γ ∈ Icc a b, 0 ≤ Real.cos (γ - θ)) → (∀ γ ∈ Icc a b, Real.cos (γ - θ) ≤ 0) → False :=
      fun a b hab h1 h2 => false_of_cos_eq_zero_Icc' hab fun γ hγ => le_antisymm (h2 γ hγ) (h1 γ hγ)
    by_contra hcon
    rw [not_or] at hcon
    obtain ⟨hni, hno⟩ := hcon
    have hA : (∀ γ ∈ Icc (d 0) (d 1), 0 ≤ Real.cos (γ - θ)) ∨ (∀ γ ∈ Icc (d 1) (d 2), 0 ≤ Real.cos (γ - θ)) ∨
        (∀ γ ∈ Icc (d 2) (d 3), 0 ≤ Real.cos (γ - θ)) := by
      by_contra hh; push Not at hh; exact hni ⟨hh.1, hh.2.1, hh.2.2⟩
    have hB : (∀ γ ∈ Icc (d 0) (d 1), Real.cos (γ - θ) ≤ 0) ∨ (∀ γ ∈ Icc (d 1) (d 2), Real.cos (γ - θ) ≤ 0) ∨
        (∀ γ ∈ Icc (d 2) (d 3), Real.cos (γ - θ) ≤ 0) := by
      by_contra hh; push Not at hh; exact hno ⟨hh.1, hh.2.1, hh.2.2⟩
    rcases hA with hA | hA | hA <;> rcases hB with hB | hB | hB
    · exact key _ _ hS0 hA hB
    · exact hne 1 (le_antisymm (hB (d 1) ⟨le_rfl, hS1.le⟩) (hA (d 1) ⟨hS0.le, le_rfl⟩))
    · exact hne 0 (show Real.cos (d 0 - θ) = 0 from le_antisymm (by rw [← hc3]; exact hB (d 3) ⟨hS2.le, le_rfl⟩) (hA (d 0) ⟨le_rfl, hS0.le⟩))
    · exact hne 1 (le_antisymm (hB (d 1) ⟨hS0.le, le_rfl⟩) (hA (d 1) ⟨le_rfl, hS1.le⟩))
    · exact key _ _ hS1 hA hB
    · exact hne 2 (le_antisymm (hB (d 2) ⟨le_rfl, hS2.le⟩) (hA (d 2) ⟨hS1.le, le_rfl⟩))
    · exact hne 0 (show Real.cos (d 0 - θ) = 0 from le_antisymm (hB (d 0) ⟨le_rfl, hS0.le⟩) (by rw [← hc3]; exact hA (d 3) ⟨hS2.le, le_rfl⟩))
    · exact hne 2 (le_antisymm (hB (d 2) ⟨hS1.le, le_rfl⟩) (hA (d 2) ⟨le_rfl, hS2.le⟩))
    · exact key _ _ hS2 hA hB
  have hcollar : ∀ θ : ℝ, (∀ κ ∈ K, ∀ m : ℤ, θ ≠ κ + 2 * π * m) →
      ∃ s, CollarAt (closure (F.region X ∪ F.region Y)) v s θ := by
    intro θ hθ
    rcases hside θ hθ with hI | hO
    · exact ⟨.inner, hin θ hI⟩
    · exact ⟨.outer, hout θ hO⟩
  -- the arc opposite each sector carries inner collars (first order)
  have hopp0 : ∀ ψ ∈ Ioo (d 1 - 3 * π / 2) (d 0 - π / 2), CollarAt (closure (F.region X ∪ F.region Y)) v .inner ψ := by
    intro ψ hψ
    obtain ⟨h1, h2⟩ := hψ
    refine hin ψ ⟨⟨d 0, ⟨le_rfl, hS0.le⟩, cos_neg_of_mem' (by linarith) (by linarith)⟩,
      ⟨d 1, ⟨le_rfl, hS1.le⟩, cos_neg_of_mem' (by linarith) (by linarith)⟩,
      ⟨d 3, ⟨hS2.le, le_rfl⟩, by rw [hc3]; exact cos_neg_of_mem' (by linarith) (by linarith)⟩⟩
  have hopp1 : ∀ ψ ∈ Ioo (d 2 - 3 * π / 2) (d 1 - π / 2), CollarAt (closure (F.region X ∪ F.region Y)) v .inner ψ := by
    intro ψ hψ
    obtain ⟨h1, h2⟩ := hψ
    refine hin ψ ⟨⟨d 1, ⟨hS0.le, le_rfl⟩, cos_neg_of_mem' (by linarith) (by linarith)⟩,
      ⟨d 1, ⟨le_rfl, hS1.le⟩, cos_neg_of_mem' (by linarith) (by linarith)⟩,
      ⟨d 2, ⟨le_rfl, hS2.le⟩, cos_neg_of_mem' (by linarith) (by linarith)⟩⟩
  have hopp2 : ∀ ψ ∈ Ioo (d 3 - 3 * π / 2) (d 2 - π / 2), CollarAt (closure (F.region X ∪ F.region Y)) v .inner ψ := by
    intro ψ hψ
    obtain ⟨h1, h2⟩ := hψ
    refine hin ψ ⟨⟨d 0, ⟨le_rfl, hS0.le⟩, by rw [← hc3]; exact cos_neg_of_mem' (by linarith) (by linarith)⟩,
      ⟨d 2, ⟨hS1.le, le_rfl⟩, cos_neg_of_mem' (by linarith) (by linarith)⟩,
      ⟨d 2, ⟨le_rfl, hS2.le⟩, cos_neg_of_mem' (by linarith) (by linarith)⟩⟩
  -- a closed sub-arc of an open arc of length above `π/3`
  have hsub : ∀ a b : ℝ, π / 3 < b - a → (∀ ψ ∈ Ioo a b, CollarAt (closure (F.region X ∪ F.region Y)) v .inner ψ) →
      ∃ (s : Rim) (θ₁ θ₂ : ℝ), π / 3 < θ₂ - θ₁ ∧ ∀ θ ∈ Icc θ₁ θ₂, CollarAt (closure (F.region X ∪ F.region Y)) v s θ := by
    intro a b hab hI
    refine ⟨.inner, a + (b - a - π / 3) / 4, b - (b - a - π / 3) / 4, by linarith, fun θ hθ => hI θ ⟨?_, ?_⟩⟩
    · linarith [hθ.1]
    · linarith [hθ.2]
  have hseed : ∃ (s : Rim) (θ₁ θ₂ : ℝ), π / 3 < θ₂ - θ₁ ∧
      ∀ θ ∈ Icc θ₁ θ₂, CollarAt (closure (F.region X ∪ F.region Y)) v s θ := by
    by_cases h0 : d 1 - d 0 < 2 * π / 3
    · exact hsub _ _ (by linarith) hopp0
    by_cases h1 : d 2 - d 1 < 2 * π / 3
    · exact hsub _ _ (by linarith) hopp1
    by_cases h2 : d 3 - d 2 < 2 * π / 3
    · exact hsub _ _ (by linarith) hopp2
    -- all three angles are `2π/3`: a certified normal of the edge `d 0` (the refined second-order lemma) extends an opposite arc
    push Not at h0 h1 h2
    have e1 : d 1 = d 0 + 2 * π / 3 := by linarith
    have e2 : d 2 = d 0 + 4 * π / 3 := by linarith
    have hpos : ∀ j : Fin 3, 0 < d j.succ - d j.castSucc := fun j => by linarith [hang j]
    obtain ⟨σ, hσ, hcol⟩ := h.exists_normal_collarAt hP (by norm_num) hpos 0
    have hprev : (finRotate 3).symm 0 = 2 := by decide
    rw [hprev] at hcol
    set ψ₀ := d 0 + σ * (π / 2) with hψ₀
    have hψ₀' : d (Fin.castSucc 0) + σ * (π / 2) = ψ₀ := rfl
    rw [hψ₀'] at hcol
    have hc1 : CollarAt (shadow (F.region (c 1))) v .inner ψ₀ := by
      rcases hσ with rfl | rfl
      · exact collarAt_shadow_inner_of_mem_coneAt hv (h.mem_coneAt_of_mem_Icc 1 (γ := d 2) ⟨hS1.le, le_rfl⟩)
          (cos_neg_of_mem' (by rw [hψ₀]; linarith) (by rw [hψ₀]; linarith))
      · exact collarAt_shadow_inner_of_mem_coneAt hv (h.mem_coneAt_of_mem_Icc 1 (γ := d 1) ⟨le_rfl, hS1.le⟩)
          (cos_neg_of_mem' (by rw [hψ₀]; linarith) (by rw [hψ₀]; linarith))
    have hall : CollarAt (closure (F.region X ∪ F.region Y)) v .inner ψ₀ := by
      refine collarAt_closure_of_forall_shadow' hF hP hXY fun x hx => ?_
      simp only [Finset.mem_insert, Finset.mem_singleton] at hx
      rcases hx with rfl | rfl | rfl
      · exact hcol.mono inter_subset_right
      · exact hc1
      · exact hcol.mono inter_subset_left
    obtain ⟨h₀, hh₀, hsub₀⟩ := hall
    set t := min (h₀ / 4) (π / 12) with ht
    have ht0 : 0 < t := lt_min (by linarith) (by linarith)
    have ht1 : t ≤ h₀ / 4 := min_le_left _ _
    have ht2 : t ≤ π / 12 := min_le_right _ _
    have hnear : ∀ θ : ℝ, |θ - ψ₀| ≤ t → CollarAt (closure (F.region X ∪ F.region Y)) v .inner θ :=
      fun θ hθ => CollarAt.of_near' hh₀ hsub₀ (by linarith)
    rcases hσ with rfl | rfl
    · -- `ψ₀ = d 0 + π/2`, the start of the arc opposite sector 2, `(d 0 + π/2, d 0 + 5π/6)`
      refine ⟨.inner, ψ₀ - t, d 0 + 5 * π / 6 - t / 2, by rw [hψ₀]; linarith, fun θ hθ => ?_⟩
      by_cases hle : θ ≤ ψ₀ + t
      · exact hnear θ (abs_le.mpr ⟨by linarith [hθ.1], by linarith⟩)
      · push Not at hle
        exact hopp2 θ ⟨by rw [hlast]; rw [hψ₀] at hle; linarith, by rw [e2]; linarith [hθ.2]⟩
    · -- `ψ₀ = d 0 − π/2`, the end of the arc opposite sector 0, `(d 0 − 5π/6, d 0 − π/2)`
      refine ⟨.inner, d 0 - 5 * π / 6 + t / 2, ψ₀ + t, by rw [hψ₀]; linarith, fun θ hθ => ?_⟩
      by_cases hle : ψ₀ - t ≤ θ
      · exact hnear θ (abs_le.mpr ⟨by linarith, by linarith [hθ.2]⟩)
      · push Not at hle
        exact hopp0 θ ⟨by rw [e1]; linarith [hθ.1], by rw [hψ₀] at hle; linarith⟩
  exact townsend_lemma (F.isOpen_region X) (F.isOpen_region Y) (hF.region_dist_ne_one' X) (hF.region_dist_ne_one' Y)
    (u := v) hKfin hcollar hseed

end ArcMap
end HadwigerNelson.Plane

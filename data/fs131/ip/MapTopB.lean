import Proofs.HadwigerNelson.Plane.ValidMap.MapTopology

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-- The outer domain is open: with each point it holds the point's component of `(cl T)ᶜ`. -/
theorem isOpen_outerDom (T : Set ℂ) : IsOpen (outerDom T) := by
  rw [isOpen_iff_forall_mem_open]
  intro z hz
  refine ⟨connectedComponentIn (closure T)ᶜ z, fun w hw => ⟨connectedComponentIn_subset _ _ hw, ?_⟩,
    isClosed_closure.isOpen_compl.connectedComponentIn, mem_connectedComponentIn hz.1⟩
  rw [← connectedComponentIn_eq hw]
  exact hz.2

/-- The outer domain misses the closure. -/
theorem outerDom_subset_compl_closure (T : Set ℂ) : outerDom T ⊆ (closure T)ᶜ := fun _ hz => hz.1

theorem tileOf_subset_ball' (hF : F.Valid) {u : ℂ} {j : Fin k} {S T : Set ℂ} (hS : F.TileOf j S) (huS : u ∈ closure S)
    (hT : F.TileOf j T) (hTb : (T ∩ ball u 1).Nonempty) : T ⊆ ball u 1 := by
  -- no pair of the two tiles is at distance `1` (one colour, validity)
  have hne : ∀ s ∈ S, ∀ t ∈ T, dist s t ≠ 1 := fun s hs t ht h1 =>
    hF s (hS.1.subset_interiorPts hs) t (hT.1.subset_interiorPts ht) h1 (by rw [hS.2 hs, hT.2 ht])
  obtain ⟨t₀, ht₀T, ht₀u⟩ := hTb
  rw [mem_ball] at ht₀u
  -- a pair near `(u, t₀)` is closer than `1`
  obtain ⟨s₀, hs₀, hs₀d⟩ := Metric.mem_closure_iff.mp huS (1 - dist t₀ u) (by linarith)
  have hnear : dist s₀ t₀ < 1 := by
    have := dist_triangle s₀ u t₀
    rw [dist_comm u t₀, dist_comm s₀ u] at this
    linarith
  -- so every pair is closer than `1` (the distances over the connected `S × T` form an interval missing `1`)
  have hpre : IsPreconnected ((fun q : ℂ × ℂ => dist q.1 q.2) '' (S ×ˢ T)) :=
    (hS.1.isPreconnected.prod hT.1.isPreconnected).image _ (continuous_fst.dist continuous_snd).continuousOn
  have hall : ∀ q ∈ S ×ˢ T, dist q.1 q.2 ≤ 1 := by
    rintro ⟨s, t⟩ ⟨hs, ht⟩
    by_contra hlt
    push Not at hlt
    obtain ⟨q, hq, hq1⟩ := hpre.Icc_subset ⟨(s₀, t₀), ⟨hs₀, ht₀T⟩, rfl⟩ ⟨(s, t), ⟨hs, ht⟩, rfl⟩ ⟨hnear.le, hlt.le⟩
    exact hne q.1 hq.1 q.2 hq.2 hq1
  -- on the closure of `S`, so `dist u t ≤ 1` on `T`; `T` open makes it strict
  have hcl : closure (S ×ˢ T) ⊆ {q : ℂ × ℂ | dist q.1 q.2 ≤ 1} :=
    closure_minimal hall (isClosed_le (continuous_fst.dist continuous_snd) continuous_const)
  rw [closure_prod_eq] at hcl
  have hle : ∀ t ∈ T, dist t u ≤ 1 := fun t ht => by
    rw [dist_comm]; exact hcl (show (u, t) ∈ closure S ×ˢ closure T from ⟨huS, subset_closure ht⟩)
  intro t ht
  rw [mem_ball]
  refine lt_of_le_of_ne (hle t ht) fun h1 => ?_
  -- a point of `T` just beyond `t`, away from `u`, would be farther than `1`
  obtain ⟨ε, hε, hεT⟩ := Metric.isOpen_iff.mp hT.1.isOpen t ht
  set t' := t + ((ε / 2 : ℝ) : ℂ) * (t - u) with ht'
  have ht'T : t' ∈ T := hεT (by
    rw [mem_ball, ht', dist_eq_norm, add_sub_cancel_left, norm_mul, Complex.norm_real, Real.norm_of_nonneg (by linarith),
      ← dist_eq_norm, h1]
    linarith)
  have : dist t' u = (1 + ε / 2) * dist t u := by
    rw [ht', dist_eq_norm, dist_eq_norm, show t + ((ε / 2 : ℝ) : ℂ) * (t - u) - u = ((1 + ε / 2 : ℝ) : ℂ) * (t - u) by
      push_cast; ring, norm_mul, Complex.norm_real, Real.norm_of_nonneg (by linarith)]
  have := hle t' ht'T
  rw [‹dist t' u = _›, h1] at this
  linarith

theorem GermPseudo.eq_of_cw' {u : ℂ} {θ : ℝ} {a c : Fin k} (ha : F.GermPseudo u θ .cw a) (hc : F.GermPseudo u θ .cw c) : a = c := by
  obtain ⟨δ₁, hδ₁, h₁⟩ := ha
  obtain ⟨δ₂, hδ₂, h₂⟩ := hc
  have hδ : 0 < min δ₁ δ₂ := lt_min hδ₁ hδ₂
  obtain ⟨z, hz⟩ : (germ u θ .cw (min δ₁ δ₂)).Nonempty :=
    ⟨_, mem_image_of_mem _ (show min δ₁ δ₂ / 2 ∈ Ioo 0 (min δ₁ δ₂) from ⟨by linarith, by linarith⟩)⟩
  have e₁ : F.pseudoColours u z = {a} := h₁ (germ_mono (min_le_left _ _) hz)
  have e₂ : F.pseudoColours u z = {c} := h₂ (germ_mono (min_le_right _ _) hz)
  exact Set.singleton_eq_singleton_iff.mp (e₁.symm.trans e₂)

end ArcMap

end HadwigerNelson.Plane

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- An arc of `ω(u)` is unchanged by shifting both ends by a multiple of `2π`. -/
theorem ringArc_add_two_pi_mul (u : ℂ) (s t : ℝ) (n : ℤ) :
    ringArc u (s + 2 * π * n) (t + 2 * π * n) = ringArc u s t := by
  unfold ringArc
  rw [← Set.image_add_const_Icc, Set.image_image]
  congr 1
  ext θ
  simp only [ringPt, e_add_int_mul]

theorem ringArc_cases' (u : ℂ) {s t s' t' : ℝ} (hst : s < t) (hst' : t < s + π / 3) (hs't' : s' < t') (hs't'' : t' < s' + π / 3) :
    Disjoint (ringArc u s t) (ringArc u s' t') ∨ ringArc u s t ⊆ ringArc u s' t' ∨ ringArc u s' t' ⊆ ringArc u s t ∨
      (∃ n : ℤ, (s < s' + 2 * π * n ∧ s' + 2 * π * n < t ∧ t < t' + 2 * π * n) ∨
        (s' + 2 * π * n < s ∧ s < t' + 2 * π * n ∧ t' + 2 * π * n < t)) ∨
      ringPt u t = ringPt u s' ∨ ringPt u t' = ringPt u s := by
  have hπ := Real.pi_pos
  -- shift the second arc to start within `π` of `s`
  set n : ℤ := ⌊(s - s' + π) / (2 * π)⌋ with hn
  have hn1 : (n : ℝ) ≤ (s - s' + π) / (2 * π) := Int.floor_le _
  have hn2 : (s - s' + π) / (2 * π) < n + 1 := Int.lt_floor_add_one _
  rw [le_div_iff₀ (by positivity)] at hn1
  rw [div_lt_iff₀ (by positivity)] at hn2
  set σ := s' + 2 * π * n with hσ
  set τ := t' + 2 * π * n with hτ
  have hσ1 : s - π < σ := by rw [hσ]; nlinarith
  have hσ2 : σ ≤ s + π := by rw [hσ]; nlinarith
  have hστ : σ < τ := by rw [hσ, hτ]; linarith
  have hστ' : τ < σ + π / 3 := by rw [hσ, hτ]; linarith
  have hA : ringArc u s' t' = ringArc u σ τ := (ringArc_add_two_pi_mul u s' t' n).symm
  have hrt' : ringPt u t' = ringPt u τ := by simp only [ringPt, hτ, e_add_int_mul]
  have hrs' : ringPt u s' = ringPt u σ := by simp only [ringPt, hσ, e_add_int_mul]
  -- real intervals that miss each other give arcs that miss each other
  have hdisj : (τ < s ∨ t < σ) → Disjoint (ringArc u s t) (ringArc u s' t') := by
    intro h
    rw [hA, Set.disjoint_left]
    rintro z ⟨θ, hθ, rfl⟩ ⟨φ, hφ, hφθ⟩
    simp only [ringPt, add_right_inj] at hφθ
    obtain ⟨m, hm⟩ := e_eq_e_iff.mp hφθ
    have hm0 : m = 0 := by
      have h1 : (m * (2 * π) : ℝ) < 2 * π := by linarith [hθ.1, hθ.2, hφ.1, hφ.2]
      have h2 : -(2 * π) < (m * (2 * π) : ℝ) := by linarith [hθ.1, hθ.2, hφ.1, hφ.2]
      have h1' : (m : ℝ) < 1 := by nlinarith
      have h2' : (-1 : ℝ) < m := by nlinarith
      have : m < 1 := by exact_mod_cast h1'
      have : -1 < m := by exact_mod_cast h2'
      omega
    rw [hm0] at hm
    simp at hm
    rcases h with h | h
    · linarith [hθ.1, hφ.2]
    · linarith [hθ.2, hφ.1]
  rcases lt_trichotomy τ s with h1 | h1 | h1
  · exact Or.inl (hdisj (Or.inl h1))
  · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inr (by rw [hrt', h1])))))
  rcases lt_trichotomy t σ with h2 | h2 | h2
  · exact Or.inl (hdisj (Or.inr h2))
  · exact Or.inr (Or.inr (Or.inr (Or.inr (Or.inl (by rw [hrs', h2])))))
  rw [hA]
  rcases le_or_gt σ s with h3 | h3
  · rcases le_or_gt t τ with h4 | h4
    · exact Or.inr (Or.inl (by unfold ringArc; exact image_mono (Icc_subset_Icc h3 h4)))
    · rcases eq_or_lt_of_le h3 with h5 | h5
      · exact Or.inr (Or.inr (Or.inl (by unfold ringArc; exact image_mono (Icc_subset_Icc h5.ge h4.le))))
      · exact Or.inr (Or.inr (Or.inr (Or.inl ⟨n, Or.inr ⟨h5, h1, h4⟩⟩)))
  · rcases le_or_gt τ t with h4 | h4
    · exact Or.inr (Or.inr (Or.inl (by unfold ringArc; exact image_mono (Icc_subset_Icc h3.le h4))))
    · exact Or.inr (Or.inr (Or.inr (Or.inl ⟨n, Or.inl ⟨h3, h2, h4⟩⟩)))

end HadwigerNelson.Plane

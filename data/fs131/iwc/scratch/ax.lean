import Proofs.HadwigerNelson.Plane.Woodall.NoFourFive

/-!
# Woodall's step 3, localized: finitely many merges on a ball (FS131-E3's E3-W, E3-NICE, E3-BALL)

FS131-W3's skeleton (`plans/FS131-W-kernel-plan.md` § 14) for `exists_woodallMerged`, the modification Woodall's chain reads
(`plans/FS131-E3-derivation.md` §§ 3.2–3.4): every valid arc map of the plane has a valid arc map of the plane, Condition 5 kept, in which
every point of `closedBall 0 R` of three or more colours is `NiceAt`.

* **Recolouring** (`ArcMap.recolour`): a set `W` whose frontier lies on finitely many new arcs is given one colour; nothing else moves. Its
  validity is a statement about `W` alone (`recolour_valid`), its Condition 5 one about the new arcs (`recolour_condition5`), and off
  `closure W` and the new arcs the regions are unchanged (`recolour_region_diff`).
* **E3-W** (`clear_wedge`): two open ray segments in the closure of an open set `S` with null unit pairs, less than `π` apart, clear the wedge
  between them of `S`'s unit distance up to radius `r₁ cos(α/2)/2` (the sagitta). E3's hypothesis "`ω(v)` misses `S`" is not needed: the
  segments put `v` in `closure S`, and wave 1's `dist_ne_one_of_mem_of_mem_closure` gives it.
* **The merge at a wedge** (`wedgeMerge`, `wedgeMerge_valid`, `wedgeMerge_condition5`, `wedgeMerge_region_diff`): the recolouring of the open
  annular sector `annSector v 0 ρ d₁ d₂` with `c`, bounded by two segments and an arc of radius `ρ`.
* **Locality** (`coloursAt_congr`, `niceAt_congr`): the colours at a point and `NiceAt` depend only on the regions near it.
* **The local data at a point** (`DirColourAt`): finitely many exceptional directions, off which a thin open cone lies in one colour class.
  Wave 3's wedge lemma (`GoodAt.exists_wedge`) gives it at every point of the domain (`exists_dirColourAt`); the `NiceAt` picture is built from
  it (`niceAt_of_dirColourAt`); in a good ball only the centre carries three colours (`GoodAt.ncard_coloursAt_le_two`), so three-colour points
  are finite on compact sets (`finite_three_le_coloursAt`).
* **E3-NICE** (`exists_merge_at`): merging at one point until it, and every new point of three colours near it, is `NiceAt` — the local data
  updated by each merge (`dirColourAt_wedgeMerge`), the crossings `NiceAt` (`wedgeMerge_niceAt`).
* **E3-BALL** (`exists_woodallMerged`): finitely many such merges on `closedBall 0 R`.

No statement here reads `localSectors` (FS131-I3i): wave 3's landed `GoodAt` engine gives every local fact the merge needs (§ 14.3).

**Inhabitants.** `recolour`, `wedgeMerge` and `DirColourAt` are defined for any arc map; the theorems over a valid map of the plane with any
number of colours are inhabited by `sevenBrickMap` (`sevenBrickMap_valid`, `sevenBrickMap_isPlaneMap`, `Plane/SVMap`); `DirColourAt` has its spec
example on the one-colour plane below; `clear_wedge` is region-only (any open set with null unit pairs and two such segments: E3's model, a
two-sector colour class of diameter below `1`).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-- `φ` is off the finitely many directions `D`, mod `2π`. -/
def OffDirs (D : Finset ℝ) (φ : ℝ) : Prop := ∀ δ ∈ D, ∀ m : ℤ, φ ≠ δ + 2 * π * m

/-- An annular sector of non-negative inner radius lies in the ball of its outer radius. -/
theorem annSector_subset_ball (u : ℂ) {r₁ : ℝ} (hr : 0 ≤ r₁) (r₂ θ₁ θ₂ : ℝ) : annSector u r₁ r₂ θ₁ θ₂ ⊆ ball u r₂ := by
  rintro _ ⟨⟨s, θ⟩, ⟨hs, -⟩, rfl⟩
  rw [mem_ball, dist_eq_norm, add_sub_cancel_left, norm_real_mul_e (hr.trans hs.1.le)]
  exact hs.2

/-- Annular sectors grow with the outer radius. -/
theorem annSector_mono_r₂ (u : ℂ) {r₁ r₂ r₂' θ₁ θ₂ : ℝ} (h : r₂ ≤ r₂') : annSector u r₁ r₂ θ₁ θ₂ ⊆ annSector u r₁ r₂' θ₁ θ₂ := by
  rintro _ ⟨⟨s, θ⟩, ⟨hs, hθ⟩, rfl⟩
  exact ⟨(s, θ), ⟨⟨hs.1, hs.2.trans_le h⟩, hθ⟩, rfl⟩

/-- A point `u + s e(d)`, `0 ≤ s ≤ ρ`, lies on the segment from `u` to `u + ρ e(d)`. -/
theorem mem_segment_ray {u : ℂ} {ρ s : ℝ} (hρ : 0 < ρ) (hs0 : 0 ≤ s) (hsρ : s ≤ ρ) (d : ℝ) :
    u + (s : ℂ) * e d ∈ segment ℝ u (u + (ρ : ℂ) * e d) := by
  refine ⟨1 - s / ρ, s / ρ, by rw [sub_nonneg, div_le_one hρ]; exact hsρ, div_nonneg hs0 hρ.le, by ring, ?_⟩
  simp only [Complex.real_smul]
  have : (ρ : ℂ) ≠ 0 := by exact_mod_cast hρ.ne'
  push_cast
  field_simp
  ring

/-- A point of the punctured disc off the two edge rays at `d₁` and `d₂` lies in one of the open sectors `(d₁, d₂)`, `(d₂, d₁ + 2π)` (either
empty when `d₂` is outside `(d₁, d₁ + 2π)`). -/
theorem mem_annSector_union_of_ne {v q : ℂ} {d₁ d₂ r : ℝ} (hq : q ≠ v)
    (hqr : ‖q - v‖ < r) (h₁ : ∀ s : ℝ, 0 < s → s < r → q ≠ v + (s : ℂ) * e d₁)
    (h₂ : ∀ s : ℝ, 0 < s → s < r → q ≠ v + (s : ℂ) * e d₂) :
    q ∈ annSector v 0 r d₁ d₂ ∪ annSector v 0 r d₂ (d₁ + 2 * π) := by
  have hpol := eq_add_norm_mul_e v q (d₁ + π)
  set ψ := d₁ + π + Complex.arg ((q - v) * starRingEnd ℂ (e (d₁ + π))) with hψ
  have ha1 := Complex.neg_pi_lt_arg ((q - v) * starRingEnd ℂ (e (d₁ + π)))
  have ha2 := Complex.arg_le_pi ((q - v) * starRingEnd ℂ (e (d₁ + π)))
  have hs0 : 0 < ‖q - v‖ := norm_pos_iff.mpr (sub_ne_zero.mpr hq)
  rcases lt_trichotomy ψ d₂ with h | h | h
  · exact Or.inl ⟨(‖q - v‖, ψ), ⟨⟨hs0, hqr⟩, ⟨by linarith, h⟩⟩, hpol.symm⟩
  · exact absurd (h ▸ hpol) (h₂ _ hs0 hqr)
  · rcases lt_or_eq_of_le (show ψ ≤ d₁ + 2 * π by linarith) with h' | h'
    · exact Or.inr ⟨(‖q - v‖, ψ), ⟨⟨hs0, hqr⟩, ⟨h, h'⟩⟩, hpol.symm⟩
    · refine absurd ?_ (h₁ _ hs0 hqr)
      calc q = v + (‖q - v‖ : ℂ) * e ψ := hpol
        _ = v + (‖q - v‖ : ℂ) * e d₁ := by rw [h', e_add_two_pi]

/-- The two open sectors between the edge rays at `d₁ < d₂ < d₁ + 2π` are disjoint. -/
theorem disjoint_annSector_wedges (v : ℂ) {d₁ d₂ r : ℝ} :
    Disjoint (annSector v 0 r d₁ d₂) (annSector v 0 r d₂ (d₁ + 2 * π)) := by
  rw [Set.disjoint_left]
  rintro _ ⟨⟨s, θ⟩, ⟨hs, hθ⟩, rfl⟩ ⟨⟨s', θ'⟩, ⟨hs', hθ'⟩, h⟩
  simp only at hs hθ hs' hθ' h
  have h1 : (s' : ℂ) * e θ' = (s : ℂ) * e θ := by linear_combination h
  have hss : s' = s := by
    have := congrArg norm h1
    rwa [norm_real_mul_e hs'.1.le, norm_real_mul_e hs.1.le] at this
  rw [hss] at h1
  have he : e θ' = e θ := mul_left_cancel₀ (by exact_mod_cast hs.1.ne') h1
  obtain ⟨n, hn⟩ := e_eq_e_iff.mp he
  have hπ := Real.pi_pos
  have h0 : (0 : ℝ) * (2 * π) < n * (2 * π) := by linarith [hθ.2, hθ'.1]
  have h1' : (n : ℝ) * (2 * π) < 1 * (2 * π) := by linarith [hθ.1, hθ'.2]
  have hn1 : (0 : ℝ) < n := lt_of_mul_lt_mul_right h0 (by positivity)
  have hn2 : (n : ℝ) < 1 := lt_of_mul_lt_mul_right h1' (by positivity)
  have : (0 : ℤ) < n := by exact_mod_cast hn1
  have : n < 1 := by exact_mod_cast hn2
  omega

/-- **E3-W, Woodall's criterion with a radius** (`plans/FS131-E3-derivation.md` § 3.2; `[Woodall1973]` p. 197, step 3, asserts it without a
radius: "each unit circle through Q, except for those through P, passes through X or Y"): if the open segments from `v` in the directions
`d₁ < d₂ < d₁ + π`, of length `r₁ < cos(α/2)/2` (`α = d₂ − d₁`), lie in the closure of an open set `S` with null unit pairs, then no point of the
open wedge between them within `r₁ cos(α/2)/2` of `v` is at distance `1` from a point of `S`. -/
theorem clear_wedge {S : Set ℂ} (hS : IsOpen S) (hnull : UnitPairsNull S) {v : ℂ} {d₁ d₂ r₁ : ℝ} (hd : d₁ < d₂)
    (hπ : d₂ - d₁ < π) (hr₁ : 0 < r₁) (hr₁c : r₁ < Real.cos ((d₂ - d₁) / 2) / 2)
    (hseg : ∀ s ∈ Ioo 0 r₁, v + (s : ℂ) * e d₁ ∈ closure S ∧ v + (s : ℂ) * e d₂ ∈ closure S) :
    ∀ z ∈ annSector v 0 (r₁ * Real.cos ((d₂ - d₁) / 2) / 2) d₁ d₂, ∀ y ∈ S, dist z y ≠ 1 := by
  have hpi := Real.pi_pos
  have hγ0 : 0 < Real.cos ((d₂ - d₁) / 2) := Real.cos_pos_of_mem_Ioo ⟨by linarith, by linarith⟩
  have hγ1 : Real.cos ((d₂ - d₁) / 2) ≤ 1 := Real.cos_le_one _
  generalize hγdef : Real.cos ((d₂ - d₁) / 2) = γ at hγ0 hγ1 hr₁c
  have hr₁h : r₁ < 1 / 2 := by linarith
  rintro _ ⟨⟨s₀, θ₀⟩, ⟨hs₀, hθ₀⟩, rfl⟩ y hy hzy
  simp only at hs₀ hθ₀ hzy
  -- closure points of `S` are never at distance `1` from `y`, and `v` is one
  have hcl : ∀ q ∈ closure S, dist q y ≠ 1 := fun q hq h =>
    dist_ne_one_of_mem_of_mem_closure hS hnull hy hq (by rw [dist_comm]; exact h)
  have hvS : v ∈ closure S := by
    rw [← closure_closure, Metric.mem_closure_iff]
    intro ε hε
    refine ⟨v + ((min ε r₁ / 2 : ℝ) : ℂ) * e d₁, (hseg _ ⟨by positivity, by linarith [min_le_right ε r₁]⟩).1, ?_⟩
    rw [dist_eq_norm, show v - (v + ((min ε r₁ / 2 : ℝ) : ℂ) * e d₁) = -(((min ε r₁ / 2 : ℝ) : ℂ) * e d₁) by ring,
      norm_neg, norm_real_mul_e (by positivity)]
    linarith [min_le_left ε r₁]
  -- the unit circle about `y`, and the distance of its points from `v`
  set p : ℝ → ℂ := fun t => y + e t with hp
  have hpc : Continuous p := by have := continuous_e; fun_prop
  set f : ℝ → ℝ := fun t => ‖p t - v‖ with hf
  have hfc : Continuous f := by fun_prop
  have hzv : ‖v + (s₀ : ℂ) * e θ₀ - v‖ = s₀ := by rw [add_sub_cancel_left, norm_real_mul_e hs₀.1.le]
  have hγs : r₁ * γ / 2 < r₁ := by nlinarith
  have hs₀r : s₀ < r₁ := hs₀.2.trans hγs
  obtain ⟨tz, htz⟩ : ∃ tz, p tz = v + (s₀ : ℂ) * e θ₀ := by
    have h1 : ‖v + (s₀ : ℂ) * e θ₀ - y‖ = 1 := by rw [← dist_eq_norm]; exact hzy
    have := eq_add_norm_mul_e y (v + (s₀ : ℂ) * e θ₀) 0
    rw [h1, Complex.ofReal_one, one_mul] at this
    exact ⟨_, this.symm⟩
  have hftz : f tz < r₁ := by simp only [hf, htz, hzv]; exact hs₀r
  have hepi : ∀ t, e (t + π) = - e t := fun t => by
    rw [e_add]; simp [e, Complex.exp_pi_mul_I]
  have hfar : ∀ t, e t = - e tz → r₁ < f t := by
    intro t ht
    have h1 : p t - v = (v + (s₀ : ℂ) * e θ₀ - v) - 2 * e tz := by
      rw [← htz]; simp only [hp, ht]; ring
    have h2 : ‖(2 : ℂ) * e tz‖ = 2 := by rw [norm_mul, norm_e, mul_one]; norm_num
    have h3 := norm_sub_norm_le ((2 : ℂ) * e tz) (v + (s₀ : ℂ) * e θ₀ - v)
    simp only [hf, h1]
    rw [norm_sub_rev ((2 : ℂ) * e tz)] at h3
    linarith
  -- `b`: the first return to the circle of radius `r₁` after `tz`; `a`: the last one before it
  set B := {t | tz ≤ t ∧ r₁ ≤ f t} with hBdef
  have hBne : B.Nonempty := ⟨tz + π, by linarith, (hfar _ (hepi tz)).le⟩
  have hBbdd : BddBelow B := ⟨tz, fun t ht => ht.1⟩
  have hBcl : IsClosed B := (isClosed_le continuous_const continuous_id).inter (isClosed_le continuous_const hfc)
  have hbB : sInf B ∈ B := hBcl.csInf_mem hBne hBbdd
  set b := sInf B with hbdef
  have hlowb : ∀ t, tz ≤ t → t < b → f t < r₁ := fun t h1 h2 => by
    by_contra h
    exact absurd (csInf_le hBbdd ⟨h1, not_lt.mp h⟩) (not_le.mpr h2)
  have htzb : tz < b := lt_of_le_of_ne hbB.1 fun h => by rw [← h] at hbB; linarith [hbB.2]
  have hfb : f b = r₁ := by
    refine le_antisymm ?_ hbB.2
    by_contra h
    push Not at h
    obtain ⟨ε, hε, hball⟩ := Metric.eventually_nhds_iff.mp ((hfc.tendsto b).eventually (lt_mem_nhds h))
    have h1 := hball (show dist (max tz (b - ε / 2)) b < ε by
      rw [Real.dist_eq, abs_lt]; constructor <;> [linarith [le_max_right tz (b - ε / 2)]; linarith [max_lt htzb (by linarith : b - ε / 2 < b)]])
    linarith [hlowb _ (le_max_left _ _) (max_lt htzb (show b - ε / 2 < b by linarith))]
  set A := {t | t ≤ tz ∧ r₁ ≤ f t} with hAdef
  have hAne : A.Nonempty := ⟨tz - π, by linarith, (hfar _ (by have := hepi (tz - π); rw [sub_add_cancel] at this; rw [this]; ring)).le⟩
  have hAbdd : BddAbove A := ⟨tz, fun t ht => ht.1⟩
  have hAcl : IsClosed A := (isClosed_le continuous_id continuous_const).inter (isClosed_le continuous_const hfc)
  have haA : sSup A ∈ A := hAcl.csSup_mem hAne hAbdd
  set a := sSup A with hadef
  have hlowa : ∀ t, a < t → t ≤ tz → f t < r₁ := fun t h1 h2 => by
    by_contra h
    exact absurd (le_csSup hAbdd ⟨h2, not_lt.mp h⟩) (not_le.mpr h1)
  have hatz : a < tz := lt_of_le_of_ne haA.1 fun h => by rw [h] at haA; linarith [haA.2]
  have hfa : f a = r₁ := by
    refine le_antisymm ?_ haA.2
    by_contra h
    push Not at h
    obtain ⟨ε, hε, hball⟩ := Metric.eventually_nhds_iff.mp ((hfc.tendsto a).eventually (lt_mem_nhds h))
    have h1 := hball (show dist (min tz (a + ε / 2)) a < ε by
      rw [Real.dist_eq, abs_lt]; constructor <;> [linarith [lt_min hatz (by linarith : a < a + ε / 2)]; linarith [min_le_right tz (a + ε / 2)]])
    linarith [hlowa _ (lt_min hatz (show a < a + ε / 2 by linarith)) (min_le_left _ _)]
  have hin : ∀ t ∈ Ioo a b, f t < r₁ := fun t ht => by
    by_cases h : t ≤ tz
    · exact hlowa t ht.1 h
    · exact hlowb t (le_of_lt (not_le.mp h)) ht.2
  -- the arc between `a` and `b` stays in the open wedge (it cannot cross the edges, which lie in `closure S`)
  have hd2 : d₂ < d₁ + 2 * π := by linarith
  have hIW : p '' Ioo a b ⊆ annSector v 0 r₁ d₁ d₂ := by
    have hsub : p '' Ioo a b ⊆ annSector v 0 r₁ d₁ d₂ ∪ annSector v 0 r₁ d₂ (d₁ + 2 * π) := by
      rintro _ ⟨t, ht, rfl⟩
      have hpy : dist (p t) y = 1 := by simp only [hp, dist_eq_norm, add_sub_cancel_left, norm_e]
      refine mem_annSector_union_of_ne (fun h => hcl v hvS (h ▸ hpy)) (hin t ht)
        (fun s hs1 hs2 h => hcl _ (hseg s ⟨hs1, hs2⟩).1 (h ▸ hpy)) (fun s hs1 hs2 h => hcl _ (hseg s ⟨hs1, hs2⟩).2 (h ▸ hpy))
    exact (isPreconnected_Ioo.image p hpc.continuousOn).subset_left_of_subset_union
      (isOpen_annSector v le_rfl _ _ _) (isOpen_annSector v le_rfl _ _ _) (disjoint_annSector_wedges v) hsub
      ⟨_, ⟨tz, ⟨hatz, htzb⟩, htz⟩, ⟨(s₀, θ₀), ⟨⟨hs₀.1, hs₀r⟩, hθ₀⟩, rfl⟩⟩
  -- its ends lie on the circle of radius `r₁` about `v`, in the closed wedge
  have hab : a < b := hatz.trans htzb
  have hend : ∀ t, t = a ∨ t = b → ∃ θ ∈ Icc d₁ d₂, p t = v + (r₁ : ℂ) * e θ := by
    intro t ht
    have hcl1 : t ∈ closure (Ioo a b) := by
      rw [closure_Ioo hab.ne]; rcases ht with rfl | rfl <;> constructor <;> linarith
    have hpt : p t ∈ closure (annSector v 0 r₁ d₁ d₂) := closure_mono hIW (map_mem_closure hpc hcl1 (mapsTo_image p _))
    obtain ⟨⟨s, θ⟩, ⟨hs, hθ⟩, hst⟩ := closure_annSector_subset v hr₁.le hd.le hpt
    simp only at hs hθ hst
    have hft : f t = r₁ := by rcases ht with rfl | rfl; exacts [hfa, hfb]
    have hsr : s = r₁ := by
      rw [← hft]; simp only [hf, ← hst, add_sub_cancel_left, norm_real_mul_e hs.1]
    exact ⟨θ, hθ, by rw [← hst, hsr]⟩
  -- the arc is at most a half circle
  have hshort : b - a ≤ π := by
    by_contra h
    push Not at h
    have h1 : (a + b) / 2 - π / 2 ∈ Ioo a b := ⟨by linarith, by linarith⟩
    have h2 : (a + b) / 2 - π / 2 + π ∈ Ioo a b := ⟨by linarith, by linarith⟩
    have h3 : ‖p ((a + b) / 2 - π / 2 + π) - p ((a + b) / 2 - π / 2)‖ = 2 := by
      simp only [hp, hepi]
      rw [show y + -e ((a + b) / 2 - π / 2) - (y + e ((a + b) / 2 - π / 2)) = -(2 * e ((a + b) / 2 - π / 2)) by ring,
        norm_neg, norm_mul, norm_e, mul_one]; norm_num
    have h4 := norm_sub_le_norm_sub_add_norm_sub (p ((a + b) / 2 - π / 2 + π)) v (p ((a + b) / 2 - π / 2))
    have h5 := hin _ h1
    have h6 := hin _ h2
    simp only [hf] at h5 h6
    rw [norm_sub_rev v] at h4
    linarith
  -- the chord: `2 sin h ≤ 2 r₁`, `h = (b − a)/2`
  obtain ⟨θa, hθa, hpa⟩ := hend a (Or.inl rfl)
  obtain ⟨θb, hθb, hpb⟩ := hend b (Or.inr rfl)
  have hh0 : 0 < (b - a) / 2 := by linarith
  have hhπ : (b - a) / 2 ≤ π / 2 := by linarith
  have hsinh0 : 0 < Real.sin ((b - a) / 2) := Real.sin_pos_of_pos_of_lt_pi hh0 (by linarith)
  have hcosh0 : 0 ≤ Real.cos ((b - a) / 2) := Real.cos_nonneg_of_mem_Icc ⟨by linarith, hhπ⟩
  have hchord : Real.sin ((b - a) / 2) ≤ r₁ := by
    have e1 : p b - p a = -(e a * (1 - e (2 * ((b - a) / 2)))) := by
      simp only [hp]
      rw [show 2 * ((b - a) / 2) = b - a by ring, mul_sub, mul_one, ← e_add, show a + (b - a) = b by ring]
      ring
    have e2 : ‖p b - p a‖ = 2 * Real.sin ((b - a) / 2) := by
      rw [e1, norm_neg, norm_mul, norm_e, one_mul, one_sub_e_two_mul, norm_mul, norm_e, mul_one, Complex.norm_real,
        Real.norm_eq_abs, abs_of_pos (by positivity)]
    have e3 := norm_sub_le_norm_sub_add_norm_sub (p b) v (p a)
    rw [norm_sub_rev v, e2] at e3
    have : f a + f b = 2 * r₁ := by rw [hfa, hfb]; ring
    simp only [hf] at this
    linarith
  -- the bisector projection: `K + cos (t − β)`
  have hg : ∀ t, ((p t - v) * starRingEnd ℂ (e ((d₁ + d₂) / 2))).re =
      ((y - v) * starRingEnd ℂ (e ((d₁ + d₂) / 2))).re + Real.cos (t - (d₁ + d₂) / 2) := by
    intro t
    simp only [hp]
    rw [show y + e t - v = (y - v) + e t by ring, add_mul, Complex.add_re, ← e_sub_eq, e_eq (t - (d₁ + d₂) / 2)]
    simp only [Complex.add_re, Complex.ofReal_re, Complex.mul_re, Complex.ofReal_im, Complex.I_re, Complex.I_im]
    ring
  have hga : ∀ θ ∈ Icc d₁ d₂, r₁ * γ ≤ ((v + (r₁ : ℂ) * e θ - v) * starRingEnd ℂ (e ((d₁ + d₂) / 2))).re := by
    intro θ hθ
    rw [add_sub_cancel_left, mul_assoc, ← e_sub_eq, e_eq]
    simp only [Complex.mul_re, Complex.ofReal_re, Complex.ofReal_im, Complex.add_re, Complex.add_im, Complex.mul_im,
      Complex.I_re, Complex.I_im]
    have habs : |θ - (d₁ + d₂) / 2| ≤ (d₂ - d₁) / 2 := abs_le.mpr ⟨by linarith [hθ.1], by linarith [hθ.2]⟩
    have hc := Real.cos_le_cos_of_nonneg_of_le_pi (abs_nonneg _) (by linarith) habs
    rw [Real.cos_abs, hγdef] at hc
    nlinarith
  have hKa := hga θa hθa
  have hKb := hga θb hθb
  rw [← hpa, hg] at hKa
  rw [← hpb, hg] at hKb
  have hKz : ((y - v) * starRingEnd ℂ (e ((d₁ + d₂) / 2))).re + Real.cos (tz - (d₁ + d₂) / 2) ≤ s₀ := by
    rw [← hg, htz]
    calc _ ≤ ‖(v + (s₀ : ℂ) * e θ₀ - v) * starRingEnd ℂ (e ((d₁ + d₂) / 2))‖ := Complex.re_le_norm _
      _ = s₀ := by rw [norm_mul, Complex.norm_conj, norm_e, mul_one, hzv]
  generalize ((y - v) * starRingEnd ℂ (e ((d₁ + d₂) / 2))).re = K at hKa hKb hKz
  -- the sinusoid lies above its chord, up to the sagitta `1 − cos h ≤ sin² h ≤ r₁²`
  set u := tz - (a + b) / 2 with hu
  set h := (b - a) / 2 with hh
  set m := (a + b) / 2 - (d₁ + d₂) / 2 with hm
  have ha' : a - (d₁ + d₂) / 2 = m - h := by rw [hm, hh]; ring
  have hb' : b - (d₁ + d₂) / 2 = m + h := by rw [hm, hh]; ring
  have hz' : tz - (d₁ + d₂) / 2 = m + u := by rw [hm, hu]; ring
  rw [ha', Real.cos_sub] at hKa
  rw [hb', Real.cos_add] at hKb
  rw [hz', Real.cos_add] at hKz
  have hu1 : |u| ≤ h := abs_le.mpr ⟨by rw [hu, hh]; linarith, by rw [hu, hh]; linarith⟩
  have hcu : Real.cos h ≤ Real.cos u := by
    have := Real.cos_le_cos_of_nonneg_of_le_pi (abs_nonneg u) (by linarith) hu1
    rwa [Real.cos_abs] at this
  have hsu : |Real.sin u| ≤ Real.sin h := by
    have h1 : Real.sin u ^ 2 ≤ Real.sin h ^ 2 := by
      have e1 := Real.sin_sq_add_cos_sq u
      have e2 := Real.sin_sq_add_cos_sq h
      have e3 := pow_le_pow_left₀ hcosh0 hcu 2
      linarith
    exact abs_le_of_sq_le_sq' h1 hsinh0.le |> fun h2 => abs_le.mpr h2
  have hC1 := Real.neg_one_le_cos m
  have hC2 := Real.cos_le_one m
  have hcu1 := Real.cos_le_one u
  have hsag : 1 - Real.cos h ≤ r₁ ^ 2 := by
    have e1 := Real.sin_sq_add_cos_sq h
    have e2 := mul_nonneg hcosh0 (sub_nonneg.mpr (Real.cos_le_one h))
    have e3 := pow_le_pow_left₀ hsinh0.le hchord 2
    have e4 : Real.cos h * (1 - Real.cos h) = Real.cos h - Real.cos h ^ 2 := by ring
    linarith
  have hkey : K + Real.cos m * Real.cos h - |Real.sin m| * Real.sin h ≥ r₁ * γ := by
    rcases le_total 0 (Real.sin m) with hs | hs
    · rw [abs_of_nonneg hs]; linarith
    · rw [abs_of_nonpos hs]; linarith
  have hprod : Real.sin m * Real.sin u ≤ |Real.sin m| * Real.sin h := by
    calc Real.sin m * Real.sin u ≤ |Real.sin m * Real.sin u| := le_abs_self _
      _ = |Real.sin m| * |Real.sin u| := abs_mul _ _
      _ ≤ |Real.sin m| * Real.sin h := mul_le_mul_of_nonneg_left hsu (abs_nonneg _)
  have hcm : Real.cos m * Real.cos u - Real.cos m * Real.cos h ≥ -(Real.cos u - Real.cos h) := by
    have e1 := mul_nonneg (show 0 ≤ Real.cos m + 1 by linarith) (sub_nonneg.mpr hcu)
    have e2 : (Real.cos m + 1) * (Real.cos u - Real.cos h) =
        Real.cos m * Real.cos u - Real.cos m * Real.cos h + (Real.cos u - Real.cos h) := by ring
    linarith
  have hr₁2 : r₁ ^ 2 < r₁ * γ / 2 := by
    have e1 := mul_pos hr₁ (show 0 < γ / 2 - r₁ by linarith)
    have e2 : r₁ * (γ / 2 - r₁) = r₁ * γ / 2 - r₁ ^ 2 := by ring
    linarith
  linarith [hs₀.2]

/-- The boundary of the open annular sector `annSector v 0 ρ d₁ d₂`: its two edges and its outer arc. -/
noncomputable def wedgeArcs (v : ℂ) (ρ d₁ d₂ : ℝ) : Set Arc :=
  {Arc.seg v (v + (ρ : ℂ) * e d₁), Arc.seg v (v + (ρ : ℂ) * e d₂), Arc.circ v ρ d₁ d₂}

/-- The wedge's arcs have positive length. -/
theorem wedgeArcs_nondegenerate {v : ℂ} {ρ d₁ d₂ : ℝ} (hρ : 0 < ρ) (hd : d₁ < d₂) (hd2 : d₂ ≤ d₁ + 2 * π) :
    ∀ a ∈ wedgeArcs v ρ d₁ d₂, a.Nondegenerate := by
  have hseg : ∀ d : ℝ, v ≠ v + (ρ : ℂ) * e d := fun d h => by
    have : (ρ : ℂ) * e d = 0 := by linear_combination -h
    rcases mul_eq_zero.mp this with h1 | h1
    · exact hρ.ne' (by exact_mod_cast h1)
    · exact e_ne_zero _ h1
  intro a ha
  simp only [wedgeArcs, mem_insert_iff, mem_singleton_iff] at ha
  rcases ha with rfl | rfl | rfl
  · exact hseg d₁
  · exact hseg d₂
  · exact ⟨hρ, hd, hd2⟩

/-- The wedge's arcs lie in the polar image of its closed radii and closed angles. -/
theorem wedgeArcs_subset_polar {v : ℂ} {ρ d₁ d₂ : ℝ} (hρ : 0 < ρ) (hd : d₁ ≤ d₂) :
    ⋃ a ∈ wedgeArcs v ρ d₁ d₂, a.carrier ⊆ (fun q : ℝ × ℝ => v + (q.1 : ℂ) * e q.2) '' (Icc 0 ρ ×ˢ Icc d₁ d₂) := by
  refine iUnion₂_subset fun a ha => ?_
  have hseg : ∀ d ∈ Icc d₁ d₂, segment ℝ v (v + (ρ : ℂ) * e d) ⊆
      (fun q : ℝ × ℝ => v + (q.1 : ℂ) * e q.2) '' (Icc 0 ρ ×ˢ Icc d₁ d₂) := by
    rintro d hd' _ ⟨a', b', ha', hb', hab, rfl⟩
    refine ⟨(b' * ρ, d), ⟨⟨by positivity, by nlinarith⟩, hd'⟩, ?_⟩
    simp only [Complex.real_smul]
    rw [show (a' : ℂ) = 1 - b' by rw [show a' = 1 - b' by linarith]; push_cast; ring]
    push_cast; ring
  simp only [wedgeArcs, mem_insert_iff, mem_singleton_iff] at ha
  rcases ha with rfl | rfl | rfl
  · exact hseg d₁ ⟨le_rfl, hd⟩
  · exact hseg d₂ ⟨hd, le_rfl⟩
  · rintro _ ⟨θ, hθ, rfl⟩
    exact ⟨(ρ, θ), ⟨⟨hρ.le, le_rfl⟩, hθ⟩, rfl⟩

/-- A point at a direction in `(d₂, d₁ + 2π)` is off the polar image of `[0, ρ] × [d₁, d₂]`. -/
theorem polar_notMem {v : ℂ} {ρ d₁ d₂ s θ : ℝ} (hs : 0 < s) (hθ : θ ∈ Ioo d₂ (d₁ + 2 * π)) :
    v + (s : ℂ) * e θ ∉ (fun q : ℝ × ℝ => v + (q.1 : ℂ) * e q.2) '' (Icc 0 ρ ×ˢ Icc d₁ d₂) := by
  rintro ⟨⟨s', θ'⟩, ⟨hs', hθ'⟩, h⟩
  simp only at h hs' hθ'
  exact e_ne_e_of_lt (show θ' < θ by linarith [hθ.1, hθ'.2]) (by linarith [hθ.2, hθ'.1])
    (polar_inj hs hs'.1 h.symm).2.symm

/-- The open wedge meets none of its arcs. -/
theorem annSector_notMem_wedgeArcs {v : ℂ} {ρ d₁ d₂ : ℝ} (hd2 : d₂ ≤ d₁ + 2 * π) {z : ℂ}
    (hz : z ∈ annSector v 0 ρ d₁ d₂) : z ∉ ⋃ a ∈ wedgeArcs v ρ d₁ d₂, a.carrier := by
  obtain ⟨⟨s, θ⟩, ⟨hs, hθ⟩, rfl⟩ := hz
  simp only at hs hθ
  intro h
  obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp h
  have hseg : ∀ d : ℝ, v + (s : ℂ) * e θ ∈ segment ℝ v (v + (ρ : ℂ) * e d) → e θ = e d := by
    rintro d ⟨a', b', ha', hb', hab, he⟩
    have he' : v + (s : ℂ) * e θ = v + ((b' * ρ : ℝ) : ℂ) * e d := by
      rw [← he]; simp only [Complex.real_smul]
      rw [show (a' : ℂ) = 1 - b' by rw [show a' = 1 - b' by linarith]; push_cast; ring]
      push_cast; ring
    exact (polar_inj hs.1 (by have := hs.1; nlinarith [hs.2]) he').2
  simp only [wedgeArcs, mem_insert_iff, mem_singleton_iff] at ha
  rcases ha with rfl | rfl | rfl
  · exact e_ne_e_of_lt hθ.1 (by linarith [hθ.2]) (hseg d₁ hza).symm
  · exact e_ne_e_of_lt (show θ < d₂ from hθ.2) (by linarith [hθ.1]) (hseg d₂ hza)
  · obtain ⟨θ', -, h'⟩ := hza
    have := (polar_inj hs.1 (le_of_lt (hs.1.trans hs.2)) h'.symm).1
    linarith [hs.2]

/-- The frontier of the open annular sector lies on its two edges and its outer arc. -/
theorem frontier_annSector_subset {v : ℂ} {ρ d₁ d₂ : ℝ} (hρ : 0 < ρ) (hd : d₁ < d₂) (hd2 : d₂ ≤ d₁ + 2 * π) :
    frontier (annSector v 0 ρ d₁ d₂) ⊆ ⋃ a ∈ wedgeArcs v ρ d₁ d₂, a.carrier := by
  have _ := hd2
  intro z hz
  rw [(isOpen_annSector v le_rfl ρ d₁ d₂).frontier_eq] at hz
  obtain ⟨hzc, hzW⟩ := hz
  obtain ⟨⟨s, θ⟩, ⟨hs, hθ⟩, rfl⟩ := closure_annSector_subset v hρ.le hd.le hzc
  simp only at hs hθ hzW ⊢
  by_cases h0 : s = 0
  · subst h0
    refine mem_iUnion₂.mpr ⟨_, Or.inl rfl, ?_⟩
    simp only [Complex.ofReal_zero, zero_mul, add_zero]
    exact left_mem_segment ℝ _ _
  by_cases hρs : s = ρ
  · subst hρs
    exact mem_iUnion₂.mpr ⟨_, Or.inr (Or.inr rfl), ⟨θ, hθ, rfl⟩⟩
  by_cases h1 : θ = d₁
  · subst h1
    exact mem_iUnion₂.mpr ⟨_, Or.inl rfl, mem_segment_ray hρ hs.1 hs.2 _⟩
  by_cases h2 : θ = d₂
  · subst h2
    exact mem_iUnion₂.mpr ⟨_, Or.inr (Or.inl rfl), mem_segment_ray hρ hs.1 hs.2 _⟩
  exact absurd ⟨(s, θ), ⟨⟨lt_of_le_of_ne hs.1 (Ne.symm h0), lt_of_le_of_ne hs.2 hρs⟩,
    ⟨lt_of_le_of_ne hθ.1 (Ne.symm h1), lt_of_le_of_ne hθ.2 h2⟩⟩, rfl⟩ hzW

namespace ArcMap

variable {k : ℕ}

/-! ## Recolouring a set bounded by new arcs -/

/-- **Recolouring** `W` with the colour `c`: the arcs of `F` and the finitely many arcs `B`, which carry the frontier of `W`; the colour `c` on
`W` and `F`'s colour elsewhere. The colour is locally constant off the arcs because a point off `frontier W` lies in the interior of `W` or of
its complement. -/
noncomputable def recolour (F : ArcMap k) (W : Set ℂ) (B : Set Arc) (hB : ∀ a ∈ B, a.Nondegenerate) (hBf : B.Finite)
    (hW : frontier W ⊆ ⋃ a ∈ B, a.carrier) (c : Fin k) : ArcMap k where
  dom := F.dom
  isOpen_dom := F.isOpen_dom
  arcs := F.arcs ∪ B
  nondegenerate := fun a ha => ha.elim (F.nondegenerate a) (hB a)
  locallyFinite := fun x hx => by
    obtain ⟨t, ht, hfin⟩ := F.locallyFinite x hx
    refine ⟨t, ht, (hfin.union hBf).subset ?_⟩
    rintro a ⟨ha | ha, hne⟩
    · exact Or.inl ⟨ha, hne⟩
    · exact Or.inr ha
  col := by classical exact fun z => if z ∈ W then c else F.col z
  locallyConstant := by
    classical
    intro x hx hxΓ
    have hxF : x ∉ ⋃ a ∈ F.arcs, a.carrier := fun h => hxΓ (by
      obtain ⟨a, ha, hxa⟩ := mem_iUnion₂.mp h
      exact mem_iUnion₂.mpr ⟨a, Or.inl ha, hxa⟩)
    have hxW : x ∉ frontier W := fun h => hxΓ (by
      obtain ⟨a, ha, hxa⟩ := mem_iUnion₂.mp (hW h)
      exact mem_iUnion₂.mpr ⟨a, Or.inr ha, hxa⟩)
    by_cases hx' : x ∈ W
    · have hint : x ∈ interior W := by
        by_contra hni
        exact hxW ⟨subset_closure hx', hni⟩
      filter_upwards [mem_interior_iff_mem_nhds.mp hint] with y hy
      simp [hy, hx']
    · have hcl : x ∉ closure W := fun h => hxW ⟨h, fun hi => hx' (interior_subset hi)⟩
      filter_upwards [isClosed_closure.isOpen_compl.mem_nhds hcl, F.locallyConstant x hx hxF] with y hy hyc
      have hyW : y ∉ W := fun h => hy (subset_closure h)
      simp [hyW, hx', hyc]

variable {F : ArcMap k} {W : Set ℂ} {B : Set Arc} {hB : ∀ a ∈ B, a.Nondegenerate} {hBf : B.Finite}
  {hW : frontier W ⊆ ⋃ a ∈ B, a.carrier} {c : Fin k}

/-- Recolouring keeps the domain, so a map of the plane stays one. -/
theorem recolour_isPlaneMap (hP : F.IsPlaneMap) : (F.recolour W B hB hBf hW c).IsPlaneMap := hP

/-- The interior points of the recoloured map are interior points of `F` (the arcs only grow). -/
theorem interiorPts_recolour_subset : (F.recolour W B hB hBf hW c).interiorPts ⊆ F.interiorPts := by
  rintro x ⟨hx, hxΓ⟩
  exact ⟨hx, fun h => hxΓ (by
    obtain ⟨a, ha, hxa⟩ := mem_iUnion₂.mp h
    exact mem_iUnion₂.mpr ⟨a, Or.inl ha, hxa⟩)⟩

/-- **Validity of a recolouring** is a statement about `W`: no unit pair inside `W`, and none between `W` and `F`'s class of `c`. -/
theorem recolour_valid (hF : F.Valid) (hWW : ∀ x ∈ W, ∀ y ∈ W, dist x y ≠ 1)
    (hWc : ∀ x ∈ W, ∀ y ∈ F.region c, dist x y ≠ 1) : (F.recolour W B hB hBf hW c).Valid := by
  classical
  intro x hx y hy hxy
  have hx' := interiorPts_recolour_subset hx
  have hy' := interiorPts_recolour_subset hy
  change (if x ∈ W then c else F.col x) ≠ (if y ∈ W then c else F.col y)
  split_ifs with h1 h2 h2
  · exact absurd hxy (hWW x h1 y h2)
  · intro hc
    exact hWc x h1 y ⟨hy', hc.symm⟩ hxy
  · intro hc
    exact hWc y h2 x ⟨hx', hc⟩ (by rw [dist_comm]; exact hxy)
  · exact hF x hx' y hy' hxy

/-- **Condition 5 is kept** when no new arc meets a unit circle in infinitely many points. -/
theorem recolour_condition5 (h5 : F.Condition5) (hB5 : ∀ a ∈ B, ∀ p, (a.carrier ∩ sphere p 1).Finite) :
    (F.recolour W B hB hBf hW c).Condition5 := by
  rintro a (ha | ha) p
  · exact h5 a ha p
  · exact (hB5 a ha p).subset fun z hz => ⟨hz.1.1, hz.2⟩

/-- **Off `closure W` and the new arcs, the regions are unchanged.** -/
theorem recolour_region_diff (j : Fin k) :
    (F.recolour W B hB hBf hW c).region j \ (closure W ∪ ⋃ a ∈ B, a.carrier) =
      F.region j \ (closure W ∪ ⋃ a ∈ B, a.carrier) := by
  classical
  ext z
  simp only [Set.mem_sdiff, mem_union, not_or]
  constructor
  · rintro ⟨⟨⟨hzd, hzΓ⟩, hcol⟩, hcl, hB'⟩
    have hzW : z ∉ W := fun h => hcl (subset_closure h)
    refine ⟨⟨⟨hzd, fun h => hzΓ ?_⟩, ?_⟩, hcl, hB'⟩
    · obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp h
      exact mem_iUnion₂.mpr ⟨a, Or.inl ha, hza⟩
    · have : (if z ∈ W then c else F.col z) = j := hcol
      rw [if_neg hzW] at this
      exact this
  · rintro ⟨⟨⟨hzd, hzΓ⟩, hcol⟩, hcl, hB'⟩
    have hzW : z ∉ W := fun h => hcl (subset_closure h)
    refine ⟨⟨⟨hzd, fun h => ?_⟩, ?_⟩, hcl, hB'⟩
    · obtain ⟨a, ha | ha, hza⟩ := mem_iUnion₂.mp h
      · exact hzΓ (mem_iUnion₂.mpr ⟨a, ha, hza⟩)
      · exact hB' (mem_iUnion₂.mpr ⟨a, ha, hza⟩)
    · show (if z ∈ W then c else F.col z) = j
      rw [if_neg hzW]
      exact hcol

/-! ## The merge at a wedge -/

/-- **The merge at a wedge** (E3-NICE's single merge): `F` recoloured with `c` on the open annular sector of radius `ρ` between the directions
`d₁ < d₂ ≤ d₁ + 2π`, its two edges and its outer arc added to the arcs. -/
noncomputable def wedgeMerge (F : ArcMap k) (v : ℂ) {ρ d₁ d₂ : ℝ} (hρ : 0 < ρ) (hd : d₁ < d₂) (hd2 : d₂ ≤ d₁ + 2 * π)
    (c : Fin k) : ArcMap k :=
  F.recolour (annSector v 0 ρ d₁ d₂) (wedgeArcs v ρ d₁ d₂) (wedgeArcs_nondegenerate hρ hd hd2)
    (((finite_singleton _).insert _).insert _) (frontier_annSector_subset hρ hd hd2) c

/-- **The merge at a wedge is valid** (E3-W): the two edges in the closure of `F`'s class of `c`, less than `π` apart, and the radius within
E3-W's bound. -/
theorem wedgeMerge_valid (hF : F.Valid) {v : ℂ} {ρ d₁ d₂ r₁ : ℝ} (hρ : 0 < ρ) (hd : d₁ < d₂) (hπ : d₂ - d₁ < π) (hr₁ : 0 < r₁)
    (hr₁c : r₁ < Real.cos ((d₂ - d₁) / 2) / 2) (hρr : ρ ≤ r₁ * Real.cos ((d₂ - d₁) / 2) / 2)
    (hseg : ∀ s ∈ Ioo 0 r₁, v + (s : ℂ) * e d₁ ∈ closure (F.region c) ∧ v + (s : ℂ) * e d₂ ∈ closure (F.region c)) :
    (F.wedgeMerge v hρ hd (by linarith [Real.pi_pos]) c).Valid := by
  have hcos : Real.cos ((d₂ - d₁) / 2) ≤ 1 := Real.cos_le_one _
  have hcos0 : 0 < Real.cos ((d₂ - d₁) / 2) := Real.cos_pos_of_mem_Ioo ⟨by linarith [Real.pi_pos], by linarith⟩
  have hρ4 : ρ < 1 / 4 := by nlinarith
  refine recolour_valid hF (fun x hx y hy hxy => ?_) (fun x hx y hy => ?_)
  · have h1 := annSector_subset_ball v le_rfl ρ d₁ d₂ hx
    have h2 := annSector_subset_ball v le_rfl ρ d₁ d₂ hy
    rw [mem_ball] at h1 h2
    have := dist_triangle_right x y v
    linarith
  · exact clear_wedge (F.isOpen_region c) (hF.unitPairsNull_region c) hd hπ hr₁ hr₁c hseg x
      (annSector_mono_r₂ v hρr hx) y hy

/-- **The merge at a wedge keeps Condition 5**: its new arcs are two segments and an arc of radius `ρ < 1`. -/
theorem wedgeMerge_condition5 (h5 : F.Condition5) {v : ℂ} {ρ d₁ d₂ : ℝ} (hρ : 0 < ρ) (hρ1 : ρ < 1) (hd : d₁ < d₂)
    (hd2 : d₂ ≤ d₁ + 2 * π) : (F.wedgeMerge v hρ hd hd2 c).Condition5 := by
  refine recolour_condition5 h5 fun a ha p => ?_
  rcases Arc.finite_inter_sphere_or_eq_circ a (wedgeArcs_nondegenerate hρ hd hd2 a ha) p with h | ⟨θ₀, θ₁, rfl⟩
  · exact h
  · exfalso
    simp only [wedgeArcs, mem_insert_iff, mem_singleton_iff] at ha
    rcases ha with h | h | h
    · exact Arc.noConfusion h
    · exact Arc.noConfusion h
    · injection h with _ h1
      linarith

/-- **The merge at a wedge changes nothing off `closedBall v ρ`.** -/
theorem wedgeMerge_region_diff {v : ℂ} {ρ d₁ d₂ : ℝ} (hρ : 0 < ρ) (hd : d₁ < d₂) (hd2 : d₂ ≤ d₁ + 2 * π) (j : Fin k) :
    (F.wedgeMerge v hρ hd hd2 c).region j \ closedBall v ρ = F.region j \ closedBall v ρ := by
  have hX : closure (annSector v 0 ρ d₁ d₂) ∪ ⋃ a ∈ wedgeArcs v ρ d₁ d₂, a.carrier ⊆ closedBall v ρ := by
    refine union_subset (closure_minimal ((annSector_subset_ball v le_rfl ρ d₁ d₂).trans ball_subset_closedBall)
      isClosed_closedBall) (iUnion₂_subset fun a ha => ?_)
    have hend : ∀ d : ℝ, v + (ρ : ℂ) * e d ∈ closedBall v ρ := fun d => by
      rw [mem_closedBall, dist_eq_norm, add_sub_cancel_left, norm_real_mul_e hρ.le]
    simp only [wedgeArcs, mem_insert_iff, mem_singleton_iff] at ha
    rcases ha with rfl | rfl | rfl
    · exact (convex_closedBall v ρ).segment_subset (mem_closedBall_self hρ.le) (hend d₁)
    · exact (convex_closedBall v ρ).segment_subset (mem_closedBall_self hρ.le) (hend d₂)
    · rintro _ ⟨θ, -, rfl⟩; exact hend θ
  have key := recolour_region_diff (F := F) (W := annSector v 0 ρ d₁ d₂) (B := wedgeArcs v ρ d₁ d₂)
    (hB := wedgeArcs_nondegenerate hρ hd hd2) (hBf := ((finite_singleton _).insert _).insert _)
    (hW := frontier_annSector_subset hρ hd hd2) (c := c) j
  have e1 : ∀ A : Set ℂ, A \ closedBall v ρ =
      (A \ (closure (annSector v 0 ρ d₁ d₂) ∪ ⋃ a ∈ wedgeArcs v ρ d₁ d₂, a.carrier)) \ closedBall v ρ := fun A => by
    ext z
    simp only [Set.mem_sdiff]
    exact ⟨fun h => ⟨⟨h.1, fun h' => h.2 (hX h')⟩, h.2⟩, fun h => ⟨h.1.1, h.2⟩⟩
  rw [e1, e1 (F.region j)]
  exact congrArg (· \ closedBall v ρ) key

/-! ## Locality -/

/-- **The colours at a point depend only on the regions near it.** -/
theorem coloursAt_congr {F F' : ArcMap k} {w : ℂ} {U : Set ℂ} (hU : U ∈ 𝓝 w)
    (h : ∀ j, F.region j ∩ U = F'.region j ∩ U) : F.coloursAt w = F'.coloursAt w := by
  have key : ∀ S : Set ℂ, w ∈ closure S ↔ w ∈ closure (S ∩ U) := fun S => by
    refine ⟨fun hS => ?_, fun hS => closure_mono inter_subset_left hS⟩
    rw [mem_closure_iff_nhds] at hS ⊢
    intro t ht
    obtain ⟨y, hy1, hy2⟩ := hS (t ∩ U) (inter_mem ht hU)
    exact ⟨y, hy1.1, hy2, hy1.2⟩
  ext j
  simp only [coloursAt, mem_setOf_eq]
  rw [key, h j, ← key]

/-- **`NiceAt` depends only on the regions near the point** (and on its being in the domain): pictures read cones, and cones are local. -/
theorem niceAt_congr {F F' : ArcMap k} {w : ℂ} {U : Set ℂ} (hU : U ∈ 𝓝 w) (hdom : w ∈ F.dom ↔ w ∈ F'.dom)
    (h : ∀ j, F.region j ∩ U = F'.region j ∩ U) : F.NiceAt w ↔ F'.NiceAt w := by
  obtain ⟨r, hr, hrU⟩ := Metric.mem_nhds_iff.mp hU
  have key : ∀ S : Set ℂ, coneAt S w = coneAt (S ∩ U) w := fun S =>
    Subset.antisymm (fun β hβ => coneAt_mono (inter_subset_inter_right S hrU) w (coneAt_inter_ball hr hβ))
      (coneAt_mono inter_subset_left w)
  have hcone : ∀ j, coneAt (F.region j) w = coneAt (F'.region j) w := fun j => by rw [key, h j, ← key]
  have hS : ∀ n d c, F.SectorsAt w n d c ↔ F'.SectorsAt w n d c := fun n d c => by
    simp only [SectorsAt, hcone, hdom]
  simp only [NiceAt, hS]

/-! ## The local data at a point -/

/-- **The local data at `v`**: off the finitely many directions `D` (mod `2π`), a thin open cone about each direction `φ` lies in the colour
class `σ φ`. With `D` the tangent directions at `v` of the arcs through `v`, wave 3's wedge lemma gives it at every point of the domain
(`exists_dirColourAt`). `D` may hold invisible directions (an arc between two sides of one colour); the colour classes' cones off `D` are read
from `σ` alone. -/
def DirColourAt (F : ArcMap k) (v : ℂ) (D : Finset ℝ) (σ : ℝ → Fin k) : Prop :=
  ∀ φ : ℝ, OffDirs D φ → ∃ r > 0, annSector v 0 r (φ - r) (φ + r) ⊆ F.region (σ φ)

/-- Spec example: the one-colour plane has the local data `D = ∅`, `σ = 0` at every point. -/
example (v : ℂ) : (ArcMap.const univ isOpen_univ (0 : Fin 1)).DirColourAt v ∅ fun _ => 0 :=
  fun _ _ => ⟨1, one_pos, fun _ _ => ⟨by simp, rfl⟩⟩

/-- **The local data exists at every point of the domain** — from `exists_goodAt` and `GoodAt.exists_wedge` (wave 3, landed); no
`localSectors`. -/
theorem exists_dirColourAt {v : ℂ} (hv : v ∈ F.dom) : ∃ (D : Finset ℝ) (σ : ℝ → Fin k), F.DirColourAt v D σ := by
  classical
  obtain ⟨ρ₀, hG⟩ := F.exists_goodAt hv
  set 𝒜 := {a | a ∈ F.arcs ∧ (a.carrier ∩ ball v ρ₀).Nonempty} with h𝒜
  -- the unit vectors tangent at `v` to an arc of the good ball: finitely many
  set M : Set ℂ := ⋃ a ∈ 𝒜, {m : ℂ | m.re * (a.curveData v).2.re + m.im * (a.curveData v).2.im = 0 ∧
    m.re ^ 2 + m.im ^ 2 = 1} with hM
  have hMfin : M.Finite := hG.fin.biUnion fun a ha =>
    finite_perp_circle _ (Arc.curveData_ne (F.nondegenerate a ha.1) (hG.through a ha.1 ha.2)) 0 1
  refine ⟨hMfin.toFinset.image Complex.arg, ?_⟩
  have hgen : ∀ φ : ℝ, OffDirs (hMfin.toFinset.image Complex.arg) φ → ∀ a ∈ F.arcs,
      (a.carrier ∩ ball v ρ₀).Nonempty → ¬ a.Tang v (e φ) := by
    intro φ hφ a ha hne hT
    have hmem : e φ ∈ M := by
      refine mem_iUnion₂.mpr ⟨a, ⟨ha, hne⟩, ?_, ?_⟩
      · have : ((a.curveData v).2 * (starRingEnd ℂ) (e φ)).re = 0 := hT
        simpa [Complex.mul_re, mul_comm] using this
      · have := norm_e φ
        have h := Complex.sq_norm (e φ)
        rw [Complex.normSq_apply, this] at h
        nlinarith
    have harg : e (Complex.arg (e φ)) = e φ := by
      have h := Complex.norm_mul_exp_arg_mul_I (e φ)
      rw [norm_e, Complex.ofReal_one, one_mul] at h
      exact h
    obtain ⟨n, hn⟩ := e_eq_e_iff.mp harg.symm
    exact hφ _ (Finset.mem_image.mpr ⟨e φ, hMfin.mem_toFinset.mpr hmem, rfl⟩) n (hn.trans (by ring))
  have hex : ∀ φ : ℝ, OffDirs (hMfin.toFinset.image Complex.arg) φ →
      ∃ g : Fin k, ∃ r > 0, annSector v 0 r (φ - r) (φ + r) ⊆ F.region g := by
    intro φ hφ
    have hu : ‖e φ‖ = 1 := norm_e φ
    obtain ⟨m, hm0, N₀, hN₀, hN⟩ := hG.exists_wedge hu
    set N := max N₀ 1 with hNdef
    have hN0 : 0 < N := lt_max_of_lt_right one_pos
    obtain ⟨hball, hΓ⟩ := hN N (le_max_left _ _)
    have hI : Rgn v (e φ) N m ⊆ F.interiorPts := by
      intro w hw
      refine ⟨hG.subdom (hball hw), fun hwa => ?_⟩
      obtain ⟨a', ha', hwa'⟩ := mem_iUnion₂.mp hwa
      obtain ⟨-, hT⟩ := hΓ w hw a' ha' hwa'
      exact hgen φ hφ a' ha' ⟨w, hwa', hball hw⟩ hT
    have hpre : IsPreconnected (Rgn v (e φ) N m) := by
      have := isPreconnected_Rgn_lev (y := v) hu hN0 1 (I := Set.univ) ordConnected_univ (m := m)
      simpa using this
    set r := min (1 / 2) (min (1 / (2 * N)) (m / 2)) with hr
    have hr0 : 0 < r := by positivity
    have hr1 : r ≤ 1 / 2 := min_le_left _ _
    have hr2 : r ≤ 1 / (2 * N) := (min_le_right _ _).trans (min_le_left _ _)
    have hr3 : r ≤ m / 2 := (min_le_right _ _).trans (min_le_right _ _)
    have hsub : annSector v 0 r (φ - r) (φ + r) ⊆ Rgn v (e φ) N m := by
      rintro _ ⟨⟨s, θ⟩, ⟨hs, hθ⟩, rfl⟩
      simp only at hs hθ
      have hrot : rotD v (e φ) (v + (s : ℂ) * e θ) = (s : ℂ) * e (θ - φ) := by
        unfold rotD; rw [e_sub_eq]; ring
      have ht : |θ - φ| < r := abs_sub_lt_iff.mpr ⟨by linarith [hθ.2], by linarith [hθ.1]⟩
      have hcos : 1 / 2 < Real.cos (θ - φ) := by
        have h1 := Real.one_sub_sq_div_two_le_cos (x := θ - φ)
        have h2 : (θ - φ) ^ 2 < 1 / 4 := by
          have := sq_abs (θ - φ); nlinarith [abs_nonneg (θ - φ)]
        linarith
      have hsin : |Real.sin (θ - φ)| < m / 2 := lt_of_le_of_lt Real.abs_sin_le_abs (ht.trans_le hr3)
      have hre : ((s : ℂ) * e (θ - φ)).re = s * Real.cos (θ - φ) := by
        rw [e_eq]; simp only [Complex.mul_re, Complex.mul_im, Complex.add_re, Complex.add_im, Complex.ofReal_re,
          Complex.ofReal_im, Complex.I_re, Complex.I_im]; ring
      have him : ((s : ℂ) * e (θ - φ)).im = s * Real.sin (θ - φ) := by
        rw [e_eq]; simp only [Complex.mul_re, Complex.mul_im, Complex.add_re, Complex.add_im, Complex.ofReal_re,
          Complex.ofReal_im, Complex.I_re, Complex.I_im]; ring
      have hns : Complex.normSq ((s : ℂ) * e (θ - φ)) = s ^ 2 := by
        rw [Complex.normSq_eq_norm_sq, norm_real_mul_e hs.1.le]
      have hsN : N * s < 1 / 2 := by
        have := hs.2.trans_le hr2
        rw [lt_div_iff₀ (by positivity)] at this; linarith
      show v + (s : ℂ) * e θ ∈ Rgn v (e φ) N m
      refine ⟨fun h => ?_, ?_, ?_⟩
      · have h' : (s : ℂ) * e θ = 0 := by linear_combination h
        rcases mul_eq_zero.mp h' with h1 | h1
        · exact hs.1.ne' (by exact_mod_cast h1)
        · exact e_ne_zero _ h1
      · rw [hrot, hns, hre]; nlinarith [hs.1]
      · rw [hrot, him, hre, abs_mul, abs_of_pos hs.1]
        have : m / 2 < m * Real.cos (θ - φ) := by nlinarith
        nlinarith [hs.1]
    set p := v + ((r / 2 : ℝ) : ℂ) * e φ with hp
    have hpA : p ∈ annSector v 0 r (φ - r) (φ + r) := ⟨(r / 2, φ), ⟨⟨by positivity, by linarith⟩, ⟨by linarith, by linarith⟩⟩, rfl⟩
    have hpI : p ∈ F.interiorPts := hI (hsub hpA)
    have hT : F.IsTile (connectedComponentIn F.interiorPts p) := ⟨p, hpI, rfl⟩
    have hRT := hT.subset_of_preconnected hpre hI (hsub hpA) (mem_connectedComponentIn hpI)
    refine ⟨F.col p, r, hr0, fun w hw => ⟨hI (hsub hw), ?_⟩⟩
    exact hT.col_eq (hRT (hsub hw)) (hRT (hsub hpA))
  haveI : Nonempty (Fin k) := ⟨F.col v⟩
  choose! σ r hr hσ using hex
  exact ⟨σ, fun φ hφ => ⟨r φ, hr φ hφ, hσ φ hφ⟩⟩

/-- **Two preconnected sides bound the colours at a point by two**: if every nonempty open subset of a neighbourhood `N` of `z` meets one
of two preconnected sets of interior points, the colours at `z` are among the colours of those two sets (one each: a preconnected set of
interior points lies in one tile). -/
theorem ncard_coloursAt_le_two_of_sides {z : ℂ} {N N₁ N₂ : Set ℂ} (hN : N ∈ 𝓝 z) (h₁ : IsPreconnected N₁)
    (h₂ : IsPreconnected N₂) (hI₁ : N₁ ⊆ F.interiorPts) (hI₂ : N₂ ⊆ F.interiorPts)
    (hcov : ∀ O : Set ℂ, IsOpen O → O ⊆ N → O.Nonempty → (O ∩ (N₁ ∪ N₂)).Nonempty) : (F.coloursAt z).ncard ≤ 2 := by
  have hsub : F.coloursAt z ⊆ F.col '' N₁ ∪ F.col '' N₂ := by
    intro j hj
    have hO : (F.region j ∩ interior N).Nonempty :=
      (mem_closure_iff.mp hj _ isOpen_interior (mem_interior_iff_mem_nhds.mpr hN)).mono fun y hy => ⟨hy.2, hy.1⟩
    obtain ⟨y, ⟨hyj, -⟩, hy⟩ :=
      hcov _ ((F.isOpen_region j).inter isOpen_interior) (inter_subset_right.trans interior_subset) hO
    rcases hy with hy | hy
    · exact Or.inl ⟨y, hy, hyj.2⟩
    · exact Or.inr ⟨y, hy, hyj.2⟩
  have hone : ∀ {M : Set ℂ}, IsPreconnected M → M ⊆ F.interiorPts → (F.col '' M).ncard ≤ 1 := by
    intro M hM hMI
    refine (Set.ncard_le_one_iff (Set.toFinite _)).mpr ?_
    rintro _ _ ⟨p, hp, rfl⟩ ⟨q, hq, rfl⟩
    have hT : F.IsTile (connectedComponentIn F.interiorPts p) := ⟨p, hMI hp, rfl⟩
    have hs := hT.subset_of_preconnected hM hMI hp (mem_connectedComponentIn (hMI hp))
    exact hT.col_eq (hs hp) (hs hq)
  calc (F.coloursAt z).ncard ≤ (F.col '' N₁ ∪ F.col '' N₂).ncard := Set.ncard_le_ncard hsub
    _ ≤ (F.col '' N₁).ncard + (F.col '' N₂).ncard := Set.ncard_union_le _ _
    _ ≤ 1 + 1 := add_le_add (hone h₁ hI₁) (hone h₂ hI₂)

/-- The circle through `x` about `x + b` is the curve with data `(1, b)`. -/
theorem mem_curveAt_one_iff (x b y : ℂ) : y ∈ curveAt x 1 b ↔ ‖y - (x + b)‖ = ‖b‖ := by
  have h : Complex.normSq (y - (x + b)) = Complex.normSq (y - x) + Complex.normSq b - 2 * ((y - x) * (starRingEnd ℂ) b).re := by
    rw [show y - (x + b) = (y - x) - b by ring, Complex.normSq_sub]
  simp only [curveAt, mem_setOf_eq, one_mul]
  rw [← sq_eq_sq₀ (norm_nonneg _) (norm_nonneg _), ← Complex.normSq_eq_norm_sq, ← Complex.normSq_eq_norm_sq, h]
  constructor <;> intro h' <;> linarith

/-- **In a good ball only the centre carries three colours**: every other point lies on at most one full curve of arcs
(`GoodAt.exists_local_curve`), which it has two sides of. -/
theorem GoodAt.ncard_coloursAt_le_two {x : ℂ} {ρ₀ : ℝ} (hG : F.GoodAt x ρ₀) {z : ℂ} (hz : z ∈ ball x ρ₀) (hzx : z ≠ x) :
    (F.coloursAt z).ncard ≤ 2 := by
  classical
  by_cases hΓ : z ∈ ⋃ a ∈ F.arcs, a.carrier
  · obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp hΓ
    obtain ⟨δ, hδ, hδsub, hcurve⟩ := hG.exists_local_curve hz hzx ha hza
    have hxa : x ∈ a.carrier := hG.through a ha ⟨z, hza, hz⟩
    have hb := Arc.curveData_ne (F.nondegenerate a ha) hxa
    have hzC : z ∈ curveAt x (a.curveData x).1 (a.curveData x).2 := Arc.carrier_subset_curve hxa hza
    have hint : ∀ y ∈ ball z δ, y ∉ curveAt x (a.curveData x).1 (a.curveData x).2 → y ∈ F.interiorPts :=
      fun y hy hyC => ⟨hG.subdom (hδsub hy), fun h => by
        obtain ⟨a', ha', hya'⟩ := mem_iUnion₂.mp h
        exact hyC (hcurve y hy a' ha' hya')⟩
    have hoff := fun O (hO : IsOpen O) (hne : O.Nonempty) =>
      exists_notMem_curveAt (x := x) (Arc.curveData_kappa x a) hb hO hne
    have hκ := Arc.curveData_kappa x a
    generalize (a.curveData x).1 = κ at hκ hzC hint hoff
    generalize (a.curveData x).2 = b at hb hzC hint hoff
    by_cases h0 : κ = 0
    · subst h0
      have hC : ∀ y, y ∈ curveAt x 0 b ↔ (y * (starRingEnd ℂ) b).re = (x * (starRingEnd ℂ) b).re := fun y => by
        simp only [curveAt, mem_setOf_eq, zero_mul, sub_mul, Complex.sub_re]
        constructor <;> intro h <;> linarith
      have hlin : IsLinearMap ℝ fun y : ℂ => (y * (starRingEnd ℂ) b).re :=
        ⟨fun p q => by simp [add_mul], fun r p => by simp [Complex.real_smul, mul_assoc]⟩
      refine ncard_coloursAt_le_two_of_sides (ball_mem_nhds z hδ)
        ((convex_ball z δ).inter (convex_halfSpace_gt hlin (x * (starRingEnd ℂ) b).re)).isPreconnected
        ((convex_ball z δ).inter (convex_halfSpace_lt hlin (x * (starRingEnd ℂ) b).re)).isPreconnected
        (fun y hy => hint y hy.1 fun h => (ne_of_gt hy.2) ((hC y).mp h))
        (fun y hy => hint y hy.1 fun h => (ne_of_lt hy.2) ((hC y).mp h)) fun O hO hON hne => ?_
      obtain ⟨w, hwO, hwC⟩ := hoff O hO hne
      rcases lt_or_gt_of_ne (fun h => hwC ((hC w).mpr h)) with h | h
      · exact ⟨w, hwO, Or.inr ⟨hON hwO, h⟩⟩
      · exact ⟨w, hwO, Or.inl ⟨hON hwO, h⟩⟩
    · -- a circle through `x`: two thin annular sectors about its centre
      obtain rfl : κ = 1 := hκ.resolve_left h0
      have hR0 : 0 < ‖b‖ := norm_pos_iff.mpr hb
      have hC : ∀ y, y ∈ curveAt x 1 b ↔ ‖y - (x + b)‖ = ‖b‖ := fun y => mem_curveAt_one_iff x b y
      have hzpol : z = (x + b) + (‖b‖ : ℂ) * e (0 + Complex.arg ((z - (x + b)) * starRingEnd ℂ (e 0))) := by
        have := eq_add_norm_mul_e (x + b) z 0
        rwa [(hC z).mp hzC] at this
      generalize 0 + Complex.arg ((z - (x + b)) * starRingEnd ℂ (e 0)) = θz at hzpol
      generalize x + b = c at hC hzpol
      generalize ‖b‖ = R at hR0 hC hzpol
      set η := min (R / 2) (δ / (2 * (1 + R))) with hη
      have hη0 : 0 < η := lt_min (by positivity) (by positivity)
      have hηR : η ≤ R / 2 := min_le_left _ _
      have hηδ : η * (2 * (1 + R)) ≤ δ := (le_div_iff₀ (by positivity)).mp (min_le_right _ _)
      have hpol : ∀ s θ : ℝ, 0 ≤ s → ‖c + (s : ℂ) * e θ - c‖ = s := fun s θ hs => by
        rw [add_sub_cancel_left, norm_real_mul_e hs]
      have hNδ : annSector c (R - η) (R + η) (θz - η) (θz + η) ⊆ ball z δ := by
        rintro _ ⟨⟨s, θ⟩, ⟨hs, hθ⟩, rfl⟩
        simp only at hs hθ
        rw [mem_ball, dist_eq_norm, hzpol]
        have h1 : c + (s : ℂ) * e θ - (c + (R : ℂ) * e θz) = ((s - R : ℝ) : ℂ) * e θ + (R : ℂ) * (e θ - e θz) := by
          push_cast; ring
        have h2 : |s - R| < η := abs_sub_lt_iff.mpr ⟨by linarith [hs.2], by linarith [hs.1]⟩
        have h3 : |θ - θz| < η := abs_sub_lt_iff.mpr ⟨by linarith [hθ.2], by linarith [hθ.1]⟩
        have h4 : ‖e θ - e θz‖ ≤ |θ - θz| := norm_e_sub_e_le θ θz
        rw [h1]
        calc ‖((s - R : ℝ) : ℂ) * e θ + (R : ℂ) * (e θ - e θz)‖
            ≤ ‖((s - R : ℝ) : ℂ) * e θ‖ + ‖(R : ℂ) * (e θ - e θz)‖ := norm_add_le _ _
          _ = |s - R| + R * ‖e θ - e θz‖ := by
              rw [norm_mul, norm_mul, norm_e, mul_one, Complex.norm_real, Complex.norm_real, Real.norm_eq_abs,
                Real.norm_eq_abs, abs_of_pos hR0]
          _ < δ := by nlinarith
      have hNopen : IsOpen (annSector c (R - η) (R + η) (θz - η) (θz + η)) := isOpen_annSector c (by linarith) _ _ _
      have hzN : z ∈ annSector c (R - η) (R + η) (θz - η) (θz + η) :=
        ⟨(R, θz), ⟨⟨by linarith, by linarith⟩, ⟨by linarith, by linarith⟩⟩, hzpol.symm⟩
      have hside : ∀ s θ, s ∈ Ioo (R - η) (R + η) → θ ∈ Ioo (θz - η) (θz + η) → s ≠ R →
          c + (s : ℂ) * e θ ∈ F.interiorPts := fun s θ hs hθ hsR =>
        hint _ (hNδ ⟨(s, θ), ⟨hs, hθ⟩, rfl⟩) fun h => hsR (by rw [← (hC _).mp h, hpol s θ (by linarith [hs.1])])
      refine ncard_coloursAt_le_two_of_sides (hNopen.mem_nhds hzN) (isPreconnected_annSector c (R - η) R (θz - η) (θz + η))
        (isPreconnected_annSector c R (R + η) (θz - η) (θz + η)) ?_ ?_ fun O hO hON hne => ?_
      · rintro _ ⟨⟨s, θ⟩, ⟨hs, hθ⟩, rfl⟩
        exact hside s θ ⟨hs.1, by linarith [hs.2]⟩ hθ hs.2.ne
      · rintro _ ⟨⟨s, θ⟩, ⟨hs, hθ⟩, rfl⟩
        exact hside s θ ⟨by linarith [hs.1], hs.2⟩ hθ hs.1.ne'
      · obtain ⟨w, hwO, hwC⟩ := hoff O hO hne
        obtain ⟨⟨s, θ⟩, ⟨hs, hθ⟩, rfl⟩ := hON hwO
        have hsR : s ≠ R := fun h => hwC ((hC _).mpr (by rw [hpol s θ (by linarith [hs.1]), h]))
        rcases lt_or_gt_of_ne hsR with h | h
        · exact ⟨_, hwO, Or.inl ⟨(s, θ), ⟨⟨hs.1, h⟩, hθ⟩, rfl⟩⟩
        · exact ⟨_, hwO, Or.inr ⟨(s, θ), ⟨⟨h, hs.2⟩, hθ⟩, rfl⟩⟩
  · have hzI : z ∈ F.interiorPts := ⟨hG.subdom hz, hΓ⟩
    obtain ⟨r, hr, hrI⟩ := Metric.isOpen_iff.mp F.isOpen_interiorPts z hzI
    exact ncard_coloursAt_le_two_of_sides (ball_mem_nhds z hr) (convex_ball z r).isPreconnected
      (convex_ball z r).isPreconnected hrI hrI fun O _ hON hne => hne.mono fun y hy => ⟨hy, Or.inl (hON hy)⟩

/-- **Points of three or more colours are finite on a compact subset of the domain** (finitely many good balls cover it, each holding at
most its centre). -/
theorem finite_three_le_coloursAt {K : Set ℂ} (hK : IsCompact K) (hKd : K ⊆ F.dom) :
    {v ∈ K | 3 ≤ (F.coloursAt v).ncard}.Finite := by
  classical
  have hex : ∀ x ∈ K, ∃ ρ₀, F.GoodAt x ρ₀ := fun x hx => F.exists_goodAt (hKd hx)
  choose! ρ hρ using hex
  obtain ⟨t, htK, hcov⟩ := hK.elim_nhds_subcover (fun x => ball x (ρ x)) fun x hx => ball_mem_nhds x (hρ x hx).pos
  refine t.finite_toSet.subset ?_
  rintro v ⟨hvK, hv3⟩
  obtain ⟨x, hxt, hvx⟩ := mem_iUnion₂.mp (hcov hvK)
  by_contra hvt
  have hne : v ≠ x := fun h => hvt (h ▸ hxt)
  have := (hρ x (htK x hxt)).ncard_coloursAt_le_two hvx hne
  omega

/-- **The `NiceAt` picture from the local data** (E3-NICE's last paragraph): if every colour's directions off `D` form one arc of the circle
(`hrun`) and no colour's cone meets a direction of `D` strictly inside another colour's arc (`hpoke`), a point of three or more colours is
`NiceAt` — the arcs, in order, are the positive sectors, and at each change of colour the other colours whose cones hold that direction are
horns, each once. -/
theorem niceAt_of_dirColourAt {v : ℂ} (hv : v ∈ F.dom) {D : Finset ℝ} {σ : ℝ → Fin k} (hD : F.DirColourAt v D σ)
    (hrun : ∀ φ₁ φ₂ : ℝ, OffDirs D φ₁ → OffDirs D φ₂ → φ₁ < φ₂ → φ₂ < φ₁ + 2 * π → σ φ₁ = σ φ₂ →
      (∀ φ ∈ Ioo φ₁ φ₂, OffDirs D φ → σ φ = σ φ₁) ∨ (∀ φ ∈ Ioo φ₂ (φ₁ + 2 * π), OffDirs D φ → σ φ = σ φ₁))
    (hpoke : ∀ δ ∈ D, ∀ j c : Fin k, δ ∈ coneAt (F.region j) v →
      (∃ t > 0, ∀ φ ∈ Ioo (δ - t) (δ + t), OffDirs D φ → σ φ = c) → j = c)
    (h3 : 3 ≤ (F.coloursAt v).ncard) : F.NiceAt v := by
  sorry

/-- **The local data after a merge at a wedge**: off `D` and the two edge directions, a direction strictly inside the wedge now carries `c`,
and every other one keeps its colour (for a small enough cone the wedge either contains it or misses it and the new arcs). -/
theorem dirColourAt_wedgeMerge {v : ℂ} {D : Finset ℝ} {σ : ℝ → Fin k} (hD : F.DirColourAt v D σ) {ρ d₁ d₂ : ℝ} (hρ : 0 < ρ)
    (hd : d₁ < d₂) (hd2 : d₂ < d₁ + 2 * π) :
    (F.wedgeMerge v hρ hd hd2.le c).DirColourAt v (insert d₁ (insert d₂ D))
      (fun φ => by classical exact if φ ∈ angleIoo d₁ d₂ then c else σ φ) := by
  classical
  intro φ hφ
  have hφ1 : ∀ m : ℤ, φ ≠ d₁ + 2 * π * m := hφ d₁ (Finset.mem_insert_self _ _)
  have hφ2 : ∀ m : ℤ, φ ≠ d₂ + 2 * π * m := hφ d₂ (Finset.mem_insert_of_mem (Finset.mem_insert_self _ _))
  have hφD : OffDirs D φ := fun δ hδ => hφ δ (Finset.mem_insert_of_mem (Finset.mem_insert_of_mem hδ))
  obtain ⟨r, hr, hsub⟩ := hD φ hφD
  have hπ := Real.pi_pos
  have hmono : ∀ r' ≤ r, annSector v 0 r' (φ - r') (φ + r') ⊆ annSector v 0 r (φ - r) (φ + r) := by
    rintro r' hr' _ ⟨⟨s, θ⟩, ⟨hs, hθ⟩, rfl⟩
    exact ⟨(s, θ), ⟨⟨hs.1, hs.2.trans_le hr'⟩, ⟨by linarith [hθ.1], by linarith [hθ.2]⟩⟩, rfl⟩
  by_cases hin : φ ∈ angleIoo d₁ d₂
  · obtain ⟨m, hm⟩ := mem_iUnion.mp hin
    set r' := min r (min ρ (min (φ - (d₁ + 2 * π * m)) (d₂ + 2 * π * m - φ))) with hr'
    have hr'0 : 0 < r' := lt_min hr (lt_min hρ (lt_min (by linarith [hm.1]) (by linarith [hm.2])))
    have h1 : r' ≤ r := min_le_left _ _
    have h2 : r' ≤ ρ := (min_le_right _ _).trans (min_le_left _ _)
    have h3 : r' ≤ φ - (d₁ + 2 * π * m) := (min_le_right _ _).trans ((min_le_right _ _).trans (min_le_left _ _))
    have h4 : r' ≤ d₂ + 2 * π * m - φ := (min_le_right _ _).trans ((min_le_right _ _).trans (min_le_right _ _))
    refine ⟨r', hr'0, fun w hw => ?_⟩
    have hwF := hsub (hmono r' h1 hw)
    obtain ⟨⟨s, θ⟩, ⟨hs, hθ⟩, rfl⟩ := hw
    simp only at hs hθ hwF ⊢
    have hW : v + (s : ℂ) * e θ ∈ annSector v 0 ρ d₁ d₂ := by
      refine ⟨(s, θ + 2 * π * ((-m : ℤ) : ℝ)), ⟨⟨hs.1, hs.2.trans_le h2⟩, ?_, ?_⟩, ?_⟩
      · push_cast; linarith [hθ.1]
      · push_cast; linarith [hθ.2]
      · simp only [e_add_two_pi_mul_int]
    rw [if_pos hin]
    refine ⟨⟨hwF.1.1, fun h => ?_⟩, ?_⟩
    · obtain ⟨a, ha | ha, hza⟩ := mem_iUnion₂.mp h
      · exact hwF.1.2 (mem_iUnion₂.mpr ⟨a, ha, hza⟩)
      · exact annSector_notMem_wedgeArcs hd2.le hW (mem_iUnion₂.mpr ⟨a, ha, hza⟩)
    · show (if v + (s : ℂ) * e θ ∈ annSector v 0 ρ d₁ d₂ then c else F.col (v + (s : ℂ) * e θ)) = c
      rw [if_pos hW]
  · obtain ⟨n, hn⟩ := exists_shift_Ico d₁ φ
    have hn1 : d₁ < φ + 2 * π * n := lt_of_le_of_ne hn.1 fun h => hφ1 (-n) (by push_cast; linarith)
    have hn2 : d₂ < φ + 2 * π * n := by
      rcases lt_trichotomy (φ + 2 * π * n) d₂ with h | h | h
      · exact absurd (mem_iUnion.mpr ⟨-n, by push_cast; constructor <;> linarith⟩) hin
      · exact absurd (by push_cast; linarith : φ = d₂ + 2 * π * ((-n : ℤ) : ℝ)) (hφ2 (-n))
      · exact h
    set r' := min r (min (φ + 2 * π * n - d₂) (d₁ + 2 * π - (φ + 2 * π * n))) with hr'
    have hr'0 : 0 < r' := lt_min hr (lt_min (by linarith) (by linarith [hn.2]))
    have h1 : r' ≤ r := min_le_left _ _
    have h3 : r' ≤ φ + 2 * π * n - d₂ := (min_le_right _ _).trans (min_le_left _ _)
    have h4 : r' ≤ d₁ + 2 * π - (φ + 2 * π * n) := (min_le_right _ _).trans (min_le_right _ _)
    refine ⟨r', hr'0, fun w hw => ?_⟩
    have hwF := hsub (hmono r' h1 hw)
    obtain ⟨⟨s, θ⟩, ⟨hs, hθ⟩, rfl⟩ := hw
    simp only at hs hθ hwF ⊢
    rw [if_neg hin]
    have hoff : v + (s : ℂ) * e θ ∉ closure (annSector v 0 ρ d₁ d₂) ∪ ⋃ a ∈ wedgeArcs v ρ d₁ d₂, a.carrier := by
      have hP := polar_notMem (v := v) (ρ := ρ) (d₁ := d₁) (d₂ := d₂) hs.1
        (show θ + 2 * π * n ∈ Ioo d₂ (d₁ + 2 * π) from ⟨by linarith [hθ.1], by linarith [hθ.2]⟩)
      rw [e_add_two_pi_mul_int] at hP
      rintro (h | h)
      · exact hP (closure_annSector_subset v hρ.le hd.le h)
      · exact hP (wedgeArcs_subset_polar hρ hd.le h)
    have key := recolour_region_diff (F := F) (W := annSector v 0 ρ d₁ d₂) (B := wedgeArcs v ρ d₁ d₂)
      (hB := wedgeArcs_nondegenerate hρ hd hd2.le) (hBf := ((finite_singleton _).insert _).insert _)
      (hW := frontier_annSector_subset hρ hd hd2.le) (c := c) (σ φ)
    have : v + (s : ℂ) * e θ ∈ F.region (σ φ) \ (closure (annSector v 0 ρ d₁ d₂) ∪ ⋃ a ∈ wedgeArcs v ρ d₁ d₂, a.carrier) :=
      ⟨hwF, hoff⟩
    rw [← key] at this
    exact this.1

/-! ## Cones after a merge (children of `exists_merge_at`'s measure, FS131-IWc) -/

/-- **Cones are local in direction**: a set approaching `v` along `δ` does so inside every thin truncated cone about `δ`. -/
theorem mem_coneAt_inter_annSector {S : Set ℂ} {v : ℂ} {δ : ℝ} (h : δ ∈ coneAt S v) {r η : ℝ} (hr : 0 < r) (hη : 0 < η) :
    δ ∈ coneAt (S ∩ annSector v 0 r (δ - η) (δ + η)) v := by
  have hcont : ContinuousAt Complex.arg 1 := Complex.continuousAt_arg (by simp [Complex.slitPlane])
  obtain ⟨κ, hκ, hball⟩ := Metric.continuousAt_iff.mp hcont η hη
  intro ε hε
  obtain ⟨z, hzS, hzv, hzd, hdir⟩ := h (min ε (min r κ)) (by positivity)
  refine ⟨z, ⟨hzS, ?_⟩, hzv, hzd.trans_le (min_le_left _ _), hdir.trans_le (min_le_left _ _)⟩
  have hn : 0 < ‖z - v‖ := norm_pos_iff.mpr (sub_ne_zero.mpr hzv)
  have hpol := eq_add_norm_mul_e v z δ
  set u := (z - v) / (‖z - v‖ : ℂ) * starRingEnd ℂ (e δ) with hu
  have hu1 : dist u 1 < κ := by
    rw [dist_eq_norm, hu, show (z - v) / (‖z - v‖ : ℂ) * starRingEnd ℂ (e δ) - 1 =
      ((z - v) / (‖z - v‖ : ℂ) - e δ) * starRingEnd ℂ (e δ) by rw [sub_mul, e_mul_conj_e], norm_mul,
      Complex.norm_conj, norm_e, mul_one]
    exact hdir.trans_le ((min_le_right _ _).trans (min_le_right _ _))
  have hn' : ((‖z - v‖ : ℝ) : ℂ) ≠ 0 := by exact_mod_cast hn.ne'
  have harg : Complex.arg ((z - v) * starRingEnd ℂ (e δ)) = Complex.arg u := by
    rw [hu, show (z - v) * starRingEnd ℂ (e δ) = ((‖z - v‖ : ℝ) : ℂ) * ((z - v) / (‖z - v‖ : ℂ) * starRingEnd ℂ (e δ)) by
      field_simp, Complex.arg_real_mul _ hn]
  have h1 := hball hu1
  rw [Complex.arg_one, Real.dist_eq, sub_zero] at h1
  rw [← harg] at h1
  have h2 := abs_lt.mp h1
  refine ⟨(‖z - v‖, δ + Complex.arg ((z - v) * starRingEnd ℂ (e δ))), ⟨⟨hn, ?_⟩, ⟨by linarith, by linarith⟩⟩, hpol.symm⟩
  rw [← dist_eq_norm]; exact hzd.trans_le ((min_le_right _ _).trans (min_le_left _ _))

/-- An angle lies in `angleIcc a b` exactly when its direction is one of `[a, b]`. -/
theorem mem_angleIcc_iff_e {a b β : ℝ} : β ∈ angleIcc a b ↔ e β ∈ e '' Icc a b := by
  constructor
  · intro hβ
    obtain ⟨m, hm⟩ := mem_iUnion.mp hβ
    refine ⟨β + 2 * π * ((-m : ℤ) : ℝ), ⟨by push_cast; linarith [hm.1], by push_cast; linarith [hm.2]⟩, ?_⟩
    rw [e_add_two_pi_mul_int]
  · rintro ⟨θ, hθ, he⟩
    obtain ⟨n, hn⟩ := e_eq_e_iff.mp he.symm
    exact mem_iUnion.mpr ⟨n, by rw [hn]; constructor <;> linarith [hθ.1, hθ.2]⟩

/-- Angular intervals are closed. -/
theorem isClosed_angleIcc (a b : ℝ) : IsClosed (angleIcc a b) := by
  have : angleIcc a b = e ⁻¹' (e '' Icc a b) := Set.ext fun β => mem_angleIcc_iff_e
  rw [this]
  exact (isCompact_Icc.image continuous_e).isClosed.preimage continuous_e

/-- **Off the closed wedge, a merge leaves the cones at `v` alone.** -/
theorem coneAt_wedgeMerge_of_notMem {v : ℂ} {ρ d₁ d₂ : ℝ} (hρ : 0 < ρ) (hd : d₁ < d₂) (hd2 : d₂ ≤ d₁ + 2 * π) {δ : ℝ}
    (hδ : δ ∉ angleIcc d₁ d₂) (j : Fin k) :
    δ ∈ coneAt ((F.wedgeMerge v hρ hd hd2 c).region j) v ↔ δ ∈ coneAt (F.region j) v := by
  obtain ⟨η, hη, hηsub⟩ := Metric.isOpen_iff.mp (isClosed_angleIcc d₁ d₂).isOpen_compl δ hδ
  have hoff : ∀ z ∈ annSector v 0 ρ (δ - η) (δ + η),
      z ∉ closure (annSector v 0 ρ d₁ d₂) ∪ ⋃ a ∈ wedgeArcs v ρ d₁ d₂, a.carrier := by
    rintro _ ⟨⟨s, θ⟩, ⟨hs, hθ⟩, rfl⟩ hX
    simp only at hs hθ hX
    have hP := hX.elim (fun h => closure_annSector_subset v hρ.le hd.le h) (fun h => wedgeArcs_subset_polar hρ hd.le h)
    obtain ⟨⟨s', θ'⟩, ⟨hs', hθ'⟩, h⟩ := hP
    simp only at h hs' hθ'
    have he := (polar_inj hs.1 hs'.1 h.symm).2
    exact hηsub (show θ ∈ Metric.ball δ η by rw [Metric.mem_ball, Real.dist_eq, abs_lt]; constructor <;> linarith [hθ.1, hθ.2])
      (mem_angleIcc_iff_e.mpr ⟨θ', hθ', he.symm⟩)
  have key := recolour_region_diff (F := F) (W := annSector v 0 ρ d₁ d₂) (B := wedgeArcs v ρ d₁ d₂)
    (hB := wedgeArcs_nondegenerate hρ hd hd2) (hBf := ((finite_singleton _).insert _).insert _)
    (hW := frontier_annSector_subset hρ hd hd2) (c := c) j
  have hA : (F.wedgeMerge v hρ hd hd2 c).region j ∩ annSector v 0 ρ (δ - η) (δ + η) =
      F.region j ∩ annSector v 0 ρ (δ - η) (δ + η) := by
    ext z
    constructor
    · rintro ⟨hz, hzA⟩
      have : z ∈ (F.wedgeMerge v hρ hd hd2 c).region j \ (closure (annSector v 0 ρ d₁ d₂) ∪
        ⋃ a ∈ wedgeArcs v ρ d₁ d₂, a.carrier) := ⟨hz, hoff z hzA⟩
      exact ⟨(key ▸ this : z ∈ F.region j \ _).1, hzA⟩
    · rintro ⟨hz, hzA⟩
      have : z ∈ F.region j \ (closure (annSector v 0 ρ d₁ d₂) ∪ ⋃ a ∈ wedgeArcs v ρ d₁ d₂, a.carrier) := ⟨hz, hoff z hzA⟩
      exact ⟨(key.symm ▸ this : z ∈ (F.wedgeMerge v hρ hd hd2 c).region j \ _).1, hzA⟩
  constructor
  · intro h
    have := mem_coneAt_inter_annSector h hρ hη
    rw [hA] at this
    exact coneAt_mono inter_subset_left v this
  · intro h
    have := mem_coneAt_inter_annSector h hρ hη
    rw [← hA] at this
    exact coneAt_mono inter_subset_left v this

/-- **Inside the wedge, after a merge only `c` approaches `v`.** -/
theorem eq_of_mem_coneAt_wedgeMerge {v : ℂ} {ρ d₁ d₂ : ℝ} (hρ : 0 < ρ) (hd : d₁ < d₂) (hd2 : d₂ ≤ d₁ + 2 * π) {δ : ℝ}
    (hδ : δ ∈ angleIoo d₁ d₂) {j : Fin k} (h : δ ∈ coneAt ((F.wedgeMerge v hρ hd hd2 c).region j) v) : j = c := by
  classical
  obtain ⟨m, hm⟩ := mem_iUnion.mp hδ
  have hη : 0 < min (δ - (d₁ + 2 * π * m)) (d₂ + 2 * π * m - δ) := lt_min (by linarith [hm.1]) (by linarith [hm.2])
  obtain ⟨z, ⟨hzR, hzA⟩, -⟩ := mem_coneAt_inter_annSector h hρ hη 1 one_pos
  obtain ⟨⟨s, θ⟩, ⟨hs, hθ⟩, rfl⟩ := hzA
  simp only at hs hθ hzR
  have h1 := min_le_left (δ - (d₁ + 2 * π * m)) (d₂ + 2 * π * m - δ)
  have h2 := min_le_right (δ - (d₁ + 2 * π * m)) (d₂ + 2 * π * m - δ)
  have hzW : v + (s : ℂ) * e θ ∈ annSector v 0 ρ d₁ d₂ := by
    refine ⟨(s, θ + 2 * π * ((-m : ℤ) : ℝ)), ⟨hs, ?_, ?_⟩, ?_⟩
    · push_cast; linarith [hθ.1]
    · push_cast; linarith [hθ.2]
    · simp only [e_add_two_pi_mul_int]
  have hcol : (if v + (s : ℂ) * e θ ∈ annSector v 0 ρ d₁ d₂ then c else F.col (v + (s : ℂ) * e θ)) = j := hzR.2
  rw [if_pos hzW] at hcol
  exact hcol.symm

/-- **Along a direction whose thin cone lies in `F`'s class of `c`, after a merge only `c` approaches `v`** (the merge recolours with
`c`, and leaves the rest of that cone alone). -/
theorem eq_of_mem_coneAt_wedgeMerge_of_subset {v : ℂ} {ρ d₁ d₂ : ℝ} (hρ : 0 < ρ) (hd : d₁ < d₂) (hd2 : d₂ ≤ d₁ + 2 * π)
    {d r : ℝ} (hr : 0 < r) (hF : annSector v 0 r (d - r) (d + r) ⊆ F.region c) {j : Fin k}
    (h : d ∈ coneAt ((F.wedgeMerge v hρ hd hd2 c).region j) v) : j = c := by
  classical
  obtain ⟨z, ⟨hzR, hzA⟩, -⟩ := mem_coneAt_inter_annSector h hr hr 1 one_pos
  have hcol : (if z ∈ annSector v 0 ρ d₁ d₂ then c else F.col z) = j := hzR.2
  by_cases hzW : z ∈ annSector v 0 ρ d₁ d₂
  · rw [if_pos hzW] at hcol; exact hcol.symm
  · rw [if_neg hzW] at hcol; rw [← hcol]; exact (hF hzA).2

/-- **The points a merge at a wedge creates are `NiceAt`** (E3-NICE's crossings): inside a good ball of `F` at `v`, with the two edges in
`F`'s class of `c` a little beyond the radius `ρ`, every point of `closedBall v ρ` other than `v` that carries three or more colours after the
merge is `NiceAt` — it is a transversal crossing of the outer arc with a branch through `v`, `c` on the inner half and two other colours outside
(a three-sector picture); every other such point carries at most two colours. -/
theorem wedgeMerge_niceAt {v : ℂ} {ρ₀ : ℝ} (hG : F.GoodAt v ρ₀) {ρ d₁ d₂ r₁ : ℝ} (hρ : 0 < ρ) (hρ₀ : ρ < ρ₀) (hd : d₁ < d₂)
    (hπ : d₂ - d₁ < π) (hρr : ρ < r₁)
    (hc : ∀ s ∈ Ioo 0 r₁, v + (s : ℂ) * e d₁ ∈ F.region c ∧ v + (s : ℂ) * e d₂ ∈ F.region c)
    {w : ℂ} (hw : w ∈ closedBall v ρ) (hwv : w ≠ v)
    (h3 : 3 ≤ ((F.wedgeMerge v hρ hd (by linarith [Real.pi_pos]) c).coloursAt w).ncard) :
    (F.wedgeMerge v hρ hd (by linarith [Real.pi_pos]) c).NiceAt w := by
  sorry

/-! ## E3-NICE and E3-BALL -/

/-- **E3-NICE, the merge at one point** (`plans/FS131-E3-derivation.md` § 3.3): for every `ε > 0` there are `ρ ∈ (0, ε)` and a valid map of the
plane, Condition 5 kept, equal to `F` off `closedBall v ρ`, in which every point of `closedBall v ρ` of three or more colours is `NiceAt` —
finitely many merges at wedges (`wedgeMerge`) of decreasing radii, each across a gap of angle `< π` between two arcs of one colour, or across a
colour poking into another's arc, until the local data at `v` satisfies `niceAt_of_dirColourAt`; the new points of three colours are crossings
of the merges' outer arcs with branches, `NiceAt` by the same lemma. -/
theorem exists_merge_at (hF : F.Valid) (hP : F.IsPlaneMap) (v : ℂ) {ε : ℝ} (hε : 0 < ε) :
    ∃ ρ ∈ Ioo 0 ε, ∃ F' : ArcMap k, F'.Valid ∧ F'.IsPlaneMap ∧ (F.Condition5 → F'.Condition5) ∧
      (∀ j, F'.region j \ closedBall v ρ = F.region j \ closedBall v ρ) ∧ F'.WoodallMerged (closedBall v ρ) := by
  sorry

/-- **Woodall's step 3, localized** (FS131-E3's E3-BALL, `plans/FS131-E3-derivation.md` § 3.4; `[Woodall1973]` p. 197 for the merge): every
valid map of the plane has a valid map of the plane, Condition 5 kept, in which every point of `closedBall 0 R` of three or more colours is
`NiceAt` — the points of three colours in the ball are finite (`finite_three_le_coloursAt`), and one merge (`exists_merge_at`), within less
than their distance to the others, removes one bad point and adds none (`coloursAt_congr`, `niceAt_congr` off the merged ball). Not claimed:
Woodall's horn-only conclusion, at every point (a GAP past Condition 5, inventory item 161 (b)). -/
theorem exists_woodallMerged (hF : F.Valid) (hP : F.IsPlaneMap) (R : ℝ) :
    ∃ F' : ArcMap k, F'.Valid ∧ F'.IsPlaneMap ∧ F'.WoodallMerged (closedBall 0 R) ∧ (F.Condition5 → F'.Condition5) := by
  classical
  -- the bad points of a map: points of the ball of three or more colours that are not `NiceAt`
  let bad : ArcMap k → Set ℂ := fun G => {w | w ∈ closedBall 0 R ∧ 3 ≤ (G.coloursAt w).ncard ∧ ¬ G.NiceAt w}
  suffices key : ∀ (n : ℕ) (S : Finset ℂ), S.card = n → ∀ G : ArcMap k, G.Valid → G.IsPlaneMap → bad G ⊆ ↑S →
      ∃ F' : ArcMap k, F'.Valid ∧ F'.IsPlaneMap ∧ F'.WoodallMerged (closedBall 0 R) ∧ (G.Condition5 → F'.Condition5) by
    have hfin := finite_three_le_coloursAt (F := F) (isCompact_closedBall (0 : ℂ) R) (by rw [hP]; exact subset_univ _)
    exact key _ hfin.toFinset rfl F hF hP fun w hw => hfin.mem_toFinset.mpr ⟨hw.1, hw.2.1⟩
  intro n
  induction n using Nat.strong_induction_on with
  | _ n ih =>
  intro S hS G hG hGP hbad
  by_cases hne : (bad G).Nonempty
  · obtain ⟨v, hv⟩ := hne
    have hvS : v ∈ S := hbad hv
    obtain ⟨ρ, hρ, G₁, hG₁, hG₁P, h5, hdiff, hM⟩ := exists_merge_at hG hGP v one_pos
    have hsub : bad G₁ ⊆ ↑(S.erase v) := by
      rintro w ⟨hwR, hw3, hwn⟩
      by_cases hwv : w ∈ closedBall v ρ
      · exact absurd (hM w hwv hw3) hwn
      · have hU : (closedBall v ρ)ᶜ ∈ 𝓝 w := isClosed_closedBall.isOpen_compl.mem_nhds hwv
        have hreg : ∀ j, G₁.region j ∩ (closedBall v ρ)ᶜ = G.region j ∩ (closedBall v ρ)ᶜ := fun j => by
          simpa [Set.sdiff_eq] using hdiff j
        have hcol := coloursAt_congr hU hreg
        have hnice := niceAt_congr hU (by rw [hG₁P, hGP]) hreg
        have hwG : w ∈ bad G := ⟨hwR, hcol ▸ hw3, fun h => hwn (hnice.mpr h)⟩
        refine Finset.mem_coe.mpr (Finset.mem_erase.mpr ⟨?_, hbad hwG⟩)
        rintro rfl
        exact hwv (mem_closedBall_self hρ.1.le)
    have hlt : (S.erase v).card < n := by
      rw [← hS]; exact Finset.card_erase_lt_of_mem hvS
    obtain ⟨F', hF', hF'P, hF'M, hF'5⟩ := ih _ hlt (S.erase v) rfl G₁ hG₁ hG₁P hsub
    exact ⟨F', hF', hF'P, hF'M, fun h => hF'5 (h5 h)⟩
  · refine ⟨G, hG, hGP, fun w hw h3 => ?_, id⟩
    by_contra hn
    exact hne ⟨w, hw, h3, hn⟩

end ArcMap

end HadwigerNelson.Plane

#print axioms HadwigerNelson.Plane.clear_wedge
#print axioms HadwigerNelson.Plane.mem_annSector_union_of_ne
#print axioms HadwigerNelson.Plane.disjoint_annSector_wedges
#print axioms HadwigerNelson.Plane.wedgeArcs_nondegenerate
#print axioms HadwigerNelson.Plane.frontier_annSector_subset
#print axioms HadwigerNelson.Plane.annSector_subset_ball
#print axioms HadwigerNelson.Plane.annSector_mono_r₂
#print axioms HadwigerNelson.Plane.mem_segment_ray
#print axioms HadwigerNelson.Plane.wedgeArcs_subset_polar
#print axioms HadwigerNelson.Plane.polar_notMem
#print axioms HadwigerNelson.Plane.annSector_notMem_wedgeArcs
#print axioms HadwigerNelson.Plane.ArcMap.recolour_valid
#print axioms HadwigerNelson.Plane.ArcMap.recolour_region_diff
#print axioms HadwigerNelson.Plane.ArcMap.wedgeMerge_valid
#print axioms HadwigerNelson.Plane.ArcMap.wedgeMerge_condition5
#print axioms HadwigerNelson.Plane.ArcMap.wedgeMerge_region_diff
#print axioms HadwigerNelson.Plane.ArcMap.coloursAt_congr
#print axioms HadwigerNelson.Plane.ArcMap.niceAt_congr
#print axioms HadwigerNelson.Plane.ArcMap.exists_dirColourAt
#print axioms HadwigerNelson.Plane.ArcMap.ncard_coloursAt_le_two_of_sides
#print axioms HadwigerNelson.Plane.ArcMap.mem_curveAt_one_iff
#print axioms HadwigerNelson.Plane.ArcMap.GoodAt.ncard_coloursAt_le_two
#print axioms HadwigerNelson.Plane.ArcMap.finite_three_le_coloursAt
#print axioms HadwigerNelson.Plane.ArcMap.dirColourAt_wedgeMerge
#print axioms HadwigerNelson.Plane.ArcMap.mem_coneAt_inter_annSector
#print axioms HadwigerNelson.Plane.ArcMap.mem_angleIcc_iff_e
#print axioms HadwigerNelson.Plane.ArcMap.isClosed_angleIcc
#print axioms HadwigerNelson.Plane.ArcMap.coneAt_wedgeMerge_of_notMem
#print axioms HadwigerNelson.Plane.ArcMap.eq_of_mem_coneAt_wedgeMerge
#print axioms HadwigerNelson.Plane.ArcMap.eq_of_mem_coneAt_wedgeMerge_of_subset
#print axioms HadwigerNelson.Plane.ArcMap.exists_woodallMerged
#print axioms HadwigerNelson.Plane.ArcMap.threeCol_locallyConstant
#print axioms HadwigerNelson.Plane.ArcMap.threeSectorDisc_sectorsAt
#print axioms HadwigerNelson.Plane.ArcMap.threeSectorDisc_phantom
#print axioms HadwigerNelson.Plane.ArcMap.threeSectorDisc_ncard_coloursAt_le_two
#print axioms HadwigerNelson.Plane.ArcMap.threeSectorDisc_niceAt
#print axioms HadwigerNelson.Plane.ArcMap.threeSectorDisc_woodallMerged
#print axioms HadwigerNelson.Plane.ArcMap.threeSectorDisc_woodallNormal
#print axioms HadwigerNelson.Plane.ArcMap.threeSectorDisc_not_forall_merged
#print axioms HadwigerNelson.Plane.ArcMap.threeSectorDisc_not_forall_normal
#print axioms HadwigerNelson.Plane.halfDisc_sectorsAt
#print axioms HadwigerNelson.Plane.halfDisc_niceAt
#print axioms HadwigerNelson.Plane.coneAt_annSector_eq
#print axioms HadwigerNelson.Plane.mem_annSector_zero_iff

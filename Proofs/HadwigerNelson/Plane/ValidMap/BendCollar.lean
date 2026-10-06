import Proofs.HadwigerNelson.Plane.ValidMap.Chain
import Proofs.HadwigerNelson.Plane.ValidMap.UnitArc
import Proofs.HadwigerNelson.Plane.LocalStructure
import Proofs.HadwigerNelson.Plane.ValidMap.RadialPush
import Proofs.HadwigerNelson.Plane.ValidMap.Pushforward
import Proofs.HadwigerNelson.Plane.ValidMap.CollarMap

/-!
# The collar bend (FS131-KB2)

`bend_toward_collar`, the strengthened toward bend `exists_preBend` iterates (FS131-E4's E4-BEND-UN with R1–R3 and no new inert arc;
FS131-I5o's statement, moved verbatim from `data/fs131/i5o/BendCollar.lean`, rulings 360, 366, 370 (d)). Its construction: a lens
bounded by circles internally tangent to the arc at its two ends (so a horn-shaped tip fits a horn), the push of the arc across a collar
along the rays from its centre, and the bent map as the image of the old one under that homeomorphism (`plans/FS131-I5-implementation.md`
§ 44).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

section Collar

variable {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} {ε R' R R'' : ℝ}

/-- **A polar band over a closed angle interval is compact**: `{P + t e(θ) : θ ∈ [θa, θb], f θ ≤ t ≤ g θ}` with `f ≤ g` continuous is the
image of `[θa, θb] × [0, 1]` under `(θ, s) ↦ P + (f θ + s (g θ − f θ)) e(θ)`. -/
theorem isCompact_polarSet_Icc (P : ℂ) {θa θb : ℝ} {f g : ℝ → ℝ} (hf : Continuous f) (hg : Continuous g)
    (hfg : ∀ θ ∈ Icc θa θb, f θ ≤ g θ) : IsCompact (polarSet P (Icc θa θb) fun θ => Icc (f θ) (g θ)) := by
  have hK : IsCompact (Icc θa θb ×ˢ Icc (0 : ℝ) 1) := isCompact_Icc.prod isCompact_Icc
  have hr : Continuous fun p : ℝ × ℝ => f p.1 + p.2 * (g p.1 - f p.1) :=
    (hf.comp continuous_fst).add (continuous_snd.mul ((hg.comp continuous_fst).sub (hf.comp continuous_fst)))
  have hcont : Continuous fun p : ℝ × ℝ => P + ((f p.1 + p.2 * (g p.1 - f p.1) : ℝ) : ℂ) * e p.1 :=
    continuous_const.add ((Complex.continuous_ofReal.comp hr).mul (continuous_e.comp continuous_fst))
  convert hK.image hcont using 1
  ext z
  constructor
  · rintro ⟨θ, hθ, t, ht, rfl⟩
    rcases eq_or_lt_of_le (hfg θ hθ) with heq | hlt
    · refine ⟨(θ, 0), ⟨hθ, ⟨le_rfl, zero_le_one⟩⟩, ?_⟩
      have : t = f θ := le_antisymm (heq ▸ ht.2) ht.1
      simp [this]
    · refine ⟨(θ, (t - f θ) / (g θ - f θ)), ⟨hθ, ⟨div_nonneg (by linarith [ht.1]) (by linarith), ?_⟩⟩, ?_⟩
      · rw [div_le_one (by linarith)]; linarith [ht.2]
      · have hne : g θ - f θ ≠ 0 := by linarith
        show P + ((f θ + (t - f θ) / (g θ - f θ) * (g θ - f θ) : ℝ) : ℂ) * e θ = P + (t : ℂ) * e θ
        rw [div_mul_cancel₀ _ hne, add_sub_cancel]
  · rintro ⟨⟨θ, s⟩, ⟨hθ, hs⟩, rfl⟩
    refine ⟨θ, hθ, f θ + s * (g θ - f θ), ⟨?_, ?_⟩, rfl⟩
    · nlinarith [hfg θ hθ, hs.1]
    · nlinarith [hfg θ hθ, hs.2]

/-- At an end of an arc of at most `60°`, the ring point is off the open arc. -/
theorem ringPt_not_mem_openArc_of_end {P : ℂ} {θ₁ θ₂ θ : ℝ} (hℓ : θ₂ - θ₁ ≤ π / 3) (hθ : θ ∈ Icc θ₁ θ₂)
    (hθ' : θ ∉ Ioo θ₁ θ₂) : ringPt P θ ∉ ringPt P '' Ioo θ₁ θ₂ := by
  have hπ := Real.pi_pos
  rw [ringPt_mem_openArc_iff]
  rintro ⟨n, hn⟩
  have h1 : (n : ℝ) * (2 * π) < π / 3 := by linarith [hn.1, hθ.2]
  have h2 : -(π / 3) < (n : ℝ) * (2 * π) := by linarith [hn.2, hθ.1]
  have hn0 : n = 0 := by
    have : (n : ℝ) < 1 := by nlinarith
    have : (-1 : ℝ) < n := by nlinarith
    have h3 : n < 1 := by exact_mod_cast ‹(n : ℝ) < 1›
    have h4 : -1 < n := by exact_mod_cast ‹(-1 : ℝ) < n›
    omega
  subst hn0
  simp only [Int.cast_zero, zero_mul, sub_zero] at hn
  exact hθ' hn

/-- The collar's profiles are at most `1`. -/
theorem CollarFit.lensProf_le_one (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') (θ : ℝ) : lensProf θ₁ θ₂ R θ ≤ 1 := by
  by_cases hθ : θ ∈ Ioo θ₁ θ₂
  · exact (hfit.pushProfiles.inside θ hθ).2.2.1.le
  · exact (hfit.pushProfiles.off θ hθ).2.1.le

/-- **The closed lens is compact**: `{P + t e(θ) : θ ∈ [θ₁, θ₂], lensProf θ ≤ t ≤ 1}`. -/
theorem CollarFit.isClosed_closedLens (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') :
    IsClosed (polarSet P (Icc θ₁ θ₂) fun θ => Icc (lensProf θ₁ θ₂ R θ) 1) :=
  (isCompact_polarSet_Icc P hfit.pushProfiles.cont_l continuous_const fun θ _ => hfit.lensProf_le_one θ).isClosed

/-- The lens with its boundary lies in the closed lens. -/
theorem CollarFit.lens_subset_closedLens (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') :
    lensSet P θ₁ θ₂ R ∪ lensCurve P θ₁ θ₂ R ⊆ polarSet P (Icc θ₁ θ₂) fun θ => Icc (lensProf θ₁ θ₂ R θ) 1 := by
  rintro z (⟨θ, hθ, t, ht, rfl⟩ | ⟨θ, hθ, t, ht, rfl⟩)
  · exact ⟨θ, Ioo_subset_Icc_self hθ, t, ⟨ht.1.le, ht.2⟩, rfl⟩
  · rw [mem_singleton_iff] at ht
    exact ⟨θ, hθ, t, ⟨ht.ge, ht ▸ hfit.lensProf_le_one θ⟩, rfl⟩

/-- **Closures are local**: where two maps have the same interior points and colours on an open set about `x`, the closures at `x` of
their classes (met with any set `S`) agree. -/
theorem mem_closure_region_inter_iff_of_agree {F' : ArcMap k} {x : ℂ} {O : Set ℂ} (hO : IsOpen O) (hx : x ∈ O)
    (hI : ∀ z ∈ O, z ∈ F'.interiorPts ↔ z ∈ F.interiorPts) (hc : ∀ z ∈ O, F'.col z = F.col z) (d : Fin k) (S : Set ℂ) :
    x ∈ closure (F'.region d ∩ S) ↔ x ∈ closure (F.region d ∩ S) := by
  have heq : O ∩ (F'.region d ∩ S) = O ∩ (F.region d ∩ S) := by
    ext z
    constructor
    · rintro ⟨hzO, ⟨hzI, hzc⟩, hzS⟩
      refine ⟨hzO, ⟨(hI z hzO).mp hzI, ?_⟩, hzS⟩
      show F.col z = d
      rw [← hc z hzO]; exact hzc
    · rintro ⟨hzO, ⟨hzI, hzc⟩, hzS⟩
      refine ⟨hzO, ⟨(hI z hzO).mpr hzI, ?_⟩, hzS⟩
      show F'.col z = d
      rw [hc z hzO]; exact hzc
  have key : ∀ A : Set ℂ, x ∈ closure A ↔ x ∈ closure (O ∩ A) := fun A =>
    ⟨fun h => hO.inter_closure ⟨hx, h⟩, fun h => closure_mono inter_subset_right h⟩
  rw [key, heq, ← key]

/-! ## The collar at an end, in the end's frame (FS131-CC2) -/

/-- **A collar point in the frame at each end.** With `z − E = (Y + X i) e(θ_E)` at the end `E = ringPt P θ_E` (`Y` along the outward
normal, `X` along the tangent `i e(θ_E)`): the point lies on the arc's side of the end (`X ≥ 0` at `θ₁`, `X ≤ 0` at `θ₂`), outside the
open disc of the tangent circle of radius `R'` (`0 ≤ 2R'Y + |z − E|²`) and inside the closed disc of the one of radius `R''`
(`2R''Y + |z − E|² ≤ 0`) — the two are `tangRad`'s quadratic at `R'` and `R''` (`tangRad_le_iff`, `le_tangRad_iff`). -/
theorem collarK_frame (hR' : 1 / 2 < R') (hR'' : 1 < R'') (hℓ : θ₂ - θ₁ ≤ π / 3) {z : ℂ}
    (hz : z ∈ collarK P θ₁ θ₂ R' R'') :
    (∃ X Y : ℝ, z - ringPt P θ₁ = ((Y : ℂ) + (X : ℂ) * I) * e θ₁ ∧ 0 ≤ X ∧ 0 ≤ 2 * R' * Y + (X ^ 2 + Y ^ 2) ∧
        2 * R'' * Y + (X ^ 2 + Y ^ 2) ≤ 0) ∧
      ∃ X Y : ℝ, z - ringPt P θ₂ = ((Y : ℂ) + (X : ℂ) * I) * e θ₂ ∧ X ≤ 0 ∧ 0 ≤ 2 * R' * Y + (X ^ 2 + Y ^ 2) ∧
        2 * R'' * Y + (X ^ 2 + Y ^ 2) ≤ 0 := by
  obtain ⟨ψ, hψ, t, ht, rfl⟩ := hz
  have hπ := Real.pi_pos
  have hcl : clampAngle θ₁ θ₂ ψ = ψ := by unfold clampAngle; rw [min_eq_left hψ.2, max_eq_right hψ.1]
  have hlo : ∀ u, u = ψ - θ₁ ∨ u = θ₂ - ψ → tangRad R' u ≤ t := by
    intro u hu
    refine le_trans ?_ ht.1
    unfold lensProf
    rw [hcl]
    rcases hu with rfl | rfl
    · exact le_max_left _ _
    · exact le_max_right _ _
  have hhi : ∀ u, u = ψ - θ₁ ∨ u = θ₂ - ψ → t ≤ tangRad R'' u := by
    intro u hu
    refine le_trans ht.2 ?_
    unfold outerProf
    rw [hcl]
    rcases hu with rfl | rfl
    · exact min_le_left _ _
    · exact min_le_right _ _
  have ht0 : 0 < t := (tangRad_pos hR' _).trans_le (hlo _ (Or.inl rfl))
  have key : ∀ u : ℝ, 0 ≤ u → u ≤ π / 3 → tangRad R' u ≤ t → t ≤ tangRad R'' u →
      0 ≤ t * Real.sin u ∧ 0 ≤ 2 * R' * (t * Real.cos u - 1) + ((t * Real.sin u) ^ 2 + (t * Real.cos u - 1) ^ 2) ∧
        2 * R'' * (t * Real.cos u - 1) + ((t * Real.sin u) ^ 2 + (t * Real.cos u - 1) ^ 2) ≤ 0 := by
    intro u hu0 hu1 h1 h2
    have hs : 0 ≤ Real.sin u := Real.sin_nonneg_of_nonneg_of_le_pi hu0 (by linarith)
    have hq1 := (tangRad_le_iff hR' u ht0).mp h1
    have hq2 := (le_tangRad_iff (show (1 : ℝ) / 2 < R'' by linarith) u ht0).mp h2
    have hsc := Real.sin_sq_add_cos_sq u
    have e1 : ∀ ρ : ℝ, 2 * ρ * (t * Real.cos u - 1) + ((t * Real.sin u) ^ 2 + (t * Real.cos u - 1) ^ 2) =
        t ^ 2 - 2 * (1 - ρ) * t * Real.cos u - (2 * ρ - 1) := fun ρ => by linear_combination t ^ 2 * hsc
    refine ⟨mul_nonneg ht0.le hs, ?_, ?_⟩
    · rw [e1]; exact hq1
    · rw [e1]; exact hq2
  refine ⟨?_, ?_⟩
  · obtain ⟨hX, h1, h2⟩ := key (ψ - θ₁) (by linarith [hψ.1]) (by linarith [hψ.2]) (hlo _ (Or.inl rfl)) (hhi _ (Or.inl rfl))
    refine ⟨t * Real.sin (ψ - θ₁), t * Real.cos (ψ - θ₁) - 1, ?_, hX, h1, h2⟩
    have : e ψ = e θ₁ * e (ψ - θ₁) := by rw [← e_add]; congr 1; ring
    rw [this, e_eq (ψ - θ₁), ringPt]
    push_cast
    ring
  · obtain ⟨hX, h1, h2⟩ := key (θ₂ - ψ) (by linarith [hψ.2]) (by linarith [hψ.1]) (hlo _ (Or.inr rfl)) (hhi _ (Or.inr rfl))
    refine ⟨-(t * Real.sin (θ₂ - ψ)), t * Real.cos (θ₂ - ψ) - 1, ?_, by linarith, by nlinarith, by nlinarith⟩
    have : e ψ = e θ₂ * e (-(θ₂ - ψ)) := by rw [← e_add]; congr 1; ring
    rw [this, e_neg (θ₂ - ψ), ringPt]
    push_cast
    ring

/-- The crescent's tangential term decides, outside: with `b > 0`, `A ≥ 0`, `A² = N − Y²`, `−N ≤ Y ≤ 0`, `|α| ≤ 1` and `N` small,
`N + 2(αY + bA) > 0`. Stated on real variables alone (`nlinarith` in a small context). -/
theorem side_core_pos {b A N Y α : ℝ} (hb0 : 0 < b) (hA : 0 ≤ A) (hAN : A ^ 2 = N - Y ^ 2) (hY0 : Y ≤ 0) (hYN : -N ≤ Y)
    (hN : 0 < N) (hN1 : N < 1 / 2) (hN2 : N < 2 * b ^ 2) (hα1 : α ≤ 1) : 0 < N + 2 * (α * Y + b * A) := by
  by_contra hD
  push Not at hD
  have hαY : Y ≤ α * Y := by
    have := mul_nonneg (sub_nonneg.mpr hα1) (neg_nonneg.mpr hY0)
    linarith [show (1 - α) * -Y = α * Y - Y by ring]
  have h3 : 2 * b * A ≤ N := by linarith
  have h4 : (2 * b * A) ^ 2 ≤ N ^ 2 := pow_le_pow_left₀ (mul_nonneg (mul_nonneg (by norm_num) hb0.le) hA) h3 2
  have hY2 : 0 ≤ N ^ 2 - Y ^ 2 := by
    have := mul_nonneg (show 0 ≤ N + Y by linarith) (show 0 ≤ N - Y by linarith)
    linarith [show (N + Y) * (N - Y) = N ^ 2 - Y ^ 2 by ring]
  have e : (2 * b * A) ^ 2 = 4 * b ^ 2 * (N - Y ^ 2) := by rw [← hAN]; ring
  have h5 : 4 * b ^ 2 * (N - N ^ 2) ≤ N ^ 2 := by
    have := mul_nonneg (sq_nonneg b) hY2
    linarith [show 4 * b ^ 2 * (N - N ^ 2) = 4 * b ^ 2 * (N - Y ^ 2) - 4 * (b ^ 2 * (N ^ 2 - Y ^ 2)) by ring]
  have h6 : 4 * b ^ 2 * (1 - N) ≤ N := by
    by_contra h
    push Not at h
    have := mul_pos hN (sub_pos.mpr h)
    linarith [show N * (4 * b ^ 2 * (1 - N) - N) = 4 * b ^ 2 * (N - N ^ 2) - N ^ 2 by ring]
  have := mul_nonneg (sq_nonneg b) (show (0 : ℝ) ≤ 1 / 2 - N by linarith)
  linarith [show 4 * b ^ 2 * (1 - N) = 2 * b ^ 2 + 4 * (b ^ 2 * (1 / 2 - N)) by ring]

/-- The crescent's tangential term decides, inside: with `b < 0` and `N` small, `N + 2(αY + bA) < 0`. -/
theorem side_core_neg {b A N Y α : ℝ} (hb0 : b < 0) (hA : 0 ≤ A) (hAN : A ^ 2 = N - Y ^ 2) (hY0 : Y ≤ 0) (hYN : -N ≤ Y)
    (hN : 0 < N) (hN1 : N < 1 / 2) (hN2 : N < 2 * b ^ 2 / 9) (hα2 : -1 ≤ α) : N + 2 * (α * Y + b * A) < 0 := by
  by_contra hD
  push Not at hD
  have hαY : α * Y ≤ -Y := by
    have := mul_nonneg (show 0 ≤ α + 1 by linarith) (neg_nonneg.mpr hY0)
    linarith [show (α + 1) * -Y = -(α * Y) - Y by ring]
  have h3 : 2 * -b * A ≤ 3 * N := by linarith
  have h4 : (2 * -b * A) ^ 2 ≤ (3 * N) ^ 2 :=
    pow_le_pow_left₀ (mul_nonneg (mul_nonneg (by norm_num) (by linarith)) hA) h3 2
  have hY2 : 0 ≤ N ^ 2 - Y ^ 2 := by
    have := mul_nonneg (show 0 ≤ N + Y by linarith) (show 0 ≤ N - Y by linarith)
    linarith [show (N + Y) * (N - Y) = N ^ 2 - Y ^ 2 by ring]
  have e : (2 * -b * A) ^ 2 = 4 * b ^ 2 * (N - Y ^ 2) := by rw [← hAN]; ring
  have h5 : 4 * b ^ 2 * (N - N ^ 2) ≤ 9 * N ^ 2 := by
    have := mul_nonneg (sq_nonneg b) hY2
    linarith [show 4 * b ^ 2 * (N - N ^ 2) = 4 * b ^ 2 * (N - Y ^ 2) - 4 * (b ^ 2 * (N ^ 2 - Y ^ 2)) by ring,
      show (3 * N) ^ 2 = 9 * N ^ 2 by ring]
  have h6 : 4 * b ^ 2 * (1 - N) ≤ 9 * N := by
    by_contra h
    push Not at h
    have := mul_pos hN (sub_pos.mpr h)
    linarith [show N * (4 * b ^ 2 * (1 - N) - 9 * N) = 4 * b ^ 2 * (N - N ^ 2) - 9 * N ^ 2 by ring]
  have := mul_nonneg (sq_nonneg b) (show (0 : ℝ) ≤ 1 / 2 - N by linarith)
  linarith [show 4 * b ^ 2 * (1 - N) = 2 * b ^ 2 + 4 * (b ^ 2 * (1 / 2 - N)) by ring]

/-- A crescent point has `−N ≤ Y ≤ 0` (`N = X² + Y²`): between the tangent circles of radii `R' > 1/2` and `R'' > 1`. -/
theorem crescent_Y {X Y R' R'' : ℝ} (hR' : 1 / 2 < R') (hR'' : 1 < R'') (h1 : 0 ≤ 2 * R' * Y + (X ^ 2 + Y ^ 2))
    (h2 : 2 * R'' * Y + (X ^ 2 + Y ^ 2) ≤ 0) : Y ≤ 0 ∧ -(X ^ 2 + Y ^ 2) ≤ Y := by
  have hN : 0 ≤ X ^ 2 + Y ^ 2 := by positivity
  have hY0 : Y ≤ 0 := by
    by_contra h
    push Not at h
    have := mul_pos (show (0 : ℝ) < R'' by linarith) h
    linarith
  refine ⟨hY0, ?_⟩
  have := mul_nonneg (show (0 : ℝ) ≤ 2 * R' - 1 by linarith) (neg_nonneg.mpr hY0)
  linarith [show (2 * R' - 1) * -Y = -(2 * R' * Y) + Y by ring]

/-! ## The collar's choice: thin, clear, and free of `Γ` off the arc (FS131-CC2) -/

/-- **A thin collar lies near the arc**: with radii `1 − τ` and `1 + τ` (`0 < τ ≤ 1/4`) every collar point is `P + t e(ψ)` with
`ψ ∈ [θ₁, θ₂]` and `|1 − t| ≤ 2τ` (`one_sub_lensProf_le`, `tangRad_sub_one_le`). -/
theorem collarK_thin {τ : ℝ} (hτ : 0 < τ) (hτ' : τ ≤ 1 / 4) (hℓ : θ₂ - θ₁ ≤ π / 3) {z : ℂ}
    (hz : z ∈ collarK P θ₁ θ₂ (1 - τ) (1 + τ)) : ∃ ψ ∈ Icc θ₁ θ₂, ∃ t : ℝ, 0 < t ∧ z = P + (t : ℂ) * e ψ ∧ |1 - t| ≤ 2 * τ := by
  obtain ⟨ψ, hψ, t, ht, rfl⟩ := hz
  have hπ4 : π < 4 := Real.pi_lt_four
  have hπ0 := Real.pi_pos
  have hcl : clampAngle θ₁ θ₂ ψ = ψ := by unfold clampAngle; rw [min_eq_left hψ.2, max_eq_right hψ.1]
  have hR' : (1 : ℝ) / 2 < 1 - τ := by linarith
  have ht0 : 0 < t := by
    refine lt_of_lt_of_le (tangRad_pos hR' (ψ - θ₁)) (le_trans ?_ ht.1)
    unfold lensProf; rw [hcl]; exact le_max_left _ _
  refine ⟨ψ, hψ, t, ht0, rfl, abs_le.mpr ⟨?_, ?_⟩⟩
  · -- `t − 1 ≤ τ (ψ − θ₁)² ≤ 2τ`
    have h1 : t ≤ tangRad (1 + τ) (ψ - θ₁) := by
      refine le_trans ht.2 ?_
      unfold outerProf; rw [hcl]; exact min_le_left _ _
    have h2 := tangRad_sub_one_le (show (1 : ℝ) ≤ 1 + τ by linarith) (ψ - θ₁)
    have h3 : (ψ - θ₁) ^ 2 ≤ 2 := by
      have : ψ - θ₁ ≤ 4 / 3 := by linarith [hψ.2]
      nlinarith [hψ.1]
    nlinarith
  · -- `1 − t ≤ τ/(1 − τ) · min ≤ 2τ`
    have h1 := one_sub_lensProf_le hR' (show 1 - τ < 1 by linarith) hψ hℓ
    have h2 : min (ψ - θ₁) (θ₂ - ψ) ≤ 1 := by
      have := min_le_left (ψ - θ₁) (θ₂ - ψ)
      have := min_le_right (ψ - θ₁) (θ₂ - ψ)
      linarith
    have h3 : 0 ≤ min (ψ - θ₁) (θ₂ - ψ) := le_min (by linarith [hψ.1]) (by linarith [hψ.2])
    have h4 : (1 - (1 - τ)) / (1 - τ) ≤ 2 * τ := by
      rw [div_le_iff₀ (by linarith)]
      nlinarith
    have h5 : (1 - (1 - τ)) / (1 - τ) * min (ψ - θ₁) (θ₂ - ψ) ≤ 2 * τ * 1 :=
      mul_le_mul h4 h2 h3 (by linarith)
    linarith [ht.1]

/-- **A thin lens is clear for the outer colour** (C1): the outer class stays a positive distance from `P` (`hout`), so for `R = 1 − τ/2`
close to `1` the lens lies under both envelope profiles (`one_sub_lensProf_le` against `n2_env_toward`, `n2_env_near`), and
`toward_clear` applies. -/
theorem exists_lens_clear (hF : F.Valid) (hA : F.IsRingArc P θ₁ θ₂ c c') (hout : c' ∉ F.coloursAt P) :
    ∀ᶠ τ in 𝓝[>] (0 : ℝ), ∀ z ∈ polarSet P (Ioo θ₁ θ₂) (fun θ => Ioo (lensProf θ₁ θ₂ (1 - τ / 2) θ) 1), F.IsClear c' z := by
  have h12 := hA.1
  have hℓ := l60_le hF hA
  obtain ⟨r, hr0, hr⟩ : ∃ r > 0, ∀ y ∈ F.region c', r ≤ dist y P := by
    have hP : P ∉ closure (F.region c') := hout
    rw [Metric.mem_closure_iff] at hP
    push Not at hP
    obtain ⟨r, hr0, hr⟩ := hP
    exact ⟨r, hr0, fun y hy => by rw [dist_comm]; exact hr y hy⟩
  obtain ⟨ψ₁, hψ₁, henv⟩ := n2_env_toward P h12 hℓ hr0
  obtain ⟨ψ₂, hψ₂, hnear⟩ := n2_env_near P h12 hℓ
  refine Filter.eventually_of_mem (Ioo_mem_nhdsGT (show (0 : ℝ) < min 1 (min ψ₁ ψ₂) from lt_min one_pos (lt_min hψ₁ hψ₂))) ?_
  rintro τ ⟨hτ0, hτ⟩ z ⟨φ, hφ, t, ht, rfl⟩
  have hτ1 : τ < 1 := lt_of_lt_of_le hτ (min_le_left _ _)
  have hτψ₁ : τ < ψ₁ := lt_of_lt_of_le hτ ((min_le_right _ _).trans (min_le_left _ _))
  have hτψ₂ : τ < ψ₂ := lt_of_lt_of_le hτ ((min_le_right _ _).trans (min_le_right _ _))
  have hl := one_sub_lensProf_le (show (1 : ℝ) / 2 < 1 - τ / 2 by linarith) (show 1 - τ / 2 < 1 by linarith)
    (Ioo_subset_Icc_self hφ) hℓ
  have hm0 : 0 ≤ min (φ - θ₁) (θ₂ - φ) := le_min (by linarith [hφ.1]) (by linarith [hφ.2])
  have hk : (1 - (1 - τ / 2)) / (1 - τ / 2) ≤ τ := by
    rw [div_le_iff₀ (by linarith)]
    nlinarith
  have hs : 1 - t ≤ τ * min (φ - θ₁) (θ₂ - φ) :=
    le_trans (by linarith [ht.1]) (le_trans hl (mul_le_mul_of_nonneg_right hk hm0))
  have hcl := toward_clear F hF hA hr henv hnear hφ (show 0 < 1 - t by linarith [ht.2])
    (hs.trans (mul_le_mul_of_nonneg_right hτψ₁.le hm0)) (hs.trans (mul_le_mul_of_nonneg_right hτψ₂.le hm0))
  have : P + (1 - ((1 - t : ℝ) : ℂ)) * e φ = P + (t : ℂ) * e φ := by push_cast; ring
  rw [← this]
  exact hcl

/-- Finitely many positive numbers have a positive lower bound. -/
theorem exists_pos_forall_le {n : ℕ} (f : Fin n → ℝ) (hf : ∀ i, 0 < f i) : ∃ m > 0, ∀ i, m ≤ f i := by
  rcases Nat.eq_zero_or_pos n with rfl | hn
  · exact ⟨1, one_pos, fun i => i.elim0⟩
  · obtain ⟨i₀, -, h⟩ := Finset.exists_min_image Finset.univ f ⟨⟨0, hn⟩, Finset.mem_univ _⟩
    exact ⟨f i₀, hf i₀, fun i => h i (Finset.mem_univ i)⟩

/-- **A germ across the arc's tangent has no point in the crescent near the end** (real variables): the crescent hugs the tangent
(`|Y| ≤ s²`), a germ of direction `(gx, gy)`, `gx ≠ 0`, leaves it at rate `|gx|`. -/
theorem branch_transversal {gx gy κ s ca sa X Y R' R'' : ℝ} (hg : gx ^ 2 + gy ^ 2 = 1) (hs : 0 < s)
    (hs1 : s * (2 + |κ|) < |gx|) (hs2 : s * (1 + |κ|) < 1) (hca : 0 < ca) (hcs : ca ^ 2 + sa ^ 2 = 1) (hsa : sa = κ * s / 2)
    (hY : Y = s * (gx * ca - gy * sa)) (hN : X ^ 2 + Y ^ 2 = s ^ 2) (hR' : 1 / 2 < R') (hR'' : 1 < R'')
    (h1 : 0 ≤ 2 * R' * Y + (X ^ 2 + Y ^ 2)) (h2 : 2 * R'' * Y + (X ^ 2 + Y ^ 2) ≤ 0) : False := by
  obtain ⟨hY0, hYN⟩ := crescent_Y hR' hR'' h1 h2
  rw [hN] at hYN
  have hκ0 := abs_nonneg κ
  -- `|gx ca − gy sa| ≤ s`
  have hd : |gx * ca - gy * sa| ≤ s := by
    rw [abs_le]
    constructor
    · by_contra h
      push Not at h
      have := mul_pos hs (show 0 < -s - (gx * ca - gy * sa) by linarith)
      nlinarith
    · by_contra h
      push Not at h
      have := mul_pos hs (show 0 < gx * ca - gy * sa by linarith)
      nlinarith
  have hsa' : |sa| = |κ| * s / 2 := by rw [hsa, abs_div, abs_mul, abs_of_pos hs, abs_of_pos (show (0 : ℝ) < 2 by norm_num)]
  have hgy : |gy| ≤ 1 := by rw [← sq_le_one_iff_abs_le_one]; nlinarith [sq_nonneg gx]
  have hsa1 : |sa| < 1 / 2 := by rw [hsa']; nlinarith
  have hca1 : 1 / 2 < ca := by
    by_contra h
    push Not at h
    have h3 : sa ^ 2 < 1 / 4 := by
      have := abs_nonneg sa
      rw [← sq_abs]; nlinarith
    nlinarith
  have hgs : |gy * sa| ≤ |κ| * s / 2 := by
    rw [abs_mul, ← hsa']
    exact mul_le_of_le_one_left (abs_nonneg _) hgy
  have h3 : |gx| * ca ≤ s + |κ| * s / 2 := by
    have : |gx * ca| ≤ |gx * ca - gy * sa| + |gy * sa| := by
      have := abs_add_le (gx * ca - gy * sa) (gy * sa)
      rwa [sub_add_cancel] at this
    rw [abs_mul, abs_of_pos hca] at this
    linarith
  have h4 : |gx| * (1 / 2) ≤ |gx| * ca := mul_le_mul_of_nonneg_left hca1.le (abs_nonneg _)
  linarith

/-- **A germ along the arc's tangent that meets the crescent on the arc's side is the unit circle's**, once the crescent's radii
`1 − τ`, `1 + τ` are closer to `1` than the germ's curvature allows (real variables). -/
theorem branch_tangent {gy κ σ s ca sa τ X Y : ℝ} (hgy : gy = 1 ∨ gy = -1) (hσ : σ = 1 ∨ σ = -1) (hs : 0 < s) (hca : 0 < ca)
    (hsa : sa = κ * s / 2) (hX : X = s * (gy * ca)) (hY : Y = s * -(gy * sa)) (hN : X ^ 2 + Y ^ 2 = s ^ 2) (hσX : 0 ≤ σ * X)
    (hτ : 0 < τ) (hτ' : σ * κ = 1 ∨ τ * (|σ * κ| + 1) < |σ * κ - 1|)
    (h1 : 0 ≤ 2 * (1 - τ) * Y + (X ^ 2 + Y ^ 2)) (h2 : 2 * (1 + τ) * Y + (X ^ 2 + Y ^ 2) ≤ 0) :
    2 * Y + (X ^ 2 + Y ^ 2) = 0 := by
  have hsc : 0 < s * ca := mul_pos hs hca
  have hgσ : gy = σ := by
    rcases hgy with rfl | rfl <;> rcases hσ with rfl | rfl
    · rfl
    · rw [hX] at hσX; nlinarith
    · rw [hX] at hσX; nlinarith
    · rfl
  have hσ2 : σ * σ = 1 := by rcases hσ with rfl | rfl <;> norm_num
  have hs2 : 0 < s ^ 2 := by positivity
  have hYv : Y = -(σ * κ) * s ^ 2 / 2 := by rw [hY, hsa, hgσ]; ring
  rw [hN, hYv] at h1 h2 ⊢
  set v := σ * κ with hv
  have hv1 : (1 - τ) * v ≤ 1 := by
    by_contra h
    push Not at h
    have := mul_pos hs2 (sub_pos.mpr h)
    nlinarith
  have hv2 : 1 ≤ (1 + τ) * v := by
    by_contra h
    push Not at h
    have := mul_pos hs2 (sub_pos.mpr h)
    nlinarith
  rcases hτ' with h | h
  · rw [h]; ring
  · exfalso
    have ha : τ * v ≤ τ * |v| := mul_le_mul_of_nonneg_left (le_abs_self v) hτ.le
    have hb : |v - 1| ≤ τ * |v| := abs_le.mpr ⟨by linarith, by linarith⟩
    nlinarith [abs_nonneg v]

/-- **Near an end, the arcs of `Γ` in the collar's crescent lie on `ω(P)`** (C4, at any point `E = ringPt P θ_E` of the domain and
either side `σ`): `F`'s sector chart at `E` (`localSectors`) lists the arcs near `E` as finitely many branches; in `E`'s frame a branch
across the tangent leaves the crescent (`branch_transversal`), one along it backwards is on the wrong side, and one along it forwards
has its curvature between `1/(1 + τ)` and `1/(1 − τ)`, so is the unit circle's once `τ` is small (`branch_tangent`). -/
theorem exists_end_free (F : ArcMap k) {P : ℂ} {θE σ : ℝ} (hE : ringPt P θE ∈ F.dom) (hσ : σ = 1 ∨ σ = -1) :
    ∃ ρ > 0, ∃ τ₀ > 0, ∀ τ, 0 < τ → τ < τ₀ → ∀ z ∈ F.Γ, dist z (ringPt P θE) < ρ → ∀ X Y : ℝ,
      z - ringPt P θE = ((Y : ℂ) + (X : ℂ) * I) * e θE → 0 ≤ σ * X → 0 ≤ 2 * (1 - τ) * Y + (X ^ 2 + Y ^ 2) →
        2 * (1 + τ) * Y + (X ^ 2 + Y ^ 2) ≤ 0 → dist z P = 1 := by
  obtain ⟨r₀, n, G, hC⟩ := localSectors F hE
  obtain ⟨s₀, hs₀, hs₀i⟩ := exists_pos_forall_le
    (fun i : Fin n => min (if Real.cos (G.β i - θE) = 0 then 1 else |Real.cos (G.β i - θE)| / (2 + |G.κ i|)) (1 / (1 + |G.κ i|)))
    (fun i => by
      have hκ := abs_nonneg (G.κ i)
      refine lt_min ?_ (by positivity)
      split_ifs with h
      · exact one_pos
      · exact div_pos (abs_pos.mpr h) (by positivity))
  obtain ⟨τ₀, hτ₀, hτ₀i⟩ := exists_pos_forall_le
    (fun i : Fin n => if σ * G.κ i = 1 then 1 else |σ * G.κ i - 1| / (|σ * G.κ i| + 1))
    (fun i => by
      have hκ := abs_nonneg (σ * G.κ i)
      split_ifs with h
      · exact one_pos
      · exact div_pos (abs_pos.mpr (sub_ne_zero.mpr h)) (by positivity))
  refine ⟨min r₀ s₀, lt_min hC.pos hs₀, min (1 / 2) τ₀, lt_min (by norm_num) hτ₀, ?_⟩
  intro τ hτ hττ z hzΓ hzd X Y hz hσX h1 h2
  have hτ2 : τ < 1 / 2 := lt_of_lt_of_le hττ (min_le_left _ _)
  have hττ₀ : τ < τ₀ := lt_of_lt_of_le hττ (min_le_right _ _)
  -- on `ω(P)` exactly when `2Y + N = 0`
  have hdP : dist z P ^ 2 = 2 * Y + (X ^ 2 + Y ^ 2) + 1 := by
    have hzP : z - P = ((Y : ℂ) + (X : ℂ) * I + 1) * e θE := by
      rw [add_mul, ← hz, ringPt]; ring
    rw [dist_eq_norm, hzP, norm_mul, norm_e, mul_one, ← Complex.normSq_eq_norm_sq, Complex.normSq_apply]
    simp
    ring
  suffices h : 2 * Y + (X ^ 2 + Y ^ 2) = 0 by
    rw [h, zero_add] at hdP
    have h0 := dist_nonneg (x := z) (y := P)
    nlinarith
  by_cases hzE : z = ringPt P θE
  · have h0 : ((Y : ℂ) + (X : ℂ) * I) * e θE = 0 := by rw [← hz, hzE, sub_self]
    have h0' : (Y : ℂ) + (X : ℂ) * I = 0 := (mul_eq_zero.mp h0).resolve_right (e_ne_zero θE)
    have hY0 : Y = 0 := by simpa using congrArg Complex.re h0'
    have hX0 : X = 0 := by simpa using congrArg Complex.im h0'
    rw [hY0, hX0]; ring
  · have hmem : z ∈ (F.Γ ∩ ball (ringPt P θE) r₀) \ {ringPt P θE} :=
      ⟨⟨hzΓ, lt_of_lt_of_le hzd (min_le_left _ _)⟩, hzE⟩
    rw [hC.branches] at hmem
    obtain ⟨i, s, hs, rfl⟩ := mem_iUnion.mp hmem
    have hds : dist (branchPt (ringPt P θE) (G.β i) (G.κ i) s) (ringPt P θE) = s := by
      rw [dist_eq_norm, norm_branchPt_sub _ _ _ hs.1.le]
    rw [hds] at hzd
    have hss₀ : s < s₀ := lt_of_lt_of_le hzd (min_le_right _ _)
    have hκs : |G.κ i| * s < 2 := lt_of_le_of_lt (mul_le_mul_of_nonneg_left hs.2.le (abs_nonneg _)) (hC.curv i)
    have hx1 : -1 < G.κ i * s / 2 ∧ G.κ i * s / 2 < 1 := by
      have := abs_lt.mp (show |G.κ i * s| < 2 by rw [abs_mul, abs_of_pos hs.1]; exact hκs)
      constructor <;> linarith [this.1, this.2]
    set a := Real.arcsin (G.κ i * s / 2) with ha
    have hsa : Real.sin a = G.κ i * s / 2 := Real.sin_arcsin hx1.1.le hx1.2.le
    have hca : 0 < Real.cos a :=
      Real.cos_pos_of_mem_Ioo ⟨Real.neg_pi_div_two_lt_arcsin.mpr hx1.1, Real.arcsin_lt_pi_div_two.mpr hx1.2⟩
    -- the frame coordinates of the branch point
    have hW : (Y : ℂ) + (X : ℂ) * I = (s : ℂ) * e (G.β i - θE + a) := by
      have h3 : ((Y : ℂ) + (X : ℂ) * I) * e θE = (s : ℂ) * e (G.β i + a) := by
        rw [← hz, branchPt]; ring
      have h4 : e (G.β i + a) = e (G.β i - θE + a) * e θE := by rw [← e_add]; congr 1; ring
      rw [h4, ← mul_assoc] at h3
      exact mul_right_cancel₀ (e_ne_zero θE) h3
    have hYe : Y = s * Real.cos (G.β i - θE + a) := by
      have := congrArg Complex.re hW
      simpa [re_e] using this
    have hXe : X = s * Real.sin (G.β i - θE + a) := by
      have := congrArg Complex.im hW
      simpa [im_e] using this
    rw [Real.cos_add] at hYe
    rw [Real.sin_add] at hXe
    have hN : X ^ 2 + Y ^ 2 = s ^ 2 := by
      rw [hXe, hYe]
      linear_combination s ^ 2 * (Real.cos a ^ 2 + Real.sin a ^ 2) * Real.sin_sq_add_cos_sq (G.β i - θE) +
        s ^ 2 * Real.sin_sq_add_cos_sq a
    have hs₀' := hs₀i i
    have hs2 : s * (1 + |G.κ i|) < 1 := by
      have h5 : s < 1 / (1 + |G.κ i|) := lt_of_lt_of_le hss₀ (hs₀'.trans (min_le_right _ _))
      rwa [lt_div_iff₀ (by positivity)] at h5
    by_cases hgx : Real.cos (G.β i - θE) = 0
    · -- along the tangent
      have hgy : Real.sin (G.β i - θE) = 1 ∨ Real.sin (G.β i - θE) = -1 := by
        have h5 := Real.sin_sq_add_cos_sq (G.β i - θE)
        rw [hgx] at h5
        have h6 : (Real.sin (G.β i - θE) - 1) * (Real.sin (G.β i - θE) + 1) = 0 := by ring_nf; linarith
        rcases mul_eq_zero.mp h6 with h | h
        · exact Or.inl (by linarith)
        · exact Or.inr (by linarith)
      rw [hgx] at hYe hXe
      refine branch_tangent hgy hσ hs.1 hca hsa (by rw [hXe]; ring) (by rw [hYe]; ring) hN hσX hτ ?_ h1 h2
      by_cases hv : σ * G.κ i = 1
      · exact Or.inl hv
      · right
        have h5 := hτ₀i i
        simp only [if_neg hv] at h5
        have h6 : τ < |σ * G.κ i - 1| / (|σ * G.κ i| + 1) := lt_of_lt_of_le hττ₀ h5
        rwa [lt_div_iff₀ (by positivity)] at h6
    · -- across the tangent
      exfalso
      have h5 : s < |Real.cos (G.β i - θE)| / (2 + |G.κ i|) := by
        have h6 := hs₀'.trans (min_le_left _ _)
        simp only [if_neg hgx] at h6
        exact lt_of_lt_of_le hss₀ h6
      rw [lt_div_iff₀ (by positivity)] at h5
      exact branch_transversal (gy := Real.sin (G.β i - θE)) (Real.cos_sq_add_sin_sq _) hs.1 h5 hs2 hca
        (Real.cos_sq_add_sin_sq a) hsa hYe hN (show (1 : ℝ) / 2 < 1 - τ by linarith)
        (show (1 : ℝ) < 1 + τ by linarith) h1 h2

/-- **A thin collar meets `Γ` only on the arc** (C3 with C4): near each end by `exists_end_free` in the end's frame (`collarK_frame`);
in between, the collar is within `2τ` of a compact middle of the arc, which lies in the open set where `Γ` is `ω(P)` (`hfree`). -/
theorem exists_collar_free (hF : F.Valid) (hA : F.IsRingArc P θ₁ θ₂ c c')
    (hfree : ∀ θ ∈ Ioo θ₁ θ₂, ∃ r > 0, F.Γ ∩ ball (ringPt P θ) r ⊆ sphere P 1) :
    ∀ᶠ τ in 𝓝[>] (0 : ℝ), F.Γ ∩ collarK P θ₁ θ₂ (1 - τ) (1 + τ) ⊆ ringArc P θ₁ θ₂ := by
  have h12 := hA.1
  have hℓ := l60_le hF hA
  have hA1 : ringPt P θ₁ ∈ F.dom := (hA.2.1 ⟨θ₁, ⟨le_rfl, h12.le⟩, rfl⟩).1
  have hA2 : ringPt P θ₂ ∈ F.dom := (hA.2.1 ⟨θ₂, ⟨h12.le, le_rfl⟩, rfl⟩).1
  obtain ⟨ρ₁, hρ₁, τ₁, hτ₁, hend₁⟩ := exists_end_free F hA1 (σ := 1) (Or.inl rfl)
  obtain ⟨ρ₂, hρ₂, τ₂, hτ₂, hend₂⟩ := exists_end_free F hA2 (σ := -1) (Or.inr rfl)
  -- the open set where `Γ` is `ω(P)`, and the compact middle of the arc inside it
  set U : Set ℂ := {y | ∃ θ ∈ Ioo θ₁ θ₂, ∃ r : ℝ, F.Γ ∩ ball (ringPt P θ) r ⊆ sphere P 1 ∧ y ∈ ball (ringPt P θ) r} with hU
  have hUo : IsOpen U := by
    rw [isOpen_iff_mem_nhds]
    rintro y ⟨θ, hθ, r, hr, hy⟩
    exact Filter.mem_of_superset (isOpen_ball.mem_nhds hy) fun y' hy' => ⟨θ, hθ, r, hr, hy'⟩
  have hUΓ : ∀ y ∈ U, y ∈ F.Γ → dist y P = 1 := by
    rintro y ⟨θ, -, r, hr, hy⟩ hyΓ
    exact hr ⟨hyΓ, hy⟩
  set M : Set ℂ := ringArc P θ₁ θ₂ ∩ {y | ρ₁ / 2 ≤ dist y (ringPt P θ₁) ∧ ρ₂ / 2 ≤ dist y (ringPt P θ₂)} with hM
  have hMc : IsCompact M := by
    refine (isCompact_Icc.image (by unfold ringPt e; fun_prop) : IsCompact (ringArc P θ₁ θ₂)).inter_right ?_
    exact (isClosed_le continuous_const (continuous_id.dist continuous_const)).inter
      (isClosed_le continuous_const (continuous_id.dist continuous_const))
  have hMU : M ⊆ U := by
    rintro y ⟨⟨θ, hθ, rfl⟩, hy1, hy2⟩
    have hθo : θ ∈ Ioo θ₁ θ₂ := by
      refine ⟨lt_of_le_of_ne hθ.1 ?_, lt_of_le_of_ne hθ.2 ?_⟩
      · rintro rfl
        rw [dist_self] at hy1; linarith
      · rintro rfl
        rw [dist_self] at hy2; linarith
    obtain ⟨r, hr, hsub⟩ := hfree θ hθo
    exact ⟨θ, hθo, r, hsub, mem_ball_self hr⟩
  obtain ⟨δ, hδ, hδU⟩ := hMc.exists_thickening_subset_open hUo hMU
  have hpos : (0 : ℝ) < min (min (1 / 4) (δ / 2)) (min (min τ₁ τ₂) (min (ρ₁ / 4) (ρ₂ / 4))) :=
    lt_min (lt_min (by norm_num) (by linarith)) (lt_min (lt_min hτ₁ hτ₂) (lt_min (by linarith) (by linarith)))
  refine Filter.eventually_of_mem (Ioo_mem_nhdsGT hpos) ?_
  rintro τ ⟨hτ0, hτ⟩ z ⟨hzΓ, hzK⟩
  have hτa : τ < 1 / 4 := lt_of_lt_of_le hτ ((min_le_left _ _).trans (min_le_left _ _))
  have hτb : τ < δ / 2 := lt_of_lt_of_le hτ ((min_le_left _ _).trans (min_le_right _ _))
  have hτc : τ < τ₁ := lt_of_lt_of_le hτ ((min_le_right _ _).trans ((min_le_left _ _).trans (min_le_left _ _)))
  have hτd : τ < τ₂ := lt_of_lt_of_le hτ ((min_le_right _ _).trans ((min_le_left _ _).trans (min_le_right _ _)))
  have hτe : τ < ρ₁ / 4 := lt_of_lt_of_le hτ ((min_le_right _ _).trans ((min_le_right _ _).trans (min_le_left _ _)))
  have hτf : τ < ρ₂ / 4 := lt_of_lt_of_le hτ ((min_le_right _ _).trans ((min_le_right _ _).trans (min_le_right _ _)))
  obtain ⟨⟨X₁, Y₁, hz₁, hX₁, h11, h12'⟩, ⟨X₂, Y₂, hz₂, hX₂, h21, h22⟩⟩ :=
    collarK_frame (show (1 : ℝ) / 2 < 1 - τ by linarith) (show (1 : ℝ) < 1 + τ by linarith) hℓ hzK
  obtain ⟨ψ, hψ, t, ht0, hzt, htτ⟩ := collarK_thin hτ0 hτa.le hℓ hzK
  -- it suffices that the point is on `ω(P)`
  suffices hd : dist z P = 1 by
    rw [hzt, dist_eq_norm, add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_of_nonneg ht0.le] at hd
    exact ⟨ψ, hψ, by rw [hzt, hd]; simp [ringPt]⟩
  by_cases hd1 : dist z (ringPt P θ₁) < ρ₁
  · exact hend₁ τ hτ0 hτc z hzΓ hd1 X₁ Y₁ hz₁ (by linarith) h11 h12'
  by_cases hd2 : dist z (ringPt P θ₂) < ρ₂
  · exact hend₂ τ hτ0 hτd z hzΓ hd2 X₂ Y₂ hz₂ (by linarith) h21 h22
  -- the middle
  have hx : dist z (ringPt P ψ) ≤ 2 * τ := by rw [hzt, dist_polar_ringPt]; exact htτ
  have hxM : ringPt P ψ ∈ M := by
    refine ⟨⟨ψ, hψ, rfl⟩, ?_, ?_⟩
    · have := dist_triangle z (ringPt P ψ) (ringPt P θ₁)
      linarith [not_lt.mp hd1]
    · have := dist_triangle z (ringPt P ψ) (ringPt P θ₂)
      linarith [not_lt.mp hd2]
  exact hUΓ z (hδU (mem_thickening_iff.mpr ⟨ringPt P ψ, hxM, lt_of_le_of_lt hx (by linarith)⟩)) hzΓ

/-- **The collar exists** (the F-dependent choice; plan § 4, child C1). The route proved (FS131-CC2, `plans/FS131-collar-C-implementation.md`
§ 7.1): the radii are one parameter, `R' = 1 − τ`, `R = 1 − τ/2`, `R'' = 1 + τ`, and each clause of `CollarFit` holds for all small `τ > 0`, so
one `τ` serves all. `clear` (`exists_lens_clear`): `hout` keeps the outer class a positive distance from `P`, and for small `τ` the lens lies
under `bend_toward`'s two profiles (`one_sub_lensProf_le` against `n2_env_toward`, `n2_env_near`), so `toward_clear` applies. Thin
(`collarK_thin`): a collar point is `P + t e(ψ)` with `ψ ∈ [θ₁, θ₂]` and `|1 − t| ≤ 2τ`, so the collar lies within `ε` of the arc and inside the
domain (a compact arc in an open set). `Γ`-free off the arc (`exists_collar_free`): near each end by the end's sector chart (`localSectors`)
read in the end's frame — a branch across the tangent leaves the crescent (`branch_transversal`), and a branch along it stays in the crescent
only with the circle's curvature, so it is the circle (`branch_tangent`; `exists_end_free`) — and in the middle by `hfree` and a thickening of
the arc's compact middle. `l60_le` gives `short`. Inhabitant of the hypotheses, at once: `collarModel_hyps` (a sub-arc of
`l60Frag`'s unit arc, sides `0` and `1`). -/
theorem exists_collarFit (hF : F.Valid) (hA : F.IsRingArc P θ₁ θ₂ c c') (hout : c' ∉ F.coloursAt P)
    (hfree : ∀ θ ∈ Ioo θ₁ θ₂, ∃ r > 0, F.Γ ∩ ball (ringPt P θ) r ⊆ sphere P 1) (hε : 0 < ε) :
    ∃ R' R R'', CollarFit F P θ₁ θ₂ c c' ε R' R R'' := by
  have h12 := hA.1
  have hℓ := l60_le hF hA
  obtain ⟨δ, hδ, hδdom⟩ := (isCompact_Icc.image (by unfold ringPt e; fun_prop) :
    IsCompact (ringArc P θ₁ θ₂)).exists_thickening_subset_open F.isOpen_dom (fun y hy => (hA.2.1 hy).1)
  have hpos : (0 : ℝ) < min (1 / 4) (min (ε / 2) (δ / 2)) := lt_min (by norm_num) (lt_min (by linarith) (by linarith))
  obtain ⟨τ, ⟨hclear, hfr⟩, hτ0, hτ⟩ :=
    (((exists_lens_clear hF hA hout).and (exists_collar_free hF hA hfree)).and (Ioo_mem_nhdsGT hpos)).exists
  have hτ4 : τ < 1 / 4 := lt_of_lt_of_le hτ (min_le_left _ _)
  have hτε : τ < ε / 2 := lt_of_lt_of_le hτ ((min_le_right _ _).trans (min_le_left _ _))
  have hτδ : τ < δ / 2 := lt_of_lt_of_le hτ ((min_le_right _ _).trans (min_le_right _ _))
  have hthin : ∀ η, 2 * τ < η → collarK P θ₁ θ₂ (1 - τ) (1 + τ) ⊆ thickening η (ringArc P θ₁ θ₂) := by
    intro η hη z hz
    obtain ⟨ψ, hψ, t, -, hzt, ht⟩ := collarK_thin hτ0 hτ4.le hℓ hz
    exact mem_thickening_ringArc_of_polar hψ hzt (lt_of_le_of_lt ht hη)
  exact ⟨1 - τ, 1 - τ / 2, 1 + τ, ⟨hA, hℓ, ⟨by linarith, by linarith, by linarith, by linarith⟩, hfree, hthin ε (by linarith),
    (hthin δ (by linarith)).trans hδdom, hfr, hclear⟩⟩

/-! ## The model: a collar on the L60 fragment (B0; FS131-CC2) -/

/-- A chord of the unit circle over an angle in `(π/8, π/3)` is longer than `1/4` and shorter than `1`. -/
theorem quarter_lt_chord {x : ℝ} (h1 : π / 8 < x) (h2 : x < π / 3) : 1 / 4 < 2 * Real.sin (x / 2) ∧ 2 * Real.sin (x / 2) < 1 := by
  have hπ := Real.pi_pos
  constructor
  · have h := Real.mul_lt_sin (show 0 < x / 2 by linarith) (show x / 2 < π / 2 by linarith)
    have h3 : 2 / π * (x / 2) = x / π := by field_simp
    have h4 : 1 / 8 < x / π := by rw [lt_div_iff₀ hπ]; linarith
    linarith
  · have h := Real.sin_lt_sin_of_lt_of_le_pi_div_two (show -(π / 2) ≤ x / 2 by linarith) (show π / 6 ≤ π / 2 by linarith)
      (show x / 2 < π / 6 by linarith)
    rw [Real.sin_pi_div_six] at h
    linarith

/-- **The collar's model, hypothesis by hypothesis and at once** (FS131-QA4's QA4-C1, without its idle length clause). On the
valid four-colour fragment `l60Frag` of L60-REAL (`Plane/ValidMap/UnitArc`: the arc `r([0, 60°])` of `ω(0)` with sides `0` inside and
`1` outside), the sub-arc `r([π/8, 5π/24])` satisfies every hypothesis of `exists_collarFit` and of `bend_toward_collar` together
(`hF`, `hA`, `hout`, `hfree`; `ε` is free): it is a constant-sided unit arc (a sub-arc of
`l60Frag_isRingArc`), the outer colour `1` is not carried at the centre `0` (its class lies in `B(1 + e 60°, 1)`, which is `√3` from
`0`), and near each of its points `Γ` is `ω(0)` (the other four arcs are circles about `1` and `e 60°` of radii `1` and `1/4`, and the
points of the sub-arc are at distance strictly between `1/4` and `1` from both: `quarter_lt_chord`). The sub-arc is not maximal
(the whole arc `r([0, π/3])` holds it), and neither theorem asks for a maximal one. -/
theorem collarModel_hyps :
    l60Frag.Valid ∧ l60Frag.IsRingArc 0 (π / 8) (5 * π / 24) 0 1 ∧ (1 : Fin 4) ∉ l60Frag.coloursAt 0 ∧
      (∀ θ ∈ Ioo (π / 8) (5 * π / 24), ∃ r > 0, l60Frag.Γ ∩ ball (ringPt 0 θ) r ⊆ sphere 0 1) := by
  have hπ := Real.pi_pos
  have hA := l60Frag_isRingArc
  -- the sub-arc
  have hsub : l60Frag.IsRingArc 0 (π / 8) (5 * π / 24) 0 1 :=
    ⟨by linarith, (image_mono (Icc_subset_Icc (by linarith) (by linarith))).trans hA.2.1,
      fun θ hθ => hA.2.2 θ ⟨by linarith [hθ.1], by linarith [hθ.2]⟩⟩
  -- the outer colour is not carried at the centre
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
      rw [sq_norm_eq]
      simp only [Complex.add_re, Complex.one_re, re_e, Complex.add_im, Complex.one_im, im_e, Real.cos_pi_div_three,
        Real.sin_pi_div_three]
      nlinarith [Real.sq_sqrt (show (0 : ℝ) ≤ 3 by norm_num)]
    nlinarith [norm_nonneg ((1 : ℂ) + e (π / 3))]
  -- near each point of the sub-arc, `Γ` is `ω(0)`
  have hfree : ∀ θ ∈ Ioo (π / 8) (5 * π / 24), ∃ r > 0, l60Frag.Γ ∩ ball (ringPt 0 θ) r ⊆ sphere 0 1 := by
    intro θ hθ
    have hv : ringPt 0 θ = e θ := by simp [ringPt]
    obtain ⟨ha1, ha2⟩ := quarter_lt_chord hθ.1 (show θ < π / 3 by linarith [hθ.2])
    obtain ⟨hb1, hb2⟩ := quarter_lt_chord (show π / 8 < π / 3 - θ by linarith [hθ.2]) (show π / 3 - θ < π / 3 by linarith [hθ.1])
    have hd1 : dist (e θ) 1 = 2 * Real.sin (θ / 2) := by
      rw [dist_eq_norm, ← e_zero, norm_e_sub_e_eq, sub_zero, abs_of_pos (by linarith)]
    have hd2 : dist (e θ) (e (π / 3)) = 2 * Real.sin ((π / 3 - θ) / 2) := by
      rw [dist_eq_norm, norm_e_sub_e_eq, show (θ - π / 3) / 2 = -((π / 3 - θ) / 2) by ring, Real.sin_neg, abs_neg,
        abs_of_pos (by linarith)]
    set d₁ := dist (e θ) 1 with hd₁
    set d₂ := dist (e θ) (e (π / 3)) with hd₂
    rw [← hd1] at ha1 ha2
    rw [← hd2] at hb1 hb2
    refine ⟨min (min (d₁ - 1 / 4) (1 - d₁)) (min (d₂ - 1 / 4) (1 - d₂)),
      lt_min (lt_min (by linarith) (by linarith)) (lt_min (by linarith) (by linarith)), ?_⟩
    rintro z ⟨⟨-, hzU⟩, hzb⟩
    rw [hv, mem_ball] at hzb
    have hr1 : dist z (e θ) < d₁ - 1 / 4 := lt_of_lt_of_le hzb ((min_le_left _ _).trans (min_le_left _ _))
    have hr2 : dist z (e θ) < 1 - d₁ := lt_of_lt_of_le hzb ((min_le_left _ _).trans (min_le_right _ _))
    have hr3 : dist z (e θ) < d₂ - 1 / 4 := lt_of_lt_of_le hzb ((min_le_right _ _).trans (min_le_left _ _))
    have hr4 : dist z (e θ) < 1 - d₂ := lt_of_lt_of_le hzb ((min_le_right _ _).trans (min_le_right _ _))
    have t1 := dist_triangle z (e θ) 1
    have t2 := dist_triangle (e θ) z 1
    have t3 := dist_triangle z (e θ) (e (π / 3))
    have t4 := dist_triangle (e θ) z (e (π / 3))
    rw [dist_comm (e θ) z] at t2 t4
    -- a point of a circle is at its radius from its centre
    have hcirc : ∀ (c : ℂ) (ρ a b : ℝ), 0 ≤ ρ → z ∈ (Arc.circ c ρ a b).carrier → dist z c = ρ := by
      rintro c ρ a b hρ ⟨t, -, rfl⟩
      rw [dist_eq_norm, add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_of_nonneg hρ]
    obtain ⟨a, ha, hza⟩ := mem_iUnion₂.mp hzU
    have ha' : a ∈ l60Arcs := ha
    simp only [l60Arcs, mem_insert_iff, mem_singleton_iff] at ha'
    rcases ha' with rfl | rfl | rfl | rfl | rfl
    · exact hcirc 0 1 _ _ zero_le_one hza
    · have := hcirc 1 1 _ _ zero_le_one hza
      linarith
    · have := hcirc (e (π / 3)) 1 _ _ zero_le_one hza
      linarith
    · have := hcirc 1 (1 / 4) _ _ (by norm_num) hza
      linarith
    · have := hcirc (e (π / 3)) (1 / 4) _ _ (by norm_num) hza
      linarith
  exact ⟨l60Frag_valid, hsub, hout, hfree⟩

/-- **The model `collarModel` (B0): `CollarFit` is inhabited, with two different side colours** — `exists_collarFit` at
`collarModel_hyps`, for every `ε > 0`. So every clause lemma that takes a `CollarFit` has a model, with `c = 0 ≠ 1 = c'`. -/
theorem collarModel {ε : ℝ} (hε : 0 < ε) : ∃ R' R R'', CollarFit l60Frag 0 (π / 8) (5 * π / 24) 0 1 ε R' R R'' := by
  obtain ⟨hF, hA, hout, hfree⟩ := collarModel_hyps
  exact exists_collarFit hF hA hout hfree hε

/-- **`F` at a point of the open arc**: degree `2`, its sectors coloured `c` (inside) and `c'` (outside). Route: `Γ` near the point is
`ω(P)` (`free_open`), a two-germ sector chart (`isSectorChart_of` with the germs `(θ + π/2, 1)`, `(θ − π/2, −1)`; branches by
`exists_eq_branchPt_curveGerm`, `branchPt_curveGerm_mem`), `IsSectorChart.hasDegree`, `IsSectorChart.encard_sectorsOf`. -/
theorem CollarFit.degree_openArc (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {θ : ℝ} (hθ : θ ∈ Ioo θ₁ θ₂) :
    (∀ n, F.HasDegree (ringPt P θ) n ↔ n = 2) ∧ (F.HasRepeatedColour (ringPt P θ) ↔ c = c') := by
  obtain ⟨r₁, hr₁, hfr⟩ := hfit.free_open θ hθ
  have hvΓ : ringPt P θ ∈ F.Γ := hfit.ring.2.1 ⟨θ, Ioo_subset_Icc_self hθ, rfl⟩
  obtain ⟨r₂, hr₂, hdom⟩ := Metric.isOpen_iff.mp F.isOpen_dom _ hvΓ.1
  obtain ⟨r₃, hr₃, hsph⟩ := exists_sphere_inter_ball_subset_openArc (p := P) hθ
  set r₀ := min (min r₁ r₂) (min r₃ 1) with hr₀
  have h0 : 0 < r₀ := lt_min (lt_min hr₁ hr₂) (lt_min hr₃ one_pos)
  have h1 : r₀ ≤ r₁ := (min_le_left _ _).trans (min_le_left _ _)
  have h2 : r₀ ≤ r₂ := (min_le_left _ _).trans (min_le_right _ _)
  have h3 : r₀ ≤ r₃ := (min_le_right _ _).trans (min_le_left _ _)
  have h4 : r₀ ≤ 1 := (min_le_right _ _).trans (min_le_right _ _)
  refine degree_of_circle (q := P) (φ := θ) one_pos (by simp [ringPt]) h0 (by linarith) ((ball_subset_ball h2).trans hdom) ?_
    (fun d hd => ?_) (fun d hd => ?_)
  · apply Subset.antisymm
    · rintro z ⟨hzΓ, hzb⟩
      exact ⟨hfr ⟨hzΓ, ball_subset_ball h1 hzb⟩, hzb⟩
    · rintro z ⟨hzs, hzb⟩
      obtain ⟨t, ht, rfl⟩ := hsph ⟨hzs, ball_subset_ball h3 hzb⟩
      exact ⟨hfit.ring.2.1 ⟨t, Ioo_subset_Icc_self ht, rfl⟩, hzb⟩
  · have : d ∈ F.innerColours P (ringPt P θ) := hd
    rw [(hfit.ring.2.2 θ hθ).1] at this
    exact this
  · have : d ∈ F.outerColours P (ringPt P θ) := hd
    rw [(hfit.ring.2.2 θ hθ).2] at this
    exact this

/-- **The bent map at a point of the lens boundary**: degree `2`, sectors `c` (inside `β`) and `c'` (the lens). Route: `Γ` near the point
is one circle of radius `R` (`map_Γ`, the collar `Γ`-free), or at `X` the two arcs meeting transversally — a two-germ chart either way. -/
theorem CollarFit.map_degree_lensCurve (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {θ : ℝ} (hθ : θ ∈ Ioo θ₁ θ₂) :
    (∀ n, hfit.map.HasDegree (P + (lensProf θ₁ θ₂ R θ : ℂ) * e θ) n ↔ n = 2) ∧
      (hfit.map.HasRepeatedColour (P + (lensProf θ₁ θ₂ R θ : ℂ) * e θ) ↔ c = c') := by
  -- the point is the image of a point of the open arc, and a pushforward carries germ counts (`pushforward_hasDegree`)
  have hz : ringPt P θ ∈ F.dom := (hfit.ring.2.1 ⟨θ, Ioo_subset_Icc_self hθ, rfl⟩).1
  have hpush : (∀ m, hfit.map.HasDegree (hfit.homeo (ringPt P θ)) m ↔ F.HasDegree (ringPt P θ) m) ∧
      (hfit.map.HasRepeatedColour (hfit.homeo (ringPt P θ)) ↔ F.HasRepeatedColour (ringPt P θ)) := pushforward_hasDegree hz
  rw [hfit.homeo_ringPt hθ] at hpush
  have hFd := hfit.degree_openArc hθ
  exact ⟨fun n => (hpush.1 n).trans (hFd.1 n), hpush.2.trans hFd.2⟩

/-- **At the arc's ends the sectors are kept** (KB2's chart surgery). Route: `F`'s chart at `A` (`localSectors_disj`) has `α`'s germ
`(θ₁ + π/2, 1)` at some index `i` (`α`'s points near `A` are its branch); the bent map's chart is the same germs with `κ i := 1/R`
(`isSectorChart_of`: sorted, since the collar horn holds no other germ — `free`; branches by `map_Γ`; apart by `exists_germDir_ne_of_ne`);
the sector before `i` gains the lens (colour `c'`, as before), the sector from `i` loses it (colour `c`, as before), the others are
untouched — so the colour of every sector is kept (`IsSectorChart.encard_sectorsOf`, `IsSectorChart.hasDegree`). At `B` the same with
`(θ₂ − π/2, −1)` and `−1/R`. -/
theorem CollarFit.map_degree_end (hF : F.Valid) (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {v : ℂ}
    (hv : v = ringPt P θ₁ ∨ v = ringPt P θ₂) :
    (∀ n, hfit.map.HasDegree v n ↔ F.HasDegree v n) ∧ (hfit.map.HasRepeatedColour v ↔ F.HasRepeatedColour v) := by
  -- an end is a point of `Γ` off the open arc, fixed by the homeomorphism, and a pushforward carries germ counts; validity is not read
  have _ := hF
  have h12 := hfit.ring.1
  obtain ⟨ψ, hψ, hψ', rfl⟩ : ∃ ψ, ψ ∈ Icc θ₁ θ₂ ∧ ψ ∉ Ioo θ₁ θ₂ ∧ v = ringPt P ψ := by
    rcases hv with rfl | rfl
    · exact ⟨θ₁, ⟨le_rfl, h12.le⟩, fun h => lt_irrefl _ h.1, rfl⟩
    · exact ⟨θ₂, ⟨h12.le, le_rfl⟩, fun h => lt_irrefl _ h.2, rfl⟩
  have hΓ : ringPt P ψ ∈ F.Γ := hfit.ring.2.1 ⟨ψ, hψ, rfl⟩
  have hfix := hfit.homeo_fix_Γ hΓ (ringPt_not_mem_openArc_of_end hfit.short hψ hψ')
  have hpush : (∀ m, hfit.map.HasDegree (hfit.homeo (ringPt P ψ)) m ↔ F.HasDegree (ringPt P ψ) m) ∧
      (hfit.map.HasRepeatedColour (hfit.homeo (ringPt P ψ)) ↔ F.HasRepeatedColour (ringPt P ψ)) := pushforward_hasDegree hΓ.1
  rw [hfix] at hpush
  exact hpush

/-- **The collar is closed** (`isCompact_polarSet_Icc`: its profiles are continuous and ordered). -/
theorem CollarFit.isClosed_collarK (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') : IsClosed (collarK P θ₁ θ₂ R' R'') := by
  have hp := hfit.pushProfiles
  refine (isCompact_polarSet_Icc P hp.cont_a hp.cont_b fun θ _ => ?_).isClosed
  by_cases hθ : θ ∈ Ioo θ₁ θ₂
  · obtain ⟨-, h1, h2, h3⟩ := hp.inside θ hθ
    linarith
  · rw [(hp.off θ hθ).1, (hp.off θ hθ).2.2]

/-- **Degrees and repeated colours are carried** (clauses 6 and 7 together), by the place of `z`: an interior point of `F` goes to one of
the bent map (degree `1`, no repeated colour on either side); off the closed collar the homeomorphism is the identity on a ball, where
the maps agree (`hasDegree_iff_of_agree`); on the collar and on `Γ` the point is on `α` (`free`) — on `α°` both sides are two-letter
words `c`, `c'` (`degree_openArc`, `map_degree_lensCurve` at `h z`, `homeo_ringPt`), at an end `h` fixes it (`map_degree_end`). -/
theorem CollarFit.map_degree_and_repeated (hF : F.Valid) (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') (z : ℂ) :
    (∀ n, hfit.map.HasDegree (hfit.homeo z) n ↔ F.HasDegree z n) ∧
      (hfit.map.HasRepeatedColour (hfit.homeo z) ↔ F.HasRepeatedColour z) := by
  -- no repeated colour at an interior point (its chart has no germ)
  have hnorep : ∀ {G : ArcMap k} {v : ℂ}, v ∈ G.interiorPts → ¬ G.HasRepeatedColour v := by
    intro G v hv
    obtain ⟨r₀, m, Gm, hC⟩ := localSectors G hv.1
    have hm : m = 0 := by
      by_contra hm
      exact hv.2 (hC.mem_Γ.mpr (Nat.pos_of_ne_zero hm)).2
    exact hC.not_hasRepeatedColour_of_zero hm
  by_cases hzI : z ∈ F.interiorPts
  · have hzM : hfit.homeo z ∈ hfit.map.interiorPts := (pushforward_mem_interiorPts_iff z).mpr hzI
    exact ⟨fun n => (hasDegree_iff_of_mem_interiorPts hzM n).trans (hasDegree_iff_of_mem_interiorPts hzI n).symm,
      iff_of_false (hnorep hzM) (hnorep hzI)⟩
  by_cases hzK : z ∈ collarK P θ₁ θ₂ R' R''
  · -- on `α`
    have hzΓ : z ∈ F.Γ := ⟨hfit.sub_dom hzK, by_contra fun h => hzI ⟨hfit.sub_dom hzK, h⟩⟩
    obtain ⟨θ, hθ, rfl⟩ := hfit.free ⟨hzΓ, hzK⟩
    by_cases hθ' : θ ∈ Ioo θ₁ θ₂
    · rw [hfit.homeo_ringPt hθ']
      have hFd := hfit.degree_openArc hθ'
      have hMd := hfit.map_degree_lensCurve hθ'
      exact ⟨fun n => (hMd.1 n).trans (hFd.1 n).symm, hMd.2.trans hFd.2.symm⟩
    · have hfix := hfit.homeo_fix_Γ hzΓ (ringPt_not_mem_openArc_of_end hfit.short hθ hθ')
      rw [hfix]
      refine hfit.map_degree_end hF ?_
      rcases eq_or_lt_of_le hθ.1 with h1 | h1
      · exact Or.inl (by rw [h1])
      · exact Or.inr (by rw [le_antisymm hθ.2 (not_lt.mp fun h2 => hθ' ⟨h1, h2⟩)])
  · -- off the closed collar the homeomorphism is the identity on a ball
    obtain ⟨r, hr, hball⟩ := Metric.isOpen_iff.mp hfit.isClosed_collarK.isOpen_compl z hzK
    have hid : ∀ x ∈ ball z r, hfit.homeo.symm x = x := fun x hx => (hfit.homeo_eq_self (hball hx)).2
    rw [(hfit.homeo_eq_self hzK).1]
    refine hasDegree_iff_of_agree hr (fun x hx => ?_) (fun x hx _ => ?_)
    · have := (pushforward_mem_interiorPts_iff (hfit.homeo.symm x) :
        hfit.homeo (hfit.homeo.symm x) ∈ hfit.map.interiorPts ↔ hfit.homeo.symm x ∈ F.interiorPts)
      rwa [hfit.homeo.apply_symm_apply, hid x hx] at this
    · show F.col (hfit.homeo.symm x) = F.col x
      rw [hid x hx]

/-- **Degrees are carried** (clause 6). Route, by the place of `z`: off the collar the maps agree near `z` (`homeo_eq_self` on a ball,
`hasDegree_iff_of_agree`); at interior points of the collar both are interior (`hasDegree_iff_of_mem_interiorPts`); on the open arc
`degree_openArc` and `map_degree_lensCurve` at `h z` (`homeo_ringPt`); at the ends `map_degree_end` (`h` fixes them). -/
theorem CollarFit.map_hasDegree (hF : F.Valid) (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') (z : ℂ) (n : ℕ) :
    hfit.map.HasDegree (hfit.homeo z) n ↔ F.HasDegree z n := by
  exact (hfit.map_degree_and_repeated hF z).1 n

/-- **Repeated colours are carried** (clause 7; the same cases, with `not_hasRepeatedColour_of_mem_interiorPts` at interior points). -/
theorem CollarFit.map_hasRepeatedColour (hF : F.Valid) (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') (z : ℂ) :
    hfit.map.HasRepeatedColour (hfit.homeo z) ↔ F.HasRepeatedColour z := by
  exact (hfit.map_degree_and_repeated hF z).2

/-- **No unit arc is created**: the bent map's `Γ` lies in `F`'s and the lens boundary's two arcs, of radius `R ≠ 1`
(`ringArcsWithin_of_Γ_subset`, `germArc_isUnitArc_iff`). -/
theorem CollarFit.map_ringArcsWithin (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') : hfit.map.RingArcsWithin F := by
  obtain ⟨hR', hR'R, hR1, -⟩ := hfit.params
  have hR : 0 < R := by linarith
  have hR1' : 1 / R ≠ 1 := fun h => by rw [div_eq_one_iff_eq hR.ne'] at h; linarith
  refine ringArcsWithin_of_Γ_subset (A' := {collarArcA P θ₁ θ₂ R, collarArcB P θ₁ θ₂ R}) rfl
    (fun a ha => hfit.collarArcs_nondegenerate a (Or.inr ha))
    (fun x _ => ⟨univ, univ_mem, (Set.toFinite ({collarArcA P θ₁ θ₂ R, collarArcB P θ₁ θ₂ R} : Set Arc)).subset
      fun a ha => ha.1⟩) ?_ ?_
  · intro a ha
    rcases ha with rfl | rfl
    · unfold collarArcA
      rw [germArc_isUnitArc_iff, abs_of_pos (by positivity)]
      exact hR1'
    · unfold collarArcB
      rw [germArc_isUnitArc_iff, abs_neg, abs_of_pos (by positivity)]
      exact hR1'
  · intro z hz
    rw [hfit.map_Γ] at hz
    rcases hz with ⟨hzΓ, -⟩ | hzL
    · exact Or.inl hzΓ
    · right
      rw [← collarArcs_carrier (by linarith) hR1 hfit.ring.1 hfit.short] at hzL
      rcases hzL with h | h
      · exact mem_iUnion₂.mpr ⟨_, Or.inl rfl, h⟩
      · exact mem_iUnion₂.mpr ⟨_, Or.inr rfl, h⟩

/-- **The side of a second unit circle, in an end's frame** (pure algebra). A unit vector `m` with frame components `(α, β)`,
`(α, β) ≠ (1, 0)`; points `(X, Y)` of the collar's crescent on the arc's side (`σ X ≥ 0`). Close to the end, the sign of
`|w + m|² − 1 = |w|² + 2(αY + βX)` is constant: the crescent hugs the tangent (`|Y| ≤ |w|²`), so the tangential term `2βX` decides,
and where `β = 0` the circle is the one tangent from outside (`α = −1`). -/
theorem side_core {α β σ : ℝ} (hαβ : α ^ 2 + β ^ 2 = 1) (hne : ¬ (α = 1 ∧ β = 0)) (hσ : σ = 1 ∨ σ = -1) :
    ∃ ρ > 0, (∀ X Y R' R'' : ℝ, 1 / 2 < R' → 1 < R'' → 0 ≤ σ * X → 0 ≤ 2 * R' * Y + (X ^ 2 + Y ^ 2) →
        2 * R'' * Y + (X ^ 2 + Y ^ 2) ≤ 0 → 0 < X ^ 2 + Y ^ 2 → X ^ 2 + Y ^ 2 < ρ → 0 < X ^ 2 + Y ^ 2 + 2 * (α * Y + β * X)) ∨
      (∀ X Y R' R'' : ℝ, 1 / 2 < R' → 1 < R'' → 0 ≤ σ * X → 0 ≤ 2 * R' * Y + (X ^ 2 + Y ^ 2) →
        2 * R'' * Y + (X ^ 2 + Y ^ 2) ≤ 0 → 0 < X ^ 2 + Y ^ 2 → X ^ 2 + Y ^ 2 < ρ → X ^ 2 + Y ^ 2 + 2 * (α * Y + β * X) < 0) := by
  have hσ2 : σ ^ 2 = 1 := by rcases hσ with rfl | rfl <;> norm_num
  have hα1 : α ≤ 1 := by nlinarith [sq_nonneg β, sq_nonneg (α - 1)]
  have hα2 : -1 ≤ α := by nlinarith [sq_nonneg β, sq_nonneg (α + 1)]
  have hβX : ∀ X : ℝ, β * X = σ * β * (σ * X) := fun X => by linear_combination (-(β * X)) * hσ2
  have hA2 : ∀ X Y : ℝ, (σ * X) ^ 2 = X ^ 2 + Y ^ 2 - Y ^ 2 := fun X Y => by linear_combination X ^ 2 * hσ2
  rcases lt_trichotomy (σ * β) 0 with hb0 | hb0 | hb0
  · -- the tangential term is negative: inside
    have hb2 : 0 < (σ * β) ^ 2 := by nlinarith [mul_pos_of_neg_of_neg hb0 hb0]
    refine ⟨min (1 / 2) (2 * (σ * β) ^ 2 / 9), lt_min (by norm_num) (by positivity), Or.inr ?_⟩
    intro X Y R' R'' hR' hR'' hX h1 h2 hN hρ
    obtain ⟨hY0, hYN⟩ := crescent_Y hR' hR'' h1 h2
    rw [hβX]
    exact side_core_neg hb0 hX (hA2 X Y) hY0 hYN hN (lt_of_lt_of_le hρ (min_le_left _ _))
      (lt_of_lt_of_le hρ (min_le_right _ _)) hα2
  · -- the circle is tangent to the arc's at the end, from outside
    have hβ : β = 0 := by
      rcases hσ with rfl | rfl
      · linarith
      · linarith
    have hα : α = -1 := by
      have h1 : α ^ 2 = 1 := by rw [hβ] at hαβ; linarith
      have h2 : (α - 1) * (α + 1) = 0 := by ring_nf; linarith
      rcases mul_eq_zero.mp h2 with h | h
      · exact absurd ⟨by linarith, hβ⟩ hne
      · linarith
    refine ⟨1, one_pos, Or.inl ?_⟩
    intro X Y R' R'' hR' hR'' hX h1 h2 hN hρ
    obtain ⟨hY0, -⟩ := crescent_Y hR' hR'' h1 h2
    rw [hα, hβ]
    linarith
  · -- the tangential term is positive: outside
    refine ⟨min (1 / 2) (2 * (σ * β) ^ 2), lt_min (by norm_num) (by positivity), Or.inl ?_⟩
    intro X Y R' R'' hR' hR'' hX h1 h2 hN hρ
    obtain ⟨hY0, hYN⟩ := crescent_Y hR' hR'' h1 h2
    rw [hβX]
    exact side_core_pos hb0 hX (hA2 X Y) hY0 hYN hN (lt_of_lt_of_le hρ (min_le_left _ _))
      (lt_of_lt_of_le hρ (min_le_right _ _)) hα1

/-- **Near an end the collar lies on one side of every other unit circle**: for `Q ≠ P` and an end `x` of the arc there is a radius
within which every collar point but `x` is inside `ω(Q)`, or every one is outside. On `ω(Q)` this is `side_core` in the end's frame
(`collarK_frame`); off it, continuity of the distance. -/
theorem CollarFit.exists_one_side (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {Q x : ℂ} (hQ : Q ≠ P)
    (hx : x = ringPt P θ₁ ∨ x = ringPt P θ₂) :
    ∃ ρ > 0, (∀ z ∈ collarK P θ₁ θ₂ R' R'', z ≠ x → dist z x < ρ → dist z Q < 1) ∨
      (∀ z ∈ collarK P θ₁ θ₂ R' R'', z ≠ x → dist z x < ρ → 1 < dist z Q) := by
  obtain ⟨hR', hR'R, hR1, hR''⟩ := hfit.params
  rcases lt_trichotomy (dist x Q) 1 with hlt | heq | hgt
  · exact ⟨1 - dist x Q, by linarith, Or.inl fun z _ _ hz => by linarith [dist_triangle z x Q]⟩
  · -- on `ω(Q)`: the frame at the end
    obtain ⟨θE, σ, hσ, rfl, hfr⟩ : ∃ θE σ : ℝ, (σ = 1 ∨ σ = -1) ∧ x = ringPt P θE ∧
        ∀ z ∈ collarK P θ₁ θ₂ R' R'', ∃ X Y : ℝ, z - ringPt P θE = ((Y : ℂ) + (X : ℂ) * I) * e θE ∧ 0 ≤ σ * X ∧
          0 ≤ 2 * R' * Y + (X ^ 2 + Y ^ 2) ∧ 2 * R'' * Y + (X ^ 2 + Y ^ 2) ≤ 0 := by
      rcases hx with rfl | rfl
      · refine ⟨θ₁, 1, Or.inl rfl, rfl, fun z hz => ?_⟩
        obtain ⟨X, Y, h0, h1, h2, h3⟩ := (collarK_frame hR' hR'' hfit.short hz).1
        exact ⟨X, Y, h0, by linarith, h2, h3⟩
      · refine ⟨θ₂, -1, Or.inr rfl, rfl, fun z hz => ?_⟩
        obtain ⟨X, Y, h0, h1, h2, h3⟩ := (collarK_frame hR' hR'' hfit.short hz).2
        exact ⟨X, Y, h0, by linarith, h2, h3⟩
    set m : ℂ := ringPt P θE - Q with hm
    set g : ℂ := m * starRingEnd ℂ (e θE) with hg
    have hmn : ‖m‖ = 1 := by rw [hm, ← dist_eq_norm]; exact heq
    have hgn : Complex.normSq g = 1 := by
      rw [hg, Complex.normSq_mul, Complex.normSq_conj, Complex.normSq_eq_norm_sq, Complex.normSq_eq_norm_sq, hmn, norm_e]
      norm_num
    have hαβ : g.re ^ 2 + g.im ^ 2 = 1 := by rw [← hgn, Complex.normSq_apply]; ring
    have hmg : m = g * e θE := by
      rw [hg, mul_assoc, mul_comm (starRingEnd ℂ (e θE)), e_mul_conj_e, mul_one]
    have hne : ¬ (g.re = 1 ∧ g.im = 0) := by
      rintro ⟨h1, h2⟩
      have hg1 : g = 1 := Complex.ext (by simpa using h1) (by simpa using h2)
      apply hQ
      have : ringPt P θE - Q = e θE := by rw [← hm, hmg, hg1, one_mul]
      rw [ringPt] at this
      linear_combination -this
    obtain ⟨ρ, hρ, hcore⟩ := side_core hαβ hne hσ
    -- the distance to `Q` in the frame
    have hdist : ∀ z : ℂ, ∀ X Y : ℝ, z - ringPt P θE = ((Y : ℂ) + (X : ℂ) * I) * e θE →
        dist z Q ^ 2 = X ^ 2 + Y ^ 2 + 2 * (g.re * Y + g.im * X) + 1 ∧ dist z (ringPt P θE) ^ 2 = X ^ 2 + Y ^ 2 := by
      intro z X Y hz
      have hzQ : z - Q = ((Y : ℂ) + (X : ℂ) * I + g) * e θE := by
        rw [add_mul, ← hmg, ← hz, hm]; ring
      have hre : ((Y : ℂ) + (X : ℂ) * I + g).re = Y + g.re := by simp
      have him : ((Y : ℂ) + (X : ℂ) * I + g).im = X + g.im := by simp
      refine ⟨?_, ?_⟩
      · rw [dist_eq_norm, hzQ, norm_mul, norm_e, mul_one, ← Complex.normSq_eq_norm_sq, Complex.normSq_apply, hre, him]
        linear_combination hαβ
      · rw [dist_eq_norm, hz, norm_mul, norm_e, mul_one, ← Complex.normSq_eq_norm_sq, Complex.normSq_apply]
        simp
        ring
    have hsmall : ∀ z : ℂ, z ≠ ringPt P θE → dist z (ringPt P θE) < min 1 ρ → ∀ X Y : ℝ,
        dist z (ringPt P θE) ^ 2 = X ^ 2 + Y ^ 2 → 0 < X ^ 2 + Y ^ 2 ∧ X ^ 2 + Y ^ 2 < ρ := by
      intro z hzx hzd X Y hN
      have hd0 : 0 < dist z (ringPt P θE) := dist_pos.mpr hzx
      have hd1 : dist z (ringPt P θE) < 1 := lt_of_lt_of_le hzd (min_le_left _ _)
      have hd2 : dist z (ringPt P θE) < ρ := lt_of_lt_of_le hzd (min_le_right _ _)
      rw [← hN]
      exact ⟨by positivity, by nlinarith⟩
    refine ⟨min 1 ρ, lt_min one_pos hρ, ?_⟩
    rcases hcore with hc | hc
    · refine Or.inr fun z hzK hzx hzd => ?_
      obtain ⟨X, Y, hz, hX, h1, h2⟩ := hfr z hzK
      obtain ⟨hdQ, hdx⟩ := hdist z X Y hz
      obtain ⟨hN0, hNρ⟩ := hsmall z hzx hzd X Y hdx
      have := hc X Y R' R'' hR' hR'' hX h1 h2 hN0 hNρ
      nlinarith [dist_nonneg (x := z) (y := Q)]
    · refine Or.inl fun z hzK hzx hzd => ?_
      obtain ⟨X, Y, hz, hX, h1, h2⟩ := hfr z hzK
      obtain ⟨hdQ, hdx⟩ := hdist z X Y hz
      obtain ⟨hN0, hNρ⟩ := hsmall z hzx hzd X Y hdx
      have := hc X Y R' R'' hR' hR'' hX h1 h2 hN0 hNρ
      nlinarith [dist_nonneg (x := z) (y := Q)]
  · exact ⟨dist x Q - 1, by linarith, Or.inr fun z _ _ hz => by
      have := dist_triangle x z Q
      rw [dist_comm x z] at this
      linarith⟩

/-- **The homeomorphism maps the collar into itself** (ray by ray: `push1_mem_Ioo` on the open collar, the identity off it). -/
theorem CollarFit.homeo_mem_collarK (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {z : ℂ} (hz : z ∈ collarK P θ₁ θ₂ R' R'') :
    hfit.homeo z ∈ collarK P θ₁ θ₂ R' R'' := by
  have hp := hfit.pushProfiles
  by_cases hO : z ∈ polarSet P (Ioo θ₁ θ₂) (fun θ => Ioo (lensProf θ₁ θ₂ R' θ) (outerProf θ₁ θ₂ R'' θ))
  · obtain ⟨ψ, hψ, t, ht, rfl⟩ := hO
    have hin := hp.inside ψ hψ
    have ht0 : 0 < t := hin.1.trans ht.1
    rw [CollarFit.homeo, pushHomeo_polar hp hψ ht0]
    have := push1_mem_Ioo (m := 1) (m' := lensProf θ₁ θ₂ R ψ) (by linarith) hin.2.2.2 hin.2.1 (by linarith) ht
    exact ⟨ψ, Ioo_subset_Icc_self hψ, _, Ioo_subset_Icc_self this, rfl⟩
  · rw [CollarFit.homeo, (pushHomeo_eq_self hp hO).1]
    exact hz

/-- **The sides of a unit circle through an end are kept**: near `A` the two maps differ only on the collar's horn (with `α`), which misses
`ω(Q)` for `Q ≠ P` (its germs at `A` are `α`'s direction with curvature near `1`; `ω(Q)`'s there have another direction or curvature
`−1`) and so lies on one side of it; on that side both maps carry `c` and `c'` up to `A`. -/
theorem CollarFit.sides_end (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {Q x : ℂ} (hQ : Q ≠ P)
    (hx : x = ringPt P θ₁ ∨ x = ringPt P θ₂) :
    hfit.map.innerColours Q x = F.innerColours Q x ∧ hfit.map.outerColours Q x = F.outerColours Q x := by
  have h12 := hfit.ring.1
  obtain ⟨ρ, hρ, hside⟩ := hfit.exists_one_side hQ hx
  -- the end is fixed
  have hfix : hfit.homeo x = x := by
    obtain ⟨ψ, hψ, hψ', rfl⟩ : ∃ ψ, ψ ∈ Icc θ₁ θ₂ ∧ ψ ∉ Ioo θ₁ θ₂ ∧ x = ringPt P ψ := by
      rcases hx with rfl | rfl
      · exact ⟨θ₁, ⟨le_rfl, h12.le⟩, fun h => lt_irrefl _ h.1, rfl⟩
      · exact ⟨θ₂, ⟨h12.le, le_rfl⟩, fun h => lt_irrefl _ h.2, rfl⟩
    exact hfit.homeo_fix_Γ (hfit.ring.2.1 ⟨ψ, hψ, rfl⟩) (ringPt_not_mem_openArc hfit.short hψ hψ')
  -- a ball about the end whose image stays within `ρ` of it
  obtain ⟨δ, hδ, hδb⟩ := Metric.continuousAt_iff.mp hfit.homeo.continuous.continuousAt ρ hρ
  rw [hfix] at hδb
  set ρ' := min δ ρ with hρ'
  have hρ'0 : 0 < ρ' := lt_min hδ hρ
  -- on that ball the homeomorphism moves no point across `ω(Q)`
  have hiff : ∀ z ∈ ball x ρ', (dist (hfit.homeo z) Q < 1 ↔ dist z Q < 1) ∧ (dist (hfit.homeo z) Q ≤ 1 ↔ dist z Q ≤ 1) := by
    intro z hz
    by_cases hzK : z ∈ collarK P θ₁ θ₂ R' R''
    · by_cases hzx : z = x
      · rw [hzx, hfix]
        exact ⟨Iff.rfl, Iff.rfl⟩
      · have h1 : dist z x < ρ := lt_of_lt_of_le (mem_ball.mp hz) (min_le_right _ _)
        have h2 : dist (hfit.homeo z) x < ρ := hδb (lt_of_lt_of_le (mem_ball.mp hz) (min_le_left _ _))
        have hne : hfit.homeo z ≠ x := fun h => hzx (hfit.homeo.injective (h.trans hfix.symm))
        rcases hside with hs | hs
        · have a1 := hs z hzK hzx h1
          have a2 := hs _ (hfit.homeo_mem_collarK hzK) hne h2
          exact ⟨iff_of_true a2 a1, iff_of_true a2.le a1.le⟩
        · have a1 := hs z hzK hzx h1
          have a2 := hs _ (hfit.homeo_mem_collarK hzK) hne h2
          exact ⟨iff_of_false (not_lt.mpr a2.le) (not_lt.mpr a1.le), iff_of_false (not_le.mpr a2) (not_le.mpr a1)⟩
    · rw [(hfit.homeo_eq_self hzK).1]
      exact ⟨Iff.rfl, Iff.rfl⟩
  -- the closures at the end, of a class met with a set the homeomorphism respects near the end
  have key : ∀ S : Set ℂ, (∀ z ∈ ball x ρ', (hfit.homeo z ∈ S ↔ z ∈ S)) → ∀ d : Fin k,
      x ∈ closure (hfit.map.region d ∩ S) ↔ x ∈ closure (F.region d ∩ S) := by
    intro S hS d
    have hreg : hfit.map.region d = hfit.homeo '' F.region d := pushforward_region d
    have hWo : IsOpen (hfit.homeo '' ball x ρ') := hfit.homeo.isOpenMap _ isOpen_ball
    have hxW : x ∈ hfit.homeo '' ball x ρ' := ⟨x, mem_ball_self hρ'0, hfix⟩
    have himg : hfit.homeo '' ball x ρ' ∩ (hfit.homeo '' F.region d ∩ S) = hfit.homeo '' (ball x ρ' ∩ (F.region d ∩ S)) := by
      ext y
      constructor
      · rintro ⟨⟨z, hzW, rfl⟩, ⟨z', hz', hzz⟩, hyS⟩
        obtain rfl := hfit.homeo.injective hzz
        exact ⟨z', ⟨hzW, hz', (hS z' hzW).mp hyS⟩, rfl⟩
      · rintro ⟨z, ⟨hzW, hzr, hzS⟩, rfl⟩
        exact ⟨⟨z, hzW, rfl⟩, ⟨z, hzr, rfl⟩, (hS z hzW).mpr hzS⟩
    have hloc : x ∈ closure (hfit.homeo '' F.region d ∩ S) ↔
        x ∈ closure (hfit.homeo '' ball x ρ' ∩ (hfit.homeo '' F.region d ∩ S)) :=
      ⟨fun h => hWo.inter_closure ⟨hxW, h⟩, fun h => closure_mono inter_subset_right h⟩
    rw [hreg, hloc, himg, ← hfit.homeo.image_closure]
    constructor
    · rintro ⟨y, hy, hyx⟩
      have hyx' : y = x := hfit.homeo.injective (hyx.trans hfix.symm)
      rw [hyx'] at hy
      exact closure_mono inter_subset_right hy
    · intro h
      exact ⟨x, isOpen_ball.inter_closure ⟨mem_ball_self hρ'0, h⟩, hfix⟩
  refine ⟨Set.ext fun d => ?_, Set.ext fun d => ?_⟩
  · exact key (ball Q 1) (fun z hz => by simp only [mem_ball]; exact (hiff z hz).1) d
  · show x ∈ closure (hfit.map.region d \ closedBall Q 1) ↔ x ∈ closure (F.region d \ closedBall Q 1)
    rw [sdiff_eq, sdiff_eq]
    exact key (closedBall Q 1)ᶜ (fun z hz => by
      simp only [mem_compl_iff, mem_closedBall]; exact not_congr (hiff z hz).2) d

/-- **The sides at a point of `F.Γ` off the open arc are kept** (the common step of R1 and R2): off the closed lens the two maps agree
near the point (`map_agreesOff`, closures being local); on it, such a point is an end of `α` (the open collar is interior in `F`), where
`sides_end` applies for a centre other than `P`. -/
theorem CollarFit.sides_eq (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {Q x : ℂ} (hxΓ : x ∈ F.Γ)
    (hxO : x ∉ ringPt P '' Ioo θ₁ θ₂) (hQ : (x = ringPt P θ₁ ∨ x = ringPt P θ₂) → Q ≠ P) :
    hfit.map.innerColours Q x = F.innerColours Q x ∧ hfit.map.outerColours Q x = F.outerColours Q x := by
  have hp := hfit.pushProfiles
  by_cases hxV : x ∈ polarSet P (Icc θ₁ θ₂) fun θ => Icc (lensProf θ₁ θ₂ R θ) 1
  · obtain ⟨ψ, hψ, t, ht, hxe⟩ := hxV
    by_cases hψ' : ψ ∈ Ioo θ₁ θ₂
    · exfalso
      rcases eq_or_lt_of_le ht.2 with ht1 | ht1
      · subst ht1
        exact hxO ⟨ψ, hψ', by rw [hxe]; simp [ringPt]⟩
      · exact (hfit.kin_subset ⟨ψ, hψ', t, ⟨(hp.inside ψ hψ').2.1.le.trans ht.1, ht1⟩, hxe⟩).1.2 hxΓ.2
    · have ht1 : t = 1 := le_antisymm ht.2 ((hp.off ψ hψ').2.1 ▸ ht.1)
      have hxe' : x = ringPt P ψ := by rw [hxe, ht1]; simp [ringPt]
      have hend : x = ringPt P θ₁ ∨ x = ringPt P θ₂ := by
        rcases eq_or_lt_of_le hψ.1 with h1 | h1
        · exact Or.inl (hxe'.trans (by rw [h1]))
        · exact Or.inr (hxe'.trans (by rw [le_antisymm hψ.2 (not_lt.mp fun h2 => hψ' ⟨h1, h2⟩)]))
      exact hfit.sides_end (hQ hend) hend
  · have hO : IsOpen (polarSet P (Icc θ₁ θ₂) fun θ => Icc (lensProf θ₁ θ₂ R θ) 1)ᶜ := hfit.isClosed_closedLens.isOpen_compl
    have hag : ∀ z ∈ (polarSet P (Icc θ₁ θ₂) fun θ => Icc (lensProf θ₁ θ₂ R θ) 1)ᶜ,
        (z ∈ hfit.map.interiorPts ↔ z ∈ F.interiorPts) ∧ hfit.map.col z = F.col z :=
      fun z hz => ⟨(hfit.map_agreesOff.2 z fun hzU => hz (hfit.lens_subset_closedLens hzU)).1.symm,
        (hfit.map_agreesOff.2 z fun hzU => hz (hfit.lens_subset_closedLens hzU)).2.symm⟩
    have hloc := fun j S => mem_closure_region_inter_iff_of_agree hO hxV (fun z hz => (hag z hz).1)
      (fun z hz => (hag z hz).2) j S
    refine ⟨Set.ext fun j => hloc j (ball Q 1), Set.ext fun j => ?_⟩
    show x ∈ closure (hfit.map.region j \ closedBall Q 1) ↔ x ∈ closure (F.region j \ closedBall Q 1)
    rw [sdiff_eq, sdiff_eq]
    exact hloc j (closedBall Q 1)ᶜ

/-- **R1** (clause 8). Route: the arc lies in `F`'s `Γ` (`map_ringArcsWithin`); its interior points are off `α°` (`α° ∩ M.Γ = ∅`) and off
`β°` (`β° ⊆ F`'s interior points), so off the collar — where the maps agree near the point — or at an end (`sides_end`; `Q ≠ P`, since a
ring arc of `ω(P)` in the bent map misses `α°` and lies in `F`'s). -/
theorem CollarFit.map_R1 (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {Q : ℂ} {a b : ℝ} {d d' : Fin k}
    (h : hfit.map.IsRingArc Q a b d d') : F.IsRingArc Q a b d d' := by
  obtain ⟨hab, hsub, hsides⟩ := h
  obtain ⟨hR', hR'R, hR1, -⟩ := hfit.params
  have hR : 0 < R := by linarith
  have hp := hfit.pushProfiles
  -- the closed arc lies in `F.Γ`: it meets the two collar arcs (radius `R ≠ 1`) finitely, and off them `M.Γ ⊆ F.Γ`
  have hfinA : ∀ a' ∈ ({collarArcA P θ₁ θ₂ R, collarArcB P θ₁ θ₂ R} : Set Arc), (a'.carrier ∩ sphere Q 1).Finite := by
    intro a' ha'
    rcases a'.finite_inter_sphere_or_eq_circ (hfit.collarArcs_nondegenerate a' (Or.inr ha')) Q with h | ⟨θa, θb, he⟩
    · exact h
    · exfalso
      have hu : a'.IsUnitArc := by rw [he]; rfl
      rcases ha' with rfl | rfl
      · unfold collarArcA at hu
        rw [germArc_isUnitArc_iff, abs_of_pos (by positivity), div_eq_one_iff_eq hR.ne'] at hu
        linarith
      · unfold collarArcB at hu
        rw [germArc_isUnitArc_iff, abs_neg, abs_of_pos (by positivity), div_eq_one_iff_eq hR.ne'] at hu
        linarith
  have hC : (((collarArcA P θ₁ θ₂ R).carrier ∪ (collarArcB P θ₁ θ₂ R).carrier) ∩ sphere Q 1).Finite := by
    rw [union_inter_distrib_right]
    exact (hfinA _ (Or.inl rfl)).union (hfinA _ (Or.inr rfl))
  have hΓF : ringArc Q a b ⊆ F.Γ := by
    refine F.ringArc_subset_Γ_of_finite hab (fun y hy => (hsub hy).1) hC ?_
    rintro y ⟨hy, hyC⟩
    have hyM := hsub hy
    rw [hfit.map_Γ] at hyM
    rcases hyM with ⟨hyΓ, -⟩ | hyL
    · exact hyΓ
    · refine absurd ⟨?_, ?_⟩ hyC
      · rw [collarArcs_carrier (by linarith) hR1 hfit.ring.1 hfit.short]; exact hyL
      · obtain ⟨θ, -, rfl⟩ := hy; exact ringPt_mem_sphere _ _
  refine ⟨hab, hΓF, fun θ hθ => ?_⟩
  have hxΓ : ringPt Q θ ∈ F.Γ := hΓF ⟨θ, Ioo_subset_Icc_self hθ, rfl⟩
  have hxM : ringPt Q θ ∈ hfit.map.Γ := hsub ⟨θ, Ioo_subset_Icc_self hθ, rfl⟩
  obtain ⟨hMin, hMout⟩ := hsides θ hθ
  by_cases hxV : ringPt Q θ ∈ polarSet P (Icc θ₁ θ₂) fun θ => Icc (lensProf θ₁ θ₂ R θ) 1
  · -- on the closed lens and on `F.Γ`, a point of the bent map's `Γ` is an end of `α`
    obtain ⟨ψ, hψ, t, ht, hxe⟩ := hxV
    by_cases hψ' : ψ ∈ Ioo θ₁ θ₂
    · exfalso
      rcases eq_or_lt_of_le ht.2 with ht1 | ht1
      · subst ht1
        exact (hfit.map_lens ⟨ψ, hψ', 1, ⟨(hp.inside ψ hψ').2.2.1, le_rfl⟩, hxe⟩).1.2 hxM.2
      · exact (hfit.kin_subset ⟨ψ, hψ', t, ⟨(hp.inside ψ hψ').2.1.le.trans ht.1, ht1⟩, hxe⟩).1.2 hxΓ.2
    · have ht1 : t = 1 := le_antisymm ht.2 ((hp.off ψ hψ').2.1 ▸ ht.1)
      have hxe' : ringPt Q θ = ringPt P ψ := by rw [hxe, ht1]; simp [ringPt]
      have hψe : ψ = θ₁ ∨ ψ = θ₂ := by
        rcases eq_or_lt_of_le hψ.1 with h1 | h1
        · exact Or.inl h1.symm
        · exact Or.inr (le_antisymm hψ.2 (not_lt.mp fun h2 => hψ' ⟨h1, h2⟩))
      -- `Q ≠ P`: an arc of `ω(P)` in the bent map's `Γ` through an end would continue into the open arc, interior there
      have hQ : Q ≠ P := by
        rintro rfl
        have he : e θ = e ψ := add_left_cancel hxe'
        have h12 := hfit.ring.1
        rcases hψe with rfl | rfl
        · set s := min ((b - θ) / 2) ((θ₂ - ψ) / 2) with hs
          have hs0 : 0 < s := lt_min (by linarith [hθ.2]) (by linarith)
          have hs1 : s < b - θ := lt_of_le_of_lt (min_le_left _ _) (by linarith [hθ.2])
          have hs2 : s < θ₂ - ψ := lt_of_le_of_lt (min_le_right _ _) (by linarith)
          have hmem := hsub ⟨θ + s, ⟨by linarith [hθ.1], by linarith⟩, rfl⟩
          have hpt : ringPt Q (θ + s) = ringPt Q (ψ + s) := by simp only [ringPt, e_add, he]
          rw [hpt] at hmem
          exact (hfit.map_lens ⟨ψ + s, ⟨by linarith, by linarith⟩, 1,
            ⟨(hp.inside (ψ + s) ⟨by linarith, by linarith⟩).2.2.1, le_rfl⟩, by simp [ringPt]⟩).1.2 hmem.2
        · set s := min ((θ - a) / 2) ((ψ - θ₁) / 2) with hs
          have hs0 : 0 < s := lt_min (by linarith [hθ.1]) (by linarith)
          have hs1 : s < θ - a := lt_of_le_of_lt (min_le_left _ _) (by linarith [hθ.1])
          have hs2 : s < ψ - θ₁ := lt_of_le_of_lt (min_le_right _ _) (by linarith)
          have hmem := hsub ⟨θ - s, ⟨by linarith, by linarith [hθ.2]⟩, rfl⟩
          have hpt : ringPt Q (θ - s) = ringPt Q (ψ - s) := by
            simp only [ringPt, sub_eq_add_neg, e_add, he]
          rw [hpt] at hmem
          exact (hfit.map_lens ⟨ψ - s, ⟨by linarith, by linarith⟩, 1,
            ⟨(hp.inside (ψ - s) ⟨by linarith, by linarith⟩).2.2.1, le_rfl⟩, by simp [ringPt]⟩).1.2 hmem.2
      have hend : ringPt Q θ = ringPt P θ₁ ∨ ringPt Q θ = ringPt P θ₂ := by
        rcases hψe with rfl | rfl
        · exact Or.inl hxe'
        · exact Or.inr hxe'
      obtain ⟨hin, hout⟩ := hfit.sides_end hQ hend
      exact ⟨hin ▸ hMin, hout ▸ hMout⟩
  · -- off the closed lens the two maps agree near the point
    have hO : IsOpen (polarSet P (Icc θ₁ θ₂) fun θ => Icc (lensProf θ₁ θ₂ R θ) 1)ᶜ := hfit.isClosed_closedLens.isOpen_compl
    have hag : ∀ z ∈ (polarSet P (Icc θ₁ θ₂) fun θ => Icc (lensProf θ₁ θ₂ R θ) 1)ᶜ,
        (z ∈ hfit.map.interiorPts ↔ z ∈ F.interiorPts) ∧ hfit.map.col z = F.col z :=
      fun z hz => ⟨(hfit.map_agreesOff.2 z fun hzU => hz (hfit.lens_subset_closedLens hzU)).1.symm,
        (hfit.map_agreesOff.2 z fun hzU => hz (hfit.lens_subset_closedLens hzU)).2.symm⟩
    have hloc := fun j S => mem_closure_region_inter_iff_of_agree hO hxV (fun z hz => (hag z hz).1)
      (fun z hz => (hag z hz).2) j S
    refine ⟨?_, ?_⟩
    · rw [← hMin]
      ext j
      exact (hloc j (ball Q 1)).symm
    · rw [← hMout]
      ext j
      show ringPt Q θ ∈ closure (F.region j \ closedBall Q 1) ↔ ringPt Q θ ∈ closure (hfit.map.region j \ closedBall Q 1)
      rw [sdiff_eq, sdiff_eq]
      exact (hloc j (closedBall Q 1)ᶜ).symm

/-- **R2** (clause 9). Route: the closed arc misses `α°` (its open part by hypothesis; an end on `α°` would put an arc of `ω(Q) ≠ ω(P)` in
`Γ` near a point of `α°`, against `free_open`), so it lies in the bent map's `Γ` (`map_Γ`); sides as in `map_R1`. -/
theorem CollarFit.map_R2 (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {Q : ℂ} {a b : ℝ} {d d' : Fin k}
    (h : F.IsRingArc Q a b d d') (hd : Disjoint (ringPt Q '' Ioo a b) (ringPt P '' Ioo θ₁ θ₂)) :
    hfit.map.IsRingArc Q a b d d' := by
  obtain ⟨hab, hsub, hsides⟩ := h
  have h12 := hfit.ring.1
  -- no point of the closed arc lies on `α°`: near such a point `Γ` is `ω(P)` (`free_open`), whose points there are on `α°`, and the
  -- open arc of `ω(Q)` reaches it
  have hoff : ∀ θ ∈ Icc a b, ringPt Q θ ∉ ringPt P '' Ioo θ₁ θ₂ := by
    intro θ hθ hmem
    obtain ⟨ψ, hψ, hψe⟩ := hmem
    obtain ⟨r₁, hr₁, hfr⟩ := hfit.free_open ψ hψ
    obtain ⟨r₃, hr₃, hsph⟩ := exists_sphere_inter_ball_subset_openArc (p := P) hψ
    have hr : 0 < min r₁ r₃ := lt_min hr₁ hr₃
    obtain ⟨θ', hθ', hd'⟩ : ∃ θ' ∈ Ioo a b, dist (ringPt Q θ') (ringPt Q θ) < min r₁ r₃ := by
      have hba : 0 < b - a := by linarith
      set t := min 1 (min r₁ r₃ / (b - a)) with ht
      have ht0 : 0 < t := lt_min one_pos (div_pos hr hba)
      have ht1 : t ≤ 1 := min_le_left _ _
      have htr : t * (b - a) ≤ min r₁ r₃ := by
        have := min_le_right 1 (min r₁ r₃ / (b - a))
        rw [le_div_iff₀ hba] at this
        linarith
      refine ⟨θ + t * ((a + b) / 2 - θ), ⟨?_, ?_⟩, ?_⟩
      · nlinarith [mul_pos ht0 hba, mul_nonneg (sub_nonneg.mpr ht1) (sub_nonneg.mpr hθ.1)]
      · nlinarith [mul_pos ht0 hba, mul_nonneg (sub_nonneg.mpr ht1) (sub_nonneg.mpr hθ.2)]
      · refine lt_of_le_of_lt (dist_ringPt_ringPt_le Q _ _) ?_
        rw [show θ + t * ((a + b) / 2 - θ) - θ = t * ((a + b) / 2 - θ) by ring, abs_mul, abs_of_pos ht0]
        have : |(a + b) / 2 - θ| ≤ (b - a) / 2 := abs_le.mpr ⟨by linarith [hθ.2], by linarith [hθ.1]⟩
        nlinarith
    have hz : ringPt Q θ' ∈ F.Γ := hsub ⟨θ', Ioo_subset_Icc_self hθ', rfl⟩
    rw [← hψe] at hd'
    have h1 : ringPt Q θ' ∈ sphere P 1 := hfr ⟨hz, lt_of_lt_of_le hd' (min_le_left _ _)⟩
    exact disjoint_left.mp hd ⟨θ', hθ', rfl⟩ (hsph ⟨h1, lt_of_lt_of_le hd' (min_le_right _ _)⟩)
  refine ⟨hab, fun y ⟨θ, hθ, hy⟩ => ?_, fun θ hθ => ?_⟩
  · rw [hfit.map_Γ, ← hy]
    exact Or.inl ⟨hsub ⟨θ, hθ, rfl⟩, hoff θ hθ⟩
  · -- the sides: `sides_eq`, with `Q ≠ P` at an end (an arc of `ω(P)` through an end continues into `α°`)
    have hQ : (ringPt Q θ = ringPt P θ₁ ∨ ringPt Q θ = ringPt P θ₂) → Q ≠ P := by
      rintro hend rfl
      rcases hend with hxe | hxe
      · have he : e θ = e θ₁ := add_left_cancel hxe
        set s := min ((b - θ) / 2) ((θ₂ - θ₁) / 2) with hs
        have hs0 : 0 < s := lt_min (by linarith [hθ.2]) (by linarith)
        have hs1 : s < b - θ := lt_of_le_of_lt (min_le_left _ _) (by linarith [hθ.2])
        have hs2 : s < θ₂ - θ₁ := lt_of_le_of_lt (min_le_right _ _) (by linarith)
        have hpt : ringPt Q (θ + s) = ringPt Q (θ₁ + s) := by simp only [ringPt, e_add, he]
        exact disjoint_left.mp hd ⟨θ + s, ⟨by linarith [hθ.1], by linarith⟩, rfl⟩
          ⟨θ₁ + s, ⟨by linarith, by linarith⟩, hpt.symm⟩
      · have he : e θ = e θ₂ := add_left_cancel hxe
        set s := min ((θ - a) / 2) ((θ₂ - θ₁) / 2) with hs
        have hs0 : 0 < s := lt_min (by linarith [hθ.1]) (by linarith)
        have hs1 : s < θ - a := lt_of_le_of_lt (min_le_left _ _) (by linarith [hθ.1])
        have hs2 : s < θ₂ - θ₁ := lt_of_le_of_lt (min_le_right _ _) (by linarith)
        have hpt : ringPt Q (θ - s) = ringPt Q (θ₂ - s) := by simp only [ringPt, sub_eq_add_neg, e_add, he]
        exact disjoint_left.mp hd ⟨θ - s, ⟨by linarith, by linarith [hθ.2]⟩, rfl⟩
          ⟨θ₂ - s, ⟨by linarith, by linarith⟩, hpt.symm⟩
    obtain ⟨hin, hout⟩ := hfit.sides_eq (hsub ⟨θ, Ioo_subset_Icc_self hθ, rfl⟩) (hoff θ (Ioo_subset_Icc_self hθ)) hQ
    rw [hin, hout]
    exact hsides θ hθ

/-- **R3** (clause 10): the open arc lies in the lens, interior in the bent map (`map_lens`), so off its `Γ`. -/
theorem CollarFit.map_R3 (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {θ : ℝ} (hθ : θ ∈ Ioo θ₁ θ₂) :
    ¬ hfit.map.OnRingArc P (ringPt P θ) := by
  rintro ⟨a, b, -, hx, hsub⟩
  have hL : ringPt P θ ∈ lensSet P θ₁ θ₂ R :=
    ⟨θ, hθ, 1, ⟨(hfit.pushProfiles.inside θ hθ).2.2.1, le_rfl⟩, by simp [ringPt]⟩
  exact (hfit.map_lens hL).1.2 (hsub hx).2

/-- **Only `c` is lost, and only on the lens**: every colour `F` carries at `Q` the bent map carries, but `c`, which it can lose only at a
point of `lensSet` (the open lens or the open arc). -/
theorem CollarFit.coloursAt_subset (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') (Q : ℂ) :
    F.coloursAt Q ⊆ hfit.map.coloursAt Q ∪ {c} ∧ (c ∈ F.coloursAt Q → c ∉ hfit.map.coloursAt Q → Q ∈ lensSet P θ₁ θ₂ R) := by
  have hp := hfit.pushProfiles
  have hAg := hfit.map_agreesOff
  have hcol : ∀ z, hfit.map.coloursAt (hfit.homeo z) = F.coloursAt z := fun z => pushforward_coloursAt z
  -- in `F` the closed lens holds no interior point of a colour other than `c`
  have hUc : ∀ z ∈ lensSet P θ₁ θ₂ R ∪ lensCurve P θ₁ θ₂ R, z ∈ F.interiorPts → F.col z = c := by
    have hin : ∀ θ ∈ Ioo θ₁ θ₂, ∀ t, lensProf θ₁ θ₂ R θ ≤ t → t < 1 → F.col (P + (t : ℂ) * e θ) = c := fun θ hθ t h1 h2 =>
      (hfit.kin_subset ⟨θ, hθ, t, ⟨(hp.inside θ hθ).2.1.le.trans h1, h2⟩, rfl⟩).2
    have hring : ∀ θ ∈ Icc θ₁ θ₂, P + ((1 : ℝ) : ℂ) * e θ ∉ F.interiorPts := fun θ hθ hI =>
      hI.2 (hfit.ring.2.1 ⟨θ, hθ, by simp [ringPt]⟩).2
    rintro z (⟨θ, hθ, t, ht, rfl⟩ | ⟨θ, hθ, t, ht, rfl⟩) hz
    · rcases eq_or_lt_of_le ht.2 with rfl | ht1
      · exact absurd hz (hring θ (Ioo_subset_Icc_self hθ))
      · exact hin θ hθ t ht.1.le ht1
    · rw [mem_singleton_iff] at ht
      subst ht
      by_cases hθ' : θ ∈ Ioo θ₁ θ₂
      · exact hin θ hθ' _ le_rfl (hp.inside θ hθ').2.2.1
      · rw [(hp.off θ hθ').2.1] at hz
        exact absurd hz (hring θ hθ)
  refine ⟨fun j hj => ?_, fun hcF hcM => ?_⟩
  · by_cases hjc : j = c
    · exact Or.inr hjc
    · refine Or.inl (closure_mono (fun z hz => ?_) hj)
      have hzU : z ∉ lensSet P θ₁ θ₂ R ∪ lensCurve P θ₁ θ₂ R := fun hzU =>
        hjc ((hz.2 : F.col z = j).symm.trans (hUc z hzU hz.1))
      obtain ⟨hI, hc⟩ := hAg.2 z hzU
      exact ⟨hI.mp hz.1, by show hfit.map.col z = j; rw [← hc]; exact hz.2⟩
  · by_contra hQ
    apply hcM
    by_cases hQV : Q ∈ polarSet P (Icc θ₁ θ₂) fun θ => Icc (lensProf θ₁ θ₂ R θ) 1
    · obtain ⟨θ, hθ, t, ht, rfl⟩ := hQV
      by_cases hθ' : θ ∈ Ioo θ₁ θ₂
      · -- on the open lens boundary: the image of a point of the open arc
        have htl : t = lensProf θ₁ θ₂ R θ := by
          by_contra hne
          exact hQ ⟨θ, hθ', t, ⟨lt_of_le_of_ne ht.1 (Ne.symm hne), ht.2⟩, rfl⟩
        rw [htl, ← hfit.homeo_ringPt hθ', hcol]
        have : c ∈ F.innerColours P (ringPt P θ) := by rw [(hfit.ring.2.2 θ hθ').1]; exact mem_singleton _
        exact closure_mono inter_subset_left this
      · -- at an end: a point of `Γ` off the open arc, fixed by the homeomorphism
        have ht1 : t = 1 := le_antisymm ht.2 ((hp.off θ hθ').2.1 ▸ ht.1)
        have hQe : P + (t : ℂ) * e θ = ringPt P θ := by rw [ht1]; simp [ringPt]
        rw [hQe] at hcF ⊢
        have hfix := hfit.homeo_fix_Γ (hfit.ring.2.1 ⟨θ, hθ, rfl⟩) (ringPt_not_mem_openArc_of_end hfit.short hθ hθ')
        rw [← hfix, hcol]
        exact hcF
    · -- off the closed lens the two maps agree near `Q`
      have hcl : Q ∈ closure (F.region c ∩ (polarSet P (Icc θ₁ θ₂) fun θ => Icc (lensProf θ₁ θ₂ R θ) 1)ᶜ) :=
        hfit.isClosed_closedLens.isOpen_compl.inter_closure ⟨hQV, hcF⟩ |> fun h => by
          rw [inter_comm]; exact h
      refine closure_mono (fun z hz => ?_) hcl
      have hzU : z ∉ lensSet P θ₁ θ₂ R ∪ lensCurve P θ₁ θ₂ R := fun hzU => hz.2 (hfit.lens_subset_closedLens hzU)
      obtain ⟨hI, hc⟩ := hAg.2 z hzU
      exact ⟨hI.mp hz.1.1, by show hfit.map.col z = c; rw [← hc]; exact hz.1.2⟩

/-- **A unit arc centred on the lens carries no `c` on a side**: centred on the open arc by `lock` (the class of `c` meets `ω(Q)` in at
most two points); centred in the open lens, an open subset of `c`'s class, by `Valid.dist_ne_one_of_isOpen_subset_closure`. -/
theorem CollarFit.side_ne_inner_of_mem_lens (hF : F.Valid) (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {Q : ℂ}
    (hQ : Q ∈ lensSet P θ₁ θ₂ R) {a b : ℝ} {d d' : Fin k} (h : F.IsRingArc Q a b d d') : d ≠ c ∧ d' ≠ c := by
  suffices key : ¬ ∀ θ ∈ Ioo a b, ringPt Q θ ∈ closure (F.region c) by
    refine ⟨fun hd => key fun θ hθ => ?_, fun hd => key fun θ hθ => ?_⟩
    · have : d ∈ F.innerColours Q (ringPt Q θ) := by rw [(h.2.2 θ hθ).1]; exact mem_singleton _
      rw [hd] at this
      exact closure_mono inter_subset_left this
    · have : d' ∈ F.outerColours Q (ringPt Q θ) := by rw [(h.2.2 θ hθ).2]; exact mem_singleton _
      rw [hd] at this
      exact closure_mono sdiff_subset this
  intro hall
  obtain ⟨ψ, hψ, t, ht, rfl⟩ := hQ
  rcases eq_or_lt_of_le ht.2 with ht1 | ht1
  · -- centred on the open arc: `lock` leaves the class of `c` two points on the unit circle
    subst ht1
    have hQe : P + ((1 : ℝ) : ℂ) * e ψ = ringPt P ψ := by simp [ringPt]
    rw [hQe] at hall
    have hlock := (lock hF hfit.ring hψ).2.1
    have hsub : Ioo a b ⊆ ringPt (ringPt P ψ) ⁻¹' {P, P + 2 * e ψ} := fun θ hθ =>
      hlock ⟨hall θ hθ, ringPt_mem_sphere _ _⟩
    have hcount : (ringPt (ringPt P ψ) ⁻¹' {P, P + 2 * e ψ}).Countable := by
      rw [show ({P, P + 2 * e ψ} : Set ℂ) = {P} ∪ {P + 2 * e ψ} from rfl, preimage_union]
      exact (countable_ringPt_preimage _ _).union (countable_ringPt_preimage _ _)
    have h0 := (hcount.mono hsub).measure_zero MeasureTheory.volume
    rw [Real.volume_Ioo, ENNReal.ofReal_eq_zero] at h0
    linarith [h.1]
  · -- centred in the open lens, an open part of the class of `c`
    have hQc : P + (t : ℂ) * e ψ ∈ F.region c :=
      hfit.kin_subset ⟨ψ, hψ, t, ⟨(hfit.pushProfiles.inside ψ hψ).2.1.le.trans ht.1.le, ht1⟩, rfl⟩
    obtain ⟨θ, hθ⟩ := nonempty_Ioo.mpr h.1
    exact Valid.dist_ne_one_of_isOpen_subset_closure hF (hall θ hθ) (F.isOpen_region c) subset_closure hQc
      (dist_ringPt _ _)

/-- **No inert arc is created** (clause 11): an inert arc of the bent map is a ring arc of `F` with the same sides (`map_R1`), neither side
`c` where `c` was lost (`coloursAt_subset`, `side_ne_inner_of_mem_lens`), so neither side is carried at its centre in `F`. -/
theorem CollarFit.map_inert (hF : F.Valid) (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {Q : ℂ} {a b : ℝ}
    (h : hfit.map.Inert Q a b) : F.Inert Q a b := by
  obtain ⟨d, d', hA, hd, hd'⟩ := h
  have hFA := hfit.map_R1 hA
  have key : ∀ x, (x = d ∨ x = d') → x ∉ hfit.map.coloursAt Q → x ∉ F.coloursAt Q := by
    intro x hx hxM hxF
    have hxc : x = c := ((hfit.coloursAt_subset Q).1 hxF).resolve_left hxM
    rw [hxc] at hxF hxM
    have hne := hfit.side_ne_inner_of_mem_lens hF ((hfit.coloursAt_subset Q).2 hxF hxM) hFA
    rcases hx with hx | hx
    · exact hne.1 (hx.symm.trans hxc)
    · exact hne.2 (hx.symm.trans hxc)
  exact ⟨d, d', hFA, key d (Or.inl rfl) hd, key d' (Or.inr rfl) hd'⟩

end Collar

/-- **The collar bend** (E4-BEND-UN with R1–R3; FS131-I5o's form): an arc `α = r([θ₁, θ₂])` of `Γ` on `ω(P)` with constant
sides `c` (inner), `c'` (outer), `c'` not carried at `P`, whose open arc meets no other arc of `Γ` (`hfree`: near
each interior point `Γ` is `ω(P)`), bends toward `P` inside a collar of `α` in its inner tile. The arc need not be maximal and no
bound on its length is assumed: the proof read neither, and FS131-RP1 removed `hmax` and `hlen` (inventory rulings 419 (d),
427 (a)). Inhabitant of the hypotheses, at once: `collarModel_hyps` (a sub-arc of `l60Frag`'s unit arc, sides `0` and `1`). The bent map `M` is the image of `F` under a
homeomorphism `h` of the plane supported in `thickening ε α`, fixing every point of `Γ` off `α°` (so the ends `A`, `B` and every vertex),
carrying interior points to interior points of the same colour; so colours, degrees and repeated colours are carried point by point.
Metrically: `M` is valid, on `F`'s domain; its constant-sided unit arcs are `F`'s with the same sides (R1); `F`'s whose open arc misses `α°`
survive in `M` (R2); no point of `α°` is on a unit arc of `M` centred at `P` (R3); and no inert arc is created (validity forbids a unit
arc centred on `α°` or in the lens to carry `c` on a side, so the colours lost there make nothing inert). -/
theorem bend_toward_collar (hF : F.Valid) {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} (hA : F.IsRingArc P θ₁ θ₂ c c')
    (hout : c' ∉ F.coloursAt P)
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
  -- the construction bends any constant-sided arc with a free interior (plan § 2): no length bound (`l60_le` gives one) and no
  -- maximality is assumed
  obtain ⟨R', R, R'', hfit⟩ := exists_collarFit hF hA hout hfree hε
  refine ⟨hfit.map, hfit.homeo, hfit.map_valid hF, rfl, fun z hz => (hfit.homeo_eq_self fun hK => hz (hfit.sub_thick hK)).1,
    fun z hz hzO => hfit.homeo_fix_Γ hz hzO, fun z => ⟨pushforward_mem_interiorPts_iff z, fun _ => pushforward_col_apply z⟩,
    fun z => pushforward_coloursAt z, fun z n => hfit.map_hasDegree hF z n, fun z => hfit.map_hasRepeatedColour hF z,
    fun Q a b d d' h => hfit.map_R1 h, fun Q a b d d' h hd => hfit.map_R2 h hd, fun θ hθ => hfit.map_R3 hθ,
    fun Q a b h => hfit.map_inert hF h⟩

end ArcMap

end HadwigerNelson.Plane

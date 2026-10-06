import Proofs.HadwigerNelson.Plane.ValidMap.Chain
import Proofs.HadwigerNelson.Plane.ValidMap.UnitArc
import Proofs.HadwigerNelson.Plane.LocalStructure
import Proofs.HadwigerNelson.Plane.ValidMap.RadialPush
import Proofs.HadwigerNelson.Plane.ValidMap.Pushforward

/-!
# The collar bend's map (FS131-CG1, lane G)

The collar's fit to the map (`CollarFit`), its homeomorphism, the bent map `CollarFit.map`, and the geometric clauses of
`bend_toward_collar` read off it (`map_Γ`, `map_lens`, `map_agreesOff`, `map_valid`): moved verbatim from `BendCollar` (FS131-KP2's
skeleton; inventory ruling 395 (a)), so the collar bend's two lanes never share a file. The charts, the sides, `exists_collarFit` and the
assembly stay in `BendCollar`.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

/-! ## The collar's fit to the map (FS131-KP2's skeleton; `plans/FS131-collar-kernel-plan.md` § 3)

The construction (KB2's D1): three radii `1/2 < R' < R < 1 < R''`. The lens boundary `β = lensCurve P θ₁ θ₂ R` is made of the circles of
radius `R` internally tangent to `ω(P)` at the ends (`collarArcA`, `collarArcB`); the collar `K = collarK P θ₁ θ₂ R' R''` lies between the
circles of radius `R'` (inside) and `R''` (enclosing), tangent at the ends — so at a horn end each has a germ of the arc's direction and
curvature near `1`, and fits inside the horn. The homeomorphism is the radial push about `P` across `K` sending `α` onto `β`
(`pushHomeo`); the bent map is `F`'s image under it (`pushforward`), its arcs `F`'s with the open arc cut out (`cutArcs`) and the two arcs
of `β`. Everything the map-level proofs read about `F` is in `CollarFit`, which `exists_collarFit` supplies. -/

section Collar

variable {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} {ε R' R R'' : ℝ}

/-- **The collar fits the map**: the radii are ordered; the arc is a constant-sided unit arc of at most `60°` with `Γ` free near each
interior point (`hfree`); the collar lies in the `ε`-neighbourhood of the arc and in the domain, and meets `Γ` only on the arc; and the
open lens is clear for the outer colour. Inhabitant: `exists_collarFit`, at any map satisfying `bend_toward_collar`'s hypotheses (a model
map for those is the plan's child `collarModel`, § 4). -/
structure CollarFit (F : ArcMap k) (P : ℂ) (θ₁ θ₂ : ℝ) (c c' : Fin k) (ε R' R R'' : ℝ) : Prop where
  /-- The arc is a constant-sided unit arc. -/
  ring : F.IsRingArc P θ₁ θ₂ c c'
  /-- It is at most `60°` long (`l60_le`). -/
  short : θ₂ - θ₁ ≤ π / 3
  /-- The radii. -/
  params : 1 / 2 < R' ∧ R' < R ∧ R < 1 ∧ 1 < R''
  /-- Near each interior point of the arc, `Γ` is `ω(P)`. -/
  free_open : ∀ θ ∈ Ioo θ₁ θ₂, ∃ r > 0, F.Γ ∩ ball (ringPt P θ) r ⊆ sphere P 1
  /-- The collar lies within `ε` of the arc. -/
  sub_thick : collarK P θ₁ θ₂ R' R'' ⊆ thickening ε (ringArc P θ₁ θ₂)
  /-- The collar lies in the domain. -/
  sub_dom : collarK P θ₁ θ₂ R' R'' ⊆ F.dom
  /-- The collar meets `Γ` only on the arc. -/
  free : F.Γ ∩ collarK P θ₁ θ₂ R' R'' ⊆ ringArc P θ₁ θ₂
  /-- The open lens is clear for the outer colour. -/
  clear : ∀ z ∈ polarSet P (Ioo θ₁ θ₂) (fun θ => Ioo (lensProf θ₁ θ₂ R θ) 1), F.IsClear c' z

/-- A point of the collar over the open sector off the unit circle is an interior point of `F` (`free`: the collar meets `Γ` only on
the arc). -/
theorem CollarFit.mem_interiorPts (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {θ t : ℝ} (hθ : θ ∈ Ioo θ₁ θ₂)
    (ht : t ∈ Icc (lensProf θ₁ θ₂ R' θ) (outerProf θ₁ θ₂ R'' θ)) (ht1 : t ≠ 1) : P + (t : ℂ) * e θ ∈ F.interiorPts := by
  have hK : P + (t : ℂ) * e θ ∈ collarK P θ₁ θ₂ R' R'' := ⟨θ, Ioo_subset_Icc_self hθ, t, ht, rfl⟩
  refine ⟨hfit.sub_dom hK, fun hU => ht1 ?_⟩
  obtain ⟨θ', -, hθ'⟩ := hfit.free ⟨⟨hfit.sub_dom hK, hU⟩, hK⟩
  have ht0 : 0 < t :=
    ((pushProfiles_collar hfit.params.1 hfit.params.2.1 hfit.params.2.2.1 hfit.params.2.2.2 hfit.ring.1 hfit.short).a_pos θ).trans_le ht.1
  have h := congrArg (fun z => ‖z - P‖) hθ'
  simp only [ringPt, add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs,
    abs_of_pos ht0] at h
  exact h.symm

/-- **The inner collar has the inner colour**: `{a(θ) ≤ t < 1}` over `(θ₁, θ₂)` is connected, `Γ`-free (`free`), inside `B(P, 1)`, and
its closure meets the open arc, whose inner colour is `c` alone. -/
theorem CollarFit.kin_subset (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') :
    polarSet P (Ioo θ₁ θ₂) (fun θ => Ico (lensProf θ₁ θ₂ R' θ) 1) ⊆ F.region c := by
  have hp := pushProfiles_collar hfit.params.1 hfit.params.2.1 hfit.params.2.2.1 hfit.params.2.2.2 hfit.ring.1 hfit.short
  have hca := hp.cont_a
  set a := lensProf θ₁ θ₂ R' with ha_def
  -- the inner collar is the image of a box under a continuous map
  have hS : polarSet P (Ioo θ₁ θ₂) (fun θ => Ico (a θ) 1) =
      (fun q : ℝ × ℝ => P + ((a q.1 + q.2 * (1 - a q.1) : ℝ) : ℂ) * e q.1) '' (Ioo θ₁ θ₂ ×ˢ Ico 0 1) := by
    ext z
    constructor
    · rintro ⟨θ, hθ, t, ht, rfl⟩
      have hin := hp.inside θ hθ
      have h1 : 0 < 1 - a θ := by linarith [hin.2.1, hin.2.2.1]
      refine ⟨(θ, (t - a θ) / (1 - a θ)), ⟨hθ, div_nonneg (by linarith [ht.1]) h1.le, (div_lt_one h1).mpr (by linarith [ht.2])⟩, ?_⟩
      show P + ((a θ + (t - a θ) / (1 - a θ) * (1 - a θ) : ℝ) : ℂ) * e θ = _
      rw [div_mul_cancel₀ _ h1.ne', add_sub_cancel]
    · rintro ⟨⟨θ, s⟩, ⟨hθ, hs⟩, rfl⟩
      have hin := hp.inside θ hθ
      have h1 : 0 < 1 - a θ := by linarith [hin.2.1, hin.2.2.1]
      exact ⟨θ, hθ, _, ⟨by nlinarith [mul_nonneg hs.1 h1.le], by nlinarith [mul_lt_mul_of_pos_right hs.2 h1]⟩, rfl⟩
  have hcont : Continuous (fun q : ℝ × ℝ => P + ((a q.1 + q.2 * (1 - a q.1) : ℝ) : ℂ) * e q.1) :=
    continuous_const.add ((Complex.continuous_ofReal.comp ((hca.comp continuous_fst).add
      (continuous_snd.mul (continuous_const.sub (hca.comp continuous_fst))))).mul (continuous_e.comp continuous_fst))
  have hpre : IsPreconnected (polarSet P (Ioo θ₁ θ₂) (fun θ => Ico (a θ) 1)) := by
    rw [hS]; exact (isPreconnected_Ioo.prod isPreconnected_Ico).image _ hcont.continuousOn
  have hint : polarSet P (Ioo θ₁ θ₂) (fun θ => Ico (a θ) 1) ⊆ F.interiorPts := by
    rintro _ ⟨θ, hθ, t, ht, rfl⟩
    have hin := hp.inside θ hθ
    exact hfit.mem_interiorPts hθ ⟨ht.1, by linarith [ht.2, hin.2.2.2]⟩ (ne_of_lt ht.2)
  -- the colour is constant on it, and is the arc's inner colour
  obtain ⟨θ₀, hθ₀⟩ := nonempty_Ioo.mpr hfit.ring.1
  have hin₀ := hp.inside θ₀ hθ₀
  have hz₀ : P + (a θ₀ : ℂ) * e θ₀ ∈ polarSet P (Ioo θ₁ θ₂) (fun θ => Ico (a θ) 1) :=
    ⟨θ₀, hθ₀, _, ⟨le_rfl, by linarith [hin₀.2.1, hin₀.2.2.1]⟩, rfl⟩
  have hconst : ∀ z ∈ polarSet P (Ioo θ₁ θ₂) (fun θ => Ico (a θ) 1), F.col z = F.col (P + (a θ₀ : ℂ) * e θ₀) :=
    fun z hz => hpre.constant (F.continuousOn_col.mono hint) hz hz₀
  have hd : F.col (P + (a θ₀ : ℂ) * e θ₀) ∈ F.innerColours P (ringPt P θ₀) := by
    show ringPt P θ₀ ∈ closure (F.region _ ∩ ball P 1)
    rw [Metric.mem_closure_iff]
    intro δ hδ
    have ht1 : max (a θ₀) (1 - δ / 2) < 1 := max_lt (by linarith [hin₀.2.1, hin₀.2.2.1]) (by linarith)
    have ht0 : 0 < max (a θ₀) (1 - δ / 2) := lt_max_of_lt_left hin₀.1
    have hy : P + ((max (a θ₀) (1 - δ / 2) : ℝ) : ℂ) * e θ₀ ∈ polarSet P (Ioo θ₁ θ₂) (fun θ => Ico (a θ) 1) :=
      ⟨θ₀, hθ₀, _, ⟨le_max_left _ _, ht1⟩, rfl⟩
    refine ⟨_, ⟨⟨hint hy, hconst _ hy⟩, ?_⟩, ?_⟩
    · rw [mem_ball, dist_eq_norm, add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real,
        Real.norm_of_nonneg ht0.le]
      exact ht1
    · rw [dist_eq_norm, ringPt, show P + e θ₀ - (P + ((max (a θ₀) (1 - δ / 2) : ℝ) : ℂ) * e θ₀) =
          ((1 - max (a θ₀) (1 - δ / 2) : ℝ) : ℂ) * e θ₀ by push_cast; ring, norm_mul, norm_e, mul_one, Complex.norm_real,
        Real.norm_of_nonneg (by linarith)]
      linarith [le_max_right (a θ₀) (1 - δ / 2)]
  rw [(hfit.ring.2.2 θ₀ hθ₀).1, mem_singleton_iff] at hd
  intro z hz
  exact ⟨hint hz, by rw [mem_preimage, mem_singleton_iff, hconst z hz, hd]⟩

/-- **The outer collar has the outer colour** (the same argument outside `B̄(P, 1)`). -/
theorem CollarFit.kout_subset (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') :
    polarSet P (Ioo θ₁ θ₂) (fun θ => Ioc 1 (outerProf θ₁ θ₂ R'' θ)) ⊆ F.region c' := by
  have hp := pushProfiles_collar hfit.params.1 hfit.params.2.1 hfit.params.2.2.1 hfit.params.2.2.2 hfit.ring.1 hfit.short
  have hcb := hp.cont_b
  set b := outerProf θ₁ θ₂ R'' with hb_def
  -- the outer collar is the image of a box under a continuous map
  have hS : polarSet P (Ioo θ₁ θ₂) (fun θ => Ioc 1 (b θ)) =
      (fun q : ℝ × ℝ => P + ((1 + q.2 * (b q.1 - 1) : ℝ) : ℂ) * e q.1) '' (Ioo θ₁ θ₂ ×ˢ Ioc 0 1) := by
    ext z
    constructor
    · rintro ⟨θ, hθ, t, ht, rfl⟩
      have hin := hp.inside θ hθ
      have h1 : 0 < b θ - 1 := by linarith [hin.2.2.2]
      refine ⟨(θ, (t - 1) / (b θ - 1)), ⟨hθ, div_pos (by linarith [ht.1]) h1, (div_le_one h1).mpr (by linarith [ht.2])⟩, ?_⟩
      show P + ((1 + (t - 1) / (b θ - 1) * (b θ - 1) : ℝ) : ℂ) * e θ = _
      rw [div_mul_cancel₀ _ h1.ne', add_sub_cancel]
    · rintro ⟨⟨θ, s⟩, ⟨hθ, hs⟩, rfl⟩
      have hin := hp.inside θ hθ
      have h1 : 0 < b θ - 1 := by linarith [hin.2.2.2]
      exact ⟨θ, hθ, _, ⟨by nlinarith [mul_pos hs.1 h1], by nlinarith [mul_le_mul_of_nonneg_right hs.2 h1.le]⟩, rfl⟩
  have hcont : Continuous (fun q : ℝ × ℝ => P + ((1 + q.2 * (b q.1 - 1) : ℝ) : ℂ) * e q.1) :=
    continuous_const.add ((Complex.continuous_ofReal.comp (continuous_const.add
      (continuous_snd.mul ((hcb.comp continuous_fst).sub continuous_const)))).mul (continuous_e.comp continuous_fst))
  have hpre : IsPreconnected (polarSet P (Ioo θ₁ θ₂) (fun θ => Ioc 1 (b θ))) := by
    rw [hS]; exact (isPreconnected_Ioo.prod isPreconnected_Ioc).image _ hcont.continuousOn
  have hint : polarSet P (Ioo θ₁ θ₂) (fun θ => Ioc 1 (b θ)) ⊆ F.interiorPts := by
    rintro _ ⟨θ, hθ, t, ht, rfl⟩
    have hin := hp.inside θ hθ
    exact hfit.mem_interiorPts hθ ⟨by linarith [ht.1, hin.2.1, hin.2.2.1], ht.2⟩ (ne_of_gt ht.1)
  -- the colour is constant on it, and is the arc's outer colour
  obtain ⟨θ₀, hθ₀⟩ := nonempty_Ioo.mpr hfit.ring.1
  have hin₀ := hp.inside θ₀ hθ₀
  have hz₀ : P + (b θ₀ : ℂ) * e θ₀ ∈ polarSet P (Ioo θ₁ θ₂) (fun θ => Ioc 1 (b θ)) :=
    ⟨θ₀, hθ₀, _, ⟨hin₀.2.2.2, le_rfl⟩, rfl⟩
  have hconst : ∀ z ∈ polarSet P (Ioo θ₁ θ₂) (fun θ => Ioc 1 (b θ)), F.col z = F.col (P + (b θ₀ : ℂ) * e θ₀) :=
    fun z hz => hpre.constant (F.continuousOn_col.mono hint) hz hz₀
  have hd : F.col (P + (b θ₀ : ℂ) * e θ₀) ∈ F.outerColours P (ringPt P θ₀) := by
    show ringPt P θ₀ ∈ closure (F.region _ \ closedBall P 1)
    rw [Metric.mem_closure_iff]
    intro δ hδ
    have ht1 : 1 < min (b θ₀) (1 + δ / 2) := lt_min hin₀.2.2.2 (by linarith)
    have hy : P + ((min (b θ₀) (1 + δ / 2) : ℝ) : ℂ) * e θ₀ ∈ polarSet P (Ioo θ₁ θ₂) (fun θ => Ioc 1 (b θ)) :=
      ⟨θ₀, hθ₀, _, ⟨ht1, min_le_left _ _⟩, rfl⟩
    refine ⟨_, ⟨⟨hint hy, hconst _ hy⟩, ?_⟩, ?_⟩
    · rw [mem_closedBall, dist_eq_norm, add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real,
        Real.norm_of_nonneg (by linarith)]
      exact not_le.mpr ht1
    · rw [dist_eq_norm, ringPt, show P + e θ₀ - (P + ((min (b θ₀) (1 + δ / 2) : ℝ) : ℂ) * e θ₀) =
          ((1 - min (b θ₀) (1 + δ / 2) : ℝ) : ℂ) * e θ₀ by push_cast; ring, norm_mul, norm_e, mul_one, Complex.norm_real,
        Real.norm_eq_abs, abs_of_neg (by linarith)]
      linarith [min_le_right (b θ₀) (1 + δ / 2)]
  rw [(hfit.ring.2.2 θ₀ hθ₀).2, mem_singleton_iff] at hd
  intro z hz
  exact ⟨hint hz, by rw [mem_preimage, mem_singleton_iff, hconst z hz, hd]⟩

/-- The collar's profiles are push profiles. -/
theorem CollarFit.pushProfiles (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') :
    PushProfiles θ₁ θ₂ (lensProf θ₁ θ₂ R') (lensProf θ₁ θ₂ R) (outerProf θ₁ θ₂ R'') :=
  pushProfiles_collar hfit.params.1 hfit.params.2.1 hfit.params.2.2.1 hfit.params.2.2.2 hfit.ring.1 hfit.short

/-- **The collar's homeomorphism**: the radial push about `P` across the collar, sending `α` onto `β`. -/
noncomputable def CollarFit.homeo (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') : ℂ ≃ₜ ℂ :=
  pushHomeo P θ₁ θ₂ (lensProf θ₁ θ₂ R') (lensProf θ₁ θ₂ R) (outerProf θ₁ θ₂ R'') hfit.pushProfiles

/-- **The homeomorphism is the identity off the collar** (`pushHomeo_eq_self`; the open collar lies in `K`). -/
theorem CollarFit.homeo_eq_self (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {z : ℂ} (hz : z ∉ collarK P θ₁ θ₂ R' R'') :
    hfit.homeo z = z ∧ hfit.homeo.symm z = z :=
  pushHomeo_eq_self hfit.pushProfiles fun h => hz (polarSet_mono Ioo_subset_Icc_self (fun _ _ => Ioo_subset_Icc_self) h)

/-- **The arc goes to the lens boundary**: `ringPt P θ ↦ P + lensProf θ₁ θ₂ R θ · e(θ)` (`pushHomeo_polar`, `push1_mid`). -/
theorem CollarFit.homeo_ringPt (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {θ : ℝ} (hθ : θ ∈ Ioo θ₁ θ₂) :
    hfit.homeo (ringPt P θ) = P + (lensProf θ₁ θ₂ R θ : ℂ) * e θ := by
  have hin := hfit.pushProfiles.inside θ hθ
  rw [CollarFit.homeo, show ringPt P θ = P + ((1 : ℝ) : ℂ) * e θ by simp [ringPt], pushHomeo_polar _ hθ one_pos,
    push1_mid (by linarith) hin.2.2.2]

/-- **The homeomorphism fixes `Γ` off the open arc**: such a point is off the collar (`free`) or an end (`a = b = 1` there). -/
theorem CollarFit.homeo_fix_Γ (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {z : ℂ} (hz : z ∈ F.Γ)
    (hzO : z ∉ ringPt P '' Ioo θ₁ θ₂) : hfit.homeo z = z := by
  by_cases hK : z ∈ collarK P θ₁ θ₂ R' R''
  · obtain ⟨θ, hθ, rfl⟩ := hfit.free ⟨hz, hK⟩
    have hθ' : θ ∉ Ioo θ₁ θ₂ := fun h => hzO ⟨θ, h, rfl⟩
    refine (pushHomeo_eq_self hfit.pushProfiles ?_).1
    rw [show ringPt P θ = P + ((1 : ℝ) : ℂ) * e θ by simp [ringPt]]
    exact polar_not_mem_polarSet hfit.short hθ hθ' one_pos fun θ' _ ht => (hfit.pushProfiles.a_pos θ').trans ht.1
  · exact (hfit.homeo_eq_self hK).1

/-- The homeomorphism keeps the domain (the identity off the collar, which lies in the domain and is carried onto itself). -/
theorem CollarFit.homeo_image_dom (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') : hfit.homeo '' F.dom = F.dom := by
  have hp := hfit.pushProfiles
  have hOK : polarSet P (Ioo θ₁ θ₂) (fun θ => Ioo (lensProf θ₁ θ₂ R' θ) (outerProf θ₁ θ₂ R'' θ)) ⊆ collarK P θ₁ θ₂ R' R'' :=
    polarSet_mono Ioo_subset_Icc_self fun _ _ => Ioo_subset_Icc_self
  have hmaps : ∀ z ∈ F.dom, hfit.homeo z ∈ F.dom ∧ hfit.homeo.symm z ∈ F.dom := by
    intro z hz
    by_cases hO : z ∈ polarSet P (Ioo θ₁ θ₂) (fun θ => Ioo (lensProf θ₁ θ₂ R' θ) (outerProf θ₁ θ₂ R'' θ))
    · obtain ⟨θ, hθ, t, ht, rfl⟩ := hO
      have hin := hp.inside θ hθ
      have ht0 : 0 < t := hin.1.trans ht.1
      constructor
      · rw [CollarFit.homeo, pushHomeo_polar hp hθ ht0]
        exact hfit.sub_dom (hOK ⟨θ, hθ, _, push1_mem_Ioo (by linarith) hin.2.2.2 hin.2.1 (by linarith) ht, rfl⟩)
      · rw [CollarFit.homeo, pushHomeo_symm_polar hp hθ ht0]
        exact hfit.sub_dom (hOK ⟨θ, hθ, _, push1_mem_Ioo hin.2.1 (by linarith) (by linarith) hin.2.2.2 ht, rfl⟩)
    · have h := pushHomeo_eq_self hp hO
      exact ⟨by rw [CollarFit.homeo, h.1]; exact hz, by rw [CollarFit.homeo, h.2]; exact hz⟩
  refine Subset.antisymm ?_ fun z hz => ⟨hfit.homeo.symm z, (hmaps z hz).2, hfit.homeo.apply_symm_apply z⟩
  rintro _ ⟨z, hz, rfl⟩
  exact (hmaps z hz).1

/-- **The bent map's arcs**: `F`'s with the open arc cut out, and the lens boundary's two arcs. -/
def collarArcs (F : ArcMap k) (P : ℂ) (θ₁ θ₂ R : ℝ) : Set Arc :=
  F.cutArcs P θ₁ θ₂ ∪ {collarArcA P θ₁ θ₂ R, collarArcB P θ₁ θ₂ R}

/-- The bent map's arcs are non-degenerate (`cutArcs_nondegenerate`, `germArc_nondegenerate`: `X ≠ A`, `X ≠ B`). -/
theorem CollarFit.collarArcs_nondegenerate (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') :
    ∀ a ∈ collarArcs F P θ₁ θ₂ R, a.Nondegenerate := by
  have hπ := Real.pi_pos
  have h12 := hfit.ring.1
  have hpos : 0 < ‖(tangRad R ((θ₂ - θ₁) / 2) : ℂ) * e ((θ₂ - θ₁) / 2) - 1‖ :=
    norm_tangRad_sub_one_pos (by linarith [hfit.params.1, hfit.params.2.1]) (by linarith) (by linarith [hfit.short])
  rintro a (ha | ha)
  · exact F.cutArcs_nondegenerate a ha
  · rcases ha with rfl | ha
    · exact germArc_nondegenerate _ _ _ (by rw [dist_collarMid_left h12.le]; exact hpos)
    · rw [mem_singleton_iff] at ha; subst ha
      exact germArc_nondegenerate _ _ _ (by rw [dist_collarMid_right h12.le]; exact hpos)

/-- The bent map's arcs are locally finite on the domain (the cut's, and two more). -/
theorem collarArcs_locallyFinite :
    ∀ x ∈ F.dom, ∃ t ∈ 𝓝 x, {a | a ∈ collarArcs F P θ₁ θ₂ R ∧ (a.carrier ∩ t).Nonempty}.Finite := by
  intro x hx
  obtain ⟨t, ht, hfin⟩ := F.cutArcs_locallyFinite (P := P) (θ₁ := θ₁) (θ₂ := θ₂) x hx
  refine ⟨t, ht, (hfin.union ((Set.finite_singleton (collarArcB P θ₁ θ₂ R)).insert (collarArcA P θ₁ θ₂ R))).subset ?_⟩
  rintro b ⟨hb | hb, hbt⟩
  · exact Or.inl ⟨hb, hbt⟩
  · exact Or.inr hb

/-- The lens boundary lies in the collar (`R' < R < 1 < R''` on the open sector, all three `1` at the ends). -/
theorem CollarFit.lensCurve_subset (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') :
    lensCurve P θ₁ θ₂ R ⊆ collarK P θ₁ θ₂ R' R'' := by
  refine polarSet_mono subset_rfl fun θ _ => ?_
  rintro t rfl
  rcases hfit.pushProfiles.cases θ with ⟨-, -, h1, h2, h3⟩ | ⟨-, h1, h2, h3⟩
  · exact ⟨h1.le, by linarith⟩
  · rw [h1, h2, h3]; exact ⟨le_rfl, le_rfl⟩

/-- The arc's ends lie on the lens boundary (the lens profile is `1` there). -/
theorem CollarFit.ringPt_mem_lensCurve (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {θ : ℝ} (hθ : θ ∈ Icc θ₁ θ₂)
    (hθ' : θ ∉ Ioo θ₁ θ₂) : ringPt P θ ∈ lensCurve P θ₁ θ₂ R :=
  ⟨θ, hθ, _, rfl, by rw [(hfit.pushProfiles.off θ hθ').2.1]; simp [ringPt]⟩

/-- **No arc of `F` but `ω(P)`'s passes through the open arc**: near a point of `α°`, `Γ` is `ω(P)` (`free_open`), which another arc
meets in finitely many points (`Arc.finite_inter_sphere_or_eq_circ`), while an arc through the point has points at every small distance
(`Arc.exists_near`). -/
theorem CollarFit.not_kept (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {x : ℂ} (hx : x ∈ ringPt P '' Ioo θ₁ θ₂) {a : Arc}
    (ha : a ∈ F.arcs) (hne : ∀ θa θb, a ≠ .circ P 1 θa θb) (hxa : x ∈ a.carrier) : False := by
  obtain ⟨θ, hθ, rfl⟩ := hx
  obtain ⟨r, hr, hsub⟩ := hfit.free_open θ hθ
  have hxd : ringPt P θ ∈ F.dom := (hfit.ring.2.1 ⟨θ, Ioo_subset_Icc_self hθ, rfl⟩).1
  obtain ⟨r', hr', hball⟩ := Metric.isOpen_iff.mp F.isOpen_dom _ hxd
  have hfin : (a.carrier ∩ sphere P 1).Finite :=
    (Arc.finite_inter_sphere_or_eq_circ a (F.nondegenerate a ha) P).resolve_right fun ⟨θa, θb, h⟩ => hne θa θb h
  have hcl : IsClosed ((a.carrier ∩ sphere P 1) \ {ringPt P θ}) := hfin.sdiff.isClosed
  obtain ⟨δ, hδ, hδb⟩ := Metric.isOpen_iff.mp hcl.isOpen_compl _ fun h => h.2 rfl
  obtain ⟨z, hza, hz0, hzr⟩ := Arc.exists_near (F.nondegenerate a ha) hxa (lt_min (lt_min hr hr') hδ)
  have hzb : z ∈ ball (ringPt P θ) (min (min r r') δ) := by rw [mem_ball, dist_eq_norm]; exact hzr
  have hzΓ : z ∈ F.Γ :=
    ⟨hball (ball_subset_ball ((min_le_left _ _).trans (min_le_right _ _)) hzb), mem_iUnion₂.mpr ⟨a, ha, hza⟩⟩
  have hzs : z ∈ sphere P 1 := hsub ⟨hzΓ, ball_subset_ball ((min_le_left _ _).trans (min_le_left _ _)) hzb⟩
  exact hδb (ball_subset_ball (min_le_right _ _) hzb)
    ⟨⟨hza, hzs⟩, fun h => hz0.ne' (by rw [mem_singleton_iff.mp h, sub_self, norm_zero])⟩

/-- **`h(Γ)`**: `F`'s `Γ` off the open arc, and the lens boundary (`homeo_fix_Γ` off `α°`; `homeo_ringPt` on it; the ends are on both). -/
theorem CollarFit.homeo_image_Γ (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') :
    hfit.homeo '' F.Γ = (F.Γ \ ringPt P '' Ioo θ₁ θ₂) ∪ lensCurve P θ₁ θ₂ R := by
  ext x
  constructor
  · rintro ⟨z, hz, rfl⟩
    by_cases hO : z ∈ ringPt P '' Ioo θ₁ θ₂
    · obtain ⟨θ, hθ, rfl⟩ := hO
      right
      rw [hfit.homeo_ringPt hθ]
      exact ⟨θ, Ioo_subset_Icc_self hθ, _, rfl, rfl⟩
    · left
      rw [hfit.homeo_fix_Γ hz hO]
      exact ⟨hz, hO⟩
  · rintro (⟨hx, hO⟩ | ⟨θ, hθ, s, hs, rfl⟩)
    · exact ⟨x, hx, hfit.homeo_fix_Γ hx hO⟩
    · rw [mem_singleton_iff] at hs
      subst hs
      by_cases hθ' : θ ∈ Ioo θ₁ θ₂
      · exact ⟨ringPt P θ, hfit.ring.2.1 ⟨θ, hθ, rfl⟩, hfit.homeo_ringPt hθ'⟩
      · have hl : lensProf θ₁ θ₂ R θ = 1 := (hfit.pushProfiles.off θ hθ').2.1
        have hE : P + (lensProf θ₁ θ₂ R θ : ℂ) * e θ = ringPt P θ := by rw [hl]; simp [ringPt]
        rw [hE]
        exact ⟨ringPt P θ, hfit.ring.2.1 ⟨θ, hθ, rfl⟩,
          hfit.homeo_fix_Γ (hfit.ring.2.1 ⟨θ, hθ, rfl⟩) (ringPt_not_mem_openArc hfit.short hθ hθ')⟩

/-- **The new arcs carry `h(Γ)`**: inside the domain, the cut's arcs are `Γ` off the open arc (`mem_cutArcs_iff` off `α°` and the ends;
on `α°` no arc of `F` but `ω(P)`'s passes, by `free_open`, so the cut leaves nothing there), and the two arcs are `β`
(`collarArcs_carrier`), which holds the ends; `h(Γ) = (Γ ∖ α°) ∪ h(α°)` (`homeo_fix_Γ`) and `h(α°) = β°` (`homeo_ringPt`). -/
theorem CollarFit.collarArcs_Γ (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') :
    F.dom ∩ ⋃ a ∈ collarArcs F P θ₁ θ₂ R, a.carrier = hfit.homeo '' F.Γ := by
  have hR : 1 / 2 < R := by linarith [hfit.params.1, hfit.params.2.1]
  have hβ : (⋃ a ∈ ({collarArcA P θ₁ θ₂ R, collarArcB P θ₁ θ₂ R} : Set Arc), a.carrier) = lensCurve P θ₁ θ₂ R := by
    rw [biUnion_insert, biUnion_singleton]
    exact collarArcs_carrier hR hfit.params.2.2.1 hfit.ring.1 hfit.short
  have hβdom : lensCurve P θ₁ θ₂ R ⊆ F.dom := hfit.lensCurve_subset.trans hfit.sub_dom
  have hends : ∀ x, x = ringPt P θ₁ ∨ x = ringPt P θ₂ → x ∈ lensCurve P θ₁ θ₂ R := by
    rintro x (rfl | rfl)
    · exact hfit.ringPt_mem_lensCurve ⟨le_rfl, hfit.ring.1.le⟩ fun h => lt_irrefl _ h.1
    · exact hfit.ringPt_mem_lensCurve ⟨hfit.ring.1.le, le_rfl⟩ fun h => lt_irrefl _ h.2
  rw [hfit.homeo_image_Γ, collarArcs, biUnion_union, hβ]
  ext x
  constructor
  · rintro ⟨hxd, hx | hx⟩
    · by_cases hO : x ∈ ringPt P '' Ioo θ₁ θ₂
      · obtain ⟨a, ha, hne, hxa⟩ := F.exists_kept_of_mem_openArc hO hx
        exact (hfit.not_kept hO ha hne hxa).elim
      by_cases hE : x = ringPt P θ₁ ∨ x = ringPt P θ₂
      · exact Or.inr (hends x hE)
      · push Not at hE
        exact Or.inl ⟨⟨hxd, (F.mem_cutArcs_iff hO hE.1 hE.2).mp hx⟩, hO⟩
    · exact Or.inr hx
  · rintro (⟨⟨hxd, hx⟩, hO⟩ | hx)
    · refine ⟨hxd, ?_⟩
      by_cases hE : x = ringPt P θ₁ ∨ x = ringPt P θ₂
      · exact Or.inr (hends x hE)
      · push Not at hE
        exact Or.inl ((F.mem_cutArcs_iff hO hE.1 hE.2).mpr hx)
    · exact ⟨hβdom hx, Or.inr hx⟩

/-- **The bent map**: `F`'s image under the collar's homeomorphism, with the arcs `collarArcs`. -/
noncomputable def CollarFit.map (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') : ArcMap k :=
  F.pushforward hfit.homeo hfit.homeo_image_dom (collarArcs F P θ₁ θ₂ R) hfit.collarArcs_nondegenerate collarArcs_locallyFinite
    hfit.collarArcs_Γ

/-- **The bent map's `Γ`**: `F`'s off the open arc, and the lens boundary. -/
theorem CollarFit.map_Γ (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') :
    hfit.map.Γ = (F.Γ \ ringPt P '' Ioo θ₁ θ₂) ∪ lensCurve P θ₁ θ₂ R := by
  rw [CollarFit.map, pushforward_Γ, hfit.homeo_image_Γ]

/-- **The lens is the outer colour's**: the lens with the open arc is interior in the bent map, of colour `c'` (it is `h`'s image of part
of the outer collar, `kout_subset`). -/
theorem CollarFit.map_lens (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') {z : ℂ} (hz : z ∈ lensSet P θ₁ θ₂ R) :
    z ∈ hfit.map.interiorPts ∧ hfit.map.col z = c' := by
  obtain ⟨θ, hθ, t, ht, rfl⟩ := hz
  have hin := hfit.pushProfiles.inside θ hθ
  have ht0 : 0 < t := hin.1.trans (hin.2.1.trans ht.1)
  have hw : hfit.homeo.symm (P + (t : ℂ) * e θ) ∈ F.region c' := by
    rw [CollarFit.homeo, pushHomeo_symm_polar _ hθ ht0]
    exact hfit.kout_subset ⟨θ, hθ, _, push1_mem_Ioc hin.2.1 (by linarith) hin.2.2.2 ⟨ht.1, by linarith [ht.2]⟩, rfl⟩
  rw [← hfit.homeo.apply_symm_apply (P + (t : ℂ) * e θ)]
  exact ⟨(pushforward_mem_interiorPts_iff _).mpr hw.1, (pushforward_col_apply _).trans hw.2⟩

/-- **The bent map agrees with `F` off the closed lens** (`lensSet ∪ lensCurve`): off the collar `h` is the identity; on the collar off
the closed lens, `h` moves points within the inner collar (colour `c`) or within the outer collar (colour `c'`). -/
theorem CollarFit.map_agreesOff (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') :
    hfit.map.AgreesOff F (lensSet P θ₁ θ₂ R ∪ lensCurve P θ₁ θ₂ R) := by
  have hp := hfit.pushProfiles
  refine ⟨rfl, fun z hz => ?_⟩
  have hzw : z = hfit.homeo (hfit.homeo.symm z) := (hfit.homeo.apply_symm_apply z).symm
  have hI : z ∈ hfit.map.interiorPts ↔ hfit.homeo.symm z ∈ F.interiorPts := by
    conv_lhs => rw [hzw]
    exact pushforward_mem_interiorPts_iff _
  have hC : hfit.map.col z = F.col (hfit.homeo.symm z) := by
    conv_lhs => rw [hzw]
    exact pushforward_col_apply _
  rw [hI, hC]
  by_cases hK : z ∈ collarK P θ₁ θ₂ R' R''
  · obtain ⟨θ, hθ, t, ht, rfl⟩ := hK
    by_cases hθo : θ ∈ Ioo θ₁ θ₂
    · have hin := hp.inside θ hθo
      have ht0 : 0 < t := hin.1.trans_le ht.1
      rw [CollarFit.homeo, pushHomeo_symm_polar hp hθo ht0]
      have hl : t ≠ lensProf θ₁ θ₂ R θ := fun h => hz (Or.inr ⟨θ, hθ, t, h, rfl⟩)
      have hs : ¬ (lensProf θ₁ θ₂ R θ < t ∧ t ≤ 1) := fun h => hz (Or.inl ⟨θ, hθo, t, h, rfl⟩)
      rcases lt_or_gt_of_ne hl with h | h
      · -- the inner collar: both points of colour `c`
        have hz' := hfit.kin_subset ⟨θ, hθo, t, ⟨ht.1, by linarith [hin.2.2.1]⟩, rfl⟩
        have hw' := hfit.kin_subset ⟨θ, hθo, _, push1_mem_Ico (b := outerProf θ₁ θ₂ R'' θ) hin.2.1 (by linarith) (by linarith) ⟨ht.1, h⟩, rfl⟩
        exact ⟨iff_of_true hz'.1 hw'.1, hz'.2.trans hw'.2.symm⟩
      · -- the outer collar: both points of colour `c'`
        have h1 : 1 < t := by by_contra h'; exact hs ⟨h, not_lt.mp h'⟩
        have hz' := hfit.kout_subset ⟨θ, hθo, t, ⟨h1, ht.2⟩, rfl⟩
        have hw' := hfit.kout_subset ⟨θ, hθo, _, push1_mem_Ioc hin.2.1 (by linarith) hin.2.2.2 ⟨h, ht.2⟩, rfl⟩
        exact ⟨iff_of_true hz'.1 hw'.1, hz'.2.trans hw'.2.symm⟩
    · -- an end of the arc: fixed
      have hoff := hp.off θ hθo
      have ht1 : t = 1 := le_antisymm (hoff.2.2 ▸ ht.2) (hoff.1 ▸ ht.1)
      subst ht1
      have hfix := (pushHomeo_eq_self (P := P) hp (polar_not_mem_polarSet hfit.short hθ hθo one_pos
        fun θ' _ ht' => (hp.a_pos θ').trans ht'.1)).2
      rw [CollarFit.homeo, hfix]
      exact ⟨Iff.rfl, rfl⟩
  · rw [(hfit.homeo_eq_self hK).2]
    exact ⟨Iff.rfl, rfl⟩

/-- **The bent map is valid** (clause 1). Route: `Valid.of_agreesOff` on the closed lens (`map_agreesOff`); its interior points in the bent
map are `lensSet`, of colour `c'` (`map_lens`), clear for `c'` in `F` (`clear` inside, `ne1_region` on the open arc), and no two of them
are `1` apart (`dist_lt_one_of_mem_polarSet`). -/
theorem CollarFit.map_valid (hF : F.Valid) (hfit : CollarFit F P θ₁ θ₂ c c' ε R' R R'') : hfit.map.Valid := by
  have hp := hfit.pushProfiles
  -- the closed lens's interior points in the bent map are the lens
  have hU : ∀ z ∈ (lensSet P θ₁ θ₂ R ∪ lensCurve P θ₁ θ₂ R) ∩ hfit.map.interiorPts, z ∈ lensSet P θ₁ θ₂ R := by
    rintro z ⟨hz | hz, hzi⟩
    · exact hz
    · have hΓ : z ∈ hfit.map.Γ := by rw [hfit.map_Γ]; exact Or.inr hz
      exact (hzi.2 hΓ.2).elim
  have hsub : lensSet P θ₁ θ₂ R ⊆ polarSet P (Ioo θ₁ θ₂) (fun _ => Ioc 0 1) :=
    polarSet_mono subset_rfl fun θ hθ t ht => ⟨(hp.inside θ hθ).1.trans ((hp.inside θ hθ).2.1.trans ht.1), ht.2⟩
  refine Valid.of_agreesOff hF hfit.map_agreesOff (fun z hz => ?_) (fun z hz y hy hzy => ?_)
  · have hzl := hU z hz
    rw [(hfit.map_lens hzl).2]
    obtain ⟨θ, hθ, t, ht, rfl⟩ := hzl
    rcases lt_or_eq_of_le ht.2 with h | h
    · exact hfit.clear _ ⟨θ, hθ, t, ⟨ht.1, h⟩, rfl⟩
    · -- on the open arc: in the closure of the outer class
      subst h
      have hcl : P + ((1 : ℝ) : ℂ) * e θ ∈ closure (F.region c') := by
        have hc' : c' ∈ F.outerColours P (ringPt P θ) := by rw [(hfit.ring.2.2 θ hθ).2]; exact mem_singleton c'
        rw [show P + ((1 : ℝ) : ℂ) * e θ = ringPt P θ by simp [ringPt]]
        exact closure_mono sdiff_subset hc'
      intro y hy hdist
      exact ne1_region hF hcl hy (by rw [dist_comm]; exact hdist)
  · exact absurd hzy (dist_lt_one_of_mem_polarSet hfit.short (hsub (hU z hz)) (hsub (hU y hy))).ne

end Collar

end ArcMap

end HadwigerNelson.Plane

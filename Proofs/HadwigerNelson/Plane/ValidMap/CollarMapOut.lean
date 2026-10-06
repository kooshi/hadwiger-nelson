import Proofs.HadwigerNelson.Plane.ValidMap.CollarMap
import Proofs.HadwigerNelson.Plane.ValidMap.LensOut

/-!
# The outward collar bend's map (FS131-KA1's plan, proved by FS131-BA1; mirror of `Plane/ValidMap/CollarMap`)

The outward collar's fit to the map (`CollarFitOut`), its homeomorphism, the bent map `CollarFitOut.map` and the geometric clauses read
off it (`map_Γ`, `map_lens`, `map_agreesOff`, `map_valid`): `plans/FS131-bendaway-kernel-plan.md` § 3, lane G. The collar is the toward
bend's set `collarK P θ₁ θ₂ R' R''`; only the lens differs — outside `ω(P)`, bounded by the circles of radius `R > 1` tangent to
`ω(P)` at the ends, and recoloured with the **inner** colour.
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

namespace ArcMap

variable {k : ℕ} {F : ArcMap k}

section CollarOut

variable {P : ℂ} {θ₁ θ₂ : ℝ} {c c' : Fin k} {ε R' R R'' : ℝ}

/-- **The outward collar fits the map**: `CollarFit` with the lens radius above `1` (`1/2 < R' < 1 < R < R''`, and `R ≤ 9/8` so that
two lens points are closer than `1`, `dist_lt_one_of_thin`) and the open lens — now outside `ω(P)` — clear for the **inner** colour.
Inhabitant: `exists_collarFitOut` (`Plane/ValidMap/BendGap`), at any map satisfying `bend_away_gap`'s hypotheses; a model map for those
is owed with the away bend's (the plan's § 5). -/
structure CollarFitOut (F : ArcMap k) (P : ℂ) (θ₁ θ₂ : ℝ) (c c' : Fin k) (ε R' R R'' : ℝ) : Prop where
  /-- The arc is a constant-sided unit arc. -/
  ring : F.IsRingArc P θ₁ θ₂ c c'
  /-- It is at most `60°` long (`l60_le`). -/
  short : θ₂ - θ₁ ≤ π / 3
  /-- The radii. -/
  params : 1 / 2 < R' ∧ R' < 1 ∧ 1 < R ∧ R < R'' ∧ R ≤ 9 / 8
  /-- Near each interior point of the arc, `Γ` is `ω(P)`. -/
  free_open : ∀ θ ∈ Ioo θ₁ θ₂, ∃ r > 0, F.Γ ∩ ball (ringPt P θ) r ⊆ sphere P 1
  /-- The collar lies within `ε` of the arc. -/
  sub_thick : collarK P θ₁ θ₂ R' R'' ⊆ thickening ε (ringArc P θ₁ θ₂)
  /-- The collar lies in the domain. -/
  sub_dom : collarK P θ₁ θ₂ R' R'' ⊆ F.dom
  /-- The collar meets `Γ` only on the arc. -/
  free : F.Γ ∩ collarK P θ₁ θ₂ R' R'' ⊆ ringArc P θ₁ θ₂
  /-- The open lens is clear for the inner colour. -/
  clear : ∀ z ∈ polarSet P (Ioo θ₁ θ₂) (fun θ => Ioo 1 (outerProf θ₁ θ₂ R θ)), F.IsClear c z

/-- The outward collar's profiles are push profiles. -/
theorem CollarFitOut.pushOutProfiles (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') :
    PushOutProfiles θ₁ θ₂ (lensProf θ₁ θ₂ R') (outerProf θ₁ θ₂ R) (outerProf θ₁ θ₂ R'') :=
  pushOutProfiles_collar hfit.params.1 hfit.params.2.1 hfit.params.2.2.1 hfit.params.2.2.2.1 hfit.ring.1 hfit.short

/-- **The outward collar's homeomorphism**: the radial push about `P` across the collar, sending the arc onto the outward lens curve. -/
noncomputable def CollarFitOut.homeo (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') : ℂ ≃ₜ ℂ :=
  pushOutHomeo P θ₁ θ₂ (lensProf θ₁ θ₂ R') (outerProf θ₁ θ₂ R) (outerProf θ₁ θ₂ R'') hfit.pushOutProfiles

/-- A point of the collar over the open sector off the unit circle is an interior point of `F` (mirror of
`CollarFit.mem_interiorPts`: the collar is the same set and meets `Γ` only on the arc). -/
theorem CollarFitOut.mem_interiorPts (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') {θ t : ℝ} (hθ : θ ∈ Ioo θ₁ θ₂)
    (ht : t ∈ Icc (lensProf θ₁ θ₂ R' θ) (outerProf θ₁ θ₂ R'' θ)) (ht1 : t ≠ 1) : P + (t : ℂ) * e θ ∈ F.interiorPts := by
  have hK : P + (t : ℂ) * e θ ∈ collarK P θ₁ θ₂ R' R'' := ⟨θ, Ioo_subset_Icc_self hθ, t, ht, rfl⟩
  refine ⟨hfit.sub_dom hK, fun hU => ht1 ?_⟩
  obtain ⟨θ', -, hθ'⟩ := hfit.free ⟨⟨hfit.sub_dom hK, hU⟩, hK⟩
  have ht0 : 0 < t := (hfit.pushOutProfiles.a_pos θ).trans_le ht.1
  have h := congrArg (fun z => ‖z - P‖) hθ'
  simp only [ringPt, add_sub_cancel_left, norm_mul, norm_e, mul_one, Complex.norm_real, Real.norm_eq_abs,
    abs_of_pos ht0] at h
  exact h.symm

/-- **The inner collar has the inner colour** (mirror of `CollarFit.kin_subset`; the same set, the same argument): `{a(θ) ≤ t < 1}`
over `(θ₁, θ₂)` is connected, `Γ`-free, inside `B(P, 1)`, and its closure meets the open arc, whose inner colour is `c` alone. -/
theorem CollarFitOut.kin_subset (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') :
    polarSet P (Ioo θ₁ θ₂) (fun θ => Ico (lensProf θ₁ θ₂ R' θ) 1) ⊆ F.region c := by
  have hp := hfit.pushOutProfiles
  have hca := hp.cont_a
  set a := lensProf θ₁ θ₂ R' with ha_def
  -- the inner collar is the image of a box under a continuous map
  have hS : polarSet P (Ioo θ₁ θ₂) (fun θ => Ico (a θ) 1) =
      (fun q : ℝ × ℝ => P + ((a q.1 + q.2 * (1 - a q.1) : ℝ) : ℂ) * e q.1) '' (Ioo θ₁ θ₂ ×ˢ Ico 0 1) := by
    ext z
    constructor
    · rintro ⟨θ, hθ, t, ht, rfl⟩
      have hin := hp.inside θ hθ
      have h1 : 0 < 1 - a θ := by linarith [hin.2.1]
      refine ⟨(θ, (t - a θ) / (1 - a θ)), ⟨hθ, div_nonneg (by linarith [ht.1]) h1.le, (div_lt_one h1).mpr (by linarith [ht.2])⟩, ?_⟩
      show P + ((a θ + (t - a θ) / (1 - a θ) * (1 - a θ) : ℝ) : ℂ) * e θ = _
      rw [div_mul_cancel₀ _ h1.ne', add_sub_cancel]
    · rintro ⟨⟨θ, s⟩, ⟨hθ, hs⟩, rfl⟩
      have hin := hp.inside θ hθ
      have h1 : 0 < 1 - a θ := by linarith [hin.2.1]
      exact ⟨θ, hθ, _, ⟨by nlinarith [mul_nonneg hs.1 h1.le], by nlinarith [mul_lt_mul_of_pos_right hs.2 h1]⟩, rfl⟩
  have hcont : Continuous (fun q : ℝ × ℝ => P + ((a q.1 + q.2 * (1 - a q.1) : ℝ) : ℂ) * e q.1) :=
    continuous_const.add ((Complex.continuous_ofReal.comp ((hca.comp continuous_fst).add
      (continuous_snd.mul (continuous_const.sub (hca.comp continuous_fst))))).mul (continuous_e.comp continuous_fst))
  have hpre : IsPreconnected (polarSet P (Ioo θ₁ θ₂) (fun θ => Ico (a θ) 1)) := by
    rw [hS]; exact (isPreconnected_Ioo.prod isPreconnected_Ico).image _ hcont.continuousOn
  have hint : polarSet P (Ioo θ₁ θ₂) (fun θ => Ico (a θ) 1) ⊆ F.interiorPts := by
    rintro _ ⟨θ, hθ, t, ht, rfl⟩
    have hin := hp.inside θ hθ
    exact hfit.mem_interiorPts hθ ⟨ht.1, by linarith [ht.2, hin.2.2.1, hin.2.2.2]⟩ (ne_of_lt ht.2)
  -- the colour is constant on it, and is the arc's inner colour
  obtain ⟨θ₀, hθ₀⟩ := nonempty_Ioo.mpr hfit.ring.1
  have hin₀ := hp.inside θ₀ hθ₀
  have hz₀ : P + (a θ₀ : ℂ) * e θ₀ ∈ polarSet P (Ioo θ₁ θ₂) (fun θ => Ico (a θ) 1) :=
    ⟨θ₀, hθ₀, _, ⟨le_rfl, hin₀.2.1⟩, rfl⟩
  have hconst : ∀ z ∈ polarSet P (Ioo θ₁ θ₂) (fun θ => Ico (a θ) 1), F.col z = F.col (P + (a θ₀ : ℂ) * e θ₀) :=
    fun z hz => hpre.constant (F.continuousOn_col.mono hint) hz hz₀
  have hd : F.col (P + (a θ₀ : ℂ) * e θ₀) ∈ F.innerColours P (ringPt P θ₀) := by
    show ringPt P θ₀ ∈ closure (F.region _ ∩ ball P 1)
    rw [Metric.mem_closure_iff]
    intro δ hδ
    have ht1 : max (a θ₀) (1 - δ / 2) < 1 := max_lt hin₀.2.1 (by linarith)
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

/-- **The outer collar has the outer colour** (mirror of `CollarFit.kout_subset`; the same argument outside `B̄(P, 1)`). -/
theorem CollarFitOut.kout_subset (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') :
    polarSet P (Ioo θ₁ θ₂) (fun θ => Ioc 1 (outerProf θ₁ θ₂ R'' θ)) ⊆ F.region c' := by
  have hp := hfit.pushOutProfiles
  have hcb := hp.cont_b
  set b := outerProf θ₁ θ₂ R'' with hb_def
  have hb1 : ∀ θ ∈ Ioo θ₁ θ₂, 1 < b θ := fun θ hθ => (hp.inside θ hθ).2.2.1.trans (hp.inside θ hθ).2.2.2
  -- the outer collar is the image of a box under a continuous map
  have hS : polarSet P (Ioo θ₁ θ₂) (fun θ => Ioc 1 (b θ)) =
      (fun q : ℝ × ℝ => P + ((1 + q.2 * (b q.1 - 1) : ℝ) : ℂ) * e q.1) '' (Ioo θ₁ θ₂ ×ˢ Ioc 0 1) := by
    ext z
    constructor
    · rintro ⟨θ, hθ, t, ht, rfl⟩
      have h1 : 0 < b θ - 1 := by linarith [hb1 θ hθ]
      refine ⟨(θ, (t - 1) / (b θ - 1)), ⟨hθ, div_pos (by linarith [ht.1]) h1, (div_le_one h1).mpr (by linarith [ht.2])⟩, ?_⟩
      show P + ((1 + (t - 1) / (b θ - 1) * (b θ - 1) : ℝ) : ℂ) * e θ = _
      rw [div_mul_cancel₀ _ h1.ne', add_sub_cancel]
    · rintro ⟨⟨θ, s⟩, ⟨hθ, hs⟩, rfl⟩
      have h1 : 0 < b θ - 1 := by linarith [hb1 θ hθ]
      exact ⟨θ, hθ, _, ⟨by nlinarith [mul_pos hs.1 h1], by nlinarith [mul_le_mul_of_nonneg_right hs.2 h1.le]⟩, rfl⟩
  have hcont : Continuous (fun q : ℝ × ℝ => P + ((1 + q.2 * (b q.1 - 1) : ℝ) : ℂ) * e q.1) :=
    continuous_const.add ((Complex.continuous_ofReal.comp (continuous_const.add
      (continuous_snd.mul ((hcb.comp continuous_fst).sub continuous_const)))).mul (continuous_e.comp continuous_fst))
  have hpre : IsPreconnected (polarSet P (Ioo θ₁ θ₂) (fun θ => Ioc 1 (b θ))) := by
    rw [hS]; exact (isPreconnected_Ioo.prod isPreconnected_Ioc).image _ hcont.continuousOn
  have hint : polarSet P (Ioo θ₁ θ₂) (fun θ => Ioc 1 (b θ)) ⊆ F.interiorPts := by
    rintro _ ⟨θ, hθ, t, ht, rfl⟩
    have hin := hp.inside θ hθ
    exact hfit.mem_interiorPts hθ ⟨by linarith [ht.1, hin.2.1], ht.2⟩ (ne_of_gt ht.1)
  -- the colour is constant on it, and is the arc's outer colour
  obtain ⟨θ₀, hθ₀⟩ := nonempty_Ioo.mpr hfit.ring.1
  have hb₀ := hb1 θ₀ hθ₀
  have hz₀ : P + (b θ₀ : ℂ) * e θ₀ ∈ polarSet P (Ioo θ₁ θ₂) (fun θ => Ioc 1 (b θ)) :=
    ⟨θ₀, hθ₀, _, ⟨hb₀, le_rfl⟩, rfl⟩
  have hconst : ∀ z ∈ polarSet P (Ioo θ₁ θ₂) (fun θ => Ioc 1 (b θ)), F.col z = F.col (P + (b θ₀ : ℂ) * e θ₀) :=
    fun z hz => hpre.constant (F.continuousOn_col.mono hint) hz hz₀
  have hd : F.col (P + (b θ₀ : ℂ) * e θ₀) ∈ F.outerColours P (ringPt P θ₀) := by
    show ringPt P θ₀ ∈ closure (F.region _ \ closedBall P 1)
    rw [Metric.mem_closure_iff]
    intro δ hδ
    have ht1 : 1 < min (b θ₀) (1 + δ / 2) := lt_min hb₀ (by linarith)
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

/-- **The outward homeomorphism is the identity off the collar** (`pushOutHomeo_eq_self`; the open collar lies in `K`). -/
theorem CollarFitOut.homeo_eq_self (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') {z : ℂ}
    (hz : z ∉ collarK P θ₁ θ₂ R' R'') : hfit.homeo z = z ∧ hfit.homeo.symm z = z :=
  pushOutHomeo_eq_self hfit.pushOutProfiles fun h => hz (polarSet_mono Ioo_subset_Icc_self (fun _ _ => Ioo_subset_Icc_self) h)

/-- **The arc goes to the outward lens boundary**: `ringPt P θ ↦ P + outerProf θ₁ θ₂ R θ · e(θ)` (`pushOutHomeo_polar`,
`push1_mid`). -/
theorem CollarFitOut.homeo_ringPt (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') {θ : ℝ} (hθ : θ ∈ Ioo θ₁ θ₂) :
    hfit.homeo (ringPt P θ) = P + (outerProf θ₁ θ₂ R θ : ℂ) * e θ := by
  have hin := hfit.pushOutProfiles.inside θ hθ
  rw [CollarFitOut.homeo, show ringPt P θ = P + ((1 : ℝ) : ℂ) * e θ by simp [ringPt], pushOutHomeo_polar _ hθ one_pos,
    push1_mid hin.2.1 (hin.2.2.1.trans hin.2.2.2)]

/-- **The outward homeomorphism fixes `Γ` off the open arc** (mirror of `CollarFit.homeo_fix_Γ`): such a point is off the collar
(`free`) or an end (`a = b = 1` there). -/
theorem CollarFitOut.homeo_fix_Γ (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') {z : ℂ} (hz : z ∈ F.Γ)
    (hzO : z ∉ ringPt P '' Ioo θ₁ θ₂) : hfit.homeo z = z := by
  by_cases hK : z ∈ collarK P θ₁ θ₂ R' R''
  · obtain ⟨θ, hθ, rfl⟩ := hfit.free ⟨hz, hK⟩
    have hθ' : θ ∉ Ioo θ₁ θ₂ := fun h => hzO ⟨θ, h, rfl⟩
    refine (pushOutHomeo_eq_self hfit.pushOutProfiles ?_).1
    rw [show ringPt P θ = P + ((1 : ℝ) : ℂ) * e θ by simp [ringPt]]
    exact polar_not_mem_polarSet hfit.short hθ hθ' one_pos fun θ' _ ht => (hfit.pushOutProfiles.a_pos θ').trans ht.1
  · exact (hfit.homeo_eq_self hK).1

/-- The homeomorphism keeps the domain (mirror of `CollarFit.homeo_image_dom`; plan § 3, child G5): the identity off the collar,
which lies in the domain and is carried onto itself. -/
theorem CollarFitOut.homeo_image_dom (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') : hfit.homeo '' F.dom = F.dom := by
  have hp := hfit.pushOutProfiles
  have hOK : polarSet P (Ioo θ₁ θ₂) (fun θ => Ioo (lensProf θ₁ θ₂ R' θ) (outerProf θ₁ θ₂ R'' θ)) ⊆ collarK P θ₁ θ₂ R' R'' :=
    polarSet_mono Ioo_subset_Icc_self fun _ _ => Ioo_subset_Icc_self
  have hmaps : ∀ z ∈ F.dom, hfit.homeo z ∈ F.dom ∧ hfit.homeo.symm z ∈ F.dom := by
    intro z hz
    by_cases hO : z ∈ polarSet P (Ioo θ₁ θ₂) (fun θ => Ioo (lensProf θ₁ θ₂ R' θ) (outerProf θ₁ θ₂ R'' θ))
    · obtain ⟨θ, hθ, t, ht, rfl⟩ := hO
      obtain ⟨h0, ha1, h1l, hlb⟩ := hp.inside θ hθ
      have ht0 : 0 < t := h0.trans ht.1
      constructor
      · rw [CollarFitOut.homeo, pushOutHomeo_polar hp hθ ht0]
        exact hfit.sub_dom (hOK ⟨θ, hθ, _, push1_mem_Ioo ha1 (h1l.trans hlb) (ha1.trans h1l) hlb ht, rfl⟩)
      · rw [CollarFitOut.homeo, pushOutHomeo_symm_polar hp hθ ht0]
        exact hfit.sub_dom (hOK ⟨θ, hθ, _, push1_mem_Ioo (ha1.trans h1l) hlb ha1 (h1l.trans hlb) ht, rfl⟩)
    · have h := pushOutHomeo_eq_self hp hO
      exact ⟨by rw [CollarFitOut.homeo, h.1]; exact hz, by rw [CollarFitOut.homeo, h.2]; exact hz⟩
  refine Subset.antisymm ?_ fun z hz => ⟨hfit.homeo.symm z, (hmaps z hz).2, hfit.homeo.apply_symm_apply z⟩
  rintro _ ⟨z, hz, rfl⟩
  exact (hmaps z hz).1

/-- **The outward bent map's arcs**: `F`'s with the open arc cut out, and the outward lens boundary's two arcs. -/
def collarOutArcs (F : ArcMap k) (P : ℂ) (θ₁ θ₂ R : ℝ) : Set Arc :=
  F.cutArcs P θ₁ θ₂ ∪ {collarOutArcA P θ₁ θ₂ R, collarOutArcB P θ₁ θ₂ R}

/-- The outward bent map's arcs are non-degenerate (mirror of `CollarFit.collarArcs_nondegenerate`; child G5):
`cutArcs_nondegenerate`, and `germArc_nondegenerate` since the crossing is neither end. -/
theorem CollarFitOut.collarOutArcs_nondegenerate (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') :
    ∀ a ∈ collarOutArcs F P θ₁ θ₂ R, a.Nondegenerate := by
  have hπ := Real.pi_pos
  have h12 := hfit.ring.1
  have hpos : 0 < ‖(tangRad R ((θ₂ - θ₁) / 2) : ℂ) * e ((θ₂ - θ₁) / 2) - 1‖ :=
    norm_tangRad_sub_one_pos (by linarith [hfit.params.2.2.1]) (by linarith) (by linarith [hfit.short])
  rintro a (ha | ha)
  · exact F.cutArcs_nondegenerate a ha
  · rcases ha with rfl | ha
    · exact germArc_nondegenerate _ _ _ (by rw [dist_collarOutMid_left h12.le]; exact hpos)
    · rw [mem_singleton_iff] at ha; subst ha
      exact germArc_nondegenerate _ _ _ (by rw [dist_collarOutMid_right h12.le]; exact hpos)

/-- The outward bent map's arcs are locally finite on the domain (the cut's, and two more). -/
theorem collarOutArcs_locallyFinite :
    ∀ x ∈ F.dom, ∃ t ∈ 𝓝 x, {a | a ∈ collarOutArcs F P θ₁ θ₂ R ∧ (a.carrier ∩ t).Nonempty}.Finite := by
  intro x hx
  obtain ⟨t, ht, hfin⟩ := F.cutArcs_locallyFinite (P := P) (θ₁ := θ₁) (θ₂ := θ₂) x hx
  refine ⟨t, ht, (hfin.union ((Set.finite_singleton (collarOutArcB P θ₁ θ₂ R)).insert (collarOutArcA P θ₁ θ₂ R))).subset ?_⟩
  rintro b ⟨hb | hb, hbt⟩
  · exact Or.inl ⟨hb, hbt⟩
  · exact Or.inr hb

/-- The outward lens boundary lies in the collar (`R' < 1 < R < R''` on the open sector, all three profiles `1` at the ends). -/
theorem CollarFitOut.lensOutCurve_subset (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') :
    lensOutCurve P θ₁ θ₂ R ⊆ collarK P θ₁ θ₂ R' R'' := by
  refine polarSet_mono subset_rfl fun θ _ => ?_
  rintro t rfl
  rcases hfit.pushOutProfiles.cases θ with ⟨-, -, h1, h2, h3⟩ | ⟨-, h1, h2, h3⟩
  · exact ⟨by linarith, h3.le⟩
  · rw [h1, h2, h3]; exact ⟨le_rfl, le_rfl⟩

/-- The arc's ends lie on the outward lens boundary (the lens profile is `1` there). -/
theorem CollarFitOut.ringPt_mem_lensOutCurve (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') {θ : ℝ} (hθ : θ ∈ Icc θ₁ θ₂)
    (hθ' : θ ∉ Ioo θ₁ θ₂) : ringPt P θ ∈ lensOutCurve P θ₁ θ₂ R :=
  ⟨θ, hθ, _, rfl, by rw [(hfit.pushOutProfiles.off θ hθ').2.1]; simp [ringPt]⟩

/-- **No arc of `F` but `ω(P)`'s passes through the open arc** (mirror of `CollarFit.not_kept`; it reads `free_open` and `ring`
only): near a point of `α°`, `Γ` is `ω(P)`, which another arc meets in finitely many points, while an arc through the point has
points at every small distance. -/
theorem CollarFitOut.not_kept (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') {x : ℂ} (hx : x ∈ ringPt P '' Ioo θ₁ θ₂) {a : Arc}
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

/-- **`h(Γ)`** for the outward bend (mirror of `CollarFit.homeo_image_Γ`): `F`'s `Γ` off the open arc, and the outward lens boundary
(`homeo_fix_Γ` off `α°`; `homeo_ringPt` on it; the ends are on both). -/
theorem CollarFitOut.homeo_image_Γ (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') :
    hfit.homeo '' F.Γ = (F.Γ \ ringPt P '' Ioo θ₁ θ₂) ∪ lensOutCurve P θ₁ θ₂ R := by
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
      · have hl : outerProf θ₁ θ₂ R θ = 1 := (hfit.pushOutProfiles.off θ hθ').2.1
        have hE : P + (outerProf θ₁ θ₂ R θ : ℂ) * e θ = ringPt P θ := by rw [hl]; simp [ringPt]
        rw [hE]
        exact ⟨ringPt P θ, hfit.ring.2.1 ⟨θ, hθ, rfl⟩,
          hfit.homeo_fix_Γ (hfit.ring.2.1 ⟨θ, hθ, rfl⟩) (ringPt_not_mem_openArc hfit.short hθ hθ')⟩

/-- The outward bent map's arcs inside the domain are the homeomorphism's image of `Γ` (mirror of `CollarFit.collarArcs_Γ`, through
`collarOutArcs_carrier` and `homeo_image_Γ`; child G5). -/
theorem CollarFitOut.collarOutArcs_Γ (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') :
    F.dom ∩ ⋃ a ∈ collarOutArcs F P θ₁ θ₂ R, a.carrier = hfit.homeo '' F.Γ := by
  have hβ : (⋃ a ∈ ({collarOutArcA P θ₁ θ₂ R, collarOutArcB P θ₁ θ₂ R} : Set Arc), a.carrier) = lensOutCurve P θ₁ θ₂ R := by
    rw [biUnion_insert, biUnion_singleton]
    exact collarOutArcs_carrier hfit.params.2.2.1 hfit.ring.1 hfit.short
  have hβdom : lensOutCurve P θ₁ θ₂ R ⊆ F.dom := hfit.lensOutCurve_subset.trans hfit.sub_dom
  have hends : ∀ x, x = ringPt P θ₁ ∨ x = ringPt P θ₂ → x ∈ lensOutCurve P θ₁ θ₂ R := by
    rintro x (rfl | rfl)
    · exact hfit.ringPt_mem_lensOutCurve ⟨le_rfl, hfit.ring.1.le⟩ fun h => lt_irrefl _ h.1
    · exact hfit.ringPt_mem_lensOutCurve ⟨hfit.ring.1.le, le_rfl⟩ fun h => lt_irrefl _ h.2
  rw [hfit.homeo_image_Γ, collarOutArcs, biUnion_union, hβ]
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

/-- **The outward bent map**: `F`'s image under the outward collar's homeomorphism, with the arcs `collarOutArcs`. -/
noncomputable def CollarFitOut.map (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') : ArcMap k :=
  F.pushforward hfit.homeo hfit.homeo_image_dom (collarOutArcs F P θ₁ θ₂ R) hfit.collarOutArcs_nondegenerate
    collarOutArcs_locallyFinite hfit.collarOutArcs_Γ

/-- Spec: the outward bent map's arcs are the cut and the two lens arcs, its domain `F`'s. -/
example (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') :
    hfit.map.arcs = F.cutArcs P θ₁ θ₂ ∪ {collarOutArcA P θ₁ θ₂ R, collarOutArcB P θ₁ θ₂ R} ∧ hfit.map.dom = F.dom :=
  ⟨rfl, rfl⟩

/-- **The outward bent map's `Γ`**: `F`'s off the open arc, and the outward lens boundary (mirror of `CollarFit.map_Γ`; child
G5). -/
theorem CollarFitOut.map_Γ (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') :
    hfit.map.Γ = (F.Γ \ ringPt P '' Ioo θ₁ θ₂) ∪ lensOutCurve P θ₁ θ₂ R := by
  rw [CollarFitOut.map, pushforward_Γ, hfit.homeo_image_Γ]

/-- **The outward lens is the inner colour's**: the lens with the open arc is interior in the bent map, of colour `c` — it is
`h`'s image of part of the inner collar, `{a ≤ t < 1}` stretched onto `{a ≤ t < l}` (mirror of `CollarFit.map_lens` with
`kin_subset`; child G6). -/
theorem CollarFitOut.map_lens (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') {z : ℂ} (hz : z ∈ lensOutSet P θ₁ θ₂ R) :
    z ∈ hfit.map.interiorPts ∧ hfit.map.col z = c := by
  obtain ⟨θ, hθ, t, ht, rfl⟩ := hz
  obtain ⟨h0, ha1, h1l, hlb⟩ := hfit.pushOutProfiles.inside θ hθ
  have ht0 : 0 < t := one_pos.trans_le ht.1
  have hw : hfit.homeo.symm (P + (t : ℂ) * e θ) ∈ F.region c := by
    rw [CollarFitOut.homeo, pushOutHomeo_symm_polar _ hθ ht0]
    exact hfit.kin_subset ⟨θ, hθ, _, push1_mem_Ico (ha1.trans h1l) hlb ha1 ⟨by linarith [ht.1], ht.2⟩, rfl⟩
  rw [← hfit.homeo.apply_symm_apply (P + (t : ℂ) * e θ)]
  exact ⟨(pushforward_mem_interiorPts_iff _).mpr hw.1, (pushforward_col_apply _).trans hw.2⟩

/-- **The outward bent map agrees with `F` off the closed lens** (mirror of `CollarFit.map_agreesOff`; child G6): off the collar
`h` is the identity; on the collar off the closed lens, `h` moves points within the inner collar (colour `c`) or within the outer
collar (colour `c'`). -/
theorem CollarFitOut.map_agreesOff (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') :
    hfit.map.AgreesOff F (lensOutSet P θ₁ θ₂ R ∪ lensOutCurve P θ₁ θ₂ R) := by
  have hp := hfit.pushOutProfiles
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
    · obtain ⟨h0, ha1, h1l, hlb⟩ := hp.inside θ hθo
      have ht0 : 0 < t := h0.trans_le ht.1
      rw [CollarFitOut.homeo, pushOutHomeo_symm_polar hp hθo ht0]
      have hl : t ≠ outerProf θ₁ θ₂ R θ := fun h => hz (Or.inr ⟨θ, hθ, t, h, rfl⟩)
      have hs : ¬ (1 ≤ t ∧ t < outerProf θ₁ θ₂ R θ) := fun h => hz (Or.inl ⟨θ, hθo, t, h, rfl⟩)
      rcases lt_or_gt_of_ne hl with h | h
      · -- the inner collar: both points of colour `c`
        have h1 : t < 1 := by by_contra h'; exact hs ⟨not_lt.mp h', h⟩
        have hz' := hfit.kin_subset ⟨θ, hθo, t, ⟨ht.1, h1⟩, rfl⟩
        have hw' := hfit.kin_subset ⟨θ, hθo, _, push1_mem_Ico (b := outerProf θ₁ θ₂ R'' θ) (ha1.trans h1l) hlb ha1 ⟨ht.1, h⟩, rfl⟩
        exact ⟨iff_of_true hz'.1 hw'.1, hz'.2.trans hw'.2.symm⟩
      · -- the outer collar: both points of colour `c'`
        have hz' := hfit.kout_subset ⟨θ, hθo, t, ⟨h1l.trans h, ht.2⟩, rfl⟩
        have hw' := hfit.kout_subset ⟨θ, hθo, _, push1_mem_Ioc (ha1.trans h1l) hlb (h1l.trans hlb) ⟨h, ht.2⟩, rfl⟩
        exact ⟨iff_of_true hz'.1 hw'.1, hz'.2.trans hw'.2.symm⟩
    · -- an end of the arc: fixed
      have hoff := hp.off θ hθo
      have ht1 : t = 1 := le_antisymm (hoff.2.2 ▸ ht.2) (hoff.1 ▸ ht.1)
      subst ht1
      have hfix := (pushOutHomeo_eq_self (P := P) hp (polar_not_mem_polarSet hfit.short hθ hθo one_pos
        fun θ' _ ht' => (hp.a_pos θ').trans ht'.1)).2
      rw [CollarFitOut.homeo, hfix]
      exact ⟨Iff.rfl, rfl⟩
  · rw [(hfit.homeo_eq_self hK).2]
    exact ⟨Iff.rfl, rfl⟩

/-- **The outward bent map is valid** (mirror of `CollarFit.map_valid`; child G7): the closed lens's interior points are the lens, of
colour `c`, clear for `c` in `F` (`clear` off `ω(P)`, `ne1_region` on the open arc), and no two of them are `1` apart — by
`dist_lt_one_of_mem_lensOutSet` (`dist_lt_one_of_thin` with `κ = R − 1 ≤ 1/8` and `tangRad_sub_one_le`), **not** by
`dist_lt_one_of_mem_polarSet`. -/
theorem CollarFitOut.map_valid (hF : F.Valid) (hfit : CollarFitOut F P θ₁ θ₂ c c' ε R' R R'') : hfit.map.Valid := by
  -- the closed lens's interior points in the bent map are the lens
  have hU : ∀ z ∈ (lensOutSet P θ₁ θ₂ R ∪ lensOutCurve P θ₁ θ₂ R) ∩ hfit.map.interiorPts, z ∈ lensOutSet P θ₁ θ₂ R := by
    rintro z ⟨hz | hz, hzi⟩
    · exact hz
    · have hΓ : z ∈ hfit.map.Γ := by rw [hfit.map_Γ]; exact Or.inr hz
      exact (hzi.2 hΓ.2).elim
  refine Valid.of_agreesOff hF hfit.map_agreesOff (fun z hz => ?_) (fun z hz y hy hzy => ?_)
  · have hzl := hU z hz
    rw [(hfit.map_lens hzl).2]
    obtain ⟨θ, hθ, t, ht, rfl⟩ := hzl
    rcases eq_or_lt_of_le ht.1 with h | h
    · -- on the open arc: in the closure of the inner class
      subst h
      have hcl : P + ((1 : ℝ) : ℂ) * e θ ∈ closure (F.region c) := by
        have hc : c ∈ F.innerColours P (ringPt P θ) := by rw [(hfit.ring.2.2 θ hθ).1]; exact mem_singleton c
        rw [show P + ((1 : ℝ) : ℂ) * e θ = ringPt P θ by simp [ringPt]]
        exact closure_mono inter_subset_left hc
      intro y hy hdist
      exact ne1_region hF hcl hy (by rw [dist_comm]; exact hdist)
    · exact hfit.clear _ ⟨θ, hθ, t, ⟨h, ht.2⟩, rfl⟩
  · exact absurd hzy (dist_lt_one_of_mem_lensOutSet hfit.params.2.2.1.le hfit.params.2.2.2.2 hfit.short (hU z hz) (hU y hy)).ne

end CollarOut

end ArcMap

end HadwigerNelson.Plane

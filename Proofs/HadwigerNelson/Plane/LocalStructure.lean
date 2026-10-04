import Proofs.HadwigerNelson.Plane.LocalMap
import Mathlib.LinearAlgebra.Complex.FiniteDimensional
import Mathlib.Geometry.Euclidean.Basic

/-!
# The local structure of an arc map at a point: finitely many tiles, the germ dichotomy, interval cones

Wave 3's supporting lemmas (`plans/FS131-w3-kernel-plan.md` § "For stage 3" and stage 3; inventory ruling 27: wave 3 takes
these forward from wave 4's foundation). Pure topology of `ArcMap`: no validity, no colour count.

* **Angular intervals.** `angleIcc a b` and `angleIoo a b` are the closed and open intervals `[a, b]`, `(a, b)` of angles,
  repeated with period `2π` — the rows' cones "`[θ₂ − 90°, θ₁ + 90°]`" read on the circle. Empty when `b < a` (resp.
  `b ≤ a`); the whole line when `b − a ≥ 2π`.
* **The disc of radius above 1.** `covers_one_iff`: a fragment covers `B̄(p, 1)` exactly when it covers a closed disc of
  radius above `1` about `p` (the domain is open and the disc compact) — so every row's "on a closed disc of radius above
  1 about `p`" is stated as `F.Covers p 1`.
* **Arcs against a unit circle.** `Arc.finite_inter_sphere_or_eq_circ`: a nondegenerate arc meets `ω(p)` in finitely many
  points or is an arc of `ω(p)` itself; `finite_ringΓ_off_ringArc`: on a covered ring, the points of `Γ` that lie on no arc
  of `Γ` on `ω(p)` are finitely many.
* **Interior points are dense** (`dense_interiorPts`): `Γ` is a locally finite union of arcs, so it has empty interior;
  every point of the domain carries a colour (`exists_mem_coloursAt`).
* **Finitely many tiles near a point** (`finite_tiles_near`, the wave's hardest leaf) and its consequences: the colours at
  a point are the colours of the tiles whose closure holds it (`mem_coloursAt_iff_exists_tileOf`), the cone of a colour
  class is the union of its tiles' cones (`coneAt_region_eq_biUnion`), every direction lies in some colour's cone
  (`exists_mem_coneAt_region`).
* **The germ dichotomy** (`germ_dichotomy`): at a ring point in the domain, a germ lies in one colour class, or on an arc of
  `Γ` on `ω(p)` with constant sides.
* **Interval cones in a simple map** (`Simple.coneAt_eq_angleIcc`): each tile's cone at a point of its closure is one closed
  angular interval.

Every leaf is `sorry` until wave 3's implementer lands it (`plans/FS131-w3-kernel-plan.md` § the leaf plans).
-/

namespace HadwigerNelson.Plane

open Complex Real Set Filter Topology Metric

/-! ## Angular intervals -/

/-- Normalising is `2/‖u‖`-Lipschitz at `u`: `‖w/‖w‖ − u/‖u‖‖ ≤ 2‖w − u‖/‖u‖`. -/
theorem norm_div_norm_sub_le {u w : ℂ} (hu : u ≠ 0) (hw : w ≠ 0) :
    ‖w / (‖w‖ : ℂ) - u / (‖u‖ : ℂ)‖ ≤ 2 * ‖w - u‖ / ‖u‖ := by
  set a := ‖u‖ with ha
  set b := ‖w‖ with hb
  have ha0 : 0 < a := norm_pos_iff.mpr hu
  have hb0 : 0 < b := norm_pos_iff.mpr hw
  have hac : (a : ℂ) ≠ 0 := by exact_mod_cast ha0.ne'
  have hbc : (b : ℂ) ≠ 0 := by exact_mod_cast hb0.ne'
  have key : w / (b : ℂ) - u / (a : ℂ) = (w - u) / (a : ℂ) + w * (((a - b) / (a * b) : ℝ) : ℂ) := by
    push_cast; field_simp; ring
  rw [key]
  refine (norm_add_le _ _).trans ?_
  have h1 : ‖(w - u) / (a : ℂ)‖ = ‖w - u‖ / a := by
    rw [norm_div, Complex.norm_real, Real.norm_eq_abs, abs_of_pos ha0]
  have h2 : ‖w * (((a - b) / (a * b) : ℝ) : ℂ)‖ = |a - b| / a := by
    rw [norm_mul, Complex.norm_real, Real.norm_eq_abs, abs_div, abs_of_pos (mul_pos ha0 hb0), ← hb]
    field_simp
  have h3 : |a - b| ≤ ‖w - u‖ := by
    rw [abs_sub_comm]; exact abs_norm_sub_norm_le w u
  rw [h1, h2]
  have : |a - b| / a ≤ ‖w - u‖ / a := div_le_div_of_nonneg_right h3 ha0.le
  have e : 2 * ‖w - u‖ / a = ‖w - u‖ / a + ‖w - u‖ / a := by ring
  rw [e]; linarith

/-- The closed angular interval `[a, b]`, repeated with period `2π`. -/
def angleIcc (a b : ℝ) : Set ℝ := ⋃ m : ℤ, Icc (a + 2 * π * m) (b + 2 * π * m)

/-- The open angular interval `(a, b)`, repeated with period `2π`. -/
def angleIoo (a b : ℝ) : Set ℝ := ⋃ m : ℤ, Ioo (a + 2 * π * m) (b + 2 * π * m)

/-- `[a, b]` lies in its angular interval. -/
theorem Icc_subset_angleIcc (a b : ℝ) : Icc a b ⊆ angleIcc a b := fun x hx =>
  mem_iUnion.mpr ⟨0, by simpa using hx⟩

/-- `(a, b)` lies in its angular interval. -/
theorem Ioo_subset_angleIoo (a b : ℝ) : Ioo a b ⊆ angleIoo a b := fun x hx =>
  mem_iUnion.mpr ⟨0, by simpa using hx⟩

/-- Spec example: `2π + π/2` lies in the angular interval `[0, π]`. -/
example : 2 * π + π / 2 ∈ angleIcc 0 π := by
  refine mem_iUnion.mpr ⟨1, ?_⟩
  constructor <;> push_cast <;> linarith [Real.pi_pos]

/-- **Adversary**: `−π/2` does not lie in the angular interval `(0, π)`. -/
example : -(π / 2) ∉ angleIoo 0 π := by
  intro h
  obtain ⟨m, hm1, hm2⟩ := mem_iUnion.mp h
  have hπ := Real.pi_pos
  rcases lt_or_ge m 0 with hm | hm
  · have : (m : ℝ) ≤ -1 := by exact_mod_cast Int.le_sub_one_iff.mpr hm
    nlinarith
  · have : (0 : ℝ) ≤ m := by exact_mod_cast hm
    nlinarith

/-! ## Arcs against a unit circle -/

/-- A nondegenerate arc meets the unit circle `ω(p)` in finitely many points, unless it is an arc of `ω(p)` itself (a
line or a different circle meets `ω(p)` in at most two points). -/
theorem Arc.finite_inter_sphere_or_eq_circ (a : Arc) (ha : a.Nondegenerate) (p : ℂ) :
    (a.carrier ∩ sphere p 1).Finite ∨ ∃ θ₀ θ₁, a = .circ p 1 θ₀ θ₁ := by
  cases a with
  | seg a b =>
    left
    have hab : b - a ≠ 0 := sub_ne_zero.mpr (Ne.symm ha)
    set A : ℝ := ‖b - a‖ ^ 2
    set B : ℝ := 2 * ((a - p) * (starRingEnd ℂ) (b - a)).re
    set C : ℝ := ‖a - p‖ ^ 2 - 1
    have hA : A ≠ 0 := by positivity
    let q : Polynomial ℝ := Polynomial.C A * Polynomial.X ^ 2 + Polynomial.C B * Polynomial.X + Polynomial.C C
    have hq : q ≠ 0 := by
      intro h
      have := congrArg (fun r => Polynomial.coeff r 2) h
      simp [q, Polynomial.coeff_X_pow] at this
      exact hA this
    refine ((Polynomial.finite_setOf_isRoot hq).image (fun t : ℝ => a + (t : ℂ) * (b - a))).subset ?_
    rintro z ⟨hz, hzs⟩
    rw [Arc.carrier, segment_eq_image'] at hz
    obtain ⟨t, -, rfl⟩ := hz
    refine ⟨t, ?_, by simp [Complex.real_smul]⟩
    simp only [mem_sphere, dist_eq_norm] at hzs
    have h2 : ‖a + (t : ℂ) * (b - a) - p‖ ^ 2 = 1 := by
      simp only [Complex.real_smul] at hzs
      rw [hzs]; norm_num
    have h3 : ‖a - p + (t : ℂ) * (b - a)‖ ^ 2 = A * t ^ 2 + B * t + (C + 1) := by
      rw [Complex.sq_norm, Complex.normSq_apply]
      simp only [A, B, C, Complex.sq_norm, Complex.normSq_apply, Complex.add_re, Complex.add_im,
        Complex.mul_re, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im, Complex.sub_re,
        Complex.sub_im, Complex.conj_re, Complex.conj_im]
      ring
    have h4 : a - p + (t : ℂ) * (b - a) = a + (t : ℂ) * (b - a) - p := by ring
    rw [h4, h2] at h3
    simp only [q, Set.mem_setOf_eq, Polynomial.IsRoot, Polynomial.eval_add, Polynomial.eval_mul,
      Polynomial.eval_C, Polynomial.eval_pow, Polynomial.eval_X]
    linarith
  | circ c ρ θ₀ θ₁ =>
    by_cases hcp : c = p
    · subst hcp
      by_cases hρ : ρ = 1
      · right; subst hρ; exact ⟨θ₀, θ₁, rfl⟩
      · left
        have : (Arc.circ c ρ θ₀ θ₁).carrier ∩ sphere c 1 = ∅ := by
          refine eq_empty_of_forall_notMem ?_
          rintro z ⟨⟨θ, -, rfl⟩, hz⟩
          simp only [mem_sphere, dist_eq_norm, add_sub_cancel_left, norm_mul, norm_e, mul_one,
            Complex.norm_real] at hz
          have hρ0 : 0 < ρ := ha.1
          rw [Real.norm_eq_abs, abs_of_pos hρ0] at hz
          exact hρ hz
        rw [this]; exact finite_empty
    · left
      have hsub : (Arc.circ c ρ θ₀ θ₁).carrier ∩ sphere p 1 ⊆ sphere c ρ ∩ sphere p 1 := by
        rintro z ⟨⟨θ, -, rfl⟩, hz⟩
        refine ⟨?_, hz⟩
        have hρ0 : 0 < ρ := ha.1
        simp [norm_e, abs_of_pos hρ0]
      refine Set.Finite.subset ?_ hsub
      by_cases hsub1 : (sphere c ρ ∩ sphere p 1 : Set ℂ).Subsingleton
      · exact hsub1.finite
      · obtain ⟨x, hx, y, hy, hxy⟩ := Set.not_subsingleton_iff.mp hsub1
        refine (Set.toFinite {x, y}).subset ?_
        intro z hz
        have := EuclideanGeometry.eq_of_dist_eq_of_dist_eq_of_finrank_eq_two
          (V := ℂ) (P := ℂ) Complex.finrank_real_complex hcp hxy hx.1 hy.1 hz.1 hx.2 hy.2 hz.2
        simpa using this

/-- A segment is a Lebesgue-null set of the plane (it lies in a proper affine subspace). -/
theorem volume_segment_eq_zero (a b : ℂ) : MeasureTheory.volume (segment ℝ a b) = 0 := by
  let s : AffineSubspace ℝ ℂ := AffineSubspace.mk' a (Submodule.span ℝ {b - a})
  have hsub : segment ℝ a b ⊆ (s : Set ℂ) := by
    rintro z ⟨u, v, hu, hv, huv, rfl⟩
    rw [SetLike.mem_coe, AffineSubspace.mem_mk']
    refine Submodule.mem_span_singleton.mpr ⟨v, ?_⟩
    have : u = 1 - v := by linarith
    subst this
    simp only [vsub_eq_sub, Complex.real_smul]
    push_cast; ring
  refine MeasureTheory.measure_mono_null hsub (MeasureTheory.Measure.addHaar_affineSubspace _ _ ?_)
  intro h
  have h1 : s.direction = ⊤ := by rw [h]; exact AffineSubspace.direction_top _ _ _
  rw [AffineSubspace.direction_mk'] at h1
  have h2 := finrank_span_le_card (R := ℝ) ({b - a} : Set ℂ)
  rw [h1, finrank_top, Complex.finrank_real_complex] at h2
  simp at h2

/-- The points of an arc form a Lebesgue-null set. -/
theorem Arc.volume_carrier (a : Arc) : MeasureTheory.volume a.carrier = 0 := by
  cases a with
  | seg a b => exact volume_segment_eq_zero a b
  | circ c ρ θ₀ θ₁ =>
    refine MeasureTheory.measure_mono_null (t := sphere c |ρ|) ?_
      (MeasureTheory.Measure.addHaar_sphere _ _ _)
    rintro _ ⟨θ, -, rfl⟩
    simp [norm_e]

namespace ArcMap

variable {k : ℕ} (F : ArcMap k)

/-! ## The disc of radius above 1 -/

/-- A fragment covers `B̄(p, 1)` exactly when it covers a closed disc of radius above `1` about `p`: the domain is open and
the disc compact. Every row's "on a closed disc of radius above 1 about `p`" is stated as `F.Covers p 1`. -/
theorem covers_one_iff (p : ℂ) : F.Covers p 1 ↔ ∃ R, 1 < R ∧ F.Covers p R := by
  constructor
  · intro h
    obtain ⟨δ, hδ, hsub⟩ := isCompact_closedBall p (1 : ℝ) |>.exists_cthickening_subset_open F.isOpen_dom h
    refine ⟨δ + 1, by linarith, ?_⟩
    have := cthickening_closedBall (E := ℂ) hδ.le zero_le_one p
    rw [this] at hsub
    exact hsub
  · rintro ⟨R, hR, h⟩
    exact (closedBall_subset_closedBall hR.le).trans h

/-! ## The points of `Γ` on a ring that lie on no arc of `Γ` on it -/

/-- On a covered ring, the points of `Γ` that lie on no arc of `Γ` on `ω(p)` are finitely many: the ring is compact, each
of its points has a neighbourhood meeting finitely many arcs, and each arc not on `ω(p)` meets `ω(p)` in finitely many
points (`Arc.finite_inter_sphere_or_eq_circ`). -/
theorem finite_ringΓ_off_ringArc {p : ℂ} (hp : F.Covers p 1) :
    ((F.Γ ∩ sphere p 1) \ {x | F.OnRingArc p x}).Finite := by
  have hK : sphere p 1 ⊆ F.dom := sphere_subset_closedBall.trans hp
  choose! t ht hfin using F.locallyFinite
  obtain ⟨S, hSK, hcov⟩ := (isCompact_sphere p 1).elim_nhds_subcover t fun x hx => ht x (hK hx)
  have h𝒜 : {a | a ∈ F.arcs ∧ (a.carrier ∩ sphere p 1).Nonempty}.Finite := by
    refine (S.finite_toSet.biUnion fun x hx => hfin x (hK (hSK x hx))).subset ?_
    rintro a ⟨ha, y, hya, hyK⟩
    obtain ⟨x, hxS, hyx⟩ := mem_iUnion₂.mp (hcov hyK)
    exact mem_iUnion₂.mpr ⟨x, hxS, ha, y, hya, hyx⟩
  have hsub : (F.Γ ∩ sphere p 1) \ {x | F.OnRingArc p x} ⊆
      ⋃ a ∈ {a | a ∈ F.arcs ∧ (a.carrier ∩ sphere p 1).Nonempty},
        (a.carrier ∩ sphere p 1) \ {x | F.OnRingArc p x} := by
    rintro x ⟨⟨⟨hxd, hxΓ⟩, hxK⟩, hxn⟩
    obtain ⟨a, ha, hxa⟩ := mem_iUnion₂.mp hxΓ
    exact mem_iUnion₂.mpr ⟨a, ⟨ha, x, hxa, hxK⟩, ⟨hxa, hxK⟩, hxn⟩
  refine (h𝒜.biUnion fun a ha => ?_).subset hsub
  rcases Arc.finite_inter_sphere_or_eq_circ a (F.nondegenerate a ha.1) p with h | ⟨θ₀, θ₁, rfl⟩
  · exact h.subset sdiff_subset
  · refine (finite_empty).subset ?_
    rintro x ⟨⟨hxa, hxK⟩, hxn⟩
    apply hxn
    have hnd := F.nondegenerate _ ha.1
    have hcar : (Arc.circ p 1 θ₀ θ₁).carrier = ringArc p θ₀ θ₁ := by
      simp [Arc.carrier, ringArc, ringPt]
    refine ⟨θ₀, θ₁, hnd.2.1, ?_, ?_⟩
    · rw [← hcar]; exact hxa
    · rw [← hcar]
      intro z hz
      refine ⟨hK ?_, mem_iUnion₂.mpr ⟨_, ha.1, hz⟩⟩
      obtain ⟨θ, -, rfl⟩ := hz
      simp


/-! ## Interior points are dense -/

/-- `Γ` has empty interior: every point of the domain is a limit of interior points. -/
theorem dense_interiorPts : F.dom ⊆ closure F.interiorPts := by
  intro x hx
  rw [Metric.mem_closure_iff]
  intro ε hε
  obtain ⟨t, ht, hfin⟩ := F.locallyFinite x hx
  obtain ⟨r, hr, hrsub⟩ := Metric.mem_nhds_iff.mp (inter_mem ht (F.isOpen_dom.mem_nhds hx))
  set r' := min r ε
  have hr' : 0 < r' := lt_min hr hε
  set N : Set ℂ := ⋃ a ∈ {a | a ∈ F.arcs ∧ (a.carrier ∩ t).Nonempty}, a.carrier
  have hN : MeasureTheory.volume N = 0 :=
    (MeasureTheory.measure_biUnion_null_iff hfin.countable).mpr fun a _ => a.volume_carrier
  have hpos : 0 < MeasureTheory.volume (ball x r') := Metric.measure_ball_pos _ _ hr'
  have hnot : ¬ ball x r' ⊆ N := fun h =>
    absurd (MeasureTheory.measure_mono_null h hN) hpos.ne'
  obtain ⟨y, hy, hyN⟩ := not_subset.mp hnot
  have hyr : y ∈ ball x r := ball_subset_ball (min_le_left _ _) hy
  refine ⟨y, ⟨(hrsub hyr).2, fun hΓ => hyN ?_⟩, ?_⟩
  · obtain ⟨a, ha, hya⟩ := mem_iUnion₂.mp hΓ
    exact mem_iUnion₂.mpr ⟨a, ⟨ha, y, hya, (hrsub hyr).1⟩, hya⟩
  · rw [dist_comm]
    exact lt_of_lt_of_le (mem_ball.mp hy) (min_le_right _ _)

/-- Every point of the domain carries a colour. -/
theorem exists_mem_coloursAt {x : ℂ} (hx : x ∈ F.dom) : ∃ c, c ∈ F.coloursAt x := by
  have hx' := F.dense_interiorPts hx
  have : F.interiorPts = ⋃ c, F.region c := by
    ext y
    simp only [mem_iUnion, region, mem_inter_iff, mem_preimage, mem_singleton_iff]
    exact ⟨fun h => ⟨F.col y, h, rfl⟩, fun ⟨_, h, _⟩ => h⟩
  rw [this, closure_iUnion_of_finite] at hx'
  obtain ⟨c, hc⟩ := mem_iUnion.mp hx'
  exact ⟨c, hc⟩

/-! ## A ray from a point of the domain into the interior points -/

/-- A line meets a circle in finitely many points: `{s | ‖x + s w − c‖ = ρ}` is finite when `w ≠ 0`. -/
theorem finite_ray_inter_sphere (x c w : ℂ) (ρ : ℝ) (hw : w ≠ 0) :
    {s : ℝ | ‖x + (s : ℂ) * w - c‖ = ρ}.Finite := by
  set A : ℝ := ‖w‖ ^ 2
  set B : ℝ := 2 * ((x - c) * (starRingEnd ℂ) w).re
  set C : ℝ := ‖x - c‖ ^ 2 - ρ ^ 2
  have hA : A ≠ 0 := by positivity
  let q : Polynomial ℝ := Polynomial.C A * Polynomial.X ^ 2 + Polynomial.C B * Polynomial.X + Polynomial.C C
  have hq : q ≠ 0 := by
    intro h
    have := congrArg (fun r => Polynomial.coeff r 2) h
    simp [q, Polynomial.coeff_X_pow] at this
    exact hA this
  refine (Polynomial.finite_setOf_isRoot hq).subset ?_
  intro t ht
  simp only [mem_setOf_eq] at ht
  have h3 : ‖x - c + (t : ℂ) * w‖ ^ 2 = A * t ^ 2 + B * t + (C + ρ ^ 2) := by
    rw [Complex.sq_norm, Complex.normSq_apply]
    simp only [A, B, C, Complex.sq_norm, Complex.normSq_apply, Complex.add_re, Complex.add_im,
      Complex.mul_re, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im, Complex.sub_re,
      Complex.sub_im, Complex.conj_re, Complex.conj_im]
    ring
  have h4 : x - c + (t : ℂ) * w = x + (t : ℂ) * w - c := by ring
  rw [h4, ht] at h3
  simp only [q, Set.mem_setOf_eq, Polynomial.IsRoot, Polynomial.eval_add, Polynomial.eval_mul,
    Polynomial.eval_C, Polynomial.eval_pow, Polynomial.eval_X]
  linarith

/-- A ray `x + s w` with `w` not parallel to the segment `[u, v]` meets it in at most one point. -/
theorem subsingleton_ray_inter_segment (x u v w : ℂ) (hd : v - u ≠ 0)
    (hpar : (w * (starRingEnd ℂ) (v - u)).im ≠ 0) :
    {s : ℝ | x + (s : ℂ) * w ∈ segment ℝ u v}.Subsingleton := by
  intro s₁ h₁ s₂ h₂
  obtain ⟨a₁, b₁, -, hb₁, hab₁, e₁⟩ := h₁
  obtain ⟨a₂, b₂, -, hb₂, hab₂, e₂⟩ := h₂
  by_contra hne
  have key : ((s₁ - s₂ : ℝ) : ℂ) * w = ((b₁ - b₂ : ℝ) : ℂ) * (v - u) := by
    have ha₁ : a₁ = 1 - b₁ := by linarith
    have ha₂ : a₂ = 1 - b₂ := by linarith
    subst ha₁ ha₂
    simp only [Complex.real_smul] at e₁ e₂
    push_cast at e₁ e₂ ⊢
    linear_combination e₂ - e₁
  apply hpar
  have : w = (((b₁ - b₂) / (s₁ - s₂) : ℝ) : ℂ) * (v - u) := by
    have hs : ((s₁ - s₂ : ℝ) : ℂ) ≠ 0 := by
      exact_mod_cast sub_ne_zero.mpr hne
    apply mul_left_cancel₀ hs
    rw [key]
    push_cast
    have hs' : ((s₁ : ℂ) - s₂) ≠ 0 := by simpa using hs
    field_simp
  rw [this, mul_assoc, Complex.mul_conj, ← Complex.ofReal_mul]
  exact Complex.ofReal_im _

/-- **A ray from a point of the domain** (child of engine 2): there are a direction `w ≠ 0` and `ε > 0` with
`x + s w` an interior point for all `0 < s < ε`. -/
theorem exists_ray_in_interiorPts {x : ℂ} (hx : x ∈ F.dom) :
    ∃ w : ℂ, w ≠ 0 ∧ ∃ ε > 0, ∀ s ∈ Ioo (0 : ℝ) ε, x + (s : ℂ) * w ∈ F.interiorPts := by
  classical
  obtain ⟨t, ht, hfin⟩ := F.locallyFinite x hx
  set 𝒜 := {a | a ∈ F.arcs ∧ (a.carrier ∩ t).Nonempty}
  obtain ⟨r, hr, hrsub⟩ := Metric.mem_nhds_iff.mp (inter_mem ht (F.isOpen_dom.mem_nhds hx))
  -- the bad slopes
  let slope : Arc → ℝ := fun a => match a with
    | .seg u v => (v - u).im / (v - u).re
    | .circ .. => 0
  have hbad : (slope '' 𝒜).Finite := hfin.image _
  obtain ⟨lam, hlam⟩ := hbad.infinite_compl.nonempty
  set w : ℂ := 1 + (lam : ℂ) * I with hw
  have hw0 : w ≠ 0 := by
    intro h; have := congrArg Complex.re h; simp [hw] at this
  have hfinS : {s : ℝ | x + (s : ℂ) * w ∈ ⋃ a ∈ 𝒜, a.carrier}.Finite := by
    have : {s : ℝ | x + (s : ℂ) * w ∈ ⋃ a ∈ 𝒜, a.carrier} ⊆ ⋃ a ∈ 𝒜, {s : ℝ | x + (s : ℂ) * w ∈ a.carrier} := by
      intro s hs
      obtain ⟨a, ha, hsa⟩ := mem_iUnion₂.mp hs
      exact mem_iUnion₂.mpr ⟨a, ha, hsa⟩
    refine (hfin.biUnion fun a ha => ?_).subset this
    have hnd := F.nondegenerate a ha.1
    cases a with
    | seg u v =>
      have hd : v - u ≠ 0 := sub_ne_zero.mpr (Ne.symm hnd)
      refine (subsingleton_ray_inter_segment x u v w hd ?_).finite
      intro him
      apply hlam
      refine ⟨Arc.seg u v, ha, ?_⟩
      show (v - u).im / (v - u).re = lam
      have hre : (v - u).re ≠ 0 := by
        intro h0
        have : (w * (starRingEnd ℂ) (v - u)).im = lam * (v - u).re - (v - u).im := by
          simp [hw, Complex.mul_im]; ring
        rw [this, h0] at him
        have him' : (v - u).im = 0 := by linarith
        exact hd (Complex.ext h0 him')
      have : (w * (starRingEnd ℂ) (v - u)).im = lam * (v - u).re - (v - u).im := by
        simp [hw, Complex.mul_im]; ring
      rw [this] at him
      field_simp
      linarith
    | circ c ρ θ₀ θ₁ =>
      refine (finite_ray_inter_sphere x c w |ρ| hw0).subset ?_
      rintro s ⟨θ, -, hθ⟩
      simp only [mem_setOf_eq]
      rw [← hθ]
      simp [norm_e]
  obtain ⟨ε₁, hε₁, hε₁S⟩ : ∃ ε > 0, ∀ s ∈ {s : ℝ | x + (s : ℂ) * w ∈ ⋃ a ∈ 𝒜, a.carrier}, ε ≤ |s| ∨ s = 0 ∨ True := by
    exact ⟨1, one_pos, fun _ _ => Or.inr (Or.inr trivial)⟩
  -- a positive lower bound for the bad parameters
  have hclosed := hfinS.isClosed
  have hopen : IsOpen {s : ℝ | x + (s : ℂ) * w ∈ ⋃ a ∈ 𝒜, a.carrier}ᶜ := hclosed.isOpen_compl
  -- remove s = 0, which may be bad: use the finite set restricted to positive parameters
  have hfinPos : ({s : ℝ | x + (s : ℂ) * w ∈ ⋃ a ∈ 𝒜, a.carrier} ∩ Ioi 0).Finite := hfinS.subset inter_subset_left
  have hcl2 := hfinPos.isClosed
  have h0 : (0 : ℝ) ∈ ({s : ℝ | x + (s : ℂ) * w ∈ ⋃ a ∈ 𝒜, a.carrier} ∩ Ioi 0)ᶜ := by
    intro h; exact (lt_irrefl (0 : ℝ)) h.2
  obtain ⟨ε₂, hε₂, hball⟩ := Metric.isOpen_iff.mp hcl2.isOpen_compl 0 h0
  refine ⟨w, hw0, min ε₂ (r / ‖w‖), lt_min hε₂ (div_pos hr (norm_pos_iff.mpr hw0)), ?_⟩
  intro s hs
  have hs0 : 0 < s := hs.1
  have hsε : s < ε₂ := lt_of_lt_of_le hs.2 (min_le_left _ _)
  have hsr : s * ‖w‖ < r := by
    have := lt_of_lt_of_le hs.2 (min_le_right _ _)
    rwa [lt_div_iff₀ (norm_pos_iff.mpr hw0)] at this
  have hmem : x + (s : ℂ) * w ∈ ball x r := by
    rw [mem_ball, dist_eq_norm]
    simpa [norm_mul, abs_of_pos hs0] using hsr
  have hnb : x + (s : ℂ) * w ∉ ⋃ a ∈ 𝒜, a.carrier := by
    intro h
    have : s ∈ ({s : ℝ | x + (s : ℂ) * w ∈ ⋃ a ∈ 𝒜, a.carrier} ∩ Ioi 0) := ⟨h, hs0⟩
    have hsb : s ∈ ball (0 : ℝ) ε₂ := by
      rw [mem_ball, Real.dist_eq, sub_zero, abs_of_pos hs0]; exact hsε
    exact hball hsb this
  refine ⟨(hrsub hmem).2, fun hΓ => hnb ?_⟩
  obtain ⟨a, ha, hya⟩ := mem_iUnion₂.mp hΓ
  exact mem_iUnion₂.mpr ⟨a, ⟨ha, _, hya, (hrsub hmem).1⟩, hya⟩

/-- **Engine 2.** Every point of the domain lies in the closure of some tile: a ray from it into the interior points
is connected, so lies in one tile. -/
theorem mem_closure_tile {x : ℂ} (hx : x ∈ F.dom) : ∃ T, F.IsTile T ∧ x ∈ closure T := by
  obtain ⟨w, hw, ε, hε, hray⟩ := F.exists_ray_in_interiorPts hx
  set y := x + ((ε / 2 : ℝ) : ℂ) * w
  have hy : y ∈ F.interiorPts := hray _ ⟨by positivity, by linarith⟩
  refine ⟨connectedComponentIn F.interiorPts y, ⟨y, hy, rfl⟩, ?_⟩
  have hpre : IsPreconnected ((fun s : ℝ => x + (s : ℂ) * w) '' Ioo 0 ε) :=
    (isPreconnected_Ioo).image _ (by fun_prop)
  have hsub : (fun s : ℝ => x + (s : ℂ) * w) '' Ioo 0 ε ⊆ connectedComponentIn F.interiorPts y :=
    hpre.subset_connectedComponentIn ⟨ε / 2, ⟨by positivity, by linarith⟩, rfl⟩
      (by rintro _ ⟨s, hs, rfl⟩; exact hray s hs)
  refine closure_mono hsub ?_
  have hcont : Continuous fun s : ℝ => x + (s : ℂ) * w := by fun_prop
  have h0x := map_mem_closure hcont (by rw [closure_Ioo hε.ne]; exact ⟨le_rfl, hε.le⟩ : (0 : ℝ) ∈ closure (Ioo 0 ε))
    (mapsTo_image (fun s : ℝ => x + (s : ℂ) * w) (Ioo 0 ε))
  simpa using h0x

/-! ## Finitely many tiles near a point -/

/-- **Finitely many tiles meet a small disc about any point of the domain**: near `x` only the arcs through `x` remain,
each with at most two branches at `x`; for small `r` the branches are disjoint off `x` and cut `B(x, r)` into at most as
many curvilinear sectors as there are branches, each connected. -/
theorem finite_tiles_near {x : ℂ} (hx : x ∈ F.dom) :
    ∃ r > 0, {T | F.IsTile T ∧ (T ∩ ball x r).Nonempty}.Finite := by
  sorry

/-- The colours at a point of the domain are the colours of the tiles whose closure holds it (the rows' `P_cl`, read
tile by tile). -/
theorem mem_coloursAt_iff_exists_tileOf {x : ℂ} (hx : x ∈ F.dom) {c : Fin k} :
    c ∈ F.coloursAt x ↔ ∃ T, F.TileOf c T ∧ x ∈ closure T := by
  sorry

/-- At a point of the domain, the cone of a colour class is the union of the cones of its tiles whose closure holds the
point: "the cone of a tile of colour `c`" and "the cone of the class of `c`" agree. -/
theorem coneAt_region_eq_biUnion {x : ℂ} (hx : x ∈ F.dom) (c : Fin k) :
    coneAt (F.region c) x = ⋃ T ∈ {T | F.TileOf c T ∧ x ∈ closure T}, coneAt T x := by
  sorry

/-- At a point of the domain every direction lies in the cone of some colour (pigeonhole over the finitely many colours,
on interior points near the ray). -/
theorem exists_mem_coneAt_region {x : ℂ} (hx : x ∈ F.dom) (β : ℝ) : ∃ c, β ∈ coneAt (F.region c) x := by
  classical
  obtain ⟨r, hr, hrsub⟩ := Metric.isOpen_iff.mp F.isOpen_dom x hx
  obtain ⟨N₀, hN₀⟩ := exists_nat_gt (2 / r)
  set N : ℕ := N₀ + 2 with hNdef
  have hN : 2 / r < N := lt_of_lt_of_le hN₀ (by rw [hNdef]; push_cast; linarith)
  have hN2 : (2 : ℝ) ≤ N := by rw [hNdef]; push_cast; linarith [(Nat.cast_nonneg N₀ : (0 : ℝ) ≤ N₀)]
  have hmge : ∀ n : ℕ, (N : ℝ) ≤ ((n + N : ℕ) : ℝ) := fun n => by
    push_cast; linarith [(Nat.cast_nonneg n : (0 : ℝ) ≤ n)]
  have hex : ∀ n : ℕ, ∃ z : ℂ, z ∈ F.interiorPts ∧
      dist z (x + e β / ((n + N : ℕ) : ℂ)) < 1 / ((n + N : ℕ) : ℝ) ^ 2 := by
    intro n
    have hm0 : (0 : ℝ) < ((n + N : ℕ) : ℝ) := lt_of_lt_of_le (by linarith) (hmge n)
    have hmem : x + e β / ((n + N : ℕ) : ℂ) ∈ ball x r := by
      rw [mem_ball, dist_eq_norm, add_sub_cancel_left, norm_div, norm_e, Complex.norm_natCast]
      rw [div_lt_iff₀ hm0]
      have h2 : 2 / r < N := hN
      rw [div_lt_iff₀ hr] at h2
      nlinarith [hmge n]
    have hd := F.dense_interiorPts (hrsub hmem)
    obtain ⟨z, hz, hzd⟩ := Metric.mem_closure_iff.mp hd (1 / ((n + N : ℕ) : ℝ) ^ 2) (by positivity)
    exact ⟨z, hz, by rw [dist_comm]; exact hzd⟩
  choose z hzI hzd using hex
  obtain ⟨c, hc⟩ : ∃ c : Fin k, {n : ℕ | F.col (z n) = c}.Infinite := by
    by_contra hcon
    push Not at hcon
    have hfin : (Set.univ : Set ℕ).Finite := by
      have : (Set.univ : Set ℕ) = ⋃ c : Fin k, {n : ℕ | F.col (z n) = c} := by
        ext n; simp
      rw [this]
      exact Set.finite_iUnion fun c => hcon c
    exact Set.infinite_univ hfin
  refine ⟨c, fun ε hε => ?_⟩
  obtain ⟨M, hM⟩ : ∃ M : ℕ, 8 / ε < M := exists_nat_gt _
  obtain ⟨n, hn, hnM⟩ := hc.exists_gt M
  have hmM : (M : ℝ) < ((n + N : ℕ) : ℝ) := by
    have : M < n + N := by omega
    exact_mod_cast this
  set m : ℕ := n + N with hm
  have hm0 : (2 : ℝ) ≤ m := (hN2.trans (hmge n))
  have hmpos : (0 : ℝ) < m := by linarith
  have hmε : 8 < ε * m := by
    have : 8 / ε < m := hM.trans hmM
    rwa [div_lt_iff₀ hε, mul_comm] at this
  set u : ℂ := e β / (m : ℂ) with hu
  have hun : ‖u‖ = 1 / m := by rw [hu, norm_div, norm_e, Complex.norm_natCast]
  have hu0 : u ≠ 0 := by
    intro h; rw [h, norm_zero] at hun; have : (0:ℝ) < 1 / m := by positivity
    linarith
  have hwu : ‖z n - x - u‖ < 1 / (m : ℝ) ^ 2 := by
    have := hzd n
    rw [dist_eq_norm, show z n - (x + u) = z n - x - u by ring] at this
    exact this
  have hwu' : 1 / (m : ℝ) ^ 2 ≤ 1 / (2 * m) := by
    rw [div_le_div_iff₀ (by positivity) (by positivity)]; nlinarith
  have hwn : 1 / (2 * (m : ℝ)) ≤ ‖z n - x‖ := by
    have h2 := norm_sub_norm_le u (z n - x)
    rw [norm_sub_rev u (z n - x), hun] at h2
    have : 1 / (m : ℝ) = 2 * (1 / (2 * m)) := by field_simp
    linarith
  have hw0 : z n - x ≠ 0 := by
    intro h; rw [h, norm_zero] at hwn
    have : (0 : ℝ) < 1 / (2 * (m : ℝ)) := by positivity
    linarith
  refine ⟨z n, ⟨hzI n, hn⟩, sub_ne_zero.mp hw0 |> fun h => h, ?_, ?_⟩
  · rw [dist_eq_norm]
    have h1 : ‖z n - x‖ ≤ ‖u‖ + ‖z n - x - u‖ := by
      have := norm_add_le u (z n - x - u)
      rw [show u + (z n - x - u) = z n - x by ring] at this; exact this
    rw [hun] at h1
    have : 1 / (m : ℝ) + 1 / (m : ℝ) ^ 2 ≤ 2 / m := by
      rw [show 2 / (m : ℝ) = 1 / m + 1 / m by ring]
      have : 1 / (m : ℝ) ^ 2 ≤ 1 / m := by
        rw [div_le_div_iff₀ (by positivity) (by positivity)]; nlinarith
      linarith
    have h2 : 2 / (m : ℝ) < ε := by
      rw [div_lt_iff₀ hmpos]; nlinarith
    linarith
  · have hdir := norm_div_norm_sub_le hu0 hw0
    have hub : u / (‖u‖ : ℂ) = e β := by
      rw [hun, hu]
      have : ((1 / (m : ℝ) : ℝ) : ℂ) = 1 / (m : ℂ) := by push_cast; rfl
      rw [this]
      have hmc : (m : ℂ) ≠ 0 := by exact_mod_cast hmpos.ne'
      field_simp
    rw [hub] at hdir
    refine lt_of_le_of_lt hdir ?_
    rw [hun, div_lt_iff₀ (by positivity)]
    have : 2 * ‖z n - x - u‖ < 2 * (1 / (m : ℝ) ^ 2) := by linarith
    have h3 : 2 * (1 / (m : ℝ) ^ 2) = ε * (1 / m) * (2 / (ε * m)) := by field_simp
    have h4 : 2 / (ε * (m : ℝ)) < 1 := by rw [div_lt_one (by positivity)]; linarith
    calc 2 * ‖z n - x - u‖ < 2 * (1 / (m : ℝ) ^ 2) := this
      _ = ε * (1 / m) * (2 / (ε * m)) := h3
      _ ≤ ε * (1 / m) := by
        have : 0 ≤ ε * (1 / (m : ℝ)) := by positivity
        nlinarith

/-! ## The germ dichotomy -/

/-- **The germ dichotomy**: at a ring point `r(θ)` of the domain, the germ of `ω(p)` on either side lies in one colour
class, or on an arc of `Γ` on `ω(p)` with constant sides (the strip beside a short germ avoids every other arc, which
meets `ω(p)` in finitely many points). -/
theorem germ_dichotomy {p : ℂ} {θ : ℝ} (hθ : ringPt p θ ∈ F.dom) (s : Side) :
    (∃ c, GermIn p θ s (F.region c)) ∨
      ∃ θ₁ θ₂ c c', F.IsRingArc p θ₁ θ₂ c c' ∧ GermIn p θ s (ringArc p θ₁ θ₂) := by
  sorry

/-! ## Interval cones in a simple map -/

section Simple

variable {F}

/-- **In a simple map each tile's cone at a point of its closure is one closed angular interval** (possibly a single
direction, a cusp, or every direction): near the point the tile's boundary is a Jordan curve with exactly two branches,
each a segment or a circular arc, and the tile is the sector between them. -/
theorem Simple.coneAt_eq_angleIcc (hS : F.Simple) {T : Set ℂ} (hT : F.IsTile T) {x : ℂ} (hxd : x ∈ F.dom)
    (hx : x ∈ closure T) :
    ∃ β₁ β₂, β₁ ≤ β₂ ∧ β₂ ≤ β₁ + 2 * π ∧ coneAt T x = angleIcc β₁ β₂ := by
  sorry

end Simple

end ArcMap

end HadwigerNelson.Plane

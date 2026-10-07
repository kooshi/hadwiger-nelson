import Proofs.HadwigerNelson.Plane.AeColouring

/-!
# Weak colourings of a set of the plane, and the plane's rigid motions (FS-124, the radius clause)

The definition under FS-124's first module (`data/fs124/claims-K1.md`): "A weak `k`-colouring of an open set `U` of
the plane is a measurable map `c` from `U` to `k` labels with `c(z) ≠ c(z + u)` for almost every pair of a point `z`
of `U` and a unit vector `u` with `z + u` in `U`; a rigid motion is an orientation-preserving isometry of the plane."

**One space carries both.** An oriented unit pair `(x, x + e θ)` is the image of the reference edge `(0, 1)` under
exactly one rigid motion, `z ↦ x + e θ * z`; so the pairs `(x, θ) ∈ ℂ × ℝ` of `Plane/UnitPairs` *are* the rigid
motions, and `volume ⊗ arcLength` — "almost every unit pair" — *is* "almost every rigid motion", each motion counted
once (its angle in `[0, 2π)`): Haar measure of the motion group in these coordinates.

* `rigidMotion (x, θ)` is `z ↦ x + e θ * z`: rotation about `0` by the angle `θ`, then translation by `x`
  (`dist_rigidMotion`: an isometry). That every orientation-preserving isometry of the plane is one, with its
  parameter determined up to `θ ↦ θ + 2π`, is the standard fact and is **not proved here**: no statement uses it —
  "almost every motion" and "there is a motion" are statements about parameters. `motionMul q h` is the parameter of
  the composite `rigidMotion q ∘ rigidMotion h`; multiplying on either side preserves Lebesgue measure on `ℂ × ℝ`
  (the group is unimodular). No group structure is declared: these two facts are all that is used.
* `monoPairSet U c ⊆ ℂ × ℝ` is the set of `(x, θ)` with `x` and `x + e θ` both in `U` and of one label — the motions
  carrying the reference edge into `U` onto a monochromatic pair (`mem_monoPairSet_iff_rigidMotion`).
  `AeProperOn U c` says it is `volume ⊗ arcLength`-null. It asks nothing of `c`: a null set is a set of outer
  measure `0`, and the label type is any type. A colouring proper at every unit pair of `U` is one
  (`aeProperOn_of_proper`).
* `IsWeakColouringOn U c`, for `c : ℂ → Fin k`, is `Measurable c ∧ AeProperOn U c`: the claim list's weak
  `k`-colouring of `U`. The colouring is a **total** function, read on `U` alone (`aeProperOn_congr`); the claim
  list's own form, a measurable map on the subtype `U`, is the same notion for measurable `U` and `k ≥ 1`
  (`exists_isWeakColouringOn_iff_subtype`). `U` is any set: the theorems that need it open say so.
* At the whole plane it is this library's `AeColouring` (`isWeakColouringOn_univ_iff`,
  `AeColouring.isWeakColouringOn`), hence the import's Borel weak colourings
  (`Plane/RadiusOutside`: `isWeakColouringOn_univ_iff_weakColoring`). **The release's own definition
  (`Outside.OAI158.WeakColoring`) asks only that the colouring be almost-everywhere measurable; this one asks that it
  be measurable.** The reason: it is then the object the release's transfer delivers (`∃ d, Measurable d ∧
  WeakColoring k d`) and the object this library's `AeColouring` is, so both bridges are equalities of notions with
  no choice of a representative; and the theorems that consume a weak colouring here (`Plane/Radius`) read only
  `AeProperOn`, so nothing is lost on the consuming side. That an almost-everywhere measurable weak colouring agrees
  almost everywhere with a measurable one that is still weak is true and is not a theorem of this library.
* **"Almost every rigid motion"** is stated twice: for `volume ⊗ arcLength` (each motion once), and for Lebesgue
  measure on all of `ℂ × ℝ` (every real angle; each motion countably often), which is the form the proofs move in. A
  set of parameters that reads the angle through `e θ` alone is null for one exactly when it is for the other
  (`prod_arcLength_eq_zero_iff_volume`). "Open" is open in `ℂ × ℝ`: the parametrization is a covering map of the
  motion group, so a set of motions is open exactly when its set of parameters is (a remark; the group and its
  topology are not declared).

**Inhabitant.** `exists_isWeakColouringOn_seven` (`Plane/Radius`): this library's seven-colouring R7, on every set.
Below: every colouring is proper at almost every unit pair of a small disc, which holds none; no colouring with one
colour is proper at almost every unit pair of a disc of radius `2`.
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Metric

variable {α : Type*} {k : ℕ}

/-! ## The definitions -/

/-- The rigid motion with parameter `q = (x, θ)`: `z ↦ x + e θ * z`. It carries the reference edge `(0, 1)` to the
unit pair `(x, x + e θ)`. -/
noncomputable def rigidMotion (q : ℂ × ℝ) (z : ℂ) : ℂ := q.1 + e q.2 * z

/-- The parameter of the composite motion: `rigidMotion (motionMul q h) = rigidMotion q ∘ rigidMotion h`
(`rigidMotion_motionMul`). -/
noncomputable def motionMul (q h : ℂ × ℝ) : ℂ × ℝ := (rigidMotion q h.1, q.2 + h.2)

/-- The monochromatic unit pairs of `c` inside `U`, as `(x, θ)` with `x` and `x + e θ` both in `U` and of one label. -/
def monoPairSet (U : Set ℂ) (c : ℂ → α) : Set (ℂ × ℝ) :=
  {q | q.1 ∈ U ∧ q.1 + e q.2 ∈ U ∧ c q.1 = c (q.1 + e q.2)}

/-- `c` is proper at almost every unit pair of `U`: the monochromatic unit pairs inside `U` are
`volume ⊗ arcLength`-null. No measurability is asked of `c` or of `U`. -/
def AeProperOn (U : Set ℂ) (c : ℂ → α) : Prop := (volume.prod arcLength) (monoPairSet U c) = 0

/-- **A weak `k`-colouring of `U`**: a measurable `c : ℂ → Fin k` proper at almost every unit pair of `U`. The values
of `c` off `U` are not read by the second clause (`aeProperOn_congr`). -/
structure IsWeakColouringOn (U : Set ℂ) (c : ℂ → Fin k) : Prop where
  /-- The colouring is measurable. -/
  measurable : Measurable c
  /-- It is proper at almost every unit pair of `U`. -/
  aeProperOn : AeProperOn U c

/-! ## Rigid motions -/

/-- The motion with parameter `(x, θ)` carries `0` to `x`. -/
@[simp] theorem rigidMotion_apply_zero (q : ℂ × ℝ) : rigidMotion q 0 = q.1 := by
  simp [rigidMotion]

/-- The motion with parameter `(x, θ)` carries `1` to `x + e θ`. -/
@[simp] theorem rigidMotion_apply_one (q : ℂ × ℝ) : rigidMotion q 1 = q.1 + e q.2 := by
  simp [rigidMotion]

/-- The parameter `0 = (0, 0)` is the identity. -/
@[simp] theorem rigidMotion_zero (z : ℂ) : rigidMotion 0 z = z := by
  simp [rigidMotion, e]

/-- The parameter `(t, 0)` is the translation by `t`. -/
theorem rigidMotion_translation (t z : ℂ) : rigidMotion (t, 0) z = t + z := by
  simp [rigidMotion, e]

/-- A rigid motion is an isometry. -/
theorem dist_rigidMotion (q : ℂ × ℝ) (z w : ℂ) : dist (rigidMotion q z) (rigidMotion q w) = dist z w := by
  rw [rigidMotion, rigidMotion, dist_add_left, dist_eq_norm, ← mul_sub, norm_mul, norm_e, one_mul, dist_eq_norm]

/-- The parametrization is jointly continuous in the parameter and the point. -/
theorem continuous_rigidMotion : Continuous fun p : (ℂ × ℝ) × ℂ => rigidMotion p.1 p.2 := by
  unfold rigidMotion
  exact (continuous_fst.comp continuous_fst).add
    ((continuous_e.comp (continuous_snd.comp continuous_fst)).mul continuous_snd)

/-- Each rigid motion is continuous (hence measurable). -/
theorem continuous_rigidMotion_apply (q : ℂ × ℝ) : Continuous (rigidMotion q) := by
  exact continuous_const.add (continuous_const.mul continuous_id)

/-- The motion with parameter `(x, θ + 2π)` is the motion with parameter `(x, θ)`. -/
theorem rigidMotion_add_two_pi (x : ℂ) (θ : ℝ) (z : ℂ) :
    rigidMotion (x, θ + 2 * Real.pi) z = rigidMotion (x, θ) z := by
  simp [rigidMotion, e_add_two_pi]

/-- `motionMul` is composition of motions. -/
theorem rigidMotion_motionMul (q h : ℂ × ℝ) (z : ℂ) :
    rigidMotion (motionMul q h) z = rigidMotion q (rigidMotion h z) := by
  simp only [rigidMotion, motionMul, e_add]; ring

/-- **Every unit pair is the image of the reference edge**: two points at distance `1` are `rigidMotion h 0` and
`rigidMotion h 1` for the parameter `h = (v, arg (w - v))`. -/
theorem exists_rigidMotion_edge {v w : ℂ} (h : dist v w = 1) :
    ∃ h : ℂ × ℝ, rigidMotion h 0 = v ∧ rigidMotion h 1 = w := by
  refine ⟨(v, Complex.arg (w - v)), by simp, ?_⟩
  have hn : ‖w - v‖ = 1 := by rw [← dist_eq_norm, dist_comm]; exact h
  have harg := Complex.norm_mul_exp_arg_mul_I (w - v)
  rw [hn, Complex.ofReal_one, one_mul] at harg
  rw [rigidMotion_apply_one, e, harg]
  ring

/-- **Right multiplication preserves Lebesgue measure on the parameters**: for each angle a translation of the
plane, and a translation of the angle. -/
theorem measurePreserving_motionMul_right (h : ℂ × ℝ) :
    MeasurePreserving (fun q : ℂ × ℝ => motionMul q h) volume volume := by
  -- over each angle a translation of the plane, and a translation of the angle: a skew product between two swaps
  have hsk : MeasurePreserving (fun p : ℝ × ℂ => (p.1 + h.2, p.2 + e p.1 * h.1))
      ((volume : Measure ℝ).prod (volume : Measure ℂ)) ((volume : Measure ℝ).prod (volume : Measure ℂ)) := by
    refine MeasurePreserving.skew_product (g := fun (θ : ℝ) (x : ℂ) => x + e θ * h.1)
      (measurePreserving_add_right volume h.2) ?_ (Filter.Eventually.of_forall fun θ => ?_)
    · exact measurable_snd.add ((continuous_e.measurable.comp measurable_fst).mul measurable_const)
    · exact (measurePreserving_add_right volume (e θ * h.1)).map_eq
  have h1 := (Measure.measurePreserving_swap (μ := (volume : Measure ℝ)) (ν := (volume : Measure ℂ))).comp
    (hsk.comp (Measure.measurePreserving_swap (μ := (volume : Measure ℂ)) (ν := (volume : Measure ℝ))))
  have hfun : (fun q : ℂ × ℝ => motionMul q h) =
      Prod.swap ∘ (fun p : ℝ × ℂ => (p.1 + h.2, p.2 + e p.1 * h.1)) ∘ Prod.swap := by
    funext q; simp [motionMul, rigidMotion]
  rw [hfun]
  exact h1

/-- **Left multiplication preserves Lebesgue measure on the parameters**: a rigid motion of the plane, and a
translation of the angle. -/
theorem measurePreserving_motionMul_left (q : ℂ × ℝ) :
    MeasurePreserving (fun h : ℂ × ℝ => motionMul q h) volume volume := by
  -- a rigid motion of the plane (a rotation, then a translation), and a translation of the angle
  have hrot : MeasurePreserving (fun z : ℂ => e q.2 * z) volume volume := by
    -- multiplication by the unit `e θ`, as a real-linear isometry of the plane
    have hne : e q.2 ≠ 0 := Complex.exp_ne_zero _
    let L : ℂ ≃ₗᵢ[ℝ] ℂ :=
      ⟨(LinearEquiv.smulOfUnit (Units.mk0 (e q.2) hne)).restrictScalars ℝ, fun z => by
        show ‖e q.2 * z‖ = ‖z‖
        rw [norm_mul, norm_e, one_mul]⟩
    exact L.measurePreserving
  have h1 : MeasurePreserving (rigidMotion q) volume volume :=
    (measurePreserving_add_left volume q.1).comp hrot
  have h2 : MeasurePreserving (fun θ : ℝ => q.2 + θ) volume volume := measurePreserving_add_left volume q.2
  rw [Measure.volume_eq_prod]
  exact h1.prod h2

/-- `volume ⊗ arcLength` is Lebesgue measure on `ℂ × ℝ` restricted to the angles in `[0, 2π)`. -/
theorem prod_arcLength_eq_restrict :
    (volume : Measure ℂ).prod arcLength = (volume : Measure (ℂ × ℝ)).restrict (univ ×ˢ Ico 0 (2 * Real.pi)) := by
  rw [arcLength, Measure.volume_eq_prod, ← Measure.prod_restrict, Measure.restrict_univ]

/-- A set of pairs `(x, θ)` that reads the angle through the unit vector `e θ` alone is null for
`volume ⊗ arcLength` (angles in `[0, 2π)`) exactly when it is null for Lebesgue measure on `ℂ × ℝ` (all real
angles): it is the union of its integer translates by `2π` in the angle. -/
theorem prod_arcLength_eq_zero_iff_volume {S : Set (ℂ × ℝ)}
    (hS : ∀ (x : ℂ) (θ θ' : ℝ), e θ = e θ' → (x, θ) ∈ S → (x, θ') ∈ S) :
    ((volume : Measure ℂ).prod arcLength) S = 0 ↔ (volume : Measure (ℂ × ℝ)) S = 0 := by
  have hI : MeasurableSet ((univ : Set ℂ) ×ˢ Ico (0 : ℝ) (2 * Real.pi)) := MeasurableSet.univ.prod measurableSet_Ico
  rw [prod_arcLength_eq_restrict, Measure.restrict_apply' hI]
  refine ⟨fun h0 => ?_, fun h0 => measure_mono_null inter_subset_left h0⟩
  have hp : (0 : ℝ) < 2 * Real.pi := by positivity
  -- `S` is covered by the integer translates, in the angle, of its part over `[0, 2π)`
  have hcov : S ⊆ ⋃ n : ℤ, (fun q : ℂ × ℝ => (q.1, q.2 + (-(n * (2 * Real.pi))))) ⁻¹'
      (S ∩ (univ : Set ℂ) ×ˢ Ico (0 : ℝ) (2 * Real.pi)) := by
    rintro ⟨x, θ⟩ hq
    refine mem_iUnion.2 ⟨⌊θ / (2 * Real.pi)⌋, ?_, mem_univ _, ?_, ?_⟩
    · refine hS x θ _ ?_ hq
      have h := (Function.Periodic.int_mul (fun θ : ℝ => e_add_two_pi θ) (-⌊θ / (2 * Real.pi)⌋)) θ
      simpa [mul_comm] using h.symm
    · have := Int.floor_le (θ / (2 * Real.pi))
      rw [le_div_iff₀ hp] at this
      show 0 ≤ θ + -(↑⌊θ / (2 * Real.pi)⌋ * (2 * Real.pi)); linarith
    · have := Int.lt_floor_add_one (θ / (2 * Real.pi))
      rw [div_lt_iff₀ hp] at this
      show θ + -(↑⌊θ / (2 * Real.pi)⌋ * (2 * Real.pi)) < 2 * Real.pi; linarith
  refine measure_mono_null hcov (measure_iUnion_null fun n => ?_)
  have hmp : MeasurePreserving (fun q : ℂ × ℝ => (q.1, q.2 + (-(n * (2 * Real.pi)))))
      (volume : Measure (ℂ × ℝ)) volume := by
    rw [Measure.volume_eq_prod]
    exact (MeasurePreserving.id volume).prod (measurePreserving_add_right volume _)
  exact hmp.quasiMeasurePreserving.preimage_null h0

/-! ## Proper at almost every unit pair -/

/-- **The monochromatic pairs are motions of the reference edge**: `q` is one exactly when `rigidMotion q` carries
`0` and `1` into `U` and onto one label. -/
theorem mem_monoPairSet_iff_rigidMotion {U : Set ℂ} {c : ℂ → α} {q : ℂ × ℝ} :
    q ∈ monoPairSet U c ↔
      rigidMotion q 0 ∈ U ∧ rigidMotion q 1 ∈ U ∧ c (rigidMotion q 0) = c (rigidMotion q 1) := by
  simp [monoPairSet, rigidMotion]

/-- The monochromatic unit pairs inside `U` are the unit pairs of the classes cut down to `U`. -/
theorem monoPairSet_eq_iUnion (U : Set ℂ) (c : ℂ → α) :
    monoPairSet U c = ⋃ j, unitPairSet (U ∩ c ⁻¹' {j}) := by
  ext ⟨x, θ⟩
  simp only [monoPairSet, unitPairSet, mem_setOf_eq, mem_iUnion, mem_inter_iff, mem_preimage, mem_singleton_iff]
  exact ⟨fun ⟨hx, hy, h⟩ => ⟨c x, ⟨hx, rfl⟩, hy, h.symm⟩,
    fun ⟨j, ⟨hx, h1⟩, hy, h2⟩ => ⟨hx, hy, h1.trans h2.symm⟩⟩

/-- The monochromatic pairs read the angle through the unit vector `e θ` alone. -/
theorem mem_monoPairSet_of_e_eq {U : Set ℂ} {c : ℂ → α} (x : ℂ) (θ θ' : ℝ) (h : e θ = e θ')
    (hq : (x, θ) ∈ monoPairSet U c) : (x, θ') ∈ monoPairSet U c := by
  simp only [monoPairSet, mem_setOf_eq] at hq ⊢
  rwa [← h]

/-- **In the library's primitive**: proper at almost every unit pair of `U` exactly when each class, cut down to
`U`, has null unit pairs. -/
theorem aeProperOn_iff_unitPairsNull [Countable α] {U : Set ℂ} {c : ℂ → α} :
    AeProperOn U c ↔ ∀ j, UnitPairsNull (U ∩ c ⁻¹' {j}) := by
  rw [AeProperOn, monoPairSet_eq_iUnion, measure_iUnion_null_iff]
  rfl

/-- **In the claim list's words**: `c z ≠ c (z + u)` for almost every pair of a point `z` of `U` and a unit vector
`u = e θ` with `z + u` in `U`. -/
theorem aeProperOn_iff_ae {U : Set ℂ} {c : ℂ → α} :
    AeProperOn U c ↔
      ∀ᵐ q ∂(volume : Measure ℂ).prod arcLength, q.1 ∈ U → q.1 + e q.2 ∈ U → c q.1 ≠ c (q.1 + e q.2) := by
  have hset : {q : ℂ × ℝ | ¬ (q.1 ∈ U → q.1 + e q.2 ∈ U → c q.1 ≠ c (q.1 + e q.2))} = monoPairSet U c := by
    ext q
    simp only [monoPairSet, mem_setOf_eq, Classical.not_imp, not_not]
  rw [AeProperOn, ae_iff, hset]

/-- **Over all real angles**: `AeProperOn` is nullness of the monochromatic pairs for Lebesgue measure on `ℂ × ℝ`. -/
theorem aeProperOn_iff_volume {U : Set ℂ} {c : ℂ → α} :
    AeProperOn U c ↔ (volume : Measure (ℂ × ℝ)) (monoPairSet U c) = 0 := by
  exact prod_arcLength_eq_zero_iff_volume mem_monoPairSet_of_e_eq

/-- Monochromatic pairs are monotone in the set. -/
theorem monoPairSet_mono {U V : Set ℂ} (h : V ⊆ U) (c : ℂ → α) : monoPairSet V c ⊆ monoPairSet U c := by
  exact fun _ hq => ⟨h hq.1, h hq.2.1, hq.2.2⟩

/-- Proper at almost every unit pair of `U`, hence of every subset of `U`. -/
theorem AeProperOn.mono {U V : Set ℂ} {c : ℂ → α} (hc : AeProperOn U c) (h : V ⊆ U) : AeProperOn V c := by
  exact measure_mono_null (monoPairSet_mono h c) hc

/-- The condition reads `c` on `U` alone. -/
theorem aeProperOn_congr {U : Set ℂ} {c c' : ℂ → α} (h : EqOn c c' U) : AeProperOn U c ↔ AeProperOn U c' := by
  have hset : monoPairSet U c = monoPairSet U c' := by
    ext q
    simp only [monoPairSet, mem_setOf_eq]
    constructor
    · rintro ⟨h1, h2, h3⟩
      exact ⟨h1, h2, by rw [← h h1, ← h h2]; exact h3⟩
    · rintro ⟨h1, h2, h3⟩
      exact ⟨h1, h2, by rw [h h1, h h2]; exact h3⟩
  rw [AeProperOn, AeProperOn, hset]

/-- A colouring proper at **every** unit pair of `U` is proper at almost every one — with no measurability. -/
theorem aeProperOn_of_proper {U : Set ℂ} {c : ℂ → α} (h : ∀ x ∈ U, ∀ y ∈ U, dist x y = 1 → c x ≠ c y) :
    AeProperOn U c := by
  have hempty : monoPairSet U c = ∅ := by
    ext ⟨x, θ⟩
    simp only [monoPairSet, mem_setOf_eq, mem_empty_iff_false, iff_false, not_and]
    intro hx hy
    exact h x hx _ hy (by simp [dist_eq_norm])
  rw [AeProperOn, hempty, measure_empty]

/-- **Proper off a null set**: if `c` separates every two points of `U` at distance `1` that both lie off a null set
`N` (the arcs of a map, a grid), it is proper at almost every unit pair of `U` — with no measurability of `c`, `U` or
`N`. The pairs with an end in `N` are null: `N ×ˢ univ`, and its preimage under `q ↦ motionMul q (1, 0)`. -/
theorem aeProperOn_of_proper_off_null {U N : Set ℂ} {c : ℂ → α} (hN : volume N = 0)
    (h : ∀ x ∈ U, ∀ y ∈ U, dist x y = 1 → x ∉ N → y ∉ N → c x ≠ c y) : AeProperOn U c := by
  rw [aeProperOn_iff_volume]
  -- a monochromatic unit pair of `U` has an end in `N`: its first, or its second, which is the first of its
  -- image under right multiplication by the motion `z ↦ 1 + z`
  have hNu : (volume : Measure (ℂ × ℝ)) (N ×ˢ (univ : Set ℝ)) = 0 := by
    rw [Measure.volume_eq_prod, Measure.prod_prod, hN, zero_mul]
  have hpre := (measurePreserving_motionMul_right (1, 0)).quasiMeasurePreserving.preimage_null hNu
  refine measure_mono_null (fun q hq => ?_) (measure_union_null hNu hpre)
  obtain ⟨hx, hy, hcq⟩ := hq
  by_contra hcon
  rw [mem_union, not_or] at hcon
  refine h _ hx _ hy (by simp [dist_eq_norm]) (fun hxN => hcon.1 ⟨hxN, mem_univ _⟩) (fun hyN => hcon.2 ?_) hcq
  show motionMul q (1, 0) ∈ N ×ˢ (univ : Set ℝ)
  exact ⟨by simpa [motionMul, rigidMotion] using hyN, mem_univ _⟩

/-- **Rigid motions carry the condition**: if `c` is proper at almost every unit pair of `U`, then `c ∘ g` is at
almost every unit pair of `g⁻¹ U`. (One direction is stated; the motions form a group, and for a translation the
equivalence is `exists_isWeakColouringOn_ball_iff`.) -/
theorem AeProperOn.comp_rigidMotion {U : Set ℂ} {c : ℂ → α} (hc : AeProperOn U c) (g : ℂ × ℝ) :
    AeProperOn (rigidMotion g ⁻¹' U) (c ∘ rigidMotion g) := by
  rw [aeProperOn_iff_volume] at hc ⊢
  have hset : monoPairSet (rigidMotion g ⁻¹' U) (c ∘ rigidMotion g) =
      (fun h : ℂ × ℝ => motionMul g h) ⁻¹' monoPairSet U c := by
    ext q
    simp only [mem_preimage, mem_monoPairSet_iff_rigidMotion, rigidMotion_motionMul, Function.comp_apply]
  rw [hset]
  exact (measurePreserving_motionMul_left g).quasiMeasurePreserving.preimage_null hc

/-! ## Weak colourings -/

/-- **At the whole plane a weak colouring is this library's `AeColouring`**: measurable, each class with null unit
pairs. -/
theorem isWeakColouringOn_univ_iff {c : ℂ → Fin k} :
    IsWeakColouringOn univ c ↔ Measurable c ∧ ∀ j, UnitPairsNull (c ⁻¹' {j}) := by
  constructor
  · rintro ⟨hm, hp⟩
    refine ⟨hm, fun j => ?_⟩
    have hj := aeProperOn_iff_unitPairsNull.mp hp j
    rwa [univ_inter] at hj
  · rintro ⟨hm, hp⟩
    refine ⟨hm, aeProperOn_iff_unitPairsNull.mpr fun j => ?_⟩
    rw [univ_inter]
    exact hp j

/-- An `AeColouring` of the plane is a weak colouring of every set. -/
theorem AeColouring.isWeakColouringOn (a : AeColouring k) (U : Set ℂ) : IsWeakColouringOn U a.col := by
  exact ⟨a.measurable, aeProperOn_iff_unitPairsNull.mpr fun j => (a.unitPairsNull j).mono inter_subset_right⟩

/-- A weak colouring of the whole plane is the colouring of an `AeColouring`. -/
theorem IsWeakColouringOn.exists_aeColouring {c : ℂ → Fin k} (hc : IsWeakColouringOn univ c) :
    ∃ a : AeColouring k, a.col = c := by
  exact ⟨⟨c, hc.measurable, (isWeakColouringOn_univ_iff.mp hc).2⟩, rfl⟩

/-- A weak colouring of `U` is one of every subset of `U`. -/
theorem IsWeakColouringOn.mono {U V : Set ℂ} {c : ℂ → Fin k} (hc : IsWeakColouringOn U c) (h : V ⊆ U) :
    IsWeakColouringOn V c := by
  exact ⟨hc.measurable, hc.aeProperOn.mono h⟩

/-- Rigid motions carry weak colourings: `c ∘ g` is a weak colouring of `g⁻¹ U`. -/
theorem IsWeakColouringOn.comp_rigidMotion {U : Set ℂ} {c : ℂ → Fin k} (hc : IsWeakColouringOn U c) (g : ℂ × ℝ) :
    IsWeakColouringOn (rigidMotion g ⁻¹' U) (c ∘ rigidMotion g) := by
  exact ⟨hc.measurable.comp (continuous_rigidMotion_apply g).measurable, hc.aeProperOn.comp_rigidMotion g⟩

/-- **Discs at any centre**: the disc of radius `R` about `p` has a weak `k`-colouring exactly when the disc about
`0` has one (translate). -/
theorem exists_isWeakColouringOn_ball_iff (p : ℂ) (R : ℝ) :
    (∃ c : ℂ → Fin k, IsWeakColouringOn (ball p R) c) ↔ ∃ c : ℂ → Fin k, IsWeakColouringOn (ball 0 R) c := by
  have h1 : rigidMotion (p, 0) ⁻¹' ball p R = ball 0 R := by
    ext z
    simp [rigidMotion_translation, dist_eq_norm]
  have h2 : rigidMotion (-p, 0) ⁻¹' ball 0 R = ball p R := by
    ext z
    simp [rigidMotion_translation, dist_eq_norm, neg_add_eq_sub]
  constructor
  · rintro ⟨c, hc⟩
    exact ⟨_, h1 ▸ hc.comp_rigidMotion (p, 0)⟩
  · rintro ⟨c, hc⟩
    exact ⟨_, h2 ▸ hc.comp_rigidMotion (-p, 0)⟩

/-- **The claim list's own form**: for a measurable `U` and `k ≥ 1`, a weak `k`-colouring of `U` exists exactly when
there is a measurable map from the subtype `U` to `Fin k` with different labels at almost every pair of a point `z`
of `U` and a direction `θ` with `z + e θ` in `U`. (`k ≥ 1` supplies the label off `U`; at `k = 0` and `U = ∅` the
right side holds and the left does not.) -/
theorem exists_isWeakColouringOn_iff_subtype [NeZero k] {U : Set ℂ} (hU : MeasurableSet U) :
    (∃ c : ℂ → Fin k, IsWeakColouringOn U c) ↔
      ∃ c : U → Fin k, Measurable c ∧ ∀ᵐ q ∂(volume : Measure ℂ).prod arcLength,
        ∀ (h₁ : q.1 ∈ U) (h₂ : q.1 + e q.2 ∈ U), c ⟨q.1, h₁⟩ ≠ c ⟨q.1 + e q.2, h₂⟩ := by
  classical
  constructor
  · rintro ⟨c, hc⟩
    refine ⟨fun z => c z, hc.measurable.comp measurable_subtype_coe, ?_⟩
    filter_upwards [aeProperOn_iff_ae.mp hc.aeProperOn] with q hq h₁ h₂ using hq h₁ h₂
  · rintro ⟨c, hm, hae⟩
    refine ⟨fun z => if h : z ∈ U then c ⟨z, h⟩ else 0, hm.dite measurable_const hU, aeProperOn_iff_ae.mpr ?_⟩
    filter_upwards [hae] with q hq h₁ h₂
    rw [dif_pos h₁, dif_pos h₂]
    exact hq h₁ h₂

/-! ## Spec examples (each fails if its definition drifts) -/

/-- A disc of radius `1/2` holds no unit pair: every colouring is proper at almost every unit pair of it. -/
example (c : ℂ → α) : AeProperOn (ball (0 : ℂ) (1 / 2)) c := by
  have hempty : monoPairSet (ball (0 : ℂ) (1 / 2)) c = ∅ := by
    ext ⟨x, θ⟩
    simp only [monoPairSet, mem_setOf_eq, mem_ball, dist_zero_right, mem_empty_iff_false, iff_false, not_and]
    intro hx hy
    have h1 : ‖e θ‖ ≤ ‖x + e θ‖ + ‖x‖ := by
      calc ‖e θ‖ = ‖(x + e θ) - x‖ := by rw [add_sub_cancel_left]
        _ ≤ ‖x + e θ‖ + ‖x‖ := norm_sub_le _ _
    rw [norm_e] at h1
    linarith
  rw [AeProperOn, hempty, measure_empty]

/-- **Adversary**: one colour is not proper at almost every unit pair of a disc of radius `2` — and it is on the
disc of radius `1/2` (above), so the condition is read inside `U` only. -/
example : ¬ AeProperOn (ball (0 : ℂ) 2) (fun _ => (0 : Fin 1)) := by
  intro h
  refine not_unitPairsNull_ball_two (measure_mono_null ?_ h)
  rintro ⟨x, θ⟩ ⟨hx, hy⟩
  exact ⟨hx, hy, rfl⟩

/-- The parameter `(1, π / 2)` is the quarter turn followed by the shift by `1`: it carries `1` to `1 + i`. -/
example : rigidMotion (1, Real.pi / 2) 1 = 1 + I := by
  rw [rigidMotion, e_eq, Real.cos_pi_div_two, Real.sin_pi_div_two]; simp

/-- Composition of parameters: a quarter turn twice is the half turn. -/
example : motionMul (0, Real.pi / 2) (0, Real.pi / 2) = (0, Real.pi) := by
  simp [motionMul, rigidMotion]

end HadwigerNelson.Plane

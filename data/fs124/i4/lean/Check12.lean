import Proofs.HadwigerNelson.Plane.ClosePair

/-!
# The geometry of the close-pair witnesses: three discs, a decomposition moved by a rigid motion (FS-124, job FS124-I4)

What `Plane/ClosePairModel` and `Plane/SectorPoint` build their inhabitants from. Nothing here is a claim of
`data/fs124/claims-K2.md`; every statement is a tool for a colouring given by formula.

**The frame of all three witnesses**: `x = 0`, `w = 1`, and `y = T 0` for a rigid motion `T z = y + u z` (`‖u‖ = 1`);
the set is `threeDisc y`, three discs of radius `1/4` about `0`, `1` and `y`. A disc of radius `1/4` holds no unit pair,
so a colouring of the set is proper as soon as it separates the unit pairs between two discs
(`threeDisc_aeProperOn`). The colouring is glued from three (`threeDiscCol`): a three-label colouring about `0` with
the labels `0, 1, 2` (`labLo`), a three-label colouring about `0` moved to `y` by `T` with the labels `3, 4, 5`
(`labHi`), and any colouring about `1`. The two decompositions at `0`, the first as it stands and the second moved by
`T` (`ThreePiece.transport`), are a close complementary pair of it (`threeDiscPair`), and the glued colouring is a weak
colouring as soon as the disc about `1` is separated from the other two (`isWeakColouringOn_threeDiscCol`).

* `planeMotion a u hu` — the motion `z ↦ a + u z` as a homeomorphism: an isometry (`dist_planeMotion`) whose inverse
  preserves Lebesgue measure (`measurePreserving_planeMotion_symm`).
* `ThreePiece.transport` — a decomposition moved by a measure-preserving homeomorphism and relabelled injectively. Its
  edges are the images of the edges (`transport_edge`), so arc edges are kept (`HasArcEdges.transport`); under an
  isometry the kinds of its pieces at the image of a point are the kinds at the point (`transport_separatesAt_iff`,
  `transport_oneOfEach_iff`).
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Metric Topology

variable {α β : Type*} {k : ℕ}

/-! ## Rigid motions of the plane, as homeomorphisms -/

/-- The rigid motion `z ↦ a + u z` of the plane, for a unit complex number `u`, as a homeomorphism: the rotation
`z ↦ u z` about `0`, then the translation by `a`. -/
noncomputable def planeMotion (a u : ℂ) (hu : ‖u‖ = 1) : ℂ ≃ₜ ℂ :=
  (Homeomorph.mulLeft₀ u (norm_ne_zero_iff.mp (by rw [hu]; exact one_ne_zero))).trans (Homeomorph.addLeft a)

/-- The motion, applied. -/
@[simp] theorem planeMotion_apply (a u : ℂ) (hu : ‖u‖ = 1) (z : ℂ) : planeMotion a u hu z = a + u * z := rfl

/-- The inverse motion, applied. -/
theorem planeMotion_symm_apply (a u : ℂ) (hu : ‖u‖ = 1) (z : ℂ) : (planeMotion a u hu).symm z = u⁻¹ * (-a + z) := rfl

/-- A rigid motion is an isometry. -/
theorem dist_planeMotion {a u : ℂ} (hu : ‖u‖ = 1) (z z' : ℂ) :
    dist (planeMotion a u hu z) (planeMotion a u hu z') = dist z z' := by
  rw [planeMotion_apply, planeMotion_apply, dist_eq_norm, dist_eq_norm, add_sub_add_left_eq_sub, ← mul_sub, norm_mul,
    hu, one_mul]

/-- The inverse of a rigid motion is an isometry. -/
theorem dist_planeMotion_symm {a u : ℂ} (hu : ‖u‖ = 1) (z z' : ℂ) :
    dist ((planeMotion a u hu).symm z) ((planeMotion a u hu).symm z') = dist z z' := by
  rw [← dist_planeMotion hu, Homeomorph.apply_symm_apply, Homeomorph.apply_symm_apply]

/-- The inverse of a rigid motion preserves Lebesgue measure: a translation, then multiplication by a unit complex
number, which is a real-linear isometry of the plane. -/
theorem measurePreserving_planeMotion_symm {a u : ℂ} (hu : ‖u‖ = 1) :
    MeasurePreserving (planeMotion a u hu).symm volume volume := by
  have hne : u⁻¹ ≠ 0 := inv_ne_zero (norm_ne_zero_iff.mp (by rw [hu]; exact one_ne_zero))
  let L : ℂ ≃ₗᵢ[ℝ] ℂ :=
    ⟨(LinearEquiv.smulOfUnit (Units.mk0 u⁻¹ hne)).restrictScalars ℝ, fun z => by
      show ‖u⁻¹ * z‖ = ‖z‖
      rw [norm_mul, norm_inv, hu, inv_one, one_mul]⟩
  exact L.measurePreserving.comp (measurePreserving_add_left volume (-a))

/-! ## A decomposition moved by a measure-preserving homeomorphism -/

namespace ThreePiece

variable {V U : Set ℂ} {c₀ : ℂ → β} {c : ℂ → α} {p x : ℂ}

/-- **A decomposition moved and relabelled**: the images of the neighbourhood and of the pieces of a decomposition at
`p` under a homeomorphism `T` of the plane whose inverse preserves Lebesgue measure, with the labels renamed by an
injective `f`, are a decomposition at `T p` of any colouring that is `f ∘ c₀ ∘ T⁻¹` on the image of the
neighbourhood. -/
def transport (D : ThreePiece V c₀ p) (T : ℂ ≃ₜ ℂ) (hT : MeasurePreserving T.symm volume volume) (f : β → α)
    (hf : Function.Injective f) (hx : T p = x) (hU : T '' D.nbhd ⊆ U) (hc : ∀ z ∈ D.nbhd, c (T z) = f (c₀ z)) :
    ThreePiece U c x where
  nbhd := T '' D.nbhd
  piece i := T '' D.piece i
  label i := f (D.label i)
  nbhd_mem := hx ▸ T.isOpenMap.image_mem_nhds D.nbhd_mem
  nbhd_subset := hU
  piece_subset i := image_mono (D.piece_subset i)
  isOpen_piece i := T.isOpen_image.mpr (D.isOpen_piece i)
  isPreconnected_piece i := (D.isPreconnected_piece i).image T T.continuous.continuousOn
  mem_closure_piece i := by
    rw [← hx, ← T.image_closure]
    exact mem_image_of_mem T (D.mem_closure_piece i)
  ae_label i := by
    filter_upwards [hT.quasiMeasurePreserving.ae (D.ae_label i)] with z hz hzm
    obtain ⟨q, hq, rfl⟩ := hzm
    rw [T.symm_apply_apply] at hz
    rw [hc q (D.piece_subset i hq), hz hq]
  label_injective := hf.comp D.label_injective
  null_diff := by
    refine measure_mono_null ?_ (hT.quasiMeasurePreserving.preimage_null D.null_diff)
    rintro _ ⟨⟨n, hn, rfl⟩, hz⟩
    show T.symm (T n) ∈ D.nbhd \ ⋃ i, D.piece i
    rw [T.symm_apply_apply]
    refine ⟨hn, fun hmem => hz ?_⟩
    obtain ⟨i, hi⟩ := mem_iUnion.mp hmem
    exact mem_iUnion.mpr ⟨i, n, hi, rfl⟩

variable (D : ThreePiece V c₀ p) (T : ℂ ≃ₜ ℂ) (hT : MeasurePreserving T.symm volume volume) (f : β → α)
  (hf : Function.Injective f) (hx : T p = x) (hU : T '' D.nbhd ⊆ U) (hc : ∀ z ∈ D.nbhd, c (T z) = f (c₀ z))

/-- The pieces of the moved decomposition are the images of the pieces. -/
@[simp] theorem transport_piece (i : Fin 3) : (D.transport T hT f hf hx hU hc).piece i = T '' D.piece i := rfl

/-- The labels of the moved decomposition are the renamed labels. -/
@[simp] theorem transport_label (i : Fin 3) : (D.transport T hT f hf hx hU hc).label i = f (D.label i) := rfl

/-- The neighbourhood of the moved decomposition is the image of the neighbourhood. -/
@[simp] theorem transport_nbhd : (D.transport T hT f hf hx hU hc).nbhd = T '' D.nbhd := rfl

end ThreePiece

/-! ## Two decompositions, the pieces of one the images of the pieces of the other -/

/-- The image of a set under an isometry is inner at the image of a point exactly when the set is inner at the
point. -/
theorem innerAt_image_iff {T : ℂ ≃ₜ ℂ} (hiso : ∀ a b, dist (T a) (T b) = dist a b) {P : Set ℂ} {w₀ w : ℂ}
    (hw : T w₀ = w) : InnerAt (T '' P) w ↔ InnerAt P w₀ := by
  subst hw
  constructor
  · intro h q hq
    have := h (mem_image_of_mem T hq)
    rwa [mem_closedBall, hiso] at this
  · rintro h _ ⟨q, hq, rfl⟩
    rw [mem_closedBall, hiso]
    exact h hq

/-- The image of a set under an isometry is outer at the image of a point exactly when the set is outer at the
point. -/
theorem outerAt_image_iff {T : ℂ ≃ₜ ℂ} (hiso : ∀ a b, dist (T a) (T b) = dist a b) {P : Set ℂ} {w₀ w : ℂ}
    (hw : T w₀ = w) : OuterAt (T '' P) w ↔ OuterAt P w₀ := by
  subst hw
  constructor
  · intro h
    refine Set.disjoint_left.mpr fun q hq hb => Set.disjoint_left.mp h (mem_image_of_mem T hq) ?_
    rw [mem_ball, hiso]
    exact hb
  · intro h
    refine Set.disjoint_left.mpr ?_
    rintro _ ⟨q, hq, rfl⟩ hb
    rw [mem_ball, hiso] at hb
    exact Set.disjoint_left.mp h hq hb

namespace ThreePiece

variable {V U : Set ℂ} {c₀ : ℂ → β} {c : ℂ → α} {p x : ℂ} {D : ThreePiece V c₀ p} {D' : ThreePiece U c x}
  {T : ℂ ≃ₜ ℂ}

/-- If the pieces of `D'` are the images of the pieces of `D` under an isometry, `D'` separates at the image of a
point exactly when `D` separates at the point. -/
theorem separatesAt_iff_of_image (hiso : ∀ a b, dist (T a) (T b) = dist a b)
    (hp : ∀ i, D'.piece i = T '' D.piece i) {w₀ w : ℂ} (hw : T w₀ = w) : D'.SeparatesAt w ↔ D.SeparatesAt w₀ := by
  simp only [SeparatesAt, hp, innerAt_image_iff hiso hw, outerAt_image_iff hiso hw]

/-- If the pieces of `D'` are the images of the pieces of `D` under an isometry, `D'` has one piece of each kind at
the image of a point, named by a permutation, exactly when `D` has at the point, named by the same permutation. -/
theorem oneOfEach_iff_of_image (hiso : ∀ a b, dist (T a) (T b) = dist a b)
    (hp : ∀ i, D'.piece i = T '' D.piece i) {w₀ w : ℂ} (hw : T w₀ = w) (σ : Equiv.Perm (Fin 3)) :
    D'.OneOfEach w σ ↔ D.OneOfEach w₀ σ := by
  simp only [OneOfEach, CrossingAt, hp, innerAt_image_iff hiso hw, outerAt_image_iff hiso hw]

/-- If the pieces and the neighbourhood of `D'` are the images of those of `D` under a homeomorphism, the edges of
`D'` are the images of the edges of `D`. -/
theorem edge_eq_image (hp : ∀ i, D'.piece i = T '' D.piece i) (hn : D'.nbhd = T '' D.nbhd) (i j : Fin 3) :
    D'.edge i j = T '' D.edge i j := by
  rw [edge, edge, hp i, hp j, hn, image_inter T.injective, image_inter T.injective, T.image_closure,
    T.image_closure]

/-- If the pieces and the neighbourhood of `D'` are the images of those of `D` under a homeomorphism that carries
the point of `D` to the point of `D'`, and `D` has arc edges, so has `D'`: the images of the arcs. -/
theorem HasArcEdges.of_image (h : D.HasArcEdges) (hp : ∀ i, D'.piece i = T '' D.piece i)
    (hn : D'.nbhd = T '' D.nbhd) (hx : T p = x) : D'.HasArcEdges := by
  intro i j hij
  obtain ⟨γ, hinj, hγ0, hγ⟩ := h i j hij
  refine ⟨⟨fun t => T (γ t), T.continuous.comp γ.continuous⟩, T.injective.comp hinj, ?_, ?_⟩
  · show T (γ 0) = x
    rw [hγ0, hx]
  · rw [edge_eq_image hp hn]
    rintro _ ⟨t, rfl⟩
    exact mem_image_of_mem T (hγ ⟨t, rfl⟩)

end ThreePiece

/-! ## Three discs, and a colouring glued on them -/

/-- The labels `0, 1, 2` among at least six: those of the member at `0`. -/
def labLo (hk : 6 ≤ k) (i : Fin 3) : Fin k := ⟨i, lt_of_lt_of_le i.2 (le_trans (by norm_num) hk)⟩

/-- The labels `3, 4, 5` among at least six: those of the member at `y`. -/
def labHi (hk : 6 ≤ k) (i : Fin 3) : Fin k := ⟨i + 3, lt_of_lt_of_le (Nat.add_lt_add_right i.2 3) hk⟩

/-- The low labels are distinct. -/
theorem labLo_injective (hk : 6 ≤ k) : Function.Injective (labLo hk) := by
  intro i j h
  exact Fin.ext (Fin.mk.inj h)

/-- The high labels are distinct. -/
theorem labHi_injective (hk : 6 ≤ k) : Function.Injective (labHi hk) := by
  intro i j h
  exact Fin.ext (Nat.add_right_cancel (Fin.mk.inj h))

/-- No low label is a high label. -/
theorem labLo_ne_labHi (hk : 6 ≤ k) (i j : Fin 3) : labLo hk i ≠ labHi hk j := by
  intro h
  have h1 : (i : ℕ) = j + 3 := Fin.mk.inj h
  have h2 := i.2
  omega

/-- The set of the witnesses: three discs of radius `1/4`, about `0`, `1` and `y`. -/
def threeDisc (y : ℂ) : Set ℂ := ball 0 (1 / 4) ∪ ball 1 (1 / 4) ∪ ball y (1 / 4)

/-- The set is open. -/
theorem isOpen_threeDisc (y : ℂ) : IsOpen (threeDisc y) :=
  (isOpen_ball.union isOpen_ball).union isOpen_ball

/-- The point `1` is in the set. -/
theorem one_mem_threeDisc (y : ℂ) : (1 : ℂ) ∈ threeDisc y :=
  Or.inl (Or.inr (mem_ball_self (by norm_num)))

/-- A colouring glued from three: `cx` on the disc about `0`, `cy` on the disc about `y`, `cw` elsewhere. -/
noncomputable def threeDiscCol (y : ℂ) (cx cy cw : ℂ → α) (z : ℂ) : α :=
  if dist z 0 < 1 / 4 then cx z else if dist z y < 1 / 4 then cy z else cw z

/-- The glued colouring on the disc about `0`. -/
theorem threeDiscCol_of_mem_zero (y : ℂ) (cx cy cw : ℂ → α) {z : ℂ} (h : z ∈ ball (0 : ℂ) (1 / 4)) :
    threeDiscCol y cx cy cw z = cx z :=
  if_pos h

/-- The glued colouring on the disc about `y`, when `y` is at least `1/2` from `0`. -/
theorem threeDiscCol_of_mem_right {y : ℂ} (hy : 1 / 2 ≤ dist y 0) (cx cy cw : ℂ → α) {z : ℂ}
    (h : z ∈ ball y (1 / 4)) : threeDiscCol y cx cy cw z = cy z := by
  have h0 : ¬ dist z 0 < 1 / 4 := by
    intro h0
    have := dist_triangle_left y 0 z
    rw [mem_ball] at h
    linarith
  rw [threeDiscCol, if_neg h0]
  exact if_pos h

/-- The glued colouring on the disc about `1`, when `y` is at least `1/2` from `1`. -/
theorem threeDiscCol_of_mem_one {y : ℂ} (hy : 1 / 2 ≤ dist y 1) (cx cy cw : ℂ → α) {z : ℂ}
    (h : z ∈ ball (1 : ℂ) (1 / 4)) : threeDiscCol y cx cy cw z = cw z := by
  rw [mem_ball] at h
  have h0 : ¬ dist z 0 < 1 / 4 := by
    intro h0
    have := dist_triangle_left (1 : ℂ) 0 z
    rw [dist_zero_right, norm_one] at this
    linarith
  have h1 : ¬ dist z y < 1 / 4 := by
    intro h1
    have := dist_triangle_left y 1 z
    linarith
  rw [threeDiscCol, if_neg h0, if_neg h1]

/-- The glued colouring is measurable when its three parts are. -/
theorem measurable_threeDiscCol [MeasurableSpace α] (y : ℂ) {cx cy cw : ℂ → α} (hx : Measurable cx)
    (hy : Measurable cy) (hw : Measurable cw) : Measurable (threeDiscCol y cx cy cw) :=
  Measurable.ite isOpen_ball.measurableSet hx (Measurable.ite isOpen_ball.measurableSet hy hw)

/-- **Properness on three discs**: a disc of radius `1/4` holds no unit pair, so a colouring that separates every
point of the disc about `0` from every point of the disc about `y`, and every unit pair off a null set `N` between the
disc about `1` and each of the other two, is proper at almost every unit pair of the three discs. -/
theorem threeDisc_aeProperOn {y : ℂ} {c : ℂ → α} {N : Set ℂ} (hN : volume N = 0)
    (hxy : ∀ t ∈ ball (0 : ℂ) (1 / 4), ∀ t' ∈ ball y (1 / 4), c t ≠ c t')
    (hxw : ∀ t ∈ ball (0 : ℂ) (1 / 4), ∀ z ∈ ball (1 : ℂ) (1 / 4), dist t z = 1 → t ∉ N → z ∉ N → c t ≠ c z)
    (hyw : ∀ t ∈ ball y (1 / 4), ∀ z ∈ ball (1 : ℂ) (1 / 4), dist t z = 1 → t ∉ N → z ∉ N → c t ≠ c z) :
    AeProperOn (threeDisc y) c := by
  refine aeProperOn_of_proper_off_null hN ?_
  -- two points of one disc of radius `1/4` are not at distance `1`
  have hsame : ∀ c₀ p q : ℂ, p ∈ ball c₀ (1 / 4) → q ∈ ball c₀ (1 / 4) → dist p q ≠ 1 := by
    intro c₀ p q hp hq h
    have := dist_triangle_right p q c₀
    rw [mem_ball] at hp hq
    linarith
  rintro p ((hp | hp) | hp) q ((hq | hq) | hq) hpq hpN hqN
  · exact absurd hpq (hsame _ _ _ hp hq)
  · exact hxw p hp q hq hpq hpN hqN
  · exact hxy p hp q hq
  · exact (hxw q hq p hp (by rw [dist_comm]; exact hpq) hqN hpN).symm
  · exact absurd hpq (hsame _ _ _ hp hq)
  · exact (hyw q hq p hp (by rw [dist_comm]; exact hpq) hqN hpN).symm
  · exact (hxy q hq p hp).symm
  · exact hyw p hp q hq hpq hpN hqN
  · exact absurd hpq (hsame _ _ _ hp hq)

/-! ## The pair of the witnesses -/

section pair

variable (hk : 6 ≤ k) {cx₀ cy₀ : ℂ → Fin 3} (Dx : ThreePiece (ball (0 : ℂ) (1 / 4)) cx₀ 0)
  (Dy : ThreePiece (ball (0 : ℂ) (1 / 4)) cy₀ 0) {y u : ℂ} (hu : ‖u‖ = 1) (cw : ℂ → Fin k)

/-- The colouring of the witnesses: about `0` the colouring `cx₀` with the labels `0, 1, 2`; about `y` the colouring
`cy₀` moved by the motion `z ↦ y + u z`, with the labels `3, 4, 5`; elsewhere `cw`. -/
noncomputable def pairCol (cx₀ cy₀ : ℂ → Fin 3) (y u : ℂ) (hu : ‖u‖ = 1) (cw : ℂ → Fin k) : ℂ → Fin k :=
  threeDiscCol y (fun z => labLo hk (cx₀ z)) (fun z => labHi hk (cy₀ ((planeMotion y u hu).symm z))) cw

/-- The motion `z ↦ y + u z` carries the disc of radius `1/4` about `0` into the disc about `y`. -/
theorem planeMotion_mem_ball {y u : ℂ} (hu : ‖u‖ = 1) {z : ℂ} (hz : z ∈ ball (0 : ℂ) (1 / 4)) :
    planeMotion y u hu z ∈ ball y (1 / 4) := by
  have h := dist_planeMotion (a := y) hu z 0
  rw [planeMotion_apply y u hu 0, mul_zero, add_zero] at h
  rw [mem_ball, h]
  exact hz

/-- The inverse motion carries the disc of radius `1/4` about `y` into the disc about `0`. -/
theorem planeMotion_symm_mem_ball {y u : ℂ} (hu : ‖u‖ = 1) {z : ℂ} (hz : z ∈ ball y (1 / 4)) :
    (planeMotion y u hu).symm z ∈ ball (0 : ℂ) (1 / 4) := by
  have h := dist_planeMotion_symm (a := y) hu z y
  rw [planeMotion_symm_apply y u hu y, neg_add_cancel, mul_zero] at h
  rw [mem_ball, h]
  exact hz

/-- **The close complementary pair of the witnesses**: a decomposition at `0` as it stands, with the labels
`0, 1, 2`, and a decomposition at `0` moved to `y` by the motion `z ↦ y + u z`, with the labels `3, 4, 5`, for the glued
colouring on the three discs. -/
noncomputable def threeDiscPair (hy0 : 1 / 2 ≤ dist y 0) (hy2 : dist y 0 < 2) :
    ClosePair (threeDisc y) (pairCol hk cx₀ cy₀ y u hu cw) 0 y where
  left := Dx.transport (Homeomorph.refl ℂ) (MeasurePreserving.id volume) (labLo hk) (labLo_injective hk) rfl
    (by
      rintro _ ⟨z, hz, rfl⟩
      exact Or.inl (Or.inl (Dx.nbhd_subset hz)))
    (fun z hz => threeDiscCol_of_mem_zero y _ _ cw (Dx.nbhd_subset hz))
  right := Dy.transport (planeMotion y u hu) (measurePreserving_planeMotion_symm hu) (labHi hk) (labHi_injective hk)
    (by simp)
    (by
      rintro _ ⟨z, hz, rfl⟩
      exact Or.inr (planeMotion_mem_ball hu (Dy.nbhd_subset hz)))
    (fun z hz => by
      rw [pairCol, threeDiscCol_of_mem_right hy0 _ _ cw (planeMotion_mem_ball hu (Dy.nbhd_subset hz)),
        Homeomorph.symm_apply_apply])
  ne := by
    rintro rfl
    rw [dist_self] at hy0
    norm_num at hy0
  dist_lt := by rw [dist_comm]; exact hy2
  label_ne i j := labLo_ne_labHi hk _ _

/-- **The glued colouring is a weak colouring** of the three discs as soon as, off a null set, it separates the unit
pairs between the disc about `1` and each of the other two (the discs about `0` and `y` carry different labels). -/
theorem isWeakColouringOn_pairCol (hcx : Measurable cx₀) (hcy : Measurable cy₀) (hcw : Measurable cw)
    (hy0 : 1 / 2 ≤ dist y 0) (hy1 : 1 / 2 ≤ dist y 1) {N : Set ℂ} (hN : volume N = 0)
    (hxw : ∀ t ∈ ball (0 : ℂ) (1 / 4), ∀ z ∈ ball (1 : ℂ) (1 / 4), dist t z = 1 → t ∉ N → z ∉ N →
      labLo hk (cx₀ t) ≠ cw z)
    (hyw : ∀ t ∈ ball y (1 / 4), ∀ z ∈ ball (1 : ℂ) (1 / 4), dist t z = 1 → t ∉ N → z ∉ N →
      labHi hk (cy₀ ((planeMotion y u hu).symm t)) ≠ cw z) :
    IsWeakColouringOn (threeDisc y) (pairCol hk cx₀ cy₀ y u hu cw) := by
  refine ⟨measurable_threeDiscCol y ((Measurable.of_discrete (f := labLo hk)).comp hcx)
    ((Measurable.of_discrete (f := labHi hk)).comp (hcy.comp (planeMotion y u hu).symm.continuous.measurable)) hcw,
    threeDisc_aeProperOn hN ?_ ?_ ?_⟩
  · intro t ht t' ht'
    rw [pairCol, threeDiscCol_of_mem_zero y _ _ cw ht, threeDiscCol_of_mem_right hy0 _ _ cw ht']
    exact labLo_ne_labHi hk _ _
  · intro t ht z hz htz htN hzN
    rw [pairCol, threeDiscCol_of_mem_zero y _ _ cw ht, threeDiscCol_of_mem_one hy1 _ _ cw hz]
    exact hxw t ht z hz htz htN hzN
  · intro t ht z hz htz htN hzN
    rw [pairCol, threeDiscCol_of_mem_right hy0 _ _ cw ht, threeDiscCol_of_mem_one hy1 _ _ cw hz]
    exact hyw t ht z hz htz htN hzN

end pair

/-! ## The kinds of the pair's pieces, read on the two decompositions at `0` -/

section pair

variable (hk : 6 ≤ k) {cx₀ cy₀ : ℂ → Fin 3} (Dx : ThreePiece (ball (0 : ℂ) (1 / 4)) cx₀ 0)
  (Dy : ThreePiece (ball (0 : ℂ) (1 / 4)) cy₀ 0) {y u : ℂ} (hu : ‖u‖ = 1) (cw : ℂ → Fin k)
  (hy0 : 1 / 2 ≤ dist y 0) (hy2 : dist y 0 < 2)

/-- The pieces of the first member of the pair are the pieces of its decomposition at `0`. -/
theorem threeDiscPair_left_piece (i : Fin 3) :
    (threeDiscPair hk Dx Dy hu cw hy0 hy2).left.piece i = Homeomorph.refl ℂ '' Dx.piece i := rfl

/-- The pieces of the second member of the pair are the images under the motion of the pieces of its decomposition
at `0`. -/
theorem threeDiscPair_right_piece (i : Fin 3) :
    (threeDiscPair hk Dx Dy hu cw hy0 hy2).right.piece i = planeMotion y u hu '' Dy.piece i := rfl

/-- The first member of the pair separates at a point exactly when its decomposition at `0` does. -/
theorem threeDiscPair_left_separatesAt_iff (w : ℂ) :
    (threeDiscPair hk Dx Dy hu cw hy0 hy2).left.SeparatesAt w ↔ Dx.SeparatesAt w :=
  ThreePiece.separatesAt_iff_of_image (T := Homeomorph.refl ℂ) (fun _ _ => rfl)
    (threeDiscPair_left_piece hk Dx Dy hu cw hy0 hy2) rfl

/-- The second member of the pair separates at the image of a point under the motion exactly when its decomposition
at `0` separates at the point. -/
theorem threeDiscPair_right_separatesAt_iff {w₀ w : ℂ} (hw : planeMotion y u hu w₀ = w) :
    (threeDiscPair hk Dx Dy hu cw hy0 hy2).right.SeparatesAt w ↔ Dy.SeparatesAt w₀ :=
  ThreePiece.separatesAt_iff_of_image (dist_planeMotion hu) (threeDiscPair_right_piece hk Dx Dy hu cw hy0 hy2) hw

/-- The first member of the pair has one piece of each kind at a point exactly when its decomposition at `0` has. -/
theorem threeDiscPair_left_oneOfEach_iff (w : ℂ) (σ : Equiv.Perm (Fin 3)) :
    (threeDiscPair hk Dx Dy hu cw hy0 hy2).left.OneOfEach w σ ↔ Dx.OneOfEach w σ :=
  ThreePiece.oneOfEach_iff_of_image (T := Homeomorph.refl ℂ) (fun _ _ => rfl)
    (threeDiscPair_left_piece hk Dx Dy hu cw hy0 hy2) rfl σ

/-- The second member of the pair has one piece of each kind at the image of a point under the motion exactly when
its decomposition at `0` has at the point. -/
theorem threeDiscPair_right_oneOfEach_iff {w₀ w : ℂ} (hw : planeMotion y u hu w₀ = w) (σ : Equiv.Perm (Fin 3)) :
    (threeDiscPair hk Dx Dy hu cw hy0 hy2).right.OneOfEach w σ ↔ Dy.OneOfEach w₀ σ :=
  ThreePiece.oneOfEach_iff_of_image (dist_planeMotion hu) (threeDiscPair_right_piece hk Dx Dy hu cw hy0 hy2) hw σ

/-- The first member of the pair has arc edges when its decomposition at `0` has. -/
theorem threeDiscPair_left_hasArcEdges (h : Dx.HasArcEdges) :
    (threeDiscPair hk Dx Dy hu cw hy0 hy2).left.HasArcEdges :=
  h.of_image (T := Homeomorph.refl ℂ) (threeDiscPair_left_piece hk Dx Dy hu cw hy0 hy2) rfl rfl

/-- The second member of the pair has arc edges when its decomposition at `0` has. -/
theorem threeDiscPair_right_hasArcEdges (h : Dy.HasArcEdges) :
    (threeDiscPair hk Dx Dy hu cw hy0 hy2).right.HasArcEdges :=
  h.of_image (threeDiscPair_right_piece hk Dx Dy hu cw hy0 hy2) rfl (by simp)

end pair

/-! ## Distances in coordinates -/

/-- The squared distance of two points of the plane, in coordinates. -/
theorem dist_sq_eq (p q : ℂ) : dist p q ^ 2 = (p.re - q.re) ^ 2 + (p.im - q.im) ^ 2 := by
  rw [dist_eq_norm, sq_norm_eq, Complex.sub_re, Complex.sub_im]

/-- Two points are less than `1` apart exactly when their squared distance, in coordinates, is below `1`. -/
theorem dist_lt_one_iff {p q : ℂ} : dist p q < 1 ↔ (p.re - q.re) ^ 2 + (p.im - q.im) ^ 2 < 1 := by
  rw [← dist_sq_eq, sq_lt_one_iff₀ dist_nonneg]

/-- Two points are more than `1` apart exactly when their squared distance, in coordinates, is above `1`. -/
theorem one_lt_dist_iff {p q : ℂ} : 1 < dist p q ↔ 1 < (p.re - q.re) ^ 2 + (p.im - q.im) ^ 2 := by
  rw [← dist_sq_eq, one_lt_sq_iff₀ dist_nonneg]

/-- A point of the disc of radius `1/4` about `1` has real part above `3/4` and imaginary part of absolute value
below `1/4`. -/
theorem re_im_of_mem_ball_one {z : ℂ} (hz : z ∈ ball (1 : ℂ) (1 / 4)) : 3 / 4 < z.re ∧ |z.im| < 1 / 4 := by
  rw [mem_ball, dist_eq_norm] at hz
  have h1 := Complex.abs_re_le_norm (z - 1)
  have h2 := Complex.abs_im_le_norm (z - 1)
  rw [Complex.sub_re, Complex.one_re] at h1
  rw [Complex.sub_im, Complex.one_im, sub_zero] at h2
  exact ⟨by linarith [(abs_le.mp h1).1], by linarith⟩

/-- A point of the disc of radius `1/4` about `0` has real and imaginary parts of absolute value below `1/4`. -/
theorem re_im_of_mem_ball_zero {z : ℂ} (hz : z ∈ ball (0 : ℂ) (1 / 4)) : |z.re| < 1 / 4 ∧ |z.im| < 1 / 4 := by
  rw [mem_ball, dist_zero_right] at hz
  exact ⟨lt_of_le_of_lt (Complex.abs_re_le_norm z) hz, lt_of_le_of_lt (Complex.abs_im_le_norm z) hz⟩

/-! ## The frame `x = 0`, `w = 1`, `y = 1 + i` of the first two witnesses -/

/-- `1 + i` is at least `1/2` from `0`. -/
theorem half_le_dist_one_add_I_zero : 1 / 2 ≤ dist (1 + I : ℂ) 0 := by
  have h : 1 < dist (1 + I : ℂ) 0 := by
    rw [one_lt_dist_iff]
    simp
  linarith

/-- `1 + i` is less than `2` from `0`. -/
theorem dist_one_add_I_zero_lt_two : dist (1 + I : ℂ) 0 < 2 := by
  have h : dist (1 + I : ℂ) 0 ^ 2 = 2 := by
    rw [dist_sq_eq]
    simp
    norm_num
  nlinarith [dist_nonneg (x := (1 + I : ℂ)) (y := 0)]

/-- `1 + i` is at least `1/2` from `1`. -/
theorem half_le_dist_one_add_I_one : 1 / 2 ≤ dist (1 + I : ℂ) 1 := by
  rw [dist_eq_norm, add_sub_cancel_left, Complex.norm_I]
  norm_num

/-- `1` is a common unit point of `0` and `1 + i`. -/
theorem isCommonUnitPoint_zero_one_add_I : IsCommonUnitPoint (0 : ℂ) (1 + I) 1 := by
  refine ⟨by simp, ?_⟩
  rw [dist_eq_norm, sub_add_cancel_left, norm_neg, Complex.norm_I]

/-! ## The ordinary three-sector point has no inner piece at `1` or at `−i` -/

/-- The ordinary three-sector point does not separate at `1`: each sector has a point strictly outside the unit
circle about `1`. -/
theorem sectorPoint_not_separatesAt_one : ¬ sectorPoint.SeparatesAt 1 := by
  refine (sectorPoint.not_separatesAt_iff 1).mpr ⟨.inside, fun i => ?_⟩
  rw [onSide_inside, not_innerAt_iff]
  have hb : ∀ a b : ℝ, a ^ 2 + b ^ 2 < (1 / 4) ^ 2 → (⟨a, b⟩ : ℂ) ∈ ball (0 : ℂ) (1 / 4) := fun a b h =>
    mem_ball_zero_of_sq_lt (by norm_num) h
  have hd : ∀ a b : ℝ, 1 < (a - 1) ^ 2 + b ^ 2 → 1 < dist (⟨a, b⟩ : ℂ) 1 := fun a b h => by
    rw [one_lt_dist_iff]
    simpa using h
  rcases fin_three_cases i with rfl | rfl | rfl
  · exact ⟨⟨1 / 100, 1 / 5⟩, ⟨mem_sectorSet_zero.mpr ⟨by show (0 : ℝ) < 1 / 100; norm_num,
      by show (0 : ℝ) < 1 / 5; norm_num⟩, hb _ _ (by norm_num)⟩, hd _ _ (by norm_num)⟩
  · exact ⟨⟨-(1 / 10), 0⟩, ⟨mem_sectorSet_one.mpr ⟨by show (-(1 / 10) : ℝ) < 0; norm_num,
      by show (-(1 / 10) : ℝ) < 0; norm_num⟩, hb _ _ (by norm_num)⟩, hd _ _ (by norm_num)⟩
  · exact ⟨⟨1 / 100, -(1 / 5)⟩, ⟨mem_sectorSet_two.mpr ⟨by show (-(1 / 5) : ℝ) < 0; norm_num,
      by show (-(1 / 5) : ℝ) < 1 / 100; norm_num⟩, hb _ _ (by norm_num)⟩, hd _ _ (by norm_num)⟩

/-- The ordinary three-sector point does not separate at `−i`: each sector has a point strictly outside the unit
circle about `−i`. -/
theorem sectorPoint_not_separatesAt_neg_I : ¬ sectorPoint.SeparatesAt (-I) := by
  refine (sectorPoint.not_separatesAt_iff (-I)).mpr ⟨.inside, fun i => ?_⟩
  rw [onSide_inside, not_innerAt_iff]
  have hb : ∀ a b : ℝ, a ^ 2 + b ^ 2 < (1 / 4) ^ 2 → (⟨a, b⟩ : ℂ) ∈ ball (0 : ℂ) (1 / 4) := fun a b h =>
    mem_ball_zero_of_sq_lt (by norm_num) h
  have hd : ∀ a b : ℝ, 1 < a ^ 2 + (b + 1) ^ 2 → 1 < dist (⟨a, b⟩ : ℂ) (-I) := fun a b h => by
    rw [one_lt_dist_iff]
    simpa using h
  rcases fin_three_cases i with rfl | rfl | rfl
  · exact ⟨⟨1 / 10, 1 / 10⟩, ⟨mem_sectorSet_zero.mpr ⟨by show (0 : ℝ) < 1 / 10; norm_num,
      by show (0 : ℝ) < 1 / 10; norm_num⟩, hb _ _ (by norm_num)⟩, hd _ _ (by norm_num)⟩
  · exact ⟨⟨-(1 / 10), 1 / 10⟩, ⟨mem_sectorSet_one.mpr ⟨by show (-(1 / 10) : ℝ) < 0; norm_num,
      by show (-(1 / 10) : ℝ) < 1 / 10; norm_num⟩, hb _ _ (by norm_num)⟩, hd _ _ (by norm_num)⟩
  · exact ⟨⟨1 / 5, -(1 / 100)⟩, ⟨mem_sectorSet_two.mpr ⟨by show (-(1 / 100) : ℝ) < 0; norm_num,
      by show (-(1 / 100) : ℝ) < 1 / 5; norm_num⟩, hb _ _ (by norm_num)⟩, hd _ _ (by norm_num)⟩

/-! ## The control on six: seven colours, neither member separates -/

/-- The seven-colouring of the control: the sector colouring about `0` (labels `0, 1, 2`), the sector colouring
translated to `1 + i` (labels `3, 4, 5`), and the seventh label `6` elsewhere — on the disc about `1`. -/
noncomputable def sevenCol : ℂ → Fin 7 :=
  pairCol (k := 7) (by norm_num) sectorCol sectorCol (1 + I) 1 norm_one fun _ => Fin.last 6

/-- **The pair of the control**: two ordinary three-sector points, at `0` and at `1 + i`. -/
noncomputable def sevenPair : ClosePair (threeDisc (1 + I)) sevenCol 0 (1 + I) :=
  threeDiscPair _ sectorPoint sectorPoint norm_one _ half_le_dist_one_add_I_zero dist_one_add_I_zero_lt_two

/-- The control is a weak seven-colouring of its three discs: the disc about `1` has the seventh label, and the other
two discs have three labels each of their own. -/
theorem isWeakColouringOn_sevenCol : IsWeakColouringOn (threeDisc (1 + I)) sevenCol := by
  refine isWeakColouringOn_pairCol _ norm_one _ measurable_sectorCol measurable_sectorCol measurable_const
    half_le_dist_one_add_I_zero half_le_dist_one_add_I_one (N := ∅) measure_empty ?_ ?_
  · intro t _ z _ _ _ _ h
    have h1 := congrArg Fin.val h
    have h2 := (sectorCol t).2
    simp only [labLo, Fin.val_last] at h1
    omega
  · intro t _ z _ _ _ _ h
    have h1 := congrArg Fin.val h
    have h2 := (sectorCol ((planeMotion (1 + I) 1 norm_one).symm t)).2
    simp only [labHi, Fin.val_last] at h1
    omega

/-- In the control the first member does not separate at `1`. -/
theorem sevenPair_left_not_separatesAt : ¬ sevenPair.left.SeparatesAt 1 :=
  (threeDiscPair_left_separatesAt_iff _ _ _ _ _ _ _ 1).not.mpr sectorPoint_not_separatesAt_one

/-- In the control the second member does not separate at `1`. -/
theorem sevenPair_right_not_separatesAt : ¬ sevenPair.right.SeparatesAt 1 :=
  (threeDiscPair_right_separatesAt_iff _ _ _ _ _ _ _ (w₀ := -I) (by simp)).not.mpr
    sectorPoint_not_separatesAt_neg_I

/-! ## One member alone: the petal point at `0`, a sector point at `1 + i` -/

/-- Where the petal colouring has the label `1`: on the right petal. -/
theorem petalCol_eq_one {z : ℂ} (h : petalCol z = 1) : |z.im| < z.re ∧ z.re < 1 / 8 := by
  by_contra hc
  rw [petalCol, if_neg hc] at h
  split_ifs at h <;> exact absurd h (by decide)

/-- Where the petal colouring has the label `2`: on the left petal. -/
theorem petalCol_eq_two {z : ℂ} (h : petalCol z = 2) : |z.im| < -z.re ∧ -z.re < 1 / 8 := by
  by_contra hc
  rw [petalCol, if_neg hc] at h
  split_ifs at h <;> exact absurd h (by decide)

/-- **The first inequality of the lone witness**: a point `(a, b)` near `1` inside the unit circle about `0` and a
point `(r, s)` of the right petal are less than `1` apart. -/
theorem petal_inner_lt {a b r s : ℝ} (ha : 3 / 4 < a) (hb : |b| < 1 / 4) (hab : a ^ 2 + b ^ 2 < 1) (hs : |s| < r)
    (hr : r < 1 / 8) : (r - a) ^ 2 + (s - b) ^ 2 < 1 := by
  obtain ⟨hb1, hb2⟩ := abs_lt.mp hb
  obtain ⟨hs1, hs2⟩ := abs_lt.mp hs
  have hr0 : 0 < r := lt_of_le_of_lt (abs_nonneg s) hs
  nlinarith [mul_pos (sub_pos.mpr ha) hr0, mul_pos (sub_pos.mpr hb2) (sub_pos.mpr hs2),
    mul_pos (show 0 < 1 / 4 + b by linarith) (show 0 < r + s by linarith),
    mul_pos (sub_pos.mpr hs2) (show 0 < r + s by linarith), mul_pos hr0 (sub_pos.mpr hr)]

/-- **The second inequality of the lone witness**: a point `(a, b)` near `1` not inside the unit circle about `0`
and a point `(r, s)` of the left petal are more than `1` apart. -/
theorem petal_outer_gt {a b r s : ℝ} (ha : 3 / 4 < a) (hb : |b| < 1 / 4) (hab : 1 ≤ a ^ 2 + b ^ 2) (hs : |s| < -r) :
    1 < (r - a) ^ 2 + (s - b) ^ 2 := by
  obtain ⟨hb1, hb2⟩ := abs_lt.mp hb
  obtain ⟨hs1, hs2⟩ := abs_lt.mp hs
  have hr0 : 0 < -r := lt_of_le_of_lt (abs_nonneg s) hs
  nlinarith [mul_pos (sub_pos.mpr ha) hr0, mul_pos (sub_pos.mpr hb2) (sub_pos.mpr hs2),
    mul_pos (show 0 < 1 / 4 + b by linarith) (show 0 < -r + s by linarith), sq_nonneg r, sq_nonneg s]

/-- The colouring of the lone witness on the disc about `1`: the label `1` inside the unit circle about `0`, the
label `2` elsewhere. -/
noncomputable def loneW (z : ℂ) : Fin 6 :=
  if dist z 0 < 1 then labLo (le_refl 6) 1 else labLo (le_refl 6) 2

/-- The six-colouring of the lone witness: the petal colouring about `0` (labels `0, 1, 2`), the sector colouring
translated to `1 + i` (labels `3, 4, 5`), and about `1` the petals' labels `1` and `2`, inside and outside the unit
circle about `0`. -/
noncomputable def loneCol : ℂ → Fin 6 :=
  pairCol (le_refl 6) petalCol sectorCol (1 + I) 1 norm_one loneW

/-- **The pair of the lone witness**: the petal point at `0` and an ordinary three-sector point at `1 + i`. -/
noncomputable def lonePair : ClosePair (threeDisc (1 + I)) loneCol 0 (1 + I) :=
  threeDiscPair _ petalPoint sectorPoint norm_one _ half_le_dist_one_add_I_zero dist_one_add_I_zero_lt_two

/-- The lone witness is a weak six-colouring of its three discs: near `1`, a point inside the unit circle about `0`
is less than `1` from the right petal, and a point not inside it is more than `1` from the left petal. -/
theorem isWeakColouringOn_loneCol : IsWeakColouringOn (threeDisc (1 + I)) loneCol := by
  refine isWeakColouringOn_pairCol _ norm_one _ measurable_petalCol measurable_sectorCol
    (Measurable.ite isOpen_ball.measurableSet measurable_const measurable_const)
    half_le_dist_one_add_I_zero half_le_dist_one_add_I_one (N := ∅) measure_empty ?_ ?_
  · intro t _ z hz htz _ _ h
    obtain ⟨hz1, hz2⟩ := re_im_of_mem_ball_one hz
    by_cases hz0 : dist z 0 < 1
    · rw [loneW, if_pos hz0] at h
      obtain ⟨h1, h2⟩ := petalCol_eq_one (labLo_injective _ h)
      have h3 : dist t z < 1 := by
        rw [dist_lt_one_iff]
        refine petal_inner_lt hz1 hz2 ?_ h1 h2
        simpa using dist_lt_one_iff.mp hz0
      linarith
    · rw [loneW, if_neg hz0] at h
      obtain ⟨h1, -⟩ := petalCol_eq_two (labLo_injective _ h)
      have h3 : 1 < dist t z := by
        rw [one_lt_dist_iff]
        refine petal_outer_gt hz1 hz2 ?_ h1
        have h4 := dist_sq_eq z 0
        simp only [Complex.zero_re, Complex.zero_im, sub_zero] at h4
        nlinarith [not_lt.mp hz0, dist_nonneg (x := z) (y := 0)]
      linarith
  · intro t _ z _ _ _ _
    rw [loneW]
    split_ifs <;> exact (labLo_ne_labHi _ _ _).symm

/-- In the lone witness the second member does not separate at `1`. -/
theorem lonePair_right_not_separatesAt : ¬ lonePair.right.SeparatesAt 1 :=
  (threeDiscPair_right_separatesAt_iff _ _ _ _ _ _ _ (w₀ := -I) (by simp)).not.mpr
    sectorPoint_not_separatesAt_neg_I

theorem check_lone :
    ∃ (U : Set ℂ) (c : ℂ → Fin 6) (x y w : ℂ) (C : ClosePair U c x y),
      IsOpen U ∧ IsWeakColouringOn U c ∧ w ∈ U ∧ IsCommonUnitPoint x y w ∧ ¬ C.right.SeparatesAt w := by
  exact ⟨_, _, _, _, _, lonePair, isOpen_threeDisc _, isWeakColouringOn_loneCol, one_mem_threeDisc _,
    isCommonUnitPoint_zero_one_add_I, lonePair_right_not_separatesAt⟩

theorem check_seven :
    ∃ (U : Set ℂ) (c : ℂ → Fin 7) (x y w : ℂ) (C : ClosePair U c x y),
      IsOpen U ∧ IsWeakColouringOn U c ∧ w ∈ U ∧ IsCommonUnitPoint x y w ∧ ¬ C.left.SeparatesAt w ∧
        ¬ C.right.SeparatesAt w := by
  exact ⟨_, _, _, _, _, sevenPair, isOpen_threeDisc _, isWeakColouringOn_sevenCol, one_mem_threeDisc _,
    isCommonUnitPoint_zero_one_add_I, sevenPair_left_not_separatesAt, sevenPair_right_not_separatesAt⟩

example : ∃ (U : Set ℂ) (c : ℂ → Fin 6) (x : ℂ) (D : ThreePiece U c x) (i j : Fin 3) (η : ℝ),
    0 < η ∧ closure (D.piece i) ∩ closure (D.piece j) ∩ ball x η = {x} := by
  obtain ⟨U, c, x, y, w, C, hU, hc, hw, hwu, hy⟩ := check_lone
  obtain ⟨σ, -, -, w', -, -, η', hη', -, -, h⟩ := closePair_lone hU hc C hw hwu hy
  exact ⟨U, c, x, C.left, σ 0, σ 1, η', hη', h⟩

#print axioms check_lone
#print axioms check_seven

end HadwigerNelson.Plane

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

**The three witnesses.**
* `sevenPair`, of `sevenCol` — **the control on six**: two ordinary three-sector points, at `0` and at `1 + i`, and the
  seventh label on the disc about `1`. Neither separates at `1` (`sevenPair_left_not_separatesAt`,
  `sevenPair_right_not_separatesAt`).
* `lonePair`, of `loneCol` — **one member alone**: the petal point of `Plane/ThreePiece` at `0`, an ordinary
  three-sector point at `1 + i`, and near `1` the two petals' labels inside and outside the unit circle about `0`. The
  second member does not separate at `1` (`lonePair_right_not_separatesAt`). Properness: `petal_inner_lt`,
  `petal_outer_gt`.
* `squarePair`, of `squareCol` — **both members arc-edged, one piece of each kind**: `y = 1 − i`; at `0` the split
  point (`splitPoint`: the half-disc above the real axis, and the half-disc below it cut by the unit circle about `1`
  — edges two real radii and an arc of that circle); at `1 − i` the split point turned by a quarter about `1`; near
  `1` the four regions cut by the unit circles about `0` and `1 − i` carry the labels of the two inner and the two
  outer pieces. Properness, off the three unit circles: `split_inner_lt`, `split_outer_gt`, each used once as it
  stands and once turned by the quarter. This is the planner's unit square with a straight cut in place of the unit
  circle about `i`: one non-convex piece per member.

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

/-! ## The split point: a half-disc, and a half-disc cut by a unit circle -/

/-- Two points are at most `1` apart exactly when their squared distance, in coordinates, is at most `1`. -/
theorem dist_le_one_iff {p q : ℂ} : dist p q ≤ 1 ↔ (p.re - q.re) ^ 2 + (p.im - q.im) ^ 2 ≤ 1 := by
  rw [← not_lt, one_lt_dist_iff, not_lt]

/-- Two points are at least `1` apart exactly when their squared distance, in coordinates, is at least `1`. -/
theorem one_le_dist_iff {p q : ℂ} : 1 ≤ dist p q ↔ 1 ≤ (p.re - q.re) ^ 2 + (p.im - q.im) ^ 2 := by
  rw [← not_lt, dist_lt_one_iff, not_lt]

/-- The squared norm of a point of the disc of radius `1/4` about `0`, in coordinates. -/
theorem sq_lt_of_mem_ball_zero {z : ℂ} (hz : z ∈ ball (0 : ℂ) (1 / 4)) : z.re ^ 2 + z.im ^ 2 < (1 / 4) ^ 2 := by
  rw [mem_ball, dist_zero_right] at hz
  rw [← sq_norm_eq]
  exact pow_lt_pow_left₀ hz (norm_nonneg z) two_ne_zero

/-- The split colouring: `2` above the real axis; on and below it, `0` inside the unit circle about `1` and `1`
elsewhere. -/
noncomputable def splitCol (z : ℂ) : Fin 3 := if 0 < z.im then 2 else if dist z 1 < 1 then 0 else 1

/-- The three open sets of the split point: below the real axis inside the unit circle about `1`, below it outside
that circle, and above it. -/
def splitSet : Fin 3 → Set ℂ
  | 0 => {z | z.im < 0 ∧ dist z 1 < 1}
  | 1 => {z | z.im < 0 ∧ 1 < dist z 1}
  | 2 => {z | 0 < z.im}

/-- The split colouring is measurable. -/
theorem measurable_splitCol : Measurable splitCol := by
  refine Measurable.ite ?_ measurable_const (Measurable.ite ?_ measurable_const measurable_const)
  · exact (isOpen_lt continuous_const Complex.continuous_im).measurableSet
  · exact isOpen_ball.measurableSet

/-- The set `0`: below the real axis, inside the unit circle about `1`. -/
theorem mem_splitSet_zero {z : ℂ} : z ∈ splitSet 0 ↔ z.im < 0 ∧ dist z 1 < 1 := Iff.rfl

/-- The set `1`: below the real axis, outside the unit circle about `1`. -/
theorem mem_splitSet_one {z : ℂ} : z ∈ splitSet 1 ↔ z.im < 0 ∧ 1 < dist z 1 := Iff.rfl

/-- The set `2`: above the real axis. -/
theorem mem_splitSet_two {z : ℂ} : z ∈ splitSet 2 ↔ 0 < z.im := Iff.rfl

/-- The three sets are open. -/
theorem isOpen_splitSet (i : Fin 3) : IsOpen (splitSet i) := by
  rcases fin_three_cases i with rfl | rfl | rfl
  · exact (isOpen_lt Complex.continuous_im continuous_const).inter isOpen_ball
  · exact (isOpen_lt Complex.continuous_im continuous_const).inter
      (isOpen_lt continuous_const (continuous_id.dist continuous_const))
  · exact isOpen_lt continuous_const Complex.continuous_im

/-- The split colouring has the label `i` on the set `i`. -/
theorem splitCol_of_mem {i : Fin 3} {z : ℂ} (h : z ∈ splitSet i) : splitCol z = i := by
  rcases fin_three_cases i with rfl | rfl | rfl
  · obtain ⟨h1, h2⟩ := mem_splitSet_zero.mp h
    rw [splitCol, if_neg (not_lt.mpr h1.le), if_pos h2]
  · obtain ⟨h1, h2⟩ := mem_splitSet_one.mp h
    rw [splitCol, if_neg (not_lt.mpr h1.le), if_neg (not_lt.mpr h2.le)]
  · rw [splitCol, if_pos (mem_splitSet_two.mp h)]

/-- Where the split colouring has the label `0`: not above the real axis, inside the unit circle about `1`. -/
theorem splitCol_eq_zero {z : ℂ} (h : splitCol z = 0) : z.im ≤ 0 ∧ dist z 1 < 1 := by
  unfold splitCol at h
  split_ifs at h with h1 h2
  · exact absurd h (by decide)
  · exact ⟨not_lt.mp h1, h2⟩
  · exact absurd h (by decide)

/-- Where the split colouring has the label `1`: not above the real axis, not inside the unit circle about `1`. -/
theorem splitCol_eq_one {z : ℂ} (h : splitCol z = 1) : z.im ≤ 0 ∧ 1 ≤ dist z 1 := by
  unfold splitCol at h
  split_ifs at h with h1 h2
  · exact absurd h (by decide)
  · exact absurd h (by decide)
  · exact ⟨not_lt.mp h1, not_lt.mp h2⟩

/-- A point on or above the real axis is in the closure of the set `2`. -/
theorem mem_closure_splitSet_two {p : ℂ} (h : 0 ≤ p.im) : p ∈ closure (splitSet 2) := by
  refine mem_closure_of_forall_add_ofReal_mul_mem (d := I) one_pos fun s hs _ => mem_splitSet_two.mpr ?_
  simp only [Complex.add_im, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im, Complex.I_re, Complex.I_im]
  linarith

/-- A point of the disc of radius `1/4` about `0`, on or below the real axis and on or inside the unit circle about
`1`, is in the closure of the set `0`: move along `1 − i`. -/
theorem mem_closure_splitSet_zero {p : ℂ} (hp : p ∈ ball (0 : ℂ) (1 / 4)) (h1 : p.im ≤ 0) (h2 : dist p 1 ≤ 1) :
    p ∈ closure (splitSet 0) := by
  obtain ⟨hre, him⟩ := re_im_of_mem_ball_zero hp
  rw [dist_le_one_iff] at h2
  simp only [Complex.one_re, Complex.one_im, sub_zero] at h2
  refine mem_closure_of_forall_add_ofReal_mul_mem (d := 1 - I) (r := 1 / 4) (by norm_num) fun s hs hs' =>
    mem_splitSet_zero.mpr ?_
  rw [dist_lt_one_iff]
  simp only [Complex.add_re, Complex.add_im, Complex.mul_re, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im,
    Complex.sub_re, Complex.sub_im, Complex.one_re, Complex.one_im, Complex.I_re, Complex.I_im]
  refine ⟨by linarith, ?_⟩
  have h3 : 0 < s * (1 - p.re + p.im - s) := mul_pos hs (by linarith [(abs_lt.mp hre).2, (abs_lt.mp him).1])
  nlinarith

/-- A point of the disc of radius `1/4` about `0`, on or below the real axis and on or outside the unit circle about
`1`, is in the closure of the set `1`: move along `−1 − i`. -/
theorem mem_closure_splitSet_one {p : ℂ} (hp : p ∈ ball (0 : ℂ) (1 / 4)) (h1 : p.im ≤ 0) (h2 : 1 ≤ dist p 1) :
    p ∈ closure (splitSet 1) := by
  obtain ⟨hre, him⟩ := re_im_of_mem_ball_zero hp
  rw [one_le_dist_iff] at h2
  simp only [Complex.one_re, Complex.one_im, sub_zero] at h2
  refine mem_closure_of_forall_add_ofReal_mul_mem (d := -1 - I) one_pos fun s hs _ => mem_splitSet_one.mpr ?_
  rw [one_lt_dist_iff]
  simp only [Complex.add_re, Complex.add_im, Complex.mul_re, Complex.mul_im, Complex.ofReal_re, Complex.ofReal_im,
    Complex.sub_re, Complex.sub_im, Complex.neg_re, Complex.neg_im, Complex.one_re, Complex.one_im, Complex.I_re,
    Complex.I_im]
  refine ⟨by linarith, ?_⟩
  have h3 : 0 < s * (1 - p.re - p.im + s) := mul_pos hs (by linarith [(abs_lt.mp hre).2])
  nlinarith

/-- `0` is in the closure of each of the three sets. -/
theorem zero_mem_closure_splitSet (i : Fin 3) : (0 : ℂ) ∈ closure (splitSet i) := by
  have h0 : (0 : ℂ) ∈ ball (0 : ℂ) (1 / 4) := mem_ball_self (by norm_num)
  rcases fin_three_cases i with rfl | rfl | rfl
  · exact mem_closure_splitSet_zero h0 (by simp) (by simp)
  · exact mem_closure_splitSet_one h0 (by simp) (by simp)
  · exact mem_closure_splitSet_two (by simp)

/-- **The set `1` is connected inside the disc**: its part on or left of the imaginary axis is convex, and every
other point of it is joined to that part by the horizontal segment to its mirror image in the axis — moving left
from a point outside the unit circle about `1` stays outside it. -/
theorem isPreconnected_splitOuter : IsPreconnected (splitSet 1 ∩ ball (0 : ℂ) (1 / 4)) := by
  have hLc : IsPreconnected (({z : ℂ | z.re ≤ 0} ∩ {z : ℂ | z.im < 0}) ∩ ball (0 : ℂ) (1 / 4)) :=
    (((convex_halfSpace_re_le 0).inter (convex_halfSpace_im_lt 0)).inter (convex_ball 0 (1 / 4))).isPreconnected
  have hLsub : ({z : ℂ | z.re ≤ 0} ∩ {z : ℂ | z.im < 0}) ∩ ball (0 : ℂ) (1 / 4) ⊆
      splitSet 1 ∩ ball (0 : ℂ) (1 / 4) := by
    rintro z ⟨⟨h1, h2⟩, h3⟩
    have h1' : z.re ≤ 0 := h1
    have h2' : z.im < 0 := h2
    refine ⟨mem_splitSet_one.mpr ⟨h2', ?_⟩, h3⟩
    rw [one_lt_dist_iff]
    simp only [Complex.one_re, Complex.one_im, sub_zero]
    nlinarith [mul_pos (neg_pos.mpr h2') (neg_pos.mpr h2')]
  have hp₀ : (⟨-(1 / 8), -(1 / 8)⟩ : ℂ) ∈ ({z : ℂ | z.re ≤ 0} ∩ {z : ℂ | z.im < 0}) ∩ ball (0 : ℂ) (1 / 4) :=
    ⟨⟨by show (-(1 / 8) : ℝ) ≤ 0; norm_num, by show (-(1 / 8) : ℝ) < 0; norm_num⟩,
      mem_ball_zero_of_sq_lt (by norm_num) (by norm_num)⟩
  refine isPreconnected_of_forall (⟨-(1 / 8), -(1 / 8)⟩ : ℂ) fun q hq => ?_
  obtain ⟨hq12, hq3⟩ := hq
  obtain ⟨hq1, hq2⟩ := mem_splitSet_one.mp hq12
  rcases le_or_gt q.re 0 with hre | hre
  · exact ⟨_, hLsub, hp₀, ⟨⟨hre, hq1⟩, hq3⟩, hLc⟩
  · -- the horizontal segment from `q` to its mirror image in the imaginary axis
    have hqsq := sq_lt_of_mem_ball_zero hq3
    rw [one_lt_dist_iff] at hq2
    simp only [Complex.one_re, Complex.one_im, sub_zero] at hq2
    have hq'sq : (-q.re) ^ 2 + q.im ^ 2 < (1 / 4) ^ 2 := by rw [neg_sq]; exact hqsq
    have hq'L : (⟨-q.re, q.im⟩ : ℂ) ∈ ({z : ℂ | z.re ≤ 0} ∩ {z : ℂ | z.im < 0}) ∩ ball (0 : ℂ) (1 / 4) :=
      ⟨⟨by show -q.re ≤ 0; linarith, hq1⟩, mem_ball_zero_of_sq_lt (by norm_num) hq'sq⟩
    have hseg : segment ℝ q (⟨-q.re, q.im⟩ : ℂ) ⊆ splitSet 1 ∩ ball (0 : ℂ) (1 / 4) := by
      rintro z ⟨a, b, ha, hb, hab, rfl⟩
      have hre' : (a • q + b • (⟨-q.re, q.im⟩ : ℂ)).re = (a - b) * q.re := by
        simp only [Complex.add_re, Complex.smul_re, smul_eq_mul]
        ring
      have him' : (a • q + b • (⟨-q.re, q.im⟩ : ℂ)).im = q.im := by
        simp only [Complex.add_im, Complex.smul_im, smul_eq_mul]
        rw [← add_mul, hab, one_mul]
      have hab1 : (a - b) * q.re ≤ q.re := by nlinarith [mul_nonneg hb hre.le]
      have hab2 : -q.re ≤ (a - b) * q.re := by nlinarith [mul_nonneg ha hre.le]
      refine ⟨mem_splitSet_one.mpr ⟨by rw [him']; exact hq1, ?_⟩, mem_ball_zero_of_sq_lt (by norm_num) ?_⟩
      · rw [one_lt_dist_iff, hre', him']
        simp only [Complex.one_re, Complex.one_im, sub_zero]
        nlinarith [mul_nonneg (sub_nonneg.mpr hab1) (show 0 ≤ 2 - q.re - (a - b) * q.re by nlinarith)]
      · rw [hre', him']
        nlinarith [mul_nonneg (sub_nonneg.mpr hab1) (show 0 ≤ q.re + (a - b) * q.re by linarith)]
    exact ⟨_, union_subset hLsub hseg, Or.inl hp₀, Or.inr (left_mem_segment ℝ q _),
      IsPreconnected.union _ hq'L (right_mem_segment ℝ q _) hLc (convex_segment q _).isPreconnected⟩

/-- The disc of radius `1/4` about `0` is the union of the three sets up to a null set: what is left lies on the real
axis or on the unit circle about `1`. -/
theorem volume_ball_diff_iUnion_splitSet :
    volume (ball (0 : ℂ) (1 / 4) \ ⋃ i, splitSet i ∩ ball (0 : ℂ) (1 / 4)) = 0 := by
  refine measure_mono_null (fun z hz => ?_) (measure_union_null
    (volume_setOf_re_im_eq (a := 0) (b := 1) (Or.inr one_ne_zero) 0) (Measure.addHaar_sphere volume (1 : ℂ) 1))
  obtain ⟨hzb, hzn⟩ := hz
  have hn : ∀ i, z ∉ splitSet i := fun i hi => hzn (mem_iUnion.mpr ⟨i, hi, hzb⟩)
  have h0 := hn 0
  have h1 := hn 1
  have h2 := hn 2
  rw [mem_splitSet_zero] at h0
  rw [mem_splitSet_one] at h1
  rw [mem_splitSet_two] at h2
  rcases lt_trichotomy z.im 0 with him | him | him
  · rcases lt_trichotomy (dist z 1) 1 with h | h | h
    · exact absurd ⟨him, h⟩ h0
    · exact Or.inr (mem_sphere.mpr h)
    · exact absurd ⟨him, h⟩ h1
  · exact Or.inl (by show (0 : ℝ) * z.re + 1 * z.im = 0; linarith)
  · exact absurd him h2

/-- **The split point**: the decomposition of the disc of radius `1/4` about `0` into the half-disc above the real
axis and the two parts of the half-disc below it cut by the unit circle about `1`. Its edges are the two real radii
and an arc of that circle: it is arc-edged, with one inner, one outer and one crossing piece at `1`. -/
noncomputable def splitPoint : ThreePiece (ball (0 : ℂ) (1 / 4)) splitCol 0 where
  nbhd := ball 0 (1 / 4)
  piece i := splitSet i ∩ ball 0 (1 / 4)
  label i := i
  nbhd_mem := ball_mem_nhds 0 (by norm_num)
  nbhd_subset := Subset.rfl
  piece_subset _ := inter_subset_right
  isOpen_piece i := (isOpen_splitSet i).inter isOpen_ball
  isPreconnected_piece i := by
    rcases fin_three_cases i with rfl | rfl | rfl
    · exact (((convex_halfSpace_im_lt 0).inter (convex_ball (1 : ℂ) 1)).inter
        (convex_ball (0 : ℂ) (1 / 4))).isPreconnected
    · exact isPreconnected_splitOuter
    · exact ((convex_halfSpace_im_gt 0).inter (convex_ball (0 : ℂ) (1 / 4))).isPreconnected
  mem_closure_piece i := mem_closure_inter_ball (mem_ball_self (by norm_num)) (zero_mem_closure_splitSet i)
  ae_label i := Filter.Eventually.of_forall fun _ hz => splitCol_of_mem hz.1
  label_injective _ _ h := h
  null_diff := volume_ball_diff_iUnion_splitSet

/-- A point of the disc in the closures of two of the sets is on their edge. -/
theorem mem_splitPoint_edge {i j : Fin 3} {p : ℂ} (hp : p ∈ ball (0 : ℂ) (1 / 4)) (hi : p ∈ closure (splitSet i))
    (hj : p ∈ closure (splitSet j)) : p ∈ splitPoint.edge i j :=
  ⟨⟨mem_closure_inter_ball hp hi, mem_closure_inter_ball hp hj⟩, hp⟩

/-- The point at distance `ρ` from `0` on the lower arc of the unit circle about `1`. -/
noncomputable def splitArc (ρ : ℝ) : ℂ := ⟨ρ ^ 2 / 2, -(ρ * √(1 - ρ ^ 2 / 4))⟩

/-- The arc point is at distance `ρ` from `0`, in coordinates. -/
theorem splitArc_sq {ρ : ℝ} (h : ρ ^ 2 ≤ 4) : (splitArc ρ).re ^ 2 + (splitArc ρ).im ^ 2 = ρ ^ 2 := by
  have hv := Real.sq_sqrt (show 0 ≤ 1 - ρ ^ 2 / 4 by linarith)
  show (ρ ^ 2 / 2) ^ 2 + (-(ρ * √(1 - ρ ^ 2 / 4))) ^ 2 = ρ ^ 2
  rw [neg_sq, mul_pow, hv]
  ring

/-- The arc point is on the unit circle about `1`. -/
theorem dist_splitArc_one {ρ : ℝ} (h : ρ ^ 2 ≤ 4) : dist (splitArc ρ) 1 = 1 := by
  have h1 := splitArc_sq h
  have h2 : dist (splitArc ρ) 1 ^ 2 = 1 := by
    rw [dist_sq_eq]
    simp only [Complex.one_re, Complex.one_im, sub_zero]
    have h3 : (splitArc ρ).re = ρ ^ 2 / 2 := rfl
    nlinarith
  nlinarith [dist_nonneg (x := splitArc ρ) (y := 1)]

/-- The arc point is at distance `ρ` from `0`. -/
theorem dist_splitArc_zero {ρ : ℝ} (h0 : 0 ≤ ρ) (h : ρ ^ 2 ≤ 4) : dist (splitArc ρ) 0 = ρ := by
  have h1 := splitArc_sq h
  have h2 : dist (splitArc ρ) 0 ^ 2 = ρ ^ 2 := by
    rw [dist_sq_eq]
    simpa using h1
  exact (sq_eq_sq₀ dist_nonneg h0).mp h2

/-- The arc point is on or below the real axis. -/
theorem splitArc_im_nonpos {ρ : ℝ} (h0 : 0 ≤ ρ) : (splitArc ρ).im ≤ 0 :=
  neg_nonpos.mpr (mul_nonneg h0 (Real.sqrt_nonneg _))

/-- The arc is continuous. -/
theorem continuous_splitArc : Continuous splitArc := by
  have h : splitArc = fun ρ : ℝ => ((ρ ^ 2 / 2 : ℝ) : ℂ) + ((-(ρ * √(1 - ρ ^ 2 / 4)) : ℝ) : ℂ) * I := by
    funext ρ
    apply Complex.ext
    · simp only [splitArc, Complex.add_re, Complex.ofReal_re, Complex.mul_re, Complex.I_re, Complex.ofReal_im,
        Complex.I_im, mul_zero, zero_mul, sub_zero, add_zero]
    · simp only [splitArc, Complex.add_im, Complex.ofReal_im, Complex.mul_im, Complex.I_re, Complex.ofReal_re,
        Complex.I_im, mul_zero, mul_one, add_zero, zero_add]
  rw [h]
  fun_prop

/-- An arc point within `1/4` of `0` is on the edge of the sets `0` and `1`. -/
theorem splitArc_mem_edge {ρ : ℝ} (h0 : 0 ≤ ρ) (h : ρ < 1 / 4) : splitArc ρ ∈ splitPoint.edge 0 1 := by
  have h4 : ρ ^ 2 ≤ 4 := by nlinarith
  have hb : splitArc ρ ∈ ball (0 : ℂ) (1 / 4) := by rw [mem_ball, dist_splitArc_zero h0 h4]; exact h
  exact mem_splitPoint_edge hb (mem_closure_splitSet_zero hb (splitArc_im_nonpos h0) (dist_splitArc_one h4).le)
    (mem_closure_splitSet_one hb (splitArc_im_nonpos h0) (dist_splitArc_one h4).ge)

/-- The split point has arc edges: the two real radii, and an arc of the unit circle about `1`. -/
theorem splitPoint_hasArcEdges : splitPoint.HasArcEdges := by
  have hre : ∀ t a b : ℝ, ((t : ℂ) * (⟨a, b⟩ : ℂ)).re = t * a := fun t a b => by simp
  have him : ∀ t a b : ℝ, ((t : ℂ) * (⟨a, b⟩ : ℂ)).im = t * b := fun t a b => by simp
  -- the radius along `1`, between the sets `0` and `2`
  have h02 : ∃ γ : C(unitInterval, ℂ), Function.Injective γ ∧ γ 0 = 0 ∧ range γ ⊆ splitPoint.edge 0 2 := by
    refine exists_arc_of_ray_subset (d := ⟨1 / 8, 0⟩)
      (fun h => by have := congrArg Complex.re h; norm_num at this) fun t ht0 ht1 => ?_
    have hb := ofReal_mul_mem_ball_quarter (d := ⟨1 / 8, 0⟩) (by norm_num) ht0 ht1
    refine mem_splitPoint_edge hb (mem_closure_splitSet_zero hb ?_ ?_) (mem_closure_splitSet_two ?_)
    · rw [him]; linarith
    · rw [dist_le_one_iff, hre, him]
      simp only [Complex.one_re, Complex.one_im, sub_zero]
      nlinarith
    · rw [him]; linarith
  -- the radius along `−1`, between the sets `1` and `2`
  have h12 : ∃ γ : C(unitInterval, ℂ), Function.Injective γ ∧ γ 0 = 0 ∧ range γ ⊆ splitPoint.edge 1 2 := by
    refine exists_arc_of_ray_subset (d := ⟨-(1 / 8), 0⟩)
      (fun h => by have := congrArg Complex.re h; norm_num at this) fun t ht0 ht1 => ?_
    have hb := ofReal_mul_mem_ball_quarter (d := ⟨-(1 / 8), 0⟩) (by norm_num) ht0 ht1
    refine mem_splitPoint_edge hb (mem_closure_splitSet_one hb ?_ ?_) (mem_closure_splitSet_two ?_)
    · rw [him]; linarith
    · rw [one_le_dist_iff, hre, him]
      simp only [Complex.one_re, Complex.one_im, sub_zero]
      nlinarith
    · rw [him]; linarith
  -- the arc of the unit circle about `1`, between the sets `0` and `1`
  have h01 : ∃ γ : C(unitInterval, ℂ), Function.Injective γ ∧ γ 0 = 0 ∧ range γ ⊆ splitPoint.edge 0 1 := by
    have hρ : ∀ t : unitInterval, 0 ≤ (t : ℝ) / 8 ∧ (t : ℝ) / 8 < 1 / 4 ∧ ((t : ℝ) / 8) ^ 2 ≤ 4 := fun t =>
      ⟨by linarith [t.2.1], by linarith [t.2.2], by nlinarith [t.2.1, t.2.2]⟩
    refine ⟨⟨fun t => splitArc ((t : ℝ) / 8),
      continuous_splitArc.comp (continuous_subtype_val.div_const 8)⟩, ?_, ?_, ?_⟩
    · intro s t hst
      have h1 := congrArg (fun z : ℂ => dist z 0) hst
      simp only [ContinuousMap.coe_mk] at h1
      rw [dist_splitArc_zero (hρ s).1 (hρ s).2.2, dist_splitArc_zero (hρ t).1 (hρ t).2.2] at h1
      exact Subtype.ext (by linarith)
    · show splitArc (((0 : unitInterval) : ℝ) / 8) = 0
      apply Complex.ext <;> simp [splitArc]
    · rintro _ ⟨t, rfl⟩
      exact splitArc_mem_edge (hρ t).1 (hρ t).2.1
  intro i j hij
  rcases fin_three_cases i with rfl | rfl | rfl <;> rcases fin_three_cases j with rfl | rfl | rfl
  · exact absurd rfl hij
  · exact h01
  · exact h02
  · rw [ThreePiece.edge_comm]; exact h01
  · exact absurd rfl hij
  · exact h12
  · rw [ThreePiece.edge_comm]; exact h02
  · rw [ThreePiece.edge_comm]; exact h12
  · exact absurd rfl hij

/-- **The split point has one piece of each kind at `1`**: the set `0` is inner, the set `1` outer, and the half-disc
above the axis crossing. -/
theorem splitPoint_oneOfEach : splitPoint.OneOfEach 1 (Equiv.refl (Fin 3)) := by
  refine ⟨fun z hz => ?_, Set.disjoint_left.mpr fun z hz hb => ?_, ?_⟩
  · exact mem_closedBall.mpr (mem_splitSet_zero.mp hz.1).2.le
  · exact absurd (mem_ball.mp hb) (not_lt.mpr (mem_splitSet_one.mp hz.1).2.le)
  · show CrossingAt (splitSet 2 ∩ ball (0 : ℂ) (1 / 4)) 1
    rw [crossingAt_iff]
    constructor
    · refine ⟨⟨1 / 10, 1 / 10⟩, ⟨mem_splitSet_two.mpr (by show (0 : ℝ) < 1 / 10; norm_num),
        mem_ball_zero_of_sq_lt (by norm_num) (by norm_num)⟩, ?_⟩
      rw [dist_lt_one_iff]
      simp only [Complex.one_re, Complex.one_im, sub_zero]
      norm_num
    · refine ⟨⟨-(1 / 10), 1 / 10⟩, ⟨mem_splitSet_two.mpr (by show (0 : ℝ) < 1 / 10; norm_num),
        mem_ball_zero_of_sq_lt (by norm_num) (by norm_num)⟩, ?_⟩
      rw [one_lt_dist_iff]
      simp only [Complex.one_re, Complex.one_im, sub_zero]
      norm_num

/-! ## Both members arc-edged: the split point at `0` and, turned by a quarter about `1`, at `1 − i` -/

/-- **The first inequality of the unit-square witness** (the pair of labels `0`, `0` and, turned by a quarter, the
pair `3`, `3`): a point `(a, b)` near `1`, inside the unit circle about `0` and outside the unit circle about `1 + i`,
and a point `(r, s)` near `0`, inside the unit circle about `1` and not above the real axis, are less than `1` apart.
Below the axis (`b ≤ 0`) the two ordinates have one sign and the larger one bounds their difference; in the sliver
`0 < b`, being outside the circle about `1 + i` gives `b < (1 − a)²`. -/
theorem split_inner_lt {a b r s : ℝ} (ha : 3 / 4 < a) (hb : |b| < 1 / 4) (hab : a ^ 2 + b ^ 2 < 1)
    (hout : 1 < (a - 1) ^ 2 + (b - 1) ^ 2) (hr : |r| < 1 / 4) (hs : s ≤ 0) (hs' : |s| < 1 / 4)
    (hrs : (r - 1) ^ 2 + s ^ 2 < 1) : (r - a) ^ 2 + (s - b) ^ 2 < 1 := by
  obtain ⟨hb1, hb2⟩ := abs_lt.mp hb
  obtain ⟨hr1, hr2⟩ := abs_lt.mp hr
  obtain ⟨hs1, -⟩ := abs_lt.mp hs'
  have hr0 : 0 < r := by nlinarith [sq_nonneg r, sq_nonneg s]
  have ha1 : a < 1 := by nlinarith [sq_nonneg b]
  have hs2 : s ^ 2 < 2 * r - r ^ 2 := by nlinarith
  rcases le_or_gt b 0 with hb0 | hb0
  · rcases le_total s b with hsb | hsb
    · -- `s ≤ b ≤ 0`: the difference of the ordinates is at most `|s|`
      nlinarith [mul_nonneg (neg_nonneg.mpr hb0) (show 0 ≤ b - 2 * s by linarith),
        mul_pos (sub_pos.mpr ha1) (show 0 < 1 + a - 2 * r by linarith)]
    · -- `b ≤ s ≤ 0`: the difference of the ordinates is at most `|b|`
      nlinarith [mul_nonneg (neg_nonneg.mpr hs) (show 0 ≤ s - 2 * b by linarith),
        mul_pos hr0 (show 0 < 2 * a - r by linarith)]
  · -- the sliver above the axis
    have h4 : b < (1 - a) ^ 2 := by nlinarith [mul_pos hb0 (sub_pos.mpr hb2)]
    have h2 : -(2 * s * b) ≤ b / 2 := by nlinarith [mul_nonneg hb0.le (show 0 ≤ 1 / 4 + s by linarith)]
    have h3 : b ^ 2 ≤ b / 4 := by nlinarith [mul_nonneg hb0.le (sub_nonneg.mpr hb2.le)]
    nlinarith [mul_pos (sub_pos.mpr ha1) (show 0 < 2 - 7 / 4 * (1 - a) - 2 * r by linarith)]

/-- **The second inequality of the unit-square witness** (the pair of labels `1`, `1` and, turned by a quarter, the
pair `4`, `4`): a point `(a, b)` near `1`, outside the unit circles about `0` and about `1 − i`, and a point `(r, s)`
near `0`, outside the unit circle about `1` and not above the real axis, are more than `1` apart. On or above the axis
(`0 ≤ b`) the product of the ordinates has the right sign, and the abscissae are absorbed by one of the two circles; in
the sliver `b < 0`, being outside the circle about `1 − i` gives `−b < (a − 1)²` and `1 < a`. -/
theorem split_outer_gt {a b r s : ℝ} (ha : |a - 1| < 1 / 4) (hb : |b| < 1 / 4) (hab : 1 < a ^ 2 + b ^ 2)
    (hout : 1 < (a - 1) ^ 2 + (b + 1) ^ 2) (hr : |r| < 1 / 4) (hs : s ≤ 0) (hs' : |s| < 1 / 4)
    (hrs : 1 < (r - 1) ^ 2 + s ^ 2) : 1 < (r - a) ^ 2 + (s - b) ^ 2 := by
  obtain ⟨ha1, ha2⟩ := abs_lt.mp ha
  obtain ⟨hb1, hb2⟩ := abs_lt.mp hb
  obtain ⟨hr1, hr2⟩ := abs_lt.mp hr
  obtain ⟨hs1, -⟩ := abs_lt.mp hs'
  rcases le_or_gt 0 b with hb0 | hb0
  · have hbs : 0 ≤ b * -s := mul_nonneg hb0 (neg_nonneg.mpr hs)
    rcases le_or_gt r 0 with hr0 | hr0
    · have h1 : 0 ≤ a * -r := mul_nonneg (by linarith) (neg_nonneg.mpr hr0)
      linarith only [h1, hbs, hab, sq_nonneg r, sq_nonneg s]
    · rcases le_or_gt a 1 with hu | hu
      · have h1 : 0 ≤ r * (1 - a) := mul_nonneg hr0.le (sub_nonneg.mpr hu)
        linarith only [h1, hbs, hab, hrs]
      · have h1 : 0 < (a - 1) * (a + 1 - 2 * r) := mul_pos (sub_pos.mpr hu) (by linarith)
        linarith only [h1, hbs, hrs, sq_nonneg b]
  · -- the sliver below the axis
    have h5 : 0 < -b * (1 + b) := mul_pos (neg_pos.mpr hb0) (by linarith)
    have h4 : -b < (a - 1) ^ 2 := by linarith only [hout, h5]
    have h3 : 0 ≤ -b * (1 / 4 + b) := mul_nonneg (neg_nonneg.mpr hb0.le) (by linarith)
    have hu : 1 < a := by
      by_contra hcon
      have h6 : 0 ≤ (1 - a) * (5 / 4 * a + 3 / 4) := mul_nonneg (sub_nonneg.mpr (not_lt.mp hcon)) (by linarith)
      linarith only [hab, h3, h4, h6]
    have h2 : 0 ≤ -b * (1 / 4 + s) := mul_nonneg (neg_nonneg.mpr hb0.le) (by linarith)
    have h7 : 0 < (a - 1) * (a / 2 + 3 / 2 - 2 * r) := mul_pos (sub_pos.mpr hu) (by linarith)
    linarith only [h7, hrs, h2, h4, sq_nonneg b]

/-- The unit discs about `1 − i` and `1 + i` touch at `1` only: a point inside one is outside the other. -/
theorem one_lt_dist_of_dist_lt_one {z p q : ℂ} (hpq : dist p q = 2) (h : dist z p < 1) : 1 < dist z q := by
  have := dist_triangle p z q
  rw [dist_comm p z] at this
  linarith

/-- `1 − i` and `1 + i` are `2` apart. -/
theorem dist_one_sub_I_one_add_I : dist (1 - I : ℂ) (1 + I) = 2 := by
  rw [dist_eq_norm, show (1 - I : ℂ) - (1 + I) = -(2 * I) by ring, norm_neg, norm_mul, Complex.norm_I, mul_one,
    Complex.norm_ofNat]

/-- A point of the disc of radius `1/4` about `1` has real part within `1/4` of `1` and imaginary part of absolute
value below `1/4`. -/
theorem abs_re_sub_one_im_of_mem_ball_one {z : ℂ} (hz : z ∈ ball (1 : ℂ) (1 / 4)) :
    |z.re - 1| < 1 / 4 ∧ |z.im| < 1 / 4 := by
  rw [mem_ball, dist_eq_norm] at hz
  have h1 := Complex.abs_re_le_norm (z - 1)
  have h2 := Complex.abs_im_le_norm (z - 1)
  rw [Complex.sub_re, Complex.one_re] at h1
  rw [Complex.sub_im, Complex.one_im, sub_zero] at h2
  exact ⟨by linarith, by linarith⟩

/-- The first inequality, for points of the plane: `z` near `1`, inside the unit circle about `0` and outside that
about `1 + i`; `t` near `0`, inside the unit circle about `1` and not above the real axis. -/
theorem split_inner_dist_lt {z t : ℂ} (hz : z ∈ ball (1 : ℂ) (1 / 4)) (ht : t ∈ ball (0 : ℂ) (1 / 4))
    (hz0 : dist z 0 < 1) (hzo : 1 < dist z (1 + I)) (ht1 : dist t 1 < 1) (hti : t.im ≤ 0) : dist t z < 1 := by
  obtain ⟨hz1, hz2⟩ := re_im_of_mem_ball_one hz
  obtain ⟨ht2, ht3⟩ := re_im_of_mem_ball_zero ht
  rw [dist_lt_one_iff] at hz0 ht1 ⊢
  rw [one_lt_dist_iff] at hzo
  simp only [Complex.zero_re, Complex.zero_im, Complex.one_re, Complex.one_im, Complex.add_re, Complex.add_im,
    Complex.I_re, Complex.I_im, sub_zero, add_zero, zero_add] at hz0 hzo ht1
  exact split_inner_lt hz1 hz2 hz0 hzo ht2 hti ht3 ht1

/-- The second inequality, for points of the plane: `z` near `1`, outside the unit circles about `0` and about
`1 − i`; `t` near `0`, outside the unit circle about `1` and not above the real axis. -/
theorem split_outer_dist_gt {z t : ℂ} (hz : z ∈ ball (1 : ℂ) (1 / 4)) (ht : t ∈ ball (0 : ℂ) (1 / 4))
    (hz0 : 1 < dist z 0) (hzo : 1 < dist z (1 - I)) (ht1 : 1 < dist t 1) (hti : t.im ≤ 0) : 1 < dist t z := by
  obtain ⟨hz1, hz2⟩ := abs_re_sub_one_im_of_mem_ball_one hz
  obtain ⟨ht2, ht3⟩ := re_im_of_mem_ball_zero ht
  rw [one_lt_dist_iff] at hz0 hzo ht1 ⊢
  simp only [Complex.zero_re, Complex.zero_im, Complex.one_re, Complex.one_im, Complex.sub_re, Complex.sub_im,
    Complex.I_re, Complex.I_im, sub_zero, zero_sub, sub_neg_eq_add] at hz0 hzo ht1
  exact split_outer_gt hz1 hz2 hz0 hzo ht2 hti ht3 ht1

/-! ### The frame `x = 0`, `w = 1`, `y = 1 − i`, and the quarter turn about `1` -/

/-- `1 − i` is at least `1/2` from `0`. -/
theorem half_le_dist_one_sub_I_zero : 1 / 2 ≤ dist (1 - I : ℂ) 0 := by
  have h : 1 < dist (1 - I : ℂ) 0 := by
    rw [one_lt_dist_iff]
    simp
  linarith

/-- `1 − i` is less than `2` from `0`. -/
theorem dist_one_sub_I_zero_lt_two : dist (1 - I : ℂ) 0 < 2 := by
  have h : dist (1 - I : ℂ) 0 ^ 2 = 2 := by
    rw [dist_sq_eq]
    simp
    norm_num
  nlinarith [dist_nonneg (x := (1 - I : ℂ)) (y := 0)]

/-- `1 − i` is at least `1/2` from `1`. -/
theorem half_le_dist_one_sub_I_one : 1 / 2 ≤ dist (1 - I : ℂ) 1 := by
  rw [dist_eq_norm, sub_sub_cancel_left, norm_neg, Complex.norm_I]
  norm_num

/-- `1` is a common unit point of `0` and `1 − i`. -/
theorem isCommonUnitPoint_zero_one_sub_I : IsCommonUnitPoint (0 : ℂ) (1 - I) 1 := by
  refine ⟨by simp, ?_⟩
  rw [dist_eq_norm, sub_sub_cancel, Complex.norm_I]

/-- The quarter turn about `1`, `z ↦ (1 − i) + i z`, fixes `1`. -/
theorem quarterTurn_one : planeMotion (1 - I) I Complex.norm_I 1 = 1 := by
  rw [planeMotion_apply]
  ring

/-- The inverse quarter turn carries `1` to `1`. -/
theorem quarterTurn_symm_one : (planeMotion (1 - I) I Complex.norm_I).symm 1 = 1 := by
  rw [Homeomorph.symm_apply_eq, quarterTurn_one]

/-- The inverse quarter turn carries `0` to `1 + i`. -/
theorem quarterTurn_symm_zero : (planeMotion (1 - I) I Complex.norm_I).symm 0 = 1 + I := by
  rw [Homeomorph.symm_apply_eq, planeMotion_apply]
  linear_combination -Complex.I_mul_I

/-- The inverse quarter turn carries `1 − i` to `0`. -/
theorem quarterTurn_symm_right : (planeMotion (1 - I) I Complex.norm_I).symm (1 - I) = 0 := by
  rw [Homeomorph.symm_apply_eq, planeMotion_apply, mul_zero, add_zero]

/-- The colouring of the unit-square witness on the disc about `1`: the four regions cut by the unit circles about
`0` and about `1 − i` carry the labels `0` (inside both), `4` (inside the first only), `3` (inside the second only)
and `1` (inside neither). -/
noncomputable def squareW (z : ℂ) : Fin 6 :=
  if dist z 0 < 1 then (if dist z (1 - I) < 1 then labLo (le_refl 6) 0 else labHi (le_refl 6) 1)
  else (if dist z (1 - I) < 1 then labHi (le_refl 6) 0 else labLo (le_refl 6) 1)

/-- The six-colouring of the unit-square witness: the split colouring about `0` (labels `0, 1, 2`), the split
colouring turned by a quarter about `1` onto the disc about `1 − i` (labels `3, 4, 5`), and about `1` the four labels
`0, 4, 3, 1` of the inner and the outer pieces on the four regions cut by the two unit circles. -/
noncomputable def squareCol : ℂ → Fin 6 :=
  pairCol (le_refl 6) splitCol splitCol (1 - I) I Complex.norm_I squareW

/-- **The pair of the unit-square witness**: the split point at `0` and, turned by a quarter about `1`, at
`1 − i`. -/
noncomputable def squarePair : ClosePair (threeDisc (1 - I)) squareCol 0 (1 - I) :=
  threeDiscPair _ splitPoint splitPoint Complex.norm_I _ half_le_dist_one_sub_I_zero dist_one_sub_I_zero_lt_two

/-- The colouring on the disc about `1` is measurable. -/
theorem measurable_squareW : Measurable squareW :=
  Measurable.ite isOpen_ball.measurableSet
    (Measurable.ite isOpen_ball.measurableSet measurable_const measurable_const)
    (Measurable.ite isOpen_ball.measurableSet measurable_const measurable_const)

/-- **The unit-square witness is a weak six-colouring** of its three discs: off the three unit circles about `0`,
`1` and `1 − i`, a unit pair between the disc about `1` and the disc about `0` is separated by the two inequalities,
and one between the disc about `1` and the disc about `1 − i` is such a pair turned by a quarter about `1`. -/
theorem isWeakColouringOn_squareCol : IsWeakColouringOn (threeDisc (1 - I)) squareCol := by
  have hN : volume (sphere (0 : ℂ) 1 ∪ sphere (1 - I : ℂ) 1 ∪ sphere (1 : ℂ) 1) = 0 :=
    measure_union_null (measure_union_null (Measure.addHaar_sphere volume _ _)
      (Measure.addHaar_sphere volume _ _)) (Measure.addHaar_sphere volume _ _)
  refine isWeakColouringOn_pairCol _ Complex.norm_I _ measurable_splitCol measurable_splitCol measurable_squareW
    half_le_dist_one_sub_I_zero half_le_dist_one_sub_I_one hN ?_ ?_
  · intro t ht z hz htz htN hzN h
    have hz0' : dist z 0 ≠ 1 := fun h' => hzN (Or.inl (Or.inl (mem_sphere.mpr h')))
    have hzy' : dist z (1 - I) ≠ 1 := fun h' => hzN (Or.inl (Or.inr (mem_sphere.mpr h')))
    have ht1' : dist t 1 ≠ 1 := fun h' => htN (Or.inr (mem_sphere.mpr h'))
    unfold squareW at h
    split_ifs at h with hz0 hzy hzy
    · obtain ⟨h1, h2⟩ := splitCol_eq_zero (labLo_injective _ h)
      have h3 := split_inner_dist_lt hz ht hz0 (one_lt_dist_of_dist_lt_one dist_one_sub_I_one_add_I hzy) h2 h1
      linarith
    · exact labLo_ne_labHi _ _ _ h
    · exact labLo_ne_labHi _ _ _ h
    · obtain ⟨h1, h2⟩ := splitCol_eq_one (labLo_injective _ h)
      have h3 := split_outer_dist_gt hz ht (lt_of_le_of_ne (not_lt.mp hz0) (Ne.symm hz0'))
        (lt_of_le_of_ne (not_lt.mp hzy) (Ne.symm hzy')) (lt_of_le_of_ne h2 (Ne.symm ht1')) h1
      linarith
  · intro t ht z hz htz htN hzN h
    have hz0' : dist z 0 ≠ 1 := fun h' => hzN (Or.inl (Or.inl (mem_sphere.mpr h')))
    have hzy' : dist z (1 - I) ≠ 1 := fun h' => hzN (Or.inl (Or.inr (mem_sphere.mpr h')))
    have ht1' : dist t 1 ≠ 1 := fun h' => htN (Or.inr (mem_sphere.mpr h'))
    -- the pair, turned back by a quarter about `1`
    have hτb := planeMotion_symm_mem_ball Complex.norm_I ht
    have hd := dist_planeMotion_symm (a := 1 - I) Complex.norm_I
    have hζb : (planeMotion (1 - I) I Complex.norm_I).symm z ∈ ball (1 : ℂ) (1 / 4) := by
      have h1 := hd z 1
      rw [quarterTurn_symm_one] at h1
      rw [mem_ball, h1]
      exact hz
    have hζ0 : dist ((planeMotion (1 - I) I Complex.norm_I).symm z) 0 = dist z (1 - I) := by
      rw [← quarterTurn_symm_right, hd]
    have hζp : dist ((planeMotion (1 - I) I Complex.norm_I).symm z) (1 + I) = dist z 0 := by
      rw [← quarterTurn_symm_zero, hd]
    have hτ1 : dist ((planeMotion (1 - I) I Complex.norm_I).symm t) 1 = dist t 1 := by
      have h1 := hd t 1
      rw [quarterTurn_symm_one] at h1
      exact h1
    have hτζ := hd t z
    rw [htz] at hτζ
    unfold squareW at h
    split_ifs at h with hz0 hzy hzy
    · exact labLo_ne_labHi _ _ _ h.symm
    · obtain ⟨h1, h2⟩ := splitCol_eq_one (labHi_injective _ h)
      rw [hτ1] at h2
      have h3 := split_outer_dist_gt hζb hτb (by rw [hζ0]; exact lt_of_le_of_ne (not_lt.mp hzy) (Ne.symm hzy'))
        (one_lt_dist_of_dist_lt_one (by rw [dist_comm]; exact dist_one_sub_I_one_add_I) (by rw [hζp]; exact hz0))
        (by rw [hτ1]; exact lt_of_le_of_ne h2 (Ne.symm ht1')) h1
      linarith
    · obtain ⟨h1, h2⟩ := splitCol_eq_zero (labHi_injective _ h)
      have h3 := split_inner_dist_lt hζb hτb (by rw [hζ0]; exact hzy)
        (by rw [hζp]; exact lt_of_le_of_ne (not_lt.mp hz0) (Ne.symm hz0')) h2 h1
      linarith
    · exact labLo_ne_labHi _ _ _ h.symm

/-- In the unit-square witness the first member has arc edges. -/
theorem squarePair_left_hasArcEdges : squarePair.left.HasArcEdges :=
  threeDiscPair_left_hasArcEdges _ _ _ _ _ _ _ splitPoint_hasArcEdges

/-- In the unit-square witness the second member has arc edges. -/
theorem squarePair_right_hasArcEdges : squarePair.right.HasArcEdges :=
  threeDiscPair_right_hasArcEdges _ _ _ _ _ _ _ splitPoint_hasArcEdges

/-- In the unit-square witness the first member has one piece of each kind at `1`. -/
theorem squarePair_left_oneOfEach : squarePair.left.OneOfEach 1 (Equiv.refl (Fin 3)) :=
  (threeDiscPair_left_oneOfEach_iff _ _ _ _ _ _ _ 1 _).mpr splitPoint_oneOfEach

/-- In the unit-square witness the second member has one piece of each kind at `1`. -/
theorem squarePair_right_oneOfEach : squarePair.right.OneOfEach 1 (Equiv.refl (Fin 3)) :=
  (threeDiscPair_right_oneOfEach_iff _ _ _ _ _ _ _ quarterTurn_one _).mpr splitPoint_oneOfEach

end HadwigerNelson.Plane

import Proofs.HadwigerNelson.Plane.ThreePiece

/-!
# A close complementary pair of three-piece points, at a common unit point (FS-124, second module)

Claims **C124-FORCED-PIECES**, **C124-LONE**, **C124-BOTH** and **C124-FOUR** of `data/fs124/claims-K2.md` (plan:
`plans/FS124-kernel-plan-2.md`). Nothing here rests on a declared outside theorem.

* `ClosePair U c x y` — a close complementary pair: decompositions at `x` and at `y`, `x ≠ y`, `dist x y < 2`, and no
  label of `x` a label of `y`. `IsCommonUnitPoint x y w` — `w` at distance `1` from both; at such a point the unit
  circles about `x` and `y` cross (`ClosePair.crossAt`), so they cut every disc about `w` into four regions of
  positive measure (`Plane/CircleCrossing`).
* `presentAt U c w` — the labels present at `w`: those whose class in `U` has `w` in its closed essential support
  (`essSupport`, `Plane/UnitPairs`).

**Where the number six is spent** — in one line, `ClosePair.exists_label_eq`: with six labels, every label is the
label of a piece of `x` or of a piece of `y`. Every theorem here is proved from that sentence as a hypothesis
(`hcover`) for `AeProperOn` at any label type — `exists_onSide_of_cover`, `ClosePair.separatesAt_or`,
`ClosePair.lone_of_cover`, `ClosePair.separatesAt_right_of_isFull`, `ClosePair.presentAt_eq` — and the claim list's
statements are the corollaries at `Fin 6`. With seven labels `hcover` fails, and `closePair_forced_pieces` is false
(`exists_closePair_seven_not_separatesAt`, `Plane/ClosePairModel`).

The mechanism, with no cover hypothesis (`ae_onSide_of_label`, the type of finitely many pieces at once): near `w`,
almost every point on the side `σ` of the unit circle about `x` that carries the label of a piece of `x` has that
piece on the closed side `σ` of the unit circle about `w`. With the cover: each of the four regions cut near `w` by
the unit circles about `x` and `y` has positive measure, so for each choice of sides `(σ, τ)` there is a piece of `x`
on the closed side `σ` of `S(w)` or a piece of `y` on the closed side `τ` of `S(w)` (`exists_onSide_of_cover`).
C124-FORCED-PIECES is that sentence at the two sides a non-separating pair would leave empty. When one side of
`S(y)` near `w` is filled by two labels of `x` — one inside `S(x)`, one outside — a second unit point `w' ≠ w` of
`x` is the far end of a tight pair, and the two pieces meet at `x` only
(`ThreePiece.exists_second_unit_point_of_ae_side`): this is C124-LONE's last clause, and it is what fullness
excludes in C124-BOTH and C124-FOUR.

**Inhabitants** (`Plane/ClosePairModel`): `exists_closePair_not_separatesAt` — a close complementary pair of a weak
six-colouring with a common unit point at which one member does not separate (the hypotheses of `closePair_forced_pieces` and
`closePair_lone` at once); `exists_closePair_full` — one with both members arc-edged, hence full, each with one inner, one
outer and one crossing piece (the hypotheses of `closePair_both_separate`, `closePair_both_saved` and `closePair_four` at once)
— constructed in `Plane/ClosePairWitness` (`lonePair`, `squarePair`; the control, `sevenPair`).
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Metric Topology

variable {α : Type*} {k : ℕ}

/-! ## Labels present at a point -/

/-- **The labels present at `w`**: "a label is present at a point when the point lies in the closed essential support
of its class" — the class of `i` in `U` is `U ∩ c ⁻¹' {i}`. -/
def presentAt (U : Set ℂ) (c : ℂ → α) (w : ℂ) : Set α := {i | w ∈ essSupport (U ∩ c ⁻¹' {i})}

/-- Present: every disc about the point meets the class in positive measure. -/
theorem mem_presentAt_iff {U : Set ℂ} {c : ℂ → α} {w : ℂ} {i : α} :
    i ∈ presentAt U c w ↔ ∀ r > 0, 0 < volume (U ∩ c ⁻¹' {i} ∩ ball w r) := by
  exact Iff.rfl

/-- A label almost nowhere on a disc about `w` is not present at `w`. -/
theorem not_mem_presentAt_of_ae_ne {U : Set ℂ} {c : ℂ → α} {w : ℂ} {i : α} {η : ℝ} (hη : 0 < η)
    (h : ∀ᵐ z, z ∈ ball w η → c z ≠ i) : i ∉ presentAt U c w := by
  intro hi
  refine (mem_presentAt_iff.mp hi η hη).ne' (measure_eq_zero_iff_ae_notMem.mpr ?_)
  filter_upwards [h] with z hz hzm
  exact hz hzm.2 hzm.1.2

/-- Not present: the label is almost nowhere on `U` in some disc about the point. -/
theorem not_mem_presentAt_iff {U : Set ℂ} {c : ℂ → α} {w : ℂ} {i : α} :
    i ∉ presentAt U c w ↔ ∃ η > 0, ∀ᵐ z, z ∈ U → z ∈ ball w η → c z ≠ i := by
  constructor
  · intro h
    by_contra hcon
    refine h (mem_presentAt_iff.mpr fun r hr => ?_)
    by_contra hz
    refine hcon ⟨r, hr, ?_⟩
    have h0 : volume (U ∩ c ⁻¹' {i} ∩ ball w r) = 0 := nonpos_iff_eq_zero.mp (not_lt.mp hz)
    filter_upwards [measure_eq_zero_iff_ae_notMem.mp h0] with z hz' hzU hzb hci
    exact hz' ⟨⟨hzU, hci⟩, hzb⟩
  · rintro ⟨η, hη, h⟩ hi
    refine (mem_presentAt_iff.mp hi η hη).ne' (measure_eq_zero_iff_ae_notMem.mpr ?_)
    filter_upwards [h] with z hz hzm
    exact hz hzm.1.1 hzm.2 hzm.1.2

/-- A label carried almost everywhere by a subset of `U` that has positive measure in every disc about `w` is present
at `w`. -/
theorem mem_presentAt_of_ae_eq {U : Set ℂ} {c : ℂ → α} {w : ℂ} {i : α} {V : Set ℂ} (hVU : V ⊆ U)
    (hi : ∀ᵐ z, z ∈ V → c z = i) (hpos : ∀ r > 0, 0 < volume (V ∩ ball w r)) : i ∈ presentAt U c w := by
  rw [mem_presentAt_iff]
  intro r hr
  refine lt_of_lt_of_le (hpos r hr) (measure_mono_ae ?_)
  filter_upwards [hi] with z hz hzm
  exact ⟨⟨hVU hzm.1, hz hzm.1⟩, hzm.2⟩

/-- At a point of an open set, some label is present (finitely many labels). -/
theorem presentAt_nonempty [Finite α] {U : Set ℂ} (hU : IsOpen U) (c : ℂ → α) {w : ℂ} (hw : w ∈ U) :
    (presentAt U c w).Nonempty := by
  by_contra hne
  rw [Set.not_nonempty_iff_eq_empty] at hne
  have h : ∀ i : α, ∃ η > 0, ∀ᵐ z, z ∈ U → z ∈ ball w η → c z ≠ i := fun i =>
    not_mem_presentAt_iff.mp (by rw [hne]; exact Set.notMem_empty i)
  choose η hη hae using h
  obtain ⟨r₀, hr₀, hball⟩ := Metric.isOpen_iff.mp hU w hw
  haveI : Nonempty α := ⟨c w⟩
  obtain ⟨i₀, hi₀⟩ := Finite.exists_min η
  have hr : 0 < min r₀ (η i₀) := lt_min hr₀ (hη i₀)
  -- a disc about `w` inside `U` on which almost every point has no label
  have hnull : volume (ball w (min r₀ (η i₀))) = 0 := by
    rw [measure_eq_zero_iff_ae_notMem]
    filter_upwards [ae_all_iff.2 hae] with z hz hzb
    exact hz (c z) (hball (ball_subset_ball (min_le_left _ _) hzb))
      (ball_subset_ball ((min_le_right _ _).trans (hi₀ (c z))) hzb) rfl
  exact (isOpen_ball.measure_pos volume ⟨w, mem_ball_self hr⟩).ne' hnull

/-! ## Close complementary pairs -/

/-- **A close complementary pair** (`data/fs124/claims-K2.md`): "two three-piece points x, y with 0 < |x − y| < 2
whose six labels are distinct", each with a decomposition. -/
structure ClosePair (U : Set ℂ) (c : ℂ → α) (x y : ℂ) where
  /-- The decomposition at `x`. -/
  left : ThreePiece U c x
  /-- The decomposition at `y`. -/
  right : ThreePiece U c y
  /-- `0 < |x − y|`. -/
  ne : x ≠ y
  /-- `|x − y| < 2`. -/
  dist_lt : dist x y < 2
  /-- No label of `x` is a label of `y` (with the injectivity of each: the six labels are distinct). -/
  label_ne : ∀ i j, left.label i ≠ right.label j

/-- `w` is a **common unit point** of `x` and `y`: `|w − x| = |w − y| = 1`. -/
def IsCommonUnitPoint (x y w : ℂ) : Prop := dist w x = 1 ∧ dist w y = 1

/-- A common unit point of `x` and `y` is one of `y` and `x`. -/
theorem IsCommonUnitPoint.symm {x y w : ℂ} (h : IsCommonUnitPoint x y w) : IsCommonUnitPoint y x w := by
  exact ⟨h.2, h.1⟩

/-- "Its common unit points are the two points `w` with `|w − x| = |w − y| = 1`": for `0 < |x − y| < 2` there are
exactly two. -/
theorem exists_isCommonUnitPoint {x y : ℂ} (hne : x ≠ y) (hlt : dist x y < 2) :
    ∃ w₁ w₂ : ℂ, w₁ ≠ w₂ ∧ ∀ w, IsCommonUnitPoint x y w ↔ w = w₁ ∨ w = w₂ := by
  have hfin : Module.finrank ℝ ℂ = 2 := by rw [Module.finrank_eq_card_basis Complex.basisOneI, Fintype.card_fin]
  -- the distance `d`, the unit vector `n` from `x` to `y`, the height `h` of the two points over the chord
  obtain ⟨d, hd, hd2, hdn⟩ : ∃ d : ℝ, 0 < d ∧ d < 2 ∧ ‖y - x‖ = d :=
    ⟨dist x y, dist_pos.mpr hne, hlt, by rw [dist_comm, dist_eq_norm]⟩
  have hdc : (d : ℂ) ≠ 0 := by exact_mod_cast hd.ne'
  obtain ⟨n, hnn, hyx⟩ : ∃ n : ℂ, ‖n‖ = 1 ∧ y = x + n * (d : ℂ) := by
    refine ⟨(y - x) / d, ?_, ?_⟩
    · rw [norm_div, hdn, Complex.norm_real, Real.norm_of_nonneg hd.le, div_self hd.ne']
    · rw [div_mul_cancel₀ _ hdc]
      ring
  have hh2 : 0 < 1 - (d / 2) ^ 2 := by nlinarith
  obtain ⟨h, hh, hsq⟩ : ∃ h : ℝ, 0 < h ∧ (d / 2) ^ 2 + h ^ 2 = 1 :=
    ⟨Real.sqrt (1 - (d / 2) ^ 2), Real.sqrt_pos.mpr hh2, by rw [Real.sq_sqrt hh2.le]; ring⟩
  have hunit : ∀ a b : ℝ, a ^ 2 + b ^ 2 = 1 → ‖n * ((a : ℂ) + b * I)‖ = 1 := by
    intro a b hab
    rw [norm_mul, hnn, one_mul, Complex.norm_add_mul_I, hab, Real.sqrt_one]
  have key : ∀ a b : ℝ, a ^ 2 + b ^ 2 = 1 → dist (x + n * ((a : ℂ) + b * I)) x = 1 := by
    intro a b hab
    rw [dist_eq_norm, add_sub_cancel_left]
    exact hunit a b hab
  have key' : ∀ a b : ℝ, (a - d) ^ 2 + b ^ 2 = 1 → dist (x + n * ((a : ℂ) + b * I)) y = 1 := by
    intro a b hab
    have hsub : x + n * ((a : ℂ) + b * I) - y = n * (((a - d : ℝ) : ℂ) + b * I) := by
      rw [hyx]
      push_cast
      ring
    rw [dist_eq_norm, hsub]
    exact hunit _ _ hab
  have h1x := key (d / 2) h hsq
  have h1y := key' (d / 2) h (by linear_combination hsq)
  have h2x := key (d / 2) (-h) (by linear_combination hsq)
  have h2y := key' (d / 2) (-h) (by linear_combination hsq)
  have hw₁w₂ : x + n * (((d / 2 : ℝ) : ℂ) + ((h : ℝ) : ℂ) * I) ≠ x + n * (((d / 2 : ℝ) : ℂ) + ((-h : ℝ) : ℂ) * I) := by
    intro heq
    have hn0 : n ≠ 0 := fun h0 => by
      rw [h0, norm_zero] at hnn
      exact zero_ne_one hnn
    have h3 := congrArg Complex.im (mul_left_cancel₀ hn0 (add_left_cancel heq))
    simp only [Complex.add_im, Complex.ofReal_im, Complex.mul_im, Complex.ofReal_re, Complex.I_re, Complex.I_im,
      mul_zero, mul_one, zero_add, add_zero] at h3
    linarith
  refine ⟨_, _, hw₁w₂, fun w => ⟨fun hw => ?_, ?_⟩⟩
  · exact EuclideanGeometry.eq_of_dist_eq_of_dist_eq_of_finrank_eq_two (V := ℂ) (P := ℂ) hfin hne hw₁w₂ h1x h2x hw.1
      h1y h2y hw.2
  · rintro (rfl | rfl)
    · exact ⟨h1x, h1y⟩
    · exact ⟨h2x, h2y⟩

namespace ClosePair

variable {U : Set ℂ} {c : ℂ → α} {x y w : ℂ}

/-- The pair in the other order. -/
def symm (C : ClosePair U c x y) : ClosePair U c y x where
  left := C.right
  right := C.left
  ne := C.ne.symm
  dist_lt := by rw [dist_comm]; exact C.dist_lt
  label_ne i j := (C.label_ne j i).symm

/-- At a common unit point the unit circles about the two members cross. -/
theorem crossAt (C : ClosePair U c x y) (hw : IsCommonUnitPoint x y w) : CrossAt x y w := by
  exact crossAt_of_dist_lt_two C.ne C.dist_lt hw.1 hw.2

/-- **Where six is spent**: with six labels, every label is the label of a piece of `x` or of a piece of `y` — six
distinct labels among six. -/
theorem exists_label_eq {c : ℂ → Fin 6} (C : ClosePair U c x y) (ℓ : Fin 6) :
    (∃ i, C.left.label i = ℓ) ∨ ∃ j, C.right.label j = ℓ := by
  have hinj : Function.Injective (Sum.elim C.left.label C.right.label) := by
    rintro (i | i) (j | j) h
    · exact congrArg _ (C.left.label_injective h)
    · exact absurd h (C.label_ne i j)
    · exact absurd h.symm (C.label_ne j i)
    · exact congrArg _ (C.right.label_injective h)
  have hsurj : Function.Surjective (Sum.elim C.left.label C.right.label) :=
    ((Fintype.bijective_iff_injective_and_card _).mpr ⟨hinj, by simp⟩).2
  obtain ⟨i | j, h⟩ := hsurj ℓ
  · exact Or.inl ⟨i, h⟩
  · exact Or.inr ⟨j, h⟩

end ClosePair

/-! ## The four regions at a common unit point -/

/-- **The type of finitely many pieces at once** (no cover hypothesis): let `P i` be finitely many pieces at `x` with
labels `a i`. Then near `w`, almost every point on a side `σ` of the unit circle about `x` that carries the label
`a i` has the piece `P i` on the closed side `σ` of the unit circle about `w`. (`IsPieceAt.ae_ne_region` for each
piece and each side, the least of finitely many radii.) -/
theorem ae_onSide_of_label {U : Set ℂ} {c : ℂ → α} (hU : IsOpen U) (hc : AeProperOn U c) {x w : ℂ} (hw : w ∈ U)
    {ι : Type*} [Finite ι] {P : ι → Set ℂ} {a : ι → α} (hP : ∀ i, IsPieceAt U c x (P i) (a i)) :
    ∃ η > 0, ∀ᵐ z, z ∈ ball w η → ∀ (σ : CircleSide) (i : ι), z ∈ σ.region x → c z = a i → OnSide σ (P i) w := by
  -- a radius for each side and each piece: the type of the piece if it is not on the side, any radius otherwise
  have key : ∀ (σ : CircleSide) (i : ι), ∃ η > 0,
      ∀ᵐ z, z ∈ ball w η → z ∈ σ.region x → c z = a i → OnSide σ (P i) w := by
    intro σ i
    by_cases hσ : OnSide σ (P i) w
    · exact ⟨1, one_pos, Filter.Eventually.of_forall fun _ _ _ _ => hσ⟩
    · obtain ⟨η, hη, h⟩ := (hP i).ae_ne_region hU hc hw hσ
      exact ⟨η, hη, by filter_upwards [h] with z hz hzb hzσ hci using absurd hci (hz hzb hzσ)⟩
  choose η hη hae using key
  rcases isEmpty_or_nonempty ι with hι | hι
  · exact ⟨1, one_pos, Filter.Eventually.of_forall fun z _ σ i => (hι.false i).elim⟩
  · -- the least of the finitely many radii
    obtain ⟨i₀, hi₀⟩ := Finite.exists_min fun i => min (η .inside i) (η .outside i)
    refine ⟨min (η .inside i₀) (η .outside i₀), lt_min (hη _ _) (hη _ _), ?_⟩
    have hall : ∀ᵐ z, ∀ i, (z ∈ ball w (η .inside i) → z ∈ CircleSide.inside.region x → c z = a i →
        OnSide .inside (P i) w) ∧ (z ∈ ball w (η .outside i) → z ∈ CircleSide.outside.region x → c z = a i →
        OnSide .outside (P i) w) := ae_all_iff.2 fun i => (hae .inside i).and (hae .outside i)
    filter_upwards [hall] with z hz hzb σ i hzσ hci
    cases σ
    · exact (hz i).1 (ball_subset_ball ((hi₀ i).trans (min_le_left _ _)) hzb) hzσ hci
    · exact (hz i).2 (ball_subset_ball ((hi₀ i).trans (min_le_right _ _)) hzb) hzσ hci

/-- **The quadrant lemma**: let `P i` be pieces at `x` with labels `a i` and `Q j` pieces at `y` with labels `b j`,
every label being one of them, and let the unit circles about `x` and `y` cross at `w ∈ U`. Then each of the four
regions needs a piece: for every choice of sides there is a piece of `x` on the closed side `σ` of the unit circle
about `w`, or a piece of `y` on the closed side `τ` of it. (The region on the side `σ` of `S(x)` and `τ` of `S(y)`
has positive measure in every disc about `w`, `CrossAt.volume_quadrant_pos`, and almost every point of it has some
label.) -/
theorem exists_onSide_of_cover {U : Set ℂ} {c : ℂ → α} (hU : IsOpen U) (hc : AeProperOn U c) {x y w : ℂ}
    (hcross : CrossAt x y w) (hw : w ∈ U) {ι κ : Type*} [Finite ι] [Finite κ] {P : ι → Set ℂ} {a : ι → α}
    {Q : κ → Set ℂ} {b : κ → α} (hP : ∀ i, IsPieceAt U c x (P i) (a i)) (hQ : ∀ j, IsPieceAt U c y (Q j) (b j))
    (hcover : ∀ ℓ : α, (∃ i, a i = ℓ) ∨ ∃ j, b j = ℓ) (σ τ : CircleSide) :
    (∃ i, OnSide σ (P i) w) ∨ ∃ j, OnSide τ (Q j) w := by
  obtain ⟨η₁, hη₁, h1⟩ := ae_onSide_of_label hU hc hw hP
  obtain ⟨η₂, hη₂, h2⟩ := ae_onSide_of_label hU hc hw hQ
  by_contra hcon
  obtain ⟨hx, hy⟩ := not_or.mp hcon
  -- the region on the side `σ` of `S(x)` and `τ` of `S(y)` near `w` would be null
  refine (hcross.volume_quadrant_pos σ τ (lt_min hη₁ hη₂)).ne' (measure_eq_zero_iff_ae_notMem.mpr ?_)
  filter_upwards [h1, h2] with z hz1 hz2 hzm
  obtain ⟨⟨hzb, hzσ⟩, hzτ⟩ := hzm
  rcases hcover (c z) with ⟨i, hi⟩ | ⟨j, hj⟩
  · exact hx ⟨i, hz1 (ball_subset_ball (min_le_left _ _) hzb) σ i hzσ hi.symm⟩
  · exact hy ⟨j, hz2 (ball_subset_ball (min_le_right _ _) hzb) τ j hzτ hj.symm⟩

/-- **One of the two points has an inner and an outer piece** (C124-FORCED-PIECES for any two finite families of
pieces whose labels are all the labels): otherwise one closed side of `S(w)` holds no piece of `x` and one holds no
piece of `y`, against the quadrant lemma at those two sides. -/
theorem exists_inner_outer_of_cover {U : Set ℂ} {c : ℂ → α} (hU : IsOpen U) (hc : AeProperOn U c) {x y w : ℂ}
    (hcross : CrossAt x y w) (hw : w ∈ U) {ι κ : Type*} [Finite ι] [Finite κ] {P : ι → Set ℂ} {a : ι → α}
    {Q : κ → Set ℂ} {b : κ → α} (hP : ∀ i, IsPieceAt U c x (P i) (a i)) (hQ : ∀ j, IsPieceAt U c y (Q j) (b j))
    (hcover : ∀ ℓ : α, (∃ i, a i = ℓ) ∨ ∃ j, b j = ℓ) :
    ((∃ i, InnerAt (P i) w) ∧ ∃ i, OuterAt (P i) w) ∨ ((∃ j, InnerAt (Q j) w) ∧ ∃ j, OuterAt (Q j) w) := by
  have h := exists_onSide_of_cover hU hc hcross hw hP hQ hcover
  have h1 := h .inside .inside
  have h2 := h .inside .outside
  have h3 := h .outside .inside
  have h4 := h .outside .outside
  simp only [onSide_inside, onSide_outside] at h1 h2 h3 h4
  by_cases hA : ∃ i, InnerAt (P i) w
  · by_cases hB : ∃ i, OuterAt (P i) w
    · exact Or.inl ⟨hA, hB⟩
    · exact Or.inr ⟨h3.resolve_left hB, h4.resolve_left hB⟩
  · exact Or.inr ⟨h1.resolve_left hA, h2.resolve_left hA⟩

/-- **A side of `S(y)` with no piece of `y` belongs to `x`**: if no piece of `y` is on the closed side `τ` of the unit
circle about `w`, then near `w`, on the side `τ` of the unit circle about `y`, almost every point on a side `σ` of
the unit circle about `x` has the label of a piece of `x` that is on the closed side `σ` of the unit circle about
`w`. -/
theorem ae_label_left_of_forall_not_onSide {U : Set ℂ} {c : ℂ → α} (hU : IsOpen U) (hc : AeProperOn U c)
    {x y w : ℂ} (hw : w ∈ U) {ι κ : Type*} [Finite ι] [Finite κ] {P : ι → Set ℂ} {a : ι → α} {Q : κ → Set ℂ}
    {b : κ → α} (hP : ∀ i, IsPieceAt U c x (P i) (a i)) (hQ : ∀ j, IsPieceAt U c y (Q j) (b j))
    (hcover : ∀ ℓ : α, (∃ i, a i = ℓ) ∨ ∃ j, b j = ℓ) {τ : CircleSide} (hτ : ∀ j, ¬ OnSide τ (Q j) w) :
    ∃ η > 0, ∀ᵐ z, z ∈ ball w η → z ∈ τ.region y → ∀ σ : CircleSide, z ∈ σ.region x →
      ∃ i, OnSide σ (P i) w ∧ c z = a i := by
  obtain ⟨η₁, hη₁, h1⟩ := ae_onSide_of_label hU hc hw hP
  obtain ⟨η₂, hη₂, h2⟩ := ae_onSide_of_label hU hc hw hQ
  refine ⟨min η₁ η₂, lt_min hη₁ hη₂, ?_⟩
  filter_upwards [h1, h2] with z hz1 hz2 hzb hzτ σ hzσ
  rcases hcover (c z) with ⟨i, hi⟩ | ⟨j, hj⟩
  · exact ⟨i, hz1 (ball_subset_ball (min_le_left _ _) hzb) σ i hzσ hi.symm, hi.symm⟩
  · exact absurd (hz2 (ball_subset_ball (min_le_right _ _) hzb) τ j hzτ hj.symm) (hτ j)

/-! ## One side of a circle filled by two labels: a second unit point -/

/-- **A tight pair on one side**: let the unit circles about `x` and `y` cross at `w ∈ U`. If near `w`, on the side
`τ` of the unit circle about `y`, almost every point has the label `a` inside the unit circle about `x` and `b`
outside it, then for a point `w' ≠ w` of the unit circle about `x`, as near `w` as wished, the pair `(x, w')` is
tight for `(a, b)`. No hypothesis on the colouring. -/
theorem exists_isTight_of_ae_side {U : Set ℂ} {c : ℂ → α} (hU : IsOpen U) {x y w : ℂ} (hcross : CrossAt x y w)
    (hw : w ∈ U) {a b : α} (hab : a ≠ b) {τ : CircleSide} {η : ℝ} (hη : 0 < η)
    (hin : ∀ᵐ z, z ∈ ball w η → z ∈ τ.region y → dist z x < 1 → c z = a)
    (hout : ∀ᵐ z, z ∈ ball w η → z ∈ τ.region y → 1 < dist z x → c z = b) {ρ : ℝ} (hρ : 0 < ρ) :
    ∃ w' ∈ sphere x 1, w' ≠ w ∧ dist w' w < ρ ∧ IsTight U c x w' a b := by
  obtain ⟨r₀, hr₀, hball⟩ := Metric.isOpen_iff.mp hU w hw
  have hr : 0 < min r₀ (min η ρ) := lt_min hr₀ (lt_min hη hρ)
  have hrη : min r₀ (min η ρ) ≤ η := (min_le_right _ _).trans (min_le_left _ _)
  have hrρ : min r₀ (min η ρ) ≤ ρ := (min_le_right _ _).trans (min_le_right _ _)
  -- a point of the unit circle about `x`, near `w`, on the side `τ` of the unit circle about `y`
  obtain ⟨w', hw'x, hw'b, hw'τ⟩ := hcross.exists_mem_sphere_region τ hr
  refine ⟨w', hw'x, ?_, lt_of_lt_of_le (mem_ball.mp hw'b) hrρ, ?_⟩
  · rintro rfl
    have h1 := CircleSide.mem_region_iff.mp hw'τ
    rw [hcross.right, sub_self, mul_zero] at h1
    exact lt_irrefl _ h1
  · refine isTight_of_ae_of_isOpen (V := ball w (min r₀ (min η ρ)) ∩ τ.region y)
      (by rw [dist_comm]; exact mem_sphere.mp hw'x) hab (isOpen_ball.inter (τ.isOpen_region y)) ⟨hw'b, hw'τ⟩
      (fun z hz => hball (ball_subset_ball (min_le_left _ _) hz.1)) ?_ ?_
    · filter_upwards [hin] with z hz hzV using hz (ball_subset_ball hrη hzV.1) hzV.2
    · filter_upwards [hout] with z hz hzV using hz (ball_subset_ball hrη hzV.1) hzV.2

/-- **Two unit points confine two pieces to opposite lenses**: let `A`, `B` be pieces at `x ∈ U` with labels `a`,
`b`, `A` inner and `B` outer at `w`, and let `(x, w')` be tight for `(a, b)` with `w' ≠ w`. Then inside a disc about
`x`, `A` lies in both closed unit discs, `B` is disjoint from both open unit discs, and their closures meet at `x`
only. (C124-CENTRE at the centre `x` with the far end `w'`; two different unit circles through `x` meet near `x` at
`x` only.) -/
theorem IsTight.closure_inter_closure_eq {U : Set ℂ} {c : ℂ → α} (hU : IsOpen U) (hc : AeProperOn U c)
    {x w w' : ℂ} (hx : x ∈ U) (hwx : dist w x = 1) (hne : w' ≠ w) {A B : Set ℂ} {a b : α}
    (hA : IsPieceAt U c x A a) (hB : IsPieceAt U c x B b) (hAi : InnerAt A w) (hBo : OuterAt B w)
    (ht : IsTight U c x w' a b) :
    ∃ η' > 0, A ∩ ball x η' ⊆ closedBall w 1 ∩ closedBall w' 1 ∧
      Disjoint (B ∩ ball x η') (ball w 1 ∪ ball w' 1) ∧ closure A ∩ closure B ∩ ball x η' = {x} := by
  obtain ⟨η, hη, hca, hcb⟩ := ht.ae_ne_centre hU hc hx
  have hxw' : dist x w' = 1 := by
    obtain ⟨ρ, hρ⟩ := ht
    exact hρ.dist_eq
  obtain ⟨η₂, hη₂, hsph⟩ := exists_ball_inter_spheres_subset (w := w) (w' := w') (x := x) hne.symm
    (by rw [dist_comm]; exact hwx) hxw'
  -- near `x` the piece `A` has no point strictly outside `S(w')`, and `B` none strictly inside
  have hAem : A ∩ (ball x η ∩ CircleSide.outside.region w') = ∅ :=
    hA.inter_eq_empty (isOpen_ball.inter (CircleSide.isOpen_region _ _)) (by
      filter_upwards [hca] with z hz hzm using hz hzm.1 (CircleSide.mem_region_outside.mp hzm.2))
  have hBem : B ∩ (ball x η ∩ CircleSide.inside.region w') = ∅ :=
    hB.inter_eq_empty (isOpen_ball.inter (CircleSide.isOpen_region _ _)) (by
      filter_upwards [hcb] with z hz hzm using hz hzm.1 (CircleSide.mem_region_inside.mp hzm.2))
  have hA' : ∀ z ∈ A, z ∈ ball x η → z ∈ closedBall w' 1 := by
    intro z hzA hzb
    by_contra hcon
    have hmem : z ∈ A ∩ (ball x η ∩ CircleSide.outside.region w') :=
      ⟨hzA, hzb, CircleSide.mem_region_outside.mpr (not_le.mp fun hle => hcon (mem_closedBall.mpr hle))⟩
    rw [hAem] at hmem
    exact hmem
  have hB' : ∀ z ∈ B, z ∈ ball x η → z ∉ ball w' 1 := by
    intro z hzB hzb hzw'
    have hmem : z ∈ B ∩ (ball x η ∩ CircleSide.inside.region w') :=
      ⟨hzB, hzb, CircleSide.mem_region_inside.mpr (mem_ball.mp hzw')⟩
    rw [hBem] at hmem
    exact hmem
  have hmin1 : min η η₂ ≤ η := min_le_left _ _
  have hmin2 : min η η₂ ≤ η₂ := min_le_right _ _
  refine ⟨min η η₂, lt_min hη hη₂, ?_, ?_, ?_⟩
  · exact fun z hz => ⟨hAi hz.1, hA' z hz.1 (ball_subset_ball hmin1 hz.2)⟩
  · refine Set.disjoint_left.mpr fun z hz hzu => ?_
    rcases hzu with hzw | hzw'
    · exact Set.disjoint_left.mp hBo hz.1 hzw
    · exact hB' z hz.1 (ball_subset_ball hmin1 hz.2) hzw'
  · refine Subset.antisymm ?_ ?_
    · rintro t ⟨⟨htA, htB⟩, htb⟩
      -- `t` is on `S(w)` and on `S(w')`, near `x`
      have h1 : t ∈ sphere w 1 := hAi.closure_inter_closure_subset hBo ⟨htA, htB⟩
      have hAi' : InnerAt (ball x (min η η₂) ∩ A) w' := fun z hz => hA' z hz.2 (ball_subset_ball hmin1 hz.1)
      have hBo' : OuterAt (ball x (min η η₂) ∩ B) w' :=
        Set.disjoint_left.mpr fun z hz hzw' => hB' z hz.2 (ball_subset_ball hmin1 hz.1) hzw'
      have h2 : t ∈ sphere w' 1 := hAi'.closure_inter_closure_subset hBo'
        ⟨isOpen_ball.inter_closure ⟨htb, htA⟩, isOpen_ball.inter_closure ⟨htb, htB⟩⟩
      exact hsph ⟨⟨h1, h2⟩, ball_subset_ball hmin2 htb⟩
    · rintro t ht
      rw [mem_singleton_iff] at ht
      rw [ht]
      exact ⟨⟨hA.mem_closure, hB.mem_closure⟩, mem_ball_self (lt_min hη hη₂)⟩

/-- **The second unit point** (the last clause of C124-LONE, for two pieces of one decomposition): let the unit
circles about `x` and `y` cross at `w ∈ U`, and let the piece `i` of `D` be inner and the piece `j` outer at `w`. If
near `w`, on a side `τ` of the unit circle about `y`, almost every point has the label of `i` inside the unit circle
about `x` and the label of `j` outside it, there are a point `w' ≠ w` of the unit circle about `x` and `η' > 0` such
that inside `ball x η'` the piece `i` lies in both closed unit discs, the piece `j` is disjoint from both open unit
discs, and their closures meet at `x` only. -/
theorem ThreePiece.exists_second_unit_point_of_ae_side {U : Set ℂ} {c : ℂ → α} (hU : IsOpen U)
    (hc : AeProperOn U c) {x y w : ℂ} (D : ThreePiece U c x) (hcross : CrossAt x y w) (hw : w ∈ U) {i j : Fin 3}
    (hi : InnerAt (D.piece i) w) (hj : OuterAt (D.piece j) w) {τ : CircleSide} {η : ℝ} (hη : 0 < η)
    (hin : ∀ᵐ z, z ∈ ball w η → z ∈ τ.region y → dist z x < 1 → c z = D.label i)
    (hout : ∀ᵐ z, z ∈ ball w η → z ∈ τ.region y → 1 < dist z x → c z = D.label j) :
    ∃ w' ∈ sphere x 1, w' ≠ w ∧ ∃ η' > 0,
      D.piece i ∩ ball x η' ⊆ closedBall w 1 ∩ closedBall w' 1 ∧
        Disjoint (D.piece j ∩ ball x η') (ball w 1 ∪ ball w' 1) ∧
        closure (D.piece i) ∩ closure (D.piece j) ∩ ball x η' = {x} := by
  have hij : i ≠ j := by
    rintro rfl
    exact not_innerAt_and_outerAt (D.isOpen_piece i) (D.isConnected_piece i).nonempty w ⟨hi, hj⟩
  obtain ⟨w', hw'x, hw'ne, -, ht⟩ :=
    exists_isTight_of_ae_side hU hcross hw (D.label_injective.ne hij) hη hin hout one_pos
  obtain ⟨η', hη', h1, h2, h3⟩ :=
    ht.closure_inter_closure_eq hU hc D.mem hcross.left hw'ne (D.isPieceAt i) (D.isPieceAt j) hi hj
  exact ⟨w', hw'x, hw'ne, η', hη', h1, h2, h3⟩

/-- **A filled side defeats fullness**: under the hypotheses of `ThreePiece.exists_second_unit_point_of_ae_side` the
edge of the pieces `i` and `j` is the point `x` near `x`, so the decomposition is not full. -/
theorem ThreePiece.not_isFull_of_ae_side {U : Set ℂ} {c : ℂ → α} (hU : IsOpen U) (hc : AeProperOn U c)
    {x y w : ℂ} (D : ThreePiece U c x) (hcross : CrossAt x y w) (hw : w ∈ U) {i j : Fin 3}
    (hi : InnerAt (D.piece i) w) (hj : OuterAt (D.piece j) w) {τ : CircleSide} {η : ℝ} (hη : 0 < η)
    (hin : ∀ᵐ z, z ∈ ball w η → z ∈ τ.region y → dist z x < 1 → c z = D.label i)
    (hout : ∀ᵐ z, z ∈ ball w η → z ∈ τ.region y → 1 < dist z x → c z = D.label j) : ¬ D.IsFull := by
  intro hfull
  have hij : i ≠ j := by
    rintro rfl
    exact not_innerAt_and_outerAt (D.isOpen_piece i) (D.isConnected_piece i).nonempty w ⟨hi, hj⟩
  obtain ⟨w', -, -, η', hη', -, -, h3⟩ :=
    D.exists_second_unit_point_of_ae_side hU hc hcross hw hi hj hη hin hout
  obtain ⟨t, ht, htd⟩ := Metric.mem_closure_iff.mp (hfull i j hij) η' hη'
  have hmem : t ∈ closure (D.piece i) ∩ closure (D.piece j) ∩ ball x η' :=
    ⟨ht.1.1, by rw [mem_ball, dist_comm]; exact htd⟩
  rw [h3] at hmem
  exact ht.2 hmem

/-- **One label cannot fill a side that the cover gives to it alone**: let `D` be a decomposition at `x`, the unit
circles about `x` and `y` crossing at `w ∈ U`. If near `w`, on a side `τ` of `S(y)`, almost every point on the side
`σ.flip` of `S(x)` has the label of the piece `j`, then some other piece is not on the closed side `σ` of `S(w)`.
(Otherwise the cover gives the side `σ.flip` of `S(w)` near `x` to the label of `j`,
`ThreePiece.ae_label_of_forall_onSide`; for a point `w' ≠ w` of `S(x)` near `w` on that side of `S(y)`,
`AeProperOn.ae_ne_of_ae_region` at the centre `x` with the far end `w'` takes that label off the side `σ` of `S(w')`
near `x`; and the circles `S(w)`, `S(w')` cross at `x`, so the region on the side `σ.flip` of the first and `σ` of
the second has positive measure there.) -/
theorem ThreePiece.exists_ne_not_onSide_of_ae_side {U : Set ℂ} {c : ℂ → α} (hU : IsOpen U) (hc : AeProperOn U c)
    {x y w : ℂ} (D : ThreePiece U c x) (hcross : CrossAt x y w) (hw : w ∈ U) {j : Fin 3} {σ τ : CircleSide} {η : ℝ}
    (hη : 0 < η) (hfill : ∀ᵐ z, z ∈ ball w η → z ∈ τ.region y → z ∈ σ.flip.region x → c z = D.label j) :
    ∃ i, i ≠ j ∧ ¬ OnSide σ (D.piece i) w := by
  by_contra hcon
  have hall : ∀ i, i ≠ j → OnSide σ (D.piece i) w := fun i hij => by
    by_contra h
    exact hcon ⟨i, hij, h⟩
  -- the cover gives the side `σ.flip` of `S(w)` near `x` to the label of `j`
  have hcov := D.ae_label_of_forall_onSide hall
  -- a point `w' ≠ w` of `S(x)` near `w` on the side `τ` of `S(y)`, and a disc about it where `hfill` speaks
  obtain ⟨r₀, hr₀, hball⟩ := Metric.isOpen_iff.mp hU w hw
  have hr : 0 < min r₀ (min η 1) := lt_min hr₀ (lt_min hη one_pos)
  obtain ⟨w', hw'x, hw'b, hw'τ⟩ := hcross.exists_mem_sphere_region τ hr
  have hw'ne : w' ≠ w := by
    rintro rfl
    have h1 := CircleSide.mem_region_iff.mp hw'τ
    rw [hcross.right, sub_self, mul_zero] at h1
    exact lt_irrefl _ h1
  obtain ⟨ρ, hρ, hρsub⟩ := Metric.isOpen_iff.mp (isOpen_ball.inter (τ.isOpen_region y)) w' ⟨hw'b, hw'τ⟩
  have hxw' : dist x w' = 1 := by
    rw [dist_comm]
    exact mem_sphere.mp hw'x
  -- one collar at the centre `x` with the far end `w'`: the label of `j` is off the side `σ` of `S(w')` near `x`
  obtain ⟨η₁, hη₁, hoff⟩ := hc.ae_ne_of_ae_region hU D.mem hxw' hρ
    (fun z hz => hball (ball_subset_ball (min_le_left _ _) (hρsub hz).1)) (σ := σ.flip) (a := D.label j) (by
      filter_upwards [hfill] with z hz hzb hzσ
      exact hz (ball_subset_ball ((min_le_right _ _).trans (min_le_left _ _)) (hρsub hzb).1) (hρsub hzb).2 hzσ)
  -- the unit circles about `w` and `w'` cross at `x`: the region on the side `σ.flip` of the first and `σ` of the
  -- second has positive measure in every disc about `x`
  have hww' : dist w w' < 2 := by
    have h1 := mem_ball.mp hw'b
    have h2 : min r₀ (min η 1) ≤ 1 := (min_le_right _ _).trans (min_le_right _ _)
    rw [dist_comm]
    linarith
  have hcr : CrossAt w w' x :=
    crossAt_of_dist_lt_two hw'ne.symm hww' (by rw [dist_comm]; exact hcross.left) hxw'
  obtain ⟨ε, hε, hεsub⟩ := Metric.mem_nhds_iff.mp D.nbhd_mem
  refine (hcr.volume_quadrant_pos σ.flip σ (lt_min hε hη₁)).ne' (measure_eq_zero_iff_ae_notMem.mpr ?_)
  filter_upwards [hcov, hoff] with z hz1 hz2 hzm
  obtain ⟨⟨hzb, hzw⟩, hzw'⟩ := hzm
  exact hz2 (ball_subset_ball (min_le_right _ _) hzb) (by rw [CircleSide.flip_flip]; exact hzw')
    (hz1 (hεsub (ball_subset_ball (min_le_left _ _) hzb)) hzw)

/-- Three different elements of `Fin 3` are the values at `0`, `1`, `2` of a permutation. -/
theorem exists_perm_fin_three {i j k : Fin 3} (hij : i ≠ j) (hik : i ≠ k) (hjk : j ≠ k) :
    ∃ σ : Equiv.Perm (Fin 3), σ 0 = i ∧ σ 1 = j ∧ σ 2 = k := by
  have hinj : ∀ i j k : Fin 3, i ≠ j → i ≠ k → j ≠ k → Function.Injective ![i, j, k] := by decide
  exact ⟨Equiv.ofBijective _ ((Fintype.bijective_iff_injective_and_card _).mpr ⟨hinj i j k hij hik hjk, rfl⟩),
    rfl, rfl, rfl⟩

/-- **An arc-edged member that separates at `w` saves `w`**: the edge of its inner and its outer piece lies on the
unit circle about `w` and contains an arc from the point, hence an arc of that circle from the point
(`ThreePiece.hasUnitArcFrom_of_arc_subset_sphere`). -/
theorem ThreePiece.HasArcEdges.saves_of_separatesAt {U : Set ℂ} {c : ℂ → α} {x w : ℂ} {D : ThreePiece U c x}
    (h : D.HasArcEdges) (hs : D.SeparatesAt w) : D.Saves w := by
  obtain ⟨i, j, hi, hj⟩ := hs
  have hij : i ≠ j := by
    rintro rfl
    exact not_innerAt_and_outerAt (D.isOpen_piece i) (D.isConnected_piece i).nonempty w ⟨hi, hj⟩
  obtain ⟨γ, hinj, h0, hγ⟩ := h i j hij
  exact ⟨i, j, hij, ThreePiece.hasUnitArcFrom_of_arc_subset_sphere γ hinj h0 hγ
    (hγ.trans (D.edge_subset_sphere hi hj))⟩

/-! ## The four statements at any label type, from the cover hypothesis -/

namespace ClosePair

variable {U : Set ℂ} {c : ℂ → α} {x y w : ℂ}

/-- C124-FORCED-PIECES from the cover hypothesis: one member separates. -/
theorem separatesAt_or (hU : IsOpen U) (hc : AeProperOn U c) (C : ClosePair U c x y) (hw : w ∈ U)
    (hwu : IsCommonUnitPoint x y w)
    (hcover : ∀ ℓ : α, (∃ i, C.left.label i = ℓ) ∨ ∃ j, C.right.label j = ℓ) :
    C.left.SeparatesAt w ∨ C.right.SeparatesAt w := by
  rcases exists_inner_outer_of_cover hU hc (C.crossAt hwu) hw C.left.isPieceAt C.right.isPieceAt hcover with
    ⟨⟨i, hi⟩, ⟨j, hj⟩⟩ | ⟨⟨i, hi⟩, ⟨j, hj⟩⟩
  · exact Or.inl ⟨i, j, hi, hj⟩
  · exact Or.inr ⟨i, j, hi, hj⟩

/-- C124-LONE from the cover hypothesis. -/
theorem lone_of_cover (hU : IsOpen U) (hc : AeProperOn U c) (C : ClosePair U c x y) (hw : w ∈ U)
    (hwu : IsCommonUnitPoint x y w)
    (hcover : ∀ ℓ : α, (∃ i, C.left.label i = ℓ) ∨ ∃ j, C.right.label j = ℓ) (hy : ¬ C.right.SeparatesAt w) :
    ∃ σ : Equiv.Perm (Fin 3), C.left.OneOfEach w σ ∧
      (∃ τ : CircleSide, ∃ η > 0,
        (∀ᵐ z, z ∈ ball w η → z ∈ τ.region y → dist z x < 1 → c z = C.left.label (σ 0)) ∧
          ∀ᵐ z, z ∈ ball w η → z ∈ τ.region y → 1 < dist z x → c z = C.left.label (σ 1)) ∧
      ∃ w' ∈ sphere x 1, w' ≠ w ∧ ∃ η' > 0,
        C.left.piece (σ 0) ∩ ball x η' ⊆ closedBall w 1 ∩ closedBall w' 1 ∧
          Disjoint (C.left.piece (σ 1) ∩ ball x η') (ball w 1 ∪ ball w' 1) ∧
          closure (C.left.piece (σ 0)) ∩ closure (C.left.piece (σ 1)) ∩ ball x η' = {x} := by
  have hcross := C.crossAt hwu
  -- a closed side `τ₀` of `S(w)` holds no piece of `y`: the side `τ₀` of `S(y)` near `w` belongs to `x`
  obtain ⟨τ₀, hτ₀⟩ := (C.right.not_separatesAt_iff w).mp hy
  obtain ⟨η, hη, hae⟩ :=
    ae_label_left_of_forall_not_onSide hU hc hw C.left.isPieceAt C.right.isPieceAt hcover hτ₀
  have hnio : ∀ i, ¬ (InnerAt (C.left.piece i) w ∧ OuterAt (C.left.piece i) w) := fun i =>
    not_innerAt_and_outerAt (C.left.isOpen_piece i) (C.left.isConnected_piece i).nonempty w
  -- each side of `S(x)` has positive measure there: `x` has an inner and an outer piece
  have hex : ∀ s : CircleSide, ∃ i, OnSide s (C.left.piece i) w := by
    intro s
    obtain ⟨z, hz, hzp⟩ := Measure.exists_mem_of_measure_ne_zero_of_ae
      (hcross.volume_quadrant_pos s τ₀ hη).ne' (ae_restrict_of_ae hae)
    obtain ⟨i, hi, -⟩ := hzp hz.1.1 hz.2 s hz.1.2
    exact ⟨i, hi⟩
  -- no closed side of `S(w)` holds all the pieces of `x` but one
  have hstar : ∀ (s : CircleSide) (j : Fin 3), ∃ i, i ≠ j ∧ ¬ OnSide s (C.left.piece i) w := by
    intro s j
    by_contra hcon
    have hall : ∀ i, i ≠ j → OnSide s (C.left.piece i) w := fun i hij => by
      by_contra h
      exact hcon ⟨i, hij, h⟩
    have hfill : ∀ᵐ z, z ∈ ball w η → z ∈ τ₀.region y → z ∈ s.flip.region x → c z = C.left.label j := by
      filter_upwards [hae] with z hz hzb hzτ hzs
      obtain ⟨i, hi, hci⟩ := hz hzb hzτ s.flip hzs
      by_cases hij : i = j
      · rw [hci, hij]
      · exfalso
        have h1 := hall i hij
        cases s
        · exact hnio i ⟨onSide_inside.mp h1, onSide_outside.mp hi⟩
        · exact hnio i ⟨onSide_inside.mp hi, onSide_outside.mp h1⟩
    obtain ⟨i, hij, hni⟩ := C.left.exists_ne_not_onSide_of_ae_side hU hc hcross hw hη hfill
    exact hni (hall i hij)
  obtain ⟨i₀, hi₀⟩ := hex .inside
  obtain ⟨j₀, hj₀⟩ := hex .outside
  rw [onSide_inside] at hi₀
  rw [onSide_outside] at hj₀
  obtain ⟨k₁, hk₁j, hk₁⟩ := hstar .inside j₀
  obtain ⟨k₂, hk₂i, hk₂⟩ := hstar .outside i₀
  rw [onSide_inside] at hk₁
  rw [onSide_outside] at hk₂
  have hi₀j₀ : i₀ ≠ j₀ := by
    rintro rfl
    exact hnio _ ⟨hi₀, hj₀⟩
  have hk₁i : k₁ ≠ i₀ := by
    rintro rfl
    exact hk₁ hi₀
  have hk₂j : k₂ ≠ j₀ := by
    rintro rfl
    exact hk₂ hj₀
  -- the third piece is neither inner nor outer: crossing
  have hthird : ∀ a b c d : Fin 3, a ≠ b → c ≠ a → c ≠ b → d ≠ a → d ≠ b → c = d := by decide
  have hk : k₁ = k₂ := hthird i₀ j₀ k₁ k₂ hi₀j₀ hk₁i hk₁j hk₂i hk₂j
  obtain ⟨σ, rfl, rfl, rfl⟩ := exists_perm_fin_three hi₀j₀ hk₁i.symm hk₁j.symm
  have hσ : C.left.OneOfEach w σ := ⟨hi₀, hj₀, hk₁, by rw [hk]; exact hk₂⟩
  -- on the side `τ₀` of `S(y)` near `w`: the inner label inside `S(x)`, the outer label outside it
  have hin : ∀ᵐ z, z ∈ ball w η → z ∈ τ₀.region y → dist z x < 1 → c z = C.left.label (σ 0) := by
    filter_upwards [hae] with z hz hzb hzτ hzx
    obtain ⟨i, hi, hci⟩ := hz hzb hzτ .inside (CircleSide.mem_region_inside.mpr hzx)
    rw [hci, ThreePiece.OneOfEach.eq_of_innerAt _ hσ (onSide_inside.mp hi)]
  have hout : ∀ᵐ z, z ∈ ball w η → z ∈ τ₀.region y → 1 < dist z x → c z = C.left.label (σ 1) := by
    filter_upwards [hae] with z hz hzb hzτ hzx
    obtain ⟨i, hi, hci⟩ := hz hzb hzτ .outside (CircleSide.mem_region_outside.mpr hzx)
    rw [hci, ThreePiece.OneOfEach.eq_of_outerAt _ hσ (onSide_outside.mp hi)]
  exact ⟨σ, hσ, ⟨τ₀, η, hη, hin, hout⟩,
    C.left.exists_second_unit_point_of_ae_side hU hc hcross hw hσ.1 hσ.2.1 hη hin hout⟩

/-- **A full member makes the other member separate** (the finer form of C124-BOTH's first clause): if `y` does not
separate at `w`, the inner and the outer piece of `x` meet at `x` only (`lone_of_cover`), so `x` is not full. -/
theorem separatesAt_right_of_isFull (hU : IsOpen U) (hc : AeProperOn U c) (C : ClosePair U c x y) (hw : w ∈ U)
    (hwu : IsCommonUnitPoint x y w)
    (hcover : ∀ ℓ : α, (∃ i, C.left.label i = ℓ) ∨ ∃ j, C.right.label j = ℓ) (hfx : C.left.IsFull) :
    C.right.SeparatesAt w := by
  by_contra hy
  obtain ⟨σ, hσ, ⟨τ, η, hη, hin, hout⟩, -⟩ := C.lone_of_cover hU hc hw hwu hcover hy
  exact C.left.not_isFull_of_ae_side hU hc (C.crossAt hwu) hw hσ.1 hσ.2.1 hη hin hout hfx

/-- **A full member keeps the other member's inner and outer labels present**: let each member have one inner, one
outer and one crossing piece at `w`, and let `y` be full. Then the labels of the inner and of the outer piece of `x`
are present at `w`. (If one of them were absent near `w`, its side of `S(x)` would be filled by the inner label of
`y` inside `S(y)` and the outer label of `y` outside it: `ThreePiece.not_isFull_of_ae_side` at `y`.) -/
theorem label_mem_presentAt_of_isFull_right (hU : IsOpen U) (hc : AeProperOn U c) (C : ClosePair U c x y)
    (hw : w ∈ U) (hwu : IsCommonUnitPoint x y w)
    (hcover : ∀ ℓ : α, (∃ i, C.left.label i = ℓ) ∨ ∃ j, C.right.label j = ℓ) (hfy : C.right.IsFull)
    {σ τ : Equiv.Perm (Fin 3)} (hσ : C.left.OneOfEach w σ) (hτ : C.right.OneOfEach w τ) :
    C.left.label (σ 0) ∈ presentAt U c w ∧ C.left.label (σ 1) ∈ presentAt U c w := by
  have hcross := C.crossAt hwu
  obtain ⟨r₀, hr₀, hball⟩ := Metric.isOpen_iff.mp hU w hw
  obtain ⟨η₁, hη₁, h1⟩ := ae_onSide_of_label hU hc hw C.left.isPieceAt
  obtain ⟨η₂, hη₂, h2⟩ := ae_onSide_of_label hU hc hw C.right.isPieceAt
  -- for a side `s` of `S(x)`: if one piece of `x` only is on the closed side `s` of `S(w)`, its label is present
  have key : ∀ (s : CircleSide) (i₀ : Fin 3), (∀ i, OnSide s (C.left.piece i) w → i = i₀) →
      C.left.label i₀ ∈ presentAt U c w := by
    intro s i₀ huniq
    by_contra habs
    obtain ⟨η₀, hη₀, h0⟩ := not_mem_presentAt_iff.mp habs
    obtain ⟨η, hη, hle0, hler, hle1, hle2⟩ : ∃ η > 0, η ≤ η₀ ∧ η ≤ r₀ ∧ η ≤ η₁ ∧ η ≤ η₂ :=
      ⟨min (min η₀ r₀) (min η₁ η₂), lt_min (lt_min hη₀ hr₀) (lt_min hη₁ hη₂),
        (min_le_left _ _).trans (min_le_left _ _), (min_le_left _ _).trans (min_le_right _ _),
        (min_le_right _ _).trans (min_le_left _ _), (min_le_right _ _).trans (min_le_right _ _)⟩
    -- with that label absent, the side `s` of `S(x)` near `w` belongs to `y`, by sides of `S(y)`
    have hy : ∀ᵐ z, z ∈ ball w η → z ∈ s.region x → ∀ t : CircleSide, z ∈ t.region y →
        ∃ j, OnSide t (C.right.piece j) w ∧ c z = C.right.label j := by
      filter_upwards [h0, h1, h2] with z hz0 hz1 hz2 hzb hzs t hzt
      rcases hcover (c z) with ⟨i, hi⟩ | ⟨j, hj⟩
      · exfalso
        have hii := huniq i (hz1 (ball_subset_ball hle1 hzb) s i hzs hi.symm)
        exact hz0 (hball (ball_subset_ball hler hzb)) (ball_subset_ball hle0 hzb) (by rw [← hi, hii])
      · exact ⟨j, hz2 (ball_subset_ball hle2 hzb) t j hzt hj.symm, hj.symm⟩
    have hin : ∀ᵐ z, z ∈ ball w η → z ∈ s.region x → dist z y < 1 → c z = C.right.label (τ 0) := by
      filter_upwards [hy] with z hz hzb hzs hzy
      obtain ⟨j, hj, hcj⟩ := hz hzb hzs .inside (CircleSide.mem_region_inside.mpr hzy)
      rw [hcj, ThreePiece.OneOfEach.eq_of_innerAt _ hτ (onSide_inside.mp hj)]
    have hout : ∀ᵐ z, z ∈ ball w η → z ∈ s.region x → 1 < dist z y → c z = C.right.label (τ 1) := by
      filter_upwards [hy] with z hz hzb hzs hzy
      obtain ⟨j, hj, hcj⟩ := hz hzb hzs .outside (CircleSide.mem_region_outside.mpr hzy)
      rw [hcj, ThreePiece.OneOfEach.eq_of_outerAt _ hτ (onSide_outside.mp hj)]
    exact C.right.not_isFull_of_ae_side hU hc hcross.symm hw hτ.1 hτ.2.1 hη hin hout hfy
  exact ⟨key .inside (σ 0) fun i hi => ThreePiece.OneOfEach.eq_of_innerAt _ hσ (onSide_inside.mp hi),
    key .outside (σ 1) fun i hi => ThreePiece.OneOfEach.eq_of_outerAt _ hσ (onSide_outside.mp hi)⟩

/-- C124-FOUR from the cover hypothesis: the crossing labels are almost nowhere near `w`
(`IsPieceAt.ae_ne_of_crossingAt`), every other label is one of the four, and each of the four is present
(`label_mem_presentAt_of_isFull_right`, for the pair and for the pair in the other order). -/
theorem presentAt_eq (hU : IsOpen U) (hc : AeProperOn U c) (C : ClosePair U c x y) (hw : w ∈ U)
    (hwu : IsCommonUnitPoint x y w)
    (hcover : ∀ ℓ : α, (∃ i, C.left.label i = ℓ) ∨ ∃ j, C.right.label j = ℓ) (hfx : C.left.IsFull)
    (hfy : C.right.IsFull) {σ τ : Equiv.Perm (Fin 3)} (hσ : C.left.OneOfEach w σ) (hτ : C.right.OneOfEach w τ) :
    presentAt U c w = {C.left.label (σ 0), C.left.label (σ 1), C.right.label (τ 0), C.right.label (τ 1)} := by
  have hk : ∀ k : Fin 3, k = 0 ∨ k = 1 ∨ k = 2 := by decide
  ext ℓ
  simp only [mem_insert_iff, mem_singleton_iff]
  constructor
  · intro hℓ
    rcases hcover ℓ with ⟨i, rfl⟩ | ⟨j, rfl⟩
    · obtain ⟨k, rfl⟩ := σ.surjective i
      rcases hk k with rfl | rfl | rfl
      · exact Or.inl rfl
      · exact Or.inr (Or.inl rfl)
      · exfalso
        obtain ⟨η, hη, h⟩ := (C.left.isPieceAt (σ 2)).ae_ne_of_crossingAt hU hc hw hσ.2.2
        exact not_mem_presentAt_of_ae_ne hη h hℓ
    · obtain ⟨k, rfl⟩ := τ.surjective j
      rcases hk k with rfl | rfl | rfl
      · exact Or.inr (Or.inr (Or.inl rfl))
      · exact Or.inr (Or.inr (Or.inr rfl))
      · exfalso
        obtain ⟨η, hη, h⟩ := (C.right.isPieceAt (τ 2)).ae_ne_of_crossingAt hU hc hw hτ.2.2
        exact not_mem_presentAt_of_ae_ne hη h hℓ
  · have hx := C.label_mem_presentAt_of_isFull_right hU hc hw hwu hcover hfy hσ hτ
    have hy := C.symm.label_mem_presentAt_of_isFull_right hU hc hw hwu.symm (fun ℓ => (hcover ℓ).symm) hfx hτ hσ
    rintro (rfl | rfl | rfl | rfl)
    · exact hx.1
    · exact hx.2
    · exact hy.1
    · exact hy.2

/-- The two inner and the two outer labels are four different labels. -/
theorem ncard_inner_outer (C : ClosePair U c x y) (σ τ : Equiv.Perm (Fin 3)) :
    ({C.left.label (σ 0), C.left.label (σ 1), C.right.label (τ 0), C.right.label (τ 1)} : Set α).ncard = 4 := by
  have hab : C.left.label (σ 0) ≠ C.left.label (σ 1) := C.left.label_injective.ne (σ.injective.ne (by decide))
  have hcd : C.right.label (τ 0) ≠ C.right.label (τ 1) := C.right.label_injective.ne (τ.injective.ne (by decide))
  have h1 : C.left.label (σ 1) ∉ ({C.right.label (τ 0), C.right.label (τ 1)} : Set α) := by
    simp only [mem_insert_iff, mem_singleton_iff, not_or]
    exact ⟨C.label_ne _ _, C.label_ne _ _⟩
  have h0 : C.left.label (σ 0) ∉
      ({C.left.label (σ 1), C.right.label (τ 0), C.right.label (τ 1)} : Set α) := by
    simp only [mem_insert_iff, mem_singleton_iff, not_or]
    exact ⟨hab, C.label_ne _ _, C.label_ne _ _⟩
  rw [Set.ncard_insert_of_notMem h0, Set.ncard_insert_of_notMem h1, Set.ncard_pair hcd]

end ClosePair

/-! ## The claims, at six colours -/

/-- **C124-FORCED-PIECES** (`data/fs124/claims-K2.md`): "Let c be a weak six-colouring of U, (x, y) a close
complementary pair of three-piece points, each with a decomposition, and w a common unit point of the pair lying in
U. Then x or y separates at w: one of its pieces lies in the closed unit disc about w and another is disjoint from
the open unit disc about w; the edge of those two pieces lies on S(w)."

Clause by clause: `hU`, `hc`; `C` (the pair with its two decompositions); `hw`, `hwu`; the disjunction is
"x or y separates" with its two pieces `i` (inner) and `j` (outer) named, and their edge on the unit circle. **The
number six is spent in `ClosePair.exists_label_eq`**, and nowhere else: `ClosePair.separatesAt_or` is the statement at
any label type whose labels are all carried by the six pieces. The cover clause of the two decompositions
(`null_diff`) is not read. Inhabitant of the hypotheses: `exists_closePair_not_separatesAt`
(`Plane/ClosePairModel`). -/
theorem closePair_forced_pieces {U : Set ℂ} {c : ℂ → Fin 6} (hU : IsOpen U) (hc : IsWeakColouringOn U c) {x y w : ℂ}
    (C : ClosePair U c x y) (hw : w ∈ U) (hwu : IsCommonUnitPoint x y w) :
    (∃ i j, InnerAt (C.left.piece i) w ∧ OuterAt (C.left.piece j) w ∧ C.left.edge i j ⊆ sphere w 1) ∨
      ∃ i j, InnerAt (C.right.piece i) w ∧ OuterAt (C.right.piece j) w ∧ C.right.edge i j ⊆ sphere w 1 := by
  rcases C.separatesAt_or hU hc.aeProperOn hw hwu C.exists_label_eq with ⟨i, j, hi, hj⟩ | ⟨i, j, hi, hj⟩
  · exact Or.inl ⟨i, j, hi, hj, C.left.edge_subset_sphere hi hj⟩
  · exact Or.inr ⟨i, j, hi, hj, C.right.edge_subset_sphere hi hj⟩

/-- **C124-LONE** (`data/fs124/claims-K2.md`): "In the setting of C124-FORCED-PIECES suppose y does not separate at
w. Then x has exactly one inner piece, one outer piece and one crossing piece at w, with labels a and b for the inner
and the outer one; there are a side of S(y) and η > 0 such that almost every point of B(w, η) on that side has the
label a if it lies inside S(x) and the label b if it lies outside S(x); and there are a point w′ ≠ w of S(x) and
η′ > 0 such that inside B(x, η′) the inner piece lies in B̄(w, 1) ∩ B̄(w′, 1), the outer piece is disjoint from
B(w, 1) ∪ B(w′, 1), and their closures meet at x only."

Clause by clause: `σ` names the inner piece `σ 0`, the outer piece `σ 1` and the crossing piece `σ 2`
(`ThreePiece.OneOfEach`: one of each, since `σ` is a bijection and the three kinds exclude one another); `a`, `b` are
`C.left.label (σ 0)`, `C.left.label (σ 1)`; `τ` is the side of `S(y)`; `w'`, `η'` and the three conclusions inside
`ball x η'`. The number six is spent in `ClosePair.exists_label_eq` only (`ClosePair.lone_of_cover`). Inhabitant of
the hypotheses: `exists_closePair_not_separatesAt` (`Plane/ClosePairModel`). -/
theorem closePair_lone {U : Set ℂ} {c : ℂ → Fin 6} (hU : IsOpen U) (hc : IsWeakColouringOn U c) {x y w : ℂ}
    (C : ClosePair U c x y) (hw : w ∈ U) (hwu : IsCommonUnitPoint x y w)
    (hy : ¬ C.right.SeparatesAt w) :
    ∃ σ : Equiv.Perm (Fin 3), C.left.OneOfEach w σ ∧
      (∃ τ : CircleSide, ∃ η > 0,
        (∀ᵐ z, z ∈ ball w η → z ∈ τ.region y → dist z x < 1 → c z = C.left.label (σ 0)) ∧
          ∀ᵐ z, z ∈ ball w η → z ∈ τ.region y → 1 < dist z x → c z = C.left.label (σ 1)) ∧
      ∃ w' ∈ sphere x 1, w' ≠ w ∧ ∃ η' > 0,
        C.left.piece (σ 0) ∩ ball x η' ⊆ closedBall w 1 ∩ closedBall w' 1 ∧
          Disjoint (C.left.piece (σ 1) ∩ ball x η') (ball w 1 ∪ ball w' 1) ∧
          closure (C.left.piece (σ 0)) ∩ closure (C.left.piece (σ 1)) ∩ ball x η' = {x} := by
  exact C.lone_of_cover hU hc.aeProperOn hw hwu C.exists_label_eq hy

/-- **C124-BOTH**, first clause (`data/fs124/claims-K2.md`): "In the setting of C124-FORCED-PIECES, if x and y are
full, both separate at w."

Each member's fullness makes the **other** member separate (`ClosePair.separatesAt_right_of_isFull`). Inhabitant of
the hypotheses: `exists_closePair_full` (`Plane/ClosePairModel`). -/
theorem closePair_both_separate {U : Set ℂ} {c : ℂ → Fin 6} (hU : IsOpen U) (hc : IsWeakColouringOn U c) {x y w : ℂ}
    (C : ClosePair U c x y) (hw : w ∈ U) (hwu : IsCommonUnitPoint x y w) (hfx : C.left.IsFull)
    (hfy : C.right.IsFull) : C.left.SeparatesAt w ∧ C.right.SeparatesAt w := by
  exact ⟨C.symm.separatesAt_right_of_isFull hU hc.aeProperOn hw hwu.symm (fun ℓ => (C.exists_label_eq ℓ).symm) hfy,
    C.separatesAt_right_of_isFull hU hc.aeProperOn hw hwu C.exists_label_eq hfx⟩

/-- **C124-BOTH**, second clause (`data/fs124/claims-K2.md`): "If they are sector points, each has an edge that
contains an arc of S(w) with an end at the member: no common unit point of a close complementary pair of sector
points is saved by one member alone."

**Stated for what the clause reads of a sector point**: a decomposition with arc edges (`ThreePiece.HasArcEdges` —
every edge contains an arc from the point). `D.Saves w`: some edge contains an arc of the unit circle about `w` with
an end at the point. An arc-edged member is full, so both separate (`closePair_both_separate`); the edge of the inner and the
outer piece lies on `S(w)` and contains an arc from the point, and an arc on a circle from a point contains an arc of
the circle from it (`ThreePiece.hasUnitArcFrom_of_arc_subset_sphere`). The clause in the claim list's own words, for
its sector points, is `closePair_both_saved_of_isSector` (`Plane/SectorPoint`), over one fact of plane topology: the
three-arcs lemma (`IsTriodCut.exists_arc`, `Plane/ThreeArcs`). Inhabitant of the hypotheses: `exists_closePair_full`
(`Plane/ClosePairModel`), whose members' edges are two radii and an arc of the unit circle about the common unit
point, by construction (`squarePair`, `Plane/ClosePairWitness`). -/
theorem closePair_both_saved {U : Set ℂ} {c : ℂ → Fin 6} (hU : IsOpen U) (hc : IsWeakColouringOn U c) {x y w : ℂ}
    (C : ClosePair U c x y) (hw : w ∈ U) (hwu : IsCommonUnitPoint x y w) (hax : C.left.HasArcEdges)
    (hay : C.right.HasArcEdges) : C.left.Saves w ∧ C.right.Saves w := by
  obtain ⟨hsx, hsy⟩ := closePair_both_separate hU hc C hw hwu hax.isFull hay.isFull
  exact ⟨hax.saves_of_separatesAt hsx, hay.saves_of_separatesAt hsy⟩

/-- **C124-FOUR** (`data/fs124/claims-K2.md`): "In the setting of C124-FORCED-PIECES let x and y be full, each with
exactly one inner piece, one outer piece and one crossing piece at w. Then exactly four labels are present at w:
those of the two inner and the two outer pieces."

The labels present at `w` are the set of the four named labels, and that set has four elements. The number six is
spent in `ClosePair.exists_label_eq` only (`ClosePair.presentAt_eq`). Inhabitant of the hypotheses:
`exists_closePair_full` (`Plane/ClosePairModel`). -/
theorem closePair_four {U : Set ℂ} {c : ℂ → Fin 6} (hU : IsOpen U) (hc : IsWeakColouringOn U c) {x y w : ℂ}
    (C : ClosePair U c x y) (hw : w ∈ U) (hwu : IsCommonUnitPoint x y w) (hfx : C.left.IsFull)
    (hfy : C.right.IsFull) {σ τ : Equiv.Perm (Fin 3)} (hσ : C.left.OneOfEach w σ) (hτ : C.right.OneOfEach w τ) :
    presentAt U c w = {C.left.label (σ 0), C.left.label (σ 1), C.right.label (τ 0), C.right.label (τ 1)} ∧
      (presentAt U c w).ncard = 4 := by
  have h := C.presentAt_eq hU hc.aeProperOn hw hwu C.exists_label_eq hfx hfy hσ hτ
  exact ⟨h, by rw [h]; exact C.ncard_inner_outer σ τ⟩

/-! ## Spec examples -/

/-- **Adversary** for the definition of a close pair: no point is a close pair with itself. -/
example (U : Set ℂ) (c : ℂ → α) (x : ℂ) : IsEmpty (ClosePair U c x x) :=
  ⟨fun C => C.ne rfl⟩

/-- The common unit points of `0` and `1 − i` are `1` and `−i`. -/
example : IsCommonUnitPoint (0 : ℂ) (1 - I) 1 ∧ IsCommonUnitPoint (0 : ℂ) (1 - I) (-I) := by
  refine ⟨⟨by simp, ?_⟩, ⟨by simp, ?_⟩⟩
  · rw [dist_eq_norm, show (1 : ℂ) - (1 - I) = I by ring, Complex.norm_I]
  · rw [dist_eq_norm, show -I - (1 - I) = -1 by ring, norm_neg, norm_one]

/-- **Adversary**: `2` is not a common unit point of `0` and `1 − i`. -/
example : ¬ IsCommonUnitPoint (0 : ℂ) (1 - I) 2 := by
  rintro ⟨h, -⟩
  rw [dist_zero_right, Complex.norm_ofNat] at h
  norm_num at h

/-- `presentAt` on a constant colouring: the one label is present at every point of an open set, and no other. -/
example {U : Set ℂ} (hU : IsOpen U) {w : ℂ} (hw : w ∈ U) : presentAt U (fun _ => (0 : Fin 2)) w = {0} := by
  ext i
  rw [mem_presentAt_iff, mem_singleton_iff]
  constructor
  · intro h
    by_contra hi
    have he : (fun _ : ℂ => (0 : Fin 2)) ⁻¹' {i} = ∅ := by
      ext z
      simp [Ne.symm hi]
    have h1 := h 1 one_pos
    rw [he, inter_empty, empty_inter, measure_empty] at h1
    exact lt_irrefl _ h1
  · rintro rfl r hr
    have he : (fun _ : ℂ => (0 : Fin 2)) ⁻¹' {0} = univ := by
      ext z
      simp
    rw [he, inter_univ]
    exact (hU.inter isOpen_ball).measure_pos volume ⟨w, hw, mem_ball_self hr⟩

end HadwigerNelson.Plane

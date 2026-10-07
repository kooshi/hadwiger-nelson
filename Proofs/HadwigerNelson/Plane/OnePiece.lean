import Proofs.HadwigerNelson.Plane.Radius
import Proofs.HadwigerNelson.Plane.CircleCrossing

/-!
# What one open piece of a colour forces at distance 1 (FS-124, second module)

Claims **C124-SHADOW-OPEN**, **C124-TYPE**, **C124-CENTRE-HALF**, **C124-CENTRE** and **C124-STRADDLE** of
`data/fs124/claims-K2.md` (plan: `plans/FS124-kernel-plan-2.md`). Nothing here rests on a declared outside theorem.

The colouring is `c : ℂ → α`, proper at almost every unit pair of `U` (`AeProperOn U c`, `Plane/WeakColouringOn`).
**No statement of this module reads measurability of `c` or finiteness of the label type**: each is proved for
`AeProperOn` at any label type, and the claim list's form — a weak `k`-colouring — is the corollary under it.
"Almost every point of `W` has the label `i`" is `∀ᵐ z, z ∈ W → c z = i`.

* `AeProperOn.ae_unitShadow_ne` — **the shadow**: if `W ⊆ U` is open and almost every point of `W` has the label
  `i`, almost every point of `U` at distance exactly `1` from a point of `W` (`unitShadow W`, `Plane/Cover`) has a
  label other than `i`. One Fubini slice: the pairs from a point of label `i` into `W` are null, and from a point of
  the shadow the directions into `W` are a non-empty open set of angles. `shadow_open` is C124-SHADOW-OPEN.
* `mem_unitShadow_of_isPreconnected` — a preconnected set with a point strictly inside and a point strictly outside
  the unit circle about `z` has a point on it (`preconnected_dist_lt_or_gt`).
* `IsPieceAt U c x P i` — **a piece of label `i` at `x`**: `P ⊆ U` open and preconnected, `x` in its closure, almost
  every point of `P` of label `i`. `OnSide σ P w` — `P` lies on the closed side `σ` of the unit circle about `w`:
  `InnerAt P w` is `P ⊆ closedBall w 1`, `OuterAt P w` is `Disjoint P (ball w 1)`, `CrossingAt P w` is neither.
* `IsPieceAt.ae_ne_region` — **the type of a piece** (C124-TYPE, both clauses in one): a piece at `x` that is **not**
  on the side `σ` of the unit circle about `w` has its label almost nowhere on the side `σ` of the unit circle about
  `x`, near `w`. The two circles change roles: where the piece lies with respect to `S(w)` decides where its label may
  lie with respect to `S(x)`. `piece_type` is the claim in its words.
* `AeProperOn.ae_ne_of_ae_region` — C124-CENTRE-HALF in one clause, by the type of the disc tangent to `S(q)` at
  `z`; `centre_half` in the claim's words.
* `IsTight U c q z a b` — the pair `(q, z)` is tight for `(a, b)`; `innerCollar`, `outerCollar`. `tight_centre`
  (C124-CENTRE) and `tight_straddle` (C124-STRADDLE).

**Inhabitant** of every hypothesis here at once: `tightModel` on `tightModelDom` — three discs of radius `1/10` about
`0`, `1` and `1 + i`; about `1` the label is `0` inside the unit circle about `0` and `1` outside it; elsewhere `2`.
The pair `(0, 1)` is tight for `(0, 1)` (`isTight_tightModel`), and `1 + i` is a point of the unit circle about `1`
other than `0` and its antipode `2`.
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Metric

variable {α : Type*} {k : ℕ}

/-! ## The shadow of an open set of one label -/

open scoped Pointwise in
/-- The unit shadow of an open set is open: it is the union of the translates of the set by the unit vectors. -/
theorem isOpen_unitShadow {W : Set ℂ} (hW : IsOpen W) : IsOpen (unitShadow W) := by
  have h : unitShadow W = sphere (0 : ℂ) 1 + W := by
    ext z
    simp only [unitShadow, mem_setOf_eq, Set.mem_add, mem_sphere_iff_norm, sub_zero]
    constructor
    · rintro ⟨y, hy, hd⟩
      exact ⟨z - y, by rw [← dist_eq_norm]; exact hd, y, hy, by ring⟩
    · rintro ⟨u, hu, y, hy, rfl⟩
      exact ⟨y, hy, by rw [dist_eq_norm, add_sub_cancel_right]; exact hu⟩
  rw [h]
  exact hW.add_left

/-- The unit shadow is monotone. -/
theorem unitShadow_mono {V W : Set ℂ} (h : V ⊆ W) : unitShadow V ⊆ unitShadow W := by
  exact fun z ⟨y, hy, hd⟩ => ⟨y, h hy, hd⟩

/-- A point is in the unit shadow of `W` exactly when some direction from it lands in `W`. -/
theorem mem_unitShadow_iff_exists_e {W : Set ℂ} {z : ℂ} : z ∈ unitShadow W ↔ ∃ θ : ℝ, z + e θ ∈ W := by
  constructor
  · rintro ⟨y, hy, hd⟩
    obtain ⟨θ, -, hθ⟩ := exists_angle_of_norm_eq_one (z := y - z) (by rw [← dist_eq_norm, dist_comm]; exact hd)
    exact ⟨θ, by rw [← hθ, add_sub_cancel]; exact hy⟩
  · rintro ⟨θ, hθ⟩
    exact ⟨z + e θ, hθ, by rw [dist_eq_norm, sub_add_cancel_left, norm_neg, norm_e]⟩

/-- **A preconnected set with a point strictly inside and a point strictly outside the unit circle about `z` has a
point on it.** -/
theorem mem_unitShadow_of_isPreconnected {P : Set ℂ} (hP : IsPreconnected P) {z y₀ y₁ : ℂ} (h₀ : y₀ ∈ P)
    (h₁ : y₁ ∈ P) (hin : dist y₀ z < 1) (hout : 1 < dist y₁ z) : z ∈ unitShadow P := by
  by_contra hz
  have hne : ∀ s ∈ P, dist z s ≠ 1 := fun s hs h => hz ⟨s, hs, h⟩
  rcases preconnected_dist_lt_or_gt hP hne with h | h
  · exact absurd (h y₁ h₁) (by rw [dist_comm]; exact not_lt.mpr hout.le)
  · exact absurd (h y₀ h₀) (by rw [dist_comm]; exact not_lt.mpr hin.le)

/-- **The shadow** (the core of C124-SHADOW-OPEN): if `c` is proper at almost every unit pair of `U`, `W ⊆ U` is open
and almost every point of `W` has the label `i`, then almost every point of `U` at distance exactly `1` from a point
of `W` has a label other than `i`. No measurability of `c`, no openness of `U`, any label type. -/
theorem AeProperOn.ae_unitShadow_ne {U : Set ℂ} {c : ℂ → α} (hc : AeProperOn U c) {W : Set ℂ} (hW : IsOpen W)
    (hWU : W ⊆ U) {i : α} (hi : ∀ᵐ z, z ∈ W → c z = i) : ∀ᵐ z, z ∈ U ∩ unitShadow W → c z ≠ i := by
  -- the pairs from a point of `U` of label `i` into `W` are null: monochromatic, or the far end is off its label
  have hN : (volume : Measure ℂ) {z | ¬ (z ∈ W → c z = i)} = 0 := ae_iff.mp hi
  have hM := (measurePreserving_motionMul_right (1, 0)).quasiMeasurePreserving.preimage_null
    (show (volume : Measure (ℂ × ℝ)) ({z | ¬ (z ∈ W → c z = i)} ×ˢ (univ : Set ℝ)) = 0 by
      rw [Measure.volume_eq_prod, Measure.prod_prod, hN, zero_mul])
  have hT : (volume : Measure (ℂ × ℝ)) {q | q.1 ∈ U ∧ c q.1 = i ∧ q.1 + e q.2 ∈ W} = 0 := by
    refine measure_mono_null (fun q hq => ?_) (measure_union_null (aeProperOn_iff_volume.mp hc) hM)
    obtain ⟨h1, h2, h3⟩ := hq
    by_cases h4 : c (q.1 + e q.2) = i
    · exact Or.inl ⟨h1, hWU h3, h2.trans h4.symm⟩
    · refine Or.inr ?_
      show motionMul q (1, 0) ∈ {z | ¬ (z ∈ W → c z = i)} ×ˢ (univ : Set ℝ)
      refine ⟨?_, mem_univ _⟩
      simp only [motionMul, rigidMotion, mul_one, mem_setOf_eq, Classical.not_imp]
      exact ⟨h3, h4⟩
  rw [Measure.volume_eq_prod] at hT
  -- so for almost every point the directions from it into `W` are null, if it lies in `U` with the label `i`
  have hsl := Measure.measure_ae_null_of_prod_null hT
  filter_upwards [hsl] with z hz hzU hzi
  obtain ⟨hzU, y, hyW, hzy⟩ := hzU
  -- from a point of the shadow the directions into `W` are a non-empty open set of angles
  have hopen : IsOpen {θ : ℝ | z + e θ ∈ W} := hW.preimage (continuous_const.add continuous_e)
  obtain ⟨θ₀, -, hθ₀⟩ := exists_angle_of_norm_eq_one (z := y - z)
    (by rw [← dist_eq_norm, dist_comm]; exact hzy)
  have hne : {θ : ℝ | z + e θ ∈ W}.Nonempty := ⟨θ₀, by
    show z + e θ₀ ∈ W
    rw [← hθ₀]; simpa using hyW⟩
  have hpos := hopen.measure_pos volume hne
  have hsub : {θ : ℝ | z + e θ ∈ W} ⊆
      Prod.mk z ⁻¹' {q : ℂ × ℝ | q.1 ∈ U ∧ c q.1 = i ∧ q.1 + e q.2 ∈ W} := fun θ hθ => ⟨hzU, hzi, hθ⟩
  exact hpos.ne' (measure_mono_null hsub hz)

/-- **C124-SHADOW-OPEN** (`data/fs124/claims-K2.md`): "Let U be an open set of the plane, c a measurable map from U
to a finite set of labels with c(z) ≠ c(z + u) for almost every pair of a point z of U and a unit vector u with z + u
in U, i a label, and W an open subset of U almost every point of which has the label i. Then the set of points of U
at distance exactly 1 from some point of W is open, and almost every point of it has a label other than i."

Clause by clause: `hU`; `hc` (a weak `k`-colouring of `U`, the finite set of labels being `Fin k`); `hW`, `hWU`, `hi`;
the set is `U ∩ unitShadow W`. The second clause holds with no measurability of `c` and for any label type
(`AeProperOn.ae_unitShadow_ne`). Inhabitant of the hypotheses: `tightModel` on `tightModelDom` with `W` the disc
about `0` and `i = 2` (the spec example below). -/
theorem shadow_open {U : Set ℂ} {c : ℂ → Fin k} (hU : IsOpen U) (hc : IsWeakColouringOn U c) {W : Set ℂ}
    (hW : IsOpen W) (hWU : W ⊆ U) {i : Fin k} (hi : ∀ᵐ z, z ∈ W → c z = i) :
    IsOpen (U ∩ unitShadow W) ∧ ∀ᵐ z, z ∈ U ∩ unitShadow W → c z ≠ i := by
  exact ⟨hU.inter (isOpen_unitShadow hW), hc.aeProperOn.ae_unitShadow_ne hW hWU hi⟩

/-- An open set almost every point of which satisfies a property that fails at almost every point of it is empty:
the two-label form. -/
theorem eq_empty_of_isOpen_of_ae {c : ℂ → α} {W : Set ℂ} (hW : IsOpen W) {i : α} (h₁ : ∀ᵐ z, z ∈ W → c z = i)
    (h₂ : ∀ᵐ z, z ∈ W → c z ≠ i) : W = ∅ := by
  by_contra hne
  have hnull : volume W = 0 := by
    rw [measure_eq_zero_iff_ae_notMem]
    filter_upwards [h₁, h₂] with z hz₁ hz₂ hzW using hz₂ hzW (hz₁ hzW)
  exact (hW.measure_pos volume (nonempty_iff_ne_empty.mpr hne)).ne' hnull

/-! ## Pieces, and the side of a circle a set lies on -/

/-- `P` is **inner at `w`**: it lies in the closed unit disc about `w`. -/
def InnerAt (P : Set ℂ) (w : ℂ) : Prop := P ⊆ closedBall w 1

/-- `P` is **outer at `w`**: it is disjoint from the open unit disc about `w`. -/
def OuterAt (P : Set ℂ) (w : ℂ) : Prop := Disjoint P (ball w 1)

/-- `P` is **crossing at `w`**: neither inner nor outer. -/
def CrossingAt (P : Set ℂ) (w : ℂ) : Prop := ¬ InnerAt P w ∧ ¬ OuterAt P w

/-- `P` lies on the closed side `σ` of the unit circle about `w`: inner for the inside, outer for the outside. -/
def OnSide (σ : CircleSide) (P : Set ℂ) (w : ℂ) : Prop :=
  match σ with
  | .inside => InnerAt P w
  | .outside => OuterAt P w

/-- On the closed inside: inner. -/
@[simp] theorem onSide_inside {P : Set ℂ} {w : ℂ} : OnSide .inside P w ↔ InnerAt P w := Iff.rfl

/-- On the closed outside: outer. -/
@[simp] theorem onSide_outside {P : Set ℂ} {w : ℂ} : OnSide .outside P w ↔ OuterAt P w := Iff.rfl

/-- Not inner: a point strictly outside the unit circle. -/
theorem not_innerAt_iff {P : Set ℂ} {w : ℂ} : ¬ InnerAt P w ↔ ∃ y ∈ P, 1 < dist y w := by
  simp only [InnerAt, not_subset, mem_closedBall, not_le]

/-- Not outer: a point strictly inside the unit circle. -/
theorem not_outerAt_iff {P : Set ℂ} {w : ℂ} : ¬ OuterAt P w ↔ ∃ y ∈ P, dist y w < 1 := by
  simp only [OuterAt, not_disjoint_iff, mem_ball]

/-- Crossing: "it has a point strictly inside and a point strictly outside `S(w)`". -/
theorem crossingAt_iff {P : Set ℂ} {w : ℂ} : CrossingAt P w ↔ (∃ y ∈ P, dist y w < 1) ∧ ∃ y ∈ P, 1 < dist y w := by
  rw [CrossingAt, not_innerAt_iff, not_outerAt_iff, and_comm]

/-- Not on the side `σ`: a point strictly on the other side. -/
theorem not_onSide_iff {σ : CircleSide} {P : Set ℂ} {w : ℂ} : ¬ OnSide σ P w ↔ ∃ y ∈ P, y ∈ σ.flip.region w := by
  cases σ
  · simp only [OnSide, InnerAt, CircleSide.flip, CircleSide.region, not_subset, mem_compl_iff]
  · simp only [OnSide, OuterAt, CircleSide.flip, CircleSide.region, not_disjoint_iff]

/-- An open set on the closed side `σ` of a circle lies on its open side. -/
theorem OnSide.subset_region {σ : CircleSide} {P : Set ℂ} {w : ℂ} (h : OnSide σ P w) (hP : IsOpen P) :
    P ⊆ σ.region w := by
  cases σ
  · have h' : P ⊆ closedBall w 1 := h
    exact (hP.subset_interior_iff.mpr h').trans (interior_closedBall w one_ne_zero).subset
  · have h' : Disjoint P (ball w 1) := h
    have h2 := hP.subset_interior_iff.mpr h'.subset_compl_right
    rwa [interior_compl, closure_ball w one_ne_zero] at h2

/-- A set inside the open side `σ` is on the closed side `σ`. -/
theorem onSide_of_subset_region {σ : CircleSide} {P : Set ℂ} {w : ℂ} (h : P ⊆ σ.region w) : OnSide σ P w := by
  cases σ
  · exact h.trans ball_subset_closedBall
  · exact Set.disjoint_left.mpr fun y hy hb => h hy (ball_subset_closedBall hb)

/-- **"A non-empty open set lies on no circle, so every piece is exactly one of the three"**: a non-empty open set
is not both inner and outer. -/
theorem not_innerAt_and_outerAt {P : Set ℂ} (hP : IsOpen P) (hne : P.Nonempty) (w : ℂ) :
    ¬ (InnerAt P w ∧ OuterAt P w) := by
  rintro ⟨hi, ho⟩
  obtain ⟨y, hy, hd⟩ := exists_dist_ne_of_isOpen hP hne w 1
  exact hd (le_antisymm (hi hy) (not_lt.mp fun hlt => Set.disjoint_left.mp ho hy hlt))

/-- Inner, outer or crossing — and, for a non-empty open set, exactly one (`not_innerAt_and_outerAt`; crossing
excludes both by definition). -/
theorem innerAt_or_outerAt_or_crossingAt (P : Set ℂ) (w : ℂ) : InnerAt P w ∨ OuterAt P w ∨ CrossingAt P w := by
  by_cases hi : InnerAt P w
  · exact Or.inl hi
  · by_cases ho : OuterAt P w
    · exact Or.inr (Or.inl ho)
    · exact Or.inr (Or.inr ⟨hi, ho⟩)

/-- The closures of an inner and an outer set meet on the unit circle only. -/
theorem InnerAt.closure_inter_closure_subset {P Q : Set ℂ} {w : ℂ} (hP : InnerAt P w) (hQ : OuterAt Q w) :
    closure P ∩ closure Q ⊆ sphere w 1 := by
  rintro y ⟨hyP, hyQ⟩
  have h1 : y ∈ closedBall w 1 := closure_minimal hP isClosed_closedBall hyP
  have h2 : y ∈ (ball w 1)ᶜ := closure_minimal hQ.subset_compl_right isOpen_ball.isClosed_compl hyQ
  exact mem_sphere.mpr (le_antisymm (mem_closedBall.mp h1) (not_lt.mp h2))

/-- **A piece of label `i` at `x`**: an open preconnected subset of `U` with `x` in its closure, almost every point of
which has the label `i`. (Non-empty since `x` is in its closure: `IsPieceAt.nonempty`.) -/
structure IsPieceAt (U : Set ℂ) (c : ℂ → α) (x : ℂ) (P : Set ℂ) (i : α) : Prop where
  /-- The piece is open. -/
  isOpen : IsOpen P
  /-- The piece is preconnected. -/
  isPreconnected : IsPreconnected P
  /-- The piece lies in `U`. -/
  subset : P ⊆ U
  /-- The point is in the closure of the piece. -/
  mem_closure : x ∈ closure P
  /-- Almost every point of the piece has the label. -/
  ae_label : ∀ᵐ z, z ∈ P → c z = i

/-- A piece is non-empty. -/
theorem IsPieceAt.nonempty {U : Set ℂ} {c : ℂ → α} {x : ℂ} {P : Set ℂ} {i : α} (h : IsPieceAt U c x P i) :
    P.Nonempty := by
  exact closure_nonempty_iff.mp ⟨x, h.mem_closure⟩

/-- A piece is connected. -/
theorem IsPieceAt.isConnected {U : Set ℂ} {c : ℂ → α} {x : ℂ} {P : Set ℂ} {i : α} (h : IsPieceAt U c x P i) :
    IsConnected P := by
  exact ⟨h.nonempty, h.isPreconnected⟩

/-- Two pieces of different labels are disjoint ("two open sets with different labels almost everywhere are
disjoint"). -/
theorem IsPieceAt.disjoint {U : Set ℂ} {c : ℂ → α} {x y : ℂ} {P Q : Set ℂ} {i j : α} (hP : IsPieceAt U c x P i)
    (hQ : IsPieceAt U c y Q j) (hij : i ≠ j) : Disjoint P Q := by
  refine Set.disjoint_iff_inter_eq_empty.mpr
    (eq_empty_of_isOpen_of_ae (c := c) (hP.isOpen.inter hQ.isOpen) (i := i) ?_ ?_)
  · filter_upwards [hP.ae_label] with z hz hzm using hz hzm.1
  · filter_upwards [hQ.ae_label] with z hz hzm
    rw [hz hzm.2]
    exact hij.symm

/-- The part of a piece where almost every point has another label is empty: an open subset of a piece on which the
label is almost nowhere is empty. -/
theorem IsPieceAt.inter_eq_empty {U : Set ℂ} {c : ℂ → α} {x : ℂ} {P : Set ℂ} {i : α} (hP : IsPieceAt U c x P i)
    {V : Set ℂ} (hV : IsOpen V) (h : ∀ᵐ z, z ∈ V → c z ≠ i) : P ∩ V = ∅ := by
  refine eq_empty_of_isOpen_of_ae (c := c) (hP.isOpen.inter hV) (i := i) ?_ ?_
  · filter_upwards [hP.ae_label] with z hz hzm using hz hzm.1
  · filter_upwards [h] with z hz hzm using hz hzm.2

/-- A piece has its label almost nowhere on the unit shadow of the piece, inside `U`. -/
theorem IsPieceAt.ae_unitShadow_ne {U : Set ℂ} {c : ℂ → α} (hc : AeProperOn U c) {x : ℂ} {P : Set ℂ} {i : α}
    (hP : IsPieceAt U c x P i) : ∀ᵐ z, z ∈ U ∩ unitShadow P → c z ≠ i := by
  exact hc.ae_unitShadow_ne hP.isOpen hP.subset hP.ae_label

/-! ## C124-TYPE -/

/-- **The type of a piece** (the core of C124-TYPE): let `P` be a piece of label `i` at `x` and `w ∈ U`. If `P` is
not on the closed side `σ` of the unit circle about `w`, there is `η > 0` such that almost every point of `ball w η`
on the side `σ` of the unit circle about `x` has a label other than `i`.

For `z` near `w` the point of `P` on the other side of `S(w)` is still on the other side of `S(z)`; if `z` is on the
side `σ` of `S(x)`, points of `P` near `x` are on the side `σ` of `S(z)`; so `S(z)` meets `P`
(`mem_unitShadow_of_isPreconnected`) and `z` is in its shadow. The distance from `w` to `x` is not read. -/
theorem IsPieceAt.ae_ne_region {U : Set ℂ} {c : ℂ → α} (hU : IsOpen U) (hc : AeProperOn U c) {x : ℂ} {P : Set ℂ}
    {i : α} (hP : IsPieceAt U c x P i) {w : ℂ} (hw : w ∈ U) {σ : CircleSide} (hσ : ¬ OnSide σ P w) :
    ∃ η > 0, ∀ᵐ z, z ∈ ball w η → z ∈ σ.region x → c z ≠ i := by
  obtain ⟨y₀, hy₀P, hy₀⟩ := not_onSide_iff.mp hσ
  -- a disc about `w` inside `U` on which `y₀` stays on the other side of the unit circle about the point
  obtain ⟨η, hη, hball⟩ := Metric.isOpen_iff.mp (hU.inter (σ.flip.isOpen_region y₀)) w
    ⟨hw, CircleSide.mem_region_comm.mp hy₀⟩
  refine ⟨η, hη, ?_⟩
  filter_upwards [hc.ae_unitShadow_ne hP.isOpen hP.subset hP.ae_label] with z hz hzb hzσ
  refine hz ⟨(hball hzb).1, ?_⟩
  have hy₀z : y₀ ∈ σ.flip.region z := CircleSide.mem_region_comm.mp (hball hzb).2
  -- a point of `P` near `x` on the side `σ` of the unit circle about `z`
  obtain ⟨y₁, hy₁σ, hy₁P⟩ := mem_closure_iff.mp hP.mem_closure _ (σ.isOpen_region z)
    (CircleSide.mem_region_comm.mp hzσ)
  cases σ
  · exact mem_unitShadow_of_isPreconnected hP.isPreconnected hy₁P hy₀P
      (by simpa [CircleSide.region] using hy₁σ) (by simpa [CircleSide.region, CircleSide.flip] using hy₀z)
  · exact mem_unitShadow_of_isPreconnected hP.isPreconnected hy₀P hy₁P
      (by simpa [CircleSide.region, CircleSide.flip] using hy₀z) (by simpa [CircleSide.region] using hy₁σ)

/-- A crossing piece has its label almost nowhere near `w`. -/
theorem IsPieceAt.ae_ne_of_crossingAt {U : Set ℂ} {c : ℂ → α} (hU : IsOpen U) (hc : AeProperOn U c) {x : ℂ}
    {P : Set ℂ} {i : α} (hP : IsPieceAt U c x P i) {w : ℂ} (hw : w ∈ U) (hcr : CrossingAt P w) :
    ∃ η > 0, ∀ᵐ z, z ∈ ball w η → c z ≠ i := by
  obtain ⟨η₁, hη₁, h1⟩ := hP.ae_ne_region hU hc hw (σ := .inside) hcr.1
  obtain ⟨η₂, hη₂, h2⟩ := hP.ae_ne_region hU hc hw (σ := .outside) hcr.2
  -- almost every point is off the unit circle about `x`, hence on one of its two sides
  have hoff : ∀ᵐ z : ℂ, z ∉ sphere x 1 := measure_eq_zero_iff_ae_notMem.mp (Measure.addHaar_sphere volume x 1)
  refine ⟨min η₁ η₂, lt_min hη₁ hη₂, ?_⟩
  filter_upwards [h1, h2, hoff] with z hz1 hz2 hz3 hzb
  rcases CircleSide.mem_region_or_of_dist_ne (z := z) (w := x) hz3 with h | h
  · exact hz1 (ball_subset_ball (min_le_left _ _) hzb) h
  · exact hz2 (ball_subset_ball (min_le_right _ _) hzb) h

/-- **A piece at a point of `U` lies in the closed unit disc about the point** (the type of the piece at `w = x`: a
piece reaching beyond the unit circle about `x` would have its label almost nowhere near `x`). -/
theorem IsPieceAt.innerAt_self {U : Set ℂ} {c : ℂ → α} (hU : IsOpen U) (hc : AeProperOn U c) {x : ℂ} {P : Set ℂ}
    {i : α} (hP : IsPieceAt U c x P i) (hx : x ∈ U) : InnerAt P x := by
  by_contra hni
  obtain ⟨η, hη, h⟩ := hP.ae_ne_region hU hc hx (σ := .inside) hni
  have hV : IsOpen (ball x η ∩ CircleSide.inside.region x) := isOpen_ball.inter (CircleSide.isOpen_region _ _)
  have hem := hP.inter_eq_empty hV (by filter_upwards [h] with z hz hzm using hz hzm.1 hzm.2)
  obtain ⟨y, hyV, hyP⟩ := mem_closure_iff.mp hP.mem_closure _ hV
    ⟨mem_ball_self hη, CircleSide.mem_region_inside.mpr (by rw [dist_self]; exact one_pos)⟩
  have hy : y ∈ P ∩ (ball x η ∩ CircleSide.inside.region x) := ⟨hyP, hyV⟩
  rw [hem] at hy
  exact hy

/-- **C124-TYPE** (`data/fs124/claims-K2.md`): "Let c be a weak k-colouring of an open set U, P a connected open
subset of U almost every point of which has the label i, x a point of the closure of P, and w a point of U with
|w − x| = 1. If P has a point strictly inside S(w), there is η > 0 such that almost every point z of B(w, η) with
|z − x| > 1 has a label other than i; if P has a point strictly outside S(w), there is η > 0 such that almost every
point z of B(w, η) with |z − x| < 1 has a label other than i."

**The hypothesis `|w − x| = 1` is not used and is not a hypothesis here**: the statement holds at every `w ∈ U` (it
is at `|w − x| = 1` that both regions meet every disc about `w`). Measurability of `c` and connectedness beyond
preconnectedness are not read either (`IsPieceAt.ae_ne_region`). Inhabitant of the hypotheses: `tightModel`, with
`P` the inner collar of the tight pair `(0, 1)`, `x = 1`, `w = 0`. -/
theorem piece_type {U : Set ℂ} {c : ℂ → Fin k} (hU : IsOpen U) (hc : IsWeakColouringOn U c) {P : Set ℂ}
    (hPo : IsOpen P) (hPc : IsConnected P) (hPU : P ⊆ U) {i : Fin k} (hi : ∀ᵐ z, z ∈ P → c z = i) {x w : ℂ}
    (hx : x ∈ closure P) (hw : w ∈ U) :
    ((∃ y ∈ P, dist y w < 1) → ∃ η > 0, ∀ᵐ z, z ∈ ball w η → 1 < dist z x → c z ≠ i) ∧
      ((∃ y ∈ P, 1 < dist y w) → ∃ η > 0, ∀ᵐ z, z ∈ ball w η → dist z x < 1 → c z ≠ i) := by
  have hP : IsPieceAt U c x P i := ⟨hPo, hPc.isPreconnected, hPU, hx, hi⟩
  refine ⟨fun h => ?_, fun h => ?_⟩
  · obtain ⟨η, hη, hη'⟩ := hP.ae_ne_region hU hc.aeProperOn hw (σ := .outside)
      (onSide_outside.not.mpr (not_outerAt_iff.mpr h))
    exact ⟨η, hη, by filter_upwards [hη'] with z hz hzb hzx using hz hzb (CircleSide.mem_region_outside.mpr hzx)⟩
  · obtain ⟨η, hη, hη'⟩ := hP.ae_ne_region hU hc.aeProperOn hw (σ := .inside)
      (onSide_inside.not.mpr (not_innerAt_iff.mpr h))
    exact ⟨η, hη, by filter_upwards [hη'] with z hz hzb hzx using hz hzb (CircleSide.mem_region_inside.mpr hzx)⟩

/-! ## C124-CENTRE-HALF -/

/-- **One collar** (the core of C124-CENTRE-HALF, both clauses in one): let `q ∈ U`, `z` on the unit circle about
`q`, `ball z ρ ⊆ U`. If almost every point of `ball z ρ` on the side `σ` of the unit circle about `q` has the label
`a`, there is `η > 0` such that almost every point of `ball q η` on the **other** side of the unit circle about `z`
has a label other than `a`. The disc tangent to `S(q)` at `z` on the side `σ` is a piece at `z`
(`exists_convex_subset_region`), not on the other side of `S(q)`: its type (`IsPieceAt.ae_ne_region`). -/
theorem AeProperOn.ae_ne_of_ae_region {U : Set ℂ} {c : ℂ → α} (hU : IsOpen U) (hc : AeProperOn U c) {q z : ℂ}
    (hq : q ∈ U) (hqz : dist q z = 1) {ρ : ℝ} (hρ : 0 < ρ) (hball : ball z ρ ⊆ U) {a : α} {σ : CircleSide}
    (ha : ∀ᵐ w, w ∈ ball z ρ → w ∈ σ.region q → c w = a) :
    ∃ η > 0, ∀ᵐ p, p ∈ ball q η → p ∈ σ.flip.region z → c p ≠ a := by
  -- the disc tangent to `S(q)` at `z` on the side `σ`, inside `ball z ρ`: a piece of label `a` at `z`
  obtain ⟨D, hDo, hDc, hzD, hDsub⟩ :=
    exists_convex_subset_region (q := q) (z := z) (by rw [dist_comm]; exact hqz) σ hρ
  have hD : IsPieceAt U c z D a := ⟨hDo, hDc.isPreconnected, fun y hy => hball (hDsub hy).1, hzD, by
    filter_upwards [ha] with w hw hwD using hw (hDsub hwD).1 (hDsub hwD).2⟩
  -- it is not on the closed side `σ.flip` of that circle: its points are strictly on the side `σ`
  obtain ⟨y, hy⟩ := hD.nonempty
  have hns : ¬ OnSide σ.flip D q := not_onSide_iff.mpr ⟨y, hy, by rw [CircleSide.flip_flip]; exact (hDsub hy).2⟩
  exact hD.ae_ne_region hU hc hq hns

/-- **C124-CENTRE-HALF** (`data/fs124/claims-K2.md`): "Let c be a weak k-colouring of an open set U, q and z points
of U with |q − z| = 1, ρ > 0 with B(z, ρ) ⊂ U, and a a label. If almost every point of B(z, ρ) with distance less
than 1 from q has the label a, there is η > 0 such that almost every point p of B(q, η) with |p − z| > 1 has a label
other than a; if almost every point of B(z, ρ) with distance more than 1 from q has the label a, there is η > 0 such
that almost every point p of B(q, η) with |p − z| < 1 has a label other than a."

`z ∈ U` is not a separate hypothesis: it follows from `hρ` and `hball`. Inhabitant of the hypotheses: `tightModel`
with `q = 0`, `z = 1`, `ρ = 1/10` and `a = 0` for the first clause, `a = 1` for the second. -/
theorem centre_half {U : Set ℂ} {c : ℂ → Fin k} (hU : IsOpen U) (hc : IsWeakColouringOn U c) {q z : ℂ}
    (hq : q ∈ U) (hqz : dist q z = 1) {ρ : ℝ} (hρ : 0 < ρ) (hball : ball z ρ ⊆ U) (a : Fin k) :
    ((∀ᵐ w, w ∈ ball z ρ → dist w q < 1 → c w = a) → ∃ η > 0, ∀ᵐ p, p ∈ ball q η → 1 < dist p z → c p ≠ a) ∧
      ((∀ᵐ w, w ∈ ball z ρ → 1 < dist w q → c w = a) → ∃ η > 0, ∀ᵐ p, p ∈ ball q η → dist p z < 1 → c p ≠ a) := by
  refine ⟨fun h => ?_, fun h => ?_⟩
  · obtain ⟨η, hη, hη'⟩ := hc.aeProperOn.ae_ne_of_ae_region hU hq hqz hρ hball (σ := .inside) (a := a)
      (by filter_upwards [h] with w hw hwb hwq using hw hwb (CircleSide.mem_region_inside.mp hwq))
    exact ⟨η, hη, by filter_upwards [hη'] with p hp hpb hpz using hp hpb (CircleSide.mem_region_outside.mpr hpz)⟩
  · obtain ⟨η, hη, hη'⟩ := hc.aeProperOn.ae_ne_of_ae_region hU hq hqz hρ hball (σ := .outside) (a := a)
      (by filter_upwards [h] with w hw hwb hwq using hw hwb (CircleSide.mem_region_outside.mp hwq))
    exact ⟨η, hη, by filter_upwards [hη'] with p hp hpb hpz using hp hpb (CircleSide.mem_region_inside.mpr hpz)⟩

/-! ## Tight pairs: C124-CENTRE and C124-STRADDLE -/

/-- The pair `(q, z)` is **tight for `(a, b)` with radius `ρ`** (`data/fs124/claims-K2.md`, "The object, stated
once"): `|q − z| = 1`, `a ≠ b`, `ρ > 0`, `B(z, ρ) ⊂ U`, almost every point `w` of `B(z, ρ)` with `|w − q| < 1` has the
label `a` and almost every point `w` of `B(z, ρ)` with `|w − q| > 1` has the label `b`. `q` is the centre, `z` the
far end (`z ∈ U`: `IsTightWith.mem`). That `c` is a weak colouring of `U` is a hypothesis of the theorems, not a
field. -/
structure IsTightWith (U : Set ℂ) (c : ℂ → α) (q z : ℂ) (a b : α) (ρ : ℝ) : Prop where
  /-- The far end is on the unit circle about the centre. -/
  dist_eq : dist q z = 1
  /-- The two labels are different. -/
  ne : a ≠ b
  /-- The radius is positive. -/
  pos : 0 < ρ
  /-- The disc about the far end lies in `U`. -/
  ball_subset : ball z ρ ⊆ U
  /-- Inside the unit circle about the centre the label is `a`, almost everywhere near the far end. -/
  ae_inside : ∀ᵐ w, w ∈ ball z ρ → dist w q < 1 → c w = a
  /-- Outside the unit circle about the centre the label is `b`, almost everywhere near the far end. -/
  ae_outside : ∀ᵐ w, w ∈ ball z ρ → 1 < dist w q → c w = b

/-- The pair `(q, z)` is **tight for `(a, b)`**: tight with some radius. -/
def IsTight (U : Set ℂ) (c : ℂ → α) (q z : ℂ) (a b : α) : Prop := ∃ ρ, IsTightWith U c q z a b ρ

/-- The inner collar `W_a = B(z, ρ) ∩ B(q, 1)` of a tight pair with radius `ρ`. -/
def innerCollar (q z : ℂ) (ρ : ℝ) : Set ℂ := ball z ρ ∩ ball q 1

/-- The outer collar `W_b = B(z, ρ) ∖ B̄(q, 1)` of a tight pair with radius `ρ`. -/
def outerCollar (q z : ℂ) (ρ : ℝ) : Set ℂ := ball z ρ \ closedBall q 1

/-- The far end of a tight pair is a point of `U`. -/
theorem IsTightWith.mem {U : Set ℂ} {c : ℂ → α} {q z : ℂ} {a b : α} {ρ : ℝ} (h : IsTightWith U c q z a b ρ) :
    z ∈ U := by
  exact h.ball_subset (mem_ball_self h.pos)

/-- A tight pair is tight with every smaller positive radius. -/
theorem IsTightWith.mono {U : Set ℂ} {c : ℂ → α} {q z : ℂ} {a b : α} {ρ ρ' : ℝ} (h : IsTightWith U c q z a b ρ)
    (hρ' : 0 < ρ') (hle : ρ' ≤ ρ) : IsTightWith U c q z a b ρ' := by
  refine ⟨h.dist_eq, h.ne, hρ', (ball_subset_ball hle).trans h.ball_subset, ?_, ?_⟩
  · filter_upwards [h.ae_inside] with w hw hwb using hw (ball_subset_ball hle hwb)
  · filter_upwards [h.ae_outside] with w hw hwb using hw (ball_subset_ball hle hwb)

/-- The collars are open. -/
theorem isOpen_innerCollar (q z : ℂ) (ρ : ℝ) : IsOpen (innerCollar q z ρ) := by
  exact isOpen_ball.inter isOpen_ball

/-- The collars are open. -/
theorem isOpen_outerCollar (q z : ℂ) (ρ : ℝ) : IsOpen (outerCollar q z ρ) := by
  exact isOpen_ball.sdiff isClosed_closedBall

/-- The inner collar carries the inside label almost everywhere. -/
theorem IsTightWith.ae_innerCollar {U : Set ℂ} {c : ℂ → α} {q z : ℂ} {a b : α} {ρ : ℝ}
    (h : IsTightWith U c q z a b ρ) : ∀ᵐ w, w ∈ innerCollar q z ρ → c w = a := by
  filter_upwards [h.ae_inside] with w hw hwc using hw hwc.1 (mem_ball.mp hwc.2)

/-- The outer collar carries the outside label almost everywhere. -/
theorem IsTightWith.ae_outerCollar {U : Set ℂ} {c : ℂ → α} {q z : ℂ} {a b : α} {ρ : ℝ}
    (h : IsTightWith U c q z a b ρ) : ∀ᵐ w, w ∈ outerCollar q z ρ → c w = b := by
  filter_upwards [h.ae_outside] with w hw hwc using hw hwc.1 (not_le.mp fun hle => hwc.2 (mem_closedBall.mpr hle))

/-- **Tight from a one-sided picture**: if `z ∈ U` is on the unit circle about `q`, `V` is an open set containing
`z`, and almost every point of `V` has the label `a` inside the unit circle about `q` and `b` outside it, the pair
`(q, z)` is tight for `(a, b)`. -/
theorem isTight_of_ae_of_isOpen {U : Set ℂ} {c : ℂ → α} {q z : ℂ} {a b : α} (hqz : dist q z = 1) (hab : a ≠ b)
    {V : Set ℂ} (hV : IsOpen V) (hzV : z ∈ V) (hVU : V ⊆ U) (hin : ∀ᵐ w, w ∈ V → dist w q < 1 → c w = a)
    (hout : ∀ᵐ w, w ∈ V → 1 < dist w q → c w = b) : IsTight U c q z a b := by
  obtain ⟨ρ, hρ, hsub⟩ := Metric.isOpen_iff.mp hV z hzV
  refine ⟨ρ, hqz, hab, hρ, hsub.trans hVU, ?_, ?_⟩
  · filter_upwards [hin] with w hw hwb using hw (hsub hwb)
  · filter_upwards [hout] with w hw hwb using hw (hsub hwb)

/-- The core of C124-CENTRE, for `AeProperOn` at any label type. -/
theorem IsTight.ae_ne_centre {U : Set ℂ} {c : ℂ → α} (hU : IsOpen U) (hc : AeProperOn U c) {q z : ℂ} (hq : q ∈ U)
    {a b : α} (ht : IsTight U c q z a b) :
    ∃ η > 0, (∀ᵐ w, w ∈ ball q η → 1 < dist w z → c w ≠ a) ∧ (∀ᵐ w, w ∈ ball q η → dist w z < 1 → c w ≠ b) := by
  obtain ⟨ρ, h⟩ := ht
  obtain ⟨η₁, hη₁, h1⟩ := hc.ae_ne_of_ae_region hU hq h.dist_eq h.pos h.ball_subset (σ := .inside) (a := a)
    (by filter_upwards [h.ae_inside] with w hw hwb hwq using hw hwb (CircleSide.mem_region_inside.mp hwq))
  obtain ⟨η₂, hη₂, h2⟩ := hc.ae_ne_of_ae_region hU hq h.dist_eq h.pos h.ball_subset (σ := .outside) (a := b)
    (by filter_upwards [h.ae_outside] with w hw hwb hwq using hw hwb (CircleSide.mem_region_outside.mp hwq))
  refine ⟨min η₁ η₂, lt_min hη₁ hη₂, ?_, ?_⟩
  · filter_upwards [h1] with w hw hwb hwz
    exact hw (ball_subset_ball (min_le_left _ _) hwb) (CircleSide.mem_region_outside.mpr hwz)
  · filter_upwards [h2] with w hw hwb hwz
    exact hw (ball_subset_ball (min_le_right _ _) hwb) (CircleSide.mem_region_inside.mpr hwz)

/-- **C124-CENTRE** (`data/fs124/claims-K2.md`): "Let c be a weak k-colouring of an open set U, q and z points of U
with |q − z| = 1, and (q, z) tight for (a, b). Then there is η > 0 such that almost every point w of B(q, η) with
|w − z| > 1 has a label other than a, and almost every point w of B(q, η) with |w − z| < 1 has a label other than b."

`|q − z| = 1` and `z ∈ U` are carried by `IsTight`. Inhabitant of the hypotheses: `isTight_tightModel`. -/
theorem tight_centre {U : Set ℂ} {c : ℂ → Fin k} (hU : IsOpen U) (hc : IsWeakColouringOn U c) {q z : ℂ} (hq : q ∈ U)
    {a b : Fin k} (ht : IsTight U c q z a b) :
    ∃ η > 0, (∀ᵐ w, w ∈ ball q η → 1 < dist w z → c w ≠ a) ∧ (∀ᵐ w, w ∈ ball q η → dist w z < 1 → c w ≠ b) := by
  exact ht.ae_ne_centre hU hc.aeProperOn hq

/-- The core of C124-STRADDLE, for `AeProperOn` at any label type: the unit circle about `p` crosses the unit circle
about `q` at `z`, so it meets both collars, and `p` is in the shadow of each. -/
theorem IsTight.ae_ne_straddle {U : Set ℂ} {c : ℂ → α} (hU : IsOpen U) (hc : AeProperOn U c) {q z : ℂ} {a b : α}
    (ht : IsTight U c q z a b) {p : ℂ} (hp : p ∈ U) (hpz : dist p z = 1) (hpq : p ≠ q) (hanti : p ≠ 2 * z - q) :
    ∃ η > 0, ∀ᵐ w, w ∈ ball p η → c w ≠ a ∧ c w ≠ b := by
  obtain ⟨ρ, h⟩ := ht
  have hcross : CrossAt p q z :=
    ⟨by rw [dist_comm]; exact hpz, by rw [dist_comm]; exact h.dist_eq, hpq, fun he => hanti (by linear_combination he)⟩
  -- the unit circle about `p` meets both collars
  obtain ⟨y₁, hy₁p, hy₁z, hy₁q⟩ := hcross.exists_mem_sphere_region .inside h.pos
  obtain ⟨y₂, hy₂p, hy₂z, hy₂q⟩ := hcross.exists_mem_sphere_region .outside h.pos
  have hin : p ∈ U ∩ unitShadow (innerCollar q z ρ) :=
    ⟨hp, y₁, ⟨hy₁z, CircleSide.mem_region_inside.mp hy₁q⟩, by rw [dist_comm]; exact hy₁p⟩
  have hout : p ∈ U ∩ unitShadow (outerCollar q z ρ) :=
    ⟨hp, y₂, ⟨hy₂z, fun hle => (CircleSide.mem_region_outside.mp hy₂q).not_ge (mem_closedBall.mp hle)⟩, by
      rw [dist_comm]; exact hy₂p⟩
  -- so a disc about `p` lies in the shadow of each, inside `U`
  obtain ⟨η, hη, hsub⟩ := Metric.isOpen_iff.mp
    ((hU.inter (isOpen_unitShadow (isOpen_innerCollar q z ρ))).inter
      (hU.inter (isOpen_unitShadow (isOpen_outerCollar q z ρ)))) p ⟨hin, hout⟩
  refine ⟨η, hη, ?_⟩
  filter_upwards [hc.ae_unitShadow_ne (isOpen_innerCollar q z ρ) (fun y hy => h.ball_subset hy.1) h.ae_innerCollar,
    hc.ae_unitShadow_ne (isOpen_outerCollar q z ρ) (fun y hy => h.ball_subset hy.1) h.ae_outerCollar] with w hw1 hw2 hwb
  exact ⟨hw1 (hsub hwb).1, hw2 (hsub hwb).2⟩

/-- **C124-STRADDLE** (`data/fs124/claims-K2.md`): "Let c be a weak k-colouring of U, (q, z) tight for (a, b), and p
a point of U with |p − z| = 1, p ≠ q and p ≠ 2z − q. Then there is η > 0 such that almost every point of B(p, η) has
a label other than a and other than b."

Inhabitant of the hypotheses: `isTight_tightModel` with `p = 1 + i`. -/
theorem tight_straddle {U : Set ℂ} {c : ℂ → Fin k} (hU : IsOpen U) (hc : IsWeakColouringOn U c) {q z : ℂ} {a b : Fin k}
    (ht : IsTight U c q z a b) {p : ℂ} (hp : p ∈ U) (hpz : dist p z = 1) (hpq : p ≠ q) (hanti : p ≠ 2 * z - q) :
    ∃ η > 0, ∀ᵐ w, w ∈ ball p η → c w ≠ a ∧ c w ≠ b := by
  exact ht.ae_ne_straddle hU hc.aeProperOn hp hpz hpq hanti

/-! ## The model -/

/-- The model colouring: within `1/2` of `1`, the label `0` inside the unit circle about `0` and `1` outside it;
elsewhere `2`. -/
noncomputable def tightModel (z : ℂ) : Fin 3 := if dist z 1 < 1 / 2 then (if ‖z‖ < 1 then 0 else 1) else 2

/-- The model's set: three discs of radius `1/10`, about `0`, `1` and `1 + i`. -/
def tightModelDom : Set ℂ := ball 0 (1 / 10) ∪ ball 1 (1 / 10) ∪ ball (1 + I) (1 / 10)

/-- Off the disc of radius `1/2` about `1` the model's label is `2`. -/
theorem tightModel_of_not_lt {z : ℂ} (h : ¬ dist z 1 < 1 / 2) : tightModel z = 2 := by
  rw [tightModel, if_neg h]

/-- In the disc of radius `1/2` about `1` the model's label is `0` or `1`: not `2`. -/
theorem tightModel_ne_two_of_lt {z : ℂ} (h : dist z 1 < 1 / 2) : tightModel z ≠ 2 := by
  rw [tightModel, if_pos h]
  split_ifs <;> decide

/-- The centres `0` and `1 + i` of two of the model's discs are more than `6/5` apart. -/
theorem tightModel_far : 6 / 5 < dist (1 + I : ℂ) 0 := by
  have h2 : ‖(1 : ℂ) + I‖ ^ 2 = 2 := by
    rw [sq_norm_eq]
    simp
    norm_num
  rw [dist_zero_right]
  by_contra hle
  have h3 := norm_nonneg ((1 : ℂ) + I)
  nlinarith [not_lt.mp hle]

/-- On the discs about `0` and `1 + i` the model's label is `2`. -/
theorem tightModel_eq_two_of_mem {z : ℂ} (h : z ∈ ball (0 : ℂ) (1 / 10) ∪ ball (1 + I : ℂ) (1 / 10)) :
    tightModel z = 2 := by
  refine tightModel_of_not_lt (not_lt.mpr ?_)
  rcases h with h | h
  · have h1 := dist_triangle (0 : ℂ) z 1
    rw [mem_ball, dist_comm] at h
    rw [dist_zero_left, norm_one] at h1
    linarith
  · have h1 := dist_triangle (1 + I : ℂ) z 1
    have h2 : dist (1 + I : ℂ) 1 = 1 := by rw [dist_eq_norm, add_sub_cancel_left, Complex.norm_I]
    rw [mem_ball, dist_comm] at h
    linarith

/-- On the disc about `1` the model's label is not `2`. -/
theorem tightModel_ne_two_of_mem {z : ℂ} (h : z ∈ ball (1 : ℂ) (1 / 10)) : tightModel z ≠ 2 :=
  tightModel_ne_two_of_lt (lt_trans (mem_ball.mp h) (by norm_num))

/-- The model's set is open. -/
theorem isOpen_tightModelDom : IsOpen tightModelDom := by
  exact (isOpen_ball.union isOpen_ball).union isOpen_ball

/-- The model is measurable. -/
theorem measurable_tightModel : Measurable tightModel := by
  refine Measurable.ite ?_ (Measurable.ite ?_ measurable_const measurable_const) measurable_const
  · exact (isOpen_lt (continuous_id.dist continuous_const) continuous_const).measurableSet
  · exact (isOpen_lt continuous_norm continuous_const).measurableSet

/-- **Inhabitant**: the model is a weak three-colouring of its set — it separates every two points of the set at
distance `1` (two of the three discs are more than `1` apart, and the disc about `1` has labels `0`, `1` against the
others' `2`). -/
theorem isWeakColouringOn_tightModel : IsWeakColouringOn tightModelDom tightModel := by
  refine ⟨measurable_tightModel, aeProperOn_of_proper ?_⟩
  -- two points of one disc of radius `1/10` are not at distance `1`
  have hsame : ∀ c₀ x y : ℂ, x ∈ ball c₀ (1 / 10) → y ∈ ball c₀ (1 / 10) → dist x y ≠ 1 := by
    intro c₀ x y hx hy h
    have := dist_triangle_right x y c₀
    rw [mem_ball] at hx hy
    linarith
  -- nor are a point of the disc about `0` and a point of the disc about `1 + i`
  have hdiff : ∀ x y : ℂ, x ∈ ball (0 : ℂ) (1 / 10) → y ∈ ball (1 + I : ℂ) (1 / 10) → dist x y ≠ 1 := by
    intro x y hx hy h
    have h1 := dist_triangle4 (0 : ℂ) x y (1 + I)
    rw [mem_ball] at hx hy
    rw [dist_comm] at hx
    have h2 := tightModel_far
    rw [dist_comm] at h2
    linarith
  rintro x ((hx | hx) | hx) y ((hy | hy) | hy) hxy
  · exact absurd hxy (hsame _ _ _ hx hy)
  · rw [tightModel_eq_two_of_mem (Or.inl hx)]
    exact (tightModel_ne_two_of_mem hy).symm
  · exact absurd hxy (hdiff _ _ hx hy)
  · rw [tightModel_eq_two_of_mem (Or.inl hy)]
    exact tightModel_ne_two_of_mem hx
  · exact absurd hxy (hsame _ _ _ hx hy)
  · rw [tightModel_eq_two_of_mem (Or.inr hy)]
    exact tightModel_ne_two_of_mem hx
  · exact absurd (by rw [dist_comm]; exact hxy) (hdiff _ _ hy hx)
  · rw [tightModel_eq_two_of_mem (Or.inr hx)]
    exact (tightModel_ne_two_of_mem hy).symm
  · exact absurd hxy (hsame _ _ _ hx hy)

/-- **Inhabitant**: in the model the pair `(0, 1)` is tight for the labels `(0, 1)`. -/
theorem isTight_tightModel : IsTight tightModelDom tightModel 0 1 0 1 := by
  refine ⟨1 / 10, by simp, by decide, by norm_num, fun y hy => Or.inl (Or.inr hy),
    Filter.Eventually.of_forall fun w hwb hwq => ?_, Filter.Eventually.of_forall fun w hwb hwq => ?_⟩
  · have h1 : dist w 1 < 1 / 2 := lt_trans (mem_ball.mp hwb) (by norm_num)
    have h2 : ‖w‖ < 1 := by rwa [dist_zero_right] at hwq
    rw [tightModel, if_pos h1, if_pos h2]
  · have h1 : dist w 1 < 1 / 2 := lt_trans (mem_ball.mp hwb) (by norm_num)
    have h2 : ¬ ‖w‖ < 1 := by rw [dist_zero_right] at hwq; exact not_lt.mpr hwq.le
    rw [tightModel, if_pos h1, if_neg h2]

/-! ## Spec examples -/

/-- The model, read through C124-SHADOW-OPEN: the disc about `0` has the label `2`, so almost every point of the
set at distance `1` from it — the disc about `1` among them — has another label. -/
example : ∀ᵐ z, z ∈ tightModelDom ∩ unitShadow (ball (0 : ℂ) (1 / 10)) → tightModel z ≠ 2 := by
  exact (shadow_open isOpen_tightModelDom isWeakColouringOn_tightModel isOpen_ball
    (fun y hy => Or.inl (Or.inl hy)) (i := 2)
    (Filter.Eventually.of_forall fun z hz => tightModel_eq_two_of_mem (Or.inl hz))).2

/-- The model, read through C124-CENTRE: near the centre `0` the labels `0` and `1` are confined. -/
example : ∃ η > 0, (∀ᵐ w, w ∈ ball (0 : ℂ) η → 1 < dist w 1 → tightModel w ≠ 0) ∧
    (∀ᵐ w, w ∈ ball (0 : ℂ) η → dist w 1 < 1 → tightModel w ≠ 1) :=
  tight_centre isOpen_tightModelDom isWeakColouringOn_tightModel (Or.inl (Or.inl (mem_ball_self (by norm_num))))
    isTight_tightModel

/-- The model, read through C124-STRADDLE at `p = 1 + i`. -/
example : ∃ η > 0, ∀ᵐ w, w ∈ ball (1 + I : ℂ) η → tightModel w ≠ 0 ∧ tightModel w ≠ 1 := by
  refine tight_straddle isOpen_tightModelDom isWeakColouringOn_tightModel isTight_tightModel (p := 1 + I)
    (Or.inr (mem_ball_self (by norm_num))) ?_ (fun h => ?_) (fun h => ?_)
  · rw [dist_eq_norm, add_sub_cancel_left, Complex.norm_I]
  · simpa using congrArg Complex.re h
  · simpa using congrArg Complex.im h

/-- The model, read through C124-TYPE (an example added by the implementer: the docstring of `piece_type` names this
inhabitant). The inner collar of the tight pair `(0, 1)` is a connected open subset of the model's set, of label `0`,
with `1` in its closure and the point `19/20` strictly inside the unit circle about `0`; so near `0` the label `0` is
almost nowhere outside the unit circle about `1`. -/
example : ∃ η > 0, ∀ᵐ z, z ∈ ball (0 : ℂ) η → 1 < dist z 1 → tightModel z ≠ 0 := by
  have hc0 : dist (19 / 20 : ℂ) 0 = 19 / 20 := by rw [dist_zero_right]; norm_num
  have hc1 : dist (19 / 20 : ℂ) 1 = 1 / 20 := by
    rw [dist_eq_norm, show (19 / 20 : ℂ) - 1 = -(1 / 20) by norm_num, norm_neg]; norm_num
  -- the disc tangent to the unit circle about `0` at `1`, inside the collar
  have hsub : ball (19 / 20 : ℂ) (1 / 20) ⊆ innerCollar 0 1 (1 / 10) := by
    intro y hy
    rw [mem_ball] at hy
    have h1 := dist_triangle y (19 / 20) 1
    have h0 := dist_triangle y (19 / 20) 0
    exact ⟨by rw [mem_ball]; linarith, by rw [mem_ball]; linarith⟩
  have hmem : (19 / 20 : ℂ) ∈ innerCollar 0 1 (1 / 10) := hsub (mem_ball_self (by norm_num))
  have hx : (1 : ℂ) ∈ closure (innerCollar 0 1 (1 / 10)) := by
    refine closure_mono hsub ?_
    rw [closure_ball _ (by norm_num), mem_closedBall, dist_comm, hc1]
  have hlabel : ∀ᵐ z, z ∈ innerCollar 0 1 (1 / 10) → tightModel z = 0 :=
    Filter.Eventually.of_forall fun z hz => by
      have h2 : ‖z‖ < 1 := by have := hz.2; rwa [mem_ball, dist_zero_right] at this
      rw [tightModel, if_pos (lt_trans (mem_ball.mp hz.1) (by norm_num)), if_pos h2]
  exact (piece_type isOpen_tightModelDom isWeakColouringOn_tightModel (isOpen_innerCollar 0 1 (1 / 10))
    ⟨⟨_, hmem⟩, ((convex_ball _ _).inter (convex_ball _ _)).isPreconnected⟩ (fun y hy => Or.inl (Or.inr hy.1))
    hlabel hx (Or.inl (Or.inl (mem_ball_self (by norm_num))))).1 ⟨19 / 20, hmem, by rw [hc0]; norm_num⟩

/-- The model, read through C124-CENTRE-HALF, both clauses (an example added by the implementer: the docstring of
`centre_half` names this inhabitant): `q = 0`, `z = 1`, `ρ = 1/10`, with `a = 0` for the inner collar and `a = 1` for
the outer one. -/
example : (∃ η > 0, ∀ᵐ p, p ∈ ball (0 : ℂ) η → 1 < dist p 1 → tightModel p ≠ 0) ∧
    ∃ η > 0, ∀ᵐ p, p ∈ ball (0 : ℂ) η → dist p 1 < 1 → tightModel p ≠ 1 := by
  have h := centre_half isOpen_tightModelDom isWeakColouringOn_tightModel (q := 0) (z := 1)
    (Or.inl (Or.inl (mem_ball_self (by norm_num)))) (by simp) (ρ := 1 / 10) (by norm_num)
    (fun y hy => Or.inl (Or.inr hy))
  refine ⟨(h 0).1 (Filter.Eventually.of_forall fun w hwb hwq => ?_),
    (h 1).2 (Filter.Eventually.of_forall fun w hwb hwq => ?_)⟩
  · have h2 : ‖w‖ < 1 := by rwa [dist_zero_right] at hwq
    rw [tightModel, if_pos (lt_trans (mem_ball.mp hwb) (by norm_num)), if_pos h2]
  · have h2 : ¬ ‖w‖ < 1 := by rw [dist_zero_right] at hwq; exact not_lt.mpr hwq.le
    rw [tightModel, if_pos (lt_trans (mem_ball.mp hwb) (by norm_num)), if_neg h2]

/-- **Adversary** for the definition of a tight pair: a pair is not tight for a label and itself. -/
example (U : Set ℂ) (c : ℂ → α) (q z : ℂ) (a : α) : ¬ IsTight U c q z a a :=
  fun ⟨_, h⟩ => h.ne rfl

/-- **Adversary** for inner and outer: the disc of radius `1/2` about `0` is inner at `0`, not outer, and not
crossing. -/
example : InnerAt (ball (0 : ℂ) (1 / 2)) 0 ∧ ¬ OuterAt (ball (0 : ℂ) (1 / 2)) 0 ∧
    ¬ CrossingAt (ball (0 : ℂ) (1 / 2)) 0 := by
  have hin : InnerAt (ball (0 : ℂ) (1 / 2)) 0 := (ball_subset_ball (by norm_num)).trans ball_subset_closedBall
  exact ⟨hin, not_outerAt_iff.mpr ⟨0, mem_ball_self (by norm_num), by simp⟩, fun h => h.1 hin⟩

/-- The disc of radius `1/2` about `1` is crossing at `0`. -/
example : CrossingAt (ball (1 : ℂ) (1 / 2)) 0 := by
  refine crossingAt_iff.mpr ⟨⟨3 / 4, ?_, ?_⟩, ⟨5 / 4, ?_, ?_⟩⟩
  · rw [mem_ball, dist_eq_norm, show (3 / 4 : ℂ) - 1 = -(1 / 4) by norm_num, norm_neg]; norm_num
  · rw [dist_zero_right]; norm_num
  · rw [mem_ball, dist_eq_norm, show (5 / 4 : ℂ) - 1 = 1 / 4 by norm_num]; norm_num
  · rw [dist_zero_right]; norm_num

end HadwigerNelson.Plane

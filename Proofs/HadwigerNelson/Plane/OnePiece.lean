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
* `IsTight U c q z a b` — the pair `(q, z)` is tight for `(a, b)`; `innerCollar`, `outerCollar`. `centre`
  (C124-CENTRE) and `straddle` (C124-STRADDLE).

**Inhabitant** of every hypothesis here at once: `tightModel` on `tightModelDom` — three discs of radius `1/10` about
`0`, `1` and `1 + i`; about `1` the label is `0` inside the unit circle about `0` and `1` outside it; elsewhere `2`.
The pair `(0, 1)` is tight for `(0, 1)` (`isTight_tightModel`), and `1 + i` is a point of the unit circle about `1`
other than `0` and its antipode `2`.
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Metric

variable {α : Type*} {k : ℕ}

/-! ## The shadow of an open set of one label -/

/-- The unit shadow of an open set is open: it is the union of the translates of the set by the unit vectors. -/
theorem isOpen_unitShadow {W : Set ℂ} (hW : IsOpen W) : IsOpen (unitShadow W) := by
  sorry

/-- The unit shadow is monotone. -/
theorem unitShadow_mono {V W : Set ℂ} (h : V ⊆ W) : unitShadow V ⊆ unitShadow W := by
  sorry

/-- A point is in the unit shadow of `W` exactly when some direction from it lands in `W`. -/
theorem mem_unitShadow_iff_exists_e {W : Set ℂ} {z : ℂ} : z ∈ unitShadow W ↔ ∃ θ : ℝ, z + e θ ∈ W := by
  sorry

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
  sorry

/-- An open set almost every point of which satisfies a property that fails at almost every point of it is empty:
the two-label form. -/
theorem eq_empty_of_isOpen_of_ae {c : ℂ → α} {W : Set ℂ} (hW : IsOpen W) {i : α} (h₁ : ∀ᵐ z, z ∈ W → c z = i)
    (h₂ : ∀ᵐ z, z ∈ W → c z ≠ i) : W = ∅ := by
  sorry

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

/-- Not inner: a point strictly outside the unit circle. -/
theorem not_innerAt_iff {P : Set ℂ} {w : ℂ} : ¬ InnerAt P w ↔ ∃ y ∈ P, 1 < dist y w := by
  sorry

/-- Not outer: a point strictly inside the unit circle. -/
theorem not_outerAt_iff {P : Set ℂ} {w : ℂ} : ¬ OuterAt P w ↔ ∃ y ∈ P, dist y w < 1 := by
  sorry

/-- Crossing: "it has a point strictly inside and a point strictly outside `S(w)`". -/
theorem crossingAt_iff {P : Set ℂ} {w : ℂ} : CrossingAt P w ↔ (∃ y ∈ P, dist y w < 1) ∧ ∃ y ∈ P, 1 < dist y w := by
  sorry

/-- Not on the side `σ`: a point strictly on the other side. -/
theorem not_onSide_iff {σ : CircleSide} {P : Set ℂ} {w : ℂ} : ¬ OnSide σ P w ↔ ∃ y ∈ P, y ∈ σ.flip.region w := by
  cases σ
  · simp only [OnSide, InnerAt, CircleSide.flip, CircleSide.region, not_subset, mem_compl_iff]
  · simp only [OnSide, OuterAt, CircleSide.flip, CircleSide.region, not_disjoint_iff]

/-- An open set on the closed side `σ` of a circle lies on its open side. -/
theorem OnSide.subset_region {σ : CircleSide} {P : Set ℂ} {w : ℂ} (h : OnSide σ P w) (hP : IsOpen P) :
    P ⊆ σ.region w := by
  sorry

/-- A set inside the open side `σ` is on the closed side `σ`. -/
theorem onSide_of_subset_region {σ : CircleSide} {P : Set ℂ} {w : ℂ} (h : P ⊆ σ.region w) : OnSide σ P w := by
  sorry

/-- **"A non-empty open set lies on no circle, so every piece is exactly one of the three"**: a non-empty open set
is not both inner and outer. -/
theorem not_innerAt_and_outerAt {P : Set ℂ} (hP : IsOpen P) (hne : P.Nonempty) (w : ℂ) :
    ¬ (InnerAt P w ∧ OuterAt P w) := by
  sorry

/-- Inner, outer or crossing — and, for a non-empty open set, exactly one (`not_innerAt_and_outerAt`; crossing
excludes both by definition). -/
theorem innerAt_or_outerAt_or_crossingAt (P : Set ℂ) (w : ℂ) : InnerAt P w ∨ OuterAt P w ∨ CrossingAt P w := by
  sorry

/-- The closures of an inner and an outer set meet on the unit circle only. -/
theorem InnerAt.closure_inter_closure_subset {P Q : Set ℂ} {w : ℂ} (hP : InnerAt P w) (hQ : OuterAt Q w) :
    closure P ∩ closure Q ⊆ sphere w 1 := by
  sorry

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
  sorry

/-- A piece is connected. -/
theorem IsPieceAt.isConnected {U : Set ℂ} {c : ℂ → α} {x : ℂ} {P : Set ℂ} {i : α} (h : IsPieceAt U c x P i) :
    IsConnected P := by
  sorry

/-- Two pieces of different labels are disjoint ("two open sets with different labels almost everywhere are
disjoint"). -/
theorem IsPieceAt.disjoint {U : Set ℂ} {c : ℂ → α} {x y : ℂ} {P Q : Set ℂ} {i j : α} (hP : IsPieceAt U c x P i)
    (hQ : IsPieceAt U c y Q j) (hij : i ≠ j) : Disjoint P Q := by
  sorry

/-- The part of a piece where almost every point has another label is empty: an open subset of a piece on which the
label is almost nowhere is empty. -/
theorem IsPieceAt.inter_eq_empty {U : Set ℂ} {c : ℂ → α} {x : ℂ} {P : Set ℂ} {i : α} (hP : IsPieceAt U c x P i)
    {V : Set ℂ} (hV : IsOpen V) (h : ∀ᵐ z, z ∈ V → c z ≠ i) : P ∩ V = ∅ := by
  sorry

/-- A piece has its label almost nowhere on the unit shadow of the piece, inside `U`. -/
theorem IsPieceAt.ae_unitShadow_ne {U : Set ℂ} {c : ℂ → α} (hc : AeProperOn U c) {x : ℂ} {P : Set ℂ} {i : α}
    (hP : IsPieceAt U c x P i) : ∀ᵐ z, z ∈ U ∩ unitShadow P → c z ≠ i := by
  sorry

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
  sorry

/-- **A piece at a point of `U` lies in the closed unit disc about the point** (the type of the piece at `w = x`: a
piece reaching beyond the unit circle about `x` would have its label almost nowhere near `x`). -/
theorem IsPieceAt.innerAt_self {U : Set ℂ} {c : ℂ → α} (hU : IsOpen U) (hc : AeProperOn U c) {x : ℂ} {P : Set ℂ}
    {i : α} (hP : IsPieceAt U c x P i) (hx : x ∈ U) : InnerAt P x := by
  sorry

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
  sorry

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
  sorry

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
  sorry

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
  sorry

/-- A tight pair is tight with every smaller positive radius. -/
theorem IsTightWith.mono {U : Set ℂ} {c : ℂ → α} {q z : ℂ} {a b : α} {ρ ρ' : ℝ} (h : IsTightWith U c q z a b ρ)
    (hρ' : 0 < ρ') (hle : ρ' ≤ ρ) : IsTightWith U c q z a b ρ' := by
  sorry

/-- The collars are open. -/
theorem isOpen_innerCollar (q z : ℂ) (ρ : ℝ) : IsOpen (innerCollar q z ρ) := by
  sorry

/-- The collars are open. -/
theorem isOpen_outerCollar (q z : ℂ) (ρ : ℝ) : IsOpen (outerCollar q z ρ) := by
  sorry

/-- The inner collar carries the inside label almost everywhere. -/
theorem IsTightWith.ae_innerCollar {U : Set ℂ} {c : ℂ → α} {q z : ℂ} {a b : α} {ρ : ℝ}
    (h : IsTightWith U c q z a b ρ) : ∀ᵐ w, w ∈ innerCollar q z ρ → c w = a := by
  sorry

/-- The outer collar carries the outside label almost everywhere. -/
theorem IsTightWith.ae_outerCollar {U : Set ℂ} {c : ℂ → α} {q z : ℂ} {a b : α} {ρ : ℝ}
    (h : IsTightWith U c q z a b ρ) : ∀ᵐ w, w ∈ outerCollar q z ρ → c w = b := by
  sorry

/-- **Tight from a one-sided picture**: if `z ∈ U` is on the unit circle about `q`, `V` is an open set containing
`z`, and almost every point of `V` has the label `a` inside the unit circle about `q` and `b` outside it, the pair
`(q, z)` is tight for `(a, b)`. -/
theorem isTight_of_ae_of_isOpen {U : Set ℂ} {c : ℂ → α} {q z : ℂ} {a b : α} (hqz : dist q z = 1) (hab : a ≠ b)
    {V : Set ℂ} (hV : IsOpen V) (hzV : z ∈ V) (hVU : V ⊆ U) (hin : ∀ᵐ w, w ∈ V → dist w q < 1 → c w = a)
    (hout : ∀ᵐ w, w ∈ V → 1 < dist w q → c w = b) : IsTight U c q z a b := by
  sorry

/-- The core of C124-CENTRE, for `AeProperOn` at any label type. -/
theorem IsTight.ae_ne_centre {U : Set ℂ} {c : ℂ → α} (hU : IsOpen U) (hc : AeProperOn U c) {q z : ℂ} (hq : q ∈ U)
    {a b : α} (ht : IsTight U c q z a b) :
    ∃ η > 0, (∀ᵐ w, w ∈ ball q η → 1 < dist w z → c w ≠ a) ∧ (∀ᵐ w, w ∈ ball q η → dist w z < 1 → c w ≠ b) := by
  sorry

/-- **C124-CENTRE** (`data/fs124/claims-K2.md`): "Let c be a weak k-colouring of an open set U, q and z points of U
with |q − z| = 1, and (q, z) tight for (a, b). Then there is η > 0 such that almost every point w of B(q, η) with
|w − z| > 1 has a label other than a, and almost every point w of B(q, η) with |w − z| < 1 has a label other than b."

`|q − z| = 1` and `z ∈ U` are carried by `IsTight`. Inhabitant of the hypotheses: `isTight_tightModel`. -/
theorem centre {U : Set ℂ} {c : ℂ → Fin k} (hU : IsOpen U) (hc : IsWeakColouringOn U c) {q z : ℂ} (hq : q ∈ U)
    {a b : Fin k} (ht : IsTight U c q z a b) :
    ∃ η > 0, (∀ᵐ w, w ∈ ball q η → 1 < dist w z → c w ≠ a) ∧ (∀ᵐ w, w ∈ ball q η → dist w z < 1 → c w ≠ b) := by
  sorry

/-- The core of C124-STRADDLE, for `AeProperOn` at any label type: the unit circle about `p` crosses the unit circle
about `q` at `z`, so it meets both collars, and `p` is in the shadow of each. -/
theorem IsTight.ae_ne_straddle {U : Set ℂ} {c : ℂ → α} (hU : IsOpen U) (hc : AeProperOn U c) {q z : ℂ} {a b : α}
    (ht : IsTight U c q z a b) {p : ℂ} (hp : p ∈ U) (hpz : dist p z = 1) (hpq : p ≠ q) (hanti : p ≠ 2 * z - q) :
    ∃ η > 0, ∀ᵐ w, w ∈ ball p η → c w ≠ a ∧ c w ≠ b := by
  sorry

/-- **C124-STRADDLE** (`data/fs124/claims-K2.md`): "Let c be a weak k-colouring of U, (q, z) tight for (a, b), and p
a point of U with |p − z| = 1, p ≠ q and p ≠ 2z − q. Then there is η > 0 such that almost every point of B(p, η) has
a label other than a and other than b."

Inhabitant of the hypotheses: `isTight_tightModel` with `p = 1 + i`. -/
theorem straddle {U : Set ℂ} {c : ℂ → Fin k} (hU : IsOpen U) (hc : IsWeakColouringOn U c) {q z : ℂ} {a b : Fin k}
    (ht : IsTight U c q z a b) {p : ℂ} (hp : p ∈ U) (hpz : dist p z = 1) (hpq : p ≠ q) (hanti : p ≠ 2 * z - q) :
    ∃ η > 0, ∀ᵐ w, w ∈ ball p η → c w ≠ a ∧ c w ≠ b := by
  sorry

/-! ## The model -/

/-- The model colouring: within `1/2` of `1`, the label `0` inside the unit circle about `0` and `1` outside it;
elsewhere `2`. -/
noncomputable def tightModel (z : ℂ) : Fin 3 := if dist z 1 < 1 / 2 then (if ‖z‖ < 1 then 0 else 1) else 2

/-- The model's set: three discs of radius `1/10`, about `0`, `1` and `1 + i`. -/
def tightModelDom : Set ℂ := ball 0 (1 / 10) ∪ ball 1 (1 / 10) ∪ ball (1 + I) (1 / 10)

/-- The model's set is open. -/
theorem isOpen_tightModelDom : IsOpen tightModelDom := by
  sorry

/-- The model is measurable. -/
theorem measurable_tightModel : Measurable tightModel := by
  sorry

/-- **Inhabitant**: the model is a weak three-colouring of its set — it separates every two points of the set at
distance `1` (two of the three discs are more than `1` apart, and the disc about `1` has labels `0`, `1` against the
others' `2`). -/
theorem isWeakColouringOn_tightModel : IsWeakColouringOn tightModelDom tightModel := by
  sorry

/-- **Inhabitant**: in the model the pair `(0, 1)` is tight for the labels `(0, 1)`. -/
theorem isTight_tightModel : IsTight tightModelDom tightModel 0 1 0 1 := by
  sorry

/-! ## Spec examples -/

/-- The model, read through C124-SHADOW-OPEN: the disc about `0` has the label `2`, so almost every point of the
set at distance `1` from it — the disc about `1` among them — has another label. -/
example : ∀ᵐ z, z ∈ tightModelDom ∩ unitShadow (ball (0 : ℂ) (1 / 10)) → tightModel z ≠ 2 := by
  sorry

/-- The model, read through C124-CENTRE: near the centre `0` the labels `0` and `1` are confined. -/
example : ∃ η > 0, (∀ᵐ w, w ∈ ball (0 : ℂ) η → 1 < dist w 1 → tightModel w ≠ 0) ∧
    (∀ᵐ w, w ∈ ball (0 : ℂ) η → dist w 1 < 1 → tightModel w ≠ 1) :=
  centre isOpen_tightModelDom isWeakColouringOn_tightModel (Or.inl (Or.inl (mem_ball_self (by norm_num))))
    isTight_tightModel

/-- The model, read through C124-STRADDLE at `p = 1 + i`. -/
example : ∃ η > 0, ∀ᵐ w, w ∈ ball (1 + I : ℂ) η → tightModel w ≠ 0 ∧ tightModel w ≠ 1 := by
  sorry

/-- **Adversary** for the definition of a tight pair: a pair is not tight for a label and itself. -/
example (U : Set ℂ) (c : ℂ → α) (q z : ℂ) (a : α) : ¬ IsTight U c q z a a :=
  fun ⟨_, h⟩ => h.ne rfl

/-- **Adversary** for inner and outer: the disc of radius `1/2` about `0` is inner at `0`, not outer, and not
crossing. -/
example : InnerAt (ball (0 : ℂ) (1 / 2)) 0 ∧ ¬ OuterAt (ball (0 : ℂ) (1 / 2)) 0 ∧
    ¬ CrossingAt (ball (0 : ℂ) (1 / 2)) 0 := by
  sorry

/-- The disc of radius `1/2` about `1` is crossing at `0`. -/
example : CrossingAt (ball (1 : ℂ) (1 / 2)) 0 := by
  sorry

end HadwigerNelson.Plane

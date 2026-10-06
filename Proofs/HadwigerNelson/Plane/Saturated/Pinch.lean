import Proofs.HadwigerNelson.Plane.Saturated.Basic
import Proofs.HadwigerNelson.Plane.Diameter

/-!
# The pinch at an interface point (FS-131 wave 6)

Rows of `plans/LEAN-BACKLOG.md`, each at the class its argument reads (`plans/FS131-w6-kernel-plan.md` §§ 2, 4):

* **FS121-D3-FALLSAT** — `saturated_of_forall_isMUA`: a family of maximal unit-avoiding sets is saturated; no partition is
  read. `AeColouring.saturated_of_idomatic` is the row's own form. **Proved.**
* **FS111-M-HALF** — `half_dichotomy` (a preconnected piece of `S̃` lies in the closed unit disc about a contact or
  misses the open one; one class, no colouring; **proved**) and `half_upperDensity` (upper density at most `1/2`).
* **FS111-M-PINCH** — `pinch` (for given contacts: split, one way or the other, or tangent), `pinch_not_in_in`,
  `pinch_interface` (every interface point of a saturated colouring).
* **FS111-M-C11**, clauses (i) and (iii) — `c11_discs`, `c11_split`. Clause (ii), the `C^{1,1}` graph, is the second
  planning pass's (the plan's § 5).
* **FS121-V2-EROSION-DIAM** — `erosion_diam`, `erosion_diam_cot`: two straight pieces from `z` in the closure of one
  preconnected unit-distance-free set. No sector and no colouring is read. **Proved.**

**Inhabitants.** FALLSAT: `r7Cls` (`r7Cls_isMaximalCover` with `isMaximalCover_iff`, seven MUA sets). PINCH and C11:
`sq9` at `sqEdgePt` (`sq9_twoColourAt`; saturated by `sq9_tight_saturated`), of tangent type (`sq9_isTangentAt`).
HALF: any class of `sq9` with a contact. EROSION-DIAM: an open square of side `1/2` at a corner.
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Filter Topology Metric

variable {k : ℕ}

/-! ## FS121-D3-FALLSAT -/

/-- A point whose unit circle misses the support of a MUA set `A` has a ball almost everywhere inside `A`
(`IsMUA.interior_union_unitShadow`'s argument, kept at the ball: for an irregular MUA set `int (supp A)` is larger). -/
theorem IsMUA.exists_ball_ae_subset {A : Set ℂ} (hA : IsMUA A) {z : ℂ} (hz : z ∉ unitShadow (essSupport A)) :
    ∃ δ > 0, (ball z δ : Set ℂ) ≤ᵐ[volume] A := by
  obtain ⟨hAm, hAn, hmax⟩ := hA
  have hnone : ∀ y ∈ essSupport A, dist z y ≠ 1 := fun y hy h => hz ⟨y, hy, h⟩
  obtain ⟨δ, hδ0, hδ, hann⟩ := exists_annulus_subset_compl (isClosed_essSupport A) hnone
  set B : Set ℂ := ball z δ with hB
  have hN : volume (A \ essSupport A) = 0 := volume_diff_essSupport A
  have h1 : (volume.prod arcLength) {q : ℂ × ℝ | q.1 ∈ A \ essSupport A} = 0 := by
    have : {q : ℂ × ℝ | q.1 ∈ A \ essSupport A} = (A \ essSupport A) ×ˢ univ := by ext q; simp
    rw [this, Measure.prod_prod, hN, zero_mul]
  have h2 := volume_prod_shift_null hN
  have hA' : UnitPairsNull (A ∪ B) := by
    refine measure_mono_null (t := unitPairSet A ∪ {q : ℂ × ℝ | q.1 ∈ A \ essSupport A} ∪
      {q : ℂ × ℝ | q.1 + e q.2 ∈ A \ essSupport A}) ?_ (measure_union_null (measure_union_null hAn h1) h2)
    rintro ⟨x, θ⟩ ⟨hx, hxe⟩
    simp only [unitPairSet] at hx hxe ⊢
    have hnorm : dist x (x + e θ) = 1 := by rw [dist_eq_norm, sub_add_cancel_left, norm_neg, norm_e]
    rcases hx with hx | hx <;> rcases hxe with hxe | hxe
    · exact Or.inl (Or.inl ⟨hx, hxe⟩)
    · -- `x ∈ A`, `x + e θ ∈ B`: `x` lies in the annulus about `z`
      refine Or.inl (Or.inr ⟨hx, fun hF => hann x ?_ hF⟩)
      rw [mem_ball] at hxe
      have t1 := dist_triangle x (x + e θ) z
      have t2 := dist_triangle x z (x + e θ)
      rw [dist_comm z (x + e θ)] at t2
      rw [abs_sub_lt_iff]; constructor <;> linarith
    · refine Or.inr ⟨hxe, fun hF => hann (x + e θ) ?_ hF⟩
      rw [mem_ball] at hx
      have t1 := dist_triangle (x + e θ) x z
      have t2 := dist_triangle x z (x + e θ)
      rw [dist_comm (x + e θ) x] at t1
      rw [dist_comm z (x + e θ)] at t2
      rw [abs_sub_lt_iff]; constructor <;> linarith
    · exfalso
      rw [mem_ball] at hx hxe
      have t1 := dist_triangle x z (x + e θ)
      rw [dist_comm z (x + e θ)] at t1
      linarith
  have hle : A ≤ᵐ[volume] (A ∪ B : Set ℂ) := Eventually.of_forall fun x hx => Or.inl hx
  have hBA : (A ∪ B : Set ℂ) ≤ᵐ[volume] A := hmax (A ∪ B) (hAm.union measurableSet_ball) hA' hle
  have hB : (B : Set ℂ) ≤ᵐ[volume] (A ∪ B : Set ℂ) := Eventually.of_forall fun x hx => Or.inr hx
  exact ⟨δ, hδ0, Filter.EventuallyLE.trans hB hBA⟩

/-- **FS121-D3-FALLSAT**, at the class its argument reads: every family of maximal unit-avoiding sets is saturated —
each essential boundary point of each class is a contact point of that class. The row's partition is not read. -/
theorem saturated_of_forall_isMUA {C : Fin k → Set ℂ} (h : ∀ j, IsMUA (C j)) : Saturated C := by
  intro j x hx
  by_contra hc
  have hz : x ∉ unitShadow (essSupport (C j)) := by
    rintro ⟨y, hy, hxy⟩
    exact hc ⟨y, by rwa [← essSupport_eq_closure_densitySet], hxy⟩
  obtain ⟨δ, hδ, hsub⟩ := (h j).exists_ball_ae_subset hz
  exact hx.2 (subset_densitySet_of_isOpen_ae_subset isOpen_ball hsub (mem_ball_self hδ))

/-- **FS121-D3-FALLSAT**, the row's form: a colouring whose classes are each maximal among measurable sets with null
unit pairs (a measurable idomatic partition) is saturated; honest and a.e.-proper are the type. -/
theorem AeColouring.saturated_of_idomatic (c : AeColouring k) (h : ∀ j, IsMUA (c.cls j)) : Saturated c.cls :=
  saturated_of_forall_isMUA h

/-- Inhabitant of FALLSAT's hypothesis: R7's seven classes are MUA sets, so the theorem gives `r7Cls_saturated` again. -/
example : Saturated r7Cls :=
  saturated_of_forall_isMUA ((isMaximalCover_iff fun j => (r7Cls_isMaximalCover.1.1 j).1).1 r7Cls_isMaximalCover).1

/-! ## FS111-M-HALF -/

/-- **FS111-M-HALF**, the dichotomy (FS111-M-PINCH's Step 1): for one measurable set `A` with null unit pairs and a point
`y` of `supp A`, a preconnected piece `P` of the density set lies in the closed unit disc about `y` or misses the open
one. With `|x − y| = 1` these are the two half-planes of every blow-up at `x`. -/
theorem half_dichotomy {A : Set ℂ} (hA : MeasurableSet A) (hnull : UnitPairsNull A) {y : ℂ}
    (hy : y ∈ closure (densitySet A)) {P : Set ℂ} (hP : IsPreconnected P) (hPA : P ⊆ densitySet A) :
    P ⊆ closedBall y 1 ∨ Disjoint P (ball y 1) := by
  by_contra hcon
  rw [not_or] at hcon
  obtain ⟨hout, hin⟩ := hcon
  obtain ⟨p, hpP, hp⟩ := Set.not_subset.mp hout
  obtain ⟨p', hp'P, hp'⟩ := Set.not_disjoint_iff.mp hin
  rw [mem_closedBall, not_le] at hp
  rw [mem_ball] at hp'
  obtain ⟨q, hq, hqy⟩ := Metric.mem_closure_iff.mp hy (min (dist p y - 1) (1 - dist p' y))
    (lt_min (by linarith) (by linarith))
  have h1 : dist y q < dist p y - 1 := lt_of_lt_of_le hqy (min_le_left _ _)
  have h2 : dist y q < 1 - dist p' y := lt_of_lt_of_le hqy (min_le_right _ _)
  rcases hullset hA hnull hP hPA (upperDensityAt_pos_of_mem_densitySet hq) with h | h
  · have := h p hpP
    have t := dist_triangle p q y
    rw [dist_comm q p] at this
    rw [dist_comm q y] at t
    linarith
  · have := h p' hp'P
    have t := dist_triangle q y p'
    rw [dist_comm q y, dist_comm y p'] at t
    linarith

/-- **FS111-M-HALF**, the density form: at a point `x` with a contact `y` (`|x − y| = 1`, `y ∈ supp A`), every
preconnected piece of the density set has upper density at most `1/2` at `x` — no colour takes a reflex angle at a
saturated point. -/
theorem half_upperDensity {A : Set ℂ} (hA : MeasurableSet A) (hnull : UnitPairsNull A) {x y : ℂ}
    (hy : y ∈ closure (densitySet A)) (hxy : dist x y = 1) {P : Set ℂ} (hP : IsPreconnected P)
    (hPA : P ⊆ densitySet A) : upperDensityAt P x ≤ 1 / 2 := by
  sorry

/-! ## FS111-M-PINCH -/

/-- `sq9` at the edge point is of tangent type: beyond `sq9_hasTwoDiscsAt`, the contacts `sqEdgePt ± 1` lie in the
supports of the two squares' colours (the squares one unit to the right and to the left). -/
theorem sq9_isTangentAt : sq9.IsTangentAt sqEdgePt (1 / 8) sqColA sqColB 1 := by
  sorry

/-- **FS111-M-PINCH.** At a point `x` with (H1), (H2) in `N = B(x, ρ)` for the colours `a`, `b`, and contacts `ya` of
`a`, `yb` of `b` (points of the supports at distance exactly `1`; no density of the partner is asked): either
`ya = yb` and `N` is split by the unit circle about it, `a` inside and `b` outside or the reverse, or the contacts are
antipodal and `x` is of tangent type with normal `ya − x` into `b`. -/
theorem pinch (c : AeColouring k) {x : ℂ} {ρ : ℝ} {a b : Fin k} (h : c.TwoColourAt x ρ a b) {ya yb : ℂ}
    (hya : ya ∈ essSupport (c.cls a)) (hxa : dist x ya = 1) (hyb : yb ∈ essSupport (c.cls b)) (hxb : dist x yb = 1) :
    (ya = yb ∧ (c.IsSplitAt x ρ a b ya ∨ c.IsSplitAt x ρ b a ya)) ∨
      (yb - x = -(ya - x) ∧ c.IsTangentAt x ρ a b (ya - x)) := by
  sorry

/-- **FS111-M-PINCH**, "the case (in, in) is impossible": the two classes do not both lie, within `N`, in the closed
unit discs about their contacts. A refutation; its hypotheses without the last are `pinch`'s, inhabited by `sq9` at
`sqEdgePt` (`sq9_twoColourAt`), where the last fails. -/
theorem pinch_not_in_in (c : AeColouring k) {x : ℂ} {ρ : ℝ} {a b : Fin k} (h : c.TwoColourAt x ρ a b) {ya yb : ℂ}
    (hxa : dist x ya = 1) (hxb : dist x yb = 1)
    (hin : (c.cls a ∩ ball x ρ : Set ℂ) ≤ᵐ[volume] closedBall ya 1 ∧
      (c.cls b ∩ ball x ρ : Set ℂ) ≤ᵐ[volume] closedBall yb 1) : False := by
  sorry

/-- **FS111-M-PINCH** at the points it is used: in a saturated colouring every interface point has a two-colour
neighbourhood in which it is of split type (`a` inside) or of tangent type. -/
theorem pinch_interface (c : AeColouring k) (hsat : Saturated c.cls) {x : ℂ} (hx : x ∈ c.interfaceSet) :
    ∃ ρ a b, c.TwoColourAt x ρ a b ∧ ((∃ y, c.IsSplitAt x ρ a b y) ∨ ∃ ν, c.IsTangentAt x ρ a b ν) := by
  sorry

/-! ## FS111-M-C11, clauses (i) and (iii) -/

/-- **FS111-M-C11 (i).** In a saturated colouring every interface point carries two open unit discs tangent there from
opposite sides, one in each of its two colours (within `N`, up to null sets) — at the split type as at the tangent
type. -/
theorem c11_discs (c : AeColouring k) (hsat : Saturated c.cls) {x : ℂ} (hx : x ∈ c.interfaceSet) :
    ∃ ρ a b ν, c.TwoColourAt x ρ a b ∧ c.HasTwoDiscsAt x ρ a b ν := by
  sorry

/-- **FS111-M-C11 (iii).** If `x` is of split type in `N = B(x, ρ)` about `y`, the essential boundary in `N` is the arc
of the unit circle about `y`. -/
theorem c11_split (c : AeColouring k) {x : ℂ} {ρ : ℝ} {a b : Fin k} {y : ℂ} (h : c.IsSplitAt x ρ a b y) :
    c.essBdry ∩ ball x ρ = sphere y 1 ∩ ball x ρ := by
  sorry

/-! ## FS121-V2-EROSION-DIAM -/

/-- Two points of the closure of a preconnected set with no two points at distance `1` are at distance at most `1`. -/
theorem dist_le_one_of_mem_closure {D : Set ℂ} (hD : IsPreconnected D) (hfree : ∀ p ∈ D, ∀ q ∈ D, dist p q ≠ 1)
    {p q : ℂ} (hp : p ∈ closure D) (hq : q ∈ closure D) : dist p q ≤ 1 := by
  have hlt := dist_lt_one_of_forall_dist_ne_one hD hfree
  have h1 : (p, q) ∈ closure (D ×ˢ D) := by rw [closure_prod_eq]; exact ⟨hp, hq⟩
  have h2 : IsClosed {w : ℂ × ℂ | dist w.1 w.2 ≤ 1} :=
    isClosed_le (continuous_fst.dist continuous_snd) continuous_const
  exact closure_minimal (fun w hw => (hlt w.1 hw.1 w.2 hw.2).le) h2 h1

/-- **FS121-V2-EROSION-DIAM**, at the class its argument reads: if the straight pieces `[z, z + L₁ e α]` and
`[z, z + L₂ e β]`, at an angle `θ = β − α ∈ (0, π)`, end in the closure of one preconnected set with no two points at
distance `1` (a component of a colour, in any a.e.-proper colouring), then `min(L₁, L₂) ≤ 1 / (2 sin (θ/2))`. The
colour's sector between the pieces is not read. -/
theorem erosion_diam {D : Set ℂ} (hD : IsPreconnected D) (hfree : ∀ p ∈ D, ∀ q ∈ D, dist p q ≠ 1) {z : ℂ}
    {α β L₁ L₂ : ℝ} (hαβ : α < β) (hβα : β - α < Real.pi) (hL₁ : 0 ≤ L₁) (hL₂ : 0 ≤ L₂)
    (h₁ : ∀ t ∈ Icc 0 L₁, z + (t : ℂ) * e α ∈ closure D) (h₂ : ∀ t ∈ Icc 0 L₂, z + (t : ℂ) * e β ∈ closure D) :
    min L₁ L₂ ≤ 1 / (2 * Real.sin ((β - α) / 2)) := by
  set m := min L₁ L₂ with hm
  have hm0 : 0 ≤ m := le_min hL₁ hL₂
  have hd := dist_le_one_of_mem_closure hD hfree (h₁ m ⟨hm0, min_le_left _ _⟩) (h₂ m ⟨hm0, min_le_right _ _⟩)
  have hring : dist (ringPt 0 α) (ringPt 0 β) = 2 * Real.sin ((β - α) / 2) := by
    rw [dist_ringPt_ringPt 0 (by rw [abs_sub_comm, abs_of_pos (by linarith)]; exact hβα.le), abs_sub_comm,
      abs_of_pos (by linarith)]
  have hdist : dist (z + (m : ℂ) * e α) (z + (m : ℂ) * e β) = m * (2 * Real.sin ((β - α) / 2)) := by
    rw [← hring, dist_eq_norm, dist_eq_norm, add_sub_add_left_eq_sub, ← mul_sub, norm_mul, Complex.norm_real,
      Real.norm_eq_abs, abs_of_nonneg hm0]
    simp [ringPt]
  have hsin : 0 < Real.sin ((β - α) / 2) := Real.sin_pos_of_pos_of_lt_pi (by linarith) (by linarith [Real.pi_pos])
  rw [hdist] at hd
  rw [le_div_iff₀ (by positivity)]
  exact hd

/-- **FS121-V2-EROSION-DIAM**, the "so" clause: for `θ ≤ 2π/3` the bound is at most `cot (θ/2)`. -/
theorem erosion_diam_cot {D : Set ℂ} (hD : IsPreconnected D) (hfree : ∀ p ∈ D, ∀ q ∈ D, dist p q ≠ 1) {z : ℂ}
    {α β L₁ L₂ : ℝ} (hαβ : α < β) (hβα : β - α ≤ 2 * Real.pi / 3) (hL₁ : 0 ≤ L₁) (hL₂ : 0 ≤ L₂)
    (h₁ : ∀ t ∈ Icc 0 L₁, z + (t : ℂ) * e α ∈ closure D) (h₂ : ∀ t ∈ Icc 0 L₂, z + (t : ℂ) * e β ∈ closure D) :
    min L₁ L₂ ≤ Real.cos ((β - α) / 2) / Real.sin ((β - α) / 2) := by
  have hpi := Real.pi_pos
  have h := erosion_diam hD hfree hαβ (by linarith) hL₁ hL₂ h₁ h₂
  have hsin : 0 < Real.sin ((β - α) / 2) := Real.sin_pos_of_pos_of_lt_pi (by linarith) (by linarith)
  have hcos : 1 / 2 ≤ Real.cos ((β - α) / 2) := by
    rw [← Real.cos_pi_div_three]
    exact Real.cos_le_cos_of_nonneg_of_le_pi (by linarith) (by linarith) (by linarith)
  refine h.trans ?_
  rw [div_le_div_iff₀ (by positivity) hsin]
  nlinarith

/-- Spec for `erosion_diam`: at a right angle the bound is `1/√2` — two pieces of length `1/2` (a square of side `1/2`)
pass, two of length `3/4` do not. -/
example : (1 / 2 : ℝ) ≤ 1 / (2 * Real.sin ((Real.pi / 2 - 0) / 2)) ∧ ¬ (3 / 4 : ℝ) ≤ 1 / (2 * Real.sin ((Real.pi / 2 - 0) / 2)) := by
  rw [sub_zero, show Real.pi / 2 / 2 = Real.pi / 4 by ring, Real.sin_pi_div_four]
  have h2 : (0 : ℝ) < √2 := by positivity
  have h3 : √2 * √2 = 2 := Real.mul_self_sqrt (by norm_num)
  constructor
  · rw [le_div_iff₀ (by positivity)]; nlinarith
  · rw [not_le, div_lt_iff₀ (by positivity)]; nlinarith

end HadwigerNelson.Plane

import Proofs.HadwigerNelson.Plane.Saturated.Basic
import Proofs.HadwigerNelson.Plane.Diameter

/-!
# The pinch at an interface point (FS-131 wave 6)

Rows of `plans/LEAN-BACKLOG.md`, each at the class its argument reads (`plans/FS131-w6-kernel-plan.md` §§ 2, 4):

* **FS121-D3-FALLSAT** — `saturated_of_forall_isMUA`: a family of maximal unit-avoiding sets is saturated; no partition is
  read. `AeColouring.saturated_of_idomatic` is the row's own form. **Proved.**
* **FS111-M-HALF** — `half_dichotomy` (a preconnected piece of `S̃` lies in the closed unit disc about a contact or
  misses the open one; one class, no colouring; **proved**) and `half_upperDensity` (upper density at most `1/2`).
* **FS111-M-PINCH** — `pinch` (two sets on an open set `N`, any point of `N`, given contacts: split, one way or the
  other, or tangent), `pinch_not_in_in`, `pinch_interface` (every interface point of a family, where it is saturated).
* **FS111-M-C11**, clauses (i) and (iii) — `c11_discs` (every point of the one `N`), `c11_discs_interface`,
  `c11_split`. Clause (ii), the `C^{1,1}` graph, is FS131-E8-LOCAL (`Plane/Saturated/LocalGraph`).
* **FS121-V2-EROSION-DIAM** — `erosion_diam`, `erosion_diam_cot`: two straight pieces from `z` in the closure of one
  preconnected unit-distance-free set. No sector and no colouring is read. **Proved.**

**Inhabitants.** FALLSAT: `r7Cls` (`r7Cls_isMaximalCover` with `isMaximalCover_iff`, seven MUA sets). PINCH and C11:
`sq9` at `sqEdgePt` (`sq9_twoColourNhd`; saturated by `sq9_tight_saturated`), of tangent type (`sq9_isTangentAt`).
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
theorem sq9_isTangentAt :
    IsTangentAt (sq9.cls sqColA) (sq9.cls sqColB) (ball sqEdgePt (1 / 8)) sqEdgePt 1 := by
  sorry

/-- **FS111-M-PINCH**, at the class its argument reads: two measurable sets `A`, `B` with null unit pairs, an open set
`N` on which they satisfy the row's hypotheses (`TwoColourOn`: (H1) as "cover and almost disjoint", (H2) for each), a
point `x` of `N` — any point, `N` is not centred at it — and contacts `ya` of `A`, `yb` of `B` (points of the supports
at distance exactly `1`; no density of the partner is asked). Either `ya = yb` and `N` is split by the unit circle
about it, `A` inside and `B` outside or the reverse, or the contacts are antipodal and `x` is of tangent type with
normal `ya − x` into `B`. No colouring, no third class and no family is read. -/
theorem pinch {A B N : Set ℂ} (hA : MeasurableSet A) (hAn : UnitPairsNull A) (hB : MeasurableSet B)
    (hBn : UnitPairsNull B) (h : TwoColourOn A B N) {x ya yb : ℂ} (hx : x ∈ N)
    (hya : ya ∈ essSupport A) (hxa : dist x ya = 1) (hyb : yb ∈ essSupport B) (hxb : dist x yb = 1) :
    (ya = yb ∧ (IsSplitAt A B N x ya ∨ IsSplitAt B A N x ya)) ∨
      (yb - x = -(ya - x) ∧ IsTangentAt A B N x (ya - x)) := by
  sorry

/-- **FS111-M-PINCH**, "the case (in, in) is impossible", at the class its argument reads: if an open set `N` is
almost everywhere `A ∪ B`, no point `x` of `N` on the unit circles about `ya` and `yb` has `A` and `B` both, within
`N`, in the closed unit discs about them. Neither (H2), nor almost-disjointness, nor measurability is read.
A refutation; its hypotheses without the last are met by `sq9` at `sqEdgePt` (`sq9_twoColourNhd`, with
`ya = sqEdgePt + 1`, `yb = sqEdgePt - 1`), where the last fails. -/
theorem pinch_not_in_in {A B N : Set ℂ} (hN : IsOpen N) (hcover : (N : Set ℂ) ≤ᵐ[volume] (A ∪ B : Set ℂ))
    {x ya yb : ℂ} (hx : x ∈ N) (hxa : dist x ya = 1) (hxb : dist x yb = 1)
    (hin : (A ∩ N : Set ℂ) ≤ᵐ[volume] closedBall ya 1 ∧ (B ∩ N : Set ℂ) ≤ᵐ[volume] closedBall yb 1) : False := by
  sorry

/-- In a two-colour open set the two sets have the same essential boundary: where one is neither of density `1` nor
of density `0`, so is the other (the density ratios of `A` and `B` sum to `1` in small balls). -/
theorem TwoColourOn.essBoundary_inter_eq {A B N : Set ℂ} (hA : MeasurableSet A) (hB : MeasurableSet B)
    (h : TwoColourOn A B N) : essBoundary A ∩ N = essBoundary B ∩ N := by
  sorry

/-- In a two-colour neighbourhood of a family, an essential boundary point of the family is an essential boundary
point of both classes (a third class is null near it). With `cl P = supp` inside `N` this is the frozen (H2)'s clause
`x ∈ cl P_a ∩ cl P_b`. -/
theorem TwoColourNhd.mem_essBoundary {C : Fin k → Set ℂ} (hm : ∀ j, MeasurableSet (C j)) {N : Set ℂ} {a b : Fin k}
    (h : TwoColourNhd C N a b) {x : ℂ} (hx : x ∈ N) (hxb : x ∈ essBdry C) :
    x ∈ essBoundary (C a) ∧ x ∈ essBoundary (C b) := by
  obtain ⟨j, hj⟩ := mem_iUnion.1 hxb
  have key := h.two.essBoundary_inter_eq (hm a) (hm b)
  by_cases hja : j = a
  · subst hja
    exact ⟨hj, (key.subset ⟨hj, hx⟩).1⟩
  · by_cases hjb : j = b
    · subst hjb
      exact ⟨(key.superset ⟨hj, hx⟩).1, hj⟩
    · exfalso
      obtain ⟨r, hr, hsub⟩ := Metric.isOpen_iff.1 h.two.isOpen x hx
      have h0 : ∀ s, 0 < s → s ≤ r / 2 → volume (C j ∩ closedBall x s) = 0 := fun s _ hs =>
        measure_mono_null (inter_subset_inter_right _ ((closedBall_subset_ball (by linarith)).trans hsub))
          (h.h1 j hja hjb)
      exact (ne_of_gt hj.1) (upperDensityAt_eq_zero_of_null (half_pos hr) h0)

/-- **FS111-M-PINCH** at the points it is used, for a family (a colouring's classes: `c.cls`, with
`c.isAeCover.1`): at an interface point where the family is saturated, some ball centred there is a two-colour
neighbourhood in which the point is of split type (`a` inside) or of tangent type. -/
theorem pinch_interface {C : Fin k → Set ℂ} (hC : IsAdmissible C) {U : Set ℂ} (hsat : SaturatedOn C U) {x : ℂ}
    (hxU : x ∈ U) (hx : x ∈ interfaceSet C) :
    ∃ ρ a b, TwoColourNhd C (ball x ρ) a b ∧
      ((∃ y, IsSplitAt (C a) (C b) (ball x ρ) x y) ∨ ∃ ν, IsTangentAt (C a) (C b) (ball x ρ) x ν) := by
  obtain ⟨ρ, a, b, h⟩ := exists_twoColourNhd_of_mem_interfaceSet hx
  have hxN : x ∈ ball x ρ := mem_ball_self h.radius_pos
  obtain ⟨hxa, hxb⟩ := h.mem_essBoundary (fun j => (hC j).1) hxN hx.1
  obtain ⟨ya, hya, hda⟩ := hsat a x ⟨hxa, hxU⟩
  obtain ⟨yb, hyb, hdb⟩ := hsat b x ⟨hxb, hxU⟩
  rw [← essSupport_eq_closure_densitySet] at hya hyb
  rcases pinch (hC a).1 (hC a).2 (hC b).1 (hC b).2 h.two hxN hya hda hyb hdb with ⟨rfl, hs | hs⟩ | ⟨-, ht⟩
  · exact ⟨ρ, a, b, h, Or.inl ⟨ya, hs⟩⟩
  · exact ⟨ρ, b, a, h.symm, Or.inl ⟨ya, hs⟩⟩
  · exact ⟨ρ, a, b, h, Or.inr ⟨_, ht⟩⟩

/-! ## FS111-M-C11, clauses (i) and (iii) -/

/-- **FS111-M-C11 (i)**, at the class its argument reads: in a two-colour open set `N`, every point of `N` with a
contact of `A` and a contact of `B` — every point, with the one `N` — carries two open unit discs tangent there from
opposite sides, one in each set (within `N`, up to null sets): at the split type as at the tangent type. (At a point
of `N` off the common essential boundary the two contacts cannot both exist.) -/
theorem c11_discs {A B N : Set ℂ} (hA : MeasurableSet A) (hAn : UnitPairsNull A) (hB : MeasurableSet B)
    (hBn : UnitPairsNull B) (h : TwoColourOn A B N) {x : ℂ} (hx : x ∈ N) (hcA : IsContactFor A x)
    (hcB : IsContactFor B x) : ∃ ν, HasTwoDiscsAt A B N x ν := by
  sorry

/-- **FS111-M-C11 (i)** at an interface point of a family saturated there: a two-colour ball centred at the point,
and the two tangent unit discs in it. -/
theorem c11_discs_interface {C : Fin k → Set ℂ} (hC : IsAdmissible C) {U : Set ℂ} (hsat : SaturatedOn C U) {x : ℂ}
    (hxU : x ∈ U) (hx : x ∈ interfaceSet C) :
    ∃ ρ a b ν, TwoColourNhd C (ball x ρ) a b ∧ HasTwoDiscsAt (C a) (C b) (ball x ρ) x ν := by
  obtain ⟨ρ, a, b, h⟩ := exists_twoColourNhd_of_mem_interfaceSet hx
  have hxN : x ∈ ball x ρ := mem_ball_self h.radius_pos
  obtain ⟨hxa, hxb⟩ := h.mem_essBoundary (fun j => (hC j).1) hxN hx.1
  obtain ⟨ν, hν⟩ := c11_discs (hC a).1 (hC a).2 (hC b).1 (hC b).2 h.two hxN (hsat a x ⟨hxa, hxU⟩)
    (hsat b x ⟨hxb, hxU⟩)
  exact ⟨ρ, a, b, ν, h, hν⟩

/-- **FS111-M-C11 (iii).** If some point is of split type in the open set `N` about `y`, the essential boundary of
each of the two sets in `N` is the arc of the unit circle about `y`. -/
theorem c11_split {A B N : Set ℂ} (hN : IsOpen N) {x y : ℂ} (h : IsSplitAt A B N x y) :
    essBoundary A ∩ N = sphere y 1 ∩ N ∧ essBoundary B ∩ N = sphere y 1 ∩ N := by
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

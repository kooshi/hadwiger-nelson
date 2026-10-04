import Proofs.HadwigerNelson.Plane.Suprema
import Proofs.HadwigerNelson.Plane.DensityPoints
import Mathlib.Analysis.Calculus.DerivativeTest

/-!
# Fills, maximal covers, shadows, Grundy colourings (FS-131 wave 2)

Rows: **FS111-C-FILL**, **FS111-M-SATC**, **FS111-M2-COV**, **FS111-M2-FIX**, **FS111-M-COVER-SC** (its second clause in
the corrected curvature form, ruling: `plans/FS131-close-inventory.md` items 18–19), **FS121-D3-GRUNDY**.
Plan: `plans/FS131-w2-kernel-plan.md` § 4. Every class is a set in a family `Fin k → Set ℂ` (`Plane/Cover`).
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Filter Topology Metric

variable {k : ℕ}

/-! ## One MUA set's shadow -/

/-- **FS111-M-SATC (ii) for one MUA set**: `ℝ² = int (supp A) ∪ (supp A + S¹)`. -/
theorem IsMUA.interior_union_unitShadow {A : Set ℂ} (hA : IsMUA A) :
    interior (essSupport A) ∪ unitShadow (essSupport A) = univ := by
  refine eq_univ_of_forall fun z => ?_
  by_cases hz : z ∈ unitShadow (essSupport A)
  · exact Or.inr hz
  left
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
  have hsub : ball z δ ⊆ essSupport A := by
    intro y hy r hr
    have hy' := mem_ball.1 hy
    set ρ := min r (δ - dist y z) with hρ
    have hρ0 : 0 < ρ := lt_min hr (by linarith)
    have hρB : ball y ρ ⊆ B := fun w hw => by
      rw [mem_ball] at hw ⊢
      have := dist_triangle w y z
      have := min_le_right r (δ - dist y z)
      linarith
    have : volume (ball y ρ) ≤ volume (A ∩ ball y r) := by
      refine measure_mono_ae ?_
      filter_upwards [hBA] with w hw hwb
      exact ⟨hw (Or.inr (hρB hwb)), ball_subset_ball (min_le_left _ _) hwb⟩
    exact lt_of_lt_of_le (measure_ball_pos volume y hρ0) this
  exact mem_interior.2 ⟨ball z δ, hsub, isOpen_ball, mem_ball_self hδ0⟩


open scoped Classical in
/-- The fill move: the constant colour `j` on the open disc `B(x, ρ)`, the colouring `c` elsewhere. -/
noncomputable def AeColouring.fillCol (c : AeColouring k) (x : ℂ) (ρ : ℝ) (j : Fin k) : ℂ → Fin k :=
  fun y => if y ∈ ball x ρ then j else c.col y

/-- **FS111-C-FILL**: if `x` is `j`-free with `|S̃_j ∩ A_η(x)| = 0`, the fill move on `B(x, η/2)` with colour `j` keeps the
colouring a.e.-proper with `k` colours. -/
theorem AeColouring.exists_fill (c : AeColouring k) {j : Fin k} {x : ℂ} {η : ℝ} (hx : x ∈ essClosure (c.cls j))
    (hη : 0 < η) (hfree : volume (densitySet (c.cls j) ∩ unitAnnulus x η) = 0) :
    ∃ c' : AeColouring k, c'.col = c.fillCol x (η / 2) j := by
  classical
  set A := c.cls j with hAdef
  set ρ : ℝ := η / 2 with hρ
  -- `A` meets the unit annulus about `x` in a null set
  have hN : volume (A ∩ unitAnnulus x η) = 0 := by
    have h1 : volume (A \ densitySet A) = 0 := volume_diff_densitySet (c.measurableSet_cls j)
    refine measure_mono_null (fun y hy => ?_) (measure_union_null h1 hfree)
    by_cases hyd : y ∈ densitySet A
    · exact Or.inr ⟨hyd, hy.2⟩
    · exact Or.inl ⟨hy.1, hyd⟩
  -- so `η < 1`: otherwise the annulus holds a whole ball about `x`
  have hη1 : η < 1 := by
    by_contra hcon
    push Not at hcon
    have h0 : upperDensityAt A x = 0 := by
      refine upperDensityAt_eq_zero_of_null one_pos fun r hr hr1 => ?_
      refine measure_mono_null (t := A ∩ unitAnnulus x η) (fun y hy => ⟨hy.1, ?_⟩) hN
      have := mem_closedBall.1 hy.2
      show |dist y x - 1| ≤ η
      rw [abs_le]; constructor <;> linarith [dist_nonneg (x := y) (y := x)]
    exact absurd h0 hx.ne'
  have hji : ∀ i : Fin k, ¬ i = j → ¬ j = i := fun i hi h => hi h.symm
  -- the new class `j` is `A ∪ B(x, ρ)`
  have hcol : ∀ i, (c.fillCol x ρ j) ⁻¹' {i} = if i = j then (A ∪ ball x ρ) else (c.cls i \ ball x ρ) := by
    intro i
    ext y
    by_cases hy : y ∈ ball x ρ
    · by_cases hi : i = j <;> simp [AeColouring.fillCol, hy, hi, hAdef, AeColouring.cls, hji i, eq_comm]
    · by_cases hi : i = j <;> simp [AeColouring.fillCol, hy, hi, hAdef, AeColouring.cls, eq_comm]
  have hmeas : Measurable (c.fillCol x ρ j) := by
    unfold AeColouring.fillCol
    exact Measurable.ite measurableSet_ball measurable_const c.measurable
  refine ⟨⟨c.fillCol x ρ j, hmeas, fun i => ?_⟩, rfl⟩
  rw [hcol]
  split_ifs with hi
  · -- class `j`: `A`, the ball, and the pairs between them
    have h1 : (volume.prod arcLength) {q : ℂ × ℝ | q.1 ∈ A ∩ unitAnnulus x η} = 0 := by
      have : {q : ℂ × ℝ | q.1 ∈ A ∩ unitAnnulus x η} = (A ∩ unitAnnulus x η) ×ˢ univ := by ext q; simp
      rw [this, Measure.prod_prod, hN, zero_mul]
    have h2 := volume_prod_shift_null hN
    refine measure_mono_null (t := unitPairSet A ∪ {q : ℂ × ℝ | q.1 ∈ A ∩ unitAnnulus x η} ∪
      {q : ℂ × ℝ | q.1 + e q.2 ∈ A ∩ unitAnnulus x η}) ?_
      (measure_union_null (measure_union_null (c.unitPairsNull j) h1) h2)
    rintro ⟨p, θ⟩ ⟨hp, hpe⟩
    simp only [unitPairSet] at hp hpe ⊢
    have hnorm : dist p (p + e θ) = 1 := by rw [dist_eq_norm, sub_add_cancel_left, norm_neg, norm_e]
    rcases hp with hp | hp <;> rcases hpe with hpe | hpe
    · exact Or.inl (Or.inl ⟨hp, hpe⟩)
    · refine Or.inl (Or.inr ⟨hp, ?_⟩)
      rw [mem_ball] at hpe
      have t1 := dist_triangle p (p + e θ) x
      have t2 := dist_triangle p x (p + e θ)
      rw [dist_comm x (p + e θ)] at t2
      show |dist p x - 1| ≤ η
      rw [abs_le]; constructor <;> linarith
    · refine Or.inr ⟨hpe, ?_⟩
      rw [mem_ball] at hp
      have t1 := dist_triangle (p + e θ) p x
      have t2 := dist_triangle p x (p + e θ)
      rw [dist_comm (p + e θ) p] at t1
      rw [dist_comm x (p + e θ)] at t2
      show |dist (p + e θ) x - 1| ≤ η
      rw [abs_le]; constructor <;> linarith
    · exfalso
      rw [mem_ball] at hp hpe
      have t1 := dist_triangle p x (p + e θ)
      rw [dist_comm x (p + e θ)] at t1
      linarith
  · exact (c.unitPairsNull i).mono sdiff_subset

/-- **FS111-M2-COV**: a `k`-tuple of measurable sets is a maximal admissible cover iff each coordinate is a MUA set and
their union has full measure. -/
theorem isMaximalCover_iff {C : Fin k → Set ℂ} (hC : ∀ j, MeasurableSet (C j)) :
    IsMaximalCover C ↔ (∀ j, IsMUA (C j)) ∧ ∀ᵐ x ∂volume, ∃ j, x ∈ C j := by
  classical
  -- measurability is part of `IsMUA`; the hypothesis is the row's "k-tuple of measurable sets"
  have _ := hC
  constructor
  · rintro ⟨⟨hadm, hcov⟩, hmax⟩
    refine ⟨fun j => ⟨(hadm j).1, (hadm j).2, fun B hBm hBn hCB => ?_⟩, hcov⟩
    -- enlarge the `j`th class to `B`
    let D : Fin k → Set ℂ := Function.update C j B
    have hD : ∀ i, D i = if i = j then B else C i := fun i => by
      by_cases h : i = j <;> simp [D, h]
    have hDadm : IsAdmissible D := by
      intro i
      rw [hD]
      split_ifs
      · exact ⟨hBm, hBn⟩
      · exact hadm i
    have hDcov : ∀ᵐ x ∂volume, ∃ i, x ∈ D i := by
      filter_upwards [hcov, hCB] with x hx hxB
      obtain ⟨i, hi⟩ := hx
      by_cases hij : i = j
      · subst hij; exact ⟨i, by rw [hD]; simp; exact hxB hi⟩
      · exact ⟨i, by rw [hD]; simp [hij, hi]⟩
    have hle : AeLE C D := by
      intro i
      rw [hD]
      split_ifs with h
      · subst h; exact hCB
      · exact EventuallyLE.rfl
    have := hmax D ⟨hDadm, hDcov⟩ hle j
    rwa [hD, if_pos rfl] at this
  · rintro ⟨hM, hcov⟩
    refine ⟨⟨fun j => ⟨(hM j).1, (hM j).2.1⟩, hcov⟩, fun D hD hle j => ?_⟩
    exact (hM j).2.2 (D j) (hD.1 j).1 (hD.1 j).2 (hle j)

/-- **FS111-M-SATC**, first clause: every a.e.-proper `k`-colouring lies below a maximal admissible cover. -/
theorem AeColouring.exists_isMaximalCover (c : AeColouring k) : ∃ C, IsMaximalCover C ∧ AeLE c.cls C := by
  choose A hAM hle using fun j => exists_isMUA_ae_le (c.measurableSet_cls j) (c.unitPairsNull j)
  have hcov : ∀ᵐ x ∂volume, ∃ j, x ∈ A j := by
    have : ∀ᵐ x ∂volume, ∀ j, x ∈ c.cls j → x ∈ A j := ae_all_iff.2 hle
    filter_upwards [this] with x hx
    exact ⟨c.col x, hx _ rfl⟩
  exact ⟨A, (isMaximalCover_iff fun j => (hAM j).1).2 ⟨hAM, hcov⟩, hle⟩

/-- **FS111-M-SATC**, second clause: every maximal cover's supports satisfy `ℝ² = int F_j ∪ (F_j + S¹)`. -/
theorem IsMaximalCover.interior_union_unitShadow {C : Fin k → Set ℂ} (hC : IsMaximalCover C) (j : Fin k) :
    interior (essSupport (C j)) ∪ unitShadow (essSupport (C j)) = univ := by
  rcases (isMaximalCover_iff (fun j => (hC.1.1 j).1)).1 hC with ⟨hM, -⟩
  exact (hM j).interior_union_unitShadow

/-- **FS111-M-SATC**, third clause: a selection is an a.e.-proper `k`-colouring — from any admissible family (the row
says "from a maximal cover"; the argument reads only that each class has null unit pairs: a generalization). -/
theorem IsAdmissible.exists_aeColouring {C : Fin k → Set ℂ} (hC : IsAdmissible C) {f : ℂ → Fin k}
    (hf : IsSelection C f) : ∃ c : AeColouring k, c.col = f := by
  refine ⟨⟨f, hf.1, fun j => ?_⟩, rfl⟩
  have hB : MeasurableSet (f ⁻¹' {j}) := hf.1 (measurableSet_singleton j)
  have h1 : UnitPairsNull (f ⁻¹' {j} ∩ C j) := (hC j).2.mono inter_subset_right
  refine h1.congr_ae ?_
  rw [Filter.eventuallyEq_set]
  filter_upwards [hf.2] with x hx
  exact ⟨fun h => h.1, fun h => ⟨h, by rw [mem_preimage, mem_singleton_iff] at h; rw [← h]; exact hx⟩⟩

/-- **FS111-M2-FIX**, the shadow identity: a regular MUA set `A` has `int F = ℝ² ∖ (F + S¹)`, `F = supp A`. -/
theorem IsRegularMUA.interior_eq_compl_unitShadow {A : Set ℂ} (hA : IsRegularMUA A) :
    interior (essSupport A) = (unitShadow (essSupport A))ᶜ := by
  have hM := hA.1
  have hFA := hA.2.1
  refine subset_antisymm (fun z hz hzs => ?_) (fun z hz => ?_)
  · obtain ⟨y, hy, hd⟩ := hzs
    have hU : interior (essSupport A) ⊆ densitySet A := by
      refine subset_densitySet_of_isOpen_ae_subset isOpen_interior ?_
      filter_upwards [measure_eq_zero_iff_ae_notMem.1 hFA] with w hw hwi
      by_contra hwA
      exact hw ⟨interior_subset hwi, hwA⟩
    rw [essSupport_eq_closure_densitySet] at hy
    exact dist_ne_one_of_mem_interior_densitySet hM.1 hM.2.1 (interior_maximal hU isOpen_interior hz) hy hd
  · have h2 : z ∈ interior (essSupport A) ∪ unitShadow (essSupport A) := by
      rw [IsMUA.interior_union_unitShadow hM]; trivial
    exact h2.resolve_right hz

/-- **FS111-M2-FIX**, its readings: every unit circle centred in `F` misses `int F`, and every component of `int F` lies
inside or outside each such circle. -/
theorem IsRegularMUA.component_side {A : Set ℂ} (hA : IsRegularMUA A) {y : ℂ} (hy : y ∈ essSupport A) :
    (∀ z ∈ interior (essSupport A), dist z y ≠ 1) ∧
      ∀ z ∈ interior (essSupport A), ∀ z' ∈ connectedComponentIn (interior (essSupport A)) z,
        (dist z y < 1 ↔ dist z' y < 1) := by
  have hid := hA.interior_eq_compl_unitShadow
  have h1 : ∀ z ∈ interior (essSupport A), dist z y ≠ 1 := fun z hz hd => by
    have : z ∈ (unitShadow (essSupport A))ᶜ := hid ▸ hz
    exact this ⟨y, hy, hd⟩
  refine ⟨h1, fun z hz z' hz' => ?_⟩
  have hsub : connectedComponentIn (interior (essSupport A)) z ⊆ interior (essSupport A) :=
    connectedComponentIn_subset _ _
  have hpre : IsPreconnected (connectedComponentIn (interior (essSupport A)) z) :=
    isPreconnected_connectedComponentIn
  have hz0 : z ∈ connectedComponentIn (interior (essSupport A)) z :=
    mem_connectedComponentIn hz
  rcases preconnected_dist_lt_or_gt hpre (x := y) (fun s hs => by
      rw [dist_comm]; exact h1 s (hsub hs)) with h | h
  · exact ⟨fun _ => by rw [dist_comm]; exact h z' hz', fun _ => by rw [dist_comm]; exact h z hz0⟩
  · constructor <;> intro hlt
    · have := h z hz0; rw [dist_comm] at hlt; linarith
    · have := h z' hz'; rw [dist_comm] at hlt; linarith

/-- **FS111-M-COVER-SC**, first clause, with the contact point in the support (the stronger child; the statement below reads
it with `y` unconstrained, `x ∈ closure P` idle). -/
theorem IsMaximalCover.enclosing_or_exterior_contact {C : Fin k → Set ℂ} (hC : IsMaximalCover C) (a : Fin k) {x : ℂ}
    (hx : x ∈ frontier (essSupport (C a))) {P : Set ℂ} (hP : IsPreconnected P) (hPa : P ⊆ densitySet (C a)) :
    ∃ y ∈ essSupport (C a), dist x y = 1 ∧ ((∀ p ∈ P, dist p y ≤ 1) ∨ (∀ p ∈ P, 1 ≤ dist p y)) := by
  have hmeas := (hC.1.1 a).1
  have hnull := (hC.1.1 a).2
  have hxF : x ∉ interior (essSupport (C a)) := fun h => hx.2 h
  obtain ⟨y, hyF, hxy⟩ : x ∈ unitShadow (essSupport (C a)) :=
    (hC.interior_union_unitShadow a ▸ mem_univ x : x ∈ interior (essSupport (C a)) ∪ unitShadow (essSupport (C a))).resolve_left hxF
  refine ⟨y, hyF, hxy, ?_⟩
  by_contra hcon
  push Not at hcon
  obtain ⟨⟨p₁, hp₁, h₁⟩, ⟨p₂, hp₂, h₂⟩⟩ := hcon
  have hopen : IsOpen {y' : ℂ | 1 < dist p₁ y' ∧ dist p₂ y' < 1} :=
    (isOpen_lt continuous_const (continuous_const.dist continuous_id)).inter
      (isOpen_lt (continuous_const.dist continuous_id) continuous_const)
  have hy : y ∈ {y' : ℂ | 1 < dist p₁ y' ∧ dist p₂ y' < 1} :=
    ⟨h₁, h₂⟩
  rw [essSupport_eq_closure_densitySet] at hyF
  obtain ⟨y', hy'o, hy'D⟩ := mem_closure_iff.1 hyF _ hopen hy
  rcases hullset hmeas hnull hP hPa (upperDensityAt_pos_of_mem_densitySet hy'D) with h | h
  · have := h p₁ hp₁; rw [dist_comm] at this; linarith [hy'o.1]
  · have := h p₂ hp₂; rw [dist_comm] at this; linarith [hy'o.2]

/-- **FS111-M-COVER-SC**, first clause: in a maximal cover, at every boundary point `x` of `F_a`, each adjacent
preconnected piece `P` of `F̃_a` lies in an enclosing unit disc or outside an exterior one, the disc's circle through
`x`. (The row says path-connected; preconnected is wider.) -/
theorem IsMaximalCover.enclosing_or_exterior {C : Fin k → Set ℂ} (hC : IsMaximalCover C) (a : Fin k) {x : ℂ}
    (hx : x ∈ frontier (essSupport (C a))) {P : Set ℂ} (hP : IsPreconnected P) (hPa : P ⊆ densitySet (C a))
    (hxP : x ∈ closure P) :
    ∃ y, dist x y = 1 ∧ ((∀ p ∈ P, dist p y ≤ 1) ∨ (∀ p ∈ P, 1 ≤ dist p y)) := by
  obtain ⟨y, -, h1, h2⟩ := hC.enclosing_or_exterior_contact a hx hP hPa
  have _ := hxP
  exact ⟨y, h1, h2⟩

/-- The class lies below the graph of `u` over `J` in the frame `(z₀, θ)`, locally: the points
`z₀ + e θ · (s + t i)` with `s ∈ J` and `u s − δ < t < u s` are in the density set `Ã`, and those with `u s < t < u s + δ`
are not in `supp A`. (Ruling, `plans/FS131-close-inventory.md` item 56: the region below the graph is read in `Ã`, as the
derivation's pieces `P ⊆ F̃_a` are; it was `supp A`. Item 72: the region is the open one, `t < u s` — a point on a smooth
arc has density `1/2`.) -/
def IsLowerGraphOf (A : Set ℂ) (z₀ : ℂ) (θ : ℝ) (J : Set ℝ) (u : ℝ → ℝ) (δ : ℝ) : Prop :=
  0 < δ ∧ ∀ s ∈ J, ∀ t : ℝ, (u s - δ < t → t < u s → z₀ + e θ * (s + t * I) ∈ densitySet A) ∧
    (u s < t → t < u s + δ → z₀ + e θ * (s + t * I) ∉ essSupport A)

/-- Curvature at most `1`, in the viscosity sense for a semiconcave bound: at every `s₀ ∈ J`, every `C²` function `φ` touching
`u` from below at `s₀` has `φ''(s₀) ≤ (1 + φ'(s₀)²)^{3/2}`. (Ruling, `plans/FS131-close-inventory.md` item 57: the test
functions touch from below; from above, `φ = u + N (s − s₀)²` defeats every bound.) -/
def CurvatureLeOne (u : ℝ → ℝ) (J : Set ℝ) : Prop :=
  ∀ s₀ ∈ J, ∀ φ : ℝ → ℝ, ContDiff ℝ 2 φ → φ s₀ = u s₀ → (∀ᶠ s in 𝓝 s₀, φ s ≤ u s) →
    deriv (deriv φ) s₀ ≤ (1 + deriv φ s₀ ^ 2) ^ ((3 : ℝ) / 2)

/-- A `C²` function that is `≤ 0` near `s₀` and `0` at `s₀` has zero derivative and nonpositive second derivative there. -/
theorem second_order_of_local_max {g : ℝ → ℝ} (hg : ContDiff ℝ 2 g) {s₀ : ℝ} (h0 : g s₀ = 0)
    (hle : ∀ᶠ s in 𝓝 s₀, g s ≤ 0) : deriv g s₀ = 0 ∧ deriv (deriv g) s₀ ≤ 0 := by
  have hmax : IsLocalMax g s₀ := by
    filter_upwards [hle] with s hs; rw [h0]; exact hs
  refine ⟨hmax.deriv_eq_zero, ?_⟩
  by_contra hpos
  push Not at hpos
  set c := deriv (deriv g) s₀ with hc
  set h : ℝ → ℝ := fun s => g s - (c / 4) * (s - s₀) ^ 2 with hh
  have hd1 : ∀ s, HasDerivAt h (deriv g s - (c / 2) * (s - s₀)) s := by
    intro s
    have h1 : HasDerivAt g (deriv g s) s := (hg.differentiable (by norm_num) s).hasDerivAt
    have h2 := (((hasDerivAt_id s).sub_const s₀).pow 2).const_mul (c / 4)
    have h3 := h1.sub h2
    refine h3.congr_deriv ?_
    simp only [id]; push_cast; ring
  have hderiv : deriv h = fun s => deriv g s - (c / 2) * (s - s₀) := funext fun s => (hd1 s).deriv
  have hdg : ContDiff ℝ 1 (deriv g) := (contDiff_succ_iff_deriv.1 (by rw [show ((1:WithTop ℕ∞) + 1) = 2 by norm_num]; exact hg)).2.2
  have hg2 : DifferentiableAt ℝ (deriv g) s₀ := hdg.differentiable (by norm_num) s₀
  have hdd : deriv (deriv h) s₀ = c / 2 := by
    rw [hderiv]
    have := (hg2.hasDerivAt).sub (((hasDerivAt_id s₀).sub_const s₀).const_mul (c / 2))
    have h' := this.deriv
    simp only [id] at h'
    simp only [hc] at h' ⊢
    rw [show (fun s => deriv g s - c / 2 * (s - s₀)) = (deriv g - fun y => c / 2 * (y - s₀)) from rfl, h']; ring
  have hd0 : deriv h s₀ = 0 := by rw [hderiv]; simp [hmax.deriv_eq_zero]
  have hch : ContDiff ℝ 2 h := by
    refine hg.sub ?_
    fun_prop
  have hmin : IsLocalMin h s₀ := isLocalMin_of_deriv_deriv_pos (by rw [hdd]; linarith) hd0 hch.continuous.continuousAt
  obtain ⟨ε, hε, hball⟩ := Metric.eventually_nhds_iff.1 (hmin.and hle)
  have hs1 : s₀ + ε / 2 ∈ ball s₀ ε := by simp [abs_of_pos hε]; linarith
  obtain ⟨hm, hl⟩ := hball hs1
  have : h s₀ = 0 := by simp [hh, h0]
  have h2 : h (s₀ + ε / 2) < 0 := by
    simp only [hh]
    have : 0 < (c / 4) * (s₀ + ε / 2 - s₀) ^ 2 := by
      have : s₀ + ε / 2 - s₀ = ε / 2 := by ring
      rw [this]; positivity
    linarith
  linarith

/-- The first- and second-order conditions of a graph touching a unit circle centred `(σ, τ)` — from inside (`c = 1`) or
from outside (`c = -1`). -/
theorem touch_conditions {φ : ℝ → ℝ} (hφ : ContDiff ℝ 2 φ) {σ τ s₀ c : ℝ}
    (h0 : (s₀ - σ) ^ 2 + (φ s₀ - τ) ^ 2 - 1 = 0)
    (hle : ∀ᶠ s in 𝓝 s₀, c * ((s - σ) ^ 2 + (φ s - τ) ^ 2 - 1) ≤ 0) :
    c * ((s₀ - σ) + (φ s₀ - τ) * deriv φ s₀) = 0 ∧
      c * (1 + deriv φ s₀ ^ 2 + (φ s₀ - τ) * deriv (deriv φ) s₀) ≤ 0 := by
  have hdφ : ContDiff ℝ 1 (deriv φ) := (contDiff_succ_iff_deriv.1 (by rw [show ((1:WithTop ℕ∞) + 1) = 2 by norm_num]; exact hφ)).2.2
  have hφd : ∀ s, HasDerivAt φ (deriv φ s) s := fun s => (hφ.differentiable (by norm_num) s).hasDerivAt
  have hφdd : ∀ s, HasDerivAt (deriv φ) (deriv (deriv φ) s) s := fun s => (hdφ.differentiable (by norm_num) s).hasDerivAt
  set G : ℝ → ℝ := fun s => c * ((s - σ) ^ 2 + (φ s - τ) ^ 2 - 1) with hG
  have hG1 : ∀ s, HasDerivAt G (c * (2 * (s - σ) + 2 * (φ s - τ) * deriv φ s)) s := by
    intro s
    have a := (((hasDerivAt_id s).sub_const σ).pow 2)
    have b := (((hφd s).sub_const τ).pow 2)
    have c' := ((a.add b).sub_const 1).const_mul c
    refine c'.congr_deriv ?_
    simp only [id]; push_cast; ring
  have hGd : deriv G = fun s => c * (2 * (s - σ) + 2 * (φ s - τ) * deriv φ s) := funext fun s => (hG1 s).deriv
  have hG2 : ∀ s, HasDerivAt (deriv G) (c * (2 + 2 * deriv φ s ^ 2 + 2 * (φ s - τ) * deriv (deriv φ) s)) s := by
    intro s
    rw [hGd]
    have a := ((hasDerivAt_id s).sub_const σ).const_mul 2
    have b := (((hφd s).sub_const τ).const_mul 2).mul (hφdd s)
    have c' := (a.add b).const_mul c
    refine c'.congr_deriv ?_
    ring
  have hGc : ContDiff ℝ 2 G := by
    rw [hG]
    exact contDiff_const.mul (((contDiff_id.sub contDiff_const).pow 2).add ((hφ.sub contDiff_const).pow 2) |>.sub contDiff_const)
  have hG0 : G s₀ = 0 := by simp only [hG]; rw [h0]; ring
  obtain ⟨d1, d2⟩ := second_order_of_local_max hGc hG0 hle
  rw [hGd] at d1
  have d1' : c * (2 * (s₀ - σ) + 2 * (φ s₀ - τ) * deriv φ s₀) = 0 := d1
  rw [(hG2 s₀).deriv] at d2
  constructor <;> nlinarith [d1', d2]

theorem dist_frame (θ : ℝ) (s t σ τ : ℝ) (z₀ : ℂ) :
    dist (z₀ + e θ * ((s : ℂ) + t * I)) (z₀ + e θ * ((σ : ℂ) + τ * I)) = √((s - σ) ^ 2 + (t - τ) ^ 2) := by
  have : z₀ + e θ * ((s : ℂ) + t * I) - (z₀ + e θ * ((σ : ℂ) + τ * I)) =
      e θ * (((s - σ : ℝ) : ℂ) + ((t - τ : ℝ) : ℂ) * I) := by push_cast; ring
  rw [dist_eq_norm, this, norm_mul, norm_e, one_mul, Complex.norm_add_mul_I]

theorem exists_frame_coords (θ : ℝ) (z₀ y : ℂ) : ∃ σ τ : ℝ, y = z₀ + e θ * ((σ : ℂ) + τ * I) := by
  have hne : e θ ≠ 0 := by
    intro h; have := norm_e θ; rw [h, norm_zero] at this; exact zero_ne_one this
  refine ⟨((y - z₀) / e θ).re, ((y - z₀) / e θ).im, ?_⟩
  rw [Complex.re_add_im, mul_div_cancel₀ _ hne]; ring

theorem le_zero_of_forall_small {f : ℝ → ℝ} (hf : Continuous f) {η₀ : ℝ} (hη : 0 < η₀)
    (h : ∀ η ∈ Ioo 0 η₀, f η ≤ 0) : f 0 ≤ 0 :=
  le_of_tendsto (hf.tendsto 0 |>.mono_left nhdsWithin_le_nhds) (eventually_of_mem (Ioo_mem_nhdsGT hη) h)

theorem ge_zero_of_forall_small {f : ℝ → ℝ} (hf : Continuous f) {η₀ : ℝ} (hη : 0 < η₀)
    (h : ∀ η ∈ Ioo 0 η₀, 0 ≤ f η) : 0 ≤ f 0 :=
  ge_of_tendsto (hf.tendsto 0 |>.mono_left nhdsWithin_le_nhds) (eventually_of_mem (Ioo_mem_nhdsGT hη) h)

/-- The frame map `(s, t) ↦ z₀ + e θ · (s + t i)`. -/
noncomputable def frameMap (z₀ : ℂ) (θ : ℝ) (s t : ℝ) : ℂ := z₀ + e θ * ((s : ℂ) + t * I)

theorem continuous_frameMap (z₀ : ℂ) (θ : ℝ) : Continuous (fun q : ℝ × ℝ => frameMap z₀ θ q.1 q.2) :=
  continuous_const.add (continuous_const.mul ((Complex.continuous_ofReal.comp continuous_fst).add
    ((Complex.continuous_ofReal.comp continuous_snd).mul continuous_const)))

/-- **FS111-M-COVER-SC**, second clause, **corrected** (the row's "semiconcave with constant 1" is false at R7's cusped
down triangles; ruling `plans/FS131-close-inventory.md` items 18–19): where `∂F_a` is locally the graph of a continuous
`u` with `F_a` below it, `u` has curvature at most `1` in the viscosity sense. -/
theorem IsMaximalCover.curvatureLeOne {C : Fin k → Set ℂ} (hC : IsMaximalCover C) (a : Fin k) {z₀ : ℂ} {θ δ : ℝ}
    {J : Set ℝ} (hJ : IsOpen J) {u : ℝ → ℝ} (hu : ContinuousOn u J) (hgraph : IsLowerGraphOf (C a) z₀ θ J u δ) :
    CurvatureLeOne u J := by
  obtain ⟨hδ, hg⟩ := hgraph
  intro s₀ hs₀ φ hφ hφ0 hφle
  have huc : ContinuousAt u s₀ := hu.continuousAt (hJ.mem_nhds hs₀)
  have hφc : Continuous φ := hφ.continuous
  -- a window `I` around `s₀` on which `u − δ < φ ≤ u` and `I ⊆ J`
  have hev : ∀ᶠ s in 𝓝 s₀, s ∈ J ∧ φ s ≤ u s ∧ u s - δ < φ s := by
    refine (hJ.eventually_mem hs₀).and (hφle.and ?_)
    have : ContinuousAt (fun s => φ s - u s + δ) s₀ := (hφc.continuousAt).sub huc |>.add continuousAt_const
    have h0 : 0 < φ s₀ - u s₀ + δ := by rw [hφ0]; linarith
    filter_upwards [this.eventually (lt_mem_nhds h0)] with s hs
    linarith
  obtain ⟨r, hr, hball⟩ := Metric.eventually_nhds_iff.1 hev
  set Iw : Set ℝ := Ioo (s₀ - r) (s₀ + r) with hI
  have hIb : ∀ s ∈ Iw, s ∈ J ∧ φ s ≤ u s ∧ u s - δ < φ s := fun s hs =>
    hball (by rw [Real.dist_eq]; exact abs_lt.2 ⟨by linarith [hs.1], by linarith [hs.2]⟩)
  have hs0I : s₀ ∈ Iw := ⟨by linarith, by linarith⟩
  set P : Set ℂ := (fun q : ℝ × ℝ => frameMap z₀ θ q.1 (u q.1 - δ * q.2)) '' (Iw ×ˢ Ioo (0 : ℝ) 1) with hP
  have hPc : IsPreconnected P := by
    have hIc : IsPreconnected Iw := isPreconnected_Ioo
    refine (hIc.prod (isPreconnected_Ioo (a := (0 : ℝ)) (b := 1))).image (fun q : ℝ × ℝ => frameMap z₀ θ q.1 (u q.1 - δ * q.2)) ?_
    have h1 : ContinuousOn (fun q : ℝ × ℝ => u q.1) (Iw ×ˢ Ioo (0 : ℝ) 1) :=
      hu.comp continuousOn_fst (fun q hq => (hIb q.1 hq.1).1)
    have h2 : ContinuousOn (fun q : ℝ × ℝ => (q.1, u q.1 - δ * q.2)) (Iw ×ˢ Ioo (0 : ℝ) 1) :=
      continuousOn_fst.prodMk (h1.sub (continuousOn_const.mul continuousOn_snd))
    have h3 := ((continuous_frameMap z₀ θ).comp_continuousOn h2)
    exact h3
  have hPmem : ∀ s ∈ Iw, ∀ t, u s - δ < t → t < u s → frameMap z₀ θ s t ∈ P := by
    intro s hs t ht1 ht2
    refine ⟨(s, (u s - t) / δ), ⟨hs, ?_, ?_⟩, ?_⟩
    · exact div_pos (by linarith) hδ
    · rw [div_lt_one hδ]; linarith
    · simp only; congr 2; field_simp; ring
  have hPa : P ⊆ densitySet (C a) := by
    rintro _ ⟨⟨s, l⟩, ⟨hs, hl0, hl1⟩, rfl⟩
    exact (hg s (hIb s hs).1 (u s - δ * l)).1 (by nlinarith) (by nlinarith)
  have hdist : ∀ s t : ℝ, ∀ σ τ : ℝ, dist (frameMap z₀ θ s t) (frameMap z₀ θ σ τ) = √((s - σ) ^ 2 + (t - τ) ^ 2) :=
    fun s t σ τ => dist_frame θ s t σ τ z₀
  -- the graph point `x` is a frontier point of the support
  have hxsupp : frameMap z₀ θ s₀ (u s₀) ∈ essSupport (C a) := by
    rw [essSupport_eq_closure_densitySet]
    have hcl : u s₀ ∈ closure (Ioo (u s₀ - δ) (u s₀)) := by
      rw [closure_Ioo (by linarith)]; exact ⟨by linarith, le_rfl⟩
    have hcont : Continuous (fun t : ℝ => frameMap z₀ θ s₀ t) :=
      (continuous_frameMap z₀ θ).comp (continuous_const.prodMk continuous_id)
    have h1 := image_closure_subset_closure_image hcont ⟨u s₀, hcl, rfl⟩
    refine closure_mono ?_ h1
    rintro _ ⟨t, ht, rfl⟩
    exact (hg s₀ hs₀ t).1 ht.1 ht.2
  have hxfr : frameMap z₀ θ s₀ (u s₀) ∈ frontier (essSupport (C a)) := by
    refine ⟨by rw [(isClosed_essSupport _).closure_eq]; exact hxsupp, fun hint => ?_⟩
    obtain ⟨ε, hε, hb⟩ := Metric.isOpen_iff.1 isOpen_interior _ hint
    set η := min (ε / 2) (δ / 2) with hη
    have hη0 : 0 < η := lt_min (by linarith) (by linarith)
    have hηε : η ≤ ε / 2 := min_le_left _ _
    have hηδ : η ≤ δ / 2 := min_le_right _ _
    have hq : frameMap z₀ θ s₀ (u s₀ + η) ∈ ball (frameMap z₀ θ s₀ (u s₀)) ε := by
      rw [mem_ball, hdist]
      rw [show (s₀ - s₀) ^ 2 + (u s₀ + η - u s₀) ^ 2 = η ^ 2 by ring, Real.sqrt_sq hη0.le]; linarith
    exact (hg s₀ hs₀ (u s₀ + η)).2 (by linarith) (by linarith) (interior_subset (hb hq))
  obtain ⟨y, hy, hxy, hside⟩ := hC.enclosing_or_exterior_contact a hxfr hPc hPa
  obtain ⟨σ, τ, hy'⟩ := exists_frame_coords θ z₀ y
  have hdy : ∀ s t : ℝ, dist (frameMap z₀ θ s t) y = √((s - σ) ^ 2 + (t - τ) ^ 2) := by
    intro s t; rw [hy']; exact hdist s t σ τ
  have h0 : (s₀ - σ) ^ 2 + (φ s₀ - τ) ^ 2 - 1 = 0 := by
    have := hdy s₀ (u s₀); rw [hxy] at this
    have h1 := (Real.sqrt_eq_one).1 this.symm
    rw [hφ0]; linarith
  have hIn : Iw ∈ 𝓝 s₀ := Ioo_mem_nhds (by linarith) (by linarith)
  have hφ2 : ContDiff ℝ 2 φ := hφ
  -- the vertical segment below the graph point
  have hvert : ∀ η ∈ Ioo 0 δ, frameMap z₀ θ s₀ (u s₀ - η) ∈ P := fun η hη =>
    hPmem s₀ hs0I _ (by linarith [hη.2]) (by linarith [hη.1])
  have hφ0' : φ s₀ - τ = u s₀ - τ := by rw [hφ0]
  rcases hside with hin | hout
  · -- enclosing: the class lies in the unit disc about `y`
    have hle : ∀ᶠ s in 𝓝 s₀, 1 * ((s - σ) ^ 2 + (φ s - τ) ^ 2 - 1) ≤ 0 := by
      filter_upwards [hIn] with s hs
      obtain ⟨-, hs1, hs2⟩ := hIb s hs
      have := le_zero_of_forall_small (f := fun η => (s - σ) ^ 2 + (φ s - η - τ) ^ 2 - 1)
        (by fun_prop) (η₀ := φ s - (u s - δ)) (by linarith) (fun η hη => by
          have hmem := hin _ (hPmem s hs (φ s - η) (by linarith [hη.2]) (by linarith [hη.1]))
          rw [hdy] at hmem
          have := (Real.sqrt_le_iff.1 hmem).2
          nlinarith)
      simp only [sub_zero] at this; linarith
    obtain ⟨d1, d2⟩ := touch_conditions hφ2 h0 hle
    have hw : 0 < u s₀ - τ := by
      by_contra hneg
      push Not at hneg
      have hmem := hin _ (hvert (δ / 2) ⟨by linarith, by linarith⟩)
      rw [hdy] at hmem
      have := (Real.sqrt_le_iff.1 hmem).2
      rw [hφ0] at h0
      nlinarith
    rw [hφ0'] at d2
    have hneg : deriv (deriv φ) s₀ < 0 := by
      by_contra hnn; push Not at hnn
      nlinarith [mul_nonneg hw.le hnn, sq_nonneg (deriv φ s₀)]
    exact hneg.le.trans (Real.rpow_pos_of_pos (by positivity) _).le
  · -- exterior: the class lies outside the open unit disc about `y`
    have hge : ∀ᶠ s in 𝓝 s₀, (-1 : ℝ) * ((s - σ) ^ 2 + (φ s - τ) ^ 2 - 1) ≤ 0 := by
      filter_upwards [hIn] with s hs
      obtain ⟨-, hs1, hs2⟩ := hIb s hs
      have := ge_zero_of_forall_small (f := fun η => (s - σ) ^ 2 + (φ s - η - τ) ^ 2 - 1)
        (by fun_prop) (η₀ := φ s - (u s - δ)) (by linarith) (fun η hη => by
          have hmem := hout _ (hPmem s hs (φ s - η) (by linarith [hη.2]) (by linarith [hη.1]))
          rw [hdy] at hmem
          have := (Real.le_sqrt' one_pos).1 hmem
          nlinarith)
      simp only [sub_zero] at this; linarith
    obtain ⟨d1, d2⟩ := touch_conditions hφ2 h0 hge
    rw [hφ0'] at d1 d2
    have hw : u s₀ - τ < 0 := by
      by_contra hnn; push Not at hnn
      rcases hnn.eq_or_lt with hz | hpos
      · rw [← hz] at d1; rw [hφ0, ← hz] at h0
        have : s₀ - σ = 0 := by linarith
        rw [this] at h0; norm_num at h0
      · set η := min (δ / 2) (u s₀ - τ) with hη
        have hη0 : 0 < η := lt_min (by linarith) hpos
        have hηδ : η ≤ δ / 2 := min_le_left _ _
        have hηw : η ≤ u s₀ - τ := min_le_right _ _
        have hmem := hout _ (hvert η ⟨hη0, by linarith⟩)
        rw [hdy] at hmem
        have := (Real.le_sqrt' one_pos).1 hmem
        rw [hφ0] at h0
        nlinarith
    set w := u s₀ - τ with hwdef
    set X := 1 + deriv φ s₀ ^ 2 with hX
    have hXpos : 0 < X := by positivity
    have hs0 : s₀ - σ = -(w * deriv φ s₀) := by linarith
    rw [hφ0] at h0
    have hw2 : w ^ 2 * X = 1 := by rw [hs0] at h0; rw [hX]; nlinarith [h0]
    have hsqrt : √X * (-w) = 1 := by
      have hpos : 0 < √X * (-w) := mul_pos (Real.sqrt_pos.2 hXpos) (by linarith)
      have hsq : (√X * (-w)) ^ 2 = 1 := by
        rw [mul_pow, Real.sq_sqrt hXpos.le]; nlinarith [hw2]
      nlinarith [hsq, hpos]
    have hrp : X ^ ((3 : ℝ) / 2) = X * √X := by
      rw [show (3 : ℝ) / 2 = 1 + 1 / 2 by norm_num, Real.rpow_add hXpos, Real.rpow_one, ← Real.sqrt_eq_rpow]
    rw [hrp]
    have h1 : deriv (deriv φ) s₀ * (-w) ≤ X := by nlinarith [d2]
    calc deriv (deriv φ) s₀ = (deriv (deriv φ) s₀ * (-w)) * √X := by
          rw [mul_assoc, mul_comm (-w), hsqrt, mul_one]
      _ ≤ X * √X := mul_le_mul_of_nonneg_right h1 (Real.sqrt_nonneg _)

/-- Semiconcavity with constant `K` on `J`: `u(s + h) + u(s − h) − 2u(s) ≤ K h²` whenever `s ± h ∈ J`. -/
def SemiconcaveWith (K : ℝ) (u : ℝ → ℝ) (J : Set ℝ) : Prop :=
  ∀ s h, s ∈ J → s + h ∈ J → s - h ∈ J → u (s + h) + u (s - h) - 2 * u s ≤ K * h ^ 2

/-- A `C¹` function touching an `L`-Lipschitz function from below at `x₀` has slope at most `L` in absolute value. -/
theorem abs_deriv_le_of_touch_below {u φ : ℝ → ℝ} {L : ℝ} {x₀ : ℝ} (hφ : DifferentiableAt ℝ φ x₀)
    (h0 : φ x₀ = u x₀) (hle : ∀ᶠ x in 𝓝 x₀, φ x ≤ u x) (hL : ∀ᶠ x in 𝓝 x₀, |u x - u x₀| ≤ L * |x - x₀|) :
    |deriv φ x₀| ≤ L := by
  have hd := hφ.hasDerivAt
  have hr := hd.tendsto_slope_zero_right
  have hl := hd.tendsto_slope_zero_left
  have hev : ∀ᶠ t in 𝓝 (0 : ℝ), φ (x₀ + t) ≤ u (x₀ + t) ∧ |u (x₀ + t) - u x₀| ≤ L * |t| := by
    have h1 : Tendsto (fun t : ℝ => x₀ + t) (𝓝 0) (𝓝 x₀) := by
      simpa using (tendsto_id (x := 𝓝 (0:ℝ))).const_add x₀
    filter_upwards [h1.eventually (hle.and hL)] with t ht
    exact ⟨ht.1, by simpa using ht.2⟩
  have up : deriv φ x₀ ≤ L := by
    refine le_of_tendsto hr ?_
    filter_upwards [eventually_nhdsWithin_of_eventually_nhds hev, self_mem_nhdsWithin] with t ht (ht0 : 0 < t)
    simp only [smul_eq_mul]
    rw [inv_mul_eq_div, div_le_iff₀ ht0]
    have := ht.2; rw [abs_of_pos ht0] at this
    have h3 := ht.1
    have := (abs_le.1 ht.2).2
    linarith [(le_abs_self _ : u (x₀ + t) - u x₀ ≤ |u (x₀ + t) - u x₀|), h0]
  have down : -L ≤ deriv φ x₀ := by
    refine ge_of_tendsto hl ?_
    filter_upwards [eventually_nhdsWithin_of_eventually_nhds hev, self_mem_nhdsWithin] with t ht (ht0 : t < 0)
    simp only [smul_eq_mul]
    rw [inv_mul_eq_div, le_div_iff_of_neg ht0]
    have := ht.2; rw [abs_of_neg ht0] at this
    have h3 := ht.1
    linarith [(le_abs_self _ : u (x₀ + t) - u x₀ ≤ |u (x₀ + t) - u x₀|), h0]
  exact abs_le.2 ⟨down, up⟩

/-- The curvature bound and the Lipschitz bound give semiconcavity, for `h > 0` (the viscosity-to-chord argument: a chord
violation is touched from below by a convex parabola). -/
theorem semiconcave_pos {α β : ℝ} {u : ℝ → ℝ} (hu : ContinuousOn u (Ioo α β))
    (hcur : CurvatureLeOne u (Ioo α β)) {L : NNReal} (hL : LipschitzOnWith L u (Ioo α β)) {s h : ℝ} (hh : 0 < h)
    (hsh : s + h ∈ Ioo α β) (hsmh : s - h ∈ Ioo α β) :
    u (s + h) + u (s - h) - 2 * u s ≤ (1 + (L : ℝ) ^ 2) ^ ((3 : ℝ) / 2) * h ^ 2 := by
  set K : ℝ := (1 + (L : ℝ) ^ 2) ^ ((3 : ℝ) / 2) with hK
  by_contra hviol
  push Not at hviol
  set a := s - h with ha
  set b := s + h with hb
  have hab : a < b := by linarith
  have hsub : Icc a b ⊆ Ioo α β := fun x hx => ⟨by linarith [hsmh.1, hx.1], by linarith [hsh.2, hx.2]⟩
  set v : ℝ → ℝ := fun x => u x - K * x ^ 2 / 2 with hv
  set m : ℝ := (v b - v a) / (b - a) with hm
  set ℓ : ℝ → ℝ := fun x => v a + m * (x - a) with hℓ
  have hba : b - a ≠ 0 := (sub_pos.2 hab).ne'
  have hsa : s - a = (b - a) / 2 := by rw [ha, hb]; ring
  have hℓb : ℓ b = v b := by simp only [hℓ, hm]; field_simp; ring
  have hℓs : ℓ s = (v a + v b) / 2 := by
    simp only [hℓ, hm, hsa]; field_simp; ring
  have hδ0 : 0 < ℓ s - v s := by
    rw [hℓs]; simp only [hv, ha, hb]; nlinarith [hviol]
  set ε : ℝ := (ℓ s - v s) / (4 * h ^ 2) with hε
  have hε0 : 0 < ε := by positivity
  set g : ℝ → ℝ := fun x => v x - ℓ x + ε * ((x - a) * (b - x)) with hg
  have hgc : ContinuousOn g (Icc a b) := by
    have : ContinuousOn v (Icc a b) := by
      simp only [hv]
      exact ((hu.mono hsub).sub (by fun_prop))
    simp only [hg, hℓ]
    exact (this.sub (by fun_prop)).add (by fun_prop)
  obtain ⟨x₁, hx₁, hmin⟩ := isCompact_Icc.exists_isMinOn (nonempty_Icc.2 hab.le) hgc
  have hga : g a = 0 := by simp [hg, hℓ]
  have hgb : g b = 0 := by simp only [hg]; rw [hℓb]; ring
  have hgs : g s < 0 := by
    simp only [hg]
    have : ε * ((s - a) * (b - s)) = (ℓ s - v s) / 4 := by
      simp only [ha, hb, hε]; field_simp; ring
    rw [this]; linarith
  have hgx : g x₁ < 0 := lt_of_le_of_lt (hmin ⟨by linarith, by linarith⟩) hgs
  have hx1a : a < x₁ := lt_of_le_of_ne hx₁.1 (fun h => by rw [← h, hga] at hgx; exact lt_irrefl _ hgx)
  have hx1b : x₁ < b := lt_of_le_of_ne hx₁.2 (fun h => by rw [h, hgb] at hgx; exact lt_irrefl _ hgx)
  -- the touching parabola
  set φ : ℝ → ℝ := fun x => ℓ x - ε * ((x - a) * (b - x)) + g x₁ + K * x ^ 2 / 2 with hφ
  have hφd : ∀ x, HasDerivAt φ (m - ε * ((b - x) - (x - a)) + K * x) x := by
    intro x
    have h1 : HasDerivAt (fun x => v a + m * (x - a)) m x := by
      simpa using ((hasDerivAt_id x).sub_const a).const_mul m |>.const_add (v a)
    have h2 : HasDerivAt (fun x => (x - a) * (b - x)) ((b - x) - (x - a)) x := by
      exact (((hasDerivAt_id x).sub_const a).mul ((hasDerivAt_id x).const_sub b)).congr_deriv (by simp; ring)
    have h3 : HasDerivAt (fun x => K * x ^ 2 / 2) (K * x) x := by
      have := ((hasDerivAt_id x).pow 2).const_mul K |>.div_const 2
      refine this.congr_deriv ?_
      simp; ring
    exact ((h1.sub (h2.const_mul ε)).add_const (g x₁)).add h3
  have hφd' : deriv φ = fun x => m - ε * ((b - x) - (x - a)) + K * x := funext fun x => (hφd x).deriv
  have hφdd : ∀ x, HasDerivAt (deriv φ) (2 * ε + K) x := by
    intro x
    rw [hφd']
    have := (((hasDerivAt_id x).const_sub b).sub ((hasDerivAt_id x).sub_const a)).const_mul ε |> fun h => ((hasDerivAt_const x m).sub h).add ((hasDerivAt_id x).const_mul K)
    refine this.congr_deriv ?_
    simp; ring
  have hφc : ContDiff ℝ 2 φ := by
    simp only [hφ, hℓ]
    fun_prop
  have hφ0 : φ x₁ = u x₁ := by
    have : g x₁ = v x₁ - ℓ x₁ + ε * ((x₁ - a) * (b - x₁)) := rfl
    simp only [hφ, hv] at this ⊢
    nlinarith [this]
  have hφle : ∀ᶠ x in 𝓝 x₁, φ x ≤ u x := by
    filter_upwards [Ioo_mem_nhds hx1a hx1b] with x hx
    have := hmin (a := x) ⟨hx.1.le, hx.2.le⟩
    simp only [Set.mem_setOf_eq] at this
    have hgx' : g x₁ ≤ g x := this
    simp only [hφ, hg, hv] at hgx' ⊢
    nlinarith [hgx']
  have hx1J : x₁ ∈ Ioo α β := hsub ⟨hx1a.le, hx1b.le⟩
  have hLip : ∀ᶠ x in 𝓝 x₁, |u x - u x₁| ≤ L * |x - x₁| := by
    filter_upwards [(isOpen_Ioo (a := α) (b := β)).mem_nhds hx1J] with x hx
    have := hL.dist_le_mul x hx x₁ hx1J
    simpa [Real.dist_eq] using this
  have hder : |deriv φ x₁| ≤ L :=
    abs_deriv_le_of_touch_below (hφd x₁).differentiableAt hφ0 hφle hLip
  have hcurv := hcur x₁ hx1J φ hφc hφ0 hφle
  rw [(hφdd x₁).deriv] at hcurv
  have hsq : deriv φ x₁ ^ 2 ≤ (L : ℝ) ^ 2 := by
    have := sq_le_sq' (abs_le.1 hder).1 (abs_le.1 hder).2
    exact this
  have : (1 + deriv φ x₁ ^ 2) ^ ((3 : ℝ) / 2) ≤ K :=
    Real.rpow_le_rpow (by positivity) (by linarith) (by norm_num)
  linarith

/-- **FS111-M-COVER-SC**, the named corollary (ruling items 18–19): on an interval where `u` is moreover `L`-Lipschitz, `u`
is semiconcave with constant `(1 + L²)^{3/2}`. -/
theorem IsMaximalCover.semiconcaveWith {C : Fin k → Set ℂ} (hC : IsMaximalCover C) (a : Fin k) {z₀ : ℂ} {θ δ : ℝ}
    {α β : ℝ} {u : ℝ → ℝ} (hu : ContinuousOn u (Ioo α β)) (hgraph : IsLowerGraphOf (C a) z₀ θ (Ioo α β) u δ)
    {L : NNReal} (hL : LipschitzOnWith L u (Ioo α β)) :
    SemiconcaveWith ((1 + (L : ℝ) ^ 2) ^ ((3 : ℝ) / 2)) u (Ioo α β) := by
  have hcur := hC.curvatureLeOne a isOpen_Ioo hu hgraph
  intro s h hs hsh hsmh
  rcases lt_trichotomy h 0 with hneg | rfl | hpos
  · have key := semiconcave_pos hu hcur hL (s := s) (h := -h) (by linarith)
      (by rw [show s + -h = s - h by ring]; exact hsmh) (by rw [show s - -h = s + h by ring]; exact hsh)
    rw [show s + -h = s - h by ring, show s - -h = s + h by ring, neg_sq] at key
    linarith
  · simp only [add_zero, sub_zero]; norm_num; linarith
  · exact semiconcave_pos hu hcur hL hpos hsh hsmh

/-- **FS121-D3-GRUNDY**: every a.e.-proper `k`-colouring can be modified, keeping it a.e.-proper with `k` colours and never
raising a point's colour index, into a measurable Grundy colouring `(A_1, …, A_k)`: `A_1` is a MUA set (the case `m = 0`
below), each `A_m` contains `S_m` minus the earlier classes and is maximal among measurable sets with null unit pairs inside
their complement, every point of `supp A_m` is at distance exactly `1` from `supp A_i` for every `i < m`, and at every
essential boundary point every colour of `P(x)` other than the largest is bound (a contact) at `x`. -/
theorem AeColouring.exists_grundy (c : AeColouring k) :
    ∃ c' : AeColouring k, (∀ x, c'.col x ≤ c.col x) ∧
      (∀ m : Fin k, c.cls m \ (⋃ i < m, c'.cls i) ⊆ c'.cls m ∧ c'.cls m ⊆ (⋃ i < m, c'.cls i)ᶜ ∧
        ∀ B : Set ℂ, MeasurableSet B → UnitPairsNull B → B ⊆ (⋃ i < m, c'.cls i)ᶜ → c'.cls m ≤ᵐ[volume] B →
          B ≤ᵐ[volume] c'.cls m) ∧
      (∀ m i : Fin k, i < m → essSupport (c'.cls m) ⊆ unitShadow (essSupport (c'.cls i))) ∧
      (∀ x j, x ∈ essBoundary (c'.cls j) → ∀ j' ∈ essMulticolour c'.cls x, j < j' → IsContactFor (c'.cls j) x) := by
  sorry

end HadwigerNelson.Plane

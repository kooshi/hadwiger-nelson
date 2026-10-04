import Proofs.HadwigerNelson.Plane.Suprema
import Proofs.HadwigerNelson.Plane.DensityPoints

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
`z₀ + e θ · (s + t i)` with `s ∈ J` and `u s − δ < t ≤ u s` are in the density set `Ã`, and those with `u s < t < u s + δ`
are not in `supp A`. (Ruling, `plans/FS131-close-inventory.md` item 56: the region below the graph is read in `Ã`, as the
derivation's pieces `P ⊆ F̃_a` are; it was `supp A`.) -/
def IsLowerGraphOf (A : Set ℂ) (z₀ : ℂ) (θ : ℝ) (J : Set ℝ) (u : ℝ → ℝ) (δ : ℝ) : Prop :=
  0 < δ ∧ ∀ s ∈ J, ∀ t : ℝ, (u s - δ < t → t ≤ u s → z₀ + e θ * (s + t * I) ∈ densitySet A) ∧
    (u s < t → t < u s + δ → z₀ + e θ * (s + t * I) ∉ essSupport A)

/-- Curvature at most `1`, in the viscosity sense for a semiconcave bound: at every `s₀ ∈ J`, every `C²` function `φ` touching
`u` from below at `s₀` has `φ''(s₀) ≤ (1 + φ'(s₀)²)^{3/2}`. (Ruling, `plans/FS131-close-inventory.md` item 57: the test
functions touch from below; from above, `φ = u + N (s − s₀)²` defeats every bound.) -/
def CurvatureLeOne (u : ℝ → ℝ) (J : Set ℝ) : Prop :=
  ∀ s₀ ∈ J, ∀ φ : ℝ → ℝ, ContDiff ℝ 2 φ → φ s₀ = u s₀ → (∀ᶠ s in 𝓝 s₀, φ s ≤ u s) →
    deriv (deriv φ) s₀ ≤ (1 + deriv φ s₀ ^ 2) ^ ((3 : ℝ) / 2)

/-- **FS111-M-COVER-SC**, second clause, **corrected** (the row's "semiconcave with constant 1" is false at R7's cusped
down triangles; ruling `plans/FS131-close-inventory.md` items 18–19): where `∂F_a` is locally the graph of a continuous
`u` with `F_a` below it, `u` has curvature at most `1` in the viscosity sense. -/
theorem IsMaximalCover.curvatureLeOne {C : Fin k → Set ℂ} (hC : IsMaximalCover C) (a : Fin k) {z₀ : ℂ} {θ δ : ℝ}
    {J : Set ℝ} (hJ : IsOpen J) {u : ℝ → ℝ} (hu : ContinuousOn u J) (hgraph : IsLowerGraphOf (C a) z₀ θ J u δ) :
    CurvatureLeOne u J := by
  sorry

/-- Semiconcavity with constant `K` on `J`: `u(s + h) + u(s − h) − 2u(s) ≤ K h²` whenever `s ± h ∈ J`. -/
def SemiconcaveWith (K : ℝ) (u : ℝ → ℝ) (J : Set ℝ) : Prop :=
  ∀ s h, s ∈ J → s + h ∈ J → s - h ∈ J → u (s + h) + u (s - h) - 2 * u s ≤ K * h ^ 2

/-- **FS111-M-COVER-SC**, the named corollary (ruling items 18–19): on an interval where `u` is moreover `L`-Lipschitz, `u`
is semiconcave with constant `(1 + L²)^{3/2}`. -/
theorem IsMaximalCover.semiconcaveWith {C : Fin k → Set ℂ} (hC : IsMaximalCover C) (a : Fin k) {z₀ : ℂ} {θ δ : ℝ}
    {α β : ℝ} {u : ℝ → ℝ} (hu : ContinuousOn u (Ioo α β)) (hgraph : IsLowerGraphOf (C a) z₀ θ (Ioo α β) u δ)
    {L : NNReal} (hL : LipschitzOnWith L u (Ioo α β)) :
    SemiconcaveWith ((1 + (L : ℝ) ^ 2) ^ ((3 : ℝ) / 2)) u (Ioo α β) := by
  sorry

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

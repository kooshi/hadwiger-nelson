import Proofs.HadwigerNelson.Plane.AeColouring
import Proofs.HadwigerNelson.Plane.UnitAvoiding
import Mathlib.MeasureTheory.Function.Floor
import Mathlib.MeasureTheory.Measure.Support
import Mathlib.MeasureTheory.Covering.BesicovitchVectorSpace
import Mathlib.MeasureTheory.Integral.IntervalIntegral.Periodic
import Mathlib.Analysis.Real.Pi.Bounds
import Mathlib.MeasureTheory.Measure.Lebesgue.VolumeOfBalls
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Bounds

/-!
# Families of colour classes: covers, maximal covers, selections, saturation (FS-131 wave 2's foundation)

The primitive stays one set (`Plane/UnitPairs`); a colouring's classes, a cover and a partial colouring are all a
**family** `C : Fin k → Set ℂ`, and what distinguishes them is a predicate on the family, never a separate type: R7 is
"a maximal cover with disjoint classes", DISC7 a maximal cover with overlaps, and a selection from a cover is a colouring
— one object read three ways (`plans/FS131-w2-kernel-plan.md` § 2).

* `AeLE C D` — `C j ⊆ D j` up to null sets for every `j` (the order maximality is taken in).
* `IsAdmissible C` — every class measurable with null unit pairs; `IsAeCover C` — admissible, with union of full measure
  (FS111-M-SATC's "admissible cover"); `IsMaximalCover C` — an admissible cover maximal in `AeLE` among admissible covers.
* `IsSelection C f` — a measurable `f` with `x ∈ C (f x)` for almost every `x`.
* `unitShadow F` — `F + S¹`, the points at distance exactly `1` from `F`; `IsRegularMUA A` — FS111-M2's regular MUA set
  (`|supp A ∖ A| = 0`, `|∂ supp A| = 0`).
* For one class `A`: `essClosure A` (`A* = {d̄_A > 0}`), `essBoundary A` (`∂_e A = A* ∖ Ã`), `unitAnnulus x η`
  (`A_η(x)`), `IsFreeFor A x`, `IsContactFor A x` (`data/fs111/claims.md` § 0). For a family: `essMulticolour C x`
  (`P(x)`), `Saturated C` (every essential boundary point is a contact point of its class), `SaturatedPos C` (with a
  partner of positive upper density, FS111-W-SQ9's "positive-density partners").

**Inhabitant.** `sq9`: the colouring by half-open squares of side `1/2`, square `(i, j)` coloured `(i mod 3, j mod 3)` —
**proper at every unit pair** (two points of one colour are in one square, closer than `1`, or in squares whose index
differs by a nonzero multiple of `3` in some coordinate, farther than `1`), so its classes are an admissible cover and a
partial colouring, and `AeColouring 9` is inhabited sorry-free. Its tightness and saturation are FS111-W-SQ9's content
(`Plane/CoverExamples`); a maximal cover is FS111-M-SATC's output (`Plane/MaximalCover`).
-/

namespace HadwigerNelson.Plane

open Complex Set MeasureTheory Filter Topology Metric Function

variable {k : ℕ}

/-! ## Families, covers, maximal covers, selections -/

/-- Each class of `C` lies in the matching class of `D` up to a null set. -/
def AeLE (C D : Fin k → Set ℂ) : Prop := ∀ j, C j ≤ᵐ[volume] D j

/-- An admissible family: every class is measurable and has null unit pairs. -/
def IsAdmissible (C : Fin k → Set ℂ) : Prop := ∀ j, MeasurableSet (C j) ∧ UnitPairsNull (C j)

/-- An **admissible cover**: an admissible family whose union has full measure. -/
def IsAeCover (C : Fin k → Set ℂ) : Prop := IsAdmissible C ∧ ∀ᵐ x ∂volume, ∃ j, x ∈ C j

/-- A **maximal admissible cover**: an admissible cover that no admissible cover above it (in `AeLE`) strictly exceeds. -/
def IsMaximalCover (C : Fin k → Set ℂ) : Prop :=
  IsAeCover C ∧ ∀ D : Fin k → Set ℂ, IsAeCover D → AeLE C D → AeLE D C

/-- A **selection** from a family: a measurable colouring with `x ∈ C (f x)` for almost every `x`. -/
def IsSelection (C : Fin k → Set ℂ) (f : ℂ → Fin k) : Prop := Measurable f ∧ ∀ᵐ x ∂volume, x ∈ C (f x)

/-- The classes of a colouring, as a family. -/
def AeColouring.cls (c : AeColouring k) (j : Fin k) : Set ℂ := c.col ⁻¹' {j}

theorem AeColouring.measurableSet_cls (c : AeColouring k) (j : Fin k) : MeasurableSet (c.cls j) :=
  c.measurable (measurableSet_singleton j)

theorem AeColouring.iUnion_cls (c : AeColouring k) : ⋃ j, c.cls j = univ :=
  eq_univ_of_forall fun x => mem_iUnion.2 ⟨c.col x, rfl⟩

theorem AeColouring.pairwise_disjoint_cls (c : AeColouring k) : Pairwise (Disjoint on c.cls) :=
  fun _ _ hij => Disjoint.preimage _ (disjoint_singleton.2 hij)

/-- A colouring's classes are an admissible cover. -/
theorem AeColouring.isAeCover (c : AeColouring k) : IsAeCover c.cls :=
  ⟨fun j => ⟨c.measurableSet_cls j, c.unitPairsNull j⟩, Eventually.of_forall fun x => ⟨c.col x, rfl⟩⟩

/-! ## Shadows and regular MUA sets -/

/-- `F + S¹`: the points at distance exactly `1` from some point of `F`. -/
def unitShadow (F : Set ℂ) : Set ℂ := {z | ∃ y ∈ F, dist z y = 1}

/-- FS111-M2's **regular** MUA set: a MUA set `A` whose support `F = supp A` has `|F ∖ A| = 0` and `|∂F| = 0`. -/
def IsRegularMUA (A : Set ℂ) : Prop :=
  IsMUA A ∧ volume (essSupport A \ A) = 0 ∧ volume (frontier (essSupport A)) = 0

/-! ## One class: essential closure and boundary, free and contact points -/

/-- `A* = {x : d̄_A(x) > 0}`, the essential closure. -/
def essClosure (A : Set ℂ) : Set ℂ := {x | 0 < upperDensityAt A x}

/-- `∂_e A = A* ∖ Ã`, the essential boundary. -/
def essBoundary (A : Set ℂ) : Set ℂ := essClosure A \ densitySet A

/-- `A_η(x) = {y : ||y − x| − 1| ≤ η}`, the closed annulus of half-width `η` about the unit circle at `x`. -/
def unitAnnulus (x : ℂ) (η : ℝ) : Set ℂ := {y | |dist y x - 1| ≤ η}

/-- `x ∈ A*` is **free** for `A`: some annulus `A_η(x)`, `η > 0`, meets `Ã` in a null set. -/
def IsFreeFor (A : Set ℂ) (x : ℂ) : Prop :=
  x ∈ essClosure A ∧ ∃ η > 0, volume (densitySet A ∩ unitAnnulus x η) = 0

/-- `x` is a **contact point** of `A`: some point of the closure of `Ã` is at distance exactly `1` from `x`. -/
def IsContactFor (A : Set ℂ) (x : ℂ) : Prop := ∃ y ∈ closure (densitySet A), dist x y = 1

/-! ## A family: essential multicolour and saturation -/

/-- `P(x) = {j : d̄_j(x) > 0}`, the essential multicolour of `x`. -/
def essMulticolour (C : Fin k → Set ℂ) (x : ℂ) : Set (Fin k) := {j | x ∈ essClosure (C j)}

/-- **Saturated**: every essential boundary point of every class is a contact point of that class — for a colouring,
"every essential boundary point is a contact point for each colour of `P(x)`" (`plans/FS111-M-regularity.md` § 2.1). -/
def Saturated (C : Fin k → Set ℂ) : Prop := ∀ j, ∀ x ∈ essBoundary (C j), IsContactFor (C j) x

/-- **Saturated with positive-density partners**: every essential boundary point of a class is at distance exactly `1`
from a point where that class has positive upper density (FS111-W-SQ9's form; FALSE at R7's down arcs). -/
def SaturatedPos (C : Fin k → Set ℂ) : Prop :=
  ∀ j, ∀ x ∈ essBoundary (C j), ∃ y ∈ essClosure (C j), dist x y = 1

/-! ## The inhabitant: nine colours by half-open squares of side `1/2` -/

/-- The square index `⌊2t⌋` of a coordinate, read mod `3`. -/
noncomputable def sq9Index (t : ℝ) : ZMod 3 := (⌊2 * t⌋ : ZMod 3)

/-- `sq9`'s colour: the half-open square `[i/2, (i+1)/2) × [j/2, (j+1)/2)` gets `(i mod 3, j mod 3)`. -/
noncomputable def sq9Col (z : ℂ) : Fin 9 := finProdFinEquiv (sq9Index z.re, sq9Index z.im)

theorem measurable_sq9Col : Measurable sq9Col := by
  have h : sq9Col = (fun p : ℤ × ℤ => finProdFinEquiv ((p.1 : ZMod 3), (p.2 : ZMod 3))) ∘
      fun z : ℂ => (⌊2 * z.re⌋, ⌊2 * z.im⌋) := rfl
  rw [h]
  refine (measurable_of_countable _).comp ?_
  exact (Int.measurable_floor.comp (Complex.continuous_re.measurable.const_mul 2)).prodMk
    (Int.measurable_floor.comp (Complex.continuous_im.measurable.const_mul 2))

/-- One coordinate: equal indices mod `3` put two reals within `1/2` or more than `1` apart. -/
theorem abs_sub_lt_half_or_one_lt_of_sq9Index_eq {s t : ℝ} (h : sq9Index s = sq9Index t) :
    (⌊2 * s⌋ = ⌊2 * t⌋ ∧ |s - t| < 1 / 2) ∨ 1 < |s - t| := by
  have hd : (3 : ℤ) ∣ ⌊2 * s⌋ - ⌊2 * t⌋ := (ZMod.intCast_eq_intCast_iff_dvd_sub _ _ 3).1 h.symm
  have h1 := Int.floor_le (2 * s)
  have h2 := Int.lt_floor_add_one (2 * s)
  have h3 := Int.floor_le (2 * t)
  have h4 := Int.lt_floor_add_one (2 * t)
  rcases eq_or_ne ⌊2 * s⌋ ⌊2 * t⌋ with he | hne
  · left
    refine ⟨he, abs_sub_lt_iff.2 ⟨?_, ?_⟩⟩ <;>
    · have : (⌊2 * s⌋ : ℝ) = ⌊2 * t⌋ := by exact_mod_cast he
      linarith
  · right
    have : 3 ≤ ⌊2 * s⌋ - ⌊2 * t⌋ ∨ ⌊2 * s⌋ - ⌊2 * t⌋ ≤ -3 := by omega
    rcases this with h5 | h5
    · have : (3 : ℝ) ≤ (⌊2 * s⌋ : ℝ) - ⌊2 * t⌋ := by exact_mod_cast h5
      rw [abs_of_pos (by linarith)]; linarith
    · have : (⌊2 * s⌋ : ℝ) - ⌊2 * t⌋ ≤ -3 := by exact_mod_cast h5
      rw [abs_of_neg (by linarith)]; linarith

/-- **`sq9` is proper at every unit pair**: two points at distance exactly `1` get different colours. -/
theorem sq9Col_ne_of_dist_eq_one {x y : ℂ} (hxy : dist x y = 1) : sq9Col x ≠ sq9Col y := by
  intro h
  have h' := finProdFinEquiv.injective h
  simp only [Prod.mk.injEq] at h'
  have hre : |x.re - y.re| ≤ 1 := by
    have := Complex.abs_re_le_norm (x - y); rw [← dist_eq_norm, hxy] at this; simpa using this
  have him : |x.im - y.im| ≤ 1 := by
    have := Complex.abs_im_le_norm (x - y); rw [← dist_eq_norm, hxy] at this; simpa using this
  rcases abs_sub_lt_half_or_one_lt_of_sq9Index_eq h'.1 with ⟨-, hr⟩ | hr
  · rcases abs_sub_lt_half_or_one_lt_of_sq9Index_eq h'.2 with ⟨-, hi⟩ | hi
    · have hsq : dist x y ^ 2 = (x.re - y.re) ^ 2 + (x.im - y.im) ^ 2 := by
        rw [dist_eq_norm, ← Complex.normSq_eq_norm_sq, Complex.normSq_apply]; simp [sq]
      rw [hxy] at hsq
      have a1 : (x.re - y.re) ^ 2 < 1 / 4 := by
        have := sq_abs (x.re - y.re); nlinarith [abs_nonneg (x.re - y.re)]
      have a2 : (x.im - y.im) ^ 2 < 1 / 4 := by
        have := sq_abs (x.im - y.im); nlinarith [abs_nonneg (x.im - y.im)]
      linarith
    · linarith
  · linarith

/-- **The inhabitant**: `sq9` is a measurable nine-colouring with null unit pairs (indeed none). -/
noncomputable def sq9 : AeColouring 9 where
  col := sq9Col
  measurable := measurable_sq9Col
  unitPairsNull j := by
    have : unitPairSet (sq9Col ⁻¹' {j}) = ∅ := by
      ext ⟨x, θ⟩
      simp only [unitPairSet, mem_preimage, mem_singleton_iff, mem_setOf_eq, mem_empty_iff_false, iff_false,
        not_and]
      intro hx hy
      refine sq9Col_ne_of_dist_eq_one ?_ (hx.trans hy.symm)
      rw [dist_eq_norm, sub_add_cancel_left, norm_neg, norm_e]
    rw [UnitPairsNull, this, measure_empty]

/-! ## Spec examples -/

/-- `sq9`'s classes are an admissible cover (the cover-level inhabitant). -/
example : IsAeCover sq9.cls := sq9.isAeCover

/-- A colouring is a selection from its own classes. -/
example : IsSelection sq9.cls sq9.col := ⟨sq9.measurable, Eventually.of_forall fun _ => rfl⟩

/-- `AeLE` is reflexive. -/
example : AeLE sq9.cls sq9.cls := fun _ => EventuallyLE.rfl

/-- `sq9` colours the origin `(0, 0)` and the point `(1/2, 0)` differently, and `(0, 0)` and `(3/2, 0)` alike
(`3/2` apart: the colouring is periodic with period `3/2`, and proper only because `3/2 ≠ 1`). -/
example : sq9.col 0 ≠ sq9.col (1 / 2) ∧ sq9.col 0 = sq9.col (3 / 2) := by
  have h0 : ⌊(2 : ℝ) * 0⌋ = 0 := by norm_num
  have h1 : ⌊(2 : ℝ) * (1 / 2)⌋ = 1 := by norm_num
  have h3 : ⌊(2 : ℝ) * (3 / 2)⌋ = 3 := by norm_num
  refine ⟨?_, ?_⟩ <;>
  · norm_num [sq9, sq9Col, sq9Index, h0, h1, h3]
    decide

/-- The plane has no essential boundary. -/
example : essBoundary (univ : Set ℂ) = ∅ := by
  refine eq_empty_of_forall_notMem fun x hx => hx.2 ?_
  refine tendsto_const_nhds.congr' ?_
  filter_upwards [self_mem_nhdsWithin] with r hr using (densityRatio_univ x hr).symm

/-- Every point is a contact point of the plane. -/
example (x : ℂ) : IsContactFor univ x := by
  refine ⟨x + 1, subset_closure ?_, by simp [dist_eq_norm]⟩
  refine tendsto_const_nhds.congr' ?_
  filter_upwards [self_mem_nhdsWithin] with r hr using (densityRatio_univ _ hr).symm

/-- **Adversary**: no point is a contact point of the empty set. -/
example (x : ℂ) : ¬ IsContactFor ∅ x := by
  rintro ⟨y, hy, -⟩
  have : densitySet (∅ : Set ℂ) = ∅ := by
    ext z
    simp only [densitySet, mem_setOf_eq, mem_empty_iff_false, iff_false]
    intro h
    have h0 : densityRatio ∅ z = fun _ => 0 := by funext r; simp [densityRatio]
    rw [h0] at h
    exact zero_ne_one (tendsto_nhds_unique tendsto_const_nhds h)
  rw [this, closure_empty] at hy
  exact hy

/-! ## Shared children of wave 2 (FS131-I2): a.e. invariance and exhaustion -/

/-- Null sets of the first factor pull back to null unit-pair sets: `{(x,θ) | x + e θ ∈ N}` is null for null `N`. -/
theorem volume_prod_shift_null {N : Set ℂ} (hN : volume N = 0) :
    (volume.prod arcLength) {q : ℂ × ℝ | q.1 + e q.2 ∈ N} = 0 := by
  obtain ⟨N', hNN', hN'm, hN'0⟩ : ∃ N' ⊇ N, MeasurableSet N' ∧ volume N' = 0 :=
    ⟨toMeasurable volume N, subset_toMeasurable _ _, measurableSet_toMeasurable _ _, by rwa [measure_toMeasurable]⟩
  have hm : MeasurableSet {q : ℂ × ℝ | q.1 + e q.2 ∈ N'} :=
    (measurable_fst.add (continuous_e.measurable.comp measurable_snd)) hN'm
  refine measure_mono_null (t := {q : ℂ × ℝ | q.1 + e q.2 ∈ N'}) (fun q hq => hNN' hq) ?_
  rw [Measure.prod_apply_symm hm]
  have : ∀ θ : ℝ, volume ((fun x : ℂ => (x, θ)) ⁻¹' {q : ℂ × ℝ | q.1 + e q.2 ∈ N'}) = 0 := by
    intro θ
    have : (fun x : ℂ => (x, θ)) ⁻¹' {q : ℂ × ℝ | q.1 + e q.2 ∈ N'} = (fun x => x + e θ) ⁻¹' N' := rfl
    rw [this, measure_preimage_add_right]; exact hN'0
  rw [lintegral_congr this]; simp

/-- **`UnitPairsNull` is invariant under a.e. equality.** -/
theorem UnitPairsNull.congr_ae {A B : Set ℂ} (hA : UnitPairsNull A) (h : A =ᵐ[volume] B) : UnitPairsNull B := by
  set N : Set ℂ := {x | ¬ (x ∈ A ↔ x ∈ B)} with hNdef
  have hN : volume N = 0 := ae_iff.mp (Filter.eventuallyEq_set.mp h)
  have h1 : (volume.prod arcLength) {q : ℂ × ℝ | q.1 ∈ N} = 0 := by
    have : {q : ℂ × ℝ | q.1 ∈ N} = N ×ˢ univ := by ext q; simp
    rw [this, Measure.prod_prod, hN, zero_mul]
  have h2 := volume_prod_shift_null hN
  refine measure_mono_null (t := unitPairSet A ∪ {q : ℂ × ℝ | q.1 ∈ N} ∪ {q : ℂ × ℝ | q.1 + e q.2 ∈ N}) ?_
    (measure_union_null (measure_union_null hA h1) h2)
  rintro q ⟨hq1, hq2⟩
  by_cases a1 : q.1 ∈ A
  · by_cases a2 : q.1 + e q.2 ∈ A
    · exact Or.inl (Or.inl ⟨a1, a2⟩)
    · exact Or.inr (show ¬ (q.1 + e q.2 ∈ A ↔ q.1 + e q.2 ∈ B) from fun hh => a2 (hh.mpr hq2))
  · exact Or.inl (Or.inr (show ¬ (q.1 ∈ A ↔ q.1 ∈ B) from fun hh => a1 (hh.mpr hq1)))

/-- **Measure-maximizing exhaustion.** For a predicate `P` on measurable sets that respects a.e. equality and is closed
under increasing countable unions, every `P`-set lies a.e. below an a.e.-maximal one. -/
theorem exists_ae_maximal {α : Type*} [MeasurableSpace α] (μ : Measure α) [SFinite μ] (P : Set α → Prop)
    (hmeas : ∀ B, P B → MeasurableSet B) (hcongr : ∀ B B', P B → MeasurableSet B' → B =ᵐ[μ] B' → P B')
    (hunion : ∀ D : ℕ → Set α, Monotone D → (∀ n, P (D n)) → P (⋃ n, D n)) {A : Set α} (hA : P A) :
    ∃ U, P U ∧ A ≤ᵐ[μ] U ∧ ∀ D, P D → U ≤ᵐ[μ] D → D ≤ᵐ[μ] U := by
  classical
  obtain ⟨ν, hνfin, hμν, hνμ⟩ := exists_isFiniteMeasure_absolutelyContinuous μ
  have hae : ∀ {s t : Set α}, s ≤ᵐ[μ] t → s ≤ᵐ[ν] t := fun h => hνμ.ae_le h
  have hae' : ∀ {s t : Set α}, s ≤ᵐ[ν] t → s ≤ᵐ[μ] t := fun h => hμν.ae_le h
  -- the supremum of `ν` over `P`-sets above `B`
  let s : Set α → ENNReal := fun B => ⨆ (D : Set α) (_ : P D ∧ B ≤ᵐ[μ] D), ν D
  have hs_top : ∀ B, s B ≠ ⊤ := fun B =>
    ne_top_of_le_ne_top (measure_ne_top ν univ) (iSup₂_le fun D _ => measure_mono (subset_univ _))
  -- the step: a `P`-set above `B` almost attaining the supremum
  have step : ∀ (B : Set α) (_ : P B) (n : ℕ), ∃ D, P D ∧ B ≤ᵐ[μ] D ∧ s B < ν D + (1 / (n + 1 : ℕ) : ENNReal) := by
    intro B hB n
    have hpos : (0 : ENNReal) < (1 / (n + 1 : ℕ) : ENNReal) := by simp
    by_cases h0 : s B = 0
    · exact ⟨B, hB, EventuallyLE.rfl, by rw [h0]; exact lt_of_lt_of_le hpos le_add_self⟩
    · have h1 : s B - (1 / (n + 1 : ℕ) : ENNReal) < s B := ENNReal.sub_lt_self (hs_top B) h0 hpos.ne'
      have h2 : s B - (1 / (n + 1 : ℕ) : ENNReal) < ⨆ (D : Set α) (_ : P D ∧ B ≤ᵐ[μ] D), ν D := h1
      obtain ⟨D, hD⟩ := lt_iSup_iff.1 h2
      obtain ⟨hD2, hD1⟩ := lt_iSup_iff.1 hD
      refine ⟨D, hD2.1, hD2.2, ?_⟩
      by_cases hc : (1 / (n + 1 : ℕ) : ENNReal) ≤ s B
      · exact (ENNReal.sub_lt_iff_lt_right (by simp) hc).1 hD1
      · exact lt_of_lt_of_le (not_le.1 hc) le_add_self
  let nxt : ℕ → {B : Set α // P B} → {B : Set α // P B} := fun n B =>
    ⟨(step B.1 B.2 n).choose ∪ B.1, hcongr _ _ (step B.1 B.2 n).choose_spec.1
      ((hmeas _ (step B.1 B.2 n).choose_spec.1).union (hmeas _ B.2))
      (union_ae_eq_left_iff_ae_subset.2 (step B.1 B.2 n).choose_spec.2.1).symm⟩
  let seq : ℕ → {B : Set α // P B} := fun n => Nat.rec ⟨A, hA⟩ nxt n
  have hseq0 : seq 0 = ⟨A, hA⟩ := rfl
  have hseqS : ∀ n, seq (n + 1) = nxt n (seq n) := fun n => rfl
  have hmono : Monotone (fun n => (seq n).1) :=
    monotone_nat_of_le_succ fun n => by rw [hseqS]; exact subset_union_right
  set U : Set α := ⋃ n, (seq n).1 with hU
  have hPU : P U := hunion _ hmono fun n => (seq n).2
  have hsub : ∀ n, (seq n).1 ⊆ U := fun n => subset_iUnion (fun n => (seq n).1) n
  refine ⟨U, hPU, Eventually.of_forall fun x hx => mem_iUnion.2 ⟨0, hx⟩, fun D hD hUD => ?_⟩
  have hbound : ∀ n : ℕ, ν D ≤ ν U + (1 / (n + 1 : ℕ) : ENNReal) := by
    intro n
    have hn : (seq n).1 ≤ᵐ[μ] D := hUD.mono fun y hy hyn => hy (hsub n hyn)
    have h1 : ν D ≤ s (seq n).1 :=
      le_iSup₂ (f := fun (D : Set α) (_ : P D ∧ (seq n).1 ≤ᵐ[μ] D) => ν D) D ⟨hD, hn⟩
    have h2 := (step (seq n).1 (seq n).2 n).choose_spec.2.2
    have h3 : ν (step (seq n).1 (seq n).2 n).choose ≤ ν U :=
      measure_mono (fun x hx => mem_iUnion.2 ⟨n + 1, by rw [hseqS]; exact Or.inl hx⟩)
    exact h1.trans (h2.le.trans (add_le_add h3 le_rfl))
  have hle : ν D ≤ ν U := by
    refine ENNReal.le_of_forall_pos_le_add fun ε hε _ => ?_
    obtain ⟨n, hn⟩ := ENNReal.exists_inv_nat_lt (a := (ε : ENNReal)) (by simpa using hε.ne')
    refine (hbound n).trans (add_le_add le_rfl ?_)
    calc (1 / (n + 1 : ℕ) : ENNReal) ≤ (n : ENNReal)⁻¹ := by
          rw [one_div]; exact ENNReal.inv_le_inv.2 (by exact_mod_cast Nat.le_succ n)
      _ ≤ ε := hn.le
  have hUm : MeasurableSet U := hmeas U hPU
  have hDm : MeasurableSet D := hmeas D hD
  have hUD' : ν U = ν (U ∩ D) := measure_congr (by
    rw [Filter.eventuallyEq_set]
    filter_upwards [hae hUD] with x hx
    exact ⟨fun h => ⟨h, hx h⟩, fun h => h.1⟩)
  have hsplit := measure_inter_add_sdiff (μ := ν) D hUm
  have hfin : ν U ≠ ⊤ := measure_ne_top ν U
  have hz : ν (D \ U) = 0 := by
    have : ν (D \ U) + ν U ≤ 0 + ν U := by
      calc ν (D \ U) + ν U = ν (D \ U) + ν (U ∩ D) := by rw [← hUD']
        _ = ν D := by rw [add_comm, inter_comm, hsplit]
        _ ≤ ν U := hle
        _ = 0 + ν U := (zero_add _).symm
    exact le_antisymm (ENNReal.le_of_add_le_add_right hfin this) bot_le
  have : D \ U =ᵐ[ν] (∅ : Set α) := by rw [ae_eq_empty]; exact hz
  exact hae' (by
    filter_upwards [measure_eq_zero_iff_ae_notMem.1 hz] with x hx hxD
    by_contra hxU
    exact hx ⟨hxD, hxU⟩)

/-- **One MUA set above a measurable set with null unit pairs** (the one-class form of FS111-M-SATC's first clause). -/
theorem exists_isMUA_ae_le {A : Set ℂ} (hA : MeasurableSet A) (hnull : UnitPairsNull A) :
    ∃ A' : Set ℂ, IsMUA A' ∧ A ≤ᵐ[volume] A' := by
  have hu : ∀ D : ℕ → Set ℂ, Monotone D → (∀ n, MeasurableSet (D n) ∧ UnitPairsNull (D n)) →
      MeasurableSet (⋃ n, D n) ∧ UnitPairsNull (⋃ n, D n) := by
    intro D hD hP
    refine ⟨MeasurableSet.iUnion fun n => (hP n).1, ?_⟩
    have : unitPairSet (⋃ n, D n) = ⋃ n, unitPairSet (D n) := by
      ext ⟨x, θ⟩
      simp only [unitPairSet, mem_setOf_eq, mem_iUnion]
      constructor
      · rintro ⟨⟨m, hm⟩, ⟨n, hn⟩⟩
        exact ⟨max m n, hD (le_max_left _ _) hm, hD (le_max_right _ _) hn⟩
      · rintro ⟨n, h1, h2⟩
        exact ⟨⟨n, h1⟩, ⟨n, h2⟩⟩
    rw [UnitPairsNull, this]
    exact measure_iUnion_null fun n => (hP n).2
  obtain ⟨U, ⟨hUm, hUn⟩, hAU, hmax⟩ := exists_ae_maximal (volume : Measure ℂ)
    (fun B : Set ℂ => MeasurableSet B ∧ UnitPairsNull B) (fun B h => h.1)
    (fun B B' hB hB' hBB' => ⟨hB', hB.2.congr_ae hBB'⟩) hu (A := A) ⟨hA, hnull⟩
  exact ⟨U, ⟨hUm, hUn, fun B hBm hBn hUB => hmax B ⟨hBm, hBn⟩ hUB⟩, hAU⟩

/-- The essential support is the support of the restricted measure. -/
theorem essSupport_eq_support (A : Set ℂ) : essSupport A = (volume.restrict A).support := by
  ext x
  rw [Metric.nhds_basis_ball.mem_measureSupport]
  simp only [essSupport, mem_setOf_eq, gt_iff_lt]
  refine forall_congr' fun r => forall_congr' fun _ => ?_
  rw [Measure.restrict_apply measurableSet_ball, inter_comm]

/-- The essential support is closed. -/
theorem isClosed_essSupport (A : Set ℂ) : IsClosed (essSupport A) := by
  rw [essSupport_eq_support]; exact Measure.isClosed_support

/-- The part of a set off its essential support is null. -/
theorem volume_diff_essSupport (A : Set ℂ) : volume (A \ essSupport A) = 0 := by
  have h := Measure.measure_compl_support (μ := volume.restrict A)
  rw [← essSupport_eq_support, Measure.restrict_apply (isClosed_essSupport A).isOpen_compl.measurableSet] at h
  rwa [sdiff_eq, inter_comm]

/-- The essential support is monotone for `≤ᵐ`. -/
theorem essSupport_mono_ae {A B : Set ℂ} (h : A ≤ᵐ[volume] B) : essSupport A ⊆ essSupport B := by
  intro x hx r hr
  have := hx r hr
  refine lt_of_lt_of_le this (measure_mono_ae ?_)
  filter_upwards [h] with y hy hy' using ⟨hy hy'.1, hy'.2⟩

/-- A closed set missing the unit circle about `z` misses a whole annulus about `z`. -/
theorem exists_annulus_subset_compl {F : Set ℂ} (hF : IsClosed F) {z : ℂ} (h : ∀ y ∈ F, dist z y ≠ 1) :
    ∃ δ, 0 < δ ∧ δ < 1 / 2 ∧ ∀ w, |dist w z - 1| < δ → w ∉ F := by
  obtain ⟨δ, hδ, hsub⟩ := (isCompact_sphere z 1).exists_thickening_subset_open hF.isOpen_compl
    (fun y hy hyF => h y hyF (by rw [mem_sphere] at hy; rw [dist_comm]; exact hy))
  refine ⟨min δ (1 / 4), lt_min hδ (by norm_num), lt_of_le_of_lt (min_le_right _ _) (by norm_num), fun w hw hwF => ?_⟩
  have hw1 : |dist w z - 1| < 1 / 4 := lt_of_lt_of_le hw (min_le_right _ _)
  have hwz : w ≠ z := by
    rintro rfl; simp at hw1; norm_num [abs_of_nonneg] at hw1
  have hpos : 0 < dist w z := dist_pos.2 hwz
  -- the radial projection of `w` to the circle
  set y : ℂ := z + (w - z) / ((dist w z : ℝ) : ℂ) with hy
  have hyS : y ∈ sphere z 1 := by
    rw [mem_sphere, dist_eq_norm, hy, add_sub_cancel_left, norm_div, Complex.norm_real, Real.norm_of_nonneg hpos.le,
      ← dist_eq_norm, div_self hpos.ne']
  have hdist : dist w y < min δ (1 / 4) := by
    have h1 : w - y = (w - z) * (((dist w z - 1) / dist w z : ℝ) : ℂ) := by
      have hne : ((dist w z : ℝ) : ℂ) ≠ 0 := by exact_mod_cast hpos.ne'
      rw [hy]; push_cast; field_simp; ring
    have h2 : dist w y = |dist w z - 1| := by
      rw [dist_eq_norm, h1, norm_mul, Complex.norm_real, ← dist_eq_norm, Real.norm_eq_abs, abs_div,
        abs_of_pos hpos]
      field_simp
    rw [h2]; exact hw
  exact (hsub (mem_thickening_iff.2 ⟨y, hyS, lt_of_lt_of_le hdist (min_le_left _ _)⟩)) hwF

/-- Almost every point of `A` is a density point of `A` (Lebesgue density, `A` arbitrary). -/
theorem ae_restrict_mem_densitySet (A : Set ℂ) : ∀ᵐ x ∂(volume.restrict A), x ∈ densitySet A :=
  Besicovitch.ae_tendsto_measure_inter_div volume A

/-- A measurable set differs from its density set by a null set (one half: `A ∖ Ã` is null). -/
theorem volume_diff_densitySet {A : Set ℂ} (hA : MeasurableSet A) : volume (A \ densitySet A) = 0 := by
  have := (ae_restrict_iff' hA).1 (ae_restrict_mem_densitySet A)
  rw [measure_eq_zero_iff_ae_notMem]
  filter_upwards [this] with y hy hyA
  exact hyA.2 (hy hyA.1)

/-- A set with a null part in every small ball about `x` has upper density `0` at `x`. -/
theorem upperDensityAt_eq_zero_of_null {A : Set ℂ} {x : ℂ} {r₀ : ℝ} (hr₀ : 0 < r₀)
    (h : ∀ r, 0 < r → r ≤ r₀ → volume (A ∩ closedBall x r) = 0) : upperDensityAt A x = 0 := by
  have : densityRatio A x =ᶠ[𝓝[>] 0] fun _ => 0 := by
    filter_upwards [Ioo_mem_nhdsGT hr₀] with r hr
    rw [densityRatio, h r hr.1 hr.2.le, ENNReal.zero_div]
  rw [upperDensityAt, limsup_congr this, limsup_const]

/-- The support of `A` is the closure of its density set. -/
theorem essSupport_eq_closure_densitySet (A : Set ℂ) : essSupport A = closure (densitySet A) := by
  apply subset_antisymm
  · intro x hx
    rw [Metric.mem_closure_iff]
    intro ε hε
    have hpos := hx ε hε
    have hae := ae_restrict_mem_densitySet A
    have hne : volume.restrict A (ball x ε) ≠ 0 := by
      rw [Measure.restrict_apply measurableSet_ball, inter_comm]; exact hpos.ne'
    have hne' : ¬ ∀ᵐ y ∂(volume.restrict A), y ∉ ball x ε := by
      intro h
      exact hne (measure_eq_zero_iff_ae_notMem.2 h)
    by_contra hcon
    push Not at hcon
    apply hne'
    filter_upwards [hae] with y hy hyb
    have := hcon y hy
    rw [mem_ball, dist_comm] at hyb
    linarith
  · refine closure_minimal (fun x hx r hr => ?_) (isClosed_essSupport A)
    have h1 : ∀ᶠ s in 𝓝[>] (0 : ℝ), 0 < volume (A ∩ closedBall x s) := by
      have := hx.eventually (lt_mem_nhds (zero_lt_one' ENNReal))
      filter_upwards [this] with s hs
      rw [densityRatio, ENNReal.div_pos_iff] at hs
      exact pos_iff_ne_zero.2 hs.1
    obtain ⟨s, hs, hs0⟩ := (h1.and (Ioo_mem_nhdsGT hr)).exists
    exact lt_of_lt_of_le hs (measure_mono (inter_subset_inter_right _
      (closedBall_subset_ball hs0.2)))

/-- An open set lying a.e. inside `A` lies in the density set of `A`. -/
theorem subset_densitySet_of_isOpen_ae_subset {U A : Set ℂ} (hU : IsOpen U) (h : U ≤ᵐ[volume] A) :
    U ⊆ densitySet A := by
  intro x hx
  obtain ⟨ε, hε, hball⟩ := Metric.isOpen_iff.mp hU x hx
  refine tendsto_const_nhds.congr' ?_
  have : Ioo 0 ε ∈ 𝓝[>] (0 : ℝ) := Ioo_mem_nhdsGT hε
  filter_upwards [this] with r hr
  have hsub : closedBall x r ⊆ U := fun y hy => hball (lt_of_le_of_lt (mem_closedBall.mp hy) hr.2)
  have hAe : volume (A ∩ closedBall x r) = volume (closedBall x r) := by
    refine le_antisymm (measure_mono inter_subset_right) (measure_mono_ae ?_)
    filter_upwards [h] with y hy hyb using ⟨hy (hsub hyb), hyb⟩
  rw [densityRatio, hAe]
  exact (ENNReal.div_self (measure_closedBall_pos volume x hr.1).ne' measure_closedBall_lt_top.ne).symm

/-- `d = ‖d‖ · e (arg d)`. -/
theorem eq_norm_mul_e_arg (d : ℂ) : d = (‖d‖ : ℂ) * e (Complex.arg d) := by
  unfold e
  exact (Complex.norm_mul_exp_arg_mul_I d).symm



/-! ## Arc lemmas: helpers -/

/-- A `2π`-periodic measurable set of angles has the same mass in every window of length `2π`. -/
theorem arcLength_eq_window {S : Set ℝ} (hS : MeasurableSet S) (hper : ∀ θ, θ + 2 * Real.pi ∈ S ↔ θ ∈ S)
    (a : ℝ) : arcLength S = volume (S ∩ Ioc a (a + 2 * Real.pi)) := by
  have hT : 0 < 2 * Real.pi := by positivity
  have h1 : arcLength S = volume (S ∩ Ioc 0 (0 + 2 * Real.pi)) := by
    rw [arcLength, Measure.restrict_apply hS]
    refine measure_congr (ae_eq_set_inter (ae_eq_refl S) ?_)
    rw [zero_add]; exact Ico_ae_eq_Ioc
  rw [h1]
  haveI : VAddInvariantMeasure (AddSubgroup.zmultiples (2 * Real.pi)) ℝ volume :=
    ⟨fun c s _ => measure_preimage_add _ _ _⟩
  refine (isAddFundamentalDomain_Ioc hT 0).measure_set_eq
    (isAddFundamentalDomain_Ioc hT a) hS ?_
  rintro ⟨g, hg⟩
  obtain ⟨n, rfl⟩ := AddSubgroup.mem_zmultiples_iff.1 hg
  ext θ
  have hp : Function.Periodic (fun θ => θ ∈ S) (2 * Real.pi) := fun θ => propext (hper θ)
  have := (hp.zsmul n θ)
  simp only [mem_preimage]
  show (n • (2 * Real.pi) + θ) ∈ S ↔ θ ∈ S
  rw [add_comm]; exact iff_of_eq this

/-- An arc of angles `(α − ε, α + ε)` inside a `2π`-periodic set gives it mass `≥ 2ε`. -/
theorem arcLength_ge_of_Ioo {S : Set ℝ} (hS : MeasurableSet S) (hper : ∀ θ, θ + 2 * Real.pi ∈ S ↔ θ ∈ S)
    {α ε : ℝ} (hε : ε ≤ Real.pi) (hsub : Ioo (α - ε) (α + ε) ⊆ S) :
    ENNReal.ofReal (2 * ε) ≤ arcLength S := by
  rw [arcLength_eq_window hS hper (α - Real.pi)]
  have hw : Ioo (α - ε) (α + ε) ⊆ Ioc (α - Real.pi) (α - Real.pi + 2 * Real.pi) :=
    fun θ hθ => ⟨by linarith [hθ.1], by linarith [hθ.2]⟩
  calc ENNReal.ofReal (2 * ε) = volume (Ioo (α - ε) (α + ε)) := by
        rw [Real.volume_Ioo]; congr 1; ring
    _ ≤ _ := measure_mono (subset_inter hsub hw)

/-- An arc of angles `[α − ε, α + ε]` containing a `2π`-periodic set's mass in one window bounds it by `2ε`. -/
theorem arcLength_le_of_subset_Ioo {S : Set ℝ} (hS : MeasurableSet S) (hper : ∀ θ, θ + 2 * Real.pi ∈ S ↔ θ ∈ S)
    {α ε : ℝ} (hsub : ∀ θ ∈ Ioc (α - Real.pi) (α + Real.pi), θ ∈ S → θ ∈ Ioo (α - ε) (α + ε)) :
    arcLength S ≤ ENNReal.ofReal (2 * ε) := by
  rw [arcLength_eq_window hS hper (α - Real.pi)]
  calc _ ≤ volume (Ioo (α - ε) (α + ε)) := measure_mono (fun θ hθ => hsub θ (by
          have := hθ.2; constructor <;> linarith [this.1, this.2]) hθ.1)
    _ = _ := by rw [Real.volume_Ioo]; congr 1; ring

/-- `‖e θ − s e β‖² = 1 + s² − 2 s cos (θ − β)`. -/
theorem norm_sq_e_sub (θ s β : ℝ) : ‖e θ - (s : ℂ) * e β‖ ^ 2 = 1 + s ^ 2 - 2 * s * Real.cos (θ - β) := by
  have h : e θ - (s : ℂ) * e β = e β * (e (θ - β) - (s : ℂ)) := by
    rw [mul_sub, ← e_add]; ring_nf
  rw [h, norm_mul, norm_e, one_mul, e_eq, Complex.sq_norm, Complex.normSq_apply]
  simp only [Complex.sub_re, Complex.add_re, Complex.ofReal_re, Complex.mul_re, Complex.I_re,
    Complex.ofReal_im, Complex.I_im, Complex.sub_im, Complex.add_im, Complex.mul_im]
  nlinarith [Real.sin_sq_add_cos_sq (θ - β)]

/-- The angles `θ` with `c + σ e θ` in an open set form a measurable set. -/
theorem measurableSet_angles {W : Set ℂ} (hW : IsOpen W) (c : ℂ) (σ : ℝ) :
    MeasurableSet {θ : ℝ | c + σ • e θ ∈ W} := by
  refine (hW.preimage ?_).measurableSet
  unfold e; fun_prop

/-- The mass of `{(u, θ) : u ∈ U, u + e θ ∈ B}` is the integral of `φ_B` over `U`. -/
theorem pairs_eq_lintegral {U B : Set ℂ} (hU : MeasurableSet U) (hB : MeasurableSet B) :
    (volume.prod arcLength) {q : ℂ × ℝ | q.1 ∈ U ∧ q.1 + e q.2 ∈ B} = ∫⁻ u in U, phi B u := by
  have hme : Measurable (fun θ : ℝ => e θ) := by unfold e; fun_prop
  have hP : MeasurableSet {q : ℂ × ℝ | q.1 ∈ U ∧ q.1 + e q.2 ∈ B} :=
    (measurable_fst hU).inter ((measurable_fst.add (hme.comp measurable_snd)) hB)
  rw [Measure.prod_apply hP, ← lintegral_indicator hU]
  refine lintegral_congr fun u => ?_
  by_cases hu : u ∈ U
  · simp [hu, phi, Set.indicator_of_mem]
  · simp [hu]

/-! ## FS131-K2c: shared children — arcs of unit circles in balls, and the two-ball pair bound

Each `sorry`ed; plan `plans/FS131-w2-kernel-plan.md` § 12. They carry `keptAt_band` (`Plane/Slack`) and Lemma 3 of
`falconer_reduction` (`Plane/FalconerReduction`, through `essClosure_dist_ne_one_of_mem_densitySet`). -/

/-- Positive upper density at `x` puts `x` in the support. -/
theorem essClosure_subset_essSupport (A : Set ℂ) : essClosure A ⊆ essSupport A := by
  intro x hx r hr
  by_contra h
  have h0 : volume (A ∩ ball x r) = 0 := by simpa using h
  have : upperDensityAt A x = 0 := by
    refine upperDensityAt_eq_zero_of_null (half_pos hr) fun s hs hsr => ?_
    exact measure_mono_null (inter_subset_inter_right _
      (closedBall_subset_ball (by linarith))) h0
  exact absurd this (ne_of_gt hx)

/-- On a closed ball the ratios of a measurable set and of its complement sum to `1`. -/
theorem densityRatio_add_compl {A : Set ℂ} (hA : MeasurableSet A) (x : ℂ) {r : ℝ} (hr : 0 < r) :
    densityRatio A x r + densityRatio Aᶜ x r = 1 := by
  have hB : volume (closedBall x r) ≠ 0 := (measure_closedBall_pos volume x hr).ne'
  have hB' : volume (closedBall x r) ≠ ⊤ := measure_closedBall_lt_top.ne
  rw [densityRatio, densityRatio, ← ENNReal.add_div]
  have := measure_inter_add_sdiff (μ := volume) (closedBall x r) hA
  rw [inter_comm A, inter_comm Aᶜ, ← sdiff_eq, this, ENNReal.div_self hB hB']

/-- A density point of a measurable set is not a density point of its complement. -/
theorem densitySet_disjoint_compl {A : Set ℂ} (hA : MeasurableSet A) {x : ℂ} (h1 : x ∈ densitySet A) :
    x ∉ densitySet Aᶜ := by
  intro h2
  have := h1.add h2
  have h3 : Tendsto (fun r => densityRatio A x r + densityRatio Aᶜ x r) (𝓝[>] 0) (𝓝 1) :=
    tendsto_const_nhds.congr' (by
      filter_upwards [self_mem_nhdsWithin] with r hr
      exact (densityRatio_add_compl hA x hr).symm)
  have := tendsto_nhds_unique this h3
  norm_num at this

/-- A measurable set differs from its density set by a null set (the other half of `volume_diff_densitySet`). -/
theorem volume_densitySet_diff {A : Set ℂ} (hA : MeasurableSet A) : volume (densitySet A \ A) = 0 := by
  refine measure_mono_null (fun x hx => ?_) (volume_diff_densitySet hA.compl)
  exact ⟨hx.2, densitySet_disjoint_compl hA hx.1⟩

/-- **The chord lemma** (FS106-TQ § 2.2): for `ε ≤ 1/2` and `|x − y| = 1 + t` with `|t| ≤ 3ε/2`, the unit circle about `x`
meets `B(y, 2ε)` in an arc of length at least `2ε`. -/
theorem arcLength_ball_ge {x y : ℂ} {ε t : ℝ} (hε : 0 < ε) (hε2 : ε ≤ 1 / 2) (ht : |t| ≤ 3 * ε / 2)
    (hd : dist x y = 1 + t) : ENNReal.ofReal (2 * ε) ≤ arcLength {θ | x + e θ ∈ ball y (2 * ε)} := by
  set d := y - x with hdd
  have hdn : ‖d‖ = 1 + t := by rw [hdd, ← dist_eq_norm, dist_comm]; exact hd
  set α := Complex.arg d
  have hd' : d = ((1 + t : ℝ) : ℂ) * e α := by
    have := eq_norm_mul_e_arg d; rwa [hdn] at this
  have hS : MeasurableSet {θ : ℝ | x + e θ ∈ ball y (2 * ε)} := by
    have := measurableSet_angles (isOpen_ball (x := y) (ε := 2 * ε)) x 1
    simpa using this
  have hper : ∀ θ, θ + 2 * Real.pi ∈ {θ : ℝ | x + e θ ∈ ball y (2 * ε)} ↔ θ ∈ {θ : ℝ | x + e θ ∈ ball y (2 * ε)} := by
    intro θ; simp only [mem_setOf_eq, e_add_two_pi]
  refine arcLength_ge_of_Ioo hS hper (α := α) (by linarith [Real.pi_gt_three]) ?_
  intro θ hθ
  show x + e θ ∈ ball y (2 * ε)
  rw [mem_ball, dist_eq_norm]
  have hn : ‖x + e θ - y‖ = ‖e θ - ((1 + t : ℝ) : ℂ) * e α‖ := by
    rw [← hd', hdd]; congr 1; ring
  rw [hn]
  have hsq := norm_sq_e_sub θ (1 + t) α
  have hcos := Real.one_sub_sq_div_two_le_cos (x := θ - α)
  have hφ : (θ - α) ^ 2 < ε ^ 2 := by
    have : |θ - α| < ε := abs_lt.2 ⟨by linarith [hθ.1], by linarith [hθ.2]⟩
    nlinarith [abs_nonneg (θ - α), sq_abs (θ - α)]
  have habs := abs_le.1 ht
  have hr0 : 0 ≤ 1 + t := by linarith
  have h1 : 2 * (1 + t) * (1 - Real.cos (θ - α)) ≤ (1 + t) * (θ - α) ^ 2 := by
    nlinarith [mul_nonneg hr0 (sub_nonneg.2 hcos)]
  have h2 : (1 + t) * (θ - α) ^ 2 ≤ 7 / 4 * (θ - α) ^ 2 := by nlinarith [sq_nonneg (θ - α)]
  have h3 : t ^ 2 ≤ 9 / 4 * ε ^ 2 := by nlinarith
  by_contra hcon
  push Not at hcon
  have := mul_self_le_mul_self (by positivity) hcon
  nlinarith

/-- A unit circle meets a ball of radius `ρ ≤ 1` in an arc of length at most `πρ` (written for the directions `v − e θ`,
the form the exchange bound reads). -/
theorem arcLength_sub_ball_le (v z : ℂ) {ρ : ℝ} (hρ : 0 < ρ) (hρ1 : ρ ≤ 1) :
    arcLength {θ | v - e θ ∈ ball z ρ} ≤ ENNReal.ofReal (Real.pi * ρ) := by
  set w := v - z with hwd
  set s := ‖w‖ with hs
  set β := Complex.arg w
  have hw' : w = (s : ℂ) * e β := by simpa using eq_norm_mul_e_arg w
  have hS : MeasurableSet {θ : ℝ | v - e θ ∈ ball z ρ} := by
    have := measurableSet_angles (isOpen_ball (x := z) (ε := ρ)) v (-1)
    simpa [sub_eq_add_neg] using this
  have hper : ∀ θ, θ + 2 * Real.pi ∈ {θ : ℝ | v - e θ ∈ ball z ρ} ↔ θ ∈ {θ : ℝ | v - e θ ∈ ball z ρ} := by
    intro θ; simp only [mem_setOf_eq, e_add_two_pi]
  have hb : arcLength {θ : ℝ | v - e θ ∈ ball z ρ} ≤ ENNReal.ofReal (2 * (Real.pi * ρ / 2)) := by
    refine arcLength_le_of_subset_Ioo hS hper (α := β) ?_
    intro θ hθ hmem
    by_contra hout
    have hφ : Real.pi * ρ / 2 ≤ |θ - β| := by
      by_contra h; push Not at h
      exact hout ⟨by linarith [(abs_lt.1 h).1], by linarith [(abs_lt.1 h).2]⟩
    have habs : |θ - β| ≤ Real.pi := abs_le.2 ⟨by linarith [hθ.1], by linarith [hθ.2]⟩
    have hx0 : 0 ≤ Real.pi * ρ / 2 := by positivity
    have hx1 : Real.pi * ρ / 2 ≤ Real.pi / 2 := by nlinarith [Real.pi_pos]
    have hcos : Real.cos (θ - β) ≤ Real.cos (Real.pi * ρ / 2) := by
      rw [← Real.cos_abs (θ - β)]
      exact Real.cos_le_cos_of_nonneg_of_le_pi hx0 habs hφ
    set κ := Real.cos (Real.pi * ρ / 2) with hκ
    have hκ0 : 0 ≤ κ := Real.cos_nonneg_of_mem_Icc ⟨by linarith, hx1⟩
    have hsin : ρ ≤ Real.sin (Real.pi * ρ / 2) := by
      have := Real.mul_le_sin hx0 hx1
      have h2 : 2 / Real.pi * (Real.pi * ρ / 2) = ρ := by field_simp
      linarith
    have hκ2 : κ ^ 2 ≤ 1 - ρ ^ 2 := by
      have := Real.sin_sq_add_cos_sq (Real.pi * ρ / 2)
      nlinarith
    have hnorm : ‖e θ - (s : ℂ) * e β‖ < ρ := by
      have : v - e θ - z = -(e θ - (s : ℂ) * e β) := by rw [← hw', hwd]; ring
      have h' : ‖v - e θ - z‖ < ρ := by simpa [dist_eq_norm] using hmem
      rwa [this, norm_neg] at h'
    have hsq := norm_sq_e_sub θ s β
    have hlt : ‖e θ - (s : ℂ) * e β‖ ^ 2 < ρ ^ 2 := by nlinarith [norm_nonneg (e θ - (s : ℂ) * e β)]
    have hs0 : 0 ≤ s := norm_nonneg w
    nlinarith [sq_nonneg (s - κ), mul_le_mul_of_nonneg_left hcos hs0]
  refine hb.trans (le_of_eq ?_)
  congr 1; ring

/-- A point of a ball of radius `R > 1` (strict: at `R = 1`, `u = z` the circle about `u` lies on the sphere, outside the open ball; ruling, `plans/FS131-close-inventory.md` item 100) sees at least a third of its unit circle inside the ball. -/
theorem arcLength_bigBall_ge {u z : ℂ} {R : ℝ} (hR : 1 < R) (hu : u ∈ ball z R) :
    ENNReal.ofReal (2 * Real.pi / 3) ≤ arcLength {θ | u + e θ ∈ ball z R} := by
  set w := z - u with hwd
  set s := ‖w‖ with hs
  set β := Complex.arg w
  have hw' : w = (s : ℂ) * e β := by simpa using eq_norm_mul_e_arg w
  have hsR : s < R := by
    have : dist u z < R := mem_ball.1 hu
    rw [dist_eq_norm, ← norm_neg] at this; simpa [hs, hwd] using this
  have hS : MeasurableSet {θ : ℝ | u + e θ ∈ ball z R} := by
    have := measurableSet_angles (isOpen_ball (x := z) (ε := R)) u 1
    simpa using this
  have hper : ∀ θ, θ + 2 * Real.pi ∈ {θ : ℝ | u + e θ ∈ ball z R} ↔ θ ∈ {θ : ℝ | u + e θ ∈ ball z R} := by
    intro θ; simp only [mem_setOf_eq, e_add_two_pi]
  have := arcLength_ge_of_Ioo hS hper (α := β) (ε := Real.pi / 3) (by linarith [Real.pi_pos]) ?_
  · refine le_of_eq_of_le ?_ this; congr 1; ring
  intro θ hθ
  show u + e θ ∈ ball z R
  rw [mem_ball, dist_eq_norm]
  have hn : ‖u + e θ - z‖ = ‖e θ - (s : ℂ) * e β‖ := by
    rw [← hw', hwd]; congr 1; ring
  rw [hn]
  have hsq := norm_sq_e_sub θ s β
  have habs : |θ - β| < Real.pi / 3 := abs_lt.2 ⟨by linarith [hθ.1], by linarith [hθ.2]⟩
  have hcos : 1 / 2 < Real.cos (θ - β) := by
    rw [← Real.cos_abs (θ - β), ← Real.cos_pi_div_three]
    exact Real.cos_lt_cos_of_nonneg_of_le_pi (abs_nonneg _) (by linarith [Real.pi_pos]) habs
  have hs0 : 0 ≤ s := norm_nonneg w
  have hq : s ^ 2 - s + 1 < R ^ 2 := by
    rcases le_or_gt s 1 with h | h <;> nlinarith
  by_contra hcon
  push Not at hcon
  have := mul_self_le_mul_self (by linarith) hcon
  nlinarith [mul_le_mul_of_nonneg_left hcos.le hs0]

/-- **The exchange bound** (FS106-TQ's (EX), Tonelli in the other order): the pairs `(u, θ)` with `u ∈ U`, `u + e θ ∈ N`
have mass at most `M · |N|` when every `v` sees `U` through an arc of length at most `M`. -/
theorem pairs_le_of_arc {U N : Set ℂ} (hU : MeasurableSet U) (hN : MeasurableSet N) {M : ENNReal}
    (hM : ∀ v : ℂ, arcLength {θ | v - e θ ∈ U} ≤ M) :
    (volume.prod arcLength) {q : ℂ × ℝ | q.1 ∈ U ∧ q.1 + e q.2 ∈ N} ≤ M * volume N := by
  have hme : Measurable (fun θ : ℝ => e θ) := by unfold e; fun_prop
  have hP : MeasurableSet {q : ℂ × ℝ | q.1 ∈ U ∧ q.1 + e q.2 ∈ N} :=
    (measurable_fst hU).inter ((measurable_fst.add (hme.comp measurable_snd)) hN)
  rw [Measure.prod_apply_symm hP]
  have hB : ∀ θ : ℝ, MeasurableSet {v : ℂ | v - e θ ∈ U} := fun θ =>
    (measurable_id.sub_const _) hU
  have h1 : ∀ θ : ℝ, volume ((fun x : ℂ => (x, θ)) ⁻¹' {q : ℂ × ℝ | q.1 ∈ U ∧ q.1 + e q.2 ∈ N}) =
      ∫⁻ v in N, {v : ℂ | v - e θ ∈ U}.indicator 1 v := by
    intro θ
    have : (fun x : ℂ => (x, θ)) ⁻¹' {q : ℂ × ℝ | q.1 ∈ U ∧ q.1 + e q.2 ∈ N} =
        (fun x : ℂ => x + e θ) ⁻¹' ({v : ℂ | v - e θ ∈ U} ∩ N) := by
      ext x; simp
    rw [this, measure_preimage_add_right, lintegral_indicator_one (hB θ),
      Measure.restrict_apply (hB θ)]
  simp_rw [h1]
  have hmeas : MeasurableSet {q : ℝ × ℂ | q.2 - e q.1 ∈ U} :=
    (measurable_snd.sub (hme.comp measurable_fst)) hU
  rw [lintegral_lintegral_swap]
  swap
  · exact (measurable_one.indicator hmeas).aemeasurable
  calc ∫⁻ v in N, ∫⁻ θ, {v' : ℂ | v' - e θ ∈ U}.indicator 1 v ∂arcLength ∂volume
      ≤ ∫⁻ v in N, M ∂volume := by
        refine lintegral_mono fun v => ?_
        have hv : MeasurableSet {θ : ℝ | v - e θ ∈ U} := (measurable_const.sub hme) hU
        have : ∫⁻ θ, {v' : ℂ | v' - e θ ∈ U}.indicator 1 v ∂arcLength = arcLength {θ : ℝ | v - e θ ∈ U} := by
          rw [← lintegral_indicator_one hv]; rfl
        rw [this]; exact hM v
    _ = M * volume N := by rw [lintegral_const, Measure.restrict_apply_univ]

/-- **The two-ball pair bound** (good pairs minus bad pairs, FS106-TQ § 2.2 in one inequality): for `r ≤ 1/2` and
`|dist x y − 1| ≤ r`, the unit pairs of `A` from `B(x, r/2)` into `B(y, 2r)`, plus `πr/2` times the hole of `A` in `B(y, 2r)`,
are at least `2r · |A ∩ B(x, r/2)|`. Children: `arcLength_ball_ge` (at `ε = r`), `arcLength_sub_ball_le` (at `ρ = r/2`),
`pairs_le_of_arc`. -/
theorem twoBall_pairs_ge {A : Set ℂ} (hA : MeasurableSet A) {x y : ℂ} {r : ℝ} (hr : 0 < r) (hr2 : r ≤ 1 / 2)
    (hd : |dist x y - 1| ≤ r) :
    ENNReal.ofReal (2 * r) * volume (A ∩ ball x (r / 2)) ≤
      (volume.prod arcLength) {q : ℂ × ℝ | q.1 ∈ A ∩ ball x (r / 2) ∧ q.1 + e q.2 ∈ A ∩ ball y (2 * r)} +
        ENNReal.ofReal (Real.pi * r / 2) * volume (ball y (2 * r) \ A) := by
  set U := A ∩ ball x (r / 2) with hUd
  set N := ball y (2 * r) \ A with hNd
  have hU : MeasurableSet U := hA.inter measurableSet_ball
  have hN : MeasurableSet N := measurableSet_ball.diff hA
  have hB : MeasurableSet (A ∩ ball y (2 * r)) := hA.inter measurableSet_ball
  have hpt : ∀ u ∈ U, ENNReal.ofReal (2 * r) ≤ phi (A ∩ ball y (2 * r)) u + phi N u := by
    intro u hu
    have hux : dist u x < r / 2 := mem_ball.1 hu.2
    have hdu : |dist u y - 1| ≤ 3 * r / 2 := by
      have h1 := abs_dist_sub_le u x y
      have h2 : |dist u y - 1| ≤ |dist u y - dist x y| + |dist x y - 1| := by
        have := abs_add_le (dist u y - dist x y) (dist x y - 1); simpa using this
      linarith
    have := arcLength_ball_ge (x := u) (y := y) (ε := r) (t := dist u y - 1) hr hr2 hdu (by ring)
    refine this.trans ?_
    refine le_trans (measure_mono ?_) (measure_union_le _ _)
    intro θ hθ
    by_cases hAu : u + e θ ∈ A
    · exact Or.inl ⟨hAu, hθ⟩
    · exact Or.inr ⟨hθ, hAu⟩
  have hphi : ∀ B : Set ℂ, MeasurableSet B → Measurable (phi B) := fun B hB => measurable_phi hB
  calc ENNReal.ofReal (2 * r) * volume U = ∫⁻ u in U, ENNReal.ofReal (2 * r) := by
        rw [lintegral_const, Measure.restrict_apply_univ, mul_comm]
    _ ≤ ∫⁻ u in U, (phi (A ∩ ball y (2 * r)) u + phi N u) := setLIntegral_mono' hU hpt
    _ = (∫⁻ u in U, phi (A ∩ ball y (2 * r)) u) + ∫⁻ u in U, phi N u :=
        lintegral_add_left (hphi _ hB) _
    _ ≤ _ := by
        rw [← pairs_eq_lintegral hU hB, ← pairs_eq_lintegral hU hN]
        gcongr
        refine pairs_le_of_arc hU hN fun v => ?_
        have h0 := arcLength_sub_ball_le (v) x (ρ := r / 2) (by positivity) (by linarith)
        have h1 : ENNReal.ofReal (Real.pi * (r / 2)) = ENNReal.ofReal (Real.pi * r / 2) := by
          congr 1; ring
        rw [h1] at h0
        refine le_trans (measure_mono fun θ hθ => ?_) h0
        exact hθ.2

/-- The area of a closed disc, in `ofReal` form. -/
theorem volume_closedBall_ofReal (z : ℂ) {ρ : ℝ} (hρ : 0 ≤ ρ) :
    volume (closedBall z ρ) = ENNReal.ofReal (ρ ^ 2 * Real.pi) := by
  rw [Complex.volume_closedBall, ENNReal.ofReal_mul (sq_nonneg ρ), ENNReal.ofReal_pow hρ, ← NNReal.coe_real_pi,
    ENNReal.ofReal_coe_nnreal]

/-- **Lemma 3's inequality** (from `twoBall_pairs_ge`): for a measurable `A` with null unit pairs and `x`, `y` at distance exactly `1`, `densityRatio A x (r/4) ≤ 16π · densityRatio Aᶜ y (2r)` for `0 < r ≤ 1/2`. -/
theorem densityRatio_le_of_unit_dist {A : Set ℂ} (hA : MeasurableSet A) (hnull : UnitPairsNull A) {x y : ℂ}
    (hxy : dist x y = 1) {r : ℝ} (hr : 0 < r) (hr2 : r ≤ 1 / 2) :
    densityRatio A x (r / 4) ≤ ENNReal.ofReal (16 * Real.pi) * densityRatio Aᶜ y (2 * r) := by
  have hd : |dist x y - 1| ≤ r := by rw [hxy]; simpa using hr.le
  have h2 := twoBall_pairs_ge hA hr hr2 hd
  have hp : (volume.prod arcLength) {q : ℂ × ℝ | q.1 ∈ A ∩ ball x (r / 2) ∧ q.1 + e q.2 ∈ A ∩ ball y (2 * r)} = 0 :=
    measure_mono_null (t := unitPairSet A) (fun q hq => ⟨hq.1.1, hq.2.1⟩) (show (volume.prod arcLength) (unitPairSet A) = 0 from hnull)
  rw [hp, zero_add] at h2
  have hV : volume (A ∩ closedBall x (r / 4)) ≤ volume (A ∩ ball x (r / 2)) :=
    measure_mono (inter_subset_inter_right _ (closedBall_subset_ball (by linarith)))
  have hW : volume (ball y (2 * r) \ A) ≤ volume (Aᶜ ∩ closedBall y (2 * r)) :=
    measure_mono (fun z hz => ⟨hz.2, ball_subset_closedBall hz.1⟩)
  have h3 : ENNReal.ofReal (2 * r) * volume (A ∩ closedBall x (r / 4)) ≤
      ENNReal.ofReal (Real.pi * r / 2) * volume (Aᶜ ∩ closedBall y (2 * r)) :=
    (mul_le_mul_right hV _).trans (h2.trans (mul_le_mul_right hW _))
  have h4 : volume (A ∩ closedBall x (r / 4)) ≤ ENNReal.ofReal (Real.pi / 4) * volume (Aᶜ ∩ closedBall y (2 * r)) := by
    have := mul_le_mul_right h3 (ENNReal.ofReal (1 / (2 * r)))
    rw [← mul_assoc, ← mul_assoc, ← ENNReal.ofReal_mul (by positivity), ← ENNReal.ofReal_mul (by positivity)] at this
    have e1 : 1 / (2 * r) * (2 * r) = 1 := by field_simp
    have e2 : 1 / (2 * r) * (Real.pi * r / 2) = Real.pi / 4 := by field_simp; ring
    rw [e1, e2, ENNReal.ofReal_one, one_mul] at this
    exact this
  unfold densityRatio
  apply ENNReal.div_le_of_le_mul
  rw [volume_closedBall_ofReal _ (by positivity), volume_closedBall_ofReal _ (by positivity)]
  have e3 : ENNReal.ofReal (16 * Real.pi) * (volume (Aᶜ ∩ closedBall y (2 * r)) / ENNReal.ofReal ((2 * r) ^ 2 * Real.pi))
      * ENNReal.ofReal ((r / 4) ^ 2 * Real.pi) = ENNReal.ofReal (Real.pi / 4) * volume (Aᶜ ∩ closedBall y (2 * r)) := by
    have hc2 : ENNReal.ofReal ((2 * r) ^ 2 * Real.pi) ≠ 0 := by
      simpa using (by positivity : 0 < (2 * r) ^ 2 * Real.pi)
    have hc2' : ENNReal.ofReal ((2 * r) ^ 2 * Real.pi) ≠ ⊤ := ENNReal.ofReal_ne_top
    set W := volume (Aᶜ ∩ closedBall y (2 * r))
    have : ENNReal.ofReal (16 * Real.pi) * ENNReal.ofReal ((r / 4) ^ 2 * Real.pi) =
        ENNReal.ofReal (Real.pi / 4) * ENNReal.ofReal ((2 * r) ^ 2 * Real.pi) := by
      rw [← ENNReal.ofReal_mul (by positivity), ← ENNReal.ofReal_mul (by positivity)]
      congr 1; ring
    calc ENNReal.ofReal (16 * Real.pi) * (W / ENNReal.ofReal ((2 * r) ^ 2 * Real.pi)) * ENNReal.ofReal ((r / 4) ^ 2 * Real.pi)
        = (ENNReal.ofReal (16 * Real.pi) * ENNReal.ofReal ((r / 4) ^ 2 * Real.pi)) * (W / ENNReal.ofReal ((2 * r) ^ 2 * Real.pi)) := by ring
      _ = ENNReal.ofReal (Real.pi / 4) * (ENNReal.ofReal ((2 * r) ^ 2 * Real.pi) * (W / ENNReal.ofReal ((2 * r) ^ 2 * Real.pi))) := by
        rw [this, mul_assoc]
      _ = ENNReal.ofReal (Real.pi / 4) * W := by
        rw [mul_comm (ENNReal.ofReal _) (W / _), ENNReal.div_mul_cancel hc2 hc2']
  rw [e3]; exact h4

/-- Scaling by a positive constant maps `𝓝[>] 0` to itself. -/
theorem tendsto_mul_nhdsGT (c : ℝ) (hc : 0 < c) : Tendsto (fun r : ℝ => c * r) (𝓝[>] 0) (𝓝[>] 0) := by
  refine tendsto_nhdsWithin_iff.2 ⟨?_, ?_⟩
  · have : Tendsto (fun r : ℝ => c * r) (𝓝 0) (𝓝 (c * 0)) := (continuous_const.mul continuous_id).tendsto 0
    rw [mul_zero] at this
    exact this.mono_left nhdsWithin_le_nhds
  · filter_upwards [self_mem_nhdsWithin] with r hr using mul_pos hc hr

/-- **Lemma 3's core** (`[Falconer1981]` Lemma 3, measurable form): for a measurable `A` with null unit pairs, a point
where `A` has positive upper density is never at distance exactly `1` from a density point of `A`. From `twoBall_pairs_ge`
at small `r` (the hole at the density point is `o(r²)`, the mass at the other point `≥ c r²` along a sequence). -/
theorem essClosure_dist_ne_one_of_mem_densitySet {A : Set ℂ} (hA : MeasurableSet A) (hnull : UnitPairsNull A)
    {x y : ℂ} (hx : x ∈ essClosure A) (hy : y ∈ densitySet A) : dist x y ≠ 1 := by
  intro h1
  have hc : Tendsto (densityRatio Aᶜ y) (𝓝[>] 0) (𝓝 0) := by
    have := ENNReal.Tendsto.sub (tendsto_const_nhds (x := (1 : ENNReal))) hy (Or.inl ENNReal.one_ne_top)
    rw [tsub_self] at this
    refine this.congr' ?_
    filter_upwards [self_mem_nhdsWithin] with r hr
    have hs := densityRatio_add_compl hA y hr
    have hne : densityRatio A y r ≠ ⊤ := by
      intro htop; rw [htop, top_add] at hs; exact ENNReal.top_ne_one hs
    exact (ENNReal.eq_sub_of_add_eq hne (by rw [add_comm]; exact hs)).symm
  have hc2 : Tendsto (fun r : ℝ => densityRatio Aᶜ y (2 * r)) (𝓝[>] 0) (𝓝 0) :=
    hc.comp (tendsto_mul_nhdsGT 2 (by norm_num))
  have hK : Tendsto (fun r : ℝ => ENNReal.ofReal (16 * Real.pi) * densityRatio Aᶜ y (2 * r)) (𝓝[>] 0) (𝓝 0) := by
    have := ENNReal.Tendsto.const_mul hc2 (Or.inr (ENNReal.ofReal_ne_top (r := 16 * Real.pi)))
    rwa [mul_zero] at this
  have hF : Tendsto (fun r : ℝ => densityRatio A x (r / 4)) (𝓝[>] 0) (𝓝 0) := by
    refine tendsto_of_tendsto_of_tendsto_of_le_of_le' tendsto_const_nhds hK (Eventually.of_forall fun _ => bot_le) ?_
    filter_upwards [Ioo_mem_nhdsGT (by norm_num : (0:ℝ) < 1 / 2)] with r hr
    exact densityRatio_le_of_unit_dist hA hnull h1 hr.1 hr.2.le
  have hG : Tendsto (densityRatio A x) (𝓝[>] 0) (𝓝 0) := by
    have := hF.comp (tendsto_mul_nhdsGT 4 (by norm_num))
    refine this.congr (fun r => ?_)
    simp only [Function.comp]
    congr 1; ring
  have : upperDensityAt A x = 0 := hG.limsup_eq
  exact absurd this (ne_of_gt hx)

/-- At a density point of a measurable `A` the density of the complement tends to `0`. -/
theorem tendsto_densityRatio_compl_of_mem {A : Set ℂ} (hA : MeasurableSet A) {y : ℂ} (hy : y ∈ densitySet A) :
    Tendsto (densityRatio Aᶜ y) (𝓝[>] 0) (𝓝 0) := by
  have := ENNReal.Tendsto.sub (tendsto_const_nhds (x := (1 : ENNReal))) hy (Or.inl ENNReal.one_ne_top)
  rw [tsub_self] at this
  refine this.congr' ?_
  filter_upwards [self_mem_nhdsWithin] with r hr
  have hs := densityRatio_add_compl hA y hr
  have hne : densityRatio A y r ≠ ⊤ := by
    intro htop; rw [htop, top_add] at hs; exact ENNReal.top_ne_one hs
  exact (ENNReal.eq_sub_of_add_eq hne (by rw [add_comm]; exact hs)).symm

/-- The converse: complement density `0` makes a density point. -/
theorem mem_densitySet_of_tendsto_compl {A : Set ℂ} (hA : MeasurableSet A) {y : ℂ}
    (hy : Tendsto (densityRatio Aᶜ y) (𝓝[>] 0) (𝓝 0)) : y ∈ densitySet A := by
  have := ENNReal.Tendsto.sub (tendsto_const_nhds (x := (1 : ENNReal))) hy (Or.inl ENNReal.one_ne_top)
  rw [tsub_zero] at this
  refine this.congr' ?_
  filter_upwards [self_mem_nhdsWithin] with r hr
  have hs := densityRatio_add_compl hA y hr
  have hne : densityRatio Aᶜ y r ≠ ⊤ := by
    intro htop; rw [htop, add_top] at hs; exact ENNReal.top_ne_one hs
  exact (ENNReal.eq_sub_of_add_eq hne hs).symm

/-- For a fixed radius, the density ratio of a measurable set is measurable in the centre (Tonelli). -/
theorem measurable_densityRatio_centre {B : Set ℂ} (hB : MeasurableSet B) (q : ℝ) :
    Measurable fun x : ℂ => densityRatio B x q := by
  have hs : MeasurableSet {p : ℂ × ℂ | p.2 ∈ B ∧ dist p.2 p.1 ≤ q} :=
    (measurable_snd hB).inter (measurableSet_le (continuous_snd.dist continuous_fst).measurable measurable_const)
  have h1 : Measurable fun x : ℂ => volume (B ∩ closedBall x q) := by
    have := measurable_measure_prodMk_left (ν := (volume : Measure ℂ)) hs
    have e : (fun x : ℂ => volume (B ∩ closedBall x q)) =
        fun x : ℂ => (volume : Measure ℂ) (Prod.mk x ⁻¹' {p : ℂ × ℂ | p.2 ∈ B ∧ dist p.2 p.1 ≤ q}) := by
      funext x; congr 1
    rw [e]; exact this
  simp only [densityRatio, Complex.volume_closedBall]
  exact h1.div_const _

/-- The density set read along rational radii (`r ↦ |Aᶜ ∩ B̄(x, r)|` is monotone, and `|B̄(x, q)| ≤ 4|B̄(x, r)|` for `r < q < 2r`). -/
theorem densitySet_iff_rat {A : Set ℂ} (hA : MeasurableSet A) (x : ℂ) :
    x ∈ densitySet A ↔ ∀ n : ℕ, ∃ m : ℕ, ∀ q : ℚ, 0 < (q : ℝ) → (q : ℝ) < 1 / (m + 1) →
      densityRatio Aᶜ x q ≤ ((n : ENNReal) + 1)⁻¹ := by
  constructor
  · intro hx n
    have hc := tendsto_densityRatio_compl_of_mem hA hx
    have h1 := ENNReal.tendsto_nhds_zero.1 hc ((n + 1 : ENNReal)⁻¹) (by simp)
    obtain ⟨u, hu, hsub⟩ := mem_nhdsGT_iff_exists_Ioo_subset.1 h1
    obtain ⟨m, hm⟩ := exists_nat_one_div_lt (show (0 : ℝ) < u from hu)
    refine ⟨m, fun q hq hq1 => hsub ⟨hq, hq1.trans hm⟩⟩
  · intro h
    refine mem_densitySet_of_tendsto_compl hA ?_
    rw [ENNReal.tendsto_nhds_zero]
    intro ε hε
    obtain ⟨n, hn⟩ := ENNReal.exists_inv_nat_lt (a := ε / 4) (by simpa using hε.ne')
    obtain ⟨m, hm⟩ := h n
    have hu : Set.Ioo (0 : ℝ) (1 / (2 * ((m : ℝ) + 1))) ∈ 𝓝[>] (0 : ℝ) := Ioo_mem_nhdsGT (by positivity)
    filter_upwards [hu] with r hr
    obtain ⟨q, hq1, hq2⟩ := exists_rat_btwn (show r < 2 * r by linarith [hr.1])
    have hq0 : (0 : ℝ) < q := hr.1.trans hq1
    have hqm : (q : ℝ) < 1 / ((m : ℝ) + 1) := by
      have := hr.2
      have h2 : 2 * r < 1 / ((m : ℝ) + 1) := by
        rw [lt_div_iff₀ (by positivity)] at this ⊢
        nlinarith
      linarith
    have h3 := hm q hq0 hqm
    -- the comparison of volumes
    have hcr : volume (closedBall x r) = ENNReal.ofReal (r ^ 2 * Real.pi) := volume_closedBall_ofReal x hr.1.le
    have hcq : volume (closedBall x q) = ENNReal.ofReal ((q : ℝ) ^ 2 * Real.pi) := volume_closedBall_ofReal x hq0.le
    have hmono : volume (Aᶜ ∩ closedBall x r) ≤ volume (Aᶜ ∩ closedBall x q) :=
      measure_mono (inter_subset_inter_right _ (closedBall_subset_closedBall hq1.le))
    have hVq : volume (Aᶜ ∩ closedBall x q) = densityRatio Aᶜ x q * volume (closedBall x q) := by
      rw [densityRatio, ENNReal.div_mul_cancel]
      · rw [hcq]; simpa using (by positivity : 0 < (q : ℝ) ^ 2 * Real.pi)
      · rw [hcq]; exact ENNReal.ofReal_ne_top
    have hcmp : volume (closedBall x q) ≤ 4 * volume (closedBall x r) := by
      rw [hcq, hcr, show (4 : ENNReal) = ENNReal.ofReal 4 by simp, ← ENNReal.ofReal_mul (by norm_num)]
      refine ENNReal.ofReal_le_ofReal ?_
      have : (q : ℝ) ^ 2 ≤ 4 * r ^ 2 := by nlinarith [hr.1]
      nlinarith [Real.pi_pos]
    rw [densityRatio]
    apply ENNReal.div_le_of_le_mul
    calc volume (Aᶜ ∩ closedBall x r) ≤ densityRatio Aᶜ x q * volume (closedBall x q) := hVq ▸ hmono
      _ ≤ ((n : ENNReal) + 1)⁻¹ * (4 * volume (closedBall x r)) := mul_le_mul' h3 hcmp
      _ ≤ ε * volume (closedBall x r) := by
        rw [← mul_assoc]
        refine mul_le_mul' ?_ le_rfl
        have h4 : ((n : ENNReal) + 1)⁻¹ ≤ ε / 4 := by
          refine le_trans ?_ hn.le
          exact ENNReal.inv_le_inv.2 (by simp)
        exact (ENNReal.le_div_iff_mul_le (Or.inl (by norm_num)) (Or.inl (by norm_num))).1 h4

/-- Measurable sets have measurable density sets (`[Falconer1981]` Lemma 2 (ii); `r ↦ densityRatio A x r` is continuous on
`r > 0` and `x ↦ densityRatio A x r` continuous, so the limit is read along rational radii). -/
theorem measurableSet_densitySet {A : Set ℂ} (hA : MeasurableSet A) : MeasurableSet (densitySet A) := by
  have : densitySet A = ⋂ n : ℕ, ⋃ m : ℕ, ⋂ q : ℚ, ⋂ (_ : 0 < (q : ℝ) ∧ (q : ℝ) < 1 / (m + 1)),
      {x : ℂ | densityRatio Aᶜ x q ≤ ((n : ENNReal) + 1)⁻¹} := by
    ext x
    simp only [densitySet_iff_rat hA x, mem_iInter, mem_iUnion, mem_setOf_eq, and_imp]
  rw [this]
  refine MeasurableSet.iInter fun n => MeasurableSet.iUnion fun m => MeasurableSet.iInter fun q =>
    MeasurableSet.iInter fun _ => ?_
  exact measurableSet_le (measurable_densityRatio_centre hA.compl q) measurable_const

/-- A point outside the essential closure has density ratio tending to `0`. -/
theorem tendsto_densityRatio_of_notMem_essClosure {A : Set ℂ} {x : ℂ} (h : x ∉ essClosure A) :
    Tendsto (densityRatio A x) (𝓝[>] 0) (𝓝 0) := by
  have h0 : upperDensityAt A x = 0 := by
    simpa [essClosure, pos_iff_ne_zero] using h
  refine tendsto_order.2 ⟨fun a ha => absurd ha (not_lt_zero), fun b hb => ?_⟩
  exact eventually_lt_of_limsup_lt (by rw [upperDensityAt] at h0; rw [h0]; exact hb)

/-- In a finite disjoint measurable cover, a point of the essential boundary of one class lies in the essential closure
of another (the densities of the classes sum to `1`). -/
theorem exists_ne_mem_essClosure {C : Fin k → Set ℂ} (hm : ∀ j, MeasurableSet (C j)) (hd : Pairwise (Disjoint on C))
    (hcov : ⋃ j, C j = univ) {a : Fin k} {x : ℂ} (hx : x ∈ essBoundary (C a)) : ∃ b ≠ a, x ∈ essClosure (C b) := by
  by_contra hcon
  push Not at hcon
  refine hx.2 ?_
  have hsum : ∀ r : ℝ, 0 < r → ∑ b, densityRatio (C b) x r = 1 := by
    intro r hr
    have hB : volume (closedBall x r) ≠ 0 := (measure_closedBall_pos volume x hr).ne'
    have hB' : volume (closedBall x r) ≠ ⊤ := measure_closedBall_lt_top.ne
    simp only [densityRatio, div_eq_mul_inv, ← Finset.sum_mul]
    have : ∑ b, volume (C b ∩ closedBall x r) = volume (closedBall x r) := by
      have h := measure_iUnion (μ := volume) (f := fun b => C b ∩ closedBall x r)
        (fun i j hij => (hd hij).mono inter_subset_left inter_subset_left)
        (fun b => (hm b).inter measurableSet_closedBall)
      rw [tsum_fintype, ← iUnion_inter, hcov, univ_inter] at h
      exact h.symm
    rw [this, ENNReal.mul_inv_cancel hB hB']
  have hS : Tendsto (fun r => ∑ b ∈ Finset.univ.erase a, densityRatio (C b) x r) (𝓝[>] 0) (𝓝 0) := by
    have := tendsto_finsetSum (Finset.univ.erase a) (fun b hb =>
      tendsto_densityRatio_of_notMem_essClosure (hcon b (Finset.ne_of_mem_erase hb)))
    simpa using this
  have h1 := ENNReal.Tendsto.sub (tendsto_const_nhds (x := (1 : ENNReal))) hS (Or.inl ENNReal.one_ne_top)
  rw [tsub_zero] at h1
  refine h1.congr' ?_
  filter_upwards [self_mem_nhdsWithin] with r hr
  have hs := hsum r hr
  rw [← Finset.add_sum_erase _ _ (Finset.mem_univ a)] at hs
  have hne : ∑ b ∈ Finset.univ.erase a, densityRatio (C b) x r ≠ ⊤ := by
    intro htop; rw [htop, add_top] at hs; exact ENNReal.top_ne_one hs
  exact (ENNReal.eq_sub_of_add_eq hne hs).symm

end HadwigerNelson.Plane

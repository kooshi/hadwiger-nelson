import Proofs.HadwigerNelson.Plane.AeColouring
import Proofs.HadwigerNelson.Plane.UnitAvoiding
import Mathlib.MeasureTheory.Function.Floor
import Mathlib.MeasureTheory.Measure.Support
import Mathlib.MeasureTheory.Covering.BesicovitchVectorSpace

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

end HadwigerNelson.Plane

import Proofs.HadwigerNelson.Plane.AeColouring
import Proofs.HadwigerNelson.Plane.UnitAvoiding
import Mathlib.MeasureTheory.Function.Floor

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

end HadwigerNelson.Plane

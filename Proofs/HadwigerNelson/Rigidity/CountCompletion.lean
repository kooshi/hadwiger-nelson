import Proofs.HadwigerNelson.Rigidity.CountResidue
import Mathlib.MeasureTheory.Measure.Haar.Basic
import Mathlib.Topology.Algebra.Group.Pointwise

/-!
# The count's completion: the stable profinite part `K`, its Haar measure, and the edges in the closure (FS-131, job FS131-K12A; module M12, block K; skeleton)

**Read aloud, against the derivation** (J28D § 3.2 C1–C3: `G_S := (L ⊗ ℝ) × ∏_{v stable} O_{L_v} × …`, "`R` embedded
diagonally", "dense", "`T_S` … is the closure of `U`"). The completion is built from residues only:

* `K F` — the closure in `∏_k Lev F k` (each level discrete and finite) of the diagonal image of `R`: a compact abelian group,
  the profinite part of `G_∅`. `ιK` is the diagonal map, `proj k` the level-`k` coordinate, `haarK` the Haar probability
  measure. No completion of a local field is named: what the count reads of `K` is its levels.
* `haarK_proj_preimage` — every level-`k` coset has measure `1/|level k image|`.
* `tendsto_haarK_bad` — **density along cosets**: for a measurable `Y ⊆ K`, the points of `Y` whose level-`k` coset `Y` fills
  to at most `1 − κ` have measure tending to `0` (approximation by clopen cylinders; Haar is regular). This replaces J28V's
  Vitali family on the non-doubling product: the count regularises in `ℂ` only (`Plane.densitySet_bandFree`).
* `G F := (L ⊗ ℝ) × K F`, `ιG` the diagonal map; `denseRange_ιG` (Mathlib's mixed space of `L` and module M9's
  `dense_mixedEmbedding_nsmul_unitRing`).
* `mem_closure_ιG` — **the edges**: `(Δ(e^{iθ}), ιK u) ∈ closure (ιG '' U)` for every `θ` and unit vector `u`. Route: the
  units of a finite ring have finite exponent `h`, so `w^h ≡ 1` at level `k` for every unit vector `w`;
  `Counting.mem_closure_pow` and `Counting.Delta_circle_mem_closure` give `w` with `e(u w^h) ≈ Δ(e^{iθ})`.

**Models.** `ιK 0 = 0`; the trivial colouring's level sets; `F = ℚ` has `level ℚ k` the stable primes of `ℚ(i)` of norm at
most `k`.
-/

namespace HadwigerNelson.Rigidity.Counting

open SpectralChain NumberField MeasureTheory Filter Topology

noncomputable section

variable (F : Subfield ℝ) [NumberField F]

instance (k : ℕ) : TopologicalSpace (Lev F k) := ⊥

instance (k : ℕ) : DiscreteTopology (Lev F k) := ⟨rfl⟩

/-- The diagonal map of `R` into all levels. -/
def ιAll : unitRing F →+ ∀ k, Lev F k := AddMonoidHom.pi fun k => (levR F k).toAddMonoidHom

/-- **`K`**: the closure of the diagonal image of `R` in the product of the levels. -/
def Kgrp : AddSubgroup (∀ k, Lev F k) := (ιAll F).range.topologicalClosure

/-- The stable profinite part of the completion. -/
abbrev K := ↥(Kgrp F)

instance : CompactSpace (K F) := by
  sorry

instance : MeasurableSpace (K F) := borel (K F)

instance : BorelSpace (K F) := ⟨rfl⟩

/-- `R → K`. -/
def ιK : unitRing F →+ K F :=
  AddMonoidHom.codRestrict (ιAll F) (Kgrp F) fun r => (ιAll F).range.le_topologicalClosure ⟨r, rfl⟩

/-- The level-`k` coordinate of `K`. -/
def proj (k : ℕ) : K F →+ Lev F k := (Pi.evalAddMonoidHom (fun k => Lev F k) k).comp (Kgrp F).subtype

theorem proj_ιK (k : ℕ) (r : unitRing F) : proj F k (ιK F r) = levR F k r := rfl

theorem continuous_proj (k : ℕ) : Continuous (proj F k) := by
  sorry

theorem range_proj (k : ℕ) : Set.range (proj F k) = Set.range (levR F k) := by
  sorry

/-- A coarser level is read off a finer one on `K`. -/
theorem proj_eq_zero_of_le {k k' : ℕ} (hk : k' ≤ k) {x : K F} (hx : proj F k x = 0) : proj F k' x = 0 := by
  sorry

/-- **The Haar probability measure of `K`.** -/
def haarK : Measure (K F) := Measure.addHaarMeasure ⊤

instance : IsProbabilityMeasure (haarK F) := by
  sorry

instance : (haarK F).IsAddLeftInvariant := by
  sorry

theorem haarK_proj_preimage (k : ℕ) {a : Lev F k} (ha : a ∈ Set.range (proj F k)) :
    haarK F (proj F k ⁻¹' {a}) = (Nat.card (Set.range (proj F k)) : ENNReal)⁻¹ := by
  sorry

/-- **Density along cosets.** -/
theorem tendsto_haarK_bad {Y : Set (K F)} (hY : MeasurableSet Y) {κ : ENNReal} (hκ : 0 < κ) :
    Tendsto (fun k => haarK F {x | x ∈ Y ∧
      haarK F (Y ∩ proj F k ⁻¹' {proj F k x}) ≤ (1 - κ) * haarK F (proj F k ⁻¹' {proj F k x})}) atTop (𝓝 0) := by
  sorry

/-- **The completion `G_∅ = (L ⊗ ℝ) × K`.** -/
abbrev G := NumberField.mixedEmbedding.mixedSpace (fieldI F) × K F

/-- `R → G_∅`, diagonally: the canonical embedding of `L` and `ιK`. -/
def ιG : unitRing F →+ G F :=
  AddMonoidHom.prod ((NumberField.mixedEmbedding (fieldI F)).toAddMonoidHom.comp (toL F).toAddMonoidHom) (ιK F)

theorem denseRange_ιG : DenseRange (ιG F) := by
  sorry

/-- The unit vectors of `F²`, as elements of `R`. -/
def unitVectorsR : Set (unitRing F) := {r | (r : ℂ) ∈ unitVectors F}

/-- **The edges of the slices lie in the closure of `U`.** -/
theorem mem_closure_ιG (θ : ℝ) {u : unitRing F} (hu : u ∈ unitVectorsR F) :
    (Delta F (Complex.exp (θ * Complex.I)), ιK F u) ∈ closure (ιG F '' unitVectorsR F) := by
  sorry

/-! ## Spec examples -/

example (k : ℕ) : proj F k (ιK F 0) = 0 := by
  rw [proj_ιK, map_zero]

end

end HadwigerNelson.Rigidity.Counting

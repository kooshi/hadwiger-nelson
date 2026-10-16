import Proofs.HadwigerNelson.Collapse.Headline
import Proofs.HadwigerNelson.Plane.OneClass.Fractional
import Proofs.HadwigerNelson.Plane.OneClass.InvariantLaw
import Proofs.HadwigerNelson.Plane.CoverExamples

/-!
# The density form of the collapse: the definitions and the lower half (FS-131, job FS131-KFR1; module D1, skeleton)

**Read aloud, against the informal claim** (`LEDGER.md` row 129: "`α₁(F²) = α_loc(F)` with
`α_loc(F) = max(m₁(ℝ²), sup_v r_v)` (`r_v` a stable place's all-levels independence ratio)"; FS103-F-FRAC, FS103-B-AMEN).

* `stableRatio P` — `r_P`: the supremum over the levels `m ≥ 1` of `|I| / |𝓞 ⧸ P^m|`, `I` an independent set of the
  residue target `levelTarget P m = Cay(𝓞 ⧸ P^m, norm-one)`.
* `localRatio F` — `α_loc(F) = max(m₁(ℝ²), ⨆_P r_P)`.
* `IndepSets F`, `IndepLaw F`, `IndepLaw.density` — an `R ⋊ U`-invariant random independent set of `Cay(R, U)`,
  `R = ℤ[U_F]`, and its density `P(0 ∈ I)`: the one-class namesakes of `Collapse.Xk` and `Collapse.InvColouring`.
* `SetEdgeNull F W` — a set `W ⊆ ℂ × K` whose pairs `(z, x)`, `(z + e^{iθ}, x + ιK u)` both in `W` are null at every unit
  vector `u`: the one-class namesake of `Collapse.SliceEdgeNullK`.

**The lower half** (FRAC step 8; B-AMEN's pullbacks), with no outside theorem: `localRatio_le_finIndepRatio`.

**Models.** `IndepLaw F` is inhabited at every number field by the point mass at the empty set (`nonempty_indepLaw`); a
law of positive density is `Collapse.exists_indepLaw` (module D2). `stableRatio P ≥ 1/2` at a ramified stable prime
(`half_le_stableRatio_of_isRamified`; `F = ℚ`, the prime above `2`).
-/

namespace HadwigerNelson.Collapse

open SpectralChain NumberField MeasureTheory SimpleGraph Rigidity Rigidity.Counting Plane
open scoped ENNReal

noncomputable section

variable {F : Subfield ℝ}

/-! ## The ratios -/

/-- **The all-levels independence ratio of a stable prime**, `r_P`: the supremum, over the levels `m ≥ 1` and the
independent sets `s` of the level-`m` residue target, of `|s| / |𝓞 ⧸ P^m|`. -/
def stableRatio (P : StablePrime F) : ℝ≥0∞ :=
  ⨆ (m : ℕ) (_ : 1 ≤ m) (s : Finset (𝓞 (fieldI F) ⧸ P.P ^ m))
    (_ : (levelTarget P m).IsIndepSet (s : Set (𝓞 (fieldI F) ⧸ P.P ^ m))),
    (s.card : ℝ≥0∞) / (Nat.card (𝓞 (fieldI F) ⧸ P.P ^ m) : ℝ≥0∞)

variable (F) in
/-- **`α_loc(F)`, the local ratio**: the larger of `m₁(ℝ²)` and every stable prime's all-levels ratio. -/
def localRatio : ℝ≥0∞ := max mOne (⨆ P : StablePrime F, stableRatio P)

example (P : StablePrime F) : stableRatio P = ⨆ (m : ℕ) (_ : 1 ≤ m) (s : Finset (𝓞 (fieldI F) ⧸ P.P ^ m))
    (_ : (levelTarget P m).IsIndepSet (s : Set (𝓞 (fieldI F) ⧸ P.P ^ m))),
    (s.card : ℝ≥0∞) / (Nat.card (𝓞 (fieldI F) ⧸ P.P ^ m) : ℝ≥0∞) := rfl

example : localRatio F = max mOne (⨆ P : StablePrime F, stableRatio P) := rfl

/-- An independent set of a level's target holds at most `r_P` of it. -/
theorem card_div_le_stableRatio (P : StablePrime F) {m : ℕ} (hm : 1 ≤ m) (s : Finset (𝓞 (fieldI F) ⧸ P.P ^ m))
    (hs : (levelTarget P m).IsIndepSet (s : Set (𝓞 (fieldI F) ⧸ P.P ^ m))) :
    (s.card : ℝ≥0∞) / (Nat.card (𝓞 (fieldI F) ⧸ P.P ^ m) : ℝ≥0∞) ≤ stableRatio P := by
  sorry

/-- `m₁(ℝ²) ≤ α_loc(F)`. -/
theorem mOne_le_localRatio : mOne ≤ localRatio F := by
  sorry

/-- `r_P ≤ α_loc(F)`. -/
theorem stableRatio_le_localRatio (P : StablePrime F) : stableRatio P ≤ localRatio F := by
  sorry

/-- **What an upper bound on `α_loc` means**: one on `m₁` and on every `r_P`. -/
theorem localRatio_le_iff {r : ℝ≥0∞} : localRatio F ≤ r ↔ mOne ≤ r ∧ ∀ P : StablePrime F, stableRatio P ≤ r := by
  sorry

/-- **From the count's `RatioAtMost` to `r_P`** (the converse of `ratioAtMost_of_stableRatio_le`). -/
theorem stableRatio_le_of_ratioAtMost [NumberField F] {P : StablePrime F} {c : ℝ} (h : RatioAtMost P c) :
    stableRatio P ≤ ENNReal.ofReal c := by
  sorry

/-- **From `r_P` to the count's `RatioAtMost`**: a real bound on `r_P` bounds every level. -/
theorem ratioAtMost_of_stableRatio_le [NumberField F] (P : StablePrime F) {c : ℝ} (hc : 0 ≤ c)
    (h : stableRatio P ≤ ENNReal.ofReal c) : RatioAtMost P c := by
  sorry

/-- `r_P ≤ 1`. -/
theorem stableRatio_le_one [NumberField F] (P : StablePrime F) : stableRatio P ≤ 1 := by
  sorry

/-- **At a ramified stable prime `r_P ≥ 1/2`**: the level-one target is two-colourable
(`Rigidity.colorable_two_levelTarget_one_of_isRamified`), and a colour class holds half of it. -/
theorem half_le_stableRatio_of_isRamified [NumberField F] {P : StablePrime F} (h : IsRamified P) :
    2⁻¹ ≤ stableRatio P := by
  sorry

/-- **Hoffman at every level from thickness**: a `c`-thick stable prime has all-levels ratio at most `c/(1 + c)` (a
modulus bound on the character sums bounds their real parts; `Rigidity/ClassRatio`'s `ratioAtMost_of_charBound`). -/
theorem ratioAtMost_of_thickAt [NumberField F] {P : StablePrime F} {c : ℝ} (hc : 0 ≤ c) (h : ThickAt P c) :
    RatioAtMost P (c / (1 + c)) := by
  sorry

/-- `r_P ≤ c/(1 + c)` at a `c`-thick stable prime. -/
theorem stableRatio_le_of_thickAt [NumberField F] {P : StablePrime F} {c : ℝ} (hc : 0 ≤ c) (h : ThickAt P c) :
    stableRatio P ≤ ENNReal.ofReal (c / (1 + c)) := by
  sorry

/-! ## The lower half -/

/-- **The averaging lemma for a Cayley target** (the No-Homomorphism lemma's density form): a graph with a homomorphism
into a translation-invariant graph on a finite abelian group has finitary ratio at least the target's independent sets'
proportion — the translates of an independent set pull back to independent sets, and on average they meet a finite set in
its proportion. -/
theorem card_div_le_finIndepRatio_of_hom {V A : Type*} [AddCommGroup A] [Finite A] {G : SimpleGraph V}
    {H : SimpleGraph A} (hH : ∀ a x y : A, H.Adj (x + a) (y + a) ↔ H.Adj x y) (φ : G →g H) (s : Finset A)
    (hs : H.IsIndepSet (s : Set A)) : (s.card : ℝ≥0∞) / (Nat.card A : ℝ≥0∞) ≤ G.finIndepRatio := by
  sorry

/-- The residue targets are translation-invariant (adjacency reads `x − y`). -/
theorem levelTarget_adj_add (P : StablePrime F) (m : ℕ) (a x y : 𝓞 (fieldI F) ⧸ P.P ^ m) :
    (levelTarget P m).Adj (x + a) (y + a) ↔ (levelTarget P m).Adj x y := by
  sorry

/-- **`r_P ≤ α₁(F²)`** (the pullback at a stable place): `UpperHalf.exists_hom_levelTarget` and the averaging lemma. -/
theorem stableRatio_le_finIndepRatio [NumberField F] (P : StablePrime F) :
    stableRatio P ≤ ((unitDistance ℂ).induce (planeOver F)).finIndepRatio := by
  sorry

/-- **`m₁(ℝ²) ≤ α₁(F²)`** (the pullback at the real place): `F²` is a subgraph of the plane, and
`OneClass.mOne_le_finIndepRatio` (C133-EASY, no outside theorem). -/
theorem mOne_le_finIndepRatio_planeOver (F : Subfield ℝ) :
    mOne ≤ ((unitDistance ℂ).induce (planeOver F)).finIndepRatio := by
  sorry

/-- **The lower half, `α_loc(F) ≤ α₁(F²)`**, at every real number field, with no outside theorem. -/
theorem localRatio_le_finIndepRatio [NumberField F] :
    localRatio F ≤ ((unitDistance ℂ).induce (planeOver F)).finIndepRatio := by
  sorry

/-- `α₁(F²) ≤ 1/2`: `0` and `1` are at distance one. -/
theorem finIndepRatio_planeOver_le_half (F : Subfield ℝ) :
    ((unitDistance ℂ).induce (planeOver F)).finIndepRatio ≤ 2⁻¹ := by
  sorry

/-! ## `m₁(ℝ²) > 1/6`, from `disc7` -/

/-- **`m₁(ℝ²) ≥ 2π/(21√3) = 0.1727…`**: the interior of one class of the seven-disc colouring (`Plane.disc7 0`, closed
discs of radius `1/2`) has no unit pair (`disc7_unitPair_mem_sphere`: a class's unit pairs lie on its spheres) and the class's
density (`disc7_upperDensity`, `volume_frontier_disc7`, `upperDensity_congr_ae`). -/
theorem disc7_le_mOne : ENNReal.ofReal (2 * Real.pi / (21 * Real.sqrt 3)) ≤ mOne := by
  sorry

/-- `1/6 < m₁(ℝ²)`: `2π/(21√3) > 1/6` (`π > 3.14`, `√3 < 1.733`). -/
theorem sixth_lt_mOne : (6 : ℝ≥0∞)⁻¹ < mOne := by
  sorry

/-! ## Random independent sets of `Cay(R, U)` -/

variable (F) in
/-- **The independent sets of `Cay(R, U)`**, as indicators `R → Bool`: no two points of the set differ by a unit vector. -/
def IndepSets : Set (unitRing F → Bool) :=
  {c | ∀ x y : unitRing F, (y : ℂ) - x ∈ unitVectors F → ¬ (c x = true ∧ c y = true)}

variable (F) in
/-- **An invariant random independent set** of `Cay(R, U)`: a probability on `R → Bool` carried by `IndepSets F`,
invariant under every translation and every rotation (the one-class `InvColouring`). -/
structure IndepLaw where
  /-- The law of the random set. -/
  μ : Measure (unitRing F → Bool)
  /-- It is a probability measure. -/
  isProb : IsProbabilityMeasure μ
  /-- It is carried by the independent sets. -/
  carried : μ (IndepSets F)ᶜ = 0
  /-- Invariant under every translation. -/
  shift_inv : ∀ y : unitRing F, μ.map (fun c x => c (x + y)) = μ
  /-- Invariant under every rotation. -/
  rot_inv : ∀ u : unitVectors F, μ.map (fun c x => c (uvRing u * x)) = μ

/-- **The density** of an invariant random independent set: `P(0 ∈ I)`. -/
def IndepLaw.density (μ : IndepLaw F) : ℝ≥0∞ := μ.μ {c | c 0 = true}

example (μ : IndepLaw F) : μ.density = μ.μ {c | c 0 = true} := rfl

/-- `IndepSets F` is closed (one clopen condition per pair). -/
theorem isClosed_indepSets : IsClosed (IndepSets F) := by
  sorry

/-- `IndepSets F` is measurable when `R` is countable. -/
theorem measurableSet_indepSets [Countable (unitRing F)] : MeasurableSet (IndepSets F) := by
  sorry

/-- **A model**: the point mass at the empty set is an invariant random independent set (of density `0`). -/
theorem nonempty_indepLaw [NumberField F] : Nonempty (IndepLaw F) := by
  sorry

/-! ## Sets of the slice with null edges -/

variable (F) in
/-- **A set of the slice `ℂ × K` with null edges**: at every unit vector `u`, the pairs `(z, x) ∈ W` with
`(z + e^{iθ}, x + ιK u) ∈ W` are null for `vol ⊗ haar ⊗ arc length`. -/
def SetEdgeNull [NumberField F] (W : Set (ℂ × K F)) : Prop :=
  ∀ u ∈ unitVectorsR F, ((volume.prod (haarK F)).prod arcLength)
    {p : (ℂ × K F) × ℝ | p.1 ∈ W ∧ (p.1.1 + e p.2, p.1.2 + ιK F u) ∈ W} = 0

/-- The empty set has null edges (the model of `SetEdgeNull`; a positive-measure one is `exists_slice_set`'s). -/
theorem setEdgeNull_empty [NumberField F] : SetEdgeNull F ∅ := by
  sorry

end

end HadwigerNelson.Collapse

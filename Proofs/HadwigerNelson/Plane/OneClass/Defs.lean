import Proofs.HadwigerNelson.Plane.Suprema
import Proofs.HadwigerNelson.UnitDistance
import Proofs.HadwigerNelson.Fractional
import Proofs.HadwigerNelson.Outside.OAI158Rigidity
import Mathlib.Combinatorics.SimpleGraph.Circulant

/-!
# The one-class transfer: the definitions (FS-133)

The vocabulary of `plans/FS133-E1-derivation.md` § 1, each definition beside the printed one it stands for
(`plans/FS133-kernel-plan.md` stage 3 has the table).

* `SimpleGraph.finIndepRatio G` — the infimum of `α(G[S]) / |S|` over the nonempty finite vertex sets `S`:
  `[Davies2026]` p. 6, "ᾱ(G) is the infimum of the independence ratios of its nonempty finite induced subgraphs";
  `[MatolcsiEtAl2025]` p. 5's `α₁(ℝ²)` is `(unitDistance ℂ).finIndepRatio`, and the algebraic plane's is
  `(unitDistance E).finIndepRatio`.
* `Plane.mOne` — `m₁(ℝ²)`: the supremum of the upper densities, along the discs about the origin, of the Borel sets
  with no two points at distance one. `mOne_eq_iSup_nullMeasurableSet` says Lebesgue-measurable sets give the same
  number. That other windows give the same number is the derivation's C133-PER, which is not in this module.
* `Plane.minIndepNum n` — `[DuczVarga2026]`'s `f(n)`: the least independence number of the unit-distance graph on
  `n` points of the plane.
* `OneClass.IsShiftInvariantLaw G P`, `OneClass.IsInvariantLaw G P` — a random independent set of a graph `G` on
  the algebraic plane, as a probability on `E → Bool` (the derivation's `{0,1}^E`) carried by the indicators of
  independent sets, invariant under the translations; under the translations and the algebraic rotations.
* `OneClass.IsPlaneSystem P τ ρ` — a probability space on which the algebraic plane acts by translations `τ` and
  its rotations by `ρ`, measure-preserving and covariant: what the field theorem (`OneClass/Field`) is about.
-/

open MeasureTheory Filter Set
open scoped ENNReal Topology

namespace SimpleGraph

variable {V : Type*}

/-- The finitary independence ratio of a graph: the infimum, over its nonempty finite vertex sets `S`, of the
independence number of the induced graph on `S` divided by `|S|`. -/
noncomputable def finIndepRatio (G : SimpleGraph V) : ℝ≥0∞ :=
  ⨅ (S : Finset V) (_ : S.Nonempty), ((G.induce (S : Set V)).indepNum : ℝ≥0∞) / S.card

/-- **What a lower bound means**: `r ≤ ᾱ(G)` exactly when every nonempty finite vertex set holds an independent
set of at least `r` times its size. The reasoning surface for lower bounds; never unfold `finIndepRatio`. -/
theorem le_finIndepRatio_iff (G : SimpleGraph V) {r : ℝ≥0∞} :
    r ≤ G.finIndepRatio ↔
      ∀ S : Finset V, S.Nonempty → ∃ I : Finset V, I ⊆ S ∧ G.IsIndepSet (I : Set V) ∧ r * S.card ≤ I.card := by
  sorry

/-- **What an upper bound takes**: one finite vertex set all of whose independent subsets have at most `a`
points. -/
theorem finIndepRatio_le_of_forall_card_le (G : SimpleGraph V) {S : Finset V} (hS : S.Nonempty) {a : ℕ}
    (h : ∀ I : Finset V, I ⊆ S → G.IsIndepSet (I : Set V) → I.card ≤ a) :
    G.finIndepRatio ≤ (a : ℝ≥0∞) / S.card := by
  sorry

/-- The ratio is at most one. -/
theorem finIndepRatio_le_one [Nonempty V] (G : SimpleGraph V) : G.finIndepRatio ≤ 1 := by
  sorry

/-- A graph that embeds as an induced subgraph has the larger ratio (its infimum runs over fewer vertex sets). -/
theorem finIndepRatio_le_of_embedding {W : Type*} {G : SimpleGraph V} {G' : SimpleGraph W} (f : G ↪g G') :
    G'.finIndepRatio ≤ G.finIndepRatio := by
  sorry

/-- A `k`-colourable graph has ratio at least `1 / k`: the largest colour class of a finite set. -/
theorem inv_le_finIndepRatio_of_colorable (G : SimpleGraph V) {k : ℕ} (h : G.Colorable k) :
    (k : ℝ≥0∞)⁻¹ ≤ G.finIndepRatio := by
  sorry

/-- The fractional chromatic number of some finite induced subgraph is at least the reciprocal of the ratio:
`χ_f(G[S]) ≥ |S| / α(G[S])`. -/
theorem inv_finIndepRatio_le_iSup_fractionalChromaticNumber (G : SimpleGraph V) :
    G.finIndepRatio⁻¹ ≤ ⨆ S : Finset V, (G.induce (S : Set V)).fractionalChromaticNumber := by
  sorry

end SimpleGraph

namespace HadwigerNelson.Plane

/-- `m₁(ℝ²)`: the supremum of the upper densities (along the discs about the origin, `Plane.upperDensity`) of the
Borel sets of the plane with no two points at distance one. -/
noncomputable def mOne : ℝ≥0∞ :=
  ⨆ (A : Set ℂ) (_ : MeasurableSet A) (_ : (unitDistance ℂ).IsIndepSet A), upperDensity A

/-- The working form of independence in the unit-distance graph. -/
theorem isIndepSet_unitDistance_iff {V : Type*} [MetricSpace V] {A : Set V} :
    (unitDistance V).IsIndepSet A ↔ ∀ x ∈ A, ∀ y ∈ A, dist x y ≠ 1 := by
  sorry

/-- A measurable set with no two points at distance one has upper density at most `m₁`. -/
theorem upperDensity_le_mOne {A : Set ℂ} (hA : MeasurableSet A) (hind : (unitDistance ℂ).IsIndepSet A) :
    upperDensity A ≤ mOne :=
  le_iSup₂_of_le A hA (le_iSup_of_le hind le_rfl)

/-- **What an upper bound on `m₁` means**: a bound on the upper density of every Borel set with no two points at
distance one. With `upperDensity_le_mOne`, the whole reasoning surface of `mOne`. -/
theorem mOne_le_iff {r : ℝ≥0∞} :
    mOne ≤ r ↔ ∀ A : Set ℂ, MeasurableSet A → (unitDistance ℂ).IsIndepSet A → upperDensity A ≤ r := by
  simp only [mOne, iSup_le_iff]

/-- `m₁ ≤ 1`. -/
theorem mOne_le_one : mOne ≤ 1 :=
  iSup₂_le fun A _ => iSup_le fun _ => upperDensity_le_one A

/-- An inhabitant of the supremum's index set: the open disc of radius `1 / 2` is measurable and holds no two points
at distance one. -/
theorem isIndepSet_ball_half : (unitDistance ℂ).IsIndepSet (Metric.ball (0 : ℂ) (1 / 2)) := by
  sorry

/-- **Lebesgue-measurable sets give the same number**: the supremum over the null-measurable sets with no two
points at distance one is `m₁` (such a set holds a Borel set of the same measure in every disc). So `mOne` is the
`m₁(ℝ²)` of `[DuczVarga2026]` § 2.1 and `[Davies2026]` p. 2, where "measurable" is Lebesgue's. -/
theorem mOne_eq_iSup_nullMeasurableSet :
    mOne = ⨆ (A : Set ℂ) (_ : NullMeasurableSet A volume) (_ : (unitDistance ℂ).IsIndepSet A), upperDensity A := by
  sorry

/-- `f(n)` of `[DuczVarga2026]`: the least independence number of the unit-distance graph on `n` points of the
plane. -/
noncomputable def minIndepNum (n : ℕ) : ℕ :=
  ⨅ S : {S : Finset ℂ // S.card = n}, ((unitDistance ℂ).induce (S.1 : Set ℂ)).indepNum

/-- Drift check: one point has independence number one. -/
theorem minIndepNum_one : minIndepNum 1 = 1 := by
  sorry

end HadwigerNelson.Plane

namespace HadwigerNelson.OneClass

open HadwigerNelson.Outside.OAI158 HadwigerNelson.Outside.OAI158.Spectral

/-- The algebraic plane sits in the plane isometrically: an embedding of unit-distance graphs. -/
noncomputable def algPlaneEmbedding : unitDistance E ↪g unitDistance ℂ where
  toFun z := (z : ℂ)
  inj' := fun _ _ h => Subtype.ext h
  map_rel_iff' := by
    sorry

variable {Λ : Type*}

/-- A labelling of the algebraic plane read from the point `z`: `(shiftLab z ℓ) x = ℓ (x + z)`. For the indicator
of a set `I` it is the indicator of `I − z` (the derivation's `τ_z`). -/
noncomputable def shiftLab (z : E) (ℓ : E → Λ) : E → Λ := fun x => ℓ (x + z)

/-- A labelling of the algebraic plane read after a rotation: `(turnLab u ℓ) x = ℓ (u x)`. For the indicator of a
set `I` it is the indicator of `u⁻¹ I` (the derivation's `ρ_u`). -/
noncomputable def turnLab (u : K) (ℓ : E → Λ) : E → Λ := fun x => ℓ (kCoeff u * x)

/-- A translation-invariant random independent set of a graph `G` on the algebraic plane: a probability on
`E → Bool` carried by the indicators of independent sets and invariant under every translation. Its *density* is
`P {I | I 0 = true}`. A consumer opens with `haveI := h.prob`. -/
structure IsShiftInvariantLaw (G : SimpleGraph E) (P : Measure (E → Bool)) : Prop where
  /-- a probability measure -/
  prob : IsProbabilityMeasure P
  /-- carried by the indicators of the independent sets of `G` -/
  indep : ∀ᵐ I ∂P, G.IsIndepSet {z | I z = true}
  /-- invariant under the translations -/
  shift : ∀ z : E, P.map (shiftLab z) = P

/-- An invariant random independent set: invariant under the translations and under the algebraic rotations (the
derivation's "`E ⋊ K`-invariant Borel probability on the space of independent sets"). -/
structure IsInvariantLaw (G : SimpleGraph E) (P : Measure (E → Bool)) : Prop extends IsShiftInvariantLaw G P where
  /-- invariant under the algebraic rotations -/
  turn : ∀ u : K, P.map (turnLab u) = P

/-- A probability space with a measure-preserving action of the algebraic plane (`τ`, translations) and of its
rotations (`ρ`), covariant: `τ z ∘ ρ u = ρ u ∘ τ (u z)`. -/
structure IsPlaneSystem {Ω : Type*} [MeasurableSpace Ω] (P : Measure Ω) (τ : E → Ω → Ω) (ρ : K → Ω → Ω) :
    Prop where
  /-- a probability measure -/
  prob : IsProbabilityMeasure P
  /-- the translations preserve the measure -/
  shift_mp : ∀ z, MeasurePreserving (τ z) P P
  /-- the rotations preserve the measure -/
  turn_mp : ∀ u, MeasurePreserving (ρ u) P P
  /-- the translation by `0` is the identity -/
  shift_zero : ∀ ω, τ 0 ω = ω
  /-- the translations are an action -/
  shift_add : ∀ a b ω, τ (a + b) ω = τ a (τ b ω)
  /-- the rotation by `1` is the identity -/
  turn_one : ∀ ω, ρ 1 ω = ω
  /-- the rotations are an action -/
  turn_mul : ∀ u v ω, ρ (u * v) ω = ρ u (ρ v ω)
  /-- covariance -/
  cov : ∀ u z ω, τ z (ρ u ω) = ρ u (τ (kCoeff u * z) ω)

/-- **An invariant random independent set is a plane system**: the labellings of the algebraic plane under
`shiftLab` and `turnLab`, with any invariant law. (The model of `IsPlaneSystem`'s fields at the law of
`exists_isInvariantLaw`.) -/
theorem IsInvariantLaw.isPlaneSystem {G : SimpleGraph E} {P : Measure (E → Bool)} (h : IsInvariantLaw G P) :
    IsPlaneSystem P shiftLab turnLab := by
  sorry

/-- **A model of the laws**: the point mass at the empty set is an invariant random independent set of every
graph (of density `0`; a law of positive density is `exists_isInvariantLaw`). -/
theorem isInvariantLaw_dirac (G : SimpleGraph E) : IsInvariantLaw G (Measure.dirac fun _ => false) := by
  sorry

end HadwigerNelson.OneClass

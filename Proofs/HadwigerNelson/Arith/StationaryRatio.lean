import Mathlib.MeasureTheory.Measure.Prod
import Mathlib.MeasureTheory.Group.Convolution
import Mathlib.MeasureTheory.Measure.Haar.Basic
import Mathlib.Topology.Algebra.OpenSubgroup
import Mathlib.Dynamics.Ergodic.MeasurePreserving

/-!
# The stationary ratio of a Cayley graph on a measurable group (FS-131 wave 10; X25B-PZ, X25B-L1)

**Read aloud, against the informal claim.** `plans/FS100-X25B-derivation.md` § Stage 2: for a group `G` with a symmetric
measure `ν` (the connection set and its measure), a measurable `W ⊆ G` is *a.e.-independent* if almost no pair `(x, x + t)`,
`t` drawn from `ν`, lies in `W`; the *stationary ratio* `r(G, ν)` is the supremum of `P(0 ∈ W)` over stationary random
a.e.-independent sets `W`.

**The model.** A stationary random set is a probability space with a measure-preserving, jointly measurable action of `G`
and an event `B`: the random set is `W_ω = {x : T_x ω ∈ B}`, and `P(0 ∈ W) = P(B)` (`StationarySet`). Its being a.e.-independent
almost surely is, by stationarity and Tonelli, one equation at the origin: `(ν × P){(t, ω) : ω ∈ B, T_t ω ∈ B} = 0`
(`StationarySet.AEIndependent`) — no Haar measure on `G` enters the definition, so the rows are stated for measurable groups
and σ-finite symmetric `ν`, a wider class than the entry's "LCA Cayley graphs".

**The rows.**
* **X25B-PZ** (`ratio_prod_le`): `r(G × H, ν_G × ν_H) ≤ max(r(G, ν_G), r(H, ν_H))` — Zhang's count at the origin; its child
  `prob_le_ratio_mul` is X25B-P (Zhang's Prop. 1.7, stationary form), a lemma of the same job and not a backlog row.
* **X25B-L1** (`ratio_prod_le_iSup_levels`): for a compact `Y` with open subgroups `K_k` shrinking to `0`,
  `r(X × Y, ν_X × ν_Y) ≤ sup_k r(X × Y, ν_X × (ν_Y ∗ m_{K_k}))`. The level-`k` graph `X × Y/K_k` is stated **pulled back to
  `X × Y`** — connection measure `ν_Y` smoothed by the Haar probability of `K_k` — so no quotient system is needed: a
  stationary set independent for the smoothed measure is `K_k`-invariant up to a larger independent one.

**Inhabitant.** `StationarySet.empty` (one point, the empty event) is a.e.-independent for every `ν`
(`StationarySet.empty_aeIndependent`); a model with `P(B) = 1/2` is `ZMod 2` acting on itself with `B = {0}`, `ν = δ₁`.
-/

namespace HadwigerNelson.StationaryRatio

open MeasureTheory

/-- **A stationary random set in `G`**: a probability space with a jointly measurable measure-preserving action of `G` and an
event `B`; the random set is `W_ω = {x | T x ω ∈ B}`. -/
structure StationarySet (G : Type*) [AddCommGroup G] [MeasurableSpace G] where
  /-- The sample space. -/
  Ω : Type
  /-- Its σ-algebra. -/
  [mΩ : MeasurableSpace Ω]
  /-- The probability. -/
  P : Measure Ω
  /-- It is a probability measure. -/
  isProb : IsProbabilityMeasure P
  /-- The action of `G`. -/
  T : G → Ω → Ω
  /-- It is jointly measurable. -/
  measurable_T : Measurable fun p : G × Ω => T p.1 p.2
  /-- Each `T x` preserves `P`. -/
  preserving : ∀ x, MeasurePreserving (T x) P P
  /-- `T 0 = id`. -/
  T_zero : T 0 = id
  /-- `T (x + y) = T x ∘ T y`. -/
  T_add : ∀ x y, T (x + y) = T x ∘ T y
  /-- The event "the origin is in the set". -/
  B : Set Ω
  /-- It is measurable. -/
  measurableSet_B : MeasurableSet B

attribute [instance] StationarySet.mΩ StationarySet.isProb

variable {G : Type*} [AddCommGroup G] [MeasurableSpace G]

/-- **Almost surely a.e.-independent**, read at the origin: almost no `(t, ω)` has both `0` and `t` in the set. -/
def StationarySet.AEIndependent (W : StationarySet G) (ν : Measure G) : Prop :=
  (ν.prod W.P) {p | p.2 ∈ W.B ∧ W.T p.1 p.2 ∈ W.B} = 0

/-- `N(W)` at the origin: the origin has a `ν`-positive set of neighbours in the set. -/
def StationarySet.nbhd (W : StationarySet G) (ν : Measure G) : Set W.Ω := {ω | 0 < ν {t | W.T (-t) ω ∈ W.B}}

/-- **The stationary ratio** `r(G, ν)`: the supremum of `P(0 ∈ W)` over stationary random a.e.-independent sets. -/
noncomputable def ratio (ν : Measure G) : ENNReal := ⨆ (W : StationarySet G) (_ : W.AEIndependent ν), W.P W.B

/-- The trivial stationary set: one point, the empty event. -/
noncomputable def StationarySet.empty (G : Type*) [AddCommGroup G] [MeasurableSpace G] : StationarySet G where
  Ω := Unit
  P := Measure.dirac ()
  isProb := Measure.dirac.isProbabilityMeasure
  T _ := id
  measurable_T := measurable_snd
  preserving _ := MeasurePreserving.id _
  T_zero := rfl
  T_add _ _ := rfl
  B := ∅
  measurableSet_B := MeasurableSet.empty

theorem StationarySet.empty_aeIndependent (ν : Measure G) : (StationarySet.empty G).AEIndependent ν := by
  show (ν.prod (Measure.dirac ())) {p : G × Unit | p.2 ∈ (∅ : Set Unit) ∧ id p.2 ∈ (∅ : Set Unit)} = 0
  simp

/-- A stationary a.e.-independent set has probability at most the ratio. -/
theorem StationarySet.prob_le_ratio (W : StationarySet G) {ν : Measure G} (hW : W.AEIndependent ν) : W.P W.B ≤ ratio ν :=
  le_iSup₂ (f := fun (W : StationarySet G) (_ : W.AEIndependent ν) => W.P W.B) W hW

/-- **X25B-P** (Zhang's Prop. 1.7, stationary form; a child of X25B-PZ, not a backlog row): "If `A` is a `G`-stationary random
a.e.-independent set, `P(0 ∈ A) ≤ r(G,T)·P(0 ∈ N[A])`." -/
theorem StationarySet.prob_le_ratio_mul [MeasurableAdd₂ G] [MeasurableNeg G] (W : StationarySet G) {ν : Measure G}
    [SigmaFinite ν] (hsymm : ν.map Neg.neg = ν) (hW : W.AEIndependent ν) :
    W.P W.B ≤ ratio ν * W.P (W.B ∪ W.nbhd ν) := by
  sorry

/-- **X25B-PZ**: "the stationary ratio of a categorical product of two LCA Cayley graphs is at most the larger factor's"
(Zhang 2012 §2's argument, measure form) — for measurable groups and σ-finite symmetric connection measures. -/
theorem ratio_prod_le {H : Type*} [AddCommGroup H] [MeasurableSpace H] [MeasurableAdd₂ G] [MeasurableNeg G]
    [MeasurableAdd₂ H] [MeasurableNeg H] (νG : Measure G) (νH : Measure H) [SigmaFinite νG] [SigmaFinite νH]
    (hG : νG.map Neg.neg = νG) (hH : νH.map Neg.neg = νH) :
    ratio (νG.prod νH) ≤ max (ratio νG) (ratio νH) := by
  sorry

/-- The Haar probability of a compact open subgroup `K` of `Y`, as a measure on `Y`. -/
noncomputable def cosetAverage {Y : Type*} [AddCommGroup Y] [TopologicalSpace Y] [IsTopologicalAddGroup Y]
    [LocallyCompactSpace Y] [MeasurableSpace Y] [BorelSpace Y] (K : OpenAddSubgroup Y) : Measure Y :=
  (Measure.addHaar (K : Set Y))⁻¹ • (Measure.addHaar : Measure Y).restrict (K : Set Y)

/-- **X25B-L1**: "a profinite factor's stationary ratio in a product is at most the supremum over its finite levels (fibre
shares above `1/2` form an a.e.-independent set)". `Y` compact with open subgroups `K k` shrinking to `0`; the level-`k` graph is
`X × Y` with `ν_Y` smoothed by the Haar probability of `K k` (the pull-back of `X × Y/K_k`). -/
theorem ratio_prod_le_iSup_levels {X Y : Type*} [AddCommGroup X] [MeasurableSpace X] [MeasurableAdd₂ X]
    [AddCommGroup Y] [TopologicalSpace Y] [IsTopologicalAddGroup Y] [CompactSpace Y] [LocallyCompactSpace Y] [T2Space Y]
    [SecondCountableTopology Y] [MeasurableSpace Y] [BorelSpace Y] (νX : Measure X) [SigmaFinite νX] (νY : Measure Y)
    [IsFiniteMeasure νY] (K : ℕ → OpenAddSubgroup Y) (hK : Antitone K)
    (hK0 : ∀ V ∈ nhds (0 : Y), ∃ k, (K k : Set Y) ⊆ V) :
    ratio (νX.prod νY) ≤ ⨆ k, ratio (νX.prod (Measure.conv νY (cosetAverage (K k)))) := by
  sorry

/-! ## Spec -/

-- the empty event has probability `0`; the ratio is a supremum over a nonempty family.
example : (StationarySet.empty ℤ).P (StationarySet.empty ℤ).B = 0 := measure_empty
example (ν : Measure ℤ) : (0 : ENNReal) ≤ ratio ν := zero_le
-- the empty event is independent for every connection measure, so every ratio is a supremum over a nonempty family.
example (ν : Measure ℤ) : (StationarySet.empty ℤ).AEIndependent ν := StationarySet.empty_aeIndependent ν
example (ν : Measure ℤ) : (StationarySet.empty ℤ).P (StationarySet.empty ℤ).B ≤ ratio ν :=
  (StationarySet.empty ℤ).prob_le_ratio (StationarySet.empty_aeIndependent ν)

end HadwigerNelson.StationaryRatio

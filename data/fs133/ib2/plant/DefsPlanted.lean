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

/-! The bridge between the induced graph on a finite vertex set and the independent subsets of that set: its
independence number is the largest size of one (two private lemmas; every reading of `finIndepRatio` below goes
through them). -/

/-- An independent subset of a finite vertex set has at most the independence number of the induced graph. -/
private theorem card_le_indepNum_induce (G : SimpleGraph V) (S : Finset V) {J : Finset V}
    (hJS : J ⊆ S) (hJ : G.IsIndepSet (J : Set V)) : J.card ≤ (G.induce (S : Set V)).indepNum := by
  classical
  have hind : (G.induce (S : Set V)).IsIndepSet
      ((J.subtype (· ∈ (S : Set V)) : Finset (S : Set V)) : Set (S : Set V)) := by
    intro x hx y hy hxy hadj
    exact hJ (Finset.mem_subtype.1 hx) (Finset.mem_subtype.1 hy) (fun h => hxy (Subtype.ext h))
      (SimpleGraph.induce_adj.1 hadj)
  have hcard : (J.subtype (· ∈ (S : Set V))).card = J.card := by
    rw [Finset.card_subtype, Finset.filter_true_of_mem fun x hx => Finset.mem_coe.2 (hJS hx)]
  rw [← hcard]
  exact SimpleGraph.IsIndepSet.card_le_indepNum hind

/-- The independence number of the graph induced on a finite vertex set is the size of an independent subset of
it. -/
private theorem exists_indep_card_eq_indepNum (G : SimpleGraph V) (S : Finset V) :
    ∃ J : Finset V, J ⊆ S ∧ G.IsIndepSet (J : Set V) ∧ J.card = (G.induce (S : Set V)).indepNum := by
  classical
  obtain ⟨J', hJ'⟩ := (G.induce (S : Set V)).exists_isNIndepSet_indepNum
  refine ⟨J'.map (Function.Embedding.subtype _), ?_, ?_, ?_⟩
  · intro x hx
    obtain ⟨y, -, rfl⟩ := Finset.mem_map.1 hx
    exact y.2
  · intro x hx y hy hxy hadj
    obtain ⟨x', hx', rfl⟩ := Finset.mem_map.1 (Finset.mem_coe.1 hx)
    obtain ⟨y', hy', rfl⟩ := Finset.mem_map.1 (Finset.mem_coe.1 hy)
    exact hJ'.isIndepSet (Finset.mem_coe.2 hx') (Finset.mem_coe.2 hy') (fun h => hxy (congrArg _ h))
      (SimpleGraph.induce_adj.2 hadj)
  · rw [Finset.card_map, hJ'.card_eq]

/-- **What a lower bound means**: `r ≤ ᾱ(G)` exactly when every nonempty finite vertex set holds an independent
set of at least `r` times its size. The reasoning surface for lower bounds; never unfold `finIndepRatio`. -/
theorem le_finIndepRatio_iff (G : SimpleGraph V) {r : ℝ≥0∞} :
    r ≤ G.finIndepRatio ↔
      ∀ S : Finset V, S.Nonempty → ∃ I : Finset V, I ⊆ S ∧ G.IsIndepSet (I : Set V) ∧ r * S.card ≤ I.card := by
  simp only [finIndepRatio, le_iInf_iff]
  refine forall_congr' fun S => forall_congr' fun hS => ?_
  have hcard : (S.card : ℝ≥0∞) ≠ 0 := by simpa using hS.ne_empty
  rw [ENNReal.le_div_iff_mul_le (Or.inl hcard) (Or.inl (ENNReal.natCast_ne_top _))]
  constructor
  · intro h
    obtain ⟨J, hJS, hJ, hJc⟩ := exists_indep_card_eq_indepNum G S
    exact ⟨J, hJS, hJ, by rw [hJc]; exact h⟩
  · rintro ⟨I, hIS, hI, hle⟩
    exact hle.trans (by exact_mod_cast card_le_indepNum_induce G S hIS hI)

/-- **What an upper bound takes**: one finite vertex set all of whose independent subsets have at most `a`
points. -/
theorem finIndepRatio_le_of_forall_card_le (G : SimpleGraph V) {S : Finset V} (hS : S.Nonempty) {a : ℕ}
    (h : ∀ I : Finset V, I ⊆ S → G.IsIndepSet (I : Set V) → I.card ≤ a) :
    G.finIndepRatio ≤ (a : ℝ≥0∞) / S.card := by
  obtain ⟨J, hJS, hJ, hJc⟩ := exists_indep_card_eq_indepNum G S
  calc G.finIndepRatio ≤ ((G.induce (S : Set V)).indepNum : ℝ≥0∞) / S.card :=
        iInf₂_le (f := fun (S : Finset V) (_ : S.Nonempty) =>
          ((G.induce (S : Set V)).indepNum : ℝ≥0∞) / S.card) S hS
    _ ≤ (a : ℝ≥0∞) / S.card := ENNReal.div_le_div_right (by rw [← hJc]; exact_mod_cast h J hJS hJ) _

/-- The ratio is at most one. -/
theorem finIndepRatio_le_one [Nonempty V] (G : SimpleGraph V) (_hplant : (0 : ℕ) = 0) : G.finIndepRatio ≤ 1 := by
  classical
  obtain ⟨v⟩ := ‹Nonempty V›
  have h := G.finIndepRatio_le_of_forall_card_le (Finset.singleton_nonempty v) (a := 1)
    fun I hI _ => (Finset.card_le_card hI).trans (Finset.card_singleton v).le
  simpa using h

/-- A graph that embeds as an induced subgraph has the larger ratio (its infimum runs over fewer vertex sets). -/
theorem finIndepRatio_le_of_embedding {W : Type*} {G : SimpleGraph V} {G' : SimpleGraph W} (f : G ↪g G') :
    G'.finIndepRatio ≤ G.finIndepRatio := by
  classical
  rw [le_finIndepRatio_iff]
  intro S hS
  obtain ⟨I', hI'S, hI', hle⟩ := (G'.le_finIndepRatio_iff.1 le_rfl) (S.map f.toEmbedding) (hS.map)
  refine ⟨S.filter fun v => f v ∈ I', Finset.filter_subset _ _, ?_, ?_⟩
  · intro x hx y hy hxy hadj
    have hx' := (Finset.mem_filter.1 (Finset.mem_coe.1 hx)).2
    have hy' := (Finset.mem_filter.1 (Finset.mem_coe.1 hy)).2
    exact hI' (Finset.mem_coe.2 hx') (Finset.mem_coe.2 hy') (fun h => hxy (f.injective h)) (f.map_adj_iff.2 hadj)
  · rw [Finset.card_map] at hle
    refine hle.trans ?_
    have hsub : I' ⊆ (S.filter fun v => f v ∈ I').map f.toEmbedding := by
      intro w hw
      obtain ⟨v, hv, rfl⟩ := Finset.mem_map.1 (hI'S hw)
      exact Finset.mem_map.2 ⟨v, Finset.mem_filter.2 ⟨hv, hw⟩, rfl⟩
    have hc := Finset.card_le_card hsub
    rw [Finset.card_map] at hc
    exact_mod_cast hc

/-- A `k`-colourable graph has ratio at least `1 / k`: the largest colour class of a finite set. -/
theorem inv_le_finIndepRatio_of_colorable (G : SimpleGraph V) {k : ℕ} (h : G.Colorable k) :
    (k : ℝ≥0∞)⁻¹ ≤ G.finIndepRatio := by
  classical
  obtain ⟨C⟩ := h
  rw [le_finIndepRatio_iff]
  intro S hS
  obtain ⟨v, -⟩ := hS
  have hk : 0 < k := (C v).pos
  -- pigeonhole: some colour class holds at least `|S| / k` points of `S`
  obtain ⟨c, hc⟩ : ∃ c : Fin k, S.card ≤ k * (S.filter fun x => C x = c).card := by
    by_contra hcon
    push Not at hcon
    have hsum : S.card = ∑ c : Fin k, (S.filter fun x => C x = c).card :=
      Finset.card_eq_sum_card_fiberwise fun x _ => Finset.mem_coe.2 (Finset.mem_univ _)
    have hlt : k * S.card < k * S.card :=
      calc k * S.card = ∑ c : Fin k, k * (S.filter fun x => C x = c).card := by
            rw [← Finset.mul_sum, ← hsum]
        _ < ∑ _c : Fin k, S.card := Finset.sum_lt_sum_of_nonempty ⟨C v, Finset.mem_univ _⟩ fun c _ => hcon c
        _ = k * S.card := by simp
    exact lt_irrefl _ hlt
  refine ⟨S.filter fun x => C x = c, Finset.filter_subset _ _, ?_, ?_⟩
  · intro x hx y hy _ hadj
    have hx' := (Finset.mem_filter.1 (Finset.mem_coe.1 hx)).2
    have hy' := (Finset.mem_filter.1 (Finset.mem_coe.1 hy)).2
    exact C.valid hadj (hx'.trans hy'.symm)
  · have hk0 : (k : ℝ≥0∞) ≠ 0 := by exact_mod_cast hk.ne'
    rw [ENNReal.inv_mul_le_iff hk0 (ENNReal.natCast_ne_top k)]
    exact_mod_cast hc

/-- The fractional chromatic number of some finite induced subgraph is at least the reciprocal of the ratio:
`χ_f(G[S]) ≥ |S| / α(G[S])`. -/
theorem inv_finIndepRatio_le_iSup_fractionalChromaticNumber (G : SimpleGraph V) :
    G.finIndepRatio⁻¹ ≤ ⨆ S : Finset V, (G.induce (S : Set V)).fractionalChromaticNumber := by
  classical
  rw [finIndepRatio, ENNReal.inv_iInf]
  refine iSup_mono fun S => ?_
  rw [ENNReal.inv_iInf]
  refine iSup_le fun hS => ?_
  have ha : 0 < (G.induce (S : Set V)).indepNum := by
    obtain ⟨v, hv⟩ := hS
    have h1 : 1 ≤ (G.induce (S : Set V)).indepNum := by
      simpa using card_le_indepNum_induce G S (Finset.singleton_subset_iff.2 hv) (by simp)
    omega
  have hcard : (S.card : ℝ≥0∞) ≠ 0 := by simpa using hS.ne_empty
  rw [ENNReal.inv_div (Or.inl (ENNReal.natCast_ne_top _)) (Or.inl hcard)]
  have h := le_fractionalChromaticNumber_of_indepNum (G := G.induce (S : Set V)) ha
    fun I hI => hI.card_le_indepNum
  simpa using h

end SimpleGraph

namespace HadwigerNelson.Plane

/-- `m₁(ℝ²)`: the supremum of the upper densities (along the discs about the origin, `Plane.upperDensity`) of the
Borel sets of the plane with no two points at distance one. -/
noncomputable def mOne : ℝ≥0∞ :=
  ⨆ (A : Set ℂ) (_ : MeasurableSet A) (_ : (unitDistance ℂ).IsIndepSet A), upperDensity A

/-- The working form of independence in the unit-distance graph. -/
theorem isIndepSet_unitDistance_iff {V : Type*} [MetricSpace V] {A : Set V} :
    (unitDistance V).IsIndepSet A ↔ ∀ x ∈ A, ∀ y ∈ A, dist x y ≠ 1 := by
  constructor
  · intro h x hx y hy hxy
    by_cases hne : x = y
    · subst hne
      rw [dist_self] at hxy
      exact zero_ne_one hxy
    · exact h hx hy hne hxy
  · intro h x hx y hy _ hxy
    exact h x hx y hy hxy

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
  rw [isIndepSet_unitDistance_iff]
  intro x hx y hy hxy
  have h1 := Metric.mem_ball.1 hx
  have h2 := Metric.mem_ball.1 hy
  have h3 := dist_triangle_right x y 0
  linarith

/-- Sets equal almost everywhere have one upper density. -/
private theorem upperDensity_congr_ae {A B : Set ℂ} (h : A =ᵐ[volume] B) : upperDensity A = upperDensity B := by
  unfold upperDensity
  congr 1
  funext R
  rw [measure_congr (ae_eq_set_inter h (ae_eq_refl (Metric.ball (0 : ℂ) R)))]

/-- **Lebesgue-measurable sets give the same number**: the supremum over the null-measurable sets with no two
points at distance one is `m₁` (such a set holds a Borel set of the same measure in every disc). So `mOne` is the
`m₁(ℝ²)` of `[DuczVarga2026]` § 2.1 and `[Davies2026]` p. 2, where "measurable" is Lebesgue's. -/
theorem mOne_eq_iSup_nullMeasurableSet :
    mOne = ⨆ (A : Set ℂ) (_ : NullMeasurableSet A volume) (_ : (unitDistance ℂ).IsIndepSet A), upperDensity A := by
  refine le_antisymm (iSup₂_le fun A hA => iSup_le fun hind => ?_) (iSup₂_le fun A hA => iSup_le fun hind => ?_)
  · exact le_iSup₂_of_le A hA.nullMeasurableSet (le_iSup_of_le hind le_rfl)
  · obtain ⟨B, hBA, hB, hae⟩ := hA.exists_measurable_subset_ae_eq
    calc upperDensity A = upperDensity B := (upperDensity_congr_ae hae).symm
      _ ≤ mOne := upperDensity_le_mOne hB (Set.Pairwise.mono hBA hind)

/-- `f(n)` of `[DuczVarga2026]`: the least independence number of the unit-distance graph on `n` points of the
plane. -/
noncomputable def minIndepNum (n : ℕ) : ℕ :=
  ⨅ S : {S : Finset ℂ // S.card = n}, ((unitDistance ℂ).induce (S.1 : Set ℂ)).indepNum

/-- Drift check: one point has independence number one. -/
theorem minIndepNum_one : minIndepNum 1 = 1 := by
  have hval : ∀ S : {S : Finset ℂ // S.card = 1}, ((unitDistance ℂ).induce (S.1 : Set ℂ)).indepNum = 1 := by
    rintro ⟨S, hS⟩
    obtain ⟨p, rfl⟩ := Finset.card_eq_one.1 hS
    apply le_antisymm
    · obtain ⟨J, hJS, -, hJc⟩ := SimpleGraph.exists_indep_card_eq_indepNum (unitDistance ℂ) {p}
      rw [← hJc]
      exact (Finset.card_le_card hJS).trans (Finset.card_singleton p).le
    · have h := SimpleGraph.card_le_indepNum_induce (unitDistance ℂ) {p} (subset_refl _) (by simp)
      simpa using h
  haveI : Nonempty {S : Finset ℂ // S.card = 1} := ⟨⟨{0}, Finset.card_singleton 0⟩⟩
  simp only [minIndepNum, hval, ciInf_const]

end HadwigerNelson.Plane

namespace HadwigerNelson.OneClass

open HadwigerNelson.Outside.OAI158 HadwigerNelson.Outside.OAI158.Spectral

/-- The algebraic plane sits in the plane isometrically: an embedding of unit-distance graphs. -/
noncomputable def algPlaneEmbedding : unitDistance E ↪g unitDistance ℂ where
  toFun z := (z : ℂ)
  inj' := fun _ _ h => Subtype.ext h
  map_rel_iff' := by
    intro a b
    exact Iff.rfl

variable {Λ : Type*}

/-- A labelling of the algebraic plane read from the point `z`: `(shiftLab z ℓ) x = ℓ (x + z)`. For the indicator
of a set `I` it is the indicator of `I − z` (the derivation's `τ_z`). -/
noncomputable def shiftLab (z : E) (ℓ : E → Λ) : E → Λ := fun x => ℓ (x + z)

/-- A labelling of the algebraic plane read after a rotation: `(turnLab u ℓ) x = ℓ (u x)`. For the indicator of a
set `I` it is the indicator of `u⁻¹ I` (the derivation's `ρ_u`). -/
noncomputable def turnLab (u : K) (ℓ : E → Λ) : E → Λ := fun x => ℓ (kCoeff u * x)

/-! Private helpers for the two models below: the two maps are measurable and the rotations multiply. The point
mass at a labelling sees each point of the labellings' space because the algebraic plane is countable
(`countable_algPlane`, after them). -/

private theorem measurable_shiftLab [MeasurableSpace Λ] (z : E) : Measurable (shiftLab z : (E → Λ) → E → Λ) :=
  measurable_pi_lambda _ fun _ => measurable_pi_apply _

private theorem measurable_turnLab [MeasurableSpace Λ] (u : K) : Measurable (turnLab u : (E → Λ) → E → Λ) :=
  measurable_pi_lambda _ fun _ => measurable_pi_apply _

private theorem kCoeff_one' : kCoeff 1 = 1 :=
  Subtype.ext (show (((1 : K) : Circle) : ℂ) = 1 from Circle.coe_one)

private theorem kCoeff_mul' (u v : K) : kCoeff (u * v) = kCoeff u * kCoeff v :=
  Subtype.ext (show (((u * v : K) : Circle) : ℂ) = ((u : Circle) : ℂ) * ((v : Circle) : ℂ) by
    rw [Subgroup.coe_mul, Circle.coe_mul])

/-- The algebraic plane is countable (the release's `E_countable`; a theorem, not an instance: `E` is Mathlib's
type). -/
theorem countable_algPlane : Countable E := by
  -- each algebraic number is a root of one of the countably many rational polynomials, each of which has finitely
  -- many roots; a polynomial is fixed by the list of its coefficients up to its degree
  have hpoly : Countable (Polynomial ℚ) := by
    refine Function.Injective.countable
      (f := fun p : Polynomial ℚ => (List.range (p.natDegree + 1)).map p.coeff) ?_
    intro p q hpq
    have hlen := congrArg List.length hpq
    simp only [List.length_map, List.length_range] at hlen
    have hdeg : p.natDegree = q.natDegree := by omega
    ext n
    by_cases hn : n ≤ p.natDegree
    · have h := congrArg (fun l : List ℚ => l[n]?) hpq
      have hn' : n < q.natDegree + 1 := by omega
      have hn'' : n < p.natDegree + 1 := by omega
      simp only [List.getElem?_map, List.getElem?_range hn', List.getElem?_range hn'', Option.map_some,
        Option.some.injEq] at h
      exact h
    · rw [Polynomial.coeff_eq_zero_of_natDegree_lt (by omega), Polynomial.coeff_eq_zero_of_natDegree_lt (by omega)]
  apply Set.Countable.to_subtype
  refine (Set.countable_iUnion fun p : Polynomial ℚ => (p.rootSet_finite ℂ).countable).mono ?_
  intro x hx
  obtain ⟨p, hp0, hpx⟩ := mem_algebraicClosure_iff.1 hx
  exact Set.mem_iUnion.2 ⟨p, Polynomial.mem_rootSet.2 ⟨hp0, hpx⟩⟩

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
    IsPlaneSystem P shiftLab turnLab where
  prob := h.prob
  shift_mp z := ⟨measurable_shiftLab z, h.shift z⟩
  turn_mp u := ⟨measurable_turnLab u, h.turn u⟩
  shift_zero ω := funext fun x => by simp only [shiftLab, add_zero]
  shift_add a b ω := funext fun x => by simp only [shiftLab, add_assoc]
  turn_one ω := funext fun x => by simp only [turnLab, kCoeff_one', one_mul]
  turn_mul u v ω := funext fun x => by simp only [turnLab, kCoeff_mul']; congr 1; ring
  cov u z ω := funext fun x => by simp only [shiftLab, turnLab, mul_add]

/-- **A model of the laws**: the point mass at the empty set is an invariant random independent set of every
graph (of density `0`; a law of positive density is `exists_isInvariantLaw`). -/
theorem isInvariantLaw_dirac (G : SimpleGraph E) : IsInvariantLaw G (Measure.dirac fun _ => false) where
  prob := inferInstance
  indep := by
    -- the point mass sees single points only where they are measurable: `E` is countable
    haveI := countable_algPlane
    rw [ae_dirac_eq, eventually_pure]
    intro x hx
    exact absurd hx (by simp)
  shift z := by rw [Measure.map_dirac' (measurable_shiftLab z)]; rfl
  turn u := by rw [Measure.map_dirac' (measurable_turnLab u)]; rfl

end HadwigerNelson.OneClass

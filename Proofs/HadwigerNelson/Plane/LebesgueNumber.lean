import Proofs.HadwigerNelson.Outside.OAI158Collapse
import Proofs.HadwigerNelson.Plane.FalconerReduction
import Proofs.HadwigerNelson.Plane.WeakColouringOn
import Proofs.HadwigerNelson.Plane.DensityPoints
import Mathlib.Combinatorics.Compactness

/-!
# The chromatic number of the plane is its Lebesgue-measurable chromatic number (FS-131, claims NF3)

**Whose mathematics this is.** None of it is this project's beyond the composing. The module formalizes a printed
lemma, joins it to a density-point step this library already held, and composes the result with a declared outside
theorem:

* **`[Davies2026]` Lemma B.1, p. 44** (J. Davies, *Measurable obstructions for unmeasurable colourings*,
  arXiv:2610.12301v1; the paper says of the lemma "We suspect that this is a folklore result, but have not found it in
  the literature"): "Suppose that A₁, …, A_k ⊆ ℝ^d are measurable D-avoiding sets whose union is conull. Then ℝ^d admits a
  measurable proper k-colouring of its D-distance graph." **Formalized here with its printed proof**, in the reach of
  that proof: `exists_proper_ae_eq_of_proper_on_conull` (the sentence that introduces the lemma: a Lebesgue-measurable
  colouring proper on a conull set can be changed on a null set to one proper everywhere),
  `exists_proper_nullMeasurable_of_avoiding_cover` (the lemma's own form, sets), both for any relation invariant under
  translations on a finite-dimensional real normed space with a Haar measure; `davies_lemma_B1_euclidean` (the printed
  statement: `ℝ^d`, distances in a set `D`) and `Plane.davies_lemma_B1` (the plane, the unit distance).
* **The density-point step** — two density-one points of one colour class of a weak colouring are never at distance
  `1`: the density-point argument of `[DeCorteOliveiraVallentin2022]` (proof of Lemma 5.6, there for the density
  points of a support on a compact group), which `[Davies2026]` p. 46 follows in `ℝ^d`; this library holds it as
  `Plane.AeColouring.dist_ne_one` (FS111-V0-ID1), and a second time as the ported
  `Outside.OAI158.weak_density_proper` (`[OAIMath2026]`). Used here in `Plane.AeColouring.core_dist_ne_one`.
* **The declared outside theorem** `Outside.OAI158.proper_to_borel_weak` (`[OAIMath2026]` family 158): a proper
  `k`-colouring of the plane gives a Borel one proper at almost every unit pair. Only the last section rests on it.

**The statements.** `Plane.chiLebesgue` is the **Lebesgue**-measurable chromatic number of the plane — the paper's
`χ^(m)(ℝ²)` (its p. 2: "Requiring the colour classes to be Lebesgue measurable gives the measurable chromatic number"),
Falconer's number: the least `k` with a colouring `ℂ → Fin k` whose classes are Lebesgue measurable
(`nullMeasurable_iff_forall_fibre`) and which is proper at **every** unit pair. Then

* `Plane.chiM0_eq_chiLebesgue` — `χ_m⁰(ℝ²) = χ_m(ℝ²)`: the almost-everywhere number equals the Lebesgue-measurable
  number. On the standard three axioms; no outside theorem.
* `Plane.chromaticNumber_plane_eq_chiLebesgue` — `χ(ℝ²) = χ_m(ℝ²)`. On the standard three axioms and the one declared
  outside theorem `Outside.OAI158.proper_to_borel_weak`.

**What is not said.** Nothing about Borel colourings: `Plane.chiM` (`Plane/FalconerReduction`) asks a **Borel** map
proper at every unit pair — row 130's `χ_B` — and all that is proved about it here is `chiLebesgue ≤ chiM`. The lemma's
colouring is Lebesgue measurable and no more: its null set is coloured by a compactness argument (`Finset.rado_selection`,
which Mathlib proves from Tychonoff's theorem). No value of any of these numbers is claimed here. The weak-to-proper
step is stated for the plane and the unit distance only: in other dimensions the lemma is here and the density-point
step is not.

**Read aloud.** Take any way of colouring the points of the plane with `k` colours such that no two points one unit
apart share a colour. Then there is such a colouring, with the same number of colours, each of whose colour classes is
a Lebesgue-measurable set — given the outside theorem; and, with no outside theorem, a Lebesgue-measurable colouring that
breaks the rule only on a null set of pairs can be corrected on a null set of points to one that never breaks it.
-/

open MeasureTheory Set Filter Topology Metric

namespace HadwigerNelson

/-! ## Density one, in any finite dimension -/

section DensityOne

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [FiniteDimensional ℝ E]
  [MeasurableSpace E] [BorelSpace E] {μ : Measure E}

/-- `s` has Lebesgue density one at `x`: "the proportion of the set in shrinking balls centred there tends to one"
(`[Davies2026]` p. 44). Closed balls, as in `Besicovitch.ae_tendsto_measure_inter_div`; `Plane.densitySet A` is
`{x | HasDensityOneAt volume A x}` (`Plane.mem_densitySet_iff_hasDensityOneAt`). -/
def HasDensityOneAt {X : Type*} [PseudoMetricSpace X] [MeasurableSpace X] (μ : Measure X) (s : Set X) (x : X) : Prop :=
  Tendsto (fun r : ℝ => μ (s ∩ closedBall x r) / μ (closedBall x r)) (𝓝[>] 0) (𝓝 1)

omit [BorelSpace E] in
/-- The whole space has density one everywhere. -/
theorem hasDensityOneAt_univ [μ.IsAddHaarMeasure] (x : E) : HasDensityOneAt μ univ x := by
  refine tendsto_const_nhds.congr' ?_
  filter_upwards [self_mem_nhdsWithin] with r hr
  rw [univ_inter]
  exact (ENNReal.div_self (measure_closedBall_pos μ x hr).ne' measure_closedBall_lt_top.ne).symm

omit [NormedSpace ℝ E] [FiniteDimensional ℝ E] [BorelSpace E] in
/-- Sets equal almost everywhere have density one at the same points. -/
theorem hasDensityOneAt_congr_ae {s t : Set E} (h : s =ᵐ[μ] t) (x : E) :
    HasDensityOneAt μ s x ↔ HasDensityOneAt μ t x := by
  have hr : ∀ r : ℝ, μ (s ∩ closedBall x r) = μ (t ∩ closedBall x r) := fun r =>
    measure_congr (h.inter (ae_eq_refl _))
  simp only [HasDensityOneAt, hr]

/-- **Two sets of density one at a point meet in a set of density one there** (one of them Lebesgue measurable): the
parts of a small ball missed by each are small, so the part missed by both is. -/
theorem HasDensityOneAt.inter [μ.IsAddHaarMeasure] {s t : Set E} {x : E} (ht : NullMeasurableSet t μ)
    (hs : HasDensityOneAt μ s x) (ht1 : HasDensityOneAt μ t x) : HasDensityOneAt μ (s ∩ t) x := by
  have hlow : Tendsto (fun r : ℝ => μ (s ∩ closedBall x r) / μ (closedBall x r) +
      μ (t ∩ closedBall x r) / μ (closedBall x r) - 1) (𝓝[>] 0) (𝓝 1) := by
    have h := ENNReal.Tendsto.sub (hs.add ht1) (tendsto_const_nhds (x := (1 : ENNReal)))
      (Or.inr ENNReal.one_ne_top)
    rwa [ENNReal.add_sub_cancel_right ENNReal.one_ne_top] at h
  refine tendsto_of_tendsto_of_tendsto_of_le_of_le' hlow tendsto_const_nhds ?_ ?_
  · filter_upwards [self_mem_nhdsWithin] with r hr
    have hB0 : μ (closedBall x r) ≠ 0 := (measure_closedBall_pos μ x hr).ne'
    have hBt : μ (closedBall x r) ≠ ⊤ := measure_closedBall_lt_top.ne
    have hm : NullMeasurableSet (t ∩ closedBall x r) μ := ht.inter measurableSet_closedBall.nullMeasurableSet
    have key : μ (s ∩ closedBall x r) + μ (t ∩ closedBall x r) ≤ μ (s ∩ t ∩ closedBall x r) + μ (closedBall x r) :=
      calc μ (s ∩ closedBall x r) + μ (t ∩ closedBall x r)
          = μ (s ∩ closedBall x r ∪ t ∩ closedBall x r) + μ (s ∩ closedBall x r ∩ (t ∩ closedBall x r)) :=
            (measure_union_add_inter₀ (s ∩ closedBall x r) hm).symm
        _ ≤ μ (closedBall x r) + μ (s ∩ t ∩ closedBall x r) :=
            add_le_add (measure_mono (union_subset inter_subset_right inter_subset_right))
              (measure_mono fun z hz => ⟨⟨hz.1.1, hz.2.1⟩, hz.1.2⟩)
        _ = μ (s ∩ t ∩ closedBall x r) + μ (closedBall x r) := add_comm _ _
    rw [tsub_le_iff_right]
    calc μ (s ∩ closedBall x r) / μ (closedBall x r) + μ (t ∩ closedBall x r) / μ (closedBall x r)
        = (μ (s ∩ closedBall x r) + μ (t ∩ closedBall x r)) / μ (closedBall x r) := ENNReal.add_div.symm
      _ ≤ (μ (s ∩ t ∩ closedBall x r) + μ (closedBall x r)) / μ (closedBall x r) := ENNReal.div_le_div_right key _
      _ = μ (s ∩ t ∩ closedBall x r) / μ (closedBall x r) + 1 := by rw [ENNReal.add_div, ENNReal.div_self hB0 hBt]
  · filter_upwards [self_mem_nhdsWithin] with r hr
    exact ENNReal.div_le_of_le_mul (by rw [one_mul]; exact measure_mono inter_subset_right)

omit [NormedSpace ℝ E] [FiniteDimensional ℝ E] in
/-- Density one is carried by translations: `s − u` has density one at `x` exactly when `s` has it at `x + u`. -/
theorem hasDensityOneAt_preimage_add_right [μ.IsAddHaarMeasure] {s : Set E} {x u : E} :
    HasDensityOneAt μ ((fun z => z + u) ⁻¹' s) x ↔ HasDensityOneAt μ s (x + u) := by
  have he (r : ℝ) : (fun z : E => z + u) ⁻¹' (closedBall (x + u) r) = closedBall x r := by
    ext z
    simp only [mem_preimage, mem_closedBall, dist_eq_norm, add_sub_add_right_eq_sub]
  have h1 (r : ℝ) : μ (((fun z : E => z + u) ⁻¹' s) ∩ closedBall x r) = μ (s ∩ closedBall (x + u) r) := by
    rw [← he, ← preimage_inter, measure_preimage_add_right]
  have h2 (r : ℝ) : μ (closedBall x r) = μ (closedBall (x + u) r) := by
    rw [← he, measure_preimage_add_right]
  simp only [HasDensityOneAt, h1, h2]

omit [NormedSpace ℝ E] [FiniteDimensional ℝ E] [BorelSpace E] in
/-- A set of density one at a point is not empty. -/
theorem HasDensityOneAt.nonempty {s : Set E} {x : E} (hs : HasDensityOneAt μ s x) : s.Nonempty := by
  by_contra h
  rw [not_nonempty_iff_eq_empty] at h
  have h0 : Tendsto (fun r : ℝ => μ (s ∩ closedBall x r) / μ (closedBall x r)) (𝓝[>] 0) (𝓝 0) := by
    simp [h]
  exact zero_ne_one (tendsto_nhds_unique h0 hs)

/-- **The Lebesgue density theorem, for a map with finitely many values**: almost every point is a density-one point
of its own fibre. No measurability is asked (`Besicovitch.ae_tendsto_measure_inter_div` holds for every set). -/
theorem ae_hasDensityOneAt_fibre (μ : Measure E) [μ.IsAddHaarMeasure] {k : ℕ} (c : E → Fin k) :
    ∀ᵐ x ∂μ, HasDensityOneAt μ (c ⁻¹' {c x}) x := by
  have h : ∀ i : Fin k, ∀ᵐ x ∂μ, x ∈ c ⁻¹' {i} → HasDensityOneAt μ (c ⁻¹' {i}) x := fun i =>
    ae_imp_of_ae_restrict (Besicovitch.ae_tendsto_measure_inter_div μ (c ⁻¹' {i}))
  filter_upwards [ae_all_iff.2 h] with x hx
  exact hx (c x) rfl

/-- **Step 3 of the printed proof** (`[Davies2026]` p. 44: "For finite F ⊆ ℝ^d, the intersection
⋂_{x∈F∩A} (A_{c(x)} − x) ∩ ⋂_{x∈F∖A} (A − x) has positive measure near 0: the first part has density one there and the
second is conull"): finitely many Lebesgue-measurable sets, `V x` of density one at `x` for each `x` of a finite `F`,
are met by one translation — some `ξ` has `x + ξ ∈ V x` for every `x ∈ F`. (The sets `V x − x` have density one at `0`,
and so has their intersection, `HasDensityOneAt.inter`.)

Inhabitant of the hypotheses: `V x = univ` (`hasDensityOneAt_univ`); the theorem's use, in
`exists_proper_ae_eq_of_proper_on_conull`, is at `V x` the colour class of `x` cut to a conull set. -/
theorem exists_translate_mem [μ.IsAddHaarMeasure] {V : E → Set E} (F : Finset E)
    (hVm : ∀ x ∈ F, NullMeasurableSet (V x) μ) (hV1 : ∀ x ∈ F, HasDensityOneAt μ (V x) x) :
    ∃ ξ : E, ∀ x ∈ F, x + ξ ∈ V x := by
  classical
  -- `W x`: the translations that carry `x` into `V x`
  let W : E → Set E := fun x => (fun ξ : E => ξ + x) ⁻¹' V x
  have hWm : ∀ x ∈ F, NullMeasurableSet (W x) μ := fun x hx =>
    (hVm x hx).preimage (measurePreserving_add_right μ x).quasiMeasurePreserving
  have hW1 : ∀ x ∈ F, HasDensityOneAt μ (W x) 0 := fun x hx =>
    hasDensityOneAt_preimage_add_right.2 (by rw [zero_add]; exact hV1 x hx)
  have key : ∀ G : Finset E, G ⊆ F → HasDensityOneAt μ (⋂ x ∈ G, W x) 0 := by
    intro G
    induction G using Finset.induction_on with
    | empty => intro _; simpa using hasDensityOneAt_univ (μ := μ) (0 : E)
    | insert a G _ ih =>
      intro hG
      rw [Finset.set_biInter_insert, inter_comm]
      exact (ih fun y hy => hG (Finset.mem_insert_of_mem hy)).inter (hWm a (hG (Finset.mem_insert_self a G)))
        (hW1 a (hG (Finset.mem_insert_self a G)))
  obtain ⟨ξ, hξ⟩ := (key F subset_rfl).nonempty
  refine ⟨ξ, fun x hx => ?_⟩
  have h : ξ + x ∈ V x := mem_iInter₂.1 hξ x hx
  rwa [add_comm] at h

end DensityOne

/-! ## `[Davies2026]` Lemma B.1, in the reach of its printed proof -/

/-- **Step 1 of the printed proof** ("First make the sets disjoint by replacing A_i by A_i ∖ ⋃_{j<i} A_j"), as a
colouring: Lebesgue-measurable sets `A 0, …, A (k − 1)`, `k ⩾ 1`, have a Lebesgue-measurable selector — a map `c` with
`x ∈ A (c x)` for every `x` of their union (the least index holding `x`). For any measure on any measurable space. -/
theorem exists_nullMeasurable_selector {X : Type*} [MeasurableSpace X] {μ : Measure X} {k : ℕ} (hk : 0 < k)
    {A : Fin k → Set X} (hA : ∀ i, NullMeasurableSet (A i) μ) :
    ∃ c : X → Fin k, NullMeasurable c μ ∧ ∀ x ∈ ⋃ i, A i, x ∈ A (c x) := by
  classical
  -- the indices of the sets holding `x`, and the least of them
  let I : X → Finset (Fin k) := fun x => Finset.univ.filter fun i => x ∈ A i
  let c : X → Fin k := fun x => if h : (I x).Nonempty then (I x).min' h else ⟨0, hk⟩
  have hmem : ∀ x ∈ ⋃ i, A i, x ∈ A (c x) := by
    intro x hx
    obtain ⟨i, hi⟩ := mem_iUnion.1 hx
    have hne : (I x).Nonempty := ⟨i, Finset.mem_filter.2 ⟨Finset.mem_univ i, hi⟩⟩
    have hc : c x = (I x).min' hne := dif_pos hne
    rw [hc]
    exact (Finset.mem_filter.1 (Finset.min'_mem (I x) hne)).2
  refine ⟨c, fun s _ => ?_, hmem⟩
  have hs : c ⁻¹' s = ⋃ j ∈ s, c ⁻¹' {j} := by ext x; simp
  rw [hs]
  refine NullMeasurableSet.biUnion (Set.to_countable s) fun j _ => ?_
  -- the class `j`: in `A j` and in no earlier set; the points of no set go to the class `0`
  have hj : c ⁻¹' {j} = (A j ∩ ⋂ i, ⋂ (_ : i < j), (A i)ᶜ) ∪ ((⋃ i, A i)ᶜ ∩ {_x | j = ⟨0, hk⟩}) := by
    ext x
    have hx_iff : x ∈ c ⁻¹' {j} ↔ c x = j := Iff.rfl
    rw [hx_iff]
    by_cases hne : (I x).Nonempty
    · have hc : c x = (I x).min' hne := dif_pos hne
      have hminA : x ∈ A ((I x).min' hne) := (Finset.mem_filter.1 (Finset.min'_mem (I x) hne)).2
      constructor
      · intro h
        rw [hc] at h
        refine Or.inl ⟨h ▸ hminA, mem_iInter₂.2 fun i hi hxi => ?_⟩
        have hle := Finset.min'_le (I x) i (Finset.mem_filter.2 ⟨Finset.mem_univ i, hxi⟩)
        rw [h] at hle
        exact absurd hi (not_lt.2 hle)
      · rintro (⟨hxj, hlt⟩ | ⟨hnone, -⟩)
        · rw [hc]
          exact le_antisymm (Finset.min'_le (I x) j (Finset.mem_filter.2 ⟨Finset.mem_univ j, hxj⟩))
            (not_lt.1 fun hlt' => (mem_iInter₂.1 hlt _ hlt') hminA)
        · exact absurd (mem_iUnion.2 ⟨_, hminA⟩) hnone
    · have hc : c x = ⟨0, hk⟩ := dif_neg hne
      have hnone : x ∉ ⋃ i, A i := fun hx => by
        obtain ⟨i, hi⟩ := mem_iUnion.1 hx
        exact hne ⟨i, Finset.mem_filter.2 ⟨Finset.mem_univ i, hi⟩⟩
      constructor
      · intro h
        refine Or.inr ⟨hnone, ?_⟩
        show j = ⟨0, hk⟩
        rw [← h, hc]
      · rintro (⟨hxj, -⟩ | ⟨-, hj0⟩)
        · exact absurd (mem_iUnion.2 ⟨j, hxj⟩) hnone
        · rw [hc]; exact hj0.symm
  rw [hj]
  exact ((hA j).inter (NullMeasurableSet.iInter fun i => NullMeasurableSet.iInter fun _ => (hA i).compl)).union
    ((NullMeasurableSet.iUnion hA).compl.inter (MeasurableSet.const _).nullMeasurableSet)

section LemmaB1

variable {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E] [FiniteDimensional ℝ E]
  [MeasurableSpace E] [BorelSpace E]

/-- **`[Davies2026]` Lemma B.1 (p. 44), as the sentence that introduces it** — "a measurable proper colouring of a
conull set can, after changes on a null set, be extended to a measurable proper colouring of ℝ^d" — **formalized with
its printed proof, not imported.** `E` is a finite-dimensional real normed space with a Haar measure `μ` (Lebesgue
measure on `ℝ^d`); `R` is any relation invariant under translations (the paper's: `‖x − y‖ ∈ D`); `c` is a
Lebesgue-measurable `k`-colouring, proper for `R` on a conull set `S`. Then some Lebesgue-measurable `f` equals `c`
almost everywhere and is proper for `R` at **every** pair.

The printed proof never reads the distance set, the dimension or the norm beyond translation invariance, the Lebesgue
density theorem and compactness, and no more is assumed here: `D` need not be finite, `d ⩾ 2` and `k ⩾ 2` are not asked.
The colouring is Lebesgue measurable, not Borel: the null set is coloured by `Finset.rado_selection`.

Inhabitant of the hypotheses: the plane, the unit distance, `c = Plane.sq9Col`, `S = univ` (the `example` after
`Plane.davies_lemma_B1`); with `S ≠ univ`, an `AeColouring` and its density points (`Plane.exists_proper_of_aeColouring`,
at `Plane.r7_aeColouring`). -/
theorem exists_proper_ae_eq_of_proper_on_conull (μ : Measure E) [μ.IsAddHaarMeasure]
    {R : E → E → Prop} (hR : ∀ ξ x y, R x y → R (x + ξ) (y + ξ))
    {k : ℕ} {c : E → Fin k} (hc : NullMeasurable c μ)
    {S : Set E} (hS : μ Sᶜ = 0) (hproper : ∀ x ∈ S, ∀ y ∈ S, R x y → c x ≠ c y) :
    ∃ f : E → Fin k, NullMeasurable f μ ∧ f =ᵐ[μ] c ∧ ∀ x y, R x y → f x ≠ f y := by
  classical
  -- `T`: the points of `S` that are density-one points of their own colour class (the paper's `A`)
  set T : Set E := {x | x ∈ S ∧ HasDensityOneAt μ (c ⁻¹' {c x}) x} with hTdef
  have hT : μ Tᶜ = 0 := by
    rw [measure_eq_zero_iff_ae_notMem]
    filter_upwards [measure_eq_zero_iff_ae_notMem.1 hS, ae_hasDensityOneAt_fibre μ c] with x hx hd hxT
    exact hxT ⟨not_not.1 hx, hd⟩
  have hTu : T =ᵐ[μ] (univ : Set E) := ae_eq_univ.2 hT
  have hTm : NullMeasurableSet T μ := (NullMeasurableSet.of_null hT).of_compl
  -- `V x`: where a translate of `x` has to land — in `T`, and in the colour class of `x` when `x ∈ T`
  let V : E → Set E := fun x => if x ∈ T then T ∩ c ⁻¹' {c x} else T
  have hVm : ∀ x, NullMeasurableSet (V x) μ := fun x => by
    by_cases hx : x ∈ T
    · simp only [V, if_pos hx]; exact hTm.inter (hc (measurableSet_singleton _))
    · simp only [V, if_neg hx]; exact hTm
  have hV1 : ∀ x, HasDensityOneAt μ (V x) x := fun x => by
    by_cases hx : x ∈ T
    · simp only [V, if_pos hx]
      have h : (T ∩ c ⁻¹' {c x} : Set E) =ᵐ[μ] c ⁻¹' {c x} := by
        have h' := hTu.inter (ae_eq_refl (c ⁻¹' {c x}))
        rwa [univ_inter] at h'
      exact (hasDensityOneAt_congr_ae h x).2 hx.2
    · simp only [V, if_neg hx]
      exact (hasDensityOneAt_congr_ae hTu x).2 (hasDensityOneAt_univ x)
  -- step 3: every finite set is carried into `T` by a translation that keeps the colours of its points of `T`
  choose ξ hξ using fun F : Finset E => exists_translate_mem F (fun x _ => hVm x) fun x _ => hV1 x
  have hξT : ∀ (F : Finset E), ∀ x ∈ F, x + ξ F ∈ T := fun F x hx => by
    have h := hξ F x hx
    by_cases hxT : x ∈ T
    · simp only [V, if_pos hxT] at h; exact h.1
    · simp only [V, if_neg hxT] at h; exact h
  have hξc : ∀ (F : Finset E), ∀ x ∈ F, x ∈ T → c (x + ξ F) = c x := fun F x hx hxT => by
    have h := hξ F x hx
    simp only [V, if_pos hxT] at h
    exact h.2
  -- step 5: compactness
  obtain ⟨χ, hχ⟩ := Finset.rado_selection (β := fun _ : E => Fin k) fun F x => c (x + ξ F)
  have hχT : ∀ x ∈ T, χ x = c x := by
    intro x hx
    obtain ⟨t, hst, ht⟩ := hχ {x}
    rw [ht x (Finset.mem_singleton_self x)]
    exact hξc t x (hst (Finset.mem_singleton_self x)) hx
  have hae : χ =ᵐ[μ] c := by
    filter_upwards [measure_eq_zero_iff_ae_notMem.1 hT] with x hx
    exact hχT x (not_not.1 hx)
  refine ⟨χ, hc.congr hae.symm, hae, fun x y hxy => ?_⟩
  obtain ⟨t, hst, ht⟩ := hχ {x, y}
  have hx : x ∈ t := hst (Finset.mem_insert_self x {y})
  have hy : y ∈ t := hst (Finset.mem_insert_of_mem (Finset.mem_singleton_self y))
  rw [ht x (Finset.mem_insert_self x {y}), ht y (Finset.mem_insert_of_mem (Finset.mem_singleton_self y))]
  exact hproper _ (hξT t x hx).1 _ (hξT t y hy).1 (hR (ξ t) x y hxy)

/-- **`[Davies2026]` Lemma B.1 (p. 44), in its own form** — "Suppose that A₁, …, A_k ⊆ ℝ^d are measurable D-avoiding sets
whose union is conull. Then ℝ^d admits a measurable proper k-colouring of its D-distance graph" — **formalized, not
imported**, for any relation `R` invariant under translations in place of "at a distance in `D`", on any
finite-dimensional real normed space with a Haar measure. "Measurable" is Lebesgue measurable on both sides
(`NullMeasurableSet`, `NullMeasurable`); the colouring puts almost every point in a set of its own colour.

Inhabitant of the hypotheses: the nine classes of `Plane.sq9Col` (the `example` after `Plane.davies_lemma_B1`). -/
theorem exists_proper_nullMeasurable_of_avoiding_cover (μ : Measure E) [μ.IsAddHaarMeasure]
    {R : E → E → Prop} (hR : ∀ ξ x y, R x y → R (x + ξ) (y + ξ))
    {k : ℕ} {A : Fin k → Set E} (hA : ∀ i, NullMeasurableSet (A i) μ)
    (havoid : ∀ i, ∀ x ∈ A i, ∀ y ∈ A i, ¬ R x y) (hcov : μ (⋃ i, A i)ᶜ = 0) :
    ∃ f : E → Fin k, NullMeasurable f μ ∧ (∀ᵐ x ∂μ, x ∈ A (f x)) ∧ ∀ x y, R x y → f x ≠ f y := by
  have hk : 0 < k := by
    rcases Nat.eq_zero_or_pos k with rfl | hk
    · exfalso
      have hempty : (⋃ i : Fin 0, A i) = ∅ := iUnion_of_empty A
      rw [hempty, compl_empty] at hcov
      exact (isOpen_univ.measure_pos μ univ_nonempty).ne' hcov
    · exact hk
  obtain ⟨c, hc, hcA⟩ := exists_nullMeasurable_selector hk hA
  obtain ⟨f, hf, hfc, hproper⟩ := exists_proper_ae_eq_of_proper_on_conull μ hR hc hcov
    fun x hx y hy hxy hcxy => havoid (c x) x (hcA x hx) y (hcxy ▸ hcA y hy) hxy
  refine ⟨f, hf, ?_, hproper⟩
  filter_upwards [hfc, measure_eq_zero_iff_ae_notMem.1 hcov] with x hx hxS
  rw [hx]
  exact hcA x (not_not.1 hxS)

/-- **`[Davies2026]` Lemma B.1 as printed**: Lebesgue-measurable sets `A₁, …, A_k ⊆ ℝ^d`, none holding two points at a
distance in `D`, with conull union, give a Lebesgue-measurable `k`-colouring of `ℝ^d` proper at every pair at a
distance in `D`. The paper's standing hypotheses — `D ⊆ (0, ∞)` finite and nonempty, `d ⩾ 2`, `k ⩾ 2` — are not used by
its proof and are not asked: `D` is any set of reals. -/
theorem davies_lemma_B1_euclidean {d : ℕ} (D : Set ℝ) {k : ℕ} {A : Fin k → Set (EuclideanSpace ℝ (Fin d))}
    (hA : ∀ i, NullMeasurableSet (A i) volume) (havoid : ∀ i, ∀ x ∈ A i, ∀ y ∈ A i, dist x y ∉ D)
    (hcov : volume (⋃ i, A i)ᶜ = 0) :
    ∃ f : EuclideanSpace ℝ (Fin d) → Fin k, NullMeasurable f volume ∧ (∀ᵐ x, x ∈ A (f x)) ∧
      ∀ x y, dist x y ∈ D → f x ≠ f y :=
  exists_proper_nullMeasurable_of_avoiding_cover volume (R := fun x y => dist x y ∈ D)
    (fun ξ x y h => by simpa using h) hA havoid hcov

end LemmaB1

namespace Plane

open HadwigerNelson

variable {k : ℕ}

/-! ## The plane and the unit distance -/

/-- The library's density set is the set of density-one points. -/
theorem mem_densitySet_iff_hasDensityOneAt {A : Set ℂ} {x : ℂ} :
    x ∈ densitySet A ↔ HasDensityOneAt volume A x := Iff.rfl

/-- **`[Davies2026]` Lemma B.1 for the plane and the unit distance** (`d = 2`, `D = {1}`): Lebesgue-measurable sets
`A 0, …, A (k − 1) ⊆ ℂ`, none holding two points at distance `1`, with conull union, give a Lebesgue-measurable
`k`-colouring of the plane proper at every unit pair, which puts almost every point in a set of its own colour.
Formalized (`exists_proper_nullMeasurable_of_avoiding_cover`), not imported. -/
theorem davies_lemma_B1 {A : Fin k → Set ℂ} (hA : ∀ i, NullMeasurableSet (A i) volume)
    (havoid : ∀ i, ∀ x ∈ A i, ∀ y ∈ A i, dist x y ≠ 1) (hcov : volume (⋃ i, A i)ᶜ = 0) :
    ∃ f : ℂ → Fin k, NullMeasurable f volume ∧ (∀ᵐ x, x ∈ A (f x)) ∧ ∀ x y, dist x y = 1 → f x ≠ f y :=
  exists_proper_nullMeasurable_of_avoiding_cover volume (R := fun x y => dist x y = 1)
    (fun ξ x y h => by simpa using h) hA havoid hcov

/-- **Model of the lemma's hypotheses** (both forms): the nine classes of the half-unit-square colouring `sq9Col` are
measurable, hold no unit pair, and cover the plane. -/
example : ∃ f : ℂ → Fin 9, NullMeasurable f volume ∧ (∀ᵐ x, x ∈ sq9Col ⁻¹' {f x}) ∧
    ∀ x y, dist x y = 1 → f x ≠ f y :=
  davies_lemma_B1 (A := fun j => sq9Col ⁻¹' {j})
    (fun j => (measurable_sq9Col (measurableSet_singleton j)).nullMeasurableSet)
    (fun j x hx y hy h => sq9Col_ne_of_dist_eq_one h (hx.trans hy.symm))
    (by
      have : (⋃ j, sq9Col ⁻¹' {j}) = univ := by ext x; simp
      rw [this, compl_univ, measure_empty])

/-! ## The density-point step: a weak colouring gives classes with no unit pair -/

/-- The points of colour `j` that are density-one points of the colour class `j` — the paper's `A_j` after "Discard the
other points of each A_i". -/
def AeColouring.core (a : AeColouring k) (j : Fin k) : Set ℂ := a.col ⁻¹' {j} ∩ densitySet (a.col ⁻¹' {j})

/-- The cores are measurable. -/
theorem AeColouring.measurableSet_core (a : AeColouring k) (j : Fin k) : MeasurableSet (a.core j) :=
  (a.measurable (measurableSet_singleton j)).inter (measurableSet_densitySet (a.measurable (measurableSet_singleton j)))

/-- **The density-point step** (the argument of `[DeCorteOliveiraVallentin2022]`, proof of Lemma 5.6, as
`[Davies2026]` p. 46 follows it; here `AeColouring.dist_ne_one`, FS111-V0-ID1): no two points of one core are at
distance `1` — every pair, where the colouring itself was proper only at almost every pair. -/
theorem AeColouring.core_dist_ne_one (a : AeColouring k) (j : Fin k) {x y : ℂ} (hx : x ∈ a.core j)
    (hy : y ∈ a.core j) : dist x y ≠ 1 :=
  a.dist_ne_one j hy.2 (upperDensityAt_pos_of_mem_densitySet hx.2)

/-- The cores cover the plane up to a null set (the Lebesgue density theorem, `volume_diff_densitySet`). -/
theorem AeColouring.volume_compl_iUnion_core (a : AeColouring k) : volume (⋃ j, a.core j)ᶜ = 0 := by
  refine measure_mono_null (t := ⋃ j, a.col ⁻¹' {j} \ densitySet (a.col ⁻¹' {j})) (fun x hx => ?_)
    (measure_iUnion_null fun j => volume_diff_densitySet (a.measurable (measurableSet_singleton j)))
  refine mem_iUnion.2 ⟨a.col x, rfl, fun hd => hx (mem_iUnion.2 ⟨a.col x, rfl, hd⟩)⟩

/-- The colouring has colour `j` on the core `j`: the cores are pairwise disjoint. -/
theorem AeColouring.col_eq_of_mem_core (a : AeColouring k) {j : Fin k} {x : ℂ} (hx : x ∈ a.core j) : a.col x = j :=
  hx.1

/-! ## From proper at almost every unit pair to proper at every unit pair -/

/-- **A weak colouring agrees almost everywhere with a Lebesgue-measurable colouring proper at every unit pair**
(claim NF3-WEAK-TO-PROPER; `[Davies2026]` Lemma B.1 with the density-point step, composed). Inhabitant of the
hypothesis: `r7_aeColouring` (seven colours); none exists with five colours given the declared outside theorem
`Outside.OAI158.no_proper_five_coloring` (`Outside.OAI158.six_le_chiM0`), and whether one exists with six is the
Hadwiger–Nelson problem given that theorem and `Outside.OAI158.proper_to_borel_weak`
(`Outside.OAI158.colorable_iff_nonempty_aeColouring`). The theorem itself is on the standard three axioms. -/
theorem exists_proper_of_aeColouring (a : AeColouring k) :
    ∃ f : ℂ → Fin k, NullMeasurable f volume ∧ f =ᵐ[volume] a.col ∧ ∀ x y, dist x y = 1 → f x ≠ f y := by
  refine exists_proper_ae_eq_of_proper_on_conull volume (R := fun x y => dist x y = 1)
    (fun ξ x y h => by simpa using h) a.measurable.nullMeasurable a.volume_compl_iUnion_core ?_
  intro x hx y hy hxy hc
  obtain ⟨i, hi⟩ := mem_iUnion.1 hx
  obtain ⟨j, hj⟩ := mem_iUnion.1 hy
  have hij : i = j := by rw [← a.col_eq_of_mem_core hi, ← a.col_eq_of_mem_core hj, hc]
  subst hij
  exact a.core_dist_ne_one i hi hj hxy

/-- **The step run on a colouring that is not proper**: the library's seven-colouring `r7Col` is proper at almost
every unit pair (`r7_aeColouring`); a Lebesgue-measurable colouring proper at every unit pair agrees with it almost
everywhere. -/
example : ∃ f : ℂ → Fin 7, NullMeasurable f volume ∧ f =ᵐ[volume] r7Col ∧ ∀ x y, dist x y = 1 → f x ≠ f y := by
  obtain ⟨a, ha⟩ := r7_aeColouring
  rw [← ha]
  exact exists_proper_of_aeColouring a

/-- **The same for a Lebesgue-measurable weak colouring**: a `c : ℂ → Fin k` with Lebesgue-measurable classes, each
with null unit pairs (proper at almost every unit pair), agrees almost everywhere with a Lebesgue-measurable colouring
proper at every unit pair. Inhabitant of the hypotheses: the colouring of `r7_aeColouring`. -/
theorem exists_proper_of_nullMeasurable_weak {c : ℂ → Fin k} (hc : NullMeasurable c volume)
    (hnull : ∀ j, UnitPairsNull (c ⁻¹' {j})) :
    ∃ f : ℂ → Fin k, NullMeasurable f volume ∧ f =ᵐ[volume] c ∧ ∀ x y, dist x y = 1 → f x ≠ f y := by
  have hae : AEMeasurable c volume := hc.aemeasurable
  have hcg : c =ᵐ[volume] hae.mk c := hae.ae_eq_mk
  have hfib : ∀ j, (c ⁻¹' {j} : Set ℂ) =ᵐ[volume] hae.mk c ⁻¹' {j} := fun j => by
    filter_upwards [hcg] with x hx
    show (c x ∈ ({j} : Set (Fin k))) = (hae.mk c x ∈ ({j} : Set (Fin k)))
    rw [hx]
  obtain ⟨f, hf, hfg, hproper⟩ :=
    exists_proper_of_aeColouring ⟨hae.mk c, hae.measurable_mk, fun j => (hnull j).congr_ae (hfib j)⟩
  exact ⟨f, hf, hfg.trans hcg.symm, hproper⟩

/-- **Conversely**: a Lebesgue-measurable colouring proper at every unit pair agrees almost everywhere with a Borel
colouring proper at almost every unit pair — an `AeColouring`. Inhabitant of the hypotheses: `sq9Col`. -/
theorem exists_aeColouring_of_nullMeasurable_proper {f : ℂ → Fin k} (hf : NullMeasurable f volume)
    (hproper : ∀ x y, dist x y = 1 → f x ≠ f y) : ∃ a : AeColouring k, a.col =ᵐ[volume] f := by
  have hae : AEMeasurable f volume := hf.aemeasurable
  have hfg : f =ᵐ[volume] hae.mk f := hae.ae_eq_mk
  have hN : volume {x | ¬ f x = hae.mk f x} = 0 := ae_iff.mp hfg
  have hp : AeProperOn univ (hae.mk f) := aeProperOn_of_proper_off_null hN fun x _ y _ hxy hx hy => by
    rw [← not_not.1 hx, ← not_not.1 hy]
    exact hproper x y hxy
  exact ⟨⟨hae.mk f, hae.measurable_mk, (isWeakColouringOn_univ_iff.mp ⟨hae.measurable_mk, hp⟩).2⟩, hfg.symm⟩

/-! ## The Lebesgue-measurable chromatic number -/

/-- **`χ_m(ℝ²)`, the Lebesgue-measurable chromatic number of the plane** — Falconer's number, `[Davies2026]`'s
`χ^(m)(ℝ²)` (p. 2): the least `k` with a `k`-colouring of the plane that is Lebesgue measurable (`NullMeasurable`: each
colour class is a Lebesgue-measurable set, `nullMeasurable_iff_forall_fibre`) and proper at **every** unit pair; `⊤` if
there is none. Not `Plane.chiM`, which asks a Borel colouring (`chiLebesgue_le_chiM`). -/
noncomputable def chiLebesgue : ℕ∞ :=
  ⨅ (k : ℕ) (_ : ∃ f : ℂ → Fin k, NullMeasurable f volume ∧ ∀ x y, dist x y = 1 → f x ≠ f y), (k : ℕ∞)

/-- **The definition's measurability clause, in the paper's words**: a colouring with finitely many colours is
Lebesgue measurable exactly when each of its colour classes is a Lebesgue-measurable set. -/
theorem nullMeasurable_iff_forall_fibre {f : ℂ → Fin k} :
    NullMeasurable f (volume : Measure ℂ) ↔ ∀ j, NullMeasurableSet (f ⁻¹' {j}) volume := by
  refine ⟨fun hf j => hf (measurableSet_singleton j), fun h s _ => ?_⟩
  have hs : f ⁻¹' s = ⋃ j ∈ s, f ⁻¹' {j} := by ext x; simp
  rw [hs]
  exact NullMeasurableSet.biUnion (Set.to_countable s) fun j _ => h j

/-- Any Lebesgue-measurable colouring proper at every unit pair bounds `χ_m(ℝ²)`. -/
theorem chiLebesgue_le {f : ℂ → Fin k} (hf : NullMeasurable f volume) (hproper : ∀ x y, dist x y = 1 → f x ≠ f y) :
    chiLebesgue ≤ k := iInf₂_le k ⟨f, hf, hproper⟩

/-- **The Lebesgue number is at most the Borel number**: a Borel colouring is Lebesgue measurable. Nothing is claimed
in the other direction. -/
theorem chiLebesgue_le_chiM : chiLebesgue ≤ chiM :=
  le_iInf₂ fun _ ⟨_, hf, hproper⟩ => chiLebesgue_le hf.nullMeasurable hproper

/-- Spec: nine colours suffice (`sq9Col`), so the infimum is not over an empty family. -/
example : chiLebesgue ≤ 9 := chiLebesgue_le measurable_sq9Col.nullMeasurable fun _ _ h => sq9Col_ne_of_dist_eq_one h

/-- **`χ(ℝ²) ≤ χ_m(ℝ²)`**: a Lebesgue-measurable proper colouring is a proper colouring. No outside theorem. -/
theorem chromaticNumber_plane_le_chiLebesgue : (unitDistance ℂ).chromaticNumber ≤ chiLebesgue :=
  le_iInf₂ fun _ ⟨f, _, hproper⟩ => SimpleGraph.chromaticNumber_le_iff_colorable.mpr
    ⟨SimpleGraph.Coloring.mk f fun {x y} hxy => hproper x y (unitDistance_adj.mp hxy)⟩

/-- Spec: `5 ≤ χ_m(ℝ²)` with no outside theorem (rung B), so the definition is not trivially small. -/
example : 5 ≤ chiLebesgue := by
  have h := chromaticNumber_plane_interval.1
  rw [chromaticNumber_plane_eq_complex] at h
  exact h.trans chromaticNumber_plane_le_chiLebesgue

/-- `χ_m⁰(ℝ²) ≤ χ_m(ℝ²)`: proper at every unit pair is proper at almost every one, after a null change to a Borel map. -/
theorem chiM0_le_chiLebesgue : chiM0 ≤ chiLebesgue :=
  le_iInf₂ fun _ ⟨_, hf, hproper⟩ =>
    (exists_aeColouring_of_nullMeasurable_proper hf hproper).elim fun a _ => chiM0_le a

/-- `χ_m(ℝ²) ≤ χ_m⁰(ℝ²)`: `exists_proper_of_aeColouring`. -/
theorem chiLebesgue_le_chiM0 : chiLebesgue ≤ chiM0 :=
  le_iInf₂ fun _ ⟨a⟩ =>
    (exists_proper_of_aeColouring a).elim fun _ h => chiLebesgue_le h.1 h.2.2

/-- **Colour by colour**: the plane has a Borel `k`-colouring proper at almost every unit pair exactly when it has a
Lebesgue-measurable `k`-colouring proper at every unit pair. Both sides hold at `k = 7` (`r7_aeColouring`). On the
standard three axioms. -/
theorem nonempty_aeColouring_iff_exists_nullMeasurable_proper :
    Nonempty (AeColouring k) ↔ ∃ f : ℂ → Fin k, NullMeasurable f volume ∧ ∀ x y, dist x y = 1 → f x ≠ f y :=
  ⟨fun ⟨a⟩ => (exists_proper_of_aeColouring a).elim fun f h => ⟨f, h.1, h.2.2⟩,
   fun ⟨_, hf, hproper⟩ => (exists_aeColouring_of_nullMeasurable_proper hf hproper).elim fun a _ => ⟨a⟩⟩

/-- **`χ_m⁰(ℝ²) = χ_m(ℝ²)`** (claim NF3-WEAK-TO-PROPER): the least number of colours in a measurable colouring of the
plane proper at almost every unit pair is the least number in a Lebesgue-measurable colouring proper at every unit
pair. `[Davies2026]` Lemma B.1 (formalized above) with the density-point step this library held; the composition is a
reader's (`plans/FS131-ER1-davies-reading.md` § M). On the standard three axioms: no outside theorem. -/
theorem chiM0_eq_chiLebesgue : chiM0 = chiLebesgue := le_antisymm chiM0_le_chiLebesgue chiLebesgue_le_chiM0

/-! ## On the declared outside theorem `Outside.OAI158.proper_to_borel_weak` -/

/-- **Colour by colour, on the outside theorem**: the plane has a `k`-colouring proper at every unit pair exactly when
it has a Lebesgue-measurable one. From a proper colouring: `Outside.OAI158.proper_to_borel_weak` (`[OAIMath2026]`), then
`exists_proper_of_aeColouring` (`[Davies2026]` Lemma B.1). Rests on the standard three axioms and that one declared
outside theorem. Both sides hold at `k = 7` and, given `Outside.OAI158.no_proper_five_coloring`, fail at `k = 5`. -/
theorem colorable_iff_exists_nullMeasurable_proper :
    (unitDistance ℂ).Colorable k ↔ ∃ f : ℂ → Fin k, NullMeasurable f volume ∧ ∀ x y, dist x y = 1 → f x ≠ f y :=
  Outside.OAI158.colorable_iff_nonempty_aeColouring.trans nonempty_aeColouring_iff_exists_nullMeasurable_proper

/-- **`χ(ℝ²) = χ_m(ℝ²)`: the chromatic number of the plane is its Lebesgue-measurable chromatic number** (claim
NF3-PLANE). A composition of two outside results, neither of which states it as far as each was read:
`Outside.OAI158.chromaticNumber_plane_eq_chiM0` — `[OAIMath2026]`'s transfer, a declared outside theorem — and
`chiM0_eq_chiLebesgue` — `[Davies2026]` Lemma B.1, formalized in this module. Rests on the standard three axioms and the
one declared outside theorem `Outside.OAI158.proper_to_borel_weak`. It says nothing of Borel colourings and gives no
value. -/
theorem chromaticNumber_plane_eq_chiLebesgue : (unitDistance ℂ).chromaticNumber = chiLebesgue :=
  Outside.OAI158.chromaticNumber_plane_eq_chiM0.trans chiM0_eq_chiLebesgue

/-- The same in row 33's form, over `EuclideanSpace ℝ (Fin 2)`. -/
theorem chromaticNumber_euclidean_plane_eq_chiLebesgue :
    (unitDistance (EuclideanSpace ℝ (Fin 2))).chromaticNumber = chiLebesgue :=
  chromaticNumber_plane_eq_complex.trans chromaticNumber_plane_eq_chiLebesgue

end Plane

end HadwigerNelson

import Mathlib.Analysis.SpecialFunctions.Log.NegMulLog
import Mathlib.MeasureTheory.Measure.Typeclasses.Probability
import Mathlib.MeasureTheory.Measure.Real
import Mathlib.MeasureTheory.Measure.Map
import Mathlib.Dynamics.Ergodic.MeasurePreserving
import Mathlib.Probability.Kernel.Defs
import Mathlib.Order.LiminfLimsup
import Mathlib.Topology.Instances.ENNReal.Lemmas
import Proofs.HadwigerNelson.Outside.OAI015Mixtures

/-!
# Kolmogorov–Sinai entropy of a map for a measure (FS-131, jobs FS131-KN3 and FS131-KN6; skeleton)

**Read aloud, against the informal claim.** For a map `T : X → X`, a measure `μ` and a finite measurable partition given by
its label map `P : X → Fin k`, the *name* of a point through time `n` is the word `(P x, P (T x), …, P (T^[n-1] x))`; the
points with a given name are a cell (`nameCell`), the cells are the atoms of `P ∨ T⁻¹P ∨ … ∨ T^{-(n-1)}P`, and
`blockEntropy μ T P n = Σ_w −μ(cell w) log μ(cell w)` is the Shannon entropy `H_μ(⋁_{j<n} T^{-j}P)`. The entropy of `T` on
`P` is `h_μ(T, P) = inf_n H_n / n` (`partitionEntropy`; for a `T`-invariant probability measure `H_n` is subadditive, so
`H_n / n` converges and its limit is this infimum — `tendsto_blockEntropy_div`, the textbook's definition as a theorem), and
**the Kolmogorov–Sinai entropy is `h_μ(T) = sup_P h_μ(T, P)` over finite measurable partitions** (`ksEntropy`). Natural logarithms. The form on a sub-σ-algebra `𝒜` — the entropy of the factor of `T` that `𝒜`
is, written `h_μ(T | 𝒜)` in `plans/FS100-X02D-derivation.md` § 3.1 — is the same supremum over the `𝒜`-measurable label maps
(`ksEntropyOn`); `ksEntropy μ T = ksEntropyOn m μ T` by definition (`ksEntropyOn_self`).

**Why an infimum, and why the supremum is over *measurable* label maps.** `Rigidity.positive_entropy_rigidity` is an
axiom whose conclusion says that an entropy vanishes; were this entropy larger than the textbook's, that axiom would say
more than its page. The infimum is below every other reading of "the limit of `H_n / n`" for **every** measure and map,
with nothing to prove (`partitionEntropy_le_liminf`), so the axiom stated over it is implied by the axiom stated over any
of them; that it is not *smaller* than the textbook's number for an invariant probability measure is a theorem
(`tendsto_blockEntropy_div`), which only our own proofs read. With a non-measurable `P` the cells carry outer measure,
their masses need not add up to one, and the supremum can exceed the true entropy. Entropy is read in this library only
for a probability measure that the map preserves; elsewhere the definition is a junk value.

**Mathlib at the pin** has no measure-theoretic entropy of a transformation (`Dynamics/TopologicalEntropy/` is topological;
`Real.negMulLog`, `Real.binEntropy` and `InformationTheory.klDiv` are static). **Prior art in Lean:** `[OAIMath2026]` family
015, `OAI/NumberTheory/DukePrimeDegree/Entropy/MetricEntropy.lean` (Lean 4.34.1, Apache-2.0), defines `metricEntropy` in the
same shape — a label map into `Fin (k + 1)`, the names' cells, a `liminf` — read on 2026-10-13; nothing is copied from it,
and its further files (`Entropy/`, 20,958 lines) are unread. The same family's `PrimePackets/ShannonEntropy.lean` defines
`measureEntropy` as this module does — a supremum over label maps of `sInf {H_N / N}` — and is to be ported beside it
(`plans/FS131-KN6-chain-first-layer.md` § Stage 5): `ksEntropy` and `measureEntropy` are then the same number for every
measure and map.

**Inhabitants.** The zero measure has entropy `0` (`ksEntropy_zero_measure`). Stated for the module's implementer, each a
check that would fail if the definition drifted: `blockEntropy_one` (time one is the Shannon entropy of the partition),
`ksEntropy_id` (the identity has entropy `0`), `ksEntropy_map` (the entropy of a factor is the entropy on the pulled-back
σ-algebra); the claim list `data/fs131/kn3/claims-M1-entropy.md` adds the two-shift at `log 2`.
-/

namespace HadwigerNelson.Rigidity

open MeasureTheory Filter

open scoped ENNReal

variable {X : Type*}

/-- **The cell of a name**: the points whose labels along the orbit, at times `0, …, n − 1`, spell the word `w`. The cells
at length `n` are the atoms of `P ∨ T⁻¹P ∨ … ∨ T^{-(n-1)}P`. -/
def nameCell {k : ℕ} (T : X → X) (P : X → Fin k) (n : ℕ) (w : Fin n → Fin k) : Set X :=
  {x | ∀ j : Fin n, P (T^[j] x) = w j}

/-- **Shannon entropy of the names of length `n`**: `H_μ(⋁_{j<n} T^{-j}P) = Σ_w −μ(cell w) log μ(cell w)`. -/
noncomputable def blockEntropy {m : MeasurableSpace X} (μ : Measure X) {k : ℕ} (T : X → X) (P : X → Fin k) (n : ℕ) : ℝ :=
  ∑ w : Fin n → Fin k, Real.negMulLog (μ.real (nameCell T P n w))

/-- **The entropy of `T` on the partition `P`**: `h_μ(T, P) = inf_{n ≥ 1} H_μ(⋁_{j<n} T^{-j}P) / n` (the index `n + 1`
keeps the denominator positive). For a `T`-invariant probability measure it is the limit of `H_n / n`
(`tendsto_blockEntropy_div`). -/
noncomputable def partitionEntropy {m : MeasurableSpace X} (μ : Measure X) {k : ℕ} (T : X → X) (P : X → Fin k) : ℝ≥0∞ :=
  ⨅ n : ℕ, ENNReal.ofReal (blockEntropy μ T P (n + 1) / (n + 1))

/-- **The infimum is below the `liminf`, for every measure and map**: an entropy defined by a limit of `H_n / n`, in
whichever reading, is at least `partitionEntropy`. This is the direction in which an axiom concluding "entropy zero" stays
within its page with nothing to prove. -/
theorem partitionEntropy_le_liminf {m : MeasurableSpace X} (μ : Measure X) {k : ℕ} (T : X → X) (P : X → Fin k) :
    partitionEntropy μ T P ≤ liminf (fun n : ℕ => ENNReal.ofReal (blockEntropy μ T P (n + 1) / (n + 1))) atTop :=
  iInf_le_liminf

/-- **The entropy of `T` on the sub-σ-algebra `𝒜`**: the supremum of `h_μ(T, P)` over the finite partitions whose label
map is `𝒜`-measurable. For a `T`-invariant `𝒜` it is the Kolmogorov–Sinai entropy of the factor of `(X, μ, T)` that `𝒜` is. -/
noncomputable def ksEntropyOn {m : MeasurableSpace X} (𝒜 : MeasurableSpace X) (μ : @Measure X m) (T : X → X) : ℝ≥0∞ :=
  ⨆ (k : ℕ) (P : X → Fin k) (_ : Measurable[𝒜] P), partitionEntropy μ T P

/-- **Kolmogorov–Sinai entropy** `h_μ(T)`: the supremum of `h_μ(T, P)` over the finite measurable partitions. -/
noncomputable def ksEntropy {m : MeasurableSpace X} (μ : Measure X) (T : X → X) : ℝ≥0∞ :=
  ksEntropyOn m μ T

@[simp] theorem ksEntropyOn_self {m : MeasurableSpace X} (μ : Measure X) (T : X → X) : ksEntropyOn m μ T = ksEntropy μ T := rfl

@[simp] theorem nameCell_zero {k : ℕ} (T : X → X) (P : X → Fin k) (w : Fin 0 → Fin k) : nameCell T P 0 w = Set.univ :=
  Set.eq_univ_of_forall fun _ j => j.elim0

/-- The cells are measurable when the map and the label map are. -/
theorem measurableSet_nameCell {m : MeasurableSpace X} {k : ℕ} {T : X → X} (hT : Measurable T) {P : X → Fin k}
    (hP : Measurable P) (n : ℕ) (w : Fin n → Fin k) : MeasurableSet (nameCell T P n w) := by
  have h : nameCell T P n w = ⋂ j : Fin n, (fun x => P (T^[j] x)) ⁻¹' {w j} := by
    ext x
    simp [nameCell]
  rw [h]
  exact MeasurableSet.iInter fun j => (hP.comp (hT.iterate j)) (measurableSet_singleton _)

/-- A coarser σ-algebra carries less entropy. -/
theorem ksEntropyOn_mono {m : MeasurableSpace X} {𝒜 ℬ : MeasurableSpace X} (h : 𝒜 ≤ ℬ) (μ : @Measure X m) (T : X → X) :
    ksEntropyOn 𝒜 μ T ≤ ksEntropyOn ℬ μ T :=
  iSup_mono fun _ => iSup_mono fun _ => iSup_mono' fun hP => ⟨hP.mono h le_rfl, le_rfl⟩

@[simp] theorem blockEntropy_zero_measure {m : MeasurableSpace X} {k : ℕ} (T : X → X) (P : X → Fin k) (n : ℕ) :
    blockEntropy (0 : Measure X) T P n = 0 := by
  simp [blockEntropy]

/-- **An inhabitant of "zero entropy"**: the zero measure. -/
@[simp] theorem ksEntropy_zero_measure {m : MeasurableSpace X} (T : X → X) : ksEntropy (0 : Measure X) T = 0 := by
  simp [ksEntropy, ksEntropyOn, partitionEntropy]

/-- **Time one is the Shannon entropy of the partition**: `H_μ(P) = Σ_c −μ(P = c) log μ(P = c)`. A check on the
definition (the sum over words of length one is the sum over labels). -/
theorem blockEntropy_one {m : MeasurableSpace X} (μ : Measure X) {k : ℕ} (T : X → X) (P : X → Fin k) :
    blockEntropy μ T P 1 = ∑ c : Fin k, Real.negMulLog (μ.real (P ⁻¹' {c})) := by
  have hcell : ∀ w : Fin 1 → Fin k, nameCell T P 1 w = P ⁻¹' {w 0} := by
    intro w
    ext x
    constructor
    · intro h
      simpa using h 0
    · intro h j
      obtain rfl : j = 0 := Subsingleton.elim _ _
      simpa using h
  unfold blockEntropy
  simp only [hcell]
  exact Fintype.sum_equiv (Equiv.funUnique (Fin 1) (Fin k)) _ _ fun _ => rfl

/-- For the identity every name is a constant word: the cells of the other words are empty, and the cell of the
constant word `c` is `P ⁻¹' {c}`, so `H_{n+1} = H_1`. -/
private theorem blockEntropy_id {m : MeasurableSpace X} (μ : Measure X) {k : ℕ} (P : X → Fin k) (n : ℕ) :
    blockEntropy μ id P (n + 1) = blockEntropy μ id P 1 := by
  have key : ∀ N : ℕ, blockEntropy μ id P (N + 1) = ∑ c : Fin k, Real.negMulLog (μ.real (P ⁻¹' {c})) := by
    intro N
    unfold blockEntropy
    symm
    refine Fintype.sum_of_injective (fun c : Fin k => (fun _ : Fin (N + 1) => c)) (fun a b h => congrFun h 0)
      _ _ (fun w hw => ?_) (fun c => ?_)
    · have hempty : nameCell id P (N + 1) w = ∅ := by
        refine Set.eq_empty_of_forall_notMem fun x hx => hw ⟨P x, funext fun j => ?_⟩
        simpa using hx j
      rw [hempty, measureReal_empty, Real.negMulLog_zero]
    · congr 2
      ext x
      constructor
      · intro hx j
        simpa using hx
      · intro hx
        simpa using hx 0
  rw [key n, key 0]

/-- **The identity has entropy zero**: a check that the definition is not too large (every name is a constant word, so
`H_n = H_1` for every `n ≥ 1`, and `inf_n H_1 / n = 0`). No hypothesis on the measure: `μ.real` is finite. -/
theorem ksEntropy_id {m : MeasurableSpace X} (μ : Measure X) : ksEntropy μ (id : X → X) = 0 := by
  simp only [ksEntropy, ksEntropyOn, ENNReal.iSup_eq_zero]
  intro k P _
  have hlim : Tendsto (fun n : ℕ => ENNReal.ofReal (blockEntropy μ id P 1 / ((n : ℝ) + 1))) atTop (nhds 0) := by
    have h := (tendsto_const_div_atTop_nhds_zero_nat (blockEntropy μ id P 1)).comp (tendsto_add_atTop_nat 1)
    have h' := (ENNReal.continuous_ofReal.tendsto _).comp h
    simpa [Function.comp_def] using h'
  refine le_antisymm (ge_of_tendsto' hlim fun n => ?_) bot_le
  rw [← blockEntropy_id μ P n]
  exact iInf_le _ n

/-! ## The bridge to the release's entropy (`Outside/OAI015Shannon`; FS131-KN6's statements, FS131-IE1's proofs)

`[OAIMath2026]` family 015 defines the entropy of a map in the same shape as this module (a supremum over finite
measurable label maps of an infimum of `H_N / N`), independently; ported here, its theorems are this module's through
the four lemmas below: a cell is a fibre of the release's `orbitName`, `blockEntropy` is its `observationEntropy`, and
for a probability measure the two entropies are one number for every map. The statements are FS131-KN6's
(`data/fs131/kn6/bridge-statements.lean`), with the release's namespace as it is ported here. -/

section Bridge

open HadwigerNelson.Outside.OAI015

/-- A cell of names is a fibre of the release's `orbitName`. -/
theorem nameCell_eq_orbitName_fibre {k : ℕ} (T : X → X) (P : X → Fin k) (n : ℕ) (w : Fin n → Fin k) :
    nameCell T P n w = {x | orbitName T P n x = w} := by
  ext x
  simp [nameCell, orbitName, funext_iff]

/-- The Shannon entropy of the names of length `n` is the release's entropy of the observation `orbitName T P n`. -/
theorem blockEntropy_eq_observationEntropy {m : MeasurableSpace X} (μ : Measure X) {k : ℕ} (T : X → X) (P : X → Fin k)
    (n : ℕ) : blockEntropy μ T P n = observationEntropy μ (orbitName T P n) := by
  simp only [blockEntropy, observationEntropy, finiteShannon, nameCell_eq_orbitName_fibre]

/-- The entropy of `T` on a partition is the release's rate, for a probability measure (every `H_n` is then `≥ 0`). -/
theorem partitionEntropy_eq_ofReal_observationEntropyRate {m : MeasurableSpace X} (μ : Measure X)
    [IsProbabilityMeasure μ] {k : ℕ} (T : X → X) (P : X → Fin k) :
    partitionEntropy μ T P = ENNReal.ofReal (observationEntropyRate μ T P) := by
  set a : ℕ → ℝ := fun N => observationEntropy μ (orbitName T P N) / (N : ℝ) with ha
  have hH : ∀ N, 0 ≤ observationEntropy μ (orbitName T P N) := fun N => by
    rw [← blockEntropy_eq_observationEntropy]
    exact Finset.sum_nonneg fun _ _ => Real.negMulLog_nonneg measureReal_nonneg measureReal_le_one
  have hne : (a '' Set.Ici 1).Nonempty := ⟨a 1, 1, Set.self_mem_Ici, rfl⟩
  have hbdd : BddBelow (a '' Set.Ici 1) := ⟨0, by rintro _ ⟨N, -, rfl⟩; exact div_nonneg (hH N) N.cast_nonneg⟩
  have hmap := Monotone.map_csInf_of_continuousAt ENNReal.continuous_ofReal.continuousAt
    (fun _ _ h => ENNReal.ofReal_le_ofReal h) hne hbdd
  have hrate : observationEntropyRate μ T P = sInf (a '' Set.Ici 1) := rfl
  rw [hrate, hmap, Set.image_image, sInf_image]
  unfold partitionEntropy
  apply le_antisymm
  · refine le_iInf₂ fun N hN => ?_
    obtain ⟨n, rfl⟩ : ∃ n, N = n + 1 := ⟨N - 1, by rw [Set.mem_Ici] at hN; omega⟩
    refine (iInf_le _ n).trans_eq ?_
    simp [a, blockEntropy_eq_observationEntropy]
  · refine le_iInf fun n => (iInf₂_le (n + 1) (by simp)).trans_eq ?_
    simp [a, blockEntropy_eq_observationEntropy]

/-- **The two entropies are one number**, for every probability measure and every map. -/
theorem ksEntropy_eq_measureEntropy {m : MeasurableSpace X} (μ : Measure X) [IsProbabilityMeasure μ] (T : X → X) :
    ksEntropy μ T = measureEntropy μ T := by
  unfold ksEntropy ksEntropyOn measureEntropy
  refine iSup_congr fun k => iSup_congr fun P => ?_
  refine iSup_congr_Prop ⟨fun hP a => hP (measurableSet_singleton a), fun h => measurable_to_countable' h⟩
    fun _ => ?_
  exact partitionEntropy_eq_ofReal_observationEntropyRate μ T P

end Bridge

/-- **The pinning theorem: for a probability measure that the map preserves, `H_n / n` converges, and its limit is
`partitionEntropy`** — the textbook's `h_μ(T, P) = lim_n H_μ(⋁_{j<n} T^{-j}P) / n` (the limit exists because `H_n` is
subadditive under invariance, and equals the infimum by Fekete's lemma, Mathlib's `Subadditive.tendsto_lim`). With it
every statement of this library about `ksEntropy` of an invariant probability measure is a statement about the
textbook's number. `Rigidity.positive_entropy_rigidity` does not wait on it (its docstring). -/
theorem tendsto_blockEntropy_div {m : MeasurableSpace X} (μ : Measure X) [IsProbabilityMeasure μ] {T : X → X}
    (hT : MeasurePreserving T μ μ) {k : ℕ} {P : X → Fin k} (hP : Measurable P) :
    Tendsto (fun n : ℕ => ENNReal.ofReal (blockEntropy μ T P (n + 1) / (n + 1))) atTop
      (nhds (partitionEntropy μ T P)) := by
  have hP' : ∀ a, MeasurableSet {y | P y = a} := fun a => hP (measurableSet_singleton a)
  have h := ENNReal.tendsto_ofReal
    ((Outside.OAI015.tendsto_observationEntropyRate μ hT P hP').comp (tendsto_add_atTop_nat 1))
  rw [partitionEntropy_eq_ofReal_observationEntropyRate]
  refine Tendsto.congr (fun n => ?_) h
  simp [blockEntropy_eq_observationEntropy]

/-- The cells of a factor pull back to the cells of the map: for `π ∘ T = S ∘ π`, the points whose image is named `w`
by `(S, Q)` are the points named `w` by `(T, Q ∘ π)`. -/
private theorem preimage_nameCell {Y : Type*} {T : X → X} {π : X → Y} {S : Y → Y} (h : ∀ x, π (T x) = S (π x))
    {k : ℕ} (Q : Y → Fin k) (n : ℕ) (w : Fin n → Fin k) : π ⁻¹' nameCell S Q n w = nameCell T (Q ∘ π) n w := by
  have hit : ∀ (j : ℕ) (x : X), π (T^[j] x) = S^[j] (π x) := fun j x =>
    Function.Semiconj.iterate_right (f := π) (ga := T) (gb := S) h j x
  ext x
  simp [nameCell, hit]

/-- The entropy of a factor on a measurable partition is the entropy of the map on the pulled-back partition. -/
private theorem partitionEntropy_map {m : MeasurableSpace X} {Y : Type*} [MeasurableSpace Y] (μ : Measure X)
    {T : X → X} {π : X → Y} (hπ : Measurable π) {S : Y → Y} (hS : Measurable S) (h : ∀ x, π (T x) = S (π x))
    {k : ℕ} {Q : Y → Fin k} (hQ : Measurable Q) : partitionEntropy (μ.map π) S Q = partitionEntropy μ T (Q ∘ π) := by
  unfold partitionEntropy blockEntropy
  simp only [map_measureReal_apply hπ (measurableSet_nameCell hS hQ _ _), preimage_nameCell h]

/-- A label map measurable for a pulled-back σ-algebra is a measurable label map of the factor composed with the
projection (when there is a label `c₀` to give the points off the image). -/
private theorem exists_measurable_comp_of_comap {Y : Type*} [mY : MeasurableSpace Y] {π : X → Y} {k : ℕ}
    {P : X → Fin k} (hP : Measurable[mY.comap π] P) (c₀ : Fin k) :
    ∃ Q : Y → Fin k, Measurable Q ∧ ∀ x, Q (π x) = P x := by
  classical
  choose B hB hBP using fun c : Fin k => MeasurableSpace.measurableSet_comap.1 (hP (measurableSet_singleton c))
  have hmem : ∀ x c, π x ∈ B c ↔ P x = c := fun x c => by
    simpa using Set.ext_iff.1 (hBP c) x
  have key : ∀ L : List (Fin k),
      ∃ Q : Y → Fin k, Measurable Q ∧ ∀ x, Q (π x) = if P x ∈ L then P x else c₀ := by
    intro L
    induction L with
    | nil => exact ⟨fun _ => c₀, measurable_const, fun x => by simp⟩
    | cons c L ih =>
      obtain ⟨Q, hQ, hQP⟩ := ih
      refine ⟨fun y => if y ∈ B c then c else Q y, Measurable.ite (hB c) measurable_const hQ, fun x => ?_⟩
      by_cases hc : P x = c
      · simp [(hmem x c).2 hc, hc]
      · have hx : π x ∉ B c := fun hx => hc ((hmem x c).1 hx)
        simp [hx, hQP x, hc]
  obtain ⟨Q, hQ, hQP⟩ := key (List.finRange k)
  exact ⟨Q, hQ, fun x => by simpa using hQP x⟩

/-- **The entropy of a factor is the entropy on the pulled-back σ-algebra**: for `π ∘ T = S ∘ π`,
`h_{π_*μ}(S) = h_μ(T | π⁻¹ℬ_Y)`. This is the bridge between the page's "the measure induced on the factor `X/G`" and
`ksEntropyOn`. -/
theorem ksEntropy_map {m : MeasurableSpace X} {Y : Type*} [mY : MeasurableSpace Y] (μ : Measure X) {T : X → X} {π : X → Y}
    (hπ : Measurable π) {S : Y → Y} (hS : Measurable S) (h : ∀ x, π (T x) = S (π x)) :
    ksEntropy (μ.map π) S = ksEntropyOn (mY.comap π) μ T := by
  apply le_antisymm
  · refine iSup_le fun k => iSup_le fun Q => iSup_le fun hQ => ?_
    rw [partitionEntropy_map μ hπ hS h hQ]
    exact le_iSup_of_le k (le_iSup_of_le (Q ∘ π) (le_iSup_of_le (hQ.comp (comap_measurable π)) le_rfl))
  · refine iSup_le fun k => iSup_le fun P => iSup_le fun hP => ?_
    rcases isEmpty_or_nonempty X with hX | ⟨⟨x₀⟩⟩
    · rw [Measure.eq_zero_of_isEmpty μ]
      refine le_trans (iInf_le _ 0) ?_
      simp
    · obtain ⟨Q, hQ, hQP⟩ := exists_measurable_comp_of_comap hP (P x₀)
      have hPQ : P = Q ∘ π := funext fun x => (hQP x).symm
      rw [hPQ, ← partitionEntropy_map μ hπ hS h hQ]
      exact le_iSup_of_le k (le_iSup_of_le Q (le_iSup_of_le hQ le_rfl))

/-! ## The reasoning surface: what the next modules read, so that nobody unfolds a definition (FS131-KN6)

Proved here over Mathlib alone: membership in a cell, the two inequalities that say "an entropy is a supremum of infima",
`ksEntropy_eq_zero_iff`, and `blockEntropy_nonneg`. Leaves: the point mass (`ksEntropy_dirac`), long blocks of small
entropy (`exists_blockEntropy_le_mul`, what EN2-ZE reads of "entropy zero"), the limit along increasing σ-algebras
(`ksEntropy_eq_iSup_ksEntropyOn`, T2) and the mixture lemma (`ksEntropy_bind_eq_zero`, the consequence of Jacobs's formula
the chain reads). The last three and the pinning theorem are proved from the release's entropy files once they are ported
(`plans/FS131-KN6-chain-first-layer.md` § Stage 5); the bridge is `data/fs131/kn6/bridge-statements.lean`. -/

@[simp] theorem mem_nameCell {k : ℕ} {T : X → X} {P : X → Fin k} {n : ℕ} {w : Fin n → Fin k} {x : X} :
    x ∈ nameCell T P n w ↔ ∀ j : Fin n, P (T^[j] x) = w j := Iff.rfl

/-- Every point lies in the cell of its own name. -/
theorem mem_nameCell_self {k : ℕ} (T : X → X) (P : X → Fin k) (n : ℕ) (x : X) :
    x ∈ nameCell T P n (fun j => P (T^[j] x)) := fun _ => rfl

/-- The entropy on a partition is below each `H_n / n`. -/
theorem partitionEntropy_le {m : MeasurableSpace X} (μ : Measure X) {k : ℕ} (T : X → X) (P : X → Fin k) (n : ℕ) :
    partitionEntropy μ T P ≤ ENNReal.ofReal (blockEntropy μ T P (n + 1) / (n + 1)) :=
  iInf_le _ n

/-- The entropy on a sub-σ-algebra is above the entropy on each of its partitions. -/
theorem partitionEntropy_le_ksEntropyOn {m : MeasurableSpace X} {𝒜 : MeasurableSpace X} (μ : @Measure X m) (T : X → X)
    {k : ℕ} {P : X → Fin k} (hP : Measurable[𝒜] P) : partitionEntropy μ T P ≤ ksEntropyOn 𝒜 μ T :=
  le_iSup_of_le k (le_iSup_of_le P (le_iSup_of_le hP le_rfl))

/-- The entropy is above the entropy on each measurable partition. -/
theorem partitionEntropy_le_ksEntropy {m : MeasurableSpace X} (μ : Measure X) (T : X → X) {k : ℕ} {P : X → Fin k}
    (hP : Measurable P) : partitionEntropy μ T P ≤ ksEntropy μ T :=
  partitionEntropy_le_ksEntropyOn μ T hP

/-- **Entropy zero, read partition by partition** — the form in which every consumer of "entropy zero" takes it. -/
theorem ksEntropy_eq_zero_iff {m : MeasurableSpace X} (μ : Measure X) (T : X → X) :
    ksEntropy μ T = 0 ↔ ∀ (k : ℕ) (P : X → Fin k), Measurable P → partitionEntropy μ T P = 0 := by
  simp only [ksEntropy, ksEntropyOn, ENNReal.iSup_eq_zero]

-- With two `MeasurableSpace X` binders in scope `(μ : Measure X)` is a measure for the LAST one (here `𝒜`): the measure's
-- σ-algebra is written out, `@Measure X m`, in every statement that names a sub-σ-algebra (FS131-KN6, found by a mismatch).
/-- A sub-σ-algebra carries at most the entropy. -/
theorem ksEntropyOn_le_ksEntropy {m : MeasurableSpace X} {𝒜 : MeasurableSpace X} (h : 𝒜 ≤ m) (μ : @Measure X m)
    (T : X → X) : ksEntropyOn 𝒜 μ T ≤ ksEntropy μ T :=
  ksEntropyOn_mono h μ T

/-- For a probability measure every `H_n` is non-negative (each cell has mass in `[0, 1]`; no measurability is read). -/
theorem blockEntropy_nonneg {m : MeasurableSpace X} (μ : Measure X) [IsProbabilityMeasure μ] {k : ℕ} (T : X → X)
    (P : X → Fin k) (n : ℕ) : 0 ≤ blockEntropy μ T P n :=
  Finset.sum_nonneg fun _ _ => Real.negMulLog_nonneg measureReal_nonneg measureReal_le_one

/-- **A point mass has entropy zero**, for every measurable map: each cell has mass `0` or `1`. With it the point mass at
the trivial character is the `ρ` of `EntropySplit` when the non-Haar part vanishes, and the model of `ZeroEntropyCarried`. -/
theorem ksEntropy_dirac {m : MeasurableSpace X} {T : X → X} (hT : Measurable T) (x : X) :
    ksEntropy (Measure.dirac x) T = 0 := by
  rw [ksEntropy_eq_zero_iff]
  intro k P hP
  have hH : blockEntropy (Measure.dirac x) T P (0 + 1) = 0 := by
    refine Finset.sum_eq_zero fun w _ => ?_
    have hm := measurableSet_nameCell hT hP (0 + 1) w
    by_cases hx : x ∈ nameCell T P (0 + 1) w
    · simp [Measure.real, Measure.dirac_apply' x hm, hx]
    · simp [Measure.real, Measure.dirac_apply' x hm, hx]
  refine le_antisymm ((partitionEntropy_le _ T P 0).trans ?_) bot_le
  rw [hH]
  simp

/-- **Entropy zero gives long blocks of small entropy** (FS131-EN2, EN2-ZE step 2; EN2 § 5.1 items 1–2): for a probability
measure that `T` preserves and a measurable partition of rate zero, every `ε > 0` and every `K` have a block length
`n ≥ K` with `H_n ≤ ε n`. Route: the pinning theorem (`H_n / n` converges to the infimum, which is `0`). -/
theorem exists_blockEntropy_le_mul {m : MeasurableSpace X} (μ : Measure X) [IsProbabilityMeasure μ] {T : X → X}
    (hT : MeasurePreserving T μ μ) {k : ℕ} {P : X → Fin k} (hP : Measurable P) (h0 : partitionEntropy μ T P = 0)
    {ε : ℝ} (hε : 0 < ε) (K : ℕ) : ∃ n : ℕ, K ≤ n ∧ 0 < n ∧ blockEntropy μ T P n ≤ ε * n := by
  have h := tendsto_blockEntropy_div μ hT hP
  rw [h0] at h
  have hε' : (0 : ℝ≥0∞) < ENNReal.ofReal ε := ENNReal.ofReal_pos.2 hε
  obtain ⟨n, hlt, hn⟩ := ((h.eventually (gt_mem_nhds hε')).and (eventually_ge_atTop K)).exists
  refine ⟨n + 1, by omega, Nat.succ_pos n, ?_⟩
  have h1 : blockEntropy μ T P (n + 1) / ((n : ℝ) + 1) < ε := (ENNReal.ofReal_lt_ofReal_iff hε).1 hlt
  have hpos : (0 : ℝ) < (n : ℝ) + 1 := by positivity
  rw [div_lt_iff₀ hpos] at h1
  push_cast
  linarith

/-- **T2, the entropy along increasing σ-algebras** (`plans/FS100-X02D-derivation.md` l. 173; read by Lemma Γ): for
countably generated sub-σ-algebras that increase and generate the whole σ-algebra, the entropy is the supremum of the
entropies on them. From the release's `measureEntropy_eq_iSup_generating` (finite partitions that increase and generate). -/
theorem ksEntropy_eq_iSup_ksEntropyOn {m : MeasurableSpace X} (μ : Measure X) [IsProbabilityMeasure μ] {T : X → X}
    (hT : MeasurePreserving T μ μ) (𝒜 : ℕ → MeasurableSpace X) (hmono : Monotone 𝒜) (hgen : ⨆ i, 𝒜 i = m)
    (hcg : ∀ i, @MeasurableSpace.CountablyGenerated X (𝒜 i)) :
    ksEntropy μ T = ⨆ i, ksEntropyOn (𝒜 i) μ T := by
  sorry

/-- **A mixture of invariant measures of entropy zero has entropy zero** — the one consequence of Jacobs's formula the
chain reads (`plans/FS100-X02D-derivation.md` ll. 207, 217; FS131-EN2 § 4.2 step 4). The release's
`measureEntropy_kernel_zero`, word for word, over `ksEntropy`. -/
theorem ksEntropy_bind_eq_zero {Z : Type*} [MeasurableSpace Z] {m : MeasurableSpace X} (τ : Measure Z)
    [IsProbabilityMeasure τ] (κ : ProbabilityTheory.Kernel Z X) [ProbabilityTheory.IsMarkovKernel κ] {T : X → X}
    (hT : Measurable T) (hκ : ∀ᵐ z ∂τ, MeasurePreserving T (κ z) (κ z)) (hzero : ∀ᵐ z ∂τ, ksEntropy (κ z) T = 0) :
    ksEntropy (τ.bind κ) T = 0 := by
  rw [ksEntropy_eq_measureEntropy]
  exact Outside.OAI015.measureEntropy_kernel_zero τ κ hT hκ
    (hzero.mono fun z hz => (ksEntropy_eq_measureEntropy (κ z) T).symm.trans hz)

end HadwigerNelson.Rigidity

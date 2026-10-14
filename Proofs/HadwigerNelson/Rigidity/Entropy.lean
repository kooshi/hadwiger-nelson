import Mathlib.Analysis.SpecialFunctions.Log.NegMulLog
import Mathlib.MeasureTheory.Measure.Typeclasses.Probability
import Mathlib.MeasureTheory.Measure.Real
import Mathlib.MeasureTheory.Measure.Map
import Mathlib.Dynamics.Ergodic.MeasurePreserving
import Mathlib.Order.LiminfLimsup
import Mathlib.Topology.Instances.ENNReal.Lemmas

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

theorem ksEntropyOn_self {m : MeasurableSpace X} (μ : Measure X) (T : X → X) : ksEntropyOn m μ T = ksEntropy μ T := rfl

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
  sorry

/-- **The identity has entropy zero**: a check that the definition is not too large (every name is a constant word, so
`H_n = H_1` for every `n ≥ 1`, and `inf_n H_1 / n = 0`). No hypothesis on the measure: `μ.real` is finite. -/
theorem ksEntropy_id {m : MeasurableSpace X} (μ : Measure X) : ksEntropy μ (id : X → X) = 0 := by
  sorry

/-- **The pinning theorem: for a probability measure that the map preserves, `H_n / n` converges, and its limit is
`partitionEntropy`** — the textbook's `h_μ(T, P) = lim_n H_μ(⋁_{j<n} T^{-j}P) / n` (the limit exists because `H_n` is
subadditive under invariance, and equals the infimum by Fekete's lemma, Mathlib's `Subadditive.tendsto_lim`). With it
every statement of this library about `ksEntropy` of an invariant probability measure is a statement about the
textbook's number. `Rigidity.positive_entropy_rigidity` does not wait on it (its docstring). -/
theorem tendsto_blockEntropy_div {m : MeasurableSpace X} (μ : Measure X) [IsProbabilityMeasure μ] {T : X → X}
    (hT : MeasurePreserving T μ μ) {k : ℕ} {P : X → Fin k} (hP : Measurable P) :
    Tendsto (fun n : ℕ => ENNReal.ofReal (blockEntropy μ T P (n + 1) / (n + 1))) atTop
      (nhds (partitionEntropy μ T P)) := by
  sorry

/-- **The entropy of a factor is the entropy on the pulled-back σ-algebra**: for `π ∘ T = S ∘ π`,
`h_{π_*μ}(S) = h_μ(T | π⁻¹ℬ_Y)`. This is the bridge between the page's "the measure induced on the factor `X/G`" and
`ksEntropyOn`. -/
theorem ksEntropy_map {m : MeasurableSpace X} {Y : Type*} [mY : MeasurableSpace Y] (μ : Measure X) {T : X → X} {π : X → Y}
    (hπ : Measurable π) {S : Y → Y} (hS : Measurable S) (h : ∀ x, π (T x) = S (π x)) :
    ksEntropy (μ.map π) S = ksEntropyOn (mY.comap π) μ T := by
  sorry

end HadwigerNelson.Rigidity

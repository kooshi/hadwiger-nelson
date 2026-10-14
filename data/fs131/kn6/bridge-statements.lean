-- FS131-KN6: the bridge between this library's entropy (`Rigidity/Entropy`) and the release's (`PrimePackets/ShannonEntropy`),
-- typed against the real constants in a scratch bundle (tools/fs131_kn6_release_copy.py, bundle "Bridge"). My text; the
-- release's is not in this file.  These are the statements of the planned module `Rigidity/EntropyBridge` (Stage 5).
namespace HadwigerNelson.Rigidity

open MeasureTheory OAI.PrimeDegreePackets

open scoped ENNReal

variable {X : Type*}

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
  sorry

/-- **The two entropies are one number**, for every probability measure and every map. -/
theorem ksEntropy_eq_measureEntropy {m : MeasurableSpace X} (μ : Measure X) [IsProbabilityMeasure μ] (T : X → X) :
    ksEntropy μ T = measureEntropy μ T := by
  sorry

end HadwigerNelson.Rigidity

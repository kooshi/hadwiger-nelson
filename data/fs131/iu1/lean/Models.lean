import Proofs.HadwigerNelson.Arith.UpperHalf
import Proofs.HadwigerNelson.Arith.StandingFive
/-!
FS131-IU1 — the headlines of `Arith/UpperHalf` at a model the kernel holds today, from the compiled modules (run after the
build): `lake env lean data/fs131/iu1/lean/Models.lean`. Never part of the library: `Arith/UpperHalf` does not import
`Arith/StandingFive`, and this job adds no import.

The model: the standing field `F = ℚ(√3, √11, η) ⊂ ℝ` (`StandingFive.standingField`, a number field by
`StandingFive.instNumberFieldStanding`) with a stable prime of `F(i)` above 2 (`StandingFive.exists_stablePrime_two`).
Each theorem below applies one headline at it; `#print axioms` then shows what the model itself rests on.
-/
open HadwigerNelson HadwigerNelson.SpectralChain HadwigerNelson.StandingFive HadwigerNelson.UpperHalf SimpleGraph NumberField

namespace FS131IU1Models

/-- `StablePrime F` with `[NumberField F]` is inhabited: the hypothesis of every NF1-S1B statement. -/
theorem stablePrime_model : Nonempty (StablePrime standingField) :=
  let ⟨P, _⟩ := exists_stablePrime_two; ⟨P⟩

/-- `exists_hom_levelTarget` at the model, every level `m ≥ 1`, with its formula exercised on a unit edge: the difference of
two points at distance 1 lies in `𝓞_P`. -/
theorem hom_model : ∃ P : StablePrime standingField, ∀ m : ℕ, 1 ≤ m →
    Nonempty ((unitDistance ℂ).induce (planeOver standingField) →g levelTarget P m) :=
  let ⟨P, _⟩ := exists_stablePrime_two
  ⟨P, fun _ hm => let ⟨h, _⟩ := exists_hom_levelTarget P hm; ⟨h⟩⟩

/-- `exists_stablePrime_of_valuationSubring`'s hypotheses hold of `𝓞_P` (`localRing_ne_top`, `conj_mem_localRing`), and its
conclusion returns a stable prime with the same localization. -/
theorem converse_model : ∃ P Q : StablePrime standingField, Q.localRing = P.localRing :=
  let ⟨P, _⟩ := exists_stablePrime_two
  let ⟨Q, hQ⟩ := exists_stablePrime_of_valuationSubring P.localRing (localRing_ne_top P) (conj_mem_localRing P)
  ⟨P, Q, hQ⟩

/-- Row 105 over the stable primes, at `n = 2` in the model: the right side fails (a stable prime holds 2), so `1/2` is not
in the ring of unit vectors of the standing field's plane — the 2-adic wall stands there. Both sides of the iff occur:
at `n = 1` both hold. -/
theorem wall_model : (2 : ℂ)⁻¹ ∉ UnitRing.unitRingOver standingField := by
  obtain ⟨P, hP⟩ := exists_stablePrime_two
  intro h
  have h2 := (inv_natCast_mem_unitRingOver_iff_forall_stablePrime standingField (n := 2) two_ne_zero).1 (by simpa using h) P
  exact h2 (by simpa using hP)

/-- …and at `n = 1` both sides hold (no prime holds 1). -/
theorem one_model : ∀ P : StablePrime standingField, ((1 : ℕ) : 𝓞 (fieldI standingField)) ∉ P.P :=
  (inv_natCast_mem_unitRingOver_iff_forall_stablePrime standingField (n := 1) one_ne_zero).1
    (by simp)

/-- `colorable_two_planeOver_of_ramified`'s hypothesis `hram` has **no** model at the standing field: conjugation is not the
identity modulo any stable prime there (`StandingFive.exists_conjO_sub_notMem`). Its model is at `ℚ`
(`UpperHalf.exists_stablePrime_rat`, a leaf of `Instances/UpperHalfValues`). -/
theorem hram_fails_at_standingField (P : StablePrime standingField) :
    ¬ ∀ x : 𝓞 (fieldI standingField), conjO standingField x - x ∈ P.P := fun h =>
  let ⟨x, hx⟩ := exists_conjO_sub_notMem P; hx (h x)

end FS131IU1Models

set_option pp.fullNames true
#print axioms HadwigerNelson.StandingFive.exists_stablePrime_two
#print axioms HadwigerNelson.StandingFive.instNumberFieldStanding
#print axioms FS131IU1Models.stablePrime_model
#print axioms FS131IU1Models.hom_model
#print axioms FS131IU1Models.converse_model
#print axioms FS131IU1Models.wall_model
#print axioms FS131IU1Models.one_model
#print axioms FS131IU1Models.hram_fails_at_standingField

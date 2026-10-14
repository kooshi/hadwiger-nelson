import Proofs.HadwigerNelson.Instances.UpperHalfValues
/-!
FS131-IV1 — the hypothesis-shaped headlines of the module's three files, each applied at an inhabitant the compiled
library holds (run after the build): `data/fs131/iv1/lean1.sh data/fs131/iv1/lean/Models.lean`. Never part of the library.

The models: **`ℚ`** (`⊥ : Subfield ℝ`, a number field by `UpperHalf.instNumberFieldBot`) with the stable prime of `ℚ(i)`
above 2 (`UpperHalf.exists_stablePrime_rat`) — the one inhabitant of the two-colour theorems' hypothesis `hram`; and
**`ℚ(√11)` at 7** (`QuadraticPrime.exists_maximal_card_eq`) — a usable prime. (The standing field's stable prime, where
`hram` fails, is FS131-IU1's `data/fs131/iu1/lean/Models.lean`.) Each theorem below applies one headline at its model;
`#print axioms` then shows what the model itself rests on.
-/
open HadwigerNelson HadwigerNelson.Arith HadwigerNelson.SpectralChain HadwigerNelson.SquareClass HadwigerNelson.UpperHalf
  SimpleGraph NumberField

namespace FS131IV1Models

/-- `StablePrime ⊥` is inhabited. -/
theorem stablePrime_rat_model : Nonempty (StablePrime (⊥ : Subfield ℝ)) :=
  let ⟨P, _⟩ := exists_stablePrime_rat; ⟨P⟩

/-- **`colorable_two_planeOver_of_ramified` at its inhabitant**: `[NumberField F]`, `P : StablePrime F` and `hram` all hold at
`ℚ`, and the conclusion is two colours for the rational plane. -/
theorem two_colour_model : ((unitDistance ℂ).induce (planeOver ⊥)).Colorable 2 :=
  let ⟨P, _, hram⟩ := exists_stablePrime_rat
  colorable_two_planeOver_of_ramified P hram

/-- **`two_mem_of_conj_trivial` at its inhabitant**: the same `P` and `hram`; its conclusion `2 ∈ P` is here obtained from
the theorem, not from `exists_stablePrime_rat`'s own second clause. -/
theorem two_mem_model : ∃ P : StablePrime (⊥ : Subfield ℝ),
    (∀ x : 𝓞 (fieldI (⊥ : Subfield ℝ)), conjO ⊥ x - x ∈ P.P) ∧ (2 : 𝓞 (fieldI (⊥ : Subfield ℝ))) ∈ P.P :=
  let ⟨P, _, hram⟩ := exists_stablePrime_rat
  ⟨P, hram, two_mem_of_conj_trivial P hram⟩

/-- `exists_hom_levelTarget` at `ℚ`, every level `m ≥ 1`. -/
theorem hom_rat_model : ∃ P : StablePrime (⊥ : Subfield ℝ), ∀ m : ℕ, 1 ≤ m →
    Nonempty ((unitDistance ℂ).induce (planeOver ⊥) →g levelTarget P m) :=
  let ⟨P, _⟩ := exists_stablePrime_rat
  ⟨P, fun _ hm => let ⟨h, _⟩ := exists_hom_levelTarget P hm; ⟨h⟩⟩

/-- `exists_stablePrime_of_valuationSubring` at `ℚ`: `𝓞_P` satisfies its hypotheses and a stable prime with that
localization comes back. -/
theorem converse_rat_model : ∃ P Q : StablePrime (⊥ : Subfield ℝ), Q.localRing = P.localRing :=
  let ⟨P, _⟩ := exists_stablePrime_rat
  let ⟨Q, hQ⟩ := exists_stablePrime_of_valuationSubring P.localRing (localRing_ne_top P) (conj_mem_localRing P)
  ⟨P, Q, hQ⟩

/-- Row 105 over the stable primes at `ℚ`, `n = 2`: a stable prime holds 2, so `1/2` is not in the ring of unit vectors
of the rational plane. -/
theorem wall_rat_model : (2 : ℂ)⁻¹ ∉ UnitRing.unitRingOver (⊥ : Subfield ℝ) := by
  obtain ⟨P, hP, _⟩ := exists_stablePrime_rat
  intro h
  have h2 := (inv_natCast_mem_unitRingOver_iff_forall_stablePrime ⊥ (n := 2) two_ne_zero).1 (by simpa using h) P
  exact h2 (by simpa using hP)

/-- `χ(ℚ²) ≤ L(ℚ)`, with `L(ℚ)` an infimum over an inhabited family. -/
theorem localBound_rat_model : ((unitDistance ℂ).induce (planeOver ⊥)).chromaticNumber ≤ localBound ⊥ :=
  chromaticNumber_planeOver_le_localBound ⊥

/-- **`IsUsablePrime` is inhabited** — `ℚ(√11)` at 7 — and the NF1-S1A bound applies there:
`χ(ℚ(√11)²) ≤ χ(UD(𝔽₇, 2))`. -/
theorem usablePrime_model : ∃ 𝔭 : Ideal (𝓞 (fieldOfRadicands {11})), IsUsablePrime 𝔭 ∧
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {11}))).chromaticNumber ≤ (finitePlane 7).chromaticNumber :=
  let ⟨𝔭, hmax, hcard⟩ := QuadraticPrime.exists_maximal_card_eq {11} (p := 7) (by norm_num) (by norm_num)
    (by rintro d rfl; exact ⟨by decide, ⟨2, by decide⟩⟩)
  ⟨𝔭, ⟨hmax, by rw [hcard]⟩,
    chromaticNumber_planeOver_le_finitePlane (fieldOfRadicands {11}) ⟨hmax, by rw [hcard]⟩ (by norm_num) hcard⟩

/-- The ramified clause at its model: `K = ℚ(√3, √11)` at 11 (`3 ≡ 5²`, `11 ∣ 11`, `121 ∤ 11`). -/
theorem ramified_model : ∃ 𝔭 : Ideal (𝓞 (fieldOfRadicands (insert 11 {3}))), 𝔭.IsMaximal ∧
    Nat.card (𝓞 (fieldOfRadicands (insert 11 {3})) ⧸ 𝔭) = 11 :=
  QuadraticPrime.exists_maximal_card_eq_of_ramified {3} 11 (p := 11) (by norm_num) (by norm_num)
    (by rintro d rfl; exact ⟨by decide, ⟨5, by decide⟩⟩) (dvd_refl 11) (by norm_num)

end FS131IV1Models

set_option pp.fullNames true
#print axioms HadwigerNelson.UpperHalf.exists_stablePrime_rat
#print axioms HadwigerNelson.UpperHalf.instNumberFieldBot
#print axioms FS131IV1Models.stablePrime_rat_model
#print axioms FS131IV1Models.two_colour_model
#print axioms FS131IV1Models.two_mem_model
#print axioms FS131IV1Models.hom_rat_model
#print axioms FS131IV1Models.converse_rat_model
#print axioms FS131IV1Models.wall_rat_model
#print axioms FS131IV1Models.localBound_rat_model
#print axioms FS131IV1Models.usablePrime_model
#print axioms FS131IV1Models.ramified_model

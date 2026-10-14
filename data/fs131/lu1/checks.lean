import Proofs
/-!
FS131-LU1 — the landing's iteration file: the headline statements as the kernel holds them (`#check`), the axioms of
each headline and of the kernel theorem that holds the other half of each exact value, and a model of every
hypothesis-shaped headline. Never part of the library; elaborated by the gate's pass on the gated commit
(`lake env lean -DautoImplicit=false -DrelaxedAutoImplicit=false data/fs131/lu1/checks.lean`).

The model terms at `ℚ` and at `ℚ(√11)` are FS131-IV1's (`data/fs131/iv1/lean/Models.lean`), those at the standing field
FS131-IU1's (`data/fs131/iu1/lean/Models.lean`), copied under one namespace; the terms marked LU1 are this job's.
-/
open HadwigerNelson HadwigerNelson.Arith HadwigerNelson.SpectralChain HadwigerNelson.SquareClass HadwigerNelson.UpperHalf
  HadwigerNelson.StandingFive SimpleGraph NumberField

namespace FS131LU1

/-! ## At `ℚ`: the stable prime above 2 — the one inhabitant of `hram` the library holds -/

/-- `StablePrime ⊥` is inhabited, so `localBound ⊥` is an infimum over an inhabited family. -/
theorem stablePrime_rat_model : Nonempty (StablePrime (⊥ : Subfield ℝ)) :=
  let ⟨P, _⟩ := exists_stablePrime_rat; ⟨P⟩

/-- `colorable_two_planeOver_of_ramified` at its inhabitant: `[NumberField F]`, `P : StablePrime F` and `hram` at once. -/
theorem two_colour_model : ((unitDistance ℂ).induce (planeOver ⊥)).Colorable 2 :=
  let ⟨P, _, hram⟩ := exists_stablePrime_rat
  colorable_two_planeOver_of_ramified P hram

/-- `two_mem_of_conj_trivial` at its inhabitant; `2 ∈ P` here comes from the theorem. -/
theorem two_mem_model : ∃ P : StablePrime (⊥ : Subfield ℝ),
    (∀ x : 𝓞 (fieldI (⊥ : Subfield ℝ)), conjO ⊥ x - x ∈ P.P) ∧ (2 : 𝓞 (fieldI (⊥ : Subfield ℝ))) ∈ P.P :=
  let ⟨P, _, hram⟩ := exists_stablePrime_rat
  ⟨P, hram, two_mem_of_conj_trivial P hram⟩

/-- `exists_hom_levelTarget` at `ℚ`, every level `m ≥ 1`: a homomorphism INTO the level target. -/
theorem hom_rat_model : ∃ P : StablePrime (⊥ : Subfield ℝ), ∀ m : ℕ, 1 ≤ m →
    Nonempty ((unitDistance ℂ).induce (planeOver ⊥) →g levelTarget P m) :=
  let ⟨P, _⟩ := exists_stablePrime_rat
  ⟨P, fun _ hm => let ⟨h, _⟩ := exists_hom_levelTarget P hm; ⟨h⟩⟩

/-- `exists_stablePrime_of_valuationSubring` at `ℚ`: `𝓞_P` satisfies both hypotheses. -/
theorem converse_rat_model : ∃ P Q : StablePrime (⊥ : Subfield ℝ), Q.localRing = P.localRing :=
  let ⟨P, _⟩ := exists_stablePrime_rat
  let ⟨Q, hQ⟩ := exists_stablePrime_of_valuationSubring P.localRing (localRing_ne_top P) (conj_mem_localRing P)
  ⟨P, Q, hQ⟩

/-- Row 105 over the stable primes at `ℚ`, `n = 2`: the right side fails, so `1/2 ∉ ℤ[U_ℚ]`. -/
theorem wall_rat_model : (2 : ℂ)⁻¹ ∉ UnitRing.unitRingOver (⊥ : Subfield ℝ) := by
  obtain ⟨P, hP, _⟩ := exists_stablePrime_rat
  intro h
  have h2 := (inv_natCast_mem_unitRingOver_iff_forall_stablePrime ⊥ (n := 2) two_ne_zero).1 (by simpa using h) P
  exact h2 (by simpa using hP)

/-- `χ(ℚ²) ≤ L(ℚ)`. -/
theorem localBound_rat_model : ((unitDistance ℂ).induce (planeOver ⊥)).chromaticNumber ≤ localBound ⊥ :=
  chromaticNumber_planeOver_le_localBound ⊥

/-- LU1. With the value: `2 ≤ L(ℚ)` — the upper half and `χ(ℚ²) = 2` composed. That `L(ℚ)` is finite is not here. -/
theorem two_le_localBound_rat : (2 : ℕ∞) ≤ localBound ⊥ :=
  chromaticNumber_planeOver_rat ▸ chromaticNumber_planeOver_le_localBound ⊥

/-! ## At the standing field: a second number field with a stable prime, where `hram` FAILS -/

/-- `StablePrime F` with `[NumberField F]` at another field. -/
theorem stablePrime_standing_model : Nonempty (StablePrime standingField) :=
  let ⟨P, _⟩ := exists_stablePrime_two; ⟨P⟩

/-- `exists_hom_levelTarget` at the standing field. -/
theorem hom_standing_model : ∃ P : StablePrime standingField, ∀ m : ℕ, 1 ≤ m →
    Nonempty ((unitDistance ℂ).induce (planeOver standingField) →g levelTarget P m) :=
  let ⟨P, _⟩ := exists_stablePrime_two
  ⟨P, fun _ hm => let ⟨h, _⟩ := exists_hom_levelTarget P hm; ⟨h⟩⟩

/-- Row 105's iff with both sides true: `n = 1`. -/
theorem one_standing_model : ∀ P : StablePrime standingField, ((1 : ℕ) : 𝓞 (fieldI standingField)) ∉ P.P :=
  (inv_natCast_mem_unitRingOver_iff_forall_stablePrime standingField (n := 1) one_ne_zero).1 (by simp)

/-- `hram` is a real condition: at the standing field it fails at every stable prime. -/
theorem hram_fails_at_standingField (P : StablePrime standingField) :
    ¬ ∀ x : 𝓞 (fieldI standingField), conjO standingField x - x ∈ P.P := fun h =>
  let ⟨x, hx⟩ := exists_conjO_sub_notMem P; hx (h x)

/-! ## A usable prime: `ℚ(√11)` at 7 — the library's first model of `IsUsablePrime` -/

/-- `IsUsablePrime` is inhabited, with `Nat.card = p` and `p` prime, and both NF1-S1A bounds apply there. -/
theorem usablePrime_model : ∃ 𝔭 : Ideal (𝓞 (fieldOfRadicands {11})), IsUsablePrime 𝔭 ∧
    Nat.card (𝓞 (fieldOfRadicands {11}) ⧸ 𝔭) = 7 ∧
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {11}))).chromaticNumber
      ≤ (unitQuadrance (𝓞 (fieldOfRadicands {11}) ⧸ 𝔭)).chromaticNumber ∧
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {11}))).chromaticNumber ≤ (finitePlane 7).chromaticNumber :=
  let ⟨𝔭, hmax, hcard⟩ := QuadraticPrime.exists_maximal_card_eq {11} (p := 7) (by norm_num) (by norm_num)
    (by rintro d rfl; exact ⟨by decide, ⟨2, by decide⟩⟩)
  ⟨𝔭, ⟨hmax, by rw [hcard]⟩, hcard,
    chromaticNumber_planeOver_le_unitQuadrance (fieldOfRadicands {11}) ⟨hmax, by rw [hcard]⟩,
    chromaticNumber_planeOver_le_finitePlane (fieldOfRadicands {11}) ⟨hmax, by rw [hcard]⟩ (by norm_num) hcard⟩

/-- LU1. The planner's remark, as a term: a usable prime whose quotient has `p` elements has `p ≡ 3 (mod 4)`; the second
clause of NF1-S1A does not say so and need not. -/
theorem usable_card_mod_four {F : Subfield ℝ} {𝔭 : Ideal (𝓞 F)} (h𝔭 : IsUsablePrime 𝔭) {p : ℕ}
    (hcard : Nat.card (𝓞 F ⧸ 𝔭) = p) : p % 4 = 3 := hcard ▸ h𝔭.2

/-! ## The ramified clause -/

/-- The ramified clause at its model: `K = ℚ(√3, √11)` at 11 — every hypothesis at once. -/
theorem ramified_model : ∃ 𝔭 : Ideal (𝓞 (fieldOfRadicands (insert 11 {3}))), 𝔭.IsMaximal ∧
    Nat.card (𝓞 (fieldOfRadicands (insert 11 {3})) ⧸ 𝔭) = 11 :=
  QuadraticPrime.exists_maximal_card_eq_of_ramified {3} 11 (p := 11) (by norm_num) (by norm_num)
    (by rintro d rfl; exact ⟨by decide, ⟨5, by decide⟩⟩) (dvd_refl 11) (by norm_num)

/-- LU1. The reader's note on `exists_maximal_card_eq_of_ramified`, as a term: `hD` and `hq` can hold together only when
the divisible radicand is outside the set. -/
theorem ramified_radicand_notMem {D : Set ℕ} {q p : ℕ} (hD : ∀ d ∈ D, (d : ZMod p) ≠ 0 ∧ IsSquare (d : ZMod p))
    (hq : p ∣ q) : q ∉ D := fun h => (hD q h).1 ((ZMod.natCast_eq_zero_iff q p).2 hq)

/-- LU1. …and `hq2` excludes `q = 0`. -/
theorem ramified_radicand_ne_zero {q p : ℕ} (hq2 : ¬ p ^ 2 ∣ q) : q ≠ 0 := fun h => hq2 (h ▸ dvd_zero _)

/-- LU1. The dated line's counterexample is refused by the hypotheses: `2` is not a square modulo `11`, so no `D ∋ 2`
satisfies `hD` at `p = 11` — `ℚ(√11, √22) = ℚ(√11, √2)` is not an instance. -/
theorem two_notMem_of_hD {D : Set ℕ} (hD : ∀ d ∈ D, (d : ZMod 11) ≠ 0 ∧ IsSquare (d : ZMod 11)) : 2 ∉ D :=
  fun h => (by decide : ¬ IsSquare ((2 : ℕ) : ZMod 11)) (hD 2 h).2

end FS131LU1

/-! ## The headline statements as the kernel holds them -/
set_option pp.fullNames true
#check @HadwigerNelson.UpperHalf.nonempty_hom_unitQuadrance
#check @HadwigerNelson.UpperHalf.chromaticNumber_planeOver_le_unitQuadrance
#check @HadwigerNelson.UpperHalf.chromaticNumber_planeOver_le_finitePlane
#check @HadwigerNelson.UpperHalf.exists_hom_levelTarget
#check @HadwigerNelson.UpperHalf.nonempty_hom_levelTarget_one
#check @HadwigerNelson.UpperHalf.chromaticNumber_planeOver_le_levelTarget
#check @HadwigerNelson.UpperHalf.chromaticNumber_planeOver_le_localBound
#check @HadwigerNelson.UpperHalf.chromaticNumber_eq_localBound_of_chain
#check @HadwigerNelson.SpectralChain.chromaticNumber_eq_localBound
#check @HadwigerNelson.UpperHalf.two_mem_of_conj_trivial
#check @HadwigerNelson.UpperHalf.colorable_two_planeOver_of_ramified
#check @HadwigerNelson.UpperHalf.exists_stablePrime_of_valuationSubring
#check @HadwigerNelson.UpperHalf.inv_natCast_mem_unitRingOver_iff_forall_stablePrime
#check @HadwigerNelson.QuadraticPrime.numberField_fieldOfRadicands
#check @HadwigerNelson.QuadraticPrime.exists_maximal_card_of_padic
#check @HadwigerNelson.QuadraticPrime.exists_maximal_card_eq
#check @HadwigerNelson.QuadraticPrime.exists_maximal_card_eq_sqrt
#check @HadwigerNelson.QuadraticPrime.nonempty_ringHom_zmod_of_ramified_sqrt
#check @HadwigerNelson.QuadraticPrime.exists_maximal_card_eq_of_ramified
#check @HadwigerNelson.UpperHalf.colorable_planeOver_fieldOfRadicands
#check @HadwigerNelson.UpperHalf.chromaticNumber_planeOver_eleven
#check @HadwigerNelson.UpperHalf.chromaticNumber_planeOver_sqrt167_le_eight
#check @HadwigerNelson.UpperHalf.chromaticNumber_planeOver_sqrt47_le_five_of_prime
#check @HadwigerNelson.UpperHalf.two_le_chromaticNumber_planeOver
#check @HadwigerNelson.UpperHalf.exists_stablePrime_rat
#check @HadwigerNelson.UpperHalf.chromaticNumber_planeOver_rat

/-! ## Their axioms -/
#print axioms HadwigerNelson.UpperHalf.chromaticNumber_planeOver_le_unitQuadrance
#print axioms HadwigerNelson.UpperHalf.chromaticNumber_planeOver_le_finitePlane
#print axioms HadwigerNelson.UpperHalf.exists_hom_levelTarget
#print axioms HadwigerNelson.UpperHalf.nonempty_hom_levelTarget_one
#print axioms HadwigerNelson.UpperHalf.chromaticNumber_planeOver_le_localBound
#print axioms HadwigerNelson.UpperHalf.chromaticNumber_eq_localBound_of_chain
#print axioms HadwigerNelson.UpperHalf.colorable_two_planeOver_of_ramified
#print axioms HadwigerNelson.UpperHalf.exists_stablePrime_of_valuationSubring
#print axioms HadwigerNelson.UpperHalf.inv_natCast_mem_unitRingOver_iff_forall_stablePrime
#print axioms HadwigerNelson.QuadraticPrime.exists_maximal_card_eq
#print axioms HadwigerNelson.QuadraticPrime.exists_maximal_card_eq_sqrt
#print axioms HadwigerNelson.QuadraticPrime.exists_maximal_card_eq_of_ramified
#print axioms HadwigerNelson.UpperHalf.colorable_planeOver_fieldOfRadicands
#print axioms HadwigerNelson.UpperHalf.chromaticNumber_planeOver_eleven
#print axioms HadwigerNelson.UpperHalf.chromaticNumber_planeOver_sqrt167_le_eight
#print axioms HadwigerNelson.UpperHalf.chromaticNumber_planeOver_sqrt47_le_five_of_prime
#print axioms HadwigerNelson.UpperHalf.exists_stablePrime_rat
#print axioms HadwigerNelson.UpperHalf.chromaticNumber_planeOver_rat

/-! ## The other half of each value, and what each instance reads — older kernel theorems, by name -/
#print axioms HadwigerNelson.four_le_chromaticNumber_planeOver_eleven
#print axioms HadwigerNelson.finitePlane7_colorable_four
#print axioms HadwigerNelson.UpperHalf.two_le_chromaticNumber_planeOver
#print axioms HadwigerNelson.colorable_two_unitDistance_induce_of_valuationSubring
#print axioms HadwigerNelson.four_le_chromaticNumber_planeOver_sqrt167
#print axioms HadwigerNelson.CayleyCert.colorable_finitePlane23_eight
#print axioms HadwigerNelson.SqrtFortySeven.chromaticNumber_planeOver_sqrt47_le_five
#print axioms HadwigerNelson.chromaticNumber_finitePlane11
#print axioms HadwigerNelson.StandingFive.exists_stablePrime_two
#print axioms HadwigerNelson.StandingFive.exists_conjO_sub_notMem

/-! ## The models -/
#print axioms FS131LU1.stablePrime_rat_model
#print axioms FS131LU1.two_colour_model
#print axioms FS131LU1.two_mem_model
#print axioms FS131LU1.hom_rat_model
#print axioms FS131LU1.converse_rat_model
#print axioms FS131LU1.wall_rat_model
#print axioms FS131LU1.localBound_rat_model
#print axioms FS131LU1.two_le_localBound_rat
#print axioms FS131LU1.stablePrime_standing_model
#print axioms FS131LU1.hom_standing_model
#print axioms FS131LU1.one_standing_model
#print axioms FS131LU1.hram_fails_at_standingField
#print axioms FS131LU1.usablePrime_model
#print axioms FS131LU1.usable_card_mod_four
#print axioms FS131LU1.ramified_model
#print axioms FS131LU1.ramified_radicand_notMem
#print axioms FS131LU1.ramified_radicand_ne_zero
#print axioms FS131LU1.two_notMem_of_hD

/-! ## The control is the same statement (LU1)

`SqrtFortySeven.F47` is an `abbrev` for `fieldOfRadicands {47}`: the two theorems prove one proposition, so an equation
between the two proofs typechecks (by proof irrelevance) exactly when their statements are definitionally one. -/
example : @HadwigerNelson.UpperHalf.chromaticNumber_planeOver_sqrt47_le_five_of_prime =
    @HadwigerNelson.SqrtFortySeven.chromaticNumber_planeOver_sqrt47_le_five := rfl
#check @HadwigerNelson.SqrtFortySeven.chromaticNumber_planeOver_sqrt47_le_five

/-! ## A fact two of the module's records state about Mathlib at the pin (LU1: checked once more)

The coercion `𝓞 K → K` is `RingOfIntegers.val`, a reducible definition unfolding to `algebraMap (𝓞 K) K`. -/
#print NumberField.RingOfIntegers.val
example (K : Type*) [Field K] (a : 𝓞 K) : (a : K) = NumberField.RingOfIntegers.val a := rfl

import Proofs.HadwigerNelson.Arith.UpperHalf
import Proofs.HadwigerNelson.Arith.QuadraticPrime
import Proofs.HadwigerNelson.Instances.UpperHalfValues
import Proofs.HadwigerNelson.Arith.ThreeColourCriterion
import Proofs.HadwigerNelson.Arith.DyadicQuadratic
import Proofs.HadwigerNelson.PlaneRotation
import Proofs.HadwigerNelson.Instances.PlaneFreedom

/-!
# Three and four colours over real number fields: the joining module (FS-131, NF4 with NF1; planned by FS131-KN4)

**PLANNED TEXT — not in the library.** It imports `Arith/UpperHalf`, `Arith/QuadraticPrime` and
`Instances/UpperHalfValues` (line `fs131-wnf`, NF1) and `Arith/ThreeColourCriterion` (line `fs131-wr2`, NF4), so it
becomes `Proofs/HadwigerNelson/Arith/ThreeFourColours.lean` at the join of the two lines. Its statements are elaborated
against both lines' skeletons by `data/fs131/kn4/join_check.sh`.

**Read aloud, against the claim** (`data/fs131/claims-NF4.md`, NF4-THEOREM).
* (b) *"For every real number field `F` whose plane is not bipartite: `χ(F²) = 3` iff some prime of `F` above 3 has
  residue field `𝔽₃`."* — `chromaticNumber_planeOver_eq_three_iff`; without the hypothesis, FS91-J02-T2's form
  `colorable_three_planeOver_iff`.
* (a), the table — one theorem per row, each naming the upper half it reads (every upper half is prior art:
  `[Fischer1990]`, `[Johnson2000]`; at the level of a field it is NF1's).
* Row 99 in the form row 127 takes — `localBound_le_chromaticNumber_of_le_four`.
-/

namespace HadwigerNelson.ThreeFourColours

open HadwigerNelson HadwigerNelson.Arith HadwigerNelson.SpectralChain HadwigerNelson.CharacterColouring
  HadwigerNelson.SquareClass HadwigerNelson.ThreeColourCriterion HadwigerNelson.DyadicQuadratic HadwigerNelson.UpperHalf
  SimpleGraph NumberField

section Dictionary

variable {F : Subfield ℝ} [NumberField F]

/-- **J1 — a maximal ideal of `ℤ[U_F]` is cut out by a stable prime of `F(i)`** (FS91-J02-L2(b)): the ring lies in the
local ring `𝓞_P`, and the ideal is the ring's part of the maximal ideal of `𝓞_P`. (`𝔪 ≠ ⊥`: were `ℤ[U_F]` a field the
statement would fail; that it never is needs Chebotarev, which no consumer here needs — each has `2` or `3` in `𝔪`.) -/
theorem exists_stablePrime_of_maximal {𝔪 : Ideal (unitRing F)} (h𝔪 : 𝔪.IsMaximal) (hne : 𝔪 ≠ ⊥) :
    ∃ P : StablePrime F, ∃ hle : ∀ x : unitRing F, unitRingToFieldI F x ∈ P.localRing,
      ∀ x : unitRing F, x ∈ 𝔪 ↔ P.residue 1 ⟨unitRingToFieldI F x, hle x⟩ = 0 := by
  sorry

/-- **J2 — every norm-one residue is the residue of a unit vector** (FS91-J02-L2(c); NF4-S9 at level one): for
`t ∈ 𝓞 ⧸ P` with `t·t̄ = 1` some `x ∈ ℤ[U_F]`, a unit vector, reduces to `t`. -/
theorem exists_unitSet_residue_eq (P : StablePrime F) (hle : ∀ x : unitRing F, unitRingToFieldI F x ∈ P.localRing)
    {t : 𝓞 (fieldI F) ⧸ P.P ^ 1}
    (ht : t * Ideal.quotientMap (P.P ^ 1) (conjO F) (P.le_comap 1) t = 1) :
    ∃ u ∈ unitSet F, P.residue 1 ⟨unitRingToFieldI F u, hle u⟩ = t := by
  sorry

/-- **J3 — nine elements in the ring, three in `𝓞 F`.** A maximal ideal of `ℤ[U_F]` with nine elements in its quotient
gives a maximal ideal of `𝓞 F` with three. -/
theorem exists_maximal_card_three_of_card_nine {𝔪 : Ideal (unitRing F)} (h𝔪 : 𝔪.IsMaximal)
    (h9 : Nat.card (unitRing F ⧸ 𝔪) = 9) : ∃ 𝔭 : Ideal (𝓞 F), 𝔭.IsMaximal ∧ Nat.card (𝓞 F ⧸ 𝔭) = 3 := by
  sorry

/-- **J4 — trivial conjugation in the ring, trivial conjugation at a stable prime.** -/
theorem exists_stablePrime_conj_trivial {𝔪 : Ideal (unitRing F)} (h𝔪 : 𝔪.IsMaximal)
    (htriv : ∀ x, conjR F x - x ∈ 𝔪) : ∃ P : StablePrime F, ∀ x : 𝓞 (fieldI F), conjO F x - x ∈ P.P := by
  sorry

end Dictionary

/-! ## Clause (b) -/

/-- A maximal ideal of `𝓞 F` with three elements in its quotient gives a three-colouring (the upper half, NF1-S1A at
`Γ₃`; prior art). -/
theorem colorable_three_of_card_three (F : Subfield ℝ) [NumberField F] {𝔭 : Ideal (𝓞 F)} (h𝔭 : 𝔭.IsMaximal)
    (hcard : Nat.card (𝓞 F ⧸ 𝔭) = 3) : ((unitDistance ℂ).induce (planeOver F)).Colorable 3 :=
  colorable_planeOver_of_finitePlane F ⟨h𝔭, by rw [hcard]⟩ Nat.prime_three hcard finitePlane3_colorable_three

/-- **FS91-J02-T2 (S1), `(1) ⟺ (4)`**: the plane over a real number field is three-colourable iff it is two-colourable
or some prime of `F` has residue field `𝔽₃`. Rests on Weil's bound (⟹). -/
theorem colorable_three_planeOver_iff (F : Subfield ℝ) [NumberField F] :
    ((unitDistance ℂ).induce (planeOver F)).Colorable 3 ↔
      ((unitDistance ℂ).induce (planeOver F)).Colorable 2 ∨
        ∃ 𝔭 : Ideal (𝓞 F), 𝔭.IsMaximal ∧ Nat.card (𝓞 F ⧸ 𝔭) = 3 := by
  sorry

/-- **Clause (b), as claimed.** For a real number field `F` whose plane is not bipartite: `χ(F²) = 3` iff some prime of
`F` has residue field `𝔽₃`. Rests on Weil's bound (⟹). -/
theorem chromaticNumber_planeOver_eq_three_iff (F : Subfield ℝ) [NumberField F]
    (hnb : ¬ ((unitDistance ℂ).induce (planeOver F)).Colorable 2) :
    ((unitDistance ℂ).induce (planeOver F)).chromaticNumber = 3 ↔
      ∃ 𝔭 : Ideal (𝓞 F), 𝔭.IsMaximal ∧ Nat.card (𝓞 F ⧸ 𝔭) = 3 := by
  sorry

/-! ## Row 99 in the form row 127 takes -/

/-- **Row 99's lower half** (FS91-J02-T3, S2): `L(F) ≤ χ(F²)` or `χ(F²) ≥ 4`, every real number field. -/
theorem localBound_le_chromaticNumber_or_four_le (F : Subfield ℝ) [NumberField F] :
    localBound F ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber ∨
      4 ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber := by
  sorry

/-- **`hRow99` of `SpectralChain.min_localBound_five_le_chromaticNumber`, discharged.** -/
theorem localBound_le_chromaticNumber_of_le_four (F : Subfield ℝ) [NumberField F] (h : localBound F ≤ 4) :
    localBound F ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber :=
  (localBound_le_chromaticNumber_or_four_le F).elim id fun h4 => h.trans h4

/-! ## Clause (a): the table for real quadratic fields, one theorem per row -/

/-- **The row at 3**: `χ(ℚ(√m)²) = 3` for squarefree `m ≡ 3, 7 (mod 12)`. Upper half: `[Fischer1990]` Thm 9, here
NF1-S2 at 3 (`m ≡ 1 (mod 3)`) and its ramified clause (`3 ∣ m`). Lower half: `not_colorable_two_of_sqrt_mem`. -/
theorem chromaticNumber_planeOver_sqrt_eq_three {m : ℕ} (hm : Squarefree m) (h : m % 12 = 3 ∨ m % 12 = 7) :
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {m}))).chromaticNumber = 3 := by
  sorry

/-- **The row at 4, through a prime above 7**: squarefree `m ≡ 11 (mod 12)` with `m` a square modulo 7. Upper half:
NF1-S2 at 7 and `finitePlane7_colorable_four` (prior art). Lower half: this project's
`TorsionExtraction.four_le_chromaticNumber_planeOver_fieldOfRadicands`. -/
theorem chromaticNumber_planeOver_sqrt_eq_four_of_seven {m : ℕ} (hm : Squarefree m) (h12 : m % 12 = 11)
    (h7 : m % 7 = 0 ∨ m % 7 = 1 ∨ m % 7 = 2 ∨ m % 7 = 4) :
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {m}))).chromaticNumber = 4 := by
  sorry

/-- **The row at 4, through the dyadic prime**: `χ(ℚ(√m)²) = 4` for `m ≡ 11 (mod 24)`. Upper half:
`DyadicQuadratic.colorable_four_planeOver_sqrt` (prior art). Lower half: this project's. -/
theorem chromaticNumber_planeOver_sqrt_eq_four_of_dyadic {m : ℕ} (h24 : m % 24 = 11) :
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {m}))).chromaticNumber = 4 :=
  le_antisymm (colorable_four_planeOver_sqrt (by omega)).chromaticNumber_le
    (TorsionExtraction.four_le_chromaticNumber_planeOver_fieldOfRadicands (by omega))

/-- **The row at 2**: `χ(ℚ(√m)²) = 2` for squarefree `m ≢ 3 (mod 4)` (`[Fischer1990]`, `[Johnson2000]`; prior art). -/
theorem chromaticNumber_planeOver_sqrt_eq_two {m : ℕ} (hm : Squarefree m) (h4 : m % 4 ≠ 3) :
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {m}))).chromaticNumber = 2 :=
  le_antisymm (colorable_two_planeOver_sqrt hm h4).chromaticNumber_le (two_le_chromaticNumber_planeOver _)

/-! ## The two dyadic primes themselves (NF4-DYADIC-TWO, NF4-DYADIC-FOUR in the claim's words) -/

/-- **NF4-DYADIC-TWO, as worded**: for squarefree `m ≢ 3 (mod 4)` a stable prime of `ℚ(√m)(i)` modulo which conjugation
is the identity — ramified over `ℚ(√m)`, and above 2 (`two_mem_of_conj_trivial`). A corollary of the two-colouring
through the two-colour end and J4. -/
theorem exists_stablePrime_ramified_sqrt {m : ℕ} (hm : Squarefree m) (h4 : m % 4 ≠ 3) :
    ∃ P : StablePrime (fieldOfRadicands {m}),
      ∀ x : 𝓞 (fieldI (fieldOfRadicands {m})), conjO (fieldOfRadicands {m}) x - x ∈ P.P := by
  obtain ⟨𝔪, h𝔪, htriv⟩ := exists_maximal_conj_trivial_of_colorable_two _ (colorable_two_planeOver_sqrt hm h4)
  exact exists_stablePrime_conj_trivial h𝔪 htriv

/-- **NF4-DYADIC-FOUR, as worded**: for `m ≡ 3 (mod 8)` a stable prime of `ℚ(√m)(i)` above 2 with four elements in its
quotient (its target has four vertices). -/
theorem exists_stablePrime_card_four_sqrt {m : ℕ} (h8 : m % 8 = 3) :
    ∃ P : StablePrime (fieldOfRadicands {m}), (2 : 𝓞 (fieldI (fieldOfRadicands {m}))) ∈ P.P ∧
      Nat.card (𝓞 (fieldI (fieldOfRadicands {m})) ⧸ P.P ^ 1) = 4 := by
  sorry

end HadwigerNelson.ThreeFourColours

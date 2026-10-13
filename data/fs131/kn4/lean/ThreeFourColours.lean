import Proofs.HadwigerNelson.Arith.UpperHalf
import Proofs.HadwigerNelson.Arith.QuadraticPrime
import Proofs.HadwigerNelson.Instances.UpperHalfValues
import Proofs.HadwigerNelson.Arith.ThreeColourCriterion
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
  `colorable_three_iff`.
* (a), the table — one theorem per row, each naming the upper half it reads (every upper half is prior art:
  `[Fischer1990]`, `[Johnson2000]`; at the level of a field it is NF1's).
* Row 99 in the form row 127 takes — `localBound_le_chromaticNumber_of_le_four`.
-/

namespace HadwigerNelson.ThreeFourColours

open HadwigerNelson HadwigerNelson.Arith HadwigerNelson.SpectralChain HadwigerNelson.CharacterColouring
  HadwigerNelson.SquareClass HadwigerNelson.ThreeColourCriterion HadwigerNelson.UpperHalf SimpleGraph NumberField

section Dictionary

variable {F : Subfield ℝ} [NumberField F]

/-- **J1 — a maximal ideal of `ℤ[U_F]` is cut out by a stable prime of `F(i)`** (FS91-J02-L2(b)): the ring lies in the
local ring `𝓞_P`, and the ideal is the ring's part of the maximal ideal of `𝓞_P`. -/
theorem exists_stablePrime_of_maximal {𝔪 : Ideal (unitRing F)} (h𝔪 : 𝔪.IsMaximal) :
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
theorem colorable_three_iff (F : Subfield ℝ) [NumberField F] :
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

/-- **The row at 4, through the dyadic prime**: `m ≡ 11 (mod 24)`, given a stable prime of `ℚ(√m)(i)` with four
elements in its quotient (the prime above 2 is inert in `F(i)/F` exactly when `m ≡ 3 (mod 8)`; **NF1 has no leaf for
this family yet**, so it is a hypothesis here). The target has four vertices. -/
theorem chromaticNumber_planeOver_sqrt_eq_four_of_dyadic {m : ℕ} (h24 : m % 24 = 11)
    (hP : ∃ P : StablePrime (fieldOfRadicands {m}), Nat.card (𝓞 (fieldI (fieldOfRadicands {m})) ⧸ P.P ^ 1) = 4) :
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {m}))).chromaticNumber = 4 := by
  sorry

/-- **The row at 2**: given a two-colouring (`[Fischer1990]`, `[Johnson2000]`; at a number field a stable dyadic prime
ramified in `F(i)/F`, which exists for squarefree `m ≢ 3 (mod 4)` — **NF1 has no leaf for this family yet**). -/
theorem chromaticNumber_planeOver_eq_two (F : Subfield ℝ)
    (h2 : ((unitDistance ℂ).induce (planeOver F)).Colorable 2) :
    ((unitDistance ℂ).induce (planeOver F)).chromaticNumber = 2 :=
  le_antisymm h2.chromaticNumber_le (two_le_chromaticNumber_planeOver F)

end HadwigerNelson.ThreeFourColours

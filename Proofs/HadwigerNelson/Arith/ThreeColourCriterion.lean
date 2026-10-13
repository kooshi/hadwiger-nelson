import Proofs.HadwigerNelson.Arith.TorsionExtraction
import Proofs.HadwigerNelson.Arith.WeilKloosterman

/-!
# The three-colour criterion over a real number field, in the unit-vector ring (FS-131, NF4; planner FS131-KN4)

**Read aloud, against the claim** (`data/fs131/claims-NF4.md`, NF4-THEOREM (b)): *"For every real number field `F` whose
plane is not bipartite: `χ(F²) = 3` iff some prime of `F` above 3 has residue field `𝔽₃`."* This module proves the
direction that is this project's — from a three-colouring to the prime — **as far as the ring `ℤ[U_F]`**:
`exists_maximal_card_nine_of_colorable_three`, a maximal ideal of `ℤ[U_F]` with nine elements in its quotient. The last
step (that ideal is cut out by a prime `𝔓` of `F(i)` fixed by conjugation with `𝓞/𝔓 = 𝔽₉`, so `𝔓 ∩ F` has residue field
`𝔽₃`) reads `UpperHalf.exists_stablePrime_of_valuationSubring`, which lives on another line (`fs131-wnf`); it and the
clause as claimed are in the joining module `Arith/ThreeFourColours` (`plans/FS131-KN4-three-four-colours-plan.md` § 4).

**The route** (FS91-J02-T1's ⟹, `plans/FS91-S0F-three-colours.md` §2.6, with two steps shortened by the kernel planner).
`τ ∈ Θ₃ ∩ T₆` (`TorsionExtraction.exists_torsion_mem_fieldBandSet`) splits as `τ₂ = 3τ` on `R/2R` and `τ₃ = −2τ` on
`R/3R`; on a unit vector `(τ₂, τ₃) ∈ {(1/2, 0), (0, ±1/3)}`. For units `x₂`, `x₃` of the two quotients lift `(x₂, x₃)` to
`a ∈ R`; `u = a/ā` is a unit vector reducing to `(x₂/x̄₂, x₃/x̄₃)` (`exists_unit_mul_conj_eq`). So either `τ₃` never
vanishes on `{x/x̄}` in `R/3R`, or `τ₂ = 1/2` on `{x/x̄}` in `R/2R` (`exists_maximal_of_torsion`).
* *Three.* `exists_maximal_card_nine`: compose the functional with a power of Frobenius that kills the nilradical; it
  lives on the reduced quotient, a product of finite fields, and never vanishes on the product of their norm-one groups;
  so on one factor it never vanishes on the norm-one group, a proper additive three-colouring of that factor's target
  `normOneCayley`; **Weil's bound** (`targetFloor_four_weil`) forbids it unless the factor has nine elements.
* *Two.* `exists_maximal_conj_trivial`: the same reduction; a functional equal to 1 on a product of norm-one groups is
  constant on each, the norm-one group `μ_{Q+1}` of `𝔽_{Q²}` sums to 0 and has odd order, so some factor has trivial
  conjugation; then every unit vector is `1` modulo that ideal, and a functional with value 1 at 1 is a two-colouring
  (`fieldBandSet_two_nonempty_of_conj_trivial`).

**Whose this is** (`LEDGER.md` § The claim list and § B, row 99). The three-colour criterion over **every** real number
field is this project's FS91-J02-T2 `[hand; three derivations]`; not found in print; `[Fischer1990]` §1 poses the question.
The two-colour classification over every real number field and the three-colour one for fields containing `√3` are an
outside model's derivation (GPT Astra, `LEDGER.md` § B, the two entries dated 2026-09-14), and
`exists_maximal_conj_trivial_of_colorable_two` is that two-colour theorem's ⟹ in the ring's words (second derivation
FS91-J02-A21p): not claimed as this project's. Every upper bound is prior art and is on `fs131-wnf`.

**Rests on** the declared outside theorem `StandingFive.kloosterman_bound` (`[Weil1948]` p. 207), through
`targetFloor_four_weil`, in `exists_maximal_card_nine` and everything downstream of it; `exists_maximal_conj_trivial`
and the two-colour end do not read it.

**Inhabitants.** The hypotheses of `exists_maximal_card_nine` at `A = 𝔽₉ = 𝔽₃[i]`, conjugation, `l(x + yi) = x + y`
(FS91-J02-L4(a) at `q = 3`: `l ≠ 0` on `μ₄ = {±1, ±i}`); of `exists_maximal_conj_trivial` at `A = 𝔽₂`, the identity and
`l = id`. `exists_maximal_card_nine_of_colorable_three` at `F = ℚ(√3)` (`χ = 3`, `[Fischer1990]` Thm 9), which no
declaration on this line exhibits; `exists_maximal_conj_trivial_of_colorable_two` at `F = ℚ`.
-/

namespace HadwigerNelson.ThreeColourCriterion

open HadwigerNelson.CharacterColouring HadwigerNelson.SpectralChain HadwigerNelson.StandingFive SimpleGraph

/-! ## §1 Finite rings with an involution (no field `F` here) -/

/-- **The floor at four, on Weil's bound**: `χ(Γ_Q) ≥ 4` for `Q ≡ 3 (mod 4)`, `Q ≥ 14` — every `Q = 3^f ≥ 27` with `f`
odd. (`targetFloor_of_charSum` at `m = 2√Q`: `3·2√Q < Q + 1 + 2√Q`.) Rests on the import. -/
theorem targetFloor_four_weil {Q : ℕ} (hQ4 : Q % 4 = 3) (hQ : 14 ≤ Q) : TargetFloor 4 Q := by
  sorry

/-- **The three-part (FS91-J02-L3, L4(a) and T1 step 4, in one finite ring).** A finite commutative ring of
characteristic 3 with an involution `c` fixing each maximal ideal, an element `ι` with `ι² = −1`, `c ι = −ι`, and an
additive functional that never vanishes on `{x / c x : x a unit}`: some maximal ideal has nine elements in its quotient.
Rests on Weil's bound. -/
theorem exists_maximal_card_nine {A : Type} [CommRing A] [Finite A] [CharP A 3] (c : A →+* A) (hcc : ∀ x, c (c x) = x)
    (hmax : ∀ 𝔪 : Ideal A, 𝔪.IsMaximal → 𝔪.comap c = 𝔪) {ι : A} (hι : ι * ι = -1) (hcι : c ι = -ι)
    (l : A →+ ZMod 3) (hl : ∀ x : Aˣ, l ((x : A) * c ((x⁻¹ : Aˣ) : A)) ≠ 0) :
    ∃ 𝔪 : Ideal A, 𝔪.IsMaximal ∧ Nat.card (A ⧸ 𝔪) = 9 := by
  sorry

/-- **The two-part (FS91-J02-L4(b) and T1 step 5).** A finite commutative ring of characteristic 2 with an involution `c`
fixing each maximal ideal and an additive functional equal to 1 on `{x / c x : x a unit}`: `c` is the identity modulo
some maximal ideal. No outside theorem. -/
theorem exists_maximal_conj_trivial {A : Type} [CommRing A] [Finite A] [CharP A 2] (c : A →+* A)
    (hcc : ∀ x, c (c x) = x) (hmax : ∀ 𝔪 : Ideal A, 𝔪.IsMaximal → 𝔪.comap c = 𝔪)
    (l : A →+ ZMod 2) (hl : ∀ x : Aˣ, l ((x : A) * c ((x⁻¹ : Aˣ) : A)) = 1) :
    ∃ 𝔪 : Ideal A, 𝔪.IsMaximal ∧ ∀ x, c x - x ∈ 𝔪 := by
  sorry

/-! ## §2 The unit-vector ring: conjugation, Hilbert 90, primes, finite quotients -/

variable {F : Subfield ℝ}

/-- `ℤ[U_F]` is closed under complex conjugation (its generators are). -/
theorem conj_mem_unitRing {x : ℂ} (hx : x ∈ unitRing F) : (starRingEnd ℂ) x ∈ unitRing F := by
  sorry

/-- **Complex conjugation on `ℤ[U_F]`.** -/
noncomputable def conjR (F : Subfield ℝ) : unitRing F →+* unitRing F :=
  ((starRingEnd ℂ).comp (unitRing F).subtype).codRestrict (unitRing F) fun x => conj_mem_unitRing x.2

@[simp] theorem coe_conjR (x : unitRing F) : ((conjR F x : unitRing F) : ℂ) = (starRingEnd ℂ) (x : ℂ) := rfl

/-- **Hilbert 90 inside the ring**: for `a ≠ 0` in `ℤ[U_F]` the quotient `u = a/ā` is a unit vector, and `u·ā = a`. -/
theorem exists_unit_mul_conj_eq {a : unitRing F} (ha : a ≠ 0) : ∃ u ∈ unitSet F, u * conjR F a = a := by
  sorry

/-- **Every prime ideal of `ℤ[U_F]` is fixed by conjugation** (FS91-J02-L2(b), with no valuation: for `a ∈ 𝔮`,
`a = u·ā` with `u` a unit of the ring, so `ā ∈ 𝔮`). -/
theorem comap_conjR_eq (𝔮 : Ideal (unitRing F)) [𝔮.IsPrime] : 𝔮.comap (conjR F) = 𝔮 := by
  sorry

/-- **`ℤ[U_F]/N` is finite** for a number field `F` and `N ≠ 0` (FS91-J02-L2(a): any `[F(i) : ℚ] + 1` elements of the
ring satisfy a primitive integer relation). -/
theorem finite_quotient_span_natCast (F : Subfield ℝ) [NumberField F] {N : ℕ} (hN : N ≠ 0) :
    Finite (unitRing F ⧸ Ideal.span {(N : unitRing F)}) := by
  sorry

/-! ## §3 The torsion theorem, and the two ends -/

/-- **FS91-J02-T1, ⟹, in the ring.** For a real number field, a point of `Θ₃ ∩ T₆` gives a maximal ideal of `ℤ[U_F]`
modulo which conjugation is the identity (the dyadic type), or one with nine elements in its quotient (the `𝔽₃` type).
Rests on Weil's bound (the second alternative). -/
theorem exists_maximal_of_torsion (F : Subfield ℝ) [NumberField F] {τ : unitRing F →+ UnitAddCircle}
    (hτ : τ ∈ fieldBandSet F (band 3)) (h6 : τ ∈ torsionBy (unitRing F) 6) :
    (∃ 𝔪 : Ideal (unitRing F), 𝔪.IsMaximal ∧ ∀ x, conjR F x - x ∈ 𝔪) ∨
      (∃ 𝔪 : Ideal (unitRing F), 𝔪.IsMaximal ∧ Nat.card (unitRing F ⧸ 𝔪) = 9) := by
  sorry

/-- **A maximal ideal with trivial conjugation is a two-colouring**: every unit vector is `1` modulo it (`u·ū = 1`,
`ū ≡ u`, characteristic 2), so a functional on the quotient with value 1 at 1 is `1/2` on unit vectors. Every subfield
`F ⊆ ℝ`. -/
theorem fieldBandSet_two_nonempty_of_conj_trivial {𝔪 : Ideal (unitRing F)} (h𝔪 : 𝔪.IsMaximal)
    (htriv : ∀ x, conjR F x - x ∈ 𝔪) : (fieldBandSet F (band 2)).Nonempty := by
  sorry

/-- **Clause (b), toward the prime, in the ring.** A real number field whose plane is three-colourable and not
two-colourable has a maximal ideal of `ℤ[U_F]` with nine elements in its quotient. Rests on Weil's bound. -/
theorem exists_maximal_card_nine_of_colorable_three (F : Subfield ℝ) [NumberField F]
    (h3 : ((unitDistance ℂ).induce (planeOver F)).Colorable 3)
    (hnb : ¬ ((unitDistance ℂ).induce (planeOver F)).Colorable 2) :
    ∃ 𝔪 : Ideal (unitRing F), 𝔪.IsMaximal ∧ Nat.card (unitRing F ⧸ 𝔪) = 9 := by
  obtain ⟨τ, hτ, h6⟩ := TorsionExtraction.exists_torsion_mem_fieldBandSet F
    (ThreeColourCharacter.fieldBandSet_three_nonempty_of_colorable F h3)
  rcases exists_maximal_of_torsion F hτ h6 with ⟨𝔪, h𝔪, htriv⟩ | h
  · exact absurd ((TorsionExtraction.colorable_two_iff_fieldBandSet_two_nonempty F).mpr
      (fieldBandSet_two_nonempty_of_conj_trivial h𝔪 htriv)) hnb
  · exact h

/-- **The two-colour end, in the ring** (GPT Astra's Thm 2.1, ⟹; second derivation FS91-J02-A21p — an outside model's
theorem, not this project's): a real number field with a two-colourable plane has a maximal ideal of `ℤ[U_F]` modulo
which conjugation is the identity. With `fieldBandSet_two_nonempty_of_conj_trivial` it is an equivalence. No outside
theorem. -/
theorem exists_maximal_conj_trivial_of_colorable_two (F : Subfield ℝ) [NumberField F]
    (h2 : ((unitDistance ℂ).induce (planeOver F)).Colorable 2) :
    ∃ 𝔪 : Ideal (unitRing F), 𝔪.IsMaximal ∧ ∀ x, conjR F x - x ∈ 𝔪 := by
  sorry

/-! ## Spec -/

-- Models of the two finite theorems' hypotheses on the functional, at the smallest rings.
-- `𝔽₂`, the identity, `l = id`: the only unit is 1 and `l 1 = 1`.
example : ∀ x : (ZMod 2)ˣ,
    (AddMonoidHom.id (ZMod 2)) ((x : ZMod 2) * (RingHom.id (ZMod 2)) ((x⁻¹ : (ZMod 2)ˣ) : ZMod 2)) = 1 := by
  decide
-- The floor's arithmetic: `14` is the least `Q` with `4√Q < Q + 1`, and `27 ≡ 3 (mod 4)`.
example : 16 * 14 < (14 + 1) ^ 2 ∧ ¬ 16 * 13 < (13 + 1) ^ 2 ∧ 27 % 4 = 3 := by norm_num
-- Conjugation on the ring is conjugation.
example (x : unitRing (⊥ : Subfield ℝ)) : ((conjR ⊥ x : unitRing (⊥ : Subfield ℝ)) : ℂ) = (starRingEnd ℂ) (x : ℂ) := rfl

end HadwigerNelson.ThreeColourCriterion

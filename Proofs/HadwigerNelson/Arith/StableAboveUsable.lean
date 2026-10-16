import Proofs.HadwigerNelson.Arith.UpperHalf
import Proofs.HadwigerNelson.Arith.StandingFive
import Mathlib.FieldTheory.Finite.GaloisField

/-!
# A usable prime's plane is a level-one target: `L(F) ≤ χ(Γ_q)` (FS-131, job FS131-KCS1; skeleton)

**Read aloud, against the informal claim** (`CLAUDE.md` § Notation: "**L(F)**, F's *local bound*: the least chromatic number
among the residue targets its conjugation-fixed primes supply"; row 52's upper half). For a real number field `F` and a
usable prime `𝔭` of `F` (residue field `𝔽_q`, `q ≡ 3 (mod 4)`):

* `exists_stablePrime_card_eq_sq` — **some stable prime `P` of `F(i)` has `|𝓞 (F(i)) ⧸ P| = q²`**: the prime above `𝔭`,
  inert in `F(i)` because `−1` is no square in `𝔽_q`.
* `nonempty_hom_levelTarget_one_unitQuadrance` — at an odd stable prime with `Q²` residues, **the level-one target maps
  homomorphically to `Γ_Q` over any field of `Q` elements** (coordinates `x = a + bι`, `a, b` fixed by conjugation).
* `localBound_le_unitQuadrance`, `localBound_le_finitePlane` — **`L(F) ≤ χ(Γ_q)`**: row 52's upper half in `L`'s own words.
  With `UpperHalf.chromaticNumber_planeOver_le_localBound` it recovers `χ(F²) ≤ χ(Γ_q)`
  (`chromaticNumber_planeOver_le_unitQuadrance`), and it is what "`L = 5`" asks at a field with 11 or 19 usable.

**Not claimed:** that the stable prime above `𝔭` is unique, or that every stable prime arises this way (a ramified or a
dyadic inert one does not).

**Inhabitants.** A usable prime: `ℚ(√47)` above 11 (`QuadraticPrime.exists_maximal_card_eq {47}` at `p = 11`).
-/

namespace HadwigerNelson.UpperHalf

open SpectralChain NumberField SimpleGraph Arith

/-! ### The Gaussian valuation subring `B[i]` over a valuation subring `B` of `F` -/

section Gauss

variable {F : Subfield ℝ}

-- The real and imaginary parts of an element of `F(i)`, as elements of `F`.
private def reF (z : fieldI F) : F := ⟨(z : ℂ).re, ((mem_fieldI F).1 z.2).1⟩

private def imF (z : fieldI F) : F := ⟨(z : ℂ).im, ((mem_fieldI F).1 z.2).2⟩

-- `F → F(i)`, `b ↦ b + 0i`.
private def ofF : F →+* fieldI F where
  toFun b := ⟨((b : ℝ) : ℂ), by simp, by simp [zero_mem]⟩
  map_one' := Subtype.ext (by simp)
  map_mul' _ _ := Subtype.ext (by simp)
  map_zero' := Subtype.ext (by simp)
  map_add' _ _ := Subtype.ext (by simp)

-- `i` as an integer of `F(i)`, with its coordinates known (`exists_I_integer` hides the sign).
private noncomputable def iO : 𝓞 (fieldI F) :=
  ⟨⟨Complex.I, by simp [zero_mem], by simp [one_mem]⟩,
    IsIntegral.of_pow (n := 2) (by norm_num) (by
      rw [show (⟨Complex.I, by simp [zero_mem], by simp [one_mem]⟩ : fieldI F) ^ 2 = -1 from Subtype.ext Complex.I_sq]
      exact isIntegral_one.neg)⟩

private theorem coe_iO : (((iO : 𝓞 (fieldI F)) : fieldI F) : ℂ) = Complex.I := rfl

private theorem iO_sq : (iO : 𝓞 (fieldI F)) ^ 2 = -1 :=
  RingOfIntegers.coe_injective (by rw [map_pow, map_neg, map_one]; exact Subtype.ext Complex.I_sq)

private theorem conjO_iO : conjO F (iO : 𝓞 (fieldI F)) = -iO :=
  RingOfIntegers.coe_injective (by rw [map_neg]; exact Subtype.ext Complex.conj_I)

private theorem reF_ofF (b : F) : reF (ofF b) = b := Subtype.ext (by simp [reF, ofF])

private theorem imF_ofF (b : F) : imF (ofF b) = 0 := Subtype.ext (by simp [imF, ofF])

private theorem reF_add (z w : fieldI F) : reF (z + w) = reF z + reF w := Subtype.ext (by simp [reF])

private theorem imF_add (z w : fieldI F) : imF (z + w) = imF z + imF w := Subtype.ext (by simp [imF])

private theorem reF_neg (z : fieldI F) : reF (-z) = -reF z := Subtype.ext (by simp [reF])

private theorem imF_neg (z : fieldI F) : imF (-z) = -imF z := Subtype.ext (by simp [imF])

private theorem reF_mul (z w : fieldI F) : reF (z * w) = reF z * reF w - imF z * imF w :=
  Subtype.ext (by simp [reF, imF])

private theorem imF_mul (z w : fieldI F) : imF (z * w) = reF z * imF w + imF z * reF w :=
  Subtype.ext (by simp [reF, imF])

private theorem reF_inv (z : fieldI F) : reF z⁻¹ = reF z / (reF z ^ 2 + imF z ^ 2) :=
  Subtype.ext (by simp [reF, imF, Complex.inv_re, Complex.normSq_apply, sq])

private theorem imF_inv (z : fieldI F) : imF z⁻¹ = -(imF z / (reF z ^ 2 + imF z ^ 2)) :=
  Subtype.ext (by simp [reF, imF, Complex.inv_im, Complex.normSq_apply, sq, neg_div])

private theorem reF_conj (z : fieldI F) : reF (conjOn (fieldI_conj F) z) = reF z := Subtype.ext (by simp [reF])

private theorem imF_conj (z : fieldI F) : imF (conjOn (fieldI_conj F) z) = -imF z := Subtype.ext (by simp [imF])

-- `z = a + b·i`.
private theorem eq_reF_add (z : fieldI F) : z = ofF (reF z) + ofF (imF z) * ((iO : 𝓞 (fieldI F)) : fieldI F) :=
  Subtype.ext (Complex.ext (by simp [reF, imF, ofF, coe_iO]) (by simp [reF, imF, ofF, coe_iO]))

-- The subring `B[i] = {a + bi : a, b ∈ B}`.
private def gaussSubring (B : ValuationSubring F) : Subring (fieldI F) where
  carrier := {z | reF z ∈ B ∧ imF z ∈ B}
  mul_mem' {z w} hz hw := by
    refine ⟨?_, ?_⟩
    · rw [reF_mul]; exact sub_mem (mul_mem hz.1 hw.1) (mul_mem hz.2 hw.2)
    · rw [imF_mul]; exact add_mem (mul_mem hz.1 hw.2) (mul_mem hz.2 hw.1)
  one_mem' := by
    refine ⟨?_, ?_⟩
    · rw [← map_one ofF, reF_ofF]; exact B.one_mem
    · rw [← map_one ofF, imF_ofF]; exact B.zero_mem
  add_mem' {z w} hz hw := ⟨by rw [reF_add]; exact add_mem hz.1 hw.1, by rw [imF_add]; exact add_mem hz.2 hw.2⟩
  zero_mem' := by
    refine ⟨?_, ?_⟩
    · rw [← map_zero ofF, reF_ofF]; exact B.zero_mem
    · rw [← map_zero ofF, imF_ofF]; exact B.zero_mem
  neg_mem' {z} hz := ⟨by rw [reF_neg]; exact neg_mem hz.1, by rw [imF_neg]; exact neg_mem hz.2⟩

-- With `1 + t²` a unit of `B` for `t ∈ B`: if `b = t·a`, `a ≠ 0`, then `a, b ∈ B` or `a/(a² + b²), b/(a² + b²) ∈ B`.
private theorem gauss_key {B : ValuationSubring F} (hnon : ∀ x ∈ B, 1 + x ^ 2 ∉ B.nonunits) {a b t : F}
    (ht : t ∈ B) (hb : b = t * a) (ha : a ≠ 0) :
    (a ∈ B ∧ b ∈ B) ∨ (a / (a ^ 2 + b ^ 2) ∈ B ∧ b / (a ^ 2 + b ^ 2) ∈ B) := by
  by_cases haB : a ∈ B
  · exact Or.inl ⟨haB, hb ▸ mul_mem ht haB⟩
  have hainv : a⁻¹ ∈ B := (B.mem_or_inv_mem a).resolve_left haB
  have hu := hnon t ht
  rw [ValuationSubring.mem_nonunits_iff_or, not_or, not_not] at hu
  obtain ⟨hu0, huinv⟩ := hu
  have hN : a ^ 2 + b ^ 2 = a ^ 2 * (1 + t ^ 2) := by rw [hb]; ring
  have e1 : a / (a ^ 2 + b ^ 2) = a⁻¹ * (1 + t ^ 2)⁻¹ := by
    rw [hN]; field_simp
  have e2 : b / (a ^ 2 + b ^ 2) = t * (a⁻¹ * (1 + t ^ 2)⁻¹) := by
    rw [hN, hb]; field_simp
  exact Or.inr ⟨e1 ▸ mul_mem hainv huinv, e2 ▸ mul_mem ht (mul_mem hainv huinv)⟩

-- `B[i]` meets every element or its inverse.
private theorem gauss_mem_or_inv_mem {B : ValuationSubring F} (hnon : ∀ x ∈ B, 1 + x ^ 2 ∉ B.nonunits)
    (z : fieldI F) : z ∈ gaussSubring B ∨ z⁻¹ ∈ gaussSubring B := by
  by_cases hz : z = 0
  · exact Or.inl (hz ▸ (gaussSubring B).zero_mem)
  have hab : reF z ≠ 0 ∨ imF z ≠ 0 := by
    by_contra h
    push Not at h
    apply hz
    rw [eq_reF_add z, h.1, h.2, map_zero, zero_mul, add_zero]
  have hcase : (∃ t ∈ B, imF z = t * reF z ∧ reF z ≠ 0) ∨ (∃ s ∈ B, reF z = s * imF z ∧ imF z ≠ 0) := by
    by_cases ha : reF z = 0
    · exact Or.inr ⟨0, B.zero_mem, by rw [ha, zero_mul], hab.resolve_left (not_not.2 ha)⟩
    by_cases hb : imF z = 0
    · exact Or.inl ⟨0, B.zero_mem, by rw [hb, zero_mul], ha⟩
    rcases B.mem_or_inv_mem (imF z / reF z) with h | h
    · exact Or.inl ⟨_, h, by field_simp, ha⟩
    · exact Or.inr ⟨_, by rwa [inv_div] at h, by field_simp, hb⟩
  rcases hcase with ⟨t, ht, hb, ha⟩ | ⟨s, hs, ha, hb⟩
  · rcases gauss_key hnon ht hb ha with h | h
    · exact Or.inl h
    · exact Or.inr ⟨by rw [reF_inv]; exact h.1, by rw [imF_inv]; exact neg_mem h.2⟩
  · rcases gauss_key hnon hs ha hb with h | h
    · exact Or.inl ⟨h.2, h.1⟩
    · exact Or.inr ⟨by rw [reF_inv, add_comm]; exact h.2, by rw [imF_inv, add_comm]; exact neg_mem h.1⟩

-- `B[i]` as a valuation subring of `F(i)`.
private noncomputable def gaussVal (B : ValuationSubring F) (hnon : ∀ x ∈ B, 1 + x ^ 2 ∉ B.nonunits) : ValuationSubring (fieldI F) :=
  ValuationSubring.ofSubring (gaussSubring B) (gauss_mem_or_inv_mem hnon)

private theorem mem_gaussVal {B : ValuationSubring F} {hnon : ∀ x ∈ B, 1 + x ^ 2 ∉ B.nonunits} {z : fieldI F} :
    z ∈ gaussVal B hnon ↔ reF z ∈ B ∧ imF z ∈ B := Iff.rfl

-- A finite field in which `2 = 0` has an even number of elements.
private theorem two_dvd_card_of_two_eq_zero {K : Type*} [Field K] [Finite K] (h : (2 : K) = 0) : 2 ∣ Nat.card K := by
  haveI : CharP K 2 := CharTwo.of_one_ne_zero_of_two_eq_zero one_ne_zero h
  letI : Fintype K := Fintype.ofFinite K
  obtain ⟨n, -, hn⟩ := FiniteField.card K 2
  rw [Nat.card_eq_fintype_card, hn]
  exact dvd_pow_self 2 n.ne_zero

end Gauss

variable {F : Subfield ℝ} [NumberField F]

/-! ### The residue count -/

-- The residue field at a stable prime whose local ring is `B[i]` has `|𝓞 F ⧸ 𝔭|²` elements, `r` the residue map of `B`.
private theorem card_eq_sq_of_localRing_eq {𝔭 : Ideal (𝓞 F)} {B : ValuationSubring F}
    (hnon : ∀ x ∈ B, 1 + x ^ 2 ∉ B.nonunits) (r : B →+* 𝓞 F ⧸ 𝔭) (hr : Function.Surjective r)
    (hker : ∀ x : B, r x = 0 ↔ (x : F) ∈ B.nonunits) (h2B : (2 : F)⁻¹ ∈ B)
    (P : StablePrime F) (hPA : P.localRing = gaussVal B hnon) :
    Nat.card (𝓞 (fieldI F) ⧸ P.P) = Nat.card (𝓞 F ⧸ 𝔭) ^ 2 := by
  classical
  haveI hmax : (P.P ^ 1).IsMaximal := by rw [pow_one]; exact P.isMaximal
  letI : Field (𝓞 (fieldI F) ⧸ P.P ^ 1) := Ideal.Quotient.field (P.P ^ 1)
  haveI : Finite (𝓞 (fieldI F) ⧸ P.P ^ 1) := Ideal.finiteQuotientOfFreeOfNeBot _ (pow_ne_zero 1 P.heightOne.ne_bot)
  have memA : ∀ z : fieldI F, z ∈ P.localRing ↔ reF z ∈ B ∧ imF z ∈ B := fun z => by rw [hPA]; exact Iff.rfl
  -- the residue map is onto, and kills exactly the non-units
  have hsurj : Function.Surjective (P.residue 1) := fun y => by
    obtain ⟨a, rfl⟩ := Ideal.Quotient.mk_surjective y
    exact ⟨_, residue_algebraMap P 1 a⟩
  have hkerres : ∀ z : P.localRing, P.residue 1 z = 0 ↔ (z : fieldI F) ∈ P.localRing.nonunits := fun z => by
    have hm := IsLocalRing.eq_maximalIdeal (RingHom.ker_isMaximal_of_surjective (P.residue 1) hsurj)
    rw [ValuationSubring.mem_nonunits_iff_exists_mem_maximalIdeal, ← RingHom.mem_ker, hm]
    exact ⟨fun h => ⟨z.2, h⟩, fun ⟨_, h⟩ => h⟩
  -- `ρ : B → 𝓞 ⧸ P`, through the real elements of `B[i]`
  have memOf : ∀ b : B, ofF (b : F) ∈ P.localRing := fun b =>
    (memA _).2 ⟨by rw [reF_ofF]; exact b.2, by rw [imF_ofF]; exact B.zero_mem⟩
  let ρ : B →+* 𝓞 (fieldI F) ⧸ P.P ^ 1 :=
    (P.residue 1).comp ((ofF.comp B.subtype).codRestrict P.localRing memOf)
  have hρ : ∀ b : B, ρ b = P.residue 1 ⟨ofF (b : F), memOf b⟩ := fun _ => rfl
  have hρker : ∀ b : B, ρ b = 0 ↔ (b : F) ∈ B.nonunits := fun b => by
    rw [hρ, hkerres, ValuationSubring.mem_nonunits_iff_or, ValuationSubring.mem_nonunits_iff_or, ← map_inv₀, memA,
      reF_ofF, imF_ofF, map_eq_zero]
    simp [B.zero_mem]
  -- conjugation on the residue field, `ι = res i`, and `2 ≠ 0`
  set σ : (𝓞 (fieldI F) ⧸ P.P ^ 1) →+* (𝓞 (fieldI F) ⧸ P.P ^ 1) :=
    Ideal.quotientMap (P.P ^ 1) (conjO F) (P.le_comap 1) with hσdef
  have hσmk : ∀ x, σ (Ideal.Quotient.mk (P.P ^ 1) x) = Ideal.Quotient.mk (P.P ^ 1) (conjO F x) := fun x =>
    Ideal.quotientMap_mk
  have hσ : ∀ x, σ (σ x) = x := fun x => by
    obtain ⟨x, rfl⟩ := Ideal.Quotient.mk_surjective x
    rw [hσmk, hσmk, UpperHalf.conjO_conjO]
  set ι := Ideal.Quotient.mk (P.P ^ 1) (iO : 𝓞 (fieldI F)) with hιdef
  have hι : ι ^ 2 = -1 := by rw [hιdef, ← map_pow, iO_sq, map_neg, map_one]
  have hσι : σ ι = -ι := by rw [hιdef, hσmk, conjO_iO, map_neg]
  have hι0 : ι ≠ 0 := fun h => by rw [h] at hι; simp at hι
  have h2k : (2 : 𝓞 (fieldI F) ⧸ P.P ^ 1) ≠ 0 := by
    have h2u : ρ 2 ≠ 0 := by
      rw [Ne, hρker, ValuationSubring.mem_nonunits_iff_or, not_or, not_not]
      exact ⟨by simp, by exact_mod_cast h2B⟩
    rwa [map_ofNat] at h2u
  obtain ⟨hcard0, -⟩ := StandingFive.card_fixed_of_involution σ hσ hι hσι h2k
  -- `res (a + b·i) = ρ a + ρ b · ι`
  have hdecomp : ∀ (z : P.localRing) (a b : B), reF (z : fieldI F) = a → imF (z : fieldI F) = b →
      P.residue 1 z = ρ a + ρ b * ι := fun z a b ha hb => by
    have e : z = ⟨ofF (a : F), memOf a⟩ + ⟨ofF (b : F), memOf b⟩ *
        algebraMap (𝓞 (fieldI F)) P.localRing (iO : 𝓞 (fieldI F)) := by
      apply Subtype.ext
      show (z : fieldI F) = ofF (a : F) + ofF (b : F) * ((iO : 𝓞 (fieldI F)) : fieldI F)
      rw [← ha, ← hb]
      exact eq_reF_add (z : fieldI F)
    rw [e, map_add, map_mul, residue_algebraMap]
    rfl
  -- `ρ` lands in the fixed field, and onto it
  have hρfix : ∀ b : B, σ (ρ b) = ρ b := fun b => by
    have h := residue_conj P 1 ⟨ofF (b : F), memOf b⟩
    have e : (⟨conjOn (fieldI_conj F) (ofF (b : F)), conj_mem_localRing P _ (memOf b)⟩ : P.localRing) =
        ⟨ofF (b : F), memOf b⟩ := Subtype.ext (Subtype.ext (by simp [ofF]))
    rw [e] at h
    exact h.symm
  set k₀ := σ.eqLocusField (RingHom.id _) with hk₀def
  let ρ₀ : B →+* k₀ := ρ.codRestrict k₀ fun b => show σ (ρ b) = RingHom.id _ (ρ b) from hρfix b
  have hρ₀surj : Function.Surjective ρ₀ := by
    rintro ⟨x, hx⟩
    obtain ⟨z, rfl⟩ := hsurj x
    obtain ⟨ha, hb⟩ := (memA _).1 z.2
    have h1 := hdecomp z ⟨_, ha⟩ ⟨_, hb⟩ rfl rfl
    have h2 := hdecomp ⟨conjOn (fieldI_conj F) z, conj_mem_localRing P z z.2⟩ ⟨_, ha⟩ (-⟨_, hb⟩)
      (reF_conj _) (by rw [imF_conj]; rfl)
    have hx' : σ (P.residue 1 z) = P.residue 1 z := hx
    rw [residue_conj, hx', h1, map_neg] at h2
    have hb0 : ρ ⟨_, hb⟩ = 0 := by
      have h3 : (2 : 𝓞 (fieldI F) ⧸ P.P ^ 1) * ρ ⟨_, hb⟩ * ι = 0 := by linear_combination h2
      rcases mul_eq_zero.1 h3 with h | h
      · exact (mul_eq_zero.1 h).resolve_left h2k
      · exact absurd h hι0
    refine ⟨⟨_, ha⟩, Subtype.ext ?_⟩
    show ρ ⟨_, ha⟩ = P.residue 1 z
    rw [h1, hb0, zero_mul, add_zero]
  have hkerEq : RingHom.ker ρ₀ = RingHom.ker r := by
    ext b
    rw [RingHom.mem_ker, RingHom.mem_ker, hker]
    constructor
    · intro h; exact (hρker b).1 (congrArg Subtype.val h)
    · intro h; exact Subtype.ext ((hρker b).2 h)
  have hk₀card : Nat.card k₀ = Nat.card (𝓞 F ⧸ 𝔭) :=
    Nat.card_congr ((RingHom.quotientKerEquivOfSurjective hρ₀surj).symm.toEquiv.trans
      ((Ideal.quotEquivOfEq hkerEq).toEquiv.trans (RingHom.quotientKerEquivOfSurjective hr).toEquiv))
  have e1 : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Nat.card (𝓞 (fieldI F) ⧸ P.P ^ 1) := by rw [pow_one]
  rw [e1, hcard0, hk₀card]

/-- **The stable prime above a usable prime** has `q²` residues, `q = |𝓞 F ⧸ 𝔭|`. -/
theorem exists_stablePrime_card_eq_sq {𝔭 : Ideal (𝓞 F)} (h𝔭 : IsUsablePrime 𝔭) :
    ∃ P : StablePrime F, Nat.card (𝓞 (fieldI F) ⧸ P.P) = Nat.card (𝓞 F ⧸ 𝔭) ^ 2 := by
  classical
  haveI : 𝔭.IsMaximal := h𝔭.1
  letI : Field (𝓞 F ⧸ 𝔭) := Ideal.Quotient.field 𝔭
  haveI : Finite (𝓞 F ⧸ 𝔭) :=
    Nat.finite_of_card_ne_zero (fun h => by have := h𝔭.2; rw [h] at this; norm_num at this)
  letI : Fintype (𝓞 F ⧸ 𝔭) := Fintype.ofFinite _
  obtain ⟨B, hB⟩ := exists_valuationSubring_localization F h𝔭.1
  obtain ⟨r, hr1, hr2⟩ := exists_residue_localization F h𝔭.1 B hB
  -- `−1` is no square modulo `𝔭`, so `1 + x²` is a unit of `B` (as in `placeHom_base`)
  have hsq : ¬ IsSquare (-1 : 𝓞 F ⧸ 𝔭) := by
    rw [FiniteField.isSquare_neg_one_iff, ← Nat.card_eq_fintype_card, not_not]; exact h𝔭.2
  have hnon : ∀ x ∈ B, 1 + x ^ 2 ∉ B.nonunits := by
    intro x hx
    refine hr2 ⟨1 + x ^ 2, add_mem B.one_mem (pow_mem hx 2)⟩ ?_
    have : (⟨1 + x ^ 2, add_mem B.one_mem (pow_mem hx 2)⟩ : B) = 1 + ⟨x, hx⟩ ^ 2 := rfl
    rw [this, map_add, map_one, map_pow]
    intro h
    exact hsq ⟨r ⟨x, hx⟩, by linear_combination -h⟩
  -- the residue map of `B` is onto and kills exactly the non-units
  have h1𝔭 : (1 : 𝓞 F) ∉ 𝔭 := fun h => h𝔭.1.ne_top ((Ideal.eq_top_iff_one _).2 h)
  have hr : Function.Surjective r := fun y => by
    obtain ⟨a, rfl⟩ := Ideal.Quotient.mk_surjective y
    refine ⟨⟨(a : F) / ((1 : 𝓞 F) : F), (hB _).2 ⟨a, 1, h1𝔭, rfl⟩⟩, ?_⟩
    have h := hr1 a 1 h1𝔭
    rwa [map_one, mul_one] at h
  have hker : ∀ x : B, r x = 0 ↔ (x : F) ∈ B.nonunits := fun x => by
    constructor
    · intro h
      by_contra hx
      rw [ValuationSubring.mem_nonunits_iff_or, not_or, not_not] at hx
      have e : x * ⟨(x : F)⁻¹, hx.2⟩ = 1 := Subtype.ext (mul_inv_cancel₀ hx.1)
      have h' := congrArg r e
      rw [map_mul, h, zero_mul, map_one] at h'
      exact zero_ne_one h'
    · intro h
      by_contra hx
      exact hr2 x hx h
  -- `2 ∉ 𝔭` (`q` is odd), so `1/2 ∈ B`
  have h2𝔭 : (2 : 𝓞 F) ∉ 𝔭 := by
    intro h
    have h0 : (2 : 𝓞 F ⧸ 𝔭) = 0 := by
      rw [← map_ofNat (Ideal.Quotient.mk 𝔭) 2, Ideal.Quotient.eq_zero_iff_mem]; exact h
    have hd := two_dvd_card_of_two_eq_zero h0
    have hq := h𝔭.2
    omega
  have h2B : (2 : F)⁻¹ ∈ B := (hB _).2 ⟨1, 2, h2𝔭, by
    rw [show ((2 : 𝓞 F) : F) = 2 from map_ofNat (algebraMap (𝓞 F) F) 2]; simp⟩
  -- `B[i]`: conjugation-stable, and not all of `F(i)` (`1/q ∉ B`)
  have hσA : ∀ z ∈ gaussVal B hnon, conjOn (fieldI_conj F) z ∈ gaussVal B hnon := fun z hz => by
    rw [mem_gaussVal] at hz ⊢
    rw [reF_conj, imF_conj]
    exact ⟨hz.1, neg_mem hz.2⟩
  have hA : gaussVal B hnon ≠ ⊤ := by
    intro htop
    have hq0 : (Nat.card (𝓞 F ⧸ 𝔭) : F) ≠ 0 := by
      have hq := h𝔭.2
      exact_mod_cast (by omega : Nat.card (𝓞 F ⧸ 𝔭) ≠ 0)
    have hrq : r (Nat.card (𝓞 F ⧸ 𝔭) : B) = 0 := by
      rw [map_natCast, Nat.card_eq_fintype_card]; exact FiniteField.cast_card_eq_zero _
    have hqn := (hker _).1 hrq
    rw [ValuationSubring.mem_nonunits_iff_or] at hqn
    rcases hqn with h | h
    · exact hq0 (by exact_mod_cast h)
    · apply h
      have hm : ofF ((Nat.card (𝓞 F ⧸ 𝔭) : F)⁻¹) ∈ gaussVal B hnon := by
        rw [htop]; exact ValuationSubring.mem_top _
      rw [mem_gaussVal, reF_ofF] at hm
      simpa using hm.1
  obtain ⟨P, hPA⟩ := exists_stablePrime_of_valuationSubring (gaussVal B hnon) hA hσA
  exact ⟨P, card_eq_sq_of_localRing_eq hnon r hr hker h2B P hPA⟩

/-- **The level-one target at an odd stable prime with `Q²` residues maps to `Γ_Q`** over any finite field `k` of `Q`
elements. -/
theorem nonempty_hom_levelTarget_one_unitQuadrance (P : StablePrime F) (h2 : (2 : 𝓞 (fieldI F)) ∉ P.P)
    (k : Type*) [Field k] [Finite k] (hk : Nat.card (𝓞 (fieldI F) ⧸ P.P) = Nat.card k ^ 2) :
    Nonempty (levelTarget P 1 →g unitQuadrance k) := by
  -- the hom of `Rigidity.chromaticNumber_le_four_of_small`, which never reads its `Q ∈ {3, 7}`: coordinates `x = a + bι`
  classical
  haveI hmax : (P.P ^ 1).IsMaximal := by rw [pow_one]; exact P.isMaximal
  letI : Field (𝓞 (fieldI F) ⧸ P.P ^ 1) := Ideal.Quotient.field (P.P ^ 1)
  haveI : Finite (𝓞 (fieldI F) ⧸ P.P ^ 1) := Ideal.finiteQuotientOfFreeOfNeBot _ (pow_ne_zero 1 P.heightOne.ne_bot)
  set σ : (𝓞 (fieldI F) ⧸ P.P ^ 1) →+* (𝓞 (fieldI F) ⧸ P.P ^ 1) :=
    Ideal.quotientMap (P.P ^ 1) (conjO F) (P.le_comap 1) with hσdef
  have hσmk : ∀ x, σ (Ideal.Quotient.mk (P.P ^ 1) x) = Ideal.Quotient.mk (P.P ^ 1) (conjO F x) := fun x =>
    Ideal.quotientMap_mk
  have hσ : ∀ x, σ (σ x) = x := fun x => by
    obtain ⟨x, rfl⟩ := Ideal.Quotient.mk_surjective x
    rw [hσmk, hσmk, UpperHalf.conjO_conjO]
  obtain ⟨i, hi2, hci⟩ := UpperHalf.exists_I_integer (F := F)
  have h2k : (2 : 𝓞 (fieldI F) ⧸ P.P ^ 1) ≠ 0 := by
    rw [← map_ofNat (Ideal.Quotient.mk (P.P ^ 1)) 2, Ne, Ideal.Quotient.eq_zero_iff_mem, pow_one]; exact h2
  set ι := Ideal.Quotient.mk (P.P ^ 1) i with hιdef
  have hι : ι ^ 2 = -1 := by rw [hιdef, ← map_pow, hi2, map_neg, map_one]
  have hσι : σ ι = -ι := by rw [hιdef, hσmk, hci, map_neg]
  obtain ⟨hcard0, -⟩ := StandingFive.card_fixed_of_involution σ hσ hι hσι h2k
  set k₀ := σ.eqLocusField (RingHom.id _) with hk₀def
  have hk₀ : Nat.card k₀ = Nat.card k := by
    have e : Nat.card k₀ ^ 2 = Nat.card k ^ 2 := by rw [← hcard0, ← hk, pow_one]
    exact Nat.pow_left_injective two_ne_zero e
  set u : 𝓞 (fieldI F) ⧸ P.P ^ 1 := (2 : 𝓞 (fieldI F) ⧸ P.P ^ 1)⁻¹ with hudef
  have hu : 2 * u = 1 := mul_inv_cancel₀ h2k
  have hσu : σ u = u := by rw [hudef, map_inv₀, map_ofNat]
  have ha : ∀ x, u * (x + σ x) ∈ k₀ := fun x => by
    show σ (u * (x + σ x)) = u * (x + σ x)
    rw [map_mul, map_add, hσ, hσu]; ring
  have hb : ∀ x, -(u * ι * (x - σ x)) ∈ k₀ := fun x => by
    show σ (-(u * ι * (x - σ x))) = -(u * ι * (x - σ x))
    rw [map_neg, map_mul, map_mul, map_sub, hσ, hσu, hσι]; ring
  let φ : levelTarget P 1 →g unitQuadrance k₀ :=
    { toFun := fun x => (⟨_, ha x⟩, ⟨_, hb x⟩)
      map_rel' := by
        intro x y hxy
        rw [unitQuadrance_adj]
        obtain ⟨hne, hN⟩ := (SimpleGraph.fromRel_adj _ _ _).1 hxy
        have hN' : (x - y) * σ (x - y) = 1 := by
          rcases hN with h | h
          · exact h
          · have e : (y - x) * σ (y - x) = (x - y) * σ (x - y) := by rw [map_sub, map_sub]; ring
            rw [← e]; exact h
        refine ⟨fun heq => hne ?_, ?_⟩
        · have h1 := congrArg (fun p : k₀ × k₀ => (p.1 : 𝓞 (fieldI F) ⧸ P.P ^ 1)) heq
          have h2' := congrArg (fun p : k₀ × k₀ => (p.2 : 𝓞 (fieldI F) ⧸ P.P ^ 1)) heq
          simp only at h1 h2'
          linear_combination h1 + ι * h2' - (x - y) * hu + u * (x - y - (σ x - σ y)) * hι
        · apply Subtype.ext
          push_cast
          rw [map_sub] at hN'
          linear_combination (2 * u + 1) * (x - y) * (σ x - σ y) * hu + hN' +
            u ^ 2 * (x - y - (σ x - σ y)) ^ 2 * hι }
  letI : Fintype k₀ := Fintype.ofFinite _
  letI : Fintype k := Fintype.ofFinite _
  have hcardF : Fintype.card k₀ = Fintype.card k := by rw [← Nat.card_eq_fintype_card, ← Nat.card_eq_fintype_card, hk₀]
  exact ⟨(unitQuadrance.map (FiniteField.ringEquivOfCardEq hcardF).toRingHom).comp φ⟩

variable (F) in
/-- **`L(F) ≤ χ(Γ_q)`** at a usable prime with residue field `𝔽_q`. -/
theorem localBound_le_unitQuadrance {𝔭 : Ideal (𝓞 F)} (h𝔭 : IsUsablePrime 𝔭) :
    localBound F ≤ (unitQuadrance (𝓞 F ⧸ 𝔭)).chromaticNumber := by
  obtain ⟨P, hP⟩ := exists_stablePrime_card_eq_sq h𝔭
  haveI : 𝔭.IsMaximal := h𝔭.1
  letI : Field (𝓞 F ⧸ 𝔭) := Ideal.Quotient.field 𝔭
  haveI : Finite (𝓞 F ⧸ 𝔭) :=
    Nat.finite_of_card_ne_zero (fun h => by have := h𝔭.2; rw [h] at this; norm_num at this)
  -- `|𝓞 ⧸ P| = q²` is odd, so `2 ∉ P`
  have h2 : (2 : 𝓞 (fieldI F)) ∉ P.P := by
    intro h2
    haveI := P.isMaximal
    letI : Field (𝓞 (fieldI F) ⧸ P.P) := Ideal.Quotient.field P.P
    haveI : Finite (𝓞 (fieldI F) ⧸ P.P) := Ideal.finiteQuotientOfFreeOfNeBot _ P.heightOne.ne_bot
    have h0 : (2 : 𝓞 (fieldI F) ⧸ P.P) = 0 := by
      rw [← map_ofNat (Ideal.Quotient.mk P.P) 2, Ideal.Quotient.eq_zero_iff_mem]; exact h2
    have hd := two_dvd_card_of_two_eq_zero h0
    rw [hP] at hd
    have hodd : Odd (Nat.card (𝓞 F ⧸ 𝔭) ^ 2) := Odd.pow (Nat.odd_iff.2 (by have := h𝔭.2; omega))
    exact (Nat.not_even_iff_odd.2 hodd) (even_iff_two_dvd.2 hd)
  obtain ⟨φ⟩ := nonempty_hom_levelTarget_one_unitQuadrance P h2 (𝓞 F ⧸ 𝔭) hP
  exact (iInf_le _ P).trans (chromaticNumber_mono_of_hom φ)

variable (F) in
/-- **`L(F) ≤ χ(Γ_p)`** at a usable prime whose residue field has prime order `p`. -/
theorem localBound_le_finitePlane {𝔭 : Ideal (𝓞 F)} (h𝔭 : IsUsablePrime 𝔭) {p : ℕ} (hp : p.Prime)
    (hcard : Nat.card (𝓞 F ⧸ 𝔭) = p) : localBound F ≤ (finitePlane p).chromaticNumber := by
  obtain ⟨e⟩ := nonempty_ringEquiv_zmod_of_card hp hcard
  haveI : Fact p.Prime := ⟨hp⟩
  exact (localBound_le_unitQuadrance F h𝔭).trans (chromaticNumber_mono_of_hom (unitQuadrance.map e.toRingHom))

/-! ## Spec -/

-- The residue sizes the head statement is read at: `11 ≡ 19 ≡ 3 (mod 4)`, and `47` a nonzero square mod 11.
example : 11 % 4 = 3 ∧ 19 % 4 = 3 ∧ (47 : ZMod 11) ≠ 0 ∧ IsSquare (47 : ZMod 11) := by decide

end HadwigerNelson.UpperHalf

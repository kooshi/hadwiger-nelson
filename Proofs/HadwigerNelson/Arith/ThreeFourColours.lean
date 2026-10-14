import Proofs.HadwigerNelson.Arith.UpperHalf
import Proofs.HadwigerNelson.Arith.QuadraticPrime
import Proofs.HadwigerNelson.Instances.UpperHalfValues
import Proofs.HadwigerNelson.Arith.ThreeColourCriterion
import Proofs.HadwigerNelson.Arith.DyadicQuadratic
import Proofs.HadwigerNelson.PlaneRotation
import Proofs.HadwigerNelson.Instances.PlaneFreedom

/-!
# Three and four colours over real number fields: the joining module (FS-131, NF4 with NF1)

Statements planned by FS131-KN4 (passes FS131-KN5); joined, extended and proved by FS131-KJ1. It reads the residue module
(`Arith/UpperHalf`, `Arith/QuadraticPrime`, `Instances/UpperHalfValues`; NF1) and this line's four modules
(`Arith/ThreeColourCharacter`, `Arith/TorsionExtraction`, `Arith/ThreeColourCriterion`, `Arith/DyadicQuadratic`; NF4).

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

omit [NumberField F] in
/-- `P ^ 1` is maximal (the quotient the level-one target lives on is a field). -/
private theorem isMaximal_pow_one (P : StablePrime F) : (P.P ^ 1).IsMaximal := by
  rw [pow_one]; exact P.isMaximal

omit [NumberField F] in
/-- Conjugation on `𝓞 ⧸ P ^ 1` is an involution. -/
private theorem quotientMap_conjO_involutive (P : StablePrime F) (x : 𝓞 (fieldI F) ⧸ P.P ^ 1) :
    Ideal.quotientMap (P.P ^ 1) (conjO F) (P.le_comap 1) (Ideal.quotientMap (P.P ^ 1) (conjO F) (P.le_comap 1) x) = x := by
  obtain ⟨a, rfl⟩ := Ideal.Quotient.mk_surjective x
  rw [Ideal.quotientMap_mk, Ideal.quotientMap_mk, conjO_conjO]

omit [NumberField F] in
/-- `i` is an integer of `F(i)`, with `i² = −1` and `ī = −i` (`UpperHalf`'s private lemma, restated). -/
private theorem exists_I_integer' : ∃ i : 𝓞 (fieldI F), i ^ 2 = -1 ∧ conjO F i = -i := by
  let iL : fieldI F := ⟨Complex.I, by simp [zero_mem], by simp [one_mem]⟩
  have hiL : iL ^ 2 = -1 := Subtype.ext Complex.I_sq
  have hint : IsIntegral ℤ iL := IsIntegral.of_pow (n := 2) (by norm_num) (by rw [hiL]; exact isIntegral_one.neg)
  refine ⟨⟨iL, hint⟩, RingOfIntegers.coe_injective ?_, RingOfIntegers.coe_injective ?_⟩
  · rw [map_pow, map_neg, map_one]; exact hiL
  · rw [map_neg]; exact Subtype.ext Complex.conj_I

/-- The level-one residue map vanishes exactly on the non-units of `𝓞_P`: its kernel is a maximal ideal of a local ring. -/
private theorem residue_one_eq_zero_iff (P : StablePrime F) (z : P.localRing) :
    P.residue 1 z = 0 ↔ (z : fieldI F) ∈ P.localRing.nonunits := by
  haveI := isMaximal_pow_one P
  letI := Ideal.Quotient.field (P.P ^ 1)
  have hsurj : Function.Surjective (P.residue 1) := fun t => by
    obtain ⟨a, rfl⟩ := Ideal.Quotient.mk_surjective t
    exact ⟨algebraMap _ _ a, residue_algebraMap P 1 a⟩
  have hker : RingHom.ker (P.residue 1) = IsLocalRing.maximalIdeal P.localRing :=
    IsLocalRing.eq_maximalIdeal (RingHom.ker_isMaximal_of_surjective _ hsurj)
  rw [← RingHom.mem_ker, hker, ValuationSubring.mem_nonunits_iff_exists_mem_maximalIdeal]
  exact ⟨fun h => ⟨z.2, h⟩, fun ⟨_, h⟩ => h⟩

/-- The residue map on the ring `ℤ[U_F]`, as a ring homomorphism (`x ↦ res ⟨x, hle x⟩`). -/
private noncomputable def ringResidue (P : StablePrime F)
    (hle : ∀ x : unitRing F, unitRingToFieldI F x ∈ P.localRing) : unitRing F →+* 𝓞 (fieldI F) ⧸ P.P ^ 1 :=
  (P.residue 1).comp
    ((((unitRing F).subtype.codRestrict (fieldI F)
      fun x => UnitRing.unitRingOver_le_planeOverSubring F x.2).codRestrict P.localRing) hle)

private theorem ringResidue_apply (P : StablePrime F) (hle : ∀ x : unitRing F, unitRingToFieldI F x ∈ P.localRing)
    (x : unitRing F) : ringResidue P hle x = P.residue 1 ⟨unitRingToFieldI F x, hle x⟩ := rfl

omit [NumberField F] in
/-- A unit vector has `u·ū = 1` in the ring. -/
private theorem mul_conjR_eq_one {u : unitRing F} (hu : u ∈ unitSet F) : u * conjR F u = 1 :=
  Subtype.ext (by
    show (u : ℂ) * (starRingEnd ℂ) (u : ℂ) = 1
    rw [Complex.mul_conj, Complex.normSq_eq_norm_sq, hu.2]
    norm_num)

/-- **J1 — a maximal ideal of `ℤ[U_F]` is cut out by a stable prime of `F(i)`** (FS91-J02-L2(b)): the ring lies in the
local ring `𝓞_P`, and the ideal is the ring's part of the maximal ideal of `𝓞_P`. (`𝔪 ≠ ⊥`: were `ℤ[U_F]` a field the
statement would fail; that it never is needs Chebotarev, which no consumer here needs — each has `2` or `3` in `𝔪`.)
Chevalley's domination (`Ideal.image_subset_nonunits_valuationSubring`) gives a valuation subring over the ring whose
non-units hold `𝔪`; it holds the unit vectors, so it is conjugation-stable, and it is `𝓞_P` for a stable prime
(`UpperHalf.exists_stablePrime_of_valuationSubring`); the kernel of the residue on the ring is a proper ideal over `𝔪`. -/
theorem exists_stablePrime_of_maximal {𝔪 : Ideal (unitRing F)} (h𝔪 : 𝔪.IsMaximal) (hne : 𝔪 ≠ ⊥) :
    ∃ P : StablePrime F, ∃ hle : ∀ x : unitRing F, unitRingToFieldI F x ∈ P.localRing,
      ∀ x : unitRing F, x ∈ 𝔪 ↔ P.residue 1 ⟨unitRingToFieldI F x, hle x⟩ = 0 := by
  have hσσ := conjOn_conjOn (fieldI_conj F)
  -- the ring as a subring `A` of `F(i)`, and `𝔪` as an ideal of `A`
  let A : Subring (fieldI F) := UnitRing.unitRing (conjOn (fieldI_conj F))
  have hA : ∀ x : unitRing F, unitRingToFieldI F x ∈ A := fun x =>
    (UnitRing.coe_mem_unitRingOver_iff (unitRingToFieldI F x)).mp x.2
  let f : A →+* unitRing F := ((fieldI F).subtype.comp A.subtype).codRestrict (unitRing F)
    fun z => (UnitRing.coe_mem_unitRingOver_iff (z : fieldI F)).mpr z.2
  obtain ⟨B, hAB, hIB⟩ :=
    Ideal.image_subset_nonunits_valuationSubring (𝔪.comap f) (Ideal.comap_ne_top f h𝔪.ne_top)
  have hnon : ∀ x ∈ 𝔪, unitRingToFieldI F x ∈ B.nonunits := fun x hx =>
    hIB ⟨⟨unitRingToFieldI F x, hA x⟩, (show f ⟨unitRingToFieldI F x, hA x⟩ ∈ 𝔪 from hx), rfl⟩
  have hstab : ∀ z ∈ B, conjOn (fieldI_conj F) z ∈ B :=
    (UnitRing.normOne_subset_iff_stable _ hσσ B).mp fun u hu => hAB (UnitRing.normOne_subset_unitRing _ hu)
  have hBtop : B ≠ ⊤ := by
    rintro rfl
    obtain ⟨x, hx, hx0⟩ := Submodule.exists_mem_ne_zero_of_ne_bot hne
    have h := hnon x hx
    rw [ValuationSubring.mem_nonunits_iff_or] at h
    rcases h with h | h
    · exact hx0 (unitRingToFieldI_injective F (h.trans (map_zero _).symm))
    · exact h (ValuationSubring.mem_top _)
  obtain ⟨P, rfl⟩ := exists_stablePrime_of_valuationSubring B hBtop hstab
  have hle : ∀ x : unitRing F, unitRingToFieldI F x ∈ P.localRing := fun x => hAB (hA x)
  haveI := isMaximal_pow_one P
  letI := Ideal.Quotient.field (P.P ^ 1)
  refine ⟨P, hle, fun x => ?_⟩
  have hker : 𝔪 = RingHom.ker (ringResidue P hle) := by
    refine h𝔪.eq_of_le (RingHom.ker_ne_top _) fun y hy => ?_
    rw [RingHom.mem_ker, ringResidue_apply, residue_one_eq_zero_iff]
    exact hnon y hy
  rw [hker, RingHom.mem_ker, ringResidue_apply]

/-- **J2 — every norm-one residue is the residue of a unit vector** (FS91-J02-L2(c); NF4-S9 at level one): for
`t ∈ 𝓞 ⧸ P` with `t·t̄ = 1` some `x ∈ ℤ[U_F]`, a unit vector, reduces to `t`. (Conjugation not the identity on the
residue field: Hilbert 90 there, `t = y/ȳ`, and `u = a/ā` for a lift `a` of `y`. The identity: `t² = 1` in
characteristic 2, so `t = 1`.) At higher levels the statement is false as the claim list first had it
(`data/fs131/claims-NF4.md`, the dated line of 17:59 UTC: `F = ℚ`, `P = (1 + i)`, level 4). -/
theorem exists_unitSet_residue_eq (P : StablePrime F) (hle : ∀ x : unitRing F, unitRingToFieldI F x ∈ P.localRing)
    {t : 𝓞 (fieldI F) ⧸ P.P ^ 1}
    (ht : t * Ideal.quotientMap (P.P ^ 1) (conjO F) (P.le_comap 1) t = 1) :
    ∃ u ∈ unitSet F, P.residue 1 ⟨unitRingToFieldI F u, hle u⟩ = t := by
  haveI := isMaximal_pow_one P
  letI := Ideal.Quotient.field (P.P ^ 1)
  have hσσ := quotientMap_conjO_involutive P
  by_cases hid : Ideal.quotientMap (P.P ^ 1) (conjO F) (P.le_comap 1) = RingHom.id _
  · -- conjugation is the identity modulo `P`: characteristic 2, and `t² = 1` gives `t = 1`
    have hram : ∀ x : 𝓞 (fieldI F), conjO F x - x ∈ P.P := fun x => by
      have h := DFunLike.congr_fun hid (Ideal.Quotient.mk (P.P ^ 1) x)
      rw [Ideal.quotientMap_mk, RingHom.id_apply] at h
      have h' := Ideal.Quotient.eq.mp h
      rwa [pow_one] at h'
    have h2 : (2 : 𝓞 (fieldI F) ⧸ P.P ^ 1) = 0 := by
      have h := two_mem_of_conj_trivial P hram
      rw [← pow_one P.P] at h
      have h' := Ideal.Quotient.eq_zero_iff_mem.mpr h
      rwa [map_ofNat] at h'
    have htt : t * t = 1 := by rw [hid, RingHom.id_apply] at ht; exact ht
    have hsq : (t - 1) ^ 2 = 0 := by linear_combination htt + (1 - t) * h2
    have ht1 : t = 1 := sub_eq_zero.mp ((pow_eq_zero_iff (by norm_num : (2 : ℕ) ≠ 0)).mp hsq)
    refine ⟨1, ⟨⟨by simp, by simp⟩, by simp⟩, ?_⟩
    rw [← ringResidue_apply, map_one, ht1]
  · -- Hilbert 90 in the residue field: `t = y / ȳ`, and `a / ā` for a lift `a` of `y` is a unit vector
    obtain ⟨y, hy⟩ := exists_mul_conj_inv_eq_of_mul_conj_eq_one _ hσσ hid ht
    obtain ⟨a, ha⟩ := Ideal.Quotient.mk_surjective (y : 𝓞 (fieldI F) ⧸ P.P ^ 1)
    have haP : a ∉ P.P := fun h =>
      y.ne_zero (by rw [← ha]; exact Ideal.Quotient.eq_zero_iff_mem.mpr (by rwa [pow_one]))
    have hcaP : conjO F a ∉ P.P := mt (conjO_mem_iff P).1 haP
    have ha0 : (a : fieldI F) ≠ 0 := fun h =>
      haP (by rw [RingOfIntegers.coe_eq_zero_iff.1 h]; exact P.P.zero_mem)
    have hca0 : ((conjO F a : 𝓞 (fieldI F)) : fieldI F) ≠ 0 := fun h =>
      hcaP (by rw [RingOfIntegers.coe_eq_zero_iff.1 h]; exact P.P.zero_mem)
    have hu₀ : ((a : fieldI F) / ((conjO F a : 𝓞 (fieldI F)) : fieldI F)) *
        conjOn (fieldI_conj F) ((a : fieldI F) / ((conjO F a : 𝓞 (fieldI F)) : fieldI F)) = 1 := by
      rw [map_div₀, ← coe_conjO, ← coe_conjO, conjO_conjO]
      field_simp
    have hU : (((a : fieldI F) / ((conjO F a : 𝓞 (fieldI F)) : fieldI F) : fieldI F) : ℂ) ∈ unitVectors F :=
      ⟨((a : fieldI F) / ((conjO F a : 𝓞 (fieldI F)) : fieldI F)).2, (UnitRing.mem_normOne_conjOn_iff _).mp hu₀⟩
    refine ⟨⟨_, unitVectors_subset_unitRing F hU⟩, hU, ?_⟩
    have hres := residue_div P 1 a (conjO F a) hcaP
    have hσy : Ideal.Quotient.mk (P.P ^ 1) (conjO F a) =
        Ideal.quotientMap (P.P ^ 1) (conjO F) (P.le_comap 1) (y : 𝓞 (fieldI F) ⧸ P.P ^ 1) := by
      rw [← ha, Ideal.quotientMap_mk]
    rw [hσy, ha] at hres
    have hσy0 : Ideal.quotientMap (P.P ^ 1) (conjO F) (P.le_comap 1) (y : 𝓞 (fieldI F) ⧸ P.P ^ 1) ≠ 0 :=
      (map_ne_zero _).mpr y.ne_zero
    rw [← hy, Units.val_inv_eq_inv_val, map_inv₀]
    exact (eq_mul_inv_iff_mul_eq₀ hσy0).mpr hres

/-- **J4 — trivial conjugation in the ring, trivial conjugation at a stable prime.** (`2 ∈ 𝔪` from `ī − i = −2i`; were
conjugation to move some `y` of the residue field at the prime of J1, `y/ȳ ≠ 1` would be the residue of a unit vector
(J2) — and every unit vector is `1` modulo `𝔪`: `u·ū = 1`, `ū ≡ u`, characteristic 2.) -/
theorem exists_stablePrime_conj_trivial {𝔪 : Ideal (unitRing F)} (h𝔪 : 𝔪.IsMaximal)
    (htriv : ∀ x, conjR F x - x ∈ 𝔪) : ∃ P : StablePrime F, ∀ x : 𝓞 (fieldI F), conjO F x - x ∈ P.P := by
  -- `i` in the ring, `2 ∈ 𝔪`, and `𝔪 ≠ ⊥`
  let iR : unitRing F := ⟨Complex.I, unitVectors_subset_unitRing F ⟨⟨by simp, by simp⟩, by simp⟩⟩
  have hI : (conjR F iR - iR : unitRing F) = ⟨-(2 * Complex.I), neg_mem (mul_mem (ofNat_mem _ 2) iR.2)⟩ :=
    Subtype.ext (by
      show (starRingEnd ℂ) Complex.I - Complex.I = -(2 * Complex.I)
      rw [Complex.conj_I]; ring)
  have h2 : (2 : unitRing F) ∈ 𝔪 := by
    have h := 𝔪.mul_mem_left iR (htriv iR)
    have e : iR * (conjR F iR - iR) = 2 := by
      rw [hI]
      exact Subtype.ext (by
        show Complex.I * -(2 * Complex.I) = 2
        linear_combination (-2 : ℂ) * Complex.I_sq)
    rwa [e] at h
  have hne : 𝔪 ≠ ⊥ := fun h => by
    have h0 := htriv iR
    rw [h, Ideal.mem_bot, hI] at h0
    have h1 : -(2 * Complex.I) = 0 := congrArg Subtype.val h0
    exact Complex.I_ne_zero (by linear_combination (-1 / 2 : ℂ) * h1)
  obtain ⟨P, hle, hker⟩ := exists_stablePrime_of_maximal h𝔪 hne
  haveI := isMaximal_pow_one P
  letI := Ideal.Quotient.field (P.P ^ 1)
  have hσσ := quotientMap_conjO_involutive P
  refine ⟨P, fun x => ?_⟩
  by_contra hx
  have hσy : Ideal.quotientMap (P.P ^ 1) (conjO F) (P.le_comap 1) (Ideal.Quotient.mk (P.P ^ 1) x) ≠
      Ideal.Quotient.mk (P.P ^ 1) x := fun h => hx (by
    rw [Ideal.quotientMap_mk] at h
    have h' := Ideal.Quotient.eq.mp h
    rwa [pow_one] at h')
  generalize Ideal.Quotient.mk (P.P ^ 1) x = y at hσy
  have hy0 : y ≠ 0 := fun h => hσy (by rw [h, map_zero])
  have hσy0 : Ideal.quotientMap (P.P ^ 1) (conjO F) (P.le_comap 1) y ≠ 0 := (map_ne_zero _).mpr hy0
  -- `t = y / ȳ` has norm one and is not `1`
  have ht : (y * (Ideal.quotientMap (P.P ^ 1) (conjO F) (P.le_comap 1) y)⁻¹) *
      Ideal.quotientMap (P.P ^ 1) (conjO F) (P.le_comap 1)
        (y * (Ideal.quotientMap (P.P ^ 1) (conjO F) (P.le_comap 1) y)⁻¹) = 1 := by
    rw [map_mul, map_inv₀, hσσ]
    field_simp
  obtain ⟨u, hu, hut⟩ := exists_unitSet_residue_eq P hle ht
  -- but a unit vector is `1` modulo `𝔪`
  have hu1 : u - 1 ∈ 𝔪 := by
    have hnorm := mul_conjR_eq_one hu
    have hsq : (u - 1) ^ 2 ∈ 𝔪 := by
      have e : (u - 1) ^ 2 = -(u * (conjR F u - u)) + (1 - u) * 2 := by linear_combination hnorm
      rw [e]
      exact 𝔪.add_mem (𝔪.neg_mem (𝔪.mul_mem_left u (htriv u))) (𝔪.mul_mem_left _ h2)
    exact h𝔪.isPrime.mem_of_pow_mem 2 hsq
  have hres1 : ringResidue P hle (u - 1) = 0 := (hker (u - 1)).mp hu1
  rw [map_sub, map_one, sub_eq_zero, ringResidue_apply, hut] at hres1
  exact hσy ((mul_inv_eq_one₀ hσy0).mp hres1).symm

/-- **A stable prime with nine elements in its quotient** (what J3's proof builds, and what row 99's form reads; stated
by FS131-KJ1): a maximal ideal of `ℤ[U_F]` with nine elements in its quotient is cut out by a stable prime `P` of `F(i)`
with `𝓞 ⧸ P` of nine elements. (`3 ∈ 𝔪`; J1; by J2 the `Q + 1` norm-one elements of `𝓞 ⧸ P`, a field of `Q²` elements
with `Q ≡ 3 (mod 4)`, lie in the image of the ring, which has nine elements; so `Q = 3`.) -/
theorem exists_stablePrime_card_nine {𝔪 : Ideal (unitRing F)} (h𝔪 : 𝔪.IsMaximal)
    (h9 : Nat.card (unitRing F ⧸ 𝔪) = 9) :
    ∃ P : StablePrime F, Nat.card (𝓞 (fieldI F) ⧸ P.P ^ 1) = 9 := by
  classical
  -- `3 ∈ 𝔪`, so `𝔪 ≠ ⊥`
  have h3 : (3 : unitRing F) ∈ 𝔪 := by
    have h : Nat.card (unitRing F ⧸ 𝔪) • (1 : unitRing F ⧸ 𝔪) = 0 := card_nsmul_eq_zero'
    rw [h9, nsmul_eq_mul, mul_one] at h
    have h9m : (3 : unitRing F) * 3 ∈ 𝔪 := by
      rw [← Ideal.Quotient.eq_zero_iff_mem, map_mul, map_ofNat]
      have e : (3 : unitRing F ⧸ 𝔪) * 3 = ((9 : ℕ) : unitRing F ⧸ 𝔪) := by norm_num
      rw [e, h]
    exact (h𝔪.isPrime.mem_or_mem h9m).elim id id
  have hne : 𝔪 ≠ ⊥ := fun h => by
    rw [h, Ideal.mem_bot] at h3
    have h0 := congrArg (unitRing F).subtype h3
    rw [map_ofNat, map_zero] at h0
    norm_num at h0
  obtain ⟨P, hle, hker⟩ := exists_stablePrime_of_maximal h𝔪 hne
  haveI := isMaximal_pow_one P
  letI := Ideal.Quotient.field (P.P ^ 1)
  refine ⟨P, ?_⟩
  have hσσ := quotientMap_conjO_involutive P
  haveI : Finite (𝓞 (fieldI F) ⧸ P.P ^ 1) :=
    Ideal.finiteQuotientOfFreeOfNeBot _ (by rw [pow_one]; exact P.heightOne.ne_bot)
  letI : Fintype (𝓞 (fieldI F) ⧸ P.P ^ 1) := Fintype.ofFinite _
  -- the image of the ring has nine elements
  have hkerg : RingHom.ker (ringResidue P hle) = 𝔪 := by
    ext x
    rw [RingHom.mem_ker, ringResidue_apply]
    exact (hker x).symm
  have hrange : Nat.card (ringResidue P hle).range = 9 := by
    rw [← h9, ← hkerg]
    exact Nat.card_congr (RingHom.quotientKerEquivRange (ringResidue P hle)).symm.toEquiv
  -- characteristic 3
  have h3κ : (3 : 𝓞 (fieldI F) ⧸ P.P ^ 1) = 0 := by
    have h := (hker 3).mp h3
    rwa [← ringResidue_apply, map_ofNat] at h
  have h2κ : (2 : 𝓞 (fieldI F) ⧸ P.P ^ 1) ≠ 0 := fun h => one_ne_zero (by linear_combination h3κ - h)
  -- `i` modulo `P`
  obtain ⟨i, hi2, hci⟩ := exists_I_integer' (F := F)
  have hι2 : (Ideal.Quotient.mk (P.P ^ 1) i) ^ 2 = -1 := by rw [← map_pow, hi2, map_neg, map_one]
  have hσι : Ideal.quotientMap (P.P ^ 1) (conjO F) (P.le_comap 1) (Ideal.Quotient.mk (P.P ^ 1) i) =
      -Ideal.Quotient.mk (P.P ^ 1) i := by rw [Ideal.quotientMap_mk, hci, map_neg]
  obtain ⟨hQ2, hQ4⟩ := StandingFive.card_fixed_of_involution _ hσσ hι2 hσι h2κ
  generalize Nat.card ↥((Ideal.quotientMap (P.P ^ 1) (conjO F) (P.le_comap 1)).eqLocusField (RingHom.id _)) = Q
    at hQ2 hQ4
  have hcard : Fintype.card (𝓞 (fieldI F) ⧸ P.P ^ 1) = Q ^ 2 := by rw [← Nat.card_eq_fintype_card, hQ2]
  have hσne : Ideal.quotientMap (P.P ^ 1) (conjO F) (P.le_comap 1) ≠ RingHom.id _ := fun h => by
    rw [h, RingHom.id_apply] at hσι
    have hι0 : Ideal.Quotient.mk (P.P ^ 1) i = 0 := by
      have h2ι : (2 : 𝓞 (fieldI F) ⧸ P.P ^ 1) * Ideal.Quotient.mk (P.P ^ 1) i = 0 := by linear_combination hσι
      exact (mul_eq_zero.mp h2ι).resolve_left h2κ
    rw [hι0] at hι2
    norm_num at hι2
  have hpow := StandingFive.involution_eq_pow _ hσσ hσne hcard
  -- the `Q + 1` norm-one elements lie in the image of the ring
  have hle9 : Q + 1 ≤ 9 := by
    rw [← StandingFive.card_normOne hcard, ← hrange, ← Fintype.card_subtype, ← Nat.card_eq_fintype_card]
    refine Nat.card_le_card_of_injective
      (fun u : {u : 𝓞 (fieldI F) ⧸ P.P ^ 1 // u ^ (Q + 1) = 1} => (⟨u.1, ?_⟩ : (ringResidue P hle).range))
      fun u v h => Subtype.ext (Subtype.mk.inj h)
    have ht : u.1 * Ideal.quotientMap (P.P ^ 1) (conjO F) (P.le_comap 1) u.1 = 1 := by
      rw [hpow, ← pow_succ']
      exact u.2
    obtain ⟨v, -, hv⟩ := exists_unitSet_residue_eq P hle ht
    exact ⟨v, hv⟩
  -- `Q ≡ 3 (mod 4)` and `Q ≤ 8`: `Q = 3` or `7`, and `7² = 49` is not the order of a group killed by 3
  have hQ : Q = 3 := by
    have h37 : Q = 3 ∨ Q = 7 := by omega
    rcases h37 with h | h
    · exact h
    · exfalso
      have hd1 : addOrderOf (1 : 𝓞 (fieldI F) ⧸ P.P ^ 1) ∣ 3 :=
        addOrderOf_dvd_of_nsmul_eq_zero (by rw [nsmul_eq_mul, mul_one]; exact_mod_cast h3κ)
      have hd2 : addOrderOf (1 : 𝓞 (fieldI F) ⧸ P.P ^ 1) ∣ 49 := by
        have := addOrderOf_dvd_natCard (1 : 𝓞 (fieldI F) ⧸ P.P ^ 1)
        rwa [hQ2, h] at this
      have hd : addOrderOf (1 : 𝓞 (fieldI F) ⧸ P.P ^ 1) ∣ 1 := by
        have hg := Nat.dvd_gcd hd1 hd2
        rwa [show Nat.gcd 3 49 = 1 by norm_num] at hg
      exact one_ne_zero (AddMonoid.addOrderOf_eq_one_iff.mp (Nat.dvd_one.mp hd))
  rw [hQ2, hQ]
  norm_num

omit [NumberField F] in
/-- `F → F(i)`, the inclusion. -/
private noncomputable def toFieldIHom (F : Subfield ℝ) : F →+* fieldI F :=
  (Complex.ofRealHom.comp F.subtype).codRestrict (fieldI F) fun x => by
    show ((x : ℝ) : ℂ) ∈ fieldI F
    exact ⟨by simp, by simp⟩

/-- `𝓞 F → 𝓞 (F(i))`. -/
private noncomputable def upO (F : Subfield ℝ) : 𝓞 F →+* 𝓞 (fieldI F) := RingOfIntegers.mapRingHom (toFieldIHom F)

omit [NumberField F] in
/-- Conjugation fixes the integers of `F`. -/
private theorem conjO_upO (a : 𝓞 F) : conjO F (upO F a) = upO F a :=
  RingOfIntegers.ext (Subtype.ext (by
    show (starRingEnd ℂ) (((a : F) : ℝ) : ℂ) = (((a : F) : ℝ) : ℂ)
    exact Complex.conj_ofReal _))

omit [NumberField F] in
/-- **A stable prime with nine elements in its quotient lies over a prime of `F` with three**: `P ∩ 𝓞 F` is maximal, and
`𝓞 F ⧸ (P ∩ 𝓞 F)` lands in the fixed field of conjugation on `𝓞 ⧸ P`, which has three elements. Every subfield
`F ⊆ ℝ` (finiteness comes from the count). -/
theorem exists_maximal_card_three_of_stablePrime_card_nine (P : StablePrime F)
    (h9 : Nat.card (𝓞 (fieldI F) ⧸ P.P ^ 1) = 9) : ∃ 𝔭 : Ideal (𝓞 F), 𝔭.IsMaximal ∧ Nat.card (𝓞 F ⧸ 𝔭) = 3 := by
  classical
  haveI := isMaximal_pow_one P
  letI := Ideal.Quotient.field (P.P ^ 1)
  haveI : Finite (𝓞 (fieldI F) ⧸ P.P ^ 1) := Nat.finite_of_card_ne_zero (by rw [h9]; norm_num)
  have hσσ := quotientMap_conjO_involutive P
  -- characteristic 3, and the fixed field of conjugation has three elements
  have h3κ : (3 : 𝓞 (fieldI F) ⧸ P.P ^ 1) = 0 := by
    have h : Nat.card (𝓞 (fieldI F) ⧸ P.P ^ 1) • (1 : 𝓞 (fieldI F) ⧸ P.P ^ 1) = 0 := card_nsmul_eq_zero'
    rw [h9, nsmul_eq_mul, mul_one] at h
    have e : (3 : 𝓞 (fieldI F) ⧸ P.P ^ 1) * 3 = ((9 : ℕ) : 𝓞 (fieldI F) ⧸ P.P ^ 1) := by norm_num
    exact mul_self_eq_zero.mp (e.trans h)
  have h2κ : (2 : 𝓞 (fieldI F) ⧸ P.P ^ 1) ≠ 0 := fun h => one_ne_zero (by linear_combination h3κ - h)
  obtain ⟨i, hi2, hci⟩ := exists_I_integer' (F := F)
  have hι2 : (Ideal.Quotient.mk (P.P ^ 1) i) ^ 2 = -1 := by rw [← map_pow, hi2, map_neg, map_one]
  have hσι : Ideal.quotientMap (P.P ^ 1) (conjO F) (P.le_comap 1) (Ideal.Quotient.mk (P.P ^ 1) i) =
      -Ideal.Quotient.mk (P.P ^ 1) i := by rw [Ideal.quotientMap_mk, hci, map_neg]
  obtain ⟨hQ2, -⟩ := StandingFive.card_fixed_of_involution _ hσσ hι2 hσι h2κ
  have hQ : Nat.card ↥((Ideal.quotientMap (P.P ^ 1) (conjO F) (P.le_comap 1)).eqLocusField (RingHom.id _)) = 3 :=
    Nat.pow_left_injective (by norm_num : 2 ≠ 0) (show _ ^ 2 = 3 ^ 2 by rw [← hQ2, h9])
  -- the prime below, and its quotient inside `𝓞 ⧸ P`
  have hj : Function.Injective (Ideal.quotientMap (P.P ^ 1) (upO F) (le_refl ((P.P ^ 1).comap (upO F)))) :=
    Ideal.quotientMap_injective
  haveI : Finite (𝓞 F ⧸ (P.P ^ 1).comap (upO F)) := Finite.of_injective _ hj
  have hmax : ((P.P ^ 1).comap (upO F)).IsMaximal :=
    Ideal.Quotient.maximal_of_isField _ (Finite.isField_of_domain _)
  refine ⟨(P.P ^ 1).comap (upO F), hmax, ?_⟩
  have hfix : ∀ x : 𝓞 F ⧸ (P.P ^ 1).comap (upO F),
      Ideal.quotientMap (P.P ^ 1) (upO F) (le_refl ((P.P ^ 1).comap (upO F))) x ∈
        (Ideal.quotientMap (P.P ^ 1) (conjO F) (P.le_comap 1)).eqLocusField (RingHom.id _) := fun x => by
    obtain ⟨a, rfl⟩ := Ideal.Quotient.mk_surjective x
    show Ideal.quotientMap (P.P ^ 1) (conjO F) (P.le_comap 1)
        (Ideal.quotientMap (P.P ^ 1) (upO F) (le_refl _) (Ideal.Quotient.mk _ a)) =
      Ideal.quotientMap (P.P ^ 1) (upO F) (le_refl _) (Ideal.Quotient.mk _ a)
    rw [Ideal.quotientMap_mk, Ideal.quotientMap_mk, conjO_upO]
  have hle3 : Nat.card (𝓞 F ⧸ (P.P ^ 1).comap (upO F)) ≤ 3 := by
    rw [← hQ]
    exact Nat.card_le_card_of_injective
      (fun x => (⟨_, hfix x⟩ :
        ↥((Ideal.quotientMap (P.P ^ 1) (conjO F) (P.le_comap 1)).eqLocusField (RingHom.id _))))
      fun x y h => hj (Subtype.mk.inj h)
  -- three divides the order of the quotient
  have h3 : (3 : 𝓞 F ⧸ (P.P ^ 1).comap (upO F)) = 0 := hj (by rw [map_ofNat, map_zero]; exact h3κ)
  have hd1 : addOrderOf (1 : 𝓞 F ⧸ (P.P ^ 1).comap (upO F)) ∣ 3 :=
    addOrderOf_dvd_of_nsmul_eq_zero (by rw [nsmul_eq_mul, mul_one]; exact_mod_cast h3)
  have hne1 : addOrderOf (1 : 𝓞 F ⧸ (P.P ^ 1).comap (upO F)) ≠ 1 := fun h =>
    one_ne_zero (AddMonoid.addOrderOf_eq_one_iff.mp h)
  have hord := ((Nat.dvd_prime Nat.prime_three).mp hd1).resolve_left hne1
  have hd2 : 3 ∣ Nat.card (𝓞 F ⧸ (P.P ^ 1).comap (upO F)) := by
    have h := addOrderOf_dvd_natCard (1 : 𝓞 F ⧸ (P.P ^ 1).comap (upO F))
    rwa [hord] at h
  exact le_antisymm hle3 (Nat.le_of_dvd Nat.card_pos hd2)

/-- **J3 — nine elements in the ring, three in `𝓞 F`.** A maximal ideal of `ℤ[U_F]` with nine elements in its quotient
gives a maximal ideal of `𝓞 F` with three. -/
theorem exists_maximal_card_three_of_card_nine {𝔪 : Ideal (unitRing F)} (h𝔪 : 𝔪.IsMaximal)
    (h9 : Nat.card (unitRing F ⧸ 𝔪) = 9) : ∃ 𝔭 : Ideal (𝓞 F), 𝔭.IsMaximal ∧ Nat.card (𝓞 F ⧸ 𝔭) = 3 := by
  obtain ⟨P, hP⟩ := exists_stablePrime_card_nine h𝔪 h9
  exact exists_maximal_card_three_of_stablePrime_card_nine P hP

end Dictionary

/-! ## Clause (b) -/

/-- A graph that is not two-colourable has chromatic number at least three. -/
private theorem three_le_chromaticNumber_of_not_colorable_two {V : Type*} {G : SimpleGraph V} (h : ¬ G.Colorable 2) :
    3 ≤ G.chromaticNumber := by
  have h3 : ((3 : ℕ) : ℕ∞) ≤ G.chromaticNumber := by
    rw [SimpleGraph.le_chromaticNumber_iff_colorable]
    intro k hk
    by_contra hlt
    exact h (hk.mono (by omega))
  exact_mod_cast h3

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
  constructor
  · intro h3
    by_cases h2 : ((unitDistance ℂ).induce (planeOver F)).Colorable 2
    · exact Or.inl h2
    · obtain ⟨𝔪, h𝔪, h9⟩ := exists_maximal_card_nine_of_colorable_three F h3 h2
      exact Or.inr (exists_maximal_card_three_of_card_nine h𝔪 h9)
  · rintro (h2 | ⟨𝔭, h𝔭, hcard⟩)
    · exact h2.mono (by norm_num)
    · exact colorable_three_of_card_three F h𝔭 hcard

/-- **Clause (b), as claimed.** For a real number field `F` whose plane is not bipartite: `χ(F²) = 3` iff some prime of
`F` has residue field `𝔽₃`. Rests on Weil's bound (⟹). -/
theorem chromaticNumber_planeOver_eq_three_iff (F : Subfield ℝ) [NumberField F]
    (hnb : ¬ ((unitDistance ℂ).induce (planeOver F)).Colorable 2) :
    ((unitDistance ℂ).induce (planeOver F)).chromaticNumber = 3 ↔
      ∃ 𝔭 : Ideal (𝓞 F), 𝔭.IsMaximal ∧ Nat.card (𝓞 F ⧸ 𝔭) = 3 := by
  constructor
  · intro h
    have h3 : ((unitDistance ℂ).induce (planeOver F)).Colorable 3 :=
      SimpleGraph.chromaticNumber_le_iff_colorable.mp (by rw [h]; rfl)
    exact ((colorable_three_planeOver_iff F).mp h3).resolve_left hnb
  · intro h
    have h3 := (colorable_three_planeOver_iff F).mpr (Or.inr h)
    exact le_antisymm h3.chromaticNumber_le (three_le_chromaticNumber_of_not_colorable_two hnb)

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

/-- A natural number's class modulo `p`, read in `ZMod p`. -/
private theorem natCast_zmod_of_mod {m p r : ℕ} (h : m % p = r) : (m : ZMod p) = (r : ZMod p) := by
  rw [← h, ZMod.natCast_mod]

/-- **Three colours suffice** for `ℚ(√m)²` when `m ≡ 1 (mod 3)`, or `3 ∣ m` and `9 ∤ m` — a prime of `ℚ(√m)` with residue
field `𝔽₃` (split at `m ≡ 1`, ramified at `3 ∣ m`) and the three-colouring `x + y` of the plane over `𝔽₃`. No
squarefreeness. Prior art, value and map: `[Fischer1990]` Thm 9, p. 192 (squarefree `N ≢ 2 (mod 3)`; his additive maps
`(a₁ + b₁)/c` and `(a₁ + b₁ + a₂ + b₂)/c` modulo 3 are this residue followed by `x + y`). (`9 ∤ m` is needed: `m = 99` is
`ℚ(√11)`, which needs four.) -/
theorem colorable_three_planeOver_sqrt {m : ℕ} (h : m % 3 = 1 ∨ (3 ∣ m ∧ ¬ 9 ∣ m)) :
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {m}))).Colorable 3 := by
  rcases h with h1 | ⟨h3, h9⟩
  · refine colorable_planeOver_fieldOfRadicands {m} Nat.prime_three (by norm_num) ?_ finitePlane3_colorable_three
    rintro d rfl
    have hd : (d : ZMod 3) = 1 := by rw [natCast_zmod_of_mod h1, Nat.cast_one]
    exact ⟨by rw [hd]; decide, ⟨1, by rw [hd, mul_one]⟩⟩
  · have h := QuadraticPrime.exists_maximal_card_eq_of_ramified ∅ m Nat.prime_three (by norm_num) (by simp) h3 (by simpa using h9)
    rw [insert_empty_eq] at h
    obtain ⟨𝔭, h𝔭, hcard⟩ := h
    exact colorable_three_of_card_three _ h𝔭 hcard

/-- **The row at 3, at its proof's level**: `χ(ℚ(√m)²) = 3` for `m ≡ 3 (mod 4)` with `m ≡ 1 (mod 3)`, or with `3 ∣ m` and
`9 ∤ m` — no squarefreeness beyond that. The value is prior art (`[Fischer1990]` Thm 9 with the sentence after it,
p. 192, for squarefree `N ≡ 3, 7 (mod 12)`). -/
theorem chromaticNumber_planeOver_sqrt_eq_three_of_mod {m : ℕ} (h4 : m % 4 = 3)
    (h3 : m % 3 = 1 ∨ (3 ∣ m ∧ ¬ 9 ∣ m)) :
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {m}))).chromaticNumber = 3 :=
  le_antisymm (colorable_three_planeOver_sqrt h3).chromaticNumber_le
    (TorsionExtraction.three_le_chromaticNumber_planeOver_of_sqrt_mem h4
      (sqrt_mem_fieldOfRadicands (Set.mem_singleton m)))

/-- **The row at 3**: `χ(ℚ(√m)²) = 3` for squarefree `m ≡ 3, 7 (mod 12)`. Prior art: `[Fischer1990]` Thm 9 with the
sentence after it, p. 192 ("the chromatic number of the plane `ℚ(√N)²` is 3 when `N ≡ 3 or 7 mod 12`"); the upper half
here is NF1-S2 at 3 (`m ≡ 1 (mod 3)`) and its ramified clause (`3 ∣ m`), the lower half
`TorsionExtraction.three_le_chromaticNumber_planeOver_of_sqrt_mem` (his Thm 8). What is here is the kernel proof. -/
theorem chromaticNumber_planeOver_sqrt_eq_three {m : ℕ} (hm : Squarefree m) (h : m % 12 = 3 ∨ m % 12 = 7) :
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {m}))).chromaticNumber = 3 := by
  have h9 : ¬ 9 ∣ m := fun h9 => absurd (Nat.isUnit_iff.mp (hm 3 h9)) (by norm_num)
  refine chromaticNumber_planeOver_sqrt_eq_three_of_mod (by omega) ?_
  rcases h with h | h
  · exact Or.inr ⟨by omega, h9⟩
  · exact Or.inl (by omega)

/-- **Four colours suffice** for `ℚ(√m)²` when `m` is a nonzero square modulo 7 (`m ≡ 1, 2, 4`), or `7 ∣ m` and `49 ∤ m`
— a prime of `ℚ(√m)` with residue field `𝔽₇` and `finitePlane7_colorable_four`. No squarefreeness. Prior art
(`[Moorhouse2010]`, `[Madore2015]`: the residue plane; NF1-S2). -/
theorem colorable_four_planeOver_sqrt_of_seven {m : ℕ}
    (h7 : m % 7 = 1 ∨ m % 7 = 2 ∨ m % 7 = 4 ∨ (7 ∣ m ∧ ¬ 49 ∣ m)) :
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {m}))).Colorable 4 := by
  have hp7 : Nat.Prime 7 := by norm_num
  have unram : ∀ r s : ℕ, m % 7 = r → (r : ZMod 7) ≠ 0 → (r : ZMod 7) = s * s →
      ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {m}))).Colorable 4 := by
    intro r s hr hr0 hrs
    refine colorable_planeOver_fieldOfRadicands {m} hp7 (by norm_num) ?_ finitePlane7_colorable_four
    rintro d rfl
    have hd : (d : ZMod 7) = r := natCast_zmod_of_mod hr
    exact ⟨by rw [hd]; exact hr0, ⟨s, by rw [hd, hrs]⟩⟩
  rcases h7 with h | h | h | ⟨h7, h49⟩
  · exact unram 1 1 h (by decide) (by decide)
  · exact unram 2 3 h (by decide) (by decide)
  · exact unram 4 2 h (by decide) (by decide)
  · have h := QuadraticPrime.exists_maximal_card_eq_of_ramified ∅ m hp7 (by norm_num) (by simp) h7 (by simpa using h49)
    rw [insert_empty_eq] at h
    obtain ⟨𝔭, h𝔭, hcard⟩ := h
    exact colorable_planeOver_of_finitePlane _ ⟨h𝔭, by rw [hcard]⟩ hp7 hcard finitePlane7_colorable_four

/-- **The row at 4, through a prime above 7, at its proof's level**: `m ≡ 11 (mod 12)` with `m` a nonzero square modulo
7, or `7 ∣ m` and `49 ∤ m`. -/
theorem chromaticNumber_planeOver_sqrt_eq_four_of_seven_of_mod {m : ℕ} (h12 : m % 12 = 11)
    (h7 : m % 7 = 1 ∨ m % 7 = 2 ∨ m % 7 = 4 ∨ (7 ∣ m ∧ ¬ 49 ∣ m)) :
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {m}))).chromaticNumber = 4 :=
  le_antisymm (colorable_four_planeOver_sqrt_of_seven h7).chromaticNumber_le
    (TorsionExtraction.four_le_chromaticNumber_planeOver_fieldOfRadicands h12)

/-- **The row at 4, through a prime above 7**: squarefree `m ≡ 11 (mod 12)` with `m` a square modulo 7. Upper half:
NF1-S2 at 7 and `finitePlane7_colorable_four` (prior art). Lower half: this project's
`TorsionExtraction.four_le_chromaticNumber_planeOver_fieldOfRadicands`. -/
theorem chromaticNumber_planeOver_sqrt_eq_four_of_seven {m : ℕ} (hm : Squarefree m) (h12 : m % 12 = 11)
    (h7 : m % 7 = 0 ∨ m % 7 = 1 ∨ m % 7 = 2 ∨ m % 7 = 4) :
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {m}))).chromaticNumber = 4 := by
  have h49 : ¬ 49 ∣ m := fun h49 => absurd (Nat.isUnit_iff.mp (hm 7 h49)) (by norm_num)
  refine chromaticNumber_planeOver_sqrt_eq_four_of_seven_of_mod h12 ?_
  rcases h7 with h | h | h | h
  · exact Or.inr (Or.inr (Or.inr ⟨by omega, h49⟩))
  · exact Or.inl h
  · exact Or.inr (Or.inl h)
  · exact Or.inr (Or.inr (Or.inl h))

/-- **The row at 4, through the dyadic prime**: `χ(ℚ(√m)²) = 4` for `m ≡ 11 (mod 24)`, squarefree or not. Upper half:
`DyadicQuadratic.colorable_four_planeOver_sqrt` (the value is prior art: `[Fischer1990]` Thm 10(i), p. 193). Lower half:
this project's. -/
theorem chromaticNumber_planeOver_sqrt_eq_four_of_dyadic {m : ℕ} (h24 : m % 24 = 11) :
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {m}))).chromaticNumber = 4 :=
  le_antisymm (colorable_four_planeOver_sqrt (by omega)).chromaticNumber_le
    (TorsionExtraction.four_le_chromaticNumber_planeOver_fieldOfRadicands (by omega))

/-- **The row at 2**: `χ(ℚ(√m)²) = 2` for squarefree `m ≢ 3 (mod 4)` (prior art: `[Fischer1990]` Thm 8, p. 189; the
"if" half also `[Johnson1987]`). -/
theorem chromaticNumber_planeOver_sqrt_eq_two {m : ℕ} (hm : Squarefree m) (h4 : m % 4 ≠ 3) :
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {m}))).chromaticNumber = 2 :=
  le_antisymm (colorable_two_planeOver_sqrt hm h4).chromaticNumber_le (two_le_chromaticNumber_planeOver _)

/-- **The row at 4, in the claim's words** (NF4-THEOREM (a): "`4` for `m ≡ 11 (mod 12)` outside the classes
`47, 143, 167 (mod 168)`"): the three excluded classes are `m ≡ 23 (mod 24)` with `m` a non-square modulo 7, where neither
the dyadic prime nor a prime above 7 gives four colours. -/
theorem chromaticNumber_planeOver_sqrt_eq_four {m : ℕ} (hm : Squarefree m) (h12 : m % 12 = 11)
    (h168 : m % 168 ≠ 47 ∧ m % 168 ≠ 143 ∧ m % 168 ≠ 167) :
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {m}))).chromaticNumber = 4 := by
  by_cases h24 : m % 24 = 11
  · exact chromaticNumber_planeOver_sqrt_eq_four_of_dyadic h24
  · have e7 : m % 7 = m % 168 % 7 := (Nat.mod_mod_of_dvd m (by norm_num)).symm
    have e24 : m % 24 = m % 168 % 24 := (Nat.mod_mod_of_dvd m (by norm_num)).symm
    have hlt : m % 168 < 168 := Nat.mod_lt _ (by norm_num)
    have hr : m % 168 = 23 ∨ m % 168 = 71 ∨ m % 168 = 95 ∨ m % 168 = 119 := by omega
    refine chromaticNumber_planeOver_sqrt_eq_four_of_seven hm h12 ?_
    rcases hr with h | h | h | h <;> rw [h] at e7 <;> omega

/-- **NF4-THEOREM (a), the whole table as one statement.** For squarefree `m`: `χ(ℚ(√m)²) = 2` if `m ≢ 3 (mod 4)`;
`= 3` if `m ≡ 3, 7 (mod 12)`; `≥ 4` if `m ≡ 11 (mod 12)`, and `= 4` there outside the classes `47, 143, 167 (mod 168)`.
The lower bound at four is this project's; the values 2 and 3 and every upper bound are prior art (`[Fischer1990]`
Thms 8, 9, 10(i); the residue plane at 7). -/
theorem chromaticNumber_planeOver_sqrt_table {m : ℕ} (hm : Squarefree m) :
    (m % 4 ≠ 3 → ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {m}))).chromaticNumber = 2) ∧
    (m % 12 = 3 ∨ m % 12 = 7 → ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {m}))).chromaticNumber = 3) ∧
    (m % 12 = 11 → 4 ≤ ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {m}))).chromaticNumber) ∧
    (m % 12 = 11 → m % 168 ≠ 47 ∧ m % 168 ≠ 143 ∧ m % 168 ≠ 167 →
      ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {m}))).chromaticNumber = 4) :=
  ⟨chromaticNumber_planeOver_sqrt_eq_two hm, chromaticNumber_planeOver_sqrt_eq_three hm,
    TorsionExtraction.four_le_chromaticNumber_planeOver_fieldOfRadicands, chromaticNumber_planeOver_sqrt_eq_four hm⟩

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

/-! ## Spec: the models the line's docstrings name, and the table at four fields -/

/-- **A three-chromatic plane over a number field**: `χ(ℚ(√3)²) = 3` (the value is `[Fischer1990]` Thm 9, p. 192). It is
the model the docstrings of `Arith/ThreeColourCharacter`, `Arith/TorsionExtraction` and `Arith/ThreeColourCriterion` name
and could not hold. -/
theorem chromaticNumber_planeOver_sqrt_three :
    ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {3}))).chromaticNumber = 3 :=
  chromaticNumber_planeOver_sqrt_eq_three_of_mod (by norm_num) (Or.inr ⟨dvd_refl 3, by norm_num⟩)

/-- **`Θ₃(R_F) ≠ ∅` at `F = ℚ(√3)`**: the hypothesis of `TorsionExtraction.exists_torsion_mem_fieldBandSet` and
`tendsto_layer`, inhabited. -/
theorem fieldBandSet_three_nonempty_sqrt_three : (fieldBandSet (fieldOfRadicands {3}) (band 3)).Nonempty :=
  ThreeColourCharacter.fieldBandSet_three_nonempty_of_colorable _
    (colorable_three_planeOver_sqrt (Or.inr ⟨dvd_refl 3, by norm_num⟩))

/-- **A maximal ideal of `ℤ[U_F]` with nine elements in its quotient, at `F = ℚ(√3)`**: the hypotheses of
`exists_maximal_card_nine_of_colorable_three` hold there, and its conclusion is the hypothesis of J3 and of
`exists_stablePrime_card_nine`. Rests on Weil's bound, as that theorem does. -/
theorem exists_maximal_card_nine_sqrt_three :
    ∃ 𝔪 : Ideal (unitRing (fieldOfRadicands {3})), 𝔪.IsMaximal ∧ Nat.card (unitRing (fieldOfRadicands {3}) ⧸ 𝔪) = 9 :=
  exists_maximal_card_nine_of_colorable_three _ (colorable_three_planeOver_sqrt (Or.inr ⟨dvd_refl 3, by norm_num⟩))
    (TorsionExtraction.not_colorable_two_of_sqrt_mem (d := 3) (by norm_num)
      (sqrt_mem_fieldOfRadicands (Set.mem_singleton 3)))

/-- **A maximal ideal of `ℤ[U_F]` with trivial conjugation, at `F = ℚ(√2)`**: the hypothesis of J4, from the
two-colouring of `ℚ(√2)²`. -/
theorem exists_maximal_conj_trivial_sqrt_two :
    ∃ 𝔪 : Ideal (unitRing (fieldOfRadicands {2})), 𝔪.IsMaximal ∧ ∀ x, conjR (fieldOfRadicands {2}) x - x ∈ 𝔪 :=
  exists_maximal_conj_trivial_of_colorable_two _ (colorable_two_planeOver_sqrt_of_mod_four (Or.inr (by norm_num)))

-- The table at four fields: 2 at `√2`, 3 at `√7`, 4 at `√11` (the dyadic prime) and at `√23` (a prime above 7) —
-- the field `[Johnson2000]` p. 176 says to start at.
example : ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {2}))).chromaticNumber = 2 :=
  chromaticNumber_planeOver_sqrt_eq_two Nat.prime_two.squarefree (by norm_num)
example : ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {7}))).chromaticNumber = 3 :=
  chromaticNumber_planeOver_sqrt_eq_three_of_mod (by norm_num) (Or.inl (by norm_num))
example : ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {11}))).chromaticNumber = 4 :=
  chromaticNumber_planeOver_sqrt_eq_four_of_dyadic (by norm_num)
example : ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {23}))).chromaticNumber = 4 :=
  chromaticNumber_planeOver_sqrt_eq_four_of_seven_of_mod (by norm_num) (Or.inr (Or.inl (by norm_num)))
-- The three classes the table leaves at "at least four": 47, 143, 167 modulo 168.
example : 4 ≤ ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {47}))).chromaticNumber ∧
    4 ≤ ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {167}))).chromaticNumber :=
  ⟨TorsionExtraction.four_le_chromaticNumber_planeOver_fieldOfRadicands (by norm_num),
    TorsionExtraction.four_le_chromaticNumber_planeOver_fieldOfRadicands (by norm_num)⟩

end HadwigerNelson.ThreeFourColours

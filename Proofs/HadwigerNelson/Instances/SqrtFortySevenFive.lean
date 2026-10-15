import Proofs.HadwigerNelson.Rigidity.SqrtClassFive
import Proofs.HadwigerNelson.Instances.SqrtFortySeven

/-!
# `χ(ℚ(√47)²) = 5` (FS-131, job FS131-KM15; module M15, the first instance)

**Read aloud, against the informal claim** (`data/fs131/claims-NF2.md`, NF2-LEAF-23: "`NumberField` for `ℚ(√47)`'s
`Subfield ℝ`, and `5 ≤ localBound` there: every stable prime of `ℚ(√47, i)` and its target").

* `numberField_F47` — `ℚ(√47) ⊂ ℝ` is a number field (the library's instance for fields of square roots).
* `stablePrime_card_sqrt47` — **every stable prime of `ℚ(√47, i)` has a residue field of `p²` elements, `p` a prime
  `≡ 3 (mod 4)` modulo which `47` is a square** (`p = 47` included, where `47 ≡ 0`): no stable prime lies above 2, and the
  residue size `Q = pⁿ` of `Rigidity.stablePrime_card_of_two_notMem` has `n = 1` because `Q² ∣ p^[ℚ(√47, i) : ℚ]` and the
  degree is at most 4. So the targets are `Γ₁₁, Γ₁₉, Γ₂₃, Γ₃₁, Γ₄₃, Γ₄₇, Γ₆₇, …`.
* `five_le_localBound_sqrt47` — **`5 ≤ L(ℚ(√47))`**: `47` is in D:116's class (`Rigidity.five_le_localBound_of_isSquare_class`).
* `chromaticNumber_planeOver_sqrt47_eq_five` — **`χ(ℚ(√47)²) = 5`**, with no hypothesis: the chain's lower bound
  (`Rigidity.five_le_chromaticNumber_planeOver_of_five_le_localBound`) and the kernel's upper half
  (`chromaticNumber_planeOver_sqrt47_le_five`). `[AmbrusEtAl2023]` Theorem 1, which the chain's count reads, is a theorem
  of the library (`Plane.oneAvoidingDensityBound`), discharged at the chain's landing (FS131-LCH1). It answers
  `[Moorhouse2010]`'s question and the existence half of Soifer's Open Problem 55.1 (`CLAUDE.md` § Publication).

**What rests on what:** `#print axioms` of the value prints the standard three, the declared `positive_entropy_rigidity`
and `kloosterman_bound`, and, until the lines still running land, `sorryAx` through their leaves (record
`plans/FS131-LCH1-join.md`).

**Not claimed:** `L(ℚ(√47)) = 5`; that every listed `p` carries a stable prime (only `p = 11` is exhibited); that the value
is new mathematics.

**Inhabitants.** `StablePrime F47` is inhabited above 11 (`exists_stablePrime_eleven`): `1/11` is not in `ℤ[U]`, since
every unit vector has 11-integral coordinates (`unit_mem_A`).
-/

namespace HadwigerNelson.SqrtFortySeven

open SpectralChain NumberField SimpleGraph

/-- **`ℚ(√47)` is a number field**: `QuadraticPrime.instNumberFieldFieldOfRadicands` at `{47}`. -/
theorem numberField_F47 : NumberField F47 := inferInstance

/-- `[ℚ(√47, i) : ℚ] ≤ 4`: `F(i)` is the image of `F × F`, and `F47` is spanned by `1` and `√47`. -/
theorem finrank_fieldI_F47_le : Module.finrank ℚ (fieldI F47) ≤ 4 := by
  let j : (ℚ × ℚ) →ₗ[ℚ] F47 :=
    { toFun := fun q => (q.1 : F47) + (q.2 : F47) * ⟨s, sqrt47_mem⟩
      map_add' := fun x y => by simp only [Prod.fst_add, Prod.snd_add, Rat.cast_add]; ring
      map_smul' := fun c x => by
        simp only [Prod.smul_fst, Prod.smul_snd, smul_eq_mul, Rat.cast_mul, RingHom.id_apply, Rat.smul_def]
        ring }
  have hj : Function.Surjective j := fun x => by
    obtain ⟨a, b, hab⟩ := mem_q47_of_mem x
    exact ⟨(a, b), Subtype.ext (by simp [j, hab])⟩
  have h1 : Module.finrank ℚ F47 ≤ 2 := by
    have h := LinearMap.finrank_le_finrank_of_surjective hj
    rwa [Module.finrank_prod, Module.finrank_self] at h
  have h2 := LinearMap.finrank_le_finrank_of_surjective (toFieldI_surjective F47)
  rw [Module.finrank_prod, ← two_mul] at h2
  omega

/-- `47` is a square in `ℚ(√47)`. -/
theorem isSquare_fortySeven : IsSquare ((47 : ℕ) : F47) :=
  ⟨⟨s, sqrt47_mem⟩, Subtype.ext (by push_cast; exact s_mul_s.symm)⟩

/-- **Every stable prime of `ℚ(√47, i)` and its residue size**: `p²` elements, `p ≡ 3 (mod 4)` prime, `47` a square
modulo `p`. -/
theorem stablePrime_card_sqrt47 (P : StablePrime F47) :
    ∃ p : ℕ, p.Prime ∧ p % 4 = 3 ∧ IsSquare (47 : ZMod p) ∧ Nat.card (𝓞 (fieldI F47) ⧸ P.P) = p ^ 2 := by
  have h2 := Rigidity.two_notMem_of_isSquare P isSquare_fortySeven (by norm_num)
  obtain ⟨p, n, hp, hp4, hn, hpP, hcard, hsq⟩ := Rigidity.stablePrime_card_of_two_notMem P h2
  -- `n = 1`: `(pⁿ)² ∣ p^[L:ℚ]` and `[L:ℚ] ≤ 4`
  have hdvd : (p ^ n) ^ 2 ∣ p ^ Module.finrank ℚ (fieldI F47) := by
    have hle : Ideal.span {((p : ℕ) : 𝓞 (fieldI F47))} ≤ P.P := by
      rw [Ideal.span_le, Set.singleton_subset_iff]
      exact hpP
    have h := Ideal.absNorm_dvd_absNorm_of_le hle
    rwa [Ideal.absNorm_span_natCast, RingOfIntegers.rank, Ideal.absNorm_apply, Submodule.cardQuot_apply, hcard] at h
  have hle : n * 2 ≤ 4 := by
    rw [← pow_mul] at hdvd
    exact ((Nat.pow_dvd_pow_iff_le_right hp.one_lt).1 hdvd).trans finrank_fieldI_F47_le
  obtain rfl : n = 1 := by obtain ⟨j, rfl⟩ := hn; omega
  exact ⟨p, hp, hp4, by simpa using hsq 47 isSquare_fortySeven, by rw [hcard, pow_one]⟩

/-- **A stable prime above 11** — the model of `StablePrime F47`: `1/11 ∉ ℤ[U]`, since every unit vector of `ℚ(√47)²` has
11-integral coordinates (`unit_mem_A`), and `UpperHalf.inv_natCast_mem_unitRingOver_iff_forall_stablePrime`. -/
theorem exists_stablePrime_eleven : ∃ P : StablePrime F47, (11 : 𝓞 (fieldI F47)) ∈ P.P := by
  -- the points of `ℂ` whose two coordinates lie in `A`, a subring
  let S : Subring ℂ :=
    { carrier := {z | ∃ x y : A, z = (((x : F47) : ℝ) : ℂ) + (((y : F47) : ℝ) : ℂ) * Complex.I}
      mul_mem' := by
        rintro _ _ ⟨x, y, rfl⟩ ⟨x', y', rfl⟩
        refine ⟨x * x' - y * y', x * y' + y * x', ?_⟩
        push_cast
        linear_combination (((y : F47) : ℝ) * ((y' : F47) : ℝ) : ℂ) * Complex.I_sq
      one_mem' := ⟨1, 0, by simp⟩
      add_mem' := by
        rintro _ _ ⟨x, y, rfl⟩ ⟨x', y', rfl⟩
        exact ⟨x + x', y + y', by push_cast; ring⟩
      zero_mem' := ⟨0, 0, by simp⟩
      neg_mem' := by
        rintro _ ⟨x, y, rfl⟩
        exact ⟨-x, -y, by push_cast; ring⟩ }
  -- every unit vector has coordinates in `A` (`unit_mem_A`), so `ℤ[U] ⊆ S`
  have hle : UnitRing.unitRingOver F47 ≤ S := by
    refine Subring.closure_le.mpr ?_
    rintro z ⟨⟨hre, him⟩, h1⟩
    have hv : (⟨z.re, hre⟩ : F47) ^ 2 + (⟨z.im, him⟩ : F47) ^ 2 = 1 := Subtype.ext (by
      have h := Complex.sq_norm z
      rw [h1, Complex.normSq_apply] at h
      push_cast
      linear_combination -h)
    obtain ⟨hA1, hA2⟩ := unit_mem_A (⟨z.re, hre⟩, ⟨z.im, him⟩) hv
    exact ⟨⟨_, hA1⟩, ⟨_, hA2⟩, by simp [Complex.re_add_im]⟩
  -- `1/11` is not in `S`: its rational coordinate is not 11-integral
  have hnot : ((11 : ℕ) : ℂ)⁻¹ ∉ UnitRing.unitRingOver F47 := by
    intro h
    obtain ⟨x, y, hxy⟩ := hle h
    have hre : ((x : F47) : ℝ) = ((1 / 11 : ℚ) : ℝ) + ((0 : ℚ) : ℝ) * s := by
      have := congrArg Complex.re hxy
      simp at this
      push_cast
      linarith
    have hx := (mem_A.mp x.2).1
    rw [(coords_of_eq hre).1] at hx
    revert hx
    show ¬ (((1 / 11 : ℚ).den : ℕ) : ZMod 11) ≠ 0
    decide +kernel
  have h := (UpperHalf.inv_natCast_mem_unitRingOver_iff_forall_stablePrime F47 (n := 11) (by norm_num)).not.mp hnot
  push Not at h
  obtain ⟨P, hP⟩ := h
  exact ⟨P, by simpa using hP⟩

/-- **`5 ≤ L(ℚ(√47))`**. -/
theorem five_le_localBound_sqrt47 : 5 ≤ localBound F47 :=
  Rigidity.five_le_localBound_of_isSquare_class F47 isSquare_fortySeven (by norm_num)

/-- **`χ(ℚ(√47)²) = 5`**. -/
theorem chromaticNumber_planeOver_sqrt47_eq_five :
    ((unitDistance ℂ).induce (planeOver F47)).chromaticNumber = 5 :=
  le_antisymm chromaticNumber_planeOver_sqrt47_le_five
    (Rigidity.five_le_chromaticNumber_planeOver_of_five_le_localBound F47 five_le_localBound_sqrt47)

/-! ## Spec -/

-- The listed residue characteristics: `47` is a square modulo 11, 19, 23, 31, 43 and 47, and not modulo 3 or 7.
example : IsSquare (47 : ZMod 11) ∧ IsSquare (47 : ZMod 19) ∧ IsSquare (47 : ZMod 23) ∧ IsSquare (47 : ZMod 31) ∧
    IsSquare (47 : ZMod 43) ∧ IsSquare (47 : ZMod 47) := by decide
example : ¬ IsSquare (47 : ZMod 3) ∧ ¬ IsSquare (47 : ZMod 7) := by decide

end HadwigerNelson.SqrtFortySeven

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
`a ∈ R`; `u = a/ā` is a unit vector reducing to `(x₂/x̄₂, x₃/x̄₃)` (`exists_unitSet_mul_conjR_eq`). So either `τ₃` never
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
declaration on this line exhibits; `exists_maximal_conj_trivial_of_colorable_two` at `F = ℚ(√2)`
(`DyadicQuadratic.colorable_two_planeOver_sqrt`, downstream of this module). The two field cases: `𝔽₈₁` has no
model of `exists_normOne_zero_of_card_ne_nine`'s `ι` with `σ ι = −ι` (`ι ∈ 𝔽₉` is fixed by `x ↦ x⁹`); its first model is
`𝔽₂₇[i]`, the field of `27²` elements; `eq_zero_of_forall_normOne_eq` at `𝔽₄` with Frobenius, `e = 0`.
-/

namespace HadwigerNelson.ThreeColourCriterion

open HadwigerNelson.CharacterColouring HadwigerNelson.SpectralChain HadwigerNelson.StandingFive SimpleGraph

/-! ## §1 Finite rings with an involution (no field `F` here) -/

/-- **The floor at four, on Weil's bound**: `χ(Γ_Q) ≥ 4` for `Q ≡ 3 (mod 4)`, `Q ≥ 14` — every `Q = 3^f ≥ 27` with `f`
odd. (`targetFloor_of_charSum` at `m = 2√Q`: `3·2√Q < Q + 1 + 2√Q`.) Rests on the import. -/
theorem targetFloor_four_weil {Q : ℕ} (hQ4 : Q % 4 = 3) (hQ : 14 ≤ Q) : TargetFloor 4 Q := by
  have hQr : (14 : ℝ) ≤ Q := by exact_mod_cast hQ
  have hs : Real.sqrt Q < ((Q : ℝ) + 1) / 4 := by
    rw [Real.sqrt_lt' (by linarith)]
    nlinarith [mul_nonneg (show (0 : ℝ) ≤ Q by linarith) (show (0 : ℝ) ≤ (Q : ℝ) - 14 by linarith)]
  refine targetFloor_of_charSum 4 Q (m := 2 * Real.sqrt Q)
    (mul_pos two_pos (Real.sqrt_pos.mpr (by linarith))) ?_
    fun k _ _ _ hcard ψ hψ => normOne_charSum_ge hQ4 hcard
      (fun F _ _ _ hF =>
        kloostermanBound_of_ringChar_ne_two F (ringChar_ne_two_of_card_mod_four (by rw [hF]; exact hQ4))) ψ hψ
  norm_num
  linarith

/-- **Hilbert 90 for a field with an involution** (every field: no finiteness is read): a norm-one element is
`y / σ y`. (Read by the field case at 3 below and, at a stable prime's residue field, by the joining module.) -/
theorem exists_mul_conj_inv_eq_of_mul_conj_eq_one {k : Type*} [Field k] (σ : k →+* k)
    (hσσ : ∀ x, σ (σ x) = x) (hσ : σ ≠ RingHom.id k) {t : k} (ht : t * σ t = 1) :
    ∃ y : kˣ, (y : k) * σ ((y⁻¹ : kˣ) : k) = t := by
  -- The resolvent `w = a + t·σ a` satisfies `t·σ w = w`; were it `0` for every `a`, then `t = −1` and `σ = id`.
  obtain ⟨a, ha⟩ : ∃ a : k, a + t * σ a ≠ 0 := by
    by_contra hall
    push Not at hall
    have h1 := hall 1
    rw [map_one, mul_one] at h1
    refine hσ (RingHom.ext fun a => ?_)
    have h2 := hall a
    rw [RingHom.id_apply]
    linear_combination (σ a) * h1 - h2
  have hfix : t * σ (a + t * σ a) = a + t * σ a := by
    rw [map_add, map_mul, hσσ a]
    linear_combination a * ht
  have hσw : σ (a + t * σ a) ≠ 0 := (map_ne_zero σ).mpr ha
  refine ⟨Units.mk0 _ ha, ?_⟩
  rw [Units.val_inv_eq_inv_val, Units.val_mk0, map_inv₀, eq_comm, eq_mul_inv_iff_mul_eq₀ hσw]
  exact hfix

/-- **The field case at 3 (FS91-J02-L4(a))**: in a finite field of characteristic 3 with an involution `σ`, an element
`ι` with `ι² = −1`, `σ ι = −ι`, and not nine elements, every additive functional into `𝔽₃` vanishes somewhere on the
norm-one group `{y / σ y}`. Rests on Weil's bound (`targetFloor_four_weil`: the functional would three-colour the
field's target). -/
theorem exists_normOne_zero_of_card_ne_nine {k : Type} [Field k] [Finite k] [CharP k 3] (σ : k →+* k)
    (hσσ : ∀ x, σ (σ x) = x) {ι : k} (hι : ι * ι = -1) (hσι : σ ι = -ι) (hcard : Nat.card k ≠ 9) (lam : k →+ ZMod 3) :
    ∃ y : kˣ, lam ((y : k) * σ ((y⁻¹ : kˣ) : k)) = 0 := by
  by_contra hne
  push Not at hne
  have h2 : (2 : k) ≠ 0 := by
    intro h
    have h3 : ((3 : ℕ) : k) = 0 := CharP.cast_eq_zero k 3
    push_cast at h3
    exact one_ne_zero (by linear_combination h3 - h : (1 : k) = 0)
  have hι0 : ι ≠ 0 := by
    rintro rfl
    simp at hι
  have hσne : σ ≠ RingHom.id k := by
    intro h
    rw [h, RingHom.id_apply] at hσι
    exact hι0 (mul_left_cancel₀ h2 (by linear_combination hσι))
  -- `lam` is a proper colouring of the field's target with the three elements of `ZMod 3`
  have hcol : (normOneCayley k σ).Colorable 3 := by
    let C : (normOneCayley k σ).Coloring (ZMod 3) := SimpleGraph.Coloring.mk (fun x => lam x) (by
      intro x y hadj heq
      have heq' : lam x = lam y := heq
      rw [normOneCayley, SimpleGraph.fromRel_adj] at hadj
      obtain ⟨-, h | h⟩ := hadj
      · obtain ⟨u, hu⟩ := exists_mul_conj_inv_eq_of_mul_conj_eq_one σ hσσ hσne h
        refine hne u ?_
        rw [hu, map_sub, heq', sub_self]
      · obtain ⟨u, hu⟩ := exists_mul_conj_inv_eq_of_mul_conj_eq_one σ hσσ hσne h
        refine hne u ?_
        rw [hu, map_sub, heq', sub_self])
    have h := C.colorable
    rwa [ZMod.card] at h
  obtain ⟨Q, hQ2, hQ4⟩ : ∃ Q : ℕ, Nat.card k = Q ^ 2 ∧ Q % 4 = 3 :=
    ⟨_, card_fixed_of_involution σ hσσ (ι := ι) (by rw [pow_two]; exact hι) hσι h2⟩
  rcases lt_or_ge Q 14 with hlt | hge
  · -- `Q ∈ {3, 7, 11}`, and `3 ∣ Q²`: `Q = 3`, nine elements
    have h3dvd : 3 ∣ Q ^ 2 := by
      cases nonempty_fintype k
      rw [← hQ2, Nat.card_eq_fintype_card]
      exact (CharP.cast_eq_zero_iff k 3 _).mp (Nat.cast_card_eq_zero k)
    have hQ3 : Q = 3 := by
      interval_cases Q <;> first | rfl | (exfalso; revert hQ4; decide) | (exfalso; revert h3dvd; decide)
    exact hcard (by rw [hQ2, hQ3]; norm_num)
  · -- Weil's bound: the target needs four colours
    have h4 := (targetFloor_four_weil hQ4 hge k σ hσσ hσne hQ2).trans hcol.chromaticNumber_le
    exact absurd (by exact_mod_cast h4 : (4 : ℕ) ≤ 3) (by norm_num)

/-- **The field case at 2 (FS91-J02-L4(b))**: in a finite field of characteristic 2 with an endomorphism `σ ≠ id`, an
additive functional into `𝔽₂` that is constant on the group `{y / σ y}` is `0` there (the group is a non-trivial subgroup
of `kˣ`, so it has odd order and sums to `0`; for an involution it is the norm-one group, of order `Q + 1 ≥ 3`). `σ` need
not be an involution. No outside theorem. -/
theorem eq_zero_of_forall_normOne_eq {k : Type*} [Field k] [Finite k] [CharP k 2] (σ : k →+* k)
    (hσ : σ ≠ RingHom.id k) (lam : k →+ ZMod 2) {e : ZMod 2}
    (h : ∀ y : kˣ, lam ((y : k) * σ ((y⁻¹ : kˣ) : k)) = e) : e = 0 := by
  cases nonempty_fintype k
  classical
  -- the elements `y / σ y` form a subgroup of `kˣ`: the range of `φ`
  let φ : kˣ →* kˣ := MonoidHom.id kˣ / Units.map (σ : k →* k)
  have hφ : ∀ y : kˣ, ((φ y : kˣ) : k) = (y : k) * σ ((y⁻¹ : kˣ) : k) := fun y => by
    simp [φ, div_eq_mul_inv]
  have hG : φ.range ≠ ⊥ := by
    obtain ⟨a, ha⟩ : ∃ a, σ a ≠ a := by
      by_contra hall
      push Not at hall
      exact hσ (RingHom.ext hall)
    have ha0 : a ≠ 0 := by
      rintro rfl
      exact ha (map_zero σ)
    intro hbot
    have hmem : φ (Units.mk0 a ha0) ∈ φ.range := ⟨_, rfl⟩
    rw [hbot, Subgroup.mem_bot] at hmem
    have h1 := congrArg Units.val hmem
    rw [hφ, Units.val_one, Units.val_inv_eq_inv_val, Units.val_mk0, map_inv₀] at h1
    exact ha ((mul_inv_eq_one₀ ((map_ne_zero σ).mpr ha0)).mp h1).symm
  have hsum : ∑ x : φ.range, ((x : kˣ) : k) = 0 := FiniteField.sum_subgroup_units_eq_zero hG
  have hlam : ∀ x : φ.range, lam ((x : kˣ) : k) = e := by
    rintro ⟨_, y, rfl⟩
    rw [hφ]
    exact h y
  have hsmul : Fintype.card φ.range • e = 0 := by
    have h0 := congrArg lam hsum
    rw [map_sum, map_zero, Finset.sum_congr rfl fun x _ => hlam x, Finset.sum_const, Finset.card_univ] at h0
    exact h0
  -- its order divides `|k| − 1`, which is odd
  have hodd : Odd (Fintype.card φ.range) := by
    have hdvd : Fintype.card φ.range ∣ Fintype.card kˣ := by
      have h := Subgroup.card_subgroup_dvd_card φ.range
      rwa [Nat.card_eq_fintype_card, Nat.card_eq_fintype_card] at h
    have heven : Fintype.card k % 2 = 0 := FiniteField.even_card_of_char_two (ringChar.eq k 2)
    have hpos : 0 < Fintype.card k := Fintype.card_pos
    have hodd' : Odd (Fintype.card kˣ) := by
      rw [Fintype.card_units, Nat.odd_iff]
      omega
    exact hodd'.of_dvd_nat hdvd
  rwa [nsmul_eq_mul, ZMod.natCast_eq_one_iff_odd.mpr hodd, one_mul] at hsmul

/-- The map an involution induces on a quotient by an ideal it fixes is an involution. -/
private theorem quotientMap_involutive {A : Type*} [CommRing A] (c : A →+* A) (hcc : ∀ x, c (c x) = x) {I : Ideal A}
    (h : I ≤ I.comap c) (x : A ⧸ I) : Ideal.quotientMap I c h (Ideal.quotientMap I c h x) = x := by
  obtain ⟨x, rfl⟩ := Ideal.Quotient.mk_surjective x
  rw [Ideal.quotientMap_mk, Ideal.quotientMap_mk, hcc]

/-- A quotient of a ring of prime characteristic `p` by a maximal ideal has characteristic `p`. -/
private theorem charP_quotient_of_isMaximal {A : Type*} [CommRing A] (p : ℕ) [hp : Fact p.Prime] [CharP A p]
    (I : Ideal A) [I.IsMaximal] : CharP (A ⧸ I) p :=
  haveI : Nontrivial (A ⧸ I) := Ideal.Quotient.nontrivial_iff.mpr (Ideal.IsMaximal.ne_top inferInstance)
  ringChar.of_eq (CharP.ringChar_of_prime_eq_zero hp.out
    (by rw [← map_natCast (Ideal.Quotient.mk I), CharP.cast_eq_zero A p, map_zero]))

/-- **The shared reduction of the two parts** (FS91-J02-L3; `plans/FS131-KN5-three-four-colours-passes.md` § Stage 3, R).
For a finite commutative ring `A` of prime characteristic `p`, an endomorphism `c` fixing each maximal ideal and an
additive `l : A →+ ZMod p`, there is one additive functional per residue field such that for every family of units of the
residue fields some unit `x` of `A` has `l (x / c x) = Σ_I lam I (y I / c̄ (y I))`. (`x ↦ x ^ pⁿ` is additive and kills the
nilradical, so `l ∘ (·) ^ pⁿ` lives on `A ⧸ nilradical A = Π_I A ⧸ I`; a family of units lifts to a unit `a`, and
`x = a ^ pⁿ`.) -/
private theorem exists_factor_functionals {A : Type} [CommRing A] [Finite A] (p : ℕ) [Fact p.Prime] [CharP A p]
    [Fintype (MaximalSpectrum A)] (c : A →+* A) (hmax : ∀ 𝔪 : Ideal A, 𝔪.IsMaximal → 𝔪.comap c = 𝔪)
    (l : A →+ ZMod p) :
    ∃ lam : ∀ I : MaximalSpectrum A, A ⧸ I.asIdeal →+ ZMod p,
      ∀ y : ∀ I : MaximalSpectrum A, (A ⧸ I.asIdeal)ˣ, ∃ x : Aˣ,
        l ((x : A) * c ((x⁻¹ : Aˣ) : A)) = ∑ I : MaximalSpectrum A, lam I ((y I : A ⧸ I.asIdeal) *
          Ideal.quotientMap I.asIdeal c (hmax I.asIdeal I.isMaximal).ge
            (((y I)⁻¹ : (A ⧸ I.asIdeal)ˣ) : A ⧸ I.asIdeal)) := by
  classical
  let π : A →+* (∀ I : MaximalSpectrum A, A ⧸ I.asIdeal) := RingHom.pi fun I => Ideal.Quotient.mk I.asIdeal
  have he : ∀ a : A, IsArtinianRing.quotNilradicalEquivPi A (Ideal.Quotient.mk (nilradical A) a) = π a :=
    fun a => (IsArtinianRing.quotNilradicalEquivPi A).commutes a
  have hπsurj : Function.Surjective π := fun v => by
    obtain ⟨a, ha⟩ := Ideal.Quotient.mk_surjective ((IsArtinianRing.quotNilradicalEquivPi A).symm v)
    exact ⟨a, by rw [← he, ha, AlgEquiv.apply_symm_apply]⟩
  have hπker : ∀ a, π a = 0 → a ∈ nilradical A := fun a ha => by
    rw [← he] at ha
    exact Ideal.Quotient.eq_zero_iff_mem.mp
      ((map_eq_zero_iff _ (IsArtinianRing.quotNilradicalEquivPi A).injective).mp ha)
  -- one exponent kills the nilradical
  obtain ⟨n, hn⟩ : ∃ n : ℕ, ∀ a, π a = 0 → a ^ p ^ n = 0 := by
    obtain ⟨n, hn⟩ := IsArtinianRing.isNilpotent_nilradical (R := A)
    refine ⟨n, fun a ha => pow_eq_zero_of_le (Nat.lt_pow_self (Fact.out : p.Prime).one_lt).le ?_⟩
    have h1 : a ^ n ∈ nilradical A ^ n := Ideal.pow_mem_pow (hπker a ha) n
    rw [hn] at h1
    simpa using h1
  -- `l ∘ (·) ^ pⁿ` descends along `π`
  let l' : A →+ ZMod p := l.comp (iterateFrobenius A p n).toAddMonoidHom
  have hl' : ∀ a, l' a = l (a ^ p ^ n) := fun a => congrArg l (iterateFrobenius_def p n a)
  have hker : π.toAddMonoidHom.ker ≤ l'.ker := fun a ha => by
    rw [AddMonoidHom.mem_ker] at ha ⊢
    rw [hl', hn a ha, map_zero]
  let L : (∀ I : MaximalSpectrum A, A ⧸ I.asIdeal) →+ ZMod p :=
    π.toAddMonoidHom.liftOfRightInverse (Function.surjInv hπsurj) (Function.rightInverse_surjInv hπsurj) ⟨l', hker⟩
  have hL : ∀ a, L (π a) = l' a := fun a =>
    AddMonoidHom.liftOfRightInverse_comp_apply π.toAddMonoidHom _ (Function.rightInverse_surjInv hπsurj) ⟨l', hker⟩ a
  refine ⟨fun I => L.comp (AddMonoidHom.single (fun I : MaximalSpectrum A => A ⧸ I.asIdeal) I), fun y => ?_⟩
  -- lift the family of units to a unit of `A`
  obtain ⟨a, ha⟩ := hπsurj fun I => (y I : A ⧸ I.asIdeal)
  have hmk : ∀ I : MaximalSpectrum A, Ideal.Quotient.mk I.asIdeal a = (y I : A ⧸ I.asIdeal) := fun I => congrFun ha I
  have hu : IsUnit a := by
    by_contra hnu
    obtain ⟨𝔪, h𝔪, ha𝔪⟩ := exists_max_ideal_of_mem_nonunits hnu
    have h0 := hmk ⟨𝔪, h𝔪⟩
    rw [Ideal.Quotient.eq_zero_iff_mem.mpr ha𝔪] at h0
    haveI : Nontrivial (A ⧸ 𝔪) := Ideal.Quotient.nontrivial_iff.mpr h𝔪.ne_top
    exact (y ⟨𝔪, h𝔪⟩).ne_zero h0.symm
  obtain ⟨x, rfl⟩ := hu
  refine ⟨x ^ p ^ n, ?_⟩
  have hx : ((x ^ p ^ n : Aˣ) : A) * c (((x ^ p ^ n)⁻¹ : Aˣ) : A) = ((x : A) * c ((x⁻¹ : Aˣ) : A)) ^ p ^ n := by
    rw [← inv_pow, Units.val_pow_eq_pow_val, Units.val_pow_eq_pow_val, map_pow, mul_pow]
  rw [hx, ← hl', ← hL, ← Finset.univ_sum_single (π ((x : A) * c ((x⁻¹ : Aˣ) : A))), map_sum]
  refine Finset.sum_congr rfl fun I _ => ?_
  have hinv : (((y I)⁻¹ : (A ⧸ I.asIdeal)ˣ) : A ⧸ I.asIdeal) = Ideal.Quotient.mk I.asIdeal ((x⁻¹ : Aˣ) : A) :=
    Units.inv_eq_of_mul_eq_one_right (by rw [← hmk I, ← map_mul, Units.mul_inv, map_one])
  rw [hinv, Ideal.quotientMap_mk, ← hmk I, ← map_mul]
  rfl

/-- **The three-part (FS91-J02-L3, L4(a) and T1 step 4, in one finite ring).** A finite commutative ring of
characteristic 3 with an involution `c` fixing each maximal ideal, an element `ι` with `ι² = −1`, `c ι = −ι`, and an
additive functional that never vanishes on `{x / c x : x a unit}`: some maximal ideal has nine elements in its quotient.
Rests on Weil's bound. -/
theorem exists_maximal_card_nine {A : Type} [CommRing A] [Finite A] [CharP A 3] (c : A →+* A) (hcc : ∀ x, c (c x) = x)
    (hmax : ∀ 𝔪 : Ideal A, 𝔪.IsMaximal → 𝔪.comap c = 𝔪) {ι : A} (hι : ι * ι = -1) (hcι : c ι = -ι)
    (l : A →+ ZMod 3) (hl : ∀ x : Aˣ, l ((x : A) * c ((x⁻¹ : Aˣ) : A)) ≠ 0) :
    ∃ 𝔪 : Ideal A, 𝔪.IsMaximal ∧ Nat.card (A ⧸ 𝔪) = 9 := by
  classical
  haveI : Fact (Nat.Prime 3) := ⟨Nat.prime_three⟩
  letI : Fintype (MaximalSpectrum A) := Fintype.ofFinite _
  obtain ⟨lam, hlam⟩ := exists_factor_functionals 3 c hmax l
  by_contra hno
  push Not at hno
  -- no residue field has nine elements, so each factor's functional vanishes at some `y / c̄ y` (the field case at 3)
  have hzero : ∀ I : MaximalSpectrum A, ∃ y : (A ⧸ I.asIdeal)ˣ, lam I ((y : A ⧸ I.asIdeal) *
      Ideal.quotientMap I.asIdeal c (hmax I.asIdeal I.isMaximal).ge ((y⁻¹ : (A ⧸ I.asIdeal)ˣ) : A ⧸ I.asIdeal)) = 0 := by
    intro I
    haveI := I.isMaximal
    letI : Field (A ⧸ I.asIdeal) := Ideal.Quotient.field I.asIdeal
    haveI : Finite (A ⧸ I.asIdeal) := Finite.of_surjective _ Ideal.Quotient.mk_surjective
    haveI : CharP (A ⧸ I.asIdeal) 3 := charP_quotient_of_isMaximal 3 I.asIdeal
    exact exists_normOne_zero_of_card_ne_nine (Ideal.quotientMap I.asIdeal c (hmax I.asIdeal I.isMaximal).ge)
      (quotientMap_involutive c hcc _) (ι := Ideal.Quotient.mk I.asIdeal ι)
      (by rw [← map_mul, hι, map_neg, map_one]) (by rw [Ideal.quotientMap_mk, hcι, map_neg])
      (hno I.asIdeal I.isMaximal) (lam I)
  choose y hy using hzero
  obtain ⟨x, hx⟩ := hlam y
  exact hl x (by rw [hx]; exact Finset.sum_eq_zero fun I _ => hy I)

/-- **The two-part (FS91-J02-L4(b) and T1 step 5).** A finite commutative ring of characteristic 2 with an endomorphism `c`
fixing each maximal ideal and an additive functional equal to 1 on `{x / c x : x a unit}`: `c` is the identity modulo
some maximal ideal. No outside theorem. -/
theorem exists_maximal_conj_trivial {A : Type} [CommRing A] [Finite A] [CharP A 2] (c : A →+* A)
    (hmax : ∀ 𝔪 : Ideal A, 𝔪.IsMaximal → 𝔪.comap c = 𝔪)
    (l : A →+ ZMod 2) (hl : ∀ x : Aˣ, l ((x : A) * c ((x⁻¹ : Aˣ) : A)) = 1) :
    ∃ 𝔪 : Ideal A, 𝔪.IsMaximal ∧ ∀ x, c x - x ∈ 𝔪 := by
  classical
  haveI : Fact (Nat.Prime 2) := ⟨Nat.prime_two⟩
  letI : Fintype (MaximalSpectrum A) := Fintype.ofFinite _
  obtain ⟨lam, hlam⟩ := exists_factor_functionals 2 c hmax l
  by_contra hno
  push Not at hno
  -- `g I y`: the factor's functional at `y / c̄ y`
  let g : ∀ I : MaximalSpectrum A, (A ⧸ I.asIdeal)ˣ → ZMod 2 := fun I y => lam I ((y : A ⧸ I.asIdeal) *
    Ideal.quotientMap I.asIdeal c (hmax I.asIdeal I.isMaximal).ge ((y⁻¹ : (A ⧸ I.asIdeal)ˣ) : A ⧸ I.asIdeal))
  have hsum : ∀ y : ∀ I : MaximalSpectrum A, (A ⧸ I.asIdeal)ˣ, ∑ I, g I (y I) = 1 := fun y => by
    obtain ⟨x, hx⟩ := hlam y
    rw [← hl x, hx]
  -- varying one coordinate: each `g I` is constant
  have hconst : ∀ (I : MaximalSpectrum A) (y : (A ⧸ I.asIdeal)ˣ), g I y = g I 1 := by
    intro I y
    have h1 := hsum (Function.update (fun _ => 1) I y)
    have h2 := hsum fun _ => 1
    rw [Finset.sum_congr rfl fun J _ => Function.apply_update g (fun _ => 1) I y J,
      Finset.sum_update_of_mem (Finset.mem_univ I)] at h1
    rw [Finset.sum_eq_sum_sdiff_singleton_add (Finset.mem_univ I)] at h2
    linear_combination h1 - h2
  -- conjugation moves something in every residue field, so each constant is `0` (the field case at 2)
  have hz : ∀ I : MaximalSpectrum A, g I 1 = 0 := by
    intro I
    haveI := I.isMaximal
    letI : Field (A ⧸ I.asIdeal) := Ideal.Quotient.field I.asIdeal
    haveI : Finite (A ⧸ I.asIdeal) := Finite.of_surjective _ Ideal.Quotient.mk_surjective
    haveI : CharP (A ⧸ I.asIdeal) 2 := charP_quotient_of_isMaximal 2 I.asIdeal
    obtain ⟨x, hx⟩ := hno I.asIdeal I.isMaximal
    refine eq_zero_of_forall_normOne_eq (Ideal.quotientMap I.asIdeal c (hmax I.asIdeal I.isMaximal).ge)
      (fun hid => hx ?_) (lam I) (hconst I)
    have h := RingHom.congr_fun hid (Ideal.Quotient.mk I.asIdeal x)
    rw [Ideal.quotientMap_mk, RingHom.id_apply] at h
    exact Ideal.Quotient.eq.mp h
  have h1 := hsum fun _ => 1
  rw [Finset.sum_eq_zero fun I _ => hz I] at h1
  exact zero_ne_one h1

/-! ## §2 The unit-vector ring: conjugation, Hilbert 90, primes, finite quotients -/

variable {F : Subfield ℝ}

/-- `ℤ[U_F]` is closed under complex conjugation (its generators are). -/
theorem conj_mem_unitRing {x : ℂ} (hx : x ∈ unitRing F) : (starRingEnd ℂ) x ∈ unitRing F := by
  sorry

/-- **Complex conjugation on `ℤ[U_F]`.** -/
noncomputable def conjR (F : Subfield ℝ) : unitRing F →+* unitRing F :=
  ((starRingEnd ℂ).comp (unitRing F).subtype).codRestrict (unitRing F) fun x => conj_mem_unitRing x.2

@[simp] theorem coe_conjR (x : unitRing F) : ((conjR F x : unitRing F) : ℂ) = (starRingEnd ℂ) (x : ℂ) := rfl

/-- Conjugation on `ℤ[U_F]` is an involution. -/
@[simp] theorem conjR_conjR (x : unitRing F) : conjR F (conjR F x) = x :=
  Subtype.ext (Complex.conj_conj (x : ℂ))

/-- **Every non-zero element of `ℤ[U_F]` is a unit vector times its conjugate**: `u = a/ā` has norm one and
coordinates in `F`, and `u·ā = a`. (The easy direction; Hilbert 90 is `exists_mul_conj_inv_eq_of_mul_conj_eq_one`.) -/
theorem exists_unitSet_mul_conjR_eq {a : unitRing F} (ha : a ≠ 0) : ∃ u ∈ unitSet F, u * conjR F a = a := by
  sorry

/-- **Every ideal of `ℤ[U_F]` is fixed by conjugation** (FS91-J02-L2(b) states it for primes; with no valuation: for
`a ∈ I`, `a = u·ā` with `u` a unit vector, so `ā = ū·a ∈ I`). -/
theorem comap_conjR_eq (I : Ideal (unitRing F)) : I.comap (conjR F) = I := by
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

/-- **The two-colour end, in the ring, every subfield `F ⊆ ℝ`**: a two-colourable plane gives a maximal ideal of
`ℤ[U_F]` modulo which conjugation is the identity — the ideal generated by the `u − 1`, `u` a unit vector, whose
quotient is `𝔽₂` (every unit vector is `1` modulo it and `i ≡ 1` gives `2 ≡ 0`; a two-colouring's character kills it
and not `1`). With `fieldBandSet_two_nonempty_of_conj_trivial` it is an equivalence: `F²` is two-colourable iff `ℤ[U_F]`
has `𝔽₂` as a quotient — "no odd closed walk" in the ring's words. Read through the joining module's dictionary at a
real number field it is the ⟹ of the two-colour classification, which is an outside model's theorem (GPT Astra's
Thm 2.1; second derivation FS91-J02-A21p) and is not claimed as this project's. No outside theorem is read. -/
theorem exists_maximal_conj_trivial_of_colorable_two (F : Subfield ℝ)
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

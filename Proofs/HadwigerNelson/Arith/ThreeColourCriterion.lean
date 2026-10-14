import Proofs.HadwigerNelson.Arith.TorsionExtraction
import Proofs.HadwigerNelson.Arith.WeilKloosterman

/-!
# The three-colour criterion over a real number field, in the unit-vector ring (FS-131, NF4; planner FS131-KN4)

**Read aloud, against the claim** (`data/fs131/claims-NF4.md`, NF4-THEOREM (b)): *"For every real number field `F` whose
plane is not bipartite: `χ(F²) = 3` iff some prime of `F` above 3 has residue field `𝔽₃`."* This module proves the
direction that is this project's — from a three-colouring to the prime — **as far as the ring `ℤ[U_F]`**:
`exists_maximal_card_nine_of_colorable_three`, a maximal ideal of `ℤ[U_F]` with nine elements in its quotient. The last
step (that ideal is cut out by a prime `𝔓` of `F(i)` fixed by conjugation with `𝓞/𝔓 = 𝔽₉`, so `𝔓 ∩ F` has residue field
`𝔽₃`) reads `UpperHalf.exists_stablePrime_of_valuationSubring`, the residue module's (`Arith/UpperHalf`, which this module does
not import); it and the clause as claimed are in the joining module `Arith/ThreeFourColours`
(`chromaticNumber_planeOver_eq_three_iff`; `plans/FS131-KN4-three-four-colours-plan.md` § 4).

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
FS91-J02-A21p): not claimed as this project's. **In the ring's words the two-colour end is older**: `[Fischer1990]`
Thm 1(iii), p. 183 — "the plane `F²` can be 2-colored iff there exists a non-zero ring homomorphism `v : C₀(F²) → ℤ/(2)`" —
is the equivalence `exists_maximal_conj_trivial_of_colorable_two` and `fieldBandSet_two_nonempty_of_conj_trivial` state
(read against the paper by FS131-KJ1); what the outside model adds is the passage from that homomorphism to a prime of
`F(i)`. Every upper bound is prior art and is in the residue module (`Arith/UpperHalf`).

**Rests on** the declared outside theorem `StandingFive.kloosterman_bound` (`[Weil1948]` p. 207), through
`targetFloor_four_weil`, in `exists_maximal_card_nine` and everything downstream of it; `exists_maximal_conj_trivial`
and the two-colour end do not read it.

**Inhabitants.** The hypotheses of `exists_maximal_card_nine` at `A = 𝔽₉ = 𝔽₃[i]`, conjugation, `l(x + yi) = x + y`
(FS91-J02-L4(a) at `q = 3`: `l ≠ 0` on `μ₄ = {±1, ±i}`); of `exists_maximal_conj_trivial` at `A = 𝔽₂`, the identity and
`l = id`. `exists_maximal_card_nine_of_colorable_three` at `F = ℚ(√3)` (`χ = 3`, `[Fischer1990]` Thm 9): exhibited
downstream, `ThreeFourColours.exists_maximal_card_nine_sqrt_three`; `exists_maximal_conj_trivial_of_colorable_two` at
`F = ℚ(√2)`: `ThreeFourColours.exists_maximal_conj_trivial_sqrt_two` (through
`DyadicQuadratic.colorable_two_planeOver_sqrt_of_mod_four`, downstream of this module). The two field cases: `𝔽₈₁` has no
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
  have h : unitRing F ≤ (unitRing F).comap (starRingEnd ℂ) :=
    Subring.closure_le.mpr fun z hz => Subring.subset_closure
      ⟨fieldI_conj F z hz.1, by rw [Complex.norm_conj]; exact hz.2⟩
  exact h hx

/-- **Complex conjugation on `ℤ[U_F]`.** -/
noncomputable def conjR (F : Subfield ℝ) : unitRing F →+* unitRing F :=
  ((starRingEnd ℂ).comp (unitRing F).subtype).codRestrict (unitRing F) fun x => conj_mem_unitRing x.2

@[simp] theorem coe_conjR (x : unitRing F) : ((conjR F x : unitRing F) : ℂ) = (starRingEnd ℂ) (x : ℂ) := rfl

/-- Conjugation on `ℤ[U_F]` is an involution. -/
@[simp] theorem conjR_conjR (x : unitRing F) : conjR F (conjR F x) = x :=
  Subtype.ext (Complex.conj_conj (x : ℂ))

/-- The conjugate of a unit vector is a unit vector. -/
private theorem conjR_mem_unitSet {u : unitRing F} (hu : u ∈ unitSet F) : conjR F u ∈ unitSet F :=
  ⟨fieldI_conj F _ hu.1, by rw [coe_conjR, Complex.norm_conj]; exact hu.2⟩

/-- A unit vector times its conjugate is `1`. -/
private theorem mul_conjR_of_mem_unitSet {u : unitRing F} (hu : u ∈ unitSet F) : u * conjR F u = 1 :=
  Subtype.ext (by
    show (u : ℂ) * (starRingEnd ℂ) (u : ℂ) = 1
    rw [Complex.mul_conj, Complex.normSq_eq_norm_sq, hu.2]
    norm_num)

/-- A product of unit vectors is a unit vector. -/
private theorem mul_mem_unitSet {u v : unitRing F} (hu : u ∈ unitSet F) (hv : v ∈ unitSet F) : u * v ∈ unitSet F :=
  ⟨(fieldI F).mul_mem hu.1 hv.1, by
    show ‖(u : ℂ) * (v : ℂ)‖ = 1
    rw [norm_mul, hu.2, hv.2, mul_one]⟩

/-- `1` is a unit vector. -/
private theorem one_mem_unitSet : (1 : unitRing F) ∈ unitSet F :=
  ⟨(fieldI F).one_mem, by show ‖(1 : ℂ)‖ = 1; exact norm_one⟩

/-- `−1` is a unit vector. -/
private theorem neg_one_mem_unitSet : (-1 : unitRing F) ∈ unitSet F :=
  ⟨(fieldI F).neg_mem (fieldI F).one_mem, by show ‖(-1 : ℂ)‖ = 1; rw [norm_neg, norm_one]⟩

/-- **`ℤ[U_F]` is the additive span of the unit vectors**, as an induction principle
(`UnitRing.exists_sum_eq_of_mem_unitRingOver`). -/
private theorem unitRing_induction {P : unitRing F → Prop} (h0 : P 0) (hadd : ∀ x y, P x → P y → P (x + y))
    (hu : ∀ u ∈ unitSet F, P u) (x : unitRing F) : P x := by
  obtain ⟨m, u, hn, hp, hsum⟩ := UnitRing.exists_sum_eq_of_mem_unitRingOver x.2
  have hmem : ∀ j, u j ∈ unitVectors F := fun j => ⟨hp j, hn j⟩
  have hx : x = ∑ j, (⟨u j, unitVectors_subset_unitRing F (hmem j)⟩ : unitRing F) :=
    Subtype.ext (by rw [← hsum, AddSubmonoidClass.coe_finsetSum])
  rw [hx]
  exact Finset.sum_induction _ P hadd h0 fun j _ => hu _ (hmem j)

/-- **Every non-zero element of `ℤ[U_F]` is a unit vector times its conjugate**: `u = a/ā` has norm one and
coordinates in `F`, and `u·ā = a`. (The easy direction; Hilbert 90 is `exists_mul_conj_inv_eq_of_mul_conj_eq_one`.) -/
theorem exists_unitSet_mul_conjR_eq {a : unitRing F} (ha : a ≠ 0) : ∃ u ∈ unitSet F, u * conjR F a = a := by
  have ha0 : (a : ℂ) ≠ 0 := fun h => ha (Subtype.ext h)
  have hc0 : (starRingEnd ℂ) (a : ℂ) ≠ 0 := (map_ne_zero _).mpr ha0
  have hplane : (a : ℂ) ∈ fieldI F := UnitRing.unitRingOver_le_planeOverSubring F a.2
  have hu : (a : ℂ) / (starRingEnd ℂ) (a : ℂ) ∈ unitVectors F :=
    ⟨(fieldI F).div_mem hplane (fieldI_conj F _ hplane), by
      rw [norm_div, Complex.norm_conj, div_self (norm_ne_zero_iff.mpr ha0)]⟩
  refine ⟨⟨_, unitVectors_subset_unitRing F hu⟩, hu, Subtype.ext ?_⟩
  show (a : ℂ) / (starRingEnd ℂ) (a : ℂ) * (starRingEnd ℂ) (a : ℂ) = a
  exact div_mul_cancel₀ _ hc0

/-- **Every ideal of `ℤ[U_F]` is fixed by conjugation** (FS91-J02-L2(b) states it for primes; with no valuation: for
`a ∈ I`, `a = u·ā` with `u` a unit vector, so `ā = ū·a ∈ I`). -/
theorem comap_conjR_eq (I : Ideal (unitRing F)) : I.comap (conjR F) = I := by
  have key : ∀ a ∈ I, conjR F a ∈ I := by
    intro a ha
    by_cases ha0 : a = 0
    · rw [ha0, map_zero]
      exact I.zero_mem
    obtain ⟨u, hu, hua⟩ := exists_unitSet_mul_conjR_eq ha0
    have h1 : conjR F u * u = 1 := by rw [mul_comm]; exact mul_conjR_of_mem_unitSet hu
    have h2 : conjR F a = conjR F u * a :=
      calc conjR F a = conjR F u * u * conjR F a := by rw [h1, one_mul]
        _ = conjR F u * (u * conjR F a) := mul_assoc _ _ _
        _ = conjR F u * a := by rw [hua]
    rw [h2]
    exact I.mul_mem_left _ ha
  ext a
  refine ⟨fun h => ?_, fun h => key a h⟩
  have h' := key _ (Ideal.mem_comap.mp h)
  rwa [conjR_conjR] at h'

/-- **`ℤ[U_F]/p` is finite** for a number field `F` and a prime `p`: it is an `𝔽_p`-space of dimension at most
`[F(i) : ℚ]`. (Lifts of an `𝔽_p`-independent family are independent over `ℤ`: an integer relation among them reduces to an
`𝔽_p`-relation, so `p` divides every coefficient, and `ℤ[U_F]` has no torsion — by descent every coefficient is `0`.) -/
private theorem finite_quotient_span_prime (F : Subfield ℝ) [NumberField F] (p : ℕ) [hp : Fact p.Prime] :
    Finite (unitRing F ⧸ Ideal.span {(p : unitRing F)}) := by
  classical
  have hpx : ∀ x : unitRing F ⧸ Ideal.span {(p : unitRing F)}, p • x = 0 := fun x => by
    obtain ⟨x, rfl⟩ := Ideal.Quotient.mk_surjective x
    rw [← map_nsmul, Ideal.Quotient.eq_zero_iff_mem, nsmul_eq_mul]
    exact Ideal.mul_mem_right _ _ (Ideal.subset_span rfl)
  -- `haveI`, not `letI`: with the structure's value visible, instance search for `Module.Free` is reported stuck
  haveI : Module (ZMod p) (unitRing F ⧸ Ideal.span {(p : unitRing F)}) := AddCommGroup.zmodModule hpx
  have hrank : Module.rank (ZMod p) (unitRing F ⧸ Ideal.span {(p : unitRing F)}) ≤
      (Module.finrank ℚ (fieldI F) : ℕ) := by
    refine rank_le fun s hli => ?_
    choose r hr using fun x : unitRing F ⧸ Ideal.span {(p : unitRing F)} => Ideal.Quotient.mk_surjective x
    let v : s → fieldI F := fun i => ⟨(r i : ℂ), UnitRing.unitRingOver_le_planeOverSubring F (r i).2⟩
    -- `p` divides every coefficient of an integer relation among the lifts
    have hrel : ∀ g : s → ℤ, ∑ i, g i • v i = 0 → ∀ i, (p : ℤ) ∣ g i := by
      intro g hg i
      have h1 : ∑ i : s, (g i : unitRing F) * r i = 0 := Subtype.ext (by
        have h := congrArg (fun z : fieldI F => (z : ℂ)) hg
        simpa [v, zsmul_eq_mul] using h)
      have h2 := congrArg (Ideal.Quotient.mk (Ideal.span {(p : unitRing F)})) h1
      rw [map_sum, map_zero] at h2
      have h3 : ∑ i : s, ((g i : ℤ) : ZMod p) • (i : unitRing F ⧸ Ideal.span {(p : unitRing F)}) = 0 := by
        refine (Finset.sum_congr rfl fun i _ => ?_).trans h2
        rw [Int.cast_smul_eq_zsmul, map_mul, map_intCast, hr, zsmul_eq_mul]
      exact (ZMod.intCast_zmod_eq_zero_iff_dvd (g i) p).mp (Fintype.linearIndependent_iff.mp hli _ h3 i)
    -- so `pⁿ` does, for every `n`
    have hpow : ∀ n : ℕ, ∀ g : s → ℤ, ∑ i, g i • v i = 0 → ∀ i, (p : ℤ) ^ n ∣ g i := by
      intro n
      induction n with
      | zero => intro g _ i; simp
      | succ n ih =>
        intro g hg i
        choose g' hg' using hrel g hg
        have hsmul : (p : ℤ) • ∑ i, g' i • v i = 0 := by
          rw [Finset.smul_sum, ← hg]
          exact Finset.sum_congr rfl fun i _ => by rw [hg' i, mul_smul]
        have hg'rel : ∑ i, g' i • v i = 0 :=
          (smul_eq_zero.mp hsmul).resolve_left (by exact_mod_cast hp.out.ne_zero)
        rw [hg' i, pow_succ']
        exact mul_dvd_mul_left _ (ih g' hg'rel i)
    have hliZ : LinearIndependent ℤ v := by
      rw [Fintype.linearIndependent_iff]
      intro g hg i
      refine Int.eq_zero_of_abs_lt_dvd (hpow (g i).natAbs g hg i) ?_
      rw [← Int.natCast_natAbs]
      exact_mod_cast Nat.lt_pow_self hp.out.one_lt
    have hcard := ((LinearIndependent.iff_fractionRing ℤ ℚ).mp hliZ).fintype_card_le_finrank
    rwa [Fintype.card_coe] at hcard
  have hlt : Module.rank (ZMod p) (unitRing F ⧸ Ideal.span {(p : unitRing F)}) < Cardinal.aleph0 :=
    hrank.trans_lt Cardinal.natCast_lt_aleph0
  haveI : Module.Finite (ZMod p) (unitRing F ⧸ Ideal.span {(p : unitRing F)}) := Module.rank_lt_aleph0_iff.mp hlt
  exact Module.finite_of_finite (ZMod p)

/-- **`ℤ[U_F]/N` is finite** for a number field `F` and `N ≠ 0` (FS91-J02-L2(a): any `[F(i) : ℚ] + 1` elements of the
ring satisfy a primitive integer relation). -/
theorem finite_quotient_span_natCast (F : Subfield ℝ) [NumberField F] {N : ℕ} (hN : N ≠ 0) :
    Finite (unitRing F ⧸ Ideal.span {(N : unitRing F)}) := by
  induction N using Nat.recOnMul with
  | zero => exact absurd rfl hN
  | one =>
    haveI : Subsingleton (unitRing F ⧸ Ideal.span {((1 : ℕ) : unitRing F)}) :=
      Ideal.Quotient.subsingleton_iff.mpr (by rw [Nat.cast_one, Ideal.span_singleton_one])
    infer_instance
  | prime p hp =>
    haveI : Fact p.Prime := ⟨hp⟩
    exact finite_quotient_span_prime F p
  | mul a b iha ihb =>
    haveI := iha (left_ne_zero_of_mul hN)
    haveI := ihb (right_ne_zero_of_mul hN)
    have e : Ideal.span {((a * b : ℕ) : unitRing F)} =
        Ideal.span {(a : unitRing F)} • Ideal.span {(b : unitRing F)} := by
      rw [smul_eq_mul, Ideal.span_singleton_mul_span_singleton, Nat.cast_mul]
    rw [e]
    exact Submodule.finite_quotient_smul _ (Submodule.fg_span_singleton _)

/-! ## §3 The torsion theorem, and the two ends -/

/-- **The two parts of a point of `Θ₃ ∩ T₆` at one unit vector**: where the character lies in the band at 3 (its value is
`1/3`, `1/2` or `2/3`), its 2-part is `1` exactly when its 3-part is `0` (both at the value `1/2`). -/
private theorem two_part_eq_one_iff_three_part_eq_zero {M : Type*} [AddCommGroup M] {τ : M →+ UnitAddCircle}
    (h6 : 6 • τ = 0) {m₂ : M →+ ZMod 2} {m₃ : M →+ ZMod 3} (h₂ : ∀ x, (3 • τ) x = ZMod.toAddCircle (m₂ x))
    (h₃ : ∀ x, (2 • τ) x = ZMod.toAddCircle (m₃ x)) {u : M} (hu : τ u ∈ band 3) : m₂ u = 1 ↔ m₃ u = 0 := by
  obtain ⟨x, ⟨hx1, hx2⟩, hxu⟩ := hu
  have hxu' : τ u = (x : UnitAddCircle) := hxu.symm
  norm_num at hx1 hx2
  have hz : ∀ n : ℕ, n • (x : UnitAddCircle) = 0 ↔ ∃ k : ℤ, (k : ℝ) = n * x := fun n => by
    rw [← AddCircle.coe_nsmul, AddCircle.coe_eq_zero_iff]
    simp only [zsmul_eq_mul, mul_one, nsmul_eq_mul]
  -- `6x = n ∈ {2, 3, 4}`
  obtain ⟨n, hn⟩ : ∃ n : ℤ, (n : ℝ) = 6 * x := by
    have h := DFunLike.congr_fun h6 u
    rw [AddMonoidHom.smul_apply, AddMonoidHom.zero_apply, hxu'] at h
    simpa using (hz 6).mp h
  have hn2 : 2 ≤ n := by exact_mod_cast (by linarith : (2 : ℝ) ≤ n)
  have hn4 : n ≤ 4 := by exact_mod_cast (by linarith : (n : ℝ) ≤ 4)
  have e₂ : m₂ u = 0 ↔ ∃ k : ℤ, (k : ℝ) = 3 * x := by
    rw [← (ZMod.toAddCircle_injective 2).eq_iff, map_zero, ← h₂, AddMonoidHom.smul_apply, hxu']
    simpa using hz 3
  have e₃ : m₃ u = 0 ↔ ∃ k : ℤ, (k : ℝ) = 2 * x := by
    rw [← (ZMod.toAddCircle_injective 3).eq_iff, map_zero, ← h₃, AddMonoidHom.smul_apply, hxu']
    simpa using hz 2
  have h01 : ∀ z : ZMod 2, z = 1 ↔ ¬ z = 0 := by decide
  rw [h01, e₂, e₃]
  constructor
  · intro h
    have hn3 : n = 3 := by
      by_contra hne
      rcases (by omega : n = 2 ∨ n = 4) with rfl | rfl
      · exact h ⟨1, by push_cast at hn ⊢; linarith⟩
      · exact h ⟨2, by push_cast at hn ⊢; linarith⟩
    subst hn3
    exact ⟨1, by push_cast at hn ⊢; linarith⟩
  · rintro ⟨k, hk⟩ ⟨k', hk'⟩
    have h3k : (3 * k : ℤ) = n := by exact_mod_cast (by rw [hk, hn]; ring : (3 * k : ℝ) = n)
    have h2k : (2 * k' : ℤ) = n := by exact_mod_cast (by rw [hk', hn]; ring : (2 * k' : ℝ) = n)
    omega

/-- An additive map into `ZMod p` kills `p·R`: it descends to `R ⧸ (p)`. -/
private theorem exists_quotient_hom {R : Type*} [CommRing R] (p : ℕ) (m : R →+ ZMod p) :
    ∃ l : R ⧸ Ideal.span {(p : R)} →+ ZMod p, ∀ x, l (Ideal.Quotient.mk _ x) = m x := by
  have hsurj : Function.Surjective (Ideal.Quotient.mk (Ideal.span {(p : R)})).toAddMonoidHom :=
    Ideal.Quotient.mk_surjective
  have hker : (Ideal.Quotient.mk (Ideal.span {(p : R)})).toAddMonoidHom.ker ≤ m.ker := fun x hx => by
    rw [AddMonoidHom.mem_ker] at hx ⊢
    obtain ⟨a, rfl⟩ := Ideal.mem_span_singleton'.mp (Ideal.Quotient.eq_zero_iff_mem.mp hx)
    rw [← nsmul_eq_mul', map_nsmul, nsmul_eq_mul, CharP.cast_eq_zero, zero_mul]
  exact ⟨AddMonoidHom.liftOfRightInverse _ (Function.surjInv hsurj) (Function.rightInverse_surjInv hsurj) ⟨m, hker⟩,
    fun x => AddMonoidHom.liftOfRightInverse_comp_apply _ _ (Function.rightInverse_surjInv hsurj) ⟨m, hker⟩ x⟩

/-- Conjugation on a quotient of `ℤ[U_F]` fixes every ideal of the quotient (`comap_conjR_eq` on its pull-back). -/
private theorem comap_quotientMap_conjR (I : Ideal (unitRing F)) (𝔪 : Ideal (unitRing F ⧸ I)) :
    𝔪.comap (Ideal.quotientMap I (conjR F) (comap_conjR_eq I).ge) = 𝔪 := by
  ext x
  obtain ⟨x, rfl⟩ := Ideal.Quotient.mk_surjective x
  rw [Ideal.mem_comap, Ideal.quotientMap_mk]
  exact SetLike.ext_iff.mp (comap_conjR_eq (𝔪.comap (Ideal.Quotient.mk I))) x

/-- If `u·ā = a` and `a` reduces to a unit `x` modulo `I`, then `u` reduces to `x / c̄ x`. -/
private theorem mk_eq_unit_mul_conj_inv {I : Ideal (unitRing F)} {a u : unitRing F} (hua : u * conjR F a = a)
    (x : (unitRing F ⧸ I)ˣ) (hx : Ideal.Quotient.mk I a = x) :
    Ideal.Quotient.mk I u = (x : unitRing F ⧸ I) *
      Ideal.quotientMap I (conjR F) (comap_conjR_eq I).ge ((x⁻¹ : (unitRing F ⧸ I)ˣ) : unitRing F ⧸ I) := by
  have h1 : Ideal.Quotient.mk I u * Ideal.quotientMap I (conjR F) (comap_conjR_eq I).ge (x : unitRing F ⧸ I) = x := by
    rw [← hx, Ideal.quotientMap_mk, ← map_mul, hua]
  have h2 : Ideal.quotientMap I (conjR F) (comap_conjR_eq I).ge (x : unitRing F ⧸ I) *
      Ideal.quotientMap I (conjR F) (comap_conjR_eq I).ge ((x⁻¹ : (unitRing F ⧸ I)ˣ) : unitRing F ⧸ I) = 1 := by
    rw [← map_mul, Units.mul_inv, map_one]
  rw [← h1, mul_assoc, h2, mul_one]

/-- Pulling an ideal of `R ⧸ I` back to `R` keeps the quotient. -/
private theorem card_quotient_comap_mk {R : Type*} [CommRing R] (I : Ideal R) (𝔪 : Ideal (R ⧸ I)) :
    Nat.card (R ⧸ 𝔪.comap (Ideal.Quotient.mk I)) = Nat.card ((R ⧸ I) ⧸ 𝔪) := by
  have hle : I ≤ 𝔪.comap (Ideal.Quotient.mk I) := fun x hx => by
    rw [Ideal.mem_comap, Ideal.Quotient.eq_zero_iff_mem.mpr hx]
    exact 𝔪.zero_mem
  have e := DoubleQuot.quotQuotEquivQuotOfLE hle
  rw [Ideal.map_comap_of_surjective _ Ideal.Quotient.mk_surjective] at e
  exact Nat.card_congr e.symm.toEquiv

/-- **One fact about two predicates** (`plans/FS131-KN5-three-four-colours-passes.md` § Stage 3, L3.8). Let `2 ∈ I₂`,
`3 ∈ I₃`, and let the functionals `l₂`, `l₃` on the two quotients come from maps `m₂`, `m₃` on `ℤ[U_F]` with
`m₂ u = 1 ↔ m₃ u = 0` at every unit vector. For units `x₂`, `x₃` the common lift `a = 3a₂ − 2a₃` gives the unit vector
`a/ā`, which reduces to `x₂ / c̄ x₂` and to `x₃ / c̄ x₃`: so `l₂ (x₂ / c̄ x₂) = 1 ↔ l₃ (x₃ / c̄ x₃) = 0` for every pair, and
one of the two predicates holds throughout. -/
private theorem forall_unit_eq_one_or_forall_unit_ne_zero {I₂ I₃ : Ideal (unitRing F)} (h2 : (2 : unitRing F) ∈ I₂)
    (h3 : (3 : unitRing F) ∈ I₃) {m₂ : unitRing F →+ ZMod 2} {m₃ : unitRing F →+ ZMod 3}
    (hdich : ∀ u ∈ unitSet F, m₂ u = 1 ↔ m₃ u = 0) {l₂ : unitRing F ⧸ I₂ →+ ZMod 2}
    {l₃ : unitRing F ⧸ I₃ →+ ZMod 3} (hl₂ : ∀ x, l₂ (Ideal.Quotient.mk I₂ x) = m₂ x)
    (hl₃ : ∀ x, l₃ (Ideal.Quotient.mk I₃ x) = m₃ x) :
    (∀ x₂ : (unitRing F ⧸ I₂)ˣ, l₂ ((x₂ : unitRing F ⧸ I₂) * Ideal.quotientMap I₂ (conjR F) (comap_conjR_eq I₂).ge
        ((x₂⁻¹ : (unitRing F ⧸ I₂)ˣ) : unitRing F ⧸ I₂)) = 1) ∨
      ∀ x₃ : (unitRing F ⧸ I₃)ˣ, l₃ ((x₃ : unitRing F ⧸ I₃) * Ideal.quotientMap I₃ (conjR F) (comap_conjR_eq I₃).ge
        ((x₃⁻¹ : (unitRing F ⧸ I₃)ˣ) : unitRing F ⧸ I₃)) ≠ 0 := by
  have hpair : ∀ (x₂ : (unitRing F ⧸ I₂)ˣ) (x₃ : (unitRing F ⧸ I₃)ˣ),
      l₂ ((x₂ : unitRing F ⧸ I₂) * Ideal.quotientMap I₂ (conjR F) (comap_conjR_eq I₂).ge
          ((x₂⁻¹ : (unitRing F ⧸ I₂)ˣ) : unitRing F ⧸ I₂)) = 1 ↔
        l₃ ((x₃ : unitRing F ⧸ I₃) * Ideal.quotientMap I₃ (conjR F) (comap_conjR_eq I₃).ge
          ((x₃⁻¹ : (unitRing F ⧸ I₃)ˣ) : unitRing F ⧸ I₃)) = 0 := by
    intro x₂ x₃
    obtain ⟨a₂, ha₂⟩ := Ideal.Quotient.mk_surjective (x₂ : unitRing F ⧸ I₂)
    obtain ⟨a₃, ha₃⟩ := Ideal.Quotient.mk_surjective (x₃ : unitRing F ⧸ I₃)
    have hmk₂ : Ideal.Quotient.mk I₂ (3 * a₂ - 2 * a₃) = x₂ := by
      rw [← ha₂]
      refine Ideal.Quotient.eq.mpr ?_
      rw [show 3 * a₂ - 2 * a₃ - a₂ = (a₂ - a₃) * 2 by ring]
      exact I₂.mul_mem_left _ h2
    have hmk₃ : Ideal.Quotient.mk I₃ (3 * a₂ - 2 * a₃) = x₃ := by
      rw [← ha₃]
      refine Ideal.Quotient.eq.mpr ?_
      rw [show 3 * a₂ - 2 * a₃ - a₃ = (a₂ - a₃) * 3 by ring]
      exact I₃.mul_mem_left _ h3
    by_cases ha : 3 * a₂ - 2 * a₃ = 0
    · -- both quotients would be trivial: excluded by the unit vector `1`
      exfalso
      rw [ha, map_zero] at hmk₂ hmk₃
      have h1₂ : (1 : unitRing F ⧸ I₂) = 0 := by rw [← x₂.mul_inv, ← hmk₂, zero_mul]
      have h1₃ : (1 : unitRing F ⧸ I₃) = 0 := by rw [← x₃.mul_inv, ← hmk₃, zero_mul]
      have hm₂ : m₂ 1 = 0 := by rw [← hl₂, map_one, h1₂, map_zero]
      have hm₃ : m₃ 1 = 0 := by rw [← hl₃, map_one, h1₃, map_zero]
      have h := (hdich 1 one_mem_unitSet).mpr hm₃
      rw [hm₂] at h
      exact zero_ne_one h
    · obtain ⟨u, hu, hua⟩ := exists_unitSet_mul_conjR_eq ha
      rw [← mk_eq_unit_mul_conj_inv hua x₂ hmk₂, ← mk_eq_unit_mul_conj_inv hua x₃ hmk₃, hl₂, hl₃]
      exact hdich u hu
  refine or_iff_not_imp_right.mpr fun hall => ?_
  push Not at hall
  obtain ⟨x₃, hx₃⟩ := hall
  exact fun x₂ => (hpair x₂ x₃).mpr hx₃

/-- The dyadic end of `exists_maximal_of_torsion`: the two-part on a finite quotient by an ideal holding `2`, pulled back. -/
private theorem exists_maximal_conj_trivial_of_quotient {I : Ideal (unitRing F)} [Finite (unitRing F ⧸ I)]
    (h2 : (2 : unitRing F) ∈ I) (l : unitRing F ⧸ I →+ ZMod 2)
    (hl : ∀ x : (unitRing F ⧸ I)ˣ, l ((x : unitRing F ⧸ I) * Ideal.quotientMap I (conjR F) (comap_conjR_eq I).ge
      ((x⁻¹ : (unitRing F ⧸ I)ˣ) : unitRing F ⧸ I)) = 1) :
    ∃ 𝔪 : Ideal (unitRing F), 𝔪.IsMaximal ∧ ∀ x, conjR F x - x ∈ 𝔪 := by
  haveI : Nontrivial (unitRing F ⧸ I) := by
    by_contra hnt
    haveI := not_nontrivial_iff_subsingleton.mp hnt
    have h := hl 1
    rw [show ∀ z : unitRing F ⧸ I, l z = 0 from fun z => by rw [Subsingleton.elim z 0, map_zero]] at h
    exact zero_ne_one h
  haveI : CharP (unitRing F ⧸ I) 2 := ringChar.of_eq (CharP.ringChar_of_prime_eq_zero Nat.prime_two (by
    rw [Nat.cast_ofNat, ← map_ofNat (Ideal.Quotient.mk I) 2]
    exact Ideal.Quotient.eq_zero_iff_mem.mpr h2))
  obtain ⟨𝔪, h𝔪, htriv⟩ := exists_maximal_conj_trivial (Ideal.quotientMap I (conjR F) (comap_conjR_eq I).ge)
    (fun 𝔪 _ => comap_quotientMap_conjR I 𝔪) l hl
  haveI := h𝔪
  refine ⟨𝔪.comap (Ideal.Quotient.mk I), Ideal.comap_isMaximal_of_surjective _ Ideal.Quotient.mk_surjective,
    fun x => ?_⟩
  have h := htriv (Ideal.Quotient.mk I x)
  rw [Ideal.quotientMap_mk, ← map_sub] at h
  exact Ideal.mem_comap.mpr h

/-- The `𝔽₃` end of `exists_maximal_of_torsion`: the three-part on a finite quotient by an ideal holding `3` (with `ι` the
class of `i`), pulled back with its quotient. Rests on Weil's bound. -/
private theorem exists_maximal_card_nine_of_quotient {I : Ideal (unitRing F)} [Finite (unitRing F ⧸ I)]
    (h3 : (3 : unitRing F) ∈ I) (l : unitRing F ⧸ I →+ ZMod 3)
    (hl : ∀ x : (unitRing F ⧸ I)ˣ, l ((x : unitRing F ⧸ I) * Ideal.quotientMap I (conjR F) (comap_conjR_eq I).ge
      ((x⁻¹ : (unitRing F ⧸ I)ˣ) : unitRing F ⧸ I)) ≠ 0) :
    ∃ 𝔪 : Ideal (unitRing F), 𝔪.IsMaximal ∧ Nat.card (unitRing F ⧸ 𝔪) = 9 := by
  haveI : Nontrivial (unitRing F ⧸ I) := by
    by_contra hnt
    haveI := not_nontrivial_iff_subsingleton.mp hnt
    exact hl 1 (by rw [Subsingleton.elim (_ * _ : unitRing F ⧸ I) 0, map_zero])
  haveI : CharP (unitRing F ⧸ I) 3 := ringChar.of_eq (CharP.ringChar_of_prime_eq_zero Nat.prime_three (by
    rw [Nat.cast_ofNat, ← map_ofNat (Ideal.Quotient.mk I) 3]
    exact Ideal.Quotient.eq_zero_iff_mem.mpr h3))
  have hI : Complex.I ∈ unitVectors F := ⟨⟨by simp, by simp⟩, Complex.norm_I⟩
  obtain ⟨𝔪, h𝔪, hcard⟩ := exists_maximal_card_nine (Ideal.quotientMap I (conjR F) (comap_conjR_eq I).ge)
    (quotientMap_involutive (conjR F) conjR_conjR (comap_conjR_eq I).ge) (fun 𝔪 _ => comap_quotientMap_conjR I 𝔪)
    (ι := Ideal.Quotient.mk I ⟨Complex.I, unitVectors_subset_unitRing F hI⟩)
    (by
      rw [← map_mul, ← map_one (Ideal.Quotient.mk I), ← map_neg]
      exact congrArg _ (Subtype.ext Complex.I_mul_I))
    (by
      rw [Ideal.quotientMap_mk, ← map_neg]
      exact congrArg _ (Subtype.ext Complex.conj_I))
    l hl
  haveI := h𝔪
  exact ⟨𝔪.comap (Ideal.Quotient.mk I), Ideal.comap_isMaximal_of_surjective _ Ideal.Quotient.mk_surjective,
    (card_quotient_comap_mk I 𝔪).trans hcard⟩

/-- **FS91-J02-T1, ⟹, in the ring.** For a real number field, a point of `Θ₃ ∩ T₆` gives a maximal ideal of `ℤ[U_F]`
modulo which conjugation is the identity (the dyadic type), or one with nine elements in its quotient (the `𝔽₃` type).
Rests on Weil's bound (the second alternative). -/
theorem exists_maximal_of_torsion (F : Subfield ℝ) [NumberField F] {τ : unitRing F →+ UnitAddCircle}
    (hτ : τ ∈ fieldBandSet F (band 3)) (h6 : τ ∈ torsionBy (unitRing F) 6) :
    (∃ 𝔪 : Ideal (unitRing F), 𝔪.IsMaximal ∧ ∀ x, conjR F x - x ∈ 𝔪) ∨
      (∃ 𝔪 : Ideal (unitRing F), 𝔪.IsMaximal ∧ Nat.card (unitRing F ⧸ 𝔪) = 9) := by
  have h6' : 6 • τ = 0 := h6
  -- the 2-part `3τ` and the 3-part `2τ`, as functionals into `ZMod 2` and `ZMod 3`
  obtain ⟨m₂, hm₂⟩ := TorsionExtraction.exists_zmod_hom_of_mem_torsionBy (N := 2) (θ := 3 • τ)
    (mem_torsionBy.mpr (by rw [smul_smul]; exact h6'))
  obtain ⟨m₃, hm₃⟩ := TorsionExtraction.exists_zmod_hom_of_mem_torsionBy (N := 3) (θ := 2 • τ)
    (mem_torsionBy.mpr (by rw [smul_smul]; exact h6'))
  have hdich : ∀ u ∈ unitSet F, m₂ u = 1 ↔ m₃ u = 0 := fun u hu =>
    two_part_eq_one_iff_three_part_eq_zero h6' hm₂ hm₃ (hτ u hu)
  -- on the finite quotients `R/2`, `R/3`
  obtain ⟨l₂, hl₂⟩ := exists_quotient_hom 2 m₂
  obtain ⟨l₃, hl₃⟩ := exists_quotient_hom 3 m₃
  haveI : Finite (unitRing F ⧸ Ideal.span {((2 : ℕ) : unitRing F)}) := finite_quotient_span_natCast F (by norm_num)
  haveI : Finite (unitRing F ⧸ Ideal.span {((3 : ℕ) : unitRing F)}) := finite_quotient_span_natCast F (by norm_num)
  have h2 : (2 : unitRing F) ∈ Ideal.span {((2 : ℕ) : unitRing F)} := Ideal.subset_span (by simp)
  have h3 : (3 : unitRing F) ∈ Ideal.span {((3 : ℕ) : unitRing F)} := Ideal.subset_span (by simp)
  rcases forall_unit_eq_one_or_forall_unit_ne_zero h2 h3 hdich hl₂ hl₃ with hP | hQ
  · exact Or.inl (exists_maximal_conj_trivial_of_quotient h2 l₂ hP)
  · exact Or.inr (exists_maximal_card_nine_of_quotient h3 l₃ hQ)

/-- `1/2` is not `0` on the circle. -/
private theorem half_ne_zero : ((1 / 2 : ℝ) : UnitAddCircle) ≠ 0 := by
  intro h
  obtain ⟨n, hn⟩ := (AddCircle.coe_eq_zero_iff _).mp h
  rw [zsmul_eq_mul, mul_one] at hn
  have h2 : (2 * n : ℤ) = 1 := by exact_mod_cast (by linarith : (2 * n : ℝ) = 1)
  omega

/-- `ZMod 2 ↪ ℝ/ℤ` sends `1` to `1/2`. -/
private theorem toAddCircle_one_two : ZMod.toAddCircle (1 : ZMod 2) = ((1 / 2 : ℝ) : UnitAddCircle) := by
  have h := ZMod.toAddCircle_natCast (N := 2) 1
  simpa using h

/-- **A maximal ideal with trivial conjugation is a two-colouring**: every unit vector is `1` modulo it (`u·ū = 1`,
`ū ≡ u`, characteristic 2), so a functional on the quotient with value 1 at 1 is `1/2` on unit vectors. Every subfield
`F ⊆ ℝ`. (Where the quotient is `𝔽₂` this is the "if" of `[Fischer1990]` Thm 1(iii), p. 183.) -/
theorem fieldBandSet_two_nonempty_of_conj_trivial {𝔪 : Ideal (unitRing F)} (h𝔪 : 𝔪.IsMaximal)
    (htriv : ∀ x, conjR F x - x ∈ 𝔪) : (fieldBandSet F (band 2)).Nonempty := by
  haveI := h𝔪
  letI : Field (unitRing F ⧸ 𝔪) := Ideal.Quotient.field 𝔪
  -- `2 ∈ 𝔪`: `ī − i = −2i` and `i` is a unit
  have hI : Complex.I ∈ unitVectors F := ⟨⟨by simp, by simp⟩, Complex.norm_I⟩
  have h2 : (2 : unitRing F ⧸ 𝔪) = 0 := by
    have h := 𝔪.mul_mem_left ⟨Complex.I, unitVectors_subset_unitRing F hI⟩ (htriv ⟨Complex.I, unitVectors_subset_unitRing F hI⟩)
    have e : (⟨Complex.I, unitVectors_subset_unitRing F hI⟩ : unitRing F) *
        (conjR F ⟨Complex.I, unitVectors_subset_unitRing F hI⟩ - ⟨Complex.I, unitVectors_subset_unitRing F hI⟩) = 2 :=
      Subtype.ext (by
        show Complex.I * ((starRingEnd ℂ) Complex.I - Complex.I) = 2
        rw [Complex.conj_I]
        linear_combination (-2 : ℂ) * Complex.I_mul_I)
    rw [e] at h
    rw [← map_ofNat (Ideal.Quotient.mk 𝔪) 2]
    exact Ideal.Quotient.eq_zero_iff_mem.mpr h
  -- every unit vector is `1` modulo `𝔪`
  have hone : ∀ u ∈ unitSet F, Ideal.Quotient.mk 𝔪 u = 1 := by
    intro u hu
    have hsq : Ideal.Quotient.mk 𝔪 u * Ideal.Quotient.mk 𝔪 u = 1 :=
      calc Ideal.Quotient.mk 𝔪 u * Ideal.Quotient.mk 𝔪 u
          = Ideal.Quotient.mk 𝔪 u * Ideal.Quotient.mk 𝔪 (conjR F u) := by
            rw [Ideal.Quotient.eq.mpr (htriv u)]
        _ = 1 := by rw [← map_mul, mul_conjR_of_mem_unitSet hu, map_one]
    have h0 : (Ideal.Quotient.mk 𝔪 u - 1) * (Ideal.Quotient.mk 𝔪 u - 1) = 0 := by
      linear_combination hsq + (1 - Ideal.Quotient.mk 𝔪 u) * h2
    exact sub_eq_zero.mp (mul_self_eq_zero.mp h0)
  -- an `𝔽₂`-linear functional on the quotient with value 1 at 1
  letI : Module (ZMod 2) (unitRing F ⧸ 𝔪) := AddCommGroup.zmodModule (n := 2) fun x => by
    rw [nsmul_eq_mul, Nat.cast_ofNat, h2, zero_mul]
  obtain ⟨g, hg⟩ := LinearMap.exists_leftInverse_of_injective
    (LinearMap.toSpanSingleton (ZMod 2) (unitRing F ⧸ 𝔪) 1) (LinearMap.ker_eq_bot'.mpr fun r hr => by
      rcases (by decide : ∀ r : ZMod 2, r = 0 ∨ r = 1) r with rfl | rfl
      · rfl
      · rw [LinearMap.toSpanSingleton_apply, one_smul] at hr
        exact absurd hr one_ne_zero)
  have hg1 : g 1 = 1 := by
    have h := LinearMap.congr_fun hg 1
    rwa [LinearMap.comp_apply, LinearMap.toSpanSingleton_apply, one_smul, LinearMap.id_apply] at h
  refine ⟨ZMod.toAddCircle.comp (g.toAddMonoidHom.comp (Ideal.Quotient.mk 𝔪).toAddMonoidHom), fun u hu => ?_⟩
  refine ⟨1 / 2, ⟨by norm_num, by norm_num⟩, ?_⟩
  show ((1 / 2 : ℝ) : UnitAddCircle) = ZMod.toAddCircle (g (Ideal.Quotient.mk 𝔪 u))
  rw [hone u hu, hg1, toAddCircle_one_two]

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
has `𝔽₂` as a quotient — "no odd closed walk" in the ring's words, and `[Fischer1990]` Thm 1(iii), p. 183 (prior art; the
kernel form is what is here). Read through the joining module's dictionary at a
real number field it is the ⟹ of the two-colour classification, which is an outside model's theorem (GPT Astra's
Thm 2.1; second derivation FS91-J02-A21p) and is not claimed as this project's. No outside theorem is read. -/
theorem exists_maximal_conj_trivial_of_colorable_two (F : Subfield ℝ)
    (h2 : ((unitDistance ℂ).induce (planeOver F)).Colorable 2) :
    ∃ 𝔪 : Ideal (unitRing F), 𝔪.IsMaximal ∧ ∀ x, conjR F x - x ∈ 𝔪 := by
  obtain ⟨τ, hτ⟩ := (TorsionExtraction.colorable_two_iff_fieldBandSet_two_nonempty F).mp h2
  -- the two-colouring's character is `1/2` on every unit vector
  have hhalf : ∀ u ∈ unitSet F, τ u = ((1 / 2 : ℝ) : UnitAddCircle) := by
    intro u hu
    obtain ⟨x, ⟨h1, h2⟩, hx⟩ := hτ u hu
    have hx' : (x : UnitAddCircle) = τ u := hx
    norm_num at h1 h2
    rw [← hx', show x = 1 / 2 by linarith]
  -- the ideal generated by the `u − 1`
  let J : Ideal (unitRing F) := Ideal.span {x | ∃ u ∈ unitSet F, x = u - 1}
  have hJu : ∀ u ∈ unitSet F, u - 1 ∈ J := fun u hu => Ideal.subset_span ⟨u, hu, rfl⟩
  have h2J : (2 : unitRing F) ∈ J := by
    have h := J.neg_mem (hJu (-1) neg_one_mem_unitSet)
    have e : -((-1 : unitRing F) - 1) = 2 := by ring
    rwa [e] at h
  -- every element is `0` or `1` modulo `J`
  have h01 : ∀ x : unitRing F, x ∈ J ∨ x - 1 ∈ J := by
    refine unitRing_induction (Or.inl J.zero_mem) ?_ fun u hu => Or.inr (hJu u hu)
    rintro x y (hx | hx) (hy | hy)
    · exact Or.inl (J.add_mem hx hy)
    · exact Or.inr (by have h := J.add_mem hx hy; rwa [← add_sub_assoc] at h)
    · exact Or.inr (by have h := J.add_mem hx hy; rwa [sub_add_eq_add_sub] at h)
    · refine Or.inl ?_
      have h := J.add_mem (J.add_mem hx hy) h2J
      have e : x - 1 + (y - 1) + 2 = x + y := by ring
      rwa [e] at h
  -- the character kills `J`
  have hkill : ∀ x ∈ J, ∀ r : unitRing F, τ (r * x) = 0 := by
    intro x hx
    induction hx using Submodule.span_induction with
    | mem x hx =>
      obtain ⟨u, hu, rfl⟩ := hx
      refine unitRing_induction (by rw [zero_mul, map_zero]) (fun a b ha hb => ?_) fun v hv => ?_
      · rw [add_mul, map_add, ha, hb, add_zero]
      · rw [mul_sub, mul_one, map_sub, hhalf _ (mul_mem_unitSet hv hu), hhalf v hv, sub_self]
    | zero => intro r; rw [mul_zero, map_zero]
    | add x y _ _ hx hy => intro r; rw [mul_add, map_add, hx r, hy r, add_zero]
    | smul a x _ hx => intro r; rw [smul_eq_mul, ← mul_assoc]; exact hx (r * a)
  have h1J : (1 : unitRing F) ∉ J := fun h => by
    have h0 := hkill 1 h 1
    rw [mul_one, hhalf 1 one_mem_unitSet] at h0
    exact half_ne_zero h0
  refine ⟨J, Ideal.isMaximal_iff.mpr ⟨h1J, fun J' x hJJ' hx hxJ' => ?_⟩, ?_⟩
  · have h := J'.sub_mem hxJ' (hJJ' ((h01 x).resolve_left hx))
    rwa [sub_sub_cancel] at h
  · -- conjugation is the identity modulo `J`: `ū − u = (ū − 1) − (u − 1)`
    refine unitRing_induction (by rw [map_zero, sub_self]; exact J.zero_mem) (fun x y hx hy => ?_) fun u hu => ?_
    · have h := J.add_mem hx hy
      have e : conjR F x - x + (conjR F y - y) = conjR F (x + y) - (x + y) := by rw [map_add]; ring
      rwa [e] at h
    · have h := J.sub_mem (hJu _ (conjR_mem_unitSet hu)) (hJu u hu)
      rwa [sub_sub_sub_cancel_right] at h

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

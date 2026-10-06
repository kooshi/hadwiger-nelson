import Proofs.HadwigerNelson.SpectralChain
import Mathlib.Topology.Instances.AddCircle.Defs
import Mathlib.GroupTheory.Torsion
import Mathlib.LinearAlgebra.Finsupp.LinearCombination

/-!
# Character colourings: band sets, and the gluing from the rational circle to every real field (FS-131 wave 10)

**Read aloud, against the informal claim.** A *character* of an additive group `M` is an additive map `θ : M → ℝ/ℤ`. For a set
`U ⊆ M` and a set `B ⊆ ℝ/ℤ` (the *band*), the *band set* `Θ_B(M, U)` is the set of characters with `θ(U) ⊆ B`; for the band
`B_k = [1/k, 1 − 1/k]` and `U` the unit vectors of a field's plane these are the characters whose colouring `x ↦ ⌊kθ(x)⌋` is a
proper `k`-colouring (`plans/FS89-derivation.md`, Notation). `T_N` is the subgroup of characters killed by `N`, `T` the torsion
characters, and `A` the **archimedean** characters: those that lift to an additive map into `ℝ`.

**Which `A`.** FS-89's Notation wrote `A` as `λ_e(x) = Re(ē x)` at one embedding, and with that reading the three rows stated
here are false (`ℚ(√3)`, band `1/4`); the filed erratum reads `A(R_F) = Hom_ℚ(F(i), ℝ) mod 1` (caution C109). Here `A` is
`archimedean M`, the characters with an additive lift `M → ℝ`: intrinsic to `M`, and for `M = R_F` equal to the erratum's set
(`mem_archimedean_unitRing_iff`), because an additive map from a subgroup of a `ℚ`-vector space into `ℝ` extends to a
`ℚ`-linear map.

**The rows.**
* **FS89-S0A-2, the gluing** (`gluing`, and `gluing_field` for the row's own instance): stated at the class its argument reads —
  a ring `Q₀` in which some integer `m ≥ 2` is invertible, a `Q₀`-module `M` spanned by a set `U` stable under the units `U₀`
  of the base, and *any* band. The proof is not the derivation's limit `lim 5^k·rep(Nθ(x/5^k))`: the per-layer real lifts sum
  to an additive map on the free module on `U`, integer-valued on the kernel of the map onto `M`; the kernel is `m`-divisible,
  and an `m`-divisible subgroup of `ℤ` is `0`.
* **FS89-S0A-10, the equivalence** (`gluing_iff_uniform`, `gluing_iff_of_orderBound`): at every band the uniform statement
  (`∃ N`) over `ℚ` is equivalent to the uniform statement over every real field; the statement with `T` in place of `T_N` is
  equivalent **given the band's order bound** `OrderBound B N`, a named hypothesis from outside the backlog (FS89-S0A-3 at
  `k = 4`, on Weil's bound; J08-11 at `k = 5`; J08-10 at `k = 6`; not derived at any other band).
* **FS89-CL2** (`cl2`): the gluing at the two bands `1/4` and `1/5`, over the rational statements as named hypotheses (`RQ₄`
  with `N₀`, `RQ₅` with its order bound; FS89-D2-T1, -S0A-3, -D5-T2 and J08-11, none a backlog row).

**Inhabitants.** `bandSet`'s hypotheses are sets, not structures. The half character `x ↦ x/2` of `ℤ` is in the band set of
`{1}` at band `1/2` and is torsion (`half_mem_bandSet`, `half_mem_torsionBy`): the hypotheses of `gluing` are satisfiable with a
nonempty band set.
-/

namespace HadwigerNelson.CharacterColouring

open SpectralChain

/-! ## The vocabulary -/

section Vocabulary

variable {M : Type*} [AddCommGroup M]

/-- The reduction `ℝ → ℝ/ℤ`, as an additive map. -/
def mk1 : ℝ →+ UnitAddCircle := QuotientAddGroup.mk' _

@[simp] theorem mk1_apply (x : ℝ) : mk1 x = (x : UnitAddCircle) := rfl

/-- **The band set** `Θ_B(M, U)`: the characters of `M` whose values on `U` lie in the band `B`. -/
def bandSet (U : Set M) (B : Set UnitAddCircle) : Set (M →+ UnitAddCircle) := {θ | ∀ u ∈ U, θ u ∈ B}

/-- **`T_N`**: the characters killed by `N`. -/
def torsionBy (M : Type*) [AddCommGroup M] (N : ℕ) : AddSubgroup (M →+ UnitAddCircle) where
  carrier := {θ | N • θ = 0}
  zero_mem' := smul_zero N
  add_mem' ha hb := by
    simp only [Set.mem_setOf_eq] at ha hb ⊢
    rw [smul_add, ha, hb, add_zero]
  neg_mem' ha := by
    simp only [Set.mem_setOf_eq] at ha ⊢
    rw [smul_neg, ha, neg_zero]

theorem mem_torsionBy {N : ℕ} {θ : M →+ UnitAddCircle} : θ ∈ torsionBy M N ↔ N • θ = 0 := Iff.rfl

/-- **`A`**, the archimedean characters: those with an additive lift to `ℝ`. -/
def archimedean (M : Type*) [AddCommGroup M] : AddSubgroup (M →+ UnitAddCircle) :=
  (AddMonoidHom.compHom (mk1) : (M →+ ℝ) →+ (M →+ UnitAddCircle)).range

theorem mem_archimedean {θ : M →+ UnitAddCircle} : θ ∈ archimedean M ↔ ∃ ψ : M →+ ℝ, ∀ x, θ x = (ψ x : UnitAddCircle) := by
  constructor
  · rintro ⟨ψ, rfl⟩
    exact ⟨ψ, fun _ => rfl⟩
  · rintro ⟨ψ, h⟩
    exact ⟨ψ, AddMonoidHom.ext fun x => (h x).symm⟩

/-- The band `B_k = [1/k, 1 − 1/k]` in `ℝ/ℤ`. -/
def band (k : ℕ) : Set UnitAddCircle := (fun x : ℝ => (x : UnitAddCircle)) '' Set.Icc (1 / (k : ℝ)) (1 - 1 / (k : ℝ))

/-- **The order bound at a band**, over a base `(Q₀, U₀)`: a band character in `T + A` is in `T_N + A`. -/
def OrderBound {Q : Type*} [AddCommGroup Q] (U₀ : Set Q) (B : Set UnitAddCircle) (N : ℕ) : Prop :=
  bandSet U₀ B ∩ ((AddCommGroup.torsion (Q →+ UnitAddCircle) ⊔ archimedean Q : AddSubgroup _) : Set _) ⊆
    ((torsionBy Q N ⊔ archimedean Q : AddSubgroup _) : Set _)

theorem torsionBy_le_torsion {N : ℕ} (hN : N ≠ 0) : torsionBy M N ≤ AddCommGroup.torsion (M →+ UnitAddCircle) := by
  intro θ hθ
  rw [AddCommGroup.mem_torsion, isOfFinAddOrder_iff_nsmul_eq_zero]
  exact ⟨N, Nat.pos_of_ne_zero hN, hθ⟩

/-- A torsion character is killed by some positive `N`. -/
theorem exists_mem_torsionBy_of_mem_torsion {θ : M →+ UnitAddCircle} (h : θ ∈ AddCommGroup.torsion (M →+ UnitAddCircle)) :
    ∃ N : ℕ, N ≠ 0 ∧ θ ∈ torsionBy M N := by
  rw [AddCommGroup.mem_torsion, isOfFinAddOrder_iff_nsmul_eq_zero] at h
  obtain ⟨N, hN, h⟩ := h
  exact ⟨N, hN.ne', h⟩

end Vocabulary

/-! ## The gluing, at the class its argument reads -/

section Gluing

variable {Q₀ M : Type*} [Ring Q₀] [AddCommGroup M] [Module Q₀ M]

/-- An integer divisible by every power of `m ≥ 2` is `0`. -/
theorem int_eq_zero_of_forall_pow_dvd {m : ℕ} (hm : 2 ≤ m) {n : ℤ} (h : ∀ j : ℕ, ((m : ℤ) ^ j) ∣ n) : n = 0 := by
  refine Int.eq_zero_of_abs_lt_dvd (h n.natAbs) ?_
  have h1 : (n.natAbs : ℤ) < (m : ℤ) ^ n.natAbs := by
    exact_mod_cast (Nat.lt_pow_self (show 1 < m by omega) : n.natAbs < m ^ n.natAbs)
  rw [Int.abs_eq_natAbs]
  exact h1

/-- **The lift.** If a character `φ` of a `Q₀`-module `M` spanned by `U` restricts, on each layer `Q₀ • b` (`b ∈ U`), to the
reduction of an additive real map, and some integer `m ≥ 2` is invertible in `Q₀`, then `φ` is archimedean. -/
theorem mem_archimedean_of_layers {m : ℕ} (hm : 2 ≤ m) {c : Q₀} (hc : (m : Q₀) * c = 1) {U : Set M}
    (hspan : Submodule.span Q₀ U = ⊤) (φ : M →+ UnitAddCircle)
    (h : ∀ b ∈ U, ∃ ℓ : Q₀ →+ ℝ, ∀ x : Q₀, φ (x • b) = (ℓ x : UnitAddCircle)) : φ ∈ archimedean M := by
  classical
  choose! ℓ hℓ using h
  -- the sum of the per-layer lifts, on the free module on `U`
  let Φ : (U →₀ Q₀) →+ ℝ := Finsupp.liftAddHom fun b : U => ℓ b
  let π : (U →₀ Q₀) →ₗ[Q₀] M := Finsupp.linearCombination Q₀ (fun b : U => (b : M))
  have hΦ : ∀ f : U →₀ Q₀, ((Φ f : ℝ) : UnitAddCircle) = φ (π f) := by
    intro f
    induction f using Finsupp.induction_linear with
    | zero => simp
    | add f g hf hg => rw [map_add, map_add, map_add, AddCircle.coe_add, hf, hg]
    | single b x =>
      rw [Finsupp.liftAddHom_apply_single, Finsupp.linearCombination_single]
      exact (hℓ b b.2 x).symm
  -- the kernel is `m`-divisible and `Φ` is integer-valued on it, so `Φ` vanishes there
  have hker : ∀ f : U →₀ Q₀, π f = 0 → Φ f = 0 := by
    intro f hf
    have hdiv : ∀ j : ℕ, ∃ g : U →₀ Q₀, π g = 0 ∧ Φ f = (m : ℝ) ^ j * Φ g := by
      intro j
      induction j with
      | zero => exact ⟨f, hf, by simp⟩
      | succ j ih =>
        obtain ⟨g, hg0, hg⟩ := ih
        refine ⟨c • g, by rw [map_smul, hg0, smul_zero], ?_⟩
        have hgm : g = m • (c • g) := by
          rw [← Nat.cast_smul_eq_nsmul Q₀, smul_smul, hc, one_smul]
        have : Φ g = (m : ℝ) * Φ (c • g) := by
          conv_lhs => rw [hgm]
          rw [map_nsmul, nsmul_eq_mul]
        rw [hg, this, pow_succ, mul_assoc]
    have hint : ∀ g : U →₀ Q₀, π g = 0 → ∃ n : ℤ, (n : ℝ) = Φ g := by
      intro g hg
      have h0 : ((Φ g : ℝ) : UnitAddCircle) = 0 := by rw [hΦ, hg, map_zero]
      obtain ⟨n, hn⟩ := (AddCircle.coe_eq_zero_iff (1 : ℝ)).mp h0
      exact ⟨n, by simpa using hn⟩
    obtain ⟨n, hn⟩ := hint f hf
    have hn0 : n = 0 := by
      refine int_eq_zero_of_forall_pow_dvd hm fun j => ?_
      obtain ⟨g, hg0, hg⟩ := hdiv j
      obtain ⟨k, hk⟩ := hint g hg0
      refine ⟨k, ?_⟩
      have : (n : ℝ) = (((m : ℤ) ^ j * k : ℤ) : ℝ) := by
        push_cast
        rw [hn, hg, hk]
      exact_mod_cast this
    rw [← hn, hn0, Int.cast_zero]
  have hsurj : Function.Surjective π := by
    rw [← LinearMap.range_eq_top, Finsupp.range_linearCombination, Subtype.range_coe, hspan]
  have hwd : ∀ f g : U →₀ Q₀, π f = π g → Φ f = Φ g := by
    intro f g hfg
    have := hker (f - g) (by rw [map_sub, hfg, sub_self])
    rwa [map_sub, sub_eq_zero] at this
  let Ψ : M →+ ℝ :=
    { toFun := fun x => Φ (Function.surjInv hsurj x)
      map_zero' := hker _ (Function.surjInv_eq hsurj 0)
      map_add' := fun x y => by
        rw [← map_add]
        refine hwd _ _ ?_
        rw [map_add, Function.surjInv_eq hsurj, Function.surjInv_eq hsurj, Function.surjInv_eq hsurj] }
  refine mem_archimedean.mpr ⟨Ψ, fun x => ?_⟩
  show φ x = ((Φ (Function.surjInv hsurj x) : ℝ) : UnitAddCircle)
  rw [hΦ, Function.surjInv_eq hsurj]

/-- If `N • θ` is archimedean and `N ≠ 0`, then `θ ∈ T_N + A`. -/
theorem mem_torsionBy_sup_archimedean_of_nsmul {N : ℕ} (hN : N ≠ 0) {θ : M →+ UnitAddCircle}
    (h : N • θ ∈ archimedean M) : θ ∈ torsionBy M N ⊔ archimedean M := by
  obtain ⟨Ψ, hΨ⟩ := mem_archimedean.mp h
  let ψ : M →+ ℝ := (AddMonoidHom.mulLeft ((N : ℝ)⁻¹)).comp Ψ
  let α : M →+ UnitAddCircle := mk1.comp ψ
  have hα : α ∈ archimedean M := mem_archimedean.mpr ⟨ψ, fun _ => rfl⟩
  have hτ : θ - α ∈ torsionBy M N := by
    rw [mem_torsionBy]
    ext x
    have hN' : (N : ℝ) ≠ 0 := Nat.cast_ne_zero.mpr hN
    have h1 : N • α x = ((Ψ x : ℝ) : UnitAddCircle) := by
      show N • ((ψ x : ℝ) : UnitAddCircle) = _
      rw [← AddCircle.coe_nsmul]
      congr 1
      show N • ((N : ℝ)⁻¹ * Ψ x) = Ψ x
      rw [nsmul_eq_mul, ← mul_assoc, mul_inv_cancel₀ hN', one_mul]
    have h2 : N • θ x = ((Ψ x : ℝ) : UnitAddCircle) := hΨ x
    simp only [AddMonoidHom.smul_apply, AddMonoidHom.sub_apply, AddMonoidHom.zero_apply, smul_sub, h1, h2, sub_self]
  have : θ = (θ - α) + α := by abel
  rw [this]
  exact AddSubgroup.add_mem_sup hτ hα

/-- **FS89-S0A-2, the gluing, at the class its argument reads.** Let some integer `m ≥ 2` be invertible in the ring `Q₀`, and
let the `Q₀`-module `M` be spanned by a set `U` with `U₀ • U ⊆ U`. If every band character of the base `(Q₀, U₀)` is in
`T_N + A`, so is every band character of `(M, U)` — for any band `B ⊆ ℝ/ℤ` whatever. -/
theorem gluing {m : ℕ} (hm : 2 ≤ m) {c : Q₀} (hc : (m : Q₀) * c = 1) {U₀ : Set Q₀} {U : Set M}
    (hU : ∀ a ∈ U₀, ∀ b ∈ U, a • b ∈ U) (hspan : Submodule.span Q₀ U = ⊤) (B : Set UnitAddCircle) (N : ℕ)
    (h : bandSet U₀ B ⊆ ((torsionBy Q₀ N ⊔ archimedean Q₀ : AddSubgroup _) : Set _)) :
    bandSet U B ⊆ ((torsionBy M N ⊔ archimedean M : AddSubgroup _) : Set _) := by
  intro θ hθ
  rcases Nat.eq_zero_or_pos N with hN | hN
  · -- `T_0` is everything
    subst hN
    exact AddSubgroup.mem_sup_left (by rw [mem_torsionBy, zero_nsmul])
  refine mem_torsionBy_sup_archimedean_of_nsmul hN.ne' (mem_archimedean_of_layers hm hc hspan _ fun b hb => ?_)
  -- the layer character `θ_b(x) = θ(x • b)` is a band character of the base
  let θb : Q₀ →+ UnitAddCircle := θ.comp ((AddMonoidHom.smul : Q₀ →+ M →+ M).flip b)
  have hθb : θb ∈ bandSet U₀ B := fun a ha => hθ _ (hU a ha b hb)
  obtain ⟨τ, hτ, α, hα, hsum⟩ := AddSubgroup.mem_sup.mp (h hθb)
  obtain ⟨ψ, hψ⟩ := mem_archimedean.mp hα
  refine ⟨N • ψ, fun x => ?_⟩
  have hx : θb x = τ x + α x := by rw [← hsum]; rfl
  have hτx : N • τ x = 0 := by
    have := congrArg (fun f : Q₀ →+ UnitAddCircle => f x) (mem_torsionBy.mp hτ)
    simpa using this
  show N • θ (x • b) = (((N • ψ) x : ℝ) : UnitAddCircle)
  have : θ (x • b) = θb x := rfl
  rw [this, hx, smul_add, hτx, zero_add, hψ x, AddMonoidHom.smul_apply, AddCircle.coe_nsmul]

end Gluing

/-! ## The row's instance: the unit-vector rings of real fields -/

noncomputable section Field

/-- `U_F`, as a subset of `R_F = ℤ[U_F]`. -/
def unitSet (F : Subfield ℝ) : Set (unitRing F) := {x | (x : ℂ) ∈ unitVectors F}

/-- `Θ_B(R_F)`: the band characters of the plane over `F`. -/
abbrev fieldBandSet (F : Subfield ℝ) (B : Set UnitAddCircle) : Set (unitRing F →+ UnitAddCircle) := bandSet (unitSet F) B

/-- `Q = ℤ[U_ℚ]`, the unit-vector ring of the rational plane: the case `F = ℚ`. -/
abbrev Qring : Subring ℂ := unitRing (⊥ : Subfield ℝ)

theorem unitVectors_mono {F F' : Subfield ℝ} (h : F ≤ F') : unitVectors F ⊆ unitVectors F' :=
  fun _ hu => ⟨⟨h hu.1.1, h hu.1.2⟩, hu.2⟩

theorem unitRing_mono {F F' : Subfield ℝ} (h : F ≤ F') : unitRing F ≤ unitRing F' :=
  Subring.closure_mono (unitVectors_mono h)

/-- The `ℤ[U_ℚ]`-algebra structure of `R_F`, by inclusion. A local instance of this file only: no global speech. -/
@[reducible] def algebraQ (F : Subfield ℝ) : Algebra Qring (unitRing F) :=
  (Subring.inclusion (unitRing_mono (bot_le : (⊥ : Subfield ℝ) ≤ F))).toAlgebra

attribute [local instance] algebraQ

/-- Generic in the two subrings, so the kernel checks the `rfl` once with variables: at the concrete pair
`unitRing ⊥ ≤ unitRing F` a direct `rfl` sends the kernel into `F =?= ⊥` (measured: a deterministic timeout). -/
theorem coe_inclusion_subring {R : Type*} [Ring R] {S T : Subring R} (h : S ≤ T) (a : S) :
    ((Subring.inclusion h a : T) : R) = (a : R) := rfl

theorem coe_smul_unitRing (F : Subfield ℝ) (a : Qring) (b : unitRing F) : ((a • b : unitRing F) : ℂ) = (a : ℂ) * (b : ℂ) := by
  rw [Algebra.smul_def, RingHom.algebraMap_toAlgebra, Subring.coe_mul, coe_inclusion_subring]

/-- `1/5 ∈ ℤ[U_ℚ]`: `(3 + 4i)/5 + (3 − 4i)/5 − 1 = 1/5`. -/
theorem inv_five_mem_Qring : (5 : ℂ)⁻¹ ∈ Qring := by
  have hmem : ∀ z : ℂ, z.re ∈ (⊥ : Subfield ℝ) → z.im ∈ (⊥ : Subfield ℝ) → ‖z‖ = 1 → z ∈ Qring :=
    fun z h1 h2 h3 => UnitRing.unit_mem_unitRingOver ⟨h1, h2⟩ h3
  have hq : ∀ q : ℚ, (q : ℝ) ∈ (⊥ : Subfield ℝ) := fun q => SubfieldClass.ratCast_mem _ q
  have h1 : (⟨3 / 5, 4 / 5⟩ : ℂ) ∈ Qring := by
    refine hmem _ (by simpa using hq (3 / 5)) (by simpa using hq (4 / 5)) ?_
    rw [Complex.norm_eq_sqrt_sq_add_sq]
    norm_num
  have h2 : (⟨3 / 5, -(4 / 5)⟩ : ℂ) ∈ Qring := by
    refine hmem _ (by simpa using hq (3 / 5)) (by simpa using hq (-(4 / 5))) ?_
    rw [Complex.norm_eq_sqrt_sq_add_sq]
    norm_num
  have h3 : (1 : ℂ) ∈ Qring := Qring.one_mem
  have : (5 : ℂ)⁻¹ = (⟨3 / 5, 4 / 5⟩ : ℂ) + (⟨3 / 5, -(4 / 5)⟩ : ℂ) - 1 := by
    apply Complex.ext
    · simp
      norm_num
    · simp
  rw [this]
  exact Qring.sub_mem (Qring.add_mem h1 h2) h3

/-- **FS89-S0A-2, the gluing, in the row's words**: if every band character of `ℤ[U_ℚ]` is in `T_N + A`, then so is every band
character of `R_F`, for every subfield `F ⊆ ℝ` — at every band (indeed for any subset `B` of `ℝ/ℤ`). -/
theorem gluing_field (B : Set UnitAddCircle) (N : ℕ)
    (h : fieldBandSet ⊥ B ⊆ ((torsionBy Qring N ⊔ archimedean Qring : AddSubgroup _) : Set _)) (F : Subfield ℝ) :
    fieldBandSet F B ⊆ ((torsionBy (unitRing F) N ⊔ archimedean (unitRing F) : AddSubgroup _) : Set _) := by
  refine gluing (m := 5) (by norm_num) (c := ⟨(5 : ℂ)⁻¹, inv_five_mem_Qring⟩) ?_ (U₀ := unitSet ⊥) (U := unitSet F) ?_ ?_ B N h
  · apply Subtype.ext
    rw [Subring.coe_mul, Subring.coe_natCast, Subring.coe_one]
    norm_num
  · intro a ha b hb
    show ((a • b : unitRing F) : ℂ) ∈ unitVectors F
    rw [coe_smul_unitRing]
    have ha' := unitVectors_mono (bot_le : (⊥ : Subfield ℝ) ≤ F) ha
    exact ⟨(UnitRing.planeOverSubfield F).mul_mem ha'.1 hb.1, by rw [norm_mul, ha'.2, hb.2, one_mul]⟩
  · -- `R_F` is the additive span of `U_F`, a fortiori its `Q`-span
    rw [eq_top_iff]
    rintro ⟨x, hx⟩ -
    obtain ⟨n, u, hu1, huF, rfl⟩ := UnitRing.exists_sum_eq_of_mem_unitRingOver hx
    have hmem : ∀ j, (⟨u j, UnitRing.unit_mem_unitRingOver (huF j) (hu1 j)⟩ : unitRing F) ∈ Submodule.span Qring (unitSet F) :=
      fun j => Submodule.subset_span ⟨huF j, hu1 j⟩
    have hsum : (⟨∑ j, u j, hx⟩ : unitRing F) =
        ∑ j, (⟨u j, UnitRing.unit_mem_unitRingOver (huF j) (hu1 j)⟩ : unitRing F) := by
      apply Subtype.ext
      simp
    rw [hsum]
    exact Submodule.sum_mem _ fun j _ => hmem j

/-- **FS89-S0A-10, the equivalence, uniform form — unconditional at every band**: some `N ≠ 0` works over `ℚ` iff some `N ≠ 0`
works over every subfield of `ℝ`. `⟸` is `F = ℚ`; `⟹` is the gluing. -/
theorem gluing_iff_uniform (B : Set UnitAddCircle) :
    (∃ N : ℕ, N ≠ 0 ∧ fieldBandSet ⊥ B ⊆ ((torsionBy Qring N ⊔ archimedean Qring : AddSubgroup _) : Set _)) ↔
      ∃ N : ℕ, N ≠ 0 ∧ ∀ F : Subfield ℝ,
        fieldBandSet F B ⊆ ((torsionBy (unitRing F) N ⊔ archimedean (unitRing F) : AddSubgroup _) : Set _) :=
  ⟨fun ⟨N, hN, h⟩ => ⟨N, hN, gluing_field B N h⟩, fun ⟨N, hN, h⟩ => ⟨N, hN, h ⊥⟩⟩

/-- **FS89-S0A-10, the equivalence, in the row's words, given the band's order bound**: `Θ_B(ℤ[U_ℚ]) ⊆ T + A` iff
`Θ_B(R_F) ⊆ T + A` for every subfield `F ⊆ ℝ`. The hypothesis `hN` (the order bound at the band, `N ≠ 0`) is from outside the
backlog: FS89-S0A-3 gives `N = 168` at `band 4` (on Weil's bound), J08-11 gives `35112` at `band 5`, J08-10 gives `105336` at
`band 6`; at no other band is it derived, and the gluing cannot supply it (FS89-S0A-5's layer-wise torsion of unbounded
order). -/
theorem gluing_iff_of_orderBound (B : Set UnitAddCircle) {N : ℕ} (hN0 : N ≠ 0) (hN : OrderBound (unitSet ⊥) B N) :
    fieldBandSet ⊥ B ⊆ ((AddCommGroup.torsion (Qring →+ UnitAddCircle) ⊔ archimedean Qring : AddSubgroup _) : Set _) ↔
      ∀ F : Subfield ℝ, fieldBandSet F B ⊆
        ((AddCommGroup.torsion (unitRing F →+ UnitAddCircle) ⊔ archimedean (unitRing F) : AddSubgroup _) : Set _) := by
  refine ⟨fun h F θ hθ => ?_, fun h => h ⊥⟩
  have h' : fieldBandSet ⊥ B ⊆ ((torsionBy Qring N ⊔ archimedean Qring : AddSubgroup _) : Set _) :=
    fun θ hθ => hN ⟨hθ, h hθ⟩
  exact sup_le_sup_right (torsionBy_le_torsion hN0) _ (gluing_field B N h' F hθ)

/-- **FS89-CL2**: for every subfield `F ⊆ ℝ`, `Θ₄(R_F) ⊆ T₁₆₈ + A` and `Θ₅(R_F) ⊆ T + A`. A composition, with no new step:
the gluing at the bands `1/4` and `1/5`, over the rational statements as named hypotheses from outside the backlog —
`hRQ4` (RQ₄, FS89-D2-T1), `hN0` (Lemma N₀, FS89-S0A-3, on Weil's bound), `hRQ5` (RQ₅, FS89-D5-T2) and `hN5` (the order bound
at band `1/5`, J08-11: `N₅ = 35112`). -/
theorem cl2
    (hRQ4 : fieldBandSet ⊥ (band 4) ⊆
      ((AddCommGroup.torsion (Qring →+ UnitAddCircle) ⊔ archimedean Qring : AddSubgroup _) : Set _))
    (hN0 : OrderBound (unitSet ⊥) (band 4) 168)
    (hRQ5 : fieldBandSet ⊥ (band 5) ⊆
      ((AddCommGroup.torsion (Qring →+ UnitAddCircle) ⊔ archimedean Qring : AddSubgroup _) : Set _))
    {N₅ : ℕ} (hN5pos : N₅ ≠ 0) (hN5 : OrderBound (unitSet ⊥) (band 5) N₅) (F : Subfield ℝ) :
    fieldBandSet F (band 4) ⊆ ((torsionBy (unitRing F) 168 ⊔ archimedean (unitRing F) : AddSubgroup _) : Set _) ∧
      fieldBandSet F (band 5) ⊆
        ((AddCommGroup.torsion (unitRing F →+ UnitAddCircle) ⊔ archimedean (unitRing F) : AddSubgroup _) : Set _) :=
  ⟨gluing_field (band 4) 168 (fun _ hθ => hN0 ⟨hθ, hRQ4 hθ⟩) F,
    (gluing_iff_of_orderBound (band 5) hN5pos hN5).mp hRQ5 F⟩

/-- **The corrected `A` is the erratum's**: a character of `R_F` is archimedean iff it is the reduction of a `ℚ`-linear map
`F(i) → ℝ` restricted to `R_F` (`A(R_F) = Hom_ℚ(F(i), ℝ) mod 1`, `plans/FS89-derivation.md:32`). -/
theorem mem_archimedean_unitRing_iff (F : Subfield ℝ) (θ : unitRing F →+ UnitAddCircle) :
    θ ∈ archimedean (unitRing F) ↔
      ∃ ℓ : fieldI F →ₗ[ℚ] ℝ, ∀ x : unitRing F,
        θ x = ((ℓ ⟨x, UnitRing.unitRingOver_le_planeOverSubring F x.2⟩ : ℝ) : UnitAddCircle) := by
  sorry

end Field

/-! ## Spec -/

/-- The half character of `ℤ`: `x ↦ x/2 mod 1`. -/
noncomputable def half : ℤ →+ UnitAddCircle := mk1.comp ((AddMonoidHom.mulLeft (1 / 2 : ℝ)).comp (Int.castAddHom ℝ))

theorem half_one : half 1 = ((1 / 2 : ℝ) : UnitAddCircle) := by simp [half]

/-- The half character is a band character of `(ℤ, {1})` at the band `[1/2, 1/2]`. -/
theorem half_mem_bandSet : half ∈ bandSet ({1} : Set ℤ) (band 2) := by
  rintro u rfl
  rw [half_one]
  exact ⟨1 / 2, ⟨by norm_num, by norm_num⟩, rfl⟩

/-- The half character is killed by `2`. -/
theorem half_mem_torsionBy : half ∈ torsionBy ℤ 2 := by
  rw [mem_torsionBy]
  refine AddMonoidHom.ext fun x => ?_
  have : (2 : ℕ) • ((1 / 2 * (x : ℝ) : ℝ) : UnitAddCircle) = 0 := by
    rw [← AddCircle.coe_nsmul, AddCircle.coe_eq_zero_iff]
    exact ⟨x, by simp⟩
  simpa [half] using this

-- `band` would drift if its endpoints moved: `1/4 ∈ B₄`, `0 ∉ B₄`.
example : ((1 / 4 : ℝ) : UnitAddCircle) ∈ band 4 := ⟨1 / 4, ⟨by norm_num, by norm_num⟩, rfl⟩
-- `T_0` is everything, `T_1` is `0`.
example : half ∈ torsionBy ℤ 0 := by rw [mem_torsionBy, zero_nsmul]
-- the zero character is archimedean.
example : (0 : ℤ →+ UnitAddCircle) ∈ archimedean ℤ := zero_mem _
-- `1 ∈ U_ℚ`.
example : (1 : Qring) ∈ unitSet ⊥ := ⟨(UnitRing.planeOverSubfield ⊥).one_mem, by simp⟩

end HadwigerNelson.CharacterColouring

import Proofs.HadwigerNelson.Rigidity.DualGroup
import Proofs.HadwigerNelson.Rigidity.AdmissiblePrime
import Mathlib.MeasureTheory.Group.Action
import Mathlib.Dynamics.Ergodic.Action.Basic

/-!
# The unit vectors of `F²` as a group acting on `R̂`; admissible pairs (FS-131, job FS131-KN8; the vocabulary of modules M6 and M7b; proved by FS131-IDG1 but `exists_admissiblePair`)

**Read aloud, against the informal claim.** `SpectralChain` has the unit vectors of `F²` as a set of complex numbers,
`unitVectors F`, and the rotation `rot u` of `R̂ = Dual F` by each. The entropy split reads them as a **group** acting on
`R̂`, and a subgroup `Γ ≅ ℤ²` of it (FS100-X02D § 2.2, PE-1′). This module names:

* **`unitCircle F`**, the unit vectors as a subgroup of `Circle` (`z` with `(z : ℂ) ∈ F(i)`), with `toUnitVector`, a
  bijection onto `unitVectors F` (`unitCircleEquiv`);
* **the rotation action** `MulAction (unitCircle F) (Dual F)`, `g • χ = rot (toUnitVector g) χ` (`smul_def`, by `rfl`), each
  `g • ·` measurable (`MeasurableConstSMul`), so `MeasurableEquiv.smul g` is the rotation as a measurable equivalence; a
  measure is `RotInv` exactly when every `g • ·` preserves it (`rotInv_iff`); a Haar measure in Fourier form is `RotInv`
  (`IsHaarFourier.rotInv`, through `IsHaarFourier.map_dual_eq`);
* **`zpowHom u w : Multiplicative (Fin 2 → ℤ) →* unitCircle F`**, `n ↦ u^{n₀} w^{n₁}`;
* **`AdmissiblePair F`**, X02D's *admissible* `Γ` (l. 146, PE-1′) with its two generators carried as data, because the
  pieces' `ℤ²`-action is built from them: `zpowHom u w` is injective (two multiplicatively independent generators, so
  `ℤ² ≅ Γ`), and for every finite-index `Λ ⊆ ℤ²` the values on `Λ` generate the field `F(i)` (X02D: "`ℚ(Γ′) = L` for every
  finite-index `Γ′ ⊆ Γ`", read through `ℤ² ≅ Γ` as the axiom's `IsTotallyIrreducible` reads finite index). Its subgroup is
  `AdmissiblePair.subgroup`, the range of `zpowHom`. X02D's sufficient condition ("in particular if `Γ` contains a `w` with
  `ℚ(wᵏ) = L` for every `k ≥ 1`") is `AdmissiblePair.ofPow`; its existence over a real number field is
  `exists_admissiblePair` (X02D's Lemma W construction at one `u`).

**Models.** `toUnitVector`, the action and `zpowHom` are defined for every `F`; `AdmissiblePair F` is inhabited over every
real number field (`exists_admissiblePair`, a leaf) — at `ℚ` by `u = (3 + 4i)/5`, `w = (5 + 12i)/13` (the leaf's plan).
-/

namespace HadwigerNelson.Rigidity

open MeasureTheory SpectralChain SpectralInputs

noncomputable section

variable (F : Subfield ℝ)

/-- **The unit vectors of `F²` as a subgroup of the circle**: the `z` with `(z : ℂ) ∈ F(i)`. Closed under products in the
field `F(i)`, and under inverses, which are conjugates on the circle. -/
def unitCircle : Subgroup Circle where
  carrier := {z | (z : ℂ) ∈ fieldI F}
  mul_mem' {a b} ha hb := by
    show ((a * b : Circle) : ℂ) ∈ fieldI F
    rw [Circle.coe_mul]
    exact (fieldI F).mul_mem ha hb
  one_mem' := by
    show ((1 : Circle) : ℂ) ∈ fieldI F
    rw [Circle.coe_one]
    exact (fieldI F).one_mem
  inv_mem' {a} ha := by
    show ((a⁻¹ : Circle) : ℂ) ∈ fieldI F
    rw [Circle.coe_inv]
    exact (fieldI F).inv_mem ha

variable {F}

theorem mem_unitCircle {z : Circle} : z ∈ unitCircle F ↔ (z : ℂ) ∈ fieldI F := Iff.rfl

/-- A point of `unitCircle F` as a unit vector of `F²`. -/
def toUnitVector (g : unitCircle F) : unitVectors F :=
  ⟨((g : Circle) : ℂ), g.2, Circle.norm_coe _⟩

@[simp] theorem coe_toUnitVector (g : unitCircle F) : ((toUnitVector g : unitVectors F) : ℂ) = ((g : Circle) : ℂ) :=
  rfl

variable (F)

/-- **The two models of the unit vectors agree**: `toUnitVector` is a bijection onto `unitVectors F`. -/
def unitCircleEquiv : unitCircle F ≃ unitVectors F where
  toFun := toUnitVector
  invFun u := ⟨⟨u, mem_sphere_zero_iff_norm.mpr u.2.2⟩, u.2.1⟩
  left_inv g := by
    ext
    rfl
  right_inv u := by
    ext
    rfl

/-- The unit vector of a product is the product of the unit vectors, in `R`. -/
theorem uvRing_toUnitVector_mul (g h : unitCircle F) :
    uvRing (toUnitVector (g * h)) = uvRing (toUnitVector g) * uvRing (toUnitVector h) := by
  refine Subtype.ext ?_
  show (((g * h : unitCircle F) : Circle) : ℂ) = ((g : Circle) : ℂ) * ((h : Circle) : ℂ)
  rw [Subgroup.coe_mul, Circle.coe_mul]

theorem uvRing_toUnitVector_one : uvRing (toUnitVector (1 : unitCircle F)) = 1 := by
  refine Subtype.ext ?_
  show (((1 : unitCircle F) : Circle) : ℂ) = 1
  rw [OneMemClass.coe_one, Circle.coe_one]

/-- **The rotation action** of the unit vectors on `R̂`: `(g • χ)(r) = χ(g r)` — an action because `R` is commutative. -/
instance instMulActionDual : MulAction (unitCircle F) (Dual F) where
  smul g χ := rot (toUnitVector g) χ
  one_smul χ := by
    refine DFunLike.ext _ _ fun r => ?_
    show χ (uvRing (toUnitVector (1 : unitCircle F)) * r) = χ r
    rw [uvRing_toUnitVector_one, one_mul]
  mul_smul g h χ := by
    refine DFunLike.ext _ _ fun r => ?_
    show χ (uvRing (toUnitVector (g * h)) * r) = χ (uvRing (toUnitVector h) * (uvRing (toUnitVector g) * r))
    rw [uvRing_toUnitVector_mul, mul_comm (uvRing (toUnitVector g)), mul_assoc]

variable {F}

theorem smul_def (g : unitCircle F) (χ : Dual F) : g • χ = rot (toUnitVector g) χ := rfl

instance measurableConstSMul_dual : MeasurableConstSMul (unitCircle F) (Dual F) :=
  ⟨fun g => measurable_rot (toUnitVector g)⟩

/-- `RotInv` in the language of the action: every `g • ·` preserves the measure. -/
theorem rotInv_iff {τ : Measure (Dual F)} : RotInv F τ ↔ ∀ g : unitCircle F, τ.map (g • ·) = τ := by
  refine ⟨fun h g => h (toUnitVector g), fun h u => ?_⟩
  obtain ⟨g, rfl⟩ := (unitCircleEquiv F).surjective u
  exact h g

/-- **`R = ℤ[U]` is countable** over a number field (`SpectralChain.countable_unitRing`), as an instance: the standard
Borel structure of `Dual F` (`Rigidity.standardBorelSpace_dual`) reads it. -/
instance countable_unitRing_of_numberField [NumberField F] : Countable (unitRing F) :=
  @countable_unitRing F (Finsupp.Countable.of_moduleFinite (R := ℚ) (M := F))

/-- **`unitCircle F` is countable** over a number field: it injects into `R`. -/
instance countable_unitCircle [NumberField F] : Countable (unitCircle F) := by
  refine Function.Injective.countable (f := fun g : unitCircle F => uvRing (toUnitVector g)) fun g h hgh => ?_
  have hc : (((g : unitCircle F) : Circle) : ℂ) = ((h : Circle) : ℂ) := congrArg (fun x : unitRing F => (x : ℂ)) hgh
  exact Subtype.ext (Circle.ext hc)

/-- **A Haar measure in Fourier form is rotation invariant** (with no Herglotz–Bochner): `rot u` is the dual of
multiplication by `u`, injective on `R` (`IsHaarFourier.map_dual_eq`). -/
theorem _root_.HadwigerNelson.SpectralInputs.IsHaarFourier.rotInv [NumberField F] {m : Measure (Dual F)}
    (hm : IsHaarFourier m) : RotInv F m := by
  intro u
  have hu : uvRing u ≠ 0 := by
    intro h0
    have h1 : ‖((uvRing u : unitRing F) : ℂ)‖ = 1 := u.2.2
    rw [h0, ZeroMemClass.coe_zero, norm_zero] at h1
    exact zero_ne_one h1
  have hinj : Function.Injective (AddMonoidHom.mulLeft (uvRing u)) := fun a b hab =>
    mul_left_cancel₀ hu hab
  exact hm.map_dual_eq (AddMonoidHom.mulLeft (uvRing u)) hinj

/-! ## Admissible pairs -/

/-- `n ↦ u^{n₀} w^{n₁}`, a homomorphism from `ℤ²` (written multiplicatively) to the unit vectors. -/
def zpowHom (u w : unitCircle F) : Multiplicative (Fin 2 → ℤ) →* unitCircle F where
  toFun n := u ^ (Multiplicative.toAdd n 0) * w ^ (Multiplicative.toAdd n 1)
  map_one' := by simp
  map_mul' a b := by
    simp only [toAdd_mul, Pi.add_apply, zpow_add]
    exact mul_mul_mul_comm _ _ _ _

variable (F) in
/-- **An admissible pair** (FS100-X02D l. 146, PE-1′): two unit vectors `u`, `w` such that `n ↦ u^{n₀} w^{n₁}` is
injective on `ℤ²` (multiplicatively independent generators) and, for every finite-index `Λ ⊆ ℤ²`, the values on `Λ`
generate the field `F(i)` ("`ℚ(Γ′) = L` for every finite-index `Γ′ ⊆ Γ`"). -/
structure AdmissiblePair where
  /-- The first generator. -/
  u : unitCircle F
  /-- The second generator. -/
  w : unitCircle F
  /-- Multiplicatively independent: `ℤ² ≅ Γ`. -/
  injective : Function.Injective (zpowHom u w)
  /-- Every finite-index subgroup of `Γ` generates `F(i)`. -/
  generates : ∀ Λ : AddSubgroup (Fin 2 → ℤ), Λ.FiniteIndex →
    Subfield.closure ((fun n => (((zpowHom u w (Multiplicative.ofAdd n) : unitCircle F) : Circle) : ℂ)) '' Λ) = fieldI F

namespace AdmissiblePair

variable (p : AdmissiblePair F)

/-- The admissible group `Γ = ⟨u, w⟩`. -/
def subgroup : Subgroup (unitCircle F) := (zpowHom p.u p.w).range

theorem mem_subgroup {g : unitCircle F} : g ∈ p.subgroup ↔ ∃ n : Fin 2 → ℤ, zpowHom p.u p.w (Multiplicative.ofAdd n) = g :=
  ⟨fun ⟨n, hn⟩ => ⟨Multiplicative.toAdd n, hn⟩, fun ⟨n, hn⟩ => ⟨Multiplicative.ofAdd n, hn⟩⟩

/-- **The first generator is not a root of unity** (the rotation `entropySplit` returns): `u^k = 1` would make `zpowHom`
not injective. -/
theorem u_nonTorsion : ∀ k : ℕ, k ≠ 0 → ((toUnitVector p.u : unitVectors F) : ℂ) ^ k ≠ 1 := by
  intro k hk hpow
  have hu : p.u ^ k = 1 := by
    refine Subtype.ext (Circle.ext ?_)
    rw [SubmonoidClass.coe_pow, Circle.coe_pow, OneMemClass.coe_one, Circle.coe_one]
    exact hpow
  have hz : zpowHom p.u p.w (Multiplicative.ofAdd ![(k : ℤ), 0]) = zpowHom p.u p.w 1 := by
    rw [map_one]
    show p.u ^ ((k : ℤ)) * p.w ^ (0 : ℤ) = 1
    rw [zpow_zero, mul_one, zpow_natCast, hu]
  have h0 := congrArg (fun n : Multiplicative (Fin 2 → ℤ) => Multiplicative.toAdd n 0) (p.injective hz)
  simp only [toAdd_ofAdd, toAdd_one, Matrix.cons_val_zero, Pi.zero_apply, Nat.cast_eq_zero] at h0
  exact hk h0

end AdmissiblePair

/-- **X02D's sufficient condition** (l. 146, "in particular"): independent `u`, `w` with `ℚ(wᵏ) = F(i)` for every `k ≥ 1` are
an admissible pair — a finite-index `Λ ⊆ ℤ²` contains `(0, k)` for `k` its index. -/
def AdmissiblePair.ofPow (u w : unitCircle F) (hinj : Function.Injective (zpowHom u w))
    (hw : ∀ k : ℕ, 0 < k → Subfield.closure {(((w : Circle) : ℂ)) ^ k} = fieldI F) : AdmissiblePair F where
  u := u
  w := w
  injective := hinj
  generates Λ hΛ := by
    refine le_antisymm (Subfield.closure_le.mpr ?_) ?_
    · rintro _ ⟨n, _, rfl⟩
      exact (zpowHom u w (Multiplicative.ofAdd n)).2
    · have hidx : 0 < Λ.index := Nat.pos_of_ne_zero hΛ.index_ne_zero
      rw [← hw Λ.index hidx]
      refine Subfield.closure_mono (Set.singleton_subset_iff.mpr ⟨Λ.index • ![0, 1], ?_, ?_⟩)
      · exact Λ.nsmul_index_mem _
      · show (((u ^ ((Λ.index • ![(0 : ℤ), 1]) 0) * w ^ ((Λ.index • ![(0 : ℤ), 1]) 1) : unitCircle F) : Circle) :
            ℂ) = ((w : Circle) : ℂ) ^ Λ.index
        simp only [Pi.smul_apply, Matrix.cons_val_zero, Matrix.cons_val_one, smul_zero, zpow_zero, one_mul,
          nsmul_eq_mul, mul_one, zpow_natCast, SubmonoidClass.coe_pow, Circle.coe_pow]

/-- **An admissible pair exists over every real number field** (FS100-X02D's Lemma W construction, l. 156, at one `u`).
Plan: a rational prime `p` splitting completely in `F(i)` (one suffices; at a biquadratic `F(i)` by Dirichlet), a prime
`𝔓 ∣ p` of `F(i)` with `𝔓 ≠ 𝔓̄`, `(z) = 𝔓ʰ`, `w = z/z̄`; then `ℚ(wᵏ) = F(i)` for every `k ≥ 1` (X02D's valuation argument)
and `u` a second such element at another prime, independent by valuations; `AdmissiblePair.ofPow`. -/
theorem exists_admissiblePair [NumberField F] : Nonempty (AdmissiblePair F) := by
  obtain ⟨u, w, hu, hu1, hw, hw1, hind, hgen⟩ := exists_unitPair F
  let u' : unitCircle F := ⟨⟨u, mem_sphere_zero_iff_norm.mpr hu1⟩, hu⟩
  let w' : unitCircle F := ⟨⟨w, mem_sphere_zero_iff_norm.mpr hw1⟩, hw⟩
  refine ⟨AdmissiblePair.ofPow u' w' ?_ fun k hk => hgen k hk⟩
  rw [injective_iff_map_eq_one]
  intro n hn
  have h : u ^ (Multiplicative.toAdd n 0) * w ^ (Multiplicative.toAdd n 1) = 1 := by
    have h' := congrArg (fun g : unitCircle F => ((g : Circle) : ℂ)) hn
    change (((u' ^ Multiplicative.toAdd n 0 * w' ^ Multiplicative.toAdd n 1 : unitCircle F) : Circle) : ℂ) =
      (((1 : unitCircle F) : Circle) : ℂ) at h'
    simpa only [Subgroup.coe_mul, SubgroupClass.coe_zpow, Circle.coe_mul, Circle.coe_zpow, OneMemClass.coe_one,
      Circle.coe_one] using h'
  obtain ⟨h0, h1⟩ := hind _ _ h
  refine Multiplicative.toAdd.injective (funext fun i => ?_)
  fin_cases i
  · exact h0
  · exact h1

end

end HadwigerNelson.Rigidity

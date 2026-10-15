import Proofs.HadwigerNelson.Rigidity.DualGroup
import Mathlib.Topology.Algebra.ClopenNhdofOne
import Mathlib.Algebra.Category.Grp.Injective

/-!
# A torsion-free discrete group has a connected dual (FS-131, job FS131-KPD1; skeleton)

**Read aloud, against the informal claim.** For an abelian group `G` and its dual `Ĝ = AddChar G Circle` under the pointwise
topology (`Rigidity/DualGroup`, compact):

* **restriction is onto** (`surjective_compAddMonoidHom`): along an injective `f : H →+ G` every character of `H` extends to `G`
  — the circle is divisible, so injective as a `ℤ`-module (Mathlib's `Module.Baer.of_divisible` on `AddCircle`);
* **if `G` is torsion-free, `Ĝ` is divisible** (`exists_pow_eq`): `χ` on `G ≅ nG` read as a character of `nG`, extended to `G`,
  is an `n`-th root of `χ`;
* **D3: if `G` is torsion-free, `Ĝ` is connected** (`connectedSpace_dual`): a clopen neighbourhood of `1` in the compact group
  `Ĝ` contains an open subgroup (Mathlib's `IsTopologicalGroup.exist_openSubgroup_sub_clopen_nhds_of_one`), of finite index `m`
  (compactness); every `χ` is `ξ^m` with `ξ^m` in that subgroup, so the subgroup is `Ĝ`, and so is the neighbourhood.

What the chain reads (`Rigidity.isSolenoid_pieceDual`'s `connectedSpace` field, at `G = M ⊆ F(i)`, torsion-free). It reads no
D1, no Haar measure and no structure theory of compact groups.

**Models.** `G = ℤ` is torsion-free (Mathlib's instance), so `Ĝ` is connected (the example). **The negative partner:** `ZMod 2`
is not torsion-free and its dual is two points, not connected (`not_connectedSpace_dual_zmod_two`) — the hypothesis cannot be
dropped.
-/

namespace HadwigerNelson.Rigidity

open Topology

noncomputable section

variable {G : Type*} [AddCommGroup G]

/-- **Restriction of characters along an injective homomorphism is onto**: the circle is divisible. -/
theorem surjective_compAddMonoidHom {H : Type*} [AddCommGroup H] (f : H →+ G) (hf : Function.Injective f) :
    Function.Surjective fun ξ : AddChar G Circle => ξ.compAddMonoidHom f := by
  intro χ
  haveI : Fact ((0 : ℝ) < 1) := ⟨one_pos⟩
  let e : AddCircle (1 : ℝ) ≃+ Additive Circle :=
    { toFun := fun x => Additive.ofMul (AddCircle.toCircle x)
      invFun := fun z => (AddCircle.homeomorphCircle one_ne_zero).symm (Additive.toMul z)
      left_inv := fun x => by
        simp only [toMul_ofMul]
        rw [← AddCircle.homeomorphCircle_apply one_ne_zero, Homeomorph.symm_apply_apply]
      right_inv := fun z => by
        simp only
        rw [← AddCircle.homeomorphCircle_apply one_ne_zero, Homeomorph.apply_symm_apply, ofMul_toMul]
      map_add' := fun x y => by simp only [AddCircle.toCircle_add, ofMul_mul] }
  obtain ⟨h, hh⟩ := (Module.Baer.of_divisible (AddCircle (1 : ℝ))).extension_property_addMonoidHom f hf
    (e.symm.toAddMonoidHom.comp χ.toAddMonoidHom)
  refine ⟨AddChar.toAddMonoidHomEquiv.symm (e.toAddMonoidHom.comp h), ?_⟩
  refine AddChar.ext _ _ fun x => ?_
  have hx := congrArg (fun k : H →+ AddCircle (1 : ℝ) => e (k x)) hh
  simp only [AddMonoidHom.coe_comp, Function.comp_apply, AddEquiv.coe_toAddMonoidHom,
    AddEquiv.apply_symm_apply] at hx
  show Additive.toMul (e (h (f x))) = χ x
  exact congrArg Additive.toMul hx

/-- **The dual of a torsion-free group is divisible**: every character has an `n`-th root, `n ≠ 0`. -/
theorem exists_pow_eq [IsAddTorsionFree G] (χ : AddChar G Circle) {n : ℕ} (hn : n ≠ 0) :
    ∃ ξ : AddChar G Circle, ξ ^ n = χ := by
  obtain ⟨ξ, hξ⟩ := surjective_compAddMonoidHom (nsmulAddMonoidHom (α := G) n)
    (IsAddTorsionFree.nsmul_right_injective hn) χ
  refine ⟨ξ, AddChar.ext _ _ fun g => ?_⟩
  rw [AddChar.pow_apply, ← AddChar.map_nsmul_eq_pow, ← hξ]
  rfl

/-- **D3: the dual of a torsion-free discrete abelian group is connected.** -/
theorem connectedSpace_dual [IsAddTorsionFree G] : ConnectedSpace (AddChar G Circle) := by
  refine connectedSpace_iff_clopen.mpr ⟨⟨1⟩, fun s hs => ?_⟩
  rcases s.eq_empty_or_nonempty with h | ⟨χ₀, hχ₀⟩
  · exact Or.inl h
  right
  let W : Set (AddChar G Circle) := (fun χ => χ₀ * χ) ⁻¹' s
  have hW : IsClopen W := hs.preimage (continuous_const.mul continuous_id)
  have h1 : (1 : AddChar G Circle) ∈ W := by simpa [W] using hχ₀
  obtain ⟨H, hHW⟩ := IsTopologicalGroup.exist_openSubgroup_sub_clopen_nhds_of_one hW h1
  haveI : Finite (AddChar G Circle ⧸ H.toSubgroup) := Subgroup.quotient_finite_of_isOpen _ H.isOpen
  haveI : H.toSubgroup.Normal := Subgroup.normal_of_isMulCommutative _
  have hidx : H.toSubgroup.index ≠ 0 := Subgroup.index_ne_zero_of_finite
  refine Set.eq_univ_of_forall fun χ => ?_
  obtain ⟨ξ, hξ⟩ := exists_pow_eq (χ₀⁻¹ * χ) hidx
  have hmem : χ₀⁻¹ * χ ∈ (H : Set (AddChar G Circle)) := hξ ▸ H.toSubgroup.pow_index_mem ξ
  have := hHW hmem
  simpa [W] using this

example : ConnectedSpace (AddChar ℤ Circle) := connectedSpace_dual

/-- **The negative partner**: the dual of `ZMod 2` is not connected (two characters, and a finite Hausdorff space is
discrete), so `connectedSpace_dual` needs its torsion-freeness. -/
theorem not_connectedSpace_dual_zmod_two : ¬ ConnectedSpace (AddChar (ZMod 2) Circle) := by
  intro hc
  have hpm : ∀ χ : AddChar (ZMod 2) Circle, (χ 1 : ℂ) = 1 ∨ (χ 1 : ℂ) = -1 := by
    intro χ
    have h2 : (χ 1 : ℂ) * (χ 1 : ℂ) = 1 := by
      have h11 : (1 + 1 : ZMod 2) = 0 := by decide
      rw [← Circle.coe_mul, ← AddChar.map_add_eq_mul, h11, AddChar.map_zero_eq_one, Circle.coe_one]
    exact mul_self_eq_one_iff.mp h2
  obtain ⟨χ₁, hχ₁⟩ := exists_apply_ne_one (one_ne_zero : (1 : ZMod 2) ≠ 0)
  have hχ₁' : (χ₁ 1 : ℂ) = -1 := by
    rcases hpm χ₁ with h | h
    · exact absurd (Circle.ext (by rw [h, Circle.coe_one])) hχ₁
    · exact h
  let f : AddChar (ZMod 2) Circle → ℝ := fun χ => (χ 1 : ℂ).re
  have hf : Continuous f := Complex.continuous_re.comp (continuous_evalChar (ZMod 2) 1)
  have hf1 : f χ₁ ≤ 0 := by
    show (χ₁ 1 : ℂ).re ≤ 0
    rw [hχ₁']
    norm_num
  have hf2 : 0 ≤ f 1 := by
    show ((1 : AddChar (ZMod 2) Circle) 1 : ℂ).re ≥ 0
    rw [AddChar.one_apply, Circle.coe_one]
    norm_num
  obtain ⟨χ, hχ⟩ := intermediate_value_univ χ₁ 1 hf ⟨hf1, hf2⟩
  have hχ0 : (χ 1 : ℂ).re = 0 := hχ
  rcases hpm χ with h | h
  · rw [h] at hχ0
    norm_num at hχ0
  · rw [h] at hχ0
    norm_num at hχ0

end

end HadwigerNelson.Rigidity

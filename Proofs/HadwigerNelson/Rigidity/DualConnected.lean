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
  sorry

/-- **The dual of a torsion-free group is divisible**: every character has an `n`-th root, `n ≠ 0`. -/
theorem exists_pow_eq [IsAddTorsionFree G] (χ : AddChar G Circle) {n : ℕ} (hn : n ≠ 0) :
    ∃ ξ : AddChar G Circle, ξ ^ n = χ := by
  sorry

/-- **D3: the dual of a torsion-free discrete abelian group is connected.** -/
theorem connectedSpace_dual [IsAddTorsionFree G] : ConnectedSpace (AddChar G Circle) := by
  sorry

example : ConnectedSpace (AddChar ℤ Circle) := connectedSpace_dual

/-- **The negative partner**: the dual of `ZMod 2` is not connected (two characters, and a finite Hausdorff space is
discrete), so `connectedSpace_dual` needs its torsion-freeness. -/
theorem not_connectedSpace_dual_zmod_two : ¬ ConnectedSpace (AddChar (ZMod 2) Circle) := by
  sorry

end

end HadwigerNelson.Rigidity

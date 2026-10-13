import Proofs.HadwigerNelson.ThreeColour
import Proofs.HadwigerNelson.Arith.CharacterColouring
import Mathlib.Analysis.LocallyConvex.Separation
import Mathlib.Topology.Algebra.Group.Compact

/-!
# Three colours give a character: the criterion's ⟹ in character form (FS-131, NF4; planner FS131-KN4)

**Read aloud, against the claim** (`data/fs131/claims-NF4.md`, NF4-S6): *"A winding on the relation lattice of
`Cay(R_F, U_F)` gives a character `θ` of `R_F` with `θ(U_F) ⊆ [1/3, 2/3]` (`plans/FS73-derivation.md` T22;
`plans/FS81-derivation.md:39`)."* In this library's words: a proper 3-colouring of the unit-distance graph on `F²`
gives a point of `CharacterColouring.fieldBandSet F (band 3)` — an additive map `θ : ℤ[U_F] → ℝ/ℤ` with
`θ(u) ∈ [1/3, 2/3]` at every unit vector `u` of `F²`. **Every subfield `F ⊆ ℝ`; no finite generation, no number field.**

**The route** (FS81-T2, `plans/FS81-derivation.md:39`, in the form the kernel's winding makes short).
1. *Finitely many generators.* A colouring proper along `s : Fin m → A` carries a winding `W` on the relation lattice
   (`ThreeColour.nonempty_winding`, in the kernel since FS-75). `Winding.exists_box_point`: some `x ∈ [1/3, 2/3]^m` has
   `r · x = W r` on every relation — the box and the affine condition are separated otherwise, and the separating
   functional, moved to a rational and then an integer combination of relations, contradicts `W.minRise_le` at `−r`.
2. *A character of the whole group.* `r · x ∈ ℤ` on relations, so `s j ↦ x j mod 1` is a character of the subgroup `s`
   generates; `ℝ/ℤ` is divisible, so it extends to `A` (`exists_character_of_box_point`).
3. *All generators at once.* The characters of `A` with `θ(S) ⊆ B` form a closed subset of the compact space
   `A → ℝ/ℤ`, decreasing in `S`; finite `S` suffice (`bandSet_nonempty_of_finite`) — de Bruijn–Erdős in character form.

**Whose this is** (`LEDGER.md` § The claim list, row 79). The criterion "three colours are linear" is this project's
FS73-T22 with FS81-T2's passage to infinitely many generators `[hand; two independent derivations]`; not found in print,
never "first". The compactness is de Bruijn–Erdős's in character form.

**Inhabitants.** `ThreeColour.properAlong_one_two` (`ℤ` along `(1, 2)`, `x ↦ x mod 3`) inhabits every hypothesis here;
`exists_character_one_two` is the conclusion at that model.
-/

namespace HadwigerNelson.ThreeColourCharacter

open HadwigerNelson.ThreeColour HadwigerNelson.CharacterColouring HadwigerNelson.SpectralChain SimpleGraph

variable {A : Type*} [AddCommGroup A] {m : ℕ}

/-! ## §1 Finitely many generators: from the winding to a point of the box -/

/-- **Finitely many strict linear inequalities with a real solution have an integer one**: the solutions form an open
cone, the rational vectors are dense, and a common denominator scales a rational solution to an integer one. (The one
analytic step of `Winding.exists_box_point`, read there at the `2^m` vertices of the box.) -/
theorem exists_int_vector_of_forall_neg {ι κ : Type*} [Fintype ι] [Finite κ] (ℓ : κ → (ι → ℝ) →ₗ[ℝ] ℝ) {c : ι → ℝ}
    (h : ∀ k, ℓ k c < 0) : ∃ N : ι → ℤ, ∀ k, ℓ k (fun i => (N i : ℝ)) < 0 := by
  sorry

/-- **NF4-S6, finite form (FS73-T22 ⟹ past the winding).** A winding is the relation form of a point of the box: some
`x ∈ [1/3, 2/3]^m` has `Σ_j r_j x_j = W r` for every relation `r`. -/
theorem _root_.HadwigerNelson.ThreeColour.Winding.exists_box_point {s : Fin m → A} (W : Winding s) :
    ∃ x : Fin m → ℝ, (∀ j, x j ∈ Set.Icc (1 / 3 : ℝ) (2 / 3)) ∧
      ∀ r : (relMap s).ker, ∑ j, (((r : Fin m → ℤ) j : ℤ) : ℝ) * x j = ((W.toHom r : ℤ) : ℝ) := by
  sorry

/-- **Values on generators that are integral on relations are a character.** If `Σ_j r_j x_j ∈ ℤ` for every relation `r`
of `s`, some character of `A` takes the value `x j mod 1` at `s j`. (On the subgroup `s` generates by the first
isomorphism theorem; extended to `A` because `ℝ/ℤ` is divisible.) -/
theorem exists_character_of_box_point (s : Fin m → A) {x : Fin m → ℝ}
    (hx : ∀ r : (relMap s).ker, ∃ n : ℤ, ∑ j, (((r : Fin m → ℤ) j : ℤ) : ℝ) * x j = (n : ℝ)) :
    ∃ θ : A →+ UnitAddCircle, ∀ j, θ (s j) = ((x j : ℝ) : UnitAddCircle) := by
  sorry

/-- **The criterion's ⟹, finitely many generators, character form**: a colouring proper along `s` gives a character of
`A` with every `θ (s j)` in the band `[1/3, 2/3]`. -/
theorem exists_character_of_properAlong (s : Fin m → A) {c : A → ZMod 3} (hc : ProperAlong s c) :
    ∃ θ : A →+ UnitAddCircle, ∀ j, θ (s j) ∈ band 3 := by
  sorry

/-! ## §2 All generators at once: compactness of the character group -/

/-- The band `[1/k, 1 − 1/k]` is closed in `ℝ/ℤ` (a compact interval's image). -/
theorem isClosed_band (k : ℕ) : IsClosed (band k) := by
  sorry

/-- **Compactness, character form** (de Bruijn–Erdős for band sets): for a closed band `B`, if every finite subset of `U`
has a character of `M` with values in `B` on it, so has `U`. -/
theorem bandSet_nonempty_of_finite {M : Type*} [AddCommGroup M] (U : Set M) {B : Set UnitAddCircle} (hB : IsClosed B)
    (h : ∀ S : Finset M, (S : Set M) ⊆ U → (bandSet (S : Set M) B).Nonempty) : (bandSet U B).Nonempty := by
  sorry

/-- **NF4-S6 for a group**: a colouring `c : A → ZMod 3` that changes along every step in `U` gives a character of `A`
with `θ(U) ⊆ [1/3, 2/3]`. -/
theorem bandSet_three_nonempty_of_proper {U : Set A} {c : A → ZMod 3} (hc : ∀ a, ∀ u ∈ U, c (a + u) ≠ c a) :
    (bandSet U (band 3)).Nonempty := by
  sorry

/-! ## §3 The plane over a subfield of `ℝ` -/

/-- **NF4-S6 (FS81-T2: `χ(F²) ≤ 3 ⟹ Θ₃(F) ≠ ∅`), every subfield `F ⊆ ℝ`.** A proper 3-colouring of the unit-distance
graph on `F²` gives a character of `ℤ[U_F]` with values in `[1/3, 2/3]` on every unit vector of `F²`. -/
theorem fieldBandSet_three_nonempty_of_colorable (F : Subfield ℝ)
    (h : ((unitDistance ℂ).induce (planeOver F)).Colorable 3) : (fieldBandSet F (band 3)).Nonempty := by
  sorry

/-! ## Spec -/

/-- The model: `ℤ` along `(1, 2)` with `x ↦ x mod 3` — the conclusion of `exists_character_of_properAlong` there. -/
theorem exists_character_one_two : ∃ θ : ℤ →+ UnitAddCircle, ∀ j, θ (![(1 : ℤ), 2] j) ∈ band 3 :=
  exists_character_of_properAlong _ properAlong_one_two

-- The band at 3 holds `1/3`, `1/2` and `2/3`, and not `0`.
example : ((1 / 3 : ℝ) : UnitAddCircle) ∈ band 3 := ⟨1 / 3, ⟨by norm_num, by norm_num⟩, rfl⟩
example : ((1 / 2 : ℝ) : UnitAddCircle) ∈ band 3 := ⟨1 / 2, ⟨by norm_num, by norm_num⟩, rfl⟩

end HadwigerNelson.ThreeColourCharacter

import Proofs.HadwigerNelson.CayleyThree.Density
/-!
FS131-ICT3 — models, checked by the kernel outside the library, for two head statements whose every hypothesis the modules'
own models do not meet at once (LEAN.md § The gate: "the inhabitant satisfies every hypothesis the theorem does not refute, at
once"):
* `exists_isPeriodic_eqOn_of_fg_torsionFree` — row 79's class at `ℤ` with `S = {−2, −1, 1, 2}` (finite, symmetric, generating,
  without `0`), a 3-colouring `x ↦ x mod 3` of it, and the theorem applied there;
* `exists_affine_of_forall_three_nsmul` — at `ℤ` along `(1, 2)` with `x ↦ x mod 3`: generation, properness, and every band
  character of `{1, 2}` of order 3 (`θ(1) = t`, `θ(2) = 2t`, both in `[1/3, 2/3]`, force `t ∈ {1/3, 2/3}`); and the theorem
  applied there.
Run from the worktree's root: `lake env lean data/fs131/ict3/lean/Models.lean`; it must elaborate with no error.
-/
set_option autoImplicit false
set_option relaxedAutoImplicit false

namespace FS131ICT3Models

open HadwigerNelson HadwigerNelson.CayleyThree HadwigerNelson.ThreeColour HadwigerNelson.CharacterColouring
  HadwigerNelson.ThreeColourCharacter SimpleGraph

/-- The symmetric step set `{−2, −1, 1, 2}` of `ℤ`. -/
def S4 : Set ℤ := {-2, -1, 1, 2}

theorem S4_finite : S4.Finite := by unfold S4; exact Set.toFinite _

theorem S4_neg : -S4 = S4 := by
  ext x; simp only [S4, Set.mem_neg, Set.mem_insert_iff, Set.mem_singleton_iff]; omega

theorem S4_zero : (0 : ℤ) ∉ S4 := by simp [S4]

theorem S4_gen : AddSubgroup.closure S4 = ⊤ := by
  rw [eq_top_iff]
  intro x _
  have h1 : (1 : ℤ) ∈ AddSubgroup.closure S4 := AddSubgroup.subset_closure (by simp [S4])
  have := AddSubgroup.zsmul_mem _ h1 x
  simpa using this

/-- `x ↦ x mod 3` colours `addCayley S4`. -/
def colS4 : (addCayley S4).Coloring (Fin 3) :=
  HadwigerNelson.addCayleyColoring (fun x : ℤ => ((x : ZMod 3) : Fin 3)) fun d hd x => by
    simp only [S4, Set.mem_insert_iff, Set.mem_singleton_iff] at hd
    change ((x + d : ℤ) : ZMod 3) ≠ (x : ZMod 3)
    push_cast
    intro h
    have h' : ((d : ℤ) : ZMod 3) = 0 := by linear_combination h
    rcases hd with rfl | rfl | rfl | rfl <;> revert h' <;> decide

-- Row 79's class is inhabited, and the theorem applies there.
example : ∃ C' : (addCayley S4).Coloring (Fin 3), IsPeriodic C' ∧ Set.EqOn (⇑C') (⇑colS4) ({0, 1, 2} : Finset ℤ) :=
  exists_isPeriodic_eqOn_of_fg_torsionFree S4_finite S4_neg S4_gen S4_zero colS4 _

/-- Along `(1, 2)` on `ℤ` every band character has order 3. -/
theorem three_nsmul_of_mem_bandSet_one_two :
    ∀ θ ∈ bandSet (Set.range ![(1 : ℤ), 2]) (band 3), 3 • θ = 0 := by
  intro θ hθ
  obtain ⟨a, ⟨ha1, ha2⟩, hθa⟩ := hθ (![(1 : ℤ), 2] 0) ⟨0, rfl⟩
  obtain ⟨b, ⟨hb1, hb2⟩, hθb⟩ := hθ (![(1 : ℤ), 2] 1) ⟨1, rfl⟩
  simp only [Matrix.cons_val_zero, Matrix.cons_val_one, Nat.cast_ofNat] at hθa hθb ha1 ha2 hb1 hb2
  -- `θ 2 = 2 θ 1`
  have h2 : θ 2 = 2 • θ 1 := by rw [← map_nsmul]; rfl
  have hcoe : (((2 * a - b : ℝ)) : UnitAddCircle) = 0 := by
    rw [AddCircle.coe_sub, hθb, h2, ← hθa]
    simp only [two_mul, AddCircle.coe_add, two_nsmul, sub_self]
  obtain ⟨n, hn⟩ := (AddCircle.coe_eq_zero_iff 1).mp hcoe
  rw [zsmul_eq_mul, mul_one] at hn
  have hn0 : (0 : ℝ) ≤ n := by rw [hn]; linarith
  have hn1 : (n : ℝ) ≤ 1 := by rw [hn]; linarith
  have hn0' : 0 ≤ n := by exact_mod_cast hn0
  have hn1' : n ≤ 1 := by exact_mod_cast hn1
  -- so `3a ∈ {1, 2}`, and `3 θ 1 = 0`
  have h3a : (((3 * a : ℝ)) : UnitAddCircle) = 0 := by
    rcases (by omega : n = 0 ∨ n = 1) with rfl | rfl
    · have : a = 1 / 3 := by push_cast at hn; linarith
      rw [this, show (3 : ℝ) * (1 / 3) = 1 by norm_num]; exact AddCircle.coe_period (p := (1 : ℝ))
    · have : a = 2 / 3 := by push_cast at hn; linarith
      rw [this, show (3 : ℝ) * (2 / 3) = 1 + 1 by norm_num, AddCircle.coe_add, AddCircle.coe_period (p := (1 : ℝ)), add_zero]
  refine AddMonoidHom.ext_int ?_
  rw [AddMonoidHom.smul_apply, ← hθa, AddMonoidHom.zero_apply, ← h3a, ← AddCircle.coe_nsmul, nsmul_eq_mul]
  norm_num

-- The rigidity clause's hypotheses hold at once at `ℤ` along `(1, 2)`, and the theorem applies there.
example : ∃ φ : ℤ →+ ZMod 3, ∀ x : ℤ, ((x : ZMod 3)) = ((0 : ℤ) : ZMod 3) + φ x :=
  exists_affine_of_forall_three_nsmul ((surjective_relMap_iff _).mpr (by
      rw [eq_top_iff]
      intro x _
      have h1 : (1 : ℤ) ∈ AddSubgroup.closure (Set.range ![(1 : ℤ), 2]) := AddSubgroup.subset_closure ⟨0, rfl⟩
      simpa using AddSubgroup.zsmul_mem _ h1 x))
    properAlong_one_two three_nsmul_of_mem_bandSet_one_two

end FS131ICT3Models

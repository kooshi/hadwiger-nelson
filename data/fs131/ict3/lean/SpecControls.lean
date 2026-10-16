import Proofs.HadwigerNelson.CayleyThree.Density
/-!
FS131-ICT3 — the spec examples' negative controls. For each of the five definitions given a spec example
(`circularColoring`, `tightSet`, `fibre`, `Winding.flip`, `coloringOneTwo`), a drifted copy of the definition, and a proof
by the kernel that the example's statement, read at the drifted copy, is **false**. So each example would fail if its
definition drifted that way (the examples themselves are in the modules' spec sections and pass at the real definitions).
Run from the worktree's root: `lake env lean data/fs131/ict3/lean/SpecControls.lean`; every `example` here must elaborate.
-/
set_option autoImplicit false
set_option relaxedAutoImplicit false

namespace FS131ICT3Controls

open HadwigerNelson HadwigerNelson.CayleyThree HadwigerNelson.ThreeColour HadwigerNelson.CharacterColouring
  HadwigerNelson.ThreeColourCharacter SimpleGraph

/-- The character `x ↦ x/3` of `ℤ` (the example's). -/
noncomputable def θ₃ : ℤ →+ UnitAddCircle := mk1.comp ((AddMonoidHom.mulLeft (1 / 3 : ℝ)).comp (Int.castAddHom ℝ))

theorem hθ₃ : θ₃ ∈ bandSet ({1} : Set ℤ) (band 3) := fun u hu => by
  rw [Set.mem_singleton_iff] at hu
  subst hu
  exact ⟨1 / 3, ⟨by norm_num, by norm_num⟩, by simp [θ₃]⟩

/-- Drift 1: the circular colouring shifted by one step (still a colouring). -/
noncomputable def circularColoringD : (addCayley ({1} : Set ℤ)).Coloring (Fin 3) :=
  addCayleyColoring (fun x => circular θ₃ (x + 1)) fun u hu x => by
    rw [add_right_comm]; exact circular_add_ne θ₃ (hθ₃ u hu) (x + 1)

-- The example's statement `… 2 = 2` is false at the drift: the shifted colour at `2` is `⌊3·{1}⌋ = 0`.
example : circularColoringD 2 ≠ 2 := by
  have h : θ₃ (2 + 1) = ((0 : ℝ) : UnitAddCircle) := by
    simp only [θ₃, AddMonoidHom.coe_comp, Function.comp_apply, Int.coe_castAddHom, AddMonoidHom.coe_mulLeft]
    norm_num
  change ((⌊3 * rep01 (θ₃ (2 + 1))⌋ : ℤ) : ZMod 3) ≠ 2
  rw [h, rep01_coe ⟨le_refl _, by norm_num⟩, mul_zero, Int.floor_zero]
  decide

/-- Drift 2: the tight set with the tightness dropped (every direction some relation moves). -/
def tightSetD {A : Type*} [AddCommGroup A] {m : ℕ} {s : Fin m → A} (_W : Winding s) : Set (Fin m) :=
  {j | ∃ σ : (relMap s).ker, (σ : Fin m → ℤ) j ≠ 0}

-- The example's statement `… = ∅` along `(1, 1)` is false at the drift: `(1, −1)` moves direction `0`.
example : tightSetD (heightWinding (s := ![(1 : ℤ), 1]) (c := fun x => (x : ZMod 3))
    (fun a j => by fin_cases j <;> simp)) ≠ ∅ :=
  Set.nonempty_iff_ne_empty.mp ⟨0, ⟨![1, -1], by decide⟩, by decide⟩

/-- Drift 3: the fibre with the relation constraint dropped (the whole box). -/
def fibreD {A : Type*} [AddCommGroup A] {m : ℕ} {s : Fin m → A} (_W : Winding s) : Set (Fin m → ℝ) :=
  {x | ∀ j, x j ∈ Set.Icc (1 / 3 : ℝ) (2 / 3)}

-- The example's statement `… = {(1/3, 2/3)}` is false at the drift: `(1/2, 1/2)` is in the box.
example : fibreD (heightWinding properAlong_one_two) ≠ {![1 / 3, 2 / 3]} := by
  intro h
  have hm : (fun _ => (1 / 2 : ℝ)) ∈ fibreD (heightWinding properAlong_one_two) :=
    fun j => ⟨by norm_num, by norm_num⟩
  rw [h, Set.mem_singleton_iff] at hm
  have := congrFun hm 0
  norm_num at this

/-- Drift 4a: the reversal with the winding's sign changed, `r ↦ Σ_j r_j + W r` (as a function on relations). -/
def flipD {A : Type*} [AddCommGroup A] {m : ℕ} {s : Fin m → A} (f : (relMap s).ker → ℤ) : (relMap s).ker → ℤ :=
  fun r => ∑ j, (r : Fin m → ℤ) j + f r

/-- Drift 4b: the reversal as the negated winding, `r ↦ −W r`. -/
def flipN {A : Type*} [AddCommGroup A] {m : ℕ} {s : Fin m → A} (f : (relMap s).ker → ℤ) : (relMap s).ker → ℤ :=
  fun r => -f r

-- The example's statement `flip … = 1 ∧ flip (flip …) = 0` is false at both drifts: `1 + 0 = 1` but `1 + 1 = 2`;
-- and `−0 = 0 ≠ 1`.
example : ¬ (flipD (heightWinding properAlong_one_two).toHom ⟨![2, -1], by decide⟩ = 1 ∧
    flipD (flipD (heightWinding properAlong_one_two).toHom) ⟨![2, -1], by decide⟩ = 0) := by
  simp only [flipD, heightWinding_apply]
  decide

example : ¬ (flipN (heightWinding properAlong_one_two).toHom ⟨![2, -1], by decide⟩ = 1 ∧
    flipN (flipN (heightWinding properAlong_one_two).toHom) ⟨![2, -1], by decide⟩ = 0) := by
  simp only [flipN, heightWinding_apply]
  decide

/-- Drift 5: the colouring `x ↦ (x + 1) mod 3` (still proper along `{1, 2}`; only its table matters here). -/
def coloringD (x : ℤ) : Fin 3 := (((x + 1 : ℤ) : ZMod 3) : Fin 3)

-- The example's statement `5 ↦ 2, −1 ↦ 2, 3 ↦ 0` is false at the drift.
example : ¬ (coloringD 5 = 2 ∧ coloringD (-1) = 2 ∧ coloringD 3 = 0) := by decide

end FS131ICT3Controls

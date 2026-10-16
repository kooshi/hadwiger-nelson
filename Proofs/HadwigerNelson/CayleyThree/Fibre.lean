import Proofs.HadwigerNelson.CayleyThree.Circular
import Mathlib.Order.WellQuasiOrder

/-!
# Three colours on abelian Cayley graphs: heights, the fibre, tight relations (FS-131, planner FS131-KTC1; skeleton)

The layer FS73-T21/T23 and Coxeter's H-ii stand on, in the library's normalization: a colouring `c : A → ZMod 3` proper
along a family `s : Fin m → A` (`ThreeColour.ProperAlong`), steps lifted to `{1, 2}` (`ThreeColour.step`), the winding
`W : Winding s` on the relation lattice `R = ker (relMap s)`, and its **fibre** — the points `x ∈ [1/3, 2/3]^m` with
`r · x = W r` on `R` (nonempty: the held `Winding.exists_box_point`).

* §1 the height on `ℤ^m` (`liftHeight`, steps in `{1, 2}`; `pmHeight = 3Σx − 2·liftHeight`, steps `±1`) and the colouring's
  own winding `heightWinding`;
* §2 **tight relations** (`minRise σ = 3·W σ`) freeze every step along their directions (H-ii's combinatorial half);
* §3 **Dickson in place of LP duality**: with no tight relation through a direction, the slack is uniformly positive
  (`exists_slack_bound`), so some fibre point is strictly inside the box there (`exists_mem_fibre_gt`, `_lt`);
* §4 a **rational fibre point strict off the tight directions** (`exists_rat_mem_fibre_relint`), the slope H-iii uses;
* §5 the rigidity clause of row 79: if every band character has order 3, every colouring is affine.

**Not claimed:** the dichotomy's cell clause (`plans/FS131-KTC1-three-colour-plan.md` § 2.5); anything at four colours.
**Inhabitants:** `ThreeColour.properAlong_one_two` (`ℤ` along `(1, 2)`, `x ↦ x mod 3`) for every theorem taking `ProperAlong`;
`ThreeColour.nonempty_winding_one_two` for every theorem taking a `Winding`; `isTight_one_two` for `IsTight`.
-/

namespace HadwigerNelson.CayleyThree

open HadwigerNelson.ThreeColour HadwigerNelson.CharacterColouring HadwigerNelson.ThreeColourCharacter

variable {A : Type*} [AddCommGroup A] {m : ℕ}

/-! ## §1 The height on `ℤ^m` -/

/-- The `ℓ¹` norm on `ℤ^m`, the graph distance of the grid. -/
def l1 (v : Fin m → ℤ) : ℤ := ∑ j, |v j|

section Height

variable (s : Fin m → A) (c : A → ZMod 3)

/-- **The height on `ℤ^m`** (steps in `{1, 2}`): up the positive part of `x` from `0`, then down its negative part to
`π x`. -/
def liftHeight (x : Fin m → ℤ) : ℤ :=
  height s c 0 (word (posPart x)) - height s c (relMap s x) (word (negPart x))

/-- **The `±1` height**: `3·Σ_j x_j − 2·liftHeight x`; a step lifted to `1` is `+1`, to `2` is `−1`. -/
def pmHeight (x : Fin m → ℤ) : ℤ := 3 * ∑ j, x j - 2 * liftHeight s c x

variable {s c}

theorem liftHeight_add_single (hc : ProperAlong s c) (x : Fin m → ℤ) (j : Fin m) :
    liftHeight s c (x + Pi.single j 1) = liftHeight s c x + step s c (relMap s x) j := by
  sorry

theorem liftHeight_cast (hc : ProperAlong s c) (x : Fin m → ℤ) :
    ((liftHeight s c x : ℤ) : ZMod 3) = c (relMap s x) - c 0 := by
  sorry

theorem pmHeight_add_single (hc : ProperAlong s c) (x : Fin m → ℤ) (j : Fin m) :
    pmHeight s c (x + Pi.single j 1) = pmHeight s c x + (3 - 2 * step s c (relMap s x) j) := by
  sorry

theorem pmHeight_cast (hc : ProperAlong s c) (x : Fin m → ℤ) :
    ((pmHeight s c x : ℤ) : ZMod 3) = c (relMap s x) - c 0 := by
  sorry

/-- The `±1` height is `1`-Lipschitz for the grid distance. -/
theorem abs_pmHeight_sub_le (hc : ProperAlong s c) (x y : Fin m → ℤ) :
    |pmHeight s c x - pmHeight s c y| ≤ l1 (x - y) := by
  sorry

/-- The `±1` height has the parity of `Σ_j x_j`. -/
theorem even_pmHeight_sub_sum (hc : ProperAlong s c) (x : Fin m → ℤ) : Even (pmHeight s c x - ∑ j, x j) := by
  sorry

/-- **The colouring's own winding** (FS73-T21's `w`, the library's `W`): `W r = liftHeight r / 3` on the relation lattice. -/
noncomputable def heightWinding (hc : ProperAlong s c) : Winding s where
  toHom :=
    { toFun := fun r => liftHeight s c (r : Fin m → ℤ) / 3
      map_zero' := by sorry
      map_add' := by sorry }
  minRise_le := by sorry

theorem heightWinding_apply (hc : ProperAlong s c) (r : (relMap s).ker) :
    (heightWinding hc).toHom r = liftHeight s c (r : Fin m → ℤ) / 3 := rfl

/-- **The winding is global** (FS73-T21, Lemma 2): `liftHeight (x + r) = liftHeight x + 3·W r` for every relation `r`. -/
theorem liftHeight_add_ker (hc : ProperAlong s c) (x : Fin m → ℤ) (r : (relMap s).ker) :
    liftHeight s c (x + r) = liftHeight s c x + 3 * (heightWinding hc).toHom r := by
  sorry

/-- **The `±1` height's winding**: `pmHeight (x + r) = pmHeight x + (3·Σ_j r_j − 6·W r)` — the seam between the
library's normalization (steps in `{1, 2}`, the fibre in `[1/3, 2/3]^m`) and the McShane extension's (steps `±1`,
slopes `a = 3 − 6x` in `[−1, 1]^m`). -/
theorem pmHeight_add_ker (hc : ProperAlong s c) (x : Fin m → ℤ) (r : (relMap s).ker) :
    pmHeight s c (x + r) = pmHeight s c x + (3 * ∑ j, (r : Fin m → ℤ) j - 6 * (heightWinding hc).toHom r) := by
  sorry

end Height

/-! ## §2 Tight relations freeze their directions -/

/-- **Generation, in the family's words**: the relation map is onto iff the family generates `A`. -/
theorem surjective_relMap_iff (s : Fin m → A) :
    Function.Surjective (relMap s) ↔ AddSubgroup.closure (Set.range s) = ⊤ := by
  sorry


/-- **A tight relation** for a winding: the least rise is attained, `minRise σ = 3·W σ`. -/
def IsTight {s : Fin m → A} (W : Winding s) (σ : (relMap s).ker) : Prop := minRise (σ : Fin m → ℤ) = 3 * W.toHom σ

/-- **The tight directions** of a winding: those some tight relation moves. -/
def tightSet {s : Fin m → A} (W : Winding s) : Set (Fin m) := {j | ∃ σ : (relMap s).ker, (σ : Fin m → ℤ) j ≠ 0 ∧ IsTight W σ}

/-- **The fibre of a winding**: the points of the box `[1/3, 2/3]^m` realizing it on every relation. -/
def fibre {s : Fin m → A} (W : Winding s) : Set (Fin m → ℝ) :=
  {x | (∀ j, x j ∈ Set.Icc (1 / 3 : ℝ) (2 / 3)) ∧ ∀ r : (relMap s).ker, ∑ j, (((r : Fin m → ℤ) j : ℤ) : ℝ) * x j = W.toHom r}

theorem fibre_nonempty {s : Fin m → A} (W : Winding s) : (fibre W).Nonempty := by
  sorry

theorem convex_fibre {s : Fin m → A} (W : Winding s) : Convex ℝ (fibre W) := by
  sorry

/-- **H-ii, the combinatorial half (positive side)**: along a tight relation of the colouring's winding, every step in a
direction the relation moves forward is lifted to `1`, from every base point. Generation moves the base point. -/
theorem step_eq_one_of_isTight {s : Fin m → A} {c : A → ZMod 3} (hc : ProperAlong s c)
    (hgen : Function.Surjective (relMap s)) {σ : (relMap s).ker} (hσ : IsTight (heightWinding hc) σ) {j : Fin m}
    (hj : 0 < (σ : Fin m → ℤ) j) (a : A) : step s c a j = 1 := by
  sorry

/-- **H-ii, the combinatorial half (negative side).** -/
theorem step_eq_two_of_isTight {s : Fin m → A} {c : A → ZMod 3} (hc : ProperAlong s c)
    (hgen : Function.Surjective (relMap s)) {σ : (relMap s).ker} (hσ : IsTight (heightWinding hc) σ) {j : Fin m}
    (hj : (σ : Fin m → ℤ) j < 0) (a : A) : step s c a j = 2 := by
  sorry

/-- A tight relation pins the fibre: `x_j = 1/3` where it moves forward, `2/3` where it moves back. -/
theorem fibre_coord_of_isTight {s : Fin m → A} {W : Winding s} {σ : (relMap s).ker} (hσ : IsTight W σ) {x : Fin m → ℝ}
    (hx : x ∈ fibre W) (j : Fin m) :
    (0 < (σ : Fin m → ℤ) j → x j = 1 / 3) ∧ ((σ : Fin m → ℤ) j < 0 → x j = 2 / 3) := by
  sorry

/-! ## §3 Dickson in place of LP duality -/

/-- **A Gordan bound by Dickson's lemma.** On a set `M ⊆ ℕ^ι` closed under sums and under differences of comparable
elements, two functions additive on `M` with `g x = 0 → t x = 0` satisfy `t ≤ κ·g` for one `κ`. (The minimal nonzero
elements of `M` are an antichain, finite by `WellQuasiOrderedLE.finite_of_isAntichain`; `κ` is the largest `t` among them.) -/
theorem exists_le_mul_of_imp_eq_zero {ι : Type*} [Finite ι] (M : Set (ι → ℕ))
    (hadd : ∀ x ∈ M, ∀ y ∈ M, x + y ∈ M) (hsub : ∀ x ∈ M, ∀ y ∈ M, y ≤ x → x - y ∈ M) (g t : (ι → ℕ) → ℕ)
    (hg : ∀ x ∈ M, ∀ y ∈ M, g (x + y) = g x + g y) (ht : ∀ x ∈ M, ∀ y ∈ M, t (x + y) = t x + t y)
    (h0 : ∀ x ∈ M, g x = 0 → t x = 0) : ∃ κ : ℕ, ∀ x ∈ M, t x ≤ κ * g x := by
  sorry

/-- **The uniform slack**: with no tight relation moving `j` forward, `σ_j ≤ κ·(3·W σ − minRise σ)` on every relation
moving `j` forward (`exists_le_mul_of_imp_eq_zero` on each orthant of `R`). -/
theorem exists_slack_bound {s : Fin m → A} (W : Winding s) (j : Fin m)
    (hj : ∀ σ : (relMap s).ker, 0 < (σ : Fin m → ℤ) j → ¬ IsTight W σ) :
    ∃ κ : ℕ, 0 < κ ∧ ∀ σ : (relMap s).ker, 0 < (σ : Fin m → ℤ) j →
      (σ : Fin m → ℤ) j ≤ κ * (3 * W.toHom σ - minRise (σ : Fin m → ℤ)) := by
  sorry

/-- **Separation for a general box** (the held `Winding.exists_box_point`'s real-linear half, for `∏_j [lo_j, hi_j]`): if
every integer combination of the equations is non-negative at some vertex, a point of the box solves them. -/
theorem exists_mem_pi_Icc_of_forall_int {n : ℕ} (lo hi : Fin m → ℝ) (hlh : ∀ j, lo j ≤ hi j) (g : Fin n → Fin m → ℝ)
    (w : Fin n → ℝ)
    (h : ∀ N : Fin n → ℤ, ∃ b : Fin m → Bool,
      0 ≤ ∑ i, (N i : ℝ) * (∑ j, g i j * (if b j then hi j else lo j) - w i)) :
    ∃ x : Fin m → ℝ, (∀ j, x j ∈ Set.Icc (lo j) (hi j)) ∧ ∀ i, ∑ j, g i j * x j = w i := by
  sorry

/-- **Farkas, one side**: with no tight relation moving `j` forward, some fibre point has `x_j > 1/3`. -/
theorem exists_mem_fibre_gt {s : Fin m → A} (W : Winding s) (j : Fin m)
    (hj : ∀ σ : (relMap s).ker, 0 < (σ : Fin m → ℤ) j → ¬ IsTight W σ) : ∃ x ∈ fibre W, 1 / 3 < x j := by
  sorry

/-- **The reversed winding** `r ↦ Σ_j r_j − W r`: the winding of the colouring `−c`. -/
def _root_.HadwigerNelson.ThreeColour.Winding.flip {s : Fin m → A} (W : Winding s) : Winding s where
  toHom :=
    { toFun := fun r => ∑ j, (r : Fin m → ℤ) j - W.toHom r
      map_zero' := by sorry
      map_add' := by sorry }
  minRise_le := by sorry

theorem mem_fibre_flip_iff {s : Fin m → A} (W : Winding s) (x : Fin m → ℝ) :
    x ∈ fibre W.flip ↔ (fun j => 1 - x j) ∈ fibre W := by
  sorry

theorem isTight_flip_iff {s : Fin m → A} (W : Winding s) (σ : (relMap s).ker) : IsTight W.flip σ ↔ IsTight W (-σ) := by
  sorry

/-- **Farkas, the other side**: with no tight relation moving `j` back, some fibre point has `x_j < 2/3`. -/
theorem exists_mem_fibre_lt {s : Fin m → A} (W : Winding s) (j : Fin m)
    (hj : ∀ σ : (relMap s).ker, (σ : Fin m → ℤ) j < 0 → ¬ IsTight W σ) : ∃ x ∈ fibre W, x j < 2 / 3 := by
  sorry

/-! ## §4 The rational slope strict off the tight directions -/

/-- **A rational fibre point in the relative interior** (H-iii's `a*`, as `a* = 3 − 6x`): strict inside the box at every
direction no tight relation moves. Route: average the points of §3 (one per side and direction), then
`exists_rat_solution_near` on the affine hull with the tight coordinates held. -/
theorem exists_rat_mem_fibre_relint {s : Fin m → A} (W : Winding s) :
    ∃ x : Fin m → ℚ, (fun j => (x j : ℝ)) ∈ fibre W ∧ ∀ j ∉ tightSet W, 1 / 3 < x j ∧ x j < 2 / 3 := by
  sorry

/-! ## §5 Rigidity: band characters of order 3 make every colouring affine -/

/-- **FS73-T23, the rigidity clause of row 79**: if every band character has order 3, every 3-colouring proper along a
generating family is affine, `c = c 0 + φ` with `φ : A → ZMod 3` additive. -/
theorem exists_affine_of_forall_three_nsmul {s : Fin m → A} (hgen : Function.Surjective (relMap s)) {c : A → ZMod 3}
    (hc : ProperAlong s c) (h3 : ∀ θ ∈ bandSet (Set.range s) (band 3), 3 • θ = 0) :
    ∃ φ : A →+ ZMod 3, ∀ x, c x = c 0 + φ x := by
  sorry

/-! ## Spec: the model `ℤ` along `(1, 2)`, `x ↦ x mod 3` -/

example : l1 ![(2 : ℤ), -1] = 3 := by decide
example : liftHeight ![(1 : ℤ), 2] (fun x => (x : ZMod 3)) ![2, -1] = 0 := by decide
example : pmHeight ![(1 : ℤ), 2] (fun x => (x : ZMod 3)) ![1, 0] = 1 := by decide
example : pmHeight ![(1 : ℤ), 2] (fun x => (x : ZMod 3)) ![0, 1] = -1 := by decide

/-- The model of `IsTight`: the relation `(2, −1)` of `(1, 2)` is tight for the winding of `x ↦ x mod 3`. -/
theorem isTight_one_two :
    IsTight (heightWinding properAlong_one_two) ⟨![2, -1], by decide⟩ := by
  sorry

end HadwigerNelson.CayleyThree

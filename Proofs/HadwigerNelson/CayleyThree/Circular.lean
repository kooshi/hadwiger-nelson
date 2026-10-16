import Proofs.HadwigerNelson.Arith.ThreeColourCharacter
import Proofs.HadwigerNelson.Kempe
import Proofs.HadwigerNelson.LocalGlobal

/-!
# Three colours on abelian Cayley graphs: the criterion and the periodic form (FS-131, planner FS131-KTC1; skeleton)

**Read aloud, against `LEDGER.md` row 79.** Row 79: *"every Cayley graph of a finitely generated torsion-free abelian group is
3-colourable iff a character puts every generator in `[1/3, 2/3]` … ⟺ it has a periodic (circular) 3-colouring"*, for `S = −S`
finite generating. Here, in this library's words, and in the widest class the proofs read (the coordinator's ruling,
FS-131 inventory item 996):
* `colorable_three_iff_bandSet_nonempty` — for **every** abelian group `A` and **every** `S ⊆ A` with `0 ∉ S`,
  `addCayley S` is 3-colourable iff `bandSet S (band 3)` (the characters `θ : A → ℝ/ℤ` with `θ(S) ⊆ [1/3, 2/3]`) is nonempty.
  The ⟹ is the held `bandSet_three_nonempty_of_proper`; the ⟸ is the circular colouring `x ↦ ⌊3·{θ(x)}⌋`.
* `colorable_three_iff_exists_isPeriodic` — for `A` finitely generated and `S` finite: 3-colourable iff some
  3-colouring has a period group of finite index. No torsion-freeness, no symmetry, no generation.
* `not_isPeriodic_rat`, with `colorable_three_rat` — the control: over `ℚ` with the step `1` the graph is 3-colourable and no
  3-colouring is periodic, so finite generation cannot be dropped.
* `colorable_three_iff_of_fg_torsionFree` — row 79's class, as an instance of the two.

**Not claimed:** anything at `k ≠ 3`; the forms of row 79 over `Hom(Λ, ℝ)` (FS73-T22's, which needs torsion-freeness);
that the widening is new — circular colourings of abelian Cayley graphs are old (FS73-T22's prior-art line; the plan's
§ 3.6 records the question).

**Shared tool.** `exists_rat_solution_near` (a linear system with rational coefficients and a real solution has rational
solutions arbitrarily near it) is used here and by `CayleyThree/Fibre`.
-/

namespace HadwigerNelson.CayleyThree

open HadwigerNelson.ThreeColour HadwigerNelson.CharacterColouring HadwigerNelson.ThreeColourCharacter SimpleGraph

/-! ## §1 Rational points near real solutions of rational linear systems -/

/-- **Rational solutions are dense in the real solutions of a rational linear system**: a system `G y = b` with rational
coefficients and a real solution `x` has a rational solution within `ε` of `x` in every coordinate. (Route: a `ℚ`-basis of
the `ℚ`-span of `1` and the coordinates of `x`; the basis vectors moved to nearby rationals; normalized at `1`.) -/
theorem exists_rat_solution_near {ι κ : Type*} [Fintype ι] [Finite κ] (G : κ → ι → ℚ) (b : κ → ℚ) {x : ι → ℝ}
    (hx : ∀ k, ∑ i, (G k i : ℝ) * x i = b k) {ε : ℝ} (hε : 0 < ε) :
    ∃ q : ι → ℚ, (∀ k, ∑ i, G k i * q i = b k) ∧ ∀ i, |(q i : ℝ) - x i| < ε := by
  sorry

/-! ## §2 The circular colouring of a character -/

variable {A : Type*} [AddCommGroup A] {S : Set A}

/-- The representative in `[0, 1)` of a point of `ℝ/ℤ`. -/
noncomputable def rep01 (t : UnitAddCircle) : ℝ := (AddCircle.equivIco 1 0 t : ℝ)

theorem rep01_mem (t : UnitAddCircle) : rep01 t ∈ Set.Ico (0 : ℝ) 1 := by
  sorry

theorem coe_rep01 (t : UnitAddCircle) : ((rep01 t : ℝ) : UnitAddCircle) = t := by
  sorry

/-- **The circular colouring** of a character `θ`: `x ↦ ⌊3·{θ(x)}⌋ mod 3`. -/
noncomputable def circular (θ : A →+ UnitAddCircle) (x : A) : ZMod 3 := ((⌊3 * rep01 (θ x)⌋ : ℤ) : ZMod 3)

/-- **The circular colouring changes along a band step**: two points of `[0, 1)` in one third differ by less than `1/3`. -/
theorem circular_add_ne (θ : A →+ UnitAddCircle) {u : A} (hu : θ u ∈ band 3) (x : A) :
    circular θ (x + u) ≠ circular θ x := by
  sorry

/-- The circular colouring of a band character, as a colouring of `addCayley S`. -/
noncomputable def circularColoring (θ : A →+ UnitAddCircle) (hθ : θ ∈ bandSet S (band 3)) :
    (addCayley S).Coloring (Fin 3) :=
  addCayleyColoring (circular θ) fun u hu x => circular_add_ne θ (hθ u hu) x

/-- The circular colouring is periodic under the kernel of its character. -/
theorem ker_le_periods_circularColoring (θ : A →+ UnitAddCircle) (hθ : θ ∈ bandSet S (band 3)) :
    θ.ker ≤ periods (circularColoring θ hθ) := by
  sorry

/-- **A colouring changes along every step**: the bridge from `addCayley S` to the held forward half. -/
theorem coloring_add_ne (hS : (0 : A) ∉ S) (C : (addCayley S).Coloring (Fin 3)) (a : A) {u : A} (hu : u ∈ S) :
    (C (a + u) : ZMod 3) ≠ C a := by
  sorry

/-- **The three-colour criterion, character form (FS73-T22), every abelian group and every set of steps.** -/
theorem colorable_three_iff_bandSet_nonempty (hS : (0 : A) ∉ S) :
    (addCayley S).Colorable 3 ↔ (bandSet S (band 3)).Nonempty := by
  sorry

/-! ## §3 The periodic form -/

/-- **A character of finite order has a kernel of finite index**: its range lies in the finite `N`-torsion of `ℝ/ℤ`. -/
theorem finiteIndex_ker_of_nsmul_eq_zero {θ : A →+ UnitAddCircle} {N : ℕ} (hN : N ≠ 0) (h : N • θ = 0) :
    θ.ker.FiniteIndex := by
  sorry

/-- **The band set over finitely many steps of a finitely generated group has a point of finite order** (FS73-T22's
"rational vertex"; `plans/FS131-KTC1-three-colour-plan.md` § 2.1, R2). Route: lift `θ` on a generating family that lists `S`
first, keep the box faces the lift lies on, `exists_rat_solution_near`, then `exists_character_of_box_point`. -/
theorem exists_torsion_mem_bandSet [AddGroup.FG A] (hSfin : S.Finite) (h : (bandSet S (band 3)).Nonempty) :
    ∃ θ ∈ bandSet S (band 3), ∃ N : ℕ, N ≠ 0 ∧ N • θ = 0 := by
  sorry

/-- **The three-colour criterion, periodic form**: a finitely generated abelian group with finitely many steps. (`0 ∈ S` is
harmless here: `addCayley (S \ {0}) = addCayley S`, `SimpleGraph.addCayley_erase_zero`.) -/
theorem colorable_three_iff_exists_isPeriodic [AddGroup.FG A] (hSfin : S.Finite) :
    (addCayley S).Colorable 3 ↔ ∃ C : (addCayley S).Coloring (Fin 3), IsPeriodic C := by
  sorry

/-! ## §4 The control: finite generation is needed -/

/-- Over `ℚ` with the step `1` the Cayley graph is 3-colourable (the character `x ↦ x/2`). -/
theorem colorable_three_rat : (addCayley ({1} : Set ℚ)).Colorable 3 := by
  sorry

/-- **No 3-colouring of `addCayley {1}` over `ℚ` is periodic**: `ℚ` is divisible, so its only subgroup of finite index is
`ℚ` itself, and a colouring with every period is constant. With `colorable_three_rat`, the periodic form fails without
finite generation. -/
theorem not_isPeriodic_rat (C : (addCayley ({1} : Set ℚ)).Coloring (Fin 3)) : ¬ IsPeriodic C := by
  sorry

/-! ## §5 Row 79's class -/

/-- **Row 79, as an instance**: for a finitely generated torsion-free abelian group and a finite symmetric generating set
of steps without `0`, three-colourable ⟺ a character puts every step in `[1/3, 2/3]` ⟺ periodically three-colourable. -/
theorem colorable_three_iff_of_fg_torsionFree [AddGroup.FG A] [_htf : IsAddTorsionFree A] (hSfin : S.Finite) (_hsymm : -S = S)
    (_hgen : AddSubgroup.closure S = ⊤) (hS : (0 : A) ∉ S) :
    ((addCayley S).Colorable 3 ↔ (bandSet S (band 3)).Nonempty) ∧
      ((addCayley S).Colorable 3 ↔ ∃ C : (addCayley S).Coloring (Fin 3), IsPeriodic C) :=
  ⟨colorable_three_iff_bandSet_nonempty hS, colorable_three_iff_exists_isPeriodic hSfin⟩

/-! ## Spec -/

-- `rep01` drifts if its interval moves: `1/2 ↦ 1/2`.
example : rep01 ((1 / 2 : ℝ) : UnitAddCircle) = 1 / 2 := by
  sorry

-- The circular colouring of `x ↦ x/3` on `ℤ` is `x mod 3` at `1`.
example : circular (mk1.comp ((AddMonoidHom.mulLeft (1 / 3 : ℝ)).comp (Int.castAddHom ℝ))) 1 = 1 := by
  sorry

end HadwigerNelson.CayleyThree

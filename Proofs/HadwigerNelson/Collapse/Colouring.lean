import Proofs.HadwigerNelson.Rigidity.APlus

/-!
# Invariant random `k`-colourings of `Cay(ℤ[U_F], U_F)` (FS-131, job FS131-KCL1; module C2)

**Read aloud, against the informal claim** (V1-L0, `plans/FS103-V1-verification.md` l. 90: "If `F²` is `k`-colourable, `[k]^R`
carries an `R ⋊ U`-invariant probability `μ` on proper `k`-colourings of `Cay(R, U)`"). The five-colour chain holds this at
four colours (`SpectralChain.X4`, `InvariantColouring`, `exists_invariantColouring`, `Rigidity.invariantMeasureOnClosed_of_countable`);
this module states it at `k` colours, for the collapse, which reads `k = χ(F²) ≤ 6`.

* `Xk F k` — the proper `k`-colourings of `Cay(R, U)`; closed, measurable, stable under shifts and rotations.
* `InvColouring F k` — a translation- and rotation-invariant random proper `k`-colouring (the law `μ`).
* `xk_nonempty_of_colorable`, `exists_invColouring` — a proper `k`-colouring of `F²` gives one, over a number field.

**Route.** Each statement is its four-colour namesake with `Fin 4` replaced by `Fin k`; the four-colour proofs read no
property of `4` (`Rigidity/InvariantMeasure`: a common fixed point of the shifts on the compact space of probabilities carried by
`Xk`, then of the rotations, which normalise the shifts).

**Models.** Over `ℚ` at `k = 2`: `ℚ²` is two-colourable (the ramified stable prime above `2`), so `InvColouring ⊥ 2` is
inhabited (`nonempty_invColouring_bot`). At `k = 1` the set `Xk` is empty (`Xk_one_eq_empty`): the unit vector `1` is an edge.
-/

namespace HadwigerNelson.Collapse

open SpectralChain MeasureTheory SimpleGraph NumberField

noncomputable section

variable (F : Subfield ℝ) (k : ℕ)

/-- **`X_k(F)`**: the proper `k`-colourings of `Cay(R, U)`, `R = ℤ[U_F]`. -/
def Xk : Set (unitRing F → Fin k) := {c | ∀ x y : unitRing F, (y : ℂ) - x ∈ unitVectors F → c x ≠ c y}

/-- **An invariant random proper `k`-colouring** of `Cay(R, U)`: its law is a probability, carried by `X_k(F)`, invariant
under every translation `c ↦ c(· + y)` and every rotation `c ↦ c(u ·)`. -/
structure InvColouring where
  /-- The law of the random colouring. -/
  μ : Measure (unitRing F → Fin k)
  /-- It is a probability measure. -/
  isProb : IsProbabilityMeasure μ
  /-- It is carried by the proper colourings. -/
  carried : μ (Xk F k)ᶜ = 0
  /-- Invariant under every translation. -/
  shift_inv : ∀ y : unitRing F, μ.map (fun c x => c (x + y)) = μ
  /-- Invariant under every rotation. -/
  rot_inv : ∀ u : unitVectors F, μ.map (fun c x => c (uvRing u * x)) = μ

variable {F k}

/-- A proper `k`-colouring of `F²` restricts to `Cay(R, U)`. -/
theorem xk_nonempty_of_colorable (h : ((unitDistance ℂ).induce (planeOver F)).Colorable k) : (Xk F k).Nonempty := by
  sorry

/-- `X_k(F)` is closed (an intersection of one clopen condition per pair). -/
theorem isClosed_Xk : IsClosed (Xk F k) := by
  sorry

/-- `X_k(F)` is measurable when `R` is countable. -/
theorem measurableSet_Xk [Countable (unitRing F)] : MeasurableSet (Xk F k) := by
  sorry

/-- `X_k(F)` is stable under the translations. -/
theorem shift_mem_Xk (y : unitRing F) (c : unitRing F → Fin k) (hc : c ∈ Xk F k) : (fun x => c (x + y)) ∈ Xk F k :=
  fun x' y' h => hc (x' + y) (y' + y) (by
    have e : ((y' + y : unitRing F) : ℂ) - ((x' + y : unitRing F) : ℂ) = (y' : ℂ) - x' := by push_cast; ring
    rw [e]; exact h)

/-- `X_k(F)` is stable under the rotations. -/
theorem rot_mem_Xk (u : unitVectors F) (c : unitRing F → Fin k) (hc : c ∈ Xk F k) :
    (fun x => c (uvRing u * x)) ∈ Xk F k := by
  sorry

/-- **An invariant colouring exists** over a number field as soon as `X_k(F)` is not empty (V1-L0; the four-colour
`exists_invariantColouring` with `invariantMeasureOnClosed_of_countable`, at `Fin k`). -/
theorem exists_invColouring [NumberField F] (h : (Xk F k).Nonempty) : Nonempty (InvColouring F k) := by
  sorry

/-- **A proper `k`-colouring of `F²` gives an invariant one** of `Cay(R, U)`. -/
theorem nonempty_invColouring_of_colorable [NumberField F]
    (h : ((unitDistance ℂ).induce (planeOver F)).Colorable k) : Nonempty (InvColouring F k) :=
  exists_invColouring (xk_nonempty_of_colorable h)

/-! ## Models -/

/-- **The model**: over `ℚ`, an invariant random two-colouring (`ℚ²` is two-colourable at its ramified stable prime above
`2`). -/
theorem nonempty_invColouring_bot : Nonempty (InvColouring (⊥ : Subfield ℝ) 2) := by
  haveI := Rigidity.numberField_bot
  obtain ⟨P, -, hram⟩ := UpperHalf.exists_stablePrime_rat
  exact nonempty_invColouring_of_colorable (UpperHalf.colorable_two_planeOver_of_ramified P hram)

/-- **The adversary**: no proper one-colouring of `Cay(R, U)` (the pair `0, 1` is an edge). -/
theorem Xk_one_eq_empty : Xk F 1 = ∅ := by
  sorry

/-! ## Spec -/

-- a one-colouring is never proper: `Xk` would drift if properness were dropped.
example : Xk F 1 = ∅ := Xk_one_eq_empty

end

end HadwigerNelson.Collapse

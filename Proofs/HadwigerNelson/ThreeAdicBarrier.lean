import Proofs.HadwigerNelson.ResidueColouring

/-!
# The 3-adic barrier: 3-integral unit-distance graphs over `ℚ(√d)`, `d ≡ 2 (mod 3)`, are 3-colourable

FS-58 (`plans/FS58-four-colours.md` §2 D1; found in `plans/FS58-prelude-seven-cycle-gadget.md` §4 for `d = 167`).

When `d ≡ 2 (mod 3)` the prime 3 is inert in `ℚ(√d)`, and reduction sends `ℤ₍₃₎[√d]` onto `𝔽₉ = 𝔽₃[t]/(t² + 1)`
with `√d ↦ t`, because `d ≡ −1 (mod 3)`. A unit vector whose coordinates have denominator prime to 3 reduces to a
point of the circle `x² + y² = 1` of `𝔽₉²`, which has eight points, and the linear rule
`κ(x₀ + x₁t, y₀ + y₁t) = x₀ + x₁ + y₀` is nonzero on all eight. So `κ ∘ reduction` is an additive map, nonzero on
every 3-integral unit vector, and Theorem A (`colorable_of_residue`) three-colours every unit-distance graph whose
edge vectors are 3-integral — at every size, with no solver.

The consequence FS-58 uses: a four-chromatic unit-distance graph over such a field needs an edge whose direction has
3 in its denominator.

SKELETON (WORKFLOW step 3): statements only; every `sorry` is a tracked leaf of FS-58 phase D.
-/

namespace HadwigerNelson.ThreeAdicBarrier

/-- The point `((a + b√d)/m, (c + e√d)/m)` of the plane, as a complex number. -/
noncomputable def point (d : ℕ) (a b c e m : ℤ) : ℂ :=
  ⟨(a + b * Real.sqrt d) / m, (c + e * Real.sqrt d) / m⟩

/-- **The 3-integral vectors of the plane over `ℚ(√d)`**: both coordinates have a denominator prime to 3. -/
def threeIntegral (d : ℕ) : AddSubgroup ℂ where
  carrier := {z | ∃ a b c e m : ℤ, ¬ (3 : ℤ) ∣ m ∧ z = point d a b c e m}
  add_mem' := sorry
  zero_mem' := sorry
  neg_mem' := sorry

/-- **The linear rule** `(a + b + c)·m⁻¹ (mod 3)` on the 3-integral vectors. Well defined because `√d` is
irrational when `d ≡ 2 (mod 3)` (no square is), so the representation is unique up to scaling by an integer prime
to 3. -/
noncomputable def kappa (d : ℕ) (hd : d % 3 = 2) : threeIntegral d →+ ZMod 3 := sorry

/-- The rule, on a representation. -/
theorem kappa_point {d : ℕ} (hd : d % 3 = 2) {a b c e m : ℤ} (hm : ¬ (3 : ℤ) ∣ m) :
    kappa d hd ⟨point d a b c e m, ⟨a, b, c, e, m, hm, rfl⟩⟩ = (a + b + c) * ((m : ZMod 3))⁻¹ := sorry

/-- **The rule never vanishes on a 3-integral unit vector** — the eight-point circle of `𝔽₉²`. -/
theorem kappa_ne_zero {d : ℕ} (hd : d % 3 = 2) {z : threeIntegral d} (hz : ‖(z : ℂ)‖ = 1) :
    kappa d hd z ≠ 0 := sorry

/-- **The 3-adic barrier.** Every unit-distance graph over `ℚ(√d)`, `d ≡ 2 (mod 3)`, whose edge vectors are
3-integral is 3-colourable. -/
theorem colorable_three_of_threeIntegral {d : ℕ} (hd : d % 3 = 2) {S : Set ℂ}
    (hS : ∀ z ∈ S, ∀ w ∈ S, dist z w = 1 → z - w ∈ threeIntegral d) :
    ((unitDistance ℂ).induce S).Colorable 3 := sorry

/-- A 3-integral unit vector of `ℚ(√167)` outside `ℚ(i)`: a diamond side of the prelude's seven-cycle,
`((−15 − 7√167)/140, (105 − √167)/140)`. The model of `hS`'s edges: the barrier's hypothesis is met by real edges. -/
theorem norm_point_167_diamond : ‖point 167 (-15) (-7) 105 (-1) 140‖ = 1 := sorry

/-- **The inhabitant**: the whole 3-integral plane over `ℚ(√167)` is 3-colourable, and it has edges
(`norm_point_167_diamond`). -/
theorem colorable_three_threeIntegral_167 :
    ((unitDistance ℂ).induce (threeIntegral 167 : Set ℂ)).Colorable 3 := sorry

end HadwigerNelson.ThreeAdicBarrier

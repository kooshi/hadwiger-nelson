import Proofs.HadwigerNelson.Instances.SqrtEleven

/-!
# The field `ℤ[√3, √5]` inside the coordinate tower, for FS-70's kernel form (the subring; no theorem about colours)

FS-70 (`plans/FS70-five-over-sqrt3-sqrt5.md`; closed 2026-09-22 as a typed null — `LEDGER.md` row 76) aimed at
`χ(ℚ(√3,√5)²) ≥ 5` from a finite unit-distance graph with no Moser spindle. No such graph was found; every lattice the milestone
built but one is four-colourable by a periodic colouring (a theorem, rows 56 and 66 with FS-70's screens), and the last one's
four-colourability is undecided (`plans/STUB-last-lattice.md`). **This module keeps the infrastructure the kernel form would rest
on, and nothing that asserts a chromatic number:**

* `Q4.threeFive`, the elements of the tower `Q4 = Adjoin 11 (Adjoin 7 (Adjoin 5 (Adjoin 3 ℤ)))` whose `√11`- and `√7`-parts
  vanish — `ℤ[√3, √5]` — as a `Subring` with decidable membership, so `UDCert.CoordsIn Q4.threeFive` decides;
* `Q4.eval_mem_of_mem_threeFive`: such an element evaluates into every real field holding `√3` and `√5`;
* `sqrt_three_mem_fieldOfRadicands_three_five`, `sqrt_five_mem_fieldOfRadicands_three_five`.

The consumer is `UDCert.chromaticNumber_le_planeOver` (`Instances/SqrtEleven.lean`), already generic in the subring: a certificate
`witness : UDCert n` with a kernel-replayed four-refusal (`Gadget.ofUnsat`), exact unit edges (`Valid`) and coordinates in
`Q4.threeFive` would give `5 ≤ χ` of the plane over any real field holding `√3` and `√5` by
`(add_one_le_chromaticNumber_iff_not_colorable.mpr h).trans (witness.chromaticNumber_le_planeOver (by decide) hvalid hcoords
fun _ hx => Q4.eval_mem_of_mem_threeFive h3 h5 hx)` — the shape FS-72 would fill. The skeleton that stated that theorem with a
placeholder proof is in git at `a4af6ea4`.
-/

namespace HadwigerNelson

open SimpleGraph SquareClass

-- `Adjoin.eval`'s defining equation, restated locally for the reason `SeamCert.lean`'s private copy gives: the lemma belongs
-- in `Field/Quadratic.lean`, whose declarations have ~1,500 transitive dependents.
private theorem eval_mk {K : Type*} [CommRing K] [NatScalar K] {d : ℕ} (evalBase : K →+* ℝ)
    (r : ℝ) (hr : r ^ 2 = d) (x : Adjoin d K) :
    Adjoin.eval evalBase r hr x = evalBase x.re + evalBase x.im * r := rfl

/-! ### `ℤ[√3, √5]` inside the tower -/

/-- **`ℤ[√3, √5]` inside the tower.** `Q4 = Adjoin 11 (Adjoin 7 (Adjoin 5 (Adjoin 3 ℤ)))`: `x.im` is the `√11`-component and
`x.re.im` the `√7`-component of the `√11`-free part. Both vanish exactly when `x.re.re ∈ Adjoin 5 (Adjoin 3 ℤ) = ℤ[√3, √5]`
carries everything, i.e. `x ∈ ℤ[√3, √5]`.

Closed under multiplication because the outer two levels are then trivial: with no `√11` on either factor the product's
`√11`-part is `x.re * y.im + x.im * y.re = 0`, and its `√11`-free part is `x.re * y.re` (the `11 * x.im * y.im` term vanishes),
whose `√7`-part is `x.re.re * y.re.im + x.re.im * y.re.re = 0`. -/
def Q4.threeFive : Subring Q4 where
  carrier := {x | x.im = 0 ∧ x.re.im = 0}
  mul_mem' {x y} hx hy := by
    simp only [Set.mem_setOf_eq] at hx hy ⊢
    obtain ⟨hx1, hx2⟩ := hx; obtain ⟨hy1, hy2⟩ := hy
    simp only [Adjoin.mul_re, Adjoin.mul_im, hx1, hx2, hy1, hy2, mul_zero, zero_mul, add_zero, and_self]
  one_mem' := by simp
  add_mem' {x y} hx hy := by
    simp only [Set.mem_setOf_eq] at hx hy ⊢
    simp [Adjoin.add_re, Adjoin.add_im, hx.1, hx.2, hy.1, hy.2]
  zero_mem' := by simp
  neg_mem' {x} hx := by
    simp only [Set.mem_setOf_eq] at hx ⊢
    simp [Adjoin.neg_re, Adjoin.neg_im, hx.1, hx.2]

/-- Membership decides, so `CoordsIn` decides: a `decide` over a certificate's table checks that it is drawn in `ℚ(√3,√5)`. -/
instance : DecidablePred (· ∈ Q4.threeFive) :=
  fun x => decidable_of_iff (x.im = 0 ∧ x.re.im = 0) Iff.rfl

-- A member: `2 - 3√3 + √5 + 4√15` (the `√5`-level element `⟨⟨2, -3⟩, ⟨1, 4⟩⟩`, no `√7`, no `√11`).
example : (⟨⟨⟨⟨2, -3⟩, ⟨1, 4⟩⟩, 0⟩, 0⟩ : Q4) ∈ Q4.threeFive := by decide
-- A `√7` intruder must fail: `√7` is the `.re.im` slot.
example : (⟨⟨0, ⟨⟨0, 0⟩, ⟨1, 0⟩⟩⟩, 0⟩ : Q4) ∉ Q4.threeFive := by decide
-- A `√11` intruder must fail: `√11` is the `.im` slot.
example : (⟨0, ⟨⟨⟨1, 0⟩, 0⟩, 0⟩⟩ : Q4) ∉ Q4.threeFive := by decide

/-- **An element of `ℤ[√3, √5]` evaluates into every real field holding `√3` and `√5`.** -/
theorem Q4.eval_mem_of_mem_threeFive {F : Subfield ℝ} (h3 : Real.sqrt 3 ∈ F) (h5 : Real.sqrt 5 ∈ F) {x : Q4}
    (hx : x ∈ Q4.threeFive) : Q4.eval x ∈ F := by
  obtain ⟨h1, h2⟩ := hx
  simp only [Q4.eval, eval_mk, h1, h2, map_zero, zero_mul, add_zero, Int.coe_castRingHom]
  repeat' first
    | exact h3
    | exact h5
    | exact intCast_mem F _
    | apply add_mem
    | apply mul_mem

/-! ### The plane -/

/-- `√3 ∈ ℚ(√3,√5)`. -/
theorem sqrt_three_mem_fieldOfRadicands_three_five : Real.sqrt 3 ∈ fieldOfRadicands {3, 5} := by
  simpa using sqrt_mem_fieldOfRadicands (D := {3, 5}) (d := 3) (by simp)

/-- `√5 ∈ ℚ(√3,√5)`. -/
theorem sqrt_five_mem_fieldOfRadicands_three_five : Real.sqrt 5 ∈ fieldOfRadicands {3, 5} := by
  simpa using sqrt_mem_fieldOfRadicands (D := {3, 5}) (d := 5) (by simp)

end HadwigerNelson

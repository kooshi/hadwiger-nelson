import Proofs.HadwigerNelson.Instances.SqrtEleven

/-!
# The plane over `ℚ(√3,√5)` needs five colours — the skeleton (FS-70)

FS-70 (`plans/FS70-five-over-sqrt3-sqrt5.md` §5): **`five_le_chromaticNumber_planeOver_threeFive`** — `χ(ℚ(√3,√5)²) ≥ 5`, from a
finite unit-distance graph in `ℚ(√3,√5)²` with no proper 4-colouring. The field has no `√11`, so the witness contains no Moser
spindle; it is a four-colour forced pair at a chainable distance closed inside the field by the chain theorem (`CLAUDE.md` G55),
built in FS-70's phases 1–2.

## What this module holds today

The statement, at its proof's level, with one `sorry` where phase 2.4 will put the certificate. Everything else is proved:

* `Q4.threeFive`, the elements of the tower `Q4 = Adjoin 11 (Adjoin 7 (Adjoin 5 (Adjoin 3 ℤ)))` whose `√11`- and `√7`-parts
  vanish — `ℤ[√3, √5]` — as a `Subring` with decidable membership, so `UDCert.CoordsIn Q4.threeFive` decides;
* `Q4.eval_mem_of_mem_threeFive`: such an element evaluates into every real field holding `√3` and `√5`;
* the consumer is `UDCert.chromaticNumber_le_planeOver` (`Instances/SqrtEleven.lean`), already generic in the subring.

**This module is not imported by `Proofs.lean` until the `sorry` is discharged**: the gates fail on `sorryAx`.

## What the certificate will be

`tools/fs70_emit_witness.py` puts the phase-2 witness through `tools/emit_cert.py` (slots `1, √3, √5, √15` of the sixteen) and
`tools/emit_mask.py` (four colours, the triangle pin `c(0) = 0, c(1) = 1, c(2) = 2`) into `Instances/ThreeFive/`; the kernel then
checks the geometry (`Valid`), the field (`CoordsIn Q4.threeFive`) and the refutation (`Gadget.ofUnsat`), exactly as
`Instances/SqrtEleven.lean` does at three colours.
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

/-- **The plane over any real field holding `√3` and `√5` needs five colours.** The statement at its proof's level: the
witness uses nothing about the field but `√3, √5 ∈ F`.

**Skeleton (FS-70 phase 2.4 discharges this):** the proof is
`(add_one_le_chromaticNumber_iff_not_colorable.mpr witness_not_colorable_four).trans
  (witness.chromaticNumber_le_planeOver (by decide) witness_valid witness_coordsIn_threeFive
    fun _ hx => Q4.eval_mem_of_mem_threeFive h3 h5 hx)`
for a certificate `witness : UDCert n` whose four-refusal is a kernel-replayed LRAT (`Gadget.ofUnsat`, as in
`Instances/SqrtEleven.lean`), whose edges are exact unit distances (`Valid`) and whose coordinates lie in `Q4.threeFive`. -/
theorem five_le_chromaticNumber_planeOver_of_sqrt_three_five_mem {F : Subfield ℝ} (h3 : Real.sqrt 3 ∈ F)
    (h5 : Real.sqrt 5 ∈ F) :
    5 ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber := by
  sorry

/-- **The plane over `ℚ(√3,√5)` needs five colours**: `χ(ℚ(√3,√5)²) ≥ 5` — the first kernel five outside the towers over
`K = ℚ(√3,√11)`, and the first from a graph with no Moser spindle. The matching upper bound (`χ ≤ 5`, the residue plane at 11,
`chromaticNumber_finitePlane11`) is **not** proved here: its number-field step is row 57's gap. -/
theorem five_le_chromaticNumber_planeOver_threeFive :
    5 ≤ ((unitDistance ℂ).induce (planeOver (fieldOfRadicands {3, 5}))).chromaticNumber :=
  five_le_chromaticNumber_planeOver_of_sqrt_three_five_mem sqrt_three_mem_fieldOfRadicands_three_five
    sqrt_five_mem_fieldOfRadicands_three_five

end HadwigerNelson

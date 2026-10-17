import Proofs.HadwigerNelson.RationalFour.Order

/-!
# The four-colour compulsions of rational four-space (FS-131, FS131-KFS1; skeleton)

**Read aloud, against the informal claim** (`CLOSED-QUESTIONS.md` § 3, the `ℚ⁴` entry; the consolidation run's LV-T3 and LX-T5).
For points `x ≠ y` of `ℚ⁴`, with `w = v₂(|x − y|²)`:
* every proper four-colouring of the unit-distance graph gives `x` and `y` one colour iff `w ≥ 1`
  (`forall_coloring_eq_iff`);
* every one gives them different colours iff `w = 0` (`forall_coloring_ne_iff`);
* some give them one colour and some do not iff `w < 0` (`exists_coloring_eq_and_ne_iff`).

**What it rests on:** the standard three axioms (planned). `[Zaks1999]` Lemma 1 (pairs at `√2` share a colour) is
`coloring_eq_of_sqDist_two`, proved here by the consolidation run's five-point gadget (LX L4), not imported. `[BendaPerles2000]`'s
description of the component is `mem_comp_iff` (`RationalFour/Order`), proved here.

**Models.** Every theorem here takes a proper four-colouring `c : G.Coloring (Fin 4)`; the residue colourings
`residueColouring a` inhabit that type for every shift `a` (`nonempty_coloring`), so no statement is vacuous.

**Not claimed:** anything at other numbers of colours; that the law is new (prior art: FS131-PAS2's to find).
-/

namespace HadwigerNelson.RationalFour

open Quaternion

/-! ## Zaks's Lemma 1 -/

/-- **`[Zaks1999]` Lemma 1** (p. 92): every proper four-colouring of the unit-distance graph on `ℚ⁴` gives every two points at
distance `√2` one colour. The gadget `0, 1, h, a, b` (`a = ½(1+i+j−k)`, `b = ½(1+i−j+k)`: nine unit pairs, `|a − b|² = 2`),
moved onto `x, y` by `z ↦ x + (z − a)·q`, `q = (b − a)⁻¹(y − x)` a unit. -/
theorem coloring_eq_of_sqDist_two (c : quatGraph.Coloring (Fin 4)) {x y : ℍ[ℚ]} (h : sqDist x y = 2) : c x = c y := by
  sorry

/-! ## Forced equal and forced different -/

/-- **Forced equal** (LX L5): `v₂(|x − y|²) ≥ 1` gives one colour — `x − y = (1 + i) r` with `r` a sum of unit vectors, and
each `(1 + i) u` has squared length 2. -/
theorem coloring_eq_of_mem_pr (c : quatGraph.Coloring (Fin 4)) {x y : ℍ[ℚ]} (h : x - y ∈ pr) : c x = c y := by
  sorry

/-- **Forced different** (LX L6): a difference in `comp` outside `P` is congruent modulo `P` to a nonzero vertex of the
tetrahedron, a unit vector. -/
theorem coloring_ne_of_mem_comp_of_notMem_pr (c : quatGraph.Coloring (Fin 4)) {x y : ℍ[ℚ]} (hc : x - y ∈ comp)
    (hp : x - y ∉ pr) : c x ≠ c y := by
  sorry

/-! ## The residue colourings -/

/-- **The residue of a point of the component**: the vertex of the tetrahedron it is congruent to modulo `P` (`0` outside the
component, where it is never read). -/
noncomputable def residue (z : ℍ[ℚ]) : Fin 4 := by
  classical
  exact if hz : z ∈ comp then (existsUnique_tetra_sub_mem_pr hz).exists.choose else 0

/-- **The residue colouring shifted by `a`**: on the component of `x`, the residue of `x` minus the component's chosen
representative, plus the shift `a` chosen per component. -/
noncomputable def residueCol (a : ℍ[ℚ] ⧸ comp → Fin 4) (x : ℍ[ℚ]) : Fin 4 :=
  residue (x - (QuotientAddGroup.mk x : ℍ[ℚ] ⧸ comp).out) + a (QuotientAddGroup.mk x)

/-- Every shifted residue colouring is proper (`[Johnson1990]` Thm 3's colouring at the shift `0`). -/
theorem residueCol_ne_of_adj (a : ℍ[ℚ] ⧸ comp → Fin 4) {x y : ℍ[ℚ]} (h : quatGraph.Adj x y) :
    residueCol a x ≠ residueCol a y := by
  sorry

/-- **The residue colouring**, shifted by `a`, as a colouring. -/
noncomputable def residueColouring (a : ℍ[ℚ] ⧸ comp → Fin 4) : quatGraph.Coloring (Fin 4) :=
  SimpleGraph.Coloring.mk (residueCol a) fun h => residueCol_ne_of_adj a h

/-- The model of every hypothesis of this file: proper four-colourings exist. -/
theorem nonempty_coloring : Nonempty (quatGraph.Coloring (Fin 4)) := ⟨residueColouring fun _ => 0⟩

/-- **The residue colouring separates `v₂ = 0`**: one colour forces `x − y ∈ P` or `x − y ∉ comp`. -/
theorem residueCol_eq_imp (a : ℍ[ℚ] ⧸ comp → Fin 4) {x y : ℍ[ℚ]} (h : residueCol a x = residueCol a y) :
    x - y ∈ pr ∨ x - y ∉ comp := by
  sorry

/-- **Free across components**: points in two components are given one colour by one shift and two colours by another. -/
theorem exists_residueCol_eq_and_ne {x y : ℍ[ℚ]} (h : x - y ∉ comp) :
    (∃ a, residueCol a x = residueCol a y) ∧ ∃ a, residueCol a x ≠ residueCol a y := by
  sorry

/-! ## The compulsion law on the quaternion graph -/

/-- Forced equal, on the quaternion graph: iff `x − y ∈ P`. -/
theorem forall_quatColoring_eq_iff (x y : ℍ[ℚ]) :
    (∀ c : quatGraph.Coloring (Fin 4), c x = c y) ↔ x - y ∈ pr := by
  sorry

/-- Forced different, on the quaternion graph: iff `x − y ∈ comp` and `x − y ∉ P`. -/
theorem forall_quatColoring_ne_iff (x y : ℍ[ℚ]) :
    (∀ c : quatGraph.Coloring (Fin 4), c x ≠ c y) ↔ x - y ∈ comp ∧ x - y ∉ pr := by
  sorry

/-- Free, on the quaternion graph: iff `x` and `y` lie in different components. -/
theorem exists_quatColoring_eq_and_ne_iff (x y : ℍ[ℚ]) :
    ((∃ c : quatGraph.Coloring (Fin 4), c x = c y) ∧ ∃ c : quatGraph.Coloring (Fin 4), c x ≠ c y) ↔
      x - y ∉ comp := by
  sorry

/-! ## The compulsion law on `ℚ⁴` (the head statements) -/

/-- **Forced to one colour** (LV-T3 = LX-T5, first clause): every proper four-colouring of the unit-distance graph on `ℚ⁴`
gives `x` and `y` one colour iff `x = y` or `v₂(|x − y|²) ≥ 1`. -/
theorem forall_coloring_eq_iff (x y : Fin 4 → ℚ) :
    (∀ c : ratFourGraph.Coloring (Fin 4), c x = c y) ↔ x = y ∨ 1 ≤ padicValRat 2 (sqDist4 x y) := by
  sorry

/-- **Forced to different colours** (second clause): iff `v₂(|x − y|²) = 0` and `x ≠ y`. -/
theorem forall_coloring_ne_iff (x y : Fin 4 → ℚ) :
    (∀ c : ratFourGraph.Coloring (Fin 4), c x ≠ c y) ↔ padicValRat 2 (sqDist4 x y) = 0 ∧ x ≠ y := by
  sorry

/-- **Free** (third clause): some proper four-colouring gives `x, y` one colour and another gives them two iff
`v₂(|x − y|²) < 0` — `x` and `y` lie in different components. -/
theorem exists_coloring_eq_and_ne_iff (x y : Fin 4 → ℚ) :
    ((∃ c : ratFourGraph.Coloring (Fin 4), c x = c y) ∧ ∃ c : ratFourGraph.Coloring (Fin 4), c x ≠ c y) ↔
      padicValRat 2 (sqDist4 x y) < 0 := by
  sorry

/-- **Forced equal, applied**: a proper four-colouring of `ℚ⁴` gives one colour to two points whose squared distance has
2-adic valuation at least 1 (`[Zaks1999]` Lemmas 1–2 are the squared distances 2 and 4). -/
theorem coloring_eq_of_one_le_padicValRat (c : ratFourGraph.Coloring (Fin 4)) {x y : Fin 4 → ℚ}
    (h : 1 ≤ padicValRat 2 (sqDist4 x y)) : c x = c y :=
  (forall_coloring_eq_iff x y).2 (Or.inr h) c

/-- **Forced different, applied**: a proper four-colouring of `ℚ⁴` gives two colours to distinct points whose squared distance
has 2-adic valuation 0 (`[Zaks1999]` Theorem 3 is the odd integer distances). -/
theorem coloring_ne_of_padicValRat_eq_zero (c : ratFourGraph.Coloring (Fin 4)) {x y : Fin 4 → ℚ} (hxy : x ≠ y)
    (h : padicValRat 2 (sqDist4 x y) = 0) : c x ≠ c y :=
  (forall_coloring_ne_iff x y).2 ⟨h, hxy⟩ c

/-! ## Spec -/

/-- Zaks's Lemma 2 (`[Zaks1999]` p. 92) as an instance of the law: pairs at distance 2 share a colour. -/
example (c : ratFourGraph.Coloring (Fin 4)) : c 0 = c ![2, 0, 0, 0] := by
  sorry

end HadwigerNelson.RationalFour

#!/usr/bin/env python3
"""FS131-KFS1 stage 3: apply the domain- and experience-modeling passes' statement changes to the skeleton (run once)."""
import pathlib
root = pathlib.Path(__file__).resolve().parents[3]
def edit(rel, old, new):
    p = root / rel
    s = p.read_text()
    assert s.count(old) == 1, (rel, old[:60])
    p.write_text(s.replace(old, new))

C = 'Proofs/HadwigerNelson/RationalFour/Compulsion.lean'
# domain pass: the quaternion-level law by membership in comp ⊇ pr
edit(C, """theorem forall_quatColoring_eq_iff (x y : ℍ[ℚ]) :
    (∀ c : quatGraph.Coloring (Fin 4), c x = c y) ↔ x = y ∨ 1 ≤ val (x - y) := by""",
"""/-- Forced equal, on the quaternion graph: iff `x − y ∈ P`. -/
theorem forall_quatColoring_eq_iff (x y : ℍ[ℚ]) :
    (∀ c : quatGraph.Coloring (Fin 4), c x = c y) ↔ x - y ∈ pr := by""")
edit(C, """theorem forall_quatColoring_ne_iff (x y : ℍ[ℚ]) :
    (∀ c : quatGraph.Coloring (Fin 4), c x ≠ c y) ↔ val (x - y) = 0 ∧ x ≠ y := by""",
"""/-- Forced different, on the quaternion graph: iff `x − y ∈ comp` and `x − y ∉ P`. -/
theorem forall_quatColoring_ne_iff (x y : ℍ[ℚ]) :
    (∀ c : quatGraph.Coloring (Fin 4), c x ≠ c y) ↔ x - y ∈ comp ∧ x - y ∉ pr := by""")
edit(C, """theorem exists_quatColoring_eq_and_ne_iff (x y : ℍ[ℚ]) :
    ((∃ c : quatGraph.Coloring (Fin 4), c x = c y) ∧ ∃ c : quatGraph.Coloring (Fin 4), c x ≠ c y) ↔
      val (x - y) < 0 := by""",
"""/-- Free, on the quaternion graph: iff `x` and `y` lie in different components. -/
theorem exists_quatColoring_eq_and_ne_iff (x y : ℍ[ℚ]) :
    ((∃ c : quatGraph.Coloring (Fin 4), c x = c y) ∧ ∃ c : quatGraph.Coloring (Fin 4), c x ≠ c y) ↔
      x - y ∉ comp := by""")
# experience pass: the forms a prover applies to one colouring
edit(C, """/-! ## Spec -/

/-- Zaks's Lemma 2""", """/-- **Forced equal, applied**: a proper four-colouring of `ℚ⁴` gives one colour to two points whose squared distance has
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

/-- Zaks's Lemma 2""")
F = 'Proofs/HadwigerNelson/RationalFour/Forbid.lean'
edit(F, """/-- **`[Johnson2006]` p. 212's question, answered**: for `d > 0`, a proper four-colouring of the unit-distance graph on `ℚ⁴`
forbidding distance `d` exists iff `d²` is irrational (no pair of `ℚ⁴` is at distance `d`) or `d² = p/q` with `p, q` odd. -/""",
"""/-- **Which distances a four-colouring of `ℚ⁴` can forbid beside 1** (`[Johnson2006]` p. 212's question): for `d > 0`, a proper
four-colouring of the unit-distance graph on `ℚ⁴` forbidding distance `d` exists iff `d²` is irrational (no pair of `ℚ⁴` is at
distance `d`) or `d² = p/q` with `p, q` odd. The *if* half is `[Johnson1990]` Thm 3; the *only if* half is the compulsion
law with a rational similarity of ratio `d`. -/""")
S = 'Proofs/HadwigerNelson/Instances/SeamFractional.lean'
edit(S, """/-- **`χ_f(ℚ(√3, √11)²) = 4`.** -/""",
"""/-- **The fractional chromatic number of the plane over `ℚ(√3, √11)` is 4** (`[CranstonRabern2015]`'s question). The upper
bound is `[Fischer1994]`'s value, Theorem B (`four_colorable_of_seam_field`); the lower is `[MatolcsiEtAl2025]` Thm 3's
certificate for `G27` read against an invariant random independent set (`IndepLaw.density_le_quarter_seamField`). -/""")
print('applied')

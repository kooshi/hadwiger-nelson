import Proofs.HadwigerNelson.FieldWall4
import Proofs.HadwigerNelson.UnitQuadrance

/-!
# Certificates over `K = ℚ(√3, √11)`: Theorem B, applied

**Any unit-distance certificate whose coordinates avoid `√5` and `√7` describes a 4-colourable
graph.** That is Theorem B (`FieldWall4.lean`, `colorable_four_of_subset_seamPlane`) delivered to
the form the instances hold: a `UDCert`, an integer table, and a `decide`.

## Why this module exists

`Instances/Core122.lean` proves *"every proper 4-colouring of these 122 points makes some listed
distance-2 pair monochromatic"* — and until now **nothing in this library showed those points had
a 4-colouring at all**. The statement was true and could have been empty. The audit that found it
(`plans/STUB-consolidation-remainder.md` §1) noted the consequence honestly: if that graph had no
4-colouring, this project would own a 122-point 5-chromatic graph, four times smaller than the
record, and not know it.

**It does have one, and the reason is arithmetic rather than luck.** The 122 points are seam-lattice
points: every coordinate uses only `1, √3, √11, √33` of the tower's sixteen basis slots, so they lie
in `K = ℚ(√3, √11)` — Theorem B's own field — and Theorem B four-colours every finite unit-distance
graph drawn there. `scripts/vacuity.sh` is what turned the gap from a remark into a gate.

## The shape, and one thing it deliberately is not

`Q4.seamFree` is `Q4.sevenFree` one level deeper, written to match it, because `UDCert.CoordsIn` is
stated over a `Subring Q4` and **decides** — which is what makes the instance below a one-liner and
every future `K`-certificate free.

*It is NOT built as an intersection with a "`√5`-free" subring, and the reason is worth recording:
there is no such subring.* Forgetting an **inner** generator of the tower is not independently
closed — with `√7` still present, `(a + b√7)(a' + b'√7)` contributes `7bb'`, whose `√5`-part need
not vanish. Only after the outer generator is gone does the inner condition become multiplicative,
so the four conditions have to be taken together and there is nothing to intersect.
-/

namespace HadwigerNelson

open SimpleGraph FieldWall4

-- `Adjoin.eval`'s defining equation, restated locally. `Field/Approx.lean:203` holds an identical
-- private copy: the lemma belongs on `Adjoin.eval` in `Field/Quadratic.lean`, and it is not there
-- because that module carries ~1,498 transitive dependents while this leaf carries none. Same
-- trade, same reason, as the fourteen private copies of `√3 * √3 = 3` (FS-24 item D).
private theorem eval_mk {K : Type*} [CommRing K] [NatScalar K] {d : ℕ} (evalBase : K →+* ℝ)
    (r : ℝ) (hr : r ^ 2 = d) (x : Adjoin d K) :
    Adjoin.eval evalBase r hr x = evalBase x.re + evalBase x.im * r := rfl

/-! ### The `√5`- and `√7`-free subring -/

/-- **`ℤ[√3, √11]` inside the tower.** `Q4 = Adjoin 11 (Adjoin 7 (Adjoin 5 (Adjoin 3 ℤ)))`, so
`x.re` and `x.im` are the two `√11`-components, their `.im` are the `√7`-coefficients, and the
`.re.im` of those are the `√5`-coefficients. All four vanish exactly when `x.re, x.im ∈ ℤ[√3]`,
i.e. when `x ∈ ℤ[√3, √11]`.

Closed under multiplication because both cross terms vanish: with no `√7` on either factor the
`√7`-parts of the product are `0`, and the surviving components then carry no `√5` either. -/
def Q4.seamFree : Subring Q4 where
  carrier := {x | x.re.im = 0 ∧ x.im.im = 0 ∧ x.re.re.im = 0 ∧ x.im.re.im = 0}
  mul_mem' {x y} hx hy := by
    simp only [Set.mem_setOf_eq] at hx hy ⊢
    obtain ⟨hx1, hx2, hx3, hx4⟩ := hx; obtain ⟨hy1, hy2, hy3, hy4⟩ := hy
    simp only [Adjoin.mul_re, Adjoin.mul_im, Adjoin.add_re, Adjoin.add_im, Adjoin.natCast_re,
      Adjoin.natCast_im, hx1, hx2, hx3, hx4, hy1, hy2, hy3, hy4, mul_zero, zero_mul, add_zero,
      and_self]
  one_mem' := by simp
  add_mem' {x y} hx hy := by
    simp only [Set.mem_setOf_eq] at hx hy ⊢
    simp [Adjoin.add_re, Adjoin.add_im, hx.1, hx.2.1, hx.2.2.1, hx.2.2.2,
      hy.1, hy.2.1, hy.2.2.1, hy.2.2.2]
  zero_mem' := by simp
  neg_mem' {x} hx := by
    simp only [Set.mem_setOf_eq] at hx ⊢
    simp [Adjoin.neg_re, Adjoin.neg_im, hx.1, hx.2.1, hx.2.2.1, hx.2.2.2]

/-- Membership decides, so `CoordsIn` decides: a `decide` over a certificate's table checks that it
is drawn in `K`. -/
instance : DecidablePred (· ∈ Q4.seamFree) :=
  fun x => decidable_of_iff (x.re.im = 0 ∧ x.im.im = 0 ∧ x.re.re.im = 0 ∧ x.im.re.im = 0) Iff.rfl

/-! ### Evaluation lands in `K` -/

private theorem sqrt3_mul_sqrt11 : Real.sqrt 3 * Real.sqrt 11 = Real.sqrt 33 := by
  rw [← Real.sqrt_mul (by norm_num)]; norm_num

/-- **The bridge.** A `√5`- and `√7`-free element evaluates into `K`: its four surviving integer
components are the coordinates on `1, √3, √11, √33`. -/
theorem Q4.eval_mem_seamField {x : Q4} (h : x ∈ Q4.seamFree) : Q4.eval x ∈ seamField := by
  obtain ⟨h1, h2, h3, h4⟩ := h
  refine ⟨(x.re.re.re.re : ℚ), (x.re.re.re.im : ℚ), (x.im.re.re.re : ℚ), (x.im.re.re.im : ℚ), ?_⟩
  simp only [Q4.eval, eval_mk, h1, h2, h3, h4, map_zero, zero_mul, add_zero,
    Int.coe_castRingHom]
  push_cast
  rw [← sqrt3_mul_sqrt11]
  ring

/-! ### The consumer -/

namespace UDCert

variable {n : ℕ}

/-- Every point of a `K`-drawn certificate lies in `K²`. The denominator divides out inside the
subfield. -/
theorem point_mem_seamPlane (c : UDCert n) (hS : c.CoordsIn Q4.seamFree) (i : Fin n) :
    c.point i ∈ seamPlane := by
  have hD : ((c.denom : ℝ)) ∈ seamField := by
    simp
  exact ⟨div_mem (Q4.eval_mem_seamField (hS i).1) hD,
    div_mem (Q4.eval_mem_seamField (hS i).2) hD⟩

/-- **Theorem B for certificates.** A valid certificate drawn in `K = ℚ(√3, √11)` has a
4-colourable graph.

The hypotheses are satisfiable and the witness ships with the theorem: `core122` discharges all
three by `decide` (`Instances/Core122.lean`, `core122_colorable_four`) — `CLAUDE.md` `G30`'s fifth
failure mode, which is what this whole module is repairing. -/
theorem colorable_four_of_seamFree (c : UDCert n) (hd : c.denom ≠ 0) (hv : c.Valid = true)
    (hS : c.CoordsIn Q4.seamFree) : (edgeGraph n c.edges).Colorable 4 := by
  have hunit := c.valid_sound hd hv
  refine Colorable.of_hom
    (G' := (unitDistance ℂ).induce (Set.range c.point))
    ⟨fun i => ⟨c.point i, i, rfl⟩, ?_⟩
    (colorable_four_of_subset_seamPlane _ ?_)
  · rintro i j ⟨hne, hm | hm⟩
    · exact unitDistance_adj.mpr (hunit (i, j) hm)
    · exact unitDistance_adj.mpr (by rw [dist_comm]; exact hunit (j, i) hm)
  · rintro z ⟨i, rfl⟩
    exact point_mem_seamPlane c hS i

end UDCert

end HadwigerNelson

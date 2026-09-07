import Proofs.HadwigerNelson.ResidueObstruction
import Mathlib.NumberTheory.LegendreSymbol.Basic

/-!
# Local–global tightness: the periodic quotient, the counting bound, and the spindle that escapes its prime

The **local bound** of a real field `F` is the least number of colours any residue colouring of `F²` uses — at
the prime above `2` (Theorem B), at `3` (Fischer), and at every usable prime `p ≡ 3 (mod 4)` the chromatic number
of the finite plane `UD(𝔽_p, 2)` (M58). The conjecture M61 studies (`plans/M61-local-global-tightness.md`) is that
`χ(F²)` IS that bound wherever the bound is at most `6`. This module holds the three pieces of kernel content the
milestone's derivations produced:

* **The periodic quotient** (§S3). A colouring of a Cayley graph `addCayley S` that is constant on the cosets of a
  subgroup is a colouring of the quotient Cayley graph: an additive hom `π` whose kernel misses `S` is a graph hom
  `addCayley S →g addCayley (π '' S)` (`addCayleyMap`), so a colouring of the image graph pulls back
  (`colorable_of_addCayley_image_subset`). For the finite plane the quotient by a null line is a circulant on `p`
  vertices, and a table on `ZMod p` that is proper along the projected circle is a colouring of the plane
  (`addCayleyColoring`, `unitQuadrance_colorable_of_quotient`). At `19` this is a nineteen-entry certificate of
  `χ(UD(𝔽₁₉, 2)) ≤ 5` (`Instances/LocalGlobal19.lean`).
* **The counting bound** (§S2). A `k`-colourable finite graph has at most `k · indepNum` vertices
  (`card_le_mul_indepNum_of_colorable`) — the fractional face of the first digit, whose consumer is a certified
  refutation of an independent set (none exists yet; the tools' α refusals are the solver's).
* **The spindle escapes its prime** (§S5). In `ZMod p` with `p ≡ 3 (mod 4)` there are no isotropic vectors
  (`sq_add_sq_eq_zero_iff`), so a pair whose residues coincide has a residue-`0` squared distance; and a ring hom
  `φ : R →+* ZMod p` cannot send `d` to `0` when `R` holds the spindle radicand `√(4d − 1)` up to a unit
  (`no_ringHom_of_spindle_radicand`: `φ(x/e)² = −1`). Composed with M60's transfer: **a graph forcing a pair equal
  at `k` colours, drawn in a ring that holds that pair's spindle radicand, admits no reduction to a plane that is
  forces-free at `k`** (`Forces.no_hom_of_spindle_radicand`). That is the mechanism of tightness: a forcer built as
  "fabric forcing a pair at `k` colours + the spindle over it" lands in a field where the prime that sealed the fabric
  at `k` is no longer usable — the local bound it beats is the one its own construction removes.

## What a consumer may conclude, and what not

The quotient theorems are about Cayley graphs and additive homs; the plane instance needs the projection to miss the
circle (a null line), decided per prime. The counting bound is unconditional. The radicand lemma is ring-level: the
field-level statement ("every prime of `F(√(4d² − 1))` above `p` has even residue degree") is a hand argument
(`plans/M61-local-global-tightness.md` §S5), exactly as M58's integrality is. `Forces.no_hom_of_spindle_radicand`
takes the plane's forces-freeness as a hypothesis — a theorem at `11` (`finitePlane11_forces_iff`), a per-class
witness at `3` (`Instances/LocalGlobal19.lean`), measured at `7` and `19`.
-/

namespace HadwigerNelson

open SimpleGraph

/-! ### The periodic quotient of a Cayley graph -/

section Quotient

variable {A B : Type*} [AddGroup A] [AddGroup B] {k : ℕ}

/-- **An additive hom whose kernel misses the connection set is a Cayley-graph homomorphism onto the image
set.** Adjacent vertices differ by an element of `S`, whose image is nonzero and lies in `π '' S`. -/
def addCayleyMap (π : A →+ B) (S : Set A) (hS : ∀ s ∈ S, π s ≠ 0) : addCayley S →g addCayley (π '' S) where
  toFun := π
  map_rel' := sorry

@[simp] theorem addCayleyMap_apply (π : A →+ B) (S : Set A) (hS : ∀ s ∈ S, π s ≠ 0) (a : A) :
    addCayleyMap π S hS a = π a := rfl

/-- **A colouring of the quotient is a colouring of the graph** — periodic colourings, in the quotient's
words: any `D ⊇ π '' S` will do. -/
theorem colorable_of_addCayley_image_subset (π : A →+ B) {S : Set A} {D : Set B} (hS : ∀ s ∈ S, π s ≠ 0)
    (hD : ∀ s ∈ S, π s ∈ D) (h : (addCayley D).Colorable k) : (addCayley S).Colorable k :=
  sorry

/-- **A table proper along the connection set is a colouring of the Cayley graph.** The hypothesis is the
decidable one a finite instance checks: `tab x ≠ tab (x + d)` for every `d ∈ D` and every `x`. -/
def addCayleyColoring {D : Set B} (tab : B → Fin k) (h : ∀ d ∈ D, ∀ x, tab x ≠ tab (x + d)) :
    (addCayley D).Coloring (Fin k) :=
  sorry

/-- The pulled-back colouring is periodic at every element of the kernel — the periodic colourings of M60's
`Aperiodic` vocabulary are exactly these. -/
theorem periodic_comp_of_mem_ker (π : A →+ B) (tab : B → Fin k) {d : A} (hd : π d = 0) :
    Function.Periodic (fun a => tab (π a)) d :=
  sorry

end Quotient

/-! ### The plane's periodic colourings -/

section Plane

variable {R : Type*} [CommRing R] {k : ℕ}

/-- **The finite plane is `k`-colourable as soon as its quotient along a null line is.** `π` projects the plane
onto a line; the circle must miss the kernel (`hS`) and project into `D` (`hD`); a table on the quotient proper
along `D` then colours the plane, periodically. -/
theorem unitQuadrance_colorable_of_quotient (π : R × R →+ R) {D : Set R}
    (hS : ∀ s : R × R, s.1 ^ 2 + s.2 ^ 2 = 1 → π s ≠ 0) (hD : ∀ s : R × R, s.1 ^ 2 + s.2 ^ 2 = 1 → π s ∈ D)
    (tab : R → Fin k) (h : ∀ d ∈ D, ∀ x, tab x ≠ tab (x + d)) : (unitQuadrance R).Colorable k :=
  sorry

end Plane

/-! ### The counting bound -/

section Counting

variable {V : Type*} {G : SimpleGraph V} {k : ℕ}

/-- **A `k`-colourable finite graph has at most `k · α` vertices**: each colour class is an independent set. -/
theorem card_le_mul_indepNum_of_colorable [Fintype V] (h : G.Colorable k) : Fintype.card V ≤ k * G.indepNum :=
  sorry

/-- The contrapositive — the consumer of a certified refutation of an independent set. -/
theorem not_colorable_of_mul_indepNum_lt [Fintype V] (h : k * G.indepNum < Fintype.card V) : ¬ G.Colorable k :=
  fun hc => absurd (card_le_mul_indepNum_of_colorable hc) (not_le.mpr h)

end Counting

/-! ### No isotropic vectors, and the spindle radicand -/

section Spindle

variable {p : ℕ} [Fact p.Prime]

/-- **No isotropic vectors modulo a prime `≡ 3 (mod 4)`**: `a² + b² = 0` forces `a = b = 0`, because otherwise
`(a/b)² = −1` and `−1` is not a square (`ZMod.exists_sq_eq_neg_one_iff`). -/
theorem sq_add_sq_eq_zero_iff (hp : p % 4 = 3) {a b : ZMod p} : a ^ 2 + b ^ 2 = 0 ↔ a = 0 ∧ b = 0 :=
  sorry

/-- A ring hom into `ZMod p` commutes with the quadrance. -/
theorem quadrance_map {R : Type*} [CommRing R] (φ : R →+* ZMod p) (w : R × R) :
    (φ w.1) ^ 2 + (φ w.2) ^ 2 = φ (w.1 ^ 2 + w.2 ^ 2) := by
  simp only [map_add, map_pow]

/-- **The spindle radicand kills the prime.** If `R` holds `x, e` with `x² = (4d − 1)·e²` — the radicand of the
spindle over a pair at squared distance `d`, up to the unit `e` — then no ring hom `φ : R →+* ZMod p`, `p ≡ 3 (mod
4)`, sends `d` to `0` while keeping `e` nonzero: `φ(x/e)² = −1`. -/
theorem no_ringHom_of_spindle_radicand {R : Type*} [CommRing R] (hp : p % 4 = 3) (φ : R →+* ZMod p) {x d e : R}
    (hx : x ^ 2 = (4 * d - 1) * e ^ 2) (hd : φ d = 0) (he : φ e ≠ 0) : False :=
  sorry

/-- **A forced pair's spindle escapes every plane that is forces-free at that many colours.** `G` is drawn in `R`
by `g`; the pair `u, v` is forced equal at `k` colours; the plane `UD(ZMod p)` is `k`-forces-free; then no ring hom
`φ : R →+* ZMod p` can exist once `R` holds the pair's spindle radicand — because along `φ` the pair's residues
coincide (`Forces.image` + forces-freeness), so `φ` kills the squared distance, which the radicand lemma forbids. -/
theorem Forces.no_hom_of_spindle_radicand {V R : Type*} {G : SimpleGraph V} [CommRing R] {k : ℕ} (hp : p % 4 = 3)
    (hfree : ∀ u v : ZMod p × ZMod p, Forces (finitePlane p) k u v → u = v)
    (g : G →g unitQuadrance R) (φ : R →+* ZMod p) {u v : V} (h : Forces G k u v) {x e : R}
    (hx : x ^ 2 = (4 * ((g u).1 - (g v).1) ^ 2 + 4 * ((g u).2 - (g v).2) ^ 2 - 1) * e ^ 2) (he : φ e ≠ 0) :
    False :=
  sorry

end Spindle

/-! ### Spec: the radicand lemma on the towers -/

-- The Moser spindle's radicand: `11 = 4·3 − 1` for the rhombus's `√3`-pair. No hom `ℤ[√11] → ZMod 3`.
example : IsEmpty (Adjoin 11 ℤ →+* ZMod 3) := sorry

-- The 6-level's radicand over a 5-sealed field: `43 = 4·11 − 1` for a forced `√11`-pair. No hom `ℤ[√43] → ZMod 11`.
example : IsEmpty (Adjoin 43 ℤ →+* ZMod 11) := sorry

-- Positive controls: `√3 ↦ 5` reduces `ℤ[√3]` at `11` (`25 ≡ 3`), and `√11 ↦ 0` reduces `ℤ[√11]` at `11` — sending
-- the radicand's `d` to `0` alone is no obstruction; the spindle's `4d − 1 ≡ −1` is.
example : Adjoin 3 ℤ →+* ZMod 11 := Adjoin.lift (Int.castRingHom (ZMod 11)) 5 (by decide)
example : Adjoin 11 ℤ →+* ZMod 11 := Adjoin.lift (Int.castRingHom (ZMod 11)) 0 (by decide)

end HadwigerNelson

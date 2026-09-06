import Mathlib.Combinatorics.SimpleGraph.Cayley
import Mathlib.Combinatorics.SimpleGraph.Coloring.Vertex
import Proofs.HadwigerNelson.Certificate
import Proofs.HadwigerNelson.EdgeList

/-!
# The unit-quadrance graph of a ring, and the reduction of a certificate into it

For a commutative ring `R`, `unitQuadrance R` is the graph on `R × R` joining two points whose
difference has **quadrance** `(Δx)² + (Δy)² = 1` — Vinh's "unit-quadrance graph". At `R = ℝ` it is the
Hadwiger–Nelson graph in coordinates; at `R = 𝔽_p` it is the finite Euclidean plane `UD(𝔽_p, 2)`, the
Cayley graph of `𝔽_p²` on the circle. **The finite-plane bound** (the pivot of 2026-09-06,
`reference/Chat-analysis/`; M58) is the functoriality of this graph in `R`: a ring homomorphism applied
coordinatewise is a graph homomorphism (`unitQuadrance.map`), because a homomorphism preserves the
quadrance identity and cannot collapse two points at quadrance `1` (that would make `1 = 0`).

The certificates of M04 present their points in the tower `Q4 = ℤ[√3, √5, √7, √11]` scaled by a
denominator `D`, so the statement the kernel consumes is the certificate form: a `Valid` certificate whose
coordinates lie in a subring `S` of the tower, a ring hom `φ : S →+* R`, and an inverse `u` of `D` in `R`
give a drawing `i ↦ (u·φ xᵢ, u·φ yᵢ)` that is a graph homomorphism `edgeGraph n c.edges →g unitQuadrance R`
(`UDCert.drawing_adj`). The subring is what lets `p = 11` in: `7` is not a square mod `11`, so no hom
leaves `Q4`, but Heule's coordinates are `√7`-free and the `√7`-free elements form a subring
(`Q4.sevenFree`) isomorphic to the smaller tower `Q3 = ℤ[√3, √5, √11]`, out of which the residue hom
exists (`Instances/FinitePlane11.lean`).

## What is and is not here

The hand theorem — every finite unit-distance graph in `F²`, for a number field `F` with a prime above
`p ≡ 3 (mod 4)` of odd residue degree, maps into `UD(𝔽_p, 2)` — has one arithmetic step, the
`𝔭`-integrality of unit vectors, which is NOT formalized: here it is the hypothesis `u * D = 1`, a
decidable fact about a certificate. In exchange the certificate theorem holds for every commutative
ring `R`, every subring `S`, with no condition on `p` at all: the usability of a prime is a statement
about the existence of `φ`, not about the graphs. `plans/M58-field-sieve.md` §M1 records the shape.

## Whose work this is

The bound is the web session's derivation (Kooshi, 2026-09-06), verified in `VERIFICATION.md`; the
finite Euclidean graphs are Medrano–Myers–Stark–Terras (1996) and Vinh (2005). Ours is the statement
over rings and certificates, the kernel proof, and the instances.
-/

namespace HadwigerNelson

open SimpleGraph

/-! ### The graph -/

/-- **The unit-quadrance graph of `R`**: `R × R`, joined at quadrance `1`. Mathlib's `addCayley`
symmetrises and strips loops, so this is a `SimpleGraph` for every commutative ring — the finite
plane `UD(𝔽_p, 2)` at `R = ZMod p`, the real plane in coordinates at `R = ℝ`. -/
def unitQuadrance (R : Type*) [CommRing R] : SimpleGraph (R × R) :=
  addCayley {v : R × R | v.1 ^ 2 + v.2 ^ 2 = 1}

variable {R S : Type*} [CommRing R] [CommRing S]

/-- Adjacency is unit quadrance of the difference — the reasoning surface; never unfold
`unitQuadrance`. -/
theorem unitQuadrance_adj {u v : R × R} :
    (unitQuadrance R).Adj u v ↔ u ≠ v ∧ (u.1 - v.1) ^ 2 + (u.2 - v.2) ^ 2 = 1 := by
  sorry

/-- The graph computes wherever equality in `R` does: `decide` reaches every finite statement about
`unitQuadrance (ZMod p)`. -/
instance unitQuadrance.instDecidableRel [DecidableEq R] : DecidableRel (unitQuadrance R).Adj :=
  fun _ _ => decidable_of_iff _ unitQuadrance_adj.symm

/-- **Functoriality — the finite-plane bound in one line.** A ring homomorphism, applied
coordinatewise, is a graph homomorphism: it preserves the quadrance identity, and it cannot collapse
two adjacent points because their images would then have quadrance `0 = 1`. `Nontrivial S` is exactly
what that last step uses. -/
def unitQuadrance.map [Nontrivial S] (f : R →+* S) : unitQuadrance R →g unitQuadrance S where
  toFun v := (f v.1, f v.2)
  map_rel' h := by sorry

/-! ### Homs out of the towers -/

namespace Adjoin

variable {K : Type*} [CommRing K] [NatScalar K] {d : ℕ}

/-- The universal property of `K[√d]`, computably: a hom out of `K` and a root `r` of `d` in the target
determine the hom `⟨a, b⟩ ↦ f a + f b · r`. A `RingHom` exactly because `r ^ 2 = d`. `Adjoin.eval` is
this at `R = ℝ`; stated here rather than by editing `Field/Quadratic.lean`, which every certificate
module imports. -/
def lift (f : K →+* R) (r : R) (hr : r ^ 2 = d) : Adjoin d K →+* R where
  toFun x := f x.re + f x.im * r
  map_one' := by sorry
  map_mul' x y := by sorry
  map_zero' := by sorry
  map_add' x y := by sorry

@[simp] theorem lift_apply (f : K →+* R) (r : R) (hr : r ^ 2 = d) (x : Adjoin d K) :
    lift f r hr x = f x.re + f x.im * r := rfl

end Adjoin

/-- `ℤ[√3, √5, √11]` — Heule's field's order, the `√7`-free part of the tower. -/
abbrev Q3 : Type := Adjoin 11 (Adjoin 5 (Adjoin 3 ℤ))

/-- A hom out of `Q3` from roots of `3, 5, 11` in the target. -/
def Q3.lift (r₃ r₅ r₁₁ : R) (h₃ : r₃ ^ 2 = 3) (h₅ : r₅ ^ 2 = 5) (h₁₁ : r₁₁ ^ 2 = 11) : Q3 →+* R :=
  Adjoin.lift (Adjoin.lift (Adjoin.lift (Int.castRingHom R) r₃ (by simpa using h₃)) r₅ (by simpa using h₅))
    r₁₁ (by simpa using h₁₁)

/-- A hom out of the whole tower `Q4 = ℤ[√3, √5, √7, √11]` from roots of all four radicands — exists
exactly at the primes where all four are residues (`131` is the first usable one for de Grey's field). -/
def Q4.lift (r₃ r₅ r₇ r₁₁ : R) (h₃ : r₃ ^ 2 = 3) (h₅ : r₅ ^ 2 = 5) (h₇ : r₇ ^ 2 = 7)
    (h₁₁ : r₁₁ ^ 2 = 11) : Q4 →+* R :=
  Adjoin.lift (Adjoin.lift (Adjoin.lift (Adjoin.lift (Int.castRingHom R) r₃ (by simpa using h₃))
    r₅ (by simpa using h₅)) r₇ (by simpa using h₇)) r₁₁ (by simpa using h₁₁)

/-- **The `√7`-free subring** of the tower: the tower is `Adjoin 11 (Adjoin 7 (Adjoin 5 (Adjoin 3 ℤ)))`, so
the `√7`-coefficients of `x` are the inner `.im` of each `√11`-component. Closed under the ring
operations because the `√7`-cross terms vanish when both factors have none. -/
def Q4.sevenFree : Subring Q4 where
  carrier := {x | x.re.im = 0 ∧ x.im.im = 0}
  mul_mem' := by sorry
  one_mem' := by sorry
  add_mem' := by sorry
  zero_mem' := by sorry
  neg_mem' := by sorry

/-- Membership decides: a `decide` over a certificate's table checks `√7`-freeness. -/
instance : DecidablePred (· ∈ Q4.sevenFree) :=
  fun x => decidable_of_iff (x.re.im = 0 ∧ x.im.im = 0) Iff.rfl

/-- **The `√7`-free subring is the smaller tower**: forget the zero `√7`-parts. A ring hom because the
parts forgotten are zero on both sides of every product. -/
def Q4.sevenFree.toQ3 : Q4.sevenFree →+* Q3 where
  toFun x := ⟨x.1.re.re, x.1.im.re⟩
  map_one' := by sorry
  map_mul' x y := by sorry
  map_zero' := by sorry
  map_add' x y := by sorry

/-! ### The reduction of a certificate -/

namespace UDCert

variable {n : ℕ}

/-- Every coordinate of the certificate lies in the subring `S`. -/
def CoordsIn (c : UDCert n) (S : Subring Q4) : Prop := ∀ i, (c.verts i).x ∈ S ∧ (c.verts i).y ∈ S

instance (c : UDCert n) (S : Subring Q4) [DecidablePred (· ∈ S)] : Decidable (c.CoordsIn S) :=
  inferInstanceAs (Decidable (∀ i, _ ∧ _))

/-- Every certificate has its coordinates in the whole tower. -/
theorem coordsIn_top (c : UDCert n) : c.CoordsIn ⊤ := fun _ => ⟨Subring.mem_top _, Subring.mem_top _⟩

/-- **The drawing of a certificate in `R × R`**: each stored coordinate through `φ`, times a chosen
inverse `u` of the denominator. Meaningful when `u * D = 1`; `drawing_adj` demands exactly that. -/
def drawing (c : UDCert n) {S : Subring Q4} (φ : S →+* R) (hS : c.CoordsIn S) (u : R) (i : Fin n) :
    R × R :=
  (u * φ ⟨(c.verts i).x, (hS i).1⟩, u * φ ⟨(c.verts i).y, (hS i).2⟩)

/-- **The reduction theorem, one edge.** A stored unit distance `distSq = D²` in the tower, pushed through
`φ` and scaled by `u² = D⁻²`, is unit quadrance in `R²`; distinctness of the images is the same
identity read at `0 ≠ 1`. -/
theorem drawing_adj [Nontrivial R] (c : UDCert n) {S : Subring Q4} (φ : S →+* R) (hS : c.CoordsIn S)
    {u : R} (hu : u * c.denom = 1) (hv : c.Valid = true) {i j : Fin n}
    (h : (edgeGraph n c.edges).Adj i j) :
    (unitQuadrance R).Adj (c.drawing φ hS u i) (c.drawing φ hS u j) := by
  sorry

/-- **The reduction, as a graph homomorphism.** -/
def drawingHom [Nontrivial R] (c : UDCert n) {S : Subring Q4} (φ : S →+* R) (hS : c.CoordsIn S)
    {u : R} (hu : u * c.denom = 1) (hv : c.Valid = true) : edgeGraph n c.edges →g unitQuadrance R where
  toFun := c.drawing φ hS u
  map_rel' h := c.drawing_adj φ hS hu hv h

/-- **Upper bounds pull back**: a `k`-colouring of `unitQuadrance R` is a `k`-colouring of the certified
graph. -/
theorem colorable_of_unitQuadrance [Nontrivial R] (c : UDCert n) {S : Subring Q4} (φ : S →+* R)
    (hS : c.CoordsIn S) {u : R} (hu : u * c.denom = 1) (hv : c.Valid = true) {k : ℕ}
    (hk : (unitQuadrance R).Colorable k) : (edgeGraph n c.edges).Colorable k :=
  Colorable.of_hom (c.drawingHom φ hS hu hv) hk

/-- **Lower bounds push forward**: a certified refusal of `k` colours on the graph is a refusal on
`unitQuadrance R`. This is how `χ(UD(𝔽₁₁, 2)) ≥ 5` reaches the kernel from Heule-510 with no new
certificate. -/
theorem not_colorable_unitQuadrance [Nontrivial R] (c : UDCert n) {S : Subring Q4} (φ : S →+* R)
    (hS : c.CoordsIn S) {u : R} (hu : u * c.denom = 1) (hv : c.Valid = true) {k : ℕ}
    (hk : ¬ (edgeGraph n c.edges).Colorable k) : ¬ (unitQuadrance R).Colorable k :=
  fun h => hk (c.colorable_of_unitQuadrance φ hS hu hv h)

/-- The numeral form of `not_colorable_unitQuadrance`. -/
theorem add_one_le_chromaticNumber_unitQuadrance [Nontrivial R] (c : UDCert n) {S : Subring Q4}
    (φ : S →+* R) (hS : c.CoordsIn S) {u : R} (hu : u * c.denom = 1) (hv : c.Valid = true) {k : ℕ}
    (hk : ¬ (edgeGraph n c.edges).Colorable k) : (k + 1 : ℕ) ≤ (unitQuadrance R).chromaticNumber := by
  sorry

end UDCert

/-! ### Spec

`UD(𝔽₃, 2)` is the smallest usable plane (χ = 3): its circle has four points and `(0,0)–(0,1)` is an
edge. The hypotheses of `drawing_adj` are load-bearing: a certificate whose denominator vanishes in `R`
has no inverse there, and a drawing made with a wrong `u` collapses the unit pair to a loop, which
`unitQuadrance` strips. -/

section Spec

example : (unitQuadrance (ZMod 3)).Adj (0, 0) (0, 1) := by decide
example : ¬ (unitQuadrance (ZMod 3)).Adj (0, 0) (1, 1) := by decide
example : ¬ (unitQuadrance (ZMod 3)).Adj (0, 0) (0, 0) := by decide

/-- The unit pair `(0,0)`, `(11,0)` at denominator `11`: valid, and at `p = 11` there is no inverse. -/
private def unitPair11 : UDCert 2 where
  verts := ![⟨0, 0⟩, ⟨11, 0⟩]
  edges := [(0, 1)]
  denom := 11

example : unitPair11.Valid = true := by decide

/-- No `u` inverts `11` in `ZMod 11`: the reduction theorem's hypothesis fails, and indeed the drawing
made with any `u` puts both points at the origin. -/
example : ¬ ∃ u : ZMod 11, u * (unitPair11.denom : ZMod 11) = 1 := by sorry

example (u : ZMod 11) :
    unitPair11.drawing (Q4.lift (R := ZMod 11) 5 4 0 0 (by decide) (by decide) sorry (by decide) |>.comp
      (Subring.subtype ⊤)) unitPair11.coordsIn_top u 0 =
    unitPair11.drawing (Q4.lift (R := ZMod 11) 5 4 0 0 (by decide) (by decide) sorry (by decide) |>.comp
      (Subring.subtype ⊤)) unitPair11.coordsIn_top u 1 := by
  sorry

end Spec

end HadwigerNelson

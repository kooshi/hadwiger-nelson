import Mathlib.Combinatorics.SimpleGraph.Cayley
import Mathlib.Combinatorics.SimpleGraph.Coloring.Vertex
import Proofs.HadwigerNelson.Certificate
import Proofs.HadwigerNelson.EdgeList

/-!
# The finite Euclidean plane, and the reduction of a certificate into it

The **finite-plane bound** (the pivot of 2026-09-06, `reference/Chat-analysis/`; M58): for a real number
field `F` with a prime `𝔭` above `p ≡ 3 (mod 4)` of odd residue degree, every finite unit-distance graph
in `F²` maps homomorphically into the finite Euclidean plane

    UD(𝔽_p, 2) = Cay(𝔽_p², {(a, b) : a² + b² = 1}),

so `χ(F²) ≤ χ(UD(𝔽_p, 2))`. This module states the plane (`fplane p`) and the reduction **in the
certificate's own vocabulary**: a `Valid` certificate (M04, exact tower arithmetic) whose denominator is
nonzero modulo `p` reduces, through any ring hom `Q4 →+* ZMod p`, to a graph homomorphism
`edgeGraph n c.edges →g fplane p`. The one non-trivial step of the hand proof — the `𝔭`-integrality of
unit vectors — is here the hypothesis `φ c.denom ≠ 0`, a decidable fact about the certificate rather
than a valuation argument; the field-level statement (every finite unit-distance graph in `F²` is so
presentable after a translation) is priced in `plans/M58-field-sieve.md` §S3 and not proved.

## Whose work this is

The bound is the web session's derivation (Kooshi, 2026-09-06), verified in `VERIFICATION.md`; the
finite Euclidean graphs are Medrano–Myers–Stark–Terras (1996) and Vinh (2005). Ours is the statement
over certificates, the kernel proof, and the instances (`Instances/FPlane11.lean`).

## What a consumer may conclude

`UDCert.colorable_of_fplane`: a `k`-colouring of the plane pulls back to the certificate's graph — an
UPPER bound on a certified witness. `UDCert.not_colorable_fplane`: a certified refusal of `k` colours
pushes forward — a LOWER bound on the plane. Nothing here says anything about `χ(ℝ²)`.
-/

namespace HadwigerNelson

open SimpleGraph

/-! ### The plane -/

/-- **The finite Euclidean plane** `UD(𝔽_p, 2)`: the Cayley graph of `ZMod p × ZMod p` whose connection
set is the unit circle `a² + b² = 1`. Mathlib's `addCayley` symmetrises and strips loops, so this is a
`SimpleGraph` for every `p`, usable or not. -/
def fplane (p : ℕ) : SimpleGraph (ZMod p × ZMod p) :=
  addCayley {v : ZMod p × ZMod p | v.1 ^ 2 + v.2 ^ 2 = 1}

/-- Adjacency in the plane is unit quadrance — the reasoning surface; never unfold `fplane`. -/
theorem fplane_adj {p : ℕ} {u v : ZMod p × ZMod p} :
    (fplane p).Adj u v ↔ u ≠ v ∧ (u.1 - v.1) ^ 2 + (u.2 - v.2) ^ 2 = 1 := by
  sorry

/-- The plane's adjacency computes: `decide` reaches every finite statement about a `fplane p`. -/
instance fplane.instDecidableRel (p : ℕ) : DecidableRel (fplane p).Adj :=
  fun _ _ => decidable_of_iff _ fplane_adj.symm

/-! ### Residue homs out of the tower -/

namespace Adjoin

variable {K : Type*} [CommRing K] [NatScalar K] {d : ℕ}

/-- `Adjoin.eval` with its target generalized from `ℝ` to any commutative ring: given a base hom and a
root `r` of `d` in `R`, send `⟨a, b⟩ ↦ f a + f b · r`. A `RingHom` exactly because `r ^ 2 = d`. Stated
here rather than by editing `Field/Quadratic.lean`, which every certificate module imports. -/
def evalHom {R : Type*} [CommRing R] (f : K →+* R) (r : R) (hr : r ^ 2 = d) : Adjoin d K →+* R where
  toFun x := f x.re + f x.im * r
  map_one' := by sorry
  map_mul' x y := by sorry
  map_zero' := by sorry
  map_add' x y := by sorry

@[simp] theorem evalHom_apply {R : Type*} [CommRing R] (f : K →+* R) (r : R) (hr : r ^ 2 = d)
    (x : Adjoin d K) : evalHom f r hr x = f x.re + f x.im * r := rfl

end Adjoin

/-- **The residue hom of the tower** at a prime `p` where every radicand has a square root: `√3 ↦ r₃`,
`√5 ↦ r₅`, `√7 ↦ r₇`, `√11 ↦ r₁₁`. Exists exactly for the primes where all four are residues (131 is the
first usable one for de Grey's field); `Instances/FPlane11.lean` handles `p = 11`, where `√7` has none. -/
def Q4.resHom (p : ℕ) (r₃ r₅ r₇ r₁₁ : ZMod p) (h₃ : r₃ ^ 2 = 3) (h₅ : r₅ ^ 2 = 5) (h₇ : r₇ ^ 2 = 7)
    (h₁₁ : r₁₁ ^ 2 = 11) : Q4 →+* ZMod p :=
  Adjoin.evalHom (Adjoin.evalHom (Adjoin.evalHom (Adjoin.evalHom (Int.castRingHom (ZMod p))
    r₃ (by simpa using h₃)) r₅ (by simpa using h₅)) r₇ (by simpa using h₇)) r₁₁ (by simpa using h₁₁)

/-! ### The reduction of a certificate -/

namespace UDCert

variable {n p : ℕ}

/-- The residue of a stored point: the coordinates through `φ`, divided by the residue of the
denominator. Meaningful when `φ c.denom ≠ 0`; `reduce_adj` demands exactly that. -/
def reduce (c : UDCert n) (φ : Q4 →+* ZMod p) (i : Fin n) : ZMod p × ZMod p :=
  (φ (c.verts i).x * (φ (c.denom : Q4))⁻¹, φ (c.verts i).y * (φ (c.denom : Q4))⁻¹)

/-- **The reduction theorem, one edge.** A stored unit distance `distSq = denom²` in the tower, pushed
through `φ` and divided by `φ(denom)²`, is unit quadrance in `𝔽_p²`; distinctness of the images is the
same identity read at `0 ≠ 1`. -/
theorem reduce_adj [Fact p.Prime] (c : UDCert n) (φ : Q4 →+* ZMod p) (hv : c.Valid = true)
    (hD : φ (c.denom : Q4) ≠ 0) {i j : Fin n} (h : (edgeGraph n c.edges).Adj i j) :
    (fplane p).Adj (c.reduce φ i) (c.reduce φ j) := by
  sorry

/-- **The reduction, as a graph homomorphism.** -/
def reduceHom [Fact p.Prime] (c : UDCert n) (φ : Q4 →+* ZMod p) (hv : c.Valid = true)
    (hD : φ (c.denom : Q4) ≠ 0) : edgeGraph n c.edges →g fplane p where
  toFun := c.reduce φ
  map_rel' h := c.reduce_adj φ hv hD h

/-- **Upper bounds pull back**: a `k`-colouring of the plane is a `k`-colouring of the certified graph. -/
theorem colorable_of_fplane [Fact p.Prime] (c : UDCert n) (φ : Q4 →+* ZMod p) (hv : c.Valid = true)
    (hD : φ (c.denom : Q4) ≠ 0) {k : ℕ} (hk : (fplane p).Colorable k) :
    (edgeGraph n c.edges).Colorable k :=
  Colorable.of_hom (c.reduceHom φ hv hD) hk

/-- **Lower bounds push forward**: a certified refusal of `k` colours on the graph is a refusal on the
plane. This is how the kernel's `χ(UD(𝔽₁₁, 2)) ≥ 5` is obtained from Heule-510 with no new certificate. -/
theorem not_colorable_fplane [Fact p.Prime] (c : UDCert n) (φ : Q4 →+* ZMod p) (hv : c.Valid = true)
    (hD : φ (c.denom : Q4) ≠ 0) {k : ℕ} (hk : ¬ (edgeGraph n c.edges).Colorable k) :
    ¬ (fplane p).Colorable k :=
  fun h => hk (c.colorable_of_fplane φ hv hD h)

/-- The numeral form of `not_colorable_fplane`. -/
theorem add_one_le_chromaticNumber_fplane [Fact p.Prime] (c : UDCert n) (φ : Q4 →+* ZMod p)
    (hv : c.Valid = true) (hD : φ (c.denom : Q4) ≠ 0) {k : ℕ}
    (hk : ¬ (edgeGraph n c.edges).Colorable k) : (k + 1 : ℕ) ≤ (fplane p).chromaticNumber := by
  sorry

end UDCert

/-! ### Spec

The plane at `p = 3` is the smallest usable one (χ = 3): its circle has four points and `(0,0)–(0,1)` is
an edge; the hypotheses of `reduce_adj` are load-bearing — a certificate whose denominator vanishes
mod `p` reduces to a loop, which `fplane` strips. -/

section Spec

example : (fplane 3).Adj (0, 0) (0, 1) := by decide
example : ¬ (fplane 3).Adj (0, 0) (1, 1) := by decide
example : ¬ (fplane 3).Adj (0, 0) (0, 0) := by decide

/-- The unit pair `(0,0)`, `(11,0)` at denominator `11`: valid, and its reduction at `p = 11` collapses
both points to the origin — `hD` fails and so does the conclusion. -/
private def unitPair11 : UDCert 2 where
  verts := ![⟨0, 0⟩, ⟨11, 0⟩]
  edges := [(0, 1)]
  denom := 11

instance : Fact (Nat.Prime 11) := ⟨by decide⟩

example : unitPair11.Valid = true := by decide
example : (unitPair11.reduce (Q4.resHom 11 5 4 0 0 (by decide) (by decide) sorry (by decide)) 0) =
    (unitPair11.reduce (Q4.resHom 11 5 4 0 0 (by decide) (by decide) sorry (by decide)) 1) := by
  sorry

end Spec

end HadwigerNelson

import Proofs.HadwigerNelson.UnitQuadrance

/-!
# The lift: lower bounds pull back along an injective drawing, and the first obstruction to lifting

M59 (`plans/M59-finite-plane-lift.md`). `UDCert.drawing_adj` (M58) sends a valid certificate INTO
`unitQuadrance R` — the direction that carries upper bounds. This module states the other direction:

* **The lift theorem.** If the drawing is injective and a graph `H` on `R × R` lies inside the image
  (`H ≤ (edgeGraph n c.edges).map f`), then `χ(H) ≤ χ(edgeGraph n c.edges)`. A subgraph `H` of the finite
  plane that refuses `k` colours and is covered by a certificate's drawing therefore certifies
  `χ(ℝ²) ≥ k + 1` through `add_one_le_chromaticNumber_of_valid` — the shape any lifted 6-forcer would take.
* **The level-`p²` obstruction.** A framework `H` in `𝔽_p²` (integer reference positions `x₀`, an edge set
  `E`) lifts to `(ℤ/p²)²` with every edge of quadrance `1` only if, for every self-stress `λ` of `H`
  (scalars on edges whose weighted edge-vector sum vanishes mod `p` at every vertex), the pairing
  `Σ_e λ_e · (Q(x₀_e) − 1)` is `0` mod `p²`. Contrapositive: one stress with a nonzero pairing and `H` has
  no lift, mod `p²` already — hence none in `ℤ_p²`, hence none in any number field with a degree-one
  prime above `p`. This is the linear-algebra face of the lift problem (`plans/M59-finite-plane-lift.md`
  §S1), and a nonzero pairing is a `decide`-scale certificate on a concrete core.

Everything here is stated over `ℤ` (positions) and `ℕ` (the prime) with divisibility, so that an
instance is integer arithmetic the kernel evaluates; nothing about `p` being prime is used.
-/

namespace HadwigerNelson

open SimpleGraph

section LiftTheorem

variable {V W : Type*} {G : SimpleGraph V} {H : SimpleGraph W}

/-- **Colourings pull back along an injective image.** If `H` sits inside the image of `G` under an
injection `f`, a `k`-colouring of `G` colours `H`: colour `f v` by `v`'s colour, and every vertex outside
the image (isolated in `H`, since `H ≤ G.map f`) by any colour. `Nonempty V` supplies that colour. -/
theorem Colorable.of_le_map [Nonempty V] {f : V → W} (hf : Function.Injective f) (hH : H ≤ G.map f)
    {k : ℕ} (hG : G.Colorable k) : H.Colorable k := by
  sorry

/-- **The lift theorem, abstractly.** `χ(H) ≤ χ(G)` whenever `H ≤ G.map f` for an injection `f`. -/
theorem chromaticNumber_le_of_le_map [Nonempty V] {f : V → W} (hf : Function.Injective f)
    (hH : H ≤ G.map f) :
    H.chromaticNumber ≤ G.chromaticNumber := by
  sorry

end LiftTheorem

namespace UDCert

variable {n : ℕ} {R : Type*} [CommRing R]

/-- **The lift theorem for certificates.** A valid certificate whose drawing into `R × R` is injective
covers every graph `H` on `R × R` below the drawing's image; such an `H` bounds the certificate's chromatic
number from below. With `H` a subgraph of `finitePlane p` refusing `k` colours, this is the whole content
of "a lift of a `(k+1)`-critical finite-plane subgraph is a `(k+1)`-chromatic unit-distance graph". -/
theorem chromaticNumber_le_of_drawing [Nontrivial R] (c : UDCert n) {S : Subring Q4} (φ : S →+* R)
    (hS : c.CoordsIn S) {u : R} (hinj : Function.Injective (c.drawing φ hS u)) (hn : 0 < n)
    (H : SimpleGraph (R × R)) (hH : H ≤ (edgeGraph n c.edges).map (c.drawing φ hS u)) :
    H.chromaticNumber ≤ (edgeGraph n c.edges).chromaticNumber := by
  sorry

/-- **A lifted `(k+1)`-forcer forces the plane.** The composite any lifted core would consume: the finite
graph `H` refuses `k` colours, the certificate covers it injectively, and the certificate is valid with a
nonzero denominator — so `χ(ℝ²) ≥ k + 1`. -/
theorem add_one_le_chromaticNumber_plane_of_lift [Nontrivial R] (c : UDCert n) {S : Subring Q4}
    (φ : S →+* R) (hS : c.CoordsIn S) {u : R} (hinj : Function.Injective (c.drawing φ hS u)) (hn : 0 < n)
    (H : SimpleGraph (R × R)) (hH : H ≤ (edgeGraph n c.edges).map (c.drawing φ hS u))
    (hd : c.denom ≠ 0) (hv : c.Valid = true) {k : ℕ} (hk : ¬ H.Colorable k) :
    (k + 1 : ℕ) ≤ (unitDistance ℂ).chromaticNumber := by
  sorry

end UDCert

section Obstruction

/-- The quadrance of an integer vector. -/
def quadZ (d : ℤ × ℤ) : ℤ := d.1 ^ 2 + d.2 ^ 2

variable {V : Type*} [Fintype V] [DecidableEq V]

/-- The net stress at a vertex `v`: the weighted sum of outgoing edge vectors minus incoming, from integer
reference positions `x₀`; a self-stress mod `p` has every net stress divisible by `p` componentwise. -/
def netStress (E : Finset (V × V)) (x₀ : V → ℤ × ℤ) (lam : V × V → ℤ) (v : V) : ℤ × ℤ :=
  (∑ e ∈ E, (if e.1 = v then lam e else 0) * (x₀ e.1 - x₀ e.2).1
      - ∑ e ∈ E, (if e.2 = v then lam e else 0) * (x₀ e.1 - x₀ e.2).1,
   ∑ e ∈ E, (if e.1 = v then lam e else 0) * (x₀ e.1 - x₀ e.2).2
      - ∑ e ∈ E, (if e.2 = v then lam e else 0) * (x₀ e.1 - x₀ e.2).2)

/-- **A self-stress mod `p`**: every vertex's net stress vanishes mod `p`. -/
def IsStressMod (p : ℕ) (E : Finset (V × V)) (x₀ : V → ℤ × ℤ) (lam : V × V → ℤ) : Prop :=
  ∀ v, (p : ℤ) ∣ (netStress E x₀ lam v).1 ∧ (p : ℤ) ∣ (netStress E x₀ lam v).2

/-- **The stress pairing**: `Σ_e λ_e · (Q(x₀_e) − 1)`, the first-order obstruction. -/
def stressPairing (E : Finset (V × V)) (x₀ : V → ℤ × ℤ) (lam : V × V → ℤ) : ℤ :=
  ∑ e ∈ E, lam e * (quadZ (x₀ e.1 - x₀ e.2) - 1)

/-- **The level-`p²` obstruction.** Positions `x ≡ x₀ (mod p)` with every edge of quadrance `≡ 1 (mod p²)`
force the pairing of every mod-`p` self-stress to vanish mod `p²`. Proof shape: with `x = x₀ + p·y`,
`Q(x_e) − Q(x₀_e) = 2p⟨D̂_e, y_u − y_v⟩ + p²|y_u − y_v|²`; summing against `λ` and regrouping by vertex,
the middle term is `2p Σ_v ⟨netStress v, y_v⟩ ≡ 0 (mod p²)`. -/
theorem stressPairing_dvd_of_lift (p : ℕ) (E : Finset (V × V)) (x₀ : V → ℤ × ℤ) (lam : V × V → ℤ)
    (hlam : IsStressMod p E x₀ lam) (x : V → ℤ × ℤ)
    (hx : ∀ v, (p : ℤ) ∣ (x v).1 - (x₀ v).1 ∧ (p : ℤ) ∣ (x v).2 - (x₀ v).2)
    (hunit : ∀ e ∈ E, ((p : ℤ) ^ 2) ∣ quadZ (x e.1 - x e.2) - 1) :
    ((p : ℤ) ^ 2) ∣ stressPairing E x₀ lam := by
  sorry

/-- **No lift** — the contrapositive in the form an instance cites: a stress whose pairing is not divisible
by `p²` refutes every candidate lift at once. -/
theorem no_lift_of_stressPairing (p : ℕ) (E : Finset (V × V)) (x₀ : V → ℤ × ℤ) (lam : V × V → ℤ)
    (hlam : IsStressMod p E x₀ lam) (hb : ¬ ((p : ℤ) ^ 2) ∣ stressPairing E x₀ lam) (x : V → ℤ × ℤ)
    (hx : ∀ v, (p : ℤ) ∣ (x v).1 - (x₀ v).1 ∧ (p : ℤ) ∣ (x v).2 - (x₀ v).2) :
    ∃ e ∈ E, ¬ ((p : ℤ) ^ 2) ∣ quadZ (x e.1 - x e.2) - 1 := by
  sorry

end Obstruction

/-! ## Spec: the obstruction on a three-point frame, and the theorem's hypotheses seen load-bearing

At `p = 3` the points `0, (1,0), (2,0)` are pairwise at quadrance `≡ 1`: a triangle of the finite plane
`UD(𝔽₃, 2)` that no real unit triangle reduces to (its three vertices are collinear). The stress
`λ = (1, 1, −1)`... — the pairing and its residue are pinned here once the theorems are proved; the
skeleton records the shape. -/
section Spec

/-- The collinear triangle of `UD(𝔽₃,2)`: `0 → (1,0) → (2,0)` and the closing edge `0 → (2,0)`. -/
def tri3E : Finset (Fin 3 × Fin 3) := {(0, 1), (1, 2), (0, 2)}

def tri3x : Fin 3 → ℤ × ℤ := ![(0, 0), (1, 0), (2, 0)]

example : ∀ e ∈ tri3E, (3 : ℤ) ∣ quadZ (tri3x e.1 - tri3x e.2) - 1 := by decide

end Spec

end HadwigerNelson

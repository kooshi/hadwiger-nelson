import Proofs.HadwigerNelson.UnitQuadrance

/-!
# The lift: lower bounds pull back along an injective drawing, and the first-order obstruction to lifting

M59 (`plans/M59-finite-plane-lift.md`). `UDCert.drawing_adj` (M58) sends a valid certificate INTO
`unitQuadrance R` — the direction that carries upper bounds. This module states the other direction, in
two theorems.

* **The lift theorem.** If a drawing is injective and a graph `H` on `R × R` lies inside its image
  (`H ≤ (edgeGraph n c.edges).map (c.drawing φ hS u)`), then `χ(H) ≤ χ(edgeGraph n c.edges)`. A subgraph
  `H` of the finite plane refusing `k` colours and covered by a certificate therefore certifies
  `χ(ℝ²) ≥ k + 1` through `add_one_le_chromaticNumber_of_valid` — the shape any lifted 6-forcer takes.
* **The first-order obstruction.** In any commutative ring with an element `π` of square zero, a
  *stressed framework* — a list of weighted edges `(u, v, λ)` over reference positions `x₀`, with
  `π • netStress = 0` at every vertex — has no deformation `x = x₀ + π • y` with every edge of quadrance
  `1` unless the **stress pairing** `Σ λ · (quad (x₀ u − x₀ v) − 1)` vanishes. At `R = ZMod (p²)`,
  `π = p` this is the level-`p²` obstruction to lifting a subgraph of `UD(𝔽_p, 2)`: the residue class of
  `x₀` is exactly `x₀ + p • y`, and a certificate drawn at level `p²` that agrees with `x₀` modulo `p`
  is such a deformation (`drawing_map`). At `R = ZMod (p^(k+1))`, `π = p^k` with `x₀` a level-`k`
  solution it is the level-`(k+1)` obstruction: the whole Hensel tower is this one theorem.

The obstruction theorem is first-order rigidity theory (the dual numbers `R[π]/π²` as the tangent
space of the realization variety); nothing about `p` being prime is used anywhere.
-/

namespace HadwigerNelson

open SimpleGraph

section LiftTheorem

variable {V W : Type*} {G : SimpleGraph V} {H : SimpleGraph W}

/-- **Colourings pull back along an injective image.** If `H` sits inside the image of `G` under an
injection `f`, a `k`-colouring of `G` colours `H`: colour `f v` by `v`'s colour, and every vertex outside
the image (isolated in `H`, since `H ≤ G.map f`) by any colour — `Nonempty V` supplies one. Without it
the statement fails: an empty `V` and a nonempty `W` give `H = ⊥` on `W`, `1`-chromatic, above `χ(G) = 0`. -/
theorem Colorable.of_le_map [Nonempty V] {f : V → W} (hf : Function.Injective f) (hH : H ≤ G.map f)
    {k : ℕ} (hG : G.Colorable k) : H.Colorable k := by
  sorry

/-- **The lift theorem, abstractly.** `χ(H) ≤ χ(G)` whenever `H ≤ G.map f` for an injection `f`. -/
theorem chromaticNumber_le_of_le_map [Nonempty V] {f : V → W} (hf : Function.Injective f)
    (hH : H ≤ G.map f) : H.chromaticNumber ≤ G.chromaticNumber :=
  chromaticNumber_le_of_forall_imp fun _ => Colorable.of_le_map hf hH

end LiftTheorem

/-- The quadrance of a vector of `R × R`. `unitQuadrance_adj` reads `quad (u - v) = 1`. -/
def quad {R : Type*} [CommRing R] (d : R × R) : R := d.1 ^ 2 + d.2 ^ 2

theorem quad_eq_one_of_adj {R : Type*} [CommRing R] {u v : R × R} (h : (unitQuadrance R).Adj u v) :
    quad (u - v) = 1 := by
  sorry

namespace UDCert

variable {n : ℕ} {R R' : Type*} [CommRing R] [CommRing R']

/-- **The drawing is natural in the ring**: a ring hom applied coordinatewise to a drawing is the drawing
through the composite hom. This is what relates a certificate's drawing at level `p` to its drawing at
level `p²`. -/
theorem drawing_map (c : UDCert n) {S : Subring Q4} (φ : S →+* R) (hS : c.CoordsIn S) (u : R)
    (g : R →+* R') (i : Fin n) :
    Prod.map g g (c.drawing φ hS u i) = c.drawing (g.comp φ) hS (g u) i := by
  sorry

/-- **The lift theorem for certificates.** A valid certificate whose drawing into `R × R` is injective
covers every graph `H` on `R × R` below the drawing's image; such an `H` bounds the certificate's chromatic
number from below. With `H` a subgraph of `finitePlane p` refusing `k` colours, this is the whole content
of "a lift of a `(k+1)`-critical finite-plane subgraph is a `(k+1)`-chromatic unit-distance graph". -/
theorem chromaticNumber_le_of_drawing (c : UDCert n) {S : Subring Q4} (φ : S →+* R)
    (hS : c.CoordsIn S) {u : R} (hinj : Function.Injective (c.drawing φ hS u)) (hn : 0 < n)
    (H : SimpleGraph (R × R)) (hH : H ≤ (edgeGraph n c.edges).map (c.drawing φ hS u)) :
    H.chromaticNumber ≤ (edgeGraph n c.edges).chromaticNumber :=
  have : Nonempty (Fin n) := ⟨⟨0, hn⟩⟩
  chromaticNumber_le_of_le_map hinj hH

/-- **A lifted `(k+1)`-forcer forces the plane.** The composite any lifted core would consume: the finite
graph `H` refuses `k` colours, the certificate covers it injectively, and the certificate is valid with a
nonzero denominator — so `χ(ℝ²) ≥ k + 1`. -/
theorem add_one_le_chromaticNumber_plane_of_lift (c : UDCert n) {S : Subring Q4}
    (φ : S →+* R) (hS : c.CoordsIn S) {u : R} (hinj : Function.Injective (c.drawing φ hS u)) (hn : 0 < n)
    (H : SimpleGraph (R × R)) (hH : H ≤ (edgeGraph n c.edges).map (c.drawing φ hS u))
    (hd : c.denom ≠ 0) (hv : c.Valid = true) {k : ℕ} (hk : ¬ H.Colorable k) :
    (k + 1 : ℕ) ≤ (unitDistance ℂ).chromaticNumber := by
  sorry

end UDCert

section Obstruction

variable {V : Type*} [Fintype V] [DecidableEq V] {R : Type*} [CommRing R]

/-- A **stressed framework**: a list of weighted edges `(u, v, λ)`. The positions are supplied
separately, as `x₀ : V → R × R`; the edge vector of `(u, v, _)` is `x₀ u - x₀ v`. -/
abbrev StressedEdges (V R : Type*) := List (V × V × R)

/-- The net stress at a vertex: the weighted sum of the edge vectors leaving `v` minus those entering. -/
def netStress (L : StressedEdges V R) (x₀ : V → R × R) (v : V) : R × R :=
  (L.map fun e => (if e.1 = v then e.2.2 else 0) • (x₀ e.1 - x₀ e.2.1)
      - (if e.2.1 = v then e.2.2 else 0) • (x₀ e.1 - x₀ e.2.1)).sum

/-- **A self-stress modulo `π`**: `π` kills the net stress at every vertex. At `R = ZMod (p²)`, `π = p`
this says the residues of the weights form a self-stress of the residue framework in `𝔽_p²`. -/
def IsStress (π : R) (L : StressedEdges V R) (x₀ : V → R × R) : Prop :=
  ∀ v, π • netStress L x₀ v = 0

instance [DecidableEq R] (π : R) (L : StressedEdges V R) (x₀ : V → R × R) :
    Decidable (IsStress π L x₀) :=
  Fintype.decidableForallFintype

/-- **The stress pairing**: `Σ λ · (quad (x₀ u − x₀ v) − 1)`, the first-order obstruction. -/
def stressPairing (L : StressedEdges V R) (x₀ : V → R × R) : R :=
  (L.map fun e => e.2.2 * (quad (x₀ e.1 - x₀ e.2.1) - 1)).sum

/-- **The first-order obstruction.** With `π² = 0`, a deformation `x₀ + π • y` of a stressed framework
along which every listed edge has quadrance `1` forces the stress pairing to vanish. Proof shape:
`quad (x₀ e + π • y e) − 1 = (quad (x₀ e) − 1) + 2π⟨x₀ e, y e⟩` since `π² = 0`; summing against the
weights and regrouping by vertex (summation by parts along the edge list), the second term is
`2 Σ_v ⟨π • netStress v, y v⟩ = 0`. -/
theorem stressPairing_eq_zero_of_lift {π : R} (hπ : π ^ 2 = 0) (L : StressedEdges V R)
    (x₀ y : V → R × R) (hs : IsStress π L x₀)
    (hunit : ∀ e ∈ L, quad ((x₀ e.1 + π • y e.1) - (x₀ e.2.1 + π • y e.2.1)) = 1) :
    stressPairing L x₀ = 0 := by
  sorry

/-- **No lift** — the contrapositive in the form an instance cites: a stress with a nonzero pairing refutes
every deformation at once. -/
theorem no_lift_of_stressPairing_ne_zero {π : R} (hπ : π ^ 2 = 0) (L : StressedEdges V R)
    (x₀ : V → R × R) (hs : IsStress π L x₀) (hb : stressPairing L x₀ ≠ 0) (y : V → R × R) :
    ∃ e ∈ L, quad ((x₀ e.1 + π • y e.1) - (x₀ e.2.1 + π • y e.2.1)) ≠ 1 := by
  sorry

end Obstruction

section ResidueClass

/-- **The residue class is the deformation space.** In `ZMod (p²)` two elements with the same residue
modulo `p` differ by a multiple of `p`. This is the bridge from "a drawing agrees with `x₀` modulo `p`" to
the hypothesis shape of `stressPairing_eq_zero_of_lift`. -/
theorem ZMod.exists_smul_of_castHom_eq (p : ℕ) {a b : ZMod (p ^ 2)}
    (h : ZMod.castHom (dvd_pow_self p two_ne_zero) (ZMod p) a
      = ZMod.castHom (dvd_pow_self p two_ne_zero) (ZMod p) b) :
    ∃ t : ZMod (p ^ 2), a = b + (p : ℕ) • t := by
  sorry

/-- `p² = 0` in `ZMod (p²)`: the square-zero element of the level-`p²` instance. -/
theorem ZMod.natCast_sq_eq_zero (p : ℕ) : ((p : ZMod (p ^ 2)) ^ 2 : ZMod (p ^ 2)) = 0 := by
  sorry

end ResidueClass

/-! ## Spec: a real framework passes, the collinear triangle of `UD(𝔽₃, 2)` does not

The closed hex shell — a point and its six unit neighbours, twelve unit edges, one self-stress — lifts (it
is a real configuration), so its pairing is zero at every prime where it reduces. The three points
`0, (1,0), (2,0)` are pairwise at quadrance `≡ 1 (mod 3)` — a triangle of `UD(𝔽₃,2)` that no real unit
triangle reduces to (its vertices are collinear) — and the stress `(2, 2, −1)` has pairing `−3 ≠ 0` in
`ZMod 9`: the framework has no lift even modulo `9`. Both decided once the theorems are proved; the
skeleton records the data. -/
section Spec

/-- The collinear triangle of `UD(𝔽₃,2)` with the stress `(2, 2, −1)`, over `ZMod 9`. -/
def tri3 : StressedEdges (Fin 3) (ZMod 9) := [(0, 1, 2), (1, 2, 2), (0, 2, 8)]

def tri3x : Fin 3 → ZMod 9 × ZMod 9 := ![(0, 0), (1, 0), (2, 0)]

example : ∀ e ∈ tri3, quad (tri3x e.1 - tri3x e.2.1) - 1 = 0 ∨
    quad (tri3x e.1 - tri3x e.2.1) - 1 = 3 := by decide
example : IsStress (3 : ZMod 9) tri3 tri3x := by decide
example : stressPairing tri3 tri3x = 6 := by decide

end Spec

end HadwigerNelson

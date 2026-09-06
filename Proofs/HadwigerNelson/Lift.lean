import Proofs.HadwigerNelson.UnitQuadrance

/-!
# The lift: lower bounds pull back along an injective drawing, and the first-order obstruction to lifting

M59 (`plans/M59-finite-plane-lift.md`). `UDCert.drawing_adj` (M58) sends a valid certificate INTO
`unitQuadrance R` — the direction that carries upper bounds. This module states the other direction, in
two theorems.

* **The lift theorem.** If a drawing is injective and a graph `H` on `R × R` lies inside its image
  (`H ≤ (edgeGraph n c.edges).map (c.drawing φ hS u)`), then `χ(H) ≤ χ(edgeGraph n c.edges)`. A subgraph
  `H` of the finite plane refusing `k` colours and covered by a certificate therefore certifies
  `χ(ℝ²) ≥ k + 1` (`UDCert.add_one_le_chromaticNumber_plane_of_lift`) — the shape any lifted 6-forcer
  takes.
* **The first-order obstruction.** In any commutative ring with an element `π` of square zero, a
  *stressed framework* — positions `x₀ : V → R × R` and a list of weighted edges `⟨src, dst, wt⟩` with
  `π • netStress = 0` at every vertex — admits no **lift** `x₀ + π • y` with every listed edge of
  quadrance `1` unless the **stress pairing** `Σ wt · (quad (x₀ src − x₀ dst) − 1)` vanishes. At
  `R = ZMod (p²)`, `π = p` this is the level-`p²` obstruction to lifting a subgraph of `UD(𝔽_p, 2)`: the
  residue class of `x₀` is exactly `x₀ + p • y`, and a certificate drawn at level `p²` whose residues agree
  with `x₀` is such a lift (`UDCert.stressPairing_eq_zero_of_drawing`). At `R = ZMod (p^(k+1))`, `π = p^k`
  with `x₀` a level-`k` solution it is the level-`(k+1)` obstruction: the whole Hensel tower is this one
  theorem. A stress supported on a sub-framework is a stress of the whole, and a lift restricts, so one
  small sub-framework with a nonzero pairing refutes every lift of a large core — that is what a kernel
  instance exhibits.

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

/-- The quadrance of a vector of `R × R`; `unitQuadrance_adj` reads `quad (u - v) = 1`. -/
def quad {R : Type*} [CommRing R] (d : R × R) : R := d.1 ^ 2 + d.2 ^ 2

/-- Adjacent points of `unitQuadrance R` differ by a vector of quadrance one. -/
theorem quad_eq_one_of_adj {R : Type*} [CommRing R] {u v : R × R} (h : (unitQuadrance R).Adj u v) :
    quad (u - v) = 1 := by
  sorry

namespace UDCert

variable {n : ℕ} {R R' : Type*} [CommRing R] [CommRing R']

/-- **The drawing is natural in the ring**: a ring hom applied coordinatewise to a drawing is the drawing
through the composite hom. This relates a certificate's drawing at level `p` to its drawing at level `p²`. -/
@[simp] theorem drawing_map (c : UDCert n) {S : Subring Q4} (φ : S →+* R) (hS : c.CoordsIn S) (u : R)
    (g : R →+* R') (i : Fin n) :
    Prod.map g g (c.drawing φ hS u i) = c.drawing (g.comp φ) hS (g u) i := by
  sorry

/-- **The lift theorem for certificates.** A valid certificate whose drawing into `R × R` is injective
covers every graph `H` on `R × R` below the drawing's image; such an `H` bounds the certificate's chromatic
number from below. -/
theorem chromaticNumber_le_of_drawing (c : UDCert n) {S : Subring Q4} (φ : S →+* R)
    (hS : c.CoordsIn S) {u : R} (hinj : Function.Injective (c.drawing φ hS u)) (hn : 0 < n)
    (H : SimpleGraph (R × R)) (hH : H ≤ (edgeGraph n c.edges).map (c.drawing φ hS u)) :
    H.chromaticNumber ≤ (edgeGraph n c.edges).chromaticNumber :=
  have : Nonempty (Fin n) := ⟨⟨0, hn⟩⟩
  chromaticNumber_le_of_le_map hinj hH

/-- **A lifted `(k+1)`-forcer forces the plane — the recipe.** Hold a graph `H` on `R × R` (a subgraph of
`finitePlane p`, say) that refuses `k` colours (`hk`: an LRAT refutation of `H` as an edge list, transported
along the isomorphism — the one hypothesis a certificate does not decide), a valid tower certificate `c` with a
nonzero denominator, a hom `φ` out of a subring holding its coordinates with an inverse `u` of the denominator,
and check that the drawing is injective and that every edge of `H` is the image of a certificate edge
(`hH`; both decide on a concrete certificate). Then `χ(ℝ²) ≥ k + 1`. -/
theorem add_one_le_chromaticNumber_plane_of_lift (c : UDCert n) {S : Subring Q4}
    (φ : S →+* R) (hS : c.CoordsIn S) {u : R} (hinj : Function.Injective (c.drawing φ hS u)) (hn : 0 < n)
    (H : SimpleGraph (R × R)) (hH : H ≤ (edgeGraph n c.edges).map (c.drawing φ hS u))
    (hd : c.denom ≠ 0) (hv : c.Valid = true) {k : ℕ} (hk : ¬ H.Colorable k) :
    (k + 1 : ℕ) ≤ (unitDistance ℂ).chromaticNumber := by
  sorry

end UDCert

section Obstruction

variable {V : Type*} [DecidableEq V] {R : Type*} [CommRing R]

/-- A **weighted edge** of a framework: source, target, and the weight a self-stress assigns it. -/
structure StressedEdge (V R : Type*) where
  src : V
  dst : V
  wt : R

/-- The net stress at a vertex `v` of the framework `x₀` under the weights `L`: the weighted sum of the
edge vectors `x₀ src − x₀ dst` leaving `v` minus those entering `v`. -/
def netStress (x₀ : V → R × R) (L : List (StressedEdge V R)) (v : V) : R × R :=
  (L.map fun e => (if e.src = v then e.wt else 0) • (x₀ e.src - x₀ e.dst)
      - (if e.dst = v then e.wt else 0) • (x₀ e.src - x₀ e.dst)).sum

@[simp] theorem netStress_nil (x₀ : V → R × R) (v : V) : netStress x₀ [] v = 0 := rfl

@[simp] theorem netStress_cons (x₀ : V → R × R) (e : StressedEdge V R) (L : List (StressedEdge V R))
    (v : V) :
    netStress x₀ (e :: L) v = ((if e.src = v then e.wt else 0) • (x₀ e.src - x₀ e.dst)
      - (if e.dst = v then e.wt else 0) • (x₀ e.src - x₀ e.dst)) + netStress x₀ L v := by
  sorry

variable [Fintype V]

/-- **A self-stress modulo `π`**: `π` kills the net stress at every vertex. At `R = ZMod (p²)`, `π = p` this
says the residues of the weights form a self-stress of the residue framework in `𝔽_p²`. -/
def IsStress (π : R) (x₀ : V → R × R) (L : List (StressedEdge V R)) : Prop :=
  ∀ v, π • netStress x₀ L v = 0

instance [DecidableEq R] (π : R) (x₀ : V → R × R) (L : List (StressedEdge V R)) :
    Decidable (IsStress π x₀ L) :=
  Fintype.decidableForallFintype

/-- **A lift** of the framework `x₀` along `y`, to first order in `π`: every listed edge of the deformed
positions `x₀ + π • y` has quadrance one. At `R = ZMod (p²)`, `π = p`, the deformations `x₀ + p • y` are
exactly the configurations with the residues of `x₀`, so `IsLift p x₀ L y` says "a lift modulo `p²`". -/
def IsLift (π : R) (x₀ y : V → R × R) (L : List (StressedEdge V R)) : Prop :=
  ∀ e ∈ L, quad ((x₀ e.src + π • y e.src) - (x₀ e.dst + π • y e.dst)) = 1

/-- **The stress pairing** `Σ wt · (quad (x₀ src − x₀ dst) − 1)`: the first-order obstruction. -/
def stressPairing (x₀ : V → R × R) (L : List (StressedEdge V R)) : R :=
  (L.map fun e => e.wt * (quad (x₀ e.src - x₀ e.dst) - 1)).sum

/-- The bilinear form on `R × R` in which the first-order term of `quad` is written. -/
def dot (a b : R × R) : R := a.1 * b.1 + a.2 * b.2

@[simp] theorem dot_zero_left (b : R × R) : dot (0 : R × R) b = 0 := by sorry
theorem dot_add_left (a a' b : R × R) : dot (a + a') b = dot a b + dot a' b := by sorry
theorem dot_sub_left (a a' b : R × R) : dot (a - a') b = dot a b - dot a' b := by sorry
theorem dot_smul_left (c : R) (a b : R × R) : dot (c • a) b = c * dot a b := by sorry
theorem dot_sub_right (a b b' : R × R) : dot a (b - b') = dot a b - dot a b' := by sorry

/-- **The first-order expansion of the quadrance**: the per-edge identity the obstruction rests on. -/
theorem quad_add_smul (a b : R × R) (π : R) :
    quad (a + π • b) = quad a + 2 * π * dot a b + π ^ 2 * quad b := by
  sorry

/-- **Summation by parts along the edge list**: the weighted edge vectors against the coboundary of `y`
regroup as the net stresses against `y`. The one induction of the module — on the list. -/
theorem sum_dot_eq_sum_netStress (x₀ y : V → R × R) (L : List (StressedEdge V R)) :
    (L.map fun e => e.wt * dot (x₀ e.src - x₀ e.dst) (y e.src - y e.dst)).sum
      = ∑ v, dot (netStress x₀ L v) (y v) := by
  sorry

/-- **The first-order obstruction.** With `π² = 0`, a lift of a stressed framework forces its stress pairing
to vanish. Proof shape: `quad (x₀ e + π • y e) − 1 = (quad (x₀ e) − 1) + 2π⟨x₀ e, y e⟩` since `π² = 0`;
summing against the weights and regrouping by vertex, the second term is `2 Σ_v ⟨π • netStress v, y v⟩ = 0`.

What a nonzero pairing licenses: the framework has no lift along any `y` in this ring — at `ZMod (p²)`
no lift modulo `p²`. Restricting a stress to a sub-framework (weight zero elsewhere) keeps it a stress, and a
lift restricts, so a nonzero pairing on a SMALL sub-framework refutes every lift of a large one. -/
theorem stressPairing_eq_zero_of_lift {π : R} (hπ : π ^ 2 = 0) {x₀ y : V → R × R}
    {L : List (StressedEdge V R)} (hs : IsStress π x₀ L) (hy : IsLift π x₀ y L) :
    stressPairing x₀ L = 0 := by
  sorry

/-- **No lift**: the headline in the form an instance cites — a stress with a nonzero pairing refutes every
lift at once. -/
theorem not_exists_lift_of_stressPairing_ne_zero {π : R} (hπ : π ^ 2 = 0) {x₀ : V → R × R}
    {L : List (StressedEdge V R)} (hs : IsStress π x₀ L) (hb : stressPairing x₀ L ≠ 0) :
    ¬ ∃ y : V → R × R, IsLift π x₀ y L := by
  sorry

end Obstruction

section ResidueClass

/-- **The residue** of a point of `(ℤ/p²)²` in `𝔽_p²`. -/
def residue (p : ℕ) (x : ZMod (p ^ 2) × ZMod (p ^ 2)) : ZMod p × ZMod p :=
  Prod.map (ZMod.castHom (dvd_pow_self p two_ne_zero) (ZMod p))
    (ZMod.castHom (dvd_pow_self p two_ne_zero) (ZMod p)) x

/-- **The residue class is the deformation space.** In `ZMod (p²)` two elements with the same residue
modulo `p` differ by a multiple of `p`. -/
theorem ZMod.exists_eq_add_mul_of_castHom_eq (p : ℕ) {a b : ZMod (p ^ 2)}
    (h : ZMod.castHom (dvd_pow_self p two_ne_zero) (ZMod p) a
      = ZMod.castHom (dvd_pow_self p two_ne_zero) (ZMod p) b) :
    ∃ t : ZMod (p ^ 2), a = b + (p : ZMod (p ^ 2)) * t := by
  sorry

/-- `p² = 0` in `ZMod (p²)`: the square-zero element of the level-`p²` instance. -/
theorem ZMod.natCast_sq_eq_zero (p : ℕ) : ((p : ZMod (p ^ 2)) ^ 2 : ZMod (p ^ 2)) = 0 := by
  sorry

end ResidueClass

namespace UDCert

variable {V : Type*} [Fintype V] [DecidableEq V] {n : ℕ}

/-- **A certificate drawn at level `p²` cannot cover an obstructed framework.** A valid tower certificate
drawn through a hom into `ZMod (p²)`, whose residues agree with `x₀` on the framework's vertices and whose
edges cover the framework's, is a lift `x₀ + p • y` — so every self-stress pairs to zero.

What an instance certifies through this theorem: no valid certificate over the tower `Q4`, drawn at level
`p²` through any hom out of any subring holding its coordinates with an inverse of its denominator, covers the
framework with matching residues. What it does not say: anything about other number fields, or about
configurations not presentable as tower certificates. The statement "no lift at any `p`-adic level, hence
none in any number field with a degree-one prime above `p`" is the hand derivation
(`plans/M59-finite-plane-lift.md` §S1), of which this theorem is the level-`p²` face. -/
theorem stressPairing_eq_zero_of_drawing (p : ℕ) [Nontrivial (ZMod (p ^ 2))] (c : UDCert n)
    {S : Subring Q4} (φ : S →+* ZMod (p ^ 2)) (hS : c.CoordsIn S) {u : ZMod (p ^ 2)}
    (hu : u * c.denom = 1) (hv : c.Valid = true) (g : V → Fin n)
    {x₀ : V → ZMod (p ^ 2) × ZMod (p ^ 2)} {L : List (StressedEdge V (ZMod (p ^ 2)))}
    (hs : IsStress (p : ZMod (p ^ 2)) x₀ L)
    (hres : ∀ v, residue p (c.drawing φ hS u (g v)) = residue p (x₀ v))
    (hE : ∀ e ∈ L, (edgeGraph n c.edges).Adj (g e.src) (g e.dst)) :
    stressPairing x₀ L = 0 := by
  sorry

end UDCert

/-! ## Spec: a real framework passes, the collinear triangle of `UD(𝔽₃, 2)` does not

The closed hex shell — a point and its six unit neighbours, twelve unit edges, one self-stress (rim `+1`,
spokes `−1`) — is a real configuration; at `p = 11` its residues are below and its pairing is `0` in
`ZMod 121`, though its twelve edge defects `(quad − 1)/11` are `0, 3, 4, 0, 3, 3, 9, 8, 8, 0, 9, 8`: a genuine
cancellation. The three points `0, (1,0), (2,0)` are pairwise at quadrance `≡ 1 (mod 3)` — a triangle of
`UD(𝔽₃,2)` that no real unit triangle reduces to (its vertices are collinear) — and the stress `(2, 2, −1)`
pairs to `6 = −3 ≠ 0` in `ZMod 9`: the framework has no lift even modulo `9`. -/
section Spec

/-- The closed hex shell reduced at `11`: the origin and `ζ^k`, `ζ = 6 + 3i` a primitive sixth root of unity
on the circle of `𝔽₁₁(i)`. -/
def hex11x : Fin 7 → ZMod 121 × ZMod 121 :=
  ![(0, 0), (1, 0), (6, 3), (5, 3), (10, 0), (5, 8), (6, 8)]

/-- Its twelve edges with the self-stress: spokes `−1 = 120`, rim `+1`. -/
def hex11 : List (StressedEdge (Fin 7) (ZMod 121)) :=
  [⟨0, 1, 120⟩, ⟨1, 2, 1⟩, ⟨0, 2, 120⟩, ⟨2, 3, 1⟩, ⟨0, 3, 120⟩, ⟨3, 4, 1⟩,
   ⟨0, 4, 120⟩, ⟨4, 5, 1⟩, ⟨0, 5, 120⟩, ⟨5, 6, 1⟩, ⟨0, 6, 120⟩, ⟨6, 1, 1⟩]

example : ∀ e ∈ hex11, (11 : ZMod 121) * (quad (hex11x e.src - hex11x e.dst) - 1) = 0 := by decide
example : IsStress (11 : ZMod 121) hex11x hex11 := by decide
example : stressPairing hex11x hex11 = 0 := by decide

/-- The collinear triangle of `UD(𝔽₃,2)` with the stress `(2, 2, −1)`, over `ZMod 9`. -/
def tri3x : Fin 3 → ZMod 9 × ZMod 9 := ![(0, 0), (1, 0), (2, 0)]

def tri3 : List (StressedEdge (Fin 3) (ZMod 9)) := [⟨0, 1, 2⟩, ⟨1, 2, 2⟩, ⟨0, 2, 8⟩]

example : ∀ e ∈ tri3, (3 : ZMod 9) * (quad (tri3x e.src - tri3x e.dst) - 1) = 0 := by decide
example : IsStress (3 : ZMod 9) tri3x tri3 := by decide
example : stressPairing tri3x tri3 = 6 := by decide

end Spec

end HadwigerNelson

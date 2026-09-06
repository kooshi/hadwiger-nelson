import Proofs.HadwigerNelson.Lift

/-!
# The first obstruction instance: a ≥ 5-chromatic subgraph of `UD(𝔽₁₃₁, 2)` that is not a shadow

M59 (`plans/M59-finite-plane-lift.md` §R). De Grey's 1581-vertex graph reduces at the prime above 131 of its field
onto 1,547 residue classes (34 pairs of vertices collide). Its **merged image** — the 1,547 residues with the union of
the colliding vertices' edges, 7,876 edges — is a subgraph of the finite plane and, as the image of a graph
homomorphism, at least 5-chromatic. It is NOT the shadow of any unit-distance configuration: the instrument
(`tools/fplift.py local --degrey --p 131 --merge`, `data/fplane/lift-degrey1581-p131-merged.json`) found a
self-stress of a 26-vertex, 48-edge sub-framework whose pairing with the defect is `7205 ≠ 0` in `ZMod (131²)`,
and by `not_exists_lift_of_stressPairing_ne_zero` no deformation of those 26 residues has all 48 edges unit modulo
`131²` — hence no lift of the merged image modulo `131²`, hence none in `ℤ₁₃₁²`, hence none in any number field with an
unramified degree-one prime above 131 (the last two steps the hand derivation's, §S1). The kernel decides the stress
condition and the pairing on the literal below; the residues are the instrument's, in `[0, 131)`.

Also here: the finite plane's clique number, pinned at two primes — a unit triangle exists at `11` and none at `19`
(§S2: triangles iff `p ≡ 11 (mod 12)`), which is the `ω` column M58 measured.
-/

namespace HadwigerNelson

open SimpleGraph

set_option maxRecDepth 100000

/-- The 26 residues of the witness sub-framework of the 1581's merged image at 131, as points of `(ℤ/131²)²`. -/
def merged131x : Fin 26 → ZMod (131 ^ 2) × ZMod (131 ^ 2) :=
  ![(96, 15), (14, 88), (109, 0), (60, 58), (47, 73), (129, 0), (40, 100), (25, 107), (73, 78), (1, 68), (11, 116), (129, 124), (22, 32), (16, 61), (99, 90), (76, 22), (97, 117), (21, 18), (77, 21), (31, 15), (80, 73), (53, 113), (14, 89), (123, 122), (28, 79), (41, 64)]

/-- Its 48 weighted edges: a self-stress modulo 131 of the sub-framework. -/
def merged131 : List (StressedEdge (Fin 26) (ZMod (131 ^ 2))) :=
  [⟨0, 1, 110⟩, ⟨0, 2, 109⟩, ⟨0, 3, 49⟩, ⟨0, 4, 16⟩, ⟨0, 11, 128⟩, ⟨0, 12, 61⟩, ⟨0, 13, 47⟩, ⟨0, 14, 11⟩, ⟨0, 17, 122⟩, ⟨1, 2, 124⟩, ⟨1, 16, 84⟩, ⟨2, 3, 33⟩, ⟨2, 15, 87⟩, ⟨3, 4, 82⟩, ⟨3, 10, 82⟩, ⟨4, 5, 98⟩, ⟨4, 10, 49⟩, ⟨5, 10, 82⟩, ⟨5, 18, 113⟩, ⟨5, 20, 64⟩, ⟨6, 8, 39⟩, ⟨6, 13, 92⟩, ⟨6, 16, 92⟩, ⟨7, 8, 17⟩, ⟨7, 9, 98⟩, ⟨7, 12, 33⟩, ⟨7, 14, 94⟩, ⟨7, 15, 114⟩, ⟨8, 12, 20⟩, ⟨8, 13, 24⟩, ⟨8, 15, 67⟩, ⟨8, 16, 15⟩, ⟨9, 11, 70⟩, ⟨9, 14, 53⟩, ⟨11, 19, 74⟩, ⟨17, 18, 122⟩, ⟨18, 21, 122⟩, ⟨18, 24, 130⟩, ⟨18, 25, 130⟩, ⟨19, 20, 64⟩, ⟨19, 21, 35⟩, ⟨19, 22, 32⟩, ⟨19, 23, 121⟩, ⟨21, 22, 99⟩, ⟨22, 23, 99⟩, ⟨23, 24, 130⟩, ⟨23, 25, 130⟩, ⟨24, 25, 1⟩]

/-- Every listed edge is unit modulo 131 (the framework is a subgraph of `UD(𝔽₁₃₁, 2)`). -/
theorem merged131_unit_mod_p :
    ∀ e ∈ merged131, (131 : ZMod (131 ^ 2)) * (quad (merged131x e.src - merged131x e.dst) - 1) = 0 := by
  decide +kernel

theorem merged131_isStress : IsStress (131 : ZMod (131 ^ 2)) merged131x merged131 := by
  decide +kernel

theorem merged131_pairing : stressPairing merged131x merged131 = 7205 := by
  decide +kernel

/-- **The headline**: the witness sub-framework of the 1581's merged image at 131 has no lift modulo `131²` — no
choice of one point per residue class (the deformations `x₀ + 131 • y` are exactly those) makes all 48 edges unit. -/
theorem merged131_no_lift :
    ¬ ∃ y : Fin 26 → ZMod (131 ^ 2) × ZMod (131 ^ 2),
      IsLift (131 : ZMod (131 ^ 2)) merged131x y merged131 :=
  not_exists_lift_of_stressPairing_ne_zero (ZMod.natCast_sq_eq_zero 131) merged131_isStress
    (by rw [merged131_pairing]; decide)

instance : Fact (1 < 131 ^ 2) := ⟨by norm_num⟩

/-- **The certificate form**: no valid tower certificate, drawn at level `131²` through any hom out of any subring with
an inverse of its denominator, covers the witness with matching residues. -/
theorem merged131_no_drawing {n : ℕ} (c : UDCert n) {S : Subring Q4} (φ : S →+* ZMod (131 ^ 2))
    (hS : c.CoordsIn S) {u : ZMod (131 ^ 2)} (hu : u * c.denom = 1) (hv : c.Valid = true)
    (g : Fin 26 → Fin n) (hres : ∀ v, residue 131 (c.drawing φ hS u (g v)) = residue 131 (merged131x v))
    (hE : ∀ e ∈ merged131, (edgeGraph n c.edges).Adj (g e.src) (g e.dst)) : False := by
  have := c.stressPairing_eq_zero_of_drawing 131 φ hS hu hv g merged131_isStress hres hE
  rw [merged131_pairing] at this
  exact absurd this (by decide)

/-! ## The clique number of the finite plane, pinned: a unit triangle at `11`, none at `19` -/

/-- `UD(𝔽₁₁, 2)` has a unit triangle through the origin (`11 ≡ 11 (mod 12)`). -/
theorem finitePlane11_triangle : ∃ a b : ZMod 11 × ZMod 11,
    (finitePlane 11).Adj 0 a ∧ (finitePlane 11).Adj 0 b ∧ (finitePlane 11).Adj a b := by
  decide +kernel

/-- `UD(𝔽₁₉, 2)` is triangle-free (`19 ≡ 7 (mod 12)`): by vertex-transitivity it suffices at the origin. -/
theorem finitePlane19_triangle_free : ¬ ∃ a b : ZMod 19 × ZMod 19,
    (finitePlane 19).Adj 0 a ∧ (finitePlane 19).Adj 0 b ∧ (finitePlane 19).Adj a b := by
  decide +kernel

end HadwigerNelson

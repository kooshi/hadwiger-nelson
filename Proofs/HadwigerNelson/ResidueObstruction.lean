import Proofs.HadwigerNelson.Lift
import Proofs.HadwigerNelson.Arity
import Proofs.HadwigerNelson.PairDist

/-!
# The residue obstruction: what a colouring of the plane forces on everything that reduces into it

A graph `G` with a homomorphism `f` into the unit-quadrance graph `unitQuadrance R` (M58: every valid
certificate over a subring of the tower, through a ring hom out of it, has one) inherits every
`k`-colouring of the plane by pullback. So a pair FORCED equal in every `k`-colouring of `G` is identified
by every colouring of the plane at its images, and a pair SEPARATED by every `k`-colouring of `G` (a
virtual edge) is separated by every colouring of the plane at its images. Two lines, already in the
kernel as `Forces.comap` and `Separated.comap`.

The content is what "every colouring of the plane" costs. Translation `w ↦ w + t` is an automorphism
of `unitQuadrance R` (adjacency depends only on the difference), so ONE colouring table `col` supplies
a colouring for every `t`, and along that orbit the two transfers read, with `d := f v − f u`:

* forced ⟹ `∀ t, col t = col (t + d)` — `d` is a **period** of the table;
* separated ⟹ `∀ t, col t ≠ col (t + d)` — `d` is a **never-coincident difference** of the table.

Hence two decidable properties of a single table settle the transfer completely (`Aperiodic`: no
nonzero period; `CoincidesOffCircle`: every nonzero difference off the unit circle coincides somewhere):
**a forced pair has equal images, and a virtual edge has adjacent images.** At `11` the certified table
of `Instances/FinitePlane11.lean` has both properties (`Instances/ResidueObstruction11.lean`), so over
the `√7`-free subring of the tower a forced-equal pair at five colours has squared distance `≡ 0`
and a virtual edge squared distance `≡ 1` modulo `11` — and the hex-shell distances `√3` and `2`
(`3, 4 ≢ 0, 1` modulo every prime `≥ 5`) can carry neither, over any field whose plane at a usable
prime is 5-colourable. That is the compulsion-level content of "5-sealed" (M58), one gadget at a time.

The same two properties say the plane itself has no arity-2 compulsion beyond its edges
(`forces_iff_eq_of_aperiodic`, `separated_iff_adj_of_coincides`, `three_le_arityFloor_of_aperiodic_coincides`).
-/

namespace HadwigerNelson

open SimpleGraph

variable {R : Type*} [CommRing R] {V : Type*} {G : SimpleGraph V} {k : ℕ}

/-! ### Translations are automorphisms -/

/-- **Translation by `t` is a graph homomorphism** of the unit-quadrance graph: adjacency depends only
on the difference of the two points. (An automorphism, in fact; the homomorphism is all a pullback needs.) -/
def unitQuadrance.translate (t : R × R) : unitQuadrance R →g unitQuadrance R where
  toFun v := v + t
  map_rel' h := by sorry

@[simp] theorem unitQuadrance.translate_apply (t v : R × R) : unitQuadrance.translate t v = v + t := rfl

/-! ### The two properties of a table -/

/-- **No nonzero period**: for every nonzero difference `d` some point and its `d`-translate are coloured
differently. The property a forced-equal pair's image must violate. -/
def Aperiodic (col : R × R → Fin k) : Prop := ∀ d : R × R, d ≠ 0 → ∃ t, col t ≠ col (t + d)

/-- **Every off-circle difference coincides somewhere**: for every nonzero `d` that is not a unit-quadrance
step, some point and its `d`-translate share a colour. The property a virtual edge's image must violate. -/
def CoincidesOffCircle (col : R × R → Fin k) : Prop :=
  ∀ d : R × R, d ≠ 0 → ¬ (unitQuadrance R).Adj 0 d → ∃ t, col t = col (t + d)

instance [Fintype R] [DecidableEq R] (col : R × R → Fin k) : Decidable (Aperiodic col) :=
  inferInstanceAs (Decidable (∀ _, _ → ∃ _, _))

instance [Fintype R] [DecidableEq R] (col : R × R → Fin k) : Decidable (CoincidesOffCircle col) :=
  inferInstanceAs (Decidable (∀ _, _ → _ → ∃ _, _))

/-! ### The transfer -/

/-- **A forced-equal pair has equal images** in any plane coloured by an aperiodic table: if the images
differed by `d ≠ 0`, the translate of the table exhibiting `d` as a non-period, pulled back along `f`, would
separate the pair. -/
theorem eq_of_forces_of_aperiodic (col : (unitQuadrance R).Coloring (Fin k)) (ha : Aperiodic col)
    (f : G →g unitQuadrance R) {u v : V} (h : Forces G k u v) : f u = f v := by
  sorry

/-- **A virtual edge has adjacent images** in any plane coloured by a table coinciding off the circle: equal
images are identified by the table itself, and non-adjacent distinct images by the translate exhibiting the
coincidence. -/
theorem adj_of_separated_of_coincides (col : (unitQuadrance R).Coloring (Fin k))
    (hc : CoincidesOffCircle col) (f : G →g unitQuadrance R) {u v : V} (h : Separated G k u v) :
    (unitQuadrance R).Adj (f u) (f v) := by
  sorry

/-! ### The plane's own compulsions -/

/-- The plane coloured by an aperiodic table forces no pair but the trivial ones. -/
theorem forces_iff_eq_of_aperiodic (col : (unitQuadrance R).Coloring (Fin k)) (ha : Aperiodic col)
    {u v : R × R} : Forces (unitQuadrance R) k u v ↔ u = v := by
  sorry

/-- The plane coloured by a table coinciding off the circle separates no pair but its edges. -/
theorem separated_iff_adj_of_coincides (col : (unitQuadrance R).Coloring (Fin k))
    (hc : CoincidesOffCircle col) {u v : R × R} :
    Separated (unitQuadrance R) k u v ↔ (unitQuadrance R).Adj u v := by
  sorry

/-- **The plane has no arity-2 compulsion at `k` colours** when one table is aperiodic and coincides off
the circle: arity 2 is exactly `Separated`/`Forces` (`compels_two_eq`, `compels_two_ne`), and both are
trivial by the two `iff`s above. -/
theorem three_le_arityFloor_of_aperiodic_coincides (col : (unitQuadrance R).Coloring (Fin k))
    (ha : Aperiodic col) (hc : CoincidesOffCircle col) : 3 ≤ arityFloor (unitQuadrance R) k := by
  sorry

/-! ### Certificates: the distance law -/

namespace UDCert

variable {n : ℕ}

/-- `coord_quadrance` at class distance `√r`: a pair whose stored squared distance is `r · D²` in `Q4`
satisfies `Δx·Δx + Δy·Δy = r · D²` inside the subring. -/
theorem coord_distSq (c : UDCert n) {S : Subring Q4} (hS : c.CoordsIn S) {i j : Fin n} {r : ℤ}
    (hp : (c.verts i).distSq (c.verts j) = ((r * (c.denom * c.denom) : ℤ) : Q4)) :
    ((c.coord hS i).1 - (c.coord hS j).1) * ((c.coord hS i).1 - (c.coord hS j).1) +
      ((c.coord hS i).2 - (c.coord hS j).2) * ((c.coord hS i).2 - (c.coord hS j).2) =
      ((r * (c.denom * c.denom) : ℤ) : S) := by
  sorry

/-- **The distance law.** A pair at stored squared distance `r · D²` is drawn at quadrance `r` — the
identity `drawing_adj` uses at `r = 1`, for every `r`. -/
theorem drawing_quad (c : UDCert n) {S : Subring Q4} (φ : S →+* R) (hS : c.CoordsIn S) {u : R}
    (hu : u * c.denom = 1) {i j : Fin n} {r : ℤ}
    (hp : (c.verts i).distSq (c.verts j) = ((r * (c.denom * c.denom) : ℤ) : Q4)) :
    quad (c.drawing φ hS u i - c.drawing φ hS u j) = (r : R) := by
  sorry

/-- **A pair whose squared distance is not `0` in `R` is never forced equal** at `k` colours, for any
`k` at which the plane over `R` is coloured by an aperiodic table. -/
theorem not_forces_of_distSq [Nontrivial R] (c : UDCert n) {S : Subring Q4} (φ : S →+* R)
    (hS : c.CoordsIn S) {u : R} (hu : u * c.denom = 1) (hv : c.Valid = true)
    (col : (unitQuadrance R).Coloring (Fin k)) (ha : Aperiodic col) {i j : Fin n} {r : ℤ}
    (hp : (c.verts i).distSq (c.verts j) = ((r * (c.denom * c.denom) : ℤ) : Q4)) (hr : (r : R) ≠ 0) :
    ¬ Forces (edgeGraph n c.edges) k i j := by
  sorry

/-- **A pair whose squared distance is not `1` in `R` is never a virtual edge** at `k` colours, for any
`k` at which the plane over `R` is coloured by a table coinciding off the circle. -/
theorem not_separated_of_distSq [Nontrivial R] (c : UDCert n) {S : Subring Q4} (φ : S →+* R)
    (hS : c.CoordsIn S) {u : R} (hu : u * c.denom = 1) (hv : c.Valid = true)
    (col : (unitQuadrance R).Coloring (Fin k)) (hc : CoincidesOffCircle col) {i j : Fin n} {r : ℤ}
    (hp : (c.verts i).distSq (c.verts j) = ((r * (c.denom * c.denom) : ℤ) : Q4)) (hr : (r : R) ≠ 1) :
    ¬ Separated (edgeGraph n c.edges) k i j := by
  sorry

/-- `not_forces_of_distSq` for a pair listed in a `PairsAt` certificate. -/
theorem not_forces_of_pairsAt [Nontrivial R] (c : UDCert n) {S : Subring Q4} (φ : S →+* R)
    (hS : c.CoordsIn S) {u : R} (hu : u * c.denom = 1) (hv : c.Valid = true)
    (col : (unitQuadrance R).Coloring (Fin k)) (ha : Aperiodic col) {ps : List (Fin n × Fin n)} {r : ℤ}
    (hps : c.PairsAt ps r = true) {i j : Fin n} (hmem : (i, j) ∈ ps) (hr : (r : R) ≠ 0) :
    ¬ Forces (edgeGraph n c.edges) k i j :=
  c.not_forces_of_distSq φ hS hu hv col ha ((c.pairsAt_iff ps r).mp hps (i, j) hmem) hr

/-- `not_separated_of_distSq` for a pair listed in a `PairsAt` certificate. -/
theorem not_separated_of_pairsAt [Nontrivial R] (c : UDCert n) {S : Subring Q4} (φ : S →+* R)
    (hS : c.CoordsIn S) {u : R} (hu : u * c.denom = 1) (hv : c.Valid = true)
    (col : (unitQuadrance R).Coloring (Fin k)) (hc : CoincidesOffCircle col) {ps : List (Fin n × Fin n)}
    {r : ℤ} (hps : c.PairsAt ps r = true) {i j : Fin n} (hmem : (i, j) ∈ ps) (hr : (r : R) ≠ 1) :
    ¬ Separated (edgeGraph n c.edges) k i j :=
  c.not_separated_of_distSq φ hS hu hv col hc ((c.pairsAt_iff ps r).mp hps (i, j) hmem) hr

end UDCert

end HadwigerNelson

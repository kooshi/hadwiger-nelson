import Proofs.HadwigerNelson.Lift
import Proofs.HadwigerNelson.Arity
import Proofs.HadwigerNelson.PairDist
import Mathlib.Algebra.Ring.Periodic

/-!
# The residue obstruction: compulsions map forward, and a Cayley graph coloured by one good table has none

A graph `G` with a homomorphism `f` into a graph `P` inherits every `k`-colouring of `P` by pullback, so a
pair forced equal in every `k`-colouring of `G` is forced equal in `P` at its images, and a pair separated
by every colouring of `G` (a virtual edge) is separated in `P` at its images: **compulsions map forward
along homomorphisms** (`Forces.image`, `Separated.image` — `Forces.comap` and `Separated.comap` read as
statements about `P`).

On a Cayley graph `addCayley S` of an abelian group the translations are automorphisms (Mathlib's
`addCayley_adj_add_iff_right`), so every compulsion reduces to the origin (`forces_iff_forces_zero`,
`separated_iff_separated_zero`), and an origin compulsion at `d` is refuted by ONE colouring: `Forces P k 0 d`
fails as soon as some colouring `C` has `C (t + d) ≠ C t` for some `t` — as soon as `d` is not a period of `C`
(`Function.Periodic`); `Separated P k 0 d` fails as soon as some colouring coincides at `d` somewhere.
Two decidable properties of a single table therefore settle the whole compulsion structure of the graph at
arity 2: **`Aperiodic col`** (no nonzero period) gives `Forces P k x y ↔ x = y`, and **`CoincidesAtNonedges P col`**
(every nonzero non-edge difference coincides somewhere) gives `Separated P k x y ↔ P.Adj x y`; together they
put the arity floor of `P` at `k` colours at `3` or above.

The finite plane `UD(𝔽_p, 2) = unitQuadrance (ZMod p)` is `addCayley` of the circle by definition. At `11` the
certified table of `Instances/FinitePlane11.lean` has both properties (`Instances/ResidueObstruction11.lean`),
so for every `√7`-free tower certificate with `11 ∤ D`: a pair forced equal at five colours has equal
residues — the residue of its squared distance is `0` — and a virtual edge has adjacent residues — the residue
of its squared distance is `1` (`Forces.quad_image_eq_zero`, `Separated.quad_image_eq_one`, through
`UDCert.drawing_quad`: the quadrance of a drawn difference IS the residue of the stored squared distance).
The hex-shell distances `√3` and `2` (`3, 4 ≢ 0, 1` modulo every prime `≥ 5`) can therefore carry neither
compulsion over any field whose plane at a usable prime is 5-colourable. That is the compulsion-level
content of "5-sealed" (M58), one gadget at a time.
-/

namespace HadwigerNelson

open SimpleGraph

variable {V W : Type*} {G : SimpleGraph V} {P : SimpleGraph W} {k : ℕ}

/-! ### Compulsions map forward along homomorphisms -/

/-- **A forced pair's image is forced.** `Forces.comap` read as a statement about the target graph. -/
theorem Forces.image (f : G →g P) {u v : V} (h : Forces G k u v) : Forces P k (f u) (f v) :=
  fun C => h.comap f C

/-- **A virtual edge's image is a virtual edge.** -/
theorem Separated.image (f : G →g P) {u v : V} (h : Separated G k u v) : Separated P k (f u) (f v) :=
  fun C => h.comap f C

/-! ### Cayley graphs: translations reduce every compulsion to the origin -/

variable {A : Type*} [AddCommGroup A] {S : Set A}

/-- **Translation by `t` is a homomorphism** (an automorphism) of the Cayley graph: adjacency depends only
on the difference (`addCayley_adj_add_iff_right`). -/
def addCayley.translate (S : Set A) (t : A) : addCayley S →g addCayley S where
  toFun v := t + v
  map_rel' h := (addCayley_adj_add_iff_right).mpr h

@[simp] theorem addCayley.translate_apply (t v : A) : addCayley.translate S t v = t + v := rfl

/-- A forced pair of a Cayley graph is forced at the origin, by its difference. -/
theorem forces_iff_forces_zero {x y : A} :
    Forces (addCayley S) k x y ↔ Forces (addCayley S) k 0 (y - x) := by
  sorry

/-- A virtual edge of a Cayley graph is a virtual edge at the origin, by its difference. -/
theorem separated_iff_separated_zero {x y : A} :
    Separated (addCayley S) k x y ↔ Separated (addCayley S) k 0 (y - x) := by
  sorry

/-! ### One table refutes one origin compulsion -/

/-- **`d` is forced at the origin only if it is a period of every colouring**: a colouring with `C (t + d) ≠ C t`
somewhere, translated so that `t` sits at the origin, separates `0` from `d`. -/
theorem not_forces_zero_of_not_periodic (col : (addCayley S).Coloring (Fin k)) {d : A}
    (h : ¬ Function.Periodic col d) : ¬ Forces (addCayley S) k 0 d := by
  sorry

/-- **`d` is separated at the origin only if no colouring ever coincides at it**: a colouring with
`C (t + d) = C t`, translated so that `t` sits at the origin, identifies `0` and `d`. -/
theorem not_separated_zero_of_coincides (col : (addCayley S).Coloring (Fin k)) {d : A}
    (h : ∃ t, col (t + d) = col t) : ¬ Separated (addCayley S) k 0 d := by
  sorry

/-! ### The two properties of a table -/

/-- **No nonzero period.** The property whose failure at `d` a forced-equal pair with difference `d` needs. -/
def Aperiodic (col : A → Fin k) : Prop := ∀ d, Function.Periodic col d → d = 0

/-- **Every nonzero non-edge difference coincides somewhere.** The property whose failure at `d` a virtual
edge with difference `d` needs. -/
def CoincidesAtNonedges (P : SimpleGraph A) (col : A → Fin k) : Prop :=
  ∀ d, d ≠ 0 → ¬ P.Adj 0 d → ∃ t, col (t + d) = col t

instance [Fintype A] [DecidableEq A] (col : A → Fin k) : Decidable (Aperiodic col) :=
  inferInstanceAs (Decidable (∀ d, (∀ x, col (x + d) = col x) → d = 0))

instance [Fintype A] [DecidableEq A] (P : SimpleGraph A) [DecidableRel P.Adj] (col : A → Fin k) :
    Decidable (CoincidesAtNonedges P col) :=
  inferInstanceAs (Decidable (∀ _, _ → _ → ∃ _, _))

/-! ### A Cayley graph coloured by one good table has no arity-2 compulsion -/

/-- **Forced pairs are trivial** when one colouring is aperiodic. -/
theorem forces_iff_eq_of_aperiodic (col : (addCayley S).Coloring (Fin k)) (ha : Aperiodic col) {x y : A} :
    Forces (addCayley S) k x y ↔ x = y := by
  sorry

/-- **Virtual edges are edges** when one colouring coincides at every non-edge difference. -/
theorem separated_iff_adj_of_coincides (col : (addCayley S).Coloring (Fin k))
    (hc : CoincidesAtNonedges (addCayley S) col) {x y : A} :
    Separated (addCayley S) k x y ↔ (addCayley S).Adj x y := by
  sorry

/-- **No arity-2 compulsion at `k` colours**: arity 2 is exactly `Separated`/`Forces` (`compels_two_eq`,
`compels_two_ne`), and both are trivial by the two `iff`s. -/
theorem three_le_arityFloor_of_aperiodic_coincides (col : (addCayley S).Coloring (Fin k))
    (ha : Aperiodic col) (hc : CoincidesAtNonedges (addCayley S) col) :
    3 ≤ arityFloor (addCayley S) k := by
  sorry

/-! ### The transfer, composed -/

/-- **A forced-equal pair has equal images** in a Cayley graph with an aperiodic colouring. -/
theorem Forces.image_eq_of_aperiodic (col : (addCayley S).Coloring (Fin k)) (ha : Aperiodic col)
    (f : G →g addCayley S) {u v : V} (h : Forces G k u v) : f u = f v :=
  (forces_iff_eq_of_aperiodic col ha).mp (h.image f)

/-- **A virtual edge has adjacent images** in a Cayley graph with a colouring coinciding at non-edges. -/
theorem Separated.image_adj_of_coincides (col : (addCayley S).Coloring (Fin k))
    (hc : CoincidesAtNonedges (addCayley S) col) (f : G →g addCayley S) {u v : V}
    (h : Separated G k u v) : (addCayley S).Adj (f u) (f v) :=
  (separated_iff_adj_of_coincides col hc).mp (h.image f)

/-! ### The plane: the distance law at the level of quadrance -/

variable {R : Type*} [CommRing R]

/-- **Forced equal ⟹ the image difference has quadrance `0`.** -/
theorem Forces.quad_image_eq_zero (col : (unitQuadrance R).Coloring (Fin k)) (ha : Aperiodic col)
    (f : G →g unitQuadrance R) {u v : V} (h : Forces G k u v) : quad (f u - f v) = 0 := by
  sorry

/-- **A virtual edge ⟹ the image difference has quadrance `1`.** -/
theorem Separated.quad_image_eq_one (col : (unitQuadrance R).Coloring (Fin k))
    (hc : CoincidesAtNonedges (unitQuadrance R) col) (f : G →g unitQuadrance R) {u v : V}
    (h : Separated G k u v) : quad (f u - f v) = 1 := by
  sorry

/-! ### Certificates: the quadrance of a drawn difference is the residue of the stored squared distance -/

namespace UDCert

variable {n : ℕ}

/-- **The drawn difference's quadrance**, for any pair: `u² · φ(Δx·Δx + Δy·Δy)`, the stored squared distance
read in the subring, through `φ`, scaled by the denominator's inverse squared. (`drawing_adj` is the case
where the stored value is `D²` and `u · D = 1`.) -/
theorem drawing_quad (c : UDCert n) {S : Subring Q4} (φ : S →+* R) (hS : c.CoordsIn S) (u : R)
    (i j : Fin n) :
    quad (c.drawing φ hS u i - c.drawing φ hS u j) =
      u ^ 2 * φ (((c.coord hS i).1 - (c.coord hS j).1) * ((c.coord hS i).1 - (c.coord hS j).1) +
        ((c.coord hS i).2 - (c.coord hS j).2) * ((c.coord hS i).2 - (c.coord hS j).2)) := by
  sorry

/-- `coord_quadrance` at class distance `√r`: a pair stored at squared distance `r · D²` in `Q4` satisfies
`Δx·Δx + Δy·Δy = r · D²` inside the subring. -/
theorem coord_distSq (c : UDCert n) {S : Subring Q4} (hS : c.CoordsIn S) {i j : Fin n} {r : ℤ}
    (hp : (c.verts i).distSq (c.verts j) = ((r * (c.denom * c.denom) : ℤ) : Q4)) :
    ((c.coord hS i).1 - (c.coord hS j).1) * ((c.coord hS i).1 - (c.coord hS j).1) +
      ((c.coord hS i).2 - (c.coord hS j).2) * ((c.coord hS i).2 - (c.coord hS j).2) =
      ((r * (c.denom * c.denom) : ℤ) : S) := by
  sorry

/-- **The distance law.** A pair stored at squared distance `r · D²` is drawn at quadrance `r`. -/
theorem drawing_quad_of_distSq (c : UDCert n) {S : Subring Q4} (φ : S →+* R) (hS : c.CoordsIn S) {u : R}
    (hu : u * c.denom = 1) {i j : Fin n} {r : ℤ}
    (hp : (c.verts i).distSq (c.verts j) = ((r * (c.denom * c.denom) : ℤ) : Q4)) :
    quad (c.drawing φ hS u i - c.drawing φ hS u j) = (r : R) := by
  sorry

/-- **A pair whose squared distance is not `0` in `R` is never forced equal** at `k` colours, whenever the
plane over `R` has an aperiodic `k`-colouring. -/
theorem not_forces_of_distSq [Nontrivial R] (c : UDCert n) {S : Subring Q4} (φ : S →+* R)
    (hS : c.CoordsIn S) {u : R} (hu : u * c.denom = 1) (hv : c.Valid = true)
    (col : (unitQuadrance R).Coloring (Fin k)) (ha : Aperiodic col) {i j : Fin n} {r : ℤ}
    (hp : (c.verts i).distSq (c.verts j) = ((r * (c.denom * c.denom) : ℤ) : Q4)) (hr : (r : R) ≠ 0) :
    ¬ Forces (edgeGraph n c.edges) k i j := by
  sorry

/-- **A pair whose squared distance is not `1` in `R` is never a virtual edge** at `k` colours, whenever the
plane over `R` has a `k`-colouring coinciding at every non-edge difference. -/
theorem not_separated_of_distSq [Nontrivial R] (c : UDCert n) {S : Subring Q4} (φ : S →+* R)
    (hS : c.CoordsIn S) {u : R} (hu : u * c.denom = 1) (hv : c.Valid = true)
    (col : (unitQuadrance R).Coloring (Fin k)) (hc : CoincidesAtNonedges (unitQuadrance R) col)
    {i j : Fin n} {r : ℤ}
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
    (col : (unitQuadrance R).Coloring (Fin k)) (hc : CoincidesAtNonedges (unitQuadrance R) col)
    {ps : List (Fin n × Fin n)} {r : ℤ} (hps : c.PairsAt ps r = true) {i j : Fin n} (hmem : (i, j) ∈ ps)
    (hr : (r : R) ≠ 1) : ¬ Separated (edgeGraph n c.edges) k i j :=
  c.not_separated_of_distSq φ hS hu hv col hc ((c.pairsAt_iff ps r).mp hps (i, j) hmem) hr

end UDCert

end HadwigerNelson

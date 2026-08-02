import Proofs.HadwigerNelson.Field.Approx
import Proofs.HadwigerNelson.Certificate
import Proofs.HadwigerNelson.Critical
import Proofs.HadwigerNelson.Fan

/-! # No fan confined to one distance — the certified negative

M15 found the only five-colour fans in existence: four pivots of de Grey's unshrunk 1581-vertex
graph. The closing move needs a fan **confined to a single real distance** from its pivot
(`not_colorable_of_spindled_fan`), and M16's sweep answered that none of the four is — every one of
the 1,340 equidistance classes at every pivot is separated by an explicit proper 5-colouring, eight
colourings per pivot sufficing.

This module is the checker that turns those colourings into the kernel-checked statement

> *no list of vertices, not containing the pivot, all at one real distance from it, carries a fan,*

and the statement is about **real** distances, not their `Q4` representations — the gap between the
two is exactly what `Field/Approx.lean` closes: the certificate carries the class values sorted,
their intervals pairwise disjoint, so equal real distances force equal classes and one colouring
per class covers every equidistant partner list.

Everything the emitter writes is untrusted. The colourings, the class table, the hints and the
generator bounds are all data; `NarrowCert.check` is the single `Bool` the kernel decides, and
`NarrowCert.sound` is the once-proved bridge from that `Bool` to the headline. A wrong table makes
`check` false; it cannot make a theorem false.
-/

namespace HadwigerNelson

/-- A `bits`-wide field read out of a packed `Nat` — `unpackColor` without the colour bound, for
class ids and hints, where the range check is the consumer's lookup coming back `none`. -/
def unpackNat (bits packed i : ℕ) : ℕ := (packed >>> (bits * i)) % 2 ^ bits

/-- **Every listed edge is bichromatic** under the packed colouring — full properness, against the
graph the fan lives on. Listed self-loops are skipped exactly as `edgeGraph` strips them. -/
def properColouring {n : ℕ} (E : List (Fin n × Fin n)) (bits k col : ℕ) : Bool :=
  E.all fun e => e.1 == e.2 || unpackColor bits k col e.1.val != unpackColor bits k col e.2.val

/-- A packed colouring that survives `properColouring` is a colouring of the edge-list graph, and
its values are readable back — the readable form is what separation arguments consume. -/
theorem exists_coloring_of_proper {n : ℕ} {E : List (Fin n × Fin n)} {bits k col : ℕ}
    (hk : 0 < k) (h : properColouring E bits k col = true) :
    ∃ C : (edgeGraph n E).Coloring (Fin k),
      ∀ v : Fin n, (C v).val = unpackColor bits k col v.val := sorry

/-- **The narrow-fan certificate**: everything the emitter claims about one pivot, as data.

The class structure is three claims — every non-pivot vertex's exact squared distance to the pivot
is `classVals[classId v]` (binding), the `classVals` are pairwise-distinct reals (separation, via
`Field/Approx`), and per class one committed colouring separates the whole class from the pivot
(coverage). `hints` is per-class, not per-vertex, deliberately: a per-vertex hint would let two
same-class vertices cite different colourings, which un-proves exactly the union step the headline
needs. -/
structure NarrowCert (n : ℕ) where
  /-- The pivot the fans sit at. -/
  pivot : Fin n
  /-- The colour count the fan question is asked at. -/
  k : ℕ
  /-- Field width of one colour in a packed colouring. -/
  bits : ℕ
  /-- Field width of one class id in `classIds`. -/
  idBits : ℕ
  /-- Field width of one hint in `hints`. -/
  hintBits : ℕ
  /-- Rational intervals for the four generators, checked by `SqrtBounds.Ok`. -/
  bounds : SqrtBounds
  /-- The distinct squared distances from the pivot, ascending in real value — the emitter's
  claim, verified by `sepChain`. -/
  classVals : List Q4
  /-- Packed: each vertex's index into `classVals`. -/
  classIds : ℕ
  /-- Packed: each class's index into `colourings`. -/
  hints : ℕ
  /-- The separating colourings, each `bits` per vertex. -/
  colourings : List ℕ

namespace NarrowCert

variable {n : ℕ}

/-- One vertex's obligations: its class id resolves, the resolved value **is** its exact squared
distance to the pivot, and the class's hinted colouring separates it from the pivot. -/
def checkVertex (c : NarrowCert n) (verts : Fin n → Pt) (v : Fin n) : Bool :=
  let i := unpackNat c.idBits c.classIds v.val
  match c.classVals[i]? with
  | none => false
  | some d =>
    decide ((verts v).distSq (verts c.pivot) = d) &&
    match c.colourings[unpackNat c.hintBits c.hints i]? with
    | none => false
    | some col =>
      unpackColor c.bits c.k col v.val != unpackColor c.bits c.k col c.pivot.val

/-- **The whole certificate, one `Bool`**: generator bounds check, class values are separated
reals, at least one colouring exists (the empty-`Q` case needs the graph colourable), every
colouring is proper, and every non-pivot vertex passes `checkVertex`. -/
def check (c : NarrowCert n) (verts : Fin n → Pt) (E : List (Fin n × Fin n)) : Bool :=
  c.bounds.Ok &&
  sepChain c.bounds c.classVals &&
  !c.colourings.isEmpty &&
  c.colourings.all (properColouring E c.bits c.k) &&
  (List.finRange n).all fun v => v == c.pivot || c.checkVertex verts v

/-- Equal real distances to the pivot force equal exact squared distances — `eval_distSq` run
backward through `dist`. The only step that touches `ℝ`'s geometry, isolated here. -/
theorem eval_distSq_eq_of_dist_eq {D : ℤ} (hD : D ≠ 0) {p q q' : Pt}
    (h : dist (q.toPlane D) (p.toPlane D) = dist (q'.toPlane D) (p.toPlane D)) :
    Q4.eval (q.distSq p) = Q4.eval (q'.distSq p) := sorry

/-- **Soundness.** A checked certificate refutes every fan over an equidistant partner list:
for every real `r`, no list of vertices avoiding the pivot and all at distance `r` from it is a
fan at the pivot.

The proof's shape: an empty `Q` is refuted by any committed colouring; a nonempty `Q` picks
`q₀ ∈ Q`, every `q ∈ Q` shares `q₀`'s real distance, `eval_distSq_eq_of_dist_eq` and
`index_eq_of_eval_eq` force `classId q = classId q₀`, and the class's hinted colouring separates
all of `Q` at once. -/
theorem sound (c : NarrowCert n) {verts : Fin n → Pt} {E : List (Fin n × Fin n)} {D : ℤ}
    (hD : D ≠ 0) (hk : 0 < c.k) (hchk : c.check verts E = true) :
    ∀ (r : ℝ) (Q : List (Fin n)), c.pivot ∉ Q →
      (∀ q ∈ Q, dist ((verts q).toPlane D) ((verts c.pivot).toPlane D) = r) →
      ¬ Fan (edgeGraph n E) c.k c.pivot Q := sorry

end NarrowCert

/-! ## Specification — the smallest instance that discriminates

Three collinear points at denominator 1: `p = (0,0)` the pivot, `(1,0)` adjacent to it, `(2,0)`
not. Two classes (`distSq 1` and `4`), one 3-colouring separating both, and mutations of every
datum the checker must refuse. -/

private def specVerts : Fin 3 → Pt := ![⟨0, 0⟩, ⟨1, 0⟩, ⟨2, 0⟩]

private def specEdges : List (Fin 3 × Fin 3) := [(0, 1)]

/-- Colours `0, 1, 1` for vertices `0, 1, 2`, packed 2 bits each. -/
private def specColouring : ℕ := 0 + 1 * 4 + 1 * 16

private def specCert : NarrowCert 3 where
  pivot := 0
  k := 3
  bits := 2
  idBits := 1
  hintBits := 1
  bounds := .coarse
  classVals := [1, 4]
  -- vertex 0 (pivot, unread) ↦ 0, vertex 1 ↦ class 0, vertex 2 ↦ class 1
  classIds := 0 + 0 * 2 + 1 * 4
  -- both classes point at colouring 0
  hints := 0
  colourings := [specColouring]

#guard specCert.check specVerts specEdges

-- The discriminating partners, one per datum:
-- an improper colouring (vertex 1 recoloured to the pivot's colour) is refused...
#guard !((({ specCert with colourings := [0 + 0 * 4 + 1 * 16] } : NarrowCert 3)).check
  specVerts specEdges)
-- ...class values out of real order are refused...
#guard !((({ specCert with classVals := [4, 1] } : NarrowCert 3)).check specVerts specEdges)
-- ...a class id binding a vertex to the wrong value is refused...
#guard !((({ specCert with classIds := 0 + 1 * 2 + 1 * 4 } : NarrowCert 3)).check
  specVerts specEdges)
-- ...a hint out of range is refused...
#guard !((({ specCert with hints := 1 + 1 * 2 } : NarrowCert 3)).check specVerts specEdges)
-- ...and a colouring that fails to separate a class is caught by the vertex walk: recolour
-- vertex 2 to the pivot's colour — still proper (2 is isolated), refused by `checkVertex`.
#guard !((({ specCert with colourings := [0 + 1 * 4 + 0 * 16] } : NarrowCert 3)).check
  specVerts specEdges)

/-- The specification's payoff, exactly as a generated module will consume it: no equidistant
partner list is a fan at the pivot, at any real distance. -/
example :
    ∀ (r : ℝ) (Q : List (Fin 3)), (0 : Fin 3) ∉ Q →
      (∀ q ∈ Q, dist ((specVerts q).toPlane 1) ((specVerts 0).toPlane 1) = r) →
      ¬ Fan (edgeGraph 3 specEdges) 3 0 Q :=
  specCert.sound (by decide) (by decide) (by decide +kernel)

end HadwigerNelson

import Proofs.HadwigerNelson.Field.Quadratic
import Proofs.HadwigerNelson.EdgeList
import Mathlib.Analysis.InnerProductSpace.PiL2

/-!
# Unit-distance certificates

A `UDCert n` is what an untrusted generator emits: `n` points with exact `Q4` coordinates, an edge
list over `Fin n`, and a denominator clearing those coordinates to integers. `Valid` is a
**decidable integer identity** — every listed edge has exact squared distance `denom²` — and
`valid_sound` turns that identity into the real `dist … = 1` hypothesis M01's reduction consumes.

A wrong certificate cannot pass: `Valid` is `false` unless the geometry is exactly right, and the
kernel checks it.

## Using this file

```lean
-- 1. the geometry, in chunks (see `valid_of_chunks`; one `decide` per chunk, one chunk per module)
theorem chunk₀ : myCert.ValidOn chunk₀Edges = true := by decide
-- 2. glue them
theorem myCert_valid : myCert.Valid = true := myCert.valid_of_chunks _ (by decide) (by simp [...])
-- 3. the payoff, given non-colourability from M03's SAT bridge
theorem bound := myCert.add_one_le_chromaticNumber_of_valid (by decide) myCert_valid hNotColorable
```

**When `decide` fails, `#eval myCert.badEdges` names the culprits.** `decide` can only say "no", and
at 7877 edges its failure term is unreadable; `badEdges` runs compiled and returns the offending
edges together with the squared distance actually found.

## The scale is the certificate's, not the point's

Coordinates are stored **multiplied by `denom`** so that they are integers. So `Q4.eval` of a stored
coordinate is `denom` times the real one, and a listed edge's stored squared distance is `denom²`
rather than `1`. The plane point therefore *divides*, and that division is the only place
`denom ≠ 0` is needed — which is why the hypothesis appears exactly where it does.

Getting this wrong is not a slow proof but a false theorem: `dist (eval p) (eval q) = 1` is
unprovable for a valid certificate, since those two points are `denom` apart.

## Shape notes

`n` is a **parameter**, not `verts.length`. A field whose type depends on another field's value
(`edges : List (Fin verts.length × _)`) breeds casts the moment M04 generates the data, and it buys
nothing — `Fin n` is also exactly what `add_one_le_chromaticNumber_unitDistance_edgeList` wants.

Measured (`tools/emit_geometry.py`, 60 vertices / 99 edges): an indexed vertex store and a
presentation carrying resolved endpoint pairs cost **the same** under kernel `decide` — the tower
arithmetic dominates, not the lookup.
-/

namespace HadwigerNelson

/-- A point of the plane with exact `Q4` coordinates, stored scaled by a denominator. -/
structure Pt where
  x : Q4
  y : Q4
deriving DecidableEq, Repr

/-- The exact squared distance between two **stored** points, as an element of `Q4`. For points
stored at scale `D`, a real unit distance appears here as `D * D` — see `Pt.toPlane`. -/
def Pt.distSq (p q : Pt) : Q4 :=
  (p.x - q.x) * (p.x - q.x) + (p.y - q.y) * (p.y - q.y)

/-- The actual plane point of a stored point at scale `D`: evaluate the coordinates and undo the
scaling. Named for its destination — it *divides* by `D`, since the stored coordinates are the real
ones multiplied by `D`. -/
noncomputable def Pt.toPlane (p : Pt) (D : ℤ) : ℂ :=
  ⟨Q4.eval p.x / (D : ℝ), Q4.eval p.y / (D : ℝ)⟩

/-- `eval` is a ring hom and `distSq` is a polynomial, so evaluation commutes with it. The whole
number-theoretic content of the milestone is this plus `Real.sq_sqrt` per generator. -/
theorem eval_distSq (p q : Pt) :
    Q4.eval (p.distSq q) =
      (Q4.eval p.x - Q4.eval q.x) ^ 2 + (Q4.eval p.y - Q4.eval q.y) ^ 2 := by
  sorry

/-- **The geometric bridge.** An exact identity `distSq = D²` in `Q4` says the stored points are `D`
apart, hence the plane points are exactly `1` apart. `hD` is consumed by the division. -/
theorem dist_toPlane_eq_one {p q : Pt} {D : ℤ} (hD : D ≠ 0)
    (h : p.distSq q = ((D * D : ℤ) : Q4)) :
    dist (p.toPlane D) (q.toPlane D) = 1 := by
  sorry

/-- A unit-distance certificate on `n` vertices: exact points, an edge list, and a denominator
clearing the coordinates to integers. Emitted by `tools/`, re-verified here. -/
structure UDCert (n : ℕ) where
  verts : Fin n → Pt
  edges : List (Fin n × Fin n)
  /-- The scale: stored coordinates are `denom` times the real ones, so a real unit edge has stored
  squared distance `denom²`. -/
  denom : ℤ

namespace UDCert

variable {n : ℕ}

/-- `denom²`: the stored squared distance of a real unit edge. Named for what it is, so `ValidOn`
reads without a jump. -/
def denomSq (c : UDCert n) : Q4 := ((c.denom * c.denom : ℤ) : Q4)

/-- The certificate check restricted to a sublist of edges — **the unit of work**.

At de Grey's scale the whole edge list cannot go through one `decide`: measured ~0.17 s/edge with
memory linear in the chunk, so all 7877 edges in one `List.all` builds an unaffordable kernel term.
Prove one `ValidOn` per chunk (ideally one chunk per module, so they elaborate in parallel) and glue
with `valid_of_chunks`. -/
def ValidOn (c : UDCert n) (es : List (Fin n × Fin n)) : Bool :=
  es.all fun e => decide ((c.verts e.1).distSq (c.verts e.2) = c.denomSq)

/-- The certificate check: every listed edge is a stored unit distance. -/
def Valid (c : UDCert n) : Bool := c.ValidOn c.edges

/-- `Valid` is `ValidOn` over all the edges, by definition. -/
theorem valid_eq (c : UDCert n) : c.Valid = c.ValidOn c.edges := rfl

/-- The `Prop` reading of `ValidOn` — the bridge out of `Bool`, so downstream proofs never destructure
a `List.all`. -/
theorem validOn_iff (c : UDCert n) (es : List (Fin n × Fin n)) :
    c.ValidOn es = true ↔ ∀ e ∈ es, (c.verts e.1).distSq (c.verts e.2) = c.denomSq := by
  sorry

/-- **The chunking glue.** Prove `ValidOn` for each chunk, show the chunks concatenate to the edge
list, and get `Valid`. The `hjoin` check is cheap for the kernel — list equality of index pairs, no
tower arithmetic. -/
theorem valid_of_chunks (c : UDCert n) (chunks : List (List (Fin n × Fin n)))
    (hjoin : chunks.flatten = c.edges) (h : ∀ ch ∈ chunks, c.ValidOn ch = true) :
    c.Valid = true := by
  sorry

/-! ### Diagnosis

`decide` can only say "no", and at de Grey's scale its failure term is unreadable. These run
compiled, so they are instant at any size. -/

/-- The listed edges that fail the unit-distance check, each with the squared distance actually
found. **`#eval c.badEdges` is the first thing to run when `Valid` is `false`** — it names the
culprit edge instead of leaving a wall of kernel term. An empty list means `Valid = true`. -/
def badEdges (c : UDCert n) : List ((Fin n × Fin n) × Q4) :=
  c.edges.filterMap fun e =>
    let d := (c.verts e.1).distSq (c.verts e.2)
    if d = c.denomSq then none else some (e, d)

/-! ### Soundness — the bridge into M01 -/

/-- **Soundness.** A valid certificate certifies every listed edge as a real unit distance — exactly
the hypothesis `add_one_le_chromaticNumber_unitDistance_edgeList` consumes. -/
theorem valid_sound (c : UDCert n) (hd : c.denom ≠ 0) (hv : c.Valid = true) :
    ∀ e ∈ c.edges, dist ((c.verts e.1).toPlane c.denom) ((c.verts e.2).toPlane c.denom) = 1 := by
  sorry

/-- The plane point of a vertex — the map M01's reduction is given. -/
noncomputable def point (c : UDCert n) (i : Fin n) : ℂ := (c.verts i).toPlane c.denom

/-- **The certificate's payoff.** A valid certificate whose graph is not `k`-colourable pushes the
chromatic number of the plane above `k`. M05 calls exactly this. -/
theorem add_one_le_chromaticNumber_of_valid {k : ℕ} (c : UDCert n) (hd : c.denom ≠ 0)
    (hv : c.Valid = true) (hG : ¬ (edgeGraph n c.edges).Colorable k) :
    ((k + 1 : ℕ) : ℕ∞) ≤ (unitDistance ℂ).chromaticNumber :=
  add_one_le_chromaticNumber_unitDistance_edgeList c.edges c.point (c.valid_sound hd hv) hG

end UDCert

end HadwigerNelson

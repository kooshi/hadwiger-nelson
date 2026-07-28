import Proofs.HadwigerNelson.Field.Quadratic
import Proofs.HadwigerNelson.EdgeList
import Mathlib.Analysis.InnerProductSpace.PiL2

/-!
# Unit-distance certificates

A `UDCert n` is what an untrusted generator emits: `n` points with exact `Q4` coordinates, an edge
list over `Fin n`, and a denominator clearing those coordinates to integers. Its `Valid` field is a
**decidable integer identity** — every listed edge has exact squared distance `denom²` — and
`valid_sound` turns that identity into the real `dist … = 1` hypothesis M01's reduction consumes.

A wrong certificate cannot pass: `Valid` is `false` unless the geometry is exactly right, and the
kernel checks it.

## Shape notes

`n` is a **parameter**, not `verts.length`. A field whose type depends on another field's value
(`edges : List (Fin verts.length × _)`) breeds casts the moment M04 generates the data, and it buys
nothing — `Fin n` is also exactly what
`add_one_le_chromaticNumber_unitDistance_edgeList` wants, so the certificate hands its edge list
straight to the reduction with no translation.

Measured (`tools/emit_geometry.py`, 60 vertices / 99 edges): an indexed vertex store and a
presentation carrying resolved endpoint pairs cost **the same** under kernel `decide` — the tower
arithmetic dominates, not the lookup. So the choice is made on proof cleanliness and file size,
where indexing wins: resolved pairs duplicate every point once per incident edge (~10× at de Grey's
average degree).
-/

namespace HadwigerNelson

/-- A point of the plane with exact `Q4` coordinates. -/
structure Pt where
  x : Q4
  y : Q4
deriving DecidableEq, Repr

/-- The exact squared distance between two points, as an element of `Q4`. -/
def Pt.distSq (p q : Pt) : Q4 :=
  (p.x - q.x) * (p.x - q.x) + (p.y - q.y) * (p.y - q.y)

/-- Realise a point in `ℂ` via the ring hom `Q4 →+* ℝ`. -/
noncomputable def Pt.toPlane (p : Pt) : ℂ := ⟨Q4.eval p.x, Q4.eval p.y⟩

/-- A unit-distance certificate on `n` vertices: exact points, an edge list, and a denominator
clearing the coordinates to integers. Emitted by `tools/`, re-verified here. -/
structure UDCert (n : ℕ) where
  verts : Fin n → Pt
  edges : List (Fin n × Fin n)
  /-- The common denominator: a real unit edge has scaled squared distance `denom²`. -/
  denom : ℤ

namespace UDCert

variable {n : ℕ}

/-- `denom²` as an element of `Q4`: the target squared distance for a scaled unit edge. -/
def target (c : UDCert n) : Q4 := ((c.denom * c.denom : ℤ) : Q4)

/-- The certificate check: every listed edge is a scaled unit distance. Kernel-decidable. -/
def Valid (c : UDCert n) : Bool :=
  c.edges.all fun e => decide ((c.verts e.1).distSq (c.verts e.2) = c.target)

/-! ## Soundness — the bridge into M01

`Valid` is an exact identity over `Q4`; the reduction wants real distances. The two are linked by
`Q4.eval` being a ring hom and one `Real.sq_sqrt` per generator. -/

/-- A scaled squared-distance identity in `Q4` realises as a real unit distance. -/
theorem dist_toPlane_eq_one_of_distSq {p q : Pt} {denom : ℤ} (hd : denom ≠ 0)
    (h : p.distSq q = ((denom * denom : ℤ) : Q4)) :
    dist p.toPlane q.toPlane = 1 := by
  sorry

/-- **Soundness.** A valid certificate certifies every listed edge as a real unit distance — exactly
the hypothesis `add_one_le_chromaticNumber_unitDistance_edgeList` consumes. -/
theorem valid_sound (c : UDCert n) (hd : c.denom ≠ 0) (hv : c.Valid = true) :
    ∀ e ∈ c.edges, dist (c.verts e.1).toPlane (c.verts e.2).toPlane = 1 := by
  sorry

/-- **The certificate's payoff.** A valid certificate whose graph is not `k`-colourable pushes the
chromatic number of the plane above `k`. M05 calls exactly this. -/
theorem add_one_le_chromaticNumber_of_valid {k : ℕ} (c : UDCert n) (hd : c.denom ≠ 0)
    (hv : c.Valid = true) (hG : ¬ (edgeGraph n c.edges).Colorable k) :
    ((k + 1 : ℕ) : ℕ∞) ≤ (unitDistance ℂ).chromaticNumber := by
  sorry

end UDCert

end HadwigerNelson

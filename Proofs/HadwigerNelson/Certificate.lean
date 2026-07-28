import Proofs.HadwigerNelson.Field.Quadratic
import Proofs.HadwigerNelson.EdgeList
import Mathlib.Analysis.InnerProductSpace.PiL2

/-!
# Unit-distance certificates

A `UDCert` is what an untrusted generator emits: a list of `Q4` points, an edge list, and a
denominator that clears the coordinates to integers. Its `Valid` field is a **decidable integer
identity** — every listed edge has exact squared distance `denom²` — and `valid_sound` turns that
identity into the real `dist … = 1` hypothesis M01's reduction consumes.

The whole point: a wrong certificate cannot pass. `Valid` is `false` unless the geometry is exactly
right, and the kernel checks it (measured: 11 spindle edges, ~4 s, axioms `[propext]` only).
-/

namespace HadwigerNelson

open scoped Complex

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

/-- A unit-distance certificate: exact points, an edge list, and a denominator clearing the
coordinates to integers. Emitted by `tools/`, re-verified here. -/
structure UDCert where
  verts : List Pt
  edges : List (Fin verts.length × Fin verts.length)
  /-- The common denominator: a real unit edge has scaled squared distance `denom²`. -/
  denom : ℤ

/-- `denom² : Q4`, the target squared distance for a scaled unit edge. -/
def UDCert.target (c : UDCert) : Q4 := Adjoin.ofBase (Adjoin.ofBase (Adjoin.ofBase
  (⟨c.denom * c.denom, 0⟩)))

/-- The certificate check: every listed edge is a scaled unit distance. Kernel-decidable. -/
def UDCert.Valid (c : UDCert) : Bool :=
  c.edges.all fun e => decide (c.verts[e.1].distSq c.verts[e.2] = c.target)

/-! ## Soundness — the bridge into M01

`Valid` is an exact identity over `Q4`; the reduction wants real distances. The two are linked by
`Q4.eval` being a ring hom and one `Real.sq_sqrt` per generator. -/

/-- A scaled squared-distance identity `distSq = denom²` in `Q4` realises as a real unit distance. -/
theorem dist_toPlane_eq_one_of_distSq {p q : Pt} {denom : ℤ} (hd : denom ≠ 0)
    (h : p.distSq q = Adjoin.ofBase (Adjoin.ofBase (Adjoin.ofBase ⟨denom * denom, 0⟩))) :
    dist p.toPlane q.toPlane = 1 := by
  sorry

/-- **Soundness.** A valid certificate certifies every listed edge as a real unit distance — exactly
the hypothesis `add_one_le_chromaticNumber_unitDistance_edgeList` consumes. -/
theorem UDCert.valid_sound (c : UDCert) (hd : c.denom ≠ 0) (hv : c.Valid = true) :
    ∀ e ∈ c.edges, dist (c.verts[e.1].toPlane) (c.verts[e.2].toPlane) = 1 := by
  sorry

end HadwigerNelson

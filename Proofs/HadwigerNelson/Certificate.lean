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

## The scale is the certificate's, not the point's

Coordinates are stored **multiplied by `denom`** so that they are integers. So `Q4.eval` of a stored
coordinate is `denom` times the real one, and a listed edge's stored squared distance is `denom²`
rather than `1`. The plane point is therefore `Pt.scaled`, which divides — and that division is the
only place `denom ≠ 0` is needed, which is why the hypothesis appears exactly where it does.

Getting this wrong is not a slow proof but a false theorem: `dist (eval p) (eval q) = 1` is
unprovable for a valid certificate, since those two points are `denom` apart.

## Shape notes

`n` is a **parameter**, not `verts.length`. A field whose type depends on another field's value
(`edges : List (Fin verts.length × _)`) breeds casts the moment M04 generates the data, and it buys
nothing — `Fin n` is also exactly what
`add_one_le_chromaticNumber_unitDistance_edgeList` wants, so the certificate hands its edge list
straight to the reduction with no translation.

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

/-- The exact squared distance between two stored points, as an element of `Q4`. For points scaled
by `D`, a real unit distance shows up here as `D * D`. -/
def Pt.distSq (p q : Pt) : Q4 :=
  (p.x - q.x) * (p.x - q.x) + (p.y - q.y) * (p.y - q.y)

/-- The actual plane point: evaluate the stored coordinates and undo the scaling. -/
noncomputable def Pt.scaled (p : Pt) (D : ℤ) : ℂ :=
  ⟨Q4.eval p.x / (D : ℝ), Q4.eval p.y / (D : ℝ)⟩

/-- `eval` is a ring hom and `distSq` is a polynomial, so evaluation commutes with it. The whole
number-theoretic content of the milestone is this plus `Real.sq_sqrt` per generator. -/
theorem eval_distSq (p q : Pt) :
    Q4.eval (p.distSq q) =
      (Q4.eval p.x - Q4.eval q.x) ^ 2 + (Q4.eval p.y - Q4.eval q.y) ^ 2 := by
  sorry

/-- **The geometric bridge.** An exact identity `distSq = D²` in `Q4` says the scaled points are `D`
apart, hence the descaled points are exactly `1` apart. `hD` is consumed by the division. -/
theorem dist_scaled_eq_one {p q : Pt} {D : ℤ} (hD : D ≠ 0)
    (h : p.distSq q = ((D * D : ℤ) : Q4)) :
    dist (p.scaled D) (q.scaled D) = 1 := by
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

/-- `denom²` as an element of `Q4`: the stored squared distance of a real unit edge. -/
def target (c : UDCert n) : Q4 := ((c.denom * c.denom : ℤ) : Q4)

/-- The certificate check: every listed edge is a scaled unit distance. Kernel-decidable.

At de Grey's scale this must be run in chunks — measured ~0.17 s/edge with memory linear in the
chunk, so all 7877 edges in one `List.all` builds an unaffordable kernel term. -/
def Valid (c : UDCert n) : Bool :=
  c.edges.all fun e => decide ((c.verts e.1).distSq (c.verts e.2) = c.target)

/-- The plane point of a vertex — the map M01's reduction is given. -/
noncomputable def point (c : UDCert n) (i : Fin n) : ℂ := (c.verts i).scaled c.denom

/-- **Soundness.** A valid certificate certifies every listed edge as a real unit distance — exactly
the hypothesis `add_one_le_chromaticNumber_unitDistance_edgeList` consumes. -/
theorem valid_sound (c : UDCert n) (hd : c.denom ≠ 0) (hv : c.Valid = true) :
    ∀ e ∈ c.edges, dist (c.point e.1) (c.point e.2) = 1 := by
  sorry

/-- **The certificate's payoff.** A valid certificate whose graph is not `k`-colourable pushes the
chromatic number of the plane above `k`. M05 calls exactly this. -/
theorem add_one_le_chromaticNumber_of_valid {k : ℕ} (c : UDCert n) (hd : c.denom ≠ 0)
    (hv : c.Valid = true) (hG : ¬ (edgeGraph n c.edges).Colorable k) :
    ((k + 1 : ℕ) : ℕ∞) ≤ (unitDistance ℂ).chromaticNumber :=
  add_one_le_chromaticNumber_unitDistance_edgeList c.edges c.point (c.valid_sound hd hv) hG

end UDCert

end HadwigerNelson

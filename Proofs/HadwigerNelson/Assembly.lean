import Proofs.HadwigerNelson.Motion

/-!
# Assembly — one certificate for many placed copies

M09's largest single win was an orbit found by accident: de Grey's second 791-point copy turned out
to be his first one rotated, and *deriving* it rather than certifying it deleted 1,043 generated
modules, 180 MB of source and 12.8 hours of processor time, replaced by 95 CPU seconds. That saving
was collected once, by hand, on a table that had been frozen before the rotation was known.

**A candidate that is *constructed* as an orbit collects it by construction.** This module is the
layer that makes that true: a base certificate plus a list of placements yields one certificate on
`copies × n` vertices whose intra-copy edges are certified by the base's own check, transported for
free. Only the **cross-copy edges** — the seams — cost anything, and they are the irreducible part.

## The denominator, and why every copy is rescaled twice

A motion `μ` sends a point stored at denominator `d` to one stored at `d · μ.M`, and `μ.M` is a `Q4`
element that need not be an integer — a reflection with `a = 1, b = √11` has `scale = 12` and
`M = √12`. `UDCert.denom` is an `ℤ`, so a copy placed by `image` alone may have no denominator to be
written at.

The composite `rescale ∘ image` fixes that for **every** motion, not merely the convenient ones: it
lands at denominator `d · μ.scale`, and `scale` is a natural number by construction. Squared distances
scale by `μ.scale²`.

Copies still have to agree with *each other*, so copy `i` is scaled by the product of every *other*
placement's scale (`coFactor`). Then every copy sits at the same denominator `d · factor` and every
copy's squared distances scale by the same `factor²` — one hypothesis, discharged once, for copies
placed by motions with nothing in common. That uniformity is the whole reason for the shape.
-/

namespace HadwigerNelson

/-- A stored point re-written at `m` times the denominator. The same plane point; only the scaling
of the integer coordinates changes. -/
def Pt.scaleBy (m : Q4) (p : Pt) : Pt := ⟨m * p.x, m * p.y⟩

/-- Re-denomination scales every squared distance by `m²`. -/
theorem Pt.distSq_scaleBy (m : Q4) (p p' : Pt) :
    (p.scaleBy m).distSq (p'.scaleBy m) = m * m * p.distSq p' := by
  sorry

/-- **A base certificate and the placements that copy it.**

The copies are `places.length` in number and the assembled graph has `places.length * n` vertices,
copy `i` occupying indices `i * n` through `i * n + n - 1`. -/
structure Assembly (n : ℕ) where
  /-- The configuration being copied. Certified once. -/
  base : UDCert n
  /-- Where the copies go. One motion per copy; `Motion.id` for a copy left in place. -/
  places : List Motion

namespace Assembly

variable {n : ℕ} (A : Assembly n)

/-- The product of every placement's scale — the factor the assembled denominator carries. -/
def factor : ℕ := (A.places.map Motion.scale).prod

/-- The product of every placement's scale **except** copy `i`'s.

Defined by deletion rather than as `factor / scale i`: natural division truncates, and a junk value
here would silently produce a certificate at the wrong denominator that still elaborated. -/
def coFactor (i : Fin A.places.length) : ℕ :=
  ((A.places.eraseIdx i.val).map Motion.scale).prod

/-- Copy `i`'s embedding of a point: place it, re-denominate it to an integer scale, then bring it
to the assembly's common denominator. -/
def place (i : Fin A.places.length) (p : Pt) : Pt :=
  Pt.scaleBy ((A.coFactor i : ℕ) : Q4)
    ((A.places.get i).rescale ((A.places.get i).image p))

/-- **Every copy scales squared distance by the same factor**, whatever motions were used.

This is the hypothesis `UDCert.validOn_map_of_scaling` takes, discharged once for all copies — and
the reason `coFactor` exists. -/
theorem distSq_place (i : Fin A.places.length) (p p' : Pt) :
    ((A.place i) p).distSq ((A.place i) p') = ((A.factor * A.factor : ℕ) : Q4) * p.distSq p' := by
  sorry

/-- Vertex `v` of copy `i`, as an index of the assembled graph. -/
def idx (i : Fin A.places.length) (v : Fin n) : Fin (A.places.length * n) :=
  ⟨i.val * n + v.val, by
    have h1 := i.isLt
    have h2 := v.isLt
    calc i.val * n + v.val < i.val * n + n := by omega
      _ = (i.val + 1) * n := by ring
      _ ≤ A.places.length * n := Nat.mul_le_mul_right n h1⟩

/-- The base's edge list, transported into copy `i`. -/
def copyEdges (i : Fin A.places.length) :
    List (Fin (A.places.length * n) × Fin (A.places.length * n)) :=
  A.base.edges.map fun e => (A.idx i e.1, A.idx i e.2)

/-- Every copy's own edges, in copy order. The edges that cost nothing. -/
def copiedEdges : List (Fin (A.places.length * n) × Fin (A.places.length * n)) :=
  (List.finRange A.places.length).flatMap A.copyEdges

/-- **The assembled certificate.** `cross` is the seam: the unit-distance pairs *between* copies,
which no transport can supply and which are checked directly. -/
def cert (cross : List (Fin (A.places.length * n) × Fin (A.places.length * n))) :
    UDCert (A.places.length * n) where
  verts v :=
    -- `n = 0` would make the index type empty, so a vertex existing is already the bound. Deriving
    -- it rather than taking `0 < n` as a field keeps the structure free of a hypothesis every
    -- consumer would have to carry.
    have hn : 0 < n := Nat.pos_of_ne_zero fun h => absurd v.isLt (by simp [h])
    A.place ⟨v.val / n, (Nat.div_lt_iff_lt_mul hn).mpr v.isLt⟩
      (A.base.verts ⟨v.val % n, Nat.mod_lt _ hn⟩)
  edges := A.copiedEdges ++ cross
  denom := A.base.denom * (A.factor : ℤ)

/-- Reading a vertex of copy `i` back out of the assembled table gives copy `i`'s placement of the
base point — the `hverts` hypothesis, for every copy at once. -/
theorem cert_verts_idx (cross) (i : Fin A.places.length) (v : Fin n) :
    (A.cert cross).verts (A.idx i v) = A.place i (A.base.verts v) := by
  sorry

/-- **The payoff.** Every copy of the base's edge list is certified by the *base's own* validity —
no per-copy geometry, no per-vertex identity, whatever the placements were. -/
theorem validOn_copiedEdges (cross) (hbase : A.base.Valid = true) :
    (A.cert cross).ValidOn A.copiedEdges = true := by
  sorry

/-- **The assembled certificate is valid** once the seams are checked. The only work that scales with
the number of copies is `cross`. -/
theorem valid_of_cross (cross) (hbase : A.base.Valid = true)
    (hcross : (A.cert cross).ValidOn cross = true) :
    (A.cert cross).Valid = true := by
  sorry

end Assembly

/-! ## Spec

A placement layer that certified nothing, or that certified everything, would look identical to a
working one on any single example. So: a model of the hypotheses, a `#eval` per definition, and an
adversarial member that must be refused. -/

section Spec

/-- **A model of the hypotheses.** One unit edge, placed twice — left where it is, and rotated by the
`3–4–5` rotation about the origin. Four vertices, two copies, no seam. -/
def demoAssembly : Assembly 2 where
  base := ⟨![⟨0, 0⟩, ⟨5, 0⟩], [(0, 1)], 5⟩
  places := [Motion.id, pythagorean]

/-- The assembled graph has four vertices and two edges. -/
example : demoAssembly.places.length * 2 = 4 := by decide

/-- The assembled certificate certifies both copies, with no per-copy geometry. -/
example : (demoAssembly.cert []).Valid = true := by sorry

/-- **The adversarial member.** Move the base's second point off the unit circle: the base's own
check must fail, and with it the assembly's — a placement layer that "certified" a broken base would
certify anything. -/
def demoBroken : Assembly 2 :=
  { demoAssembly with base := ⟨![⟨0, 0⟩, ⟨5, 1⟩], [(0, 1)], 5⟩ }

example : demoBroken.base.Valid = false := by sorry

end Spec

end HadwigerNelson

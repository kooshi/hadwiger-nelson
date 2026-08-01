import Proofs.HadwigerNelson.Motion
import Proofs.HadwigerNelson.EdgeList
import Mathlib.Logic.Equiv.Fin.Basic

/-!
# Assembly — one certificate for many placed copies

M09's largest single win was an orbit found by accident: de Grey's second 791-point copy turned out
to be his first one rotated, and *deriving* it rather than certifying it deleted 1,043 generated
modules, 180 MB of source and 12.8 hours of processor time, replaced by 95 CPU seconds. That saving
was collected once, by hand, on a table frozen before the rotation was known.

**A candidate *constructed* as an orbit collects it by construction.** A base certificate plus a list
of placements yields one certificate on `copies × n` vertices whose intra-copy edges are certified by
the base's own check and whose intra-copy *colouring properties* transport along the same map. Only
the **cross-copy edges** — the seams — cost anything.

## Why this is not an optimisation but the thing that makes the representation work

Defining a copy's coordinates as `place i (base.verts v)` rather than emitting them as literals is a
**pessimisation** if the certificate is then checked edge by edge: measured at M12 subplanning, one
edge of computed coordinates costs **0.33 CPU s** against M08's **7.1 ms** for an edge of emitted
ones — 47× worse, because every check re-runs six `Q4` multiplications for the image, two for the
re-denomination and two more for the common scale.

`validOn_copiedEdges` is what inverts that. It certifies every copy's edges *symbolically*, with no
per-edge reduction at all, so the computed representation goes from 47× worse to free. The module
exists for that theorem; the structure exists to state it.

## The denominator, and why every copy is rescaled twice

A motion `μ` sends a point stored at denominator `d` to one at `d · μ.M`, and `μ.M` is a `Q4` element
that need not be an integer — a reflection with `a = 1, b = √11` has `scale = 12` and `M = √12`.
`UDCert.denom` is an `ℤ`, so a copy placed by `image` alone may have no denominator to be written at.

The composite `rescale ∘ image` fixes that for **every** motion, not merely the convenient ones: it
lands at denominator `d · μ.scale`, and `scale` is a natural number by construction.

Copies must also agree with each other, so copy `i` is additionally scaled by the product of every
*other* placement's scale (`coFactor`). Then every copy sits at the same denominator `d · factor` and
scales squared distances by the same `factor²` — one hypothesis, discharged once, for copies placed
by motions with nothing in common.

**The exponential growth of `factor` in the copy count costs nothing**, measured: the assembled table
is a *function*, so no coordinate is ever a literal, and the direct check is linear in the copy count
rather than exponential. That is M08's "kernel bit width is irrelevant beside step count", holding at
a new place.
-/

namespace HadwigerNelson

/-- A stored point re-written at `m` times the denominator. The same plane point; only the scaling of
the integer coordinates changes. -/
def Pt.scaleBy (m : Q4) (p : Pt) : Pt := ⟨m * p.x, m * p.y⟩

/-- Re-denomination scales every squared distance by `m²`. -/
theorem Pt.distSq_scaleBy (m : Q4) (p p' : Pt) :
    (p.scaleBy m).distSq (p'.scaleBy m) = m * m * p.distSq p' := by
  sorry

/-- **A base configuration and the placements that copy it.**

`places` is a `List Motion` rather than one motion iterated: the orbits that arise are not all
cyclic — de Grey's is a single reflection, a hexagonal one is six distinct motions — and a list is
the least representation covering both. It is also why `Motion` still needs no monoid instance.

`Assembly` nests: `cert` returns a `UDCert`, which is what `base` takes, so a construction layered
out of copies of copies is an `Assembly` whose base is an `Assembly`'s certificate. -/
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

/-- Copy `i`'s embedding of a point: place it, re-denominate it to an integer scale, then bring it to
the assembly's common denominator.

Reason about it through `distSq_place`; the three steps are an implementation detail. -/
def place (i : Fin A.places.length) (p : Pt) : Pt :=
  Pt.scaleBy ((A.coFactor i : ℕ) : Q4)
    ((A.places.get i).rescale ((A.places.get i).image p))

/-- **Every copy scales squared distance by the same factor**, whatever motions were used.

The hypothesis `UDCert.validOn_map_of_scaling` takes, discharged once for all copies — and the reason
`coFactor` exists. -/
theorem distSq_place (i : Fin A.places.length) (p p' : Pt) :
    ((A.place i) p).distSq ((A.place i) p') = ((A.factor * A.factor : ℕ) : Q4) * p.distSq p' := by
  sorry

/-- **Vertex `v` of copy `i`, as an index of the assembled graph.**

This is Mathlib's `Fin c × Fin n ≃ Fin (c * n)` and not a hand-rolled `i * n + v`. The difference is
not cosmetic: the linking lemma `verts_idx` below is `simp` through the equiv and nine lines of
division, modulus, `congr` and a derived `0 < n` without it — a bijection stated as a bijection needs
no side condition, because it has an inverse by construction. -/
def idx (i : Fin A.places.length) (v : Fin n) : Fin (A.places.length * n) :=
  finProdFinEquiv (i, v)

/-- The base's edge list, transported into copy `i`. -/
def copyEdges (i : Fin A.places.length) :
    List (Fin (A.places.length * n) × Fin (A.places.length * n)) :=
  A.base.edges.map fun e => (A.idx i e.1, A.idx i e.2)

/-- Every copy's own edges, in copy order. The edges that cost nothing. -/
def copiedEdges : List (Fin (A.places.length * n) × Fin (A.places.length * n)) :=
  (List.finRange A.places.length).flatMap A.copyEdges

/-- **The assembled certificate.** `cross` is the seam: the unit-distance pairs *between* copies,
which no transport can supply and which are checked directly.

`cross` is a parameter and not a field, because it is a *claim* about which pairs are being asserted
adjacent, not a property of the placement — a search proposes one placement and then hunts for seams,
and re-deriving the placement per seam list would be the tail wagging the dog. `UDCert.edges` is a
claim in exactly the same sense. -/
def cert (cross : List (Fin (A.places.length * n) × Fin (A.places.length * n))) :
    UDCert (A.places.length * n) where
  verts v := A.place (finProdFinEquiv.symm v).1 (A.base.verts (finProdFinEquiv.symm v).2)
  edges := A.copiedEdges ++ cross
  denom := A.base.denom * (A.factor : ℤ)

/-- Reading a vertex of copy `i` back out of the assembled table gives copy `i`'s placement of the
base point — the `hverts` hypothesis, for every copy at once. -/
theorem verts_idx (cross) (i : Fin A.places.length) (v : Fin n) :
    (A.cert cross).verts (A.idx i v) = A.place i (A.base.verts v) := by
  simp only [cert, idx, Equiv.symm_apply_apply]

/-- **The payoff for the geometry.** Every copy of the base's edge list is certified by the *base's
own* validity — no per-copy geometry, no per-vertex identity, whatever the placements were. -/
theorem validOn_copiedEdges (cross) (hbase : A.base.Valid = true) :
    (A.cert cross).ValidOn A.copiedEdges = true := by
  sorry

/-- **The assembled certificate is valid** once the seams are checked. The only work that scales with
the number of copies is `cross`. -/
theorem valid_of_cross (cross) (hbase : A.base.Valid = true)
    (hcross : (A.cert cross).ValidOn cross = true) :
    (A.cert cross).Valid = true := by
  sorry

/-- **The payoff for the colouring**, and the half that carried M09's 12.8 hours.

A copy's edges really are edges of the assembled graph, so `Gadget.transport` carries any colouring
property proved of the base into copy `i` — the geometric copy and the combinatorial copy are the
same map, `idx i`, and this is what lets them be. Without it a placed copy would be free in the
geometry and full price in the refutation, which is the expensive half. -/
theorem adj_idx (cross) (i : Fin A.places.length) {e : Fin n × Fin n}
    (hne : A.idx i e.1 ≠ A.idx i e.2) (he : e ∈ A.base.edges) :
    (edgeGraph (A.places.length * n) ((A.cert cross).edges)).Adj (A.idx i e.1) (A.idx i e.2) := by
  sorry

end Assembly

/-! ## Spec

A placement layer that certified nothing, or that certified everything, would look identical to a
working one on any single example. So: a model of the hypotheses, a check per definition, and an
adversarial member that must be refused. -/

section Spec

/-- **A model of the hypotheses.** One unit edge, placed twice — left where it is, and rotated by the
`3–4–5` rotation about the origin. Four vertices, two copies, no seam. -/
def demoAssembly : Assembly 2 where
  base := ⟨![⟨0, 0⟩, ⟨5, 0⟩], [(0, 1)], 5⟩
  places := [Motion.id, pythagorean]

example : demoAssembly.base.Valid = true := by decide +kernel

/-- Two copies of a unit edge: four vertices, two edges, and the denominator carries both scales. -/
example : demoAssembly.factor = 25 := by decide
example : (demoAssembly.cert []).denom = 125 := by decide
example : (demoAssembly.cert []).edges.length = 2 := by decide

/-- The assembled certificate certifies both copies — checked here the expensive way, by reduction,
so that `validOn_copiedEdges` has something to agree with. -/
example : (demoAssembly.cert []).Valid = true := by decide +kernel

/-- **The exponential denominator is not exponential in cost.** Sixteen copies is a `factor` of
`25^16`, and it computes. -/
example : (Assembly.mk demoAssembly.base (List.replicate 16 pythagorean)).factor = 25 ^ 16 := by
  decide

/-- **The adversarial member.** Move the base's second point off the unit circle: the base's own check
must fail, and with it the assembly's — a placement layer that "certified" a broken base would
certify anything. -/
def demoBroken : Assembly 2 :=
  { demoAssembly with base := ⟨![⟨0, 0⟩, ⟨5, 1⟩], [(0, 1)], 5⟩ }

example : demoBroken.base.Valid = false := by decide +kernel
example : (demoBroken.cert []).Valid = false := by decide +kernel

end Spec

end HadwigerNelson

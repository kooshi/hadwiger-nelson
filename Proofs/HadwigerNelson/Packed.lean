import Proofs.HadwigerNelson.Certificate

/-!
# Structure-aware geometry — one norm per distinct difference, one subtraction per edge

The certificate check this file replaces recomputes a squared distance for every listed edge:
7,877 of them for de Grey's graph, at 0.0246 CPU s and 4.55 MB each. Two facts make almost all of
that work redundant.

**A distance depends only on a difference, and these graphs have very few distinct differences.**
De Grey's 7,877 edges have 133 distinct difference vectors; Heule's 510- and 553-vertex witnesses
have 66 and 82. The ratio is stable at roughly 118 : 1 across de Grey's whole construction. So the
expensive part — two squarings in `ℚ(√3,√5,√7,√11)` — can be paid once per *difference*, and each
edge only has to agree that its endpoints differ by the difference it names.

**And that agreement need not be checked coordinate by coordinate.** A point is 32 integers. Packing
them into a single `ℤ`, one 32-bit lane each, makes the packing a *linear* map — so a difference of
packed points is the packed difference, exactly, with no borrow between lanes to reason about — and
the per-edge check becomes one big-integer subtraction and one comparison. Measured: **0.00137 CPU s
and 0.27 MB per edge**, against a list walk carrying no arithmetic at all at 0.0011 s. The arithmetic
has effectively vanished.

Together: de Grey's geometry falls from 194 CPU s to a projected 17, and from 35.8 GB spread across
nine modules to 2.6 GB in one.

## What is trusted

Nothing here. `DiffWitness` is data an untrusted generator emits, and every field of it is checked:
a wrong difference, a wrong index, a wrong packing, a leaf out of range, or a `keys` list of the
wrong length each make `Check` return `false`. None of them can make a theorem false.

The claim this file produces is `UDCert.Valid = true` — *the same claim* the per-edge route produces,
so nothing downstream of a certificate changes shape.

## The lane arithmetic, stated once

A vertex leaf is bounded by `vertexBound = 2^29`, so a difference of two is within `2^30`, and the
injectivity argument's one requirement — `2 * b + 2 ≤ 2 ^ laneBits` — holds at `2^31 + 2 ≤ 2^32`.
De Grey's largest leaf is **1920**, so the margin is eighteen binary orders.

**Width is not free, and the instinct that it would be was measured wrong.** Big-integer arithmetic
is indeed one reduction step at any size, but wider lanes mean wider literals, and 64-bit lanes cost
**28% more per edge** than 32-bit ones (0.00176 s against 0.00137, de Grey's first chunk, desktop).
So the lanes are the narrowest width the proof is comfortable in, not the widest the kernel tolerates.

## Emitter contract

`tools/emit_geometry.py` must agree with this file on all five:

| item | value |
|---|---|
| lane width | 32 bits, one lane per integer leaf |
| lane order | the tower's own: `re` before `im` at every level, and `x` before `y` in a `Pt` |
| difference orientation | `verts e.1 - verts e.2` — the same orientation `ValidOn` reads |
| vertex bound | every leaf `|l| ≤ 2^29` |
| `keys` order | the certificate's edge order, one entry per edge, no gaps |

**Diagnostics are not in this file.** They live in `PackedDiagnose.lean`, downstream, where rewriting
them costs one module rather than every geometry module that imports this one.
-/

namespace HadwigerNelson

/-- A table of integers indexed by `Nat` — the packed sibling of `PtTable`, same balanced split of
the index range, same flat lookup cost at every index. -/
inductive IntTable where
  /-- A subtable covering exactly one index. -/
  | leaf : Int → IntTable
  /-- `node m l r` — indices below `m` are `l`'s; the rest are `r`'s, renumbered from zero. -/
  | node : Nat → IntTable → IntTable → IntTable
deriving Repr

/-- Look up index `i`. Structural on the table, so a lookup costs the table's depth.

**Totality is denied out of range**, exactly as `PtTable.get` denies it: `Nat` subtraction truncates
and a too-large index returns *some* integer. Every caller here supplies an index the check itself
compares against a table entry, so an out-of-range index makes the check false rather than a claim
wrong. -/
def IntTable.get : IntTable → Nat → Int
  | .leaf v, _ => v
  | .node m l r, i => if i < m then l.get i else r.get (i - m)

/-- Bits per lane. One lane per integer leaf of a point.

Measured, not chosen for comfort: 64-bit lanes cost 28% more per edge than these, because the
per-edge cost is now literal width rather than arithmetic. -/
def laneBits : ℕ := 32

/-- The largest leaf a certificate's vertex may carry. A difference of two lands within `2 ^ 30`,
which is exactly what `pack_inj`'s lane condition admits. De Grey's largest leaf is 1920. -/
def vertexBound : Int := 2 ^ 29

/-- **Packing a level of the tower.** `pack` is a linear map into `ℤ`, `width` counts the lanes it
consumes, and `bnd b x` says every integer leaf of `x` is within `b`.

The three laws travel with the data because no consumer ever wants one without the others: linearity
is why the per-edge check is a subtraction, the lane bound is why the packing is injective, and
injectivity is why the check proves anything.

**Indexed on `CommRing K`, not on `Sub K`.** `NatScalar` next door is indexed the same way and for
the same reason recorded there: a class indexed on the *pieces* only synthesizes where the ambient
instances happen to be found by the route that declared it, which for a tower is never reliably
true. Indexing on the single bundled structure makes the route unique. -/
class Packable (K : Type) [CommRing K] where
  /-- The 32 leaves of `x`, laid end to end in lanes of `laneBits` bits. -/
  pack : K → Int
  /-- How many lanes `pack` consumes. -/
  width : ℕ
  /-- `bnd b x` — every integer leaf of `x` has absolute value at most `b`. Decidable, because the
  certificate check runs it. -/
  bnd : Int → K → Bool
  /-- **Linearity.** The reason a difference of packed points is the packed difference. -/
  pack_sub : ∀ x y : K, pack (x - y) = pack x - pack y
  /-- Leaves within `b` give leaves within `b` on both sides of a subtraction, doubled. -/
  bnd_sub : ∀ (b : Int) (x y : K), bnd b x = true → bnd b y = true → bnd (2 * b) (x - y) = true
  /-- **The lane bound.** A value whose leaves fit in half a lane packs to a value that fits, with
  room for the `+ 2`, in its own width. The `+ 2` is not slack: the induction's step is
  `(M - 2) + M * (M - 2) + 2 = M² - M ≤ M²`, and it fails with a bare `<`. -/
  pack_le : ∀ (b : Int) (x : K), 2 * b + 2 ≤ 2 ^ laneBits → bnd b x = true →
    2 * |pack x| + 2 ≤ 2 ^ (laneBits * width)
  /-- **Injectivity on bounded values** — the load-bearing law, and the milestone's one real
  obligation. -/
  pack_inj : ∀ (b : Int) (x y : K), 2 * b + 2 ≤ 2 ^ laneBits →
    bnd b x = true → bnd b y = true → pack x = pack y → x = y

namespace Packable

/-- The leaf of the tower: an integer packs to itself and occupies one lane. -/
instance instInt : Packable Int where
  pack := id
  width := 1
  bnd b z := decide (|z| ≤ b)
  pack_sub := by sorry
  bnd_sub := by sorry
  pack_le := by sorry
  pack_inj := by sorry

/-- One level of the tower: the real part in the low lanes, the `√d` coefficient in the high ones.
`d` plays no part — packing is a fact about the *shape* of the data, not about the field. -/
instance instAdjoin {d : ℕ} {K : Type} [CommRing K] [NatScalar K] [Packable K] :
    Packable (Adjoin d K) where
  pack x := pack x.re + 2 ^ (laneBits * width (K := K)) * pack x.im
  width := 2 * width (K := K)
  bnd b x := bnd b x.re && bnd b x.im
  pack_sub := by sorry
  bnd_sub := by sorry
  pack_le := by sorry
  pack_inj := by sorry

end Packable

/-! ### Points

`Pt` is two `Q4`s and is not a ring, so it gets the three laws directly rather than through an
instance. `Pt.sub` is a plain `def` and not a `Sub` instance: an instance is a permanent utterance
into every future elaboration, and nothing here needs one. -/

/-- The difference of two stored points, in the orientation `UDCert.ValidOn` reads: source minus
target. -/
def Pt.sub (p q : Pt) : Pt := ⟨p.x - q.x, p.y - q.y⟩

/-- The squared length of a difference vector.

`Pt.normSq (Pt.sub p q)` is `Pt.distSq p q` **by definition** — which is the whole reason the
milestone works, and is stated as `normSq_sub` below rather than left for a reader to notice. -/
def Pt.normSq (v : Pt) : Q4 := FastSq.sq v.x + FastSq.sq v.y

/-- The two coordinates of a point, packed end to end. -/
def Pt.pack (p : Pt) : Int :=
  Packable.pack p.x + 2 ^ (laneBits * Packable.width (K := Q4)) * Packable.pack p.y

/-- Every leaf of a point is within `b`. -/
def Pt.bnd (b : Int) (p : Pt) : Bool := Packable.bnd b p.x && Packable.bnd b p.y

/-- **The distance is the norm of the difference, definitionally.** -/
theorem Pt.normSq_sub (p q : Pt) : (Pt.sub p q).normSq = p.distSq q := rfl

/-- Linearity, at the level of points. -/
theorem Pt.pack_sub (p q : Pt) : (Pt.sub p q).pack = p.pack - q.pack := by sorry

/-- A difference of bounded points is bounded, doubled. -/
theorem Pt.bnd_sub {b : Int} {p q : Pt} (hp : p.bnd b = true) (hq : q.bnd b = true) :
    (Pt.sub p q).bnd (2 * b) = true := by sorry

/-- **Injectivity on bounded points.** Two points whose leaves are within `b`, with `2 * b` inside a
lane, and whose packings agree, are the same point. -/
theorem Pt.pack_inj {b : Int} {p q : Pt} (hlane : 2 * b + 2 ≤ 2 ^ laneBits)
    (hp : p.bnd b = true) (hq : q.bnd b = true) (h : p.pack = q.pack) : p = q := by sorry

/-! ### The witness

Every check below is a **structural walk over the data it checks** — no index list, no range, no
arithmetic on positions. That is not tidiness: `List.range` plus `List.map` costs ~0.83 ms *per
element* in this kernel, which at 1581 vertices would be 1.3 s of pure bookkeeping, and an index
built by hand needs a proof that it is in range, which is a `sorry` waiting to be written into a
definition. Walking the tables together has neither problem, and it makes "the two tables have the
same shape" part of what the check establishes rather than something a reader has to assume. -/

/-- **What the generator emits so the kernel can check a graph's geometry cheaply.**

Nothing here is trusted and nothing needs to be. Every field is compared against the certificate by
`Check`; a wrong entry makes the check `false`. -/
structure DiffWitness (n : ℕ) where
  /-- The certificate's own vertex table. Carried here so the check can walk it; tied to the
  certificate by `hverts`, which is `rfl` for every emitted certificate. -/
  verts : PtTable
  /-- `Pt.pack (verts.get i)`, one per vertex, **in a table of the same shape as `verts`**. -/
  packedV : IntTable
  /-- The distinct edge difference vectors, exact, in first-use order. -/
  diffs : PtTable
  /-- `Pt.pack (diffs.get k)`, one per difference, in a table of the same shape as `diffs`. -/
  packedD : IntTable
  /-- One index into `diffs` per edge, in the certificate's own edge order. -/
  keys : List ℕ

namespace DiffWitness

variable {n : ℕ}

/-- **A point table and its packing, walked together**: every leaf packs to what the packed table
holds, every leaf is within `b`, and the two tables have the same shape.

Same shape is not decoration — the per-edge check looks a vertex up by index in `packedV` and the
soundness proof has to know that index means the same point in `verts`. Requiring `m == m'` at every
node is how that is established rather than assumed.

Measured **0.00196 CPU s per entry**. -/
def packOk (b : Int) : PtTable → IntTable → Bool
  | .leaf p, .leaf v => p.bnd b && (v == p.pack)
  | .node m l r, .node m' l' r' => (m == m') && packOk b l l' && packOk b r r'
  | _, _ => false

/-- **The expensive check, and the only one that carries a multiplication** — every distinct
difference really has squared length `denomSq`.

Measured **0.0209 CPU s each**, and there are 133 of them for de Grey against 7,877 edges. This one
line is the milestone. -/
def normsOk (target : Q4) : PtTable → Bool
  | .leaf v => decide (v.normSq = target)
  | .node _ l r => normsOk target l && normsOk target r

/-- **The per-edge check** — one big-integer subtraction and one comparison.

The edge list and the key list are walked *together*, and a length mismatch is `false` rather than a
silently truncated pass: `List.zip` would drop the tail of the longer list, and a separate length
check is one more thing that can rot out of agreement with the walk it guards.

Measured **0.00137 CPU s and 0.27 MB per edge**, against a walk carrying no arithmetic at all at
0.0011 s — the arithmetic is no longer what this costs. -/
def edgesOk (w : DiffWitness n) : List (Fin n × Fin n) → List ℕ → Bool
  | [], [] => true
  | e :: es, k :: ks =>
      (w.packedV.get e.1.val - w.packedV.get e.2.val == w.packedD.get k) && edgesOk w es ks
  | _, _ => false

/-- The four checks, as one `Bool` the kernel decides.

The difference bound is `2 * vertexBound` because a difference of two vertices within `vertexBound`
lands there, and `2 * (2 * vertexBound) + 2 ≤ 2 ^ laneBits` is exactly what `pack_inj` asks. -/
def Check (c : UDCert n) (w : DiffWitness n) : Bool :=
  packOk vertexBound w.verts w.packedV
    && packOk (2 * vertexBound) w.diffs w.packedD
    && normsOk c.denomSq w.diffs
    && w.edgesOk c.edges w.keys

/-! ### What `packOk` establishes, extracted once

The soundness proof needs `packOk` in pointwise form, and so does every diagnostic. Proved by
induction on the two tables together, which is the induction `packOk`'s own recursion performs. -/

/-- Same shape, so `get` at an index means the same entry in both tables. -/
theorem packOk_pack {b : Int} {t : PtTable} {u : IntTable} (h : packOk b t u = true) (i : ℕ) :
    u.get i = (t.get i).pack := by sorry

/-- …and every entry is inside the bound. -/
theorem packOk_bnd {b : Int} {t : PtTable} {u : IntTable} (h : packOk b t u = true) (i : ℕ) :
    (t.get i).bnd b = true := by sorry

/-- `normsOk` in pointwise form, for indices the table actually covers. -/
theorem normsOk_get {target : Q4} {t : PtTable} (h : normsOk target t = true) (i : ℕ) :
    (t.get i).normSq = target := by sorry

/-- `edgesOk` in pointwise form: every edge is paired with a key, and its endpoints' packed
difference is that key's packed difference. -/
theorem edgesOk_mem {w : DiffWitness n} {es : List (Fin n × Fin n)} {ks : List ℕ}
    (h : w.edgesOk es ks = true) (e : Fin n × Fin n) (he : e ∈ es) :
    ∃ k, w.packedV.get e.1.val - w.packedV.get e.2.val = w.packedD.get k := by sorry

end DiffWitness

/-- **Soundness.** A witness that checks certifies the certificate — the same `UDCert.Valid = true`
the per-edge route produces, from data that costs an order of magnitude less to verify.

`hverts` says the witness carries the certificate's own vertex table, and is `rfl` for every emitted
certificate — the same arrangement `UDCert.valid_of_chunks` makes with its join hypothesis. `h` is a
closed `Bool` the kernel decides. Nothing else about the witness is assumed. -/
theorem UDCert.valid_of_diffWitness {n : ℕ} (c : UDCert n) (w : DiffWitness n)
    (hverts : c.verts = w.verts.toVerts) (h : w.Check c = true) : c.Valid = true := by sorry

/-! ## Spec

Every theorem above has the form "if the check passes then …", so every one of them is true of a
`Check` that never passes. These pin the two directions no proof here can: that a witness is
reachable at all, and that each check goes `false` when its own field is wrong. -/

section Spec

/-- The two points `(0,0)` and `(1,0)`, as a table — the shape `toVerts` reads. -/
private def unitPairTable : PtTable := .node 1 (.leaf ⟨0, 0⟩) (.leaf ⟨1, 0⟩)

/-- The smallest honest certificate: those two points at scale `1`, one edge. -/
private def unitPair : UDCert 2 where
  verts := unitPairTable.toVerts
  edges := [(0, 1)]
  denom := 1

/-- Its difference witness. The one difference is `verts 0 - verts 1 = (-1, 0)`, in the orientation
`ValidOn` reads, and `(-1)² + 0² = 1 = denom²`. -/
private def unitPairDiffs : DiffWitness 2 where
  verts := unitPairTable
  packedV := .node 1 (.leaf (Pt.pack ⟨0, 0⟩)) (.leaf (Pt.pack ⟨1, 0⟩))
  diffs := .leaf ⟨-1, 0⟩
  packedD := .leaf (Pt.pack ⟨-1, 0⟩)
  keys := [0]

example : unitPairDiffs.Check unitPair = true := by sorry

/-- **Non-vacuity, all the way through**: the cheap route really does yield the old claim, on a
certificate whose hypotheses are all satisfied. -/
example : unitPair.Valid = true :=
  unitPair.valid_of_diffWitness unitPairDiffs rfl (by sorry)

/-- **The adversarial member.** Point the single key at a difference that is not this edge's:
`edgesOk` must go `false`. Without this, every theorem above could hold of a `Check` that is
constantly `true`. -/
example :
    ({ unitPairDiffs with
        diffs := .node 1 (.leaf ⟨-1, 0⟩) (.leaf ⟨-2, 0⟩)
        packedD := .node 1 (.leaf (Pt.pack ⟨-1, 0⟩)) (.leaf (Pt.pack ⟨-2, 0⟩))
        keys := [1] } : DiffWitness 2).Check unitPair = false := by sorry

/-- **A short key list must fail, not truncate.** The one control that a `List.zip` formulation
would have passed. -/
example : ({ unitPairDiffs with keys := [] } : DiffWitness 2).Check unitPair = false := by sorry

/-- **A wrong norm must fail** — the geometry moved off the unit circle. -/
example :
    ({ unitPairDiffs with
        diffs := .leaf ⟨-2, 0⟩, packedD := .leaf (Pt.pack ⟨-2, 0⟩) } :
      DiffWitness 2).Check unitPair = false := by sorry

/-- **A mismatched table shape must fail**, so that a lookup by index cannot mean two different
things in the two tables. -/
example :
    ({ unitPairDiffs with packedV := .leaf (Pt.pack ⟨0, 0⟩) } :
      DiffWitness 2).Check unitPair = false := by sorry

/-- The packing separates the two points this certificate actually carries — the concrete instance
of `Pt.pack_inj`, and the thing that would be false if the lanes were too narrow. -/
example : Pt.pack ⟨0, 0⟩ ≠ Pt.pack ⟨1, 0⟩ := by sorry

end Spec

end HadwigerNelson

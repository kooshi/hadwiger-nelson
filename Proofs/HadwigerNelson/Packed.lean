import Proofs.HadwigerNelson.Certificate

/-!
# Structure-aware geometry — one norm per distinct difference, one subtraction per edge

The certificate check this file replaces recomputes a squared distance for every listed edge:
7,877 of them for de Grey's graph, at 0.0246 CPU s and 4.55 MB each. Two facts make almost all of
that work redundant.

**A distance depends only on a difference, and these graphs have very few distinct differences.**
De Grey's 7,877 edges have 133 distinct difference vectors; Heule's 510- and 553-vertex witnesses
have 66 and 82. So the expensive part — two squarings in `ℚ(√3,√5,√7,√11)` — can be paid once per
*difference*, and each edge only has to agree that its endpoints differ by the difference it names.

**And that agreement need not be checked coordinate by coordinate.** A point is 32 integers. Packing
them into a single `ℤ`, one 32-bit lane each, makes the packing a *linear* map — so a difference of
packed points is the packed difference, exactly, with no borrow between lanes to reason about — and
the per-edge check becomes one big-integer subtraction and one comparison. Measured: **0.00137 CPU s
and 0.27 MB per edge**, against a list walk carrying no arithmetic at all at 0.0011 s. The arithmetic
has effectively vanished.

Together: de Grey's geometry falls from 194 CPU s to a projected 17, and from 35.8 GB spread across
nine modules to 2.6 GB in one.

## The one idea, in three costumes

Everything below is base-`2^laneBits` positional notation with small digits:

* `Packable` is *"this type is a fixed number of integer digits"*. `Int` is one digit; a two-lane
  shape is twice its lane's digits. Both `Adjoin d K` — a level of the field tower — and `Pt` — two
  coordinates — are two-lane shapes, which is why both are instances and neither is a special case.
* `two_digit_le` and `two_digit_inj` are the *whole* arithmetic content: a two-digit numeral with
  small digits fits its width, and its digits are recoverable from it. Every `pack_le` and
  `pack_inj` below is one of those two lemmas applied, never re-argued.
* The per-edge check is *"the difference of two numerals is a third numeral"*, which is one
  subtraction precisely because positional notation is linear.

## What is trusted

Nothing here. `DiffWitness` is data an untrusted generator emits, and every field of it is checked:
a wrong difference, a wrong index, a wrong packing, a leaf out of range, or a `keys` list of the
wrong length each make `Check` return `false`. None of them can make a theorem false.

The claim this file produces is `UDCert.Valid = true` — *the same claim* the per-edge route produces,
so nothing downstream of a certificate changes shape.

## The lane arithmetic, stated once

A vertex leaf is bounded by `vertexBound = 2^29`, so a difference of two is within `2^30`, and the
one condition the digit lemmas ask — `2 * b + 2 ≤ 2 ^ laneBits` — holds at `2^31 + 2 ≤ 2^32`.
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

/-! ## Digits

Two facts about integers, and the milestone's entire arithmetic content. Everything below cites
them; nothing re-argues them. -/

/-- **A two-digit numeral in base `M` fits in `M²`**, when each digit fits in half of `M`.

The `+ 2` is not slack. The step is `(M − 2) + M(M − 2) + 2 = M² − M ≤ M²`, and the same statement
with a bare `<` fails by exactly one. -/
theorem two_digit_le {M a b : Int} (hM : 0 < M)
    (ha : 2 * |a| + 2 ≤ M) (hb : 2 * |b| + 2 ≤ M) :
    2 * |a + M * b| + 2 ≤ M * M := by sorry

/-- **A two-digit numeral in base `M` determines its digits**, when the low digits fit in half of
`M`. The high digits need no bound of their own: once the low ones agree, `M * (b − d) = 0`.

This is `pack_inj` at every level of the tower and at `Pt` — one argument, three citations. -/
theorem two_digit_inj {M a b c d : Int} (hM : 0 < M)
    (ha : 2 * |a| + 2 ≤ M) (hc : 2 * |c| + 2 ≤ M)
    (h : a + M * b = c + M * d) : a = c ∧ b = d := by sorry

/-! ## Packable

`Packable K` says: a value of `K` is a fixed number of integer digits, laid end to end in lanes of
`laneBits` bits.

**The class carries its own subtraction rather than borrowing `Sub` or `CommRing`**, and that is the
decision the rest of the file rests on. Two consequences, both wanted:

* `Pt` becomes an ordinary instance. It is two coordinates and no algebra, and inventing one for it
  would be a fiction — but it is a two-lane shape exactly as a tower level is, and the shape is all
  the packing ever reads.
* Instance search has one candidate per head symbol and no algebraic side condition to discharge.
  Indexed on `[CommRing K]` — the first shape tried, because `pack_sub` looked like it needed a
  `Sub` — `Packable Q4` failed to synthesize at every use site: the failure `NatScalar` records in
  its own docstring next door, arriving on schedule.

On a tower level the class's subtraction is `rfl`-equal to the ring's, so nothing downstream has to
choose between them. -/

/-- Bits per lane. One lane per integer leaf of a point.

Measured, not chosen for comfort: 64-bit lanes cost 28% more per edge than these, because the
per-edge cost is now literal width rather than arithmetic. -/
def laneBits : ℕ := 32

/-- A type whose values are a fixed number of integer digits in base `2 ^ laneBits`. -/
class Packable (K : Type) where
  /-- The digits of `x`, laid end to end, low lanes first. -/
  pack : K → Int
  /-- How many lanes `pack` consumes. -/
  width : ℕ
  /-- `bnd b x` — every digit of `x` has absolute value at most `b`. `Bool`-valued, because the
  certificate check runs it. -/
  bnd : Int → K → Bool
  /-- Digitwise subtraction. A field rather than an inherited `Sub`, so that `Pt` — which has no
  algebra — is an ordinary member of this class. -/
  sub : K → K → K
  /-- **Linearity.** The reason the per-edge check is one subtraction. -/
  pack_sub : ∀ x y : K, pack (sub x y) = pack x - pack y
  /-- A difference of bounded values is bounded, doubled. -/
  bnd_sub : ∀ (b : Int) (x y : K), bnd b x = true → bnd b y = true → bnd (2 * b) (sub x y) = true
  /-- **The lane bound** — `two_digit_le`, lifted. -/
  pack_le : ∀ (b : Int) (x : K), 2 * b + 2 ≤ 2 ^ laneBits → bnd b x = true →
    2 * |pack x| + 2 ≤ 2 ^ (laneBits * width)
  /-- **Injectivity on bounded values** — `two_digit_inj`, lifted, and the load-bearing law. -/
  pack_inj : ∀ (b : Int) (x y : K), 2 * b + 2 ≤ 2 ^ laneBits →
    bnd b x = true → bnd b y = true → pack x = pack y → x = y

namespace Packable

/-- The leaf: an integer is one digit and is its own packing. -/
instance instInt : Packable Int where
  pack := id
  width := 1
  bnd b z := decide (|z| ≤ b)
  sub a b := a - b
  pack_sub := by sorry
  bnd_sub := by sorry
  pack_le := by sorry
  pack_inj := by sorry

/-- A level of the field tower: the real part in the low lanes, the `√d` coefficient in the high
ones. `d` is never read — packing is a fact about the shape of the data, not about the field. -/
instance instAdjoin {d : ℕ} {K : Type} [Packable K] : Packable (Adjoin d K) where
  pack x := pack x.re + 2 ^ (laneBits * width K) * pack x.im
  width := 2 * width K
  bnd b x := bnd b x.re && bnd b x.im
  sub x y := ⟨sub x.re y.re, sub x.im y.im⟩
  pack_sub := by sorry
  bnd_sub := by sorry
  pack_le := by sorry
  pack_inj := by sorry

/-- A point: the abscissa in the low lanes, the ordinate in the high ones — structurally the same
two-lane shape as a tower level, and the four laws are the same two digit lemmas again. -/
instance instPt : Packable Pt where
  pack p := pack p.x + 2 ^ (laneBits * width Q4) * pack p.y
  width := 2 * width Q4
  bnd b p := bnd b p.x && bnd b p.y
  sub p q := ⟨sub p.x q.x, sub p.y q.y⟩
  pack_sub := by sorry
  bnd_sub := by sorry
  pack_le := by sorry
  pack_inj := by sorry

end Packable

/-! ### Points

`Pt` is a `Packable` like any other; what it adds is the geometry — a squared length, and the one
definitional identity the milestone turns on. -/

/-- The squared length of a difference vector. -/
def Pt.normSq (v : Pt) : Q4 := FastSq.sq v.x + FastSq.sq v.y

/-- **The distance is the norm of the difference, definitionally.**

This single `rfl` is why a difference table certifies edges at all: `UDCert.ValidOn` asks for
`distSq`, the witness supplies a difference and its `normSq`, and there is nothing in between. -/
theorem Pt.normSq_sub (p q : Pt) : (Packable.sub p q).normSq = p.distSq q := rfl

/-! ### The witness

Every check below is a **structural walk over the data it checks** — no index list, no range, no
arithmetic on positions. That is not tidiness: `List.range` plus `List.map` costs ~0.83 ms *per
element* in this kernel, which at 1581 vertices would be 1.3 s of pure bookkeeping, and an index
built by hand needs a proof that it is in range — a `sorry` waiting to be written into a definition. -/

/-- A table of integers indexed by `Nat` — the packed sibling of `PtTable`, same balanced split of
the index range, same flat lookup cost at every index.

**It is a second copy of `PtTable`, and it stays one.** The role — *a balanced index table* — is real
and unnamed, but naming it would mean generalising `PtTable` in `Certificate.lean`, which sits
upstream of 2,466 certificate modules holding 28.8 hours of kernel work. So the generalisation could
not collapse two declarations into one; it would leave two and add a type parameter. The duplication
is paid deliberately, and it goes away the next time `Certificate.lean` is legitimately edited. -/
inductive IntTable where
  /-- A subtable covering exactly one index. -/
  | leaf : Int → IntTable
  /-- `node m l r` — indices below `m` are `l`'s; the rest are `r`'s, renumbered from zero. -/
  | node : Nat → IntTable → IntTable → IntTable
deriving Repr

/-- Look up index `i`. Structural on the table, so a lookup costs the table's depth.

**Totality is denied out of range**, exactly as `PtTable.get` denies it: `Nat` subtraction truncates
and a too-large index returns *some* integer. Every caller here compares the result against another
table entry, so an out-of-range index makes a check false rather than a claim wrong. -/
def IntTable.get : IntTable → Nat → Int
  | .leaf v, _ => v
  | .node m l r, i => if i < m then l.get i else r.get (i - m)

/-- The largest leaf a certificate's vertex may carry. A difference of two lands within `2 ^ 30`,
which is exactly what the digit lemmas admit. De Grey's largest leaf is 1920. -/
def vertexBound : Int := 2 ^ 29

/-- **What the generator emits so the kernel can check a graph's geometry cheaply.**

The certificate's *vertex* table is not a field here. It already exists, compiled, in the instance's
own module, and re-emitting it would duplicate the one literal that costs 28 s to elaborate — so it
is a parameter of `Check`, shared with the hypothesis that ties it to the certificate. A witness
therefore holds only what is new, and cannot hold a vertex table that disagrees with one.

Nothing here is trusted and nothing needs to be: every field is compared against the certificate by
`Check`, and a wrong entry makes the check `false`. -/
structure DiffWitness (n : ℕ) where
  /-- `Packable.pack` of each vertex, **in a table of the same shape as the certificate's vertex
  table**. -/
  packedV : IntTable
  /-- The distinct edge difference vectors, exact, in first-use order. -/
  diffs : PtTable
  /-- `Packable.pack` of each difference, in a table of the same shape as `diffs`. -/
  packedD : IntTable
  /-- One index into `diffs` per edge, in the certificate's own edge order. -/
  keys : List ℕ

namespace DiffWitness

variable {n : ℕ}

/-- **A point table and its packing, walked together**: every leaf packs to what the packed table
holds, every leaf is within `b`, and the two tables have the same shape.

Same shape is not decoration — the per-edge check looks a vertex up by index in `packedV`, and the
soundness proof has to know the index means the same point in the vertex table. Requiring `m == m'`
at every node is how that is established rather than assumed.

Measured **0.00196 CPU s per entry**. -/
def packOk (b : Int) : PtTable → IntTable → Bool
  | .leaf p, .leaf v => Packable.bnd b p && (v == Packable.pack p)
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

`t` is the certificate's own vertex table; `UDCert.valid_of_diffWitness` is what ties it to `c`. The
difference bound is `2 * vertexBound`, because a difference of two vertices within `vertexBound`
lands there and `2 * (2 * vertexBound) + 2 ≤ 2 ^ laneBits`. -/
def Check (w : DiffWitness n) (t : PtTable) (c : UDCert n) : Bool :=
  packOk vertexBound t w.packedV
    && packOk (2 * vertexBound) w.diffs w.packedD
    && normsOk c.denomSq w.diffs
    && w.edgesOk c.edges w.keys

/-! ### What the walks establish, extracted once

The soundness proof needs each walk in pointwise form, and so does every diagnostic. Each is proved
by the induction its own recursion performs. -/

/-- Same shape, so `get` at an index means the same entry in both tables. -/
theorem packOk_pack {b : Int} {t : PtTable} {u : IntTable} (h : packOk b t u = true) (i : ℕ) :
    u.get i = Packable.pack (t.get i) := by sorry

/-- …and every entry is inside the bound. -/
theorem packOk_bnd {b : Int} {t : PtTable} {u : IntTable} (h : packOk b t u = true) (i : ℕ) :
    Packable.bnd b (t.get i) = true := by sorry

/-- `normsOk` in pointwise form — at every index, including out of range, since `PtTable.get` is
total and every leaf was checked. -/
theorem normsOk_get {target : Q4} {t : PtTable} (h : normsOk target t = true) (i : ℕ) :
    (t.get i).normSq = target := by sorry

/-- `edgesOk` in pointwise form: every edge in the list is paired with some key, and its endpoints'
packed difference is that key's packed difference. -/
theorem edgesOk_mem {w : DiffWitness n} {es : List (Fin n × Fin n)} {ks : List ℕ}
    (h : w.edgesOk es ks = true) (e : Fin n × Fin n) (he : e ∈ es) :
    ∃ k, w.packedV.get e.1.val - w.packedV.get e.2.val = w.packedD.get k := by sorry

end DiffWitness

/-- **Soundness.** A witness that checks certifies the certificate — the same `UDCert.Valid = true`
the per-edge route produces, from data that costs an order of magnitude less to verify.

`hverts` says the vertex table is the certificate's own, and is `rfl` for every emitted certificate —
the same arrangement `UDCert.valid_of_chunks` makes with its join hypothesis. `h` is a closed `Bool`
the kernel decides. Nothing else about the witness is assumed. -/
theorem UDCert.valid_of_diffWitness {n : ℕ} (c : UDCert n) (t : PtTable) (w : DiffWitness n)
    (hverts : c.verts = t.toVerts) (h : w.Check t c = true) : c.Valid = true := by sorry

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
  packedV := .node 1 (.leaf (Packable.pack (⟨0, 0⟩ : Pt))) (.leaf (Packable.pack (⟨1, 0⟩ : Pt)))
  diffs := .leaf ⟨-1, 0⟩
  packedD := .leaf (Packable.pack (⟨-1, 0⟩ : Pt))
  keys := [0]

example : unitPairDiffs.Check unitPairTable unitPair = true := by sorry

/-- **Non-vacuity, all the way through**: the cheap route really does yield the old claim, on a
certificate whose hypotheses are all satisfied. -/
example : unitPair.Valid = true :=
  unitPair.valid_of_diffWitness unitPairTable unitPairDiffs rfl (by sorry)

/-- **The adversarial member.** Point the single key at a difference that is not this edge's:
`edgesOk` must go `false`. Without this, every theorem above could hold of a `Check` that is
constantly `true`. -/
example :
    ({ unitPairDiffs with
        diffs := .node 1 (.leaf ⟨-1, 0⟩) (.leaf ⟨-2, 0⟩)
        packedD := .node 1 (.leaf (Packable.pack (⟨-1, 0⟩ : Pt)))
                           (.leaf (Packable.pack (⟨-2, 0⟩ : Pt)))
        keys := [1] } : DiffWitness 2).Check unitPairTable unitPair = false := by sorry

/-- **A short key list must fail, not truncate.** The one control a `List.zip` formulation would
have passed. -/
example :
    ({ unitPairDiffs with keys := [] } : DiffWitness 2).Check unitPairTable unitPair = false := by
  sorry

/-- **A wrong norm must fail** — the geometry moved off the unit circle. -/
example :
    ({ unitPairDiffs with
        diffs := .leaf ⟨-2, 0⟩, packedD := .leaf (Packable.pack (⟨-2, 0⟩ : Pt)) } :
      DiffWitness 2).Check unitPairTable unitPair = false := by sorry

/-- **A mismatched table shape must fail**, so that a lookup by index cannot mean two different
things in the two tables. -/
example :
    ({ unitPairDiffs with packedV := .leaf (Packable.pack (⟨0, 0⟩ : Pt)) } :
      DiffWitness 2).Check unitPairTable unitPair = false := by sorry

/-! `Packable` is a claim about *shape*, so the shape is pinned: `Q4` is sixteen digits, a point is
thirty-two, the class's subtraction on a tower level is the ring's, and the packing separates the two
points this certificate actually carries.

The last one goes through the **kernel** rather than the elaborator, and that is not a style
preference. A point's packing multiplies by `2 ^ 512`; the elaborator refuses to evaluate an
exponent past 256 and then dies on recursion depth, while the kernel computes it in one
GMP-accelerated step. Every check in this file is in the same position, which is why the emitted
theorems all say `decide +kernel`. -/

#guard Packable.width Q4 = 16
#guard Packable.width Pt = 32
example (a b : Q4) : Packable.sub a b = a - b := rfl
example : Packable.pack (⟨0, 0⟩ : Pt) ≠ Packable.pack (⟨1, 0⟩ : Pt) := by decide +kernel

end Spec

end HadwigerNelson

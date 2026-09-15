import Proofs.HadwigerNelson.LocalGlobal
import Proofs.HadwigerNelson.Critical

/-!
# A colouring of a finite Euclidean plane as one packed `Bool` — the Cayley form

FS-53 needs upper bounds `χ(UD(𝔽_q, 2)) ≤ k` at planes with up to 6,241 vertices. The shape
`Instances/FinitePlane11.lean` uses — `decide +kernel` over every ordered pair — costs `q⁴` adjacency
tests: 14,641 at `q = 11`, but 279,841 at 23, 3.4 million at 43 and 4.9 million at 47.

The plane is a Cayley graph, so properness is equivalent to a statement over the connection set alone,

> for every circle point `s` and every vertex `v`, the colours of `v` and `v + s` differ,

which is `(q+1)·q²` tests — 12,696 at 23, 81,356 at 43, 106,032 at 47, a factor `q²/(q+1)` cheaper
(22× at 23, 42× at 47). `LocalGlobal.addCayleyColoring` already consumes exactly that hypothesis.

Three rules from `CLAUDE.md` § The kernel's cost model shape the rest, and each is a decision, not a
style: a `∀ x ∈ l` under `decide` costs an order of magnitude more than the same check as a `Bool`, so
everything here is a `Bool` recovered by `List.all_eq_true`; a numeral at an unsimplified type index is
paid per numeral, so the table carries no `ZMod q` literals and vertices are `ℕ` identifiers
`v = x·q + y`; and a `Nat` literal costs ≈ 2.3 KB of olean against ≈ 145 bytes per literal node, so the
whole colouring is **one** `Nat`, read by `unpackColor` (M04's rule, `Critical.lean`).

## The direction the circle is checked in, and why it is that direction

`Cert.covers` asks that the listed circle **contains** every point of quadrance one — not that the two
sets are equal. The asymmetry is load-bearing. A *missing* circle point drops edges from the graph the
`Bool` examines, makes a colouring easier, and would let an unsound certificate pass; a *spurious* point
only makes the check harder and can never make a false theorem true. This is `CLAUDE.md` G21's rule —
the finding and refusing sides fail in opposite directions — applied to the kernel: the check is written
in the direction whose failure mode is unsound, and its negative control is a certificate whose circle
list is one point short, which must be refused.

## What this module is not

It is an **upper**-bound instrument only. Nothing here refuses a colouring, and a `Cert` that fails
`check` says nothing whatever about `χ`.

## `finitePlane 27` is not the plane over `𝔽₂₇`

`finitePlane q` is `unitQuadrance (ZMod q)`, the unit-quadrance graph of the **ring** `ℤ/q`. For a prime
that is the finite Euclidean plane; for `q = 27` it is not — `ℤ/27` is not `𝔽₂₇`, and the two graphs are
different objects. FS-53's eighth window member is the plane over the *field* `𝔽₂₇ = 𝔽₃[t]/(t³ − t − 1)`,
which needs a concrete `CommRing` with `DecidableEq` that this library has not got (subplan §S7 D-8).
Nothing in this module may be instantiated at `q = 27` and read as a statement about that member.
-/

namespace HadwigerNelson

open SimpleGraph

namespace CayleyCert

variable {q : ℕ}

/-! ### Vertices as natural numbers -/

/-- The identifier of a plane point: `v = x·q + y`, little-endian in `y`. -/
def toId (q : ℕ) (v : ZMod q × ZMod q) : ℕ := v.1.val * q + v.2.val

/-- The point an identifier names. -/
def ofId (q i : ℕ) : ZMod q × ZMod q := ((i / q : ℕ), (i % q : ℕ))

/-- Addition of points, carried out on identifiers — the only arithmetic the packed check performs. -/
def addId (q i j : ℕ) : ℕ := ((i / q + j / q) % q) * q + ((i % q + j % q) % q)

/-- The quadrance of the point an identifier names, as a natural number below `q`. -/
def quadId (q i : ℕ) : ℕ := ((i / q) ^ 2 + (i % q) ^ 2) % q

theorem toId_lt [NeZero q] (v : ZMod q × ZMod q) : toId q v < q * q := by
  sorry

theorem ofId_toId [NeZero q] (v : ZMod q × ZMod q) : ofId q (toId q v) = v := by
  sorry

theorem toId_ofId [NeZero q] {i : ℕ} (h : i < q * q) : toId q (ofId q i) = i := by
  sorry

/-- Identifier arithmetic is point arithmetic — the bridge the soundness proof crosses exactly once. -/
theorem toId_add [NeZero q] (u v : ZMod q × ZMod q) :
    toId q (u + v) = addId q (toId q u) (toId q v) := by
  sorry

/-- A point lies on the unit circle exactly when its identifier's quadrance reads one. -/
theorem mem_unitCircle_iff [Fact (1 < q)] (v : ZMod q × ZMod q) :
    v ∈ unitCircle (ZMod q) ↔ quadId q (toId q v) = 1 := by
  sorry

/-! ### The certificate -/

/-- **A packed colouring certificate for a unit-quadrance plane.** `table` holds one `bits`-wide colour
field per vertex identifier; `circle` lists the connection set by identifier. All five fields are
untrusted data: `check` is the only `Bool` the kernel decides, and `sound` is the once-proved bridge. -/
structure Cert where
  /-- The modulus: the plane is `unitQuadrance (ZMod q)`. -/
  q : ℕ
  /-- How many colours the table claims to use. -/
  k : ℕ
  /-- The width of a packed colour field. A tuning parameter: soundness holds for every value. -/
  bits : ℕ
  /-- The colouring, packed little-endian by vertex identifier. -/
  table : ℕ
  /-- The connection set, by vertex identifier. -/
  circle : List ℕ

namespace Cert

/-- The listed circle **covers** the true circle. The covering direction, never equality — see the
module docstring. -/
def covers (c : Cert) : Bool :=
  (List.range (c.q * c.q)).all fun i => quadId c.q i != 1 || c.circle.contains i

/-- No listed circle point joins two vertices of the same colour. -/
def proper (c : Cert) : Bool :=
  c.circle.all fun s =>
    (List.range (c.q * c.q)).all fun v =>
      unpackColor c.bits c.k c.table v != unpackColor c.bits c.k c.table (addId c.q v s)

/-- The single `Bool` the kernel decides. -/
def check (c : Cert) : Bool := (0 < c.k) && c.covers && c.proper

/-- The colouring the table names, as a function on the plane. -/
def colouring (c : Cert) (hk : 0 < c.k) (v : ZMod c.q × ZMod c.q) : Fin c.k :=
  ⟨unpackColor c.bits c.k c.table (toId c.q v), Nat.mod_lt _ hk⟩

/-- **Soundness.** A certificate that passes `check` colours the plane. The whole trust surface of
every upper bound FS-53 reports is this one theorem plus the kernel's evaluation of `check`. -/
theorem sound {c : Cert} [Fact (1 < c.q)] (h : c.check = true) :
    (unitQuadrance (ZMod c.q)).Colorable c.k := by
  sorry

/-! ### The spec, validated where it is cheap

Every definition above is pinned by a computation that would fail if it drifted, and the certificate
format is exhibited on a real plane before anything large is attempted. -/

-- the identifier arithmetic at `q = 11`, the plane whose value the kernel already holds
#guard toId 11 (3, 4) = 37
#guard addId 11 (toId 11 (3, 4)) (toId 11 (9, 8)) = toId 11 ((3, 4) + (9, 8))
#guard quadId 11 (toId 11 (0, 1)) = 1
#guard quadId 11 (toId 11 (3, 4)) = 3   -- `3² + 4² = 25 ≡ 3`: not a circle point

/-- **A model of the hypothesis: the whole certificate format, exhibited at `q = 3`.** The plane over
`𝔽₃` is 3-chromatic, its circle is `{(0,±1), (±1,0)}` — identifiers `1, 2, 3, 6` — and `(x, y) ↦ x + y`
is a proper colouring, packed two bits per vertex into the single natural number `74340`. This passes
`check`, so `Cert.sound`'s hypothesis is inhabited and the vacuity gate has a witness at hand. -/
def cert3 : Cert := ⟨3, 3, 2, 74340, [1, 2, 3, 6]⟩

#guard cert3.check

-- Red: the covering check earns its keep. The same certificate with an empty circle list is refused
-- — (0, 1) has quadrance one and is not listed. A certificate whose circle list is short describes a
-- graph with edges missing, which is exactly the failure a colouring must not be allowed to survive.
#guard !(Cert.check ⟨3, 3, 2, 74340, []⟩)

-- Red: a corrupted table is refused. Repainting vertex 0 with the colour of its neighbour (0, 1)
-- makes the circle point 1 monochromatic.
#guard !(Cert.check ⟨3, 3, 2, 74340 + 1, [1, 2, 3, 6]⟩)

end Cert

end CayleyCert

end HadwigerNelson

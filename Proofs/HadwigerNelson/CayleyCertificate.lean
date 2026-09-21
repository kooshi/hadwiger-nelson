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

## Measured cost

Desktop (16 physical cores, 125 GB), CPU seconds = user + sys, minimum of three
runs of `lake env lean` on a pair of files differing in exactly one line. All three rows colour the
**same** plane with the **same** table; only the shape of the `Bool` differs.

| what the kernel evaluates | tests | CPU | peak RSS |
|---|---|---|---|
| `cert23Eight.check (IdArith.zmod 23 …)` — this module, at `q = 23` | 12,696 pairs + 529 quadrances | **1.49 s** | +324 MB |
| the all-pairs `decide +kernel` at `q = 23` — `FinitePlane11.lean`'s shape, same colouring | 279,841 ordered pairs | **did not complete** | 31.4 GB |
| the all-pairs `decide +kernel` at `q = 11` — `FinitePlane11.lean` as it stands | 14,641 ordered pairs | 9.47 s | +1,980 MB |

The all-pairs row at 23 is not a slow answer but **no answer**: the elaborator spent 163.6 s of CPU
and 31.4 GB of resident memory and then stopped at the default 200,000-heartbeat limit with the
question undecided. Raising the limit is a payday loan (DEBRUIJN `error_reflexes`) and 31.4 GB for one
module already exceeds the ≈ 9 GB per module `scripts/build.sh` sizes its batches against, so the
all-pairs shape is not merely dearer at 23 — it is not a thing this repository can build.

Two comparisons, with their denominators spelled out, because they are different comparisons. **Same
plane, same table, only the `Bool`'s shape differing:** 1.49 s against no answer at all, at `q = 23`.
**Comparable test counts, at different `q` and therefore not a controlled comparison:** 12,696 Cayley
tests at 23 cost 1.49 s where 14,641 all-pairs tests at 11 cost 9.47 s — 0.87 times the tests for 0.16
times the CPU, on a plane 4.4 times larger.

The whole module, every `#guard` and both `Colorable` theorems included, elaborates in 4.16 s of CPU at a peak of 3.3 GB.

## The direction the circle is checked in, and why it is that direction

`Cert.covers` asks that the listed circle **contains** every point of quadrance one — not that the two
sets are equal. The asymmetry is load-bearing. A *missing* circle point drops edges from the graph the
`Bool` examines, makes a colouring easier, and would let an unsound certificate pass; a *spurious* point
only makes the check harder and can never make a false theorem true. This is `CLAUDE.md` G21's rule —
the finding and refusing sides fail in opposite directions — applied to the kernel: the check is written
in the direction whose failure mode is unsound, and its negative control is a certificate whose circle
list is one point short, which must be refused.

`Cert.covers_iff` is the statement that the `Bool` says exactly that and nothing more, so a *correct*
certificate is never refused either. The two halves of that `iff` are what the two round-trip laws of
`IdArith` are for.

## What this module is not

It is an **upper**-bound instrument only. Nothing here refuses a colouring, and a `Cert` that fails
`check` says nothing whatever about `χ`.

## `finitePlane 27` is not the plane over `𝔽₂₇`, and here that is a type

`finitePlane q` is `unitQuadrance (ZMod q)`, the unit-quadrance graph of the **ring** `ℤ/q`. For a prime
that is the finite Euclidean plane; for `q = 27` it is not — `ℤ/27` is not `𝔽₂₇`, and the two graphs are
different objects. FS-53's eighth window member is the plane over the *field* `𝔽₂₇ = 𝔽₃[t]/(t³ − t − 1)`.

The certificate is therefore **generic over an `IdArith R`** (subplan §S12.1 D-13) rather than
hard-wired to `ZMod q`: `Cert.sound` concludes about `unitQuadrance R` for whatever `R` the arithmetic
names, so a certificate for the eighth member requires an `IdArith F27` — which this library has not
got — and cannot be obtained by instantiating anything here at 27. `IdArith.zmod 27` exists and is
honest: it certifies colourings of the plane over the ring `ℤ/27` and of nothing else. What used to be
a docstring's warning is now the type-checker's business.
-/

namespace HadwigerNelson

open SimpleGraph

namespace CayleyCert

/-! ### The identifier arithmetic

A certificate is a table indexed by natural numbers; the plane is a set of ring elements. An
`IdArith R` is the dictionary between them, and it is an explicit argument rather than a class: a
plane has several perfectly good identifier conventions (base-`q` digits, base-3 digits, a Zech
logarithm), and a structure one would ever want to swap was never an instance. -/

/-- **An identifier scheme for the plane `R × R`.** `toId` names a point by a natural number below
`nverts`, `ofId` reads the name back, and `addId`/`quadId` carry out on names the two operations the
kernel's `Bool` performs: adding a circle point to a vertex, and asking whether a name is a circle
point.

The five laws are what make the dictionary faithful, and they are not interchangeable:

* `toId_lt` and `quadId_toId_iff`'s forward half are what `Cert.sound` consumes, with `toId_add`;
* `toId_ofId` and `quadId_toId_iff`'s backward half are what make `Cert.covers` *exactly* the
  covering condition rather than something stronger (`Cert.covers_iff`), so that no good certificate
  is refused;
* `ofId_toId` says the naming is injective, which with the others pins `nverts` to the vertex count
  (`nverts_eq_card`) — the law that stops a scheme from quietly describing a coarser graph.

There is deliberately **no** `Fintype` or `DecidableEq` on `R`: `Cert.check` is arithmetic on `ℕ`
and `Cert.sound`'s proof uses neither, so demanding them would be a hypothesis no proof spends. -/
structure IdArith (R : Type*) [CommRing R] where
  /-- The number of vertex identifiers: every point's name is below it. -/
  nverts : ℕ
  /-- The name of a point. -/
  toId : R × R → ℕ
  /-- The point a name denotes. -/
  ofId : ℕ → R × R
  /-- Addition of points, carried out on names — the only arithmetic the packed check performs. -/
  addId : ℕ → ℕ → ℕ
  /-- The quadrance of the point a name denotes, as a natural number. -/
  quadId : ℕ → ℕ
  /-- Every name is below `nverts`, so `List.range nverts` reaches every point. -/
  toId_lt : ∀ v, toId v < nverts
  /-- Naming is injective. -/
  ofId_toId : ∀ v, ofId (toId v) = v
  /-- Every name below `nverts` denotes a point that carries it. -/
  toId_ofId : ∀ {i : ℕ}, i < nverts → toId (ofId i) = i
  /-- **Identifier arithmetic is point arithmetic** — the bridge soundness crosses exactly once. -/
  toId_add : ∀ u v, toId (u + v) = addId (toId u) (toId v)
  /-- A name reads quadrance one exactly when it denotes a circle point. -/
  quadId_toId_iff : ∀ v, quadId (toId v) = 1 ↔ v ∈ unitCircle R

namespace IdArith

variable {R : Type*} [CommRing R] (A : IdArith R)

/-- Naming is injective — `ofId` is a retraction. -/
theorem toId_injective : Function.Injective A.toId :=
  Function.LeftInverse.injective A.ofId_toId

/-- **The identifier count is the vertex count.** Nothing above says so directly: `toId_lt` with
injectivity gives `card ≤ nverts`, and `toId_ofId` makes `ofId` injective on the names, giving
`nverts ≤ card`. A scheme that quietly skipped a point, or carried a name denoting none, would fail
one of the two halves — which is what those two laws are for. -/
theorem nverts_eq_card [Fintype R] : A.nverts = Fintype.card R * Fintype.card R := by
  have hle : Fintype.card (R × R) ≤ A.nverts := by
    have := Fintype.card_le_of_injective (fun v => (⟨A.toId v, A.toId_lt v⟩ : Fin A.nverts))
      (fun u v h => A.toId_injective (congrArg Fin.val h))
    simpa using this
  have hge : A.nverts ≤ Fintype.card (R × R) := by
    have : Function.Injective (fun i : Fin A.nverts => A.ofId i.val) := by
      intro i j h
      have := congrArg A.toId h
      rw [A.toId_ofId i.isLt, A.toId_ofId j.isLt] at this
      exact Fin.val_injective this
    simpa using Fintype.card_le_of_injective _ this
  have := le_antisymm hge hle
  rwa [Fintype.card_prod] at this

end IdArith

/-! ### The certificate -/

/-- **A packed colouring certificate for a unit-quadrance plane.** `table` holds one `bits`-wide
colour field per vertex identifier; `circle` lists the connection set by identifier. All four fields
are untrusted data: `check` is the only `Bool` the kernel decides, and `sound` is the once-proved
bridge. The plane itself is not named here — an `IdArith R` supplies it, so the same data checked
against a different arithmetic is a claim about a different graph and says so in its type. -/
structure Cert where
  /-- How many colours the table claims to use. -/
  k : ℕ
  /-- The width of a packed colour field. A tuning parameter: soundness holds for every value. -/
  bits : ℕ
  /-- The colouring, packed little-endian by vertex identifier. -/
  table : ℕ
  /-- The connection set, by vertex identifier. -/
  circle : List ℕ

namespace Cert

variable {R : Type*} [CommRing R]

/-- The listed circle **covers** the true circle. The covering direction, never equality — see the
module docstring. -/
def covers (c : Cert) (A : IdArith R) : Bool :=
  (List.range A.nverts).all fun i => A.quadId i != 1 || c.circle.contains i

/-- No listed circle point joins two vertices of the same colour.

The vertex walk is the **outer** loop and the circle the inner one, so that `List.range A.nverts` is
written once rather than once per circle point. **Measured, and the measurement is the reason this
paragraph is not stronger:** at `q = 23` the two orders cost 4.19 s and 4.17 s for the whole module —
a difference inside run-to-run variation, so the kernel's `whnf` cache evidently absorbs the repeated
`List.range`, and the naive prediction (24 rebuilds of a 529-node list) is simply not what happens.
The order is kept because it is the honest shape and costs nothing, not because it was found to
matter. At a larger `q`, or for an index list built by `List.range` *and* `List.map` — which is the
construction `CLAUDE.md` § The kernel's cost model actually prices, at about 0.83 ms per element —
the question would have to be measured again. -/
def proper (c : Cert) (A : IdArith R) : Bool :=
  (List.range A.nverts).all fun v =>
    c.circle.all fun s =>
      unpackColor c.bits c.k c.table v != unpackColor c.bits c.k c.table (A.addId v s)

/-- The single `Bool` the kernel decides. -/
def check (c : Cert) (A : IdArith R) : Bool := (0 < c.k) && c.covers A && c.proper A

/-- The colouring the table names, as a function on the plane. -/
def colouring (c : Cert) (A : IdArith R) (hk : 0 < c.k) (v : R × R) : Fin c.k :=
  ⟨unpackColor c.bits c.k c.table (A.toId v), Nat.mod_lt _ hk⟩

/-- **`covers` says exactly what it is meant to say.** The `Bool` walks identifiers, not points; this
is the statement that the walk misses nothing (forward, the half `sound` spends) and demands nothing
extra (backward, the half that keeps a good certificate from being refused). -/
theorem covers_iff (c : Cert) (A : IdArith R) :
    c.covers A = true ↔ ∀ v : R × R, v ∈ unitCircle R → A.toId v ∈ c.circle := by
  rw [covers, List.all_eq_true]
  constructor
  · intro h v hv
    have hrow := h (A.toId v) (List.mem_range.mpr (A.toId_lt v))
    simp only [Bool.or_eq_true, bne_iff_ne, ne_eq] at hrow
    rcases hrow with hne | hmem
    · exact absurd ((A.quadId_toId_iff v).mpr hv) hne
    · exact List.mem_of_elem_eq_true hmem
  · intro h i hi
    rw [List.mem_range] at hi
    simp only [Bool.or_eq_true, bne_iff_ne, ne_eq]
    by_cases hq : A.quadId i = 1
    · refine Or.inr ?_
      have hid : A.toId (A.ofId i) = i := A.toId_ofId hi
      have : A.ofId i ∈ unitCircle R := (A.quadId_toId_iff _).mp (by rw [hid]; exact hq)
      have := h _ this
      rw [hid] at this
      exact List.elem_eq_true_of_mem this
    · exact Or.inl hq

/-- **Soundness.** A certificate that passes `check` colours the plane. The whole trust surface of
every upper bound FS-53 reports is this one theorem plus the kernel's evaluation of `check`. -/
theorem sound (c : Cert) (A : IdArith R) (h : c.check A = true) :
    (unitQuadrance R).Colorable c.k := by
  rw [check, Bool.and_eq_true, Bool.and_eq_true, decide_eq_true_eq] at h
  obtain ⟨⟨hk, hcov⟩, hprop⟩ := h
  refine ⟨addCayleyColoring (D := unitCircle R) (c.colouring A hk) ?_⟩
  intro s hs v
  -- (i) the circle point is listed, by `covers` in its covering direction
  have h1 : A.toId s ∈ c.circle := (covers_iff c A).mp hcov s hs
  -- (ii) properness at that listed point and at this vertex
  have h2 := List.all_eq_true.mp
    (List.all_eq_true.mp hprop (A.toId v) (List.mem_range.mpr (A.toId_lt v))) (A.toId s) h1
  rw [bne_iff_ne, ne_eq] at h2
  -- (iii) identifier addition is point addition
  refine fun hcon => h2 ?_
  have := congrArg Fin.val hcon
  simp only [colouring] at this
  rw [← A.toId_add v s]
  exact this.symm

end Cert

/-! ### The identifier arithmetic of the ring `ZMod q`

Base `q`: `v = x·q + y`. The five laws below are this milestone's only arithmetic obligations, and
each is `ℕ`-arithmetic once `ZMod.val` has been moved across. They are stated as standalone theorems
rather than only as fields of `IdArith.zmod` because they are the whole API of `toId`, `ofId`,
`addId` and `quadId`: no proof downstream unfolds those four definitions. -/

section ZMod

variable {q : ℕ}

/-- The identifier of a plane point over `ZMod q`: `v = x·q + y`, little-endian in `y`. -/
def toId (q : ℕ) (v : ZMod q × ZMod q) : ℕ := v.1.val * q + v.2.val

/-- The point an identifier names. -/
def ofId (q i : ℕ) : ZMod q × ZMod q := ((i / q : ℕ), (i % q : ℕ))

/-- Addition of points, carried out on identifiers — the only arithmetic the packed check performs. -/
def addId (q i j : ℕ) : ℕ := ((i / q + j / q) % q) * q + ((i % q + j % q) % q)

/-- The quadrance of the point an identifier names, as a natural number below `q`. -/
def quadId (q i : ℕ) : ℕ := ((i / q) ^ 2 + (i % q) ^ 2) % q

/-- The high digit of an identifier is the first coordinate. -/
theorem toId_div [NeZero q] (v : ZMod q × ZMod q) : toId q v / q = v.1.val := by
  have hq : 0 < q := Nat.pos_of_ne_zero (NeZero.ne q)
  rw [toId, Nat.add_comm, Nat.add_mul_div_right _ _ hq, Nat.div_eq_of_lt (ZMod.val_lt v.2),
    Nat.zero_add]

/-- The low digit of an identifier is the second coordinate. -/
theorem toId_mod [NeZero q] (v : ZMod q × ZMod q) : toId q v % q = v.2.val := by
  rw [toId, Nat.add_comm, Nat.add_mul_mod_self_right, Nat.mod_eq_of_lt (ZMod.val_lt v.2)]

theorem toId_lt [NeZero q] (v : ZMod q × ZMod q) : toId q v < q * q := by
  have h1 := ZMod.val_lt v.1
  have h2 := ZMod.val_lt v.2
  calc toId q v = v.1.val * q + v.2.val := rfl
    _ < v.1.val * q + q := by omega
    _ = (v.1.val + 1) * q := by ring
    _ ≤ q * q := Nat.mul_le_mul_right q h1

theorem ofId_toId [NeZero q] (v : ZMod q × ZMod q) : ofId q (toId q v) = v := by
  simp only [ofId, toId_div, toId_mod, ZMod.natCast_zmod_val]

theorem toId_ofId [NeZero q] {i : ℕ} (h : i < q * q) : toId q (ofId q i) = i := by
  have hq : 0 < q := Nat.pos_of_ne_zero (NeZero.ne q)
  have hdiv : i / q < q := Nat.div_lt_of_lt_mul h
  have hmod : i % q < q := Nat.mod_lt _ hq
  rw [toId, ofId, ZMod.val_cast_of_lt hdiv, ZMod.val_cast_of_lt hmod, Nat.div_add_mod']

/-- Identifier arithmetic is point arithmetic — the bridge the soundness proof crosses exactly once. -/
theorem toId_add [NeZero q] (u v : ZMod q × ZMod q) :
    toId q (u + v) = addId q (toId q u) (toId q v) := by
  rw [addId, toId_div, toId_mod, toId_div, toId_mod, toId, Prod.fst_add, Prod.snd_add,
    ZMod.val_add, ZMod.val_add]

/-- A point lies on the unit circle exactly when its identifier's quadrance reads one.

`1 < q` is not decoration: at `q = 1` the ring is trivial, every point lies on the circle, and
`quadId 1` is identically `0`, so the equivalence is false — `zmod_one_no_circle_law` below is that
failure, decided. -/
theorem mem_unitCircle_iff (hq : 1 < q) (v : ZMod q × ZMod q) :
    v ∈ unitCircle (ZMod q) ↔ quadId q (toId q v) = 1 := by
  haveI : NeZero q := ⟨by omega⟩
  have hcast : ((v.1.val ^ 2 + v.2.val ^ 2 : ℕ) : ZMod q) = v.1 ^ 2 + v.2 ^ 2 := by
    push_cast [ZMod.natCast_zmod_val]
    ring
  rw [quadId, toId_div, toId_mod, Set.mem_setOf_eq, ← hcast,
    show (1 : ZMod q) = ((1 : ℕ) : ZMod q) by norm_cast, ZMod.natCast_eq_natCast_iff, Nat.ModEq,
    Nat.mod_eq_of_lt hq]

/-- `1 < q` gives `NeZero q`, supplied explicitly below so that `IdArith.zmod` stays a plain
constructor application: a `haveI` in the body wraps it in a `let_fun` that the kernel will not see
through, and `check` would then not evaluate at all. -/
private theorem neZero_of_one_lt (hq : 1 < q) : NeZero q := ⟨by omega⟩

/-- **The identifier arithmetic of the plane over the ring `ZMod q`.**

`1 < q` is an explicit argument and not a `Fact` instance: an unscoped `Fact (1 < q)` is speech into
every future instance search (DEBRUIJN `global_speech_acts`), and the proofs below reach the law at
`q = 1` through `Nat.mod_eq_of_lt` rather than through `ZMod.val_one`, so nothing needs it resolved. -/
def IdArith.zmod (q : ℕ) (hq : 1 < q) : IdArith (ZMod q) where
  nverts := q * q
  toId := CayleyCert.toId q
  ofId := CayleyCert.ofId q
  addId := CayleyCert.addId q
  quadId := CayleyCert.quadId q
  toId_lt := @CayleyCert.toId_lt q (neZero_of_one_lt hq)
  ofId_toId := @CayleyCert.ofId_toId q (neZero_of_one_lt hq)
  toId_ofId := @CayleyCert.toId_ofId q (neZero_of_one_lt hq)
  toId_add := @CayleyCert.toId_add q (neZero_of_one_lt hq)
  quadId_toId_iff := fun v => (CayleyCert.mem_unitCircle_iff hq v).symm

@[simp] theorem IdArith.zmod_nverts (q : ℕ) (hq : 1 < q) : (IdArith.zmod q hq).nverts = q * q := rfl

end ZMod

/-! ### The spec, validated where it is cheap

Every definition above is pinned by a computation that would fail if it drifted, and the certificate
format is exhibited on a real plane before anything large is attempted. -/

section Spec

/-- `1 < q` at `q = 3`, spelled once for the exhibits below. -/
private theorem one_lt_three : (1 : ℕ) < 3 := by norm_num

/-- `1 < q` at `q = 23`, the window's smallest member. -/
private theorem one_lt_twentyThree : (1 : ℕ) < 23 := by norm_num

-- the identifier arithmetic at `q = 11`, the plane whose value the kernel already holds
#guard toId 11 (3, 4) = 37
#guard addId 11 (toId 11 (3, 4)) (toId 11 (9, 8)) = toId 11 ((3, 4) + (9, 8))
#guard quadId 11 (toId 11 (0, 1)) = 1
#guard quadId 11 (toId 11 (3, 4)) = 3   -- `3² + 4² = 25 ≡ 3`: not a circle point

/-- **Red, and it is why `1 < q` is a hypothesis and not a convenience.** At `q = 1` the ring is
trivial, so every point satisfies `v.1² + v.2² = 1` and the circle is the whole plane, while
`quadId 1` is identically zero. The law `mem_unitCircle_iff` is therefore **false** at `q = 1`, and
the kernel says so. Drop `hq` from that theorem and this `example` is what stands refuted. -/
example : ¬ (∀ v : ZMod 1 × ZMod 1, v ∈ unitCircle (ZMod 1) ↔ quadId 1 (toId 1 v) = 1) := by decide

/-- **A model of the hypothesis: the whole certificate format, exhibited at `q = 3`.** The plane over
`𝔽₃` is 3-chromatic, its circle is `{(0,±1), (±1,0)}` — identifiers `1, 2, 3, 6` — and `(x, y) ↦ x + y`
is a proper colouring, packed two bits per vertex into the single natural number `74340`. This passes
`check`, so `Cert.sound`'s hypothesis is inhabited and the vacuity gate has a witness at hand. -/
def cert3 : Cert := ⟨3, 2, 74340, [1, 2, 3, 6]⟩

#guard cert3.check (IdArith.zmod 3 one_lt_three)

/-- The 3-plane is 3-colourable, by the certificate — the pipeline end to end in one line. -/
theorem colorable_finitePlane3 : (finitePlane 3).Colorable 3 :=
  Cert.sound cert3 (IdArith.zmod 3 one_lt_three) (by decide +kernel)

-- Red: the covering check earns its keep. The same certificate with an empty circle list is refused
-- — (0, 1) has quadrance one and is not listed. A certificate whose circle list is short describes a
-- graph with edges missing, which is exactly the failure a colouring must not be allowed to survive.
#guard !(Cert.check ⟨3, 2, 74340, []⟩ (IdArith.zmod 3 one_lt_three))

-- Red: a corrupted table is refused. Repainting vertex 0 with the colour of its neighbour (0, 1)
-- makes the circle point 1 monochromatic.
#guard !(Cert.check ⟨3, 2, 74340 + 1, [1, 2, 3, 6]⟩ (IdArith.zmod 3 one_lt_three))

/-- **The 23-plane, eight colours — the first kernel-checked upper bound at a window member.**

The colouring is the line-periodic one of `data/fplane/periodic-below-71.json`'s `p = 23` row, whose
23 entries live on the quotient by the direction `(1, 2)`; the plane's 529 colours are its lift
`colour(x·23 + y) = row[(x + 2y) mod 23]`, packed three bits per vertex into one 1,587-bit natural
number. Re-verified here from the definition of `UD(𝔽₂₃, 2)` before packing: 8 colours, 0
monochromatic edges of 6,348.

It is an **upper** bound and decides nothing: six at 23 is open, and `χ(UD(𝔽₂₃,2)) ∈ {5, 6, 7, 8}`. -/
def cert23Eight : Cert :=
  ⟨8, 3, 184618122629798387792121645237466383710703425883693632143438788017073065155621357143428249034984189576893819321437758172309172411181512148965727454609627777461633962492936391663273591075379431105169015898717477506176899676931241322880128544522843582921780427695276852495288468574397229917152503342388387371677363860868413058238915368011765143476365025765575168432797443237244175098545138132675297194139944557459318291071357740947214457201590322503727964164926230720794579332080,
   [1, 22, 23, 102, 105, 195, 196, 216, 221, 234, 249, 261, 268, 284, 291, 303, 318, 331, 336, 356, 357, 447, 450, 506]⟩

#guard cert23Eight.check (IdArith.zmod 23 one_lt_twentyThree)

/-- **`χ(UD(𝔽₂₃, 2)) ≤ 8`**, by the packed certificate — the kernel's first statement about any
member of FS-53's eight-member window. -/
theorem colorable_finitePlane23_eight : (finitePlane 23).Colorable 8 :=
  Cert.sound cert23Eight (IdArith.zmod 23 one_lt_twentyThree) (by decide +kernel)

-- The packed data, pinned: the origin's colour, its circle neighbour's, and the far corner's, so a
-- regenerated table that silently changed is caught at the build.
#guard unpackColor cert23Eight.bits cert23Eight.k cert23Eight.table 0 = 0
#guard unpackColor cert23Eight.bits cert23Eight.k cert23Eight.table 1 = 6
#guard unpackColor cert23Eight.bits cert23Eight.k cert23Eight.table 528 = 0
#guard cert23Eight.circle.length = 24

end Spec

end CayleyCert

end HadwigerNelson

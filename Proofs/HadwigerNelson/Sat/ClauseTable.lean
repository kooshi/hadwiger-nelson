import Proofs.HadwigerNelson.Sat.Mask

/-!
# The clause table

Every clause the refutation touches — the formula's own, and every clause the solver derived — lives
in one table, emitted as a **literal** by `tools/`, and re-checked here against the formula Lean
computes for itself.

## Why a literal, and why chunks

Two measurements settle the shape (`plans/M05-kernel-checker.md` § 0):

**A table the kernel *builds* is unusable.** Grown by a chain of `insert`s, one lookup costs time
proportional to the size of the whole table, because a structure built from N nested function
applications takes O(N) work to reach weak head normal form and each of its sub-terms costs again.
Measured: 2.14 ms per lookup at 2,381 clauses, **16.7 ms at 33,089** — 60 days for the full proof.
A literal has no such cost: its every node is already in normal form. This is the same conclusion
M04 reached for the vertex table, arrived at from the opposite direction.

**But a table of 37,000 `Nat` literals is unusable too**, for the other reason: a `Nat` literal costs
about 2.3 KB of compiled module, so one per clause is ~85 MB per formula. Packing many clauses into
each big `Nat` — the same trick as the checker itself — brings it to ~1.5 MB, and measurement shows
the packing costs nothing: lookup time is flat in chunk size across a 23× range, because the shifts
and masks involved are hardware operations at any width.

So: a pivot-split tree of a few hundred big `Nat` chunks, each chunk a block of fixed-width clause
slots, each slot a run of packed literal fields. Measured at 37,000 clauses: 2.4 MB of source,
12.7 s to elaborate, ~2.5 ms per lookup, flat in table size.

## The packing parameters live in the table

They are not a separate `Layout` passed alongside. The emitter chose them, they are untrusted exactly
as the chunks are, and `agreesWithCNF` re-derives the formula through them — so they are part of the
emitted datum, and a wrong one can only make the check fail. Keeping them out of the table meant
threading them through `rup`, `runActions` and `runChunks`, none of which ever inspect them.

The **certificate's** field width is a different number and stays elsewhere (`Sat/MaskCheck.lean`):
one blob's packing is not the other's, and the two optima need not coincide.

## The trust boundary

Nothing in the table is trusted. `agreesWithCNF` compares the table's first `n` slots against literal
sets that *Lean* computes from the formula, and the soundness theorem takes that comparison as a
hypothesis. The clauses above that prefix — the solver's derived clauses — are trusted by nobody
either: the checker justifies each one before it may be cited.
-/

namespace HadwigerNelson

open Std.Sat

/-- The chunk tree: a pivot split whose leaves are big `Nat`s.

`node m l r` sends indices below `m` to `l` and the rest to `r`, renumbered from zero — M04's
`PtTable` shape, over chunks instead of points. A lookup costs the tree's *depth* in reduction steps,
identically for every index, which is what keeps per-cube timings uniform. -/
inductive Chunks where
  /-- One big `Nat` holding a block of packed clause slots. -/
  | leaf : Nat → Chunks
  /-- `node m l r` — chunk indices below `m` are `l`'s, the rest are `r`'s, renumbered from zero. -/
  | node : Nat → Chunks → Chunks → Chunks
deriving Repr, Inhabited

/-- Fetch chunk `i`.

**Totality is denied out of range:** `Nat` subtraction truncates, so a too-large index returns *some*
chunk rather than failing. Reaching it means the emitter and the packing parameters disagree, and the
consequence is a failed check, never a false theorem — every clause the checker cites has already
been justified or compared against the formula. The spec section pins the junk value. -/
def Chunks.get : Chunks → Nat → Nat
  | .leaf w, _ => w
  | .node m l r, i => if i < m then l.get i else r.get (i - m)

/-- The emitted clause table: how it is packed, and the packed data.

A single uniform slot width, not one per chunk. **This is the cheapest adequate choice, not
necessarily the final one** — a per-chunk width read from a chunk header would stop one long derived
clause from padding every slot, at the cost of one more reduction step per lookup. Which wins depends
on the real distribution of derived-clause lengths, which is unmeasured; see
`plans/M05-kernel-checker.md` § 7. -/
structure ClauseTable where
  /-- Bits per packed literal field. 24 covers 8·10⁶ variables. -/
  field : Nat
  /-- Literal capacity of one slot. A slot with fewer literals is zero-terminated. -/
  lits : Nat
  /-- Clause slots per chunk. -/
  perChunk : Nat
  /-- The packed data. -/
  chunks : Chunks
deriving Repr, Inhabited

namespace ClauseTable

/-- Bits per clause slot. -/
def slotBits (t : ClauseTable) : Nat := t.field * t.lits

/-- Decode a slot's packed literal fields into a literal set.

The encoding: field value `0` terminates; otherwise `e = fld - 1` holds the variable in its high bits
and the sign in bit 0, so `e / 2` is the variable and `e % 2` says which side it joins. Shifting the
*remainder* right by one field each step keeps the work linear in the field count rather than
quadratic in the chunk size.

Structural on `n`, the slot's literal capacity — so no termination argument, and no well-founded
recursion for the kernel to unfold. `fw` is passed rather than projected so the projection is paid
once per lookup instead of once per literal. -/
def unpackAux (fw : Nat) : Nat → Nat → LitSet → LitSet
  | 0,     _, L => L
  | n + 1, w, L =>
      let fld := w % (2 ^ fw)
      if fld == 0 then L
      else
        let e := fld - 1
        let v := e / 2
        if e % 2 == 0 then unpackAux fw n (w >>> fw) ⟨L.pos ||| (1 <<< v), L.neg⟩
        else unpackAux fw n (w >>> fw) ⟨L.pos, L.neg ||| (1 <<< v)⟩

/-- Clause `id`, as a literal set: descend to its chunk, shift its slot down, decode its fields.

This is the checker's inner-loop lookup, and it is where the milestone's time goes — about 2.5 ms per
call at de Grey's scale, against a propagation step's arithmetic, which is free. -/
def get (t : ClauseTable) (id : Nat) : LitSet :=
  let w := (t.chunks.get (id / t.perChunk)) >>> ((id % t.perChunk) * t.slotBits)
  unpackAux t.field t.lits (w % (2 ^ t.slotBits)) ⟨0, 0⟩

/-- The table's first slots hold exactly the formula's clauses, and none of them is a tautology.

Recursion carries the id alongside the clause list rather than indexing by position, because
`List.range` and `List.map` cost about 0.83 ms *per element* in the kernel — measured, and a defect in
this project's own benchmark harness before it was a design note. -/
def agreesAux (t : ClauseTable) : Nat → List (CNF.Clause Nat) → Bool
  | _,  []      => true
  | id, c :: cs =>
      let L := LitSet.ofClause c
      L.ok && t.get id == L && t.agreesAux (id + 1) cs

/-- **The trust boundary, as one kernel-decidable `Bool`.** The emitted table really does hold the
formula in its first `f.clauses.size` slots.

A tautological clause in the *formula* makes this fail rather than being silently dropped. Dropping
would be sound — removing clauses only makes propagation harder — but silent acceptance of input the
checker then cannot use is the failure mode this project has already been bitten by twice, so it
fails loudly instead. Neither the colouring encoding nor a cube's unit clauses can produce one. -/
def agreesWithCNF (t : ClauseTable) (f : CNF Nat) : Bool :=
  t.agreesAux 0 f.clauses.toList

end ClauseTable

/-- Clause ids below `w` are settled: each is a genuine, non-tautological consequence of `f`.

The checker's whole invariant. It moves in one direction only — a watermark, never a mutation — which
is what lets the clause table be a literal. -/
def Justified (t : ClauseTable) (f : CNF Nat) (w : Nat) : Prop :=
  ∀ id, id < w → (t.get id).Ok ∧ (t.get id).Entails f

/-- **The base case of the induction.** A table that agrees with the formula justifies exactly the
formula's own clause ids. -/
theorem justified_of_agreesWithCNF {t : ClauseTable} {f : CNF Nat}
    (h : t.agreesWithCNF f = true) : Justified t f f.clauses.size := by
  sorry

/-! ## Spec

The packing is exercised at a size where every claim can be read off by hand, and checked against
`LitSet.ofClause` — the definition that *means* "these are the formula's clauses" — rather than
against itself. -/

section Spec

/-- Field encoding of a literal: variable `v`, `s` true for a positive occurrence. -/
private def fld (v : Nat) (s : Bool) : Nat := (if s then 2 * v else 2 * v + 1) + 1

/-- `(x ∨ y)` then `(x ∨ ¬y)` packed into one chunk, with variables 0 and 1. -/
private def chunk0 : Nat :=
  (fld 0 true ||| (fld 1 true <<< 8)) ||| ((fld 0 true ||| (fld 1 false <<< 8)) <<< 16)

/-- `(¬x ∨ y)` then `(¬x ∨ ¬y)`. -/
private def chunk1 : Nat :=
  (fld 0 false ||| (fld 1 true <<< 8)) ||| ((fld 0 false ||| (fld 1 false <<< 8)) <<< 16)

/-- Two literals per slot, two slots per chunk, 8-bit fields: small enough to read in binary. -/
private def tbl : ClauseTable :=
  { field := 8, lits := 2, perChunk := 2, chunks := .node 1 (.leaf chunk0) (.leaf chunk1) }

#guard tbl.slotBits == 16

-- The four clauses come back out, and they agree with the list form independently compiled.
#guard tbl.get 0 == LitSet.ofClause [(0, true), (1, true)]
#guard tbl.get 1 == LitSet.ofClause [(0, true), (1, false)]
#guard tbl.get 2 == LitSet.ofClause [(0, false), (1, true)]
#guard tbl.get 3 == LitSet.ofClause [(0, false), (1, false)]

/-- The formula the table claims to hold. -/
private def f4 : CNF Nat :=
  ⟨#[[(0, true), (1, true)], [(0, true), (1, false)],
     [(0, false), (1, true)], [(0, false), (1, false)]]⟩

#guard tbl.agreesWithCNF f4

-- **The negative control.** One corrupted slot, and the boundary check goes red. A `#guard` that
-- could not fail proves nothing, so this is the partner of the one above.
#guard !({ tbl with chunks := .node 1 (.leaf (chunk0 + 1)) (.leaf chunk1) } : ClauseTable).agreesWithCNF f4

-- ...and a table that is right but claimed against a *different* formula.
#guard !tbl.agreesWithCNF ⟨#[[(0, true), (1, true)], [(2, true)]]⟩

-- The packing parameters are part of the datum: right chunks, wrong slot width, check fails.
#guard !({ tbl with lits := 1 } : ClauseTable).agreesWithCNF f4

-- A short clause is zero-terminated, not padded with a spurious literal.
#guard ({ tbl with chunks := .leaf (fld 3 true) } : ClauseTable).get 0
        == ({ pos := 1 <<< 3, neg := 0 } : LitSet)

-- **The denied obligation, pinned.** Out of range, `Chunks.get` returns a chunk rather than failing.
#guard tbl.chunks.get 99 == chunk1

end Spec

end HadwigerNelson

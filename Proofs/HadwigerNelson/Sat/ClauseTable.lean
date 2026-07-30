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

**But a table of 37,000 `Nat` literals is unusable too**, for the other reason: a `Nat` literal
costs about 2.3 KB of compiled module, so one per clause is ~85 MB per formula. Packing many clauses
into each big `Nat` — the same trick as the checker itself — brings it to ~1.5 MB, and measurement
shows the packing costs nothing: lookup time is flat in chunk size across a 23× range, because the
shifts and masks involved are hardware operations at any width.

So: a pivot-split tree of a few hundred big `Nat` chunks, each chunk a block of fixed-width clause
slots, each slot a run of packed literal fields. Measured at 37,000 clauses: 2.4 MB of source,
12.7 s to elaborate, ~2.5 ms per lookup, flat in table size.

## The trust boundary

Nothing in the table is trusted. `agreesWithCNF` compares the table's first `n` slots against masks
that *Lean* computes from the formula, and the soundness theorem takes that comparison as a
hypothesis. An emitter bug can only make the comparison fail. The clauses above that prefix — the
solver's derived clauses — are trusted by nobody either: the checker justifies each one before it
may be cited.
-/

namespace HadwigerNelson

open Std.Sat

/-- The clause table: a pivot-split tree whose leaves are big `Nat` chunks.

`node m l r` sends indices below `m` to `l` and the rest to `r`, renumbered from zero — M04's
`PtTable` shape, over chunks instead of points. A lookup costs the tree's *depth* in reduction
steps, identically for every index, which is what keeps per-cube timings uniform. -/
inductive ClauseTable where
  /-- A chunk: one big `Nat` holding a block of packed clause slots. -/
  | leaf : Nat → ClauseTable
  /-- `node m l r` — chunk indices below `m` are `l`'s, the rest are `r`'s, renumbered from zero. -/
  | node : Nat → ClauseTable → ClauseTable → ClauseTable
deriving Repr, Inhabited

/-- Fetch chunk `i`.

**Totality is denied out of range:** `Nat` subtraction truncates, so a too-large index returns
*some* chunk rather than failing. Reaching it means the emitter and the layout disagree, and the
consequence is a failed check, never a false theorem — every clause the checker cites has already
been justified or compared against the formula. The spec section pins the junk value. -/
def ClauseTable.chunk : ClauseTable → Nat → Nat
  | .leaf w, _ => w
  | .node m l r, i => if i < m then l.chunk i else r.chunk (i - m)

/-- How the emitter packed the table: field width, literals per slot, slots per chunk.

A single uniform slot width, not one per chunk. **This is the cheapest adequate choice, not
necessarily the final one** — a per-chunk width read from a chunk header would stop one long derived
clause from padding every slot, at the cost of one more reduction step per lookup. Which wins depends
on the real distribution of derived-clause lengths, which is unmeasured; see
`plans/M05-kernel-checker.md` § 7. -/
structure Layout where
  /-- Bits per packed literal field. 24 covers 8·10⁶ variables. -/
  field : Nat
  /-- Literal capacity of one slot. A slot with fewer literals is zero-terminated. -/
  lits : Nat
  /-- Clause slots per chunk. -/
  perChunk : Nat
deriving DecidableEq, Repr, Inhabited

/-- Bits per clause slot. -/
def Layout.slotBits (L : Layout) : Nat := L.field * L.lits

/-- Decode a slot's packed literal fields into two bit sets.

The encoding: field value `0` terminates; otherwise `e = fld - 1` holds the variable in its high
bits and the sign in bit 0, so `e / 2` is the variable and `e % 2` says which mask it joins. Shifting
the *remainder* right by one field each step keeps the work linear rather than re-shifting from the
base every time.

Structural on `n`, the layout's literal capacity — so no termination argument, and no well-founded
recursion for the kernel to unfold. -/
def unpackAux (L : Layout) : Nat → Nat → MClause → MClause
  | 0,     _, c => c
  | n + 1, w, c =>
      let fld := w % (2 ^ L.field)
      if fld == 0 then c
      else
        let e := fld - 1
        let v := e / 2
        if e % 2 == 0 then unpackAux L n (w >>> L.field) ⟨c.pos ||| (1 <<< v), c.neg⟩
        else unpackAux L n (w >>> L.field) ⟨c.pos, c.neg ||| (1 <<< v)⟩

/-- Clause `id`, as masks: descend to its chunk, shift its slot down, decode its fields.

This is the checker's inner-loop lookup, and it is where the milestone's time goes — about 2.5 ms
per call at de Grey's scale, against a propagation step's arithmetic which is free. -/
def ClauseTable.get (L : Layout) (t : ClauseTable) (id : Nat) : MClause :=
  let w := (t.chunk (id / L.perChunk)) >>> ((id % L.perChunk) * L.slotBits)
  unpackAux L L.lits (w % (2 ^ L.slotBits)) ⟨0, 0⟩

/-- The table's first slots hold exactly the formula's clauses, and none of them is a tautology.

Recursion carries the id alongside the clause list rather than indexing by position, because
`List.range` and `List.map` cost about 0.83 ms *per element* in the kernel — measured, and a defect
in this project's own benchmark harness before it was a design note. -/
def agreesAux (L : Layout) (t : ClauseTable) : Nat → List (CNF.Clause Nat) → Bool
  | _,  []      => true
  | id, c :: cs =>
      let m := MClause.ofClause c
      m.ok && t.get L id == m && agreesAux L t (id + 1) cs

/-- **The trust boundary, as one kernel-decidable `Bool`.** The emitted table really does hold the
formula in its first `f.clauses.size` slots.

A tautological clause in the *formula* makes this fail rather than being silently dropped. Dropping
would be sound — removing clauses only makes propagation harder — but silent acceptance of input the
checker then cannot use is the failure mode this project has already been bitten by twice, so it
fails loudly instead. Neither the colouring encoding nor a cube's unit clauses can produce one. -/
def agreesWithCNF (L : Layout) (t : ClauseTable) (f : CNF Nat) : Bool :=
  agreesAux L t 0 f.clauses.toList

/-- Clause ids below `w` are settled: each is a genuine, non-tautological consequence of `f`.

The checker's whole invariant. It moves in one direction only — a watermark, never a mutation — which
is what lets the clause table be a literal. -/
def Justified (L : Layout) (t : ClauseTable) (f : CNF Nat) (w : Nat) : Prop :=
  ∀ id, id < w → (t.get L id).Ok ∧ ∀ a, CNF.eval a f = true → MClause.Sat a (t.get L id)

/-- **The base case of the induction.** A table that agrees with the formula justifies exactly the
formula's own clause ids. -/
theorem justified_of_agreesWithCNF {L : Layout} {t : ClauseTable} {f : CNF Nat}
    (h : agreesWithCNF L t f = true) : Justified L t f f.clauses.size := by
  sorry

/-! ## Spec

The layout is exercised at a size where every claim can be read off by hand, and the packing is
checked against `MClause.ofClause` — the definition that *means* "these are the formula's clauses" —
rather than against itself. -/

section Spec

/-- Two literals per slot, two slots per chunk, 8-bit fields: small enough to read in binary. -/
private def L2 : Layout := { field := 8, lits := 2, perChunk := 2 }

/-- Field encoding of a literal: variable `v`, `s` true for a positive occurrence. -/
private def fld (v : Nat) (s : Bool) : Nat := (if s then 2 * v else 2 * v + 1) + 1

#guard L2.slotBits == 16

/-- `(x ∨ y)` then `(x ∨ ¬y)` packed into one chunk, with variables 0 and 1. -/
private def chunk0 : Nat :=
  (fld 0 true ||| (fld 1 true <<< 8)) ||| ((fld 0 true ||| (fld 1 false <<< 8)) <<< 16)

/-- `(¬x ∨ y)` then `(¬x ∨ ¬y)`. -/
private def chunk1 : Nat :=
  (fld 0 false ||| (fld 1 true <<< 8)) ||| ((fld 0 false ||| (fld 1 false <<< 8)) <<< 16)

private def tbl : ClauseTable := .node 1 (.leaf chunk0) (.leaf chunk1)

-- The four clauses come back out, and they agree with the list form independently compiled.
#guard tbl.get L2 0 == MClause.ofClause [(0, true), (1, true)]
#guard tbl.get L2 1 == MClause.ofClause [(0, true), (1, false)]
#guard tbl.get L2 2 == MClause.ofClause [(0, false), (1, true)]
#guard tbl.get L2 3 == MClause.ofClause [(0, false), (1, false)]

/-- The formula the table claims to hold. -/
private def f4 : CNF Nat :=
  ⟨#[[(0, true), (1, true)], [(0, true), (1, false)],
     [(0, false), (1, true)], [(0, false), (1, false)]]⟩

#guard agreesWithCNF L2 tbl f4

-- **The negative control.** One corrupted slot, and the boundary check goes red. A `#guard` that
-- could not fail proves nothing, so this is the partner of the one above.
private def tblBad : ClauseTable := .node 1 (.leaf (chunk0 + 1)) (.leaf chunk1)
#guard !agreesWithCNF L2 tblBad f4

-- ...and a table that is right but claimed against a *different* formula.
private def f4' : CNF Nat := ⟨#[[(0, true), (1, true)], [(2, true)]]⟩
#guard !agreesWithCNF L2 tbl f4'

-- A short clause is zero-terminated, not padded with a spurious literal.
#guard (ClauseTable.leaf (fld 3 true)).get L2 0 == ({ pos := 1 <<< 3, neg := 0 } : MClause)

-- **The denied obligation, pinned.** Out of range, `chunk` returns a chunk rather than failing.
#guard tbl.chunk 99 == chunk1

end Spec

end HadwigerNelson

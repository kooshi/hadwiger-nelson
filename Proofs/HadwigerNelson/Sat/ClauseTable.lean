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

## The reasoning surface

`ClauseTable.get` and `unpackAux` exist to be *fast*, not to be read: their shapes are chosen for
reduction-step count. Reason through `justified_of_agreesWithCNF`, diagnose with `#eval t.firstFault f`,
and never unfold either. If a proof wants to, a lemma is missing.

## The trust boundary

Nothing in the table is trusted. `agreesWithCNF` compares the table's first `n` slots against literal
sets that *Lean* computes from the formula, and the soundness theorem takes that comparison as a
hypothesis. The clauses above that prefix — the solver's derived clauses — are trusted by nobody
either: the checker justifies each one before it may be cited.
-/

namespace HadwigerNelson

open Std.Sat

/-- The chunk tree: a pivot split whose leaves carry a slot capacity and a big `Nat`.

`node m l r` sends indices below `m` to `l` and the rest to `r`, renumbered from zero — M04's
`PtTable` shape, over chunks instead of points. A lookup costs the tree's *depth* in reduction steps,
identically for every index, which is what keeps per-segment timings uniform.

**The slot capacity is per chunk, and that is a measured decision** (`plans/M06-chi-ge-five.md`
§ 2.2). A learned clause database has a long tail — measured on de Grey's halves: median 19
literals, 99th percentile 86, longest 227 — so one uniform capacity pads every short clause out to
the longest in the whole table: 145 MB against 68 MB for half A. M05 chose uniform and recorded
medium confidence pending this distribution. -/
inductive Chunks where
  /-- `leaf lits w` — one big `Nat` holding a block of packed clause slots, each with capacity
  `lits` literal fields. -/
  | leaf : Nat → Nat → Chunks
  /-- `node m l r` — chunk indices below `m` are `l`'s, the rest are `r`'s, renumbered from zero. -/
  | node : Nat → Chunks → Chunks → Chunks
deriving Repr, Inhabited

/-- Fetch chunk `i`: its slot capacity and its packed data.

**Totality is denied out of range:** `Nat` subtraction truncates, so a too-large index returns *some*
chunk rather than failing. Reaching it means the emitter and the packing parameters disagree, and the
consequence is a failed check, never a false theorem — every clause the checker cites has already
been justified or compared against the formula. The spec section pins the junk value. -/
def Chunks.get : Chunks → Nat → Nat × Nat
  | .leaf lits w, _ => (lits, w)
  | .node m l r, i => if i < m then l.get i else r.get (i - m)

/-- The emitted clause table: how it is packed, and the packed data. The slot capacity lives in
each chunk (see `Chunks`), so this holds only what is genuinely uniform. -/
structure ClauseTable where
  /-- Bits per packed literal field. 14 covers 8192 variables; 24 covers 8·10⁶. -/
  field : Nat
  /-- Clause slots per chunk. Uniform, which is what keeps the index arithmetic a division. -/
  perChunk : Nat
  /-- The packed data. -/
  chunks : Chunks
deriving Repr, Inhabited

namespace ClauseTable

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

This is the checker's inner-loop lookup, and it is where the milestone's time goes. Measured on a
real de Grey table through `decide +kernel`: **1.35 ms per lookup-and-propagate**, against a
propagation step's arithmetic, which is free. -/
def get (t : ClauseTable) (id : Nat) : LitSet :=
  let c := t.chunks.get (id / t.perChunk)
  let sb := t.field * c.1
  unpackAux t.field c.1 ((c.2 >>> ((id % t.perChunk) * sb)) % (2 ^ sb)) ⟨0, 0⟩

end ClauseTable

/-! ### Diagnosis

A `Bool` that comes back `false` over 33,089 clauses is useless to whoever has to fix it. So the
diagnostic is the **primary** definition and the `Bool` is derived from it — `agreesWithCNF` *is*
"there is no fault". M04 kept the two as separate functions related by a proved lemma
(`badEdges_eq_nil_iff`); defining one from the other is strictly better, because drift between them
stops being possible rather than being ruled out by an obligation someone has to maintain. -/

/-- Why the emitted table does not hold the formula.

Carries the observed value alongside the wanted one, so the reader is told what is wrong rather than
being sent to compare two `#eval`s by hand. -/
inductive TableFault where
  /-- Slot `id` holds `held`, but the formula's clause at that position compiles to `wanted`. -/
  | slotMismatch (id : Nat) (held wanted : LitSet)
  /-- Slot `id` agrees with the formula, but that clause is a tautology, which the checker cannot
  use. Neither the colouring encoding nor a cube's unit clauses can produce one. -/
  | tautology (id : Nat) (held : LitSet)
deriving DecidableEq, Repr, Inhabited

namespace ClauseTable

/-- Walk the formula's clauses against the table's slots from `id`, reporting the first fault.

Recursion carries the id alongside the clause list rather than indexing by position, because
`List.range` and `List.map` cost about 0.83 ms *per element* in the kernel — measured, and a defect in
this project's own benchmark harness before it was a design note. -/
def disagreement (t : ClauseTable) : Nat → List (CNF.Clause Nat) → Option TableFault
  | _,  []      => none
  | id, c :: cs =>
      let L := LitSet.ofClause c
      if t.get id != L then some (.slotMismatch id (t.get id) L)
      else if !L.ok then some (.tautology id L)
      else t.disagreement (id + 1) cs

/-- **What to run the moment `agreesWithCNF` comes back false.** The first place the emitted table and
the formula part company, with both values.

`#eval t.firstFault f` — it runs compiled, so it is instant at any size, and it names the culprit. -/
def firstFault (t : ClauseTable) (f : CNF Nat) : Option TableFault :=
  t.disagreement 0 f.clauses.toList

/-- **The trust boundary, as one kernel-decidable `Bool`.** The emitted table really does hold the
formula in its first `f.clauses.size` slots, with no tautology among them.

Defined as "no fault", so the `Bool` the kernel decides and the diagnosis a human reads are the same
computation and cannot disagree. When this is `false`, run `#eval t.firstFault f`. -/
def agreesWithCNF (t : ClauseTable) (f : CNF Nat) : Bool :=
  (t.firstFault f).isNone

end ClauseTable

/-- Clause ids below `w` are settled: each is a genuine, non-tautological consequence of `f`.

The checker's whole invariant. It moves in one direction only — a watermark, never a mutation — which
is what lets the clause table be a literal. -/
def Justified (t : ClauseTable) (f : CNF Nat) (w : Nat) : Prop :=
  ∀ id, id < w → (t.get id).Ok ∧ (t.get id).Entails f

/-- **The strengthened statement the induction needs.** `disagreement` walks the clause list carrying an
id counter, so a claim stated only at id 0 has an induction hypothesis that cannot carry itself through
the step. Quantifying the starting id fixes that, and the base case becomes vacuous — `id₀ ≤ id` and
`id < id₀ + 0` cannot both hold — which is the right anchoring rather than a peeled special case.

It carries **membership**, not position, because membership is what `LitSet.Entails` consumes:
`CNF.eval` is an `Array.all`, and `Array.all_eq_true_iff_forall_mem` speaks of members. Indexing would
have dragged in `getElem` side conditions that nothing downstream wants.

Induction on `cs`, `generalizing id₀`; descent measure is the clause list's length. -/
theorem disagreement_eq_none_mem {t : ClauseTable} {cs : List (CNF.Clause Nat)} {id₀ : Nat}
    (h : t.disagreement id₀ cs = none) :
    ∀ id, id₀ ≤ id → id < id₀ + cs.length →
      (t.get id).Ok ∧ ∃ c ∈ cs, t.get id = LitSet.ofClause c := by
  induction cs generalizing id₀ with
  | nil => intro id h1 h2; simp only [List.length_nil] at h2; omega
  | cons c cs ih =>
      rw [ClauseTable.disagreement] at h
      split at h
      · exact absurd h (by simp)
      · rename_i hmatch
        split at h
        · exact absurd h (by simp)
        · rename_i hok
          simp only [bne_iff_ne, ne_eq, Decidable.not_not, Bool.not_eq_true'] at hmatch hok
          intro id h1 h2
          by_cases hid : id = id₀
          · subst hid
            exact ⟨hmatch ▸ (LitSet.ok_iff _).mp (by simpa using hok),
                   c, List.mem_cons_self .., hmatch⟩
          · obtain ⟨hok', c', hmem, heq⟩ :=
              ih h id (by omega) (by simp only [List.length_cons] at h2; omega)
            exact ⟨hok', c', List.mem_cons_of_mem _ hmem, heq⟩

/-- **The base case of the checker's induction.** A table that agrees with the formula justifies
exactly the formula's own clause ids. -/
theorem justified_of_agreesWithCNF {t : ClauseTable} {f : CNF Nat}
    (h : t.agreesWithCNF f = true) : Justified t f f.clauses.size := by
  intro id hid
  obtain ⟨hok, c, hmem, heq⟩ :=
    disagreement_eq_none_mem (Option.isNone_iff_eq_none.mp h) id (Nat.zero_le _) (by simpa [Array.length_toList] using hid)
  refine ⟨hok, fun a ha => ?_⟩
  rw [heq, LitSet.any_ofClause_iff]
  rw [CNF.eval, Array.all_eq_true_iff_forall_mem] at ha
  exact ha c (by simpa using hmem)

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
  { field := 8, perChunk := 2, chunks := .node 1 (.leaf 2 chunk0) (.leaf 2 chunk1) }

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
#guard !({ tbl with chunks := .node 1 (.leaf 2 (chunk0 + 1)) (.leaf 2 chunk1) } :
  ClauseTable).agreesWithCNF f4

-- ...and a table that is right but claimed against a *different* formula.
#guard !tbl.agreesWithCNF ⟨#[[(0, true), (1, true)], [(2, true)]]⟩

-- The packing parameters are part of the datum: right chunks, wrong slot capacity, check fails.
#guard !({ tbl with chunks := .node 1 (.leaf 1 chunk0) (.leaf 1 chunk1) } :
  ClauseTable).agreesWithCNF f4

-- **The per-chunk capacity is read from the chunk it descends into**, not from the table: the two
-- chunks here hold clauses of different lengths and both decode correctly. This is the whole point
-- of M06's change, and a uniform-width table could not do it.
#guard ({ field := 8, perChunk := 1,
          chunks := .node 1 (.leaf 1 (fld 3 true))
                            (.leaf 3 ((fld 0 true ||| (fld 1 false <<< 8)) ||| (fld 2 true <<< 16))) } :
        ClauseTable).get 0 == ({ pos := 1 <<< 3, neg := 0 } : LitSet)
#guard ({ field := 8, perChunk := 1,
          chunks := .node 1 (.leaf 1 (fld 3 true))
                            (.leaf 3 ((fld 0 true ||| (fld 1 false <<< 8)) ||| (fld 2 true <<< 16))) } :
        ClauseTable).get 1 == LitSet.ofClause [(0, true), (1, false), (2, true)]

-- A short clause is zero-terminated, not padded with a spurious literal.
#guard ({ tbl with chunks := .leaf 2 (fld 3 true) } : ClauseTable).get 0
        == ({ pos := 1 <<< 3, neg := 0 } : LitSet)

-- **The denied obligation, pinned.** Out of range, `Chunks.get` returns a chunk rather than failing.
#guard tbl.chunks.get 99 == (2, chunk1)

end Spec

end HadwigerNelson

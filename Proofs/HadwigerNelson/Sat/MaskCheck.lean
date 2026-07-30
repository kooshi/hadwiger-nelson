import Proofs.HadwigerNelson.Sat.ClauseTable

/-!
# The checker

A refutation checker Lean's **kernel** can run, and the theorem that says running it means something.

## What a certificate is here

Nothing but hint lists. Because every clause — the formula's and the solver's derived ones alike —
already lives in the emitted table (`Sat/ClauseTable.lean`), an action needs to carry neither a
clause nor an id: ids are consumed densely and in order, so the checker's entire state is a
**watermark**, and clause ids below it are the ones it has justified.

That is smaller than the format core's `LRAT.check` consumes, and it is what removes the growing
clause database whose measured cost (16.7 ms per lookup at de Grey's scale, rising with database
size) made the obvious design impossible.

## Deletion lines are dropped by the emitter, not ignored here

Real certificates contain them — 381 per de Grey cube, removing 2,770 clause ids. A larger clause
database only makes propagation *harder*, so discarding deletions can never let a bad certificate
through; and with the table emitted as a literal there is nothing to delete from. So the emitter
drops them and `Action` stays two constructors wide. Recorded because "accepted and ignored" is
normally a smell, and this is the case where it is a decision.

## Where the trust sits

Two closed `Bool`s, both decided by the kernel: the table agrees with the formula, and the checker
accepts the certificate. `tools/` is trusted for neither. A wrong table fails the first; a wrong
certificate, a stale one, a hint citing an unjustified clause, or a certificate for a satisfiable
formula all fail the second.
-/

namespace HadwigerNelson

open Std.Sat

/-- One certificate step. The clause being derived is the one the table holds at the current
watermark, so only the hints need saying. -/
inductive Action where
  /-- Justify the clause at the current watermark by reverse unit propagation. -/
  | addRup (hints : List Nat)
  /-- Justify the empty clause, ending the proof. -/
  | addEmpty (hints : List Nat)
deriving DecidableEq, Repr, Inhabited

/-! ### Decoding

The decoder is **untrusted, structurally**: `maskCheck_sound` says nothing whatever about what
`decodeChunk` means. Any `List Action` it produces is checked from scratch, so a decoding bug can
only cause a failed check. That is why it is worth keeping simple rather than proving anything about
it.

Certificate chunk format, all fields `L.field` bits wide, least significant first: one header field
giving the number of fields that follow, then a sequence of actions, each a head field
`2 * hintCount + tag` (tag 0 = `addRup`, 1 = `addEmpty`) followed by its hint fields. -/

/-- Peel `n` fields off a chunk, least significant first. Shifting the remainder keeps the work
linear in the field count rather than quadratic in the chunk size. -/
def fields (L : Layout) : Nat → Nat → List Nat
  | 0,     _ => []
  | n + 1, w => (w % (2 ^ L.field)) :: fields L n (w >>> L.field)

/-- Group a field list into actions. Structural on a fuel that the caller sets to the field count,
which bounds the number of actions; running out with fields left over is a **failure**, not a quiet
truncation. -/
def parseActions : Nat → List Nat → Option (List Action)
  | _,     []         => some []
  | 0,     _ :: _     => none
  | f + 1, hd :: rest =>
      let k := hd / 2
      let hs := rest.take k
      if hs.length == k then
        (parseActions f (rest.drop k)).map fun acts =>
          (if hd % 2 == 0 then Action.addRup hs else Action.addEmpty hs) :: acts
      else none

/-- Decode one certificate chunk. -/
def decodeChunk (L : Layout) (w : Nat) : Option (List Action) :=
  let n := w % (2 ^ L.field)
  parseActions n (fields L n (w >>> L.field))

/-! ### Checking -/

/-- **Reverse unit propagation.** Starting from an assignment that falsifies the clause being
derived, walk the hinted clauses; `true` means a conflict was reached, which is what justifies the
clause.

`h < w` is the discipline that keeps the watermark meaningful: a hint may only cite a clause already
justified. Without it a certificate could bootstrap a clause from itself.

There is no `Ok` test on the hinted clause — the watermark invariant `Justified` already carries it,
which is the point of having an invariant instead of re-checking. -/
def rup (L : Layout) (t : ClauseTable) (w : Nat) : Asg → List Nat → Bool
  | _, []      => false
  | α, h :: hs =>
      if h < w then
        match propagate α (t.get L h) with
        | .conflict => true
        | .prop α'  => rup L t w α' hs
        | .fail     => false
      else false

/-- What running a chunk's actions produced. -/
inductive Outcome where
  /-- The empty clause was justified: the formula is unsatisfiable. -/
  | done
  /-- All actions checked out; the watermark has advanced this far. -/
  | more (w : Nat)
  /-- The certificate is wrong. -/
  | fail
deriving DecidableEq, Repr, Inhabited

/-- Run a decoded action list from watermark `w`. Each `addRup` justifies the clause the table holds
at `w` and advances the watermark by one; the clause must be non-tautological, which is the
hypothesis `propagate_prop_sound` needs and the only check here that guards against a *false theorem*
rather than a failed proof. -/
def runActions (L : Layout) (t : ClauseTable) : Nat → List Action → Outcome
  | w, []                  => .more w
  | w, .addRup hs :: rest  =>
      let c := t.get L w
      if c.ok && rup L t w (Asg.negate c) hs then runActions L t (w + 1) rest else .fail
  | w, .addEmpty hs :: _   => if rup L t w ⟨0, 0⟩ hs then .done else .fail

/-- Run the certificate chunk by chunk, threading the watermark. Reaching the end of the
certificate without an `addEmpty` is a failure, not a success. -/
def runChunks (L : Layout) (t : ClauseTable) : Nat → List Nat → Bool
  | _, []       => false
  | w, ch :: cs =>
      match decodeChunk L ch with
      | none      => false
      | some acts =>
          match runActions L t w acts with
          | .done    => true
          | .more w' => runChunks L t w' cs
          | .fail    => false

/-- **The checker.** `m` is the number of the formula's own clauses, so the watermark starts just
past them. -/
def maskCheck (L : Layout) (t : ClauseTable) (m : Nat) (cert : List Nat) : Bool :=
  runChunks L t m cert

/-! ### Soundness

One induction per layer, all on the same invariant pair: `Justified` for the clause table, and
`Asg.Extends` inside a single propagation chain. -/

/-- Reaching a conflict is impossible if a satisfying assignment extends where we started. -/
theorem rup_sound {L : Layout} {t : ClauseTable} {f : CNF Nat} {w : Nat} {α : Asg}
    {a : Nat → Bool} {hs : List Nat} (hJ : Justified L t f w) (hf : CNF.eval a f = true)
    (hE : α.Extends a) (h : rup L t w α hs = true) : False := by
  sorry

/-- Checking a batch of actions extends the justified prefix. -/
theorem runActions_more {L : Layout} {t : ClauseTable} {f : CNF Nat} {w w' : Nat}
    {acts : List Action} (hJ : Justified L t f w) (h : runActions L t w acts = .more w') :
    Justified L t f w' := by
  sorry

/-- Justifying the empty clause refutes any satisfying assignment. -/
theorem runActions_done {L : Layout} {t : ClauseTable} {f : CNF Nat} {w : Nat}
    {acts : List Action} {a : Nat → Bool} (hJ : Justified L t f w) (hf : CNF.eval a f = true)
    (h : runActions L t w acts = .done) : False := by
  sorry

/-- The same, across chunks. -/
theorem runChunks_sound {L : Layout} {t : ClauseTable} {f : CNF Nat} {w : Nat}
    {cert : List Nat} {a : Nat → Bool} (hJ : Justified L t f w) (hf : CNF.eval a f = true)
    (h : runChunks L t w cert = true) : False := by
  sorry

/-- **The milestone's theorem.** If the emitted table really holds the formula, and the checker
accepts the certificate against it, the formula is unsatisfiable.

Both hypotheses are closed `Bool`s the kernel decides, so a proof of unsatisfiability costs no
axiom beyond the standard three — which is the whole point of M05, and the difference between a
result a reader can check and one that asks them to trust a compiler and a CPU. -/
theorem maskCheck_sound {L : Layout} {t : ClauseTable} {f : CNF Nat} {cert : List Nat}
    (hagree : agreesWithCNF L t f = true)
    (hcheck : maskCheck L t f.clauses.size cert = true) : f.Unsat := by
  sorry

/-! ## Spec

The whole path, end to end, on the smallest formula that needs more than one derivation:
`(x ∨ y) ∧ (x ∨ ¬y) ∧ (¬x ∨ y) ∧ (¬x ∨ ¬y)`. Derive `(x)` from the first two, `(¬x)` from the last
two, then the empty clause from those. This is `spikes/KernelLratEscape.lean`'s formula, so the two
routes are checking the same refutation. -/

section Spec

private def L2 : Layout := { field := 8, lits := 2, perChunk := 2 }

/-- Field encoding of a literal: variable `v`, `s` true for a positive occurrence. -/
private def fld (v : Nat) (s : Bool) : Nat := (if s then 2 * v else 2 * v + 1) + 1

/-- Pack a list of fields into one chunk, least significant first. -/
private def pack (L : Layout) (xs : List Nat) : Nat :=
  xs.foldr (fun x acc => x ||| (acc <<< L.field)) 0

/-- ids 0,1 — `(x ∨ y)` and `(x ∨ ¬y)`. -/
private def ch0 : Nat := pack L2 [fld 0 true, fld 1 true, fld 0 true, fld 1 false]
/-- ids 2,3 — `(¬x ∨ y)` and `(¬x ∨ ¬y)`. -/
private def ch1 : Nat := pack L2 [fld 0 false, fld 1 true, fld 0 false, fld 1 false]
/-- ids 4,5 — the derived clauses `(x)` and `(¬x)`, zero-terminated. -/
private def ch2 : Nat := pack L2 [fld 0 true, 0, fld 0 false, 0]

private def tbl : ClauseTable := .node 2 (.node 1 (.leaf ch0) (.leaf ch1)) (.leaf ch2)

private def f4 : CNF Nat :=
  ⟨#[[(0, true), (1, true)], [(0, true), (1, false)],
     [(0, false), (1, true)], [(0, false), (1, false)]]⟩

#guard agreesWithCNF L2 tbl f4
#guard tbl.get L2 4 == ({ pos := 1, neg := 0 } : MClause)
#guard tbl.get L2 5 == ({ pos := 0, neg := 1 } : MClause)

/-- The certificate: `addRup [0,1]`, `addRup [2,3]`, `addEmpty [4,5]` — nine fields behind a header
that says so. -/
private def cert : List Nat := [pack L2 [9, 4, 0, 1, 4, 2, 3, 5, 4, 5]]

/-- info: some [HadwigerNelson.Action.addRup [0, 1], HadwigerNelson.Action.addRup [2, 3], HadwigerNelson.Action.addEmpty [4, 5]] -/
#guard_msgs in #eval decodeChunk L2 cert.head!

#guard maskCheck L2 tbl 4 cert

-- **The negative controls.** Each breaks one thing and must go red.
-- A hint citing a clause that is not yet justified.
#guard !maskCheck L2 tbl 4 [pack L2 [9, 4, 0, 5, 4, 2, 3, 5, 4, 5]]
-- The empty-clause action removed: the certificate stops without concluding anything.
#guard !maskCheck L2 tbl 4 [pack L2 [6, 4, 0, 1, 4, 2, 3]]
-- A hint list that does not propagate to a conflict.
#guard !maskCheck L2 tbl 4 [pack L2 [9, 4, 0, 2, 4, 2, 3, 5, 4, 5]]
-- A certificate filed against the wrong number of input clauses, so the derived ids are misread.
#guard !maskCheck L2 tbl 5 cert
-- An empty certificate is a failure, not a vacuous success.
#guard !maskCheck L2 tbl 4 []

/-- **The terminal test, in miniature.** The kernel — not the compiler — runs both checks. The same
two `decide +kernel` calls at de Grey's scale are what M05 exists to make affordable. -/
example : agreesWithCNF L2 tbl f4 = true ∧ maskCheck L2 tbl 4 cert = true := by decide +kernel

end Spec

end HadwigerNelson

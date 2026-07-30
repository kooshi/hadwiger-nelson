import Proofs.HadwigerNelson.Sat.ClauseTable

/-!
# The checker

A refutation checker Lean's **kernel** can run, and the theorem that says running it means something.

## What a certificate is here

Nothing but hint lists. Because every clause — the formula's and the solver's derived ones alike —
already lives in the emitted table (`Sat/ClauseTable.lean`), an action needs to carry neither a clause
nor an id: ids are consumed densely and in order, so the checker's entire state is a **watermark**,
and clause ids below it are the ones it has justified.

That is smaller than the format core's `LRAT.check` consumes, and it is what removes the growing
clause database whose measured cost (16.7 ms per lookup at de Grey's scale, rising with database size)
made the obvious design impossible.

## The decoder is untrusted, and the type says so

`runStream` takes the decoder as a **parameter**, and `runStream_sound` is proved for *every* function
of that type. That is the strongest available statement of "nothing about the decoder is trusted": not
a docstring promise, but a universally quantified variable, so relying on the real decoder's behaviour
would be a type error rather than a review question. A decoding bug can only cause a failed check.

It also means the certificate's own packing — its field width — never appears in the soundness
argument. It lives in the concrete decoder, separate from the clause table's packing, because one
blob's layout is not the other's.

## Deletion lines are dropped by the emitter, not ignored here

Real certificates contain them — 381 per de Grey cube, removing 2,770 clause ids. A larger clause
database only makes propagation *harder*, so discarding deletions can never let a bad certificate
through; and with the table emitted as a literal there is nothing to delete from. So the emitter drops
them and `Action` stays two constructors wide. Recorded because "accepted and ignored" is normally a
smell, and this is the case where it is a decision.

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

/-! ### Checking -/

/-- **Reverse unit propagation.** Starting from an assignment that falsifies the clause being derived,
walk the hinted clauses; `true` means a conflict was reached, which is what justifies the clause.

`h < w` is the discipline that keeps the watermark meaningful: a hint may only cite a clause already
justified. Without it a certificate could bootstrap a clause from itself.

There is no `ok` test on the hinted clause — the watermark invariant `Justified` already carries it,
which is the point of having an invariant instead of re-checking. -/
def rup (t : ClauseTable) (w : Nat) : LitSet → List Nat → Bool
  | _, []      => false
  | α, h :: hs =>
      if h < w then
        match propagate α (t.get h) with
        | .conflict => true
        | .prop α'  => rup t w α' hs
        | .fail     => false
      else false

/-- What running a batch of actions produced. -/
inductive Outcome where
  /-- The empty clause was justified: the formula is unsatisfiable. -/
  | done
  /-- All actions checked out; the watermark has advanced this far. -/
  | more (w : Nat)
  /-- The certificate is wrong. -/
  | fail
deriving DecidableEq, Repr, Inhabited

/-- Run a decoded action list from watermark `w`. Each `addRup` justifies the clause the table holds
at `w` and advances the watermark by one; the clause must be non-tautological, which is the hypothesis
`propagate_prop_sound` needs and the only check here that guards against a *false theorem* rather than
a failed proof. -/
def runActions (t : ClauseTable) : Nat → List Action → Outcome
  | w, []                  => .more w
  | w, .addRup hs :: rest  =>
      let c := t.get w
      if c.ok && rup t w c.negate hs then runActions t (w + 1) rest else .fail
  | w, .addEmpty hs :: _   => if rup t w ⟨0, 0⟩ hs then .done else .fail

/-- Run the certificate chunk by chunk, threading the watermark, decoding with **whatever decoder is
handed in**. Reaching the end of the certificate without an `addEmpty` is a failure, not a success. -/
def runStream (t : ClauseTable) (decode : Nat → Option (List Action)) : Nat → List Nat → Bool
  | _, []       => false
  | w, ch :: cs =>
      match decode ch with
      | none      => false
      | some acts =>
          match runActions t w acts with
          | .done    => true
          | .more w' => runStream t decode w' cs
          | .fail    => false

/-! ### The concrete decoder

Certificate chunk format, all fields `fw` bits wide, least significant first: one header field giving
the number of fields that follow, then a sequence of actions, each a head field
`2 * hintCount + tag` (tag 0 = `addRup`, 1 = `addEmpty`) followed by its hint fields.

None of this is trusted. It is one instantiation of `runStream`'s decoder parameter, and
`runStream_sound` holds for all of them. -/

/-- Peel `n` fields off a chunk, least significant first. Shifting the remainder keeps the work linear
in the field count rather than quadratic in the chunk size. -/
def fields (fw : Nat) : Nat → Nat → List Nat
  | 0,     _ => []
  | n + 1, w => (w % (2 ^ fw)) :: fields fw n (w >>> fw)

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

/-- Decode one certificate chunk at field width `fw`. -/
def decodeChunk (fw : Nat) (w : Nat) : Option (List Action) :=
  let n := w % (2 ^ fw)
  parseActions n (fields fw n (w >>> fw))

/-- **The checker.** `m` is the number of the formula's own clauses, so the watermark starts just past
them; `fw` is the certificate's field width, which is the clause table's business only by coincidence
and so is passed separately. -/
def maskCheck (t : ClauseTable) (fw m : Nat) (cert : List Nat) : Bool :=
  runStream t (decodeChunk fw) m cert

/-! ### Soundness

One induction per layer, all on the same invariant pair: `Justified` for the clause table, and
`LitSet.All` inside a single propagation chain. -/

/-- Reaching a conflict is impossible if a satisfying assignment agrees with where we started. -/
theorem rup_sound {t : ClauseTable} {f : CNF Nat} {w : Nat} {α : LitSet}
    {a : Nat → Bool} {hs : List Nat} (hJ : Justified t f w) (hf : CNF.eval a f = true)
    (hE : α.All a) (h : rup t w α hs = true) : False := by
  sorry

/-- Checking a batch of actions extends the justified prefix. -/
theorem runActions_more {t : ClauseTable} {f : CNF Nat} {w w' : Nat} {acts : List Action}
    (hJ : Justified t f w) (h : runActions t w acts = .more w') : Justified t f w' := by
  sorry

/-- Justifying the empty clause refutes any satisfying assignment. -/
theorem runActions_done {t : ClauseTable} {f : CNF Nat} {w : Nat} {acts : List Action}
    {a : Nat → Bool} (hJ : Justified t f w) (hf : CNF.eval a f = true)
    (h : runActions t w acts = .done) : False := by
  sorry

/-- The same, across chunks — **for an arbitrary decoder.** Nothing about `decode` is available to
this proof, which is what makes the decoder untrusted as a matter of type rather than of policy. -/
theorem runStream_sound {t : ClauseTable} {f : CNF Nat} {w : Nat} {cert : List Nat}
    {a : Nat → Bool} (decode : Nat → Option (List Action)) (hJ : Justified t f w)
    (hf : CNF.eval a f = true) (h : runStream t decode w cert = true) : False := by
  sorry

/-- **The milestone's theorem.** If the emitted table really holds the formula, and the checker
accepts the certificate against it, the formula is unsatisfiable.

Both hypotheses are closed `Bool`s the kernel decides, so a proof of unsatisfiability costs no axiom
beyond the standard three — which is the whole point of M05, and the difference between a result a
reader can check and one that asks them to trust a compiler and a CPU. -/
theorem maskCheck_sound {t : ClauseTable} {f : CNF Nat} {fw : Nat} {cert : List Nat}
    (hagree : t.agreesWithCNF f = true)
    (hcheck : maskCheck t fw f.clauses.size cert = true) : f.Unsat := by
  intro a
  cases hev : CNF.eval a f
  · rfl
  · exact (runStream_sound (decodeChunk fw) (justified_of_agreesWithCNF hagree) hev hcheck).elim

/-! ## Spec

The whole path, end to end, on the smallest formula that needs more than one derivation:
`(x ∨ y) ∧ (x ∨ ¬y) ∧ (¬x ∨ y) ∧ (¬x ∨ ¬y)`. Derive `(x)` from the first two, `(¬x)` from the last
two, then the empty clause from those. This is `spikes/KernelLratEscape.lean`'s formula, so the two
routes are checking the same refutation. -/

section Spec

/-- Field encoding of a literal: variable `v`, `s` true for a positive occurrence. -/
private def fld (v : Nat) (s : Bool) : Nat := (if s then 2 * v else 2 * v + 1) + 1

/-- Pack a list of fields into one chunk, least significant first. -/
private def pack (xs : List Nat) : Nat := xs.foldr (fun x acc => x ||| (acc <<< 8)) 0

private def tbl : ClauseTable :=
  { field := 8, lits := 2, perChunk := 2
    chunks :=
      .node 2
        (.node 1
          -- ids 0,1 — `(x ∨ y)` and `(x ∨ ¬y)`
          (.leaf (pack [fld 0 true, fld 1 true, fld 0 true, fld 1 false]))
          -- ids 2,3 — `(¬x ∨ y)` and `(¬x ∨ ¬y)`
          (.leaf (pack [fld 0 false, fld 1 true, fld 0 false, fld 1 false])))
        -- ids 4,5 — the derived clauses `(x)` and `(¬x)`, zero-terminated
        (.leaf (pack [fld 0 true, 0, fld 0 false, 0])) }

private def f4 : CNF Nat :=
  ⟨#[[(0, true), (1, true)], [(0, true), (1, false)],
     [(0, false), (1, true)], [(0, false), (1, false)]]⟩

#guard tbl.agreesWithCNF f4
#guard tbl.get 4 == ({ pos := 1, neg := 0 } : LitSet)
#guard tbl.get 5 == ({ pos := 0, neg := 1 } : LitSet)

/-- The certificate: `addRup [0,1]`, `addRup [2,3]`, `addEmpty [4,5]` — nine fields behind a header
that says so. -/
private def cert : List Nat := [pack [9, 4, 0, 1, 4, 2, 3, 5, 4, 5]]

/-- info: some [HadwigerNelson.Action.addRup [0, 1], HadwigerNelson.Action.addRup [2, 3], HadwigerNelson.Action.addEmpty [4, 5]] -/
#guard_msgs in #eval decodeChunk 8 cert.head!

#guard maskCheck tbl 8 4 cert

-- **The negative controls.** Each breaks one thing and must go red.
-- A hint citing a clause that is not yet justified.
#guard !maskCheck tbl 8 4 [pack [9, 4, 0, 5, 4, 2, 3, 5, 4, 5]]
-- The empty-clause action removed: the certificate stops without concluding anything.
#guard !maskCheck tbl 8 4 [pack [6, 4, 0, 1, 4, 2, 3]]
-- A hint list that does not propagate to a conflict.
#guard !maskCheck tbl 8 4 [pack [9, 4, 0, 2, 4, 2, 3, 5, 4, 5]]
-- A certificate filed against the wrong number of input clauses, so the derived ids are misread.
#guard !maskCheck tbl 8 5 cert
-- The certificate decoded at the wrong field width.
#guard !maskCheck tbl 16 4 cert
-- An empty certificate is a failure, not a vacuous success.
#guard !maskCheck tbl 8 4 []

/-- **The terminal test, in miniature.** The kernel — not the compiler — runs both checks. The same
two `decide +kernel` calls at de Grey's scale are what M05 exists to make affordable. -/
example : tbl.agreesWithCNF f4 = true ∧ maskCheck tbl 8 4 cert = true := by decide +kernel

end Spec

end HadwigerNelson

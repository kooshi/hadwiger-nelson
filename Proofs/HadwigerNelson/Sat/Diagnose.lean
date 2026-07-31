import Proofs.HadwigerNelson.Sat.MaskCheck

/-!
# Reading a failed check — the diagnostics, in their own module

Everything here runs by `#eval`, is compiled rather than kernel-reduced, and appears in no proof.
None of it is trusted and none of it can be: a diagnosis is a string.

## Why this is a separate module, which is the part worth knowing

`Sat/Mask.lean`, `Sat/ClauseTable.lean` and `Sat/MaskCheck.lean` sit **upstream of every generated
certificate module** — 2,265 of them for de Grey's graph alone, holding 27.8 hours of kernel work.
Lake's traces are content-based, so changing any byte of those three files, including a comment,
marks all of it out of date.

That happened. A one-line improvement to a diagnostic message queued a full re-check of M06, and it
was noticed only because the rebuild was watched. So the rule the layout now enforces:

> **Nothing that exists to be read by a human goes in a module a certificate imports.**

A diagnostic is exactly that. It lives here, downstream, where it can be rewritten as often as it
needs to be for the cost of recompiling one file.

## What to run when a check comes back false

| the check | what to `#eval` |
|---|---|
| `t.agreesWithCNF f` is `false` | `t.faultReport f` — one line, naming the slot and both clauses |
| a segment's `decide +kernel` fails | `runSegment t (decodeChunk fw) w seg` — the `Outcome`, with its fault |
| the geometry's `Valid` is `false` | `c.badEdges` — every offending pair and the distance it has |

`ClauseTable.firstFault` returns the same answer as data, for a caller that wants to match on it.
`faultReport` is the one to read: `Repr` on a `TableFault` prints its two `LitSet`s as raw bit sets,
which at de Grey's variable count is two thousand-digit integers — the whole truth, in the
implementation's vocabulary, and useless to the person holding the error.
-/

namespace HadwigerNelson

namespace LitSet

/-- The variables a bit set holds, low bit first.

An ordinary recursion on `n / 2` rather than a walk over a bit range, because it exists to be
`#eval`ed on a clause of twenty literals and legibility is the whole point of it. -/
def bitsFrom : Nat → Nat → List Nat
  | 0,     _ => []
  | n + 1, i =>
      (if n % 2 = 0 then [i] else []) ++ bitsFrom ((n + 1) / 2) (i + 1)
  termination_by n => n
  decreasing_by exact Nat.div_lt_self (by omega) (by omega)

/-- **A `LitSet` in the vocabulary it is compared against.** `CNF.Clause Nat` is
`List (Nat × Bool)` — variable and polarity — so a diagnosis that prints two bit sets is answering in
the implementation's terms rather than the reader's. -/
def toClause (L : LitSet) : List (Nat × Bool) :=
  (bitsFrom L.pos 0).map (·, true) ++ (bitsFrom L.neg 0).map (·, false)

end LitSet

/-- The fault as a sentence, with both clauses in `CNF.Clause` vocabulary. -/
def TableFault.report : TableFault → String
  | .slotMismatch id held wanted =>
      s!"slot {id}: the table holds {held.toClause}, the formula wants {wanted.toClause}"
  | .tautology id held =>
      s!"slot {id}: {held.toClause} is a tautology, which the checker cannot use"

/-- **What to `#eval` the moment `agreesWithCNF` comes back false**, in one line and in English.

Compiled, so it is instant at any table size, and it prints a clause rather than a bit set. -/
def ClauseTable.faultReport (t : ClauseTable) (f : Std.Sat.CNF Nat) : String :=
  match t.firstFault f with
  | none => "the table agrees with the formula"
  | some fl => fl.report

/-! ## Spec

`toClause` is the diagnostic surface, so it gets the check a diagnostic owes: bit `i` of `pos` is the
positive literal on variable `i`, bit `i` of `neg` the negative one, and nothing is dropped or
doubled. Without this the renderer could be plausibly, silently wrong exactly when it is needed. -/

#guard LitSet.toClause ⟨0b1010, 0b0101⟩ = [(1, true), (3, true), (0, false), (2, false)]
#guard LitSet.toClause ⟨0, 0⟩ = []

end HadwigerNelson

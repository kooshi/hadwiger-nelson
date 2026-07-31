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

## The emitter's contract, indexed by the fault it causes

Everything `tools/` must get right, and what the checker says when it does not. This list is the
authoritative one: a generator author reading a fault name should be able to find their bug here
without opening any other module.

| the emitter must | or you get |
|---|---|
| pack the clause table's slots with the table's own `field` width, `lits` capacity and `perChunk` | `TableFault.slotMismatch` |
| encode a literal as `2 * v + (if positive then 0 else 1) + 1`, so `0` is free to terminate a slot | `TableFault.slotMismatch` |
| leave no clause with a variable on both sides among the formula's own | `TableFault.tautology` |
| number derived clauses **densely and in increasing order**, starting at the formula's clause count | `CertFault.hintUnjustified` |
| emit one `addRup` per derived clause, in that same order, so the watermark tracks the id | `CertFault.hintUnjustified` or `hintNoPropagate` |
| keep each hint list in propagation order | `CertFault.hintNoPropagate` |
| put every derived clause into the table too, not only into the certificate | `CertFault.derivedTautology` or `hintNoPropagate` |
| end with an `addEmpty` action | `CertFault.noEmptyClause` |
| use the **certificate's** field width — which is not the table's — and a header field counting the fields that follow | `CertFault.malformedChunk` |
| drop the solver's deletion lines | *(nothing: they are simply not part of this format)* |
| pin the solver flags so no `.addRat` step is ever produced | `CertFault.malformedChunk` |
| backward-trim the certificate from the empty clause | *(nothing: an untrimmed certificate is 1.4–20× slower to check and no less sound)* |
| give each `Chunks.leaf` a slot capacity at least the longest clause in that chunk | `TableFault.slotMismatch` |

Nothing on that list is trusted. Every item is re-derived by one of the two kernel-decided `Bool`s, so
a violation is a failed check, never a false theorem.

## When the *build* fails, which is the other half of it

At de Grey's scale the certificate is checked in thousands of segments across thousands of generated
modules, and most of what goes wrong there is a build failure with no `CertFault` in sight. This is the
table for that, because the person holding the error is reading a Lean message, not Python.

| the build says | what it means | what to do |
|---|---|---|
| a type mismatch between two consecutive segment theorems | the emitter miscounted the additions in some chunk, so one segment's watermark does not meet the next one's | regenerate. Those watermarks are the emitter's only arithmetic, and this error is the elaborator checking it |
| `maximum recursion depth has been reached` inside a segment | the decoder peels one field per reduction step and a chunk holds thousands | raise `maxRecDepth` in the generated header; the emitter sets 10⁶ **when a certificate is large enough to need it** — below ~500 segments it emits no knob, so a knob appearing is itself information |
| `[Error pretty printing: maximum recursion depth has been reached]`, **in brackets, on a `decide +kernel` line** | **not** the row above, and raising `maxRecDepth` will not help. The `Bool` is genuinely `false`; what overflowed is the *pretty-printer* trying to render the counterexample term. Two unrelated causes wearing the same words — read the brackets | `#eval` the `Bool` itself to confirm it is `false`, then the diagnostic for whichever `Bool` it was: `t.firstFault f` for agreement, `runSegment …` for a segment |
| the machine runs out of memory | a segment is too large. Measured peak: **≈ 3.4 GB + 0.81 GB per certificate chunk** — it is `unpackAux`'s intermediate literal sets, which the kernel retains for the whole reduction | fewer chunks per segment, and fewer segments at once. Wall clock depends only on the job count, so shrinking segments is free |
| `decide` failed, with a proposition too large to print | the certificate really is wrong in that segment — but the kernel cannot tell you how | **`#eval runSegment t (decodeChunk fw) w seg`**: the same expression compiled prints the `Outcome`, including the fault. This is the diagnostic for a failed segment, and it is instant |
| `agreesWithCNF` is false on a table that used to pass | the formula moved under the certificate — usually a regenerated edge list against an old certificate, or a certificate filed against the wrong witness | **`#eval t.faultReport f`** (`Sat/Diagnose.lean`) — one line naming the slot and both clauses. `firstFault` returns the same fault as data, but `Repr` prints its two `LitSet`s as raw bit sets, which at this variable count is two thousand-digit integers. Then regenerate |

## The reasoning surface — nothing here is ever unfolded

Consumers reason through exactly three names, and no proof outside this module should ever `unfold` a
definition in it:

* **`maskCheck_sound`** — the only way to turn a checked certificate into unsatisfiability;
* **`whyNot`** and **`ClauseTable.firstFault`** — the only things to run when a check fails, both by
  `#eval`, never in a proof. The readable rendering of a fault, and the fuller table of build faults,
  live **downstream** in `Sat/Diagnose.lean`: this module is imported by every generated certificate
  module, so a comment changed here re-checks 27.8 hours of kernel work, and a diagnostic is the one
  thing that gets rewritten often.

`propagate`, `rupWhy`, `runActions`, `runStream`, `ClauseTable.get` and `unpackAux` are implementation.
They are reasoned about only by the lemmas in this file and `Sat/ClauseTable.lean`, and their shapes
are chosen for reduction-step count rather than for legibility — unfolding one is a sign that a lemma
is missing, not that the definition needed reading.

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

/-! ### Diagnosis first, checking second

A `Bool` that comes back `false` over 134,396 hints, once for each of 96 cubes, tells whoever has to
fix it nothing at all. So — as in `Sat/ClauseTable.lean` — the **diagnostic is the primary definition
and the `Bool` is derived from it**: `maskCheck` *is* "there is no fault". Drift between the checker
and the explanation is then impossible rather than ruled out by an obligation someone maintains, which
is a genuine improvement on M04's arrangement of `Valid` beside `badEdges`.

Every fault carries the **clause id being derived** when it happened, because that is what locates a
failure inside a 3,657-step certificate. -/

/-- Why a certificate did not check. -/
inductive CertFault where
  /-- A chunk did not decode. Almost always the certificate's field width or its header count — note
  that the certificate's field width is **not** the clause table's. -/
  | malformedChunk (whileDeriving : Nat)
  /-- The table's clause at this id has a variable on both sides, so no derivation can use it. -/
  | derivedTautology (clause : Nat) (held : LitSet)
  /-- A hint cited clause `hint`, which is at or above the watermark — not yet justified. Usually a
  stale certificate, or ids that are not dense and in order. -/
  | hintUnjustified (clause hint : Nat)
  /-- Hint `hint` left two or more literals undecided, so it does not propagate. Usually the hints are
  out of order, or the table's clause differs from the one the solver used. -/
  | hintNoPropagate (clause hint : Nat)
  /-- The hints ran out before any conflict was reached. -/
  | hintsExhausted (clause : Nat)
  /-- The certificate ended without ever deriving the empty clause. -/
  | noEmptyClause (reachedClause : Nat)
deriving DecidableEq, Repr, Inhabited

/-- **Reverse unit propagation.** Starting from an assignment that falsifies the clause being derived,
walk the hinted clauses. `none` means a conflict was reached, which is what justifies the clause.

`hint < clause` is the discipline that keeps the watermark meaningful: a hint may only cite a clause
already justified. Without it a certificate could bootstrap a clause from itself.

There is no tautology test on the hinted clause — the watermark invariant `Justified` already carries
it, which is the point of having an invariant instead of re-checking. -/
def rupWhy (t : ClauseTable) (w : Nat) : LitSet → List Nat → Option CertFault
  | _, []      => some (.hintsExhausted w)
  | α, h :: hs =>
      if h < w then
        match propagate α (t.get h) with
        | .conflict => none
        | .prop α'  => rupWhy t w α' hs
        | .fail     => some (.hintNoPropagate w h)
      else some (.hintUnjustified w h)

/-- What running a batch of actions produced. -/
inductive Outcome where
  /-- The empty clause was justified: the formula is unsatisfiable. -/
  | done
  /-- All actions checked out; the watermark has advanced this far. -/
  | more (w : Nat)
  /-- The certificate is wrong, and this is why. -/
  | fault (why : CertFault)
deriving DecidableEq, Repr, Inhabited

/-- Run a decoded action list from watermark `w`. Each `addRup` justifies the clause the table holds at
`w` and advances the watermark by one; that clause must be non-tautological, which is the hypothesis
`propagate_prop_sound` needs and the only check here guarding against a *false theorem* rather than a
failed proof.

Both action kinds are the same operation on different clauses — the empty literal set is its own
negation, so `addEmpty` is the ordinary case at `⟨0,0⟩`. -/
def runActions (t : ClauseTable) : Nat → List Action → Outcome
  | w, []                  => .more w
  | w, .addRup hs :: rest  =>
      let c := t.get w
      if c.ok then
        match rupWhy t w c.negate hs with
        | none     => runActions t (w + 1) rest
        | some why => .fault why
      else .fault (.derivedTautology w c)
  | w, .addEmpty hs :: _   =>
      match rupWhy t w (⟨0, 0⟩ : LitSet).negate hs with
      | none     => .done
      | some why => .fault why

/-- Run a run of chunks, threading the watermark, decoding with **whatever decoder is handed in**,
and reporting where the watermark got to.

Running out of chunks is `.more`, not a fault: **a certificate may be checked in segments.** A
segment proves an implication between watermarks, so segments elaborate independently and in
parallel — which is the difference between 6.9 hours of wall clock for one of de Grey's halves and
three minutes per segment over 32 cores (`plans/M06-chi-ge-five.md` § 2.4). Only `runStream` below,
which sees the whole certificate, treats a missing `addEmpty` as the fault it is. -/
def runSegment (t : ClauseTable) (decode : Nat → Option (List Action)) :
    Nat → List Nat → Outcome
  | w, []       => .more w
  | w, ch :: cs =>
      match decode ch with
      | none      => .fault (.malformedChunk w)
      | some acts =>
          match runActions t w acts with
          | .done      => .done
          | .more w'   => runSegment t decode w' cs
          | .fault why => .fault why

/-- Run a whole certificate. Reaching the end without an `addEmpty` is a fault, not a success. -/
def runStream (t : ClauseTable) (decode : Nat → Option (List Action))
    (w : Nat) (cert : List Nat) : Option CertFault :=
  match runSegment t decode w cert with
  | .done      => none
  | .more w'   => some (.noEmptyClause w')
  | .fault why => some why

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

/-- **What to run the moment `maskCheck` comes back false.** The first fault in the certificate, with
the clause id it happened at.

`#eval whyNot t fw m cert` — it runs compiled, so it is instant at de Grey's scale, and it names the
culprit instead of leaving 96 cubes to bisect by hand. -/
def whyNot (t : ClauseTable) (fw m : Nat) (cert : List Nat) : Option CertFault :=
  runStream t (decodeChunk fw) m cert

/-- **The checker.** `m` is the number of the formula's own clauses, so the watermark starts just past
them; `fw` is the certificate's field width, which is the clause table's business only by coincidence
and so is passed separately.

Defined as "no fault", so the `Bool` the kernel decides and the diagnosis a human reads are the same
computation and cannot disagree. When this is `false`, run `#eval whyNot t fw m cert`. -/
def maskCheck (t : ClauseTable) (fw m : Nat) (cert : List Nat) : Bool :=
  (whyNot t fw m cert).isNone

/-! ### Soundness

Every statement below concludes something **positive** — a clause is entailed, a prefix is justified,
the formula is unsatisfiable — rather than deriving `False` from a `Bool`. That is not stylistic: it is
what makes the layers compose, and it is what collapses two theorems into one and makes the top-level
theorem a single line.

The recursions are all structural over a list, so every descent measure is a list length and nothing
here needs a termination argument: hint list, action list, chunk list. -/

/-- **What an outcome being sound means**, indexed by the outcome itself.

`runActions` can end three ways and each one means something different, so two separate theorems over
the same induction were two copies of one argument. Indexing the conclusion by the `Outcome` makes it
one statement, one induction, three two-line cases. -/
def Outcome.Sound (t : ClauseTable) (f : CNF Nat) : Outcome → Prop
  | .done   => f.Unsat
  | .more w => Justified t f w
  | .fault _ => True

/-- **Reverse unit propagation is sound.** If the check succeeds from the assignment `α`, then the
clause `α` was built to falsify — that is, `α.negate` — follows from the formula.

Stated at an arbitrary `α` rather than at `L.negate`, because `α` is what varies down the recursion;
the caller's form is the instance at `α = L.negate`, recovered by `negate_negate`. The duality
`all_iff_not_any` is what turns "no satisfying assignment can agree with `α`" into "`α.negate` is
entailed", so the statement and the induction are the same object.

Induction on the hint list, `generalizing α`. -/
theorem rup_sound {t : ClauseTable} {f : CNF Nat} {w : Nat} {α : LitSet} {hs : List Nat}
    (hJ : Justified t f w) (h : rupWhy t w α hs = none) : α.negate.Entails f := by
  induction hs generalizing α with
  | nil => exact absurd h (by simp [rupWhy])
  | cons hd hs ih =>
      rw [rupWhy] at h
      split at h
      · rename_i hlt
        split at h
        · rename_i hc
          intro a ha
          refine Classical.byContradiction fun hn => ?_
          exact propagate_conflict_sound ((LitSet.all_iff_not_any α a).mpr hn)
            ((hJ hd hlt).2 a ha) hc
        · rename_i α' hc
          intro a ha
          refine Classical.byContradiction fun hn => ?_
          have hα : α.All a := (LitSet.all_iff_not_any α a).mpr hn
          have hα' : α'.All a := propagate_prop_sound (hJ hd hlt).1 hα ((hJ hd hlt).2 a ha) hc
          exact (LitSet.all_iff_not_any α' a).mp hα' (ih h a ha)
        · exact absurd h (by simp)
      · exact absurd h (by simp)

/-- **One induction for the whole batch.** Both action kinds are the same operation — check that the
clause being derived follows by reverse unit propagation — and they differ only in which clause and
what the outcome records. For `addRup` that clause is the table's entry at the watermark, so the
justified prefix grows by one; for `addEmpty` it is the empty literal set, and
`LitSet.entails_zero_iff_unsat` turns "the empty clause is entailed" into "the formula is
unsatisfiable" with no special handling at all.

Induction on the action list, `generalizing w`. -/
theorem runActions_sound {t : ClauseTable} {f : CNF Nat} {w : Nat} {acts : List Action}
    (hJ : Justified t f w) : (runActions t w acts).Sound t f := by
  induction acts generalizing w with
  | nil => exact hJ
  | cons act rest ih =>
      cases act with
      | addRup hs =>
          rw [runActions]
          split
          · rename_i hokc
            split
            · rename_i hr
              refine ih (fun id hid => ?_)
              by_cases hidw : id = w
              · subst hidw
                exact ⟨(LitSet.ok_iff _).mp hokc, by simpa using rup_sound hJ hr⟩
              · exact hJ id (by omega)
            · exact trivial
          · exact trivial
      | addEmpty hs =>
          rw [runActions]
          split
          · rename_i hr
            exact LitSet.entails_zero_iff_unsat.mp (by simpa using rup_sound hJ hr)
          · exact trivial

/-- The same across chunks — **for an arbitrary decoder.** Nothing about `decode` is available to this
proof, which is what makes the decoder untrusted as a matter of type rather than of policy.

Indexing the conclusion by the `Outcome` does for the chunk loop what it already did for the action
loop: one induction covers "the empty clause was derived", "the watermark advanced this far" and "the
certificate is wrong", so a segmented check and a whole-certificate check are the same theorem.

Induction on the chunk list, `generalizing w`. -/
theorem runSegment_sound {t : ClauseTable} {f : CNF Nat} {w : Nat} {cert : List Nat}
    (decode : Nat → Option (List Action)) (hJ : Justified t f w) :
    (runSegment t decode w cert).Sound t f := by
  induction cert generalizing w with
  | nil => exact hJ
  | cons ch cs ih =>
      rw [runSegment]
      split
      · exact trivial
      · rename_i acts _
        have hs := runActions_sound (acts := acts) hJ
        split
        · rename_i ho; rw [ho] at hs; exact hs
        · rename_i w' ho; rw [ho] at hs; exact ih hs
        · exact trivial

/-! **Why there are exactly two of the next theorems, and not one.**

`Outcome.Sound` is a `Prop`-valued *match*, so it cannot be inverted: from an expected type
`Justified t f w'` the elaborator cannot recover which constructor produced it, and a single
`sound_of_eq (h : runSegment … = o) : o.Sound t f` would leave `o` an unsolved metavariable — the
`decide` that determines `o` needs its goal first. So the two theorems below are the elimination rules
for a non-invertible motive, one per informative constructor. (`.fault` is the third and no caller
wants it: its `Sound` is `True`.) That is a derivation, not a duplication. -/

/-- **What a certificate segment buys: the watermark moves, and everything below it stays justified.**

The table, the field width, the segment and the watermark it reaches are all **explicit**, for M05's
reason — nothing determines them, so leaving them implicit would make every one of 256 generated
segment modules name its arguments by hand. A generated segment is one citation:

```lean
theorem segA017 (h : Justified halfATable halfACnf 1234567) :
    Justified halfATable halfACnf 1378901 :=
  justified_of_segment halfATable 19 1234567 segA017Chunks 1378901 h (by decide +kernel)
```
-/
theorem justified_of_segment {f : CNF Nat} (t : ClauseTable) (fw w : Nat) (seg : List Nat)
    (w' : Nat) (hJ : Justified t f w)
    (h : runSegment t (decodeChunk fw) w seg = .more w') : Justified t f w' := by
  have hs := runSegment_sound (cert := seg) (decodeChunk fw) hJ
  rw [h] at hs
  exact hs

/-- **And the last segment derives the empty clause.** Same shape, terminal conclusion. -/
theorem unsat_of_segment {f : CNF Nat} (t : ClauseTable) (fw w : Nat) (seg : List Nat)
    (hJ : Justified t f w) (h : runSegment t (decodeChunk fw) w seg = .done) : f.Unsat := by
  have hs := runSegment_sound (cert := seg) (decodeChunk fw) hJ
  rw [h] at hs
  exact hs

/-- The whole-certificate form, for a certificate small enough to check in one module. -/
theorem runStream_sound {t : ClauseTable} {f : CNF Nat} {w : Nat} {cert : List Nat}
    (decode : Nat → Option (List Action)) (hJ : Justified t f w)
    (h : runStream t decode w cert = none) : f.Unsat := by
  have hs := runSegment_sound (cert := cert) decode hJ
  unfold runStream at h
  split at h
  · rename_i ho; rw [ho] at hs; exact hs
  · exact absurd h (by simp)
  · exact absurd h (by simp)

/-- **The milestone's theorem.** If the emitted table really holds the formula, and the checker accepts
the certificate against it, the formula is unsatisfiable.

Both hypotheses are closed `Bool`s the kernel decides, so a proof of unsatisfiability costs no axiom
beyond the standard three — which is the whole point of M05, and the difference between a result a
reader can check and one that asks them to trust a compiler and a CPU.

**The table, the field width and the certificate are explicit**, because nothing determines them: the
goal fixes only the formula. Leaving them implicit would have forced every one of ~1000 generated cube
modules to write `(t := …) (fw := …) (cert := …)`, which is the "argument every caller supplies by
hand" smell — the binder mode was the bug, not the caller.

So a generated per-cube module is one citation:

```lean
theorem cube0017_unsat : (coloringCNF 4 1581 deGrey.edges ++ cubeCNF 4 1581 cube0017).Unsat :=
  maskCheck_sound cube0017Table 24 cube0017Cert (by decide +kernel) (by decide +kernel)
```

and M06 joins ~1000 of those with M03's `not_colorable_of_cubes`. No bridge lemma is needed here, and
adding one would make this module — imported by every generated cube — depend on Mathlib.

That this is one line is the readout on the statements underneath it. -/
theorem maskCheck_sound {f : CNF Nat} (t : ClauseTable) (fw : Nat) (cert : List Nat)
    (hagree : t.agreesWithCNF f = true)
    (hcheck : maskCheck t fw f.clauses.size cert = true) : f.Unsat :=
  runStream_sound (decodeChunk fw) (justified_of_agreesWithCNF hagree)
    (Option.isNone_iff_eq_none.mp hcheck)

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
  { field := 8, perChunk := 2
    chunks :=
      .node 2
        (.node 1
          -- ids 0,1 — `(x ∨ y)` and `(x ∨ ¬y)`
          (.leaf 2 (pack [fld 0 true, fld 1 true, fld 0 true, fld 1 false]))
          -- ids 2,3 — `(¬x ∨ y)` and `(¬x ∨ ¬y)`
          (.leaf 2 (pack [fld 0 false, fld 1 true, fld 0 false, fld 1 false])))
        -- ids 4,5 — the derived clauses `(x)` and `(¬x)`, one literal each, so this chunk needs a
        -- capacity of only 1: the per-chunk width in action.
        (.leaf 1 (pack [fld 0 true, fld 0 false])) }

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

-- **The negative controls, with their diagnostics pinned.** Each breaks one thing; the check must go
-- red *and* say which. `#guard_msgs` puts the rendered message under regression control, so the text a
-- future reader will see is itself a test — the serialized surface is the product.

/-- info: some (HadwigerNelson.CertFault.hintUnjustified 4 5) -/
#guard_msgs in #eval whyNot tbl 8 4 [pack [9, 4, 0, 5, 4, 2, 3, 5, 4, 5]]

/-- info: some (HadwigerNelson.CertFault.noEmptyClause 6) -/
#guard_msgs in #eval whyNot tbl 8 4 [pack [6, 4, 0, 1, 4, 2, 3]]

/-- info: some (HadwigerNelson.CertFault.hintNoPropagate 4 2) -/
#guard_msgs in #eval whyNot tbl 8 4 [pack [9, 4, 0, 2, 4, 2, 3, 5, 4, 5]]

/-- info: some (HadwigerNelson.CertFault.noEmptyClause 4) -/
#guard_msgs in #eval whyNot tbl 8 4 []

/-- **The control that matters most: a satisfiable formula is refused.** The first three clauses of
`f4` alone are satisfied by `x = true, y = true`, and the very same table still *agrees* with that
formula — the table is a prefix of itself. So the only thing standing between a satisfiable formula
and a proof of its unsatisfiability is the certificate check, and this pins that it holds: the
derivation reaches a hint that leaves two literals open instead of one.

Soundness makes this unfalsifiable in principle; the point of running it is that a check nobody has
watched refuse is a check nobody knows works. -/
private def f3 : CNF Nat :=
  ⟨#[[(0, true), (1, true)], [(0, true), (1, false)], [(0, false), (1, true)]]⟩

#guard tbl.agreesWithCNF f3
#guard CNF.eval (fun _ => true) f3

/-- info: some (HadwigerNelson.CertFault.hintNoPropagate 3 0) -/
#guard_msgs in #eval whyNot tbl 8 3 cert

-- A clause citing **itself** as a hint — the bootstrap `rupWhy`'s `hint < w` test exists to stop.
/-- info: some (HadwigerNelson.CertFault.hintUnjustified 4 4) -/
#guard_msgs in #eval whyNot tbl 8 4 [pack [2, 2, 4]]

-- A certificate filed against the wrong number of input clauses: the derived ids are misread, so the
-- very first hint is out of range.
#guard !maskCheck tbl 8 5 cert
-- The certificate decoded at the wrong field width.
#guard !maskCheck tbl 16 4 cert
-- And the `Bool` and the diagnosis cannot disagree, because one is defined from the other.
#guard maskCheck tbl 8 4 cert == (whyNot tbl 8 4 cert).isNone

-- **The segmented check, pinned.** A certificate may be checked in pieces, and a piece reports the
-- watermark it reached rather than demanding the empty clause. One `addRup` deriving clause 4 moves
-- the watermark from 4 to 5 and stops there — no fault, no `done`.
/-- info: HadwigerNelson.Outcome.more 5 -/
#guard_msgs in #eval runSegment tbl (decodeChunk 8) 4 [pack [3, 4, 0, 1]]

-- …and a segment reports a fault in the same shape, which is what `#eval` is for when a `decide
-- +kernel` on a real segment fails with a proposition too large to print.
/-- info: HadwigerNelson.Outcome.fault (HadwigerNelson.CertFault.hintUnjustified 4 5) -/
#guard_msgs in #eval runSegment tbl (decodeChunk 8) 4 [pack [3, 4, 0, 5]]

/-- **The terminal test, in miniature.** The kernel — not the compiler — runs both checks. The same
two `decide +kernel` calls at de Grey's scale are what M05 exists to make affordable. -/
example : tbl.agreesWithCNF f4 = true ∧ maskCheck tbl 8 4 cert = true := by decide +kernel

/-- **The consumer's call site, exactly as a generated cube module will write it.** One citation, two
kernel-decided `Bool`s, and the unsatisfiability of a formula. If this ever needs a named argument or
a second lemma, the surface has regressed. -/
example : f4.Unsat := maskCheck_sound tbl 8 cert (by decide +kernel) (by decide +kernel)

/-- **The same conclusion, reached without the checker at all.** Two variables, four cases, by hand —
so the checker's answer is cross-checked against an independent oracle rather than against itself.
This is the discipline M03 applied to the Moser spindle (`decide` beside the SAT bridge) at the one
scale where the second route is free; above it, no second route exists, which is exactly why the
negative controls above have to carry the weight. -/
example : f4.Unsat := by
  intro a
  cases ha : a 0 <;> cases hb : a 1 <;>
    simp [f4, CNF.eval, CNF.Clause.eval, ha, hb]

end Spec

end HadwigerNelson

import Std.Sat.CNF.Basic
import Init.Data.Nat.Power2.Lemmas

/-!
# Clauses and assignments as bitmasks

The propositional layer of the kernel-checkable refutation checker. A clause is two natural numbers
— the set of variables occurring positively, and the set occurring negatively, each as a bit set —
and a partial assignment is two more. Unit propagation then costs a handful of `Nat` bitwise
operations, all of which the kernel performs in hardware via GMP at any width this project reaches.

## Why bitmasks, and why `Nat`

Measured (`plans/M05-kernel-checker.md`): at 6324 variables, `x &&& y`, `x ^^^ (x &&& y)`,
`x &&& (x - 1)` and `x % 2 ^ k` are *free* — indistinguishable from the cost of the surrounding
recursion — while one iteration of any recursive function costs about 33 µs. **The cost of this
checker is its reduction-step count, not its bit width.** Every definition below is therefore shaped
to do as few reduction steps per propagation as possible, and the width of the numbers involved is
deliberately irrelevant.

`Nat` and not `BitVec` or `USize`: `USize`'s width is `System.Platform.numBits`, which reduces to an
`@[extern] opaque` call the kernel has no rule for, so every `USize` operation is stuck forever —
that single fact is why core's own shipped LRAT checker cannot be run by the kernel at all.

## What is deliberately absent

* **No width parameter, and no complement.** "The literals of `D` not yet falsified by `α`" is a set
  *difference*, `D.pos ^^^ (D.pos &&& α.neg)`, not a complement within a fixed width. So the
  variable count never enters the design, and `Nat.testBit_two_pow_sub_one` — which an earlier plan
  called the load-bearing lemma here — is not on the path.
* **No `Nat.ldiff`.** It exists, it has its own `testBit` lemma, and it is exactly the shape a reader
  will want to tidy `x ^^^ (x &&& y)` into. The kernel accelerates `land`/`lor`/`xor` **by name** and
  cannot do so for a Mathlib definition, so `ldiff` reduces through the `bitwise` recursion at about
  one step per bit: 50 operations at 6324 bits does not complete in 240 seconds. Do not.
* **No "is this clause already satisfied" test.** Dropping it is sound — see `propagate` — and it
  saves three operations and a branch per propagation step.
-/

namespace HadwigerNelson

open Std.Sat

/-- A clause as two bit sets: `pos` is the variables occurring positively, `neg` negatively.

The representation admits a state the problem forbids — a variable in *both* sets, i.e. a
tautological clause — and that state is not harmless: propagating from it makes the assignment
inconsistent, and an inconsistent assignment manufactures conflicts. `Ok` names its absence, and
every consumer demands it. -/
structure MClause where
  /-- Variables occurring positively, as a bit set. -/
  pos : Nat
  /-- Variables occurring negatively, as a bit set. -/
  neg : Nat
deriving DecidableEq, Repr, Inhabited

namespace MClause

/-- The clause is not a tautology: no variable occurs both ways.

This is the one invariant the mask representation cannot carry in its type without an index that
every consumer would pay for, so it is carried as a side condition and demanded by name. -/
def Ok (c : MClause) : Prop := c.pos &&& c.neg = 0

/-- `Ok` as a `Bool` the kernel decides — two accelerated operations. -/
def ok (c : MClause) : Bool := c.pos &&& c.neg == 0

theorem ok_iff (c : MClause) : c.ok = true ↔ c.Ok := by sorry

/-- A total assignment satisfies the clause. Stated over `testBit` against `a : Nat → Bool`, never
over a bitmask *of* `a` — which is what lets the bridge to `Std.Sat.CNF.Unsat` (a `∀` over arbitrary
total assignments) go through with no width argument anywhere. -/
def Sat (a : Nat → Bool) (c : MClause) : Prop :=
  (∃ i, c.pos.testBit i = true ∧ a i = true) ∨ (∃ i, c.neg.testBit i = true ∧ a i = false)

/-- A `Std.Sat` clause as masks. The untrusted emitter's table is checked against *this*, so this
definition is the meaning of "the table really holds the formula". -/
def ofClause (c : CNF.Clause Nat) : MClause :=
  c.foldl
    (fun m (v, b) => if b then ⟨m.pos ||| (1 <<< v), m.neg⟩ else ⟨m.pos, m.neg ||| (1 <<< v)⟩)
    ⟨0, 0⟩

/-- **The bridge.** The mask form of a clause is satisfied by exactly the assignments that satisfy
the clause. Everything downstream reasons about masks; this is the only place the two vocabularies
meet. -/
theorem sat_ofClause_iff (a : Nat → Bool) (c : CNF.Clause Nat) :
    Sat a (ofClause c) ↔ CNF.Clause.eval a c = true := by sorry

end MClause

/-- A partial assignment as two bit sets: variables forced true, and variables forced false.

Consistency (`pos &&& neg = 0`) is deliberately *not* an invariant here. It never needs to be: the
soundness argument always has a total assignment in hand that extends this one, and its existence
rules inconsistency out for free. Carrying it would cost a field and buy nothing. -/
structure Asg where
  /-- Variables forced true, as a bit set. -/
  pos : Nat
  /-- Variables forced false, as a bit set. -/
  neg : Nat
deriving DecidableEq, Repr, Inhabited

namespace Asg

/-- The total assignment `a` agrees with everything the partial assignment `α` has decided. This is
the invariant the whole propagation induction preserves. -/
def Extends (α : Asg) (a : Nat → Bool) : Prop :=
  (∀ i, α.pos.testBit i = true → a i = true) ∧ (∀ i, α.neg.testBit i = true → a i = false)

/-- The assignment that falsifies `c` — where every RUP derivation of `c` starts. -/
def negate (c : MClause) : Asg := ⟨c.neg, c.pos⟩

/-- An assignment that falsifies a clause extends that clause's negation. The base case of the
propagation induction. -/
theorem extends_negate {a : Nat → Bool} {c : MClause} (h : ¬ c.Sat a) : (negate c).Extends a := by
  sorry

end Asg

/-- The outcome of one propagation against one hinted clause. -/
inductive Step where
  /-- Every literal of the clause is false: the derivation succeeds here. -/
  | conflict
  /-- Exactly one literal was undecided; it is now forced. -/
  | prop (α : Asg)
  /-- Two or more literals undecided — the hint does not propagate, so the certificate is wrong. -/
  | fail
deriving DecidableEq, Repr, Inhabited

/-- **One propagation step.** Given a partial assignment and a hinted clause, either the clause is
falsified (a conflict, which is what a RUP derivation is looking for), or exactly one of its
literals is undecided (which is therefore forced), or the certificate is wrong.

The whole step, and the reason the design has no width:

* `up` is the positive literals not yet false — a set *difference*, `pos` minus `α.neg`;
* `un` likewise for the negative literals;
* `u` is their union, and because a non-tautological clause has `pos` and `neg` disjoint, `u`'s
  population count is exactly the number of literals that are not false.

Then `u = 0` is a conflict and `u` a single bit is a forced literal — and "single bit" is
`u &&& (u - 1) = 0`, whose equivalence with `∃ i, u = 2 ^ i` is
`Nat.ne_zero_and_sub_one_eq_zero_iff_isPowerOfTwo`, shipped in core.

**There is no check that the clause is already satisfied, and that is deliberate.** A satisfied
literal is not false, so it lies inside `u`; when `u` is a single bit the satisfied literal *is* the
propagated one, and the update re-asserts what the assignment already held. Adding the test would
cost three operations per step across 1.3 × 10⁷ steps and rule out nothing. -/
def propagate (α : Asg) (c : MClause) : Step :=
  let up := c.pos ^^^ (c.pos &&& α.neg)
  let un := c.neg ^^^ (c.neg &&& α.pos)
  let u  := up ||| un
  if u == 0 then .conflict
  else if u &&& (u - 1) == 0 then .prop ⟨α.pos ||| up, α.neg ||| un⟩
  else .fail

/-- A conflict is impossible against an assignment that a satisfying total assignment extends. This
is what makes reaching `.conflict` evidence, and it needs no tautology hypothesis. -/
theorem propagate_conflict_sound {a : Nat → Bool} {α : Asg} {c : MClause}
    (hE : α.Extends a) (hS : c.Sat a) (h : propagate α c = .conflict) : False := by
  sorry

/-- **The one genuinely new proof in this milestone.** A propagation preserves the invariant: if the
total assignment `a` satisfies the hinted clause and agrees with everything already decided, it also
agrees with the literal the step forces.

`Ok c` is load-bearing here and nowhere else. Without it a single-bit `u` can carry both `v` and
`¬v`, the step forces both, and the assignment becomes inconsistent — after which a later clause
yields a conflict that justifies an arbitrary clause. The negative control in
`plans/M05-kernel-checker.md` § 5 exhibits exactly that, and is the test that this hypothesis is
real. -/
theorem propagate_prop_sound {a : Nat → Bool} {α α' : Asg} {c : MClause}
    (hok : c.Ok) (hE : α.Extends a) (hS : c.Sat a) (h : propagate α c = .prop α') :
    α'.Extends a := by
  sorry

/-! ## Spec

A model of the hypotheses, and a check that the definitions say what they are meant to. The formula
is `(x ∨ y) ∧ (x ∨ ¬y) ∧ (¬x ∨ y) ∧ (¬x ∨ ¬y)` over variables 0 and 1 — unsatisfiable, and small
enough that `decide` cross-checks everything. -/

section Spec

/-- `(x ∨ y)` — variables 0 and 1, both positive. -/
private def cXY : MClause := ⟨0b11, 0⟩
/-- `(x ∨ ¬y)`. -/
private def cXnY : MClause := ⟨0b01, 0b10⟩
/-- `(¬x ∨ y)`. -/
private def cnXY : MClause := ⟨0b10, 0b01⟩
/-- `(¬x ∨ ¬y)`. -/
private def cnXnY : MClause := ⟨0, 0b11⟩
/-- A tautology — the state the representation admits and `Ok` forbids. -/
private def taut : MClause := ⟨0b01, 0b01⟩

#guard cXY.ok && cXnY.ok && cnXY.ok && cnXnY.ok
-- The adversarial member: it satisfies the letter of `MClause` and violates the intent.
#guard !taut.ok

-- Masks agree with the list form they are compiled from.
#guard MClause.ofClause [(0, true), (1, true)] == cXY
#guard MClause.ofClause [(0, true), (1, false)] == cXnY
#guard MClause.ofClause [(1, false), (0, false)] == cnXnY

-- Deriving `(x)` from `(x ∨ y)` and `(x ∨ ¬y)`: start by falsifying `(x)`, propagate `y` from the
-- first clause, then hit a conflict on the second. This is a whole RUP step, by hand.
#guard propagate (Asg.negate ⟨0b01, 0⟩) cXY == .prop ⟨0b10, 0b01⟩
#guard propagate ⟨0b10, 0b01⟩ cXnY == .conflict

-- A hint that does not propagate is rejected rather than guessed at.
#guard propagate ⟨0, 0⟩ cXY == .fail

-- **The denied obligation, pinned.** Propagating from a tautology forces a variable both ways —
-- an inconsistent assignment, from which conflicts are manufactured. `Ok` is what excludes it, and
-- this is the fact that makes that hypothesis load-bearing rather than decorative.
#guard propagate ⟨0, 0⟩ taut == .prop ⟨0b01, 0b01⟩

end Spec

end HadwigerNelson

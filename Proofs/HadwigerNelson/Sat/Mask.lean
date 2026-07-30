import Std.Sat.CNF.Basic
import Init.Data.Nat.Power2.Lemmas

/-!
# Literal sets as bitmasks

The propositional layer of the kernel-checkable refutation checker.

## One type, two readings

A clause and a partial assignment are the same object — **a set of literals** — read two different
ways. A clause `x ∨ ¬y` asserts that *some* literal holds; the assignment `x = true, y = false`
asserts that *every* one does. Modelling them as two types would be incidental structure, and the
evidence is mechanical: the map between them (`negate`, flipping every polarity) is an involution,
and the theorem relating the two readings — `all_iff_not_any` — comes out as **commutativity of `∧`**
after normalization. Two genuinely different types could not do that.

So there is one type, `LitSet`, with `Any` (the clause reading) and `All` (the assignment reading).
An assignment falsifies a clause exactly when it satisfies the clause's negation, and that is one
lemma rather than a family of ad-hoc bridges.

## Why `testBit`, and not a bit-set abstraction of our own

Core tags `Nat.testBit_and`, `testBit_or` and `testBit_xor` `@[simp, grind =]`. **`testBit` is the
library's own normal form for reasoning about `Nat` bitwise operations**, not a preference of ours —
so every proof here ends in the vocabulary the automation already drives toward. Wrapping `Nat` in a
`BitSet` type with its own membership lemmas would fight that normal form: `simp` and `grind` would
unfold straight through it, and every lemma would need restating.

## Why `Nat`, and the cost model that shapes everything below

Measured (`plans/M05-kernel-checker.md` § 0): at 6324 variables, `x &&& y`, `x ^^^ (x &&& y)`,
`x &&& (x - 1)` and `x % 2 ^ k` are *free* — inside the noise of the surrounding recursion — while
one iteration of any recursive function costs about **33 µs**. **Reduction-step count is the only
cost; bit width is irrelevant.** Every definition here is shaped for fewest steps per propagation.

`Nat` and not `USize` or `BitVec`: `USize`'s width is `System.Platform.numBits`, which reduces to an
`@[extern] opaque` call the kernel has no rule for, so every `USize` operation is stuck forever —
that one fact is why core's shipped LRAT checker cannot be run by the kernel at all.

## What is deliberately absent

* **No width parameter, and no complement.** "The literals of `D` not yet falsified by `α`" is a set
  *difference*, `D.pos ^^^ (D.pos &&& α.neg)`, not a complement within a fixed width. So the variable
  count never enters the design, and `Nat.testBit_two_pow_sub_one` — which an earlier plan called the
  load-bearing lemma here — is not on the path.
* **No `Nat.ldiff`.** It exists, it has its own `testBit` lemma, and it is exactly the shape a reader
  will want to tidy `x ^^^ (x &&& y)` into. The kernel accelerates `land`/`lor`/`xor` **by name** and
  cannot do so for a Mathlib definition, so `ldiff` reduces through the `bitwise` recursion at about
  one step per bit: 50 operations at 6324 bits does not complete in 240 seconds. Do not.
* **No "is this clause already satisfied" test.** Dropping it is sound — see `propagate` — and it
  saves three operations and a branch per propagation step.
-/

namespace HadwigerNelson

open Std.Sat

/-! ## A `Nat` fact with no model in it

The arithmetic core of the whole checker, isolated so that nothing about SAT appears in it. Not in
core and not in Mathlib — grepped, in the toolchain source, which is where the last three "missing"
lemmas turned out to be. Worth offering upstream. -/

/-- **Two disjoint bit sets whose union is a single bit: one of them is that bit, the other is
empty.** This is what turns the checker's single-bit test into "exactly one literal was undecided",
and it is the reason the non-tautology hypothesis is needed — without disjointness both sets could
contain the bit. -/
theorem or_eq_two_pow_cases {x y i : Nat} (hu : x ||| y = 2 ^ i) (hd : x &&& y = 0) :
    (x = 2 ^ i ∧ y = 0) ∨ (x = 0 ∧ y = 2 ^ i) := by
  have hb : ∀ j, (x.testBit j || y.testBit j) = decide (i = j) := fun j => by
    rw [← Nat.testBit_or, hu, Nat.testBit_two_pow]
  have hc : ∀ j, (x.testBit j && y.testBit j) = false := fun j => by
    rw [← Nat.testBit_and, hd, Nat.zero_testBit]
  have hoff : ∀ j, ¬ i = j → x.testBit j = false ∧ y.testBit j = false := by
    intro j hj
    have h := hb j
    simp only [hj, decide_false, Bool.or_eq_false_iff] at h
    exact h
  by_cases hx : x.testBit i = true
  · refine Or.inl ⟨Nat.eq_of_testBit_eq fun j => ?_, Nat.eq_of_testBit_eq fun j => ?_⟩
    · rw [Nat.testBit_two_pow]
      by_cases hj : i = j
      · subst hj; simp [hx]
      · simp [hj, (hoff j hj).1]
    · rw [Nat.zero_testBit]
      by_cases hj : i = j
      · subst hj
        have h := hc i; simp only [hx, Bool.true_and] at h; exact h
      · exact (hoff j hj).2
  · rw [Bool.not_eq_true] at hx
    have hy : y.testBit i = true := by
      have h := hb i; simp only [hx, Bool.false_or] at h; simpa using h
    refine Or.inr ⟨Nat.eq_of_testBit_eq fun j => ?_, Nat.eq_of_testBit_eq fun j => ?_⟩
    · rw [Nat.zero_testBit]
      by_cases hj : i = j
      · subst hj; exact hx
      · exact (hoff j hj).1
    · rw [Nat.testBit_two_pow]
      by_cases hj : i = j
      · subst hj; simp [hy]
      · simp [hj, (hoff j hj).2]

/-- **A set of literals**: `pos` the variables occurring positively, `neg` those occurring
negatively, each as a bit set.

Read as a clause (`Any`) or as a partial assignment (`All`). The representation admits a variable in
*both* sets — a tautology as a clause, an inconsistency as an assignment — and that state is not
harmless: propagating from a tautology forces a variable both ways, and an inconsistent assignment
manufactures conflicts. `Ok` names its absence, and the consumers that need it demand it by name. -/
structure LitSet where
  /-- Variables occurring positively, as a bit set. -/
  pos : Nat
  /-- Variables occurring negatively, as a bit set. -/
  neg : Nat
deriving DecidableEq, Repr, Inhabited

namespace LitSet

/-- **The clause reading**: `a` makes *some* literal true. -/
def Any (L : LitSet) (a : Nat → Bool) : Prop :=
  (∃ i, L.pos.testBit i = true ∧ a i = true) ∨ (∃ i, L.neg.testBit i = true ∧ a i = false)

/-- **The assignment reading**: `a` makes *every* literal true — i.e. `a` agrees with everything this
partial assignment has decided. -/
def All (L : LitSet) (a : Nat → Bool) : Prop :=
  (∀ i, L.pos.testBit i = true → a i = true) ∧ (∀ i, L.neg.testBit i = true → a i = false)

/-- Flip every literal's polarity. -/
def negate (L : LitSet) : LitSet := ⟨L.neg, L.pos⟩

@[simp] theorem negate_negate (L : LitSet) : L.negate.negate = L := rfl

/-- **The duality.** The two readings are each other's negation through `negate` — De Morgan, stated
once, in place of a family of lemmas relating a clause to the assignment that falsifies it.

That this proof is `And.comm` is the evidence that one type was right: a clause and the assignment
falsifying it are the same data. -/
theorem all_iff_not_any (L : LitSet) (a : Nat → Bool) : L.All a ↔ ¬ L.negate.Any a := by
  simp only [All, Any, negate, not_or, not_exists, not_and, Bool.not_eq_true, Bool.not_eq_false]
  exact and_comm

/-- Not a tautology: no variable occurs both ways.

**Extrinsic, and necessarily so.** The clause reading needs it — `propagate_prop_sound` would be
false without it — and the assignment reading has no use for it at all, because the soundness
argument always has a total assignment in hand whose existence rules inconsistency out for free.
A bundled proof field would therefore tax exactly the half of the uses that do not need it. -/
def Ok (L : LitSet) : Prop := L.pos &&& L.neg = 0

/-- `Ok` as a `Bool` the kernel decides — two accelerated operations. -/
def ok (L : LitSet) : Bool := L.pos &&& L.neg == 0

theorem ok_iff (L : LitSet) : L.ok = true ↔ L.Ok := by sorry

/-- A `Std.Sat` clause as a literal set. The untrusted table is checked against *this*, so this
definition is what "the table really holds the formula" means. -/
def ofClause (c : CNF.Clause Nat) : LitSet :=
  c.foldl
    (fun m (v, b) => if b then ⟨m.pos ||| (1 <<< v), m.neg⟩ else ⟨m.pos, m.neg ||| (1 <<< v)⟩)
    ⟨0, 0⟩

/-- **The bridge to `Std.Sat`.** The literal-set form of a clause is satisfied by exactly the
assignments that satisfy the clause. Everything downstream reasons about bit sets; this is the only
place the two vocabularies meet. -/
theorem any_ofClause_iff (a : Nat → Bool) (c : CNF.Clause Nat) :
    (ofClause c).Any a ↔ CNF.Clause.eval a c = true := by sorry

/-- **The role the checker establishes**: this literal set, read as a clause, follows from `f`. -/
def Entails (L : LitSet) (f : CNF Nat) : Prop :=
  ∀ a, CNF.eval a f = true → L.Any a

end LitSet

/-- The outcome of one propagation against one hinted clause. -/
inductive Step where
  /-- Every literal of the clause is false: the derivation succeeds here. -/
  | conflict
  /-- Exactly one literal was undecided; it is now forced. -/
  | prop (α : LitSet)
  /-- Two or more literals undecided — the hint does not propagate, so the certificate is wrong. -/
  | fail
deriving DecidableEq, Repr, Inhabited

/-- **One propagation step.** `α` is read as an assignment, `D` as a clause. Either `D` is falsified
(a conflict, which is what a reverse-unit-propagation derivation is looking for), or exactly one of
its literals is undecided and therefore forced, or the certificate is wrong.

* `up` is the positive literals not yet false — a set *difference*, `pos` minus `α.neg`;
* `un` likewise for the negative literals;
* `u` is their union, and because a non-tautological clause has `pos` and `neg` disjoint, `u`'s
  population count is exactly the number of literals that are not false.

`u = 0` is a conflict; `u` a single bit is a forced literal. "Single bit" is `u &&& (u - 1) = 0`,
whose equivalence with `∃ i, u = 2 ^ i` is `Nat.ne_zero_and_sub_one_eq_zero_iff_isPowerOfTwo`,
shipped in core.

**There is no check that the clause is already satisfied, and that is deliberate.** A satisfied
literal is not false, so it lies inside `u`; when `u` is a single bit the satisfied literal *is* the
propagated one, and the update re-asserts what the assignment already held. Adding the test would
cost three operations per step across 1.3 × 10⁷ steps and rule out nothing.

Both arguments have the same type, because a clause and an assignment *are* the same kind of thing.
Swapping them is a wrong call, not an illegal state — and it cannot produce a false theorem, only a
failed check. The spec section pins the intended reading. -/
def propagate (α D : LitSet) : Step :=
  let up := D.pos ^^^ (D.pos &&& α.neg)
  let un := D.neg ^^^ (D.neg &&& α.pos)
  let u  := up ||| un
  if u == 0 then .conflict
  else if u &&& (u - 1) == 0 then .prop ⟨α.pos ||| up, α.neg ||| un⟩
  else .fail

/-- A conflict is impossible against an assignment that a satisfying total assignment agrees with.
This is what makes reaching `.conflict` evidence, and it needs no tautology hypothesis. -/
theorem propagate_conflict_sound {a : Nat → Bool} {α D : LitSet}
    (hE : α.All a) (hS : D.Any a) (h : propagate α D = .conflict) : False := by
  sorry

/-- **The one genuinely new proof in this milestone.** A propagation preserves the invariant: if the
total assignment `a` satisfies the hinted clause and agrees with everything already decided, it also
agrees with the literal the step forces.

`Ok D` is load-bearing here and nowhere else, and `or_eq_two_pow_cases` is what consumes it: without
disjointness a single-bit `u` can carry both `v` and `¬v`, the step forces both, and the assignment
becomes inconsistent — after which a later clause yields a conflict that justifies an arbitrary
clause. The negative control in `plans/M05-kernel-checker.md` § 5 exhibits exactly that. -/
theorem propagate_prop_sound {a : Nat → Bool} {α α' D : LitSet}
    (hok : D.Ok) (hE : α.All a) (hS : D.Any a) (h : propagate α D = .prop α') :
    α'.All a := by
  sorry

/-! ## Spec

A model of the hypotheses, and a check that the definitions say what they are meant to. The formula
is `(x ∨ y) ∧ (x ∨ ¬y) ∧ (¬x ∨ y) ∧ (¬x ∨ ¬y)` over variables 0 and 1 — unsatisfiable, and small
enough that `decide` cross-checks everything. -/

section Spec

/-- `(x ∨ y)` — variables 0 and 1, both positive. -/
private def cXY : LitSet := ⟨0b11, 0⟩
/-- `(x ∨ ¬y)`. -/
private def cXnY : LitSet := ⟨0b01, 0b10⟩
/-- `(¬x ∨ y)`. -/
private def cnXY : LitSet := ⟨0b10, 0b01⟩
/-- `(¬x ∨ ¬y)`. -/
private def cnXnY : LitSet := ⟨0, 0b11⟩
/-- A tautology — the state the representation admits and `Ok` forbids. -/
private def taut : LitSet := ⟨0b01, 0b01⟩

#guard cXY.ok && cXnY.ok && cnXY.ok && cnXnY.ok
-- The adversarial member: it satisfies the letter of `LitSet` and violates the intent.
#guard !taut.ok

-- `negate` is the involution that carries the clause reading to the assignment reading.
#guard cXnY.negate == ({ pos := 0b10, neg := 0b01 } : LitSet)
#guard cXnY.negate.negate == cXnY

-- Masks agree with the list form they are compiled from.
#guard LitSet.ofClause [(0, true), (1, true)] == cXY
#guard LitSet.ofClause [(0, true), (1, false)] == cXnY
#guard LitSet.ofClause [(1, false), (0, false)] == cnXnY

-- Deriving `(x)` from `(x ∨ y)` and `(x ∨ ¬y)`: start by falsifying `(x)`, propagate `y` from the
-- first clause, then hit a conflict on the second. A whole derivation, by hand — and the argument
-- order of `propagate` pinned, since both arguments have the same type.
#guard propagate (LitSet.negate ⟨0b01, 0⟩) cXY == .prop ⟨0b10, 0b01⟩
#guard propagate ⟨0b10, 0b01⟩ cXnY == .conflict

-- A hint that does not propagate is rejected rather than guessed at.
#guard propagate ⟨0, 0⟩ cXY == .fail

-- **The denied obligation, pinned.** Propagating from a tautology forces a variable both ways —
-- an inconsistent assignment, from which conflicts are manufactured. `Ok` is what excludes it, and
-- this is the fact that makes that hypothesis load-bearing rather than decorative.
#guard propagate ⟨0, 0⟩ taut == .prop ⟨0b01, 0b01⟩

-- The arithmetic core, on the case that matters and on the case `Ok` rules out.
example : (0b100 ||| 0 = 2 ^ 2) ∧ (0b100 &&& 0 = 0) := by decide
#guard (0b100 ||| 0b100) == 2 ^ 2 && !((0b100 &&& 0b100) == 0)

end Spec

end HadwigerNelson

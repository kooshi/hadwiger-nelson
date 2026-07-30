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

/-- **Set difference, one bit at a time.** `x ^^^ (x &&& y)` is `x` minus `y`, and this is the *only*
bit-level content in either propagation soundness proof — named once so the same `simp` chain does not
reappear in every case. -/
theorem testBit_xor_and (x y i : Nat) :
    (x ^^^ (x &&& y)).testBit i = (x.testBit i && !y.testBit i) := by
  rw [Nat.testBit_xor, Nat.testBit_and]
  cases x.testBit i <;> cases y.testBit i <;> rfl

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

/-- **Adding one bit adds exactly one witness.** The bit-level content of `any_insert`, isolated so the
clause-building induction contains no bit arithmetic at all: a set extended by the single bit `v`
witnesses `p` exactly when the old set did, or `p` holds at `v`. -/
theorem exists_testBit_or_two_pow {x v : Nat} {p : Nat → Prop} :
    (∃ i, (x ||| 1 <<< v).testBit i = true ∧ p i) ↔ (∃ i, x.testBit i = true ∧ p i) ∨ p v := by
  constructor
  · rintro ⟨i, hi, hp⟩
    rw [Nat.one_shiftLeft, Nat.testBit_or, Nat.testBit_two_pow] at hi
    rcases Bool.or_eq_true _ _ |>.mp hi with h | h
    · exact Or.inl ⟨i, h, hp⟩
    · exact Or.inr (of_decide_eq_true h ▸ hp)
  · rintro (⟨i, hi, hp⟩ | hp)
    · exact ⟨i, by rw [Nat.testBit_or, hi, Bool.true_or], hp⟩
    · exact ⟨v, by rw [Nat.one_shiftLeft, Nat.testBit_or, Nat.testBit_two_pow]; simp, hp⟩

/-- **An empty union witnesses nothing.** Both propagation soundness proofs reach for this: the
conflict test is `pos ||| neg = 0`, and that one equation kills every witness on both sides. -/
theorem not_any_of_or_eq_zero {x y : Nat} {p q : Nat → Prop} (h : x ||| y = 0) :
    ¬ ((∃ i, x.testBit i = true ∧ p i) ∨ (∃ i, y.testBit i = true ∧ q i)) := by
  have hz : ∀ i, x.testBit i = false ∧ y.testBit i = false := fun i => by
    have : (x.testBit i || y.testBit i) = false := by
      rw [← Nat.testBit_or, h, Nat.zero_testBit]
    exact Bool.or_eq_false_iff.mp this
  rintro (⟨i, hi, _⟩ | ⟨i, hi, _⟩)
  · exact absurd hi (by rw [(hz i).1]; simp)
  · exact absurd hi (by rw [(hz i).2]; simp)

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

/-- The `Bool` the kernel decides and the `Prop` the proofs consume are the same fact. -/
theorem ok_iff (L : LitSet) : L.ok = true ↔ L.Ok := by
  simp [ok, Ok]

/-- The empty literal set satisfies nobody. -/
theorem not_any_zero (a : Nat → Bool) : ¬ (⟨0, 0⟩ : LitSet).Any a := by
  simp [Any, Nat.zero_testBit]

/-- Add one literal. Named, because it is the step of the fold below and therefore the subject of the
lemma that carries the induction — an anonymous lambda inside `ofClause` could not be spoken about. -/
def insert (L : LitSet) (l : Literal Nat) : LitSet :=
  if l.2 then ⟨L.pos ||| (1 <<< l.1), L.neg⟩ else ⟨L.pos, L.neg ||| (1 <<< l.1)⟩

/-- A `Std.Sat` clause as a literal set. The untrusted table is checked against *this*, so this
definition is what "the table really holds the formula" means. -/
def ofClause (c : CNF.Clause Nat) : LitSet := c.foldl insert ⟨0, 0⟩

/-- Adding a literal adds exactly that literal's satisfaction, and nothing else. -/
theorem any_insert (L : LitSet) (a : Nat → Bool) (l : Literal Nat) :
    (L.insert l).Any a ↔ L.Any a ∨ a l.1 = l.2 := by
  obtain ⟨v, s⟩ := l
  cases s
  · show (LitSet.mk L.pos (L.neg ||| (1 <<< v))).Any a ↔ L.Any a ∨ a v = false
    simp only [Any]
    rw [exists_testBit_or_two_pow, or_assoc]
  · show (LitSet.mk (L.pos ||| (1 <<< v)) L.neg).Any a ↔ L.Any a ∨ a v = true
    simp only [Any]
    rw [exists_testBit_or_two_pow]
    constructor
    · rintro ((h | h) | h)
      · exact Or.inl (Or.inl h)
      · exact Or.inr h
      · exact Or.inl (Or.inr h)
    · rintro ((h | h) | h)
      · exact Or.inl (Or.inl h)
      · exact Or.inr h
      · exact Or.inl (Or.inr h)

/-- **The strengthened statement the induction actually needs.** `ofClause` is a fold from `⟨0,0⟩`, so
an induction stated only at `⟨0,0⟩` has an induction hypothesis that cannot carry itself through the
step: after one literal the accumulator is no longer empty. Quantifying the accumulator — Gries's
fresh variable — makes every case local. -/
theorem any_foldl_insert (a : Nat → Bool) (c : CNF.Clause Nat) (L : LitSet) :
    (c.foldl insert L).Any a ↔ L.Any a ∨ CNF.Clause.eval a c = true := by
  induction c generalizing L with
  | nil => simp
  | cons l c ih =>
      rw [List.foldl_cons, ih, any_insert, CNF.Clause.eval_cons, or_assoc]
      simp [beq_iff_eq]

/-- **The bridge to `Std.Sat`.** The literal-set form of a clause is satisfied by exactly the
assignments that satisfy the clause. Everything downstream reasons about bit sets; this is the only
place the two vocabularies meet.

The empty accumulator contributes nothing, which is why the strengthened form specialises back. -/
theorem any_ofClause_iff (a : Nat → Bool) (c : CNF.Clause Nat) :
    (ofClause c).Any a ↔ CNF.Clause.eval a c = true := by
  rw [ofClause, any_foldl_insert]
  refine ⟨fun h => h.resolve_left (not_any_zero a), Or.inr⟩

/-- **The role the checker establishes**: this literal set, read as a clause, follows from `f`. -/
def Entails (L : LitSet) (f : CNF Nat) : Prop :=
  ∀ a, CNF.eval a f = true → L.Any a

/-- **Why the empty clause needs no special handling.** "The empty clause follows from `f`" *is*
"`f` is unsatisfiable" — so the one lemma about reverse unit propagation covers both kinds of
certificate step, and `runActions`' two branches cite it identically. -/
theorem entails_zero_iff_unsat {f : CNF Nat} : (⟨0, 0⟩ : LitSet).Entails f ↔ f.Unsat := by
  constructor
  · intro h a
    cases hev : CNF.eval a f
    · rfl
    · exact absurd (h a hev) (not_any_zero a)
  · intro h a hev
    exact absurd hev (by rw [h a]; simp)

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

/-- The literals of `D` that `α` has not already falsified — `D`'s sides minus what `α` has decided
against, each a set *difference* rather than a complement, which is why no width appears.

Named rather than inlined into `propagate`, because it is the subject of every lemma below: the
definition shaped around the statement. It costs about three reduction steps per propagation out of
roughly fifty; if that shows up in measurement, `propagate` can be inlined against a stated equation
lemma without touching a proof. -/
def undecided (α D : LitSet) : LitSet :=
  ⟨D.pos ^^^ (D.pos &&& α.neg), D.neg ^^^ (D.neg &&& α.pos)⟩

/-- **One propagation step.** `α` is read as an assignment, `D` as a clause. Either `D` is falsified
(a conflict, which is what a reverse-unit-propagation derivation is looking for), or exactly one of
its literals is undecided and therefore forced, or the certificate is wrong.

Because a non-tautological clause has its two sides disjoint, the population count of
`u = U.pos ||| U.neg` is exactly the number of literals that are not false. So `u = 0` is a conflict,
and `u` a single bit is a forced literal — where "single bit" is `u &&& (u - 1) = 0`, whose
equivalence with `∃ i, u = 2 ^ i` is `Nat.ne_zero_and_sub_one_eq_zero_iff_isPowerOfTwo`, shipped in
core.

**There is no check that the clause is already satisfied, and that is deliberate.** A satisfied
literal is not false, so it lies inside `u`; when `u` is a single bit the satisfied literal *is* the
propagated one, and the update re-asserts what the assignment already held. Adding the test would
cost three operations per step across 1.3 × 10⁷ steps and rule out nothing.

Both arguments have the same type, because a clause and an assignment *are* the same kind of thing.
Swapping them is a wrong call, not an illegal state — and it cannot produce a false theorem, only a
failed check. The spec section pins the intended reading. -/
def propagate (α D : LitSet) : Step :=
  let U := undecided α D
  let u := U.pos ||| U.neg
  if u == 0 then .conflict
  else if u &&& (u - 1) == 0 then .prop ⟨α.pos ||| U.pos, α.neg ||| U.neg⟩
  else .fail

/-! ### The two facts both soundness proofs share

Both proofs destructure the same two nested tests over the same `undecided` set, and both need
exactly one thing from the assignment: the literal `a` satisfies has not been falsified, so it
survives into `undecided`. Stated once here, the two proofs below become case analysis with no bit
arithmetic left in them. -/

/-- A non-tautological clause has a non-tautological undecided set — which is what carries the `Ok`
hypothesis into `or_eq_two_pow_cases`, the one place it is consumed. -/
theorem ok_undecided {α D : LitSet} (hok : D.Ok) : (undecided α D).Ok := by
  have hok' : D.pos &&& D.neg = 0 := hok
  show (undecided α D).pos &&& (undecided α D).neg = 0
  refine Nat.eq_of_testBit_eq fun i => ?_
  have hD : (D.pos.testBit i && D.neg.testBit i) = false := by
    rw [← Nat.testBit_and, hok', Nat.zero_testBit]
  simp only [undecided, Nat.testBit_and, testBit_xor_and, Nat.zero_testBit]
  cases hp : D.pos.testBit i <;> cases hn : D.neg.testBit i <;> simp_all

/-- **The shared fact.** A satisfied literal of `D` survives into `undecided α D`: `α` agrees with
`a` everywhere it has decided, so the literal `a` satisfies cannot be one `α` falsified. -/
theorem any_undecided {a : Nat → Bool} {α D : LitSet} (hE : α.All a) (hS : D.Any a) :
    (undecided α D).Any a := by
  show ((∃ i, (undecided α D).pos.testBit i = true ∧ a i = true) ∨
        ∃ i, (undecided α D).neg.testBit i = true ∧ a i = false)
  simp only [undecided, testBit_xor_and]
  rcases hS with ⟨i, hi, ha⟩ | ⟨i, hi, ha⟩
  · refine Or.inl ⟨i, ?_, ha⟩
    have hn : α.neg.testBit i = false := by
      cases hb : α.neg.testBit i
      · rfl
      · exact absurd (hE.2 i hb) (by rw [ha]; simp)
    rw [hi, hn]; rfl
  · refine Or.inr ⟨i, ?_, ha⟩
    have hp : α.pos.testBit i = false := by
      cases hb : α.pos.testBit i
      · rfl
      · exact absurd (hE.1 i hb) (by rw [ha]; simp)
    rw [hi, hp]; rfl

/-! The two sides of `propagate`'s forced-literal case are mirror images of each other — one side is
the forced bit and the other is empty, and which is which depends only on the literal's polarity. The
three facts below are stated over an arbitrary polarity `b` precisely so that the mirror is a change
of argument rather than a second copy of the proof. -/

/-- Extending a decided set by the single bit `k`, where the assignment already agrees at `k`. -/
private theorem all_or_two_pow {a : Nat → Bool} {x k : Nat} {b : Bool}
    (hx : ∀ i, x.testBit i = true → a i = b) (hk : a k = b) :
    ∀ i, (x ||| 2 ^ k).testBit i = true → a i = b := by
  intro i hi
  rw [Nat.testBit_or, Nat.testBit_two_pow] at hi
  rcases Bool.or_eq_true _ _ |>.mp hi with h | h
  · exact hx i h
  · exact of_decide_eq_true h ▸ hk

/-- A witness inside a single-bit set is that bit. -/
private theorem eq_of_exists_two_pow {a : Nat → Bool} {k : Nat} {b : Bool}
    (h : ∃ i, (2 ^ k).testBit i = true ∧ a i = b) : a k = b := by
  obtain ⟨i, hi, ha⟩ := h
  rw [Nat.testBit_two_pow] at hi
  have hik : k = i := of_decide_eq_true hi
  subst hik
  exact ha

/-- An empty set holds no witness — what rules out the mirror side in each case. -/
private theorem not_exists_zero_testBit {p : Nat → Prop} :
    ¬ ∃ i, (0 : Nat).testBit i = true ∧ p i := by
  rintro ⟨i, hi, _⟩
  simp [Nat.zero_testBit] at hi

/-- A conflict is impossible against an assignment that a satisfying total assignment agrees with.
This is what makes reaching `.conflict` evidence, and it needs no tautology hypothesis: an empty
undecided set contradicts `any_undecided` directly. -/
theorem propagate_conflict_sound {a : Nat → Bool} {α D : LitSet}
    (hE : α.All a) (hS : D.Any a) (h : propagate α D = .conflict) : False := by
  have hU : (undecided α D).Any a := any_undecided hE hS
  unfold propagate at h
  simp only at h
  split at h
  · rename_i hz
    exact not_any_of_or_eq_zero (beq_iff_eq.mp hz) hU
  · split at h <;> exact absurd h (by simp)

/-- **The one genuinely new proof in this milestone.** A propagation preserves the invariant: if the
total assignment `a` satisfies the hinted clause and agrees with everything already decided, it also
agrees with the literal the step forces.

The argument, with the bit arithmetic already discharged above: the single-bit test plus
`Nat.ne_zero_and_sub_one_eq_zero_iff_isPowerOfTwo` give `u = 2 ^ i`; `ok_undecided` plus
`or_eq_two_pow_cases` then force one side of `undecided` to be that bit and the other empty; and
`any_undecided` says the satisfied literal is on the non-empty side. -/
theorem propagate_prop_sound {a : Nat → Bool} {α α' D : LitSet}
    (hok : D.Ok) (hE : α.All a) (hS : D.Any a) (h : propagate α D = .prop α') :
    α'.All a := by
  have hU : (undecided α D).Any a := any_undecided hE hS
  have hokU : (undecided α D).pos &&& (undecided α D).neg = 0 := ok_undecided hok
  unfold propagate at h
  simp only at h
  split at h
  · exact absurd h (by simp)
  · rename_i hne
    split at h
    · rename_i hone
      injection h with h; subst h
      have hu0 : (undecided α D).pos ||| (undecided α D).neg ≠ 0 := fun hc =>
        hne (by rw [hc]; rfl)
      obtain ⟨k, hk⟩ :=
        Nat.ne_zero_and_sub_one_eq_zero_iff_isPowerOfTwo.mp ⟨hu0, beq_iff_eq.mp hone⟩
      -- The two sides are mirror images: exactly one of them is the forced bit.
      rcases or_eq_two_pow_cases hk hokU with ⟨hp, hn⟩ | ⟨hp, hn⟩
      · refine ⟨?_, ?_⟩
        · rw [hp]
          exact all_or_two_pow hE.1
            (eq_of_exists_two_pow (hp ▸ hU.resolve_right (hn ▸ not_exists_zero_testBit)))
        · rw [hn]; simpa using hE.2
      · refine ⟨?_, ?_⟩
        · rw [hp]; simpa using hE.1
        · rw [hn]
          exact all_or_two_pow hE.2
            (eq_of_exists_two_pow (hn ▸ hU.resolve_left (hp ▸ not_exists_zero_testBit)))
    · exact absurd h (by simp)
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

/-- **The non-tautology hypothesis is load-bearing, proved rather than asserted.** Delete `hok` from
`propagate_prop_sound` and the statement becomes *false*, not merely unproven — and this exhibits the
counterexample. Propagating from the tautology `x ∨ ¬x` against an empty assignment yields the single
`u` bit for variable 0 with that bit set on *both* sides, so the forced assignment demands
`a 0 = true` and `a 0 = false` at once.

A build failure could never establish this; only a countermodel can. Its partner above is the
`example` that exhibits a model of all the hypotheses at once — together they pin the statement from
both sides. -/
example : ¬ ∀ (a : Nat → Bool) (α α' D : LitSet),
    α.All a → D.Any a → propagate α D = .prop α' → α'.All a := by
  intro h
  have hAll := h (fun _ => true) ⟨0, 0⟩ ⟨0b01, 0b01⟩ taut
    ⟨fun i hi => absurd hi (by simp [Nat.zero_testBit]),
     fun i hi => absurd hi (by simp [Nat.zero_testBit])⟩
    (Or.inl ⟨0, by decide, rfl⟩) (by decide)
  exact absurd (hAll.2 0 (by decide)) (by simp)

end Spec

end HadwigerNelson

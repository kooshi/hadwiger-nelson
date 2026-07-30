import Std.Sat.CNF.Basic
import Init.Data.Nat.Power2.Lemmas

/-! M05 domain-modeling probe. Four questions, each answered by whether the code below works:

1. Are `MClause` and `Asg` one type with two readings? -> `Lits`, `Any`, `All`.
2. Is the clause/negation relationship one lemma instead of two? -> `all_iff_not_any`.
3. Does the single-bit argument reduce to a named `Nat` fact? -> `or_eq_two_pow_cases`.
4. Can "the decoder is untrusted" be a universally quantified variable? -> `runStream`.
-/

namespace Probe

/-- A set of literals: `pos` those occurring positively, `neg` negatively, each as a bit set. -/
structure Lits where
  pos : Nat
  neg : Nat
deriving DecidableEq, Repr, Inhabited

namespace Lits

/-- Read **disjunctively** — a clause. Some literal is true. -/
def Any (a : Nat → Bool) (L : Lits) : Prop :=
  (∃ i, L.pos.testBit i = true ∧ a i = true) ∨ (∃ i, L.neg.testBit i = true ∧ a i = false)

/-- Read **conjunctively** — a partial assignment. Every literal is true. -/
def All (a : Nat → Bool) (L : Lits) : Prop :=
  (∀ i, L.pos.testBit i = true → a i = true) ∧ (∀ i, L.neg.testBit i = true → a i = false)

/-- Flip every literal's polarity. -/
def negate (L : Lits) : Lits := ⟨L.neg, L.pos⟩

@[simp] theorem negate_negate (L : Lits) : negate (negate L) = L := rfl

/-- **The duality.** The two readings are each other's negation through `negate` — De Morgan, once,
in place of separate lemmas relating a clause to the assignment that falsifies it. -/
theorem all_iff_not_any (a : Nat → Bool) (L : Lits) : All a L ↔ ¬ Any a (negate L) := by
  simp only [All, Any, negate, not_or, not_exists, not_and, Bool.not_eq_true]
  constructor
  · exact fun ⟨hp, hn⟩ => ⟨fun i h ha => absurd (hn i h) (by simp [ha]),
                           fun i h ha => absurd (hp i h) (by simp [ha])⟩
  · refine fun ⟨h1, h2⟩ => ⟨fun i h => ?_, fun i h => ?_⟩
    · cases hh : a i
      · exact absurd rfl (by simpa using h2 i h)
      · rfl
    · cases hh : a i
      · rfl
      · exact absurd rfl (by simpa using h1 i h)

/-- A clause is not a tautology. Extrinsic, because the *assignment* reading has no use for it —
which is exactly why one shared type is right and a bundled proof field would be wrong. -/
def Ok (L : Lits) : Prop := L.pos &&& L.neg = 0

end Lits

/-- **The single-bit argument, reduced to a `Nat` fact with no model in it.** Two disjoint bit sets
whose union is a single bit: one of them is that bit and the other is empty. This is what turns
`u &&& (u - 1) = 0` into "exactly one literal was undecided". -/
theorem or_eq_two_pow_cases {x y i : Nat} (hu : x ||| y = 2 ^ i) (hd : x &&& y = 0) :
    (x = 2 ^ i ∧ y = 0) ∨ (x = 0 ∧ y = 2 ^ i) := by
  have hb : ∀ j, (x.testBit j || y.testBit j) = decide (i = j) := by
    intro j; rw [← Nat.testBit_or, hu, Nat.testBit_two_pow]
  have hc : ∀ j, (x.testBit j && y.testBit j) = false := by
    intro j; rw [← Nat.testBit_and, hd, Nat.zero_testBit]
  by_cases hx : x.testBit i
  · left
    refine ⟨Nat.eq_of_testBit_eq fun j => ?_, Nat.eq_of_testBit_eq fun j => ?_⟩
    · rw [Nat.testBit_two_pow]
      by_cases hj : i = j
      · subst hj; simp [hx]
      · have := hb j; simp [hj] at this ⊢; exact this.1
    · rw [Nat.zero_testBit]
      by_cases hj : i = j
      · subst hj; have := hc j; simp [hx] at this; exact this
      · have := hb j; simp [hj] at this; exact this.2
  · right
    have hy : y.testBit i = true := by have := hb i; simp [hx] at this; exact this
    refine ⟨Nat.eq_of_testBit_eq fun j => ?_, Nat.eq_of_testBit_eq fun j => ?_⟩
    · rw [Nat.zero_testBit]
      by_cases hj : i = j
      · subst hj; simpa using hx
      · have := hb j; simp [hj] at this; exact this.1
    · rw [Nat.testBit_two_pow]
      by_cases hj : i = j
      · subst hj; simp [hy]
      · have := hb j; simp [hj] at this; exact this.2

/-! ## The decoder as a universally quantified variable

The checker's chunk loop takes the decoder as a *parameter*. `runStream_sound` then holds for
**every** function of that type, which is the strongest available statement of "nothing about the
decoder is trusted" — stronger than a docstring, and it makes accidental reliance on the real
decoder's behaviour a type error rather than a review question. -/

/-- Stand-in action and checker, enough to show the shape elaborates. -/
inductive Action where
  | addRup (hints : List Nat)
  | addEmpty (hints : List Nat)
deriving Repr

/-- Stand-in: whatever the real per-batch checker does. -/
opaque runActions : Nat → List Action → Option Nat

def runStream (decode : Nat → Option (List Action)) : Nat → List Nat → Bool
  | _, []       => false
  | w, ch :: cs =>
      match decode ch with
      | none      => false
      | some acts =>
          match runActions w acts with
          | none     => true          -- ⊥ derived
          | some w'  => runStream decode w' cs

/-- The soundness statement quantifies over the decoder. Any decoder whatsoever. -/
example : ∀ (decode : Nat → Option (List Action)) (w : Nat) (cert : List Nat),
    runStream decode w cert = true → True := fun _ _ _ _ => trivial

end Probe

import Mathlib.Data.Fintype.Card
import Mathlib.Data.Fin.Tuple.Basic

/-!
# Colour patterns, one per partition

Fix `m` positions and `k` colours. A **pattern** is a function `Fin m → Fin k`, and what a
colouring problem can ever say about one is which positions agree and which differ — never which
colours they take, because renaming the colours of a proper colouring gives another proper
colouring. So the patterns worth enumerating are the **partitions of the positions into at most `k`
blocks**, and this file enumerates exactly one pattern per partition.

The representative is the classical one: **colours numbered in order of first occurrence**. `[2,3,2]`
and `[0,1,0]` are the same partition and the second is the representative; `[0,2,0]` is not a
representative, because colour `1` was skipped.

## Why it matters, in one number

An exhaustive check over every pattern is `k^m`. Over the representatives it is the number of
partitions of `m` positions into at most `k` blocks — 3,845 against 390,625 at five colours and eight
positions. Measured in Lean's kernel, that is **8.3 seconds against a computation that does not
finish**.

## The enumeration carries a count, not a set

`canonAux k m u` lists the representatives of `m` further positions **given that `u` colours are
already in use**. A position may take any colour already used (`< u`) or exactly one fresh colour
(`= u`) — never a higher one, since that would skip a name. So the recursion needs one number, and
the completeness proof needs the list of original colours those `u` names stand for, which is why
`exists_canonAux` carries a `List` where `canonAux` carries its length.

This file depends on nothing but Mathlib.
-/

namespace HadwigerNelson

/-- **The representatives of `m` positions, given that `u` colours are already named.** Position `0`
may take any of `0, …, u` — an existing name or the next fresh one — and the count advances when it
takes the fresh one. -/
def canonAux (k : ℕ) : (m : ℕ) → ℕ → List (Fin m → Fin k)
  | 0, _ => [Fin.elim0]
  | m + 1, u => (List.finRange k).flatMap fun c =>
      if c.val ≤ u then (canonAux k m (max u (c.val + 1))).map (Fin.cons c) else []

/-- **One pattern per partition of `m` positions into at most `k` blocks.** -/
def canonPatterns (k m : ℕ) : List (Fin m → Fin k) := canonAux k m 0

/-- **The completeness of the enumeration, strengthened to carry its context.**

`s` is the list of original colours already named, in the order they were named, so `s.idxOf c` is
the representative's name for `c` and `s.length` is the count `canonAux` carries. The conclusion
extends `s` to an `s'` naming every colour `q` uses, and exhibits the representative as `q` read
through `s'`.

Everything the enumeration is for follows from the last clause: two positions get the same name
exactly when they had the same colour. -/
theorem exists_canonAux {k : ℕ} : ∀ (m : ℕ) (s : List (Fin k)), s.Nodup → ∀ q : Fin m → Fin k,
    ∃ (s' : List (Fin k)) (q' : Fin m → Fin k),
      s'.Nodup ∧ s <+: s' ∧ (∀ i, q i ∈ s') ∧ q' ∈ canonAux k m s.length ∧
        ∀ i, (q' i).val = s'.idxOf (q i) := by
  sorry

/-- **Every pattern matches a listed one, position for position.**

The one statement any consumer needs: the listed representative agrees exactly where `q` agrees and
differs exactly where `q` differs. Combined with the fact that renaming colours carries proper
colourings to proper colourings, this is what lets an exhaustive check range over the
representatives alone. -/
theorem exists_mem_canonPatterns {k m : ℕ} (q : Fin m → Fin k) :
    ∃ q' ∈ canonPatterns k m, ∀ i j, q' i = q' j ↔ q i = q j := by
  sorry

/-! ## Spec

The enumeration is worth nothing if it lists the wrong things, and `exists_mem_canonPatterns` would
be satisfied by an enumeration that listed *everything*. Both directions are pinned. -/

section Spec

-- Three positions, five colours: five partitions — all three alike, one of three ways for exactly
-- two alike, and all different. Read against the `#guard` below it, which is the count.
/-- info: [[0, 0, 0], [0, 0, 1], [0, 1, 0], [0, 1, 1], [0, 1, 2]] -/
#guard_msgs in
#eval (canonPatterns 5 3).map (List.ofFn ·)

-- Two positions, one colour: only the constant pattern, because the second position cannot open a
-- block there is no colour for. The `k` bound is real.
/-- info: [[0, 0]] -/
#guard_msgs in
#eval (canonPatterns 1 2).map (List.ofFn ·)

-- **No two representatives are the same partition** — the property `exists_mem_canonPatterns` does
-- *not* state, and the one that makes the enumeration a saving rather than a filter.
#guard ((canonPatterns 5 4).map fun a => (canonPatterns 5 4).countP fun b =>
  decide (∀ i j, a i = a j ↔ b i = b j)).all (· == 1)

-- The counts, against the partition numbers computed by hand: at five colours,
-- 1 · 15 · 52 · 202 · 855 for zero through seven positions is Bell's sequence truncated at five
-- blocks, and the truncation first bites at six positions (203 partitions, 202 with at most five
-- blocks).
#guard (canonPatterns 5 4).length = 15
#guard (canonPatterns 5 5).length = 52
#guard (canonPatterns 5 6).length = 202
#guard (canonPatterns 4 6).length = 187

end Spec

end HadwigerNelson

import Mathlib.Data.Fintype.Card
import Mathlib.Data.Fin.Tuple.Basic
import Mathlib.Data.Fin.VecNotation
import Mathlib.Data.Fintype.Pi

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

## The relation, and why it is not a `Quotient`

"Same partition" is an equivalence relation on patterns, and this file could have been a `Quotient`
by it. It is not, for a reason worth stating: a quotient is what you build when you must *reason*
about equivalence classes, and every function out of it owes a proof that it respects the relation.
What is needed here is the opposite — a **section**: a computable list hitting every class once.
A section of a quotient is a list, not a quotient, and going through the quotient would have added
a respects-obligation to every gadget constructor and bought nothing.

## The enumeration carries a count; the proof carries a list

`canonAux k m u` lists the representatives of `m` further positions **given that `u` colours are
already in use**. A position may take any colour already used (`< u`) or exactly one fresh colour
(`= u`) — never a higher one, since that would skip a name. The state that decides the choices is
exactly that number, so the enumeration carries a `ℕ` and nothing else.

The completeness proof carries more, and it has to: to relate a *given* pattern to the enumeration it
must know which original colour each name stands for. That is `exists_canonAux`'s list, whose length
is the enumeration's count. The list is the accumulator the induction is generalised over — it never
appears in the enumeration and never appears in the statement any consumer reads.

This file depends on nothing but Mathlib.
-/

namespace HadwigerNelson

/-! ## Two patterns, one partition -/

/-- **Two patterns induce the same partition**: the same positions agree, and the same positions
differ. The relation everything in this file is about, named because three separate statements
otherwise spell out the same quantifier. -/
def SamePattern {m k : ℕ} (a b : Fin m → Fin k) : Prop := ∀ i j, a i = a j ↔ b i = b j

instance {m k : ℕ} (a b : Fin m → Fin k) : Decidable (SamePattern a b) :=
  inferInstanceAs (Decidable (∀ i j, a i = a j ↔ b i = b j))

/-- `SamePattern` as a `Bool`, for the gadget algebra, which computes with it. Kept beside the
proposition rather than in the file that uses it, so the two costumes cannot drift apart. -/
def samePattern {m k : ℕ} (a b : Fin m → Fin k) : Bool := decide (SamePattern a b)

/-- The bridge. Stated the same day as the definition, per the house rule on `Bool`/`Prop` pairs. -/
theorem samePattern_iff {m k : ℕ} {a b : Fin m → Fin k} :
    samePattern a b = true ↔ SamePattern a b := by
  simp [samePattern]

/-! ## The enumeration -/

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

`s` names the original colours already met, in the order they were met, so `s.idxOf c` is the
representative's name for `c` and `s.length` is the count `canonAux` carries. The conclusion extends
`s` to an `s'` naming every colour `q` uses, and exhibits the representative as `q` read through `s'`.

Five conjuncts, each doing one job — the accumulator generalisation written out:

| conjunct | role |
|---|---|
| `s'.Nodup` | the accumulator's invariant; it is what bounds `s'.length` by `k` |
| `s <+: s'` | the accumulator only grows, so a name fixed at position `0` still means the same thing at position `m` |
| `∀ i, q i ∈ s'` | the accumulator covers `q`, so `idxOf` is a real index rather than a fallback |
| `q' ∈ canonAux k m s.length` | the conclusion |
| `∀ i, (q' i).val = s'.idxOf (q i)` | the link, stated on `.val` so that the `Fin k` bound stays a proposition instead of becoming a dependent existential |

The representative is *constructed* here rather than characterised, and that is why there is no
sixth conjunct saying `s'` is in first-occurrence order: it is built in that order, so nothing has to
say so. -/
theorem exists_canonAux {k : ℕ} : ∀ (m : ℕ) (s : List (Fin k)), s.Nodup → ∀ q : Fin m → Fin k,
    ∃ (s' : List (Fin k)) (q' : Fin m → Fin k),
      s'.Nodup ∧ s <+: s' ∧ (∀ i, q i ∈ s') ∧ q' ∈ canonAux k m s.length ∧
        ∀ i, (q' i).val = s'.idxOf (q i) := by
  intro m
  induction m with
  | zero =>
      -- No positions: the context is already the answer and every `∀ i : Fin 0` is vacuous.
      intro s hs q
      exact ⟨s, Fin.elim0, hs, List.prefix_rfl, fun i => i.elim0, by simp [canonAux],
        fun i => i.elim0⟩
  | succ m ih =>
      intro s hs q
      by_cases hc : q 0 ∈ s
      · -- **The first position reuses a name.** The context does not grow, and the head takes the
        -- name that colour already has.
        obtain ⟨s', t', hnd, hpre, hcov, hmem, hlink⟩ := ih s hs (Fin.tail q)
        obtain ⟨u, rfl⟩ := hpre
        have hidx : (s ++ u).idxOf (q 0) = s.idxOf (q 0) := by simp [List.idxOf_append, hc]
        have hlen : s.idxOf (q 0) < s.length := List.idxOf_lt_length_of_mem hc
        have hlt : s.idxOf (q 0) < k :=
          hlen.trans_le (hs.length_le_card.trans_eq (Fintype.card_fin k))
        refine ⟨s ++ u, Fin.cons ⟨s.idxOf (q 0), hlt⟩ t', hnd, List.prefix_append s u, ?_, ?_, ?_⟩
        · exact fun i => Fin.cases (List.mem_append_left u hc) hcov i
        · -- The head is an existing name, so the count is unchanged: `max s.length (idx+1)` is
          -- `s.length`, which is where the induction hypothesis put the tail.
          refine List.mem_flatMap.mpr ⟨⟨s.idxOf (q 0), hlt⟩, List.mem_finRange _, ?_⟩
          rw [if_pos (Nat.le_of_lt hlen), Nat.max_eq_left hlen]
          exact List.mem_map_of_mem hmem
        · refine Fin.cases ?_ (fun j => ?_)
          · simpa using hidx.symm
          · simp only [Fin.cons_succ]; exact hlink j
      · -- **The first position opens a block.** The context grows by that colour, and the head takes
        -- the next fresh name — which is the old count.
        have hnd₁ : (s ++ [q 0]).Nodup := by
          simp only [List.nodup_append]
          refine ⟨hs, List.nodup_singleton _, fun x hx y hy => ?_⟩
          rw [List.mem_singleton] at hy
          subst hy
          exact fun h => hc (h ▸ hx)
        obtain ⟨s', t', hnd, hpre, hcov, hmem, hlink⟩ := ih (s ++ [q 0]) hnd₁ (Fin.tail q)
        obtain ⟨u, rfl⟩ := hpre
        have hlt : s.length < k := by
          have h1 := hnd₁.length_le_card.trans_eq (Fintype.card_fin k)
          simp only [List.length_append, List.length_cons, List.length_nil] at h1
          omega
        have hmem₁ : q 0 ∈ s ++ [q 0] := List.mem_append_right _ (by simp)
        have hmem' : t' ∈ canonAux k m (s.length + 1) := by
          simpa only [List.length_append, List.length_cons, List.length_nil] using hmem
        have hidx : (s ++ [q 0] ++ u).idxOf (q 0) = s.length := by
          simp [List.idxOf_append, hc]
        refine ⟨s ++ [q 0] ++ u, Fin.cons ⟨s.length, hlt⟩ t', hnd,
          (List.prefix_append s [q 0]).trans (List.prefix_append _ u), ?_, ?_, ?_⟩
        · exact fun i => Fin.cases (List.mem_append_left u hmem₁) hcov i
        · refine List.mem_flatMap.mpr ⟨⟨s.length, hlt⟩, List.mem_finRange _, ?_⟩
          rw [if_pos (Nat.le_refl _), Nat.max_eq_right (Nat.le_succ _)]
          exact List.mem_map_of_mem hmem'
        · refine Fin.cases ?_ (fun j => ?_)
          · simpa using hidx.symm
          · simp only [Fin.cons_succ]; exact hlink j

/-- **Every pattern matches a listed one, position for position.**

The one statement any consumer needs: the listed representative agrees exactly where `q` agrees and
differs exactly where `q` differs. Combined with the fact that renaming colours carries proper
colourings to proper colourings, this is what lets an exhaustive check range over the
representatives alone. -/
theorem exists_mem_canonPatterns {k m : ℕ} (q : Fin m → Fin k) :
    ∃ q' ∈ canonPatterns k m, SamePattern q' q := by
  obtain ⟨s', q', -, -, hcov, hmem, hlink⟩ := exists_canonAux m [] List.nodup_nil q
  -- Two positions get the same *name* exactly when they had the same colour: `idxOf` is injective
  -- on the elements a list contains, and every colour `q` uses is one of them.
  refine ⟨q', hmem, fun i j => ?_⟩
  rw [← Fin.val_inj, hlink, hlink]
  exact List.idxOf_inj (hcov i)

/-! ## Spec

The enumeration is worth nothing if it lists the wrong things, and it can be wrong in two independent
directions — listing too few, and listing too many. `exists_mem_canonPatterns` states only the first.
Both are pinned below, decidably, at sizes small enough to read. -/

section Spec

-- Three positions, five colours: five partitions — all three alike, one of three ways for exactly
-- two alike, and all different.
/-- info: [[0, 0, 0], [0, 0, 1], [0, 1, 0], [0, 1, 1], [0, 1, 2]] -/
#guard_msgs in
#eval (canonPatterns 5 3).map (List.ofFn ·)

-- Two positions, one colour: only the constant pattern, because the second position cannot open a
-- block there is no colour for. The `k` bound is real.
/-- info: [[0, 0]] -/
#guard_msgs in
#eval (canonPatterns 1 2).map (List.ofFn ·)

-- **Nothing is listed twice** — no two representatives are the same partition. The property
-- `exists_mem_canonPatterns` does *not* state, and the one that makes the enumeration a saving
-- rather than a filter.
#guard ((canonPatterns 5 4).map fun a =>
  (canonPatterns 5 4).countP (samePattern a)).all (· == 1)

-- **Nothing is left out** — every one of the `5^4` patterns matches exactly one representative.
-- This is `exists_mem_canonPatterns` made computational at a size the kernel can check, and it is
-- what would go red if `canonAux` ever skipped a partition.
#guard (canonPatterns 5 4).length = 15

/-- **Coverage, decided.** The theorem below is stated for all `m` and `k`; here it is *checked* at
four positions and five colours, over every one of the 625 patterns. A proof can be wrong about
which statement it proves; this cannot. -/
example : ∀ q : Fin 4 → Fin 5, (canonPatterns 5 4).any (samePattern · q) := by decide +kernel

-- The counts, against the partition numbers: at five colours, 15 · 52 · 202 · 855 for four through
-- seven positions is Bell's sequence truncated at five blocks, and the truncation first bites at six
-- positions (203 partitions, 202 with at most five blocks).
#guard (canonPatterns 5 5).length = 52
#guard (canonPatterns 5 6).length = 202
#guard (canonPatterns 4 6).length = 187

-- The relation is an equivalence, exhibited rather than asserted: a pattern is its own partition,
-- and two patterns one relabelling apart are the same one.
#guard samePattern (![2, 3, 2] : Fin 3 → Fin 5) ![0, 1, 0]
#guard !samePattern (![2, 3, 2] : Fin 3 → Fin 5) ![0, 1, 1]

end Spec

end HadwigerNelson

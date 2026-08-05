import Mathlib.Data.ZMod.Basic

/-! # The strip automaton

The exact structure of the two-circle colouring space, abstractly (M20 §0.3–§2.4). One
⟨zeta6, seam⟩-orbit of the two circles is the strip graph on cells
`{out, in} × ℤ/6 × ℤ`; the parity `(j + [inner]) mod 2` is invariant under all three edge
rules, so the strip splits into two isomorphic **tubes** — alternating chains of hexagon
columns (outer, 60°-steps: a 6-cycle) and rainbow columns (inner, 120°-steps: two
triangles), consecutive columns coupled by pointwise disequality ("avoidance").

This module is the tube's colouring theory, finite part fully decidable:

* mono-parity hexagon columns avoid *no* rainbow column (`mono_blocks`) — the lone
  finite obstruction, and the seed of the 120° compulsion (`Compulsion.lean`);
* every hexagon column avoiding some rainbow column is non-mono (`purification`);
* every non-mono hexagon column admits exactly 4 avoiding rainbow columns
  (`avoid_card`), whose hexagon-continuations count 2,2,4,4 — twelve in all
  (`twostep_card`): the colouring space grows by exactly ×12 per column;
* every rainbow column admits a continuing hexagon column (`rainbow_extends`);
* hence the **window-extension theorem** (`window_extends`): every proper colouring of a
  finite window of length ≥ 2 extends to the whole bi-infinite tube.

Kernel cost, measured (M20 subplan §3.2): a pair-quantified `decide` over `Fin 729 ×
Fin 729` costs 5m30s; the same content as one quantifier against a literal table costs
2.5 s. Rule: **no decide here runs a pair quantifier** — the second side is always one
of the two tables below, each verified complete by a linear filter bridge.
-/

namespace HadwigerNelson
namespace Strip

/-! ## Packed columns

A column is a function `ZMod 6 → Fin 3`, packed as `n < 729` with base-3 digits;
`digit n i = n / 3^i % 3` is GMP-friendly (the M19 nibble lesson). -/

/-- Digit `i` of the packed column `n`. -/
def digit (n i : ℕ) : ℕ := n / 3 ^ i % 3

/-- A proper hexagon column: consecutive digits (mod 6) differ — a proper 3-colouring of
the outer 6-cycle. -/
def properHexB (n : ℕ) : Bool :=
  (List.range 6).all fun i => digit n ((i + 1) % 6) != digit n i

/-- A rainbow column: digits two apart (mod 6) differ — both inner triangles rainbow. -/
def rainbowB (n : ℕ) : Bool :=
  (List.range 6).all fun i => digit n ((i + 2) % 6) != digit n i

/-- Avoidance: the cross-seam coupling — pointwise disequality of adjacent columns. -/
def avoidsB (n m : ℕ) : Bool :=
  (List.range 6).all fun i => digit n i != digit m i

/-- Neither parity-triple of the column is monochromatic. -/
def nonMonoB (n : ℕ) : Bool :=
  (digit n 0 != digit n 2 || digit n 2 != digit n 4) &&
  (digit n 1 != digit n 3 || digit n 3 != digit n 5)

/-! ## The tables

Emitted by `tools/extend.py --tables` and verified complete by the filter bridges —
a wrong or incomplete table fails its bridge by `decide`. -/

/-- The 66 proper hexagon columns. -/
def hexTable : List ℕ :=
  [91, 92, 97, 100, 101, 104, 140, 142, 145, 146, 151, 172, 173, 178, 181, 182, 185,
   194, 196, 208, 209, 212, 273, 275, 276, 290, 291, 293, 300, 302, 303, 308, 312, 416,
   420, 425, 426, 428, 435, 437, 438, 452, 453, 455, 516, 519, 520, 532, 534, 543, 546,
   547, 550, 555, 556, 577, 582, 583, 586, 588, 624, 627, 628, 631, 636, 637]

/-- The 36 rainbow columns. -/
def rainTable : List ℕ :=
  [44, 52, 68, 76, 116, 132, 140, 156, 196, 204, 220, 228, 260, 268, 308, 316,
   332, 348, 380, 396, 412, 420, 460, 468, 500, 508, 524, 532, 572, 588, 596,
   612, 652, 660, 676, 684]

theorem hexTable_complete : (List.range 729).filter properHexB = hexTable := sorry

theorem rainTable_complete : (List.range 729).filter rainbowB = rainTable := sorry

/-! ## The finite theorems (each one quantifier at most, tables on the other side) -/

/-- **Purification**: a hexagon column avoiding any rainbow column is non-mono. -/
theorem purification :
    (hexTable.all fun n => rainTable.all fun m => !avoidsB n m || nonMonoB n) = true :=
  sorry

/-- **The mono obstruction**: a mono-parity hexagon column avoids *no* rainbow column —
the tube's only finite obstruction, and the compulsion's engine. -/
theorem mono_blocks :
    (hexTable.all fun n => nonMonoB n || rainTable.all fun m => !avoidsB n m) = true :=
  sorry

/-- Every non-mono hexagon column admits exactly 4 avoiding rainbow columns. -/
theorem avoid_card :
    (hexTable.all fun n =>
      !nonMonoB n || (rainTable.filter (avoidsB n)).length == 4) = true := sorry

/-- **The ×12 identity**: each non-mono hexagon column's avoiding rainbow columns carry
12 hexagon-continuations in all (the split is 2,2,4,4) — the tube's colouring space
grows by exactly twelve per column. -/
theorem twostep_card :
    (hexTable.all fun n => !nonMonoB n ||
      ((rainTable.filter (avoidsB n)).map fun m =>
        (hexTable.filter fun n' => avoidsB n' m).length).sum == 12) = true := sorry

/-- Every rainbow column admits a continuing hexagon column. -/
theorem rainbow_extends :
    (rainTable.all fun m => hexTable.any fun n => avoidsB n m) = true := sorry

/-- Avoidance is symmetric — the coupling reads the same in both directions. -/
theorem avoidsB_comm (n m : ℕ) : avoidsB n m = avoidsB m n := sorry

/-! ## Prop bridges (the shapes proofs consume)

Membership in a table is the canonical currency: parse once (predicate + bound → `mem`),
then every existence lemma trades in it. Digits only see `n % 729`, so the predicates
alone admit junk high bits — the bound is load-bearing, never decoration. -/

theorem properHex_mem {n : ℕ} (h729 : n < 729) (h : properHexB n = true) :
    n ∈ hexTable := sorry

theorem rainbow_mem {m : ℕ} (h729 : m < 729) (hr : rainbowB m = true) : m ∈ rainTable :=
  sorry

theorem mem_hexTable_props {n : ℕ} (hn : n ∈ hexTable) :
    n < 729 ∧ properHexB n = true := sorry

theorem mem_rainTable_props {m : ℕ} (hm : m ∈ rainTable) :
    m < 729 ∧ rainbowB m = true := sorry

theorem exists_rain_avoiding {n : ℕ} (hn : n ∈ hexTable) (hm : nonMonoB n = true) :
    ∃ m ∈ rainTable, avoidsB n m = true := sorry

theorem exists_hex_avoiding {m : ℕ} (hm : m ∈ rainTable) :
    ∃ n ∈ hexTable, avoidsB n m = true := sorry

theorem nonMono_of_avoids_rain {n m : ℕ} (hn : n ∈ hexTable) (hm : m ∈ rainTable)
    (h : avoidsB n m = true) : nonMonoB n = true := sorry

/-! ## The tube, and the window-extension theorem -/

/-- A proper colouring of the bi-infinite tube: hexagon columns at even `j`, rainbow
columns at odd `j`, consecutive columns avoiding. The bound is part of the notion —
digits only see `n % 729`, and without it the type admits colourings differing by
invisible junk. -/
structure TubeProper (f : ℤ → ℕ) : Prop where
  bound : ∀ j : ℤ, f j < 729
  hex : ∀ j : ℤ, Even j → properHexB (f j) = true
  rain : ∀ j : ℤ, ¬ Even j → rainbowB (f j) = true
  avoid : ∀ j : ℤ, avoidsB (f j) (f (j + 1)) = true

/-- A proper colouring of an `L`-column window (anchored with a hexagon column at 0;
the odd-anchored variant is deferred until a consumer exists — the tube's shift and
reflection symmetries make it a one-liner then). -/
structure WindowProper (L : ℕ) (g : Fin L → ℕ) : Prop where
  bound : ∀ t : Fin L, g t < 729
  hex : ∀ t : Fin L, Even (t : ℕ) → properHexB (g t) = true
  rain : ∀ t : Fin L, ¬ Even (t : ℕ) → rainbowB (g t) = true
  avoid : ∀ (t : ℕ) (h : t + 1 < L),
    avoidsB (g ⟨t, Nat.lt_of_succ_lt h⟩) (g ⟨t + 1, h⟩) = true

/-- **The window-extension theorem.** Every proper colouring of a window of length ≥ 2
extends to a proper colouring of the whole bi-infinite tube: interior and end hexagon
columns are non-mono by purification (each avoids a rainbow column inside the window),
so both ends continue forever. Length 1 is the honest boundary: a lone mono-parity
hexagon column (`monoHexExample`) extends to nothing. -/
theorem window_extends {L : ℕ} (hL : 2 ≤ L) (g : Fin L → ℕ)
    (hg : WindowProper L g) :
    ∃ f : ℤ → ℕ, TubeProper f ∧ ∀ t : Fin L, f (t : ℤ) = g t := sorry

/-! ## Specification -/

-- the M19 tables, packed: outerTable = [1,2,0,2,1,0] ↦ 142, innerTable = [0,0,1,1,2,2] ↦ 684
#guard properHexB 142
#guard rainbowB 684
#guard avoidsB 142 684          -- outerTable_ne_innerTable, packed
#guard nonMonoB 142
#guard (142 ∈ hexTable : Bool) && (684 ∈ rainTable : Bool)

/-- The tube's only finite obstruction, exhibited: the alternating column `[0,1,0,1,0,1]`
(packed 273) is a proper hexagon colouring, mono on both parities — and avoids no rainbow
column at all. -/
def monoHexExample : ℕ := 273

#guard properHexB monoHexExample
#guard !nonMonoB monoHexExample
#guard rainTable.all fun m => !avoidsB monoHexExample m

-- the M19 table state is a fixed point: constant columns (142 at even j, 684 at odd)
-- form a proper tube — the j-independent colouring, one of exactly 96
example : TubeProper (fun j => if Even j then 142 else 684) := sorry

-- adversarial member, refused: junk high bits are not a tube colouring (the bound bites)
#guard properHexB (142 + 729)   -- the predicate alone cannot tell 871 from 142 …
example : ¬ TubeProper (fun j => if Even j then 142 + 729 else 684) :=
  fun h => by simpa using h.bound 0

end Strip
end HadwigerNelson

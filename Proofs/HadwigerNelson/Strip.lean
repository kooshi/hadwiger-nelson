import Mathlib.Data.ZMod.Basic
import Mathlib.Data.Fin.VecNotation

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

set_option maxHeartbeats 4000000

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

theorem hexTable_complete : (List.range 729).filter properHexB = hexTable := by
  decide +kernel

theorem rainTable_complete : (List.range 729).filter rainbowB = rainTable := by
  decide +kernel

/-! ## The finite theorems (each one quantifier at most, tables on the other side) -/

private theorem purification_all :
    (hexTable.all fun n => rainTable.all fun m => !avoidsB n m || nonMonoB n) = true :=
  by decide +kernel

private theorem mono_blocks_all :
    (hexTable.all fun n => nonMonoB n || rainTable.all fun m => !avoidsB n m) = true :=
  by decide +kernel

private theorem avoid_card_all :
    (hexTable.all fun n =>
      !nonMonoB n || (rainTable.filter (avoidsB n)).length == 4) = true := by
  decide +kernel

private theorem twostep_card_all :
    (hexTable.all fun n => !nonMonoB n ||
      ((rainTable.filter (avoidsB n)).map fun m =>
        (hexTable.filter fun n' => avoidsB n' m).length).sum == 12) = true := by
  decide +kernel

private theorem rainbow_extends_all :
    (rainTable.all fun m => hexTable.any fun n => avoidsB n m) = true := by
  decide +kernel

/-- Avoidance is symmetric — the coupling reads the same in both directions. This is
what makes the leftward tube extension the rightward one read backward. -/
theorem avoidsB_comm (n m : ℕ) : avoidsB n m = avoidsB m n := by
  simp only [avoidsB]
  congr 1
  funext i
  exact bne_comm

/-! ## Prop bridges (the shapes proofs consume)

Membership in a table is the canonical currency: parse once (predicate + bound → `mem`),
then every existence lemma trades in it. Digits only see `n % 729`, so the predicates
alone admit junk high bits — the bound is load-bearing, never decoration. -/

theorem mem_hexTable_of_properHex {n : ℕ} (h729 : n < 729) (h : properHexB n = true) :
    n ∈ hexTable := by
  rw [← hexTable_complete]
  exact List.mem_filter.mpr ⟨List.mem_range.mpr h729, h⟩

theorem mem_rainTable_of_rainbow {m : ℕ} (h729 : m < 729) (hr : rainbowB m = true) :
    m ∈ rainTable := by
  rw [← rainTable_complete]
  exact List.mem_filter.mpr ⟨List.mem_range.mpr h729, hr⟩

theorem mem_hexTable_lt {n : ℕ} (hn : n ∈ hexTable) : n < 729 := by
  rw [← hexTable_complete] at hn
  exact List.mem_range.mp (List.mem_filter.mp hn).1

theorem mem_hexTable_properHex {n : ℕ} (hn : n ∈ hexTable) : properHexB n = true := by
  rw [← hexTable_complete] at hn
  exact (List.mem_filter.mp hn).2

theorem mem_rainTable_lt {m : ℕ} (hm : m ∈ rainTable) : m < 729 := by
  rw [← rainTable_complete] at hm
  exact List.mem_range.mp (List.mem_filter.mp hm).1

theorem mem_rainTable_rainbow {m : ℕ} (hm : m ∈ rainTable) : rainbowB m = true := by
  rw [← rainTable_complete] at hm
  exact (List.mem_filter.mp hm).2

/-- **Purification**, consumer form: a hexagon column avoiding any rainbow column is
automatically non-mono — rainbow neighbours purify. -/
theorem nonMonoB_of_avoids_rain {n m : ℕ} (hn : n ∈ hexTable) (hm : m ∈ rainTable)
    (h : avoidsB n m = true) : nonMonoB n = true := by
  have h1 := List.all_eq_true.mp purification_all n hn
  have h2 := List.all_eq_true.mp h1 m hm
  rcases Bool.or_eq_true_iff.mp h2 with h3 | h3
  · rw [h] at h3; exact absurd h3 (by decide)
  · exact h3

/-- **The mono obstruction**, consumer form: a mono-parity hexagon column avoids *no*
rainbow column — the tube's only finite obstruction, and the compulsion's engine. -/
theorem mono_avoids_no_rainbow {n : ℕ} (hn : n ∈ hexTable) (hnm : nonMonoB n = false)
    {m : ℕ} (hm : m ∈ rainTable) : avoidsB n m = false := by
  have h1 := List.all_eq_true.mp mono_blocks_all n hn
  rcases Bool.or_eq_true_iff.mp h1 with h3 | h3
  · rw [hnm] at h3; exact absurd h3 (by decide)
  · have h4 := List.all_eq_true.mp h3 m hm
    simpa using h4

/-- Every non-mono hexagon column admits exactly 4 avoiding rainbow columns. -/
theorem avoid_card {n : ℕ} (hn : n ∈ hexTable) (hnm : nonMonoB n = true) :
    (rainTable.filter (avoidsB n)).length = 4 := by
  have h1 := List.all_eq_true.mp avoid_card_all n hn
  rcases Bool.or_eq_true_iff.mp h1 with h3 | h3
  · rw [hnm] at h3; exact absurd h3 (by decide)
  · exact eq_of_beq h3

/-- **The ×12 identity**: each non-mono hexagon column's avoiding rainbow columns carry
12 hexagon-continuations in all (the split is 2,2,4,4) — the tube's colouring space
grows by exactly twelve per column. -/
theorem twostep_card {n : ℕ} (hn : n ∈ hexTable) (hnm : nonMonoB n = true) :
    ((rainTable.filter (avoidsB n)).map fun m =>
      (hexTable.filter fun n' => avoidsB n' m).length).sum = 12 := by
  have h1 := List.all_eq_true.mp twostep_card_all n hn
  rcases Bool.or_eq_true_iff.mp h1 with h3 | h3
  · rw [hnm] at h3; exact absurd h3 (by decide)
  · exact eq_of_beq h3

theorem exists_rain_avoiding {n : ℕ} (hn : n ∈ hexTable) (hm : nonMonoB n = true) :
    ∃ m ∈ rainTable, avoidsB n m = true := by
  have h4 := avoid_card hn hm
  have hpos : (rainTable.filter (avoidsB n)) ≠ [] := by
    intro h; rw [h] at h4; simp at h4
  obtain ⟨m, hm'⟩ := List.exists_mem_of_ne_nil _ hpos
  exact ⟨m, (List.mem_filter.mp hm').1, (List.mem_filter.mp hm').2⟩

theorem exists_hex_avoiding {m : ℕ} (hm : m ∈ rainTable) :
    ∃ n ∈ hexTable, avoidsB n m = true := by
  have h1 := List.all_eq_true.mp rainbow_extends_all m hm
  obtain ⟨n, hn, ha⟩ := List.any_eq_true.mp h1
  exact ⟨n, hn, ha⟩

/-! ## The extension machinery (computable) -/

/-- The rainbow column continuing a (non-mono) hexagon column — `List.find?` over the
table, with an arbitrary table member as junk for the mono case the specs exclude. -/
def stepHexToRain (n : ℕ) : ℕ := (rainTable.find? (avoidsB n)).getD 684

/-- The hexagon column continuing a rainbow column. -/
def stepRainToHex (m : ℕ) : ℕ := (hexTable.find? (avoidsB m)).getD 142

theorem stepHexToRain_spec {n : ℕ} (hn : n ∈ hexTable) (hnm : nonMonoB n = true) :
    stepHexToRain n ∈ rainTable ∧ avoidsB n (stepHexToRain n) = true := by
  obtain ⟨m, hm, ha⟩ := exists_rain_avoiding hn hnm
  have hs : (rainTable.find? (avoidsB n)).isSome :=
    List.find?_isSome.mpr ⟨m, hm, ha⟩
  obtain ⟨r, hr⟩ := Option.isSome_iff_exists.mp hs
  rw [stepHexToRain, hr, Option.getD_some]
  exact ⟨List.mem_of_find?_eq_some hr, List.find?_some hr⟩

theorem stepRainToHex_spec {m : ℕ} (hm : m ∈ rainTable) :
    stepRainToHex m ∈ hexTable ∧ avoidsB m (stepRainToHex m) = true := by
  obtain ⟨n, hn, ha⟩ := exists_hex_avoiding hm
  have ha' : avoidsB m n = true := by rw [avoidsB_comm]; exact ha
  have hs : (hexTable.find? (avoidsB m)).isSome :=
    List.find?_isSome.mpr ⟨n, hn, ha'⟩
  obtain ⟨r, hr⟩ := Option.isSome_iff_exists.mp hs
  rw [stepRainToHex, hr, Option.getD_some]
  exact ⟨List.mem_of_find?_eq_some hr, List.find?_some hr⟩

/-- The alternating invariant: what a column must be to keep extending forever —
hexagon columns must be non-mono (the mono obstruction), rainbow columns need only
be rainbow. The window theorem is exactly "this invariant is self-sustaining". -/
def ColState (isHex : Bool) (c : ℕ) : Prop :=
  cond isHex (c ∈ hexTable ∧ nonMonoB c = true) (c ∈ rainTable)

/-- One tube step of the type the parity demands. -/
def tubeNext (isHex : Bool) (c : ℕ) : ℕ :=
  cond isHex (stepHexToRain c) (stepRainToHex c)

/-- The step lemma: the invariant survives its own step — purification closes the
hexagon case's loop. -/
theorem tubeNext_spec {b : Bool} {c : ℕ} (h : ColState b c) :
    ColState (!b) (tubeNext b c) ∧ avoidsB c (tubeNext b c) = true := by
  cases b with
  | true =>
    obtain ⟨hmem, hnm⟩ := h
    exact stepHexToRain_spec hmem hnm
  | false =>
    obtain ⟨hh, ha⟩ := stepRainToHex_spec h
    have hnm : nonMonoB (stepRainToHex c) = true := by
      apply nonMonoB_of_avoids_rain hh h
      rw [avoidsB_comm]; exact ha
    exact ⟨⟨hh, hnm⟩, ha⟩

/-- The tower: `k` tube steps from column `c` of type `b`. One recursion serves both
directions of the extension — leftward is rightward read backward (`avoidsB_comm`). -/
def towerR (c : ℕ) (b : Bool) : ℕ → ℕ
  | 0 => c
  | k + 1 => towerR (tubeNext b c) (!b) k

/-- The column type the tower wears at step `k`. -/
def parityAt (b : Bool) (k : ℕ) : Bool := cond (k % 2 == 0) b (!b)

private theorem parityAt_succ (b : Bool) (k : ℕ) :
    parityAt b (k + 1) = parityAt (!b) k := by
  simp only [parityAt]
  rcases Nat.mod_two_eq_zero_or_one k with hk | hk <;>
    simp [hk, Nat.add_mod, Bool.not_not]

/-- The ray invariant: every tower column wears the invariant of its parity. -/
theorem towerR_state : ∀ (k c : ℕ) (b : Bool), ColState b c →
    ColState (parityAt b k) (towerR c b k)
  | 0, _, _, h => h
  | k + 1, c, b, h => by
    rw [parityAt_succ]
    exact towerR_state k (tubeNext b c) (!b) (tubeNext_spec h).1

/-- Consecutive tower columns avoid. -/
theorem towerR_avoids : ∀ (k c : ℕ) (b : Bool), ColState b c →
    avoidsB (towerR c b k) (towerR c b (k + 1)) = true
  | 0, c, b, h => by simpa [towerR] using (tubeNext_spec h).2
  | k + 1, c, b, h => by
    simpa [towerR] using towerR_avoids k (tubeNext b c) (!b) (tubeNext_spec h).1

/-! ## The tube, and the window-extension theorem -/

/-- A proper colouring of the bi-infinite tube: hexagon columns at even `j`, rainbow
columns at odd `j`, consecutive columns avoiding. The bound is part of the notion —
digits only see `n % 729`, and without it the type admits colourings differing by
invisible junk. -/
structure TubeProper (f : ℤ → ℕ) : Prop where
  /-- Every column is a genuine packed column — digits only see `n % 729`. -/
  bound : ∀ j : ℤ, f j < 729
  /-- Even positions carry proper hexagon columns. -/
  hex : ∀ j : ℤ, Even j → properHexB (f j) = true
  /-- Odd positions carry rainbow columns. -/
  rain : ∀ j : ℤ, ¬ Even j → rainbowB (f j) = true
  /-- Consecutive columns avoid pointwise — the cross-seam coupling. -/
  avoid : ∀ j : ℤ, avoidsB (f j) (f (j + 1)) = true

/-- A proper colouring of an `L`-column window (anchored with a hexagon column at 0;
the odd-anchored variant is deferred until a consumer exists — the tube's shift and
reflection symmetries make it a one-liner then). -/
structure WindowProper (L : ℕ) (g : Fin L → ℕ) : Prop where
  /-- Every column is a genuine packed column. -/
  bound : ∀ t : Fin L, g t < 729
  /-- Even window positions carry proper hexagon columns. -/
  hex : ∀ t : Fin L, Even (t : ℕ) → properHexB (g t) = true
  /-- Odd window positions carry rainbow columns. -/
  rain : ∀ t : Fin L, ¬ Even (t : ℕ) → rainbowB (g t) = true
  /-- Consecutive window columns avoid pointwise. -/
  avoid : ∀ (t : ℕ) (h : t + 1 < L),
    avoidsB (g ⟨t, Nat.lt_of_succ_lt h⟩) (g ⟨t + 1, h⟩) = true

/-- Reading `ColState` back out, per parity. -/
private theorem ColState.lt {b : Bool} {c : ℕ} (h : ColState b c) : c < 729 := by
  cases b with
  | true => exact mem_hexTable_lt h.1
  | false => exact mem_rainTable_lt h

private theorem ColState.properHexB {c : ℕ} (h : ColState true c) :
    Strip.properHexB c = true := mem_hexTable_properHex h.1

private theorem ColState.rainbowB {c : ℕ} (h : ColState false c) :
    Strip.rainbowB c = true := mem_rainTable_rainbow h

private theorem parityAt_of_even {b : Bool} {k : ℕ} (h : k % 2 = 0) :
    parityAt b k = b := by simp [parityAt, h]

private theorem parityAt_of_odd {b : Bool} {k : ℕ} (h : k % 2 = 1) :
    parityAt b k = !b := by simp [parityAt, h]

/-- The extension itself, computable: the window in the middle, towers on both rays.
Each tower *starts at* a window end column (`towerR _ _ 0` is its start), so the three
regions agree on their overlaps and no seam case exists in the proofs. -/
def extendWindow (L : ℕ) (hL : 2 ≤ L) (g : Fin L → ℕ) : ℤ → ℕ := fun j =>
  if j < 0 then towerR (g ⟨0, by omega⟩) true (-j).toNat
  else if h : j < (L : ℤ) then g ⟨j.toNat, by omega⟩
  else towerR (g ⟨L - 1, by omega⟩) ((L - 1) % 2 == 0) (j - (L : ℤ) + 1).toNat

private theorem extendWindow_left {L : ℕ} {hL : 2 ≤ L} {g : Fin L → ℕ} {j : ℤ}
    (hj : j ≤ 0) :
    extendWindow L hL g j = towerR (g ⟨0, by omega⟩) true (-j).toNat := by
  have hL' : (2 : ℤ) ≤ (L : ℤ) := by exact_mod_cast hL
  unfold extendWindow
  rcases (by omega : j < 0 ∨ j = 0) with h | h
  · rw [if_pos h]
  · subst h
    rw [if_neg (by omega), dif_pos (by omega)]
    rfl

private theorem extendWindow_mid' {L : ℕ} {hL : 2 ≤ L} {g : Fin L → ℕ} {j : ℤ}
    (h0 : 0 ≤ j) (hjL : j < (L : ℤ)) :
    extendWindow L hL g j = g ⟨j.toNat, by omega⟩ := by
  unfold extendWindow
  rw [if_neg (by omega), dif_pos hjL]

private theorem extendWindow_mid {L : ℕ} {hL : 2 ≤ L} {g : Fin L → ℕ} (t : Fin L) :
    extendWindow L hL g (t : ℤ) = g t :=
  extendWindow_mid' (by omega) (by exact_mod_cast t.isLt)

private theorem extendWindow_right {L : ℕ} {hL : 2 ≤ L} {g : Fin L → ℕ} {j : ℤ}
    (hj : (L : ℤ) - 1 ≤ j) :
    extendWindow L hL g j
      = towerR (g ⟨L - 1, by omega⟩) ((L - 1) % 2 == 0) (j - (L : ℤ) + 1).toNat := by
  have hL' : (2 : ℤ) ≤ (L : ℤ) := by exact_mod_cast hL
  unfold extendWindow
  rw [if_neg (by omega)]
  rcases (by omega : j = (L : ℤ) - 1 ∨ (L : ℤ) ≤ j) with h | h
  · rw [dif_pos (by omega)]
    have hk : (j - (L : ℤ) + 1).toNat = 0 := by omega
    rw [hk]
    show g _ = g _
    congr 1
    exact Fin.ext (show j.toNat = L - 1 by omega)
  · rw [dif_neg (by omega)]

/-- The window's first column carries the invariant: it is a proper hexagon column and
its rainbow neighbour at position 1 purifies it. -/
private theorem window_start {L : ℕ} (hL : 2 ≤ L) {g : Fin L → ℕ}
    (hg : WindowProper L g) : ColState true (g ⟨0, by omega⟩) := by
  have h01 : (0 : ℕ) + 1 < L := by omega
  have hmem : g ⟨0, by omega⟩ ∈ hexTable :=
    mem_hexTable_of_properHex (hg.bound _) (hg.hex ⟨0, by omega⟩ (by simp))
  have hrmem : g ⟨1, by omega⟩ ∈ rainTable :=
    mem_rainTable_of_rainbow (hg.bound _) (hg.rain ⟨1, by omega⟩ (by simp))
  exact ⟨hmem, nonMonoB_of_avoids_rain hmem hrmem (hg.avoid 0 h01)⟩

/-- The window's last column carries the invariant of its parity — its inside
neighbour purifies it when it is a hexagon column. -/
private theorem window_end {L : ℕ} (hL : 2 ≤ L) {g : Fin L → ℕ}
    (hg : WindowProper L g) :
    ColState ((L - 1) % 2 == 0) (g ⟨L - 1, by omega⟩) := by
  rcases Nat.mod_two_eq_zero_or_one (L - 1) with hp | hp
  · have hmem : g ⟨L - 1, by omega⟩ ∈ hexTable :=
      mem_hexTable_of_properHex (hg.bound _)
        (hg.hex ⟨L - 1, by omega⟩ (Nat.even_iff.mpr hp))
    have hrmem : g ⟨L - 2, by omega⟩ ∈ rainTable :=
      mem_rainTable_of_rainbow (hg.bound _)
        (hg.rain ⟨L - 2, by omega⟩ (show ¬ Even (L - 2) by rw [Nat.even_iff]; omega))
    have hav := hg.avoid (L - 2) (by omega)
    have hidx : (⟨L - 2 + 1, by omega⟩ : Fin L) = ⟨L - 1, by omega⟩ :=
      Fin.ext (show L - 2 + 1 = L - 1 by omega)
    rw [hidx] at hav
    have hnm : nonMonoB (g ⟨L - 1, by omega⟩) = true := by
      apply nonMonoB_of_avoids_rain hmem hrmem
      rw [avoidsB_comm]; exact hav
    simp only [ColState, hp]
    exact ⟨hmem, hnm⟩
  · simp only [ColState, hp]
    exact mem_rainTable_of_rainbow (hg.bound _)
      (hg.rain ⟨L - 1, by omega⟩ (show ¬ Even (L - 1) by rw [Nat.even_iff]; omega))

/-- **The window-extension theorem.** Every proper colouring of a window of length ≥ 2
extends to a proper colouring of the whole bi-infinite tube: interior and end hexagon
columns are non-mono by purification (each avoids a rainbow column inside the window),
so both ends continue forever. Length 1 is the honest boundary: a lone mono-parity
hexagon column (`monoHexExample`) extends to nothing. -/
theorem window_extends {L : ℕ} (hL : 2 ≤ L) (g : Fin L → ℕ)
    (hg : WindowProper L g) :
    ∃ f : ℤ → ℕ, TubeProper f ∧ ∀ t : Fin L, f (t : ℤ) = g t := by
  have hL' : (2 : ℤ) ≤ (L : ℤ) := by exact_mod_cast hL
  have hs := window_start hL hg
  have he := window_end hL hg
  -- the per-column invariant, all three zones
  have state : ∀ j : ℤ, ColState (if Even j then true else false)
      (extendWindow L hL g j) := by
    intro j
    rcases (by omega : j ≤ 0 ∨ 0 < j) with hj | hj
    · rw [extendWindow_left hj]
      have hk : ((-j).toNat : ℤ) = -j := Int.toNat_of_nonneg (by omega)
      have hst := towerR_state (-j).toNat _ true hs
      rcases Nat.mod_two_eq_zero_or_one (-j).toNat with hpar | hpar
      · have hpa : parityAt true (-j).toNat = true := by simp [parityAt, hpar]
        rw [hpa] at hst
        rw [if_pos (by rw [Int.even_iff]; omega : Even j)]
        exact hst
      · have hpa : parityAt true (-j).toNat = false := by simp [parityAt, hpar]
        rw [hpa] at hst
        rw [if_neg (by rw [Int.even_iff]; omega : ¬ Even j)]
        exact hst
    · rcases (by omega : j < (L : ℤ) ∨ (L : ℤ) ≤ j) with hjL | hjL
      · rw [extendWindow_mid' (by omega) hjL]
        set t : Fin L := ⟨j.toNat, by omega⟩ with hts
        have htv : (t : ℕ) = j.toNat := rfl
        rcases Nat.mod_two_eq_zero_or_one j.toNat with hpar | hpar
        · have hevt : Even (t : ℕ) := Nat.even_iff.mpr hpar
          have hmem : g t ∈ hexTable :=
            mem_hexTable_of_properHex (hg.bound t) (hg.hex t hevt)
          rw [if_pos (by rw [Int.even_iff]; omega : Even j)]
          refine ⟨hmem, ?_⟩
          -- non-mono: a rainbow neighbour sits inside the window on one side
          rcases (by omega : (t : ℕ) + 1 < L ∨ L ≤ (t : ℕ) + 1) with hin | hin
          · have hrmem : g ⟨(t : ℕ) + 1, hin⟩ ∈ rainTable :=
              mem_rainTable_of_rainbow (hg.bound _)
                (hg.rain ⟨(t : ℕ) + 1, hin⟩
                  (show ¬ Even ((t : ℕ) + 1) by rw [Nat.even_iff]; omega))
            exact nonMonoB_of_avoids_rain hmem hrmem (hg.avoid (t : ℕ) hin)
          · -- t is the last column and wears hex parity: the end invariant carries it
            have hteq : t = (⟨L - 1, by omega⟩ : Fin L) :=
              Fin.ext (show j.toNat = L - 1 by omega)
            have hb : ((L - 1) % 2 == 0) = true := by
              have h2 : (L - 1) % 2 = 0 := by omega
              simp [h2]
            rw [hb] at he
            rw [hteq]
            exact he.2
        · rw [if_neg (by rw [Int.even_iff]; omega : ¬ Even j)]
          exact mem_rainTable_of_rainbow (hg.bound t)
            (hg.rain t (show ¬ Even j.toNat by rw [Nat.even_iff]; omega))
      · rw [extendWindow_right (by omega)]
        have hk : ((j - (L : ℤ) + 1).toNat : ℤ) = j - (L : ℤ) + 1 :=
          Int.toNat_of_nonneg (by omega)
        have hst := towerR_state (j - (L : ℤ) + 1).toNat _ ((L - 1) % 2 == 0) he
        rcases Nat.mod_two_eq_zero_or_one (L - 1) with hb | hb <;>
          rcases Nat.mod_two_eq_zero_or_one (j - (L : ℤ) + 1).toNat with hpar | hpar
        · have hpa : parityAt ((L - 1) % 2 == 0) (j - (L : ℤ) + 1).toNat = true := by
            simp [parityAt, hpar, hb]
          rw [hpa] at hst
          rw [if_pos (by rw [Int.even_iff]; omega : Even j)]
          exact hst
        · have hpa : parityAt ((L - 1) % 2 == 0) (j - (L : ℤ) + 1).toNat = false := by
            simp [parityAt, hpar, hb]
          rw [hpa] at hst
          rw [if_neg (by rw [Int.even_iff]; omega : ¬ Even j)]
          exact hst
        · have hpa : parityAt ((L - 1) % 2 == 0) (j - (L : ℤ) + 1).toNat = false := by
            simp [parityAt, hpar, hb]
          rw [hpa] at hst
          rw [if_neg (by rw [Int.even_iff]; omega : ¬ Even j)]
          exact hst
        · have hpa : parityAt ((L - 1) % 2 == 0) (j - (L : ℤ) + 1).toNat = true := by
            simp [parityAt, hpar, hb]
          rw [hpa] at hst
          rw [if_pos (by rw [Int.even_iff]; omega : Even j)]
          exact hst
  -- consecutive avoidance, all three zones
  have avoids : ∀ j : ℤ,
      avoidsB (extendWindow L hL g j) (extendWindow L hL g (j + 1)) = true := by
    intro j
    rcases (by omega : j < 0 ∨ 0 ≤ j) with hj | hj
    · -- both columns in the left ray: k+1 and k steps out
      have hknat : (-j).toNat = (-(j + 1)).toNat + 1 := by omega
      rw [extendWindow_left (by omega : j ≤ 0),
        extendWindow_left (by omega : j + 1 ≤ 0), hknat, avoidsB_comm]
      exact towerR_avoids _ _ _ hs
    · rcases (by omega : j < (L : ℤ) - 1 ∨ (L : ℤ) - 1 ≤ j) with hjL | hjL
      · -- both columns inside the window
        have ht1 : (j.toNat) + 1 < L := by omega
        rw [extendWindow_mid' (by omega) (by omega),
          extendWindow_mid' (by omega) (by omega)]
        have hidx : (⟨(j + 1).toNat, by omega⟩ : Fin L) = ⟨j.toNat + 1, ht1⟩ :=
          Fin.ext (show (j + 1).toNat = j.toNat + 1 by omega)
        rw [hidx]
        exact hg.avoid j.toNat ht1
      · -- both columns in the right ray: k and k+1 steps out
        have hknat : (j + 1 - (L : ℤ) + 1).toNat = (j - (L : ℤ) + 1).toNat + 1 := by
          omega
        rw [extendWindow_right (by omega : (L : ℤ) - 1 ≤ j),
          extendWindow_right (by omega : (L : ℤ) - 1 ≤ j + 1), hknat]
        exact towerR_avoids _ _ _ he
  refine ⟨extendWindow L hL g, ⟨?_, ?_, ?_, ?_⟩, fun t => extendWindow_mid t⟩
  · intro j
    exact (state j).lt
  · intro j hj
    have := state j
    rw [if_pos hj] at this
    exact this.properHexB
  · intro j hj
    have := state j
    rw [if_neg hj] at this
    exact this.rainbowB
  · exact avoids

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
example : TubeProper (fun j => if Even j then 142 else 684) := by
  refine ⟨fun j => ?_, fun j hj => ?_, fun j hj => ?_, fun j => ?_⟩
  · split <;> omega
  · rw [if_pos hj]; decide
  · rw [if_neg hj]; decide
  · rcases Int.even_or_odd j with hj | hj
    · have hj1 : ¬ Even (j + 1) := by
        rw [Int.even_iff] at hj ⊢; omega
      rw [if_pos hj, if_neg hj1]; decide
    · have hj' : ¬ Even j := by
        rw [Int.odd_iff] at hj
        rw [Int.even_iff]; omega
      have hj1 : Even (j + 1) := by
        rw [Int.odd_iff] at hj
        rw [Int.even_iff]; omega
      rw [if_neg hj', if_pos hj1]; decide

-- the computable steppers land where their specs say, watched concretely
#guard stepHexToRain 142 ∈ rainTable
#guard avoidsB 142 (stepHexToRain 142)
#guard stepRainToHex 684 ∈ hexTable
#guard avoidsB 684 (stepRainToHex 684)

-- the extension is computable: extend the M19 two-column window [142, 684] and watch
-- real columns come out of both rays, avoiding as they go
#guard avoidsB (extendWindow 2 (by omega) ![142, 684] (-2))
               (extendWindow 2 (by omega) ![142, 684] (-1))
#guard avoidsB (extendWindow 2 (by omega) ![142, 684] (-1))
               (extendWindow 2 (by omega) ![142, 684] 0)
#guard extendWindow 2 (by omega) ![142, 684] 0 == 142
#guard extendWindow 2 (by omega) ![142, 684] 1 == 684
#guard avoidsB (extendWindow 2 (by omega) ![142, 684] 1)
               (extendWindow 2 (by omega) ![142, 684] 2)
#guard extendWindow 2 (by omega) ![142, 684] 3 ∈ rainTable

-- adversarial member, refused: junk high bits are not a tube colouring (the bound bites)
#guard properHexB (142 + 729)   -- the predicate alone cannot tell 871 from 142 …
example : ¬ TubeProper (fun j => if Even j then 142 + 729 else 684) :=
  fun h => by simpa using h.bound 0

end Strip
end HadwigerNelson

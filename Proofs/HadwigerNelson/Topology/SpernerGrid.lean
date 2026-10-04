import Mathlib.Data.ZMod.Basic
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Tactic.LinearCombination

/-!
# Sperner's lemma on a triangulated square grid (three labels)

The combinatorial core of Lebesgue's covering theorem for the square
(`Proofs/HadwigerNelson/Topology/LebesgueCovering.lean`, job FS131-LEB).

The grid is `{0, …, N}²`; cell `(i, j)` (with `i, j < N`) is cut along its diagonal into the
*lower* triangle `(i, j), (i+1, j), (i+1, j+1)` and the *upper* triangle `(i, j), (i, j+1), (i+1, j+1)`.
A labelling `ℓ : ℕ → ℕ → Fin 3` (values off the grid are ignored) obeys the *square boundary
conditions* when the left column is labelled `0`, the right column avoids `0`, the bottom row avoids
`2` and the top row avoids `1`. Then some triangle is *rainbow* (carries all three labels).

The proof is the parity count. A *door* is an edge whose ends are labelled `0` and `1`; a triangle
has an odd number of doors exactly when it is rainbow (`door_cell`, by `decide`). Summing over one
horizontal strip of cells, interior edges cancel in pairs, so if the strip holds no rainbow triangle the
door counts of its two horizontal lines agree mod 2 (`rowDoors_succ_eq`; its left and right vertical
edges are no doors by the boundary conditions). The bottom line has an odd number of doors (its labels
run from `0` to `1` inside `{0, 1}`), the top line none: some strip holds a rainbow triangle.
-/

namespace HadwigerNelson.SpernerGrid

open Finset

/-- An edge whose ends carry labels `x` and `y` is a *door* when one label is `0` and the other `1`;
the indicator, valued in `ZMod 2` because only the parity of the door count matters. -/
def door (x y : Fin 3) : ZMod 2 :=
  if (x = 0 ∧ y = 1) ∨ (x = 1 ∧ y = 0) then 1 else 0

/-- Three labels are *rainbow* when they are pairwise distinct, i.e. `{x, y, z} = {0, 1, 2}`. -/
def Rainbow (x y z : Fin 3) : Prop :=
  x ≠ y ∧ y ≠ z ∧ x ≠ z

/-- `Rainbow` is decided label by label. -/
instance (x y z : Fin 3) : Decidable (Rainbow x y z) := by
  unfold Rainbow; infer_instance

/-- Cell `(i, j)` of the grid holds a rainbow triangle: its lower triangle `(i, j), (i+1, j), (i+1, j+1)`
or its upper triangle `(i, j), (i, j+1), (i+1, j+1)` carries all three labels. -/
def RainbowCell (ℓ : ℕ → ℕ → Fin 3) (i j : ℕ) : Prop :=
  Rainbow (ℓ i j) (ℓ (i + 1) j) (ℓ (i + 1) (j + 1)) ∨ Rainbow (ℓ i j) (ℓ i (j + 1)) (ℓ (i + 1) (j + 1))

/-- `RainbowCell` is decided triangle by triangle. -/
instance (ℓ : ℕ → ℕ → Fin 3) (i j : ℕ) : Decidable (RainbowCell ℓ i j) := by
  unfold RainbowCell; infer_instance

/-- The number of doors, mod 2, on the horizontal line at height `j` between columns `0` and `n`. -/
def rowDoors (ℓ : ℕ → ℕ → Fin 3) (n j : ℕ) : ZMod 2 :=
  ∑ i ∈ range n, door (ℓ i j) (ℓ (i + 1) j)

/-! ## The local facts, each a finite check -/

/-- Every element of `ZMod 2` is its own negative. -/
theorem zmod2_add_self (x : ZMod 2) : x + x = 0 := by
  revert x; decide

/-- `2 = 0` in `ZMod 2`, the coefficient `linear_combination` needs to cancel a doubled term. -/
theorem zmod2_two : (2 : ZMod 2) = 0 := by
  decide

/-- **The cell identity.** If neither triangle of a cell with corners `a = (i, j)`, `b = (i+1, j)`,
`c = (i+1, j+1)`, `d = (i, j+1)` is rainbow, the doors on its bottom and top edges agree mod 2 with
the doors on its left and right edges (the diagonal is counted by both triangles and cancels). -/
theorem door_cell (a b c d : Fin 3) (hlo : ¬ Rainbow a b c) (hup : ¬ Rainbow a d c) :
    door a b + door d c = door a d + door b c := by
  revert a b c d; decide

/-- No edge between two labels other than `0` is a door. -/
theorem door_eq_zero_of_ne_zero {x y : Fin 3} (hx : x ≠ 0) (hy : y ≠ 0) : door x y = 0 := by
  revert x y; decide

/-- No edge between two labels other than `1` is a door. -/
theorem door_eq_zero_of_ne_one {x y : Fin 3} (hx : x ≠ 1) (hy : y ≠ 1) : door x y = 0 := by
  revert x y; decide

/-- The labels `0` and `1` as elements of `ZMod 2` (the label `2` is sent to `0`; it is never used). -/
def bit (x : Fin 3) : ZMod 2 :=
  if x = 1 then 1 else 0

/-- Between labels in `{0, 1}`, an edge is a door exactly when its ends differ: `door = bit + bit`. -/
theorem door_eq_bit_add_bit {x y : Fin 3} (hx : x ≠ 2) (hy : y ≠ 2) : door x y = bit x + bit y := by
  revert x y; decide

/-- Pairwise distinct labels in `Fin 3` exhaust it. -/
theorem Rainbow.exhaust {x y z : Fin 3} (h : Rainbow x y z) (k : Fin 3) : k = x ∨ k = y ∨ k = z := by
  revert x y z k; decide

/-- A label in `Fin 3` that is neither `0` nor `2` is `1`. -/
theorem fin3_eq_one {x : Fin 3} (h0 : x ≠ 0) (h2 : x ≠ 2) : x = 1 := by
  revert x; decide

/-- One more column: `rowDoors ℓ (n + 1) j` adds the door between columns `n` and `n + 1`. -/
theorem rowDoors_succ (ℓ : ℕ → ℕ → Fin 3) (n j : ℕ) :
    rowDoors ℓ (n + 1) j = rowDoors ℓ n j + door (ℓ n j) (ℓ (n + 1) j) :=
  sum_range_succ _ _

/-! ## The counts -/

/-- **One strip.** If no cell of the strip between heights `j` and `j + 1`, among the first `n`
columns, holds a rainbow triangle, the door counts of its two horizontal lines differ, mod 2, by the
doors on its two vertical ends. -/
theorem rowDoors_add_rowDoors (ℓ : ℕ → ℕ → Fin 3) (j : ℕ) :
    ∀ n, (∀ i < n, ¬ RainbowCell ℓ i j) →
      rowDoors ℓ n j + rowDoors ℓ n (j + 1) = door (ℓ 0 j) (ℓ 0 (j + 1)) + door (ℓ n j) (ℓ n (j + 1)) := by
  intro n
  induction n with
  | zero => intro _; simp [rowDoors, zmod2_add_self]
  | succ n ih =>
    intro h
    have hn := ih fun i hi => h i (Nat.lt_succ_of_lt hi)
    have hc : ¬ RainbowCell ℓ n j := h n (Nat.lt_succ_self n)
    simp only [RainbowCell, not_or] at hc
    have key := door_cell (ℓ n j) (ℓ (n + 1) j) (ℓ (n + 1) (j + 1)) (ℓ n (j + 1)) hc.1 hc.2
    rw [rowDoors_succ, rowDoors_succ]
    linear_combination hn + key + door (ℓ n j) (ℓ n (j + 1)) * zmod2_two

/-- A telescoping sum in `ZMod 2`: `∑_{i < n} (f i + f (i+1)) = f 0 + f n`. -/
theorem sum_range_add_succ (f : ℕ → ZMod 2) (n : ℕ) :
    ∑ i ∈ range n, (f i + f (i + 1)) = f 0 + f n := by
  induction n with
  | zero => simp [zmod2_add_self]
  | succ n ih =>
    rw [sum_range_succ, ih]
    linear_combination f n * zmod2_two

/-- **The bottom line has an odd number of doors**: its labels lie in `{0, 1}` and run from `0` to `1`. -/
theorem rowDoors_bottom (N : ℕ) (ℓ : ℕ → ℕ → Fin 3) (hL : ℓ 0 0 = 0) (hR : ℓ N 0 ≠ 0)
    (hB : ∀ i ≤ N, ℓ i 0 ≠ 2) : rowDoors ℓ N 0 = 1 := by
  have h1 : rowDoors ℓ N 0 = ∑ i ∈ range N, (bit (ℓ i 0) + bit (ℓ (i + 1) 0)) :=
    sum_congr rfl fun i hi =>
      door_eq_bit_add_bit (hB i (mem_range.1 hi).le) (hB (i + 1) (mem_range.1 hi))
  rw [h1, sum_range_add_succ (fun i => bit (ℓ i 0)) N, hL, fin3_eq_one hR (hB N le_rfl)]
  decide

/-- **The top line has no doors**: its labels avoid `1`. -/
theorem rowDoors_top (N : ℕ) (ℓ : ℕ → ℕ → Fin 3) (hT : ∀ i ≤ N, ℓ i N ≠ 1) : rowDoors ℓ N N = 0 :=
  sum_eq_zero fun i hi =>
    door_eq_zero_of_ne_one (hT i (mem_range.1 hi).le) (hT (i + 1) (mem_range.1 hi))

/-- **A strip without a rainbow triangle passes its door parity up**, under the side conditions (the
left column labelled `0`, the right column avoiding `0`). -/
theorem rowDoors_succ_eq (N : ℕ) (ℓ : ℕ → ℕ → Fin 3) (hL : ∀ j ≤ N, ℓ 0 j = 0) (hR : ∀ j ≤ N, ℓ N j ≠ 0)
    {j : ℕ} (hj : j < N) (hstrip : ∀ i < N, ¬ RainbowCell ℓ i j) :
    rowDoors ℓ N (j + 1) = rowDoors ℓ N j := by
  have h := rowDoors_add_rowDoors ℓ j N hstrip
  rw [hL j hj.le, hL (j + 1) hj, door_eq_zero_of_ne_zero (hR j hj.le) (hR (j + 1) hj),
    show door 0 0 = 0 by decide, add_zero] at h
  linear_combination h - rowDoors ℓ N j * zmod2_two

/-- **Sperner's lemma on the triangulated square grid.** A labelling of `{0, …, N}²` by `Fin 3` whose
left column is labelled `0`, whose right column avoids `0`, whose bottom row avoids `2` and whose top
row avoids `1` has a cell `(i, j)`, `i, j < N`, one of whose two triangles carries all three labels. -/
theorem exists_rainbowCell (N : ℕ) (ℓ : ℕ → ℕ → Fin 3)
    (hL : ∀ j ≤ N, ℓ 0 j = 0) (hR : ∀ j ≤ N, ℓ N j ≠ 0)
    (hB : ∀ i ≤ N, ℓ i 0 ≠ 2) (hT : ∀ i ≤ N, ℓ i N ≠ 1) :
    ∃ i < N, ∃ j < N, RainbowCell ℓ i j := by
  by_contra hne
  push Not at hne
  have hall : ∀ j ≤ N, rowDoors ℓ N j = 1 := by
    intro j hj
    induction j with
    | zero => exact rowDoors_bottom N ℓ (hL 0 (Nat.zero_le _)) (hR 0 (Nat.zero_le _)) hB
    | succ j ih =>
      rw [rowDoors_succ_eq N ℓ hL hR (Nat.lt_of_succ_le hj) fun i hi => hne i hi j (Nat.lt_of_succ_le hj)]
      exact ih (Nat.le_of_succ_le hj)
  have h := hall N le_rfl
  rw [rowDoors_top N ℓ hT] at h
  exact absurd h (by decide)

/-! ## Spec examples: each definition pinned, and a model of the boundary conditions -/

example : door 0 1 = 1 ∧ door 1 0 = 1 ∧ door 0 0 = 0 ∧ door 0 2 = 0 ∧ door 1 2 = 0 := by decide

example : Rainbow 0 1 2 ∧ Rainbow 2 0 1 ∧ ¬ Rainbow 0 1 1 ∧ ¬ Rainbow 2 2 2 := by decide

example : bit 0 = 0 ∧ bit 1 = 1 ∧ bit 2 = 0 := by decide

/-- The one-cell model of `exists_rainbowCell`'s hypotheses: the left column `0`, then `1` below and
`2` above on the right. -/
def oneCell (i j : ℕ) : Fin 3 :=
  if i = 0 then 0 else if j = 0 then 1 else 2

example : (∀ j ≤ 1, oneCell 0 j = 0) ∧ (∀ j ≤ 1, oneCell 1 j ≠ 0) ∧ (∀ i ≤ 1, oneCell i 0 ≠ 2) ∧
    (∀ i ≤ 1, oneCell i 1 ≠ 1) := by decide

example : RainbowCell oneCell 0 0 ∧ rowDoors oneCell 1 0 = 1 ∧ rowDoors oneCell 1 1 = 0 := by decide

end HadwigerNelson.SpernerGrid

-- PLANT (J16 stage 3): S2 forward's conclusion r1 = r5 replaced by r1 = r4 (false on type-P wheels); wheel_all must fail.
import Mathlib.Data.ZMod.Basic
import Mathlib.Data.Fin.VecNotation
import Mathlib.Data.List.FinRange
import Mathlib.Tactic.Ring
import Mathlib.Tactic.LinearCombination

/-!
# The stripe lemma: a proper four-colouring of the triangular lattice with no monochromatic √3-triangle is striped

FS-87 target 1, FS85-V2-T5 (`plans/FS85-V2-verification.md` §W5 item 3; prior art `[Parts2020hv]` §3, MASCOT-T10): **under NT₀
every proper four-colouring of the triangular lattice is striped** — the four colours split into two pairs, and which pair a
point's colour lies in is an affine function `ℤ[ζ₆] → 𝔽₂`.

The lattice is `ℤ[ζ₆]` in the basis `1, ζ₆`, i.e. `ℤ × ℤ` with the six unit steps `rim 0, …, rim 5 = ±(1,0), ±(0,1), ±(−1,1)` in
cyclic order. The proof:
- **the wheel facts** (`wheel_facts`, a complete check of the `4⁷` colourings of one wheel, `wheel_all`): a proper wheel with no
  monochromatic alternate triple has all three diagonals monochromatic (type O) or exactly one, with the rim `b c b d c d`
  (type P); and the two propagation facts below;
- **propagation along a line** (`typeP_zero_add`): a type-P point along `v` makes `x + v` and `x − v` type P along `v`, so the line
  `x + ℤv` is two-coloured;
- **line to line** (`striped_of_line`, properness alone): a point of the next parallel line is adjacent to two consecutive points of
  this one, so avoids their two colours;
- **one direction suffices** (`rot`): the rotation by `ζ₆` carries proper NT₀ colourings to proper NT₀ colourings and stripes back;
  if no point is of type P, every point is of type O and every line is two-coloured.

The finite check is a complete enumeration of the set the wheel derivation fixes (the colourings of one wheel), in the kernel by
`decide +kernel`; no solver, no native evaluation.
-/

set_option autoImplicit false

namespace HadwigerNelson
namespace Stripe

/-! ## The lattice, the colourings, the conclusion -/

/-- The six unit steps of `ℤ[ζ₆]` in the basis `1, ζ₆`, in cyclic order (angles 0°, 60°, …, 300°). -/
def rim : Fin 6 → ℤ × ℤ := ![(1, 0), (0, 1), (-1, 1), (-1, 0), (0, -1), (1, -1)]

theorem rim_zero : rim 0 = (1, 0) := rfl
theorem rim_one : rim 1 = (0, 1) := rfl
theorem rim_two : rim 2 = (-1, 1) := rfl
theorem rim_three : rim 3 = (-1, 0) := rfl
theorem rim_four : rim 4 = (0, -1) := rfl
theorem rim_five : rim 5 = (1, -1) := rfl

/-- Proper: a point and each of its six neighbours differ. -/
def Proper (c : ℤ × ℤ → Fin 4) : Prop := ∀ x (i : Fin 6), c x ≠ c (x + rim i)

/-- NT₀: no monochromatic √3-triangle. Every √3-triangle of `ℤ[ζ₆]` is an alternate triple `x + rim 0, x + rim 2, x + rim 4` or
`x + rim 1, x + rim 3, x + rim 5` of the wheel at its centroid `x`, a lattice point. -/
def NT0 (c : ℤ × ℤ → Fin 4) : Prop :=
  ∀ x, ¬ (c (x + rim 0) = c (x + rim 2) ∧ c (x + rim 2) = c (x + rim 4)) ∧
       ¬ (c (x + rim 1) = c (x + rim 3) ∧ c (x + rim 3) = c (x + rim 5))

/-- Striped: a pairing of the four colours (`π`, each fibre of size two) whose pair index is affine on the lattice. -/
def Striped (c : ℤ × ℤ → Fin 4) : Prop :=
  ∃ (π : Fin 4 → ZMod 2) (β : ℤ × ℤ →+ ZMod 2),
    (∀ e : ZMod 2, (Finset.univ.filter fun i => π i = e).card = 2) ∧ ∀ x, π (c x) = π (c 0) + β x

/-- Type P along `rim k` at `x`: the diagonal `±rim k` is monochromatic, the two rim neighbours of `rim k` agree, and so do the two
rim neighbours of `−rim k` — the rim reads `b c b d c d`. Type P along `rim k` and along `rim (k + 3)` are the same condition. -/
def TypeP (c : ℤ × ℤ → Fin 4) (x : ℤ × ℤ) (k : Fin 6) : Prop :=
  c (x + rim k) = c (x + rim (k + 3)) ∧ c (x + rim (k + 1)) = c (x + rim (k + 5)) ∧
    c (x + rim (k + 2)) = c (x + rim (k + 4))

/-! ## The wheel facts: a complete check of one wheel's `4⁷` colourings -/

/-- What one wheel (centre `a`, rim `r₀ … r₅`) must satisfy, proper and without a monochromatic alternate triple: type O or type P
along `rim 0`, `rim 1` or `rim 2`; and the two propagation facts (a pair of rim points two apart agreeing forces the pattern). -/
abbrev WheelFacts (a r0 r1 r2 r3 r4 r5 : Fin 4) : Prop :=
  a ≠ r0 → a ≠ r1 → a ≠ r2 → a ≠ r3 → a ≠ r4 → a ≠ r5 →
    r0 ≠ r1 → r1 ≠ r2 → r2 ≠ r3 → r3 ≠ r4 → r4 ≠ r5 → r5 ≠ r0 →
    ¬ (r0 = r2 ∧ r2 = r4) → ¬ (r1 = r3 ∧ r3 = r5) →
    ((r0 = r3 ∧ r1 = r4 ∧ r2 = r5) ∨ (r0 = r3 ∧ r1 = r5 ∧ r2 = r4) ∨ (r1 = r4 ∧ r2 = r0 ∧ r3 = r5) ∨
        (r2 = r5 ∧ r3 = r1 ∧ r4 = r0)) ∧
      (r2 = r4 → r0 = r3 ∧ r1 = r4) ∧ (r1 = r5 → r0 = r3 ∧ r2 = r4)

/-- **The wheel check**: `WheelFacts` on all `4⁷ = 16,384` wheels, by nested `List.all` (recursion depth 28, not `4⁷`). -/
theorem wheel_all :
    (List.finRange 4).all (fun a => (List.finRange 4).all fun r0 => (List.finRange 4).all fun r1 =>
      (List.finRange 4).all fun r2 => (List.finRange 4).all fun r3 => (List.finRange 4).all fun r4 =>
      (List.finRange 4).all fun r5 => decide (WheelFacts a r0 r1 r2 r3 r4 r5)) = true := by
  decide +kernel

theorem wheelFacts (a r0 r1 r2 r3 r4 r5 : Fin 4) : WheelFacts a r0 r1 r2 r3 r4 r5 := by
  have h := wheel_all
  simp only [List.all_eq_true, List.mem_finRange, forall_const, decide_eq_true_eq] at h
  exact h a r0 r1 r2 r3 r4 r5

/-! ## The wheel facts at a lattice point -/

section Wheel

variable {c : ℤ × ℤ → Fin 4}

/-- Consecutive rim points are adjacent: `rim i + rim (i + 2) = rim (i + 1)`. -/
theorem rim_add_rim_two (i : Fin 6) : rim i + rim (i + 2) = rim (i + 1) := by
  fin_cases i <;> rfl

theorem rim_ne_succ (hc : Proper c) (x : ℤ × ℤ) (i : Fin 6) : c (x + rim i) ≠ c (x + rim (i + 1)) := by
  have h := hc (x + rim i) (i + 2)
  rwa [add_assoc, rim_add_rim_two] at h

/-- The wheel facts at `x`, in the lattice's words. -/
theorem wheel (hc : Proper c) (hnt : NT0 c) (x : ℤ × ℤ) :
    ((c (x + rim 0) = c (x + rim 3) ∧ c (x + rim 1) = c (x + rim 4) ∧ c (x + rim 2) = c (x + rim 5)) ∨
        TypeP c x 0 ∨ TypeP c x 1 ∨ TypeP c x 2) ∧
      (c (x + rim 2) = c (x + rim 4) → c (x + rim 0) = c (x + rim 3) ∧ c (x + rim 1) = c (x + rim 5)) ∧
      (c (x + rim 1) = c (x + rim 5) → c (x + rim 0) = c (x + rim 3) ∧ c (x + rim 2) = c (x + rim 4)) := by
  have h := wheelFacts (c x) (c (x + rim 0)) (c (x + rim 1)) (c (x + rim 2)) (c (x + rim 3)) (c (x + rim 4))
    (c (x + rim 5)) (hc x 0) (hc x 1) (hc x 2) (hc x 3) (hc x 4) (hc x 5) (rim_ne_succ hc x 0) (rim_ne_succ hc x 1)
    (rim_ne_succ hc x 2) (rim_ne_succ hc x 3) (rim_ne_succ hc x 4) (rim_ne_succ hc x 5) (hnt x).1 (hnt x).2
  obtain ⟨hO, hF, hB⟩ := h
  refine ⟨?_, hF, hB⟩
  rcases hO with h | h | h | h
  · exact Or.inl h
  · exact Or.inr (Or.inl h)
  · exact Or.inr (Or.inr (Or.inl h))
  · exact Or.inr (Or.inr (Or.inr ⟨h.1, h.2.1, h.2.2⟩))

end Wheel

/-! ## Propagation along a line (direction `rim 0`) -/

section Propagation

variable {c : ℤ × ℤ → Fin 4}

/-- Type P along `rim 0`, spelled out. -/
theorem typeP_zero_iff {x : ℤ × ℤ} :
    TypeP c x 0 ↔ c (x + rim 0) = c (x + rim 3) ∧ c (x + rim 1) = c (x + rim 5) ∧ c (x + rim 2) = c (x + rim 4) :=
  Iff.rfl

/-- **S2, forward**: type P along `rim 0` at `x` gives type P along `rim 0` at `x + rim 0`. -/
theorem typeP_zero_add (hc : Proper c) (hnt : NT0 c) {x : ℤ × ℤ} (h : TypeP c x 0) : TypeP c (x + rim 0) 0 := by
  obtain ⟨-, h15, -⟩ := typeP_zero_iff.mp h
  have e2 : x + rim 0 + rim 2 = x + rim 1 := by rw [add_assoc]; rfl
  have e4 : x + rim 0 + rim 4 = x + rim 5 := by rw [add_assoc]; rfl
  have h24 : c (x + rim 0 + rim 2) = c (x + rim 0 + rim 4) := by rw [e2, e4]; exact h15
  obtain ⟨h03, h15'⟩ := (wheel hc hnt (x + rim 0)).2.1 h24
  exact ⟨h03, h15', h24⟩

/-- **S2, backward**: type P along `rim 0` at `x` gives type P along `rim 0` at `x + rim 3 = x − rim 0`. -/
theorem typeP_three_add (hc : Proper c) (hnt : NT0 c) {x : ℤ × ℤ} (h : TypeP c x 0) : TypeP c (x + rim 3) 0 := by
  obtain ⟨-, -, h24⟩ := typeP_zero_iff.mp h
  have e1 : x + rim 3 + rim 1 = x + rim 2 := by rw [add_assoc]; rfl
  have e5 : x + rim 3 + rim 5 = x + rim 4 := by rw [add_assoc]; rfl
  have h15 : c (x + rim 3 + rim 1) = c (x + rim 3 + rim 5) := by rw [e1, e5]; exact h24
  obtain ⟨h03, h24'⟩ := (wheel hc hnt (x + rim 3)).2.2 h15
  exact ⟨h03, h15, h24'⟩

/-- **The line through a type-P point is type P along its diagonal throughout.** -/
theorem typeP_line (hc : Proper c) (hnt : NT0 c) {x : ℤ × ℤ} (h : TypeP c x 0) (s : ℤ) :
    TypeP c (x + (s, 0)) 0 := by
  induction s using Int.induction_on with
  | zero =>
    have e : x + ((0 : ℤ), (0 : ℤ)) = x := by ext <;> simp
    rw [e]; exact h
  | succ n ih =>
    have e : x + ((n : ℤ) + 1, (0 : ℤ)) = x + ((n : ℤ), (0 : ℤ)) + rim 0 := by
      ext <;> simp [rim_zero, add_assoc]
    rw [e]; exact typeP_zero_add hc hnt ih
  | pred n ih =>
    have e : x + (-(n : ℤ) - 1, (0 : ℤ)) = x + (-(n : ℤ), (0 : ℤ)) + rim 3 := by
      ext <;> simp [rim_three, add_assoc, sub_eq_add_neg]
    rw [e]; exact typeP_three_add hc hnt ih

end Propagation

/-! ## Line to line: a two-coloured line stripes the lattice (properness alone) -/

section Lines

/-- The pairing that separates `{p, q}` from the other two colours. -/
def pairOf (p q : Fin 4) (i : Fin 4) : ZMod 2 := if i = p ∨ i = q then 0 else 1

theorem pairOf_card {p q : Fin 4} (hpq : p ≠ q) (e : ZMod 2) :
    (Finset.univ.filter fun i => pairOf p q i = e).card = 2 := by
  revert p q e
  decide

/-- The step: a colour different from two distinct colours of one pair lies in the other pair. -/
theorem pairOf_step {p q : Fin 4} (hpq : p ≠ q) {a b y : Fin 4} (hab : a ≠ b) (hya : y ≠ a) (hyb : y ≠ b)
    (h : pairOf p q a = pairOf p q b) : pairOf p q y = pairOf p q a + 1 := by
  revert p q a b y
  decide

variable {c : ℤ × ℤ → Fin 4}

/-- A neighbour of `x + (s, n)` in coordinates. -/
theorem ne_add_rim (hc : Proper c) (x : ℤ × ℤ) (s n : ℤ) (i : Fin 6) :
    c (x + (s, n)) ≠ c (x + (s + (rim i).1, n + (rim i).2)) := by
  have h := hc (x + (s, n)) i
  have e : x + (s, n) + rim i = x + (s + (rim i).1, n + (rim i).2) := by ext <;> simp [add_assoc]
  rwa [e] at h

/-- **Line to line.** If the line `x + ℤ·(1, 0)` is two-periodic, the colouring is striped: with `{p, q}` that line's two colours,
the pair of the colour at `x + (s, n)` is `n mod 2`. Uses only properness. -/
theorem striped_of_line (hc : Proper c) (x : ℤ × ℤ) (hx : ∀ s : ℤ, c (x + (s + 2, 0)) = c (x + (s, 0))) : Striped c := by
  obtain ⟨C, hC⟩ : ∃ C : ℤ → ℤ → Fin 4, ∀ s n, C s n = c (x + (s, n)) := ⟨_, fun _ _ => rfl⟩
  have a0 : ∀ s n, C s n ≠ C (s + 1) n := fun s n => by
    simpa [hC, rim_zero] using ne_add_rim hc x s n 0
  have a1 : ∀ s n, C s n ≠ C s (n + 1) := fun s n => by
    simpa [hC, rim_one] using ne_add_rim hc x s n 1
  have a2 : ∀ s n, C (s + 1) n ≠ C s (n + 1) := fun s n => by
    simpa [hC, rim_two] using ne_add_rim hc x (s + 1) n 2
  have h2 : ∀ s, C (s + 2) 0 = C s 0 := fun s => by simpa [hC] using hx s
  set p := C 0 0
  set q := C 1 0
  have hpq : p ≠ q := by simpa using a0 0 0
  -- the base line lies in `{p, q}`
  have base : ∀ s : ℤ, (C s 0 = p ∧ C (s + 1) 0 = q) ∨ (C s 0 = q ∧ C (s + 1) 0 = p) := by
    intro s
    induction s using Int.induction_on with
    | zero => exact Or.inl ⟨rfl, by simp [q]⟩
    | succ n ih =>
      have e : C ((n : ℤ) + 1 + 1) 0 = C n 0 := by rw [add_assoc, one_add_one_eq_two]; exact h2 n
      rcases ih with ⟨h1, h2⟩ | ⟨h1, h2⟩
      · exact Or.inr ⟨h2, e.trans h1⟩
      · exact Or.inl ⟨h2, e.trans h1⟩
    | pred n ih =>
      have e : C (-(n : ℤ) - 1) 0 = C (-(n : ℤ) + 1) 0 := by
        have := h2 (-(n : ℤ) - 1)
        rw [show -(n : ℤ) - 1 + 2 = -(n : ℤ) + 1 from (by ring)] at this
        exact this.symm
      rw [sub_add_cancel, e]
      rcases ih with ⟨h1, h2⟩ | ⟨h1, h2⟩
      · exact Or.inr ⟨h2, h1⟩
      · exact Or.inl ⟨h2, h1⟩
  have two : (2 : ZMod 2) = 0 := rfl
  -- the pair of `x + (s, n)` is `n`
  have lines : ∀ n : ℤ, ∀ s : ℤ, pairOf p q (C s n) = (n : ZMod 2) := by
    intro n
    induction n using Int.induction_on with
    | zero =>
      intro s
      rcases base s with ⟨h1, -⟩ | ⟨h1, -⟩ <;> simp [pairOf, h1]
    | succ n ih =>
      intro s
      have := pairOf_step hpq (a0 s n) (a1 s n).symm (a2 s n).symm ((ih s).trans (ih (s + 1)).symm)
      rw [this, ih s]
      push_cast; ring
    | pred n ih =>
      intro s
      have hya : C s (-(n : ℤ) - 1) ≠ C s (-(n : ℤ)) := by
        simpa using a1 s (-(n : ℤ) - 1)
      have hyb : C s (-(n : ℤ) - 1) ≠ C (s - 1) (-(n : ℤ)) := by
        simpa using a2 (s - 1) (-(n : ℤ) - 1)
      have hab : C s (-(n : ℤ)) ≠ C (s - 1) (-(n : ℤ)) := by
        simpa using (a0 (s - 1) (-(n : ℤ))).symm
      have := pairOf_step hpq hab hya hyb ((ih s).trans (ih (s - 1)).symm)
      rw [this, ih s]
      push_cast
      linear_combination two
  refine ⟨pairOf p q, (Int.castAddHom (ZMod 2)).comp (AddMonoidHom.snd ℤ ℤ), pairOf_card hpq, fun y => ?_⟩
  have ey : c y = C (y.1 - x.1) (y.2 - x.2) := by rw [hC]; congr 1; ext <;> simp
  have e0 : c 0 = C (-x.1) (-x.2) := by rw [hC]; congr 1; ext <;> simp
  rw [ey, e0, lines, lines]
  simp only [AddMonoidHom.coe_comp, Function.comp_apply, AddMonoidHom.coe_snd, Int.coe_castAddHom]
  push_cast; ring

end Lines

/-! ## One direction suffices: the rotation by `ζ₆` -/

section Rotation

/-- Multiplication by `ζ₆` in the basis `1, ζ₆`: `(a, b) ↦ (−b, a + b)`. -/
def rot : ℤ × ℤ →+ ℤ × ℤ where
  toFun p := (-p.2, p.1 + p.2)
  map_zero' := by ext <;> simp
  map_add' p q := by ext <;> simp <;> ring

/-- The inverse rotation, `(a, b) ↦ (a + b, −a)`. -/
def rotInv : ℤ × ℤ →+ ℤ × ℤ where
  toFun p := (p.1 + p.2, -p.1)
  map_zero' := by ext <;> simp
  map_add' p q := by ext <;> simp <;> ring

theorem rot_rotInv (x : ℤ × ℤ) : rot (rotInv x) = x := by
  ext <;> simp [rot, rotInv]

/-- The rotation steps the rim: `ζ₆ · rim i = rim (i + 1)`. -/
theorem rot_rim (i : Fin 6) : rot (rim i) = rim (i + 1) := by
  fin_cases i <;> rfl

variable {c : ℤ × ℤ → Fin 4}

theorem proper_comp_rot (hc : Proper c) : Proper (c ∘ rot) := fun x i => by
  simpa only [Function.comp_apply, map_add, rot_rim] using hc (rot x) (i + 1)

theorem nt0_comp_rot (hnt : NT0 c) : NT0 (c ∘ rot) := fun x => by
  simp only [Function.comp_apply, map_add, rot_rim]
  obtain ⟨h1, h2⟩ := hnt (rot x)
  exact ⟨h2, fun h => h1 ⟨(h.1.trans h.2).symm, h.1⟩⟩

theorem striped_of_comp_rot (h : Striped (c ∘ rot)) : Striped c := by
  obtain ⟨π, β, hπ, hβ⟩ := h
  refine ⟨π, β.comp rotInv, hπ, fun x => ?_⟩
  have := hβ (rotInv x)
  simpa only [Function.comp_apply, rot_rotInv, map_zero, AddMonoidHom.coe_comp] using this

theorem typeP_comp_rot {x : ℤ × ℤ} {k : Fin 6} (h : TypeP c (rot x) (k + 1)) : TypeP (c ∘ rot) x k := by
  obtain ⟨h1, h2, h3⟩ := h
  simp only [TypeP, Function.comp_apply, map_add, rot_rim]
  refine ⟨?_, ?_, ?_⟩
  · rwa [add_right_comm k 3 1]
  · rwa [add_right_comm k 5 1]
  · rwa [add_right_comm k 2 1, add_right_comm k 4 1]

end Rotation

/-! ## The stripe lemma -/

section Main

variable {c : ℤ × ℤ → Fin 4}

/-- A type-P point along `rim 0` stripes the colouring: its line is two-coloured (propagation), then line to line. -/
theorem striped_of_typeP (hc : Proper c) (hnt : NT0 c) {x : ℤ × ℤ} (h : TypeP c x 0) : Striped c := by
  refine striped_of_line hc x fun s => ?_
  have h03 := (typeP_zero_iff.mp (typeP_line hc hnt h (s + 1))).1
  have e1 : x + (s + 1, 0) + rim 0 = x + (s + 2, 0) := by
    ext <;> simp [rim_zero, add_assoc]
  have e2 : x + (s + 1, 0) + rim 3 = x + (s, 0) := by
    ext <;> simp [rim_three, add_assoc]
  rwa [e1, e2] at h03

/-- **The stripe lemma** (FS85-V2-T5; `[Parts2020hv]` §3): every proper four-colouring of the triangular lattice with no
monochromatic √3-triangle is striped. -/
theorem striped_of_proper_nt0 (hc : Proper c) (hnt : NT0 c) : Striped c := by
  by_cases h0 : ∃ x, TypeP c x 0
  · obtain ⟨x, hx⟩ := h0
    exact striped_of_typeP hc hnt hx
  by_cases h1 : ∃ x, TypeP c x 1
  · obtain ⟨x, hx⟩ := h1
    refine striped_of_comp_rot (striped_of_typeP (proper_comp_rot hc) (nt0_comp_rot hnt) (x := rotInv x) ?_)
    apply typeP_comp_rot
    rw [rot_rotInv]
    exact hx
  by_cases h2 : ∃ x, TypeP c x 2
  · obtain ⟨x, hx⟩ := h2
    refine striped_of_comp_rot (striped_of_comp_rot (c := c ∘ rot)
      (striped_of_typeP (proper_comp_rot (proper_comp_rot hc)) (nt0_comp_rot (nt0_comp_rot hnt))
        (x := rotInv (rotInv x)) ?_))
    apply typeP_comp_rot
    rw [rot_rotInv]
    apply typeP_comp_rot
    rw [rot_rotInv]
    exact hx
  -- no type-P point: every point is of type O, and the line through `0` along `rim 0` is two-periodic
  simp only [not_exists] at h0 h1 h2
  refine striped_of_line hc 0 fun s => ?_
  rcases (wheel hc hnt ((0 : ℤ × ℤ) + (s + 1, 0))).1 with ⟨h03, -, -⟩ | h | h | h
  · have e1 : (0 : ℤ × ℤ) + (s + 1, 0) + rim 0 = 0 + (s + 2, 0) := by
      ext
      · simp [rim_zero]; ring
      · simp [rim_zero]
    have e2 : (0 : ℤ × ℤ) + (s + 1, 0) + rim 3 = 0 + (s, 0) := by
      ext <;> simp [rim_three]
    rwa [e1, e2] at h03
  · exact absurd h (h0 _)
  · exact absurd h (h1 _)
  · exact absurd h (h2 _)

end Main

/-! ## Spec -/

-- The rim is the unit circle of the Eisenstein norm `a² + ab + b²`, and an alternate triple is a √3-triangle.
example : ∀ i : Fin 6, (rim i).1 ^ 2 + (rim i).1 * (rim i).2 + (rim i).2 ^ 2 = 1 := by decide
example : ((rim 2 - rim 0).1 ^ 2 + (rim 2 - rim 0).1 * (rim 2 - rim 0).2 + (rim 2 - rim 0).2 ^ 2 = 3) := by decide

/-- The four classes of `ℤ[ζ₆]/2 = 𝔽₄`, numbered. -/
def enc (a b : ZMod 2) : Fin 4 :=
  ⟨a.val + 2 * b.val, by have h1 := ZMod.val_lt a; have h2 := ZMod.val_lt b; omega⟩

/-- The model: the colouring by the class modulo `2ℤ[ζ₆]` — type O at every point. -/
def modTwo (x : ℤ × ℤ) : Fin 4 := enc x.1 x.2

theorem modTwo_add (x y : ℤ × ℤ) : modTwo (x + y) = enc ((x.1 : ZMod 2) + y.1) ((x.2 : ZMod 2) + y.2) := by
  simp only [modTwo, Prod.fst_add, Prod.snd_add, Int.cast_add]

/-- The hypotheses are inhabited (1): the class-mod-2 colouring is proper. -/
theorem proper_modTwo : Proper modTwo := by
  intro x i
  rw [modTwo_add]
  change enc (x.1 : ZMod 2) (x.2 : ZMod 2) ≠ _
  generalize (x.1 : ZMod 2) = a
  generalize (x.2 : ZMod 2) = b
  revert a b i
  decide

/-- The hypotheses are inhabited (2): the class-mod-2 colouring has no monochromatic √3-triangle. -/
theorem nt0_modTwo : NT0 modTwo := by
  intro x
  simp only [modTwo_add]
  generalize (x.1 : ZMod 2) = a
  generalize (x.2 : ZMod 2) = b
  revert a b
  decide

-- The stripe lemma consumed on its model.
example : Striped modTwo := striped_of_proper_nt0 proper_modTwo nt0_modTwo

end Stripe
end HadwigerNelson

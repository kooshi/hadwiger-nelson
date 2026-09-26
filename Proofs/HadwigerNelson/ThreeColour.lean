import Mathlib.Combinatorics.SimpleGraph.Cayley
import Mathlib.Combinatorics.SimpleGraph.Coloring.Vertex
import Mathlib.Data.ZMod.Basic
import Mathlib.Algebra.BigOperators.Fin
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.FinCases
import Mathlib.Tactic.Ring
import Mathlib.Tactic.NormNum

/-!
# The three-colour criterion's ⟹ direction, in winding form (FS-75, job J52K)

A colouring `c : A → ZMod 3` of an abelian group, proper along generators `s : Fin m → A` (every step `a ↦ a + s j`
changes the colour), carries a **winding**: an additive map `W` on the relation lattice `ker (r ↦ Σ_j r_j • s_j)` with

  `Σ_j min(r_j, 2r_j) ≤ 3·W(r)`.

This is FS73-T42's forward lift (`data/fs73/records/verify-P3b-q167.md` §1, steps 1–3) read on words, with no
averaging: lift each colour step to an integer in `{1, 2}`; along a word the lifted steps add to a *height* in
`[length, 2·length]`; the height is independent of the order of the word, because both two-step sums around a square lie
in `{2, 3, 4}` and agree mod 3; so the height difference between the positive and negative parts of a relation is a
well-defined, additive, `3`-divisible integer bounded below by the least rise. Nothing here uses a real number, a
Følner set, compactness, torsion-freeness of `A`, or that `s` generates.

`plans/FS75-kernel-167.md` §1.3 explains why a relation-branching certificate (`ThetaCert`) needs only this functional
and never the real point of `Θ₃`; `ThetaCert.Cert.isEmpty_winding` is the consumer.

## Main results

* `ThreeColour.nonempty_winding` — a colouring proper along `s` carries a `Winding s`;
* `ThreeColour.nonempty_winding_of_colorable` — the same from a proper 3-colouring of `addCayley (Set.range s)`;
* `ThreeColour.properAlong_one_two` — the inhabitant: `x ↦ x mod 3` on `ℤ` along `(1, 2)`.
-/

namespace HadwigerNelson

open SimpleGraph

namespace ThreeColour

open SimpleGraph

variable {A : Type*} [AddCommGroup A] {m : ℕ}

/-! ## §1 The relation lattice and the winding -/

/-- The relation map `ℤ^m → A`, `r ↦ Σ_j r_j • s_j`; its kernel is the relation lattice. -/
def relMap (s : Fin m → A) : (Fin m → ℤ) →+ A where
  toFun r := ∑ j, r j • s j
  map_zero' := by simp
  map_add' r r' := by simp [add_smul, Finset.sum_add_distrib]

/-- **The least rise along `r`**: `Σ_j min(r_j, 2r_j) = |r⁺| − 2|r⁻|`, the least height change of a word pair
`(r⁺, r⁻)` whose steps lie in `{1, 2}`; equal to `3·min_{x ∈ [1/3, 2/3]^m} r·x`, the box minimum of the relation form. -/
def minRise (r : Fin m → ℤ) : ℤ := ∑ j, min (r j) (2 * r j)

/-- **A winding of `s`**: an additive functional on the relation lattice bounded below by the box — the relation
form of a point of `Θ₃` (for `x ∈ Θ₃`'s relation form, `W r = r·x`), with no real numbers. -/
structure Winding (s : Fin m → A) where
  /-- The functional. -/
  toHom : (relMap s).ker →+ ℤ
  /-- The box bound, `Σ_j min(r_j, 2r_j) ≤ 3·W(r)`. -/
  minRise_le : ∀ r : (relMap s).ker, minRise (r : Fin m → ℤ) ≤ 3 * toHom r

/-- A colouring `c : A → ZMod 3` is **proper along `s`** when every generator step changes the colour — exactly
properness on `addCayley (Set.range s)`. -/
def ProperAlong (s : Fin m → A) (c : A → ZMod 3) : Prop := ∀ a j, c (a + s j) ≠ c a

/-! ## §2 Leaf 1: the forward lift on words -/

section Lift

variable (s : Fin m → A) (c : A → ZMod 3)

/-- The lifted step `δ(a, j) ∈ {1, 2}`: the integer representative of `c (a + s j) − c a`. -/
def step (a : A) (j : Fin m) : ℤ := if c (a + s j) - c a = 1 then 1 else 2

/-- The endpoint displacement of a word. -/
def wsum (l : List (Fin m)) : A := (l.map s).sum

/-- **The height gain along a word** `l` from `a`: the sum of the lifted steps. -/
def height : A → List (Fin m) → ℤ
  | _, [] => 0
  | a, j :: l => step s c a j + height (a + s j) l

/-- The word with `v j` copies of each generator `j`, in index order. -/
def word (v : Fin m → ℕ) : List (Fin m) := (List.finRange m).flatMap fun j => List.replicate (v j) j

/-- The winding of the pair of words `(u, v)` read from `a`. -/
def wind (a : A) (u v : Fin m → ℕ) : ℤ := height s c a (word u) - height s c a (word v)

/-- Positive and negative parts of an integer vector. -/
def posPart (r : Fin m → ℤ) : Fin m → ℕ := fun j => (r j).toNat
/-- See `posPart`. -/
def negPart (r : Fin m → ℤ) : Fin m → ℕ := fun j => (-r j).toNat

-- 1a: the step
theorem step_mem (a : A) (j : Fin m) : 1 ≤ step s c a j ∧ step s c a j ≤ 2 := by
  unfold step; split_ifs <;> norm_num

theorem step_cast {c} (hc : ProperAlong s c) (a : A) (j : Fin m) :
    ((step s c a j : ℤ) : ZMod 3) = c (a + s j) - c a := by
  have h : c (a + s j) - c a ≠ 0 := sub_ne_zero.mpr (hc a j)
  unfold step
  generalize c (a + s j) - c a = x at h ⊢
  revert x; decide

-- 1b: the height along words
@[simp] theorem height_nil (a : A) : height s c a [] = 0 := rfl

theorem height_append (a : A) (l l' : List (Fin m)) :
    height s c a (l ++ l') = height s c a l + height s c (a + wsum s l) l' := by
  induction l generalizing a with
  | nil => simp [height, wsum]
  | cons j l ih => simp [height, ih, wsum, add_assoc]

theorem height_cast {c} (hc : ProperAlong s c) (a : A) (l : List (Fin m)) :
    ((height s c a l : ℤ) : ZMod 3) = c (a + wsum s l) - c a := by
  induction l generalizing a with
  | nil => simp [height, wsum]
  | cons j l ih =>
    simp only [height, Int.cast_add, step_cast s hc, ih, wsum, List.map_cons, List.sum_cons, add_assoc]
    ring

theorem height_bounds (a : A) (l : List (Fin m)) :
    (l.length : ℤ) ≤ height s c a l ∧ height s c a l ≤ 2 * l.length := by
  induction l generalizing a with
  | nil => simp [height]
  | cons j l ih =>
    have h1 := step_mem s c a j; have h2 := ih (a + s j)
    simp only [height, List.length_cons]; push_cast; omega

-- 1c: the square — both two-step sums lie in `{2, 3, 4}` and agree mod 3, hence agree
theorem step_square {c} (hc : ProperAlong s c) (a : A) (i j : Fin m) :
    step s c a i + step s c (a + s i) j = step s c a j + step s c (a + s j) i := by
  have h1 := step_mem s c a i; have h2 := step_mem s c (a + s i) j
  have h3 := step_mem s c a j; have h4 := step_mem s c (a + s j) i
  have hmod : ((step s c a i + step s c (a + s i) j : ℤ) : ZMod 3) =
      ((step s c a j + step s c (a + s j) i : ℤ) : ZMod 3) := by
    push_cast [step_cast s hc]
    rw [add_right_comm a (s i) (s j)]; ring
  rw [ZMod.intCast_eq_intCast_iff'] at hmod
  push_cast at hmod
  omega

-- 1d: path independence
theorem height_perm {c} (hc : ProperAlong s c) {l l' : List (Fin m)} (h : l.Perm l') (a : A) :
    height s c a l = height s c a l' := by
  induction h generalizing a with
  | nil => rfl
  | cons x _ ih => simp only [height, ih]
  | swap x y l =>
    simp only [height]
    rw [show a + s y + s x = a + s x + s y from add_right_comm _ _ _]
    linarith [step_square s hc a y x]
  | trans _ _ ih1 ih2 => rw [ih1, ih2]

-- 1e: words
theorem wsum_append (l l' : List (Fin m)) : wsum s (l ++ l') = wsum s l + wsum s l' := by
  simp [wsum]

theorem wsum_flatMap {ι : Type*} (f : ι → List (Fin m)) (l : List ι) :
    wsum s (l.flatMap f) = (l.map fun i => wsum s (f i)).sum := by
  induction l with
  | nil => simp [wsum]
  | cons i l ih => simp [List.flatMap_cons, wsum_append, ih]

theorem wsum_word (v : Fin m → ℕ) : wsum s (word v) = ∑ j, v j • s j := by
  rw [word, wsum_flatMap, Fin.sum_univ_def]
  congr 1; apply List.map_congr_left; intro j _
  simp [wsum, List.sum_replicate]

theorem length_word (v : Fin m → ℕ) : (word v).length = ∑ j, v j := by
  rw [word, List.length_flatMap, Fin.sum_univ_def]
  simp

theorem count_word (v : Fin m → ℕ) (j : Fin m) : (word v).count j = v j := by
  rw [word, List.count_flatMap, ← Fin.sum_univ_def (fun i => (List.count j ∘ fun i => List.replicate (v i) i) i)]
  simp [List.count_replicate]

theorem word_add_perm (v v' : Fin m → ℕ) : (word (v + v')).Perm (word v ++ word v') := by
  rw [List.perm_iff_count]; intro j
  simp [count_word, List.count_append]

-- 1f: the winding of a relation
/-- One generator moved from the front of a word to its end. -/
theorem height_add_gen {c} (hc : ProperAlong s c) (a : A) (i : Fin m) (l : List (Fin m)) :
    height s c (a + s i) l = height s c a l + step s c (a + wsum s l) i - step s c a i := by
  have h := height_perm s hc (List.perm_append_singleton i l) a
  rw [height_append] at h
  simp only [height, add_zero] at h
  linarith

theorem wind_add_gen {c} (hc : ProperAlong s c) {u v : Fin m → ℕ} (huv : wsum s (word u) = wsum s (word v))
    (a : A) (i : Fin m) : wind s c (a + s i) u v = wind s c a u v := by
  simp only [wind, height_add_gen s hc, huv]; ring

theorem wind_shift {c} (hc : ProperAlong s c) {u v : Fin m → ℕ} (huv : wsum s (word u) = wsum s (word v))
    (a : A) (l : List (Fin m)) : wind s c (a + wsum s l) u v = wind s c a u v := by
  induction l generalizing a with
  | nil => simp [wsum]
  | cons j l ih =>
    have e : a + wsum s (j :: l) = a + s j + wsum s l := by simp [wsum, add_assoc]
    rw [e, ih, wind_add_gen s hc huv]

theorem wind_add_diag {c} (hc : ProperAlong s c) {u v : Fin m → ℕ} (huv : wsum s (word u) = wsum s (word v))
    (a : A) (t : Fin m → ℕ) : wind s c a (u + t) (v + t) = wind s c a u v := by
  simp only [wind, height_perm s hc (word_add_perm u t), height_perm s hc (word_add_perm v t), height_append, huv]
  ring

theorem wind_add {c} (hc : ProperAlong s c) {u v u' v' : Fin m → ℕ}
    (huv : wsum s (word u) = wsum s (word v)) (huv' : wsum s (word u') = wsum s (word v')) (a : A) :
    wind s c a (u + u') (v + v') = wind s c a u v + wind s c a u' v' := by
  have h := wind_shift s hc huv' a (word u)
  simp only [wind, height_perm s hc (word_add_perm u u'), height_perm s hc (word_add_perm v v'),
    height_append] at h ⊢
  rw [← huv, ← h]; ring

theorem wind_cast {c} (hc : ProperAlong s c) {u v : Fin m → ℕ} (huv : wsum s (word u) = wsum s (word v)) (a : A) :
    ((wind s c a u v : ℤ) : ZMod 3) = 0 := by
  rw [wind, Int.cast_sub, height_cast s hc, height_cast s hc, huv, sub_self]

theorem minRise_le_wind (r : Fin m → ℤ) (a : A) : minRise r ≤ wind s c a (posPart r) (negPart r) := by
  have h1 := (height_bounds s c a (word (posPart r))).1
  have h2 := (height_bounds s c a (word (negPart r))).2
  rw [length_word] at h1 h2
  have e : minRise r = ∑ j, (((posPart r j : ℕ) : ℤ) - 2 * ((negPart r j : ℕ) : ℤ)) := by
    unfold minRise; refine Finset.sum_congr rfl fun j _ => ?_
    simp only [posPart, negPart]; omega
  rw [e, Finset.sum_sub_distrib, ← Finset.mul_sum, wind]
  push_cast at h1 h2
  linarith

-- 1g: the winding on the relation lattice
/-- **Balanced pairs with the same difference have the same winding.** -/
theorem wind_eq_of_sub_eq {c} (hc : ProperAlong s c) {u v u' v' : Fin m → ℕ}
    (huv : wsum s (word u) = wsum s (word v)) (huv' : wsum s (word u') = wsum s (word v'))
    (h : u + v' = u' + v) (a : A) : wind s c a u v = wind s c a u' v' := by
  rw [← wind_add_diag s hc huv a v', ← wind_add_diag s hc huv' a v, h, add_comm v v']

theorem wsum_word_add (u v : Fin m → ℕ) : wsum s (word (u + v)) = wsum s (word u) + wsum s (word v) := by
  simp only [wsum_word, Pi.add_apply, add_smul, Finset.sum_add_distrib]

/-- A relation's positive and negative parts are a balanced pair. -/
theorem wsum_word_posPart {r : Fin m → ℤ} (hr : relMap s r = 0) :
    wsum s (word (posPart r)) = wsum s (word (negPart r)) := by
  rw [wsum_word, wsum_word, ← sub_eq_zero, ← Finset.sum_sub_distrib]
  calc ∑ j, (posPart r j • s j - negPart r j • s j) = ∑ j, r j • s j :=
        Finset.sum_congr rfl fun j _ => by
          rw [← natCast_zsmul, ← natCast_zsmul, ← sub_smul, posPart, negPart, Int.toNat_sub_toNat_neg]
    _ = 0 := hr

end Lift

/-- **Leaf 1 — the three-colour criterion's ⟹ direction, winding form.** A colouring proper along `s` carries a
winding. No torsion-freeness, no generation hypothesis, no averaging, no compactness. -/
theorem nonempty_winding (s : Fin m → A) {c : A → ZMod 3} (hc : ProperAlong s c) : Nonempty (Winding s) := by
  set w : (Fin m → ℤ) → ℤ := fun r => wind s c 0 (posPart r) (negPart r) with hw
  have hdvd : ∀ r, relMap s r = 0 → 3 * (w r / 3) = w r := fun r hr =>
    Int.mul_ediv_cancel' ((ZMod.intCast_zmod_eq_zero_iff_dvd _ 3).mp (wind_cast s hc (wsum_word_posPart s hr) 0))
  have hadd : ∀ r r', relMap s r = 0 → relMap s r' = 0 → w (r + r') = w r + w r' := by
    intro r r' hr hr'
    rw [hw]; dsimp only
    rw [← wind_add s hc (wsum_word_posPart s hr) (wsum_word_posPart s hr') 0]
    refine wind_eq_of_sub_eq s hc (wsum_word_posPart s (by rw [map_add, hr, hr', add_zero]))
      (by rw [wsum_word_add, wsum_word_add, wsum_word_posPart s hr, wsum_word_posPart s hr']) ?_ 0
    funext j; simp only [Pi.add_apply, posPart, negPart]; omega
  refine ⟨{ toHom := { toFun := fun r => w r / 3, map_zero' := ?_, map_add' := ?_ }, minRise_le := ?_ }⟩
  · have h0 := hadd 0 0 (map_zero _) (map_zero _)
    simp only [add_zero] at h0
    change w 0 / 3 = 0
    omega
  · intro r r'
    have h := hadd r r' r.2 r'.2
    have h1 := hdvd r r.2; have h2 := hdvd r' r'.2
    have h3 := hdvd (r + r' : (relMap s).ker) (r + r').2
    change w ((r : Fin m → ℤ) + r') / 3 = w r / 3 + w r' / 3
    push_cast at h3
    omega
  · intro r
    change minRise (r : Fin m → ℤ) ≤ 3 * (w r / 3)
    rw [hdvd r r.2]
    exact minRise_le_wind s c r 0

/-- The `addCayley` form: a proper 3-colouring of `addCayley (Set.range s)` carries a winding. -/
theorem nonempty_winding_of_colorable (s : Fin m → A) (hs : ∀ j, s j ≠ 0)
    (h : (addCayley (Set.range s)).Colorable 3) : Nonempty (Winding s) := by
  obtain ⟨C⟩ := h
  refine nonempty_winding s (c := fun a => (C a : ZMod 3)) fun a j => ?_
  have hadj : (addCayley (Set.range s)).Adj a (a + s j) :=
    (addCayley_adj' _ _ _).mpr ⟨fun h => hs j (by simpa using h), s j, ⟨j, rfl⟩, Or.inl rfl⟩
  exact fun h => C.valid hadj h.symm

/-- **The inhabitant** (G30(5)): `x ↦ x mod 3` is proper along `(1, 2)` on `ℤ` — the criterion's hypothesis is not
empty, and neither is its conclusion. -/
theorem properAlong_one_two : ProperAlong ![(1 : ℤ), 2] (fun x => (x : ZMod 3)) := by
  intro a j; fin_cases j <;> simp [show (2 : ZMod 3) ≠ 0 by decide]

example : Nonempty (Winding ![(1 : ℤ), 2]) := nonempty_winding _ properAlong_one_two

/-! ### Spec examples: each definition on the inhabitant `x ↦ x mod 3` along `(1, 2)`, relation `(2, −1)` -/

example : relMap ![(1 : ℤ), 2] ![2, -1] = 0 := by decide
example : relMap ![(1 : ℤ), 2] ![1, 1] = 3 := by decide
example : minRise ![(2 : ℤ), -1] = 0 := by decide
example : minRise ![(1 : ℤ), 1] = 2 := by decide
example : posPart ![(2 : ℤ), -1] = ![2, 0] ∧ negPart ![(2 : ℤ), -1] = ![0, 1] := by decide
example : word ![2, 1] = [0, 0, 1] := by decide
example : wsum ![(1 : ℤ), 2] [0, 0, 1] = 4 := by decide
example : step ![(1 : ℤ), 2] (fun x => (x : ZMod 3)) 1 1 = 2 := by decide
example : height ![(1 : ℤ), 2] (fun x => (x : ZMod 3)) 0 [0, 0, 1] = 4 := by decide
example : wind ![(1 : ℤ), 2] (fun x => (x : ZMod 3)) 0 ![2, 0] ![0, 1] = 0 := by decide

end ThreeColour

end HadwigerNelson

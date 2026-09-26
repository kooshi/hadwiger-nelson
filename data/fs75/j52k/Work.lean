import Proofs.HadwigerNelson.SquareClass
import Proofs.HadwigerNelson.Chain
import Proofs.HadwigerNelson.UnitDistance
import Mathlib.Combinatorics.SimpleGraph.Cayley

/-!
# FS-75's minimal instance — SKELETON (job J52, 2026-09-26; `plans/FS75-kernel-167.md` §S)

Not imported by `Proofs.lean` and not under `Proofs/` (`scripts/build_order.py` walks that directory); checked with
`lake env lean` only. The implementer (J52K) splits it into `Proofs/HadwigerNelson/ThreeColour.lean` (§1–§2),
`Proofs/HadwigerNelson/ThetaCert.lean` (§3) and `Proofs/HadwigerNelson/Instances/SqrtOneSixSeven.lean` (§4–§5) when
each is sorry-free.

* §1–§2, leaf 1: **the three-colour criterion's ⟹ direction in winding form.** A colouring of an abelian group, proper
  along generators `s j`, carries a *winding*: an additive map `W` on the relation lattice `ker (r ↦ Σ r_j • s_j)` with
  `Σ_j min(r_j, 2r_j) ≤ 3·W(r)`. It is FS73-T42's forward lift (`data/fs73/records/verify-P3b-q167.md` §1, steps 1–3)
  read on words, with no averaging: the certificate never needs the point `x`, only `W` (plan §1.3).
* §3, leaf 2: **the relation-branching certificate** (V2's format, `tools/fs73v2_check.py`, integer multipliers) and
  its soundness: a passing certificate leaves no winding.
* §4–§5, leaves 3–4: the lattice in the plane over `ℚ(√167)` and the headline.
-/

set_option autoImplicit false

namespace HadwigerNelson
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

end ThreeColour

/-! ## §3 Leaf 2: the relation-branching certificate (V2's format, integer multipliers) -/

namespace ThetaCert

open ThreeColour

/-- A constraint on the path, over a winding `W`: `W(coef) ≤ rhs`, or `= rhs` when `isEq`. -/
structure Con where
  coef : List ℤ
  rhs : ℤ
  isEq : Bool
  deriving Repr, DecidableEq

/-- V2's tree. A branch names a relation (an index into the certificate's list) and `lo..hi`; its `hi − lo + 3`
children carry `W r ≤ lo − 1`, `W r = k` (`k = lo..hi`), `W r ≥ hi + 1`, in that order. A leaf lists
`(path position, integer multiplier)`, positions counted from the root. -/
inductive Tree where
  | branch (rel : ℕ) (lo hi : ℤ) (kids : List Tree)
  | leaf (mults : List (ℕ × ℤ))
  deriving Repr

/-- Untrusted data: the generators as integer vectors (read as `ℕ → ℤ`, zero beyond each list), the relations, the
tree. -/
structure Cert where
  units : List (List ℤ)
  rels : List (List ℤ)
  tree : Tree

/-- Padded addition, so `getD` is additive with no length hypothesis. -/
def addL : List ℤ → List ℤ → List ℤ
  | [], l => l
  | l, [] => l
  | a :: l, b :: l' => (a + b) :: addL l l'

/-- Scalar multiple. -/
def smulL (k : ℤ) (l : List ℤ) : List ℤ := l.map (k * ·)

/-- `Σ_j r_j • u_j` as a padded list. -/
def lincomb : List ℤ → List (List ℤ) → List ℤ
  | k :: r, u :: us => addL (smulL k u) (lincomb r us)
  | _, _ => []

/-- `Σ_j min(q_j, 2q_j)`. -/
def minRiseL (q : List ℤ) : ℤ := (q.map fun x => min x (2 * x)).sum

/-- The children's constraints of a branch on `r` over `lo..hi`. -/
def eqRun (r : List ℤ) : ℤ → ℕ → List Con
  | _, 0 => []
  | k, n + 1 => ⟨r, k, true⟩ :: eqRun r (k + 1) n

/-- See `eqRun`. -/
def childCons (r : List ℤ) (lo hi : ℤ) : List Con :=
  ⟨r, lo - 1, false⟩ :: (eqRun r lo (hi - lo + 1).toNat ++ [⟨smulL (-1) r, -(hi + 1), false⟩])

/-- A leaf refutes its path: valid positions, non-negative multipliers on inequalities, and
`Σ_j min(Q_j, 2Q_j) > 3P` for `Q = Σ λ·coef`, `P = Σ λ·rhs`. -/
def leafOk (path : List Con) (mults : List (ℕ × ℤ)) : Bool :=
  mults.all (fun pm => decide (pm.1 < path.length) && ((path.getD pm.1 ⟨[], 0, true⟩).isEq || decide (0 ≤ pm.2))) &&
    let Q := mults.foldr (fun pm acc => addL (smulL pm.2 (path.getD pm.1 ⟨[], 0, true⟩).coef) acc) []
    let P := (mults.map fun pm => pm.2 * (path.getD pm.1 ⟨[], 0, true⟩).rhs).sum
    decide (3 * P < minRiseL Q)

mutual
/-- Walk the tree; every constraint is derived from `(r, lo, hi)`, none is stated by the certificate. -/
def checkTree (rels : List (List ℤ)) (path : List Con) : Tree → Bool
  | .leaf mults => leafOk path mults
  | .branch ri lo hi kids =>
      decide (ri < rels.length) && decide (lo - 1 ≤ hi) && checkKids rels path kids (childCons (rels.getD ri []) lo hi)
/-- The children against their constraints, pairwise; the counts must match. -/
def checkKids (rels : List (List ℤ)) (path : List Con) : List Tree → List Con → Bool
  | [], [] => true
  | k :: ks, con :: cons => checkTree rels (path ++ [con]) k && checkKids rels path ks cons
  | _, _ => false
end

/-- **The checker.** Every relation is a relation of the listed units (`Σ_j r_j u_j = 0`, and no longer than the
unit list), then the tree. -/
def Cert.check (c : Cert) : Bool :=
  c.rels.all (fun r => decide (r.length ≤ c.units.length) && (lincomb r c.units).all (· == 0)) &&
    checkTree c.rels [] c.tree

/-- The listed units as generators of `ℕ → ℤ`. -/
def Cert.gen (c : Cert) : Fin c.units.length → (ℕ → ℤ) := fun j k => (c.units.getD j []).getD k 0

/-- **Leaf 2 — soundness.** A passing certificate leaves no winding. -/
theorem Cert.isEmpty_winding (c : Cert) (h : c.check = true) : IsEmpty (Winding c.gen) := sorry

/-- Leaves 1 + 2: a passing certificate refuses every colouring proper along its units. -/
theorem Cert.not_properAlong (c : Cert) (h : c.check = true) (col : (ℕ → ℤ) → ZMod 3) :
    ¬ ProperAlong c.gen col := fun hc => (c.isEmpty_winding h).false (nonempty_winding c.gen hc).some

/-- **The control** (hand-made, plan §S): `S = {1, 2, 3}` in `ℤ` — `K₄` on `0..3`, not 3-colourable — refused by a
five-leaf tree on the relations `(3, 0, −1)`, `(2, −1, 0)`. -/
def tinyK4 : Cert where
  units := [[1], [2], [3]]
  rels := [[3, 0, -1], [2, -1, 0]]
  tree := .branch 0 1 1
    [.leaf [(0, 1)],
     .branch 1 0 1 [.leaf [(1, 1)], .leaf [(0, -2), (1, 3)], .leaf [(0, 2), (1, -3)], .leaf [(1, 1)]],
     .leaf [(0, 1)]]

example : tinyK4.check = true := by decide +kernel

/-- Plant: the "= 0" leaf's multipliers negated — must fail. -/
def tinyK4Bad : Cert where
  units := [[1], [2], [3]]
  rels := [[3, 0, -1], [2, -1, 0]]
  tree := .branch 0 1 1
    [.leaf [(0, 1)],
     .branch 1 0 1 [.leaf [(1, 1)], .leaf [(0, 2), (1, -3)], .leaf [(0, 2), (1, -3)], .leaf [(1, 1)]],
     .leaf [(0, 1)]]

example : tinyK4Bad.check = false := by decide +kernel

/-- Plant: a non-relation — must fail. -/
example : ({ tinyK4 with rels := [[3, 0, 1], [2, -1, 0]] } : Cert).check = false := by decide +kernel

/-- Plant: a dropped child — must fail. -/
example : ({ tinyK4 with tree := .branch 0 1 1 [.leaf [(0, 1)], .leaf [(0, 1)]] } : Cert).check = false := by
  decide +kernel

end ThetaCert

/-! ## §4 Leaf 3: a certificate's lattice in the plane over any real field holding `√d` -/

namespace ThetaPlane

open ThreeColour ThetaCert

/-- `(a, b, c, e) ↦ ((a + b√d)/D, (c + e√d)/D)`, read off the first four coordinates; additive, and not required to
be injective. -/
noncomputable def iota (d D : ℕ) : (ℕ → ℤ) →+ ℂ where
  toFun v := ⟨((v 0 : ℝ) + v 1 * Real.sqrt d) / D, ((v 2 : ℝ) + v 3 * Real.sqrt d) / D⟩
  map_zero' := sorry
  map_add' := sorry

theorem iota_mem {d D : ℕ} {F : Subfield ℝ} (hF : Real.sqrt d ∈ F) (v : ℕ → ℤ) : iota d D v ∈ planeOver F := sorry

/-- The unit test on one listed vector, as a `Bool`: `a² + d·b² + c² + d·e² = D²` and `ab + ce = 0`. -/
def unitOk (d D : ℕ) (u : List ℤ) : Bool :=
  u.getD 0 0 ^ 2 + d * u.getD 1 0 ^ 2 + u.getD 2 0 ^ 2 + d * u.getD 3 0 ^ 2 == (D : ℤ) ^ 2 &&
    u.getD 0 0 * u.getD 1 0 + u.getD 2 0 * u.getD 3 0 == 0

/-- The two integer identities make a unit vector. -/
theorem norm_iota {d D : ℕ} (hD : D ≠ 0) {v : ℕ → ℤ}
    (h1 : v 0 ^ 2 + d * v 1 ^ 2 + v 2 ^ 2 + d * v 3 ^ 2 = (D : ℤ) ^ 2) (h2 : v 0 * v 1 + v 2 * v 3 = 0) :
    ‖iota d D v‖ = 1 := sorry

/-- A three-colouring of the plane over `F ∋ √d` pulls back to a colouring proper along the certificate's units. -/
theorem properAlong_of_colorable {d D : ℕ} (hD : D ≠ 0) {F : Subfield ℝ} (hF : Real.sqrt d ∈ F) (c : Cert)
    (hu : c.units.all (unitOk d D) = true) (h : ((unitDistance ℂ).induce (planeOver F)).Colorable 3) :
    ∃ col : (ℕ → ℤ) → ZMod 3, ProperAlong c.gen col := sorry

/-- **The consumer.** A passing certificate whose units are unit vectors of `ℚ(√d)²` with denominator `D` proves
`χ(F²) ≥ 4` for every real field `F` holding `√d`. One line per field: FS-60's quadratic witnesses, ℚ(√47)'s tree
(if it is in this format), the 60-vector control. -/
theorem four_le_chromaticNumber_of_cert {d D : ℕ} (hD : D ≠ 0) (c : Cert) (hu : c.units.all (unitOk d D) = true)
    (hc : c.check = true) {F : Subfield ℝ} (hF : Real.sqrt d ∈ F) :
    4 ≤ ((unitDistance ℂ).induce (planeOver F)).chromaticNumber := by
  have key : ¬ ((unitDistance ℂ).induce (planeOver F)).Colorable 3 := fun h => by
    obtain ⟨col, hcol⟩ := properAlong_of_colorable hD hF c hu h
    exact c.not_properAlong hc col hcol
  simpa using add_one_le_chromaticNumber_iff_not_colorable.mpr key

end ThetaPlane

/-! ## §5 Leaf 4: ℚ(√167) -/

namespace Sqrt167

/-- **T41's 36 vectors** `{1, v, z}·U_R` (18 ± pairs; `v = (83 + i√167)/84`, the type-M rotation `n = 42`) and the
1,050-leaf tree of `data/fs73/verify-v2/L21cc6506-sub-1vz-empty.json.gz`, multipliers scaled to integers per leaf by
`tools/j52_intcert.py --emit-lean` (untrusted; the kernel re-checks). The skeleton holds a stand-in. -/
def cert : ThetaCert.Cert := sorry

theorem cert_units : cert.units.all (ThetaPlane.unitOk 167 420) = true := sorry -- `decide +kernel`
theorem cert_check : cert.check = true := sorry                                  -- `decide +kernel`, 19.4 CPU s measured

end Sqrt167

/-- **`χ(ℚ(√167)²) ≥ 4`** (row 79 in the kernel): the 36 unit vectors `{1, v, z}·U_R` carry no winding, so the plane
over `ℚ(√167)` has no proper three-colouring. No finite graph is built; standard three axioms, no native purchase. -/
theorem four_le_chromaticNumber_planeOver_sqrt167 :
    4 ≤ ((unitDistance ℂ).induce (planeOver (SquareClass.fieldOfRadicands {167}))).chromaticNumber :=
  ThetaPlane.four_le_chromaticNumber_of_cert (by norm_num) Sqrt167.cert Sqrt167.cert_units Sqrt167.cert_check
    (SquareClass.sqrt_mem_fieldOfRadicands rfl)

end HadwigerNelson

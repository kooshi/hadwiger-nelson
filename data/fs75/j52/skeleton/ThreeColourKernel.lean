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

/-- `3·min_{x ∈ [1/3, 2/3]^m} r·x = Σ_j min(r_j, 2r_j)`: the box minimum, scaled to stay in `ℤ`. -/
def boxMin (r : Fin m → ℤ) : ℤ := ∑ j, min (r j) (2 * r j)

/-- **A winding of `s`**: an additive functional on the relation lattice bounded below by the box — the relation
form of a point of `Θ₃` (for `x ∈ Θ₃`'s relation form, `W r = r·x`), with no real numbers. -/
structure Winding (s : Fin m → A) where
  /-- The functional. -/
  toHom : (relMap s).ker →+ ℤ
  /-- The box bound, `Σ_j min(r_j, 2r_j) ≤ 3·W(r)`. -/
  boxMin_le : ∀ r : (relMap s).ker, boxMin (r : Fin m → ℤ) ≤ 3 * toHom r

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
theorem wsum_word (v : Fin m → ℕ) : wsum s (word v) = ∑ j, v j • s j := sorry

theorem length_word (v : Fin m → ℕ) : (word v).length = ∑ j, v j := sorry

theorem word_add_perm (v v' : Fin m → ℕ) : (word (v + v')).Perm (word v ++ word v') := sorry

-- 1f: the winding of a relation
theorem wind_shift {c} (hc : ProperAlong s c) {u v : Fin m → ℕ} (huv : wsum s (word u) = wsum s (word v))
    (a : A) (l : List (Fin m)) : wind s c (a + wsum s l) u v = wind s c a u v := sorry

theorem wind_add_diag {c} (hc : ProperAlong s c) {u v : Fin m → ℕ} (huv : wsum s (word u) = wsum s (word v))
    (a : A) (t : Fin m → ℕ) : wind s c a (u + t) (v + t) = wind s c a u v := sorry

theorem wind_add {c} (hc : ProperAlong s c) {u v u' v' : Fin m → ℕ}
    (huv : wsum s (word u) = wsum s (word v)) (huv' : wsum s (word u') = wsum s (word v')) (a : A) :
    wind s c a (u + u') (v + v') = wind s c a u v + wind s c a u' v' := sorry

theorem wind_cast {c} (hc : ProperAlong s c) {u v : Fin m → ℕ} (huv : wsum s (word u) = wsum s (word v)) (a : A) :
    ((wind s c a u v : ℤ) : ZMod 3) = 0 := sorry

theorem boxMin_le_wind (r : Fin m → ℤ) (a : A) : boxMin r ≤ wind s c a (posPart r) (negPart r) := sorry

end Lift

/-- **Leaf 1 — the three-colour criterion's ⟹ direction, winding form.** A colouring proper along `s` carries a
winding. No torsion-freeness, no generation hypothesis, no averaging, no compactness. -/
theorem nonempty_winding (s : Fin m → A) {c : A → ZMod 3} (hc : ProperAlong s c) : Nonempty (Winding s) := sorry

/-- The `addCayley` form: a proper 3-colouring of `addCayley (Set.range s)` carries a winding. -/
theorem nonempty_winding_of_colorable (s : Fin m → A) (hs : ∀ j, s j ≠ 0)
    (h : (addCayley (Set.range s)).Colorable 3) : Nonempty (Winding s) := sorry

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
def boxMinL (q : List ℤ) : ℤ := (q.map fun x => min x (2 * x)).sum

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
    decide (3 * P < boxMinL Q)

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

/-! ## §4 Leaf 3: the lattice in the plane over `ℚ(√167)` -/

namespace Sqrt167

open ThreeColour ThetaCert

/-- `F = ℚ(√167)`. -/
noncomputable abbrev F : Subfield ℝ := SquareClass.fieldOfRadicands {167}

/-- `(a, b, c, e) ↦ ((a + b√167)/420, (c + e√167)/420)`, read off the first four coordinates; additive, and not
required to be injective. -/
noncomputable def iota : (ℕ → ℤ) →+ ℂ where
  toFun v := ⟨((v 0 : ℝ) + v 1 * Real.sqrt 167) / 420, ((v 2 : ℝ) + v 3 * Real.sqrt 167) / 420⟩
  map_zero' := sorry
  map_add' := sorry

theorem iota_mem (v : ℕ → ℤ) : iota v ∈ planeOver F := sorry

/-- The two integer identities make a unit vector: `a² + 167b² + c² + 167e² = 420²` and `ab + ce = 0`. -/
theorem norm_iota {v : ℕ → ℤ} (h1 : v 0 ^ 2 + 167 * v 1 ^ 2 + v 2 ^ 2 + 167 * v 3 ^ 2 = 420 ^ 2)
    (h2 : v 0 * v 1 + v 2 * v 3 = 0) : ‖iota v‖ = 1 := sorry

/-- The unit test on one listed vector, as a `Bool`. -/
def unitOk (u : List ℤ) : Bool :=
  u.getD 0 0 ^ 2 + 167 * u.getD 1 0 ^ 2 + u.getD 2 0 ^ 2 + 167 * u.getD 3 0 ^ 2 == 420 ^ 2 &&
    u.getD 0 0 * u.getD 1 0 + u.getD 2 0 * u.getD 3 0 == 0

/-- **T41's 36 vectors** `{1, v, z}·U_R` (18 ± pairs), `v = (83 + i√167)/84` the type-M rotation `n = 42`, and the
1,050-leaf tree of `data/fs73/verify-v2/L21cc6506-sub-1vz-empty.json.gz`, multipliers scaled to integers per leaf.
Emitted by the implementer's `tools/j52k_emit.py`; the skeleton holds a stand-in. -/
def cert167 : Cert := sorry

theorem cert167_units : cert167.units.all unitOk = true := sorry -- `decide +kernel`
theorem cert167_check : cert167.check = true := sorry            -- `decide +kernel`

/-- The pulled-back colouring is proper along the 36 vectors. -/
theorem properAlong_of_colorable (h : ((unitDistance ℂ).induce (planeOver F)).Colorable 3) :
    ∃ col : (ℕ → ℤ) → ZMod 3, ProperAlong cert167.gen col := sorry

end Sqrt167

/-! ## §5 Leaf 4: the headline -/

open Sqrt167 in
/-- **`χ(ℚ(√167)²) ≥ 4`** (row 79 in the kernel): the 36 unit vectors `{1, v, z}·U_R` have no winding, so the plane
over `ℚ(√167)` has no proper three-colouring. No finite graph is built; standard three axioms, no native purchase. -/
theorem four_le_chromaticNumber_planeOver_sqrt167 :
    4 ≤ ((unitDistance ℂ).induce (planeOver (SquareClass.fieldOfRadicands {167}))).chromaticNumber := by
  have key : ¬ ((unitDistance ℂ).induce (planeOver F)).Colorable 3 := fun h => by
    obtain ⟨col, hcol⟩ := properAlong_of_colorable h
    exact cert167.not_properAlong cert167_check col hcol
  simpa using add_one_le_chromaticNumber_iff_not_colorable.mpr key

end HadwigerNelson

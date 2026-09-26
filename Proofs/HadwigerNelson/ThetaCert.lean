import Proofs.HadwigerNelson.ThreeColour
import Mathlib.Algebra.BigOperators.Pi

/-!
# Relation-branching certificates for `Θ₃ = ∅`, checked against windings (FS-75, job J52K)

V2's certificate format (`tools/fs73v2_check.py`; `data/fs73/records/verify-P3b-q167.md` §2), with the leaves' rational
multipliers scaled to integers per leaf (`tools/j52_intcert.py`, an exact transformation). A **branch** names a relation
`r` of the units (an index into the certificate's list) and a range `lo..hi`; its `hi − lo + 3` children carry
`W r ≤ lo − 1`, `W r = k` for `k = lo..hi`, and `W r ≥ hi + 1` (stored as `W(−r) ≤ −(hi + 1)`), in that order. A
**leaf** lists `(path position, integer multiplier)`; with `Q = Σ λ·coef` and `P = Σ λ·rhs` over the cited constraints,
it refutes its path when `3P < Σ_j min(Q_j, 2Q_j)` — because a winding has `Σ_j min(Q_j, 2Q_j) ≤ 3·W(Q) ≤ 3P`. The
checker derives every constraint from `(r, lo, hi)`; the certificate states none.

The soundness theorem `Cert.isEmpty_winding` needs of a winding only what `ThreeColour.Winding` bundles — an additive
functional on the relation lattice with the least-rise bound — never a real point of `Θ₃` (`plans/FS75-kernel-167.md`
§1.3). The tree walk is a pair of mutually structural theorems on the nested `Tree`.

Two guards in the checker are well-formedness only, and the proof does not use them: a leaf position past the path's end
cites the trivially true equation `W 0 = 0`, and a relation index past the list names the empty relation. The sign guard
(non-negative multipliers on inequalities) and the relation check are the ones the proof consumes.

## Main results

* `ThetaCert.Cert.isEmpty_winding` — a passing certificate leaves no winding;
* `ThetaCert.Cert.not_properAlong` — with `ThreeColour.nonempty_winding`: a passing certificate refuses every colouring
  proper along its units;
* `ThetaCert.tinyK4` — the hand-made control `S = {1, 2, 3} ⊂ ℤ` (`K₄`), passing, and three plants, each refused.
-/

namespace HadwigerNelson
namespace ThetaCert

open ThreeColour

/-! ## §1 The format and the checker -/

/-- A constraint on the path, over a winding `W`: `W(coef) ≤ rhs`, or `= rhs` when `isEq`. -/
structure Con where
  /-- The relation, as integer coefficients on the units. -/
  coef : List ℤ
  /-- The bound. -/
  rhs : ℤ
  /-- An equation, not an inequality. -/
  isEq : Bool
  deriving Repr, DecidableEq

/-- V2's tree. A branch names a relation (an index into the certificate's list) and `lo..hi`; its `hi − lo + 3`
children carry `W r ≤ lo − 1`, `W r = k` (`k = lo..hi`), `W r ≥ hi + 1`, in that order. A leaf lists
`(path position, integer multiplier)`, positions counted from the root. -/
inductive Tree where
  /-- Branch on the value of the winding at relation number `rel`, over `lo..hi`. -/
  | branch (rel : ℕ) (lo hi : ℤ) (kids : List Tree)
  /-- Refute the path by the listed `(position, multiplier)` pairs. -/
  | leaf (mults : List (ℕ × ℤ))
  deriving Repr

/-- Untrusted data: the generators as integer vectors (read as `ℕ → ℤ`, zero beyond each list), the relations, the
tree. -/
structure Cert where
  /-- The generators. -/
  units : List (List ℤ)
  /-- The relations the tree branches on. -/
  rels : List (List ℤ)
  /-- The tree. -/
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

/-- The constraint a leaf cites at position `i`: the path's entry, or past its end the true equation `W 0 = 0`. -/
def cite (path : List Con) (i : ℕ) : Con := path.getD i ⟨[], 0, true⟩

/-- A leaf's combined coefficients `Q = Σ λ·coef`. -/
def leafQ (path : List Con) (mults : List (ℕ × ℤ)) : List ℤ :=
  mults.foldr (fun pm acc => addL (smulL pm.2 (cite path pm.1).coef) acc) []

/-- A leaf's combined bound `P = Σ λ·rhs`. -/
def leafP (path : List Con) (mults : List (ℕ × ℤ)) : ℤ := (mults.map fun pm => pm.2 * (cite path pm.1).rhs).sum

/-- A leaf refutes its path: valid positions, non-negative multipliers on inequalities, and
`Σ_j min(Q_j, 2Q_j) > 3P` for `Q = Σ λ·coef`, `P = Σ λ·rhs`. -/
def leafOk (path : List Con) (mults : List (ℕ × ℤ)) : Bool :=
  mults.all (fun pm => decide (pm.1 < path.length) && ((cite path pm.1).isEq || decide (0 ≤ pm.2))) &&
    decide (3 * leafP path mults < minRiseL (leafQ path mults))

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

/-! ## §2 Lists as vectors -/

/-- A list read as a vector on `Fin m`, zero beyond its end. -/
def vecOf {m : ℕ} (l : List ℤ) : Fin m → ℤ := fun j => l.getD j 0

/-- A property of every entry and of the default holds of every `getD`. -/
theorem getD_induction {α : Type*} {p : α → Prop} {l : List α} {d : α} (hl : ∀ x ∈ l, p x) (hd : p d) (i : ℕ) :
    p (l.getD i d) := by
  rw [List.getD_eq_getElem?_getD]
  cases h : l[i]? with
  | none => exact hd
  | some x => exact hl x (List.mem_of_getElem? h)

theorem getD_addL : ∀ (l l' : List ℤ) (k : ℕ), (addL l l').getD k 0 = l.getD k 0 + l'.getD k 0
  | [], l, k => by simp [addL]
  | a :: l, [], k => by simp [addL]
  | a :: l, b :: l', 0 => by simp [addL]
  | a :: l, b :: l', k + 1 => by simp only [addL, List.getD_cons_succ]; exact getD_addL l l' k

theorem getD_smulL (k : ℤ) : ∀ (l : List ℤ) (j : ℕ), (smulL k l).getD j 0 = k * l.getD j 0
  | [], j => by simp [smulL]
  | a :: l, 0 => by simp [smulL]
  | a :: l, j + 1 => by simpa [smulL] using getD_smulL k l j

theorem length_addL_le {m : ℕ} : ∀ {l l' : List ℤ}, l.length ≤ m → l'.length ≤ m → (addL l l').length ≤ m
  | [], _, _, h' => by simpa [addL] using h'
  | _ :: _, [], h, _ => by simpa [addL] using h
  | a :: l, b :: l', h, h' => by
    simp only [addL, List.length_cons] at h h' ⊢
    have := length_addL_le (m := m - 1) (l := l) (l' := l') (by omega) (by omega)
    omega

@[simp] theorem length_smulL (k : ℤ) (l : List ℤ) : (smulL k l).length = l.length := by simp [smulL]

variable {m : ℕ}

@[simp] theorem vecOf_nil : (vecOf [] : Fin m → ℤ) = 0 := by funext j; simp [vecOf]

theorem vecOf_addL (l l' : List ℤ) : (vecOf (addL l l') : Fin m → ℤ) = vecOf l + vecOf l' := by
  funext j; exact getD_addL l l' j

theorem vecOf_smulL (k : ℤ) (l : List ℤ) : (vecOf (smulL k l) : Fin m → ℤ) = k • vecOf l := by
  funext j; exact getD_smulL k l j

/-- On a list no longer than `m`, the list and vector least rises agree. -/
theorem minRiseL_eq : ∀ {m : ℕ} {q : List ℤ}, q.length ≤ m → minRiseL q = minRise (vecOf q : Fin m → ℤ)
  | m, [], _ => by simp [minRiseL, minRise, vecOf]
  | 0, _ :: _, h => by simp at h
  | m + 1, x :: q, h => by
    rw [minRise, Fin.sum_univ_succ]
    simp only [List.length_cons, Nat.add_le_add_iff_right] at h
    have ih := minRiseL_eq (m := m) h
    simp only [minRise] at ih
    simp only [minRiseL, List.map_cons, List.sum_cons, vecOf, Fin.val_zero, List.getD_cons_zero, Fin.val_succ,
      List.getD_cons_succ] at ih ⊢
    rw [ih]

/-- `Σ_j r_j · (u_j)_k` over the listed units is the `k`-th entry of `lincomb`. -/
theorem sum_getD_lincomb : ∀ (r : List ℤ) (us : List (List ℤ)) (k : ℕ),
    ∑ j : Fin us.length, r.getD j 0 * (us.getD j []).getD k 0 = (lincomb r us).getD k 0
  | r, [], k => by cases r <;> simp [lincomb]
  | [], u :: us, k => by simp [lincomb]
  | x :: r, u :: us, k => by
    rw [List.length_cons, Fin.sum_univ_succ]
    simp only [Fin.val_zero, List.getD_cons_zero, Fin.val_succ, List.getD_cons_succ, lincomb, getD_addL,
      getD_smulL, sum_getD_lincomb r us k]

/-- A checked relation lies in the relation lattice of `Cert.gen`. -/
theorem relMap_vecOf (c : Cert) (r : List ℤ) (k : ℕ) :
    relMap c.gen (vecOf r) k = (lincomb r c.units).getD k 0 := by
  rw [← sum_getD_lincomb]
  simp [relMap, Finset.sum_apply, Cert.gen, vecOf]

/-! ## §3 Soundness -/

variable {A : Type*} [AddCommGroup A] {s : Fin m → A}

open Classical in
/-- A winding read as a total function: zero off the relation lattice. -/
noncomputable def _root_.HadwigerNelson.ThreeColour.Winding.eval (W : Winding s) (r : Fin m → ℤ) : ℤ :=
  if h : r ∈ (relMap s).ker then W.toHom ⟨r, h⟩ else 0

namespace Soundness

variable (W : Winding s)

theorem eval_zero : W.eval 0 = 0 := by
  rw [Winding.eval, dif_pos (zero_mem _)]; exact map_zero W.toHom

theorem eval_add {u v : Fin m → ℤ} (hu : u ∈ (relMap s).ker) (hv : v ∈ (relMap s).ker) :
    W.eval (u + v) = W.eval u + W.eval v := by
  rw [Winding.eval, Winding.eval, Winding.eval, dif_pos (add_mem hu hv), dif_pos hu, dif_pos hv]
  exact map_add W.toHom ⟨u, hu⟩ ⟨v, hv⟩

theorem eval_smul (k : ℤ) {v : Fin m → ℤ} (hv : v ∈ (relMap s).ker) : W.eval (k • v) = k * W.eval v := by
  rw [Winding.eval, Winding.eval, dif_pos (AddSubgroup.zsmul_mem _ hv k), dif_pos hv]
  exact map_zsmul W.toHom k ⟨v, hv⟩

theorem minRise_le_eval {v : Fin m → ℤ} (hv : v ∈ (relMap s).ker) : minRise v ≤ 3 * W.eval v := by
  rw [Winding.eval, dif_pos hv]; exact W.minRise_le ⟨v, hv⟩

/-- A constraint that holds for `W`: its coefficients are a relation no longer than `m`, and its bound holds. -/
def Holds (con : Con) : Prop :=
  vecOf con.coef ∈ (relMap s).ker ∧ con.coef.length ≤ m ∧ W.eval (vecOf con.coef) ≤ con.rhs ∧
    (con.isEq = true → W.eval (vecOf con.coef) = con.rhs)

theorem holds_dflt : Holds W ⟨[], 0, true⟩ := by
  refine ⟨?_, by simp, ?_, fun _ => ?_⟩ <;> simp [eval_zero]

theorem holds_cite {path : List Con} (hp : ∀ con ∈ path, Holds W con) (i : ℕ) : Holds W (cite path i) :=
  getD_induction hp (holds_dflt W) i

/-- **The leaf, one induction with a tupled conclusion**: `Q` is a relation, no longer than `m`, with `W Q ≤ P`. -/
theorem leaf_bound {path : List Con} (hp : ∀ con ∈ path, Holds W con) : ∀ mults : List (ℕ × ℤ),
    (∀ pm ∈ mults, (cite path pm.1).isEq = true ∨ 0 ≤ pm.2) →
    vecOf (leafQ path mults) ∈ (relMap s).ker ∧ (leafQ path mults).length ≤ m ∧
      W.eval (vecOf (leafQ path mults)) ≤ leafP path mults
  | [], _ => by simp [leafQ, leafP, eval_zero]
  | pm :: ms, hs => by
    obtain ⟨hk, hl, hle⟩ := leaf_bound hp ms fun q hq => hs q (List.mem_cons_of_mem _ hq)
    obtain ⟨hck, hcl, hcle, hceq⟩ := holds_cite W hp pm.1
    have hq : leafQ path (pm :: ms) = addL (smulL pm.2 (cite path pm.1).coef) (leafQ path ms) := rfl
    have hP : leafP path (pm :: ms) = pm.2 * (cite path pm.1).rhs + leafP path ms := by simp [leafP]
    have hsm : (vecOf (smulL pm.2 (cite path pm.1).coef) : Fin m → ℤ) ∈ (relMap s).ker := by
      rw [vecOf_smulL]; exact AddSubgroup.zsmul_mem _ hck _
    refine ⟨?_, ?_, ?_⟩
    · rw [hq, vecOf_addL]; exact add_mem hsm hk
    · rw [hq]; exact length_addL_le (by simpa using hcl) hl
    · rw [hq, hP, vecOf_addL, eval_add W hsm hk, vecOf_smulL, eval_smul W _ hck]
      have hmul : pm.2 * W.eval (vecOf (cite path pm.1).coef) ≤ pm.2 * (cite path pm.1).rhs := by
        rcases hs pm (List.mem_cons_self ..) with h | h
        · rw [hceq h]
        · exact mul_le_mul_of_nonneg_left hcle h
      omega

/-- A leaf that passes refutes every path whose constraints hold. -/
theorem leafOk_sound {path : List Con} (hp : ∀ con ∈ path, Holds W con) {mults : List (ℕ × ℤ)}
    (h : leafOk path mults = true) : False := by
  simp only [leafOk, Bool.and_eq_true, List.all_eq_true, decide_eq_true_eq, Bool.or_eq_true] at h
  obtain ⟨hs, hlt⟩ := h
  obtain ⟨hk, hl, hle⟩ := leaf_bound W hp mults fun pm hpm => (hs pm hpm).2
  have := minRise_le_eval W hk
  rw [← minRiseL_eq hl] at this
  omega

theorem mem_eqRun (r : List ℤ) : ∀ (n : ℕ) (k t : ℤ), k ≤ t → t < k + n → (⟨r, t, true⟩ : Con) ∈ eqRun r k n
  | 0, k, t, h1, h2 => by omega
  | n + 1, k, t, h1, h2 => by
    rcases eq_or_lt_of_le h1 with rfl | h1
    · exact List.mem_cons_self ..
    · exact List.mem_cons_of_mem _ (mem_eqRun r n (k + 1) t (by omega) (by push_cast at h2; omega))

/-- **Coverage**: for a relation `r`, some child constraint of a branch on `r` holds, whatever `lo` and `hi`. -/
theorem exists_holds_childCons {r : List ℤ} (hr : vecOf r ∈ (relMap s).ker) (hl : r.length ≤ m) (lo hi : ℤ) :
    ∃ con ∈ childCons r lo hi, Holds W con := by
  set t := W.eval (vecOf r)
  have hneg : (vecOf (smulL (-1) r) : Fin m → ℤ) ∈ (relMap s).ker := by
    rw [vecOf_smulL]; exact AddSubgroup.zsmul_mem _ hr _
  by_cases h1 : t ≤ lo - 1
  · exact ⟨_, List.mem_cons_self .., hr, hl, h1, fun h => by simp at h⟩
  by_cases h2 : hi + 1 ≤ t
  · refine ⟨_, List.mem_cons_of_mem _ (List.mem_append_right _ (List.mem_singleton_self _)), hneg, by simpa using hl,
      ?_, fun h => by simp at h⟩
    dsimp only
    rw [vecOf_smulL, eval_smul W _ hr]; omega
  · refine ⟨⟨r, t, true⟩, List.mem_cons_of_mem _ (List.mem_append_left _ (mem_eqRun r _ lo t (by omega) ?_)),
      hr, hl, le_rfl, fun _ => rfl⟩
    rw [Int.toNat_of_nonneg (by omega)]; omega

variable {rels : List (List ℤ)}

mutual
/-- **The walk**: a passing tree refutes every path whose constraints hold. -/
theorem checkTree_sound (hrels : ∀ r ∈ rels, vecOf r ∈ (relMap s).ker ∧ r.length ≤ m) : ∀ (t : Tree) (path : List Con), (∀ con ∈ path, Holds W con) →
    checkTree rels path t = true → False
  | .leaf mults, path, hp, h => leafOk_sound W hp (by simpa [checkTree] using h)
  | .branch ri lo hi kids, path, hp, h => by
    simp only [checkTree, Bool.and_eq_true] at h
    obtain ⟨hr, hl⟩ := getD_induction (p := fun r : List ℤ => vecOf r ∈ (relMap s).ker ∧ r.length ≤ m) (d := [])
      hrels (by simp) ri
    exact checkKids_sound hrels kids path _ hp (exists_holds_childCons W hr hl lo hi) h.2
  termination_by structural t => t
/-- Children against constraints, pairwise: if one of the remaining constraints holds, the remaining children refute. -/
theorem checkKids_sound (hrels : ∀ r ∈ rels, vecOf r ∈ (relMap s).ker ∧ r.length ≤ m) : ∀ (kids : List Tree) (path cons : List Con), (∀ con ∈ path, Holds W con) →
    (∃ con ∈ cons, Holds W con) → checkKids rels path kids cons = true → False
  | [], _, [], _, ⟨_, hmem, _⟩, _ => by simp at hmem
  | [], _, _ :: _, _, _, h => by simp [checkKids] at h
  | _ :: _, _, [], _, _, h => by simp [checkKids] at h
  | k :: ks, path, con :: cons, hp, ⟨con', hmem, hcon'⟩, h => by
    simp only [checkKids, Bool.and_eq_true] at h
    rcases List.mem_cons.mp hmem with rfl | hmem
    · refine checkTree_sound hrels k (path ++ [con']) ?_ h.1
      intro x hx
      rcases List.mem_append.mp hx with hx | hx
      · exact hp x hx
      · rw [List.mem_singleton.mp hx]; exact hcon'
    · exact checkKids_sound hrels ks path cons hp ⟨con', hmem, hcon'⟩ h.2
  termination_by structural kids => kids
end

end Soundness

/-- **Leaf 2 — soundness.** A passing certificate leaves no winding. -/
theorem Cert.isEmpty_winding (c : Cert) (h : c.check = true) : IsEmpty (Winding c.gen) := by
  refine ⟨fun W => ?_⟩
  simp only [Cert.check, Bool.and_eq_true, List.all_eq_true, decide_eq_true_eq] at h
  obtain ⟨hrels, htree⟩ := h
  refine Soundness.checkTree_sound W (rels := c.rels) (fun r hr => ⟨?_, (hrels r hr).1⟩) c.tree [] (by simp) htree
  have hz : ∀ k, (lincomb r c.units).getD k 0 = 0 :=
    getD_induction (p := (· = 0)) (fun x hx => by simpa using (hrels r hr).2 x hx) rfl
  exact funext fun k => (relMap_vecOf c r k).trans (hz k)

/-- Leaves 1 + 2: a passing certificate refuses every colouring proper along its units. -/
theorem Cert.not_properAlong (c : Cert) (h : c.check = true) (col : (ℕ → ℤ) → ZMod 3) :
    ¬ ProperAlong c.gen col := fun hc => (c.isEmpty_winding h).false (nonempty_winding c.gen hc).some

/-! ## §4 The control and its plants -/

/-- **The control** (hand-made, `plans/FS75-kernel-167.md` §S): `S = {1, 2, 3}` in `ℤ` — `K₄` on `0..3`, not
3-colourable — refused by a five-leaf tree on the relations `(3, 0, −1)`, `(2, −1, 0)`. -/
def tinyK4 : Cert where
  units := [[1], [2], [3]]
  rels := [[3, 0, -1], [2, -1, 0]]
  tree := .branch 0 1 1
    [.leaf [(0, 1)],
     .branch 1 0 1 [.leaf [(1, 1)], .leaf [(0, -2), (1, 3)], .leaf [(0, 2), (1, -3)], .leaf [(1, 1)]],
     .leaf [(0, 1)]]

example : tinyK4.check = true := by decide +kernel

/-- `{1, 2, 3} ⊂ ℤ` has no winding. -/
theorem tinyK4_isEmpty_winding : IsEmpty (Winding tinyK4.gen) := tinyK4.isEmpty_winding (by decide +kernel)

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

/-! ### Spec examples, one per definition -/

example : addL [1, 2] [10] = [11, 2] ∧ addL [] [5] = [5] := by decide
example : smulL (-2) [1, 3] = [-2, -6] := by decide
example : lincomb [3, 0, -1] [[1], [2], [3]] = [0] ∧ lincomb [1, 1] [[1, 0], [0, 1]] = [1, 1] := by decide
example : minRiseL [2, -1, 0] = 0 := by decide
example : eqRun [1] 0 2 = [⟨[1], 0, true⟩, ⟨[1], 1, true⟩] := by decide
example : childCons [1] 0 0 = [⟨[1], -1, false⟩, ⟨[1], 0, true⟩, ⟨[-1], -1, false⟩] := by decide
example : cite [⟨[1], 5, false⟩] 0 = ⟨[1], 5, false⟩ ∧ cite [] 3 = ⟨[], 0, true⟩ := by decide
example : leafQ [⟨[1, 2], 5, false⟩] [(0, 2)] = [2, 4] ∧ leafP [⟨[1, 2], 5, false⟩] [(0, 2)] = 10 := by decide
example : leafOk [⟨[1], -1, false⟩] [(0, 1)] = true ∧ leafOk [⟨[1], 1, false⟩] [(0, 1)] = false := by decide
example : checkTree [[1]] [] (.leaf []) = false ∧ checkKids [] [] [] [] = true := by decide
example : tinyK4.gen ⟨2, by decide⟩ 0 = 3 ∧ tinyK4.gen ⟨2, by decide⟩ 1 = 0 := by decide
example : (vecOf [4, 5] : Fin 3 → ℤ) = ![4, 5, 0] := by decide

end ThetaCert
end HadwigerNelson

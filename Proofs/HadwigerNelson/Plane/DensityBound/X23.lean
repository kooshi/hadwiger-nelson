import Proofs.HadwigerNelson.Plane.DensityBound.Pattern
import Proofs.HadwigerNelson.Plane.DensityBound.X23All

/-!
# `[AmbrusEtAl2023]`'s certificate as a `DualCert`, and its validity (FS-131, FS131-IDB3)

`X23 : DualCert 23` is the paper's certificate: the 23 points of Table 1 (`xᵢ = Pᵢ/12`, `Pᵢ` with integer coordinates in
`1, √3, √11, √33`), `w₁` (nonzero only at the paper's point 1), the 26 `w₂` rows and the 2,321 `w_C` rows of `g23.csv` at
scale `10²¹` (exact: one `w_C` row has 21 decimals), and `bound = w_T + ν`, `ν = 10⁻⁵` (p. 16). The data are the generated
modules' (`X23Data`, read by the core-only checker `X23Check`); this module gives the checker's computations their meaning
and proves `X23_valid`:

* `cong`: each row's isometry `z ↦ (U/m)·(b ? z̄ : z) + V/(12m)` (`rowOk`) carries `X|I` onto `X|J` (`congruent_of_rowOk`);
* `atoms`: an independent `S` contains no listed edge (a listed edge has length one, `dist_of_adj`), so the DFS reaches its
  mask (`collect_sound`), whose leaf test bounds the sum of the terms in it, which is `L(S)·10²¹` (`gval_terms`, `L_eq`).

Record: `plans/FS131-IDB3-implementation.md`.
-/

namespace HadwigerNelson.DensityBound

open X23Check

namespace X23Check

/-! ### The field `ℚ(√3, √11)` and its complex pairs -/

/-- `a + b√3 + c√11 + d√3√11`. -/
noncomputable def ev (x : Q4) : ℝ := x.a + x.b * √3 + x.c * √11 + x.d * (√3 * √11)

theorem ev_add (x y : Q4) : ev (x.add y) = ev x + ev y := by
  simp only [ev, Q4.add]; push_cast; ring

theorem ev_sub (x y : Q4) : ev (x.sub y) = ev x - ev y := by
  simp only [ev, Q4.sub]; push_cast; ring

theorem ev_neg (x : Q4) : ev x.neg = -ev x := by
  simp only [ev, Q4.neg]; push_cast; ring

theorem ev_smul (m : ℤ) (x : Q4) : ev (x.smul m) = m * ev x := by
  simp only [ev, Q4.smul]; push_cast; ring

theorem ev_ofInt (n : ℤ) : ev (Q4.ofInt n) = n := by
  simp [ev, Q4.ofInt]

theorem ev_mul (x y : Q4) : ev (x.mul y) = ev x * ev y := by
  have h3 : √3 ^ 2 = 3 := Real.sq_sqrt (by norm_num)
  have h11 : √11 ^ 2 = 11 := Real.sq_sqrt (by norm_num)
  obtain ⟨a, b, c, d⟩ := x
  obtain ⟨e, f, g, h⟩ := y
  simp only [ev, Q4.mul]
  push_cast
  linear_combination (-((b : ℝ) * f + d * h * √11 ^ 2 + b * h * √11 + d * f * √11)) * h3 +
    (-((c : ℝ) * g + 3 * d * h + c * h * √3 + d * g * √3)) * h11

theorem Q4.eq_of_beq {x y : Q4} (h : x.beq y = true) : x = y := by
  obtain ⟨a, b, c, d⟩ := x
  obtain ⟨e, f, g, k⟩ := y
  simp only [Q4.beq, Bool.and_eq_true, beq_iff_eq] at h
  obtain ⟨⟨⟨rfl, rfl⟩, rfl⟩, rfl⟩ := h
  rfl

theorem C4.eq_of_beq {x y : C4} (h : x.beq y = true) : x = y := by
  obtain ⟨xr, xi⟩ := x
  obtain ⟨yr, yi⟩ := y
  simp only [C4.beq, Bool.and_eq_true] at h
  rw [Q4.eq_of_beq h.1, Q4.eq_of_beq h.2]

/-- The complex number a `C4` names. -/
noncomputable def toC (p : C4) : ℂ := ⟨ev p.re, ev p.im⟩

theorem toC_add (x y : C4) : toC (x.add y) = toC x + toC y := by
  apply Complex.ext <;> simp [toC, C4.add, ev_add]

theorem toC_sub (x y : C4) : toC (x.sub y) = toC x - toC y := by
  apply Complex.ext <;> simp [toC, C4.sub, ev_sub]

theorem toC_mul (x y : C4) : toC (x.mul y) = toC x * toC y := by
  apply Complex.ext <;> simp [toC, C4.mul, ev_sub, ev_add, ev_mul]

theorem toC_smul (m : ℤ) (x : C4) : toC (x.smul m) = (m : ℂ) * toC x := by
  apply Complex.ext <;> simp [toC, C4.smul, ev_smul]

theorem toC_cond (b : Bool) (x : C4) :
    toC (x.cond b) = if b then (starRingEnd ℂ) (toC x) else toC x := by
  cases b
  · rfl
  · apply Complex.ext <;> simp [toC, C4.cond, C4.conj, ev_neg]

theorem normSq_toC (x : C4) : Complex.normSq (toC x) = ev x.normSq := by
  simp [Complex.normSq_apply, toC, C4.normSq, ev_add, ev_mul]

/-! ### The points -/

/-- The point `xᵢ = Pᵢ/12` of the certificate (0-based). -/
noncomputable def X23pt (i : Fin 23) : ℂ := toC (pt ptsL i) / 12

/-- The points named by a list of indices. -/
def finsetOf (I : List ℕ) : Finset (Fin 23) := (I.map (Fin.ofNat 23)).toFinset

theorem mem_finsetOf {I : List ℕ} (hI : ∀ i ∈ I, i < 23) (x : Fin 23) : x ∈ finsetOf I ↔ (x : ℕ) ∈ I := by
  simp only [finsetOf, List.mem_toFinset, List.mem_map]
  constructor
  · rintro ⟨i, hi, rfl⟩
    rw [Fin.val_ofNat, Nat.mod_eq_of_lt (hI i hi)]
    exact hi
  · intro hx
    exact ⟨x, hx, Fin.ext (by rw [Fin.val_ofNat, Nat.mod_eq_of_lt x.2])⟩

/-- `|Pᵢ − Pⱼ|² = 144` makes `xᵢ`, `xⱼ` a unit pair. -/
theorem dist_of_sqd {p q : C4} (h : (sqd p q).beq (Q4.ofInt 144) = true) : dist (toC p / 12) (toC q / 12) = 1 := by
  have hq := Q4.eq_of_beq h
  rw [dist_eq_norm, ← sub_div, norm_div, ← toC_sub, Complex.norm_def, normSq_toC]
  simp only [sqd] at hq
  rw [hq, ev_ofInt]
  have : √((144 : ℤ) : ℝ) = 12 := by
    rw [show ((144 : ℤ) : ℝ) = 12 ^ 2 by norm_num, Real.sqrt_sq (by norm_num)]
  rw [this]
  norm_num

/-- A bit of a vertex's adjacency mask is a listed unit pair. -/
theorem dist_of_adj {w u : ℕ} (hw : w < 23) (hu : u < 23) (h : ((vertsL.getD w (0, [])).1).testBit u = true) :
    dist (X23pt ⟨w, hw⟩) (X23pt ⟨u, hu⟩) = 1 := by
  have := adj_ok
  simp only [adjOk, List.all_eq_true, List.mem_range] at this
  have h' := this w hw u hu
  rw [h] at h'
  simp only [Bool.not_true, Bool.false_or] at h'
  exact dist_of_sqd h'

/-! ### Bits -/

theorem testBit_maskL (I : List ℕ) (k : ℕ) : (maskL I).testBit k = true ↔ k ∈ I := by
  induction I with
  | nil => simp [maskL]
  | cons i I ih =>
    simp only [maskL, Nat.testBit_or, Bool.or_eq_true, ih, Nat.testBit_two_pow, decide_eq_true_eq,
      List.mem_cons]
    tauto

/-- The mask of a set of points. -/
def maskOf (S : Finset (Fin 23)) : ℕ := maskL (((List.finRange 23).filter (· ∈ S)).map Fin.val)

theorem testBit_maskOf (S : Finset (Fin 23)) (k : ℕ) : (maskOf S).testBit k = true ↔ ∃ x ∈ S, (x : ℕ) = k := by
  simp [maskOf, testBit_maskL]

theorem land_eq_self_iff (m U : ℕ) : m &&& U = m ↔ ∀ k, m.testBit k = true → U.testBit k = true := by
  constructor
  · intro h k hk
    rw [← h, Nat.testBit_and, Bool.and_eq_true] at hk
    exact hk.2
  · intro h
    apply Nat.eq_of_testBit_eq
    intro k
    rw [Nat.testBit_and]
    cases hm : m.testBit k
    · rfl
    · rw [h k hm]; rfl

theorem maskL_sub_iff {I : List ℕ} (hI : ∀ i ∈ I, i < 23) (S : Finset (Fin 23)) :
    maskL I &&& maskOf S = maskL I ↔ finsetOf I ⊆ S := by
  rw [land_eq_self_iff]
  constructor
  · intro h x hx
    rw [mem_finsetOf hI] at hx
    obtain ⟨y, hy, hyx⟩ := (testBit_maskOf S x).1 (h x ((testBit_maskL I x).2 hx))
    rwa [← Fin.ext hyx]
  · intro h k hk
    rw [testBit_maskL] at hk
    exact (testBit_maskOf S k).2 ⟨⟨k, hI k hk⟩, h ((mem_finsetOf hI _).2 hk), rfl⟩

/-! ### Terms -/

theorem tval_pack {m : ℕ} {c : ℤ} (h : termOk m c = true) (U : ℕ) :
    tval U (pack m c) = if m &&& U = m then c else 0 := by
  simp only [termOk, Bool.and_eq_true, beq_iff_eq, decide_eq_true_eq] at h
  obtain ⟨h1, h2⟩ := h
  simp only [tval, h1, h2]
  by_cases hm : m &&& U = m
  · rw [if_pos hm, beq_iff_eq.2 hm]; rfl
  · rw [if_neg hm, beq_eq_false_iff_ne.2 hm]; rfl

/-- The terms of a group summed on `U`. -/
def gval (U : ℕ) (g : List ℕ) : ℤ := (g.map (tval U)).sum

theorem addGroup_eq (U : ℕ) : ∀ (g : List ℕ) (a : ℤ), addGroup U g a = a + gval U g
  | [], a => by simp [addGroup, gval]
  | t :: g, a => by
    rw [addGroup, addGroup_eq U g]
    simp only [gval, List.map_cons, List.sum_cons]
    ring

/-! ### The DFS -/

/-- The DFS's refusals hold on the final set `U`: a point in `U` has no adjacency bit on a lower point of `U`. -/
def Pass : List (ℕ × List ℕ) → ℕ → ℕ → Prop
  | [], _, _ => True
  | (a, _) :: vs, v, U => (U.testBit v = true → ∀ j < v, U.testBit j = true → a.testBit j = false) ∧ Pass vs (v + 1) U

/-- Every term of vertex `v + k`'s group has highest point `v + k`. -/
def GroupsOk : List (ℕ × List ℕ) → ℕ → Prop
  | [], _ => True
  | (_, g) :: vs, v => (∀ t ∈ g, inGroup v t = true) ∧ GroupsOk vs (v + 1)

/-- The sum of all groups' terms on `U`. -/
def tot (U : ℕ) : List (ℕ × List ℕ) → ℤ
  | [] => 0
  | (_, g) :: vs => gval U g + tot U vs

theorem testBit_of_inGroup {v t : ℕ} (h : inGroup v t = true) :
    (t % M23).testBit v = true ∧ ∀ j, v < j → (t % M23).testBit j = false := by
  simp only [inGroup, beq_iff_eq] at h
  constructor
  · have := Nat.testBit_shiftRight (i := v) (j := 0) (t % M23)
    rw [h, Nat.add_zero] at this
    rw [← this]; rfl
  · intro j hj
    have := Nat.testBit_shiftRight (i := v) (j := j - v) (t % M23)
    rw [h, Nat.add_sub_cancel' hj.le] at this
    rw [← this]
    obtain ⟨k, hk⟩ : ∃ k, j - v = k + 1 := ⟨j - v - 1, by omega⟩
    rw [hk, Nat.testBit_succ, show (1 : ℕ) / 2 = 0 from rfl, Nat.zero_testBit]

theorem gval_eq_zero {v : ℕ} {g : List ℕ} (hg : ∀ t ∈ g, inGroup v t = true) {U : ℕ} (hU : U.testBit v = false) :
    gval U g = 0 := by
  have : ∀ t ∈ g, tval U t = 0 := by
    intro t ht
    have hb := (testBit_of_inGroup (hg t ht)).1
    have hne : (t % M23 &&& U == t % M23) = false := by
      rw [beq_eq_false_iff_ne]
      intro he
      have := ((land_eq_self_iff _ _).1 he v hb)
      rw [hU] at this
      exact Bool.false_ne_true this
    simp [tval, hne]
  simp only [gval]
  rw [List.map_congr_left this]
  simp

theorem gval_congr {v : ℕ} {g : List ℕ} (hg : ∀ t ∈ g, inGroup v t = true) {U U' : ℕ}
    (hU : ∀ j ≤ v, U.testBit j = U'.testBit j) : gval U g = gval U' g := by
  have : ∀ t ∈ g, tval U t = tval U' t := by
    intro t ht
    have hb := (testBit_of_inGroup (hg t ht)).2
    have hiff : (t % M23 &&& U == t % M23) = (t % M23 &&& U' == t % M23) := by
      have key : t % M23 &&& U = t % M23 ↔ t % M23 &&& U' = t % M23 := by
        rw [land_eq_self_iff, land_eq_self_iff]
        constructor
        · intro h k hk
          have hkv : k ≤ v := by
            by_contra hc
            rw [hb k (by omega)] at hk
            exact Bool.false_ne_true hk
          rw [← hU k hkv]; exact h k hk
        · intro h k hk
          have hkv : k ≤ v := by
            by_contra hc
            rw [hb k (by omega)] at hk
            exact Bool.false_ne_true hk
          rw [hU k hkv]; exact h k hk
      by_cases h1 : t % M23 &&& U = t % M23
      · rw [beq_iff_eq.2 h1, beq_iff_eq.2 (key.1 h1)]
      · rw [beq_eq_false_iff_ne.2 h1, beq_eq_false_iff_ne.2 (fun h => h1 (key.2 h))]
    simp only [tval, hiff]
  simp only [gval]
  rw [List.map_congr_left this]

theorem dfsG_eq_all (leaf : ℕ → ℤ → Bool) :
    ∀ (vs : List (ℕ × List ℕ)) (v S : ℕ) (acc : ℤ),
      dfsG leaf vs v S acc = (collect vs v S acc).all (fun p => leaf p.1 p.2)
  | [], v, S, acc => by simp [dfsG, collect]
  | (a, g) :: vs, v, S, acc => by
    simp only [dfsG, collect, List.all_append, dfsG_eq_all leaf vs]
    cases (a &&& S != 0) <;> simp

theorem dfsG_append (leaf : ℕ → ℤ → Bool) :
    ∀ (vsA vsB : List (ℕ × List ℕ)) (v S : ℕ) (acc : ℤ),
      dfsG leaf (vsA ++ vsB) v S acc = dfsG (fun S acc => dfsG leaf vsB (v + vsA.length) S acc) vsA v S acc
  | [], vsB, v, S, acc => by simp [dfsG]
  | (a, g) :: vsA, vsB, v, S, acc => by
    have hl : v + 1 + vsA.length = v + ((a, g) :: vsA).length := by simp; omega
    simp only [List.cons_append, dfsG, dfsG_append leaf vsA vsB, hl]

theorem collect_sound : ∀ (vs : List (ℕ × List ℕ)) (v S : ℕ) (acc : ℤ) (T : ℕ), GroupsOk vs v →
    (∀ k, S.testBit k = true → k < v) → (∀ k, T.testBit k = true → v ≤ k ∧ k < v + vs.length) →
    Pass vs v (S ||| T) → (S ||| T, acc + tot (S ||| T) vs) ∈ collect vs v S acc
  | [], v, S, acc, T, _, _, hT, _ => by
    have hT0 : T = 0 := Nat.eq_of_testBit_eq fun k => by
      rw [Nat.zero_testBit]
      by_contra h
      have := hT k (by simpa using h)
      simp at this; omega
    subst hT0
    simp [collect, tot]
  | (a, g) :: vs, v, S, acc, T, hG, hS, hT, hP => by
    obtain ⟨hG1, hG2⟩ := hG
    obtain ⟨hP1, hP2⟩ := hP
    rw [collect]
    by_cases hTv : T.testBit v = true
    · -- `v` is in
      set S' := S ||| 2 ^ v
      set T' := T ^^^ 2 ^ v
      have hST : S' ||| T' = S ||| T := by
        apply Nat.eq_of_testBit_eq
        intro k
        simp only [S', T', Nat.testBit_or, Nat.testBit_xor, Nat.testBit_two_pow]
        by_cases hk : v = k
        · subst hk; simp [hTv]
        · simp [hk]
      have hUv : (S ||| T).testBit v = true := by simp [Nat.testBit_or, hTv]
      have haS : (a &&& S != 0) = false := by
        have : a &&& S = 0 := Nat.eq_of_testBit_eq fun k => by
          rw [Nat.testBit_and, Nat.zero_testBit]
          cases hSk : S.testBit k
          · simp
          · have hk := hS k hSk
            have := hP1 hUv k hk (by simp [Nat.testBit_or, hSk])
            simp [this]
        simp [this]
      rw [haS]
      apply List.mem_append_right
      simp only [cond_false]
      have hagree : ∀ j ≤ v, (S ||| T).testBit j = S'.testBit j := by
        intro j hj
        simp only [S', Nat.testBit_or, Nat.testBit_two_pow]
        by_cases hjv : j = v
        · subst hjv; simp [hTv]
        · have hTj : T.testBit j = false := by
            by_contra h
            have := (hT j (by simpa using h)).1
            omega
          simp [hTj, Ne.symm hjv]
      have ih := collect_sound vs (v + 1) S' (addGroup S' g acc) T' hG2
        (fun k hk => by
          simp only [S', Nat.testBit_or, Nat.testBit_two_pow, Bool.or_eq_true, decide_eq_true_eq] at hk
          rcases hk with hk | hk
          · have := hS k hk; omega
          · omega)
        (fun k hk => by
          simp only [T', Nat.testBit_xor, Nat.testBit_two_pow] at hk
          by_cases hkv : v = k
          · subst hkv; simp [hTv] at hk
          · simp only [hkv, decide_false, Bool.xor_false] at hk
            have := hT k hk
            simp only [List.length_cons] at this
            omega)
        (by rw [hST]; exact hP2)
      rw [hST] at ih
      have hacc : addGroup S' g acc = acc + gval (S ||| T) g := by
        rw [addGroup_eq, gval_congr hG1 (fun j hj => (hagree j hj).symm)]
      have : acc + tot (S ||| T) ((a, g) :: vs) = addGroup S' g acc + tot (S ||| T) vs := by
        rw [hacc]; simp only [tot]; ring
      rw [this]
      exact ih
    · -- `v` is out
      have hTv' : T.testBit v = false := by simpa using hTv
      have hUv : (S ||| T).testBit v = false := by
        have : S.testBit v = false := by
          by_contra h
          have := hS v (by simpa using h)
          omega
        simp [Nat.testBit_or, this, hTv']
      apply List.mem_append_left
      have ih := collect_sound vs (v + 1) S acc T hG2 (fun k hk => by have := hS k hk; omega)
        (fun k hk => by
          have := hT k hk
          have hkv : k ≠ v := fun h => by rw [h, hTv'] at hk; exact Bool.false_ne_true hk
          simp only [List.length_cons] at this
          omega)
        hP2
      have : acc + tot (S ||| T) ((a, g) :: vs) = acc + tot (S ||| T) vs := by
        simp only [tot, gval_eq_zero hG1 hUv, zero_add]
      rw [this]
      exact ih

theorem pass_of_getD : ∀ (vs : List (ℕ × List ℕ)) (v U : ℕ),
    (∀ k < vs.length, U.testBit (v + k) = true → ∀ j < v + k, U.testBit j = true →
      ((vs.getD k (0, [])).1).testBit j = false) → Pass vs v U
  | [], _, _, _ => trivial
  | (a, g) :: vs, v, U, h => by
    refine ⟨fun hv j hj hUj => by simpa using h 0 (by simp) (by simpa using hv) j (by simpa using hj) hUj, ?_⟩
    apply pass_of_getD vs (v + 1) U
    intro k hk hU j hj hUj
    have := h (k + 1) (by simp; omega) (by rwa [show v + (k + 1) = v + 1 + k by omega]) j (by omega) hUj
    simpa using this

theorem groupsOk_of_getD : ∀ (vs : List (ℕ × List ℕ)) (v : ℕ),
    (∀ k < vs.length, ∀ t ∈ (vs.getD k (0, [])).2, inGroup (v + k) t = true) → GroupsOk vs v
  | [], _, _ => trivial
  | (a, g) :: vs, v, h => by
    refine ⟨fun t ht => by simpa using h 0 (by simp) t (by simpa using ht), ?_⟩
    apply groupsOk_of_getD vs (v + 1)
    intro k hk t ht
    have := h (k + 1) (by simp; omega) t (by simpa using ht)
    rwa [show v + (k + 1) = v + 1 + k by omega] at this

theorem tot_eq (U : ℕ) : ∀ vs : List (ℕ × List ℕ), tot U vs = ((vs.map Prod.snd).map (gval U)).sum
  | [] => rfl
  | (_, g) :: vs => by simp [tot, tot_eq U vs]

theorem sum_ite_const {α : Type*} (p : α → Bool) (c : ℤ) :
    ∀ l : List α, (l.map fun v => if p v = true then c else 0).sum = (l.filter p).length * c
  | [] => by simp
  | v :: l => by
    by_cases hv : p v = true
    · simp [hv, sum_ite_const p c l]; ring
    · simp [hv, sum_ite_const p c l]

theorem sum_groups (U : ℕ) : ∀ T : List ℕ, (∀ t ∈ T, oneGroup t = true) →
    (((List.range 23).map fun v => T.filter (inGroup v)).map (gval U)).sum = gval U T
  | [], _ => by simp [gval]
  | t :: T, h => by
    have h1 := h t (by simp)
    have hT := sum_groups U T (fun s hs => h s (by simp [hs]))
    have hsplit : ∀ v, gval U ((t :: T).filter (inGroup v)) =
        (if inGroup v t = true then tval U t else 0) + gval U (T.filter (inGroup v)) := by
      intro v
      by_cases hv : inGroup v t = true <;> simp [hv, gval]
    simp only [List.map_map, Function.comp_def, hsplit, List.sum_map_add]
    rw [sum_ite_const (fun v => inGroup v t) (tval U t) (List.range 23)]
    simp only [List.map_map, Function.comp_def] at hT
    rw [hT]
    simp only [oneGroup, beq_iff_eq] at h1
    rw [h1]
    simp [gval]

/-! ### Distances -/

theorem lowMul_le {b : ℤ} {l u : ℕ} {x : ℝ} (hl : (l : ℝ) ≤ x) (hu : x ≤ u) : (lowMul b l u : ℝ) ≤ b * x := by
  unfold lowMul
  by_cases hb : 0 ≤ b
  · simp only [hb, decide_true, cond_true]; push_cast
    exact mul_le_mul_of_nonneg_left hl (by exact_mod_cast hb)
  · simp only [hb, decide_false, cond_false]; push_cast
    have : (b : ℝ) ≤ 0 := by exact_mod_cast (le_of_lt (not_le.1 hb))
    nlinarith

theorem le_highMul {b : ℤ} {l u : ℕ} {x : ℝ} (hl : (l : ℝ) ≤ x) (hu : x ≤ u) : b * x ≤ (highMul b l u : ℝ) := by
  unfold highMul
  by_cases hb : 0 ≤ b
  · simp only [hb, decide_true, cond_true]; push_cast
    exact mul_le_mul_of_nonneg_left hu (by exact_mod_cast hb)
  · simp only [hb, decide_false, cond_false]; push_cast
    have : (b : ℝ) ≤ 0 := by exact_mod_cast (le_of_lt (not_le.1 hb))
    nlinarith

theorem encl_sqrt {l u K n : ℕ} (hl : l * l ≤ n * (K * K)) (hu : n * (K * K) ≤ u * u) :
    (l : ℝ) ≤ √n * K ∧ √n * K ≤ u := by
  have hK : √n * K = √(n * (K * K) : ℝ) := by
    rw [Real.sqrt_mul (by positivity), Real.sqrt_mul_self (by positivity)]
  rw [hK]
  constructor
  · rw [Real.le_sqrt (by positivity) (by positivity)]
    exact_mod_cast (by nlinarith : l ^ 2 ≤ n * (K * K))
  · rw [Real.sqrt_le_left (by positivity)]
    exact_mod_cast (by nlinarith : n * (K * K) ≤ u ^ 2)

theorem ev_encl {e : Encl} (he : e.ok = true) (q : Q4) :
    (evLo e q : ℝ) ≤ ev q * e.K ∧ ev q * e.K ≤ evHi e q := by
  simp only [Encl.ok, Bool.and_eq_true, decide_eq_true_eq] at he
  obtain ⟨⟨⟨⟨⟨⟨_, h1⟩, h2⟩, h3⟩, h4⟩, h5⟩, h6⟩ := he
  obtain ⟨a3, b3⟩ := encl_sqrt h1 h2
  obtain ⟨a11, b11⟩ := encl_sqrt h3 h4
  obtain ⟨a33, b33⟩ := encl_sqrt h5 h6
  have h33 : √(33 : ℕ) = √3 * √11 := by
    rw [show ((33 : ℕ) : ℝ) = 3 * 11 by norm_num, Real.sqrt_mul (by norm_num)]
  rw [h33] at a33 b33
  push_cast at a3 b3 a11 b11
  have l3 := lowMul_le (b := q.b) a3 b3
  have l11 := lowMul_le (b := q.c) a11 b11
  have l33 := lowMul_le (b := q.d) a33 b33
  have u3 := le_highMul (b := q.b) a3 b3
  have u11 := le_highMul (b := q.c) a11 b11
  have u33 := le_highMul (b := q.d) a33 b33
  have hev : ev q * e.K = q.a * e.K + q.b * (√3 * e.K) + q.c * (√11 * e.K) + q.d * (√3 * √11 * e.K) := by
    simp only [ev]; ring
  rw [hev]
  simp only [evLo, evHi]
  push_cast
  constructor <;> linarith

theorem distOk_sound {e : Encl} (he : e.ok = true) {D : ℤ} {p q : C4} (h : distOk e D (sqd p q) = true) :
    |‖toC p / 12 - toC q / 12‖ - (D : ℝ) / S64| ≤ 1 / (S64 : ℝ) ∧ 0 ≤ ‖toC p / 12 - toC q / 12‖ := by
  refine ⟨?_, norm_nonneg _⟩
  simp only [distOk, Bool.and_eq_true, decide_eq_true_eq] at h
  obtain ⟨⟨hD, hlo⟩, hhi⟩ := h
  obtain ⟨elo, ehi⟩ := ev_encl he (sqd p q)
  have hS : (S64 : ℝ) = 18446744073709551616 := by norm_num [S64]
  have hSpos : (0 : ℝ) < S64 := by rw [hS]; norm_num
  have hKpos : (0 : ℝ) < e.K := by
    simp only [Encl.ok, Bool.and_eq_true, decide_eq_true_eq] at he
    exact_mod_cast he.1.1.1.1.1.1
  set z := ‖toC p / 12 - toC q / 12‖
  have hz : z = √(ev (sqd p q)) / 12 := by
    simp only [z]
    rw [← sub_div, norm_div, ← toC_sub, Complex.norm_def, normSq_toC]
    simp [sqd]
  have hlo' : (144 * ((D - 1) * (D - 1)) * e.K : ℝ) ≤ evLo e (sqd p q) * (S64 * S64) := by exact_mod_cast hlo
  have hhi' : (evHi e (sqd p q) * (S64 * S64) : ℝ) ≤ 144 * ((D + 1) * (D + 1)) * e.K := by exact_mod_cast hhi
  have hD' : (1 : ℝ) ≤ D := by exact_mod_cast hD
  have hq1 : 144 * ((D - 1) * (D - 1)) ≤ ev (sqd p q) * (S64 * S64) := by
    have : (144 * ((D - 1) * (D - 1)) * e.K : ℝ) ≤ ev (sqd p q) * e.K * (S64 * S64) :=
      hlo'.trans (mul_le_mul_of_nonneg_right elo (by positivity))
    nlinarith
  have hq2 : ev (sqd p q) * (S64 * S64) ≤ 144 * ((D + 1) * (D + 1)) := by
    have : ev (sqd p q) * e.K * (S64 * S64) ≤ (144 * ((D + 1) * (D + 1)) * e.K : ℝ) :=
      (mul_le_mul_of_nonneg_right ehi (by positivity)).trans hhi'
    nlinarith
  have hev : 0 ≤ ev (sqd p q) := by
    have hS2 : (0 : ℝ) < S64 * S64 := by positivity
    have : 0 ≤ ev (sqd p q) * (S64 * S64) := le_trans (by positivity) hq1
    exact (mul_nonneg_iff_of_pos_right hS2).1 this
  set r := √(ev (sqd p q))
  have hr : r ^ 2 = ev (sqd p q) := Real.sq_sqrt hev
  have hr0 : 0 ≤ r := Real.sqrt_nonneg _
  have h1 : 12 * (D - 1) ≤ r * S64 := by
    have : (12 * (D - 1)) ^ 2 ≤ (r * S64) ^ 2 := by nlinarith
    exact (abs_le_of_sq_le_sq' this (by positivity)).2
  have h2 : r * S64 ≤ 12 * (D + 1) := by
    have : (r * S64) ^ 2 ≤ (12 * (D + 1)) ^ 2 := by nlinarith
    exact (abs_le_of_sq_le_sq' this (by nlinarith)).2
  rw [hz, abs_sub_le_iff]
  constructor
  · rw [div_sub_div _ _ (by norm_num) hSpos.ne', div_le_div_iff₀ (by positivity) hSpos]
    nlinarith
  · rw [div_sub_div _ _ hSpos.ne' (by norm_num), div_le_div_iff₀ (by positivity) hSpos]
    nlinarith

end X23Check

/-! ### The certificate -/

/-- **`[AmbrusEtAl2023]`'s dual certificate** (Table 1, `g23.csv`): the points `xᵢ`, `w₁ = w₁(1)` at the paper's point 1
(`0` here), the `w₂` and `w_C` rows at scale `10²¹`, and `bound = w_T + 10⁻⁵`. -/
noncomputable def X23 : DualCert 23 where
  X := X23pt
  w1 := fun i => if i = 0 then (w1N : ℝ) / 10 ^ 21 else 0
  w2 := w2T.map fun e => (Fin.ofNat 23 e.1, Fin.ofNat 23 e.2.1, (e.2.2 : ℝ) / 10 ^ 21)
  wc := wcR.map fun r => (finsetOf (rowI r), finsetOf (rowJ r), (rowC r : ℝ) / 10 ^ 21)
  bound := (boundN : ℝ) / 10 ^ 21

/-- `w₀` (Table 2). -/
noncomputable def X23w0 : ℝ := 0.378583312921677

namespace X23Check

/-- A `Forall₂` relates each member of its left list to some member of its right list. -/
theorem forall₂_exists_left {α β : Type*} {R : α → β → Prop} {l₁ : List α} {l₂ : List β}
    (h : List.Forall₂ R l₁ l₂) {a : α} (ha : a ∈ l₁) : ∃ b ∈ l₂, R a b := by
  induction h with
  | nil => simp at ha
  | cons hab _ ih =>
    rcases List.mem_cons.1 ha with rfl | ha'
    · exact ⟨_, List.mem_cons_self .., hab⟩
    · obtain ⟨b, hb, h⟩ := ih ha'
      exact ⟨b, List.mem_cons_of_mem _ hb, h⟩

/-- A `Forall₂` relates each member of its right list to some member of its left list. -/
theorem forall₂_exists_right {α β : Type*} {R : α → β → Prop} {l₁ : List α} {l₂ : List β}
    (h : List.Forall₂ R l₁ l₂) {b : β} (hb : b ∈ l₂) : ∃ a ∈ l₁, R a b := by
  induction h with
  | nil => simp at hb
  | cons hab _ ih =>
    rcases List.mem_cons.1 hb with rfl | hb'
    · exact ⟨_, List.mem_cons_self .., hab⟩
    · obtain ⟨a, ha, h⟩ := ih hb'
      exact ⟨a, List.mem_cons_of_mem _ ha, h⟩

theorem congruent_of_rowOk {r : ℕ} (h : rowOk ptsL r = true) (hI : ∀ i ∈ rowI r, i < 23)
    (hJ : ∀ j ∈ rowJ r, j < 23) : X23.Congruent (finsetOf (rowI r)) (finsetOf (rowJ r)) := by
  simp only [rowOk, Bool.and_eq_true, decide_eq_true_eq] at h
  obtain ⟨⟨hm, hU⟩, hcorr⟩ := h
  set m := rowM r
  set U := rowU r
  set V := rowV r
  set b := rowB r
  have hm' : (0 : ℝ) < m := by exact_mod_cast hm
  have hUn : ‖toC U‖ = m := by
    rw [Complex.norm_def, normSq_toC, Q4.eq_of_beq hU, ev_ofInt]
    push_cast
    rw [Real.sqrt_mul_self hm'.le]
  refine ⟨toC U / m, toC V / (12 * m), b, ?_, ?_⟩
  · rw [norm_div, hUn, Complex.norm_natCast, div_self hm'.ne']
  -- the correspondence, entry by entry
  set f : ℂ → ℂ := fun z => toC U / m * (if b then (starRingEnd ℂ) z else z) + toC V / (12 * m)
  have hpt : ∀ i j, (((U.mul ((pt ptsL i).cond b)).add V).beq ((pt ptsL j).smul (m : ℤ))) = true →
      f (toC (pt ptsL i) / 12) = toC (pt ptsL j) / 12 := by
    intro i j hij
    have he := congrArg toC (C4.eq_of_beq hij)
    rw [toC_add, toC_mul, toC_cond, toC_smul] at he
    simp only [f]
    have hm0 : (m : ℂ) ≠ 0 := by exact_mod_cast hm'.ne'
    cases hb : b
    · simp only [hb, Bool.false_eq_true, if_false] at he ⊢
      field_simp
      push_cast at he
      linear_combination he
    · simp only [hb, if_true] at he ⊢
      rw [map_div₀, Complex.conj_ofNat]
      field_simp
      push_cast at he
      linear_combination he
  have hF : ∀ I J : List ℕ, corrOk ptsL b U V (m : ℤ) I J = true →
      List.Forall₂ (fun i j => f (toC (pt ptsL i) / 12) = toC (pt ptsL j) / 12) I J := by
    intro I
    induction I with
    | nil => intro J hJ; cases J <;> simp_all [corrOk]
    | cons i I ih =>
      intro J hJ
      cases J with
      | nil => simp [corrOk] at hJ
      | cons j J =>
        simp only [corrOk, Bool.and_eq_true] at hJ
        exact List.Forall₂.cons (hpt i j hJ.1) (ih J hJ.2)
  have hFI := hF _ _ hcorr
  -- the images
  have himg : ∀ (L : List ℕ), (∀ i ∈ L, i < 23) →
      X23.X '' ↑(finsetOf L) = (fun i => toC (pt ptsL i) / 12) '' {i | i ∈ L} := by
    intro L hL
    ext z
    simp only [Set.mem_image, Finset.mem_coe, Set.mem_setOf_eq]
    constructor
    · rintro ⟨x, hx, rfl⟩
      exact ⟨x, (mem_finsetOf hL x).1 hx, rfl⟩
    · rintro ⟨i, hi, rfl⟩
      exact ⟨⟨i, hL i hi⟩, (mem_finsetOf hL _).2 hi, rfl⟩
  show f '' (X23.X '' ↑(finsetOf (rowI r))) = X23.X '' ↑(finsetOf (rowJ r))
  rw [himg _ hI, himg _ hJ, Set.image_image]
  ext z
  simp only [Set.mem_image, Set.mem_setOf_eq]
  constructor
  · rintro ⟨i, hi, rfl⟩
    obtain ⟨j, hj, hij⟩ := forall₂_exists_left hFI hi
    exact ⟨j, hj, hij.symm⟩
  · rintro ⟨j, hj, rfl⟩
    exact forall₂_exists_right hFI hj

/-! ### `L(S)` as the sum of the terms -/

/-- `terms_ok` read as propositions. -/
theorem terms_ok' : termOk 1 w1N = true ∧
    (∀ e ∈ w2T, e.1 < 23 ∧ e.2.1 < 23 ∧ termOk (2 ^ e.1 ||| 2 ^ e.2.1) e.2.2 = true) ∧
    (∀ r ∈ wcR, (∀ i ∈ rowI r, i < 23) ∧ (∀ j ∈ rowJ r, j < 23) ∧ termOk (maskL (rowI r)) (-rowC r) = true ∧
      termOk (maskL (rowJ r)) (rowC r) = true) := by
  have h := terms_ok
  simp only [termsOk, Bool.and_eq_true, List.all_eq_true, decide_eq_true_eq] at h
  obtain ⟨⟨h1, h2⟩, h3⟩ := h
  exact ⟨h1, fun e he => ⟨(h2 e he).1.1, (h2 e he).1.2, (h2 e he).2⟩,
    fun r hr => ⟨(h3 r hr).1.1.1, (h3 r hr).1.1.2, (h3 r hr).1.2, (h3 r hr).2⟩⟩

/-- A point index `< 23` is in `S` exactly when its bit is in `S`'s mask. -/
theorem testBit_maskOf_iff {i : ℕ} (hi : i < 23) (S : Finset (Fin 23)) :
    (maskOf S).testBit i = true ↔ Fin.ofNat 23 i ∈ S := by
  rw [testBit_maskOf]
  constructor
  · rintro ⟨x, hx, rfl⟩
    rwa [show Fin.ofNat 23 (x : ℕ) = x from Fin.ext (by rw [Fin.val_ofNat, Nat.mod_eq_of_lt x.2])]
  · intro h
    exact ⟨_, h, by rw [Fin.val_ofNat, Nat.mod_eq_of_lt hi]⟩

private theorem sum_map_div {α : Type*} (l : List α) (f : α → ℤ) :
    (l.map fun x => (f x : ℝ) / 10 ^ 21).sum = ((l.map f).sum : ℝ) / 10 ^ 21 := by
  induction l with
  | nil => simp
  | cons x l ih => simp only [List.map_cons, List.sum_cons, ih]; push_cast; ring

private theorem sum_map_neg' {α : Type*} (l : List α) (f : α → ℝ) :
    (l.map fun x => -f x).sum = -(l.map f).sum := by
  induction l with
  | nil => simp
  | cons x l ih => simp only [List.map_cons, List.sum_cons, ih]; ring

private theorem gval_append (U : ℕ) (l l' : List ℕ) : gval U (l ++ l') = gval U l + gval U l' := by
  simp [gval]

private theorem gval_flatMap (U : ℕ) (l : List ℕ) (f : ℕ → List ℕ) :
    gval U (l.flatMap f) = (l.map fun r => gval U (f r)).sum := by
  induction l with
  | nil => simp [gval]
  | cons r l ih => rw [List.flatMap_cons, gval_append, ih]; simp

/-- **`L(S)·10²¹` is the sum of the terms in `S`**. -/
theorem L_eq (S : Finset (Fin 23)) : X23.L S = (gval (maskOf S) (terms w1N w2T wcR) : ℝ) / 10 ^ 21 := by
  obtain ⟨h1, h2, h3⟩ := terms_ok'
  set U := maskOf S
  -- `w₁`
  have hw1 : ∑ i ∈ S, X23.w1 i = (tval U (pack 1 w1N) : ℝ) / 10 ^ 21 := by
    show ∑ i ∈ S, (if i = 0 then (w1N : ℝ) / 10 ^ 21 else 0) = _
    rw [Finset.sum_ite_eq', tval_pack h1]
    have : (1 &&& U = 1) ↔ (0 : Fin 23) ∈ S := by
      rw [land_eq_self_iff]
      constructor
      · intro h
        have := h 0 (by decide)
        exact (testBit_maskOf_iff (by norm_num) S).1 this
      · intro h k hk
        have hk0 : k = 0 := by
          rw [show (1 : ℕ) = 2 ^ 0 by rfl, Nat.testBit_two_pow] at hk
          simpa [eq_comm] using hk
        subst hk0
        exact (testBit_maskOf_iff (by norm_num) S).2 h
    by_cases h0 : (0 : Fin 23) ∈ S
    · rw [if_pos h0, if_pos (this.2 h0)]
    · rw [if_neg h0, if_neg (mt this.1 h0)]; simp
  -- `w₂`
  have hw2 : (X23.w2.map fun e => if e.1 ∈ S ∧ e.2.1 ∈ S then e.2.2 else 0).sum =
      (gval U (w2T.map w2Term) : ℝ) / 10 ^ 21 := by
    show ((w2T.map fun e => (Fin.ofNat 23 e.1, Fin.ofNat 23 e.2.1, (e.2.2 : ℝ) / 10 ^ 21)).map _).sum = _
    rw [List.map_map, gval, List.map_map, ← sum_map_div w2T (tval U ∘ w2Term)]
    congr 1
    apply List.map_congr_left
    intro e he
    obtain ⟨hi, hj, ht⟩ := h2 e he
    simp only [Function.comp_apply, w2Term, tval_pack ht]
    have : (2 ^ e.1 ||| 2 ^ e.2.1) &&& U = 2 ^ e.1 ||| 2 ^ e.2.1 ↔ Fin.ofNat 23 e.1 ∈ S ∧ Fin.ofNat 23 e.2.1 ∈ S := by
      rw [land_eq_self_iff, ← testBit_maskOf_iff hi, ← testBit_maskOf_iff hj]
      constructor
      · intro h
        exact ⟨h _ (by simp [Nat.testBit_or, Nat.testBit_two_pow]), h _ (by simp [Nat.testBit_or, Nat.testBit_two_pow])⟩
      · rintro ⟨ha, hb⟩ k hk
        simp only [Nat.testBit_or, Nat.testBit_two_pow, Bool.or_eq_true, decide_eq_true_eq] at hk
        rcases hk with rfl | rfl <;> assumption
    by_cases hc : Fin.ofNat 23 e.1 ∈ S ∧ Fin.ofNat 23 e.2.1 ∈ S
    · rw [if_pos hc, if_pos (this.2 hc)]
    · rw [if_neg hc, if_neg (mt this.1 hc)]; simp
  -- the congruence rows
  have hwc : (X23.wc.map fun e => e.2.2 * ((if e.1 ⊆ S then 1 else 0) - (if e.2.1 ⊆ S then 1 else 0))).sum =
      -(gval U (wcR.flatMap rowTerms) : ℝ) / 10 ^ 21 := by
    show ((wcR.map fun r => (finsetOf (rowI r), finsetOf (rowJ r), (rowC r : ℝ) / 10 ^ 21)).map _).sum = _
    rw [List.map_map, gval_flatMap, neg_div, ← sum_map_div wcR (fun r => gval U (rowTerms r)),
      ← sum_map_neg']
    congr 1
    apply List.map_congr_left
    intro r hr
    obtain ⟨hI, hJ, htI, htJ⟩ := h3 r hr
    have hIU : maskL (rowI r) &&& U = maskL (rowI r) ↔ finsetOf (rowI r) ⊆ S := maskL_sub_iff hI S
    have hJU : maskL (rowJ r) &&& U = maskL (rowJ r) ↔ finsetOf (rowJ r) ⊆ S := maskL_sub_iff hJ S
    simp only [Function.comp_apply, rowTerms, gval, List.map_cons, List.map_nil, List.sum_cons, List.sum_nil,
      add_zero, tval_pack htI, tval_pack htJ, hIU, hJU]
    by_cases hIS : finsetOf (rowI r) ⊆ S <;> by_cases hJS : finsetOf (rowJ r) ⊆ S <;>
      first | (simp [hIS, hJS]; done) | (simp [hIS, hJS]; ring)
  show ∑ i ∈ S, X23.w1 i + (X23.w2.map fun e => if e.1 ∈ S ∧ e.2.1 ∈ S then e.2.2 else 0).sum -
      (X23.wc.map fun e => e.2.2 * ((if e.1 ⊆ S then 1 else 0) - (if e.2.1 ⊆ S then 1 else 0))).sum = _
  rw [hw1, hw2, hwc]
  simp only [terms, gval, List.map_cons, List.sum_cons, List.map_append, List.sum_append]
  push_cast
  ring

/-! ### The atoms -/

/-- The DFS accepts the whole tree: the prefix to depth `KF` is the frontier, and every frontier state's subtree passes. -/
theorem atoms_dfs : dfsG (final boundN) vertsL 0 0 0 = true := by
  rw [← List.take_append_drop KF vertsL, dfsG_append, dfsG_eq_all]
  have hlen : 0 + (vertsL.take KF).length = KF := by
    rw [List.length_take, verts_length]; rfl
  rw [hlen, List.all_eq_true]
  intro p hp
  have hq : packSt p ∈ frL := frontier_eq ▸ List.mem_map_of_mem hp
  have hrt : decSt (packSt p) = p := by
    have := List.all_eq_true.1 frontier_rt p hp
    simpa using this
  have := List.all_eq_true.1 frL_ok (packSt p) hq
  simp only [subtreeOk, hrt] at this
  exact this

/-- **`V(S) ≥ −ν` on every nonempty independent atom.** -/
theorem X23_atoms (S : Finset (Fin 23)) (hS : S.Nonempty) (hI : X23.IsIndep S) : X23.L S ≤ X23.bound := by
  set U := maskOf S
  have hbits : ∀ k, U.testBit k = true → 0 ≤ k ∧ k < 0 + vertsL.length := by
    intro k hk
    obtain ⟨x, _, rfl⟩ := (testBit_maskOf S k).1 hk
    rw [verts_length]
    exact ⟨Nat.zero_le _, by omega⟩
  have hG : GroupsOk vertsL 0 := by
    apply groupsOk_of_getD
    intro k hk t ht
    rw [verts_length] at hk
    have hg : (vertsL.getD k (0, [])).2 = (vertsL.map Prod.snd).getD k [] := by
      simp only [List.getD_eq_getElem?_getD, List.getElem?_map]
      cases vertsL[k]? <;> rfl
    rw [hg, groups_eq, groupsOf] at ht
    simp only [List.getD_eq_getElem?_getD, List.getElem?_map, List.getElem?_range hk, Option.map_some,
      Option.getD_some] at ht
    rw [zero_add]
    exact (List.mem_filter.1 ht).2
  have hP : Pass vertsL 0 (0 ||| U) := by
    rw [Nat.zero_or]
    apply pass_of_getD
    intro k hk hUk j hj hUj
    rw [verts_length] at hk
    rw [zero_add] at hUk hj
    by_contra hb
    have hd := dist_of_adj (w := k) (u := j) hk (by omega) (by simpa using hb)
    have hkS := (testBit_maskOf_iff hk S).1 hUk
    have hjS := (testBit_maskOf_iff (by omega) S).1 hUj
    have := hI _ hkS _ hjS
    apply this
    simpa [X23, Fin.ofNat, Nat.mod_eq_of_lt hk, Nat.mod_eq_of_lt (show j < 23 by omega)] using hd
  have hmem := collect_sound vertsL 0 0 0 U hG (by simp) hbits hP
  have hall := (dfsG_eq_all _ _ _ _ _).symm.trans atoms_dfs
  have hfin := List.all_eq_true.1 hall _ hmem
  simp only [Nat.zero_or, zero_add, final, Bool.or_eq_true, beq_iff_eq, decide_eq_true_eq] at hfin
  have hU0 : U ≠ 0 := by
    obtain ⟨x, hx⟩ := hS
    intro h0
    have := (testBit_maskOf S x).2 ⟨x, hx, rfl⟩
    rw [show maskOf S = 0 from h0, Nat.zero_testBit] at this
    exact Bool.false_ne_true this
  have htot := hfin.resolve_left hU0
  rw [tot_eq, groups_eq] at htot
  simp only [groupsOf] at htot
  rw [sum_groups _ _ (List.all_eq_true.1 one_group)] at htot
  rw [L_eq]
  show _ ≤ (boundN : ℝ) / 10 ^ 21
  exact (div_le_div_iff_of_pos_right (by positivity)).2 (by exact_mod_cast htot)

end X23Check

/-- **`[AmbrusEtAl2023]`'s certificate is valid**: every listed congruence is between congruent sets, `V ≥ −ν` on every
nonempty independent atom, and the bound is nonnegative. -/
theorem X23_valid : X23.Valid where
  cong := by
    intro e he
    obtain ⟨r, hr, rfl⟩ := List.mem_map.1 he
    obtain ⟨-, -, h3⟩ := X23Check.terms_ok'
    obtain ⟨hI, hJ, -, -⟩ := h3 r hr
    exact X23Check.congruent_of_rowOk (List.all_eq_true.1 X23Check.wcR_ok r hr) hI hJ
  atoms := X23Check.X23_atoms
  bound_nonneg := by
    show (0 : ℝ) ≤ (boundN : ℝ) / 10 ^ 21
    simp only [boundN]
    positivity

end HadwigerNelson.DensityBound

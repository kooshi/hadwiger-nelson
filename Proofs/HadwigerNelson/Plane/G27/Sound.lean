import Proofs.HadwigerNelson.Plane.G27.Check
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# `G27`'s checker is sound: the residual DFS and the sort preserve the terms' values (FS-131, FS131-ISF1)

The computations of `Plane/G27/Check` read as statements about `val U L`, the sum of the coefficients of the terms of `L`
whose key lies in the set `U`:

* `val_mergeR`, `val_sortR` — merging and sorting add values;
* `val_stepOut`, `val_stepIn` — deciding point `k` out (in) leaves the value on every set without `k` (with `k`, and no
  point adjacent to `k`) unchanged, the residual read on the rest of the set;
* `dfsR_sound` — if the residual DFS accepts, every set `U` of later points that is independent in the masks, together with
  the chosen set, has `val U L ≤ D`; `dfsR_append` and `dfsR_eq_all` cut it at a frontier.

Record: `plans/FS131-ISF1-seam-fractional.md`.
-/

namespace HadwigerNelson.G27

/-! ### Bits -/

theorem M27_eq : M27 = 2 ^ 27 := rfl

theorem two_pow_lt_M27 {k : ℕ} (hk : k < 27) : 2 ^ k < M27 := by
  rw [M27_eq]; exact Nat.pow_lt_pow_right (by norm_num) hk

theorem testBit_key (t i : ℕ) : (key t).testBit i = (decide (i < 27) && t.testBit i) := by
  rw [key, M27_eq, Nat.testBit_mod_two_pow]

theorem testBit_of_lt_M27 {m i : ℕ} (hm : m < M27) (hi : 27 ≤ i) : m.testBit i = false :=
  Nat.testBit_lt_two_pow (lt_of_lt_of_le hm (by rw [M27_eq]; exact Nat.pow_le_pow_right (by norm_num) hi))

/-- A mask below `2²⁷` sees only a term's key. -/
theorem land_key {t m : ℕ} (hm : m < M27) : t &&& m = key t &&& m := by
  apply Nat.eq_of_testBit_eq
  intro i
  rw [Nat.testBit_and, Nat.testBit_and, testBit_key]
  by_cases hi : i < 27
  · simp [hi]
  · rw [testBit_of_lt_M27 hm (show 27 ≤ i by omega)]
    simp

theorem land_self_iff (m U : ℕ) : m &&& U = m ↔ ∀ i, m.testBit i = true → U.testBit i = true := by
  constructor
  · intro h i hi
    rw [← h, Nat.testBit_and, Bool.and_eq_true] at hi
    exact hi.2
  · intro h
    apply Nat.eq_of_testBit_eq
    intro i
    rw [Nat.testBit_and]
    cases hm : m.testBit i
    · rfl
    · rw [h i hm]; rfl

theorem land_eq_zero_iff (m U : ℕ) : m &&& U = 0 ↔ ∀ i, m.testBit i = true → U.testBit i = false := by
  constructor
  · intro h i hi
    have := congrArg (fun x => x.testBit i) h
    simp only [Nat.testBit_and, Nat.zero_testBit, hi, Bool.true_and] at this
    exact this
  · intro h
    apply Nat.eq_of_testBit_eq
    intro i
    rw [Nat.testBit_and, Nat.zero_testBit]
    cases hm : m.testBit i
    · rfl
    · rw [h i hm]; rfl

theorem key_add_mul {k n : ℕ} (hk : k < M27) : key (k + M27 * n) = k := by
  rw [key, Nat.add_mul_mod_self_left, Nat.mod_eq_of_lt hk]

theorem div_add_mul {k n : ℕ} (hk : k < M27) : (k + M27 * n) / M27 = n := by
  rw [Nat.add_mul_div_left _ _ (by decide : 0 < M27), Nat.div_eq_of_lt hk, zero_add]

/-- Toggling a point's bit moves only the key. -/
theorem key_xor {t k : ℕ} (hk : k < 27) : key (t ^^^ 2 ^ k) = key t ^^^ 2 ^ k := by
  apply Nat.eq_of_testBit_eq
  intro i
  rw [testBit_key, Nat.testBit_xor, Nat.testBit_xor, testBit_key, Nat.testBit_two_pow]
  by_cases hi : i < 27
  · simp [hi]
  · have : k ≠ i := by omega
    simp [hi, this]

theorem div_xor {t k : ℕ} (hk : k < 27) : (t ^^^ 2 ^ k) / M27 = t / M27 := by
  apply Nat.eq_of_testBit_eq
  intro i
  rw [M27_eq, Nat.testBit_div_two_pow, Nat.testBit_div_two_pow, Nat.testBit_xor, Nat.testBit_two_pow]
  have : k ≠ i + 27 := by omega
  simp [this]

/-! ### Values -/

/-- The term `t`'s contribution to the value on `U`. -/
def tv (U t : ℕ) : ℤ := bif key t &&& U == key t then cf t else 0

theorem val_nil (U : ℕ) : val U [] = 0 := rfl

theorem val_cons (U t : ℕ) (L : List ℕ) : val U (t :: L) = tv U t + val U L := by
  simp [val, tv]

theorem val_append (U : ℕ) (L L' : List ℕ) : val U (L ++ L') = val U L + val U L' := by
  simp [val]

theorem tv_of_key_eq {U a b : ℕ} (h : key a = key b) : tv U a = bif key b &&& U == key b then cf a else 0 := by
  simp [tv, h]

/-! ### Merging -/

theorem mergeR_zero (l₁ l₂ : List ℕ) : mergeR 0 l₁ l₂ = l₁ ++ l₂ := rfl

theorem mergeR_succ_nil (f : ℕ) (l₂ : List ℕ) : mergeR (f + 1) [] l₂ = l₂ := rfl

theorem mergeR_succ_cons_nil (f a : ℕ) (l₁ : List ℕ) : mergeR (f + 1) (a :: l₁) [] = a :: l₁ := rfl

theorem mergeR_succ_cons_cons (f a b : ℕ) (l₁ l₂ : List ℕ) : mergeR (f + 1) (a :: l₁) (b :: l₂) =
    cond (Nat.blt (Nat.mod a M27) (Nat.mod b M27)) (a :: mergeR f l₁ (b :: l₂))
      (cond (Nat.blt (Nat.mod b M27) (Nat.mod a M27)) (b :: mergeR f (a :: l₁) l₂)
        (cond (Nat.ble OFFC (Nat.add (Nat.div a M27) (Nat.div b M27)))
          (Nat.add (Nat.mod a M27) (Nat.mul M27 (Nat.sub (Nat.add (Nat.div a M27) (Nat.div b M27)) OFFC)) ::
            mergeR f l₁ l₂)
          (a :: b :: mergeR f l₁ l₂))) := rfl

-- The combination, with the offset a variable: a closed offset of a thousand bits in the goal sends the kernel into deep
-- recursion at the rewrite (seen here; `LEAN.md`, FS131-I10E's line on closed `Nat` terms).
private theorem combine_aux (O x y : ℕ) (hle : O ≤ x + y) :
    (((x + y - O : ℕ) : ℤ) - (O : ℤ)) = (((x : ℕ) : ℤ) - (O : ℤ)) + (((y : ℕ) : ℤ) - (O : ℤ)) := by
  omega

private theorem tv_combine_aux (O U a b : ℕ) (hk : key a = key b) (hle : O ≤ a / M27 + b / M27) :
    (bif key (key a + M27 * (a / M27 + b / M27 - O)) &&& U == key (key a + M27 * (a / M27 + b / M27 - O)) then
        (((key a + M27 * (a / M27 + b / M27 - O)) / M27 : ℕ) : ℤ) - (O : ℤ) else 0) =
      (bif key a &&& U == key a then ((a / M27 : ℕ) : ℤ) - (O : ℤ) else 0) +
        (bif key b &&& U == key b then ((b / M27 : ℕ) : ℤ) - (O : ℤ) else 0) := by
  have hka : key a < M27 := Nat.mod_lt _ (by decide)
  rw [key_add_mul hka, div_add_mul hka, ← hk]
  cases key a &&& U == key a
  · rfl
  · exact combine_aux O (a / M27) (b / M27) hle

/-- Two terms of one key combined: the packing of the summed coefficient. -/
theorem tv_combine {U a b : ℕ} (hk : key a = key b) (hle : OFFC ≤ a / M27 + b / M27) :
    tv U (key a + M27 * (a / M27 + b / M27 - OFFC)) = tv U a + tv U b :=
  tv_combine_aux OFFC U a b hk hle

/-- **Merging adds values.** -/
theorem val_mergeR (U : ℕ) : ∀ (f : ℕ) (l₁ l₂ : List ℕ), val U (mergeR f l₁ l₂) = val U l₁ + val U l₂
  | 0, l₁, l₂ => by rw [mergeR_zero, val_append]
  | f + 1, [], l₂ => by rw [mergeR_succ_nil, val_nil, zero_add]
  | f + 1, a :: l₁, [] => by rw [mergeR_succ_cons_nil, val_nil, add_zero]
  | f + 1, a :: l₁, b :: l₂ => by
    rw [mergeR_succ_cons_cons]
    cases h1 : Nat.blt (Nat.mod a M27) (Nat.mod b M27)
    · cases h2 : Nat.blt (Nat.mod b M27) (Nat.mod a M27)
      · have hk : key a = key b := by
          simp only [Nat.blt_eq, Bool.eq_false_iff, ne_eq, not_lt] at h1 h2
          exact le_antisymm h2 h1
        cases h3 : Nat.ble OFFC (Nat.add (Nat.div a M27) (Nat.div b M27))
        · simp only [cond_false, val_cons, val_mergeR U f l₁ l₂]
          ring
        · have hle : OFFC ≤ a / M27 + b / M27 := Nat.le_of_ble_eq_true h3
          simp only [cond_false, cond_true, val_cons, val_mergeR U f l₁ l₂]
          change tv U (key a + M27 * (a / M27 + b / M27 - OFFC)) + _ = _
          rw [tv_combine hk hle]
          ring
      · simp only [cond_false, cond_true, val_cons, val_mergeR U f (a :: l₁) l₂]
        ring
    · simp only [cond_true, val_cons, val_mergeR U f l₁ (b :: l₂)]
      ring

/-- One round of merging neighbours preserves the total value. -/
theorem sum_val_mergePairs (U : ℕ) : ∀ ls : List (List ℕ),
    ((mergePairs ls).map (val U)).sum = (ls.map (val U)).sum
  | l₁ :: l₂ :: ls => by
    simp only [mergePairs, List.map_cons, List.sum_cons, val_mergeR, sum_val_mergePairs U ls]
    ring
  | [] => rfl
  | [_] => rfl

theorem val_flatten (U : ℕ) : ∀ ls : List (List ℕ), val U ls.flatten = (ls.map (val U)).sum
  | [] => rfl
  | l :: ls => by rw [List.flatten_cons, val_append, val_flatten U ls]; simp

theorem val_sortRounds (U : ℕ) : ∀ (r : ℕ) (ls : List (List ℕ)), val U (sortRounds r ls) = (ls.map (val U)).sum
  | 0, ls => val_flatten U ls
  | _ + 1, [] => rfl
  | _ + 1, [l] => by simp [sortRounds]
  | r + 1, l₁ :: l₂ :: ls => by
    rw [sortRounds, val_sortRounds U r, sum_val_mergePairs]

/-- **Sorting preserves the value.** -/
theorem val_sortR (U : ℕ) (L : List ℕ) : val U (sortR L) = val U L := by
  rw [sortR, val_sortRounds, List.map_map]
  induction L with
  | nil => rfl
  | cons t L ih =>
    simp only [List.map_cons, List.sum_cons, Function.comp_apply, ih, val_cons, val_nil, add_zero]

/-! ### The steps -/

theorem stepOut_nil (bit : ℕ) : stepOut bit [] = [] := rfl

theorem stepOut_cons (bit t : ℕ) (L : List ℕ) :
    stepOut bit (t :: L) = cond (Nat.beq (Nat.land t bit) 0) (t :: stepOut bit L) (stepOut bit L) := rfl

theorem keepIn_cons (ba t : ℕ) (L : List ℕ) :
    keepIn ba (t :: L) = cond (Nat.beq (Nat.land t ba) 0) (t :: keepIn ba L) (keepIn ba L) := rfl

theorem shiftIn_cons (bit a t : ℕ) (L : List ℕ) : shiftIn bit a (t :: L) =
    cond (Nat.beq (Nat.land t a) 0) (cond (Nat.beq (Nat.land t bit) 0) (shiftIn bit a L)
      (Nat.xor t bit :: shiftIn bit a L)) (shiftIn bit a L) := rfl

theorem land_two_pow_eq_zero {U k : ℕ} (hU : U.testBit k = false) : U &&& 2 ^ k = 0 := by
  rw [land_eq_zero_iff]
  intro i hi
  rw [Nat.testBit_two_pow]
  simp only [decide_eq_false_iff_not]
  rintro rfl
  rw [hU] at hi
  exact Bool.false_ne_true hi

/-- A term that needs a point outside `U` is worth nothing on `U`. -/
theorem tv_eq_zero_of_land {U t m : ℕ} (hm : m < M27) (htm : t &&& m ≠ 0) (hUm : U &&& m = 0) : tv U t = 0 := by
  have h : (key t &&& U == key t) = false := by
    rw [beq_eq_false_iff_ne]
    intro he
    apply htm
    rw [land_key hm, ← he, Nat.and_assoc, hUm, Nat.and_zero]
  simp [tv, h]

/-- **Point `k` out**: on a set without `k`, dropping the terms that need `k` changes nothing. -/
theorem val_stepOut {k U : ℕ} (hk : k < 27) (hU : U.testBit k = false) (L : List ℕ) :
    val U (stepOut (2 ^ k) L) = val U L := by
  have hUb : U &&& 2 ^ k = 0 := land_two_pow_eq_zero hU
  induction L with
  | nil => rfl
  | cons t L ih =>
    rw [stepOut_cons]
    cases h : Nat.beq (Nat.land t (2 ^ k)) 0
    · have htm : t &&& 2 ^ k ≠ 0 := Nat.ne_of_beq_eq_false h
      rw [cond_false, ih, val_cons, tv_eq_zero_of_land (two_pow_lt_M27 hk) htm hUb, zero_add]
    · rw [cond_true, val_cons, val_cons, ih]

theorem or_eq_zero_iff' {x y : ℕ} : x ||| y = 0 ↔ x = 0 ∧ y = 0 := by
  constructor
  · intro h
    constructor <;> apply Nat.eq_of_testBit_eq <;> intro i <;> rw [Nat.zero_testBit] <;>
      · have := congrArg (fun z => z.testBit i) h
        simp only [Nat.testBit_or, Nat.zero_testBit, Bool.or_eq_false_iff] at this
        first | exact this.1 | exact this.2
  · rintro ⟨rfl, rfl⟩; rfl

theorem beq_land_true {t m : ℕ} (h : t &&& m = 0) : Nat.beq (Nat.land t m) 0 = true := by
  rw [show Nat.land t m = 0 from h]; rfl

theorem beq_land_false {t m : ℕ} (h : t &&& m ≠ 0) : Nat.beq (Nat.land t m) 0 = false :=
  Bool.eq_false_iff.2 fun h' => h (Nat.eq_of_beq_eq_true h')

/-- The masks `2ᵏ ||| U` and `a` are disjoint when `U` misses `a` and `a` misses `k`. -/
private theorem or_land_eq_zero {k a U : ℕ} (hak : a.testBit k = false) (hUa : U &&& a = 0) :
    (2 ^ k ||| U) &&& a = 0 := by
  rw [Nat.and_or_distrib_right, hUa, Nat.or_zero, Nat.and_comm]
  exact land_two_pow_eq_zero hak

theorem testBit_of_land_two_pow {t k : ℕ} (h : t &&& 2 ^ k ≠ 0) : t.testBit k = true := by
  by_contra hc
  exact h (land_two_pow_eq_zero (by simpa using hc))

/-- **Point `k` in**, term by term: the term's value on a set with `k` and without `k`'s neighbours is the value, on the
rest, of its shifted part (if it holds `k`) or of itself (if not). -/
theorem val_shift_keep {k a U : ℕ} (hk : k < 27) (ha : a < M27) (hak : a.testBit k = false)
    (hU : U.testBit k = false) (hUa : U &&& a = 0) (L : List ℕ) :
    val U (shiftIn (2 ^ k) a L) + val U (keepIn (Nat.lor (2 ^ k) a) L) = val (2 ^ k ||| U) L := by
  have hb := two_pow_lt_M27 hk
  have hUb : U &&& 2 ^ k = 0 := land_two_pow_eq_zero hU
  induction L with
  | nil => rfl
  | cons t L ih =>
    rw [shiftIn_cons, keepIn_cons, val_cons]
    have hor : Nat.land t (Nat.lor (2 ^ k) a) = (t &&& 2 ^ k) ||| (t &&& a) := Nat.and_or_distrib_left _ _ _
    by_cases hA : t &&& a = 0
    · by_cases hB : t &&& 2 ^ k = 0
      · -- neither `k` nor a neighbour: kept
        have hK : Nat.beq (Nat.land t (Nat.lor (2 ^ k) a)) 0 = true := by
          rw [hor, hA, hB]; rfl
        simp only [beq_land_true hA, beq_land_true hB, hK, cond_true, val_cons]
        have : tv U t = tv (2 ^ k ||| U) t := by
          have hkey : key t &&& (2 ^ k ||| U) = key t &&& U := by
            rw [Nat.and_or_distrib_left, ← land_key hb, hB, Nat.zero_or]
          simp only [tv, hkey]
        rw [this, ← ih]; ring
      · -- `k` and no neighbour: shifted
        have hK : Nat.beq (Nat.land t (Nat.lor (2 ^ k) a)) 0 = false := by
          apply beq_land_false
          rw [show t &&& Nat.lor (2 ^ k) a = (t &&& 2 ^ k) ||| (t &&& a) from hor]
          intro h0
          exact hB (or_eq_zero_iff'.1 h0).1
        simp only [beq_land_true hA, beq_land_false hB, hK, cond_true, cond_false, val_cons]
        have hkt : (key t).testBit k = true := by
          rw [testBit_key]; simp [hk, testBit_of_land_two_pow hB]
        have htest : (key (Nat.xor t (2 ^ k)) &&& U == key (Nat.xor t (2 ^ k))) =
            (key t &&& (2 ^ k ||| U) == key t) := by
          change (key (t ^^^ 2 ^ k) &&& U == key (t ^^^ 2 ^ k)) = _
          rw [key_xor hk, Bool.eq_iff_iff, beq_iff_eq, beq_iff_eq, land_self_iff, land_self_iff]
          constructor
          · intro h i hi
            rw [Nat.testBit_or, Nat.testBit_two_pow]
            by_cases hik : k = i
            · simp [hik]
            · have := h i (by rw [Nat.testBit_xor, Nat.testBit_two_pow]; simp [hik, hi])
              simp [this]
          · intro h i hi
            rw [Nat.testBit_xor, Nat.testBit_two_pow] at hi
            by_cases hik : k = i
            · subst hik; simp [hkt] at hi
            · have hti : (key t).testBit i = true := by simpa [hik] using hi
              have := h i hti
              rw [Nat.testBit_or, Nat.testBit_two_pow] at this
              simpa [hik] using this
        have hcf : cf (Nat.xor t (2 ^ k)) = cf t := by
          change ((((t ^^^ 2 ^ k) / M27 : ℕ) : ℤ) - (OFFC : ℤ)) = _
          rw [div_xor hk]; rfl
        have : tv U (Nat.xor t (2 ^ k)) = tv (2 ^ k ||| U) t := by
          simp only [tv, htest, hcf]
        rw [this, ← ih]; ring
    · -- a neighbour of `k`: worthless on the set
      have hK : Nat.beq (Nat.land t (Nat.lor (2 ^ k) a)) 0 = false := by
        apply beq_land_false
        rw [show t &&& Nat.lor (2 ^ k) a = (t &&& 2 ^ k) ||| (t &&& a) from hor]
        intro h0
        exact hA (or_eq_zero_iff'.1 h0).2
      simp only [beq_land_false hA, hK, cond_false]
      rw [ih, tv_eq_zero_of_land ha hA (or_land_eq_zero hak hUa), zero_add]

/-- **Point `k` in**: on a set with `k` and no neighbour of `k`, the residual's value on the rest. -/
theorem val_stepIn {k a U : ℕ} (hk : k < 27) (ha : a < M27) (hak : a.testBit k = false)
    (hU : U.testBit k = false) (hUa : U &&& a = 0) (L : List ℕ) :
    val U (stepIn (2 ^ k) a L) = val (2 ^ k ||| U) L := by
  rw [stepIn, val_mergeR, val_shift_keep hk ha hak hU hUa]

/-! ### The DFS -/

theorem dfsR_nil (leaf : ℕ → List ℕ → Bool) (k S : ℕ) (L : List ℕ) : dfsR leaf [] k S L = leaf S L := rfl

theorem dfsR_cons (leaf : ℕ → List ℕ → Bool) (a : ℕ) (as : List ℕ) (k S : ℕ) (L : List ℕ) :
    dfsR leaf (a :: as) k S L =
      (dfsR leaf as (k + 1) S (stepOut (2 ^ k) L) &&
        (a &&& S != 0 || dfsR leaf as (k + 1) (S ||| 2 ^ k) (stepIn (2 ^ k) a L))) := rfl

theorem collectR_nil (k S : ℕ) (L : List ℕ) : collectR [] k S L = [(S, L)] := rfl

theorem collectR_cons (a : ℕ) (as : List ℕ) (k S : ℕ) (L : List ℕ) :
    collectR (a :: as) k S L =
      (collectR as (k + 1) S (stepOut (2 ^ k) L) ++
        bif a &&& S != 0 then [] else collectR as (k + 1) (S ||| 2 ^ k) (stepIn (2 ^ k) a L)) := rfl

/-- The masks are well formed from point `k` on: each at a point `< 27`, below `2²⁷`, without its own bit. -/
def WfAdj : List ℕ → ℕ → Prop
  | [], _ => True
  | a :: as, k => k < 27 ∧ a < M27 ∧ a.testBit k = false ∧ WfAdj as (k + 1)

/-- The set `W` is independent in the masks from point `k` on: each of its points there misses its mask. -/
def IndepFrom : List ℕ → ℕ → ℕ → Prop
  | [], _, _ => True
  | a :: as, k, W => (W.testBit k = true → a &&& W = 0) ∧ IndepFrom as (k + 1) W

theorem tv_zero (t : ℕ) : tv 0 t = bif Nat.beq (Nat.mod t M27) 0 then cf t else 0 := by
  have hk : (key t &&& 0 == key t) = Nat.beq (Nat.mod t M27) 0 := by
    rw [Nat.and_zero]
    cases h : Nat.beq (Nat.mod t M27) 0
    · have : t % M27 ≠ 0 := Nat.ne_of_beq_eq_false h
      exact beq_eq_false_iff_ne.2 (fun h' => this h'.symm)
    · have : t % M27 = 0 := Nat.eq_of_beq_eq_true h
      exact beq_iff_eq.2 this.symm
  simp only [tv, hk]

theorem val0_eq (L : List ℕ) : val0 L = val 0 L := by
  induction L with
  | nil => rfl
  | cons t L ih =>
    rw [val_cons, ← ih, tv_zero]
    change cond (Nat.beq (Nat.mod t M27) 0) (Int.add (Int.subNatNat (Nat.div t M27) OFFC) (val0 L)) (val0 L) = _
    cases Nat.beq (Nat.mod t M27) 0
    · simp
    · simp only [cond_true, cf]
      change Int.subNatNat _ _ + val0 L = _
      rw [Int.subNatNat_eq_coe]
      rfl

/-- **The residual DFS is sound**: if it accepts from point `k` with the set `S` and residual `L`, every set `U` of the
points `k, …` that `S ||| U` leaves independent has `val U L ≤ D`. -/
theorem dfsR_sound (D : ℤ) : ∀ (as : List ℕ) (k S : ℕ) (L : List ℕ), dfsR (leafOk D) as k S L = true →
    WfAdj as k → ∀ U : ℕ, (∀ i, U.testBit i = true → k ≤ i ∧ i < k + as.length) →
      IndepFrom as k (S ||| U) → val U L ≤ D
  | [], k, S, L, h, _, U, hU, _ => by
    have hU0 : U = 0 := Nat.eq_of_testBit_eq fun i => by
      rw [Nat.zero_testBit]
      by_contra hc
      have := hU i (by simpa using hc)
      simp at this; omega
    subst hU0
    rw [dfsR_nil, leafOk, decide_eq_true_eq, val0_eq] at h
    exact h
  | a :: as, k, S, L, h, hW, U, hU, hI => by
    obtain ⟨hk, ha, hak, hW'⟩ := hW
    obtain ⟨hI1, hI2⟩ := hI
    rw [dfsR_cons, Bool.and_eq_true, Bool.or_eq_true] at h
    obtain ⟨hout, hin⟩ := h
    simp only [List.length_cons] at hU
    by_cases hUk : U.testBit k = true
    · -- `k ∈ U`: the in branch
      have haW := hI1 (by rw [Nat.testBit_or, hUk, Bool.or_true])
      have haS : a &&& S = 0 := by
        rw [land_eq_zero_iff] at haW ⊢
        intro i hi
        have := haW i hi
        rw [Nat.testBit_or, Bool.or_eq_false_iff] at this
        exact this.1
      have hin' : dfsR (leafOk D) as (k + 1) (S ||| 2 ^ k) (stepIn (2 ^ k) a L) = true := by
        rcases hin with h1 | h1
        · rw [haS] at h1; exact absurd h1 (by decide)
        · exact h1
      set U' := U ^^^ 2 ^ k with hU'
      have hU'k : U'.testBit k = false := by simp [hU', Nat.testBit_xor, hUk]
      have hUeq : U = 2 ^ k ||| U' := by
        apply Nat.eq_of_testBit_eq
        intro i
        simp only [hU', Nat.testBit_or, Nat.testBit_xor, Nat.testBit_two_pow]
        by_cases hik : k = i
        · subst hik; simp [hUk]
        · simp [hik]
      have hU'a : U' &&& a = 0 := by
        rw [land_eq_zero_iff]
        intro i hi
        by_contra hai
        have hai' : a.testBit i = true := by simpa using hai
        have := (land_eq_zero_iff _ _).1 haW i hai'
        rw [Nat.testBit_or, Bool.or_eq_false_iff] at this
        by_cases hik : i = k
        · subst hik; rw [hU'k] at hi; exact Bool.false_ne_true hi
        · have : U'.testBit i = U.testBit i := by
            simp [hU', Nat.testBit_xor, Ne.symm hik]
          rw [this, ‹(S.testBit i = false ∧ U.testBit i = false)›.2] at hi
          exact Bool.false_ne_true hi
      rw [hUeq, ← val_stepIn hk ha hak hU'k hU'a]
      refine dfsR_sound D as (k + 1) (S ||| 2 ^ k) _ hin' hW' U' ?_ ?_
      · intro i hi
        have hik : i ≠ k := by rintro rfl; rw [hU'k] at hi; exact Bool.false_ne_true hi
        have := hU i (by
          rw [hUeq, Nat.testBit_or]; simp [hi])
        omega
      · have : S ||| 2 ^ k ||| U' = S ||| U := by
          rw [hUeq, Nat.or_assoc]
        rw [this]; exact hI2
    · -- `k ∉ U`: the out branch
      have hUk' : U.testBit k = false := by simpa using hUk
      rw [← val_stepOut hk hUk' L]
      refine dfsR_sound D as (k + 1) S _ hout hW' U ?_ hI2
      intro i hi
      have := hU i hi
      have hik : i ≠ k := by rintro rfl; rw [hUk'] at hi; exact Bool.false_ne_true hi
      omega

/-- The DFS over a list of masks cut in two: the first part's leaves run the second part. -/
theorem dfsR_append (leaf : ℕ → List ℕ → Bool) : ∀ (as₁ as₂ : List ℕ) (k S : ℕ) (L : List ℕ),
    dfsR leaf (as₁ ++ as₂) k S L = dfsR (fun S L => dfsR leaf as₂ (k + as₁.length) S L) as₁ k S L
  | [], as₂, k, S, L => by simp [dfsR_nil]
  | a :: as₁, as₂, k, S, L => by
    rw [List.cons_append, dfsR_cons, dfsR_cons, dfsR_append leaf as₁ as₂, dfsR_append leaf as₁ as₂]
    simp only [List.length_cons, Nat.add_assoc, Nat.add_comm 1]

/-- The DFS accepts exactly when its leaf test accepts every state it collects. -/
theorem dfsR_eq_all (leaf : ℕ → List ℕ → Bool) : ∀ (as : List ℕ) (k S : ℕ) (L : List ℕ),
    dfsR leaf as k S L = (collectR as k S L).all (fun p => leaf p.1 p.2)
  | [], k, S, L => by simp [dfsR_nil, collectR_nil]
  | a :: as, k, S, L => by
    rw [dfsR_cons, collectR_cons, List.all_append, dfsR_eq_all leaf as, dfsR_eq_all leaf as]
    cases a &&& S != 0 <;> simp


/-! ### Splitting the DFS at literal states, and the rows by module -/

theorem eqL_eq : ∀ {a b : List ℕ}, eqL a b = true → a = b
  | [], [], _ => rfl
  | x :: a, y :: b, h => by
    simp only [eqL, Bool.and_eq_true] at h
    rw [Nat.eq_of_beq_eq_true h.1, eqL_eq h.2]
  | [], _ :: _, h => by simp [eqL] at h
  | _ :: _, [], h => by simp [eqL] at h

theorem eqLL_eq : ∀ {a b : List (List ℕ)}, eqLL a b = true → a = b
  | [], [], _ => rfl
  | x :: a, y :: b, h => by
    simp only [eqLL, Bool.and_eq_true] at h
    rw [eqL_eq h.1, eqLL_eq h.2]
  | [], _ :: _, h => by simp [eqLL] at h
  | _ :: _, [], h => by simp [eqLL] at h

theorem wfAdj_of_wfB : ∀ {as : List ℕ} {k : ℕ}, wfB as k = true → WfAdj as k
  | [], _, _ => trivial
  | a :: as, k, h => by
    simp only [wfB, Bool.and_eq_true, Nat.blt_eq, Bool.not_eq_true'] at h
    exact ⟨h.1.1.1, h.1.1.2, h.1.2, wfAdj_of_wfB h.2⟩

/-- **A split**: if the states one level down pass, the state passes. -/
theorem goodB_of_split {D : ℤ} {as : List ℕ} {k d : ℕ} {st : List ℕ} {out : List (List ℕ)}
    (hs : splitOk as k d st out = true) (hc : out.all (goodB D as d) = true) : goodB D as k st = true := by
  simp only [splitOk, Bool.and_eq_true, Nat.ble_eq] at hs
  obtain ⟨⟨hkd, hdl⟩, heq⟩ := hs
  have hout := eqLL_eq heq
  have hdd : (as.drop k).drop (d - k) = as.drop d := by
    rw [List.drop_drop]; congr 1; omega
  have hsplit : as.drop k = (as.drop k).take (d - k) ++ as.drop d := by
    rw [← hdd, List.take_append_drop]
  have hlen : k + ((as.drop k).take (d - k)).length = d := by
    rw [List.length_take, List.length_drop]; omega
  unfold goodB
  rw [hsplit, dfsR_append, hlen, dfsR_eq_all, List.all_eq_true]
  intro p hp
  have hm : stateL p ∈ out := hout ▸ List.mem_map_of_mem hp
  have := List.all_eq_true.1 hc _ hm
  simpa [goodB, stateL] using this

/-- Joining two lists that pass. -/
theorem all_append_true {α : Type*} {f : α → Bool} {l₁ l₂ : List α} (h₁ : l₁.all f = true) (h₂ : l₂.all f = true) :
    (l₁ ++ l₂).all f = true := by
  rw [List.all_append, h₁, h₂]; rfl

/-- One element that passes. -/
theorem all_singleton_true {α : Type*} {f : α → Bool} {a : α} (h : f a = true) : [a].all f = true := by
  simp [h]

/-- The root state: the DFS from point 0 with the empty set. -/
theorem goodB_root {D : ℤ} {as L : List ℕ} (h : goodB D as 0 (0 :: L) = true) : dfsR (leafOk D) as 0 0 L = true := by
  simpa [goodB] using h

theorem rowsFit_length : ∀ {r c : List ℕ}, rowsFit r c = true → r.length = c.length
  | [], [], _ => rfl
  | _ :: r, _ :: c, h => by
    simp only [rowsFit, Bool.and_eq_true] at h
    simp [rowsFit_length h.2]
  | [], _ :: _, h => by simp [rowsFit] at h
  | _ :: _, [], h => by simp [rowsFit] at h

theorem rowsFit_append : ∀ {r c : List ℕ} (r' c' : List ℕ), rowsFit r c = true →
    rowsFit (r ++ r') (c ++ c') = rowsFit r' c'
  | [], [], _, _, _ => rfl
  | x :: r, y :: c, r', c', h => by
    simp only [rowsFit, Bool.and_eq_true] at h
    simp only [List.cons_append, rowsFit, rowsFit_append r' c' h.2, h.1, Bool.true_and]
  | [], _ :: _, _, _, h => by simp [rowsFit] at h
  | _ :: _, [], _, _, h => by simp [rowsFit] at h

theorem rowsTerms_append : ∀ {r c : List ℕ} (r' c' : List ℕ), r.length = c.length →
    rowsTerms (r ++ r') (c ++ c') = rowsTerms r c ++ rowsTerms r' c'
  | [], [], _, _, _ => by simp [rowsTerms]
  | x :: r, y :: c, r', c', h => by
    simp only [List.length_cons, Nat.add_right_cancel_iff] at h
    simp only [List.cons_append, rowsTerms, rowsTerms_append r' c' h, List.append_assoc]
  | [], _ :: _, _, _, h => by simp at h
  | _ :: _, [], _, _, h => by simp at h

/-- Each module of rows: its rows are isometries (in two halves), they fit, and their terms sort to the given list. -/
def SegsOk (pts : List ℕ) : List (List ℕ) → List (List ℕ) → List (List ℕ) → Prop
  | [], [], [] => True
  | r :: rs, c :: cs, s :: ss =>
    ((∃ n, (r.take n).all (DensityBound.X23Check.rowOk pts) = true ∧
        (r.drop n).all (DensityBound.X23Check.rowOk pts) = true) ∧
      rowsFit r c = true ∧ eqL (sortR (rowsTerms r c)) s = true) ∧ SegsOk pts rs cs ss
  | _, _, _ => False

/-- The modules of rows joined: every row an isometry, every row fitting, and the value of their terms the sorted lists'. -/
theorem segsOk_spec {pts : List ℕ} : ∀ {rs cs ss : List (List ℕ)}, SegsOk pts rs cs ss →
    rs.flatten.all (DensityBound.X23Check.rowOk pts) = true ∧ rowsFit rs.flatten cs.flatten = true ∧
      ∀ U, val U (rowsTerms rs.flatten cs.flatten) = (ss.map (val U)).sum
  | [], [], [], _ => ⟨rfl, rfl, fun _ => rfl⟩
  | r :: rs, c :: cs, s :: ss, h => by
    obtain ⟨⟨⟨n, h0, h1⟩, hfit, hsort⟩, hrest⟩ := h
    obtain ⟨ih1, ih2, ih3⟩ := segsOk_spec hrest
    refine ⟨?_, ?_, fun U => ?_⟩
    · rw [List.flatten_cons, List.all_append, ← List.take_append_drop n r, List.all_append, h0, h1, ih1]; rfl
    · rw [List.flatten_cons, List.flatten_cons, rowsFit_append _ _ hfit, ih2]
    · rw [List.flatten_cons, List.flatten_cons, rowsTerms_append _ _ (rowsFit_length hfit), val_append, ih3,
        ← eqL_eq hsort, List.map_cons, List.sum_cons, val_sortR]
  | [], [], _ :: _, h => h.elim
  | [], _ :: _, _, h => h.elim
  | _ :: _, [], _, h => h.elim
  | _ :: _, _ :: _, [], h => h.elim

end HadwigerNelson.G27

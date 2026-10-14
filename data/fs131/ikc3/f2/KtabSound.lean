import Proofs.HadwigerNelson.Arith.FibreCert
/-!
FS131-IKC3, a probe (not a library module): the soundness of F2's K-table check (item (b) of
`plans/FS131-IKC3-implementation.md` § 3.3). If the literal has the table's length, its length is covered by `R`
pieces of `k` maps, and every piece passes, then the literal *is* `ktable C`, so L3's proof (stated through `ktable C`)
applies to a phase 1 that reads the literal after one rewrite. Core Lean only; the definitions are the probe's
(`tools/fs131_ikc3_ktab.py`), copied.
-/
namespace FS131IKC3KT
open HadwigerNelson.FibreCert

/-- Bool equality of two lists of packed row pairs. -/
def rowsEq : List (Nat × Nat) → List (Nat × Nat) → Bool
  | [], [] => true
  | a :: l, b :: l' => Nat.beq a.1 b.1 && Nat.beq a.2 b.2 && rowsEq l l'
  | _, _ => false

/-- Bool equality of two K-table entries. -/
def entEq (a b : (Nat × Nat × Nat) × List (Nat × Nat)) : Bool :=
  Nat.beq a.1.1 b.1.1 && Nat.beq a.1.2.1 b.1.2.1 && Nat.beq a.1.2.2 b.1.2.2 && rowsEq a.2 b.2

/-- F2's K-table check, piece `r`: maps `[r·k, r·k + k)` of `ktable C` agree with the literal `kt`. -/
def ktabChk (C : Cert) (kt : List ((Nat × Nat × Nat) × List (Nat × Nat))) (k r : Nat) : Bool :=
  let a := ((ktable C).drop (Nat.mul r k)).take k
  let b := (kt.drop (Nat.mul r k)).take k
  Nat.beq a.length b.length && (a.zip b).all fun x => entEq x.1 x.2

theorem rowsEq_eq : ∀ l l' : List (Nat × Nat), rowsEq l l' = true → l = l'
  | [], [], _ => rfl
  | a :: l, b :: l', h => by
    simp only [rowsEq, Bool.and_eq_true, Nat.beq_eq] at h
    obtain ⟨⟨h1, h2⟩, h3⟩ := h
    rw [rowsEq_eq l l' h3, Prod.ext h1 h2]
  | [], _ :: _, h => by simp [rowsEq] at h
  | _ :: _, [], h => by simp [rowsEq] at h

theorem entEq_eq (a b : (Nat × Nat × Nat) × List (Nat × Nat)) (h : entEq a b = true) : a = b := by
  obtain ⟨⟨c, d, e⟩, r⟩ := a
  obtain ⟨⟨c', d', e'⟩, r'⟩ := b
  simp only [entEq, Bool.and_eq_true, Nat.beq_eq] at h
  obtain ⟨⟨⟨h1, h2⟩, h3⟩, h4⟩ := h
  rw [rowsEq_eq _ _ h4, h1, h2, h3]

/-- **The pieces determine the table**: lengths equal, `R` pieces of `k` maps covering the literal, every piece
passing, give `ktable C = kt`. -/
theorem ktable_eq_of_chk (C : Cert) (kt : List ((Nat × Nat × Nat) × List (Nat × Nat))) (k R : Nat)
    (hlen : (ktable C).length = kt.length) (hR : kt.length ≤ R * k) (h : ∀ r < R, ktabChk C kt k r = true) :
    ktable C = kt := by
  apply List.ext_getElem hlen
  intro i h1 h2
  have hk : 0 < k := by
    rcases Nat.eq_zero_or_pos k with hk | hk
    · subst hk; rw [Nat.mul_zero] at hR; omega
    · exact hk
  have hr : i / k < R := (Nat.div_lt_iff_lt_mul hk).2 (by omega)
  have hc := h (i / k) hr
  simp only [ktabChk, Bool.and_eq_true, Nat.beq_eq, List.all_eq_true] at hc
  obtain ⟨-, hall⟩ := hc
  have hi : (i / k) * k + i % k = i := by rw [Nat.mul_comm]; exact Nat.div_add_mod i k
  have hjk : i % k < k := Nat.mod_lt _ hk
  have ha : i % k < (((ktable C).drop (Nat.mul (i / k) k)).take k).length := by
    simp only [List.length_take, List.length_drop, Nat.mul_eq]; omega
  have hb : i % k < ((kt.drop (Nat.mul (i / k) k)).take k).length := by
    simp only [List.length_take, List.length_drop, Nat.mul_eq]; omega
  have hz : i % k < ((((ktable C).drop (Nat.mul (i / k) k)).take k).zip ((kt.drop (Nat.mul (i / k) k)).take k)).length := by
    rw [List.length_zip]; omega
  have he := entEq_eq _ _ (by
    have := hall _ (List.getElem_mem hz)
    rwa [List.getElem_zip] at this)
  simp only [List.getElem_take, List.getElem_drop, Nat.mul_eq] at he
  simpa only [hi] using he

end FS131IKC3KT

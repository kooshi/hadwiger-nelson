import Mathlib.Data.ZMod.Basic
import Mathlib.Tactic.FinCases

/-!
# FS116-V6-COUNT, the count, as a certified computation

Job FS131-I8A (`plans/FS131-I8A-implementation.md`, Stage 2), for `ArcMap.v6_count` (`Plane/RingCalculus/Empty`).

The count's statement speaks of a relation `tip : Fin 4 → ZMod 6 → Prop` (tile, hub). Under its hypothesis that a tile
tips only equal or consecutive hubs, each tile's set of tipped hubs is one of thirteen *tip sets* — none, one hub, two
consecutive hubs (`exists_shape`) — so the statement is a finite check over `13⁴ = 28,561` quadruples, which the kernel
runs (`table`, by `decide +kernel` on a `Bool`: measured 12.3 s, under 8 GiB; no `native_decide`).

**The shape, and why** (`LEAN.md` § The kernel's cost model). The check is a `Bool` (`stmtB`) written with four literal
quantifiers (`allZ`, `anyZ`, `allF`, `anyF`: a `∀`/`∃` over six hubs or four tiles is a six- or four-fold `&&`/`||`),
never a `Decidable` instance over a `Fintype`; its hypotheses come first under `||`, so a quadruple failing one costs
the kernel that hypothesis and no more. `stmtB_sound` reads the `Bool` back as the statement (`CountStmt`), and
`count` composes the three: tip sets, the table, the read-back.

The exact tool `tools/fs131_k8_count.py` counts 72 quadruples meeting the hypotheses, none violating the conclusion;
the kernel agrees that none violates it. One of the 72 is exhibited below (`countModel`).
-/

namespace HadwigerNelson.Plane.V6Count

/-- The statement of FS116-V6-COUNT's count over a relation `tip` (tile, hub). -/
def CountStmt (tip : Fin 4 → ZMod 6 → Prop) : Prop :=
  (∀ a, ∃ i, tip i a) →
  (∀ i a, tip i a → tip i (a + 1) → (∃ j, j ≠ i ∧ tip j a) ∨ ∃ j, j ≠ i ∧ tip j (a + 1)) →
    ∃ a : ZMod 6, (∀ i, tip i a ∨ tip i (a + 3)) ∧ (∀ i, ¬ (tip i a ∧ tip i (a + 3))) ∧
      (∃ i j, i ≠ j ∧ ∀ l, tip l a ↔ l = i ∨ l = j) ∧ (∃ i j, i ≠ j ∧ ∀ l, tip l (a + 3) ↔ l = i ∨ l = j) ∧
      ∀ i, ∃ b, tip i b ∧ tip i (b + 1)

/-- `∀` over the six hubs, as a `Bool`. -/
def allZ (p : ZMod 6 → Bool) : Bool := p 0 && p 1 && p 2 && p 3 && p 4 && p 5
/-- `∃` over the six hubs, as a `Bool`. -/
def anyZ (p : ZMod 6 → Bool) : Bool := p 0 || p 1 || p 2 || p 3 || p 4 || p 5
/-- `∀` over the four tiles, as a `Bool`. -/
def allF (p : Fin 4 → Bool) : Bool := p 0 && p 1 && p 2 && p 3
/-- `∃` over the four tiles, as a `Bool`. -/
def anyF (p : Fin 4 → Bool) : Bool := p 0 || p 1 || p 2 || p 3

/-- `allZ` is `∀` over the hubs. -/
theorem allZ_iff {p : ZMod 6 → Bool} : allZ p = true ↔ ∀ a, p a = true := by
  constructor
  · intro h a
    simp only [allZ, Bool.and_eq_true] at h
    obtain ⟨⟨⟨⟨⟨h0, h1⟩, h2⟩, h3⟩, h4⟩, h5⟩ := h
    fin_cases a <;> assumption
  · intro h
    simp only [allZ, Bool.and_eq_true]
    exact ⟨⟨⟨⟨⟨h 0, h 1⟩, h 2⟩, h 3⟩, h 4⟩, h 5⟩

/-- `anyZ` is `∃` over the hubs. -/
theorem anyZ_iff {p : ZMod 6 → Bool} : anyZ p = true ↔ ∃ a, p a = true := by
  constructor
  · intro h
    simp only [anyZ, Bool.or_eq_true] at h
    rcases h with ((((h | h) | h) | h) | h) | h
    exacts [⟨0, h⟩, ⟨1, h⟩, ⟨2, h⟩, ⟨3, h⟩, ⟨4, h⟩, ⟨5, h⟩]
  · rintro ⟨a, h⟩
    simp only [anyZ, Bool.or_eq_true]
    fin_cases a
    · exact Or.inl (Or.inl (Or.inl (Or.inl (Or.inl h))))
    · exact Or.inl (Or.inl (Or.inl (Or.inl (Or.inr h))))
    · exact Or.inl (Or.inl (Or.inl (Or.inr h)))
    · exact Or.inl (Or.inl (Or.inr h))
    · exact Or.inl (Or.inr h)
    · exact Or.inr h

/-- `allF` is `∀` over the tiles. -/
theorem allF_iff {p : Fin 4 → Bool} : allF p = true ↔ ∀ i, p i = true := by
  constructor
  · intro h i
    simp only [allF, Bool.and_eq_true] at h
    obtain ⟨⟨⟨h0, h1⟩, h2⟩, h3⟩ := h
    fin_cases i <;> assumption
  · intro h
    simp only [allF, Bool.and_eq_true]
    exact ⟨⟨⟨h 0, h 1⟩, h 2⟩, h 3⟩

/-- `anyF` is `∃` over the tiles. -/
theorem anyF_iff {p : Fin 4 → Bool} : anyF p = true ↔ ∃ i, p i = true := by
  constructor
  · intro h
    simp only [anyF, Bool.or_eq_true] at h
    rcases h with ((h | h) | h) | h
    exacts [⟨0, h⟩, ⟨1, h⟩, ⟨2, h⟩, ⟨3, h⟩]
  · rintro ⟨i, h⟩
    simp only [anyF, Bool.or_eq_true]
    fin_cases i
    · exact Or.inl (Or.inl (Or.inl h))
    · exact Or.inl (Or.inl (Or.inr h))
    · exact Or.inl (Or.inr h)
    · exact Or.inr h

/-- The count's statement at a `Bool`-valued relation, as a `Bool`: the hypotheses first, so that a configuration
failing one costs the kernel only that hypothesis. -/
def stmtB (t : Fin 4 → ZMod 6 → Bool) : Bool :=
  !(allZ fun a => anyF fun i => t i a) ||
  (!(allF fun i => allZ fun a => !(t i a) || (!(t i (a + 1)) ||
      ((anyF fun j => (j != i) && t j a) || anyF fun j => (j != i) && t j (a + 1)))) ||
    anyZ fun a => (allF fun i => t i a || t i (a + 3)) && ((allF fun i => !(t i a && t i (a + 3))) &&
      ((anyF fun i => anyF fun j => (i != j) && allF fun l => t l a == (l == i || l == j)) &&
      ((anyF fun i => anyF fun j => (i != j) && allF fun l => t l (a + 3) == (l == i || l == j)) &&
      allF fun i => anyZ fun b => t i b && t i (b + 1)))))

/-- **The read-back**: where the `Bool` is `true`, the count's statement holds of the relation it encodes. -/
theorem stmtB_sound {t : Fin 4 → ZMod 6 → Bool} (h : stmtB t = true) : CountStmt fun i a => t i a = true := by
  intro hcover hhug
  have h1 : (allZ fun a => anyF fun i => t i a) = true := by
    simp only [allZ_iff, anyF_iff]; exact hcover
  have h2 : (allF fun i => allZ fun a => !(t i a) || (!(t i (a + 1)) ||
      ((anyF fun j => (j != i) && t j a) || anyF fun j => (j != i) && t j (a + 1)))) = true := by
    simp only [allF_iff, allZ_iff, anyF_iff, Bool.or_eq_true, Bool.and_eq_true, Bool.not_eq_true', bne_iff_ne, ne_eq]
    intro i a
    by_cases ha : t i a = true
    · by_cases hb : t i (a + 1) = true
      · exact Or.inr (Or.inr (hhug i a ha hb))
      · exact Or.inr (Or.inl (by simpa using hb))
    · exact Or.inl (by simpa using ha)
  simp only [stmtB, h1, h2, Bool.not_true, Bool.false_or] at h
  simp only [anyZ_iff, allF_iff, anyF_iff, Bool.and_eq_true, Bool.or_eq_true, Bool.not_eq_true',
    bne_iff_ne, ne_eq, beq_iff_eq, Bool.and_eq_false_iff] at h
  obtain ⟨a, hA, hB, ⟨i, j, hij, hC⟩, ⟨i', j', hij', hD⟩, hE⟩ := h
  refine ⟨a, hA, ?_, ⟨i, j, hij, fun l => ?_⟩, ⟨i', j', hij', fun l => ?_⟩, hE⟩
  · intro i ⟨h1, h2⟩
    rcases hB i with h | h <;> simp_all
  · show t l a = true ↔ _
    rw [hC l]; simp
  · show t l (a + 3) = true ↔ _
    rw [hD l]; simp

/-- A tile's tip set, encoded: no hub, one hub `a` (`some (a, false)`), or the two consecutive hubs `a`, `a + 1`
(`some (a, true)`). -/
def smem : Option (ZMod 6 × Bool) → ZMod 6 → Bool
  | none, _ => false
  | some (a, false), b => b == a
  | some (a, true), b => b == a || b == a + 1

/-- The thirteen tip sets. -/
def shapes : List (Option (ZMod 6 × Bool)) :=
  [none, some (0, false), some (1, false), some (2, false), some (3, false), some (4, false), some (5, false),
   some (0, true), some (1, true), some (2, true), some (3, true), some (4, true), some (5, true)]

/-- Four tip sets as a relation. -/
def rel (s0 s1 s2 s3 : Option (ZMod 6 × Bool)) : Fin 4 → ZMod 6 → Bool
  | 0 => smem s0
  | 1 => smem s1
  | 2 => smem s2
  | 3 => smem s3

/-- **The certified computation**: the count's statement holds at each of the `13⁴ = 28,561` quadruples of tip sets. -/
theorem table : (shapes.all fun s0 => shapes.all fun s1 => shapes.all fun s2 => shapes.all fun s3 =>
    stmtB (rel s0 s1 s2 s3)) = true := by decide +kernel

/-- No hub is consecutive to both neighbours of a hub's successor: `a − 1 ∉ {a + 1, a + 2, a}` in `ℤ/6`. -/
theorem sub_one_not_cons (a : ZMod 6) : ¬ (a - 1 = a + 1 ∨ a - 1 = a + 1 + 1 ∨ a - 1 = a + 1 - 1) := by
  revert a; decide

/-- Every one-hub tip set is in the list. -/
theorem mem_shapes_single (a : ZMod 6) : some (a, false) ∈ shapes := by
  revert a; decide

/-- Every two-hub tip set is in the list. -/
theorem mem_shapes_double (a : ZMod 6) : some (a, true) ∈ shapes := by
  revert a; decide

/-- **A tile's tip set is one of the thirteen**: a set of hubs any two of which are equal or consecutive is empty, one
hub, or two consecutive hubs. -/
theorem exists_shape {tip : ZMod 6 → Prop} (hcons : ∀ a b, tip a → tip b → b = a ∨ b = a + 1 ∨ b = a - 1) :
    ∃ s ∈ shapes, ∀ b, tip b ↔ smem s b = true := by
  by_cases h : ∃ a, tip a
  · obtain ⟨a, ha⟩ := h
    by_cases h1 : tip (a + 1)
    · have h2 : ¬ tip (a - 1) := fun h2 => sub_one_not_cons a (hcons (a + 1) (a - 1) h1 h2)
      refine ⟨some (a, true), mem_shapes_double a, fun b => ?_⟩
      simp only [smem, Bool.or_eq_true, beq_iff_eq]
      constructor
      · intro hb
        rcases hcons a b ha hb with rfl | rfl | rfl
        · exact Or.inl rfl
        · exact Or.inr rfl
        · exact absurd hb h2
      · rintro (rfl | rfl) <;> assumption
    · by_cases h2 : tip (a - 1)
      · refine ⟨some (a - 1, true), mem_shapes_double _, fun b => ?_⟩
        simp only [smem, Bool.or_eq_true, beq_iff_eq, sub_add_cancel]
        constructor
        · intro hb
          rcases hcons a b ha hb with rfl | rfl | rfl
          · exact Or.inr rfl
          · exact absurd hb h1
          · exact Or.inl rfl
        · rintro (rfl | rfl) <;> assumption
      · refine ⟨some (a, false), mem_shapes_single a, fun b => ?_⟩
        simp only [smem, beq_iff_eq]
        constructor
        · intro hb
          rcases hcons a b ha hb with rfl | rfl | rfl
          · rfl
          · exact absurd hb h1
          · exact absurd hb h2
        · rintro rfl; exact ha
  · refine ⟨none, by simp [shapes], fun b => ?_⟩
    simp only [smem]
    exact ⟨fun hb => absurd ⟨b, hb⟩ h, fun hb => by cases hb⟩

/-- **FS116-V6-COUNT, the count**: the statement of `ArcMap.v6_count`, from the table. -/
theorem count (tip : Fin 4 → ZMod 6 → Prop) (hcons : ∀ i a b, tip i a → tip i b → b = a ∨ b = a + 1 ∨ b = a - 1) :
    CountStmt tip := by
  have hsh : ∀ i, ∃ s ∈ shapes, ∀ b, tip i b ↔ smem s b = true := fun i => exists_shape (hcons i)
  choose s hs hst using hsh
  have htab := table
  simp only [List.all_eq_true] at htab
  have hB := htab (s 0) (hs 0) (s 1) (hs 1) (s 2) (hs 2) (s 3) (hs 3)
  have htip : tip = fun i a => rel (s 0) (s 1) (s 2) (s 3) i a = true := by
    funext i a
    apply propext
    rw [hst i a]
    fin_cases i <;> rfl
  rw [htip]
  exact stmtB_sound hB

/-! ## Spec examples: one of the 72 configurations, and an adversary -/

/-- **Inhabitant of the count's hypotheses**: tiles tipping `{5, 0}`, `{0, 1}`, `{2, 3}`, `{3, 4}` — the hubs `0` and `3`
have two tips each. -/
def countModel : Fin 4 → ZMod 6 → Bool := rel (some (5, true)) (some (0, true)) (some (2, true)) (some (3, true))

/-- The model meets the three hypotheses of `ArcMap.v6_count`. -/
theorem countModel_hyps :
    (∀ a, ∃ i, countModel i a = true) ∧
    (∀ i a b, countModel i a = true → countModel i b = true → b = a ∨ b = a + 1 ∨ b = a - 1) ∧
    ∀ i a, countModel i a = true → countModel i (a + 1) = true →
      (∃ j, j ≠ i ∧ countModel j a = true) ∨ ∃ j, j ≠ i ∧ countModel j (a + 1) = true := by
  decide

/-- **Adversary**: with the last hypothesis dropped the conclusion fails — tiles tipping `{0, 1}`, `{2, 3}`, `{4, 5}` and
nothing cover the hubs, each alone at both of its hubs, and one tile tips no hub. -/
example : stmtB (rel (some (0, true)) (some (2, true)) (some (4, true)) none) = true ∧
    (allZ fun a => anyF fun i => rel (some (0, true)) (some (2, true)) (some (4, true)) none i a) = true ∧
    (allF fun i => anyZ fun b => rel (some (0, true)) (some (2, true)) (some (4, true)) none i b &&
      rel (some (0, true)) (some (2, true)) (some (4, true)) none i (b + 1)) = false := by
  decide

end HadwigerNelson.Plane.V6Count

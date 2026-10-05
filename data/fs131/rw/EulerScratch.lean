import Mathlib

/-! FS131-RW1 scratch: WALK's C6/C8, the pure combinatorics (an Euler circuit of the port structure). To move into `MapGraph`. -/

namespace EulerScratch

variable {α β : Type*}

/-- A closed trail based at `v`: consecutive entries chain (`en a = st b`), the first starts and the last ends at `v`. -/
def BasedTrail (st en : α → β) (v : β) (L : List α) : Prop :=
  ∃ h : L ≠ [], L.IsChain (fun a b => en a = st b) ∧ st (L.head h) = v ∧ en (L.getLast h) = v

/-- Two closed trails based at one point concatenate. -/
theorem BasedTrail.append {st en : α → β} {v : β} {A B : List α} (hA : BasedTrail st en v A) (hB : BasedTrail st en v B) :
    BasedTrail st en v (A ++ B) := by
  obtain ⟨hA0, hAc, hAh, hAl⟩ := hA
  obtain ⟨hB0, hBc, hBh, hBl⟩ := hB
  refine ⟨by simp [hA0], hAc.append hBc ?_, ?_, ?_⟩
  · intro x hx y hy
    rw [List.getLast?_eq_some_getLast hA0, Option.mem_def, Option.some_inj] at hx
    rw [List.head?_eq_some_head hB0, Option.mem_def, Option.some_inj] at hy
    rw [← hx, ← hy, hAl, hBh]
  · rw [List.head_append_of_ne_nil hA0]; exact hAh
  · rw [List.getLast_append_of_ne_nil _ hB0]; exact hBl

/-- Each entry's end is some entry's start. -/
theorem BasedTrail.exists_start {st en : α → β} {v : β} {L : List α} (hL : BasedTrail st en v L) {e : α} (he : e ∈ L) :
    ∃ e' ∈ L, st e' = en e := by
  obtain ⟨hL0, hLc, hLh, hLl⟩ := hL
  obtain ⟨A, B, rfl⟩ := List.append_of_mem he
  rcases B with _ | ⟨b, B⟩
  · refine ⟨(A ++ [e]).head hL0, List.head_mem _, ?_⟩
    rw [hLh, ← hLl, List.getLast_append_of_ne_nil _ (by simp)]; rfl
  · refine ⟨b, by simp, ?_⟩
    have h := (List.isChain_append.mp hLc).2.1
    exact ((List.isChain_cons_cons.mp h).1).symm

/-- **Insertion**: a closed trail based at the start of one of a trail's entries goes in before that entry. -/
theorem BasedTrail.insert {st en : α → β} {v : β} {L : List α} (hL : BasedTrail st en v L) {e : α} (he : e ∈ L) {O : List α}
    (hO : BasedTrail st en (st e) O) :
    ∃ L', BasedTrail st en v L' ∧ (∀ a, a ∈ L' ↔ a ∈ L ∨ a ∈ O) ∧ (L.Nodup → O.Nodup → (∀ a ∈ O, a ∉ L) → L'.Nodup) := by
  obtain ⟨hL0, hLc, hLh, hLl⟩ := hL
  obtain ⟨hO0, hOc, hOh, hOl⟩ := hO
  obtain ⟨A, B, rfl⟩ := List.append_of_mem he
  have hAeB := List.isChain_append.mp hLc
  have heB : (e :: B).IsChain (fun a b => en a = st b) := hAeB.2.1
  have hOeB : (O ++ e :: B).IsChain (fun a b => en a = st b) := by
    refine hOc.append heB fun x hx y hy => ?_
    rw [List.getLast?_eq_some_getLast hO0, Option.mem_def, Option.some_inj] at hx
    simp only [List.head?_cons, Option.mem_def, Option.some_inj] at hy
    rw [← hx, ← hy, hOl]
  refine ⟨A ++ (O ++ e :: B), ⟨by simp, hAeB.1.append hOeB fun x hx y hy => ?_, ?_, ?_⟩, fun a => ?_, fun hn hOn hdis => ?_⟩
  · rw [List.head?_append_of_ne_nil _ hO0, List.head?_eq_some_head hO0, Option.mem_def, Option.some_inj] at hy
    rw [← hy, hOh]
    exact hAeB.2.2 x hx e (by simp)
  · rcases A with _ | ⟨a, A⟩
    · simp only [List.nil_append] at hLh ⊢
      rw [List.head_append_of_ne_nil hO0, hOh]; exact hLh
    · simpa using hLh
  · rw [List.getLast_append_of_ne_nil _ (by simp), List.getLast_append_of_ne_nil _ (by simp)]
    rw [List.getLast_append_of_ne_nil _ (by simp)] at hLl; exact hLl
  · simp only [List.mem_append, List.mem_cons]; tauto
  · rw [List.nodup_append] at hn ⊢
    obtain ⟨hA, heB', hAd⟩ := hn
    refine ⟨hA, List.nodup_append.mpr ⟨hOn, heB', fun x hx y hy => ?_⟩, fun x hx y hy => ?_⟩
    · rintro rfl; exact hdis x hx (List.mem_append_right _ hy)
    · rw [List.mem_append] at hy
      rcases hy with hy | hy
      · rintro rfl; exact hdis x hy (List.mem_append_left _ hx)
      · exact hAd x hx y hy


/-- **A vertex-preserving pairing exists when every vertex has evenly many ports**. -/
theorem exists_vertex_involution [DecidableEq α] [DecidableEq β] (vtx : α → β) :
    ∀ s : Finset α, (∀ b, Even (s.filter fun a => vtx a = b).card) →
      ∃ f : α → α, ∀ a ∈ s, f a ∈ s ∧ f (f a) = a ∧ f a ≠ a ∧ vtx (f a) = vtx a := by
  intro s
  induction s using Finset.strongInduction with
  | H s ih =>
  intro hev
  rcases s.eq_empty_or_nonempty with rfl | ⟨a, ha⟩
  · exact ⟨id, fun a h => absurd h (Finset.notMem_empty a)⟩
  have hfa : a ∈ s.filter fun x => vtx x = vtx a := Finset.mem_filter.mpr ⟨ha, rfl⟩
  obtain ⟨a', ha', haa'⟩ : ∃ a' ∈ s.filter (fun x => vtx x = vtx a), a' ≠ a := by
    by_contra h
    push Not at h
    have : (s.filter fun x => vtx x = vtx a) = {a} := Finset.eq_singleton_iff_unique_mem.mpr ⟨hfa, h⟩
    have h1 := hev (vtx a)
    rw [this, Finset.card_singleton] at h1
    exact Nat.not_even_one h1
  obtain ⟨ha's, hva'⟩ := Finset.mem_filter.mp ha'
  set s' := (s.erase a).erase a' with hs'
  have hs's : s' ⊂ s := (Finset.erase_ssubset (Finset.mem_erase.mpr ⟨haa', ha's⟩)).trans (Finset.erase_ssubset ha)
  have hev' : ∀ b, Even (s'.filter fun x => vtx x = b).card := by
    intro b
    by_cases hb : b = vtx a
    · have h1 : (s.filter fun x => vtx x = b) = insert a (insert a' (s'.filter fun x => vtx x = b)) := by
        ext x; simp only [Finset.mem_filter, Finset.mem_insert, hs', Finset.mem_erase]
        constructor
        · rintro ⟨hx, rfl⟩; by_cases h1 : x = a; · exact Or.inl h1
          by_cases h2 : x = a'; · exact Or.inr (Or.inl h2)
          exact Or.inr (Or.inr ⟨⟨h2, h1, hx⟩, rfl⟩)
        · rintro (rfl | rfl | ⟨⟨-, -, hx⟩, rfl⟩)
          · exact ⟨ha, hb.symm⟩
          · exact ⟨ha's, hva'.trans hb.symm⟩
          · exact ⟨hx, rfl⟩
      have h2 := hev b
      rw [h1, Finset.card_insert_of_notMem (by simp [hs', Ne.symm haa']),
        Finset.card_insert_of_notMem (by simp [hs'])] at h2
      obtain ⟨m, hm⟩ := h2
      exact ⟨m - 1, by omega⟩
    · have h1 : (s'.filter fun x => vtx x = b) = s.filter fun x => vtx x = b := by
        ext x; simp only [Finset.mem_filter, hs', Finset.mem_erase]
        constructor
        · rintro ⟨⟨-, -, hx⟩, h⟩; exact ⟨hx, h⟩
        · rintro ⟨hx, h⟩
          refine ⟨⟨fun h' => hb ?_, fun h' => hb ?_, hx⟩, h⟩
          · rw [← h, h', hva']
          · rw [← h, h']
      rw [h1]; exact hev b
  obtain ⟨f', hf'⟩ := ih s' hs's hev'
  refine ⟨fun x => if x = a then a' else if x = a' then a else f' x, fun x hx => ?_⟩
  by_cases hxa : x = a
  · subst hxa; simp [haa', ha's, hva']
  by_cases hxa' : x = a'
  · subst hxa'; simp [haa', Ne.symm haa', ha, hva']
  have hxs' : x ∈ s' := by simp [hs', hxa, hxa', hx]
  obtain ⟨h1, h2, h3, h4⟩ := hf' x hxs'
  have hfa : f' x ≠ a := fun h => by simp [hs', h] at h1
  have hfa' : f' x ≠ a' := fun h => by simp [hs', h] at h1
  simp only [hxa, hxa', if_false, hfa, hfa', h2]
  exact ⟨Finset.mem_of_mem_erase (Finset.mem_of_mem_erase h1), trivial, h3, h4⟩

end EulerScratch

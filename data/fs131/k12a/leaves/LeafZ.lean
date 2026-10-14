import Proofs.HadwigerNelson.Rigidity.FiniteZhang
/-! First leaf of block Z (scratch; FS131-K12A): the neighbourhood ratio of a finite symmetric Cayley graph. -/
namespace HadwigerNelson.Rigidity
open Finset
variable {G : Type*} [AddCommGroup G] [Finite G]

theorem leafZ {S : Set G} {c : ℝ} (hS : ∀ s ∈ S, -s ∈ S) (h : RatioLe S c) {I : Finset G}
    (hI : SIndep S I) : (I.card : ℝ) ≤ c * (closedNbhd S I).card := by
  classical
  haveI := Fintype.ofFinite G
  set N := closedNbhd S I with hN
  have memN : ∀ y, y ∈ N ↔ y ∈ I ∨ ∃ x ∈ I, y - x ∈ S := fun y => by
    simp [hN, closedNbhd]
  -- a maximum independent set
  obtain ⟨J, hJmem, hJmax⟩ := Finset.exists_max_image ((univ : Finset G).powerset.filter (SIndep S)) Finset.card
    ⟨∅, by simp [SIndep]⟩
  have hJ : SIndep S J := (Finset.mem_filter.mp hJmem).2
  have hmax : ∀ K : Finset G, SIndep S K → K.card ≤ J.card := fun K hK =>
    hJmax K (Finset.mem_filter.mpr ⟨Finset.mem_powerset.mpr (Finset.subset_univ _), hK⟩)
  -- each translate meets `N` in at least `|I|` points
  have step : ∀ t : G, I.card ≤ ((J.map (addRightEmbedding t)).filter (· ∈ N)).card := by
    intro t
    set Jt := J.map (addRightEmbedding t)
    let K := Jt.filter (· ∉ N) ∪ I
    have hK : SIndep S K := by
      intro x hx y hy
      simp only [K, Finset.mem_union, Finset.mem_filter] at hx hy
      rcases hx with ⟨hx, hxN⟩ | hx <;> rcases hy with ⟨hy, hyN⟩ | hy
      · obtain ⟨x', hx', rfl⟩ := Finset.mem_map.mp hx
        obtain ⟨y', hy', rfl⟩ := Finset.mem_map.mp hy
        simpa using hJ x' hx' y' hy'
      · intro hs
        exact hxN ((memN x).mpr (Or.inr ⟨y, hy, by simpa using hS _ hs⟩))
      · intro hs
        exact hyN ((memN y).mpr (Or.inr ⟨x, hx, hs⟩))
      · exact hI x hx y hy
    have hdisj : Disjoint (Jt.filter (· ∉ N)) I := by
      rw [Finset.disjoint_left]
      intro a ha haI
      exact (Finset.mem_filter.mp ha).2 ((memN a).mpr (Or.inl haI))
    have h1 := hmax K hK
    rw [Finset.card_union_of_disjoint hdisj] at h1
    have h2 := Finset.card_filter_add_card_filter_not (s := Jt) (· ∈ N)
    rw [Finset.card_map] at h2
    omega
  -- sum over the translates
  have hsum : ∑ t : G, ((J.map (addRightEmbedding t)).filter (· ∈ N)).card = J.card * N.card := by
    have : ∀ t : G, ((J.map (addRightEmbedding t)).filter (· ∈ N)).card = ∑ y ∈ N, if y - t ∈ J then 1 else 0 := by
      intro t
      rw [Finset.card_eq_sum_ones, Finset.sum_filter, Finset.sum_map]
      rw [← Finset.sum_filter, ← Finset.sum_filter]
      refine Finset.sum_bij (fun x _ => x + t) ?_ ?_ ?_ ?_ <;> simp
      · exact fun a ha hN => ⟨hN, ha⟩
      · exact fun b hb hbt => ⟨b - t, ⟨hbt, by simpa using hb⟩, by simp⟩
    simp_rw [this]
    rw [Finset.sum_comm]
    have hy : ∀ y : G, (∑ t : G, if y - t ∈ J then 1 else 0) = J.card := by
      intro y
      rw [← Finset.sum_filter, ← Finset.card_eq_sum_ones]
      refine Finset.card_bij (fun t _ => y - t) ?_ ?_ ?_ <;> simp
      · intro a ha; exact ⟨y - a, by simpa using ha⟩
    simp [hy, mul_comm]
  have hG : (0 : ℝ) < Nat.card G := by exact_mod_cast Nat.card_pos
  have hα := h J hJ
  have key : (Nat.card G : ℝ) * I.card ≤ J.card * N.card := by
    have : ∑ _t : G, I.card ≤ ∑ t : G, ((J.map (addRightEmbedding t)).filter (· ∈ N)).card :=
      Finset.sum_le_sum fun t _ => step t
    rw [hsum, Finset.sum_const, Finset.card_univ, ← Nat.card_eq_fintype_card, smul_eq_mul] at this
    exact_mod_cast this
  have hN0 : (0 : ℝ) ≤ N.card := Nat.cast_nonneg _
  nlinarith

end HadwigerNelson.Rigidity

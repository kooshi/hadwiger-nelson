p='Proofs/HadwigerNelson/Kempe.lean'
s=open(p).read()
old='''    ∃ C : G.Coloring (Fin k), C u ≠ C v := by
  sorry'''
new='''    ∃ C : G.Coloring (Fin k), C u ≠ C v := by
  choose g hg using h
  obtain ⟨χ, hχ⟩ := Finset.rado_selection (β := fun _ => Fin k) g
  classical
  refine ⟨Coloring.mk χ fun {x y} hxy => ?_, ?_⟩
  · obtain ⟨t, hst, hχt⟩ := hχ {x, y}
    rw [hχt x (by simp), hχt y (by simp)]
    exact (hg t).1 x (hst (by simp)) y (hst (by simp)) hxy
  · obtain ⟨t, -, hχt⟩ := hχ {u, v}
    show χ u ≠ χ v
    rw [hχt u (by simp), hχt v (by simp)]
    exact (hg t).2'''
assert old in s
s=s.replace(old,new)
old2='''      ∃ (s : Set V) (_ : s.Finite) (hu : u ∈ s) (hv : v ∈ s), Forces (G.induce s) k ⟨u, hu⟩ ⟨v, hv⟩ := by
  sorry'''
new2='''      ∃ (s : Set V) (_ : s.Finite) (hu : u ∈ s) (hv : v ∈ s), Forces (G.induce s) k ⟨u, hu⟩ ⟨v, hv⟩ := by
  constructor
  · intro hF
    by_contra hno
    simp only [not_exists] at hno
    refine absurd hF ?_
    intro hF'
    obtain ⟨C, hC⟩ := exists_coloring_ne_of_forall_finset (G := G) (k := k) (u := u) (v := v) fun t => by
      classical
      set s : Set V := ↑t ∪ {u, v} with hs_def
      have hs : s.Finite := (t.finite_toSet).union (Set.toFinite _)
      have hus : u ∈ s := Or.inr (Or.inl rfl)
      have hvs : v ∈ s := Or.inr (Or.inr rfl)
      have hnf := hno s hs hus hvs
      simp only [Forces, not_forall] at hnf
      obtain ⟨C', hC'⟩ := hnf
      refine ⟨fun x => if hx : x ∈ s then C' ⟨x, hx⟩ else C' ⟨u, hus⟩, ?_, ?_⟩
      · intro x hx y hy hxy
        have hxs : x ∈ s := Or.inl hx
        have hys : y ∈ s := Or.inl hy
        simp only [dif_pos hxs, dif_pos hys]
        exact C'.valid (show (G.induce s).Adj ⟨x, hxs⟩ ⟨y, hys⟩ from hxy)
      · simp only [dif_pos hus, dif_pos hvs]
        exact hC'
    exact hC (hF' C)
  · rintro ⟨s, -, hu, hv, hF⟩ C
    exact hF.comap (Embedding.induce s).toHom C'''
assert old2 in s
s=s.replace(old2,new2)
open(p,'w').write(s)

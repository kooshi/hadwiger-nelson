import re,sys
p='Proofs/HadwigerNelson/Kempe.lean'
s=open(p).read()
old_swap='''noncomputable def kempeSwap (C : G.Coloring (Fin k)) (a b : Fin k) (K : Set V) (hK : KempeClosed C a b K) :
    G.Coloring (Fin k) := by
  classical
  exact Coloring.mk (fun v => if v ∈ K then Equiv.swap a b (C v) else C v) (by sorry)
'''
new_swap='''noncomputable def kempeSwap (C : G.Coloring (Fin k)) (a b : Fin k) (K : Set V) (hK : KempeClosed C a b K) :
    G.Coloring (Fin k) := by
  classical
  exact Coloring.mk (fun v => if v ∈ K then Equiv.swap a b (C v) else C v) fun {v w} hvw => by
    by_cases hv : v ∈ K <;> by_cases hw : w ∈ K <;> simp only [hv, hw, if_true, if_false]
    · exact fun h => C.valid hvw ((Equiv.swap a b).injective h)
    · exact swap_ne_of_mem_of_notMem_adj hK hv hw hvw
    · exact fun h => swap_ne_of_mem_of_notMem_adj hK hw hv hvw.symm h.symm
    · exact C.valid hvw
'''
helper='''/-- The properness of a swap across the boundary of `K`: a non-member neighbour of a member wears neither `a` nor
`b` (else it would be a member), while the member's swapped colour is `a` or `b`. -/
private theorem swap_ne_of_mem_of_notMem_adj {C : G.Coloring (Fin k)} {a b : Fin k} {K : Set V}
    (hK : KempeClosed C a b K) {v w : V} (hv : v ∈ K) (hw : w ∉ K) (hvw : G.Adj v w) :
    Equiv.swap a b (C v) ≠ C w := by
  have hwab : ¬ (C w = a ∨ C w = b) := fun h => hw (hK.2 v hv w hvw h)
  rcases hK.1 v hv with h | h <;> rw [h] <;> intro hc <;> apply hwab
  · rw [Equiv.swap_apply_left] at hc; exact Or.inr hc.symm
  · rw [Equiv.swap_apply_right] at hc; exact Or.inl hc.symm

/-- **The Kempe swap**'''
s=s.replace(old_swap,new_swap)
s=s.replace('/-- **The Kempe swap**',helper,1)
s=s.replace('''    {v : V} (hv : v ∈ K) : kempeSwap C a b K hK v = Equiv.swap a b (C v) := by
  sorry''','''    {v : V} (hv : v ∈ K) : kempeSwap C a b K hK v = Equiv.swap a b (C v) := by
  classical
  show (if v ∈ K then Equiv.swap a b (C v) else C v) = _
  rw [if_pos hv]''')
s=s.replace('''    {v : V} (hv : v ∉ K) : kempeSwap C a b K hK v = C v := by
  sorry''','''    {v : V} (hv : v ∉ K) : kempeSwap C a b K hK v = C v := by
  classical
  show (if v ∈ K then Equiv.swap a b (C v) else C v) = _
  rw [if_neg hv]''')
s=s.replace('''    kempeSwap C a b K hK u ≠ kempeSwap C a b K hK v := by
  sorry''','''    kempeSwap C a b K hK u ≠ kempeSwap C a b K hK v := by
  rw [kempeSwap_apply_of_mem hK hu, kempeSwap_apply_of_notMem hK hv, ← huv]
  exact Equiv.swap_apply_ne_self_iff.mpr ⟨hab, hK.1 u hu⟩''')
s=s.replace('''    (hK : KempeClosed C a b K) {u v : V} (hu : u ∈ K) (hv : v ∉ K) : ¬ Forces G k u v := by
  sorry''','''    (hK : KempeClosed C a b K) {u v : V} (hu : u ∈ K) (hv : v ∉ K) : ¬ Forces G k u v := by
  intro hf
  by_cases huv : C u = C v
  · exact kempeSwap_ne_of_mem_of_notMem C hab hK hu hv huv (hf _)
  · exact huv (hf C)''')
open(p,'w').write(s)

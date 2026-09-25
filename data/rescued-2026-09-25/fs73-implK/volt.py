p='Proofs/HadwigerNelson/Kempe.lean'
s=open(p).read()
def rep(old,new):
    global s
    assert s.count(old)==1, old[:80]
    s=s.replace(old,new)
rep('''theorem VoltageEscape.zero_mem_lift (e : VoltageEscape π S D k) : (0 : A) ∈ e.lift := by
  sorry''','''theorem VoltageEscape.zero_mem_lift (e : VoltageEscape π S D k) : (0 : A) ∈ e.lift := by
  refine ⟨by rw [map_zero]; exact e.zero_mem, ?_⟩
  rw [map_zero, zero_sub]
  exact neg_mem e.p_zero''')
rep('''    y + w ∈ e.lift ↔ y ∈ e.lift := by
  sorry''','''    y + w ∈ e.lift ↔ y ∈ e.lift := by
  have hπw : π (y + w) = π y := by rw [map_add, e.V_ker w hw, add_zero]
  have hsub : y + w - e.p (π y) = (y - e.p (π y)) + w := by abel
  simp only [VoltageEscape.lift, Set.mem_setOf_eq, hπw, hsub, AddSubgroup.add_mem_cancel_right _ hw]''')
rep('''    KempeClosed ((addCayleyColoring e.tab e.proper).comap (addCayleyMap π hS hD)) e.a e.b e.lift := by
  sorry''','''    KempeClosed ((addCayleyColoring e.tab e.proper).comap (addCayleyMap π hS hD)) e.a e.b e.lift := by
  refine ⟨fun y hy => e.colour _ hy.1, fun y hy w hyw hw => ?_⟩
  change e.tab (π w) = e.a ∨ e.tab (π w) = e.b at hw
  -- adjacency is a step `w = y + t` with `t = ±s`
  obtain ⟨s, hs, t, ht, rfl⟩ : ∃ s ∈ S, ∃ t ∈ ({s, -s} : Set A), w = y + t := by
    rw [addCayley_adj'] at hyw
    obtain ⟨-, s, hs, h | h⟩ := hyw
    · exact ⟨s, hs, s, Or.inl rfl, h.symm⟩
    · exact ⟨s, hs, -s, Or.inr rfl, by rw [h, add_neg_cancel_right]⟩
  rw [map_add] at hw
  refine ⟨?_, ?_⟩
  · rw [map_add]; exact e.closed _ hy.1 s hs t ht hw
  · have hid : y + t - e.p (π (y + t)) = (y - e.p (π y)) + (e.p (π y) + t - e.p (π y + π t)) := by
      rw [map_add]; abel
    rw [hid]
    exact add_mem hy.2 (e.voltage _ hy.1 s hs t ht hw)''')
open(p,'w').write(s)

import Proofs.HadwigerNelson.RationalFour.Order

/-!
# The four-colour compulsions of rational four-space (FS-131, FS131-KFS1, FS131-IRF1)

**Read aloud, against the informal claim** (`CLOSED-QUESTIONS.md` § 3, the `ℚ⁴` entry; the consolidation run's LV-T3 and LX-T5).
For points `x ≠ y` of `ℚ⁴`, with `w = v₂(|x − y|²)`:
* every proper four-colouring of the unit-distance graph gives `x` and `y` one colour iff `w ≥ 1`
  (`forall_coloring_eq_iff`);
* every one gives them different colours iff `w = 0` (`forall_coloring_ne_iff`);
* some give them one colour and some do not iff `w < 0` (`exists_coloring_eq_and_ne_iff`).

**The structure clause** (A3): every proper four-colouring is, on each component `x₀ + comp`, the residue map onto the unit
tetrahedron followed by a bijection of the four colours (`exists_equiv_coloring_add_eq_residue`); so two proper
four-colourings that agree on one unit tetrahedron agree on its component (`coloring_eq_of_forall_tetra`), and, since every
coset of `P` is dense, two that agree on the rational points of an open set are equal (`coloring_eq_of_eqOn_isOpen`,
`[KubickiLehelMorayne2002]` Thm 4.3's rigidity, which the structure clause implies and does not follow from).

**What it rests on:** the standard three axioms (`#print axioms`, audited at the gate); no outside theorem. `[Zaks1999]` Lemma 1 (pairs at `√2` share a colour) is
`coloring_eq_of_sqDist_two`, proved here by the consolidation run's five-point gadget (LX L4), not imported. `[BendaPerles2000]`'s
description of the component is `mem_comp_iff` (`RationalFour/Order`), proved here.

**Models.** Every theorem here takes a proper four-colouring `c : G.Coloring (Fin 4)`; the residue colourings
`residueColouring a` inhabit that type on `quatGraph` for every shift `a` (`nonempty_coloring`), and through the coordinates
on `ratFourGraph` (`nonempty_ratFourGraph_coloring`), so no statement is vacuous.

**Not claimed:** anything at other numbers of colours; anything in `ℚⁿ`, `n ≠ 4`; novelty (prior art: pending
`[KubickiLehelMorayne2002]`).
-/

namespace HadwigerNelson.RationalFour

open Quaternion

/-! ## Zaks's Lemma 1 -/

/-- **`[Zaks1999]` Lemma 1** (p. 92): every proper four-colouring of the unit-distance graph on `ℚ⁴` gives every two points at
distance `√2` one colour. The gadget `0, 1, h, a, b` (`a = ½(1+i+j−k)`, `b = ½(1+i−j+k)`: nine unit pairs, `|a − b|² = 2`),
moved onto `x, y` by `z ↦ x + (z − a)·q`, `q = (b − a)⁻¹(y − x)` a unit. -/
theorem coloring_eq_of_sqDist_two (c : quatGraph.Coloring (Fin 4)) {x y : ℍ[ℚ]} (h : sqDist x y = 2) : c x = c y := by
  -- the gadget's two apexes `a = ½(1+i+j−k)`, `b = ½(1+i−j+k)`, at squared distance 2
  set a : ℍ[ℚ] := ⟨1 / 2, 1 / 2, 1 / 2, -1 / 2⟩ with ha
  set b : ℍ[ℚ] := ⟨1 / 2, 1 / 2, -1 / 2, 1 / 2⟩ with hb
  have hba : normSq (b - a) = 2 := by rw [ha, hb, normSq_def']; norm_num
  have hba0 : b - a ≠ 0 := fun h0 => by rw [h0, map_zero] at hba; norm_num at hba
  -- the isometry `z ↦ x + (z − a)·q` carrying `a ↦ x`, `b ↦ y`
  set q : ℍ[ℚ] := (b - a)⁻¹ * (y - x) with hq
  have hqn : normSq q = 1 := by
    have hyx : normSq (y - x) = 2 := by rw [← h, sqDist_comm]; rfl
    rw [hq, map_mul, map_inv₀, hba, hyx]
    norm_num
  set φ : ℍ[ℚ] → ℍ[ℚ] := fun z => x + (z - a) * q with hφ
  have hiso : ∀ z w, sqDist (φ z) (φ w) = sqDist z w := by
    intro z w
    simp only [hφ, sqDist]
    rw [show x + (z - a) * q - (x + (w - a) * q) = (z - w) * q by noncomm_ring, map_mul, hqn, mul_one]
  have hφa : φ a = x := by simp only [hφ, sub_self, zero_mul, add_zero]
  have hφb : φ b = y := by
    simp only [hφ, hq]
    rw [mul_inv_cancel_left₀ hba0, add_sub_cancel]
  have adj : ∀ z w, sqDist z w = 1 → c (φ z) ≠ c (φ w) := fun z w hzw =>
    c.valid (show sqDist (φ z) (φ w) = 1 by rw [hiso, hzw])
  have e01 := adj 0 1 (by rw [sqDist, normSq_def']; norm_num)
  have e0h := adj 0 hur (by rw [sqDist, normSq_def']; norm_num [hur])
  have e0a := adj 0 a (by rw [sqDist, normSq_def', ha]; norm_num)
  have e0b := adj 0 b (by rw [sqDist, normSq_def', hb]; norm_num)
  have e1h := adj 1 hur (by rw [sqDist, normSq_def']; norm_num [hur])
  have e1a := adj 1 a (by rw [sqDist, normSq_def', ha]; norm_num)
  have e1b := adj 1 b (by rw [sqDist, normSq_def', hb]; norm_num)
  have eha := adj hur a (by rw [sqDist, normSq_def', ha]; norm_num [hur])
  have ehb := adj hur b (by rw [sqDist, normSq_def', hb]; norm_num [hur])
  rw [← hφa, ← hφb]
  -- four colours on the triangle `0, 1, h` and its two apexes: the apexes share the fourth
  have key : ∀ p0 p1 ph pa pb : Fin 4, p0 ≠ p1 → p0 ≠ ph → p0 ≠ pa → p0 ≠ pb → p1 ≠ ph → p1 ≠ pa → p1 ≠ pb →
      ph ≠ pa → ph ≠ pb → pa = pb := by decide
  exact key _ _ _ _ _ e01 e0h e0a e0b e1h e1a e1b eha ehb

/-! ## Forced equal and forced different -/

/-- **Forced equal** (LX L5): `v₂(|x − y|²) ≥ 1` gives one colour — `x − y = (1 + i) r` with `r` a sum of unit vectors, and
each `(1 + i) u` has squared length 2. -/
theorem coloring_eq_of_mem_pr (c : quatGraph.Coloring (Fin 4)) {x y : ℍ[ℚ]} (h : x - y ∈ pr) : c x = c y := by
  have hn : normSq onePlusI = 2 := by rw [normSq_def']; norm_num [onePlusI]
  -- the motive is quantified over the base point
  have key : ∀ r ∈ comp, ∀ y, c (y + onePlusI * r) = c y := by
    intro r hr
    have hr' : r ∈ AddSubgroup.closure unitSphere := hr
    clear hr
    induction hr' using AddSubgroup.closure_induction with
    | mem u hu =>
      intro y
      apply coloring_eq_of_sqDist_two
      show normSq (y + onePlusI * u - y) = 2
      rw [add_sub_cancel_left, map_mul, hn, show normSq u = 1 from hu, mul_one]
    | zero => intro y; rw [mul_zero, add_zero]
    | add a b _ _ ha hb => intro y; rw [mul_add, ← add_assoc, hb, ha]
    | neg a _ ha =>
      intro y
      have := ha (y + onePlusI * -a)
      rw [mul_neg, neg_add_cancel_right] at this
      rw [mul_neg]
      exact this.symm
  rw [pr, AddSubgroup.mem_map] at h
  obtain ⟨r, hr, hxy⟩ := h
  have hx : x = y + onePlusI * r := by
    rw [show onePlusI * r = x - y from hxy]
    abel
  rw [hx]
  exact key r hr y

/-- **Forced different** (LX L6): a difference in `comp` outside `P` is congruent modulo `P` to a nonzero vertex of the
tetrahedron, a unit vector. -/
theorem coloring_ne_of_mem_comp_of_notMem_pr (c : quatGraph.Coloring (Fin 4)) {x y : ℍ[ℚ]} (hc : x - y ∈ comp)
    (hp : x - y ∉ pr) : c x ≠ c y := by
  obtain ⟨i, hi, -⟩ := existsUnique_tetra_sub_mem_pr hc
  have hi0 : i ≠ 0 := by
    rintro rfl
    apply hp
    simpa [tetra] using hi
  have h1 : c x = c (y + tetra i) :=
    coloring_eq_of_mem_pr c (by rwa [show x - (y + tetra i) = x - y - tetra i by abel])
  rw [h1]
  apply c.valid
  show sqDist (y + tetra i) y = 1
  have := sqDist_tetra hi0
  rw [sqDist, add_sub_cancel_left]
  simpa [sqDist, tetra] using this

/-! ## The residue colourings -/

/-- **The residue of a point of the component**: the vertex of the tetrahedron it is congruent to modulo `P` (`0` outside the
component, where it is never read). -/
noncomputable def residue (z : ℍ[ℚ]) : Fin 4 := by
  classical
  exact if hz : z ∈ comp then (existsUnique_tetra_sub_mem_pr hz).exists.choose else 0

/-- **The residue colouring shifted by `a`**: on the component of `x`, the residue of `x` minus the component's chosen
representative, plus the shift `a` chosen per component. -/
noncomputable def residueCol (a : ℍ[ℚ] ⧸ comp → Fin 4) (x : ℍ[ℚ]) : Fin 4 :=
  residue (x - (QuotientAddGroup.mk x : ℍ[ℚ] ⧸ comp).out) + a (QuotientAddGroup.mk x)

/-- The residue of a point of the component is its vertex of the tetrahedron. -/
private theorem residue_spec {z : ℍ[ℚ]} (hz : z ∈ comp) : z - tetra (residue z) ∈ pr := by
  simp only [residue, dif_pos hz]
  exact (existsUnique_tetra_sub_mem_pr hz).exists.choose_spec

/-- … and the only one. -/
private theorem residue_eq_of_sub_mem_pr {z : ℍ[ℚ]} (hz : z ∈ comp) {i : Fin 4} (hi : z - tetra i ∈ pr) :
    residue z = i :=
  (existsUnique_tetra_sub_mem_pr hz).unique (residue_spec hz) hi

/-- A point minus its component's representative lies in the component. -/
private theorem sub_out_mem_comp (x : ℍ[ℚ]) : x - (QuotientAddGroup.mk x : ℍ[ℚ] ⧸ comp).out ∈ comp := by
  obtain ⟨h, hh⟩ := QuotientAddGroup.mk_out_eq_mul comp x
  rw [hh, sub_add_cancel_left]
  exact neg_mem h.2

/-- Two points of one component with one residue (relative to a common base point) differ by a member of `P`. -/
private theorem sub_mem_pr_of_residue_eq {x y r : ℍ[ℚ]} (hx : x - r ∈ comp) (hy : y - r ∈ comp)
    (h : residue (x - r) = residue (y - r)) : x - y ∈ pr := by
  have h1 := residue_spec hx
  have h2 := residue_spec hy
  rw [h] at h1
  have := sub_mem h1 h2
  rwa [show x - r - tetra (residue (y - r)) - (y - r - tetra (residue (y - r))) = x - y by abel] at this

/-- Every shifted residue colouring is proper (`[Johnson1990]` Thm 3's colouring at the shift `0`). -/
theorem residueCol_ne_of_adj (a : ℍ[ℚ] ⧸ comp → Fin 4) {x y : ℍ[ℚ]} (h : quatGraph.Adj x y) :
    residueCol a x ≠ residueCol a y := by
  have hxy : x - y ∈ comp := unitSphere_subset_comp h
  have hq : (QuotientAddGroup.mk x : ℍ[ℚ] ⧸ comp) = QuotientAddGroup.mk y := by
    rw [QuotientAddGroup.eq]
    rw [show -x + y = -(x - y) by abel]
    exact neg_mem hxy
  intro heq
  simp only [residueCol, hq, add_left_inj] at heq
  have hp := sub_mem_pr_of_residue_eq (by rw [← hq]; exact sub_out_mem_comp x) (sub_out_mem_comp y) heq
  rcases (mem_pr_iff _).1 hp with h0 | h1
  · rw [sub_eq_zero] at h0
    exact quatGraph.loopless.irrefl x (h0 ▸ h)
  · have h' : normSq (x - y) = 1 := h
    rw [val, h', padicValRat.one] at h1
    norm_num at h1

/-- **The residue colouring**, shifted by `a`, as a colouring. -/
noncomputable def residueColouring (a : ℍ[ℚ] ⧸ comp → Fin 4) : quatGraph.Coloring (Fin 4) :=
  SimpleGraph.Coloring.mk (residueCol a) fun h => residueCol_ne_of_adj a h

/-- The model of every hypothesis of this file: proper four-colourings exist. -/
theorem nonempty_coloring : Nonempty (quatGraph.Coloring (Fin 4)) := ⟨residueColouring fun _ => 0⟩

/-- **The residue colouring separates `v₂ = 0`**: one colour forces `x − y ∈ P` or `x − y ∉ comp`. -/
theorem residueCol_eq_imp (a : ℍ[ℚ] ⧸ comp → Fin 4) {x y : ℍ[ℚ]} (h : residueCol a x = residueCol a y) :
    x - y ∈ pr ∨ x - y ∉ comp := by
  by_cases hxy : x - y ∈ comp
  · left
    have hq : (QuotientAddGroup.mk x : ℍ[ℚ] ⧸ comp) = QuotientAddGroup.mk y := by
      rw [QuotientAddGroup.eq, show -x + y = -(x - y) by abel]
      exact neg_mem hxy
    simp only [residueCol, hq, add_left_inj] at h
    exact sub_mem_pr_of_residue_eq (by rw [← hq]; exact sub_out_mem_comp x) (sub_out_mem_comp y) h
  · exact Or.inr hxy

/-- **Free across components**: points in two components are given one colour by one shift and two colours by another. -/
theorem exists_residueCol_eq_and_ne {x y : ℍ[ℚ]} (h : x - y ∉ comp) :
    (∃ a, residueCol a x = residueCol a y) ∧ ∃ a, residueCol a x ≠ residueCol a y := by
  classical
  have hq : (QuotientAddGroup.mk x : ℍ[ℚ] ⧸ comp) ≠ QuotientAddGroup.mk y := by
    rw [Ne, QuotientAddGroup.eq, show -x + y = -(x - y) by abel, neg_mem_iff]
    exact h
  -- shift `y`'s component alone, by `s`
  have hshift : ∀ s : Fin 4, residueCol (Function.update 0 (QuotientAddGroup.mk y) s) x = residueCol 0 x ∧
      residueCol (Function.update 0 (QuotientAddGroup.mk y) s) y = residueCol 0 y + s := by
    intro s
    simp only [residueCol, Function.update_of_ne hq, Function.update_self, Pi.zero_apply, add_zero, and_self]
  refine ⟨⟨Function.update 0 (QuotientAddGroup.mk y) (residueCol 0 x - residueCol 0 y), ?_⟩,
    ⟨Function.update 0 (QuotientAddGroup.mk y) (residueCol 0 x - residueCol 0 y + 1), ?_⟩⟩
  · rw [(hshift _).1, (hshift _).2]
    abel
  · rw [(hshift _).1, (hshift _).2]
    intro h'
    have : (0 : Fin 4) = 1 := by
      have := congrArg (· - residueCol 0 x) h'
      simp only at this
      rw [sub_self] at this
      rw [this]
      abel
    exact absurd this (by decide)

/-! ## The structure clause -/

/-- **The structure clause** (A3; the consolidation run's LX-T5, restated): every proper four-colouring of the unit-distance
graph on `ℚ⁴` (as `quatGraph`) is, on the component `x₀ + comp` of any point `x₀`, the residue map followed by a bijection of
the four colours — `c (x₀ + z) = e (residue z)` for every `z ∈ comp`, where `residue z` is the vertex of the unit tetrahedron
`z` is congruent to modulo `P = (1 + i)·comp` (`existsUnique_tetra_sub_mem_pr`). The bijection is `i ↦ c (x₀ + tetra i)`.
So a proper four-colouring is fixed on a component by its colours on one unit tetrahedron there
(`coloring_eq_of_forall_tetra`). -/
theorem exists_equiv_coloring_add_eq_residue (c : quatGraph.Coloring (Fin 4)) (x₀ : ℍ[ℚ]) :
    ∃ e : Fin 4 ≃ Fin 4, ∀ z ∈ comp, c (x₀ + z) = e (residue z) := by
  let f : Fin 4 → Fin 4 := fun i => c (x₀ + tetra i)
  have hf : Function.Injective f := by
    intro i j hij
    by_contra hne
    exact c.valid (show sqDist (x₀ + tetra i) (x₀ + tetra j) = 1 by
      rw [sqDist, add_sub_add_left_eq_sub]; exact sqDist_tetra hne) hij
  refine ⟨Equiv.ofBijective f (Finite.injective_iff_bijective.1 hf), fun z hz => ?_⟩
  show c (x₀ + z) = c (x₀ + tetra (residue z))
  apply coloring_eq_of_mem_pr
  rw [show x₀ + z - (x₀ + tetra (residue z)) = z - tetra (residue z) by abel]
  exact residue_spec hz

/-- **Two proper four-colourings that agree on a unit tetrahedron agree on its component** (a corollary of the structure
clause, `exists_equiv_coloring_add_eq_residue`): if `c` and `c'` agree at the four points `x₀ + tetra i`, they agree at every
`x₀ + z`, `z ∈ comp`. -/
theorem coloring_eq_of_forall_tetra (c c' : quatGraph.Coloring (Fin 4)) {x₀ : ℍ[ℚ]}
    (h : ∀ i, c (x₀ + tetra i) = c' (x₀ + tetra i)) {z : ℍ[ℚ]} (hz : z ∈ comp) : c (x₀ + z) = c' (x₀ + z) := by
  have hp : x₀ + z - (x₀ + tetra (residue z)) ∈ pr := by
    rw [show x₀ + z - (x₀ + tetra (residue z)) = z - tetra (residue z) by abel]
    exact residue_spec hz
  rw [coloring_eq_of_mem_pr c hp, coloring_eq_of_mem_pr c' hp, h]

/-! ## The compulsion law on the quaternion graph -/

/-- Forced equal, on the quaternion graph: iff `x − y ∈ P`. -/
theorem forall_quatColoring_eq_iff (x y : ℍ[ℚ]) :
    (∀ c : quatGraph.Coloring (Fin 4), c x = c y) ↔ x - y ∈ pr := by
  refine ⟨fun h => ?_, fun h c => coloring_eq_of_mem_pr c h⟩
  by_contra hp
  by_cases hc : x - y ∈ comp
  · exact coloring_ne_of_mem_comp_of_notMem_pr (residueColouring fun _ => 0) hc hp (h _)
  · obtain ⟨-, a, ha⟩ := exists_residueCol_eq_and_ne hc
    exact ha (h (residueColouring a))

/-- Forced different, on the quaternion graph: iff `x − y ∈ comp` and `x − y ∉ P`. -/
theorem forall_quatColoring_ne_iff (x y : ℍ[ℚ]) :
    (∀ c : quatGraph.Coloring (Fin 4), c x ≠ c y) ↔ x - y ∈ comp ∧ x - y ∉ pr := by
  refine ⟨fun h => ⟨?_, fun hp => h _ (coloring_eq_of_mem_pr (residueColouring fun _ => 0) hp)⟩,
    fun ⟨hc, hp⟩ c => coloring_ne_of_mem_comp_of_notMem_pr c hc hp⟩
  by_contra hc
  obtain ⟨⟨a, ha⟩, -⟩ := exists_residueCol_eq_and_ne hc
  exact h (residueColouring a) ha

/-- Free, on the quaternion graph: iff `x` and `y` lie in different components. -/
theorem exists_quatColoring_eq_and_ne_iff (x y : ℍ[ℚ]) :
    ((∃ c : quatGraph.Coloring (Fin 4), c x = c y) ∧ ∃ c : quatGraph.Coloring (Fin 4), c x ≠ c y) ↔
      x - y ∉ comp := by
  constructor
  · rintro ⟨⟨c, hc⟩, ⟨c', hc'⟩⟩ hxy
    by_cases hp : x - y ∈ pr
    · exact hc' (coloring_eq_of_mem_pr c' hp)
    · exact coloring_ne_of_mem_comp_of_notMem_pr c hxy hp hc
  · intro h
    obtain ⟨⟨a, ha⟩, ⟨b, hb⟩⟩ := exists_residueCol_eq_and_ne h
    exact ⟨⟨residueColouring a, ha⟩, ⟨residueColouring b, hb⟩⟩

/-! ## The compulsion law on `ℚ⁴` (the head statements) -/

/-- A colouring of `ratFourGraph` read on `quatGraph` through the coordinates. -/
private theorem exists_quatColoring_of (c : ratFourGraph.Coloring (Fin 4)) :
    ∃ c' : quatGraph.Coloring (Fin 4), ∀ x, c' (toQuat x) = c x :=
  ⟨SimpleGraph.Coloring.mk (fun z => c (toQuat.symm z)) fun {z w} h => c.valid (by
      rw [ratFourGraph_adj, ← sqDist_toQuat, Equiv.apply_symm_apply, Equiv.apply_symm_apply]
      exact quatGraph_adj.1 h),
    fun x => by
      show c (toQuat.symm (toQuat x)) = c x
      rw [Equiv.symm_apply_apply]⟩

/-- A colouring of `quatGraph` read on `ratFourGraph` through the coordinates. -/
private theorem exists_ratColoring_of (c : quatGraph.Coloring (Fin 4)) :
    ∃ c' : ratFourGraph.Coloring (Fin 4), ∀ x, c' x = c (toQuat x) :=
  ⟨SimpleGraph.Coloring.mk (fun x => c (toQuat x)) fun {x y} h => c.valid (by
      rw [quatGraph_adj, sqDist_toQuat]
      exact ratFourGraph_adj.1 h),
    fun _ => rfl⟩

/-- The quantifier over colourings of `ratFourGraph` is the one over colourings of `quatGraph`. -/
private theorem forall_coloring_iff_quat (P : Fin 4 → Fin 4 → Prop) (x y : Fin 4 → ℚ) :
    (∀ c : ratFourGraph.Coloring (Fin 4), P (c x) (c y)) ↔
      ∀ c : quatGraph.Coloring (Fin 4), P (c (toQuat x)) (c (toQuat y)) := by
  constructor
  · intro h c
    obtain ⟨c', hc'⟩ := exists_ratColoring_of c
    rw [← hc', ← hc']
    exact h c'
  · intro h c
    obtain ⟨c', hc'⟩ := exists_quatColoring_of c
    rw [← hc', ← hc']
    exact h c'

/-- The same for the existential quantifier. -/
private theorem exists_coloring_iff_quat (P : Fin 4 → Fin 4 → Prop) (x y : Fin 4 → ℚ) :
    (∃ c : ratFourGraph.Coloring (Fin 4), P (c x) (c y)) ↔
      ∃ c : quatGraph.Coloring (Fin 4), P (c (toQuat x)) (c (toQuat y)) := by
  constructor
  · rintro ⟨c, hc⟩
    obtain ⟨c', hc'⟩ := exists_quatColoring_of c
    exact ⟨c', by rw [hc', hc']; exact hc⟩
  · rintro ⟨c, hc⟩
    obtain ⟨c', hc'⟩ := exists_ratColoring_of c
    exact ⟨c', by rw [hc', hc']; exact hc⟩

/-- **Proper four-colourings of `ℚ⁴` exist** — the model of every hypothesis of the head statements: the residue colouring
(`[Johnson1990]` Thm 3's colouring), read through the coordinates. -/
theorem nonempty_ratFourGraph_coloring : Nonempty (ratFourGraph.Coloring (Fin 4)) :=
  (exists_ratColoring_of (residueColouring fun _ => 0)).elim fun c _ => ⟨c⟩

/-- `v₂` of the squared distance, read on the quaternions. -/
private theorem val_toQuat_sub (x y : Fin 4 → ℚ) : val (toQuat x - toQuat y) = padicValRat 2 (sqDist4 x y) := by
  rw [val, ← sqDist_toQuat]
  rfl

private theorem toQuat_sub_eq_zero {x y : Fin 4 → ℚ} : toQuat x - toQuat y = 0 ↔ x = y := by
  rw [sub_eq_zero, toQuat.injective.eq_iff]

/-- **Forced to one colour** (LV-T3 = LX-T5, first clause): every proper four-colouring of the unit-distance graph on `ℚ⁴`
gives `x` and `y` one colour iff `x = y` or `v₂(|x − y|²) ≥ 1`. -/
theorem forall_coloring_eq_iff (x y : Fin 4 → ℚ) :
    (∀ c : ratFourGraph.Coloring (Fin 4), c x = c y) ↔ x = y ∨ 1 ≤ padicValRat 2 (sqDist4 x y) := by
  rw [forall_coloring_iff_quat (· = ·), forall_quatColoring_eq_iff, mem_pr_iff, toQuat_sub_eq_zero,
    val_toQuat_sub]

/-- **Forced to different colours** (second clause): iff `v₂(|x − y|²) = 0` and `x ≠ y`. -/
theorem forall_coloring_ne_iff (x y : Fin 4 → ℚ) :
    (∀ c : ratFourGraph.Coloring (Fin 4), c x ≠ c y) ↔ padicValRat 2 (sqDist4 x y) = 0 ∧ x ≠ y := by
  rw [forall_coloring_iff_quat (· ≠ ·), forall_quatColoring_ne_iff, mem_pr_iff, mem_comp_iff, toQuat_sub_eq_zero,
    val_toQuat_sub, not_or]
  constructor
  · rintro ⟨h0, hxy, h1⟩
    exact ⟨by omega, hxy⟩
  · rintro ⟨h0, hxy⟩
    exact ⟨h0.ge, hxy, by omega⟩

/-- **Free** (third clause): some proper four-colouring gives `x, y` one colour and another gives them two iff
`v₂(|x − y|²) < 0` — `x` and `y` lie in different components. -/
theorem exists_coloring_eq_and_ne_iff (x y : Fin 4 → ℚ) :
    ((∃ c : ratFourGraph.Coloring (Fin 4), c x = c y) ∧ ∃ c : ratFourGraph.Coloring (Fin 4), c x ≠ c y) ↔
      padicValRat 2 (sqDist4 x y) < 0 := by
  rw [exists_coloring_iff_quat (· = ·), exists_coloring_iff_quat (· ≠ ·), exists_quatColoring_eq_and_ne_iff,
    mem_comp_iff, val_toQuat_sub, not_le]

/-- **Forced equal, applied**: a proper four-colouring of `ℚ⁴` gives one colour to two points whose squared distance has
2-adic valuation at least 1 (`[Zaks1999]` Lemmas 1–2 are the squared distances 2 and 4). -/
theorem coloring_eq_of_one_le_padicValRat (c : ratFourGraph.Coloring (Fin 4)) {x y : Fin 4 → ℚ}
    (h : 1 ≤ padicValRat 2 (sqDist4 x y)) : c x = c y :=
  (forall_coloring_eq_iff x y).2 (Or.inr h) c

/-- **Forced different, applied**: a proper four-colouring of `ℚ⁴` gives two colours to distinct points whose squared distance
has 2-adic valuation 0 (`[Zaks1999]` Theorem 3 is the odd integer distances). -/
theorem coloring_ne_of_padicValRat_eq_zero (c : ratFourGraph.Coloring (Fin 4)) {x y : Fin 4 → ℚ} (hxy : x ≠ y)
    (h : padicValRat 2 (sqDist4 x y) = 0) : c x ≠ c y :=
  (forall_coloring_ne_iff x y).2 ⟨h, hxy⟩ c

/-! ## Rigidity (`[KubickiLehelMorayne2002]` Thm 4.3) -/

/-- Every coset of `P` is dense in `ℝ⁴`: within `ε` of any rational point `x` lies a rational point congruent to `w` modulo
`P` — `(2/3ᵏ)ℤ⁴ ⊆ P`, and the lattice `(2/3ᵏ)ℤ⁴` is `3⁻ᵏ`-dense coordinate by coordinate. -/
private theorem exists_near_sub_mem_pr (w x : Fin 4 → ℚ) {ε : ℝ} (hε : 0 < ε) :
    ∃ z : Fin 4 → ℚ, (∀ j, |(z j : ℝ) - x j| < ε) ∧ toQuat z - toQuat w ∈ pr := by
  obtain ⟨k, hk⟩ := exists_pow_lt_of_lt_one hε (by norm_num : (1 / 3 : ℝ) < 1)
  have hMo : Odd (3 ^ k) := Odd.pow (by decide)
  have hM0 : (0 : ℚ) < ((3 ^ k : ℕ) : ℚ) := by positivity
  set M : ℚ := ((3 ^ k : ℕ) : ℚ) with hM
  let n : Fin 4 → ℤ := fun j => round ((x j - w j) * M / 2)
  refine ⟨fun j => w j + 2 * n j / M, fun j => ?_, ?_⟩
  · have hr := abs_sub_round ((x j - w j) * M / 2)
    have key : |(w j + 2 * n j / M) - x j| ≤ 1 / M := by
      have e : (w j + 2 * n j / M) - x j = -(2 / M) * ((x j - w j) * M / 2 - n j) := by
        field_simp
        ring
      rw [e, abs_mul, abs_neg, abs_of_pos (by positivity : (0 : ℚ) < 2 / M)]
      calc 2 / M * |(x j - w j) * M / 2 - n j| ≤ 2 / M * (1 / 2) := by gcongr
        _ = 1 / M := by ring
    have hkR : ((1 / M : ℚ) : ℝ) < ε := by
      rw [hM]
      push_cast
      rw [one_div, ← inv_pow, ← one_div]
      exact hk
    calc |(((w j + 2 * n j / M : ℚ)) : ℝ) - x j| = ((|(w j + 2 * n j / M) - x j| : ℚ) : ℝ) := by push_cast; rfl
      _ ≤ ((1 / M : ℚ) : ℝ) := by exact_mod_cast key
      _ < ε := hkR
  · have hc : ∀ y : Fin 4 → ℚ, toQuat y = ⟨y 0, y 1, y 2, y 3⟩ := fun y => rfl
    have heq : toQuat (fun j => w j + 2 * n j / M) - toQuat w =
        ⟨((2 * n 0 : ℤ) : ℚ) / M, ((2 * n 1 : ℤ) : ℚ) / M, ((2 * n 2 : ℤ) : ℚ) / M, ((2 * n 3 : ℤ) : ℚ) / M⟩ := by
      rw [hc, hc]
      ext <;> simp only [re_sub, imI_sub, imJ_sub, imK_sub] <;> push_cast <;> ring
    rw [heq, mem_pr_iff]
    by_cases h0 : ((2 * n 0 : ℤ), (2 * n 1 : ℤ), (2 * n 2 : ℤ), (2 * n 3 : ℤ)) = (0, 0, 0, 0)
    · left
      simp only [Prod.mk.injEq] at h0
      obtain ⟨h0, h1, h2, h3⟩ := h0
      ext <;> simp [h0, h1, h2, h3]
    · exact Or.inr ((one_le_val_div_odd hMo h0).2 ⟨n 0 + n 1 + n 2 + n 3, by ring⟩)

/-- **Every proper four-colouring of `ℚ⁴` is rigid** (`[KubickiLehelMorayne2002]` Thm 4.3, p. 50: *"Every 4-coloring of
Q⁴ is S³-dense and, therefore, rigid"* — its rigidity half), rigid in the paper's sense (p. 49): for every open `U` meeting
`ℚ⁴` and every proper four-colouring `c'`, if `c` and `c'` agree on `U ∩ ℚ⁴` then `c = c'`. Here `ℚ⁴` sits in `ℝ⁴` as
`Fin 4 → ℝ`, whose product topology is the Euclidean one. A corollary of the structure clause
(`exists_equiv_coloring_add_eq_residue`, through `coloring_eq_of_forall_tetra`): every coset of `P` is dense, so `U` holds a
point of every residue class of every component, and a colouring is fixed on a component by its four residue colours. -/
theorem coloring_eq_of_eqOn_isOpen (c c' : ratFourGraph.Coloring (Fin 4)) {U : Set (Fin 4 → ℝ)} (hU : IsOpen U)
    (hne : ∃ x : Fin 4 → ℚ, (fun i => (x i : ℝ)) ∈ U)
    (h : ∀ x : Fin 4 → ℚ, (fun i => (x i : ℝ)) ∈ U → c x = c' x) : c = c' := by
  obtain ⟨x, hx⟩ := hne
  obtain ⟨ε, hε, hball⟩ := Metric.isOpen_iff.1 hU _ hx
  obtain ⟨cq, hcq⟩ := exists_quatColoring_of c
  obtain ⟨cq', hcq'⟩ := exists_quatColoring_of c'
  -- `c` and `c'` agree on every vertex of every translated tetrahedron
  have htet : ∀ v : ℍ[ℚ], ∀ i, cq (v + tetra i) = cq' (v + tetra i) := by
    intro v i
    obtain ⟨z, hzx, hz⟩ := exists_near_sub_mem_pr (toQuat.symm (v + tetra i)) x hε
    rw [Equiv.apply_symm_apply] at hz
    have hzU : (fun j => (z j : ℝ)) ∈ U := hball ((dist_pi_lt_iff hε).2 fun j => by
      rw [Real.dist_eq]
      exact hzx j)
    rw [← coloring_eq_of_mem_pr cq hz, ← coloring_eq_of_mem_pr cq' hz, hcq, hcq']
    exact h z hzU
  refine DFunLike.ext c c' fun v => ?_
  rw [← hcq, ← hcq']
  simpa only [add_zero] using coloring_eq_of_forall_tetra cq cq' (htet (toQuat v)) (zero_mem comp)

/-! ## Spec -/

/-- Zaks's Lemma 2 (`[Zaks1999]` p. 92) as an instance of the law: pairs at distance 2 share a colour. -/
example (c : ratFourGraph.Coloring (Fin 4)) : c 0 = c ![2, 0, 0, 0] := by
  apply coloring_eq_of_one_le_padicValRat
  have h4 : sqDist4 0 ![2, 0, 0, 0] = 2 ^ 2 := by
    simp [sqDist4, Fin.sum_univ_four]
  have hv2 : padicValRat 2 (2 : ℚ) = 1 := padicValRat.self (p := 2) (by norm_num)
  rw [h4, padicValRat.pow, hv2]
  norm_num

end HadwigerNelson.RationalFour

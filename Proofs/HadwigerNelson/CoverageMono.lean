import Proofs.HadwigerNelson.Coverage

/-!
# The coverage ratchet (M19)

M18 made distance-to-confinement a number (`minCov`, `tools/coverage.py`); this module makes
the number's *one-way behaviour* a theorem. `CoverAtLeast G k p Q m` says every proper
`k`-colouring shows at least `m` colours on `N(p) ∪ Q`. It is monotone in the graph, in the
class, and antitone in the level — so a **lower** coverage bound, once established, survives
every later construction step (adding edges, adding vertices' worth of edges, widening the
class). Upper bounds enjoy no such transfer: a witnessing colouring of the small graph need
not extend, which is why the instrument re-verifies its pool on every new graph rather than
carrying numbers across. The asymmetry is not a tool convention; it is this module.

At level `k` the property *is* the fan (`fan_iff_coverAtLeast`, via M18's
`fan_iff_coverage`), so the ratchet is a genuine gradient toward confinement, and the
campaign of M19+ — union gadgets, watch `minCov` — is climbing something the kernel
certifies to be climbable.
-/

namespace HadwigerNelson

open SimpleGraph

variable {V : Type*} {G G' : SimpleGraph V} {k m m' : ℕ} {p : V} {Q Q' : List V}

open Classical in
/-- The set of colours a colouring shows on `N(p) ∪ Q`. Classical decidability: this is a
reasoning object (the instrument computes its own copy in Python; nothing here executes). -/
noncomputable def coverColors (G : SimpleGraph V) (p : V) (Q : List V)
    (C : G.Coloring (Fin k)) : Finset (Fin k) :=
  Finset.univ.filter fun c => ∃ v, (G.Adj p v ∨ v ∈ Q) ∧ C v = c

/-- Every proper `k`-colouring shows at least `m` colours on `N(p) ∪ Q`. At `m = k` this is
confinement (`fan_iff_coverAtLeast`); below `k` it is the measured gradient. -/
def CoverAtLeast (G : SimpleGraph V) (k : ℕ) (p : V) (Q : List V) (m : ℕ) : Prop :=
  ∀ C : G.Coloring (Fin k), m ≤ (coverColors G p Q C).card

/-- Weakening the level: `h.anti hm` lowers a coverage bound. -/
theorem CoverAtLeast.anti (h : CoverAtLeast G k p Q m) (hm : m' ≤ m) :
    CoverAtLeast G k p Q m' :=
  fun C => hm.trans (h C)

/-- Widening the class only helps: `N(p) ∪ Q` grows, so every colouring shows at least as
many colours. Dot-usable: `h.mono_subset hQ`. -/
theorem CoverAtLeast.mono_subset (h : CoverAtLeast G k p Q m) (hQ : Q ⊆ Q') :
    CoverAtLeast G k p Q' m := by
  intro C
  refine (h C).trans (Finset.card_le_card fun c hc => ?_)
  simp only [coverColors, Finset.mem_filter, Finset.mem_univ, true_and] at hc ⊢
  obtain ⟨v, hv | hv, hCv⟩ := hc
  · exact ⟨v, Or.inl hv, hCv⟩
  · exact ⟨v, Or.inr (hQ hv), hCv⟩

/-- **The ratchet.** Adding edges anywhere in the graph can only raise coverage: every
proper colouring of the larger graph is one of the smaller (restriction along `G ≤ G'`),
evaluated over a larger neighbourhood. This is the theorem that makes "union a gadget and
re-measure" a climb rather than a walk. Dot-usable: `h.mono_edges hG`. -/
theorem CoverAtLeast.mono_edges (h : CoverAtLeast G k p Q m) (hG : G ≤ G') :
    CoverAtLeast G' k p Q m := by
  intro C
  have h0 := h (Coloring.mk (⇑C) fun hab => C.valid (hG hab))
  refine h0.trans (Finset.card_le_card fun c hc => ?_)
  simp only [coverColors, Finset.mem_filter, Finset.mem_univ, true_and] at hc ⊢
  obtain ⟨v, hv | hv, hCv⟩ := hc
  · exact ⟨v, Or.inl (hG hv), hCv⟩
  · exact ⟨v, Or.inr hv, hCv⟩

/-- **Confinement is full coverage** — the numeric face of M18's `fan_iff_coverage`. -/
theorem fan_iff_coverAtLeast (hp : p ∉ Q) :
    Fan G k p Q ↔ CoverAtLeast G k p Q k := by
  rw [fan_iff_coverage hp]
  constructor
  · intro hcov C
    have huniv : coverColors G p Q C = Finset.univ := by
      refine Finset.eq_univ_iff_forall.mpr fun c => ?_
      simp only [coverColors, Finset.mem_filter, Finset.mem_univ, true_and]
      exact hcov C c
    simp [huniv]
  · intro h C c
    have huniv : coverColors G p Q C = Finset.univ := by
      refine Finset.eq_univ_of_card _
        (le_antisymm (by simpa using Finset.card_le_univ (coverColors G p Q C)) ?_)
      simpa using h C
    have : c ∈ coverColors G p Q C := huniv ▸ Finset.mem_univ c
    simpa only [coverColors, Finset.mem_filter, Finset.mem_univ, true_and] using this

/-- The rainbow floor, lifted: a unit triangle inside the class already forces three
colours onto `N(p) ∪ Q` — the level every 120°-class pivot starts at, and (by the
two-circle theorem) the level no cover-set-internal structure can beat. -/
theorem CoverAtLeast.of_triangle_mem {a b c : V} (ha : a ∈ Q) (hb : b ∈ Q) (hc : c ∈ Q)
    (hab : G.Adj a b) (hac : G.Adj a c) (hbc : G.Adj b c) :
    CoverAtLeast G k p Q 3 := by
  intro C
  have hmem : ∀ v ∈ Q, C v ∈ coverColors G p Q C := fun v hv => by
    simp only [coverColors, Finset.mem_filter, Finset.mem_univ, true_and]
    exact ⟨v, Or.inr hv, rfl⟩
  exact Finset.two_lt_card.mpr
    ⟨C a, hmem a ha, C b, hmem b hb, C c, hmem c hc,
     C.valid hab, C.valid hac, C.valid hbc⟩

/-! ## Specification

The floor established on a concrete triangle, ratcheted into a larger graph, and closed into
a fan through the level-`k` bridge; then vacuity, shown honestly. -/

/-- The rainbow floor on a `K₃` class, from the triangle lemma alone. -/
example : CoverAtLeast (edgeGraph 4 [(0, 1), (0, 2), (1, 2)]) 3 3 [0, 1, 2] 3 :=
  CoverAtLeast.of_triangle_mem (a := 0) (b := 1) (c := 2) (by decide) (by decide) (by decide)
    (edgeGraph_adj_of_mem (by decide) (by decide))
    (edgeGraph_adj_of_mem (by decide) (by decide))
    (edgeGraph_adj_of_mem (by decide) (by decide))

/-- **The ratchet, exercised**: the same floor survives adding an edge — the direction every
gadget-union experiment of the M19+ campaign relies on. -/
example : CoverAtLeast (edgeGraph 4 [(0, 1), (0, 2), (1, 2), (0, 3)]) 3 3 [0, 1, 2] 3 :=
  CoverAtLeast.mono_edges (G := edgeGraph 4 [(0, 1), (0, 2), (1, 2)])
    (CoverAtLeast.of_triangle_mem (a := 0) (b := 1) (c := 2) (by decide) (by decide)
      (by decide)
      (edgeGraph_adj_of_mem (by decide) (by decide))
      (edgeGraph_adj_of_mem (by decide) (by decide))
      (edgeGraph_adj_of_mem (by decide) (by decide)))
    (fun _ _ h => edgeGraph_adj_mono (by decide) h)

/-- **Round-trip with M18**: at level `k` the property is the fan itself — the isolated
pivot over a `K₃` class is confined, by the triangle floor and the bridge. -/
example : Fan (edgeGraph 4 [(0, 1), (0, 2), (1, 2)]) 3 3 [0, 1, 2] :=
  (fan_iff_coverAtLeast (by decide)).mpr
    (CoverAtLeast.of_triangle_mem (a := 0) (b := 1) (c := 2) (by decide) (by decide) (by decide)
      (edgeGraph_adj_of_mem (by decide) (by decide))
      (edgeGraph_adj_of_mem (by decide) (by decide))
      (edgeGraph_adj_of_mem (by decide) (by decide)))

/-- Vacuity, on purpose: with zero colours there are no colourings at all, so every level
holds over the empty quantifier. The instrument's guards, not this definition, refuse the
degenerate questions — this example is the honest record of that division. -/
example : CoverAtLeast (⊥ : SimpleGraph (Fin 1)) 0 0 [] 99 :=
  fun C => absurd (C 0).isLt (by omega)

end HadwigerNelson

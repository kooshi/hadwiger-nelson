import Proofs.HadwigerNelson.Fan

/-!
# Coverage: a fan is exactly compulsory colour coverage (M18)

The reduction that turns confinement from a binary SAT verdict into a gradient. For a pivot
`p` not listed in its own class `Q`:

> `p` is fanned by `Q` **iff** every proper `k`-colouring puts all `k` colours on
> `N(p) ∪ Q`.

One direction is the observation the whole M18 measurement rests on: the pivot's own colour
appears somewhere on `N(p) ∪ Q` (it covers), cannot sit on a neighbour (properness), so it
sits in the class. The other direction is the recolouring move: a colour missing from
`N(p) ∪ Q` can be given to `p`, and the recoloured map separates `p` from all of `Q`.

`tools/coverage.py` measures the minimum of `|colours(N(p) ∪ Q)|` over proper colourings —
`minCov` — whose value `k` is exactly confinement by this theorem, and whose gap below `k`
is the number of colours a construction still has to force. Measured 2026-08-03: both ℤ/3
closures sit at `minCov = 3` of 5, the floor their rainbow triangles alone guarantee.

Like everything downstream of `Fan.lean`, nothing here certifies a concrete instance: a
`minCov = k` reading would be promoted to a claim only through M16's kernel-checked route
(`Fan.of_unsat`), never through the instrument.
-/

namespace HadwigerNelson

variable {V : Type*} {G : SimpleGraph V} {k : ℕ}

/-- **Coverage forces the fan**, with no side condition at all: if a colouring puts every
colour somewhere on `N(p) ∪ Q`, then in particular `p`'s own colour lands there, properness
bars the neighbourhood, and the class is all that is left. This is the direction a
coverage-driven construction consumes (M19), so it travels without the `p ∉ Q` hypothesis
only the converse needs. -/
theorem Fan.of_coverage {p : V} {Q : List V}
    (h : ∀ C : G.Coloring (Fin k), ∀ c : Fin k, ∃ v, (G.Adj p v ∨ v ∈ Q) ∧ C v = c) :
    Fan G k p Q := by
  intro C
  obtain ⟨v, hv | hv, hCv⟩ := h C (C p)
  · exact absurd hCv.symm (C.valid hv)
  · exact ⟨v, hv, hCv.symm⟩

/-- **Fan ⟺ compulsory coverage.** `p` is fanned by `Q` exactly when no proper `k`-colouring
can keep a colour off `N(p) ∪ Q` entirely. The forward direction is the recolouring move — a
colour missing from `N(p) ∪ Q` may be handed to `p`, separating it — and is what makes
`minCov` (`tools/coverage.py`) a *distance*: `minCov = k` is confinement, not merely evidence
of it. Requires only that `p` is not its own partner — true of every distance class, which
never contains its pivot. -/
theorem fan_iff_coverage {p : V} {Q : List V} (hp : p ∉ Q) :
    Fan G k p Q ↔
      ∀ C : G.Coloring (Fin k), ∀ c : Fin k, ∃ v, (G.Adj p v ∨ v ∈ Q) ∧ C v = c := by
  refine ⟨fun hfan C c => ?_, Fan.of_coverage⟩
  by_contra hno
  push Not at hno
  classical
  -- the recolouring move: `p` wears the missing colour, everyone else keeps `C`
  let φ : V → Fin k := fun v => if v = p then c else C v
  have hφp : φ p = c := if_pos rfl
  have hφ : ∀ {v : V}, v ≠ p → φ v = C v := fun hv => if_neg hv
  have hvalid : ∀ {v w : V}, G.Adj v w → φ v ≠ φ w := by
    intro v w hadj
    by_cases hv : v = p <;> by_cases hw : w = p
    · subst hv; subst hw
      exact absurd rfl (G.ne_of_adj hadj)
    · subst hv
      rw [hφp, hφ hw]
      exact (hno w (Or.inl hadj)).symm
    · subst hw
      rw [hφp, hφ hv]
      exact hno v (Or.inl hadj.symm)
    · rw [hφ hv, hφ hw]
      exact C.valid hadj
  obtain ⟨q, hq, hpq⟩ := hfan (SimpleGraph.Coloring.mk φ hvalid)
  change φ p = φ q at hpq
  have hqp : q ≠ p := fun h => hp (h ▸ hq)
  rw [hφp, hφ hqp] at hpq
  exact hno q (Or.inr hq) hpq.symm

/-- **The rainbow floor.** A triangle inside `Q` forces three distinct colours onto `Q` under
any proper colouring — the reason a ℤ/3-closed `1/3`-class starts every coverage count at 3,
and the formal reading of `minCov = 3` as "the triangles alone, and nothing else yet". -/
theorem three_le_card_of_triangle_mem (C : G.Coloring (Fin k)) {Q : List V} {a b c : V}
    (ha : a ∈ Q) (hb : b ∈ Q) (hc : c ∈ Q)
    (hab : G.Adj a b) (hbc : G.Adj b c) (hac : G.Adj a c) :
    3 ≤ (Q.map C).toFinset.card := by
  have hmem : ∀ {v : V}, v ∈ Q → C v ∈ (Q.map C).toFinset := fun hv =>
    List.mem_toFinset.mpr (List.mem_map_of_mem hv)
  exact Finset.two_lt_card.mpr
    ⟨C a, hmem ha, C b, hmem hb, C c, hmem hc, C.valid hab, C.valid hac, C.valid hbc⟩

/-! ## Specification

The reduction read on the smallest genuine fan (`Fan.lean`'s pendant triangle), the refusal
on a graph with no fan, and the rainbow floor on the triangle itself. -/

/-- The pendant triangle's width-two fan, read through the reduction: every 3-colouring puts
all three colours on the pendant's neighbourhood and partners. -/
example (C : (edgeGraph 4 pendantTriangle).Coloring (Fin 3)) (c : Fin 3) :
    ∃ v, ((edgeGraph 4 pendantTriangle).Adj 3 v ∨ v ∈ [1, 2]) ∧ C v = c :=
  (fan_iff_coverage (by decide)).mp (Fan.of_edges (by decide +kernel)) C c

/-- **The negative control**: on the edgeless pair there is no fan, so compulsory coverage
must fail — through `Fan.of_coverage`'s contrapositive, which is what makes a low `minCov`
reading a separation witness rather than an absence of evidence. -/
example : ¬ ∀ C : (edgeGraph 2 []).Coloring (Fin 2), ∀ c : Fin 2,
    ∃ v, ((edgeGraph 2 []).Adj 0 v ∨ v ∈ [1]) ∧ C v = c := fun h => by
  obtain ⟨q, hq, hcq⟩ := (Fan.of_coverage h)
    (SimpleGraph.Coloring.mk id fun hadj => absurd hadj.2 (by simp))
  rw [List.mem_singleton] at hq
  subst hq
  exact absurd hcq (by decide)

/-- The rainbow floor on the pendant triangle's `K₃`: three colours, always. -/
example (C : (edgeGraph 4 pendantTriangle).Coloring (Fin 3)) :
    3 ≤ ([0, 1, 2].map C).toFinset.card :=
  three_le_card_of_triangle_mem (a := 0) (b := 1) (c := 2) C (by decide) (by decide)
    (by decide) (edgeGraph_adj_of_mem (by decide) (by decide))
    (edgeGraph_adj_of_mem (by decide) (by decide))
    (edgeGraph_adj_of_mem (by decide) (by decide))

end HadwigerNelson

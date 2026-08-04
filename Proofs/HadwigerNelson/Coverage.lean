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
  sorry

/-- **Fan ⟺ compulsory coverage.** `p` is fanned by `Q` exactly when no proper `k`-colouring
can keep a colour off `N(p) ∪ Q` entirely. The forward direction is the recolouring move — a
colour missing from `N(p) ∪ Q` may be handed to `p`, separating it — and is what makes
`minCov` (`tools/coverage.py`) a *distance*: `minCov = k` is confinement, not merely evidence
of it. Requires only that `p` is not its own partner — true of every distance class, which
never contains its pivot. -/
theorem fan_iff_coverage {p : V} {Q : List V} (hp : p ∉ Q) :
    Fan G k p Q ↔
      ∀ C : G.Coloring (Fin k), ∀ c : Fin k, ∃ v, (G.Adj p v ∨ v ∈ Q) ∧ C v = c := by
  sorry

/-- **The rainbow floor.** A triangle inside `Q` forces three distinct colours onto `Q` under
any proper colouring — the reason a ℤ/3-closed `1/3`-class starts every coverage count at 3,
and the formal reading of `minCov = 3` as "the triangles alone, and nothing else yet". -/
theorem three_le_card_of_triangle_mem (C : G.Coloring (Fin k)) {Q : List V} {a b c : V}
    (ha : a ∈ Q) (hb : b ∈ Q) (hc : c ∈ Q)
    (hab : G.Adj a b) (hbc : G.Adj b c) (hac : G.Adj a c) :
    3 ≤ (Q.map C).toFinset.card := by
  sorry

end HadwigerNelson

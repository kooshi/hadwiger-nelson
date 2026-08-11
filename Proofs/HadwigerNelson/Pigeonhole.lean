import Proofs.HadwigerNelson.EdgeList
import Proofs.HadwigerNelson.Critical

/-!
# The pigeonhole bridge, the transmuter, and the criticality factorization (M34)

Act One of the two-act anatomy (G15/G16), as kernel vocabulary. Three pieces:

* **The bridge** (`mono_pair_of_not_colorable_append` and its iff): a proper `k`-colouring of
  `(V, E)` avoiding every monochromatic pair of a list `P` *is* a proper colouring of the
  augmented graph `(V, E ++ P)` — so a class-avoidance refutation is an ordinary
  non-colourability fact about an ordinary edge list, and the entire certified SAT chain
  (encoding, mask checker, emitters) applies to it verbatim. M33 §0f F1 observed the clause
  identity tools-side; this is the same fact on the kernel side.

* **The transmuter** (`transmuter`): the five-vertex forcing at the heart of the nine-vertex
  √3-pair core — a centre `z`, its rainbow triangle `a b c`, and a hub `h` seeing `z, b, c`:
  if the triangle is pairwise polychromatic, the hub is forced to `a`'s colour. Decided at
  `4⁵`. Two instances composed through one edge refute the nine-vertex core
  (`Instances/Core9.lean`); measured aside, the forced transfer `h = a` happens across plane
  distance exactly 2 — the ρ₁₅ spindle distance.

* **A1, the criticality factorization** (`not_colorable_iff_covers`): for a vertex `v` whose
  edge-deleted graph is still `k`-colourable, `χ(G) ≥ k + 1` holds **iff** every proper
  `k`-colouring of `G.deleteIncidenceSet v` puts all `k` colours on `N_G(v)`. The 4-onset of
  the coverage curves is a criticality echo — measured at three centres in M33, a theorem
  here. Vocabulary: `Critical.lean`'s `deleteIncidenceSet` model of "G − v" (edges dropped,
  vertex kept — no subtypes), M18's recolouring move.

Nothing in this module mentions a particular witness; the instances live in
`Instances/Core9.lean` and `Instances/Core122/`.
-/

namespace HadwigerNelson

open SimpleGraph

variable {V : Type*} {G : SimpleGraph V} {k : ℕ}

/-! ## The bridge: class avoidance is colourability of the augmented graph -/

/-- A colouring makes some listed pair monochromatic. The pigeonhole conclusions below are
exactly this predicate; it exists so the statement reads as the claim ("some pair of `P` goes
mono") rather than as a bare existential soup. -/
def MonoPair {n : ℕ} (P : List (Fin n × Fin n)) (C : Fin n → Fin k) : Prop :=
  ∃ p ∈ P, C p.1 = C p.2

/-- **The bridge, forward direction — the one the certificates consume.** If the augmented
graph `(V, E ++ P)` has no proper `k`-colouring, then every proper `k`-colouring of `(V, E)`
makes some pair of `P` monochromatic. -/
theorem mono_pair_of_not_colorable_append {n : ℕ} {E P : List (Fin n × Fin n)}
    (h : ¬ (edgeGraph n (E ++ P)).Colorable k)
    (C : (edgeGraph n E).Coloring (Fin k)) : MonoPair P C := by
  sorry

/-- **The bridge, both directions.** The augmented graph is `k`-colourable exactly when some
proper `k`-colouring of the base graph avoids every listed pair. Stated as the iff so the
negative control (an explicit avoiding colouring on a colourable instance) is one rewrite away. -/
theorem colorable_append_iff_exists_avoiding {n : ℕ} {E P : List (Fin n × Fin n)}
    (hP : ∀ p ∈ P, p.1 ≠ p.2) :
    (edgeGraph n (E ++ P)).Colorable k ↔
      ∃ C : (edgeGraph n E).Coloring (Fin k), ¬ MonoPair P C := by
  sorry

/-! ## The transmuter: the five-vertex forcing of the nine-vertex core -/

/-- **The transmuter.** Centre `z` sees its whole triangle `a b c`; hub `h` sees `z`, `b`, `c`
(but not `a`); the triangle is pairwise polychromatic. Then the triangle is rainbow in the
three colours other than `z`'s, the hub avoids `{z, b, c}`'s colours, and exactly `a`'s colour
is left: `h = a`, forced. Four colours, five vertices, `decide`. -/
theorem transmuter {h z a b c : Fin 4}
    (hza : z ≠ a) (hzb : z ≠ b) (hzc : z ≠ c)
    (hhz : h ≠ z) (hhb : h ≠ b) (hhc : h ≠ c)
    (hab : a ≠ b) (hac : a ≠ c) (hbc : b ≠ c) :
    h = a := by
  sorry

/-! ## A1: the criticality factorization -/

/-- **A1 — the criticality factorization.** For a vertex `v` whose edge-deleted graph is still
`k`-colourable: the whole graph refuses `k` colours **iff** every proper `k`-colouring of the
deleted graph covers `v`'s neighbourhood with all `k` colours. The 4-onset arriving exactly at
the last ring (M33, three centres) is this theorem read through vertex-criticality: the fan is
`χ(G) ≥ k + 1` itself, factored at `v`. -/
theorem not_colorable_iff_covers (v : V)
    (hdel : (G.deleteIncidenceSet v).Colorable k) :
    ¬ G.Colorable k ↔
      ∀ C : (G.deleteIncidenceSet v).Coloring (Fin k), ∀ c : Fin k,
        ∃ w, G.Adj v w ∧ C w = c := by
  sorry

/-! ## Specification — validated before any instance is trusted -/

/-- Non-vacuity for the bridge: on the path `0 − 1` with the avoidance pair `(0, 2)`,
the augmented graph is a path plus an edge — 2-colourable — so the pigeonhole must NOT fire,
and an explicit avoiding colouring exists. (Negative control: `fired` requires refusal.) -/
example : (edgeGraph 3 ([(0, 1)] ++ [(0, 2)])).Colorable 2 := by
  sorry

/-- The bridge fires on the triangle: `K₃`'s edges plus the pair `(0, 1)` … is just `K₃`, and at
2 colours the augmented graph refuses, so every proper 2-colouring of the path `0−2, 1−2` makes
`{0, 1}` monochromatic — the smallest genuine pigeonhole, checked end to end. -/
example (C : (edgeGraph 3 [(0, 2), (1, 2)]).Coloring (Fin 2)) :
    MonoPair [((0 : Fin 3), (1 : Fin 3))] C := by
  sorry

/-- A1's negative control: on the pendant triangle, deleting the pendant's incidence leaves the
`K₃`, which 3-colours; and some 3-colouring of the deleted graph misses a colour on the
pendant's neighbourhood (its only neighbour wears one colour), so the whole graph IS
3-colourable — the ← direction refusing, as it must. -/
example : (edgeGraph 4 pendantTriangle).Colorable 3 := by
  sorry

end HadwigerNelson

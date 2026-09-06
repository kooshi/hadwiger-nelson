import Proofs.HadwigerNelson.Critical
import Proofs.HadwigerNelson.PartnerLattice
import Mathlib.Data.Set.Card

/-! # The critical set, and where a pair compulsion can live

M54 (2026-09-05). At `k + 1` colours a graph `G` may force two vertices to agree (`Forces`) or to
differ (`Separated`); the six-colour programme is the hunt for one such compulsion at five colours on
a unit-distance graph, and every 5-chromatic graph ever swept reads zero. This module says WHY, in a
form that constrains every future reading: the **critical set** `CriticalSet G k` — the vertices
whose deletion leaves `G` `k`-colourable — must sit inside the common neighbourhood of a forced-equal
pair, and inside the union of neighbourhoods of a virtual edge. The argument is the spare-colour
recolouring of `SpareColour.lean` applied to a two- or three-point independent set through a
critical vertex: delete `c`, colour the rest with `k` colours, paint `{p, c}` (or `{p, q, c}`) with
the spare colour.

Consequences:

* **The spare-colour lemma is the case `CriticalSet G k = univ`** (a `k`-colourable graph has every
  vertex critical): `not_forces_of_colorable` re-derived as a spec example.
* **In the plane the critical set of a forcing graph has at most two points** — the glue point of
  the forced pair and its mirror (`PartnerLattice.eq_gluePoint_of_unit_pair`) — and NONE when the
  pair is more than two apart. So a 6-forcer built as "5-rigid fabric plus a spindle at distance
  `d > 2`" needs fabric whose 5-chromaticity survives every single vertex deletion: **redundancy
  before rigidity**, the first rung of the five-colour dial, readable at one 4-colour ask per vertex.
* **Single-centre spindle unions are dead for the dial by theorem**: the fused centre is critical
  (delete it and every spindle chord loses its forcing), so any compulsion lives among the centre's
  own neighbours.

The witness of T20 (1,175 points, one spindle on a 1-minimal core) has hundreds of critical vertices
against a maximum degree of 26, so its five-colour zero (T21) is an instance of the theorem, not a
finding.

Stated over an arbitrary vertex type with no finiteness and no decidability, like `Critical.lean`;
`Fintype`/`DecidableRel` arrive only in the cardinality corollary, where a degree is counted. -/

namespace HadwigerNelson

variable {V : Type*} {G : SimpleGraph V} {k : ℕ}

/-- **The critical set at `k` colours**: the vertices whose incident edges, deleted, leave a
`k`-colourable graph. `CriticalSet G k = univ` for a `k`-colourable `G`; for a `(k+1)`-chromatic `G`
it is the set of vertices whose removal drops the chromatic number. -/
def CriticalSet (G : SimpleGraph V) (k : ℕ) : Set V :=
  {c | (G.deleteIncidenceSet c).Colorable k}

theorem mem_criticalSet_iff {c : V} :
    c ∈ CriticalSet G k ↔ (G.deleteIncidenceSet c).Colorable k :=
  Iff.rfl

/-! ## The isolating colouring

One lemma carries everything: through a critical vertex `c`, any independent set `S ∋ c` can be
painted with the spare colour over a `k`-colouring of the rest. `Critical.exists_isolating_of_
colorable_delete` is the case `S = {c}`; `SpareColour`'s two recolourings are the cases `S = {p}` and
`S = {p, q}` with `c` absent (every vertex critical). -/

/-- **A critical vertex isolates any independent set through it.** -/
theorem exists_coloring_isolating_of_mem_criticalSet {c : V} (hc : c ∈ CriticalSet G k)
    (S : Set V) (hcS : c ∈ S) (hS : ∀ ⦃v w : V⦄, v ∈ S → w ∈ S → ¬ G.Adj v w) :
    ∃ C : G.Coloring (Fin (k + 1)),
      (∀ v ∈ S, C v = Fin.last k) ∧ ∀ v, v ∉ S → C v ≠ Fin.last k := by
  sorry

/-! ## The two localization theorems -/

/-- **A critical vertex non-adjacent to `p` separates `p` from every other `q`.** The case `c = p`
is `Critical.not_forces_of_colorable_delete`; the new content is `c ≠ p`. -/
theorem not_forces_of_mem_criticalSet {p q c : V} (hpq : p ≠ q) (hcq : c ≠ q) (hpc : ¬ G.Adj p c)
    (hc : c ∈ CriticalSet G k) : ¬ Forces G (k + 1) p q := by
  sorry

/-- **A critical vertex non-adjacent to both `p` and `q` unites them** (for non-adjacent `p, q`). -/
theorem not_separated_of_mem_criticalSet {p q c : V} (hpq : ¬ G.Adj p q) (hpc : ¬ G.Adj p c)
    (hqc : ¬ G.Adj q c) (hc : c ∈ CriticalSet G k) : ¬ Separated G (k + 1) p q := by
  sorry

/-- **A critical vertex outside a fan's partner list, non-adjacent to the pivot, refutes the fan**
— the general form (`Critical.not_fan_of_colorable_delete` is `c = p`); `Forces` is the width-one
case. -/
theorem not_fan_of_mem_criticalSet {p c : V} {Q : List V} (hp : p ∉ Q) (hcQ : c ∉ Q)
    (hpc : ¬ G.Adj p c) (hc : c ∈ CriticalSet G k) : ¬ Fan G (k + 1) p Q := by
  sorry

/-- **Localization for a fan**: the critical set lies in the pivot's neighbourhood or the partner
list. -/
theorem criticalSet_subset_of_fan {p : V} {Q : List V} (hp : p ∉ Q) (h : Fan G (k + 1) p Q) :
    CriticalSet G k ⊆ G.neighborSet p ∪ {c | c ∈ Q} := by
  sorry

/-- **Localization, forced-equal polarity**: the critical set lies in the common neighbourhood of a
forced-equal pair. In particular neither endpoint is critical. -/
theorem criticalSet_subset_inter_neighborSet_of_forces {p q : V} (hpq : p ≠ q)
    (h : Forces G (k + 1) p q) : CriticalSet G k ⊆ G.neighborSet p ∩ G.neighborSet q := by
  sorry

/-- **Localization, virtual-edge polarity**: every critical vertex is a neighbour of an endpoint of a
forced-distinct non-adjacent pair; neither endpoint is critical. -/
theorem criticalSet_subset_union_neighborSet_of_separated {p q : V} (hpq : ¬ G.Adj p q)
    (h : Separated G (k + 1) p q) : CriticalSet G k ⊆ G.neighborSet p ∪ G.neighborSet q := by
  sorry

theorem not_mem_criticalSet_of_forces {p q : V} (hpq : p ≠ q) (h : Forces G (k + 1) p q) :
    p ∉ CriticalSet G k := by
  sorry

/-! ## The spare-colour lemma as the case `CriticalSet = univ` -/

theorem criticalSet_eq_univ_of_colorable (h : G.Colorable k) : CriticalSet G k = Set.univ := by
  sorry

/-- `SpareColour.not_forces_of_colorable`, re-derived: every vertex is critical, and `p` is not its
own neighbour. -/
example {p q : V} (hG : G.Colorable k) (hpq : p ≠ q) : ¬ Forces G (k + 1) p q := by
  sorry

/-! ## Cardinality -/

/-- **A forced-equal pair caps the critical set by the degree of either endpoint.** -/
theorem encard_criticalSet_le_degree_of_forces [Fintype V] [DecidableRel G.Adj] {p q : V}
    (hpq : p ≠ q) (h : Forces G (k + 1) p q) : (CriticalSet G k).encard ≤ G.degree p := by
  sorry

/-! ## The plane

A drawing `q : ι → ℂ` with every edge a unit pair (the hypothesis `OneDefect` consumes). The common
unit neighbours of two distinct points are the glue point and its mirror, and none exist beyond
distance 2. -/

open Glue in
/-- **In the plane a forcing graph's critical vertices are drawn at the forced pair's two glue
points.** -/
theorem forces_criticalSet_glue {ι : Type*} {G : SimpleGraph ι} (q : ι → ℂ)
    (hq : ∀ i j, G.Adj i j → dist (q i) (q j) = 1) {u v : ι} (hne : q u ≠ q v)
    (h : Forces G (k + 1) u v) :
    ∀ c ∈ CriticalSet G k,
      q c = gluePoint (q u) (q v) 1 1 ∨ q c = reflAxis (q u) (q v) (gluePoint (q u) (q v) 1 1) := by
  sorry

/-- **Beyond distance 2 the critical set is empty**: a 6-forcer spindled at a distance above 2 needs
fabric with no critical vertex at all. -/
theorem criticalSet_eq_empty_of_forces_of_two_lt_dist {ι : Type*} {G : SimpleGraph ι} (q : ι → ℂ)
    (hq : ∀ i j, G.Adj i j → dist (q i) (q j) = 1) {u v : ι} (hd : 2 < dist (q u) (q v))
    (h : Forces G (k + 1) u v) : CriticalSet G k = ∅ := by
  sorry

/-- **At most two critical vertices** for an injective drawing. -/
theorem encard_criticalSet_le_two_of_forces {ι : Type*} {G : SimpleGraph ι} {q : ι → ℂ}
    (hinj : Function.Injective q) (hq : ∀ i j, G.Adj i j → dist (q i) (q j) = 1) {u v : ι}
    (hne : q u ≠ q v) (h : Forces G (k + 1) u v) : (CriticalSet G k).encard ≤ 2 := by
  sorry

/-! ## Spec: the bound is tight

`K₄` minus the edge `{0, 1}` forces `0` and `1` equal at three colours (both must avoid the two
colours of the adjacent pair `{2, 3}`), and its critical set at two colours is exactly `{2, 3}` =
`N(0) ∩ N(1)`: deleting `2` leaves the path `0 – 3 – 1`, deleting `0` leaves the triangle `{1, 2, 3}`. -/

/-- `K₄` minus the edge `{0, 1}`. -/
def k4MinusEdge : SimpleGraph (Fin 4) :=
  SimpleGraph.fromRel fun i j => i ≠ j ∧ ¬ ({i, j} : Finset (Fin 4)) = {0, 1}

example : Forces k4MinusEdge 3 0 1 := by
  sorry

example : (2 : Fin 4) ∈ CriticalSet k4MinusEdge 2 := by
  sorry

example : (0 : Fin 4) ∉ CriticalSet k4MinusEdge 2 := by
  sorry

end HadwigerNelson

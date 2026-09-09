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
  vertex critical): `not_forces_of_colorable` re-derived as a spec example. The vertex-critical case
  (every deletion drops the chromatic number ⟹ no pair compulsion) is folklore of the critical-graph
  literature; the localization to an arbitrary critical set, and its plane form, are this module's.
* **In the plane the critical set of a forcing graph has at most two points** — the glue point of
  the forced pair and its mirror (`PartnerLattice.eq_gluePoint_of_unit_pair`) — and NONE when the
  pair is more than two apart.

  **The unit-edge hypothesis is only half needed** (consolidation, 2026-09-09). The localization
  and the emptiness both hold for a drawing whose edges merely lie in a set `D` of distances, which
  is what M49's `{1, d}` two-distance objects are: a critical vertex then sits at a glue point of
  *some* radius pair from `D`, so a two-distance forcer confines its critical set to at most eight
  points where a unit one confines it to two. **The counting bound `encard_criticalSet_le_two_of_forces`
  does not generalize and is not a gap** — with the radii free the two glue points move with the
  critical vertex, and "at most two" is simply false. Stated for `D` in
  `eq_gluePoint_or_reflAxis_of_mem_criticalSet_of_forces_in`, and for an edge-length bound `M` over
  any metric space in `criticalSet_eq_empty_of_forces_of_two_mul_lt_dist`. So a 6-forcer built as "5-rigid fabric plus a spindle at distance
  `d > 2`" needs fabric whose 5-chromaticity survives every single vertex deletion: **redundancy
  before rigidity**, the first rung of the five-colour dial, readable at one 4-colour ask per vertex.
* **Single-centre spindle unions are dead for the dial by theorem**: the fused centre is critical
  (delete it and every spindle chord loses its forcing), so any compulsion lives among the centre's
  own neighbours.
* **Every stage of the descent has an empty critical set**: it forces a pair five apart in its
  {1, 2}-graph, and no point is within {1, 2}-distance of both endpoints — so a critical vertex on a
  committed object is a bug (the object stopped forcing), a free regression control.

The witness of T20 (1,175 points, one spindle on a 1-minimal core) has hundreds of critical vertices
against a maximum degree of 26, so its five-colour zero (T21) is an instance of the theorem, not a
finding.

## Which direction to reach for

| you have | you want | use |
|---|---|---|
| a colouring of `G` minus a vertex `c` not adjacent to `p` | no forced pair `(p, q)`, any `q ≠ c` | `not_forces_of_mem_criticalSet` |
| the same `c`, adjacent to neither `p` nor `q` | no virtual edge `(p, q)` | `not_separated_of_mem_criticalSet` |
| the same `c`, outside a fan's partner list | no fan at `p` over it | `not_fan_of_mem_criticalSet` |
| a forced pair | the critical set inside its common neighbourhood; a degree bound | `criticalSet_subset_inter_neighborSet_of_forces`, `encard_criticalSet_le_degree_of_forces` |
| a forced pair drawn with unit edges | critical vertices at the two glue points; none beyond 2; at most two | `eq_gluePoint_or_reflAxis_of_mem_criticalSet_of_forces`, `criticalSet_eq_empty_of_forces_of_two_lt_dist`, `encard_criticalSet_le_two_of_forces` |
| a forced pair drawn with edges at distances in `D` (the descent's `{1, d}` objects) | critical vertices at a glue point of *some* radius pair from `D` | `eq_gluePoint_or_reflAxis_of_mem_criticalSet_of_forces_in` |
| the same, with every edge at most `M` | none at all, once the pair is more than `2M` apart | `criticalSet_eq_empty_of_forces_of_two_mul_lt_dist` (any metric space) |
| a packed colouring of an edge list minus a vertex | membership in the critical set | `Critical.colorable_delete_of_packed`, then `mem_criticalSet_iff` (definitional) |

Stated over an arbitrary vertex type with no finiteness and no decidability, like `Critical.lean`;
`Fintype`/`DecidableRel` arrive only in the cardinality corollary, where a degree is counted. -/

namespace HadwigerNelson

variable {V : Type*} {G : SimpleGraph V} {k : ℕ}

/-- **The critical set at `k` colours**: the vertices whose incident edges, deleted, leave a
`k`-colourable graph. `CriticalSet G k = univ` for a `k`-colourable `G`; for a `(k+1)`-chromatic `G`
it is the set of vertices whose removal drops the chromatic number. -/
def CriticalSet (G : SimpleGraph V) (k : ℕ) : Set V :=
  {c | (G.deleteIncidenceSet c).Colorable k}

/-- Membership is definitional: a critical vertex is one whose deleted graph is `k`-colourable. -/
theorem mem_criticalSet_iff {c : V} :
    c ∈ CriticalSet G k ↔ (G.deleteIncidenceSet c).Colorable k :=
  Iff.rfl

/-- A forced pair is forced the other way round — the step every consumer of the localization
theorems needs once; minted here rather than in `Forcer.lean` (48 dependents). -/
theorem Forces.symm {p q : V} (h : Forces G k p q) : Forces G k q p :=
  fun C => (h C).symm

/-! ## The isolating colouring

One lemma carries everything: through a critical vertex `c`, any independent set `S ∋ c` can be
painted with the spare colour over a `k`-colouring of the rest. `Critical.exists_isolating_of_
colorable_delete` is the case `S = {c}`; `SpareColour`'s two recolourings are the cases `S = {p}` and
`S = {p, q}` with `c` absent (every vertex critical). `c ∈ S` is exactly the hypothesis that makes the
deleted edges harmless: an edge of `G` missing from `G − c` touches `c`, hence touches `S`. -/

/-- **A critical vertex isolates any independent set through it.** -/
theorem exists_coloring_isolating_of_mem_criticalSet {c : V} (hc : c ∈ CriticalSet G k)
    (S : Set V) (hcS : c ∈ S) (hS : ∀ ⦃v w : V⦄, v ∈ S → w ∈ S → ¬ G.Adj v w) :
    ∃ C : G.Coloring (Fin (k + 1)),
      (∀ v ∈ S, C v = Fin.last k) ∧ ∀ v, v ∉ S → C v ≠ Fin.last k := by
  classical
  obtain ⟨C'⟩ := hc
  let f : V → Fin (k + 1) := fun v => if v ∈ S then Fin.last k else (C' v).castSucc
  have hvalid : ∀ {v w : V}, G.Adj v w → f v ≠ f w := by
    intro v w hvw
    by_cases hv : v ∈ S <;> by_cases hw : w ∈ S
    · exact absurd hvw (hS hv hw)
    · simp only [f, if_pos hv, if_neg hw]
      exact ((C' w).castSucc_lt_last).ne'
    · simp only [f, if_neg hv, if_pos hw]
      exact ((C' v).castSucc_lt_last).ne
    · simp only [f, if_neg hv, if_neg hw]
      intro h
      have hvc : v ≠ c := fun h' => hv (by rw [h']; exact hcS)
      have hwc : w ≠ c := fun h' => hw (by rw [h']; exact hcS)
      exact C'.valid (SimpleGraph.deleteIncidenceSet_adj.mpr ⟨hvw, hvc, hwc⟩)
        (Fin.castSucc_injective k h)
  refine ⟨SimpleGraph.Coloring.mk f hvalid, fun v hv => ?_, fun v hv => ?_⟩
  · show f v = Fin.last k
    simp only [f, if_pos hv]
  · show f v ≠ Fin.last k
    simp only [f, if_neg hv]
    exact ((C' v).castSucc_lt_last).ne

/-- The two-point set `{p, c}` is independent when `p` and `c` are not adjacent (`c = p` allowed). -/
private theorem pair_indep {p c : V} (hpc : ¬ G.Adj p c) :
    ∀ ⦃v w : V⦄, v ∈ ({p, c} : Set V) → w ∈ ({p, c} : Set V) → ¬ G.Adj v w := by
  intro v w hv hw hvw
  simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at hv hw
  rcases hv with rfl | rfl <;> rcases hw with rfl | rfl
  · exact G.irrefl hvw
  · exact hpc hvw
  · exact hpc hvw.symm
  · exact G.irrefl hvw

/-! ## The localization theorems -/

/-- **A critical vertex non-adjacent to `p` separates `p` from every other `q`.** The case `c = p`
is `Critical.not_forces_of_colorable_delete`; the new content is `c ≠ p`. The hypothesis `c ≠ q` is
what this instance needs (at `c = q` the set `{p, q}` is painted alike and refutes nothing); at
`c = q` the conclusion still holds, by the instance `S = {q}` on the swapped pair. -/
theorem not_forces_of_mem_criticalSet {p q c : V} (hpq : p ≠ q) (hcq : c ≠ q) (hpc : ¬ G.Adj p c)
    (hc : c ∈ CriticalSet G k) : ¬ Forces G (k + 1) p q := by
  intro h
  obtain ⟨C, hS, hnS⟩ :=
    exists_coloring_isolating_of_mem_criticalSet hc {p, c} (by simp) (pair_indep hpc)
  have hp : C p = Fin.last k := hS p (by simp)
  have hq : C q ≠ Fin.last k := hnS q (by
    simp only [Set.mem_insert_iff, Set.mem_singleton_iff, not_or]
    exact ⟨hpq.symm, hcq.symm⟩)
  exact hq ((h C).symm.trans hp)

/-- **A critical vertex non-adjacent to both `p` and `q` unites them** (for non-adjacent `p, q`).
No `p ≠ q`: at `p = q` the compulsion already fails whenever any colouring exists. -/
theorem not_separated_of_mem_criticalSet {p q c : V} (hpq : ¬ G.Adj p q) (hpc : ¬ G.Adj p c)
    (hqc : ¬ G.Adj q c) (hc : c ∈ CriticalSet G k) : ¬ Separated G (k + 1) p q := by
  intro h
  obtain ⟨C, hS, -⟩ := exists_coloring_isolating_of_mem_criticalSet hc {p, q, c} (by simp) (by
    intro v w hv hw hvw
    simp only [Set.mem_insert_iff, Set.mem_singleton_iff] at hv hw
    rcases hv with rfl | rfl | rfl <;> rcases hw with rfl | rfl | rfl
    all_goals first
      | exact G.irrefl hvw
      | exact hpq hvw
      | exact hpq hvw.symm
      | exact hpc hvw
      | exact hpc hvw.symm
      | exact hqc hvw
      | exact hqc hvw.symm)
  exact h C ((hS p (by simp)).trans (hS q (by simp)).symm)

/-- **A critical vertex outside a fan's partner list, non-adjacent to the pivot, refutes the fan**
— the general form (`Critical.not_fan_of_colorable_delete` is `c = p`); `Forces` is the width-one
case. -/
theorem not_fan_of_mem_criticalSet {p c : V} {Q : List V} (hp : p ∉ Q) (hcQ : c ∉ Q)
    (hpc : ¬ G.Adj p c) (hc : c ∈ CriticalSet G k) : ¬ Fan G (k + 1) p Q := by
  intro h
  obtain ⟨C, hS, hnS⟩ :=
    exists_coloring_isolating_of_mem_criticalSet hc {p, c} (by simp) (pair_indep hpc)
  obtain ⟨q, hqQ, hpq⟩ := h C
  have hq : q ∉ ({p, c} : Set V) := by
    simp only [Set.mem_insert_iff, Set.mem_singleton_iff, not_or]
    exact ⟨fun h' => hp (h' ▸ hqQ), fun h' => hcQ (h' ▸ hqQ)⟩
  exact hnS q hq (hpq.symm.trans (hS p (by simp)))

/-- **Localization for a fan**: the critical set lies in the pivot's neighbourhood or the partner
list. -/
theorem criticalSet_subset_of_fan {p : V} {Q : List V} (hp : p ∉ Q) (h : Fan G (k + 1) p Q) :
    CriticalSet G k ⊆ G.neighborSet p ∪ {c | c ∈ Q} := by
  intro c hc
  by_contra hcn
  simp only [Set.mem_union, SimpleGraph.mem_neighborSet, Set.mem_setOf_eq, not_or] at hcn
  exact not_fan_of_mem_criticalSet hp hcn.2 hcn.1 hc h

/-- **Localization, forced-equal polarity**: the critical set lies in the common neighbourhood of a
forced-equal pair. In particular neither endpoint is critical — the endpoints are ruled out first,
through the one-point instance `S = {c}` on the pair and on its swap, and only then is a critical
vertex non-adjacent to an endpoint refuted through `S = {endpoint, c}`. -/
theorem criticalSet_subset_inter_neighborSet_of_forces {p q : V} (hpq : p ≠ q)
    (h : Forces G (k + 1) p q) : CriticalSet G k ⊆ G.neighborSet p ∩ G.neighborSet q := by
  intro c hc
  have hcp : c ≠ p := fun hcp =>
    not_forces_of_mem_criticalSet hpq hpq G.irrefl (hcp ▸ hc) h
  have hcq : c ≠ q := fun hcq =>
    not_forces_of_mem_criticalSet hpq.symm hpq.symm G.irrefl (hcq ▸ hc) h.symm
  refine ⟨?_, ?_⟩
  · by_contra hpc
    exact not_forces_of_mem_criticalSet hpq hcq hpc hc h
  · by_contra hqc
    exact not_forces_of_mem_criticalSet hpq.symm hcp hqc hc h.symm

/-- **Localization, virtual-edge polarity**: every critical vertex is a neighbour of an endpoint of a
forced-distinct non-adjacent pair; neither endpoint is critical (at `c = p` the hypotheses of the
three-point instance hold trivially). -/
theorem criticalSet_subset_union_neighborSet_of_separated {p q : V} (hpq : ¬ G.Adj p q)
    (h : Separated G (k + 1) p q) : CriticalSet G k ⊆ G.neighborSet p ∪ G.neighborSet q := by
  intro c hc
  by_contra hcn
  simp only [Set.mem_union, SimpleGraph.mem_neighborSet, not_or] at hcn
  exact not_separated_of_mem_criticalSet hpq hcn.1 hcn.2 hc h

/-- **Neither endpoint of a forced-equal pair is critical** — the ∩-theorem at `c = p`, where membership
would make `p` its own neighbour. -/
theorem not_mem_criticalSet_of_forces {p q : V} (hpq : p ≠ q) (h : Forces G (k + 1) p q) :
    p ∉ CriticalSet G k :=
  fun hp => G.irrefl (criticalSet_subset_inter_neighborSet_of_forces hpq h hp).1

/-! ## The spare-colour lemma as the case `CriticalSet = univ` -/

/-- **On a `k`-colourable graph every vertex is critical** — the case the spare-colour lemma lives in. -/
theorem criticalSet_eq_univ_of_colorable (h : G.Colorable k) : CriticalSet G k = Set.univ :=
  Set.eq_univ_of_forall fun c =>
    SimpleGraph.Colorable.mono_left (SimpleGraph.deleteIncidenceSet_le G c) h

/-- `SpareColour.not_forces_of_colorable`, re-derived: every vertex is critical, and `p` is not its
own neighbour. -/
example {p q : V} (hG : G.Colorable k) (hpq : p ≠ q) : ¬ Forces G (k + 1) p q :=
  fun h => not_mem_criticalSet_of_forces hpq h (by
    rw [criticalSet_eq_univ_of_colorable hG]; exact Set.mem_univ p)

/-! ## Cardinality -/

/-- **A forced-equal pair caps the critical set by the degree of either endpoint.** -/
theorem encard_criticalSet_le_degree_of_forces [Fintype V] [DecidableRel G.Adj] {p q : V}
    (hpq : p ≠ q) (h : Forces G (k + 1) p q) : (CriticalSet G k).encard ≤ G.degree p := by
  calc (CriticalSet G k).encard ≤ (G.neighborSet p).encard :=
        Set.encard_le_encard fun c hc =>
          (criticalSet_subset_inter_neighborSet_of_forces hpq h hc).1
    _ = ((G.neighborFinset p : Finset V) : Set V).encard := by rw [SimpleGraph.coe_neighborFinset]
    _ = ((G.neighborFinset p).card : ℕ∞) := Set.encard_coe_eq_coe_finsetCard _
    _ = G.degree p := rfl

/-! ## The plane

A drawing `q : ι → ℂ` with every edge a unit pair (the hypothesis `OneDefect` consumes). The common
unit neighbours of two distinct points are the glue point and its mirror, and none exist beyond
distance 2. -/

open Glue in
/-- **In the plane a forcing graph's critical vertices are drawn at a glue point of the forced
pair**, at radii taken from the drawing's own distance set. A critical vertex is adjacent to both
endpoints (`criticalSet_subset_inter_neighborSet_of_forces`), so each of its two distances to them
is an edge length, and `Glue.eq_gluePoint_of_dist_pair` then pins it — the annulus bounds coming
free from the vertex itself.

The distance set is where the content is: at `D = {1}` this is the two-point localization M54
proved, and at `D = {1, d}` — the descent's two-distance objects — it confines the critical set to
the eight glue points of the four radius pairs. Reading the radii off the vertex instead of
constraining them would leave a true statement with nothing in it, since *every* point of the plane
is a glue point of any two distinct points at its own two distances. -/
theorem eq_gluePoint_or_reflAxis_of_mem_criticalSet_of_forces_in {ι : Type*}
    {G : SimpleGraph ι} {D : Set ℝ} (q : ι → ℂ)
    (hq : ∀ i j, G.Adj i j → dist (q i) (q j) ∈ D) {u v : ι} (hne : q u ≠ q v)
    (h : Forces G (k + 1) u v) :
    ∀ c ∈ CriticalSet G k, ∃ r₁ ∈ D, ∃ r₂ ∈ D,
      q c = gluePoint (q u) (q v) r₁ r₂ ∨
        q c = reflAxis (q u) (q v) (gluePoint (q u) (q v) r₁ r₂) := by
  intro c hc
  have huv : u ≠ v := fun h' => hne (by rw [h'])
  obtain ⟨hu, hv⟩ := criticalSet_subset_inter_neighborSet_of_forces huv h hc
  exact ⟨_, hq u c hu, _, hq v c hv,
    Glue.eq_gluePoint_of_dist_pair hne (dist_comm (q u) (q c) ▸ rfl)
      (dist_comm (q v) (q c) ▸ rfl)⟩

open Glue in
/-- **The unit-edge reading**, kept in its M54 form for the callers that speak of unit drawings:
with every edge of the drawing at distance one, the two radii are `1` and the critical vertices sit
at the forced pair's own glue point or its mirror. -/
theorem eq_gluePoint_or_reflAxis_of_mem_criticalSet_of_forces {ι : Type*} {G : SimpleGraph ι}
    (q : ι → ℂ) (hq : ∀ i j, G.Adj i j → dist (q i) (q j) = 1) {u v : ι} (hne : q u ≠ q v)
    (h : Forces G (k + 1) u v) :
    ∀ c ∈ CriticalSet G k,
      q c = gluePoint (q u) (q v) 1 1 ∨ q c = reflAxis (q u) (q v) (gluePoint (q u) (q v) 1 1) :=
  fun c hc => by
    obtain ⟨r₁, hr₁, r₂, hr₂, hcc⟩ :=
      eq_gluePoint_or_reflAxis_of_mem_criticalSet_of_forces_in (D := {1}) q
        (fun i j hij => Set.mem_singleton_iff.mpr (hq i j hij)) hne h c hc
    rwa [Set.mem_singleton_iff.mp hr₁, Set.mem_singleton_iff.mp hr₂] at hcc

/-- **Beyond distance 2 the critical set is empty**: a 6-forcer spindled at a distance above 2 needs
fabric with no critical vertex at all. -/
theorem criticalSet_eq_empty_of_forces_of_two_mul_lt_dist {ι W : Type*} [MetricSpace W]
    {G : SimpleGraph ι} (q : ι → W) {M : ℝ} (hM : 0 ≤ M)
    (hq : ∀ i j, G.Adj i j → dist (q i) (q j) ≤ M)
    {u v : ι} (hd : 2 * M < dist (q u) (q v)) (h : Forces G (k + 1) u v) :
    CriticalSet G k = ∅ := by
  rw [Set.eq_empty_iff_forall_notMem]
  intro c hc
  have huv : u ≠ v := by
    rintro rfl
    simp only [dist_self] at hd
    linarith
  obtain ⟨hu, hv⟩ := criticalSet_subset_inter_neighborSet_of_forces huv h hc
  have hle : dist (q u) (q v) ≤ 2 * M := by
    calc dist (q u) (q v) ≤ dist (q u) (q c) + dist (q c) (q v) := dist_triangle _ _ _
      _ ≤ M + M := add_le_add (hq u c hu) (by rw [dist_comm]; exact hq v c hv)
      _ = 2 * M := by ring
  linarith

/-- **Beyond distance 2 the critical set is empty** — the unit-edge reading (`M = 1`), kept in its
M54 form. -/
theorem criticalSet_eq_empty_of_forces_of_two_lt_dist {ι : Type*} {G : SimpleGraph ι} (q : ι → ℂ)
    (hq : ∀ i j, G.Adj i j → dist (q i) (q j) = 1) {u v : ι} (hd : 2 < dist (q u) (q v))
    (h : Forces G (k + 1) u v) : CriticalSet G k = ∅ :=
  criticalSet_eq_empty_of_forces_of_two_mul_lt_dist q (M := 1) zero_le_one
    (fun i j hij => (hq i j hij).le) (by linarith) h

/-- **At most two critical vertices** for an injective drawing. -/
theorem encard_criticalSet_le_two_of_forces {ι : Type*} {G : SimpleGraph ι} {q : ι → ℂ}
    (hinj : Function.Injective q) (hq : ∀ i j, G.Adj i j → dist (q i) (q j) = 1) {u v : ι}
    (hne : q u ≠ q v) (h : Forces G (k + 1) u v) : (CriticalSet G k).encard ≤ 2 := by
  set g := Glue.gluePoint (q u) (q v) 1 1 with hg
  set g' := Glue.reflAxis (q u) (q v) g with hg'
  have hsub : CriticalSet G k ⊆ q ⁻¹' {g, g'} := fun c hc => by
    have := eq_gluePoint_or_reflAxis_of_mem_criticalSet_of_forces q hq hne h c hc
    simpa [Set.mem_preimage, Set.mem_insert_iff, Set.mem_singleton_iff, hg, hg'] using this
  calc (CriticalSet G k).encard ≤ (q ⁻¹' {g, g'}).encard := Set.encard_le_encard hsub
    _ = (q '' (q ⁻¹' {g, g'})).encard := (hinj.encard_image _).symm
    _ ≤ ({g, g'} : Set ℂ).encard := Set.encard_le_encard (Set.image_preimage_subset q _)
    _ ≤ ({g'} : Set ℂ).encard + 1 := Set.encard_insert_le _ _
    _ = 2 := by rw [Set.encard_singleton]; norm_num

/-! ## Spec: the bound is tight

`K₄` minus the edge `{0, 1}` forces `0` and `1` equal at three colours (both must avoid the two
colours of the adjacent pair `{2, 3}`), and its critical set at two colours is exactly `{2, 3}` =
`N(0) ∩ N(1)`: deleting `2` leaves the path `0 – 3 – 1`, deleting `0` leaves the triangle `{1, 2, 3}`. -/

/-- `K₄` minus the edge `{0, 1}`. -/
def k4MinusEdge : SimpleGraph (Fin 4) :=
  SimpleGraph.fromRel fun i j => i ≠ j ∧ ¬ ({i, j} : Finset (Fin 4)) = {0, 1}

/-- Adjacency in `k4MinusEdge` is decidable, so the spec examples close by `decide`. -/
instance : DecidableRel k4MinusEdge.Adj := fun a b =>
  decidable_of_iff _ (SimpleGraph.fromRel_adj _ a b).symm

example : Forces k4MinusEdge 3 0 1 := by
  intro C
  have h02 : C 0 ≠ C 2 := C.valid (by decide)
  have h03 : C 0 ≠ C 3 := C.valid (by decide)
  have h12 : C 1 ≠ C 2 := C.valid (by decide)
  have h13 : C 1 ≠ C 3 := C.valid (by decide)
  have h23 : C 2 ≠ C 3 := C.valid (by decide)
  have key : ∀ a b c d : Fin 3, a ≠ c → a ≠ d → b ≠ c → b ≠ d → c ≠ d → a = b := by decide
  exact key _ _ _ _ h02 h03 h12 h13 h23

example : (2 : Fin 4) ∈ CriticalSet k4MinusEdge 2 := by
  refine ⟨SimpleGraph.Coloring.mk (fun v : Fin 4 => if v = 3 then (1 : Fin 2) else 0) ?_⟩
  intro v w hvw
  rw [SimpleGraph.deleteIncidenceSet_adj] at hvw
  obtain ⟨h, hv, hw⟩ := hvw
  revert h hv hw
  revert v w
  decide

example : (0 : Fin 4) ∉ CriticalSet k4MinusEdge 2 := by
  rintro ⟨C⟩
  have h12 : C 1 ≠ C 2 := C.valid (by rw [SimpleGraph.deleteIncidenceSet_adj]; decide)
  have h13 : C 1 ≠ C 3 := C.valid (by rw [SimpleGraph.deleteIncidenceSet_adj]; decide)
  have h23 : C 2 ≠ C 3 := C.valid (by rw [SimpleGraph.deleteIncidenceSet_adj]; decide)
  have key : ∀ a b c : Fin 2, a ≠ b → a ≠ c → b ≠ c → False := by decide
  exact key _ _ _ h12 h13 h23

end HadwigerNelson

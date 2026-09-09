import Proofs.HadwigerNelson.PairDist
import Proofs.HadwigerNelson.Pigeonhole
import Proofs.HadwigerNelson.DistanceGraph

/-!
# The hexagonal-shell pigeonhole at up to six colours (M35 L1)

**Every proper colouring of the plane with at most six colours makes some pair at distance
`√3` or at distance `2` monochromatic** — equivalently, the three-distance graph of the plane
at `{1, √3, 2}` needs at least seven colours.

The carrier is the closed first shell of the triangular lattice: a point and its six unit
neighbours. All 21 pairwise distances lie in `{1, √3, 2}` (12 unit, 6 at `√3` across the 120°
ring gaps, 3 diameters), so the seven points are a clique of the three-distance graph — with
fewer than seven colours two of them share, and a shared pair is never a unit pair. No search
and no refutation certificate appear anywhere: the pigeonhole is carried by counting
(`mono_pair_of_clique`), and the kernel checks only the 21 distance identities, the two
completeness sweeps, and the clique membership decide.

**Attribution** (M35 §0a C3): the clique is elementary and presumably folklore — the first
shell of the triangular lattice. **What is new is the formalization, not the compulsion.**
The compulsion is COMPOUND — disjunctive over two distances — and strictly weaker than a
single-distance firing at five colours would be. Its seed value for the 6-programme: a
6-forcer built over this pigeonhole needs kill webs for BOTH distances, and the spindle
radicands `4·3 − 1 = 11` and `4·4 − 1 = 15` both lie inside the 5-forcers' field
`ℚ(√3,√5,√7,√11)`.

**Not checked, and not claimed**: novelty of the plane statements, and any single-distance
compulsion at five colours — the M35 sweep measures those separately, tools-side.
-/

namespace HadwigerNelson

open SimpleGraph

-- id 0 = the centre; ids 1..6 = the ring ζ₆^(a−1), a = id − 1 (tools-side reading, not a
-- theorem). Emitted by `build/m35-design.py --emit-hexshell` (untrusted); the kernel
-- re-decides every distance below.

/-- The seven vertices — the origin and the six sixth-roots of unity — exact in the
`ℚ(√3,√5,√7,√11)` basis and scaled by `2` so every leaf is an integer. -/
def hexShellTable : PtTable :=
  (PtTable.node 3 (PtTable.node 1 (PtTable.leaf ⟨⟨⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩,⟨⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩⟩) (PtTable.node 1 (PtTable.leaf ⟨⟨⟨⟨⟨2,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩,⟨⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩⟩) (PtTable.leaf ⟨⟨⟨⟨⟨1,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩,⟨⟨⟨⟨0,1⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩⟩))) (PtTable.node 2 (PtTable.node 1 (PtTable.leaf ⟨⟨⟨⟨⟨(-1),0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩,⟨⟨⟨⟨0,1⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩⟩) (PtTable.leaf ⟨⟨⟨⟨⟨(-2),0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩,⟨⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩⟩)) (PtTable.node 1 (PtTable.leaf ⟨⟨⟨⟨⟨(-1),0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩,⟨⟨⟨⟨0,(-1)⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩⟩) (PtTable.leaf ⟨⟨⟨⟨⟨1,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩,⟨⟨⟨⟨0,(-1)⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩,⟨⟨⟨0,0⟩,⟨0,0⟩⟩,⟨⟨0,0⟩,⟨0,0⟩⟩⟩⟩⟩))))

/-- The twelve claimed unit-distance pairs: six spokes and the six ring steps. -/
def hexShellEdges : List (Fin 7 × Fin 7) :=
  [(0,1), (0,2), (0,3), (0,4), (0,5), (0,6), (1,2), (1,6), (2,3), (3,4), (4,5), (5,6)]

/-- The six claimed `√3`-pairs: the 120° ring gaps. -/
def hexShellP3 : List (Fin 7 × Fin 7) :=
  [(1,3), (1,5), (2,4), (2,6), (3,5), (4,6)]

/-- The three claimed distance-2 pairs: the ring diameters. -/
def hexShellP4 : List (Fin 7 × Fin 7) :=
  [(1,4), (2,5), (3,6)]

/-- The compound class the pigeonhole names: some `√3`-pair or some diameter goes mono. -/
def hexShellPairs : List (Fin 7 × Fin 7) := hexShellP3 ++ hexShellP4

/-- The certificate. -/
def hexShell : UDCert 7 where
  verts := hexShellTable.toVerts
  edges := hexShellEdges
  denom := 2

/-- Every listed edge has exact squared distance `2²`. Kernel-checked. -/
theorem hexShell_valid : hexShell.Valid = true := by decide +kernel

/-- Every listed `√3`-pair has exact squared distance `3 · 2²`. Kernel-checked. -/
theorem hexShell_p3_dist : hexShell.PairsAt hexShellP3 3 = true := by decide +kernel

/-- Every listed diameter has exact squared distance `4 · 2²` — real distance `2`.
Kernel-checked. -/
theorem hexShell_p4_dist : hexShell.PairsAt hexShellP4 4 = true := by decide +kernel

/-- **Completeness of the `√3` list**: any two of the seven points at squared distance `3`
are a listed pair — `hexShellP3` is the whole class, not a curated sublist. Kernel-checked
over all 49 ordered pairs. -/
theorem hexShell_p3_complete :
    ∀ i j : Fin 7, (hexShell.verts i).distSq (hexShell.verts j) = ((3 * (2 * 2) : ℤ) : Q4) →
      (i, j) ∈ hexShellP3 ∨ (j, i) ∈ hexShellP3 := by
  decide +kernel

/-- **Completeness of the diameter list**, same contract. -/
theorem hexShell_p4_complete :
    ∀ i j : Fin 7, (hexShell.verts i).distSq (hexShell.verts j) = ((4 * (2 * 2) : ℤ) : Q4) →
      (i, j) ∈ hexShellP4 ∨ (j, i) ∈ hexShellP4 := by
  decide +kernel

/-- **The clique fact**: every two distinct vertices are adjacent in the augmented graph —
the seven points are pairwise at distance `1`, `√3`, or `2`. One decide over 42 ordered
membership checks; this is the entire combinatorial content of the pigeonhole. -/
theorem hexShell_clique :
    ∀ i j : Fin 7, i ≠ j →
      ((i, j) ∈ (hexShellEdges ++ hexShellPairs) ∨
       (j, i) ∈ (hexShellEdges ++ hexShellPairs)) := by
  decide

/-! ### Shape pins and controls — compiled, every build -/

#guard hexShellEdges.length = 12
#guard hexShellP3.length = 6
#guard hexShellP4.length = 3
#guard hexShellEdges.eraseDups.length = 12
#guard hexShellPairs.eraseDups.length = 9
#guard hexShellEdges.all fun e => e.1 < e.2
#guard hexShellPairs.all fun p => p.1 < p.2
#guard hexShell.denom = 2

-- The compiled cross-check: `badEdges` is the compiler's independent evaluation of the same
-- predicate `hexShell_valid` settles by kernel reduction.
#guard hexShell.badEdges.isEmpty

-- The adversarial member: move ring vertex 1 (a member of edges, √3-pairs, AND diameters) to
-- the far point ⟨9, 9⟩ and every check must fail, the edge check naming only vertex-1 edges.
#guard !(({ hexShell with verts := fun i => if i = 1 then ⟨9, 9⟩ else hexShell.verts i } :
  UDCert 7)).badEdges.isEmpty
#guard (({ hexShell with verts := fun i => if i = 1 then ⟨9, 9⟩ else hexShell.verts i } :
  UDCert 7)).badEdges.all fun be => be.1.1 = 1 ∨ be.1.2 = 1
#guard ({ hexShell with verts := fun i => if i = 1 then ⟨9, 9⟩ else hexShell.verts i } :
  UDCert 7).PairsAt hexShellP3 3 = false
#guard ({ hexShell with verts := fun i => if i = 1 then ⟨9, 9⟩ else hexShell.verts i } :
  UDCert 7).PairsAt hexShellP4 4 = false

/-! ### The pigeonhole -/

/-- **The hexagonal-shell pigeonhole.** With fewer than seven colours, every proper colouring
of the shell (properness over the twelve listed unit edges) makes some listed `√3`-pair or
diameter monochromatic. Counting, not search: the seven vertices are pairwise adjacent in the
augmented graph, so two share a colour, and a shared pair is never a unit edge. -/
theorem hexShell_pigeonhole {k : ℕ} (hk : k < 7)
    (C : (edgeGraph 7 hexShellEdges).Coloring (Fin k)) : MonoPair hexShellPairs C :=
  mono_pair_of_clique Finset.univ (by simpa using hk)
    (fun i _ j _ hne => ⟨hne, hexShell_clique i j hne⟩) C

/-! ### Specification — the compulsion is live, and its hypothesis is load-bearing -/

/-- The ring-alternation colouring (centre `2`, ring `0,1,0,1,0,1`) is proper on the shell —
the colouring domain is non-vacuous even at three colours — and the pigeonhole's conclusion
is visibly live on it: ring vertices 1 and 3 share colour `0` across a `√3` gap. -/
example : ∃ C : (edgeGraph 7 hexShellEdges).Coloring (Fin 3), MonoPair hexShellPairs C := by
  refine ⟨Coloring.mk ![2, 0, 1, 0, 1, 0, 1] ?_, ⟨(1, 3), by decide, rfl⟩⟩
  rintro i j ⟨hne, hm⟩
  fin_cases i <;> fin_cases j <;> revert hne hm <;> decide

/-- The mutation partner: at seven colours the counting fails and the rainbow colouring
avoids every listed pair — `k < 7` is load-bearing. -/
example : ∃ C : (edgeGraph 7 hexShellEdges).Coloring (Fin 7),
    ¬ MonoPair hexShellPairs C := by
  refine ⟨Coloring.mk ![0, 1, 2, 3, 4, 5, 6] ?_, ?_⟩
  · rintro i j ⟨hne, hm⟩
    fin_cases i <;> fin_cases j <;> revert hne hm <;> decide
  · rw [not_monoPair_iff]
    intro p hp
    fin_cases hp <;> decide

/-! ### The plane corollaries -/

-- SCOPE, added 2026-09-09 (FS-26, the vacuity sweep). The three theorems below quantify over
-- `(unitDistance ℂ).Coloring (Fin k)`, and how much they say depends on `k` in three steps:
--
--   * `k ≤ 4` — VACUOUS. Rung B makes the type empty (`Instances/Interval.lean`,
--     `isEmpty_coloring_plane_four`). `hexShell_plane` is colour-generic and its `hk : k < 7`
--     admits this range, so the theorem is true and empty there; it has no consumer at `k ≤ 4`.
--   * `k ∈ {5, 6}` — OPEN, and open in the exact sense that whether the type is inhabited IS the
--     Hadwiger-Nelson problem: if `χ(ℝ²) = 7` then both are empty and `hexShell_plane5` and
--     `hexShell_plane6` are vacuous too.
--   * `k ≥ 7` — inhabited (`Instances/Seven.lean`), and excluded by `hk` because the counting
--     argument stops there.
--
-- That middle step is not a defect and needs no repair, because BOTH consumers assume a colouring
-- in order to REFUTE it: `not_colorable_five_of_forced_pairs` concludes `¬ Colorable 5`, and
-- `seven_le_chromaticNumber_hexShell_distances` concludes a lower bound. Assuming a structure in
-- order to derive a contradiction is the one shape vacuity cannot damage -- emptiness there is the
-- conclusion, not a hidden hypothesis. It is written down because the distinction is invisible in
-- the statements themselves, and because a reader who takes `hexShell_plane5` as a positive fact
-- ABOUT five-colourings would be making the `core9_plane` mistake one colour up.
--
-- The genuinely non-vacuous content of this module is the seven-point carrier, which really is
-- colourable: `Coloring (Fin 3)` and `Coloring (Fin 7)` of it are exhibited above, and two
-- `Coloring (Fin 5)` of it below, which is why the load-bearing reds work at all.

/-- **The plane pigeonhole, colour-generic.** Every proper colouring of the plane's
unit-distance graph with fewer than seven colours has a monochromatic pair at distance `√3`
or at distance `2`. The witnesses are two of the seven certified shell points. -/
theorem hexShell_plane {k : ℕ} (hk : k < 7) (C : (unitDistance ℂ).Coloring (Fin k)) :
    ∃ x y : ℂ, (dist x y = Real.sqrt 3 ∨ dist x y = 2) ∧ C x = C y := by
  have hunit := hexShell.valid_sound (by decide) hexShell_valid
  have hvalid : ∀ {i j : Fin 7}, (edgeGraph 7 hexShellEdges).Adj i j →
      C (hexShell.point i) ≠ C (hexShell.point j) := by
    rintro i j ⟨hne, hm | hm⟩
    · exact C.valid (unitDistance_adj.mpr (hunit (i, j) hm))
    · exact C.valid (unitDistance_adj.mpr (by rw [dist_comm]; exact hunit (j, i) hm))
  obtain ⟨p, hp, heq⟩ :=
    hexShell_pigeonhole hk (Coloring.mk (fun i => C (hexShell.point i)) hvalid)
  refine ⟨hexShell.point p.1, hexShell.point p.2, ?_, heq⟩
  rcases List.mem_append.mp hp with h3 | h4
  · left
    have h := hexShell.pairsAt_sound (by decide) hexShell_p3_dist p h3
    rwa [show ((3 : ℤ) : ℝ) = 3 by norm_num] at h
  · right
    have h := hexShell.pairsAt_sound (by decide) hexShell_p4_dist p h4
    rwa [show Real.sqrt ((4 : ℤ) : ℝ) = 2 by
      rw [show ((4 : ℤ) : ℝ) = (2 : ℝ) ^ 2 by norm_num, Real.sqrt_sq (by norm_num)]] at h

/-- **The five-colour reading** — the 6-programme's Act-One seed: every proper 5-colouring of
the plane has a mono pair at distance `√3` or `2`. A 6-forcer built over this compound
pigeonhole needs kill webs for both distances (radicands 11 and 15, inside the 5-forcers'
field). Compound = disjunctive: strictly weaker than a single-distance firing. -/
theorem hexShell_plane5 (C : (unitDistance ℂ).Coloring (Fin 5)) :
    ∃ x y : ℂ, (dist x y = Real.sqrt 3 ∨ dist x y = 2) ∧ C x = C y :=
  hexShell_plane (by norm_num) C

/-- **The six-colour reading**: every proper 6-colouring of the plane has a mono pair at
distance `√3` or `2` — equivalently, the `{1, √3, 2}` three-distance graph of the plane is
not 6-colourable: **χ(ℝ²; {1, √3, 2}) ≥ 7**, stated as a theorem about that graph in
`seven_le_chromaticNumber_hexShell_distances` below. Elementary and presumably folklore; what is
new is the formalization, not the compulsion. -/
theorem hexShell_plane6 (C : (unitDistance ℂ).Coloring (Fin 6)) :
    ∃ x y : ℂ, (dist x y = Real.sqrt 3 ∨ dist x y = 2) ∧ C x = C y :=
  hexShell_plane (by norm_num) C

/-! ### The three-distance plane, as a theorem rather than a docstring (M49)

`hexShell_plane6`'s docstring reads "equivalently, χ(ℝ²; {1, √3, 2}) ≥ 7". Until M49 no such graph
existed in the repository; with `distanceGraph` it does, and the claim is a two-line consequence
of the same seven-point clique through the edge-list reduction. -/

/-- The augmented shell is complete: every two of the seven points are joined by a unit edge, a
`√3`-pair or a diameter. -/
theorem edgeGraph_hexShellAug_eq_top : edgeGraph 7 (hexShellEdges ++ hexShellPairs) = ⊤ := by
  ext i j
  simp only [top_adj]
  constructor
  · exact fun h => h.1
  · exact fun h => ⟨h, hexShell_clique i j h⟩

theorem hexShellAug_not_colorable_six : ¬ (edgeGraph 7 (hexShellEdges ++ hexShellPairs)).Colorable 6 := by
  rw [edgeGraph_hexShellAug_eq_top, ← chromaticNumber_le_iff_colorable, chromaticNumber_top,
    Fintype.card_fin]
  decide

/-- **χ(ℝ²; {1, √3, 2}) ≥ 7.** The plane's graph with three forbidden distances — `1`, `√3` and `2` —
needs at least seven colours: the closed first shell of the unit triangular lattice is a `K₇` of it.
Elementary and presumably folklore; the formalization is ours. -/
theorem seven_le_chromaticNumber_hexShell_distances :
    ((6 + 1 : ℕ) : ℕ∞) ≤ (distanceGraph ℂ {1, Real.sqrt 3, 2}).chromaticNumber := by
  refine add_one_le_chromaticNumber_distanceGraph_edgeList (hexShellEdges ++ hexShellPairs)
    hexShell.point ?_ ?_ hexShellAug_not_colorable_six
  · have hunit := hexShell.valid_sound (by decide) hexShell_valid
    have h3 := hexShell.pairsAt_sound (by decide) hexShell_p3_dist
    have h4 := hexShell.pairsAt_sound_sq (by decide) (m := 2) hexShell_p4_dist
    intro e he
    rcases List.mem_append.mp he with h | h
    · have h1 : dist (hexShell.point e.1) (hexShell.point e.2) = 1 := hunit e h
      rw [h1]; simp
    · rcases List.mem_append.mp h with h' | h'
      · rw [h3 e h']; simp
      · rw [h4 e h']; simp
  · -- `0 ∉ {1, √3, 2}`
    simp only [Set.mem_insert_iff, Set.mem_singleton_iff, not_or]
    refine ⟨by norm_num, ?_, by norm_num⟩
    intro h
    have := Real.sqrt_pos.mpr (by norm_num : (0 : ℝ) < 3)
    linarith

/-! ### What Act Two of the six-colour programme must supply

The pigeonhole above is *disjunctive*, and that is the whole content of this section. Refuting the
six `√3`-placements leaves the three diameters standing, and refuting the diameters leaves the
`√3`-pairs standing — so `χ(ℝ²) ≥ 6` needs a virtual edge at `√3` **and** one at `2`, not one at
either. Each alone would be a major result that halves the remaining problem; neither alone closes
it. The two `example`s below are the proof of that claim rather than a restatement of it: each
exhibits a proper 5-colouring of the very carrier this pigeonhole runs on which avoids one class
entirely. -/

/-- **The six-colour programme's exact requirement.** With every `√3`-pair and every distance-`2`
pair separated in every proper 5-colouring of the plane, the plane is not 5-colourable.

Three lines, because all the work is elsewhere: `hexShell_plane5` supplies the disjunction and the
two hypotheses close its branches. The hypotheses are what `Homogeneous.Separated.plane` produces
from a finite gadget, so a future find instantiates this the day it lands. -/
theorem not_colorable_five_of_forced_pairs
    (h3 : ∀ (C : (unitDistance ℂ).Coloring (Fin 5)) (x y : ℂ),
            dist x y = Real.sqrt 3 → C x ≠ C y)
    (h2 : ∀ (C : (unitDistance ℂ).Coloring (Fin 5)) (x y : ℂ), dist x y = 2 → C x ≠ C y) :
    ¬ (unitDistance ℂ).Colorable 5 := by
  intro hc
  obtain ⟨x, y, hd | hd, heq⟩ := hexShell_plane5 hc.some
  · exact h3 hc.some x y hd heq
  · exact h2 hc.some x y hd heq

/-- **`χ(ℝ²) ≥ 6`, conditional on Act Two** — the headline form, in the numeral idiom of
`add_one_le_chromaticNumber_unitDistance`. -/
theorem six_le_chromaticNumber_plane_of_forced_pairs
    (h3 : ∀ (C : (unitDistance ℂ).Coloring (Fin 5)) (x y : ℂ),
            dist x y = Real.sqrt 3 → C x ≠ C y)
    (h2 : ∀ (C : (unitDistance ℂ).Coloring (Fin 5)) (x y : ℂ), dist x y = 2 → C x ≠ C y) :
    6 ≤ (unitDistance ℂ).chromaticNumber := by
  have := lt_chromaticNumber_iff_not_colorable.mpr (not_colorable_five_of_forced_pairs h3 h2)
  rwa [show ((5 : ℕ) : ℕ∞) = 5 from rfl, ← ENat.add_one_le_iff (by simp)] at this

/-- **Neither distance class is forced on its own, half one.** Centre `3`, ring `0,1,2,0,1,2`:
a proper 5-colouring separating all six `√3`-pairs. So killing the diameters alone leaves a
colouring this pigeonhole cannot refute, and `h3` in the composition above is load-bearing. -/
example : ∃ C : (edgeGraph 7 hexShellEdges).Coloring (Fin 5), ¬ MonoPair hexShellP3 C := by
  refine ⟨Coloring.mk ![3, 0, 1, 2, 0, 1, 2] ?_, ?_⟩
  · rintro i j ⟨hne, hm⟩
    fin_cases i <;> fin_cases j <;> revert hne hm <;> decide
  · rw [not_monoPair_iff]; intro p hp; fin_cases hp <;> decide

/-- **Neither distance class is forced on its own, half two.** Centre `4`, ring `0,1,2,3,0,1`:
a proper 5-colouring separating all three diameters. So `h2` is load-bearing too, and the
disjunction is irreducible from both sides. -/
example : ∃ C : (edgeGraph 7 hexShellEdges).Coloring (Fin 5), ¬ MonoPair hexShellP4 C := by
  refine ⟨Coloring.mk ![4, 0, 1, 2, 3, 0, 1] ?_, ?_⟩
  · rintro i j ⟨hne, hm⟩
    fin_cases i <;> fin_cases j <;> revert hne hm <;> decide
  · rw [not_monoPair_iff]; intro p hp; fin_cases hp <;> decide

end HadwigerNelson

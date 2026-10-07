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

/-! ### The plane corollaries

The pigeonhole above is about a proper colouring, and the only thing its proof asks of one is that
it separate points at distance `1`. So the natural hypothesis is not "a colouring of the
unit-distance graph" but "a colouring of `distanceGraph ℂ D` for some `D` containing `1`" — the
same relaxation `Homogeneous.lean` already makes, where `Separated.planeIn` is stated over an
arbitrary `D` and `Separated.plane` is its `D = {1}` instance. The naming here follows that
convention, and the reason is not tidiness: `Separated.planeIn`'s conclusion is *verbatim* the
hypothesis shape the conditional theorems at the foot of this file want, so a finite gadget's
`Separated` fact now feeds them with no transport step in between. -/

-- SCOPE, added 2026-09-09 (FS-26, the vacuity sweep). Kept beside the docstring below rather than
-- folded into it because two audits running in parallel reached the same three-region reading of
-- these theorems on the same day, and the convergence is worth recording as convergence.
--
-- What that reading does not say, and it is the part that matters: the vacuity here is HARMLESS,
-- and harmless structurally rather than luckily. Both consumers assume a colouring in order to
-- REFUTE it -- `not_colorable_five_of_forced_pairs` concludes `¬ Colorable 5`, and
-- `seven_le_chromaticNumber_hexShell_distances` concludes a lower bound. Assuming a structure in
-- order to derive a contradiction is the one shape vacuity cannot damage: emptiness there is the
-- conclusion, not a hidden hypothesis. A reader who instead took `hexShell_plane5` as a positive
-- fact ABOUT five-colourings would be making the `core9_plane` mistake one colour up.

/-- **A proper colouring of a distance graph separates every listed distance.** Stated for any
metric space and any colour type because the proof uses neither: the pair is adjacent because its
distance lies in `D`, and it is a pair of *distinct* points because that distance is not zero.

This is the discharge map that makes `not_colorable_distanceGraph_of_forced_sqrt3` and its mirror
*instances* of one theorem rather than copies of one argument. -/
-- Its natural home is `DistanceGraph.lean`; it is kept local because a declaration added there
-- rebuilds `Homogeneous.lean`, `Copy.lean` and `Mascot.lean` forever after, and moving it later is
-- a cut-and-paste. Deliberately NOT named `Coloring.ne_of_dist_mem`: inside `namespace
-- HadwigerNelson` that spelling would not resolve by dot notation on a `SimpleGraph.Coloring`.
theorem coloring_ne_of_dist_mem {V α : Type*} [MetricSpace V] {D : Set ℝ}
    (C : (distanceGraph V D).Coloring α) {d : ℝ} (hd : d ∈ D) (hd0 : d ≠ 0)
    {x y : V} (hxy : dist x y = d) : C x ≠ C y :=
  C.valid ⟨fun h => hd0 (by rw [← hxy, h, dist_self]), hxy ▸ hd⟩

/-- **The plane pigeonhole, colour-generic and distance-set-generic.** Every proper colouring of
`distanceGraph ℂ D` with fewer than seven colours, for any `D` containing `1`, has a monochromatic
pair at distance `√3` or at distance `2`. The witnesses are two of the seven certified shell
points.

**This is a restatement, not a strengthening, and the record should say so.** It and
`hexShell_plane` are interderivable, each in one line: downward because a unit-distance colouring is
a `{1}`-colouring, and upward because the *same function* is a proper unit-distance colouring
whenever `1 ∈ D`. It is stated over `D` so that a consumer working in a two-distance plane needs no
transport, which is where the value is (see the conditional theorems below).

**Vacuity, which has three regions and only the middle one is interesting** (the house rule asks
every structure-valued hypothesis for a named inhabitant). Over `D = {1}`: at `k ≤ 4` the hypothesis
is an *empty* type — this repository's `χ(ℝ²) ≥ 5` makes it so, and `Interval.lean`'s
`isEmpty_coloring_plane_four` is that emptiness as a theorem — so the statement is vacuous there; at
`k ∈ {5, 6}` whether it is inhabited **is the Hadwiger–Nelson problem itself**; at `k = 7` the
inhabitant is `Instances/Seven.lean`'s `plane_colorable_seven`, just outside the `hk` window. And at
any `D ⊇ {1, √3, 2}` with `k = 6` the hypothesis is *provably* empty — which is not a defect but
`seven_le_chromaticNumber_hexShell_distances` below, seen from the other side. The non-vacuity that
anchors the argument is at the finite carrier, where the `example` above exhibits a proper
3-colouring of the seven points. -/
theorem hexShell_planeIn {k : ℕ} (hk : k < 7) {D : Set ℝ} (h1 : (1 : ℝ) ∈ D)
    (C : (distanceGraph ℂ D).Coloring (Fin k)) :
    ∃ x y : ℂ, (dist x y = Real.sqrt 3 ∨ dist x y = 2) ∧ C x = C y := by
  have hunit := hexShell.valid_sound (by decide) hexShell_valid
  have hvalid : ∀ {i j : Fin 7}, (edgeGraph 7 hexShellEdges).Adj i j →
      C (hexShell.point i) ≠ C (hexShell.point j) := by
    rintro i j ⟨hne, hm | hm⟩
    · exact coloring_ne_of_dist_mem C h1 one_ne_zero (hunit (i, j) hm)
    · exact coloring_ne_of_dist_mem C h1 one_ne_zero (by rw [dist_comm]; exact hunit (j, i) hm)
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

/-- **The plane pigeonhole, colour-generic.** Every proper colouring of the plane's unit-distance
graph with fewer than seven colours has a monochromatic pair at distance `√3` or at distance `2`.
The `D = {1}` case of `hexShell_planeIn`, and interderivable with it. -/
theorem hexShell_plane {k : ℕ} (hk : k < 7) (C : (unitDistance ℂ).Coloring (Fin k)) :
    ∃ x y : ℂ, (dist x y = Real.sqrt 3 ∨ dist x y = 2) ∧ C x = C y :=
  hexShell_planeIn hk (Set.mem_singleton (1 : ℝ))
    (Coloring.mk C fun {_ _} hxy =>
      C.valid (unitDistance_adj.mpr (Set.mem_singleton_iff.mp hxy.2)))

/-- **The five-colour reading** — the 6-programme's Act-One seed: every proper 5-colouring of the
plane has a mono pair at distance `√3` or `2`. A 6-forcer built over this compound pigeonhole needs
kill webs for both distances (radicands 11 and 15, inside the 5-forcers' field). Compound =
disjunctive: strictly weaker than a single-distance firing.

**Empty given an import** (FS132-L1; said in words, by ruling — not the scan's marker, which is for
emptiness the library proves and counts as its own): given the declared outside theorem
`Outside.OAI158.no_proper_five_coloring` the plane has no five-colouring
(`Outside.OAI158.not_colorable_five`), so this statement's hypothesis has no inhabitant and it says
nothing beyond that import; on the standard three axioms alone the vacuity scan cannot see this and
holds the statement in its baseline as unknown; `hexShell_plane6` is the open case. -/
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

`hexShell_plane6`'s docstring reads "equivalently, χ(ℝ², {1, √3, 2}) ≥ 7". Until M49 no such graph
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
it. The four `example`s below are the proof of that claim rather than a restatement of it: each
exhibits a proper colouring of the very carrier this pigeonhole runs on which avoids one class
entirely — at five colours and again at six, so the new colour-generic statements are as honest as
the ones they generalize.

There is exactly **one** conditional theorem here. Per distance, the requirement is either "it lies
in `D`, so the colouring's own validity separates it" or "some gadget separates it" — and the first
*implies* the second through `coloring_ne_of_dist_mem`, so the disjunction collapses and every
named form below is an instance obtained by discharging a hypothesis from a membership. -/

/-- **The six-colour programme's exact requirement, over any distance graph containing `1`.** With
every `√3`-pair and every distance-`2` pair separated in every proper `k`-colouring, `k < 7`, the
graph is not `k`-colourable.

The hypotheses are exactly what `Homogeneous.Separated.planeIn` produces from a finite gadget, so a
future find instantiates this the day it lands. -/
theorem not_colorable_distanceGraph_of_forced_pairs {k : ℕ} (hk : k < 7) {D : Set ℝ}
    (h1 : (1 : ℝ) ∈ D)
    (h3 : ∀ (C : (distanceGraph ℂ D).Coloring (Fin k)) (x y : ℂ),
            dist x y = Real.sqrt 3 → C x ≠ C y)
    (h2 : ∀ (C : (distanceGraph ℂ D).Coloring (Fin k)) (x y : ℂ), dist x y = 2 → C x ≠ C y) :
    ¬ (distanceGraph ℂ D).Colorable k := by
  intro hc
  obtain ⟨x, y, hd | hd, heq⟩ := hexShell_planeIn hk h1 hc.some
  · exact h3 hc.some x y hd heq
  · exact h2 hc.some x y hd heq

/-- **One gadget suffices when the other distance is already forbidden.** If `2 ∈ D` then the
shell's three diameters are edges of the graph, so the distance-`2` half is discharged by the
colouring's own validity and only a `√3` gadget is asked for.

`six_le_chromaticNumber_oneTwo_of_forced_sqrt3` is the instance the descent programme wants. -/
theorem not_colorable_distanceGraph_of_forced_sqrt3 {k : ℕ} (hk : k < 7) {D : Set ℝ}
    (h1 : (1 : ℝ) ∈ D) (hm : (2 : ℝ) ∈ D)
    (h3 : ∀ (C : (distanceGraph ℂ D).Coloring (Fin k)) (x y : ℂ),
            dist x y = Real.sqrt 3 → C x ≠ C y) :
    ¬ (distanceGraph ℂ D).Colorable k :=
  not_colorable_distanceGraph_of_forced_pairs hk h1 h3
    fun C _ _ h => coloring_ne_of_dist_mem C hm two_ne_zero h

/-- **The mirror**: if `√3 ∈ D` then the shell's six `√3`-pairs are edges, and only a distance-`2`
gadget is asked for. Instantiate at `D = {1, Real.sqrt 3}` for the two-distance headline; that
instance is not minted here because no measurement programme targets it, where the `{1,2}` one
below carries M49's and M50's. -/
theorem not_colorable_distanceGraph_of_forced_two {k : ℕ} (hk : k < 7) {D : Set ℝ}
    (h1 : (1 : ℝ) ∈ D) (hm : Real.sqrt 3 ∈ D)
    (h2 : ∀ (C : (distanceGraph ℂ D).Coloring (Fin k)) (x y : ℂ), dist x y = 2 → C x ≠ C y) :
    ¬ (distanceGraph ℂ D).Colorable k :=
  not_colorable_distanceGraph_of_forced_pairs hk h1
    (fun C _ _ h => coloring_ne_of_dist_mem C hm (by positivity) h) h2

/-- **The six-colour programme's exact requirement for the plane**, colour-generic. The `D = {1}`
case, reached through `unitDistance_eq_distanceGraph_singleton` — the equality of graphs that module
provides precisely so that a `unitDistance` theorem can be a `D = {1}` instance. -/
theorem not_colorable_of_forced_pairs {k : ℕ} (hk : k < 7)
    (h3 : ∀ (C : (unitDistance ℂ).Coloring (Fin k)) (x y : ℂ),
            dist x y = Real.sqrt 3 → C x ≠ C y)
    (h2 : ∀ (C : (unitDistance ℂ).Coloring (Fin k)) (x y : ℂ), dist x y = 2 → C x ≠ C y) :
    ¬ (unitDistance ℂ).Colorable k := by
  rw [unitDistance_eq_distanceGraph_singleton] at h3 h2 ⊢
  exact not_colorable_distanceGraph_of_forced_pairs hk (D := {1}) rfl h3 h2

/-- **The plane bound, colour-generic**, in the numeral idiom of
`add_one_le_chromaticNumber_unitDistance`. All the `ℕ∞` arithmetic lives in
`add_one_le_chromaticNumber_iff_not_colorable`, which exists for that reason. -/
theorem add_one_le_chromaticNumber_plane_of_forced_pairs {k : ℕ} (hk : k < 7)
    (h3 : ∀ (C : (unitDistance ℂ).Coloring (Fin k)) (x y : ℂ),
            dist x y = Real.sqrt 3 → C x ≠ C y)
    (h2 : ∀ (C : (unitDistance ℂ).Coloring (Fin k)) (x y : ℂ), dist x y = 2 → C x ≠ C y) :
    ((k + 1 : ℕ) : ℕ∞) ≤ (unitDistance ℂ).chromaticNumber :=
  add_one_le_chromaticNumber_iff_not_colorable.mpr (not_colorable_of_forced_pairs hk h3 h2)

/-- **The six-colour programme's exact requirement.** With every `√3`-pair and every distance-`2`
pair separated in every proper 5-colouring of the plane, the plane is not 5-colourable.

Three lines, because all the work is elsewhere: `hexShell_plane5` supplies the disjunction and the
two hypotheses close its branches. The hypotheses are what `Homogeneous.Separated.plane` produces
from a finite gadget, so a future find instantiates this the day it lands. -/
theorem not_colorable_five_of_forced_pairs
    (h3 : ∀ (C : (unitDistance ℂ).Coloring (Fin 5)) (x y : ℂ),
            dist x y = Real.sqrt 3 → C x ≠ C y)
    (h2 : ∀ (C : (unitDistance ℂ).Coloring (Fin 5)) (x y : ℂ), dist x y = 2 → C x ≠ C y) :
    ¬ (unitDistance ℂ).Colorable 5 :=
  not_colorable_of_forced_pairs (by norm_num) h3 h2

/-- **`χ(ℝ²) ≥ 6`, conditional on Act Two** — the headline form, in the numeral idiom of
`add_one_le_chromaticNumber_unitDistance`. -/
theorem six_le_chromaticNumber_plane_of_forced_pairs
    (h3 : ∀ (C : (unitDistance ℂ).Coloring (Fin 5)) (x y : ℂ),
            dist x y = Real.sqrt 3 → C x ≠ C y)
    (h2 : ∀ (C : (unitDistance ℂ).Coloring (Fin 5)) (x y : ℂ), dist x y = 2 → C x ≠ C y) :
    6 ≤ (unitDistance ℂ).chromaticNumber := by
  have := add_one_le_chromaticNumber_plane_of_forced_pairs (k := 5) (by norm_num) h3 h2
  exact_mod_cast this

/-- **The same requirement one colour up**, which the five-colour phrasing could not express. With
every `√3`-pair and every distance-`2` pair separated in every proper 6-colouring of the plane, the
plane is not 6-colourable. -/
theorem not_colorable_six_of_forced_pairs
    (h3 : ∀ (C : (unitDistance ℂ).Coloring (Fin 6)) (x y : ℂ),
            dist x y = Real.sqrt 3 → C x ≠ C y)
    (h2 : ∀ (C : (unitDistance ℂ).Coloring (Fin 6)) (x y : ℂ), dist x y = 2 → C x ≠ C y) :
    ¬ (unitDistance ℂ).Colorable 6 :=
  not_colorable_of_forced_pairs (by norm_num) h3 h2

/-- **`χ(ℝ²) ≥ 7`, conditional on two six-colour gadgets** — the affirmative side of the
local–global conjecture in its bold form, and a sentence this repository could not previously
write. Note what it is not: the hypotheses are about six-colourings, which is a strictly harder
demand than the five-colour ones of `six_le_chromaticNumber_plane_of_forced_pairs`, and nothing
here suggests either is within reach. -/
theorem seven_le_chromaticNumber_plane_of_forced_pairs
    (h3 : ∀ (C : (unitDistance ℂ).Coloring (Fin 6)) (x y : ℂ),
            dist x y = Real.sqrt 3 → C x ≠ C y)
    (h2 : ∀ (C : (unitDistance ℂ).Coloring (Fin 6)) (x y : ℂ), dist x y = 2 → C x ≠ C y) :
    7 ≤ (unitDistance ℂ).chromaticNumber := by
  have := add_one_le_chromaticNumber_plane_of_forced_pairs (k := 6) (by norm_num) h3 h2
  exact_mod_cast this

/-- **The two-distance dial's target: `χ(ℝ²; {1,2}) ≥ 6` from a single `√3` gadget.** In the plane
with both `1` and `2` forbidden, the shell's three diameters are already edges, so half of the
compound pigeonhole is free and only the `√3` half needs a gadget — where the plane itself needs
both (`six_le_chromaticNumber_plane_of_forced_pairs`).

**Read the trade honestly: this is weaker than `χ(ℝ²) ≥ 6` at both ends.** The hypothesis is weaker,
because every `{1,2}`-colouring is a unit-distance colouring but not conversely, so "all of the
smaller family separate `√3`-pairs" is a strictly easier thing to establish; and the conclusion is
weaker, because a bound on a two-distance graph is weaker than the same bound on the plane
(`chromaticNumber_unitDistance_le_distanceGraph`). Neither statement implies the other. That trade is
the point: the objects M49 and M50 measured `μ` against are `{1,2}`-graphs, so this is the version a
real gadget could discharge.

The mirror — a distance-`2` gadget over `{1, √3}` — is
`not_colorable_distanceGraph_of_forced_two` at `D = {1, Real.sqrt 3}`, one line. -/
theorem six_le_chromaticNumber_oneTwo_of_forced_sqrt3
    (h3 : ∀ (C : (distanceGraph ℂ {1, 2}).Coloring (Fin 5)) (x y : ℂ),
            dist x y = Real.sqrt 3 → C x ≠ C y) :
    6 ≤ (distanceGraph ℂ {1, 2}).chromaticNumber := by
  have := add_one_le_chromaticNumber_iff_not_colorable.mpr
    (not_colorable_distanceGraph_of_forced_sqrt3 (k := 5) (by norm_num) (by simp) (by simp) h3)
  exact_mod_cast this

/-! ### Controls for the generalization — compiled, every build

The first two pin that the conjunction is irreducible **from both sides**, at five colours; the next
two do the same at six, so the colour-generic statements are as honest as the ones they generalize.
The fifth pins that properness at distance `1` — the hypothesis `1 ∈ D` — is load-bearing rather
than inherited. The last is the consistency cross-check that decided this file's factoring. -/

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

/-- The same at six colours, half one — so `h3` is load-bearing in
`seven_le_chromaticNumber_plane_of_forced_pairs` too, and the new instance carries its own
adversary rather than inheriting the five-colour one. -/
example : ∃ C : (edgeGraph 7 hexShellEdges).Coloring (Fin 6), ¬ MonoPair hexShellP3 C := by
  refine ⟨Coloring.mk ![3, 0, 1, 2, 0, 1, 2] ?_, ?_⟩
  · rintro i j ⟨hne, hm⟩
    fin_cases i <;> fin_cases j <;> revert hne hm <;> decide
  · rw [not_monoPair_iff]; intro p hp; fin_cases hp <;> decide

/-- The same at six colours, half two. -/
example : ∃ C : (edgeGraph 7 hexShellEdges).Coloring (Fin 6), ¬ MonoPair hexShellP4 C := by
  refine ⟨Coloring.mk ![4, 0, 1, 2, 3, 0, 1] ?_, ?_⟩
  · rintro i j ⟨hne, hm⟩
    fin_cases i <;> fin_cases j <;> revert hne hm <;> decide
  · rw [not_monoPair_iff]; intro p hp; fin_cases hp <;> decide

/-- **Properness at distance `1` is load-bearing** — the hypothesis `1 ∈ D`, read at the carrier.
This six-colour labelling of the seven shell points has NO monochromatic pair among the six
`√3`-pairs or the three diameters; its one repeat sits on the listed unit edge `(0,1)`. So drop
properness at distance `1` and the pigeonhole's conclusion is false, six colours or not. -/
example : ¬ MonoPair hexShellPairs (![0, 0, 1, 2, 3, 4, 5] : Fin 7 → Fin 6) := by
  rw [not_monoPair_iff]; intro p hp; fin_cases hp <;> decide

-- and the repeat really is on a listed unit edge, so the counterexample is the one described
#guard (0, 1) ∈ hexShellEdges
#guard (![0, 0, 1, 2, 3, 4, 5] : Fin 7 → Fin 6) 0 = (![0, 0, 1, 2, 3, 4, 5] : Fin 7 → Fin 6) 1

/-- **The consistency cross-check that decided this file's factoring.** The conditional theorem with
*both* hypotheses discharged from membership reproves `¬ (distanceGraph ℂ {1, √3, 2}).Colorable 6` —
which `seven_le_chromaticNumber_hexShell_distances` above already proves by the independent
edge-list route. Two proofs of one fact by different arguments; a generalization that re-derives a
theorem the file already had is a generalization stated at the right level.

It is also the vacuity note made concrete: at this `D` and this `k`, `hexShell_planeIn`'s hypothesis
is an empty type, and that emptiness is exactly this statement. -/
example : ¬ (distanceGraph ℂ {1, Real.sqrt 3, 2}).Colorable 6 :=
  not_colorable_distanceGraph_of_forced_pairs (by norm_num) (by simp)
    (fun C _ _ h => coloring_ne_of_dist_mem C (by simp) (by positivity) h)
    (fun C _ _ h => coloring_ne_of_dist_mem C (by simp) two_ne_zero h)

/-! ### The record's cited names, pinned at their old statements

`CLAUDE.md` cites these by address, and the rule for a generalization here is that no cited name
disappears and no cited statement changes. That rule is a promise unless something checks it, so
these `example`s check it: each ascribes the *pre-generalization* type and is closed by the name as
it now stands. Change any of those statements and this section goes red, which is the point. -/

example : ∀ {k : ℕ}, k < 7 → ∀ (C : (unitDistance ℂ).Coloring (Fin k)),
    ∃ x y : ℂ, (dist x y = Real.sqrt 3 ∨ dist x y = 2) ∧ C x = C y :=
  @hexShell_plane

example : ∀ (C : (unitDistance ℂ).Coloring (Fin 5)),
    ∃ x y : ℂ, (dist x y = Real.sqrt 3 ∨ dist x y = 2) ∧ C x = C y :=
  @hexShell_plane5

example : ∀ (C : (unitDistance ℂ).Coloring (Fin 6)),
    ∃ x y : ℂ, (dist x y = Real.sqrt 3 ∨ dist x y = 2) ∧ C x = C y :=
  @hexShell_plane6

example :
    (∀ (C : (unitDistance ℂ).Coloring (Fin 5)) (x y : ℂ), dist x y = Real.sqrt 3 → C x ≠ C y) →
    (∀ (C : (unitDistance ℂ).Coloring (Fin 5)) (x y : ℂ), dist x y = 2 → C x ≠ C y) →
    ¬ (unitDistance ℂ).Colorable 5 :=
  @not_colorable_five_of_forced_pairs

example :
    (∀ (C : (unitDistance ℂ).Coloring (Fin 5)) (x y : ℂ), dist x y = Real.sqrt 3 → C x ≠ C y) →
    (∀ (C : (unitDistance ℂ).Coloring (Fin 5)) (x y : ℂ), dist x y = 2 → C x ≠ C y) →
    6 ≤ (unitDistance ℂ).chromaticNumber :=
  @six_le_chromaticNumber_plane_of_forced_pairs

example : ((6 + 1 : ℕ) : ℕ∞) ≤ (distanceGraph ℂ {1, Real.sqrt 3, 2}).chromaticNumber :=
  seven_le_chromaticNumber_hexShell_distances

example : ¬ (edgeGraph 7 (hexShellEdges ++ hexShellPairs)).Colorable 6 :=
  hexShellAug_not_colorable_six

example : ∀ {k : ℕ}, k < 7 → ∀ (C : (edgeGraph 7 hexShellEdges).Coloring (Fin k)),
    MonoPair hexShellPairs C :=
  @hexShell_pigeonhole

end HadwigerNelson

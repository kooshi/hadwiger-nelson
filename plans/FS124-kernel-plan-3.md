# FS-124 — the kernel plan for three arcs from a point: every two regions of a cut disc share an arc (job FS124-K3)

*De Bruijn, the planner. Brief: `data/fs124/briefs/FS124-K3-three-arcs.md` (on `main`). The leaf planned:
`ThreePiece.IsSector.hasArcEdges` (`Proofs/HadwigerNelson/Plane/SectorPoint.lean`). Branch `fs124-wk3`, cut from
`fs124-wi3` at `fb515b25`. Working files: `data/fs124/k3/`. The job is open from its first line (no derivation of the
fact exists to be blind to). The record is written in stages; each is committed before the next starts.*

## Theorems this phase proved

*(Filled at Stage 4; until then: none.)*

## Stage 1 — SAVED (FS124-K3): the readback and the build as given

**The quotations.** `data/fs124/k3/readback.py` (the first implementer's reader, copied unchanged but for its first
line) on the brief: **12 of 12 quotations found in their sources**, exit 0 (`data/fs124/k3/logs/readback.txt`); the
control (one letter of each quotation changed) finds none of the twelve, exit 0
(`data/fs124/k3/logs/readback-control.txt`). No mismatch.

**The build as given.** `scripts/slot.py --mem 40 --cpus 8 -- env MEMMAX=40G BATCH=4 ./scripts/build.sh` from this
worktree at `fb515b25`: `EXIT 0`, "all 1853 modules already up to date, nothing built", **6 `declaration uses sorry`
warnings and no other** (three in `Plane/ClosePairModel`, three in `Plane/SectorPoint`;
`data/fs124/k3/logs/build-as-given.log`).

**The leaf and its two definitions, read whole** (`Plane/SectorPoint.lean`, `Plane/ThreePiece.lean`).

> def IsSector (D : ThreePiece U c x) : Prop :=
>   ∃ r > 0, ∃ J : Fin 3 → C(unitInterval, ℂ),
>     (∀ m, Function.Injective (J m)) ∧ (∀ m, J m 0 = x) ∧ (∀ m, dist (J m 1) x = r) ∧
>       (∀ m t, t ≠ 1 → dist (J m t) x < r) ∧
>       (∀ m m' s t, m ≠ m' → J m s = J m' t → J m s = x) ∧
>       (∀ i, ∃ z ∈ D.piece i, D.piece i = connectedComponentIn (ball x r \ ⋃ m, range (J m)) z) ∧
>       ⋃ i, D.piece i = ball x r \ ⋃ m, range (J m)
> — source: Proofs/HadwigerNelson/Plane/SectorPoint.lean

> def HasArcEdges (D : ThreePiece U c x) : Prop :=
>   ∀ i j, i ≠ j → ∃ γ : C(unitInterval, ℂ), Function.Injective γ ∧ γ 0 = x ∧ range γ ⊆ D.edge i j
> — source: Proofs/HadwigerNelson/Plane/ThreePiece.lean

> def edge (D : ThreePiece U c x) (i j : Fin 3) : Set ℂ := closure (D.piece i) ∩ closure (D.piece j) ∩ D.nbhd
> — source: Proofs/HadwigerNelson/Plane/ThreePiece.lean

Read against the claim list's words (the brief's quotation of `data/fs124/claims-K2.md` § Definitions), clause by
clause: "three arcs (homeomorphic images of [0, 1])" — `J m` continuous and injective on a compact interval; "from x" —
`J m 0 = x`; "to the circle ∂B(x, r)" — `dist (J m 1) x = r`; "inside B(x, r) but for their far ends" — the fourth
clause; "disjoint but for x" — the fifth; "the three components of B(x, r) ∖ (J_0 ∪ J_1 ∪ J_2) are the pieces" — each
piece is a component, and the pieces fill the cut disc. **No clause is missing and none is added.** Two remarks, neither a
defect:
1. **The sixth clause is implied by the seventh and the decomposition's own fields.** The pieces of a `ThreePiece` are
   open, preconnected and pairwise disjoint (`isOpen_piece`, `isPreconnected_piece`, `disjoint_piece`); three such sets
   whose union is the cut disc are its components. My route reads the seventh clause and never the sixth (Stage 3).
2. **The definition hands the proof the count.** The classical θ-curve theorem has two halves: the cut disc has *exactly
   three* components, and each arc borders exactly two of them. `IsSector` *assumes* the first half — the list's words
   do ("such that the three components … are the pieces") — so the leaf is the second half only. That is where the
   price falls (Stage 3).

`HasArcEdges` is exactly what its two consumers read: `ThreePiece.HasArcEdges.saves_of_separatesAt` uses the arc of
the one edge joining the inner and the outer piece at `w`, which piece pair that is depends on `w`, so every pair is
needed; `HasArcEdges.isFull` uses a second point of each edge near `x`. (Narrower forms are possible and are not this
job's: the second implementer's note that the arc lemma "reads injectivity at one pair of points only" stands.)

**The module's planner on what the leaf needs** (`plans/FS124-kernel-plan-2.md` § 2.4, read whole). Its steps 1 and 2
(the piece at a rim arc; the three are different, by the crossing lemma) are steps of my route. Its step 3 — "the step I
have not made precise" — I could not make work as written: as I read it, the continuum it builds (a path in the
other neighbour, the disc about `t`, the part of `J_m` beyond `t`) ends at `J_m`'s own far end, and that end and a
point of the neighbour's rim arc are not interleaved with the far ends of any two arcs it avoids; the crossing lemma
gives lower bounds on the number of regions, and this step needs an upper bound. My route takes it from unicoherence
(Stage 3). Its step 4 (an arc has empty interior) is not needed.

**This library's plane-topology module** (`Plane/PlaneTopology.lean`, 24 theorems and one definition, statements read
whole). The three my route uses:
- `isPreconnected_inter_of_union_eq_univ` — the plane is unicoherent;
- `inter_nonempty_of_interleaved_of_isClosed_left` — the crossing lemma for the unit disc, one continuum closed;
- `exists_inter_of_finite_closed_cover` — a preconnected set covered by finitely many closed sets, two of which meet
  it, has a point in two of them.
And one from `Plane/ValidMap/MapTopology.lean`: `inter_nonempty_of_interleaved_radius` — the crossing lemma on a circle
of any radius, over `polarPt u R θ = u + R e(θ)` (`Plane/LocalStructure`).

## Stage 2 — SAVED (FS124-K3): what exists

Searched by the statement's shape — three arcs, a θ-curve, a Jordan arc not separating a disc, components of the
complement of a tree or a triod, accessibility of a boundary point, a crosscut — in three places.

**This library** (`rg` over `Proofs/`, this worktree). No θ-curve, triod, crosscut or accessibility statement. What it
holds of the kind: unicoherence and the crossing lemma (above); `isPreconnected_frontier_connectedComponentIn` (the
frontier of a complementary component of a closed preconnected set is preconnected — tried against this leaf and not
enough by itself: the frontier of a region of the cut disc is a closed curve, which stays connected with a point
removed); `not_isHoleOf_union` (`Plane/ValidMap/MapGraph`, "Janiszewski's theorem for holes": two disjoint bounded
continua with no hole have none together — its two continua are disjoint, three arcs through a point are not);
`ArcMap.IsJordanDomain` and its charts (`Plane/ArcMap`, `Plane/LocalStructure` — a hypothesis on a map's tiles, not a
theorem about arcs). **Nothing here gives the leaf; three lemmas here are its whole foundation.**

**Mathlib at the pin** (`v4.32.0`; `rg -i` over `.lake/packages/mathlib/Mathlib` for "jordan curve", "unicoheren",
"janiszewski", "theta curve", "θ-curve", "schoenflies", "phragm.n.brouwer", "invariance of domain"): **no hit**. The
2026-10-04 grep recorded in `Plane/PlaneTopology`'s header stands.

**The outside release** (`/home/kooshi/source/math`, one commit `adc7f1241`, Lean `v4.34.1`; read, nothing written).
Three places hold plane topology; none holds the leaf, and the nearest is far.
1. `lean/OAI/Geometry/PlaneColoring/` (the family this project builds on, 14,661 lines). Its obstruction is a
   covering-dimension argument through lifts over a simply connected ball (`PlanarCovers.lean`: `ball_simplyConnected`,
   `hit_center`, `finite_partition_impossible`, `compact_open_cover_impossible`) and limits of continua
   (`ContinuumLimits.lean`). No statement about arcs, components of a cut disc, or separation.
2. `lean/OAI/Geometry/Cannon/PlaneTopology/` (67 files, 18,134 lines). Jordan-type statements — a crosscut gives two
   regions, an arc deleted from a region leaves it connected (`CrosscutIncidenceLocal.lean`:
   `tame_crosscut_components`; `TamePairJordanRegions.lean`: `tame_pair_jordan_regions`;
   `FreeArcDeleteConnected.lean`: `free_arc_delete_connected`) — **for polygonal arcs only**: each carries the
   hypothesis `range a ⊆ ⋃ q∈Q, segment ℝ q.1 q.2` for a finite set `Q` of segments. A sector point's arcs are
   arbitrary; these do not apply.
3. `lean/OAI/Analysis/CircleDomains/Topology/` (45,193 lines). **The nearest statement**:
   > def UnitDiskCrosscutSeparation : Prop :=
   >   ∀ p : C(PathTime, ℂ), Injective p → ‖p 0‖ = 1 → ‖p 1‖ = 1 →
   >     (∀ t ∈ Ioo (0 : PathTime) 1, ‖p t‖ < 1) →
   >     ∃ U V : Set ℂ, IsOpen U ∧ IsOpen V ∧ IsConnected U ∧ IsConnected V ∧
   >       Disjoint U V ∧ U ∪ V = Metric.ball 0 1 \ range p ∧
   >       frontier U ∩ Metric.ball 0 1 = range p ∩ Metric.ball 0 1 ∧
   >       frontier V ∩ Metric.ball 0 1 = range p ∩ Metric.ball 0 1
   > — source: /home/kooshi/source/math/lean/OAI/Analysis/CircleDomains/Topology/CrosscutSeparationInput.lean

   — a crosscut of the unit disc for arbitrary arcs, proved as `unitDiskCrosscutSeparation (hsch : PlanarSchoenflies)`
   (`CrosscutSeparationProof.lean`) **over the Jordan–Schoenflies theorem as a hypothesis**, which
   `PlanarSchoenfliesProof.lean` discharges from a third party's package (`import Schoenflies.JordanSchoenflies`;
   the release's lakefile: `require «schoenflies-lean» from git "https://github.com/alonamaloh/schoenflies-lean" @
   "05a43d29cde026618777db3d4e4316204ccca237"`). **What a port would bring with it**: the module cone of
   `CrosscutSeparationProof` inside the release is 247 modules, 24,695 lines (my count by import closure, an upper
   bound on the declaration cone), plus the Schoenflies package, which is **not held on this machine** (the clone has
   no `.lake/packages`) and whose size I did not measure, all at another Mathlib; and from two crosscuts the three-arc
   fact is still a further argument. **I do not recommend a port**: the route of Stage 3 needs none of it.

**In print.** The fact is classical (the θ-curve lemma under the Jordan curve theorem). **Recalled, not read**: no source
is held in `~/source/library/` and `BIBLIOGRAPHY.md` has no entry for it; the derivers cite it the same way ("the
θ-curve form of the Jordan–Schoenflies theorem: recalled, not read", `plans/FS124-derivation.md`, C124-FORCED's `uses
only` line). The route below proves it here and cites nothing.

## Stage 3 — SAVED (FS124-K3): the statement typed with its model, the route, the price, the alternative

### 3.1 The statement, in the form its proof gives and its consumers need

A new module, `Proofs/HadwigerNelson/Plane/ThreeArcs.lean` (pure topology of `ℂ`; imports
`Plane/ValidMap/MapTopology`, `Mathlib.Topology.UnitInterval`, `Mathlib.Data.Fin.Tuple.Sort`; registered in
`Proofs.lean` and `ARCHITECTURE.md`). Two predicates and one theorem carry it:

> structure IsTriod (x : ℂ) (r : ℝ) (J : Fin 3 → C(unitInterval, ℂ)) : Prop where
> — source: Proofs/HadwigerNelson/Plane/ThreeArcs.lean

(its six fields are `0 < r` and the five arc clauses of `IsSector`, in `IsSector`'s order and words)

> structure IsTriodCut (x : ℂ) (r : ℝ) (J : Fin 3 → C(unitInterval, ℂ)) (P : Fin 3 → Set ℂ) : Prop
>     extends IsTriod x r J where
> — source: Proofs/HadwigerNelson/Plane/ThreeArcs.lean

(the pieces open, preconnected, pairwise disjoint, and `⋃ i, P i = ball x r \ ⋃ m, range (J m)`)

> theorem exists_opposite (h : IsTriodCut x r J P) :
>     ∃ opp : Equiv.Perm (Fin 3), (∀ m i, i ≠ opp m → range (J m) ⊆ closure (P i)) ∧
>       ∀ m, closure (P (opp m)) ∩ range (J m) = {x} := by
> — source: Proofs/HadwigerNelson/Plane/ThreeArcs.lean

**Read back against the derivers' words** for the input (`plans/FS124-derivation.md`, C124-FORCED, `uses only`): "each
of the three arcs of its decomposition lies in the closure of exactly two of the three components and that every two
components share one arc". `opp` is the piece an arc does *not* border: the first conjunct is "lies in the closure of"
the two others, the second is "exactly" (the arc meets the third closure at the centre only), and `opp` being a
bijection is "every two components share one arc" — the arc opposite the third component. Nothing is added: the
hypothesis is the definition's own data.

The form the leaf reads:

> theorem exists_arc (h : IsTriodCut x r J P) {N : Set ℂ} (hN : N ∈ 𝓝 x) {i j : Fin 3} (hij : i ≠ j) :
>     ∃ γ : C(unitInterval, ℂ), Function.Injective γ ∧ γ 0 = x ∧ range γ ⊆ closure (P i) ∩ closure (P j) ∩ N := by
> — source: Proofs/HadwigerNelson/Plane/ThreeArcs.lean

**The model.** The ordinary three-sector point: the radii along `1`, `i`, `−1 − i` of the disc of radius `1/4` about
`0`, and its three sectors — `sectorPoint_isSector` (`Plane/SectorPoint`, a leaf of the job running beside this one).
The data of any `IsSector` is an `IsTriodCut` field for field (checked: the first `example` of
`data/fs124/k3/lean/Bridge.lean`), so that theorem is the inhabitant, and the module's header names it. By hand on it:
every two sectors share a radius, and the radius along `1` meets the closure of the sector between `i` and `−1 − i` at
`0` only — the statement says what the picture shows. *A hypothesis that cannot be dropped*: without the fill clause
three small discs off the arcs satisfy the rest and share nothing.

**The line that closes the leaf** — for `Plane/SectorPoint.lean`, which this job does not write (elaborated as the
second `example` of `data/fs124/k3/lean/Bridge.lean`; the file needs `import Proofs.HadwigerNelson.Plane.ThreeArcs`):

```lean
theorem IsSector.hasArcEdges {D : ThreePiece U c x} (h : D.IsSector) : D.HasArcEdges := by
  obtain ⟨r, hr, J, h1, h2, h3, h4, h5, -, h7⟩ := h
  exact fun i j hij => IsTriodCut.exists_arc ⟨⟨hr, h1, h2, h3, h4, h5⟩, D.isOpen_piece, D.isPreconnected_piece,
    fun _ _ hab => D.disjoint_piece hab, h7⟩ D.nbhd_mem hij
```

The dash is the sixth clause of `IsSector`, unread (Stage 1, remark 1).

### 3.2 The route

Write `B` for the open disc, `S` for its rim, `T` for the union of the three arcs, `e_m` for the far end of `J_m`,
`P_i` for the pieces. The fill clause is the hypothesis throughout.

1. **A rim point off the far ends is in exactly one closure.** `T` is closed, so a small disc about the point misses
   it; its part in `B` is convex, inside `B ∖ T`, hence inside one piece; the point is a limit of it, and no other
   piece meets that small disc. (`exists_unique_mem_closure`.) So two closures meet on `T` only: inside `B` a point off
   `T` is in a piece, an open set meeting no other piece. (`closure_inter_closure_subset`.)
2. **One piece along each arc of the rim.** Order the far ends round the rim, at angles `θ_0 < θ_1 < θ_2 < θ_0 + 2π`
   (`exists_perm_polarPt`: sort the three arguments). Each of the three open arcs of the rim between consecutive far
   ends is preconnected and covered by the three closures, no two of which share a point of it: it lies in one
   (`exists_forall_rimArc`, by `exists_inter_of_finite_closed_cover`). Call that piece `Q_k` for the rim arc from
   `e_k` to `e_{k+1}`; its closure holds both far ends.
3. **The three are different** — the crossing lemma, once per pair. If one piece `Q` had two rim arcs in its closure,
   `Q` with a point of each is preconnected (`IsPreconnected.subset_closure`), lies in the closed disc and misses `T`;
   two of the arcs `J_a ∪ J_b` are a continuum joining far ends that interleave with the two points; they would meet.
   (`not_mem_closure_both_sides`, proved, over `inter_nonempty_of_interleaved_radius`.) So `k ↦ Q_k` is a bijection
   onto the pieces: every piece's closure holds two far ends.
4. **The part of `T` in one closure is connected** — unicoherence of the closed disc. `cl P_i` and `T ∪ cl P_j ∪ cl
   P_l` are closed, preconnected (step 3: each closure meets `T`), and cover the closed disc (step 1); so they meet in
   a preconnected set, and that set is `cl P_i ∩ T` (step 1). (`isPreconnected_closure_inter`, over
   `isPreconnected_inter_of_union_eq_closedBall`, proved: the plane's unicoherence for the preimages under the radial
   retraction — the outside is shared out along rays, which is what keeps it from gluing the two sets together.)
5. **A connected part of `T` holding two far ends holds both arcs.** Were `J_m(s₀)` missing, the part of `J_m` beyond
   it and the rest of `T` are closed, cover the set, each meet it, and share only that point.
   (`range_subset_of_isPreconnected`.) So `J_k ∪ J_{k+1} ⊆ cl Q_k`, and `J_k` lies in `cl Q_k ∩ cl Q_{k−1}`.
6. **Exactly two.** Were a point `J_m(s)`, `s > 0`, in the closure of the third piece `Q_{m+1}`, that piece with the
   part of `J_m` from `s` on is a preconnected set of the open disc off `J_{m+1} ∪ J_{m+2}` reaching the rim on both
   sides of their far ends: step 3's lemma again. (Inside `exists_perm_of_sorted`.)

No Jordan curve theorem, no "an arc does not separate", no "an arc has empty interior": the count of components is
the definition's, and the two tools are in this library. **A second route** I weighed and dropped: the frontier of a
complementary component is preconnected (`isPreconnected_frontier_connectedComponentIn`) — true and not enough, the
frontier of a region being a closed curve; and the release's crosscut theorem (Stage 2) — a port of a Schoenflies proof
for a statement this route does not need.

### 3.3 The price

**Measured from the leaves taken through the build** (`data/fs124/k3/logs/build-1.log`: `EXIT 0`, 2 modules rebuilt,
23 `declaration uses sorry` warnings — the 6 as given and 17 here — and no other; `tools/check_architecture.py`:
`RESULT: PASS`): the module states 34 theorems; **17 are proved in 151 lines of proof** —
- the closed disc is unicoherent: 8 declarations, 87 lines (`ballRetract_of_mem_segment` 29,
  `isPreconnected_preimage_ballRetract` 21, `isPreconnected_inter_of_union_eq_closedBall` 16, its model 8, four
  one-step lemmas);
- the crossing leaf `IsTriod.not_mem_closure_both_sides`: 46 lines;
- eight facts about the arcs: 18 lines.
My estimate for those 17 before writing them was about 235 lines; they took 151. **The 17 left** I estimate at 545
lines on the same scale — about 350 to 450 at the measured ratio — the largest `exists_perm_of_sorted` (the assembly,
about 130). **The module whole: about 500 to 600 lines of proof**, one implementer, no leaf that I cannot price from
one tried: every remaining leaf is point-set bookkeeping over the two proved tools. Axioms of the proved tools as
printed from the build's library (`data/fs124/k3/logs/bridge.txt`): `[propext, Classical.choice, Quot.sound]`;
`IsTriodCut.exists_arc` prints `sorryAx` (the control: the print tells them apart).

### 3.4 The alternative: re-fixing "sector point" as "each edge contains an arc from the point"

For each hand entry that says "sector point": does its argument use the three arcs for anything but arc edges and
fullness? Read: `plans/FS124-derivation.md` § 3 and the arguments in `plans/FS124-E2-derivation.md`;
`plans/FS136-E1-derivation.md` Stage 4.

| entry | what it reads of the three arcs | under the re-fixed definition |
|---|---|---|
| C124-BOTH, second sentence | "every two components share an arc of the decomposition … so a sector point is full, and the argument of C124-FORCED gives each member its arc of `S(w)`" — arc edges and fullness | unchanged but for the word (it is what the kernel holds: `closePair_both_saved`) |
| C124-FORCED, first sentence (`w` is saved) | the shared arc lies in the edge of the inner and the outer piece — an arc edge | unchanged but for the word (`ThreePiece.HasArcEdges.saves_of_separatesAt`) |
| **C124-FORCED, second sentence** (tight at every interior point `z` of the arc) | "`B(z, ρ) ∖ S(w)` has two components, each connected and disjoint from the three arcs, so each inside one piece" — **that off the arcs the cut disc is the pieces and nothing else** | **more than a word: the step fails for an arc-edged point by the letter** (below); the sentence would need a new hypothesis or be dropped |
| C124-SECOND | "would share an arc of the decomposition lying on the circle, a second edge"; "if the same arc of the decomposition served at `w′` … a non-trivial arc on two distinct circles" — an arc edge each time: the edge of an inner and an outer piece lies on the circle (`ThreePiece.edge_subset_sphere`) and holds infinitely many points | unchanged in substance; "arc of the decomposition" becomes "edge" in two sentences |
| **C136-PARTNERS** | "the edge `J` (an arc from `x`)"; "`A` is a connected subset of the arc `J` containing its first point, so it is an initial piece `J([0, t₀])`, and `J([t₀, 1])` is compact and misses `x`" — **that the edge *is* one arc** (the "exactly two" half; here `IsTriodCut.closure_inter_closure_inter_ball`) | **more than a word**: "begins with an arc of `S(w)`" must be re-read as "near `x` the edge lies on `S(w)`", and "the partner" re-argued from `edge_subset_sphere`; with "contains an arc of `S(w)` with an end at `x`" its first step fails for an arc-edged point by the letter (below) |
| C124-EDGE-CLOSED, C124-EDGE | nothing: six uses of C124-TYPE on named pieces of a held map, and exact comparisons | unchanged (neither says "sector point") |
| C124-LONE-EXISTS, C124-FORCED-AS-POSED, the model lines | "a sector point" names a model's three-sector vertex | unchanged: arc-edged by construction |

**Two configurations, topology only — neither is checked against any constraint a weak colouring puts on pieces** (one
mind, by hand). (i) *An inner piece that is a comb.* Along an arc `A` of `S(w)` from `x` let the inner piece be a comb
inside the circle whose teeth stop short of `A`, at heights tending to `0`, with feet dense along `A`; the outer piece
the outside; and let the third piece hold the thin layer between the tips and `A`, joined to the rest of itself round
the comb. All three closures contain `A`, so the decomposition has arc edges and is full; and in every disc about an
interior point of `A` the third piece has positive measure inside the circle: the pair is not tight for the two labels
by the pieces alone. (ii) *An edge holding arcs of two circles.* Two pieces meeting along arcs `R₁ ⊂ S(w)` and `R₂ ⊂
S(w″)` from `x`, the third piece two such thin layers along an initial part of `R₁`, one in each, joined through a gap
in `R₁` away from `x`: arc-edged, and one edge contains an arc of each circle with an end at `x`. For a sector point
neither can happen — inside the disc an edge is one arc, and the third piece's closure meets it at `x` only: the two
"exactly" facts, which are the second conjunct of `exists_opposite`.

**What a reader would lose**: a definition recognised on a picture and checked on a map (three arcs cutting a disc: a
vertex of three tiles), together with the two facts above that come with it and that C124-FORCED's tightness and
C136-PARTNERS read. **What the re-fixing would save**: the 350 to 450 lines left of this module. **My reading**: keep
the list's definition and build the leaf; the bridge is short because the definition supplies the count, and the wider
class is not the class two of the hand entries argue about. The ruling is the coordinator's, with the derive lane.

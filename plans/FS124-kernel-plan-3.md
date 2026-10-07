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

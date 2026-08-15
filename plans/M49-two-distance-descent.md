# M49 — The two-distance descent: from a rigid six-forcer with defects toward the plane

*(Subplan, 2026-08-15, desktop, on Kooshi's go: "Excellent idea. You are go for M49
subplanning and implementation." Written SELF-CONTAINED for a fresh session: everything below is
stated in full, with the mission context first. §0 is REGISTERED before any campaign instrument
runs; only the seed re-derivation and three solver timings in §0e were measured before writing,
and they are reported as pre-registration measurements, not predictions.)*

## §A. The one-paragraph version, for a reader who knows nothing

The famous question: how few colours suffice to colour every point of the plane so that no two
points exactly one unit apart share a colour? Known: 5, 6 or 7 — and this repository holds both
ends kernel-checked (`Instances/Interval.lean`). The project's whole purpose is the next rung,
**six**: a finite unit-distance graph that no five colours can properly colour. Every campaign
since M30 has asked existing five-colour-forcing graphs whether they hide any *rigid* structure at
five colours — a pair of points forced to agree, or forced to differ, in every proper
5-colouring — because one such rigid pair closes the problem (§B). Every reading was zero, and M48
proved the zero complete on de Grey's graph through triples: **there is nothing to extract from
existing witnesses; a rigid pair at five colours must be constructed.**

This milestone changes stance. Instead of asking floppy unit-distance material whether anything
is forced, it starts from an object that IS rigid at five colours — a finite graph in the plane
whose edges are pairs at distance 1 **or distance 2**, which cannot be 5-coloured (published,
2019–2023, never certified) — and tries to trade its distance-2 edges for unit-distance material,
one at a time, keeping the graph non-5-colourable. Each distance-2 edge is a *defect*: a place
where the graph uses a constraint the plane's unit-distance graph does not have. The number of
defects a non-5-colourable graph needs is a well-defined invariant, **μ**; μ = 0 is exactly
χ(ℝ²) ≥ 6, and — the theorem this milestone puts in the kernel first — **μ = 1 already implies
χ(ℝ²) ≥ 6** (remove the one bad edge: its endpoints are forced equal in every 5-colouring; rotate
a copy about one endpoint until the other endpoints are a unit apart; the Moser spindle argument,
one level up). So the descent is a dial with a jackpot at its end, it starts from a positive
number rather than from a void, and it is calibrated: the same descent one colour down (a
{1,2}-graph forcing FIVE colours, which this repository already holds as the 122-core with its
forty distance-2 pairs) is known to reach zero — de Grey did it in 2018 — through material one
number field up.

## §B. The reduction, stated exactly (and why "reduction" is too kind a word)

Let `k = 5`. A **rigid pair** in a finite unit-distance graph `G` at five colours is either

* **forced-equal**: `u, v` non-adjacent, `C u = C v` for every proper 5-colouring `C` — equivalently
  `G + uv` is not 5-colourable, i.e. `G + uv` is a **6-chromatic plane graph with one non-unit
  edge**; or
* **forced-distinct** (a "virtual edge"): `C u ≠ C v` for every proper 5-colouring — equivalently
  `G/uv` (identify `u, v`) is not 5-colourable, a **6-chromatic plane graph with one identified
  pair**. Since `χ(G/uv) ≤ χ(G) + 1`, this forces `χ(G) = 5`.

Either one closes χ(ℝ²) ≥ 6:

* forced-equal at ANY distance `d ≥ 1/2` → the spindle (§C, kernel this milestone);
* forced-distinct at distance `d` → needs a *pigeonhole* at `d`: a finite `{1,d}`-graph that is
  6-chromatic (every 5-colouring of the plane's unit graph then puts a mono pair on one of its
  `d`-edges, and the forced-distinct gadget placed there kills it). For `d = 2` such a graph EXISTS
  in the literature (§D). For the hex-shell pigeonhole (`Instances/HexShell.lean`) it needs `d = √3`
  AND `d = 2` (M48's correction stands for THAT pigeonhole).

**So both kinds of rigid pair are "a 6-chromatic plane graph with one defect", and the reduction
relocates the difficulty rather than shrinking it.** The Frontier's "the 6-forcer reduces to one
gadget" (G26) is true and trivially so; the honest statement is: *the target is a 6-chromatic plane
graph, and one unit of geometric slack is allowed.* This milestone's invariant μ measures exactly
how much slack a 6-chromatic plane graph currently needs.

## §C. The kernel layer (phase 0) — statements before proofs

Two new modules and one instance module. Names are provisional until the domain-modeling pass.

**`Proofs/HadwigerNelson/DistanceGraph.lean`** — the plane's graph for a SET of forbidden distances.
```lean
def distanceGraph (V : Type*) [MetricSpace V] (D : Set ℝ) : SimpleGraph V   -- Adj x y := x ≠ y ∧ dist x y ∈ D
theorem distanceGraph_adj …
theorem unitDistance_eq_distanceGraph_singleton : unitDistance V = distanceGraph V {1}
theorem distanceGraph_mono (h : D₁ ⊆ D₂) : distanceGraph V D₁ ≤ distanceGraph V D₂
theorem chromaticNumber_unitDistance_le_distanceGraph (h : (1:ℝ) ∈ D) :
    (unitDistance V).chromaticNumber ≤ (distanceGraph V D).chromaticNumber
theorem add_one_le_chromaticNumber_distanceGraph_edgeList (E) (p : Fin n → V)
    (hp : ∀ e ∈ E, dist (p e.1) (p e.2) ∈ D)   -- membership, and 0 ∉ D or p injective on edges: settle in modeling
    (hG : ¬ (edgeGraph n E).Colorable k) : ((k+1 : ℕ) : ℕ∞) ≤ (distanceGraph V D).chromaticNumber
theorem chromaticNumber_distanceGraph_congr (e : V ≃ᵢ W) : … = …
-- homogeneity, generalized from Homogeneous.lean (the isometry z ↦ az+b preserves every distance):
theorem forced_pair_of_forced_distanceGraph {D} … (∀ C : (distanceGraph ℂ D).Coloring α, C x₀ ≠ C y₀) → dist x y = dist x₀ y₀ → C x ≠ C y
theorem forced_equal_of_forced_equal_distanceGraph … (= polarity)
theorem Forces.plane / Separated.plane for distanceGraph
```

**`Proofs/HadwigerNelson/Spindle.lean`** — the Moser argument as a theorem, `k`-generic.
```lean
theorem exists_dist_eq_dist_eq {x y : ℂ} {d : ℝ} (hxy : dist x y = d) (hd : 1/2 ≤ d) :
    ∃ z, dist x z = d ∧ dist y z = 1                      -- Glue.sphere_inter_sphere at radii d, 1
theorem not_colorable_of_forced_equal {D : Set ℝ} (h1 : (1:ℝ) ∈ D) {k : ℕ} {d : ℝ} (hd : 1/2 ≤ d)
    (h : ∀ (C : (distanceGraph ℂ D).Coloring (Fin k)) (x y : ℂ), dist x y = d → C x = C y) :
    ¬ (distanceGraph ℂ D).Colorable k
theorem add_one_le_chromaticNumber_of_forced_equal … : ((k+1 : ℕ) : ℕ∞) ≤ (distanceGraph ℂ D).chromaticNumber
theorem forces_of_not_colorable_append_single (h : ¬ (edgeGraph n (E ++ [(u,v)])).Colorable k) :
    Forces (edgeGraph n E) k u v                          -- Pigeonhole.mono_pair_of_not_colorable_append, P = [(u,v)]
theorem add_one_le_chromaticNumber_plane_of_one_defect (E) (u v) (q : Fin n → ℂ)
    (hp : ∀ e ∈ E, dist (q e.1) (q e.2) = 1) (hd : dist (q u) (q v) = d) (hhalf : 1/2 ≤ d)
    (hG : ¬ (edgeGraph n (E ++ [(u,v)])).Colorable k) : ((k+1 : ℕ) : ℕ∞) ≤ (unitDistance ℂ).chromaticNumber
-- the {1,2} instance the descent's endpoint would consume: μ(2) = 1 ⟹ χ(ℝ²) ≥ 6.
```
Spec obligations (the standing rule): a model of the hypotheses — **the rhombus at k = 3**
(`Gadget.rhombus`, tips forced equal at √3) run through `add_one_le_chromaticNumber_plane_of_one_defect`
gives **χ(ℝ²) ≥ 4, a second proof of the Moser bound through the abstract lemma** — the whole
chain exercised at `decide` size; and the red control: `hd : 1/2 ≤ d` load-bearing (at `d < 1/2`
the two circles miss — `Glue.sphere_inter_sphere_eq_empty_of_nested`), stated as an example.

**`Proofs/HadwigerNelson/Instances/OneTwo.lean`** (+ `OneTwo/{Base,Aug,Cnf/}`) — the certified
seed. Two independent kernel routes to the same headline (the "prove it twice" gate):
* **Route 1 (the mathematics):** `Forces (edgeGraph 426 oneTwoH) 5 A B` via `Gadget.ofUnsat` on
  the port patterns of (A, B, a palette triangle) — every pattern with `A ≠ B` refuted by a pinned
  LRAT — then geometry (`Valid` for the unit edges, `PairsAt … 4` for the distance-2 edges,
  `PairsAt [(A,B)] 25` for `|AB| = 5`) → `Forces.plane` for `D = {1,2}` → the spindle theorem →
  `six_le_chromaticNumber_distanceGraph_one_two : 6 ≤ (distanceGraph ℂ {1,2}).chromaticNumber`.
* **Route 2 (the finite check):** the union `K = H ∪ H'` refuted by the Gadget algebra alone —
  `mono` (H's list into K's), `transport` along the rotation's index permutation, `edge B B'`,
  `inter`, `survivors = []` — giving `¬ (edgeGraph 426 oneTwoK).Colorable 5`, then the edge-list
  reduction for `distanceGraph`. Same theorem, no spindle lemma, no homogeneity.
* Corollaries for the from-below hunt: `oneTwo_plane : ∀ C : (unitDistance ℂ).Coloring (Fin 5),
  ∃ x y, dist x y = 2 ∧ C x = C y` (Act One with a SINGLE class), and
  `six_le_chromaticNumber_plane_of_forced_distinct_two : (∀ C x y, dist x y = 2 → C x ≠ C y) → 6 ≤ χ`
  — the halved requirement, beside `HexShell.six_le_chromaticNumber_plane_of_forced_pairs`.
* Controls: `#guard`s on lengths, `eraseDups`, `e.1 < e.2`, `denom`, `badEdges.isEmpty`; the
  adversarial moved vertex failing both `Valid` and `PairsAt`; `*_pairs_complete` (the listed
  distance-2 pairs are ALL of them — decide over n²); the red control `oneTwoK_colorable_six` (an
  explicit proper 6-colouring using all six colours) and `oneTwoK_unit_colorable_five` (the
  unit-edge part alone IS 5-colourable — so the distance-2 edges are load-bearing).

## §D. The seeds, and what was measured before registration (§0e)

**Exoo–Ismailescu 2020** (arXiv:1909.13177): points `[a,b,c,d] := ((a√3+b√11)/12, (c+d√33)/12)` —
the SEAM FIELD ℚ(√3,√11), our home field, whose unit chords M24–M26 classify completely. 23 seed
points; `T` = seeds ∪ x-reflections ∪ y-reflections (57); `V` = six rotations of `T` by π/3 (205,
graph `G`); `H` = `V` + 9 named points (214) with `A = [−2,0,0,−6]`, `B = [8,0,0,4]`, `|AB| = 5`;
`K` = `H ∪ H'` where `H'` is `H` rotated about `A` by `arccos 49/50` (the 5–5–1 isosceles triangle;
`|BB'| = 1`), 426 points. Verified in the paper by a custom exhaustive search only.

**Re-derived here from the paper's data alone (2026-08-15, exact rational arithmetic on the
4-coefficient basis, `tools/m49_rederive.py`) — every published count reproduces exactly:**
`|T| = 57`, `|V| = 205`, `G`: 966 unit + 423 distance-2 edges; `|H| = 214`, 1004 + 446;
`|AB|² = 25`; `|K| = 426`, 2009 + 892; `|BB'| = 1`. `G` has **exactly 18** proper 5-colourings up
to palette (36 with a triangle pinned), `H` **exactly 35** (70), and **`A = B` in every one**. `K`
is 6-colourable (control) and its unit-edge part alone is 5-colourable (control).

**Solver timings measured before registration** (desktop, plain CaDiCaL, wall seconds):
`K` at k = 5 unpinned: **unknown at 600 s** (the monolithic refutation is hard);
`H` with pins `A=0, B=1` only: unknown at 300 s; `H` with `A ≠ B` as clauses + first-occurrence
palette breaking (degree order): **UNSAT 4.9 s**; `H` with a full-palette cube `A=0, B=1,
triangle=2,3,4` (kernel-shaped: base + unit pins): **UNSAT 3.9 s**; with `A` sharing the
triangle's colour: 5.4 s; `K` whole with first-occurrence breaking: UNSAT 208 s; `K` with the
single pin `A=0`: unknown at 300 s. **Decision this fixes:** the certificate is COMPOSED (H's forced pair as
a gadget, ~13 or fewer full-palette cubes, each seconds), never monolithic — G18 again.

**Parts 2020/23** (arXiv:2010.12656): for `d = 2`, `G199` (199 v, 870 unit + 273 distance-2, a
forced mono pair at `5/√3`) → a 397-vertex 6-forcer, built from Minkowski sums of the hexagonal
wheel `G7` (our hex shell) and its rotations by `arccos 5/6` — **the Moser twist
`ρ = ζ₆³σ⁻²` (`FieldWall.lean`)** — so the object is our own certified seam fabric read in the
{1,2}-graph. Its exact reconstruction is described in prose ("`G19 ⊕ G19 ⊕ G7`, discarding vertices
outside radius √3, then reduced") and is a phase-1 task with a planted-count control; the E–I
graph, being fully explicit, is the primary seed. Also: for `d = φ` a 16-vertex 6-chromatic
{1,φ}-graph (28 unit + 28 φ-edges, human proof) — μ(φ) is computable EXACTLY there (§0 P8).
De Neve et al. (Amer. Math. Monthly 2025): `d = 3` (33 vertices), `d = 2+√6` (117) — data not yet
in hand.

## §0. Registered predictions and their priors (BEFORE any campaign instrument runs)

The verdict vocabulary throughout: `unknown ≥ cap` is never a verdict; a "removed" 2-edge is a
claim only after (i) UNSAT of the augmented object at k = 5, (ii) re-confirmation in the 3-bit
encoding (`rigidity.reencode_confirm`), (iii) the halo shrunk 1-minimal with a necessity witness
per survivor. **Jackpot clause, verbatim: any μ = 0 or μ = 1 outcome at k = 5 is χ(ℝ²) ≥ 6 — HALT,
re-derive the graph independently, re-refute in a second encoding, and report before
interpreting.**

* **P1 (seed).** The E–I counts reproduce (DONE before registration, §D) and the composed
  certificate lands on axioms exactly `[propext, Classical.choice, Quot.sound]` with every cube's
  LRAT under 10⁶ lines. Prior 0.85. Failure clause: if any cube exceeds the emitter's comfort,
  split it further (more ports) — never buy `native_decide`.
* **P2 (μ from the seed).** The essential distance-2 edge count of the certified 6-forcer — the
  size of a 1-minimal distance-2 edge subset keeping it non-5-colourable, greedy over several
  random orders — is at most one third of the total (≤ 297 of 892 for K; ≤ 149 of 446 for the
  forced-equal carrier H). Prior 0.7. (Their construction includes EVERY distance-2 pair among the
  points; nothing suggests all are load-bearing.)
* **P3 (structure of the essential set).** The essential 2-edges are not spread uniformly: at
  least half of them lie within distance 3 of the forced pair `A, B` (i.e., the forcing is carried
  near the ports). Prior 0.5 — a genuine coin flip, registered so the reading cannot be post hoc.
* **P4 (calibration at k = 4).** On the 122-core read as a {1,2}-graph (40 distance-2 pairs, not
  4-colourable): (a) its essential 2-edge count is ≥ 30 of 40 (the pigeonhole was shrunk 1-minimal
  in vertices, not edges, but the five dihedral classes are all needed) — prior 0.6; (b) the
  seam-field halo (`hexchunk` material at seam depth ≤ 3, ≤ 5,000 points, unit edges only) removes
  **no** essential 2-edge — the G1 prediction that seam-field unit material cannot do a √15 job —
  prior 0.75; (c) the one-field-up halo (`RHO15`/`HALF15` closure material about the endpoints)
  removes at least one — prior 0.6. **If (b) fails, the halo has produced a 5-chromatic
  seam-field unit-distance graph, which falsifies G1 and is itself news: HALT and verify.**
* **P5 (the k = 5 descent, seam halo).** On the certified {1,2}-6-forcer, the seam-field halo
  removes at least one essential distance-2 edge. Prior 0.35.
* **P6 (the k = 5 descent, one field up).** With `√ρ₁₅ / √ρ₆₃` material admitted, at least one
  further essential edge is removed. Prior 0.4. Removes all (jackpot): prior 0.02.
* **P7 (cost ratio).** Where a removal succeeds at both k = 4 and k = 5 by the same halo family,
  the k = 5 removal costs at least 3× the halo vertices of the k = 4 one (the recursion's cost
  reading, G25). Prior 0.6.
* **P8 (μ(φ) exactly).** On Parts's 31-vertex {1,φ} 6-forcer the minimum number of φ-edges over
  all non-5-colourable subgraphs is ≥ 20 of 56 (the K5-pentagons' diagonals are load-bearing).
  Prior 0.6. This is the ONE μ value the milestone can pin exactly, by exhaustive search on 31
  vertices, and it is a calibrator for what "essential fraction" looks like on a clique-heavy seed.

**What a flat outcome means, stated now:** if P5 and P6 both fail — no essential distance-2 edge
of a 6-forcer can be replaced by unit material from either pool at any affordable size — the
honest reading is *the seed's five-tightness is bought entirely by its distance-2 edges, and no
unit-distance halo up to the probed depth transmits it*; that is a stall value μ_stall > 0
reported as such, never as a bound on μ, and G26/G31 gain the sentence "the seam-field's {1,2}
six-forcers do not descend at probed depth". It is NOT evidence about χ(ℝ²).

## §1. Phases, in order (each closes with its numbers in §R before the next starts)

| # | phase | deliverable | control |
|---|---|---|---|
| 0 | **Kernel layer** (§C) — `DistanceGraph.lean`, `Spindle.lean`, skeleton of `Instances/OneTwo`; the rhombus spec | theorems on the standard three axioms; the Moser bound re-proved through the abstract spindle | `hd : 1/2 ≤ d` red; the rhombus at `d = √3` green |
| 1 | **Seed import + certification** — `tools/twodist.py` builds K exactly (16-int field vectors at a common denominator), re-checks §D, finds the palette triangle, emits the ~13 cubes (`scripts/Dimacs.lean` prints each CNF from the Lean definition; CaDiCaL `--lrat`; `emit_mask.py --colours 5`), assembles Route 1 and Route 2 | `six_le_chromaticNumber_distanceGraph_one_two` twice; `oneTwo_plane`; the from-below corollary | planted count assertions; the six-colouring red; unit-only-5-colourable red; `pairs_complete`; `axioms.sh` |
| 2 | **μ from the seed** — 1-minimal distance-2 edge subsets of K and of H (`mechanism.greedy_1min` over edge indices, predicate = UNSAT with breaking, ≥ 5 random orders), necessity census, 3-bit re-confirm; the essential set's geometry (distance to A,B; orbits under D6) | P2, P3 numbers; `build/m49-mu.json` | every survivor's deletion re-SATs (necessity witnesses); the certified object's own list as the green control |
| 3 | **Calibration at k = 4** — the 122-core as {1,2}-graph: edge-criticality (P4a); halo descent with the seam pool (P4b) and the √15 pool (P4c); per-removal cost | the calibration curve; the algorithm validated where the endpoint is known | de Grey's own success as the existence proof; the M34 forty-pair list as the green count |
| 4 | **The k = 5 descent** — same algorithm on the certified seed's essential edges: for each orbit representative, pools of increasing depth (seam, then one field up); each success re-confirmed, halo shrunk 1-minimal; μ curve vs pool | P5–P7; `build/m49-descent.json`; the stall value | jackpot clause armed; every "removed" edge triple-checked (UNSAT, 3-bit, shrunk) |
| 5 | **μ(φ) exactly** on Parts's 31-vertex graph; Parts's 397 reconstructed and cross-checked (its counts as planted controls) | P8; a second seed if the reconstruction lands | count controls |
| R | §R results, Frontier (ledger row 44, G-entries), report | | |

Order of the SAT-heavy phases respects "one heavy job at a time" (desktop, 32 cores).

## §2. Instruments

**New: `tools/twodist.py`** — the {1,d} campaign module, built on the standing suite (nothing in
`tools/` is trusted; every claim reaches the kernel through the emitters or is reported as
tools-side):
* exact points in ℚ(√3,√11) as `field.py` 16-int vectors at a common denominator (`emit_cert.py`'s
  input format), with the 4-coefficient `[a,b,c,d]` reader for E–I's data and the seam-group
  generators (`closure.Z6`, `SEAM`, `RHO15`, `HALF15`, `HALF63`) for pools;
* `classify(pts) → {"unit", "two"}` (grid-bucketed float proposal, exact disposal, planted
  norm-constant assertions — the M48 lesson) plus the exact `dist2 == r·denom²` test for any `r`;
* `refute(n, E, k, pins | breaking, cap)` over `forcer._solve` with `coloring.base_clauses` +
  `rigidity.amo_clauses` + `arity._brk`; models re-validated;
* `count_colourings(n, E, k, cap)` — blocking-clause enumeration with first-occurrence breaking
  (one representative per palette orbit) — the "exactly 18 / 35" instrument;
* `edge_critical(n, E1, E2, k, orders)` — `mechanism.greedy_1min` over the indices of `E2` with
  predicate UNSAT(E1 ∪ E2[sub]); necessity census; `reencode_confirm` at k = 5 (3-bit);
* `halo_descend(seed, pool, k, …)` — for a target 2-edge `e`: SAT(V ∪ P, unit(V∪P) ∪ E2∖{e}); on
  UNSAT shrink P 1-minimal (vertices) with necessity witnesses, re-confirm 3-bit, commit the
  removal; records every ask as a row with `claim_scope`;
* pools: `seam(depth B)` = `hexchunk` / `closure` seam-lattice material about the seed's centre and
  about the target edge's endpoints; `up(depth)` = `closure.close_gen` with the half-spindle
  generators; every pool row carries the pool's fingerprint;
* `--self-test`: planted controls — a shuffled edge list must not change the fingerprint; a
  moved point must fail classification; a fake "removal" (SAT) must be refused; the rhombus at
  k = 3 must read forced-equal.

**Kernel emission:** `emit_cert.py` for `Base.lean` (unit edges, `denom` = the common denominator
— expected 1200 = 12·2·50), the pair lists by hand-emitted `def`s (`Aug.lean`), `scripts/Dimacs.lean`
`emitOneTwo` printing each cube's CNF FROM THE LEAN DEFINITION, `emit_mask.py --colours 5` per cube.

## §3. Discipline and failure clauses

* Every SAT verdict that becomes a claim is either kernel-replayed (certificates) or double-encoded
  (one-hot + 3-bit) with the model validated in-process.
* `unknown` at cap is recorded as `unknown`, never folded into a negative; every row carries the
  cap and the pool fingerprint.
* A removal is a claim only after the three checks of §0.
* **Jackpot: HALT AND VERIFY**, verbatim as registered.
* **P4b's failure is a finding (a seam-field 5-chromatic UDG), not an error**: HALT and verify.
* Segfault from any process: HALT and report (standing rule).

## §4. Practical notes

* Desktop, 32 cores, 125 GB. Builds through `./scripts/build.sh` only. One heavy job at
  a time.
* The E–I graph's own coordinates carry denominators 12, halves after the π/3 rotation, and
  fiftieths after the spindle rotation; the common denominator is 1200 unless the design pass finds
  a better frame (rotating the whole figure so the spindle copy is integral is worth checking).
* Distance-2 spindle radicand is 15 (`field.spindle_radicand`), so a *forced-EQUAL at 2* at k = 5
  would need √15 for ITS spindle; E–I's forced pair is at distance **5** (radicand 99 = 9·11 — inside
  the seam field, which is why K stays in ℚ(√3,√11)). Register the observation: their spindle
  distance was chosen to keep the field closed.

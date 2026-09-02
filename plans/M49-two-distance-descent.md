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
theorem exists_dist_eq_and_dist_eq_one {x y : ℂ} {d : ℝ} (hxy : dist x y = d) (hd : 1/2 ≤ d) :
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

### §Cʹ. What the domain-modeling pass changed (2026-08-15, before any code)

1. **The spindle is homogeneity ∘ a triangle, and the "rotated copy" never appears.** The
   theorem's content splits cleanly: *combinatorics* — in any graph on a metric space in which unit
   pairs are adjacent, a colouring constant on all pairs at distance `d` cannot exist if a triangle
   with sides `d, d, 1` exists (`C y = C x = C z` against the unit side); *geometry* — such a
   triangle exists in ℂ **iff** `d ≥ 1/2` (`Glue.sphere_inter_sphere` at radii `d, 1`; the
   converse by the triangle inequality, `dist y z ≤ 2d < 1`, which is the red control). The
   universal "all pairs at distance `d`" is what homogeneity already supplies from one forced pair,
   so the classical construction (place a copy, rotate) is not a step of the proof at all.
2. **Route 1 needs only `H` (214 vertices), never `K`.** `Forces (edgeGraph 214 oneTwoAug) 5 A B`
   from the gadget; `Forces.plane` for `distanceGraph ℂ {1,2}` (homogeneity in the `=` polarity);
   the spindle at `d = 5`. And the two from-below corollaries — the single-class Act One
   (`∀ C : (unitDistance ℂ).Coloring (Fin 5), ∃ x y, dist x y = 2 ∧ C x = C y`) and the halved
   requirement — follow **abstractly** from `6 ≤ χ(ℝ²;{1,2})` (a unit-graph colouring with no
   mono distance-2 pair IS a `{1,2}` colouring). So the 426-vertex union `K` is not needed for any
   theorem; Route 2 (the finite `mono`/`transport`/`edge` composition on `K`) becomes optional,
   priced by its transport `decide` (~1450 edges × ~2900 memberships), and is NOT load-bearing.
   The certified object is `H`: table of 214 points at **denominator 24** (twelfths and halves —
   no fiftieths, those belong to `K`), 1004 unit edges, 446 distance-2 pairs, one pair at
   distance 5.
3. **Homogeneity is one relation-generic lemma, not two polarities:**
   `(∀ C : (distanceGraph ℂ D).Coloring α, R (C x₀) (C y₀)) → dist x y = dist x₀ y₀ → ∀ C, R (C x) (C y)`
   for any `R`; `Separated.plane` (`R := Ne`) and `Forces.plane` (`R := Eq`) are its instances,
   and `Homogeneous.lean` is generalized in place from `unitDistance ℂ` to `distanceGraph ℂ D` (the
   isometry `z ↦ az + b` preserves every distance), the unit statements kept as `D = {1}` corollaries
   through `unitDistance_eq_distanceGraph_singleton`. `Homogeneous.lean` has no downstream
   consumers beyond `Instances/AritySpec.lean`, so the in-place edit costs nothing.
4. **`distanceGraph` mirrors `unitDistance`, not `SimpleGraph.fromRel`:**
   `Adj x y := x ≠ y ∧ dist x y ∈ D`, symmetric by `dist_comm`, loopless structurally — the `≠`
   conjunct is intrinsic (a `SimpleGraph` is loopless whatever `D` contains). The single side
   condition it induces is `(0:ℝ) ∉ D` in the edge-list reduction (so `dist ∈ D` gives `p i ≠ p j`),
   discharged by `norm_num` once per `D`. New module `DistanceGraph.lean` — never an edit to
   `UnitDistance.lean`, which every certificate imports.
5. **μ stays out of the kernel.** A definition with no lemma API and no consumer besides prose;
   the theorem that carries its meaning — one defect suffices — is stated directly
   (`add_one_le_chromaticNumber_plane_of_one_defect`, from `forces_of_not_colorable_append_single`
   + `Forces.plane` + the spindle). μ lives in the tool and in §R.
6. **The reduction lemma earns a free consumer:** `hexShell`'s augmented list is a `K₇`, so
   `7 ≤ (distanceGraph ℂ {1, √3, 2}).chromaticNumber` becomes a *theorem* — the docstring of
   `hexShell_plane6` currently states it as prose only.
7. **The gadget→`Forces` bridge** is one general lemma:
   `forces_of_gadget (g : Gadget k n m E p) (i j : Fin m) (h : ∀ q, g.admits q = true → q i = q j) : Forces (edgeGraph n E) k (p i) (p j)`,
   `h` by `decide` over `Fin m → Fin k` (≤ 5⁵). Port design (`A, B` + a palette triangle, or
   `A`'s own triangle if it has one — 13 vs 3 cubes) is settled by measurement in phase 1.
8. **Spec obligations fixed:** the rhombus at `k = 3` (`Gadget.rhombus`, tips at `√3`) through the
   one-defect theorem yields χ(ℝ²) ≥ 4 — Moser re-proved through the abstract lemma; `H` is
   exhibited 5-colourable (one literal colouring, `decide`) so `Forces` is not vacuous; the
   `d < 1/2` red control as an `example` by the triangle inequality.

### §Cʺ. The obligation-modeling pass (2026-08-15) — the theory layer is PROVED, and it landed

Run against the elaborator rather than on paper: every statement of §C/§Cʹ was written, its proof
derived, and the modules built through `scripts/build.sh` in the same sitting (`DistanceGraph.lean`,
`Homogeneous.lean` generalized in place, `OneDefect.lean` — the theory module is named for its
payoff theorem, since `Instances/Spindle.lean` already names the Moser spindle — and
`Instances/OneDefectSpec.lean`). `OneDefect.lean` elaborated first try; the audit reads
`[propext, Classical.choice, Quot.sound]` on all seventeen new declarations. What the pass settled:

1. **`exists_isometry_map_pair` loses its `x₀ ≠ y₀`.** The degenerate branch is a translation, so
   `transport_pair` has no side condition at all — the strengthening was free and it removed the
   `by_cases` from every consumer.
2. **The spindle's proof is four lines** once the triangle is a lemma: `x := 0`, `y := (d : ℂ)`,
   `z` from `exists_dist_eq_and_dist_eq_one`, then `C.valid` on the unit side against `h C x y` and
   `h C x z`. The geometry lives entirely in `exists_dist_eq_and_dist_eq_one` (whose obligations are exactly
   `Glue.sphere_inter_sphere`'s annulus bounds — `|d − 1| ≤ d` IS `1/2 ≤ d`) and its converse
   `not_exists_dist_eq_and_dist_eq_one_of_lt_half` (the triangle inequality, three lines).
3. **`forces_of_gadget` is one line** — `g.sound C (C.valid)` then `h`; colour symmetry is not
   needed because `sound` quantifies over every proper colouring directly. Its `h` is a `decide`
   over `Fin m → Fin k`, measured instant at `m = 2, k = 3` (the rhombus).
4. **The unit graph appears exactly once**, at the end: every plane lemma is stated for
   `distanceGraph ℂ D` and `add_one_le_chromaticNumber_unitDistance_of_forces` rewrites with
   `unitDistance_eq_distanceGraph_singleton` (motive-correct after `revert`) — no unit-specific
   duplicates of the theory. `Separated.plane`/`forced_pair_of_forced` survive as `D = {1}`
   corollaries for their existing caller (`AritySpec`).
5. **The spec closed both entry points**: `four_le_chromaticNumber_plane_of_rhombus` (the `Forces`
   form, through `Gadget.rhombusGadget` and `forces_of_gadget` — which cross-checks against
   `Forcer.rhombus_forces`, proved another way) and `_of_rhombus_defect` (the append form: the
   rhombus plus its tip pair is `K₄`, refuted by `decide` over `3⁴`). Both give χ(ℝ²) ≥ 4 with no
   spindle drawn. The `d = 1/4` red control is an `example`.
6. **The obligation partition**: *prove* — everything above; *test* — the `#guard`/`example`s of
   the instance module (phase 1) and the rhombus spec; *assume* — nothing: no theorem in the layer
   carries a hypothesis a caller must discharge by hand beyond geometry the certificate produces
   (`Valid`, `PairsAt`) and `1/2 ≤ d` / `1 ∈ D` / `0 ∉ D`, each `norm_num`.
7. **The descent's invariants, stated as the tool's own obligations** (tools-side; nothing here is
   trusted): the state is `(V, E₁, E₂, log)` with `¬ Colorable 5 (E₁ ++ E₂)` an invariant re-checked
   after every step; `|E₂|` is the termination measure — it strictly decreases on every accepted
   step and no step may add a distance-2 edge (a halo point's distance-2 pairs to `V` are NOT
   edges; the classifier asserts it); a step is *accepted* only after (i) UNSAT of
   `E₁ ∪ unit(P) ∪ E₂∖{e}` at k = 5, (ii) the 3-bit re-encode agreeing, (iii) `P` shrunk 1-minimal
   with a necessity witness per survivor; the acceptance test is the exact condition (G21), not a
   sufficient one, because the invariant *is* what is asked. Every row carries the pool
   fingerprint and the cap; `unknown` is never folded.

### §Cʹʹʹ. The experience-modeling pass (2026-08-15) — the surface a caller meets

Walked as the phase-1 instance module will walk it (`Forces` from a gadget → the plane → the
headline → the from-below corollaries) and as the tool's row schema will be read by a fresh session.

1. **Two preambles every two-distance caller would repeat were folded into `PairDist.lean`:**
   `UDCert.pairsAt_sound_sq` (class distance a natural number `m`, `PairsAt … (m*m)` gives
   `dist = m` — every existing caller of `pairsAt_sound` at `r = 4` was rewriting `√4 = 2` by hand)
   and `UDCert.adj_dist_mem` (`Valid` + `PairsAt … r` ⟹ every adjacency of the augmented list
   `c.edges ++ ps` is realized in any `D ∋ 1, √r` — stated on adjacency, which is exactly the
   `hq` of `Forces.planeIn`/`Separated.planeIn`/`distanceGraphHom`, so the append split is written
   once). `PairDist.lean` is not upstream of any generated module; its dependents rebuilt in minutes.
2. **The from-below corollaries are general lemmas, not instance-local proofs:** in
   `DistanceGraph.lean`, `exists_mono_pair_of_not_colorable_distanceGraph` (a unit colouring
   avoiding every mono pair at `D ∖ {1}` IS a `D`-colouring — the pigeonhole reading) and
   `not_colorable_unitDistance_of_separated` (the kill reading), with the programme-shaped
   `{1, d}` instances `exists_mono_pair_of_not_colorable_two_distance` and
   `not_colorable_unitDistance_of_forced_distinct`. So the instance module's "Act One with a single
   class" and "the halved requirement" are each one application.
3. **Names transcribe statements:** the triangle lemma is `exists_dist_eq_and_dist_eq_one` (its
   converse `not_exists_dist_eq_and_dist_eq_one_of_lt_half`); the plane forms are
   `Separated.planeIn` / `Forces.planeIn` (dot-notation from the gadget's own proof: `hf.planeIn q
   hq h0 hd C hxy`), keeping `Separated.plane` as the unit-graph corollary its existing caller uses.
   The one-defect theorem keeps the house's long conventional name
   (`add_one_le_chromaticNumber_unitDistance_of_one_defect`, beside `_edgeList`).
4. **The instance module's surface (phase 1), fixed now:** `oneTwo : UDCert 214`, `oneTwo_valid`,
   `oneTwoPairs` (446), `oneTwo_pairs_dist : PairsAt oneTwoPairs (2*2)`,
   `oneTwo_pairs_complete` (decide over all ordered pairs — "these are ALL the distance-2 pairs"),
   `oneTwoAB : PairsAt [(iA, iB)] (5*5)`, `oneTwoAug := oneTwo.edges ++ oneTwoPairs`,
   `oneTwo_forces : Forces (edgeGraph 214 oneTwoAug) 5 iA iB` (via `forces_of_gadget`),
   `oneTwo_colorable_five` (a literal 5-colouring, so `Forces` is not vacuous),
   `six_le_chromaticNumber_two_distance : 6 ≤ (distanceGraph ℂ {1, 2}).chromaticNumber`,
   `oneTwo_plane : ∀ C : (unitDistance ℂ).Coloring (Fin 5), ∃ x y, dist x y = 2 ∧ C x = C y`,
   `six_le_chromaticNumber_plane_of_forced_distinct_two`, and the controls (`#guard`s, the moved
   vertex failing `Valid` and `PairsAt`, `oneTwoAug_colorable_six` red, unit-part-5-colourable
   red). Plus the free consumer: `seven_le_chromaticNumber_hexShell_distances` in `HexShell.lean`.
5. **`tools/twodist.py`'s surface (the row contract, so a fresh reader cannot misread it):**
   * every row: `kind`, `stage_fingerprint`, `pool_fingerprint` (or `null`), `cap`, `outcome ∈
     {sat, unsat, unknown}`, `claim_scope` prose; `unknown` never folds into anything;
   * removal rows: `verdict ∈ {removed, candidate-removal, refused, unknown}` — `removed` REQUIRES the
     three fields `unsat`, `reencode: unsat`, `halo: {one_minimal: true, witnesses: n}`; a writer
     lacking any of them raises rather than downgrading silently (M48's `check_recordable`
     pattern);
   * the dial is always named **`mu_upper`**, never `mu`, and a `stall` row carries the sentence
     *"an upper bound on μ within the probed pools; not a bound on μ"* in the row itself;
   * **`mu_upper ≤ 1` at k = 5 does not write a summary — it raises the HALT-AND-VERIFY banner**
     and exits, so the jackpot cannot be recorded as an ordinary row;
   * `--self-test` plants: a fake removal without the triple must be refused; a moved point must
     fail classification; the rhombus at k = 3 must read forced-equal; a shuffled edge list must
     keep its fingerprint.

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
* Crash from any process: HALT and report (standing rule).

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

## §R. Results (filled as phases close; every number from an artifact or a build log)

### §R0. The kernel layer (phase 0) — LANDED, first sitting

`DistanceGraph.lean`, `OneDefect.lean`, `Instances/OneDefectSpec.lean`, `Homogeneous.lean`
(generalized), `PairDist.lean` (two lemmas), `Instances/HexShell.lean` (one theorem): 22 new
declarations, all on axioms exactly `[propext, Classical.choice, Quot.sound]` (`scripts/axioms.sh`:
528 clean, the 5 pre-existing declared Moser-cube purchases). The theorems the milestone was named
for: **`not_colorable_of_forced_equal`** (the spindle, `k`-generic, homogeneity ∘ a `d`–`d`–`1`
triangle), **`add_one_le_chromaticNumber_unitDistance_of_one_defect`** (one non-unit edge already
suffices), and the spec **`four_le_chromaticNumber_plane_of_rhombus`** — the Moser bound from the
rhombus alone through the abstract lemma, both entry points, with the `d < 1/2` red control. Free
consumer: **`seven_le_chromaticNumber_hexShell_distances`**, χ(ℝ²;{1,√3,2}) ≥ 7 as a theorem about
the distance graph (the M35 docstring's prose).

### §R1. The seed (phase 1) — re-derived exactly; the certificate PRICED before emission

* Re-derivation from the paper's data alone (`tools/twodist.py --seed`, exact rational arithmetic on
  the 4-basis; every published count planted as an assertion): T 57, V 205, G 966 unit + 423
  distance-2, H 214 / 1004 + 446, |AB|² = 25, K 426 / 2009 + 892, |BB'| = 1 — **all reproduce**.
  Colouring counts up to palette (first-occurrence breaking, blocking-clause enumeration): G exactly
  18, H exactly 35, `A = B` in all 35 — the paper's claims, independently.
* Controls: K is 6-colourable (SAT 0.1 s); K's unit-edge part alone is 5-colourable (SAT 0.0 s) —
  the distance-2 edges are load-bearing; G and H are 5-colourable (0.7 s / 0.6 s with breaking).
* Port design (measured, not chosen): `A` lies on a triangle of `H` (neighbours 1 and 43 in H's
  index), so the `Forces` gadget needs **three** cubes on ports `(A, a₁, a₂, B)` —
  `B ∈ {a₁'s colour, a₂'s colour, fresh}` — each UNSAT in 21.7–23.1 s (pins only, no breaking, as
  the kernel chain requires); the survivor pattern `A = B` is SAT in 0.5 s.
* **The price, measured before any emission** (backward-trimmed, `emit_mask.read_lrat`): the three
  cubes trim to 616,839 / 570,943 / 521,847 derived clauses carrying **24.0M / 22.9M / 19.8M hints**
  (`--unsat` is WORSE: 773k/808k/606k clauses). At the standing kernel rate of 1.35 ms per hint that
  is ~25 h of kernel time and ~600 MB of Lean source for the seed alone — M06's whole de Grey
  certificate was 34M hints / 27.8 h / 396 MB. The alternative six-port design (`A`'s and `B`'s
  triangles, 26 cubes) projects to ~78M hints from a five-cube sample; the size is intrinsic to `H`
  at 214 vertices, not to the port design. **So the seed is being vertex-shrunk (ports protected,
  `mechanism.greedy_1min`, necessity census) before emission** — the M07 move: the certificate is
  priced on the core, not the paper's object.
* Parts's `d = 2` family: under the reading `θ = 2·arccos 5/6`, strict radius `< √3`, the pool
  `G19 ⊕ G19 ⊕ G7` has exactly **313 points** (his count) — but **no pair at `5/√3` is forced equal
  there** (58 sampled colourings separate all 36 such pairs; and vertex deletion can never create a
  forcing, so his 199-vertex reduction cannot come from this pool). His frame is not recoverable
  from the prose; the explicit E–I object is the seed. Reported, not worked around.

### §R2. μ from the seed (phase 2) — a sandwich, `29 ≤ μ_H ≤ 252`, and the instrument that had to change

The quantity: the fewest distance-2 edges of `H` (unit edges kept, WLOG) that keep `A = B` forced at
five colours — the forced-pair carrier's `μ_upper`. Desktop, CaDiCaL, `A ≠ B` as clauses with
first-occurrence palette breaking; every model validated in-process.

* **The registered greedy did not finish and was replaced, with the reason recorded.** `mechanism.greedy_1min`
  over the 446 edge indices at cap 60 s reached 276 survivors in pass 1, then its necessity census
  found survivors deletable at 4× cap and the code exited (fixed to loop). Relaunched at cap 240 s it
  ran **> 4 h without completing pass 1**: the batch greedy is *serial in acceptances* (an accepted
  deletion requeues the rest of its 30-wide batch), so pass 1 with hundreds of acceptances is one
  4-minute batch per acceptance — ~30 h. Replaced by **census-first** (`--seed-edges-census`,
  committed): (1) all 446 single-deletion asks in parallel; (2) a *parallel* ddmin over the deletable
  ones (every piece of a level asked against the same set concurrently, passing pieces merged with
  re-verification); (3) the necessity census on the survivors at 4× cap. The quantity is unchanged.
* **The census, and the lower bound it hands over for free.** `forces_outcome(H − e)` for each of the
  446: **29 `sat`, 417 `unsat`, 0 unknown at 240 s** — reproduced exactly on the rerun (291 s, then
  158 s). An edge whose lone deletion admits a validated separating colouring lies in **every** forcing
  subset (if `e ∉ S` then `S ⊆ E∖{e}`, which does not force), so **`μ_H ≥ 29` rigorously** — a bound
  the greedy could never have produced. (The exact-minimum engine `tools/hitset.py` was also run on
  this question: rigorous, but its bound climbed to 6 in 6,600 s — 446 columns is beyond it; retired.)
* **The shrink.** Parallel ddmin from 446 with the 417 deletable as candidates: levels 208 → 104 (0
  passed) → 52 (7 of 8 pieces passed; −104) → 26 (−26) → 13 (−39) → 6 (−24) → 3 → 1 (0 passed) —
  **252 survivors, 492 asks, 5,123 s**. Independently the abandoned serial run had reached 252 at its
  chunk-6 level (same shuffle seed).
* **The necessity census at 960 s** on the 252: **92 necessary** (deletion admits a witness), **46
  unknown**, **114 still deletable** — the level-1 "0 passed" was mostly timeouts at 240 s, so
  **252 is a cap-limited upper bound, not a 1-minimal set**. `build/m49-seed-edges.json` (kinds
  `single-deletion-census`, `edge-critical`, `necessity.complete: false`).
* **P2 (μ_upper ≤ 149 of 446): UNDECIDED at cap.** The certified sandwich is `29 ≤ μ_H ≤ 252`; the
  upper end is solver-limited (114 of its members are individually deletable at 960 s) and a
  higher-cap tightening is priced at ~2–4 h of the whole desktop per level. Not claimed either way.
* **P3 (≥ half of the essential edges within distance 3 of `A, B`): met, VACUOUSLY** — 444 of all
  446 distance-2 edges are within 3 of the pair (`|AB| = 5`, the graph is compact), so the registered
  statistic cannot discriminate. The sharper *post-hoc* reading, offered as such and not as a
  registered result: **6 of the 7 distance-2 edges incident to `A` or `B` are essential alone, versus
  23 of the other 439 (5 %)** — the lower-bound set concentrates at the ports.

### §R3. The calibration at k = 4 (phase 3) — the algorithm validated where the endpoint is known, and P4b refuted the good way

Object: the M33/M34 122-point distance-2 pigeonhole core (421 unit edges, 40 distance-2 pairs, not
4-colourable), read as a {1,2}-graph; invariant "not 4-colourable"; pools = one generation of the seam
group (`ζ₆, σ`) about the target edge's endpoints, then one generation of `ρ₁₅, √ρ₁₅, √ρ₆₃`; cap 60 s
(4× for the certifications); 8 workers, sequential scan (`descend_run`). Desktop, ~40 h wall.

* **P4a (edge-critical count ≥ 30 of 40): MET** — two greedy orders both give **37 of 40** essential,
  necessity complete.
* **P4b ("the seam halo removes NONE"): REFUTED at step 1 and then 33 more times.** The seam pool
  (790–4,368 new points per ask) removed **34 of the 37** distance-2 edges, in the scan's own order,
  every removal certified (UNSAT, 2-bit re-encode UNSAT, halo 1-minimal with a witness per survivor —
  527 witnesses over 527 halo vertices, zero undecided). Halo sizes, in order: 5, 0, 3, 1, 0, 49, 0,
  21, 16, 9, 8, 10, 5, 8, 0, 4, 13, 6, 2, 56, 2, 0, 1, 45, 37, 18, 17, 21, 6, 34, 64, 29, 18, 19
  (mean 15.5, median 8.5); object 122 → **649** vertices, 3,232 unit edges. **The stall: μ_upper = 3.**
  The three survivors — `(15,57)` and the symmetric pair `(112,118)`, `(113,119)` — refuse the seam
  pool AND the up pool (7,776 points) on every rescan; `(15,57)` refuses even a two-generation seam
  pool of 27,690 points. The final object's unit part alone is 4-colourable (0.1 s): **no seam-field
  unit-distance 5-forcer** — the field wall (G1) holds at this depth, three edges wide.
* My P4b reasoning was wrong and is worth recording: G1 speaks of *pure* unit material forcing five;
  a halo does a distance-2 edge's job **in context**, with the other distance-2 edges still carrying
  the load, and that is a much weaker demand — 34 of 37 times a one-generation seam halo meets it.
* **P4c ("the one-field-up halo removes at least one"): under the registered order (up only after
  seam refuses) the up pool was asked only on the three survivors and refused all three (one
  generation, 7,776 points). MET one level deeper**: the seam-then-up TWO-generation pool
  (~64,000 points) turns all three UNSAT (284 / 126 / 246 s, one encoding). Their certified commits
  and the final unit-part test are §R3′ below.
* Replay: every one of the 34 (later 37) steps was re-derived from its row — the pools are
  deterministic and every stage and pool fingerprint matched — and the object is saved
  (`build/m49-calib122-object.json`).

### §R3′. The calibration completed at depth two — PENDING at the time of writing

(filled when `scratchpad/finish_k4.py` finishes: the three deep-pool commits through the certified
step, then the unit part alone at k = 4. If it refuses: a unit-distance graph with χ ≥ 5 built by
descent from the pigeonhole — HALT AND VERIFY before interpreting.)

### §R4. The k = 5 descent on the seed (phase 4) — twelve of the twenty-nine edges every forcing subset needs, replaced by seventeen seam-field points

* **The registered full-pool run stalled undecided**: 252 targets (the phase-2 survivors), forced-pair
  framing, cap 180 s: seam pool (1,083–1,567 new points) **243 unknown / 9 refused / 0 removed**; up
  pool (2,556) **219 unknown / 33 refused / 0 removed**. Recorded as a stall at μ_upper = 252, meaning
  only "undecided at this cap". Replaced the same morning by **phase 4′** (`--descend5-lb`,
  committed): targets = the **29 lower-bound edges** (each provably in every forcing subset), object
  = the FULL seed (all 446), pools laddered by radius about the target's midpoint (1.5, 3, whole) for
  seam then up, cap 900 s; parallel scan per rung, sequential certified commits (`descend_step`:
  re-ask, 3-bit re-encode at 3,600 s, halo shrunk 1-minimal — by parallel ddmin after the batch
  greedy spent 13 h on one 700-point halo — with a necessity witness per survivor at 3,600 s).
* **The rung table (every ask decided — zero unknown anywhere):**

  | pool | radius | new points | asked | UNSAT (candidates) | refused |
  |---|---|---|---|---|---|
  | seam | 1.5 | 153–424 | 29 | **8** | 21 |
  | seam | 3.0 | 592–1,223 | 21, then 20 (rescan after resume) | 3, then 3 (**4 new removals**) | 17 |
  | seam | whole | 1,386–1,677 | 17 | 0 | 17 |
  | up | 1.5 | 235–1,271 | 17 | 0 | 17 |
  | up | 3.0 | 1,161–2,709 | 17 | 0 | 17 |
  | up | whole | 2,760 | 17 | 0 | 17 |

* **Twelve certified removals, 17 points in all**: `(76,78)`·1, `(78,168)`·1, `(111,112)`·1,
  `(112,134)`·2, `(134,149)`·0, `(143,210)`·0, `(168,204)`·1, `(185,211)`·1 at radius 1.5;
  `(11,207)`·1, `(22,112)`·9, `(22,134)`·0, `(33,85)`·0 at radius 3 (halo sizes; the zeros are edges
  whose job the points added for EARLIER edges already do — shared kills). Every one: UNSAT in
  4.8–9.6 s, 3-bit re-encode UNSAT, halo 1-minimal, every survivor witnessed, 0 undecided
  (`build/m49-descent5.json`, label `seed-k5-lb`; the resumed run replayed the first nine exactly).
  Object 214 → **231** vertices, 1,004 → 1,122 unit edges, distance-2 edges 446 → **434**.
* **The mechanism, measured on the first removal**: the kill point `p` for `(76,78)` sits at unit
  distance from endpoint 78 (2.18 from 76 — NOT the tangency midpoint) and has **9 unit neighbours**
  in the seed; forbidding any one colour on those nine (palette-WLOG) in `H − (76,78)` with `A ≠ B` is
  **UNSAT** while the control without the restriction is SAT — so in every separating colouring the
  neighbourhood is forced rainbow and `p` cannot be coloured: the kernel's A1
  (`not_colorable_iff_covers`) at a point outside the object. `(76,78)` and `(111,112)` are a symmetry
  pair with identical kill geometry (1.3696 from the midpoint, 2.1799 / 1.0000 from the endpoints).
* **P5 (seam halo removes ≥ 1 essential edge at k = 5): MET, twelve times, on the strongest targets.**
  **P6 (up pool removes further): MISSED, decisively** — 0 of 17 at every radius, all decided.
  **P7 (k = 5 removal costs ≥ 3× the k = 4 halo): REFUTED in its literal reading** — the twelve k = 5
  removals cost 0–9 points (median 1) against the k = 4 median 8.5 — with the selection caveat that
  these are the twelve *cheap* ones and the other seventeen cost more than any pool offered.
  **The jackpot clause never fired** (μ_upper 434 in the forced framing).
* **What the flat half means, in the plan's own words**: for the seventeen refusing lower-bound edges,
  no one-generation unit halo from either field about their endpoints transmits the forcing at this
  cap — a stall value, not a bound on μ. G26/G31 gain: *twelve of a {1,2} six-forcer's
  provably-essential distance-2 edges DO descend into seam-field unit material at five colours, at a
  cost of one point each; the rest do not descend at depth one in either field.*

### §R5. μ(φ) exactly (phase 5) — Parts's {1,φ} six-forcer is edge-critical to the last edge

* **Reconstruction, exact.** Parts's paper (arXiv:2010.12656 v2, fetched 2026-08-16) gives `G16`'s two
  edge lists explicitly and names it a subgraph of `G126 = G5^{⊕5}` (the five-fold Minkowski sum of a
  unit-side regular pentagon; diagonal `φ`). Rebuilt in ℚ(√5) (`scratchpad/parts31.py`): `G126` has
  **350 + 350** edges (his count, planted); the backtracking search finds `G16` as an **induced**
  {1,φ}-subgraph — its induced lists reproduce his 28 + 28 exactly (control). `G31` = two copies of
  `G16` about vertex 1 rotated by `arccos((95+√5)/100)`: the designed `|16−16′| = 1` is the exact identity
  `2·(5R)²·(5−√5)/100 = 1` with `R² = (5+√5)/10`; the other 224 cross-copy pairs miss both distances by
  ≥ 0.0132 (60-digit numeric census; the rotation leaves ℚ(√5), so this classification is numeric with
  its margin stated). Totals **31 vertices, 57 unit + 56 φ-edges**; controls: not 5-colourable
  (UNSAT), unit-only 5-colourable, 6-colourable.
* **The exact value: μ(φ) over subgraphs of `G31` = 56 = ALL of them.** Every single φ-edge deletion
  leaves a 5-colourable graph (56 SAT calls, models validated in-process), so by monotonicity no
  proper φ-subset refutes — no hitting-set loop needed (the implicit-hitting-set engine built for it,
  `scratchpad/hitset.py`, had reached LB = 10 after 1,550 iterations when the single-deletion census
  settled it in 4 s: **the exact question was answerable by the cheapest instrument, and I ran the
  expensive one first**). Every unit edge is essential too (57/57), and the forced-pair carrier
  `G16` (1 = 16 forced at five colours) is likewise edge-critical: 28/28 φ and 28/28 unit deletions
  each un-force the pair. Twenty greedy orders all return 56 (`build/m49-parts31.json`).
* **P8 (≥ 20 of 56): MET** — at the extreme value. Reading: a hand-minimized forcer keeps every
  edge; *the μ dial cannot be read off a critical object's own subgraphs* (they only bound μ above),
  which is exactly why the descent (phase 4) ADDS material rather than deleting it.

### §R6. The registered predictions, scored

| # | registered | outcome |
|---|---|---|
| P1 | seed certificate lands, every cube < 10⁶ LRAT lines | **MISSED** — priced at 24.0/22.9/19.8 M hints per cube (~50 M total, M06 × 1.6, ~40 kernel-hours, ~600 MB source); every lever measured (vertex shrink 3× worse, K no better, six ports ~78 M, configs −26 %, proof-guided a fixed point); deferred with numbers, tools-side double-encoded |
| P2 | μ_upper ≤ 149 of 446 for H's forced pair | **UNDECIDED** — sandwich `29 ≤ μ_H ≤ 252`; the upper end is cap-limited (114 of 252 individually deletable at 960 s) |
| P3 | ≥ half the essential edges within 3 of A, B | **MET VACUOUSLY** (444/446 of all edges are); post hoc: 6/7 port-incident edges essential alone vs 23/439 |
| P4a | 122-core essential count ≥ 30 of 40 | **MET** — 37/40, two orders agree |
| P4b | seam halo removes NONE at k = 4 | **REFUTED** — 34 of 37 removed, all certified; the unit part alone stays 4-colourable (G1 not contradicted — the prediction misapplied it, G30 addendum) |
| P4c | up halo removes ≥ 1 at k = 4 | **MET AT DEPTH TWO** — one generation refused all three survivors; the seam-then-up two-generation pool turns all three UNSAT (§R3′ for the certified commits) |
| P5 | seam halo removes ≥ 1 essential edge at k = 5 | **MET** — twelve of the twenty-nine lower-bound edges, seventeen points, every rung decided |
| P6 | up pool removes a further one at k = 5 | **MISSED** — 0 of 17 at radii 1.5, 3, whole; all decided (jackpot never fired) |
| P7 | k = 5 removal costs ≥ 3× the k = 4 halo | **REFUTED literally** — k = 5 median 1 point vs k = 4 median 8.5; selection caveat: these are the twelve cheap ones |
| P8 | μ(φ) on Parts's G31 ≥ 20 of 56 | **MET at the extreme** — 56 of 56 (edge-critical to the last edge) |

### §R7. The next turn (stub for the successor milestone — the ranking's item 1)

The instrument exists and is checkpointed; the registered next turn, in order of expected yield per
CPU-hour: (i) the seventeen refusing lower-bound edges against two-generation pools (seam-then-up
about the endpoints, ~60,000 points; the k = 4 calibration needed exactly depth two where depth one
stalled) — cap 1,800 s, parallel scan, certified commits with the ddmin shrink; (ii) the descent on
ALL essential edges of the seed (the 92 necessary at 960 s — recompute and STORE per-edge necessity,
the phase-2 row kept only counts), so μ for the whole object moves — that curve is the χ ≥ 6 dial;
(iii) DESIGNED halos: for a refuser `e`, search the seam and up orbits about its endpoints for a
single point whose unit neighbourhood in the seed is forced rainbow in every separating colouring of
`H − e` (one coverage ask per candidate point; the twelve kills found so far are exactly such points),
and compare the hit rate against enumerated pools; (iv) the same descent on Parts's {1,φ} G31 (its
φ-edges are ALL essential — a clean 56-target ladder) and on De Neve's {1,3} object if its data
surfaces; (v) the second encoding applied to the SHRUNK object rather than the full-halo object
(today's `descend_step` re-encodes before shrinking, which certifies the candidate, not the committed
core — the core is certified one-hot plus witnesses; make it two encodings); (vi) **the kill engine
against the CURRENT object** (§R8–§R9): enumerate the separating colourings of the reduced object
minus the target — kills are context-dependent, five certified gadgets did not compose — then the
whole-set tests by depth, the lookup ddmin, exact certification; build the local depth-two unions
with `cKDTree` (the coarse grid hung on 600,000 points); (vii) the five untouched refusers
(`(126,203)`, `(206,210)`, `(206,211)`, `(4,205)`, `(71,107)`) are the sharpest question: what
structure of their 4–16 surviving colourings makes every depth-two point list-colourable. Jackpot
clause verbatim.

### §R8. The enumeration screen (2026-08-17 night, on Kooshi's "keep hunting depth and efficiency") — the kill space is finite and the solver leaves the loop

* **The candidate space is enumerable, in any field.** A single added point kills a separating
  colouring only if it cannot be coloured, so it needs ≥ 5 unit neighbours in the seed; a point at unit
  distance from two seed vertices `u, v` is one of the two intersection points of the unit circles about
  them (M22's gluing classification: `{a point, its mirror}`, coordinates in the seed's field extended by
  `√(4 − |uv|²)`). Census (`scratchpad/kill_census*.py`, float geometry at 1e-7 for the candidate list —
  a pool is a choice, not a claim): **9,485 depth-one partner points**, 214 of them the seed itself,
  **51 non-seed points with ≥ 5 seed neighbours** (25 with five, 22 with eight); **59 distinct radicands
  `4 − d²`** over the seed's realized distances `d < 2` — the complete list of "odd ratios" available at
  depth one, several outside the seam field.
* **The separating colourings are FEW.** For each of the 17 refusing lower-bound edges `e`, the proper
  5-colourings of `H − e` with `A ≠ B` (all of which have `e`'s endpoints monochromatic), enumerated
  exactly up to palette by blocking clauses: **2, 2, 2, 2, 2, 3, 3, 4, 4, 4, 4, 8, 10, 10, 10, 16, 19**
  (7–45 s each; `build/m49-sep-*.json`). Controls: the removed edges `(76,78)` and `(22,112)` have 2 and
  8. So a halo kills `e` iff its list-colouring problem (lists = colours unused on each member's seed
  neighbourhood, halo unit edges as ≠) is infeasible under every listed colouring — **bit masks, no
  solver**. The solver census on the 51 × 17 single-point questions (867 asks, cap 900 s, **0 kills, 0
  unknown**) agrees with the lookup exactly (green cross-check).
* **Screened so far, all 17 refusers, zero kills:** every single depth-one point (any field); every
  unit-adjacent pair among all 9,271 non-seed depth-one points (28,734 pairs); every connected triple
  (189,402); every connected subset of size ≤ 7 among the 284 "strong" points (≥ 3 seed neighbours;
  548 unit edges among them; 707,239 subsets). Depth-two points (intersections about seed ∪ strong
  points; 42,868) have ≤ 1 seed neighbour each, so they act only as connectors needing ≥ 4 halo
  neighbours. **Control green:** the same screen finds 958 halo kills of size ≤ 5 for the removed edge
  `(76,78)` (whose certified kill is one point) and none ≤ 5 for `(22,112)` (whose certified kill is
  nine strong points with 13 halo edges among them — a genuine gadget, and the template the size-9
  search below is aimed at).
* **Running:** connected subsets of size ≤ 9 among the strong points (~11 M), the two controls in the
  edge list. Anything found is a candidate only until certified by the standard route.

* **Depth one is exhausted for the seventeen — in every field.** The whole depth-one partner set
  (all 9,271 points, all their mutual unit edges) as one halo: for each refuser, some separating
  colouring extends to the ENTIRE set (list-colouring SAT, ~1–8 s each), so no depth-one subset of any
  size kills it (feasibility is monotone in the point set). Both controls read KILL. Per refuser the
  colourings surviving depth one: 2, 4, 1, 1, 1, 6, 6, 2, 4, 2, 16, 4, 1, 1, 4, 1, 2 (of 3, 4, 16, 4,
  2, 10, 10, 2, 4, 2, 19, 10, 2, 2, 4, 8, 3). Per-colouring depth-two single points (a point with one
  seed neighbour squeezed by ≥ 4 forced depth-one neighbours): none, for any surviving colouring
  (~25,000 candidates each).
* **Depth two, restricted (intersections about seed ∪ the 284 strong depth-one points; 42,868 new
  points; union set 52,139 points / 263,272 unit pairs), the whole set as one halo, per surviving
  colouring:** **seven refusers are KILLED** — `(133,150)`, `(205,207)`, `(205,208)`, `(40,206)`,
  `(56,168)`, `(56,78)`, `(77,94)`; five are one or two colourings short — `(118,212)` 1 of 2,
  `(21,210)` 1 of 2, `(38,211)` 1 of 2, `(98,213)` 1 of 2, `(210,211)` 2 of 4; five fully survive —
  `(126,203)`, `(206,210)`, `(206,211)`, `(4,205)`, `(71,107)`. Shrinking the seven with the lookup
  oracle (ddmin, ~5 min each): `(133,150)` → a **122-point 1-minimal gadget** (every point
  necessary; depth-one points with 2–3 seed neighbours and depth-two points with one, halo degrees
  4–10) — the recursion's cost made concrete: one point at depth one, a hundred-odd at depth two.
  Certification of the designed halos (exact sympy coordinates from the defining circle pairs, every
  unit edge exact, two solver encodings) is `scratchpad/certify_halo.py`, running next.

### §R9. Designed kills — seven refusers fall to depth-two gadgets (2026-08-18 morning)

* **The seven restricted-depth-two kills, shrunk 1-minimal by the lookup oracle** (ddmin over the
  52,139-point union with per-colouring list-colouring SATs; every survivor re-checked necessary):
  `(133,150)` **122** points (102 depth-one + 20 depth-two), `(205,207)` **267** (211 + 56),
  `(205,208)` **254** (213 + 41), `(40,206)` **147**, `(56,168)` **87**, `(56,78)` **225**,
  `(77,94)` **101** — gadgets of a hundred-odd points each, mostly depth-one points with 2–3 seed
  neighbours plus depth-two points with one, unit-connected among themselves at degrees 4–10
  (`build/m49-kill-halos*.json`). The step from one point (depth one) to ~100–270 (depth two) is
  the recursion's cost, measured (G25).
* **Certification** (`tools/m49/certify_halo.py`): every halo point defined exactly as an
  intersection of unit circles about two exact points (seed–seed for depth one; seed + an exactly
  defined depth-one point for depth two; sympy nested radicals), every claimed unit edge checked
  exactly (sympy simplify to 0 within a 10-s budget; otherwise 200-digit numeric agreement,
  LABELLED as such in the row — the first two gadgets: 637 exact + 46 numeric of 683 edges, and
  1,372 + 155 of 1,527), then the one-hot ask with `A ≠ B` on `H − e + halo` and the 3-bit
  re-encode: **`(133,150)` UNSAT/UNSAT (removed, 122 points), `(205,207)` UNSAT/UNSAT (removed, 267)**;
  and then **all seven certified** — `(205,208)` 254 (1,285 exact + 118 numeric-200 edges), `(40,206)`
  147 (722 + 142), `(56,168)` 87 (425 + 50), `(56,78)` 225 (1,110 + 123), `(77,94)` 101 (518 + 53) —
  each UNSAT in both encodings **on `H − e`** (rows in `build/m49-descent5.json`, label
  `seed-k5-design`).
* **Kills are context-dependent, and the composition says so.** All nineteen removals at once (the
  12-removal object + the seven gadgets, 1,434 points, 23,255 unit edges, 427 distance-2 edges) is
  **SAT** — `A ≠ B` becomes possible — because each gadget was designed against the separating
  colourings of `H − e` with the OTHER 445 distance-2 edges present, and the multiply-reduced object
  has more of them. Committed SEQUENTIALLY on the 12-removal object (each ask on the current object,
  3-bit re-encode): `(56,168)` (87 points) and `(56,78)` (225) **commit**; `(77,94)`, `(133,150)`,
  `(40,206)`, `(205,208)`, `(205,207)` do not kill in the reduced context (SAT in 0–5 s). **The
  descent object at the close: 543 points, 3,441 unit edges, 14 of the 29 lower-bound edges removed
  (446 → 432 distance-2 edges)** — 12 at depth one for 17 points, 2 at depth two for 312 —
  `build/m49-compose-seq.json`; the other five gadgets are certified standalone kills on the seed and
  are re-designable against the current object's own separating-colouring list (the engine's next
  turn: enumerate on the CURRENT object, not on `H`).
* **What was NOT reached at this depth:** five refusers are one or two colourings short of a kill
  on the restricted depth-two union (`(118,212)`, `(21,210)`, `(38,211)`, `(98,213)`, `(210,211)`)
  and five are untouched by it (`(126,203)`, `(206,210)`, `(206,211)`, `(4,205)`, `(71,107)`). The
  local, unrestricted depth-two union (all depth-one centres within 1.5 of the edge) was attempted and
  its construction was too slow with the coarse grid (hundreds of thousands of points; the unit-pair
  census is the bottleneck, `cKDTree` is the fix) — not run to a verdict, reported as such.
* **The k = 4 side of the same idea did not transfer:** the stalled 649-point calibration object minus
  a refuser has more than 20,000 four-colourings up to palette (enumeration capped after 7.7 h), so
  the lookup engine has no small list to work with there; the three depth-two UNSAT probes stand as
  single-encoding probes, and the certified commit (a 28,000-point shrink at k = 4) was stopped after
  9.5 h without finishing. The seed at five colours is rigid (35 colourings; 2–19 per refuser); the
  four-colour pigeonhole object is not. Rigidity is what makes the engine cheap.

### §R10. Two questions asked at the close (Kooshi, 2026-08-18) — order, and batch design

* **Order dependence, measured.** The seven certified gadgets committed sequentially onto the
  12-removal object in three orders (one-hot asks; `scratchpad/order_test.py`): by `|S_e|` ascending
  **3 of 7** compose (`(56,168)`, `(56,78)`, and `(133,150)` — the last only after the others had
  changed the context); by `|S_e|` descending **2**; by halo size descending **3**; by halo size
  ascending (§R9) **2**. Small lists first is weakly better; context can HELP as well as hurt. An
  object with **15 of 29** lower-bound edges removed exists (one-hot; 3-bit pass and row: next turn).
* **Batch lists are enumerable.** `|S_B|` for the seed minus a whole batch `B` (no halos), exact up to
  palette by blocking clauses: **684** for the twelve depth-one-removed edges, **1,010** for the
  fourteen, ≥ 3,469 for the nineteen and ≥ 5,366 for all twenty-nine at a 30-min cap (still climbing
  at 2–3/s) — thousands, plausibly tens of thousands, not millions. So the whole lower-bound set is
  ONE design problem: a halo list-uncolourable under every colouring of `S_29` kills all twenty-nine at
  once, composition by construction, no ordering — the next turn's cleanest formulation.
* **Completeness caveat recorded.** The depth-`d` partner lattice is exactly the unit-compass-
  constructible points over the seed (a 2-tower of quadratic extensions of height ≤ `d`); depth-one
  completeness for single-point kills is a corollary of `Glue.sphere_inter_sphere` (to be written);
  a MINIMAL kill has every point with ≥ 2 neighbours, but rigid non-2-generated halos (K₃,₃-type)
  lie outside the lattice at every depth — so "no kill at any depth" claims are about constructible
  halos only. Measured: the seed's own unit graph is 2-generated from 4,011 of its 22,791 point pairs
  (never from an adjacent pair), so anchored rigid copies of the seed are in the lattice; the paper's
  single-anchor spindle copy is not.

## §S. STATE AT THE CLOSE (2026-08-18 evening; the earlier continuation note is superseded by §R0–§R9)

Milestone CLOSED. Gate: `scripts/build.sh` OK (170 modules), `scripts/axioms.sh` OK (533 clean, the
5 pre-existing Moser-cube purchases), `lake lint` passed, `tools/twodist.py --self-test` PASS.
Frontier updated (narrative, ledger row 44, G32, G26/G30 addenda, ranking). Nothing is running.
Artifacts: `build/m49-*.json` (seed-edges, calib122 + object, descent5 with labels `seed-k5-lb` /
`seed-k5-design`, kill-census, kill-screen, kill-design, kill-halos*, compose19, compose-seq, sep-*,
parts31, H-colourings, H-forced-equal), the explorer `scratchpad/two_distance_dial.html` published as
an Artifact (https://claude.ai/code/artifact/97ebb92e-066d-42ea-93aa-662a4cc3cff8), the campaign
scripts in `tools/m49/`, the engine in `tools/killengine.py`.

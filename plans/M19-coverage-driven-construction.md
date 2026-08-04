# M19 — The two-circle theorem, the coverage ratchet, and the colourings as objects

*Subplanned 2026-08-03/04 from the stub of the same name (the stub's carry-forward notes are
superseded by this document; its §0 obligations were all executed and are reported below).
Direction agreed with Kooshi 2026-08-03: the lower-bound hunt stays the spine; the χ = 5
perspective rides in §0 for nearly free.*

**The milestone in one line: the flat histogram was a theorem waiting to be stated — every
unit-distance graph on the two circles of a 120°-class pivot is 3-colourable — and the honest
death of mechanism (b) is what uncovered it.**

## 0. Measurements (all on the desktop, 32 cores; instruments named per number)

### 0(a) The pools as objects — and what they turned out to measure

Instrument: `coverage.py --pool-out` (new) + `colorstat.py` (new, self-tested, wired into
regen-check). Pools: de Grey 1,292 colourings (`build/m19-pool-degrey.json`), Z3 closure
3,054 colourings (`build/m19-pool-z3closure.json`); every colouring re-verified proper by
the reader against an independently rebuilt graph (identity: n, edge count, edge-list hash).

* **Diversity**: all 1,292 de Grey pool colourings distinct up to colour permutation; 1,261
  distinct size profiles. The pool is not one pattern resampled.
* **Triangle treatment**: every colouring uses **all 10** colour-triples on unit triangles —
  no specialization anywhere (label-free statistic).
* **Translation structure**: **no periodicity.** 968,897 distinct difference vectors over
  1.25M pairs (the point set barely repeats a vector); top-multiplicity vectors (~114 pairs)
  show lifts of only +0.04..+0.10 over base rate 0.203, all at short 1/3- and 1/9-vectors.
* **Densities**: max-class density over the pool: floor 0.2113, median 0.2264 — **but see
  0(c): this floor is solver bias, not structure.**

**The methodological finding, which retroactively tempers M17/M18 language: pool statistics
measure the solver's preferred colourings, not the colouring space.** Only SAT/UNSAT
verdicts and matched-control contrasts survive the bias. Recorded in `colorstat.py`'s
docstring; the sweeps' pool-rejection economics are unaffected (the pool is still a valid
source of upper-bound witnesses — every witness is re-verified).

### 0(b) Mechanism (b) — dissolved, with pre-registered controls

The M18 finding ("ambient near-forcing at structureless √33 classes") was hunted to ground
through three pre-registered hypothesis rounds (`predictions.md`, scratchpad, written before
each dataset):

1. **Local transmission — refuted.** The top zero-in-class-edge resisters have ≤ 2 common
   unit-neighbours per pair (the crosswise chord bound, a consistency check) and *low*
   3-path counts; `5/3−2/9·√33` resists 15× with zero 2-paths while `5/3` (more 3-paths)
   resists 6×. Neither width nor radius nor path counts order the resistance. Sweep order
   is exonerated in the strong direction: irrational classes test *last*, against a
   maximally enriched pool.
2. **Periodicity leakage — refuted** (0(a): no translation structure to leak).
3. **The spindle-rotation ghost — refuted with controls.** On the closure (ℤ/3-closed, so
   every vertex's 120°-image exists): margin(x, rot3 x) median 0.251 vs **exact-distance-
   matched non-image controls median 0.235** — indistinguishable; and margins *rise* toward
   the graph rim (0.285 → 0.443) instead of decaying from the pivot — the signature of
   solver phase bias on weakly-constrained vertices, not of structural forcing.

**Retraction: "near-forcing" was sampling bias.** What remains of mechanism (b): nothing —
the √33 family's real meaning surfaced elsewhere (0(e)): √33/6 is the *sine of the
cross-chord rotation between a pivot's two circles*. The seam was geometry, not colour.

### 0(c) Balance — the χ = 5 lens's first exact answer

Instrument: Sinz sequential-counter cardinality encoding over `base_clauses` (scratchpad
`balance.py`, to be promoted into `tools/` §2). Question: does a proper 5-colouring exist
with every colour class ≤ s?

* **De Grey, s = 317 (exact pigeonhole): SAT in 132 s** (2.51M vars, 5.06M clauses).
  Witness class sizes **[317, 316, 316, 316, 316]**, re-verified proper on all 7,877 edges.
  **De Grey's graph admits a perfectly balanced 5-colouring** — the pool's 0.2113 density
  floor was pure CDCL bias, and no density obstruction exists at witness scale.
* **Closure, s = 936 (pigeonhole for n = 4,678): running at subplan commit** (21.9M vars,
  43.9M clauses, encode 25 s; verdict folds in before the implementation commit). The
  closure pool's own density floor is already 0.2041 vs pigeonhole 0.2001 — the pools get
  *more* balanced with growth, so SAT is expected.

### 0(d) Design experiments — minCov(630, 1/3) per gadget, fresh pool each

Instrument: scratchpad `experiments.py` over `construct.py` + `min_coverage`. Control
reproduced first; the closure regenerates deterministically (same 3,054-pool histogram).

| experiment | construction | n / edges | |N(p)| | |C| | minCov |
|---|---|---|---|---|---|
| E0 control | Z3 closure as-is | 4,678 / 24,405 | 12 | 9 | **3** (2 calls + seed, 1.8 s) |
| E1 | 2nd ℤ/3 closure at q_n = 726 (widest-class unit neighbour) | 13,432 / 72,525 | 14 | 9 | **3** (3 calls, 37 s) |
| E1′ | 2nd ℤ/3 closure at q_c = 648 (member of C(630)) | 12,937 / 80,379 | 18 | 10 | **3** (3 calls, 348 s) |
| E2 | spindle-double at 630, r² = 1 | in flight | | | predicted 3 |
| E3 | spindle-double at 630, r² = 3 | in flight | | | predicted 3 |

E0–E1′ verdict: tripling the graph at the strongest available attachment points moves
nothing — exactly what the two-circle theorem (0(e)) *predicts*, since every one of these
gadgets acts inside or through the cover set's two circles. E2/E3 verdicts fold in before
the implementation commit; the theorem predicts 3 for both.

### 0(e) The discovery: the two-circle theorem (draft proved, verified numerically)

The flat histogram (minCov ≤ 3 at all 4,615 + 1,558 pivots, M18/§0) says: at every pivot
ever built, the induced unit-distance graph on S = N(p) ∪ C is 3-colourable. That is not an
accident of our constructions — **it is forced by the geometry of the two circles**:

* S lives on circle A (radius 1) and circle B (radius 1/√3) about p.
* Unit chords on A subtend exactly 60°; on B exactly 120° (the ℤ/3 triangles); cross
  chords A↔B subtend α with **cos α = √3/6, sin α = √33/6** — both in the field, and the
  √33 family's true geometric identity.
* **Infinite-order lemma**: 2cos α = √3/3 is not an algebraic integer ((√3/3)² = 1/3, and a
  rational algebraic integer is an integer), so the seam rotation is no root of unity. Hence
  every point of a Γ-orbit (Γ = ⟨ζ₆, seam⟩, an abelian group) has a **unique** label
  (i, j) ∈ ℤ₆ × ℤ, and the only unit edges are the four label steps:
  A(i,j)–A(i±1,j), B(i,j)–B(i±2,j), A(i,j)–B(i,j±1).
* **The strip 3-colouring**: colour A-points by e(i) = [1,2,0,2,1,0], B-points by
  o(i) = [0,0,1,1,2,2] — j-independent, proper on all four step types (checked by machine
  on the strip and on a numeric 324-point / 612-edge two-circle instance: zero clashes).

**Theorem (M19's centerpiece): every unit-distance graph whose vertices lie on the two
circles of radius 1 and 1/√3 about a common point is 3-colourable.**

Consequences, stated with their honest boundaries:
* **The local barrier**: no S-internal gadget can force a 4th colour onto a 120°-pivot's
  cover set, ever — the rainbow floor is the local ceiling. E0–E3's flat results and the
  4,615-pivot histogram are retro-dicted.
* **The boundary of the barrier**: minCov = 4 is *not* excluded — external structure can
  restrict which 3-colourings of G[S] extend. The barrier kills a gadget family, not the
  hunt: coverage-4 construction must force from outside S. That is M20's question (the
  multi-circle / extension problem), now sharply posed.

### 0(f) Costs

Pool runs: closure ~75 min, de Grey ~15 min (single-core SAT streams). Balance: de Grey
132 s solve; closure <SLOT>. Ghost probe: ~30 s on the landed pool. Experiment battery:
~30–40 min per gadget (edge enumeration at doubled denominators dominates; SAT trivial).
Transmission probe: 27 s pair scan. All on the desktop, ≤ 10 GB RSS total at peak
(closure-balance cadical). No Lean cost in §0.

## 1. The milestone thesis

M18 made distance-to-confinement a number and found it pinned to the floor everywhere. M19
explains the pin (the two-circle theorem), makes the hunt's gradient a theorem (coverage
monotone under construction), certifies the χ=5-lens negative (balance witness), and puts
the instrument's epistemology right (pool = solver sample). The construction problem
survives, sharpened: the 4th colour must come from outside the two circles.

## 2. Deliverables

1. **`Proofs/HadwigerNelson/TwoCircle.lean`** — the theorem. Shape (skeleton commits with
   this plan):
   * `zeta6`, `seam : ℂ` (explicit re/im); norm-1, `zeta6 ^ 6 = 1`, `seam` re/im lemmas.
   * `seam_pow_ne_one : ∀ n : ℕ, n ≠ 0 → seam ^ n ≠ 1` via the algebraic-integer argument
     (`IsIntegral ℤ`, rational integral ⟹ integer, (√3/3)² = 1/3 ∉ ℤ).
   * Ratio classification on unit circles: ‖w‖ = ‖w'‖ = 1, ‖w − w'‖ = 1 → w'/w = ζ₆^{±1};
     ‖w − w'‖ = √3 → w'/w = ζ₆^{±2}; cross at re = √3/6 → seam^{±1} (M18 engine style).
   * The label decomposition (Γ abelian, `Subgroup.closure {ζ₆, seam}`; normal form a^i b^j;
     uniqueness from `seam_pow_ne_one`).
   * `colorable_three_of_mem_two_circles {n} (f : Fin n → ℂ) (p : ℂ)
     (hf : ∀ v, dist (f v) p = 1 ∨ dist (f v) p = Real.sqrt 3 / 3) :
     (unitGraph f).Colorable 3` — the headline, hypothesis-light, over the *full* unit
     graph on the points (not class-only).
2. **`Proofs/HadwigerNelson/CoverageMono.lean`** — the ratchet:
   * `CoverAtLeast G k p Q m` (every proper k-colouring shows ≥ m colours on N(p) ∪ Q);
   * monotone in edges (`G ≤ G'`), in `Q` (⊆), antitone in `m`;
   * `fan_iff_coverAtLeast (hp : p ∉ Q) : Fan G k p Q ↔ CoverAtLeast G k p Q k`;
   * rainbow-floor lift from M18's `three_le_card_of_triangle_mem`.
   * The point, stated in the module doc: lower bounds ratchet under construction; upper
     bounds must be re-witnessed — the asymmetry the instrument already embodies.
3. **`Proofs/HadwigerNelson/DeGreyBalanced.lean`** — the balanced witness as kernel fact:
   the 1,581-entry colouring literal, `decide +kernel` for properness on the committed edge
   list and for the five class sizes `[317, 316, 316, 316, 316]`. The χ=5-lens receipt: *no
   density obstruction at witness scale*.
4. **Instruments promoted**: `tools/balance.py` (cardinality probe, self-tested);
   `colorstat.py` + `coverage.py --pool-out` (already landed with §0); margins docstring
   carries the bias caveat; all three self-tests in `regen-check.sh`.
5. **The retraction recorded** (this §0(b)) — in the plan, the report, and memory. M17/M18's
   "near-forcing" language is corrected wherever it would mislead a reader (ARCHITECTURE
   roadmap row for M18 gets one clarifying clause; no Lean artifact was affected — the Lean
   statements never mentioned forcing).

## 2.4 Domain-pass decisions (2026-08-04)

* **Sphere vocabulary**: the headline set is `Metric.sphere p 1 ∪ Metric.sphere p (√3/3)`,
  not a raw `dist` set-builder — Mathlib's name for the structure, with its lemma API.
  Alternative: the `{z | dist … ∨ dist …}` set-builder; rejected because every consumer
  restates it and `mem_sphere` is where the search looks. Confidence high.
* **Per-orbit choice is `Quotient.out`**: `orbitSetoid` (a `def`, deliberately *not* an
  instance) + `orbitRep z := (Quotient.mk orbitSetoid z).out`, with label-existence
  (`Quotient.mk_out`) and orbit-invariance (`Quotient.sound`) as the two rep lemmas. No
  quotient type in any signature; no hand-rolled choice plumbing. Alternative: a `Subgroup
  ℂˣ` + `QuotientGroup` — rejected as unit-coercion noise for zero gain at two generators.
  Confidence high.
* **Witness layout is one packed `Nat`, 4 bits per vertex** (M04 `PtTable` pattern) with a
  nibble extractor `wcolour v = (W >>> 4v) &&& 15`. The `Array (Fin 5)` draft was refuted
  by the kernel cost model: `Array.get!` reduces through the underlying list at O(index)
  per access ≈ 12.6M steps over the edge list (minutes); GMP shift-and-mask is ~free, so
  the packed layout checks in seconds. Two layers exactly as in M06: three decidable data
  facts over the literal (range, properness, counts) by `decide +kernel`, then the
  `∃ Coloring, …` headline derived by hand. Confidence high (cost model is measured, M05).
* **`induce` is primary, `comap` is the corollary**: any `f` with range in the union
  factors through the induced graph by a hom, and `Colorable` transfers along homs.
  The `comap` form keeps the consumer-facing hypothesis as sphere *membership* so the two
  forms compose definitionally. Confidence high.
* **The cover predicate `G.Adj p v ∨ v ∈ Q` stays unnamed** in CoverageMono — naming it
  would mint a second spelling of M18's `fan_iff_coverage` RHS (a seam), and the role
  already has a prose name (`N(p) ∪ Q`). Confidence medium — if a third module ever spells
  it again, name it then.

## 2.5 Proof decompositions (obligation pass, 2026-08-04)

**TwoCircle — constants.** `zeta6_sq = ⟨−1/2, √3/2⟩` and `zeta6_cube = −1` by component
`linear_combination` over the private `sq_sqrt3 : √3·√3 = 3` (M18 pattern); `zeta6^6 = 1`
by squaring the cube. `orderOf`-style iff via powers 1–5 ≠ 1 (im ≠ 0 except the cube, by
re); the ℤ-power iff `zeta6 ^ i = 1 ↔ 6 ∣ i` by `i = 6q + r` split (`Int.emod`) if no
`orderOf`/zpow bridge lemma answers a query first.

**`seam_pow_ne_one`** (the load-bearing 8 lines): `seam ^ n = 1` →
`IsIntegral ℤ seam` (root of monic `Xⁿ − 1`; or `IsIntegral.of_pow` on `isIntegral_one`) →
`seam⁻¹ = seam^(n−1)` integral (`IsIntegral.pow`) → their sum `t` integral
(`IsIntegral.add`); `t = (√3/3 : ℂ)` componentwise (inverse of a norm-1 number is its
conjugate, `Complex.ext`); `t² = (1/3 : ℂ)` via `Real.sq_sqrt`; so `1/3` is integral over ℤ
and rational — `IsIntegrallyClosed` descent (query `IsIntegrallyClosed.isIntegral_iff`,
`isIntegral_algebraMap_iff` for the ℚ→ℂ leg; fallback: monic `p(1/3) = 0` cleared by
`3^deg` gives `1 ≡ 0 (mod 3)` — the rational-root argument by hand). `seam_zpow_eq_one_iff`
by sign split on `j` (`Int.ofNat`/`negSucc`).

**Chord classifications — one helper pair, three instances.**
`private chord_ratio (hw hv : ‖·‖ = 1) (h : ‖(s:ℝ)·v − w‖ = c) : ∃ u, ‖u‖ = 1 ∧
‖s·u − 1‖ = c ∧ v = u * w` (u := v·w⁻¹; `(s·u − 1)·w = s·v − w`; norms multiply), then
`private unit_of_re_im (hu : ‖u‖ = 1) (hre : u.re = a) (hb : 0 ≤ b) (hab : a² + b² = 1) :
u = ⟨a, b⟩ ∨ u = ⟨a, −b⟩` (normSq gives `im² = b²`, `mul_self_eq_mul_self_iff`, `Complex.ext`).
Per instance, extract `u.re` from `‖s·u − 1‖ = c` by componentwise normSq expansion
(`Complex.mul_re/im`, `ofReal`) + `nlinarith`/`linarith`: (s,c) = (1,1) → re = 1/2;
(1,√3) → −1/2; (√3⁻¹,1) → √3/6. The `⁻¹` spelling in the cross-chord hypothesis is kept —
it is literally what the phase definition emits at the consumer.

**Labels.** `label w : ℤ × ℤ` by two `Classical.choose` on `sameOrbit_orbitRep`, with
`label_spec : w = ζ^i·s^j·orbitRep w`. `orbitRep_ne_zero` from norm-1 orbit membership.
`label_unique` as in the skeleton (cancel base, 6th power, `seam_zpow_eq_one_iff`, then
`ZMod.intCast_zmod_eq_zero_iff_dvd`-shaped cast — query exact name). The reusable core of
the assembly: `private label_step (hb : b ≠ 0) (h : y = ζ^a·s^c·x) (hx hy : labels over b) :
j' = j + c ∧ (i' : ZMod 6) = i + a` — every edge case becomes ratio → `label_step` → table.

**Assembly (`colorable_three_two_circles`).** Phase `if dist z p = 1 then z − p else
√3·(z − p)` (classical if; norm-1 in both branches, inner via `√3·√3 = 3` and the union
membership's other disjunct). Colour := `eTable/oTable ((label (phase z)).1 : ZMod 6)` by
tag. Validity: `by_cases` on the two tags (4 cases); each: dist-to-phase-norm algebra →
the matching chord classification → `SameOrbit` (so `orbitRep` agrees, `orbitRep_eq_of_
sameOrbit`) → `label_step` → `eTable_step`/`oTable_step`/`eTable_ne_oTable` (mixed cases
use the cross lemma with fixed (w, v) roles, `.symm` for the inner-outer orientation).
Estimated 120–180 lines with the helpers. **comap corollary**: hom `v ↦ ⟨f v, hf v⟩` into
the induced graph (adjacency definitional), colouring composes along homs (query
`SimpleGraph.Coloring.comp`/`Hom.comp`; fallback `Coloring.mk (C ∘ hom)`).

**CoverageMono.** `anti` = `le_trans`. `mono_subset` = `Finset.filter_subset_filter` on the
predicate implication + `card_le_card`. `mono_edges`: restrict `C' : G'.Coloring` to `G` by
`Coloring.mk C' (C'.valid ∘ hG)`; then `coverColours G … C ⊆ coverColours G' … C'` (same
underlying function — `rfl` on values) + `card_le_card`. `fan_iff_coverAtLeast`: forward
through M18's `fan_iff_coverage` — filter = `univ` by `eq_univ_iff_forall`, card = `k` by
`card_univ`/`Fintype.card_fin`; backward — `card ≥ k` + `⊆ univ` forces `= univ`
(`Finset.eq_univ_of_card`), pointwise gives the coverage ∀, close with `Fan.of_coverage`.
`of_triangle_mem`: the M18 move verbatim — `Finset.two_lt_card.mpr` with the three
`C a/b/c`, memberships via the `∈ Q` disjunct, distinctness via `C.valid`.

**DeGreyBalanced, two layers.** Layer 1 (`decide +kernel` over the packed literal):
`wcolour_lt_five : ∀ v : Fin 1581, wcolour v.val < 5`;
`wcolour_proper : ∀ e ∈ deGrey.edges, wcolour e.1.val ≠ wcolour e.2.val`;
`balancedColoring_counts : ∀ c : Fin 5, (univ.filter (balancedColoring · = c)).card ≤ 317`
— stated over the *same Finset the headline consumes* (no List↔Finset bridge). Kernel cost
by the measured model: edges ≈ 8k cells × O(1) big-int ops ≈ trivial; the five
`univ (Fin 1581)` constructions ≈ 0.8 ms/elem ≈ seconds. Measure at implementation; the
`Array` layout was already refuted (§2.4). Layer 2: `deGrey_balanced` packages
`Coloring.mk balancedColoring` (validity from `wcolour_proper`, both edge orientations,
`Fin.ext_iff`) with the counts fact (filter-predicate bridge `C v = i ↔ balancedColoring
v = i` is `rfl`-level through the `Coloring.mk` coe).

**Witness emission**: `tools/balance.py --emit` writes the packed hex literal + re-verifies
the model (proper, sizes) before emitting; the kernel re-checks everything anyway.

**Mutation audits at the gate** (each must go red): drop `hn : n ≠ 0` from
`seam_pow_ne_one` (seam⁰ = 1); 317 → 316 in the counts (the witness has a 317 class);
perturb one `eTable` entry (a step lemma's `decide` fails); swap `√3/3` for `1/2` in the
headline set (the inner-chord classification loses its target).

## 3. NOT in M19 (scope, with reasons)

1. **The general-r two-circle theorem** (any class radius, not just 1/3) — the same method
   likely covers every r with both chord angles defined; deferred until a milestone needs
   it; the r² = 1/3 case is the live class. → outlook, possibly M20.
2. **The multi-circle / extension problem** (can external structure force a 4th colour by
   restricting which 3-colourings of G[S] extend? equivalently: coverage-4 via ambient
   forcing) — **M20's question**, now precisely posed by the barrier's boundary.
3. **Certifying the closure's balance verdict** — the closure graph has no Lean-side data
   modules, and a side negative does not justify a data milestone. Tools-only record.
4. **Any ghost/forcing theorem** — dead with mechanism (b); nothing to state.
5. **Kernel-certifying a minCov reading** — unchanged M16 policy; no CONFINED reading
   exists to certify.

## 4. Gate additions (beyond build green / zero sorry / axioms clean / lint silent)

* `colorstat.py --self-test`, `balance.py --self-test` in `regen-check.sh` (coverage.py's
  self-test already wired covers `--pool-out` refusals via colorstat's round-trip);
* negative controls in-module: a 4-clique handed to the two-circle colouring machinery must
  be *rejected by the hypotheses* (no 4 points pairwise unit on two circles — pinned as an
  `example` refuting the premise pattern, or a `#guard_msgs` control); `CoverAtLeast`'s
  vacuous-domain control (empty cover set ⟹ level 1 fails);
* `#print axioms` on all three new modules: exactly `[propext, Classical.choice,
  Quot.sound]`; `DeGreyBalanced` may **not** buy `native_decide` (decide +kernel only);
* the balanced witness's five class sizes asserted in Lean must match the committed JSON
  witness byte-for-byte (emit-and-reverify, never hand-copy).

## 5. Operational rules in force (unchanged, recorded in CLAUDE.md)

All builds through `scripts/build.sh`; on any segfault halt and report immediately; one
heavy job at a time; write-up and `lean4checker` replays deferred indefinitely (publication
gates); `tools/` untrusted; a `minCov = 5` reading becomes a claim only through M16's
kernel route.

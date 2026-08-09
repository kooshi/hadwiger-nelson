# M25 — The 3-pivot + metapivot ladder system, unconditionally

*Stub recorded 2026-08-08 (post-M23 roadmap discussion); subplan opened
2026-08-09 on Kooshi's go. §0 predictions are registered BEFORE the experiments
run — the commit of this section predates every instrument result below it.*

## §0 Registrations — predictions BEFORE instruments

### §0.1 E1 — The frame and the four meta-axis norm forms

The object: four ladders. Each pivot p ∈ {0, 1, ζ₆} carries
`{p + w, p + (√3/3)·w : w = ζ₆^a σ^b}` — anchor direction 1 serves all three,
because every pivot→pivot difference is a ζ₆-power and the word absorbs it.
The metapivot m = (1+ζ₆)/3 carries the same two-circle ladder anchored at
direction ζ₁₂ (its axis to the pivot 0).

Registered predictions:
* **P1.1** m = ζ₁₂/√3 exactly, and the three pivot→metapivot unit directions
  are `e₀ = ζ₁₂`, `e₁ = ζ₁₂⁵`, `e_{ζ₆} = ζ₁₂⁹` — exactly the odd coset of
  ⟨ζ₆⟩ in ⟨ζ₁₂⟩ (P4.5's index-2 statement made pointwise).
* **P1.2** For every pivot–meta pair and every circle combination
  (ρ₁, ρ₂ ∈ {1, 1/√3}), the chord-1 condition has the M24-oi master shape:
  `normSq(A) = 3` for an explicit `A` linear in the two words with √3-weights
  determined by (ρ₁, ρ₂), after scaling the cross identity by √3 (the axis is
  1/√3, so ‖1 − x − v‖ = √3 replaces M24's = 1). The oi instance (1 → 1/√3)
  factors with the hub factor (the meta's inner circle passes through the
  pivots); the io instance with the other hub factor; oo and ii are
  irreducible — no matching-type factor anywhere on this axis (E4 confirmed at
  the circle level; this re-derives it at the word level).
* **P1.3** The three pivot–meta webs are word-level isomorphic: conjugating by
  the 120° rotation about m carries the (0,m) classification to (1,m) and
  (ζ₆,m) by explicit address re-indexing. One web is proven in Lean; two
  transport lemmas cover the rest.
* **P1.4** The pivot–pivot webs at the axes (0,ζ₆) and (1,ζ₆) are pure
  re-addressings of M24's theorems (address shift a ↦ a ± 1); no new
  arithmetic.

### §0.2 E2 — The ζ₁₂-ring engine (the research risk)

* **P2.1** `√3 = ζ₁₂ + ζ₁₂⁻¹ ∈ ℚ(ζ₁₂)`: **the M24 separation is UNAVAILABLE
  for the meta-axis families.** Their cleared equations live wholly in
  `ℤ[ζ₁₂, π]` (minimal polynomial `x⁴ − x² + 1`; integer basis
  `{1, ζ₁₂, ζ₁₂², ζ₁₂³} ⊗ {1, π}`, eight coordinates).
* **P2.2** The separation's replacement: divisibility by √3 in `ℤ[ζ₁₂]` is a
  pair of mod-3 congruences on the four coordinates (the sublattice
  `√3·ℤ[ζ₁₂]` has index 9); the ideal (√3) is prime in `ℤ[ζ₁₂]` with residue
  field `𝔽₉` (`x² + 1` irreducible mod 3, `ζ₁₂ ↦ i`); modulo (√3) the relation
  `π² = π − 3` degenerates to `π(π − 1) ≡ 0`, and the two-prime structure
  π/π̄ over √3 persists — the M24 collapse `π·π̄ = 3 = √3²` carries verbatim.
* **P2.3** Coordinate uniqueness (the `sep_rat` analogue):
  `ℚ(ζ₁₂, π) = ℚ(i, √3, √11)`, and the eight coordinates separate through
  real/imaginary parts into two applications of M24's `sqrt_indep` — no new
  irrationality input.
* **P2.4** The ζ₁₂-unit tables (the `hexE`/`hexF` analogue): integer tables
  `ζ₁₂^n = c₀(n) + c₁(n)ζ₁₂ + c₂(n)ζ₁₂² + c₃(n)ζ₁₂³` for n < 12; no unit is
  ≡ 0 mod √3 (units stay units in 𝔽₉), and the twelve units have distinct
  𝔽₉-signatures (the pin mechanism's licence).
* **P2.5** The sharp transfer prediction: clearing produces ONE ring equation
  (no separation component); the √3-adic parity of the cleared coefficients
  replaces M24's parity split; 𝔽₉-congruences replace the mod-3 rows; and the
  trace-pair/telescope shapes reappear over ζ₁₂-addresses. The named risk: 𝔽₉
  has more units than 𝔽₃, so pins may be weaker and some case may need
  second-order (mod (√3)² = mod 3) congruences. **Failure clause**: a
  meta-axis family whose case analysis does not close under (√3)-adic plus
  mod-9-coordinate congruences is reported NOT LANDED, the χ theorem is
  stated conditional on exactly that family, and the milestone re-scopes
  openly — no quiet rescoping.

### §0.3 E3 — The census bed

* **P3.1** `tools/couple.py --ladder-census` extends to the four-ladder object
  (metapivot ladder at direction ζ₁₂), exact verdicts, with the M24 control
  discipline: census cross-checks the Lean-stated tables once they exist, and
  the self-test carries a planted disagreement.
* **P3.2** Registered structural counts, falsifiable: the meta-axis oi
  (outer→meta-inner), ii, and io families carry **periodic infinite
  glue branches** indexed by their gluing torsions (ζ₁₂, ζ₆, ζ₃ — periods
  12, 6, 3 in the hex address), because periodic gluings recur along the
  lattice; the oo family (θσ, incommensurate) carries **no infinite branch**;
  beyond the periodic branches every family's remainder is **finite**
  (sporadic + hub-incident), by analogy with M24's oi. The census decides.
* **P3.4** Tube parity: each family shows a fixed parity signature in the
  combined lattice (measured, no strong prior registered — recorded at face
  value).

### §0.4 E4 — The colouring probe and the fork

* **P4.1** With all census families imposed, b-collapsed (the M24 E6 method),
  the four-ladder object admits a proper 4-colouring by a b-independent table
  extending M24's 24 entries by the metapivot's circles (medium confidence).
  **Pre-committed fork** (the stub's Ask, now binding): if k = 4 is UNSAT at
  census depth and the kill is injection-verified, the milestone pivots to
  certifying the 5-forcing — that outcome is the more valuable one.
* **P4.2** χ ≥ 4 is free: M24's `ladderSet` is a subset of the four-ladder
  object (the pivots 0, 1 ladders), so the nine-point witness embeds and the
  lower bound is an induced-subgraph monotonicity, one lemma.

### §0 results — recorded 2026-08-09 (`build/m25-derive.py`, `build/m25-census.py`,
`build/m25-color.py`; all chord verdicts exact; census parallel over the 36
family pairs per Kooshi's mid-run instruction)

**E1 — all confirmed.** P1.1 exact (`m = ζ₁₂/√3`; axes `ζ₁₂, ζ₁₂⁵, ζ₁₂⁹`).
P1.2: all four norm forms derive in the trace-pair genus (constant + three
conjugate pairs); the oi instance factors with hub factor `(v + 1)` — the hub
is `v = −1`, the meta-inner point AT the pivot (E4-M24's `(v−1)` was the same
factor in the opposite frame sign); io factors with `(u − 1)` (the pivot-inner
point at the metapivot); oo and ii irreducible. The ii form has NO constant
term and no √3: pure trace pairs. P1.3, P1.4 confirmed at address level by the
census (the three webs are exact `a ↦ a+2` shifts; pivot-pivot counts match
M24's proven tables).

**E2 — confirmed, with one registered miss that sharpens the engine.**
P2.1 ✓ (`√3 = 2ζ₁₂ − ζ₁₂³`, minpoly `x⁴ − x² + 1`). P2.2 ✓ and now EXPLICIT:
`√3 ∣ x` in `ℤ[ζ₁₂]` ⟺ **`c₂ ≡ c₀` and `c₃ ≡ c₁` (mod 3)** (index 9, det
computed); (√3) prime, residue `𝔽₉`, `π(π−1) ≡ 0` mod (√3). P2.3 ✓ (degree 8,
`= ℚ(i,√3,√11)`; `sqrt_indep` twice through re/im). **P2.4's second half is
WRONG as registered**: the twelve units have only FOUR distinct 𝔽₉-signatures
(`ζ₁₂ ↦ i`, period 4) — mod-√3 pins give the address mod 4 only. The full pin
lives one level up: mod 3 (= mod (√3)²) all twelve coordinate vectors are
pairwise distinct. The M25 pin ladder is therefore two-stage: mod √3 for
coarse kills, mod 3 for address pins — exactly the P2.5 named risk, landing
where predicted.

**E3 — the measured structure is SIMPLER than registered.** Census exact at
B = 30 and B = 60, growth-tested. Controls: the pivot–pivot families reproduce
M24's PROVEN tables exactly (matching 726 + the 8 non-crossing ii rows; the 16
oi rows verbatim; intra hex/rot3/seam counts). The new webs, per pivot–meta
pair: **oo, io, ii are FINITE — four sporadic chords each, all at |b| ≤ 1**;
**oi = the hub pencil** (every outer(p) point to the fused meta-inner point at
the pivot, exact address `(3,0)` in the 0-web) **plus four hex-layer
sporadics (b = 0 both sides)**. P3.2's finiteness-beyond-named-branches and
oo-carries-nothing: ✓. P3.2's torsion-periodic branches for ii and io: **WRONG
— those gluings' orbit points are off-lattice** (mirror centroids and the
`ζ₁₂/√3`-directed io hub are never lattice words — M24's empty `Re = √3/2`
fibre doing the work), so both families are finite outright. The measured
tables (0-web): oo `{(0,0,5,±1), (1,0,1,±1)}`; oi sporadics
`{(0,0,1,0), (1,0,5,0), (2,0,1,0), (5,0,5,0)}`; io
`{(2,∓1... (2,-1,5,1), (2,1,5,-1), (5,-1,1,1), (5,1,1,-1)}`; ii
`{(0,±1,5,0), (1,±1,1,0)}`. Artifact: `build/m25-census.json`.

**E4 — both registrations confirmed; the fork does NOT fire.** Exact graph at
B = 30: 2,928 labelled points, 2,907 after fusion-dedup, 9,048 exact unit
edges. k = 3 UNSAT (control ✓, the M24 witness inside); **k = 4 SAT** ✓; and
the **b-independent table EXISTS** (33 collapsed classes after fusion merges,
90 collapsed edges, no self-loop) — recorded verbatim in the skeleton's
`metaColTab`. The milestone stays a χ = 4 construction; the pre-committed
5-forcing pivot is not taken.

## §1 Scope (post-§0 shape)

1. **The ζ₁₂ layer** (`MetaLadder.lean` §Z/§R): `zeta12`, `metaPivot`, the
   ring facts, the eight-coordinate uniqueness, the √3-divisibility
   congruence pair, the unit tables. The M24 engine's replacement parts.
2. **The object** (§L): four anchor pairs — `(0,1)`, `(1,2)`, `(ζ₆,ζ₆+1)`,
   `(m, m+ζ₁₂)` — every sub-ladder an M24 `outerPt`/`innerPt` family, so M24's
   intra/fusion/injectivity theory applies verbatim; `fourLadder` the 8-set
   union; M24's `ladderSet` a subset (the χ ≥ 4 transport).
3. **The master web** (§W): the four completeness theorems at the (0,m) axis
   with the census tables (hub pencil + 4+4+4+4 sporadics), by the two-stage
   ζ₁₂-engine.
4. **Transport** (§T): the 120°-rotation web transport (`a ↦ a+2`) and the
   pivot-pair re-addressing (`a ↦ a±1`) — geometry-only lemmas.
5. **The colouring** (§C): `metaColTab` (measured), properness over all
   families, χ = 4 headline (`chromaticNumber_fourLadder`).

Skeleton: `Proofs/HadwigerNelson/MetaLadder.lean`, 25 obligations, elaborates
clean with `sorry` at every leaf. NOT yet imported by `Proofs.lean` (added at
implementation).

### Already settled at subplan (four-part rows)

| choice | alternative | why | confidence |
|---|---|---|---|
| Sub-ladders as M24 `outerPt`/`innerPt` at four anchor pairs | fresh point defs with a ζ₁₂-direction parameter | the whole M24 intra/fusion theory transfers with zero new statements; the ζ₁₂ enters once, in `metaAnchor` | high |
| One master web + rotation transport | three webs proven independently | census confirms exact `a ↦ a+2` isomorphy; transport is one geometry lemma vs ~3× the core analysis | high |
| Census standalone in `build/` at subplan; promotion into `tools/couple.py` with planted-control self-test at implementation | extend `tools/couple.py` now | the subplan needed tables, not surface; the tool change deserves the control discipline as part of the gate | medium — if implementation finds the standalone and tool censuses disagree, the tool wins and the tables re-derive |
| The colour table from the collapsed-probe solution as a literal | re-search in Lean | measured object, kernel re-verifies properness anyway (M24 pattern) | high |

## Scope

The **four-ladder object**: natural ladders of the pivots 0, 1, ζ₆ AND of the
metapivot m = (1+ζ₆)/3 (the metapivot gets its own ladder — Kooshi,
2026-08-08), closed under ALL unit chords among their points. Deliverables:

1. Complete chord lists: the three unit-axis cross-webs (M24 theorems apply
   verbatim — anchor-independence) + the three axis-1/√3 pivot–metapivot webs
   (norm forms from M24's derivation batch) + intra families (backbone).
   Sporadic counts PROVEN, not computed.
2. The colouring theorem: χ(four-ladder object) decided exactly. This is the
   sharpest form of M23's broadcast-cycle question — the first place the
   triangle's cyclic structure meets a complete chord list.
3. The overlap-aware pattern census (the M23 §0.2.1 protocol discovery made
   into the registered instrument): pattern triples consistent on the shared
   ten-point structure; registered BEFORE building.

## Ask

* Decision at subplan: if tools-side triage finds χ = 5 forced, the milestone
  pivots to certifying THAT (a 5-forcing countable structured object would mean
  the family can exceed 4 — the recursion/tiling thread comes alive toward 6);
  if χ = 4, the constructive pattern + splice machinery from M24 carries.
* Compute: SAT battery on the 4-ladder object at depth; desktop-scale.

## Evidence in hand

`Triangle.lean` (self-gluing, ten-point theorem, metapivot couplings, chord
classifications, seam hexagon); census A (34-point inventory, field closure);
the M23 loop census (seam relations need all three pivots); the matched-pair
period-1 pattern (`build/m23-ladderpair-pattern.json`); M23 §0.2.1 finding
(unit triangles never "far" — cover sets interlock through the shared glue
points, so the pattern machinery must be overlap-aware from the start).

## Modeling pass 1 — domain (2026-08-09, fresh invocation)

Four changes, all applied to the skeleton (elaborates, 26 obligations):

1. **Anchor-independence named once**: `outerPt_hexRot`/`innerPt_hexRot` — rotating
   the anchor partner by a hex power re-addresses the ladder (`a ↦ a + k`),
   quantified over the rotation. The pivot-pair re-addressing, the M24-subset
   inclusion (which needs the `a+3` instance: M24's q-side ladder points back
   along `−1`), and the web transports are all instances — the "N statements
   modulo naming" smell collapsed into one lemma.
2. **All-web completeness with multiplicity**: the four per-family theorems now
   quantify over the pivot `j : Fin 3` with membership shifted by
   `webShift j = 2j` — the census-verified isomorphy as one statement per
   family instead of three copies; the master web is the `j = 0` instance.
3. **Coordinate tables in the house currency**: `z12Coords : ℕ → ℤ×ℤ×ℤ×ℤ`
   (projection soup at every certificate) replaced by four `ℕ → ℤ` tables
   `z12c0..z12c3` (the `hexE`/`hexF` pattern), and `zeta12_pow_coords` restated
   over `ZMod 12` with no side hypothesis (the `.val` carries the bound).
4. **`pivot : Fin 3 → ℂ` named**; the anchor list routes through it.

Seam validation done during the pass: the colour table's consistency on fused
points re-checked by hand at the worst point (pivot 1 = `P0o[0]` = `PZo[5]` =
`Mi[5]`, all colour 1 — the probe's union-find had enforced it); the rotation
`0 ↦ 1` about the metapivot computed exactly (`m + ζ₆²(0−m) = 1`). Deliberately
NOT added: the trace-pair-over-`ZMod 12` object and the clearing identities —
proof machinery, recorded for the obligation pass, not spec.

## Modeling pass 2 — obligation (2026-08-09, fresh invocation)

Skeleton grew to 28 obligations (naturality lemmas added: `outerPt_map_rot` /
`innerPt_map_rot` — the web transports are two-line instances of them).

### The proof spines, by tier (prove / test / assume partition: everything below
is "prove"; the census artifacts are "test"; no assumed hypotheses anywhere)

1. **ζ₁₂ layer** (~10 easy): `zeta12_sq/pow_three/minpoly/sqrt3_eq_zeta12` by
   `Complex.ext` + `nlinarith [sq_sqrt3]` (the M24 §0 pattern);
   `zeta12_pow_coords` by the power ladder + `interval_cases` on `val < 12`
   (the `zeta6_zpow_hex` spine verbatim). `meta_axis_dirs` by ext-arithmetic.
2. **Ring layer** (~15): `inRing12_coords_zero` — separate re/im, each an
   instance of M24's public `sqrt_indep` (`ℚ(ζ₁₂,π) = ℚ(i,√3,√11)`: re-parts
   over `{1,√3,√11,√33}`... exact routing derived at implementation from the
   component expansion; the spine is TWO `sqrt_indep` applications).
   `sqrt3_dvd_iff`: mpr constructs the quotient coordinates explicitly —
   `d₀ = (c₁−c₃)/3, d₁ = (2c₀+c₂)/3, d₂ = (c₁+2c₃)/3, d₃ = (c₂−c₀)/3`
   (E2's inverse matrix), divisibility by omega from the congruences; mp reads
   `c = M√3·d` off coordinate uniqueness and closes by omega. Plus the closure
   API (`InRing12.add/neg/mul/zeta12_mul/piC_mul/...` — the M24 `InRing` list
   with one more generator) and the unit-table helpers (twelve units pairwise
   distinct mod 3; none ≡ 0 — both `decide`).
3. **The engine adaptation** (~20, the research core): the M25 clearing turns a
   web equation into ONE `ℤ[ζ₁₂,π]` identity (no separation component — √3 is
   in the ring). The kill instrument is the two-stage congruence read:
   * stage 1 (mod √3): a term `√3^e·ζ₁₂^x·π^h` with `e ≥ 1` drops; the
     surviving minimal-exponent terms give a `𝔽₉`-relation among units ×
     π-images (π ≡ 0 or π̄ ≡ ... via `π(π−1) ≡ 0`); the address-mod-4
     signatures kill or pin coarsely.
   * stage 2 (mod 3 = mod √3², after dividing the identity by √3 once): the
     twelve-unit tables are pairwise distinct — full address pins, the M24
     mod-3 rows reborn.
   The parity split reappears as: which terms carry ODD √3-exponent — same
   bookkeeping, now internal. The collapse `π^h·π̄^k = 3^min·π^{h−k}` and the
   conjugate-root development (`π̄ = 1−π`) carry verbatim from M24. The
   trace-pair analogue: `T₁₂(x : ZMod 12, h) = ζ₁₂^x π^h + ζ₁₂^{−x} π̄^h`,
   with the invariant that pivot-side addresses are ODD and meta-side EVEN
   (the index-2 coset split doing arithmetic work). Pin/telescope lemmas port
   with the ZMod-12 tables.
4. **The four families** (the bulk, est. 600–900 lines): per family, the
   census says every solution sits at |b|,|d| ≤ 1 (oi additionally the hub
   pencil, whose factor `(v+1)` splits off FIRST — the hub branch is
   `word c d = −ζ₁₂⁻¹`-free... `innerPt m · (3+2j,0) = pivot j` handles it
   at the geometry level, then the cofactor is the finite part). Spine per
   family: clear → one ring identity → stage-1 kills for heights ≥ 2 (the
   √3-exponent gaps grow with height, so large heights die on the FIRST
   congruence pair; expected far shallower than M24-oi's shape tree) →
   boundary decides over (a, c) at |b|,|d| ≤ 1 (≤ 324 cases; the M24
   36-pair-decide pattern with the mod-3 twelve-unit tables; watch
   `synthInstance.maxSize` — M24's six-fold-Or lesson). Signed heights via
   the M24 conj/swap reductions (conjugation maps the web to itself with
   `a ↦ −a`; no swap symmetry across the axis — the two sides differ — so
   sign quadrants reduce by conjugation only: 2 cases per family, not 4).
5. **Transport + assembly**: `outerPt_map_rot` by `ring` after unfolding (pure
   algebra); `web_transport_rot(_meta)` = naturality + `outerPt_hexRot` +
   the exact rotation facts (`m + ζ₆²(0−m) = 1` etc); the all-web iffs reduce
   `j` to 0 through `dist`-invariance under the rotation isometry
   (`Complex.dist_eq` + `|ζ₆²| = 1` — or `Isometry` API if Mathlib's rotation
   isometries state it directly; query at implementation).
6. **Colouring layer**: the decode + properness, M24's §H pattern. **The named
   hidden obligation this pass surfaced: the fusion inventory.** The census
   dedup found 21 coincidences at B = 30 (pivots-on-ladders, the M24 fusion
   octet at each pivot axis, hub identities). Well-definedness of the decode
   over `fourLadder` needs the COMPLETE coincidence list as a theorem
   (M24 §F extended to all anchor pairs). Implementation starts by
   enumerating it tools-side (exact), then states it; the Triangle.lean
   couplings (certified circle intersections) supply the glue-point
   candidates. This is the likely cost overrun; the carve line if it overruns
   is stated in §1 (χ-theorem conditional, openly).

### Mutation audits (fixed now, run at gate)

1. Delete one row from each meta table → the family's completeness (and the
   properness decide) must break, naming it.
2. `webShift j := 2j → j` → the `j = 1` instances must break.
3. One `metaColTab` entry flipped → properness fails naming the family.
4. `sqrt3_dvd_iff` weakened (drop `c₃ ≡ c₁`) → the iff's proof must break.
5. Hub disjunct removed from `meta_oi_complete` → the pencil's ⟸ breaks.

### Statement adjustments this pass made

* Added the two naturality lemmas (transports demoted to instances).
* No completeness statement needed strengthening: the j-quantified forms carry
  their own reduction (isometry + re-addressing), and the hub disjunct's
  address arithmetic (`c − 2j = 3`) was re-checked against the census.

## Modeling pass 3 — experience (2026-08-09, fresh invocation)

Consumers walked: M26's implementation (seven ladders — the heaviest future
reader), the automation inside M25's own proofs, and the census operator.
Skeleton now 30 obligations; changes:

1. **`outerPt_map_rot` → `outerPt_affine`** (and inner): the statement has no
   unit-modulus hypothesis — it is affine equivariance, and a name claiming
   rotation would plant a false belief in every future guess. Docstring names
   the transports as the `r = ζ₆²` instances.
2. **`metaColTab` docstring** now states the Bool convention (`false` = outer,
   M24's `colTab` convention) — the cold read could not recover it.
3. **Membership intro API added** (`outer_mem_fourLadder`/`inner_mem_...`):
   the χ-theorem consumers and M26's subset arguments need them; without them
   every use site re-unfolds the union.
4. Checked and kept: the all-web iff shape is exactly what `exact?` finds from
   a `dist … = 1` goal and unifies at any `j` (the domain pass's collapse
   validated from the consumer side); zero simp tags (house precedent); table
   names in the M24 currency; the engine surface (`InRing12`, `sqrt3_dvd_iff`,
   `z12c*`, `piCoeff` reuse) is public for M26–M27.
5. Census promotion contract re-affirmed (P3.1): the tools/couple.py extension
   at implementation must cross-check ALL the MetaLadder tables including the
   shifted webs, and its self-test must carry a planted disagreement.

## Pre-implementation context save (2026-08-09, before compaction)

**The four cleared norm forms, exact** (E1.2, frame: pivot at 0, axis real,
D = 1/√3; multiply |z₁−z₂|²−1 by 3; `u` = pivot-side unit, `v` = meta-side
unit, bars = conjugates). In the LATTICE addressing of the j = 0 web:
`u = word a b · ζ₁₂⁻¹` (pivot side — trace addresses ODD: 2a−1),
`v = word c d` (meta side — EVEN: 2c); webs j = 1, 2 via the 120° rotation.

* oo: `4 − √3(u+ū) + √3(v+v̄) − 3(uv̄+ūv) = 0` — irreducible.
* oi: `2 − √3(u+ū) + (v+v̄) − √3(uv̄+ūv) = 0` — hub factor `(v+1)`:
  u·v-cleared it is `−√3(v+1)(u² − (√3/3)uv − (√3/3)u + v)`; the hub `v = −1`
  is `word c d = −1`, address `(3,0)` (`metaInner_hub`).
* io: `2 − (u+ū) + √3(v+v̄) − √3(uv̄+ūv) = 0` — hub factor `(u−1)`; the hub
  `u = 1` needs `word a b = ζ₁₂` — off-lattice (M24's empty `Re = √3/2`
  fibre), hence io stays finite.
* ii: `−(u+ū) + (v+v̄) − (uv̄+ūv) = 0` — no constant, no √3: pure trace pairs.

**√3-quotient coordinates** (for `sqrt3_dvd_iff`.mpr): given `c₂ ≡ c₀`,
`c₃ ≡ c₁` (mod 3), the witness is `d₀ = (c₁−c₃)/3, d₁ = (2c₀+c₂)/3,
d₂ = (c₁+2c₃)/3, d₃ = (c₂−c₀)/3`; mp direction reads `c = M·d` with
`M = [[0,1,0,-1],[2,0,1,0],[0,1,0,2],[-1,0,1,0]]` (mult-by-√3 in the basis,
det 9).

**Instrument note**: `build/m25-derive.py`, `build/m25-census.py` (parallel
across the 36 family pairs — Kooshi's instruction), `build/m25-color.py` are
in gitignored `build/`; everything they measured is recorded above, and they
regenerate from this plan's specifications. Census artifact
`build/m25-census.json` likewise regenerable (B = 30/60, ~2 min parallel).

## Implementation §I.0 — the engine, re-derived (2026-08-09, before any Lean)

**The registered ζ₁₂-ring engine is superseded by LESS machinery, exactly as M24's
registered π-adic valuation sketch was.** One identity does it:

  **√3 · ζ₁₂ = 1 + ζ₆**   (equivalently ζ₁₂ = (1+ζ₆)/√3, the metapivot relation
  m = (1+ζ₆)/3 = ζ₁₂/√3 read one radius out).

Write `g := 1 + ζ₆` (so `g·ḡ = 3`, `g² = 3ζ₆`, `ḡ = ζ₆⁻¹g`). Then every meta-axis
web equation is a ℤ[√3]-combination of **M24 trace pairs over ℤ[ζ₆,π]** — the
ζ₁₂ never appears. With `w₁ = word (a−1) b` (pivot side), `V = word c d` (meta
side), `W = w₁·V̄ = word (a−1−c) (b−d)`, and `Tr z := z + z̄`:

| family | master trace form (⟺ dist = 1) |
|---|---|
| oo | `4 − Tr(g·w₁) + √3·Tr(V) − √3·Tr(g·W) = 0` |
| oi | `2 − Tr(g·w₁) + Tr(V) − Tr(g·W) = 0` |
| io | `2√3 − Tr(g·w₁) + 3·Tr(V) − √3·Tr(g·W) = 0` |
| ii | `0 − Tr(g·w₁) + √3·Tr(V) − Tr(g·W) = 0` |

(uniformly `κ = (3 + s²t² − 2s²)/s, λ = st, μ = t` for `s,t ∈ {1,√3}` the two
circle radii; verified exhaustively against the geometry, `build/m25-trace.py`,
0 mismatches over 6·6·7·7 addresses per family, census tables re-derived.)

**Consequences, all in the direction of less work:**
* M24's separation `√3 ∉ ℚ(ζ₆,π)` (`eq_zero_of_add_sqrt3_mul`) IS available —
  P2.1's "the separation is UNAVAILABLE" was measuring the wrong ring. `ℤ[ζ₁₂,π]`
  is where the *equation was expected to live*; it never goes there.
* `InRing12`, `inRing12_coords_zero`, `sqrt3_dvd_iff`, `z12c0..3`,
  `zeta12_pow_coords` are **deleted** from the skeleton — machinery for a proof
  that is not the proof. The ζ₁₂ layer keeps only what the object needs.
* The M24 engine (`piCoeff` rows, `hexE`/`hexF`, `InRing`, `sqrt_indep`) carries
  M25 verbatim, and it generalizes once: `hexTrace t₁ t₂ h := (t₁+t₂ζ₆)π^h +
  (t₁+t₂ζ̄₆)π̄^h` has coordinates `(t₁P + (t₁+t₂)(P+Q), −t₂Q, −t₂Q, 2t₂Q)` in
  `{1,ζ₆,π,ζ₆π}` — M24's `tracePair x h` is the `ζ₆^x` instance.

**The case tree (measured, `build/m25-tree.py`, `m25-kill.py`, `m25-roots.py`):**
clear by `√3^(m+n)` where `m = |b|, n = |d|` — **no shape split needed**, the
cross term's denominator factors through the other two. Exponents
`(κ: m+n+τ₀, w₁: n, V: m+τ₂, W: τ₃)`; `τ = (0,1,1)/(0,0,0)/(1,2,1)/(—,1,0)`.

1. **Parity separation** on `(m,n) mod 2`: three of four classes leave a single
   trace object alone on one side of `√3`, killed by two finite facts —
   `(F1)` `G(x,h) ≢ 0 (mod 3)` for `h ≥ 1` (`G := TP(x,h)+TP(x+1,h)`, the
   `g`-trace) and `(F2)` `TP(y,n) ≢ 0 (mod 3)` ever. Live class per family:
   oo `(m,n) = (e,o)`, oi `(e,e)`, io `(o,o)`, ii `(o,e)`.
2. **The live class, mod 3**: the minimal-exponent terms must cancel mod 3.
   `φ(z) := n₁ − n₂ mod 3` (reduction at the prime 𝔭 over 3) satisfies
   `φ(G) = 0` always and `φ(TP) ≠ 0` always — this is what mod-3 on all four
   coordinates cannot see term-by-term but does see in combination. Verified
   exhaustively (`m25-kill.py`, |b| ≤ 24, |d| ≤ 10): **every family collapses to
   |d| ≤ 1** — oo, io need `|d| = 1`; oi, ii need `d = 0`.
3. **The endgame at fixed d**: the equation is `Tr(Ψ·w₁) = C` with
   `Ψ = g(1 + μV̄)`, `C = κ + λ·Tr(V)` explicit in the ≤ 12 remaining `(c,d)`.
   Clearing gives `hexTrace t₁ t₂ m = 3^e·(integer)` with `(t₁+t₂ζ₆) = √3^n Ψ ζ₆^A`;
   coordinate 4 forces `t₂ = 0` (since `Q_m ≠ 0`), coordinate 1 gives
   `t₁(2P_m+Q_m) = 3^e·τ`, and `3 ∤ (2P+Q)` forces `3^e ∣ t₁` — **which bounds m
   outright**, since `t₁` runs over an explicit finite set. Finite check closes.
   Root-level cross-check (`m25-roots.py`): the quadratic `Ψw² − Cw + Ψ̄ = 0`
   has exactly the census words as lattice roots in every one of the 36 cases,
   every other root a non-word — all four tables reproduced exactly.

**Confidence**: high for steps 1 and 3 (both exhaustively machine-checked over
their finite content); medium-high for step 2's Lean cost (the exponent
comparisons are a case tree of ~6 branches per family).

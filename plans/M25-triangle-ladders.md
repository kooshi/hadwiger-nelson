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

### §0 results

*(recorded after the §0 batch runs; the registrations above are committed
first)*

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

### row 1 — FS106-COMP (upstream; plans/FS106-derivation.md:227)
- grade: hand; the first two minds, one blind: TQ, QB; the equivalence one mind: QB | minds:  | verdict: TRUE.
- needs: 
- statement: 
- uses: 
- not claimed: 
- handoff/kernel: declined.
- dependents (index, direct/transitive): 1/6

### row 2 — FS106-DIAM (upstream; plans/FS106-derivation.md:155)
- grade: hand; two minds, one blind: V2, SB (L0, L0′) | minds:  | verdict: TRUE (classical in its first form).
- needs: 
- statement: 
- uses: 
- not claimed: 
- handoff/kernel: stub — small, a natural first FS-101 leaf.
- dependents (index, direct/transitive): 1/16

### row 3 — FS106-L (upstream; plans/FS106-derivation.md:160)
- grade: hand; one mind: V3 | minds:  | verdict: TRUE.
- needs: 
- statement: 
- uses: 
- not claimed: 
- handoff/kernel: declined.
- dependents (index, direct/transitive): 2/11

### row 4 — FS106-REM (upstream; plans/FS106-derivation.md:223)
- grade: hand; two minds, one blind: TQ, QB; the uniform form's falsity one mind (TQ) | minds:  | verdict: TRUE.
- needs: 
- statement: 
- uses: 
- not claimed: 
- handoff/kernel: declined.
- dependents (index, direct/transitive): 1/6

### row 5 — FS106-EQ (upstream CYCLE; plans/FS106-derivation.md:197)
- grade: hand; two minds, one blind: TQ, QB by a different route at (c) ⟹ (a); (a) ⟺ (b) is row 130's | minds:  | verdict: TRUE by both (A2 §1a.1). **G21: a compactness restatement; it moves no value** — …
- needs: FS106-COMP, FS106-REM, FS106-SUP
- statement: 
- uses: 
- not claimed: 
- handoff/kernel: stub — after row 130's M1 enters FS-101.
- dependents (index, direct/transitive): 1/5

### row 6 — FS106-SUP (upstream CYCLE; plans/FS106-derivation.md:205)
- grade: hand; two minds, one blind: TQ, QB (stronger) | minds:  | verdict: TRUE.
- needs: FS106-EQ
- statement: 
- uses: 
- not claimed: 
- handoff/kernel: declined.
- dependents (index, direct/transitive): 2/5

### row 7 — FS106-TS-C (upstream; plans/FS106-derivation.md:143)
- grade: hand; two minds, one blind: TS, SB (L0′, a different route) | minds:  | verdict: TRUE.
- needs: FS106-DIAM
- statement: 
- uses: 
- not claimed: 
- handoff/kernel: declined.
- dependents (index, direct/transitive): 1/15

### row 8 — FS106-TS-T (upstream; plans/FS106-derivation.md:151)
- grade: hand; two minds, one blind: TS (hull growth), SB (Lebesgue's covering theorem, sharper) | minds:  | verdict: TRUE.
- needs: FS106-TS-C
- statement: 
- uses: 
- not claimed: 
- handoff/kernel: declined.
- dependents (index, direct/transitive): 3/14

### row 9 — FS106-WO (upstream; plans/FS106-derivation.md:73)
- grade: hand; one mind: V3; steps 2, 3, 5, 7 in outline, step 8 unchecked | minds:  | verdict: as stated.
- needs: FS106-L
- statement: 
- uses: 
- not claimed: 
- handoff/kernel: declined.
- dependents (index, direct/transitive): 1/10

### row 10 — FS106-TW (upstream; plans/FS106-derivation.md:67)
- grade: hand; "no proof": three readers (V, VB, V3); the lemma one mind in general (V3), two on a one-sided annulus (VB blind); the manuscript one mind (V3); the fill in outline | minds:  | verdict: as stated.
- needs: FS106-L, FS106-WO
- statement: 
- uses: 
- not claimed: 
- handoff/kernel: declined until the fill is walked.
- dependents (index, direct/transitive): 1/9

### row 11 — FS106-AE-MAP6 (upstream; plans/FS106-derivation.md:121)
- grade: hand; one mind per link: TS (the reduction to Townsend's annulus lemma), V3 (the lemma and Thms 1–2 region-only); the fill in outline | minds:  | verdict: TRUE modulo the named fill.
- needs: FS106-TS-T, FS106-TW
- statement: 
- uses: 
- not claimed: 
- handoff/kernel: declined.
- dependents (index, direct/transitive): 3/8

### row 12 — FS111-C-FILL (SEED; plans/FS111-derivation.md:252)
- grade: hand | minds: 2 — blind to: FS111-P's stage 5 until V0's verdicts were committed; method: the same measure estimate (a third reading,  … | verdict: derived
- needs: 
- statement: if x is j-free with |S̃_j ∩ A_η(x)| = 0, the fill move on B(x, η/2) with colour j keeps the colouring a.e.-proper with k colours
- uses: x ∈ A*_j forces η < 1; the Leb ⊗ σ measure of unit pairs into the null set S_j ∩ A_η(x) is 0; other classes only lose points
- not claimed: that fills saturate (fills create no contact for the filled colour, FS111-W-FILL-FREE)
- handoff/kernel: de Bruijn — queued behind the measurable chain: a short measure estimate once D-NF is in Lean
- dependents (index, direct/transitive): 3/19

### row 13 — FS111-C-HULL-SO (upstream; plans/FS111-derivation.md:282)
- grade:  | minds:  | verdict: refuted: the tight hexagonal seven-colouring by hexagons of circumradius 1/2 col …
- needs: 
- statement: the claim list's "so": A*_j ⊆ {x : sup_{c∈C}|x − c| < 1} ∪ {x : dist(x, C) > 1} for every path-connected C ⊆ S̃_j
- uses: 
- not claimed: 
- handoff/kernel: 
- dependents (index, direct/transitive): 1/78

### row 14 — FS111-M-R7 (SEED; plans/FS111-derivation.md:347)
- grade: computed over: one fundamental domain of Λ, 7 classes, exact in ℚ(√3), with the hand reduction of the plane to it | minds: 2 — blind to: FS111-M's record until VMW's verdicts were committed (3ea1d5ab); method: M by two distance engines agreein … | verdict: derived
- needs: 
- statement: R7 — Reuleaux triangles of width 1 on the up triangles of the unit triangular lattice Λ, coloured by the four cosets of 2Λ, and the cusped down triangles coloured by the three cosets of M = ⟨(0, √3), (3/2, √3/2)⟩ — is a.e.-proper, tight and saturated (every essential boundary point is a contact point for each of its colours); every boundary is a unit arc centred at a lattice point that carries both its side colours
- uses: exact arithmetic in ℚ(√3) on one fundamental domain of Λ; the reduction of the plane's distance conditions to finitely many tile pairs by periodicity; every same-colour critical distance ≥ 1 (216 pairs)
- not claimed: saturation with partners of positive density (FALSE at the down arcs, FS111-VMW-R7-PPLUS); any six-colour analogue
- handoff/kernel: de Bruijn — a periodic tiling in ℚ(√3) with an exact certificate; kernel-checkable now, not urgent (a control object)
- dependents (index, direct/transitive): 2/4

### row 15 — FS111-M-SATC (SEED; plans/FS111-derivation.md:316)
- grade: hand | minds: 1 — FS111-M (FS111-M2-COV re-reads it, sighted) | verdict: derived
- needs: FS111-C-FILL
- statement: every a.e.-proper k-colouring lies below a maximal admissible cover (k measurable sets with null unit pairs, maximal under inclusion up to null sets, union of full measure), and every maximal cover's supports satisfy ℝ² = int F_j ∪ (F_j + S¹) for each j; a selection from a maximal cover is an a.e.-proper k-colouring
- uses: Zorn's lemma on admissible covers ordered by a.e. inclusion (chains have measurable unions up to null sets); I-D1 for the shadow identity
- not claimed: that a selection is saturated (FS111-M2-NOSEL); that the classes are regular (FS111-M3-IRREG)
- handoff/kernel: de Bruijn — queued behind the measurable chain: Zorn on admissible covers is short once a.e.-properness is in Lean
- dependents (index, direct/transitive): 5/15

### row 16 — FS111-M2-COV (SEED; plans/FS111-derivation.md:816)
- grade: hand | minds: 1 — FS111-M2 | verdict: derived
- needs: FS111-M-SATC
- statement: a k-tuple of measurable sets is a maximal admissible cover iff each coordinate is a MUA set and their union has full measure
- uses: the definitions; maximality of a cover is maximality of each coordinate separately, since enlarging one class never touches another's unit pairs
- not claimed: that a maximal cover's classes are regular (FS111-M3-IRREG) or disjoint (DISC7 has lenses)
- handoff/kernel: de Bruijn — queued behind the measurable chain, with FS111-M-SATC
- dependents (index, direct/transitive): 3/6

### row 17 — FS111-M2-DISC7 (upstream; plans/FS111-derivation.md:881)
- grade: computed over: one period of the hexagonal lattice, 7 discs, exact rational bounds in ℚ(√3) | minds: 2 — blind to: M2's record until VM2's verdicts were committed; method: M2 by hand and a 2,173-point exact grid, VM2 by e … | verdict: derived
- needs: 
- statement: the circumscribed discs of the tight hexagonal seven-colouring (radius 1/2, centred at the hexagon centres, coloured as the hexagons) form a maximal admissible seven-cover with regular classes whose overlaps (lenses) have positive measure; each class has density 2π/(21√3), the seven summing to Kershner's thinnest-covering density 2π/(3√3)
- uses: the discs pass through the hexagon vertices (cover); same-colour centres √21/2 apart (admissible); for 1/2 < |z − c| < 3/2 the circle T₁(z) crosses the disc (maximal); exact rational bounds
- not claimed: that its selections are saturated (FS111-M2-NOSEL); curvature of class boundaries ≤ 1 (it is 2)
- handoff/kernel: none — a control object; exact and periodic, formalizable on demand
- dependents (index, direct/transitive): 4/11

### row 18 — FS111-M2-ZERO (SEED; plans/FS111-derivation.md:833)
- grade: hand | minds: 1 — FS111-M2 | verdict: derived
- needs: 
- statement: a measurable A is a MUA set iff A = {φ_A = 0} a.e., where φ_A(p) = σ{w ∈ S¹ : p + w ∈ A}: unit-avoiding is φ_A = 0 a.e. on A, maximal is φ_A > 0 a.e. off A (a measurable independent dominating set of the unit-distance graph)
- uses: Fubini on Leb ⊗ σ; maximality tested one point-neighbourhood at a time
- not claimed: that {φ_A = 0} is closed or regular
- handoff/kernel: de Bruijn — queued behind the measurable chain
- dependents (index, direct/transitive): 4/21

### row 19 — FS111-V0-CLOSE (upstream; plans/FS111-derivation.md:53)
- grade: hand | minds: 1 — FS111-V0 | verdict: derived
- needs: 
- statement: in a D-AEMAP-proper map, a closure point of a colour-j region is never at distance 1 from an open colour-j point
- uses: D-AEMAP; openness of regions; continuity of the distance
- not claimed: anything about boundary points of different colours
- handoff/kernel: none — a one-line lemma used by FS111-V0-CLEAN and VM2-FACE; crosses with them
- dependents (index, direct/transitive): 2/11

### row 20 — FS111-V0-CLEAN (upstream; plans/FS111-derivation.md:37)
- grade: hand | minds: 1 — FS111-V0 | verdict: derived
- needs: FS111-V0-CLOSE
- statement: the limit tiling W-EQ-K produces (a full tight a.e.-proper six-colouring by closed tiles of complexity at most K) can be cleaned — equal colours merged, slits and degree-2 vertices erased, islands filled — into an S–V map-type colouring (Conditions 2–4) bounded by segments and circular arcs, a.e.-proper (D-AEMAP), with at most six colours
- uses: W-EQ-K's output (tiles bounded by at most K arcs or segments, at most K tiles per unit disc); FS111-V0-CLOSE; Townsend's island fill
- not claimed: that the cleaned map has no unit arcs (row 134 or FS-114 decides which NO applies)
- handoff/kernel: none — a routine cleaning step inside FS111-C1-PW; it crosses with that entry if the chain is formalized
- dependents (index, direct/transitive): 2/7

### row 21 — FS111-C1-PW (upstream CYCLE; plans/FS111-derivation.md:67)
- grade: derived from: FS111-V0-CLEAN | minds: 2 — blind to: FS111-P's stage 2 until V0's verdicts were committed; method: V0 made the cleaning step explicit (V0-CLEAN … | verdict: derived
- needs: FS111-C1-UNIF, FS111-V0-CLEAN
- statement: Q-NO ⟹ δ₀(K) > 0 for every K
- uses: W-EQ-K (⟹; two minds, one blind); FS111-V0-CLEAN; row 134 for maps with no unit arc and FS-114's NO for maps with one (the premise Q-NO)
- not claimed: any lower bound on δ₀(K) uniform in K; FS-114's NO itself
- handoff/kernel: none — conditional on FS-114's NO, which is open; it crosses with the NO if the NO lands
- dependents (index, direct/transitive): 3/3

### row 22 — FS111-C1-UNIF (SEED CYCLE; plans/FS111-derivation.md:18)
- grade: hand | minds: 2 — blind to: FS111-P's stages 2 and 5 until V0's verdicts were committed (08c4d8f3); method: V0 rasterised by pixelatio … | verdict: derived
- needs: FS106-SUP, FS111-C1-PW
- statement: 1 − lim_{ε→0} µ₆(ε) = inf_K δ₀(K); hence χ_m⁰(ℝ²) ≥ 7 ⟺ inf_K δ₀(K) > 0
- uses: H-EQ (row 131) and FS106-SUP's periodic attainment; the rasterisation of a periodic partial colouring into closed cells (density threshold, or V0's pixelation with slack loss 3h); that 𝓜_K is non-decreasing in K; the equivalence needs only H-EQ as quoted
- not claimed: any value of inf_K δ₀(K); that δ₀(K) is attained; that δ₀ tends to 0 or not
- handoff/kernel: de Bruijn — queued behind the measurable chain (FS-113, FS-101): the statement with µ₆ and 𝓜_K defined; no Lean object for either yet
- dependents (index, direct/transitive): 2/3

### row 23 — FS111-V0-ID1 (SEED; plans/FS111-derivation.md:296)
- grade: hand | minds: 1 — FS111-V0 (FS-103's D1 is a second derivation of the tight case; whether V0 saw it first is not recorded, so it is no … | verdict: derived
- needs: 
- statement: I-D1 holds for every a.e.-proper measurable colouring: if y ∈ S̃_j and d̄_j(x) > 0 then |x − y| ≠ 1
- uses: Lebesgue density at y; a positive-density neighbourhood of x meeting unit circles about a full-density disc at y in positive measure
- not claimed: anything at points of density 0
- handoff/kernel: de Bruijn — queued behind the measurable chain
- dependents (index, direct/transitive): 3/84

### row 24 — FS111-C-HULL (SEED; plans/FS111-derivation.md:267)
- grade: hand | minds: 2 — blind to: FS111-P's stage 5 until V0's verdicts were committed; method: the same interval argument; M re-derived it  … | verdict: derived
- needs: FS111-C-HULL-SO, FS111-V0-ID1
- statement: in a tight a.e.-proper k-colouring in D-NF, for C ⊆ S̃_j path-connected and x ∈ A*_j, either |x − c| < 1 for every c ∈ C or |x − c| > 1 for every c ∈ C; the form with sup_{c∈C}|x − c| < 1 or dist(x, C) > 1 holds when C is compact
- uses: I-D1 in V0's form (FS111-V0-ID1: |x − c| ≠ 1 for c ∈ S̃_j, x ∈ A*_j); continuity of c ↦ |x − c| on a path-connected C
- not claimed: A*_j ⊆ {x : sup_{c∈C}|x − c| < 1} ∪ {x : dist(x, C) > 1} for non-compact C — refuted (FS111-C-HULL-SO)
- handoff/kernel: de Bruijn — queued behind the measurable chain, with FS111-V0-ID1
- dependents (index, direct/transitive): 6/77

### row 25 — FS111-M-COVER-SC (upstream; plans/FS111-derivation.md:534)
- grade: derived from: FS111-M-SATC, FS111-C-HULL | minds: 1 — FS111-M (FS111-M2-HULLC extends it, sighted; VM2 blind on HULLC) | verdict: derived
- needs: FS111-C-HULL, FS111-M-SATC
- statement: in a maximal cover, at every boundary point of F_a each adjacent path-connected piece of F̃_a lies in an enclosing unit disc or outside an exterior one; where ∂F_a is locally the graph of a continuous function with F_a below it, that function is semiconcave with constant 1
- uses: FS111-M-SATC's shadow identity; FS111-C-HULL's first clause
- not claimed: semiconvexity (FALSE on covers: DISC7, curvature 2)
- handoff/kernel: none — superseded by FS111-M2-HULLC's fuller form; crosses with it
- dependents (index, direct/transitive): 1/4

### row 26 — FS111-M-HALF (upstream; plans/FS111-derivation.md:549)
- grade: derived from: FS111-C-HULL | minds: 1 — FS111-M | verdict: derived
- needs: FS111-C-HULL
- statement: at a point x saturated for j, every path-connected piece of S̃_j with x in its closure lies in a closed half-plane in every blow-up at x, so has upper density at most 1/2 at x: no colour takes a reflex angle at a saturated point
- uses: FS111-C-HULL's first clause at the contact of x; the blow-up of a unit disc at a boundary point is a half-plane
- not claimed: that the pieces' blow-ups are sectors (a cone structure at x is REG-J′'s content)
- handoff/kernel: none — a structural lemma toward REG-J′
- dependents (index, direct/transitive): 4/6

### row 27 — FS111-M-HULL2 (upstream; plans/FS111-derivation.md:579)
- grade: derived from: FS111-C-HULL | minds: 2 — blind to: M's record until VMW's verdicts were committed; method: VMW's component form in VMW-BLOCK-EQ ("linked or a … | verdict: derived
- needs: FS111-C-HULL
- statement: two path-connected pieces of one class of an a.e.-proper colouring have all cross distances < 1 or all > 1
- uses: FS111-C-HULL's first clause at each point of one piece (density points of a path-connected piece); path-connectedness of the other
- not claimed: that "near" (all < 1) is transitive (that is tight block structure, FS111-M-BLOCK-EQ)
- handoff/kernel: none — a lemma inside FS111-M-BLOCK-EQ
- dependents (index, direct/transitive): 5/63

### row 28 — FS111-M-PINCH (SEED CYCLE; plans/FS111-derivation.md:435)
- grade: derived from: FS111-C-HULL | minds: 3 — blind to: each other's records (M and W, competitors; VMW before 3ea1d5ab); method: M by M-HULL1 at density points ( … | verdict: derived
- needs: FS111-C-HULL, FS111-V0-ID1, FS121-D4-HOLE
- statement: at a saturated point x of an honest a.e.-proper colouring with a neighbourhood N in which only two colours a, b have positive measure and each is a.e. one connected open set of density points (H1, H2): either N is split by one unit circle T₁(y) with a inside and b outside or the reverse, y a contact of both colours, or two open unit discs tangent at x from opposite sides lie a.e. in S_a and in S_b; the case (in, in) is impossible; no positive density of the partner is needed
- uses: FS111-C-HULL's first clause applied at density points q_n ∈ S̃_a converging to the partner y_a, then the closed-disc limit; (H1); (H2); saturation at x
- not claimed: the same without (H1) or (H2) (C-HULL-REG as stated is a GAP there); anything at points of the singular set Σ
- handoff/kernel: de Bruijn — queued behind the measurable chain: the central lemma of route M, with (H1), (H2) stated and its not-claimed line kept
- dependents (index, direct/transitive): 18/60

### row 29 — FS121-D4-HOLE (upstream CYCLE; plans/FS121-derivation.md:951)
- grade: hand | minds: 1 | verdict: derived
- needs: FS111-M-HULL2, FS111-M-PINCH
- statement: in an honest saturated colouring in D-NF, if a region D (a component of the interior of the density set of one colour) has a bounded complementary component K of its closure, then every point of ∂K lies in Σ; so Σ contains a non-degenerate continuum, and a colouring whose Σ is locally finite has no region with a hole
- uses: FS111-M-PINCH at a point off Σ (both types); C-HULL's first clause at the contact; FS111-M-HULL2 (diam D ≤ 1); a bounded complementary component lies in the convex hull; the definition of Σ
- not claimed: that a region with a hole exists or not; anything about unbounded complementary components; REG-J′ (unused)
- handoff/kernel: none — a structural no-go between open statements; it crosses with FS111-M-PINCH
- dependents (index, direct/transitive): 1/60

### row 30 — FS111-M-C11 (SEED; plans/FS111-derivation.md:455)
- grade: derived from: FS111-M-PINCH | minds: 3 — blind to: each other's records, as FS111-M-PINCH; method: M from PINCH; W as W-C11 with H-DEN; VMW as VMW-HULL | verdict: derived
- needs: FS111-M-PINCH
- statement: if M-PINCH's hypotheses hold at every essential boundary point in N, then ∂_e S_a ∩ N′ (N′ ⋐ N) is a C^{1,1} curve with curvature in [−1, 1] and unit-parallel partners on both sides; a single unit arc if any of its points is of the split type
- uses: FS111-M-PINCH at every point; the two-sided unit-ball condition gives C^{1,1} with |κ| ≤ 1 (classical)
- not claimed: that the curve is a segment or a circular arc (REG-A's missing rung, FS111-M2-INTRAD under REG-J′); "curvature 1 exactly on arcs of kind both" (W-CURV's "exactly", not derived)
- handoff/kernel: de Bruijn — with FS111-M-PINCH; the rolling-ball step would need its own formal proof or a Mathlib source
- dependents (index, direct/transitive): 23/52

### row 31 — FS111-M2-INT (SEED; plans/FS111-derivation.md:850)
- grade: derived from: FS111-V0-ID1 | minds: 2 — blind to: M2's record until VM2's verdicts were committed (00fd646f); method: VM2-INT by the r³ measure of unit pair … | verdict: derived
- needs: FS111-V0-ID1
- statement: for every a.e. unit-avoiding A, the topological interior of its density set, int Ã, contains no point at distance exactly 1 from cl Ã
- uses: FS111-V0-ID1 (I-D1); full-density discs about interior points
- not claimed: the same for the interior of the support F of a set with null unit pairs (a GAP under the topological reading of "regular", VM2 (O2))
- handoff/kernel: de Bruijn — queued behind the measurable chain
- dependents (index, direct/transitive): 3/20

### row 32 — FS111-M2-FIX (SEED CYCLE; plans/FS111-derivation.md:864)
- grade: derived from: FS111-M2-INT, FS111-M2-ZERO | minds: 2 — blind to: M2's record until VM2's verdicts were committed; method: VM2 from VM2-INT and maximality (VM2 § 2.2) | verdict: derived
- needs: FS111-C-HULL, FS111-M2-INT, FS111-M2-ZERO, FS111-M3-FIXCONV
- statement: a regular MUA set A satisfies the shadow identity int F = ℝ² ∖ (F + S¹), F = supp A: every unit circle centred in F misses int F, and every component of int F lies inside or outside each such circle
- uses: FS111-M2-INT (no interior point on a unit circle about F); FS111-M2-ZERO (maximality: almost every point off A has φ_A > 0); regularity (|∂F| = 0) to pass from a.e. to every point
- not claimed: the converse (a regular set satisfying the identity need not be maximal: FS111-M3-FIXCONV)
- handoff/kernel: de Bruijn — queued behind the measurable chain: the identity route M's cover form rests on
- dependents (index, direct/transitive): 5/14

### row 33 — FS111-M3-BAND (upstream CYCLE; plans/FS111-derivation.md:1255)
- grade: derived from: FS111-M2-FIX | minds: 1 — FS111-M3 | verdict: derived
- needs: FS111-M2-FIX
- statement: a flat side of a block of diameter ≤ 1 in a MUA set needs material of its class at distance exactly 1 over the middle half of the side; a band of length λ excludes its own horns out to λ and is unit-free only if λ ≤ 1; a side of length 1 with its band at distance 1 is excluded exactly by an apex at depth √3/2, tight at one point
- uses: FS111-M2-FIX's shadow identity at points facing the side; elementary distances
- not claimed: anything about curved sides (constant-width blocks carry no band)
- handoff/kernel: none — design facts for HC
- dependents (index, direct/transitive): 1/14

### row 34 — FS111-M3-FIXCONV (upstream CYCLE; plans/FS111-derivation.md:1241)
- grade: derived from: FS111-M3-IRREG | minds: 1 — FS111-M3 | verdict: derived
- needs: FS111-M3-IRREG
- statement: the converse of FS111-M2-FIX fails: F_f is regular with int F = ℝ² ∖ (F + S¹) and its interior is not maximal
- uses: FS111-M3-IRREG's A_f
- not claimed: anything about maximal sets
- handoff/kernel: none — a scope marker for FS111-M2-FIX
- dependents (index, direct/transitive): 1/14

### row 35 — FS111-M3-HC (upstream CYCLE; plans/FS111-derivation.md:1129)
- grade: computed over: the critical configurations of one period of the honeycomb, exact in ℚ(√3), with the hand reduction to them | minds: 1 — FS111-M3 (../tools/fs111_m3_honey.py: six checks, five plants firing) | verdict: derived
- needs: FS111-M2-FIX, FS111-M3-BAND
- statement: the honeycomb class HC — equilateral triangles of side 1 at the vertices of a honeycomb of edge 2 + √3/3, pointing at the face centres; on each edge a band of length 1 at distance 1 from both facing sides, of thickness in [0, g] vanishing exactly on a closed null set Z ∋ ±1/2; discs of radius 1/2 at the face centres — is a regular MUA set satisfying FS111-M2-FIX, for every gap function with (G1)'s bounds; with Z a Cantor set (HC_K) each band has one interior component per gap
- uses: FS111-M3-BAND (a flat side needs its class at distance exactly 1 over its middle half; a band of length 1 excludes its horns); exact checks in ℚ(√3) of unit-avoidance and maximality at the finitely many critical configurations
- not claimed: that HC_K is a class of any partition (FS111-M4-HC: it fits none with an ordinary ladder through three rungs); any colour count
- handoff/kernel: none — a counterexample to a universal form; exact, formalizable on demand
- dependents (index, direct/transitive): 5/14

### row 36 — FS111-M3-IRREG (upstream CYCLE; plans/FS111-derivation.md:1225)
- grade: hand | minds: 1 — FS111-M3 | verdict: derived
- needs: FS111-M3-HC
- statement: with a fat Cantor set Z_f, A_f = int HC(g_f) is unit-avoiding, regular and satisfies the shadow identity, but is not maximal, and every MUA set containing it has |∂ supp| > 0; so "every MUA set is regular" (MUA-REG-U) is false
- uses: a pinch set of positive length makes a positive-measure set of points whose unit circles touch the class only at pinch points (excluded in closure, free in measure); maximality must add them, and they form a nowhere dense set
- not claimed: that no maximal cover can be modified into one with regular classes (MUA-REG-P is open)
- handoff/kernel: none — a no-go for a universal form
- dependents (index, direct/transitive): 1/14

### row 37 — FS111-M2-HULLC (SEED; plans/FS111-derivation.md:907)
- grade: derived from: FS111-M2-FIX, FS111-C-HULL | minds: 2 — blind to: M2's record until VM2's verdicts were committed; method: VM2-HULLC (exterior radius 1 per component; M2 us … | verdict: derived
- needs: FS111-C-HULL, FS111-M-COVER-SC, FS111-M-PINCH, FS111-M2-DISC7, FS111-M2-FIX
- statement: in a maximal cover with regular classes, every component of int F_j lies inside or outside every unit circle centred at a point of F_j and has an exterior ball of radius 1 at every boundary point; where the boundary is a graph it is semiconcave with constant 1; each component has finite perimeter; near any point int F ∩ B(x, r) = B(x, r) ∖ ⋃_{p ∈ F_x} T₁(p), and where F_x has finitely many components the boundary lies on the unit parallels (outer and far) of the class's own components; on the pinch set of two classes FS111-M-PINCH and FS111-M-C11 hold verbatim
- uses: FS111-M2-FIX; FS111-C-HULL's first clause; a classical finite-perimeter criterion for exterior-ball sets (Federer GMT 4.5.11, cited unread)
- not claimed: semiconvexity with constant 1 (FALSE: DISC7, curvature 2); the unit-parallel description without "F_x has finitely many components"
- handoff/kernel: de Bruijn — queued behind the measurable chain; the finite-perimeter step needs Federer 4.5.11 or a Mathlib substitute
- dependents (index, direct/transitive): 1/3

### row 38 — FS111-V0-RESCALE (SEED; plans/FS111-derivation.md:175)
- grade: hand | minds: 1 — FS111-V0 | verdict: derived
- needs: 
- statement: if an a.e.-proper measurable k-colouring of ℝ² exists, a tight one exists (rescale by 1 ± ε*, ε* the supremum of the slacks); so a tight a.e.-proper k-colouring exists iff χ_m⁰(ℝ²) ≤ k
- uses: D-SLACK; that dilation by 1 + ε maps a colouring with slack ε to one proper at the band's edge; the converse is immediate (a tight colouring is an a.e.-proper one)
- not claimed: that every a.e.-proper colouring is tight
- handoff/kernel: de Bruijn — queued behind the measurable chain (FS-113): a short lemma with D-SLACK and a.e.-properness defined
- dependents (index, direct/transitive): 7/13

### row 39 — FS111-C-SIX-M (upstream; plans/FS111-derivation.md:207)
- grade: derived from: FS111-V0-RESCALE | minds: 2 — blind to: FS111-P's stage 5 until V0's verdicts were committed; method: as FS111-C-SEVEN-M | verdict: derived
- needs: FS106-AE-MAP6, FS111-V0-RESCALE
- statement: FS106-AE-MAP6 ∧ REG-I₅ ⟹ χ_m⁰(ℝ²) ≥ 6; given MR (row 130), χ(ℝ²) ≥ 6
- uses: FS111-V0-RESCALE; FS106-AE-MAP6 at its grade (one mind per link, the fill in outline, modulo Townsend's (c)); row 130 for the MR clause
- not claimed: REG-I₅; FS106-AE-MAP6 beyond its grade
- handoff/kernel: none — a composition of open statements; it crosses with them
- dependents (index, direct/transitive): 2/4

### row 40 — FS111-M2-REDUCE-C (SEED; plans/FS111-derivation.md:973)
- grade: derived from: FS111-M2-INT, FS111-V0-CLOSE, FS111-V0-RESCALE | minds: 2 — blind to: M2's record until VM2's verdicts were committed; method: VM2-FACE, step by step, adding the island fill an … | verdict: derived
- needs: FS106-AE-MAP6, FS111-C-SIX-M, FS111-M-R7, FS111-M-SATC, FS111-M2-COV, FS111-M2-INT, FS111-V0-CLOSE, FS111-V0-RESCALE
- statement: if some maximal k-cover has regular classes whose boundaries form a locally finite plane graph (finitely many Jordan arcs in each bounded set, meeting only at endpoints: REG-J′-C_k), then REG-I_k holds; at k = 5, with FS106-AE-MAP6, χ_m⁰(ℝ²) ≥ 6, hence χ(ℝ²) ≥ 6 given MR
- uses: faces of the arrangement coloured by a class whose interior contains them (VM2-FACE steps 1–6); merged points lie in int F_j; the island fill; FS111-M2-INT and FS111-V0-CLOSE for D-AEMAP; FS111-V0-RESCALE; FS106-AE-MAP6 at its grade (one mind per link, the fill in outline)
- not claimed: REG-J′-C₅ itself; the statement with "a finite union of Jordan arcs" in place of "meeting only at endpoints" (M2 §2.3's wording, MISSTATED); that it makes the five-colour question smaller (FS111-VM2-EQ5)
- handoff/kernel: de Bruijn — queued behind the measurable chain and FS106-AE-MAP6's formalization (Townsend's (c), FS-108)
- dependents (index, direct/transitive): 2/2

### row 41 — FS111-W-KB-DIR (upstream; plans/FS111-derivation.md:677)
- grade: derived from: FS111-M-PINCH | minds: 1 — FS111-W | verdict: derived
- needs: FS111-M-PINCH
- statement: at the centre of a unit arc of kind both in a saturated colouring, the inner colour's sector points toward the arc
- uses: FS111-M-PINCH's split case; the partner at the centre carries both colours
- not claimed: anything at an arc of kind in or out
- handoff/kernel: none — a local rule for saturated maps
- dependents (index, direct/transitive): 1/4

### row 42 — FS111-W-NOBEND (upstream; plans/FS111-derivation.md:471)
- grade: derived from: FS111-M-C11 | minds: 2 — blind to: W's record until VMW's verdicts were committed; method: W as corollaries of W-C11, VMW from the common for … | verdict: derived
- needs: FS111-M-C11
- statement: a saturated two-colour interface under (H1), (H2) has no bend (corner), and its curvature is at most 1
- uses: FS111-M-C11
- not claimed: that curvature equals 1 only on arcs of kind both (a case-(i) unit arc about an a-contact with b inside is locally consistent)
- handoff/kernel: none — a corollary; it crosses with FS111-M-C11
- dependents (index, direct/transitive): 3/7

### row 43 — FS111-W-NOREP (upstream; plans/FS111-derivation.md:485)
- grade: derived from: FS111-M-C11 | minds: 1 — FS111-W (read sighted by VMW, who scoped it to maps) | verdict: derived
- needs: FS111-M-C11, FS111-W-KB-DIR
- statement: at a cone vertex of a saturated map without cusps, no colour occupies two sectors
- uses: FS111-M-C11 applied at the partner points y_a(p) of interface points p near the vertex, where (H2) holds for all but finitely many p on a map
- not claimed: the same for general saturated colourings (GAP: (H2) at the partners is not among C11's hypotheses there)
- handoff/kernel: none — a lemma inside FS111-W-HULLREG-MAPS; it crosses with it
- dependents (index, direct/transitive): 2/3

### row 44 — FS111-W-SQ9 (upstream; plans/FS111-derivation.md:648)
- grade: computed over: one period of the square lattice (9 classes), exact rationals | minds: 2 — blind to: W's record until VMW's verdicts were committed; method: W's checker ../tools/fs111_w_check.py, VMW's own c … | verdict: derived
- needs: 
- statement: the colouring of the plane by closed squares of side 1/2, square (i, j) coloured (i mod 3, j mod 3), is a.e.-proper, tight and saturated, also with positive-density partners (every edge faces a same-colour edge at distance exactly 1)
- uses: same-colour squares at offsets (3a/2, 3b/2); exact distances of facing edges
- not claimed: saturation below nine colours on square tilings (FS111-W-HEXSAT's hexagonal analogue)
- handoff/kernel: none — a control object; exact and periodic, formalizable on demand
- dependents (index, direct/transitive): 2/31

### row 45 — FS111-M2-INTRAD (SEED CYCLE; plans/FS111-derivation.md:1007)
- grade: derived from: FS111-M-C11 | minds: 2 — blind to: M2's record until VM2's verdicts were committed; method: (i)–(ii) by two routes; (iii) completed by VM2 al … | verdict: derived
- needs: FS111-M-C11, FS111-W-SQ9, FS121-DB1-L6
- statement: in an honest saturated colouring whose singular set Σ is locally finite with finitely many interface arcs at each point (REG-J′), the unit parallel of every tangent-type interface arc is again an interface arc, so radii of curvature drop by exactly 1 toward the centre and stop at 1: every interface has integer radius of curvature almost everywhere and is locally a chain of segments and circular arcs, finitely many of each radius
- uses: FS111-M-C11 off Σ; (i) the near side of the parallel has density 0 for the partner colour (M2 from I-D1 and (H2); VM2 from M-HULL1); (ii) the parallel is an interface; (iii) finiteness per radius by VM2-FIN′ (the n-th inner parallel carries each gap to an interface curve starting at one of finitely many centres in Σ; REG-J′'s second clause bounds the gaps)
- not claimed: exclusion of large-radius accumulation (radii → ∞: LRA, FS-115's stuck ray); the statement without REG-J′'s finitely-many-arcs clause
- handoff/kernel: de Bruijn — queued behind FS111-M-PINCH and FS111-M-C11: the link between route M and FS-115
- dependents (index, direct/transitive): 16/27

### row 46 — FS121-DB1-L6 (upstream CYCLE; plans/FS121-derivation.md:192)
- grade: hand | minds: 1 | verdict: derived
- needs: FS111-M-PINCH, FS111-M2-INTRAD
- statement: in an honest saturated colouring in D-NF satisfying REG-J′, the chain of unit parallels of an interface arc of finite radius toward its centre ends, off finitely many normals, at a unit arc whose centre carries that arc's outer colour
- uses: FS111-M2-INTRAD step (1); FS111-M-PINCH's two types; REG-J′'s local finiteness (each point of Σ but the centre on one normal)
- not claimed: which kind the last arc is (FS121-O1-ENDS)
- handoff/kernel: none — a re-derivation inside C121-ENDS's verification; it crosses with FS111-M2-INTRAD
- dependents (index, direct/transitive): 1/27

### row 47 — FS112-A4SIX (upstream; plans/FS112-derivation.md:61)
- grade: hand; three minds, one blind: A4; N; NB | minds:  | verdict: TRUE. On the strip its hypothesis is vacuous in the union sense and met in the d …
- needs: 
- statement: 
- uses: 
- not claimed: 
- handoff/kernel: stub — with FS-114.
- dependents (index, direct/transitive): 2/42

### row 48 — FS112-BOWTIE (upstream; plans/FS112-derivation.md:355)
- grade: tools, exact; one fragment: YB3; one checker, YB2's tower checker; stuckness exact at the antipodes and at named points | minds:  | verdict: TRUE locally; a fragment, not a map. It refutes Y3-END-NEEDS as Y3 stated it, an …
- needs: 
- statement: 
- uses: 
- not claimed: 
- handoff/kernel: declined — an exact fragment; FS-115 may promote it.
- dependents (index, direct/transitive): 1/19

### row 49 — FS112-BUDGET2 (upstream; plans/FS112-derivation.md:292)
- grade: tools, exact; the union sense two minds, one blind: Y; YB; the disjoint sense one: Y2 | minds:  | verdict: FALSE as stated; consistent with FS112-NB4P, whose escape (α) holds at `A_0`.
- needs: 
- statement: 
- uses: 
- not claimed: 
- handoff/kernel: declined.
- dependents (index, direct/transitive): 1/42

### row 50 — FS112-C-DOUBLE (upstream; plans/FS112-derivation.md:235)
- grade: hand; one mind: FS112-C2, a sketch over FS112-Y3-END-NEEDS's levels with n reversed and FS112-N2-TERM | minds:  | verdict: TRUE at one mind, a sketch; the mixed source case (one horn's `g`-shadow from ea …
- needs: FS112-BOWTIE
- statement: 
- uses: 
- not claimed: 
- handoff/kernel: stub — with FS-115.
- dependents (index, direct/transitive): 1/18

### row 51 — FS112-DISC1 (upstream; plans/FS112-derivation.md:124)
- grade: hand; two minds: N2's sketch; NB2's proof | minds:  | verdict: TRUE.
- needs: 
- statement: 
- uses: 
- not claimed: 
- handoff/kernel: stub — with FS-114.
- dependents (index, direct/transitive): 2/19

### row 52 — FS112-FLANK (upstream; plans/FS112-derivation.md:97)
- grade: hand; two minds: N, blind to NB; NB sighted, after its stage 1 had "survives" | minds:  | verdict: TRUE — the round-1 reversal went the side's way.
- needs: 
- statement: 
- uses: 
- not claimed: 
- handoff/kernel: stub — with FS-114.
- dependents (index, direct/transitive): 2/21

### row 53 — FS112-ISO (upstream; plans/FS112-derivation.md:80)
- grade: hand; two minds: NB; N2 conceding | minds:  | verdict: TRUE; it refuted N's l. 231 and exposed a GAP in N112-RED that N had not named — …
- needs: 
- statement: 
- uses: 
- not claimed: 
- handoff/kernel: declined — a local example.
- dependents (index, direct/transitive): 1/19

### row 54 — FS112-LOCK (upstream; plans/FS112-derivation.md:70)
- grade: hand; two minds, one blind, different routes: N; NB; the outer colour's exclusion at radius 2 tools exact | minds:  | verdict: TRUE. N's sentence "its 'finitely many isolated contact points' do not exist in  …
- needs: 
- statement: 
- uses: 
- not claimed: 
- handoff/kernel: stub — with FS-114.
- dependents (index, direct/transitive): 2/20

### row 55 — FS112-BEND (upstream; plans/FS112-derivation.md:75)
- grade: hand; two minds, one blind: N; NB | minds:  | verdict: TRUE off end vertices (their GAP closed by FS112-N2-BENDS). Answers **ARC-INERT: …
- needs: FS112-LOCK
- statement: 
- uses: 
- not claimed: 
- handoff/kernel: stub — with FS-114.
- dependents (index, direct/transitive): 1/18

### row 56 — FS112-N2-BENDS (upstream; plans/FS112-derivation.md:85)
- grade: hand; two minds, one blind: N2; NB2; N2-TOWARD by different routes; identities tools exact | minds:  | verdict: TRUE; NB2-SIGN adds that the dichotomy is for open-tile points (an R2 contact is …
- needs: FS112-ISO, FS112-LOCK
- statement: 
- uses: 
- not claimed: 
- handoff/kernel: stub — with FS-114.
- dependents (index, direct/transitive): 2/18

### row 57 — FS112-N2-FLANK-Q (upstream; plans/FS112-derivation.md:106)
- grade: hand; two minds, one blind: N2; NB2, sighted on the one-arc clause | minds:  | verdict: TRUE.
- needs: FS112-FLANK
- statement: 
- uses: 
- not claimed: 
- handoff/kernel: stub — with FS-114.
- dependents (index, direct/transitive): 2/19

### row 58 — FS112-N2-RAY (upstream; plans/FS112-derivation.md:110)
- grade: hand; two minds, one blind: N2; NB2; the pencil one mind, NB2; RAY exact | minds:  | verdict: TRUE. FIN as a statement about bi-infinite sequences in `(−1, 1)` is untouched;  …
- needs: FS112-FLANK
- statement: 
- uses: 
- not claimed: 
- handoff/kernel: stub — with FS-114.
- dependents (index, direct/transitive): 1/18

### row 59 — FS112-N3-ANTI (upstream; plans/FS112-derivation.md:151)
- grade: hand; two minds, one blind, different routes: N3; NB3; tools exact, ANTI | minds:  | verdict: TRUE; CE5's step "at an M-in point the strip's majority side is outside" is not  …
- needs: 
- statement: 
- uses: 
- not claimed: 
- handoff/kernel: stub — with FS-114.
- dependents (index, direct/transitive): 1/18

### row 60 — FS112-N3-FAIL (upstream; plans/FS112-derivation.md:146)
- grade: hand; two minds, one blind, different routes: N3; NB3; tools exact, VOTES; FAIL | minds:  | verdict: TRUE; N3's vote table has combinatorial rows the geometry never realises, harmle …
- needs: 
- statement: 
- uses: 
- not claimed: 
- handoff/kernel: stub — with FS-114.
- dependents (index, direct/transitive): 2/18

### row 61 — FS112-N3-NOBOTH (upstream; plans/FS112-derivation.md:142)
- grade: hand; two minds, one blind: N3; NB3; over FS112-U1 | minds:  | verdict: TRUE. So no both-kind arc is centred at a cubic trichromatic vertex, and a three …
- needs: 
- statement: 
- uses: 
- not claimed: 
- handoff/kernel: stub — with FS-114.
- dependents (index, direct/transitive): 6/27

### row 62 — FS112-N3-END (upstream; plans/FS112-derivation.md:182)
- grade: hand; two minds, one blind: N3; NB3 | minds:  | verdict: TRUE as the table states it; N3's body's first alternative ("both horns lie betw …
- needs: FS112-N2-FLANK-Q, FS112-N3-NOBOTH
- statement: 
- uses: 
- not claimed: 
- handoff/kernel: stub — with FS-114.
- dependents (index, direct/transitive): 1/18

### row 63 — FS112-N3-PAIRS (upstream; plans/FS112-derivation.md:164)
- grade: hand; two minds, one blind: N3; NB3; (i)'s unconditional form one mind, N3, with NB3's sighted check | minds:  | verdict: TRUE; N3-II's form at `x` is sharper (four colours, not "four or a repeat").
- needs: FS112-N3-NOBOTH
- statement: 
- uses: 
- not claimed: 
- handoff/kernel: stub — with FS-114.
- dependents (index, direct/transitive): 1/18

### row 64 — FS112-NB4P (upstream; plans/FS112-derivation.md:53)
- grade: hand; three minds, one blind: N; NB; Y2 | minds:  | verdict: TRUE. **Correction owed to `plans/FS110-derivation.md` l. 42** (FS110-NB-4's "ge …
- needs: FS112-A4SIX, FS112-BUDGET2
- statement: 
- uses: 
- not claimed: 
- handoff/kernel: stub — with FS-114.
- dependents (index, direct/transitive): 3/41

### row 65 — FS112-SIX (upstream; plans/FS112-derivation.md:48)
- grade: hand; two minds, one blind: N; NB | minds:  | verdict: TRUE. De Grey's covering step for C-V56 ("those six tiles must jointly cover a d …
- needs: 
- statement: 
- uses: 
- not claimed: 
- handoff/kernel: stub — with FS-114.
- dependents (index, direct/transitive): 3/41

### row 66 — FS112-U1 (upstream; plans/FS112-derivation.md:42)
- grade: hand; two minds, one blind: N; NB | minds:  | verdict: TRUE with NB's precision. Answers **C-UA-WEDGE: MISSTATED** as written ("the `c` …
- needs: 
- statement: 
- uses: 
- not claimed: 
- handoff/kernel: stub — with the NO's map argument (FS-114).
- dependents (index, direct/transitive): 13/59

### row 67 — FS114-BV-HEX (upstream; plans/FS114-derivation.md:960)
- grade: hand | minds: 1 — BASE-V, blind to FS-110's and FS-112's walks of these steps; BV-HEX is CB D5 item 5 in substance (FS-110), with H in … | verdict: derived
- needs: 
- statement: (BV-HEX) Lemma 6's `< 9` branch under H: the regular hexagon of kept points cannot occur at a cubic trichromatic `u` in a valid map (unit arcs allowed) when `x_1, …, x_6` are cubic; no Condition 5, no strip `A(u)`, no unit-arc step; (BV-L3) Lemma 3, a.e., curved, cusps and double cusps at `u₁, u₂`: no two points with the same multicolour at distance in (1, 2) whose unit circles carry proper finite circle colourings in the complementary triple; (BV-ND) NoDouble holds with unit arcs, at cusps; (BV-ND1) BV-ND under the 60° rotation of one circle: two switch points of `ω(u)` at distance 1 with the same pair, switching in opposite senses, are impossible at plain or cubic points; with unit arcs, no strip used
- uses: the band lemma BV-H1 (a finite 3-colouring of the unit circle lifts to a height whose `h(x+60°) − h(x)` stays in one band), the unit-distance four-bar linkage, exact identities (sympy)
- not claimed: Lemma 4 at cusps (not landed: a GAP in BASE-V's blind derivation at Prop. 19(b) and the selection; CUSP-BASE's D5 items 1–4, 6 stay at CE's one mind); a downgrade of anything (the regrade is upgrades only)
- handoff/kernel: none — BASE-V's regrade of row 134's base (the ledger draft carries it)
- dependents (index, direct/transitive): 2/18

### row 68 — FS114-CV-HD (upstream; plans/FS114-derivation.md:57)
- grade: hand | minds: 2 — blind to: each other's records at stage 1 (CVB sighted on Y3-END-NEEDS's levels, an FS-112 input); method: CV one ch … | verdict: derived
- needs: FS112-U1
- statement: (CV-HD) in `M*`, for a stuck `E`: both upper bounds `1` and no in-type lower-flank tile at `E − n` is impossible; hence `G_N ⇔ H_S ⇔ υ± = 1 ⇔ λ± = −1` (all four horn arcs unit arcs, in-type flank tiles at both antipodes); (CV-CLASS) a stuck vertex of `M*` is a bowtie (CV-HD's four equivalent conditions; both neighbours both-centres with `≥ 4` colours; a one-vertex chain) or has `g` twice at `E − n` and `h` twice at `E + n` (each neighbour stuck or with `≥ 4` colours and a repeated colour); (CV-L0) in a terminal valid map `M*` a stuck vertex centres no unit arc, so `Γ ∩ ω(E)` is finite; (CV-ENDS) FS112-C-ENDS holds with no residue: the point one step beyond every finite end of a stuck chain has at least four colours
- uses: FS-110's N4 frame at a stuck vertex (horn curvatures `λ_k < υ_k`), FS112-U1's wedges, W-MERGE, N-E1 and N-E2; CV-U and CV-L4 (below ends of chains), CV-FLANK and CV-P
- not claimed: that a stuck vertex exists in any valid map; anything about one-sided infinite chains (FS-115's (b′)), which CV-ENDS leaves to N4-FIN
- handoff/kernel: none — a relay-result inside FS-112's chain composition; CV-EXISTS no longer uses it (FS114-CVB-EXISTS's route)
- dependents (index, direct/transitive): 2/18

### row 69 — FS114-CVB-THOM (upstream; plans/FS114-derivation.md:83)
- grade: hand | minds: 3 — blind to: each other's records (NB and CVB blind; FS114-N's stage 1 against, on the pinch clause); method: NB by tre … | verdict: derived
- needs: 
- statement: `[Thomassen1999]`'s steps other than the rainbow step hold for every valid map, Siamese pairs allowed: fill holes, read facial cycles as boundary walks, and replace the count in `int(R)` by local finiteness (finite against infinite); the reduced map graph `H` then has a vertex of degree `≥ 6` (with FS114-CVB-PINCH: in the map graph of a locally finite plane map, `M − x` is connected at a pinched tile and disconnected at a holed one; holes are locally consistent with validity)
- uses: Thomassen's Lemma 1 (a connected, locally finite, locally Hamiltonian graph with at least 13 vertices has a vertex of degree at least 6) and his topological steps; local finiteness of the map; nothing about colours but at the rainbow step, which this entry excludes
- not claimed: the rainbow step on valid maps (it fails there: FS114-N114-RD's types (A) and (B)); the 2-separator criterion at pinches, which is a sketch (one mind: CVB)
- handoff/kernel: none — a relay-result for route T: it says where Thomassen's argument fails on valid maps (only the rainbow step)
- dependents (index, direct/transitive): 1/17

### row 70 — FS114-L60-LE (upstream; plans/FS114-derivation.md:922)
- grade: hand | minds: 2 — blind to: nothing of the other's frame for the bound (FS114-L60 was briefed with FS114-N4's record open; N4 found it … | verdict: derived
- needs: 
- statement: (L60-LE) a unit arc with constant sides has `ℓ ≤ 60°` (its ends lie in the closure of one tile); (L60-EQ) at `ℓ = 60°` both side tiles lie in the lens `B̄(A, 1) ∩ B̄(B, 1)`: `T_in ⊆ Reul(P, A, B)`, `T_out ⊆ Reul(A, B, C) ∖ B̄(P, 1)`, `C = A + B − P`; at each end their sectors lie in the two corner cones (120° and 60°), which fill exactly the closed half-plane facing the other end, so each end is a vertex carrying a third tile; (L60-REAL) equality is realised, by a valid fragment by formula on a neighbourhood of the closed arc
- uses: the diameter bound (every tile has diameter at most 1) and TS-C; the fragment's exact coordinates for L60-REAL (`tools/fs114_l60_check.py`)
- not claimed: FS112-L60 as filed ("below 60°": FALSE at exactly 60°, the erratum in `plans/FS112-derivation.md`); the second clause's "ends" reading (FALSE at equality); that the equality case occurs in a valid map
- handoff/kernel: none — a correction of an FS-112 lemma, filed with its erratum
- dependents (index, direct/transitive): 3/19

### row 71 — FS112-C-ENDS (upstream CYCLE; plans/FS112-derivation.md:197)
- grade: hand; one mind: FS112-C, an assembly, repaired by FS112-C2; its links two minds, one blind, but the arc-through-N count one mind: NB, and FS112-C-DOUBLE one mind | minds:  | verdict: TRUE at one mind outside the residue in the statement; the exhaustiveness of N2' …
- needs: FS112-C-DOUBLE, FS112-N2-TERM, FS112-N3-END, FS114-CV-HD
- statement: 
- uses: 
- not claimed: 
- handoff/kernel: stub — with FS-114.
- dependents (index, direct/transitive): 2/17

### row 72 — FS112-L60 (upstream CYCLE; plans/FS112-derivation.md:66)
- grade: hand; two minds, one blind: N; NB; tools exact | minds:  | verdict: TRUE.
- needs: FS114-CV-EXISTS, FS114-L60-LE
- statement: 
- uses: 
- not claimed: 
- handoff/kernel: stub — with FS-114.
- dependents (index, direct/transitive): 2/17

### row 73 — FS112-N2-RED (upstream CYCLE; plans/FS112-derivation.md:90)
- grade: hand; two minds, one blind: N2; NB2; over NB-MERGE3, two minds | minds:  | verdict: TRUE. N112-RED's merge step is needed only at centres with a repeated colour: at …
- needs: FS112-BEND, FS112-L60, FS112-N2-BENDS
- statement: 
- uses: 
- not claimed: 
- handoff/kernel: stub — with FS-114.
- dependents (index, direct/transitive): 1/17

### row 74 — FS112-N2-TERM (upstream CYCLE; plans/FS112-derivation.md:115)
- grade: hand; two minds, one blind: N2; NB2 | minds:  | verdict: TRUE.
- needs: FS112-N2-FLANK-Q, FS112-N2-RAY, FS112-N2-RED, FS112-NB4P
- statement: 
- uses: 
- not claimed: 
- handoff/kernel: stub — with FS-114.
- dependents (index, direct/transitive): 3/17

### row 75 — FS112-N3-BASE (upstream CYCLE; plans/FS112-derivation.md:169)
- grade: hand; two minds, one blind: N3; NB3; over row 134's base at its grade — CB's route with CE's repairs, CUSP-BASE, S–V Lemma 5, Prop. 18 and Lemma 6's `< 9` branch, unre-derived here — and FS112-U1, FS112-N2-BENDS, two minds each | minds:  | verdict: TRUE; no row needed a repair; Prop. 17's row gains N3-COR3 as a dependency (NB3  …
- needs: FS112-N2-BENDS, FS112-N3-ANTI, FS112-N3-COR3, FS112-N3-FAIL, FS112-N3-PAIRS, FS112-ROTHEX, FS114-BV-HEX
- statement: 
- uses: 
- not claimed: 
- handoff/kernel: stub — with FS-114, over the base's own formalization.
- dependents (index, direct/transitive): 1/17

### row 76 — FS112-N3-COR3 (upstream CYCLE; plans/FS112-derivation.md:156)
- grade: hand; two minds, one blind, different routes: N3; NB3; tools exact, COR3 on 403 + 128 + 336 cases | minds:  | verdict: TRUE; readings "double" = of both vertices, "four-colour" = at least four. **It  …
- needs: FS112-L60, FS112-N3-FAIL, FS112-N3-NOBOTH
- statement: 
- uses: 
- not claimed: 
- handoff/kernel: stub — with FS-114.
- dependents (index, direct/transitive): 6/17

### row 77 — FS112-N3-DENSE3 (upstream CYCLE; plans/FS112-derivation.md:176)
- grade: hand; two minds, one blind: N3; NB3; over FS112-N3-BASE and FS112-DISC1 | minds:  | verdict: TRUE. On both positives it holds (four-colour midline vertices within 1.834 of e …
- needs: FS112-DISC1, FS112-N3-BASE, FS112-SIX, FS114-BV-HEX, FS114-CV-EXISTS
- statement: 
- uses: 
- not claimed: 
- handoff/kernel: stub — with FS-114.
- dependents (index, direct/transitive): 3/17

### row 78 — FS112-ROTHEX (upstream CYCLE; plans/FS112-derivation.md:191)
- grade: hand; one mind: NB3, the named check | minds:  | verdict: TRUE; N3 took the lemmas on FS110-P17's route unwalked.
- needs: FS112-N3-COR3
- statement: 
- uses: 
- not claimed: 
- handoff/kernel: stub — with FS-114.
- dependents (index, direct/transitive): 1/17

### row 79 — FS114-CV-EXISTS (SEED CYCLE; plans/FS114-derivation.md:26)
- grade: hand | minds: 2 — blind to: each other (FS114-CV blind to the FS112-C assembly; FS114-CVB blind to FS114-CV's record until its stage 1 … | verdict: derived
- needs: FS112-C-ENDS, FS112-N2-TERM, FS112-N3-DENSE3, FS114-CV-HD, FS114-L60-WALK
- statement: Every valid map has a vertex of at least four colours, in the map itself; the proof passes through `M*`, where with no such vertex every stuck chain would be bi-infinite; it uses neither CV-HD nor FS112-C-ENDS, no ray step and no residue
- uses: FS112-N3-DENSE3 (a vertex of `F ∪ R` in every disc of radius 3), FS112-N2-TERM (the terminal modification `M*`, whose vertices are cubic, NB4P exceptions with at least four colours, or stuck on chains along their normal lines), N4-FIN (no bi-infinite stuck chain), and that a modification creating no unit arc keeps a four-colour vertex's colours at the vertex in the map itself; FS114-CV's route add …
- not claimed: C114-LOCAL-F (an explicit radius about the four-colour vertex); that four-colour vertices come within any bounded distance of every point (GS-4's density form, which still needs FS-115's (b′) and (b″) for aperiodic maps); anything about maps at a fixed complexity `K` alone
- handoff/kernel: de Bruijn — deferred with D6 (a Lean skeleton of Q-full's statement, held for Kooshi): the statement verbatim, its not-claimed line, the model's vacuity caveat, and its inputs FS112-N3-DENSE3, FS112-N …
- dependents (index, direct/transitive): 4/17

### row 80 — FS114-L60-WALK (upstream CYCLE; plans/FS114-derivation.md:943)
- grade: hand | minds: 1 | verdict: derived
- needs: FS114-CV-EXISTS, FS114-L60-LE
- statement: (L60-WALK) no step of FS112-N2-RED, FS112-N3-COR3, FS112-N3-BASE, FS112-N3-DENSE3 or FS114-CV-EXISTS (with CVB-EXISTS) needs the strict bound; each use of "`< 60°`" in their frames needs `0 < ℓ ≤ 60°` or only `0 < ℓ < 180°`, and the equality case passes every step; two remarks outside the chain are false at equality (NB's C-UA-CHAIN aside, N's ends reading of the second clause) and nothing rests on them; (L60-D5) in N3-BASE's setting, the two ends of a circle-to-circle path (CB D5 item 1) are less than 1 apart
- uses: FS114-L60-LE, the statements and proofs of the five entries walked, N3-P′, N3-PAIR, N3-NOBOTH
- not claimed: a blind second mind (the registered L60-P1, p 0.85, and L60-P2, p 0.9, wait for one that never ran)
- handoff/kernel: none — an audit of a chain; its blind second mind is owed before publication
- dependents (index, direct/transitive): 1/17

### row 81 — FS114-N114-RD (upstream; plans/FS114-derivation.md:108)
- grade: hand | minds: 2 — blind to: NB derived its NB-RD before opening FS114-N's record; method: NB reads the radius `1 + 1/√3` about the til … | verdict: derived
- needs: FS114-CVB-THOM
- statement: **The rainbow deficit.** In a valid map every repeat at a tile `x` is (S) a close pair, or (A) a unit arc of `∂x` shared with one member and centred at a point `q ∈ F ∪ R` where the other member touches `x` at `q` alone, or (B) two members touching `x` only at vertices `p, q ∈ F ∪ R` with `|p − q| = 1 = diam x`; at most one member of a far pair shares an arc with `x`
- uses: that two same-colour tiles are close or far, never both (FS114-N114-FAR, FS-110's N-E2 in interval form), and that a point of `cl x` met by another tile at that point alone is a vertex of at least four sectors (NB-ANCHOR)
- not claimed: that type (B) occurs in a valid map (it is realised on fragments only: FS114-N's hexagon by hand, and YB's exact fragment of radius 3/5 for the corrected C114-RAINBOW's third case); the original C114-RAINBOW dichotomy (MISSTATED by four minds)
- handoff/kernel: none — a relay-result for route T's counts and for C114-RAINBOW's corrected statement
- dependents (index, direct/transitive): 5/16

### row 82 — FS114-N114-EULER (upstream; plans/FS114-derivation.md:148)
- grade: hand | minds: 2 — blind to: NB derived NB-EULER before opening FS114-N's record; method: NB checked it exactly on 17 torus maps by for … | verdict: derived
- needs: FS114-N114-RD
- statement: On a cellular torus map: `Σ_f (deg_M(f) − (k − 1)) = (7 − k)F + Σ_v (d(v) − 2)(d(v) − 3) − μ`, `μ ≥ 0` counting repeated contacts between one pair of faces (0 when faces meet at most once)
- uses: Euler's formula on the torus and the map graph's degrees by vertex incidence; `μ` counted as excess multiplicity, self-meetings included (NB's reading, adopted by FS114-N2)
- not claimed: the identity with `μ` counting only distinct neighbours met twice (it fails: NB-EULER); anything on the plane without averaging
- handoff/kernel: none — an identity route T's counts are read from
- dependents (index, direct/transitive): 4/14

### row 83 — FS114-N2-FIVE (upstream; plans/FS114-derivation.md:166)
- grade: hand | minds: 2 — blind to: NB derived NB-ABSENT and NB-COUNT before opening FS114-N's record; FS114-N2 re-derived them sighted; metho … | verdict: derived
- needs: FS114-N114-EULER, FS114-N114-RD
- statement: C114-FIVE-COUNT: **TRUE** — no non-Siamese valid five-colour map is cellular on a torus with `μ = 0` (`Σ_v p_5(d) ≤ 0` with `p_5 = 3, 4, 9` at `d = 3, 4, 5`). (N2-ABS, NB-ABSENT: on a non-Siamese valid map with `μ = 0`, the tiles meeting `x` at a vertex alone are the (A) partners plus the tiles of colours absent from `x` and its edge-neighbours, at most 3 per absent colour; so `3 s(x) + Σ_{v∈∂x}(d(v) − 3) ≤ 3(k − 1) + A_x`)
- uses: FS114-N114-EULER, FS114-N114-RD, and that four points cannot be pairwise at distance 1 (so a colour absent from `x`'s edge-neighbours meets it in at most three tiles)
- not claimed: the five-colour statement for maps with Siamese pairs or `μ > 0`; anything at six colours (FS114-N2-ENDS)
- handoff/kernel: none — route T's positive control, a known value by counting
- dependents (index, direct/transitive): 3/12

### row 84 — FS114-N114-ROOM (upstream; plans/FS114-derivation.md:187)
- grade: hand | minds: 2 — blind to: NB derived NB-COUNT before opening FS114-N's record; method: NB by the quadratic `Σ_v [2d² + (2 − 3k)d + 6 … | verdict: derived
- needs: FS114-N114-EULER, FS114-N2-FIVE
- statement: At six colours the same count forces type (B) only when `V₄ < 3V₆`: six's room is the degree-4 (four-colour) vertices, `V₄` of it (with NB-COUNT: on a non-Siamese valid map cellular on a torus with `μ = 0` and six colours, `V₄ ≥ 3V₆` and `V₃ ≤ 2V₄ + 5V₅ + 8V₆`)
- uses: FS114-N114-EULER and FS114-N2-FIVE's absent-colour cap, at `k = 6`
- not claimed: that any map has `V₄ ≥ 3V₆` (no valid map is known); a per-vertex bound (FS114-N2-LEMMAS' VCAP: none can kill)
- handoff/kernel: none — a relay-result for FS114-N2-ENDS
- dependents (index, direct/transitive): 2/11

### row 85 — FS114-N2-ENDS (SEED; plans/FS114-derivation.md:235)
- grade: hand | minds: 1 | verdict: derived
- needs: FS114-N114-EULER, FS114-N114-RD, FS114-N114-ROOM, FS114-N2-FIVE
- statement: **The count in edge-end form.** With `n(p)` the non-tactic edges at `p`: `Σ_{d=3} n + Σ_{d=4} (n − 2) + Σ_{d=5} n + Σ_{d=6} (n + 6) + 2U = 0`; every tactic edge's end `p` lies at distance exactly 1 from its centre `q ∈ F`, both in the closure of its inner tile (with N2-SLACK: at six colours, exactly `A = E′ − V₄ + 3V₆ + U`, `U = Σ_x (3a(x) − B_x) ≥ 0` the unused absent-colour capacity)
- uses: FS114-N114-EULER, FS114-N114-RD, FS114-N2-FIVE's cap at `k = 6`, on a non-Siamese torus map with `μ = 0`
- not claimed: that any vertex type is excluded; the kill (K1, K2′); Siamese maps (FS114-N2-LEMMAS' SIAM) and `μ > 0` (GAP-μ)
- handoff/kernel: de Bruijn — deferred with D6: the identity on a torus map is a finite combinatorial statement, a natural first kernel target once the class is fixed
- dependents (index, direct/transitive): 4/10

### row 86 — FS114-N3-LOCAL (upstream; plans/FS114-derivation.md:419)
- grade: hand | minds: 1 — N3-FACE's substance is FS114-Y4-UPDOWN, derived blind on the other side and re-derived blind by YB3; the others have … | verdict: derived
- needs: FS112-U1
- statement: (N3-FACE) Two distinct tiles of one colour at vertices `u, w` with `|u − w| = 1` have their cones in the closed half-planes facing away from each other; one tile at both lies in `B̄(u, 1) ∩ B̄(w, 1)`; (N3-HALF) At a tactic edge at `p` (centre `q`, inner `x`, outer `y`): `x` faces `q`, `y` faces away; every other tile at `p` meeting the open half-plane facing `q` has a colour absent at `q` or contains `q`; at `q` the open half-plane facing `p` meets only `x` and tiles of the two colours absent at `p` (one of each at most); (N3-SEC) Every tile adjacent to a tactic edge at `p` has cone `≤ 180°`; two consecutive tactic edges with the tile between inner to one and outer to the other have it `≥ 60°`; a tile inner to both its edges at `p` (a **lens**) has cone `180° − γ ∈ [120°, 180°]`, `γ ≤ 60°` the angle between the two centres; (N3-FLANK) In the simple class, each branch of `p`'s ring at a tactic centre `q` lies on `Γ` or in a tile of a colour absent at `p`; two such tiles are distinct and of the two different absent colours: `q` is a change point of the ring or an end of a `Γ`-arc of `ω(p)`; (N3-PAIR) If `y` is an edge point between tiles of colours `c, c′` and `y′` carries `c, c′` at distance 1, the edge through `y` is an arc of `ω(y′)`; (N3-ODD) Off `Γ`-arcs of `ω(p)`, every half-open 60° window of the ring of a four-colour vertex holds an odd number of change points
- uses: N-E0, N-E1, N-E2 (FS-110), FS112-U1's wedges, and the non-Siamese hypothesis where a colour absent at a vertex is used
- not claimed: any exclusion by these lemmas alone (K1 is not derivable at radius `1 + ε` from them: FS114-N3's N3-K1)
- handoff/kernel: none — local tools for every later round; a blind check of N3-HALF, -SEC, -FLANK, -PAIR, -ODD is owed before the successor files K1
- dependents (index, direct/transitive): 7/27

### row 87 — FS114-N3-DR (upstream; plans/FS114-derivation.md:443)
- grade: hand | minds: 1 — DR's shape was built blind on the other side (FS114-Y2-BOWTIE) and N3-DR1 re-derived blind by NB5 in N5's setting | verdict: derived
- needs: FS114-N3-LOCAL
- statement: **The escaping configuration DR**: a degree-4 vertex with two opposite Reuleaux lenses and all four edges tactic forces, at radius `≤ 1 + ε`: partners `c₂, c₄, c₄, c₂` at `a, b, −a, −b`; one tile of `c₃` over `R1`'s cap (so `R1` is inner to three tactic edges), each corner of degree exactly 4; each lune's ring carrying change points at `s, s + 60°` (with N3-CONT: in DR's general member the continuation of each tactic lens arc beyond its end is non-tactic; and N3-DR1: `t₄` reaches the ring at `y′` or `y″`, and `z_a` reaches `y″` or `z_{−b}` reaches `y′`)
- uses: FS114-N3-LOCAL
- not claimed: that DR exists in a valid map (it does not, on `B̄(p, √3)`: FS114-Y4-RSTOPALL); N3-DR0's written proof (its step 1 fails; the conclusion holds by FS114-N4-D); N3-DR2 at more than one mind
- handoff/kernel: none — superseded by FS114-Y4-RSTOPALL as a statement; its lemmas are relay-results
- dependents (index, direct/transitive): 5/25

### row 88 — FS114-N3-JOINT (upstream; plans/FS114-derivation.md:258)
- grade: hand | minds: 1 | verdict: derived
- needs: FS114-N2-ENDS, FS114-N3-DR
- statement: Route T's count restated: `N + U + 3V₆ = V₄` (non-tactic edges); the non-Siamese simple torus NO ⟸ a fractional assignment giving every degree-4 vertex two units among non-tactic edge-ends (its own or free ones within radius `R`), `U`, and six units per degree-6 vertex, with a unit unused in every disc of radius `R₀` (K1 ∧ K2-loc is the own-ends case) (with N2-KILL: the torus NO, non-Siamese, `μ = 0`, follows from K1 and K2; and N3-PAY: DR vertices pay, from their four continuation ends)
- uses: FS114-N2-ENDS (N2-SLACK) and N3-CONT (the continuation of each tactic lens arc beyond its end is non-tactic)
- not claimed: the assignment's existence (K1′, the payment of the deficient patterns other than DR, and K2′, a unit unused per disc, are open); the Siamese class; `μ > 0`
- handoff/kernel: none — a reduction; the kill it names is the successor's
- dependents (index, direct/transitive): 2/9

### row 89 — FS114-N4-LEMMAS (upstream; plans/FS114-derivation.md:503)
- grade: hand | minds: 2 — blind to: NB4 derived N4-OWN, N4-LENS, N4-FIVE and N4-TOP before opening FS114-N4's record; method: NB4-OWN by E1 at … | verdict: derived
- needs: FS112-A4SIX, FS112-NB4P, FS112-SIX, FS112-U1, FS114-N3-LOCAL
- statement: (N4-OWN) A Reuleaux corner of the bowtie never carries the colour of the lune it bounds (`2 ∉ P_cl(q1), P_cl(q3)`; `4 ∉ P_cl(q2), P_cl(q4)`): `ω(q1)` leaves `p` tangent to the `t2 | t3` edge and curves into `t2`; (N4-LENS) If `|u − v| = 1`, a tile meeting the open lens `B(u,1) ∩ B(v,1)` with a colour of `P_cl(u)` is `u`'s tile of that colour; a colour that `u` and `v` carry on different tiles meets no point of the open lens; (N4-TOP) In the degenerate member: the ring tiles `T_R ⊂ B̄(q1,1) ∩ B̄(top,1)`, `T_L ⊂ B̄(q3,1) ∩ B̄(top,1)`; one tile `W` of the far lune's colour fills the outer wedge at `top`, cone exactly `[60°, 120°]`, bordered by arcs of `ω(q1)` and `ω(q3)`; the lune tile reaches `top`, a degree-4 vertex of four colours `{2, 4, 5, 6}` at distance 1 from `p`; (N4-FIVE) with the lune rings free of `Γ`, a corner carries five colours iff its lune's ring is degenerate, and otherwise exactly four `{1, 3, 4, X}`; (N4-ARC) at a five-colour corner `q1`, 120° of unit arcs centred at `q1` lie within radius `√3` of `p`, and FS112-SIX's demand adds nothing beyond N-E0 on the far arc; (N4-A4NB) neither A4SIX nor NB4P gives the bowtie a new constraint
- uses: FS114-N3-LOCAL, N-E1, N-E2, FS112-U1, FS112-SIX, FS112-A4SIX, FS112-NB4P
- not claimed: N4-OPP as N4 stated it (MISSTATED in general: an edge leaving `p` exactly opposite and curving toward `q` with curvature above 1 captures the branch of `ω(q)`; NB4's corrected second-order form holds, and N4-OWN is unaffected); N4-LENS without the non-Siamese hypothesis (FALSE: NB4)
- handoff/kernel: none — relay-results for the bowtie's exclusion
- dependents (index, direct/transitive): 2/21

### row 90 — FS114-Y-EDGE (upstream; plans/FS114-derivation.md:130)
- grade: hand | minds: 4 — blind to: FS114-N and FS114-Y blind to each other; NB and YB blind to their sides' records; method: four derivations … | verdict: derived
- needs: 
- statement: C114-EDGE-RAINBOW TRUE: in a valid map, two faces of one colour that each share a boundary arc of positive length with a face `x` (either may be `x`) are Siamese; so a face with six or more edge-neighbours forces a Siamese pair (Sirgedas's "Degree 6 isn't possible with only 6 colors", for non-Siamese maps)
- uses: `diam x ≤ 1` and that a unit circle meets a circle of radius 1 about another point in at most two points
- not claimed: the statement under the narrower gloss "the two meet at a vertex" (FALSE: YB); any bound on repeats through vertex contacts
- handoff/kernel: none — a relay-result for route T and the pinwheel lemmas (FS114-Y5-PINALL uses its non-Siamese form)
- dependents (index, direct/transitive): 4/21

### row 91 — FS114-Y2-BOWTIE (upstream; plans/FS114-derivation.md:461)
- grade: computed over: the fragment's 46 same-colour tile pairs, each checked exactly over `ℚ(√3)` (`data/fs114/fs114-y2/k1.out`) | minds: 2 — blind to: YB2 built its own 20-tile D2-symmetric fragment before opening FS114-Y2's record; method: YB2's checker ov … | verdict: derived
- needs: 
- statement: **K1's killing test fires as a local statement:** a non-Siamese valid fragment by formula (twenty tiles over `ℚ(√3)`) holds the closed disc of radius `3√3/5 ≈ 1.0392` about a degree-4 vertex `p` of four colours whose **four** edges are tactic — unit arcs about four-colour vertices `q1…q4` at distance 1, each with a tile of the outer tile's colour meeting the inner tile at `q_i` alone. So no argument reading only the closed disc of radius `3√3/5` about the vertex proves K1
- uses: the fragment's exact coordinates over `ℚ(√3)` and FS114-YB's segment-and-arc checker, unedited, recalibrated on the five controls
- not claimed: a disc of radius `√3` or more (the bowtie stops there: FS114-Y3-RSTOP); that the fragment is part of a valid map; five colours at `q_i` as forced in every bowtie (forced only with `top`'s neighbourhood: FS114-Y4-DIAG)
- handoff/kernel: none — an exact object checked by exact arithmetic; a kernel certificate is owed only if K1's route is ever published through it
- dependents (index, direct/transitive): 2/21

### row 92 — FS114-Y4-LUNE (upstream; plans/FS114-derivation.md:554)
- grade: hand | minds: 2 — blind to: YB3 derived all four before opening FS114-Y4's record; method: different routes at LUNE's frontier and at  … | verdict: derived
- needs: FS112-U1
- statement: (Y4-LUNE) In a non-Siamese simple valid map with a Reuleaux bowtie at `p`, the two side tiles of each lune differ in colour: `c(X1) ≠ c(X4)`, `c(X2) ≠ c(X3)`; with SIDES the pattern is diagonal (`c(X1) = c(X3)`, `c(X2) = c(X4)`); (Y4-SIDES) Let `t1 = Reul(p, q1, q2)` be a tile of a valid map; the tile `X1` along its side `p q1` at `q1` and the tile `X2` along its side `p q2` at `q2` (both outside `t1`) are distinct and of different colours, Siamese pairs allowed; in a non-Siamese Reuleaux bowtie `{c(X1), c(X2)} = {5, 6}`; (Y4-UPDOWN) If `|u − v| = 1`, a tile at `u` with a direction `ψ` at `u` with `cos(ψ − arg(v − u)) > 0` has points within `< 1` of `v`, hence of every tile at `v`: in a non-Siamese map its colour is absent at `v` unless it is that tile; (Y4-W) In a non-Siamese simple Reuleaux bowtie the tile along `t1`'s outer side at `q1` and the one at `q2` are one tile `W`, of colour 3 (the colour of `t3`); `W ⊂ B̄(q1, 1) ∩ B̄(q2, 1)`, so its sector is inside `[300°, 360°]` at `q1` and `[0°, 60°]` at `q2`, pointing toward `r` at both
- uses: the straddle computation (two tiles of one colour with points at distance above and below 1), FS112-U1, N-E1
- not claimed: the mirror clause of Y4-W for `t3`'s outer tile as a separate claim (it is Y4-W under the reflection); anything about non-Reuleaux lenses
- handoff/kernel: none — relay-results for FS114-Y4-RSTOPALL
- dependents (index, direct/transitive): 2/21

### row 93 — FS114-N4-D (upstream CYCLE; plans/FS114-derivation.md:480)
- grade: hand | minds: 2 — blind to: NB4 derived N4-D and the reduction of N4-G before opening FS114-N4's record, and checked N4-G's kill step  … | verdict: derived
- needs: FS114-N3-DR, FS114-N3-LOCAL, FS114-N4-LEMMAS, FS114-Y3-RSTOP, FS114-Y4-RSTOPALL
- statement: (N4-D) **The degenerate member does not exist at radius `√3`**: no valid fragment on the closed disc of radius `√3` about `p` holds the Reuleaux bowtie with a lune whose ring is free of `Γ` and changes colour once; (N4-G) **The general member does not exist at radius `√3`** (both lune rings `Γ`-free): if the lune tile `t2` reached the change point `y′` nearer `q1`, the partner `z4` would fill the lens `B(q1,1) ∩ B(top,1)` near `P90` while its sector at `q1` starts at `0°`, giving `z4` two points more than 1 apart; by the mirror `t2` cannot reach `y″` either, against N3-DR1 (N4-BOWTIE: no valid fragment, non-Siamese, simple class, on the closed disc of radius `√3` about `p` holds a Reuleaux bowtie whose lune rings are free of `Γ`)
- uses: FS114-N3-LOCAL, FS114-N3-DR's N3-DR1, and FS114-N4-LEMMAS (N4-TOP, N4-TANG, N4-LENS, N4-GP90); NB4-RING (a `Γ`-free lune ring has one change point, at `top`, or exactly two, `e(s)`, `e(s + 60°)`), which makes degenerate and general exhaust the `Γ`-free rings
- not claimed: lune rings carrying arcs of `ω(p)` (FS114-N5-GRING); maps with Siamese pairs; non-simple bowties
- handoff/kernel: none — superseded in scope by FS114-Y4-RSTOPALL; kept as the proof side's route
- dependents (index, direct/transitive): 1/20

### row 94 — FS114-N5-GRING (upstream CYCLE; plans/FS114-derivation.md:531)
- grade: hand | minds: 2 — blind to: NB5 derived N5-UP, -DEG, -R0, -ΓRING, -BEND, -KAPPA, -XBAR, -SIGHT, -BENDG, -W, -DR1 before opening FS114- … | verdict: derived
- needs: FS114-N3-DR, FS114-N3-LOCAL, FS114-N4-D, FS114-N4-LEMMAS
- statement: (N5-ΓRING) **K1-ΓRING reduced**: a Reuleaux bowtie whose lune rings carry arcs of `ω(p)` (non-Siamese, simple class) does not exist on the closed disc of radius 2 about `p` unless a lune is in the residual **(R-V)** of N5-XBAR (one corner carries both absent colours; a (Q) arc `t2 | z4` ends at the lune's ring midpoint): every lune is degenerate (N4-D), general (N4-G), or (R0) (N5-R0), and every pair of lunes not involving (R-V) dies; (NB5-RVKILL) **(R-V) does not exist on `B̄(p, √3)`**: `T ⊂ B̄(P90′, 1)`, `z4 ⊂ B̄(q1, 1)`, and the direction `60°` at `top` between the externally tangent `ω(q1)`, `ω(P90′)` has no colour; no hypothesis on the bottom lune
- uses: N5-BEND and N5-BENDG (FS-112's bends leave only (Q) and (R2) ring arcs at a degree-4 vertex, over FS112-N2-TOWARD, -AWAY, -TAN), N5-KAPPA, N5-UP (the up-tile at `top` avoids both corners' ring colours), N5-DEG, N5-W, N5-XBAR, N5-R0, N5-SIGHT, and FS114-N4-D
- not claimed: N5-RV's "Not excluded: K1-ΓRING is GAP at (R-V)" (FALSE: NB5-RVKILL); N5-BEND's length bound read for (Q) arcs (derived for (R2) arcs only); anything at the pinwheel (N5-PIN0's structure only)
- handoff/kernel: none — the proof side's route to FS114-Y4-RSTOPALL's conclusion (NB5-BOWTIE)
- dependents (index, direct/transitive): 3/20

### row 95 — FS114-Y3-RSTOP (upstream CYCLE; plans/FS114-derivation.md:601)
- grade: hand | minds: 2 — blind to: YB2 derived RSTOP, R and D2 before opening FS114-Y3's record; method: YB2 made the germ condition explicit … | verdict: derived
- needs: FS112-U1, FS114-Y2-BOWTIE, FS114-Y4-RSTOPALL
- statement: **FS114-Y2-BOWTIE stops at `√3`**: no valid fragment (Siamese pairs allowed) that agrees with it near `q1` and `q2` contains a neighbourhood of `r = q1 + e(330°) = (√3, 0)`; so the bowtie extends to no closed disc of radius `√3` or more about `p` (with Y3-R: a map with a Reuleaux bowtie containing a neighbourhood of `r` uses E1 or E2; and Y3-D2: in Y2's symmetry class each `q_i` has exactly five colours and no fragment holds `√3`)
- uses: N-E1 at `q1`, FS112-U1, and FS114-Y2-BOWTIE's tiles near `q1`, `q2`
- not claimed: Y3-FOUR's "so five colours at `q_i` are not forced by the bowtie" (FALSE once `top`'s neighbourhood is in the fragment: YB3-FIVE, Y4-DIAG); Y3-D2 without reading R-T (a GAP at one case: YB2)
- handoff/kernel: none — a member of FS114-Y4-RSTOPALL
- dependents (index, direct/transitive): 2/20

### row 96 — FS114-Y4-RSTOPALL (SEED CYCLE; plans/FS114-derivation.md:577)
- grade: hand | minds: 3 — blind to: YB3 derived it before opening FS114-Y4's record; the proof side (FS114-N4, FS114-N5, FS114-NB5) derived th … | verdict: derived
- needs: FS112-U1, FS114-N3-DR, FS114-N5-GRING, FS114-Y3-RSTOP, FS114-Y4-LUNE
- statement: **No non-Siamese simple valid fragment holding a Reuleaux bowtie at `p` contains neighbourhoods of the closed unit disc about `p` and of `r`**: RSTOP extends to every Reuleaux bowtie, symmetric or not, Γ-free or ΓRING; none holds a closed disc of radius `√3` about `p`. E1, E2 and E0 are all excluded
- uses: FS114-Y4-LUNE and its lemmas, FS114-Y4-DIAG (a diagonal bowtie with neighbourhoods of `top` and `bot` has five colours at each `q_i`, `X1` starting at exactly 60°, forcing E1 at `r` and then no colour for `bot`'s sector `(240°, 300°)`), FS114-Y3-R (every map with a bowtie containing a neighbourhood of `r` uses E1 or E2), FS112-U1
- not claimed: the pinwheel, the `(2, 1, 1, 0)` patterns, non-Reuleaux lenses, non-simple bowties; maps with Siamese pairs (Y3-RSTOP, the one member, allows them); DIAG step 5's written reason ("`T2 ⊂ [240°, 300°]` points at `bot`" misses a cusp `T2` along 300°; closed by the `X2 | N′` unit arc: YB3-CUSP, exact 5/ …
- handoff/kernel: de Bruijn — deferred with D6: the first explicit-radius exclusion of a configuration at a four-colour vertex; what crosses: the statement, the bowtie's definition with reading R-T, the non-Siamese and …
- dependents (index, direct/transitive): 4/20

### row 97 — FS114-N6-NOQ (upstream CYCLE; plans/FS114-derivation.md:619)
- grade: hand | minds: 2 — blind to: NB6 derived NOQ, RING60, KAPPA, CENT, PIN, P60′, ADJ, QOUT, QE1, PIN180 before opening FS114-N6's record;  … | verdict: derived
- needs: FS112-U1, FS114-N3-LOCAL, FS114-N5-GRING, FS114-Y5-PINALL
- statement: **No pinwheel has a ring free of (Q) arcs** (after the bends); in particular none with a `Γ`-free ring, at radius `1 + ε` (with N6-RING60: a four-colour vertex whose ring carries no (Q) arc has ring change points exactly `y + 60°ℤ`, six ring tiles alternating the absent colours, each spanning a closed 60° arc; and N6-CENT: at a non-Siamese degree-4 vertex whose ring carries no (Q) arc, all tactic centres lie in one class mod 60°, so non-Reuleaux lenses need a (Q) arc)
- uses: FS114-N5-GRING's N5-BENDG, FS112-U1, N6-KAPPA, N6-WIN in its §2.2 form (the reach of `y + 60°` when `κ` is defined just before it), N6-P60′, N6-ADJ, N6-QOUT, N6-QE1, N6-PIN180, FS114-N3-LOCAL's N3-FLANK
- not claimed: pinwheels whose rings carry (Q) arcs (K1-PINQ; N6's "(Q) arcs never start at a centre counter-clockwise" is a GAP, NB6-QSTART); N6-WIN's table sentence and N6-COV as first stated (MISSTATED: each needs `κ` defined just beyond the windows; corrected, NB6); N6-MTP's route
- handoff/kernel: none — the proof side's half of the pinwheel's exclusion
- dependents (index, direct/transitive): 4/15

### row 98 — FS114-Y5-PINALL (upstream CYCLE; plans/FS114-derivation.md:640)
- grade: hand | minds: 2 — blind to: YB4 derived the twelve statements before opening FS114-Y5's record; method: YB4-2ND finds PXKILL's contrad … | verdict: derived
- needs: FS114-N6-NOQ, FS114-Y-EDGE
- statement: **no non-Siamese simple valid fragment containing a neighbourhood of the closed unit disc about `p` holds a pinwheel at `p`**, except possibly under E1 (an edge at `p` of length exactly `60°`) or E2 (a blade's counter-clockwise side a unit arc centred at its clockwise edge end)
- uses: FS114-Y5-RAINBOW (C114-EDGE-RAINBOW's non-Siamese form), Y5-REGION, Y5-MU (with its two hypotheses: simple; edge `j + 1` below 60°), Y5-ALT, Y5-POCKET, Y5-CASE, Y5-REDUCE (outside E1 and E2 every pinwheel at `1 + ε` is `P_x`, cones `(x, 180° − x, x, 180° − x)`, `60° < x < 120°`), Y5-PIN120-60, and Y5-PXKILL (`T_k` and `O_{k+1}`, both of colour `k`, border the pocket tile `μ_k` along `ω(v_{k+1})` f …
- not claimed: E1 and E2 (exactly the cases the chain misses: YB4); Y5-PX's clause "`λ_k = α_k − 60°`" (a GAP: the pocket tile can wrap round `t_{k+1}`'s ring end — YB4-WRAP; CASE survives); Y5-PIN120-60's and Y5-PIN120's no-exception claims (GAPs at named E1 subcases, YB4)
- handoff/kernel: none — a local exclusion with two named exceptions; filed with them
- dependents (index, direct/transitive): 4/15

### row 99 — FS114-N7-QOPP (upstream; plans/FS114-derivation.md:787)
- grade: hand | minds: 1 | verdict: derived
- needs: FS112-U1, FS114-N6-NOQ
- statement: (N7-QOPP) Every (Q) arc of a four-colour degree-4 vertex joins opposite tiles (inner `t_i`, outer colour `c_{i+2}`); the other two tiles' colours are absent along it; (N7-FLANK) A tile of `p` with cone `[a, b]` puts its colour at no ring point in `(a ∓ 90°, b ∓ 90°)`; in `W(t) = [b − 90°, a + 90°]` only as itself, in `W̄(t)` only as other tiles; a ring point carries at most two colours of `p`; (N7-CHAIN) Change points propagate by `±60°` until the next point lies on a (Q) arc
- uses: N-E1, N-E2, FS112-U1, FS114-N6-NOQ's N6-KAPPA
- not claimed: that (Q) arcs occur; K1 on (Q) rings (a GAP at N7-HUBQ)
- handoff/kernel: none — tools for the (Q)-ring cases, the successor's
- dependents (index, direct/transitive): 4/11

### row 100 — FS114-Y6-HALF (upstream; plans/FS114-derivation.md:698)
- grade: hand | minds: 2 — blind to: YB5 derived the corrected form before opening FS114-Y6's record; method: YB5 found the two boundary subcas … | verdict: derived
- needs: FS114-Y4-LUNE, FS114-Y4-RSTOPALL
- statement: in a `(2, 1, 1, 0)` pattern whose two-edge tile `t_1` is a width-1 Reuleaux triangle, with `t_2`'s cone above 60° and `t_4`'s at least 60°, FS114-Y4-SIDES, FS114-YB3-D2T and FS114-Y4-W hold unchanged: the side tiles at its corners are 5 and 6, and the tile along its ring arc is one cap tile `W`, of the colour of the tile opposite `t_1` at `p`; the stop at `√3` is **not** inherited, since Y3's germ condition at `r` needs the slivers that FS114-Y4-DIAG derived from the second Reuleaux triangle
- uses: FS114-Y4-LUNE's lemmas (SIDES, W) and YB3-D2T
- not claimed: HALF as FS114-Y6 stated it, with no cone hypothesis (MISSTATED: at `t_2`'s cone 60° `q1 ∈ cl t_2` is forced, and at `t_4`'s below 60° SIDES-2 fails or no map exists, YB5-HALF4); any stop for the half-bowtie
- handoff/kernel: none — a construction target's frame
- dependents (index, direct/transitive): 1/6

### row 101 — FS114-K1 (upstream CYCLE; plans/FS114-derivation.md:804)
- grade:  | minds:  | verdict: gap: the cases no entry above excludes — rings with (Q) arcs (N7-HUBQ; the (Q)-p …
- needs: FS114-N114-ROOM, FS114-N2-ENDS, FS114-N3-DR, FS114-N3-JOINT, FS114-N3-LOCAL, FS114-N5-GRING, FS114-N7-3T, FS114-N7-QOPP, FS114-Y2-BOWTIE, FS114-Y4-RSTOPALL, FS114-Y5-PINALL
- statement: K1 in its local form — no valid fragment, non-Siamese and simple, on a disc of explicit radius about a degree-4 four-colour vertex with three or four tactic edges
- uses: 
- not claimed: 
- handoff/kernel: 
- dependents (index, direct/transitive): 1/5

### row 102 — FS114-N7-3T (upstream CYCLE; plans/FS114-derivation.md:717)
- grade: hand | minds: 1 — filed at one mind as the brief rules (inventory item 118); a blind check of N7-HUB (b) and the `+++ b = a + 1` step  … | verdict: derived
- needs: FS114-N3-LOCAL, FS114-N6-NOQ, FS114-N7-HUB, FS114-Y6-HALF
- statement: **Three or more tactic edges at a degree-4 vertex with a (Q)-free ring are excluded at radius `1 + ε`**, except the open-cap family **OC** (`+−+`, a Reuleaux lens beside a `60°` anti-lens; with a fourth tactic edge, the Reuleaux bowtie whose lenses do not border the caps): the `(2, 1, 1, 0)` patterns, the pinwheel, `γ = 0°` and non-Reuleaux lenses, `++−`, `−++` die in every member (with N7-HUB: at a four-colour vertex, non-Siamese and simple, whose ring is (Q)-free after the bends, each of the six change points `y_k` is a vertex of at least four colours: the directions toward `p` there lie in tiles of `p` reaching `y_k`, a tip, which meets `B(y_{k−1},1) ∩ B(y_{k+1},1)`, so its colour is carried at `y_{k±1}` by no other tile, and the outward directions in tiles of `p`'s colours outside `B̄(p,1)` whose `p`-tiles face away)
- uses: N7-REACH, N7-TAN, N7-TAC, FS114-N6-NOQ's ring lemmas (N6-RING60, N6-CENT), FS114-N3-LOCAL (N3-FLANK), NB4's form of N4-OPP
- not claimed: rings with (Q) arcs (N7-HUBQ, the tip with (Q) arcs allowed, needs the change point's ±60° points free of (Q) arcs — the named GAP); OC (its forced structure N7-OCTB and a route to `√3`, not closed); the pinwheel's E1 and E2 in N7's readings R-E1, R-E2 (GAP; whether R-E2 is the construction side's E …
- handoff/kernel: none — owed a blind second mind first; then with K1
- dependents (index, direct/transitive): 2/5

### row 103 — FS114-N7-HUB (upstream CYCLE; plans/FS114-derivation.md:762)
- grade: hand | minds: 2 — blind to: N7's record and this file until its verdict's commit (FS116-V1, 894db2d9), though given FS114-N7-3T's stat … | verdict: derived
- needs: FS114-K1, FS114-N6-NOQ, FS114-N7-3T
- statement: At a four-colour vertex (non-Siamese, simple) whose ring is (Q)-free after the bends, each of the six change points `y_k` is a vertex of at least four colours: the directions toward `p` there lie in tiles of `p` reaching `y_k` (a **tip**, which meets `B(y_{k−1},1) ∩ B(y_{k+1},1)`, so its colour is carried at `y_{k±1}` by no other tile), and the outward directions in tiles of `p`'s colours outside `B̄(p,1)` whose `p`-tiles face away
- uses: FS114-N6-NOQ's N6-RING60 (six change points, the ring tiles `R_k` alternating the two absent colours); N-E2; CL and CL-p (two tiles of one colour with points less than 1 apart are one tile; a tile of a colour of `p` with a point in `B(p, 1)` is `p`'s own); N3-FACE at the unit pair `(p, y_k)`; six colours, exactly four at `p`
- not claimed: rings with (Q) arcs (N7-HUBQ: a tip only at a change point whose `±60°` points have `κ` defined just outside); anything in the Siamese or non-simple class; anything at `k ≥ 7`
- handoff/kernel: none — a relay-result; true vacuously where the ring carries no arc of Γ (FS116-Y4-EMPTY), and its content, if any, on (Q)-free rings carrying (R2) arcs (FS-123)
- dependents (index, direct/transitive): 2/5

### row 104 — FS116-N1-GERM-R (SEED; plans/FS116-derivation.md:414)
- grade: hand | minds: 2 — blind to: N1's record until V3's verdicts (7245b6eb); method: a straddle on T′ × T in two regimes against the monoto … | verdict: derived
- needs: 
- statement: in a valid k-coloured fragment on a closed disc of radius above 1 about a point p, for any k, Siamese pairs allowed, let y = r(ψ) be a point of ω(p), c a colour, and v⁻, v⁺, u⁻, u⁺ the arcs of ω(p) just clockwise and just counter-clockwise of r(ψ − 60°) and r(ψ + 60°); if v⁻ lies in the closure of a tile of colour c, no tile of colour c approaches y along a direction β with β − ψ in (150°, 330°); for v⁺ the interval is (−30°, 150°), for u⁻ (−150°, 30°), and for u⁺ (30°, 210°)
- uses: N-E1; that the ring point at distance 1 from y + h near y ± 60° moves monotonically through y ± 60° as |y + h − r(ψ ± 60°)| crosses 1
- not claimed: anything about tiles that approach y only along the boundary directions ψ + 150°, ψ + 330°, ψ − 30°, ψ + 30°, ψ + 210°, ψ − 150°; anything when a germ lies on Γ with colour c on neither side
- handoff/kernel: de Bruijn — the statement with its four open intervals; N-E1 and a monotonicity along the ring; queued behind D6's map type
- dependents (index, direct/transitive): 5/16

### row 105 — FS116-N1-TWIST-D (SEED; plans/FS116-derivation.md:108)
- grade: hand | minds: 1 | verdict: derived
- needs: 
- statement: at a vertex p of a valid k-coloured fragment on a closed disc of radius above 1 about p, for any k ≥ 1, Siamese pairs allowed, any degree, the set D of points of ω(p) in the closure of a tile of one of p's colours is closed and lies in the union of the arcs of Γ on ω(p) and finitely many points
- uses: N-E1 at p (an interior point of a tile of colour c is at distance 1 from no point of the closure of a tile of colour c); that Γ is a locally finite union of segments and circular arcs, so finitely many of its pieces meet ω(p), each meeting it in at most two points unless it is an arc of ω(p)
- not claimed: that D is non-empty; that D is contained in the arcs of Γ on ω(p) alone (the strip's P₀ has two isolated points of D, its change points)
- handoff/kernel: de Bruijn — the first clause as stated, with N-E1 and the local finiteness it uses; a small statement once a map type exists in Lean (D6)
- dependents (index, direct/transitive): 10/41

### row 106 — FS116-N1-ECHO (SEED; plans/FS116-derivation.md:528)
- grade: hand | minds: 2 — on the corrected statement (reading B); blind to: N1's record until 7245b6eb; method: FS116-V3-ECHO-ONLY by a stradd … | verdict: derived
- needs: FS116-N1-TWIST-D
- statement: in a valid k-coloured fragment on a closed disc of radius above 2 about a point p, for any k, Siamese pairs allowed, let w be a point of ω(p) whose ring just clockwise and just counter-clockwise of w lies in tiles of one colour X absent at p; if w is an essential boundary point at which the fragment is saturated (each colour of P(w) has a point of its support at distance exactly 1 from w) and X is in w's essential multicolour, the point 2w − p lies in the closure of a tile of colour X
- uses: N-E1 (the ring germs at w put X-interior points at distance exactly 1 from every point near ω(w) off the directions ψ and ψ + 180° from w); FS116-N1-TWIST-D (X absent at p, so p carries no X); saturation at w
- not claimed: anything when X has density 0 at w (a cusp); that the X-tile at 2w − p exists in any fragment of SAT-STRIP's class
- handoff/kernel: de Bruijn — with N-E1 and saturation read at a point
- dependents (index, direct/transitive): 0/0

### row 107 — FS116-N1-GERM-S (SEED; plans/FS116-derivation.md:452)
- grade: derived from: FS116-N1-GERM-R, FS116-N1-TWIST-D | minds: 2 — blind to: N1's record until 7245b6eb, given N7-HUB's sketch in § 8 (V3's own caveat: a reader who counts it as given … | verdict: derived
- needs: FS116-N1-GERM-R, FS116-N1-TWIST-D
- statement: in a valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, Siamese pairs allowed, let y be a change point of the ring, X the colour of the ring just counter-clockwise of y and X̄ the colour just clockwise, and u⁻, u⁺, v⁻, v⁺ the arcs of ω(p) just clockwise and just counter-clockwise of the ring points y + 60° and y − 60°; then p has four colours and no more, X and X̄ are the colours absent at p, and (i) if neither v⁻ nor u⁺ lies on a (Q) arc, every direction at y in the open cone of 60° about the direction to p lies in the cone of a tile of a colour c of p every tile of p of which colour lies in B̄(y, 1); (ii) if neither u⁻ nor v⁺ lies on a (Q) arc, every direction at y in the open cone of 60° about the direction away from p lies in the cone of a tile, not a tile of p, of a colour c of p every tile of p of which colour misses B(y, 1); (iii) if none of the four lies on a (Q) arc, y is a vertex of at least four colours
- uses: FS116-N1-GERM-R; FS116-N1-TWIST-D; N-E1; that the distances between two tiles form an interval avoiding 1; that a tile of p lies in B̄(p, 1); six colours, spent once, at Step 1 (a germ carrying no X̄ and a colour absent at p carries X)
- not claimed: anything at k ≥ 7; that the tile in (i) is a tile of p (that is RING-GERM, in the non-Siamese class); that a change point with a germ on a (Q) arc has fewer than four colours
- handoff/kernel: de Bruijn — with RING-GERM, the non-Siamese hypothesis dropped and (i), (ii) in their facing form
- dependents (index, direct/transitive): 2/5

### row 108 — FS116-N1-QFREE4 (upstream; plans/FS116-derivation.md:490)
- grade: derived from: FS116-N1-TWIST-D | minds: 1 | verdict: derived
- needs: FS116-N1-TWIST-D
- statement: at a vertex p of at least four colours of a valid fragment on a closed disc of radius above 1 about p, Siamese pairs allowed, if the ring carries no (Q) arc then p has four colours and no more
- uses: FS116-N1-TWIST-D (a ring point off Γ has a colour absent at p); N-E1; stage 2's L1 (a ring arc of Γ excludes its side colours 60° away); six colours
- not claimed: anything at k ≥ 7; anything when the ring carries a (Q) arc (then p may have five colours)
- handoff/kernel: none — a two-line step used inside TOUCH's reduction; it crosses to Lean with it
- dependents (index, direct/transitive): 2/19

### row 109 — FS116-N1-TOUCH (SEED; plans/FS116-derivation.md:507)
- grade: derived from: FS116-N1-GERM-R, FS116-N1-TWIST-D | minds: 2 — blind to: N1's record until 7245b6eb; method: the same three steps (a second mind on the information axis only, V3 § … | verdict: derived
- needs: FS116-N1-GERM-R, FS116-N1-TWIST-D
- statement: in a valid fragment on a closed disc of radius above 1 about a vertex p of four colours and no more, Siamese pairs allowed, let w be a point of ω(p) in the closure of a tile of one of p's colours which is not a change point of the ring and lies on no arc of Γ on ω(p), and suppose none of the four arcs of ω(p) just clockwise and just counter-clockwise of w + 60° and w − 60° lies on a (Q) arc; then the ring just clockwise and just counter-clockwise of w lies in tiles of one colour X absent at p, each of the four arcs lies in the closure of a tile of the other absent colour X̄ and of no tile of colour X, and no tile of colour X̄ has w in its closure
- uses: FS116-N1-TWIST-D; N-E1; FS116-N1-GERM-R with c = X̄ at all four germs, whose four open intervals cover every direction; six colours, spent once; w ∈ D is used only to place w on Γ — the conclusions hold at every point of ω(p) off the arcs of Γ on ω(p), not a change point, with its four germs off (Q) arcs (V3 § 4.4)
- not claimed: that such a point exists in any fragment of SAT-QFREE's class; anything at k ≥ 7; anything when a germ lies on a (Q) arc
- handoff/kernel: de Bruijn — the statement, queued behind D6's map type
- dependents (index, direct/transitive): 1/4

### row 110 — FS116-N2-FIVERING (upstream; plans/FS116-derivation.md:655)
- grade: hand | minds: 1 | verdict: derived
- needs: FS116-N1-TWIST-D
- statement: in a valid fragment on a closed disc of radius above 1 about a vertex p of five colours, Siamese pairs allowed, the ring has no change point, and for every θ outside a finite set r(θ) or r(θ + 60°) lies on a (Q) arc; so the (Q) arcs of the ring have total length at least 180° and p has no hub
- uses: FS116-N1-TWIST-D; N-E1; FS116-N1's L1 (a ring arc of Γ excludes its side colours 60° away); that p's four or more colours make a non-(Q) ring arc have an absent side colour
- not claimed: anything at k ≥ 7; that a five-colour vertex occurs in any fragment
- handoff/kernel: none — a relay-result for the ring-type list; crosses to Lean with TWIST-D
- dependents (index, direct/transitive): 2/2

### row 111 — FS116-N2-SIXRING (SEED; plans/FS116-derivation.md:635)
- grade: derived from: FS116-N1-TWIST-D | minds: 1 | verdict: derived
- needs: FS116-N1-TWIST-D
- statement: in a non-Siamese valid fragment on a closed disc of radius above 1 about a vertex p of six colours, the ring lies in Γ and is six consecutive closed 60° arcs Z_i = [α + 60°i, α + 60°(i + 1)], each the whole set of ring points in the closure of one tile t_i of p; t_i lies in the Reuleaux triangle Reul(p, z_i, z_(i+1)) on its arc, with cone at p in [α + 60°i − 30°, α + 60°i + 90°]; every ring arc is a (Q) arc, and every outer tile along a non-degenerate subarc of Z_i has the colour of t_(i+2), t_(i+3) or t_(i+4); the ring has no change point, so p has no hub
- uses: FS116-N1-TWIST-D (a ring point off Γ carries a colour absent at p); non-Siamese (the inner tile of a ring arc is p's tile of its colour, and an outer tile is far from p's tile of its colour); that a tile has diameter at most 1 and a chord over more than 60° exceeds 1
- not claimed: that any valid fragment has a six-colour vertex beyond radius 3/2; an exclusion of the type at any radius (FS116-Y2-SIXOFF's family stops below √3; the general type is open); anything in the Siamese class (there an inner tile need not be p's)
- handoff/kernel: de Bruijn — with TWIST-D, queued behind D6's map type; a relay-result for any exclusion of six-colour vertices
- dependents (index, direct/transitive): 2/2

### row 112 — FS116-N3-PAIR (SEED; plans/FS116-derivation.md:1396)
- grade: hand | minds: 2 — blind to: N3's record until 3647075d; method: the same route; the same model (Opus 5.5), one prior | verdict: derived
- needs: 
- statement: in a non-Siamese simple valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, if both germs of one pair at a change point of the ring lie on (Q) arcs and the two arcs have the same pair of colours, then the inner colour of each is the outer colour of the other
- uses: that the inner tile of a (Q) arc is the tile of p of its colour and holds the arc; that a germ's arc holds the germ's ring point (u or v) in its closure; |u − v| = √3; non-Siamese; diameter at most 1
- not claimed: anything about two (Q) arcs that are not at the germs of one pair; that a full parallel semi-hub occurs at six colours beyond FS114-Y2-BOWTIE
- handoff/kernel: de Bruijn — with FS114-N7-QOPP, queued behind D6's map type
- dependents (index, direct/transitive): 3/5

### row 113 — FS116-N3-STAR2 (SEED; plans/FS116-derivation.md:1414)
- grade: derived from: FS116-N3-PAIR | minds: 1 | verdict: derived
- needs: FS114-N7-QOPP, FS116-N3-PAIR
- statement: in a non-Siamese simple valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, let y = r(ψ) be a full semi-hub of kind O with (Q) arcs A = [ψ + 60°, ψ + 60° + ℓ] of inner colour a and outer a′ and B = [ψ − 60° − m, ψ − 60°]; if B's colours b (inner) and b′ (outer) are disjoint from a, a′, then ℓ + m ≤ 60° and the tiles of p are, counter-clockwise, t_b, t_a, t_b′, t_a′ with edges t_b|t_a in [ψ + ℓ − 30°, ψ + 30° − m], t_a|t_b′ in [ψ + 30°, ψ + 150°], t_b′|t_a′ in [ψ + 150° + ℓ, ψ + 210° − m] and t_a′|t_b in [ψ + 210°, ψ + 330°]; if B's colours are a′ (inner) and a (outer), then t_a ⊂ [ψ + 30°, ψ + 150°], t_a′ ⊂ [ψ + 210°, ψ + 330°], and the other two tiles' cones contain [ψ − 30°, ψ + 30°] and [ψ + 150°, ψ + 210°]
- uses: FS114-N7-QOPP's windows (one mind; re-derived in the stage's preamble from N-E1 and non-Siamese at the unit pairs (p, r(θ))); FS116-N3-PAIR; that p has four tiles in cyclic order (non-Siamese, simple, four colours); that A starts at u and B ends at v (u⁻, v⁺ off (Q) arcs); 0 < ℓ, m ≤ 60°
- not claimed: the windows of a crossed semi-hub of kind T (computed in § 2.3's spirit but not entered); that any star in the windows is realised
- handoff/kernel: de Bruijn — with FS114-N7-QOPP
- dependents (index, direct/transitive): 3/4

### row 114 — FS116-O1-SATPIN (SEED; plans/FS116-derivation.md:54)
- grade: derived from: FS111-M-PINCH, FS111-M-C11 | minds: 2 — blind to: the first derivation until 3daaa05c, not to FS111-M-PINCH's case split, which both routes use (item 31's r … | verdict: derived
- needs: FS111-M-C11, FS111-M-PINCH
- statement: let p be a vertex of at least four colours of a valid k-coloured fragment saturated on a disc about p, every tile at p with a cone of positive angle; each edge e at p (a boundary arc between tiles of two different colours), with side colours a (clockwise) and b (counter-clockwise) and unit normal ν pointing to b's side, is near p of at least one of two types — (split) an arc of the unit circle about a point y of ω(p) at which both a and b have support, a unit arc of kind both; or (tangent) a segment or an arc of radius at least 1 along which every x has x + ν(x) in the closure of colour a and x − ν(x) in the closure of colour b, so that p + ν(p) carries a and p − ν(p) carries b, two antipodal points of ω(p) on the normal to e at p; and every colour of p is carried on ω(p)
- uses: FS111-M-PINCH and FS111-M-C11 at the interior points of e, where (H1) and (H2) hold (two tiles meet there, each locally connected, e being a segment or an arc of a fragment); that supports are closed; that the split points of e's interior are open (M-C11 (iii)) and closed (a limit y of split centres y_n has |x − y| = 1 and carries both colours, and M-PINCH run with y as both contacts is (split)),  …
- not claimed: anything at a cusp at p; that the split centre y has four colours (FS112-N3-NOBOTH gives four colours or a repeated colour, and FS111-W-NOREP removes the repeat only on cusp-free saturated maps); that any saturated valid six-coloured fragment about a four-colour vertex exists; that the strip's midli …
- handoff/kernel: de Bruijn — with FS111-M-PINCH and FS111-M-C11, queued behind the measurable chain: the statement, its cusp exclusion, and the inner-disc reading of saturation for fragments
- dependents (index, direct/transitive): 3/6

### row 115 — FS116-N1-AXIS (SEED; plans/FS116-derivation.md:571)
- grade: derived from: FS116-N1-GERM-R | minds: 2 — blind to: N1's record until 7245b6eb; method: N-E2 for (a) and saturation's definition for (b), so V3's (b) does not … | verdict: derived
- needs: FS116-N1-GERM-R, FS116-O1-SATPIN
- statement: let p be a degree-4 vertex of four colours of a valid fragment on a closed disc of radius above 1 about p, saturated on a disc about p, whose four edges are segments along the four half-axes, with tiles coloured c_I, c_II, c_III, c_IV by quadrant and absent colours X, X̄; then at q_N = p + (0, 1): (a) every tile approaching q_N along a direction below the horizontal has colour X or X̄; (b) a tile of colour c_IV approaches q_N along 0⁺ and one of colour c_III along 180⁻, both above the line y = 1; (c) the arcs of ω(p) just counter-clockwise of r(30°) and just clockwise of r(150°) lie on no (Q) arc; (d) if the arcs just clockwise of r(30°) and just counter-clockwise of r(150°) lie on no (Q) arc, every tile approaching q_N along a direction below the horizontal has one colour, and q_N is not a change point; and at each of the axis points q_E, q_W, q_S, read with the quadrants turned with it
- uses: N-E1 on the dip of ω(z) below p through the four tiles (a); FS116-O1-SATPIN in its corrected wording (two minds) at the four edges near p (b); GERM-S's interval argument on a (Q) arc's side tiles and FS116-N1-GERM-R (c); FS116-N1-GERM-R and six colours (d); (a) and (d) use no saturation (FS116-V3 § 3.6: the strip satisfies both)
- not claimed: anything for four segments not at right angles; anything at k ≥ 7 for (d) (at k = 9 SQ9 fails it); that the axis points are touch points in any fragment saturated on B̄(p, 1); SAT-STRIP
- handoff/kernel: de Bruijn — the statement at q_N with the quarter-turn symmetry; queued behind SATPIN and D6's map type
- dependents (index, direct/transitive): 1/4

### row 116 — FS116-O1-YESLIM (SEED; plans/FS116-derivation.md:30)
- grade: hand | minds: 2 — blind to: the first derivation until V1's verdicts were committed (3daaa05c); method: the Rajchman step by a compact … | verdict: derived
- needs: 
- statement: for every k ≥ 1, if for every R > 0 some closed disc of radius R carries a valid k-coloured fragment (a map of an open set containing the disc, bounded by segments and circular arcs, k-coloured with no two interior points of one colour at distance exactly 1), then χ_m⁰(ℝ²) ≤ k; at k = 6, then χ(ℝ²) ≤ 6, with no MR
- uses: that each fragment's tile boundaries are Lebesgue-null (countably many segments and arcs); that the circle measure σ on S¹ is Rajchman, σ̂(ξ) = J₀(|ξ|) → 0; weak-* compactness of the unit ball of L^∞; the definition of χ_m⁰ (a Lebesgue-measurable colouring whose unit pairs are bichromatic at (Leb ⊗ σ)-almost every pair); for the MR-free clause, χ(ℝ²) ≤ χ_m⁰(ℝ²) (row 130; `[GwynStavrianos2022]` Lem …
- not claimed: the converse (a measurable a.e.-proper six-colouring gives no fragment: it need not be a map); that the limit colouring is a map, or saturated, or regular; anything about the fragments' centres, so nothing about C114-LOCAL-F's explicitness; χ(ℝ²) ≤ 6 from fragments on discs of one bounded radius
- handoff/kernel: de Bruijn — queued behind the measurable chain (row 131's weak-* step): the statement at every k, its not-claimed line, and the Rajchman lemma it rests on
- dependents (index, direct/transitive): 1/1

### row 117 — FS116-RING-GERM (SEED; plans/FS116-derivation.md:175)
- grade: derived from: FS116-N1-TWIST-D | minds: 2 — blind to: N1's argument until 81bfc5cb, given N7-HUB's one-line sketch in the list's § 8 (item 49's caveat); method: … | verdict: derived
- needs: FS116-N1-TWIST-D
- statement: in a non-Siamese valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, let y be a change point of the ring (the ring off Γ on both sides of y), X the colour of the ring just counter-clockwise of y and X̄ the colour just clockwise, and u⁻, u⁺, v⁻, v⁺ the arcs of ω(p) just clockwise and just counter-clockwise of the ring points y + 60° and y − 60°; then p has four colours and no more, X and X̄ are the colours absent at p, and (i) if neither v⁻ nor u⁺ lies on a (Q) arc, every direction at y in the open cone of 60° about the direction to p lies in the cone of a tile of p; (ii) if neither u⁻ nor v⁺ lies on a (Q) arc, every direction at y in the open cone of 60° about the direction away from p lies in the cone of a tile of a colour of p that is not a tile of p; (iii) if none of the four lies on a (Q) arc, y is a vertex of at least four colours
- uses: FS116-N1-TWIST-D (a ring point off Γ has a colour absent at p); N-E1; CL and N3-FACE (non-Siamese) for (i) and (iii) only — (ii) holds without them (V2-RG-THIN, V2 § 4.1 row 2); that a tile has diameter at most 1; six colours, spent at Step 1 and in the cone step (V2 § 4.1 row 3)
- not claimed: anything at k ≥ 7; that a change point with a germ on a (Q) arc has fewer than four colours (the strip's P₂ has four, with u⁺ and v⁻ on (Q) arcs); that the ring's change points are 60° apart (N6-RING60's conclusion, for (Q)-free rings)
- handoff/kernel: de Bruijn — the statement with its four germs, the six-colour step named, over TWIST-D; queued behind D6's map type
- dependents (index, direct/transitive): 18/28

### row 118 — FS116-N2-STAR (SEED; plans/FS116-derivation.md:673)
- grade: derived from: FS116-RING-GERM | minds: 1 | verdict: derived
- needs: FS116-N1-TWIST-D, FS116-RING-GERM
- statement: in a non-Siamese valid fragment on a closed disc of radius above 1 about a vertex p of four colours P, let y = r(ψ) be a change point of the ring, T_y the colours of the tiles of p at y and O_y those of the other tiles at y of colours of P; then C(y) = A(p) ⊔ T_y ⊔ O_y and A(y) = P ∖ (T_y ∪ O_y); every tile of p at y has its cone at p in [ψ − 90°, ψ + 90°], and the tile of p of each colour of O_y in [ψ + 90°, ψ + 270°]; every tile of p whose cone holds ψ + 90° or ψ − 90° in its interior has its colour in A(y); T_y is non-empty when v⁻, u⁺ lie on no (Q) arc and O_y when u⁻, v⁺ do
- uses: RING-GERM (i), (ii) (two minds); FS116-N1-TWIST-D; N-E1 at y; non-Siamese (one tile per colour at y; distinct tiles of one colour far apart); that a tile has diameter at most 1; six colours (every colour at y other than X, X̄ is in P)
- not claimed: anything at k ≥ 7; that T_y or O_y is a single colour (at a hub y has four, five or six colours); anything about the ring of y beyond its branches at p
- handoff/kernel: de Bruijn — with RING-GERM, queued behind D6's map type
- dependents (index, direct/transitive): 8/16

### row 119 — FS116-N2-ANTI (SEED; plans/FS116-derivation.md:714)
- grade: derived from: FS116-N2-STAR | minds: 1 | verdict: derived
- needs: FS116-N2-STAR
- statement: in a non-Siamese simple valid fragment on a closed disc of radius above 1 about a vertex p of four colours, let y = r(ψ) and y* = r(ψ + 180°) be hubs of p, and let ψ + 90° and ψ − 90° lie in the interiors of the cones at p of tiles t⁺ and t⁻; then t⁺ ≠ t⁻, A(y) = A(y*) = {c(t⁺), c(t⁻)}, T_y = O_(y*) and O_y = T_(y*), each a single colour, and y and y* have four colours and no more
- uses: FS116-N2-STAR at y and at y*; that p has exactly four tiles (non-Siamese and simple); that a cone is an interval
- not claimed: anything when an edge of p leaves at ψ + 90° or ψ − 90° (the strip: there the two missing pairs differ); anything at k ≥ 7
- handoff/kernel: de Bruijn — with STAR
- dependents (index, direct/transitive): 1/1

### row 120 — FS116-N2-RECIP (SEED; plans/FS116-derivation.md:694)
- grade: derived from: FS116-N2-STAR, FS116-N1-TOUCH | minds: 1 | verdict: derived
- needs: FS116-N1-TOUCH, FS116-N2-STAR
- statement: in a non-Siamese valid fragment on a closed disc of radius above 2 about a vertex p of four colours P, let y = r(ψ) be a hub of p with four colours and no more; the points of ω(y) at 60° on either side of p are r(ψ + 60°) and r(ψ − 60°); if p lies on no arc of Γ on ω(y) and the four arcs of ω(y) just clockwise and just counter-clockwise of those two points lie on no (Q) arc of y's ring, then p is a change point of y's ring, its two sides lying in the tiles of p that hold the directions ψ − 90° and ψ + 90°, whose colours are the two colours of A(y)
- uses: FS116-N2-STAR; FS116-N1-TOUCH (one mind: a point of D off Γ-arcs that is no change point has the other absent colour at none of its tiles); N-E1 at y; six colours (A(y) ⊂ P)
- not claimed: anything when an edge of p runs along ω(y) (then p lies on an arc of Γ on ω(y), a tactic edge centred at y when its sides are y's colours); that the hub has four colours in general; anything at k ≥ 7
- handoff/kernel: de Bruijn — with STAR and TOUCH
- dependents (index, direct/transitive): 2/3

### row 121 — FS116-N2-HEX6 (SEED; plans/FS116-derivation.md:731)
- grade: derived from: FS116-N2-RECIP | minds: 1 | verdict: derived
- needs: FS114-N7-HUB, FS116-N1-QFREE4, FS116-N2-RECIP, FS116-RING-GERM
- statement: in a non-Siamese simple valid fragment on a closed disc of radius above 2 about a vertex p of at least four colours whose ring carries no arc of Γ, the ring's change points include six hubs y_k = r(ψ + 60°k), k in Z/6, and of any four consecutive y_k at least one has a ring carrying an arc of Γ; in particular the six rings are not all free of arcs of Γ
- uses: FS116-N1-QFREE4 at p and at each recurring hub; RING-GERM's Step 1 and (iii) (two minds); FS116-N2-RECIP; N-E1 at y_(m−1) and y_(m+2) at a D-direction inside a tile; that p has four edges (non-Siamese, simple, four colours); six colours at (c)
- not claimed: that any Γ-free four-colour vertex exists in a valid six-coloured fragment; anything for rings free of (Q) arcs but carrying other arcs of Γ (N6-RING60's bends would be needed); anything at k ≥ 7; the placed vertices' rings beyond whether they carry an arc of Γ
- handoff/kernel: de Bruijn — with RECIP, STAR and TOUCH; a relay-result for D2 (the first shell of a Γ-free vertex holds a hub whose ring carries an arc of Γ)
- dependents (index, direct/transitive): 2/2

### row 122 — FS116-N2-HEX3 (SEED; plans/FS116-derivation.md:752)
- grade: derived from: FS116-N2-HEX6 | minds: 1 | verdict: derived
- needs: FS116-N2-HEX6
- statement: in HEX6's setting, if every y_k has four colours and no more, the set S of k whose y_k has a ring free of arcs of Γ is empty, one hub, or of the form {k, k+1}, {k, k+3}, {k, k+2} or {k, k+1, k+2}; with {k, k+3} the missing pairs of y_k and y_(k+3) are not complementary; with {k, k+2} or {k, k+1, k+2} the four edges of p leave at D_k, D_(k+1), D_(k+3), D_(k+4) (D_m = ψ + 30° + 60°m), y_k and y_(k+2) miss one pair and y_(k+1), y_(k+3), y_(k+4), y_(k+5) the complementary pair
- uses: FS116-N2-HEX6's steps (c) and (d); that two disjoint 2-subsets of a four-colour set are complementary
- not claimed: that any S of the list occurs; anything without four colours at every hub (then only HEX6)
- handoff/kernel: de Bruijn — with HEX6
- dependents (index, direct/transitive): 0/0

### row 123 — FS116-N3-CONE (SEED; plans/FS116-derivation.md:1374)
- grade: hand | minds: 1 | verdict: derived
- needs: FS112-N3-NOBOTH, FS112-U1, FS116-N1-GERM-R, FS116-RING-GERM
- statement: in a non-Siamese simple valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, at a change point y = r(ψ) of the ring: u⁻ off (Q) arcs gives R ⊂ B̄(r(ψ + 60°), 1); v⁻ off them gives R ∩ B(r(ψ − 60°), 1) = ∅; v⁺ off them gives R′ ⊂ B̄(r(ψ − 60°), 1); u⁺ off them gives R′ ∩ B(r(ψ + 60°), 1) = ∅; a germ on a (Q) arc bars both colours of that arc from an open half-circle of directions at y — (ψ + 30°, ψ + 210°) for u⁺, (ψ + 150°, ψ + 330°) for v⁻, (ψ − 150°, ψ + 30°) for u⁻, (ψ − 30°, ψ + 150°) for v⁺; and an edge at y between a tile inside B̄(w, 1) and a tile outside B(w, 1) is an arc of ω(w), whose centre w, if it carries both side colours, is a vertex of at least four colours
- uses: RING-GERM's Steps 1 and 2 (two minds); FS116-N1-GERM-R (one mind); FS112-N3-NOBOTH with FS112-U1 (two minds each), local at the centre; non-Siamese (distinct tiles of one colour at distance at least 1; no repeated colour at a point); that a tile has diameter at most 1
- not claimed: anything about a germ on a non-(Q) arc of Γ beyond RING-GERM's Step 1; the Siamese or non-simple class; anything at k ≥ 7
- handoff/kernel: de Bruijn — with RING-GERM and NOBOTH, queued behind D6's map type: the six half-planes at y and the edge clause
- dependents (index, direct/transitive): 3/4

### row 124 — FS116-N3-CROSS (SEED; plans/FS116-derivation.md:1469)
- grade: derived from: FS116-N3-STAR2, FS116-N3-CONE | minds: 2 — on every clause but the last; blind to: N3's record until 3647075d; method: FS116-V5-U1's cones at p (V5 § 3.4); the … | verdict: derived
- needs: FS114-N7-QOPP, FS116-N3-CONE, FS116-N3-STAR2, FS116-RING-GERM
- statement: in a non-Siamese simple valid fragment on a closed disc of radius above 2 about a vertex p of at least four colours, let y = r(ψ) be a crossed full semi-hub of kind O of the ring of p, u⁺ on a (Q) arc of inner colour a and outer colour a′ and v⁻ on one of inner colour b and outer colour b′; then every tile of p at y has a cone at y of zero angle, and the outer colours at y lie in {a′, b′}; if y has four colours and every tile at y a cone of positive angle at y, its outer colours are a′ and b′ and its missing pair is {a, b}, and, unless an edge of p runs along ω(y) at p, p is a change point of the ring of y, that ring being b just counter-clockwise of p and a just clockwise, and p is a semi-hub of kind O of the ring of y
- uses: FS116-N3-STAR2 (crossed); FS116-N3-CONE (b), (d); RING-GERM (i) at y (two minds); FS114-N7-QOPP at y (one mind); N-E1; non-Siamese and simple
- not claimed: that y has four colours; that p is a crossed semi-hub of y's ring; anything about y's ring away from p; anything at k ≥ 7
- handoff/kernel: de Bruijn — with STAR2 and RING-GERM
- dependents (index, direct/transitive): 1/2

### row 125 — FS116-RING-Q-PRIME (SEED; plans/FS116-derivation.md:201)
- grade: derived from: FS116-RING-GERM | minds: 1 | verdict: derived
- needs: FS116-RING-GERM
- statement: in a non-Siamese simple valid fragment on a closed disc of radius above 2 about a vertex p of at least four colours whose ring carries a (Q) arc, every change point of the ring whose points at ±60° on ω(p) lie on no (Q) arc is a vertex of at least four colours
- uses: RING-GERM (iii); that a (Q) arc whose closure holds a ring point holds one of its two germs
- not claimed: the change points with a point at ±60° on a (Q) arc (RING-Q, GAP); "lie on" read as the open arc (then a ±60° point may end a (Q) arc, as at the strip's P₂, and RING-GERM gives only one of the tip and the outer tile)
- handoff/kernel: de Bruijn — with RING-GERM
- dependents (index, direct/transitive): 0/0

### row 126 — FS116-RING-Q-PRIME-S (SEED; plans/FS116-derivation.md:475)
- grade: derived from: FS116-N1-GERM-S | minds: 1 | verdict: derived
- needs: FS116-N1-GERM-S
- statement: in a valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, Siamese pairs allowed, every change point of the ring whose points at ±60° on ω(p) lie on no closed (Q) arc is a vertex of at least four colours
- uses: FS116-N1-GERM-S (iii); that a (Q) arc whose closure holds a ring point holds one of its two germs
- not claimed: the change points with a point at ±60° on a (Q) arc (RING-Q, GAP)
- handoff/kernel: de Bruijn — with FS116-N1-GERM-S
- dependents (index, direct/transitive): 0/0

### row 127 — FS116-RING-TWIST-C (SEED; plans/FS116-derivation.md:129)
- grade: derived from: FS116-N1-TWIST-D | minds: 2 — blind to: N1's argument until V2's verdicts (81bfc5cb); method: the same route in substance (V2 § 4.2); the same mod … | verdict: derived
- needs: FS116-N1-TWIST-D
- statement: at a vertex p of at least four colours of a valid fragment on a closed disc of radius above 1 about p (Siamese pairs allowed, any degree), the set D of points of ω(p) in the closure of a tile of one of p's colours is closed and lies in the union of the arcs of Γ on ω(p) and finitely many points; and for every half-open 60° window W of ω(p) with W ∪ σ(W) disjoint from D: p has four colours and no more; off a finite set, every point of W ∪ σ(W) lies in the closures of tiles of a single colour, one of the two colours absent at p, and this colour differs at θ and at θ + 60° for θ in W; every edge on ω(p) meeting W ∪ σ(W) in an arc has one colour on both sides; W holds an odd number of colour changes — points of W at which that colour differs on the two sides — each lying in the closures of tiles of the two absent colours and of no other colour; every change point in W is a colour change, and a colour change in W that is not a change point lies on an edge on ω(p) with one colour on both sides; so W holds an odd number of change points when no such arc meets W, in particular in every non-Siamese simple fragment
- uses: FS116-N1-TWIST-D; N-E1; that a unit circle through a point of ω(p) centred 60° away crosses ω(p) there at 60°; six colours, spent once, at L2 (two absent colours make the colours at θ and θ + 60° complementary singletons); for the last clause, that a slit makes a tile meet itself and two tiles of one colour sharing an arc are close
- not claimed: anything at k ≥ 7; that any fragment of the class has a qualifying window (no held fragment has one: the strip's and the disk's D-free arcs are at most 60° and 87.83°); the parity of change points when a seam meets W (FS116-N1-TWIST-LIT: then it can fail)
- handoff/kernel: de Bruijn — the statement, its six-colour step L2 named, and TWIST-LIT's slit as the reason the counting word is colour changes
- dependents (index, direct/transitive): 4/19

### row 128 — FS116-RING-TRANSFER-C (SEED; plans/FS116-derivation.md:769)
- grade: derived from: FS116-N2-STAR, FS116-N2-RECIP, FS116-N2-ANTI, FS116-N2-HEX6, FS116-N2-SIXRING, FS116-N2-FIVERING | minds: 1 | verdict: derived
- needs: FS116-N1-TWIST-D, FS116-N2-ANTI, FS116-N2-FIVERING, FS116-N2-HEX6, FS116-N2-RECIP, FS116-N2-SIXRING, FS116-N2-STAR, FS116-RING-GERM, FS116-RING-TWIST-C
- statement: in a non-Siamese simple valid fragment on a closed disc of radius above 2 about a vertex p of at least four colours: a ring of five or six colours has no change point and places no vertex through RING-GERM, the six-colour ring being six 60° (Q) arcs, one per tile of p, each tile in the Reuleaux triangle on its arc; a ring of four colours places its hubs, and at each hub y = r(ψ) the ring of p and the tiles of p holding the directions ψ + 90° and ψ − 90° determine the colours of y as the absent pair of p, the tip colours and the outer colours, and the pair missing at y, which contains the colour of every tile of p holding ψ ± 90° inside its cone; when y has four colours and its ring meets no (Q) arc at the points r(ψ ± 60°) and no arc of Γ at p, p is a change point of y's ring between the two colours missing at y; two antipodal hubs whose flanking directions lie inside tiles of p miss the same pair and exchange tip and outer colour; and a ring free of arcs of Γ has, among any four consecutive of its six hubs, one whose ring carries an arc of Γ
- uses: FS116-N2-SIXRING, FS116-N2-FIVERING, FS116-N2-STAR, FS116-N2-RECIP, FS116-N2-ANTI, FS116-N2-HEX6, and through them RING-GERM (two minds), RING-TWIST-C (two minds), FS116-N1-TWIST-D, -QFREE4 and -TOUCH (one mind each)
- not claimed: that the ring type of p alone determines any of this (the star is an input); anything about the arcs of Γ on the placed vertex's ring outside B̄(p, 1); the recurrence of types with (Q) arcs (RING-TRANSFER-Q, GAP); that the rule is the same at k = 7 (every step spends six: two absent colours)
- handoff/kernel: de Bruijn — deferred with D6's map type, after a blind second mind on STAR, RECIP, ANTI and HEX6
- dependents (index, direct/transitive): 0/0

### row 129 — FS116-S1-CLUSTER (SEED; plans/FS116-derivation.md:836)
- grade: hand | minds: 1 | verdict: derived
- needs: 
- statement: in a valid k-coloured fragment, for any k, Siamese pairs allowed, let 𝒯 be a finite family of tiles of one colour c the union of whose closures is connected, and U a tile of colour c; if some point of that union is at distance below 1 from some point of cl U, every point of the union is at distance at most 1 from every point of cl U
- uses: validity; tiles are open and connected; the distances between two tiles form an interval; no point is at distance exactly 1 from every point of an open set
- not claimed: anything for an infinite family; that the tiles of 𝒯 are pairwise near
- handoff/kernel: de Bruijn — a short lemma on connected families of open sets; it crosses with RUNG
- dependents (index, direct/transitive): 2/4

### row 130 — FS116-S1-EXIT (SEED; plans/FS116-derivation.md:904)
- grade: hand | minds: 1 | verdict: derived
- needs: 
- statement: let 30° < b < 90° and −90° < a < −30°, y_b = e(b), y_a = e(a), y_3 = e(b + 60°), y_5 = e(a − 60°) and Λ = B(y_a, 1) ∩ B(y_b, 1); let γ on [0, t_e] be a C¹ curve with γ(0) = 0, γ(t) in Λ for 0 < t < t_e and γ(t_e) in ∂Λ other than 0, with left unit normal ν; if at t_e |γ + ν − y_3| ≤ 1, |γ − ν − y_5| ≤ 1, |γ − y_3| ≥ 1 and |γ − y_5| ≥ 1, then γ(t_e) + ν(t_e) = y_b or γ(t_e) − ν(t_e) = y_a
- uses: the left derivative of |γ − y_b|² (or |γ − y_a|²) at the first exit, which is non-negative; that the headings putting γ + ν in B̄(y_3, 1) form an arc of length at most 120° when |γ − y_3| ≥ 1; the identities P = y_b at the side's tangent heading, |y_b − y_3| = 1 and d|P − y_3|²/dβ = −2 cos(φ − b + 150°) there, with their mirrors for Q, checked symbolically; the signs on b − a > 60°
- not claimed: anything about colourings (it is a lemma on curves and four points); that such a curve exists
- handoff/kernel: de Bruijn — an elementary plane-geometry lemma; mechanical
- dependents (index, direct/transitive): 1/3

### row 131 — FS116-S1-RUNG (SEED; plans/FS116-derivation.md:854)
- grade: derived from: FS116-O1-SATPIN, FS116-S1-CLUSTER | minds: 2 — blind to: S1's record until 48534b7c, with item 108's caveat; method: FS116-V4-PARTNER (saturation at the edge point … | verdict: derived
- needs: FS116-O1-SATPIN, FS116-S1-CLUSTER
- statement: let p be a degree-4 vertex of four colours of a valid fragment whose four edges are segments along the four half-axes, with tiles coloured c_I, c_II, c_III, c_IV by quadrant, and suppose the fragment saturated at every point of the east edge's first segment [p, p + (ℓ, 0)], 0 < ℓ ≤ L_E; if a tile of colour c_IV has a point w in its closure with |w − q_N| < 1, q_N = p + (0, 1), then |w − p − (s, 1)| ≤ 1 for every s in [0, ℓ]; and the same at each edge and axis point, turned and reflected with the quadrants; in particular a contact of c_IV at r(φ), 90° < φ < 150°, gives ℓ ≤ cos φ + √(sin φ (2 − sin φ)), which at φ = 120° is FS116-Y1-STRIPCEIL's x* = √(√3 − 3/4) − 1/2
- uses: FS116-O1-SATPIN in FS116-V1's corrected wording (two minds: the edge is of tangent type, so (s, 1) lies in the closure of colour c_IV); local finiteness; FS116-S1-CLUSTER
- not claimed: anything at a partner point where the edge is not saturated; anything for edges that are not segments; that a contact exists in quadrant II in any fragment of SAT-STRIP's class (FS116-S1-LENS supplies one where the ring carries no (Q) arc)
- handoff/kernel: de Bruijn — with SATPIN; a rung-and-contact lemma
- dependents (index, direct/transitive): 0/0

### row 132 — FS116-V4-CHORD (upstream; plans/FS116-derivation.md:954)
- grade: hand | minds: 1 | verdict: derived
- needs: 
- statement: two points r(α), r(β) of a unit circle about p, at angular separation δ = |α − β| ∈ [0°, 180°], are at distance 2 sin(δ/2); so the distance is 1 at δ = 60°, below 1 for δ < 60° and above 1 for 60° < δ ≤ 180°; and for β > α the chord from r(α) to r(β) points in the direction (α + β)/2 + 90°
- uses: the law of cosines on the isosceles triangle p, r(α), r(β)
- not claimed: anything about circles of other radii
- handoff/kernel: none — a relay-result for stage 2
- dependents (index, direct/transitive): 3/8

### row 133 — FS116-V4-DICHOTOMY (upstream; plans/FS116-derivation.md:970)
- grade: hand | minds: 1 | verdict: derived
- needs: 
- statement: in a valid k-coloured fragment, for tiles A, B of one colour (A = B allowed), either every point of A is at distance below 1 from every point of B (write A ~ B) or every point of A is at distance above 1 from every point of B (A ⊥ B); A ~ A, so the closure of a tile has diameter at most 1; if points z ∈ cl A, z′ ∈ cl B have |z − z′| < 1 then A ~ B, and if |z − z′| > 1 then A ⊥ B; in a non-Siamese fragment A ~ B forces A = B
- uses: that A × B is connected and the distance is continuous on it
- not claimed: anything for tiles of different colours
- handoff/kernel: none — a relay-result for KAPPA, RUNG and QF
- dependents (index, direct/transitive): 5/10

### row 134 — FS116-V4-MEET (upstream; plans/FS116-derivation.md:986)
- grade: hand | minds: 1 | verdict: derived
- needs: FS116-V4-DICHOTOMY
- statement: if tiles A, B of one colour have a common closure point z, then for every tile T of that colour, T ~ A holds if and only if T ~ B
- uses: V4-DICHOTOMY, and that an open set is not contained in a circle
- not claimed: anything when cl A and cl B are disjoint
- handoff/kernel: none — RUNG's Siamese case rests on it
- dependents (index, direct/transitive): 1/6

### row 135 — FS116-V4-OUTER (upstream; plans/FS116-derivation.md:1035)
- grade: hand | minds: 1 | verdict: derived
- needs: FS116-V4-CHORD, FS116-V4-DICHOTOMY
- statement: in a non-Siamese valid fragment on a disc of radius above 1 about a degree-4 vertex p of four colours whose four edges are segments at right angles and whose ring carries no (Q) arc, at each of κ's change points c in an open quadrant, the directions within 30° of the outward direction at c lie in one tile, not a tile of p, of the colour of the quadrant tile opposite to c's quadrant
- uses: KAPPA's K6 (as derived in § 2.2), V4-DICHOTOMY, V4-CHORD
- not claimed: anything at a change point on an axis; anything for crosses not at right angles (there the colour of the tile above the far edge can qualify as well: § Attack on QF)
- handoff/kernel: none — QF rests on it
- dependents (index, direct/transitive): 1/6

### row 136 — FS116-V4-PARTNER (upstream; plans/FS116-derivation.md:1018)
- grade: hand | minds: 1 | verdict: derived
- needs: FS116-V4-DICHOTOMY
- statement: let x be an interior point of a segment edge of a valid k-coloured fragment from a point p, of direction u and first-segment length L, with tile T_a on its clockwise side and T_b on its counter-clockwise side, and ν = u turned by +90°; if the fragment is saturated at x, then x + ν lies in the closure of a tile of T_a's colour and x − ν in the closure of a tile of T_b's colour, and every tile of T_a's colour other than T_a whose closure meets ω(x) is far from T_a (⊥)
- uses: V4-DICHOTOMY, the half-discs of T_a and T_b at x, and T_a, T_b running along the whole open segment
- not claimed: anything when the edge is curved; anything at p itself or at the segment's far end (closure gives those points of supp only)
- handoff/kernel: none — RUNG and QF rest on it
- dependents (index, direct/transitive): 1/6

### row 137 — FS116-V4-TWIST (upstream; plans/FS116-derivation.md:1001)
- grade: hand | minds: 1 | verdict: derived
- needs: FS116-V4-CHORD, FS116-V4-DICHOTOMY
- statement: at a point p of a valid k-coloured fragment on a disc of radius above 1 about p, for any k, Siamese pairs allowed, no colour has a tile whose closure holds a germ g of ω(p) and a tile (the same or another) whose closure holds σg or σ⁻¹g; and a point of ω(p) inside a tile has that tile's colour absent at p when p is a vertex
- uses: V4-DICHOTOMY, V4-CHORD
- not claimed: anything about germs lying on Γ with the colour on neither side
- handoff/kernel: none — KAPPA rests on it
- dependents (index, direct/transitive): 1/6

### row 138 — FS116-S1-KAPPA (SEED; plans/FS116-derivation.md:795)
- grade: hand | minds: 2 — blind to: S1's record until V4's verdicts (48534b7c), told by its brief that a decided result rests on it (items 107 … | verdict: derived
- needs: FS116-V4-CHORD, FS116-V4-DICHOTOMY, FS116-V4-MEET, FS116-V4-OUTER, FS116-V4-PARTNER, FS116-V4-TWIST
- statement: at a vertex p of four colours and no more of a valid fragment on a closed disc of radius above 1 about p, Siamese pairs allowed, whose ring carries no (Q) arc, every germ of ω(p) (an arc just clockwise or just counter-clockwise of a ring point) lies in the closure of tiles of exactly one of the two colours absent at p, κ, and the germ 60° on carries the other; so κ's change points form a finite non-empty set invariant under the rotation by 60° about p, each half-open 60° window of ω(p) holds an odd number of them, and antipodal germs carry different colours; in a non-Siamese fragment κ's change points are exactly y + 60°ℤ for one ring point y
- uses: N-E1; local finiteness (a germ lies in one tile or on one arc of Γ on ω(p)); the definition of a (Q) arc; that ω(w) crosses ω(p) transversally at the ring points 60° from w; two absent colours, spent once, at (c); CL and a tile's diameter at most 1, for the last clause only
- not claimed: anything when the ring carries a (Q) arc; anything at k ≥ 7 (at k = 9 SQ9's r(45°) and r(225°) carry one colour); that any vertex of the class exists at six colours
- handoff/kernel: de Bruijn — with N-E1 and the germ convention; queued behind D6's map type
- dependents (index, direct/transitive): 2/5

### row 139 — FS116-S1-PAIR (SEED; plans/FS116-derivation.md:818)
- grade: derived from: FS116-S1-KAPPA | minds: 1 | verdict: derived
- needs: FS116-S1-KAPPA
- statement: in a valid fragment as in FS116-S1-KAPPA, let z be a point with 0 < |z − p| < 2, φ its direction from p and α = arccos(|z − p|/2), so that r(φ + α) and r(φ − α) are the ring points at distance 1 from z; if neither φ + α nor φ − α is a change point, no tile of colour κ(φ + α) or κ(φ − α) has z in its closure; in particular where κ(φ + α) ≠ κ(φ − α) only colours of p are carried at z
- uses: FS116-S1-KAPPA; N-E1 at an interior point z′ of a hypothetical tile near z, whose ring points lie in the same cells and off the finite exceptional set (z ↦ φ ± α is continuous and open); that ω(z′) crosses ω(p) transversally for 0 < |z′ − p| < 2
- not claimed: anything at a point whose ring point is a change point; which colours of p are carried
- handoff/kernel: de Bruijn — with FS116-S1-KAPPA
- dependents (index, direct/transitive): 1/4

### row 140 — FS116-S1-LENS (SEED; plans/FS116-derivation.md:882)
- grade: derived from: FS116-S1-KAPPA, FS116-S1-PAIR, FS116-N1-GERM-S, FS116-N1-AXIS | minds: 1 | verdict: derived
- needs: FS116-N1-AXIS, FS116-N1-GERM-S, FS116-S1-KAPPA, FS116-S1-PAIR
- statement: let p be a degree-4 vertex of four colours of a non-Siamese valid fragment on a closed disc of radius above 1 about p whose four edges are segments along the four half-axes and whose ring carries no (Q) arc; then no change point of κ lies on an axis; the least change point c_− and the greatest c_+ in (−90°, 90°) satisfy −90° < c_− < −30° and 30° < c_+ < 90°; the open lens Λ = B(r(c_−), 1) ∩ B(r(c_+), 1) meets no tile but T_I and T_IV; and r(c_+ + 60°) and r(c_− − 60°) are change points in the open quadrants II and III at distance below 1 from q_N and q_S, each holding in its closure an outward tile, of colour c_IV and c_I, while T_IV misses B(r(c_+ + 60°), 1) and T_I misses B(r(c_− − 60°), 1)
- uses: FS116-S1-KAPPA; FS116-S1-PAIR; FS116-N1-GERM-S (i), (ii) (two minds, FS116-V3) at change points, whose germs lie on no (Q) arc; FS116-N1-AXIS (a) (two minds, FS116-V3); CL; that a tile of p in B̄(y, 1), or missing B(y, 1), has its cone in the closed half-plane facing y, or facing away
- not claimed: rings with (Q) arcs; Siamese fragments (a tile Siamese-near T_II or T_III may meet Λ); crosses not at right angles; saturation is not used
- handoff/kernel: de Bruijn — with KAPPA, PAIR and GERM-S; queued behind D6's map type
- dependents (index, direct/transitive): 1/3

### row 141 — FS116-S1-QF (SEED; plans/FS116-derivation.md:931)
- grade: derived from: FS116-S1-LENS, FS116-S1-EXIT, FS116-S1-CLUSTER, FS116-O1-SATPIN | minds: 1 — and a second derivation by a different route (FS116-V4 § 2.4: the rung tiles cross in the crescent B(q, 1) ∖ B̄(p, 1 … | verdict: derived
- needs: FS111-W-NOBEND, FS116-O1-SATPIN, FS116-S1-CLUSTER, FS116-S1-EXIT, FS116-S1-LENS
- statement: no non-Siamese valid fragment on B̄(p, 2), saturated on B̄(p, 1), whose ring ω(p) carries no (Q) arc, has at p a degree-4 vertex of four colours whose four edges are segments at right angles
- uses: FS116-S1-LENS; FS116-S1-EXIT; FS116-S1-CLUSTER; FS116-O1-SATPIN in FS116-V1's wording and V1's L1 (the tangent partners are "out", so far from the tile they face); FS111-W-NOBEND and SATPIN's open-and-closed step along the interface (saturation on Λ ⊂ B(p, 1)); the Jordan curve theorem (two tiles cannot alternate four times about a point); local finiteness; that T_IV and T_I hold points near p wit …
- not claimed: SAT-STRIP itself (rings with (Q) arcs, Siamese fragments, crosses not at right angles stay open: § 2.5's G1–G3); anything at k ≥ 7 (at k = 9 SQ9 meets every other hypothesis); that the class is non-empty at six colours without the cross
- handoff/kernel: de Bruijn — the composition of LENS, EXIT and CLUSTER, queued behind SATPIN, M-PINCH and D6's map type
- dependents (index, direct/transitive): 2/2

### row 142 — FS116-V5-NE1 (upstream; plans/FS116-derivation.md:1256)
- grade: hand | minds: 1 | verdict: derived
- needs: 
- statement: in a valid k-coloured fragment, for any k, Siamese pairs allowed, if a point x lies in the closure of a tile of colour c, then no point z interior to a tile of colour c has |z − x| = 1; in particular every tile T lies in B(x, 1) for every x in cl T, so cl T lies in B̄(x, 1) and T has diameter at most 1
- uses: tiles open and connected; validity (no two interior points of one colour at distance exactly 1)
- not claimed: that T lies in the open disc B(x, 1) when x is a closure point of another tile of T's colour (only that z ∉ ω(x)); anything about points of Γ
- handoff/kernel: none — a relay-result for the stages that follow
- dependents (index, direct/transitive): 7/24

### row 143 — FS116-V5-OUT (upstream; plans/FS116-derivation.md:1314)
- grade: hand | minds: 1 | verdict: derived
- needs: 
- statement: in V5-RING's setting, let y = r(ψ) be a ring point and O a tile of colour c ∈ P, not a tile of p, with points y + s e(γ) for arbitrarily small s > 0 along a direction γ with cos(γ − ψ) > 0; then the cone at p of p's tile of colour c lies in the closed half-plane of directions [ψ + 90°, ψ + 270°]
- uses: validity; tiles open and connected; the expansion |e(ψ) + s e(γ) − s′ e(δ)|² = 1 + 2s cos(γ − ψ) − 2s′ cos(δ − ψ) + O(s² + s′²) (control `out-expansion`)
- not claimed: anything about the boundary directions ψ ± 90° of that cone (second order); anything when cos(γ − ψ) ≤ 0
- handoff/kernel: none — a relay-result for NBTIP, TIGHTLENS and STARFORCE
- dependents (index, direct/transitive): 2/16

### row 144 — FS116-V5-OUT2 (upstream; plans/FS116-derivation.md:1554)
- grade: hand | minds: 1 | verdict: derived
- needs: 
- statement: in V5-QCOL's setting (or V5-RING's), if an outer tile of colour c has a ring point r(θ) in its closure, then p's tile of colour c has its cone at p in [θ + 90°, θ + 270°]
- uses: an outer tile is open and disjoint from B(p, 1) (non-Siamese), hence lies in |w| > 1; |w − s e(δ)| = 1 has a small root s > 0 when w·e(δ) > 0 and |w| > 1 is close to 1
- not claimed: anything about the boundary directions of that cone
- handoff/kernel: none — a relay-result for CROSS
- dependents (index, direct/transitive): 2/4

### row 145 — FS116-V5-QCOL (upstream; plans/FS116-derivation.md:1518)
- grade: hand | minds: 1 | verdict: derived
- needs: FS116-V5-NE1
- statement: in this setting p has exactly four colours and X, X̄ are the two absent; a germ that lies on no (Q) arc "carries" an absent colour — the ring colour there if the germ is off Γ, else an absent side colour of the arc of Γ on ω(p) it lies on — namely X at u⁻ and v⁻ and X̄ at u⁺ and v⁺, and the hub's partner point (u or v) lies in the closure of a tile of that colour; a germ on a (Q) arc lies on an arc of ω(p) whose inner tile is p's tile of the inner colour and whose outer tile is not a tile of p; the two germs of one pair never lie on one (Q) arc, and a (Q) arc holding u⁺ (v⁻) and not u⁻ (v⁺) ends at u (v)
- uses: V5-NE1; non-Siamese; reading L at y; a circular arc of Γ containing a sub-arc of ω(p) lies on ω(p)
- not claimed: that a germ off (Q) lies off Γ; anything at k ≥ 7
- handoff/kernel: none — a relay-result for SEMI, PAIR, CROSS
- dependents (index, direct/transitive): 3/5

### row 146 — FS116-V5-RING (upstream; plans/FS116-derivation.md:1273)
- grade: hand | minds: 1 | verdict: derived
- needs: FS116-V5-NE1
- statement: at a point p of a valid six-coloured fragment on a closed disc of radius above 1 about p, non-Siamese, with at least four colours at p and Γ ∩ ω(p) containing no arc: Γ ∩ ω(p) is finite; every point of ω(p) off Γ is interior to a tile of one of the colours absent at p; p has exactly four colours, so exactly two are absent, X and X̄; the ring colour c satisfies c(θ + 60°) ≠ c(θ) off Γ; every tile T meeting ω(p) at r(θ₀) meets it only inside the open arc (θ₀ − 60°, θ₀ + 60°); two ring points off Γ of one colour less than 60° apart lie in one tile; and the change points are exactly y + 60°ℤ for one ring point y
- uses: V5-NE1; the non-Siamese hypothesis (for "one tile"); six colours (for "exactly two absent"); a locally finite union of segments and circular arcs not containing an arc of ω(p) meets ω(p) in finitely many points
- not claimed: anything with Siamese pairs (the step "one tile" fails there); anything at k ≥ 7; that the ring tile over an arc between consecutive change points touches no other ring point
- handoff/kernel: none — a relay-result for SIX and everything after it
- dependents (index, direct/transitive): 3/17

### row 147 — FS116-V5-GERM (upstream; plans/FS116-derivation.md:1294)
- grade: hand | minds: 1 | verdict: derived
- needs: FS116-V5-NE1, FS116-V5-RING
- statement: in V5-RING's setting, let y = r(ψ) be a change point, X₊ the ring colour just counter-clockwise of y and X₋ the one just clockwise; for β − ψ in each open interval below, every point y + t e(β′) with t > 0 small and β′ near β that is off Γ lies in a tile of the colours named: (−30°, 30°) a colour of p, on a tile that is not a tile of p (an outer tile); (30°, 90°) X₊ or an outer tile; (90°, 150°) X₊ or a tile of p; (150°, 210°) a tile of p; (210°, 270°) X₋ or a tile of p; (270°, 330°) X₋ or an outer tile; at y there is exactly one tile of colour X₊, the ring tile R₊ over the ring arc counter-clockwise of y, and one of X₋, R₋; so y is a vertex whose tiles, counter-clockwise, are outer tiles (covering ψ + (−30°, 30°)), R₊ (containing ψ + 90°), tiles of p (covering ψ + (150°, 210°)), R₋ (containing ψ + 270°), no tile colour being both a tip colour and an outer colour
- uses: V5-RING, V5-NE1, non-Siamese; the first-order motion of the two points of ω(z) ∩ ω(p) (control `germ-first-order`)
- not claimed: anything at the six boundary directions ψ + 30°k (second order decides there); anything when a germ lies on Γ
- handoff/kernel: none — a relay-result for TIPS onward
- dependents (index, direct/transitive): 2/16

### row 148 — FS116-V5-TIPSET (upstream; plans/FS116-derivation.md:1332)
- grade: hand | minds: 1 | verdict: derived
- needs: FS116-V5-NE1
- statement: in V5-RING's setting with the change points at y_k = e(60°k), let a tile T of p be a tip at y_k (y_k ∈ cl T); then cl T lies in B̄(y_k, 1) ∩ B̄(p, 1), its cone at p lies in [60°k − 90°, 60°k + 90°] and its cone at y_k in [60°k + 90°, 60°k + 270°]; T is a tip at no hub other than y_{k±1}, and at y_k and y_{k+1} only if its cone at p lies in [60°k − 30°, 60°k + 90°]; a tip at y_k and a tip at y_{k+3} have closures meeting only at p
- uses: V5-NE1; |y_k − y_{k+2}| = √3, |y_k − y_{k+3}| = 2 (control `hub-distances`)
- not claimed: that every hub has a tip (that is V5-GERM's (150°, 210°) clause); anything about tiles of p tipping no hub
- handoff/kernel: none — a relay-result for TIPS
- dependents (index, direct/transitive): 2/16

### row 149 — FS116-V5-LENS (upstream CYCLE; plans/FS116-derivation.md:1349)
- grade: hand | minds: 1 | verdict: derived
- needs: FS116-V5-GERM, FS116-V5-NE1, FS116-V5-OUT, FS116-V5-RING, FS116-V5-TIPSET, FS116-Y3-TIPS
- statement: in a non-Siamese simple valid six-coloured fragment on a closed disc of radius at least √3 about a vertex p of at least four colours whose ring carries no arc of Γ, labelled as FS116-Y3-TIPS, at the lens L_1 (hubs y_1, y_2, far vertex q_1 = √3 e(90°)): (a) every interior point of L_1 off Γ has colour X̄, 2 or 4; (b) no tile of colour X̄ has q_1 in its closure, and no tile of colour 4 with points in L_1 does; (c) every point of L_1 near q_1 lies in one tile Z of colour 2 or on Γ; (d) y_1 carries an outer tile of colour 4, its outer colours are 4 alone or 4 and 2, and in the second case the 2-tile is Z and comes after the 4-tile counter-clockwise from the ring tile R_{0,1}; (e) δ_4 = −30°; and, by the reflection in the line at 30° and the half-turn, the same at L_5 (δ_1 = 90°, Z of colour 2 at q_5, y_0's outer colours 3 alone or 2 then 3), at L_4 (δ_2 = 150°, colour 1 at q_4, y_4's outer colours 3 alone or 3 then 1) and at L_2 (δ_3 = 270°, colour 1 at q_2, y_3's outer colours 4 alone or 1 then 4)
- uses: V5-NE1, V5-RING, V5-GERM, V5-OUT, V5-TIPSET, FS116-Y3-TIPS and -NBTIP as derived here (§§ 2.3–2.4); radius √3 (only to have a neighbourhood of q_k); the exact facts of controls `hub-distances` and `astar-arc`
- not claimed: that any fragment of the class exists; anything below radius √3; anything in the Siamese or non-simple class; anything at k ≥ 7
- handoff/kernel: Keryx — V5-LENS proves more than FS116-Y3-TIGHTLENS states (each lens forces its first disjunct); the divergence table at stage 4 compares routes
- dependents (index, direct/transitive): 1/15

### row 150 — FS116-Y3-SIX (SEED CYCLE; plans/FS116-derivation.md:1074)
- grade: derived from: FS116-RING-TWIST-C, FS116-RING-GERM, FS116-N1-QFREE4 | minds: 2 — blind to: Y3's record until V5's verdicts (320a3b53); method: FS116-V5-RING (non-Siamese against a tile's 60° reach; … | verdict: derived
- needs: FS116-N1-QFREE4, FS116-RING-GERM, FS116-RING-TWIST-C, FS116-V5-GERM, FS116-V5-LENS, FS116-V5-NE1, FS116-V5-OUT, FS116-V5-RING, FS116-V5-TIPSET
- statement: in a non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours whose ring carries no arc of Γ, the ring has exactly six change points, 60° apart, each a hub, and p has exactly four tiles
- uses: FS116-N1-QFREE4 (four colours and no more at p); RING-TWIST-C (the ring's colours swapped by σ, an odd number of colour changes per half-open 60° window); RING-GERM (i) (a tip at each change point); that a tile of p has diameter at most 1 and lies in B̄(p, 1); non-Siamese and simple (four tiles)
- not claimed: anything in the Siamese class (there RING-GERM's tip is GERM-S's tile, not necessarily a tile of p, and the count is not run); anything at k ≥ 7 (SQ9 at k = 9 has twelve); that any such fragment exists
- handoff/kernel: de Bruijn — with RING-TWIST-C and RING-GERM, queued behind D6's map type
- dependents (index, direct/transitive): 3/15

### row 151 — FS116-Y3-TIPS (SEED CYCLE; plans/FS116-derivation.md:1095)
- grade: derived from: FS116-Y3-SIX, FS116-RING-GERM | minds: 2 — blind to: Y3's record until 320a3b53; method: the same argument (V5 § 4.1); the same model (Opus 5.5), one prior | verdict: derived
- needs: FS116-RING-GERM, FS116-Y3-SIX
- statement: in FS116-Y3-SIX's setting, with the hubs y_k = e(60k), each hub has exactly one tip, the tips of antipodal hubs are opposite tiles of p, and up to rotation of the labels the four tiles of p, counter-clockwise, are T1 tipping y_0 and y_1 (cone at p in [−30°, 90°]), T3 tipping y_2 (in [30°, 210°]), T2 tipping y_3 and y_4 (in [150°, 270°]) and T4 tipping y_5 (in [210°, 30°])
- uses: FS116-Y3-SIX; RING-GERM (i); that a tip of y lies in B̄(y, 1); that the closed unit discs about antipodal hubs meet only at p; that two tiles adjacent at p share a non-degenerate boundary curve from p
- not claimed: anything in the Siamese or non-simple class; that the cones fill their ranges (each δ is free in its interval); that any such fragment exists
- handoff/kernel: de Bruijn — with SIX; a relay-result for any exclusion of the Γ-free type
- dependents (index, direct/transitive): 7/15

### row 152 — FS116-V5-U1 (upstream; plans/FS116-derivation.md:1536)
- grade: hand | minds: 1 | verdict: derived
- needs: 
- statement: let A be an arc of Γ on ω(z), of angular extent [θ₁, θ₂] about z, θ₂ − θ₁ = ℓ > 0, with inner side colour c and outer side colour c′; a tile of colour c with z in its closure has its cone at z in the closed cone [θ₂ − 90°, θ₁ + 90°] facing A; one of colour c′ has it in the closed cone [θ₂ + 90°, θ₁ + 270°] facing away; the two open side cones (θ₁ − 90°, θ₂ − 90°) and (θ₁ + 90°, θ₂ + 90°) hold neither colour; so if z carries both c and c′ (A is both-kind), the side cones hold two further colours and, in a non-Siamese simple fragment, z has at least four colours
- uses: validity; first order of |z + (1 ∓ η) e(θ) − z − s e(δ)| = 1 ∓ η − s cos(δ − θ) + O(s² + η²)
- not claimed: anything when ℓ = 0; anything about tiles at z of other colours
- handoff/kernel: none — a relay-result
- dependents (index, direct/transitive): 3/5

### row 153 — FS116-V5-DICHO (upstream; plans/FS116-derivation.md:1570)
- grade: hand | minds: 1 | verdict: derived
- needs: FS116-V5-NE1, FS116-V5-QCOL, FS116-V5-U1
- statement: in V5-QCOL's setting, if both germs of one pair at y lie on (Q) arcs A₁, A₂ with colour pairs Π₁, Π₂, then Π₁ = Π₂ (and then the inner colour of each is the outer colour of the other) or Π₁ ∩ Π₂ = ∅
- uses: V5-QCOL, V5-U1 at p, V5-NE1; simple (one sector per tile at p) and the four tiles of p
- not claimed: that either case occurs
- handoff/kernel: none — § 13's note asks that the dichotomy be checked, not given; here it is derived for every degree
- dependents (index, direct/transitive): 1/3

### row 154 — FS116-N3-SEMI (SEED; plans/FS116-derivation.md:1436)
- grade: derived from: FS116-N3-CONE, FS116-N3-STAR2, FS116-N3-PAIR | minds: 2 — blind to: N3's record until V5's verdicts (3647075d); method: FS116-V5-U1 for the centre's four colours and FS116-V5 … | verdict: derived
- needs: FS116-N2-STAR, FS116-N3-CONE, FS116-N3-PAIR, FS116-N3-STAR2, FS116-RING-GERM, FS116-V5-DICHO, FS116-V5-OUT2, FS116-V5-QCOL, FS116-V5-U1
- statement: in a non-Siamese simple valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, let y = r(ψ) be a semi-hub of the ring of p; then y is a vertex of at least four colours, or y is a vertex of exactly three colours one of whose edges at y is an arc of the unit circle about r(ψ + 60°) or about r(ψ − 60°) whose two side colours are both carried at that centre, which is then a vertex of at least four colours, or y is a full parallel semi-hub of exactly three colours — the two absent at p and the colour of the tile of p whose cone holds ψ + 180° (kind O) or ψ (kind T) in its interior
- uses: FS116-N3-CONE; FS116-N3-STAR2 and its kind-T parallel line (§ 2.3); FS116-N3-PAIR; RING-GERM (i), (ii) (two minds); FS116-N2-STAR's windows (one mind); non-Siamese and simple (three colours give three tiles, consecutive tiles share an edge); six colours, at RING-GERM's Step 1 and in C(y) = A(p) ⊔ T_y ⊔ O_y
- not claimed: that a semi-hub has four colours; that the third alternative occurs, or that it is excluded; anything at a closed change point (the disk's corner, FS116-N1-QDISK); Siamese or non-simple fragments; anything at k ≥ 7
- handoff/kernel: de Bruijn — with RING-GERM, NOBOTH and STAR, after a blind second mind; a relay-result for D2 (every semi-hub but the parallel three-colour one places a vertex of at least four colours on ω(p))
- dependents (index, direct/transitive): 1/2

### row 155 — FS116-RING-TRANSFER-QC (SEED; plans/FS116-derivation.md:1492)
- grade: derived from: FS116-N3-SEMI, FS116-N3-CROSS, FS116-N3-PAIR, FS116-N3-STAR2 | minds: 1 | verdict: derived
- needs: FS112-N3-NOBOTH, FS114-N7-QOPP, FS116-N1-GERM-R, FS116-N2-STAR, FS116-N3-CONE, FS116-N3-CROSS, FS116-N3-PAIR, FS116-N3-SEMI, FS116-N3-STAR2, FS116-RING-GERM
- statement: in a non-Siamese simple valid fragment on a closed disc of radius above 2 about a vertex p of four colours: at a semi-hub y = r(ψ) of p's ring a vertex of at least four colours lies at y, at r(ψ + 60°) or at r(ψ − 60°), unless y is a full parallel semi-hub of three colours, which are then the two absent at p and the colour of the tile of p holding ψ + 180° (kind O) or ψ (kind T) in its cone's interior; when the (Q) arcs at a semi-hub's other pair join the same two opposite tiles of p their inner colours are swapped; at a full semi-hub of kind O the four edges of p lie in FS116-N3-STAR2's windows; and at a crossed full semi-hub of kind O whose (Q) arcs have inner colours a, b and outer a′, b′, every tip has a cone of zero angle and the outer colours lie in {a′, b′}, and if y has four colours with cones of positive angle its missing pair is {a, b} and p — unless an edge of p runs along ω(y) — is a change point of y's ring, b counter-clockwise and a clockwise of it, and a semi-hub of kind O of that ring
- uses: FS116-N3-CONE, FS116-N3-PAIR, FS116-N3-STAR2, FS116-N3-SEMI, FS116-N3-CROSS, and through them RING-GERM and FS112-N3-NOBOTH (two minds each), FS116-N1-GERM-R, FS116-N2-STAR and FS114-N7-QOPP (one mind each)
- not claimed: anything at a closed change point; that the parallel three-colour semi-hub is excluded or occurs (SEMI-PAR3, GAP); that p is a crossed semi-hub of y's ring; anything about y's ring outside B̄(p, 1); that the rule is the same at k = 7 (RING-GERM's Step 1 and C(y) = A(p) ⊔ T_y ⊔ O_y spend six)
- handoff/kernel: de Bruijn — deferred with D6's map type, after a blind second mind on SEMI, PAIR, STAR2 and CROSS
- dependents (index, direct/transitive): 1/1

### row 156 — FS116-V6-HUBS (upstream; plans/FS116-derivation.md:1768)
- grade: hand | minds: 1 | verdict: derived
- needs: 
- statement: in a non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours whose ring carries no arc of Γ, m = 1: the change points are y_k = r(ψ₀ + 60°k), six of them; a tile of p tips at most two, and two only if consecutive
- uses: V6-DIAM (a tile has diameter at most 1, so its tipped change points lie in one closed 60° arc); V6-RING (six colours, at least four at p: exactly two absent colours, the ring alternating them under the 60° rotation); V6-WIN (an odd number m of change points in each half-open 60° window); V6-TIP (every change point has a tip, by B(u) ∩ B(v) ⊂ B(p), non-Siamese and six colours); four tiles at p, so  …
- not claimed: anything in the Siamese class; anything at k ≥ 7 (SQ9 at k = 9 meets every other hypothesis with twelve points of Γ on its ring, control v6-sq9); that any such fragment exists
- handoff/kernel: none — a step of FS116-V6's route to FS116-Y4-EMPTY; it travels with EMPTY's handoff
- dependents (index, direct/transitive): 4/7

### row 157 — FS116-V6-ANTI (upstream; plans/FS116-derivation.md:1832)
- grade: hand | minds: 1 | verdict: derived
- needs: FS116-V6-HUBS
- statement: in a non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours whose ring carries no arc of Γ, with its change points y_k (FS116-V6-HUBS), a tile tipping y_k and a tile tipping y_(k+3) share no edge at p
- uses: V6-DIAM (a tile tipping y lies in B̄(y)); B̄(y_k) ∩ B̄(y_(k+3)) = {p}
- not claimed: that the four tiles at p form a cycle of shared edges (that is simplicity, V6-COUNT's last step); anything at k ≥ 7
- handoff/kernel: none — a step of FS116-V6's route; with EMPTY
- dependents (index, direct/transitive): 2/4

### row 158 — FS116-V6-HUG (SEED; plans/FS116-derivation.md:1786)
- grade: hand | minds: 1 | verdict: derived
- needs: FS116-V6-HUBS
- statement: in a non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours whose ring carries no arc of Γ, with its change points y_k = e(60°k) (FS116-V6-HUBS), no tile T of p tips both y_0 and y_1 while being the only tip at each
- uses: V6-GERM (near a change point the X-tiles lie in B̄(u) ∖ B(v) and the X̄-tiles in B̄(v) ∖ B(u)); V6-TIP (the tip sector holds only colours of p, six colours); V6-DICH (non-Siamese: a point lies in the closure of at most one tile of each colour; two distinct tiles of one colour have interior distances all below or all above 1); V6-DIAM; the identity |a(s) − b(t)|² − 1 = −8 sin(s/2) sin(t/2) cos((s + …
- not claimed: anything about a tile tipping two adjacent hubs with a second tip at either; anything in the Siamese class (non-Siamese gives the uniqueness of the tip and of the two X̄-tiles; V6: "Validity alone kills it here; non-Siamese was used only for the uniqueness of R⁻, R⁺ and of the tip"); anything at k ≥ …
- handoff/kernel: de Bruijn — the pinning of the two edges to ω(y_1) and ω(y_0) and the trigonometric identity, a short kernel target, with EMPTY
- dependents (index, direct/transitive): 3/5

### row 159 — FS116-V6-COUNT (upstream; plans/FS116-derivation.md:1815)
- grade: hand | minds: 1 | verdict: derived
- needs: FS116-V6-ANTI, FS116-V6-HUBS, FS116-V6-HUG
- statement: in a non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours whose ring carries no arc of Γ, with V6-HUG, the tips force two antipodal doubly-tipped hubs and four double tiles: M = 4, s = 2, each hub of S has exactly two tips, and every tip at a hub of S is a double tile; the two hubs of S are antipodal, y_k and y_(k+3), each tipped by two of the four tiles
- uses: FS116-V6-HUBS (six hubs; a tile tips at most two, consecutive); FS116-V6-HUG (each double tile has a hub with two or more tips); V6-TIP (every hub has a tip); four tiles at p; counting incidences, Σ_h t_h ≤ M + 4; the edges of the hexagon y_0 … y_5
- not claimed: the contradiction (FS116-V6-ANTI and simplicity finish it); anything in the Siamese class; anything at k ≥ 7
- handoff/kernel: none — a step of FS116-V6's route; with EMPTY
- dependents (index, direct/transitive): 1/3

### row 160 — FS116-Y2-SIXFRAG (SEED; plans/FS116-derivation.md:365)
- grade: computed over: the 18 tiles of the fragment and their 36 same-colour pairs, exact in Q(√3, √7) | minds: 1 | verdict: derived
- needs: 
- statement: the unit sector flower S_j (colour j), the six lenses Q_j between e(60j − 30°) and e(60j + 30°) outside ω(p) (colour j + 2) and the six gap tiles G_j at e(60j + 30°) (colour j + 4), all cut at |x| = 3/2, form a valid non-Siamese six-coloured fragment holding B̄(p, R) for every R < 3/2, in which p is a vertex of six colours whose ring lies in Γ and all of whose ring arcs are (Q) arcs
- uses: exact arithmetic in Q(√3, √7) (the cut points have cosine 3/4 and sine √7/4 at the lens corners); FS114-YB's exact pair verdict (every candidate distance compared with 1) and its map-consistency test; the 36 same-colour tile pairs, self-pairs included
- not claimed: any R ≥ 3/2 in this form (at 8/5 each G_j exceeds diameter 1: the plant); that the fragment extends; Y-QRING (3/2 < φ²/√2); that a vertex of six colours occurs in any valid map
- handoff/kernel: de Bruijn — an exact fragment in Q(√3, √7) with its pair certificate, a control object for any local exclusion that claims six-colour vertices; not urgent
- dependents (index, direct/transitive): 0/0

### row 161 — FS116-Y3-HUBCOL (upstream; plans/FS116-derivation.md:1114)
- grade: derived from: FS116-Y3-TIPS, FS116-N2-STAR | minds: 1 | verdict: derived
- needs: FS116-N2-STAR, FS116-RING-GERM, FS116-Y3-TIPS
- statement: in FS116-Y3-TIPS's labelling, each hub's colours are X, X̄, its tip's colour and a non-empty set of outer colours drawn from the list of § 2.3 (y_0: 2, and 3 only if δ_1 = 90°; y_1: 2, and 4 only if δ_4 = −30°; y_2: 4, and 2 only if δ_2 = 210°, 1 only if δ_1 = 30°; y_3: 1, and 4 only if δ_3 = 270°; y_4: 1, and 3 only if δ_2 = 150°; y_5: 3, and 1 only if δ_4 = 30°, 2 only if δ_3 = 210°); when every δ is interior to its range, y_0, y_1, y_3, y_4 carry {1, 2, X, X̄} and y_2, y_5 carry {3, 4, X, X̄}
- uses: FS116-Y3-TIPS; FS116-N2-STAR; RING-GERM (ii)
- not claimed: that an outer colour the list allows occurs (the boundary values of δ are necessary for the extra outer colours, not sufficient); anything about the hubs' rings beyond their colours
- handoff/kernel: none — a relay-result for § 3 and the families
- dependents (index, direct/transitive): 2/4

### row 162 — FS116-Y3-NBTIP (upstream; plans/FS116-derivation.md:1212)
- grade: derived from: FS116-Y3-TIPS, FS116-N2-STAR | minds: 1 — and a checking reading by FS116-V5 (blind to Y3's record until 320a3b53, but its route and conclusion were N7-HUB's  … | verdict: derived
- needs: FS116-N2-STAR, FS116-RING-GERM, FS116-Y3-TIPS
- statement: in FS116-Y3-TIPS's setting, the tip of each hub meets the open unit disc about each of the two neighbouring hubs; so no hub has a neighbour's tip colour as an outer colour, and the only outer colour of y_2 is 4 and of y_5 is 3
- uses: RING-GERM (i) and FS116-Y3-TIPS (one tip per hub, whose cone holds the open 60° cone about the direction to p); FS116-N2-STAR (an outer colour's tile at p misses B(y, 1)); RING-GERM (ii) (an outer colour exists); that the direction from y_j to a neighbour is at 60° from the direction to p
- not claimed: anything about outer tiles of other colours; anything outside the Γ-free class (there consecutive change points need not be 60° apart)
- handoff/kernel: none — a relay-result for STARFORCE
- dependents (index, direct/transitive): 2/3

### row 163 — FS116-Y3-NOQ (SEED; plans/FS116-derivation.md:1150)
- grade: derived from: FS116-Y3-SIX | minds: 1 | verdict: derived
- needs: FS116-RING-GERM, FS116-Y3-SIX
- statement: in FS116-Y3-TIPS's setting, at a hub y_k, no tile adjacent at y_k to the ring tile over the arc from y_(k−1) to y_k lies in B̄(q_k, 1), and no tile adjacent at y_k to the ring tile over the arc from y_k to y_(k+1) lies in B̄(q_(k−1), 1), where q_k = y_k + y_(k+1); in particular the clockwise-most outer tile at y_k does not have q_k in its closure, the counter-clockwise-most does not have q_(k−1), and an only outer tile has neither
- uses: FS116-Y3-SIX (the ring arc between consecutive hubs lies in one tile, off finitely many points); that a tile has diameter at most 1; that tiles adjacent at a vertex share a non-degenerate boundary curve; |y_(k−1) − q_k| = |y_(k+1) − q_(k−1)| = 2 with midpoint y_k; the cyclic order of the tiles at a hub (RING-GERM's cones, and that an outer tile has points outside B̄(p, 1))
- not claimed: anything at change points of rings carrying arcs of Γ (there a ring tile need not reach the next change point); anything about outer tiles adjacent to neither ring tile
- handoff/kernel: de Bruijn — with SIX and TIPS; a relay-result for any exclusion of the Γ-free type
- dependents (index, direct/transitive): 5/5

### row 164 — FS116-Y3-TIGHT (upstream; plans/FS116-derivation.md:1132)
- grade: derived from: FS116-Y3-TIPS | minds: 1 | verdict: derived
- needs: FS116-RING-GERM, FS116-Y3-TIPS
- statement: in FS116-Y3-TIPS's labelling, the ring tile clockwise of y_0 does not have q_5 = √3 e(330°) in its closure, the ring tile counter-clockwise of y_1 not q_1, the one counter-clockwise of y_3 not q_2, the one clockwise of y_4 not q_4; at y_0 and y_1 the tip T1's cone has the endpoint 210°, at y_3 and y_4 the tip T2's the endpoint 30°, each along an edge inside the unit disc about the double tip's other hub
- uses: FS116-Y3-TIPS; RING-GERM (i); that a tile with a point q in its closure lies in B̄(q, 1); |y_1 − q_5| = |y_0 − q_1| = |y_4 − q_2| = |y_3 − q_4| = 2 with midpoints y_0, y_1, y_3, y_4
- not claimed: anything about the ring tiles over the double tips' arcs (between y_0, y_1 and between y_3, y_4); that the four ring tiles named do not reach beyond their hubs' discs
- handoff/kernel: none — a relay-result for § 3 and the families
- dependents (index, direct/transitive): 2/5

### row 165 — FS116-Y3-LENS (upstream; plans/FS116-derivation.md:1170)
- grade: derived from: FS116-Y3-TIPS, FS116-Y3-TIGHT, FS116-Y3-NOQ | minds: 1 | verdict: derived
- needs: FS116-Y3-NOQ, FS116-Y3-TIGHT, FS116-Y3-TIPS
- statement: in FS116-Y3-TIPS's labelling, for k in {1, 2, 4, 5} and every point x close enough to q_k inside B(y_k, 1) ∩ B(y_(k+1), 1), every colour at x is a colour of p other than the tip colours of y_k and y_(k+1); and if it is a colour of y_k (of y_(k+1)), that hub's tile of that colour has q_k in its closure
- uses: FS116-Y3-TIPS; FS116-Y3-TIGHT's argument (the ring tile R_(k,k+1) does not lie in B̄(q_k, 1)); FS116-Y3-NOQ's first clause for the ring tile over the arc before y_k; the straddle principle; non-Siamese (a c-coloured point within 1 of a hub's c-tile belongs to it); |q_k| = √3, |q_k − e(60k + 30°)| = √3 − 1, |q_k − y_(k−1)| = 2
- not claimed: anything at q_0 or q_3 (beside the double tips, where the ring tile may reach the far vertex); anything at points of the lens away from q_k
- handoff/kernel: none — a relay-result for TIGHTLENS
- dependents (index, direct/transitive): 2/4

### row 166 — FS116-Y3-TIGHTLENS (SEED; plans/FS116-derivation.md:1189)
- grade: derived from: FS116-Y3-LENS, FS116-Y3-NOQ, FS116-Y3-HUBCOL | minds: 2 — blind to: Y3's record until 320a3b53; method: FS116-V5-LENS (the lens corner at the far vertex) against Y3's NOQ and … | verdict: derived
- needs: FS116-Y3-HUBCOL, FS116-Y3-LENS, FS116-Y3-NOQ
- statement: in a non-Siamese simple valid six-coloured fragment on a closed disc of radius at least √3 about a vertex p of at least four colours whose ring carries no arc of Γ, labelled as FS116-Y3-TIPS, the edges of p satisfy (Q1) δ_4 = −30° or δ_1 = 30° or δ_2 = 210°; (Q2) δ_3 = 270° or δ_1 = 30° or δ_2 = 210°; (Q4) δ_2 = 150° or δ_4 = 30° or δ_3 = 210°; (Q5) δ_1 = 90° or δ_4 = 30° or δ_3 = 210° — for each lens beside a single tip, the tip of one of its two hubs is tight at p for that hub; so at least two edges of p lie along flanking directions of hubs, and no such fragment has a generic star
- uses: FS116-Y3-LENS; FS116-Y3-NOQ; FS116-Y3-HUBCOL's list of candidate outer colours; that the domain of a fragment on B̄(p, R), R ≥ √3, contains a neighbourhood of each q_k
- not claimed: that any star satisfying (Q1)–(Q5) occurs; anything below radius √3 (a generic star there is neither excluded nor built); anything in the Siamese or non-simple class; anything at k ≥ 7 (a third absent colour survives near q_k)
- handoff/kernel: de Bruijn — with NOQ, LENS, TIPS and SIX, after a blind second mind; the generic star's exclusion at √3 is a relay-result for D2's case list
- dependents (index, direct/transitive): 1/3

### row 167 — FS116-Y3-STARFORCE (SEED; plans/FS116-derivation.md:1231)
- grade: derived from: FS116-Y3-TIGHTLENS, FS116-Y3-NBTIP, FS116-Y3-HUBCOL | minds: 2 — blind to: Y3's record until 320a3b53; method: FS116-V5-LENS with its images under the reflection at 30° and the half … | verdict: derived
- needs: FS116-Y3-HUBCOL, FS116-Y3-LENS, FS116-Y3-NBTIP, FS116-Y3-NOQ, FS116-Y3-TIGHTLENS
- statement: in a non-Siamese simple valid six-coloured fragment on a closed disc of radius at least √3 about a vertex p of at least four colours whose ring carries no arc of Γ, labelled as FS116-Y3-TIPS, the edges of p are δ_1 = 90°, δ_2 = 150°, δ_3 = 270°, δ_4 = −30° (FS116-N2-HEX3's star); 3 is an outer colour of y_0 and of y_4, and 4 of y_1 and of y_3; each of these four hubs has that outer colour alone or two outer tiles, counter-clockwise 2, 3 at y_0; 4, 2 at y_1; 1, 4 at y_3; 3, 1 at y_4; and near q_1, q_5 the lens points carry colour 2, near q_2, q_4 colour 1
- uses: FS116-Y3-TIGHTLENS's argument (FS116-Y3-LENS with FS116-Y3-NOQ at the four lenses beside the single tips); FS116-Y3-NBTIP; FS116-Y3-HUBCOL's cone conditions for the outer colours of the double-tip hubs
- not claimed: that any such fragment exists, at any radius; anything below radius √3; anything in the Siamese or non-simple class; anything at k ≥ 7
- handoff/kernel: de Bruijn — with NOQ, LENS, NBTIP, TIPS and SIX, after a blind second mind; a relay-result for D2: the Γ-free type's case list is one star
- dependents (index, direct/transitive): 2/2

### row 168 — FS116-Y4-FLANK (SEED; plans/FS116-derivation.md:1684)
- grade: hand | minds: 1 | verdict: derived
- needs: 
- statement: let t be a tile of a valid fragment, Siamese pairs allowed, on a closed disc of radius above 1 about a point p, and let y = r(ψ) and y′ = r(ψ + 60°) be points of ω(p) in the closure of t such that the cone of t at y contains the open cone (ψ + 150°, ψ + 210°) and its cone at y′ contains (ψ + 210°, ψ + 270°); then t's cone at y ends at ψ + 210° and its cone at y′ begins at ψ + 210°, and if a is the tile bordering t at y along t's edge leaving y in the direction ψ + 210°, and b the tile bordering t at y′ along t's edge leaving y′ in the direction ψ + 210°, some point of the closure of a and some point of the closure of b are at distance below 1
- uses: that a tile has diameter at most 1, so t ⊂ B̄(y, 1) ∩ B̄(y′, 1); that near a vertex an edge of Γ is a segment or a circular arc (a second-order expansion); |y − y′| = 1 with y′ − y = e(ψ + 120°)
- not claimed: anything about the colours of a and b; that a ≠ b; that the cones contain the open cones (an input, here from RING-GERM (i))
- handoff/kernel: de Bruijn — a short lemma about two arcs inside two unit discs, after a blind second mind
- dependents (index, direct/transitive): 1/3

### row 169 — FS116-Y4-EMPTY (SEED; plans/FS116-derivation.md:1712)
- grade: derived from: FS116-Y4-FLANK, FS116-Y3-SIX, FS116-Y3-TIPS, FS116-RING-GERM | minds: 2 — blind to: FS116-Y4's record until its verdict's commit (2429e200), though given the frozen list with round 3's const … | verdict: derived
- needs: FS116-N2-STAR, FS116-RING-GERM, FS116-V6-ANTI, FS116-V6-COUNT, FS116-V6-HUBS, FS116-V6-HUG, FS116-Y3-SIX, FS116-Y3-TIPS, FS116-Y4-FLANK
- statement: no non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours has a ring carrying no arc of Γ
- uses: FS116-Y3-SIX (six change points y_k, hubs, the ring alternating X and X̄, four tiles at p); FS116-Y3-TIPS (one tip per hub; a tile tipping two adjacent hubs); RING-GERM (i) and (ii) (the tip cone and the outer cone at a hub); FS116-N2-STAR (C(y) = A(p) ⊔ T ⊔ O); FS116-Y4-FLANK; non-Siamese
- not claimed: anything for rings carrying an arc of Γ that is not a (Q) arc (the (Q)-free rings of FS114-N6-RING60 after the bends, with (R2) arcs); anything in the Siamese or non-simple class; anything at k ≥ 7 (with three absent colours the flank tiles need not share a colour)
- handoff/kernel: de Bruijn — by either route, the first with FLANK, SIX, TIPS and RING-GERM, or FS116-V6's (FS116-V6-HUBS, -HUG, -COUNT, -ANTI, hand, using no statement of the frozen list), the shorter; for D2, the Γ- …
- dependents (index, direct/transitive): 2/2

### row 170 — FS116-Y4-SYM (upstream; plans/FS116-derivation.md:1625)
- grade: hand | minds: 1 | verdict: derived
- needs: FS116-Y3-TIPS
- statement: let F be a fragment of the HEX3 class on B̄(p, R), R ≥ √3; then σ_30(F), with the colours 3 and 4 exchanged, and σ_120(F), with the colours 1 and 2 exchanged and X and X̄ exchanged, are fragments of the HEX3 class on B̄(p, R) with the same labels — σ_30 fixing T1 and T2 and exchanging T3 and T4, σ_120 exchanging T1 and T2 and fixing T3 and T4 — so every statement of this record about F at a point z holds at σ(z) with the colours so exchanged
- uses: that σ_30 and σ_120 are isometries fixing p; that a bijection of the colours preserves validity, non-Siamese and simplicity; the cones, hubs, tips and ring colours of FS116-Y3-TIPS's labelling and the edges of HEX3's star, mapped by hand (§ 2.1) and checked as a table (control fs116-y4-sym)
- not claimed: that any fragment of the class is symmetric; anything about stars other than HEX3's
- handoff/kernel: none — a bookkeeping lemma for the casework of this record
- dependents (index, direct/transitive): 1/2

### row 171 — FS116-Y4-SPOKE (SEED (conditional: handoff begins `none`); plans/FS116-derivation.md:1645)
- grade: derived from: FS116-Y3-STARFORCE, FS116-Y3-NBTIP, FS116-RING-GERM, FS116-Y4-SYM | minds: 1 | verdict: derived
- needs: FS116-RING-GERM, FS116-Y3-NBTIP, FS116-Y3-NOQ, FS116-Y3-STARFORCE, FS116-Y4-SYM
- statement: in a fragment of the HEX3 class on a closed disc of radius above 2 about p, the outer tile O_2 of y_2 (colour 4) has 2y_2 in its closure, lies in B̄(y_2, 1) ∩ B̄(2y_2, 1), and contains every point of some neighbourhood of 2y_2 that lies in B(y_2, 1) and off Γ; every tile with a point of that neighbourhood outside B̄(y_2, 1) in its closure has colour 3, X or X̄; so near 2y_2 the circle ω(y_2) lies in Γ, with inner colour 4; and the same at y_5 and 2y_5 with 3 and 4 exchanged
- uses: FS116-Y3-STARFORCE (the lens colours near q_1 and q_2; HEX3's star); FS116-Y3-NBTIP (y_2's only outer colour is 4); RING-GERM (ii) (O_2's cone at y_2 holds (90°, 150°)); FS116-Y3-NOQ's argument (R_12 and R_23 hold the open ring arcs); non-Siamese; diameter at most 1; |2y_2 − q_1| = |2y_2 − q_2| = 1, |2y_2 − e(90°)|² = |2y_2 − e(150°)|² = 5 − 2√3; FS116-Y4-SYM for y_5
- not claimed: that the outer colour at 2y_2 is 3 (X and X̄ are not excluded there when the ring tiles' cones at y_2 do not meet the outer side of the ring); anything below radius 2; anything at the double-tip hubs; anything at k ≥ 7 (a seventh colour survives inside ω(y_2) near 2y_2)
- handoff/kernel: none — a relay-result for the obstruction or the construction of this record; with STARFORCE, after its blind check, a candidate for de Bruijn
- dependents (index, direct/transitive): 1/1

### row 172 — FS121-C1-BOUND (SEED; plans/FS121-derivation.md:710)
- grade: hand | minds: 2 — blind to: FS121-C1's record until V4's verdicts were committed (0dde4982); method: a switch point over the local fin … | verdict: derived
- needs: 
- statement: in a locally finite map colouring, a point x of F_i ∖ S_i is i-bound if and only if it lies on the outer unit parallel or on the far level of a connected component of F_i
- uses: no two points of faces of one colour at distance exactly 1, faces open; closedness and connectedness of components; the intermediate value theorem on a connected set; 1-Lipschitz d_C and D_C; no local finiteness beyond F_i = cl S_i
- not claimed: which of the two levels; that the component is unique; anything at points of S_i
- handoff/kernel: de Bruijn — queued behind the measurable chain (FS-113): a short lemma on closed connected sets and one perturbation
- dependents (index, direct/transitive): 2/4

### row 173 — FS121-C1-GMAP (SEED CYCLE; plans/FS121-derivation.md:732)
- grade: derived from: FS121-C1-BOUND | minds: 2 — blind to: FS121-C1's record until 0dde4982; method: the same route (one mind on the method axis), V4 writing out R7' … | verdict: derived
- needs: FS121-C1-BOUND, FS121-D3-GRUNDY
- statement: (i) for every k, a Grundy-bound k-colouring that is a.e. equal to a locally finite map colouring makes that map colouring a member of 𝒫_k under the order 1 < 2 < … < k; (ii) G-FIN₆ and C121-NOPAR together imply χ_m⁰(ℝ²) ≥ 7, and given C121-NOPAR, G-FIN₆ holds if and only if χ_m⁰(ℝ²) ≥ 7
- uses: FS121-C1-BOUND; supports are invariant under null changes and equal closures for open sets; the definition of χ_m⁰ (row 130); vacuity
- not claimed: G-FIN₆; that a Grundy-bound colouring of a map colouring is again a map colouring
- handoff/kernel: de Bruijn — with FS121-D3-GRUNDY, once map colourings and supports are in Lean
- dependents (index, direct/transitive): 1/2

### row 174 — FS121-D3-GRUNDY (SEED CYCLE; plans/FS121-derivation.md:516)
- grade: hand | minds: 2 — blind to: D3 § 2.2 until dea603eb; method: exhaustion (dependent choice) and a ball added at a support point (V3), a … | verdict: derived
- needs: FS111-M-SATC, FS111-M2-ZERO, FS121-C1-GMAP
- statement: every a.e.-proper k-colouring (S_1, …, S_k) of the plane can be modified, keeping it a.e.-proper with k colours and never raising a point's colour index, into a measurable Grundy colouring (A_1, …, A_k): A_1 is a MUA set, each A_m is maximal among sets with null unit pairs inside the complement of A_1 ∪ … ∪ A_(m−1) that contain S_m minus that union, every point of the support of A_m is at distance exactly 1 from the support of A_i for every i < m, and so at every essential boundary point x every colour of P(x) other than the largest is bound at x
- uses: maximal extension inside a region (Zorn with FS111-M-SATC (i)'s chain argument, D3; exhaustion by a weighted measure, dependent choice only, V3); a ball of A_m added to A_i where A_i's support misses the unit circle (V3), or FS111-M2-ZERO's relative form and a limit (D3)
- not claimed: that the colour max P(x) is bound (the output need not be saturated); uniqueness; that the output lies above f in any order; any regularity of the classes; that a saturated input stays saturated
- handoff/kernel: de Bruijn — queued behind the measurable chain; its dependent-choice route matters to a ZF + DC audit (Soifer's Open AC Problem 62.14)
- dependents (index, direct/transitive): 2/2

### row 175 — FS121-C1-SAT (SEED; plans/FS121-derivation.md:751)
- grade: derived from: FS121-C1-BOUND | minds: 2 — blind to: FS121-C1's record until 0dde4982; method: the same route (one mind on the method axis) | verdict: derived
- needs: FS121-C1-BOUND
- statement: for every k, a locally finite map colouring with k colours whose edges are finite chains of segments and circular arcs, and whose classes form an honest saturated colouring, is a member of 𝒫_k under every total order of its colours; so C121-NOPAR implies that no honest saturated six-colouring is a.e. equal to a locally finite map colouring whose edges are finite chains of segments and circular arcs
- uses: FS121-C1-BOUND; densities 1/2 on each side of a smooth arc; saturation at essential boundary points; closedness of F_j + S¹
- not claimed: the converse (a member of 𝒫_k need not be saturated); anything for edges that are not finite chains
- handoff/kernel: de Bruijn — queued behind FS121-C1-BOUND and the saturated-colouring definitions (FS-113)
- dependents (index, direct/transitive): 0/0

### row 176 — FS121-D1-XCORNER (upstream; plans/FS121-derivation.md:228)
- grade: hand | minds: 1 | verdict: derived
- needs: 
- statement: at a convex corner z of angle θ in (0, π) whose two edges are straight, the inner unit parallels of the two edges meet at the point at distance 1/sin(θ/2) from z on the bisector, the image of the points at distance cot(θ/2) from z along each edge
- uses: plane trigonometry
- not claimed: anything about colourings (a statement about lines)
- handoff/kernel: none — elementary; it crosses with FS121-D1-EROSION
- dependents (index, direct/transitive): 1/5

### row 177 — FS121-D2-EXT (SEED; plans/FS121-derivation.md:607)
- grade: hand | minds: 1 | verdict: derived
- needs: FS111-M-C11, FS111-M2-INTRAD
- statement: in an honest saturated colouring in D-NF satisfying REG-J′, let a be a point of an interface arc, not in Σ, at which the arc passes from a circular piece γ of radius n ≥ 3 and centre z to a piece not on γ's circle, and let L be the normal line at a; then for every integer k with 1 ≤ k ≤ n − 2, and for every integer k ≤ −1, no arc of the circle ∂B(z, n − k) that lies on the far side of L from γ and has an end on L lies in the closure of the interface set
- uses: FS111-M2-INTRAD step (1) on either side, iterated |k| times; FS111-M-C11 and its clause (iii); REG-J′; two distinct circles, or a circle and a line, tangent at a point meet only there near it; no cusp-freeness
- not claimed: anything about a continuation past L along another curve; anything when a is a point of Σ; the unit rung, n − k = 1
- handoff/kernel: de Bruijn — queued behind FS111-M-PINCH, FS111-M-C11 and FS111-M2-INTRAD; its geometric core is elementary
- dependents (index, direct/transitive): 2/4

### row 178 — FS121-D2-THIN (upstream; plans/FS121-derivation.md:632)
- grade: derived from: FS121-D2-EXT | minds: 1 | verdict: derived
- needs: FS111-M2-INTRAD, FS121-D2-EXT
- statement: in an honest saturated colouring in D-NF satisfying REG-J′, if interface pieces whose radii tend to infinity accumulate at a point, then for every integer r ≥ 2 the colouring has infinitely many radius-r arcs — maximal arcs of circles of radius r contained in the closure of the interface set — whose angular windows tend to 0
- uses: FS111-M2-INTRAD step (2) and (iii); REG-J′; parallel curves share normals; FS121-D2-EXT at each piece's two junctions; no cusp-freeness
- not claimed: that the thin arcs lie in a bounded set; the converse; anything at r = 1; accumulations by segment pieces (the argument takes circular pieces; V5 § 3.3 supplies the segment case at one mind, over M2-INTRAD's per-radius finiteness)
- handoff/kernel: none — a necessary condition on an uninhabited class; it crosses with FS121-D2-SYM
- dependents (index, direct/transitive): 2/3

### row 179 — FS121-D3-FALLSAT (SEED; plans/FS121-derivation.md:498)
- grade: hand | minds: 2 — blind to: D3 § 2.1 until dea603eb; method: the same small-ball argument, reached independently (one mind on the meth … | verdict: derived
- needs: FS111-C-FILL
- statement: every partition of the plane, up to a null set, into k measurable sets each maximal among measurable sets with null unit pairs (a measurable idomatic partition of the unit-distance graph, the classes of a measurable fall colouring) is an honest saturated a.e.-proper k-colouring
- uses: maximality of each class alone: a small ball added where a class's support misses a point's unit circle keeps null unit pairs (FS111-C-FILL's estimate; V3's Lemma B)
- not claimed: the converse — a saturated honest colouring need not be idomatic (FS121-D3-SWAP1D); that any idomatic partition exists with fewer than seven classes
- handoff/kernel: de Bruijn — queued behind the measurable chain (FS-113)
- dependents (index, direct/transitive): 1/1

### row 180 — FS121-D4-FACE (SEED; plans/FS121-derivation.md:908)
- grade: hand | minds: 2 — blind to: D4 §§ 2.1–2.2 until V5's verdicts were committed (4ed402c6); method: a Fubini pair lemma and a crossing cr … | verdict: derived
- needs: 
- statement: in an a.e.-proper measurable colouring, let x be a point, e a unit vector and e⊥ a unit vector orthogonal to it; if the open half-box {x − s e + t e⊥ : 0 < s < ε, |t| < ε} and the open box {x + s e + t e⊥ : g < s < g + ε′, |t| < ρ} both lie almost everywhere in one class S_c, with ε, ε′ > 0 and 0 < 2g < ρ², then no point of supp S_c is at distance exactly 1 from x; so in a saturated colouring the colour c has density 1 at x
- uses: a.e.-properness, through Fubini on Leb ⊗ σ; the unit circle's sagitta; saturation only in the last clause, at the one point x
- not claimed: the same with a curved near side (a tangent unit disc admits the in-contact x − e); the margin below ρ² ≥ 2g − g² (FALSE there, FS121-V5-FACE-SHARP); anything at an x where c has density 1; honesty, D-NF, REG-J′ (none is used)
- handoff/kernel: de Bruijn — a short measure-theoretic lemma (Fubini on Leb ⊗ σ, one trigonometric bound); it crosses with the measurable chain
- dependents (index, direct/transitive): 2/2

### row 181 — FS121-DB1-L3 (SEED; plans/FS121-derivation.md:143)
- grade: hand | minds: 2 — blind to: each other's records (DB1 § 2.3 opened by V2 only after f537b8c9); method: a straddle with a tangent/unit- … | verdict: derived
- needs: FS111-M-C11, FS111-M-PINCH
- statement: in an honest saturated colouring in D-NF satisfying REG-J′, at every point of Σ no colour occupies two sectors of positive angle, whatever cusps are present at the point or elsewhere
- uses: the local fan REG-J′ gives; FS111-M-PINCH and FS111-M-C11 at points of the sectors' edges; C-HULL's first clause (DB1); Lemma H, the component lemma at contacts inherited along the edges (V2)
- not claimed: that a colour cannot occupy a sector and a cusp, or two cusps, at one point (the first is FS121-V2-SECTOR); anything without REG-J′
- handoff/kernel: de Bruijn — queued behind FS111-M-PINCH, FS111-M-C11 and the measurable chain
- dependents (index, direct/transitive): 4/25

### row 182 — FS121-DB1-L7 (upstream; plans/FS121-derivation.md:207)
- grade: hand | minds: 1 | verdict: derived
- needs: FS111-M-C11, FS111-M-PINCH, FS111-M2-INTRAD
- statement: in an honest saturated colouring in D-NF, the unit parallel away from the centre of a tangent-type interface arc is, at every point off Σ, a tangent-type interface of radius one more; REG-J′ is not used
- uses: FS111-M-PINCH's tangent contacts; FS111-M2-INTRAD step (1) away from the centre; FS111-M-C11 (iii)
- not claimed: the family over the whole window (that uses REG-J′, FS121-O1-OUT); the same for split arcs (FALSE at R7)
- handoff/kernel: none — it crosses with FS121-O1-OUT
- dependents (index, direct/transitive): 1/9

### row 183 — FS121-O1-ENDS (SEED; plans/FS121-derivation.md:20)
- grade: hand | minds: 2 — blind to: FS121-O1's § 3.2–3.4 until its verdicts were committed (43bb6385); method: DB1 reads the local fan REG-J′  … | verdict: derived
- needs: FS111-M-HALF, FS111-M-PINCH, FS111-M2-INTRAD, FS111-W-NOREP, FS112-N3-NOBOTH, FS121-DB1-L3
- statement: in an honest saturated colouring in D-NF satisfying REG-J′, the chain of unit parallels of an interface arc of finite radius ends, off a null set of normals, at a unit arc J_1 whose centre z carries J_1's outer colour; either z also carries J_1's inner colour — J_1 is of kind both and z is a vertex with at least four colours or a repeated colour, at least four when no colour at z has density 0, so J_1 is (Q) — or it does not — J_1 is (R2), and z is a point of Σ carrying at least three colours counted by sector — the outer colour and at least two further sectors of positive angle — and at least three distinct colours when no colour at z has density 0
- uses: FS111-M2-INTRAD steps (1)–(2) (the chain toward the centre stops at radius 1 or at Σ); FS111-M-PINCH's two types; C-HULL's first clause; FS112-N3-NOBOTH's sector argument with N112-U1's cones; FS121-DB1-L3 for the no-repeat step (FS111-W-NOREP, which the first derivation cited, does not reach a centre whose neighbours at distance 1 carry cusps); FS111-M-HALF; no colour count
- not claimed: that every chain ends at a (Q) arc; that an (R2) end exists in any saturated colouring; that an (R2) centre has four colours; that the centre has four colours of positive density (FALSE at R7: |P(z)| = 3 with six colours carried)
- handoff/kernel: de Bruijn — queued behind FS111-M-PINCH, FS111-M2-INTRAD and the measurable chain (FS-113)
- dependents (index, direct/transitive): 1/1

### row 184 — FS121-V2-EROSION-DIAM (upstream; plans/FS121-derivation.md:308)
- grade: hand | minds: 1 | verdict: derived
- needs: FS111-M-HULL2
- statement: in every a.e.-proper colouring, if a colour's sector at z has angle θ in (0, π) and both its edges begin with straight pieces of the boundary of one component of that colour, of lengths L₁ and L₂, then min(L₁, L₂) ≤ 1/(2 sin(θ/2)); so for θ ≤ 2π/3, min(L₁, L₂) ≤ cot(θ/2)
- uses: a component of a class has diameter at most 1 (FS111-M-HULL2); 1/(2 sin(θ/2)) ≤ cot(θ/2) when cos(θ/2) ≥ 1/2
- not claimed: anything for θ in (2π/3, π)
- handoff/kernel: none — it places FS121-D1-EROSION's content
- dependents (index, direct/transitive): 1/5

### row 185 — FS121-V3-CPI (upstream; plans/FS121-derivation.md:469)
- grade: hand | minds: 1 | verdict: derived
- needs: 
- statement: in an honest saturated colouring in D-NF satisfying REG-J′, at a point of Σ every region of positive angle has angle at most π
- uses: Lemma C and the contacts at z inherited along a region's two edges (V3 § 2.3's lemmas)
- not claimed: anything about zero-angle regions
- handoff/kernel: none — a corollary inside FS121-V2-SECTOR's verification
- dependents (index, direct/transitive): 1/20

### row 186 — FS121-V2-SECTOR (SEED; plans/FS121-derivation.md:450)
- grade: hand | minds: 2 — blind to: V2 § 2.3 until V3's verdicts were committed (dea603eb; V3 was relayed two definition lines of V2's record, … | verdict: derived
- needs: FS111-M-C11, FS111-M-PINCH, FS121-DB1-L3, FS121-V3-CPI
- statement: in an honest saturated colouring in D-NF satisfying REG-J′, at every point of Σ, a colour that occupies a sector of positive angle occupies no other region there, of positive or of zero angle
- uses: Lemma C (a.e.-properness); FS111-M-PINCH's contacts on the normal line and FS111-M-C11's bound |κ| ≤ 1 at points of the sector's edges near the point; the fan at the point (REG-J′ read with the essential boundary in a small disc about z the finitely many arcs at z)
- not claimed: that a colour cannot occupy two zero-angle regions at one point (they are collinear, FS121-V3-CUSP); anything without REG-J′; that the point itself is saturated (not used)
- handoff/kernel: de Bruijn — queued behind FS111-M-PINCH, FS111-M-C11 and the measurable chain
- dependents (index, direct/transitive): 5/19

### row 187 — FS121-V2-VT-W (upstream; plans/FS121-derivation.md:267)
- grade: derived from: FS121-V2-SECTOR | minds: 1 | verdict: derived
- needs: FS111-M-C11, FS111-M-PINCH, FS111-M2-INTRAD, FS121-V2-SECTOR
- statement: in a cusp-free honest saturated colouring in D-NF satisfying REG-J′, let I be a tangent-type interface arc between colours a and b, ν its normal into b, and x₀ an interior point of I that is not in the closure of a sub-arc of I of radius 1 curving toward b ending at an endpoint of I; let Y = x₀ + ν(x₀), P the closure of the radius-1 sub-arc of I curving toward b that contains x₀ in its closure if there is one and {x₀} otherwise, and L_Y the image under x ↦ x + ν(x) of a neighbourhood of P in I — a C¹ arc through Y when P = {x₀}, two branches meeting at Y at a corner otherwise; then no interface arc other than L_Y's branches ends at Y in the a-side region that L_Y bounds at Y (its far side, or the wedge between its branches)
- uses: Lemma C (a.e.-properness); FS111-M-PINCH and FS111-M-C11 along I and along L_Y off Σ; FS111-M2-INTRAD's chain form, only to name the corner case; FS121-V2-SECTOR; cusp-freeness only at Y for the colour a
- not claimed: anything at a point where a has density 0 (the double horn is not excluded); anything at the image of an endpoint of I; anything on L_Y's near side
- handoff/kernel: none — the wider form of FS121-D1-VT; it crosses with it if the corner case is consumed
- dependents (index, direct/transitive): 1/17

### row 188 — FS121-D1-VT (SEED; plans/FS121-derivation.md:243)
- grade: hand | minds: 2 — blind to: FS121-D1's § 2.1 until V2's verdicts were committed (f537b8c9); method: F2–F3 at points of L then FS121-V2 … | verdict: derived
- needs: FS111-M-C11, FS111-M-PINCH, FS111-M2-INTRAD, FS121-V2-SECTOR, FS121-V2-VT-W
- statement: in a cusp-free honest saturated colouring in D-NF satisfying REG-J′, let I be a tangent-type interface arc between colours a and b with no sub-arc of radius 1 curving toward b, and L its unit parallel on b's side, which carries a on its far side; at the image Y on L of any interior point of I, no interface arc ends at Y from the far side of L
- uses: FS111-M-PINCH's tangent partners with M-HULL1; FS111-M2-INTRAD step (1); REG-J′'s local finiteness and FS111-M-C11's end tangents; FS121-V2-SECTOR at Y (in place of D1's step "cusp-freeness gives every sector at Y positive angle", false under reading (Σ)); cusp-freeness only at Y for the colour a
- not claimed: anything at the image of an endpoint of I; anything when I has a sub-arc of radius 1 curving toward b (L has a corner: FS121-V2-VT-W); anything with cusps
- handoff/kernel: de Bruijn — queued behind FS111-M-PINCH, FS111-M2-INTRAD and the measurable chain: the statement with its no-radius-1 clause
- dependents (index, direct/transitive): 6/16

### row 189 — FS121-D1-EROSION (SEED; plans/FS121-derivation.md:288)
- grade: derived from: FS121-D1-VT, FS121-D1-XCORNER | minds: 2 — blind to: FS121-D1's §§ 1.3, 2.2 until f537b8c9; method: the same crossing (named in the statement, so given), VT ap … | verdict: derived
- needs: FS111-M-C11, FS121-D1-VT, FS121-D1-XCORNER, FS121-V2-EROSION-DIAM
- statement: in a cusp-free honest saturated colouring in D-NF satisfying REG-J′, if a colour's sector at a point z has angle θ in (0, π) and both its edges begin with maximal straight pieces of the colour's tile boundary of lengths L₁ and L₂, then min(L₁, L₂) ≤ cot(θ/2), or each of the two pieces has a point of Σ at distance cot(θ/2) from z
- uses: FS121-D1-VT on the straight branch through the crossing of the two inner partner lines (where L is C¹); FS121-D1-XCORNER; FS111-M-C11 (iii)
- not claimed: anything for curved edges; anything at θ ≥ π; anything with cusps; content at θ ≤ 2π/3, where the first disjunct holds in every a.e.-proper colouring (FS121-V2-EROSION-DIAM)
- handoff/kernel: de Bruijn — with FS121-D1-VT, queued behind the measurable chain
- dependents (index, direct/transitive): 1/4

### row 190 — FS121-D1-PENCILWIN (upstream CYCLE; plans/FS121-derivation.md:389)
- grade: derived from: FS121-D1-VT | minds: 1 | verdict: derived
- needs: FS111-M-HULL2, FS111-M2-INTRAD, FS121-D1-VT, FS121-O1-OUT, FS121-V2-SECTOR
- statement: in a cusp-free honest saturated colouring in D-NF satisfying REG-J′, a tangent-type interface arc of finite radius n ≥ 2 about z whose chain of unit parallels ends at a single unit arc lies in a pencil whose rungs of radius at least 2 share one window, of angular width ℓ with 4 sin(ℓ/2) ≤ 1
- uses: FS111-M2-INTRAD step (1) and FS121-O1-OUT (the windows nest both ways); FS121-D1-VT (i); one sector per colour (FS121-V2-SECTOR); FS111-M-HULL2; no colour count
- not claimed: any bound when the chain's inner end is broken by points of Σ; that such a pencil exists (C121-CURVED)
- handoff/kernel: none — a necessary condition on an uninhabited object; it crosses with FS121-O1-OUT if a curved inhabitant lands
- dependents (index, direct/transitive): 1/8

### row 191 — FS121-O1-OUT (SEED CYCLE; plans/FS121-derivation.md:44)
- grade: hand | minds: 2 — blind to: FS121-O1's § 3.3 until 43bb6385; method: the same held step, DB1 adding the radial images of points of Σ a … | verdict: derived
- needs: FS111-M-C11, FS111-M-PINCH, FS111-M2-INTRAD, FS121-D1-PENCILWIN, FS121-DB1-L7
- statement: in an honest saturated colouring in D-NF satisfying REG-J′, the unit parallel away from the centre of every tangent-type interface arc of radius n (n a positive integer, or infinite for a segment) is, off Σ, a tangent-type interface arc of radius n + 1; so every curved interface of tangent type lies in a one-sided infinite family of concentric interface arcs of radii n, n + 1, n + 2, … over one angular window
- uses: FS111-M-PINCH's tangent contacts; FS111-M2-INTRAD step (1) on the side away from the centre; FS111-M-C11 (iii); no colour count
- not claimed: that a saturated colouring with a curved tangent interface exists at any k (none is held); the same for split arcs (FALSE at R7, exact: ../tools/fs121_db1_r7parallel.py)
- handoff/kernel: de Bruijn — with FS111-M2-INTRAD, queued behind the measurable chain
- dependents (index, direct/transitive): 6/8

### row 192 — FS121-V5-LOC (upstream CYCLE; plans/FS121-derivation.md:1092)
- grade: hand | minds: 1 | verdict: derived
- needs: FS111-M-C11, FS111-M-PINCH, FS121-V5-RAY
- statement: in an honest saturated colouring in D-NF satisfying REG-J′ with interface set 𝓘: (i) cl 𝓘 ∖ Σ ⊆ 𝓘, and no point of 𝓘 is a density point of any class; (ii) each y ∈ cl 𝓘 ∖ Σ has a ball missing Σ in which cl 𝓘 is the graph of a C^{1,1} function over the tangent line at y; (iii) a circular or straight arc of positive length in cl 𝓘 is, at its points off Σ and its ends, interior to a piece on its own circle or line, of tangent type when its radius is not 1
- uses: the definitions of ∂_e and Σ (cusps); FS111-M-PINCH and FS111-M-C11 at points off Σ
- not claimed: anything at points of Σ
- handoff/kernel: none — local lemmas consumed by FS121-V5-RAY
- dependents (index, direct/transitive): 2/7

### row 193 — FS121-V5-RAY (SEED CYCLE; plans/FS121-derivation.md:1109)
- grade: derived from: FS121-V5-LOC | minds: 1 | verdict: derived
- needs: FS111-M-C11, FS121-V5-LOC
- statement: in an honest saturated colouring in D-NF satisfying REG-J′, let C_n ⊆ cl 𝓘 be arcs of circles of radii R_n → ∞, or segments, no two sharing a sub-arc of positive length, with points p_n ∈ C_n, p_n → x₀, from which C_n continues for arclength at least λ > 0 with unit tangent u_n → u; then Σ contains the open segment (x₀, x₀ + λu), so Σ is not locally finite
- uses: FS121-V5-LOC; FS111-M-C11; uniform convergence of the arcs to the ray
- not claimed: anything for arcs of bounded radius
- handoff/kernel: de Bruijn — a self-contained lemma over FS111-M-C11 that both routes to FS121-D2-SYM can rest on (item 79)
- dependents (index, direct/transitive): 3/7

### row 194 — FS121-D2-PERFIN (upstream CYCLE; plans/FS121-derivation.md:679)
- grade: derived from: FS121-D2-SYM | minds: 1 | verdict: derived
- needs: FS111-M2-INTRAD, FS121-D2-SYM
- statement: in a doubly periodic honest saturated colouring in D-NF satisfying REG-J′, with any number of colours, the interfaces carry only finitely many radii of curvature
- uses: FS121-D2-SYM; REG-J′ (finitely many interface arcs meet a compact set); FS111-M2-INTRAD (iii); compactness of an interface arc
- not claimed: anything for colourings that are not periodic; that a tight colouring can be taken periodic
- handoff/kernel: none — it removes a hypothesis from C121-PER's periodic clause; it crosses with FS121-D2-SYM
- dependents (index, direct/transitive): 1/1

### row 195 — FS121-D2-SYM (SEED CYCLE; plans/FS121-derivation.md:656)
- grade: derived from: FS121-D2-THIN | minds: 2 — blind to: D2 § 2 until V5's verdict was committed (ab25bbdc; V5 was relayed four header definitions of D2's record); … | verdict: derived
- needs: FS111-M-C11, FS111-M2-INTRAD, FS121-D2-EXT, FS121-D2-PERFIN, FS121-D2-THIN, FS121-O1-OUT, FS121-V5-RAY
- statement: in an honest saturated colouring in D-NF satisfying REG-J′, with any number of colours, if for some integer r ≥ 2 the angular windows of its radius-r arcs are bounded below by a positive constant — in particular if it is invariant under a group of isometries of the plane, each mapping the partition to itself up to a permutation of the colours, with a compact set whose images cover the plane, such as a doubly periodic colouring — then ¬LRA holds
- uses: FS121-D2-THIN (D2), or FS111-M2-INTRAD's parallel step, FS121-O1-OUT, FS111-M-C11 and FS121-V5-RAY (V5); for the in-particular clause and for segment pieces, FS111-M2-INTRAD's per-radius finiteness (one mind, VM2-FIN′); no colour count; no cusp-freeness
- not claimed: ¬LRA without such a bound (C121-NOLRA's open step); that a tight colouring can be taken symmetric; anything from a bound at r = 1
- handoff/kernel: de Bruijn — queued behind FS111-M2-INTRAD and the measurable chain (FS-113); V5's route needs only FS121-V5-RAY beyond held inputs
- dependents (index, direct/transitive): 1/1

### row 196 — TC1-SQRT3-DYADIC (SEED (conditional: handoff begins `none`); plans/TC1-derivation.md:8)
- grade: hand | minds: 1 | verdict: derived
- needs: 
- statement: for a number field F with √3 ∈ F and i ∉ F, no place of F above 2 is ramified in F(i)/F, and a place w above 2 splits in F(i) if and only if its residue degree f(w|2) is even; when it does not split it is inert, of norm 2^f with f odd
- uses: √−3 generates ℚ₄, the unramified quadratic extension of ℚ₂; F_w(i) = F_w(√−3) when √3 ∈ F_w; a compositum with an unramified extension is unramified over the smaller field; ℚ₄ lies in F_w when 2 divides f(w|2), and not otherwise
- not claimed: anything for F without √3 — ℚ(ζ₇)⁺'s one place above 2 is ramified in F(i) (TC1-FIELDS)
- handoff/kernel: none — a two-line local lemma that scopes G56's exclusion; it crosses to de Bruijn with that exclusion if it is formalized
- dependents (index, direct/transitive): 1/1

### row 197 — TC1-STANDING-FIVE (SEED (conditional: handoff begins `none`); plans/TC1-derivation.md:60)
- grade: derived from: TC1-SQRT3-DYADIC | minds: 1 | verdict: derived
- needs: TC1-SQRT3-DYADIC
- statement: F = K·E₇, with K = ℚ(√3,√11) and E₇ the degree-7 subfield of ℚ(ζ₂₉), is a totally real field of degree 28 containing K; its two places above 2 are inert in F(i), each of norm 128, and none of its places has a usable residue field of size at most 47; so L(F) ≥ 7, and given MR, χ(F²) ≥ 5
- uses: TC1-FIELDS (the decompositions, exact); TC1-SQRT3-DYADIC (f = 7 is odd, so inert — a cross-check); G56 (every usable plane from 59 up refuses six; U₁₂₈'s Hoffman floor is 8); row 123 (χ(F²) ≥ min(L(F), 5), given MR)
- not claimed: any value of χ(F²); that it is the smallest such field — ℚ(√3)·E₇, degree 14, has the same dyadic data and no small usable residue field, but does not contain K
- handoff/kernel: none — conditional on MR (row 120, [hand]); it crosses to de Bruijn only with row 123's chain
- dependents (index, direct/transitive): 0/0

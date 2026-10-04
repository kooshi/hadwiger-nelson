# FS-116 — the derivation file (the local exclusion)

*Written by the close job FS116-Z1 (Ephodos, Opus 5.5), 2026-10-03, assembled by `../tools/fs116_z1_derivation.py` from the job records' own
`derivation:` blocks, copied field by field, in the grammar of `.claude/skills/ephodos/SKILL.md` § the entry. Every id is qualified `FS116-…`; a
frozen name without the prefix (RING-GERM, SAT-STRIP, …) is filed as `FS116-<name>`, and a verifier's lemma `V4-…`, `V5-…` as `FS116-V4-…`,
`FS116-V5-…`. Every theorem FS-116 proved outside the kernel is one entry; the quotation readbacks (`FS116-*-QT`) are not mathematics and are
left in their records. A verifier's re-derivation is counted in its entry's minds, never filed twice. Grades translate as `hand` = [hand],
`derived from` = [derived], `computed over` = [tools]; verdict `derived` is TRUE, `gap:` and `stalls at:` are GAP. Minds and blindness are read
from the fence logs and commit order (`FS116-Z1-close.md` § Stage 2); every mind is Opus 5.5, one prior. **Held** means the announcement rule
(`FS116-close-inventory.md`, its top): a frozen statement, two minds, the second blind, its verdict committed first. Frozen names and the list's
sections are `../data/fs116/claims.md`'s, whose § 0 defines valid map, unit arc, (Q), (R2), fragment, Siamese, Γ, tile, ring, change point,
tactic edge, simple and saturated, § 13 the germs, hubs and semi-hubs, and § 14 the hub labels. A statement a verifier corrected is filed in its
corrected wording, the frozen one's address given beside it, and the frozen list is not edited. Arguments are addresses in the job records,
resolved from `plans/`.*

*Updated by the close's part 2, FS116-Z2 (Ephodos, Opus 5.5), 2026-10-03, by `../tools/fs116_z2_fold.py`: FS116-V6's verdict folded into
FS116-Y4-EMPTY, every vacuity note made definite, FS116-V6's five lemmas filed at one mind, and the case list's Γ-free case held.*

***Vacuity.** FS116-Y4-EMPTY is **held** (inventory item 139: two minds, the second, FS116-V6, blind, its verdict committed before it compared, by a
route resting on none of round 3's statements): the non-Siamese simple six-coloured class with a ring carrying no arc of Γ is empty. Every entry below
marked "**True vacuously**" has its class inside that one (items 124, 135), so it is true with no member, at the count its own verifier gave; its
argument stays valid as an argument. **Nothing here moves a value**: χ(ℝ²) ∈ {5, 6, 7}, and every statement about a valid six-coloured fragment on a large
disc is about a possible object.*

*Prior art: FS-116's gate (`FS116-local-exclusion.md` § 2.3, 12 zbMATH queries, `../data/fs116/o1/zb/`) and the queries each record names. Where
an entry says "owed", no search was run for it; the successor's §PA carries the debt (inventory items 63, 99, 113, 128).*

## Round 1 — the opening's two claims (FS116-O1; FS116-V1 blind), and V1's frame

derivation: FS116-O1-YESLIM
  statement: for every k ≥ 1, if for every R > 0 some closed disc of radius R carries a valid k-coloured fragment (a map of an open set containing the
    disc, bounded by segments and circular arcs, k-coloured with no two interior points of one colour at distance exactly 1), then χ_m⁰(ℝ²) ≤ k; at k
    = 6, then χ(ℝ²) ≤ 6, with no MR
  uses only: that each fragment's tile boundaries are Lebesgue-null (countably many segments and arcs); that the circle measure σ on S¹ is Rajchman,
    σ̂(ξ) = J₀(|ξ|) → 0; weak-* compactness of the unit ball of L^∞; the definition of χ_m⁰ (a Lebesgue-measurable colouring whose unit pairs are
    bichromatic at (Leb ⊗ σ)-almost every pair); for the MR-free clause, χ(ℝ²) ≤ χ_m⁰(ℝ²) (row 130; `[GwynStavrianos2022]` Lemma 2, Theorem 2)
  not claimed: the converse (a measurable a.e.-proper six-colouring gives no fragment: it need not be a map); that the limit colouring is a map, or
    saturated, or regular; anything about the fragments' centres, so nothing about C114-LOCAL-F's explicitness; χ(ℝ²) ≤ 6 from fragments on discs of
    one bounded radius
  argument: FS116-local-exclusion.md § 3.5 The argument of FS116-O1-YESLIM
  verdict: derived
  grade: hand
  minds: 2 — blind to: the first derivation until V1's verdicts were committed (3daaa05c); method: the Rajchman step by a compact operator and the
    rounding by a least index (V1 § 4.1 rows 1–2), against dominated convergence and the support rounding; the same model (Opus 5.5), one prior
  model: k = 7 — R7 (de Grey's Reuleaux seven-colouring, FS111-M-R7) restricted to every disc is a valid seven-coloured fragment, and the conclusion
    χ_m⁰(ℝ²) ≤ 7 holds (row 33's upper bound, measurable); at k = 6 the hypothesis is inhabited only if χ_m⁰(ℝ²) ≤ 6
  prior art: partly: row 131's weak-* step (`[Bukh2008]` Lemma 12 and `[CohenMani2025]` Lemma 2.4 for one class; its k-class form not found, FS-106's
    gate) and FS111-W-NEG (iii), its near-colouring twin; run on exact fragments here, not found in print
  handoff: de Bruijn — queued behind the measurable chain (row 131's weak-* step): the statement at every k, its not-claimed line, and the Rajchman
    lemma it rests on

Frozen at § 3. TRUE, **held** (item 31). A thin truth: the map structure is idle beyond a null boundary, and the `k = 6` clause holds for every `k` straight from the fragments with no limit (V1 § 2.1–2.2). Rests on it: nothing in this file; the YES side of C114-LOCAL-F (fragments on every disc give χ(ℝ²) ≤ 6 with no MR).

derivation: FS116-O1-SATPIN
  statement: let p be a vertex of at least four colours of a valid k-coloured fragment saturated on a disc about p, every tile at p with a cone of
    positive angle; each edge e at p (a boundary arc between tiles of two different colours), with side colours a (clockwise) and b
    (counter-clockwise) and unit normal ν pointing to b's side, is near p of at least one of two types — (split) an arc of the unit circle about a
    point y of ω(p) at which both a and b have support, a unit arc of kind both; or (tangent) a segment or an arc of radius at least 1 along which
    every x has x + ν(x) in the closure of colour a and x − ν(x) in the closure of colour b, so that p + ν(p) carries a and p − ν(p) carries b, two
    antipodal points of ω(p) on the normal to e at p; and every colour of p is carried on ω(p)
  uses only: FS111-M-PINCH and FS111-M-C11 at the interior points of e, where (H1) and (H2) hold (two tiles meet there, each locally connected, e
    being a segment or an arc of a fragment); that supports are closed; that the split points of e's interior are open (M-C11 (iii)) and closed (a
    limit y of split centres y_n has |x − y| = 1 and carries both colours, and M-PINCH run with y as both contacts is (split)), so e's interior, being
    connected, is of one type; that e's tangent direction is continuous up to p; saturation at p itself for the last clause
  not claimed: anything at a cusp at p; that the split centre y has four colours (FS112-N3-NOBOTH gives four colours or a repeated colour, and
    FS111-W-NOREP removes the repeat only on cusp-free saturated maps); that any saturated valid six-coloured fragment about a four-colour vertex
    exists; that the strip's midline configuration is excluded in the class (SAT-STRIP, the claim list); saturation of any held six-colour positive
  argument: FS116-local-exclusion.md § 4.1a The argument of FS116-O1-SATPIN
  verdict: derived
  grade: derived from: FS111-M-PINCH, FS111-M-C11
  minds: 2 — blind to: the first derivation until 3daaa05c, not to FS111-M-PINCH's case split, which both routes use (item 31's ruling); method: V1's
    L1–L4, a connected-product interval per contact, the last clause through the edges, against saturation at p (V1 § 4.2); the same model (Opus 5.5),
    one prior
  model: k = 9 — FS111-W-SQ9, the square nine-colouring of side 1/2 (saturated, FS111-M-PINCH's model at an edge point): at each grid point four
    colours meet, every edge is of the tangent type, and its partners sit at the two points of ω(p) on the edge's normal; at k = 7 R7's lattice points
    have cusps and are outside the hypothesis
  prior art: partly: FS111-M-PINCH is FS-111's (the dichotomy at an edge point); its reading at a vertex of a map not found — FS-111's gate,
    "chromatic & plane & (measurable | map) & (tight | saturat* | maximal)" (7)
  handoff: de Bruijn — with FS111-M-PINCH and FS111-M-C11, queued behind the measurable chain: the statement, its cusp exclusion, and the inner-disc
    reading of saturation for fragments

Frozen at § 3 with "each edge e at p, with side colours" and "of exactly one of two types": **MISSTATED** in those two words (an edge with `a = b` is of neither type, a monster; exclusivity is not carried), TRUE in the author's readings S1, S2 (V1 § 1.6, § 2.3), and filed here in V1's corrected wording; **held** (item 31). A thin truth: four colours and positive cones are idle, and it holds at every vertex of at least two colours in the saturated disc, cusps included (R7). Rests on it: FS116-N1-AXIS; FS116-S1-RUNG; FS116-S1-QF.

derivation: FS116-V1-FRAME
  statement: at a degree-4 vertex p of four colours, every tile at p with a cone of positive angle, of a non-Siamese simple valid fragment on an open
    set containing B̄(p, 1) whose ring ω(p) carries no arc of Γ, the ring has exactly six change points, 60° apart, and the centre of every tactic
    edge at p is a change point of the ring
  uses only: V1's F0 (two tiles of one colour are all closer than 1 or all farther; a tile has diameter at most 1), F1–F3 (off Γ the ring lies in
    tiles of the two absent colours, swapped by the rotation σ; the four regions at a change point cut by ω(σy) and ω(σ⁻¹y)) and F4 (the inward region
    lies in tiles of p reaching y); non-Siamese at F4–F6, simple at F6, six colours at F3
  not claimed: anything with Siamese pairs or non-simple tiles; anything at k ≥ 7; that any such vertex exists (FS116-Y4-EMPTY excludes the class at
    six colours, held)
  argument: FS116-V1-verification.md § 3.1 The frame (my route) — setting N
  verdict: derived
  grade: hand
  minds: 1
  model: none at six colours; V1 read the frame's colour-level conditions by hand on OC, the (1, 2, 1, 2) pinwheel, +++ and the γ = 0° lens (V1 §
    3.2), which are patterns, not fragments
  prior art: partly: FS114-N6-RING60 (six change points after the bends) and FS114-N7-TAC (tactic centres at change points), one mind each; F5 is a
    second route to the count over non-Siamese (V1 § 4.3 row 4)
  handoff: none — FS116-Y4-EMPTY (held) leaves it vacuous; it carried N7-HUB's second mind to FS-114's filing (FS114-N7-HUB, FS116-Z2's
    erratum)

**True vacuously** — its class lies inside FS116-Y4-EMPTY's (item 135). V1's second route to the six change points and the tactic centres (F5, F6), derived blind beside N7-HUB (b), (c), which stand at two minds in FS-114's filing (`FS114-derivation.md` FS114-N7-HUB, FS116-Z2's erratum). Rests on it: nothing in this file.

## Round 1 — the ring (FS116-N1; FS116-V2 blind on three)

derivation: FS116-N1-TWIST-D
  statement: at a vertex p of a valid k-coloured fragment on a closed disc of radius above 1 about p, for any k ≥ 1, Siamese pairs allowed, any
    degree, the set D of points of ω(p) in the closure of a tile of one of p's colours is closed and lies in the union of the arcs of Γ on ω(p) and
    finitely many points
  uses only: N-E1 at p (an interior point of a tile of colour c is at distance 1 from no point of the closure of a tile of colour c); that Γ is a
    locally finite union of segments and circular arcs, so finitely many of its pieces meet ω(p), each meeting it in at most two points unless it is
    an arc of ω(p)
  not claimed: that D is non-empty; that D is contained in the arcs of Γ on ω(p) alone (the strip's P₀ has two isolated points of D, its change
    points)
  argument: FS116-N1-proof.md § 2.1 The argument of FS116-N1-TWIST-D (the first clause)
  verdict: derived
  grade: hand
  minds: 1
  model: the capped strip's midline vertex P₀ (row 136; FS114-Y-DIAL) — D is its four closed (Q) arcs and the two change points r(0°), r(180°)
    (`data/fs116/n1/ring-survey.out`; the arcs' ends and the change points on ω(P₀) exactly, `data/fs116/n1/strip-exact.out`)
  prior art: partly: FS-110's N-E1 is the whole mechanism; as a statement about the ring it is FS114-N3-ODD's setting ("off Γ-arcs of ω(p)") made
    explicit
  handoff: de Bruijn — the first clause as stated, with N-E1 and the local finiteness it uses; a small statement once a map type exists in Lean (D6)

Not frozen; its four-colour case is FS116-RING-TWIST-C's first clause, re-derived blind by V2. Rests on it: FS116-RING-TWIST-C; FS116-RING-GERM; FS116-N1-GERM-S; FS116-N1-QFREE4; FS116-N1-TOUCH; FS116-N1-ECHO; FS116-N2-SIXRING; FS116-N2-FIVERING; FS116-N2-STAR; FS116-RING-TRANSFER-C.

derivation: FS116-RING-TWIST-C
  statement: at a vertex p of at least four colours of a valid fragment on a closed disc of radius above 1 about p (Siamese pairs allowed, any
    degree), the set D of points of ω(p) in the closure of a tile of one of p's colours is closed and lies in the union of the arcs of Γ on ω(p) and
    finitely many points; and for every half-open 60° window W of ω(p) with W ∪ σ(W) disjoint from D: p has four colours and no more; off a finite
    set, every point of W ∪ σ(W) lies in the closures of tiles of a single colour, one of the two colours absent at p, and this colour differs at θ
    and at θ + 60° for θ in W; every edge on ω(p) meeting W ∪ σ(W) in an arc has one colour on both sides; W holds an odd number of colour changes —
    points of W at which that colour differs on the two sides — each lying in the closures of tiles of the two absent colours and of no other colour;
    every change point in W is a colour change, and a colour change in W that is not a change point lies on an edge on ω(p) with one colour on both
    sides; so W holds an odd number of change points when no such arc meets W, in particular in every non-Siamese simple fragment
  uses only: FS116-N1-TWIST-D; N-E1; that a unit circle through a point of ω(p) centred 60° away crosses ω(p) there at 60°; six colours, spent once,
    at L2 (two absent colours make the colours at θ and θ + 60° complementary singletons); for the last clause, that a slit makes a tile meet itself
    and two tiles of one colour sharing an arc are close
  not claimed: anything at k ≥ 7; that any fragment of the class has a qualifying window (no held fragment has one: the strip's and the disk's D-free
    arcs are at most 60° and 87.83°); the parity of change points when a seam meets W (FS116-N1-TWIST-LIT: then it can fail)
  argument: FS116-N1-proof.md § 2.2 The argument of RING-TWIST-C (the parity)
  verdict: derived
  grade: derived from: FS116-N1-TWIST-D
  minds: 2 — blind to: N1's argument until V2's verdicts (81bfc5cb); method: the same route in substance (V2 § 4.2); the same model (Opus 5.5), one
    prior
  model: the capped strip's midline vertex P₀ for the hypotheses of the first clause and the antiperiodic colouring (0 violations in 2,360 sampled
    pairs); no held fragment has a qualifying window, so the parity's hypothesis has no held model at six colours
  prior art: partly: FS114-N3-ODD ("Off Γ-arcs of ω(p), every half-open 60° window of the ring of a four-colour vertex holds an odd number of change
    points", non-Siamese, one mind) — here without the non-Siamese hypothesis, with D in place of the Γ-arcs, and with the counting word corrected
  handoff: de Bruijn — the statement, its six-colour step L2 named, and TWIST-LIT's slit as the reason the counting word is colour changes

Frozen at § 10. TRUE under reading L of "change point" (the ring off Γ on both sides) with "arc of Γ on ω(p)" read as an edge, and filed in V2's wording, "edge" in the two clauses that need it (V2 § 4.2 row 3); **held** (item 49). It replaces RING-TWIST (§ 5), MISSTATED: the parity counts colour changes, not change points (FS116-N1-TWIST-LIT shows the gap); RING-TWIST's frozen not-claimed line ("the parity fails: R7's lattice points") is vacuous there, not failing (item 38). The qualifying window has no held model (V2-STRIP-D: every D-free arc of the strip is at most 60°). Rests on it: FS116-N1-TWIST-LIT; FS116-RING-TWIST-Q; FS116-RING-TRANSFER-C; FS116-Y3-SIX.

derivation: FS116-N1-TWIST-LIT
  statement: RING-TWIST's parity clause as posed — every half-open 60° window W of ω(p) with W ∪ σ(W) disjoint from D holds an odd number of change
    points — holds on every fragment of RING-TWIST's class if and only if no fragment of that class has a half-open 60° window W with W ∪ σ(W)
    disjoint from D
  uses only: the slit: an arc of ω(p) from a change point into the tile on one side, added to Γ, leaves the fragment valid, the vertex p and the set D
    unchanged, and removes that change point and no other; nothing else (RING-TWIST-C, which the first entry listed, is not consumed: V2 § 4.3 row 2)
  not claimed: that the class has a fragment with a qualifying window; anything in the non-Siamese simple class, where the clause holds by
    RING-TWIST-C
  converse: FS116-N1-proof.md § 2.3 The clause as posed, and the slit (FS116-N1-TWIST-LIT)
  argument: FS116-N1-proof.md § 2.3 The clause as posed, and the slit (FS116-N1-TWIST-LIT)
  verdict: derived
  grade: hand
  minds: 2 — blind to: N1's argument until 81bfc5cb; method: the same slit (V2 § 4.3); the same model (Opus 5.5), one prior
  model: the capped strip about P₀, in the class at any radius in (1, φ²/√2): it has no qualifying window, and the clause holds on it vacuously
  prior art: partly: FS114-N3-ODD, whose hypothesis "off Γ-arcs of ω(p)" already excludes seams; the slit and the equivalence are this record's
  handoff: none — a finding about a statement's counting word; it travels as RING-TWIST's MISSTATED verdict

Frozen at § 10. TRUE under readings L and G; **held** (item 49). Filed with grade `hand` and the uses-only V2 found (item 51). V2-TL-NS (one mind): the "only if" holds inside the non-Siamese class, the slit keeping non-Siamese — simplicity, not non-Siamese, is what the parity needs. Rests on it: nothing in this file.

derivation: FS116-RING-GERM
  statement: in a non-Siamese valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, let y be a change point of
    the ring (the ring off Γ on both sides of y), X the colour of the ring just counter-clockwise of y and X̄ the colour just clockwise, and u⁻, u⁺,
    v⁻, v⁺ the arcs of ω(p) just clockwise and just counter-clockwise of the ring points y + 60° and y − 60°; then p has four colours and no more, X
    and X̄ are the colours absent at p, and (i) if neither v⁻ nor u⁺ lies on a (Q) arc, every direction at y in the open cone of 60° about the
    direction to p lies in the cone of a tile of p; (ii) if neither u⁻ nor v⁺ lies on a (Q) arc, every direction at y in the open cone of 60° about
    the direction away from p lies in the cone of a tile of a colour of p that is not a tile of p; (iii) if none of the four lies on a (Q) arc, y is a
    vertex of at least four colours
  uses only: FS116-N1-TWIST-D (a ring point off Γ has a colour absent at p); N-E1; CL and N3-FACE (non-Siamese) for (i) and (iii) only — (ii) holds
    without them (V2-RG-THIN, V2 § 4.1 row 2); that a tile has diameter at most 1; six colours, spent at Step 1 and in the cone step (V2 § 4.1 row 3)
  not claimed: anything at k ≥ 7; that a change point with a germ on a (Q) arc has fewer than four colours (the strip's P₂ has four, with u⁺ and v⁻ on
    (Q) arcs); that the ring's change points are 60° apart (N6-RING60's conclusion, for (Q)-free rings)
  argument: FS116-N1-proof.md § 3.1 The germ lemma (RING-GERM) and its argument
  verdict: derived
  grade: derived from: FS116-N1-TWIST-D
  minds: 2 — blind to: N1's argument until 81bfc5cb, given N7-HUB's one-line sketch in the list's § 8 (item 49's caveat); method: colour exclusion at
    the tiles in the cones (V2) against tile identification (N1), V2 § 4.1 row 1; the same model (Opus 5.5), one prior
  model: the capped strip's midline vertex P₀ at its change point P₂ (u⁻, v⁺ off (Q) arcs; (ii) met by two outer tiles) and FS114-Y2-BOWTIE's centre
    at top (u⁻, v⁺ off (Q) arcs; an outer tile and a tip) — `data/fs116/n1/germ.out`
  prior art: partly: FS114-N7-HUB (b), (c) and FS114-N7-HUBQ (one mind each), whose mechanism this is, stated there on rings bent to (Q) and (R2)
    arcs; the split of the four germs into the tip's pair and the outer tile's pair not found — FS-116's gate (`plans/FS116-local-exclusion.md` §
    2.3), 12 queries
  handoff: de Bruijn — the statement with its four germs, the six-colour step named, over TWIST-D; queued behind D6's map type

Frozen at § 10. TRUE under reading L, filed with "the ring off Γ on both sides of y" written in (item 50); under reading G FALSE by the strip's apex `(1/4, √15/4)` of `P₀`'s ring (V2-RG-G, a monster the author's reading settles); **held** with item 49's caveat. Its uses-only corrected (item 51): (0a), (0b) and (ii) hold Siamese pairs allowed (V2-RG-THIN, one mind; FS116-N1-GERM-S is the Siamese form of the whole). Rests on it: FS116-RING-Q-PRIME; FS116-RING-TWIST-Q; FS116-N2-STAR; FS116-N2-HEX6; FS116-RING-TRANSFER-C; FS116-Y3-SIX; FS116-Y3-TIPS; FS116-Y3-HUBCOL; FS116-Y3-TIGHT; FS116-Y3-NOQ; FS116-Y3-NBTIP; FS116-N3-CONE; FS116-N3-SEMI; FS116-N3-CROSS; FS116-RING-TRANSFER-QC; FS116-Y4-SPOKE; FS116-Y4-Q1; FS116-Y4-EMPTY.

derivation: FS116-RING-Q-PRIME
  statement: in a non-Siamese simple valid fragment on a closed disc of radius above 2 about a vertex p of at least four colours whose ring carries a
    (Q) arc, every change point of the ring whose points at ±60° on ω(p) lie on no (Q) arc is a vertex of at least four colours
  uses only: RING-GERM (iii); that a (Q) arc whose closure holds a ring point holds one of its two germs
  not claimed: the change points with a point at ±60° on a (Q) arc (RING-Q, GAP); "lie on" read as the open arc (then a ±60° point may end a (Q) arc,
    as at the strip's P₂, and RING-GERM gives only one of the tip and the outer tile)
  argument: FS116-N1-proof.md § 3.1 The germ lemma (RING-GERM) and its argument
  verdict: derived
  grade: derived from: FS116-RING-GERM
  minds: 1
  model: none held with a (Q) arc on the ring and a change point in scope — the strip's and the Y2 bowtie's change points have ±60° points ending (Q)
    arcs, the disk's inside them; the statement holds at the class RING-GERM names, where FS114-N7-HUB's (Q)-free rings are its instances
  prior art: partly: FS114-N7-HUBQ ("At a change point whose ±60° points have κ defined just outside, a tip exists", one mind), here with the outer
    tile and without bends
  handoff: de Bruijn — with RING-GERM

Frozen at § 5 as RING-Q′; TRUE as posed (closed (Q) arcs). The rung FS-121 takes (inventory item 41). Rests on it: nothing in this file; FS-121's ring rung (FS-121 inventory item 8).

derivation: FS116-N1-QDISK
  statement: the disk of `[Polymath2021]` Fig. 10 (FS112-CAL-DISK), restricted to the closed disc of radius R about its corner A₀, is for every R
    below r − |A₀| ≈ 1.59852 (r = √((25 + 9√5)/10) its rim radius) a non-Siamese simple valid fragment about a vertex of four colours whose ring
    carries a (Q) arc, and the ring's change point y where ω(A₀) crosses the segment A₁X₁ is an edge point of two colours, green (W₁) and violet (P₁),
    whose points at ±60° lie inside the (Q) arcs A₂A₃ and B₀Y₀; so RING-Q with "radius above 2" replaced by any radius below 1.59852 is false
  uses only: the disk's exact coordinates (FS112-YB2's rebuild, `tools/fs112_yb2_objects.py`) and FS-112's exact validity check of it; the location of
    y and its ±60° points evaluated to 50 digits from exact expressions, every inequality with margin above 0.08; the two-colour neighbourhood of y,
    non-Siamese and simple read in floats
  not claimed: that RING-Q as posed (radius above 2) is false; that the disk extends to a fragment on any disc of radius 2 about A₀ (FS114-Y-PENT: no
    valid map agrees with the disk near its B_k); that non-Siamese and simple are exact (they are float readings on sampled boundaries)
  argument: FS116-N1-proof.md § 3.2 The disk's corner: RING-Q is not local (FS116-N1-QDISK)
  verdict: derived
  grade: computed over: the disk's corner A₀ — the point y, its ±60° points and the arcs holding them, exact to 50 digits; the class hypotheses in
    floats
  minds: 1
  model: the disk itself, about A₀
  prior art: partly: the disk is Gibbs's (`[Polymath16threads]` `[07.49]`, `[Polymath2021]` Fig. 10); that its corners' rings have two-colour change
    points not found in print — FS-116's gate, "unit distance" & ("circular arcs" | "arcs of unit" | "unit arcs") (1)
  handoff: none — a statement about one held object; it crosses to Lean only as a control of RING-Q's scope

A statement about one held object, exact at the change point and its ±60° points, the class read in floats. Rests on it: FS116-Y2-DCREAD.

control: disk-two-colour
  of: FS116-N1-QDISK — the change point on A₁X₁ and its ±60° points inside the (Q) arcs, exactly; the point rotated 20° about A₀ fails
  run: python3 ../tools/fs116_n1_ring.py diskexact --line --noexit
  expect: DISKEXACT OK
  fault: python3 ../tools/fs116_n1_ring.py diskexact --plant --line --noexit

derivation: FS116-RING-TWIST-Q
  statement: in a non-Siamese simple valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, every change point y
    in a half-open 60° window W of ω(p) with W ∪ σ(W) disjoint from D has both of its germs at y − 60° on (Q) arcs; so if the ring carries no (Q) arc,
    D meets every half-open arc of ω(p) of 120°
  uses only: RING-TWIST-C (a qualifying window holds an odd number of colour changes, each carrying the two absent colours only, and in this class
    they are change points); RING-GERM (i) and (ii); that a (Q) arc lies in D
  not claimed: that any fragment has a qualifying window; the Siamese or non-simple class (there a colour change may end a seam, where RING-GERM does
    not apply)
  argument: FS116-N1-proof.md § 3.4 What RING-Q needs, and what it does to the plan
  verdict: derived
  grade: derived from: FS116-RING-TWIST-C, FS116-RING-GERM
  minds: 1
  model: FS114-Y2-BOWTIE's centre and the strip's midline vertices — rings whose D meets every half-open 120° arc (`data/fs116/n1/ring-survey.out`)
  prior art: partly: FS114-N6-RING60 with FS114-N7-HUB give it for (Q)-free rings after the bends (change points 60° apart, each in D)
  handoff: none — a relay-result tying RING-TWIST's parity clause to the (Q) arcs

Ties the parity's window to the (Q) arcs. Rests on it: nothing in this file.

derivation: FS116-RING-Q
  statement: in a non-Siamese simple valid fragment on a closed disc of radius above 2 about a vertex p of at least four colours whose ring carries a
    (Q) arc, every change point of the ring that lies on no (Q) arc is a vertex of at least four colours
  argument: FS116-N1-proof.md § 3.4 What RING-Q needs, and what it does to the plan
  verdict: gap: a change point y with a germ at y ± 60° on a (Q) arc — RING-GERM forces no tip when v⁻ or u⁺ lies on one and no outer tile when u⁻ or
    v⁺ does, and the disk's corner (FS116-N1-QDISK) has such a change point of two colours on a fragment holding B̄(A₀, 1.5985) and B̄(y, 1), so the
    step can close only through points of B̄(p, 2) outside both

Frozen at § 5 (card `what-do-q-rings-force`). GAP; its qualifier "that lies on no (Q) arc" is empty under § 0's change point (item 38, harmless). P3 (RING-Q holds, 0.45) is not decided as posed. Rests on it: nothing in this file; FS116-C114-LOCAL-F; the successor stub.

## Rounds 1–2 — the construction side (FS116-Y1, FS116-Y2)

derivation: FS116-Y1-F15
  statement: F(1/5) — the capped strip's arches U_j, D_j (j = −3..2), its top and bottom tiles over V_{−1}, V_0, V_1 trimmed at |y| = 5/4, with the
    partner tiles M* = [0, 1/5] × [1, 5/4] (colour of D_0), O* = [−1/5, 0] × [1, 5/4] (colour of D_{−1}) and their mirrors β* (colour of U_0), α*
    (colour of U_{−1}) cut from the tiles over V_0 and V′_0 — is a valid six-coloured fragment on B̄(P_0, 6/5), saturated on B̄(P_0, 1/5), and P_0 is
    a degree-4 vertex of four colours whose four edges are segments and whose ring carries four (Q) arcs
  uses only: exact arithmetic in Q(√3, √5) on the 22 tiles; FS114-YB's exact pair checker for validity; the tangent-type certificate (each piece of
    the map within 1/5 of P_0 has, for each side tile, its unit translate away from that tile on a segment piece of a tile of the side tile's colour)
  not claimed: saturation beyond B̄(P_0, 1/5); that the fragment extends to a larger disc; SAT-STRIP either way (its saturation disc is B̄(p, 1))
  argument: FS116-Y1-construction.md § 2.1 The runs, scored against 2.0
  verdict: derived
  grade: computed over: the 52 same-colour tile pairs of F(1/5) and its 4 pieces within 1/5 of P_0
  minds: 1
  model: F(1/5) itself; its four (Q) arcs are the top arcs of U_{−1}, U_0 and the bottom arcs of D_{−1}, D_0 about P_0, whose outer tiles (over
    V_{−1}, V_1, V′_{−1}, V′_1) carry colours present at P_0
  prior art: new — "unit distance & (saturat* | maximal) & colo*" (0), "chromatic & plane & (measurable | map) & (tight | saturat* | maximal)" (7)
  handoff: none — a fragment by formula checked exactly; it proves no value and the kernel lane holds no fragment checker; its exact certificate is
    the tool

Exact, by formula; the certifier's controls accept SQ9 and R7 first (Y1's control `fs116-y1-satcert`). Rests on it: FS116-N1-F15TOUCH.

control: fs116-y1-f15
  of: FS116-Y1-F15 — the object holds every check; with M* lifted by 1/20 the saturation certificate fails at [p, (1/5, 0)]
  run: python3 ../tools/fs116_y1_sat.py object 1 5 | grep '=> F'
  expect: => F(1/5): ALL HOLD
  fault: python3 ../tools/fs116_y1_sat.py object 1 5 --plant lift | grep '=> F'

derivation: FS116-Y1-STRIPCEIL
  statement: if a valid six-coloured fragment on B̄(P_0, R) agrees with the capped strip on the open unit disc about its midline vertex P_0 (tiles,
    and colours up to a permutation) and is saturated on B̄(P_0, R − 1), then R − 1 < √(√3 − 3/4) − 1/2 ≈ 0.49099; in particular no such fragment is
    saturated at every point of a midline edge at P_0
  uses only: the wedge W above V_{−1} lies outside U_{−2} and U_{−1} and five of the strip's tiles straddle each of its points through their parts
    inside B(P_0, 1) (so W is coloured M, the sixth colour); a tile has diameter at most 1; D_0 lies in the lens B̄(P_0, 1) ∩ B̄(P_1, 1), every point
    of which is within distance < 1 of (x, 0) for 0 < x < 1/2, and D_0's top edge is straight, so the M partner of (x, 0) is (x, 1); |V_{−1} − (x*,
    1)| = 1; local finiteness of the map at V_{−1} and at (x*, 1); no count of colours beyond six, and none of SATPIN, M-PINCH, FS121-D1-VT or EROSION
  not claimed: that any R − 1 between 1/5 (FS116-Y1-F15) and x* is attained; anything for fragments that change the strip inside B(P_0, 1); SAT-STRIP
    (saturation on B̄(p, 1) about any degree-4 four-colour vertex with four straight edges); anything at k ≥ 7 (with a seventh colour W need not be M)
  argument: FS116-Y1-construction.md § 2.2 The ceiling of the strip family (FS116-Y1-STRIPCEIL)
  verdict: derived
  grade: hand
  minds: 1
  model: F(1/5) (FS116-Y1-F15): R − 1 = 1/5 < x*; its wedge above V_{−1} is the tile over V_{−1}, coloured M, and its M* ends at x = 1/5, where
    |V_{−1} − (1/5, 1)| < 1
  prior art: new — "unit distance & (saturat* | maximal) & colo*" (0), "chromatic & plane & (measurable | map) & (tight | saturat* | maximal)" (7)
  handoff: none — a no-go for one family of fragments, bearing on which positive the construction side may build; it enters no proof of a value

The strip family cannot decide SAT-STRIP at `r = 1`; FS116-S1-RUNG contains it as the case `w = r(120°)`. Rests on it: FS116-Y1-NOTCH.

derivation: FS116-Y1-NOTCH
  statement: in a valid six-coloured fragment on B̄(P_0, R), R ≥ φ²/√2, whose tiles include the capped strip's arches U_{−2}, …, U_1 and D_{−2}, …,
    D_1 with the strip's colours up to a permutation, every tile meeting the cone (arcsin ¼, 180° − arcsin ¼) at the stop point Q_0 = (1/4, Y), near
    Q_0 and below height 1.85, has D_0's colour, and every tile meeting the mirror cone at Q_{−1} = (−1/4, Y) has D_{−1}'s colour
  uses only: the valley wedges' forced colours (the argument of FS116-Y1-STRIPCEIL step 1 at V_{−1}, V_0, V_1); the three arches' straddles at the
    notch points; |Q_0 − V_0| = |Q_0 − V_1| = |Q_{−1} − V_{−1}| = |Q_{−1} − V_0| = 1 with every wedge and cone direction within 90° of the joining
    direction; local finiteness at the valleys and at the notch; nothing about the tiles above the arches
  not claimed: that a tile of that colour can be placed in the notch (the capped strip's columns over V_{−1} and V_2 straddle it); anything above
    height about 1.854, where U_{±1}'s top arcs pass distance 1 and the arch colours can return; any fragment that changes an arch; anything at k ≥ 7
  argument: FS116-Y1-construction.md § 3.2 The forced notch colours (FS116-Y1-NOTCH)
  verdict: derived
  grade: hand
  minds: 1
  model: the capped strip itself: its notch at Q_0 is colourless (FS112-EDGE), because the column tiles over V_{−1} and V_2 (colour M) reach within 1
    of Q_0 while their valleys are at distance √(3/2) > 1 from it — the forced colour is the one the columns block
  prior art: new — "unit distance & (saturat* | maximal) & colo*" (0), "chromatic & plane & (measurable | map) & (tight | saturat* | maximal)" (7);
    the strip's stop point is FS112-EDGE's, the forced colour not considered there (plans/FS114-Y-construction.md § 2.1 read)
  handoff: none — a relay-result for the construction side's round 2; it enters no proof of a value

A relay-result for the construction side; Y-QRING not landed (P2 met). Rests on it: nothing in this file.

derivation: FS116-Y2-DCREAD
  statement: any derivation that excludes, on the closed disc of radius 2 about p, the disk-corner configuration (a vertex p of at least four colours
    whose ring has a change point y of two colours with y ± 60° inside (Q) arcs) in RING-Q's class must read a point of that disc outside the disk of
    [Polymath2021] Fig. 10 placed with its corner A₀ at p and its change point at y, and every such point lies in the directions (ψ + 157.4°, ψ +
    324.5°) about p, ψ the direction of y
  uses only: that the disk is a valid fragment on B̄(O, r) realising the configuration at A₀ (FS112-CAL-DISK, FS116-N1-QDISK); r² = (25 + 9√5)/10, a²
    = (5 − √5)/10, ψ ≈ 209.0102° (FS116-N1's ring survey); the maximum of |A₀ + t e(θ)| over t ≤ 2 is at t = 2
  not claimed: that the configuration is excluded at any radius; that an exclusion must read every point of the window; anything outside RING-Q's
    class (the disk's non-Siamese and simple readings are floats, FS116-N1)
  argument: FS116-Y2-construction.md § 2.2 Where an exclusion of the disk-corner configuration must read (FS116-Y2-DCREAD)
  verdict: derived
  grade: hand
  minds: 1
  model: the disk itself, about A₀
  prior art: partly: FS112-DISC (the disk's reach about A₀) and FS116-N1 § 3.4 (the gap is not local, stated in radius); the direction window is new
    here
  handoff: none — a scope statement for the proof side's RING-Q step (C-BEYOND in the claim list's sense)

Scopes FS116-RING-Q's missing step. Rests on it: nothing in this file.

derivation: FS116-Y2-SIXFRAG
  statement: the unit sector flower S_j (colour j), the six lenses Q_j between e(60j − 30°) and e(60j + 30°) outside ω(p) (colour j + 2) and the six
    gap tiles G_j at e(60j + 30°) (colour j + 4), all cut at |x| = 3/2, form a valid non-Siamese six-coloured fragment holding B̄(p, R) for every R <
    3/2, in which p is a vertex of six colours whose ring lies in Γ and all of whose ring arcs are (Q) arcs
  uses only: exact arithmetic in Q(√3, √7) (the cut points have cosine 3/4 and sine √7/4 at the lens corners); FS114-YB's exact pair verdict (every
    candidate distance compared with 1) and its map-consistency test; the 36 same-colour tile pairs, self-pairs included
  not claimed: any R ≥ 3/2 in this form (at 8/5 each G_j exceeds diameter 1: the plant); that the fragment extends; Y-QRING (3/2 < φ²/√2); that a
    vertex of six colours occurs in any valid map
  argument: FS116-Y2-construction.md § 2.3 A vertex of six colours, by formula (FS116-Y2-SIXFRAG)
  verdict: derived
  grade: computed over: the 18 tiles of the fragment and their 36 same-colour pairs, exact in Q(√3, √7)
  minds: 1
  model: the fragment itself
  prior art: partly: the six-sector picture at a six-colour vertex is de Grey's and Gibbs's ([Polymath16threads] [08.17], [08.18], 2018: "a circle
    divided into six tiles around the vertex … but what next?"); a fragment beyond the ring not found in print (FS112-PA-reading stage 3: the next
    layer's case analysis never done); no search of my own run (standing rule 5 does not bear; the debt is in the report)
  handoff: de Bruijn — an exact fragment in Q(√3, √7) with its pair certificate, a control object for any local exclusion that claims six-colour
    vertices; not urgent

The first exact valid non-Siamese fragment about a six-colour vertex held here; a ring type the plan omitted (item 61). Rests on it: nothing in this file.

control: fs116-y2-sixfrag
  of: FS116-Y2-SIXFRAG — the fragment holds every check; cut at 8/5 the gap tiles exceed diameter 1
  run: python3 ../tools/fs116_y2_six.py frag | tail -1
  expect: => FRAGMENT: VALID, NON-SIAMESE, SIX COLOURS AT p
  fault: python3 ../tools/fs116_y2_six.py frag --plant grow | tail -1

derivation: FS116-Y2-SIXOFF
  statement: no valid six-coloured fragment on B̄(p, R), Siamese pairs allowed, in which p is a vertex whose six tiles are the straight unit sectors
    S_j and whose tile covering the outer side of the ring near e(60j) is the lens over the ring arc [60j − 30°, 60j + 30°], for each j, has R ≥ √3
  uses only: the straddle principle (a tile's interior is connected); the sectors' corners and p; the lenses' corners e(60j ± 30°) and far vertices √3
    e(60j) with their cones there; the forced colours of Steps 1–2 (two cyclic patterns; the gap cones single-coloured); second order along the lens
    boundary in Step 3 (the horn); no non-Siamese hypothesis, no count of colours beyond six at Step 3's exclusions
  not claimed: anything for flowers whose tiles are not straight sectors (e.g. alternating Reuleaux and cusped tiles, where the corner straddles of
    Step 1 change); anything for outer rings that break away from the arc midpoints; that any R in (3/2, √3) is attained; anything at k ≥ 7 (with a
    seventh colour the cone at √3 e(0) is coloured, as in R7's family)
  argument: FS116-Y2-construction.md § 2.4 The offset flower stops below √3 (FS116-Y2-SIXOFF)
  verdict: derived
  grade: hand
  minds: 1
  model: FS116-Y2-SIXFRAG, a member of the setting on every B̄(p, R) with R < 3/2
  prior art: partly: the six-sector picture at a six-colour vertex is [Polymath16threads] [08.17]–[08.18]'s; the layer after it is not done there
    (FS112-PA-reading stage 3); no search of my own run — owed
  handoff: none — a no-go for one family of one ring type, for D2's list of ring types; it enters no proof of a value

One family of the six-colour type; the type's exclusion is open. Rests on it: nothing in this file.

## Round 2 — the saturated class (FS116-N1's successor; FS116-V3 blind on five)

derivation: FS116-N1-GERM-R
  statement: in a valid k-coloured fragment on a closed disc of radius above 1 about a point p, for any k, Siamese pairs allowed, let y = r(ψ) be a
    point of ω(p), c a colour, and v⁻, v⁺, u⁻, u⁺ the arcs of ω(p) just clockwise and just counter-clockwise of r(ψ − 60°) and r(ψ + 60°); if v⁻ lies
    in the closure of a tile of colour c, no tile of colour c approaches y along a direction β with β − ψ in (150°, 330°); for v⁺ the interval is
    (−30°, 150°), for u⁻ (−150°, 30°), and for u⁺ (30°, 210°)
  uses only: N-E1; that the ring point at distance 1 from y + h near y ± 60° moves monotonically through y ± 60° as |y + h − r(ψ ± 60°)| crosses 1
  not claimed: anything about tiles that approach y only along the boundary directions ψ + 150°, ψ + 330°, ψ − 30°, ψ + 30°, ψ + 210°, ψ − 150°;
    anything when a germ lies on Γ with colour c on neither side
  argument: FS116-N1-proof.md § 4.1 GERM-R, and RING-GERM without the non-Siamese hypothesis (GERM-S)
  verdict: derived
  grade: hand
  minds: 2 — blind to: N1's record until V3's verdicts (7245b6eb); method: a straddle on T′ × T in two regimes against the monotone ring point (V3 §
    4.2); the same model (Opus 5.5), one prior
  model: F(1/5) at q_N (FS116-Y1-F15): the germs at 30° and 150° carry G, and no G-tile holds q_N; the ends are sharp: four one-colour tile pairs by
    formula realise the boundary directions ψ + 150°, ψ + 330° at v⁻ and ψ + 150°, ψ − 30° at v⁺ (FS116-V3-GERM-R-EDGE)
  prior art: partly: the (a)–(d) half-planes of RING-GERM (§ 3.1, one mind), there proved with CL and N3-FACE; its form as N-E1 alone is this record's
  handoff: de Bruijn — the statement with its four open intervals; N-E1 and a monotonicity along the ring; queued behind D6's map type

Frozen at § 11. TRUE; its open intervals are sharp (FS116-V3-GERM-R-EDGE), and "above 1" may be "1" (V3 § 4.2); **held** (item 76). Rests on it: FS116-N1-GERM-S; FS116-N1-TOUCH; FS116-N1-AXIS; FS116-N3-CONE; FS116-RING-TRANSFER-QC.

derivation: FS116-V3-GERM-R-EDGE
  statement: FS116-N1-GERM-R's open intervals cannot be closed: at each end of the interval of v⁻ and of v⁺ (and, by the reflection, of u⁻ and u⁺),
    two tiles of one colour, given by formula about p = 0, y = (1, 0), have no two points at distance exactly 1 while one holds the germ in its
    closure and the other approaches y exactly along the end direction
  uses only: the four tile pairs of V3 § 2.3 item 3 (a box about r(−60°) outside or inside ω(p), and a horn or a crescent at y along ψ + 150° or ψ +
    330°), each with a hand bound on |z − a|² − 1 of one sign over the pair
  not claimed: anything about colourings beyond the pair of tiles (it shows the not-claimed line of GERM-R is needed, not that any fragment realises
    it); anything at u± beyond the reflection
  argument: FS116-V3-verification.md § 2.3 Attack on GERM-R
  verdict: derived
  grade: hand
  minds: 1
  model: the four pairs themselves; `../tools/fs116_v3_boundary.py` samples the bounds (a check of the bound, not a proof)
  prior art: partly: FS116-N1-GERM-R's not-claimed line names the boundary directions; that they are sharp is V3's
  handoff: none — a sharpness statement about GERM-R's intervals; it travels as GERM-R's model line

V3's finding, one mind: GERM-R's not-claimed line is the statement's edge, not caution. Rests on it: nothing in this file.

derivation: FS116-N1-GERM-S
  statement: in a valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, Siamese pairs allowed, let y be a
    change point of the ring, X the colour of the ring just counter-clockwise of y and X̄ the colour just clockwise, and u⁻, u⁺, v⁻, v⁺ the arcs of
    ω(p) just clockwise and just counter-clockwise of the ring points y + 60° and y − 60°; then p has four colours and no more, X and X̄ are the
    colours absent at p, and (i) if neither v⁻ nor u⁺ lies on a (Q) arc, every direction at y in the open cone of 60° about the direction to p lies in
    the cone of a tile of a colour c of p every tile of p of which colour lies in B̄(y, 1); (ii) if neither u⁻ nor v⁺ lies on a (Q) arc, every
    direction at y in the open cone of 60° about the direction away from p lies in the cone of a tile, not a tile of p, of a colour c of p every tile
    of p of which colour misses B(y, 1); (iii) if none of the four lies on a (Q) arc, y is a vertex of at least four colours
  uses only: FS116-N1-GERM-R; FS116-N1-TWIST-D; N-E1; that the distances between two tiles form an interval avoiding 1; that a tile of p lies in B̄(p,
    1); six colours, spent once, at Step 1 (a germ carrying no X̄ and a colour absent at p carries X)
  not claimed: anything at k ≥ 7; that the tile in (i) is a tile of p (that is RING-GERM, in the non-Siamese class); that a change point with a germ
    on a (Q) arc has fewer than four colours
  argument: FS116-N1-proof.md § 4.1 GERM-R, and RING-GERM without the non-Siamese hypothesis (GERM-S)
  verdict: derived
  grade: derived from: FS116-N1-GERM-R, FS116-N1-TWIST-D
  minds: 2 — blind to: N1's record until 7245b6eb, given N7-HUB's sketch in § 8 (V3's own caveat: a reader who counts it as given may count one);
    method: N-E2 against the interval argument, one fact under two names; the same model (Opus 5.5), one prior
  model: the capped strip's midline vertex P₀ at its change point P₂ ((ii) met by two outer tiles) and FS114-Y2-BOWTIE's centre — control germ-report
  prior art: partly: RING-GERM (this record, § 3.1) and FS114-N7-HUB (b), (c), both in the non-Siamese class; a search for the Siamese form is owed
  handoff: de Bruijn — with RING-GERM, the non-Siamese hypothesis dropped and (i), (ii) in their facing form

Frozen at § 11. TRUE; **held** (item 76), with V3's own caveat on N7-HUB's sketch. Rests on it: FS116-RING-Q-PRIME-S; FS116-S1-LENS.

derivation: FS116-RING-Q-PRIME-S
  statement: in a valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, Siamese pairs allowed, every change
    point of the ring whose points at ±60° on ω(p) lie on no closed (Q) arc is a vertex of at least four colours
  uses only: FS116-N1-GERM-S (iii); that a (Q) arc whose closure holds a ring point holds one of its two germs
  not claimed: the change points with a point at ±60° on a (Q) arc (RING-Q, GAP)
  argument: FS116-N1-proof.md § 4.1 GERM-R, and RING-GERM without the non-Siamese hypothesis (GERM-S)
  verdict: derived
  grade: derived from: FS116-N1-GERM-S
  minds: 1
  model: none held with a change point in scope, as RING-Q-PRIME (§ 3.5); FS114-N7-HUB's (Q)-free rings are its non-Siamese instances
  prior art: partly: RING-Q-PRIME (§ 3.5) in the non-Siamese simple class at radius above 2; FS114-N7-HUBQ
  handoff: de Bruijn — with FS116-N1-GERM-S

RING-Q′ in the Siamese and non-simple class. Rests on it: nothing in this file.

derivation: FS116-N1-QFREE4
  statement: at a vertex p of at least four colours of a valid fragment on a closed disc of radius above 1 about p, Siamese pairs allowed, if the ring
    carries no (Q) arc then p has four colours and no more
  uses only: FS116-N1-TWIST-D (a ring point off Γ has a colour absent at p); N-E1; stage 2's L1 (a ring arc of Γ excludes its side colours 60° away);
    six colours
  not claimed: anything at k ≥ 7; anything when the ring carries a (Q) arc (then p may have five colours)
  argument: FS116-N1-proof.md § 4.2 SAT-QFREE: the touch point
  verdict: derived
  grade: derived from: FS116-N1-TWIST-D
  minds: 1
  model: FS114-Y2-BOWTIE's ring has (Q) arcs and is no model; the degree-4 vertices of FS114-N6's (Q)-free pinwheel frame have four colours by
    hypothesis — none held with a (Q)-free ring at six colours
  prior art: partly: RING-TWIST-C's L2 gives four colours at a qualifying window (§ 2.2); this form's search is owed
  handoff: none — a two-line step used inside TOUCH's reduction; it crosses to Lean with it

Its Γ-free, non-Siamese case was re-derived blind inside FS116-V5-RING (step 3); as stated (Siamese allowed, (Q)-free) one mind. Rests on it: FS116-N2-HEX6; FS116-Y3-SIX.

derivation: FS116-N1-TOUCH
  statement: in a valid fragment on a closed disc of radius above 1 about a vertex p of four colours and no more, Siamese pairs allowed, let w be a
    point of ω(p) in the closure of a tile of one of p's colours which is not a change point of the ring and lies on no arc of Γ on ω(p), and suppose
    none of the four arcs of ω(p) just clockwise and just counter-clockwise of w + 60° and w − 60° lies on a (Q) arc; then the ring just clockwise and
    just counter-clockwise of w lies in tiles of one colour X absent at p, each of the four arcs lies in the closure of a tile of the other absent
    colour X̄ and of no tile of colour X, and no tile of colour X̄ has w in its closure
  uses only: FS116-N1-TWIST-D; N-E1; FS116-N1-GERM-R with c = X̄ at all four germs, whose four open intervals cover every direction; six colours,
    spent once; w ∈ D is used only to place w on Γ — the conclusions hold at every point of ω(p) off the arcs of Γ on ω(p), not a change point, with
    its four germs off (Q) arcs (V3 § 4.4)
  not claimed: that such a point exists in any fragment of SAT-QFREE's class; anything at k ≥ 7; anything when a germ lies on a (Q) arc
  argument: FS116-N1-proof.md § 4.2 SAT-QFREE: the touch point
  verdict: derived
  grade: derived from: FS116-N1-GERM-R, FS116-N1-TWIST-D
  minds: 2 — blind to: N1's record until 7245b6eb; method: the same three steps (a second mind on the information axis only, V3 § 4.2); the same model
    (Opus 5.5), one prior
  model: F(1/5) at q_N and at q_S (FS116-Y1-F15): ring R, germs G, no G at q_N; ring G, germs R, no R at q_S — control axis-touch-f15
  prior art: owed
  handoff: de Bruijn — the statement, queued behind D6's map type

Frozen at § 11. TRUE; the hypothesis "w in the closure of a tile of one of p's colours" is idle (a thin truth; V3's note in the uses-only line); **held** (item 76). Rests on it: FS116-N2-RECIP.

derivation: FS116-N1-ECHO
  statement: in a valid k-coloured fragment on a closed disc of radius above 2 about a point p, for any k, Siamese pairs allowed, let w be a point of
    ω(p) whose ring just clockwise and just counter-clockwise of w lies in tiles of one colour X absent at p; if w is an essential boundary point at
    which the fragment is saturated (each colour of P(w) has a point of its support at distance exactly 1 from w) and X is in w's essential
    multicolour, the point 2w − p lies in the closure of a tile of colour X
  uses only: N-E1 (the ring germs at w put X-interior points at distance exactly 1 from every point near ω(w) off the directions ψ and ψ + 180° from
    w); FS116-N1-TWIST-D (X absent at p, so p carries no X); saturation at w
  not claimed: anything when X has density 0 at w (a cusp); that the X-tile at 2w − p exists in any fragment of SAT-STRIP's class
  argument: FS116-N1-proof.md § 4.2 SAT-QFREE: the touch point
  verdict: derived
  grade: hand
  minds: 2 — on the corrected statement (reading B); blind to: N1's record until 7245b6eb; method: FS116-V3-ECHO-ONLY by a straddle against N1's
    derivative argument; the same model (Opus 5.5), one prior
  model: none held saturated at a touch point; F(1/5)'s q_N has the ring hypothesis (R on both sides, R of density 1/2 at q_N) but F(1/5) is saturated
    on B̄(P₀, 1/5) only and ends at radius 6/5, before (0, 2)
  prior art: owed
  handoff: de Bruijn — with N-E1 and saturation read at a point

Frozen at § 11 with "if the fragment is saturated at w and X is in w's essential multicolour": **MISSTATED** — under reading (A) (saturation at `w` vacuous off the essential boundary) FALSE by the hexagonal seven-colouring with `w` inside an `X`-hexagon (V3-ECHO-A, control `v3-echo-a` below), TRUE under (B); filed in V3's corrected wording (V3 § 4.4, items 65, 77); **held in (B)** (item 76). Rests on it: nothing in this file.

control: v3-echo-a
  of: FS116-N1-ECHO — reading (A)'s counterexample: the hexagonal seven-colouring certified valid, the hypotheses checked at w = r(20°), 2w − p in no X-tile's closure
  run: python3 ../tools/fs116_v3_echo.py | tail -1
  expect: ECHO-A: hypotheses hold and 2w - p lies in the closure of no X-tile
  fault: python3 ../tools/fs116_v3_echo.py --plant | tail -1

derivation: FS116-V3-ECHO-ONLY
  statement: in a valid k-coloured fragment on a closed disc of radius above 2 about a point p, for any k, Siamese pairs allowed, let w be a point of
    ω(p) whose ring just clockwise and just counter-clockwise of w lies in tiles of one colour X absent at p; then every point of ω(w) in the closure
    of a tile of colour X is 2w − p
  uses only: N-E1; a straddle against the ring tile on the side fixed by the sign of η·sin(θ − ψ); that X is absent at p
  not claimed: that 2w − p carries X (that needs saturation at w, FS116-N1-ECHO in reading (B)); anything about other colours on ω(w)
  argument: FS116-V3-verification.md § 3.3 ECHO — derived under reading (B), refuted under reading (A); MISSTATED
  verdict: derived
  grade: hand
  minds: 1
  model: the hexagonal seven-colouring of circumradius 0.45 with w inside an X-hexagon (V3's reading-(A) object): ω(w) meets no X-tile at all, and the
    statement holds with nothing at 2w − p
  prior art: partly: FS116-N1-ECHO's argument reaches the same support bound by a derivative (V3 § 4.2, ECHO row 2)
  handoff: none — a relay-lemma under FS116-N1-ECHO; it crosses to Lean with it

V3's relay-lemma, one mind; sharper with ECHO: `ω(w) ∩ supp S_X ⊆ {2w − p}` always, and saturation at `w` for `X` makes it `{2w − p}`. Rests on it: nothing in this file.

derivation: FS116-N1-AXIS
  statement: let p be a degree-4 vertex of four colours of a valid fragment on a closed disc of radius above 1 about p, saturated on a disc about p,
    whose four edges are segments along the four half-axes, with tiles coloured c_I, c_II, c_III, c_IV by quadrant and absent colours X, X̄; then at
    q_N = p + (0, 1): (a) every tile approaching q_N along a direction below the horizontal has colour X or X̄; (b) a tile of colour c_IV approaches
    q_N along 0⁺ and one of colour c_III along 180⁻, both above the line y = 1; (c) the arcs of ω(p) just counter-clockwise of r(30°) and just
    clockwise of r(150°) lie on no (Q) arc; (d) if the arcs just clockwise of r(30°) and just counter-clockwise of r(150°) lie on no (Q) arc, every
    tile approaching q_N along a direction below the horizontal has one colour, and q_N is not a change point; and at each of the axis points q_E,
    q_W, q_S, read with the quadrants turned with it
  uses only: N-E1 on the dip of ω(z) below p through the four tiles (a); FS116-O1-SATPIN in its corrected wording (two minds) at the four edges near p
    (b); GERM-S's interval argument on a (Q) arc's side tiles and FS116-N1-GERM-R (c); FS116-N1-GERM-R and six colours (d); (a) and (d) use no
    saturation (FS116-V3 § 3.6: the strip satisfies both)
  not claimed: anything for four segments not at right angles; anything at k ≥ 7 for (d) (at k = 9 SQ9 fails it); that the axis points are touch
    points in any fragment saturated on B̄(p, 1); SAT-STRIP
  argument: FS116-N1-proof.md § 4.3 SAT-STRIP: the right-angled cross (FS116-N1-AXIS)
  verdict: derived
  grade: derived from: FS116-N1-GERM-R
  minds: 2 — blind to: N1's record until 7245b6eb; method: N-E2 for (a) and saturation's definition for (b), so V3's (b) does not rest on SATPIN (V3 §
    4.2); the same model (Opus 5.5), one prior
  model: F(1/5) (FS116-Y1-F15), saturated on B̄(P₀, 1/5): touch points q_N, q_S; change points q_E, q_W with inner germs on its (Q) arcs — control
    axis-touch-f15
  prior art: partly: FS116-Y1-STRIPCEIL's step 2 is (b) at the strip's east edge (plans/FS116-Y1-construction.md § 2.2); the rest's search is owed
  handoff: de Bruijn — the statement at q_N with the quarter-turn symmetry; queued behind SATPIN and D6's map type

Frozen at § 11. TRUE; (a) and (d) need no saturation (V3-AXIS-STRIP, tools at named points: the unsaturated strip meets (a), (c), (d) and fails (b); SQ9 at `k = 9` fails (d)); **held** (item 76). Rests on it: FS116-S1-LENS.

control: axis-touch-f15
  of: FS116-N1-AXIS — (a)–(d) and the touch points read exactly on F(1/5); U1 recoloured G to R breaks TOUCH at q_N
  run: python3 ../tools/fs116_n1_axis.py --line
  expect: AXIS-TOUCH F(1/5): ALL AS DERIVED
  fault: python3 ../tools/fs116_n1_axis.py --line --plant

derivation: FS116-N1-F15TOUCH
  statement: FS116-Y1-F15's fragment F(1/5), valid on B̄(P₀, 6/5) and saturated on B̄(P₀, 1/5) about the degree-4 four-colour vertex P₀ whose tiles
    all have cones of 90°, has at q_N = P₀ + (0, 1) — the point p − ν(p) of the tangent-type edge along the negative x-axis, carrying O — a point that
    is not a change point of the ring and lies on no arc of Γ on ω(P₀): the ring is R on both sides of q_N; so SAT-QFREE with the words "whose ring
    carries no (Q) arc" deleted is false
  uses only: FS116-Y1-F15 (its validity and saturation, one mind, exact); exact point location in its 22 tiles at the ring points 0.11° from q_N and
    the tiles holding q_N
  not claimed: SAT-QFREE as posed (its ring carries four (Q) arcs, [60°, 75.52°] and its images); that the touch point survives saturation on B̄(P₀,
    1)
  argument: FS116-N1-proof.md § 4.2 SAT-QFREE: the touch point
  verdict: derived
  grade: computed over: F(1/5)'s tiles at the ring germs of its four axis points and their germs at ±60°
  minds: 1
  model: F(1/5) itself
  prior art: partly: F(1/5) is FS116-Y1's; the touch point on its ring is this record's reading
  handoff: none — a statement about one held object; it crosses to Lean only as a control on SAT-QFREE's hypothesis

With FS116-N1-TOUCH, the touch point SAT-QFREE stalls at, realised where the ring carries (Q) arcs. Rests on it: nothing in this file.

derivation: FS116-SAT-QFREE
  statement: in a valid fragment saturated on a disc about a vertex p of at least four colours, every tile at p with a cone of positive angle, whose
    ring carries no (Q) arc, each split centre of FS116-O1-SATPIN and each point p ± ν(p) of its tangent type is a change point of the ring or lies on
    an arc of Γ on ω(p)
  not claimed: rings with (Q) arcs; that such a vertex exists in a saturated fragment
  argument: FS116-N1-proof.md § 4.2 SAT-QFREE: the touch point
  verdict: gap: a touch point — a SATPIN point w off the arcs of Γ on ω(p) with the ring's colour X on both sides, X̄ on the four germs at w ± 60°, no
    X̄ at w (FS116-N1-TOUCH), and X at 2w − p where saturated (FS116-N1-ECHO) — neither excluded nor built; F(1/5) realises it where the ring carries
    (Q) arcs (FS116-N1-F15TOUCH), so a proof must use (Q)-freeness at the ends of the X-arc about w

Frozen at § 4. GAP (one mind). Rests on it: nothing in this file.

## Round 3 — the transfer rule (FS116-N2; no blind check)

derivation: FS116-N2-SIXRING
  statement: in a non-Siamese valid fragment on a closed disc of radius above 1 about a vertex p of six colours, the ring lies in Γ and is six
    consecutive closed 60° arcs Z_i = [α + 60°i, α + 60°(i + 1)], each the whole set of ring points in the closure of one tile t_i of p; t_i lies in
    the Reuleaux triangle Reul(p, z_i, z_(i+1)) on its arc, with cone at p in [α + 60°i − 30°, α + 60°i + 90°]; every ring arc is a (Q) arc, and every
    outer tile along a non-degenerate subarc of Z_i has the colour of t_(i+2), t_(i+3) or t_(i+4); the ring has no change point, so p has no hub
  uses only: FS116-N1-TWIST-D (a ring point off Γ carries a colour absent at p); non-Siamese (the inner tile of a ring arc is p's tile of its colour,
    and an outer tile is far from p's tile of its colour); that a tile has diameter at most 1 and a chord over more than 60° exceeds 1
  not claimed: that any valid fragment has a six-colour vertex beyond radius 3/2; an exclusion of the type at any radius (FS116-Y2-SIXOFF's family
    stops below √3; the general type is open); anything in the Siamese class (there an inner tile need not be p's)
  argument: FS116-N2-proof.md § 2.1 The ring types, by the number of colours at `p` — only a four-colour ring places anything
  verdict: derived
  grade: derived from: FS116-N1-TWIST-D
  minds: 1
  model: FS116-Y2-SIXFRAG, the straight flower — its sectors are the t_i, and its lenses Q_j, Q_(j+1) and gap tile G_j carry along Z_j exactly the
    three admissible outer colours j + 2, j + 3, j + 4 (plans/FS116-Y2-construction.md § 2.3, one mind, exact)
  prior art: partly: FS116-Y2's remark (§ 2.3, one mind) and FS112-NB's C-V56 hold the Reuleaux containment; the outer-colour rule not found — owed
  handoff: de Bruijn — with TWIST-D, queued behind D6's map type; a relay-result for any exclusion of six-colour vertices

No blind check ran (item 69). Rests on it: FS116-RING-TRANSFER-C; FS116-C114-LOCAL-F's six-colour case.

derivation: FS116-N2-FIVERING
  statement: in a valid fragment on a closed disc of radius above 1 about a vertex p of five colours, Siamese pairs allowed, the ring has no change
    point, and for every θ outside a finite set r(θ) or r(θ + 60°) lies on a (Q) arc; so the (Q) arcs of the ring have total length at least 180° and
    p has no hub
  uses only: FS116-N1-TWIST-D; N-E1; FS116-N1's L1 (a ring arc of Γ excludes its side colours 60° away); that p's four or more colours make a non-(Q)
    ring arc have an absent side colour
  not claimed: anything at k ≥ 7; that a five-colour vertex occurs in any fragment
  argument: FS116-N2-proof.md § 2.1 The ring types, by the number of colours at `p` — only a four-colour ring places anything
  verdict: derived
  grade: hand
  minds: 1
  model: none held with five colours at a vertex; at k = 7 the vertices of R7 carry six of seven, and the step "the absent colour is X" is where six
    is spent
  prior art: partly: FS116-N1-QFREE4 is its case with no (Q) arc; this form's search owed
  handoff: none — a relay-result for the ring-type list; crosses to Lean with TWIST-D

No blind check ran. Rests on it: FS116-RING-TRANSFER-C; FS116-C114-LOCAL-F's five-colour case.

derivation: FS116-N2-STAR
  statement: in a non-Siamese valid fragment on a closed disc of radius above 1 about a vertex p of four colours P, let y = r(ψ) be a change point of
    the ring, T_y the colours of the tiles of p at y and O_y those of the other tiles at y of colours of P; then C(y) = A(p) ⊔ T_y ⊔ O_y and A(y) = P
    ∖ (T_y ∪ O_y); every tile of p at y has its cone at p in [ψ − 90°, ψ + 90°], and the tile of p of each colour of O_y in [ψ + 90°, ψ + 270°]; every
    tile of p whose cone holds ψ + 90° or ψ − 90° in its interior has its colour in A(y); T_y is non-empty when v⁻, u⁺ lie on no (Q) arc and O_y when
    u⁻, v⁺ do
  uses only: RING-GERM (i), (ii) (two minds); FS116-N1-TWIST-D; N-E1 at y; non-Siamese (one tile per colour at y; distinct tiles of one colour far
    apart); that a tile has diameter at most 1; six colours (every colour at y other than X, X̄ is in P)
  not claimed: anything at k ≥ 7; that T_y or O_y is a single colour (at a hub y has four, five or six colours); anything about the ring of y beyond
    its branches at p
  argument: FS116-N2-proof.md § 2.2 The rule at a hub of a four-colour ring
  verdict: derived
  grade: derived from: FS116-RING-GERM
  minds: 1
  model: the strip's P₀ at its change points P_(±2) (the partial form: O = {B, O} and {M, P}, T = ∅, A(y) = {M, P} and {B, O}); the disk's corner at
    its two-colour change points (T = O = ∅) — control fs116-n2-star
  prior art: partly: FS114-N7-HUB (b), (c) and N7-TAN (i) (one mind each) on (Q)-free rings; this split at every change point not found — owed
  handoff: de Bruijn — with RING-GERM, queued behind D6's map type

No blind check ran; owed (item 69). Rests on it: FS116-N2-RECIP; FS116-N2-ANTI; FS116-RING-TRANSFER-C; FS116-Y3-HUBCOL; FS116-Y3-NBTIP; FS116-N3-SEMI; FS116-RING-TRANSFER-QC; FS116-Y4-EMPTY.

derivation: FS116-N2-RECIP
  statement: in a non-Siamese valid fragment on a closed disc of radius above 2 about a vertex p of four colours P, let y = r(ψ) be a hub of p with
    four colours and no more; the points of ω(y) at 60° on either side of p are r(ψ + 60°) and r(ψ − 60°); if p lies on no arc of Γ on ω(y) and the
    four arcs of ω(y) just clockwise and just counter-clockwise of those two points lie on no (Q) arc of y's ring, then p is a change point of y's
    ring, its two sides lying in the tiles of p that hold the directions ψ − 90° and ψ + 90°, whose colours are the two colours of A(y)
  uses only: FS116-N2-STAR; FS116-N1-TOUCH (one mind: a point of D off Γ-arcs that is no change point has the other absent colour at none of its
    tiles); N-E1 at y; six colours (A(y) ⊂ P)
  not claimed: anything when an edge of p runs along ω(y) (then p lies on an arc of Γ on ω(y), a tactic edge centred at y when its sides are y's
    colours); that the hub has four colours in general; anything at k ≥ 7
  argument: FS116-N2-proof.md § 2.2 The rule at a hub of a four-colour ring
  verdict: derived
  grade: derived from: FS116-N2-STAR, FS116-N1-TOUCH
  minds: 1
  model: none held (no held fragment has a hub, § 2.4); on (Q)-free rings FS114-N7-HUB's six change points are its instances where their rings meet
    the hypotheses
  prior art: owed
  handoff: de Bruijn — with STAR and TOUCH

No blind check ran; owed. Not vacuous by FS116-Y4-EMPTY: its `p` need not have a Γ-free ring (item 124). Rests on it: FS116-N2-HEX6; FS116-RING-TRANSFER-C.

derivation: FS116-N2-ANTI
  statement: in a non-Siamese simple valid fragment on a closed disc of radius above 1 about a vertex p of four colours, let y = r(ψ) and y* = r(ψ +
    180°) be hubs of p, and let ψ + 90° and ψ − 90° lie in the interiors of the cones at p of tiles t⁺ and t⁻; then t⁺ ≠ t⁻, A(y) = A(y*) = {c(t⁺),
    c(t⁻)}, T_y = O_(y*) and O_y = T_(y*), each a single colour, and y and y* have four colours and no more
  uses only: FS116-N2-STAR at y and at y*; that p has exactly four tiles (non-Siamese and simple); that a cone is an interval
  not claimed: anything when an edge of p leaves at ψ + 90° or ψ − 90° (the strip: there the two missing pairs differ); anything at k ≥ 7
  argument: FS116-N2-proof.md § 2.2 The rule at a hub of a four-colour ring
  verdict: derived
  grade: derived from: FS116-N2-STAR
  minds: 1
  model: none held with two antipodal hubs; the strip's P₀ meets every hypothesis but the interiority of the flanking directions, and fails the
    conclusion (A(P₂) = {M, P}, A(P₋₂) = {B, O}) — control fs116-n2-star
  prior art: owed
  handoff: de Bruijn — with STAR

No blind check ran; owed. Rests on it: FS116-RING-TRANSFER-C.

derivation: FS116-N2-HEX6
  statement: in a non-Siamese simple valid fragment on a closed disc of radius above 2 about a vertex p of at least four colours whose ring carries no
    arc of Γ, the ring's change points include six hubs y_k = r(ψ + 60°k), k in Z/6, and of any four consecutive y_k at least one has a ring carrying
    an arc of Γ; in particular the six rings are not all free of arcs of Γ
  uses only: FS116-N1-QFREE4 at p and at each recurring hub; RING-GERM's Step 1 and (iii) (two minds); FS116-N2-RECIP; N-E1 at y_(m−1) and y_(m+2) at
    a D-direction inside a tile; that p has four edges (non-Siamese, simple, four colours); six colours at (c)
  not claimed: that any Γ-free four-colour vertex exists in a valid six-coloured fragment; anything for rings free of (Q) arcs but carrying other arcs
    of Γ (N6-RING60's bends would be needed); anything at k ≥ 7; the placed vertices' rings beyond whether they carry an arc of Γ
  argument: FS116-N2-proof.md § 3.1 The `Γ`-free type does not recur round its hexagon (FS116-N2-HEX6, FS116-N2-HEX3)
  verdict: derived
  grade: derived from: FS116-N2-RECIP
  minds: 1
  model: none held at six colours (no Γ-free four-colour vertex is held: FS116-N1-QFREE4's model line); the hypotheses at p are FS114-N7-HUB's, whose
    six change points are this hexagon
  prior art: partly: FS114-N6-RING60 and N7-HUB (the hexagon and its four-colour points); the complement relation in KG(4, 2) and the edge count not
    found — owed
  handoff: de Bruijn — with RECIP, STAR and TOUCH; a relay-result for D2 (the first shell of a Γ-free vertex holds a hub whose ring carries an arc of
    Γ)

**True vacuously** — its class is FS116-Y4-EMPTY's (items 124, 139). No blind check ran. Rests on it: FS116-N2-HEX3; FS116-RING-TRANSFER-C.

derivation: FS116-N2-HEX3
  statement: in HEX6's setting, if every y_k has four colours and no more, the set S of k whose y_k has a ring free of arcs of Γ is empty, one hub, or
    of the form {k, k+1}, {k, k+3}, {k, k+2} or {k, k+1, k+2}; with {k, k+3} the missing pairs of y_k and y_(k+3) are not complementary; with {k, k+2}
    or {k, k+1, k+2} the four edges of p leave at D_k, D_(k+1), D_(k+3), D_(k+4) (D_m = ψ + 30° + 60°m), y_k and y_(k+2) miss one pair and y_(k+1),
    y_(k+3), y_(k+4), y_(k+5) the complementary pair
  uses only: FS116-N2-HEX6's steps (c) and (d); that two disjoint 2-subsets of a four-colour set are complementary
  not claimed: that any S of the list occurs; anything without four colours at every hub (then only HEX6)
  argument: FS116-N2-proof.md § 3.1 The `Γ`-free type does not recur round its hexagon (FS116-N2-HEX6, FS116-N2-HEX3)
  verdict: derived
  grade: derived from: FS116-N2-HEX6
  minds: 1
  model: none held, as HEX6
  prior art: owed
  handoff: de Bruijn — with HEX6

**True vacuously** — as HEX6. Rests on it: nothing in this file.

derivation: FS116-RING-TRANSFER-C
  statement: in a non-Siamese simple valid fragment on a closed disc of radius above 2 about a vertex p of at least four colours: a ring of five or
    six colours has no change point and places no vertex through RING-GERM, the six-colour ring being six 60° (Q) arcs, one per tile of p, each tile
    in the Reuleaux triangle on its arc; a ring of four colours places its hubs, and at each hub y = r(ψ) the ring of p and the tiles of p holding the
    directions ψ + 90° and ψ − 90° determine the colours of y as the absent pair of p, the tip colours and the outer colours, and the pair missing at
    y, which contains the colour of every tile of p holding ψ ± 90° inside its cone; when y has four colours and its ring meets no (Q) arc at the
    points r(ψ ± 60°) and no arc of Γ at p, p is a change point of y's ring between the two colours missing at y; two antipodal hubs whose flanking
    directions lie inside tiles of p miss the same pair and exchange tip and outer colour; and a ring free of arcs of Γ has, among any four
    consecutive of its six hubs, one whose ring carries an arc of Γ
  uses only: FS116-N2-SIXRING, FS116-N2-FIVERING, FS116-N2-STAR, FS116-N2-RECIP, FS116-N2-ANTI, FS116-N2-HEX6, and through them RING-GERM (two minds),
    RING-TWIST-C (two minds), FS116-N1-TWIST-D, -QFREE4 and -TOUCH (one mind each)
  not claimed: that the ring type of p alone determines any of this (the star is an input); anything about the arcs of Γ on the placed vertex's ring
    outside B̄(p, 1); the recurrence of types with (Q) arcs (RING-TRANSFER-Q, GAP); that the rule is the same at k = 7 (every step spends six: two
    absent colours)
  argument: FS116-N2-proof.md § 3.3 The verdict on RING-TRANSFER
  verdict: derived
  grade: derived from: FS116-N2-STAR, FS116-N2-RECIP, FS116-N2-ANTI, FS116-N2-HEX6, FS116-N2-SIXRING, FS116-N2-FIVERING
  minds: 1
  model: the strip's P₀ for STAR's partial form (control fs116-n2-star); FS116-Y2-SIXFRAG for the six-colour clause; no held hub for the rest
  prior art: owed — a search in the Kneser and local-rule vocabularies (§ 1.2) is the report's debt
  handoff: de Bruijn — deferred with D6's map type, after a blind second mind on STAR, RECIP, ANTI and HEX6

RING-TRANSFER (§ 5) is **MISSTATED** (its input too small: the rule reads `p`'s star; its output too large: each placed ring's 240° arc outside `B̄(p, 1)` is unread; N2 § 3.3); this is its corrected form, one mind, its last clause ("a ring free of arcs of Γ has …") true vacuously by FS116-Y4-EMPTY, held (items 124, 139). Rests on it: nothing in this file.

## Round 3 — SAT-STRIP from both sides (FS116-S1; FS116-V4 blind on three)

derivation: FS116-S1-KAPPA
  statement: at a vertex p of four colours and no more of a valid fragment on a closed disc of radius above 1 about p, Siamese pairs allowed, whose
    ring carries no (Q) arc, every germ of ω(p) (an arc just clockwise or just counter-clockwise of a ring point) lies in the closure of tiles of
    exactly one of the two colours absent at p, κ, and the germ 60° on carries the other; so κ's change points form a finite non-empty set invariant
    under the rotation by 60° about p, each half-open 60° window of ω(p) holds an odd number of them, and antipodal germs carry different colours; in
    a non-Siamese fragment κ's change points are exactly y + 60°ℤ for one ring point y
  uses only: N-E1; local finiteness (a germ lies in one tile or on one arc of Γ on ω(p)); the definition of a (Q) arc; that ω(w) crosses ω(p)
    transversally at the ring points 60° from w; two absent colours, spent once, at (c); CL and a tile's diameter at most 1, for the last clause only
  not claimed: anything when the ring carries a (Q) arc; anything at k ≥ 7 (at k = 9 SQ9's r(45°) and r(225°) carry one colour); that any vertex of
    the class exists at six colours
  argument: FS116-S1-proof.md § 2.1 The ring's colouring on a (Q)-free ring (FS116-S1-KAPPA)
  verdict: derived
  grade: hand
  minds: 2 — blind to: S1's record until V4's verdicts (48534b7c), told by its brief that a decided result rests on it (items 107, 108); method: three
    ring points and FS116-V4-DICHOTOMY against N-E1 at w (V4, Divergences on KAPPA row 1); the same model (Opus 5.5), one prior
  model: SQ9 at k = 9 about a grid point satisfies every hypothesis but the colour count, and its N-E1 clause holds while its antipodal clause fails —
    control sq9-antipode; no vertex of the class is held at six colours (as FS116-N1 and FS116-N2 report)
  prior art: partly: FS114-N6-KAPPA and FS114-N6-RING60 (non-Siamese, after FS-112's bends), RING-TWIST-C (qualifying windows only); this form's
    search is owed
  handoff: de Bruijn — with N-E1 and the germ convention; queued behind D6's map type

Frozen at § 12 with "tiles of exactly one colour absent at p" and "the change points are exactly": TRUE in the ruled reading (B) with κ's change points (item 103); filed in V4's corrected wording (V4, Divergences on KAPPA rows 3–4; item 109). Under § 10's ring change points the last clause is GAP at whether an orbit point can end an arc of Γ on ω(p). Two minds, blind, with item 108's caveat. Rests on it: FS116-S1-PAIR; FS116-S1-LENS.

derivation: FS116-S1-PAIR
  statement: in a valid fragment as in FS116-S1-KAPPA, let z be a point with 0 < |z − p| < 2, φ its direction from p and α = arccos(|z − p|/2), so
    that r(φ + α) and r(φ − α) are the ring points at distance 1 from z; if neither φ + α nor φ − α is a change point, no tile of colour κ(φ + α) or
    κ(φ − α) has z in its closure; in particular where κ(φ + α) ≠ κ(φ − α) only colours of p are carried at z
  uses only: FS116-S1-KAPPA; N-E1 at an interior point z′ of a hypothetical tile near z, whose ring points lie in the same cells and off the finite
    exceptional set (z ↦ φ ± α is continuous and open); that ω(z′) crosses ω(p) transversally for 0 < |z′ − p| < 2
  not claimed: anything at a point whose ring point is a change point; which colours of p are carried
  argument: FS116-S1-proof.md § 2.2 The two-point exclusion (FS116-S1-PAIR)
  verdict: derived
  grade: derived from: FS116-S1-KAPPA
  minds: 1
  model: SQ9 at k = 9 shows the contrapositive's content: there the two ring points' colours exclude two of five absent colours and leave three; no
    six-colour model is held
  prior art: owed: the two points of a circle at a given distance from a point are classical; its use as a colour map of B(p, 2) not searched
  handoff: de Bruijn — with FS116-S1-KAPPA

One mind (not frozen). Rests on it: FS116-S1-LENS.

derivation: FS116-S1-CLUSTER
  statement: in a valid k-coloured fragment, for any k, Siamese pairs allowed, let 𝒯 be a finite family of tiles of one colour c the union of whose
    closures is connected, and U a tile of colour c; if some point of that union is at distance below 1 from some point of cl U, every point of the
    union is at distance at most 1 from every point of cl U
  uses only: validity; tiles are open and connected; the distances between two tiles form an interval; no point is at distance exactly 1 from every
    point of an open set
  not claimed: anything for an infinite family; that the tiles of 𝒯 are pairwise near
  argument: FS116-S1-proof.md § 2.3 Clusters (FS116-S1-CLUSTER) and the rung (FS116-S1-RUNG); STRIPCEIL recovered
  verdict: derived
  grade: hand
  minds: 1
  model: F(1/5) (FS116-Y1-F15): its M* and the tile over V_{−1}, both of D_0's colour, within distance below 1 near (1/5, 1) and V_{−1}, and near
    throughout — control rung-ceil reads 1/5 inside the cap
  prior art: owed (an interval argument lifted to a connected family; the search is in the words of distance graphs of connected sets)
  handoff: de Bruijn — a short lemma on connected families of open sets; it crosses with RUNG

One mind; V4 reached the same mechanism as FS116-V4-MEET. Rests on it: FS116-S1-RUNG; FS116-S1-QF.

derivation: FS116-S1-RUNG
  statement: let p be a degree-4 vertex of four colours of a valid fragment whose four edges are segments along the four half-axes, with tiles
    coloured c_I, c_II, c_III, c_IV by quadrant, and suppose the fragment saturated at every point of the east edge's first segment [p, p + (ℓ, 0)], 0
    < ℓ ≤ L_E; if a tile of colour c_IV has a point w in its closure with |w − q_N| < 1, q_N = p + (0, 1), then |w − p − (s, 1)| ≤ 1 for every s in
    [0, ℓ]; and the same at each edge and axis point, turned and reflected with the quadrants; in particular a contact of c_IV at r(φ), 90° < φ <
    150°, gives ℓ ≤ cos φ + √(sin φ (2 − sin φ)), which at φ = 120° is FS116-Y1-STRIPCEIL's x* = √(√3 − 3/4) − 1/2
  uses only: FS116-O1-SATPIN in FS116-V1's corrected wording (two minds: the edge is of tangent type, so (s, 1) lies in the closure of colour c_IV);
    local finiteness; FS116-S1-CLUSTER
  not claimed: anything at a partner point where the edge is not saturated; anything for edges that are not segments; that a contact exists in
    quadrant II in any fragment of SAT-STRIP's class (FS116-S1-LENS supplies one where the ring carries no (Q) arc)
  argument: FS116-S1-proof.md § 2.3 Clusters (FS116-S1-CLUSTER) and the rung (FS116-S1-RUNG); STRIPCEIL recovered
  verdict: derived
  grade: derived from: FS116-O1-SATPIN, FS116-S1-CLUSTER
  minds: 2 — blind to: S1's record until 48534b7c, with item 108's caveat; method: FS116-V4-PARTNER (saturation at the edge point) against SATPIN's
    tangent clause, FS116-V4-MEET against CLUSTER; the same model (Opus 5.5), one prior
  model: F(1/5): ℓ = 1/5 and the contact V_{−1} = r(120°), with |V_{−1} − (1/5, 1)| < 1 — control rung-ceil
  prior art: partly: FS116-Y1-STRIPCEIL is its instance at r(120°) for fragments keeping the strip in B(P_0, 1); the general form's search is owed
  handoff: de Bruijn — with SATPIN; a rung-and-contact lemma

Frozen at § 12. TRUE, Siamese pairs allowed; a thin truth (its main clause needs neither degree 4, nor four colours, nor the other three edges; V4 § Attack on RUNG); two minds, blind, with item 108's caveat. Rests on it: nothing in this file.

control: rung-ceil
  of: FS116-S1-RUNG — the cap at the contact r(120°) is exactly x* = √(√3 − 3/4) − 1/2, F(1/5)'s 1/5 lies inside it and the strip's 1/2 outside; with
    the contact moved to r(110°) the exact identity fails
  run: python3 ../tools/fs116_s1_check.py ceil
  expect: RUNG-CEIL: |V-(x*,1)|=1 True; 1/5 inside True; 1/2 outside True; x*=0.49098477
  fault: python3 ../tools/fs116_s1_check.py ceil --plant

derivation: FS116-S1-LENS
  statement: let p be a degree-4 vertex of four colours of a non-Siamese valid fragment on a closed disc of radius above 1 about p whose four edges
    are segments along the four half-axes and whose ring carries no (Q) arc; then no change point of κ lies on an axis; the least change point c_− and
    the greatest c_+ in (−90°, 90°) satisfy −90° < c_− < −30° and 30° < c_+ < 90°; the open lens Λ = B(r(c_−), 1) ∩ B(r(c_+), 1) meets no tile but T_I
    and T_IV; and r(c_+ + 60°) and r(c_− − 60°) are change points in the open quadrants II and III at distance below 1 from q_N and q_S, each holding
    in its closure an outward tile, of colour c_IV and c_I, while T_IV misses B(r(c_+ + 60°), 1) and T_I misses B(r(c_− − 60°), 1)
  uses only: FS116-S1-KAPPA; FS116-S1-PAIR; FS116-N1-GERM-S (i), (ii) (two minds, FS116-V3) at change points, whose germs lie on no (Q) arc;
    FS116-N1-AXIS (a) (two minds, FS116-V3); CL; that a tile of p in B̄(y, 1), or missing B(y, 1), has its cone in the closed half-plane facing y, or
    facing away
  not claimed: rings with (Q) arcs; Siamese fragments (a tile Siamese-near T_II or T_III may meet Λ); crosses not at right angles; saturation is not
    used
  argument: FS116-S1-proof.md § 2.4 The two-tile lens about the east edge (FS116-S1-LENS) and the exit (FS116-S1-EXIT)
  verdict: derived
  grade: derived from: FS116-S1-KAPPA, FS116-S1-PAIR, FS116-N1-GERM-S, FS116-N1-AXIS
  minds: 1
  model: SQ9 at k = 9 meets every hypothesis but six colours, and there the lens about its east edge meets squares of five colours — the step that
    fails is KAPPA (c), control sq9-antipode
  prior art: owed
  handoff: de Bruijn — with KAPPA, PAIR and GERM-S; queued behind D6's map type

One mind. Rests on it: FS116-S1-QF.

derivation: FS116-S1-EXIT
  statement: let 30° < b < 90° and −90° < a < −30°, y_b = e(b), y_a = e(a), y_3 = e(b + 60°), y_5 = e(a − 60°) and Λ = B(y_a, 1) ∩ B(y_b, 1); let γ on
    [0, t_e] be a C¹ curve with γ(0) = 0, γ(t) in Λ for 0 < t < t_e and γ(t_e) in ∂Λ other than 0, with left unit normal ν; if at t_e |γ + ν − y_3| ≤
    1, |γ − ν − y_5| ≤ 1, |γ − y_3| ≥ 1 and |γ − y_5| ≥ 1, then γ(t_e) + ν(t_e) = y_b or γ(t_e) − ν(t_e) = y_a
  uses only: the left derivative of |γ − y_b|² (or |γ − y_a|²) at the first exit, which is non-negative; that the headings putting γ + ν in B̄(y_3, 1)
    form an arc of length at most 120° when |γ − y_3| ≥ 1; the identities P = y_b at the side's tangent heading, |y_b − y_3| = 1 and d|P − y_3|²/dβ =
    −2 cos(φ − b + 150°) there, with their mirrors for Q, checked symbolically; the signs on b − a > 60°
  not claimed: anything about colourings (it is a lemma on curves and four points); that such a curve exists
  argument: FS116-S1-proof.md § 2.4 The two-tile lens about the east edge (FS116-S1-LENS) and the exit (FS116-S1-EXIT)
  verdict: derived
  grade: hand
  minds: 1
  model: the reach exploration at ψ = 29° (tools/fs116_s1_reach.py, coarse run): its one meeting with the side was at the side's tangent heading, as
    EXIT predicts; the identities are control exit-identities
  prior art: owed (a two-disc exit lemma for curves with unit normals)
  handoff: de Bruijn — an elementary plane-geometry lemma; mechanical

One mind; its identities exact (control `exit-identities`). Rests on it: FS116-S1-QF.

control: exit-identities
  of: FS116-S1-EXIT — the six identities hold symbolically and the derivatives have the derived signs at 3,675 rational points a side; with y_3 put at
    e(b − 60°) the derivative identity fails and the lower sign flips
  run: python3 ../tools/fs116_s1_check.py exit
  expect: EXIT: P=y_b True; |y_b-y_3|=1 True; dP-form True; Q=y_a True; |y_a-y_5|=1 True; dQ-form True; lower d<0 at 3675/3675; upper d>0 at
    3675/3675
  fault: python3 ../tools/fs116_s1_check.py exit --plant

derivation: FS116-S1-QF
  statement: no non-Siamese valid fragment on B̄(p, 2), saturated on B̄(p, 1), whose ring ω(p) carries no (Q) arc, has at p a degree-4 vertex of four
    colours whose four edges are segments at right angles
  uses only: FS116-S1-LENS; FS116-S1-EXIT; FS116-S1-CLUSTER; FS116-O1-SATPIN in FS116-V1's wording and V1's L1 (the tangent partners are "out", so far
    from the tile they face); FS111-W-NOBEND and SATPIN's open-and-closed step along the interface (saturation on Λ ⊂ B(p, 1)); the Jordan curve
    theorem (two tiles cannot alternate four times about a point); local finiteness; that T_IV and T_I hold points near p within distance below 1 of
    r(c_+) and r(c_−)
  not claimed: SAT-STRIP itself (rings with (Q) arcs, Siamese fragments, crosses not at right angles stay open: § 2.5's G1–G3); anything at k ≥ 7 (at
    k = 9 SQ9 meets every other hypothesis); that the class is non-empty at six colours without the cross
  argument: FS116-S1-proof.md § 2.5 SAT-STRIP in the (Q)-free non-Siamese class (FS116-S1-QF)
  verdict: derived
  grade: derived from: FS116-S1-LENS, FS116-S1-EXIT, FS116-S1-CLUSTER, FS116-O1-SATPIN
  minds: 1 — and a second derivation by a different route (FS116-V4 § 2.4: the rung tiles cross in the crescent B(q, 1) ∖ B̄(p, 1), by Jordan), whose
    brief told it the first's verdict (item 107), so it is not counted as a blind second mind (items 108, 115); a blind second mind is owed
  model: SQ9 at k = 9, which holds the configuration with every hypothesis but six colours — where the argument fails at KAPPA (c), control
    sq9-antipode
  prior art: owed: this job ran no search; FS-111's gate ("chromatic & plane & (measurable | map) & (tight | saturat* | maximal)", 7 hits, recalled
    from plans/FS111-derivation.md, not rerun) found nothing on saturated colourings; the search is owed in the words of distance-avoiding colourings
    whose classes are maximal
  handoff: de Bruijn — the composition of LENS, EXIT and CLUSTER, queued behind SATPIN, M-PINCH and D6's map type

Frozen at § 12. TRUE; **not held** (items 108, 115): V4's derivation is a second route, but its brief gave QF's verdict. V4's route shows saturation is needed only at the points of `p`'s four edges. Rests on it: nothing in this file; FS116-C114-LOCAL-F's saturated-cross case; FS116-SAT-STRIP's narrowing.

derivation: FS116-V4-CHORD
  statement: two points r(α), r(β) of a unit circle about p, at angular separation δ = |α − β| ∈ [0°, 180°], are at distance 2 sin(δ/2); so the
    distance is 1 at δ = 60°, below 1 for δ < 60° and above 1 for 60° < δ ≤ 180°; and for β > α the chord from r(α) to r(β) points in the direction (α
    + β)/2 + 90°
  uses only: the law of cosines on the isosceles triangle p, r(α), r(β)
  not claimed: anything about circles of other radii
  argument: FS116-V4-verification.md § 1.4 argument
  verdict: derived
  grade: hand
  minds: 1
  model: α = 0°, β = 60° — r(0°) = (1, 0), r(60°) = (1/2, √3/2), distance 1
  prior art: known — elementary
  handoff: none — a relay-result for stage 2

V4's lemma, one mind; prior art owed (item 113). Rests on it: FS116-V4-TWIST; FS116-V4-OUTER; FS116-V4's second derivations of FS116-S1-KAPPA, -RUNG and -QF (counted in those entries' minds).

derivation: FS116-V4-DICHOTOMY
  statement: in a valid k-coloured fragment, for tiles A, B of one colour (A = B allowed), either every point of A is at distance below 1 from every
    point of B (write A ~ B) or every point of A is at distance above 1 from every point of B (A ⊥ B); A ~ A, so the closure of a tile has diameter at
    most 1; if points z ∈ cl A, z′ ∈ cl B have |z − z′| < 1 then A ~ B, and if |z − z′| > 1 then A ⊥ B; in a non-Siamese fragment A ~ B forces A = B
  uses only: that A × B is connected and the distance is continuous on it
  not claimed: anything for tiles of different colours
  argument: FS116-V4-verification.md § 2.1 The four lemmas
  verdict: derived
  grade: hand
  minds: 1
  model: FS111-W-SQ9 (k = 9, squares of side 1/2): two squares of one colour three squares apart are at distance above 1 throughout
  prior art: owed — elementary; no search run by this job
  handoff: none — a relay-result for KAPPA, RUNG and QF

V4's lemma, one mind; it is FS116-V1-FRAME's F0 and FS116-V5-NE1 in another form. Rests on it: FS116-V4-MEET; FS116-V4-TWIST; FS116-V4-PARTNER; FS116-V4-OUTER; FS116-V4's second derivations of FS116-S1-KAPPA, -RUNG and -QF (counted in those entries' minds).

derivation: FS116-V4-MEET
  statement: if tiles A, B of one colour have a common closure point z, then for every tile T of that colour, T ~ A holds if and only if T ~ B
  uses only: V4-DICHOTOMY, and that an open set is not contained in a circle
  not claimed: anything when cl A and cl B are disjoint
  converse: FS116-V4-verification.md § 2.1 The four lemmas
  argument: FS116-V4-verification.md § 2.1 The four lemmas
  verdict: derived
  grade: hand
  minds: 1
  model: two adjacent squares of one colour in a periodic colouring (Siamese), and any third square of that colour
  prior art: owed — elementary; no search run by this job
  handoff: none — RUNG's Siamese case rests on it

V4's lemma, one mind. Rests on it: nothing in this file; FS116-V4's second derivations of FS116-S1-KAPPA, -RUNG and -QF (counted in those entries' minds).

derivation: FS116-V4-TWIST
  statement: at a point p of a valid k-coloured fragment on a disc of radius above 1 about p, for any k, Siamese pairs allowed, no colour has a tile
    whose closure holds a germ g of ω(p) and a tile (the same or another) whose closure holds σg or σ⁻¹g; and a point of ω(p) inside a tile has that
    tile's colour absent at p when p is a vertex
  uses only: V4-DICHOTOMY, V4-CHORD
  not claimed: anything about germs lying on Γ with the colour on neither side
  argument: FS116-V4-verification.md § 2.1 The four lemmas
  verdict: derived
  grade: hand
  minds: 1
  model: FS111-W-SQ9 at p = (0, 0): the germ of ω just counter-clockwise of r(0°) lies in square (1, 0), colour (1, 0), and the germ just
    counter-clockwise of r(60°) in square (1, 1), colour (1, 1) — different, as the lemma requires
  prior art: owed — no search run by this job; the list's RING-TWIST-C (§ 10) states a relative of it
  handoff: none — KAPPA rests on it

V4's lemma, one mind. Rests on it: nothing in this file; FS116-V4's second derivations of FS116-S1-KAPPA, -RUNG and -QF (counted in those entries' minds).

derivation: FS116-V4-PARTNER
  statement: let x be an interior point of a segment edge of a valid k-coloured fragment from a point p, of direction u and first-segment length L,
    with tile T_a on its clockwise side and T_b on its counter-clockwise side, and ν = u turned by +90°; if the fragment is saturated at x, then x + ν
    lies in the closure of a tile of T_a's colour and x − ν in the closure of a tile of T_b's colour, and every tile of T_a's colour other than T_a
    whose closure meets ω(x) is far from T_a (⊥)
  uses only: V4-DICHOTOMY, the half-discs of T_a and T_b at x, and T_a, T_b running along the whole open segment
  not claimed: anything when the edge is curved; anything at p itself or at the segment's far end (closure gives those points of supp only)
  argument: FS116-V4-verification.md § 2.3 Derivation of RUNG
  verdict: derived
  grade: hand
  minds: 1
  model: FS111-W-SQ9's east edge at p = (0, 0): (s, 1 + 1/1000) carries c_IV = (0, 2) for 0 < s < 1/2 (control `v4-sq9rung`)
  prior art: owed — no search run by this job; the list's FS116-O1-SATPIN (§ 3) states the same as its tangent type
  handoff: none — RUNG and QF rest on it

V4's lemma, one mind: SATPIN's tangent clause for segment edges, with none of SATPIN's hypotheses on `p`. Rests on it: nothing in this file; FS116-V4's second derivations of FS116-S1-KAPPA, -RUNG and -QF (counted in those entries' minds).

derivation: FS116-V4-OUTER
  statement: in a non-Siamese valid fragment on a disc of radius above 1 about a degree-4 vertex p of four colours whose four edges are segments at
    right angles and whose ring carries no (Q) arc, at each of κ's change points c in an open quadrant, the directions within 30° of the outward
    direction at c lie in one tile, not a tile of p, of the colour of the quadrant tile opposite to c's quadrant
  uses only: KAPPA's K6 (as derived in § 2.2), V4-DICHOTOMY, V4-CHORD
  not claimed: anything at a change point on an axis; anything for crosses not at right angles (there the colour of the tile above the far edge can
    qualify as well: § Attack on QF)
  argument: FS116-V4-verification.md § 2.4 Derivation of QF
  verdict: derived
  grade: hand
  minds: 1
  model: none at six colours — the class is the one QF empties; the step's arithmetic is checked on its own (control `v4-outer`)
  prior art: owed — no search run by this job; the list's RING-GERM (ii) (§ 10) states a relative of it
  handoff: none — QF rests on it

V4's lemma, one mind. Rests on it: nothing in this file; FS116-V4's second derivations of FS116-S1-KAPPA, -RUNG and -QF (counted in those entries' minds).

derivation: FS116-SAT-STRIP
  statement: no valid fragment on B̄(p, 2) saturated on B̄(p, 1) has at p a degree-4 vertex of four colours whose four edges are segments
  not claimed: anything at k ≥ 7 (at k = 9 the square nine-colouring of side 1/2 has such vertices, saturated); anything about unsaturated fragments
    (the capped strip holds such a vertex to φ²/√2, FS114-Y-DIAL)
  argument: FS116-S1-proof.md § 2.5 SAT-STRIP in the (Q)-free non-Siamese class (FS116-S1-QF)
  verdict: gap: TRUE where the edges meet at right angles, the ring carries no (Q) arc and the fragment is non-Siamese (FS116-S1-QF); open on rings
    with (Q) arcs (the strip-like class, where κ's 60° rule breaks and the quadrant-II contact is a (Q) arc's outer tile), on Siamese fragments (a
    Siamese tile of c_II or c_III inside the edge's lens, or a four-sector vertex on its interface) and on crosses not at right angles

Frozen at § 4. GAP — first at the right-angled cross's axis structure (FS116-N1-proof.md § 4.3, one mind), then narrowed by S1 to G1–G3 (this block, S1 § 2.5). P1 (SAT-STRIP TRUE, 0.55) is not scored. Rests on it: nothing in this file.

derivation: FS116-Y-SAT
  statement: a valid fragment on B̄(p, R), saturated on B̄(p, R − 1), about a vertex p of at least four colours, for the largest R reached (first: the
    capped strip made saturated at its midline, which decides SAT-STRIP from the other side) — or a derived obstruction at a named radius
  argument: FS116-S1-proof.md § 2.5 SAT-STRIP in the (Q)-free non-Siamese class (FS116-S1-QF)
  verdict: stalls at: no construction this job; the obstruction FS116-S1-QF at R = 2 holds only in its class, and a positive at SAT-STRIP's
    configuration must carry a (Q) arc on its ring, a Siamese pair inside an edge's lens, or edges not at right angles

Frozen at § 7; its parenthetical ("the capped strip made saturated at its midline, which decides SAT-STRIP from the other side") cannot hold (FS116-Y1-STRIPCEIL) and is read as "a geometry differing from the strip inside the unit disc, saturated on `B̄(p, 1)`" (item 45). No construction (Y1, Y2, S1). Rests on it: nothing in this file.

## Round 3 — the Γ-free hub (FS116-Y3; FS116-V5 blind on five)

derivation: FS116-Y3-SIX
  statement: in a non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours whose
    ring carries no arc of Γ, the ring has exactly six change points, 60° apart, each a hub, and p has exactly four tiles
  uses only: FS116-N1-QFREE4 (four colours and no more at p); RING-TWIST-C (the ring's colours swapped by σ, an odd number of colour changes per
    half-open 60° window); RING-GERM (i) (a tip at each change point); that a tile of p has diameter at most 1 and lies in B̄(p, 1); non-Siamese and
    simple (four tiles)
  not claimed: anything in the Siamese class (there RING-GERM's tip is GERM-S's tile, not necessarily a tile of p, and the count is not run); anything
    at k ≥ 7 (SQ9 at k = 9 has twelve); that any such fragment exists
  argument: FS116-Y3-construction.md § 2.1 Exactly six change points, all hubs (FS116-Y3-SIX)
  verdict: derived
  grade: derived from: FS116-RING-TWIST-C, FS116-RING-GERM, FS116-N1-QFREE4
  minds: 2 — blind to: Y3's record until V5's verdicts (320a3b53); method: FS116-V5-RING (non-Siamese against a tile's 60° reach; no simplicity)
    against Y3's tip count; the same model (Opus 5.5), one prior
  model: none at six colours (no Γ-free four-colour vertex is held: N2 § 2.4); SQ9 at k = 9 meets every hypothesis but six colours and has twelve
    change points — control fs116-y3-sq9
  prior art: partly: FS116-V1's V1-F5 ("exactly six change points", inventory item 30, not read here); FS114-N6-RING60's hexagon; the tile count not
    found — owed
  handoff: de Bruijn — with RING-TWIST-C and RING-GERM, queued behind D6's map type

**True vacuously** — Frozen at § 14. TRUE; "simple" idle on V5's route (a thin truth); **held** (item 118). Rests on it: FS116-Y3-TIPS; FS116-Y3-NOQ; FS116-Y4-EMPTY.

derivation: FS116-Y3-TIPS
  statement: in FS116-Y3-SIX's setting, with the hubs y_k = e(60k), each hub has exactly one tip, the tips of antipodal hubs are opposite tiles of p,
    and up to rotation of the labels the four tiles of p, counter-clockwise, are T1 tipping y_0 and y_1 (cone at p in [−30°, 90°]), T3 tipping y_2 (in
    [30°, 210°]), T2 tipping y_3 and y_4 (in [150°, 270°]) and T4 tipping y_5 (in [210°, 30°])
  uses only: FS116-Y3-SIX; RING-GERM (i); that a tip of y lies in B̄(y, 1); that the closed unit discs about antipodal hubs meet only at p; that two
    tiles adjacent at p share a non-degenerate boundary curve from p
  not claimed: anything in the Siamese or non-simple class; that the cones fill their ranges (each δ is free in its interval); that any such fragment
    exists
  argument: FS116-Y3-construction.md § 2.2 The tip pattern is forced (FS116-Y3-TIPS)
  verdict: derived
  grade: derived from: FS116-Y3-SIX, FS116-RING-GERM
  minds: 2 — blind to: Y3's record until 320a3b53; method: the same argument (V5 § 4.1); the same model (Opus 5.5), one prior
  model: none at six colours; the lattice facts it uses are control fs116-y3-lattice
  prior art: partly: FS116-N2-HEX3 names the star with δ = 90°, 150°, 270°, −30° under a recurrence hypothesis; the forcing of the pattern not found —
    owed
  handoff: de Bruijn — with SIX; a relay-result for any exclusion of the Γ-free type

**True vacuously** — Frozen at § 14. TRUE; **held** (item 118). Rests on it: FS116-Y3-HUBCOL; FS116-Y3-TIGHT; FS116-Y3-LENS; FS116-Y3-NBTIP; FS116-V5-LENS; FS116-Y4-SYM; FS116-Y4-EMPTY.

derivation: FS116-Y3-HUBCOL
  statement: in FS116-Y3-TIPS's labelling, each hub's colours are X, X̄, its tip's colour and a non-empty set of outer colours drawn from the list of
    § 2.3 (y_0: 2, and 3 only if δ_1 = 90°; y_1: 2, and 4 only if δ_4 = −30°; y_2: 4, and 2 only if δ_2 = 210°, 1 only if δ_1 = 30°; y_3: 1, and 4
    only if δ_3 = 270°; y_4: 1, and 3 only if δ_2 = 150°; y_5: 3, and 1 only if δ_4 = 30°, 2 only if δ_3 = 210°); when every δ is interior to its
    range, y_0, y_1, y_3, y_4 carry {1, 2, X, X̄} and y_2, y_5 carry {3, 4, X, X̄}
  uses only: FS116-Y3-TIPS; FS116-N2-STAR; RING-GERM (ii)
  not claimed: that an outer colour the list allows occurs (the boundary values of δ are necessary for the extra outer colours, not sufficient);
    anything about the hubs' rings beyond their colours
  argument: FS116-Y3-construction.md § 2.3 The hub colours (FS116-Y3-HUBCOL)
  verdict: derived
  grade: derived from: FS116-Y3-TIPS, FS116-N2-STAR
  minds: 1
  model: none at six colours
  prior art: owed
  handoff: none — a relay-result for § 3 and the families

**True vacuously** — One mind. Rests on it: FS116-Y3-TIGHTLENS; FS116-Y3-STARFORCE.

derivation: FS116-Y3-TIGHT
  statement: in FS116-Y3-TIPS's labelling, the ring tile clockwise of y_0 does not have q_5 = √3 e(330°) in its closure, the ring tile
    counter-clockwise of y_1 not q_1, the one counter-clockwise of y_3 not q_2, the one clockwise of y_4 not q_4; at y_0 and y_1 the tip T1's cone has
    the endpoint 210°, at y_3 and y_4 the tip T2's the endpoint 30°, each along an edge inside the unit disc about the double tip's other hub
  uses only: FS116-Y3-TIPS; RING-GERM (i); that a tile with a point q in its closure lies in B̄(q, 1); |y_1 − q_5| = |y_0 − q_1| = |y_4 − q_2| = |y_3
    − q_4| = 2 with midpoints y_0, y_1, y_3, y_4
  not claimed: anything about the ring tiles over the double tips' arcs (between y_0, y_1 and between y_3, y_4); that the four ring tiles named do not
    reach beyond their hubs' discs
  argument: FS116-Y3-construction.md § 2.4 The tight sides (FS116-Y3-TIGHT)
  verdict: derived
  grade: derived from: FS116-Y3-TIPS
  minds: 1
  model: none at six colours
  prior art: owed
  handoff: none — a relay-result for § 3 and the families

**True vacuously** — One mind. Y4's look-back: it stated both flank edges and used each only against a far lens vertex (item 127). Rests on it: FS116-Y3-LENS; FS116-Y4-Q1.

derivation: FS116-Y3-NOQ
  statement: in FS116-Y3-TIPS's setting, at a hub y_k, no tile adjacent at y_k to the ring tile over the arc from y_(k−1) to y_k lies in B̄(q_k, 1),
    and no tile adjacent at y_k to the ring tile over the arc from y_k to y_(k+1) lies in B̄(q_(k−1), 1), where q_k = y_k + y_(k+1); in particular the
    clockwise-most outer tile at y_k does not have q_k in its closure, the counter-clockwise-most does not have q_(k−1), and an only outer tile has
    neither
  uses only: FS116-Y3-SIX (the ring arc between consecutive hubs lies in one tile, off finitely many points); that a tile has diameter at most 1; that
    tiles adjacent at a vertex share a non-degenerate boundary curve; |y_(k−1) − q_k| = |y_(k+1) − q_(k−1)| = 2 with midpoint y_k; the cyclic order of
    the tiles at a hub (RING-GERM's cones, and that an outer tile has points outside B̄(p, 1))
  not claimed: anything at change points of rings carrying arcs of Γ (there a ring tile need not reach the next change point); anything about outer
    tiles adjacent to neither ring tile
  argument: FS116-Y3-construction.md § 3.1 Two lemmas at a hub
  verdict: derived
  grade: derived from: FS116-Y3-SIX
  minds: 1
  model: none at six colours; the lattice facts are control fs116-y3-lens
  prior art: owed
  handoff: de Bruijn — with SIX and TIPS; a relay-result for any exclusion of the Γ-free type

**True vacuously** — One mind. Rests on it: FS116-Y3-LENS; FS116-Y3-TIGHTLENS; FS116-Y3-STARFORCE; FS116-Y4-SPOKE; FS116-Y4-Q1.

derivation: FS116-Y3-LENS
  statement: in FS116-Y3-TIPS's labelling, for k in {1, 2, 4, 5} and every point x close enough to q_k inside B(y_k, 1) ∩ B(y_(k+1), 1), every colour
    at x is a colour of p other than the tip colours of y_k and y_(k+1); and if it is a colour of y_k (of y_(k+1)), that hub's tile of that colour has
    q_k in its closure
  uses only: FS116-Y3-TIPS; FS116-Y3-TIGHT's argument (the ring tile R_(k,k+1) does not lie in B̄(q_k, 1)); FS116-Y3-NOQ's first clause for the ring
    tile over the arc before y_k; the straddle principle; non-Siamese (a c-coloured point within 1 of a hub's c-tile belongs to it); |q_k| = √3, |q_k
    − e(60k + 30°)| = √3 − 1, |q_k − y_(k−1)| = 2
  not claimed: anything at q_0 or q_3 (beside the double tips, where the ring tile may reach the far vertex); anything at points of the lens away from
    q_k
  argument: FS116-Y3-construction.md § 3.1 Two lemmas at a hub
  verdict: derived
  grade: derived from: FS116-Y3-TIPS, FS116-Y3-TIGHT, FS116-Y3-NOQ
  minds: 1
  model: none at six colours
  prior art: owed
  handoff: none — a relay-result for TIGHTLENS

**True vacuously** — One mind. Rests on it: FS116-Y3-TIGHTLENS; FS116-Y3-STARFORCE.

derivation: FS116-Y3-TIGHTLENS
  statement: in a non-Siamese simple valid six-coloured fragment on a closed disc of radius at least √3 about a vertex p of at least four colours
    whose ring carries no arc of Γ, labelled as FS116-Y3-TIPS, the edges of p satisfy (Q1) δ_4 = −30° or δ_1 = 30° or δ_2 = 210°; (Q2) δ_3 = 270° or
    δ_1 = 30° or δ_2 = 210°; (Q4) δ_2 = 150° or δ_4 = 30° or δ_3 = 210°; (Q5) δ_1 = 90° or δ_4 = 30° or δ_3 = 210° — for each lens beside a single
    tip, the tip of one of its two hubs is tight at p for that hub; so at least two edges of p lie along flanking directions of hubs, and no such
    fragment has a generic star
  uses only: FS116-Y3-LENS; FS116-Y3-NOQ; FS116-Y3-HUBCOL's list of candidate outer colours; that the domain of a fragment on B̄(p, R), R ≥ √3,
    contains a neighbourhood of each q_k
  not claimed: that any star satisfying (Q1)–(Q5) occurs; anything below radius √3 (a generic star there is neither excluded nor built); anything in
    the Siamese or non-simple class; anything at k ≥ 7 (a third absent colour survives near q_k)
  argument: FS116-Y3-construction.md § 3.2 The tight-lens conditions, and the generic star (FS116-Y3-TIGHTLENS)
  verdict: derived
  grade: derived from: FS116-Y3-LENS, FS116-Y3-NOQ, FS116-Y3-HUBCOL
  minds: 2 — blind to: Y3's record until 320a3b53; method: FS116-V5-LENS (the lens corner at the far vertex) against Y3's NOQ and TIGHT straddles; the
    same model (Opus 5.5), one prior
  model: none at six colours (it is an obstruction); the truth table of its four conditions is control fs116-y3-lens
  prior art: owed — a search in the words of the literature's six-coloured discs (Gibbs's disk, Sirgedas's searcher, de Grey's 2018 threads) is the
    debt
  handoff: de Bruijn — with NOQ, LENS, TIPS and SIX, after a blind second mind; the generic star's exclusion at √3 is a relay-result for D2's case
    list

**True vacuously** — Frozen at § 12. TRUE; a thin truth: each of (Q1)–(Q5) holds by its first disjunct alone, so the statement is weaker than its hypotheses give (both minds; item 120); **held** (item 118). Rests on it: FS116-Y3-STARFORCE.

derivation: FS116-Y3-NBTIP
  statement: in FS116-Y3-TIPS's setting, the tip of each hub meets the open unit disc about each of the two neighbouring hubs; so no hub has a
    neighbour's tip colour as an outer colour, and the only outer colour of y_2 is 4 and of y_5 is 3
  uses only: RING-GERM (i) and FS116-Y3-TIPS (one tip per hub, whose cone holds the open 60° cone about the direction to p); FS116-N2-STAR (an outer
    colour's tile at p misses B(y, 1)); RING-GERM (ii) (an outer colour exists); that the direction from y_j to a neighbour is at 60° from the
    direction to p
  not claimed: anything about outer tiles of other colours; anything outside the Γ-free class (there consecutive change points need not be 60° apart)
  converse: one-way — "the only outer colour of y_2 is 4" names the outer colours of two hubs; it characterizes nothing
  argument: FS116-Y3-construction.md § 4.1 A neighbour's tip enters the hub's disc (FS116-Y3-NBTIP)
  verdict: derived
  grade: derived from: FS116-Y3-TIPS, FS116-N2-STAR
  minds: 1 — and a checking reading by FS116-V5 (blind to Y3's record until 320a3b53, but its route and conclusion were N7-HUB's outline in the list's
    § 8)
  model: none at six colours; the angle fact is control fs116-y3-nbtip
  prior art: owed
  handoff: none — a relay-result for STARFORCE

**True vacuously** — Frozen at § 12. TRUE; one mind and a checking reading (item 118); its blind second mind is owed. Rests on it: FS116-Y3-STARFORCE; FS116-Y4-SPOKE.

derivation: FS116-Y3-STARFORCE
  statement: in a non-Siamese simple valid six-coloured fragment on a closed disc of radius at least √3 about a vertex p of at least four colours
    whose ring carries no arc of Γ, labelled as FS116-Y3-TIPS, the edges of p are δ_1 = 90°, δ_2 = 150°, δ_3 = 270°, δ_4 = −30° (FS116-N2-HEX3's
    star); 3 is an outer colour of y_0 and of y_4, and 4 of y_1 and of y_3; each of these four hubs has that outer colour alone or two outer tiles,
    counter-clockwise 2, 3 at y_0; 4, 2 at y_1; 1, 4 at y_3; 3, 1 at y_4; and near q_1, q_5 the lens points carry colour 2, near q_2, q_4 colour 1
  uses only: FS116-Y3-TIGHTLENS's argument (FS116-Y3-LENS with FS116-Y3-NOQ at the four lenses beside the single tips); FS116-Y3-NBTIP;
    FS116-Y3-HUBCOL's cone conditions for the outer colours of the double-tip hubs
  not claimed: that any such fragment exists, at any radius; anything below radius √3; anything in the Siamese or non-simple class; anything at k ≥ 7
  argument: FS116-Y3-construction.md § 4.2 The star (FS116-Y3-STARFORCE)
  verdict: derived
  grade: derived from: FS116-Y3-TIGHTLENS, FS116-Y3-NBTIP, FS116-Y3-HUBCOL
  minds: 2 — blind to: Y3's record until 320a3b53; method: FS116-V5-LENS with its images under the reflection at 30° and the half-turn, against Y3 §
    3.2 rerun with NBTIP; the same model (Opus 5.5), one prior
  model: none at six colours; the truth table is control fs116-y3-star
  prior art: partly: FS116-N2-HEX3 (one mind) derives this star from two alternate hubs recurring; its forcing by radius √3 not found — owed
  handoff: de Bruijn — with NOQ, LENS, NBTIP, TIPS and SIX, after a blind second mind; a relay-result for D2: the Γ-free type's case list is one star

**True vacuously** — Frozen at § 12. TRUE under the two readings both minds used (item 120), written here: **"near q_k the lens points carry colour c"** — every point of the lens `L_k` close enough to its far vertex `q_k` lies in a tile of colour `c` or on Γ (V5's R-LENSPT); **"counter-clockwise 2, 3 at y_0"** — turning counter-clockwise about `y_0` through its outer tiles, from the ring tile on the clockwise side of `y_0` toward the one on the counter-clockwise side, the tile of colour 2 comes first and of colour 3 second (V5's R-ORDER); under the reverse order the order clause is FALSE at all four hubs. **Held** (item 118). Rests on it: FS116-Y4-SPOKE; FS116-Y4-Q1.

control: fs116-y3-star
  of: FS116-Y3-STARFORCE — with the neighbour-tip rule, one assignment of the four edges survives the lens rule; without it, 26
  run: python3 ../tools/fs116_y3_hex.py star | head -n 1
  expect: satisfying assignments: 1
  fault: python3 ../tools/fs116_y3_hex.py star --plant nbtip | head -n 1

derivation: FS116-V5-NE1
  statement: in a valid k-coloured fragment, for any k, Siamese pairs allowed, if a point x lies in the closure of a tile of colour c, then no point z
    interior to a tile of colour c has |z − x| = 1; in particular every tile T lies in B(x, 1) for every x in cl T, so cl T lies in B̄(x, 1) and T has
    diameter at most 1
  uses only: tiles open and connected; validity (no two interior points of one colour at distance exactly 1)
  not claimed: that T lies in the open disc B(x, 1) when x is a closure point of another tile of T's colour (only that z ∉ ω(x)); anything about
    points of Γ
  argument: FS116-V5-verification.md § V5-NE1's argument
  verdict: derived
  grade: hand
  minds: 1
  model: any tile of the hexagonal seven-colouring (k = 7), cells of diameter below 1
  prior art: known — N-E1 of `plans/FS112-N-proof.md` § 1.3 ("ω(u) meets no tile of a colour of P_cl(u)"), re-derived here
  handoff: none — a relay-result for the stages that follow

V5's lemma, one mind; known (N-E1). Rests on it: FS116-V5-RING; FS116-V5-GERM; FS116-V5-TIPSET; FS116-V5-LENS; FS116-V5-QCOL; FS116-V5-DICHO; FS116-V5's second derivations of FS116-Y3-SIX, -TIPS, -NBTIP, -TIGHTLENS and -STARFORCE.

derivation: FS116-V5-RING
  statement: at a point p of a valid six-coloured fragment on a closed disc of radius above 1 about p, non-Siamese, with at least four colours at p
    and Γ ∩ ω(p) containing no arc: Γ ∩ ω(p) is finite; every point of ω(p) off Γ is interior to a tile of one of the colours absent at p; p has
    exactly four colours, so exactly two are absent, X and X̄; the ring colour c satisfies c(θ + 60°) ≠ c(θ) off Γ; every tile T meeting ω(p) at r(θ₀)
    meets it only inside the open arc (θ₀ − 60°, θ₀ + 60°); two ring points off Γ of one colour less than 60° apart lie in one tile; and the change
    points are exactly y + 60°ℤ for one ring point y
  uses only: V5-NE1; the non-Siamese hypothesis (for "one tile"); six colours (for "exactly two absent"); a locally finite union of segments and
    circular arcs not containing an arc of ω(p) meets ω(p) in finitely many points
  not claimed: anything with Siamese pairs (the step "one tile" fails there); anything at k ≥ 7; that the ring tile over an arc between consecutive
    change points touches no other ring point
  argument: FS116-V5-verification.md § V5-RING's argument
  verdict: derived
  grade: hand
  minds: 1
  model: none held — no fragment of the class is known, and the class may be empty (the list's preamble: a statement about a possible object)
  prior art: partly: FS114-N6-NOQ's N6-RING60 (`plans/FS114-derivation.md` § 3, "a four-colour vertex whose ring carries no (Q) arc has ring change
    points exactly y + 60°ℤ"), stated there, not read here as an argument
  handoff: none — a relay-result for SIX and everything after it

V5's lemma, one mind. Not vacuous by EMPTY (its setting drops "simple"). Rests on it: FS116-V5-GERM; FS116-V5-LENS; FS116-V5's second derivations of FS116-Y3-SIX, -TIPS, -NBTIP, -TIGHTLENS and -STARFORCE.

derivation: FS116-V5-GERM
  statement: in V5-RING's setting, let y = r(ψ) be a change point, X₊ the ring colour just counter-clockwise of y and X₋ the one just clockwise; for β
    − ψ in each open interval below, every point y + t e(β′) with t > 0 small and β′ near β that is off Γ lies in a tile of the colours named: (−30°,
    30°) a colour of p, on a tile that is not a tile of p (an outer tile); (30°, 90°) X₊ or an outer tile; (90°, 150°) X₊ or a tile of p; (150°, 210°)
    a tile of p; (210°, 270°) X₋ or a tile of p; (270°, 330°) X₋ or an outer tile; at y there is exactly one tile of colour X₊, the ring tile R₊ over
    the ring arc counter-clockwise of y, and one of X₋, R₋; so y is a vertex whose tiles, counter-clockwise, are outer tiles (covering ψ + (−30°,
    30°)), R₊ (containing ψ + 90°), tiles of p (covering ψ + (150°, 210°)), R₋ (containing ψ + 270°), no tile colour being both a tip colour and an
    outer colour
  uses only: V5-RING, V5-NE1, non-Siamese; the first-order motion of the two points of ω(z) ∩ ω(p) (control `germ-first-order`)
  not claimed: anything at the six boundary directions ψ + 30°k (second order decides there); anything when a germ lies on Γ
  argument: FS116-V5-verification.md § V5-GERM's argument
  verdict: derived
  grade: hand
  minds: 1
  model: none held — V5-RING's class is not known to be non-empty
  prior art: partly: RING-GERM (i)–(iii) (data/fs116/claims.md § 10) states the tip and outer cones; re-derived here with the four other intervals
  handoff: none — a relay-result for TIPS onward

V5's lemma, one mind; not vacuous by EMPTY. Rests on it: FS116-V5-LENS; FS116-V5's second derivations of FS116-Y3-SIX, -TIPS, -NBTIP, -TIGHTLENS and -STARFORCE.

derivation: FS116-V5-OUT
  statement: in V5-RING's setting, let y = r(ψ) be a ring point and O a tile of colour c ∈ P, not a tile of p, with points y + s e(γ) for arbitrarily
    small s > 0 along a direction γ with cos(γ − ψ) > 0; then the cone at p of p's tile of colour c lies in the closed half-plane of directions [ψ +
    90°, ψ + 270°]
  uses only: validity; tiles open and connected; the expansion |e(ψ) + s e(γ) − s′ e(δ)|² = 1 + 2s cos(γ − ψ) − 2s′ cos(δ − ψ) + O(s² + s′²) (control
    `out-expansion`)
  not claimed: anything about the boundary directions ψ ± 90° of that cone (second order); anything when cos(γ − ψ) ≤ 0
  argument: FS116-V5-verification.md § V5-OUT's argument
  verdict: derived
  grade: hand
  minds: 1
  model: none held — V5-RING's class is not known to be non-empty
  prior art: partly: FS114-N7-QOPP's N7-FLANK (data/fs116/claims.md § 8 and plans/FS114-derivation.md § 3: "A tile of p with cone [a, b] puts its
    colour at no ring point in (a ∓ 90°, b ∓ 90°)") is the same shadow read at the ring
  handoff: none — a relay-result for NBTIP, TIGHTLENS and STARFORCE

V5's lemma, one mind. Rests on it: FS116-V5-LENS; FS116-V5's second derivations of FS116-Y3-SIX, -TIPS, -NBTIP, -TIGHTLENS and -STARFORCE.

derivation: FS116-V5-TIPSET
  statement: in V5-RING's setting with the change points at y_k = e(60°k), let a tile T of p be a tip at y_k (y_k ∈ cl T); then cl T lies in B̄(y_k,
    1) ∩ B̄(p, 1), its cone at p lies in [60°k − 90°, 60°k + 90°] and its cone at y_k in [60°k + 90°, 60°k + 270°]; T is a tip at no hub other than
    y_{k±1}, and at y_k and y_{k+1} only if its cone at p lies in [60°k − 30°, 60°k + 90°]; a tip at y_k and a tip at y_{k+3} have closures meeting
    only at p
  uses only: V5-NE1; |y_k − y_{k+2}| = √3, |y_k − y_{k+3}| = 2 (control `hub-distances`)
  not claimed: that every hub has a tip (that is V5-GERM's (150°, 210°) clause); anything about tiles of p tipping no hub
  argument: FS116-V5-verification.md § V5-TIPSET's argument
  verdict: derived
  grade: hand
  minds: 1
  model: none held — V5-RING's class is not known to be non-empty
  prior art: partly: FS114-N3-LOCAL's N3-FACE ("one tile at both lies in B̄(u,1) ∩ B̄(w,1)", plans/FS114-derivation.md § 3), the same step
  handoff: none — a relay-result for TIPS

V5's lemma, one mind; not vacuous by EMPTY. Rests on it: FS116-V5-LENS; FS116-V5's second derivations of FS116-Y3-SIX, -TIPS, -NBTIP, -TIGHTLENS and -STARFORCE.

derivation: FS116-V5-LENS
  statement: in a non-Siamese simple valid six-coloured fragment on a closed disc of radius at least √3 about a vertex p of at least four colours
    whose ring carries no arc of Γ, labelled as FS116-Y3-TIPS, at the lens L_1 (hubs y_1, y_2, far vertex q_1 = √3 e(90°)): (a) every interior point
    of L_1 off Γ has colour X̄, 2 or 4; (b) no tile of colour X̄ has q_1 in its closure, and no tile of colour 4 with points in L_1 does; (c) every
    point of L_1 near q_1 lies in one tile Z of colour 2 or on Γ; (d) y_1 carries an outer tile of colour 4, its outer colours are 4 alone or 4 and 2,
    and in the second case the 2-tile is Z and comes after the 4-tile counter-clockwise from the ring tile R_{0,1}; (e) δ_4 = −30°; and, by the
    reflection in the line at 30° and the half-turn, the same at L_5 (δ_1 = 90°, Z of colour 2 at q_5, y_0's outer colours 3 alone or 2 then 3), at
    L_4 (δ_2 = 150°, colour 1 at q_4, y_4's outer colours 3 alone or 3 then 1) and at L_2 (δ_3 = 270°, colour 1 at q_2, y_3's outer colours 4 alone or
    1 then 4)
  uses only: V5-NE1, V5-RING, V5-GERM, V5-OUT, V5-TIPSET, FS116-Y3-TIPS and -NBTIP as derived here (§§ 2.3–2.4); radius √3 (only to have a
    neighbourhood of q_k); the exact facts of controls `hub-distances` and `astar-arc`
  not claimed: that any fragment of the class exists; anything below radius √3; anything in the Siamese or non-simple class; anything at k ≥ 7
  argument: FS116-V5-verification.md § V5-LENS's argument
  verdict: derived
  grade: hand
  minds: 1
  model: none held — the class is not known to be non-empty, at any radius (FS116-Y3-STARFORCE's own not-claimed line)
  prior art: owed — no search run; the statement is in the vocabulary of this project's records only
  handoff: Keryx — V5-LENS proves more than FS116-Y3-TIGHTLENS states (each lens forces its first disjunct); the divergence table at stage 4 compares
    routes

**True vacuously** — V5's lemma, one mind: at radius √3 each lens beside a single tip forces its double-tip hub's tip tight at `p`, giving HEX3's star directly. Rests on it: nothing in this file; FS116-V5's second derivations of FS116-Y3-SIX, -TIPS, -NBTIP, -TIGHTLENS and -STARFORCE.

## Round 4 — the semi-hub rule (FS116-N3; FS116-V5 blind on three)

derivation: FS116-N3-CONE
  statement: in a non-Siamese simple valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, at a change point y
    = r(ψ) of the ring: u⁻ off (Q) arcs gives R ⊂ B̄(r(ψ + 60°), 1); v⁻ off them gives R ∩ B(r(ψ − 60°), 1) = ∅; v⁺ off them gives R′ ⊂ B̄(r(ψ − 60°),
    1); u⁺ off them gives R′ ∩ B(r(ψ + 60°), 1) = ∅; a germ on a (Q) arc bars both colours of that arc from an open half-circle of directions at y —
    (ψ + 30°, ψ + 210°) for u⁺, (ψ + 150°, ψ + 330°) for v⁻, (ψ − 150°, ψ + 30°) for u⁻, (ψ − 30°, ψ + 150°) for v⁺; and an edge at y between a tile
    inside B̄(w, 1) and a tile outside B(w, 1) is an arc of ω(w), whose centre w, if it carries both side colours, is a vertex of at least four
    colours
  uses only: RING-GERM's Steps 1 and 2 (two minds); FS116-N1-GERM-R (one mind); FS112-N3-NOBOTH with FS112-U1 (two minds each), local at the centre;
    non-Siamese (distinct tiles of one colour at distance at least 1; no repeated colour at a point); that a tile has diameter at most 1
  not claimed: anything about a germ on a non-(Q) arc of Γ beyond RING-GERM's Step 1; the Siamese or non-simple class; anything at k ≥ 7
  argument: FS116-N3-proof.md § 2.1 The cone lemmas at the unit rhombus `p, u, y, v` (FS116-N3-CONE)
  verdict: derived
  grade: hand
  minds: 1
  model: the strip's P₀ at its change point P₂: R = U₁ holds u = V₁ (u⁻ off), R′ = D₁ holds v = V′₁ (v⁺ off), and B (inner of the arc at v⁻) is held
    at P₂ only by U₂, along [0°, 90°] ⊂ [ψ − 30°, ψ + 150°] — `data/fs116/n3/semi.out`
  prior art: partly: RING-GERM, FS116-N1-GERM-R and FS112-U1 hold each clause; FS114-N7-OCTB uses the edge clause at the bowtie's top ("the edge R_0 |
    W at top is an arc of ω(q1)"); their assembly at the rhombus not found — FS-116's gate (`plans/FS116-local-exclusion.md` § 2.3, 12 queries)
  handoff: de Bruijn — with RING-GERM and NOBOTH, queued behind D6's map type: the six half-planes at y and the edge clause

One mind (item 95: its statement was written during the derivation, and is not frozen). Rests on it: FS116-N3-SEMI; FS116-N3-CROSS; FS116-RING-TRANSFER-QC.

derivation: FS116-N3-PAIR
  statement: in a non-Siamese simple valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, if both germs of one
    pair at a change point of the ring lie on (Q) arcs and the two arcs have the same pair of colours, then the inner colour of each is the outer
    colour of the other
  uses only: that the inner tile of a (Q) arc is the tile of p of its colour and holds the arc; that a germ's arc holds the germ's ring point (u or v)
    in its closure; |u − v| = √3; non-Siamese; diameter at most 1
  not claimed: anything about two (Q) arcs that are not at the germs of one pair; that a full parallel semi-hub occurs at six colours beyond
    FS114-Y2-BOWTIE
  argument: FS116-N3-proof.md § 2.2 The argument of FS116-N3-PAIR
  verdict: derived
  grade: hand
  minds: 2 — blind to: N3's record until 3647075d; method: the same route; the same model (Opus 5.5), one prior
  model: FS114-Y2-BOWTIE's centre at top and at bot: the arcs at u⁺ and v⁻ are 3 | 1 and 1 | 3 (control fs116-n3-pair)
  prior art: partly: FS114-N7-QOPP's inner-tile clause; this pairing not found — FS-116's gate (12 queries)
  handoff: de Bruijn — with FS114-N7-QOPP, queued behind D6's map type

Frozen at § 13. TRUE; "simple" idle (a thin truth); **held** (item 118). Rests on it: FS116-N3-STAR2; FS116-N3-SEMI; FS116-RING-TRANSFER-QC.

derivation: FS116-N3-STAR2
  statement: in a non-Siamese simple valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, let y = r(ψ) be a
    full semi-hub of kind O with (Q) arcs A = [ψ + 60°, ψ + 60° + ℓ] of inner colour a and outer a′ and B = [ψ − 60° − m, ψ − 60°]; if B's colours b
    (inner) and b′ (outer) are disjoint from a, a′, then ℓ + m ≤ 60° and the tiles of p are, counter-clockwise, t_b, t_a, t_b′, t_a′ with edges
    t_b|t_a in [ψ + ℓ − 30°, ψ + 30° − m], t_a|t_b′ in [ψ + 30°, ψ + 150°], t_b′|t_a′ in [ψ + 150° + ℓ, ψ + 210° − m] and t_a′|t_b in [ψ + 210°, ψ +
    330°]; if B's colours are a′ (inner) and a (outer), then t_a ⊂ [ψ + 30°, ψ + 150°], t_a′ ⊂ [ψ + 210°, ψ + 330°], and the other two tiles' cones
    contain [ψ − 30°, ψ + 30°] and [ψ + 150°, ψ + 210°]
  uses only: FS114-N7-QOPP's windows (one mind; re-derived in the stage's preamble from N-E1 and non-Siamese at the unit pairs (p, r(θ)));
    FS116-N3-PAIR; that p has four tiles in cyclic order (non-Siamese, simple, four colours); that A starts at u and B ends at v (u⁻, v⁺ off (Q)
    arcs); 0 < ℓ, m ≤ 60°
  not claimed: the windows of a crossed semi-hub of kind T (computed in § 2.3's spirit but not entered); that any star in the windows is realised
  argument: FS116-N3-proof.md § 2.3 The pinned stars of a full semi-hub (FS116-N3-STAR2)
  verdict: derived
  grade: derived from: FS116-N3-PAIR
  minds: 1
  model: the strip's P₀ (crossed: edges at 0°, 90°, 180°, 270°, ℓ = m = 15.52°) and FS114-Y2-BOWTIE's centre (parallel: t3 = [120°, 240°], t1 = [300°,
    60°] at ψ = 90°, the windows met with equality) — control fs116-n3-semi
  prior art: partly: FS114-N7-QOPP and N7-FLANK's windows; the two stars not found — FS-116's gate (12 queries)
  handoff: de Bruijn — with FS114-N7-QOPP

One mind (item 95). Rests on it: FS116-N3-SEMI; FS116-N3-CROSS; FS116-RING-TRANSFER-QC.

derivation: FS116-N3-SEMI
  statement: in a non-Siamese simple valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, let y = r(ψ) be a
    semi-hub of the ring of p; then y is a vertex of at least four colours, or y is a vertex of exactly three colours one of whose edges at y is an
    arc of the unit circle about r(ψ + 60°) or about r(ψ − 60°) whose two side colours are both carried at that centre, which is then a vertex of at
    least four colours, or y is a full parallel semi-hub of exactly three colours — the two absent at p and the colour of the tile of p whose cone
    holds ψ + 180° (kind O) or ψ (kind T) in its interior
  uses only: FS116-N3-CONE; FS116-N3-STAR2 and its kind-T parallel line (§ 2.3); FS116-N3-PAIR; RING-GERM (i), (ii) (two minds); FS116-N2-STAR's
    windows (one mind); non-Siamese and simple (three colours give three tiles, consecutive tiles share an edge); six colours, at RING-GERM's Step 1
    and in C(y) = A(p) ⊔ T_y ⊔ O_y
  not claimed: that a semi-hub has four colours; that the third alternative occurs, or that it is excluded; anything at a closed change point (the
    disk's corner, FS116-N1-QDISK); Siamese or non-simple fragments; anything at k ≥ 7
  argument: FS116-N3-proof.md § 2.4 The argument of FS116-N3-SEMI
  verdict: derived
  grade: derived from: FS116-N3-CONE, FS116-N3-STAR2, FS116-N3-PAIR
  minds: 2 — blind to: N3's record until V5's verdicts (3647075d); method: FS116-V5-U1 for the centre's four colours and FS116-V5-DICHO for
    crossed-or-parallel, against FS112-N3-NOBOTH and FS114-N7-QOPP (V5 § 4.1); the same model (Opus 5.5), one prior
  model: the strip's P₀ at P₂ and P₋₂ and P₁ at its two change points (crossed full semi-hubs of kind O, four colours) and FS114-Y2-BOWTIE's centre at
    top and bot (parallel full semi-hubs of kind O, four colours) — the first alternative, `data/fs116/n3/semi.out`; no held fragment has a
    three-colour semi-hub
  prior art: partly: the alternatives' ingredients are FS-112's (NOBOTH) and FS-116's (RING-GERM); a placing rule at change points with a germ pair on
    (Q) arcs not found — FS-116's gate (12 queries); a search in the map-colouring vocabulary is owed
  handoff: de Bruijn — with RING-GERM, NOBOTH and STAR, after a blind second mind; a relay-result for D2 (every semi-hub but the parallel three-colour
    one places a vertex of at least four colours on ω(p))

Frozen at § 13. TRUE; **held** (item 118). Its crossed-or-parallel dichotomy, given in § 13's notation through FS114-N7-QOPP (one mind, degree 4), was checked by V5 for every degree (FS116-V5-DICHO). Rests on it: FS116-RING-TRANSFER-QC.

control: fs116-n3-semi
  of: FS116-N3-SEMI — with FS116-N3-STAR2 and FS116-N3-CROSS, on the held change points (the strip's P₀, P₁; the bowtie's centre; the disk's corner, closed and silent); every (Q)
    arc read with inner and outer swapped is caught
  run: python3 ../tools/fs116_n3_semi.py | tail -n 1
  expect: SEMI ALL OK
  fault: python3 ../tools/fs116_n3_semi.py --plant | tail -n 1

derivation: FS116-N3-CROSS
  statement: in a non-Siamese simple valid fragment on a closed disc of radius above 2 about a vertex p of at least four colours, let y = r(ψ) be a
    crossed full semi-hub of kind O of the ring of p, u⁺ on a (Q) arc of inner colour a and outer colour a′ and v⁻ on one of inner colour b and outer
    colour b′; then every tile of p at y has a cone at y of zero angle, and the outer colours at y lie in {a′, b′}; if y has four colours and every
    tile at y a cone of positive angle at y, its outer colours are a′ and b′ and its missing pair is {a, b}, and, unless an edge of p runs along ω(y)
    at p, p is a change point of the ring of y, that ring being b just counter-clockwise of p and a just clockwise, and p is a semi-hub of kind O of
    the ring of y
  uses only: FS116-N3-STAR2 (crossed); FS116-N3-CONE (b), (d); RING-GERM (i) at y (two minds); FS114-N7-QOPP at y (one mind); N-E1; non-Siamese and
    simple
  not claimed: that y has four colours; that p is a crossed semi-hub of y's ring; anything about y's ring away from p; anything at k ≥ 7
  argument: FS116-N3-proof.md § 3.1 The argument of FS116-N3-CROSS
  verdict: derived
  grade: derived from: FS116-N3-STAR2, FS116-N3-CONE
  minds: 2 — on every clause but the last; blind to: N3's record until 3647075d; method: FS116-V5-U1's cones at p (V5 § 3.4); the same model (Opus
    5.5), one prior; the last clause 1 and a checking reading (V5's blind verdict was GAP there, its stall closed after reading by N3's step through
    FS114-N7-QOPP at y, re-derived by V5-U1)
  model: the strip's P₀ at P₂ (a = P, a′ = O, b = M, b′ = B; O_y = {B, O}, A(y) = {M, P}; P₂'s ring is M just counter-clockwise of P₀ and P just
    clockwise, and P₀ is a crossed full semi-hub of kind O of it) and P₁ at P₃ — control fs116-n3-semi
  prior art: partly: FS116-N2-RECIP is its hub form (through FS116-N1-TOUCH); at a semi-hub not found — FS-116's gate (12 queries)
  handoff: de Bruijn — with STAR2 and RING-GERM

Frozen at § 13. TRUE; **held on every clause but the last** (item 118); the last clause one mind and a checking reading, its blind second mind owed. A thin truth: the first clause holds vacuously (no tile of `p` has `y` in its closure, FS116-V5-CROSS-S), and the hypotheses "every tile at y a cone of positive angle" and "radius above 2" are unused in every clause V5 derived (item 120). Rests on it: FS116-RING-TRANSFER-QC.

derivation: FS116-RING-TRANSFER-QC
  statement: in a non-Siamese simple valid fragment on a closed disc of radius above 2 about a vertex p of four colours: at a semi-hub y = r(ψ) of p's
    ring a vertex of at least four colours lies at y, at r(ψ + 60°) or at r(ψ − 60°), unless y is a full parallel semi-hub of three colours, which are
    then the two absent at p and the colour of the tile of p holding ψ + 180° (kind O) or ψ (kind T) in its cone's interior; when the (Q) arcs at a
    semi-hub's other pair join the same two opposite tiles of p their inner colours are swapped; at a full semi-hub of kind O the four edges of p lie
    in FS116-N3-STAR2's windows; and at a crossed full semi-hub of kind O whose (Q) arcs have inner colours a, b and outer a′, b′, every tip has a
    cone of zero angle and the outer colours lie in {a′, b′}, and if y has four colours with cones of positive angle its missing pair is {a, b} and p
    — unless an edge of p runs along ω(y) — is a change point of y's ring, b counter-clockwise and a clockwise of it, and a semi-hub of kind O of that
    ring
  uses only: FS116-N3-CONE, FS116-N3-PAIR, FS116-N3-STAR2, FS116-N3-SEMI, FS116-N3-CROSS, and through them RING-GERM and FS112-N3-NOBOTH (two minds
    each), FS116-N1-GERM-R, FS116-N2-STAR and FS114-N7-QOPP (one mind each)
  not claimed: anything at a closed change point; that the parallel three-colour semi-hub is excluded or occurs (SEMI-PAR3, GAP); that p is a crossed
    semi-hub of y's ring; anything about y's ring outside B̄(p, 1); that the rule is the same at k = 7 (RING-GERM's Step 1 and C(y) = A(p) ⊔ T_y ⊔ O_y
    spend six)
  argument: FS116-N3-proof.md § 3.3 The verdict on RING-TRANSFER-Q
  verdict: derived
  grade: derived from: FS116-N3-SEMI, FS116-N3-CROSS, FS116-N3-PAIR, FS116-N3-STAR2
  minds: 1
  model: the strip's P₀ and P₁ (four crossed full semi-hubs of kind O, four colours, missing pairs the inner colours, each reciprocated as a crossed
    semi-hub of kind O) and FS114-Y2-BOWTIE's centre (two parallel ones, four colours) — control fs116-n3-semi
  prior art: partly: FS116-N2's RING-TRANSFER-C at hubs; at semi-hubs not found — FS-116's gate (12 queries); a search in the map-colouring vocabulary
    is owed
  handoff: de Bruijn — deferred with D6's map type, after a blind second mind on SEMI, PAIR, STAR2 and CROSS

One mind; the semi-hub rule in round 3's corrected form (input: `p`'s ring with its (Q) arcs' colours and `p`'s star). Rests on it: nothing in this file; FS116-C114-LOCAL-F's (Q)-ring case.

derivation: FS116-V5-QCOL
  statement: in this setting p has exactly four colours and X, X̄ are the two absent; a germ that lies on no (Q) arc "carries" an absent colour — the
    ring colour there if the germ is off Γ, else an absent side colour of the arc of Γ on ω(p) it lies on — namely X at u⁻ and v⁻ and X̄ at u⁺ and v⁺,
    and the hub's partner point (u or v) lies in the closure of a tile of that colour; a germ on a (Q) arc lies on an arc of ω(p) whose inner tile is
    p's tile of the inner colour and whose outer tile is not a tile of p; the two germs of one pair never lie on one (Q) arc, and a (Q) arc holding u⁺
    (v⁻) and not u⁻ (v⁺) ends at u (v)
  uses only: V5-NE1; non-Siamese; reading L at y; a circular arc of Γ containing a sub-arc of ω(p) lies on ω(p)
  not claimed: that a germ off (Q) lies off Γ; anything at k ≥ 7
  argument: FS116-V5-verification.md § V5-QCOL's argument
  verdict: derived
  grade: hand
  minds: 1
  model: none held — no fragment of the class is known
  prior art: partly: RING-GERM's first clause (data/fs116/claims.md § 10) and FS116-N1-GERM-R's exclusions (§ 11)
  handoff: none — a relay-result for SEMI, PAIR, CROSS

V5's lemma, one mind. Rests on it: FS116-V5-DICHO; FS116-V5-CROSS-S; FS116-V5's second derivations of FS116-N3-SEMI, -PAIR and -CROSS.

derivation: FS116-V5-U1
  statement: let A be an arc of Γ on ω(z), of angular extent [θ₁, θ₂] about z, θ₂ − θ₁ = ℓ > 0, with inner side colour c and outer side colour c′; a
    tile of colour c with z in its closure has its cone at z in the closed cone [θ₂ − 90°, θ₁ + 90°] facing A; one of colour c′ has it in the closed
    cone [θ₂ + 90°, θ₁ + 270°] facing away; the two open side cones (θ₁ − 90°, θ₂ − 90°) and (θ₁ + 90°, θ₂ + 90°) hold neither colour; so if z carries
    both c and c′ (A is both-kind), the side cones hold two further colours and, in a non-Siamese simple fragment, z has at least four colours
  uses only: validity; first order of |z + (1 ∓ η) e(θ) − z − s e(δ)| = 1 ∓ η − s cos(δ − θ) + O(s² + η²)
  not claimed: anything when ℓ = 0; anything about tiles at z of other colours
  argument: FS116-V5-verification.md § V5-U1's argument
  verdict: derived
  grade: hand
  minds: 1
  model: the disk's corners (data/fs116/claims.md § 9's controls: four-colour vertices carrying (Q)-type unit arcs), as stated by FS114-N7-QOPP's
    model line
  prior art: known — FS112-U1 (plans/FS112-derivation.md, line 42), re-derived
  handoff: none — a relay-result

V5's lemma, one mind; known (FS112-U1). Rests on it: FS116-V5-DICHO; FS116-V5-CROSS-S; FS116-V5's second derivations of FS116-N3-SEMI, -PAIR and -CROSS.

derivation: FS116-V5-OUT2
  statement: in V5-QCOL's setting (or V5-RING's), if an outer tile of colour c has a ring point r(θ) in its closure, then p's tile of colour c has its
    cone at p in [θ + 90°, θ + 270°]
  uses only: an outer tile is open and disjoint from B(p, 1) (non-Siamese), hence lies in |w| > 1; |w − s e(δ)| = 1 has a small root s > 0 when w·e(δ)
    > 0 and |w| > 1 is close to 1
  not claimed: anything about the boundary directions of that cone
  argument: FS116-V5-verification.md § V5-OUT2's argument
  verdict: derived
  grade: hand
  minds: 1
  model: none held — no fragment of the class is known
  prior art: partly: V5-OUT (this record), which assumed a direction of the outer tile with positive cosine; this form needs none
  handoff: none — a relay-result for CROSS

V5's lemma, one mind. Rests on it: FS116-V5-CROSS-S; FS116-V5's second derivations of FS116-N3-SEMI, -PAIR and -CROSS.

derivation: FS116-V5-DICHO
  statement: in V5-QCOL's setting, if both germs of one pair at y lie on (Q) arcs A₁, A₂ with colour pairs Π₁, Π₂, then Π₁ = Π₂ (and then the inner
    colour of each is the outer colour of the other) or Π₁ ∩ Π₂ = ∅
  uses only: V5-QCOL, V5-U1 at p, V5-NE1; simple (one sector per tile at p) and the four tiles of p
  not claimed: that either case occurs
  argument: FS116-V5-verification.md § V5-DICHO's argument
  verdict: derived
  grade: hand
  minds: 1
  model: none held — no fragment of the class is known
  prior art: partly: FS114-N7-QOPP (data/fs116/claims.md § 13's note: "(Q) arc … joins opposite tiles"), stated for degree 4, not read as an argument
  handoff: none — § 13's note asks that the dichotomy be checked, not given; here it is derived for every degree

V5's lemma, one mind: the check § 13's note asked for, without FS114-N7-QOPP. Rests on it: nothing in this file; FS116-V5's second derivations of FS116-N3-SEMI, -PAIR and -CROSS.

derivation: FS116-V5-CROSS-S
  statement: in FS116-N3-CROSS's setting (y = r(ψ) a crossed full semi-hub of kind O of p's ring in a non-Siamese simple valid fragment on a closed
    disc of radius above 2 about a vertex p of at least four colours), no tile of p has y in its closure; and if y has four colours and no edge of p
    runs along ω(y) at p, then both germs of p's tip pair in y's ring lie on (Q) arcs of y's ring and at most one germ of its outer pair does, so p is
    a full semi-hub of kind O of y's ring or a closed change point of it
  uses only: FS116-V5-U1's cones at p; FS116-V5-QCOL; FS116-V5-OUT2 at y, at v and at u; N-E1; non-Siamese; that an arc of ω(y) whose side colours are
    both carried at a four-colour y is a (Q) arc
  not claimed: that p is a semi-hub of y's ring rather than a closed change point (that is FS116-N3-CROSS's last clause, closed by FS114-N7-QOPP at
    y); that y has four colours; anything at k ≥ 7
  argument: FS116-V5-verification.md § 3.4 CROSS — derivation, and where it stops
  verdict: derived
  grade: derived from: FS116-V5-U1, FS116-V5-QCOL, FS116-V5-OUT2
  minds: 1
  model: the strip's P₀ at its change point P₂ (FS116-N3-CROSS's model: P₀ is a crossed full semi-hub of kind O of P₂'s ring)
  prior art: partly: FS116-N3-CROSS (one mind on its last clause) and FS116-N2-RECIP (its hub form)
  handoff: none — strengthens CROSS's first clause (it holds vacuously) and its reciprocity to a full semi-hub; it travels with CROSS

V5's strengthening of CROSS (item 119), one mind. Rests on it: nothing in this file.

derivation: FS116-SEMI-PAR3
  statement: in a non-Siamese simple valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, no change point of
    the ring is a full parallel semi-hub of exactly three colours
  argument: FS116-N3-proof.md § 3.2 The residue: a parallel full semi-hub of three colours (SEMI-PAR3)
  verdict: gap: the step from the bowtie's four-colour parallel semi-hub to three colours — removing the tile of p toward y from y (kind O), or the
    outer tile (kind T) — is excluded by no cone at p, u, y or v; a proof must read y's own ring, which carries three absent colours and no parity

GAP (one mind); the construction side's matching target is the bowtie with its tip at `top` removed (item 96). Rests on it: nothing in this file; FS116-C114-LOCAL-F; the successor stub.

derivation: FS116-RING-TRANSFER-Q
  statement: for each ring type with a (Q) arc at a vertex of four colours, the ring types of the vertices of at least four colours it places at
    distance 1 are determined by a finite rule, and the types that recur at every vertex they place are named
  argument: FS116-N3-proof.md § 3.3 The verdict on RING-TRANSFER-Q
  verdict: gap: three places — a full parallel semi-hub of three colours (SEMI-PAR3), a closed change point (RING-Q's gap at the disk's corner), and
    whether a crossed semi-hub's placed vertex has p as a crossed semi-hub (the order of its outer tiles); the rule is derived elsewhere as
    RING-TRANSFER-QC, its input the ring with its (Q) arcs' colours and p's star, as round 3 corrected

GAP, N2's "a placing rule at semi-hubs" (FS116-N2-proof.md § 3.2) narrowed by N3 to three places. Rests on it: nothing in this file.

## Round 4 — the Γ-free type is empty (FS116-Y4; FS116-V6 blind on EMPTY)

derivation: FS116-Y4-SYM
  statement: let F be a fragment of the HEX3 class on B̄(p, R), R ≥ √3; then σ_30(F), with the colours 3 and 4 exchanged, and σ_120(F), with the
    colours 1 and 2 exchanged and X and X̄ exchanged, are fragments of the HEX3 class on B̄(p, R) with the same labels — σ_30 fixing T1 and T2 and
    exchanging T3 and T4, σ_120 exchanging T1 and T2 and fixing T3 and T4 — so every statement of this record about F at a point z holds at σ(z) with
    the colours so exchanged
  uses only: that σ_30 and σ_120 are isometries fixing p; that a bijection of the colours preserves validity, non-Siamese and simplicity; the cones,
    hubs, tips and ring colours of FS116-Y3-TIPS's labelling and the edges of HEX3's star, mapped by hand (§ 2.1) and checked as a table (control
    fs116-y4-sym)
  not claimed: that any fragment of the class is symmetric; anything about stars other than HEX3's
  argument: FS116-Y4-construction.md § 2.1 The symmetry (FS116-Y4-SYM)
  verdict: derived
  grade: hand
  minds: 1
  model: none at six colours (the class may be empty); the table is control fs116-y4-sym
  prior art: owed — no search run; the symmetry of a configuration under a colour-permuting isometry group is the standard frame of G58's equivariant
    sweeps
  handoff: none — a bookkeeping lemma for the casework of this record

**True vacuously** — One mind; a bookkeeping lemma. Rests on it: FS116-Y4-SPOKE.

derivation: FS116-Y4-SPOKE
  statement: in a fragment of the HEX3 class on a closed disc of radius above 2 about p, the outer tile O_2 of y_2 (colour 4) has 2y_2 in its closure,
    lies in B̄(y_2, 1) ∩ B̄(2y_2, 1), and contains every point of some neighbourhood of 2y_2 that lies in B(y_2, 1) and off Γ; every tile with a point
    of that neighbourhood outside B̄(y_2, 1) in its closure has colour 3, X or X̄; so near 2y_2 the circle ω(y_2) lies in Γ, with inner colour 4; and
    the same at y_5 and 2y_5 with 3 and 4 exchanged
  uses only: FS116-Y3-STARFORCE (the lens colours near q_1 and q_2; HEX3's star); FS116-Y3-NBTIP (y_2's only outer colour is 4); RING-GERM (ii) (O_2's
    cone at y_2 holds (90°, 150°)); FS116-Y3-NOQ's argument (R_12 and R_23 hold the open ring arcs); non-Siamese; diameter at most 1; |2y_2 − q_1| =
    |2y_2 − q_2| = 1, |2y_2 − e(90°)|² = |2y_2 − e(150°)|² = 5 − 2√3; FS116-Y4-SYM for y_5
  not claimed: that the outer colour at 2y_2 is 3 (X and X̄ are not excluded there when the ring tiles' cones at y_2 do not meet the outer side of the
    ring); anything below radius 2; anything at the double-tip hubs; anything at k ≥ 7 (a seventh colour survives inside ω(y_2) near 2y_2)
  argument: FS116-Y4-construction.md § 2.2 The spoke at `y_2` (FS116-Y4-SPOKE)
  verdict: derived
  grade: derived from: FS116-Y3-STARFORCE, FS116-Y3-NBTIP, FS116-RING-GERM, FS116-Y4-SYM
  minds: 1
  model: none at six colours; the plane facts at twelve points round 2y_2 are control fs116-y4-spoke
  prior art: owed
  handoff: none — a relay-result for the obstruction or the construction of this record; with STARFORCE, after its blind check, a candidate for de
    Bruijn

**True vacuously** — One mind. Rests on it: FS116-Y4-Q1.

derivation: FS116-Y4-Q1
  statement: in a fragment of the HEX3 class on a closed disc of radius above 2 about p, for every point x = q_1 + s·e(χ) of some neighbourhood of
    q_1, colours 4 and X̄ are absent at x; X is absent when χ lies in (150°, 390°); 3 is absent when χ lies in (150°, 330°); 1 is absent when χ lies
    in (210°, 390°); and the points with χ in (210°, 330°) are in Z_1 (colour 2)
  uses only: FS116-Y4-SPOKE (O_2's points inside ω(y_2) near 2y_2); FS116-Y3-STARFORCE (Z_1 at L_1 near q_1); FS116-Y3-NOQ (the ring tiles hold their
    open arcs; the cyclic order at y_1) and FS116-Y3-TIGHT's argument (|y_0 − q_1| = 2 with midpoint y_1); the tips T1 at y_1 and T3 at y_2 with their
    cones (RING-GERM (i)); straddles at first order
  not claimed: which of the remaining colours occur; that 3 is absent for χ in (−30°, 150°) (§ 3 reads when it is)
  argument: FS116-Y4-construction.md § 2.3 The colours near `q_1` (FS116-Y4-Q1)
  verdict: derived
  grade: derived from: FS116-Y4-SPOKE, FS116-Y3-STARFORCE
  minds: 1
  model: none at six colours; the plane facts at twelve points round q_1 are control fs116-y4-q1
  prior art: owed
  handoff: none — a relay-result for § 3

**True vacuously** — One mind. Rests on it: nothing in this file.

derivation: FS116-Y4-FLANK
  statement: let t be a tile of a valid fragment, Siamese pairs allowed, on a closed disc of radius above 1 about a point p, and let y = r(ψ) and y′ =
    r(ψ + 60°) be points of ω(p) in the closure of t such that the cone of t at y contains the open cone (ψ + 150°, ψ + 210°) and its cone at y′
    contains (ψ + 210°, ψ + 270°); then t's cone at y ends at ψ + 210° and its cone at y′ begins at ψ + 210°, and if a is the tile bordering t at y
    along t's edge leaving y in the direction ψ + 210°, and b the tile bordering t at y′ along t's edge leaving y′ in the direction ψ + 210°, some
    point of the closure of a and some point of the closure of b are at distance below 1
  uses only: that a tile has diameter at most 1, so t ⊂ B̄(y, 1) ∩ B̄(y′, 1); that near a vertex an edge of Γ is a segment or a circular arc (a
    second-order expansion); |y − y′| = 1 with y′ − y = e(ψ + 120°)
  not claimed: anything about the colours of a and b; that a ≠ b; that the cones contain the open cones (an input, here from RING-GERM (i))
  argument: FS116-Y4-construction.md § 3.1 The flank lemma (FS116-Y4-FLANK)
  verdict: derived
  grade: hand
  minds: 1
  model: the Reuleaux triangle Reul(p, y_0, y_1) as t, its two arcs through p as the edges: points at turning angle φ are 2cos φ − 1 apart (control
    fs116-y4-flank)
  prior art: partly: FS114-Y5-PXKILL (two tiles of one colour bordering a third along unit arcs, within √(1 − 2tt′) < 1) and G83's straddle are the
    same mechanism; this form not searched — owed
  handoff: de Bruijn — a short lemma about two arcs inside two unit discs, after a blind second mind

One mind (item 123: stated after its author had found the route); colour-free, Siamese pairs allowed. G83's straddle along two unit circles. Rests on it: FS116-Y4-EMPTY.

control: fs116-y4-flank
  of: FS116-Y4-FLANK — 12 edge pairs (radii 1 and 1/2, turning angles 1°, 10°, 30°) below 1, the ring points above 1, flank colours agreeing at 6
    of 6 positions; the tangent segments (curvature 0) never go below 1
  run: python3 ../tools/fs116_y4_lattice.py flank | tail -n 1
  expect: FLANK: 12 of 12 edge pairs below 1; EMPTY's contradiction holds
  fault: python3 ../tools/fs116_y4_lattice.py flank --plant straight | tail -n 1

derivation: FS116-Y4-EMPTY
  statement: no non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours has a ring
    carrying no arc of Γ
  uses only: FS116-Y3-SIX (six change points y_k, hubs, the ring alternating X and X̄, four tiles at p); FS116-Y3-TIPS (one tip per hub; a tile
    tipping two adjacent hubs); RING-GERM (i) and (ii) (the tip cone and the outer cone at a hub); FS116-N2-STAR (C(y) = A(p) ⊔ T ⊔ O);
    FS116-Y4-FLANK; non-Siamese
  not claimed: anything for rings carrying an arc of Γ that is not a (Q) arc (the (Q)-free rings of FS114-N6-RING60 after the bends, with (R2) arcs);
    anything in the Siamese or non-simple class; anything at k ≥ 7 (with three absent colours the flank tiles need not share a colour)
  argument: FS116-Y4-construction.md § 3.2 The class is empty (FS116-Y4-EMPTY)
  verdict: derived
  grade: derived from: FS116-Y4-FLANK, FS116-Y3-SIX, FS116-Y3-TIPS, FS116-RING-GERM
  minds: 2 — blind to: FS116-Y4's record until its verdict's commit (2429e200), though given the frozen list with round 3's construction-side
    statements and their setting (§ 14), route-shaped and unused; method: a different route at the count (FS116-V6-COUNT and -ANTI in place of
    FS116-Y3-TIPS) and at the flank step (FS116-V6-HUG's exact identity in place of FS116-Y4-FLANK's curvature bound); the same model (Opus 5.5),
    one prior
  model: none can exist (the statement is a non-existence); its geometric step is control fs116-y4-flank, whose plant three shows where six is spent
  prior art: partly: the mechanism is G83's and FS114-Y5-PXKILL's; that the Γ-free four-colour vertex dies at 1 + ε is not in FS-116's records (round
    3 and FS116-N2 worked it as possible); no outside search — owed
  handoff: de Bruijn — by either route, the first with FLANK, SIX, TIPS and RING-GERM, or FS116-V6's (FS116-V6-HUBS, -HUG, -COUNT, -ANTI, hand, using
    no statement of the frozen list), the shorter; for D2, the Γ-free ring type removed from C114-LOCAL-F's case list at 1 + ε

Frozen at § 15 with the parenthetical of its not-claimed line withheld for blindness; the line is filed whole here. **Held** (item 139): FS116-V6, blind, the same model, committed TRUE (2429e200) before it opened FS116-Y4's record, by its own route — six hubs by a
tip count (FS116-V6-HUBS), the hugging identity (FS116-V6-HUG), an incidence count forcing two antipodal doubly tipped hubs (FS116-V6-COUNT) and
antipodal tippers sharing no edge at `p` (FS116-V6-ANTI) — resting on neither FS116-Y3-SIX nor -TIPS; divergences truth 0, route 7, wording 1; no
retraction (`FS116-V6-verification.md` § 3.2). Caveats stated with it (item 139): one model; § 14's statements, about this class, were in V6's view
though unused. Six colours are spent twice on V6's route (two absent colours; the tip sector holding only colours of `p`) and once on Y4's (the
alternation). V6's wording note: "radius above 1" and "radius 1" name one class, since an open set containing `B̄(p, 1)` contains a larger closed disc
(V6 § 3.2 row 7). It removes the Γ-free ring type from C114-LOCAL-F's case list at radius `1 + ε` in the non-Siamese simple class; round 3 and FS116-N2 had worked that class as possible (a G21 instance, item 124). Rests on it: FS116-Y4-OBST; the vacuity of every entry marked True vacuously; FS116-C114-LOCAL-F's Γ-free case.

control: fs116-y4-flank-seven
  of: FS116-Y4-EMPTY — where six is spent: a ring cycling three colours (a seventh colour) makes the flank colours differ at every position
  run: python3 ../tools/fs116_y4_lattice.py flank | sed -n 14p
  expect: double-tip positions whose two flank ring arcs share a colour: 6 of 6
  fault: python3 ../tools/fs116_y4_lattice.py flank --plant three | sed -n 14p

*Erratum (2026-10-03, FS129-Z1, from `plans/FS129-SR1-audit.md` § 2.3; `plans/FS129-close-inventory.md` item 96):* the not-claimed line's "rings carrying an arc of Γ that is not a (Q) arc (the (Q)-free rings of FS114-N6-RING60 after the bends, with (R2) arcs)" are now reached in the non-Siamese simple class by FS129-OR1-QFREE (derived, one mind; `plans/FS129-derivation.md`): no non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex of at least four colours has a ring carrying no (Q) arc. FS129-SR3 (`plans/FS129-SR3-audit.md` § Stage 2 — SAVED: item (d); derived, one mind; FS129-Z2 files its entries) derives this entry and QFREE with "simple" dropped on FS116-V6's route (FS129-SR3-EMPTY-NS, FS129-SR3-QFREE-NS), which reaches the not-claimed line's non-simple class as well; FS116-Y4's own route uses simplicity.

derivation: FS116-Y4-OBST
  statement: for every R > 1, no fragment of the HEX3 class exists on the closed disc of radius R about p
  uses only: FS116-Y4-EMPTY (the HEX3 class is a subclass of its class)
  not claimed: anything outside the non-Siamese simple Γ-free class
  argument: FS116-Y4-construction.md § 3.3 What it does to the brief's target and to the held results
  verdict: derived
  grade: derived from: FS116-Y4-EMPTY
  minds: 1
  model: none can exist
  prior art: partly: as FS116-Y4-EMPTY
  handoff: none — the brief's answer; it rides on EMPTY's handoff

The brief's target answered at every radius above 1; FS116-Y4-FRAG (a fragment of the HEX3 class above radius 2) is FALSE by it. Rests on it: nothing in this file.

### FS116-V6's lemmas — the second route to FS116-Y4-EMPTY (one mind each; inventory item 140)

*Stated in V6's setting, FS116-Y4-EMPTY's class (`FS116-V6-verification.md` § 2.2, its readings R-RAD, R-SIAM, R-ARC, R-TILE at § 1.2); each statement is
V6's sentence verbatim after the setting clause, from § 2.2's bold statements or its "Theorems this phase proved" list. V6's preliminaries — V6-DIAM,
V6-E1, V6-DICH (two tiles of one colour have interior distances all below or all above 1), V6-RING, V6-WIN, V6-GERM (FS116-N1-GERM-R by V6's route) and
V6-TIP (every change point has a tip) — are steps of § 2.2, not filed apart; V6-GERM is held as GERM-R and is not filed twice.*

derivation: FS116-V6-HUBS
  statement: in a non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours whose ring
    carries no arc of Γ, m = 1: the change points are y_k = r(ψ₀ + 60°k), six of them; a tile of p tips at most two, and two only if consecutive
  uses only: V6-DIAM (a tile has diameter at most 1, so its tipped change points lie in one closed 60° arc); V6-RING (six colours, at least four at p:
    exactly two absent colours, the ring alternating them under the 60° rotation); V6-WIN (an odd number m of change points in each half-open 60°
    window); V6-TIP (every change point has a tip, by B(u) ∩ B(v) ⊂ B(p), non-Siamese and six colours); four tiles at p, so 4(m + 1) ≥ 6m
  not claimed: anything in the Siamese class; anything at k ≥ 7 (SQ9 at k = 9 meets every other hypothesis with twelve points of Γ on its ring, control
    v6-sq9); that any such fragment exists
  argument: FS116-V6-verification.md § 2.2 The derivation — the class is empty
  verdict: derived
  grade: hand
  minds: 1
  model: none at six colours (FS116-Y4-EMPTY, held: the class is empty); SQ9 at k = 9 for the hypotheses but the colour count (control v6-sq9)
  prior art: partly: FS116-Y3-SIX (held) and FS116-V1-FRAME's F5 state the count, FS114-N6-RING60 the hexagon; no outside search — owed
  handoff: none — a step of FS116-V6's route to FS116-Y4-EMPTY; it travels with EMPTY's handoff

**True vacuously** — V6's lemma, one mind; the third route to FS116-Y3-SIX's first clause (after Y3's tip count and FS116-V5-RING's reach), "simple" idle by V6's own uses-only line (§ 2.2: simplicity enters at V6-COUNT's last step only). Rests on it: FS116-V6-HUG; FS116-V6-COUNT; FS116-V6-ANTI; FS116-V6's route to FS116-Y4-EMPTY.

derivation: FS116-V6-HUG
  statement: in a non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours whose ring
    carries no arc of Γ, with its change points y_k = e(60°k) (FS116-V6-HUBS), no tile T of p tips both y_0 and y_1 while being the only tip at each
  uses only: V6-GERM (near a change point the X-tiles lie in B̄(u) ∖ B(v) and the X̄-tiles in B̄(v) ∖ B(u)); V6-TIP (the tip sector holds only
    colours of p, six colours); V6-DICH (non-Siamese: a point lies in the closure of at most one tile of each colour; two distinct tiles of one colour
    have interior distances all below or all above 1); V6-DIAM; the identity |a(s) − b(t)|² − 1 = −8 sin(s/2) sin(t/2) cos((s + t)/2) for a(s) =
    y_0 + e(120° + s), b(t) = y_1 + e(300° − t), 0 < s, t ≤ 60° (control v6-hug)
  not claimed: anything about a tile tipping two adjacent hubs with a second tip at either; anything in the Siamese class (non-Siamese gives the
    uniqueness of the tip and of the two X̄-tiles; V6: "Validity alone kills it here; non-Siamese was used only for the uniqueness of R⁻, R⁺ and of the
    tip"); anything at k ≥ 7
  converse: one-way — "the only" is the hypothesis "the only tip at each hub", not a characterization; nothing two-way is stated
  argument: FS116-V6-verification.md § 2.2 The derivation — the class is empty
  verdict: derived
  grade: hand
  minds: 1
  model: none at six colours; V6's stage-1 candidate (a star with two five-colour hubs, § 2.3 item 1) fails exactly here, its two X̄ ring tiles
    √3 − 1 apart at s = t = 30°
  prior art: partly: FS116-Y4-FLANK (its second-order, colour-free form) and FS114-Y5-PXKILL — G83's straddle along two unit circles; this identity not
    searched — owed
  handoff: de Bruijn — the pinning of the two edges to ω(y_1) and ω(y_0) and the trigonometric identity, a short kernel target, with EMPTY

**True vacuously** — V6's lemma, one mind: FS116-Y4-FLANK's content in the case EMPTY uses, by a second route (V6 § 3.2 row 3; at curvature 1 and turning angle `φ` both give `(2cos φ − 1)²`). The identity was checked symbolically by its control and numerically by the coordinator at 20,000 random `(s, t)` (item 138). Rests on it: FS116-V6-COUNT; FS116-V6's route to FS116-Y4-EMPTY.

control: v6-hug
  of: FS116-V6-HUG — the identity, and the two hugging arcs inward from y_0 and y_1 within 1 on the grid s, t in 1..60 degrees
  run: python3 ../tools/fs116_v6_hug.py inward
  expect: identity holds; below 1: 3600 of 3600
  fault: python3 ../tools/fs116_v6_hug.py outward

derivation: FS116-V6-COUNT
  statement: in a non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours whose ring
    carries no arc of Γ, with V6-HUG, the tips force two antipodal doubly-tipped hubs and four double tiles: M = 4, s = 2, each hub of S has exactly
    two tips, and every tip at a hub of S is a double tile; the two hubs of S are antipodal, y_k and y_(k+3), each tipped by two of the four tiles
  uses only: FS116-V6-HUBS (six hubs; a tile tips at most two, consecutive); FS116-V6-HUG (each double tile has a hub with two or more tips); V6-TIP
    (every hub has a tip); four tiles at p; counting incidences, Σ_h t_h ≤ M + 4; the edges of the hexagon y_0 … y_5
  not claimed: the contradiction (FS116-V6-ANTI and simplicity finish it); anything in the Siamese class; anything at k ≥ 7
  argument: FS116-V6-verification.md § 2.2 The derivation — the class is empty
  verdict: derived
  grade: hand
  minds: 1
  model: none at six colours
  prior art: owed — no search run
  handoff: none — a step of FS116-V6's route; with EMPTY

**True vacuously** — V6's lemma, one mind; it replaces FS116-Y3-TIPS's "exactly one tip per hub" on V6's route (V6 § 3.2 row 2). Rests on it: FS116-V6's route to FS116-Y4-EMPTY.

derivation: FS116-V6-ANTI
  statement: in a non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours whose ring
    carries no arc of Γ, with its change points y_k (FS116-V6-HUBS), a tile tipping y_k and a tile tipping y_(k+3) share no edge at p
  uses only: V6-DIAM (a tile tipping y lies in B̄(y)); B̄(y_k) ∩ B̄(y_(k+3)) = {p}
  not claimed: that the four tiles at p form a cycle of shared edges (that is simplicity, V6-COUNT's last step); anything at k ≥ 7
  argument: FS116-V6-verification.md § 2.2 The derivation — the class is empty
  verdict: derived
  grade: hand
  minds: 1
  model: none at six colours
  prior art: owed — no search run
  handoff: none — a step of FS116-V6's route; with EMPTY

**True vacuously** — V6's lemma, one mind; it uses only that a tile has diameter at most 1. Rests on it: FS116-V6's route to FS116-Y4-EMPTY (V6-COUNT's last step).

derivation: FS116-V6-ADJ
  statement: in a non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours whose ring
    carries no arc of Γ, outer tiles of one colour at adjacent hubs cannot both hug the lens arcs beyond their hubs (ω(y_1) beyond y_0, ω(y_0) beyond
    y_1)
  uses only: V6-DICH; the identity of FS116-V6-HUG with both arcs run outward, a = y_1 + e(−60° + s), b = y_0 + e(120° − t)
  not claimed: anything FS116-Y4-EMPTY needs (it is not used there); anything at k ≥ 7
  argument: FS116-V6-verification.md § 2.3 The attack
  verdict: derived
  grade: hand
  minds: 1
  model: none at six colours; V6's stage-1 candidate needed five-colour hubs because of it (§ 2.3 item 2)
  prior art: owed — no search run
  handoff: none — not needed by EMPTY

**True vacuously** — V6's lemma, one mind, not needed by EMPTY; V6: "It is why a single outer colour per hub is impossible on the forced colours of `y_2`, `y_5` (§ 12's NBTIP) and why a construction needs five-colour hubs — which V6-HUG then kills from the inside." Its outward identity was re-checked numerically on the 60 × 60 grid by this close (a checking reading, not a mind: `FS116-Z2-close.md` § 1.4). Rests on it: nothing in this file.

control: v6-sq9
  of: FS116-V6-HUBS — the k = 9 control: SQ9 meets every hypothesis but six colours, its ring carries no arc of Γ, and five colours
  run: python3 ../tools/fs116_v6_sq9.py 3
  expect: period 3: 9 colours; least same-colour squared gap 4 half-units^2 (valid and non-Siamese: True); colours at p: 4; Gamma on the ring: 12 points; ring colours: 5; ring colours of p: 0
  fault: python3 ../tools/fs116_v6_sq9.py 2

## The close's case list (FS116-Z1)

derivation: FS116-C114-LOCAL-F
  statement: there is a radius R — one R for every complexity, Siamese pairs allowed — such that no valid fragment exists on the closed disc of radius
    R about a vertex of at least four colours
  argument: FS116-Z1-close.md § 2.6 C114-LOCAL-F's case list, as the records leave it (non-Siamese simple fragments unless said)
  verdict: gap: the ring types left without an exclusion — a (Q)-free ring carrying (R2) arcs after the bends, a full parallel semi-hub of three
    colours (FS116-SEMI-PAR3), a closed change point (FS116-RING-Q's gap; any exclusion on B̄(p, 2) reads the far side of p, FS116-Y2-DCREAD), five-
    and six-colour vertices beyond FS116-Y2-SIXOFF's family, and the Siamese and non-simple classes; the Γ-free type is excluded at radius 1 + ε
    (FS116-Y4-EMPTY, held) and the saturated right-angled straight cross in the (Q)-free non-Siamese class at R = 2 (FS116-S1-QF)

Frozen at § 1 and § 6. The milestone's question, filed as GAP at its named cases; the stub's existence form was never worked as a whole, its structural form carried the rounds (`FS116-Z1-close.md` § 2.5). Whether FS-112's bends, run on a fragment, leave a (Q)-free ring with (R2) arcs at all
— if not, the Γ-free case is the whole (Q)-free case — is the invention signal of inventory item 136, carried to FS-123 unsettled (`FS116-Z2-close.md`
§ 1.5). Rests on it: nothing in this file; the successor stubs (FS-123–FS-125).


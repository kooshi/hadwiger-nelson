# FS-116 — the proposed claim list (statements only)

*Proposed by the opening job FS116-O1 (Ephodos), 2026-09-29. **Frozen by Keryx, 2026-09-29 05:39 UTC**, with six edits for blindness only (no statement changed): a parenthetical in this preamble and one in § 6 that asserted § 3's first claim, § 3's heading, which gave a mind count, and three source notes pointing into fenced records, replaced by "proposed at the opening" or "(this list)". The proposal as written is in git (commit 9b9b2fa6). **Statements only: no proof, no
sketch, no route, no grade.** Every quotation is verbatim with its source address; text outside quotation marks is this list's own and is marked "(this
list)". Give every claim you work one verdict — **TRUE** (with your derivation), **FALSE** (with a counterexample), **GAP at a named step**, or **MISSTATED**
(with the corrected statement) — with your count of minds. FALSE and GAP are results, as valuable as TRUE. **Every statement about a valid six-coloured
fragment on a large disc is about a possible object**: at six colours the class may be empty, so every structural claim names its behaviour at `k = 7` (R7) or at another `k` with an inhabitant. `data/fs114/claims.md` §§ 0, 6 stay in
force where this list does not restate them.*

## 0. Definitions (quoted)

- **Valid map, unit arc, (Q), (R2), `F(M)`, `R(M)`** (`plans/FS112-derivation.md` header, as quoted in `data/fs114/claims.md` § 0, verbatim): "A map is
  **valid** when it is a locally finite map of the plane bounded by segments and circular arcs, **arcs of radius 1 allowed** (Condition 5 dropped),
  carrying a six-colouring in which no two interior points of one colour are at distance exactly 1. A **unit arc** is a boundary arc of radius 1; **(Q)** an
  arc whose centre carries both side colours and at least four colours; **(R2)** an arc whose centre carries the outer side colour and not the inner, with an
  inner-colour tile along the radius-2 circle over the whole arc. `M*` is a terminal valid modification (N2-TERM). `F(M)`: the vertices of at least four
  colours; `R(M)`: the vertices carrying a repeated colour."
- **Local; valid fragment** (`data/fs114/claims.md` § 0, verbatim): "a statement or a step **reads radius `R`** when its hypotheses and its conclusion concern
  only the map inside a closed disc of radius `R`. A **valid fragment on a disc** `D` is a map of an open set containing `D`, bounded by segments and circular
  arcs, six-coloured with no two interior points of one colour at distance exactly 1."
- **Valid `k`-coloured fragment** *(this list)*: the same with "`k`-coloured" in place of "six-coloured"; "valid fragment" alone means six-coloured.
- **Siamese** (`[Polymath16threads]` `[10.59]`, de Grey, 2018-09-03, as quoted in `data/fs114/claims.md` § 0, verbatim): "tiles that lie entirely within
  each other’s annulus of exclusion".
- **`Γ`, tiles** (`plans/FS110-N-proof.md` § 1.3, verbatim): "`Γ ⊂ ℝ²` a locally finite union of arcs, C¹ with one-sided tangents at their endpoints …;
  `Γ` is null. **Tiles** are the components of `ℝ² ∖ Γ`: open, connected, each of one colour."
- **Ring, change point** (`plans/FS114-N3-proof.md` header, verbatim): "at a vertex `p`, the **ring** is `ω(p)`; a **change point** of the ring is a point of
  `Γ ∩ ω(p)` where the colour of the ring off `Γ` differs on its two sides; `σ` is the rotation by `60°` about `p`."
- **Tactic edge** (`plans/FS114-N-proof.md` l. 246, FS114-N2's notation, verbatim): "a **tactic edge** is an edge of the map (between vertices of degree ≥ 3)
  that supplies an (A) repeat — a whole unit arc on `ω(q)`, its inner tile `x` with `q ∈ cl x`, and a tile of the outer tile's colour touching `x` at `q`
  alone (NB-A1: each edge supplies at most one)".
- **Simple** (`plans/FS114-N-proof.md` l. 444, verbatim): "every tile an open disc whose closure meets each other tile's closure in a connected set or not at
  all, and does not meet itself — the plane form of `μ = 0`."
- **Essential multicolour** (`data/fs111/claims.md` § 0, D-NF, verbatim): "`S_j = f⁻¹(j)`; `S̃_j` the points of density 1 of `S_j`; … **`P(x) = {j : d̄_j(x) >
  0}`**, the *essential multicolour*."
- **Saturated** (`plans/FS111-M-regularity.md` § 2.1, verbatim): "every essential boundary point is at distance exactly 1 from the support of each colour of
  its essential multicolour." **Saturated on a disc** *(this list)*: a valid fragment on `B̄(p, R)` is *saturated on `B̄(p, R − 1)`* when every essential
  boundary point in `B̄(p, R − 1)` is at distance exactly 1 from the support of each colour of its essential multicolour.
- **`χ_m⁰(ℝ²)`** (`CLAUDE.md` § The aim, link 1, verbatim): "the fewest colours in a Lebesgue-measurable colouring whose unit pairs are bichromatic almost
  everywhere".
- **The capped strip's midline configuration** *(this list; `data/fs114/fs114-y6/survey.out`, `LEDGER.md` row 136)*: a degree-4 vertex of four colours whose
  four edges are segments and whose ring carries four (Q) arcs.
- **Ring type** *(this list)*: at a vertex `p` of at least four colours, the cyclic word, read round `ω(p)` modulo `σ`, of its (Q) arcs, its other arcs of
  `Γ`, its change points, and the arcs between them with their colours.

## 1. The questions (verbatim)

- **C114-LOCAL-F**, the existence form (`plans/STUB-local-exclusion.md` § Existence form, verbatim): "**Is there a radius `R` — one `R` for every complexity,
  Siamese pairs allowed — such that no valid fragment exists on the closed disc of radius `R` about a vertex of at least four colours?**" *Not claimed:* that
  any such `R` is at most any given number; by FS114-Y-DIAL any such `R` exceeds `φ²/√2 ≈ 1.8512`.
- **STRUCT**, the structural form (the same stub, § Structural form, verbatim): "**In every valid fragment with any number `k ≥ 4` of colours, what does the
  unit circle about each vertex of at least four colours carry — its (Q) arcs, its change points, and the vertices of at least four colours it places at
  distance 1 — and which of these ring types can recur at every such vertex a ring places?**" *Not claimed:* that the answer at `k = 6` differs from the answer
  at `k = 7`.

## 2. Held inputs (statements verbatim; used as held, grades in their files)

- **FS114-CV-EXISTS** (`plans/FS114-derivation.md` § 1): "Every valid map has a vertex of at least four colours, in the map itself; the proof passes through
  `M*`, where with no such vertex every stuck chain would be bi-infinite; it uses neither CV-HD nor FS112-C-ENDS, no ray step and no residue".
- **FS112-N3-NOBOTH** (`data/fs114/claims.md` § 2): "The centre of a both-kind unit arc is a vertex with at least four colours or a repeated colour."
- **FS114-Y-DIAL** (`plans/FS114-derivation.md` § 4): "The strip with each top (bottom) tile capped by the unit arc about its own valley between its two top
  corners is a valid fragment, and it holds the closed disc `B̄(P_j, R)` about every midline four-colour vertex for every `R` with `R² < (7 + 3√5)/4 = φ⁴/2`
  (`R < φ²/√2 ≈ 1.85123`); no valid extension of the strip holds that disc at `R ≥ φ²/√2` (the disc then holds the stop point `Q`) — C114-DIAL met,
  marginally, above `≈ 1.834`".
- **FS111-M-PINCH** (`plans/FS111-derivation.md` round 1): "at a saturated point x of an honest a.e.-proper colouring with a neighbourhood N in which only two
  colours a, b have positive measure and each is a.e. one connected open set of density points (H1, H2): either N is split by one unit circle T₁(y) with a
  inside and b outside or the reverse, y a contact of both colours, or two open unit discs tangent at x from opposite sides lie a.e. in S_a and in S_b; the
  case (in, in) is impossible; no positive density of the partner is needed".
- **FS111-VM2-STRIP-MID** (`plans/FS111-derivation.md` round 2): "the strip of `LEDGER.md` row 136 is tight but not saturated on its midline: at the
  midpoint of every edge A_j | B_j both side colours are free (no tile of either colour at distance exactly 1)".

## 3. Two claims from the opening

- **FS116-O1-YESLIM** *(proposed at the opening)*: "for every k ≥ 1, if for every R > 0 some closed disc of radius R carries a valid
  k-coloured fragment (a map of an open set containing the disc, bounded by segments and circular arcs, k-coloured with no two interior points of one colour at
  distance exactly 1), then χ_m⁰(ℝ²) ≤ k; at k = 6, then χ(ℝ²) ≤ 6, with no MR". *Not claimed:* the converse; that the limit colouring is a map, saturated or
  regular; anything about the fragments' centres; anything from fragments on discs of one bounded radius.
- **FS116-O1-SATPIN** *(proposed at the opening)*: "let p be a vertex of at least four colours of a valid k-coloured fragment saturated
  on a disc about p, every tile at p with a cone of positive angle; each edge e at p, with side colours a (clockwise) and b (counter-clockwise) and unit normal
  ν pointing to b's side, is near p of exactly one of two types — (split) an arc of the unit circle about a point y of ω(p) at which both a and b have support,
  a unit arc of kind both; or (tangent) a segment or an arc of radius at least 1 along which every x has x + ν(x) in the closure of colour a and x − ν(x) in the
  closure of colour b, so that p + ν(p) carries a and p − ν(p) carries b, two antipodal points of ω(p) on the normal to e at p; and every colour of p is
  carried on ω(p)". *Not claimed:* anything at a cusp at `p`; that the split centre has four colours; that any saturated valid six-coloured fragment about a
  four-colour vertex exists; SAT-STRIP.

## 4. D0 — the saturated class

- **SAT-STRIP** *(this list)*: no valid fragment on `B̄(p, 2)` saturated on `B̄(p, 1)` has at `p` a degree-4 vertex of four colours whose four edges are
  segments. *Not claimed:* anything at `k ≥ 7` (at `k = 9` the square nine-colouring of side 1/2 has such vertices, saturated); anything about unsaturated
  fragments (the capped strip holds such a vertex to `φ²/√2`, FS114-Y-DIAL).
- **SAT-QFREE** *(this list)*: in a valid fragment saturated on a disc about a vertex `p` of at least four colours, every tile at `p` with a cone of positive
  angle, whose ring carries no (Q) arc, each split centre of FS116-O1-SATPIN and each point `p ± ν(p)` of its tangent type is a change point of the ring or
  lies on an arc of `Γ` on `ω(p)`. *Not claimed:* rings with (Q) arcs; that such a vertex exists in a saturated fragment.
- **SATPIN-PER** *(this list)*: in a valid fragment
  saturated on a disc about a vertex `p` of at least four colours, every tile at `p` with a cone of positive angle, whose interfaces near `p` carry only
  finitely many radii of curvature, every edge at `p` is a segment of the tangent type or a (Q) arc about a point of `ω(p)` at which no colour has density 0.
  *Not claimed:* anything with infinitely many radii; that such a fragment exists at six colours.
- **NO-SAT** *(this list)*: there are an explicit radius `R`, one `R` for every complexity, Siamese pairs allowed, and a derivation that no valid fragment on
  the closed disc of radius `R` about a vertex of at least four colours is saturated on the closed disc of radius `R − 1` about it. *Not claimed:* C114-LOCAL-F
  (the all-fragments form); that NO-SAT gives `χ_m⁰(ℝ²) ≥ 7` without FS111-C-SAT-T-HONEST at six and the rest of route M.

## 5. D1 — the ring

- **RING-TWIST** *(this list)*: at a vertex `p` of at least four colours of a valid fragment on a closed disc of radius above 2 about `p` (Siamese pairs
  allowed, any degree), the set `D` of points of `ω(p)` in the closure of a tile of one of `p`'s colours is contained in the union of the arcs of `Γ` on `ω(p)`
  and finitely many points; and every half-open 60° window `W` of `ω(p)` with `W ∪ σ(W)` disjoint from `D` holds an odd number of change points. *Not claimed:*
  anything at `k ≥ 7` (with three colours absent the parity fails: R7's lattice points); that `D` is non-empty.
- **RING-Q** (card `what-do-q-rings-force`, `plans/POROS-2026-09-28-fs116-question.md` § 2.4, its ask verbatim: "At a vertex of at least four colours whose
  ring carries a (Q) arc, which vertices of at least four colours, and which (Q) arcs, does the ring force at distance 1 — as N7-HUB does for (Q)-free
  rings?") *(this list, as a claim)*: in a non-Siamese simple valid fragment on a closed disc of radius above 2 about a vertex `p` of at least four colours
  whose ring carries a (Q) arc, every change point of the ring that lies on no (Q) arc is a vertex of at least four colours; **RING-Q′**, the same for the
  change points whose points at `±60°` on `ω(p)` also lie on no (Q) arc (N7-HUBQ's form). *Not claimed:* Siamese or non-simple fragments; that the (Q) arcs'
  own ends are four-colour vertices. *Controls:* the strip's midline rings and the disk's corners (row 136); R7 at `k = 7`.
- **RING-TRANSFER** *(this list)*: for each ring type at a vertex of at least four colours, the ring types of the vertices of at least four colours it places at
  distance 1 are determined by a finite rule; state the rule, derive it, and name the ring types that can recur at every vertex they place. *Not claimed:*
  that the rule is the same at `k = 6` and `k = 7`.

## 6. D2 — the exclusion

- **C114-LOCAL-F** as § 1, worked as the NO: an explicit `R` and its derivation, or FALSE with fragments on every disc, or GAP at a named ring type.
- **DISC-F** *(this list)*: there are an explicit radius `R` and a derivation that no valid fragment exists on any closed disc of radius `R`. *Not claimed:*
  anything about the disc's centre; any `R` at most the radius of `[Polymath2021]` Fig. 10's disk, `√((25 + 9√5)/10) ≈ 2.1246`, which is a valid fragment
  (row 136).
- **LOCAL-DENSE** *(this list)*: there is an explicit `r ≥ 3` such that every valid fragment on a closed disc `B̄(x, r)` has, in `B̄(x, 3)`, a vertex of at
  least four colours or a vertex with a repeated colour. *Not claimed:* the same with four colours alone (FS-115's density form).

## 7. Y — construction (each checked exactly on an object given by formula)

- **Y-QRING** *(this list; `.claude/skills/grokkings/SKILL.md` G83's killing test)*: a valid fragment on a closed disc of radius above `φ²/√2` about a vertex
  of at least four colours whose ring carries a (Q) arc — or a derived obstruction at a named radius.
- **Y-SAT** *(this list)*: a valid fragment on `B̄(p, R)`, saturated on `B̄(p, R − 1)`, about a vertex `p` of at least four colours, for the largest `R`
  reached (first: the capped strip made saturated at its midline, which decides SAT-STRIP from the other side) — or a derived obstruction at a named radius.

## 8. K — FS-114's owed second mind

- **FS114-N7-3T** (`plans/FS114-derivation.md` § 3, verbatim): "**Three or more tactic edges at a degree-4 vertex with a (Q)-free ring are excluded at radius
  `1 + ε`**, except the open-cap family **OC** (`+−+`, a Reuleaux lens beside a `60°` anti-lens; with a fourth tactic edge, the Reuleaux bowtie whose lenses
  do not border the caps): the `(2, 1, 1, 0)` patterns, the pinwheel, `γ = 0°` and non-Reuleaux lenses, `++−`, `−++` die in every member (with N7-HUB: at a
  four-colour vertex, non-Siamese and simple, whose ring is (Q)-free after the bends, each of the six change points `y_k` is a vertex of at least four colours:
  the directions toward `p` there lie in tiles of `p` reaching `y_k`, a tip, which meets `B(y_{k−1},1) ∩ B(y_{k+1},1)`, so its colour is carried at `y_{k±1}`
  by no other tile, and the outward directions in tiles of `p`'s colours outside `B̄(p,1)` whose `p`-tiles face away)". *Not claimed* (the entry's own line,
  verbatim): "rings with (Q) arcs (N7-HUBQ, the tip with (Q) arcs allowed, needs the change point's ±60° points free of (Q) arcs — the named GAP); OC (its
  forced structure N7-OCTB and a route to `√3`, not closed); the pinwheel's E1 and E2 in N7's readings R-E1, R-E2 (GAP; whether R-E2 is the construction
  side's E2 is not settled, `plans/FS114-C-close.md` stage 2 §2.5)".

## 9. Controls, killing tests and shared constraints

- **Controls** *(this list)*: the capped strip (FS114-Y-DIAL, about its midline vertices to `φ²/√2`), the disk (row 136, `B̄(A_0, φ)` attained), FS114-Y2-BOWTIE
  (`B̄(p, 3√3/5)`), R7 at `k = 7` (FS111-M-R7), and the square nine-colouring of side 1/2 at `k = 9` (FS111-W-SQ9). Every checker accepts them before any
  refusal is believed; every local route states where it fails on the strip and the disk.
- **Killing tests carried** (`data/fs114/claims.md` § 6, verbatim): "The argument must fail on the slack hexagonal 7-colouring, and must name the step where
  "six" is spent (TS's K1 rule)."; "every NO route fails on CAL-STRIP (and, once rebuilt, CAL-DISK) at a named step and says where the plane beyond them is spent
  (C-BEYOND). A route with no such step is refuted by the strip."
- **The ban and beyond it** (`data/fs114/claims.md` § 6, verbatim): "No enumeration of maps, colourings, tile graphs or dual graphs, by any program." *(this
  list)* Nor of ring types.

## 10. Added at round 2 (frozen by Keryx, 2026-09-29 06:28 UTC; statements verbatim from their proposing record, with their *not claimed* lines)

- **RING-GERM** *(proposed at round 1)*: in a non-Siamese valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, let y be a change point of the ring, X the colour of the ring just counter-clockwise of y and X̄ the colour just clockwise, and u⁻, u⁺, v⁻, v⁺ the arcs of ω(p) just clockwise and just counter-clockwise of the ring points y + 60° and y − 60°; then p has four colours and no more, X and X̄ are the colours absent at p, and (i) if neither v⁻ nor u⁺ lies on a (Q) arc, every direction at y in the open cone of 60° about the direction to p lies in the cone of a tile of p; (ii) if neither u⁻ nor v⁺ lies on a (Q) arc, every direction at y in the open cone of 60° about the direction away from p lies in the cone of a tile of a colour of p that is not a tile of p; (iii) if none of the four lies on a (Q) arc, y is a vertex of at least four colours *Not claimed:* anything at k ≥ 7; that a change point with a germ on a (Q) arc has fewer than four colours (the strip's P₂ has four, with u⁺ and v⁻ on (Q) arcs); that the ring's change points are 60° apart (N6-RING60's conclusion, for (Q)-free rings)
- **RING-TWIST-C** *(proposed at round 1)*: at a vertex p of at least four colours of a valid fragment on a closed disc of radius above 1 about p (Siamese pairs allowed, any degree), the set D of points of ω(p) in the closure of a tile of one of p's colours is closed and lies in the union of the arcs of Γ on ω(p) and finitely many points; and for every half-open 60° window W of ω(p) with W ∪ σ(W) disjoint from D: p has four colours and no more; off a finite set, every point of W ∪ σ(W) lies in the closures of tiles of a single colour, one of the two colours absent at p, and this colour differs at θ and at θ + 60° for θ in W; every arc of Γ on ω(p) meeting W ∪ σ(W) in an arc has one colour on both sides; W holds an odd number of colour changes — points of W at which that colour differs on the two sides — each lying in the closures of tiles of the two absent colours and of no other colour; every change point in W is a colour change, and a colour change in W that is not a change point lies on an arc of Γ on ω(p) with one colour on both sides; so W holds an odd number of change points when no such arc meets W, in particular in every non-Siamese simple fragment *Not claimed:* anything at k ≥ 7; that any fragment of the class has a qualifying window (no held fragment has one: the strip's and the disk's D-free arcs are at most 60° and 87.83°); the parity of change points when a seam meets W (FS116-N1-TWIST-LIT: then it can fail)
- **FS116-N1-TWIST-LIT** *(proposed at round 1)*: RING-TWIST's parity clause as posed — every half-open 60° window W of ω(p) with W ∪ σ(W) disjoint from D holds an odd number of change points — holds on every fragment of RING-TWIST's class if and only if no fragment of that class has a half-open 60° window W with W ∪ σ(W) disjoint from D *Not claimed:* that the class has a fragment with a qualifying window; anything in the non-Siamese simple class, where the clause holds by RING-TWIST-C

## 11. Added at round 3 (frozen by Keryx, 2026-09-29 07:09 UTC; statements verbatim from their proposing record, with their *not claimed* lines)

- **FS116-N1-GERM-R** *(proposed at round 2)*: in a valid k-coloured fragment on a closed disc of radius above 1 about a point p, for any k, Siamese pairs allowed, let y = r(ψ) be a point of ω(p), c a colour, and v⁻, v⁺, u⁻, u⁺ the arcs of ω(p) just clockwise and just counter-clockwise of r(ψ − 60°) and r(ψ + 60°); if v⁻ lies in the closure of a tile of colour c, no tile of colour c approaches y along a direction β with β − ψ in (150°, 330°); for v⁺ the interval is (−30°, 150°), for u⁻ (−150°, 30°), and for u⁺ (30°, 210°) *Not claimed:* anything about tiles that approach y only along the boundary directions ψ + 150°, ψ + 330°, ψ − 30°, ψ + 30°, ψ + 210°, ψ − 150°; anything when a germ lies on Γ with colour c on neither side
- **FS116-N1-GERM-S** *(proposed at round 2)*: in a valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, Siamese pairs allowed, let y be a change point of the ring, X the colour of the ring just counter-clockwise of y and X̄ the colour just clockwise, and u⁻, u⁺, v⁻, v⁺ the arcs of ω(p) just clockwise and just counter-clockwise of the ring points y + 60° and y − 60°; then p has four colours and no more, X and X̄ are the colours absent at p, and (i) if neither v⁻ nor u⁺ lies on a (Q) arc, every direction at y in the open cone of 60° about the direction to p lies in the cone of a tile of a colour c of p every tile of p of which colour lies in B̄(y, 1); (ii) if neither u⁻ nor v⁺ lies on a (Q) arc, every direction at y in the open cone of 60° about the direction away from p lies in the cone of a tile, not a tile of p, of a colour c of p every tile of p of which colour misses B(y, 1); (iii) if none of the four lies on a (Q) arc, y is a vertex of at least four colours *Not claimed:* anything at k ≥ 7; that the tile in (i) is a tile of p (that is RING-GERM, in the non-Siamese class); that a change point with a germ on a (Q) arc has fewer than four colours
- **FS116-N1-TOUCH** *(proposed at round 2)*: in a valid fragment on a closed disc of radius above 1 about a vertex p of four colours and no more, Siamese pairs allowed, let w be a point of ω(p) in the closure of a tile of one of p's colours which is not a change point of the ring and lies on no arc of Γ on ω(p), and suppose none of the four arcs of ω(p) just clockwise and just counter-clockwise of w + 60° and w − 60° lies on a (Q) arc; then the ring just clockwise and just counter-clockwise of w lies in tiles of one colour X absent at p, each of the four arcs lies in the closure of a tile of the other absent colour X̄ and of no tile of colour X, and no tile of colour X̄ has w in its closure *Not claimed:* that such a point exists in any fragment of SAT-QFREE's class; anything at k ≥ 7; anything when a germ lies on a (Q) arc
- **FS116-N1-ECHO** *(proposed at round 2)*: in a valid k-coloured fragment on a closed disc of radius above 2 about a point p, for any k, Siamese pairs allowed, let w be a point of ω(p) whose ring just clockwise and just counter-clockwise of w lies in tiles of one colour X absent at p; if the fragment is saturated at w and X is in w's essential multicolour, the point 2w − p lies in the closure of a tile of colour X *Not claimed:* anything when X has density 0 at w (a cusp); that the X-tile at 2w − p exists in any fragment of SAT-STRIP's class
- **FS116-N1-AXIS** *(proposed at round 2)*: let p be a degree-4 vertex of four colours of a valid fragment on a closed disc of radius above 1 about p, saturated on a disc about p, whose four edges are segments along the four half-axes, with tiles coloured c_I, c_II, c_III, c_IV by quadrant and absent colours X, X̄; then at q_N = p + (0, 1): (a) every tile approaching q_N along a direction below the horizontal has colour X or X̄; (b) a tile of colour c_IV approaches q_N along 0⁺ and one of colour c_III along 180⁻, both above the line y = 1; (c) the arcs of ω(p) just counter-clockwise of r(30°) and just clockwise of r(150°) lie on no (Q) arc; (d) if the arcs just clockwise of r(30°) and just counter-clockwise of r(150°) lie on no (Q) arc, every tile approaching q_N along a direction below the horizontal has one colour, and q_N is not a change point; and at each of the axis points q_E, q_W, q_S, read with the quadrants turned with it *Not claimed:* anything for four segments not at right angles; anything at k ≥ 7 for (d) (at k = 9 SQ9 fails it); that the axis points are touch points in any fragment saturated on B̄(p, 1); SAT-STRIP

## 12. Added at round 4 (frozen by Keryx, 2026-10-03 15:12 UTC; statements verbatim from their proposing records, with their *not claimed* lines)

- **FS116-S1-KAPPA** *(proposed at round 3)*: at a vertex p of four colours and no more of a valid fragment on a closed disc of radius above 1 about p, Siamese pairs allowed, whose ring carries no (Q) arc, every germ of ω(p) (an arc just clockwise or just counter-clockwise of a ring point) lies in the closure of tiles of exactly one colour absent at p, κ, and the germ 60° on carries the other; so κ's change points form a finite non-empty set invariant under the rotation by 60° about p, each half-open 60° window of ω(p) holds an odd number of them, and antipodal germs carry different colours; in a non-Siamese fragment the change points are exactly y + 60°ℤ for one ring point y *Not claimed:* anything when the ring carries a (Q) arc; anything at k ≥ 7 (at k = 9 SQ9's r(45°) and r(225°) carry one colour); that any vertex of the class exists at six colours
- **FS116-S1-RUNG** *(proposed at round 3)*: let p be a degree-4 vertex of four colours of a valid fragment whose four edges are segments along the four half-axes, with tiles coloured c_I, c_II, c_III, c_IV by quadrant, and suppose the fragment saturated at every point of the east edge's first segment [p, p + (ℓ, 0)], 0 < ℓ ≤ L_E; if a tile of colour c_IV has a point w in its closure with |w − q_N| < 1, q_N = p + (0, 1), then |w − p − (s, 1)| ≤ 1 for every s in [0, ℓ]; and the same at each edge and axis point, turned and reflected with the quadrants; in particular a contact of c_IV at r(φ), 90° < φ < 150°, gives ℓ ≤ cos φ + √(sin φ (2 − sin φ)), which at φ = 120° is FS116-Y1-STRIPCEIL's x* = √(√3 − 3/4) − 1/2 *Not claimed:* anything at a partner point where the edge is not saturated; anything for edges that are not segments; that a contact exists in quadrant II in any fragment of SAT-STRIP's class (FS116-S1-LENS supplies one where the ring carries no (Q) arc)
- **FS116-S1-QF** *(proposed at round 3)*: no non-Siamese valid fragment on B̄(p, 2), saturated on B̄(p, 1), whose ring ω(p) carries no (Q) arc, has at p a degree-4 vertex of four colours whose four edges are segments at right angles *Not claimed:* SAT-STRIP itself (rings with (Q) arcs, Siamese fragments, crosses not at right angles stay open: § 2.5's G1–G3); anything at k ≥ 7 (at k = 9 SQ9 meets every other hypothesis); that the class is non-empty at six colours without the cross
- **FS116-Y3-NBTIP** *(proposed at round 3)*: in FS116-Y3-TIPS's setting, the tip of each hub meets the open unit disc about each of the two neighbouring hubs; so no hub has a neighbour's tip colour as an outer colour, and the only outer colour of y_2 is 4 and of y_5 is 3 *Not claimed:* anything about outer tiles of other colours; anything outside the Γ-free class (there consecutive change points need not be 60° apart)
- **FS116-Y3-TIGHTLENS** *(proposed at round 3)*: in a non-Siamese simple valid six-coloured fragment on a closed disc of radius at least √3 about a vertex p of at least four colours whose ring carries no arc of Γ, labelled as FS116-Y3-TIPS, the edges of p satisfy (Q1) δ_4 = −30° or δ_1 = 30° or δ_2 = 210°; (Q2) δ_3 = 270° or δ_1 = 30° or δ_2 = 210°; (Q4) δ_2 = 150° or δ_4 = 30° or δ_3 = 210°; (Q5) δ_1 = 90° or δ_4 = 30° or δ_3 = 210° — for each lens beside a single tip, the tip of one of its two hubs is tight at p for that hub; so at least two edges of p lie along flanking directions of hubs, and no such fragment has a generic star *Not claimed:* that any star satisfying (Q1)–(Q5) occurs; anything below radius √3 (a generic star there is neither excluded nor built); anything in the Siamese or non-simple class; anything at k ≥ 7 (a third absent colour survives near q_k)
- **FS116-Y3-STARFORCE** *(proposed at round 3)*: in a non-Siamese simple valid six-coloured fragment on a closed disc of radius at least √3 about a vertex p of at least four colours whose ring carries no arc of Γ, labelled as FS116-Y3-TIPS, the edges of p are δ_1 = 90°, δ_2 = 150°, δ_3 = 270°, δ_4 = −30° (FS116-N2-HEX3's star); 3 is an outer colour of y_0 and of y_4, and 4 of y_1 and of y_3; each of these four hubs has that outer colour alone or two outer tiles, counter-clockwise 2, 3 at y_0; 4, 2 at y_1; 1, 4 at y_3; 3, 1 at y_4; and near q_1, q_5 the lens points carry colour 2, near q_2, q_4 colour 1 *Not claimed:* that any such fragment exists, at any radius; anything below radius √3; anything in the Siamese or non-simple class; anything at k ≥ 7

## 13. Added at round 4, the semi-hub rule (frozen by Keryx, 2026-10-03 15:25 UTC; statements verbatim from their proposing record, with their *not claimed* lines, and that record's notation paragraph verbatim beside them)

*The setting words* (the proposing record's header, its paragraph **Notation**, verbatim; the record says of the statements: "Each is stated in this record's setting words (§ Notation); "lies on a (Q) arc" and the germs are RING-GERM's"):

> **Notation** (FS116-N1's and FS116-N2's headers; nothing new is meant but the words marked *new*). `p` a vertex, `ω(z)` the unit circle about `z`, `e(θ)` the unit vector at angle `θ`, `r(θ) = p + e(θ)`; `C(z)` the colours of the tiles whose closure holds `z`, `P = C(p)`, `A(z)` the colours absent at `z` (six in all). **N-E1**: an interior point of a tile of colour `c` is at distance 1 from no point of the closure of a tile of colour `c`. **Non-Siamese**: distinct tiles of one colour have all cross-distances at least 1; so at a point at most one tile of each colour. **Simple**: § 0's; a tile's cone at a vertex is one closed interval of directions (possibly a single direction, a cusp). A tile has diameter at most 1. A **change point** `y = r(ψ)` of `p`'s ring has the ring off `Γ` on both sides (reading L, the list's § 10), colour `X̄` just clockwise (tile `R′`) and `X` just counter-clockwise (tile `R`); `u = r(ψ + 60°)`, `v = r(ψ − 60°)`; the **germs** `u⁻, u⁺, v⁻, v⁺` and "a germ lies on a (Q) arc" are RING-GERM's. A **tip** at `y` is a tile of `p` whose closure holds `y`; an **outer tile** a tile of a colour of `p` that is not a tile of `p`; `T_y`, `O_y` their colours (FS116-N2-STAR). *New:* the **tip pair** is `{v⁻, u⁺}` and the **outer pair** `{u⁻, v⁺}` (the pairs RING-GERM (i) and (ii) read). `y` is a **hub** when its four germs lie on no (Q) arc (FS116-N2's word), a **semi-hub** when exactly one of the two pairs has both its germs on no (Q) arc — **of kind O** when that pair is the outer pair, **of kind T** when it is the tip pair — and **closed** when neither pair does. A semi-hub is **full** when both germs of its other pair lie on (Q) arcs; a full semi-hub is **crossed** when those two (Q) arcs' colour pairs are disjoint and **parallel** when they are equal (by FS114-N7-QOPP each (Q) arc's colours are those of two opposite tiles of `p`, so the pairs are disjoint or equal). In the arguments `ψ = 0°` and angles at `y` are measured from `e(0°)`, the direction away from `p`.

*Notes (this list):*
- "reading L, the list's § 10": the coordinator's name for the reading of § 0's "change point" that the paragraph states in the same sentence (the ring off `Γ` on both sides), under which § 10's statements were checked; § 10 itself does not carry the name.
- The **inner colour** and **outer colour** of an arc of `ω(z)` are the colours of the tiles on its side toward `z` and on the far side (the sense of "inner" and "outer side colour" in § 0's (R2)).
- The paragraph's parenthetical cites FS114-N7-QOPP, held at one mind (`LEDGER.md` § B: "hand; one mind: N7"), whose statement opens, verbatim: "(N7-QOPP) Every (Q) arc of a four-colour degree-4 vertex joins opposite tiles (inner `t_i`, outer colour `c_{i+2}`); the other two tiles' colours are absent along it". It is stated for a degree-4 vertex. Wherever a statement below needs the dichotomy crossed-or-parallel, the dichotomy is part of what is checked, not given.

- **FS116-N3-SEMI** *(proposed at round 4)*: in a non-Siamese simple valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, let y = r(ψ) be a semi-hub of the ring of p; then y is a vertex of at least four colours, or y is a vertex of exactly three colours one of whose edges at y is an arc of the unit circle about r(ψ + 60°) or about r(ψ − 60°) whose two side colours are both carried at that centre, which is then a vertex of at least four colours, or y is a full parallel semi-hub of exactly three colours — the two absent at p and the colour of the tile of p whose cone holds ψ + 180° (kind O) or ψ (kind T) in its interior. *Not claimed:* that a semi-hub has four colours; that the third alternative occurs, or that it is excluded; anything at a closed change point (the disk's corner); Siamese or non-simple fragments; anything at `k ≥ 7`.
- **FS116-N3-PAIR** *(proposed at round 4)*: in a non-Siamese simple valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, if both germs of one pair at a change point of the ring lie on (Q) arcs and the two arcs have the same pair of colours, then the inner colour of each is the outer colour of the other. *Not claimed:* anything about two (Q) arcs not at one pair's germs.
- **FS116-N3-CROSS** *(proposed at round 4)*: in a non-Siamese simple valid fragment on a closed disc of radius above 2 about a vertex p of at least four colours, let y = r(ψ) be a crossed full semi-hub of kind O of the ring of p, u⁺ on a (Q) arc of inner colour a and outer colour a′ and v⁻ on one of inner colour b and outer colour b′; then every tile of p at y has a cone at y of zero angle, and the outer colours at y lie in {a′, b′}; if y has four colours and every tile at y a cone of positive angle at y, its outer colours are a′ and b′ and its missing pair is {a, b}, and, unless an edge of p runs along ω(y) at p, p is a change point of the ring of y, that ring being b just counter-clockwise of p and a just clockwise, and p is a semi-hub of kind O of the ring of y. *Not claimed:* that y has four colours; that p is a crossed semi-hub of y's ring; anything about y's ring away from p; anything at `k ≥ 7`.

## 14. Added at round 4, the setting of § 12's last three statements (frozen by Keryx, 2026-10-03 15:35 UTC; the setting verbatim from the proposing record, copied by the Clerk and vetted by Keryx, with two of that record's statements added so that the labels they fix are checked, not given)

*Statements added (verbatim from the proposing record's entries, with their *not claimed* lines). § 12's FS116-Y3-NBTIP, -TIGHTLENS and -STARFORCE use their setting ("FS116-Y3-TIPS's setting", "labelled as FS116-Y3-TIPS").*

- **FS116-Y3-SIX** *(proposed at round 3)*: in a non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours whose ring carries no arc of Γ, the ring has exactly six change points, 60° apart, each a hub, and p has exactly four tiles *Not claimed:* anything in the Siamese class (there RING-GERM's tip is GERM-S's tile, not necessarily a tile of p, and the count is not run); anything at k ≥ 7 (SQ9 at k = 9 has twelve); that any such fragment exists
- **FS116-Y3-TIPS** *(proposed at round 3)*: in FS116-Y3-SIX's setting, with the hubs y_k = e(60k), each hub has exactly one tip, the tips of antipodal hubs are opposite tiles of p, and up to rotation of the labels the four tiles of p, counter-clockwise, are T1 tipping y_0 and y_1 (cone at p in [−30°, 90°]), T3 tipping y_2 (in [30°, 210°]), T2 tipping y_3 and y_4 (in [150°, 270°]) and T4 tipping y_5 (in [210°, 30°]) *Not claimed:* anything in the Siamese or non-simple class; that the cones fill their ranges (each δ is free in its interval); that any such fragment exists

*The setting words* (verbatim, from the proposing record unless marked; a line break in the source is a space here):

- Hub, tip, outer tile, Γ-free (the record's header paragraph *Notation*): "A **hub** of `p` (N2's) is a change point of `p`'s ring whose four germs at `±60°` lie on no (Q) arc; a **tip** at a ring point `y` is a tile of `p` whose closure holds `y`; an **outer tile** at `y` is a tile of a colour of `p` that is not a tile of `p`. *New:* a ring is **Γ-free** when no arc of `Γ` lies on it (`Γ ∩ ω(p)` finite)."
- The hubs and the ring's two colours (the record, after FS116-Y3-SIX's argument): "Rotating, the hubs are `y_k = e(60k)` (`p` at the origin), and the ring is `X` on `(0°, 60°)`, `(120°, 180°)`, `(240°, 300°)` and `X̄` on the other three arcs (the names `X`, `X̄` chosen so)."
- The tiles, their colours, the edges `δ_i` and their ranges (the record, after FS116-Y3-TIPS's argument): "So, naming the tiles by role — **`T1`** tips `y_0, y_1` (cone `[δ_4, δ_1] ⊂ [−30°, 90°]`), **`T3`** tips `y_2` (`[δ_1, δ_2] ⊂ [30°, 210°]`), **`T2`** tips `y_3, y_4` (`[δ_2, δ_3] ⊂ [150°, 270°]`), **`T4`** tips `y_5` (`[δ_3, δ_4] ⊂ [210°, 30°]`), counter-clockwise, with `δ_1 ∈ [30°, 90°]`, `δ_2 ∈ [150°, 210°]`, `δ_3 ∈ [210°, 270°]`, `δ_4 ∈ [−30°, 30°]` — and their colours `1, 3, 2, 4`."
- Lens, far vertex, ring tile, tight lens (the record, opening its third stage; the sentence is cut at its colon, the rest being a claim): "`q_k = y_k + y_{k+1} = √3·e(60k + 30°)`; the **lens** `L_k` is `B̄(y_k, 1) ∩ B̄(y_{k+1}, 1)` outside `B(p, 1)`, with far vertex `q_k`; `R_{k,k+1}` is the ring tile over the arc from `y_k` to `y_{k+1}`. The lenses `L_1, L_2, L_4, L_5` — beside the single tips — are the **tight lenses**"
- Generic star, boundary value (the same paragraph; cut where the sentence goes on to a claim): "The **star** is generic when every `δ_i` is interior to its range; a **boundary value** of `δ_i` is an endpoint of its range"
- Tight at `p` (the same sentence's defining clause, quoted alone; the claim before it, about which values are such edges, is cut): "an edge of `p` along a flanking direction `60k ± 90°` of some hub, with that hub's tip on its side — the tip **tight at `p`** for that hub"
- Flanking direction (FS116-N2's record header, which the proposing record cites for it): "for a hub `y = r(ψ)` the **flanking directions** are `ψ ± 90°` at `p`"

*Notes (this list):*
- The second and third passages restate conclusions of FS116-Y3-SIX and -TIPS as labels. Their names are the setting; that the hubs, the ring's colours, the tiles and the ranges are as they say is part of checking SIX and TIPS. "Its range", in the statements, is the interval the third passage gives for `δ_i`.
- **Double tips** are `T1` and `T2` (each tips two hubs) and **single tips** `T3` and `T4` (each tips one): the record's usage, from the third passage. A **lens beside a single tip** is one of `L_1`, `L_2`, `L_4`, `L_5` (the fourth passage). An **outer colour** of a hub is the colour of an outer tile at it (§ 13's `O_y`).
- Two phrases have no definition in the record, and a verifier states its reading of each: STARFORCE's "the lens points" ("near q_1, q_5 the lens points carry colour 2"), and the order "counter-clockwise 2, 3 at y_0" of two outer tiles about a hub.
- `X`, `X̄`, the germs and "change point" are as in §§ 0, 10 and 13.

## 15. Added at round 4, the construction side's statement (frozen by Keryx, 2026-10-03 17:03 UTC; the statement verbatim from its proposing record, with its *not claimed* line, one parenthetical of that line withheld for blindness)

*Its setting words are § 0's. (This list:) the proposing record's *not claimed* line ends with a parenthetical after "anything at k ≥ 7" that names a step of its argument; it is withheld here until the close, and the rest of the line is verbatim.*

- **FS116-Y4-EMPTY** *(proposed at round 4)*: no non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours has a ring carrying no arc of Γ *Not claimed:* anything for rings carrying an arc of Γ that is not a (Q) arc (the (Q)-free rings of FS114-N6-RING60 after the bends, with (R2) arcs); anything in the Siamese or non-simple class; anything at k ≥ 7

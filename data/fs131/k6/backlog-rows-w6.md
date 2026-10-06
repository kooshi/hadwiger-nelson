### 25. FS111-M-HALF
<!--row FS111-M-HALF plans/FS111-derivation.md:555-->
**Address** `plans/FS111-derivation.md:555` · **Role** upstream · **Era** R · **Was** 26 in `lean-order.md` · **Upstream ids** FS111-C-HULL
<!--needs FS111-M-HALF: FS111-C-HULL-->

<!--q FS111-M-HALF statement-->
**Statement as filed:**
> at a point x saturated for j, every path-connected piece of S̃_j with x in its closure lies in a closed half-plane in every blow-up at x, so has upper density at most 1/2 at x: no colour takes a reflex angle at a saturated point

<!--q FS111-M-HALF not_claimed-->
**Not claimed:**
> that the pieces' blow-ups are sectors (a cone structure at x is REG-J′'s content)

<!--q FS111-M-HALF grade-->
**Grade as filed:**
> derived from: FS111-C-HULL

<!--q FS111-M-HALF minds-->
**Minds as filed:**
> 1 — FS111-M

<!--q FS111-M-HALF handoff-->
**Handoff as filed:**
> none — a structural lemma toward REG-J′

### 26. FS111-M-PINCH
<!--row FS111-M-PINCH plans/FS111-derivation.md:435-->
**Address** `plans/FS111-derivation.md:435` · **Role** SEED · **Era** R · **Was** 28 in `lean-order.md` · **Upstream ids** FS111-C-HULL, FS111-V0-ID1
<!--needs FS111-M-PINCH: FS111-C-HULL,FS111-V0-ID1-->

<!--q FS111-M-PINCH statement-->
**Statement as filed:**
> at a saturated point x of an honest a.e.-proper colouring with a neighbourhood N in which only two colours a, b have positive measure and each is a.e. one connected open set of density points (H1, H2): either N is split by one unit circle T₁(y) with a inside and b outside or the reverse, y a contact of both colours, or two open unit discs tangent at x from opposite sides lie a.e. in S_a and in S_b; the case (in, in) is impossible; no positive density of the partner is needed

<!--q FS111-M-PINCH not_claimed-->
**Not claimed:**
> the same without (H1) or (H2) (C-HULL-REG as stated is a GAP there); anything at points of the singular set Σ

<!--q FS111-M-PINCH grade-->
**Grade as filed:**
> derived from: FS111-C-HULL

<!--q FS111-M-PINCH minds-->
**Minds as filed:**
> 3 — blind to: each other's records (M and W, competitors; VMW before 3ea1d5ab); method: M by M-HULL1 at density points (no partner density); W with H-DEN applying C-HULL at the partner itself; VMW with one-sidedness (H2′) — its stage-1 GAP at cusp partners withdrawn on reading M's Step 1

<!--q FS111-M-PINCH handoff-->
**Handoff as filed:**
> de Bruijn — queued behind the measurable chain: the central lemma of route M, with (H1), (H2) stated and its not-claimed line kept

<!--q FS111-M-PINCH note@455-->
**dated note filed under the entry (`plans/FS111-derivation.md:455`):**
> *Erratum (2026-10-03, FS129-Z1, from `plans/FS129-SR3-audit.md` § 4.1, row FS111 l. 442; `plans/FS129-close-inventory.md` items 129, 130):* the not-claimed form "the same without (H1) or (H2) (C-HULL-REG as stated is a GAP there); anything at points of the singular set Σ" is false as a general form: FS111-M-EXTREME (this file) shows the conclusion fails at the extreme points of every component of an honest saturated colouring, each a cusp or a point where (H1) or (H2) fails, and FS111-M-R7 is such a colouring (its up-vertices are M-EXTREME's model). What does hold at Σ, under REG-J′, is FS121-DB1-L3 (no colour occupies two sectors of positive angle; `plans/FS121-derivation.md`). The statement is untouched: the false form is a not-claimed one.

### 27. FS111-M-C11
<!--row FS111-M-C11 plans/FS111-derivation.md:457-->
**Address** `plans/FS111-derivation.md:457` · **Role** SEED · **Era** R · **Was** 30 in `lean-order.md` · **Upstream ids** FS111-M-PINCH
<!--needs FS111-M-C11: FS111-M-PINCH-->

<!--q FS111-M-C11 statement-->
**Statement as filed:**
> if M-PINCH's hypotheses hold at every essential boundary point in N, then ∂_e S_a ∩ N′ (N′ ⋐ N) is a C^{1,1} curve with curvature in [−1, 1] and unit-parallel partners on both sides; a single unit arc if any of its points is of the split type

<!--q FS111-M-C11 not_claimed-->
**Not claimed:**
> that the curve is a segment or a circular arc (REG-A's missing rung, FS111-M2-INTRAD under REG-J′); "curvature 1 exactly on arcs of kind both" (W-CURV's "exactly", not derived)

<!--q FS111-M-C11 grade-->
**Grade as filed:**
> derived from: FS111-M-PINCH

<!--q FS111-M-C11 minds-->
**Minds as filed:**
> 3 — blind to: each other's records, as FS111-M-PINCH; method: M from PINCH; W as W-C11 with H-DEN; VMW as VMW-HULL

<!--q FS111-M-C11 handoff-->
**Handoff as filed:**
> de Bruijn — with FS111-M-PINCH; the rolling-ball step would need its own formal proof or a Mathlib source

### 30. FS111-M2-HULLC
<!--row FS111-M2-HULLC plans/FS111-derivation.md:913-->
**Address** `plans/FS111-derivation.md:913` · **Role** SEED · **Era** R · **Was** 37 in `lean-order.md` · **Upstream ids** FS111-C-HULL, FS111-M-PINCH, FS111-M2-FIX
<!--needs FS111-M2-HULLC: FS111-C-HULL,FS111-M-PINCH,FS111-M2-FIX-->

<!--q FS111-M2-HULLC statement-->
**Statement as filed:**
> in a maximal cover with regular classes, every component of int F_j lies inside or outside every unit circle centred at a point of F_j and has an exterior ball of radius 1 at every boundary point; where the boundary is a graph it is semiconcave with constant 1; each component has finite perimeter; near any point int F ∩ B(x, r) = B(x, r) ∖ ⋃_{p ∈ F_x} T₁(p), and where F_x has finitely many components the boundary lies on the unit parallels (outer and far) of the class's own components; on the pinch set of two classes FS111-M-PINCH and FS111-M-C11 hold verbatim

<!--q FS111-M2-HULLC not_claimed-->
**Not claimed:**
> semiconvexity with constant 1 (FALSE: DISC7, curvature 2); the unit-parallel description without "F_x has finitely many components"

<!--q FS111-M2-HULLC grade-->
**Grade as filed:**
> derived from: FS111-M2-FIX, FS111-C-HULL

<!--q FS111-M2-HULLC minds-->
**Minds as filed:**
> 2 — blind to: M2's record until VM2's verdicts were committed; method: VM2-HULLC (exterior radius 1 per component; M2 used 1/2 for the perimeter argument); VM2 restored the dropped hypothesis of (iv)

<!--q FS111-M2-HULLC handoff-->
**Handoff as filed:**
> de Bruijn — queued behind the measurable chain; the finite-perimeter step needs Federer 4.5.11 or a Mathlib substitute

<!--q FS111-M2-HULLC merge@SR2-4.3-17-->
**Merge note — replaced in whole or in the part the line names** (SR2-4.3 item 17, `plans/FS129-SR2-audit.md:480-480`; status applied):
> 17. **FS111-M-COVER-SC's semiconcavity** (every maximal cover) in place of **FS111-M2-HULLC's semiconcave clause** (regular classes).

### 34. FS111-W-KB-DIR
<!--row FS111-W-KB-DIR plans/FS111-derivation.md:683-->
**Address** `plans/FS111-derivation.md:683` · **Role** upstream · **Era** R · **Was** 41 in `lean-order.md` · **Upstream ids** FS111-M-PINCH
<!--needs FS111-W-KB-DIR: FS111-M-PINCH-->

<!--q FS111-W-KB-DIR statement-->
**Statement as filed:**
> at the centre of a unit arc of kind both in a saturated colouring, the inner colour's sector points toward the arc

<!--q FS111-W-KB-DIR not_claimed-->
**Not claimed:**
> anything at an arc of kind in or out

<!--q FS111-W-KB-DIR grade-->
**Grade as filed:**
> derived from: FS111-M-PINCH

<!--q FS111-W-KB-DIR minds-->
**Minds as filed:**
> 1 — FS111-W

<!--q FS111-W-KB-DIR handoff-->
**Handoff as filed:**
> none — a local rule for saturated maps

### 35. FS111-W-NOBEND
<!--row FS111-W-NOBEND plans/FS111-derivation.md:473-->
**Address** `plans/FS111-derivation.md:473` · **Role** upstream · **Era** R · **Was** 42 in `lean-order.md` · **Upstream ids** FS111-M-C11
<!--needs FS111-W-NOBEND: FS111-M-C11-->

<!--q FS111-W-NOBEND statement-->
**Statement as filed:**
> a saturated two-colour interface under (H1), (H2) has no bend (corner), and its curvature is at most 1

<!--q FS111-W-NOBEND not_claimed-->
**Not claimed:**
> that curvature equals 1 only on arcs of kind both (a case-(i) unit arc about an a-contact with b inside is locally consistent)

<!--q FS111-W-NOBEND grade-->
**Grade as filed:**
> derived from: FS111-M-C11

<!--q FS111-W-NOBEND minds-->
**Minds as filed:**
> 2 — blind to: W's record until VMW's verdicts were committed; method: W as corollaries of W-C11, VMW from the common form

<!--q FS111-W-NOBEND handoff-->
**Handoff as filed:**
> none — a corollary; it crosses with FS111-M-C11

### 36. FS111-W-NOREP
<!--row FS111-W-NOREP plans/FS111-derivation.md:487-->
**Address** `plans/FS111-derivation.md:487` · **Role** upstream · **Era** R · **Was** 43 in `lean-order.md` · **Upstream ids** FS111-M-C11, FS111-W-KB-DIR
<!--needs FS111-W-NOREP: FS111-M-C11,FS111-W-KB-DIR-->

<!--q FS111-W-NOREP statement-->
**Statement as filed:**
> at a cone vertex of a saturated map without cusps, no colour occupies two sectors

<!--q FS111-W-NOREP not_claimed-->
**Not claimed:**
> the same for general saturated colourings (GAP: (H2) at the partners is not among C11's hypotheses there)

<!--q FS111-W-NOREP grade-->
**Grade as filed:**
> derived from: FS111-M-C11

<!--q FS111-W-NOREP minds-->
**Minds as filed:**
> 1 — FS111-W (read sighted by VMW, who scoped it to maps)

<!--q FS111-W-NOREP handoff-->
**Handoff as filed:**
> none — a lemma inside FS111-W-HULLREG-MAPS; it crosses with it

<!--q FS111-W-NOREP note@501-->
**dated note filed under the entry (`plans/FS111-derivation.md:501`):**
> *Correction (2026-10-03, FS-121's close; FS121-DB1 § 3.3 item 2, one mind):* the argument's two cases (`plans/FS111-W-wild.md` § 2.3) do not cover an edge that is a unit arc whose centre carries the repeated colour on the far side of the edge from the sector, where case (i)'s parallel collapses to a point. The statement stands through FS121-DB1-L3's case K+ (`plans/FS121-derivation.md` FS121-DB1-L3, two minds), which also localises it to a point of Σ with cusps allowed.

<!--q FS111-W-NOREP note@503-->
**dated note filed under the entry (`plans/FS111-derivation.md:503`):**
> *Erratum (2026-10-03, FS129-Z1, from `plans/FS129-SR2-audit.md` § 4.1, row 43; `plans/FS129-close-inventory.md` item 117):* the not-claimed line's GAP ("the same for general saturated colourings (GAP: (H2) at the partners is not among C11's hypotheses there)") is answered for honest saturated colourings in D-NF satisfying REG-J′ by FS121-DB1-L3 ("at every point of Σ no colour occupies two sectors of positive angle, whatever cusps are present at the point or elsewhere", two minds); what is left open is saturated colourings that are not honest or do not satisfy REG-J′. FS121-DB1-L3 is formalized in this entry's place (SR2 § 4.3 item 22).

<!--q FS111-W-NOREP merge@SR2-4.3-22-->
**Merge note — replaced in whole or in the part the line names** (SR2-4.3 item 22, `plans/FS129-SR2-audit.md:487-487`; status applied):
> 22. **FS121-DB1-L3** in place of **FS111-W-NOREP**.

### 38. FS111-M2-INTRAD
<!--row FS111-M2-INTRAD plans/FS111-derivation.md:1013-->
**Address** `plans/FS111-derivation.md:1013` · **Role** SEED · **Era** R · **Was** 45 in `lean-order.md` · **Upstream ids** FS111-M-C11, FS111-W-SQ9
<!--needs FS111-M2-INTRAD: FS111-M-C11,FS111-W-SQ9-->

<!--q FS111-M2-INTRAD statement-->
**Statement as filed:**
> in an honest saturated colouring whose singular set Σ is locally finite with finitely many interface arcs at each point (REG-J′), the unit parallel of every tangent-type interface arc is again an interface arc, so radii of curvature drop by exactly 1 toward the centre and stop at 1: every interface has integer radius of curvature almost everywhere and is locally a chain of segments and circular arcs, finitely many of each radius

<!--q FS111-M2-INTRAD not_claimed-->
**Not claimed:**
> exclusion of large-radius accumulation (radii → ∞: LRA, FS-115's stuck ray); the statement without REG-J′'s finitely-many-arcs clause

<!--q FS111-M2-INTRAD grade-->
**Grade as filed:**
> derived from: FS111-M-C11

<!--q FS111-M2-INTRAD minds-->
**Minds as filed:**
> 2 — blind to: M2's record until VM2's verdicts were committed; method: (i)–(ii) by two routes; (iii) completed by VM2 alone (VM2-FIN′, one mind), M2's convexity outline having a gap on E_n ∖ E_{n,p}

<!--q FS111-M2-INTRAD handoff-->
**Handoff as filed:**
> de Bruijn — queued behind FS111-M-PINCH and FS111-M-C11: the link between route M and FS-115

### 101. FS116-O1-SATPIN
<!--row FS116-O1-SATPIN plans/FS116-derivation.md:54-->
**Address** `plans/FS116-derivation.md:54` · **Role** SEED · **Era** R · **Was** 114 in `lean-order.md` · **Upstream ids** FS111-M-C11, FS111-M-PINCH
<!--needs FS116-O1-SATPIN: FS111-M-C11,FS111-M-PINCH-->

<!--q FS116-O1-SATPIN statement-->
**Statement as filed:**
> let p be a vertex of at least four colours of a valid k-coloured fragment saturated on a disc about p, every tile at p with a cone of positive angle; each edge e at p (a boundary arc between tiles of two different colours), with side colours a (clockwise) and b (counter-clockwise) and unit normal ν pointing to b's side, is near p of at least one of two types — (split) an arc of the unit circle about a point y of ω(p) at which both a and b have support, a unit arc of kind both; or (tangent) a segment or an arc of radius at least 1 along which every x has x + ν(x) in the closure of colour a and x − ν(x) in the closure of colour b, so that p + ν(p) carries a and p − ν(p) carries b, two antipodal points of ω(p) on the normal to e at p; and every colour of p is carried on ω(p)

<!--q FS116-O1-SATPIN not_claimed-->
**Not claimed:**
> anything at a cusp at p; that the split centre y has four colours (FS112-N3-NOBOTH gives four colours or a repeated colour, and FS111-W-NOREP removes the repeat only on cusp-free saturated maps); that any saturated valid six-coloured fragment about a four-colour vertex exists; that the strip's midline configuration is excluded in the class (SAT-STRIP, the claim list); saturation of any held six-colour positive

<!--q FS116-O1-SATPIN grade-->
**Grade as filed:**
> derived from: FS111-M-PINCH, FS111-M-C11

<!--q FS116-O1-SATPIN minds-->
**Minds as filed:**
> 2 — blind to: the first derivation until 3daaa05c, not to FS111-M-PINCH's case split, which both routes use (item 31's ruling); method: V1's L1–L4, a connected-product interval per contact, the last clause through the edges, against saturation at p (V1 § 4.2); the same model (Opus 5.5), one prior

<!--q FS116-O1-SATPIN handoff-->
**Handoff as filed:**
> de Bruijn — with FS111-M-PINCH and FS111-M-C11, queued behind the measurable chain: the statement, its cusp exclusion, and the inner-disc reading of saturation for fragments

### 102. FS116-N1-AXIS
<!--row FS116-N1-AXIS plans/FS116-derivation.md:571-->
**Address** `plans/FS116-derivation.md:571` · **Role** SEED · **Era** R · **Was** 115 in `lean-order.md` · **Upstream ids** FS116-N1-GERM-R, FS116-N1-GERM-S, FS116-O1-SATPIN
<!--needs FS116-N1-AXIS: FS116-N1-GERM-R,FS116-N1-GERM-S,FS116-O1-SATPIN-->

<!--q FS116-N1-AXIS statement-->
**Statement as filed:**
> let p be a degree-4 vertex of four colours of a valid fragment on a closed disc of radius above 1 about p, saturated on a disc about p, whose four edges are segments along the four half-axes, with tiles coloured c_I, c_II, c_III, c_IV by quadrant and absent colours X, X̄; then at q_N = p + (0, 1): (a) every tile approaching q_N along a direction below the horizontal has colour X or X̄; (b) a tile of colour c_IV approaches q_N along 0⁺ and one of colour c_III along 180⁻, both above the line y = 1; (c) the arcs of ω(p) just counter-clockwise of r(30°) and just clockwise of r(150°) lie on no (Q) arc; (d) if the arcs just clockwise of r(30°) and just counter-clockwise of r(150°) lie on no (Q) arc, every tile approaching q_N along a direction below the horizontal has one colour, and q_N is not a change point; and at each of the axis points q_E, q_W, q_S, read with the quadrants turned with it

<!--q FS116-N1-AXIS not_claimed-->
**Not claimed:**
> anything for four segments not at right angles; anything at k ≥ 7 for (d) (at k = 9 SQ9 fails it); that the axis points are touch points in any fragment saturated on B̄(p, 1); SAT-STRIP

<!--q FS116-N1-AXIS grade-->
**Grade as filed:**
> derived from: FS116-N1-GERM-R

<!--q FS116-N1-AXIS minds-->
**Minds as filed:**
> 2 — blind to: N1's record until 7245b6eb; method: N-E2 for (a) and saturation's definition for (b), so V3's (b) does not rest on SATPIN (V3 § 4.2); the same model (Opus 5.5), one prior

<!--q FS116-N1-AXIS handoff-->
**Handoff as filed:**
> de Bruijn — the statement at q_N with the quarter-turn symmetry; queued behind SATPIN and D6's map type

### 118. FS116-S1-RUNG
<!--row FS116-S1-RUNG plans/FS116-derivation.md:856-->
**Address** `plans/FS116-derivation.md:856` · **Role** SEED · **Era** R · **Was** 131 in `lean-order.md` · **Upstream ids** FS116-O1-SATPIN, FS116-S1-CLUSTER
<!--needs FS116-S1-RUNG: FS116-O1-SATPIN,FS116-S1-CLUSTER-->

<!--q FS116-S1-RUNG statement-->
**Statement as filed:**
> let p be a degree-4 vertex of four colours of a valid fragment whose four edges are segments along the four half-axes, with tiles coloured c_I, c_II, c_III, c_IV by quadrant, and suppose the fragment saturated at every point of the east edge's first segment [p, p + (ℓ, 0)], 0 < ℓ ≤ L_E; if a tile of colour c_IV has a point w in its closure with |w − q_N| < 1, q_N = p + (0, 1), then |w − p − (s, 1)| ≤ 1 for every s in [0, ℓ]; and the same at each edge and axis point, turned and reflected with the quadrants; in particular a contact of c_IV at r(φ), 90° < φ < 150°, gives ℓ ≤ cos φ + √(sin φ (2 − sin φ)), which at φ = 120° is FS116-Y1-STRIPCEIL's x* = √(√3 − 3/4) − 1/2

<!--q FS116-S1-RUNG not_claimed-->
**Not claimed:**
> anything at a partner point where the edge is not saturated; anything for edges that are not segments; that a contact exists in quadrant II in any fragment of SAT-STRIP's class (FS116-S1-LENS supplies one where the ring carries no (Q) arc)

<!--q FS116-S1-RUNG grade-->
**Grade as filed:**
> derived from: FS116-O1-SATPIN, FS116-S1-CLUSTER

<!--q FS116-S1-RUNG minds-->
**Minds as filed:**
> 2 — blind to: S1's record until 48534b7c, with item 108's caveat; method: FS116-V4-PARTNER (saturation at the edge point) against SATPIN's tangent clause, FS116-V4-MEET against CLUSTER; the same model (Opus 5.5), one prior

<!--q FS116-S1-RUNG handoff-->
**Handoff as filed:**
> de Bruijn — with SATPIN; a rung-and-contact lemma

### 123. FS116-V4-PARTNER
<!--row FS116-V4-PARTNER plans/FS116-derivation.md:1020-->
**Address** `plans/FS116-derivation.md:1020` · **Role** upstream ROUTE-ONLY · **Era** R · **Was** 136 in `lean-order.md` · **Upstream ids** FS116-V4-DICHOTOMY
<!--needs FS116-V4-PARTNER: FS116-V4-DICHOTOMY-->

<!--q FS116-V4-PARTNER statement-->
**Statement as filed:**
> let x be an interior point of a segment edge of a valid k-coloured fragment from a point p, of direction u and first-segment length L, with tile T_a on its clockwise side and T_b on its counter-clockwise side, and ν = u turned by +90°; if the fragment is saturated at x, then x + ν lies in the closure of a tile of T_a's colour and x − ν in the closure of a tile of T_b's colour, and every tile of T_a's colour other than T_a whose closure meets ω(x) is far from T_a (⊥)

<!--q FS116-V4-PARTNER not_claimed-->
**Not claimed:**
> anything when the edge is curved; anything at p itself or at the segment's far end (closure gives those points of supp only)

<!--q FS116-V4-PARTNER grade-->
**Grade as filed:**
> hand

<!--q FS116-V4-PARTNER minds-->
**Minds as filed:**
> 1

<!--q FS116-V4-PARTNER handoff-->
**Handoff as filed:**
> none — RUNG and QF rest on it

### 125. FS116-S1-KAPPA
<!--row FS116-S1-KAPPA plans/FS116-derivation.md:795-->
**Address** `plans/FS116-derivation.md:795` · **Role** SEED · **Era** R · **Was** 138 in `lean-order.md` · **Upstream ids** FS116-V4-CHORD, FS116-V4-DICHOTOMY, FS116-V4-MEET, FS116-V4-OUTER, FS116-V4-PARTNER, FS116-V4-TWIST
<!--needs FS116-S1-KAPPA: FS116-V4-CHORD,FS116-V4-DICHOTOMY,FS116-V4-MEET,FS116-V4-OUTER,FS116-V4-PARTNER,FS116-V4-TWIST-->

<!--q FS116-S1-KAPPA statement-->
**Statement as filed:**
> at a vertex p of four colours and no more of a valid fragment on a closed disc of radius above 1 about p, Siamese pairs allowed, whose ring carries no (Q) arc, every germ of ω(p) (an arc just clockwise or just counter-clockwise of a ring point) lies in the closure of tiles of exactly one of the two colours absent at p, κ, and the germ 60° on carries the other; so κ's change points form a finite non-empty set invariant under the rotation by 60° about p, each half-open 60° window of ω(p) holds an odd number of them, and antipodal germs carry different colours; in a non-Siamese fragment κ's change points are exactly y + 60°ℤ for one ring point y

<!--q FS116-S1-KAPPA not_claimed-->
**Not claimed:**
> anything when the ring carries a (Q) arc; anything at k ≥ 7 (at k = 9 SQ9's r(45°) and r(225°) carry one colour); that any vertex of the class exists at six colours

<!--q FS116-S1-KAPPA grade-->
**Grade as filed:**
> hand

<!--q FS116-S1-KAPPA minds-->
**Minds as filed:**
> 2 — blind to: S1's record until V4's verdicts (48534b7c), told by its brief that a decided result rests on it (items 107, 108); method: three ring points and FS116-V4-DICHOTOMY against N-E1 at w (V4, Divergences on KAPPA row 1); the same model (Opus 5.5), one prior

<!--q FS116-S1-KAPPA handoff-->
**Handoff as filed:**
> de Bruijn — with N-E1 and the germ convention; queued behind D6's map type

<!--q FS116-S1-KAPPA note@818-->
**dated note filed under the entry (`plans/FS116-derivation.md:818`):**
> *Erratum (2026-10-03, FS129-Z1, from `plans/FS129-SR3-audit.md` § 4.1, row FS116 l. 816; `plans/FS129-close-inventory.md` items 129, 130):* the last clause's class — non-Siamese, six colours, a vertex of four colours, a ring with no (Q) arc, radius above 1 — is empty by FS129-SR3-QFREE-NS (derived, one mind; `plans/FS129-derivation.md`), which FS129-OR1-QFREE did not reach (this entry assumes no simplicity); the GAP at whether an orbit point can end an arc of Γ on ω(p) is moot. The clause stands as a step of FS116-S1-QF's second route only.

<!--q FS116-S1-KAPPA merge@SR3-5.1-23-->
**Merge note — named** (SR3-5.1 item 23, `plans/FS129-SR3-audit.md:395-397`; status applied):
> 23. **FS129-SR3-QFREE-NS** in place of **FS129-OR1-QFREE** and **FS116-S1-QF** — S1-QF is its direct case (non-Siamese, six colours, a four-colour vertex, a (Q)-free ring; no "simple at `p`" step needed); S1-QF's own route (S1-LENS, S1-EXIT, S1-CLUSTER; V4-OUTER, S1-KAPPA's last clause) is a second route. This replaces SR2's item 19 (FS129-OR1-QFREE in place of S1-QF).

<!--q FS116-S1-KAPPA merge@SR3-5.1-DNF-2-->
**Merge note — do not formalize as stated** (SR3-5.1 item DNF-2, `plans/FS129-SR3-audit.md:410-411`; status applied):
> - **FS116-S1-KAPPA's last clause** except as a step of S1-QF's second route: its class (non-Siamese, (Q)-free ring) is empty by FS129-SR3-QFREE-NS, and its GAP under reading L is moot.

### 126. FS116-S1-PAIR
<!--row FS116-S1-PAIR plans/FS116-derivation.md:820-->
**Address** `plans/FS116-derivation.md:820` · **Role** SEED · **Era** R · **Was** 139 in `lean-order.md` · **Upstream ids** FS116-S1-KAPPA
<!--needs FS116-S1-PAIR: FS116-S1-KAPPA-->

<!--q FS116-S1-PAIR statement-->
**Statement as filed:**
> in a valid fragment as in FS116-S1-KAPPA, let z be a point with 0 < |z − p| < 2, φ its direction from p and α = arccos(|z − p|/2), so that r(φ + α) and r(φ − α) are the ring points at distance 1 from z; if neither φ + α nor φ − α is a change point, no tile of colour κ(φ + α) or κ(φ − α) has z in its closure; in particular where κ(φ + α) ≠ κ(φ − α) only colours of p are carried at z

<!--q FS116-S1-PAIR not_claimed-->
**Not claimed:**
> anything at a point whose ring point is a change point; which colours of p are carried

<!--q FS116-S1-PAIR grade-->
**Grade as filed:**
> derived from: FS116-S1-KAPPA

<!--q FS116-S1-PAIR minds-->
**Minds as filed:**
> 1

<!--q FS116-S1-PAIR handoff-->
**Handoff as filed:**
> de Bruijn — with FS116-S1-KAPPA

### 159. FS121-C1-BOUND
<!--row FS121-C1-BOUND plans/FS121-derivation.md:710-->
**Address** `plans/FS121-derivation.md:710` · **Role** SEED · **Era** R · **Was** 172 in `lean-order.md` · **Upstream ids** none
<!--needs FS121-C1-BOUND: -->

<!--q FS121-C1-BOUND statement-->
**Statement as filed:**
> in a locally finite map colouring, a point x of F_i ∖ S_i is i-bound if and only if it lies on the outer unit parallel or on the far level of a connected component of F_i

<!--q FS121-C1-BOUND not_claimed-->
**Not claimed:**
> which of the two levels; that the component is unique; anything at points of S_i

<!--q FS121-C1-BOUND grade-->
**Grade as filed:**
> hand

<!--q FS121-C1-BOUND minds-->
**Minds as filed:**
> 2 — blind to: FS121-C1's record until V4's verdicts were committed (0dde4982); method: a switch point over the local finiteness of faces (V4-SWITCH, V4-LF), against a two-line perturbation (C1)

<!--q FS121-C1-BOUND handoff-->
**Handoff as filed:**
> de Bruijn — queued behind the measurable chain (FS-113): a short lemma on closed connected sets and one perturbation

### 160. FS121-C1-SAT
<!--row FS121-C1-SAT plans/FS121-derivation.md:751-->
**Address** `plans/FS121-derivation.md:751` · **Role** SEED · **Era** R · **Was** 175 in `lean-order.md` · **Upstream ids** FS121-C1-BOUND
<!--needs FS121-C1-SAT: FS121-C1-BOUND-->

<!--q FS121-C1-SAT statement-->
**Statement as filed:**
> for every k, a locally finite map colouring with k colours whose edges are finite chains of segments and circular arcs, and whose classes form an honest saturated colouring, is a member of 𝒫_k under every total order of its colours; so C121-NOPAR implies that no honest saturated six-colouring is a.e. equal to a locally finite map colouring whose edges are finite chains of segments and circular arcs

<!--q FS121-C1-SAT not_claimed-->
**Not claimed:**
> the converse (a member of 𝒫_k need not be saturated); anything for edges that are not finite chains

<!--q FS121-C1-SAT grade-->
**Grade as filed:**
> derived from: FS121-C1-BOUND

<!--q FS121-C1-SAT minds-->
**Minds as filed:**
> 2 — blind to: FS121-C1's record until 0dde4982; method: the same route (one mind on the method axis)

<!--q FS121-C1-SAT handoff-->
**Handoff as filed:**
> de Bruijn — queued behind FS121-C1-BOUND and the saturated-colouring definitions (FS-113)

### 162. FS121-D2-EXT
<!--row FS121-D2-EXT plans/FS121-derivation.md:607-->
**Address** `plans/FS121-derivation.md:607` · **Role** SEED · **Era** R · **Was** 177 in `lean-order.md` · **Upstream ids** FS111-M-C11, FS111-M2-INTRAD
<!--needs FS121-D2-EXT: FS111-M-C11,FS111-M2-INTRAD-->

<!--q FS121-D2-EXT statement-->
**Statement as filed:**
> in an honest saturated colouring in D-NF satisfying REG-J′, let a be a point of an interface arc, not in Σ, at which the arc passes from a circular piece γ of radius n ≥ 3 and centre z to a piece not on γ's circle, and let L be the normal line at a; then for every integer k with 1 ≤ k ≤ n − 2, and for every integer k ≤ −1, no arc of the circle ∂B(z, n − k) that lies on the far side of L from γ and has an end on L lies in the closure of the interface set

<!--q FS121-D2-EXT not_claimed-->
**Not claimed:**
> anything about a continuation past L along another curve; anything when a is a point of Σ; the unit rung, n − k = 1

<!--q FS121-D2-EXT grade-->
**Grade as filed:**
> hand

<!--q FS121-D2-EXT minds-->
**Minds as filed:**
> 1

<!--q FS121-D2-EXT handoff-->
**Handoff as filed:**
> de Bruijn — queued behind FS111-M-PINCH, FS111-M-C11 and FS111-M2-INTRAD; its geometric core is elementary

### 163. FS121-D2-THIN
<!--row FS121-D2-THIN plans/FS121-derivation.md:632-->
**Address** `plans/FS121-derivation.md:632` · **Role** upstream · **Era** R · **Was** 178 in `lean-order.md` · **Upstream ids** FS111-M2-INTRAD, FS121-D2-EXT
<!--needs FS121-D2-THIN: FS111-M2-INTRAD,FS121-D2-EXT-->

<!--q FS121-D2-THIN statement-->
**Statement as filed:**
> in an honest saturated colouring in D-NF satisfying REG-J′, if interface pieces whose radii tend to infinity accumulate at a point, then for every integer r ≥ 2 the colouring has infinitely many radius-r arcs — maximal arcs of circles of radius r contained in the closure of the interface set — whose angular windows tend to 0

<!--q FS121-D2-THIN not_claimed-->
**Not claimed:**
> that the thin arcs lie in a bounded set; the converse; anything at r = 1; accumulations by segment pieces (the argument takes circular pieces; V5 § 3.3 supplies the segment case at one mind, over M2-INTRAD's per-radius finiteness)

<!--q FS121-D2-THIN grade-->
**Grade as filed:**
> derived from: FS121-D2-EXT

<!--q FS121-D2-THIN minds-->
**Minds as filed:**
> 1

<!--q FS121-D2-THIN handoff-->
**Handoff as filed:**
> none — a necessary condition on an uninhabited class; it crosses with FS121-D2-SYM

### 164. FS121-D3-FALLSAT
<!--row FS121-D3-FALLSAT plans/FS121-derivation.md:498-->
**Address** `plans/FS121-derivation.md:498` · **Role** SEED · **Era** R · **Was** 179 in `lean-order.md` · **Upstream ids** FS111-C-FILL
<!--needs FS121-D3-FALLSAT: FS111-C-FILL-->

<!--q FS121-D3-FALLSAT statement-->
**Statement as filed:**
> every partition of the plane, up to a null set, into k measurable sets each maximal among measurable sets with null unit pairs (a measurable idomatic partition of the unit-distance graph, the classes of a measurable fall colouring) is an honest saturated a.e.-proper k-colouring

<!--q FS121-D3-FALLSAT not_claimed-->
**Not claimed:**
> the converse — a saturated honest colouring need not be idomatic (FS121-D3-SWAP1D); that any idomatic partition exists with fewer than seven classes

<!--q FS121-D3-FALLSAT grade-->
**Grade as filed:**
> hand

<!--q FS121-D3-FALLSAT minds-->
**Minds as filed:**
> 2 — blind to: D3 § 2.1 until dea603eb; method: the same small-ball argument, reached independently (one mind on the method axis)

<!--q FS121-D3-FALLSAT handoff-->
**Handoff as filed:**
> de Bruijn — queued behind the measurable chain (FS-113)

### 166. FS121-C1-GMAP
<!--row FS121-C1-GMAP plans/FS121-derivation.md:732-->
**Address** `plans/FS121-derivation.md:732` · **Role** SEED · **Era** R · **Was** 173 in `lean-order.md` · **Upstream ids** FS121-C1-BOUND, FS121-D3-GRUNDY
<!--needs FS121-C1-GMAP: FS121-C1-BOUND,FS121-D3-GRUNDY-->

<!--q FS121-C1-GMAP statement-->
**Statement as filed:**
> (i) for every k, a Grundy-bound k-colouring that is a.e. equal to a locally finite map colouring makes that map colouring a member of 𝒫_k under the order 1 < 2 < … < k; (ii) G-FIN₆ and C121-NOPAR together imply χ_m⁰(ℝ²) ≥ 7, and given C121-NOPAR, G-FIN₆ holds if and only if χ_m⁰(ℝ²) ≥ 7

<!--q FS121-C1-GMAP not_claimed-->
**Not claimed:**
> G-FIN₆; that a Grundy-bound colouring of a map colouring is again a map colouring

<!--q FS121-C1-GMAP grade-->
**Grade as filed:**
> derived from: FS121-C1-BOUND

<!--q FS121-C1-GMAP minds-->
**Minds as filed:**
> 2 — blind to: FS121-C1's record until 0dde4982; method: the same route (one mind on the method axis), V4 writing out R7's Grundy-boundness

<!--q FS121-C1-GMAP handoff-->
**Handoff as filed:**
> de Bruijn — with FS121-D3-GRUNDY, once map colourings and supports are in Lean

### 168. FS121-DB1-L3
<!--row FS121-DB1-L3 plans/FS121-derivation.md:143-->
**Address** `plans/FS121-derivation.md:143` · **Role** SEED · **Era** R · **Was** 181 in `lean-order.md` · **Upstream ids** FS111-C-HULL, FS111-M-C11, FS111-M-PINCH
<!--needs FS121-DB1-L3: FS111-C-HULL,FS111-M-C11,FS111-M-PINCH-->

<!--q FS121-DB1-L3 statement-->
**Statement as filed:**
> in an honest saturated colouring in D-NF satisfying REG-J′, at every point of Σ no colour occupies two sectors of positive angle, whatever cusps are present at the point or elsewhere

<!--q FS121-DB1-L3 not_claimed-->
**Not claimed:**
> that a colour cannot occupy a sector and a cusp, or two cusps, at one point (the first is FS121-V2-SECTOR); anything without REG-J′

<!--q FS121-DB1-L3 grade-->
**Grade as filed:**
> hand

<!--q FS121-DB1-L3 minds-->
**Minds as filed:**
> 2 — blind to: each other's records (DB1 § 2.3 opened by V2 only after f537b8c9); method: a straddle with a tangent/unit-arc case split and exact cusp checks (DB1), against the component lemma at contacts inherited as limits along the edges (V2)

<!--q FS121-DB1-L3 handoff-->
**Handoff as filed:**
> de Bruijn — queued behind FS111-M-PINCH, FS111-M-C11 and the measurable chain

<!--q FS121-DB1-L3 merge@SR2-4.3-22-->
**Merge note — to formalize** (SR2-4.3 item 22, `plans/FS129-SR2-audit.md:487-487`; status applied):
> 22. **FS121-DB1-L3** in place of **FS111-W-NOREP**.

### 169. FS121-O1-ENDS
<!--row FS121-O1-ENDS plans/FS121-derivation.md:20-->
**Address** `plans/FS121-derivation.md:20` · **Role** SEED · **Era** R · **Was** 183 in `lean-order.md` · **Upstream ids** FS111-C-HULL, FS111-M-HALF, FS111-M-PINCH, FS111-M2-INTRAD, FS111-W-NOREP, FS112-N3-NOBOTH, FS121-DB1-L3
<!--needs FS121-O1-ENDS: FS111-C-HULL,FS111-M-HALF,FS111-M-PINCH,FS111-M2-INTRAD,FS111-W-NOREP,FS112-N3-NOBOTH,FS121-DB1-L3-->

<!--q FS121-O1-ENDS statement-->
**Statement as filed:**
> in an honest saturated colouring in D-NF satisfying REG-J′, the chain of unit parallels of an interface arc of finite radius ends, off a null set of normals, at a unit arc J_1 whose centre z carries J_1's outer colour; either z also carries J_1's inner colour — J_1 is of kind both and z is a vertex with at least four colours or a repeated colour, at least four when no colour at z has density 0, so J_1 is (Q) — or it does not — J_1 is (R2), and z is a point of Σ carrying at least three colours counted by sector — the outer colour and at least two further sectors of positive angle — and at least three distinct colours when no colour at z has density 0

<!--q FS121-O1-ENDS not_claimed-->
**Not claimed:**
> that every chain ends at a (Q) arc; that an (R2) end exists in any saturated colouring; that an (R2) centre has four colours; that the centre has four colours of positive density (FALSE at R7: |P(z)| = 3 with six colours carried)

<!--q FS121-O1-ENDS grade-->
**Grade as filed:**
> hand

<!--q FS121-O1-ENDS minds-->
**Minds as filed:**
> 2 — blind to: FS121-O1's § 3.2–3.4 until its verdicts were committed (43bb6385); method: DB1 reads the local fan REG-J′ gives and counts colours by properness straddles (DB1-L1, L3–L5), O1 transfers NOBOTH and cites W-NOREP

<!--q FS121-O1-ENDS handoff-->
**Handoff as filed:**
> de Bruijn — queued behind FS111-M-PINCH, FS111-M2-INTRAD and the measurable chain (FS-113)

### 170. FS121-O1-OUT
<!--row FS121-O1-OUT plans/FS121-derivation.md:44-->
**Address** `plans/FS121-derivation.md:44` · **Role** SEED · **Era** R · **Was** 191 in `lean-order.md` · **Upstream ids** FS111-M-C11, FS111-M-PINCH, FS111-M2-INTRAD
<!--needs FS121-O1-OUT: FS111-M-C11,FS111-M-PINCH,FS111-M2-INTRAD-->

<!--q FS121-O1-OUT statement-->
**Statement as filed:**
> in an honest saturated colouring in D-NF satisfying REG-J′, the unit parallel away from the centre of every tangent-type interface arc of radius n (n a positive integer, or infinite for a segment) is, off Σ, a tangent-type interface arc of radius n + 1; so every curved interface of tangent type lies in a one-sided infinite family of concentric interface arcs of radii n, n + 1, n + 2, … over one angular window

<!--q FS121-O1-OUT not_claimed-->
**Not claimed:**
> that a saturated colouring with a curved tangent interface exists at any k (none is held); the same for split arcs (FALSE at R7, exact: ../tools/fs121_db1_r7parallel.py)

<!--q FS121-O1-OUT grade-->
**Grade as filed:**
> hand

<!--q FS121-O1-OUT minds-->
**Minds as filed:**
> 2 — blind to: FS121-O1's § 3.3 until 43bb6385; method: the same held step, DB1 adding the radial images of points of Σ and the attack at R7

<!--q FS121-O1-OUT handoff-->
**Handoff as filed:**
> de Bruijn — with FS111-M2-INTRAD, queued behind the measurable chain

### 171. FS121-V2-SECTOR
<!--row FS121-V2-SECTOR plans/FS121-derivation.md:450-->
**Address** `plans/FS121-derivation.md:450` · **Role** SEED · **Era** R · **Was** 186 in `lean-order.md` · **Upstream ids** FS111-M-C11, FS111-M-PINCH, FS121-DB1-L3
<!--needs FS121-V2-SECTOR: FS111-M-C11,FS111-M-PINCH,FS121-DB1-L3-->

<!--q FS121-V2-SECTOR statement-->
**Statement as filed:**
> in an honest saturated colouring in D-NF satisfying REG-J′, at every point of Σ, a colour that occupies a sector of positive angle occupies no other region there, of positive or of zero angle

<!--q FS121-V2-SECTOR not_claimed-->
**Not claimed:**
> that a colour cannot occupy two zero-angle regions at one point (they are collinear, FS121-V3-CUSP); anything without REG-J′; that the point itself is saturated (not used)

<!--q FS121-V2-SECTOR grade-->
**Grade as filed:**
> hand

<!--q FS121-V2-SECTOR minds-->
**Minds as filed:**
> 2 — blind to: V2 § 2.3 until V3's verdicts were committed (dea603eb; V3 was relayed two definition lines of V2's record, no route); method: limits of the edge contacts sorted by two disc tests, Lemmas C and D (V3), against a per-arc case split with Lemma H (V2)

<!--q FS121-V2-SECTOR handoff-->
**Handoff as filed:**
> de Bruijn — queued behind FS111-M-PINCH, FS111-M-C11 and the measurable chain

### 172. FS121-D1-VT
<!--row FS121-D1-VT plans/FS121-derivation.md:243-->
**Address** `plans/FS121-derivation.md:243` · **Role** SEED · **Era** R · **Was** 188 in `lean-order.md` · **Upstream ids** FS111-M-C11, FS111-M-PINCH, FS111-M2-INTRAD, FS121-V2-SECTOR
<!--needs FS121-D1-VT: FS111-M-C11,FS111-M-PINCH,FS111-M2-INTRAD,FS121-V2-SECTOR-->

<!--q FS121-D1-VT statement-->
**Statement as filed:**
> in a cusp-free honest saturated colouring in D-NF satisfying REG-J′, let I be a tangent-type interface arc between colours a and b with no sub-arc of radius 1 curving toward b, and L its unit parallel on b's side, which carries a on its far side; at the image Y on L of any interior point of I, no interface arc ends at Y from the far side of L

<!--q FS121-D1-VT not_claimed-->
**Not claimed:**
> anything at the image of an endpoint of I; anything when I has a sub-arc of radius 1 curving toward b (L has a corner: FS121-V2-VT-W); anything with cusps

<!--q FS121-D1-VT grade-->
**Grade as filed:**
> hand

<!--q FS121-D1-VT minds-->
**Minds as filed:**
> 2 — blind to: FS121-D1's § 2.1 until V2's verdicts were committed (f537b8c9); method: F2–F3 at points of L then FS121-V2-SECTOR at Y (V2), against FS111-W-NOREP at Y (D1); both pass the zero-angle case through FS121-V2-SECTOR

<!--q FS121-D1-VT handoff-->
**Handoff as filed:**
> de Bruijn — queued behind FS111-M-PINCH, FS111-M2-INTRAD and the measurable chain: the statement with its no-radius-1 clause

<!--q FS121-D1-VT merge@SR1-6.2-7-->
**Merge note — replaced in whole or in the part the line names** (SR1-6.2 item 7, `plans/FS129-SR1-audit.md:549-549`; status applied):
> 7. **FS121-V2-VT-W** in place of FS121-D1-VT, if its corner case is consumed.

### 173. FS121-D1-EROSION
<!--row FS121-D1-EROSION plans/FS121-derivation.md:288-->
**Address** `plans/FS121-derivation.md:288` · **Role** SEED · **Era** R · **Was** 189 in `lean-order.md` · **Upstream ids** FS111-M-C11, FS121-D1-VT, FS121-D1-XCORNER
<!--needs FS121-D1-EROSION: FS111-M-C11,FS121-D1-VT,FS121-D1-XCORNER-->

<!--q FS121-D1-EROSION statement-->
**Statement as filed:**
> in a cusp-free honest saturated colouring in D-NF satisfying REG-J′, if a colour's sector at a point z has angle θ in (0, π) and both its edges begin with maximal straight pieces of the colour's tile boundary of lengths L₁ and L₂, then min(L₁, L₂) ≤ cot(θ/2), or each of the two pieces has a point of Σ at distance cot(θ/2) from z

<!--q FS121-D1-EROSION not_claimed-->
**Not claimed:**
> anything for curved edges; anything at θ ≥ π; anything with cusps; content at θ ≤ 2π/3, where the first disjunct holds in every a.e.-proper colouring (FS121-V2-EROSION-DIAM)

<!--q FS121-D1-EROSION grade-->
**Grade as filed:**
> derived from: FS121-D1-VT, FS121-D1-XCORNER

<!--q FS121-D1-EROSION minds-->
**Minds as filed:**
> 2 — blind to: FS121-D1's §§ 1.3, 2.2 until f537b8c9; method: the same crossing (named in the statement, so given), VT applied through different lemmas, V2's for the straight branch alone

<!--q FS121-D1-EROSION handoff-->
**Handoff as filed:**
> de Bruijn — with FS121-D1-VT, queued behind the measurable chain

### 174. FS121-V5-LOC
<!--row FS121-V5-LOC plans/FS121-derivation.md:1092-->
**Address** `plans/FS121-derivation.md:1092` · **Role** upstream · **Era** R · **Was** 192 in `lean-order.md` · **Upstream ids** FS111-M-C11, FS111-M-PINCH
<!--needs FS121-V5-LOC: FS111-M-C11,FS111-M-PINCH-->

<!--q FS121-V5-LOC statement-->
**Statement as filed:**
> in an honest saturated colouring in D-NF satisfying REG-J′ with interface set 𝓘: (i) cl 𝓘 ∖ Σ ⊆ 𝓘, and no point of 𝓘 is a density point of any class; (ii) each y ∈ cl 𝓘 ∖ Σ has a ball missing Σ in which cl 𝓘 is the graph of a C^{1,1} function over the tangent line at y; (iii) a circular or straight arc of positive length in cl 𝓘 is, at its points off Σ and its ends, interior to a piece on its own circle or line, of tangent type when its radius is not 1

<!--q FS121-V5-LOC not_claimed-->
**Not claimed:**
> anything at points of Σ

<!--q FS121-V5-LOC grade-->
**Grade as filed:**
> hand

<!--q FS121-V5-LOC minds-->
**Minds as filed:**
> 1

<!--q FS121-V5-LOC handoff-->
**Handoff as filed:**
> none — local lemmas consumed by FS121-V5-RAY

### 175. FS121-V5-RAY
<!--row FS121-V5-RAY plans/FS121-derivation.md:1109-->
**Address** `plans/FS121-derivation.md:1109` · **Role** SEED · **Era** R · **Was** 193 in `lean-order.md` · **Upstream ids** FS111-M-C11, FS121-V5-LOC
<!--needs FS121-V5-RAY: FS111-M-C11,FS121-V5-LOC-->

<!--q FS121-V5-RAY statement-->
**Statement as filed:**
> in an honest saturated colouring in D-NF satisfying REG-J′, let C_n ⊆ cl 𝓘 be arcs of circles of radii R_n → ∞, or segments, no two sharing a sub-arc of positive length, with points p_n ∈ C_n, p_n → x₀, from which C_n continues for arclength at least λ > 0 with unit tangent u_n → u; then Σ contains the open segment (x₀, x₀ + λu), so Σ is not locally finite

<!--q FS121-V5-RAY not_claimed-->
**Not claimed:**
> anything for arcs of bounded radius

<!--q FS121-V5-RAY grade-->
**Grade as filed:**
> derived from: FS121-V5-LOC

<!--q FS121-V5-RAY minds-->
**Minds as filed:**
> 1

<!--q FS121-V5-RAY handoff-->
**Handoff as filed:**
> de Bruijn — a self-contained lemma over FS111-M-C11 that both routes to FS121-D2-SYM can rest on (item 79)

### 176. FS121-D2-SYM
<!--row FS121-D2-SYM plans/FS121-derivation.md:656-->
**Address** `plans/FS121-derivation.md:656` · **Role** SEED · **Era** R · **Was** 195 in `lean-order.md` · **Upstream ids** FS111-M-C11, FS111-M2-INTRAD, FS121-D2-EXT, FS121-D2-THIN, FS121-O1-OUT, FS121-V5-RAY
<!--needs FS121-D2-SYM: FS111-M-C11,FS111-M2-INTRAD,FS121-D2-EXT,FS121-D2-THIN,FS121-O1-OUT,FS121-V5-RAY-->

<!--q FS121-D2-SYM statement-->
**Statement as filed:**
> in an honest saturated colouring in D-NF satisfying REG-J′, with any number of colours, if for some integer r ≥ 2 the angular windows of its radius-r arcs are bounded below by a positive constant — in particular if it is invariant under a group of isometries of the plane, each mapping the partition to itself up to a permutation of the colours, with a compact set whose images cover the plane, such as a doubly periodic colouring — then ¬LRA holds

<!--q FS121-D2-SYM not_claimed-->
**Not claimed:**
> ¬LRA without such a bound (C121-NOLRA's open step); that a tight colouring can be taken symmetric; anything from a bound at r = 1

<!--q FS121-D2-SYM grade-->
**Grade as filed:**
> derived from: FS121-D2-THIN

<!--q FS121-D2-SYM minds-->
**Minds as filed:**
> 2 — blind to: D2 § 2 until V5's verdict was committed (ab25bbdc; V5 was relayed four header definitions of D2's record); method: the window carried back out to the piece's radius by FS121-O1-OUT, then a segment in Σ by FS121-V5-RAY (V5), against window transport stopped at junction normals by FS121-D2-EXT (D2)

<!--q FS121-D2-SYM handoff-->
**Handoff as filed:**
> de Bruijn — queued behind FS111-M2-INTRAD and the measurable chain (FS-113); V5's route needs only FS121-V5-RAY beyond held inputs

### L29. FS121-D4-HOLE
<!--row FS121-D4-HOLE plans/FS121-derivation.md:951-->
**Address** `plans/FS121-derivation.md:951` · **Role in `lean-order.md`** upstream CYCLE · **Was** 29 · **Why it left** in edges.csv as IX1 wrote it: FS121-D4-HOLE → FS111-M-PINCH [dropped: false, sorted by SR1]
**Cautions:** [C118](#c118)
<!--q FS121-D4-HOLE readme@30-->
**`README-corrections.md:30` names it:**
> | FS121-D4-HOLE has 60 (or 61) transitive dependents and tops `vacuity.md` | inventory items 35, 99; `vacuity.md` § 1; `hubs.md` rank 6 | **0**: its one edge (to FS111-M-PINCH) is false — "it crosses with FS111-M-PINCH" (FS129-SR1 § 4.1). The top of `vacuity-corrected.md` is FS116-N1-QFREE4 (19), unchanged |

<!--q FS121-D4-HOLE readme@31-->
**`README-corrections.md:31` names it:**
> | FS111-M-HULL2 rank-4 root and hub (63 dependents) | `roots.md`, `hubs.md` | it left both top-100 lists and the Lean order: its 63 came through the false cycle {FS111-M-PINCH, FS121-D4-HOLE} |

<!--q FS121-D4-HOLE statement-->
**Statement as filed:**
> in an honest saturated colouring in D-NF, if a region D (a component of the interior of the density set of one colour) has a bounded complementary component K of its closure, then every point of ∂K lies in Σ; so Σ contains a non-degenerate continuum, and a colouring whose Σ is locally finite has no region with a hole

<!--q FS121-D4-HOLE not_claimed-->
**Not claimed:**
> that a region with a hole exists or not; anything about unbounded complementary components; REG-J′ (unused)

<!--q FS121-D4-HOLE grade-->
**Grade as filed:**
> hand

<!--q FS121-D4-HOLE minds-->
**Minds as filed:**
> 1

<!--q FS121-D4-HOLE handoff-->
**Handoff as filed:**
> none — a structural no-go between open statements; it crosses with FS111-M-PINCH

### L46. FS121-DB1-L6
<!--row FS121-DB1-L6 plans/FS121-derivation.md:192-->
**Address** `plans/FS121-derivation.md:192` · **Role in `lean-order.md`** upstream CYCLE · **Was** 46 · **Why it left** in edges.csv as IX1 wrote it: FS121-DB1-L6 → FS111-M2-INTRAD [dropped: false, sorted by SR1]
**Cautions:** [C118](#c118)

<!--q FS121-DB1-L6 statement-->
**Statement as filed:**
> in an honest saturated colouring in D-NF satisfying REG-J′, the chain of unit parallels of an interface arc of finite radius toward its centre ends, off finitely many normals, at a unit arc whose centre carries that arc's outer colour

<!--q FS121-DB1-L6 not_claimed-->
**Not claimed:**
> which kind the last arc is (FS121-O1-ENDS)

<!--q FS121-DB1-L6 grade-->
**Grade as filed:**
> hand

<!--q FS121-DB1-L6 minds-->
**Minds as filed:**
> 1

<!--q FS121-DB1-L6 handoff-->
**Handoff as filed:**
> none — a re-derivation inside C121-ENDS's verification; it crosses with FS111-M2-INTRAD

### L182. FS121-DB1-L7
<!--row FS121-DB1-L7 plans/FS121-derivation.md:207-->
**Address** `plans/FS121-derivation.md:207` · **Role in `lean-order.md`** upstream · **Was** 182 · **Why it left** in edges.csv as IX1 wrote it: FS121-DB1-L7 → FS121-O1-OUT [dropped: false, sorted by SR1]
**Cautions:** [C118](#c118)

<!--q FS121-DB1-L7 statement-->
**Statement as filed:**
> in an honest saturated colouring in D-NF, the unit parallel away from the centre of a tangent-type interface arc is, at every point off Σ, a tangent-type interface of radius one more; REG-J′ is not used

<!--q FS121-DB1-L7 not_claimed-->
**Not claimed:**
> the family over the whole window (that uses REG-J′, FS121-O1-OUT); the same for split arcs (FALSE at R7)

<!--q FS121-DB1-L7 grade-->
**Grade as filed:**
> hand

<!--q FS121-DB1-L7 minds-->
**Minds as filed:**
> 1

<!--q FS121-DB1-L7 handoff-->
**Handoff as filed:**
> none — it crosses with FS121-O1-OUT

### L184. FS121-V2-EROSION-DIAM
<!--row FS121-V2-EROSION-DIAM plans/FS121-derivation.md:308-->
**Address** `plans/FS121-derivation.md:308` · **Role in `lean-order.md`** upstream · **Was** 184 · **Why it left** in edges.csv as IX1 wrote it: FS121-V2-EROSION-DIAM → FS121-D1-EROSION [dropped: false, sorted by SR1]
**Cautions:** [C118](#c118)

<!--q FS121-V2-EROSION-DIAM statement-->
**Statement as filed:**
> in every a.e.-proper colouring, if a colour's sector at z has angle θ in (0, π) and both its edges begin with straight pieces of the boundary of one component of that colour, of lengths L₁ and L₂, then min(L₁, L₂) ≤ 1/(2 sin(θ/2)); so for θ ≤ 2π/3, min(L₁, L₂) ≤ cot(θ/2)

<!--q FS121-V2-EROSION-DIAM not_claimed-->
**Not claimed:**
> anything for θ in (2π/3, π)

<!--q FS121-V2-EROSION-DIAM grade-->
**Grade as filed:**
> hand

<!--q FS121-V2-EROSION-DIAM minds-->
**Minds as filed:**
> 1

<!--q FS121-V2-EROSION-DIAM handoff-->
**Handoff as filed:**
> none — it places FS121-D1-EROSION's content

### L185. FS121-V3-CPI
<!--row FS121-V3-CPI plans/FS121-derivation.md:469-->
**Address** `plans/FS121-derivation.md:469` · **Role in `lean-order.md`** upstream · **Was** 185 · **Why it left** in edges.csv as IX1 wrote it: FS121-V3-CPI → FS121-V2-SECTOR [dropped: false, sorted by SR1]
**Cautions:** [C118](#c118)

<!--q FS121-V3-CPI statement-->
**Statement as filed:**
> in an honest saturated colouring in D-NF satisfying REG-J′, at a point of Σ every region of positive angle has angle at most π

<!--q FS121-V3-CPI not_claimed-->
**Not claimed:**
> anything about zero-angle regions

<!--q FS121-V3-CPI grade-->
**Grade as filed:**
> hand

<!--q FS121-V3-CPI minds-->
**Minds as filed:**
> 1

<!--q FS121-V3-CPI handoff-->
**Handoff as filed:**
> none — a corollary inside FS121-V2-SECTOR's verification

### L187. FS121-V2-VT-W
<!--row FS121-V2-VT-W plans/FS121-derivation.md:267-->
**Address** `plans/FS121-derivation.md:267` · **Role in `lean-order.md`** upstream · **Was** 187 · **Why it left** in edges.csv as IX1 wrote it: FS121-V2-VT-W → FS121-D1-VT [dropped: false, sorted by SR1]
**Cautions:** [C118](#c118)

<!--q FS121-V2-VT-W statement-->
**Statement as filed:**
> in a cusp-free honest saturated colouring in D-NF satisfying REG-J′, let I be a tangent-type interface arc between colours a and b, ν its normal into b, and x₀ an interior point of I that is not in the closure of a sub-arc of I of radius 1 curving toward b ending at an endpoint of I; let Y = x₀ + ν(x₀), P the closure of the radius-1 sub-arc of I curving toward b that contains x₀ in its closure if there is one and {x₀} otherwise, and L_Y the image under x ↦ x + ν(x) of a neighbourhood of P in I — a C¹ arc through Y when P = {x₀}, two branches meeting at Y at a corner otherwise; then no interface arc other than L_Y's branches ends at Y in the a-side region that L_Y bounds at Y (its far side, or the wedge between its branches)

<!--q FS121-V2-VT-W not_claimed-->
**Not claimed:**
> anything at a point where a has density 0 (the double horn is not excluded); anything at the image of an endpoint of I; anything on L_Y's near side

<!--q FS121-V2-VT-W grade-->
**Grade as filed:**
> derived from: FS121-V2-SECTOR

<!--q FS121-V2-VT-W minds-->
**Minds as filed:**
> 1

<!--q FS121-V2-VT-W handoff-->
**Handoff as filed:**
> none — the wider form of FS121-D1-VT; it crosses with it if the corner case is consumed

<!--q FS121-V2-VT-W merge@SR1-6.2-7-->
**Merge note — to formalize** (SR1-6.2 item 7, `plans/FS129-SR1-audit.md:549-549`; status applied):
> 7. **FS121-V2-VT-W** in place of FS121-D1-VT, if its corner case is consumed.

### L190. FS121-D1-PENCILWIN
<!--row FS121-D1-PENCILWIN plans/FS121-derivation.md:389-->
**Address** `plans/FS121-derivation.md:389` · **Role in `lean-order.md`** upstream CYCLE · **Was** 190 · **Why it left** in edges.csv as IX1 wrote it: FS121-D1-PENCILWIN → FS121-O1-OUT [dropped: false, sorted by SR1]
**Cautions:** [C118](#c118)

<!--q FS121-D1-PENCILWIN statement-->
**Statement as filed:**
> in a cusp-free honest saturated colouring in D-NF satisfying REG-J′, a tangent-type interface arc of finite radius n ≥ 2 about z whose chain of unit parallels ends at a single unit arc lies in a pencil whose rungs of radius at least 2 share one window, of angular width ℓ with 4 sin(ℓ/2) ≤ 1

<!--q FS121-D1-PENCILWIN not_claimed-->
**Not claimed:**
> any bound when the chain's inner end is broken by points of Σ; that such a pencil exists (C121-CURVED)

<!--q FS121-D1-PENCILWIN grade-->
**Grade as filed:**
> derived from: FS121-D1-VT

<!--q FS121-D1-PENCILWIN minds-->
**Minds as filed:**
> 1

<!--q FS121-D1-PENCILWIN handoff-->
**Handoff as filed:**
> none — a necessary condition on an uninhabited object; it crosses with FS121-O1-OUT if a curved inhabitant lands

### L194. FS121-D2-PERFIN
<!--row FS121-D2-PERFIN plans/FS121-derivation.md:679-->
**Address** `plans/FS121-derivation.md:679` · **Role in `lean-order.md`** upstream CYCLE · **Was** 194 · **Why it left** in edges.csv as IX1 wrote it: FS121-D2-PERFIN → FS121-D2-SYM [dropped: reversed, sorted by SR1]
**Cautions:** [C118](#c118)

<!--q FS121-D2-PERFIN statement-->
**Statement as filed:**
> in a doubly periodic honest saturated colouring in D-NF satisfying REG-J′, with any number of colours, the interfaces carry only finitely many radii of curvature

<!--q FS121-D2-PERFIN not_claimed-->
**Not claimed:**
> anything for colourings that are not periodic; that a tight colouring can be taken periodic

<!--q FS121-D2-PERFIN grade-->
**Grade as filed:**
> derived from: FS121-D2-SYM

<!--q FS121-D2-PERFIN minds-->
**Minds as filed:**
> 1

<!--q FS121-D2-PERFIN handoff-->
**Handoff as filed:**
> none — it removes a hypothesis from C121-PER's periodic clause; it crosses with FS121-D2-SYM

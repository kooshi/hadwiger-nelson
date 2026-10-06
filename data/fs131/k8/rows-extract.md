@@@@ lines 2730-2754
### 98. FS116-N2-SIXRING
<!--row FS116-N2-SIXRING plans/FS116-derivation.md:635-->
**Address** `plans/FS116-derivation.md:635` · **Role** SEED · **Era** R · **Was** 111 in `lean-order.md` · **Upstream ids** FS116-N1-TWIST-D
<!--needs FS116-N2-SIXRING: FS116-N1-TWIST-D-->

<!--q FS116-N2-SIXRING statement-->
**Statement as filed:**
> in a non-Siamese valid fragment on a closed disc of radius above 1 about a vertex p of six colours, the ring lies in Γ and is six consecutive closed 60° arcs Z_i = [α + 60°i, α + 60°(i + 1)], each the whole set of ring points in the closure of one tile t_i of p; t_i lies in the Reuleaux triangle Reul(p, z_i, z_(i+1)) on its arc, with cone at p in [α + 60°i − 30°, α + 60°i + 90°]; every ring arc is a (Q) arc, and every outer tile along a non-degenerate subarc of Z_i has the colour of t_(i+2), t_(i+3) or t_(i+4); the ring has no change point, so p has no hub

<!--q FS116-N2-SIXRING not_claimed-->
**Not claimed:**
> that any valid fragment has a six-colour vertex beyond radius 3/2; an exclusion of the type at any radius (FS116-Y2-SIXOFF's family stops below √3; the general type is open); anything in the Siamese class (there an inner tile need not be p's)

<!--q FS116-N2-SIXRING grade-->
**Grade as filed:**
> derived from: FS116-N1-TWIST-D

<!--q FS116-N2-SIXRING minds-->
**Minds as filed:**
> 1

<!--q FS116-N2-SIXRING handoff-->
**Handoff as filed:**
> de Bruijn — with TWIST-D, queued behind D6's map type; a relay-result for any exclusion of six-colour vertices

@@@@ lines 2884-2912
### 104. FS116-RING-GERM
<!--row FS116-RING-GERM plans/FS116-derivation.md:175-->
**Address** `plans/FS116-derivation.md:175` · **Role** SEED · **Era** R · **Was** 117 in `lean-order.md` · **Upstream ids** FS116-N1-TWIST-D
<!--needs FS116-RING-GERM: FS116-N1-TWIST-D-->

<!--q FS116-RING-GERM statement-->
**Statement as filed:**
> in a non-Siamese valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, let y be a change point of the ring (the ring off Γ on both sides of y), X the colour of the ring just counter-clockwise of y and X̄ the colour just clockwise, and u⁻, u⁺, v⁻, v⁺ the arcs of ω(p) just clockwise and just counter-clockwise of the ring points y + 60° and y − 60°; then p has four colours and no more, X and X̄ are the colours absent at p, and (i) if neither v⁻ nor u⁺ lies on a (Q) arc, every direction at y in the open cone of 60° about the direction to p lies in the cone of a tile of p; (ii) if neither u⁻ nor v⁺ lies on a (Q) arc, every direction at y in the open cone of 60° about the direction away from p lies in the cone of a tile of a colour of p that is not a tile of p; (iii) if none of the four lies on a (Q) arc, y is a vertex of at least four colours

<!--q FS116-RING-GERM not_claimed-->
**Not claimed:**
> anything at k ≥ 7; that a change point with a germ on a (Q) arc has fewer than four colours (the strip's P₂ has four, with u⁺ and v⁻ on (Q) arcs); that the ring's change points are 60° apart (N6-RING60's conclusion, for (Q)-free rings)

<!--q FS116-RING-GERM grade-->
**Grade as filed:**
> derived from: FS116-N1-TWIST-D

<!--q FS116-RING-GERM minds-->
**Minds as filed:**
> 2 — blind to: N1's argument until 81bfc5cb, given N7-HUB's one-line sketch in the list's § 8 (item 49's caveat); method: colour exclusion at the tiles in the cones (V2) against tile identification (N1), V2 § 4.1 row 1; the same model (Opus 5.5), one prior

<!--q FS116-RING-GERM handoff-->
**Handoff as filed:**
> de Bruijn — the statement with its four germs, the six-colour step named, over TWIST-D; queued behind D6's map type

<!--q FS116-RING-GERM merge@SR3-5.1-26-->
**Merge note — named** (SR3-5.1 item 26, `plans/FS129-SR3-audit.md:402-403`; status applied):
> 26. **FS129-SR3-OUTERADJ** in place of **FS116-V6-ADJ**, over FS116-RING-GERM (ii), V6-GERM's neighbourhood form and FS129-SR1-TWOCIRC; V6-ADJ's argument is its last step, formalized class-free (two distinct same-colour tiles holding the two lens arcs beyond a unit pair).

@@@@ lines 2913-2945
### 105. FS116-N2-STAR
<!--row FS116-N2-STAR plans/FS116-derivation.md:673-->
**Address** `plans/FS116-derivation.md:673` · **Role** SEED · **Era** R · **Was** 118 in `lean-order.md` · **Upstream ids** FS116-N1-TWIST-D, FS116-RING-GERM
<!--needs FS116-N2-STAR: FS116-N1-TWIST-D,FS116-RING-GERM-->

<!--q FS116-N2-STAR statement-->
**Statement as filed:**
> in a non-Siamese valid fragment on a closed disc of radius above 1 about a vertex p of four colours P, let y = r(ψ) be a change point of the ring, T_y the colours of the tiles of p at y and O_y those of the other tiles at y of colours of P; then C(y) = A(p) ⊔ T_y ⊔ O_y and A(y) = P ∖ (T_y ∪ O_y); every tile of p at y has its cone at p in [ψ − 90°, ψ + 90°], and the tile of p of each colour of O_y in [ψ + 90°, ψ + 270°]; every tile of p whose cone holds ψ + 90° or ψ − 90° in its interior has its colour in A(y); T_y is non-empty when v⁻, u⁺ lie on no (Q) arc and O_y when u⁻, v⁺ do

<!--q FS116-N2-STAR not_claimed-->
**Not claimed:**
> anything at k ≥ 7; that T_y or O_y is a single colour (at a hub y has four, five or six colours); anything about the ring of y beyond its branches at p

<!--q FS116-N2-STAR grade-->
**Grade as filed:**
> derived from: FS116-RING-GERM

<!--q FS116-N2-STAR minds-->
**Minds as filed:**
> 1

<!--q FS116-N2-STAR handoff-->
**Handoff as filed:**
> de Bruijn — with RING-GERM, queued behind D6's map type

<!--q FS116-N2-STAR merge@SR1-6.2-2-->
**Merge note — named** (SR1-6.2 item 2, `plans/FS129-SR1-audit.md:543-543`; status amended-by:SR3-5.1-25):
> 2. **FS129-MR1-DOUBLETIP** in place of FS116-V6-HUG (and of FS116-Y4-EMPTY's double-tip step on route 2); its `uses only:` may drop FS116-N2-STAR (§ 2.2).

<!--q FS116-N2-STAR merge@SR3-5.1-25-->
**Merge note — the line that amends SR1-6.2-2, shown because the earlier line names this row** (SR3-5.1 item 25, `plans/FS129-SR3-audit.md:400-401`; status applied):
> 25. **Amending SR1's item 2**: formalize **FS129-MR1-DOUBLETIP** for the wider ring classes it serves (FS-124), but **not** as EMPTY's double-tip step: its step 3 identifies the flank tile by a cone interval at the hubs, so an EMPTY routed through it holds only in the simple class (§ 2.3, § 4.3 row 3).

@@@@ lines 2946-2970
### 106. FS116-N2-ANTI
<!--row FS116-N2-ANTI plans/FS116-derivation.md:714-->
**Address** `plans/FS116-derivation.md:714` · **Role** SEED · **Era** R · **Was** 119 in `lean-order.md` · **Upstream ids** FS116-N2-STAR
<!--needs FS116-N2-ANTI: FS116-N2-STAR-->

<!--q FS116-N2-ANTI statement-->
**Statement as filed:**
> in a non-Siamese simple valid fragment on a closed disc of radius above 1 about a vertex p of four colours, let y = r(ψ) and y* = r(ψ + 180°) be hubs of p, and let ψ + 90° and ψ − 90° lie in the interiors of the cones at p of tiles t⁺ and t⁻; then t⁺ ≠ t⁻, A(y) = A(y*) = {c(t⁺), c(t⁻)}, T_y = O_(y*) and O_y = T_(y*), each a single colour, and y and y* have four colours and no more

<!--q FS116-N2-ANTI not_claimed-->
**Not claimed:**
> anything when an edge of p leaves at ψ + 90° or ψ − 90° (the strip: there the two missing pairs differ); anything at k ≥ 7

<!--q FS116-N2-ANTI grade-->
**Grade as filed:**
> derived from: FS116-N2-STAR

<!--q FS116-N2-ANTI minds-->
**Minds as filed:**
> 1

<!--q FS116-N2-ANTI handoff-->
**Handoff as filed:**
> de Bruijn — with STAR

@@@@ lines 2971-2995
### 107. FS116-N2-RECIP
<!--row FS116-N2-RECIP plans/FS116-derivation.md:694-->
**Address** `plans/FS116-derivation.md:694` · **Role** SEED · **Era** R · **Was** 120 in `lean-order.md` · **Upstream ids** FS116-N1-TOUCH, FS116-N2-STAR
<!--needs FS116-N2-RECIP: FS116-N1-TOUCH,FS116-N2-STAR-->

<!--q FS116-N2-RECIP statement-->
**Statement as filed:**
> in a non-Siamese valid fragment on a closed disc of radius above 2 about a vertex p of four colours P, let y = r(ψ) be a hub of p with four colours and no more; the points of ω(y) at 60° on either side of p are r(ψ + 60°) and r(ψ − 60°); if p lies on no arc of Γ on ω(y) and the four arcs of ω(y) just clockwise and just counter-clockwise of those two points lie on no (Q) arc of y's ring, then p is a change point of y's ring, its two sides lying in the tiles of p that hold the directions ψ − 90° and ψ + 90°, whose colours are the two colours of A(y)

<!--q FS116-N2-RECIP not_claimed-->
**Not claimed:**
> anything when an edge of p runs along ω(y) (then p lies on an arc of Γ on ω(y), a tactic edge centred at y when its sides are y's colours); that the hub has four colours in general; anything at k ≥ 7

<!--q FS116-N2-RECIP grade-->
**Grade as filed:**
> derived from: FS116-N2-STAR, FS116-N1-TOUCH

<!--q FS116-N2-RECIP minds-->
**Minds as filed:**
> 1

<!--q FS116-N2-RECIP handoff-->
**Handoff as filed:**
> de Bruijn — with STAR and TOUCH

@@@@ lines 3162-3190
### 114. FS116-RING-TWIST-C
<!--row FS116-RING-TWIST-C plans/FS116-derivation.md:129-->
**Address** `plans/FS116-derivation.md:129` · **Role** SEED · **Era** R · **Was** 127 in `lean-order.md` · **Upstream ids** FS116-N1-TWIST-D
<!--needs FS116-RING-TWIST-C: FS116-N1-TWIST-D-->

<!--q FS116-RING-TWIST-C statement-->
**Statement as filed:**
> at a vertex p of at least four colours of a valid fragment on a closed disc of radius above 1 about p (Siamese pairs allowed, any degree), the set D of points of ω(p) in the closure of a tile of one of p's colours is closed and lies in the union of the arcs of Γ on ω(p) and finitely many points; and for every half-open 60° window W of ω(p) with W ∪ σ(W) disjoint from D: p has four colours and no more; off a finite set, every point of W ∪ σ(W) lies in the closures of tiles of a single colour, one of the two colours absent at p, and this colour differs at θ and at θ + 60° for θ in W; every edge on ω(p) meeting W ∪ σ(W) in an arc has one colour on both sides; W holds an odd number of colour changes — points of W at which that colour differs on the two sides — each lying in the closures of tiles of the two absent colours and of no other colour; every change point in W is a colour change, and a colour change in W that is not a change point lies on an edge on ω(p) with one colour on both sides; so W holds an odd number of change points when no such arc meets W, in particular in every non-Siamese simple fragment

<!--q FS116-RING-TWIST-C not_claimed-->
**Not claimed:**
> anything at k ≥ 7; that any fragment of the class has a qualifying window (no held fragment has one: the strip's and the disk's D-free arcs are at most 60° and 87.83°); the parity of change points when a seam meets W (FS116-N1-TWIST-LIT: then it can fail)

<!--q FS116-RING-TWIST-C grade-->
**Grade as filed:**
> derived from: FS116-N1-TWIST-D

<!--q FS116-RING-TWIST-C minds-->
**Minds as filed:**
> 2 — blind to: N1's argument until V2's verdicts (81bfc5cb); method: the same route in substance (V2 § 4.2); the same model (Opus 5.5), one prior

<!--q FS116-RING-TWIST-C handoff-->
**Handoff as filed:**
> de Bruijn — the statement, its six-colour step L2 named, and TWIST-LIT's slit as the reason the counting word is colour changes

<!--q FS116-RING-TWIST-C merge@SR2-4.3-21-->
**Merge note — replaced in whole or in the part the line names** (SR2-4.3 item 21, `plans/FS129-SR2-audit.md:485-486`; status applied):
> 21. **FS116-RING-Q-PRIME-S** in place of **FS116-RING-Q-PRIME**; **FS116-N1-TWIST-D** in place of **FS116-RING-TWIST-C's first clause** and of **FS116-V5-RING's first two clauses**.

@@@@ lines 2755-2779
### 99. FS116-N3-PAIR
<!--row FS116-N3-PAIR plans/FS116-derivation.md:1398-->
**Address** `plans/FS116-derivation.md:1398` · **Role** SEED · **Era** R · **Was** 112 in `lean-order.md` · **Upstream ids** none
<!--needs FS116-N3-PAIR: -->

<!--q FS116-N3-PAIR statement-->
**Statement as filed:**
> in a non-Siamese simple valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, if both germs of one pair at a change point of the ring lie on (Q) arcs and the two arcs have the same pair of colours, then the inner colour of each is the outer colour of the other

<!--q FS116-N3-PAIR not_claimed-->
**Not claimed:**
> anything about two (Q) arcs that are not at the germs of one pair; that a full parallel semi-hub occurs at six colours beyond FS114-Y2-BOWTIE

<!--q FS116-N3-PAIR grade-->
**Grade as filed:**
> hand

<!--q FS116-N3-PAIR minds-->
**Minds as filed:**
> 2 — blind to: N3's record until 3647075d; method: the same route; the same model (Opus 5.5), one prior

<!--q FS116-N3-PAIR handoff-->
**Handoff as filed:**
> de Bruijn — with FS114-N7-QOPP, queued behind D6's map type

@@@@ lines 2780-2804
### 100. FS116-N3-STAR2
<!--row FS116-N3-STAR2 plans/FS116-derivation.md:1416-->
**Address** `plans/FS116-derivation.md:1416` · **Role** SEED · **Era** R · **Was** 113 in `lean-order.md` · **Upstream ids** FS114-N7-QOPP, FS116-N3-PAIR
<!--needs FS116-N3-STAR2: FS114-N7-QOPP,FS116-N3-PAIR-->

<!--q FS116-N3-STAR2 statement-->
**Statement as filed:**
> in a non-Siamese simple valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, let y = r(ψ) be a full semi-hub of kind O with (Q) arcs A = [ψ + 60°, ψ + 60° + ℓ] of inner colour a and outer a′ and B = [ψ − 60° − m, ψ − 60°]; if B's colours b (inner) and b′ (outer) are disjoint from a, a′, then ℓ + m ≤ 60° and the tiles of p are, counter-clockwise, t_b, t_a, t_b′, t_a′ with edges t_b|t_a in [ψ + ℓ − 30°, ψ + 30° − m], t_a|t_b′ in [ψ + 30°, ψ + 150°], t_b′|t_a′ in [ψ + 150° + ℓ, ψ + 210° − m] and t_a′|t_b in [ψ + 210°, ψ + 330°]; if B's colours are a′ (inner) and a (outer), then t_a ⊂ [ψ + 30°, ψ + 150°], t_a′ ⊂ [ψ + 210°, ψ + 330°], and the other two tiles' cones contain [ψ − 30°, ψ + 30°] and [ψ + 150°, ψ + 210°]

<!--q FS116-N3-STAR2 not_claimed-->
**Not claimed:**
> the windows of a crossed semi-hub of kind T (computed in § 2.3's spirit but not entered); that any star in the windows is realised

<!--q FS116-N3-STAR2 grade-->
**Grade as filed:**
> derived from: FS116-N3-PAIR

<!--q FS116-N3-STAR2 minds-->
**Minds as filed:**
> 1

<!--q FS116-N3-STAR2 handoff-->
**Handoff as filed:**
> de Bruijn — with FS114-N7-QOPP

@@@@ lines 3054-3078
### 110. FS116-N3-CONE
<!--row FS116-N3-CONE plans/FS116-derivation.md:1376-->
**Address** `plans/FS116-derivation.md:1376` · **Role** SEED · **Era** R · **Was** 123 in `lean-order.md` · **Upstream ids** FS112-N3-NOBOTH, FS112-U1, FS116-N1-GERM-R, FS116-RING-GERM
<!--needs FS116-N3-CONE: FS112-N3-NOBOTH,FS112-U1,FS116-N1-GERM-R,FS116-RING-GERM-->

<!--q FS116-N3-CONE statement-->
**Statement as filed:**
> in a non-Siamese simple valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, at a change point y = r(ψ) of the ring: u⁻ off (Q) arcs gives R ⊂ B̄(r(ψ + 60°), 1); v⁻ off them gives R ∩ B(r(ψ − 60°), 1) = ∅; v⁺ off them gives R′ ⊂ B̄(r(ψ − 60°), 1); u⁺ off them gives R′ ∩ B(r(ψ + 60°), 1) = ∅; a germ on a (Q) arc bars both colours of that arc from an open half-circle of directions at y — (ψ + 30°, ψ + 210°) for u⁺, (ψ + 150°, ψ + 330°) for v⁻, (ψ − 150°, ψ + 30°) for u⁻, (ψ − 30°, ψ + 150°) for v⁺; and an edge at y between a tile inside B̄(w, 1) and a tile outside B(w, 1) is an arc of ω(w), whose centre w, if it carries both side colours, is a vertex of at least four colours

<!--q FS116-N3-CONE not_claimed-->
**Not claimed:**
> anything about a germ on a non-(Q) arc of Γ beyond RING-GERM's Step 1; the Siamese or non-simple class; anything at k ≥ 7

<!--q FS116-N3-CONE grade-->
**Grade as filed:**
> hand

<!--q FS116-N3-CONE minds-->
**Minds as filed:**
> 1

<!--q FS116-N3-CONE handoff-->
**Handoff as filed:**
> de Bruijn — with RING-GERM and NOBOTH, queued behind D6's map type: the six half-planes at y and the edge clause

@@@@ lines 3079-3103
### 111. FS116-N3-CROSS
<!--row FS116-N3-CROSS plans/FS116-derivation.md:1471-->
**Address** `plans/FS116-derivation.md:1471` · **Role** SEED · **Era** R · **Was** 124 in `lean-order.md` · **Upstream ids** FS114-N7-QOPP, FS116-N3-CONE, FS116-N3-STAR2, FS116-RING-GERM
<!--needs FS116-N3-CROSS: FS114-N7-QOPP,FS116-N3-CONE,FS116-N3-STAR2,FS116-RING-GERM-->

<!--q FS116-N3-CROSS statement-->
**Statement as filed:**
> in a non-Siamese simple valid fragment on a closed disc of radius above 2 about a vertex p of at least four colours, let y = r(ψ) be a crossed full semi-hub of kind O of the ring of p, u⁺ on a (Q) arc of inner colour a and outer colour a′ and v⁻ on one of inner colour b and outer colour b′; then every tile of p at y has a cone at y of zero angle, and the outer colours at y lie in {a′, b′}; if y has four colours and every tile at y a cone of positive angle at y, its outer colours are a′ and b′ and its missing pair is {a, b}, and, unless an edge of p runs along ω(y) at p, p is a change point of the ring of y, that ring being b just counter-clockwise of p and a just clockwise, and p is a semi-hub of kind O of the ring of y

<!--q FS116-N3-CROSS not_claimed-->
**Not claimed:**
> that y has four colours; that p is a crossed semi-hub of y's ring; anything about y's ring away from p; anything at k ≥ 7

<!--q FS116-N3-CROSS grade-->
**Grade as filed:**
> derived from: FS116-N3-STAR2, FS116-N3-CONE

<!--q FS116-N3-CROSS minds-->
**Minds as filed:**
> 2 — on every clause but the last; blind to: N3's record until 3647075d; method: FS116-V5-U1's cones at p (V5 § 3.4); the same model (Opus 5.5), one prior; the last clause 1 and a checking reading (V5's blind verdict was GAP there, its stall closed after reading by N3's step through FS114-N7-QOPP at y, re-derived by V5-U1)

<!--q FS116-N3-CROSS handoff-->
**Handoff as filed:**
> de Bruijn — with STAR2 and RING-GERM

@@@@ lines 3655-3679
### 131. FS116-V5-OUT2
<!--row FS116-V5-OUT2 plans/FS116-derivation.md:1556-->
**Address** `plans/FS116-derivation.md:1556` · **Role** upstream · **Era** R · **Was** 144 in `lean-order.md` · **Upstream ids** none
<!--needs FS116-V5-OUT2: -->

<!--q FS116-V5-OUT2 statement-->
**Statement as filed:**
> in V5-QCOL's setting (or V5-RING's), if an outer tile of colour c has a ring point r(θ) in its closure, then p's tile of colour c has its cone at p in [θ + 90°, θ + 270°]

<!--q FS116-V5-OUT2 not_claimed-->
**Not claimed:**
> anything about the boundary directions of that cone

<!--q FS116-V5-OUT2 grade-->
**Grade as filed:**
> hand

<!--q FS116-V5-OUT2 minds-->
**Minds as filed:**
> 1

<!--q FS116-V5-OUT2 handoff-->
**Handoff as filed:**
> none — a relay-result for CROSS

@@@@ lines 3680-3704
### 132. FS116-V5-QCOL
<!--row FS116-V5-QCOL plans/FS116-derivation.md:1520-->
**Address** `plans/FS116-derivation.md:1520` · **Role** upstream · **Era** R · **Was** 145 in `lean-order.md` · **Upstream ids** FS116-V5-NE1
<!--needs FS116-V5-QCOL: FS116-V5-NE1-->

<!--q FS116-V5-QCOL statement-->
**Statement as filed:**
> in this setting p has exactly four colours and X, X̄ are the two absent; a germ that lies on no (Q) arc "carries" an absent colour — the ring colour there if the germ is off Γ, else an absent side colour of the arc of Γ on ω(p) it lies on — namely X at u⁻ and v⁻ and X̄ at u⁺ and v⁺, and the hub's partner point (u or v) lies in the closure of a tile of that colour; a germ on a (Q) arc lies on an arc of ω(p) whose inner tile is p's tile of the inner colour and whose outer tile is not a tile of p; the two germs of one pair never lie on one (Q) arc, and a (Q) arc holding u⁺ (v⁻) and not u⁻ (v⁺) ends at u (v)

<!--q FS116-V5-QCOL not_claimed-->
**Not claimed:**
> that a germ off (Q) lies off Γ; anything at k ≥ 7

<!--q FS116-V5-QCOL grade-->
**Grade as filed:**
> hand

<!--q FS116-V5-QCOL minds-->
**Minds as filed:**
> 1

<!--q FS116-V5-QCOL handoff-->
**Handoff as filed:**
> none — a relay-result for SEMI, PAIR, CROSS

@@@@ lines 3888-3912
### 140. FS116-V5-DICHO
<!--row FS116-V5-DICHO plans/FS116-derivation.md:1572-->
**Address** `plans/FS116-derivation.md:1572` · **Role** upstream ROUTE-ONLY · **Era** R · **Was** 153 in `lean-order.md` · **Upstream ids** FS116-V5-NE1, FS116-V5-QCOL, FS116-V5-U1
<!--needs FS116-V5-DICHO: FS116-V5-NE1,FS116-V5-QCOL,FS116-V5-U1-->

<!--q FS116-V5-DICHO statement-->
**Statement as filed:**
> in V5-QCOL's setting, if both germs of one pair at y lie on (Q) arcs A₁, A₂ with colour pairs Π₁, Π₂, then Π₁ = Π₂ (and then the inner colour of each is the outer colour of the other) or Π₁ ∩ Π₂ = ∅

<!--q FS116-V5-DICHO not_claimed-->
**Not claimed:**
> that either case occurs

<!--q FS116-V5-DICHO grade-->
**Grade as filed:**
> hand

<!--q FS116-V5-DICHO minds-->
**Minds as filed:**
> 1

<!--q FS116-V5-DICHO handoff-->
**Handoff as filed:**
> none — § 13's note asks that the dichotomy be checked, not given; here it is derived for every degree

@@@@ lines 3913-3937
### 141. FS116-N3-SEMI
<!--row FS116-N3-SEMI plans/FS116-derivation.md:1438-->
**Address** `plans/FS116-derivation.md:1438` · **Role** SEED · **Era** R · **Was** 154 in `lean-order.md` · **Upstream ids** FS116-N2-STAR, FS116-N3-CONE, FS116-N3-PAIR, FS116-N3-STAR2, FS116-RING-GERM, FS116-V5-DICHO, FS116-V5-OUT2, FS116-V5-QCOL, FS116-V5-U1
<!--needs FS116-N3-SEMI: FS116-N2-STAR,FS116-N3-CONE,FS116-N3-PAIR,FS116-N3-STAR2,FS116-RING-GERM,FS116-V5-DICHO,FS116-V5-OUT2,FS116-V5-QCOL,FS116-V5-U1-->

<!--q FS116-N3-SEMI statement-->
**Statement as filed:**
> in a non-Siamese simple valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, let y = r(ψ) be a semi-hub of the ring of p; then y is a vertex of at least four colours, or y is a vertex of exactly three colours one of whose edges at y is an arc of the unit circle about r(ψ + 60°) or about r(ψ − 60°) whose two side colours are both carried at that centre, which is then a vertex of at least four colours, or y is a full parallel semi-hub of exactly three colours — the two absent at p and the colour of the tile of p whose cone holds ψ + 180° (kind O) or ψ (kind T) in its interior

<!--q FS116-N3-SEMI not_claimed-->
**Not claimed:**
> that a semi-hub has four colours; that the third alternative occurs, or that it is excluded; anything at a closed change point (the disk's corner, FS116-N1-QDISK); Siamese or non-simple fragments; anything at k ≥ 7

<!--q FS116-N3-SEMI grade-->
**Grade as filed:**
> derived from: FS116-N3-CONE, FS116-N3-STAR2, FS116-N3-PAIR

<!--q FS116-N3-SEMI minds-->
**Minds as filed:**
> 2 — blind to: N3's record until V5's verdicts (3647075d); method: FS116-V5-U1 for the centre's four colours and FS116-V5-DICHO for crossed-or-parallel, against FS112-N3-NOBOTH and FS114-N7-QOPP (V5 § 4.1); the same model (Opus 5.5), one prior

<!--q FS116-N3-SEMI handoff-->
**Handoff as filed:**
> de Bruijn — with RING-GERM, NOBOTH and STAR, after a blind second mind; a relay-result for D2 (every semi-hub but the parallel three-colour one places a vertex of at least four colours on ω(p))

@@@@ lines 3938-3962
### 142. FS116-RING-TRANSFER-QC
<!--row FS116-RING-TRANSFER-QC plans/FS116-derivation.md:1494-->
**Address** `plans/FS116-derivation.md:1494` · **Role** SEED · **Era** R · **Was** 155 in `lean-order.md` · **Upstream ids** FS112-N3-NOBOTH, FS114-N7-QOPP, FS116-N1-GERM-R, FS116-N2-STAR, FS116-N3-CONE, FS116-N3-CROSS, FS116-N3-PAIR, FS116-N3-SEMI, FS116-N3-STAR2, FS116-RING-GERM
<!--needs FS116-RING-TRANSFER-QC: FS112-N3-NOBOTH,FS114-N7-QOPP,FS116-N1-GERM-R,FS116-N2-STAR,FS116-N3-CONE,FS116-N3-CROSS,FS116-N3-PAIR,FS116-N3-SEMI,FS116-N3-STAR2,FS116-RING-GERM-->

<!--q FS116-RING-TRANSFER-QC statement-->
**Statement as filed:**
> in a non-Siamese simple valid fragment on a closed disc of radius above 2 about a vertex p of four colours: at a semi-hub y = r(ψ) of p's ring a vertex of at least four colours lies at y, at r(ψ + 60°) or at r(ψ − 60°), unless y is a full parallel semi-hub of three colours, which are then the two absent at p and the colour of the tile of p holding ψ + 180° (kind O) or ψ (kind T) in its cone's interior; when the (Q) arcs at a semi-hub's other pair join the same two opposite tiles of p their inner colours are swapped; at a full semi-hub of kind O the four edges of p lie in FS116-N3-STAR2's windows; and at a crossed full semi-hub of kind O whose (Q) arcs have inner colours a, b and outer a′, b′, every tip has a cone of zero angle and the outer colours lie in {a′, b′}, and if y has four colours with cones of positive angle its missing pair is {a, b} and p — unless an edge of p runs along ω(y) — is a change point of y's ring, b counter-clockwise and a clockwise of it, and a semi-hub of kind O of that ring

<!--q FS116-RING-TRANSFER-QC not_claimed-->
**Not claimed:**
> anything at a closed change point; that the parallel three-colour semi-hub is excluded or occurs (SEMI-PAR3, GAP); that p is a crossed semi-hub of y's ring; anything about y's ring outside B̄(p, 1); that the rule is the same at k = 7 (RING-GERM's Step 1 and C(y) = A(p) ⊔ T_y ⊔ O_y spend six)

<!--q FS116-RING-TRANSFER-QC grade-->
**Grade as filed:**
> derived from: FS116-N3-SEMI, FS116-N3-CROSS, FS116-N3-PAIR, FS116-N3-STAR2

<!--q FS116-RING-TRANSFER-QC minds-->
**Minds as filed:**
> 1

<!--q FS116-RING-TRANSFER-QC handoff-->
**Handoff as filed:**
> de Bruijn — deferred with D6's map type, after a blind second mind on SEMI, PAIR, STAR2 and CROSS

@@@@ lines 3963-3991
### 143. FS116-V6-HUBS
<!--row FS116-V6-HUBS plans/FS116-derivation.md:1772-->
**Address** `plans/FS116-derivation.md:1772` · **Role** upstream · **Era** R · **Was** 156 in `lean-order.md` · **Upstream ids** none
<!--needs FS116-V6-HUBS: -->

<!--q FS116-V6-HUBS statement-->
**Statement as filed:**
> in a non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours whose ring carries no arc of Γ, m = 1: the change points are y_k = r(ψ₀ + 60°k), six of them; a tile of p tips at most two, and two only if consecutive

<!--q FS116-V6-HUBS not_claimed-->
**Not claimed:**
> anything in the Siamese class; anything at k ≥ 7 (SQ9 at k = 9 meets every other hypothesis with twelve points of Γ on its ring, control v6-sq9); that any such fragment exists

<!--q FS116-V6-HUBS grade-->
**Grade as filed:**
> hand

<!--q FS116-V6-HUBS minds-->
**Minds as filed:**
> 1

<!--q FS116-V6-HUBS handoff-->
**Handoff as filed:**
> none — a step of FS116-V6's route to FS116-Y4-EMPTY; it travels with EMPTY's handoff

<!--q FS116-V6-HUBS merge@SR3-5.1-24-->
**Merge note — named** (SR3-5.1 item 24, `plans/FS129-SR3-audit.md:398-399`; status applied):
> 24. **FS129-SR3-EMPTY-NS** in place of **FS116-Y4-EMPTY**, proved on **FS116-V6's route**: V6-HUBS, V6-HUG *with its own colour step* (V6-GERM), V6-ANTI, and V6-COUNT with its last step on sectors (§ 2.1). FS116-Y4-OBST and FS129-OR1-QFREE-CLASS's hypothesis at the non-Siamese class follow.

@@@@ lines 3992-4020
### 144. FS116-V6-ANTI
<!--row FS116-V6-ANTI plans/FS116-derivation.md:1836-->
**Address** `plans/FS116-derivation.md:1836` · **Role** upstream · **Era** R · **Was** 157 in `lean-order.md` · **Upstream ids** FS116-V6-HUBS
<!--needs FS116-V6-ANTI: FS116-V6-HUBS-->

<!--q FS116-V6-ANTI statement-->
**Statement as filed:**
> in a non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours whose ring carries no arc of Γ, with its change points y_k (FS116-V6-HUBS), a tile tipping y_k and a tile tipping y_(k+3) share no edge at p

<!--q FS116-V6-ANTI not_claimed-->
**Not claimed:**
> that the four tiles at p form a cycle of shared edges (that is simplicity, V6-COUNT's last step); anything at k ≥ 7

<!--q FS116-V6-ANTI grade-->
**Grade as filed:**
> hand

<!--q FS116-V6-ANTI minds-->
**Minds as filed:**
> 1

<!--q FS116-V6-ANTI handoff-->
**Handoff as filed:**
> none — a step of FS116-V6's route; with EMPTY

<!--q FS116-V6-ANTI merge@SR3-5.1-24-->
**Merge note — named** (SR3-5.1 item 24, `plans/FS129-SR3-audit.md:398-399`; status applied):
> 24. **FS129-SR3-EMPTY-NS** in place of **FS116-Y4-EMPTY**, proved on **FS116-V6's route**: V6-HUBS, V6-HUG *with its own colour step* (V6-GERM), V6-ANTI, and V6-COUNT with its last step on sectors (§ 2.1). FS116-Y4-OBST and FS129-OR1-QFREE-CLASS's hypothesis at the non-Siamese class follow.

@@@@ lines 4021-4062
### 145. FS116-V6-HUG
<!--row FS116-V6-HUG plans/FS116-derivation.md:1790-->
**Address** `plans/FS116-derivation.md:1790` · **Role** SEED · **Era** R · **Was** 158 in `lean-order.md` · **Upstream ids** FS116-V6-HUBS
<!--needs FS116-V6-HUG: FS116-V6-HUBS-->
**Cautions:** [C126](#c126), [C131](#c131)

<!--q FS116-V6-HUG statement-->
**Statement as filed:**
> in a non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours whose ring carries no arc of Γ, with its change points y_k = e(60°k) (FS116-V6-HUBS), no tile T of p tips both y_0 and y_1 while being the only tip at each

<!--q FS116-V6-HUG not_claimed-->
**Not claimed:**
> anything about a tile tipping two adjacent hubs with a second tip at either; anything in the Siamese class (non-Siamese gives the uniqueness of the tip and of the two X̄-tiles; V6: "Validity alone kills it here; non-Siamese was used only for the uniqueness of R⁻, R⁺ and of the tip"); anything at k ≥ 7

<!--q FS116-V6-HUG grade-->
**Grade as filed:**
> hand

<!--q FS116-V6-HUG minds-->
**Minds as filed:**
> 1

<!--q FS116-V6-HUG handoff-->
**Handoff as filed:**
> de Bruijn — the pinning of the two edges to ω(y_1) and ω(y_0) and the trigonometric identity, a short kernel target, with EMPTY

<!--q FS116-V6-HUG merge@SR1-6.2-1-->
**Merge note — replaced in whole or in the part the line names** (SR1-6.2 item 1, `plans/FS129-SR1-audit.md:541-542`; status applied):
> 1. **FS129-SR1-TWOCIRC** once, in place of the identity steps inside FS114-Y5-PXKILL, FS116-V6-HUG, FS116-V6-ADJ and FS116-Y4-FLANK (each keeps its own pinning of two tiles).

<!--q FS116-V6-HUG merge@SR1-6.2-2-->
**Merge note — replaced in whole or in the part the line names** (SR1-6.2 item 2, `plans/FS129-SR1-audit.md:543-543`; status amended-by:SR3-5.1-25):
> 2. **FS129-MR1-DOUBLETIP** in place of FS116-V6-HUG (and of FS116-Y4-EMPTY's double-tip step on route 2); its `uses only:` may drop FS116-N2-STAR (§ 2.2).

<!--q FS116-V6-HUG merge@SR3-5.1-24-->
**Merge note — named** (SR3-5.1 item 24, `plans/FS129-SR3-audit.md:398-399`; status applied):
> 24. **FS129-SR3-EMPTY-NS** in place of **FS116-Y4-EMPTY**, proved on **FS116-V6's route**: V6-HUBS, V6-HUG *with its own colour step* (V6-GERM), V6-ANTI, and V6-COUNT with its last step on sectors (§ 2.1). FS116-Y4-OBST and FS129-OR1-QFREE-CLASS's hypothesis at the non-Siamese class follow.

<!--q FS116-V6-HUG merge@SR3-5.1-25-->
**Merge note — the line that amends SR1-6.2-2, shown because the earlier line names this row** (SR3-5.1 item 25, `plans/FS129-SR3-audit.md:400-401`; status applied):
> 25. **Amending SR1's item 2**: formalize **FS129-MR1-DOUBLETIP** for the wider ring classes it serves (FS-124), but **not** as EMPTY's double-tip step: its step 3 identifies the flank tile by a cone interval at the hubs, so an EMPTY routed through it holds only in the simple class (§ 2.3, § 4.3 row 3).

@@@@ lines 4063-4091
### 146. FS116-V6-COUNT
<!--row FS116-V6-COUNT plans/FS116-derivation.md:1819-->
**Address** `plans/FS116-derivation.md:1819` · **Role** upstream · **Era** R · **Was** 159 in `lean-order.md` · **Upstream ids** FS116-V6-ANTI, FS116-V6-HUBS, FS116-V6-HUG
<!--needs FS116-V6-COUNT: FS116-V6-ANTI,FS116-V6-HUBS,FS116-V6-HUG-->

<!--q FS116-V6-COUNT statement-->
**Statement as filed:**
> in a non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours whose ring carries no arc of Γ, with V6-HUG, the tips force two antipodal doubly-tipped hubs and four double tiles: M = 4, s = 2, each hub of S has exactly two tips, and every tip at a hub of S is a double tile; the two hubs of S are antipodal, y_k and y_(k+3), each tipped by two of the four tiles

<!--q FS116-V6-COUNT not_claimed-->
**Not claimed:**
> the contradiction (FS116-V6-ANTI and simplicity finish it); anything in the Siamese class; anything at k ≥ 7

<!--q FS116-V6-COUNT grade-->
**Grade as filed:**
> hand

<!--q FS116-V6-COUNT minds-->
**Minds as filed:**
> 1

<!--q FS116-V6-COUNT handoff-->
**Handoff as filed:**
> none — a step of FS116-V6's route; with EMPTY

<!--q FS116-V6-COUNT merge@SR3-5.1-24-->
**Merge note — named** (SR3-5.1 item 24, `plans/FS129-SR3-audit.md:398-399`; status applied):
> 24. **FS129-SR3-EMPTY-NS** in place of **FS116-Y4-EMPTY**, proved on **FS116-V6's route**: V6-HUBS, V6-HUG *with its own colour step* (V6-GERM), V6-ANTI, and V6-COUNT with its last step on sectors (§ 2.1). FS116-Y4-OBST and FS129-OR1-QFREE-CLASS's hypothesis at the non-Siamese class follow.

@@@@ lines 5873-5906
### C28. FS129-SR3-EMPTY-NS
<!--row FS129-SR3-EMPTY-NS plans/FS129-derivation.md:675-->
**Address** `plans/FS129-derivation.md:675` · **Role** FS-129 composition · **Upstream ids** FS116-Y4-EMPTY
<!--needs FS129-SR3-EMPTY-NS: FS116-Y4-EMPTY-->
**Cautions:** [C126](#c126), [C131](#c131)

<!--q FS129-SR3-EMPTY-NS statement-->
**Statement as filed:**
> no non-Siamese valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours has a ring carrying no arc of Γ

<!--q FS129-SR3-EMPTY-NS not_claimed-->
**Not claimed:**
> anything in the Siamese class (V6-RING's one tile per colour at p, V6-TIP's tip and V6-HUG's uniqueness of the tip and of R⁻, R⁺ read non-Siamese); anything at k ≥ 7 (V6-RING and V6-TIP spend six); that FS116-Y4's own route carries the non-simple class (it reads one cone per tile at a double-tipped hub)

<!--q FS129-SR3-EMPTY-NS grade-->
**Grade as filed:**
> hand

<!--q FS129-SR3-EMPTY-NS minds-->
**Minds as filed:**
> 1

<!--q FS129-SR3-EMPTY-NS handoff-->
**Handoff as filed:**
> de Bruijn — in place of FS116-Y4-EMPTY, on V6's route: V6-HUG's own colour step (V6-GERM, the Γ-free ring's germs all off Γ), not FS129-MR1-DOUBLETIP's cone step, and V6-COUNT's last step on sectors as here

<!--q FS129-SR3-EMPTY-NS uses_only-->
**Uses only:**
> FS116-V6's route to FS116-Y4-EMPTY (`plans/FS116-V6-verification.md` § 2.2) — V6-DIAM, V6-E1, V6-DICH, V6-RING, V6-WIN, V6-GERM, V6-TIP, V6-HUBS, V6-HUG (its colour step through V6-GERM), V6-ANTI and V6-COUNT's count — none of which reads simplicity (§ 2.1); V6-COUNT's last step read on sectors: every tile of p owns a sector at p, and two cyclically consecutive sectors of the two tipper groups share an edge, against V6-ANTI

<!--q FS129-SR3-EMPTY-NS merge@SR3-5.1-24-->
**Merge note — to formalize** (SR3-5.1 item 24, `plans/FS129-SR3-audit.md:398-399`; status applied):
> 24. **FS129-SR3-EMPTY-NS** in place of **FS116-Y4-EMPTY**, proved on **FS116-V6's route**: V6-HUBS, V6-HUG *with its own colour step* (V6-GERM), V6-ANTI, and V6-COUNT with its last step on sectors (§ 2.1). FS116-Y4-OBST and FS129-OR1-QFREE-CLASS's hypothesis at the non-Siamese class follow.

@@@@ lines 5907-5939
### C29. FS129-SR3-OUTERADJ
<!--row FS129-SR3-OUTERADJ plans/FS129-derivation.md:795-->
**Address** `plans/FS129-derivation.md:795` · **Role** FS-129 composition · **Upstream ids** FS116-N1-GERM-R, FS116-RING-GERM, FS116-V4-DICHOTOMY, FS129-SR1-TWOCIRC
<!--needs FS129-SR3-OUTERADJ: FS116-N1-GERM-R,FS116-RING-GERM,FS116-V4-DICHOTOMY,FS129-SR1-TWOCIRC-->

<!--q FS129-SR3-OUTERADJ statement-->
**Statement as filed:**
> in a non-Siamese valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours, let y = r(ψ) and y′ = r(ψ + 60°) be change points of the ring such that neither the arc of ω(p) just counter-clockwise of r(ψ − 60°) nor the arc just clockwise of r(ψ + 120°) lies on a (Q) arc; then no colour of p is at once the only colour carried at y by a tile that is not a tile of p and the only colour carried at y′ by a tile that is not a tile of p

<!--q FS129-SR3-OUTERADJ not_claimed-->
**Not claimed:**
> anything when y or y′ carries two or more outer colours (the tile beyond the outer tile may then be outer and unpinned: tangent segments stay exactly 1 apart, plant --fault-tangent); anything when the arc just counter-clockwise of r(ψ − 60°) or just clockwise of r(ψ + 120°) lies on a (Q) arc (RING-GERM (ii) is then unavailable); the Siamese class; anything at k ≥ 7 (a third absent colour leaves the tile beyond unpinned, plant --fault-seven); that y or y′ has a single tip

<!--q FS129-SR3-OUTERADJ grade-->
**Grade as filed:**
> hand

<!--q FS129-SR3-OUTERADJ minds-->
**Minds as filed:**
> 1

<!--q FS129-SR3-OUTERADJ handoff-->
**Handoff as filed:**
> de Bruijn — the statement and its not claimed, over RING-GERM (ii), V6-GERM's neighbourhood form and TWOCIRC; it carries FS116-V6-ADJ's argument as its last step, so V6-ADJ is formalized class-free (two distinct same-colour tiles holding the two lens arcs beyond a unit pair) or not at all

<!--q FS129-SR3-OUTERADJ uses_only-->
**Uses only:**
> FS116-RING-GERM (ii) at y (outer pair u⁻, v⁺) and at y′ (u′⁻, v′⁺) — u⁻ (the ring just clockwise of y′) and v′⁺ (just counter-clockwise of y) are off Γ because y′ and y are change points, the other two by hypothesis — and its first clause (p has four colours, X and X̄ absent); V6-GERM's neighbourhood form at y from the germs u⁻ (colour X) and u⁺ (colour X̄), and at y′ from v′⁺ (X) and v′⁻ (X̄), all off Γ (the argument of FS116-N1-GERM-R, which reads only N-E1 and the germs' colours); the germs' colours from validity (ring points 60° apart differ, two absent colours); non-Siamese (one tile per colour at a point; distinct tiles of one colour have no closure points below 1 apart, FS116-V4-DICHOTOMY); the diameter bound; FS129-SR1-TWOCIRC at the mirror apex y + y′ − p; six colours, spent in RING-GERM and in the colour of the tile beyond the outer tile

<!--q FS129-SR3-OUTERADJ merge@SR3-5.1-26-->
**Merge note — to formalize** (SR3-5.1 item 26, `plans/FS129-SR3-audit.md:402-403`; status applied):
> 26. **FS129-SR3-OUTERADJ** in place of **FS116-V6-ADJ**, over FS116-RING-GERM (ii), V6-GERM's neighbourhood form and FS129-SR1-TWOCIRC; V6-ADJ's argument is its last step, formalized class-free (two distinct same-colour tiles holding the two lens arcs beyond a unit pair).

@@@@ lines 5940-5978
### C30. FS129-MR1-DOUBLETIP
<!--row FS129-MR1-DOUBLETIP plans/FS129-derivation.md:750-->
**Address** `plans/FS129-derivation.md:750` · **Role** FS-129 composition · **Upstream ids** FS116-RING-GERM, FS116-V4-DICHOTOMY, FS116-V4-TWIST, FS116-Y4-FLANK · **Also placed after** FS129-SR1-TWOCIRC, FS129-SR3-OUTERADJ (their `Rests on it:` prose names this entry)
<!--needs FS129-MR1-DOUBLETIP: FS116-RING-GERM,FS116-V4-DICHOTOMY,FS116-V4-TWIST,FS116-Y4-FLANK-->
<!--after FS129-MR1-DOUBLETIP: FS129-SR1-TWOCIRC,FS129-SR3-OUTERADJ-->
**Cautions:** [C126](#c126), [C131](#c131)

<!--q FS129-MR1-DOUBLETIP statement-->
**Statement as filed:**
> in a non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours, let y = r(ψ) and y′ = r(ψ + 60°) be change points of the ring of p such that neither the arc of ω(p) just clockwise of r(ψ − 60°) nor the arc just counter-clockwise of r(ψ + 120°) lies on a (Q) arc; then no tile of p is at once the only tile of p whose closure holds y and the only tile of p whose closure holds y′

<!--q FS129-MR1-DOUBLETIP not_claimed-->
**Not claimed:**
> anything when the arc just clockwise of r(ψ − 60°) or just counter-clockwise of r(ψ + 120°) lies on a (Q) arc; that y or y′ has a single tip in general (two tips at either are not excluded); SEMI-PAR3 (its points y ± 60° lie at (Q) arc ends, not change points); the Siamese or non-simple class; anything at k ≥ 7 (three absent colours: the flank tiles' colours may differ, control fs129-mr1-doubletip's plant)

<!--q FS129-MR1-DOUBLETIP grade-->
**Grade as filed:**
> derived from: FS116-Y4-FLANK, FS116-RING-GERM, FS116-V4-TWIST, FS116-V4-DICHOTOMY

<!--q FS129-MR1-DOUBLETIP minds-->
**Minds as filed:**
> 1

<!--q FS129-MR1-DOUBLETIP handoff-->
**Handoff as filed:**
> de Bruijn — the statement and its not claimed, over FS116-Y4-FLANK and RING-GERM (i); it carries FS116-V6-HUG as its Γ-free instance, so the kernel module should prove this form once and V6-HUG from it

<!--q FS129-MR1-DOUBLETIP uses_only-->
**Uses only:**
> FS116-RING-GERM (i) at y and at y′ (the open cone of 60° about the direction to p lies in cones of tiles of p when neither germ of the tip pair lies on a (Q) arc); FS116-Y4-FLANK (colour-free, Siamese allowed); FS116-V4-TWIST (germs 60° apart carry different colours; a ring point inside a tile has an absent colour); FS116-V4-DICHOTOMY; non-Siamese (one tile of each colour at a point; an outer tile misses B(p, 1)); simple (one cone per tile at a vertex)

<!--q FS129-MR1-DOUBLETIP merge@SR1-6.2-2-->
**Merge note — to formalize** (SR1-6.2 item 2, `plans/FS129-SR1-audit.md:543-543`; status amended-by:SR3-5.1-25):
> 2. **FS129-MR1-DOUBLETIP** in place of FS116-V6-HUG (and of FS116-Y4-EMPTY's double-tip step on route 2); its `uses only:` may drop FS116-N2-STAR (§ 2.2).

<!--q FS129-MR1-DOUBLETIP merge@SR3-5.1-25-->
**Merge note — to formalize, as amended** (SR3-5.1 item 25, `plans/FS129-SR3-audit.md:400-401`; status applied):
> 25. **Amending SR1's item 2**: formalize **FS129-MR1-DOUBLETIP** for the wider ring classes it serves (FS-124), but **not** as EMPTY's double-tip step: its step 3 identifies the flank tile by a cone interval at the hubs, so an EMPTY routed through it holds only in the simple class (§ 2.3, § 4.3 row 3).

@@@@ lines 4349-4390
### 156. FS116-Y4-EMPTY
<!--row FS116-Y4-EMPTY plans/FS116-derivation.md:1714-->
**Address** `plans/FS116-derivation.md:1714` · **Role** SEED · **Era** R · **Was** 169 in `lean-order.md` · **Upstream ids** FS116-N2-STAR, FS116-RING-GERM, FS116-V6-ANTI, FS116-V6-COUNT, FS116-V6-HUBS, FS116-V6-HUG, FS116-Y3-SIX, FS116-Y3-TIPS, FS116-Y4-FLANK
<!--needs FS116-Y4-EMPTY: FS116-N2-STAR,FS116-RING-GERM,FS116-V6-ANTI,FS116-V6-COUNT,FS116-V6-HUBS,FS116-V6-HUG,FS116-Y3-SIX,FS116-Y3-TIPS,FS116-Y4-FLANK-->
**Cautions:** [C126](#c126), [C131](#c131)

<!--q FS116-Y4-EMPTY statement-->
**Statement as filed:**
> no non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours has a ring carrying no arc of Γ

<!--q FS116-Y4-EMPTY not_claimed-->
**Not claimed:**
> anything for rings carrying an arc of Γ that is not a (Q) arc (the (Q)-free rings of FS114-N6-RING60 after the bends, with (R2) arcs); anything in the Siamese or non-simple class; anything at k ≥ 7 (with three absent colours the flank tiles need not share a colour)

<!--q FS116-Y4-EMPTY grade-->
**Grade as filed:**
> derived from: FS116-Y4-FLANK, FS116-Y3-SIX, FS116-Y3-TIPS, FS116-RING-GERM

<!--q FS116-Y4-EMPTY minds-->
**Minds as filed:**
> 2 — blind to: FS116-Y4's record until its verdict's commit (2429e200), though given the frozen list with round 3's construction-side statements and their setting (§ 14), route-shaped and unused; method: a different route at the count (FS116-V6-COUNT and -ANTI in place of FS116-Y3-TIPS) and at the flank step (FS116-V6-HUG's exact identity in place of FS116-Y4-FLANK's curvature bound); the same model (Opus 5.5), one prior

<!--q FS116-Y4-EMPTY handoff-->
**Handoff as filed:**
> de Bruijn — by either route, the first with FLANK, SIX, TIPS and RING-GERM, or FS116-V6's (FS116-V6-HUBS, -HUG, -COUNT, -ANTI, hand, using no statement of the frozen list), the shorter; for D2, the Γ-free ring type removed from C114-LOCAL-F's case list at 1 + ε

<!--q FS116-Y4-EMPTY note@1749-->
**dated note filed under the entry (`plans/FS116-derivation.md:1749`):**
> *Erratum (2026-10-03, FS129-Z1, from `plans/FS129-SR1-audit.md` § 2.3; `plans/FS129-close-inventory.md` item 96):* the not-claimed line's "rings carrying an arc of Γ that is not a (Q) arc (the (Q)-free rings of FS114-N6-RING60 after the bends, with (R2) arcs)" are now reached in the non-Siamese simple class by FS129-OR1-QFREE (derived, one mind; `plans/FS129-derivation.md`): no non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex of at least four colours has a ring carrying no (Q) arc. FS129-SR3 (`plans/FS129-SR3-audit.md` § Stage 2 — SAVED: item (d); derived, one mind; FS129-Z2 files its entries) derives this entry and QFREE with "simple" dropped on FS116-V6's route (FS129-SR3-EMPTY-NS, FS129-SR3-QFREE-NS), which reaches the not-claimed line's non-simple class as well; FS116-Y4's own route uses simplicity.

<!--q FS116-Y4-EMPTY merge@SR1-6.2-2-->
**Merge note — replaced in whole or in the part the line names** (SR1-6.2 item 2, `plans/FS129-SR1-audit.md:543-543`; status amended-by:SR3-5.1-25):
> 2. **FS129-MR1-DOUBLETIP** in place of FS116-V6-HUG (and of FS116-Y4-EMPTY's double-tip step on route 2); its `uses only:` may drop FS116-N2-STAR (§ 2.2).

<!--q FS116-Y4-EMPTY merge@SR3-5.1-24-->
**Merge note — replaced in whole or in the part the line names** (SR3-5.1 item 24, `plans/FS129-SR3-audit.md:398-399`; status applied):
> 24. **FS129-SR3-EMPTY-NS** in place of **FS116-Y4-EMPTY**, proved on **FS116-V6's route**: V6-HUBS, V6-HUG *with its own colour step* (V6-GERM), V6-ANTI, and V6-COUNT with its last step on sectors (§ 2.1). FS116-Y4-OBST and FS129-OR1-QFREE-CLASS's hypothesis at the non-Siamese class follow.

<!--q FS116-Y4-EMPTY merge@SR3-5.1-25-->
**Merge note — named by the amending line** (SR3-5.1 item 25, `plans/FS129-SR3-audit.md:400-401`; status applied):
> 25. **Amending SR1's item 2**: formalize **FS129-MR1-DOUBLETIP** for the wider ring classes it serves (FS-124), but **not** as EMPTY's double-tip step: its step 3 identifies the flank tile by a cone interval at the hubs, so an EMPTY routed through it holds only in the simple class (§ 2.3, § 4.3 row 3).

@@@@ lines 6935-6970
### FS116-V6-ADJ
<!--row FS116-V6-ADJ plans/FS116-derivation.md:1851-->
**Address** `plans/FS116-derivation.md:1851` · **Role** not in the order · **Named by** SR1-6.2 item 1; SR1-6.2 item DNF; SR3-5.1 item 26

<!--q FS116-V6-ADJ statement-->
**Statement as filed:**
> in a non-Siamese simple valid six-coloured fragment on a closed disc of radius above 1 about a vertex p of at least four colours whose ring carries no arc of Γ, outer tiles of one colour at adjacent hubs cannot both hug the lens arcs beyond their hubs (ω(y_1) beyond y_0, ω(y_0) beyond y_1)

<!--q FS116-V6-ADJ not_claimed-->
**Not claimed:**
> anything FS116-Y4-EMPTY needs (it is not used there); anything at k ≥ 7

<!--q FS116-V6-ADJ grade-->
**Grade as filed:**
> hand

<!--q FS116-V6-ADJ minds-->
**Minds as filed:**
> 1

<!--q FS116-V6-ADJ handoff-->
**Handoff as filed:**
> none — not needed by EMPTY

<!--q FS116-V6-ADJ merge@SR1-6.2-1-->
**Merge note — replaced in whole or in the part the line names** (SR1-6.2 item 1, `plans/FS129-SR1-audit.md:541-542`; status applied):
> 1. **FS129-SR1-TWOCIRC** once, in place of the identity steps inside FS114-Y5-PXKILL, FS116-V6-HUG, FS116-V6-ADJ and FS116-Y4-FLANK (each keeps its own pinning of two tiles).

<!--q FS116-V6-ADJ merge@SR1-6.2-DNF-->
**Merge note — do not formalize as stated** (SR1-6.2 item DNF, `plans/FS129-SR1-audit.md:552-554`; status applied):
> **Do not formalize as stated (empty):** FS116-Y3-NOQ, -Y3-TIGHT, -Y3-HUBCOL, -Y3-LENS, -Y3-NBTIP, -Y3-TIGHTLENS, -Y3-STARFORCE, -Y4-SYM, -Y4-SPOKE, -Y4-Q1, -V6-ADJ, -V1-FRAME, -N2-HEX6, -N2-HEX3; FS114-N7-HUB (empty given FS129-OR1-QFREE) and with it FS114-N7-3T; FS116-RING-TRANSFER-C's four-colour clause.

<!--q FS116-V6-ADJ merge@SR3-5.1-26-->
**Merge note — replaced in whole or in the part the line names** (SR3-5.1 item 26, `plans/FS129-SR3-audit.md:402-403`; status applied):
> 26. **FS129-SR3-OUTERADJ** in place of **FS116-V6-ADJ**, over FS116-RING-GERM (ii), V6-GERM's neighbourhood form and FS129-SR1-TWOCIRC; V6-ADJ's argument is its last step, formalized class-free (two distinct same-colour tiles holding the two lens arcs beyond a unit pair).

@@@@ lines 6971-6998
### FS116-Y4-OBST
<!--row FS116-Y4-OBST plans/FS116-derivation.md:1751-->
**Address** `plans/FS116-derivation.md:1751` · **Role** not in the order · **Named by** SR3-5.1 item 24

<!--q FS116-Y4-OBST statement-->
**Statement as filed:**
> for every R > 1, no fragment of the HEX3 class exists on the closed disc of radius R about p

<!--q FS116-Y4-OBST not_claimed-->
**Not claimed:**
> anything outside the non-Siamese simple Γ-free class

<!--q FS116-Y4-OBST grade-->
**Grade as filed:**
> derived from: FS116-Y4-EMPTY

<!--q FS116-Y4-OBST minds-->
**Minds as filed:**
> 1

<!--q FS116-Y4-OBST handoff-->
**Handoff as filed:**
> none — the brief's answer; it rides on EMPTY's handoff

<!--q FS116-Y4-OBST merge@SR3-5.1-24-->
**Merge note — named** (SR3-5.1 item 24, `plans/FS129-SR3-audit.md:398-399`; status applied):
> 24. **FS129-SR3-EMPTY-NS** in place of **FS116-Y4-EMPTY**, proved on **FS116-V6's route**: V6-HUBS, V6-HUG *with its own colour step* (V6-GERM), V6-ANTI, and V6-COUNT with its last step on sectors (§ 2.1). FS116-Y4-OBST and FS129-OR1-QFREE-CLASS's hypothesis at the non-Siamese class follow.

@@@@ lines 2294-2318
### 83. FS114-N7-QOPP
<!--row FS114-N7-QOPP plans/FS114-derivation.md:793-->
**Address** `plans/FS114-derivation.md:793` · **Role** upstream · **Era** R · **Was** 99 in `lean-order.md` · **Upstream ids** FS112-U1, FS114-N6-NOQ
<!--needs FS114-N7-QOPP: FS112-U1,FS114-N6-NOQ-->

<!--q FS114-N7-QOPP statement-->
**Statement as filed:**
> (N7-QOPP) Every (Q) arc of a four-colour degree-4 vertex joins opposite tiles (inner `t_i`, outer colour `c_{i+2}`); the other two tiles' colours are absent along it; (N7-FLANK) A tile of `p` with cone `[a, b]` puts its colour at no ring point in `(a ∓ 90°, b ∓ 90°)`; in `W(t) = [b − 90°, a + 90°]` only as itself, in `W̄(t)` only as other tiles; a ring point carries at most two colours of `p`; (N7-CHAIN) Change points propagate by `±60°` until the next point lies on a (Q) arc

<!--q FS114-N7-QOPP not_claimed-->
**Not claimed:**
> that (Q) arcs occur; K1 on (Q) rings (a GAP at N7-HUBQ)

<!--q FS114-N7-QOPP grade-->
**Grade as filed:**
> hand

<!--q FS114-N7-QOPP minds-->
**Minds as filed:**
> 1

<!--q FS114-N7-QOPP handoff-->
**Handoff as filed:**
> none — tools for the (Q)-ring cases, the successor's

# FS131-K3 — wave 3's rows, quoted verbatim from `plans/LEAN-BACKLOG.md`

*Written by `tools/fs131_k3_rows.py`; `--check` re-reads it against the backlog. Every line under a row is the backlog's own quotation (which the backlog's script copies from the derivation file at the row's address).*

## FS116-V5-NE1
`plans/LEAN-BACKLOG.md:3601`; plans/FS116-derivation.md:1258

**statement:**
> in a valid k-coloured fragment, for any k, Siamese pairs allowed, if a point x lies in the closure of a tile of colour c, then no point z interior to a tile of colour c has |z − x| = 1; in particular every tile T lies in B(x, 1) for every x in cl T, so cl T lies in B̄(x, 1) and T has diameter at most 1

**not_claimed:**
> that T lies in the open disc B(x, 1) when x is a closure point of another tile of T's colour (only that z ∉ ω(x)); anything about points of Γ

<!--q FS116-V5-NE1 merge@SR2-4.3-9-->
**Merge note — replaced in whole or in the part the line names** (SR2-4.3 item 9, `plans/FS129-SR2-audit.md:467-469`; status applied):
> 9. **FS129-SR2-CLOSURE** (as FS111-M2-INT's corollary for open sets, or by V0-CLOSE's translation argument) in place of **FS106-DIAM (iii)**, **FS111-V0-CLOSE** and **FS116-V5-NE1's first clause**; and **FS106-DIAM (i)** (a connected set with no unit pair has diameter at most 1) once, in place of the connectedness step inside FS116-V5-NE1's "in particular", FS106-TS-C, FS116-V4-DICHOTOMY's "A ~ A" and FS111-V0-CLEAN's diameter step.

## FS116-V4-DICHOTOMY
`plans/LEAN-BACKLOG.md:3336`; plans/FS116-derivation.md:972

**statement:**
> in a valid k-coloured fragment, for tiles A, B of one colour (A = B allowed), either every point of A is at distance below 1 from every point of B (write A ~ B) or every point of A is at distance above 1 from every point of B (A ⊥ B); A ~ A, so the closure of a tile has diameter at most 1; if points z ∈ cl A, z′ ∈ cl B have |z − z′| < 1 then A ~ B, and if |z − z′| > 1 then A ⊥ B; in a non-Siamese fragment A ~ B forces A = B

**not_claimed:**
> anything for tiles of different colours

<!--q FS116-V4-DICHOTOMY merge@SR2-4.3-9-->
**Merge note — replaced in whole or in the part the line names** (SR2-4.3 item 9, `plans/FS129-SR2-audit.md:467-469`; status applied):
> 9. **FS129-SR2-CLOSURE** (as FS111-M2-INT's corollary for open sets, or by V0-CLOSE's translation argument) in place of **FS106-DIAM (iii)**, **FS111-V0-CLOSE** and **FS116-V5-NE1's first clause**; and **FS106-DIAM (i)** (a connected set with no unit pair has diameter at most 1) once, in place of the connectedness step inside FS116-V5-NE1's "in particular", FS106-TS-C, FS116-V4-DICHOTOMY's "A ~ A" and FS111-V0-CLEAN's diameter step.

<!--q FS116-V4-DICHOTOMY merge@SR2-4.3-10-->
**Merge note — named** (SR2-4.3 item 10, `plans/FS129-SR2-audit.md:470-471`; status applied):
> 10. **FS129-SR2-HULLSET** in place of **FS111-C-HULL** (one measurable set with null unit pairs; no colouring, tightness or normal form). FS111-M-HULL2 over it; FS116-V4-DICHOTOMY's first clause is HULL2's case for two open tiles.

## FS116-V4-MEET
`plans/LEAN-BACKLOG.md:3369`; plans/FS116-derivation.md:988

**statement:**
> if tiles A, B of one colour have a common closure point z, then for every tile T of that colour, T ~ A holds if and only if T ~ B

**not_claimed:**
> anything when cl A and cl B are disjoint

## FS116-S1-CLUSTER
`plans/LEAN-BACKLOG.md:3220`; plans/FS116-derivation.md:838

**statement:**
> in a valid k-coloured fragment, for any k, Siamese pairs allowed, let 𝒯 be a finite family of tiles of one colour c the union of whose closures is connected, and U a tile of colour c; if some point of that union is at distance below 1 from some point of cl U, every point of the union is at distance at most 1 from every point of cl U

**not_claimed:**
> anything for an infinite family; that the tiles of 𝒯 are pairwise near

<!--q FS116-S1-CLUSTER merge@SR2-4.3-19-->
**Merge note — named** (SR2-4.3 item 19, `plans/FS129-SR2-audit.md:483-483`; status replaced-by:SR3-5.1-23):
> 19. **FS129-OR1-QFREE** in place of **FS116-S1-QF** (FS129-SR2-QFCASE); S1-QF's route (S1-LENS, S1-EXIT, S1-CLUSTER) is then a second route.

<!--q FS116-S1-CLUSTER merge@SR3-5.1-23-->
**Merge note — named** (SR3-5.1 item 23, `plans/FS129-SR3-audit.md:395-397`; status applied):
> 23. **FS129-SR3-QFREE-NS** in place of **FS129-OR1-QFREE** and **FS116-S1-QF** — S1-QF is its direct case (non-Siamese, six colours, a four-colour vertex, a (Q)-free ring; no "simple at `p`" step needed); S1-QF's own route (S1-LENS, S1-EXIT, S1-CLUSTER; V4-OUTER, S1-KAPPA's last clause) is a second route. This replaces SR2's item 19 (FS129-OR1-QFREE in place of S1-QF).

## FS129-OR1-WHOLE
`plans/LEAN-BACKLOG.md:5096`; plans/FS129-derivation.md:577

**statement:**
> let F be a valid k-coloured fragment on a closed disc B̄(p, r) about a point p, r > 1, a map of an open set V, and let 1 < ρ ≤ r; let 𝒯_ρ be the tiles of F that meet the open disc B(p, ρ), and F_ρ the map of the open set U_ρ = V ∩ int ⋃_{T ∈ 𝒯_ρ} cl T whose tiles are the tiles of 𝒯_ρ with their colours; then F_ρ is a valid k-coloured fragment on B̄(p, ρ′) for every ρ′ < ρ, each of its tiles is a tile of F with the same closure, the tiles of F_ρ having p in their closure are those of F, and F_ρ is non-Siamese if F is and simple if F is; and if moreover ρ ≤ √3, then for every arc α of Γ on ω(p) of positive length whose inner side is one tile, of colour c, no tile of F_ρ of colour c has a point of R₂(ᾱ) = {p + 2u : p + u ∈ ᾱ} in its closure

**not_claimed:**
> that the round restriction — the components of B(p, ρ) ∖ Γ — keeps non-Siamese or simple (it need not: § Control: fs129-or1-cut); anything about witness tiles when ρ > √3; simplicity read with closures taken relative to U_ρ (the statement reads them in the plane, as `data/fs116/claims.md` § 0 does)

**uses_only:**
> FS116-V4-DICHOTOMY (closure points at distance below 1 make two same-colour tiles near, above 1 far; non-Siamese means distinct same-colour tiles are far); FS116-V5-NE1 (a tile lies in B(z, 1) for every z in its closure); the parallelogram identity; local finiteness of Γ; the definitions of tile (a component of the open set minus Γ), Siamese and simple (`data/fs116/claims.md` § 0)

<!--q FS129-OR1-WHOLE merge@SR1-6.2-5-->
**Merge note — named** (SR1-6.2 item 5, `plans/FS129-SR1-audit.md:546-547`; status applied):
> 5. **FS129-SR1-BENDANY** and **FS129-SR1-BENDLE3** in place of FS129-OR1-BENDFRAG and FS129-OR1-BEND3, over FS129-OR1-WHOLE and FS112-N2-BENDS, by N2's route at end vertices (§ 2.1), with the connectedness step by quasi-components.

## FS116-V4-TWIST
`plans/LEAN-BACKLOG.md:3448`; plans/FS116-derivation.md:1003

**statement:**
> at a point p of a valid k-coloured fragment on a disc of radius above 1 about p, for any k, Siamese pairs allowed, no colour has a tile whose closure holds a germ g of ω(p) and a tile (the same or another) whose closure holds σg or σ⁻¹g; and a point of ω(p) inside a tile has that tile's colour absent at p when p is a vertex

**not_claimed:**
> anything about germs lying on Γ with the colour on neither side

## FS116-N1-TWIST-D
`plans/LEAN-BACKLOG.md:2568`; plans/FS116-derivation.md:108

**statement:**
> at a vertex p of a valid k-coloured fragment on a closed disc of radius above 1 about p, for any k ≥ 1, Siamese pairs allowed, any degree, the set D of points of ω(p) in the closure of a tile of one of p's colours is closed and lies in the union of the arcs of Γ on ω(p) and finitely many points

**not_claimed:**
> that D is non-empty; that D is contained in the arcs of Γ on ω(p) alone (the strip's P₀ has two isolated points of D, its change points)

<!--q FS116-N1-TWIST-D merge@SR2-4.3-21-->
**Merge note — to formalize** (SR2-4.3 item 21, `plans/FS129-SR2-audit.md:485-486`; status applied):
> 21. **FS116-RING-Q-PRIME-S** in place of **FS116-RING-Q-PRIME**; **FS116-N1-TWIST-D** in place of **FS116-RING-TWIST-C's first clause** and of **FS116-V5-RING's first two clauses**.

## FS116-N1-GERM-R
`plans/LEAN-BACKLOG.md:2543`; plans/FS116-derivation.md:414

**statement:**
> in a valid k-coloured fragment on a closed disc of radius above 1 about a point p, for any k, Siamese pairs allowed, let y = r(ψ) be a point of ω(p), c a colour, and v⁻, v⁺, u⁻, u⁺ the arcs of ω(p) just clockwise and just counter-clockwise of r(ψ − 60°) and r(ψ + 60°); if v⁻ lies in the closure of a tile of colour c, no tile of colour c approaches y along a direction β with β − ψ in (150°, 330°); for v⁺ the interval is (−30°, 150°), for u⁻ (−150°, 30°), and for u⁺ (30°, 210°)

**not_claimed:**
> anything about tiles that approach y only along the boundary directions ψ + 150°, ψ + 330°, ψ − 30°, ψ + 30°, ψ + 210°, ψ − 150°; anything when a germ lies on Γ with colour c on neither side

## FS116-N1-GERM-S
`plans/LEAN-BACKLOG.md:2622`; plans/FS116-derivation.md:452

**statement:**
> in a valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, Siamese pairs allowed, let y be a change point of the ring, X the colour of the ring just counter-clockwise of y and X̄ the colour just clockwise, and u⁻, u⁺, v⁻, v⁺ the arcs of ω(p) just clockwise and just counter-clockwise of the ring points y + 60° and y − 60°; then p has four colours and no more, X and X̄ are the colours absent at p, and (i) if neither v⁻ nor u⁺ lies on a (Q) arc, every direction at y in the open cone of 60° about the direction to p lies in the cone of a tile of a colour c of p every tile of p of which colour lies in B̄(y, 1); (ii) if neither u⁻ nor v⁺ lies on a (Q) arc, every direction at y in the open cone of 60° about the direction away from p lies in the cone of a tile, not a tile of p, of a colour c of p every tile of p of which colour misses B(y, 1); (iii) if none of the four lies on a (Q) arc, y is a vertex of at least four colours

**not_claimed:**
> anything at k ≥ 7; that the tile in (i) is a tile of p (that is RING-GERM, in the non-Siamese class); that a change point with a germ on a (Q) arc has fewer than four colours

## FS116-RING-Q-PRIME-S
`plans/LEAN-BACKLOG.md:3133`; plans/FS116-derivation.md:475

**statement:**
> in a valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, Siamese pairs allowed, every change point of the ring whose points at ±60° on ω(p) lie on no closed (Q) arc is a vertex of at least four colours

**not_claimed:**
> the change points with a point at ±60° on a (Q) arc (RING-Q, GAP)

<!--q FS116-RING-Q-PRIME-S merge@SR2-4.3-21-->
**Merge note — to formalize** (SR2-4.3 item 21, `plans/FS129-SR2-audit.md:485-486`; status applied):
> 21. **FS116-RING-Q-PRIME-S** in place of **FS116-RING-Q-PRIME**; **FS116-N1-TWIST-D** in place of **FS116-RING-TWIST-C's first clause** and of **FS116-V5-RING's first two clauses**.

## FS116-N1-QFREE4
`plans/LEAN-BACKLOG.md:2647`; plans/FS116-derivation.md:490

**statement:**
> at a vertex p of at least four colours of a valid fragment on a closed disc of radius above 1 about p, Siamese pairs allowed, if the ring carries no (Q) arc then p has four colours and no more

**not_claimed:**
> anything at k ≥ 7; anything when the ring carries a (Q) arc (then p may have five colours)

## FS116-N2-FIVERING
`plans/LEAN-BACKLOG.md:2701`; plans/FS116-derivation.md:655

**statement:**
> in a valid fragment on a closed disc of radius above 1 about a vertex p of five colours, Siamese pairs allowed, the ring has no change point, and for every θ outside a finite set r(θ) or r(θ + 60°) lies on a (Q) arc; so the (Q) arcs of the ring have total length at least 180° and p has no hub

**not_claimed:**
> anything at k ≥ 7; that a five-colour vertex occurs in any fragment

<!--q FS116-N2-FIVERING merge@SR1-6.2-3-->
**Merge note — to formalize** (SR1-6.2 item 3, `plans/FS129-SR1-audit.md:544-544`; status applied):
> 3. **FS116-N2-FIVERING** and **FS129-SR1-SIXQ** in place of FS112-SIX.

## FS129-SR1-SIXQ
`plans/LEAN-BACKLOG.md:5572`; plans/FS129-derivation.md:913

**statement:**
> let F be a valid k-coloured fragment, for any k ≥ 1, Siamese pairs allowed, on a closed disc of radius above 1 about a point p at which all k colours are carried; then ω(p) lies in Γ, and both side colours of every arc of Γ on ω(p) are carried at p; so at k = 6, when p carries six colours, every arc of Γ on ω(p) is a (Q) arc

**not_claimed:**
> FS116-N2-SIXRING's structure (six 60° arcs, each the ring points of one tile; it needs non-Siamese); anything when a colour is absent at p (five colours: FS116-N2-FIVERING); that a fragment with a six-colour vertex exists beyond radius 3/2

**uses_only:**
> FS116-N1-TWIST-D (the ring points in the closure of a tile of one of p's colours form a closed set lying in the union of the arcs of Γ on ω(p) and finitely many points); that every point of the fragment's open set lies in the closure of a tile (Γ, a locally finite union of arcs, has empty interior); the definition of (Q) (both side colours and at least four colours at the centre)

<!--q FS129-SR1-SIXQ merge@SR1-6.2-3-->
**Merge note — to formalize** (SR1-6.2 item 3, `plans/FS129-SR1-audit.md:544-544`; status applied):
> 3. **FS116-N2-FIVERING** and **FS129-SR1-SIXQ** in place of FS112-SIX.

## FS129-SR2-TOUCHW
`plans/LEAN-BACKLOG.md:5774`; plans/FS129-derivation.md:1120

**statement:**
> in a valid fragment on a closed disc of radius above 1 about a vertex p of four colours and no more, Siamese pairs allowed, let w be a point of ω(p) which is not a change point of the ring and lies on no arc of Γ on ω(p), and suppose none of the four arcs of ω(p) just clockwise and just counter-clockwise of w + 60° and w − 60° lies on a (Q) arc; then the ring just clockwise and just counter-clockwise of w lies in tiles of one colour X absent at p, each of the four arcs lies in the closure of a tile of the other absent colour X̄ and of no tile of colour X, and no tile of colour X̄ has w in its closure

**not_claimed:**
> anything at k ≥ 7; anything when a germ lies on a (Q) arc; that such a point exists in any fragment of SAT-QFREE's class

**uses_only:**
> FS116-N1-TOUCH's argument (plans/FS116-N1-proof.md § 4.2), in which the hypothesis "w in the closure of a tile of one of p's colours" is idle (FS116-V3 § 3.1: TRUE with it idle; § 4.4's uses-only note); FS116-N1-TWIST-D; N-E1; FS116-N1-GERM-R with c = X̄ at all four germs; six colours

<!--q FS129-SR2-TOUCHW merge@SR2-4.3-20-->
**Merge note — to formalize** (SR2-4.3 item 20, `plans/FS129-SR2-audit.md:484-484`; status applied):
> 20. **FS129-SR2-TOUCHW** in place of **FS116-N1-TOUCH** (its idle hypothesis dropped).

## FS116-N1-ECHO
`plans/LEAN-BACKLOG.md:2597`; plans/FS116-derivation.md:528

**statement:**
> in a valid k-coloured fragment on a closed disc of radius above 2 about a point p, for any k, Siamese pairs allowed, let w be a point of ω(p) whose ring just clockwise and just counter-clockwise of w lies in tiles of one colour X absent at p; if w is an essential boundary point at which the fragment is saturated (each colour of P(w) has a point of its support at distance exactly 1 from w) and X is in w's essential multicolour, the point 2w − p lies in the closure of a tile of colour X

**not_claimed:**
> anything when X has density 0 at w (a cusp); that the X-tile at 2w − p exists in any fragment of SAT-STRIP's class

## FS116-V5-U1
`plans/LEAN-BACKLOG.md:3859`; plans/FS116-derivation.md:1538

**statement:**
> let A be an arc of Γ on ω(z), of angular extent [θ₁, θ₂] about z, θ₂ − θ₁ = ℓ > 0, with inner side colour c and outer side colour c′; a tile of colour c with z in its closure has its cone at z in the closed cone [θ₂ − 90°, θ₁ + 90°] facing A; one of colour c′ has it in the closed cone [θ₂ + 90°, θ₁ + 270°] facing away; the two open side cones (θ₁ − 90°, θ₂ − 90°) and (θ₁ + 90°, θ₂ + 90°) hold neither colour; so if z carries both c and c′ (A is both-kind), the side cones hold two further colours and, in a non-Siamese simple fragment, z has at least four colours

**not_claimed:**
> anything when ℓ = 0; anything about tiles at z of other colours

<!--q FS116-V5-U1 merge@SR1-6.2-4-->
**Merge note — to formalize** (SR1-6.2 item 4, `plans/FS129-SR1-audit.md:545-545`; status applied):
> 4. **FS116-V5-U1**'s first three clauses in place of FS112-U1's; U1's shadow clause and V5-U1's four-colour clause as two corollaries.

## FS116-Y4-FLANK
`plans/LEAN-BACKLOG.md:4320`; plans/FS116-derivation.md:1686

**statement:**
> let t be a tile of a valid fragment, Siamese pairs allowed, on a closed disc of radius above 1 about a point p, and let y = r(ψ) and y′ = r(ψ + 60°) be points of ω(p) in the closure of t such that the cone of t at y contains the open cone (ψ + 150°, ψ + 210°) and its cone at y′ contains (ψ + 210°, ψ + 270°); then t's cone at y ends at ψ + 210° and its cone at y′ begins at ψ + 210°, and if a is the tile bordering t at y along t's edge leaving y in the direction ψ + 210°, and b the tile bordering t at y′ along t's edge leaving y′ in the direction ψ + 210°, some point of the closure of a and some point of the closure of b are at distance below 1

**not_claimed:**
> anything about the colours of a and b; that a ≠ b; that the cones contain the open cones (an input, here from RING-GERM (i))

<!--q FS116-Y4-FLANK merge@SR1-6.2-1-->
**Merge note — replaced in whole or in the part the line names** (SR1-6.2 item 1, `plans/FS129-SR1-audit.md:541-542`; status applied):
> 1. **FS129-SR1-TWOCIRC** once, in place of the identity steps inside FS114-Y5-PXKILL, FS116-V6-HUG, FS116-V6-ADJ and FS116-Y4-FLANK (each keeps its own pinning of two tiles).

## FS116-S1-EXIT
`plans/LEAN-BACKLOG.md:3253`; plans/FS116-derivation.md:906

**statement:**
> let 30° < b < 90° and −90° < a < −30°, y_b = e(b), y_a = e(a), y_3 = e(b + 60°), y_5 = e(a − 60°) and Λ = B(y_a, 1) ∩ B(y_b, 1); let γ on [0, t_e] be a C¹ curve with γ(0) = 0, γ(t) in Λ for 0 < t < t_e and γ(t_e) in ∂Λ other than 0, with left unit normal ν; if at t_e |γ + ν − y_3| ≤ 1, |γ − ν − y_5| ≤ 1, |γ − y_3| ≥ 1 and |γ − y_5| ≥ 1, then γ(t_e) + ν(t_e) = y_b or γ(t_e) − ν(t_e) = y_a

**not_claimed:**
> anything about colourings (it is a lemma on curves and four points); that such a curve exists

<!--q FS116-S1-EXIT merge@SR2-4.3-19-->
**Merge note — named** (SR2-4.3 item 19, `plans/FS129-SR2-audit.md:483-483`; status replaced-by:SR3-5.1-23):
> 19. **FS129-OR1-QFREE** in place of **FS116-S1-QF** (FS129-SR2-QFCASE); S1-QF's route (S1-LENS, S1-EXIT, S1-CLUSTER) is then a second route.

<!--q FS116-S1-EXIT merge@SR3-5.1-23-->
**Merge note — named** (SR3-5.1 item 23, `plans/FS129-SR3-audit.md:395-397`; status applied):
> 23. **FS129-SR3-QFREE-NS** in place of **FS129-OR1-QFREE** and **FS116-S1-QF** — S1-QF is its direct case (non-Siamese, six colours, a four-colour vertex, a (Q)-free ring; no "simple at `p`" step needed); S1-QF's own route (S1-LENS, S1-EXIT, S1-CLUSTER; V4-OUTER, S1-KAPPA's last clause) is a second route. This replaces SR2's item 19 (FS129-OR1-QFREE in place of S1-QF).

## FS116-Y2-SIXFRAG
`plans/LEAN-BACKLOG.md:4092`; plans/FS116-derivation.md:365

**statement:**
> the unit sector flower S_j (colour j), the six lenses Q_j between e(60j − 30°) and e(60j + 30°) outside ω(p) (colour j + 2) and the six gap tiles G_j at e(60j + 30°) (colour j + 4), all cut at |x| = 3/2, form a valid non-Siamese six-coloured fragment holding B̄(p, R) for every R < 3/2, in which p is a vertex of six colours whose ring lies in Γ and all of whose ring arcs are (Q) arcs

**not_claimed:**
> any R ≥ 3/2 in this form (at 8/5 each G_j exceeds diameter 1: the plant); that the fragment extends; Y-QRING (3/2 < φ²/√2); that a vertex of six colours occurs in any valid map

## FS129-SR1-RINGBAND
`plans/LEAN-BACKLOG.md:5538`; plans/FS129-derivation.md:933

**statement:**
> let c colour the circle by ℤ/3, defined and locally constant off a finite set Σ of change points, with c(θ) ≠ c(θ + 60°) wherever both are defined; lift c to c̃, changing by +1 or −1 at each change point, and put W = (c̃(θ + 360°) − c̃(θ))/3; for θ with no point θ + 60°j in Σ put D_j(θ) = c̃(θ + 60°(j + 1)) − c̃(θ + 60°j), m_j(θ) = ⌊D_j(θ)/3⌋, n₂(θ) = #{j : D_j(θ) ≡ 2 (mod 3)} and h(θ) = (1/3) Σ_{j=0..5} d(c(θ + 60°j), c(θ + 60°(j + 1))), with d(x, y) = ±1 as y = x ± 1 (FS129-OA1-RINGWIND's W); then (i) h(θ) = (6 − 2n₂(θ))/3, a value in {−2, 0, 2}; (ii) W = m_0(θ) + m_1(θ) + … + m_5(θ) + 3 − h(θ)/2; (iii) h changes across θ₀ only if Σ holds two points θ₀ + 60°j and θ₀ + 60°(j + 1); (iv) if no point of Σ is a swap point (a change point x with c(x + 60°−) = c(x+) and c(x + 60°+) = c(x−), or the same with −60°), all m_j(θ) equal one integer M, W is 6M + 2, 6M + 3 or 6M + 4, and W = 6M + 3 unless Σ is invariant under the rotation by 60°; (v) if no two points of Σ are 60° apart, h is 0 everywhere and W = 6M + 3

**not_claimed:**
> anything about tiles or maps (the circle colouring is the input; FS110-N2-RING's setting — a three-colour vertex whose ring carries no arc of Γ, coloured by its three absent colours — supplies one); that h is constant across two change points 60° apart (the swap moves it, row 132 and G71)

**uses_only:**
> c(θ) ≠ c(θ + 60°), so no D_j is ≡ 0 (mod 3); that Σ is finite; at an event, the change of D_j is Δ_{j+1} − Δ_j (Δ_j the step crossed at the hexagon's j-th point, 0 if none), so the changes sum to zero; FS110-N2-RING's band step (D_0 leaves {3M + 1, 3M + 2} only by a jump of ±2, which needs a swap)

<!--q FS129-SR1-RINGBAND merge@SR1-6.2-8-->
**Merge note — to formalize** (SR1-6.2 item 8, `plans/FS129-SR1-audit.md:550-550`; status applied):
> 8. **FS129-SR1-RINGBAND** in place of FS110-N2-RING, FS110-Y3-GP and FS129-OA1-RINGWIND, should any of them be formalized.

## FS116-N1-TOUCH — merged into FS129-SR2-TOUCHW
`plans/LEAN-BACKLOG.md:2672`; plans/FS116-derivation.md:507

**statement:**
> in a valid fragment on a closed disc of radius above 1 about a vertex p of four colours and no more, Siamese pairs allowed, let w be a point of ω(p) in the closure of a tile of one of p's colours which is not a change point of the ring and lies on no arc of Γ on ω(p), and suppose none of the four arcs of ω(p) just clockwise and just counter-clockwise of w + 60° and w − 60° lies on a (Q) arc; then the ring just clockwise and just counter-clockwise of w lies in tiles of one colour X absent at p, each of the four arcs lies in the closure of a tile of the other absent colour X̄ and of no tile of colour X, and no tile of colour X̄ has w in its closure

**not_claimed:**
> that such a point exists in any fragment of SAT-QFREE's class; anything at k ≥ 7; anything when a germ lies on a (Q) arc

<!--q FS116-N1-TOUCH merge@SR2-4.3-20-->
**Merge note — replaced in whole or in the part the line names** (SR2-4.3 item 20, `plans/FS129-SR2-audit.md:484-484`; status applied):
> 20. **FS129-SR2-TOUCHW** in place of **FS116-N1-TOUCH** (its idle hypothesis dropped).

## FS116-RING-Q-PRIME — merged into FS116-RING-Q-PRIME-S
`plans/LEAN-BACKLOG.md:3104`; plans/FS116-derivation.md:201

**statement:**
> in a non-Siamese simple valid fragment on a closed disc of radius above 2 about a vertex p of at least four colours whose ring carries a (Q) arc, every change point of the ring whose points at ±60° on ω(p) lie on no (Q) arc is a vertex of at least four colours

**not_claimed:**
> the change points with a point at ±60° on a (Q) arc (RING-Q, GAP); "lie on" read as the open arc (then a ±60° point may end a (Q) arc, as at the strip's P₂, and RING-GERM gives only one of the tip and the outer tile)

<!--q FS116-RING-Q-PRIME merge@SR2-4.3-21-->
**Merge note — replaced in whole or in the part the line names** (SR2-4.3 item 21, `plans/FS129-SR2-audit.md:485-486`; status applied):
> 21. **FS116-RING-Q-PRIME-S** in place of **FS116-RING-Q-PRIME**; **FS116-N1-TWIST-D** in place of **FS116-RING-TWIST-C's first clause** and of **FS116-V5-RING's first two clauses**.

## FS110-N2-RING — merged into FS129-SR1-RINGBAND
`plans/LEAN-BACKLOG.md:6819`; plans/FS110-derivation.md:214

**statement:**
> At a three-colour vertex whose unit circle carries no arc of `Γ` the ring has a winding `W`; `|W| ≤ 1` forces a swap point.

<!--q FS110-N2-RING merge@SR1-6.2-8-->
**Merge note — replaced in whole or in the part the line names** (SR1-6.2 item 8, `plans/FS129-SR1-audit.md:550-550`; status applied):
> 8. **FS129-SR1-RINGBAND** in place of FS110-N2-RING, FS110-Y3-GP and FS129-OA1-RINGWIND, should any of them be formalized.

## FS110-Y3-GP — merged into FS129-SR1-RINGBAND
`plans/LEAN-BACKLOG.md:6845`; plans/FS110-derivation.md:241

**statement:**
> A ring with no two change points exactly 60° apart winds `W ≡ 3 (mod 6)`; so `|W| ≤ 2` needs two change points at distance exactly 1.

<!--q FS110-Y3-GP merge@SR1-6.2-8-->
**Merge note — replaced in whole or in the part the line names** (SR1-6.2 item 8, `plans/FS129-SR1-audit.md:550-550`; status applied):
> 8. **FS129-SR1-RINGBAND** in place of FS110-N2-RING, FS110-Y3-GP and FS129-OA1-RINGWIND, should any of them be formalized.

## FS112-SIX — merged into FS116-N2-FIVERING;FS129-SR1-SIXQ
`plans/LEAN-BACKLOG.md:1523`; plans/FS112-derivation.md:48

**statement:**
> A vertex with five colours has unit arcs centred at it of total length at least 180°; with six, its whole unit circle lies in `Γ`, every arc of kind both.

<!--q FS112-SIX merge@SR1-6.2-3-->
**Merge note — replaced in whole or in the part the line names** (SR1-6.2 item 3, `plans/FS129-SR1-audit.md:544-544`; status applied):
> 3. **FS116-N2-FIVERING** and **FS129-SR1-SIXQ** in place of FS112-SIX.

## FS116-RING-TRANSFER-C — merged into FS116-N2-FIVERING;FS116-N2-SIXRING (wave 8)
`plans/LEAN-BACKLOG.md:3191`; plans/FS116-derivation.md:769

**statement:**
> in a non-Siamese simple valid fragment on a closed disc of radius above 2 about a vertex p of at least four colours: a ring of five or six colours has no change point and places no vertex through RING-GERM, the six-colour ring being six 60° (Q) arcs, one per tile of p, each tile in the Reuleaux triangle on its arc; a ring of four colours places its hubs, and at each hub y = r(ψ) the ring of p and the tiles of p holding the directions ψ + 90° and ψ − 90° determine the colours of y as the absent pair of p, the tip colours and the outer colours, and the pair missing at y, which contains the colour of every tile of p holding ψ ± 90° inside its cone; when y has four colours and its ring meets no (Q) arc at the points r(ψ ± 60°) and no arc of Γ at p, p is a change point of y's ring between the two colours missing at y; two antipodal hubs whose flanking directions lie inside tiles of p miss the same pair and exchange tip and outer colour; and a ring free of arcs of Γ has, among any four consecutive of its six hubs, one whose ring carries an arc of Γ

**not_claimed:**
> that the ring type of p alone determines any of this (the star is an input); anything about the arcs of Γ on the placed vertex's ring outside B̄(p, 1); the recurrence of types with (Q) arcs (RING-TRANSFER-Q, GAP); that the rule is the same at k = 7 (every step spends six: two absent colours)

<!--q FS116-RING-TRANSFER-C merge@SR1-6.2-DNF-->
**Merge note — do not formalize as stated** (SR1-6.2 item DNF, `plans/FS129-SR1-audit.md:552-554`; status applied):
> **Do not formalize as stated (empty):** FS116-Y3-NOQ, -Y3-TIGHT, -Y3-HUBCOL, -Y3-LENS, -Y3-NBTIP, -Y3-TIGHTLENS, -Y3-STARFORCE, -Y4-SYM, -Y4-SPOKE, -Y4-Q1, -V6-ADJ, -V1-FRAME, -N2-HEX6, -N2-HEX3; FS114-N7-HUB (empty given FS129-OR1-QFREE) and with it FS114-N7-3T; FS116-RING-TRANSFER-C's four-colour clause.


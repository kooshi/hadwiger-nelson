# FS110-CB — blind second mind on Sokolov–Voronov's Corollary 1 (cubic maps), almost everywhere, curved boundaries

*Coxeter (Opus 5.5), 2026-09-27. Blind: nothing fenced by the brief (`data/fs110/briefs/CB110-cor1-blind.md`) or by standing rule 13 was
opened before stage 3 was committed. Sources read: `[SokolovVoronov2025]` (`~/source/library/pdf/arXiv-2502.01958-maptype.pdf`, v1, pp. 1–29,
text and Fig. 5 rendered), `[Voronov2023]` (`~/source/library/pdf/arXiv-2304.10163-voronov.pdf`, §§1–6), `CLAUDE.md` § The aim and
§ Counter-priors from disk.*

## Theorems this phase proved

*(filled at stage 3; one line per theorem, grade and address)*

## Stage 1 — SAVED

### 1.1 The quotation check (standing rule 5)

Every statement below is copied from the held PDF's text layer (`pdftotext -layout`), checked against the rendered page.

- **Condition 3** (p. 3): "Condition 3. (lf = “locally finite”) A Jordan coloring of a plane is called locally finite if any bounded subset of
  the plane intersects only a finite number of boundaries."
- **Condition 5** (p. 4): "Condition 5. (fa = “forbidden arcs”) If any boundary intersects with a circle of unit radius at a finite set of
  points, we say that arcs of unit curvature are forbidden."
- **Condition 6** (p. 4): "Condition 6. (3col = “no trichromatic vertices of degree 4+”) There are no trichromatic vertices of degree greater
  than 3."
- **Condition 7** (p. 4; Corollary 1's "cubic"): "Condition 7. (cubic = “no vertices of degree 4+”) The degree of any vertex is 3, or, in other
  words, the map is an embedding of some planar cubic graph."
- **Corollary 1** (p. 5): "Corollary 1. χmap+f a+cubic (R2 ) = 7." — preceded by "Obviously, Condition 7 is stronger than Condition 6. The
  formulation is somewhat simplified." Theorem 1 (p. 5): "If the coloring is proper, Jordan, locally finite, if a vertex with degree greater
  than 3 cannot be trichromatic, and if arcs of unit curvature are forbidden, then at least 7 colors will be required, i.e. χmap+f a+3col (R2 ) = 7."
- **Lemma 3** (p. 17): "Suppose that the Conditions 4, 5 (“map-type”, “forbidden arcs”) are satisfied for a proper 6-coloring. Then there do not
  exist two trichromatic points u1 , u2 with same multicolor such that 1 < ∥u1 − u2 ∥ < 2 and the boundaries between each pair of colors in their
  multicolor extend from each of them."
- **Lemma 4** (p. 19): "Suppose that the Conditions 4, 5, 6 (“map-type”, “forbidden arcs”, “no trichromatic vertices of degree 4+”) are
  satisfied for a proper 6-coloring. Then there are either two trichromatic points between 1 and 2 with the same multicolor, or two trichromatic
  points less than 2 with non-intersecting multicolors."

**Checks of the brief's own citations.**

| brief says | source | verdict |
|---|---|---|
| "Voronov's bicycle argument (`[Voronov2023]` Lemma 6.1 …)" | Voronov's Lemma 6.1 (p. 12) is the *pigeonhole* lemma: "If a proper discrete coloring of the plane with 6 colors exists, then it contains such a pair of trichromatic points u, v that C(u) = C(v), 1 < ∥u − v∥ < 2." The bicycle is **§5, "Chromatic number of the bicycle"**, proving **Theorem 1.2**: "for ε > 0 and 1 < ∥u − v∥U < 2 it holds that χ[1−ε,1+ε] (T1 (u) ∪ T1 (v); U ) ≥ 4." | **MISCITED** (the argument meant is Thm 1.2 / §5; Lemma 6.1 is S–V Lemma 4's source). Harmless to the question; logged. |
| Lemma 3's proof "uses Fig. 5's three curves" | p. 18–19: curves pq1′, pq2′, pq3′ with "q1′ p ∼ pq2′ , q2′ p ∼ pq3′ , q3′ p ∼ pq1′" | **matches** |
| Statement 1's tiles "bounded by finitely many circular arcs and segments, none an arc of radius 1" as "under Condition 5" | a circle of radius r ≠ 1, or a line, meets a unit circle in ≤ 2 points; an arc of radius 1 meets its own circle in an arc | **equivalent** for such tiles (Condition 5 ⟺ no boundary arc of radius 1) |
| Statement 1's "six-colouring in which same-coloured tiles contain no two interior points at distance exactly 1" | S–V's Condition 1 is everywhere-properness with boundary points coloured (Observation 1) | **a different, weaker hypothesis** (boundaries free); S–V's chain must be re-derived for it, which is the task |
| "Woodall 1973's step 3", "FS-106 repaired its printed proof, except at the `d = 2` edge case" | not a statement I verify; fenced records | **not checked** (context only) |

A textual slip in the paper, logged: p. 19 says "q1 , q3 ∈ A1 and q2 ∈ A2"; in Fig. 5 (rendered at 200 dpi) q1 and q2 both lie in the annulus of
ω(u1) and q3 in that of ω(u2) (measured on the figure: q2 at 303 px from u1, radius 338 px, annulus 303–373; 240 px from u2).

### 1.2 Restatements (mine, before any derivation)

Setting **M**: a locally finite partition of ℝ² into open tiles by boundary arcs, each arc a segment or a circular arc of radius ≠ 1, every vertex
of degree 3; a colouring c : tiles → {1,…,6} with **(AE)**: no two interior points of tiles of one colour are at distance exactly 1. Adjacent
tiles of one colour are allowed by (AE); merging them first (deleting the arc between them) keeps M's shape, except that vertices can become
degree-2 *corners* (bichromatic) and a vertex survives as a *vertex* only when its three tiles have three colours. Multicolour c(x) := colours of
tiles whose closure contains x (S–V Def. 2); chromaticity ≤ 3 everywhere, = 3 exactly at trichromatic vertices, where three arcs meet.

- **S1 (Corollary 1, AE form).** No colouring (M, AE) with six colours — possibly except for a *d = 2 configuration* (S3).
- **S2 (Lemma 3, AE form).** No two trichromatic vertices u1, u2 of (M, AE, 6 colours) with c(u1) = c(u2) and 1 < |u1 − u2| < 2, in particular for
  √3 ≤ |u1 − u2| < 2.
- **S3 (the d = 2 case, as I read it before deriving).** Two trichromatic vertices p, p′ with c(p) = c(p′) and |p − p′| = 2, both on ω(u) for a
  trichromatic u with c(u) ∩ c(p) of size one, arising as the pigeonhole outcome of S–V Lemma 4 when the boundaries it follows end *on* the
  circle rather than inside it.

### 1.3 Registered expectation (before stage 2; both outcomes reachable)

| claim | expectation | what would move me to the other outcome |
|---|---|---|
| S2 at √3 ≤ d < 2 | **TRUE, via the bicycle run on the two circles with a pseudo-colouring**, 0.7 | an endpoint of the bicycle (x0, y0, x1, y1, z1) at a colour change that the ε-free setting cannot move off, with no exact replacement for Voronov's "α-rotation" |
| the printed Fig. 5 argument | **fails for some d ≥ √3** by a change of which arc a unit segment's far end runs along, 0.6 | the three complementary pairs surviving for all d ∈ (1, 2) |
| S1 bar d = 2 | **TRUE**, 0.55; else GAP at S–V Prop. 17 or Prop. 19's recolouring in the AE setting, 0.35 | a step of Lemma 4's pigeonhole needing properness *at* boundary points |
| S3 reachable | **the chain can be arranged to avoid it**, 0.35; else it stands as a real edge case, 0.65 | a derivation that circle-to-circle boundaries are harmless, or a configuration showing Lemma 4's pigeonhole must return an antipodal pair |

### Would have searched here (standing rule 3)

- (none yet)

## Stage 2 — SAVED (the derivations)

Setting (M, AE) of §1.2, six colours, after merging adjacent same-coloured tiles. Notation: `ω(x)` the unit circle about x; `c(x)` the
multicolour; for a trichromatic vertex u with `c(u) = {4,5,6}`, `Ω = ω(u)` and the **pseudo-colour** `c′(x) = c(x) ∩ {1,2,3}` (S–V Def. 7).

### D1 — the one tool AE needs (replaces S–V Props. 1, 3, 4 and Lemma 1)

**(P) sweep.** If `ω(y)` contains an interior point of a tile of colour a, then `a ∉ c(y)`. *Proof:* a ball `B(z, r)` about that point lies in
the tile; every `y′ ∈ B(y, r)` has `ω(y′) ∩ B(z, r) ≠ ∅`, so by (AE) no tile of colour a meets `B(y, r)`. ∎

**(P′) unit pairs never nest.** If `|x − y| = 1` then `c(x) ⊄ c(y)`. *Proof:* the boundary arcs through x are finitely many (Condition 3) and
each meets `ω(y)` finitely (Condition 5), so for small ρ the punctured arc `ω(y) ∩ B(x, ρ) \ {x}` is two open arcs, each inside one tile whose
closure contains x; by (P) the colour of either is absent from `c(y)` while present in `c(x)`. ∎ Consequences: S–V Lemma 1 (two bichromatic
points with one multicolour at unit distance) holds AE, at corners and vertices too; **two trichromatic points with one multicolour are never at
distance exactly 1** (so `d = 1` is not an edge case).

**Transversal form.** If x ∈ Ω and `ω(y)` crosses Ω transversally at x (iff `|y − u| ≠ 2`, y ≠ u), then `ω(y)` meets both sides of Ω in every
ball about x.

### D2 — the strip, the pseudo-colouring, and Corollary 3 AE (replaces S–V Props. 9–11, Cor. 2, Cor. 3)

At u the three arcs leave with tangents `τ45, τ46, τ56`; `x_ij(δ)` their points on the circle of radius δ. S–V Prop. 2 holds AE (a curve in the
i-tile beside the arc from u to `x_ij` meets `ω(z)` when `|z−u| < 1 < |z−x_ij|`). For e ∈ Ω and fixed small δ the three numbers
`|u + e − x_ij(δ)| − 1` are nonzero unless `ω(u+e)` passes through some `x_ij(δ)` — six directions for each δ, which move with δ because no
arc from u lies on a unit circle (Condition 5). Choosing δ per direction, each e has a neighbourhood `N_e` and a side σ_e (the side named by the
majority sign) such that **every tile point of `N_e` strictly on side σ_e of Ω has colour in {1,2,3}** (repairs S–V Prop. 10, whose printed
proof asserts more than "e ∉ Int A ∪ Int B" gives). A finite subcover gives, for every η > 0, a closed curve γ(u) within η of Ω, winding once
about u, each point of which has multicolour ⊆ {1,2,3} (where sides switch, the curve crosses Ω inside `N_e ∩ N_e′`, where both sides and Ω
itself are {1,2,3}). Consequences:
- **Cor. 3 AE**: no two trichromatic vertices with disjoint multicolours at distance < 2 (γ(u) and γ(v) meet; a common point would have empty
  multicolour).
- **The pseudo-colouring of Ω**: `c′ ≠ ∅` everywhere; `|c′| ≤ 2` (Cor. 3 AE at distance 1); finitely many points with `|c′| = 2` (Conditions 3, 5);
  `{x : a ∈ c′(x)}` closed, so c′ is locally constant off those points and **c′(w) ⊆ c′(x) for w near x**; if `c′(x) = {a}` every tile point of
  `N_x` on side σ_x is colour a.
- **(i)/(ii) under transversality.** For x ∈ ω(u1), y ∈ ω(u2) (or one circle), `|x−y| = 1`, and `ω(y)` transversal to ω(u1) at x **or** `ω(x)`
  transversal to ω(u2) at y (both fail only if `|u1−u2| = 3`): (i) `c′(x) = c′(y) = {a}` is impossible; (ii) `c′(x) = c′(y) = {a,b}` is
  impossible. *Proof:* the transversal circle enters the strip beside x, a tile of a colour in c′(x); (P) removes it from c(y). ∎

### D3 — why Fig. 5 fails beyond √3 (the printed Lemma 3 proof)

Frame `u1 = 0, u2 = (d,0)`, `p0 = (d/2, h)`, `θ0 = arccos(d/2)`, q1, q2 = p0 rotated ±60° about u1, q3 = p0 rotated −60° about u2 (the far one).
The printed relation `q3′p ∼ pq1′` needs the far end of a unit segment whose near end runs u2's arc from q3 to p0 to arrive at q1. The far end is
a branch of `ω(x) ∩ ω(u1)`, continuous while `|x − u1| < 2`; along the open arc it is (`|x−u1|² < |q3−u1|²`); at the start the branch is p0, and
which side of the line q3u1 p0 lies on changes exactly when `|q3 − u1| = 2`. **Identity:** `|q3 − u1|² = 1 + d²/2 + √3·d·√(1 − d²/4) =
2 + 2cos(2θ0 − 60°)`, which is 4 only at θ0 = 30°, i.e. **d = √3**, and < 4 otherwise. So for d < √3 the branch ends at q1 (the printed 3-cycle
`−a~b, −b~c, −c~a` of index signs is odd: a contradiction, and S–V's proof stands there once D1–D2 replace its AE-sensitive steps); **at d = √3 the
segment is tangent (degenerate); for d > √3 it ends at q2**, the relations become `q1′p ∼ pq2′, q2′p ∼ pq3′, q3′p ∼ pq2′`, whose sign pattern
(`sign b = −sign a`, `sign c = −sign b`, `sign b = −sign c`) is consistent — **no contradiction; the printed argument fails for √3 ≤ d < 2.**
(`q2′p ∼ pq3′` never flips: `|q2 − u2|² = 2 + 2cos(2θ0 + 60°) < 4` on (1,2).) Exact identity and the branch endings at nine values of d, with a
plant (the other choice of q3) that fires: `tools/fs110_cb_geometry.py` → `data/fs110/fs110-cb/geometry-check{,-plant}.out`.

### D4 — Lemma 3 AE for every 1 < d < 2, by the bicycle run exactly on the two pseudo-coloured circles

Ω1 = ω(u1), Ω2 = ω(u2), `c(u1) = c(u2) = {4,5,6}`. Lifts: `g` on Ω1's arc, `f` on an arc of Ω2 shorter than 360°, integer-valued off colour
changes, `≡` colour mod 3, jumping ±1 at each colour change of the pseudo-colouring. x(t) runs Ω1 from `x0` (`|x0 − u2| = 2`) to `x1 = p0`;
y(t), z(t) are the two points of `ω(x(t)) ∩ Ω2`, `y(0) = z(0) = y0`, ending at `y1, z1` = x1 rotated ±60° about u2. R = rotation by 60° about u2.
1. **Bands.** For a unit-distance pair moving continuously with transversality (all t ∈ (0,1]; at t = 0 only `ω(x0)` is tangent, and
   `|y0 − u1| ≤ (1+d)/2 < 2`), `D = g(x) − f(y)` avoids `3ℤ` (by (i)), changes by 0 or ±1 at each of finitely many special times, and a ±2 step
   is exactly a swap `(a,b) → (b,a)`, excluded by (ii); so D stays in one band `{3m+1, 3m+2}`. Near t = 0 `f(z) − f(y) ∈ {−1,0,1}`, so `D_y` and
   `D_z` share the band. Likewise `E = f(w) − f(Rw)` on w ∈ [y1, x1] stays in one band n; WLOG n = −1 (negating colours), so each 60° step raises
   f by 1 or 2.
2. **Geometry (D3's tool, C3).** `dφ/dθ = cross(x−u1, w−x)/cross(w−u2, w−x)`, so a partner turns only where `|w − u1| = 2`, i.e. at
   `cos θ* = (3+d²)/(4d)`, which lies on the path iff **d > √3**. Hence y is monotone and reaches y1 from inside the 120° arc [y1, z1] through x1
   (which contains y0) for every d; z is monotone for d ≤ √3, and **for d > √3 overshoots and reaches z1 from outside**. The swept arcs stay
   under 360°, so one lift f serves.
3. **Endpoints, exactly (this replaces Voronov's "α-rotation", which needs the ε-band).** Put `a = f(y1^in)`, `J = f(x1^z) − f(x1^y)`,
   `J_z = f(z1^approach) − f(z1^in)` (`J_z = 0` for d ≤ √3). Band n gives `f(x1^z) = a + e1`, `f(z1^in) = a + e1 − J + e2`, `e1, e2 ∈ {1,2}`. The
   bicycle bands give `D_y − D_z = e1 + e2 − J + J_z ∈ {−1,0,1}`, `G := g(x1^←)` with `D_y = G − a`. Forcing `J − J_z ≥ e1 + e2 − 1 ≥ 1` leaves:
   - `J = 1, J_z = 0, e1 = e2 = 1`: `D_y ≡ 2` forces `G ≡ a + 2`, but G's colour lies in `c′(x1) = {a, a+1}` — contradiction;
   - `J = 1, J_z = −1, e1+e2 = 2`: `c′(x1) = c′(z1) = {a, a+1}` at `|x1 − z1| = 1` — contradicts (ii);
   - `J = 1, J_z = −1, e1+e2 = 3`: `e1 = 2` gives `c′(x1) = c′(z1)`, contradicting (ii); `e1 = 1` forces `G ≡ a+2 ∉ c′(x1)`;
   - `J = 0, J_z = −1, e1 = e2 = 1`: `G ≡ a + 2 ∈ c′(x1)` forces `c′(x1) = {a+1, a+2} = c′(z1)` — contradicts (ii).
   Every case closes. ∎ **S2 is TRUE for all 1 < d < 2** (hand, one mind); at √3 ≤ d < 2 the new ingredient over the printed proof is exactly
   the overshoot case `J_z ≠ 0`.

### D5 — Lemma 4 AE, and where distance exactly 2 can enter

S–V's printed Lemma 4 (Appendix) takes nine bichromatic points B of Ω (three per pair, pairwise > 1 apart), follows each pair-boundary inward to a
trichromatic endpoint "inside the circle", pigeonholes 10 + 1 multicolours, and closes by Lemma 3 (`1 < d < 2`) or Cor. 3 (`d < 2`).
**Distance exactly 2 arises only between two points of the closed disc that both lie on Ω, antipodally** — a path endpoint that is a vertex
*on* Ω — for a same-multicolour pair (S3) **and equally for a disjoint pair** (the "11th point" lies on ∂R ⊂ closed disc). S–V's Prop. 19 rules
out circle-to-circle paths by recolouring the cut-off region Q in the *plane*; AE that recolouring is proper only for pairs inside the closed
disc, and where the {1,2,3}-strip at an arc point lies *outside* Ω it changes the pseudo-colour there (a Q-colour and an outside colour both
touch the point), so the printed step does not transfer as written. **Repair — reduce the circle colouring, never the plane:**
1. A *circle-to-circle path* is an {a,b}-boundary path inside the open disc joining two points of Ω with `c′ ⊇ {a,b}` (a vertex on Ω counts).
   Its ends are < 1 apart (the a-tile along it has diameter ≤ 1; = 1 is (P′)); paths do not cross; their arcs (< 60°) nest or are disjoint.
2. Recolour each maximal such arc [p1, p2] of the pseudo-colouring by a, the colour of the tile beside the path outside Q (it is also Ω's colour
   just outside the arc at both ends).
3. **(i) survives:** for x in a recoloured arc and w = x ± 60°, `ω(w)` enters Q at x and leaves through the path, meeting the a-tile, so
   `a ∉ c(w)` by (P); if w lies in another recoloured arc with the same colour a, the two a-tiles' side curves C, C′ satisfy `|C(p2) − C′(p1′)| < 1
   < |C(p1) − C′(p2′)|` (arcs < 60°, `x+60° ∈ [p1′,p2′]`), so a point pair at distance exactly 1 exists by continuity on the parameter square —
   contradiction. **(ii) survives** (surviving colour changes are original ones with original pairs).
4. **Every surviving colour change's inward path ends at a trichromatic vertex of the OPEN disc** (a path that met Ω again would have made it an
   arc end); its third colour is in {4,5,6} (a {1,2,3} vertex is at distance < 2 from u, Cor. 3).
5. Lemma 5 (Voronov's Prop. 3.2 order) and Prop. 18 (Voronov's Prop. 3.3) are circle-abstract and need only (i), (ii): read and accepted,
   not re-derived line by line. **Prop. 17 (no regular hexagon of six 60° arcs) AE, re-derived:** at each x_i, (P′) from `x_{i±1}` puts the
   branches of `ω(x_{i+1})` (directions +30°, −150° from the outward normal) in `{c_{i−1}, q}` and those of `ω(x_{i−1})` (−30°, +150°) in
   `{c_i, q}`; an edge point (no q) is then impossible (a boundary ray would need β > 30° and β < −30°), and for a vertex the interval structure of
   the three sectors forces the q_i-sector to contain `[−30°, 30°]`. So consecutive `q_i` differ (ω(x_{i+1}) meets the q_i-tile), and by (P) at
   u (z = x_i + t e_i reaches u's q_i-sector at radius ≈ t/⟨d, e_i⟩) u's q_i-sector lies in `{⟨d, e_i⟩ ≤ 0}`. Each colour class of the q's is an
   independent set of C6, so of size ≤ 2 (size 3 leaves an empty cone), hence exactly 2 each, 120° or 180° apart: cones of 60° or 0°, total
   ≤ 180° < 360° — contradiction. ∎ (S–V's printed Prop. 17 argues through sector angles and a Condition-5 tangency; this is a different route.)
6. The 10 + 1 count: two same-pair endpoints p, p′ have `|p − p′| ≥ 1` (the a-side curves run from > 1 apart at the B-points to < 1 at the ends
   otherwise) and ≠ 1 (P′), and < 2 (open disc): Lemma 3 (D4). The eleventh point exists on ∂R (R: the {4,5,6}-component of u, inside every γ(u)),
   once monochromatic regions are simply connected — hole-filling (Voronov Obs. 2.2) is AE-valid globally (a unit circle from outside through a
   filled hole crosses the surrounding region's interior, after moving its centre within its tile) and keeps (M). Its disjoint partner is an
   open-disc endpoint, so the distance is < 2: Cor. 3.

**So S3's configuration is unreachable by the repaired chain**: with the circle-only reduction every pigeonhole point but the eleventh lies in the
open disc, and every pair the chain hands to Lemma 3 or Cor. 3 has distance < 2.

### D6 — Corollary 1 AE, the chain in one place

Lemma 2 (no 4-chromatic points) is vacuous for cubic maps after merging (chromaticity ≤ 3; = 3 only at degree-3 vertices, where "the boundaries
extend from each point"). A trichromatic vertex lies within distance 1 of every point (a region of diameter ≤ 1, simply connected after
hole-filling, whose outer boundary must change outside colour). Then D2 → D5 on any trichromatic u produce a same-multicolour pair at
1 < d < 2 (killed by D4) or a disjoint pair at d < 2 (killed by Cor. 3 AE). **S1: TRUE, with no d = 2 exception** — hand, one mind, with
Lemma 5 and Prop. 18 accepted from print (circle-abstract, needing only (i) and (ii)).

### Would have searched here

- The branch endings and turning points in D3/D4: I would have swept d and pictures numerically for the flip; instead derived the tangency
  identity and the turning-point locus `cos θ* = (3+d²)/(4d)`, and checked them on formulas at nine values (`tools/fs110_cb_geometry.py`).

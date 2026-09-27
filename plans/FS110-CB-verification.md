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

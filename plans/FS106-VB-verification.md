# FS106-VB — blind verification of the printed regular-class theorems, and a second mind on three held lemmas

*Job FS106-VB (Coxeter, verifier), Opus 5.5, 2026-09-26. Brief: `data/fs106/briefs/VB106-blind-print.md` with
`data/fs106/briefs/STANDING-RULES.md`. **Blind**: nothing on the brief's fence list is opened before stage 5 is committed. Working
text layers (`pdftotext -layout` of the three papers, page renders of the Townsend scan) live in my own subdirectory of the harness
scratchpad, `…/scratchpad/fs106-vb/`; nothing else in that scratchpad was opened.*

## Theorems this phase proved

*(filled at stage 5; one line per theorem, grade and address)*

## Stage 1 — SAVED

### 1a. Standing rules read

`CLAUDE.md` § The aim and § Counter-priors read from disk first (rule 0); `STANDING-RULES.md` read in full; the claim list
`data/fs106/claims.md` read in full. Message from main mid-stage: `[Thomassen1999]` is now held as text
(`~/source/library/papers/Thomassen-1999-On-the-Nelson-unit-distance-coloring-problem.txt`); it is not among this job's claims (TH-99 is the
reading job's), so it is noted here and read only if budget allows after stage 4.

### 1b. Quotation check (standing rule 5)

Tool: `tools/fs106_vb_quotes.py <dir of text layers>` — pulls every quotation from the claim-list entries this job verifies, splits at
"…", deletes whitespace, de-hyphenates line breaks, and looks each fragment up in the paper's text layer. Result: **40 of 40 fragments
found** across D-NORM, D-VPROP, D-VMC, D-SV, V-1.1 … V-6.1, SV-1, SV-2, SV-L1, SV-C2, SV-C3, SV-L3, SV-L4, TW-81, C-T-CHR4, C-T-IND,
C-AE-Q2, C-Q-STAB (§9 part). Four caught fragments are not quotations of these papers (the list's own quote marks, FS106-A's wording,
`[Parts2020c]`'s abstract) and are excluded by name in the tool. Controls: two planted misquotations are refused (exit 0 requires it);
a planted fault in a copy of the Voronov layer ("covered by 5 closed sets") turns the check red on V-1.3 alone (exit 1), for its own reason.

- **TW-81's garbled constant, read from the scan** (`tw-2.png`, p. 115): the lemma's constant is **π/3** — "at least one segment of length
  greater than π/3 containing no cut points of A". The scan also shows the note's counterexample to Woodall's assertion is at
  "L = ⅔π" (p. 114), and the note's own "A°" (the text layer reads "A”"/"A0").
- **Deferred to stage 6** (the sources are fenced): I-D1, I-D2, I-D4 and D-NF's "held" sentence are quoted from
  `plans/FS103-M-derivation.md`, fenced for this job; I-CE is quoted via the same file. They are checked against their sources at stage 6.
- Brief's own quotations: the brief quotes nothing verbatim beyond pointers to the claim list; nothing further to check.

### 1c. Expectations, registered before any derivation

*Honest order: Voronov's paper had been read in full (to check quotations) before this registration; S–V and Townsend's lemma text had
been read only at the quoted statements.* Probability that my verdict will be TRUE (proof as printed correct, possibly after local repairs
I can name); otherwise the expected failure shape.

| claim | P(TRUE) | expected shape if not |
|---|---|---|
| V-1.1 | 0.75 | GAP in the passage discrete → trichromatic structure (recolourings) |
| V-1.2 | 0.8 | GAP at the arc bookkeeping of the index argument |
| V-1.3 | 0.8 | GAP only if V-1.1's localisation to radius 3 leaks |
| V-2.1 | 0.97 | — |
| V-2.2 | 0.85 | GAP: limit taken in a recoloured discrete colouring |
| V-P2.2 | 0.95 | — |
| V-4.1 | 0.9 | sign slip only |
| V-6.1 | 0.7 | GAP at the extension of boundaries / the ten-point step |
| SV-1 | 0.55 | GAP in the case analysis around vertices / tangencies |
| SV-2 | 0.6 | GAP at the reduction of polygons to Conditions 5–6 (bowtie vertices) |
| SV-L1 | 0.6 | GAP at non-smooth boundary points |
| SV-C2 | 0.6 | GAP at the construction of the covering arcs |
| SV-C3 | 0.65 | — |
| SV-L3 | 0.55 | — |
| SV-L4 | 0.55 | — |
| TW-81 | n/a | **no proof printed**: a verdict on the proof must be "no proof to check"; the statement's truth rests on later literature |
| C-CS-1 | 0.85 | MISSTATED at the word "equivalent" (a step is not a statement) |
| C-CS-2 | 0.95 | — |
| I-D1 | 0.95 | — |
| I-D2 | 0.97 | — |
| I-D4 | 0.95 | endpoint of the slack interval |
| D-NF density statement | 0.95 | — (a corollary of I-D1) |

### 1d. Controls

1. **The tight hexagonal 7-colouring must survive every seven-colour claim.** For each "needs 7" proof I name the step where the count six
   enters and check that the same step fails for the hexagonal 7-colouring (hexagons of diameter just under 1, same-colour hexagons more
   than 1 apart). A proof step that would also refute the 7-colouring is a defect.
2. **Exact distance against a band.** For each step I record whether it uses the forbidden *interval* (slack), *closedness*, or *the colour
   of a boundary point*; a step that uses slack and is then claimed at exact distance is a defect.
3. **Known facts as calibration:** the unit circle's exact-unit-distance graph is 2-colourable (6-cycles), so any argument that proves the
   bicycle needs four colours must use the band somewhere; I locate where.

### 1e. "Would have searched here" log

- none so far.

## Stage 2 — SAVED

*`[Voronov2023]` = arXiv:2304.10163v3 (13 Apr 2025), read in full, every section, from the text layer and against the claim list. Verdicts
are on the proof as printed; "TRUE (repaired)" means every step checked and each repaired step named. Grade [hand], **one mind** (mine;
blind). Notation: `ε'` the discrete colouring's interval half-width, `h` the tile diameter.*

### 2a. Verdicts

| claim | verdict | repairs / notes |
|---|---|---|
| **V-2.1** (Prop. 2.1) | **TRUE** | Interior of each tile coloured by a colour occurring in it; a pair at distance in `D_h` moves to a pair of original points at distance in `[1−ε, 1+ε]` (each point moves ≤ `h`). Border points: coloured as an adjacent tile, same bound. |
| **V-2.2** (Lemma 2.2) | **TRUE (repaired)** | As printed the limit is taken in the discrete colouring *after* Obs. 2.3's recolouring, and a recoloured tile's colour need not occur in `φ` inside that tile, so "a limit point … will be (at least) a trichromatic point in the original coloring" is unjustified. **Repair (no recolouring):** in the un-recoloured discrete colouring take the maximal region `Q₀ ∋ x`; if the ring of tiles outside its outer boundary is one colour, pass to the region containing that ring, whose fill strictly contains the last; all fills contain `x` and have diameter `< 1`, so the chain stops (finitely many tiles in `B(x, 1)`) at a ring with two colours, whose change point is a vertex with three **original** tile colours within distance `< 1` of `x`. Each tile colour occurs in `φ` within `h`, so a subsequential limit `p` has three `φ`-colours in every neighbourhood, `‖p − x‖ ≤ 1`. (The recoloured version is also rescuable: a maximal region's outer neighbours are never recoloured tiles — shown, but not needed.) Finite `k` is used. |
| **V-P2.2** (Prop. 2.2) | **TRUE** | `l ∈ (max(1−ε, ‖u−v‖/2), 1+ε)` gives `w`; `w`'s colour lies in `C(u) ∪ C(v)`, and points of that colour near `u` or `v` are at distance near `l`, inside the open band. |
| **V-4.1** (Prop. 4.1) | **TRUE (repaired)** | (i) The printed sentence "δ(t) … increases by 1 when we leave vertex (1, 2), (2, 3) or (3, 1)" has the sign reversed: leaving a state `(a, a+1)` changes `δ` by **−1** (e.g. `γ₂: 2 → 3` has index `+1`, so `δ` drops). The printed *implications* are correct, and agree with the corrected sign. (ii) Unstated: the two arcs never change colour at the same `t` — at such `t` both points would be bichromatic, two 2-subsets of `{1, 2, 3}` meet, and points of the common colour near each are at distance in the open band. (iii) `Ind` must be read as a count **along the parameter** (the proof does this); with a non-monotone parametrisation the set-sum of the definition differs. |
| **V-1.2** (Thm 1.2, bicycle) | **TRUE (repaired)** | (i) With `Ind` counted along paths, `Ind(z-path) − Ind(y-path)` is the index of the arc `y₁x₁z₁` whatever side of it `y₀` lies on (additivity on a lift; the arcs `T₁(v) ∩ U₁(x(t))` never wrap), so the printed identification "Ind y₁z₁ = Ind y₁y₀ + Ind z₀z₁" and "= Ind y₁x₁ + Ind x₁z₁" of one arc is right though unargued (I also checked `y₀ ∈ arc y₁x₁z₁` numerically-by-hand in the Euclidean case, `‖u−v‖ ∈ {1⁺, 1.5, 2⁻}`). (ii) The perturbation needs `α ≤ ε/2` rather than `α < ε` when both circles' points move (`ψ_α` need not commute with `ψ₁` in a general norm; the triangle inequality gives `1 ± 2α`). (iii) `x₀` may itself be bichromatic on `T₁(u)`: take its colour from the right. |
| **V-6.1** (Lemma 6.1) | **TRUE (repaired)** | (i) "In the latter case" should read "in the former case" (two of the three `{4,5,c}` end points share a multicolour). (ii) Their distance exceeds 1 by the intermediate-value theorem on the two boundary paths from `p_i`, `p_j` (`‖p_i − p_j‖ > 1`): a pair at distance exactly 1 on two `{4,5}` boundaries has colour-4 points near each at distance in the open band. (iii) **Prop. 3.4 is stated for a properly 3-coloured disc** but applied to `U₁(x)`, which carries six colours; and its recolouring of `Q` does **not** keep the disc proper for the band as claimed: for `z` within about `ε` of `x`, a circle `T_d(z)`, `d ≠ 1`, cuts `T₁(x)` in a short chord that can enter and leave `Q` through the arc without meeting the polyline. **Repair:** only the circle `T₁(x)` needs to stay proper. Recolour only the arcs `pq` of matched pairs (outermost ones), each to its outer colour. For `z ∈ T₁(x)` the chord is long, so `T_d(z)` meeting arc `pq` crosses the polyline, and `z`'s original colour is not 4 or 5; two recoloured points `z, w` at distance in the band would both be originally colour 6 — impossible. So the circle stays proper, Prop. 3.3 applies, and the triple it returns consists of original, unmatched `M₄₅` points. (iv) The extended boundary from `p_i` cannot re-cross `T₁(x)` (that would match `p_i`), cannot end at a `{4,5,6}` vertex (Prop. 2.2 against `x`), so it ends at a vertex `{4, 5, c}`, `c ∈ {1, 2, 3}`, in the open disc; tangencies of tile edges to `T₁(x)` are removed by general position of the tiling. (v) The ten-point step: `R` (the maximal `{1,2,3}`-region at `x`) lies inside the open disc; with regions 1-connected its outer ring has two colours, giving a vertex `{p₁, p₂, q}` disjoint from the known `{r, s, p′}` point — Prop. 2.2. 1-connectivity is genuinely needed here (without it the ring can be monochrome and the vertex found is `{1, q, q′}`). |
| **Obs. 2.2 / 2.3** (inputs to V-6.1) | **TRUE (repaired)** | Both cases of the printed proof are right after shrinking the band by an arbitrarily small amount (the point `z ∈ ∂Q` may be a border point of another colour; a nearby interior point of `Q` is at a distance near `d`, which must be interior to the band). All holes of all regions can be filled simultaneously or in finitely many steps (each fill swallows a region); a filled region merges with no outside region of its colour. Only regions meeting `U₂(0)` matter for the local use. |
| **Props. 3.1–3.3** (inputs) | **TRUE** | 3.2's recolouring: the arcs `u′v′`, `u″v″` have colour-3 neighbourhoods at their ends (points at distance in the open band from the bichromatic `u`, `v`); the flanking colour-1 arcs cannot reach into `u′v′` (else `v′` would be colour 1), so any blocker is a `3,1,3` middle arc strictly `<` `uv`, and a `<`-minimal middle arc is recolourable. 3.3's second half gives pairwise `> 1` via the hexagon (the printed "equal to 1" in its last sentence should read "greater than 1"). |
| **V-1.1** (Thm 1.1) | **TRUE (repaired)** | The chain: Prop. 2.1 → discrete colouring; Obs. 2.3 → 1-connected; Lemma 2.2 (discrete form) → trichromatic `x`; Lemma 6.1 → `u, v`, `C(u) = C(v)`, `1 < ‖u − v‖ < 2`; both circles avoid `C(u)` → a proper 3-colouring of the bicycle with finitely many bichromatic points (Obs. 3.1) → Thm 1.2 contradiction; Lemma 2.1 for non-strictly-convex norms (`‖·‖_U`-band `[1−ε′, 1+ε′]` maps into the `‖·‖_H`-band for small `δ, ε′`). No step needs `h ≪ ε` beyond `2h < ε`. |
| **V-1.3** (Thm 1.3) | **TRUE (repaired)** | The localised Thm 1.1 runs on the hexagon colouring `c(H)` directly (it is **not** derived from any proper colouring, and needs not be — the contradiction is internal to a discrete colouring). Locality checked: `‖x‖ ≤ 1`, `u, v ∈` open `U₁(x)`, `T₁(u) ∪ T₁(v) ⊂` open `U₃(0)`; Prop. 2.2's point `w` can be taken on the origin's side of `uv`, `‖w‖ ≤ √(4 + (1+ε)²) < 3` (Euclidean); Obs. 2.2's fills near `U₂(0)` have diameter `< 1`. The limit: `dist(x_k, A_i) ≤ ε_k/3`, so `x*, y* ∈ A_i` (closed), `‖x* − y*‖ = 1`, `x*, y* ∈ U₃(0)`. |

### 2b. Where each proof uses the band, closedness, or a boundary point's colour (my words)

- **Prop. 2.1:** the band, as slack: the tile colouring loses `2h` of it. Boundary points take any adjacent tile's colour.
- **Obs. 2.2:** exact distance suffices for the geometry (a circle of radius `d` about an outside point meets `∂Q`), but the point found may be
  a border point of another colour, so a nearby point of `Q` is used — **band** (open neighbourhood of `d`).
- **Lemma 2.2:** the band only through Prop. 2.1 (connected monochromatic regions have diameter `< 1`); the limit uses **tile colours**, never
  a border point's colour.
- **Prop. 2.2:** the **band**, essentially — the witness `w` is at distance `l` from `u`, and the colour-`j` points near `u` are at distance
  near `l`, not equal to it. With a single distance the step fails.
- **§3 (circle colourings):** the **band** (colour-3 neighbourhoods of `u′`, `v′`; conflicts of recolourings); isolated points are
  recoloured (**boundary colour** discarded).
- **Prop. 4.1:** the **band** (no simultaneous change; nearby parameters stay at distance in the open band).
- **Thm 1.2:** the **band** through Prop. 4.1 and the `α`-perturbation. Calibration (control 3): at exact distance the unit circle is
  2-colourable by arcs, and the step that dies without the band is Prop. 4.1's "no simultaneous change" (at exact distance a point of one arc
  can be bichromatic while its partner is too).
- **Lemma 6.1:** the **band** through Prop. 2.2 and through the intermediate-value step (points near two boundary points at distance exactly 1).
  Tile structure (every vertex meets three tiles; boundaries are paths) is used throughout.
- **Thm 1.3:** **closedness once**, at the limit `x* ∈ A_i`; the covering only to colour hexagons.

### 2c. Control 1 (the hexagonal 7-colouring)

Six enters at three places: Prop. 2.2 (`C(u) ∪ C(v)` is every colour), §3 (a trichromatic point's unit circle carries exactly the three other
colours), and Thm 1.2 (a bicycle in three colours). In the hexagonal 7-colouring Lemma 6.1's conclusion *holds* (vertices of one type recur
at distances in `(1, 2)`), a vertex's unit circle carries four colours, Prop. 3.3's count and Prop. 4.1's three-colour bookkeeping do not
apply, and the bicycle has four colours available. So no step refutes the 7-colouring. **Control passes.**

### 2d. The closed-set step (§3 of the claim list)

- **C-CS-1 — TRUE (checkable half), with the equivalence read as follows.** Closedness is used exactly once: `x* ∈ A_i`, `y* ∈ A_i` from
  `dist(x_k, A_i) ≤ ε_k/3 → 0`. Nothing else in the proof of Thm 1.3 (nor in the localised Thm 1.1 it calls) uses it — the hexagon colouring
  uses only the covering. The step **is** one application of the lemma "a compact `K` not realizing 1 avoids some `[1 − δ, 1 + δ]`" to
  `K = A_i ∩ U₄(0)` (the approximating points of `A_i` may lie just outside `U₃(0)`): if every `A_i ∩ U₄(0)` avoided a band of half-width `δ`,
  then for `ε < 3δ/5` the pair `x(ε), y(ε)` would give points of `A_i` at distance within `ε + 2ε/3 < δ` of 1. Conversely the printed
  sequential argument proves the lemma. The lemma itself is TRUE (distance is continuous on the compact `K × K` and misses 1).
  *Precision:* "equivalent" joins a step to a statement; the defensible reading is "the step is exactly one use of that lemma". The
  sequential form gives a little more (`x*, y* ∈ U₃(0)`).
- **C-CS-2 — TRUE.** (⇒) Given a colouring of `U₃(0)` in six colours proper for `[1 − ε, 1 + ε]` on pairs in `U₃(0)`, the closures of its six
  classes are closed, cover `U₃(0)`, and none realizes 1 (a unit pair in a closure is approximated by a class pair at distance in the band);
  this contradicts V-1.3. (⇐) Given closed `A₁, …, A₆` covering `U₃(0)` with no `A_i` realizing 1, each compact `A_i ∩ U₃(0)` avoids a band
  `[1 − δ_i, 1 + δ_i]`; colouring by the least `i` is proper for `δ = min δ_i`, contradicting the colouring statement. Both directions
  elementary; one mind.

### 2e. "Would have searched here" log (stage 2)

- Would have checked the bicycle's arc identification numerically over a grid of `(‖u − v‖, t)` and several norms; instead derived it from
  additivity on a lift (norm-free) and checked three Euclidean points by hand.

## Stage 3 — SAVED

*`[SokolovVoronov2025]` = arXiv:2502.01958v1, read in full (§§1–9 and the appendix). `[Townsend1981]` read in full from the scan (2 pp.).
Grade [hand], one mind. Exact distance throughout S–V (no band).*

### 3a. The supporting propositions (checked, since the claims rest on them)

- Props. 1–4: **TRUE** (Prop. 3's printed conclusion "c(x) ∈ c(y)" is a typo for "∉"). Prop. 5: **TRUE** — near `x`, inside `ω(y)` no
  colour 2 and outside no colour 1, so if only 1 and 2 met `x` on one side of `ω`, the arc of `ω(y)` there would be a boundary (Condition 5).
- Prop. 6 and **Lemma 2 (C-T-CHR4's source): TRUE (repaired).** The step "the neighbourhood of `u` coloured in that colour must lie in
  `α_i`" needs the region adjacent to `x_i` to reach depth `s > 0` inside `ω`; then colour-`c` points `p` near `u` (`|p − u| < s/2`) off
  `α_i` see that region on both sides of `ω(p)` (Prop. 1). Each of four colours then lies in an open sector of angle `π/3`: they cannot fill a
  punctured neighbourhood.
- **Prop. 12 (C-T-IND's source): TRUE (repaired).** The printed `f` puts bichromatic points at integers, so between them `f` crosses a
  colour change at a half-integer while the curve's colour is constant — `f` does not "preserve the coloring" as defined. Repair: run the
  state machine on colour pairs (as in Voronov's Prop. 4.1). **At exact distance, simultaneous transitions are allowed and harmless unless
  they swap `(a, b) → (b, a)`; the swap is exactly Lemma 1's configuration, so Lemma 1 is what replaces Voronov's band here.**
- Props. 9, 10: **TRUE.** Prop. 9 is Prop. 2 applied with `u` and `x_ij` on the boundary of the same two regions (this needs the three
  boundaries to emanate from `u` — automatic for a degree-3 vertex, false at a bowtie). Prop. 10's contradiction is Condition 5 directly:
  infinitely many distinct `x_ij(δ)` on `ω(v)`.
- Prop. 7: **TRUE**, including the unhandled case: if `ω(u)` meets the open triangle `pqz` only through `pq`, then its width at the level of
  `xy` exceeds `|xy|`, so it meets the open segments `px` or `qy` (colour 1). `|zx|, |zy| < 1` (coloured segments) keeps `diam pqz < 1`.
- **Prop. 8: GAP.** It applies Prop. 7 at a trichromatic vertex of degree ≥ 4, but Prop. 7 needs the two bounding segments' *points*
  coloured 1, and Obs. 1 only lets a boundary take one of its two regions' colours. I construct locally a `{1,2}`-boundary point `b` with a
  colour-1 boundary point at distance 1 whose unit circle is tangent to the boundary at `b` from the colour-2 side: the triangle recolouring
  then creates a monochromatic unit pair. Whether a global recolouring avoids this is not argued.
- **Obs. 1 ("without loss of generality" on boundary colours): GAP.** Recolouring a boundary point to an adjacent region's colour can
  create a conflict with another boundary point at distance 1 (same tangent configuration, on both sides, blocks both colours at one point).
  The WLOG is used in Lemma 1 and Prop. 7/8. For Lemma 1 I have a region-only repair (below); for Prop. 8 none.
- Lemma 5, Props. 14–19, Lemma 6: read; the circle combinatorics mirror Voronov §3 and are **TRUE** as far as checked (Lemma 5's "shortest
  arc" choice replaces Voronov's partial order; its six-arc cyclic recolouring checked).

### 3b. Verdicts on the claims

| claim | verdict | the step, and where the band / closedness / boundary colour enters |
|---|---|---|
| **SV-L1** (Lemma 1) | **TRUE** (as printed, under Obs. 1) | Uses **`x`'s own colour** (a boundary point's colour): "ω(x) ∩ U(y) entirely coloured 2" holds because `x` is coloured 1. Then Prop. 1 on the colour-2 arc, and `ω(y)` near `x` lies in the open double wedge `B(y₁,1) △ B(y₂,1)` (checked: `⟨p, y₁ − y⟩ > 0 > ⟨p, y₂ − y⟩` on `ω(y)` near `x`), whose points are monochromatic colour 1 — Prop. 3. No band, no smoothness. **Region-only repair (sketch, one mind):** replace `x` by a region point `x′` near `x`; `ω(x′)` cannot cross the boundary through `y`, so its monochromatic points near `y` are colour 2; the double wedge at `x′` is open with fixed angle, so `ω(q)` for a colour-1 region point `q` near `y` enters it — contradiction. Uses Condition 5 (finitely many boundary points on a unit arc). |
| **SV-C2** (Cor. 2) | **TRUE (repaired)** | Read on the *open* sectors (radii strictly between `1 − η` and `1`, resp. `1` and `1 + η`): a boundary point on `ω` itself may carry a colour of `C(u)`. Compactness of `ω` against the open cover `A ∪ B` gives finitely many arcs and one `η`. Uses the boundaries emanating from `u` (degree 3), Condition 5, no band. |
| **SV-C3** (Cor. 3) | **TRUE** | Two closed curves in the open unions `C₁₂₃`, `C₄₅₆` winding round `u`, `v`, within `η ≪ |u − v|` of the circles, must cross (Jordan); a crossing point lies in two open regions of disjoint colour sets. The hypothesis "boundaries extend" is what Prop. 9 needs. |
| **SV-L3** (Lemma 3) | **GAP at the construction of the three curves `pq₁′, pq₂′, pq₃′`** | The parity core is TRUE: pairwise complementary in a 3-cycle `q₁′p ∼ pq₂′, q₂′p ∼ pq₃′, q₃′p ∼ pq₁′` with Cor. 4 gives `s₁ = −s₂ = s₃ = −s₁`. But the existence of such curves on `γ(u₁)`, `γ(u₂)` (each `ω(x)` meeting the partner arc exactly once, monotonically, endpoints monochromatic) is asserted from Prop. 13 and Fig. 5, not proved; `p` must be a crossing of `γ(u₁)` and `γ(u₂)`, which the text does not say. It is the bicycle geometry (Voronov §5) and very likely true; not verified here. |
| **SV-L4** (Lemma 4) | **GAP at the last step** | Appendix: "It remains to notice that on the boundary of the union of three regions … whose vertex is u, there is at least one more trichromatic point" — unargued. As stated (the three regions at `u`) the extra vertex can have multicolour `C(u)` itself, and a region may surround the others. **Repair (sketch, one mind):** take the maximal connected `C(u)`-coloured union `W` (inside the open unit disc, since the strip at `ω(u)` is `{1,2,3}`), and fill holes of regions first — **hole-filling works at exact distance for maps** (a unit circle from a hole point to an outside point must cross the open region itself); then `W`'s outer ring has two colours and gives a vertex `{a, b, q}`, `q ∉ C(u)`, disjoint from one of the nine — Cor. 3. The printed proof has neither the maximal union nor the filling (Voronov's Obs. 2.3 is not carried over). |
| **SV-1** (Thm 1) | **GAP** | Inherits SV-L3's construction, SV-L4's last step and Obs. 1. The chain is otherwise sound: Lemma 2 → trichromatic `u` within 1 of the centre (a nested-fill argument, "straightforward" in the text) → Lemma 4 → Lemma 3 or Cor. 3. The proof's "Jordan-measurable" is a slip for "Jordan". |
| **SV-2** (Thm 2) | **GAP** | As SV-1, plus **Prop. 8** (the recolouring to Condition 6 needs Prop. 7's segment-colour hypothesis, not secured), and "By Lemma 8" should read "Proposition 8". Condition 5 holds for polygons. |
| **TW-81** | **No proof printed — nothing to verify** (statements quoted correctly; constant **π/3** from the scan) | The note gives no proof ("about two hundred lines of argument"). Its counterexample to Woodall's assertion at `L = ⅔π` is stated with "Clearly". **One case of the lemma proved here** [hand, one mind]: if `A°` contains an open annulus `{1 − h < |x| < 1}` (or `{1 < |x| < 1 + h}`) — no cut points — then the regular star polygons `{(6w − 1)/w}` (resp. `{(6w + 1)/w}`) with unit sides lie in it for large `w` (radius `1/(2 sin(πw/(6w∓1)))` → 1 from the right side), and an odd closed unit walk forbids every 2-colouring. The cut-point case and the theorem are unverified. |

### 3c. Where S–V uses the band, closedness, or a boundary point's colour

- **No band anywhere**; exact distance. Its replacement for Voronov's band is **Condition 5** (unit arcs are never boundaries: Props. 5, 10,
  Lemma 2) plus **Lemma 1** (which rules out the one simultaneous transition that would break the index count, Prop. 12).
- **Boundary-point colours** (Obs. 1) enter Lemma 1 (`x` coloured 1), Prop. 7/8 (segments coloured 1), and the circle colourings via
  pseudo-colours (Def. 7 avoids them — pseudo-colours are region colours). **Closedness:** never.
- **Control 1 (the hexagonal 7-colouring):** six enters at Prop. 6 (a 5-chromatic point's circle is all colour 6), Lemma 2 (a 4-chromatic
  point's circle is 2-coloured), Cor. 3 (`C₁₂₃`, `C₄₅₆` exhaust the colours) and the pseudo-colour count. In the 7-colouring each vertex's unit
  circle carries four colours and two disjoint trichromatic multicolours leave a seventh colour at the crossing. **Passes.**

### 3d. "Would have searched here" log (stage 3)

- Would have run a small geometric search for the Obs. 1 counter-configuration inside an actual proper map colouring; instead recorded the
  local configuration and graded Obs. 1 a GAP, not FALSE.
- Would have numerically traced the three complementary curves of Lemma 3; instead graded the step a GAP with the parity core verified.

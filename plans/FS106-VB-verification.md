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

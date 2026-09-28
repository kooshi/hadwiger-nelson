# FS114-N — FS-114's proof side (the NO): card 2 by derivation; route T as Sirgedas's program, with its count made exact

*Job FS114-N, de Bruijn (Opus 5.5), launched 2026-09-27 at HEAD `c0748a23`. Brief: `data/fs114/briefs/N114-proof.md` with
`data/fs114/briefs/STANDING-RULES.md`. Claim list: `data/fs114/claims.md` (quoted, never paraphrased). Working files: `data/fs114/fs114-n/`; exact
checks: `tools/fs114_n_*.py`. Notation is FS-112's (`plans/FS112-derivation.md` header; `plans/FS112-N-proof.md` header): `Γ` the boundary set,
tiles the components of `ℝ² ∖ Γ` (adjacent tiles of one colour merged), `P_cl(x)`, `ω(x)`, N-E0–N-E2, `F(M)`, `R(M)`, (Q), (R2). New here: for a tile
`x`, `N[x]` is `x` with every tile whose closure meets `cl x`; `deg_M(x) = |N[x]| − 1` is its degree in `[Thomassen1999]`'s map graph `M`; a
**repeat** at `x` is a colour carried by two members of `N[x]`; two tiles of one colour are **close** when every distance between their points is
`< 1` (de Grey's *Siamese*) and **far** when every such distance is `> 1`.*

## Theorems this phase proved

| id | statement (one line) | grade | where |
|---|---|---|---|
| N114-QT | Every quotation of the brief and of this record is verbatim: 22 of 22 FOUND, two after removing a line-end hyphen of the source (named) | [tools] | §1.2; `tools/fs114_n_quotes.py` |
| N114-FAR | Two distinct tiles of one colour in a valid map are close or far — never both, never neither (the distance set is an interval missing 1); touching tiles of one colour are close | [hand, one mind; it is FS-110's N-E2 in interval form] | §1.3 |
| N114-RD | **The rainbow deficit.** In a valid map every repeat at a tile `x` is (S) a close pair, or (A) a unit arc of `∂x` shared with one member and centred at a point `q ∈ F ∪ R` where the other member touches `x` at `q` alone, or (B) two members touching `x` only at vertices `p, q ∈ F ∪ R` with `|p − q| = 1 = diam x`; at most one member of a far pair shares an arc with `x` | [hand, one mind] | §1.4 (5) |
| N114-EDGE-RB | C114-EDGE-RAINBOW: TRUE | [hand, one mind] | §1.4 (5) |
| N114-RB | C114-RAINBOW: MISSTATED — its dichotomy misses (B), realised locally by formula (a regular hexagon of diameter 1, half-planes beyond two opposite corners); corrected: N114-RD | [hand, one mind; the fragment exact by hand] | §1.4 (5) |
| N114-EULER | On a cellular torus map: `Σ_f (deg_M(f) − (k − 1)) = (7 − k)F + Σ_v (d(v) − 2)(d(v) − 3) − μ`, `μ ≥ 0` counting repeated contacts between one pair of faces (0 when faces meet at most once) | [hand; tools exact on five maps by formula] | §1.4 (5); `tools/fs114_n_count.py` |
| N114-FIVE | At five colours, on a non-Siamese cellular torus map with `μ = 0`, the repeats forced by N114-EULER exceed the type-(A) supply `E` unless type-(B) repeats number at least `F + V₄ + 4V₅`: **C114-FIVE-COUNT is a GAP at (B)** | [hand, one mind] | §1.4 (5) |
| N114-ROOM | At six colours the same count forces type (B) only when `V₄ < 3V₆`: six's room is the degree-4 (four-colour) vertices, `V₄` of it | [hand, one mind] | §1.4 (5) |
| N114-CUBIC | No cubic non-Siamese valid six-map on a torus with `μ = 0` (Euler's deficit `F > 0` needs repeats; N114-RD anchors every non-Siamese repeat at a vertex of degree ≥ 4) — a second route, by counting, to what FS112-N3-DENSE3 already gives | [hand, one mind] | §1.4 (5) |
| N114-COMPACT | C114-COMPACT: TRUE at every `K`; a radius uniform in `K` exists iff C-LOCAL holds, and then (with FS112-N3-DENSE3) at radius `R + 3` | [hand, one mind] | §1.4 (1) |
| N114-VOR | `[Voronov2023]` Thm 1.3 applied to a valid map's closed colour classes: every open disc of radius 3 holds a same-colour unit contact (a tile of diameter exactly 1, or two same-colour tiles at distance exactly 1) — true and no contradiction; C114-VOR fails at C-CS-1's step (c) | [hand, one mind, over V-1.3 at FS106-V's grade] | §1.4 (2) |
| N114-THOM | C114-THOM-TOP: Lemma 1 holds (graph theory); the rainbow step becomes N114-RD; "`M − x` is connected" is a GAP at tiles with holes or pinch points, repairable in the non-Siamese case by Thomassen's own area count, not with Siamese pairs | [hand, one mind; the repair a sketch] | §1.4 (3) |

## Would-have-searched-here log (standing rule 3)

| move I would have made by search | what I did instead |
|---|---|
| enumerate vertex configurations about a four-colour vertex, to find the largest fragment | derived C114-COMPACT; read the strip (1.834) and the disk (`φ`) as the controls on any explicit radius |
| enumerate degree-5 tile graphs (Sirgedas's searcher) to see whether the count closes | the Euler identity N114-EULER in closed form, checked exactly on five torus maps given by formula |
| search for a (B)-type fragment | a formula (hexagon of diameter 1, two half-planes), checked by the projection inequality by hand |
| scan disc radii for a Mohar-type discharging | the Følner accounting in words (§1.4 (1), (5)) |

## Fence log (standing rule 13; brief § Fences)

1. `ls data/fs114/briefs/` at start-up listed the **names** of the other briefs (A114, CV114, NB114, P114, Y114, YB114); none opened or grepped.
2. `ls data/fs114/` listed the directory name `reports` (its contents not listed).
3. `git log --oneline -8` at start-up showed three subjects older than the start-up snapshot: `ea14826c BASE-V: stage 1b`, `e4d0655b FS114-P: stage 5`,
   `3d12fbae Archive the hadwiger-nelson-problem Google group; bibliography row; FS-114 inventory`. Subjects only.
4. **Priming, not a fence touch:** the brief sent me to the plan's stage 5b, which names the registrations **E18** (the non-Siamese case decided at one
   mind, p 0.25) and **E19** (Sirgedas's red-block statements hold, p 0.6), and "E14 corrected". I read 5b before committing stage 1; §5.3 itself unread.
5. BASE-V's notice (the owner, mid-stage): no step of the base failed; FS112-N3-BASE and FS112-N3-DENSE3 keep their grades. Its record is now unfenced; not
   read (nothing of stage 1 rests on the base beyond DENSE3 as filed).

## Stage 1 — SAVED: reading, the quotation check, card 2 by derivation, the route

### 1.1 Read from disk, with reading status (G50)

- `data/fs114/briefs/STANDING-RULES.md` (rule 0 first), `CLAUDE.md` § The aim, § Counter-priors, G83, G82, G79, G72, G71, G68, G60, G29, G24, G21,
  G17, G15, G13 (checked against disk at `a9410925`), `DEBRUIJN.md` (loaded); `LEDGER.md` rows 131–136 in full.
- `data/fs114/claims.md` in full; `plans/FS114-unit-arc-question.md` §1.3, §G part 3, §PA, §IQ, 5.0, 5.1, 5.2, 5.4, 5b — **not 5.3**.
- `plans/FS112-derivation.md` in full; `data/fs112/claims.md` §0 and §11; `plans/FS112-N-proof.md` header, §1.3–1.4, N2-4, N3-3, N3-4 in full;
  `plans/FS112-Y-construction.md` §1.3–1.5 (the strip), stage 4 (the disk); `plans/FS112-Y3-construction.md` §2.3, §4; `plans/FS112-YB2-verification.md` O2, O5.
- `plans/FS106-V-verification.md` stage 2 (§2.1–2.3, Voronov) and V3 stage 2 (Thomassen) in full.
- `[Thomassen1999]`, held text, all four pages (OCR; the page images not checked — no garbled line is quoted here).
- `[SokolovVoronov2025]` (`arXiv-2502.01958`): §§2–8 statements and proofs read (Conditions 1–8, Props. 1–4, 6–17, Lemma 2, Cor. 2–3, §6.1–6.2, Lemmas
  3–6, §8), §9 (Question 2 and the paragraph after it) in full; Props. 18–19's proofs (Appendix) first page only.
- The Google group: README; `Z50mmulkXCQ` **every message body** (quoted replies skipped; images not held); `J_Tw1_hUxQI` lines 1–40, 589–770, 885–945,
  4150–4200, 4455–4545.
- **Fetched** (stage 1's two debts): `[Mohar2002]` — the author's preprint (April 2001, 10 pp.), now at `~/source/library/pdf/Mohar-2002-light-structures-infinite-planar.pdf`:
  abstract, §1, §2, §3 through Theorem 3.1's proof read; §§4–6 unread. Ágoston 2025 — arXiv:2404.14398v2, now at
  `~/source/library/pdf/arXiv-2404.14398-agoston-nicely-colour-sphere.pdf`: abstract, §1, §2's outline read; Lemma 7 and the proof unread.

### 1.2 The quotation check (standing rule 5)

`tools/fs114_n_quotes.py` checks 22 quotations (the brief's seven, the claim list's five §8 statements the brief names, and ten of this record's) with
whitespace collapsed and nothing else normalised: **22 of 22 FOUND** (`data/fs114/fs114-n/quotes.out`). Two needed a line-end hyphen of the source
removed, reported by name: Thomassen's map-graph sentence ("correspond- ing", OCR) and Mohar's abstract ("ap- plied", pdftotext). Ágoston's title is
checked as its two printed lines (the PDF sets the arXiv stamp between them). **Plant:** C114-EDGE-RAINBOW's quotation with "6 colors" changed to
"7 colors" is NOT FOUND and its faithful twin FOUND (`quotes-plant.out`). No quotation in the brief differs from its source.

### 1.3 Two facts used throughout (derived here)

**N114-FAR.** Let `T ≠ T′` be tiles of one colour in a valid map. `T × T′` is connected, so `D = {|a − b| : a ∈ T, b ∈ T′}` is an interval, and it
misses 1 (validity); so `D ⊂ [0, 1)` (**close**: `T ∪ T′` has diameter `≤ 1`) or `D ⊂ (1, ∞)` (**far**: `inf D ≥ 1`). Touching tiles have `inf D = 0`, so
they are close. The same argument on `T × T` gives `diam T ≤ 1`. *Reads:* the two tiles. [hand, one mind; FS-110's N-E2 in interval form.]

**Anchoring.** If a tile `z` meets `cl x` at a point `q` and shares no boundary arc with `x` near `q`, then between `x`'s and `z`'s sectors at `q` lie
further sectors on both sides, so `q` has at least four sectors: four colours, or a colour repeated — `q ∈ F ∪ R`. *Reads:* a neighbourhood of `q`.

### 1.4 Card 2 — the five items, each with the radius it reads

**(1) C114-COMPACT — TRUE at every `K`; explicitness and uniformity are one question, C-LOCAL. [hand, one mind]**
*(⟸)* a valid map restricted to a disc is a valid fragment. *(⟹)* suppose for every `n` a valid `K`-fragment `M_n` on `B̄(0, n)`. On each `B̄(0, r)` the
fragments have at most `K′(r)` arcs of radius `≥ 1/K` (at most `K` tiles per unit disc, `K` arcs per tile), so a subsequence converges: boundaries in the
Hausdorff sense, each arc's centre, radius and ends converging (degenerate arcs dropped), and — diagonally over a countable dense set of test points off
the limit boundary `Γ` — the colour at every point off `Γ` eventually constant (each such point has a neighbourhood off `Γ_n` for large `n`). The limit is
locally finite with complexity `≤ K` (the bounds are closed conditions), and valid: two interior points `a, b` of one limit colour at distance 1 have
discs `B(a, ρ)`, `B(b, ρ)` off `Γ_n` and of that colour for large `n`, a monochromatic unit pair in `M_n`. Tiles of the limit that are adjacent and of one
colour are merged. ∎ So a NO of Q-full_K gives some `R(K)`; compactness gives no value.
*Uniformity.* A radius `R` admitting no valid fragment **of any complexity** is C-LOCAL's radius: a valid map restricted to `B̄(0, R)` has finitely many
arcs (local finiteness), so some `K`. With FS112-N3-DENSE3 (local, radius 3, no complexity bound), C114-LOCAL-FR at radius `R` gives C-LOCAL at `R + 3`, and
conversely C-LOCAL at `R` gives LOCAL-FR at `R`. **What uniformity needs:** a proof whose steps read discs of bounded radius and use no quantity of the
complexity (minimum arc radius, tiles per unit disc) and no compactness. Every held lemma of FS-112 (U1, SIX, A4SIX, NB4P, NOBOTH, COR3, BASE, DENSE3) is
of that kind; the non-local steps are the terminal modification's global moves and N4-PROP's line. **The gap between Q-full's NO and uniform locality**
is fragments on growing discs of unbounded complexity with no limit map — FS-111's side of W-EQ-K, not this job's. *Controls:* any explicit `R` exceeds
`√15/4 + √3/2 ≈ 1.834` (the strip, about a midline vertex) and `φ` (the disk, about `A_0`, attained). *Reads:* `R(K)`, not explicit.

**(2) C114-VOR — fails at C-CS-1's step (c); Thm 1.3 applied to a valid map returns what valid maps may have. [hand, one mind, over V-1.3 at FS106-V's grade]**
Closedness buys exactly the band: six closed sets on `U₃(0)` realising no unit distance keep a band `[1 − δ, 1 + δ]` free by compactness (C-CS-1, (c)),
and the band feeds the three essential uses H5 (Prop. 2.2), H6 (the annulus), H12 (the bicycle) (`plans/FS106-V-verification.md` §2.2). For a valid map
the closed colour classes are six closed sets covering the plane, so V-1.3 applies: **every open disc of radius 3 holds a same-colour unit contact** — a
tile of diameter exactly 1, or two same-colour tiles at distance exactly 1 (N114-VOR). That is true of every valid map and contradicts nothing: a unit
arc of kind both is such a contact along a whole arc, and with any unit arc the classes realise 1 at every scale, so no band exists and H5, H6, H12 have
nothing to act on. Read almost everywhere the band's three uses fail pointwise at contacts; their pointwise replacements are S–V's (Cor. 3, Props. 9–10,
Lemma 3) — row 134's base — whose unit-arc form is FS112-N3-BASE, failing exactly at `F ∪ R` within 2. **So Voronov's radius 3 survives with unit arcs as
FS112-N3-DENSE3's radius 3** (1 to a trichromatic vertex, 2 for the base — the same accounting as V-1.3's), which is an unavoidable set, not a NO. *Reads:* 3.

**(3) C114-THOM-TOP — Lemma 1 holds; the rainbow step becomes N114-RD; one topological step is a GAP. [hand, one mind]**
Lemma 1 is graph theory (FS106-V3, one inference supplied) and reads `M`-distance 4 from a vertex of maximum degree, so in the plane it is local:
faces of `M`-degree `≤ 5` with local Hamiltonicity on an `M`-ball of radius 4 about a face of maximum degree close up into at most 12 faces (Euclidean
radius `≤ 5`). On a valid map: (a) **the rainbow step** ("x and its neighbors must have distinct colors") fails exactly at the repeats N114-RD lists
(below) — Siamese pairs and contacts anchored at `F ∪ R`. (b) **"`M − x` is connected"** fails at a tile with a hole or a pinch point (its boundary
visits a vertex twice): the tiles in the pocket form a component of `M − x`. Thomassen's 2-separator machinery repairs it when pockets hold boundedly
many faces: the pocket lies within a set of diameter `< 2`, and in a **non-Siamese** map the faces of one colour there are pairwise far, so their
chosen points are pairwise `≥ 1` apart — at most 12 per colour, 72 in all (his (ii), `k = 12`, as FS106-V3 repaired it with `> 1`) — a sketch; **with
Siamese pairs the count is unbounded** and (ii) fails. (c) Faces that are not discs are the first candidates the brief names; both are (b). *Reads:*
`M`-radius 4 for Lemma 1; Thomassen's region of diameter `12k + 30`.

**(4) Route T is Sirgedas's program, with its gaps named.** Sirgedas's graph is the tiles' edge-adjacency dual; "Degree 6 isn't possible with only 6
colors." is N114-EDGE-RB below; his quads are four-colour vertices, his "curved edges" the (A) repeats of N114-RD, "1 quad "emits" 4 curved edges" the
demand N114-EULER counts. **Gaps:** (i) proofs in place of posts — N114-FAR, N114-RD, N114-EULER supply them; (ii) **Siamese pairs** — (S) repeats,
unanchored when the pair does not touch (a touching pair is FS112-N3-DENSE3's `R`); (iii) tiles with four edge-neighbours — no gap: N114-EULER holds for
every face length; (iv) **new, (B) repeats** — diametral pairs of `F ∪ R` vertices on one tile, which his count never lists and which the five-colour
control cannot do without (N114-FIVE); (v) repeated contacts `μ` (2-separators, pockets). **Positive control, C114-FIVE-COUNT: a GAP at (iv)** — the count
yields five impossible only once (B) repeats are bounded below `F + V₄ + 4V₅`.

**(5) The route's lemmas, derived.**

*N114-RD (the rainbow deficit) [hand, one mind].* Let `y ≠ z` be tiles of one colour in `N[x]`. If one is `x`, the other touches `x`: close. Otherwise, by
N114-FAR, close (S), or far; far gives, for `p ∈ cl y ∩ cl x` and `q ∈ cl z ∩ cl x`, `1 ≤ inf D ≤ |p − q| ≤ diam x ≤ 1`: **every point of `cl y ∩ cl x` is at
distance exactly 1 from every point of `cl z ∩ cl x`**. If `cl y ∩ cl x` holds an arc, its points are equidistant from each point of `cl z ∩ cl x`, so that
set is one point `q`, the arc lies on `ω(q)` (a segment has no such point — three collinear points are never equidistant from one), and `z` meets `cl x`
at `q` alone, so `q ∈ F ∪ R` (Anchoring): **(A), a unit arc of `∂x` centred at `q`, with `x` its inner tile** (`x ∋ q` in closure). Both `y` and `z` cannot
hold arcs. If neither does, both meet `cl x` in finite sets of anchored vertices, each at distance exactly 1 from each: **(B)**, and `diam x = 1`. ∎
*Reads:* `N[x]` ⊂ the disc of radius 2 about any point of `x`. **G83's reading holds for every non-Siamese repeat:** each is anchored at `F ∪ R`.

*N114-EDGE-RB — C114-EDGE-RAINBOW: TRUE [hand, one mind].* Two tiles of one colour each sharing an arc with `x` (either may be `x`): one is `x` — touching,
Siamese; neither — far is excluded by N114-RD (only one may hold an arc), so close: Siamese. ∎ Its non-Siamese reading: `x`'s edge-neighbours and `x` are
rainbow, so `x` has at most `k − 1` edge-neighbours. *Reads:* 2.

*N114-RB — C114-RAINBOW: MISSTATED [hand, one mind].* "Siamese or separated by a unit arc" misses (B). **Fragment by formula:** `x` the open regular
hexagon with opposite corners `p = (1/2, 0)`, `q = (−1/2, 0)` (diameter 1); `y` any tile in `{t₁ > 1/2}` touching `x` only at `p`, `z` any tile of `y`'s colour in
`{t₁ < −1/2}` touching `x` only at `q`: for `a ∈ y`, `b ∈ z`, `|a − b| ≥ a₁ − b₁ > 1` — far, no unit arc, no contact but at `p` and `q`. Exact by hand; a
fragment, not a map. Corrected statement: N114-RD.

*N114-EULER [hand; tools exact].* On a cellular torus map with vertex degrees `d(v)`, face lengths `s(f)`: `V − E + F = 0` and `2E = Σd = Σs` give
`Σ_f (s(f) − 6) + Σ_v (2d(v) − 6) = 0`. A face meets, at each of its vertices `v`, its two edge-neighbours there and `d(v) − 3` faces meeting it at `v`
alone, so `deg_M(f) = s(f) + Σ_{v ∈ f} (d(v) − 3) − μ_f`, `μ_f ≥ 0` counting neighbours met more than once. Summing:
`Σ_f (deg_M(f) − (k − 1)) = (7 − k)F + Σ_v (d − 2)(d − 3) − μ`. `tools/fs114_n_count.py` checks `V − E + F = 0`, the first identity and the `μ = 0` form
exactly on the square grid, the honeycomb, the triangular lattice, the square grid with alternate diagonals and the prismatic pentagonal tiling (every face
a pentagon, `V₃ = F`, `V₄ = F/2`: Sirgedas's case, deficit/`E` = `4/5` at six colours — his 80 %; the square grid gives `2` at five — his 200 %), each map's
`μ = 0` verified, not assumed (`data/fs114/fs114-n/count.out`). **Plant:** `deg_M` from edge-adjacency only fails E2 on every map with a vertex of degree
`≥ 4` and holds on the cubic honeycomb (`count-plant.out`). *Reads:* the whole torus.

*N114-FIVE and N114-ROOM [hand, one mind].* In a non-Siamese map with `μ = 0` each face needs at least `deg_M(x) − (k − 1)` repeats, all of type (A) or
(B). Each (A) repeat uses an edge (an arc lies on one unit circle, and only its inner tile can reach the centre), so (A) `≤ E = V + F`. At `k = 5`: rainbow
edge-neighbours give `s ≤ 4`, so `Σ_v d = Σ_f s ≤ 4F = 4Σ_v (d/2 − 1)`, i.e. `V₃ ≤ V₅ + 2V₆`; and non-Siamese forbids six colours at a vertex (`d ≤ 5`).
Demand minus (A)-supply `≥ 2F + Σ_v (d−2)(d−3) − V − F = F − V₃ + V₄ + 5V₅ ≥ F + V₄ + 4V₅ > 0`: **(B) repeats are forced, at least `F + V₄ + 4V₅`.** At
`k = 6`: `s ≤ 5` gives `V₃ ≤ 2V₄ + 5V₅ + 8V₆`, and demand minus supply `≥ −V₃ + V₄ + 5V₅ + 11V₆ ≥ −V₄ + 3V₆`: nothing is forced once `V₄ ≥ 3V₆`. **Six's
room is `V₄`**: the one extra colour removes one repeat per face (`(7 − k)F`) and relaxes `s ≤ 4` to `s ≤ 5`, and what is left is paid for by curved edges
at degree-4 vertices (Sirgedas's 80 %). *Where six is spent:* `(7 − k)F` and the face bound `s ≤ k − 1`. *Seven-colour control:* at `k = 7` a cubic map
(the hexagonal seven-colouring) has demand `Σ(deg_M − 6) = 0`: no repeat needed, as required.

*N114-CUBIC [hand, one mind].* Cubic, non-Siamese, cellular on a torus, `μ = 0`: demand `F > 0` at six colours, and N114-RD anchors every repeat at a vertex
of degree `≥ 4`, of which there are none. ∎ FS112-N3-DENSE3 already excludes every cubic valid map (Siamese allowed; its `F ∪ R` is empty there), so this is
a **second route to part of DENSE3's content, by counting and independent of row 134's base** — route T's first positive control.

**What the count is, and card 2's answer (a reading, one mind).** The count is Act One (G15): N114-EULER forces repeats at the rate
`(7 − k)F + Σ(d − 2)(d − 3)`, and N114-RD places every non-Siamese one at `F ∪ R` in one of two named shapes. **It is not a NO at six by itself**: its supply
(curved edges) covers its demand whenever `V₄ ≥ 3V₆`. The kills must be geometric — how many (A) arcs, of what length, a four-colour vertex of degree 4 can
centre while its tiles keep diameter `≤ 1` (FS112-A4SIX's `≥ 60°` is a lower bound; an upper bound is the missing object) — and each kill is local. So
**card 2: neither alone.** The printed regular NOs are local because their hypotheses make the count's curvature strictly positive at every face
(Thomassen: rainbow ⇒ `deg_M ≤ 5`; Lemma 1 closes up within `M`-radius 4). With unit arcs the count balances to zero, so a NO is a zero-sum count made
strictly positive by local kills, then read on discs by discharging (`[Mohar2002]` Thm 3.1's accounting: an interior charge `≥ ε` per face against a
boundary term `O(|δX| + |N_r(X)|)`): **local at an explicit `R(K) ≍ K/ε`** when tiles per unit disc are bounded, and **uniform in `K` only with a charge
normalised by area** (a geometric Gauss–Bonnet), which no held lemma supplies. *Killing test of the reading:* a derivation of C114-LOCAL-FR at an explicit
radius that uses no count (then the NO is local outright and the count is decoration).

**The verdict — the route: route T, torus first (G68), anchored at `F ∪ R` through N114-RD. Four parts.**
- *Choice:* Act One by N114-EULER on doubly periodic maps (exact), kills as local lemmas bounding the (A) and (B) supply at a four-colour vertex; then the
  aperiodic plane by discharging over discs at bounded `K`.
- *Alternative weighed:* the local route (C114-LOCAL-FR / C114-LOCAL-F with C114-EXISTS-F): exclude every fragment about an `F ∪ R` vertex at an explicit
  radius. It would give C-LOCAL outright.
- *Why T won:* the local route has no Act One of its own beyond DENSE3, and the configurations about a four-colour vertex form no finite list without
  enumeration (banned); route T turns G83's placement question into a supply-and-demand inequality whose demand is exact (N114-EULER), whose anchors are
  proved (N114-RD), and whose two controls are live (N114-CUBIC met; the five-colour control a GAP at one named step, (B)).
- *Confidence:* medium. What would change it: a derivation that (B) repeats cannot be bounded even at five colours — then route T cannot pass its own
  control and the local route is the one left.

*Controls for stage 1's statements.* **Strip:** N114-RD holds there (its unit arcs are (A), centred at midline four-colour vertices, inner tile the arch that
touches the centre); the count is global and the strip, a fragment, cannot test it; where the plane beyond the strip is spent is the count's demand at the
edge vertices (the pinned corner), not derived here. **Disk:** the same, at the corners `A_k`. **Hexagonal seven-colouring:** demand zero at `k = 7`.

### 1.5 Proposed for the close (I edit none of these files)

- `BIBLIOGRAPHY.md`: `[Mohar2002]` — held (author's preprint, `library/pdf/Mohar-2002-light-structures-infinite-planar.pdf`), abstract, §§1–3 read, §§4–6 not;
  its Thm 3.1 is route T's aperiodic accounting. Ágoston 2025 — arXiv:2404.14398 held (`library/pdf/arXiv-2404.14398-agoston-nicely-colour-sphere.pdf`),
  abstract, §1, §2's outline read; it states that the plane's nice case "also follows from a relatively easy proof using Lemma 7 and the fact that a
  triangulated planar graph has 3n − 6 edges" — the pure-Euler form of Thomassen's plane case, prior art for route T's cubic shape.
- `data/fs114/claims.md` verdicts: C114-EDGE-RAINBOW TRUE; C114-RAINBOW MISSTATED (N114-RD); C114-FIVE-COUNT GAP at (B); C114-DUAL-COUNT MISSTATED as
  "emits" (each of a quad's four repeats is (A) or (B); demand `2n` exact); C114-COMPACT TRUE; C114-VOR fails at (c); C114-THOM-TOP GAP at "`M − x`
  connected" (non-disc tiles), repair sketched for non-Siamese maps.

## Stage 1 — SAVED

**Left for stage 2 (the route, torus first):** the kill — an upper bound on (A) and (B) supply at a degree-4 four-colour vertex (and at degree 5, 6), from
FS112-U1's wedges, A4SIX, SIX and tile diameter `≤ 1`; then N114-FIVE's (B) step at five colours (the positive control) before any six-colour claim;
C114-REDBLOCK and C114-ENCLOSED3 by derivation; `μ` (pockets) and Siamese (S) repeats in the count. **Stage 3:** discharging at bounded `K` (Mohar Thm 3.1)
and the question of an area-normalised charge.

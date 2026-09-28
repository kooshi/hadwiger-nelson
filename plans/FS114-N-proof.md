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
| N2-ABS | **Second mind on NB-ABSENT / NB-COUNT.** On a non-Siamese valid map with `μ = 0`, the tiles meeting `x` at a vertex alone are exactly the (A) partners (`A_x` of them) plus the tiles of colours absent from `x` and its edge-neighbours, at most 3 per absent colour; so `3 s(x) + Σ_{v∈∂x}(d(v) − 3) ≤ 3(k − 1) + A_x` | [hand; two minds, one blind: NB; N2 sighted] | §N2-2.1 |
| N2-FIVE | C114-FIVE-COUNT: **TRUE** — no non-Siamese valid five-colour map is cellular on a torus with `μ = 0` (`Σ_v p_5(d) ≤ 0` with `p_5 = 3, 4, 9` at `d = 3, 4, 5`). My stage-1 "GAP at (B)" is withdrawn | [hand; two minds, one blind: NB; N2; tools exact] | §N2-2.1; `tools/fs114_n2_count.py count` |
| N2-SLACK | At six colours, exactly `A = E′ − V₄ + 3V₆ + U`, `U = Σ_x (3a(x) − B_x) ≥ 0` the unused absent-colour capacity | [hand; tools exact] | §N2-2.2 |
| N2-ENDS | **The count in edge-end form.** With `n(p)` the non-tactic edges at `p`: `Σ_{d=3} n + Σ_{d=4} (n − 2) + Σ_{d=5} n + Σ_{d=6} (n + 6) + 2U = 0`; every tactic edge's end `p` lies at distance exactly 1 from its centre `q ∈ F`, both in the closure of its inner tile | [hand; tools exact] | §N2-2.2 |
| N2-VCAP | The per-vertex (A) cap `e(q) ≤ d(d − 3)` is attained at degree 4 by the strip's midline vertices, and `Σ_q d(d−3) ≥ E′ − V₄ + 3V₆` is edge-rainbow restated: **no per-vertex supply bound can be the kill** | [hand] | §N2-2.3 |
| N2-DIAM | A tile's inner tactic arcs total at most 180° (its diameter segments are pairwise non-parallel); equality for Reuleaux polygons | [hand] | §N2-2.3 |
| N2-KILL | The torus NO (non-Siamese, `μ = 0`) follows from **K1** (a degree-4 vertex has at most two tactic edges) and **K2** (no map realises N2-ENDS's extreme: every cubic and degree-5 vertex fully tactic, `n = 2` at every degree-4 vertex, `V₆ = 0`, `U = 0`). Both positives satisfy K1 (strip `n = 4`, disk `n = 2`) and violate the extreme | [hand; K1, K2 open] | §N2-2.3 |
| N2-CROWN | At a vertex `v` of degree `d`, if every edge at `v` ends on `ω(v)`, then `d ≥ 6` (equality only with consecutive ends 60° apart) | [hand; tools exact arithmetic] | §N2-2.4; `… crown` |
| N2-PENT | C114-REDBLOCK's "no pentagons": in a non-Siamese six-map where every tile has five edge-neighbours, the five tiles at a degree-5 vertex never lie in five different blocks of the missing colour | [hand, one mind] | §N2-2.4 |
| N2-QUAD | Same class, degree-4 vertex in four different blocks: forced to the all-β configuration (or its mirror) — a unit rhombus of degree-4 vertices about `v`, each tile an equidiagonal pentagon — which passes every local check made; "no quadrilateral" is a **GAP** | [hand; tools exact on the square instance] | §N2-2.4; `… beta` |
| N2-ENC3 | C114-ENCLOSED3: **GAP**. Insertion lemma: a tiny tile of a colour missing from `B̄(u, 1)` placed at a cubic vertex `u` of a non-Siamese valid map leaves it non-Siamese and valid, with an enclosed three-neighbour tile; so ENCLOSED3 implies COVER-3 (every colour meets `B̄(u, 1)` at every cubic vertex), and no argument reading only the tile and its neighbours proves it | [hand, one mind] | §N2-2.5 |
| N2-SIAM | Route T as a count is **blind to Siamese vertices**: at a vertex with repeated colours the demand `(d − 2)(d − 3)` is paid by (S) repeats at no cost, and `d` is unbounded; the count reaches the non-Siamese case only | [hand, one mind] | §N2-2.6 |
| N2-MU | `μ > 0` lowers demand by `μ` and is not charged by the count: GAP-μ. In the non-Siamese class a hole holds at most five tiles (one per colour but the tile's) | [hand, one mind] | §N2-2.6 |

## Would-have-searched-here log (standing rule 3)

| move I would have made by search | what I did instead |
|---|---|
| enumerate vertex configurations about a four-colour vertex, to find the largest fragment | derived C114-COMPACT; read the strip (1.834) and the disk (`φ`) as the controls on any explicit radius |
| enumerate degree-5 tile graphs (Sirgedas's searcher) to see whether the count closes | the Euler identity N114-EULER in closed form, checked exactly on five torus maps given by formula |
| search for a (B)-type fragment | a formula (hexagon of diameter 1, two half-planes), checked by the projection inequality by hand |
| scan disc radii for a Mohar-type discharging | the Følner accounting in words (§1.4 (1), (5)) |
| (N2) search torus maps for a counterexample to the six-colour room | the count made exact (N2-SLACK, N2-ENDS) and checked as symbolic identities |
| (N2) enumerate configurations at a degree-4 vertex with three or four tactic edges | stated the kill K1 as a claim, checked it on the two held positives by reading their data |
| (N2) search for a fragment realising a red-block quadrilateral | a case analysis to the all-β configuration, its metric claims checked exactly on one named instance (the square) |
| (N2) search for an enclosed three-neighbour tile | the insertion lemma, by hand |

## Fence log (standing rule 13; brief § Fences)

1. `ls data/fs114/briefs/` at start-up listed the **names** of the other briefs (A114, CV114, NB114, P114, Y114, YB114); none opened or grepped.
2. `ls data/fs114/` listed the directory name `reports` (its contents not listed).
3. `git log --oneline -8` at start-up showed three subjects older than the start-up snapshot: `ea14826c BASE-V: stage 1b`, `e4d0655b FS114-P: stage 5`,
   `3d12fbae Archive the hadwiger-nelson-problem Google group; bibliography row; FS-114 inventory`. Subjects only.
4. **Priming, not a fence touch:** the brief sent me to the plan's stage 5b, which names the registrations **E18** (the non-Siamese case decided at one
   mind, p 0.25) and **E19** (Sirgedas's red-block statements hold, p 0.6), and "E14 corrected". I read 5b before committing stage 1; §5.3 itself unread.
5. BASE-V's notice (the owner, mid-stage): no step of the base failed; FS112-N3-BASE and FS112-N3-DENSE3 keep their grades. Its record is now unfenced; not
6. (N2, start-up) `ls data/fs114/` listed the directory names `fs114-nb`, `fs114-y`, `reports` (contents not listed); the harness's start-up git
   status showed the untracked names `data/fs114/fs114-nb/`, `tools/fs114_nb_count.py`, `tools/fs114_nb_quotes.py`. Names only.
7. (N2) The owner unfenced FS114-NB's record mid-stage; I read its header, §1.2, §2.2–2.4 (not its tools' code). Every use is marked "NB" below. I read
   `plans/FS111-V0-verification.md` §2.3, §2.4 items 1–3, §2.7, §2.8 and `data/fs111/claims.md` §2 (both unfenced by the brief), nothing else of FS-111.
8. (N2) The construction side's files stay unread (`plans/FS114-Y-construction.md`, `data/fs114/fs114-y/`, `tools/fs114_y_*`).
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

## Continuation — FS114-N2

*Job FS114-N2, de Bruijn (Opus 5.5), continuing FS114-N from its SAVED stage 1 at HEAD `1a57616d`. Brief `data/fs114/briefs/N2-114-proof-continuation.md`
with FS114-N's brief and `STANDING-RULES.md` (rule 0 first). Working files `data/fs114/fs114-n2/`; exact checks `tools/fs114_n2_*.py`. Notation as stage 1,
with: a **tactic edge** is an edge of the map (between vertices of degree ≥ 3) that supplies an (A) repeat — a whole unit arc on `ω(q)`, its inner tile `x`
with `q ∈ cl x`, and a tile of the outer tile's colour touching `x` at `q` alone (NB-A1: each edge supplies at most one); `n(p)` is the number of non-tactic
edges at a vertex `p`; `s(x)` the edges of `x`, `a(x) = k − 1 − s(x)` its absent colours, `B_x` its vertex-neighbours of absent colour. Grades: § Notation.*

## Stage N2-2 — SAVED: the five-colour control closed; the six-colour count made exact; the kill located; the red blocks; Siamese pairs and `μ`

### N2-2.0 Reading and the quotation check

Read from disk: the claim list in full; the plan's §G part 3, §IQ, 5.0–5.3 (5.3 now open) and 5b; `plans/FS112-derivation.md` §§1–3 (U1, SIX, A4SIX,
NB4P, N3-NOBOTH, N3-COR3, N3-BASE, N3-DENSE3, C-ENDS); the Google-group thread `Z50mmulkXCQ` lines 1375–2200 (the metagraph and red-block posts, first
occurrences; the quoted copies skipped); the strip's and the disk's rebuilt data (`plans/FS112-Y-construction.md` §1.3, §2.2, §4.1–4.4); and, once the owner
unfenced them, FS114-NB's §1.2 and §2.2–2.4 and FS111-V0's §2.3–2.4, §2.7–2.8. `tools/fs114_n2_quotes.py`: **12 of 12 FOUND** (`quotes.out`) — the brief's one
quotation (FS114-N's closing lines), standing rule 10's, FS111-C1-PW and FS111-V0's note on it, five of Sirgedas's red-block sentences, two of NB's, one of
the disk's. Plant (one word changed) NOT FOUND beside its faithful twin FOUND (`quotes-plant.out`).

### N2-2.1 The five-colour control closes (NB's step, second-minded) — and what I withdraw

**N2-ABS [hand; two minds, one blind: NB; N2 sighted].** Non-Siamese, `μ = 0`. Every tile `z ∈ N[x]` touching `x` at a vertex `v` alone has one of two kinds.
(i) Its colour is carried by an edge-neighbour `y` of `x`: `{y, z}` is far (non-Siamese) and `y` holds an arc, so by N114-RD it is (A) with centre `v` and
`x` inner — the edge `x|y` is tactic, and (NB-A1) each tactic edge has exactly one partner, so there are exactly `A_x` such `z`. (ii) Its colour is absent
from `x` and its edge-neighbours: all tiles of that colour in `N[x]` touch `x` at vertices alone and are pairwise far, so all their contact points are pairwise
at distance exactly 1 (N114-RD's cross-distance step) — at most three (no four points in the plane are pairwise at distance 1). Hence the identity
`Σ_{v∈∂x} (d(v) − 3) = A_x + B_x` with `B_x ≤ 3a(x)`, which with `s(x) ≤ k − 1` (edge-rainbow) is NB's tile inequality `3 s(x) + Σ_{v∈∂x}(d(v) − 3) ≤ 3(k−1) + A_x`.
Summed with `Σ_x A_x = A ≤ E′`, `2E′ = Σ_v d`, `F = E′ − V′`: `Σ_v p_k(d(v)) ≤ 0`, `p_k(d) = 2d² + (2 − 3k)d + 6k − 6` — re-derived here, and checked as a
polynomial identity (`tools/fs114_n2_count.py count`: `p_5(3), p_5(4), p_5(5) = 3, 4, 9`; `p_6 = 2(d − 3)(d − 5)`). **N2-FIVE: C114-FIVE-COUNT is TRUE** on
cellular torus maps with `μ = 0`, two minds; where six's room enters: `p_6(4) = −2`, the degree-4 vertices, and nowhere else.

**What I withdraw from stage 1, each at NB's grade (one mind, blind), conceded sighted — so no concession below is a third mind:**
- N114-FIVE's "C114-FIVE-COUNT is a GAP at (B)", and the route verdict's reversal condition ("a derivation that (B) repeats cannot be bounded even at five
  colours"): answered the other way — (B) is bounded by the absent colours (NB D1).
- C114-DUAL-COUNT "MISSTATED as emits": under its hypothesis (five edge-neighbours per tile) no colour is absent, so there is no (B) and every quad's four
  repeats are (A): **TRUE, at least 80 %, exactly 80 % when no vertex has degree 5 or 6** (NB D2).
- C114-THOM-TOP's pinch clause: at a pinch vertex the pocket's tile and an outside tile both contain the vertex, so they are adjacent in `M` — FALSE as I
  stated it; `M − x` disconnects only at a hole (NB D3). NB's colour-free repair (local finiteness in place of Thomassen's counting condition) I have not
  re-derived; the owner has it as NB's reading, a third mind owed.
- N114-COMPACT at one fixed `K` (NB D5): "at most `K` tiles per unit disc" is not preserved under limits; TRUE quantified over all `K`.
- N114-VOR (NB D6): Voronov's disc is closed, and a close same-colour pair with `diam(T ∪ T′) = 1` is a third case. N114-EULER's `μ` counts self-meetings
  (D7). N114-RB's (B) is "not excluded by the pair's geometry", never "realised" (D8). A repeat is counted as excess, not as a colour (D9).
- N114-RD's reading radius: `1 + 1/√3` about the tile's Jung centre (NB), sharper than my 2.

### N2-2.2 The six-colour count, exact to the edge (torus, non-Siamese, `μ = 0`)

**N2-SLACK [hand; tools exact].** Summing N2-ABS's identity over tiles: `Σ_v d(d − 3) = A + Σ_x B_x = A + 3Σ_x a(x) − U`, with `Σ_x a(x) = 5F − 2E′` and
`U = Σ_x (3a(x) − B_x) ≥ 0`. With `F = E′ − V′` this is `A = Σ_v (d² − 7.5d + 15) + U`, and per vertex `d² − 7.5d + 15 = d/2 − [d = 4] + 3[d = 6]` (checked at
`d = 3…6`; non-Siamese forces `d ≤ 6`), so **`A = E′ − V₄ + 3V₆ + U` exactly** — NB-ARCS with its slack named: the only slack in the count is unused
absent-colour capacity.

**N2-ENDS [hand; tools exact].** The non-tactic edges number `N = E′ − A = V₄ − 3V₆ − U`, and `Σ_p n(p) = 2N`, so
`Σ_{d(p)=3} n(p) + Σ_{d(p)=4} (n(p) − 2) + Σ_{d(p)=5} n(p) + Σ_{d(p)=6} (n(p) + 6) + 2U = 0`. **Every end of a tactic edge lies at distance exactly 1 from the
edge's centre `q ∈ F`, and both lie in the closure of its inner tile** (the edge is a whole arc of `ω(q)`; `q ∈ cl x` for the inner tile `x`), so a tactic edge
at a vertex `p` names a four-colour vertex at distance exactly 1 from `p` sharing a tile with it (C-PARTNERS' "unit rhombus" corners are of this kind).
*Reading the identity:* the charge `n` (cubic), `n − 2` (degree 4), `n` (degree 5), `n + 6` (degree 6), plus `2U`, sums to zero. **It is negative at exactly one
vertex type: a degree-4 vertex with three or four tactic edges.** Everything else must be paid for by those.
*Controls* (`tools/fs114_n2_count.py strip`, and the rebuilt data read by hand): **the strip** — midline vertices `n = 4` (four straight edges), valleys and
apexes `n = 1` (one straight side each): residual `+6` per column. Its local pattern, straight edges at the four-colour and cubic vertices, is what the torus
count forbids: the strip cannot be the local structure of a torus map anywhere near its average. **The disk** — corners `A_k`: `n = 2` (the two straight
legs `A_kX_{k−1}`, `A_kY_k`; the two central arcs at `A_k` are tactic, centred `A_{k+2}`, `A_{k+3}`, partners the ring-2 tiles `T2_{k+2}`, `T2_{k+3}`), charge 0;
`B_k`: `n = 1`; `X_k, Y_k, Z_k^{L,R}`: `n = 2`. Both positives carry positive charge at their cubic vertices, consistent with neither extending. **Hexagonal
seven-colouring:** the count is at `k = 7`, outside this identity; at `k = 6` it fails edge-rainbow — six is spent at `s(x) ≤ 5`, as NB found.

### N2-2.3 The kill, located (the stage-1 target answered)

**N2-VCAP [hand]. No per-vertex supply bound can be the kill.** The (A) supply at a four-colour vertex `q` of degree `d` is at most `d(d − 3)` (one emission per
ordered pair of a tile at `q` and a tile at `q` meeting it there alone). At degree 4 the cap is **attained** by the strip's midline vertices: each of the four
arches at `P_j` emits one arc of `ω(P_j)` (FS112-Y §1.3 item 2: four arcs of kind both, each the tactic). And the capped count is edge-rainbow restated:
`Σ_q d(d − 3)V_d ≥ E′ − V₄ + 3V₆ ⟺ V₃ ≤ 2V₄ + 5V₅ + 8V₆ ⟺ 2E′ ≤ 5F`. So U1's wedges, A4SIX, SIX and diameter `≤ 1` bound the supply at a vertex by what the
strip already realises, and the count's slack survives every per-vertex supply bound. The kill must be on the edge side, where N2-ENDS puts it.

**N2-DIAM [hand; classical in kind (Hopf–Pannwitz; the arcs of a Reuleaux polygon sum to π)].** The inner tactic arcs of one tile total at most 180°: each is
swept by diameter segments `[q, a]`, `a` on the arc; two distinct diameter segments of a planar set of diameter 1 are never parallel (if `q′ = q + t`,
`a′ = a + t`, `t ≠ 0`, one of `|a′ − q|`, `|a − q′|` exceeds 1), so the fans' direction sets, taken modulo π, are disjoint up to endpoints. *Use:* a cap per
tile, but the count needs no arc length, so it does not bite by itself.

**N2-KILL — the torus NO reduced to two statements [hand; K1, K2 open].**
- **K1** *(a claim)*: a vertex of degree 4 in a non-Siamese valid map has at most two tactic edges (`n(p) ≥ 2`).
- **K2** *(a claim)*: no non-Siamese valid six-map, cellular on a torus with `μ = 0`, has every cubic and every degree-5 vertex fully tactic, `n = 2` at every
  degree-4 vertex, no degree-6 vertex and `U = 0`.
K1 makes every charge of N2-ENDS non-negative, so the identity forces each to zero: that is K2's object; K2 excludes it. **So K1 ∧ K2 ⟹ no non-Siamese valid
six-map is cellular on a torus with `μ = 0`.** *The extreme's shape (derived):* its non-tactic edges join degree-4 vertices to degree-4 vertices, two at
each, so they form disjoint closed curves through the four-colour vertices (the strip's midline is one, straightened); every other edge is a unit arc centred
at a four-colour vertex at distance 1 from both its ends; and `U = 0` makes every tile with an absent colour carry it on three vertex-neighbours at the corners
of a unit equilateral triangle in its closure — the tile lies in that triangle's Reuleaux triangle, and a second absent colour must use the same three corners
(a Reuleaux triangle of width 1 contains exactly one unit equilateral triangle: if `T′ ⊂ R` then `R ⊂ Reuleaux(T′)`, of equal area), so those corners have
degree at least 5. *Controls:* both positives satisfy K1 (strip `n = 4`, disk `n = 2`) and violate the extreme (cubic charge `+1`, `+2`). *Killing test of
the route:* a local fragment by formula with a degree-4 vertex carrying three tactic edges refutes K1, and then the kill must be found among the vertex
types N2-ENDS charges positively, jointly. **Which vertices it reads (G83):** K1 reads one four-colour vertex and its unit partners (radius 2 about it); K2
reads the whole torus.

### N2-2.4 A crown lemma, and C114-REDBLOCK

**N2-CROWN [hand; tools exact arithmetic].** *At a vertex `v` of degree `d` with tiles `t_1 … t_d` in cyclic order, let `w_i` be the far end of the edge `e_i`
shared by `t_i` and `t_{i+1}`. If every `w_i` lies on `ω(v)`, then `d ≥ 6`, with equality only when consecutive ends are 60° apart.* *Proof.* `w_{i−1}, w_i ∈ cl t_i`
and `diam t_i ≤ 1` give `|w_{i−1} − w_i| ≤ 1`. The edges lie in `B̄(v, 1)` (each in the closure of a tile containing `v`) and meet only at `v`, so the `w_i` sit on
`ω(v)` in the edges' cyclic order; the positive gaps `g_i` from `w_{i−1}` to `w_i` sum to 360°, and a chord `≤ 1` means `g_i ≤ 60°` or `g_i ≥ 300°`. If every
`g_i ≤ 60°`, then `60d ≥ 360`. If one `g_i ≥ 300°`, all `w_j` lie in an arc of 60°; `t_j ⊂ B̄(w_j, 1)` with `v ∈ ω(w_j)`, so `t_j`'s sector at `v` lies within 90° of
the direction of `w_j`, and all sectors lie in a range of `60° + 180° = 240°`, yet they cover every direction. ∎ *Reads* `B̄(v, 1)`. *Control:* the regular
hexagon of unit triangles about `v` (six tiles of diameter 1) meets it with equality — `crown6`'s plant, which claims `d = 6` excluded, fails as it must.

**C114-REDBLOCK — Sirgedas's statements, each for non-Siamese valid six-maps with `μ = 0` and five edge-neighbours per tile (the claim list's class).**
In this class every tile's closed edge-neighbourhood is rainbow of size six, so every non-red tile has exactly one red edge-neighbour.
1. **"Then, a 6-colored 5-regular graph that covers the plane can be partitioned into red blocks" — TRUE [hand, one mind].** ("Define a red "block" as a red
   tile and its neighbors."): each non-red tile lies in the block of its one red edge-neighbour, and two red tiles have no common edge-neighbour (it would
   carry two red edge-neighbours — Siamese).
2. **The metagraph is planar — TRUE, by a route other than his [hand, one mind].** His proof ("No! Proof: connect one diagonal via 2 tiles (tiles are
   vertices in the image above). The other diagonal can't be formed, because the diagonals must cross at a vertex, making two red vertices too close
   together.") is not re-derived. Instead: each block is a star in the edge-adjacency dual `D`, hence connected, and the blocks partition `D`'s vertices; two red
   tiles at "tile distance" 3 are exactly two blocks joined by an edge of `D` (distance 2 would be a common edge-neighbour, excluded by 1; a `D`-edge from
   `R`'s block to `R′`'s is a path `R–a–b–R′`). So the metagraph is `D` with every block contracted — a minor of a planar graph. Its faces are the map vertices
   whose surrounding tiles, read cyclically, pass through at least three blocks.
3. **"Also this graph can't have pentagons." — TRUE [hand, one mind] (N2-PENT).** A pentagonal face is a vertex `v` whose tiles span five blocks; a red tile at
   `v` would put three consecutive tiles in one block, so `v` has degree 5, five non-red colours, as he says ("A pentagon in the red metagraph means that the
   boundaries of the 5 red blocks share a common point. So, exactly 5 tiles meet at this common point, using all 5 non-red colors."). Each `t_i` meets
   `t_{i+2}`, `t_{i+3}` at `v` alone; their colours are carried by edge-neighbours of `t_i`, so (N114-RD) `t_i` has two tactic arcs on `ω(v)` with outer colours
   `c_{i+2}, c_{i+3}`; its five edges are `e_{i−1}`, `e_i`, those two arcs and its red edge. At `w_i`, the tiles are `t_i, t_{i+1}, u¹, …, u^m`. If `m ≥ 2`, `u¹`
   meets `t_i` at `w_i` alone, so `t_i` has a tactic edge centred at `w_i` of `u¹`'s colour; its arcs are centred at `v`, so it is the red edge and `u¹` is red;
   symmetrically `u^m` is red; two red tiles at `w_i` — Siamese. So `w_i` is cubic, and its third tile is a common far neighbour of `t_i`, `t_{i+1}`: red (then
   `r_i = r_{i+1}`) or of colour `c_{i+3}` (then it lies across `t_i`'s arc on `ω(v)`, so `w_i ∈ ω(v)`). Five different blocks put every `w_i` on `ω(v)`, and
   N2-CROWN refuses `d = 5`. ∎ His own proof ("The 5 rigid EDs have length 1, but then the "pentagon" will have at least one "edge" with length > 1.") reads
   as the crown's gap step, not re-derived from his words.
4. **"Similarly the metagraph can't have a quadrilateral." — GAP [hand, one mind] (N2-QUAD).** Quadrilateral faces are vertices of degree 4, 5 or 6 whose tiles
   span four blocks. **Degree 4, four blocks, walked:** with colours `c_1 … c_4` at `v` and yellow, red absent, each `t_i` has far edges to `y_i` (colour
   `c_{i+2}`, a tactic arc on `ω(v)`), `r_i`, `o_i`. At `w_i` there are no middle tiles (a middle colour `c_{i+2}` or `c_{i+3}` would need an arc of `t_i` or `t_{i+1}`
   centred at `w_i` where its only edge of that colour is centred at `v`), so `w_i` is (α) cubic with a shared yellow tile, or has degree 4 as (β)
   `t_i, t_{i+1}, r_{i+1}, o_i` or (γ) `t_i, t_{i+1}, o_{i+1}, r_i`, with the corresponding red and yellow edges tactic centred at `w_i`. `t_i`'s three far edges begin
   and end with different neighbours, which allows only the transitions β→{α, β}, α→γ, γ→γ around the 4-cycle: **all four `w_i` are β (or all γ, the mirror).**
   Then `t_i`'s far boundary is `w_i` —(`o_i`, arc of `ω(w_{i−1})`)— `a_i` —(`y_i`, arc of `ω(v)`)— `b_i` —(`r_i`, arc of `ω(w_i)`)— `w_{i−1}`: the pentagon
   `v, w_i, a_i, b_i, w_{i−1}` has all five diagonals equal to 1, and `w_1 … w_4` form a unit rhombus about `v`; the far pairs `r_i, r_{i+2}` and `o_i, o_{i+2}` need
   both diagonals `≥ 1` (angle in `[60°, 120°]`). **This configuration passes every local check I made** — `tools/fs114_n2_count.py beta` on the square instance,
   exact: unit sides, diagonals `√2`, `t_1`'s five diagonals exactly 1 and five sides `≤ 1` (`a_1, b_1` at `±24.3°` about `t_1`'s axis); by hand at the square: the
   ring rule (red on `(45°, 65.7°) + 90°ℤ` and yellow on `(24.3°, 45°) + 90°ℤ` each miss their 60° translates) and NB4P's exception (the change point at 45° has
   its 60° orbit point 105° inside the arc `[65.7°, 114.3°]`). Not checked: the outer tiles' own five-neighbour structure. Degree 5 and 6 quadrilaterals not
   walked. So "no quadrilateral" is **not** a consequence of the structure within `B̄(v, 2)` that I checked. The `thin` plant (a rhombus of angle 40°) fails at
   the far pair, as it must.
5. **"So, the red metagraph must have only triangles." — GAP**, resting on 4. **E19 (p 0.6) is not met at this stage**: 1–3 TRUE, 4–5 GAP.

### N2-2.5 C114-ENCLOSED3 — GAP, with an insertion lemma

"So, a valid tiling can't have an enclosed vertex with 3 neighbors." (a tile with three edge-neighbours). **Insertion lemma [hand, one mind]:** let `u` be a cubic
vertex of a non-Siamese valid map and `f` a colour whose closed class misses `B̄(u, 1)`, so every `f`-point is at distance `> 1 + δ` from `u` for some `δ > 0`.
Cut a triangle `x` of colour `f` from the three corners at `u` inside `B(u, δ/2)`: every `f`-point is at distance `> 1` from every point of `x` (validity, and `x` far
from every `f`-tile: non-Siamese); the three old tiles only shrink; the new vertices are cubic; the map stays locally finite, bounded by segments and arcs. `x`
is an enclosed tile with three edge-neighbours. ∎ **So ENCLOSED3 implies COVER-3** — *every colour meets `B̄(u, 1)` at every cubic vertex `u` of every non-Siamese
valid map* — **and no argument that reads only a tile and its neighbours proves it**: its truth depends on what the colours do at distance 1. COVER-3 is not
derived (at a cubic vertex the ring `ω(u)` off `Γ` carries only the three colours absent at `u`; COVER-3 asks that none of them is missing from the disc). The
search that found ENCLOSED3 is no input (the claim list, §8).

### N2-2.6 Siamese pairs and `μ` in the count

**N2-SIAM [hand, one mind]. Route T as a count is blind to Siamese vertices.** The demand at `x` is `deg_M(x) − 5` in every valid map, but with Siamese pairs
the supply gains (S) repeats that the count cannot bound: at a vertex of degree `d` whose colours repeat (the vertices of `R`, where `d` is no longer `≤ 6`), each
tile's `d − 3` vertex-neighbours there may all repeat colours of tiles touching it, at no cost in arcs or absent colours. So the count decides only the
non-Siamese case — de Grey's `[16.317]` target — and the Siamese case needs another kill: FS112-N3-DENSE3's `R` half, NB's reading too. Edge-rainbow fails with
them as well (two close edge-neighbours of one colour).

**N2-MU [hand, one mind].** `μ > 0` lowers the demand by `μ` (N114-EULER, NB's `μ` with self-meetings) and nothing in the count charges it: **GAP-μ**. What is
derived: in the non-Siamese class a hole of a tile `x` holds at most five tiles — the hole lies in the convex hull of `x`, of diameter `≤ 1`, so two tiles of one
colour inside are close, and a tile of `x`'s colour inside is close to `x`. Pockets between two tiles lie in a set of diameter `≤ 2`, with no such bound. On a
torus, `μ` from wrapping round disappears in a finite cover (NB); plane `μ` does not.

### N2-2.7 Verdicts of this stage, scope, and the registrations it bears on

| claim | verdict | grade, minds |
|---|---|---|
| C114-FIVE-COUNT | **TRUE** (torus, `μ = 0`); six's room is the degree-4 vertices, `p_6(4) = −2` | [hand; two minds, one blind: NB; N2] |
| C114-DUAL-COUNT | **TRUE**, at least 80 %, exactly 80 % with no vertex of degree 5 or 6 (stage 1's MISSTATED withdrawn) | NB's; N2 concedes, sighted |
| C114-BUDGET | **the types are named**: the Euler-fixed charge (N2-ENDS) is `n`, `n − 2`, `n`, `n + 6` at degrees 3–6 plus `2U`; **negative only at a degree-4 vertex with three or four tactic edges** | [hand; tools exact] |
| C114-REDBLOCK | partition TRUE; planarity TRUE (a contracted minor); no pentagons TRUE; no quadrilaterals GAP (all-β survives); only triangles GAP | [hand, one mind] |
| C114-ENCLOSED3 | **GAP**: implies COVER-3 by the insertion lemma; not provable from a tile and its neighbours | [hand, one mind] |
| C114-THOM-TOP | stage 1's pinch clause FALSE (NB D3), withdrawn; NB's colour-free repair not re-derived here | NB's; third mind owed |
| C114-CURV, C114-SKELETON | not worked this stage | — |

**Scope (the owner's note).** Everything in this stage is on **doubly periodic maps** — a torus map, finitely many arcs per period, so of bounded complexity
automatically — and the count uses **no complexity bound**, only finiteness of the period. A torus NO by K1 ∧ K2 would be E4's result ("a NO for doubly
periodic maps"), non-Siamese and `μ = 0` only: it is **neither Q-full's NO nor Q-full_K's**. The local lemmas (N2-ABS, N2-CROWN, N2-PENT, the insertion lemma,
N2-DIAM) read discs of radius at most 2 and use no complexity bound.

**Registrations (plan §5.3; read after stage 1's commit).** E6 (C114-RAINBOW TRUE as stated): not met, both minds MISSTATED. E14 (the decisive argument reads
`F ∪ R`): holds for everything here — every repeat outside (S) is anchored at a four-colour vertex, and the count's one negative charge is at degree-4
vertices. E18 (the non-Siamese case decided at one mind): not met at this stage; it is reduced to K1 ∧ K2 on the torus, with GAP-μ beside them. E19: not met
(N2-2.4, 5).

### N2-2.8 Proposed for the close (I edit none of these files)

- `data/fs114/claims.md` verdicts as N2-2.7; the corrections to stage 1 as N2-2.1.
- Stub or claim to mint: **K1** ("a degree-4 vertex of a non-Siamese valid map has at most two tactic edges") — the one local statement that makes every charge
  of the torus count non-negative; its killing test is a fragment by formula with three tactic edges at a degree-4 vertex, the construction side's kind of
  object. **COVER-3** as the local statement ENCLOSED3 needs.
- Grokking material for the close (G83's body): with unit arcs the count's only negative charge sits at degree-4 four-colour vertices carrying three or four
  unit arcs of the tactic; the strip, whose four-colour vertices carry none, is the local pattern a torus count forbids.

## Stage N2-2 — SAVED

**Left for stage N2-3 (aperiodic maps):** discharging at bounded `K` (`[Mohar2002]` Thm 3.1) and what the count needs beyond it; the question of an
area-normalised charge; GS-D's verdict at its grade, with Q-full or Q-full_K named.

# FS-114 — theorems proved outside the kernel (the derivation file)

*Filed by the close job FS114-C (Ephodos), 2026-09-28, from the records of the proof side (`plans/FS114-N-proof.md` with § Continuation — FS114-N2,
`plans/FS114-N3-proof.md` … `plans/FS114-N7-proof.md`), the construction side (`plans/FS114-Y-construction.md` … `plans/FS114-Y6-construction.md`), their
blind verifiers (`plans/FS114-NB-verification.md`, `-NB4-` … `-NB6-`, `-YB-` … `-YB5-verification.md`), the composition's (`plans/FS114-CV-verification.md`,
`plans/FS114-CVB-verification.md`), the L60 audit (`plans/FS114-L60-audit.md`) and BASE-V (`plans/BASE-V-verification.md`). The reconciliation — every
claim, its minds and their blindness, every divergence and how it was settled — is `plans/FS114-C-close.md` stage 2. Notation: `data/fs114/claims.md` §0
(valid map, unit arc, (Q), (R2), `M*`, `F(M)`, `R(M)`, Siamese, local), `plans/FS112-derivation.md`'s header (`Γ`, `P_cl`, `ω(x)`, N-E0–N-E2), and each
record's own header (the bowtie's `p, q_i, t_i, top, bot, r`; the pinwheel's `t_j, q_j, w_j, μ_j, M_j, α_j`). A **Reuleaux bowtie** includes its four
tactic edges (reading R-T, the owner's ruling, `plans/FS114-close-inventory.md` item 72). **Every statement about a valid map is about a possible object:
no valid map of the plane is known, and the class is empty exactly when the NO holds**; each entry's model line says what its hypotheses are met by.
Grades carry no nested brackets. Ids are qualified (`FS114-…`); a grouped entry quotes each member's statement from its record's theorem table, with the
member's own id, so a search for any record id finds its entry.*

**The milestone's result in one paragraph.** FS-114 asked whether a valid six-map with unit arcs exists. **Not decided.** **The NO is reduced to one
local statement**: every valid map has a vertex of at least four colours (FS114-CV-EXISTS, two minds blind to each other), so excluding every valid
fragment on a disc of explicit radius about such a vertex — C114-LOCAL-F — is the whole NO, Siamese pairs included, with no ray step and no density; the
capped strip puts that radius above `φ²/√2 ≈ 1.8512` (FS114-Y-DIAL). The six rounds excluded, locally, the configurations where the count of route T goes
negative — a degree-4 four-colour vertex with three or four tactic edges: the Reuleaux bowtie at `√3` by two independent derivations (FS114-Y4-RSTOPALL),
the pinwheel at `1 + ε` outside two named exceptions (FS114-Y5-PINALL, FS114-N6-NOQ), and three tactic edges on rings free of (Q) arcs except one family
(FS114-N7-3T, one mind). Route T itself (the count) reduces the non-Siamese NO at every complexity to K1′ ∧ K2′ ∧ GAP-μ and is blind to Siamese pairs by
theorem. Nothing moves a value; nothing answers a posed question.

## 1. The reduction

derivation: FS114-CV-EXISTS
  statement: Every valid map has a vertex of at least four colours, in the map itself; the proof passes through `M*`, where with no such vertex every
    stuck chain would be bi-infinite; it uses neither CV-HD nor FS112-C-ENDS, no ray step and no residue
  uses only: FS112-N3-DENSE3 (a vertex of `F ∪ R` in every disc of radius 3), FS112-N2-TERM (the terminal modification `M*`, whose vertices are cubic,
    NB4P exceptions with at least four colours, or stuck on chains along their normal lines), N4-FIN (no bi-infinite stuck chain), and that a
    modification creating no unit arc keeps a four-colour vertex's colours at the vertex in the map itself; FS114-CV's route adds FS114-CV-HD and
    FS112-C-ENDS with its residue closed, and CVB proposes U1, N4-SHADOW, CV-FLANK, CV-P and CV-L4 for the grade line
  not claimed: C114-LOCAL-F (an explicit radius about the four-colour vertex); that four-colour vertices come within any bounded distance of every
    point (GS-4's density form, which still needs FS-115's (b′) and (b″) for aperiodic maps); anything about maps at a fixed complexity `K` alone
  argument: FS114-CVB-verification.md § 1.4
  verdict: derived
  grade: hand
  minds: 2 — blind to: each other (FS114-CV blind to the FS112-C assembly; FS114-CVB blind to FS114-CV's record until its stage 1 was committed);
    method: CV through CV-HD and the closure of C-ENDS's residue; CVB with no four-colour vertex every stuck chain of `M*` is bi-infinite, which N4-FIN
    forbids — neither CV-HD nor C-ENDS
  model: no valid map of the plane is known (the class is empty exactly when the NO holds); the statement's local content is met on every held
    fragment — the capped strip's midline vertices and the disk's corners are four-colour vertices (FS114-Y-DIAL, FS112-CAL-DISK)
  prior art: new — "ab:discharging & ab:unit distance" (1), "(ab:map | ab:maps) & ab:'distance 1' & ab:colo* & ab:plane" (0) — FS-114's gate
    (`plans/FS114-unit-arc-question.md` §PA rows 1–3; the held Polymath16 threads grepped for "non-Siamese" (6) and "largest disk" (5)); none states it
  handoff: de Bruijn — deferred with D6 (a Lean skeleton of Q-full's statement, held for Kooshi): the statement verbatim, its not-claimed line, the
    model's vacuity caveat, and its inputs FS112-N3-DENSE3, FS112-N2-TERM, N4-FIN at their grades

Rests on it: the reduction of the unit-arc NO to C114-LOCAL-F (so SIAM-KILL is subsumed and FS-115 bears only on GS-4's density form); FS114-GSD. Its chain
is intact at FS112-L60's boundary (FS114-L60-WALK). It rests on FS112-N3-DENSE3, hence on row 134's base, whose Lemma 4 at cusps is still one mind (BASE-V).

*Prior-art note (FS116-Z2, 2026-10-03; `plans/FS116-close-inventory.md` item 20, found at FS116-O1's gate, `plans/FS116-local-exclusion.md` § 2.2):
the local-to-global idea is Sirgedas's, informally and for non-Siamese tilings found by search — "A biggest disc implies no 6-color-tiling of the plane
exists." (Google group thread "Graph Coloring by Simulation", 2020-03-17; `~/source/library/hadwiger-nelson-problem-group/threads/J_Tw1_hUxQI.txt`
l. 4661). The prior-art line above should read "partly" for the idea; a four-colour vertex in every valid map, and the reduction to a disc about one with
Siamese pairs allowed and the radius uniform in the complexity, are not in the thread as read (ll. 4290–4790 and the grep hits).*

derivation: FS114-CV-HD
  statement: (CV-HD) in `M*`, for a stuck `E`: both upper bounds `1` and no in-type lower-flank tile at `E − n` is impossible; hence
    `G_N ⇔ H_S ⇔ υ± = 1 ⇔ λ± = −1` (all four horn arcs unit arcs, in-type flank tiles at both antipodes); (CV-CLASS) a stuck vertex of `M*` is a
    bowtie (CV-HD's four equivalent conditions; both neighbours both-centres with `≥ 4` colours; a one-vertex chain) or has `g` twice at `E − n` and `h`
    twice at `E + n` (each neighbour stuck or with `≥ 4` colours and a repeated colour); (CV-L0) in a terminal valid map `M*` a stuck vertex centres no
    unit arc, so `Γ ∩ ω(E)` is finite; (CV-ENDS) FS112-C-ENDS holds with no residue: the point one step beyond every finite end of a stuck chain has at
    least four colours
  uses only: FS-110's N4 frame at a stuck vertex (horn curvatures `λ_k < υ_k`), FS112-U1's wedges, W-MERGE, N-E1 and N-E2; CV-U and CV-L4 (below
    ends of chains), CV-FLANK and CV-P
  not claimed: that a stuck vertex exists in any valid map; anything about one-sided infinite chains (FS-115's (b′)), which CV-ENDS leaves to N4-FIN
  converse: FS114-CV-verification.md § 1.4
  argument: FS114-CV-verification.md § 1.4
  verdict: derived
  grade: hand
  minds: 2 — blind to: each other's records at stage 1 (CVB sighted on Y3-END-NEEDS's levels, an FS-112 input); method: CV one chain through the
    flank shadows; CVB two branches, the `G_N` branch's merge made explicit
  model: FS112-BOWTIE, an exact fragment whose centre is a locally terminal stuck vertex between two unit circles (the bowtie case of CV-CLASS; CVB's
    control consistent)
  prior art: new — "ab:discharging & ab:unit distance" (1), "(ab:map | ab:maps) & ab:'distance 1' & ab:colo* & ab:plane" (0) — FS-114's gate; the
    frame is FS-110's
  handoff: none — a relay-result inside FS-112's chain composition; CV-EXISTS no longer uses it (FS114-CVB-EXISTS's route)

Rests on it: the correction of FS112-C-ENDS (its residue clause deleted: the erratum appended to `plans/FS112-derivation.md`) and of `LEDGER.md` row 135's
not-claimed line ("a chain end at a unit arc bounding one horn only" is walked). CV-HD step 3's wording omits the ring tile crossing `ω(E)` (CVB A-7);
step 4 is unchanged.

derivation: FS114-CVB-THOM
  statement: `[Thomassen1999]`'s steps other than the rainbow step hold for every valid map, Siamese pairs allowed: fill holes, read facial cycles as
    boundary walks, and replace the count in `int(R)` by local finiteness (finite against infinite); the reduced map graph `H` then has a vertex of degree
    `≥ 6` (with FS114-CVB-PINCH: in the map graph of a locally finite plane map, `M − x` is connected at a pinched tile and disconnected at a holed one;
    holes are locally consistent with validity)
  uses only: Thomassen's Lemma 1 (a connected, locally finite, locally Hamiltonian graph with at least 13 vertices has a vertex of degree at least 6) and
    his topological steps; local finiteness of the map; nothing about colours but at the rainbow step, which this entry excludes
  not claimed: the rainbow step on valid maps (it fails there: FS114-N114-RD's types (A) and (B)); the 2-separator criterion at pinches, which is a
    sketch (one mind: CVB)
  argument: FS114-CVB-verification.md § 1.9
  verdict: derived
  grade: hand
  minds: 3 — blind to: each other's records (NB and CVB blind; FS114-N's stage 1 against, on the pinch clause); method: NB by treating holes as
    1-separators with finite interiors; CVB by filling holes and reading boundary walks; the colour-free repair two minds, both blind
  model: the capped strip's map graph (FS114-Y-DIAL) — locally finite, faces of diameter at most 1, no pinch; YB's radius-3/5 rainbow fragment for a
    face meeting another only at points
  prior art: partly: `[Thomassen1999]` (the steps are his, for nice colourings); the repair for valid maps with unit arcs not found in print —
    "ab:'locally Hamiltonian' & ab:degree" (10) at FS-114's gate
  handoff: none — a relay-result for route T: it says where Thomassen's argument fails on valid maps (only the rainbow step)

Rests on it: C114-THOM-TOP's verdict (TRUE with the repair; E5 met), decided 2–1 against FS114-N's stage-1 pinch clause; route T's reading that the rainbow
step is the only colour-reading step (FS114-N114-RD).

## 2. Route T — the count

derivation: FS114-N114-RD
  statement: **The rainbow deficit.** In a valid map every repeat at a tile `x` is (S) a close pair, or (A) a unit arc of `∂x` shared with one member
    and centred at a point `q ∈ F ∪ R` where the other member touches `x` at `q` alone, or (B) two members touching `x` only at vertices `p, q ∈ F ∪ R`
    with `|p − q| = 1 = diam x`; at most one member of a far pair shares an arc with `x`
  uses only: that two same-colour tiles are close or far, never both (FS114-N114-FAR, FS-110's N-E2 in interval form), and that a point of `cl x` met
    by another tile at that point alone is a vertex of at least four sectors (NB-ANCHOR)
  not claimed: that type (B) occurs in a valid map (it is realised on fragments only: FS114-N's hexagon by hand, and YB's exact fragment of radius 3/5
    for the corrected C114-RAINBOW's third case); the original C114-RAINBOW dichotomy (MISSTATED by four minds)
  argument: FS114-N-proof.md § 1.4
  verdict: derived
  grade: hand
  minds: 2 — blind to: NB derived its NB-RD before opening FS114-N's record; method: NB reads the radius `1 + 1/√3` about the tile's centre; the
    corrected RAINBOW trichotomy (YB, blind to both: "Siamese, or the unit-radius tactic …, or both meet `cl x` only in finite sets at mutual distance
    exactly 1") is the same statement read on contact sets
  model: YB's exact valid fragment on the closed disc of radius 3/5 about `(1/2, 0)` (seven convex polygons over ℚ; `x` a rhombus of diameter exactly 1,
    two colour-2 triangles meeting `cl x` only at its two ends): a type-(B) repeat, all cross distances 1
  prior art: partly: `[Polymath16threads]` `[09.11]`, `[09.28]` (Gibbs's "vertex-edge" and "vertex-vertex constraints") and `[08.14]` (Mixon), as search
    rules, not as a lemma about every map
  handoff: none — a relay-result for route T's counts and for C114-RAINBOW's corrected statement

Rests on it: FS114-N114-EULER's accounting of repeats, FS114-N2-FIVE, FS114-N114-CUBIC, FS114-N2-ENDS; the corrected C114-RAINBOW in `data/fs114/claims.md`.

derivation: FS114-Y-EDGE
  statement: C114-EDGE-RAINBOW TRUE: in a valid map, two faces of one colour that each share a boundary arc of positive length with a face `x` (either may
    be `x`) are Siamese; so a face with six or more edge-neighbours forces a Siamese pair (Sirgedas's "Degree 6 isn't possible with only 6 colors", for
    non-Siamese maps)
  uses only: `diam x ≤ 1` and that a unit circle meets a circle of radius 1 about another point in at most two points
  not claimed: the statement under the narrower gloss "the two meet at a vertex" (FALSE: YB); any bound on repeats through vertex contacts
  argument: FS114-Y-construction.md § 3.2
  verdict: derived
  grade: hand
  minds: 4 — blind to: FS114-N and FS114-Y blind to each other; NB and YB blind to their sides' records; method: four derivations of one short
    argument; FS114-Y5-RAINBOW its non-Siamese form, re-derived blind by YB4
  model: the hexagonal seven-colouring's faces (six edge-neighbours of distinct colours) — the hypothesis met, the conclusion "six colours force a
    Siamese pair" not applicable at seven
  prior art: partly: Sirgedas, the Google group thread `Z50mmulkXCQ`, 2020-09-12 (stated, for non-Siamese tilings, without proof)
  handoff: none — a relay-result for route T and the pinwheel lemmas (FS114-Y5-PINALL uses its non-Siamese form)

Rests on it: FS114-Y5-PINALL (RAINBOW gives each blade one 5- and one 6-neighbour); FS114-Y-REDBLOCK1; the count's edge side.

derivation: FS114-N114-EULER
  statement: On a cellular torus map: `Σ_f (deg_M(f) − (k − 1)) = (7 − k)F + Σ_v (d(v) − 2)(d(v) − 3) − μ`, `μ ≥ 0` counting repeated contacts
    between one pair of faces (0 when faces meet at most once)
  uses only: Euler's formula on the torus and the map graph's degrees by vertex incidence; `μ` counted as excess multiplicity, self-meetings included
    (NB's reading, adopted by FS114-N2)
  not claimed: the identity with `μ` counting only distinct neighbours met twice (it fails: NB-EULER); anything on the plane without averaging
  argument: FS114-N-proof.md § 1.4
  verdict: derived
  grade: hand
  minds: 2 — blind to: NB derived NB-EULER before opening FS114-N's record; method: NB checked it exactly on 17 torus maps by formula
    (`tools/fs114_nb_count.py`), N on five (`tools/fs114_n_count.py`)
  model: the square torus tiling by congruent squares (every vertex of degree 4, `μ = 0`), one of the five maps of `tools/fs114_n_count.py`
  prior art: partly: `[Higuchi2001]` (combinatorial curvature), `[Thomassen1999]` (the map graph's count); the identity with `μ` not found —
    "ab:combinatorial curvature & (ab:tiling | ab:tilings | ab:tessellation)" (2), "ab:infinite planar & ab:curvature" (10)
  handoff: none — an identity route T's counts are read from

Rests on it: FS114-N2-FIVE, FS114-N114-ROOM, FS114-N114-CUBIC, FS114-N2-ENDS.

derivation: FS114-N2-FIVE
  statement: C114-FIVE-COUNT: **TRUE** — no non-Siamese valid five-colour map is cellular on a torus with `μ = 0` (`Σ_v p_5(d) ≤ 0` with
    `p_5 = 3, 4, 9` at `d = 3, 4, 5`). (N2-ABS, NB-ABSENT: on a non-Siamese valid map with `μ = 0`, the tiles meeting `x` at a vertex alone are the (A)
    partners plus the tiles of colours absent from `x` and its edge-neighbours, at most 3 per absent colour; so
    `3 s(x) + Σ_{v∈∂x}(d(v) − 3) ≤ 3(k − 1) + A_x`)
  uses only: FS114-N114-EULER, FS114-N114-RD, and that four points cannot be pairwise at distance 1 (so a colour absent from `x`'s edge-neighbours
    meets it in at most three tiles)
  not claimed: the five-colour statement for maps with Siamese pairs or `μ > 0`; anything at six colours (FS114-N2-ENDS)
  argument: FS114-N-proof.md § N2-2.1 The five-colour control closes
  verdict: derived
  grade: hand
  minds: 2 — blind to: NB derived NB-ABSENT and NB-COUNT before opening FS114-N's record; FS114-N2 re-derived them sighted; method: NB's excess
    count per absent colour, N2's slot accounting
  model: the brick seven-colouring's torus quotient read at five colours fails its validity — the hypothesis class is the one the theorem empties;
    the identity's terms are met by FS114-N114-EULER's torus maps (`tools/fs114_n2_count.py count`)
  prior art: partly: Sirgedas, `J_Tw1_hUxQI`, 2020-01-21 ("so 200% of the edges are curved, so a 5-coloring is impossible", stated without proof);
    the value — maps need six — is `[Woodall1973]`'s and row 132's
  handoff: none — route T's positive control, a known value by counting

Rests on it: route T's credibility as a count (its positive control met, E4's population); FS114-N2-AVG's five-colour plane corollary.

derivation: FS114-N114-ROOM
  statement: At six colours the same count forces type (B) only when `V₄ < 3V₆`: six's room is the degree-4 (four-colour) vertices, `V₄` of it (with
    NB-COUNT: on a non-Siamese valid map cellular on a torus with `μ = 0` and six colours, `V₄ ≥ 3V₆` and `V₃ ≤ 2V₄ + 5V₅ + 8V₆`)
  uses only: FS114-N114-EULER and FS114-N2-FIVE's absent-colour cap, at `k = 6`
  not claimed: that any map has `V₄ ≥ 3V₆` (no valid map is known); a per-vertex bound (FS114-N2-LEMMAS' VCAP: none can kill)
  argument: FS114-N-proof.md § 1.4
  verdict: derived
  grade: hand
  minds: 2 — blind to: NB derived NB-COUNT before opening FS114-N's record; method: NB by the quadratic `Σ_v [2d² + (2 − 3k)d + 6k − 6] ≤ 0`
  model: the capped strip's midline vertices (degree 4, four colours), where six's room is spent locally
  prior art: partly: Sirgedas's "20%" room (`Z50mmulkXCQ`, 2022-05-01), informal
  handoff: none — a relay-result for FS114-N2-ENDS

Rests on it: the location of the kill at degree-4 vertices (FS114-N2-ENDS, K1).

derivation: FS114-N114-CUBIC
  statement: No cubic non-Siamese valid six-map on a torus with `μ = 0` (Euler's deficit `F > 0` needs repeats; N114-RD anchors every non-Siamese repeat
    at a vertex of degree ≥ 4) — a second route, by counting, to what FS112-N3-DENSE3 already gives
  uses only: FS114-N114-EULER and FS114-N114-RD
  not claimed: the plane (it is the torus statement); Siamese maps
  argument: FS114-N-proof.md § 1.4
  verdict: derived
  grade: hand
  minds: 2 — blind to: NB derived NB-CUBIC before opening FS114-N's record; method: NB by Euler and edge-rainbow alone
  model: a cubic torus map (the hexagonal tiling's quotient), whose seven-colouring is valid and whose six-colourings the statement excludes
  prior art: partly: Ágoston 2025 (DCG 74, 691–718) states the plane's nice case from his Lemma 7 and `3n − 6`, pure Euler
  handoff: none — a second route to part of FS112-N3-DENSE3, independent of row 134's base

Rests on it: nothing further; it is the count's independent check of DENSE3's cubic case.

derivation: FS114-NB-DUAL
  statement: Sirgedas's 80%: unit-arc edges `≥ Σ_v d(d−3) = 2F + 2V₅ + 6V₆` of `E′ = 2.5F`; with absent colours `Σ_v (d−3) = (F + Σa)/2`
  uses only: the map class of C114-DUAL-COUNT (doubly periodic, non-Siamese, every tile with five edge-neighbours), FS114-N114-RD's type (A), and
    FS114-Y-EDGE
  not claimed: Sirgedas's exact `2n` without the degree restriction (equality holds iff no vertex has degree 5 or 6); the count when tiles with four
    edge-neighbours occur (FS114-Y-DUALCOUNT's `2n − 2f₄` form, one mind)
  argument: FS114-NB-verification.md § 1.2
  verdict: derived
  grade: hand
  minds: 2 — blind to: NB and YB each blind to its side's record; method: NB by vertex degrees; YB by emitted arcs, `2n + 2p₅ + 6p₆` distinct unit arcs of
    kind both, the opposite tile never the emitting neighbour (YB §1c item 9)
  model: none known in the class (no doubly periodic valid map is known); the count's local terms met at the disk's corners (four-colour, degree 4)
  prior art: partly: Sirgedas, `Z50mmulkXCQ`, 2022-05-01 ("1 quad "emits" 4 curved edges. This is 2n edges (80% of all edges)."), stated without the
    degree condition
  handoff: none — the corrected C114-DUAL-COUNT (four readings reconciled, `plans/FS114-C-close.md` stage 2)

Rests on it: the claim list's correction of C114-DUAL-COUNT; the design budget of C114-TORUS's family F3.

derivation: FS114-N2-ENDS
  statement: **The count in edge-end form.** With `n(p)` the non-tactic edges at `p`: `Σ_{d=3} n + Σ_{d=4} (n − 2) + Σ_{d=5} n + Σ_{d=6} (n + 6) + 2U = 0`;
    every tactic edge's end `p` lies at distance exactly 1 from its centre `q ∈ F`, both in the closure of its inner tile (with N2-SLACK: at six
    colours, exactly `A = E′ − V₄ + 3V₆ + U`, `U = Σ_x (3a(x) − B_x) ≥ 0` the unused absent-colour capacity)
  uses only: FS114-N114-EULER, FS114-N114-RD, FS114-N2-FIVE's cap at `k = 6`, on a non-Siamese torus map with `μ = 0`
  not claimed: that any vertex type is excluded; the kill (K1, K2′); Siamese maps (FS114-N2-LEMMAS' SIAM) and `μ > 0` (GAP-μ)
  argument: FS114-N-proof.md § N2-2.2
  verdict: derived
  grade: hand
  minds: 1
    model: FS114-Y2-BOWTIE's centre `p`, a degree-4 four-colour vertex with four tactic edges (`n = 0`, charge −2) — the configuration the charge
      penalises, held on a fragment (`B̄(p, 3√3/5)`); the capped strip's midline degree-4 vertices have four straight edges (`n = 4`, charge 2), each the
      centre of four tactic arcs (N2-VCAP), not their own edges
    prior art: new — "ab:discharging & (ab:tiling | ab:tilings | ab:tessellation)" (1), "ab:combinatorial curvature & (ab:tiling | ab:tilings | ab:tessellation)" (2)
    — FS-114's gate, none on map colourings avoiding a distance
  handoff: de Bruijn — deferred with D6: the identity on a torus map is a finite combinatorial statement, a natural first kernel target once the class is
    fixed

Rests on it: K1's definition (the charge is negative only at a degree-4 vertex with at least three tactic edges), hence rounds 2–6; FS114-N3-JOINT.

*Erratum (FS116-O1, 2026-09-29): the model line said the strip's midline vertices have four tactic edges (`n = 0`, charge −2); they have four straight edges (`n = 4`, charge 2) — `data/fs114/fs114-y6/survey.out`, FS114-N's control (`plans/FS114-N-proof.md` l. 299); found by Poros (FS116-P1). The model is now FS114-Y2-BOWTIE's centre; nothing rests on the model line.*
Its exact identities are checked by `tools/fs114_n2_count.py`; NB-ARCS (the inequality `A ≥ E′ − V₄ + 3V₆`) is its blind second mind's form.

derivation: FS114-N3-JOINT
  statement: Route T's count restated: `N + U + 3V₆ = V₄` (non-tactic edges); the non-Siamese simple torus NO ⟸ a fractional assignment giving every
    degree-4 vertex two units among non-tactic edge-ends (its own or free ones within radius `R`), `U`, and six units per degree-6 vertex, with a unit
    unused in every disc of radius `R₀` (K1 ∧ K2-loc is the own-ends case) (with N2-KILL: the torus NO, non-Siamese, `μ = 0`, follows from K1 and K2;
    and N3-PAY: DR vertices pay, from their four continuation ends)
  uses only: FS114-N2-ENDS (N2-SLACK) and N3-CONT (the continuation of each tactic lens arc beyond its end is non-tactic)
  not claimed: the assignment's existence (K1′, the payment of the deficient patterns other than DR, and K2′, a unit unused per disc, are open); the
    Siamese class; `μ > 0`
  argument: FS114-N3-proof.md § 3.2
  verdict: derived
  grade: hand
  minds: 1
    model: FS114-Y2-BOWTIE's centre `p` as a deficient vertex (DR's shape, FS114-N3-DR: four tactic edges, `n = 0`), its tactic ends' continuations as
      N3-PAY's sources (a fragment, not a map); the strip's midline vertices carry `n = 4` (charge 2), so their two ends beyond the first two are free ends
    prior art: partly: `[Mohar2002]` (discharging on infinite planar graphs of subexponential growth) for the method; the assignment new
  handoff: none — a reduction; the kill it names is the successor's

Rests on it: route T's standing verdict (FS114-ROUTE-T); the successor's K1′ and K2′.

*Erratum (FS116-O1, 2026-09-29): the model line changed with FS114-N2-ENDS's (see the erratum there); filed by Keryx.*

derivation: FS114-N2-AVG
  statement: For simple non-Siamese valid maps of the plane (any complexity) the tile identities and Euler hold on discs up to `O(R)`: **no simple
    non-Siamese valid five-colour map of the plane exists** (N2-FIVE-PLANE); at six colours N2-ENDS's charge has density zero, and K1 ∧ K2-loc exclude
    the class
  uses only: N2-GROW (at most `6(2R + 1)²` tiles meet a disc of radius `R`; at least `4R²`), FS114-N2-FIVE and FS114-N2-ENDS on discs, boundary terms
    `O(R)`
  not claimed: maps with Siamese pairs (no density bound: N2-REFINE) or with holes; K1 and K2-loc themselves
  argument: FS114-N-proof.md § Stage N2-3
  verdict: derived
  grade: hand
  minds: 2 — blind to: NB6 derived NB6-FOLNER blind to FS114-N2's record ("for a valid map of bounded complexity whose tiles are open discs, pinch
    points allowed, route T's aperiodic averaging step closes by Euler's formula on large discs"); method: NB6 by boundary `O(R)` and a local surplus
    `≥ cR²`; the five-colour corollary is N2's alone, one mind
  model: the capped strip's discs (simple, non-Siamese, a fragment), where the identities are exact on the interior
  prior art: partly: `[Mohar2002]`; FS114-N6's mass-transport route (`[AldousLyons2007]` Ex. 9.5, `[AngelHutchcroftNachmiasRay2018]` Thm 1) reaches it
    only with GAP-μ in the hull (NB6-MTP)
  handoff: none — route T's aperiodic step; Kooshi's lead (inventory item 79) checked through it

Rests on it: route T's reach to every complexity for the non-Siamese simple class (FS114-ROUTE-T); the answer to N6-MTP (the printed route needs GAP-μ in
the hull; the disc average suffices).

derivation: FS114-N114-COMPACT
  statement: C114-COMPACT: TRUE at every `K`; a radius uniform in `K` exists iff C-LOCAL holds, and then (with FS112-N3-DENSE3) at radius `R + 3`
  uses only: W-EQ-K's compactness at each complexity (the class of maps with at most `K` arcs per tile and at most `K` tiles per unit disc, closed under
    limits) and FS112-N3-DENSE3
  not claimed: the statement at a fixed `K` read as "≤ `K` tiles per unit disc" is preserved by fragments (it is not: a pinching tile breaks it — NB,
    accepted by N2); any explicit radius
  converse: FS114-N-proof.md § 1.4
  argument: FS114-N-proof.md § 1.4
  verdict: derived
  grade: hand
  minds: 2 — blind to: NB derived its verdict before opening FS114-N's record; method: NB over all `K` at once, reading the fixed-`K` defect
  model: the class `𝓜_K` at `K = 2` holds the brick seven-colouring (valid at seven colours), so the compactness class is not empty
  prior art: partly: FS112-A (C-LOCAL's own note, one mind) and `plans/FS107-derivation.md` W-EQ-K's compactness step
  handoff: none — it says what an explicit radius buys (C-LOCAL), no statement to formalize alone

Rests on it: the framing of C114-LOCAL-F as the explicit form; E7's reading.

derivation: FS114-N114-VOR
  statement: `[Voronov2023]` Thm 1.3 applied to a valid map's closed colour classes: every open disc of radius 3 holds a same-colour unit contact (a tile
    of diameter exactly 1, or two same-colour tiles at distance exactly 1) — true and no contradiction; C114-VOR fails at C-CS-1's step (c)
  uses only: `[Voronov2023]` Thm 1.3 as verified at FS-106 (six closed sets covering a disc of radius 3 realise the unit distance), applied to closures of
    colour classes
  not claimed: that Voronov's argument can refute a valid map (the band is what closedness buys, and valid maps realise distance 1 only on boundaries)
  argument: FS114-N-proof.md § 1.4
  verdict: derived
  grade: hand
  minds: 2 — blind to: NB derived NB-VOR before opening FS114-N's record; method: NB in three cases on the closed disc (N's wording missed a close-pair
    case: NB, accepted by N2)
  model: the capped strip: its closed classes realise distance 1 along every unit arc, inside every disc of radius 3 of the fragment
  prior art: known: `[Voronov2023]` Thm 1.3; the failure point for maps with unit arcs is this milestone's
  handoff: none — a negative about a route

Rests on it: C114-VOR's verdict; card 2's answer (the count, not Voronov, as the global instrument).

derivation: FS114-Y-REDBLOCK1
  statement: C114-REDBLOCK's first clause TRUE: in a non-Siamese valid map in which every tile has five edge-neighbours, the red tiles' closed
    edge-neighbourhoods partition the tiles (with N2-PENT, "no pentagons": in a non-Siamese six-map where every tile has five edge-neighbours, the five
    tiles at a degree-5 vertex never lie in five different blocks of the missing colour)
  uses only: FS114-Y-EDGE's non-Siamese form (each closed neighbourhood is six tiles of six distinct colours)
  not claimed: "no quadrilateral" (N2-QUAD: a GAP); "the red metagraph has only triangles"
  argument: FS114-Y-construction.md § 3.2
  verdict: derived
  grade: hand
  minds: 2 — blind to: YB derived it before opening FS114-Y's record; method: YB by one red tile per neighbourhood; N2-PENT one mind
  model: none known in the class (every tile with five edge-neighbours, non-Siamese, valid); the partition's hypothesis met by the hexagonal seven-colouring
    at seven colours with six edge-neighbours, which the class excludes
  prior art: partly: Sirgedas, `Z50mmulkXCQ`, 2021-06-27 (stated, "the proof below is a bit sloppy(?)")
  handoff: none — Sirgedas's program's first step, derived

Rests on it: E19's partial score; the successor's reading of Sirgedas's metagraph.

derivation: FS114-N2-LEMMAS
  statement: (N2-VCAP) The per-vertex (A) cap `e(q) ≤ d(d − 3)` is attained at degree 4 by the strip's midline vertices, and
    `Σ_q d(d−3) ≥ E′ − V₄ + 3V₆` is edge-rainbow restated: **no per-vertex supply bound can be the kill**; (N2-DIAM) A tile's inner tactic arcs total at
    most 180° (its diameter segments are pairwise non-parallel); equality for Reuleaux polygons; (N2-CROWN) At a vertex `v` of degree `d`, if every edge at
    `v` ends on `ω(v)`, then `d ≥ 6` (equality only with consecutive ends 60° apart); (N2-GROW) In a non-Siamese valid map at most `6(2R + 1)²` tiles meet
    a disc of radius `R` (same-colour tiles are unit-separated); at least `4R²` do; (N2-REFINE) A tile whose colour pair `(a, b)` keeps `b` more than
    `1 + δ` away can be cut into any `a, b` map: with Siamese pairs no density bound exists; (N2-SIAM) Route T as a count is **blind to Siamese vertices**:
    at a vertex with repeated colours the demand `(d − 2)(d − 3)` is paid by (S) repeats at no cost, and `d` is unbounded; the count reaches the
    non-Siamese case only; (N2-CURV) C114-CURV: TRUE at every `K` with `R₀(K) = O(K²)` for simple maps; a uniform radius (Lemma 1 made local) is a reading
  uses only: FS114-N2-ENDS, FS114-Y-EDGE, the packing of unit-separated same-colour tiles, and elementary geometry of arcs
  not claimed: a uniform `R₀` for C114-CURV (a reading); any exclusion
  argument: FS114-N-proof.md § N2-2.3 The kill, located
  verdict: derived
  grade: hand
  minds: 1
  model: the capped strip (VCAP attained at its midline vertices; the disk's Reuleaux pentagon for DIAM's equality)
  prior art: partly: `[Higuchi2001]` for the curvature form of CURV; `[Thomassen1999]` Lemma 1; the rest not found at FS-114's gate
  handoff: none — relay-results inside route T

Rests on it: FS114-N2-AVG (GROW); the verdict that route T cannot be the whole NO (REFINE, SIAM), hence the move to C114-LOCAL-F; the kill's location
on edges, not vertices (VCAP).

derivation: FS114-N2-ENC3
  statement: C114-ENCLOSED3: **GAP**. Insertion lemma: a tiny tile of a colour missing from `B̄(u, 1)` placed at a cubic vertex `u` of a non-Siamese
    valid map leaves it non-Siamese and valid, with an enclosed three-neighbour tile; so ENCLOSED3 implies COVER-3 (every colour meets `B̄(u, 1)` at every
    cubic vertex), and no argument reading only the tile and its neighbours proves it
  uses only: that a tile small enough near `u` meets no unit circle about a point of its own colour when that colour is absent from `B̄(u, 1)`
  not claimed: ENCLOSED3 itself (a GAP, by FS114-N2 and FS114-Y); COVER-3 (open, placed in the successor stub)
  argument: FS114-N-proof.md § N2-2.5
  verdict: derived
  grade: hand
  minds: 1
  model: a cubic vertex of the disk (FS112-CAL-DISK) at which a colour is missing from its closed unit disc would take the inserted tile; the lemma's
    hypothesis is local and met on fragments
  prior art: partly: Sirgedas, `J_Tw1_hUxQI`, 2020-03-08 ("So, a valid tiling can't have an enclosed vertex with 3 neighbors.", a finding of a search he
    later found flawed)
  handoff: none — it reduces a printed claim to COVER-3

Rests on it: C114-ENCLOSED3's verdict (GAP, two minds agree); COVER-3 in the successor stub.

derivation: FS114-Y-ROUTES
  statement: On the moved disk (FS112-MOVE) the blue and orange routes to a fourth colour at `C_0` fail with the rest of the disk unchanged: the only blue
    straddler of `ω(C_0 + e(72°)/100)` is `T2_0`, the only orange one `T1_0`, and at named exact points of `T2_0 ∩ B(C_0,1)` and `T1_0 ∩ B(C_0,1)` the free
    set with the cut tile ignored is exactly its own colour
  converse: FS114-YB-verification.md § 3. ROUTES on the moved disk
  uses only: the moved disk's exact coordinates (FS112-MOVE) and the straddle test at named points (`tools/fs114_y_pent.py routes`)
  not claimed: the region-wide reading (FALSE at 3 of 11 points: YB's `{Bl, P}` at 2 of 9 blue points); routes that change more of the disk
  argument: FS114-Y-construction.md § 1.3
  verdict: derived
  grade: computed over: the named exact points of `T2_0 ∩ B(C_0,1)` and `T1_0 ∩ B(C_0,1)` in `tools/fs114_y_pent.py routes` (YB reproduced all 18)
  minds: 2 — blind to: YB derived it before opening FS114-Y's record; method: YB's own checker at its own points, then the side's 18 reproduced exactly
  model: the moved disk FS112-MOVE, exact
  prior art: partly: `[Polymath2021]` Fig. 10's disk and FS112-Y3 §4.4 (ii), which named the routes and did not analyse them
  handoff: none — a statement about one printed object at named points

Rests on it: C114-PENT's second question answered at named points; the reading that neither printed positive extends.

derivation: FS114-ROUTE-T
  statement: route T gives the NO for every non-Siamese simple valid map, at every complexity, once three local statements hold: K1′ (every deficient
    configuration at a degree-4 vertex paid locally), K2′ (a unit unused in every disc of radius `R₀`) and GAP-μ (repeated contacts paid)
  argument: FS114-N3-proof.md § 3.2
  verdict: gap: K1′ ∧ K2′ ∧ GAP-μ — K1's open cases are FS114-K1's; K2′ and GAP-μ have no derivation (a pocket meets at most 65 tiles, non-Siamese, with
    no payment rule)

Rests on it: nothing; it names route T's standing and the successor's route-T targets. Route T can never reach Siamese maps (FS114-N2-LEMMAS' REFINE).

## 3. K1 and the local exclusions at a four-colour vertex

derivation: FS114-N3-LOCAL
  statement: (N3-FACE) Two distinct tiles of one colour at vertices `u, w` with `|u − w| = 1` have their cones in the closed half-planes facing away from
    each other; one tile at both lies in `B̄(u, 1) ∩ B̄(w, 1)`; (N3-HALF) At a tactic edge at `p` (centre `q`, inner `x`, outer `y`): `x` faces `q`, `y`
    faces away; every other tile at `p` meeting the open half-plane facing `q` has a colour absent at `q` or contains `q`; at `q` the open half-plane
    facing `p` meets only `x` and tiles of the two colours absent at `p` (one of each at most); (N3-SEC) Every tile adjacent to a tactic edge at `p` has
    cone `≤ 180°`; two consecutive tactic edges with the tile between inner to one and outer to the other have it `≥ 60°`; a tile inner to both its edges
    at `p` (a **lens**) has cone `180° − γ ∈ [120°, 180°]`, `γ ≤ 60°` the angle between the two centres; (N3-FLANK) In the simple class, each branch of
    `p`'s ring at a tactic centre `q` lies on `Γ` or in a tile of a colour absent at `p`; two such tiles are distinct and of the two different absent
    colours: `q` is a change point of the ring or an end of a `Γ`-arc of `ω(p)`; (N3-PAIR) If `y` is an edge point between tiles of colours `c, c′` and
    `y′` carries `c, c′` at distance 1, the edge through `y` is an arc of `ω(y′)`; (N3-ODD) Off `Γ`-arcs of `ω(p)`, every half-open 60° window of the ring
    of a four-colour vertex holds an odd number of change points
  uses only: N-E0, N-E1, N-E2 (FS-110), FS112-U1's wedges, and the non-Siamese hypothesis where a colour absent at a vertex is used
  not claimed: any exclusion by these lemmas alone (K1 is not derivable at radius `1 + ε` from them: FS114-N3's N3-K1)
  argument: FS114-N3-proof.md § 2.1
  verdict: derived
  grade: hand
  minds: 1 — N3-FACE's substance is FS114-Y4-UPDOWN, derived blind on the other side and re-derived blind by YB3; the others have no blind second mind
    (no verifier ran on FS114-N3, inventory item 57)
  model: FS114-Y2-BOWTIE's centre `p` (a degree-4 four-colour vertex with four tactic edges), on which each lemma's configuration occurs
  prior art: new — "ab:Reuleaux & ab:colo*" (3), "ab:exclusion zone & ab:colo*" (0) — FS-114's gate (the second query's words quoted in the original)
  handoff: none — local tools for every later round; a blind check of N3-HALF, -SEC, -FLANK, -PAIR, -ODD is owed before the successor files K1

Rests on it: every K1 exclusion on the proof side (FS114-N4-D, FS114-N5-GRING, FS114-N6-NOQ, FS114-N7-3T).

derivation: FS114-N3-DR
  statement: **The escaping configuration DR**: a degree-4 vertex with two opposite Reuleaux lenses and all four edges tactic forces, at radius
    `≤ 1 + ε`: partners `c₂, c₄, c₄, c₂` at `a, b, −a, −b`; one tile of `c₃` over `R1`'s cap (so `R1` is inner to three tactic edges), each corner of
    degree exactly 4; each lune's ring carrying change points at `s, s + 60°` (with N3-CONT: in DR's general member the continuation of each tactic lens
    arc beyond its end is non-tactic; and N3-DR1: `t₄` reaches the ring at `y′` or `y″`, and `z_a` reaches `y″` or `z_{−b}` reaches `y′`)
  uses only: FS114-N3-LOCAL
  not claimed: that DR exists in a valid map (it does not, on `B̄(p, √3)`: FS114-Y4-RSTOPALL); N3-DR0's written proof (its step 1 fails; the conclusion
    holds by FS114-N4-D); N3-DR2 at more than one mind
  argument: FS114-N3-proof.md § 2.2
  verdict: derived
  grade: hand
  minds: 1 — DR's shape was built blind on the other side (FS114-Y2-BOWTIE) and N3-DR1 re-derived blind by NB5 in N5's setting
  model: FS114-Y2-BOWTIE (twenty tiles over `ℚ(√3)`, exact), which realises DR on the closed disc of radius `3√3/5`
  prior art: new — "ab:Reuleaux & ab:colo*" (3), "ab:discharging & ab:unit distance" (1) — FS-114's gate
  handoff: none — superseded by FS114-Y4-RSTOPALL as a statement; its lemmas are relay-results

Rests on it: K1's first escape and its exclusion (FS114-N4-D, FS114-N5-GRING, FS114-Y4-RSTOPALL); N3-PAY in FS114-N3-JOINT.

derivation: FS114-Y2-BOWTIE
  statement: **K1's killing test fires as a local statement:** a non-Siamese valid fragment by formula (twenty tiles over `ℚ(√3)`) holds the closed disc
    of radius `3√3/5 ≈ 1.0392` about a degree-4 vertex `p` of four colours whose **four** edges are tactic — unit arcs about four-colour vertices
    `q1…q4` at distance 1, each with a tile of the outer tile's colour meeting the inner tile at `q_i` alone. So no argument reading only the closed disc
    of radius `3√3/5` about the vertex proves K1
  uses only: the fragment's exact coordinates over `ℚ(√3)` and FS114-YB's segment-and-arc checker, unedited, recalibrated on the five controls
  not claimed: a disc of radius `√3` or more (the bowtie stops there: FS114-Y3-RSTOP); that the fragment is part of a valid map; five colours at `q_i` as
    forced in every bowtie (forced only with `top`'s neighbourhood: FS114-Y4-DIAG)
  argument: FS114-Y2-construction.md § 1b.1
  verdict: derived
  grade: computed over: the fragment's 46 same-colour tile pairs, each checked exactly over `ℚ(√3)` (`data/fs114/fs114-y2/k1.out`)
  minds: 2 — blind to: YB2 built its own 20-tile D2-symmetric fragment before opening FS114-Y2's record; method: YB2's checker over towers of square
    roots and FS114-YB's, two checkers on an independent object
  model: the fragment itself (`tools/fs114_y2_k1.py`)
  prior art: new — "ab:Reuleaux & ab:colo*" (3), "(ab:map | ab:maps) & ab:'distance 1' & ab:colo* & ab:plane" (0) — FS-114's gate
  handoff: none — an exact object checked by exact arithmetic; a kernel certificate is owed only if K1's route is ever published through it

Rests on it: K1's non-locality at radius `3√3/5` (so any K1 proof reads beyond it); FS114-Y3-RSTOP's starting object.

derivation: FS114-N4-D
  statement: (N4-D) **The degenerate member does not exist at radius `√3`**: no valid fragment on the closed disc of radius `√3` about `p` holds the
    Reuleaux bowtie with a lune whose ring is free of `Γ` and changes colour once; (N4-G) **The general member does not exist at radius `√3`** (both lune
    rings `Γ`-free): if the lune tile `t2` reached the change point `y′` nearer `q1`, the partner `z4` would fill the lens `B(q1,1) ∩ B(top,1)` near `P90`
    while its sector at `q1` starts at `0°`, giving `z4` two points more than 1 apart; by the mirror `t2` cannot reach `y″` either, against N3-DR1
    (N4-BOWTIE: no valid fragment, non-Siamese, simple class, on the closed disc of radius `√3` about `p` holds a Reuleaux bowtie whose lune rings are
    free of `Γ`)
  uses only: FS114-N3-LOCAL, FS114-N3-DR's N3-DR1, and FS114-N4-LEMMAS (N4-TOP, N4-TANG, N4-LENS, N4-GP90); NB4-RING (a `Γ`-free lune ring has one
    change point, at `top`, or exactly two, `e(s)`, `e(s + 60°)`), which makes degenerate and general exhaust the `Γ`-free rings
  not claimed: lune rings carrying arcs of `ω(p)` (FS114-N5-GRING); maps with Siamese pairs; non-simple bowties
  argument: FS114-N4-proof.md § 5.1 N4-G
  verdict: derived
  grade: hand
  minds: 2 — blind to: NB4 derived N4-D and the reduction of N4-G before opening FS114-N4's record, and checked N4-G's kill step sighted (inventory
    item 83); method: NB4's N4-D ends at `R* = q1 + top` (no colour for the tile outside `ω(q1)` there), a different last step from N4's diameter
    `|P90 − P90′| = √3`
  model: FS114-Y2-BOWTIE, a Reuleaux bowtie on `B̄(p, 3√3/5)` with `Γ`-free lune rings — the configuration exists below `√3`
  prior art: new — "ab:Reuleaux & ab:colo*" (3), "ab:discharging & ab:unit distance" (1) — FS-114's gate
  handoff: none — superseded in scope by FS114-Y4-RSTOPALL; kept as the proof side's route

Rests on it: FS114-N5-GRING (N5-DEG, N5-R0 end in N4-D, N4-G); the proof side's derivation of the bowtie family's exclusion, independent of the
construction side's.

derivation: FS114-N4-LEMMAS
  statement: (N4-OWN) A Reuleaux corner of the bowtie never carries the colour of the lune it bounds (`2 ∉ P_cl(q1), P_cl(q3)`; `4 ∉ P_cl(q2), P_cl(q4)`):
    `ω(q1)` leaves `p` tangent to the `t2 | t3` edge and curves into `t2`; (N4-LENS) If `|u − v| = 1`, a tile meeting the open lens `B(u,1) ∩ B(v,1)` with a
    colour of `P_cl(u)` is `u`'s tile of that colour; a colour that `u` and `v` carry on different tiles meets no point of the open lens;
    (N4-TOP) In the degenerate member: the ring tiles `T_R ⊂ B̄(q1,1) ∩ B̄(top,1)`, `T_L ⊂ B̄(q3,1) ∩ B̄(top,1)`; one tile `W` of the far lune's colour
    fills the outer wedge at `top`, cone exactly `[60°, 120°]`, bordered by arcs of `ω(q1)` and `ω(q3)`; the lune tile reaches `top`, a degree-4 vertex of
    four colours `{2, 4, 5, 6}` at distance 1 from `p`; (N4-FIVE) with the lune rings free of `Γ`, a corner carries five colours iff its lune's ring is
    degenerate, and otherwise exactly four `{1, 3, 4, X}`; (N4-ARC) at a five-colour corner `q1`, 120° of unit arcs centred at `q1` lie within radius
    `√3` of `p`, and FS112-SIX's demand adds nothing beyond N-E0 on the far arc; (N4-A4NB) neither A4SIX nor NB4P gives the bowtie a new constraint
  uses only: FS114-N3-LOCAL, N-E1, N-E2, FS112-U1, FS112-SIX, FS112-A4SIX, FS112-NB4P
  not claimed: N4-OPP as N4 stated it (MISSTATED in general: an edge leaving `p` exactly opposite and curving toward `q` with curvature above 1 captures
    the branch of `ω(q)`; NB4's corrected second-order form holds, and N4-OWN is unaffected); N4-LENS without the non-Siamese hypothesis (FALSE: NB4)
  converse: FS114-N4-proof.md § 2.3
  argument: FS114-N4-proof.md § 2.1 Two lemmas
  verdict: derived
  grade: hand
  minds: 2 — blind to: NB4 derived N4-OWN, N4-LENS, N4-FIVE and N4-TOP before opening FS114-N4's record; method: NB4-OWN by E1 at the corner, using
    only the four edge circles and degree 4 at `p`; N4-ARC and N4-A4NB one mind
  model: FS114-Y2-BOWTIE (its corners carry five colours; its `top` the degree-4 four-colour vertex N4-TOP describes)
  prior art: new — "ab:Reuleaux & ab:colo*" (3), "ab:locally Hamiltonian & ab:degree" (10) — FS-114's gate
  handoff: none — relay-results for the bowtie's exclusion

N4-LENS's record statement adds "(likewise `v`)": the same statement with `u` and `v` exchanged, its hypothesis `|u − v| = 1` being symmetric; it
is left out of the quoted statement as a rider, not as a change of content.

Rests on it: FS114-N4-D; FS114-N5-GRING; the reconciliation of FS114-Y3-FOUR (four-colour corners occur only in N4's general member, which N4-G
excludes).

derivation: FS114-N5-GRING
  statement: (N5-ΓRING) **K1-ΓRING reduced**: a Reuleaux bowtie whose lune rings carry arcs of `ω(p)` (non-Siamese, simple class) does not exist on the
    closed disc of radius 2 about `p` unless a lune is in the residual **(R-V)** of N5-XBAR (one corner carries both absent colours; a (Q) arc `t2 | z4`
    ends at the lune's ring midpoint): every lune is degenerate (N4-D), general (N4-G), or (R0) (N5-R0), and every pair of lunes not involving (R-V) dies;
    (NB5-RVKILL) **(R-V) does not exist on `B̄(p, √3)`**: `T ⊂ B̄(P90′, 1)`, `z4 ⊂ B̄(q1, 1)`, and the direction `60°` at `top` between the externally
    tangent `ω(q1)`, `ω(P90′)` has no colour; no hypothesis on the bottom lune
  uses only: N5-BEND and N5-BENDG (FS-112's bends leave only (Q) and (R2) ring arcs at a degree-4 vertex, over FS112-N2-TOWARD, -AWAY, -TAN), N5-KAPPA,
    N5-UP (the up-tile at `top` avoids both corners' ring colours), N5-DEG, N5-W, N5-XBAR, N5-R0, N5-SIGHT, and FS114-N4-D
  not claimed: N5-RV's "Not excluded: K1-ΓRING is GAP at (R-V)" (FALSE: NB5-RVKILL); N5-BEND's length bound read for (Q) arcs (derived for (R2) arcs
    only); anything at the pinwheel (N5-PIN0's structure only)
  argument: FS114-NB5-verification.md § 1b.5
  verdict: derived
  grade: hand
  minds: 2 — blind to: NB5 derived N5-UP, -DEG, -R0, -ΓRING, -BEND, -KAPPA, -XBAR, -SIGHT, -BENDG, -W, -DR1 before opening FS114-N5's record;
    method: NB5-R0 by a different route (`C ∋ q2` makes `z4` start at `≤ 0°`); **the last step, NB5-RVKILL, is one mind**, and FS114-Y4-RSTOPALL
    excludes (R-V) independently, blind to both
  model: FS114-Y2-BOWTIE (a bowtie at radius `3√3/5`; its lune rings `Γ`-free) for the hypothesis class
  prior art: new — "ab:Reuleaux & ab:colo*" (3), "ab:discharging & ab:unit distance" (1) — FS-114's gate
  handoff: none — the proof side's route to FS114-Y4-RSTOPALL's conclusion (NB5-BOWTIE)

Rests on it: NB5-BOWTIE (K1-ΓRING closed at `√3`, one mind on its last step); with FS114-Y4-RSTOPALL, the bowtie family's exclusion by two independent
derivations.

derivation: FS114-Y4-LUNE
  statement: (Y4-LUNE) In a non-Siamese simple valid map with a Reuleaux bowtie at `p`, the two side tiles of each lune differ in colour:
    `c(X1) ≠ c(X4)`, `c(X2) ≠ c(X3)`; with SIDES the pattern is diagonal (`c(X1) = c(X3)`, `c(X2) = c(X4)`); (Y4-SIDES) Let `t1 = Reul(p, q1, q2)` be a
    tile of a valid map; the tile `X1` along its side `p q1` at `q1` and the tile `X2` along its side `p q2` at `q2` (both outside `t1`) are distinct and of
    different colours, Siamese pairs allowed; in a non-Siamese Reuleaux bowtie `{c(X1), c(X2)} = {5, 6}`; (Y4-UPDOWN) If `|u − v| = 1`, a tile at `u` with a
    direction `ψ` at `u` with `cos(ψ − arg(v − u)) > 0` has points within `< 1` of `v`, hence of every tile at `v`: in a non-Siamese map its colour is absent
    at `v` unless it is that tile; (Y4-W) In a non-Siamese simple Reuleaux bowtie the tile along `t1`'s outer side at `q1` and the one at `q2` are one
    tile `W`, of colour 3 (the colour of `t3`); `W ⊂ B̄(q1, 1) ∩ B̄(q2, 1)`, so its sector is inside `[300°, 360°]` at `q1` and `[0°, 60°]` at `q2`, pointing
    toward `r` at both
  uses only: the straddle computation (two tiles of one colour with points at distance above and below 1), FS112-U1, N-E1
  not claimed: the mirror clause of Y4-W for `t3`'s outer tile as a separate claim (it is Y4-W under the reflection); anything about non-Reuleaux lenses
  argument: FS114-Y4-construction.md § 3.1
  verdict: derived
  grade: hand
  minds: 2 — blind to: YB3 derived all four before opening FS114-Y4's record; method: different routes at LUNE's frontier and at W's colour steps;
    LUNE holds without "simple" (YB3); SIDES checked exactly at named points (`tools/fs114_y4_sides.py`)
  model: FS114-Y2-BOWTIE, which is diagonal (its side tiles 5 and 6 in the diagonal pattern)
  prior art: new — "ab:Reuleaux & ab:colo*" (3), "(ab:map | ab:maps) & ab:'distance 1' & ab:colo* & ab:plane" (0) — FS-114's gate
  handoff: none — relay-results for FS114-Y4-RSTOPALL

Rests on it: FS114-Y4-RSTOPALL; the emptiness of the `(1 3)` class (YB2-EMPTY13 is LUNE's symmetric instance) and of D2ALL's class; FS114-Y6-HALF's
inherited clauses.

derivation: FS114-Y4-RSTOPALL
  statement: **No non-Siamese simple valid fragment holding a Reuleaux bowtie at `p` contains neighbourhoods of the closed unit disc about `p` and of
    `r`**: RSTOP extends to every Reuleaux bowtie, symmetric or not, Γ-free or ΓRING; none holds a closed disc of radius `√3` about `p`. E1, E2 and E0 are
    all excluded
  uses only: FS114-Y4-LUNE and its lemmas, FS114-Y4-DIAG (a diagonal bowtie with neighbourhoods of `top` and `bot` has five colours at each `q_i`, `X1`
    starting at exactly 60°, forcing E1 at `r` and then no colour for `bot`'s sector `(240°, 300°)`), FS114-Y3-R (every map with a bowtie containing a
    neighbourhood of `r` uses E1 or E2), FS112-U1
  not claimed: the pinwheel, the `(2, 1, 1, 0)` patterns, non-Reuleaux lenses, non-simple bowties; maps with Siamese pairs (Y3-RSTOP, the one member,
    allows them); DIAG step 5's written reason ("`T2 ⊂ [240°, 300°]` points at `bot`" misses a cusp `T2` along 300°; closed by the `X2 | N′` unit arc:
    YB3-CUSP, exact 5/5)
  argument: FS114-Y4-construction.md § 3.3
  verdict: derived
  grade: hand
  minds: 3 — blind to: YB3 derived it before opening FS114-Y4's record; the proof side (FS114-N4, FS114-N5, FS114-NB5) derived the same conclusion blind to
    the construction side; method: YB3 by its own LUNE and DIAG routes; the proof side by sector orders, a lens N4-LENS empties and a diameter (N4-D, N4-G),
    the up-tile (N5-DEG, N5-R0) and NB5-RVKILL's tangency at `top`, whose last step is one mind
  model: FS114-Y2-BOWTIE and YB2's independent bowtie, each holding `B̄(p, 3√3/5)` — the family exists below `√3`
  prior art: new — "ab:Reuleaux & ab:colo*" (3), "(ab:map | ab:maps) & ab:'distance 1' & ab:colo* & ab:plane" (0) — FS-114's gate
  handoff: de Bruijn — deferred with D6: the first explicit-radius exclusion of a configuration at a four-colour vertex; what crosses: the statement, the
    bowtie's definition with reading R-T, the non-Siamese and simple hypotheses

Rests on it: K1's four-tactic Reuleaux case closed at `√3`; C114-LOCAL-F's first piece; FS114-Y3-RSTOP and FS114-N4-D as members; the successor's
Reuleaux `(2, 1, 1, 0)` question (FS114-Y6-HALF: the stop is not inherited).

derivation: FS114-Y3-RSTOP
  statement: **FS114-Y2-BOWTIE stops at `√3`**: no valid fragment (Siamese pairs allowed) that agrees with it near `q1` and `q2` contains a neighbourhood
    of `r = q1 + e(330°) = (√3, 0)`; so the bowtie extends to no closed disc of radius `√3` or more about `p` (with Y3-R: a map with a Reuleaux bowtie
    containing a neighbourhood of `r` uses E1 or E2; and Y3-D2: in Y2's symmetry class each `q_i` has exactly five colours and no fragment holds `√3`)
  uses only: N-E1 at `q1`, FS112-U1, and FS114-Y2-BOWTIE's tiles near `q1`, `q2`
  not claimed: Y3-FOUR's "so five colours at `q_i` are not forced by the bowtie" (FALSE once `top`'s neighbourhood is in the fragment: YB3-FIVE, Y4-DIAG);
    Y3-D2 without reading R-T (a GAP at one case: YB2)
  argument: FS114-Y3-construction.md § 2.1
  verdict: derived
  grade: hand
  minds: 2 — blind to: YB2 derived RSTOP, R and D2 before opening FS114-Y3's record; method: YB2 made the germ condition explicit (the stop is the cone
    `(−60°, 60°)` at `r`) and checked five exact points; Y3's tool 11 of 11 at a named ring point (`tools/fs114_y3_rstop.py`)
  model: FS114-Y2-BOWTIE, which agrees with itself near `q1`, `q2` and holds `B̄(p, 3√3/5)`
  prior art: new — "ab:Reuleaux & ab:colo*" (3), "ab:discharging & ab:unit distance" (1) — FS-114's gate
  handoff: none — a member of FS114-Y4-RSTOPALL

Rests on it: FS114-Y4-RSTOPALL's first member; the blind convergence at `√3` with FS114-N4-D (inventory item 66).

*Erratum (2026-10-03, FS129-Z1, from `plans/FS129-SR2-audit.md` § 2.1, row 95; `plans/FS129-close-inventory.md` item 117):* the handoff's "a member of FS114-Y4-RSTOPALL" holds only on the non-Siamese simple part: this entry allows Siamese pairs (its own statement, for FS114-Y2-BOWTIE), so it is not a case of RSTOPALL, which uses its lemma Y3-R. It stays a separate statement for the Lean backlog (SR2 § 4.3 item 16).

derivation: FS114-N6-NOQ
  statement: **No pinwheel has a ring free of (Q) arcs** (after the bends); in particular none with a `Γ`-free ring, at radius `1 + ε` (with N6-RING60: a
    four-colour vertex whose ring carries no (Q) arc has ring change points exactly `y + 60°ℤ`, six ring tiles alternating the absent colours, each
    spanning a closed 60° arc; and N6-CENT: at a non-Siamese degree-4 vertex whose ring carries no (Q) arc, all tactic centres lie in one class mod 60°,
    so non-Reuleaux lenses need a (Q) arc)
  uses only: FS114-N5-GRING's N5-BENDG, FS112-U1, N6-KAPPA, N6-WIN in its §2.2 form (the reach of `y + 60°` when `κ` is defined just before it), N6-P60′,
    N6-ADJ, N6-QOUT, N6-QE1, N6-PIN180, FS114-N3-LOCAL's N3-FLANK
  not claimed: pinwheels whose rings carry (Q) arcs (K1-PINQ; N6's "(Q) arcs never start at a centre counter-clockwise" is a GAP, NB6-QSTART); N6-WIN's
    table sentence and N6-COV as first stated (MISSTATED: each needs `κ` defined just beyond the windows; corrected, NB6); N6-MTP's route
  argument: FS114-N6-proof.md § 3.1 The correction
  verdict: derived
  grade: hand
  minds: 2 — blind to: NB6 derived NOQ, RING60, KAPPA, CENT, PIN, P60′, ADJ, QOUT, QE1, PIN180 before opening FS114-N6's record; method: NB6-NOQ by
    RING60, N3-FLANK and its own pinwheel lemma NB6-P60 (the kill the cone `(240°, 300°)` at `q_j`), needing no PIN180
  model: FS114-Y2-BOWTIE's centre for the ring lemma's hypotheses (a four-colour vertex after the bends); no pinwheel is held at `1 + ε`
  prior art: new — "ab:Reuleaux & ab:colo*" (3), "ab:exclusion zone & ab:colo*" (0) — FS-114's gate
  handoff: none — the proof side's half of the pinwheel's exclusion

Rests on it: with FS114-Y5-PINALL, the pinwheel closed from both ends at `1 + ε`; the coordinator's comparison that FS114-Y5's family `P_x` is N6's
(Q)-pinwheel (inventory item 103); FS114-N7-3T's ring tools.

derivation: FS114-Y5-PINALL
  statement: **no non-Siamese simple valid fragment containing a neighbourhood of the closed unit disc about `p` holds a pinwheel at `p`**, except possibly
    under E1 (an edge at `p` of length exactly `60°`) or E2 (a blade's counter-clockwise side a unit arc centred at its clockwise edge end)
  uses only: FS114-Y5-RAINBOW (C114-EDGE-RAINBOW's non-Siamese form), Y5-REGION, Y5-MU (with its two hypotheses: simple; edge `j + 1` below 60°), Y5-ALT,
    Y5-POCKET, Y5-CASE, Y5-REDUCE (outside E1 and E2 every pinwheel at `1 + ε` is `P_x`, cones `(x, 180° − x, x, 180° − x)`, `60° < x < 120°`),
    Y5-PIN120-60, and Y5-PXKILL (`T_k` and `O_{k+1}`, both of colour `k`, border the pocket tile `μ_k` along `ω(v_{k+1})` from `q_k` and along `ω(q_k)`
    from `v_{k+1}`, both outward, and come within `√(1 − 2tt′) < 1`)
  not claimed: E1 and E2 (exactly the cases the chain misses: YB4); Y5-PX's clause "`λ_k = α_k − 60°`" (a GAP: the pocket tile can wrap round `t_{k+1}`'s
    ring end — YB4-WRAP; CASE survives); Y5-PIN120-60's and Y5-PIN120's no-exception claims (GAPs at named E1 subcases, YB4)
  argument: FS114-Y5-construction.md § 4.3
  verdict: derived
  grade: hand
  minds: 2 — blind to: YB4 derived the twelve statements before opening FS114-Y5's record; method: YB4-2ND finds PXKILL's contradiction only at second
    order, from the arcs' curvature; its exact `ℚ(√3)` checker 53 of 53 as registered; the side's checks 31 of 31 and 11 of 11
  model: the pinwheel's local configuration at radius `1 + ε` about `p` is built in the frame of `P_90` by formula for the named-point checks
    (`tools/fs114_y5_px.py`); no pinwheel fragment on a neighbourhood of `B̄(p, 1)` exists outside E1, E2 — which is the theorem
  prior art: new — "ab:Reuleaux & ab:colo*" (3), "ab:exclusion zone & ab:colo*" (0) — FS-114's gate
  handoff: none — a local exclusion with two named exceptions; filed with them

Rests on it: K1's pinwheel case reduced to E1 and E2 (FS114-Y6-E1CAP, FS114-Y6-E2RED); the pinwheel closed from both ends with FS114-N6-NOQ.

derivation: FS114-Y6-E1CAP
  statement: **E1 forces a second 60° arc**: `t_2` borders the whole ring arc from `q_4` to `q_1`; the tactic tile `T_4` borders all of it from outside,
    contains `q_1` and lies in the Reuleaux cap `Reul(q_4, q_1, q_1 + q_4) ∖ B(p, 1)`; `α_4 = 120°` exactly (`φ_3 = φ_1 + 180°`), `α_2 + α_3 = 180°`, CASE
    (A) at `q_3` (with Y6-E1FORM, -E1Q3, -E1OMEGA, and Y6-E1K1: in E1 with `μ_1` bordering all of `M_1` and `α_2 > 60°`, the `P_x` kill of FS114-Y5-PXKILL
    runs at `k = 1` unless `T_4` fills the cap's corner at `q_4` and a tile of colour `m_2` sits at `q_1` between `T_1` and `μ_1`)
  uses only: FS114-Y5-PINALL's lemmas (MU, ALT, POCKET, CASE), FS114-L60-LE (the equality case at 60°), N-E1
  not claimed: E1CAP's "with `λ_3 = α_3 − 60°`" (a GAP: the wrap, YB5); E1's residues E1-Z, E1-60, E1-ν and the combinations E1{1,2}, E1{1,4}, E1 with E2
  argument: FS114-Y6-construction.md § 2.4
  verdict: derived
  grade: hand
  minds: 2 — blind to: YB5 derived E1FORM, E1Q3, E1OMEGA, E1CAP, E1K1 before opening FS114-Y6's record; method: YB5-CAP2, a Jordan-curve route to the whole
    arc; the side's checks 10 of 10 at named values (`tools/fs114_y6_e1.py`)
  model: FS114-L60's equality fragment (a unit arc of exactly 60° with its outer tile in the Reuleaux cap), the local shape E1 forces, twice
  prior art: new — "ab:Reuleaux & ab:colo*" (3), "ab:exclusion zone & ab:colo*" (0) — FS-114's gate
  handoff: none — a reduction of an exception; the residues are the successor's

Rests on it: the successor's E1 residues; the wrap lemma's second site (E1CAP's `λ_3`).

derivation: FS114-Y6-E2RED
  statement: E2 at one blade `t_{c+1}` (no E1) breaks only ALT(`μ_{c−1}`, `μ_c`), hence only POCKET at `w_c` and CASE at `q_c`; `P_x` is still excluded
    (FS114-Y5-PXKILL at `k = c + 1`); **the only E2 survivor family is S6 `(120°, b, 180° − b, 60°)`**, FS114-Y5-PIN120's own exception: S1
    `(a, b, 180 − b, 180 − a)` dies to PXKILL at `k = c + 1`, S2–S5 to YB5-E2-60 (E2 at a blade of cone 60° holds only with E1 at one of its two edges),
    S5 also by YB5-CONE180 (every pinwheel cone is below 180°)
  uses only: FS114-Y5-PINALL's lemmas, YB5-E2-60 (a width-1 Reuleaux triangle has diameter pairs only through a corner), YB5-CONE180
  converse: one-way — "the only" is a containment: S6 is what the chain leaves standing, not a family shown to exist
  not claimed: that S6 exists or dies; FS114-Y6's "all short of the tangent" (a GAP: a full wrap of `Λ_c`, YB5); E2 at two or more blades; E2 with E1
  argument: FS114-YB5-verification.md § 2.4
  verdict: derived
  grade: hand
  minds: 1 — the chain from E2 to S1–S6 is two minds (FS114-Y6; YB5 blind), the cut from S1–S6 to S6 is YB5's alone
  model: the cone sequence S6 at `b = 90°`, `(120°, 90°, 90°, 60°)`, a pinwheel shape the statement leaves standing
  prior art: new — "ab:Reuleaux & ab:colo*" (3), "ab:exclusion zone & ab:colo*" (0) — FS-114's gate
  handoff: none — a reduction of an exception

Rests on it: the successor's E2 target (S6 alone); the wrap lemma's third site. The cut to S6 is the one raise of the milestone on a single mind
(`plans/FS114-C-close.md` stage 2 §2.4).

derivation: FS114-Y6-HALF
  statement: in a `(2, 1, 1, 0)` pattern whose two-edge tile `t_1` is a width-1 Reuleaux triangle, with `t_2`'s cone above 60° and `t_4`'s at least 60°,
    FS114-Y4-SIDES, FS114-YB3-D2T and FS114-Y4-W hold unchanged: the side tiles at its corners are 5 and 6, and the tile along its ring arc is one cap tile
    `W`, of the colour of the tile opposite `t_1` at `p`; the stop at `√3` is **not** inherited, since Y3's germ condition at `r` needs the slivers that
    FS114-Y4-DIAG derived from the second Reuleaux triangle
  uses only: FS114-Y4-LUNE's lemmas (SIDES, W) and YB3-D2T
  not claimed: HALF as FS114-Y6 stated it, with no cone hypothesis (MISSTATED: at `t_2`'s cone 60° `q1 ∈ cl t_2` is forced, and at `t_4`'s below 60° SIDES-2
    fails or no map exists, YB5-HALF4); any stop for the half-bowtie
  argument: FS114-YB5-verification.md § 2.3
  verdict: derived
  grade: hand
  minds: 2 — blind to: YB5 derived the corrected form before opening FS114-Y6's record; method: YB5 found the two boundary subcases FS114-Y6's statement
    missed
  model: FS114-Y2-BOWTIE with one Reuleaux triangle kept: its `t1` side and cap tiles meet the hypotheses (a fragment below `√3`)
  prior art: new — "ab:Reuleaux & ab:colo*" (3), "ab:exclusion zone & ab:colo*" (0) — FS-114's gate
  handoff: none — a construction target's frame

Rests on it: the successor's Reuleaux `(2, 1, 1, 0)` target past `√3` (FS114-N7-3T excludes the `(2, 1, 1, 0)` patterns only on (Q)-free rings).

derivation: FS114-N7-3T
  statement: **Three or more tactic edges at a degree-4 vertex with a (Q)-free ring are excluded at radius `1 + ε`**, except the open-cap family **OC**
    (`+−+`, a Reuleaux lens beside a `60°` anti-lens; with a fourth tactic edge, the Reuleaux bowtie whose lenses do not border the caps): the
    `(2, 1, 1, 0)` patterns, the pinwheel, `γ = 0°` and non-Reuleaux lenses, `++−`, `−++` die in every member (with N7-HUB: at a four-colour vertex,
    non-Siamese and simple, whose ring is (Q)-free after the bends, each of the six change points `y_k` is a vertex of at least four colours: the directions
    toward `p` there lie in tiles of `p` reaching `y_k`, a tip, which meets `B(y_{k−1},1) ∩ B(y_{k+1},1)`, so its colour is carried at `y_{k±1}` by no other
    tile, and the outward directions in tiles of `p`'s colours outside `B̄(p,1)` whose `p`-tiles face away)
  uses only: N7-REACH, N7-TAN, N7-TAC, FS114-N6-NOQ's ring lemmas (N6-RING60, N6-CENT), FS114-N3-LOCAL (N3-FLANK), NB4's form of N4-OPP
  not claimed: rings with (Q) arcs (N7-HUBQ, the tip with (Q) arcs allowed, needs the change point's ±60° points free of (Q) arcs — the named GAP); OC
    (its forced structure N7-OCTB and a route to `√3`, not closed); the pinwheel's E1 and E2 in N7's readings R-E1, R-E2 (GAP; whether R-E2 is the
    construction side's E2 is not settled, `plans/FS114-C-close.md` stage 2 §2.5)
  argument: FS114-N7-proof.md § 2.2
  verdict: derived
  grade: hand
  minds: 1 — filed at one mind as the brief rules (inventory item 118); a blind check of N7-HUB (b) and the `+++ b = a + 1` step is the successor's first job
  model: FS114-Y2-BOWTIE's centre, a degree-4 four-colour vertex with four tactic edges whose ring carries no (Q) arc; the exclusion's scope is `1 + ε` for
    the patterns other than the bowtie (whose Reuleaux members die at `√3` instead)
  prior art: new — "ab:Reuleaux & ab:colo*" (3), "ab:discharging & ab:unit distance" (1) — FS-114's gate
  handoff: none — owed a blind second mind first; then with K1

Rests on it: K1's three-tactic case on (Q)-free rings; the reading (untested, one mind) that N7-HUB propagates four-colour vertices in hexagons — a lead
for C114-LOCAL-F. Tools: `tools/fs114_n7_hub.py`, exact at named values.

*Erratum (FS116-Z2, 2026-10-03; FS-116's close, `plans/FS116-close-inventory.md` items 29, 32, 39, 71, 110; the entry above stands as filed):*
1. *The model line.* FS114-Y2-BOWTIE's centre ring carries two (Q) arcs, its Reuleaux caps, so the bowtie is not a model of this entry's class
   (`data/fs116/n1/ring-survey-bowtie.out`: `[150°, 210°]` inner 3 | outer 1 and `[330°, 30°]` inner 1 | outer 3; `data/fs116/n3/semi.out` l. 18;
   FS116-V4's attack on KAPPA, item 8; `plans/FS116-Z1-close.md` § 2.4 F1). The line should read, in FS116-N1's drafted replacement
   (`plans/FS116-N1-proof.md` § Hand-back at stage 3, correction 1): `model: none held with a (Q)-free ring at a degree-4 four-colour vertex with three or more tactic edges (FS114-Y2-BOWTIE's centre has four tactic edges, but its ring carries two (Q) arcs, the Reuleaux caps — FS114-N6 § 4); the exclusion's scope is 1 + ε`.
   Nothing rests on the model line.
2. *The headline's setting.* Its first sentence omits the setting every step uses — non-Siamese, simple, exactly four colours at `p`, six colours, the
   ring after the bends (FS116-V1 § 3.3, § 4.3 row 6). The record's own statement carries it: "At a degree-4 four-colour vertex of a non-Siamese valid
   map in the simple class whose ring is (Q)-free after the bends, three tactic edges occur only in the pattern `+−+` (or its mirror `−+−`) with a
   Reuleaux lens and a `60°` anti-lens" (`plans/FS114-N7-proof.md` § 2.2). Read the headline in that setting.
3. *`+++`.* The enumerated list omits `+++` (with `e4` not tactic), which the record names first — "Up to rotation and reflection (which reverses the
   order and the signs) the sign patterns are `+++`, `++−`, `+−+`, `−++`" (§ 2.2) — and kills at its `b = a + 1` step; the headline covers it
   (FS116-V1 § 4.3 row 7; item 29).
4. *The parenthesis is a second claim.* "(with N7-HUB: …)" is N7-HUB, filed below as its own entry, FS114-N7-HUB (FS116-V1 § 3.3; item 32).
5. *The minds line.* The blind check it asked for ran (FS116-V1, 2026-09-29): N7-HUB stands at two minds in the reading FS116-V1 was given (see
   FS114-N7-HUB); the per-pattern kills stay **one mind** — FS116-V1's blind verdict "stalls at: the per-pattern kills at radius 1 + ε", its reading of
   the `+++`, `b = a + 1` step after its verdict a checking reading (FS116-V1 § 3.4, § 4.3 row 1; items 30, 71).
6. *What FS-116 adds to this class* (pointers; no verdict here changes): FS116-Y4-EMPTY, held (`plans/FS116-derivation.md`), excludes at radius `1 + ε`,
   in the non-Siamese simple class at six colours, every vertex of at least four colours whose ring carries no arc of `Γ`. Whether "after the bends"
   leaves arcs of `Γ` other than (Q) arcs on the ring of a fragment — so whether this entry's class is empty at `1 + ε` — is the invention signal of
   inventory item 136, carried to FS-123 unsettled (`plans/FS116-Z2-close.md` § 1.5).

derivation: FS114-N7-HUB
  statement: At a four-colour vertex (non-Siamese, simple) whose ring is (Q)-free after the bends, each of the six change points `y_k` is a vertex of at
    least four colours: the directions toward `p` there lie in tiles of `p` reaching `y_k` (a **tip**, which meets `B(y_{k−1},1) ∩ B(y_{k+1},1)`, so its
    colour is carried at `y_{k±1}` by no other tile), and the outward directions in tiles of `p`'s colours outside `B̄(p,1)` whose `p`-tiles face away
  uses only: FS114-N6-NOQ's N6-RING60 (six change points, the ring tiles `R_k` alternating the two absent colours); N-E2; CL and CL-p (two tiles of one
    colour with points less than 1 apart are one tile; a tile of a colour of `p` with a point in `B(p, 1)` is `p`'s own); N3-FACE at the unit pair
    `(p, y_k)`; six colours, exactly four at `p`
  not claimed: rings with (Q) arcs (N7-HUBQ: a tip only at a change point whose `±60°` points have `κ` defined just outside); anything in the Siamese or
    non-simple class; anything at `k ≥ 7`
  argument: FS114-N7-proof.md § 2.1 N7-HUB — the six change points of a (Q)-free ring are four-colour vertices, each with a tip
  verdict: derived
  grade: hand
  minds: 2 — blind to: N7's record and this file until its verdict's commit (FS116-V1, 894db2d9), though given FS114-N7-3T's statement with this
    claim inside it and the vetted definitions (`../data/fs116/v1-n7-definitions.md`: the D-frame's shape, N7's setting, the bends on a fragment
    leaving only (Q) ring arcs), so the second mind is on the ring carrying no arc of Γ near the hubs, and on rings with (R2) arcs the count is one;
    method: FS116-V1's same-colour dichotomy and the ring's flip at `σ^{±1}y` against N7's CL and ring cones for the tip, the dichotomy against N3-FACE
    for the outward tile; the same model (Opus 5.5), one prior
  model: none held — FS114-Y2-BOWTIE's centre is not one (its ring carries two (Q) arcs, the erratum above); on rings carrying no arc of Γ none exists
    at six colours, non-Siamese and simple (FS116-Y4-EMPTY, held)
  prior art: new — "ab:Reuleaux & ab:colo*" (3), "ab:discharging & ab:unit distance" (1) — FS-114's gate, as FS114-N7-3T
  handoff: none — a relay-result; true vacuously where the ring carries no arc of Γ (FS116-Y4-EMPTY), and its content, if any, on (Q)-free rings
    carrying (R2) arcs (FS-123)

Split from FS114-N7-3T's statement by FS116-Z2's erratum (2026-10-03), where it rode as a parenthesis (FS116-V1 § 3.3; inventory item 32). Its two minds are on FS116-V1's reading of "(Q)-free after the bends" (no arc of `Γ` on the ring), which FS116-Y4-EMPTY (held) makes empty at six colours, so there it is true vacuously; on rings carrying (R2) arcs it is one mind (N7's), and whether a fragment's bends leave such rings is inventory item 136. Tools: `tools/fs114_n7_hub.py`, exact at named values. Rests on it: FS114-N7-3T (every pattern kill reads the tips and the six four-colour vertices); FS116-N2-HEX6's model line; the successor's (Q)-free case (FS-123).

derivation: FS114-N7-QOPP
  statement: (N7-QOPP) Every (Q) arc of a four-colour degree-4 vertex joins opposite tiles (inner `t_i`, outer colour `c_{i+2}`); the other two tiles'
    colours are absent along it; (N7-FLANK) A tile of `p` with cone `[a, b]` puts its colour at no ring point in `(a ∓ 90°, b ∓ 90°)`; in
    `W(t) = [b − 90°, a + 90°]` only as itself, in `W̄(t)` only as other tiles; a ring point carries at most two colours of `p`; (N7-CHAIN) Change points
    propagate by `±60°` until the next point lies on a (Q) arc
  uses only: N-E1, N-E2, FS112-U1, FS114-N6-NOQ's N6-KAPPA
  not claimed: that (Q) arcs occur; K1 on (Q) rings (a GAP at N7-HUBQ)
  argument: FS114-N7-proof.md § 3.1
  verdict: derived
  grade: hand
  minds: 1
  model: the disk's corners (four-colour, degree 4, each carrying two (Q)-type unit arcs of the central Reuleaux pentagon), FS112-CAL-DISK
  prior art: new — "ab:Reuleaux & ab:colo*" (3), "ab:exclusion zone & ab:colo*" (0) — FS-114's gate
  handoff: none — tools for the (Q)-ring cases, the successor's

Rests on it: the successor's (Q)-ring cases of K1 (K1-QRING, K1-PINQ).

derivation: FS114-K1
  statement: K1 in its local form — no valid fragment, non-Siamese and simple, on a disc of explicit radius about a degree-4 four-colour vertex with three
    or four tactic edges
  argument: FS114-N7-proof.md § 3.4
  verdict: gap: the cases no entry above excludes — rings with (Q) arcs (N7-HUBQ; the (Q)-pinwheel's residual, NB6-QSTART), the pinwheel's E1 residues
    (E1-Z, E1-60, E1-ν; E1{1,2}, E1{1,4}, E1 with E2) and E2's survivor S6, the wrap (a pocket tile wrapping round a blade's ring end: Y5-PX's `λ`, E1CAP's
    `λ_3`, E2RED's full wrap), OC (K1-OPENCAP), non-simple bowties, and the Reuleaux `(2, 1, 1, 0)` on rings with (Q) arcs

Rests on it: nothing; it is the successor's opening list, in the order round 7 would have run it (a blind check of N7-HUB, the wrap lemma, OC, the (Q)-rings).

derivation: FS114-GSD
  statement: GS-D, the global step in DENSE3's form — no valid six-map with unit arcs exists (Q-full's NO), for every valid map, periodic or not
  argument: § 1. The reduction
  verdict: stalls at: C114-LOCAL-F — an explicit radius `R > φ²/√2` about a vertex of at least four colours within which no valid fragment exists, for
    every configuration of such a vertex (every degree, every number of tactic edges, Siamese pairs allowed); FS114-CV-EXISTS makes it the whole NO

Rests on it: nothing; it is FS-114's verdict, undecided, and the successor's target.

## 4. The construction side — the printed positives and the dial

derivation: FS114-Y-DIAL
  statement: The strip with each top (bottom) tile capped by the unit arc about its own valley between its two top corners is a valid fragment, and it
    holds the closed disc `B̄(P_j, R)` about every midline four-colour vertex for every `R` with `R² < (7 + 3√5)/4 = φ⁴/2` (`R < φ²/√2 ≈ 1.85123`); no
    valid extension of the strip holds that disc at `R ≥ φ²/√2` (the disc then holds the stop point `Q`) — C114-DIAL met, marginally, above `≈ 1.834`
  uses only: `[AxenovichEtAl2014]`'s strip as rebuilt at FS-112 (FS112-CAL-STRIP), the capping arcs by formula, and FS112-EDGE (the colourless cone at the
    strip's edge vertices)
  not claimed: a disc about a four-colour vertex beyond `φ²/√2` (none of this form); a valid map; any fragment with no Siamese pair beyond the disk's 2.1246
    (C114-SIRGEDAS-FORM not landed)
  argument: FS114-Y-construction.md § 2.1
  verdict: derived
  grade: computed over: the capped strip's 90 orbit pairs of same-colour tiles, each checked exactly (`tools/fs114_y_dial.py`); the disc containment an
    exact identity by hand
  minds: 2 — blind to: YB rebuilt the capped strip and checked it with its own exact checker before opening FS114-Y's record; method: YB's checker over
    towers of square roots, the rebuild identical tile for tile; the plant fires at exactly the six capped self-pairs
  model: the capped strip itself
  prior art: partly: `[AxenovichEtAl2014]` Thm 4.2 (the strip); the capping and the radius `φ²/√2` not found in print
  handoff: none — an exact object; C114-LOCAL-F's lower bound

Rests on it: C114-LOCAL-F's radius (`R > φ²/√2`; the claim list's 1.834 corrected); the model lines of this file.

derivation: FS114-Y-PENT
  statement: (Y-PENT) On `[Polymath2021]` Fig. 10's disk (FS112-CAL-DISK) `B_k`'s two close complementary partners `Z^R_k`, `Z^L_{k+1}` meet `ω(B_k)` at
    four distinct points `A_k, C_k, A_{k+1}, D_{k+1}`; so no valid map agrees with the disk near `B_k, Z^R_k, Z^L_{k+1}`, and no third unit-arc boundary at
    `B_k` (nor any choice of arcs) repairs it — C114-PENT's first question answered **no**. The completion `A_k + A_{k+1} − B_k` is the central corner
    `A_{k+3}`; (Y-DISKRIGID) Every valid colouring of the disk's geometry (`[Polymath2021]` Fig. 10, its 26 tiles) is the printed one up to a permutation of
    the six colours: the central tile and the five ring-1 tiles pairwise straddle distance 1, and each other tile, in a fixed order, then has exactly one
    colour left; so FS114-Y-PENT holds under every colouring: no valid map contains the disk's geometry near any `B_k`
  uses only: FS112-N3-COR3 (a close complementary pair sits on a unit rhombus whose other corners are four-colour leaving centres of both), FS114-Y-PAIRSHARE,
    the disk's exact coordinates
  not claimed: that the disk's blue and orange routes to a fourth colour at `C_0` are all refuted region-wide (FS114-Y-ROUTES holds at named points; its
    one-line region-wide reading is FALSE at 3 of 11 points, YB); anything about maps that do not contain the disk's geometry
  argument: FS114-Y-construction.md § 1.3
  verdict: derived
  grade: hand
  minds: 2 — blind to: YB derived PENT and DISKRIGID before opening FS114-Y's record; method: YB by its own exact straddle table (325 pairs) and a
    different deduction order for DISKRIGID; the owner's instance dropped DISKRIGID's chain clause (a slip, inventory item 39), which YB restored
  model: the disk, FS112-CAL-DISK, exact
  prior art: partly: `[Polymath2021]` Fig. 10 and `[Polymath16threads]` `[07.49]` (the disk is Gibbs's); that it is part of no valid map is not in print
  handoff: none — a statement about one printed object

Rests on it: C114-TORUS's family F2 excluded; the reading that neither printed positive is a piece of any valid map; E10 scored.

derivation: FS114-Y-STRIPK6
  statement: (Y-STRIPK6) In the strip's geometry the six tiles at a valley `V_m` (the arches `U_{m−1}`, `U_m` and the top tile `T_m`) and at the apex of
    `U_{m+1}` (`U_{m+1}`, `T_{m+1}`, `T_{m+2}`) pairwise straddle distance 1, so the two vertices are complementary under every colouring; `V_m`'s three
    boundary curves lie on `ω(P_{m−1})`, `ω(P_{m+1})` and a segment, none on `ω(Q_m)`, `Q_m` the pair's second common unit point; so by FS112-N3-COR3 no valid
    map contains these six tiles, under any colouring; (Y-STRIPRIGID) Every valid colouring of the strip's geometry is `[AxenovichEtAl2014]`'s, up to a
    permutation of the six colours
  uses only: FS112-N3-COR3 and the strip's exact straddle relations (`tools/fs114_y_conflicts.py strip`)
  not claimed: a statement about the capped strip's discs (FS114-Y-DIAL holds them as a fragment); maps not containing the six tiles
  argument: FS114-Y-construction.md § 2.2
  verdict: derived
  grade: hand
  minds: 2 — blind to: YB derived both before opening FS114-Y's record; method: different routes (YB's straddle table and its own deduction)
  model: the strip, FS112-CAL-STRIP, exact
  prior art: partly: `[AxenovichEtAl2014]` Thm 4.2 (the strip); Sirgedas's dual-graph reason why it cannot be extended (`[Polymath16threads]` `[16.347]`)
  handoff: none — a statement about one printed object

Rests on it: C114-TORUS's family F1 excluded; FS112-Y3-T2-BUDGET's "Not claimed" (other strip colourings) answered: none exists.

derivation: FS114-Y-PAIRSHARE
  statement: (Y-PAIRSHARE) In a valid map, any two close complementary cubic trichromatic partners `u′`, `u″` of a cubic trichromatic vertex `u` have a
    common unit point with `u` in common: `(ω(u) ∩ ω(u′)) ∩ (ω(u) ∩ ω(u″)) ≠ ∅`; (Y-K6) A design screen, about every valid map: if two cubic vertices
    `u`, `u′` at distance `< 2` have six incident tiles that pairwise straddle distance 1, they are complementary under every colouring, and each common unit
    point of `ω(u)`, `ω(u′)` must be a leaving centre of both (FS112-N3-COR3) — a geometry failing that is not part of any valid map, whatever its colours
  uses only: FS112-N3-COR3 and FS112-C-PARTNERS
  not claimed: that any valid map has a close complementary pair; a torus design meeting the screen (none built)
  argument: FS114-Y-construction.md § 1.3
  verdict: derived
  grade: hand
  minds: 2 — blind to: YB derived both before opening FS114-Y's record; method: YB over COR3 by its own case split
  model: none known in a valid map; the hypothesis (a cubic trichromatic vertex with close complementary partners) met on the strip and the disk as
    fragments, where FS114-Y-PENT and FS114-Y-STRIPK6 show the screen firing
  prior art: partly: de Grey, `[Polymath16threads]` `[17.282]` (the slack form: trichromatic points sharing no colour are at least 2 apart in a tiling
    avoiding `[1, d]`)
  handoff: none — a design screen

Rests on it: FS114-Y-PENT; the successor's torus design (a skeleton meeting K6 and PAIRSHARE at every close pair).

derivation: FS114-Y2-GAPS
  statement: About every valid map: at the centre `q` of a tactic edge `e` from `p` whose arc subtends `β` at `q`, the inner tile lies at `q` in the cone
    `[d + β − 90°, d + 90°]` and the tile `T` of the outer colour in `[d + 90° + β, d + 270°]` (`d` the direction from `q` to `p`, `e` turning
    counter-clockwise about `q`); so `q` carries further tiles in two cones of width at least `β`, one of them inside `B(p, 1)`; and in a non-Siamese map
    every tile meeting the open unit disc about a vertex `p` is a tile at `p` or has a colour absent at `p`
  uses only: FS112-U1's wedges and N-E2
  not claimed: how many tiles fill the two cones; that five colours are forced at `q` (forced only in the bowtie with `top`'s neighbourhood: FS114-Y4-DIAG)
  argument: FS114-Y2-construction.md § 1b.2
  verdict: derived
  grade: hand
  minds: 2 — blind to: YB2 derived it before opening FS114-Y2's record; method: YB2 over FS112-U1 directly
  model: FS114-Y2-BOWTIE's corners `q_i`, each the centre of a tactic edge from `p`
  prior art: new — "ab:Reuleaux & ab:colo*" (3), "ab:exclusion zone & ab:colo*" (0) — FS-114's gate
  handoff: none — a local tool

Rests on it: FS114-Y2's derivation of the bowtie's arrangement; the construction side's colour placements at tactic centres in rounds 3–6.

## 5. The L60 audit and row 134's base

derivation: FS114-L60-LE
  statement: (L60-LE) a unit arc with constant sides has `ℓ ≤ 60°` (its ends lie in the closure of one tile); (L60-EQ) at `ℓ = 60°` both side tiles lie in
    the lens `B̄(A, 1) ∩ B̄(B, 1)`: `T_in ⊆ Reul(P, A, B)`, `T_out ⊆ Reul(A, B, C) ∖ B̄(P, 1)`, `C = A + B − P`; at each end their sectors lie in the two
    corner cones (120° and 60°), which fill exactly the closed half-plane facing the other end, so each end is a vertex carrying a third tile; (L60-REAL)
    equality is realised, by a valid fragment by formula on a neighbourhood of the closed arc
  converse: FS114-L60-audit.md § 1.3
  uses only: the diameter bound (every tile has diameter at most 1) and TS-C; the fragment's exact coordinates for L60-REAL (`tools/fs114_l60_check.py`)
  not claimed: FS112-L60 as filed ("below 60°": FALSE at exactly 60°, the erratum in `plans/FS112-derivation.md`); the second clause's "ends" reading (FALSE
    at equality); that the equality case occurs in a valid map
  argument: FS114-L60-audit.md § 1.3
  verdict: derived
  grade: hand
  minds: 2 — blind to: nothing of the other's frame for the bound (FS114-L60 was briefed with FS114-N4's record open; N4 found it first) — blind to: the
    FS112-N and FS112-NB proofs' conclusions at the boundary, which both break at 60° by different steps (L60-PROOFS); method: N4 by the Reuleaux cap tile;
    L60 by the lens and the corner cones, with a fragment; the inner clause and the ends one mind
  model: L60-REAL's fragment (colours `Reul(P, A, B)`, the Reuleaux cap, two discs of radius `1/4` about the ends)
  prior art: new — "ab:Reuleaux & ab:colo*" (3), "ab:exclusion zone & ab:colo*" (0) — FS-114's gate; the lemma it corrects is FS-112's
  handoff: none — a correction of an FS-112 lemma, filed with its erratum

Rests on it: the erratum to FS112-L60; FS114-Y6-E1CAP (E1 is L60's equality case at `p`); FS114-L60-WALK.

derivation: FS114-L60-WALK
  statement: (L60-WALK) no step of FS112-N2-RED, FS112-N3-COR3, FS112-N3-BASE, FS112-N3-DENSE3 or FS114-CV-EXISTS (with CVB-EXISTS) needs the strict bound;
    each use of "`< 60°`" in their frames needs `0 < ℓ ≤ 60°` or only `0 < ℓ < 180°`, and the equality case passes every step; two remarks outside the
    chain are false at equality (NB's C-UA-CHAIN aside, N's ends reading of the second clause) and nothing rests on them; (L60-D5) in N3-BASE's setting,
    the two ends of a circle-to-circle path (CB D5 item 1) are less than 1 apart
  uses only: FS114-L60-LE, the statements and proofs of the five entries walked, N3-P′, N3-PAIR, N3-NOBOTH
  not claimed: a blind second mind (the registered L60-P1, p 0.85, and L60-P2, p 0.9, wait for one that never ran)
  argument: FS114-L60-audit.md § 2.1 The chain the brief names first
  verdict: derived
  grade: hand
  minds: 1
  model: L60-REAL's equality fragment, on which each walked step's frame is evaluated at `ℓ = 60°`; COR3's check re-run at arcs of 55°–60° (green)
  prior art: new — "ab:Reuleaux & ab:colo*" (3), "ab:exclusion zone & ab:colo*" (0) — FS-114's gate
  handoff: none — an audit of a chain; its blind second mind is owed before publication

Rests on it: FS114-CV-EXISTS's standing at the L60 boundary; the erratum's "no dependant affected" line.

derivation: FS114-BV-HEX
  statement: (BV-HEX) Lemma 6's `< 9` branch under H: the regular hexagon of kept points cannot occur at a cubic trichromatic `u` in a valid map (unit
    arcs allowed) when `x_1, …, x_6` are cubic; no Condition 5, no strip `A(u)`, no unit-arc step; (BV-L3) Lemma 3, a.e., curved, cusps and double cusps
    at `u₁, u₂`: no two points with the same multicolour at distance in (1, 2) whose unit circles carry proper finite circle colourings in the
    complementary triple; (BV-ND) NoDouble holds with unit arcs, at cusps; (BV-ND1) BV-ND under the 60° rotation of one circle: two switch points of
    `ω(u)` at distance 1 with the same pair, switching in opposite senses, are impossible at plain or cubic points; with unit arcs, no strip used
  uses only: the band lemma BV-H1 (a finite 3-colouring of the unit circle lifts to a height whose `h(x+60°) − h(x)` stays in one band), the unit-distance
    four-bar linkage, exact identities (sympy)
  not claimed: Lemma 4 at cusps (not landed: a GAP in BASE-V's blind derivation at Prop. 19(b) and the selection; CUSP-BASE's D5 items 1–4, 6 stay at
    CE's one mind); a downgrade of anything (the regrade is upgrades only)
  argument: BASE-V-verification.md § Theorems this phase proved
  verdict: derived
  grade: hand
  minds: 1 — BASE-V, blind to FS-110's and FS-112's walks of these steps; BV-HEX is CB D5 item 5 in substance (FS-110), with H in place of Condition 5,
    by a different route
  model: the hexagonal arrangement at a cubic trichromatic vertex is realised on the strip's edge vertices as fragments (FS112-EDGE), where the branch's
    hypothesis `n < 9` holds
  prior art: partly: `[SokolovVoronov2025]` Lemmas 3, 5, 6 and Prop. 18 (the steps are theirs; the curved, almost-everywhere, unit-arc forms are not)
  handoff: none — BASE-V's regrade of row 134's base (the ledger draft carries it)

Rests on it: row 134's base at its upgraded grade (S–V Lemma 5 and Prop. 18 two minds, both blind; Lemma 6's `< 9` branch under H; Lemma 3 and
Cor. 3 at cusps), hence FS112-N3-BASE and FS112-N3-DENSE3; not Lemma 4 at cusps, still one mind.

# FS-111 — the derivation file (the cone scale and the regularity step)

*Written by the close job FS111-C (Ephodos, Opus 5.5), 2026-09-28, in the grammar of `.claude/skills/ephodos/SKILL.md` § the entry, with Amendment 1
of the brief (every id qualified `FS111-…`; "Rests on it:" as prose). Every theorem FS-111 proved outside the kernel, one entry each; a verifier's
re-derivation is counted in its entry's minds, never filed twice. Grades translate as `hand` = [hand], `derived from` = [derived], `computed over` =
[tools]. Minds and blindness are read from the fence logs (`FS111-C-close.md` § Stage 2). Arguments are addresses in the job records, resolved from
`plans/`. **Nothing here moves a value.** Objects and words (SEQ, LIM, D-NF, `𝓜_K`, `δ₀(K)`, D-SLACK, D-AEMAP, the S–V Conditions, Q-NO) are
`../data/fs111/claims.md` §0; "seven" is `χ_m⁰(ℝ²) ≥ 7`, and given MR it is `χ(ℝ²) = 7` (row 130). **Q-NO is not held**: it is row 134 together
with FS-114's NO, which is open, so every entry that assumes it is a conditional.*

*Prior-art queries cited below (zbMATH, `ab:` fields unless marked; hits read by title): FS111-P's, `FS111-cone-scale.md` § Stage 4 item 1; FS111-M2's,
`FS111-M2-regularity.md` § 1.3; this close's, `../data/fs111/fs111-c/zb_*.json` via `../tools/fs111_c_zb.py` (self-test PASS; a planted fault fires).
Novelty is measured at the grain of the object class those queries name, not of every step; where a step's own search was not run, the entry says
"partly" and names what is in print.*

## Card 1 — the composition (FS111-P; FS111-V0 blind)

derivation: FS111-C1-UNIF
  statement: 1 − lim_{ε→0} µ₆(ε) = inf_K δ₀(K); hence χ_m⁰(ℝ²) ≥ 7 ⟺ inf_K δ₀(K) > 0
  uses only: H-EQ (row 131) and FS106-SUP's periodic attainment; the rasterisation of a periodic partial colouring into closed cells (density
    threshold, or V0's pixelation with slack loss 3h); that 𝓜_K is non-decreasing in K; the equivalence needs only H-EQ as quoted
  not claimed: any value of inf_K δ₀(K); that δ₀(K) is attained; that δ₀ tends to 0 or not
  converse: FS111-V0-verification.md § 2.2
  argument: FS111-cone-scale.md § 2.2
  verdict: derived
  grade: hand
  minds: 2 — blind to: FS111-P's stages 2 and 5 until V0's verdicts were committed (08c4d8f3); method: V0 rasterised by pixelation with closed cells,
    P by a density threshold (stage 3b's correction)
  model: K = 4: every H-EQ grid colouring by closed squares is a design of 𝓜_4 (four segments per tile)
  prior art: partly: [Voronov2023] Prop. 2.1 prints the regularisation at positive slack (tile scale h < ε/2) and §1 names the zero-slack problem
    "substantially more difficult"; the equivalence along the complexity filtration not found (FS111-cone-scale.md § Stage 4)
  handoff: de Bruijn — queued behind the measurable chain (FS-113, FS-101): the statement with µ₆ and 𝓜_K defined; no Lean object for either yet

Rests on it: card 1's answer (a hole bound uniform in `K` is seven itself, not a third statement); FS111-C1-PW's reading as the pointwise form; the
dial FS-109 would read along `K`.

derivation: FS111-V0-CLEAN
  statement: the limit tiling W-EQ-K produces (a full tight a.e.-proper six-colouring by closed tiles of complexity at most K) can be cleaned — equal
    colours merged, slits and degree-2 vertices erased, islands filled — into an S–V map-type colouring (Conditions 2–4) bounded by segments and
    circular arcs, a.e.-proper (D-AEMAP), with at most six colours
  uses only: W-EQ-K's output (tiles bounded by at most K arcs or segments, at most K tiles per unit disc); FS111-V0-CLOSE; Townsend's island fill
  not claimed: that the cleaned map has no unit arcs (row 134 or FS-114 decides which NO applies)
  argument: FS111-V0-verification.md § 2.1
  verdict: derived
  grade: hand
  minds: 1 — FS111-V0
  model: the tight hexagonal seven-colouring read as a tiling (already a map; the cleaning is the identity)
  prior art: partly: its island fill is Townsend's simplification (a) (FS111-VM2-verification.md § 1.4, step 5); the cleaning of W-EQ-K's limit not found
  handoff: none — a routine cleaning step inside FS111-C1-PW; it crosses with that entry if the chain is formalized

Rests on it: FS111-C1-PW.

derivation: FS111-V0-CLOSE
  statement: in a D-AEMAP-proper map, a closure point of a colour-j region is never at distance 1 from an open colour-j point
  uses only: D-AEMAP; openness of regions; continuity of the distance
  not claimed: anything about boundary points of different colours
  argument: FS111-V0-verification.md § 2.1
  verdict: derived
  grade: hand
  minds: 1 — FS111-V0
  model: the tight hexagonal seven-colouring by hexagons of circumradius 1/2
  prior art: owed — a one-line lemma; no search was run at its grain
  handoff: none — a one-line lemma used by FS111-V0-CLEAN and VM2-FACE; crosses with them

Rests on it: FS111-V0-CLEAN; FS111-M2-REDUCE-C (VM2-FACE step 6).

derivation: FS111-C1-PW
  statement: Q-NO ⟹ δ₀(K) > 0 for every K
  uses only: W-EQ-K (⟹; two minds, one blind); FS111-V0-CLEAN; row 134 for maps with no unit arc and FS-114's NO for maps with one (the premise Q-NO)
  not claimed: any lower bound on δ₀(K) uniform in K; FS-114's NO itself
  argument: FS111-cone-scale.md § 2.3
  verdict: derived
  grade: derived from: FS111-V0-CLEAN
  minds: 2 — blind to: FS111-P's stage 2 until V0's verdicts were committed; method: V0 made the cleaning step explicit (V0-CLEAN)
  model: K = 4, the grid designs of 𝓜_4; the premise Q-NO is open, so the entry is a conditional
  prior art: new — “distance & measurable & map & colo(u)ring” (0), “(cc:05C15 | cc:52C10) & plane & (measurable | regions | map) & distance” (17)
  handoff: none — conditional on FS-114's NO, which is open; it crosses with the NO if the NO lands

Rests on it: card 1's answer, with FS111-C1-UNIF: the map NO's whole content is pointwise in `K`.

derivation: FS111-V0-WIGGLE
  statement: notching raises the complexity of a band-proper partial six-colouring without bound at fixed slack and fixed junction cones, at an
    O(α²) cost in holes
  uses only: a notch of depth α inside one tile, placed away from every junction; band-properness is kept by shrinking only
  not claimed: that notching preserves any other regularity (perimeter density grows)
  argument: FS111-V0-verification.md § 2.1
  verdict: derived
  grade: hand
  minds: 1 — FS111-V0
  model: any grid design of 𝓜_4 with one notch per tile
  prior art: new — “distance & measurable & map & colo(u)ring” (0), “chromatic & plane & (measurable | map) & (tight | saturat* | maximal)” (7)
  handoff: none — a no-go on a reading of the card; it enters no proof of a value

Rests on it: FS111-V0-FLIT; FS111-C1-FALS; the corrected FS111-C1-GAP (complexity measured literally is no restriction).

derivation: FS111-V0-WIG7
  statement: the tight hexagonal seven-colouring with its edges replaced by arbitrary smooth wiggles (inside a strip that keeps every same-colour
    distance off 1) is tight and a.e.-proper, has fat junctions, and has interfaces that are neither segments nor circular arcs
  uses only: the hexagonal seven-colouring's same-colour gaps (> 1.29); tightness from each hexagon's diameter being exactly 1 at its vertices
  not claimed: a six-colour analogue
  argument: FS111-V0-verification.md § 2.1
  verdict: derived
  grade: hand
  minds: 1 — FS111-V0
  model: the object itself, with one sinusoidal wiggle per edge
  prior art: new — “chromatic & plane & (measurable | map) & (tight | saturat* | maximal)” (7), “Reuleaux & colo* & distance” (0)
  handoff: none — a control object showing what REG-J leaves; it enters no proof of a value

Rests on it: FS111-C1-FALS; the corrected FS111-C1-GAP (reading 3); M-DEADLOCK's second inhabitant.

derivation: FS111-V0-FLIT
  statement: the card's falsifier as written ("every family with holes → 0 and cone scale ≥ s₀ has a subsequence of bounded complexity whose limit is
    a segment-and-arc map") holds iff no hole-vanishing family keeps cone scale ≥ s₀ (𝓕_{s₀} = ∅)
  uses only: FS111-V0-WIGGLE (a member of 𝓕_{s₀}, notched, is a member with no bounded-complexity subsequence); the converse by vacuity
  not claimed: whether 𝓕_{s₀} is empty
  converse: FS111-V0-verification.md § 2.4
  argument: FS111-V0-verification.md § 2.4
  verdict: derived
  grade: derived from: FS111-V0-WIGGLE
  minds: 1 — FS111-V0
  model: s₀ = 1/100 and any hole-vanishing family, notched
  prior art: new — “distance & measurable & map & colo(u)ring” (0), “(cc:05C15 | cc:52C10) & plane & (measurable | regions | map) & distance” (17)
  handoff: none — a statement about a registered falsifier; it enters no proof of a value

Rests on it: FS111-C1-FALS; FS111-V0-BRIDGE (the right form of the bridge is F′, not the falsifier).

derivation: FS111-C1-FALS
  statement: on band-proper partial six-colourings "cone scale ≥ s₀ ⟹ bounded complexity" is false in every reading of (B), and on tight
    seven-colourings "fat junctions ⟹ segment-and-arc interfaces" is false
  uses only: FS111-V0-WIGGLE (the sequence side); FS111-V0-WIG7 (the limit side)
  not claimed: that the card's falsifier does not follow from (B) — a non-implication no argument here establishes (seven implies it vacuously)
  argument: FS111-V0-verification.md § 2.6
  verdict: derived
  grade: derived from: FS111-V0-WIGGLE, FS111-V0-WIG7
  minds: 2 — blind to: FS111-P's stage 2 until V0's verdicts were committed; method: P argued at the level of the notions, V0 by the two objects
  model: a notched grid design (sequence side); the wiggled hexagonal seven-colouring (limit side)
  prior art: new — “distance & measurable & map & colo(u)ring” (0), “chromatic & plane & (measurable | map) & (tight | saturat* | maximal)” (7)
  handoff: none — a no-go on a reading; it enters no proof of a value

Rests on it: card 1's answer; the claim list's corrected C1-FALS (Drafts §D3 of `FS111-C-close.md`).

derivation: FS111-V0-BRIDGE
  statement: with F′(s₀) — if 𝓕_{s₀} ≠ ∅ then δ₀(K) = 0 for some K — and B_fam — if holes can vanish they can vanish keeping cone scale ≥ s₀ — one has
    Q-NO ∧ B_fam ∧ F′ ⟹ χ_m⁰(ℝ²) ≥ 7, and χ_m⁰(ℝ²) ≥ 7 ⟹ F′
  uses only: FS111-C1-PW (F′'s conclusion then fails); H-EQ; vacuity for the second implication
  not claimed: F′; that Q-NO ∧ B_fam implies F′
  argument: FS111-V0-verification.md § 2.4
  verdict: derived
  grade: derived from: FS111-C1-PW
  minds: 1 — FS111-V0
  model: the premises are open; the statement is a pair of implications, inhabited at the level of the definitions (any s₀ > 0)
  prior art: new — “distance & measurable & map & colo(u)ring” (0), “(cc:05C15 | cc:52C10) & plane & (measurable | regions | map) & distance” (17)
  handoff: none — a bridge between open statements; it crosses with them

Rests on it: the corrected FS111-C1-GAP; the front page's route-M sentence (the third statement in sequence form).

derivation: FS111-C1-GAP
  statement: for each reading r of (B) — as FS107-RR poses it, standalone at complementary pairs, standalone at every junction (REG-J) — there is a
    statement T_r with Q-NO ∧ (B) ∧ T_r ⟹ χ_m⁰(ℝ²) ≥ 7 and χ_m⁰(ℝ²) ≥ 7 ⟹ T_r; for readings 1–2, T is the exclusion of colourings with holes → 0 and no
    complementary blocking pair, at complexity measured modulo modification; for reading 3, T is REG-I and REG-A given REG-J, or a NO for the
    interfaces such limits have
  uses only: FS111-C1-UNIF; FS111-C1-PW; FS107-R-CP and FS107-RR (held, two minds); FS111-V0-WIGGLE; FS111-V0-WIG7; vacuity
  not claimed: that Q-NO ∧ (B) does not imply seven (the planner's "only together with"); that any T_r is provable
  argument: FS111-V0-verification.md § 2.5
  verdict: derived
  grade: derived from: FS111-C1-UNIF, FS111-C1-PW, FS111-V0-WIGGLE, FS111-V0-WIG7
  minds: 1 — FS111-V0 (the corrected statement; the gap's location is two minds, P and V0 blind)
  model: reading 3 at seven colours: the wiggled hexagonal seven-colouring has REG-J's junctions and non-arc interfaces
  prior art: new — “distance & measurable & map & colo(u)ring” (0), “(cc:05C15 | cc:52C10) & plane & (measurable | regions | map) & distance” (17)
  handoff: none — a statement of where a proof is missing; it enters no proof of a value

Rests on it: card 1's answer at two minds; the successor stubs FS-121 and FS-122 (their questions are `T_3` and `T_1`); every front-page sentence
about the doors.

derivation: FS111-V0-RESCALE
  statement: if an a.e.-proper measurable k-colouring of ℝ² exists, a tight one exists (rescale by 1 ± ε*, ε* the supremum of the slacks); so a tight
    a.e.-proper k-colouring exists iff χ_m⁰(ℝ²) ≤ k
  uses only: D-SLACK; that dilation by 1 + ε maps a colouring with slack ε to one proper at the band's edge; the converse is immediate (a tight
    colouring is an a.e.-proper one)
  not claimed: that every a.e.-proper colouring is tight
  converse: FS111-V0-verification.md § 2.1
  argument: FS111-V0-verification.md § 2.1
  verdict: derived
  grade: hand
  minds: 1 — FS111-V0
  model: k = 7: the hexagonal seven-colouring of circumradius 1/2 is already tight; at circumradius 0.49 it has slack and rescales to it
  prior art: new — “chromatic & plane & (measurable | map) & (tight | saturat* | maximal)” (7), “unit distance & measurable & (boundary | regular*)” (1)
  handoff: de Bruijn — queued behind the measurable chain (FS-113): a short lemma with D-SLACK and a.e.-properness defined

Rests on it: FS111-C-SEVEN-M, FS111-C-SIX-M, FS111-C-REG-EQ (the step "a tight colouring exists iff `χ_m⁰ ≤ k`" they used without proof);
FS111-M2-REDUCE-C's `k = 5` conclusion; FS111-W-NEG.

derivation: FS111-C-SEVEN-M
  statement: Q-NO ∧ REG-A₆ ⟹ χ_m⁰(ℝ²) ≥ 7
  uses only: FS111-V0-RESCALE; REG-A₆'s conclusion (a segment-and-arc map carrying an a.e.-proper six-colouring); Q-NO excludes it
  not claimed: REG-A₆; Q-NO
  argument: FS111-V0-verification.md § 2.8
  verdict: derived
  grade: derived from: FS111-V0-RESCALE
  minds: 2 — blind to: FS111-P's stage 5 until V0's verdicts were committed; method: V0 supplied the rescaling step P had cited to a definition
  model: both premises open; a conditional
  prior art: new — “distance & measurable & map & colo(u)ring” (0), “chromatic & plane & (measurable | map) & (tight | saturat* | maximal)” (7)
  handoff: none — a two-line composition of open statements; it crosses with them

Rests on it: FS111-C1-ROUTES (route M); FS111-C-REG-EQ.

derivation: FS111-C-SIX-M
  statement: FS106-AE-MAP6 ∧ REG-I₅ ⟹ χ_m⁰(ℝ²) ≥ 6; given MR (row 130), χ(ℝ²) ≥ 6
  uses only: FS111-V0-RESCALE; FS106-AE-MAP6 at its grade (one mind per link, the fill in outline, modulo Townsend's (c)); row 130 for the MR clause
  not claimed: REG-I₅; FS106-AE-MAP6 beyond its grade
  argument: FS111-V0-verification.md § 2.8
  verdict: derived
  grade: derived from: FS111-V0-RESCALE
  minds: 2 — blind to: FS111-P's stage 5 until V0's verdicts were committed; method: as FS111-C-SEVEN-M
  model: premises open; a conditional
  prior art: new — “distance & measurable & map & colo(u)ring” (0), “chromatic & plane & (measurable | map) & (tight | saturat* | maximal)” (7)
  handoff: none — a composition of open statements; it crosses with them

Rests on it: FS111-M2-REDUCE-C (which supersedes it at five by a weaker hypothesis); the FS-104 bearing line (Drafts §D8).

derivation: FS111-C-REG-EQ
  statement: given Q-NO, REG-A₆ ⟺ χ_m⁰(ℝ²) ≥ 7; given FS106-AE-MAP6, REG-I₅ ⟺ χ_m⁰(ℝ²) ≥ 6
  uses only: FS111-C-SEVEN-M and FS111-C-SIX-M (⟹); vacuity (⟸: with the answer, no tight colouring exists and REG holds vacuously)
  not claimed: that REG's lower rungs are equivalent to the answer (they are implied by it, and do not imply it alone)
  converse: FS111-V0-verification.md § 2.8
  argument: FS111-V0-verification.md § 2.8
  verdict: derived
  grade: derived from: FS111-C-SEVEN-M, FS111-C-SIX-M
  minds: 2 — blind to: FS111-P's stage 5 until V0's verdicts were committed; method: the same vacuity, reached independently
  model: premises open; the statement's content is the direction of the caution
  prior art: new — “distance & measurable & map & colo(u)ring” (0), “chromatic & plane & (measurable | map) & (tight | saturat* | maximal)” (7)
  handoff: none — a caution about the rungs' strength; it enters no proof

Rests on it: the honesty rule every route-M sentence obeys ("REG's top rung is the answer restated"); FS111-VM2-EQ5 at five in cover form.

derivation: FS111-C1-ROUTES
  statement: route R — FS107-R-CP with A-ALL and B-RR gives χ_m⁰(ℝ²) ≥ 7 without Q-NO; route M — Q-NO with REG-A₆ gives it; the front page's
    composition (FS-114's NO plus the cone scale) is route M with REG-I and REG-A missing, or route R with (A) at every complexity missing
  uses only: FS107-RR and FS107-R-CP (held, two minds); C-Q-STAB's disc form (row 131); FS111-C-SEVEN-M
  not claimed: that either route closes; that the cone scale is idle in route M (it is REG's rung REG-J)
  argument: FS111-cone-scale.md § 2.5
  verdict: derived
  grade: derived from: FS111-C-SEVEN-M
  minds: 2 — blind to: FS111-P's stage 2 until V0's verdicts were committed; method: V0 re-read (R) through the pixelation of FS111-C1-UNIF
  model: premises open; a map of routes
  prior art: new — “distance & measurable & map & colo(u)ring” (0), “(cc:05C15 | cc:52C10) & plane & (measurable | regions | map) & distance” (17)
  handoff: none — a map of routes; it enters no proof

Rests on it: the front-page correction (`LEDGER.md` row 133's "two questions", the rank-2 row, the programme line, the atlas's MEET mark); the three
successor stubs.

derivation: FS111-C-FILL
  statement: if x is j-free with |S̃_j ∩ A_η(x)| = 0, the fill move on B(x, η/2) with colour j keeps the colouring a.e.-proper with k colours
  uses only: x ∈ A*_j forces η < 1; the Leb ⊗ σ measure of unit pairs into the null set S_j ∩ A_η(x) is 0; other classes only lose points
  not claimed: that fills saturate (fills create no contact for the filled colour, FS111-W-FILL-FREE)
  argument: FS111-V0-verification.md § 2.8
  verdict: derived
  grade: hand
  minds: 2 — blind to: FS111-P's stage 5 until V0's verdicts were committed; method: the same measure estimate (a third reading, FS111-M § 1.4,
    sighted of V0)
  model: the tight hexagonal seven-colouring at an edge midpoint, η < 0.098
  prior art: partly: [Voronov2023] Obs. 2.2 (filling a region's inclusions keeps properness) is the map-type analogue
  handoff: de Bruijn — queued behind the measurable chain: a short measure estimate once D-NF is in Lean

Rests on it: FS111-M-SATC's cover form; the §IQ structural form's "free moves".

derivation: FS111-C-HULL
  statement: in a tight a.e.-proper k-colouring in D-NF, for C ⊆ S̃_j path-connected and x ∈ A*_j, either |x − c| < 1 for every c ∈ C or |x − c| > 1
    for every c ∈ C; the form with sup_{c∈C}|x − c| < 1 or dist(x, C) > 1 holds when C is compact
  uses only: I-D1 in V0's form (FS111-V0-ID1: |x − c| ≠ 1 for c ∈ S̃_j, x ∈ A*_j); continuity of c ↦ |x − c| on a path-connected C
  not claimed: A*_j ⊆ {x : sup_{c∈C}|x − c| < 1} ∪ {x : dist(x, C) > 1} for non-compact C — refuted (FS111-C-HULL-SO)
  argument: FS111-V0-verification.md § 2.8
  verdict: derived
  grade: hand
  minds: 2 — blind to: FS111-P's stage 5 until V0's verdicts were committed; method: the same interval argument; M re-derived it sighted (M-HULL1)
  model: the tight hexagonal seven-colouring, C a hexagon's interior, x a point of another hexagon
  prior art: partly: I-D1 is FS-106's; the path-connected form not found
  handoff: de Bruijn — queued behind the measurable chain, with FS111-V0-ID1

Rests on it: FS111-M-PINCH (Step 1 applies it at density points converging to a partner); FS111-M-HULL2; FS111-M2-FIX.

derivation: FS111-C-HULL-SO
  statement: the claim list's "so": A*_j ⊆ {x : sup_{c∈C}|x − c| < 1} ∪ {x : dist(x, C) > 1} for every path-connected C ⊆ S̃_j
  argument: FS111-V0-verification.md § 2.8
  verdict: refuted: the tight hexagonal seven-colouring by hexagons of circumradius 1/2 coloured (m + 3n) mod 7, x a vertex of a hexagon H of colour j
    (d̄_j(x) = 1/3), C = int H: sup_{c∈C}|x − c| = 1 is attained only at the opposite vertex, outside C, and dist(x, C) = 0 (exact, ../tools/fs111_v0_hex.py)

Rests on it: nothing; the corrected form is FS111-C-HULL.

control: FS111-C-HULL-SO-EXACT
  of: FS111-C-HULL-SO — the counterexample's exact check passes on the faithful object and fails with the vertex misplaced
  run: python3 ../tools/fs111_v0_hex.py >/dev/null 2>&1; echo $?
  expect: 0
  fault: python3 ../tools/fs111_v0_hex.py --plant vertex >/dev/null 2>&1; echo $?

derivation: FS111-V0-ID1
  statement: I-D1 holds for every a.e.-proper measurable colouring: if y ∈ S̃_j and d̄_j(x) > 0 then |x − y| ≠ 1
  uses only: Lebesgue density at y; a positive-density neighbourhood of x meeting unit circles about a full-density disc at y in positive measure
  not claimed: anything at points of density 0
  argument: FS111-V0-verification.md § 2.1
  verdict: derived
  grade: hand
  minds: 1 — FS111-V0 (FS-103's D1 is a second derivation of the tight case; whether V0 saw it first is not recorded, so it is not counted)
  model: the tight hexagonal seven-colouring
  prior art: partly: FS-106's I-D1 (data/fs106/claims.md §1) for tight colourings
  handoff: de Bruijn — queued behind the measurable chain

Rests on it: FS111-C-HULL; FS111-M-PINCH; FS111-M2-INT.

## Round 1 — route M's first rungs (FS111-M), the wild side (FS111-W), their blind verifier (FS111-VMW)

*M and W were competitors, each blind to the other's record; VMW derived before opening either (committed `3ea1d5ab`), from the statements the
owner's brief quoted. Q1 = “chromatic & plane & (measurable | map) & (tight | saturat* | maximal)” (7) and Q2 = “unit distance & measurable & (boundary |
regular*)” (1) are this close's queries (`../data/fs111/fs111-c/zb_tight_col.json`, `zb_mua_regular.json`); they are written out in full where cited.*

derivation: FS111-M-SATC
  statement: every a.e.-proper k-colouring lies below a maximal admissible cover (k measurable sets with null unit pairs, maximal under inclusion up
    to null sets, union of full measure), and every maximal cover's supports satisfy ℝ² = int F_j ∪ (F_j + S¹) for each j; a selection from a maximal
    cover is an a.e.-proper k-colouring
  uses only: Zorn's lemma on admissible covers ordered by a.e. inclusion (chains have measurable unions up to null sets); I-D1 for the shadow identity
  not claimed: that a selection is saturated (FS111-M2-NOSEL); that the classes are regular (FS111-M3-IRREG)
  argument: FS111-M-regularity.md § 2.2
  verdict: derived
  grade: hand
  minds: 1 — FS111-M (FS111-M2-COV re-reads it, sighted)
  model: k = 7: R7's classes (a maximal cover with disjoint classes, FS111-VMW-R7-MAX); DISC7 (a maximal cover with overlaps)
  prior art: new — “unit distance & maximal & measurable” (1), “fall coloring & infinite” (2)
  handoff: de Bruijn — queued behind the measurable chain: Zorn on admissible covers is short once a.e.-properness is in Lean

Rests on it: the ruling that route M runs on maximal covers (item 25); FS111-M2-COV; FS111-M2-REDUCE-C.

derivation: FS111-M-SLACKFREE
  statement: if a colouring has slack ε in form (a), every point of A*_j is j-free; so a saturated colouring (every essential boundary point a
    j-contact for each j in its essential multicolour) is tight
  uses only: D-SLACK form (a); the band annulus A_ε(x) meets S̃_j in a null set at every x ∈ A*_j
  not claimed: that tight colourings are saturated (FS111-M-DEADLOCK: the hexagonal one cannot be saturated locally)
  argument: FS111-M-regularity.md § 2.3
  verdict: derived
  grade: hand
  minds: 1 — FS111-M
  model: the hexagonal seven-colouring at circumradius 0.49 (slack; every point free)
  prior art: new — “chromatic & plane & (measurable | map) & (tight | saturat* | maximal)” (7), “unit distance & measurable & (boundary | regular*)” (1)
  handoff: none — a two-line remark placing saturation inside tightness; it crosses with FS111-M-SATC

Rests on it: the order of the rungs (saturation is a strengthening of tightness).

derivation: FS111-M-R7
  statement: R7 — Reuleaux triangles of width 1 on the up triangles of the unit triangular lattice Λ, coloured by the four cosets of 2Λ, and the cusped
    down triangles coloured by the three cosets of M = ⟨(0, √3), (3/2, √3/2)⟩ — is a.e.-proper, tight and saturated (every essential boundary point is a
    contact point for each of its colours); every boundary is a unit arc centred at a lattice point that carries both its side colours
  uses only: exact arithmetic in ℚ(√3) on one fundamental domain of Λ; the reduction of the plane's distance conditions to finitely many tile pairs
    by periodicity; every same-colour critical distance ≥ 1 (216 pairs)
  not claimed: saturation with partners of positive density (FALSE at the down arcs, FS111-VMW-R7-PPLUS); any six-colour analogue
  argument: FS111-M-regularity.md § 2.4
  verdict: derived
  grade: computed over: one fundamental domain of Λ, 7 classes, exact in ℚ(√3), with the hand reduction of the plane to it
  minds: 2 — blind to: FS111-M's record until VMW's verdicts were committed (3ea1d5ab); method: M by two distance engines agreeing (its own and the
    frozen FS112-Y engine), VMW by hand proofs and its own exact certificates
  model: R7 itself
  prior art: partly: the colouring is [Polymath16threads] thread 4 (de Grey, 5 May 2018); thread 12 (Hockertz, 2019) names its "100% exclusion rate"
    informally; its saturation in the claim list's sense not found — “Reuleaux & colo* & distance” (0)
  handoff: de Bruijn — a periodic tiling in ℚ(√3) with an exact certificate; kernel-checkable now, not urgent (a control object)

Rests on it: FS111-VMW-R7-MAX; the verdict "honest C-SAT-T TRUE at `k ≥ 7`"; W-P1 and W-P2 scored FALSE; G84's inhabitant; FS111-M2-REDUCE-C's
`k = 7` inhabitant; the ruling that route M's first rung runs on covers (item 25: the selection is free at seven).

control: FS111-M-R7-EXACT
  of: FS111-M-R7 — the exact check passes on R7 and fails with the down classes coloured mod 2
  run: python3 ../tools/fs111_m_reuleaux7.py >/dev/null 2>&1; echo $?
  expect: 0
  fault: python3 ../tools/fs111_m_reuleaux7.py --plant down_mod2 >/dev/null 2>&1; echo $?

derivation: FS111-VMW-R7-MAX
  statement: R7 is saturated in the strongest reading: for every point x and every colour j with x ∉ S̃_j, some point of cl S̃_j is at distance
    exactly 1 from x; so no fill of any colour at any point keeps it a.e.-proper, and R7's seven classes form a maximal admissible cover with disjoint
    classes
  uses only: R7's geometry (each up of width 1 excludes its own unit neighbourhood; each down's three concave unit arcs); FS111-M-SATC's condition
    ℝ² = int F_j ∪ (F_j + S¹)
  not claimed: saturation with positive-density partners
  argument: FS111-VMW-verification.md § 1.5
  verdict: derived
  grade: hand
  minds: 1 — FS111-VMW (an exact grid of 144 points, 0 exceptions, as a check)
  model: R7
  prior art: partly: [Polymath16threads] thread 12's "100% exclusion rate" (Hockertz) is the informal statement; the proof not found
  handoff: none — a property of a control object; it crosses with FS111-M-R7 if that is formalized

Rests on it: the closing of M's open item (R7's down classes maximal); "at `k = 7` the cover form and the honest form coincide on one object".

derivation: FS111-VMW-R7-PPLUS
  statement: at x = (1, √3 − 1) on a down tile's arc of R7, every same-colour closure point at distance 1 from x is the cusp (1, √3) of the neighbouring
    same-colour down tile, a point of density 0; so R7 is not saturated if partners must have positive density
  uses only: a cone lemma at the cusp; exact arithmetic at the named point
  not claimed: the same at every relative-interior point of the down arcs (checked at 69 sampled exact points, not proved)
  argument: FS111-VMW-verification.md § 1.5
  verdict: derived
  grade: computed over: the named point (1, √3 − 1) and 69 sampled exact points, ℚ(√3)
  minds: 1 — FS111-VMW
  model: R7
  prior art: new — “Reuleaux & colo* & distance” (0), “chromatic & plane & (measurable | map) & (tight | saturat* | maximal)” (7)
  handoff: none — shows which reading of saturation R7 meets; nothing downstream rests on (P+) (M-PINCH needs no partner density)

Rests on it: the scope of "R7 is saturated" (the claim list's reading, not (P+)); G84's clause "no partner density needed".

derivation: FS111-M-R7-FORCE
  statement: on the up/down Reuleaux tiling, saturation of the arcs' down sides forces every down colour class to be a union of cosets of M; four colours
    on the ups and three on the downs are each the minimum
  uses only: the ups at distances 1 and √3 contain a K₄; three mutually touching downs; saturation at each down arc's midpoint
  not claimed: that the tiling admits no saturated colouring other than R7's up to symmetry
  argument: FS111-M-regularity.md § 2.4
  verdict: derived
  grade: hand
  minds: 1 — FS111-M
  model: R7
  prior art: new — “Reuleaux & colo* & distance” (0), “chromatic & plane & (measurable | map) & (tight | saturat* | maximal)” (7)
  handoff: none — a rigidity remark about a control object

Rests on it: nothing downstream.

derivation: FS111-M-DEADLOCK
  statement: in the tight hexagonal seven-colouring of circumradius 1/2 (and in its wiggled form), no a.e.-proper colouring agreeing with it off
    B(x, ρ), x an edge midpoint, ρ < 1 − √13/4, has a contact point for either of the edge's two colours inside B(x, ρ)
  uses only: the same-colour gaps of the hexagonal colouring (> 1.29); the farthest own-hexagon point √13/4 from an edge midpoint
  not claimed: that no global modification saturates it (hex7 is recoloured into no saturated colouring by W-HEXSAT (2), a different statement)
  argument: FS111-M-regularity.md § 2.5
  verdict: derived
  grade: hand
  minds: 1 — FS111-M (agreeing with W's HEXSAT (2), HEX7-RIGID and FILL-FREE and with VMW's calibration: three instruments)
  model: the hexagonal seven-colouring, x an edge midpoint, ρ = 1/20
  prior art: new — “chromatic & plane & (measurable | map) & (tight | saturat* | maximal)” (7), “unit distance & measurable & (boundary | regular*)” (1)
  handoff: none — a no-go for local saturation; it enters no proof of a value

Rests on it: the verdict "honest saturation is global" (C-SAT-T's procedural form GAP); the ruling to run route M on covers.

derivation: FS111-M-PINCH
  statement: at a saturated point x of an honest a.e.-proper colouring with a neighbourhood N in which only two colours a, b have positive measure and each
    is a.e. one connected open set of density points (H1, H2): either N is split by one unit circle T₁(y) with a inside and b outside or the reverse, y a
    contact of both colours, or two open unit discs tangent at x from opposite sides lie a.e. in S_a and in S_b; the case (in, in) is impossible; no
    positive density of the partner is needed
  uses only: FS111-C-HULL's first clause applied at density points q_n ∈ S̃_a converging to the partner y_a, then the closed-disc limit; (H1); (H2);
    saturation at x
  not claimed: the same without (H1) or (H2) (C-HULL-REG as stated is a GAP there); anything at points of the singular set Σ
  argument: FS111-M-regularity.md § 3.1
  verdict: derived
  grade: derived from: FS111-C-HULL
  minds: 3 — blind to: each other's records (M and W, competitors; VMW before 3ea1d5ab); method: M by M-HULL1 at density points (no partner density);
    W with H-DEN applying C-HULL at the partner itself; VMW with one-sidedness (H2′) — its stage-1 GAP at cusp partners withdrawn on reading M's Step 1
  model: R7 at a Reuleaux arc point (case (in, out): a unit arc of kind both, the down partner a cusp of density 0); SQ9 at an edge point (out, out)
  prior art: partly: the two-sided rolling-ball step is classical ([Walther1999], listing seen, unread) — “rolling ball & (C^{1,1} | curvature)” (8);
    the dichotomy for saturated colourings not found
  handoff: de Bruijn — queued behind the measurable chain: the central lemma of route M, with (H1), (H2) stated and its not-claimed line kept

Rests on it: FS111-M-C11; FS111-M-EXTREME; FS111-M2-HULLC's pinch clause; FS111-M4-LADDER (every interface point of M-PINCH's tangent type); G84.

derivation: FS111-M-C11
  statement: if M-PINCH's hypotheses hold at every essential boundary point in N, then ∂_e S_a ∩ N′ (N′ ⋐ N) is a C^{1,1} curve with curvature in
    [−1, 1] and unit-parallel partners on both sides; a single unit arc if any of its points is of the split type
  uses only: FS111-M-PINCH at every point; the two-sided unit-ball condition gives C^{1,1} with |κ| ≤ 1 (classical)
  not claimed: that the curve is a segment or a circular arc (REG-A's missing rung, FS111-M2-INTRAD under REG-J′); "curvature 1 exactly on arcs of kind
    both" (W-CURV's "exactly", not derived)
  argument: FS111-M-regularity.md § 3.2
  verdict: derived
  grade: derived from: FS111-M-PINCH
  minds: 3 — blind to: each other's records, as FS111-M-PINCH; method: M from PINCH; W as W-C11 with H-DEN; VMW as VMW-HULL
  model: R7 (every interface of the split type); SQ9 (κ = 0)
  prior art: partly: [Walther1999] (the rolling theorem; listing seen, unread) for the C^{1,1} step — “rolling ball & (C^{1,1} | curvature)” (8)
  handoff: de Bruijn — with FS111-M-PINCH; the rolling-ball step would need its own formal proof or a Mathlib source

Rests on it: FS111-W-NOBEND; FS111-W-HULLREG-MAPS; FS111-M2-INTRAD (interfaces off Σ are C^{1,1} before their radii are read); G84.

derivation: FS111-W-NOBEND
  statement: a saturated two-colour interface under (H1), (H2) has no bend (corner), and its curvature is at most 1
  uses only: FS111-M-C11
  not claimed: that curvature equals 1 only on arcs of kind both (a case-(i) unit arc about an a-contact with b inside is locally consistent)
  argument: FS111-W-wild.md § 2.2
  verdict: derived
  grade: derived from: FS111-M-C11
  minds: 2 — blind to: W's record until VMW's verdicts were committed; method: W as corollaries of W-C11, VMW from the common form
  model: SQ9's edges (no bend at an edge point); R7's arcs (curvature 1)
  prior art: partly: as FS111-M-C11
  handoff: none — a corollary; it crosses with FS111-M-C11

Rests on it: FS111-W-HULLREG-MAPS.

derivation: FS111-W-NOREP
  statement: at a cone vertex of a saturated map without cusps, no colour occupies two sectors
  uses only: FS111-M-C11 applied at the partner points y_a(p) of interface points p near the vertex, where (H2) holds for all but finitely many p on a map
  not claimed: the same for general saturated colourings (GAP: (H2) at the partners is not among C11's hypotheses there)
  argument: FS111-W-wild.md § 2.3
  verdict: derived
  grade: derived from: FS111-M-C11
  minds: 1 — FS111-W (read sighted by VMW, who scoped it to maps)
  model: SQ9's vertices (four distinct colours); R7's lattice points (three Reuleaux and three cusp colours, all distinct)
  prior art: new — “chromatic & plane & (measurable | map) & (tight | saturat* | maximal)” (7), “unit distance & measurable & (boundary | regular*)” (1)
  handoff: none — a lemma inside FS111-W-HULLREG-MAPS; it crosses with it

Rests on it: FS111-W-HULLREG-MAPS; the exclusion of M's stub (d) among maps without cusps.

derivation: FS111-W-HULLREG-MAPS
  statement: on every saturated map without cusps, each point with two colours locally has a neighbourhood in which the interface is the graph of a
    C^{1,1} function with |κ| ≤ 1, semiconcave and semiconvex
  uses only: on a map away from vertices (H1) and (H2) hold, and without cusps every partner has positive density; FS111-M-C11; FS111-W-NOBEND
    (no bend); FS111-W-NOREP (no repeated colour at a vertex, so no bichromatic vertex)
  not claimed: C-HULL-REG for general saturated colourings (GAP at (H1), (H2)); maps with cusps (R7 has them, and the conclusion holds there anyway)
  argument: FS111-W-wild.md § 2.6
  verdict: derived
  grade: derived from: FS111-M-C11, FS111-W-NOBEND, FS111-W-NOREP
  minds: 1 — FS111-W (VMW agrees on the class, D9)
  model: SQ9; HEX9
  prior art: partly: Rataj–Zajíček's planar description of r-convex boundaries by semiconcave and semiconvex functions ([RatajZajicek2025] §1) is the
    frame
  handoff: none — superseded as a statement by FS111-M-C11's common form; crosses with it

Rests on it: the verdict "C-HULL-REG TRUE on saturated maps without cusps".

derivation: FS111-M-EXTREME
  statement: every component R of an open class of a saturated honest colouring has at least two points on its minimal enclosing circle, and at none of
    them does M-PINCH's conclusion hold for R's colour: each is a cusp of R or a point where (H1) or (H2) fails
  uses only: the minimal enclosing circle has radius < 1 (a component has diameter ≤ 1); FS111-M-PINCH puts a unit disc on the region's side at every
    pinch point, which cannot fit at an extreme point
  not claimed: the same on maximal covers (FALSE: FS111-M2-EXTREME-C, DISC7)
  argument: FS111-M-regularity.md § 3.3
  verdict: derived
  grade: derived from: FS111-M-PINCH
  minds: 1 — FS111-M (read and checked sighted by VMW, D4)
  model: R7: the three vertices of every up and the three cusps of every down
  prior art: new — “chromatic & plane & (measurable | map) & (tight | saturat* | maximal)” (7), “unit distance & measurable & (boundary | regular*)” (1)
  handoff: none — a structural lemma toward REG-J′; it crosses with REG-J′ if that lands

Rests on it: FS111-M-REDUCE-I (vertex-free loops excluded); REG-J′'s evidence (Σ is non-empty in every region).

derivation: FS111-M-COVER-SC
  statement: in a maximal cover, at every boundary point of F_a each adjacent path-connected piece of F̃_a lies in an enclosing unit disc or outside an
    exterior one; where ∂F_a is locally the graph of a continuous function with F_a below it, that function is semiconcave with constant 1
  uses only: FS111-M-SATC's shadow identity; FS111-C-HULL's first clause
  not claimed: semiconvexity (FALSE on covers: DISC7, curvature 2)
  argument: FS111-M-regularity.md § 3.4
  verdict: derived
  grade: derived from: FS111-M-SATC, FS111-C-HULL
  minds: 1 — FS111-M (FS111-M2-HULLC extends it, sighted; VM2 blind on HULLC)
  model: DISC7's classes (discs of radius 1/2: semiconcave, not semiconvex with constant 1)
  prior art: partly: semiconcavity from an exterior-ball condition is classical ([RatajZajicek2017] Thm 6.4's statement read); the cover form not found
  handoff: none — superseded by FS111-M2-HULLC's fuller form; crosses with it

Rests on it: FS111-M2-HULLC.

derivation: FS111-M-HALF
  statement: at a point x saturated for j, every path-connected piece of S̃_j with x in its closure lies in a closed half-plane in every blow-up at x, so
    has upper density at most 1/2 at x: no colour takes a reflex angle at a saturated point
  uses only: FS111-C-HULL's first clause at the contact of x; the blow-up of a unit disc at a boundary point is a half-plane
  not claimed: that the pieces' blow-ups are sectors (a cone structure at x is REG-J′'s content)
  argument: FS111-M-regularity.md § 4.1
  verdict: derived
  grade: derived from: FS111-C-HULL
  minds: 1 — FS111-M
  model: R7 at a lattice point (each up's 120° sector)
  prior art: new — “chromatic & plane & (measurable | map) & (tight | saturat* | maximal)” (7), “unit distance & measurable & (boundary | regular*)” (1)
  handoff: none — a structural lemma toward REG-J′

Rests on it: FS111-M-POLAR; REG-J′'s evidence.

derivation: FS111-M-POLAR
  statement: at a saturated point, each such piece's blow-up lies in the intersection of the half-planes of all its contacts (facing an inner contact,
    facing away from an outer one), a convex cone
  uses only: FS111-M-HALF at every contact of x
  not claimed: that the cone is non-degenerate
  argument: FS111-M-regularity.md § 4.1
  verdict: derived
  grade: derived from: FS111-M-HALF
  minds: 1 — FS111-M
  model: R7 at a lattice point: each up's 120° sector is the polar cone of its 60° arc of contact directions
  prior art: new — “chromatic & plane & (measurable | map) & (tight | saturat* | maximal)” (7), “unit distance & measurable & (boundary | regular*)” (1)
  handoff: none — a structural lemma toward REG-J′

Rests on it: REG-J′'s evidence; FS-120's junction question (the sector structure at a saturated junction).

derivation: FS111-M-HULL2
  statement: two path-connected pieces of one class of an a.e.-proper colouring have all cross distances < 1 or all > 1
  uses only: FS111-C-HULL's first clause at each point of one piece (density points of a path-connected piece); path-connectedness of the other
  not claimed: that "near" (all < 1) is transitive (that is tight block structure, FS111-M-BLOCK-EQ)
  argument: FS111-M-regularity.md § 1.5
  verdict: derived
  grade: derived from: FS111-C-HULL
  minds: 2 — blind to: M's record until VMW's verdicts were committed; method: VMW's component form in VMW-BLOCK-EQ ("linked or apart")
  model: two hexagons of one colour in the hexagonal seven-colouring (all cross distances > 1.29)
  prior art: partly: Cohen–Mani's block structure ([CohenMani2025] §5) presupposes the dichotomy for blocks; for classes of a colouring not found
  handoff: none — a lemma inside FS111-M-BLOCK-EQ

Rests on it: FS111-M-BLOCK-EQ.

derivation: FS111-M-BLOCK-EQ
  statement: in a colouring whose classes are a.e. unions of path-connected components, a class has tight block structure iff "near" (all cross
    distances < 1) is transitive among its components
  uses only: FS111-M-HULL2 (near or far); a block of diameter ≤ 1 is a near-clique
  not claimed: that any tight colouring has tight block structure (FALSE universally at seven: FS111-W-DECO-B)
  converse: FS111-VMW-verification.md § 1.6
  argument: FS111-M-regularity.md § 4.2
  verdict: derived
  grade: derived from: FS111-M-HULL2
  minds: 2 — blind to: M's record until VMW's verdicts were committed; method: VMW's route adds that tight block structure coincides with Cohen–Mani's
  model: R7 (blocks = tiles, 216 same-colour pairs, critical distances ≥ 1, exact)
  prior art: partly: Cohen–Mani's block structure ([CohenMani2025] §5, after [KMOR2016]) is the one-class notion; its chain form for a colouring not
    found
  handoff: none — a reformulation of REG-B used to read objects; it enters no proof of a value

Rests on it: REG-B's verdicts; FS-121's note on CM-Q5.1 (Cohen–Mani's Question 5.1 is the one-class calibration).

derivation: FS111-M-REDUCE-I
  statement: REG-I_k follows from the honest existence form of C-SAT-T at k together with REG-J′_k (a saturated colouring whose singular set Σ is locally
    finite, each point of Σ meeting finitely many interface arcs); so, with FS106-AE-MAP6, χ_m⁰(ℝ²) ≥ 6 follows from those two statements at k = 5
  uses only: FS111-M-C11 off Σ; the finitely-many-arcs clause for S–V Condition 3 at Σ; FS111-M-EXTREME or V0-CLEAN's island fill for loops;
    FS111-W-NOBEND for degree-2 points; FS111-V0-RESCALE; FS106-AE-MAP6 at its grade
  not claimed: honest C-SAT-T at five; REG-J′₅; the statement without the finitely-many-arcs clause (the owner's brief dropped it; VMW's blind stage 1
    named it as the missing step)
  argument: FS111-M-regularity.md § 5.1
  verdict: derived
  grade: derived from: FS111-M-C11, FS111-V0-RESCALE
  minds: 2 — blind to: M's record until VMW's verdicts were committed; method: VMW derived the chain from the brief's paraphrase and located its one
    missing step at the clause M's statement contains
  model: k = 7: R7 satisfies both hypotheses and is a map-type colouring
  prior art: new — “distance & measurable & map & colo(u)ring” (0), “chromatic & plane & (measurable | map) & (tight | saturat* | maximal)” (7)
  handoff: none — superseded at five by FS111-M2-REDUCE-C (no honest saturation needed); crosses with it

Rests on it: FS111-M2-REDUCE-A; the round-2 ruling (item 25).

derivation: FS111-W-NEG
  statement: (i) each existence rung REG-A_k, REG-I_k, REG-J_k, REG-B_k holds at every k ≥ 7 (the tight hexagonal seven-colouring witnesses each) and
    vacuously at k ≤ 4; (ii) its negation at k ∈ {5, 6} asserts a tight a.e.-proper k-colouring, so implies χ_m⁰(ℝ²) ≤ k; (iii) A-ALL, read with its δ
    quantified with R, η, µ, holds iff χ_m⁰(ℝ²) ≥ 7
  uses only: FS111-V0-RESCALE; the hexagonal seven-colouring; for (iii) ⟸, vacuity (row 131's disc form: with seven, some U_R admits no band-proper
    partial six-colouring with small holes), and ⟹ contrapositively (A-ALL's failure gives, for every R and δ, holes < δ in U_R, which is χ_m⁰ ≤ 6)
  not claimed: that B-RR's failure at A-ALL's fixed R, δ implies χ_m⁰ ≤ 6 (MISSTATED in the owner's brief; true only of the joint statement with R, δ
    free); any value
  converse: FS111-VMW-verification.md § 1.9
  argument: FS111-W-wild.md § 1.4
  verdict: derived
  grade: derived from: FS111-V0-RESCALE
  minds: 2 — blind to: W's record until VMW's verdicts were committed; method: W periodises the inscribed square, VMW cites row 131's disc form
  model: k = 7: the hexagonal seven-colouring
  prior art: new — “distance & measurable & map & colo(u)ring” (0), “(cc:05C15 | cc:52C10) & plane & (measurable | regions | map) & distance” (17)
  handoff: none — a caution about what a wild object can refute and about route R's third statement; it enters no proof of a value

Rests on it: the headline's "each route's third statement is the answer restated"; FS-122's bearing (A-ALL ⟺ seven); the reading that a `k = 7`
inhabitant tests procedures and universal forms only; R-P3 read as a bet on six.

derivation: FS111-W-SQ9
  statement: the colouring of the plane by closed squares of side 1/2, square (i, j) coloured (i mod 3, j mod 3), is a.e.-proper, tight and saturated,
    also with positive-density partners (every edge faces a same-colour edge at distance exactly 1)
  uses only: same-colour squares at offsets (3a/2, 3b/2); exact distances of facing edges
  not claimed: saturation below nine colours on square tilings (FS111-W-HEXSAT's hexagonal analogue)
  argument: FS111-W-wild.md § 1.5
  verdict: derived
  grade: computed over: one period of the square lattice (9 classes), exact rationals
  minds: 2 — blind to: W's record until VMW's verdicts were committed; method: W's checker ../tools/fs111_w_check.py, VMW's own certificates
  model: SQ9 itself
  prior art: new — “chromatic & plane & (measurable | map) & (tight | saturat* | maximal)” (7), “Reuleaux & colo* & distance” (0)
  handoff: none — a control object; exact and periodic, formalizable on demand

Rests on it: the controls of M2-INTRAD (VM2-LAD-CTL), M4-LADDER (an unpinched inhabitant); C-SAT-T at nine.

derivation: FS111-W-HEX9
  statement: hexagons of width 1/2 coloured by Λ′/3Λ′ form a saturated tight a.e.-proper nine-colouring, also with positive-density partners
  uses only: nearest same-colour hexagons face flat-to-flat across exactly 1; exact distances
  not claimed: saturated hexagonal colourings at other widths (FS111-W-HEXSAT)
  argument: FS111-W-wild.md § 2.4
  verdict: derived
  grade: computed over: one period of the hexagonal lattice (9 classes), exact in ℚ(√3)
  minds: 2 — blind to: W's record until VMW's verdicts were committed; method: W's checker, VMW's certificates
  model: HEX9 itself
  prior art: new — “chromatic & plane & (measurable | map) & (tight | saturat* | maximal)” (7), “Reuleaux & colo* & distance” (0)
  handoff: none — a control object

Rests on it: VM2-LAD-CTL; FS111-W-HEXSAT's positive half.

derivation: FS111-W-KB-DIR
  statement: at the centre of a unit arc of kind both in a saturated colouring, the inner colour's sector points toward the arc
  uses only: FS111-M-PINCH's split case; the partner at the centre carries both colours
  not claimed: anything at an arc of kind in or out
  argument: FS111-W-wild.md § 2.3
  verdict: derived
  grade: derived from: FS111-M-PINCH
  minds: 1 — FS111-W
  model: R7 (each Reuleaux arc's centre is the opposite corner, whose sector points toward the arc)
  prior art: new — “chromatic & plane & (measurable | map) & (tight | saturat* | maximal)” (7), “Reuleaux & colo* & distance” (0)
  handoff: none — a local rule for saturated maps

Rests on it: FS111-W-NOREP case (ii); the necessary conditions W listed for a saturated seven-colouring (R7 meets them).

derivation: FS111-W-LADDER
  statement: a flat edge of a saturated map carries interfaces at every unit translate along its normal, with the colour rule β_{k+1} = τ_{k−1}
  uses only: FS111-M-PINCH's tangent case at every point of the edge (partners one unit along the normal on both sides)
  not claimed: that the ladder is infinite in a map with junctions (the ladder ends where the map stops being two-coloured along it; FS111-M4-CUT)
  argument: FS111-W-wild.md § 2.4
  verdict: derived
  grade: derived from: FS111-M-PINCH
  minds: 1 — FS111-W (FS111-M4-LADDER is the same mechanism for curved layers, derived sighted)
  model: SQ9 (every edge carries its unit ladder; VM2 exact, 48 of 48 edge-sides)
  prior art: new — “chromatic & plane & (measurable | map) & (tight | saturat* | maximal)” (7), “parallel curve* & unit distance” (0)
  handoff: none — a local rule, superseded by FS111-M2-INTRAD's unit-parallel form

Rests on it: FS111-W-HEXSAT; FS111-M4-LADDER's flat side.

derivation: FS111-W-HEXSAT
  statement: a regular hexagonal tiling is saturable only at width 1/m; at width 1/2 exactly nine colours; no recolouring of the hexagonal
    seven-colouring's or the brick seven-colouring's tiling is saturated
  uses only: FS111-W-LADDER on the hexagons' flat edges; FS111-W-HEX9 for the nine at width 1/2
  not claimed: that no saturated seven-colouring exists (FALSE: FS111-M-R7, which has no flat edge)
  argument: FS111-W-wild.md § 2.4
  verdict: derived
  grade: derived from: FS111-W-LADDER, FS111-W-HEX9
  minds: 1 — FS111-W
  model: HEX9
  prior art: new — “chromatic & plane & (measurable | map) & (tight | saturat* | maximal)” (7), “Reuleaux & colo* & distance” (0)
  handoff: none — a no-go on polygonal tilings

Rests on it: W-P1's generator image (recolourings of polygonal tilings), recorded as a G21 instance.

derivation: FS111-W-FILL-FREE
  statement: after a fill on B(x, η/2) at a j-free x, every new j-boundary point is j-free; so no finite sequence of fills creates a contact for the
    filled colour
  uses only: A_{η/2}(y) ⊂ A_η(x) for y ∈ B(x, η/2); the null intersection at x
  not claimed: that fills cannot reach a saturated colouring in the limit
  argument: FS111-W-wild.md § 2.6
  verdict: derived
  grade: derived from: FS111-C-FILL
  minds: 1 — FS111-W
  model: the hexagonal seven-colouring at an edge midpoint
  prior art: new — “chromatic & plane & (measurable | map) & (tight | saturat* | maximal)” (7), “unit distance & measurable & (boundary | regular*)” (1)
  handoff: none — a no-go for the procedural form of saturation

Rests on it: C-SAT-T's procedural form GAP; the ruling to run route M on covers.

derivation: FS111-W-HEX7-RIGID
  statement: in the tight hexagonal seven-colouring no local modification creates a junction or an island
  uses only: the free colours at each point of the hexagonal colouring (probed exactly at sampled points); a junction or island needs a colour free on
    an open set
  not claimed: the same for global modifications (every tight colouring is a global modification of every other at k ≥ 7)
  argument: FS111-W-wild.md § 2.5
  verdict: derived
  grade: hand
  minds: 1 — FS111-W (its free-colour map sampled exactly, ../tools/fs111_w_hex7_free.py)
  model: the hexagonal seven-colouring
  prior art: new — “chromatic & plane & (measurable | map) & (tight | saturat* | maximal)” (7), “unit distance & measurable & (boundary | regular*)” (1)
  handoff: none — a reading aid for REG-J's universal form

Rests on it: the verdict "REG-J's universal form: no wild object, and the reason named".

derivation: FS111-W-DECO-B
  statement: the tight hexagonal seven-colouring with two squares [1/2, 13/25] × [−1/50, 1/50] and its mirror added to every hexagon's class inside the
    neighbouring hexagons is tight and a.e.-proper, and no class has tight block structure; so REG-B's universal form is FALSE at k = 7
  uses only: exact distances in ℚ(√3): each class has a hexagon within distance < 1 of two squares at mutual distance exactly 1 with maxdist √677/25 > 1
  not claimed: REG-B's existence form (TRUE at k ≥ 7); anything at k ≤ 6
  argument: FS111-VMW-verification.md § 1.6
  verdict: derived
  grade: computed over: one period of the decorated hexagonal colouring (7 classes, 14 squares), exact in ℚ(√3)
  minds: 2 — blind to: W's record until VMW's verdicts were committed; method: two objects (VMW's squares at offsets 8/100–9/100, dmin √3/2 + 16/100),
    three engines agreeing on W's
  model: the decorated colouring itself
  prior art: new — “chromatic & plane & (measurable | map) & (tight | saturat* | maximal)” (7), “block structure | unit distance & avoid* & density” (6)
  handoff: none — a counterexample to a universal form; exact and periodic, formalizable on demand

Rests on it: the separation of REG-B's two forms; G21's rule that a `k = 7` object tests universal forms only.

control: FS111-W-DECO-B-EXACT
  of: FS111-W-DECO-B — the decorated colouring holds every assertion; an enlarged square breaks properness and the checker names it
  run: python3 ../tools/fs111_w_blocks.py 2>&1 | tail -1
  expect: => ALL HOLD
  fault: python3 ../tools/fs111_w_blocks.py --plant bigsq 2>&1 | tail -1

derivation: FS111-W-B-NONABS
  statement: B-NONABS: at a close complementary pair of junctions blocking toward a common unit point, a band-proper partial six-colouring with holes
    < δ near the forced point has the junctions' cone scale ≥ s₀(δ) > 0
  argument: FS111-W-wild.md § 3.3
  verdict: refuted: the fragment F_{s,ε} of FS111-W-wild.md § 3.3 — a complementary pair of scale s at x = (−1/2, 0), x′ = (1/2, 0), blocking toward
    w = (0, √3/2), with B(w, 1/10) coloured 1 or 4 off two annuli of width 2(ε + s); its holes near w are at most (8/√3)(ε + s)²(1 + o(1)), so for every
    δ and every s₀ a member has holes < δ and scale s < s₀; the content wanted is B-RR (a bound independent of δ)

Rests on it: nothing; the claim list's B-NONABS is corrected to B-RR (Drafts §D3).

derivation: FS111-W-HX-PAIRS
  statement: HX (the hexagonal seven-colouring with one class absorbed by straight triangles) carries complementary pairs of fat junctions in FS107-R-CP's
    sense at distance √7·R, blocking toward points that lie inside its voids
  uses only: the junction types of HX (exact); CP's definition; the positions of the voids at the stall parameters (float, with margins)
  not claimed: that CP's bound sizes HX's holes (it is eleven orders below the stall, ≈ 10⁻¹¹ against 0.0432)
  argument: FS111-W-wild.md § 3.4
  verdict: derived
  grade: computed over: HX at its stall parameters (R = 2/√21, ρ = R/2), floating point with stated margins, the junction types exact
  minds: 1 — FS111-W
  model: HX
  prior art: new — “distance & measurable & map & colo(u)ring” (0), “(cc:05C15 | cc:52C10) & plane & (measurable | regions | map) & distance” (17)
  handoff: none — a correction to FS-107's reading of HX; it enters no proof of a value

Rests on it: the dated erratum to `FS107-derivation.md` (HX-STALL's "K-C6 vacuous" counts only hole components).

derivation: FS111-W-SEA-PACK
  statement: the sea–island design on the hexagonal tiling (no complementary pair at any scale) admits no size with single-hexagon sea pieces
  uses only: the design's constraints on sea pieces at distance 1 from islands; a packing count
  not claimed: that no complementary-free family with vanishing holes exists (R-P3 is a bet on six, FS111-W-NEG)
  argument: FS111-W-wild.md § 3.5
  verdict: derived
  grade: hand
  minds: 1 — FS111-W
  model: the hexagonal tiling with any sea/island assignment
  prior art: new — “distance & measurable & map & colo(u)ring” (0), “(cc:05C15 | cc:52C10) & plane & (measurable | regions | map) & distance” (17)
  handoff: none — where one design stalls; it enters no proof of a value

Rests on it: nothing downstream; FS-122's record of what the wild side of route R met.

## Round 2 — the rungs on maximal covers (FS111-M2; FS111-VM2 blind)

*A **MUA set** is a maximal unit-avoiding set: measurable, with null unit pairs, maximal under inclusion up to null sets. **Regular**: `A = F` a.e.
and `|∂F| = 0`, `F = supp A`. VM2 derived before opening M2's record (committed `00fd646f`), sighted of rounds 0–1.*

derivation: FS111-M2-COV
  statement: a k-tuple of measurable sets is a maximal admissible cover iff each coordinate is a MUA set and their union has full measure
  uses only: the definitions; maximality of a cover is maximality of each coordinate separately, since enlarging one class never touches another's
    unit pairs
  not claimed: that a maximal cover's classes are regular (FS111-M3-IRREG) or disjoint (DISC7 has lenses)
  converse: FS111-M2-regularity.md § 1.4
  argument: FS111-M2-regularity.md § 1.4
  verdict: derived
  grade: hand
  minds: 1 — FS111-M2
  model: k = 7: R7 (a partition); DISC7 (with overlaps)
  prior art: new — “unit distance & maximal & measurable” (1), “distance & measurable & maximal independent” (0)
  handoff: de Bruijn — queued behind the measurable chain, with FS111-M-SATC

Rests on it: every regularity rung on covers is a statement about one MUA set; the colour count enters only through "the union is full" and the
selection (G24's rule, met); FS111-M2-REDUCE-C.

derivation: FS111-M2-ZERO
  statement: a measurable A is a MUA set iff A = {φ_A = 0} a.e., where φ_A(p) = σ{w ∈ S¹ : p + w ∈ A}: unit-avoiding is φ_A = 0 a.e. on A, maximal
    is φ_A > 0 a.e. off A (a measurable independent dominating set of the unit-distance graph)
  uses only: Fubini on Leb ⊗ σ; maximality tested one point-neighbourhood at a time
  not claimed: that {φ_A = 0} is closed or regular
  converse: FS111-M2-regularity.md § 1.4
  argument: FS111-M2-regularity.md § 1.4
  verdict: derived
  grade: hand
  minds: 1 — FS111-M2
  model: each class of R7
  prior art: partly: a partition into such sets is a fall colouring (Dunbar et al. 2000, Zbl 0962.05020, finite graphs; held under FS-67); the
    measurable form not found — “independent dominating & (measurable | Borel)” (0), “fall coloring & infinite” (2)
  handoff: de Bruijn — queued behind the measurable chain

Rests on it: the reading of a maximal partition as a measurable fall colouring (FS111-M2-SELCOMP (d)); G84.

derivation: FS111-M2-INT
  statement: for every a.e. unit-avoiding A, the topological interior of its density set, int Ã, contains no point at distance exactly 1 from cl Ã
  uses only: FS111-V0-ID1 (I-D1); full-density discs about interior points
  not claimed: the same for the interior of the support F of a set with null unit pairs (a GAP under the topological reading of "regular", VM2 (O2))
  argument: FS111-M2-regularity.md § 1.5
  verdict: derived
  grade: derived from: FS111-V0-ID1
  minds: 2 — blind to: M2's record until VM2's verdicts were committed (00fd646f); method: VM2-INT by the r³ measure of unit pairs between full discs
  model: R7's classes
  prior art: new — “unit distance & maximal & measurable” (1), “one-avoiding | 1-avoiding” (47)
  handoff: de Bruijn — queued behind the measurable chain

Rests on it: FS111-M2-FIX; FS111-M2-REDUCE-C (VM2-FACE step 6).

derivation: FS111-M2-FIX
  statement: a regular MUA set A satisfies the shadow identity int F = ℝ² ∖ (F + S¹), F = supp A: every unit circle centred in F misses int F, and every
    component of int F lies inside or outside each such circle
  uses only: FS111-M2-INT (no interior point on a unit circle about F); FS111-M2-ZERO (maximality: almost every point off A has φ_A > 0); regularity
    (|∂F| = 0) to pass from a.e. to every point
  not claimed: the converse (a regular set satisfying the identity need not be maximal: FS111-M3-FIXCONV)
  argument: FS111-M2-regularity.md § 1.5
  verdict: derived
  grade: derived from: FS111-M2-INT, FS111-M2-ZERO
  minds: 2 — blind to: M2's record until VM2's verdicts were committed; method: VM2 from VM2-INT and maximality (VM2 § 2.2)
  model: R7's classes; DISC7's classes
  prior art: new — “unit distance & maximal & measurable” (1), “distance & measurable & maximal independent” (0)
  handoff: de Bruijn — queued behind the measurable chain: the identity route M's cover form rests on

Rests on it: FS111-M2-HULLC; FS111-M4-CUT's upward half ((F1)); FS111-M3-HC's maximality check; G84 ("a maximal class is a fixed point of its own unit
shadow").

derivation: FS111-M2-DISC7
  statement: the circumscribed discs of the tight hexagonal seven-colouring (radius 1/2, centred at the hexagon centres, coloured as the hexagons) form
    a maximal admissible seven-cover with regular classes whose overlaps (lenses) have positive measure; each class has density 2π/(21√3), the seven
    summing to Kershner's thinnest-covering density 2π/(3√3)
  uses only: the discs pass through the hexagon vertices (cover); same-colour centres √21/2 apart (admissible); for 1/2 < |z − c| < 3/2 the circle T₁(z)
    crosses the disc (maximal); exact rational bounds
  not claimed: that its selections are saturated (FS111-M2-NOSEL); curvature of class boundaries ≤ 1 (it is 2)
  argument: FS111-M2-regularity.md § 1.6
  verdict: derived
  grade: computed over: one period of the hexagonal lattice, 7 discs, exact rational bounds in ℚ(√3)
  minds: 2 — blind to: M2's record until VM2's verdicts were committed; method: M2 by hand and a 2,173-point exact grid, VM2 by exact bounds at every
    point (VM2-DISC7-EXACT)
  model: DISC7 itself
  prior art: partly: the density is [Kershner1939]'s (Zbl 0021.11401); the object as a maximal unit-avoiding cover not found — “constant width & cover* &
    (unit distance | chromatic)” (1)
  handoff: none — a control object; exact and periodic, formalizable on demand

Rests on it: FS111-M2-EXTREME-C, FS111-M2-NOSEL, the semiconvexity no-go in FS111-M2-HULLC; VM2-FACE's inhabitant (every vertex of degree 3 for
all 8 lens choices).

control: FS111-M2-DISC7-EXACT
  of: FS111-M2-DISC7 — the exact checks pass on the discs and fail when the classes are the four cosets of 2Λ
  run: python3 ../tools/fs111_vm2_disc7.py --object disc7 2>&1 | tail -1
  expect: ALL PASS (plant = None)
  fault: python3 ../tools/fs111_vm2_disc7.py --object disc7 --plant lat4 2>&1 | tail -1

derivation: FS111-M2-HULLC
  statement: in a maximal cover with regular classes, every component of int F_j lies inside or outside every unit circle centred at a point of F_j and
    has an exterior ball of radius 1 at every boundary point; where the boundary is a graph it is semiconcave with constant 1; each component has finite
    perimeter; near any point int F ∩ B(x, r) = B(x, r) ∖ ⋃_{p ∈ F_x} T₁(p), and where F_x has finitely many components the boundary lies on the unit
    parallels (outer and far) of the class's own components; on the pinch set of two classes FS111-M-PINCH and FS111-M-C11 hold verbatim
  uses only: FS111-M2-FIX; FS111-C-HULL's first clause; a classical finite-perimeter criterion for exterior-ball sets (Federer GMT 4.5.11, cited unread)
  not claimed: semiconvexity with constant 1 (FALSE: DISC7, curvature 2); the unit-parallel description without "F_x has finitely many components"
  argument: FS111-M2-regularity.md § 2.1
  verdict: derived
  grade: derived from: FS111-M2-FIX, FS111-C-HULL
  minds: 2 — blind to: M2's record until VM2's verdicts were committed; method: VM2-HULLC (exterior radius 1 per component; M2 used 1/2 for the
    perimeter argument); VM2 restored the dropped hypothesis of (iv)
  model: R7; DISC7; SQ9 at nine
  prior art: partly: exterior-ball and positive-reach boundaries in the plane ([RatajZajicek2025] §1, [RatajZajicek2017] Thm 6.4's statement read); the
    carving by a class's own unit circles not found — “unit distance & measurable & (boundary | regular*)” (1)
  handoff: de Bruijn — queued behind the measurable chain; the finite-perimeter step needs Federer 4.5.11 or a Mathlib substitute

Rests on it: G84; FS111-M4-LADDER (every ordinary interface of a regular maximal partition has partners along the normal); the ruling that route M's
first rung is free on covers.

derivation: FS111-M2-EXTREME-C
  statement: FS111-M-EXTREME is false on maximal covers: DISC7's class components (discs) have no singular point
  uses only: FS111-M2-DISC7
  not claimed: anything about honest colourings (FS111-M-EXTREME holds there)
  argument: FS111-M2-regularity.md § 2.2
  verdict: derived
  grade: derived from: FS111-M2-DISC7
  minds: 1 — FS111-M2 (the object checked exactly by VM2)
  model: DISC7
  prior art: new — “unit distance & maximal & measurable” (1), “constant width & cover* & (unit distance | chromatic)” (1)
  handoff: none — a scope marker between honest colourings and covers

Rests on it: the scope of FS111-M-EXTREME.

derivation: FS111-M2-SELCOMP
  statement: in a saturated colouring, for every unit-avoiding enlargement A of a class, no interface point of the class lies in int Ã, so the class is
    null or full on each component of int Ã; from a regular maximal cover a saturated selection is a choice of whole components forming a partition; if
    every component has an exclusive point, a saturated selection exists only if the cover is a partition; a regular maximal partition (a measurable
    fall colouring) is saturated
  uses only: FS111-M2-INT; saturation at interface points; Federer 4.5.11 (cited unread) for the component structure
  not claimed: the broader wording "no interface point lies in int Ã" without "of the class" (FALSE by a degenerate example, VM2 D8)
  argument: FS111-M2-regularity.md § 3.1
  verdict: derived
  grade: derived from: FS111-M2-INT
  minds: 2 — blind to: M2's record until VM2's verdicts were committed; method: VM2-SEL by the same contact argument, reached independently
  model: R7 (a regular maximal partition, saturated)
  prior art: new — “fall coloring & infinite” (2), “independent dominating & (measurable | Borel)” (0)
  handoff: none — decides which statement to attempt (selection is not a colour-generic route); it enters no proof of a value

Rests on it: FS111-M2-NOSEL; the verdict "the selection at five is not a route to honest saturation"; FS111-M4-LADDER's hypothesis (every regular
maximal partition is saturated).

derivation: FS111-M2-NOSEL
  statement: DISC7 has no saturated selection: the lens between two discs of different colours blocks every choice of whole components
  uses only: FS111-M2-SELCOMP; every disc centre of DISC7 is exclusive; DISC7 is not a partition
  not claimed: that no saturated seven-colouring exists (FALSE: R7)
  argument: FS111-M2-regularity.md § 3.1
  verdict: derived
  grade: derived from: FS111-M2-SELCOMP, FS111-M2-DISC7
  minds: 2 — blind to: M2's record until VM2's verdicts were committed; method: VM2 by exact bounds (and for DISCK7 too)
  model: DISC7
  prior art: new — “fall coloring & infinite” (2), “unit distance & maximal & measurable” (1)
  handoff: none — a no-go for a route; it enters no proof

Rests on it: the retirement of the "honest saturation at 5, 6" stub as a route by selection; FS-121's honest route needs a global re-choice.

derivation: FS111-M2-REDUCE-C
  statement: if some maximal k-cover has regular classes whose boundaries form a locally finite plane graph (finitely many Jordan arcs in each bounded
    set, meeting only at endpoints: REG-J′-C_k), then REG-I_k holds; at k = 5, with FS106-AE-MAP6, χ_m⁰(ℝ²) ≥ 6, hence χ(ℝ²) ≥ 6 given MR
  uses only: faces of the arrangement coloured by a class whose interior contains them (VM2-FACE steps 1–6); merged points lie in int F_j; the island
    fill; FS111-M2-INT and FS111-V0-CLOSE for D-AEMAP; FS111-V0-RESCALE; FS106-AE-MAP6 at its grade (one mind per link, the fill in outline)
  not claimed: REG-J′-C₅ itself; the statement with "a finite union of Jordan arcs" in place of "meeting only at endpoints" (M2 §2.3's wording,
    MISSTATED); that it makes the five-colour question smaller (FS111-VM2-EQ5)
  argument: FS111-M2-regularity.md § 3.2
  verdict: derived
  grade: derived from: FS111-M2-INT, FS111-V0-CLOSE, FS111-V0-RESCALE
  minds: 2 — blind to: M2's record until VM2's verdicts were committed; method: VM2-FACE, step by step, adding the island fill and the merged points
  model: k = 7: DISC7 (merged into a curved hexagonal map, every vertex of degree 3) and R7
  prior art: new — “distance & measurable & map & colo(u)ring” (0), “unit distance & maximal & measurable” (1)
  handoff: de Bruijn — queued behind the measurable chain and FS106-AE-MAP6's formalization (Townsend's (c), FS-108)

Rests on it: FS111-VM2-EQ5; the ruling that REDUCE-C is a reformulation (item 31); FS-121's five-colour section.

derivation: FS111-VM2-EQ5
  statement: given FS106-AE-MAP6, the conditional statement "if a tight a.e.-proper five-colouring exists, some maximal five-cover has regular classes
    whose boundaries form a locally finite plane graph" holds iff χ_m⁰(ℝ²) ≥ 6
  uses only: FS111-M2-REDUCE-C (⟹); vacuity (⟸: with six, no tight five-colouring exists)
  not claimed: that the regularity statement is smaller than the answer (it is the answer restated; its gain is its form: a maximal cover is free by
    Zorn, and no honest saturation is needed)
  converse: FS111-VM2-verification.md § 1.4
  argument: FS111-VM2-verification.md § 1.4
  verdict: derived
  grade: derived from: FS111-M2-REDUCE-C
  minds: 2 — blind to: M2's record until VM2's verdicts were committed; method: M2 states it (§ 2.3, § 3.2), VM2 derives it as (O1)
  model: premises open; the statement is the caution
  prior art: new — “distance & measurable & map & colo(u)ring” (0), “chromatic & plane & (measurable | map) & (tight | saturat* | maximal)” (7)
  handoff: none — a caution about strength; it enters no proof

Rests on it: every sentence about REDUCE-C in the front-page drafts (a reformulation, never progress toward six by itself).

derivation: FS111-M2-INTRAD
  statement: in an honest saturated colouring whose singular set Σ is locally finite with finitely many interface arcs at each point (REG-J′), the unit
    parallel of every tangent-type interface arc is again an interface arc, so radii of curvature drop by exactly 1 toward the centre and stop at 1:
    every interface has integer radius of curvature almost everywhere and is locally a chain of segments and circular arcs, finitely many of each
    radius
  uses only: FS111-M-C11 off Σ; (i) the near side of the parallel has density 0 for the partner colour (M2 from I-D1 and (H2); VM2 from M-HULL1);
    (ii) the parallel is an interface; (iii) finiteness per radius by VM2-FIN′ (the n-th inner parallel carries each gap to an interface curve
    starting at one of finitely many centres in Σ; REG-J′'s second clause bounds the gaps)
  not claimed: exclusion of large-radius accumulation (radii → ∞: LRA, FS-115's stuck ray); the statement without REG-J′'s finitely-many-arcs clause
  argument: FS111-M2-regularity.md § 4.1
  verdict: derived
  grade: derived from: FS111-M-C11
  minds: 2 — blind to: M2's record until VM2's verdicts were committed; method: (i)–(ii) by two routes; (iii) completed by VM2 alone (VM2-FIN′, one
    mind), M2's convexity outline having a gap on E_n ∖ E_{n,p}
  model: SQ9, HEX9, R7 and row 136's strip (VM2-LAD-CTL, exact: every edge-side carries its ladder, every arc of kind both has radius 1)
  prior art: new — “parallel curve* & unit distance” (0), “chromatic & plane & (measurable | map) & (tight | saturat* | maximal)” (7)
  handoff: de Bruijn — queued behind FS111-M-PINCH and FS111-M-C11: the link between route M and FS-115

Rests on it: FS111-M2-REDUCE-A; G85; the link FS-121 ↔ FS-115 (the top rung at six needs ¬LRA, which is the stuck ray in another form).

derivation: FS111-M2-REDUCE-A
  statement: REG-A_k follows from REG-J′_k together with the absence of large-radius accumulation (¬LRA), in an honest saturated k-colouring; at six,
    with Q-NO, χ_m⁰(ℝ²) ≥ 7
  uses only: FS111-M2-INTRAD; FS111-M-REDUCE-I; FS111-C-SEVEN-M at six
  not claimed: REG-J′₆; ¬LRA; honest saturation at six; Q-NO
  argument: FS111-M2-regularity.md § 4.1
  verdict: derived
  grade: derived from: FS111-M2-INTRAD, FS111-M-REDUCE-I, FS111-C-SEVEN-M
  minds: 2 — blind to: M2's record until VM2's verdicts were committed; method: VM2 noticed the C-SAT-T conjunct is implied by REG-J′'s saturated
    hypothesis and dropped it
  model: k = 7: R7 (REG-J′ holds, no LRA, and it is a segment-and-arc map)
  prior art: new — “distance & measurable & map & colo(u)ring” (0), “parallel curve* & unit distance” (0)
  handoff: none — a reduction between open statements; it crosses with them

Rests on it: FS-121's honest route at six.

derivation: FS111-M2-DISCK7
  statement: translates of the smooth non-circular body K of constant width 1 with support function 1/2 + sin³(3θ)/200, placed at the colour lattices
    of the hexagonal seven-colouring oriented so that the hexagons' vertices lie in the directions where sin 3θ = 0, form a regular maximal seven-cover
    with a locally finite arrangement; so the cover form of REG-A is FALSE at seven, and on the cover route the NO at six must cover self-parallel curved
    boundaries (NO-PAR)
  uses only: constant width 1 (identically); radius of curvature in [37/100, 63/100]; K passes through every hexagon vertex in this orientation;
    same-colour bodies more than 1 apart; every point within 1 of every colour (maximal); exact arithmetic (sympy and rationals)
  not claimed: the same at M2 §1.6's lattice with vertices at 30° + 60k (FALSE: FS111-M2-DISCK7-AS-PLACED)
  argument: FS111-VM2-verification.md § 1.3
  verdict: derived
  grade: computed over: one period of the hexagonal lattice, 7 bodies, exact (sympy and rational bounds)
  minds: 2 — blind to: M2's record until VM2's verdicts were committed; method: M2's hand argument and body checks, VM2's exact rebuild in the corrected
    orientation
  model: the corrected DISCK7 itself
  prior art: partly: bodies of constant width and coverings are classical; this cover not found — “constant width & cover* & (unit distance |
    chromatic)” (1)
  handoff: none — a counterexample to a universal form; exact and periodic, formalizable on demand

Rests on it: NO-PAR's place in FS-121 (the cover route at six needs a NO larger than Q-NO).

control: FS111-M2-DISCK7-ORIENT
  of: FS111-M2-DISCK7 — the checks pass in the corrected orientation and fail at the record's lattice (vertices at 30° + 60k), where a tiling vertex is
    uncovered
  run: python3 ../tools/fs111_vm2_disc7.py 2>&1 | tail -1
  expect: ALL PASS (plant = None)
  fault: python3 ../tools/fs111_vm2_disc7.py --object disck7-m2 2>&1 | tail -1

derivation: FS111-M2-DISCK7-AS-PLACED
  statement: M2's DISCK7 as its record places it — K at the hexagonal seven-colouring's centres m(√3/2, 0) + n(√3/4, 3/4) — is a regular maximal
    seven-cover
  argument: FS111-VM2-verification.md § 2.3
  verdict: refuted: at that lattice the hexagon vertices lie at 30° + 60k, where h = 99/200 < 1/2 in each of the three adjacent directions, so the tiling
    vertex c + (0, 1/2) lies outside all three adjacent copies and at distance ≥ 1 from every other centre: not a cover (exact, VM2-DISCK7-ORIENT)

Rests on it: nothing; the corrected form is FS111-M2-DISCK7. M2's own tool (`../tools/fs111_m2_disck7.py`) built the other orientation, so its PASS
was about another object — a G21 instance (Drafts §D4 of `FS111-C-close.md`).

derivation: FS111-M2-KERSHNER
  statement: no admissible five-cover has classes that are unions of discs of radius 1/2: such a class has density at most π/(8√3), and five fall
    below the thinnest-covering density 2π/(3√3)
  uses only: [Kershner1939]'s thinnest covering of the plane by equal discs; the hexagonal packing bound for equal discs of radius 1 (same-colour discs
    of radius 1/2 must be at distance ≥ 2 centre to centre)
  not claimed: anything about discs of other radii
  argument: FS111-M2-regularity.md § 1.6
  verdict: derived
  grade: hand
  minds: 1 — FS111-M2
  model: DISC7 at seven (seven classes reach the covering density exactly)
  prior art: partly: [Kershner1939] and Fejes Tóth's packing bound (both cited, unread here); the corollary for five-covers not found
  handoff: none — a no-go for disc-shaped classes at five; it enters no proof of a value

Rests on it: nothing downstream; a calibration of DISC7.

derivation: FS111-VM2-STRIP-MID
  statement: the strip of `LEDGER.md` row 136 is tight but not saturated on its midline: at the midpoint of every edge A_j | B_j both side colours are
    free (no tile of either colour at distance exactly 1)
  uses only: the strip's tiles rebuilt from row 136's construction; exact distances
  not claimed: that no saturated six-coloured strip exists
  argument: FS111-VM2-verification.md § 1.3
  verdict: derived
  grade: computed over: the strip's tiles over one period, exact in ℚ(√3, √15)
  minds: 1 — FS111-VM2
  model: the strip itself
  prior art: partly: the strip is [AxenovichEtAl2014] Thm 4.2's; its saturation not considered in print
  handoff: none — a property of a control object

Rests on it: the scope of row 136's positives as controls for route M (tight, not saturated).

## Rounds 3–4 — the finiteness rung (FS111-M3; FS111-M4). No verifier ran: one mind each.

derivation: FS111-M3-VAC
  statement: M2-PINCH-C's hypothesis is unsatisfiable: no regular MUA set contains its two blocks P ∪ P′ and has every point within 11/10 of W in P ∪ P′ ∪ W
  uses only: a point just beside W inside the lens band is neither in F nor on a unit circle about F, against FS111-M2-FIX
  not claimed: that no regular MUA set has a Cantor pinch (FALSE: FS111-M3-HC)
  argument: FS111-M3-finiteness.md § 1.4
  verdict: derived
  grade: derived from: FS111-M2-FIX
  minds: 1 — FS111-M3
  model: the configuration's own blocks (the hypothesis fails at the named point)
  prior art: new — “unit distance & maximal & measurable” (1), “one-avoiding | 1-avoiding” (47)
  handoff: none — a correction to a lemma's hypothesis

Rests on it: the corrected M2-PINCH-C (FS111-M3-FIN-U).

derivation: FS111-M3-HC
  statement: the honeycomb class HC — equilateral triangles of side 1 at the vertices of a honeycomb of edge 2 + √3/3, pointing at the face centres; on
    each edge a band of length 1 at distance 1 from both facing sides, of thickness in [0, g] vanishing exactly on a closed null set Z ∋ ±1/2; discs of
    radius 1/2 at the face centres — is a regular MUA set satisfying FS111-M2-FIX, for every gap function with (G1)'s bounds; with Z a Cantor set
    (HC_K) each band has one interior component per gap
  uses only: FS111-M3-BAND (a flat side needs its class at distance exactly 1 over its middle half; a band of length 1 excludes its horns); exact checks
    in ℚ(√3) of unit-avoidance and maximality at the finitely many critical configurations
  not claimed: that HC_K is a class of any partition (FS111-M4-HC: it fits none with an ordinary ladder through three rungs); any colour count
  argument: FS111-M3-finiteness.md § 2.1
  verdict: derived
  grade: computed over: the critical configurations of one period of the honeycomb, exact in ℚ(√3), with the hand reduction to them
  minds: 1 — FS111-M3 (../tools/fs111_m3_honey.py: six checks, five plants firing)
  model: HC with Z = {±1/2} (HC₀, locally finite); HC_K
  prior art: new — “unit distance & maximal & measurable” (1), “one-avoiding | 1-avoiding” (47)
  handoff: none — a counterexample to a universal form; exact, formalizable on demand

Rests on it: FS111-M3-FIN-U; FS111-M3-D3; FS111-M3-MOVE; FS111-M3-IRREG; FS111-M4-HC; G84 ("a maximal class is as wild as its bands' zero sets").

derivation: FS111-M3-FIN-U
  statement: some regular MUA set has infinitely many interior components in a bounded set (HC_K: infinitely many in every disc of radius 3 about a
    face centre); so "every regular MUA set is locally finite" (MUA-FIN-U) is false, and M2-PINCH-C, corrected to "some regular MUA set contains a Cantor
    pinch", holds
  uses only: FS111-M3-HC with Z a Cantor set
  not claimed: that a maximal cover or partition containing HC_K exists
  argument: FS111-M3-finiteness.md § 2.6
  verdict: derived
  grade: derived from: FS111-M3-HC
  minds: 1 — FS111-M3
  model: HC_K
  prior art: new — “unit distance & maximal & measurable” (1), “one-avoiding | 1-avoiding” (47)
  handoff: none — a no-go for a universal form

Rests on it: MUA-FIN-P's framing (finiteness must come from a move, not class by class); FS-120.

derivation: FS111-M3-D3
  statement: HC_K satisfies MUA-FIN in M2's words (each band's boundary is two Jordan arcs) and fails it with VM2's clause "meeting only at endpoints"
    (the two arcs meet on the infinite set Z × {1})
  uses only: FS111-M3-HC
  not claimed: that either form holds for some maximal five-cover
  argument: FS111-M3-finiteness.md § 2.6
  verdict: derived
  grade: derived from: FS111-M3-HC
  minds: 1 — FS111-M3
  model: HC_K
  prior art: new — “unit distance & maximal & measurable” (1), “one-avoiding | 1-avoiding” (47)
  handoff: none — separates two wordings on a real object

Rests on it: the claim-list correction to MUA-FIN (the clause is what separates a plane graph from a union of arcs).

derivation: FS111-M3-MOVE
  statement: HC-type pinches are removed by arbitrarily small moves of the class alone: g_τ = (1 − τ)g_K + τg₀ gives a regular MUA set with one component
    per band, locally finite with D3's clause, differing from HC_K by a lost sliver L_τ along each up side (|L_τ| = O(τ)) and a band thickening; HC_K is the
    L¹_loc- and Hausdorff-limit of locally finite regular MUA sets
  uses only: FS111-M3-HC for every admissible gap function; convexity of the band constraints in g
  not claimed: that the move keeps a maximal cover or partition (FS111-M3-COVER; FS111-M4-MOVE)
  argument: FS111-M3-finiteness.md § 3.2
  verdict: derived
  grade: derived from: FS111-M3-HC
  minds: 1 — FS111-M3 (exact checks by ../tools/fs111_m3_honey.py)
  model: HC_K and g_τ at τ = 1/2
  prior art: new — “unit distance & maximal & measurable” (1), “one-avoiding | 1-avoiding” (47)
  handoff: none — a move whose effect in partitions is FS-120's question

Rests on it: MUA-FIN-P's one-class verdict (TRUE); FS111-M3-COVER; FS111-M4-MOVE.

derivation: FS111-M3-COVER
  statement: in a regular maximal cover containing HC_K, the move of FS111-M3-MOVE keeps a maximal cover iff the lost sliver is covered by the other
    classes
  uses only: FS111-M3-MOVE; FS111-M2-COV
  not claimed: that the sliver is covered in any given cover
  converse: FS111-M3-finiteness.md § 3.3
  argument: FS111-M3-finiteness.md § 3.3
  verdict: derived
  grade: derived from: FS111-M3-MOVE, FS111-M2-COV
  minds: 1 — FS111-M3
  model: HC_K inside a cover whose other classes cover a neighbourhood of the up sides
  prior art: new — “unit distance & maximal & measurable” (1), “one-avoiding | 1-avoiding” (47)
  handoff: none — a criterion for covers

Rests on it: MUA-FIN-P's cover verdict.

derivation: FS111-M3-CASCADE
  statement: in a regular maximal partition, a change that removes a positive-measure set from one class makes some other class gain, and every gaining
    class b loses all its old material F_b ∩ {φ_{G_b} > 0}, of positive measure
  uses only: FS111-M2-ZERO; FS111-M2-COV; a partition covers the plane
  not claimed: that the cascade closes up, or that it runs forever (FS111-M4-MOVE: along the ladder, ending at the singular set)
  argument: FS111-M3-finiteness.md § 3.3
  verdict: derived
  grade: derived from: FS111-M2-ZERO, FS111-M2-COV
  minds: 1 — FS111-M3
  model: R7 (any change of one class)
  prior art: new — “fall coloring & infinite” (2), “independent dominating & (measurable | Borel)” (0)
  handoff: none — the named obstruction to MUA-FIN-L in partitions

Rests on it: FS111-M4-MOVE (which makes it the ladder); FS-120's question.

derivation: FS111-M3-IRREG
  statement: with a fat Cantor set Z_f, A_f = int HC(g_f) is unit-avoiding, regular and satisfies the shadow identity, but is not maximal, and every MUA
    set containing it has |∂ supp| > 0; so "every MUA set is regular" (MUA-REG-U) is false
  uses only: a pinch set of positive length makes a positive-measure set of points whose unit circles touch the class only at pinch points (excluded in
    closure, free in measure); maximality must add them, and they form a nowhere dense set
  not claimed: that no maximal cover can be modified into one with regular classes (MUA-REG-P is open)
  argument: FS111-M3-finiteness.md § 4.2
  verdict: derived
  grade: hand
  minds: 1 — FS111-M3
  model: HC with a Smith–Volterra–Cantor Z_f
  prior art: new — “unit distance & maximal & measurable” (1), “unit distance & measurable & (boundary | regular*)” (1)
  handoff: none — a no-go for a universal form

Rests on it: FS111-M3-FIXCONV; M4's reading "irregularity is the only junction-free escape"; FS-120's second question ((F1) for irregular MUA sets).

derivation: FS111-M3-FIXCONV
  statement: the converse of FS111-M2-FIX fails: F_f is regular with int F = ℝ² ∖ (F + S¹) and its interior is not maximal
  uses only: FS111-M3-IRREG's A_f
  not claimed: anything about maximal sets
  argument: FS111-M3-finiteness.md § 4.1
  verdict: derived
  grade: derived from: FS111-M3-IRREG
  minds: 1 — FS111-M3
  model: F_f
  prior art: new — “unit distance & maximal & measurable” (1), “one-avoiding | 1-avoiding” (47)
  handoff: none — a scope marker for FS111-M2-FIX

Rests on it: the one-way wording of FS111-M2-FIX.

derivation: FS111-M3-BAND
  statement: a flat side of a block of diameter ≤ 1 in a MUA set needs material of its class at distance exactly 1 over the middle half of the side; a
    band of length λ excludes its own horns out to λ and is unit-free only if λ ≤ 1; a side of length 1 with its band at distance 1 is excluded exactly by
    an apex at depth √3/2, tight at one point
  uses only: FS111-M2-FIX's shadow identity at points facing the side; elementary distances
  not claimed: anything about curved sides (constant-width blocks carry no band)
  argument: FS111-M3-finiteness.md § 1.5
  verdict: derived
  grade: derived from: FS111-M2-FIX
  minds: 1 — FS111-M3
  model: HC's up triangles and bands
  prior art: new — “unit distance & maximal & measurable” (1), “one-avoiding | 1-avoiding” (47)
  handoff: none — design facts for HC

Rests on it: FS111-M3-HC; G84's clause on bands.

derivation: FS111-M4-LADDER
  statement: in a saturated colouring (every regular maximal partition), a layer of class a over an interval, flat below (class b) and bounded above by
    a graph β ≥ 0 (class c) vanishing exactly on a closed set Z with empty interior, with ordinary interfaces near the four unit-parallel curves: every
    interface point is of FS111-M-PINCH's tangent type with its contacts one unit along the normal; the regions W⁺ and W⁻ are a-free, vanish exactly on
    Z, and carry b along W⁺'s flat side and c along W⁻'s curved side; so b and c are pinched on the same Z (one interior component per gap)
  uses only: FS111-M-PINCH; FS111-M-C11; FS111-M2-SELCOMP (a regular maximal partition is saturated); the ordinariness hypotheses (R), (A), (B)
  not claimed: that the ladder continues without end (FS111-M4-CUT); that a partition containing HC_K exists
  argument: FS111-M4-cascade.md § 2.1
  verdict: derived
  grade: derived from: FS111-M-PINCH, FS111-M-C11, FS111-M2-SELCOMP
  minds: 1 — FS111-M4
  model: SQ9 (unpinched: every flat edge's ladder); no pinched inhabitant is held
  prior art: new — “parallel curve* & unit distance” (0), “fall coloring & infinite” (2)
  handoff: none — a lemma of FS-120's question; it crosses with FS-120's result

Rests on it: FS111-M4-CUT; FS111-M4-MOVE; G84's ladder clause.

derivation: FS111-M4-CUT
  statement: in a regular maximal partition, the ladder of rungs over a gap is ordinary for n rungs upward only if β(u) ≤ n − (n² − (u − z)²)^{1/2}
    (u ∈ I, z ∈ Z), so n ≤ 1/(2c) at a gap end where β ≥ c(u − z)²; and, when "ordinary" includes (R)'s lower half, downward only if the region under β is
    a union of open n-discs, so a gap of width w and height h needs h ≤ n − (n² − w²/4)^{1/2} (≈ w²/(8n))
  uses only: upward, FS111-M2-FIX's (F1) at each rung; downward, the hypothesis that ordinary includes (R)'s lower half (unit-disc rolling from below)
  not claimed: the downward bound without that hypothesis (its first proof derived the inequality from (F1), wrongly, and was corrected before the report)
  argument: FS111-M4-cascade.md § 3.1
  verdict: derived
  grade: derived from: FS111-M4-LADDER, FS111-M2-FIX
  minds: 1 — FS111-M4
  model: HC_K's first gap (the bound is met within three rungs, FS111-M4-HC)
  prior art: partly: closing and opening by discs (Matheron, Serra; classical, not held, not read) is the identity the downward half uses; the ladder
    bound not found — “parallel curve* & unit distance” (0), “rolling ball & (C^{1,1} | curvature)” (8)
  handoff: none — a lemma of FS-120's question

Rests on it: FS111-M4-MOVE's third part; the reading that a pinch brings a junction (or an irregular class) within a bounded number of rungs.

derivation: FS111-M4-HC
  statement: HC_K lies in no regular maximal partition whose ladder over the band's first gap is ordinary through three rungs up or down (rung ±4 lands
    inside a face-centre disc of the class itself), whatever the gap function; and HC's discs (curvature 2) have no ordinary boundary point in any
    saturated colouring
  uses only: HC's skeleton (the collision uses only it); FS111-M-C11 (curvature ≤ 1 at ordinary points); exact positions in ℚ(√3)
  not claimed: that no partition contains HC_K
  argument: FS111-M4-cascade.md § 3.4
  verdict: derived
  grade: computed over: the skeleton of one period of HC and rungs ±1 to ±4 over the first gap, exact in ℚ(√3)
  minds: 1 — FS111-M4 (../tools/fs111_m4_rungs.py: four checks, four plants)
  model: HC_K
  prior art: new — “parallel curve* & unit distance” (0), “unit distance & maximal & measurable” (1)
  handoff: none — a no-go on one object

Rests on it: the verdict "no partition with an HC-type class built"; FS-120's first question (a pinched class that fits a partition).

derivation: FS111-M4-MOVE
  statement: if two regular maximal partitions agree outside the ladder region of a gap J and differ there by replacing β with β′ ≠ β, both ordinary
    through rungs −N, …, N over J, then the classes at every rung are the same in both (no spare colour enters, at any k; M3-MOVE's lost sliver is absorbed
    by the class under the band), every downward rung's curved side moves, and the cascade runs one rung per step, ending only where the ladder stops
    being ordinary
  uses only: FS111-M4-LADDER (3); FS111-M4-CUT (2) for the downward rungs, with its hypothesis
  not claimed: what happens where the ladder ends (the singular set: GAP, FS111-MUA-FIN-L); that a spare colour is never needed at a junction
  argument: FS111-M4-cascade.md § 4.1
  verdict: derived
  grade: derived from: FS111-M4-LADDER, FS111-M4-CUT
  minds: 1 — FS111-M4
  model: HC_K → g_τ (FS111-M3-MOVE) in two partitions ordinary through the same rungs (hypothetical: no such partition is held)
  prior art: new — “parallel curve* & unit distance” (0), “fall coloring & infinite” (2)
  handoff: none — a lemma of FS-120's question

Rests on it: the retirement of M3's spare-colour reading in partitions; FS-120.

## The named gaps (the open steps the milestone ends at)

derivation: FS111-C-SAT-T-HONEST
  statement: every tight a.e.-proper k-colouring can be modified, keeping it a.e.-proper with k colours, into an honest (one colour per point) saturated
    one, at k = 5 and k = 6
  argument: FS111-M-regularity.md § 2.6
  verdict: gap: from a maximal cover (free, FS111-M-SATC) to an honest colouring bound on both sides of every interface — a selection from a given cover
    fails (FS111-M2-NOSEL), local fills deadlock (FS111-M-DEADLOCK); at seven it holds (R7); at five it is not needed (FS111-M2-REDUCE-C)

Rests on it: FS-121's honest route at six.

derivation: FS111-REG-JP-C5
  statement: if a tight a.e.-proper five-colouring exists, some maximal five-cover has regular classes whose boundaries form a locally finite plane graph
  argument: FS111-M2-regularity.md § 2.3
  verdict: gap: MUA-REG-P (a maximal cover modified into one with regular classes; MUA-REG-U is false, FS111-M3-IRREG) and MUA-FIN with D3's clause (a
    regular maximal cover made locally finite; MUA-FIN-U is false, FS111-M3-FIN-U); given FS106-AE-MAP6 this statement holds iff χ_m⁰(ℝ²) ≥ 6
    (FS111-VM2-EQ5) — the answer restated

Rests on it: FS-121's five-colour section; the colour-generic rung FS111-MUA-FIN-L is its local form.

derivation: FS111-MUA-FIN-L
  statement: in a regular maximal partition, an HC-type pinch can be removed by a move that changes the partition only near the pinch
  argument: FS111-M4-cascade.md § 4.1
  verdict: gap: at the singular set — the move's cascade runs along the ladder of unit parallels with forced classes (FS111-M4-MOVE) and must end within
    FS111-M4-CUT's bound where the ladder stops being ordinary (a junction, a class with disconnected local parts, or an irregular class); whether it is
    absorbed there is open

Rests on it: FS-120 (the pinch at a junction), the next job the milestone named.

derivation: FS111-REG-A6
  statement: if a tight a.e.-proper six-colouring exists, then a segment-and-arc map carries an a.e.-proper six-colouring
  argument: FS111-M2-regularity.md § 4.3
  verdict: gap: on the honest route, honest saturation at six (FS111-C-SAT-T-HONEST), REG-J′₆ and ¬LRA (FS111-M2-REDUCE-A; LRA is FS-115's stuck ray); on
    the cover route, MUA-FIN at six and a NO for maps whose boundaries are unit parallels of their own classes' components (NO-PAR; Q-NO does not
    suffice, FS111-M2-DISCK7); given Q-NO this statement holds iff χ_m⁰(ℝ²) ≥ 7 (FS111-C-REG-EQ) — the answer restated

Rests on it: FS-121's six-colour section.

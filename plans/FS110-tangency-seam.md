# FS-110 — the tangency seam: does a tight six-map exist whose close complementary vertices are all tangent pairs, bowties or cusps? (the plan)

*Job FS110-P, the milestone planner (de Bruijn, Opus 5.5), 2026-09-27; brief `data/fs110/briefs/P110-planner.md` with
`data/fs110/briefs/STANDING-RULES.md`; advisor FS110-A (Poros), record `plans/POROS-2026-09-27-fs110-tangency-seam.md`. Stub:
`plans/STUB-tangency-seam.md`. WORKFLOW steps 3–4: §G (3.1), §PA (3.2), §IQ (3.3), the fixed claim list `data/fs110/claims.md`, then the plan and
the briefs. Nothing here derives a seam; the jobs do.*

## Theorems this phase proved

None. A planning phase states claims; it proves nothing (standing rule 7's heading, kept empty on purpose).

## Would-have-searched-here log (standing rule 3)

- A search for a map meeting Q-rule (a tile-ring enumeration, a local-rule SAT, a MaxSAT over vertex types) — instead the plan assigns the
  construction side maps **given by formula** and checked exactly, and the proof side a hand derivation per seam.
- A float sweep over ring junctions and directions for V-C5's killing test ("a ring junction and a direction `θ` with no forced band on either
  side") — instead the plan poses V-C5 as a statement to be derived, with the exact one-parameter families (sliver width, angular margin) written
  by formula and checked at named values only.

## Stage 1 — SAVED: quotation check (standing rule 5), files opened, one naming hazard

### 1.1 Files read from disk (this order)

`data/fs110/briefs/P110-planner.md`, `STANDING-RULES.md`, `A110-advisor.md`; `CLAUDE.md` § The aim, § Counter-priors, § Frontier (header, items
30–31, paths forward top rows), G71's FS-106 addition, G79's tail, G82 in full (the loaded copy was stale: it predates FS-106 and FS-107; the
disk copy governs); `LEDGER.md` rows 131–133 in full, rows 1–130 by headline; `plans/STUB-tangency-seam.md` in full; `plans/STUB-reg-scale.md`;
`plans/STUB-regular-half-residuals.md` item 2; `plans/STUB-hole-dial.md`; `data/fs107/claims.md` in full (§7 included); `plans/FS107-derivation.md`
in full; `plans/FS107-stability.md` §PA, §R-close 3.1–3.3; `plans/FS107-R-stability.md` §3.4–3.6; `plans/FS107-W-near-colourings.md` §2.5,
§4.2–4.4; `plans/FS107-V-verification.md` §4.3; `plans/FS107-VW-verification.md` §2b.4, §4; `plans/POROS-2026-09-27-fs107-competition.md` §5.1,
§5.4, §5.8–5.10; `plans/FS106-TS-derivation.md` (TS-U §2.2; C-T-TAN, l. 258; C-T-IND, C-T-KILL, l. 273–275; the theorem list l. 11–36);
`plans/FS106-V-verification.md` l. 368–374 (the ⅔π counterexample checked) and l. 452 (Woodall's row); `plans/FS106-derivation.md` l. 129, 172;
`plans/PROTOCOL-competitor-and-advisor.md` §1 and the ninth run.

### 1.2 Quotation check

| quotation in the brief or the stub | source | verdict |
|---|---|---|
| "My goal is to fully solve, and then verify in Lean, HN. Then we publish." | `CLAUDE.md` § The aim | matches (a prefix of the longer quotation) |
| "Let's see some ambition. I know we can do it." | `CLAUDE.md` § Counter-priors | matches (a prefix) |
| "search for a finite graph is out" | `CLAUDE.md` § Publication | matches ("… It would be huge, not feasible.") |
| Standing rules 0, 3, 4: "From here on out …", "to eliminate the crutch …", "A proven theorem about why its impossible is also valid. All novel knowledge is a success." | `CLAUDE.md` § Counter-priors, § Toolchain, Frontier item 23 | match |
| Stub, Q-rule, "is there a planar six-coloured map, tiles of diameter `≤ 1`, … survive K-KILL's second half)?" | A2 §5.1, table, bounded row | matches verbatim |
| Stub, "a YES is decisive (`χ(ℝ²) ≤ 6` with no MR, through W-EQ-K)" | A2 §5.9, the "Why the tangency-seam question first" bullet | matches |
| Stub, NO / YES clauses of Q-rule | A2 §5.1 | match |
| Stub, V-C5: "**Tangency is not an escape at positive scale** … `≳ s²·s′ sin(µ/2)`", the sketch, the killing test | FS107-V §4.3 | match |
| Stub, R's re-route "in the overlap of the two deformed annuli … so it is priced by CP" | FS107-R §3.4 | matches |
| Stub, W-TAN's paraphrase ("must form a tangent pair … or include a bowtie") | FS107-W-TAN, `plans/FS107-derivation.md` §2 | a paraphrase, unquoted; the claim list quotes the derivation file's statement |
| Brief, "Townsend's ⅔π counterexample to Woodall already lives among maps with a unit-arc seam" | FS106-V l. 368–374: "It uses a boundary that is a **unit arc**" | consistent; the check is at l. 368, after § Continuation — FS106-V3's heading (l. 276) |
| Brief, Q-full and Q-rule | the stub | paraphrased, unquoted; the claim list quotes the stub |

### 1.3 A naming hazard found in the quotation check (carried into the claim list)

**"C5" names two different objects.** (a) **TS-C5** — FS-106's *configuration C5* (`plans/FS106-TS-derivation.md` l. 200: "Configuration C5 (Prop. 5
fails at `x` without Condition 5)"), the object of FS106-AE-Q2's [G1] and of FS106-IND-X ("configuration C5 with a colour in the side cones at `y`").
(b) **V-C5** — FS107-V's fifth configuration of its CP tool (FS107-V l. 145: "C5: a full-ring junction with an interface exactly along `e_u^⊥`"),
the instance behind "tangency is not an escape at positive scale", filed as **FS107-V-C5**. The brief's "tangent pairs (C5)" is (b). The claim list
uses **V-C5** and **TS-C5** throughout, never bare "C5".

## Stage 1 — SAVED

## Stage 2a — SAVED: §G part 1, the grokkings G1–G82 (WORKFLOW 3.1; `CLAUDE.md` read from disk at `0db926a7`)

*The milestone's object, in the theory's terms: a **tight six-map** — a locally finite map of bounded arc complexity (`𝓜_K`: tiles bounded by
`≤ K` circular or straight arcs of radius `≥ 1/K`, `≤ K` tiles per unit disc) whose six classes are open, avoid distance 1 almost everywhere and
cover the plane off the boundaries (row 133, W-EQ-K). Its vertices carry **types** (essential or closure multicolours); the question is local at
pairs of vertices within distance 2. Verdicts: **B** bears (with the phase it changes: **N** the proof side, **Y** the construction side, **A** the
advisor, **V** the blind verifiers, **CL** the claim list, **C** the close), **S** silent (why), **F** falsifiable here (a registered prediction).*

| entry | verdict | reason, and the extraction |
|---|---|---|
| G1 field wall | S | arithmetic of finite graphs over K; the measurable question has no field (row 128 put it at ℚ(√635087), where every place mixes) |
| G2 rings about a point | S | a finite-witness grammar; a map's rings of tiles about a vertex are its vertex figure, read by G13/G46 below, not by rotation centres |
| G3 radially crystal | S | finite witnesses |
| G4 shell vocabulary | S | finite witnesses |
| G5 1-sum | S | finite graphs |
| G6 hexagram fabric | S | finite graphs |
| G7 detune family | S | rotations of finite fabric |
| G8 direction group | S | finite graphs |
| G9 rigidity at the forcing level | S | pair compulsions of finite graphs |
| G10 forcing distributed | S | finite graphs |
| G11 Moser-free five | S | finite graphs |
| G12 quadrature law | S | cross edges of rotated copies |
| G13 fan ladder | **B → N, CL** | C-T-TAN's pigeonhole at `w₀` ("all six classes in `P(u) ∪ P(v)`") is a fan: `u` and `v` together must cover `w₀`'s neighbourhood with six colours. A cusp escapes exactly by failing coverage (a density-0 colour covers nothing). **X1:** N states each seam's kill as a coverage failure at `w₀` and names which colour escapes coverage; CL writes C-T-TAN's hypothesis as coverage |
| G14 width without degree | S | cross-copy matchings |
| G15 pigeonhole × kill | **B → N** | the NO has two acts: **Act One**, a class-level compulsion — every tight six-map in `𝓜_K` has a close complementary pair or an equal-type pair in `(1, 2)` (W §2.5's "no tangency at all" question: a seamless map is excluded) — and **the kills**, one per seam kind. **X2:** N proves Act One separately from the kills; a kill list with no Act One decides nothing (a map could avoid every seam by having no close complementary pair) |
| G16 distance-2 pigeonhole | S | residue colourings; the `d = 2` edge case (W-TAN's collinear configuration, AE-POLY) is a different object, carried by CL |
| G17 globality at the top rung | S | sub-rung carriers of finite graphs |
| G18 composition | S | no solver |
| G19 5-tight fabric | S | class sweeps on finite fabric |
| G20 brick colourings, boundary-tight by force | **B → A, both** | the classical tight maps (brick, hexagonal seven-colourings) are tight in D-SLACK's sense with seven colours: **X3:** the seven-colour control — every NO step must fail on the hexagonal seven-colouring (K1) and name where six is spent (FS-106 TS's K1 rule); every Y construction must not be a seven-colouring in disguise |
| G21 a negative measures its enumeration | **B → CL, N, Y, V; F** | (a) a list of exceptions measures its class — cusps were missed once (FS-107 M4): **X4:** N proves the exception list at a vertex of a `𝓜_K` map complete (every way `T_u` can be null at a cone of `𝓜_K`), not only each item; (b) a rule is necessary, not sufficient: a Q-rule YES is a candidate, never a colouring; (c) Y's exact checker certifies members; the family claim is a derivation; (d) audit a flattering seam verdict at a FALSE's rate. **F:** whether the four-seam list (tangent, bowtie, cusp, same-type) is complete for `𝓜_K`; registered E2 |
| G22 where a six-colouring cannot live | **B → Y** | non-polygonal; with W-POLY, bounded polygonal designs keep holes: **X5:** Y's candidates are curved from the first line, and Y states which arcs are unit arcs (TS-U's seat) |
| G23 refining is not a route down | S | cell-family scale |
| G24 gap law (integrality) | **B → N** | six enters the NO only through K-C6 (disjoint triples are complementary at six) and the pigeonhole `|Π|/6`; **X6:** N names, in each kill, the line where "six" is used and checks it fails at seven (X3) |
| G25 recursive ladder | S | finite forcers |
| G26 6-forcer reduction | S | finite gadgets |
| G27 hidden symmetry | **B (weak) → Y** | a candidate's symmetry group (wallpaper group, colour permutations) cuts the exact check to a fundamental domain: **X7:** Y states the group with the formula |
| G28 fine tail | S | cell family |
| G29 cell family closed | S | cell family |
| G30 measurement generates; derivation kills | **B → N, Y, CL** | failure mode 5: the domain "tight six-maps in `𝓜_K`" is not known non-empty — every statement about it is about a possible object (VW §2b.4), and CL says so; failure mode 1: escape clauses to the prediction's standard; the next room is geometric measure theory and the geometry of free boundaries (**X8:** §PA searches it) |
| G31 no held witness carries a compulsion | S | finite witnesses |
| G32 two-distance dial | S | finite graphs |
| G33 batch descent | S | finite descent |
| G34 the field is the selection | S | descent over K |
| G35 2-adic wall | S | arithmetic |
| G36 residue colouring | S | arithmetic |
| G37 endgame shape | S | descent |
| G38 linear thresholds | S | additive colourings |
| G39 redundancy before rigidity | S | finite critical sets |
| G40 absorption | S | finite copies |
| G41 additive bounds | S | additive colourings |
| G42 additive rigidity | S | additive colourings |
| G43 residue sealing | S | arithmetic |
| G44 Kloosterman | S | finite planes |
| G45 lift | S | residue configurations |
| G46 recognize the classical theory | **B → §PA, N** | the recognition: a vertex of a tight map blows up to a **cone partition** (sectors), and C-T-TAN classifies which pairs of cones at distance `< 2` are admissible — the shape of **Taylor-type classification of tangent cones of partitions** in geometric measure theory, and of **vertex-type (vertex-figure) constraints of tilings**. **X9:** §PA searches both vocabularies; N phrases the seam question as a classification of admissible tangent-cone pairs |
| G47 compulsion face of sealing | S | arithmetic |
| G48 tightness mechanism | S | arithmetic; and "tight" there is Hoffman's, not D-SLACK's (CL keeps D-SLACK's) |
| G49 prior-art gate | **B → §PA** | the object named in the disciplines' words (G46), two disciplines, the question as posed (S–V Question 2 at bounded complexity), author listings of Woodall, Townsend, Coulson, Sokolov, Voronov in zbMATH |
| G50 read what the search found | **B → §PA, N** | Townsend's 1979 manuscript and Woodall 1973 §3 are held and read (row 132); S–V is read; `[Coulson2004]`'s vertex analysis must be read at the section level before N relies on "maps need six" at a vertex (**X10**) |
| G51 competitor and advisor | **B → staffing; F** | the ninth run's lesson: "a construction against a proof locates the question more than it contests it; the verifier per side is where the contest happens … brief the next round (FS-110) on the meeting point" (protocol §3). **X11:** both sides are briefed on the seam list itself, seam by seam — N to close each, Y to realise each — so each seam is contested; a blind verifier per side. **F:** the design's killing test ("the competitor and the advisor produce nothing the single agent would not have produced alone") scored at the close |
| G52 equal-radius family | S | rotated finite arenas |
| G53 counting compulsion | **B (weak) → N** | C-T-TAN's pigeonhole is a counting compulsion (one class fills `≥ |Π|/6` of a parallelogram at `w₀`); its quantitative form at scale `s` is CP's area. No new instrument; noted so N counts rather than pins |
| G54 tight or slack (Hoffman) | S | spectral; naming hazard only: "tight" in FS-110 is D-SLACK's (slack for no `ε > 0`) — CL says so |
| G55 unit-vector ring, chain | S | arithmetic |
| G56 window for six | S | finite planes |
| G57 triangle-free window | S | finite planes |
| G58 antipodal conjecture | **B (weak) → Y** | an ansatz: a design symmetric under a point reflection that permutes colours by an involution; at a hole-free map a point reflection about a boundary point needs no fixed colour, and an involution swapping complementary triples halves the vertex-type bookkeeping. Optional for Y (FS-107's X10 went unused) |
| G59 wall at six, fractional | S | finite planes |
| G60 fractional cap | **B → N** | a per-class argument caps below 4.37 (row 129): the NO must read how classes meet at vertices — which Q-rule does; confirms the shape, no new phase |
| G61 three colours at 1/3 | S | arithmetic |
| G62 twisted bilayers | S | finite witnesses |
| G63 transcendence free | S | arithmetic |
| G64 six is not a value | **B → CL** | keep six and five apart: a tight five-map would be `χ(ℝ²) ≤ 5`, a different outcome from a six-map (CL states Q-full at six; Y reports a five-map as its own result) |
| G65 SAT phase diagram | S | no solver (the ban; Kooshi's ruling beyond it) |
| G66 residue tower | S | arithmetic |
| G67 the form of a grokking | **B → CL** | every claim in the list carries its killing test or what it forbids |
| G68 quotient first | S | lattices |
| G69 rigidity is arithmetic | S | lattices |
| G70 √3-clean is residue | S | Moser lattice |
| G71 three colours linear; the index of a density trace | **B → N, Y; F** | the index is the `K₃`-cover height of a trace on a curve; its bound between complementary curves fails only at a swap, which a unit-arc interface facing a bowtie forces (row 132, FS106-IND-X, `|ΔInd| = 2`). **X12:** the bowtie seam is where the index method is dead, so N's bowtie kill must use something other than the index (an area at the bowtie's scale, CP-style), or price the swap; Y's bowtie model must exhibit the swap. **F:** G71's sentence "its bound between complementary curves fails only at a swap" — a bowtie seam that kills the index without a swap would refute it |
| G72 invariant question | **B → §IQ** | the structural form: what does every tight six-map carry at its vertices? |
| G73 four colours cell by cell | S | cell-local *topological* invariants of lattice colourings; FS-110's vertex constraints are metric (unit circles), not topological |
| G74 layers of a field plane | S | arithmetic |
| G75 triangles as a linear identity | S | lattice spectra |
| G76 local theorem, global extension | S (with one echo) | arithmetic; the echo — "every construction of a 'no' that reads finitely much dies" — has a local analogue here that the plan does not assume |
| G77 character colourings local | S | arithmetic |
| G78 rank one, frozen walls | S | lattice shifts |
| G79 counterexample invariant vs example invariant | **B → §IQ, N, Y; F** | W-TAN is the flip of C-T-TAN; the next flip: V-C5's sketch is a counterexample invariant ("a tangent ring still costs"); its flip is what every seam a tight map *can* carry looks like — **X13:** Y writes, for each seam kind, the invariant every realisation must carry (a sliver, a unit arc, a zero angle) and N kills that invariant, not the seam's name. **F:** the record at the close |
| G80 infinite rank | S | MR |
| G81 where every place mixes | S | arithmetic; frames why the question is archimedean |
| G82 stability; feature scale, not band scale | **B → N, Y, CL** | at bounded complexity `K` the feature scale is bounded below (arcs of radius `≥ 1/K`, `≤ K` tiles per unit disc): FS-110 lives exactly where G82's second door ("features whose own scale is bounded below") is automatic. **X14:** N prices every seam at its feature's scale `s ≥ s(K)`, never at `ε`'s, and states `s(K)`; a seam priced only in the blow-up (scale → 0) is FS-111's, not FS-110's |

## Stage 2a — SAVED

## Stage 2b — SAVED: §G part 2 (rows 1–133; the method rules) and part 3 (the extraction)

### §G part 2a — `LEDGER.md` rows (§ A: rows 131–133 in full; rows 1–130 by headline)

| row | verdict | reason, and the extraction |
|---|---|---|
| 1 | B (weak) → N, Y | a two-circle unit-distance graph is 3-colourable by an explicit strip construction: in-house precedent for C-T-BIKE's arc 3-colouring of `T₁(u) ∪ T₁(v)` |
| 2 | B (weak) → N | the seam rotation's infinite order on two circles: the bicycle's arcs cannot close up periodically at generic `d`; noted for C-T-BIKE |
| 3 | S | fan/coverage kernel lemmas on finite classes (G13 carries the bearing) |
| 4 | S | fan/coverage kernel lemmas on finite classes (G13 carries the bearing) |
| 5 | S | fan/coverage kernel lemmas on finite classes (G13 carries the bearing) |
| 6 | S | 120° triangle identity on circles of radius `1/√3`; no vertex-type content |
| 7 | S | finite graphs |
| 8 | S | finite graphs |
| 9 | B (weak) → N | a 120° compulsion on two circles: the circle-colouring vocabulary Voronov's Lemmas 5–6 use; noted |
| 10 | S | finite graphs |
| 11 | B (weak) → N | the strip automaton: a finite-state reading of circle colourings, a method precedent for C-T-BIKE by hand (never run as a search) |
| 12 | S | [tools] on finite closures |
| 13 | S | [tools] on finite closures |
| 14 | S | two-circle gluing classification; finite |
| 15 | S | [tools] on finite closures |
| 16 | S | [tools] on finite closures |
| 17 | S | gluing; finite |
| 18 | S | seam-field closures, finite and arithmetic |
| 19 | S | seam-field closures, finite and arithmetic |
| 20 | S | seam-field closures, finite and arithmetic |
| 21 | S | seam-field closures, finite and arithmetic |
| 22 | S | seam-field closures, finite and arithmetic |
| 23 | S | seam-field closures, finite and arithmetic |
| 24 | S | seam-field closures, finite and arithmetic |
| 25 | S | seam-field closures, finite and arithmetic |
| 26 | S | finite witnesses and their anatomy |
| 27 | S | finite witnesses and their anatomy |
| 28 | S | finite witnesses and their anatomy |
| 29 | S | finite witnesses and their anatomy |
| 30 | S | finite witnesses and their anatomy |
| 31 | S | finite carriers; the six-target as a finite-graph statement |
| 32 | S | finite carriers; the six-target as a finite-graph statement |
| 33 | B → both | the boundary-tight brick certificate and the seven-colouring on a torus: the seven-colour control object (X3) |
| 34 | B (weak) → Y | coset colourings need seven (2, 5, 6 not Loeschian): Y's candidate cannot be a lattice-coset colouring of the triangular lattice |
| 35 | S | cell family (closed, G29) |
| 36 | S | cell family (closed, G29) |
| 37 | S | cell family (closed, G29) |
| 38 | S | cell family (closed, G29) |
| 39 | S | cell family (closed, G29) |
| 40 | S | cell family (closed, G29) |
| 41 | S | the limit lemma is the finite-graph route to stability; Kooshi's ruling (finite-graph search out) leaves it unused |
| 42 | S | compulsions and arithmetic of finite graphs and field planes |
| 43 | S | compulsions and arithmetic of finite graphs and field planes |
| 44 | S | compulsions and arithmetic of finite graphs and field planes |
| 45 | S | compulsions and arithmetic of finite graphs and field planes |
| 46 | S | compulsions and arithmetic of finite graphs and field planes |
| 47 | S | compulsions and arithmetic of finite graphs and field planes |
| 48 | S | compulsions and arithmetic of finite graphs and field planes |
| 49 | S | compulsions and arithmetic of finite graphs and field planes |
| 50 | S | compulsions and arithmetic of finite graphs and field planes |
| 51 | S | compulsions and arithmetic of finite graphs and field planes |
| 52 | S | compulsions and arithmetic of finite graphs and field planes |
| 53 | S | compulsions and arithmetic of finite graphs and field planes |
| 54 | S | compulsions and arithmetic of finite graphs and field planes |
| 55 | S | compulsions and arithmetic of finite graphs and field planes |
| 56 | S | compulsions and arithmetic of finite graphs and field planes |
| 57 | S | compulsions and arithmetic of finite graphs and field planes |
| 58 | S | compulsions and arithmetic of finite graphs and field planes |
| 59 | S | compulsions and arithmetic of finite graphs and field planes |
| 60 | S | compulsions and arithmetic of finite graphs and field planes |
| 61 | S | compulsions and arithmetic of finite graphs and field planes |
| 62 | S | compulsions and arithmetic of finite graphs and field planes |
| 63 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 64 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 65 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 66 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 67 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 68 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 69 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 70 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 71 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 72 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 73 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 74 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 75 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 76 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 77 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 78 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 79 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 80 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 81 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 82 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 83 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 84 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 85 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 86 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 87 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 88 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 89 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 90 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 91 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 92 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 93 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 94 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 95 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 96 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 97 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 98 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 99 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 100 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 101 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 102 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 103 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 104 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 105 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 106 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 107 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 108 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 109 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 110 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 111 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 112 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 113 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 114 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 115 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 116 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 117 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 118 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 119 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 120 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 121 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 122 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 123 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 124 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 125 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 126 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 127 | S | arithmetic, lattices, residue planes, character and measure rigidity over number fields |
| 128 | B → CL | given MR, `χ(ℝ²) = χ_m⁰(ℝ²)`: a NO is `χ(ℝ²) = 7` only jointly with FS-111 and only given MR; a YES needs no MR (CL states both) |
| 129 | B → N | per-class arguments stop below 4.37 (K-INT): the NO reads vertex types |
| 130 | B → CL | `χ_CP = χ_m⁰` with no MR: the object Q-full's YES lands in |
| 131 | B → CL, N | stability as the question; K-FLOOR, K-HIT, K-PIX and the Rajchman step; a seam priced at `ε`'s scale is capped (K-HIT, K-AD) |
| 132 | B → N, Y, CL | TS-U (unit arcs: side cones empty), TS-C (clusters of diameter ≤ 1), hole-filling failing at bichromatic vertices of degree ≥ 4, FS106-IND-X (the swap at a bowtie), V-C5's sibling TS-C5 ([G1]), Townsend's and Woodall's map theorems (maps need six), S–V Question 2 a GAP at [G1]–[G4]. **X15:** CL carries TS-U, TS-C and IND-X as shared constraints with their grades; bichromatic degree-≥4 vertices are a fifth live vertex kind beside the four seams (N and Y both address them) |
| 133 | B → everything | the milestone's question (W-EQ-K, W-TAN, CP, RR, W-POLY, HX-STALL, V-C5); **X16:** the construction side's family members are eroded by VW-ERODE and checked by the held checkers; its full tight map is checked by a curved-map checker (the exact per-tile-pair distance range, below) |

### §G part 2b — the method rules (`CLAUDE.md` § The standard of evidence, § What compute helps, § Toolchain, § Building, § Searching, § The gate, § Make the gate fail; § Delegation)

| rule | verdict | reason, and the extraction |
|---|---|---|
| no native evaluation in a headline | S | no kernel headline in FS-110 (the Lean slot follows a landed half) |
| the artifact is the certificate plus the checker | **B → Y** | a YES candidate ships as its formula plus an exact checker's output; nobody re-runs a search (there is none) |
| the witness is independently re-derivable | **B → Y** | "state the construction, not only the coordinates": every candidate map is a formula with its symmetry group (X7), rebuildable by hand |
| read the final statement aloud | **B → CL, V** | Q-rule is not Q-full; W-TAN's clauses are for essential types and trivalent maps; the verifiers read each verdict against the claim's words |
| report the hunt honestly | B → both | a seam neither closed nor realised is a GAP at a named step |
| write the certificate for the reviewer early | **B → N, Y** | ask of each seam verdict "what must someone who trusts none of this check?" at the stage it is drafted, not at the close (FS-107 M3: a theorem line that dropped its hypotheses) |
| order a verification by marginal evidential value | B → V | the verifiers check the load-bearing step of each seam first |
| kernel leaves price low once begun | S | no kernel phase |
| GPU/SAT instruments | S | nothing to search |
| the ban; Kooshi's finite-search ruling | **B → all** | the construction side's maps are given by formula and checked exactly in seconds; no tile-ring enumeration, no local-rule SAT, no optimiser |
| checkpoint and resume (PROTECTED) | **B → all** | every job works in SAVED stages committed per stage; no long run is planned (every exact check is seconds) |
| a blocking run is presumed killable (PROTECTED) | S | no long runs planned |
| kill by pid; pipes; waiters | S | no background jobs planned; if one appears, pid and a success-path file |
| slot.py above 2 GiB or 2 minutes | B → Y | the curved-map checker must stay under it or run in a slot |
| § Searching (ugrep, `rg -uu`) | B → all | completeness questions use `rg -uu` or `grep -rP` |
| every theorem over a structure ships an inhabitant (vacuity) | **B → CL** | the domain of tight six-maps is not known non-empty: CL marks every statement over it "about a possible object" (G30 mode 5), and a Lean form declares its vacuity status |
| make the gate fail; plant faults | **B → Y** | Y's curved-map checker carries planted faults that fire for their own reason (standing rule 7), and a faithful stub beside each |
| a positive signal for what did not happen | B → Y | the checker prints the offending tile pair and its exact distance range on REJECT, and the minimum margin on ACCEPT |
| state the uninformative outcome and confirm it reachable | **B → registrations** | every expectation in §5.3 names both outcomes and why each is reachable |
| exactly one thing differs between compared numbers | B → N, V | a seam's forced area (an area) is never compared with a hole *density* (FS-107 M2) |
| a measured half and a derived half fail in opposite directions | **B → Y** | a curved-map checker whose distance ranges are **derived** (critical-point equations) errs by inventing or losing a pair: a lost pair makes a REJECT an ACCEPT, so there **ACCEPT is the suspect verdict**; a control with a known same-colour unit pair must REJECT |
| a positive control proves only the generator's shape | **B → Y** | Y writes its generator's image first (FS-107's X9 paid most) and checks each target seam kind lies inside it |
| count the generator's free parameters | **B → Y** | a seam realisation with fewer free parameters than the seam's constraints is a measure-zero slice; count before building |
| a candidate failing one gate is checked against all | B → Y | a candidate that fails Q-rule at one seam is still read at every other before being set aside |
| a one-sided filter: enumerate how to make it inapplicable | **B → N, Y** | Q-rule is a one-sided filter on Q-full: Y lists the ways to pass Q-rule and still fail the band (equal-type pairs, degree-≥4 bichromatic vertices, the `d = 2` configuration), N the ways a map could make C-T-TAN inapplicable (cusps, weak-* blow-ups — outside `𝓜_K` —, slivers) |
| a caveat written and stepped over | B → all | each record's summary is re-read against its scope lines before commit |
| delegation one level deep | **B → briefs** | every brief says it, with the reason |

### §G part 3 — the extraction: each *bears* as an instruction to a phase (carried into stage 5's phase table and the briefs)

| X | from | instruction | phase |
|---|---|---|---|
| X1 | G13 | state each seam's kill as a coverage failure at `w₀`; name the escaping colour | N |
| X2 | G15 | Act One (a close complementary pair or a bicycle pair exists in every tight six-map of `𝓜_K`) proved apart from the kills | N |
| X3 | G20, row 33 | the seven-colour control on every step (hexagonal seven-colouring K1; brick) | N, Y, V |
| X4 | G21 | prove the exception list at a `𝓜_K` vertex complete, not item by item; a Q-rule YES is a candidate only | N, CL |
| X5 | G22, W-POLY | curved candidates from the first line; unit arcs named | Y |
| X6 | G24 | name the line where six is spent in each kill | N |
| X7 | G27 | every candidate stated with its symmetry group | Y |
| X8 | G30 | the next room is geometric measure theory and free-boundary geometry | §PA |
| X9 | G46 | the seam question as a classification of admissible tangent-cone pairs; §PA in that vocabulary and in tilings' vertex-figure vocabulary | §PA, N |
| X10 | G50 | read `[Coulson2004]`'s vertex analysis (and Townsend's manuscript at the vertex step) before relying on it | N, §PA |
| X11 | G51 | contest seam by seam: N closes each, Y realises each; blind verifier per side | staffing |
| X12 | G71, row 132 | at a bowtie the index method is dead: N's bowtie kill uses an area or prices the swap; Y's bowtie model shows the swap | N, Y |
| X13 | G79 | Y writes the invariant every realisation of each seam carries (sliver, unit arc, zero angle); N kills that invariant | Y, N |
| X14 | G82 | price every seam at its feature scale `s ≥ s(K)`, and state `s(K)` | N |
| X15 | row 132 | bichromatic vertices of degree `≥ 4` are a fifth live vertex kind beside the four seams | N, Y, CL |
| X16 | row 133 | Y's families eroded by VW-ERODE and checked by the held checkers; a full tight map checked by a curved-map checker | Y |
| X17 | methods | ACCEPT is the suspect verdict of a derived-distance checker; planted faults and a known-REJECT control | Y |
| X18 | methods | a one-sided filter: list the ways to pass Q-rule and fail Q-full, and the ways to make C-T-TAN inapplicable | N, Y |

**Falsifiable here (registered in §5.3):** G21's completeness of the seam list (E2); G71's "only at a swap" (E5); G79's flip record and G72's count
(scored at the close); G51's design killing test (scored at the close).

## Stage 2b — SAVED

## Stage 3 — SAVED: §PA (the prior-art gate) and §IQ (the invariant question)

### §PA — searched 2026-09-27 by the planner (zbMATH Open API for discovery; OpenAlex citing lists; arXiv API; held PDFs by `pdftotext`; raw outputs in `data/fs110/fs110-p/*.json`)

**The recognition sentence (G46), used as the query.** FS-110's object sits in three literatures: (i) **map colourings avoiding the unit distance**
(Woodall 1973 → Townsend 1981 and his 1979 manuscript → Thomassen 1999 → Coulson 2004 → Sokolov–Voronov 2025); (ii) **the local geometry of sets
at diameter or distance exactly 1** — two same-colour tiles of a tight map are a *Siamese* pair (all cross-distances `≤ 1`: their union has diameter
`≤ 1`) or an *outer* pair (all `≥ 1`) (`[Parts2020c]` p. 2), so a tight pair is a set of diameter exactly 1 or a pair at distance exactly 1, and the
tile boundaries there are envelopes of unit circles: **ball- (disc-) polygons and spindle convexity** (Bezdek, Lángi, Naszódi; `[MartiniMontejanoOliveros2019]`
*Bodies of constant width*), Reuleaux polygons; (iii) **tangent cones of partitions** (the blow-up of a map vertex is a cone partition, and C-T-TAN
classifies admissible cone pairs), the shape of Taylor-type singularity classification in geometric measure theory, and **local (matching) rules of
tilings**, whose global consistency is in general undecidable (Wang, Berger) — so a NO needs an invariant, not an exhaustion of local cases.

| # | question (WORKFLOW 3.2) | what was done | finding |
|---|---|---|---|
| 1 | the discipline's words | zbMATH: `ab:"unit distance" & (ab:map \| ab:tiling) & ab:colo*` (8 hits); `ab:"chromatic number of the plane" & (ab:boundar* \| ab:Jordan \| ab:regions)` (4); `ab:spindle & ab:convex` (19); vertex-type, circle-packing and tangent-cone vocabularies (0 or proceedings only) | (i): Parts 2020 and de Grey–Parts 2022 (held), Soifer's books, **Kruskal 2008**, *The chromatic number of the plane: the bounded case* (J. Comput. Syst. Sci. 74, 598–627; Zbl 1139.05023; summary withheld by licence; **unheld, title only**); (ii): the spindle-convexity literature exists and **never meets colourings** (no hit joins them); (iii): nothing joins tangent cones or vertex-type rules to distance-avoiding colourings |
| 2 | two disciplines | (i) × (ii); (i) × (iii) | **PA-1 (a recognition, not prior art):** in a tight map every tight same-colour pair is either a set of diameter exactly 1 (Siamese) or two sets at distance exactly 1 (outer), so the tight boundary arcs are unit arcs or envelopes of unit circles — spindle convexity's objects. TS-U (a unit arc's side cones are empty of both its colours) is a statement about a ball-polygon's vertex. The planner hands this vocabulary to both sides; no theorem is imported |
| 3 | the question, not only the method | `[SokolovVoronov2025]`'s questions read in the held PDF | **The question is in print.** S–V, Question 2, verbatim: "Is it true that 7 colors are needed to color a locally finite map in the plane if the boundaries can be arcs of unit circles and if trichromatic vertices of degree greater than 3 are allowed?" — and their Conditions 5 ("If any boundary intersects with a circle of unit radius at a finite set of points, we say that arcs of unit curvature are forbidden") and 6 ("There are no trichromatic vertices of degree greater than 3") are exactly the two failures of C-T-TAN at cone points (TS l. 258: "the tangent form of Prop. 2.2 names exactly S–V's Conditions 5 (tangency) and 6 (the bowtie)"). **FS-110's Q-full is Question 2 almost everywhere at bounded arc complexity, with cusps added** — cusps appear in neither condition. Woodall 1973's map question and Townsend's are its ancestors (row 132) |
| 4 | outside arXiv | zbMATH author listings; Geombinatorics | Townsend: one zbMATH item (1981); `[Townsend2005]` (Geombinatorics XIV(4)) still unheld; Coulson: seven items, of which *Tilings and colourings of 3-space* (2003) and Payne–Coulson 2007 (a dense distance-1-excluding set in `ℝ³`) are 3-space, not the plane; **Soifer 2024, ch. "Chromatic Number of the Plane Meets Map Coloring: Townsend–Woodall's 5-Color Theorem"** (The Mathematical Coloring Book, 2nd ed., doi 10.1007/978-1-0716-3597-1_25) — **unheld**, the likeliest print statement of the map question's history |
| 5 | the poser's citation graph | OpenAlex citing lists: `[Woodall1973]` (79), `[Townsend1981]` (5), `[Thomassen1999]` (7); S–V's citing list from FS-107 (one, a Ramsey listing) | Townsend's five: Thomassen 1999, Manta 2021, Chybowska-Sokół et al. 2023 (held as `[ChybowskaSokol2022]`), Soifer 2024 ch. 25, and **Alm–Manske 2013, *On radial colorings of annuli*** (arXiv:1305.5229; abstract read: "we consider radial colorings, which are 'nice' colorings, and completely determine the radial chromatic numbers of various annuli") — a local model for the band annulus about a close pair and for C-T-BIKE; **unheld, abstract only**. Thomassen's seven: Soifer's surveys, Manta, Sirgedas 2021 (spheres), **Ágoston 2025, *A lower bound on the number of colours needed to nicely colour a sphere*** (DCG; doi 10.1007/s00454-025-00736-3) — nice maps on spheres; **unheld, title only**. Woodall's 79: nothing new on maps beyond the above (the rest arithmetic, measurable, Borsuk) |
| 6 | open every neighbouring citing work | Alm–Manske's abstract (arXiv API); the others title only | none of the three unheld items is read; each is a debt, below. No citing work found states a vertex-level rule of Q-rule's kind |
| 7 | two databases | OpenAlex (FS-107's debt, now run for three posers) and zbMATH; Semantic Scholar rate-limited (429) | OpenAlex found Alm–Manske and Ágoston, which zbMATH's topical queries did not; `[Coulson2004]`'s citing list **not run** (OpenAlex search paused; a debt) |
| 8 | full author listings in zbMATH, the question in their words | Coulson (7), Townsend (1); Woodall's, Voronov's and Parts's listings were run at FS-106 and FS-107 | nothing further on topic |

**What the gate changes in the plan.** (a) The claim list quotes S–V's Question 2 and Conditions 5–6 verbatim, and states Q-full as Question 2 almost
everywhere at bounded arc complexity with cusps added. (b) Both briefs carry PA-1's vocabulary (ball-polygons, spindle convexity, Reuleaux) as a
reading room for the tight arcs, and the local-rule warning (§IQ). (c) The construction side reads Alm–Manske (if fetched) before building a bicycle
model. (d) Novelty wording: "not found in print"; the question is S–V's.

**Papers still needed (for the report):** Kruskal 2008 (J. Comput. Syst. Sci. 74, 598–627); Soifer 2024 ch. 25 (doi 10.1007/978-1-0716-3597-1_25);
Alm–Manske 2013 (arXiv:1305.5229, free); Ágoston 2025 (DCG); `[Townsend2005]`; `[Coulson2004]`'s citing list (OpenAlex). **Proposed `BIBLIOGRAPHY.md`
rows (listing only):** Kruskal 2008; Alm–Manske 2013 (abstract read, FS110-P); Ágoston 2025; `[MartiniMontejanoOliveros2019]` and Bezdek–Lángi–Naszódi
(the spindle-convexity vocabulary; titles from zbMATH listings); Soifer 2024 ch. 25.

### §IQ — the invariant question (WORKFLOW 3.3)

1. **The existence form.** Is there a full tight a.e.-proper six-colouring by a map in `𝓜_K` (Q-full)? Is there a map meeting Q-rule?
2. **The structural form.** *What must every tight six-map carry at each vertex, read against every vertex within distance 2, that a global count can
   see?* Posed in the most general class where it makes sense: locally finite maps whose boundaries are C¹ arcs with one-sided tangents at the vertices
   (the cone class), any number of colours `k`, the six entering only through K-C6. It is about every solution, and it is W-TAN's flip taken one step
   further: C-T-TAN's no-go says what a counterexample pair must avoid; the structural form asks what every *vertex* carries.
3. **The invariant it forces — named here, not found in print.** The **blocking profile** of a vertex `u` at scale `s`: for each direction `θ` and
   side `σ`, the depth `β_u(θ, σ)` of the band a unit circle about a point beyond `u` in direction `θ` is forced to cross in `u`'s colours (FS107-V
   §4.3's quantity; CP is the statement that two complementary vertices blocking toward a common `w₀` force area `≍ ss′`). Its **unblocked set**
   `U(u) = {θ : β_u(θ, σ) = 0 for some σ}` is, by C-T-TAN at cone points, a pair of directions at a tangent interface, an open set at a bowtie, and
   (V-C5's sketch) empty at positive scale except for slivers. **The rule every solution carries:** for every close complementary pair `(u, v)`, each
   of the two points `w₀` lies in a direction of `U(u) ∪ U(v)`. Beside it, the global invariants a count can use: (b) **Euler's formula on the torus**
   for a periodic map (`V − E + F = 0` per period; the seam strip periodises any W-EQ-K map at cost `O(1/L)`, VW §4 item 2) with each vertex weighted
   by its type; (c) K-DENS per class; (d) the index of density traces (G71), dead at bowties; (e) the **type graph** on the twenty triples, two triples
   joined when they occur within distance `< 2`, which off seams must be an intersecting family (K-C6). **Warning from §PA (iii):** Q-rule is a
   local-rule problem, and local rules can be consistent only aperiodically or undecidably in general; a NO should therefore come from a count
   ((b), (c)) fed by the local rule, never from an exhaustion of vertex configurations.
4. **Its route.** Derivation only: the proof side derives the blocking profile at each vertex kind of `𝓜_K` and a count; the construction side
   derives, for each seam kind, what every realisation must carry (G79's flip, X13). Exact checks of seconds check a derived claim on a given formula.
5. **The open instances it would decide.** Q-rule; Q-full at every `K`; S–V Question 2 almost everywhere for `𝓜_K` maps; V-C5's general claim;
   W §2.5's seamless question (Act One); the four seams and the degree-`≥ 4` bichromatic vertices; FS-111's first lemma (the rule at every scale);
   FS-108 item 2 (S–V Lemma 3's transplanted bicycle at `√3 ≤ d < 2`), shared with seam 4.

## Stage 3 — SAVED

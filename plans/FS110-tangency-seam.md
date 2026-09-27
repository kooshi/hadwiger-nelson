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

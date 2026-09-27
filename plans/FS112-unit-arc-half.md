# FS-112 — the unit-arc half: does a tight six-map exist once boundary arcs of radius 1 are allowed? (the plan)

*Job FS112-P, the milestone planner (de Bruijn, Opus 5.5), 2026-09-27; brief `data/fs112/briefs/P112-planner.md` with
`data/fs112/briefs/STANDING-RULES.md`; advisor FS112-A (Poros), record `plans/POROS-2026-09-27-fs112-unit-arc-half.md`. Stub:
`plans/STUB-unit-arc-half.md`. WORKFLOW steps 3–5: §G (3.1), §PA (3.2), §IQ (3.3), the fixed claim list `data/fs112/claims.md`, then the plan, the
registrations and the briefs. Nothing here derives a seam; the jobs do. HEAD at launch: 96ea0744.*

## Theorems this phase proved

None. A planning phase states claims; it proves nothing (standing rule 7's heading, kept empty on purpose).

## Would-have-searched-here log (standing rule 3)

- (stage 1) A search for exact coordinates of `[AxenovichEtAl2014]`'s six-coloured strip by fitting its Figure 4 — instead the plan makes the
  strip's reconstruction **by formula from the printed rule** ("symmetric tiles have width 1/2, with the rounded boundary being a circular arc of radius 1
  centered at the opposite corner of the tile"; height `√15/2 + √3`) the construction side's first calibration task, checked exactly.

## Stage 1 — SAVED: quotation check (standing rule 5), files opened, one naming hazard

### 1.1 Files read from disk (this order)

`data/fs112/briefs/STANDING-RULES.md`; `data/fs112/briefs/P112-planner.md`; `data/fs112/briefs/A112-advisor.md`; `CLAUDE.md` (my context held
the snapshot of e133253b, FS-110's close; the diff e133253b..96ea0744 read in full: § The aim link 2's print line, Theorem A's credit to `[Johnson1982]`
and `[Fischer1990]`, the ranking table with FS-113 at 8, G56's and G63's bridge credit to `[BendaPerles2000]`, G81's Soifer–Shelah clause; nothing in
G82, rows 131–134's pointers or the method rules changed); `LEDGER.md` header, claim list, rows 1–130 by headline, rows 131–134 in full;
`plans/STUB-unit-arc-half.md` (banner and body); `plans/STUB-reg-scale.md`, `plans/STUB-regular-half-residuals.md`, `plans/STUB-hole-dial.md`;
`plans/FS110-tangency-seam.md` §R-close (stages 3–4); `plans/FS110-derivation.md` in full (§§1–5); `data/fs110/claims.md` in full (§§0–9);
`plans/FS110-close-inventory.md` header and items 68, 78; `plans/POROS-2026-09-27-fs110-competition.md` § A4-1 (A4-SIX-ARCS, A4-TSU, A4-S1-ONE,
A4-BAND), § A5-5.6, § Stage A6-2 (A6-2.1–A6-2.4) and § Stage A6-3; `plans/PROTOCOL-competitor-and-advisor.md` §§0–1 (rule 12 read);
the print on the page, by `pdftotext -layout`, with journal page = printed page checked for each: `[Polymath2021]` pp. 190–201 in full
(`~/source/library/geombinatorics/geombinatorics-v30-n4-2021-04.pdf`, pdf pages 26–37), `[Parts2021]` pp. 177–182 and the wavy-side remarks of
pp. 186, 189 (same file, pdf pages 13–25), `[AxenovichEtAl2014]` §4 with Theorem 4.2's proof and Figure 4 viewed as an image
(`~/source/library/pdf/axenovich-2014-chromatic-number-subsets-euclidean-plane.pdf`, p. 8), `[Parts2020c]` pp. 27–28, 34, 37
(`geombinatorics-v30-n1-2020-07.pdf`), `[Kainen1992]` p. 35 (`geombinatorics-v02-n2-1992-10.pdf`).

### 1.2 Quotation check

| quotation (where it appears) | source | verdict |
|---|---|---|
| "My goal is to fully solve, and then verify in Lean, HN. Then we publish." (brief) | `CLAUDE.md` § The aim | verbatim (a prefix; the source continues "(Anything we do must be formalized …)") |
| "Let's see some ambition. I know we can do it." (brief) | `CLAUDE.md` § Counter-priors | verbatim (a prefix of a longer quotation) |
| "Looks like you've got plenty of context to coordinate another milestone or two. You're approved to continue." (brief) | Kooshi to the owner, 2026-09-27 | **not on disk** anywhere but the brief (`grep -rn` over `*.md`); taken as the owner quotes it |
| "does a tight six-map exist once boundary arcs of radius 1 are allowed?" (brief) | the stub's title line | verbatim |
| "the first question is which of the chain's steps survive unit arcs" (brief) | the stub, § What FS-110 leaves here | verbatim |
| "a YES by formula (0.03)" (brief) | the stub, § Registered expectations | verbatim |
| "search for a finite graph is out" (brief) | `CLAUDE.md` § Publication | verbatim (a prefix; continues "It would be huge, not feasible.") |
| rule 0's, rule 3's and rule 4's Kooshi quotations (STANDING-RULES) | `CLAUDE.md` § Counter-priors, § Toolchain, § Where the problem stands item 23 | verbatim |
| "It's ok if jobs overrun a bit. …" (rule 10) | `plans/CONSOLIDATION-2026-09-27.md` item 20 | verbatim |
| "to strengthen the seminal result of Thomassen [11]"; "(ii) the unit-radius tactic" (the stub's banner item 1) | `[Polymath2021]` p. 199 | verbatim. The whole sentence, for the claim list: "Our failure to discover 6-tilings of larger disks motivates hope that one might be able to strengthen the seminal result of Thomassen [11], who showed that the plane cannot be tiled with six colors if the distance between adjacent tiles of the same color is strictly greater than 1, i.e. we prohibit tilings in which either (i) some unit-diameter circle encloses two same-colored tiles, or (ii) the unit-radius tactic is employed. It may be possible to eliminate criterion (ii) via an exhaustive computer search of all possibilities, but this has, as yet, remained beyond our reach." |
| the tactic "defined on p. 194" (banner item 1, a paraphrase outside quotation marks) | `[Polymath2021]` p. 194 | the definition verbatim: "a tile T of color 1 can share a boundary segment E with a tile U of color 2 and also a point P with a tile V also of color 2, if E is drawn as an arc of radius 1 centered on P." The banner's gloss is faithful |
| "with the rounded boundary being a circular arc of radius 1 centered at the opposite corner of the tile" (banner item 2) | `[AxenovichEtAl2014]` p. 8, proof of Thm 4.2 | verbatim; height "√15/2 + √3 ≥ 3.668" verbatim in the statement |
| "an arc with a radius of 1 centered at the nearest corner of the adjacent tile to slightly reduce the distance between the tiles" (banner item 3) | `[Parts2021]` p. 181 | verbatim |
| "for m = 6, it is possible to reduce k from 31 to 29 (due to reduction of d by only 0.15%)" (banner item 3) | `[Parts2021]` p. 182 | verbatim |
| "a) vertices in which three or more colored tiles converge are disadvantageous (a void is superior to any such vertex)"; "d) the curving of pairs of opposite tile sides is optimized with a radius of 1/2" (banner item 3) | `[Parts2020c]` p. 37 | verbatim (the page breaks "curv-ing") |
| "radius-1 arcs bound only voids (p. 34)" (banner item 3, a reading outside quotation marks) | `[Parts2020c]` p. 34: "If we use only voids of type B, we get ρ6 ≈ 282.1748985451. In this case, the void boundaries are formed by arcs of radius 1."; p. 27: "A curved side always separates a tile from a void … A wavy edge always separates two tiles" | a fair reading of those two passages; the record-holding tiling's wavy edges are written as three segments (p. 34: "if each wavy edge is replaced by three segments"), so its unit arcs, where present, are void boundaries |
| "(2) CONJECTURE. The chromatic number of the plane is robust." (banner item 4) | `[Kainen1992]` p. 35 | verbatim |

### 1.3 Two findings of the quotation check, carried into the claim list

1. **Three prints, three different centres for "an arc of radius 1".** `[Polymath2021]`'s tactic centres the arc on a point `P` where a *second
   tile of the other side's colour* touches (a contact of two same-colour tiles `U`, `V` at distance exactly 1 along the whole arc);
   `[Parts2021]`'s wavy side centres it "at the nearest corner of the adjacent tile" of the same colour (the same kind); `[AxenovichEtAl2014]`'s strip
   centres it "at the opposite corner of the tile" — **the tile's own** corner, so the tile's own diameter is realised along the arc. A self-contact
   and a pair contact are different seams. The claim list names the three kinds (a definition, marked "(this list)") and asks each claim to say which
   it concerns. *(Corrected at stage 4 on the advisor's reading: the strip is self-contact by its words and, by `[Polymath2021]` p. 194, uses the
   tactic, so its pair contacts are read from its rebuild; FS-110's fragment S1 calibrates the pair kind locally. The claim list uses the advisor's
   colour-level kinds: in-, out-, both, inert.)*
2. **Polymath's question is about tilings "bounded by a closed curve"** (p. 191: "all colorings are tilings – that is, each point lies within a
   monochromatic region bounded by a closed curve"), and its hope is a *strengthening* of Thomassen (criterion (i) kept, (ii) eliminated). FS-112's
   Q-full keeps neither prohibition, so its NO is stronger than the hope within segment-and-arc maps and silent outside them, as the banner says.
   Its closing clause — "via an exhaustive computer search of all possibilities" — names the route this project's ban and Kooshi's ruling exclude; the
   plan answers it by derivation (§IQ).

## Stage 1 — SAVED

## Stage 2a — SAVED: §G part 1, the grokkings G1–G82 (WORKFLOW 3.1; `CLAUDE.md` read from disk at 96ea0744)

*One line per entry: **bears** (what it says about this milestone and the phase it changes), **silent** (why), or **falsifiable here** (registered
in stage 5). The milestone's object is a planar map — open tiles bounded by segments and circular arcs, unit arcs allowed — with a six-colouring
proper at almost every unit pair; no field, lattice or finite graph enters it. That one fact makes most of the arithmetic corpus silent, and the
reason is recorded once here rather than repeated: **(F)** "the entry is about unit-distance graphs over a field, lattice Cayley graphs, residue
planes or finite witnesses; the milestone's object is a map of `ℝ²` read almost everywhere".*

| G | verdict | reason, and the phase it changes |
|---|---|---|
| G1 field wall | silent | (F); the fragments' exact field (ℚ(√3), ℚ(√3,√15)) is a checker's arithmetic, not a wall |
| G2 construction grammar | silent | (F); a unit arc's centre is a ring-heart only in the loose sense that the arc lies on its unit circle — no rotated copy is involved |
| G3 radially crystal | silent | (F) |
| G4 one shell vocabulary | silent | (F) |
| G5 ownership factorization | silent | (F) |
| G6 hexagram is fabric | silent | (F) |
| G7 detuning, arithmetically | silent | (F); rotations of graphs, not boundary arcs |
| G8 direction group | silent | (F) |
| G9 rigidity at the forcing level | silent | (F); its "ask one rung below" has no map analogue the plan uses |
| G10 forcing is distributed | silent | (F) |
| G11 Moser-free five | silent | (F) |
| G12 quadrature law | silent | (F) |
| G13 fan ladder | **bears** | coverage is a k-set count at a centre, invisible to pair statements; FS-110's decisive count was at the *vertex* (NB-4's 60° squeeze), and NB-4's unit-arc exception is exactly a coverage failure at `ω(y)` (a `Γ`-arc through a change point of every ring orbit). → proof side, stage 1: at a four-colour vertex with unit arcs, count what the unit circles of the vertex and of the arc centres must cover, before any pair statement |
| G14 width without degree | silent | (F) |
| G15 pigeonhole × kill | **bears** | a NO is a class-level compulsion (Act One: some seam must occur) composed with kills; FS-110's failure clause "a list of seam kills with no Act One decides nothing" stands. Under Condition 5 the NO went round Act One (Woodall's merge → cubic map → S–V Cor. 1, whose own pigeonhole is on one circle). → proof side: name which frame each step lives in; claim list keeps C-ACT1 |
| G16 distance-2 pigeonhole | silent | (F) |
| G17 globality at the top rung | **falsifiable here** | predicts every unit-arc seam is realisable as a local fragment (FS-110 realised S1, T2, BB, MX, WC, A6-C2) and the obstruction, if any, is global; killing test: a seam with no tight local fragment by formula. → construction side's per-seam fragments; registration |
| G18 composition over search | silent | SAT |
| G19 5-tight fabric | silent | (F) |
| G20 brick colourings | **bears** | "use the exact certificate, never strict separation": a tight map has same-colour closures at distance exactly 1 along whole arcs, so every checker must treat distance exactly 1 at boundaries as allowed and distance 1 between interiors as refused. → checkers' calibration also accepts the tight hexagonal seven-colouring (row 33's control) |
| G21 a negative measures its enumeration | **bears** | every refusal of a formula family measures that family's image; a checker's refusal is believed only after it accepts the strip (the brief) and a tight seven-colouring; each registration states its population (the stub's 0.03 was registered on no population). → registrations (stage 5), checkers, every verdict's headline |
| G22 where a six-colouring cannot live | **bears** | polygonal colourings need seven (row 132), and under Condition 5 so do segment-and-arc maps (row 134); a YES therefore has curved tiles **with unit arcs**, tiles of diameter ≤ 1. → construction side: no candidate without a unit arc is built |
| G23 refining is no route down | silent | cell family |
| G24 gap law | **bears** | the step to seven is integrality: per-class density arguments stop below 4.37 (row 129, K-INT). → proof side: no argument that reads one class at a time; a NO uses how classes fit (link 3) |
| G25 forcing ladder recursive | silent | (F), a reading about finite forcers |
| G26 6-forcer reduction | silent | (F) |
| G27 hidden arithmetic symmetry | silent | (F) |
| G28 fine-tail forcing factors | silent | cell family |
| G29 cell family is closed | silent | nothing is spent on it |
| G30 measurement generates, derivation kills | **bears** | fragments by formula generate candidates; the NO and every seam kill are derivations; name the room: planar map colouring with curved boundaries (Woodall, Townsend, Thomassen, S–V), one room past FS-110's; prefer dials. → phase design: fragments are instruments, never verdicts on Q-full |
| G31 held witnesses carry nothing | silent | (F) |
| G32 two-distance dial | silent | (F) |
| G33 batches compose | silent | descent |
| G34 the field is the selection | silent | (F) |
| G35 the wall is 2-adic | silent | (F) |
| G36 residue colouring canonical | silent | (F) |
| G37 endgame's shape | silent | (F) |
| G38 linear thresholds | silent | (F) |
| G39 redundancy before rigidity | silent | (F) |
| G40 absorption | silent | (F); a map has no spare-colour hanging copy |
| G41 additive yardstick | silent | (F) |
| G42 additive rigidity | silent | (F) |
| G43 residue plane seals | silent | (F) |
| G44 Kloosterman control | silent | (F) |
| G45 lifts only shadows | silent | (F) |
| G46 recognize the classical theory first | **bears** | the object is a map colouring in Woodall's and Townsend's sense with Polymath's "unit-radius tactic"; its classical tools are Woodall's steps 2, 3, 5, S–V's Props. 7–19 and Cor. 1, Townsend's lemma, Thomassen's argument; and "read the implementation's data layout": the frozen checkers' tile records (arcs with centre, radius, orientation) decide what a fragment can express. → §PA's vocabulary; briefs name the classical chain first |
| G47 compulsion face of sealing | silent | (F) |
| G48 tightness mechanism | silent | (F); "tight" here is D-SLACK's, never G48's or Hoffman's |
| G49 prior-art gate | **bears** | search in the discipline's words ("wavy sides", "arc of radius 1", "unit-radius tactic", "map colouring", "Siamese"), under two disciplines (planar tilings; geometric measure theory), the zbMATH API for discovery, the held Polymath threads and Geombinatorics catalogue by their own words. → §PA (stage 3) |
| G50 read what the search found | **bears** | FS-110's miss was `[Woodall1973]` §3 unread until round 3; here Woodall §§1–2 (statements only read), `[Coulson2004]`'s figures, Townsend's (c) and `[Thomassen1999]`'s tactic-free hypothesis must be read at the opening, not in round 3. → §PA and the side briefs' reading lists |
| G51 competitor and advisor | **bears** | the shape (a proof side, a construction side, blind verifiers, a competition advisor) paid in FS-110's four rounds; count retractions; hand-backs content-free. → staffing (stage 5) |
| G52 wall necessary, not sufficient | silent | (F) |
| G53 counting compulsion | silent | (F); A4-SIX-ARCS is a count of arcs, derived without it |
| G54 tight or slack | silent | spectral; naming hazard only ("tight" in D-SLACK's sense) |
| G55 unit-vector ring | silent | (F) |
| G56 window for six | silent | (F) |
| G57 triangle-free window | silent | (F) |
| G58 antipodal conjecture | silent | finite planes; not FS110-CE5's Antipodal Lemma, which is a map statement (a naming hazard, recorded) |
| G59 wall at six | silent | (F) |
| G60 fractional reach | **bears** | a YES candidate's classes each have density at most `m₁(ℝ²) ≤ 0.2470` (row 129's input), a cheap exact necessary check (FS-110 killing test 7); one-class arguments give no six. → checkers compute class densities |
| G61 three colours break at arithmetic | silent | (F) |
| G62 twisted bilayer | silent | (F) |
| G63 transcendence is free | silent | (F) |
| G64 six may be no field's value | **bears** | never read "six skipped" as evidence for seven; a YES with five colours is a different outcome (`χ(ℝ²) = 5`); a belief in seven prices nothing. → registrations and report language |
| G65 refusal phase diagram | silent | SAT, banned |
| G66 residue tower | silent | (F) |
| G67 grokked by form | **bears** | every claim and killing test in the claim list, every brief instruction, written with its trigger and its falsifier or what it forbids. → claim list, briefs |
| G68 quotient before ball | silent | (F) |
| G69 rigidity is arithmetic | silent | (F) |
| G70 √3-clean is residue | silent | (F) |
| G71 three colours linear; the index | **falsifiable here** | row 132's index of density traces fails only at a swap, "which a unit-arc interface facing a bowtie forces: Condition 5 buys general position, not the height" — dropping Condition 5 brings back exactly that interface; FS-110 left "fails only at a swap" untested at the bowtie (removed by NB-5). Killing test: a bowtie seam with unit arcs that defeats the index with no swap. → proof side's winding stage; registration |
| G72 the invariant question | **bears** | §IQ (stage 3): the structural form about every tight six-map at a unit-arc centre; G72's count at the close |
| G73 four colours cell by cell | silent | its no-gos concern lattice Cayley graphs, whose loop invariants the graph fixes; a map's ring winding reads a continuum circle (FS-110's apparatus), another object |
| G74 layers | silent | (F) |
| G75 triangles pin the spectrum | silent | (F) |
| G76 four-colour rigidity over a field | silent | (F) |
| G77 character colourings local | silent | (F) |
| G78 rank one; Kempe blind to frozen walls | silent | (F) |
| G79 example invariant | **bears** | FS-110's walls here are counterexample invariants (YB3-SAME: what a same-type edge would have to do; NB-4's exception: what a four-colour vertex needs); the flip asks what every tight map with a unit arc carries at the arc's centre. → §IQ; the proof side's first stage |
| G80 infinite rank | silent | (F) |
| G81 the field is the plane | silent | it gives the answer's meaning given MR (a NO with FS-111 is `χ(ℝ²) = 7` given MR), not a tool for the work |
| G82 stability; regular refutation | **bears** | its *Do*: "where the limit object is a map, look first for the printed regular theorem's own chain (FS-110: S–V's Cor. 1 and Woodall's step 3, made curved and almost everywhere)" — here, which steps of that chain survive unit arcs is the stub's first question; price a certificate at its feature's scale (at bounded `K`, `≥ 1/K`), never at `ε`'s. → proof side's stage 1 walks the chain step by step |

**Count:** 19 bear or are falsifiable here (G13, G15, G17, G20, G21, G22, G24, G30, G46, G49, G50, G51, G60, G64, G67, G71, G72, G79, G82); 63 silent
(G81 among them, bearing only on the answer's meaning), most by (F). The provisional bearings of the stub (G82, G79, G51, G21, G71, G13, G50) are all
confirmed; added: G15, G17, G20, G22, G24, G30, G46, G49, G60, G64, G67, G72.

## Stage 2a — SAVED

## Stage 2b — SAVED: §G part 2 (rows 1–134; the method rules) and part 3 (the extraction)

### §G part 2a — `LEDGER.md` rows (rows 131–134 in full; rows 1–130 by headline; (F) as in part 1)

- r1 silent — circles of radii 1 and 1/√3 about one point, a graph; a map vertex's ring is another object
- r2 silent — seam group (F)
- r3 silent — coverage monotone in edges (F)
- r4 bears — fan ⟺ coverage: the count at a centre (with G13), proof side stage 1
- r5 silent — class geometry (F)
- r6 silent — 120° identity (F)
- r7 silent — greedy colouring
- r8 silent — de Grey's balance
- r9 silent — a two-circle compulsion (F)
- r10 silent — one-pivot cap (F)
- r11 silent — the strip automaton is a graph tube, not a geometric strip
- r12 silent — tools (F)
- r13 silent — negative knowledge (F)
- r14 silent — pair gluing (F)
- r15 silent (F)
- r16 silent (F)
- r17 silent — two circles meet in {point, mirror}: elementary geometry the bicycle uses, nothing more
- r18 silent (F)
- r19 silent (F)
- r20 silent (F)
- r21 silent (F)
- r22 silent (F)
- r23 silent (F)
- r24 silent (F)
- r25 silent (F)
- r26 silent (F)
- r27 silent (F)
- r28 silent (F)
- r29 silent (F)
- r30 silent (F)
- r31 silent — Act One in the kernel for graphs; its shape is G15's
- r32 silent — hex-shell pigeonhole for graphs (F)
- r33 bears — the hexagonal seven-colouring, a tight map (boundary-tight by force): the checkers' second positive control
- r34 silent — cell family
- r35 silent — cell family
- r36 silent — cell family
- r37 silent — cell family
- r38 silent — cell cores
- r39 silent — cell family
- r40 silent — closed classes need seven (row 132 carries it)
- r41 silent — limit lemma for graphs
- r42 silent — arity floor (F)
- r43 silent (F)
- r44 silent — the spindle theorem (F)
- r45 silent (F)
- r46 silent (F)
- r47 silent (F)
- r48 silent (F)
- r49 silent (F)
- r50 silent (F)
- r51 silent (F)
- r52 silent (F)
- r53 silent (F)
- r54 silent (F)
- r55 silent (F)
- r56 silent (F)
- r57 silent — Theorems A and B (F)
- r58 silent (F)
- r59 silent (F)
- r60 silent (F)
- r61 silent (F)
- r62 silent (F)
- r63 silent (F)
- r64 silent (F)
- r65 silent (F)
- r66 silent — the fan gap (F)
- r67 silent (F)
- r68 silent (F)
- r69 silent (F)
- r70 silent (F)
- r71 silent — fractional over a field (F)
- r72 silent (F)
- r73 silent (F)
- r74 silent (F)
- r75 silent (F)
- r76 silent (F)
- r77 silent — the theorem audit's method is G21's
- r78 silent (F)
- r79 silent — heights at three colours (F); G71 carries the index
- r80 silent — lattice cells (G73)
- r81 silent (F)
- r82 silent (F)
- r83 silent (F)
- r84 silent (F)
- r85 silent (F)
- r86 silent (F)
- r87 silent (F)
- r88 silent (F)
- r89 silent (F)
- r90 silent (F)
- r91 silent (F)
- r92 silent (F)
- r93 silent (F)
- r94 silent (F)
- r95 silent (F)
- r96 silent (F)
- r97 silent (F)
- r98 silent (F)
- r99 silent (F)
- r100 silent (F)
- r101 silent (F)
- r102 silent (F)
- r103 silent — chain theorem (F)
- r104 silent (F)
- r105 silent (F)
- r106 silent — stripe lemma on the triangular lattice (F)
- r107 silent — the bridge (F)
- r108 silent (F)
- r109 silent — the mixing selection (F)
- r110 silent (F)
- r111 silent (F)
- r112 silent (F)
- r113 silent (F)
- r114 silent (F)
- r115 silent (F)
- r116 silent (F)
- r117 silent (F)
- r118 silent (F)
- r119 silent (F)
- r120 silent — MR (F)
- r121 silent (F)
- r122 silent (F)
- r123 silent (F)
- r124 silent (F)
- r125 silent (F)
- r126 silent (F)
- r127 silent — kernel, conditional (F)
- r128 bears for the answer's meaning only — a NO with FS-111's (B) gives χ_m⁰ = 7, hence χ(ℝ²) = 7 given MR (report language)
- r129 bears — each class ≤ m₁(ℝ²) ≤ 0.2470, and one-class arguments stop below 4.37: the class-density check (G60) and the ban on per-class NO arguments (G24)
- r130 bears — χ_CP = χ_m⁰ with no MR: a YES tight map is a χ_m⁰ six-colouring, so χ(ℝ²) ≤ 6 through link 2 (report language)
- r131 bears — the stability equivalence; its no-gos (hole-counting at circles capped at O(ε); trichromatic-point arguments blind to partial colourings) bind any NO that is later made quantitative
- r132 bears — the regular half: polygons, convex tilings, nice maps need seven; maps need six (Woodall, Townsend), the floor Q-full cannot go below; hole-filling fails exactly at bichromatic vertices of degree ≥ 4, and the index fails where a unit-arc interface faces a bowtie — the two places this milestone reopens
- r133 bears — W-EQ-K turns a YES at bounded K into χ(ℝ²) ≤ 6 with no MR; W-TAN (close complementary pairs are tangent pairs or bowties, a GAP at cusps, closed by FS110-CUSP-K); W-POLY; R-SW's s³ swap price; HX-STALL
- r134 bears — the Condition-5 chain whose survival is the stub's first question; its Not claimed clause is this milestone's object; its fragments (S1, T2, BB, MX, WC, A6-C2) are the construction side's starting kit

**Rows count:** 8 bear (r4, r33, r129–r134; r128 for the answer's meaning only), 126 silent.

### §G part 2b — the method rules (`CLAUDE.md` § The standard of evidence, § What compute helps, § Toolchain, § Building, § Searching, § The gate, § Make the gate fail; § Delegation)

| rule | verdict | what it changes |
|---|---|---|
| no native evaluation in a headline | silent | no kernel claim is planned; the close's kernel decisions follow FS-110's ("the map argument in Lean", a stub) |
| the artifact is the certificate plus the checker | **bears** | a YES or a fragment is committed as its formula plus an exact checker a reviewer reruns; never a search log |
| the witness is independently re-derivable | **bears** | fragments are stated as constructions (centres, radii, the rule that fixed each), not coordinate lists alone |
| read the final statement aloud | **bears** | Q-full against `[SokolovVoronov2025]` Question 2's words and `[Polymath2021]` p. 199's; both are quoted in the claim list |
| report the hunt honestly | **bears** | a family that refuses is reported with its image (G21) |
| write the certificate for the reviewer early | **bears** | per seam: "what must someone who trusts none of this check?" asked at the side's stage 1 |
| order verification by marginal value | **bears** | the checkers run the discriminating exact checks (same-colour pairs whose range contains 1) before the slow float guards |
| kernel leaves priced high; GPU is not SAT | silent | no kernel work; no solver |
| the ban and "would have searched here" | **bears** | every brief carries the ban's in/out lists and the log |
| symmetry break before SAT | silent | no SAT |
| Python 3.14 `forkserver` | **bears** | any `tools/fs112_*` using multiprocessing passes the `fork` context or an initializer (none expected) |
| two machines; physical cores | silent | exact checks of seconds |
| `scripts/build.sh` only; `lake env lean` is not the gate | silent | no Lean is built |
| RAM is the discriminator (`scripts/slot.py`) | **bears** | a check over ~2 GiB or ~2 min runs under the slot; none is expected |
| checkpoint and resume (PROTECTED) | **bears** | agents' records save per stage and commit (standing rule 2); no single tool runs 15 minutes |
| a blocking run is killable; kill by pid | silent | no long runs planned |
| a pipe can kill the producer | **bears** | tools' exit statuses read directly in the briefs' check commands |
| never edit a running script | silent | — |
| generated modules; the kernel's cost model | silent | — |
| `grep -E` is ugrep; `rg` hides `build/` | **bears** | counts of verdict lines in checker output by `grep -F` or Python, never an alternation under `grep -E` |
| a failed `exact?` is not an absence | silent | — |
| vacuity: a theorem over an empty domain | **bears** | every statement about a tight six-map is about a possible object; the claim list's header says so (FS-110's wording) |
| every definition has an example | **bears** | each defined term in the claim list names an instance (the strip for the self-contact unit arc; T2 for the rhombus; A6-C2 for the doubly shadowed horn) or says none is held |
| negative controls at every milestone | **bears** | each new tool plants a fault and watches it fire for its own reason (standing rule 7) |
| a positive signal for what did not happen | **bears** | a checker prints the number of pairs it examined and the number it could not decide; "no refusal" with zero pairs examined is a failure |
| a waiter's condition false at arming | silent | no waiters |
| state the uninformative outcome and confirm it reachable; both outcomes reachable | **bears** | every registration in stage 5 names both outcomes and why each can occur |
| pre-decide the response to your own gate failing | **bears** | the construction side writes, before its first fragment, what it does if the strip is refused (the checker is wrong, not the strip) |
| replacing a broad instrument loses coverage | **bears** | new `tools/fs112_*` checkers state what the frozen FS-110 checkers see that they do not |
| a number in a ruling carries its units and population | **bears** | `[Parts2021]`'s saving is two colours at `m = 6` in a multi-fold problem, one case in `m ≤ 2000`; it is not a saving at `m = 1` |
| exactly one thing may differ between compared numbers | **bears** | the strip versus the plane differ in the region and in the closure rule at the strip's edges; neither is a six-colouring of the plane |
| a red control is evidence only with its wrong-reason red named | **bears** | each plant's firing reason is stated before it runs |
| a measured half and a derived half fail in opposite directions | **bears** | in an exact tile checker the pairs are derived (every tile pair's distance range, computed), so a missed pair makes an ACCEPT easy: **for a YES the ACCEPT is the suspect verdict** (FS-110's X17); a checker must count the tile pairs it examined against the pairs the map has |
| a check reads the value the code ships | **bears** | tolerances and radii read from the tool's own definitions, not copies |
| the failure path's formatting is part of the check | **bears** | verdict lines print exact values, not rounded ones |
| bound a plant's effect on both sides | **bears** | plants assert the refused pair's distance range contains 1 and that the unplanted twin's does not |
| replay policies over recorded decisions; cost on a failing run | silent | — |
| a caveat stepped over | **bears** | every fragment's headline says "a local fragment, not a map" (FS-110's scope line) |
| count the generator's free parameters against the problem's | **bears** | each formula family states its free parameters against the local configuration's degrees of freedom (arc centres, radii, contact points) |
| a true explanation stops the search for a second | **bears** | a fragment refused for one reason is checked against every claim's hypotheses before it is used as a test case |
| a mutation harness verifies its restore; mutate the constant | **bears** | plants restore and re-verify; one plant mutates a radius constant |
| archiving a checker can break it (two versions by name) | **bears** | a new tool importing a frozen FS-110 checker asserts the imported module's path and digest |
| enumerate the parameter first | **bears** | enumerate the kinds of unit-arc contact (by where the arc's centre lies) before screening fragments of any one kind |
| a positive control proves only shapes its generator can represent | **bears** | the strip calibrates the self-contact kind only; an ACCEPT of the strip says nothing about the pair kind (§1.3) |
| a one-sided filter's inapplicability | **bears** | a checker's "not applicable" (uncovered area, an arc it cannot parse) is never a pass |
| scars, not foresight | **bears** | plants are routine, not argued |
| delegation one level deep | **bears** | every brief says so, with the reason |

### §G part 3 — the extraction: each *bears* as an instruction to a phase (carried into stage 5's phase table and the briefs)

1. **The chain walk first (G82, r134, the stub).** The proof side's stage 1 takes the Condition-5 chain — NB-4, NB-5, W-MERGE (with N3-CONF, N3-DEG),
   N4-SHADOW, N4-SHAVE, N4-STUCK, N4-FIN, N4-TERM, FS110-COR1-NOD2 with CB-LEMMA3 and CE5–CE6, FS110-CUSP-BASE — and gives each step one verdict with
   unit arcs allowed: survives as written; survives off the arcs' centres with the exception named; fails, with the configuration. The first break is
   the milestone's first result either way.
2. **Count at the vertex, not the pair (G13, r4).** At a vertex that is a unit-arc centre, or lies on a unit arc, the proof side writes what its ring and
   the rings of the arc's centres must cover before any pair statement (NB-4's exception is a coverage statement).
3. **No per-class arguments (G24, G60, r129).** A NO never reads one class at a time; the checkers compute each class's density on a periodic candidate
   and refuse above 0.2470.
4. **Act One is kept (G15).** The claim list keeps C-ACT1; a side that proves seam kills states whether its route needs Act One or goes round it, as
   the Condition-5 chain did.
5. **Local fragments first, and expected (G17).** The construction side realises each unit-arc seam as a tight local fragment by formula; the
   registration that every one is realisable is G17's test.
6. **Curved with unit arcs, or nothing (G22).** No construction-side candidate without a boundary arc of radius 1 is built: row 134 refutes it.
7. **Calibration before refusal (G20, G21, r33, the brief).** Every new exact checker ACCEPTs the strip (`[AxenovichEtAl2014]` Thm 4.2, rebuilt by
   formula) and a tight seven-colouring fragment before any REJECT is believed, and names the contact kind each calibration covers (§1.3).
8. **The index at the bowtie (G71, r132).** The proof side's winding stage tests "fails only at a swap" at a bowtie seam with unit arcs; a no-swap
   defeat of the index is the killing test.
9. **The flip (G79, G72).** §IQ asks what every tight map with a unit arc carries at the arc's centre; the proof side's first derivation after the
   chain walk answers it or names why it cannot.
10. **Classical tools named first, read at the opening (G46, G49, G50).** The side briefs list `[Woodall1973]` §3 (steps 2, 3, 5), S–V Props. 7–19 and
    Cor. 1, `[Townsend2005]`, `[Thomassen1999]`, `[Coulson2004]` with their reading status, and the prior-art job, if any, reads what §PA leaves unread.
11. **Staffing (G51).** A proof side against a construction side, a blind verifier per side, a competition advisor; retractions counted.
12. **Registrations (G64, G21, the method rules).** Each states its population and both reachable outcomes; none reads "six skipped" as evidence.
13. **Form (G67).** Every claim, killing test and brief instruction carries its trigger and its falsifier or what it forbids.

## Stage 2b — SAVED

## Stage 3 — SAVED: §PA (the prior-art gate) and §IQ (the invariant question)

### §PA — searched 2026-09-27 by the planner (zbMATH Open API for discovery; OpenAlex citing lists; Semantic Scholar for one abstract, then rate-limited; full text of the 55 held Geombinatorics issues and the held Polymath16 threads by `pdftotext`/`grep`; raw outputs in `data/fs112/fs112-p/*.json`)

**The recognition sentence (G46), used as the query.** FS-112's object is a planar map colouring in Woodall's, Townsend's and Thomassen's sense, with
the one feature Thomassen's theorem excludes twice: a tile of diameter exactly 1 whose own diameter is realised along a boundary arc of radius 1
(`[Thomassen1999]`'s faces have "diameter less than 1"), and two same-colour tiles at distance exactly 1 along such an arc (his colour classes are at
"distance … greater than 1"). Polymath16's name for the second is "the unit-radius tactic" (`[Polymath2021]` p. 194), Parts's "wavy sides"
(`[Parts2021]` p. 181), and in the 2018 threads "arcs of unit radius" and "Reuleaux arcs"; the first is the shape of `[AxenovichEtAl2014]`'s strip
tiles and of what Philip Gibbs called a "constraint" (below). In the neighbouring discipline these are **sets of diameter exactly 1 and pairs at
distance exactly 1**, whose boundaries are unit arcs — the ball-polygon (spindle-convexity) vocabulary FS-110 recorded as PA-1.

| # | question (WORKFLOW 3.2) | what was done | finding |
|---|---|---|---|
| 1 | the discipline's words | zbMATH: `ab:"radius 1" & ab:colo* & ab:plane` (4 hits, none on topic); `ab:"unit circle" & (ab:map \| ab:tiling \| ab:tiles) & ab:colo*` (15; one on topic, `[SokolovVoronov2025]`); `ab:Siamese & ab:colo*` (3, none); `ab:"chromatic number of the plane" & (ab:tiling \| … \| ab:regions)` (7); `ab:strip & ab:"unit distance" & ab:colo*` (1); `ti:"chromatic number of the plane" & py:2019-2026` (11) | Nothing in the reviews database states, asks or answers a map-colouring question with unit arcs beyond `[SokolovVoronov2025]` Question 2 (held; FS-110's gate). **Kruskal 2008** (FS-110's debt: "title only"): abstract now read (Semantic Scholar record): two- and three-colourings of bounded regions ("a square is 2-colorable if and only the length of a side is =<2/5") — **silent for six-maps; the debt is retired**. `[Soifer2025]` (held, Zbl 1569.05108): its review names the X₆ confirmation (FS-109's), nothing on maps. `[Oostema2020]` (Coloring unit-distance strips using SAT; abstract read, OpenAlex): strips tiled by squares and hexagons, a search — no unit arcs, no bearing beyond the strip literature |
| 2 | two disciplines | (i) planar map colourings × (ii) sets of diameter or distance exactly 1 (ball polygons, Reuleaux sets; FS-110's `reuleaux.json`, `spindle*.json` queries reused, not rerun) | **PA-2 (a recognition, not prior art): the three prints' unit arcs are the three ways a boundary arc can be forced onto a unit circle in a tight map** — a tile's own diameter (self kind: the strip; Gibbs's "constraint"), two same-colour tiles at distance exactly 1 (pair kind: Polymath's tactic, Parts's wavy sides), and a Siamese pair's union of diameter exactly 1 (Polymath's criterion (i)). Thomassen's hypotheses exclude all three (faces of diameter `< 1`, classes at distance `> 1`). No work joins (ii)'s theorems to colourings (FS-110's finding stands) |
| 3 | the question, not only the method | the held Polymath16 threads (`~/source/library/notes/polymath16-threads-1-18-text.txt`, 300,535 words) grepped for "radius 1", "unit radius", "wavy", "arc(s) of radius", "curved", "circular arc", "Reuleaux" (83 hits; the tiling hits concentrated in threads 6–9, June–July 2018, and 16, the paper's writing) | **The question was worked, informally, in 2018.** Threads 6–9 searched for six-tilings with unit-arc boundaries; verbatim, Bernhard Hockertz: "One thing all of these efficient tilings have in common is that they have a boundary defined by straight lines or unit distance arcs. So far all possible tesselations that use some other kind of boundary can be reduced to one using only straight lines and unit radius arcs." and "The curvature of the boundary is limited to arcs with radius of unit distance or greater, because every arc with a radius that's smaller than 1 can be filled up to radius 1 without increasing the exclusion zone." Aubrey de Grey (ag24ag24), at a vertex of valency ≥ 4: "If B is a pentagon there must be another cell C touching B with the same colour as A. This necessitates an arc of radius one between B and C joining vertices W to U." and, at a six-colour vertex: "those six tiles must jointly cover a disk of radius 1 centred on V, and the boundaries between them must meet the edge of that disk at the vertices of a regular hexagon. Thus, each tile must lie entirely within the Reuleaux triangle defined by its vertices." Philip Gibbs: "The definition of a constraint I am using is that it is a relationship between an edge and a vertex of the same tile that requires the edge to be an arc of unit radius centred on the vertex." These are blog statements, everywhere-proper, unproved; `[Polymath2021]` p. 199 is their published residue ("It may be possible to eliminate criterion (ii) via an exhaustive computer search of all possibilities, but this has, as yet, remained beyond our reach"). **Read by grep only — a debt (G50)** |
| 4 | outside arXiv | all 55 held Geombinatorics issues in full text (27 have no text layer: XXV(2)–XXIX(1) image scans and the XXX(2)–XXX(3) printouts — the search's blind spot, named) | 5 issues carry the phrases: `[Parts2020c]` (XXX(1)) and XXX(4) (`[Parts2021]`, `[Polymath2021]`), all read at stage 1; `[Parts2022]` (XXXI(4), p. 190): the band triangle argument ("there is a point A whose ε-neighbourhood contains three colors 1, 2, 3. On a circle of unit radius centered at point A, there is a point B whose ε-neighborhood contains two other colors 4, 5") — the band form of C-T-TAN's pigeonhole, which at `ε = 0` fails exactly where `B` sits on a unit arc; XXXII(2) and XXXV(3): off topic (a "wavy edges" hope for 7-chromatic bounds; unit-radius spheres). The image-scan issues are unsearched |
| 5 | the poser's citation graph | OpenAlex: `[Thomassen1999]` (7 + 1), `[AxenovichEtAl2014]` (9), `[Coulson2004]` (5; FS-110's debt, now run), Kruskal 2008 (7); `[Polymath2021]` is in no citation index found (Geombinatorics is not indexed by OpenAlex; the Semantic Scholar search was rate-limited, 429) | Thomassen's: nothing new since FS-110 (Ágoston 2025 now read at abstract level: "We prove that with these restrictions, the chromatic number of any sphere with a large enough radius is at least 8" — nice colourings, silent on unit arcs). Axenovich's: strips and layers (Kanel-Belov et al., infinitesimal layers; Oostema 2020; Alm–Manske 2013); none a six-map. Coulson's: Manta 2021 (held), Alm–Manske, a 2009 Auburn thesis (A. Boronska, *The Chromatic Number of the Euclidean Plane*, title only), arXiv:1507.00025 (junk, `BIBLIOGRAPHY.md` l. 674), a 2014 planar-graph paper (off topic) |
| 6 | open every neighbouring citing work | abstracts read for Kruskal 2008, Ágoston 2025, Oostema 2020; the Boronska thesis not opened | none states or answers the unit-arc question |
| 7 | two databases | zbMATH and OpenAlex; Semantic Scholar once (Kruskal's abstract), then 429 | OpenAlex gave the citing lists zbMATH cannot; zbMATH gave Soifer 2025's review; neither indexes `[Polymath2021]`'s citers — a limit of both, not a zero |
| 8 | full author listings in the question's vocabulary | the posers' listings were run at FS-106–FS-110 (Woodall, Townsend, Coulson, Voronov, Parts); the question's own words run here in every held Geombinatorics issue and every Polymath16 thread | nothing further |

**What the gate changes in the plan.** (a) The claim list defines the three unit-arc kinds (PA-2) and quotes Polymath's p. 194 and p. 199 and
Thomassen's hypothesis verbatim. (b) **A reading phase before the sides start**: Polymath16 threads 6–9 read in full for their six-tiling
arguments (Hockertz's reduction to straight lines and unit arcs is an unproved claim about exactly this milestone's object; de Grey's degree-4 and
six-colour-vertex arguments are everywhere-proper sketches of FS-110's NB-4 kind), with verbatim extracts filed for both sides — G50's rule,
applied at the opening this time (FS-110 read Woodall §3 in round 3). (c) Both side briefs carry Thomassen's hypothesis verbatim, so that a side
proving "no nice-type" statement knows it has proved Thomassen again. (d) Novelty wording: the question is Polymath16's (2018 threads, 2021 paper)
and S–V's (Question 2); an answer is "not found in print".

**Papers still needed (for the report):** none blocks the opening. Reading debts: Polymath16 threads 6–9 in full (held); `[Coulson2004]`'s figures
(held, "figures not viewed"); the Boronska thesis (Auburn 2009, title only, `etd.auburn.edu/bitstream/10415/1844/1/Anna_Boronska.pdf`); the 27
image-scan Geombinatorics issues (held, unsearchable without OCR). **Proposed `BIBLIOGRAPHY.md` rows:** Kruskal 2008 → "abstract read (FS112-P):
two- and three-colourings of bounded regions; silent on six-maps"; Ágoston 2025 → title and authors verified (OpenAlex: *A Lower Bound on the Number of
Colours Needed to Nicely Colour a Sphere*, DCG, doi 10.1007/s00454-025-00736-3), abstract read; `[Oostema2020]` (P. Oostema, R. Martins, M. J. H. Heule,
*Coloring Unit-Distance Strips using SAT*, EPiC 73 (2020) 373–389, doi 10.29007/btmj; abstract read); Boronska 2009 (title only); Polymath16 threads
6–9 → "grepped for unit arcs (FS112-P); unread in full".

### §IQ — the invariant question (WORKFLOW 3.3)

1. **The existence form.** Is there a tight six-map with unit arcs — a locally finite map bounded by segments and circular arcs, arcs of radius 1
   allowed, six-coloured with no two interior points of one colour at distance exactly 1 (Q-full)?
2. **The structural form.** *For every tight six-map of that class and every boundary arc of radius 1 in it, what must hold at the arc's centre?* —
   which colours the centre `P` carries (`P_cl(P)`), where the arc's two side colours sit in the wedges at `P`, and **whether each unit arc forces
   another** (at its end vertices, or on the unit circles of `P`'s partners), so that unit arcs come in chains or cycles — the way a Woodall cone under
   Condition 5 forced a stuck vertex at unit spacing along its normal line (N4-PROP). Posed for every tight map at once, by derivation; the class
   is the widest where the question is defined (locally finite, curved, almost everywhere), with no complexity bound (row 134's chain used none).
3. **The invariant it forces: none named in print or in this project.** Three candidates, each a reading with its killing test, handed to the proof
   side as starting points, not results:
   - **(a) The centre's wedge profile.** TS-U, read conditionally (A4-TSU): if the centre carries a side colour `c`, the `c`-tiles face the arc and
     the side cones are empty of both side colours. *Killing test:* a tight fragment whose unit-arc centre carries a side colour in a side cone.
   - **(b) The arc budget of a four-colour vertex.** A4-SIX-ARCS: a four-colour vertex **"with no covering pair (v, y), y ∈ ω(v)"** carries boundary
     unit arcs *centred at itself* of total length `≥ 60°`, or at least six; on the other branch the arcs sit on `ω(σ_v^{±1}y)`, centred at ring points
     at distance 1 (NB §2.3). *(Corrected at stage 4: the first draft dropped A4-SIX-ARCS's hypothesis and wrote "four-colour vertices are unit-arc
     centres" — a standing-rule-5 slip, caught by FS112-A.)* On the first branch, four-colour vertices are unit-arc centres, and NB-4's exception and the
     unit arcs may be one object (the advisor's C-SEAMS-TWO). *Killing test:* a tight four-colour vertex with fewer than six unit arcs centred at it and less than
     `60°` of them (it would refute A4-SIX-ARCS, one mind).
   - **(c) Propagation with a monotone quantity.** As in N4-FIN, each unit arc's end vertex forces a further unit arc at a controlled position, and
     a bi-infinite chain contradicts a monotone quantity (curvature, turning angle, or the centre's facing wedge). *Killing test:* a closed cycle of
     unit arcs realised as a tight local fragment by formula (a cycle needs no infinite chain).
   G79's flip, stated: row 134 read the invariant every four-colour vertex carries under Condition 5 (each colour squeezed into 60° of the ring);
   the squeeze fails exactly where the ring meets a unit arc, so the question is what the squeeze becomes on the arcs — (b) is its first form.
4. **Its route.** Derivation only. The construction side's fragments by formula check derived claims (a cycle of unit arcs, a four-colour centre);
   they never answer the structural form.
5. **The open instances it would decide.** Y2-S1i's GAP (both side colours cusps at `u`); C-T2 (ii) (can a whole tight map use the double unit-arc
   seam wherever it needs one); NB-4's exception (A4-SIX-ARCS); YB3-SAME (`W` across a same-type edge — *corrected at stage 4: a Condition-5 statement whose event has no unit arc,
   so no bearing on Q-full; kept last, for one exact fragment*);
   FS-110 item 68 (Y3-SIX at bowties, the eight-arc aligned ring, a generic `|W| = 3` ring at one vertex); Y-BIKE-3C's corner GAP (A4-BAND's
   cross-swap); `[Polymath2021]` p. 199's hope (criterion (ii) eliminated); and, beside the milestone, whether the strip's self-contact pattern can
   close up in the plane.

## Stage 3 — SAVED

## Stage 4 — SAVED: the fixed claim list (`data/fs112/claims.md`) and the advisor's first advice

**The claim list** (statements only; ids): §0 definitions, with **the four contact kinds at a unit arc's centre** (in-, out-, both, inert; "self" the
same-tile case of in-contact) and `[Thomassen1999]`'s hypothesis verbatim; §1 **Q-full**, **Q-full_K**, the question in print twice (S–V Question 2;
`[Polymath2021]` p. 199 with p. 191's class), **Q-rule** with the (S1)/(S2) dichotomy verbatim, **C-ACT1**; §2 the seams — (S1) with N2-S1, A4-S1-ONE,
Y2-S1I and **C-S1-G**; T2 with Y-T2W and **C-T2 (ii)**; NB-4's exception with its general form (and its printed form, **MISSTATED-suspect**),
A4-SIX-ARCS, **C-SEAMS-TWO**, **C-V4-K**, **C-V56** (with de Grey's 2018 six-colour-vertex sketch verbatim), **C-UA-SEAMS**; §3 the Condition-5 chain as
**C-CHAIN-1 … C-CHAIN-18**, each statement verbatim from `plans/FS110-derivation.md` with its grade, row 134's grade clause verbatim, and one question
per step (holds / holds off a named exception, by contact kind / fails, with the configuration; the circles each step reads named); §4 **C-SAME**
(YB3-SAME, ranked last, no bearing on Q-full), **C-68a–c**, Y-BIKE-3C, YB-V5X, N2-SWAP, A3-HOLE; §5 shared constraints (W-EQ-K, W-TAN with CUSP-K, TS-U
with A4-TSU, FS106-IND-X, K-DENS, K-INT, K-CHR4, maps need six); §6 the unit-arc centre: **C-UA-INC**, **C-UA-WEDGE**, **C-UA-BUDGET** (both branches),
**C-UA-CHAIN**, **ARC-INERT** (narrowed, a GAP at isolated contact points), **C-BEYOND**, **C-LOCAL**, **C-ARC-END**, **HOCK / C-HOCK**; §7 calibration: **CAL-STRIP** (rebuilt by
formula from the printed rule), **CAL-DISK** (no positive until rebuilt: combinatorics by eye, exact solve, the printed radius as control), **CAL-7**, **CAL-FRAGS**, the checker's order and its three REJECT causes,
**CAL-PLANT**; §8 eight killing tests; §9 failure clauses; §10 not claimed.

**The advisor's advice** (FS112-A, two messages; its record `plans/POROS-2026-09-27-fs112-unit-arc-half.md` §2), and my decisions:

| # | advice | decision |
|---|---|---|
| 1 | the arc kinds: Polymath's tactic is self **and** pair; the strip's pair contacts are to be read, not assumed absent; FS-110's S1 already calibrates the pair kind locally (`u_b`–`w′_out` `[1, 1.35]`, verified in `plans/FS110-Y-construction.md` §4.5); use colour-level kinds (in-, out-, both, inert); list ARC-INERT | **adopted**; §1.3 corrected in place; ARC-INERT listed in its author's narrowed form (a GAP at isolated contact points), with the radius-2 concentric partner noted |
| 2 | §IQ (b) dropped A4-SIX-ARCS's hypothesis; NB-4's printed exception has a circle through its own centre | **adopted**; both branches quoted in C-UA-BUDGET and §IQ; the printed form quoted and marked MISSTATED-suspect (checked: `plans/FS110-NB-verification.md` l. 164 reads "`ω(y_k)` … passes through `y_k`") — my slip, logged for the report |
| 3 | YB3-SAME has no bearing on the answer (a Condition-5 statement; its event has no unit arc); rank it last | **adopted** |
| 4 | a unit arc breaks Condition 5 on one circle only; the chain walk names the circles each step reads | **adopted** into C-CHAIN's question |
| 5 | local or global: the strip and `[Polymath2021]`'s disk are local six-positives; every NO route must fail on them at a named step and name its global step | **adopted with one reservation**, then resolved by the advisor's second review: the disk enters the killing tests only once rebuilt (no printed rule, no coordinates) — by the combinatorics transcribed by eye, the exact system solved, pixels never fitted, `r² = (25 + 9√5)/10` the control; C-BEYOND (renamed from C-GLOBAL, which was misnamed: a radius-3 argument meets it) and killing test 8 carry the rest, and the open question of a bounded-radius NO is C-LOCAL |
| 6 | no frozen checker can accept the strip (ℚ(√3,√5) needed); a number-field checker, run in the order fragments → CAL-7 → strip → disk; three REJECT causes; two independent rebuilds | **adopted** (§7 "The checker"); the owner's inventory item 3 already carries it |
| 7 | the seams are two species (T2's seam points are four-colour vertices) | **adopted** as a claim, C-SEAMS-TWO |
| 8 | register the stub's 0.03 with `[Parts2020c]` §3's own population, and a dial beside it | **adopted**; the population quotation verified on pp. 37–38 ("Here we have restricted ourselves to the case of highly symmetrical tilings with only a few tiles in the repeating cell, and in the case of k = 6 to tilings in which all tiles are congruent"); the dial is registered in stage 5 with my own number |

**The advisor's second review** (of the list at b8e561c2), all adopted: (1) the stale "self, pair, free" replaced by §0's kinds in C-S1-G, C-CHAIN's
question and C-UA-INC; (2) C-SEAMS-TWO had dropped N-X's "and disjoint types" — restored (my second standing-rule-5 slip of the day); (3) C-GLOBAL renamed
C-BEYOND, its disk clause made conditional on CAL-DISK, and C-LOCAL added; (4) CAL-DISK rebuilt in three separated steps (combinatorics by eye, exact
solve, no pixel fitting; the printed radius the control), an optional construction-side stage after CAL-STRIP; (5) killing test 4 could not fire as
written — FS-110's fragments are open-ended — so C-ARC-END added, the test rewritten for arc-closed fragments, and the largest arc-closed patch made the
construction side's first product (the dial); (6) C-HOCK's first test instance is A6-C2's radius-9/10 arc, not N4's horns (radii `> 1` are allowed by
the claim); (7) killing tests reordered. Staffing: agreed, with YB's strip rebuild independent from `[AxenovichEtAl2014]`'s words.

Fences (the advisor's request, adopted): the advisor's record is fenced by path from both sides and every blind verifier (stage 5's briefs).

## Stage 4 — SAVED

## Stage 5 — SAVED: the plan (WORKFLOW 4) and the briefs

### 5.1 Phases (at most three agents at once, all Opus 5.5; one level deep)

| phase | jobs (records) | what | budget (harness) | stop rule | checkpoint and resume |
|---|---|---|---|---|---|
| **P0 reading** (beside FS112-A's last stage; two agents) | **FS112-PA**, a reading job (`plans/FS112-PA-reading.md`, `data/fs112/fs112-pa/`) | Polymath16 threads 6–9 and 16 read in full for their unit-arc tiling arguments and the two constructions (the strip's and the 2.124 disk's), every relevant passage extracted **verbatim with its address**; `[Coulson2004]`'s figures viewed; `[Soifer2024]`'s pages on Thomassen's nice colourings located and read; a verdict per print claim (HOCK, de Grey's degree-4 and six-colour-vertex sketches, Gibbs's constraint) as *stated / argued / proved*; **the disk's construction rule, if the threads print one** (CAL-DISK then becomes derivable) | ≈ 200k | every thread read, the extracts committed | SAVED stages; a successor continues at the first unread thread |
| **P1 contest** | **FS112-N**, the proof side (`plans/FS112-N-proof.md`, `data/fs112/fs112-n/`, `tools/fs112_n_*`); **FS112-Y**, the construction side (`plans/FS112-Y-construction.md`, `data/fs112/fs112-y/`, `tools/fs112_y_*`); **FS112-A2**, a fresh competition advisor (`plans/POROS-2026-09-27-fs112-competition.md`, `data/fs112/fs112-a2/`) | **Stage 1, both sides, blind:** the quotation check; the PA extracts read; **the chain walk** — every C-CHAIN step of the claim list §3 given a verdict with unit arcs allowed and the circles it reads named. N gives each verdict by derivation; Y first builds and calibrates its exact number-field checker (claim list §7, in its order: FS-110's fragments, CAL-7, CAL-STRIP rebuilt by formula), then realises each failure it claims by a tight **arc-closed** local fragment given by formula (C-ARC-END). A2 compares the two walks before round 1 (the free window, G51). **Then:** N works the seams (§2), the unit-arc centre (§6, §IQ's structural form) and C-GLOBAL; Y realises each seam arc-closed and each §6 killing test it can (a unit-arc cycle; a four-colour centre; C-HOCK on A6-C2), grows the largest arc-closed patch (the dial, 5.3 E6), optionally rebuilds CAL-DISK after CAL-STRIP, and attempts a global candidate, checked exactly; N states C-BEYOND's step and answers C-LOCAL | N, Y ≈ 400k each; A2 ≈ 250k | a side hands back when every claim it took has a verdict, or at its budget with its record SAVED | per-stage SAVED sections committed and pushed; a resumed job continues at the first unsaved stage |
| **P2 verification** | **FS112-NB** (blind on N), **FS112-YB** (blind on Y; a second, independent rebuild of the strip and of each fragment, with its own checker), launched into N's and Y's slots at their hand-backs; A2 stays for the comparison | each derives the side's claimed verdicts from the statements alone, commits its own verdicts, then reads the record and lists divergences | ≈ 300k each | verdicts committed before the record is opened | as P1 |
| **Round 2+** | set by A2's comparison (the owner's call) | the break point both sides converge on | as P1 | as P1 | as P1 |
| **P3 close** | FS112-C (the owner briefs it) | from `plans/FS112-close-inventory.md`: `plans/FS112-derivation.md`, the ledger row, the stubs, the §G re-read, G72's count and G79's record | — | — | — |

**Exact checks** (in at all times; each seconds long): Y's number-field curved-map checker `tools/fs112_y_check.py` (the frozen FS-110 checkers work
in ℚ(√3) or fall to intervals and cannot accept the strip; claim list §7). For each same-colour tile pair of an object given by formula, **a tile with
itself included**, it computes the exact minimum and maximum cross-distance and REJECTs when 1 is interior; it prints the number of tile pairs examined
against the number the object has; its suspect verdict is ACCEPT. YB builds its own. N's exact checks of derived identities go in `tools/fs112_n_*.py`.

### 5.2 Decisions (four parts each)

| choice | alternative weighed | why this one | confidence |
|---|---|---|---|
| **D1** Staffing: a proof side against a construction side, a fresh competition advisor, a blind verifier per side at hand-back — FS-110's shape | a single derivation agent on the chain walk, then a construction agent on the break it finds, in sequence | the break point is decisive only when attacked from both sides at once, and FS-110's four rounds found every divergence of truth at a verifier or an advisor (its §R-close 3.1, G51) | medium-high — if both stage-1 walks put the first break at the same step with the same fragment, round 2 can be one side plus a verifier |
| **D2** A reading job (P0) before the contest | each side reads threads 6–9 at its own stage 1 | two sides reading 30,000 words each doubles the cost and makes their first findings share a source unevenly; one reading, extracted verbatim, gives both the same prior art (protocol §1 rule 4) — and FS-110's recorded miss was prior art read in round 3 (its §R-close 3.1, X10) | high |
| **D3** Stage 1 is the chain walk, derived by both sides | the local calculus again (FS-110's stage 1); or the walk by N alone | the stub's first question is which steps survive, and Y's building is aimed by the answer; two blind walks give the first two-mind result of the milestone in the free window. The calculus (A-EXACT, A-CIRC, A-SIX) stands at FS-110's grades and is reused | high |
| **D4** A new exact checker in number-field arithmetic, built by Y and independently by YB | extend a frozen FS-110 checker (forbidden: standing rule 7); or check each object by hand in `sympy` | the strip needs ℚ(√3, √5) and the disk a nested radical; one tool with plants and calibrations, rebuilt blind by YB, is the only way an ACCEPT means anything (G21, X17) | high |
| **D5** The 2.124 disk is a positive only once rebuilt: its combinatorics transcribed by eye from Fig. 10, the exact system solved, the printed radius reproduced; an optional Y stage after CAL-STRIP | fit its figure's pixels; or leave the disk out | pixel fitting is a search (standing rule 3); leaving it out forfeits the only positive that refutes disc-local arguments between radii 1.834 and 2.124; the transcription is reading, with a built-in control (the advisor's second review) | medium — if P0 finds a printed rule in thread 16, the transcription is replaced by it |
| **D6** No Lean phase in FS-112; kernel decisions per theorem at the close (the map argument is one stub with row 134's) | formalise N4-FIN now, "an exact inequality chain, a leaf" (`plans/FS110-derivation.md`) | formalisation is not a cost (counter-priors), but whether N4-FIN survives unit arcs is this milestone's question; formalising a lemma whose hypothesis may change is premature | medium |
| **D7** The verifiers launch at hand-back, not during the contest | protocol §1 rule 11: a verifier on a finished result while the contest runs | the three-agent cap: N, Y and A2 fill it | high |
| **D8** YB3-SAME last, one in-ban fragment by Y if time allows | a proof-side stage on it | no bearing on Q-full (the advisor's reading, adopted: a Condition-5 statement) | high |

### 5.3 Registered expectations (instruments for G21, scored at the close; never caps; each with its population and both outcomes reachable)

| # | expectation | p | population, and why both outcomes are reachable |
|---|---|---|---|
| E1 | C-CHAIN-1 (NB-4) and C-CHAIN-2 (NB-5) fail as written with unit arcs, realised by FS-110's own fragments (T2's four-colour seam points; S1's saved covering pair) | 0.9 | the chain's first two steps; reachable NO: a reading of T2 or S1 that shows the fragment is not a counterexample to the step's local argument |
| E2 | the stub's "the chain's W-MERGE and N4 steps survive unit arcs outside the arcs' centres (0.6)", re-registered at **0.6** for W-MERGE and N3-CONF, **0.5** for the N4 chain | 0.6 / 0.5 | the local steps C-CHAIN-3…11 read circles `ω(v)`, `ω(v ± n)`; a unit arc breaks Condition 5 on `ω(P)` only (4.4), so each step survives exactly when no circle it reads is an arc centre's — both outcomes turn on a checkable scope |
| E3 | the first break inside the N4 chain, if any, sits at the curvature endpoints `±1` that Condition 5 made strict (N3-DEG's "curvatures in `(−1, 1)`", N4-FIN's `−1 < λ_k < υ_k < 1`): a horn bounded by a unit arc | 0.5 | N4-FIN's inequalities; reachable either way by derivation at named values |
| E4 | the stub's "the first obstruction is at a unit-arc centre carrying four colours (0.5)", re-registered: the proof side's first step it cannot close sits at a four-colour vertex that is a unit-arc centre (C-UA-BUDGET's first branch) | 0.5 | population: the steps N takes up; reachable otherwise at a three-colour (S1) centre or at T2's rhombus |
| E5 | **the stub's "a YES by formula (0.03)", re-registered at 0.03 with its population stated**: a full tight six-map of the plane given by formula and accepted exactly, within FS-112, in the population of asymmetric curved maps with unit-arc seams and four-colour vertices. No print prices this population: `[Parts2020c]`'s designs are, in its own words (pp. 37–38), "restricted … to the case of highly symmetrical tilings with only a few tiles in the repeating cell, and in the case of k = 6 to tilings in which all tiles are congruent", and put unit arcs only on voids; `[Parts2021]`'s wavy sides saved colours once in `m ≤ 2000` (at `m = 6`, a multi-fold problem, "due to reduction of d by only 0.15%"); Polymath16's 2018 search stopped at the 2.124 disk and the 3.668 strip. The 0.03 is the bold form's prior (G64: not evidence) and FS-110's closure of Condition 5 | 0.03 | YES reachable by a formula and the exact checker; NO by derivation |
| E6 | **the dial** (FS112-A's proposal): Y exhibits by formula, checked exactly, a tight six-coloured disc of radius `> √(5/2 + 9/(2√5)) ≈ 2.12426` or strip of height `> √15/2 + √3 ≈ 3.66854` — a record over print | 0.2 | informative both ways: a record moves the local frontier the NO must exceed (C-GLOBAL); a stall at the print's values with a named obstruction is evidence for the NO's global step |
| E7 | CAL-STRIP rebuilt by formula from its printed rule and accepted by Y's checker; **and** it carries out-contacts | 0.85; 0.6 | the rebuild is a derivation; a REJECT has three named causes (claim list §7) |
| E8 | C-SEAMS-TWO TRUE (the seams are a three-colour centre and a four-colour vertex with arcs) | 0.7 | a reachable FALSE: a T2 realisation whose seam points carry three colours |
| E9 | ARC-INERT TRUE off isolated contact points, a GAP at them (its author's form) | 0.6 | reachable FALSE: an inert arc whose bend creates a same-colour unit pair away from contact points |
| E10 | C-UA-CHAIN's killing test fires: a closed cycle of unit arcs realised as a tight local fragment by formula | 0.35 | informative both ways: a cycle kills §IQ's propagation route; its impossibility is a lemma for it |
| E11 | G17: every unit-arc seam is realised as a tight **arc-closed** local fragment (C-ARC-END; the obstruction, if any, is global) | 0.6 | killing test 4 as rewritten: FS-110's open-ended fragments cannot fire it; the arc-closed form can fail at the arc's end vertices |
| E12 | G71 survives: no bowtie seam with unit arcs defeats the index without a swap | 0.75 | killing test 5 |
| E13 | C-HOCK: arcs of radius `< 1` can be replaced keeping validity | 0.6 | a blog claim; its first exact test is A6-C2's radius-9/10 arc filled to radius 1 — ACCEPT or REJECT both reachable in seconds |
| E14 | a NO of Q-full at one mind with every GAP named, within P1 | 0.3 | a NO needs a step past the strip (C-BEYOND); reachable either way |
| E17 | C-LOCAL: a NO exists whose every step reads a disc of bounded radius (row 134's needed a bi-infinite line) | 0.35 | at bounded `K` a NO implies some radius by compactness, so the expectation is about an **explicit** `R` from a derivation; a FALSE of C-LOCAL at bounded `K` would be a YES |
| E15 | a named obstruction or GAP as the milestone's product | 0.85 | — |
| E16 | a blind verifier finds a divergence of truth | 0.4 | FS-110's rate (its E12 met) |

### 5.4 The ban, and Kooshi's ruling beyond it

Every brief carries standing rule 3's in/out lists and the "would have searched here" log. Out for Y in particular: a parameter scan over arc
centres, radii or tile shapes; fitting a printed figure; any optimiser over tilings (FS-109 is post-ban). In: a family given by formula whose free
parameters are fixed by derived equations, checked at the named values; the checker on each member. Kooshi, beyond 2026-10-01: *"search for a finite
graph is out. It would be huge, not feasible."* — and `[Polymath2021]`'s own proposed route, "an exhaustive computer search of all possibilities", is
exactly what the plan replaces by derivation.

### 5.5 Carry-over (not this milestone's work; for the owner and the close)

- **Correction owed** (the owner's inventory item 6): NB-4's printed form (`plans/FS110-NB-verification.md` l. 164, "`ω(y_k)` … passes through
  `y_k`") — N checks it at stage 1; the close corrects `plans/FS110-derivation.md` if it is a slip.
- **`BIBLIOGRAPHY.md` rows** (§PA): Kruskal 2008 → "abstract read (FS112-P): two- and three-colourings of bounded regions; silent on six-maps";
  Ágoston 2025 → title and authors verified, abstract read; `[Oostema2020]` new row, abstract read; Boronska 2009 thesis, title only; Polymath16 threads
  6–9 → "grepped (FS112-P); read in full by FS112-PA" when P0 lands.
- **FS-109**: the dial E6 is a disc/strip-size dial beside FS-109's hole dial; the close decides whether it folds into FS-109's stub.
- **The stub**: its banner's re-registration request is met by 5.3 E5; the close rewrites the stub's registered-expectations line.

### 5.6 Proposed edits for the close (I edit none of these files)

`LEDGER.md` — none until results; `CLAUDE.md` § Paths forward row 1 — unchanged until the close; `plans/FRONTIER-STUBS.md` — FS-112 "open (P0)"
when the owner launches; `BIBLIOGRAPHY.md` — 5.5's rows.

### 5.7 Briefs drafted (for the owner to launch)

`data/fs112/briefs/PA112-reading.md` (P0); `N112-proof.md`, `Y112-construction.md`, `A2-112-competition-advisor.md` (P1);
`NB112-verify-proof.md`, `YB112-verify-construction.md` (P2, templates: the owner adds the claim ids the side's report lists). Each carries the ban,
the fences (standing rule 13; both advisors' records; the other side's files; the verifiers'; the close inventory; `git log` beyond the start-up
snapshot), the one-level-deep rule with its reason, and the content-free hand-back.

## Stage 5 — SAVED

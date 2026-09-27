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
   it concerns; the strip calibrates the self-contact kind and nothing in print, held, calibrates the pair kind by formula.
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

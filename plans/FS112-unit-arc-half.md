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
| G51 (method, listed above) | — | — |

**Count:** 20 bear or are falsifiable here (G13, G15, G17, G20, G21, G22, G24, G30, G46, G49, G50, G51, G60, G64, G67, G71, G72, G79, G82, and G81 only for
the answer's meaning, marked silent); 62 silent, 57 of them by (F). The provisional bearings of the stub (G82, G79, G51, G21, G71, G13, G50) are all
confirmed; added: G15, G17, G20, G22, G24, G30, G46, G49, G60, G64, G67, G72.

## Stage 2a — SAVED

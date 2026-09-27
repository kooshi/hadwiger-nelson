# FS106-TS — the structural route: the regular classes almost everywhere, then Voronov's method on density-open classes

*Job FS106-TS (de Bruijn), Opus 5.5, 2026-09-27. Brief `data/fs106/briefs/TS106-structural.md` (the owner's re-brief block first) with
`data/fs106/briefs/STANDING-RULES.md` (rule 0 first: `CLAUDE.md` § The aim and § Counter-priors read from disk before anything else). Inputs
read from disk: `plans/FS106-regular-half.md` (all), `data/fs106/claims.md`, `plans/FS106-V-verification.md` (with § Continuation — FS106-V2),
`plans/FS106-VB-verification.md`, `plans/FS103-M-derivation.md` §3.1, `plans/POROS-2026-09-26-fs106-regular-half.md` stage 4. Not blind to the
print or to wave 1; blind to FS106-TQ until my verdict stage for items 1–2 is committed. Grades are `CLAUDE.md` § Notation's. Working files:
`data/fs106/fs106-ts/`; exact checks `tools/fs106_ts_*.py`. Text layers of the two papers (`pdftotext -layout`) in my own scratchpad
subdirectory `…/scratchpad/fs106-ts/`.*

## Theorems this phase proved

*(one line each, grade and address; filled stage by stage)*

## Would-have-searched-here log

- Stage 1: none (a quotation check and the controls, by hand).

## Stage 1 — SAVED: quotation check and the controls

### 1.1 Quotation check (standing rule 5)

**Instrument.** `tools/fs106_ts_quotes.py`: each row is a quotation, its source, and the verdict expected; the quotation is split at ellipses and
each piece must occur in the source after deleting whitespace and joining line-end hyphens; a miss prints the longest present prefix. A source
that quotes its own body is cut at a marker (the brief's planner text starts at "*Brief for job"), because the first run found the re-brief's
quotation of the planner's text inside the file itself and read OK — an instrument defect, repaired before the run recorded here. **Plant:**
`--plant` mutates one present quotation (its longest word reversed) and adds an invented sentence; both read MISS, the untouched row OK
(`plant exit=0`). **Recorded run: 15 rows, 0 unexpected (exit 0).**

| quotation (where my brief or its standing rules hand it on) | source | verdict |
|---|---|---|
| re-brief: "send the advisor a short note" | the planner's text of the same brief: "Send the advisor (its id comes from the owner) a short note after each saved stage." | **paraphrase in quotation marks** (capital, and the parenthesis dropped); harmless — nothing lost |
| re-brief: C-AE-CLOSED is equivalent to "no almost-everywhere-proper six-colouring of `U₃(0)` with essentially closed classes" | `plans/FS106-V-verification.md` §2.1: "no a.e.-proper measurable 6-colouring of `U₃(0)` has essentially closed classes" | **paraphrase in quotation marks; it drops "measurable"**. The word carries weight: "essentially closed" (`|supp S_j ∖ S_j| = 0`) is defined through Lebesgue measure of the classes. Read here with "measurable" restored |
| rule 0: "From here on out, you may doubt your ability … you will surprise yourself." | `CLAUDE.md` § Counter-priors | verbatim |
| rule 4: "A proven theorem about why its impossible is also valid. All novel knowledge is a success." | `CLAUDE.md` § Where the problem stands, item 23 | verbatim |
| rule 3: "The intent of the ban is to eliminate the crutch …" | `CLAUDE.md` § Toolchain quotes only "to eliminate the crutch of feeling like we're accomplishing something by asking uncomputable problems for days at a time" | the rules' extra words "The intent of the ban is" are not in `CLAUDE.md`'s quotation (they may be Kooshi's own; unverifiable here); not load-bearing |
| C-AE-Q2's Question 2, D-SV Conditions 5 and 6, SV-L1, SV-1, C-T-CHR4's Lemma 2 | `[SokolovVoronov2025]` v1 text layer | verbatim (as FS106-V and FS106-VB found) |
| V-P2.2 | `[Voronov2023]` v3 text layer | verbatim |
| C-T-TAN, the advisor's wording "the unit relation becomes 'same projection onto e = w₀−u' …" | `plans/POROS-2026-09-26-fs106-regular-half.md` | **not on disk verbatim** (as FS106-V found): the record carries it in other words; the quoted form is from a message. I state C-T-TAN from its content, not its wording |

The brief's glosses (no quotation marks), checked: Question 2 as "maps whose open regions are properly coloured, boundaries free" — that is
C-AE-Q2 (D-AEMAP), not Question 2 as posed (C-AE-Q2-EV); both are on my list, so nothing is lost. "`[SokolovVoronov2025]` has already carried
Voronov's circle method … for maps with no unit-arc boundaries and no high-degree trichromatic vertices" — matches Conditions 5 and 6 and SV-1.
The three source paths in the re-brief exist on disk. The claim ids the brief lists all occur in `data/fs106/claims.md`.

### 1.2 The controls (standing objects every verdict below is checked against)

- **K1 — the tight hexagonal 7-colouring.** Regular hexagons of side `1/2` (diameter exactly 1), open hexagons coloured by the standard 7-colouring
  (the colour classes are cosets of an index-7 sublattice), boundaries free. It is a map (Conditions 2–4), polygonal (Condition 8), satisfies
  Conditions 5 and 7, and is a.e.-proper (D-AEMAP): two points of one open hexagon are `< 1` apart, and two hexagons of one colour are more than
  1 apart (`√7/2 ≈ 1.32` at this size), so distance exactly 1 inside one colour occurs only between opposite vertices of one closed hexagon. It is **tight** (D-SLACK: an open hexagon of diameter 1
  realises every distance in `(1 − ε, 1)`). **What it forces on an argument:** at a vertex `u` (multicolour of size 3), the colour of each hexagon
  `H` at `u` touches `ω(u)` **from inside**, at the vertex of `H` opposite `u`, in a direction interior to `H`'s own sector at `u`. So "the circle
  about a trichromatic point avoids its multicolour" holds only as S–V's Corollary 2 states it (some sector, inner or outer, is free at each
  direction), never as a full annulus; any step that needs a full annulus in the complementary colours is wrong at exact distance. And every
  "needs seven" argument must spend the count six at a named step that K1 fails.
- **K2 — `[Townsend1981]`'s unit-arc sector** (p. 114, read from the scan by FS106-V and FS106-VB: the sector "subtended by the angle ⅔π", split by
  "the arc of unit radius centre a"). A boundary may contain an arc of a unit circle and a 2-colouring of the pieces may avoid the monochrome unit
  that a sector of that angle is otherwise forced to carry. **What it forces:** no argument may conclude "no boundary contains a unit arc" from
  properness alone; a statement about unit arcs must hold on K2 (there the arc's centre `a` sits at the edge of the coloured set).
- **K3 — a density-open class with a fat-Cantor edge.** Let `K ⊂ [0, 1/4]` be a closed nowhere-dense set of positive length (a fat Cantor set) and
  `A = {(s, t) : s ∈ (−1/4, 1/4) ∖ K, |t| < 1/4}` with `B` its complement in the square. `A` and `B` are, up to null sets, a two-colouring whose
  topological boundary contains `K × (−1/4, 1/4)`, of positive area, while the essential boundary (points of density 1 for neither) is null
  (Lebesgue: a.e. point of `K × ℝ` is a density point of `B`). **What it forces:** an argument that works with regions, components or topological
  boundaries says nothing about density-open classes; a claim in D-NF must survive a class whose topological boundary is fat.

## Stage 1 — SAVED

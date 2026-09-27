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

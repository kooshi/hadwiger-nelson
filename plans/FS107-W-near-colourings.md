# FS107-W — competitor W of FS-107: near-colourings whose holes vanish (job FS107-W, Opus 5.5)

*Brief: `data/fs107/briefs/W107-near-colourings.md`, with `SHARED-107-competition.md` and `STANDING-RULES.md`, read from disk in full,
2026-09-27 07:2x UTC. `CLAUDE.md` § The aim and § Counter-priors read from disk (rule 0). Object: SEQ. Fenced and untouched: R's record and
working directory, the advisor records named in SHARED § Fences and `plans/POROS-2026-09-27-fs107-competition.md`, the close inventory,
`data/fs107/reports/` (my own report excepted, written at the end), transcripts, `chats-bak/`, scratchpad files I did not create. My scratch:
`<scratchpad>/FS107-W/` only. Fence touches: **none**. (`ls data/fs107/briefs/ data/fs107/reports/` at the start listed `FS107-P.md` in
`reports/` by name; the file was not opened. Logged as a listing of a fenced directory, disclosed here.)*

## Theorems this phase proved

| id | statement | grade | address |
|---|---|---|---|
| W-CHK | `tools/fs107_w_check.py` decides band-properness of a periodic closed-grid-square partial colouring exactly (integer arithmetic on squared distances; the distance set of two closed squares at index offset `(dx, dy)` is the interval `[h√(gx²+gy²), h√((|dx|+1)²+(|dy|+1)²)]`, `gx = max(|dx|−1, 0)`) | [tools], exact | stage 1 |
| W-HEX | The rasterised hexagonal seven-colouring with one class blank (`u = (31, 0)`, `v = (15, 27)`, `h = 1/40`) is a periodic grid-square partial six-colouring with exact slack `1 − √1322/40 ≈ 0.0910` and uncovered density exactly `1/7` | [tools], exact | stage 1; `data/fs107/fs107-w/report-hex7m1-h40-e20.json` |

## Would-have-searched-here log (standing rule 3)

| # | the move a search would have made | what I did instead |
|---|---|---|
| 1 | Greedy-fill the hex member's holes (351 of 837 hole squares can individually take a colour) to see how far coverage rises | Recorded the count as a diagnostic only; a fill procedure is a colourer, out under the ban and not W's route (members are given by formula) |

## Stage 1 — SAVED: quotation check, restatement, the advisor's question, the checker

### 1.1 Quotation check (standing rule 5)

| quotation (where it appears) | source checked | result |
|---|---|---|
| W's statement, "for every `δ > 0` there are `ε > 0` and a **periodic** partial 6-colouring by half-open grid squares, …, leaving density `≤ δ` uncovered" (brief; claims.md §1) | `plans/FS106-TQ-derivation.md` §3.5 (e) | verbatim ✓ (the brief calls it "row 131's (e)"; the words are TQ's; row 131's own wording is "at most `δ`") |
| "Tight polygonal tilings in `[Parts2020c]`'s framework with voids tending to 0 would do, because TQ-SUP equates the tight and slack suprema" (claims.md; brief paraphrases it) | `plans/POROS-2026-09-27-fs106-close-and-fs107.md` l. 452 | verbatim ✓ |
| "The direction W relies on is the easy one."; "The only gap on this object is the hole gap."; "W's Route II limit, a tight a.e.-proper six-colouring in D-NF" (claims.md) | same file, ll. 455, 428, 429 | verbatim ✓ |
| "Parts's family has none: its voids keep a fixed size, one at every vertex (TQ §4.5 item 6)" (brief, paraphrase) | TQ §4.5 item 6 (b), (c) | faithful ✓ |
| K-BICH, K-C6, K-TAN, K-KILL, K-DENS, K-FLOOR (brief paraphrases) | claims.md §2 | faithful ✓ |
| "a corner-circle rule is only sufficient, §PA row 6" (brief) | plan §PA row 6: "whether that is the exact condition for whole cells is not checked here"; claims.md: "may be only sufficient" | **the brief overstates by one word** ("is only" for "may be only"); harmless — my checker uses the exact interval either way |
| "your claimed `δ(ε)` is never below `ε²/(6+ε)²` (FS106-EPS2, given V-1.3)" (brief) | claims.md K-FLOOR, the close's column | verbatim in substance ✓ |
| Kooshi: "A proven theorem about why its impossible is also valid. All novel knowledge is a success." (SHARED; rules 4) | `CLAUDE.md` § Where the problem stands, item 23 | verbatim ✓ |
| Kooshi: "search for a finite graph is out. It would be huge, not feasible." (SHARED; rules 3) | `CLAUDE.md` § Publication | verbatim ✓ |
| Kooshi (rule 0): "From here on out, you may doubt your ability … You are capable, and you will surprise yourself." | `CLAUDE.md` § Counter-priors | verbatim ✓ |
| FS106-AE-POLY, AE-CONV, AE-NICE, AE-CLOSED (used below) | `plans/FS106-derivation.md` ll. 98–115 | read from source ✓ |

### 1.2 Claim W, quoted and restated

*Quoted (TQ §3.5 (e), claims.md §1):* "for every `δ > 0` there are `ε > 0` and a **periodic** partial 6-colouring by half-open grid squares, with
no monochromatic pair at any distance in `[1 − ε, 1 + ε]`, leaving density `≤ δ` uncovered".

*Restated:* for each tolerance `δ`, some band width `ε` (allowed to depend on `δ` and to be as small as needed) admits a colouring of a periodic
grid of small squares — six colours on some squares, the rest blank — in which no two points of one colour, anywhere in the plane, are at a distance
between `1 − ε` and `1 + ε`, and the blank squares fill at most a `δ` fraction of the plane. The order is ∀δ ∃ε; the floor (K-FLOOR) forces
`δ ≥ ε²/(6+ε)²`, so a family meeting W has `ε(δ) ≤ ~6√δ`. With five colours in place of six the same family would give `χ(ℝ²) ≤ 5` — a different
outcome (G64), kept apart throughout.

*What it is not:* C-VOID's refutation (all voids small, coverage free) is weaker and decides nothing; a family with `δ` flat in `ε` (Parts's,
TQ §4.5 item 6 (c)) is a control, not a member of W.

### 1.3 The advisor's question, answered (registered by FS107-A2 at 07:35 UTC, verbatim in its record)

Sent to FS107-A2 by SendMessage; the text, verbatim:

> FS107-W's registered answer (stage 1): the step of R's programme I expect to fail first is R′ = C-VOID (claims.md §1), and with it break-table
> row 1's R step ("holes of ε-independent measure in some disc of radius R₀") whenever R reaches that measure through a void of fixed radius.
>
> WHY: (1) K-AD leaves R two doors, anchors of positive measure or holes of ε-independent size ρ₀; C-VOID is the second door, and I expect it
> FALSE, not just unproved, because it quantifies over every coverage: a counterexample need only make every uncovered disc small, not the hole
> area. (2) The local picture at a junction supports that: a void of inradius ρ with ε ≪ ρ makes the junction look TIGHT at distance 1 (on T₁(x)
> only the two colours whose tiles cross the line through x perpendicular to the direction are forbidden, not all three), so the void's job is
> done at any radius ≫ ε, and nothing I can see ties that radius to a fixed scale once the number of tiles near a junction is free. (3) What does
> give a void lower bound is compactness: families of bounded local complexity converge to regular tight colourings, which row 132 excludes
> (polygonal and convex tilings, except the d = 2 edge case), so their voids stay ≥ ρ₀(complexity). That bound depends on complexity and has no
> uniform form; C-VOID needs the uniform form, over families whose limit is wild, where no regular theorem applies. If R goes by the limit object
> instead, the step I expect to fail first is C-T-L1b's collar (its step 2), for the same reason: the limit need not be regular.
>
> WHAT WOULD SHOW I AM WRONG: a proof of C-VOID for grid-square members with no bound on complexity; or a family of mine whose largest uncovered
> disc provably stays ≥ ρ₀ as its complexity grows, for a reason that is not a design choice of the family (then the obstruction I name at stage 4
> is an instance of C-VOID, and I will say so).

*A correction to my own item (3), made at once from the advisor's card `is-a-bounded-complexity-limit-excluded` (received about 07:40 UTC; retraction sent 02:41):* row 132
excludes bounded-complexity limits only when they are **polygonal** (FS106-AE-POLY, bar `d = 2`) or locally finite **convex** tilings
(FS106-AE-CONV). Thomassen's nice-map theorem as held (FS106-AE-NICE, `plans/FS106-derivation.md` l. 115) needs "any two distinct faces of one
colour … at distance > 1"; its a.e. relaxation is "a GAP with C-AE-Q2". A tight limit of slack members has same-colour faces at distance ≥ 1,
possibly = 1, so **curved-boundary bounded-complexity families are not excluded by any held theorem** — I reached the same reading before the card
arrived (my notes: "tight nice maps with arcs … AE-NICE′ is GAP"); item (3) as sent said "nice maps" nowhere, but "regular tight colourings, which
row 132 excludes" overstated. **Retraction count: 1 (free; nothing rests on it).** This changes my stage 2: the live bounded-complexity class is
arc-bounded tight maps, and W's first obstruction theorem is scoped to polygonal/convex limits only.

### 1.4 The checker (brief item 3; X8) — `tools/fs107_w_check.py`, with `tools/fs107_w_members.py`

- **Input:** a member file — cell side `h`, claimed `ε`, the period lattice `Λ ⊂ ℤ²` (two basis vectors, grid units), one representative per
  coloured coset `[i, j, colour]`. **Scope decision (four parts):** *choice* — grid-square members only; *alternative* — general rational polygons
  with exact vertex–edge distances (would admit Parts-type tiles directly); *why* — W's claim is about grid squares, integer arithmetic makes the
  verdict exact with no geometry code to get wrong, and any polygonal tiling can be rasterised by formula; *confidence* — high; it changes if a
  family's natural members are curved and rasterising them costs more than `ε`.
- **Verdict (exact):** every ordered same-coloured pair `(p, p + Δ)`, `p` in one period cell, `Δ` in the band annulus (all offsets whose closed
  distance interval meets the closed band). Closed squares make the test slightly stronger than the claim's half-open ones; a pass here is a pass
  there. Exit 0 ACCEPT, 1 REJECT, 2 malformed (overlapping cosets refused).
- **Reported:** pairs checked; exact slack `ε*` (the colouring is band-proper for `[1−e, 1+e]` iff `e < ε*`; exact comparisons of the
  `1 − h√a` / `h√b − 1` forms); least margin `ε* − ε`; uncovered density and every class density exactly (K-DENS); the floor `ε²/(6+ε)²`; the
  junctions of D-JUNC (edge-connected components — the interior's; the corner-connected count beside it), their types (`r_J = h`), the least
  distance between complementary-type junctions (K-C6), and equal-type junction pairs whose distance interval meets `(1, 2)` (K-KILL).
- **Controls (`--self-test`, all pass, 4.8 s):**
  1. *Known positive* (faithful stub): the hexagonal seven-colouring with one class blank, rasterised — ACCEPT, 0 violations of 8,316,432 ordered
     pairs, uncovered density exactly `1/7`, every class `1/7`, exact slack `1 − √1322/40 = 0.09102 > ε = 1/20`.
  2. *Planted pair:* one blank square recoloured to the colour of a square in its band — REJECT, 840 ordered violations, **every one involving the
     planted square**, and `0 < 840 ≤ 3312` (two-sided bound).
  3. *Near miss:* same colour at min distance `1.2 > 1 + ε` — ACCEPT; at exactly `1 + ε` — REJECT (closed band's upper edge).
  4. *Exact band edge:* `h = 1/10`, `ε = 1/2`, offset `(2, 3)` has max distance exactly `1/2 = 1 − ε` — REJECT; one square nearer — ACCEPT;
     exact slack there `1 − √20/10`.
  5. *Overlap:* a second colour on a coloured coset — malformed.
  6. *Exact margin comparisons*, including an exact tie.
- **Faults planted in the checker (scratch copies; each caught for its own reason):** closed band made open at the lower edge — caught only by
  control 4; the violation test disabled — caught by 2, 3, 4; the gap formula understating distances by one square — caught only by control 3's
  near miss (the hex member still passes: its margin exceeds one square).
- **A hypothesis refuted by the tool (G21 on myself):** I asserted that every blank square of the hex member sees all six colours in its band. It is
  false: of 837 blank squares per period, 486 see six colours, 339 see five, 12 see four — so 42 % could *individually* take a colour. The histogram
  is now pinned as a regression control. (A joint fill is a colourer; not run — log item 1.)
- **The control's junctions:** one per period (the blank hexagon), type all six colours; six equal-type pairs meet `(1, 2)`, the least at
  `1.150`; no complementary-type pairs (no junction has a three-element type).

## Stage 1 — SAVED

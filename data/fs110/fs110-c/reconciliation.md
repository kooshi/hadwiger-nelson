# FS-110 close — stage 1: the reconciliation (FS110-C, de Bruijn, Opus 5.5, 2026-09-27)

*Every claim and lemma of FS-110 with its verdict, its minds and their blindness; every divergence and how it was settled. Read from the records'
"Theorems this phase proved" and divergence sections (addresses in each row). "Blind" = a verifier that derived before opening the side's record.
N and Y (and their successors) were independent of each other throughout (competitors), so a statement both reached counts two minds, neither blind.*

## Stage 1 — SAVED

### 1.0 Quotation check (standing rule 5)
- "Is it true that 7 colors are needed …?" — verbatim at `data/fs110/claims.md` l. 63 and `plans/FS110-PA-prior-art.md` l. 80. OK.
- The headline the brief attributes to "FS110-A6's § A6-2.1" — **not verbatim.** The source (`plans/POROS-2026-09-27-fs110-competition.md` l. 1485–1486)
  reads: "Under Condition 5, no locally finite map of the plane whose boundaries are segments and circular arcs, none of radius 1, carries a six-colouring
  in which no two interior points of one colour are at distance exactly 1." The brief's "carries an a.e.-proper six-colouring" is a paraphrase inside
  quotation marks (same content: an a.e.-proper colouring of a map is one whose interiors avoid distance 1). Logged as the owner's slip (inventory kind
  "slip"); the close uses the source's words.
- Kooshi's counter-priors quotation (standing rules, rule 0) — verbatim to `CLAUDE.md` l. 118. OK.

### 1.1 The headline and its chain (the final count of minds)

> **Under Condition 5, no locally finite map of the plane whose boundaries are segments and circular arcs, none of radius 1, carries a six-colouring in
> which no two interior points of one colour are at distance exactly 1** (A6-2.1, verbatim). So the Condition-5 half of `[SokolovVoronov2025]`
> Question 2 is answered **YES — seven colours are needed** — almost everywhere, for such maps.

| link | statement (short; each verbatim in its record) | minds | address |
|---|---|---|---|
| NB-4 | under Condition 5 no vertex has four colours (nor five) | two, one blind: NB (derived), A4 (checked step by step); its four-colour half is `[SokolovVoronov2025]` Lemma 2 in print (PA), TRUE region-only per FS106-V | NB §2.3; A4-2 |
| NB-5 | under Condition 5 no close covering pair (its common unit point would be a four-colour vertex); no disjointness needed (A4) | two, one blind (NB, A4) | NB §2.4 |
| W-MERGE | Woodall 1973 step 3 a.e., curved arcs, Condition 5, outside Woodall's cone; repairs: `ρ` off finitely many values, a hole fill (Woodall step 1) | two, one blind (N3, NB3) | N §2.2; NB3-MERGE |
| N3-DEG | `int D_c(v) = ∅` only in Woodall's cone | three, two blind (N3, NB3, NB4) | N §2.3; NB3-DEG; NB4 §2.5 |
| N4 chain | N4-SHADOW, FLANK, SHAVE, RAY, STUCK, PROP, FIN, TERM, CONE, RED | two, one blind (N4, NB4), with NB4's D3 (TERM counts `Φ` + number of horns), D4 (straight cuts keep the radius bound, `M* ∈ 𝓜_{O(K)}`), D5 (RAY by an exact route), D6 (STUCK by a second route) | N § Continuation — FS110-N4; NB4 §2, §4.1 |
| residue | a terminal cubic map keeps only single cusp horns that are doubly shadowed (single-horn Woodall cones) | one (NB4-CS, with N4's wedge-opening a sketch); A6-C2 shows the object exists locally [tools, exact, one checker: Y's] | NB4 §2.9, D3; A6-3 |
| base, no `d = 2` exception | S–V Cor. 1 a.e. for curved cubic maps under Condition 5 | two, **both blind**, different routes (CB: circle-only reduction; CD: Lemma R and Theorem D2) | CB §D5–D6; CD §2.2–2.7 |
| base at cusp sectors | CB's route at cubic vertices with a cusp or double cusp | at D2's strip (a)–(c), D5 item 5 and D1's (P′): two readings (A6 sighted; FS110-CC, one mind on the cusp case, [hand + tools]); CB's own derivation is uniform but not aimed at cusps. **Under check: D4's bicycle and D5 items 1–4 and 6 at cusp vertices (FS110-CE, running).** CD's route does not cover cusps (it takes S–V Props. 9–11 and 17 from print). | CC §C1–C6; A6-1.5 |

**Grade of the headline: [hand], the weakest link.** The chain two minds, one blind; the base with no `d = 2` exception two minds, both blind; the base
at cusp sectors two readings at D2, D5 item 5 and D1, **under check at D4 and D5 items 1–4, 6** (a step not yet read, not a GAP found). The residue
lemma (NB4-CS) one mind. **Polarity:** S–V Question 2 asks "Is it true that 7 colors are needed …?"; its Condition-5 half is answered **YES**; W-4's
"NO" is the no to a six-map (item 97; NB4 D1). **Card A6-C1 (bounded `K`):** NB4 did not answer it by name; its proposed wording keeps "of bounded
complexity", but its derivations use local finiteness only — TERM needs `Σ Φ₀` finite on bounded sets, and `𝓜_{O(K)}` enters only as bookkeeping
(NB4-TM, NB4-SC). So the map statement holds for every locally finite map (A6's reading; NB4's text consistent, not a separate derivation); **bounded
`K` is load-bearing only upstream, in FS-107's W-EQ-K** (vanishing holes ⟺ a tight map of complexity `≤ K`), which is where FS-111's question sits.

### 1.2 Every other claim and lemma, with its verdict

| claim / lemma | verdict | minds (blind) | settled by / address |
|---|---|---|---|
| A-EXACT | TRUE (read "meets the interior of a tile"; closure types covering six; disjointness unused) | three (A, N, Y) | N-E0; Y-AEX; A2 st. 4 |
| A-CIRC | TRUE in closure form, cusps included | five, two blind (A, N, Y, NB, NB3) | N-E1; Y-CIRC; NB3-AC |
| A-SIX | TRUE (sizes and disjointness unused) | three (A, N, Y) | N-SIX; Y-SIX |
| D-TYPE | TRUE | two (N, Y) | N-TYPE; Y-TYPE |
| C-TAN-POS | TRUE where each route reaches (N at non-vertex `w₀`; Y at A-EXACT's disjointness); superseded under Condition 5 by NB-5 | two, complementary routes | A2 st. 2, 4 |
| A2-ESC4 | TRUE: four distinct colours escape with none repeated | two (A2, Y) | A2 st. 2 |
| N-SEAM, N-E2 | TRUE | two, one blind (N, NB) | NB §2 |
| C-CUSP-K (N-HORN) | TRUE (a cusp horn is seen like a ray) | three, one blind (N via N-HORN, Y at pair level, NB) | A2 st. 4; NB |
| N-X (a)–(d) | TRUE | three, one blind (N; Y2-W4 independently; NB) | A4 st. 1; NB |
| C-SEAMLIST | MISSTATED; corrected to the (S1)/(S2) dichotomy at `w₀` | one (N) | item 21 |
| Y-BLOCK | shapes TRUE (after "exactly five shapes" retracted); "hence C-TAN-POS" GAP at completeness | one; YB blind finds the GAP | YB §3 |
| Y-T2W | TRUE at (3, 3); GAP at (2, 4); table line drops the (3, 3) sizes | two, one blind at (3, 3) | YB; A5 st. 1 |
| Y-BIKE-3C | TRUE off grid corners (two minds, one blind); GAP at grid-corner passages, which is A4-BAND's cross-swap (A5-CORNER, location three minds) | Y, YB, A4, A5 | YB §3.1; A5 st. 1 |
| N2-V4 | step 1 TRUE; step 2 TRUE for covering pairs in the union sense, GAP in the disjoint sense; with arcs of `Γ` on `ω(v)` both a GAP (A3-HOLE: three minds, two prompted) | NB blind; A3, N2 | NB D1; A3 st. 4 |
| N2-RING | TRUE, stronger: `\|W\| ≤ 1` forces a swap | two, one blind | NB §2.2 |
| N2-SWAP, N2-ACT1-W0 | TRUE under Condition 5 (GAP without) | two, one blind | NB; A4 st. 2 |
| N2-ROT | TRUE; its table line MISSTATED (drops "(A+, B+), (A−, B−) is a swap") | two, one blind | NB; item 45 |
| N2-HEX | TRUE at degree 3 (needs TS-C against bichromatic rotation points, NB); unproved at degree ≥ 4 (N3); "the pure rotating ring is locally consistent" FALSE under Condition 5 (N3; item 71) | two, one blind | NB §2.9; N3 |
| N2-S1 | TRUE; exceptional distances exactly `{1, √3}` | two, one blind | NB §2.9 |
| N2-TRANS | TRUE for edges whose ends have different third colours (`c ≠ d`), off the collinear `d = 2` configuration | four, two blind (N2 a sketch at the nerve step; NB; Y3 as Y3-PROP; YB3-TRANS) | YB3 §2.3 |
| N2-FLIP / Y3-FLIP | the parity algebra TRUE (four minds, two blind: N2, NB, Y3, YB3-FLIP); **its use for `W` a GAP at same-type steps** (YB3-SAME) | — | YB3 §2.4–2.5 |
| YB3-SAME | GAP: `W` is not transported across a same-type edge; "`\|W\|` constant" (Y3-PROP) and the "even count" of W-3 carry it | one (YB3), with a named falsifying local picture | YB3 §2.4; item 77 |
| Y2-W4 (a)–(c), Y2-W4e | TRUE; W4e holds for every (3, 3) pair | four, two blind (A5 count) | YB §3.1; A5 st. 1 |
| Y2-W4 (d) | MISSTATED → "at most `\|P(u)\| − 2` colours"; vacuous under Condition 5 (NB-4) | YB blind | item 58 |
| fragments S1, T2, BB, MX | ACCEPT, tight | **[tools, exact, two checkers]** (Y2, YB) | YB-FRAG |
| Y2-S1i | TRUE bar item 4 (GAP when both side colours are cusps at `u`); "partner free" → "vertex figure unconstrained", short of N2-S1 | one + YB | YB; A4 st. 1 |
| Y2-LAT | TRUE for YB's reading (the side has a description, not a formula); three routes to its failure | two, one blind | A5 st. 1 |
| A3-HOLE | A2-V56 TRUE without arcs of `Γ` on `ω(v)`, GAP with them | three, two prompted | A3 st. 4 |
| A4-SIX-ARCS | one mind; vacuous under Condition 5 (NB-4) | one | A4 st. 1–2 |
| A4-BAND | a sketch, one mind; its cross-swap is YB's corner GAP | one | A4 st. 1; A5-CORNER |
| YB-V5X | no bichromatic vertex of degree ≥ 4 ends a covering pair at a transversal common unit point | one (YB, blind) | YB §3.1 |
| N3-CONF, N3-CLEAR, N3-UP | TRUE | two, one blind (N3, NB3) | NB3 §2.1 |
| N3-P17 (no purely rotating ring under Cond. 5) | TRUE | many routes: N3 (two), NB3 (third, bracketing pair), S–V Prop. 17 as FS106-V repaired, Y3-SIX and YB3-SIX, CB's Prop. 17 a.e. (cones at `u`) | NB3-P17; CB §D5 item 5 |
| N3-RED | TRUE; "hard" must be named: N4's doubly shadowed, not Y4's tip-hard (A6); repairs: merge within `ρ`, or restate at radius 4 | two, one blind | NB3 §2.5; items 87, 102 |
| W-3 | GAP at G-CONE and G-d2, NO given both (round 3); then G-d2 does not arise (CB, CD) and G-CONE closes (N4, NB4) | — | A5; round 4 |
| Y3-C5 | TRUE (print's Condition 5 = no boundary arc of radius 1 in `𝓜_K`) | three, one blind (Y3, YB3, A5) | A5-C5 |
| Y3-GP | TRUE; stronger (YB3-GP′, one mind): no two change points exactly 60° apart ⟹ `W ≡ 3 (mod 6)` | two, one blind | YB3 §2.2, §4.3 |
| Y3-SIX | TRUE by a second route (YB3-SIX); drop "the colours run `r₀r₁r₂r₀r₁r₂`" | two, one blind | YB3 §2.7; item 77 |
| Y3-BOW | TRUE; its path through the bowtie is YB3-TRANS verbatim | two, one blind | YB3 §2.6; A5-BOW |
| Y3-PROP | transport TRUE at `c ≠ d`; line MISSTATED (drops the `d = 2` exclusion); "`\|W\|` constant" GAP (YB3-SAME) | two, one blind | YB3 |
| Y4-MU ≡ N4-SHADOW ≡ NB4-SH | the curvature map `λ/(1 + λ)` | four, two blind (Y4, N4, YB4, NB4); discriminated exactly (`κ₂ = 3/10` ACCEPT, `9/25` REJECT) | A6 st. 1; YB4 §2.3 |
| Y4-WC, Y4-HARD | TRUE for the members; "every curvature" → "every horn-bounding curvature"; completions owed | **[tools, exact, two checkers]** (Y4, YB4) | YB4 S1, S4 |
| Y4-TIP | TRUE; a double-horn cone needs one recolouring per horn | two, one blind | YB4 S2 |
| Y4-D2 | TRUE for closure types, tip-hard cones, the pair `(N, S′)`; moot (G-d2 does not arise) | two, one blind | YB4 S5 |
| YB4-WINDOW | both ends of `R_y` confirmed exactly | one (blind) | YB4 §2.2 |
| WC1H shaveable; WCH = N4-STUCK (iv) truncated | tip-hard is weaker than doubly shadowed | A6 [tools, exact] + NB4 blind (NB4-WC1H, NB4-WCH) | A6 st. 1; NB4 §2.10 |
| A6-C2 fragment | a doubly shadowed single horn, every N4 operation blocked, ACCEPT on Y's checker | one [tools, exact] | A6-3 |
| N4-HEX | (a) TRUE (two minds, NB4); (b)–(c) superseded | — | NB4 §4 |
| Theorem D2 (CD) | antipodal same- or disjoint-multicolour endpoints cannot collide | one (CD), agreeing with CB's circle-only reduction on truth | CD §2.7 |
| CB's circle-only reduction | TRUE; "every pigeonhole point but the eleventh lies in the open disc" a GAP at (E3), (β), harmless via D2 → "open disc or V-in vertex on `ω(u)`" | two, both blind (CB; CD's Lemma R) | CD §4.1; item 90 |
| Lemma 3 a.e., `1 < d < 2` | TRUE; the printed Fig. 5 proof FALSE from `√3` on (`\|q₃ − u₁\|² = 2 + 2 cos(2θ₀ − 60°)`) | two, one blind: CB's full derivation (blind) and FS106-SV2's sketch | CB §D3–D4 |
| Lemma 5, Prop. 18 | TRUE | one derivation (CD); CB from print | CD §2.5 |

### 1.3 Divergences and how each was settled
| # | divergence | kind | settled |
|---|---|---|---|
| 1 | "covering pair": disjoint (claims §0) or union = [6] (the sides) | definition | card 3: union; N-X needs disjoint, C-T-TAN the union (NB D1); correction owed (items 35, 45) |
| 2 | A-EXACT "meets a tile" vs "meets the interior" | wording | Y; correction (item 16) |
| 3 | "strong escape" omits four distinct colours | wording | card 1; A2-ESC4, two minds (item 16) |
| 4 | the owner's round-2 frame fact (Act One open only for ≤ 3-colour maps) | truth of an owner statement | GAP twice: arcs of `Γ` (A3-HOLE, N2-V4) and a third colour at a switch point (Y2) (items 23, 30) |
| 5 | A3-HOLE and N2-V4 read TS-U as putting a unit arc's side colours in its centre's type | truth of an argument | A4: false (Y2's exact T2); both GAP verdicts survive on another argument (item 39) |
| 6 | Y2-S1i "partner free" vs N2-S1 | scope | A4 (item 39) |
| 7 | W-3's "trivalent" | definition | card 4: `\|P_cl\| = 3` at any degree, both sides independently (item 61) |
| 8 | "`\|W\|` constant", the even count (Y3-PROP, N2-FLIP) vs YB3-SAME | truth, open | **unsettled**: a GAP at same-type edges; off the NO's path (N3-RED uses no windings); a stub item (items 77–78) |
| 9 | round 3's frame: the winding map vs the cone | frame | A5: N3-RED bypasses windings; W-3 is S–V Q2's Condition-5 half itself |
| 10 | "hard" cone: Y4 tip-hard vs N4 doubly shadowed | definition | A6: different objects; WC1H tip-hard and shaveable [tools, exact]; NB4 blind agrees (items 96, 102) |
| 11 | the polarity of the answer to Q2 | sign | YES (A6; NB4 D1; items 97, 104) |
| 12 | N4-4's headline drops the base-at-cusps hypothesis | MISSTATED | NB4 D2: the headline carries it (item 104) |
| 13 | N4-TERM's count vs its survivors | precision | NB4 D3: count `Φ` + horns |
| 14 | a radius lower bound in N4's modification | scope | NB4 D4: straight cuts; dissolved |
| 15 | CB's "open disc" at (E3), (β) | GAP, harmless | CD via D2 (item 90) |
| 16 | CB's D5 item 5 omits the inner-q case; D2 (a) can be stated stronger | completion | CC §C5, §C2 |
| 17 | YB4 S1–S5 (Y4 wording, completions) | wording | YB4 §4.2 (item 102) |
| 18 | N3-P1 met in N3-RED's form, not its letter | scoring | N4 §2.8 (item 93) |
| 19 | NB4's round-4 comparison with N4, YB4's with Y4 (no advisor did them: A6 handed back first) | — | **this reconciliation**: NB4 vs N4 — no divergence of truth; D1–D7 above (sign, headline hypothesis, TERM count, radius bound, RAY route, STUCK route, controls); YB4 vs Y4 — no divergence of truth; S1–S5 wording and completions; YB4 adds the windows' two ends and a discriminating `μ` test |

**Truth divergences between the sides across four rounds: none.** Every divergence of truth was found by a verifier or an advisor (items 5, 8, 12) or
was in owner text (items 4, 11). Retractions: N 1, Y 2, A2 0 (round 1); N2 1, Y2 1, A3 0 (round 2); N3 1, Y3 1, A5 0 (round 3); N4 1 (textual), Y4 0 (round 4)
— all free.

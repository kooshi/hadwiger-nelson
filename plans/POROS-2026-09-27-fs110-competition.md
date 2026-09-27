# Poros — FS-110, the tangency seam: the competition (job FS110-A2, the competition advisor, 2026-09-27)

*Opus 5.5. Brief `data/fs110/briefs/A2-110-competition-advisor.md` with `data/fs110/briefs/STANDING-RULES.md`. I advise the proof side FS110-N
(`ae47a8700284f84b3`, record `plans/FS110-N-proof.md`) and the construction side FS110-Y (`a8008ddea1e178569`, record `plans/FS110-Y-construction.md`)
identically, and carry nothing between them. I touch only this record and `data/fs110/fs110-a2/`. Every result below is one mind (mine) unless marked,
at the grade stated.*

## Theorems this phase proved

- **A2-ESC4** — at a cone vertex `v` of a map, C-T-TAN's `T_v` (TS l. 258) is null for direction `e` iff two classes of `P(v)` lie in opposite closed
  half-planes of `e⊥`; for a four-colour vertex whose four sectors are distinct colours, each below `180°`, this holds on an open set of directions
  with **no colour repeated** (the line `e⊥` through two opposite sectors leaves one class wholly on each side; the antipode of one sector meets the
  opposite sector in an open arc; four right angles: every direction but the four along its boundary rays). So a four-colour vertex is an escape of C-T-TAN's
  pigeonhole that is neither a tangent interface nor a bowtie in the sense of C-TAN-POS's "strong escape" ("a colour in two sectors straddling the
  tangent line with margin"). [hand, one mind, sketch] — Stage 1, H3. (The claim list already names four-colour vertices under V5 and C-SEAMLIST; the
  point is C-TAN-POS's wording.)
- **A2-V56** — a vertex of a full tight a.e.-proper map has `|P_cl(v)| ≤ 4`: by A-CIRC, `ω(v)`'s tile-interior points carry the colours outside `P_cl(v)`,
  and one colour cannot fill a unit circle (two of its points `60°` apart are at distance 1; A-EXACT). At `|P_cl(v)| = 4` the circle is two-coloured in
  the rigid alternation `c(x + 60°) ≠ c(x)`. [hand, one mind, trivial] — Stage 1, H4.

## Would-have-searched-here log (standing rule 3)

- (none yet)

## Fence log

- No fence touched. I read the competitors' briefs (both are in my reading list) and the planning advisor's record (mine to carry forward).

## Stage 0 — SAVED: quotation check (standing rule 5) and reading

| quotation in my brief or the launch message | source | result |
|---|---|---|
| Kooshi, rule 0 ("From here on out, you may doubt … you will surprise yourself.") | `CLAUDE.md` § Counter-priors, read from disk | verbatim |
| Kooshi, rule 4 ("A proven theorem about why its impossible is also valid. All novel knowledge is a success.") | `CLAUDE.md` § Where the problem stands, item 23 (checked by FS110-A, stage 0) | verbatim |
| the ban's intent; "search for a finite graph is out. It would be huge, not feasible." | `CLAUDE.md` § Toolchain; § Publication (checked by FS110-A) | verbatim |
| "(G51: zero retractions means the disagreement has not started)" (brief, item 2) | G51: "zero is not agreement, it means the disagreement has not started yet" | not in quotation marks in the brief; sense kept |
| the hand-back text | brief § Rules: "FS110-A2 idle; no content in this hand-back; my reports go to the owner by SendMessage"; the launch message: "FS110-A2 idle; report sent to the owner by SendMessage" (standing rule 9's form) | **two texts, both content-free.** I use the brief's for interim hand-backs and the launch message's as the final turn's text |
| C-TAN-POS, A-EXACT, A-CIRC, A-SIX in `data/fs110/claims.md` §1b | `plans/POROS-2026-09-27-fs110-tangency-seam.md` Theorems section and §1.7 | verbatim; C-TAN-POS's "a double unit-arc seam" is the hunch's "a double unit-arc seam centred at `w₀`" shortened, sense kept |

**Read from disk** (in full unless marked): `CLAUDE.md` § The aim, § Counter-priors, G82, G51 (G71, G79 as loaded; unchanged on disk by grep of
their first lines); `LEDGER.md` rows 131–133; `data/fs110/claims.md`; `plans/FS110-tangency-seam.md` §G part 3, §PA, §IQ, §5.1–5.3; the planning
advisor's record in full (its §1.4 routes read and fenced from both sides); `plans/POROS-2026-09-27-fs107-competition.md` §5;
`plans/PROTOCOL-competitor-and-advisor.md` §1 and the ninth run; both competitor briefs (they differ only in § Your side, the fences' names and the
tools paragraph); `plans/FS106-TS-derivation.md` l. 255–262 (C-TAN's statement and its cone failure set). Poros: the core skill in full; the
companions `poros-reframing` and `poros-anomaly-hunt` by structure only, to be loaded in full at an impasse.

**First move (09:31 UTC):** the pre-round question sent to both sides, identical text, by SendMessage, before my expectation was written. It carries
no route: it names the two programmes only as `claims.md` states them.

## Stage 0 — SAVED

## Stage 1 — SAVED: my expectation, written before either side's first card

### 1.1 The frame (the planning advisor's §1.1, re-read; one change)

- **Object:** six open unit-distance-avoiding sets, each a locally finite union of curvilinear polygons of bounded arc complexity, with dense union.
- **Question:** its existence (Q-full); the vertex rule (Q-rule_cl, working; Q-rule_ess, fallback); Act One.
- **Discipline:** first-order cone geometry at a vertex (C-T-TAN's slices; convex-geometry language: which sector lies in which closed half-plane);
  second-order contact (A-PAR); circle colourings (the bicycle); a global count (Euler on the torus, K-DENS) for the NO.
- **Audience:** a reader of `[SokolovVoronov2025]` Question 2.
- **Product:** each seam closed, realised, or a named GAP; Q-full decided if the round reaches it.
- **The change:** the planning advisor's frame puts the escapes in three kinds (tangent, bowtie, cusp) plus V5 as a side list. Read from C-T-TAN's own
  failure set (TS l. 258: "`T_u` is null iff two classes of `P(u)` lie in opposite closed half-planes"), **the escape is one condition — two classes
  in opposite closed sides of `e⊥` — and the kinds are how a vertex meets it**: an edge point only at its tangent direction; a three-sector ring
  junction only along a shared ray (tangent, decided at second order); a bowtie on an open set of directions; **a four-colour vertex on an open set,
  with no colour repeated** (A2-ESC4). The seams are one inequality read on four vertex figures.

### 1.2 Where I expect each side to break (obstacles, not odds)

| step | the obstacle | which side it bites |
|---|---|---|
| **C-TAN-POS as worded** | its escape list ("a strong escape on one side or a double unit-arc seam") omits the four-colour vertex, which escapes on an open set of directions with no repeated colour (A2-ESC4). Expected verdict at stage 1: **MISSTATED** (TRUE for pairs of three-sets). A side that returns TRUE without restricting it has read the (3, 3) case only | both, at stage 1 |
| **the global NO** (C-ACT1, C-BOW-K (ii), C-SEAMLIST complete) | escapes on open direction sets (bowtie, four-colour vertex) make Q-rule_cl a weak local filter: every edge point against a four-colour vertex is a covering pair saved by an open condition. A NO must come from a count fed by the local rule (the plan's §IQ warning), and the count must spend six somewhere the seven-colour controls do not | N, at the global claims |
| **the cascade at a four-colour vertex** | at `\|P_cl(v)\| = 4`, `ω(v)` is two-coloured in the rigid `60°` alternation (A2-V56); its colour switches are edge points at distance 1 from `v`, covering partners of `v`, and at the four boundary-ray directions `v` blocks at second order (depth `≍ s²/2`, the V-C5 shape), so the switches must avoid those positions. Each four-colour vertex therefore constrains a whole unit circle of the map | Y first (it will want four-colour vertices); N may use it |
| **the double unit-arc seam's cascade** | as the planning advisor's §1.5: `w₀, w₀′` become vertices whose own close pairs must be seams; a YES needs it periodic, a NO needs it to fail finitely | both |
| **the bicycle** (C-T-BIKE) | still the hardest local object: a one-dimensional forced set `F` on one circle per `(d, φ)` (TS C-T-BIKE (iii)); a scan over `φ` is banned, so a verdict needs a derived family or an invariant | both |
| **A-SIX** | a reading step: another use of `\|P\| = 3` inside TS stage 4 would break it. My reading of l. 258 finds only the pigeonhole and the definition of `T_u`, which is size-free | both, stage 1 |
| **D-TYPE** | expected TRUE in `𝓜_K`: a tile whose closure contains `u` has, near `u`, finitely many sectors; its density is zero iff every sector has angle 0, and a horn between two arcs with one tangent has width `o(r)` | both, stage 1 |

### 1.3 What I watch for (G21; the brief's item 5)

- a seam kind outside C-SEAMLIST: the four-colour vertex is **in** the list (V5) but **outside** C-TAN-POS; a side that proves C-TAN-POS as worded and
  then uses it to close the tangent seam has closed less than it says;
- a local TRUE for an escape scored as a refutation of the NO (C-BOW-K (i), and A2-ESC4 itself, are local and are not);
- a candidate map that is a seven-colouring in disguise (a colour used only where the hexagonal seven-colouring's seventh class sits; a six-map
  whose checker ACCEPT comes from a missed pair — X17);
- **five-colour and six-colour vertices**: excluded by A2-V56 at once; a side that spends effort on them has missed A-CIRC's direct consequence.

### 1.4 Hunch ledger (FS110-A's five carried as they stand; mine added)

hunch: c5-fails-in-band-form-at-unit-arcs
  claim: a ring junction whose tangent interface is an arc of the unit circle about `w₀` has no forced band along `e_u` on either side
  basis: derived
  falsifier: an explicit ring junction with a unit-arc interface and a side `ρ` of one sign on which `ω(w₀ + ρe_u)` meets all three colours within `B(u, s)`
  registered: 2026-09-27 (FS110-A)
  status: open

hunch: tangency-is-no-escape-against-a-blocking-partner
  claim: at positive scale a complementary pair survives at `w₀` only by a strong escape on one side or a double unit-arc seam centred at `w₀`
  basis: derived
  falsifier: a tight map in `𝓜_K` with a complementary pair at `w₀` where one side is a ring junction and the other blocks with margin
  registered: 2026-09-27 (FS110-A)
  status: open — **at risk as worded** for covering pairs of sizes (2, 4) (A2-ESC4); for three-sets I expect it to stand

hunch: cusps-close-under-closure-types
  claim: with closure types, a cusp vertex's blocking set near `w₀` is nonempty, so the cusp seam reduces to the tangent seam
  basis: derived
  falsifier: a cusp vertex with a blocking partner whose blocking set near `w₀` is empty
  registered: 2026-09-27 (FS110-A)
  status: open

hunch: bowtie-and-bicycle-outlive-tangent-and-cusp
  claim: at FS-110's close the seams still live, if any, are the bowtie and the same-type bicycle, not the tangent or the cusp
  basis: prior
  falsifier: FS-110 closes the bowtie or the bicycle while the tangent or cusp seam stays open
  registered: 2026-09-27 (FS110-A)
  status: open — I add the four-colour vertex to the survivors (A2-ESC4)

hunch: complementary-means-union-six
  claim: C-T-TAN holds for disjoint types of sizes (2, 4), so four-colour vertices belong in the exception list
  basis: read
  falsifier: a step of C-T-TAN's proof (TS stage 4) that uses `|P(u)| = 3` beyond the union
  registered: 2026-09-27 (FS110-A)
  status: confirmed (by: `plans/FS106-TS-derivation.md` l. 258, re-read by me: the pigeonhole "(all six classes are in `P(u) ∪ P(v)`)" and a size-free `T_u`)

hunch: c-tan-pos-misstated-at-four-colour-vertices
  claim: C-TAN-POS as worded is MISSTATED on covering pairs: a four-colour vertex with four distinct sector colours escapes on an open set of directions with no colour repeated
  basis: derived
  falsifier: a four-colour vertex, all sectors below `180°`, whose `T_v` has positive length for every direction in an open set (it would show the cone criterion misread)
  registered: 2026-09-27
  status: open

hunch: the-no-stalls-at-the-count-not-at-a-seam
  claim: the proof side's first GAP is at a global claim (C-ACT1, C-BOW-K (ii) or C-SEAMLIST's completeness), not at a local seam
  basis: prior
  falsifier: FS110-N's first GAP at a local claim (C-TAN-K, C-T2 (i), C-CUSP-K, C-BOW-K (i), C-T-BIKE)
  registered: 2026-09-27
  status: open

hunch: the-yes-breaks-at-the-cascade
  claim: the construction side realises at least one seam locally and breaks at the first cascade (a unit circle about a four-colour vertex, or the rhombus's `w₀, w₀′`), not at a first-order vertex rule
  basis: prior
  falsifier: FS110-Y's first named obstruction is a first-order vertex rule (a vertex figure no tight map can carry)
  registered: 2026-09-27
  status: open

hunch: the-registrations-name-global-steps
  claim: each side's pre-round answer names a global step of the other (N names Y's full map or its exact check; Y names N's Act One or completeness)
  basis: prior
  falsifier: either answer names a local seam
  registered: 2026-09-27
  status: open

### 1.5 Evidence inventory

- `plans/FS106-TS-derivation.md` l. 258, C-T-TAN's cone failure set — read against: tangent and bowtie as the only cone escapes — surprised: yes, the criterion is size-free and a four-colour vertex meets it on an open set with no repeated colour
- `data/fs110/claims.md` §1b C-TAN-POS — read against: an escape list matching C-T-TAN's failure set — surprised: yes, it omits the four-colour vertex that V5 in the same file lists
- `plans/POROS-2026-09-27-fs107-competition.md` §5.9 — read against: the round's aim is the meeting rule, with both sides on it — surprised: no
- `plans/PROTOCOL-competitor-and-advisor.md` ninth run — read against: divergences of truth came from verifiers, none from the competitors — surprised: no
- the two briefs — read against: identical but for § Your side — surprised: no (the fences and tools paragraphs also differ, by name only)

## Stage 1 — SAVED

## Stage 2 — the registrations and the stage-1 comparison (in progress)

### 2.1 The pre-round answers, verbatim

**FS110-Y** (received about 09:50 UTC; its stage 1 committed at `44eb74cb` before sending), verbatim:

> FS110-Y pre-round answer (stage 1 committed at 44eb74cb before sending).
> Step: C-BOW-K (ii), the global clause "no tight 𝓜_K map uses strong escapes at every close covering pair". Expected: GAP (out of reach this round).
> Mechanism: a strong escape costs nothing locally (B_u ∩ B(w₀,c) = ∅, so C-BOW-K (i) is TRUE), so the kill must be global; the global instruments on the list are blind there — Euler on the torus reads no geometry, density is one-class-at-a-time (K-INT), the index is dead at bowties (row 132), and §IQ's warning says a local-rule problem is not closed by exhausting vertex configurations. No area price for a bowtie exists.
> Stage-1 verdicts (plans/FS110-Y-construction.md §1.3–1.4, one mind each here): A-EXACT TRUE, with "meets a tile" read as "meets the interior of a tile" (the closure reading fails exactly at cusps); A-CIRC TRUE, cusp colours included (no angle used); A-SIX TRUE (sizes enter only the failure-set analysis; a bichromatic degree-≥4 vertex blocks every direction, a four-colour vertex escapes on an open set); D-TYPE TRUE (P_cl ∖ P_ess = colours all of whose corners at u are cusps); C-TAN-POS TRUE at the level of A-EXACT's disjointness test — blocking sets near w₀ come in five shapes (ball/slab, one-sided band from T1 or a cusp, thin double wedge from T2, empty from a strong escape), and only T2–T2 or a strong escape survive.
> Prior art: none new yet.

Scored at once: hunch `the-registrations-name-global-steps` — Y's half **confirmed** (C-BOW-K (ii), a global clause).

**FS110-N** (received about 10:00 UTC; its stage 1 committed at `a912d7c3` before sending), verbatim:

> FS110-N pre-round answer (stage 1 committed: a912d7c3). The step: C-T2 (ii), global — a whole tight 𝓜_K map using the double unit-arc seam at every close covering pair it does not otherwise escape.
> Expectation: FALSE at every K (my second choice: out of reach of any formula).
> Mechanism: a double unit-arc seam is not local — its four points become vertices carrying unit arcs and escape colours, and each of them acquires new close covering pairs (the rhombus's own pairs, and pairs with the vertices at the ends of the new unit arcs), each of which must again be a seam. I expect this cascade not to close at bounded complexity: either the unit arcs per unit disc exceed K, or the escape colours pile into one class above 0.2470.
> The local fragment (C-T2 (i)) I expect to be realisable; my bet is against the gluing, not the seam.

Scored: `the-registrations-name-global-steps` — **confirmed** (both answers name a global clause: Y names C-BOW-K (ii), N names C-T2 (ii)). The two
registrations are not each other's negation this time: **each side bets against the other's cheapest escape** (N against the double unit-arc seam's
gluing; Y against the global kill of strong escapes). Together they say the round's decisive object is a map that mixes the two escapes, which
neither registration addresses.

### 2.2 The stage-1 comparison (both records read in full at their stage-1 commits: Y `44eb74cb`, N `a912d7c3`)

| claim | FS110-Y | FS110-N | agree? |
|---|---|---|---|
| A-EXACT | TRUE; "meets a tile" read as "meets the interior" (the closure reading fails at cusps) | TRUE; tiles are the open components of `ℝ² ∖ Γ` (same reading); **consequence extended to covering pairs with overlap and covering families** ("disjointness unused"), and the **sight form** `S(z) ≠ [6]` for every `z` | truth yes; **scope differs** (N drops disjointness) |
| A-CIRC | TRUE, cusp colours included (connected `D × Σ`) | TRUE, cusp colours included (shift the centre) | yes; two routes, both sound by my reading |
| A-SIX | TRUE; failure set redone by size: bichromatic degree-`≥ 4` blocks every direction, **four-colour vertex escapes on an open set** | TRUE "and more" (overlap unused too); failure set not redone | truth yes; **Y has A2-ESC4, N does not** |
| D-TYPE | TRUE, "colours all of whose corners at `u` are cusps" | TRUE, same precision | yes (two minds, independent) |
| C-TAN-POS | **TRUE** at the level of `B_u ∩ B_v = ∅`, read from `u`'s and `v`'s figures (Y-BLOCK: five shapes; T2–T2 or a strong escape survive), four-colour vertices placed inside "strong escape" | **split**: TRUE and exact when `w₀` is not a vertex (N-SEAM, read from `w₀`'s figure), **GAP** when `w₀` is a vertex | **grade differs**; routes are complementary (Y reads `u, v`; N reads `w₀`) |

**My reading of each, as a third mind (hand, sketch):**
- **N-SEAM (a)** ("`w₀ ∈ Γ`") is sound and strong: a tile at `w₀` of colour `k ∈ P_cl(x)` contradicts A-CIRC at `x`. It holds for every covering pair at
  distance `< 2`, with no scale. **N-SEAM (c)** is sound (a C¹ arc cannot be tangent to two transversal circles). **N-SEAM (d) is short at `|P(x)| = 4`**:
  TS-U forbids the two arc colours in the side cones, so the side cones carry colours of `P(x) ∖ {c, c′}` — **one** colour in both (a bowtie) only when
  `|P(x)| = 3`; at a four-colour vertex the two side cones may carry two different colours. "A colour in two sectors" is then false; the escape is A2-ESC4's.
- **Y-BLOCK's "exactly five shapes" is short**: its "fat" row ("all three sectors meet both open half-planes of `e_u^⊥`") is **empty** for three
  sectors (a line through `u` has two rays; a sector containing neither lies in one open half-plane), and the **generic** trivalent vertex — one sector
  wholly on one side, so a **one-sided block of depth `≍ s`** (V-C5's "on one side or the other") — is not a row. Y's pair conclusions survive (one-sided
  against one-sided meet in a quadrant; a two-sided wedge enters any one-sided region), so C-TAN-POS's verdict is unaffected; the "exactly" is not earned.
- **The two C-TAN-POS routes combine**: Y's is necessary from `u, v` and needs no `w₀` figure, so if its shape list is complete it closes N's vertex-`w₀`
  GAP; N's is exact at `w₀` and adds to Y's escapes the requirement that a non-vertex `w₀` lie on a unit arc centred at the escaping vertex (Y's §1.5
  has the same reciprocal arc as an exception). Neither route is passed to the other side.

**Hunches scored:** `c-tan-pos-misstated-at-four-colour-vertices` — **confirmed by a second derivation** (Y-SIX, independent of me: "a four-colour vertex
escapes on an open set"); N's N-SEAM (d) shows the cost of the claim list's wording (a statement true only at `|P| = 3`).

### 2.3 Card 1, to both sides at the same moment (text in `data/fs110/fs110-a2/card1.md`)
Four scope questions, sent identically: (1) disjointness — used, or only the union?; (2) is the four-colour vertex inside "strong escape", and is
every statement concluding "a colour in two sectors" true for it?; (3) one-sided blocking (V-C5's own words) — is the generic three-sector vertex an
entry of any blocking classification, and is "exactly" earned?; (4) C-TAN-POS's two grades differ — state each verdict's scope and the necessary
condition it rests on. No route of either side is in it: every point is a question about `claims.md`'s words or TS l. 258; point 2 is marked as my
own sketch; point 4 names grades only. Retractions from here are counted (G51).

card: c1-the-stage-1-scope-questions
  evidence: Y-BLOCK (`plans/FS110-Y-construction.md` §1.4) has an empty "fat" row for three sectors and no one-sided depth-`s` row; N-SEAM (d) (`plans/FS110-N-proof.md` §1.4) concludes "a colour in two sectors" from TS-U, true only at `|P(x)| = 3`; N drops disjointness, Y keeps it; C-TAN-POS TRUE (Y) against TRUE/GAP (N)
  expected: the two stage-1 records agree on every verdict and scope, as the planner's E1 (A-EXACT confirmed by both, 0.85) presumed
  ask: does each side's verdict hold at the scope it states — covering pairs with overlap, four-colour vertices, one-sided three-sector blocks, vertex `w₀`?
  if a side amends: a free retraction in the window, recorded; the seam work starts on a calculus both sides share
  if neither amends: the divergences go to the blind verifiers as named points, and I re-raise them at the hand-backs
  answered by: FS110-N and FS110-Y, each on its own record
  cost: one reply each, if anything changes
  hunch: N amends N-SEAM (d) and Y amends Y-BLOCK's "exactly"; neither changes a verdict
  falsifier: either side changes a verdict (TRUE, FALSE, GAP) on a §1b claim
  rank: 1

## Stage 2 — SAVED

## Stage 3 — card 1's answers and the seam round (in progress)

### 3.1 Answers to card 1

**FS110-N** (about 10:15 UTC; committed `0b2ab4a0`, its stage 3), verbatim:

> FS110-N, one retraction after card 1 (committed 0b2ab4a0, record plans/FS110-N-proof.md stage 3).
> Point 2 — RETRACTED in part: wherever I concluded "a colour in two sectors" (strong escape) at a centre x, that holds only when |P_cl(x)| = 3. With |P_cl(x)| ≥ 4 the two side cones may hold two different colours, as in your four-sector example. Every such statement now carries the type-size condition.
> Point 3 — one wording change: a list I had headed "exact" is necessary conditions ("only if"), not "iff"; heading corrected.
> Points 1 and 4 — no change. My statements use only the union P_cl(u) ∪ P_cl(v) = [6] (overlap allowed; the first two extend to families concyclic on the unit circle about w₀), except one, which uses disjointness and says so. My C-TAN-POS verdict: TRUE when w₀ is not a vertex (any closure types at u, v with union [6], |u − v| < 2; rests on A-CIRC in closure form plus an exact contact lemma, and TS-U for the side cones); GAP when w₀ is a vertex.

**Retraction count:** N 1 (N-SEAM (d)'s "a colour in two sectors", killed by card 1 point 2; free) plus one wording change (not counted). My hunch on
card 1 (`N amends N-SEAM (d) and Y amends Y-BLOCK's "exactly"; neither changes a verdict`): N's half **met**.

**FS110-Y** (about 10:20 UTC; recorded at `8d935aa7`, its stage 3), verbatim:

> FS110-Y retractions after card 1 (recorded at 8d935aa7, plans/FS110-Y-construction.md stage 3).
> R1 (your point 3, checked): my §1.4 "fat" row ("contains the whole ball") is empty for trivalent vertices. The generic trivalent vertex blocks a one-sided band of depth ≍ s·margin; a two-sided ball arises only at degree ≥ 4 with no escape. "Exactly five shapes" withdrawn: completeness not claimed. C-TAN-POS verdict unchanged (band vs band fails: ζ ↦ (ζ·e_u, ζ·e_v) is a linear iso, so two half-open bands meet near w₀; band vs thin wedge fails).
> R2 (your point 2, checked): "strong escape" as defined in claims.md is MISSTATED — the four-distinct-colour vertex escapes on an open set with no colour repeated. Corrected: "two sectors straddling every line of tilt < µ from the tangent line, with at least one colour of P(u) wholly on each side"; my table row replaced.
> Point 1: all my statements use only the union covering six, so they hold for overlapping pairs; for families of ≥ 3 points A-EXACT still gives ⋂B = ∅, but the pair argument does not transfer (three one-sided bands through w₀ can have empty intersection).
> Point 4, scope: at u, v — trivalent (generic, T1, T2), bowtie, four-colour, cusp vertices of 𝓜_K, and bichromatic degree ≥ 4 against a four-set; nothing assumed at w₀; rests only on A-EXACT's B_u ∩ B_v = ∅.
> Also new since stage 1 (stage 2, cb156b1c): an exact curved checker with controls; the T2 picture at w₀ (degree ≥ 4, alternating branches); Y-BIKE-3C, a no-go for six-arc three-cycle colourings of the bicycle at every d ∈ (1,2).

**Retraction count after card 1:** N 1; Y 2 (R1, "exactly five shapes"; R2, its stage-1 reading of "strong escape" replaced by a MISSTATED verdict on
the claim list's definition with a corrected statement); A2 0. All free. My card-1 hunch: **met** (N amended N-SEAM (d), Y amended Y-BLOCK; no §1b
verdict changed — C-TAN-POS stays TRUE (Y) and TRUE/GAP (N)). **Both sides now hold the same corrected strong escape** (a class of `P(u)` wholly on each
side), reached independently from one question.

**The scope of C-TAN-POS after card 1 (the two verdicts, set side by side):** Y — TRUE for every covering pair (overlap allowed) of the named vertex kinds
at `u, v`, nothing assumed at `w₀`, from `B_u ∩ B_v = ∅`; N — TRUE and exact at a non-vertex `w₀` for any closure types, GAP at a vertex `w₀`, from
A-CIRC plus the contact lemma. **They are not in tension**: Y's covers N's GAP only as far as Y's vertex list is complete, and Y has withdrawn the claim
of completeness. So C-TAN-POS stands at **TRUE for the named vertex kinds (Y, one mind) and TRUE at non-vertex `w₀` (N, one mind), with completeness of
the vertex kinds at `u, v` open** — which is C-SEAMLIST's question in another place. That is the next thing I watch.

## Stage 3 — SAVED

## Stage 4 — SAVED: round 1's comparison at both hand-backs (brief item 6)

*Read in full at the hand-back commits: `plans/FS110-N-proof.md` (stages 1–3, `0b2ab4a0`), `plans/FS110-Y-construction.md` (stages 1–3, `8d935aa7`),
`data/fs110/reports/FS110-N.md`, `FS110-Y.md`. Neither blind verifier is running; nothing here went to a side. Successors FS110-N2 and FS110-Y2 were
launched by the owner; on Y2's request card 1 was resent verbatim to **both** (N2 too, so the two hold one text), with a round-2 pre-round question and
A2-V56 as a frame fact (`data/fs110/fs110-a2/round2-open.md`).*

### 4.1 Convergences of truth (independent unless marked)

| finding | N | Y | minds now |
|---|---|---|---|
| A-EXACT, A-CIRC (cusp colours included), A-SIX, D-TYPE | TRUE | TRUE | A-EXACT, A-CIRC, A-SIX three (FS110-A, N, Y); D-TYPE two (N, Y) |
| types need only the union `[6]`; overlap allowed | stage 1, unprompted | after card 1 | two |
| the corrected strong escape ("a class of `P(u)` wholly on each side"): four-colour vertices escape with no colour repeated | after card 1 | **stage 1, unprompted (Y-SIX)** | three (A2, Y independent; N after the card) |
| **C-CUSP-K TRUE** (the cusp seam closes on closure types) | N-HORN (a horn is seen like a ray; missed from both sides iff `κ₂ ≤ 1 ≤ κ₁`) and N-SEAM's exact route | Y-BLOCK's cusp row (a one-sided band) | two, different routes; FS110-A's hunch `cusps-close-under-closure-types` confirmed |
| **C-TAN-POS TRUE** where each derivation reaches | at a non-vertex `w₀`, exact (N-SEAM) | for the named vertex kinds at `u, v` (Y-BLOCK) | two, complementary routes; neither covers the vertex-`w₀` case with a complete vertex list |
| **the seam point `w₀` of a surviving pair without a unit arc is a vertex of degree `≥ 4` whose tiles alternate between the two points' colours around the four unit tangents** | N-X (a): pattern `v, u, v, u`, at least four colours at `w₀` | Y-T2W: "degree `≥ 4`, with alternating branches" (for T2) | two, independent, for different sub-cases (N: no unit arc at `w₀`; Y: T2) |

### 4.2 Divergences

- **Of truth: none.** (As at FS-106 and FS-107: every correction came from the claim list's words, not from one side against the other.)
- **Of scope:** C-SEAMLIST — N: **MISSTATED** (it lists failures of C-T-TAN's density hypotheses, not of the map's survival; corrected to the dichotomy
  (S1)/(S2) at `w₀`, proved complete, "only if"); Y did not work it. C-TAN-POS — as in stage 3. "Strong escape" — Y: **MISSTATED** as defined; N: its
  statements carry the type-size condition. Both are corrections owed to `claims.md`.
- **Of route:** N reads the seam point `w₀` exactly, on LIM, with no scale (N-SEAM: A-CIRC in closure form plus an exact contact lemma); Y reads the
  vertex figures at `u, v` through blocking sets at scale `s` (Y-BLOCK). Y built an exact curved checker (7 controls, 4 plants) and a family no-go on the
  bicycle (Y-BIKE-3C, correctly scoped to its family: "What it leaves: colourings not periodic in `60°` cells"). N wrote no tools.

### 4.3 Retractions (from the registrations on)

| mind | count | what, and what killed it |
|---|---|---|
| N | 1, free | N-SEAM (d)'s "a colour in two sectors" at type size `≥ 4` — card 1 point 2 |
| Y | 2, free | Y-BLOCK's "fat" row and "exactly five shapes" — card 1 point 3; its stage-1 reading of "strong escape" — card 1 point 2 (now MISSTATED on the list) |
| A2 | 0 cards retracted; 1 hunch killed | `the-no-stalls-at-the-count-not-at-a-seam` (4.5) |

**As at FS-107, the disagreement proper never started**: every retraction was a side against the claim list's words, prompted by one card. The two
registrations were not each other's negation; each bet against the other's cheapest escape, and neither side reached the step the other bet against.

### 4.4 Break points

- **N:** C-ACT1 untouched ("the step the NO most needs"); the vertex case (S2) with some unit arcs at `w₀` (T2 among them) a GAP; C-T2, C-BOW-K, C-V5-K,
  SEAM-S not worked. N's one observation on Act One: a four-colour vertex's circle meets at most two colours, and a switch point on it is a covering
  pair at distance 1. **With A2-V56 (one colour cannot fill a unit circle), every tight six-map with a four-colour vertex has a covering pair at distance
  1: Act One's open case is the maps whose every vertex has at most three colours** (bowties included). [hand, one mind for the combination: A2]
- **Y:** C-T2 (i) a GAP at the construction (the `d = 1` rhombus in `ℚ(√3)`, not built for budget); C-T-BIKE a GAP beyond the `60°`-cell family.

### 4.5 Predictions scored

- **The registrations:** Y's (C-BOW-K (ii) GAP) and N's (C-T2 (ii) FALSE) — both **untested**: neither side reached the step the other bet against.
- **The planner's §5.3:** E1 (A-EXACT confirmed by both, 0.85) **met**. E2 (SEAM-T1 closed at positive scale, 0.7) **met at one mind** (Y's T1 rows; N's
  (S1)/(S2) implies it with no scale). E3 (T2 realised locally, 0.4) **not met** (GAP at the construction). E4 (C-BOW-K (i) TRUE, 0.6) **met, one mind** (Y).
  E5 (SEAM-C reduces to SEAM-T, 0.6) **met, two minds**. E6 (C-T-BIKE decided, 0.3) **not met** (a family no-go). E7 (Act One, 0.45) **not met**; reduced
  to maps with at most three colours per vertex (4.4). E8 (C-SEAMLIST extended by an unnamed kind, 0.25) **not met in its letter**: no new kind, but the
  list re-derived as a dichotomy at `w₀` and found MISSTATED (N). E11 (a named obstruction, 0.8) **met** (N-X; Y-BIKE-3C). E9, E10, E13 untouched; E12
  waits on the verifiers.
- **FS110-A's hunches:** `c5-fails-in-band-form-at-unit-arcs` — **confirmed by an independent derivation** (Y-BLOCK's T2 row: a thin double wedge, no
  band); `tangency-is-no-escape-against-a-blocking-partner` — **confirmed by an independent derivation** with its "strong escape" corrected (Y: band against
  wedge fails at every positive depth); `cusps-close-under-closure-types` — **confirmed, two minds**; `bowtie-and-bicycle-outlive-tangent-and-cusp` — open,
  **as predicted so far** (T1 and cusp closed at the pair level; bowtie, bicycle and T2 open); `complementary-means-union-six` — confirmed (stage 1).
- **Mine:** `c-tan-pos-misstated-at-four-colour-vertices` — **confirmed, two minds** (Y independent). `the-no-stalls-at-the-count-not-at-a-seam` —
  **killed**: N's first GAP was local (C-TAN-POS at a vertex `w₀`, stage 1); my falsifier's list of local claims omitted C-TAN-POS itself, a G21
  instance of my own. `the-yes-breaks-at-the-cascade` — open (Y realised no seam; its first obstruction is a family no-go on the bicycle, not a vertex
  rule). `the-registrations-name-global-steps` — confirmed.

### 4.6 What round 2 should aim at (a decision in four parts, for the owner)

- **The choice:** aim both sides at the **seam point `w₀`** as the object: N-SEAM's dichotomy says a surviving pair has at `w₀` either (S1) a unit arc
  centred at an escaping vertex, or (S2) a vertex of degree `≥ 4`, which without unit arcs is a four-colour vertex whose unit circle spawns covering
  pairs at distance 1 (N-X). Concretely: the proof side takes **Act One on maps with at most three colours per vertex** (the four-colour case is closed,
  4.4) and **(S1)'s cascade** (the escaping centre's own unit circle); the construction side takes **(S1) first** — one unit arc through `w₀` centred at a
  bowtie — before the double rhombus.
- **The alternative weighed:** the successors' briefs as the owner wrote them — the construction side starting on the T2 rhombus at `d = 1` in `ℚ(√3)`,
  the proof side on C-T2 (ii) and C-BOW-K (ii).
- **Why this one:** (S1) is the only escape at a non-vertex seam point (N-SEAM, one mind), needs one unit arc and one bowtie against T2's four unit arcs
  and two vertices of degree `≥ 4`, and has a checked local model (Townsend's `⅔π` sector, TS-U's control); and Act One, which decides whether seams are
  needed at all, is now half closed. Both round-1 records reach the four-colour vertex at `w₀` independently (4.1, last row).
- **Confidence: medium.** It changes if (S1) is shown inconsistent in a line (TS-U at the bowtie centre forbidding the repeated colour in the side cones),
  which would make T2 the cheapest live seam after all.
- **Default:** if the owner changes nothing, the successors work their briefs' lists and I advise them identically; this recommendation is not sent to
  either side (it rests on both sides' round-1 routes).

## Stage 4 — SAVED

## § Continuation — FS110-A3

*Poros (Opus 5.5), 2026-09-27, taking over at round 2. Brief: `data/fs110/briefs/A3-110-competition-advisor-continued.md` (wins where it differs)
with FS110-A2's brief and `STANDING-RULES.md`. Sides: FS110-N2 (`adfbdc9b283eb0c65`, `plans/FS110-N-proof.md` § Continuation — FS110-N2) and
FS110-Y2 (`adcd3fb432b11b1b7`, `plans/FS110-Y-construction.md` § Continuation — FS110-Y2). I touch only this section and `data/fs110/fs110-a3/`.
Every result here is one mind (mine) unless marked.*

### Theorems this phase proved (FS110-A3)

- **A3-HOLE** — A2-V56's step "one colour cannot fill a unit circle" and the Act One combination's step "a switch point between the two outside
  colours on `ω(v)` is a covering pair with `v`" both assume that `ω(v) ∩ Γ` contains no arc. When `ω(v)` carries unit arcs of `Γ` centred at `v`,
  their side colours lie in `P_cl(v)` (TS-U), so the tile-interior arcs of `ω(v)` may each be shorter than `60°` and one colour each, separated by
  those unit arcs, and an endpoint `y` of such an arc has `P_cl(v) ∪ P_cl(y) ⊇ P_cl(v) ∪ {a}`, five colours, not six. So A2-V56 is TRUE for vertices with
  no arc of `Γ` on their unit circle and a **GAP** otherwise; the combination is TRUE for four-colour vertices whose unit circle meets the two outside
  colours at a point, and a **GAP** at four-colour vertices whose outside colours are separated on `ω(v)` by unit arcs centred at `v`. [hand, one mind,
  sketch; not a refutation — no such vertex is built, and TS-U's side-cone conditions at `v` may exclude it.] **Consequence:** "Act One's open case is
  the maps whose every vertex has at most three colours" (A2 §4.4) is short by exactly the four-colour vertices that are centres of unit-arc seams —
  the escaping centres of (S1). Act One's four-colour remainder and round 2's (S1) are one object.

### Would-have-searched-here log (A3)

- (none yet)

### Fence log (A3)

- `ls data/fs110/fs110-a2 data/fs110/reports` (my first commands) listed the **file names** in `data/fs110/reports/` (`FS110-A.md`, `FS110-N.md`,
  `FS110-P.md`, `FS110-Y.md`); none opened. Disclosed.
- Read, not fenced for me: both successor briefs (`N2-110-proof-continued.md`, `Y2-110-construction-continued.md`), `data/fs110/fs110-a2/`. Not read:
  `plans/FS110-close-inventory.md`, `data/fs110/reports/`, the transcripts, `chats-bak/`, other scratchpad files.

## Stage A3-0 — SAVED: quotation check and reading

| quotation or fact in my brief | source | result |
|---|---|---|
| rule 0 (Kooshi, "From here on out … surprise yourself.") | `CLAUDE.md` § Counter-priors, read from disk | verbatim |
| round 1: retractions N 1, Y 2, A2 0, all free; A-EXACT, A-CIRC, A-SIX three minds, D-TYPE two; C-CUSP-K TRUE two minds, different routes | A2 §4.1, §4.3 | matches |
| "a seam point `w₀` with no unit arc is a vertex of degree ≥ 4, with alternating colours (N-X; Y-T2W)" | A2 §4.1 last row; N-X, Y-T2W | matches in sense; **scope:** N-X assumes disjoint types and no arc of `Γ` along any of the four unit directions at `w₀`; Y-T2W is the T2 sub-case with no reciprocal arc |
| A2's combination "every tight six-map with a four-colour vertex has a covering pair at distance 1" | A2 §4.4 | matches; **its step is short at unit arcs centred at the vertex (A3-HOLE)** |
| the owner's round-2 note and "a verbatim correction of its frame fact" | not on disk for me | **unread**: asked of the owner (stage A3-1 report) |
| A2-V56's text as sent to both sides | `data/fs110/fs110-a2/round2-open.md` §C | read; quoted verbatim in card 2 |

**Read from disk:** `CLAUDE.md` § The aim, § Counter-priors, G82, G51 (§ The aim on disk differs from the loaded copy: FS-106, FS-107 closed, rows 131–133,
FS-110/111 named); A2's record in full; `data/fs110/claims.md` in full; `plans/FS110-N-proof.md` stages 1–3 (§1.3–2.6 in full); `plans/FS110-Y-construction.md`
stages 1–3 (§1.4–3 in full, header); both successor briefs; `round2-open.md`; Poros core skill in full (companions not loaded: budget; to be loaded at an
impasse). Not re-read: the planning advisor's record (A2 carried its hunches, §1.4, §4.5), `plans/FS110-tangency-seam.md`.

**Clock slip (for the owner):** `date` read 09:53 UTC at my start, yet A2's record logs round-1 answers at "about 10:00", "10:15", "10:20" UTC on the
same date. A2's times are not read from the clock, or the clock moved. I log only `date` readings.

**First move (09:5x UTC, before this expectation was committed):** card 2 (`data/fs110/fs110-a3/card2.md`) sent to both sides at once, identical text:
A3-HOLE as a question about A2-V56, with no route of either side. Sent first because it changes the proof side's Act One scope while retraction is free
(G51); it carries a frame check, not a prediction.

## Stage A3-0 — SAVED

## Stage A3-1 — SAVED: my round-2 expectation (written before either side's round-2 answer reached me)

### A3-1.1 The frame, round 2 (A2 §1.1 kept; one change)

**Object:** the seam point `w₀` of a surviving close covering pair. **The change:** Act One and (S1) are not two objects. A3-HOLE puts Act One's
four-colour remainder at vertices whose unit circle carries unit arcs of `Γ` centred at them, which is (S1)'s escaping centre `x`. So the round's one
object is **a vertex `x` whose unit circle `ω(x)` contains arcs of `Γ`**: (S1) needs one through `w₀`; Act One's four-colour case survives only with
them. Discipline: first-order cone geometry at `x` (TS-U's wedges and side cones), then second-order contact at the arcs' endpoints.

### A3-1.2 Obstacles at `w₀`, by side (not odds)

| side | step | the obstacle I expect it to meet |
|---|---|---|
| N2 | **Act One, at most three colours per vertex** | `ω(u)` of a trivalent `u` is coloured by the three complementary colours with `c(x + 60°) ≠ c(x)`, and its switches may all be **edge points** (two colours): the circle alone forces no covering pair. The edges leaving `ω(u)` end at vertices within distance 2 (TS-C), but their third colour may be one of `u`'s. So Act One is a topological statement about how the complementary boundaries around `ω(u)` end (Voronov's circle index in map form, FS106-IND), and the two-coloured circle (one complementary colour absent near `ω(u)`) is its hardest case. The proof must spend six: the tight hexagonal seven-colouring has no covering pair at all. Expected: a GAP at a named topological step |
| N2 | **Act One, the four-colour remainder** | A3-HOLE: not closed. It sits at unit-arc centres, so Act One cannot be finished apart from (S1) |
| N2 | **(S1)'s cascade** | weak by my reading: an endpoint `y` of the unit arc `A ⊂ ω(x)` has `P_cl(y) ⊇ {c, c′, k}` (the two side colours, one colour beyond), so `(x, y)` is not a covering pair; the partner's circle crosses `A` at `w₀` with `c | c′` on its two sides, as A-CIRC wants. So (S1) passes every first-order test and its kill is not local at `w₀`: it needs the second unit point `w₀′`, the arc endpoints at second order, or a count (C-BOW-K (ii)) |
| Y2 | **the (S1) fragment at the second unit point** | every close pair has two common unit points; the fragment must survive at both. Checked by me, first order only, one mind (**not an obstacle**): at `d = 1` (angle `∠w₀xw₀′ = 120°`) one three-colour bowtie can escape at both, with the second arc's facing and away colours reversed and arc widths below `30°`. So the fragment is not excluded at first order |
| Y2 | **the arc's endpoints** | TS-U's side cones at `x` are swept by `ω(y)`, `y ∈ A`, whose tangent at `x` is `⊥(y − x)`; at `A`'s endpoints `ω(y)` runs through `x` exactly along a side cone's edge. So the fragment's tight contacts at the endpoints are second order at `x`: this is where Townsend's `⅔π` sharpness bites, and where I expect the first REJECT |
| Y2 | **what a fragment decides** | an exact ACCEPT certifies a local fragment; it realises C-BOW-K (i) and (S1) locally and is not a refutation of the NO (A2 §1.3). The mixed map (Y2's list, item 3) I expect untouched this round |
| both | **the generator image** | Y's checker holds `ℚ(√3)` data; an (S1) arc through `w₀` with `ℚ(√3)` endpoints exists at `d = 1`, `√3`; a zero over other `d` says nothing (X5) |

### A3-1.3 What I watch (G21)

- A proof of Act One "for at most three colours per vertex" reported as Act One (A3-HOLE's remainder).
- A kill of (S1) from first-order cones alone: (S1) has an empty blocking set at `x`, so a first-order kill of it is a defect.
- An (S1) fragment checked at `w₀` only, with `w₀′` or the arc endpoints unchecked.
- A local ACCEPT scored against the NO; a candidate that is a seven-colouring in disguise.

### A3-1.4 Hunch ledger: A2's carried as scored (A2 §4.5), mine added

Carried: `c5-fails-in-band-form-at-unit-arcs` confirmed (Y-BLOCK); `tangency-is-no-escape-against-a-blocking-partner` confirmed with "strong escape"
corrected; `cusps-close-under-closure-types` confirmed, two minds; `bowtie-and-bicycle-outlive-tangent-and-cusp` open, as predicted so far;
`complementary-means-union-six` confirmed; `c-tan-pos-misstated-at-four-colour-vertices` confirmed, two minds; `the-no-stalls-at-the-count-not-at-a-seam`
killed (N's first GAP was local); `the-yes-breaks-at-the-cascade` open; `the-registrations-name-global-steps` confirmed.

hunch: a3-hole-is-a-real-gap
  claim: a four-colour vertex whose two outside colours are separated on its unit circle by unit arcs centred at it is consistent with TS-U at the vertex, so A3-HOLE is not closed by the vertex figure alone
  basis: derived
  falsifier: a derivation from TS-U and A-EXACT at `v` that every four-colour vertex's outside colours meet at a point of `ω(v)`
  registered: 2026-09-27
  status: open — my sketch: six short unit arcs near directions `60°k`, outside colours alternating between them, admit a first-order figure `c | d | c | c′ | e | c′` at `v`

hunch: n2-act-one-ends-a-gap
  claim: N2's Act One at at most three colours per vertex ends this round a GAP at a named topological step on `ω(u)`, neither TRUE nor FALSE
  basis: prior
  falsifier: N2 proves Act One for trivalent maps, or builds a trivalent tight six-map with no close covering pair
  registered: 2026-09-27
  status: open

hunch: y2-first-reject-at-the-arc-ends
  claim: if Y2's (S1) fragment is rejected or obstructed, the first obstruction sits at the unit arc's endpoints or at `w₀′`, not at `w₀`
  basis: derived
  falsifier: Y2's first named (S1) obstruction at `w₀` itself
  registered: 2026-09-27
  status: open

hunch: round2-registrations-cross-at-s1-and-act-one
  claim: N2's pre-round answer names Y2's (S1) fragment (its cascade or its second unit point); Y2's names N2's Act One
  basis: prior
  falsifier: either answer names another step
  registered: 2026-09-27
  status: open

### A3-1.5 Evidence inventory

- A2-V56 as sent (`round2-open.md` §C) — read against: a vertex fact with no hypothesis on `ω(v) ∩ Γ` — surprised: yes, its step needs no arc of `Γ` on `ω(v)`, and (S1) is exactly such an arc
- N-X's hypothesis (`plans/FS110-N-proof.md` §2.4) — read against: "no unit arc at `w₀`" as the brief states it — surprised: no; it also assumes disjoint types, which the brief's summary drops
- TS-U's side cones (claims.md §3, N-SEAM (d)) — read against: cones of arbitrary width — surprised: yes, their width equals the arc's, which is what `ω(y)` for `y ∈ A` sweeps at `x`
- the owner's round-2 note — read against: nothing yet — surprised: unread

## Stage A3-1 — SAVED

## Stage A3-2 — round 2's registrations (in progress)

**The owner's round-2 notes, read** (`data/fs110/owner-notes-round2.md`, filed by the owner at `e6f8f753`). Stage A3-0's "unread" row is answered here.
Read against: "the correction may already settle A3-HOLE". Surprised: no. Note 2 quotes A2 §4.4 verbatim, and neither note mentions arcs of `Γ` on
`ω(v)`. Card 2 checks the frame fact itself and does not duplicate them (the owner, by message). Both notes told both sides to check the frame fact before
relying on it. A side that relies on it unchecked for Act One's scope is the G21 instance I watch.

### A3-2.1 FS110-N2's round-2 pre-round answer and card-2 reply, verbatim (received after its stage 4, `661a8804`)

> FS110-N2 to FS110-A3: my round-2 pre-round answer (A2's question B) and my reply to card 2. My stage 4 is committed (661a8804).
>
> B. The step I expect to fail on the other side is C-T2 (ii). I call it FALSE, or a GAP at best.
> - Mechanism: every unit-arc seam at w₀ creates new covering pairs at distance 1 along the unit circles of its centres (N-X (d)'s cascade).
> - A swap on a ring whose winding is 0 then forces yet another unit arc or a covering pair (N2-SWAP).
> - So the double unit-arc seams must re-seam themselves at every level, on circles of radius 1 whose count grows. I expect no tight 𝓜_K map to close that cascade.
> - A local T2 fragment (C-T2 (i)) may well be realisable; the failure is global.
>
> Card 2: yes, a statement of mine changes; count it as retraction 2 (free). Both steps of A2-V56 hold when Γ ∩ ω(v) is finite. At |P_cl(v)| = 4 the outside colours e and f then meet at a point y, and (v, y) is a covering pair at distance 1. If ω(v) carries arcs of Γ, both steps are a GAP:
> - |P_cl(v)| = 5 needs arcs of Γ on ω(v) of total length at least 180°, because each inscribed hexagon has at most three points off Γ.
> - An endpoint of such an arc takes its side colours from P_cl(v), by TS-U, so it gives no covering pair.
> - So the vertices left over are the centres of unit arcs of Γ.
> N's stage-2 note ("any point of ω(u) where those two meet") carried the gap implicitly. My record scopes it as N2-V4 (plans/FS110-N-proof.md §4.2).
>
> For your relay (results only, no route): under Condition 5, Act One holds at every four-colour vertex and at every trivalent vertex whose complementary ring has a swap. The ring's winding W = 0 forces a swap (N2-RING). What remains is maps whose every trivalent ring winds |W| ≥ 2. That case is a GAP, and it is locally consistent (a regular 120° vertex with a rotating ring).

**Round-2 retractions:** N2 1 (N2-V4's scope, on card 2; free). **The relay is declined**: the brief carries nothing between the sides during the round,
results included; N2's results are compared at hand-back.

**Read (N2 §4.3–4.4, at `661a8804`) and checked by me, one mind:** N2-RING's band argument is sound (`D` never `≡ 0`; leaving a band needs opposite
steps at `θ` and `θ + 60°`, which is a swap; six values in one band sum to `3W ∈ [18m + 6, 18m + 12]`). N2-V4's `180°` bound is my A3-HOLE count
(`I ∩ (I + 60°) = ∅` for a one-colour interior set) reached independently in form. So **A3-HOLE's GAP verdict is two minds** (N2 prompted by card 2).

**Scored:**
- `round2-registrations-cross-at-s1-and-act-one` — **N's half killed**. N2 names C-T2 (ii), the same step N bet against in round 1, not Y2's (S1)
  fragment. Y's half is pending.
- `a3-hole-is-a-real-gap` — open. N2 confirms the GAP, but not that such a vertex exists.
- `n2-act-one-ends-a-gap` — consistent so far: N2's stage 4 has C-ACT1 a GAP at "a tight six-map (no unit arcs) whose every trivalent ring winds".
  It is scored at hand-back.
- **My expectation row killed**: I wrote that "the two-coloured circle … is its hardest case". N2-RING gives the two-coloured ring `W = 0`, which forces a
  swap. The hard case is the ring that winds, `|W| ≥ 2`, the rotating six-arc ring at a regular `120°` vertex. I priced the case by S–V Lemma 2's ring,
  in the wrong direction.

**Noted for the hand-back comparison, not sent:** N2's residual invariant (every trivalent ring winds, the pure case a six-arc three-colour rotating ring)
is the ring family of Y's round-1 no-go Y-BIKE-3C ("six `60°` arcs cycling through three colours"), there on the bicycle. The questions differ: Act One's
counterexample has no same-type pair in `(1, 2)`. But the two sides' objects meet at one ring.

### A3-2.2 FS110-Y2's round-2 pre-round answer and card-2 check, verbatim (received after its stage 4, `8dbda9a1`)

> FS110-Y2 to FS110-A3: my round-2 pre-round answer, and my check of card 2 (stage 4 committed, 8dbda9a1).
>
> B. Pre-round answer (for FS110-A2's question B), verbatim for the register:
> "C-BOW-K (ii) in its (S1) branch (a unit arc through w₀ centred at a bowtie): any kill made at the seam point w₀ or at the pair (u, v) is FALSE. Mechanism: fragment S1 (tools/fs110_y_fragments.py --frag S1, exact over Q(√3), all 18 same-colour pairs ACCEPT, tight) has w₀ and w₀′ as two-colour edge points of arcs of ω(u), not vertices, and a generic trivalent partner v. So no vertex invariant at w₀ applies and the partner carries nothing. Grade: [tools, exact] for the member; [hand, one mind] for 'every (S1) with w₀ an edge point has u a strong escape and v free'."
>
> Card 2 check [hand, one mind; record §4.4]:
> - A2-V56 is TRUE off X_E (no positive-length boundary on ω(v)); it is TS §5's own result (TS l. 271: |P(x)| ≥ 5 forces σ(ω(x) ∩ E) ≥ 1/2). At a centre of arcs of Γ it is a GAP, as card 2 says.
> - The switch-point step has a second GAP, independent of arcs of Γ. A switch point x on a four-colour vertex's circle can be a vertex carrying a third colour j ∈ P(v): ω(v) passes from the m-sector straight into the m′-sector at x, with the j-sector beside it on one side of ω(v). Then P(x) ∩ P(v) = {j}, so (v, x) is not a covering pair. I find nothing that excludes it: A-CIRC at v holds, the j-sectors at v and x can face each other, and A-CIRC at x only asks that ω(x) avoid j near v.
> No verdict of mine changed on card 1. Two statements are added, not retracted (§4.2): Y2-W4's four-colour count uses disjointness; and Y2-W4 adds a necessary condition at w₀ from A-CIRC at w₀ (the partner of an escape must be ω(w₀)-monochromatic) on top of FS110-Y's C-TAN-POS verdict. — FS110-Y2

**Round-2 retractions:** Y2 0. The additions are not retractions.

**Read (Y2 §4.4–4.5 at `8dbda9a1`; the tool's output `data/fs110/fs110-y/y2_fragments_none.out` first line "fragment S1: 11 tiles, 18 same-colour
pairs (self included): ACCEPT"):**
- **A divergence of scope, not of truth.** Y2's "second GAP" (a switch point `x` carrying `m, m′` and a third colour `j ∈ P(v)`) uses claims.md §0's
  **disjoint** covering pair. In the **union** sense `P(v) ∪ P(x) ⊇ P(v) ∪ {m, m′} = [6]`, so `(v, x)` is a covering pair and the step holds. Seam
  necessity needs only the union: A-EXACT's consequence, N-SIX/Y-SIX, and N-SEAM (a) all read the union, and both round-1 records said so (card 1).
  My reading, one mind: the second GAP dissolves in the union sense. Sent to both as **card 3** (`data/fs110/fs110-a3/card3.md`), the definitional
  question only, with no route.
- **A3-HOLE is three minds**: mine, N2's (N2-V4) and Y2's (§4.4), the last two prompted by card 2. Y2 adds prior art in-house: the off-arc half of A2-V56
  is TS §5's result (TS l. 271, "`|P(x)| ≥ 5` forces `σ(ω(x) ∩ E) ≥ 1/2`"). So A2-V56's `|P| = 5` case was never new.
- **The (S1) fragment**: a bowtie `u` escapes at both unit points by two unit arcs of `ω(u)` with reversed sides, `d = 1`, arc half-angle `≈ 14.25°`
  (below my first-order `30°` bound). This is the configuration I checked at first order in A3-1.2, now exact. Its tiles are a partial patch: the arc's two
  ends on `ω(u)` are not inside any tile's neighbourhood in the fragment. Y2's own item 4 says each end must be a vertex meeting a colour of `P(v)`. So
  the ends are **unchecked by the member**, as Y2 states.

**Scored:**
- `round2-registrations-cross-at-s1-and-act-one` — **killed on both halves**. Y2 names C-BOW-K (ii)'s (S1) branch, N2 names C-T2 (ii). As in round 1,
  each side bets against the other's escape (N2 against T2's gluing, Y2 against any local kill of (S1)). The registrations are again not each other's
  negation.
- `y2-first-reject-at-the-arc-ends` — **not triggered**: the fragment ACCEPTs, and its ends are not in the member. Y2 names the ends (and `u`) as where a
  kill of (S1) must act. That agrees with the hunch's locus and does not test it.
- A2's `the-yes-breaks-at-the-cascade` — its first half is **met** (a seam, (S1), realised locally and exactly); the cascade is not yet built.
- My A3-1.2 expectation "(S1) passes every first-order test; its kill is not local at `w₀`" — **met in Y2's registration** (the member plus Y2-S1i), and
  consistent with N2's "the failure is global". **Convergence**: both sides place the (S1) kill away from `w₀` (N2 globally, Y2 at `u` or the arc's ends).

**Slip of mine, disclosed:** card 3's delivery to N2 returned "Resuming agent", so N2 was idle when it arrived. If N2 had made its final hand-back,
this card resumed it against A2's brief ("no hint goes to a side after it has handed back"). The card carries a definitional question and no route.
Reported to the owner.

## Stage A3-2 — SAVED

## Stage A3-3 — SAVED: hand-over at my budget line (for a successor advisor)

I stop here at my token line. The round is still running. What is left, in order:
1. **Card 3's answers** (the covering-pair sense). Register them verbatim and count any retraction; round 2 so far is N2 1, Y2 0, A3 0.
2. **At each side's hand-back**, read the side's § Continuation in full and compare:
   - truth and scope: the covering-pair sense (Y2's "second GAP" in the disjoint sense); A3-HOLE, three minds;
   - route: N2 reads rings (winding) at trivalent vertices; Y2 builds exact fragments;
   - the meeting point held back from both sides: N2's residual ring (every trivalent ring winds, `|W| ≥ 2`; the pure case a six-arc rotating ring at
     a regular vertex) is the ring family of Y's Y-BIKE-3C;
   - the convergence: both place (S1)'s kill away from `w₀`.
3. **Score** `n2-act-one-ends-a-gap`, `a3-hole-is-a-real-gap`, `y2-first-reject-at-the-arc-ends` and A2's `the-yes-breaks-at-the-cascade`.
4. **The round's verdict and the next aim**, as a decision in four parts. My lean, one mind, not sent: the next object is the **ends of (S1)'s unit arc**
   (each a vertex at distance 1 from the escaping bowtie, meeting a colour of the partner; Y2-S1i item 4), together with the **winding ring**. These are
   the two places where both sides' round-2 work stops, one on each side of Act One.

## Stage A3-4 — SAVED: card 3's answers (after the hand-over note)

- **FS110-Y2**, verbatim: "one retraction on card 3 (free, G51; record stage 6, commit c8ca500e). Retracted: my card-2 GAP (ii), "a switch vertex x = {m, m′, j}
  with j ∈ P(v) is not a covering pair". That holds only in claims.md §0's disjoint sense. In the union sense P(v) ∪ P(x) = [6]. The machinery it feeds
  needs only the union: A-EXACT's B_v ∩ B_x = ∅, and C-T-TAN through A-SIX. So the owner's switch-point step keeps only card 2's GAP, arcs of Γ on the
  circle. The senses my other statements use: Y2-W4 (a), (b), (d), Y2-W4e and Y2-S1i: the union. Y2-W4 (c), "four distinct colours at w₀": disjointness.
  Under the union alone the bound is ≥ 3 when the types overlap in one colour. The fragments have disjoint types, so both senses hold for them."
- **FS110-N2**: no reply to card 3 on the channel. In its hand-back text to the owner it says no statement changes: every stage 4–6 statement uses the
  union sense, and the machinery needs only the union. It asks the close to say which sense Act One means.
- **Round-2 retractions:** N2 1, Y2 1, A3 0, all free. **The covering-pair divergence is closed**: both sides use the union sense, and Y2's second GAP is
  withdrawn. A3-HOLE (arcs of `Γ` on `ω(v)`) is the frame fact's only remaining GAP, now three minds.
- **Slip confirmed:** card 3 reached N2 after its final hand-back and resumed it. N2 changed nothing.
- **Correction owed to claims.md** (for the close): the definition of covering pair should be the union sense, and Act One's statement should name it.

## § Continuation — FS110-A4

*Poros (Opus 5.5), 2026-09-27, taking over for round 2's comparison. Brief: `data/fs110/briefs/A4-110-competition-advisor-compare.md` (wins where it
differs) with FS110-A2's brief and `STANDING-RULES.md`. Both sides have handed back: FS110-N2 (`plans/FS110-N-proof.md` § Continuation — FS110-N2,
stages 4–6) and FS110-Y2 (`plans/FS110-Y-construction.md` § Continuation — FS110-Y2, stages 4–6). Nothing here goes to either side. I touch only this
section and `data/fs110/fs110-a4/`. Every result here is one mind (mine) unless marked.*

### Theorems this phase proved (FS110-A4)

- **A4-SIX-ARCS** — a four-colour vertex `v` (`P_cl(v) = [6] ∖ {e, f}`) with no covering pair `(v, y)`, `y ∈ ω(v)`, has on `ω(v)` either arcs of `Γ`
  of total length `≥ 60°`, or at least six arcs of `Γ` (centred at `v`), one inside each of six consecutive `60°` windows. *Proof:* if the arcs total
  `< 60°`, pick `x` with all six points `x + 60°k` tile-interior. By A-CIRC at `v` and N-E0 each window `[x + 60°k, x + 60°(k+1)]` runs from one of
  `e, f` to the other. A single point of `Γ` between an `e`-stretch and an `f`-stretch sees both, which makes a covering pair with `v`. So each window
  holds an arc of `Γ` on `ω(v)`, and no arc contains a window end. [hand, one mind, trivial] Stage A4-1.
- **A4-TSU** — TS-U does **not** put a unit arc's side colours in its centre's type. Its text is conditional (TS §2.2 (i)–(ii): "every colour-`c`
  region point `y + b` has …"): *if* the centre carries `c`, those tiles face the arc. Y2's exact member T2 shows the difference: the arc of `ω(w)`
  from `u` to `p2` has sides `3 | 2`, and `P_cl(w) = {1, 3, 4, 5}` (`tools/fs110_y_fragments.py`, `u_T2_flower`: tile `u_2` bounded by
  `Arc(W, 1, U, p2)`). So A3-HOLE's "their side colours lie in `P_cl(v)` (TS-U)" and N2-V4's "An endpoint of such an arc takes its side colours
  from P_cl(v), by TS-U" misread TS-U. **Both GAP verdicts survive**, by A4-SIX-ARCS's argument: an escape needs no point of `ω(v)` seeing both `e`
  and `f`. A side colour outside `P_cl(v) ∪ {e}` at an `e`-end would itself give a covering pair. [read + tools, exact for the member; hand, one mind for
  the repair] Stage A4-1.
- **A4-S1-ONE** — N2-S1's two points `σ_v^{±1}w₀` are exactly `ω(v) ∩ ω(w₀)`. At `|u − v| ∈ {1, √3}` only one of them is exceptional: the tangency
  condition in N2-S1's proof holds at one neighbour and fails at the other. So the conclusion (`γ` on both sides along `ω(v)`) still holds at the
  other point. At `d = 1` the exceptional point is `u` itself (`u ∈ ω(v) ∩ ω(w₀)`). At a tile-interior point of `ω(v) ∩ ω(w₀)`, N2-S1 is the
  pigeonhole `[6] ∖ (P_cl(w₀) ∪ P_cl(v)) = {γ}` (A-CIRC at `w₀` and at `v`). [hand, one mind, reading N2's proof] Stage A4-1.
- **A4-BAND** (the link A3 held back; a sketch) — Let `u, v` be vertices of one closure type `t`, `|t| = 3`, with no arc of `Γ` on `ω(u)` or
  `ω(v)`. Take the unit-pair curve `C = {(α, β) : |u + e_α − v − e_β| = 1}`. Lift the two ring colourings by `t^c ≅ ℤ/3` along `C`. Then
  `c̃_u − c̃_v` stays in one band `{3m+1, 3m+2}`, except at a **cross-swap**: `x ∈ ω(u)`, `y ∈ ω(v)`, `|x − y| = 1`, colours `p | q` at `x` and
  `q | p` at `y`. This is N2-RING's swap with `σx` replaced by `y`.
  - At `d ∈ (1, 2)` (`C` a contractible oval, Y-BIKE-3C): if `v`'s ring is **monotone** (every change a step of one sign), the two partners of
    `u + e_α` (`α` near the direction of `v`) need a lifted change `≤ 1` across an arc of length `2γ > 120°`. A monotone ring gives `≥ 2`. **So a
    cross-swap exists.**
  - At `d < 1`: `C` is two curves of class `(1, 1)`. So `W(u) = W(v)` unless a cross-swap exists.
  - **Y-BIKE-3C is this argument on 60° cells with no cross-swap. N2-RING is the same argument on the curve `θ ↦ (θ, θ + 60°)` of one circle.**
    [hand, one mind, sketch; the transposed swap lemma (a cross-swap gives a covering pair or a unit arc) is **not** derived] Stage A4-1.

### Would-have-searched-here log (A4)

- The bicycle and ring link: a scan of ring colourings on the bicycle. Instead the band argument along `C` (A4-BAND).

### Fence log (A4)

- `git log --oneline -3` at stage A4-1 showed the subject "FS110-NB: stage 1" (a blind verifier's neutral subject). Its record was not opened, listed or
  grepped. Not opened: `data/fs110/reports/` beyond the three files the brief names (A3, N2, Y2), `plans/FS110-close-inventory.md`, the transcripts,
  `chats-bak/`, and other scratchpad files.

## Stage A4-0 — SAVED: quotation check and reading

| quotation or fact in my brief | source | result |
|---|---|---|
| rule 0 (Kooshi, "From here on out, you may doubt … you will surprise yourself.") | `CLAUDE.md` § Counter-priors, read from disk | verbatim |
| "N2's residual ring winding `\|W\| ≥ 2` is the ring family of Y's round-1 no-go Y-BIKE-3C" (not in quotation marks) | A3-2.1; N2 §4.4; Y §2.4 | **exact only for the pure case**: Y-BIKE-3C's family is "six `60°` arcs cycling through three colours", which is N2-HEX's `W = ±2` ring. N2's residual also holds the nine-arc (`W = 3`) and twelve-arc (`W = 4`) rings, and non-60° swap-free rings |
| A3's lean, "the ends of (S1)'s unit arc, and the winding ring" | A3-3 item 4 | matches |
| A3 stood down at stage 4, `63c856ff` | `git log`: `63c856ff FS110-A3: report` | matches |

**Read from disk, in full:** `CLAUDE.md` § The aim, § Counter-priors, G82, G51 (§ The aim on disk is newer than the copy in my context); this record,
A2's stages and A3's continuation; `data/fs110/claims.md`; `plans/FS110-N-proof.md` §2.3–2.4 and N2's continuation (stages 4–6); `plans/FS110-Y-construction.md`
§2.4 and Y2's continuation (stages 4–6); reports FS110-A3, FS110-N2, FS110-Y2; `data/fs110/owner-notes-round2.md`; TS §2.2's statement of TS-U;
`tools/fs110_y_fragments.py` l. 138–175 (the T2 formula). Poros: the core in full. The companions are not loaded (budget); I will load them at an impasse.

## Stage A4-0 — SAVED

## Stage A4-1 — SAVED: round 2's comparison (brief items 1–2)

*Read at the hand-back commits: N2 stages 4–6 (`661a8804`, `d52ca39b`, `a41f14a7`); Y2 stages 4–6 (`8dbda9a1`, `120be328`, stage 6). Nothing went
to either side.*

### A4-1.1 Convergences (independent unless marked)

| finding | N side | Y side | minds now |
|---|---|---|---|
| A2-V56 and the owner's frame fact: TRUE when `ω(v)` carries no arc of `Γ`, a GAP otherwise | N2-V4 | Y2 §4.4 (adds: the off-arc `\|P\| ≥ 5` half is TS §5, l. 271) | three (A3, N2, Y2; the last two prompted by card 2); A4-TSU corrects the justification, not the verdict |
| a seam point with no unit arc is a vertex of `≥ 4` colours, pattern `v, u, v, u`, the two `u`-colours distinct | N-X (a), (b) (round 1) | Y2-W4 (a)–(c) (blind to N-X) | **two, independent**; N-X was one mind before |
| near `u`, `ω(w₀)` runs in the one colour `P(u) ∖ P_cl(w₀)`; the partner of a strong escape is `ω(w₀)`-monochromatic or carries arcs of `ω(w₀)` | N-X (c), (d) | Y2-W4 (d), Y2-W4e | two, independent |
| **both branches of N-X (c) are realised exactly**: the arc branch (`u` on an arc of `ω(w₀)`) and the bowtie branch | N-X (c) states the dichotomy | T2 (arcs), BB (bowties), MX (one of each) [tools, exact] | the dichotomy one mind with three exact members |
| (S1) puts nothing on the partner's vertex figure | N2-S1: "`v`'s ring changes freely at `w₀`" | Y2-S1i (3): "the partner `v` is free" | two, different routes |
| (S1)'s kill is not at `w₀` | N2: "the failure is global" | Y2: "a kill of (S1) has to act at `u` or at the arc's ends" | two (A3 recorded it) |
| covering pair means the union | N2's stages 4–6 | Y2 after card 3 | two; claims.md §0 owes the change |

### A4-1.2 Divergences

- **Of truth, one, found by comparing the records:** A3-HOLE and N2-V4 both justify "an arc endpoint gives no covering pair" by "side colours in
  `P_cl(v)`, by TS-U". Y2's exact member T2 carries a unit arc of `ω(w)` with side colour `2 ∉ P_cl(w)` (A4-TSU). The statement is FALSE as a reading of
  TS-U. The GAP verdicts stand on A4-SIX-ARCS's argument. **Neither side's programme is touched**: the divergence sits between two mind's wording and the
  third's member. This is the first divergence of truth in FS-110 not prompted by the claim list's words.
- **Of scope:**
  - *"The partner is free"* (Y2-S1i (3); Y2's registration: "every (S1) with w₀ an edge point has u a strong escape and v free"). This is true of
    `v`'s vertex figure. It is short of N2-S1: the seam forces `u`'s bowtie colour `γ` on `ω(v)` at `ω(v) ∩ ω(w₀)` (A4-S1-ONE). "The whole seam sits
    at `u`" does not hold: the seam's constraints reach the partner's circle.
  - *N2-S1's exceptional distances `{1, √3}`* are the construction side's generator image (`ℚ(√3)` data, the `d = 1` rhombus). The (S1) member sits at
    `d = 1`, where one of N2-S1's two points is `u` itself. There, `ω(v)`'s sides at `u` are `b, c ≠ γ` (`u_b` on `(60°, 120°)`, `u_c` on `(240°, 300°)`,
    `ω(v)`'s tangent at `u` vertical). **The member realises N2-S1's exception clause**, a positive control for it. Its tiles do not reach the other
    point `σ_v^{−1}w₀ = (3/2, √3/2)`, where N2-S1 still forces `γ` (A4-S1-ONE). G21: the generator cannot test N2-S1 at a generic `d`.
  - *Covering pair:* closed by card 3 (A3-4).
- **Of route:** N2 reads windings and transports them (rings, nerves, parity: N2-RING, N2-TRANS, N2-FLIP), with two exact parity/ring checkers. Y2 builds
  four exact fragments by formula, with plants that fire for their own reasons. N2's objects are rings at trivalent vertices; Y2's are seam points and
  their four-colour circles. **The two meet at one object, the unit circle of a seam point** (A4-1.6).

### A4-1.3 The registrations, scored

| registration | scored |
|---|---|
| N2 (round 2): "C-T2 (ii). I call it FALSE, or a GAP at best." | **untested**: Y2 left C-T2 (ii) to a successor. Its mechanism ("new covering pairs at distance 1 along the unit circles of its centres") is **supported** by A4-SIX-ARCS at T2's `w` (below). This is the same step N bet on in round 1: two rounds unscored |
| Y2 (round 2): "C-BOW-K (ii) in its (S1) branch … any kill made at the seam point w₀ or at the pair (u, v) is FALSE." | **untested, consistent**: N2 made no kill at `w₀` or `(u, v)`. N2-S1 is a forcing at `ω(v) ∩ ω(w₀)`, not a kill; N2's named step is there, away from `w₀` |
| N2-P1 (winding case not killed locally, 0.8) | supported by N2's own locally consistent rings (N2-HEX, the nine-arc ring). A4-BAND is a two-vertex argument, consistent with P1. Open |
| N2-P2 (C-ACT1 TRUE without unit arcs, 0.6) | open |
| N2-P3 ((S1) fragment meets N2-S1, 0.7) | **untested**: the member sits at `d = 1`, the excluded distance, and does not reach the forced point (A4-1.2) |

For the third time in FS-110 (round 1, round 2, A3-2.2), **each side bet against the other's escape and neither attacked the step the other bet on.**
The registrations have never met.

### A4-1.4 Retractions

Round 2: N2 1 (N2-V4's scope, card 2), Y2 1 (the disjoint-sense GAP, card 3), A3 0 (one expectation row killed), A4 0. FS-110 in total: five, all free, all
prompted by an advisor card about the claim list's words or a frame fact. **Zero between the sides.** G51: the disagreement proper has not started, and it
cannot start while the two sides work different objects.

### A4-1.5 The (S1) convergence, stated at its scope

Both sides agree on three things: (S1) is realisable locally (Y2's member, exact); nothing at `w₀` or at `v`'s figure kills it; and its cost lies
elsewhere. **They name different places:**
- Y2: the arc's ends, which are vertices on `ω(u)` meeting `P(v)` (Y2-S1i (4)).
- N2: the two `γ` points `ω(v) ∩ ω(w₀)`, and whether they make a covering pair (N2 §5.3). Neither side has the other's place.

**Both are points at distance 1 from a seam point or a centre, so the next link of (S1) is on a unit circle too.**

### A4-1.6 The held item: N2's winding ring and Y-BIKE-3C

**What the link is (A4-BAND).** N2-RING and Y-BIKE-3C are one argument: a `ℤ/3` colour difference along a closed curve of unit pairs, lifted to `ℤ`, stays
in one band, and it leaves the band only at a swap.
- N2 runs it inside one circle, `θ ↦ (θ, θ + 60°)`.
- Y ran it across the bicycle's two circles, where the swap becomes a cross-swap at unit distance.

The pure rotating ring (N2-HEX) is Y-BIKE-3C's family. The monotone rings are the family A4-BAND reaches.

**What it does to N2's open step** (C-ACT1, "every trivalent ring winds"):
- Act One's counterexample must have no same-type pair in `(1, 2)` (claims §1). A4-BAND says why that costs nothing locally: in a winding map with
  monotone rings, a same-type pair in `(1, 2)` forces a cross-swap.
- **Given a transposed N2-SWAP** (not derived), the cross-swap gives a covering pair or a unit arc. So the winding residual is closed under that clause.
- The link does **not** close Act One. It adds two facts a count can use at bounded `K`:
  - same-type vertices in a winding map lie pairwise at distance `≤ 1` or `≥ 2`;
  - vertices closer than 1 carry equal windings.

  These are what N2's third candidate for the global step needs ("a count of ring changes against edge length per unit area").

**What it does to Y's open step** (C-T-BIKE beyond 60° cells): Y-BIKE-3C's "What it leaves" shrinks to rings that have a cross-swap, or that are
non-monotone. A bicycle colouring is decided as a map question, not as a circle question: every escape is a swap, and swaps are exactly where N2-SWAP
makes the map pay.

**For both sides.** The Q-rule NO has two halves: seams (complementary pairs) and bicycles (same-type pairs). They now run on one instrument, the band
along a curve of unit pairs. Its only escape is the swap, and the swap's only escapes are unit arcs and four-colour points.

### A4-1.7 Hunches scored, and mine

- A3's `n2-act-one-ends-a-gap`: **confirmed** by N2 §6.3 (a GAP at the winding ring, a named topological step on `ω(u)`).
- A3's `a3-hole-is-a-real-gap`: open, **sharpened**. By A4-SIX-ARCS the loophole needs `≥ 6` unit arcs at `v` (or `≥ 60°` of them). A3's sketch
  "six short unit arcs near directions `60°k`" is forced, not optional. **A built instance to test it is T2's `w`:** `ω(w)` runs in `2` beside `u`'s arc
  and in `6` at `v`, `60°` apart, and it carries only two arcs of `Γ` (through `u`, and the one-sided arc at `v`). A completion needs at least four more
  unit arcs centred at `w`.
- A3's `y2-first-reject-at-the-arc-ends`: not triggered (no REJECT). Open.
- A2's `the-yes-breaks-at-the-cascade`: its first half is met (S1, T2, BB, MX exact). Its second half is open and now located:
  - at T2's `w` (A4-SIX-ARCS);
  - at BB's `w` (no arcs, so N2-V4 gives a covering pair `(w, y)` at each of `≥ 6` switch points);
  - Y2-LAT's failure at the lattice's four-colour points is one instance of the second.
- A2's `the-registrations-name-global-steps`: confirmed again (N2 names C-T2 (ii); Y2 names C-BOW-K (ii)'s (S1) branch).
- FS110-A's `bowtie-and-bicycle-outlive-tangent-and-cusp`: open, **as predicted**. Live: bowtie (ii), T2 (ii), (S1), bicycle. Closed: T1, cusp.

hunch: every-escape-is-paid-on-a-unit-circle
  claim: under Condition 5 the only surviving local escape of a close covering pair is a strong escape at a four-colour seam point, and each such seam point has at least six switch points on its unit circle, each a covering pair at distance 1 whose partner has at least three colours
  basis: derived
  falsifier: a Condition-5 local fragment saving a close covering pair at a seam point with at most three colours, or a four-colour seam point whose circle has a bichromatic switch point saved by a seam
  registered: 2026-09-27
  status: open — its inputs: N-SEAM, N-X and Y2-W4 (no arc means four colours); N2-V4 and A4-SIX-ARCS (six switches); Y2-W4e with N-X (a `(4, 2)` pair needs two unit arcs, excluded by Condition 5)

hunch: transposed-swap-holds
  claim: N2-SWAP holds with `σx` replaced by any `y` with `|x − y| = 1`, `y` a change point of a ring on another circle, so a cross-swap gives a covering pair at distance at most 1 or an arc of a unit circle at `x` or `y`
  basis: derived
  falsifier: a cross-swap in a map with no covering pair at `x` or `y` and no unit arc through `x` or `y`
  registered: 2026-09-27
  status: open — N2-SWAP's proof uses only a transversal crossing of `ω(x)` by the second circle at a point with swapped colours

### A4-1.8 Where Q-rule stands, seam by seam (after two rounds)

| seam or claim | state | minds, grade |
|---|---|---|
| local calculus (A-EXACT, A-CIRC, A-SIX; D-TYPE) | TRUE | three; two; hand |
| C-TAN-POS | TRUE for the named vertex kinds (Y), and at a non-vertex `w₀` (N); "strong escape" MISSTATED, corrected | two, complementary routes |
| C-SEAMLIST | MISSTATED; replaced by the dichotomy at `w₀`: (S1) a unit arc of `ω(x)` with an escape at `x`, or (S2) a vertex | one (N) |
| SEAM-T1 (C-TAN-K) | closed at the pair level | two routes (Y's T1 rows; N's dichotomy); exact plant `t2_flat` |
| SEAM-C (C-CUSP-K) | TRUE | two, different routes |
| (S1) | realised locally (exact, `d = 1`); forces `γ` at `ω(v) ∩ ω(w₀)`; the arc's ends meet `P(v)`; the kill must act at `u`, the ends or the `γ` points | member exact; the rest one mind each |
| SEAM-T2, C-T2 | (i) TRUE at fragment level (exact); (ii) GAP. Its seam points are four-colour with arcs of `Γ`, and completion needs `≥ 6` unit arcs at each (A4-SIX-ARCS) | exact; one mind |
| SEAM-B, C-BOW-K | (i) TRUE (BB, S1; exact); (ii) GAP. BB's seam points are four-colour with no arcs, so each has `≥ 6` covering pairs at distance 1 on its circle | exact; one mind |
| mixed seams | one pair can mix T2 and an escape (MX, exact) | exact |
| V5 | `(2, 4)` bichromatic partner is the crossing of two unit arcs (Y2-W4e); a four-colour vertex gives a covering pair unless `≥ 6` unit arcs are on its circle | one mind each |
| SEAM-S, C-T-BIKE | GAP beyond 60° cells. A4-BAND reduces it to cross-swaps and non-monotone rings | one mind, sketch |
| C-ACT1 | TRUE (Condition 5) at four-colour vertices, swap rings and odd tiles; GAP at "every ring winds `\|W\| ≥ 2`"; GAP with unit arcs | one mind (N2); nerve step a sketch |
| Q-full | undecided | — |

**In one sentence:** every local escape is realised exactly, and every open step on both sides is a condition on a unit circle through or about a seam
point. That circle is a four-colour circle (T2, BB, Act One's four-colour case), (S1)'s arc ends and `γ` points, or a winding ring. Under Condition 5 only
the strong escape at a four-colour seam point survives. Each such point must then carry `≥ 6` covering pairs at distance 1, and those pairs must in turn
be saved.

### A4-1.9 The round's verdict, and what next (a decision in four parts, for the owner)

- **The choice: run a third round, with both sides on one object, the unit circle of a four-colour seam point.**
  - *Proof side:* Q-rule_cl **under Condition 5**, where the strong escape is the only escape (hunch `every-escape-is-paid-on-a-unit-circle`). Show that
    the cascade of `≥ 6` covering pairs per four-colour seam point cannot close at bounded `K`. Then Act One's winding case, with A4-BAND and the
    transposed swap.
  - *Construction side:* close one four-colour circle by formula and check it exactly:
    - T2's `ω(w)` with its `≥ 6` unit arcs (the A3-HOLE loophole, the only way with arcs);
    - or BB's `ω(w)` with its switch points seamed.

    Then (S1)'s arc ends and `γ` points.
  - Each side's pre-round question should name the **other side's step on this one object**, so that the registrations can finally meet.
- **The alternatives weighed:**
  - **(a) Close FS-110 now.** File the calculus, the four exact members, the dichotomy and Act One's narrowed GAP. Mint stubs for the cascade (C-T2 (ii) and
    C-BOW-K (ii)), the winding case and the bicycle's band.
  - **(b) A3's lean:** (S1)'s arc ends and the winding ring.
- **Why this one:**
  - *Against (a):* two rounds have converged every open step onto one object, both sides hold fresh tools on it (N2's windings, Y2's exact fragments with
    four-colour seam points), and closing now leaves that object un-attacked.
  - *Against (b):* (S1)'s arc ends are one of the object's two branches (the unit-arc branch). The four-colour circle carries T2, BB, MX and Act One's
    four-colour case, so it is the larger share.
  - *Condition 5* gives a sub-class with one escape. A decision there is a real result: Question 2 of `[SokolovVoronov2025]` with Condition 5 kept, almost
    everywhere, at bounded `K`. By the claims list's failure clause it is reported as partial, never as Q-full.
  - The disagreement has not started because the sides never shared an object (A4-1.4). This is the first round in which they would.
- **Confidence: medium.** Two facts would change it:
  - a defect found by NB or YB in the cascade's inputs (N-X/N-SEAM, N2-V4, Y2-W4, Y2-W4e);
  - a prior-art check showing that S–V or Townsend already settle maps with Condition 5 and without Condition 6. That check is owed before round 3:
    read `[SokolovVoronov2025]` §9 and the Condition-6 discussion first-hand.
- **Default:** if the owner says nothing, FS-110 waits for the blind verifiers. I compare them (brief item 3), and this recommendation goes to the close
  unchanged.

### A4-1.10 Evidence inventory

- Y2's T2 formula (`u_T2_flower`) — read against: a unit arc's side colours in its centre's type (TS-U as A3 and N2 used it) — surprised: yes; outer colour `2 ∉ P_cl(w)` (A4-TSU)
- N2-S1's exceptional distances — read against: generic exclusions unrelated to the other side — surprised: yes; they are the construction side's generator distances, and the (S1) member sits on one
- Y-BIKE-3C beside N2-RING — read against: two different arguments sharing a ring family (A3's note) — surprised: yes; one band argument on two curves of unit pairs (A4-BAND)
- N-X (c) beside T2, BB and MX — read against: independent work — surprised: yes; the three members are exactly N-X (c)'s two branches and their mix
- the registrations of rounds 1–2 — read against: that they would meet by round 2 — surprised: no (A3 recorded the pattern); they never met

## Stage A4-1 — SAVED

## Stage A4-2 — SAVED: FS110-NB against the proof side (brief item 3), and round 3 re-weighed

*Read on the owner's word that NB's report exists: `data/fs110/reports/FS110-NB.md`; `plans/FS110-NB-verification.md` §2.3–2.6, §2.11 and stage 4 (the
divergence table); the heading list. YB's record is still fenced (not opened).*

### A4-2.1 NB against N and N2: divergences, and the count of minds

| item | NB (blind) | the side | divergence | minds now |
|---|---|---|---|---|
| N-E2, N-SEAM, N2-RING, N2-TRANS (bar `d = 2`), N2-FLIP, N2-HEX, N2-S1 (exceptions exactly `{1, √3}`) | TRUE | TRUE | none | **two, one blind** each. N2-TRANS's genericity step is a sketch in both |
| N-X (a)–(d) | TRUE | TRUE | none | **three** (N, Y2-W4 independent, NB blind) |
| N-HORN / C-CUSP-K | TRUE at LIM | TRUE | none | three (N, Y's cusp row, NB) |
| N2-V4 | step 1 TRUE; step 2 a GAP in the claim list's **disjoint** reading, TRUE in the union reading | TRUE with the arc proviso (union) | **definition only** (NB's D1). Card 3 settled the union for both sides | step 1 four (A3, N2, Y2, NB); step 2 (union) three plus NB's acceptance |
| N2-SWAP, N2-ACT1-W0 | TRUE under Condition 5; outside it they inherit item 6's GAP | TRUE, "bar the named unit arcs" | scope: in the disjoint reading the proviso misses the arcs at the four-colour ring's change points. In the union reading the side's proviso suffices | two, one blind (Condition 5) |
| N2-ROT | the section TRUE; **the table line MISSTATED** (it drops "(A+, B+), (A−, B−) is a swap") | §4.3 states the swap clause; the table line omits it | a table line, FS-107's M3 kind | two |
| **NB-4, NB-5** | new | not stated (the side left the cascade a GAP) | beyond the side | **two, one blind**: NB, and my check below |

### A4-2.2 NB-4 and NB-5, checked (the second mind NB asks for) [hand; sighted, having read both the side and NB]

- **NB-4** ("under Condition 5 … no vertex has four colours"): **TRUE**, every step checked.
  1. The ring of `v` is two-coloured `{e, f}` with the `60°` alternation, so its change points come in `σ_v`-orbits `y₀, …, y₅`.
  2. The half-arcs of `ω(y_{k±1})` at `y_k` lie in tiles whose colours avoid `{e, f}` (A-CIRC at `y_{k±1}`, which are change points too). They split
     into an inner colour `i_k` and an outer colour `o_k`, both in `P_cl(v)`, with `i_k ≠ o_k` (N-E2 against `v`'s tile).
  3. Condition 5 and N2-V4's step 1 at `y_k` give `P_cl(y_k) = {e, f, i_k, o_k}`, exactly.
  4. A-CIRC at `y_{k+1}` gives `{i_k, o_k} ∩ {i_{k+1}, o_{k+1}} = ∅`, so the pairs alternate `{A, B}`, `{C, D}`.
  5. For each colour, N-E2 at three points `120°` apart puts its sectors at `v` into three closed half-planes whose lines are `60°` apart. They meet in
     a closed arc of at most `60°`. Four colours fill at most `240° < 360°`.
- **NB-5** ("no close covering pair at all"): **TRUE**, with one precision.
  - It **needs no disjointness**. The half-arcs of `ω(u)` at `w₀` carry two distinct colours of `[6] ∖ P_cl(u)`, and those of `ω(v)` carry two of
    `[6] ∖ P_cl(v)`. In the union sense these are disjoint sets, so `|P_cl(w₀)| ≥ 4` (or the pair dies at once).
  - Y2's remark "`≥ 3` when the types overlap in one colour" is therefore short. The two branch colours on `ω(u)` lie outside `P(u)`, hence in
    `P(v) ∖ P(u)`, and the two on `ω(v)` lie in `P(u) ∖ P(v)`. [hand, one mind]
- **What NB-4/NB-5 retire.**
  - My hunch `every-escape-is-paid-on-a-unit-circle` is **killed**. Under Condition 5 no escape survives at all (it placed one at a four-colour seam
    point, and NB-4 excludes those).
  - A4-SIX-ARCS is **vacuous under Condition 5** and stands outside it.
  - Y2's BB fragment cannot extend to a full map under Condition 5 (its seam points are four-colour and carry no arcs). Y2-LAT's failure is one
    instance of this.
- **Prior art, for the conclusion only:** NB-4's four-colour half is `[SokolovVoronov2025]` Lemma 2 in a region-only, almost-everywhere form (NB's own
  note). FS110-PA is checking S–V on Condition 5 without Condition 6.

### A4-2.3 Where FS-110 stands now (the headline changes)

**Under Condition 5 (no boundary arc of radius 1), the tangency seam is closed.** A tight six-map in `𝓜_K` has:
- no four-colour vertex (NB-4) and no close covering pair (NB-5), hence no swap (N2-SWAP) and no odd tile (N2-FLIP);
- rings that all wind, `|W| ≥ 2`, consistently along edges (N2-TRANS);
- no same-type monotone pair in `(1, 2)`, given A4-BAND and a transposed swap.

So **Q-full under Condition 5 is one question: does a winding map exist?** W-POLY adds that such a map is not polygonal (bar `d = 2`), so it needs
curved arcs of radius `≠ 1`. [NB-4/NB-5: two minds, one blind; the rest one mind each, as stated.] **Outside Condition 5** the live objects are:
- (S1) and T2;
- NB-4's exception (arcs of `ω(y_k)` through the change points);
- A4-SIX-ARCS's `≥ 6` unit arcs at a four-colour vertex.

### A4-2.4 Round 3, re-weighed (four parts; replaces A4-1.9's choice)

- **The choice: round 3 on the winding question under Condition 5, both sides on it.**
  - *N:* no winding map exists in `𝓜_K`. Candidate tools: N2-TRANS as a flat structure over the plane; N2-HEX's rigidity; A4-BAND's same-type spacing
    with a transposed swap; a count of ring changes (`≥ 3|W|` per vertex) against edge length at bounded `K`.
  - *Y:* build one, a periodic curved six-map given by formula with every ring winding, checked exactly (in under the ban).
  - The pre-round question to both is the same: the other side's step on this object. **A YES is decisive with no MR** (a full tight six-map, W-EQ-K:
    `χ(ℝ²) ≤ 6`). A NO decides S–V Question 2's Condition-5 half almost everywhere at bounded `K`: partial, and reported so.
  - The unit-arc branch ((S1), T2, NB-4's exception) goes to round 4 or a stub.
- **The alternatives weighed:**
  - A4-1.9's choice, the four-colour seam point's circle. **Dead under Condition 5 by NB-4**; it survives only in the unit-arc branch.
  - Closing FS-110 now, with NB-4/NB-5 as the headline and stubs for the winding question and the unit-arc branch.
- **Why this one:** NB-4/NB-5 turn half of FS-110 into one existence question with a named invariant, `W`, that both sides already hold tools for.
  - It is the first object on which the registrations can meet, and a YES is the strongest outcome FS-110 has.
  - Against closing: the question is fresh and exact, and both sides' round-2 tools aim at it.
  - Against the unit-arc branch first: it has three objects and no single invariant yet.
- **Confidence: medium.** Two things would change it:
  - **FS110-PA's finding.** If S–V's own argument for Conditions 5 and 6 (or Townsend's) already excludes winding rings with Condition 6 dropped,
    round 3 should re-prove their step almost everywhere instead: cheaper, and the same product.
  - YB finding a defect in Y2-W4 (an input to NB-5's count, though N-X and NB carry it too).
- **Default:** the owner waits for PA and YB, and then picks. With no word, this goes to the close as the recommendation.

**Would have searched here:** a winding-map existence check by solver. Instead it is named as round 3's exact-check target, to be built by formula only.

## Stage A4-2 — SAVED

## § Continuation — FS110-A5

*Poros (Opus 5.5), 2026-09-27, competition advisor for round 3 (W-3, the winding question) and the construction-side verifier's comparison. Brief:
`data/fs110/briefs/A5-110-competition-advisor-round3.md` (wins where it differs) with FS110-A2's brief and `STANDING-RULES.md`. Sides: FS110-N3 (proof,
`a38bf36d512f6fc0a`) and FS110-Y3 (construction, `aecdb6f1ba0545c96`). I touch only this section and `data/fs110/fs110-a5/`. Every result here is one
mind (mine) unless marked.*

### Theorems this phase proved (FS110-A5)

- **A5-C5** — in `𝓜_K` the print's Condition 5 ("If any boundary intersects with a circle of unit radius at a finite set of points …") and the claim
  list's gloss "no boundary arc of radius 1" coincide: a segment, or a circular arc of radius `≠ 1` or of radius 1 about another centre, meets a unit
  circle in at most two points, and a unit circle meets finitely many arcs. [hand, trivial; **two minds**: FS110-Y3's Y3-C5, and mine, independent]
  Stage A5-0. It discharges FS110-PA's "round 3 must say which" for `𝓜_K` and LIM.

### Would-have-searched-here log (A5)

- (none yet)

### Fence log (A5)

- Read, as my brief allows: this record, the reports of N2, Y2, NB, YB, PA, `plans/FS110-YB-verification.md` (stages 3–4), `plans/FS110-Y-construction.md`
  (l. 1–30, §2.3–2.4, stage 5's lattice paragraph, Y3's section), `plans/FS110-N-proof.md` (§4.3, §6.2–6.3, grep for "trivalent"), `data/fs110/claims.md`
  §0, §1, §5, §7. Not opened: NB's record beyond A4's reading, the transcripts, `chats-bak/`, other scratchpad files, `plans/FS110-close-inventory.md`.

## Stage A5-0 — SAVED: quotation check, reading, and N3's pre-round answer

| quotation or fact in my brief | source | result |
|---|---|---|
| rule 0 (Kooshi, "From here on out, you may doubt … you will surprise yourself.") | `CLAUDE.md` § Counter-priors, read from disk | verbatim |
| claims §7's quotation of A4-2.3 | this record, l. 891–900 | verbatim (diff empty) |
| claims §7.1: the ring (§4.3) and the N2-TRANS table line | `plans/FS110-N-proof.md` l. 345–351, table | verbatim |
| claims §7.1: the §6.2 quotation (tile count) | `plans/FS110-N-proof.md` l. 482–486 | **truncated mid-sentence**: it stops at "return swapped iff `m` is odd," and drops "parity `(−1)^m`; so the ring's own permutation has parity `(−1)^k`. An odd `k` returns the ring orientation reversed …". The definition of the count precedes the cut, so W-3 is unaffected; both sides received the same truncation. Correction owed |
| "Y3 … expects the proof side to stall at vertices of degree ≥ 4 (bowties; bichromatic vertices), which W-3's ring condition does not constrain" (not in quotation marks) | Y3's section, § The pre-round question | matches, **with a reading**: Y3 takes W-3's "trivalent" as degree 3 ("W-3's hypotheses put the ring condition … on **trivalent** vertices only"), while §7.1's setting defines the ring at any vertex with `\|P_cl(u)\| = 3`, and the proof side's record used "trivalent" for three colours ("The trivalent case — three colours at every vertex", N l. 265). See A5-2 |
| YB's four findings | `data/fs110/reports/FS110-YB.md` | match |

**Read from disk:** as the fence log lists; Poros core in full; companions by heading (budget).

### A5-0.1 FS110-N3's pre-round answer, verbatim (received by message 05:5x, as sent to "main")

> "Expected failing step: the construction's vertex at which one colour holds two non-adjacent sectors (a trichromatic "bowtie" of degree ≥ 4, or a
> bichromatic vertex of degree ≥ 4) used as ESSENTIAL — i.e. to escape S–V's cubic argument (a cubic Condition-5 map is killed by S–V's own chain,
> FS106-V's repaired Cor. 1, one mind, bar d = 2; the six-arc rotating ring at a cubic vertex is S–V Prop. 17's kill under Condition 5). I expect every
> such vertex whose repeated colour has sectors of POSITIVE angle to be removable by an almost-everywhere form of Woodall 1973's step 3, so it buys
> nothing over a cubic map.
> What would show me wrong: (1) a winding map given by formula, checked exactly, whose repeated-colour sectors at such a vertex are cusp horns tangent
> to a boundary direction of that colour's allowed cone (Woodall's "cone", excluded by his step 5 only at five colours); (2) one realising S–V's d = 2
> configuration (two same-type trichromatic points antipodal on a trivalent vertex's unit circle); (3) a merge that lands a recoloured point at distance
> exactly 1 from a same-colour tile."

Y3's answer is in its section (§ The pre-round question), sent to "main" at 05:4x. **Retractions count from both answers.**

## Stage A5-0 — SAVED

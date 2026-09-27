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

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

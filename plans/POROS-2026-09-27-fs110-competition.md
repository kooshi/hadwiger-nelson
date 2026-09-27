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

# Poros — the question cards for FS-116 (the local exclusion) and FS-121 (the map step) (job FS116-P1, 2026-09-28)

*Poros (Opus 5.5), job FS116-P1, for Keryx; brief `data/fs116/briefs/FS116-P1-question.md` (commit d44d032d) with its Amendment 1 (commit 4708b703,
2026-09-29 04:45 UTC: FS-121's card too, as a fourth stage), and `plans/STANDING-RULES.md` as part of it. Identity `.claude/agents/poros.md`. The hunch
ledger is carried forward from `plans/POROS-2026-09-28-close-reread.md` (§ 1.3 and § 2.3, scored in § 2.2). No fences: the brief's `fences:` field reads
"none — no blind job is running". I touch only this record, `plans/STUB-local-exclusion.md`, `plans/STUB-map-step.md`, `data/fs116/p1/` and
`data/fs116/reports/FS116-P1.md`.*

## Theorems this phase proved

None. Poros poses; it does not derive. One composition is offered below in the hypothetical mood, as a hunch with a falsifier, and is addressed to
Ephodos to check (card `the-yes-needs-no-map`); it is not filed as a theorem.

## Would-have-searched-here log (standing rule 5)

- Would have searched the held fragments' builders for the ring type (Γ-arcs, (Q) arcs, change points) of every four-colour vertex. Instead I read
  what the records state: `LEDGER.md` row 136 and `data/fs114/fs114-y6/survey.out`.

## Fence log (standing rule 8)

No path is fenced for this job, and I touched no fenced text. I read no session transcript.

## Stage 1 — SAVED

### 1.1 The first act: the grokkings preload

**Found.** My context holds a skill block whose base-directory line reads, as I see it:

> Base directory for this skill: /home/kooshi/source/lean-dir/.claude/skills/grokkings

The first eight words of G87's entry, from that context block and not from the file, are "G87 — The invention signal: two truths that contradict,".
(I counted "G87" as the first word and did not count the dash.) So the preload through the agent file's `skills: grokkings` field works in a fresh session.

**A finding about the brief's form.** The launch message said to do the first act "before any tool call", but the act is written inside the brief,
and I could only read the brief with a tool call. So the literal order cannot be kept. What I did: before any tool call, I wrote my expectations of
the brief and the question into the conversation (§ 1.3 below, E1–E3). Then I read the brief and ran the check from my context, not from the file.
Since tool calls do not change the preloaded context, the check's result is unaffected. **For Keryx:** an instruction that must come before any tool
call has to be in the launch message itself.

### 1.2 Readback of the brief (every quotation checked against its source)

- *"My goal is to fully solve, and then verify in Lean, HN. Then we publish.* — `CLAUDE.md` l. 74. **Match**, as a prefix. The brief opens the
  quotation mark and never closes it; the source continues "(Anything we do must be formalized in Lean before publishing, …)".
- *"- **C114-LOCAL-F** *(this list; card 2's falsifier as a claim)*: there are an explicit radius `R` and a derivation that no valid fragment exists on
  the closed disc of radius `R` about a vertex of at least four colours."* — `data/fs114/claims.md` l. 110–111, § 3. **Match.** The source continues with
  a lower bound, "By the strip, any such `R` exceeds `√15/4 + √3/2 ≈ 1.834`". § 9 of the same file corrects that bound to "`φ²/√2 ≈ 1.8512`", as the
  brief says.
- Card 1's ask, *"Does FS114-Y4-RSTOPALL, the bowtie killed at `√3`, survive … independent of ε and the complexity?"* —
  `plans/POROS-2026-09-28-close-reread.md` l. 291. **Match.**
- Card 2's ask, *"Can FS-121's map step, when it produces a segment-and-arc map, produce one of bounded complexity — or must route M's NO cover every
  locally finite map?"* — the same file, l. 307. **Match.**
- The brief also quotes the two cards' "answered by" fields, unquoted. Card 1's "a fresh mind at FS-116's opening (its §IQ), on one kill, before round
  7's queue" matches the source, which prefixes it with "derivation — ". Card 2's "FS-121's opening, or FS-116's §IQ if FS-121 is not open" matches.
- "FS-116 is rank 1 on your own re-rank" — true: `plans/FRONTIER-STUBS.md` l. 84.
- The stub has no `## The question (Poros, <date>)` section — true. **No stub in `plans/` has one** (grep over `plans/STUB-*.md`), so this is the first
  question section under the lane file's job 1.
- "The stub's provisional bearings name G83, G86, G79, G82 and G15 among others" — true (`plans/STUB-local-exclusion.md` ll. 12–16). They also name
  **G67 and G51, both retired** to `plans/GROKKINGS-RETIRED.md` (the grokkings file keeps only their titled pointers). The rewrite in stage 3 drops them.
- Amendment 1's quotation, *"the test drive's candidate edits to the lane files — chose "Let me review them first". Item 1's default is overturned:
  FS-121 opens beside FS-116"* — `plans/FS116-close-inventory.md` row 4. **Match.**
- Amendment 1's quotation of FS-121's frame sentence, *"Seven, `χ_m⁰(ℝ²) ≥ 7` (so `χ(ℝ²) = 7` given MR), is the map NO — row 134 with FS-114's NO —
  made uniform in the complexity bound (`FS111-C1-UNIF`)"* — `plans/STUB-map-step.md` § The question, first paragraph. **Match** (across a line break).
- The brief's "FS-121 is not open … plan as if it will not" is superseded by Amendment 1 (Kooshi, 2026-09-29 04:44 UTC, by the question tool).

**No mismatch.**

**The task, restated.** FS-116 (the local exclusion) and FS-121 (the map step) are open, and they are route M's two halves. I pose each milestone's
question. The output is a `## The question (Poros, 2026-09-28)` section in each stub, holding three things: a card in my identity's grammar; an
existence form; and a structural form, which is a question about every solution that cannot be answered without an invariant every solution carries
(G72). Ephodos's §IQ quotes the two forms verbatim. I also rewrite each stub's provisional bearings and its § Bearing on the answer in place, and I
decide where my open cards 1 and 2 go. Card 2 is the joint between the two milestones. I do not derive: a card whose answer is a derivation goes to
Ephodos.

### 1.3 Expectations written before any tool call (verbatim from the conversation, 2026-09-29 04:42 UTC), scored

- **E1 (the brief)**: "FS116-P1 asks me to pose FS-116's question. That means writing `## The question (Poros, 2026-09-28)` into
  `plans/STUB-local-exclusion.md` (the card, the existence form, the structural form) and rewriting the stub's bearings. It probably opens with R1's
  band question from `plans/POROS-2026-09-28-close-reread.md` §2.4." — **met**, and more: cards 1 and 2 are both handed to me to decide, and Amendment 1
  adds FS-121.
- **E2 (fences)**: "TC1 was briefed in the same commit and runs beside me. The brief will name its fences, and nothing from them may reach the stub." —
  **not met.** The brief reads "fences: none"; TC1 "touches none of your files".
- **E3 (the question itself)**: "my hunch is that FS-116's existence form is 'is there a valid six-colour fragment on a disc of radius R > φ²/√2 about a
  four-colour vertex whose rings carry (Q) arcs?' The structural form should be an invariant every valid fragment carries near a four-colour vertex (the
  straddle count along two unit circles?), posed for every tight near-colouring and not only for maps." — scored in stage 3, against what I pose.

**The conditions of the reading.** Before writing the inventory below, I had already read these, in this order:
- the brief with Amendment 1, and `plans/STANDING-RULES.md`;
- the stub in full;
- my R1 record §§ 1–2.5;
- `data/fs114/claims.md` §§ 0–3 and § 9;
- `LEDGER.md` rows 131 and 133–141;
- `plans/FS111-derivation.md` ll. 1–250 (card 1's entries) and FS111-W-NEG;
- `plans/FS114-derivation.md` § 1 in full, the entries COMPACT, ENDS, JOINT and AVG in full, and § 3 at statement level;
- `plans/FS114-C-close.md` §§ 2.4–2.6;
- the "Proposed for the close" of `plans/FS114-N7-proof.md`;
- `plans/FS114-Y6-construction.md` § 4.1 and `data/fs114/fs114-y6/survey.out`;
- `plans/STUB-map-step.md` in full.

For those items, then, I wrote no expectation before reading. Where one existed it was on file already: my R1 record's findings F1–F9, committed
hours before this job. Those items are read against the R1 findings. The items still unread are read against expectations written now.

### 1.4 Evidence inventory

**Read before this inventory (read against R1's committed findings, or marked where there was none)**
- `plans/STUB-local-exclusion.md`, the stub — read against: R1's F1 ("exactly" where the claim list says "iff uniform") and F3 (the bearing carrying FS-111's door (B)) both still present — surprised: yes; F3 is fixed in the bearing and F1 in the bearing's "uniform in the complexity", but the plain-language section still says "So the whole question … is now **local**" and "Exclude every such fragment (the NO), or build a valid map (the YES)". That second sentence treats "a valid map" as the only YES, while C114-LOCAL-F fails whenever fragments exist at every radius, which needs no map (§ 2 below)
- `plans/FS114-derivation.md` FS114-N2-ENDS, its model line — read against: none on file (a model line is a control; I expected it to match the controls) — surprised: yes; it reads "the capped strip's midline degree-4 vertices, each with four tactic edges (`n = 0`, charge −2)" (l. 239), while FS114-Y6-HELD's survey reads `tactic=0` with four `seg` edges at every strip midline vertex (`data/fs114/fs114-y6/survey.out`), and so does FS114-N's own control ("midline vertices `n = 4` (four straight edges)", `plans/FS114-N-proof.md` l. 299). FS114-N3-JOINT's model line (l. 261, "the strip's midline vertices as deficient vertices") inherits the slip: with `n = 4` a degree-4 midline vertex has charge `n − 2 = 2`, a surplus, not a deficit. **Correction owed**, for Keryx (not mine to edit)
- `data/fs114/fs114-y6/survey.out` with `LEDGER.md` row 136 — read against: none on file (I expected the held positives' four-colour vertices to sit where the count has room, at three or four tactic edges) — surprised: yes; the fragments that reach farthest sit at vertices with **0** (the strip's midline, to `φ²/√2`) and **2** (the disk's corners, to `φ`) tactic edges, and every unit arc of both is "of kind both and centred at a four-colour vertex (four arcs at each midline vertex of the strip and at each corner of the disk's central Reuleaux pentagon)" (row 136) — that is, a (Q) arc (claims § 0: "an arc whose centre carries both side colours and at least four colours"). So every held four-colour vertex that reaches past `√3` has (Q) arcs on its ring. Also: the strip's midline four-colour vertices sit at spacing `1/2`, their colour sets repeating with period 3
- `plans/FS114-derivation.md` § 3 (statements) and `plans/FS114-C-close.md` § 2.6 — read against: R1's inventory (every FS-114 kill is at a degree-4 four-colour vertex with three or four tactic edges, non-Siamese and simple) — surprised: no; confirmed. **Beside the survey, one reading:** the kills sit where rings are (Q)-free or the (Q) case is excepted, and the positives sit on (Q) rings. For the bowtie I derived nothing new; I only lined up two held facts. N6-RING60 puts a (Q)-free ring's change points at `y + 60°ℤ`, and N7-HUB makes each a four-colour vertex. The bowtie's `q1, q2` at `±30°` and `top`, `bot` at `90°`, `270°` (N4-TOP, FS114-Y4-LUNE) are four of those six points, and it dies at `r = (√3, 0)`, a point of the hexagon's second shell
- `plans/FS111-derivation.md` card 1 and FS111-W-NEG — read against: R1's F2 and F4 (route M's halves symmetric; both milestones stop at uniformity in `K`) — surprised: yes; W-NEG (iii) runs, for route R, the contrapositive that nobody has run for FS-116: "A-ALL's failure gives, for every R and δ, holes < δ in U_R, which is χ_m⁰ ≤ 6". Its exact-fragment twin is card `the-yes-needs-no-map` (§ 2)
- `plans/STUB-map-step.md` — read against: R1's F9 (the conflation "seven is the map NO made uniform in the complexity bound") present — surprised: no; present in § The question's first paragraph, as Amendment 1 says; F2's added sentence is present in § Bearing

**Unread at this stage (expectations written 2026-09-29 04:55 UTC, before opening)**
- `plans/FS114-N7-proof.md` §§ 2.1–2.2 (N7-HUB and its tip) — read against: N7-HUB is stated for any four-colour vertex (any number of tactic edges), non-Siamese and simple, and its argument gives each change point both of `p`'s absent colours plus two of `p`'s own — surprised: no; the table (l. 20) states it "At a four-colour vertex (non-Siamese, simple) whose ring is (Q)-free after the bends", any tactic count, and (c) reads "So `y_k` carries at least four colours: `X`, `X̄`, a tip's, and an outer tile's"; one mind; its § 2.3 says where six is spent — "at N6-RING60 (two absent colours alternate; with a seventh colour the ring can carry three …) and at N7-HUB (b)'s exhaustion"
- `plans/FS114-N6-proof.md` or its verifier, N6-RING60 — read against: two minds, one blind; stated at any four-colour vertex whose ring carries no (Q) arc, not only at pinwheels — surprised: no; filed inside FS114-N6-NOQ (`plans/FS114-derivation.md` l. 607 on), two minds, NB6 blind, stated for "a four-colour vertex whose ring carries no (Q) arc"
- `plans/FS114-close-inventory.md` items 118–121 (round 7's queue) — read against: every queued item is inside K1 (three or four tactic edges); none aims at a four-colour vertex with 0–2 tactic edges, at degree ≥ 5, or at Siamese maps — surprised: no; items 118–120 are N7-3T's blind check, the wrap, OC, the (Q)-pinwheel and R-E2 against E2, all inside K1
- `plans/STUB-route-t-count.md` (FS-117) — read against: it claims K1 (round 7's items 1–3) as shared with FS-116, and states that route T needs K1 while FS-116 needs every four-colour vertex — surprised: no; "its sibling FS-116 … holds K1, which this route needs too" (l. 4) and "The whole NO is FS-116's C114-LOCAL-F" (l. 28); it also says route T "can aim FS-116 even where it cannot finish"
- `plans/FS106-derivation.md` FS106-EQ and FS106-STAB, the weak-* step as stated — read against: the Rajchman step is stated for measurable partial colourings on the plane with band-null monochromatic pairs, and applies without change to exact valid fragments on growing discs — surprised: yes, mildly; FS106-COMP is stated on the plane with upper density (l. 227), and the disc form is FS106-STAB (l. 235, one mind, QB agreeing on the equivalence) with a band and a free seventh colour; an exact fragment is tight, band-proper at no `ε`, so it enters either by the Rajchman step run locally or by FS106-STAB after an erosion — neither is written anywhere. Hence card `the-yes-needs-no-map`
- `plans/FS111-derivation.md` FS111-M2-INTRAD and FS111-M2-REDUCE-A — read against: REG-A₆'s map is locally finite given REG-J′ and ¬LRA, and no complexity bound is stated or needed — surprised: yes; M2-INTRAD's interfaces are "locally a chain of segments and circular arcs, finitely many of each radius", with integer radii, and no complexity bound is stated, as expected; but **M2-REDUCE-A is stated "in an honest saturated k-colouring"** — so the map route M's honest branch hands to the NO is honestly saturated. Card 2's joint is a question of regularity class, not of complexity
- `plans/POROS-2026-09-28-close-reread.md` § Draft re-rank, the FS-116 and FS-121 rows — read against: as filed in `plans/FRONTIER-STUBS.md` ll. 84–85 — surprised: no; both rows filed verbatim (a byte comparison, this stage)

### 1.5 The hunch ledger, carried forward (R1's ten, as scored there) and registered today

hunch: third-statement-needed
  claim: FS-114's NO at every complexity bound plus a cone-scale lower bound does not give `lim µ₆(ε) < 1` alone; R's (A) at unbounded
    complexity, a uniform hole bound, or a NO for the limit's boundary class is also needed
  basis: derived
  falsifier: a derivation that every family with holes → 0 and cone scale ≥ s₀ has a subsequence of bounded complexity whose limit is a
    segment-and-arc map
  registered: 2026-09-27
  status: confirmed (by: derivation — FS111-C1-GAP's location, two minds (FS111-P; FS111-V0, blind), and FS111-C1-UNIF, two minds; `plans/FS111-C-close.md` §2.6 item 1)

hunch: the-unit-arc-no-is-global
  claim: no explicit radius R excludes every valid fragment about a four-colour vertex; the NO needs a plane-wide count
  basis: analogy
  falsifier: an explicit radius R with a derived exclusion of every valid fragment on the disc of radius R about a four-colour vertex
  registered: 2026-09-27
  status: killed (by: derivation — FS114-N114-COMPACT, two minds, and FS114-N2-REFINE, one mind; what survives is re-registered as `local-f-overshoots`)

hunch: the-base-print-steps-hold
  claim: S–V Lemma 5, Prop. 18, Lemma 6's `< 9` branch and CUSP-BASE's one-mind items hold in the curved a.e. setting with unit arcs (0.8)
  basis: prior
  falsifier: a configuration meeting a step's hypotheses where its conclusion fails
  registered: 2026-09-27
  status: confirmed (by: derivation — BASE-V, blind, `plans/BASE-V-verification.md`; Lemma 4 at cusps not landed, so CUSP-BASE's D5 items 1–4 and 6 stay at one mind)

hunch: fs115-waits
  claim: FS-114's plan will not commit to the four-colour form for maps that are not periodic, so FS-115 does not open before FS-114's phases (0.65)
  basis: derived
  falsifier: FS-114's accepted plan choosing the four-colour form for aperiodic maps
  registered: 2026-09-27
  status: confirmed (by: `plans/FS114-unit-arc-question.md` ll. 511–512)

hunch: every-valid-map-has-a-four-colour-vertex
  claim: the terminal modification of every valid six-map with unit arcs has a vertex of at least four colours, outside FS112-C-ENDS's named
    residue
  basis: derived
  falsifier: a flaw in the chain of `plans/POROS-2026-09-27-night-aim.md` § 6, or a valid map whose terminal modification has no four-colour vertex
  registered: 2026-09-27
  status: confirmed (by: derivation — FS114-CV-EXISTS, two minds blind to each other, stronger than registered)

hunch: the-closes-nominate-themselves
  claim: each close's draft "Next:" names one of its own successor stubs as the next milestone (0.7)
  basis: prior
  falsifier: either close's "Next:" naming a stub it did not mint
  registered: 2026-09-28
  status: killed (by: `plans/FS114-C-close.md` l. 476 and `plans/FS111-C-close.md` l. 535 — neither named its own successor)

hunch: fs114-closed-undecided
  claim: FS-114 closes with neither the NO nor the YES landed, and at least one local exclusion held at two minds (0.85)
  basis: read
  falsifier: `plans/FS114-C-close.md`'s verdict line reading NO or YES landed
  registered: 2026-09-28
  status: confirmed (by: `plans/FS114-C-close.md` §2.6 and l. 162)

hunch: kills-are-not-band-stable
  claim: FS-114's straddle kills do not survive an ε-band of slack uniformly in the complexity, so FS-116's exclusions cannot be made stable by
    their own proofs, and route M to seven must pass through FS-121's map step (0.65)
  basis: analogy
  falsifier: FS114-Y4-RSTOPALL re-derived for band-proper fragments with slack `ε` and holes of density `< η`, at a radius and a margin independent of
    `ε`, `η` and the complexity
  registered: 2026-09-28
  status: open

hunch: local-f-overshoots
  claim: FS-116's one explicit radius is stronger than the NO: no held compactness gives a radius uniform in the complexity from the NO for every
    locally finite map, so C114-LOCAL-F can fail while no valid map exists (0.6)
  basis: derived
  falsifier: a derivation that valid fragments about four-colour vertices at every radius give a valid locally finite map of the plane
  registered: 2026-09-28
  status: open

hunch: route-m-consumes-unbounded-maps
  claim: FS-121's map step, if it lands, produces segment-and-arc maps of no bounded complexity, so route M consumes the NO for every locally finite map,
    the form only a uniform radius gives (0.7)
  basis: derived
  falsifier: a derivation that REG-A₆'s map can be taken of bounded complexity
  registered: 2026-09-28
  status: open

Registered today, before stage 2's reading:

hunch: fragments-at-every-radius-give-six
  claim: if for every `R` a valid fragment exists on the closed disc of radius `R` about a four-colour vertex (complexity unbounded), then
    `χ_m⁰(ℝ²) ≤ 6`: recentre, take a weak-* limit of the six class indicators, and row 131's Rajchman step with support selection gives a measurable
    six-colouring proper at almost every unit pair. So C114-LOCAL-F, read with `R` uniform in the complexity, is implied by seven, and its failure gives
    `χ(ℝ²) ≤ 6` with no MR (link 2) (0.9)
  basis: derived
  falsifier: a step of that composition failing on valid fragments — the class indicators of a fragment not null on monochromatic unit pairs inside the
    disc, or the Rajchman step as held needing more than local nullity
  registered: 2026-09-28
  status: open

hunch: the-room-is-on-q-rings
  claim: every four-colour vertex that has a valid fragment on the closed disc of radius `√3` about it has a (Q) arc on its ring; a (Q)-free ring dies by
    `√3`, as N7-HUB's hexagon reaches its second shell (0.55)
  basis: analogy
  falsifier: a valid fragment by formula on the closed disc of radius `√3` about a four-colour vertex whose ring carries no (Q) arc
  registered: 2026-09-28
  status: open

### 1.6 The question, so far

*At stage 1 the honest exit stood: no question yet, because the survey had not been made; what it needed was stage 2. Stage 2 replaces it with the
cards in § 2.4.*


## Stage 1 — SAVED

## Stage 2 — SAVED

*The survey, by provenance. The seven items unread at stage 1 were read against the expectations committed then (6fc4a5ea); their results are filled
in place in § 1.4. After that, one more item was read, where an anomaly pointed. FS111-M2-INTRAD's model line cites "row 136's strip (VM2-LAD-CTL,
exact: every edge-side carries its ladder …)", while FS111-VM2-STRIP-MID says the strip is not saturated on its midline. So I read both in
`plans/FS111-VM2-verification.md` (ll. 40–44, 211). **Resolved, and not a collision.** LAD-CTL checked "16 of 16 vertical edge-sides", and VM2 says "the
strip is a fragment on which INTRAD is tested only off the midline". The derivation file's model line dropped that scope. A small correction is owed
(§ 2.5).*

### 2.1 The frame on its five axes (each with the address where it lives)

- **The goal**, in Kooshi's words: *"My goal is to fully solve, and then verify in Lean, HN."* (`CLAUDE.md` l. 74). FS-116 and FS-121 are route M's two
  halves (`FS111-C-SEVEN-M`: "Q-NO ∧ REG-A₆ ⟹ χ_m⁰(ℝ²) ≥ 7").
- **The object** (`data/fs114/claims.md` § 0, "Local": a valid fragment on a disc is a six-coloured segment-and-arc map of an open set containing it,
  with no two interior points of one colour at distance exactly 1). It has **two natural sizes, and the frame names one.** `[SokolovVoronov2025]`
  Question 2 asks about every locally finite map. Route M's honest branch hands the NO only **honestly saturated** maps: FS111-M2-REDUCE-A derives
  REG-A_k "in an honest saturated k-colouring". The cover branch has a NO of its own, NO-PAR (`plans/STUB-map-step.md` question 1). So **route M never
  needs FS-116's NO for an unsaturated map**, and the frame has not used that. Saturation is where the best positive fails: the capped strip, which
  reaches `φ²/√2`, is "not saturated on its midline", at the edges of its own four-colour vertices (FS111-VM2-STRIP-MID).
- **The question** (the stub, § The question; row 138). FS-114 asked which configurations die. It asked this of **the count's room**: degree-4
  vertices with three or four tactic edges, where N2-ENDS's charge is negative. Every kill is there, at a (Q)-free ring or with the (Q) case excepted.
  **The positives' room is elsewhere.** The held fragments that reach farthest sit at vertices with 0 and 2 tactic edges, whose rings carry (Q) arcs
  (row 136; `data/fs114/fs114-y6/survey.out`). These are the vertices FS-114 never touched.
- **The discipline.** The kills are elementary plane geometry of unit circles: straddles, tangencies, cones. The regularity of saturated colourings is
  contact geometry: every interface is pinned by partners at distance exactly 1 (G84; FS111-M-PINCH). **The two are one object seen twice.** A unit arc
  of "kind both" (its centre carries both side colours) is the map-side name for M-PINCH's first case, "a unit arc whose centre carries both colours".
  A (Q) arc is such an arc at a centre of at least four colours. For a stranger, the object is the contact graph of a unit-distance-avoiding partition,
  points joined to their partners at distance 1. Sirgedas's dual graph (C114-SKELETON, "not derived") is its combinatorial shadow.
- **The audience.** The answer, through route M; `[SokolovVoronov2025]` Question 2's unit-arc half; `[Polymath2021]` p. 199; and Mixon's thread-7 question
  (the stub, § Bearing on the answer).
- **The product.** The stub reads: "Exclude every such fragment (the NO), or build a valid map (the YES)". **The failure of C114-LOCAL-F is not a valid
  map.** It is a valid fragment at every radius, whose complexity may grow without bound. By the weak-* step that sequence is already a measurable
  six-colouring of the plane, which is `χ(ℝ²) ≤ 6` with no MR. That is a hunch at 0.9, and card `the-yes-needs-no-map` asks Ephodos to check it. It is
  the exact-fragment twin of what FS111-W-NEG (iii) runs for route R. If it holds, **the uniform radius is implied by seven, so it is never an
  overshoot of the answer**, and FS-116 is decisive in both directions without FS-121.

### 2.2 Registrations scored

- `local-f-overshoots` — **open.** Nothing read settles whether the NO for every locally finite map gives a uniform radius. Its sting is gone, though,
  if card `the-yes-needs-no-map` holds. The uniform radius would then be implied by seven, and it could fail only if `χ(ℝ²) ≤ 6`.
- `route-m-consumes-unbounded-maps` — **open.** M2-INTRAD's map is locally finite ("finitely many of each radius", locally), with no complexity bound
  stated, which is consistent with the claim. Nothing derives that the bound cannot be had. It no longer bears on FS-116's form (card 2's resolution,
  § 2.4).
- `kills-are-not-band-stable` — **open**, re-addressed with card 1 (§ 2.4).
- `fragments-at-every-radius-give-six`, `the-room-is-on-q-rings` (registered at stage 1) — **open**; they are cards 2 and 3's hunches.

Registered now, before any answer:

hunch: saturation-pins-the-four-colour-vertex
  claim: in an honestly saturated valid fragment every edge at a vertex of at least four colours is pinned — each point has a tile of each side colour
    at distance exactly 1, a unit arc about a centre carrying both colours or a curve between two tangent unit discs (FS111-M-PINCH read at a vertex) —
    so the capped strip's midline configuration (four straight edges, both side colours free at their midpoints) cannot occur in that class (0.6)
  basis: derived
  falsifier: an honestly saturated valid fragment by formula with a four-colour vertex one of whose edges has a side colour with no tile at distance
    exactly 1 from its points
  registered: 2026-09-29
  status: open

hunch: q-rings-force-a-pattern
  claim: at a four-colour vertex whose ring carries a (Q) arc, the ring's change points off the (Q) arcs are vertices of at least four colours, as N7-HUB
    has for (Q)-free rings, so the four-colour skeleton propagates through (Q) rings too (0.5)
  basis: analogy
  falsifier: a valid fragment by formula with a (Q)-ring four-colour vertex one of whose ring change points has three colours
  registered: 2026-09-29
  status: open

### 2.3 What is curious, and the pattern that would make it a matter of course

**C1 — Every kill is where the count has room; every positive is where it has none.** FS-114 aimed six rounds at the configurations N2-ENDS's charge
makes negative. That was the right aim for route T, whose deficit must be paid there. FS-116's question, though, is about every four-colour vertex,
and the held fragments that reach past `√3` all sit at surplus vertices (charge `n − 2 = 2` at the strip's midline; 0 or 2 tactic edges) and on (Q)
rings. The pattern that makes this a matter of course is that the (Q) arc is the positives' device. It is the unit-radius tactic's own arc, centred at
a vertex that carries both its side colours, so it pins its interface by contact. A (Q)-free ring has no such device: N6-RING60 and N7-HUB force a
hexagon of four-colour vertices, and the configuration dies by the hexagon's second shell (the bowtie at `r = (√3, 0)`). **FS-116's residue is the (Q)
rings, and its structural question is the ring** (§ 2.4, card 3; § Structural form in stage 3).

**C2 — The best positive is unsaturated exactly at its centre, and the NO route M consumes is saturated.** FS111-VM2-STRIP-MID puts the strip's
unsaturation on the midline edges, and those are the four straight edges of the strip's four-colour vertices, the vertices FS114-Y-DIAL's `φ²/√2` is
measured about. FS111-M2-REDUCE-A hands route M's NO an honestly saturated map. So the saturated class may lose the strip's configuration outright.
That reading is a hunch (`saturation-pins-the-four-colour-vertex`), not a derivation. Nobody has asked what saturation does at a four-colour vertex. The
two milestones' records never met: FS-111 read the strip as a control for INTRAD, and FS-114 read it as the dial.

**C3 — The stub's YES is a map; the question's negation is not.** See § 2.1, the product axis. The pattern is F1's again: the stub keeps an equivalence
that FS-114's own compactness entry (N114-COMPACT) holds only at each `K`. Across complexity, the right tool is the weak-* limit, as FS-111 knew for
route R (W-NEG (iii)).

**Which result stands without its mechanism.** FS114-Y-DIAL's `φ²/√2` (the strip holds every smaller disc about a midline vertex) stands as a
measurement of one object. Nothing says why a four-colour vertex with four straight edges reaches that far. C2 suggests the mechanism is its
unsaturated edges.

**What path has nobody considered.** Posing FS-116's NO in the class route M consumes (C2), and reading the (Q) arc as the contact that FS-111's
regularity theory is built on (C1).

### 2.4 The cards, and what I decided about R1's cards 1 and 2

question: what-does-saturation-pin
  evidence: FS111-M2-REDUCE-A derives REG-A_k "in an honest saturated k-colouring" (`plans/FS111-derivation.md`); FS111-M-PINCH, three minds: every
    two-colour interface point of a saturated colouring lies on "a unit arc whose centre carries both colours" or a `C^{1,1}` curve "between two tangent
    unit discs" (`LEDGER.md` row 140); FS111-VM2-STRIP-MID: the capped strip is "not saturated on its midline", at the four straight edges of its
    four-colour vertices (`data/fs114/fs114-y6/survey.out`: `tactic=0`), the vertices about which it holds every disc below `φ²/√2` (FS114-Y-DIAL)
  expected: that route M consumes FS-116's NO over every valid map, as the stub's bearing says
  ask: In an honestly saturated valid fragment — the class route M's honest branch must exclude — what does saturation force on the edges at a vertex of at least four colours?
  if every edge is pinned: the strip's midline configuration is outside the class; FS-116 poses its NO in the saturated class first (route M's need), keeps the all-maps form for Sokolov–Voronov's Question 2, and aims FS-114's straddle kills at the pinned vertices with 0–2 tactic edges
  if nothing new is pinned: saturation is a scope note for route M only; FS-116 keeps the all-maps class from its opening and starts from card what-do-q-rings-force
  answered by: derivation — Ephodos, FS-116's proof side at its opening (FS-121's opening to be told the answer, since its honest route produces the class)
  cost: an hour to one round; M-PINCH, W-NOBEND and W-NOREP are held, and the step is to read them at a vertex of a map
  hunch: every edge is pinned, and the strip's midline dies (hunch `saturation-pins-the-four-colour-vertex`, 0.6)
  falsifier: an honestly saturated valid fragment by formula with a four-colour vertex one of whose edges has a side colour with no tile at distance exactly 1 from its points
  rank: 1

question: the-yes-needs-no-map
  evidence: FS111-W-NEG (iii), two minds: "A-ALL's failure gives, for every R and δ, holes < δ in U_R, which is χ_m⁰ ≤ 6"; `LEDGER.md` row 131's
    mechanism, "the circle measure is Rajchman (row 130's weak-* step), so a limit of near-colourings is a colouring after support selection"; FS106-STAB's
    disc form (`plans/FS106-derivation.md` l. 235); the stub: "Exclude every such fragment (the NO), or build a valid map (the YES)"
  expected: that C114-LOCAL-F's failure needs a valid map of the plane, as the stub says
  ask: Does a sequence of valid six-colour fragments on discs of unbounded radius, their complexity unbounded, give a measurable six-colouring of the plane proper at almost every unit pair, by row 131's weak-* step and support selection?
  if it does: C114-LOCAL-F with R uniform in the complexity is implied by seven, and its failure is χ(ℝ²) ≤ 6 with no MR; FS-116 is decisive both ways without FS-121; the YES side aims at fragments at every radius, complexity free, not at a map; the complexity half of R1's card 2 dissolves
  if it does not: the failing step is named; the stub's "build a valid map (the YES)" stands, and whether FS-121's map has bounded complexity (R1's card 2 as posed) decides FS-116's form
  answered by: derivation — Ephodos at FS-116's §IQ, a check before the first round
  cost: under an hour; a composition of held steps
  hunch: it does (hunch `fragments-at-every-radius-give-six`, 0.9)
  falsifier: a step of the composition failing on valid fragments
  rank: 2

question: what-do-q-rings-force
  evidence: every held fragment that reaches past `√3` has (Q) arcs on its four-colour vertices' rings (`LEDGER.md` row 136, "every unit arc of kind both
    and centred at a four-colour vertex"; the strip to `φ²/√2`, the disk to `φ`); every FS-114 exclusion is at a (Q)-free ring or excepts (Q) rings (row
    138's not-claimed, "K1 (GAP at rings with (Q) arcs …)"; `plans/FS114-C-close.md` § 2.6 item 3); on a (Q)-free ring N6-RING60 (two minds, one blind)
    and N7-HUB (one mind) put six four-colour vertices at `y + 60°ℤ`, and the bowtie, whose `q1, q2, top, bot` are four of them, dies at `r = (√3, 0)`
  expected: that the exclusions had reached the vertex types the positives use — they had not
  ask: At a vertex of at least four colours whose ring carries a (Q) arc, which vertices of at least four colours, and which (Q) arcs, does the ring force at distance 1 — as N7-HUB does for (Q)-free rings?
  if a forced pattern: the four-colour skeleton propagates through (Q) rings; the strip (a line of midline vertices at spacing 1/2) and the disk (a 5-cycle of corners) are its two held recurrences; the proof side follows the pattern outward to the first straddle
  if nothing is forced: a (Q) ring can close without placing another four-colour vertex; the construction side builds there first, a fragment by formula about a (Q)-ring vertex beyond `φ²/√2`, and the NO needs another handle there
  answered by: derivation — Ephodos, FS-116's proof side, with the strip's midline vertices and the disk's corners as controls
  cost: one derivation round
  hunch: a forced pattern (hunch `q-rings-force-a-pattern`, 0.5); N7-HUBQ already gives a tip at every change point whose ±60° neighbours are off (Q) arcs
  falsifier: a valid fragment by formula with a (Q)-ring four-colour vertex one of whose ring change points has three colours
  rank: 3

**R1's card 1, `do-fs114-kills-survive-a-band`: re-addressed to FS-122's opening (route R), not asked at FS-116.** Even if one kill survived a band, FS-116
could not be posed on near-colourings from its opening. That posing needs a robust form of FS114-CV-EXISTS (a fat four-colour point in every band-proper
near-colouring with small holes). CV-EXISTS goes through stuck chains of the terminal modification, a global and exact argument
(`plans/FS114-derivation.md` l. 26 on), and no one has a robust form. A band-stable local kill is a statement of route R's kind, beside (A) and B-RR, so
its home is FS-122. Hunch `kills-are-not-band-stable` stays open. **Default if Keryx says nothing:** the card is carried in FS-122's stub at its opening,
and FS-116 does not ask it.

**R1's card 2, `which-no-does-route-m-consume`: split, and answered in part by reading.** *Its complexity half* dissolves if card `the-yes-needs-no-map`
holds. The uniform radius is then necessary for seven, and FS-116 poses it whatever FS-121 outputs; FS-121 need produce only a locally finite map, which
M2-INTRAD's form already gives. *Its class half* is the real joint, and card `what-does-saturation-pin` asks it. The honest route outputs honestly
saturated maps (M2-REDUCE-A), so route M's honest branch consumes FS-116's NO in that class only. The cover route has a NO of its own, NO-PAR. **Which
milestone asks it:** FS-116's opening, because the answer changes FS-116's class. FS-121's opening is told the answer, because FS-121 produces the class.

**Is C114-LOCAL-F as posed FS-116's question?** Yes, as the existence form, with three changes. Its uniformity in the complexity is written into the
statement. Its failure is stated as fragments at every radius, not as a map, conditional on card 2. And its first card is the class question. The
structural form is the ring (stage 3).

### 2.5 Findings for Keryx (corrections owed; not mine to edit)

- `plans/FS114-derivation.md` l. 239, FS114-N2-ENDS's model line: "the capped strip's midline degree-4 vertices, each with four tactic edges (`n = 0`,
  charge −2)" → "the capped strip's midline degree-4 vertices, each with four straight edges (`n = 4`, charge 2): a surplus, not the configuration the
  charge penalises" (`data/fs114/fs114-y6/survey.out`; `plans/FS114-N-proof.md` l. 299); and l. 261, FS114-N3-JOINT's model line, "the strip's midline
  vertices as deficient vertices" needs the same check against N3's record.
- `plans/FS111-derivation.md` l. 1019, FS111-M2-INTRAD's model line: "row 136's strip (VM2-LAD-CTL, exact: every edge-side carries its ladder, …)" →
  "row 136's strip off its midline (VM2-LAD-CTL, exact: 16 of 16 vertical edge-sides carry the ladder …; the midline is unsaturated, VM2-STRIP-MID)".
- `plans/STUB-local-exclusion.md`'s provisional bearings name G67 and G51, both retired. I drop them in stage 3, since the stub is mine for this job.

Invention signal: none seen. I read for it in the stub; `data/fs114/claims.md` §§ 0–3, 9; `LEDGER.md` rows 131, 133–141;
`plans/FS114-derivation.md` §§ 1–3; `plans/FS114-C-close.md` §§ 2.4–2.6; `plans/FS114-N7-proof.md` §§ 2.1–2.4, 3.2; FS114-N6-NOQ;
`plans/FS114-close-inventory.md` items 118–121; `plans/FS111-derivation.md` card 1, W-NEG, M2-INTRAD, M2-REDUCE-A, VM2-STRIP-MID and W-NOREP;
`plans/FS111-VM2-verification.md` ll. 40–44, 211; `plans/FS106-derivation.md` EQ, COMP and STAB; `plans/STUB-map-step.md`; and
`plans/STUB-route-t-count.md`. Three near-collisions were examined and classed:
- N2-ENDS's model line against the survey — a filing slip; two exact readings of the object agree against it.
- LAD-CTL against STRIP-MID — a dropped scope ("vertical", "off the midline").
- "where the count gives six room" (row 138) against where the positives reach — consistent. The count's negative charge marks a deficit that must be
  paid, and the positives sit at surplus vertices.

None is two held truths that cannot both stand.

## Stage 2 — SAVED

## Stage 3 — SAVED

### 3.1 What I wrote into `plans/STUB-local-exclusion.md`, and what I changed that FS-114's close wrote

- **Added** `## The question (Poros, 2026-09-29)`: § The card (the rank-1 card of § 2.4, verbatim, in a fence so that the gate reads only this record's
  cards), with the other two cards named by rank; § Existence form; § Structural form. The forms are quoted here so that the record carries them:
  - *Existence form:* "**Is there a radius `R` — one `R` for every complexity, Siamese pairs allowed — such that no valid fragment exists on the closed
    disc of radius `R` about a vertex of at least four colours?**"
  - *Structural form:* "**In every valid fragment with any number `k ≥ 4` of colours, what does the unit circle about each vertex of at least four
    colours carry — its (Q) arcs, its change points, and the vertices of at least four colours it places at distance 1 — and which of these ring types
    can recur at every such vertex a ring places?**"

  The structural form is not the existence form reworded. It asks for the finite rule every fragment obeys at its four-colour vertices, independent of
  `R` and of the colour count. It has a seven-colour inhabitant (R7's lattice points), which makes the vacuity test the claim list asks for, and it
  names where six is spent (N6-RING60's "with a seventh colour the ring can carry three").
- **Rewrote in place** the provisional-bearings line (as a list) and § Bearing on the answer. The bearing now says three things:
  - the question is decisive in both directions if card `the-yes-needs-no-map` holds, and that card is marked as Poros's, one mind, unchecked;
  - route M's honest branch needs the NO only in the honestly saturated class (FS111-M2-REDUCE-A);
  - the all-maps NO is what answers Question 2.

  I kept FS-114's list of what the NO answers word for word.
- **Changed two sentences of § The question, in plain language, because they were wrong:**
  - "So the whole question … is now **local**:" → "So one local statement suffices for the whole question …". This is R1's F1, left in this section
    by the close: at each `K` the question is local by compactness, and one uniform radius suffices for the whole NO. "Is local" claims the converse,
    which is open (hunch `local-f-overshoots`).
  - "Exclude every such fragment (the NO), or build a valid map (the YES)" → "… or build such a fragment on every disc (its failure; a valid map of the
    plane is one way, not the only one …)". The negation of C114-LOCAL-F is fragments at every radius, whose complexity may grow, and no compactness
    turns them into a map.
- **Dropped** G67 and G51 from the bearings; both are retired.
- **Left as FS-114's close wrote them:** § What FS-114 established, § The opening queue, § Beyond K1, § Owed second minds, § Construction targets,
  § Prior-art debts, § Registered expectations, § Failure clauses, § Known tool defects, § Decisions held, § Deliverables. The opening queue is not
  wrong: its items are K1's, and K1 remains a piece of the NO. My cards rank ahead of it for the reasons in § 2.3, C1–C2. Whether round 7's items
  keep their order is the plan's call once card 1 returns.

### 3.2 E3 scored

E3 (before any tool call) guessed an existence form "about a four-colour vertex whose rings carry (Q) arcs", and a structural form built on "the
straddle count along two unit circles", "posed for every tight near-colouring".
- **The (Q)-ring focus: met.** It became card 3 and the heart of the structural form.
- **The structural invariant: missed.** It is the ring type and its transfer rule, not the straddle, which is the kill, not the invariant.
- **The class: missed.** It is valid fragments at any `k`, not near-colourings; the band card went to route R.
- **The existence form: missed.** It was not narrowed to (Q) rings; it covers every four-colour vertex, as C114-LOCAL-F does.

A prior guess, 1 of 4 parts met, consistent with the study's rate for prior hunches.

## Stage 3 — SAVED

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
- `plans/FS114-N7-proof.md` §§ 2.1–2.2 (N7-HUB and its tip) — read against: N7-HUB is stated for any four-colour vertex (any number of tactic edges), non-Siamese and simple, and its argument gives each change point both of `p`'s absent colours plus two of `p`'s own — surprised: unread
- `plans/FS114-N6-proof.md` or its verifier, N6-RING60 — read against: two minds, one blind; stated at any four-colour vertex whose ring carries no (Q) arc, not only at pinwheels — surprised: unread
- `plans/FS114-close-inventory.md` items 118–121 (round 7's queue) — read against: every queued item is inside K1 (three or four tactic edges); none aims at a four-colour vertex with 0–2 tactic edges, at degree ≥ 5, or at Siamese maps — surprised: unread
- `plans/STUB-route-t-count.md` (FS-117) — read against: it claims K1 (round 7's items 1–3) as shared with FS-116, and states that route T needs K1 while FS-116 needs every four-colour vertex — surprised: unread
- `plans/FS106-derivation.md` FS106-EQ and FS106-STAB, the weak-* step as stated — read against: the Rajchman step is stated for measurable partial colourings on the plane with band-null monochromatic pairs, and applies without change to exact valid fragments on growing discs — surprised: unread
- `plans/FS111-derivation.md` FS111-M2-INTRAD and FS111-M2-REDUCE-A — read against: REG-A₆'s map is locally finite given REG-J′ and ¬LRA, and no complexity bound is stated or needed — surprised: unread
- `plans/POROS-2026-09-28-close-reread.md` § Draft re-rank, the FS-116 and FS-121 rows — read against: as filed in `plans/FRONTIER-STUBS.md` ll. 84–85 — surprised: unread

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

no question: the survey has not been made
  need: stage 2 — the unread items above read against their expectations, then the cards

Invention signal: none yet (stage 1 read for it; see stage 2).

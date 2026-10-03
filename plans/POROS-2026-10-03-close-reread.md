# Poros — the boundary re-read of FS-116's and FS-121's closes, and the draft re-rank (job R2, 2026-10-03)

*Job R2, Poros (the asker). Brief: `data/workflow3/briefs/R2-poros-close-reread.md`, with `plans/STANDING-RULES.md` as part of it. Started
2026-10-03 18:21 UTC (`date`). No fences: both milestones are closed and no blind job is running. Working files go under
`data/workflow3/r2/`.*

## Theorems this phase proved

None. Poros does not derive. The one algebraic identity this record leans on (§ 2, Kooshi's question) is classical. It is offered in the
hypothetical mood with a numerical control and is addressed to Ephodos for its uses. It is not claimed here as a theorem.

## Would-have-searched-here log (standing rule 5)

Rule 5's ban ended on 2026-10-01, and Kooshi has not extended it (the brief, § Done means, item 1). The log is kept anyway, one line per move I
would have made by search. Stage 1: none.

## Fence log (standing rule 8)

No fences in this brief. No fenced text touched.

## Stage 1 — SAVED

### 1.1 Readback of the brief (every quotation checked against its source)

**The task, restated.** FS-116 (the local exclusion) and FS-121 (the map step) are the two halves of route M. I posed them on 2026-09-29, and both
have now closed: FS-121 in one close job (Z1) and FS-116 in two (Z1, Z2). My job is the lane file's job 3:
- re-read both closes' whole records on purpose, not their summaries, with `poros-anomaly-hunt`;
- score my hunch ledger in the open;
- answer by card two findings the closes left for me by name (FS-121 item 89, FS-116 items 136 and 145);
- pose Kooshi's question on V6-HUG's identity as a card;
- draft the re-rank of `plans/FRONTIER-STUBS.md` and the `CLAUDE.md` § Paths forward table, with a "Next:" clause;
- keep FS-129 (the cross-application audit) unranked, in its fixed place after the filing and the workflow refinement, and name what opens after it;
- say per ranked stub whether its next step wants a solver.

The ranking is by bearing on the answer.

**The quotations, checked.**

1. Kooshi's instruction, "Please revive your agents with messages, and continue with the milestone.", with the source given as
   `plans/FS116-close-inventory.md` row 74. **Matches**, as an exact substring of row 74 (l. 108). The brief quotes one sentence of a longer message
   without marking the cut. The sentences left out ("You may revive all agents, but as they finish up, reduce total concurrency to 3 …"; "Give me an
   interim report …") are about staffing and do not change what my job is. Logged as an excerpt, not a defect.
2. FS-116's frozen § 9, "No enumeration of maps, colourings, tile graphs or dual graphs, by any program". **Matches** `data/fs116/claims.md` l. 153,
   which is in § 9 (§ 9 runs ll. 145–155). That line says the sentence is quoted "(`data/fs114/claims.md` § 6, verbatim)", and FS-114's § 6
   (l. 166–167) does carry the same words. **A finding about the rule's origin:** in FS-114 the sentence is not Kooshi's and not `CLAUDE.md`'s. It
   follows FS-114's marker "*(this list)*", so it was FS-114's own addition on top of the ban. Its standing after 2026-10-01 is therefore a
   milestone's own constraint, carried by inheritance. The brief reads it the same way ("binding only that milestone's own successors if their stubs
   carry it").
3. Kooshi's question, quoted in the brief as *where else can it be used?*, dated 2026-10-03. **A paraphrase.** The source (`plans/FS116-close-inventory.md`
   item 142, l. 176) reads: "That's an interesting one. How did the original proof do it, and where else can we use that identity?" The meaning is
   kept. The first half ("How did the original proof do it") was answered by Keryx in item 142 itself, so the paraphrase drops nothing I am asked to
   answer. Reported as a small finding about the brief (standing rule 3).
4. The identity `|a − b|² − 1 = −8 sin(s/2) sin(t/2) cos((s + t)/2)`, attributed to V6-HUG in `plans/FS116-V6-verification.md` § 2.2. **Matches in
   substance.** V6-HUG is in § 2.2 ("The derivation — the class is empty"), and the source line reads
   `|a(s) − b(t)|^2 − 1 = −8 \sin\tfrac{s}{2}\,\sin\tfrac{t}{2}\,\cos\tfrac{s+t}{2} < 0 \quad (0 < s, t \le 60°)`. The brief drops the
   parametrization (`a(s) = y_0 + e(120° + s)`, `b(t) = y_1 + e(300° − t)`, with `y_1 − y_0 = e(120°)`) and the range clause. Both matter for "where
   else": the identity is exact for all `s, t`, and the range is only where V6 uses its sign.
5. `CLAUDE.md` is "70,396 bytes": **matches** (`wc -c`).
6. "Rank by bearing on the answer, never by difficulty, length or formalization effort (`CLAUDE.md` § Counter-priors, rule 1)". Not in quotation
   marks. The source rule is "Rank a route by its bearing on the answer, never by its difficulty, its length or its formalization effort." The
   substance is the same.
7. Named items, checked to exist: FS-121 item 89 (l. 120, "three of FS-121's open claims are one question (FS-126); the structural form named the
   right objects and the wrong invariant"); FS-116 items 136 and 145 (ll. 170, 179); V6-ADJ (V6 l. 239, "outer tiles of one colour at adjacent hubs
   cannot both hug the lens arcs beyond their hubs"). FS116-Y4 § 3.4's three neighbours are read at stage 2.

**Read before these expectations were written, disclosed so they are not scored as predictions.** The brief; the standing rules; my previous
record `plans/POROS-2026-09-28-fs116-question.md` (§§ 1.5, 2, 4); `plans/FS116-close-inventory.md` items 1–36 (in the first read, before I knew to
stop), with items 74, 89, 136, 142, 145 and W4 (for the readback); `data/fs116/claims.md` ll. 150–155 and the section list; `data/fs114/claims.md` § 6;
and V6 ll. 140–160 (V6-HUG's proof). From items 1–36 I know three things. FS116-O1-YESLIM is TRUE at two minds (my hunch
`fragments-at-every-radius-give-six`). FS116-O1-SATPIN is TRUE at two minds in corrected wording. FS114-N7-3T came back GAP from its blind second
mind. I know nothing yet of either close's headline.

### 1.2 Expectations, written before the re-read (scored at stage 2)

- **E1.** FS-116 closed undecided: neither C114-LOCAL-F's NO at a uniform radius nor a YES. Its held residue is narrowed by class. Expect (Q)-free rings
  excluded at some radius (FS116-Y4-EMPTY is held, two minds, by the brief), with the (Q)-ring class open and the (R2)-arc rings as the bends
  signal's exception. (0.85)
- **E2.** FS-121 closed undecided: REG-A₆ not landed, with NO-PAR and ¬LRA open. FS-126 (curved pencils, by its stub's name) is "the one question" for
  three open claims. (0.8)
- **E3.** Each close's drafted "Next:" names a stub it minted itself. This is the hunch R1 killed last time (neither named its own), so it is a fresh
  prior. (0.6)
- **E4.** At least one close states a result that stands without its mechanism, a measured or by-formula reach with nothing saying why. FS-114's
  `φ²/√2` was the last one. (0.6)
- **E5.** The bends signal (items 136, 145) is unresolved at the close and was routed rather than decided. Expect both sides to be held at one mind or
  more, the collision being about what FS-112's bends do to a ring on a fragment versus on a whole map. (0.7)
- **E6.** V6-HUG's identity is the exact form of FS-114's "straddle" (G83: "two tiles of one colour forced along two unit circles to come within 1").
  So "where else" means every straddle whose two circles' centres are a unit apart, and the (R2)-arc rings rank first, since the bends signal leaves
  them as the next case. (0.5)
- **E7.** My card `do-ladders-end-on-q-rings` (FS-121's rank 1) was answered at FS-121's opening with a failing link (a cusp, a repeated colour, or a
  rung above radius 1), not confirmed outright. (0.55)
- **E8.** My card `what-do-q-rings-force` was not answered: the (Q)-ring class is FS-124's object, open. (0.7)
- **E9.** My draft's rank 1 is the stub carrying FS-116's residue ring class, ahead of FS-121's successor. FS-122 and FS-104 stay in the top five.
  (0.55)
- **E10.** Neither close changed a value: χ(ℝ²) ∈ {5, 6, 7} still, and no headline is announced as answering a posed question in print. (0.9)

### 1.3 Evidence inventory (by provenance; each expectation written before the item was opened at stage 2; the reading's result filled in at stage 2)

- `plans/FS116-Z2-close.md`, the headline, the sweeps and § Drafts for the front page — read against: E1's undecided headline narrowed by class; a drafted "Next:" naming FS-123 or FS-124 (E3) — surprised: yes; the headline is E1's (§ 4.1, "GAP at named ring types, one type removed"), but unit 2's "Next:" names no stub ("**Next:** Poros's re-rank"), and § 1.5 shows the bends question's side 1 is not about (Q)-free rings alone (§ 2.3 C1 below)
- `plans/FS116-Z1-close.md`, the reconciliation and the headline's draft — read against: every frozen claim with a verdict and a mind count; at least one MISSTATED claim corrected; the headline drafted narrower than Z2's — surprised: yes; as expected on the first two (§ 2.1: SATPIN, RING-TWIST, RING-TRANSFER, ECHO misstated and filed corrected), but § 2.4 F1 finds FS114-N7-3T's only model of the (Q)-free class, FS114-Y2-BOWTIE, has (Q) arcs on its ring, so no inhabitant of that class has ever been held (§ 2.3 C2)
- `plans/FS121-Z1-close.md`, with § 2.5 (FS-126) and D10 (the drafted row) — read against: E2; "the structural form named the right objects and the wrong invariant" pointing at my structural form and naming the invariant — surprised: yes; § 4.5 scores the milestone's own registrations 0 of 8, every miss toward a theorem landing, my hunch at 0.7 the costliest — the opposite direction to FS-116's verifiers (§ 2.3 C4); § 4.1 records G13 (coverage) as the entry that should have borne on TOP₆ and was never asked
- `plans/FS121-derivation.md` and `plans/FS116-derivation.md`, by entry (FS121-O1-OUT, -ENDS, -CARD, -ABOVE7, FS121-D2-INCURVED, FS121-Z1-NOCURVED; FS116-N3-SEMI, -SEMI-PAR3, -RING-GERM, -N2-FIVERING) — read against: each held entry's grade matching the close's headline; no entry promoted above its mind count — surprised: yes; FS121-Z1-NOCURVED's statement ends "no (R2) arc occurs", which joins FS-126 to FS-123's (R2)-arc rings, and neither stub says so (§ 2.3 C3); grades as the closes state them
- The six new stubs, FS-123 to FS-128 — read against: each with a bearing line against § The aim, at least two "none alone"; FS-123 carrying the bends question first — surprised: no; FS-126 and FS-127 are "none alone", FS-128 "at six, and next to the answer", FS-123 opens on the bends; each stub carries its inhabitant target, but FS-126's opening order is the open step first, not the inhabitant (§ 2.5 card 3)
- The open stubs whose bearing lines the closes rewrote (FS-122, FS-120, FS-115, FS-117, FS-128, FS-104, FS-44, FS-109) — read against: bearings changed only where a close result touches them — surprised: yes; FS-115's live bearing (¬LRA) moved into FS-126 by FS-121's close ("it lives inside FS-126 … the line form is not needed"), so its rank no longer has a reason (§ 2.6)
- `plans/FS121-close-inventory.md` and `plans/FS116-close-inventory.md` beyond item 36, by grep for "Poros" and "Kooshi" — read against: the items held for Poros as the brief quotes them — surprised: yes; FS-116's item O7 (Kooshi, 13:30, after this brief was written) keeps the search ban in force pending a count ("before we remove it outright … restricting search to a wallclock budget per day and per week"), which the brief's "Kooshi has not extended it" predates; FS-121 items 16, 23, 54 and 67 are also addressed to Poros
- FS116-Y4 § 3.4 (three neighbours of its flank lemma) and V6 §§ 2.2–2.3 (HUG, ADJ) — read against: E6, the identity is the straddle's exact form and its neighbours are unit-pair configurations — surprised: yes; the identity is wider than the straddle: with `y_1 − y_0` rotated to 1 it is `|u + v + w|² − 1` for three unit vectors, which factors classically, and V6-ADJ is the same identity on the other Reuleaux triangle of the same unit pair (§ 2.3 C5; control `data/workflow3/r2/identity_check.py`)
- `plans/STUB-cross-application-audit.md` (FS-129) — read against: an audit of where held lemmas apply beyond their first use, which Kooshi fixed after the filing — surprised: no; its four prompting instances include this job's two named findings and Kooshi's identity question
- `plans/FRONTIER-STUBS.md`, the ranked table and its columns, and `CLAUDE.md` § Paths forward — read against: FS-116 at 1 and FS-121 at 2 as R1 filed; 69 open rows; a solver column to be read as of now — surprised: yes; 69 rows as expected, but two rows carry an unescaped pipe inside a cell (FS-65's `|Aut|` at l. 108, FS-41's `|S|` at l. 134), which splits their cells when the table is rendered or parsed; FS-72's pipes are escaped and render (§ 2.7)
- `plans/FS114-NB6-verification.md` ll. 100–111 and `plans/FS114-NB5-verification.md` ll. 116–121 (side 1's sources, opened where C1 pointed) — read against: side 1 stated about (Q)-free rings, in a lemma's own setting — surprised: yes; NB6 states side 2 (l. 104, "After the bends every `Γ`-arc of the ring is (Q) or (R2) (N5-BENDG, two minds, one blind …)") and side 1 (ll. 106–108) one line apart as compatible facts about two domains, names no ring type for side 1, and records two readings of "(Q)" (ll. 109–111)
- The brief, read in full — read against: a job of job-3 shape with two named findings and one question from Kooshi — surprised: no
- `plans/FS116-close-inventory.md` items 1–36 (read before these expectations; disclosed in § 1.1) — read against: nothing written beforehand; read as context — surprised: no
- `data/fs114/claims.md` § 6 against `data/fs116/claims.md` § 9 — read against: the enumeration rule being Kooshi's ban restated — surprised: yes; it is FS-114's own addition, marked "*(this list)*" (§ 1.1 item 2)

### 1.4 The hunch ledger, carried forward (from `plans/POROS-2026-09-28-fs116-question.md` §§ 1.5, 2.2, 4.1; statuses as left there, scored at stage 2)

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

hunch: fragments-at-every-radius-give-six
  claim: if for every `R` a valid fragment exists on the closed disc of radius `R` about a four-colour vertex (complexity unbounded), then
    `χ_m⁰(ℝ²) ≤ 6`: recentre, take a weak-* limit of the six class indicators, and row 131's Rajchman step with support selection gives a measurable
    six-colouring proper at almost every unit pair. So C114-LOCAL-F, read with `R` uniform in the complexity, is implied by seven, and its failure gives
    `χ(ℝ²) ≤ 6` with no MR (link 2) (0.9)
  basis: derived
  falsifier: a step of that composition failing on valid fragments — the class indicators of a fragment not null on monochromatic unit pairs inside the
    disc, or the Rajchman step as held needing more than local nullity
  registered: 2026-09-28
  status: confirmed (by: derivation — FS116-O1-YESLIM, two minds, the second blind; `plans/FS116-Z1-close.md` § 2.1)

hunch: the-room-is-on-q-rings
  claim: every four-colour vertex that has a valid fragment on the closed disc of radius `√3` about it has a (Q) arc on its ring; a (Q)-free ring dies by
    `√3`, as N7-HUB's hexagon reaches its second shell (0.55)
  basis: analogy
  falsifier: a valid fragment by formula on the closed disc of radius `√3` about a four-colour vertex whose ring carries no (Q) arc
  registered: 2026-09-28
  status: open

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
  status: confirmed (by: derivation — FS116-RING-GERM, held, in its form: a change point whose `±60°` germs lie off (Q) arcs is a vertex of at least four colours; FS116-N3-SEMI, held, at semi-hubs, SEMI-PAR3 the exception, GAP; `plans/FS116-Z1-close.md` § 2.1)

hunch: curved-ladders-end-on-q-rings
  claim: in a cusp-free honestly saturated six-map, every curved interface descends its ladder of unit parallels to a unit arc (FS111-M2-INTRAD, "stop
    at 1") whose centre carries both colours (FS111-M-PINCH), and that centre is a vertex of at least four colours (FS112-N3-NOBOTH, with FS111-W-NOREP
    removing the repeated colour), so the last rung is a (Q) arc — FS-116's ring (0.7)
  basis: derived
  falsifier: a cusp-free honestly saturated fragment by formula with a curved interface whose ladder's last rung is a unit arc about a point of at most
    three colours
  registered: 2026-09-29
  status: killed (by: derivation — FS121-O1-ENDS, held: the ladder may end at an (R2) arc, a tangent-type unit arc, which my composition read as M-PINCH's split case; FS121-O1-CARD, GAP at the (R2) branch; the claim survives only as a consequence of FS-126's NO, FS121-Z1-NOCURVED)

Registered today, before the re-read:

hunch: fs116-closed-undecided
  claim: FS-116's close lands neither C114-LOCAL-F's NO at a uniform radius nor a valid fragment at every radius; its held residue is stated by ring class (0.85)
  basis: prior
  falsifier: `plans/FS116-Z2-close.md`'s headline reading the NO or the YES landed
  registered: 2026-10-03
  status: confirmed (by: derivation — the reconciliation of FS-116's verdicts, `plans/FS116-Z1-close.md` § 2.1, "No top claim landed"; headline `plans/FS116-Z2-close.md` § 4.1)

hunch: fs121-closed-undecided
  claim: FS-121's close lands neither REG-A₆ nor a tight six-colouring with no map; NO-PAR and ¬LRA stay open (0.85)
  basis: prior
  falsifier: `plans/FS121-Z1-close.md`'s headline reading REG-A₆ or its failure landed
  registered: 2026-10-03
  status: confirmed (by: derivation — the reconciliation of FS-121's verdicts, `plans/FS121-Z1-close.md` § 2.1, "No top claim landed: every claim of §§ 2–4 and 7.1 beyond the four the opening proved is GAP at a named step")

hunch: closes-nominate-themselves-again
  claim: each close's drafted "Next:" names a stub it minted (FS-123 to FS-128) (0.6)
  basis: prior
  falsifier: either close's drafted "Next:" naming a stub it did not mint
  registered: 2026-10-03
  status: killed (by: `plans/FS116-Z2-close.md` D2 unit 2, "**Next:** Poros's re-rank"; `plans/FS121-Z1-close.md` D2, which drafts no "Next:")

hunch: identity-is-three-step-closure
  claim: V6-HUG's identity is the instance `u = e(s)`, `v = −1`, `w = e(−t)` (in the frame `y_1 − y_0 = 1`) of the classical factorization, for unit
    complex numbers, `|u + v + w|² − 1 = (u + v)(v + w)(w + u)/(uvw)`; so it governs every pair of points joined by a path of three unit steps, and a pair
    of same-colour tiles pinned to the unit circles about the two ends of a unit-distance pair is the case where the middle step is that pair (0.9)
  basis: derived
  falsifier: a numerical counterexample to the factorization, or V6's parametrization not reducing to it
  registered: 2026-10-03
  status: open

hunch: rank-one-is-the-ring-residue
  claim: by bearing on the answer, my draft's rank 1 is the stub that carries FS-116's open ring class, ahead of FS-121's successor (0.55)
  basis: prior
  falsifier: my own stage-3 table with an FS-121 successor, FS-122 or FS-104 at rank 1
  registered: 2026-10-03
  status: open

### 1.5 The question, so far

*At stage 1 the honest exit stood ("no question: the re-read has not been made"; commit d39a7805). Stage 2 replaces it with the cards in § 2.5.*

## Stage 1 — SAVED

## Stage 2 — SAVED

*The re-read, by `poros-anomaly-hunt` (invoked fresh). Every item of § 1.3 was read against the expectation written at stage 1 (commit d39a7805);
the results are filled in place there, each with its address. One item was added where an anomaly pointed (FS-114's NB6 and NB5, side 1's sources).
Read in full: `plans/FS121-Z1-close.md`; `plans/FS116-Z1-close.md`; `plans/FS116-Z2-close.md` §§ 1.3–4.1, D2, D3, D9, D10; the six new stubs and
FS-129's; FS116-Y4 §§ 3.1–3.4; V6 §§ 2.2–2.4. Read by entry or line: the derivation entries named in § 1.3; `plans/FRONTIER-STUBS.md` ll. 1–153;
the bearing lines in `plans/STUB-{stuck-ray,pinch-at-junction,forced-pair,route-t-count}.md`; both inventories by grep. Not read: the job records
under the closes (N1–N3, S1, Y1–Y3, V1–V5; D1–D4, C1, V2–V5), whose numbers the closes quote; the closes' § B drafts.*

### 2.1 The expectations, scored (Brier on the binary outcome)

| expectation | p | outcome | Brier | address |
|---|---|---|---|---|
| E1 — FS-116 undecided; the Γ-free type removed, (Q) rings open, (R2)-arc rings the bends' exception | 0.85 | met | 0.023 | `plans/FS116-Z2-close.md` § 4.1 |
| E2 — FS-121 undecided; three open claims one question (FS-126); NO-PAR, ¬LRA open | 0.80 | met | 0.040 | `plans/FS121-Z1-close.md` §§ 2.5–2.6 |
| E3 — each close's "Next:" names a stub it minted | 0.60 | not met: FS-116's draft reads "**Next:** Poros's re-rank"; FS-121's drafts no "Next:" | 0.360 | Z2 D2 unit 2; Z1 D2 |
| E4 — a result stands without its mechanism | 0.60 | met: V6-HUG's identity (Kooshi asked what it is), FS116-N1-QDISK's `≈ 1.5985`, FS116-Y2-SIXFRAG's `3/2` | 0.160 | § 2.3 C5 |
| E5 — the bends signal unresolved and routed | 0.70 | met (FS-123, question 1) | 0.090 | Z2 § 1.5 |
| E6 — the identity is the straddle's exact form; (R2)-arc rings rank first | 0.50 | not met as stated: the identity is wider than the straddle, and the (R2)-arc rank is conditional on card 1 | 0.250 | § 2.3 C5; § 2.5 card 2 |
| E7 — my FS-121 card answered with a failing link | 0.55 | met: GAP at the (R2) branch | 0.203 | `plans/FS121-derivation.md` FS121-O1-CARD |
| E8 — my card `what-do-q-rings-force` not answered | 0.70 | not met: answered in RING-GERM's and SEMI's form, both held | 0.490 | Z1 § 2.1 round 1, round 4 |
| E9 — my rank 1 is the ring residue's stub | 0.55 | scored at stage 3 | — | — |
| E10 — no value moved, no posed question answered | 0.90 | met | 0.010 | Z1 § 2.6 item 1; Z2 § 4.1; Z1 D7 |

Nine scored: six met, three not; Brier 0.181. The two worst misses (E8, E3) were both about what other minds would do with my own cards and drafts:
I under-predicted how far FS-116's proof side would carry `what-do-q-rings-force`, and over-predicted that a close drafts its own successor.

### 2.2 The hunch ledger, scored (statuses rewritten in place in § 1.4; stage 1's are in commit d39a7805)

- `fragments-at-every-radius-give-six` → **confirmed** by FS116-O1-YESLIM, two minds, the second blind (Z1 § 2.1).
- `q-rings-force-a-pattern` → **confirmed** in RING-GERM's form: "a change point whose `±60°` germs lie off (Q) arcs is a vertex of at least four
  colours" (FS116-RING-GERM, held). At semi-hubs the pattern holds except SEMI-PAR3 (FS116-N3-SEMI, held; SEMI-PAR3 GAP).
- `curved-ladders-end-on-q-rings` → **killed as derived**. My composition read the ladder's last rung as M-PINCH's first case, a unit arc whose centre
  carries both colours. It can be the second case, a tangent-type unit arc: FS121-O1-ENDS (held) ends the ladder at "(Q) … or … (R2)". The claim
  itself survives as a consequence of FS-126's NO (FS121-Z1-NOCURVED: "every curved interface is a split unit arc of kind both"). It is re-registered
  below as `curved-tangent-inhabited-above-six`'s negation, with a new basis.
- `the-room-is-on-q-rings` → **open**, half settled. Its Γ-free part is FS116-Y4-EMPTY (held). Its (R2)-arc part is FS-123's.
- `saturation-pins-the-four-colour-vertex` → **open**, half settled. The pin is FS116-O1-SATPIN, held in corrected wording ("at least one of", not
  "exactly one of"). The strip's midline dying in the class is SAT-STRIP's G1 (the strip's midline ring carries four (Q) arcs), GAP, now FS-125's.
- `kills-are-not-band-stable` → **open**. A datum, not a verdict: FS116-Z2 reads EMPTY's margin as "a deficit of order `st` in the angular lengths"
  (`plans/STUB-forced-pair.md` l. 42, one mind, untested at a band).
- `local-f-overshoots` → **open**, sting removed. YESLIM (held) makes C114-LOCAL-F's failure `χ(ℝ²) ≤ 6`, so the uniform radius never overshoots the
  answer. Whether it can fail while no valid *map* exists is still open (YESLIM's limit is measurable, "the map structure idle").
- `route-m-consumes-unbounded-maps` → **open**, and no longer bearing on any form (YESLIM decided FS-116's form without it).
- Stage 1's five (`fs116-closed-undecided`, `fs121-closed-undecided`, `closes-nominate-themselves-again`, `identity-is-three-step-closure`,
  `rank-one-is-the-ring-residue`): the first two **confirmed** by their addresses; the third **killed** (E3); the fourth **open** — the control below
  checks it numerically and does not derive it; the fifth scored at stage 3.

Registered now, before any answer to the cards below:

hunch: bends-keep-the-class
  claim: bending a valid fragment on a neighbourhood of `B̄(p, 1 + ε)` by FS-112's moves keeps it valid, non-Siamese, simple and with `p` of at least
    four colours, so every ring in C114-LOCAL-F's non-Siamese simple class is, after it, its (Q) arcs plus finitely many points (0.6)
  basis: analogy
  falsifier: a non-Siamese simple valid fragment about a four-colour vertex whose bend on a neighbourhood of `B̄(p, 1 + ε)` creates a Siamese pair or a
    non-simple tile, changes `p`'s colours, or cannot be run
  registered: 2026-10-03
  status: open

hunch: qfree-class-is-empty
  claim: no non-Siamese simple valid six-coloured fragment on a disc of radius above 1 about a vertex of at least four colours has a ring carrying no
    (Q) arc (0.65)
  basis: analogy
  falsifier: such a fragment by formula, with an exact check whose planted fault fires
  registered: 2026-10-03
  status: open

hunch: curved-tangent-inhabited-above-six
  claim: at some `k ≥ 7` an honest saturated REG-J′ colouring of the plane has a curved tangent-type interface arc of finite radius (0.4)
  basis: prior
  falsifier: a derivation that at every `k` such colourings have only segments and split unit arcs
  registered: 2026-10-03
  status: open

### 2.3 What is curious, and the pattern that would make it a matter of course

**C1 — The bends question is not the (Q)-free half's. It is the first question of the whole remaining case list.** FS-123's stub poses it for
(Q)-free rings, and Z2 § 1.5 quotes side 1 so. But side 1's source states it for every ring. `plans/FS114-NB6-verification.md` ll. 106–108: "**Bends
on a fragment:** run on a fragment on a neighbourhood of `B̄(p, 1 + ε)`, N2-AWAY sees no radius-2 witness, so every ring arc but the (Q) arcs is
removed (…); "after the bends" then costs no radius, and the ring of a fragment bent so is `Γ`-arc-free off its (Q) arcs." The sentence names no ring
type, and the frozen definition of (R2) explains why it can be general: (R2) is "an arc whose centre carries the outer side colour and not the inner,
with an inner-colour tile along the radius-2 circle over the whole arc" (`data/fs116/claims.md` § 0). On a fragment that reads only `B̄(p, 1 + ε)`, that
witness lies outside. FS-124's cases also carry change points that end non-(Q) arcs. RING-GERM's hypothesis ("germs off (Q) arcs") and FS116-S1-KAPPA
("the tool for rings carrying non-(Q) arcs of `Γ`", FS-123's stub) both live on rings that carry such arcs. So a yes empties FS-123's question 2 and
also deletes a whole kind of change point from FS-124.

**And the two sides stand one line apart in one record, as compatible facts.** NB6 l. 104 states side 2, "After the bends every `Γ`-arc of the ring is
(Q) or (R2) (N5-BENDG, two minds, one blind: N5; NB5)", then side 1 two lines later, about a different domain. The pattern that makes this a matter of
course is that "after the bends" depends on the domain the bends run on: a map keeps (R2) arcs because their radius-2 witness is visible, and a fragment
cut at `1 + ε` does not. So the premise both sides share is that a vertex has one ring type. The record treats ring type as a property of the vertex,
when it is a property of the vertex and the domain. What is open is one lemma: whether FS-112's moves, run on a fragment, keep the class EMPTY quantifies
over (non-Siamese, simple, four colours at `p`). Z2's own reading says "the two sides are about different objects", so I agree with Z2 and add the
reach. **A related whiff:** NB6 ll. 109–111 record "Two readings of "(Q)"". N6's statements use FS-112's (Q). The instance's gloss, "a boundary arc along
`ω(p)` whose outer colour is carried at `p`", "also counts (R2) arcs". Under the gloss, a "(Q)-free" ring after the map bends is Γ-free, and EMPTY
applies to it directly. NB6 says "Every verdict below holds under both readings". FS-123 must fix FS-112's reading in its definitions before it states
anything about "(Q)-free".

**C2 — Every open class in both closes has no held inhabitant.** FS-116 worked one class that turned out empty: "twenty-one entries derived about the
Γ-free four-colour vertex … are true vacuously" (Z2 D3, the G21 instance). The rest of the (Q)-free half has never had an inhabitant either. Its one
cited model, FS114-Y2-BOWTIE in N7-3T's model line, carries two (Q) arcs on its ring (Z1 § 2.4 F1: "its caps are (Q) arcs, FS114-N7-3T's model line is
wrong"). FS-121's open class is the same shape: "no curved tangent interface is held at any `k`" (Z1 D1, ‹R121-a›), and every lemma of FS121-D1
(PENCILWIN, DOUBLE, VT, EROSION) is about it. FS-127's open case is "an honest saturated colouring at some `k ≥ 7`, by formula, with such an
accumulation", also uninhabited. The pattern that makes this a matter of course is that a milestone's proof side keeps working while its open steps sit
on classes nobody has inhabited. A GAP on an uninhabited class may be a GAP on an empty one. G91's drafted *Do* already says it ("before building on a
ring type's structure lemmas, ask whether the type is inhabited"). FS-123's and FS-127's stubs order their questions so. FS-126's stub puts the open
step first and its construction target second (card 3).

**C3 — The (R2) arc is one object in two milestones, and neither stub says so.** FS121-Z1-NOCURVED (one mind): if no honest saturated REG-J′ colouring
has a tangent-type interface arc of finite radius at least 2, "then in every such colouring no (R2) arc occurs". The (R2) witness is the tangent
partner. An (R2) unit arc's outward unit parallel is a tangent arc of radius 2 (FS121-O1-OUT, held), and that parallel is the "inner-colour tile along
the radius-2 circle" the definition asks for. So in the class route M consumes, FS-126's NO deletes the (R2) arcs that FS-123's question 2 is about.
FS-123's Q1 would delete them on fragments of every valid map. Two independent routes reach one simplification. FS-125's case list (the saturated
class) is the place both meet: given FS-126's NO, its rings carry (Q) arcs only. Neither FS-123's nor FS-126's nor FS-125's stub records the joint.

**C4 — The two closes' calibrations miss in opposite directions.** FS-121's own registrations went "0 of 8 as asked; every miss lay in the direction of
a theorem landing" (Z1 § 4.5), with my 0.7 the costliest. FS-116's verifiers missed the other way: "where the verifiers' probabilities were low, the
statements held" (Z2 § 2.5). Z2 calls its direction "the same direction `CLAUDE.md` § Counter-priors measured". FS-121's is the opposite. Both are a
matter of course if calibration splits by kind: registrations on whether an open target lands run high, and registrations on whether a written
derivation survives run low. This is a finding for counter-priors rule 2's instrument, not mathematics, and not an invention signal.

**C5 — A result standing without its mechanism, and the mechanism found: V6-HUG's identity is classical.** Rotate V6's frame so `y_1 − y_0 = 1`. Then
`a(s) − b(t) = e(s) + (−1) + e(−t)`, a sum of three unit vectors. For unit complex numbers, `(u + v)(v + w)(w + u) = (u + v + w)(uv + vw + wu) − uvw`,
and dividing by `uvw` gives `|u + v + w|² − 1 = (u + v)(v + w)(w + u)/(uvw) = 8 cos((α − β)/2) cos((β − γ)/2) cos((γ − α)/2)` with `u = e(α)` and so on.
V6's form is the case `α = s`, `β = 180°`, `γ = −t`. The control `data/workflow3/r2/identity_check.py` checks the factorization on 20,000 random
triples (worst residual 1.5·10⁻¹⁴) and V6-HUG's and V6-ADJ's forms on a 61 × 61 grid. Its `--plant` (a wrong half-angle) exits 1, run at this stage.
Geometrically, `a(s)` runs along `ω(y_0)` from `y_1` and `b(t)` along `ω(y_1)` from `y_0`, both toward `p`, so they trace two sides of the unit
Reuleaux triangle on `p, y_0, y_1`. The identity is that triangle's constant width: points on two sides through one apex are less than 1 apart except
at the far vertices. The distance is exactly 1 only where two of the three unit steps cancel (`s = 0`, `t = 0` or `s + t = 180°`). V6-ADJ is the same
law on the vesica's other Reuleaux triangle: its two arcs meet at `p′ = y_0 + e(60°)` when `s = t = 60°`, the point where they began at `p` in HUG.
Y4-FLANK's least-curved case, `(2 cos φ − 1)²`, is the diagonal `s = t`. This is a reading, one mind, with a numerical control; the factorization is
"recalled, not read" from the literature. Where it can be used is card 2.

**C6 — A path nobody took: TOP₆ as coverage.** FS-121's §G found that G13 (the fan ladder: "coverage is a k-set property invisible to pair sweeps")
"should have borne and was not used": "TOP₆ (binding the top colour) is a coverage question about the circles of the top colour's boundary points.
D3's three attempts (§§ 3.2–3.4) worked by moves and selections and never asked the coverage question G13 names" (Z1 § 4.1). FS-116's §G found G13
"paid, unnamed" in V6-TIP's confinement (Z2 § 2.1). So G13 did work in one milestone without being cited, and was never asked in the other. FS-128's
stub lists G13 among its provisional bearings but no question uses it (card 4).

**Which result stands without its mechanism, beyond C5.** FS116-N1-QDISK's `≈ 1.5985`, the radius below which RING-Q is false at the disk's corner
([tools], one mind), and FS116-Y2-SIXFRAG's `3/2`, held by a fragment about a six-colour vertex (exact, one mind). Both are measured reaches of
single objects, like FS-114's `φ²/√2`. Neither close says why that number.

**What path has nobody considered.** C1's reach, C3's joint and C6's coverage reading. All three are cheap readings whose answers change more than one
stub.

### 2.4 The named findings

**FS-121's item 89** ("three of FS-121's open claims are one question (FS-126); the structural form named the right objects and the wrong invariant").
I agree with both halves. The merge is FS121-Z1-NOCURVED's composition (one mind), and its hypothesis is FS-126's question. The structural form I
wrote asked "what does every end carry that bounds how many ends meet a bounded set". The ends were the right objects, and every end is (Q) or (R2),
held. A count was the wrong invariant: TINY16 makes per-region counts idle, and ¬LRA is thin pencils, not a number of ends (Z1 § 2.5). The invariant
FS-121 found is FS121-D4-FACE's, lateral extent against gap. It is the unit circle's sagitta: a piece of half-width `ρ` facing across `g` with
`2g < ρ²`. This is the same second-order shape as C5's margin `8 sin(s/2) sin(t/2) cos((s + t)/2) ≈ 2st`. FS-116's decisive kill and FS-121's decisive
regularity lemma both spend the unit circle's curvature at second order. That is a reading, offered to FS-129 as an index entry (§ 2.6). Is FS-126 the
right question? Yes, with one change of order: inhabitant first (card 3).

**FS-116's items 136 and 145, the bends signal.** C1 above: I pick no side. Both sides are on record and can both hold, about two domains. The premise
they share is that a vertex has one ring type. The open lemma is class preservation under fragment bends. Its reach is every ring, so it is card 1,
and it is the first question of FS-123 *and* the precondition of FS-124's case list. Whether FS116-Y4-EMPTY reaches FS114-N7-3T's whole class turns on
that lemma, as the brief says. If it holds, EMPTY reaches the whole class and also deletes (R2)-ended change points from the (Q) rings. If it fails,
the (R2)-arc rings are the next case, and card 2 ranks the identity's use there.

**Kooshi's question, *where else can we use that identity?*** Card 2, with its ranking.

### 2.5 The cards

question: does-a-fragment-bend-keep-the-class
  evidence: `plans/FS114-NB6-verification.md` ll. 104–108 states both sides one line apart as compatible facts about two domains, and side 1 names no
    ring type ("every ring arc but the (Q) arcs is removed"); the (R2) definition's radius-2 witness lies outside `B̄(p, 1 + ε)` (`data/fs116/claims.md`
    § 0); FS116-Y4-EMPTY (held) "reads radius 1" (`plans/FS116-V6-verification.md` § 2.2); FS-124's change points may end non-(Q) arcs (RING-GERM's
    hypothesis; FS116-S1-KAPPA)
  expected: that the bends question was the (Q)-free half's alone, as `plans/STUB-qfree-ring.md` question 1 poses it
  ask: Does bending a valid fragment on a neighbourhood of `B̄(p, 1 + ε)` by FS-112's moves keep it valid, non-Siamese, simple and four-coloured at `p` — so that every ring in C114-LOCAL-F's class is its (Q) arcs plus finitely many points?
  if it does: FS116-Y4-EMPTY closes every (Q)-free ring at `1 + ε` (N7-3T's, N7-HUB's, N6-RING60's classes are empty there, OC with them); FS-124's case list loses every change point that ends a non-(Q) arc; FS-123's question 2 is moot and its question 3 (Siamese) is next
  if it does not: the class condition the bend breaks is named, and the (R2)-arc rings are FS-123's main case, where card 2's ranking applies; FS-124 keeps (R2) arcs on (Q) rings as a case of its own
  answered by: derivation — Ephodos, FS-123's opening, as its first question, with FS112-N2-RED's moves (W-MERGE, whole-arc bends) and N2-AWAY read on a fragment
  cost: one derivation, under a round
  hunch: it does (`bends-keep-the-class`, 0.6); the record has never held an inhabitant of the (Q)-free class (`qfree-class-is-empty`, 0.65)
  falsifier: a non-Siamese simple valid fragment about a four-colour vertex whose fragment bend creates a Siamese pair or a non-simple tile, or changes `p`'s colours
  rank: 1

question: where-else-the-identity
  evidence: V6-HUG's identity (`plans/FS116-V6-verification.md` l. 159) is `|u + v + w|² − 1 = (u + v)(v + w)(w + u)/(uvw)` at `u = e(s)`, `v = −1`,
    `w = e(−t)` — the constant width of the unit Reuleaux triangle on a unit pair, with exactly-1 only where two steps cancel (control
    `data/workflow3/r2/identity_check.py`, PASS, plant fires); V6-ADJ (§ 2.3 item 2) is the same law on the vesica's other Reuleaux triangle; FS116-Y4
    § 3.4 names three neighbours, "each unread"; V6 notes "Validity alone kills it here" (§ 2.2)
  expected: an identity special to EMPTY's double tip
  ask: In C114-LOCAL-F's open cases, where are two tiles of one colour pinned, from outside, to the two sides through one apex of a unit Reuleaux triangle on a unit pair — and which case does each exclusion remove?
  if the shared-tip semi-hub qualifies: the exclusion narrows the placing rule's only exception (SEMI-PAR3) in FS-124 case 1, and FS-124's proof side runs the identity there first
  if only (Q)-free configurations qualify: the identity serves FS-123's (R2)-arc rings and OC, and only if card 1's answer is no
  if none qualifies outside EMPTY's class: the identity's reach in FS-116's cases is EMPTY's alone; it goes to FS-129 as an index entry (unit pairs, Reuleaux sides), with FS-122's band datum
  answered by: derivation — Ephodos, at FS-124's and FS-123's openings; or FS-129's opening as its pilot entry
  cost: a reading round per configuration; each use must fail on the controls (the strip at `φ²/√2`, the disk at `φ` with RING-Q false below `≈ 1.5985`, SIXFRAG below `3/2`, the bowtie at `3√3/5`, R7 at seven colours)
  hunch: the shared-tip semi-hub qualifies (0.5)
  falsifier: a reading of the shared-tip configuration in which the two flank tiles' colours are forced to differ, as with three absent colours
  rank: 2

**Card 2's ranking**: the four named configurations, by what an exclusion there would remove from C114-LOCAL-F's case list
(`plans/FS116-Z1-close.md` § 2.6). The unit pairs in a ring picture are `{p, y}` for every ring point `y`, and `{y, σy}` for ring points `60°` apart.
Every one of them carries two Reuleaux triangles.

| rank | configuration (address) | the unit pair | what an exclusion would remove | condition |
|---|---|---|---|---|
| 1 | a semi-hub whose tip is shared with the next change point (Y4 § 3.4, neighbour 2) | `{y, σy}` on a (Q) ring | a sub-case of the placing rule on (Q) rings; if it reaches the full parallel semi-hub of three colours, SEMI-PAR3, the rule's only exception, and with it four-colour vertices propagate at every semi-hub (FS-124 cases 1, 5) | unconditional: (Q) rings are the bulk and the YES side's home (row 136) |
| 2 | (Q)-free rings carrying (R2) arcs, and OC (Y4 § 3.4, neighbours 1 and 3) | `{y, σy}` at a double tip; `{p, y}` at an (R2) arc's end | the whole (Q)-free remainder (FS-123 questions 2) | moot if card 1 answers yes; moot in the saturated class given FS-126's NO (FS121-Z1-NOCURVED, C3) |
| 3 | outer tiles of one colour at adjacent hubs, each hugging the lens arc beyond its hub (V6-ADJ, V6 § 2.3 item 2) | `{y, σy}`, the vesica's outer Reuleaux triangle | no case alone; it prunes the recurrence's outer colours (V6: "why a construction needs five-colour hubs") on (Q) rings with adjacent placed hubs (FS-124 case 5) | unconditional, but a pruning, not a removal |
| 4 | the five- and six-colour vertices (FS116-N2-FIVERING, -SIXRING) | `{p, y}` at (Q)-arc ends `60°` apart | FS-124 case 4, in part | untested; SIXFRAG (exact, every disc below `3/2`) is the control any use must fail on |

Outside the case list, the identity bears on route R through its margin. The deficit is `8 sin(s/2) sin(t/2) cos((s + t)/2) ≈ 2st`, second order in
the hug lengths, so a kill by it survives a band of slack `ε` only if the hug lengths are of order `√ε` or more. This is FS-122's carried card's
question, and Z2 filed it there as a datum (`plans/STUB-forced-pair.md` l. 42).

question: is-the-curved-tangent-class-inhabited
  evidence: `plans/STUB-curved-pencils.md` § The question: "No held colouring does: R7 has only split unit arcs; SQ9 and HEX9 only segments"; FS121-Z1
    § 2.6 item 4 names "a curved tangent-type interface in an honest saturated colouring at some `k ≥ 7`, given by formula" as the fact that would change
    its confidence; three open claims (C121-R2-FOUR, -CURVED, -NOLRA) and FS121-D1's lemmas sit on this class; FS-116 worked an empty class for two
    rounds (Z2 D3, G21 instance)
  expected: that FS-126 opens on its open step (the transverse subdivision), as its stub's structural form and D1's suggestion order it
  ask: At some `k ≥ 7`, is there an honest saturated REG-J′ colouring of the plane with a curved tangent-type interface, given by formula — or an obstruction at every `k`?
  if one is built: the honest route cannot take its map step colour-blind; C121-NOLRA and C121-R2-FOUR become separate questions; route M's honest branch is six-specific at REG-A₆ and FS-128 carries it; FS-126's lemmas describe a real class
  if an obstruction: FS-126's NO at every `k`, cusps allowed, gives by FS121-Z1-NOCURVED no (R2) arc in route M's maps and ¬LRA; the honest branch's open rungs are REG-J′ (FS-127) and TOP₆ (FS-128), and C3's joint deletes (R2) arcs from FS-125's case list
  answered by: derivation — Ephodos, FS-126's opening, construction side first, with FS121-D1's lemmas (PENCILWIN, DOUBLE, VT) as the constraints an inhabitant must meet
  cost: one round
  hunch: an inhabitant exists at large `k` (`curved-tangent-inhabited-above-six`, 0.4)
  falsifier: a derivation that at every `k` honest saturated REG-J′ colourings have only segments and split unit arcs
  rank: 3

question: is-top-six-a-coverage-question
  evidence: `plans/FS121-Z1-close.md` § 4.1: G13 "should have borne and was not used"; "TOP₆ (binding the top colour) is a coverage question about the
    circles of the top colour's boundary points. D3's three attempts (§§ 3.2–3.4) worked by moves and selections and never asked the coverage question G13
    names"; `plans/FS116-Z2-close.md` § 2.1: G13 "paid, unnamed" in FS116-V6-TIP; FS121-O1-ABOVE7 (one mind): at `k = 7` the tight hexagonal colouring
    lies below no honest saturated one, so binding the top colour must spend six
  expected: that TOP₆'s three stalls (variational, idomatic, re-maximising) had exhausted its routes
  ask: In a Grundy six-colouring, is the top colour's binding at a boundary point the failure of a coverage — that point's unit circle covered by the five lower colours — so that G13's fan ladder at level five decides TOP₆?
  if it is: FS-128 opens on coverage at the top colour's boundary circles, with the kernel's `fan_iff_coverage` as the finite model, and TOP₆ gets a named step smaller than C121-SAT6
  if it is not: the step where coverage cannot spend six is named; TOP₆ stays the answer restated given NO-SAT, and FS-128's cover-route rung (NOPAR-C5) is its only smaller question
  answered by: derivation — Ephodos, FS-128's opening, reading FS121-D3 §§ 3.2–3.4 against G13
  cost: under a round
  rank: 4

*Four cards for four openings. The gate warns above three.*

### 2.6 What this does to the ranking (for stage 3)

- **FS-123 leads, by bearing.** Its first question (card 1) decides the shape of the whole remaining NO: FS-123's half outright, and a kind of change
  point in FS-124. FS-124 is second. It is the bulk and the YES side's home, and a necessary piece of C114-LOCAL-F like FS-123. Both are necessary for
  seven, and each piece's failure is `χ(ℝ²) ≤ 6` with no MR (YESLIM: fragments at every radius in either class give it).
- **FS-125 below FS-104.** NO-SAT is necessary for seven and its failure is also `χ(ℝ²) ≤ 6`. But it is weaker than the pair's NO, and serves route M
  only with TOP₆. FS-104 is decisive one way (`χ(ℝ²) = 5`) and gives a new lower bound the other way. R1 placed FS-104 directly below route M's halves,
  and nothing here moves it.
- **FS-122, then FS-128.** Both are the answer restated (route R's A-ALL; TOP₆ given NO-SAT). FS-122 keeps its place, with Z2's band datum. FS-128 is
  new, "at six, and next to the answer", with card 4.
- **FS-126, FS-127, FS-120: the colour-generic rungs, none alone.** FS-120's pinch now bears on FS-127 ("a pinch no move removes would be FS-127's
  counterexample"), so it follows it.
- **FS-115 is demoted.** Its live bearing, ¬LRA, moved into FS-126 at FS-121's close: "this stub's measurable question is thin pencils in aperiodic
  colourings, and it lives inside FS-126 … the line form is not needed" (`plans/STUB-stuck-ray.md` l. 60). What remains, (b′), (b″) and (c), bears only on
  GS-4's density form, which the NO does not need (row 137). It takes a banner.
- **FS-117 stays a sibling,** below the colour-generic rungs. Its (Q)-free case turns on card 1.
- **FS-129 is unranked** (Kooshi's special case). For its opening, three index entries came out of this re-read: unit pairs and their Reuleaux
  triangles (C5); the unit circle's second-order contact (§ 2.4: FLANK, HUG, FACE); and the (R2) arc as one object in two milestones (C3).

Invention signal: one whiff examined, the bends (FS-116 items 136, 145). Both sides are quoted in C1 with their addresses, and I add a third address
where they stand together (`plans/FS114-NB6-verification.md` ll. 104–108) and a related whiff (NB6 ll. 109–111, two readings of "(Q)"). No side is
picked. The premise both sides share is that a vertex has one ring type whatever domain the bends run on. Its reach is every ring, not only (Q)-free
ones. Read for it, beyond that: both closes in full, the six new stubs, FS-129's, Y4 §§ 3.1–3.4, V6 §§ 2.2–2.4, FS121-O1-OUT, -ENDS, -CARD, -ABOVE7,
FS121-D2-INCURVED and FS121-Z1-NOCURVED; FS116-N3-SEMI, -SEMI-PAR3, -RING-GERM and -N2-FIVERING. Classed and not a collision: FS121-O1-ABOVE7
against FS121-D3-GRUNDY (one is about containing a colouring's classes, the other about recolouring without raising an index); C4's opposite
calibrations (not mathematics).

### 2.7 Findings for Keryx (not mine to edit)

- **The brief predates O7.** The brief says the ban "ended 2026-10-01, and Kooshi has not extended it". `plans/FS116-close-inventory.md` O7 (Kooshi,
  18:30 UTC, after the brief) reads: "I want to know how it affected our approach before we remove it outright. I'm thinking of restricting search to a
  wallclock budget per day and per week." Stage 3's solver notes read the column as of now: the dates have passed, the ban is not deleted, and a
  wallclock budget is pending (CL3, the workflow refinement).
- **Two rows of the ranked table carry unescaped pipes** inside a cell (`plans/FRONTIER-STUBS.md` l. 108, FS-65's `|Aut|`; l. 134, FS-41's `|S|`). My
  stage-3 table escapes them, and the assembler lists the two amendments.
- **FS-123's stub should fix "(Q)" in FS-112's reading** before it states anything about "(Q)-free" (C1's related whiff, NB6 ll. 109–111).
- **The joint in C3 belongs in three stubs' bearings** (FS-123, FS-125, FS-126). I draft the lines in stage 3, since a stub's bearing on the answer is
  mine to write at a re-rank only where the brief names the stub. Keryx files them or not.

### Would-have-searched-here log (stage 2)

None. The one script, `data/workflow3/r2/identity_check.py`, evaluates a closed-form identity at fixed and pseudo-random points. It searches nothing.

## Stage 2 — SAVED

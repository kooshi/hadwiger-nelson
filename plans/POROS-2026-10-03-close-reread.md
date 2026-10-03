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

### 1.3 Evidence inventory (by provenance; each expectation written before the item was opened at stage 2)

- `plans/FS116-Z2-close.md`, the headline, the sweeps and § Drafts for the front page — read against: E1's undecided headline narrowed by class; a drafted "Next:" naming FS-123 or FS-124 (E3) — surprised: unread
- `plans/FS116-Z1-close.md`, the reconciliation and the headline's draft — read against: every frozen claim with a verdict and a mind count; at least one MISSTATED claim corrected (as SATPIN and RING-TWIST were); the headline drafted narrower than Z2's — surprised: unread
- `plans/FS121-Z1-close.md`, with § 2.5 (FS-126) and D10 (the drafted row) — read against: E2; "the structural form named the right objects and the wrong invariant" pointing at my structural form (ladder ends) and naming the invariant it should have asked — surprised: unread
- `plans/FS121-derivation.md` and `plans/FS116-derivation.md`, by entry, where the hunt points — read against: each held entry's grade matching the close's headline; no entry promoted above its mind count — surprised: unread
- The six new stubs, FS-123 to FS-128 — read against: each with a bearing line against § The aim, at least two of them "none alone"; FS-123 carrying the bends question first (the brief) — surprised: unread
- The open stubs whose bearing lines the closes rewrote (FS-122, FS-120, FS-115, FS-117 expected) — read against: bearings changed only where a close result touches them — surprised: unread
- `plans/FS121-close-inventory.md` and `plans/FS116-close-inventory.md` beyond item 36 — read against: the frictions logged; the two closes' held-for-Poros items (89, 136, 145, 142) as quoted in the brief — surprised: unread
- FS116-Y4 § 3.4 (three neighbours of its flank lemma) and V6 §§ 2.2–2.3 (HUG, ADJ) — read against: E6, the identity is the straddle's exact form and its neighbours are unit-pair configurations — surprised: unread
- `plans/STUB-cross-application-audit.md` (FS-129) — read against: an audit of where held lemmas apply beyond their first use, which Kooshi fixed after the filing — surprised: unread
- `plans/FRONTIER-STUBS.md`, the ranked table and its columns, and `CLAUDE.md` § Paths forward — read against: FS-116 at 1 and FS-121 at 2 as R1 filed; 69 open rows; a solver column to be read as of now — surprised: unread
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
  status: open

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
  status: open

hunch: curved-ladders-end-on-q-rings
  claim: in a cusp-free honestly saturated six-map, every curved interface descends its ladder of unit parallels to a unit arc (FS111-M2-INTRAD, "stop
    at 1") whose centre carries both colours (FS111-M-PINCH), and that centre is a vertex of at least four colours (FS112-N3-NOBOTH, with FS111-W-NOREP
    removing the repeated colour), so the last rung is a (Q) arc — FS-116's ring (0.7)
  basis: derived
  falsifier: a cusp-free honestly saturated fragment by formula with a curved interface whose ladder's last rung is a unit arc about a point of at most
    three colours
  registered: 2026-09-29
  status: open

Registered today, before the re-read:

hunch: fs116-closed-undecided
  claim: FS-116's close lands neither C114-LOCAL-F's NO at a uniform radius nor a valid fragment at every radius; its held residue is stated by ring class (0.85)
  basis: prior
  falsifier: `plans/FS116-Z2-close.md`'s headline reading the NO or the YES landed
  registered: 2026-10-03
  status: open

hunch: fs121-closed-undecided
  claim: FS-121's close lands neither REG-A₆ nor a tight six-colouring with no map; NO-PAR and ¬LRA stay open (0.85)
  basis: prior
  falsifier: `plans/FS121-Z1-close.md`'s headline reading REG-A₆ or its failure landed
  registered: 2026-10-03
  status: open

hunch: closes-nominate-themselves-again
  claim: each close's drafted "Next:" names a stub it minted (FS-123 to FS-128) (0.6)
  basis: prior
  falsifier: either close's drafted "Next:" naming a stub it did not mint
  registered: 2026-10-03
  status: open

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

no question: the re-read has not been made, so no surprise has an address yet
  need: stage 2 — the two closes' records read against E1–E10, then the named findings (FS-121 item 89; FS-116 items 136, 145) and Kooshi's question

## Stage 1 — SAVED

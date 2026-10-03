# FS-116 — the local exclusion: is there an explicit radius about a four-colour vertex within which no valid six-map fragment with unit arcs exists? (stub)

*Minted 2026-09-28 by the close job FS114-C at FS-114's close, on Kooshi's ruling (`plans/FS114-close-inventory.md` item 121: *"Understood. Let's close
up, then hand off to a completely fresh session with a note to check for keryx and be watchful of the new workflow in comparison to the old."*, read
by the coordinator, and accepted, as: FS-114 closes undecided and round 7's queue becomes its successor's opening). FS-114's successor; its sibling is
FS-117, route T's count (`plans/STUB-route-t-count.md`), which shares K1 with it. **Solver column: in-ban** — derivation, reading, and exact checks of
fragments given by formula; after 2026-10-01 still no finite-witness search (Kooshi: *"search for a finite graph is out. It would be huge, not
feasible."*); no program enumerates maps, colourings, cone sequences or tactic patterns (FS-114's owner ruling on a 5° grid, inventory item 115).
Written for a session with no memory of FS-114: read `CLAUDE.md` § The aim and § Counter-priors first, then `LEDGER.md` rows 133–138,
`plans/FS114-derivation.md` in full (46 entries; § 3 is this stub's ground), `plans/FS114-C-close.md` stage 2 (the reconciliation: every lemma's minds),
`data/fs114/claims.md` §0 (the definitions), and the records named below at the sections named.*

**Provisional bearings** (the opening's re-grokking replaces them; rewritten by Poros, FS116-P1, 2026-09-29):
- G83 — four-colour vertices; the (Q) rings are its named residue.
- G84 — contact: a (Q) arc is FS111-M-PINCH's first case, "a unit arc whose centre carries both colours", and saturation pins every interface by
  partners at distance 1.
- G85 — saturated interfaces have integer radii.
- G82 — a limit of near-colourings is a colouring; here, a limit of fragments on growing discs, card `the-yes-needs-no-map`.
- G86 — tile counts are blind to Siamese pairs: a Siamese kill reads points and distances.
- G72 — the structural form below.
- G79 — ask what every four-colour vertex's ring carries before excluding the next escape.
- G15 — count × local kill.
- G21 — a boundary claim needs a plant at the boundary (FS112-L60); and a held positive measures its own geometry: the strip is unsaturated at its
  midline (FS111-VM2-STRIP-MID).
- G87 — the invention signal.
- Rows 131 and 133–141.
- Stubs: FS-121 (route M's other half; its honest route hands this NO an honestly saturated map), FS-117, FS-115, and FS-122 (R1's band card,
  re-addressed there).

## The question, in plain language

Colour the plane with six colours so that no two points of one colour are exactly 1 apart, using a **valid map**: finitely many tiles per unit disc,
each bounded by segments and circular arcs, arcs of radius exactly 1 ("unit arcs") allowed, and no two interior points of one colour at distance 1. Row
134 excluded such maps without unit arcs; with them, FS-112 showed every valid map has a vertex where four colours meet, or one colour repeats, within 3
of every point, and **FS-114 showed that every valid map has a vertex where at least four colours meet** (FS114-CV-EXISTS, two minds blind to each
other). So one local statement suffices for the whole question — does a valid six-map with unit arcs exist?

> **C114-LOCAL-F.** Is there an explicit radius `R` and a derivation that no valid fragment exists on the closed disc of radius `R` about a vertex of at
> least four colours? *(`data/fs114/claims.md` §3, verbatim: "there are an explicit radius `R` and a derivation that no valid fragment exists on the
> closed disc of radius `R` about a vertex of at least four colours.")* Exclude every such fragment (the NO), or build such a fragment on every disc (its failure; a valid map of the plane is one way, not the only one — § Bearing on the answer).

A radius must exceed `φ²/√2 ≈ 1.8512`: the capped strip holds every smaller disc about a four-colour vertex (FS114-Y-DIAL, two minds).

## The question (Poros, 2026-09-29)

*Posed by Poros, job FS116-P1. The record is `plans/POROS-2026-09-28-fs116-question.md`: its § 2 holds the survey and all three of the opening's cards,
ranked; its § 1.5 and § 2.2 hold the hunches. Ephodos's §IQ quotes the two forms below verbatim.*

### The card

```
question: what-does-saturation-pin
  evidence: FS111-M2-REDUCE-A derives REG-A_k "in an honest saturated k-colouring" (plans/FS111-derivation.md); FS111-M-PINCH, three minds: every
    two-colour interface point of a saturated colouring lies on "a unit arc whose centre carries both colours" or a C^{1,1} curve "between two tangent
    unit discs" (LEDGER.md row 140); FS111-VM2-STRIP-MID: the capped strip is "not saturated on its midline", at the four straight edges of its
    four-colour vertices (data/fs114/fs114-y6/survey.out: tactic=0), the vertices about which it holds every disc below φ²/√2 (FS114-Y-DIAL)
  expected: that route M consumes FS-116's NO over every valid map, as this stub's bearing said
  ask: In an honestly saturated valid fragment — the class route M's honest branch must exclude — what does saturation force on the edges at a vertex
    of at least four colours?
  if every edge is pinned: the strip's midline configuration is outside the class; FS-116 poses its NO in the saturated class first (route M's need),
    keeps the all-maps form for Sokolov–Voronov's Question 2, and aims FS-114's straddle kills at the pinned vertices with 0–2 tactic edges
  if nothing new is pinned: saturation is a scope note for route M only; FS-116 keeps the all-maps class from its opening and starts from the
    record's card what-do-q-rings-force
  answered by: derivation — Ephodos, FS-116's proof side at its opening (FS-121's opening to be told the answer, since its honest route produces the class)
  cost: an hour to one round; M-PINCH, W-NOBEND and W-NOREP are held, and the step is to read them at a vertex of a map
  hunch: every edge is pinned, and the strip's midline dies (0.6)
  falsifier: an honestly saturated valid fragment by formula with a four-colour vertex one of whose edges has a side colour with no tile at
    distance exactly 1 from its points
  rank: 1
```

The opening's other two cards, from the record's § 2.4:
- **`the-yes-needs-no-map`** (rank 2, a check at the §IQ, under an hour): does a sequence of valid fragments on discs of unbounded radius, complexity
  unbounded, give a measurable six-colouring of the plane proper at almost every unit pair, by row 131's weak-* step? If it does, this question is
  decisive in both directions (§ Bearing on the answer).
- **`what-do-q-rings-force`** (rank 3, one round): at a four-colour vertex whose ring carries a (Q) arc, what does the ring force at distance 1, as
  N7-HUB does for (Q)-free rings? This is the structural form's first step.

### Existence form

**Is there a radius `R` — one `R` for every complexity, Siamese pairs allowed — such that no valid fragment exists on the closed disc of radius `R`
about a vertex of at least four colours?**

This is C114-LOCAL-F with its uniformity written in. The NO names `R` with a derivation, and any such `R` exceeds `φ²/√2 ≈ 1.8512` (FS114-Y-DIAL). The
alternative is a valid fragment about such a vertex on every disc, its complexity free. A valid map of the plane is one way to supply it, not the only
one. If the rank-1 card finds every edge pinned, the question is asked first for honestly saturated fragments: that is the class route M's honest
branch hands this NO (FS111-M2-REDUCE-A).

### Structural form

**In every valid fragment with any number `k ≥ 4` of colours, what does the unit circle about each vertex of at least four colours carry — its (Q)
arcs, its change points, and the vertices of at least four colours it places at distance 1 — and which of these ring types can recur at every such
vertex a ring places?**

*Why this is the structural form.* Its answer is the finite rule every fragment obeys at its four-colour vertices: a ring type, and which types a ring
places at distance 1. The rule is independent of `R` and of the colour count, and the radius is read from it. The existence form cannot be answered
without some such rule, since FS-114's case-by-case kills never reached the vertex types that reach farthest.

*What it already holds:*
- A (Q)-free ring has change points exactly at `y + 60°ℤ`, alternating the two absent colours (N6-RING60, two minds, one blind). Each of those six
  points is a vertex of at least four colours (N7-HUB, one mind). The Reuleaux bowtie's `q1, q2, top, bot` are four of them, and the bowtie dies at
  `r = (√3, 0)`, on the hexagon's second shell (FS114-Y4-RSTOPALL).
- Every held fragment that reaches past `√3` has (Q) arcs on its four-colour vertices' rings (row 136). The capped strip is a line of such vertices at
  spacing `1/2`, its colour sets repeating with period 3, and it reaches `φ²/√2`. The disk is a 5-cycle of corners, reaching `φ`.

*Its seven-colour control.* At `k = 7`, R7's lattice points (six colours each; FS111-M-R7) recur over the whole plane. So the six-colour answer must name
where the seventh colour's room is spent. N6-RING60 names one place: "with a seventh colour the ring can carry three" absent colours
(`plans/FS114-N7-proof.md` § 2.3).

## Bearing on the answer

*Rewritten by Poros (FS116-P1, 2026-09-29).*

**Decisive in both directions, and route M's first half.**

*The NO* is an explicit `R`, uniform in the complexity. With FS114-CV-EXISTS it gives the unit-arc NO for every valid map, periodic or not, Siamese
pairs included, with no ray step and no density. It then:
- answers `[SokolovVoronov2025]` Question 2 ("Is it true that 7 colors are needed …?") **yes** for its unit-arc half, almost everywhere, for locally
  finite segment-and-arc maps;
- answers `[Polymath2021]` p. 199's hope for such tilings;
- closes door (A) of row 133 at every complexity bound;
- answers the upper side of Mixon's thread-7 question ("What is the radius of the largest disk in $\mathbb{R}^2$ that can be 6-colored?") for maps with
  unit arcs.

With FS-121's map step (route M; FS111-C-SEVEN-M, two minds) the NO gives `χ_m⁰(ℝ²) = 7`, hence `χ(ℝ²) = 7` given MR. **Route M's honest branch needs
the NO only for honestly saturated maps** (FS111-M2-REDUCE-A derives REG-A_k "in an honest saturated k-colouring"). So a NO in that class is already
route M's half. The all-maps NO is what answers Question 2.

*Its failure* is a valid fragment about a four-colour vertex on every disc, its complexity free. That gives `χ_m⁰(ℝ²) ≤ 6`, hence `χ(ℝ²) ≤ 6` with no
MR, **if** card `the-yes-needs-no-map` holds. That card is a composition of `LEDGER.md` row 131's weak-* step, the exact-fragment twin of
FS111-W-NEG (iii); it is Poros's, at one mind, and unchecked. A valid map of the plane is one way to supply the failure. If the card holds, the uniform
radius is implied by seven: it is a necessary condition of the bold answer and never an overshoot of it, and this question decides something whichever
way it goes, without FS-121.

A local exclusion for one configuration only (as FS-114 filed) is a piece, not the answer. A NO for non-Siamese maps only is FS-117's, not this
stub's.

**At FS-121's close (2026-10-03).** The honest route hands this NO an honest saturated map whose curved ladders end at (Q) or (R2) arcs (FS121-O1-ENDS, held) and, when periodic, whose curved interfaces are split (Q) arcs (FS121-O1-PER, held). The colour-generic lemmas this milestone's jobs were given: FS121-D1-VT, held in its narrower wording and misstated at corners of `L`; FS121-D1-EROSION, held, with content only at `θ ∈ (2π/3, π)`. FS121-C1-SAT (held): C121-NOPAR contains the saturated segment-and-arc NO; that it contains NO-SAT is FS121-C1's commentary, one mind. FS121-D3's recognition (one mind): in a saturated colouring every colour change across an interface is an exchange with a unit neighbour.

**At FS-116's close (2026-10-03, FS116-Z2).** **Not landed:** C114-LOCAL-F is GAP at named ring types (`plans/FS116-derivation.md` FS116-C114-LOCAL-F; the case list is
`plans/FS116-Z1-close.md` § 2.6). Held under the announcement rule: the **Γ-free four-colour vertex is excluded at radius `1 + ε`** in the non-Siamese simple
class (FS116-Y4-EMPTY, two minds, the second blind); **the YES needs no map** (FS116-O1-YESLIM: valid `k`-coloured fragments on discs of every radius give
`χ_m⁰(ℝ²) ≤ k`, at six `χ(ℝ²) ≤ 6` with no MR), so this question is decisive in both directions without FS-121, as card `the-yes-needs-no-map` said; and
**saturation pins every edge at a four-colour vertex** as split or tangent (FS116-O1-SATPIN). Every change point of a ring off (Q) arcs, and every
semi-hub but the full parallel one of three colours, places a vertex of at least four colours on the ring (FS116-RING-GERM, FS116-N3-SEMI, held). The
rest of the question is FS-123 (`plans/STUB-qfree-ring.md`: the (Q)-free ring, opening with whether a fragment's bends keep it in EMPTY's class),
FS-124 (`plans/STUB-q-ring.md`: the (Q) rings and the five- and six-colour vertices) and FS-125 (`plans/STUB-saturated-local.md`: the saturated class).

## What FS-114 established (addresses in `plans/FS114-derivation.md`)

- **The reduction** (§1): FS114-CV-EXISTS (every valid map has a four-colour vertex; two minds, blind to each other, over FS112-N3-DENSE3 and row 134's
  base). C-ENDS's residue is empty (FS114-CV-HD).
- **Where the count says six has room** (§2): FS114-N2-ENDS — the charge `n`, `n − 2`, `n`, `n + 6` at degrees 3–6 sums to zero, negative only at a
  degree-4 four-colour vertex with three or four **tactic** edges (unit arcs about four-colour vertices at distance 1). **K1** asks that no such vertex
  exists in a valid map, locally.
- **K1's pieces** (§3), non-Siamese and simple:
  - the **Reuleaux bowtie** (two width-1 Reuleaux triangles corner to corner, four tactic edges; any lune rings) has no fragment on `B̄(p, √3)` —
    FS114-Y4-RSTOPALL, two independent derivations (the construction side's at two minds, one blind; the proof side's N4-D, N4-G, N5-GRING, NB5-RVKILL,
    its last step one mind); it exists on `B̄(p, 3√3/5)` (FS114-Y2-BOWTIE, two independent objects);
  - the **pinwheel** (four tactic edges turning one way) has no fragment containing a neighbourhood of `B̄(p, 1)`, except under **E1** (an edge at `p` of
    exactly 60°) or **E2** (a blade's counter-clockwise side a unit arc about its clockwise edge end) — FS114-Y5-PINALL (two minds, one blind), with
    FS114-N6-NOQ (pinwheels with rings free of (Q) arcs, two minds, one blind); E1 is FS112-L60's equality case (FS114-Y6-E1CAP), E2's only surviving
    family is S6 `(120°, b, 180° − b, 60°)` (FS114-Y6-E2RED, the cut to S6 one mind);
  - **three or more tactic edges on a ring free of (Q) arcs** have no fragment at `1 + ε`, except the open-cap family OC — FS114-N7-3T, **one mind**.
- **Not excluded anywhere**: four-colour vertices with 0–2 tactic edges (the strip's midline vertices carry 0, the disk's corners 2 — FS114-Y6-HELD's
  survey) and vertices of degree 5 or more. C114-LOCAL-F needs them too.

## The opening queue (round 7 of FS-114, not run; inventory items 118–121)

1. **A blind second mind on FS114-N7-3T**, N7-HUB (b) and the `+++ b = a + 1` step first (`plans/FS114-N7-proof.md` §2.1–2.2); it scores N7's two
   registrations (OC dies within `√3`, p 0.5; every (Q)-ring survivor has a 60° (Q) arc or a (Q) arc ending 60° from a tactic centre, p 0.4).
2. **The wrap lemma**: exclude a pocket tile wrapping round a blade's ring end (YB4-WRAP, `plans/FS114-YB4-verification.md` stage 1b items 6, 9). One lemma
   closes three GAPs: FS114-Y5-PINALL's lemma PX's "`λ_k = α_k − 60°`", FS114-Y6-E1CAP's `λ_3`, FS114-Y6-E2RED's full wrap.
3. **OC** (K1-OPENCAP): `+−+` with a Reuleaux lens beside a 60° anti-lens, or with a fourth tactic edge the bowtie whose lenses do not border the caps;
   N7-OCTB's forced structure and route to `√3` (`plans/FS114-N7-proof.md` §3.3).
4. **Rings with (Q) arcs**: N7-HUBQ's step (a tip at a change point whose ±60° points carry (Q) arcs); the (Q)-pinwheel's residual (NB6-QSTART, a (Q) arc
   of `T_{j+2}` from `q_j` when `α_{j+1} = 60°`); **first, compare N7's reading R-E2 with the construction side's E2** — not settled at the close
   (`plans/FS114-C-close.md` stage 2 §2.5: R-E2 fixes a 60° cone, E2 fixes none, and E2 at a 60° blade needs E1 by YB5-E2-60).
Then: E1's residues E1-Z, E1-60, E1-ν and E1 at edges `{1, 2}`, `{1, 4}` and with E2 (`plans/FS114-Y6-construction.md` §2.7); E2's S6; non-simple bowties;
the Reuleaux `(2, 1, 1, 0)` past `√3` on rings with (Q) arcs (FS114-Y6-HALF, corrected; `plans/FS114-Y6-construction.md` §4.3).

## Beyond K1 — the question itself

- **Four-colour vertices with at most two tactic edges, and degree ≥ 5.** No FS-114 route touched them locally; the count does not penalise them, so the
  local route needs a different handle. **The lead (a reading, one mind):** N7-HUB — at a four-colour vertex whose ring is free of (Q) arcs, the six ring
  change points are four-colour vertices — so four-colour vertices propagate in hexagons; a local exclusion might follow the hexagon outward until two
  same-colour tiles are forced to straddle distance 1, as every FS-114 kill did (YB2-DE's `√(1 − 2tt′)`; YB4-2ND: the contradiction at second order).
  Killing test of the lead: a four-colour vertex with a (Q)-free ring and a change point of three colours, on a fragment by formula.
- **Siamese pairs.** CV-EXISTS covers them, and the pieces above assume "non-Siamese" and "simple": a local exclusion for the whole NO must drop both, and
  (G86) it must read points and distances, never tile counts (N2-REFINE).
- **Explicitness.** At each complexity `K` a radius exists iff the NO holds (FS114-N114-COMPACT); the question is an explicit radius, uniform in `K`.

## Owed second minds (before anything final rests on them)

- FS114-N3-LOCAL's N3-HALF, -SEC, -FLANK, -PAIR, -ODD (one mind; every proof-side exclusion uses them); FS114-N7-3T (item 1 above); YB5's cut of E2's
  survivors to S6; FS114-L60-WALK (the registered L60-P1, p 0.85, and L60-P2, p 0.9, wait for a blind mind).
- **Row 134's base, Lemma 4 at cusps** (CUSP-BASE's D5 items 1–4 and 6, at one mind; BASE-V's blind derivation stopped at Prop. 19(b) and the selection):
  FS112-N3-DENSE3, hence FS114-CV-EXISTS, hence any NO filed here, rest on it — a second mind is owed before any publication (inventory item 14).

## Construction targets (for the YES side, or as killing tests)

- A fragment by formula about a four-colour vertex beyond `φ²/√2` (C114-DIAL's next step), first at the disk's corners (two tactic edges; FS112-DISC:
  `φ` about a vertex is attained) and at rings with (Q) arcs — the class every exclusion so far had to except.
- The Reuleaux `(2, 1, 1, 0)` past `√3` (FS114-Y4-DIAG's `top` analysis with `t_2` a blade); three tactic edges from the disk's corner
  (`plans/FS114-Y6-construction.md` §4.3); an E1 member or an S6 member past `1 + ε`.
- A four-colour vertex under 60° with its ring inside a fragment (FS114-Y's aim, `plans/FS114-Y-construction.md` §3.4; not attempted).
- *Placed at FS-114's close from its inventory:* the explicit curve pair at FS112-BOWTIE's seam (E16, G71's index with unit arcs) — carried, untested; a
  fragment for C114-RAINBOW's case (ii) — done (YB's radius-3/5 fragment, the corrected third case); the torus skeleton meeting K6 and PAIRSHARE — moved to
  FS-117 (a periodic design is route T's object).

## Prior-art debts

Sirgedas's thread "Graph Coloring by Simulation" (`~/source/library/hadwiger-nelson-problem-group/threads/J_Tw1_hUxQI.txt`, about 4,300 lines unread;
"siamese" at lines 715, 4378, 4409, 4504, 4888) and the HNT simulator thread `a701Kwnhp_A` (unheld) — read before any claim of novelty for a local
exclusion; `[Thomassen1999]`'s page images (held as OCR only).

*At FS-116's close (FS116-Z2, 2026-10-03; inventory item 19):* the HNT simulator thread `a701Kwnhp_A` is held, not unheld
(`~/source/library/hadwiger-nelson-problem-group/threads/a701Kwnhp_A.txt`): a simulator thread with no exclusion statement
(`plans/FS116-local-exclusion.md` § 2.2). Sirgedas's "A biggest disc implies no 6-color-tiling of the plane exists." (`J_Tw1_hUxQI.txt` l. 4661) is filed as
prior art for the local-to-global idea (FS-116's note under FS114-CV-EXISTS); the rest of the thread stays unread beyond ll. 4290–4790 and the grep hits.

## Registered expectations (instruments for G21, scored at the close; never caps)

Carried from FS-114: N7's two (above). Provisional, for the opening to replace: the wrap lemma derived at one mind (0.6); OC excluded at `√3` (0.5); a
four-colour vertex with at most two tactic edges excluded at an explicit radius (0.2); C114-LOCAL-F at an explicit radius within this milestone (0.25).

## Failure clauses

A local exclusion for one configuration is a piece, and says which configurations remain; a NO for non-Siamese or simple maps only says so in its
headline (FS-114's class discipline); no argument one colour class at a time (row 129); every step states its reading radius and the controls it fails on
(the strip at `φ²/√2`, the disk at `φ`, the bowtie at `3√3/5`); a YES candidate that fails the exact check measures the candidate.

## Known tool defects

`FS112-Y`'s float guard `locate` reports extra tiles at three points, and `FS112-Y2`'s `tile_poly`/`locate` places `B_0 + s·e(0)` in `R_4`, `U_4` on the
moved disk (exact: only `T1_0`) — guards, no verdict rests on them; other jobs' tools, not to be edited (standing rule 7).

## Decisions held

D6 (Kooshi's): a Lean skeleton of Q-full's statement (segment-and-arc maps, almost-everywhere validity), `sorry` at every leaf — now, or once the class
is fixed. FS-114's four kernel candidates wait on it (`plans/FS114-derivation.md` handoffs: CV-EXISTS, N2-ENDS, Y4-RSTOPALL, and K1 once filed).

## Deliverables

The plan (`plans/FS116-<slug>.md`, with the reframe first); the derivation file; the successor's stubs; the close's drafts.

# Poros — FS-107, stability: can vanishing holes save a colour? (job FS107-A, the advisor, 2026-09-27)

*Brief: `data/fs107/briefs/A107-advisor.md`, with `data/fs107/briefs/STANDING-RULES.md`. I advise the planner (FS107-P, agent
`a677ed204a8fc8479`), then competitors R and W under `plans/PROTOCOL-competitor-and-advisor.md`. Identity: `~/source/poros/CLAUDE.md`.*

**Fence note for every competitor and verifier brief:** this record and `data/fs107/fs107-a/` hold the advisor's expectation about where
each side breaks. Competitors and blind verifiers must not open either path, nor `git log -p` on them, until the owner lifts the fence
(protocol §1 rule 1: the advisor's record is a covert channel one directory up). Item H1 below.

## Theorems this phase proved

- **AD (anchor dimension)** — an argument whose only use of the holes is "an effective hole within `Cε` of every anchor of a set `A`" certifies
  at most `≍ N(A ∩ Q, ε)·ε²` of hole area per unit square `Q` (`N` the `ε`-covering number): `ε²` for finitely many anchors per unit area
  (A8b, TQ-EPS2), `ε` for curves of anchors (TQ-HIT), `Θ(1)` only for anchors of positive measure — or for holes of an `ε`-independent size
  `ρ₀`. [derived, one mind; it is TQ §4.4's dichotomy with the exponent interpolated, credit TQ.] Stage 1, E1.
- **C6 (complementary triples)** — in a six-colour palette two three-element multicolours are disjoint iff they are complementary; so
  C-T-TAN's "two points of disjoint three-element multicolours within distance 2" is "two junctions of complementary type within distance 2",
  and a colouring avoids it iff, in every disc of diameter 2, its junction types lie in one of the families that choose at most one triple
  from each of the 10 complementary pairs. [hand, one mind, trivial.] Stage 1, E2.
- **BICH (no bichromatic-only maps)** — a map whose face-adjacency graph is connected and in which every vertex meets at most two colours
  uses at most two colours. [hand, one mind: merge equal-coloured neighbours; then colours alternate around each vertex, so every
  edge-neighbour of a face of colour `a` has one colour `b`, and connectivity spreads the pair.] So every map in six colours has a vertex
  where three colours meet. Stage 1, E2.

## Would-have-searched-here log

- (none yet)

## Stage 0 — SAVED: quotation check (standing rule 5) and inventory

**Quotation check of my brief against its sources.**

| brief's words | source | verdict |
|---|---|---|
| "TQ-HIT (no hitting form)" | FS106-HIT, `plans/FS106-derivation.md` §4; TQ §4.4 | faithful as a gloss |
| "the pixel lemma (no trichromatic coloured point)" | FS106-PIX: "every coloured point has chromaticity 1" | faithful; the source is stronger (chromaticity 1, not only `≠ 3`) |
| "C-Q-LOCAL (local repairs cost `O(ε²)`)" | FS106-LOCAL is Parts's eroded tiling: "For every δ > δ₆ … every coloured point has chromaticity 1". The `O(ε²)` is **A8b**, `plans/POROS-2026-09-26-fs106-regular-half.md` l. 242: "breaking Voronov's proof costs `O(ε²)` per unit area" | **MISATTRIBUTED**, and inherited: A2's break table (`plans/POROS-2026-09-27-fs106-close-and-fs107.md` §3.6, row 2) says "C-Q-LOCAL says local repairs cost `O(ε²)`". The claim list must cite A8b (one mind, the predecessor Poros) for `O(ε²)` and FS106-LOCAL for the ceiling. Item C1. |
| "TQ-EQ … proved at two minds, one of them blind" (planner brief) | FS106-EQ: "[hand; two minds, one blind: TQ, QB by a different route at (c) ⟹ (a)]" | faithful |
| R: "Some radius `R` and some `δ₀ > 0` work for every `ε`" (planner brief) | TQ §4.5 item 2, A2 §3.3 | faithful |

**Grades moved at the close.** A2's §3.4 table grades the floor, the ceiling, HOLE-t, the pixel lemma and TQ-HIT "one mind"; the close
(`plans/FS106-derivation.md` §4) raised EPS2, HIT, PIX and LOCAL to two minds, one blind, and carried QB's constants: the floor is
`ε²/(6+ε)²` (not `ε²/78`), TQ-HIT's cap is density `ε` (QB: spacing 2), not `4ε`. The claim list takes grades and constants from the close.
Item C2.

**Evidence inventory** (read against an expectation written before the reading).

- `plans/POROS-2026-09-27-fs106-close-and-fs107.md` §3, A2's design — read against: two objects, two questions, a constraint table and a break table all quoted from TQ/TS — surprised: yes, once (the `O(ε²)` attribution, C1)
- `plans/FS106-derivation.md` §4 — read against: the grades A2's table shows — surprised: yes (four grades raised, two constants sharper, C2)
- `plans/FS106-TQ-derivation.md` §4.1–§4.5 — read against: HOLE-t, EPS2, ERODE, HIT, STAB as A2 quotes them — surprised: no
- `LEDGER.md` rows 128–132 — read against: row 131 = FS106-EQ family, row 132 = regular half — surprised: no
- `CLAUDE.md` § The aim (on disk, post-close), G82 — read against: link 5 in stability terms — surprised: no
- `plans/STUB-regularity-wall.md` § FS-107 — read against: A2 §3 carried — surprised: no
- `plans/PROTOCOL-competitor-and-advisor.md` §1 — read against: the fence list — surprised: yes (rule 1 keeps the advisor's record in scratch until hand-back; my brief puts it in `plans/`; H1)
- `plans/FS106-TS-derivation.md`, `plans/FS106-QB-verification.md`, `plans/FS106-SB-verification.md` — read against: nothing yet — surprised: unread (the planner reads them; I read the parts a card needs)

## Stage 0 — SAVED

## Stage 1 — SAVED: my expectation, written before any planner draft

*Per the counter-priors: obstacles, not odds.*

### E1. Where a stability proof has to get its holes from

The three no-gos are one law about **where the argument anchors its holes**. An effective hole contains a disc of radius `ε/2` (HOLE-t).
- Anchors at finitely many features per unit area (junctions, Voronov's certificates): `≍ ε²` (A8b; TQ-EPS2 is exactly this, one hole per
  disc of radius 3).
- Anchors along curves (every unit circle, every bicycle): `≍ ε` (TQ-HIT's strips).
- The pixel lemma removes the anchors in the coloured set altogether: every feature a proof can locate sits in or at the holes.
- **So R has exactly two doors** (TQ §4.4 names both; AD above interpolates):
  1. **(R-ρ₀) holes of an `ε`-independent size `ρ₀` at a bounded-below density of anchors.** This is Parts's picture: his voids have fixed
     half-diagonals `0.0133` and `0.0055`, one at every vertex. Anchors can be junctions, because junctions are unavoidable (BICH: every six-colour
     map has a vertex where three colours meet) and dense at scale 1 (islands have diameter `≤ 1 − ε`). The lemma R needs is then
     **void conservation**: shrinking the void at one junction below `ρ₀` forces a void `≥ ρ₀` within distance `O(1)`. A8b does not cap it,
     because A8b caps killing *Voronov's certificate*, not producing a valid colouring; the void's size is set by the constraint system's
     propagation over distance `≥ 1`, never by the junction alone.
  2. **(R-meas) a defect of positive measure**, counted by Fubini: circle length `∫|S(x,1) ∩ H| dx = 2π|H|`, or band-pair mass (PD-EQ). The only
     natural positive-measure anchor family is "almost every point", and a statement about almost every point of a near-colouring is a
     statement about its weak-* limit. **I expect R-Q to collapse into R-S within round 1**: the sequence object has no 2-dimensional anchor
     family of its own, so a direct R-Q argument either passes through a limit or is capped.

### E2. Where a W family has to put its vanishing holes

- W's holes are at the junctions, 0-dimensional anchors of vanishing size, between the floor `ε²/(6+ε)²` (a disc of radius `≍ ε` per junction)
  and `o(1)`. Channels of width `2κ ≪ ε` along every boundary are free (HOLE-t; erosion costs `κ × boundary length`).
- Eroding any **tight void-free** six-tiling with finite boundary length gives W's sequence (TQ-ERODE, holes `O(κ)`). So W's family is, in
  substance, a tight a.e.-proper six-colouring, approached through near-tight ones.
- A **transversal** junction whose three colours all have positive density cannot have a vanishing void when a junction of the complementary
  type lies within distance 2 (Voronov's circle step, verified in the tight a.e. case at FS-106; C-T-TAN). By C6 that is a combinatorial
  condition. So W has three escapes, and I expect its first family to use one of them:
  - (W-orient) in every disc of diameter 2, the junction types avoid complementary pairs. A single star (every junction contains colour 1)
    fails by BICH applied to the complement of colour 1. Other intersecting families survive this test (e.g. every junction contains at
    least two of `{1,2,3}`, which forces every boundary between two of `{4,5,6}` to be a closed curve: nested islands).
  - (W-cusp) degenerate each junction to a cusp or tangency. The cusp point stays *support*-trichromatic (the horn has positive measure in
    every ball), so the circle step still starts there. That is TS's C-T-TRIb, carried in support form. The cusp buys density-bichromaticity
    and nothing more.
  - (W-arc) unit-arc interfaces: Reuleaux-type tiles of width exactly 1, whose sides are arcs of unit circles centred on their own boundary.
    These are the tight rigid circle pattern (six arcs of exactly `π/3`, degree 2, which slack never allows), and they are where row 132's index
    method fails (a unit-arc interface facing a bowtie, `|ΔInd| = 2`). This is C-AE-Q2's family, which A2 ranked as a special case of W.

### E3. Which breaks first, and where

- **In round 1, R's first mechanism breaks, at the anchor step.** It will count junctions or circles, and the erosion test or the strip test
  kills it. The retraction is cheap and informative: it sends R to R-ρ₀ or R-meas.
- **W's first family breaks at the junction void.** I expect the shrinking parameter to *move* the void rather than kill it: a cusp or an
  orientation constraint at one junction pushes a unit-distance constraint onto a partner about 1 away, where a void of the old size reappears.
  This is the break table's row 2, read from W's side.
- **The decisive step is the same on both sides: void conservation at a junction.** R proves it (R-ρ₀). W refutes it by a family in which the
  void at every junction shrinks with a named parameter while no partner void grows. On the limit object it is C-T-PIG: must a tight
  a.e.-proper six-colouring have complementary junctions within distance 2?
- The hard content sits in the tight world's extra circle pattern (six arcs of exactly `π/3`). Slack forbids it, and the Siamese pairs of
  Parts's tiling use it. R must name the step where "six" is spent against that pattern (killing test R2); W must build with it.

### Hunch ledger

```
hunch: rq-collapses-to-rs
  claim: R's sequence-object route passes through a weak-* limit, or is capped at O(ε), before round 1 ends
  basis: derived (AD, E1)
  falsifier: an R-Q argument with an ε-independent bound whose anchors are not "almost every point" and that uses no limit
  registered: 2026-09-27
  status: open

hunch: void-conservation-is-the-crux
  claim: both sides' decisive step is whether a junction's void can shrink below a fixed ρ₀ without a void ≥ ρ₀ appearing within distance O(1)
  basis: analogy (Parts's fixed-size vertex voids; A2 break table row 2)
  falsifier: R's proof or W's refutation that never mentions junctions, their voids, or complementary junction pairs
  registered: 2026-09-27
  status: open

hunch: w-first-family-moves-the-void
  claim: W's first formula family has a shrinking parameter under which some void keeps a positive floor (the void migrates to a partner junction)
  basis: prior
  falsifier: W's first family passes W's four killing tests with total void → 0
  registered: 2026-09-27
  status: open

hunch: complementary-type-is-the-combinatorial-core
  claim: C-T-PIG, written with C6, is the statement both sides end up fighting over (a design problem on junction types at scale 2)
  basis: derived (C6) + analogy
  falsifier: the contest's first decisive step lies elsewhere (e.g. a Fourier or k-point correlation argument with no junction in it)
  registered: 2026-09-27
  status: open
```

### Held for the owner

- **H1 — the record's place.** Protocol §1 rule 1: "The working files and the advisor's record live in those scratch directories until
  hand-back, never in `plans/`." My brief puts the record at `plans/POROS-2026-09-27-fs107-stability.md`, and it now holds my break
  expectations. **The choice:** keep it in `plans/` and fence it by path in every R, W and verifier brief (with `git log -p` on it). **The
  alternative:** move my competition-phase notes to `scratchpad/fs107-a/` and keep only the plan-phase stages here, which follows the letter
  of rule 1 but splits the record. **Why the fence wins:** the plan-phase stages must be in the repository for the planner, and a path fence
  is what the protocol already uses for `chats-bak/`. **Confidence: medium.** It would change if a competitor brief goes out without the
  fence; then I move the notes. **Default:** I ask the planner to write the fence into every brief, and competition-phase stages go to my
  scratch until the owner says otherwise.

## Stage 1 — SAVED

## Stage 1b — SAVED: a correction to E2 from TS §4–§5 (read after stage 1 was committed)

- **E2's W-orient was incomplete.** TS's C-T-KILL has two halves: complementary multicolours at distance `< 2` (C-T-TAN, TRUE under its
  strong-blow-up hypotheses) and **equal** multicolours at distance in `(1, 2)` (S–V Lemma 3's transplanted bicycle; GAP on the limit object,
  TRUE for polygons after FS-106's repairs). So a W family built from regular junctions must satisfy, for junction pairs at distance in
  `(1, 2)`: types intersecting and unequal; at distance `≤ 1`: types not complementary. Both are exact checks of a given tiling.
- TS's C-T-TRIa counterexample (a horn at every vertex of the slack hexagonal 7-colouring) confirms E2's W-cusp reading: cusps remove
  *density*-trichromatic points at no cost, and the support form (C-T-TRIb) is the one both sides must carry.
- C-T-CHR4 (no point of four support colours, `k = 6`) is a GAP at `|P(x)| = 4`. A W family may use four-colour junctions; the claim list
  should say so.

## Stage 1b — SAVED

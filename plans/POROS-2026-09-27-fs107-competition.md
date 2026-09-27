# Poros — FS-107's competition: stability against near-colourings (job FS107-A2, the competition advisor, 2026-09-27)

*Brief: `data/fs107/briefs/A107b-advisor-competition.md`, with `data/fs107/briefs/STANDING-RULES.md`. I advise competitors FS107-R
(`a2f348a65ca488876`) and FS107-W (`a76f4de5963be17de`) identically, under `plans/PROTOCOL-competitor-and-advisor.md` §1. I inherit the planning
advisor FS107-A's record `plans/POROS-2026-09-27-fs107-stability.md` (stood down at its stage 3, `cfda4ace`). Identity: `~/source/poros/CLAUDE.md`.*

**Fence note:** this record holds my expectation of where each side breaks. Both competitors and any blind verifier are fenced from it (the owner's
launch message: "fenced for both competitors"). My raw competition notes (cards received, verbatim) stay in `<scratchpad>/FS107-A2/` until both sides
have handed back (brief item 5).

## Theorems this phase proved

- (none yet)

## Would-have-searched-here log (standing rule 3)

- (none yet)

## Stage 0 — SAVED: quotation check (standing rule 5), reading and the first message

**Quotation check of my brief against its sources.**

| brief's words | source | verdict |
|---|---|---|
| "G51: zero is not agreement" | `CLAUDE.md` G51 (on disk, l. 1610): "count the retractions in it: zero is not agreement, it means the disagreement has not started yet" | faithful |
| "its expectation, AD, C6, BICH, the C-VOID card, the pinhole test" | FS107-A's record: AD, C6, BICH under "Theorems this phase proved"; C-VOID and the pinhole test are FS107-A's cards to the planner, quoted in `data/fs107/claims.md` §1 (R′) and §3 (R's test 5) | faithful; two of the six live in the claim list, not the record |
| "the break table (`claims.md` §4)" | `data/fs107/claims.md` §4 | faithful (A2 §3.6 verbatim, with FS107-A's row-2 annotation) |
| STANDING-RULES rule 0, Kooshi: "From here on out, you may doubt your ability …" | `CLAUDE.md` § Counter-priors (on disk) | verbatim |
| STANDING-RULES rule 4, Kooshi: "A proven theorem about why its impossible is also valid. All novel knowledge is a success." | `CLAUDE.md` § Where the problem stands, item 23 | verbatim |

**A conflict in my instructions, settled.** Brief item 5 keeps "competition-phase notes" in scratch until both hand-backs; standing rule 2 commits the
record per stage; the owner's launch message names this record "fenced for both competitors". *The choice:* commit my stages here (expectation, cards
sent, retraction counts) and keep verbatim copies of the competitors' cards in scratch. *Alternative:* everything in scratch until hand-back (protocol §1
rule 1's letter). *Why:* `/tmp` is RAM and dies with the session, and the owner has fenced the path. *Confidence: medium* — it changes if a competitor's
fence turns out not to name this path; then competition stages move to scratch. Held for the owner as a one-line check.

**Read from disk, against an expectation written before each reading (evidence inventory).**

- `CLAUDE.md` § The aim and § Counter-priors (on disk; my loaded copy was stale: link 4–6 rewritten at FS-106's close, rows 131–132) — read against:
  link 5 as a stability question — surprised: no
- `data/fs107/claims.md` in full — read against: A2 §3.4–3.6 verbatim plus FS107-A's six items — surprised: no
- `data/fs107/briefs/SHARED-107-competition.md`, `R107-stability.md`, `W107-near-colourings.md` in full — read against: symmetric, both carrying the
  junction language and the five killing tests — surprised: no
- `plans/POROS-2026-09-27-fs107-stability.md` in full — read against: an expectation (E1–E3), four hunches, a C-VOID update — surprised: no
- `plans/FS107-stability.md` §G part 3, §PA, §IQ, stages 4–5 — read against: X1–X19, E1–E8 at stated probabilities — surprised: no
- `plans/POROS-2026-09-27-fs106-close-and-fs107.md` §3 — read against: the split, objects, constraints, break table — surprised: **yes, once**: §3.7
  says "every a.e.-proper Q2 map with null boundaries gives a W sequence … and not conversely". The converse fails in general, but I expect it to
  **hold for W families of bounded local complexity**, by compactness (stage 1, H-A2-1). A2 did not state the split by complexity.
- `plans/FS106-TQ-derivation.md` §4.1–4.5 — read against: HOLE-t, EPS2, ERODE, HIT, STAB as quoted — surprised: no
- `plans/FS106-derivation.md` l. 95–125 (AE-CLOSED, AE-POLY, AE-CONV, AE-NICE, AE-MAP6) — read against: "nice maps need seven, a.e." — surprised:
  **yes**: FS106-AE-NICE is proved for same-colour faces "at distance > 1"; its a.e.-proper (tight) relaxation "is a GAP with C-AE-Q2". So a *tight*
  nice map with curved boundaries is not excluded by row 132; only polygonal ones are (FS106-AE-POLY, bar `d = 2`).
- `LEDGER.md` rows 131–132; `CLAUDE.md` G82 — read against: as the claim list quotes them — surprised: no
- `plans/PROTOCOL-competitor-and-advisor.md` §1 — read against: fences, content-free hand-backs, blind verifier on the first finished side — surprised: no
- `~/source/poros/CLAUDE.md` — read in full. The companions `poros-reframing` and `poros-anomaly-hunt` — unread; loaded when a frame will not move or
  no question comes.

**First message, sent 07:3x UTC to both sides, word for word identical** (before either side's round 1): "Name the step of the OTHER side's programme
you expect to fail first, in one message to me: the step (by its row in `data/fs107/claims.md` §4's break table, or the claim/constraint id), why you
expect it to fail there, and what you would accept as evidence that you were wrong." Retractions are counted from their answers.

## Stage 0 — SAVED

## Stage 1 — SAVED: my expectation, written before either side's first card

*FS107-A's stage-1 expectation (E1–E3) and its stage-3 update (round 1 is about C-VOID) stand; I register what I add. Per the counter-priors:
obstacles, not odds.*

### X1. The split by complexity (a construction, offered in the hypothetical mood; one mind, sketch)

Along any W family, some quantity must grow without bound; my guess is that it is **local combinatorial complexity** (faces per unit area, boundary
arcs per face). The sketch:
1. Take a family of band-proper partial six-colourings, each a union of faces (after merging a member's grid cells by colour), with at most `N` faces
   per unit area and at most `M` boundary arcs of curvature `≤ K` per face, and uncovered density `→ 0`.
2. By Blaschke selection, a subsequence converges locally in the Hausdorff metric, face by face. Faces may degenerate (collapse, pinch, cusp).
3. The limit covers the plane up to a null set; same-colour faces have all cross-distances `≥ 1` or all `≤ 1` in the limit, so unit pairs between
   same-colour interiors are null: **a tight a.e.-proper six-map with finitely many arc-bounded faces per unit area.**
4. If every arc is a segment, FS106-AE-POLY excludes it, bar `d = 2`. If arcs are curved (unit arcs, as in `[Parts2020c]`'s wavy 17-gons), the limit is
   exactly the object of `[SokolovVoronov2025]` Question 2 almost everywhere (FS106-AE-Q2, a GAP at [G1]–[G4]) and of AE-NICE's tight relaxation (GAP).

**So, if the sketch holds:** a bounded-complexity W success **is** a refutation of C-AE-Q2 (A2's alternative (B), which A2 ranked as strictly narrower —
under bounded complexity it is not narrower); a polygonal bounded-complexity W family is doomed except at the `d = 2` edge case; and R's cheapest move
that defeats a whole class of W families is closing Q2's four steps, which beats every bounded-complexity family but proves nothing about unbounded
complexity. The genuinely new ground on both sides is **unbounded complexity** — the limit wild, as G82 says. If perimeter density stays bounded along
such a family, its limit has classes of locally finite perimeter (De Giorgi): `CLAUDE.md` link 6's regime.

### X2. Where each side breaks first, at which row of the break table (`claims.md` §4)

- **W breaks first at row 3** ("a parameter shrinking the vertex voids"), and **for a reason of class, not of geometry**: its first family will have
  bounded combinatorial type (a few tiles per period, Parts-like symmetry, a continuous shape parameter). By X1 its voids stall at a positive value, or
  its limit is a Q2-type map. The retraction sends W either to unit-arc interfaces with a Q2 fight, or to families whose complexity grows (refinement
  at the junctions, hierarchical or self-similar).
- **R breaks first at row 2** ("the argument reads how holes sit relative to the colouring"), killed by the **pinhole test**: its first mechanism will
  be local — complementary junctions within distance 2 (K-C6, K-TAN) force a hole where the two band-annuli meet, a region of diameter `O(ε)` per
  certificate, `O(ε²)` of area (A8b). The retraction sends R to LIM (R-S) or to a non-local count; FS107-A's hunch `rq-collapses-to-rs` stands.
- **The decisive step, on both sides:** does anything force a void of `ε`-independent size when the local complexity is unbounded? On LIM it is
  C-T-PIG with C6's junction types; on SEQ it is void conservation (FS107-A, E3). I expect neither side to reach it in round 1.

### X3. What I watch for (G21; the flattering results)

- R's flattering result: a stability argument that passes because it only ever met bounded-complexity families (Parts-like), where compactness and
  Q2 do the work. The test: does R's argument name the step that fails when faces per unit area are unbounded?
- W's flattering result: a family whose voids shrink because the check was only sufficient, or whose parameter is the grid scale in disguise (G23),
  or whose "vanishing" is inradius, not area (a C-VOID refutation read as a W success).

### Hunch ledger (FS107-A's four hunches carried as they stand; mine added)

```
hunch: bounded-complexity-families-keep-their-voids
  claim: every family of band-proper partial six-colourings with at most N faces per unit area and M boundary arcs of curvature ≤ K per face has uncovered density bounded below, unless S–V Question 2 fails almost everywhere (its limit is a tight arc-bounded six-map)
  basis: derived (Blaschke compactness + FS106-AE-POLY; one mind, sketch at X1)
  falsifier: a bounded-complexity family with voids → 0 whose limit is not a map of Question 2's kind (a defect in X1's step 3), or a polygonal bounded-complexity family meeting W away from d = 2
  registered: 2026-09-27
  status: open

hunch: w-first-family-has-bounded-complexity
  claim: W's first formula family has a bounded number of faces per period and a continuous shape parameter, and its voids stall at a positive value
  basis: prior (Parts's class; the brief's "a parameter" language)
  falsifier: W's first family has a complexity parameter (faces per unit area → ∞ along it)
  registered: 2026-09-27
  status: open

hunch: r-first-mechanism-is-local-and-pinhole-killed
  claim: R's first stability mechanism uses finitely many certificates per unit area (junction pairs, circle intersections) and the pinhole test caps it at O(ε²)
  basis: prior + derived (A8b, K-AD (a))
  falsifier: R's first argument survives its own pinhole test as written
  registered: 2026-09-27
  status: open
```

### Cards held for the first round boundary

```
question: what-grows-along-a-vanishing-void-family
  evidence: FS106-AE-POLY excludes tight polygonal six-maps bar d = 2; FS106-AE-NICE's tight relaxation is "a GAP with C-AE-Q2" (`plans/FS106-derivation.md` l. 115); A2 §3.7: "every a.e.-proper Q2 map … gives a W sequence …, and not conversely"
  expected: a W family with vanishing voids has a limit that no theorem held already excludes
  ask: along a family whose uncovered density tends to 0, which quantity must be unbounded — faces per unit area, arcs per face, perimeter — and is a bounded-complexity family's limit already a Question 2 map?
  if bounded complexity suffices for W: W's success is C-AE-Q2 FALSE; R's defence is [G1]–[G4], and polygonal families are out bar d = 2
  if complexity must grow: both sides' content is the unbounded regime; R names where its argument uses no complexity bound, W names its complexity parameter
  answered by: derivation
  cost: an hour of hand work per side
  hunch: complexity must grow, and bounded-complexity families reduce to Question 2
  falsifier: a defect in X1's compactness step (a degenerate limit that is not a Question 2 map)
  rank: 1
```

*Timing:* sent to both sides at once after both step-naming answers are registered, so the registrations are made without it.

## Stage 1 — SAVED

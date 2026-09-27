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

## Stage 2 — SAVED: the two registrations, and the first card (both sides, 07:38 UTC)

**The registrations** (verbatim copies in `<scratchpad>/FS107-A2/`; R's also at `plans/FS107-R-stability.md` §1.6, `a3208286`).

| side | the other's step it expects to fail | its reason, in one line | what would show it wrong |
|---|---|---|---|
| W (02:35) | R′ = C-VOID, and break row 1 "whenever R reaches that measure through a void of fixed radius"; on LIM, C-T-L1b's collar (step 2) | C-VOID quantifies over every coverage; a void of inradius `ρ ≫ ε` already makes a junction look tight at distance 1; bounded local complexity gives voids `≥ ρ₀(complexity)` by compactness, with no uniform form | a proof of C-VOID with no complexity bound; or a family of its own whose largest uncovered disc stays `≥ ρ₀` as complexity grows for a reason not of its design |
| R (02:37) | break row 3, "a parameter shrinking the vertex voids" | (1) bounded combinatorial type → a polygonal a.e.-proper limit, excluded by FS106-AE-POLY bar `d = 2`, so the parameter must drive complexity to infinity; (2) at unbounded junction density `N`, complementary-type junction voids stop shrinking before `N·ε² → 0` | a formula family with inradius → 0 and density → 0 (refutes all); inradius → 0 at bounded coverage loss (retracts (2)); (1) only on a defect in AE-POLY |

**What surprised me: three independent derivations of one frame.** My X1 (committed at `731de025`, before either message), W's (3) and R's (1) all
split W's families by local complexity and send the bounded half to a regular limit. G51: first routes converge more often than they diverge; zero
retractions so far, which is not agreement — the disagreement has not started. The registrations are the two faces of one crux (void conservation,
FS107-A's E3): W expects C-VOID to fall, R expects the vertex void to stall. FS107-A's `round-one-is-about-c-void` is confirmed for the
registrations (not yet for the first cards).

**The shared slip (a frame-level correction, sent to both at once).** Both registrations lean on row 132 to exclude a bounded-complexity limit:
W's "regular tight colourings, which row 132 excludes (polygonal and convex tilings …)"; R's "(K-TIGHT, K-REG)" and "Shrinking Parts-type vertex voids
inside a fixed combinatorial type therefore cannot work". AE-POLY excludes polygonal limits (bar `d = 2`); but **K-REG's "not a nice map" overstates for
LIM**: FS106-AE-NICE holds for faces of diameter `< 1` whose same-colour faces are `> 1` apart, and "Its a.e.-proper relaxation … is a GAP with
C-AE-Q2". A tight limit of Parts-type members (curved sides, Siamese pairs, faces touching at distance exactly 1) is in the relaxation. So
R's conclusion about Parts-type families does not follow from (1) as written (Parts's sides are curved), and W's "row 132 excludes" covers only the
polygonal half. **Card `is-a-bounded-complexity-limit-excluded`** sent word for word to both (02:38), pointing at the rows, not at a fix; its branches:
excluded by a named theorem (the contest is all at unbounded complexity), or a C-AE-Q2 object (curved bounded families live; [G1]–[G4] decide them).

**Correction owed (for the close; the claim list is the planner's):** `data/fs107/claims.md` §2 K-REG, "not a nice map" → "not a nice map in
`[Thomassen1999]`'s sense (faces of diameter `< 1`, same-colour faces `> 1` apart); the tight relaxation is a GAP with C-AE-Q2 (FS106-AE-NICE)".

**Retractions:** R 0, W 0, Poros 0.

**Hunch ledger, updated.** `bounded-complexity-families-keep-their-voids`: **amended in place** — as registered it said "unless S–V Question 2 fails
almost everywhere"; the polygonal half is a theorem (AE-POLY bar `d = 2`), the curved half *is* Question 2. Status open. `w-first-family-has-bounded-complexity`:
**at risk** — both sides now reason from the complexity split, so W's first family may carry a complexity parameter from the start (its falsifier).

## Stage 2 — SAVED

## Stage 3 — SAVED: the first card's answers (07:40–07:43 UTC)

- **Both sides took the second branch, by derivation, and each retracted one sentence, free** (verbatim in scratch):
  - W retracted its registration's item (3), "families of bounded local complexity converge to regular tight colourings, which row 132 excludes";
    what survives: the bound holds for polygonal and convex limits only (FS106-AE-POLY bar `d = 2`, FS106-AE-CONV). W's stage 2 goes to curved
    bounded families, decided by [G1]–[G4].
  - R retracted "Shrinking Parts-type vertex voids inside a fixed combinatorial type therefore cannot work"; part (1) survives for polygonal limits,
    part (2) (the complementary-junction void) stands.
- The owner applied the K-REG correction to `data/fs107/claims.md` (`e5ab02f5`), symmetric for both; inventory items 13–14.
- **Retractions: R 1, W 1, Poros 0**, both killed by one card (the first contest is between each side and the constraint list, not between the
  sides — the disagreement proper has not started).
- **What I watch next (X6, the plan's ranking).** The card made C-AE-Q2 the live ground for bounded curved families. It is **asymmetric**: a W family
  of bounded curved type with vanishing voids is decisive (it refutes C-AE-Q2 a.e. and meets W, `χ(ℝ²) ≤ 6` with no MR); R closing [G1]–[G4] only
  defeats that class and is not decisive (X6: "Rank R-S's special cases (Q2, AE-FA) below the equivalence; they are tools, not targets"). If R's
  stage 2 makes Q2 its target, the next card (to both) asks which of each side's next steps is decisive if it lands and which only closes a class.
- `bounded-complexity-families-keep-their-voids`: its polygonal half confirmed by both sides' derivations (AE-POLY), its curved half is C-AE-Q2 —
  status open, now shared frame.

## Stage 3 — SAVED

## Stage 4 — SAVED: R's stand-down (07:55 UTC), its card answer, and my hunches scored against it

- **R handed back at its budget** (stage 4 saved; report `data/fs107/reports/FS107-R.md`, `ef74449a`). Owner's rulings: R's stage 5 (reading W's record)
  goes to my comparison after W's hand-back; a blind verifier FS107-V checks R's four lemmas and RR's implication (I never contact it).
- **R's retraction 2** (free, self-found before commit): the draft "Theorem OB" — "Voronov's bicycle branch is of hitting form, so every bicycle
  argument is capped at `O(ε)`" — withdrawn; both premises false (TS's C-T-L1 excludes the swap at Jordan interfaces; an `ε`-strip legalises one colour
  only). **Retractions: R 2, W 1, Poros 0.**
- **R's answer to my second card** (`does-the-complementary-pair-cost-survive-parts`, sent 02:56): the first branch. Lemma CP needs cone scales
  `s ≤ s₀ = µη²/100` and voids `2r < t₁ = s·sin(µ/2)/3`; at `µ = η = 1/2`, `s₀ ≈ 1.3·10⁻³`, `t₁ ≈ 10⁻⁴`, against Parts's void half-diagonals 0.0055 and 0.0133.
  So Parts's junctions are not fat at any admissible scale and the bound (`≈ 10⁻⁸`) is far below `δ₆`: the calibration passes because the lemma bites
  weakly. R's own consequences: "scale-invariant" should read "cost of order `min(s, s₀)²`, independent of `ε`"; a sharp `s₀` is the real question;
  whether Parts has complementary pairs within distance 2 is R's P1 (0.9), unscored.
- **What R left (read from `plans/FS107-R-stability.md` §§3–4, which my brief permits):** Lemma SAT (holes WLOG the open six-sighted set), Lemma CP
  (complementary fat junctions within `[η, 2 − η]` blocking toward a common unit point cost `≥ (t₁ − 2r)(t₁′ − 2r′)`, independent of `ε`, repair-robust),
  Lemma SW (a flat same-multicolour unit pair costs `≥ εs`; the swap `≳ s³` a sketch), Theorem OB′, and **reading RR: R follows from (A) a forced
  complementary pair in every `U_R` and (B) a cone-scale lower bound**; W's only escape is cone scale → 0 at every complementary pair (K-TAN's exceptional
  set at every scale) or no complementary pair within `[η, 2 − η]` (a K-C6 family). R flags G82's reading at risk: (A) + (B) would be a feature-local proof.
- **Teasing hint to W** (movement only): R has handed back with GAPs at named steps, a reduction to two open statements and a repair-robust local
  lemma under blind verification. Nothing of CP's mechanism carried; W already holds its qualitative content as K-TAN + K-C6.

**My hunches, scored against R (G21: the ones I like at the rate of the ones I do not).**
- `r-first-mechanism-is-local-and-pinhole-killed` — **killed** (by: Lemma CP, `plans/FS107-R-stability.md` §3.2, pending V). R's first surviving mechanism
  *is* local (a junction pair) but its cost region has width `≍ s`, the cone scale, not `ε`: a pinhole at the certificate does not legalise it. My
  stage-1 X2 assumed the forbidden regions near the circle intersection have width `O(ε)`; that holds for *point* junctions and fails for fat ones,
  whose swept annuli have width set by the cones' radial extent. **The mechanism of the miss:** I priced the junction as a point (A8b's picture), not
  as three cones. The pinhole test stays right as a test; my prediction of its verdict was wrong. Cost of the miss: nothing paid (no card rested on it).
- FS107-A's `rq-collapses-to-rs` — **at risk, not killed**: CP is an `ε`-independent bound anchored at junction pairs with no limit, but R's (B) asks a
  cone-scale lower bound "on a set of positive measure", which is link 6's regularity question — the collapse is into regularity, not into LIM.
- FS107-A's `void-conservation-is-the-crux` — **supported**: RR's (B) is a void-conservation statement in cone form (a fat junction can shed its cone
  scale only by degenerating).
- FS107-A's `complementary-type-is-the-combinatorial-core` — **supported**: RR's (A) is C-T-PIG on SEQ, in K-C6's terms.
- `bounded-complexity-families-keep-their-voids` — unchanged (open, shared frame).

**For the close (inventory, sent to the owner):** G82's reading scored against RR if (A) or (B) lands (R's flag); my killed hunch and its mechanism.

## Stage 4 — SAVED


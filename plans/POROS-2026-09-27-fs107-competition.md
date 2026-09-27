# Poros — FS-107's competition: stability against near-colourings (job FS107-A2, the competition advisor, 2026-09-27)

*Brief: `data/fs107/briefs/A107b-advisor-competition.md`, with `data/fs107/briefs/STANDING-RULES.md`. I advise competitors FS107-R
(`a2f348a65ca488876`) and FS107-W (`a76f4de5963be17de`) identically, under `plans/PROTOCOL-competitor-and-advisor.md` §1. I inherit the planning
advisor FS107-A's record `plans/POROS-2026-09-27-fs107-stability.md` (stood down at its stage 3, `cfda4ace`). Identity: `~/source/poros/CLAUDE.md`.*

**Fence note:** this record holds my expectation of where each side breaks. Both competitors and any blind verifier are fenced from it (the owner's
launch message: "fenced for both competitors"). My raw competition notes (cards received, verbatim) stay in `<scratchpad>/FS107-A2/` until both sides
have handed back (brief item 5).

## Theorems this phase proved

- None. X1 (stage 1) was a sketch; its content is W-EQ-K and W-POLY, proved by FS107-W (one mind). My results are comparisons and
  scorings (stage 5), not theorems.

## Would-have-searched-here log (standing rule 3)

- None: no move of mine would have been a search.

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

## Stage 5 — SAVED: the comparison (both sides' stage 5, done here at the owner's ruling, after both hand-backs)

*Read in full after both hand-backs: `plans/FS107-R-stability.md` (stages 1–4), `plans/FS107-W-near-colourings.md` (stages 1–4),
`data/fs107/reports/FS107-R.md`, `FS107-W.md`. Both blind verifiers (FS107-V on R, FS107-VW on W) are running; nothing here was sent to either.
Every result below is one mind unless marked, and waits on them.*

### 5.1 The round's verdict: where the two programmes meet

**Both claims are GAP, and their open steps pair up exactly.** R's reduction RR ("R follows from (A) a forced complementary pair of fat blocking
junctions in every `U_R`, and (B) a cone-scale lower bound", R §3.4) and W's two doors ("vanishing holes lie inside the generator image by exactly two
doors: (A) a full tight a.e.-proper six-colouring of bounded arc complexity, or (B) unbounded complexity", W §2.1) are the same split seen from the two
sides:

| | R needs | W escapes by | the one object and rule where they meet |
|---|---|---|---|
| **bounded complexity** | (A): some complementary pair of fat junctions at distance in `[η, 2 − η]` blocks toward a common unit point | door (A): a full tight arc-bounded six-map (W-EQ-K: at complexity `K`, vanishing holes ⟺ such a map exists), whose complementary-type vertex pairs within distance 2 are **all tangent or bowtie** (W-TAN) | **the tangency-seam question**: is there a planar six-coloured map, tiles of diameter `≤ 1`, classes `≤ 0.2470`, same-colour tiles Siamese or `≥ 1` apart, whose complementary-type vertex pairs within distance 2 are all tangent pairs or bowties (and whose equal-type pairs in `(1, 2)` survive K-KILL's second half)? NO ⟹ door (A) is dead at every `K` and C-AE-Q2 holds a.e. for locally finite arc-bounded maps; YES ⟹ a candidate door-(A) design, to be eroded and checked exactly |
| **unbounded complexity** | (B): junction cone scales `≥ s₀` on a set of positive measure | door (B): cone scale → 0 at every complementary pair — tangencies, bowties or cusps at every scale (R §3.4: "W's only escape"; W §4.2 item 5: "untouched") | **REG-SCALE**: a cone-scale lower bound for near-optimal band-proper partial six-colourings (De Giorgi; `CLAUDE.md` link 6) |

**W-TAN and Lemma CP are one fact from two sides**: CP is C-T-TAN's cone case with an area (R), W-TAN is C-T-TAN read as a design rule (W). Both rest
on C-T-TAN (TS, one mind); CP is a second derivation of its cone case, **sighted** (R cites TS), so C-T-TAN's cone case stands at two minds, neither
blind, pending FS107-V.

**The registrations, made before either side built anything, bracket (B).** R's registered part (2): "I expect the voids at junctions of complementary
type within distance 2 (K-C6) to stop shrinking before that balance is met". W's registered reason (2): "nothing I can see ties that radius to a fixed
scale once the number of tiles near a junction is free". Each is the other's negation, and both are statements about the cone scale.

### 5.2 Convergences of truth

| finding | R | W | advisor | independent? |
|---|---|---|---|---|
| bounded complexity is a compactness question; polygonal limits are out bar `d = 2` | registration (1), retracted to polygonal | registration (3), retracted to polygonal/convex; W-POLY | X1 (committed `731de025`, before both) | three independent derivations of the split; the "curved limits are live" half came to R from my card, and W states it had it in notes before the card (unverifiable; recorded as W states it) |
| at bounded complexity W is the map question | used (retraction 1) | **W-EQ-K** proved (one mind) | hunch `bounded-complexity-families-keep-their-voids` | W's proof is the only derivation; my card was a sketch |
| complementary pairs within 2 are tangent/bowtie in the tight world | CP on LIM | W-TAN | FS107-A's C6, `complementary-type-is-the-combinatorial-core` | both over C-T-TAN; R and W independent of each other |
| holes can be taken to be the six-sighted set | Lemma SAT (saturation) | the hex control's diagnostic: 351 of 837 blank squares see `≤ 5` colours and "could individually take a colour" (W §1.4) | — | independent; SAT is the theorem, W's count its instance |
| the tight-world circle is two-colourable, so circle arguments are paid at scale `ε` | O2 | W-RATE / §1.3 (2): "on `T₁(x)` only the two colours whose tiles cross the line through `x` perpendicular to the direction are forbidden" | — | independent; both restate TS |

### 5.3 Divergences of truth: none found. Two divergences of scope

- **W §1.3 (2) versus CP.** W: a void of inradius `ρ ≫ ε` makes a junction look tight, "so the void's job is done at any radius ≫ ε". CP: at a fat
  blocking **complementary pair**, voids of radius `< t₁/2` leave a forced region of area `(t₁ − 2r)(t₁′ − 2r′)` at distance 1. Not a contradiction:
  W's statement is about one junction at exact distance (`t = 0`), CP about two junctions at offset `t ∈ [2r, t₁]`, where all three sector colours
  meet the circle (CP Claim 1). W's C-VOID-false expectation survives exactly where (B) fails.
- **W-TAN's range versus CP's.** W-TAN applies at every distance `< 2` (qualitative, tight); CP at `D ∈ [η, 2 − η]` with constants `s₀ = µη²/100`
  degrading as `η → 0`. The pairs near distance 0 and near 2 (the `d = 2` edge case) are covered by W-TAN's statement and by neither side's cost.

### 5.4 Divergences of route

- **R went from the proof side:** sort `[Voronov2023]`'s certificates by their tight form and by what a local repair does to them (R §2.1); keep the
  one that survives (the complementary pair, CP); price the one that does not (the bicycle, SW and OB′). Counterexample invariants (G79), plus one
  example invariant (SAT).
- **W went from the construction side:** the generator image first (X9), compactness at fixed complexity (W-EQ-K), then the crudest door-(A) probe
  (HX: the seventh hexagon absorbed by straight triangles into a six-chromatic junction), derived, registered, checked exactly, stalled
  (`δ*_HX = π/(42√3) = 0.0432`).
- **Neither touched door (B) / (B).** Neither built or refuted a family of unbounded complexity; neither tested C-VOID.

### 5.5 Retractions, final count (from the registrations on)

| mind | count | what, and what killed it |
|---|---|---|
| R | 2, both free | (1) "Shrinking Parts-type vertex voids inside a fixed combinatorial type therefore cannot work" — my card (FS106-AE-NICE's relaxation clause); (2) draft Theorem OB ("the bicycle branch is of hitting form") — R's own audit before commit (C-T-L1 excludes the swap; an `ε`-strip legalises one colour only) |
| W | 1, free | registration item (3), "regular tight colourings, which row 132 excludes" — my card |
| Poros | 0 retracted cards; **1 killed hunch** | `r-first-mechanism-is-local-and-pinhole-killed` (stage 4): I priced a junction as a point, not as three cones |

W also lost two of its own registered predictions (P-W1, P-W2: sign and corner slips in HX's geometry, each caught by the exact checker) and won the
third. **Three of the four retractions were the contest between each side and the constraint list or its own draft, not between the sides**: the
disagreement proper — (A) against the tangency seams, (B) against door (B) — was named by the registrations and never reached.

### 5.6 The break table (`claims.md` §4), scored

| row | outcome |
|---|---|
| 1. R: holes of `ε`-independent measure in some `R₀`-disc | not reached. CP yields an uncovered disc of radius `≍ s` (R §3.2, "(disc)") **given** (A) and (B); W built no family with uniformly spread holes |
| 2. R reads how holes sit relative to the colouring | **R's column met, in a form the table did not foresee**: CP's forced region sits at distance 1 from the junction pair, and shrinking the junction voids (`r → 0`) enlarges it (`(t₁ − 2r)` grows) — "a vertex void cannot shrink without a new void appearing elsewhere", with the new void one unit away. W's column (holes at vertices, shrunk with `ε`) untested: W's one family has no complementary junction |
| 3. W: a parameter shrinking the vertex voids | **fired first, on W's side, by W's own hand**: HX's `ρ` drives `δ` down to `π/(42√3)` and no further, set by the islands constraint (the tile's diameter against the tip's corner and the second-neighbour same-colour vertex at 120°). R's registered prediction (row 3) is confirmed in outcome; its mechanism (complementary-junction voids) is untested, HX's junctions being six-chromatic |
| 4. W: the Route II limit exists as a tight six-colouring | the meeting point: R's (A) is this row's R column on SEQ; W-TAN is its design form. Open |
| 5. the advisor's question | asked; both answered; retractions counted (5.5) |

### 5.7 Predictions scored

- **W's registration** (C-VOID fails first, expected FALSE): **untested** — HX's voids have radius `≥ 0.22`, consistent with C-VOID. Open.
- **R's registration** (W fails first at row 3): **confirmed in outcome** (HX-STALL), mechanism untested (part (1) retracted to polygonal; part (2) not
  reached).
- **R's P1** (Parts has no fat complementary pair costing `> δ₆`, 0.9): unscored ([external] coordinates); R's own reading of its card: at admissible
  scales CP bites at `≈ 10⁻⁸`, far below `δ₆`. **P2** (0.95): vacuously consistent with HX (no complementary types). **P3** (0.6): untested — HX avoids
  complementary pairs but keeps holes `≥ 0.043`, so it does not test (A) below that `δ`.
- **W's P-W1, P-W2 lost; P-W3 won** (W §3).
- **The planner's E1–E8** (`plans/FS107-stability.md` §5.3): E1, E2, E3, E6, E7 — not met. **E4** (R names an obstruction beyond HIT, PIX and the
  pinhole test, 0.45) — **met, weakly**: OB′ ("an argument that reads, at a swap, only the pairs of one colour is capped at `O(ε·s)`") is a new named
  class, of HIT's logical type. **E5** (W names a lower bound on the void for a named class of families, 0.40) — **met**: W-POLY (polygonal bounded
  designs, `δ ≥ δ₀(K)`) and HX-STALL. **E8** (first break where A2's table puts it, 0.50) — **half**: W at the junction void, yes; R's first break was
  at the bicycle branch (Theorem OB), a step the table does not list.
- **FS107-A's hunches:** `void-conservation-is-the-crux` — supported (CP's `2r` against `|Q|`; HX's two pairs balancing); `complementary-type-is-the-combinatorial-core`
  — supported (the meeting rule is W-TAN ≡ CP); `w-first-family-moves-the-void` — **confirmed in its first half by derivation** (HX-STALL: a positive
  floor), the migration clause not shown; `rq-collapses-to-rs` — at risk, not killed (the residue (B) is regularity, not the limit object);
  `round-one-is-about-c-void` — **killed** by its own falsifier (W's first family aims at door (A), not at C-VOID).
- **Mine:** `bounded-complexity-families-keep-their-voids` — **confirmed as an equivalence by derivation** (W-EQ-K, one mind; W-POLY its polygonal half),
  pending FS107-VW; `w-first-family-has-bounded-complexity` — **confirmed** (HX, two parameters, stalls at `π/(42√3)`); stage-1 X2 "W breaks at row 3
  for a reason of class" — **half**: row 3 yes, but HX stalled for a geometric reason inside the family (K-ISL), not by compactness;
  `r-first-mechanism-is-local-and-pinhole-killed` — killed (stage 4).

### 5.8 A lesson for the corpus (§G, for the close)

**"Feature-local" is not "`ε`-local".** G82's reading ("Voronov's contradiction is feature-local, so a stability proof must count a defect spread over
positive measure") and my own stage-1 prediction made the same conflation: both priced a feature at the band's scale. A8b's `O(ε²)` holds for **point**
certificates; a certificate built on **cones** of scale `s` costs `≍ s²` and survives every repair at scale `≪ s` (CP). The right reading: *a stability
proof must count a defect at a scale independent of `ε` — spread over positive measure, or at features whose own scale is bounded below*; the second
door is exactly (B). R flagged G82 at risk; I concur, and propose this rewording for the close (G82's killing test then reads: a proof of
`lim µ₆(ε) < 1` whose features' scale is not bounded below).

### 5.9 What FS-107's next round or its close should aim at (a decision in four parts)

- **The choice:** a second round on **the tangency-seam question** (5.1, bounded row), same split: R proves no tight six-map satisfies W-TAN together
  with K-KILL's equal-type half, K-DENS and the Siamese-or-`≥ 1` rule; W builds one with tangency or bowtie seams, erodes it and checks members exactly.
- **The alternative weighed:** a round on **REG-SCALE** (door (B)), which is where R must win in the end and where W's only route lies if door (A) closes.
- **Why the tangency-seam question first:** both sides' open steps converge on it; it is local (a rule on tile rings, by hand, within the ban and within
  Kooshi's finite-search ruling); a YES is decisive (`χ(ℝ²) ≤ 6` with no MR, through W-EQ-K); a NO answers `[SokolovVoronov2025]` Question 2 almost
  everywhere for locally finite arc-bounded maps — a question in print (§ Publication's second bar) — and kills every bounded-complexity W family; and
  door (B)'s escape is this rule repeated at every scale, so its answer is REG-SCALE's first lemma either way.
- **Confidence: medium.** The facts that would change it: FS107-V or FS107-VW finding a defect in CP, W-TAN or W-EQ-K (the meeting point rests on all
  three, and on C-T-TAN at two sighted minds); or a hand argument that the rule is satisfiable only by degenerating at every scale, which would make
  door (A) and door (B) one question and REG-SCALE the round.
- **Default:** if the owner does nothing, FS-107 closes with RR, W-EQ-K, the meeting point and the lemmas at one mind (after V and VW), and mints two
  stubs: the tangency-seam question (W's stub (ii) and R's (A), merged) and REG-SCALE (R's stub, W's door (B)).

### 5.10 For the close (inventory items, sent to the owner)

- result — the meeting point (5.1): RR's (A)/(B) ⟷ W's doors (A)/(B); W-TAN ≡ CP on LIM; the tangency-seam question — this record §5.1
- correction owed — G82's reading: "feature-local" → "a defect at an `ε`-independent scale" (5.8); R's flag concurs
- correction owed — `data/fs107/claims.md` W row: A2 §3.3's "Tight polygonal tilings … would do" has an empty hypothesis at bounded complexity bar
  `d = 2` (W §4.2 item 2; W-POLY); R's and W's K-REG proposal is already applied (`e5ab02f5`)
- prediction scored — the planner's E4 (weak), E5 (met), E8 (half); FS107-A's and my hunches (5.7)
- slip (mine) — my movement-only hint to W (stage 4) was sent after W's hand-back and resumed it; W re-handed back content-free. No content crossed;
  the harness routed my content-free hand-backs to W while W had last woken me
- slip — fence listings, both disclosed in the competitors' records: R listed `data/fs107/reports/` (saw `FS107-P.md`, unopened) and the names of
  `data/fs107/fs107-a/`, `fs107-p/`; W listed `data/fs107/reports/` (saw `FS107-P.md`, unopened). Neither opened a fenced file
- stub to mint — the tangency-seam question; REG-SCALE; SWAP-PRICE / bicycle-free Voronov (R); C-VOID's thin-hole refutation (W) — untested by either

## Stage 5 — SAVED


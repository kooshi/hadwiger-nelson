# FS-110 — the tangency seam: does a tight six-map exist whose close complementary vertices are all tangent pairs, bowties or cusps? (stub)

**[CLOSED 2026-09-27 — FS-110 closed at `plans/FS110-tangency-seam.md` §R-close (row 134): under Condition 5 no curved map six-colours the plane almost everywhere, the Condition-5 half of S–V Question 2 answered yes; the unit-arc half is FS-112, `plans/STUB-unit-arc-half.md`.]**

*Minted 2026-09-27 by the close planner FS107-C at FS-107's close (`plans/FS107-close-inventory.md` items 23, 25, 28–31; the owner's ruling, item 28:
"the tangency-seam question opens as its own milestone with a fresh reframe"). **Solver column: none** — derivation by hand; a candidate map given by
formula may be checked exactly (a check of a given object, allowed at all times), and nothing is searched (Kooshi: *"search for a finite graph is out.
It would be huge, not feasible."*; the ban on finite-witness search runs to 2026-10-01). Written for a session with zero conversation memory: read
`CLAUDE.md` § The aim and § Counter-priors first — they bind every job here — then `LEDGER.md` rows 131–133, `plans/FS107-derivation.md` and
`data/fs107/claims.md` (the definitions and the shared constraints).*

## Where this comes from, in plain words

Hadwiger–Nelson asks how many colours the plane needs so that no two points at distance exactly 1 share a colour; the answer is 5, 6 or 7. Given
measure rigidity (MR, `LEDGER.md` row 120) the plane's number equals a measurable one (rows 128, 130): the fewest colour classes, measurable, whose
same-colour unit pairs are null. Row 131 restated that as **stability**: let six classes avoid every distance in the band `[1 − ε, 1 + ε]`, and ask
whether the uncovered part of the plane (the *holes*) can shrink to nothing as `ε → 0`. If it cannot, `χ(ℝ²) = 7` given MR; if it can, `χ(ℝ²) ≤ 6`
with no MR at all.

FS-107 ran that as a contest. Competitor R tried to prove the holes cannot vanish; competitor W tried to build periodic colourings whose holes vanish.
Neither landed (both GAP), and their open steps turned out to be one object seen from two sides (`plans/POROS-2026-09-27-fs107-competition.md` §5.1):

- **W-EQ-K** (two minds, one blind): at bounded arc complexity `K` — tiles bounded by at most `K` circular or straight arcs of radius at least `1/K`,
  at most `K` tiles meeting each unit disc — vanishing holes exist **iff** a *full tight* six-colouring exists: a map of such tiles, every tile one
  colour, with the same-colour unit pairs a null set. Eroding such a map by `r` gives band-proper designs at every `ε < 2r` with holes `O(ε)`, so
  its existence gives `χ(ℝ²) ≤ 6` with no MR.
- **W-TAN** (two minds, one blind; over TS's C-T-TAN, one mind): in such a map (C¹ arcs), two vertices at distance `< 2` whose three-colour types are
  **complementary** (disjoint; in six colours disjoint triples are complementary, K-C6) must form a **tangent pair** — an interface tangent to the unit
  circle about a point `w₀` at distance 1 from both — or include a **bowtie** (one colour in two opposite sectors). **At a cusp vertex it is a GAP**
  (FS107-VW §4 item 4): a tile of angle 0 has density 0 at the vertex, so the vertex's essential type has two colours and C-T-TAN is silent.
- **FS107-R-CP** (two minds, one blind): on the sequence side, two fat complementary junctions at distance in `[η, 2 − η]`, both **blocking** toward
  a common unit point, force holes of area `≥ (t₁ − 2r)(t₁′ − 2r′)` independent of `ε`. A hole-free family must therefore make every close
  complementary pair non-blocking: tangent, bowtie, cusp — or let the scale go to 0 (that last door is FS-111).
- **Tangency may be no escape at positive scale** — FS107-V's candidate C5 (`plans/FS107-V-verification.md` §4.3), [tools, one instance, and a sketch;
  one mind]: "**Tangency is not an escape at positive scale** … So the exceptional set is exceptional only in the blow-up; at scale `s` a tangent ring
  still costs `≳ s²·s′ sin(µ/2)`." Sketch of the general claim, verbatim: "every ring junction blocks every direction, on one side or the other, at
  depth `≳ min(s·(angular margin), s²/2)`, unless a colour is a sliver near `θ ± 90°`." Killing test (V): "a ring junction and a direction `θ` with no
  forced band on either side." **It bears on the direction:** if the general claim holds, tangent seams are closed and the live seams are bowties,
  cusps and slivers — the question tilts toward NO.

## The question, in two forms (keep them apart: one is decisive, one is a relaxation)

- **Q-full (decisive).** Does a full tight a.e.-proper six-colouring of the plane by a locally finite map of bounded arc complexity exist?
  - YES: "a YES is decisive (`χ(ℝ²) ≤ 6` with no MR, through W-EQ-K)" (A2 §5.9).
  - NO: door (A) is dead at every `K`, and `[SokolovVoronov2025]` Question 2 is answered almost everywhere for such maps — a question in print.
- **Q-rule (the necessary conditions only).** A2 §5.1, verbatim: "is there a planar six-coloured map, tiles of diameter `≤ 1`, classes `≤ 0.2470`,
  same-colour tiles Siamese or `≥ 1` apart, whose complementary-type vertex pairs within distance 2 are all tangent pairs or bowties (and whose equal-type
  pairs in `(1, 2)` survive K-KILL's second half)?" — **with cusps listed beside tangent pairs and bowties** (VW's GAP; inventory item 30).
  - NO ⟹ Q-full NO: "door (A) is dead at every `K` and C-AE-Q2 holds a.e. for locally finite arc-bounded maps" (A2 §5.1).
  - YES ⟹ "a candidate door-(A) design, to be eroded and checked exactly" (A2 §5.1) — not yet a colouring: the rule is necessary, not sufficient (G21).

**Types.** Say which multicolour a vertex carries: the *essential* one (colours of positive density at the vertex) or the *closure* one (colours of
tiles whose closure contains it). They differ exactly at cusps; W-TAN's first clause holds for essential types, and is a GAP for closure types at cusps.
W-TAN's second clause (adjacent tiles' types pairwise intersect) holds for three-element types off `d = 2`; bichromatic vertices of degree `≥ 4` are
live (row 132: where hole-filling fails).

## The seams to decide, one by one

1. **Tangent pairs.** C5 in general — prove it, or find the ring junction and direction with no forced band.
2. **Bowties.** Where the printed index method dies: C-AE-Q2's [G2] (Cor. 2's annulus at a bowtie) and [G4] (a unit-arc interface facing a bowtie:
   complementary curves swap, `|ΔInd| = 2`, FS106-IND-X). The likeliest live seam.
3. **Cusps.** C-T-TAN with closure types at a zero-angle tile (VW's GAP; named in no earlier list).
4. **The same-type half — SWAP-PRICE, "bicycle-free Voronov", folded in here.** Q-rule's "equal-type pairs in `(1, 2)`" is `[Voronov2023]` Lemma 6.1
   branch (i), the bicycle, and K-KILL's same-multicolour half is a GAP. R's routes (`plans/FS107-R-stability.md` §3.4): **(A″)** price the swap's
   two-colour cost `≳ s^k` — at a flat swap `k = 3` is proved (`≥ s³/256`, FS107-R-SW, V's proof) — and S–V's deformed annulus (TS [G2]); or re-route
   branch (i) to end at a complementary pair: "in the overlap of the two deformed annuli about same-type junctions `u, v`, any junction of the three
   complementary colours is complementary to `u` at distance `≈ 1`, so it is priced by CP" (R). C-T-BIKE: the pure `π/3`-arc ansatz fails narrowly at
   `d = 1.9` (R §3.6), the general tight two-colouring of a circle unused. **Why here and not its own stub:** FS-110's NO must kill equal-type pairs as
   well as complementary ones, and on the limit object that is this step; FS-108's item 2 (S–V Lemma 3's transplanted bicycle at `√3 ≤ d < 2`) is its
   print residual, so FS-108 and FS-110 share it and the planner should read both.

## The contest's shape (for the planner; protocol `plans/PROTOCOL-competitor-and-advisor.md` §1 as amended at FS-107's close)

A proof side (NO: no map meets Q-rule, seams 1–4) against a construction side (YES: a map with tangent, bowtie or cusp seams at every close
complementary pair — the owner notes Townsend's ⅔π counterexample already lives among maps with such seams, item 28 — eroded by VW-ERODE and checked
exactly by W's and VW's checkers, `tools/fs107_w_check.py`, `tools/fs107_vw_grid_check.py`, and VW's ℚ(√3) design checker). A blind verifier on each
side (FS-107's lesson: every divergence of truth came from a blind mind).

## Registered expectations of the minting session (instruments for G21, never caps; the planner re-registers)

| outcome | p |
|---|---|
| C5's general claim holds (tangent seams closed at positive scale) | 0.7 |
| the milestone decides Q-rule at one mind or more | 0.3 |
| Q-full YES (a tight six-map exists) | 0.05 |
| a named obstruction on either side (a seam priced, or a seam shown realisable) | 0.7 |

**Failure clauses:** a NO for trivalent maps only is a result, not the question (bichromatic vertices of degree `≥ 4` stay live); a NO that uses a
per-tile complexity count alone meets VW's (Ct) compactness GAP; a YES candidate that fails the exact check measures the candidate, not the question.

## Deliverables

The rule stated exactly with types defined; seams 1–4 each proved closed, shown realisable, or a named GAP; a `plans/FS110-derivation.md`; a
visualiser if a candidate map appears (tiles, seams marked by kind, the band annulus about each close complementary pair). Lean: W-EQ-K and FS107-R-CP
are FS-101 stubs; whichever half lands is formalized with no declared purchases.

## Bearing on the answer

Decisive both ways at bounded complexity: YES gives `χ(ℝ²) ≤ 6` with no MR; NO closes door (A) and answers S–V Question 2 almost everywhere for
locally finite arc-bounded maps. Unbounded complexity is FS-111 (the cone scale), whose escape is this rule repeated at every scale, so FS-110's answer
is FS-111's first lemma either way (A2 §5.9).

## Provisional bearings (replaced by the re-grokking at the opening)

G82 as corrected at FS-107's close (price a certificate at its feature's scale, never at `ε`'s); G79 (W-TAN is the flip: C-T-TAN's no-go read as the
rule every solution carries); G21 (a list of exceptions measures its class — cusps were missed once); G71 and row 132 (the index; the swap at a
bowtie); G22 (where a six-colouring cannot live); G13 (fans at a vertex); G2 (rings about a point); G72 (the structural form: what every tight map
carries at its vertices); G51 (a construction against a proof). Rows 131–133; FS106-TAN, FS106-IND-X, FS106-AE-Q2, FS106-TS-U. Stubs: FS-111,
FS-108 (item 2), FS-109, FS-101.

*Would have searched here:* a search for a map meeting Q-rule — derive the local picture at each seam instead.

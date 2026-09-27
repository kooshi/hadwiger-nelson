# FS107-W — competitor W of FS-107: near-colourings whose holes vanish (job FS107-W, Opus 5.5)

*Brief: `data/fs107/briefs/W107-near-colourings.md`, with `SHARED-107-competition.md` and `STANDING-RULES.md`, read from disk in full,
2026-09-27 07:2x UTC. `CLAUDE.md` § The aim and § Counter-priors read from disk (rule 0). Object: SEQ. Fenced and untouched: R's record and
working directory, the advisor records named in SHARED § Fences and `plans/POROS-2026-09-27-fs107-competition.md`, the close inventory,
`data/fs107/reports/` (my own report excepted, written at the end), transcripts, `chats-bak/`, scratchpad files I did not create. My scratch:
`<scratchpad>/FS107-W/` only. Fence touches: **none**. (`ls data/fs107/briefs/ data/fs107/reports/` at the start listed `FS107-P.md` in
`reports/` by name; the file was not opened. Logged as a listing of a fenced directory, disclosed here.)*

## Theorems this phase proved

| id | statement | grade | address |
|---|---|---|---|
| W-CHK | `tools/fs107_w_check.py` decides band-properness of a periodic closed-grid-square partial colouring exactly (integer arithmetic on squared distances; the distance set of two closed squares at index offset `(dx, dy)` is the interval `[h√(gx²+gy²), h√((|dx|+1)²+(|dy|+1)²)]`, `gx = max(|dx|−1, 0)`) | [tools], exact | stage 1 |
| W-EQ-K | At bounded arc complexity `K`, band-proper designs with `ε_n, δ_n → 0` exist iff a full tight a.e.-proper six-colouring by tiles of complexity `≤ K` exists (⟸ with `δ(ε) = O(ε)`) | [hand, one mind] | §2.2 |
| W-POLY | Polygonal designs of bounded complexity have `δ ≥ δ₀(K) > 0` at every slack, bar FS106-AE-POLY's `d = 2` case | [hand, one mind; over AE-POLY (two minds, one blind; SV-L3 a sketch)] | §2.3 |
| W-RATE | A full tight colouring gives `δ(ε) = O(ε)`; `O(ε²)` if its contacts are isolated and transversal — the floor's order; R's pinhole test is the test against these | [hand, one mind] | §2.4 |
| W-TAN | In a full tight six-colouring by a locally finite map, complementary-type vertices at distance `< 2` are tangent pairs or bowties; off those, adjacent tiles' vertex types form an intersecting family | [derived, one mind; over C-T-TAN (one mind)] | §2.5 |
| HX-STALL | Family HX (hexagonal seven-colouring, colour-0 hexagon absorbed by straight triangles, a void of radius `ρ` at its centre): band-proper iff `ρ > max(2R − √((1−ε)² − 3R²), √((1+ε)² − 3R²) − R)` against the two named pairs (and the design's other pairs, checked at members); its holes stop at `δ*_HX = π/(42√3) = 0.0432`, at `R = 2/√21`, `ρ = R/2` | [hand, one mind; four members checked exactly, prediction P-W3 won] | §3.3–3.5 |
| W-HEX | The rasterised hexagonal seven-colouring with one class blank (`u = (31, 0)`, `v = (15, 27)`, `h = 1/40`) is a periodic grid-square partial six-colouring with exact slack `1 − √1322/40 ≈ 0.0910` and uncovered density exactly `1/7` | [tools], exact | stage 1; `data/fs107/fs107-w/report-hex7m1-h40-e20.json` |

## Would-have-searched-here log (standing rule 3)

| # | the move a search would have made | what I did instead |
|---|---|---|
| 1 | Greedy-fill the hex member's holes (351 of 837 hole squares can individually take a colour) to see how far coverage rises | Recorded the count as a diagnostic only; a fill procedure is a colourer, out under the ban and not W's route (members are given by formula) |
| 2 | Scan HX's spacing `D`, void `ρ` or triangle shape for a smaller stall | Derived the stall exactly (3.3) and placed four members by the derivation |

## Stage 1 — SAVED: quotation check, restatement, the advisor's question, the checker

### 1.1 Quotation check (standing rule 5)

| quotation (where it appears) | source checked | result |
|---|---|---|
| W's statement, "for every `δ > 0` there are `ε > 0` and a **periodic** partial 6-colouring by half-open grid squares, …, leaving density `≤ δ` uncovered" (brief; claims.md §1) | `plans/FS106-TQ-derivation.md` §3.5 (e) | verbatim ✓ (the brief calls it "row 131's (e)"; the words are TQ's; row 131's own wording is "at most `δ`") |
| "Tight polygonal tilings in `[Parts2020c]`'s framework with voids tending to 0 would do, because TQ-SUP equates the tight and slack suprema" (claims.md; brief paraphrases it) | `plans/POROS-2026-09-27-fs106-close-and-fs107.md` l. 452 | verbatim ✓ |
| "The direction W relies on is the easy one."; "The only gap on this object is the hole gap."; "W's Route II limit, a tight a.e.-proper six-colouring in D-NF" (claims.md) | same file, ll. 455, 428, 429 | verbatim ✓ |
| "Parts's family has none: its voids keep a fixed size, one at every vertex (TQ §4.5 item 6)" (brief, paraphrase) | TQ §4.5 item 6 (b), (c) | faithful ✓ |
| K-BICH, K-C6, K-TAN, K-KILL, K-DENS, K-FLOOR (brief paraphrases) | claims.md §2 | faithful ✓ |
| "a corner-circle rule is only sufficient, §PA row 6" (brief) | plan §PA row 6: "whether that is the exact condition for whole cells is not checked here"; claims.md: "may be only sufficient" | **the brief overstates by one word** ("is only" for "may be only"); harmless — my checker uses the exact interval either way |
| "your claimed `δ(ε)` is never below `ε²/(6+ε)²` (FS106-EPS2, given V-1.3)" (brief) | claims.md K-FLOOR, the close's column | verbatim in substance ✓ |
| Kooshi: "A proven theorem about why its impossible is also valid. All novel knowledge is a success." (SHARED; rules 4) | `CLAUDE.md` § Where the problem stands, item 23 | verbatim ✓ |
| Kooshi: "search for a finite graph is out. It would be huge, not feasible." (SHARED; rules 3) | `CLAUDE.md` § Publication | verbatim ✓ |
| Kooshi (rule 0): "From here on out, you may doubt your ability … You are capable, and you will surprise yourself." | `CLAUDE.md` § Counter-priors | verbatim ✓ |
| FS106-AE-POLY, AE-CONV, AE-NICE, AE-CLOSED (used below) | `plans/FS106-derivation.md` ll. 98–115 | read from source ✓ |

### 1.2 Claim W, quoted and restated

*Quoted (TQ §3.5 (e), claims.md §1):* "for every `δ > 0` there are `ε > 0` and a **periodic** partial 6-colouring by half-open grid squares, with
no monochromatic pair at any distance in `[1 − ε, 1 + ε]`, leaving density `≤ δ` uncovered".

*Restated:* for each tolerance `δ`, some band width `ε` (allowed to depend on `δ` and to be as small as needed) admits a colouring of a periodic
grid of small squares — six colours on some squares, the rest blank — in which no two points of one colour, anywhere in the plane, are at a distance
between `1 − ε` and `1 + ε`, and the blank squares fill at most a `δ` fraction of the plane. The order is ∀δ ∃ε; the floor (K-FLOOR) forces
`δ ≥ ε²/(6+ε)²`, so a family meeting W has `ε(δ) ≤ ~6√δ`. With five colours in place of six the same family would give `χ(ℝ²) ≤ 5` — a different
outcome (G64), kept apart throughout.

*What it is not:* C-VOID's refutation (all voids small, coverage free) is weaker and decides nothing; a family with `δ` flat in `ε` (Parts's,
TQ §4.5 item 6 (c)) is a control, not a member of W.

### 1.3 The advisor's question, answered (registered by FS107-A2 at 07:35 UTC, verbatim in its record)

Sent to FS107-A2 by SendMessage; the text, verbatim:

> FS107-W's registered answer (stage 1): the step of R's programme I expect to fail first is R′ = C-VOID (claims.md §1), and with it break-table
> row 1's R step ("holes of ε-independent measure in some disc of radius R₀") whenever R reaches that measure through a void of fixed radius.
>
> WHY: (1) K-AD leaves R two doors, anchors of positive measure or holes of ε-independent size ρ₀; C-VOID is the second door, and I expect it
> FALSE, not just unproved, because it quantifies over every coverage: a counterexample need only make every uncovered disc small, not the hole
> area. (2) The local picture at a junction supports that: a void of inradius ρ with ε ≪ ρ makes the junction look TIGHT at distance 1 (on T₁(x)
> only the two colours whose tiles cross the line through x perpendicular to the direction are forbidden, not all three), so the void's job is
> done at any radius ≫ ε, and nothing I can see ties that radius to a fixed scale once the number of tiles near a junction is free. (3) What does
> give a void lower bound is compactness: families of bounded local complexity converge to regular tight colourings, which row 132 excludes
> (polygonal and convex tilings, except the d = 2 edge case), so their voids stay ≥ ρ₀(complexity). That bound depends on complexity and has no
> uniform form; C-VOID needs the uniform form, over families whose limit is wild, where no regular theorem applies. If R goes by the limit object
> instead, the step I expect to fail first is C-T-L1b's collar (its step 2), for the same reason: the limit need not be regular.
>
> WHAT WOULD SHOW I AM WRONG: a proof of C-VOID for grid-square members with no bound on complexity; or a family of mine whose largest uncovered
> disc provably stays ≥ ρ₀ as its complexity grows, for a reason that is not a design choice of the family (then the obstruction I name at stage 4
> is an instance of C-VOID, and I will say so).

*A correction to my own item (3), made at once from the advisor's card `is-a-bounded-complexity-limit-excluded` (received about 07:40 UTC; retraction sent 02:41):* row 132
excludes bounded-complexity limits only when they are **polygonal** (FS106-AE-POLY, bar `d = 2`) or locally finite **convex** tilings
(FS106-AE-CONV). Thomassen's nice-map theorem as held (FS106-AE-NICE, `plans/FS106-derivation.md` l. 115) needs "any two distinct faces of one
colour … at distance > 1"; its a.e. relaxation is "a GAP with C-AE-Q2". A tight limit of slack members has same-colour faces at distance ≥ 1,
possibly = 1, so **curved-boundary bounded-complexity families are not excluded by any held theorem** — I reached the same reading before the card
arrived (my notes: "tight nice maps with arcs … AE-NICE′ is GAP"); item (3) as sent said "nice maps" nowhere, but "regular tight colourings, which
row 132 excludes" overstated. **Retraction count: 1 (free; nothing rests on it).** This changes my stage 2: the live bounded-complexity class is
arc-bounded tight maps, and W's first obstruction theorem is scoped to polygonal/convex limits only.

### 1.4 The checker (brief item 3; X8) — `tools/fs107_w_check.py`, with `tools/fs107_w_members.py`

- **Input:** a member file — cell side `h`, claimed `ε`, the period lattice `Λ ⊂ ℤ²` (two basis vectors, grid units), one representative per
  coloured coset `[i, j, colour]`. **Scope decision (four parts):** *choice* — grid-square members only; *alternative* — general rational polygons
  with exact vertex–edge distances (would admit Parts-type tiles directly); *why* — W's claim is about grid squares, integer arithmetic makes the
  verdict exact with no geometry code to get wrong, and any polygonal tiling can be rasterised by formula; *confidence* — high; it changes if a
  family's natural members are curved and rasterising them costs more than `ε`.
- **Verdict (exact):** every ordered same-coloured pair `(p, p + Δ)`, `p` in one period cell, `Δ` in the band annulus (all offsets whose closed
  distance interval meets the closed band). Closed squares make the test slightly stronger than the claim's half-open ones; a pass here is a pass
  there. Exit 0 ACCEPT, 1 REJECT, 2 malformed (overlapping cosets refused).
- **Reported:** pairs checked; exact slack `ε*` (the colouring is band-proper for `[1−e, 1+e]` iff `e < ε*`; exact comparisons of the
  `1 − h√a` / `h√b − 1` forms); least margin `ε* − ε`; uncovered density and every class density exactly (K-DENS); the floor `ε²/(6+ε)²`; the
  junctions of D-JUNC (edge-connected components — the interior's; the corner-connected count beside it), their types (`r_J = h`), the least
  distance between complementary-type junctions (K-C6), and equal-type junction pairs whose distance interval meets `(1, 2)` (K-KILL).
- **Controls (`--self-test`, all pass, 4.8 s):**
  1. *Known positive* (faithful stub): the hexagonal seven-colouring with one class blank, rasterised — ACCEPT, 0 violations of 8,316,432 ordered
     pairs, uncovered density exactly `1/7`, every class `1/7`, exact slack `1 − √1322/40 = 0.09102 > ε = 1/20`.
  2. *Planted pair:* one blank square recoloured to the colour of a square in its band — REJECT, 840 ordered violations, **every one involving the
     planted square**, and `0 < 840 ≤ 3312` (two-sided bound).
  3. *Near miss:* same colour at min distance `1.2 > 1 + ε` — ACCEPT; at exactly `1 + ε` — REJECT (closed band's upper edge).
  4. *Exact band edge:* `h = 1/10`, `ε = 1/2`, offset `(2, 3)` has max distance exactly `1/2 = 1 − ε` — REJECT; one square nearer — ACCEPT;
     exact slack there `1 − √20/10`.
  5. *Overlap:* a second colour on a coloured coset — malformed.
  6. *Exact margin comparisons*, including an exact tie.
- **Faults planted in the checker (scratch copies; each caught for its own reason):** closed band made open at the lower edge — caught only by
  control 4; the violation test disabled — caught by 2, 3, 4; the gap formula understating distances by one square — caught only by control 3's
  near miss (the hex member still passes: its margin exceeds one square).
- **A hypothesis refuted by the tool (G21 on myself):** I asserted that every blank square of the hex member sees all six colours in its band. It is
  false: of 837 blank squares per period, 486 see six colours, 339 see five, 12 see four — so 42 % could *individually* take a colour. The histogram
  is now pinned as a regression control. (A joint fill is a colourer; not run — log item 1.)
- **The control's junctions:** one per period (the blank hexagon), type all six colours; six equal-type pairs meet `(1, 2)`, the least at
  `1.150`; no complementary-type pairs (no junction has a three-element type).

## Stage 1 — SAVED

## Stage 2 — SAVED: the generator image, its parameter count, and where vanishing holes can live

### 2.1 The generator (X9, written before any member of the family is checked)

Every W member I build is produced in three steps, each a formula:
1. **A design** `P`: a periodic partial six-colouring of the plane by closed tiles, each bounded by at most `K` circular arcs (radius `≥ 1/K`)
   or segments, at most `K` tiles meeting any unit disc, periodic under a lattice. Its parameters per period cell: the vertex coordinates
   (`2V` reals), one curvature per boundary piece (`E` reals in `[−K, K]`), the colours (discrete), and the period lattice (4 reals) — finitely
   many, `2V + E + 4`.
2. **Slack**: erosion by `κ` (TQ-ERODE: slack `2κ`, cost `≤ κ·L + O(κ²)`, `L` the boundary length density), or, where the design allows, a void
   of radius `O(κ)` only at each contact point (2.4). One real parameter.
3. **Rasterisation** at mesh `h ≪ κ` (Lemma T by centres: slack loss `≤ √2 h`, coverage loss `≤ h·L`). One real parameter.

The **generator image** `Γ_K` is the set of all rasterised members so produced from designs of complexity `≤ K`; the image over all `K` is
every SEQ member (a grid-square colouring is its own design, with `K ≍ 1/h`). **Parameter count against W's claim:** W quantifies one
tolerance `δ` and asks for one `ε(δ)` and one member; a family indexed by `n` must supply `(P_n, κ_n, h_n)` with `δ_n → 0`. At fixed `K` the
design space is finite-dimensional per period, so **vanishing holes lie inside `Γ_K` only if the design space at complexity `K` contains a
full tight colouring** (2.2). Outside every `Γ_K` (complexity unbounded) the image is all of SEQ and nothing is excluded by the generator.
So the generator image contains vanishing holes by one of exactly two doors: **(A)** a full tight a.e.-proper six-colouring of bounded arc
complexity, or **(B)** unbounded complexity.

### 2.2 W-EQ-K — at bounded complexity, W is the map question [hand, one mind]

**Theorem W-EQ-K.** Fix `K`. If band-proper designs `P_n ∈ 𝓜_K` (2.1, step 1) have slack `ε_n → 0` and uncovered density `δ_n → 0`, then
there is a full a.e.-proper six-colouring of the plane by tiles of `𝓜_K`: closed tiles covering the plane, bounded by `≤ K` arcs or
segments, `≤ K` meeting any unit disc, no two interior points of one colour at distance exactly 1. Conversely, such a colouring `M` gives, by
erosion and rasterisation, a W family with `δ(ε) = O(ε)` (with `ε ≍ κ`), and so `χ(ℝ²) ≤ 6` with no MR (I-EASY).

*Proof (⟹).*
1. *Centring.* By Route II's maximal-inequality step (TQ §3.3), translate each `P_n` so that every disc `B(0, r)` has uncovered measure
   `→ 0` as `n → ∞`.
2. *Compactness.* On `B(0, r)` the tiles of `P_n` are `≤ K(r + 1)²·const` sets, each bounded by `≤ K` arcs of curvature in `[−K, K]` whose
   endpoints lie in a bounded set: a compact parameter space (arcs degenerate to arcs, segments or points). A diagonal subsequence converges on
   every `B(0, r)`: each tile to a compact tile `τ_∞` of `𝓜_K` (zero-area limits dropped), boundaries in Hausdorff distance, hence the colour
   classes in `L¹_loc` (their symmetric difference lies in an `η`-neighbourhood of boundaries of bounded length).
3. *Covering.* `L¹_loc` convergence and step 1 give limit classes covering every disc up to a null set; closed tiles, finitely many per disc,
   so they cover everything.
4. *Properness.* If `p ∈ int τ_∞`, `q ∈ int τ′_∞` (one colour) had `|p − q| = 1`, take `r` with `B(p, r) ⊂ τ_∞`, `B(q, r) ⊂ τ′_∞`. The unit
   pairs in `B(p, r) × B(q, r)` have positive `Leb ⊗ σ` measure; those with an end outside `τ_n` or `τ′_n` have measure `≤ C(|B(p,r) ∖ τ_n| +
   |B(q,r) ∖ τ′_n|) → 0`. So for large `n` member `n` has a monochromatic pair at distance exactly 1, inside its band. Contradiction. ∎

*Proof (⟸).* In `M` each tile has diameter `≤ 1` and two tiles of one colour have cross-distances all `≥ 1` or all `≤ 1` (else an interval
of distances straddling 1 carries a positive measure of unit pairs); boundaries have finite length density. That is TQ-ERODE's hypothesis:
erosion by `κ` has no monochromatic pair in `(1 − 2κ, 1 + 2κ)` and costs `≤ κL + O(κ²)`. Rasterise (Lemma T). ∎

*What it says.* Bounded-complexity W is exactly S–V's map question in its a.e. form (C-AE-Q2 / FS106-AE-NICE's relaxation) at complexity
`K`: a family of mine at bounded complexity succeeds iff its designs converge to a full tight map, and fails iff no such map exists. **`[Parts2020c]`'s
framework is inside `𝓜_K`** (17-gons, wavy sides, curved pairs); his convergent refinements with fixed voids are numerical evidence
[external] that his symmetric class holds no full tight map.

### 2.3 W-POLY — polygonal designs of bounded complexity cannot make their holes vanish, bar `d = 2` [hand, one mind; over FS106-AE-POLY]

If every design is polygonal (all curvatures 0), the limit of 2.2 is a locally finite polygonal a.e.-proper six-colouring of the plane, which
FS106-AE-POLY excludes except at its `d = 2` edge case. So **for each `K` there is `δ₀(K) > 0` with `δ ≥ δ₀(K)` for every band-proper
polygonal design in `𝓜_K`, at every slack** (for slack `≥ ε₀` TQ-EPS2 gives `ε₀²/78`), unless a full polygonal tight six-colouring exists in
the `d = 2` edge case. *Grade:* [hand, one mind for the limit step]; AE-POLY's own grade (two minds, one blind; SV-L3's repair a sketch) and
its `d = 2` residual carry over. **Consequence for W:** a polygonal refutation needs complexity → ∞, or lives in the `d = 2` edge case.

### 2.4 W-RATE — how fast the holes of a door-(A) family would vanish [hand, one mind]

Let `M` be a full tight colouring as in 2.2.
- **Always `δ(ε) = O(ε)`** (erosion; the moats are thin holes, K-THIN).
- **`δ(ε) = O(ε²)` when every *contact* of `M` is isolated and transversal.** A contact is a pair `p, q` in the closures of tiles of one colour
  with `|p − q| = 1` (two tiles, or one tile's diameter). If near `p` and `q` the tiles are cones whose directions make `|p′ − q′| − 1 ≥
  c(|p′ − p| + |q′ − q|)` for `c > 0` (transversal), the band-violating pairs near the contact lie within `ε/c` of `p` and `q`: removing two
  discs of radius `ε/c` costs `O(ε²)`. Contacts that are tangent (distance growing quadratically) cost `O(ε^{3/2})` each; a *tight curve* (a
  boundary arc of radius 1 facing a point of the same colour, or two parallel sides at distance 1) costs `O(ε·length)`.
- **At a trichromatic vertex no void is needed beyond the contacts'**: the tight constraint there forbids, at `x + u`, the colours whose sectors
  meet the slab `|⟨v, u⟩| ≤ ε` (FS107-W §1.3 item (2); 2.5 below) — a slack-`ε` condition that a tight map meets wherever its colours near `T₁(x)`
  stay `≥ ε` off the shadow boundaries, i.e. away from tight curves.

**So the floor's order `ε²` (K-FLOOR, `ε²/(6+ε)²`) is exactly the rate of a door-(A) family with isolated transversal contacts, and R's pinhole
test (killing test 5) is a test against precisely these families:** an R argument that survives pinholes at the contacts cannot exclude them,
and one that fails the pinhole test is not wrong about them — it is capped at their rate. (A registration for the joint dial, FS-109: along a
door-(A) family, `1 − µ₆(ε)` falls like `ε²` with isolated contacts, like `ε` with tight curves; Parts-type tilings, which have curved pairs,
would fall at most like `ε` toward their `δ₆`.)

### 2.5 W-TAN — the junction rule a door-(A) design must obey [derived, one mind; over C-T-TAN, one mind]

Junctions of a full tight map are its vertices; K-BICH says a six-colour map has trichromatic ones. C-T-TAN (`plans/FS106-TS-derivation.md`
l. 258, verbatim in part): for `|u − v| < 2` and "`P(u) ∩ P(v) = ∅`, `|P(u)| = |P(v)| = 3`", with strong blow-ups, "If `T_u` and `T_v` both
have positive length, the configuration does not occur"; at cone points `T_u` is null only for "an interface at `u` tangent to the unit circle
about `w₀`" or "the bowtie". For a map every vertex is a cone point (strong blow-ups hold). Hence:

**Rule W-TAN.** In a full tight six-colouring by a locally finite map, every two trichromatic vertices of complementary types at distance `< 2`
are a tangent pair — at `u` or at `v`, a boundary ray perpendicular to `w₀ − u` (resp. `w₀ − v`) for one of the two points `w₀` at distance 1
from both — or one of them is a bowtie. **Adjacent tiles bring this rule everywhere:** two vertices of adjacent tiles are within `≤ 2` of each
other (each tile has diameter `≤ 1`), so, off tangencies, bowties and the `d = 2` boundary case, **the vertex types of any two adjacent tiles
form an intersecting family** (one triple from each complementary pair, K-C6).

*What it does to the design.* A generic map breaks the rule; a tight map is not generic (its constraints are equalities), so the rule is a
**design constraint**, not an impossibility: every complementary pair within distance 2 must be paid for with a tangency or a bowtie.
The global way to satisfy it with no tangency — every vertex containing one colour, as in the hexagonal tiling with colour 1 on the index-3
sublattice — gives colour 1 density `1/3 > 0.2470` (K-DENS), and its colour-1 hexagons sit `D/√3 < 1` apart, not Siamese: excluded twice. So a
door-(A) design must change its intersecting family from region to region, with tangencies or bowties at the seams. *Not done here (a stub
proposal, §4):* decide whether any planar map with six colours, tiles of diameter `≤ 1`, class densities `≤ 0.2470` and Siamese-or-`≥ 1`
same-colour pairs satisfies the adjacent-tile intersecting rule with no tangency at all — a finite local-rule question per tile ring, answerable
by hand derivation, never by enumeration (the ban; Kooshi's ruling on finite search).

### 2.6 The concrete family for stage 3 (by formula; a probe of door (A) at its crudest)

**Family HX(ρ): the hexagonal seven-colouring with the seventh class absorbed.** Hexagonal lattice spacing `D`, seven-colouring
`col(mu + nv) = (m + 3n) mod 7`; each hexagon of colour 0 is cut into six triangles (apex its centre `c₀`, base an edge), each triangle joins the
neighbouring hexagon across its base — every hexagon of colour `j ≠ 0` has exactly one colour-0 neighbour, in the direction `w_j` with
`col(w_j) = −j`, so every colour-`j` tile is a translate of one hexagon-plus-triangle `P_j` by the index-7 lattice. A void `B(c₀, ρ)` is left at
every centre; nothing else is uncovered. Parameters: `D` and `ρ` (and `h`, `ε`); `δ = πρ²/(7·(√3/2)D²)`. **The driving parameter is `ρ`**
(not the grid scale). The junction is six-chromatic: its type is all six colours.

*Hand analysis (registered before any member is checked; G21):* the binding pairs are (a) the tile's own diameter, far hexagon vertex to the
truncated tip, `≈ √(7/3)·D − 0.756ρ < 1 − ε`, and (b) the tip against the second-neighbour same-colour hexagon's vertex, `≈ (2/√3)·D + 0.5ρ >
1 + ε`. They are compatible only for `ρ ≳ 0.228 + 1.64ε` (first order in `ρ`), so **HX's holes stop shrinking at `ρ* ≈ 0.31` at `ε = 1/20`,
`δ* ≈ 0.08` — below the control's `1/7 ≈ 0.143`, bounded away from 0** (this sentence corrected in stage 3; the analysis it summarises was wrong — stage 3.1). **Registered prediction P-W1:** at `D = 0.775`
(`u = (31, 0)`, `h = 1/40`), `ε = 1/20`, members with `ρ ≥ 0.34` ACCEPT, `ρ ≤ 0.28` REJECT, the transition in `[0.28, 0.34]`, and the binding
offset at the transition is (a) or (b). *What P-W1 cannot mean:* HX is the crudest door-(A) probe; its stall says a six-chromatic junction
with straight absorbed triangles needs a void of radius `≍ 0.3`, nothing about curved designs. Its value is a checked, named stall.

## Stage 2 — SAVED

## Stage 3 — SAVED: members by formula, checked; the four killing tests

### 3.1 P-W1 scored: LOST

Six members at `D = 0.775` (`u = (31, 0)`, `v = (15, 27)`, `h = 1/40`), `ε = 1/20`, `ρ ∈ {0.38, 0.34, 0.32, 0.30, 0.28, 0.24}`: **all REJECT**. Exact
slack `1 − √1465/40 = 0.0431` at `ρ = 0.38`, falling to exactly 0 at `ρ = 0.30` (`1 − √1600/40`), always at a diameter-type offset
`(−31, 20…25)`. P-W1 said ACCEPT at `ρ ≥ 0.34`: lost on both halves. **The cause, found:** my first-order estimate ignored that truncating the
triangle leaves a **sliver** along the hexagon's edge whose far corner, not the arc, sets the diameter. Exactly, for the continuous design, with
`R = D/√3` the hexagon's circumradius and `s = 1 − ρ/R`:
- (a) the diameter is `R√((s + 1)² + 3)` (far vertex `F` to the arc endpoint `Q₋`: `F − Q₋ = 2R·e^{i150°} − sR·e^{i30°}`);
- (b) the tip to the second-neighbour same-colour hexagon's vertex is `2R + ρ` (collinear through `c₀`; my stage-2 `+0.5ρ` was a sign slip in
  the direction).

So HX at spacing `R` is band-proper at slack `ε` iff (to the design's other pairs, which the checker covers) `ρ > ρ_min(R, ε) = max(1 + ε − 2R,
2R − √((1 − ε)² − 3R²))`. The first term falls with `R`, the second rises; at `ε = 0` they meet where `√(1 − 3R²) = 4R − 1`, i.e. **`R = 8/19`,
`ρ = 3/19`**, and HX's holes stop at **`δ*_HX = π(3/19)²/(7·(3√3/2)(8/19)²) = 9π/(672√3) = 0.02429…`** (continuous design, `ε → 0`). The
checker's exact slack at `ρ = 0.38` (0.0431) matches formula (a) with rasterisation: `1 − R√((s+1)² + 3) = 0.0695` continuous, minus the
squares' reach.

### 3.2 P-W2, registered before the members below are checked

Members at `u = (58, 0)`, `v = (29, 50)`, `h = 1/80` (`D = 0.725`, `R = 0.4186`, near `8/19 = 0.4211`), `ε = 1/100`, `ρ ∈ {0.22, 0.20, 0.18,
0.16}`. Continuous slack `s_c(ρ) = min((a) 1 − √((2R − ρ)² + 3R²), (b) 2R + ρ − 1)`: `0.0478, 0.0347, 0.0172, −0.0028`; the binding pair
switches from (a) to (b) near `ρ = 0.191`. **P-W2:** the exact slack lies in `[s_c − 0.018, s_c]` (rasterisation costs at most `√2h`); ρ = 0.22,
0.20 ACCEPT; 0.16 REJECT; the binding offset is diameter-type at 0.22 and 0.20 and tip-type at 0.16. *Uninformative outcome, reachable:* all
ACCEPT or all REJECT would say the derived geometry is off again. *What it cannot mean:* anything about curved or non-hexagonal designs.

### 3.3 P-W2 scored: LOST — a third pair, located by the checker

All four REJECT (`ρ = 0.22` at a diameter-type offset; `ρ ≤ 0.20` at `(−64, −48)`, centres exactly 1 apart). Locating the violating squares
(diagnostic run, `data/fs107/fs107-w/report-hx58-*`): a tip square just outside the void, at the **corner** of the truncated triangle, against a
square near a vertex of the nearest same-colour hexagon — the second neighbour of the void's centre, at `√3D` in the direction **120° from that
corner**. Stage 2's (b) paired the other corner, collinear through `c₀` (at 180°); the nearer corner is at 120°. **Corrected (b′):**
`√(4R² + ρ² + 2ρR) > 1 + ε` (law of cosines at 120°). With (a) unchanged, and `S = √((1 − ε)² − 3R²)`, `S′ = √((1 + ε)² − 3R²)`:
`ρ_min(R, ε) = max(2R − S, S′ − R)`. At `ε = 0` equality `2R − S = S − R` gives `S = 3R/2`, **`R = 2/√21`, `ρ = 1/√21 = R/2`**, and

> **HX's holes stop at `δ*_HX = π(ρ/R)²/(7·3√3/2) = π/(42√3) = 0.04318…`** — the continuous design, `ε → 0`, over all spacings `D` and void radii
> `ρ` [hand, one mind; checked at members below]. The stall is two named pairs balancing: the sliver's far corner against the opposite hexagon
> vertex (the tile's diameter), and the tip's corner against the second-neighbour same-colour vertex at 120°.

*A note on the checker's output:* on a REJECTed member the reported "exact slack" is the least margin of a *square* pair, which saturates near
`−√2h/…` (a pair of squares spans a distance interval of length `≤ 2√2h`); it says "violated", not by how much.

### 3.4 P-W3, registered before these members are checked

Members at `u = (60, 0)`, `v = (30, 52)`, `h = 1/80` (`D = 0.75`, `R = 0.4330`, near `2/√21 = 0.4364`), `ε = 1/100`, `ρ ∈ {0.30, 0.28, 0.26,
0.24}`. Continuous slack `min((a), (b′))`: `0.0487, 0.0348, 0.0212, 0.0077`, (b′) binding throughout. **P-W3:** exact slack in
`[s_c − 0.018, s_c]`; `ρ = 0.30, 0.28` ACCEPT; `0.24` REJECT; `0.26` either; binding offset tip-type (b′) at every member.

### 3.5 P-W3 scored: WON

| member (`D = 0.75`, `h = 1/80`, `ε = 1/100`) | verdict | exact slack (predicted window) | uncovered `δ` (exact) | max class | junctions (per period) |
|---|---|---|---|---|---|
| `ρ = 0.30` | ACCEPT | `√6964/80 − 1 = 0.0431` (`[0.031, 0.049]`) | `451/5460 = 0.0826` | 0.1530 | 1, type all six; 6 equal-type pairs in `(1,2)`, least 1.373 |
| `ρ = 0.28` | ACCEPT | `0.0259` (`[0.017, 0.035]`) | `14/195 = 0.0718` | 0.1547 | same; least 1.415 |
| `ρ = 0.26` | ACCEPT | `0.0165` (`[0.003, 0.021]`) | `49/780 = 0.0628` | 0.1562 | same; least 1.451 |
| `ρ = 0.24` | REJECT at `ε = 1/100`; band-proper for `ε < 0.0007` | `0.0007` (`[−0.010, 0.008]`) | `29/546 = 0.0531` | 0.1578 | same; least 1.489 |

Every slack is of the min-distance form `h√n − 1` — the tip-type pair (b′), as registered. Member and report files:
`data/fs107/fs107-w/{member,report}-hx60-rho*-e100.json`. Continuous-design limit at this `D`: `δ → 0.0480` as `ε → 0`; at the optimal `D`,
`δ*_HX = π/(42√3) = 0.0432`.

### 3.6 The four killing tests on HX (claims.md §3, W's)

1. **Exact check:** every member above checked exactly (W-CHK); the family's band-properness for every `(ρ, D)` is the derivation 3.3, the members
   are its controls (G21) — three of three predictions about them scored, one won.
2. **Floor:** `δ ≥ 0.053 ≫ ε²/(6+ε)² = 2.8·10⁻⁶` at every member — passes, trivially.
3. **Class density:** every class `≤ 0.1578 < 0.2470` — passes.
4. **A driving parameter:** `ρ` drives `δ` down, **to `π/(42√3)` and no further** — **fails**. HX is not a W family; it is a named stall.

*Junctions (K-C6, K-KILL):* HX's one junction per period is six-chromatic (type all six colours), so no complementary three-element types exist
(K-C6 vacuous) and its equal-type pairs are its neighbouring voids at `1.37–1.49`, inside `(1, 2)` (K-KILL's same-multicolour case, a GAP on LIM,
is present at every member). A six-chromatic junction is the worst junction a six-colour design can have; HX was chosen as the crudest probe, and it
behaves as the crudest probe should.

*Would-have-searched log, item 2:* the natural next move — scan `(D, ρ)` or the triangle shape for a smaller stall — is an optimiser; instead the
stall was derived (3.3) and the members placed by the derivation.

## Stage 3 — SAVED

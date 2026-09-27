# FS110-YB — blind verification of the construction side (FS110-Y, FS110-Y2)

*Job FS110-YB, de Bruijn (Opus 5.5), 2026-09-27. Brief: `data/fs110/briefs/YB110-verify-construction.md` with its instance block
`data/fs110/briefs/YB110-instance.md` and `data/fs110/briefs/STANDING-RULES.md`. I edit only this file, `data/fs110/fs110-yb/` and
`tools/fs110_yb_*.py`. Grades are `CLAUDE.md` § Notation's. Every statement of the side is quoted from the instance block, which quotes the side's
record; that quotation is checked against the record at stage 4, after my verdicts are committed.*

## Theorems this phase proved

*(one line each, grade and address; the list is §3.2)*

## Would-have-searched-here log

- Y-BIKE-3C: I would have scanned the offsets `(φ, ψ)` of the two circles' 60° grids for a colouring whose cross curve passes through grid vertices
  (the case my argument leaves open). Instead: one candidate was derived by hand (a grid vertex at a point of the cross curve with `θ + η = 240°`,
  its swap partner then also a vertex) and checked at one `d`; the rest is recorded as a GAP (§3.6).

## Fence log

- No fenced path opened. `git log` read only as the start-up snapshot and my own commits.

## Stage 1 — SAVED: quotations, definitions, restatements, registered expectations

### 1.1 Quotation check (standing rule 5)

| quotation | source checked | result |
|---|---|---|
| the side's theorem tables and the four formulas (instance block) | `plans/FS110-Y-construction.md` | **fenced until stage 3**; checked at stage 4 |
| C-T-TAN, "Let `k = 6`, `\|u − v\| < 2` … the configuration does not occur" | `plans/FS106-TS-derivation.md` l. 258 | verbatim |
| TS-U, "a unit-arc boundary with colours `c \| c′` puts `c` in the wedge facing it …" | TS l. 15 | verbatim |
| K-CHR4, "**GAP** — proved for `\|P(x)\| ≥ 5` off a null set; `\|P(x)\| = 4` open" | TS §5 (l. 271) | verbatim |
| C-T-BIKE, "**GAP — undecided here**; the step named: …" | TS l. 258 table | verbatim |
| Cusp, "**a cusp is a cone point whose tile has angle 0**: its colour has density 0 …" | `plans/FS107-VW-verification.md` l. 285–287 | verbatim up to list punctuation (the source's first bullet is joined to the sentence) |
| V5, "**But a bichromatic vertex of degree `≥ 4` has a two-element type** …" | VW l. 210 | verbatim |
| `𝓜_K`, "periodic designs with at most `K` circular or straight arcs per tile …" | `plans/FS107-derivation.md` l. 11 | verbatim |
| Townsend ⅔π, "So the counterexample is right, and **sharp at `2π/3`**. It uses a boundary that is a **unit arc**" | `plans/FS106-V-verification.md` l. 374 | verbatim |
| Siamese, "two distinct tiles of one colour have all cross-distances `≥ 1`, or all `≤ 1` …" | claims.md cites `plans/FS107-stability.md` l. 348 | **mis-addressed**: l. 348 there is a staffing row; the sentence is verbatim at `plans/FS106-TQ-derivation.md` l. 348 (correction owed to `data/fs110/claims.md`) |
| A-EXACT, A-CIRC, A-SIX, C-TAN-POS (advisor's words) | `plans/POROS-2026-09-27-fs110-tangency-seam.md` | fenced to me; not checked |

### 1.2 Do the statements use the claim list's definitions?

| id | finding |
|---|---|
| Y-AEX, Y-CIRC, Y-TYPE | closure types `P_cl` named; consistent with §0 and §1b |
| Y-SIX | A-SIX's statement; consistent |
| Y-BLOCK | uses A-EXACT's `B_u(s)`; the shapes are the side's own vocabulary ("T1", "T2", "escape"), consistent with §2; **its "Hence C-TAN-POS TRUE" follows only from a complete list, and completeness "is not claimed"** — flagged for stage 2 |
| Y-T2W | "a pair saved at `w₀` by T2" — covering pair of unnamed type size; "`P(u)`" of unnamed kind — flagged |
| Y-BIKE-3C | "the bicycle" is C-T-BIKE's `T₁(u) ∪ T₁(v)`; "six-arc three-cycle colouring of each circle" is undefined in the table; I read it as: each circle cut into six arcs coloured `a, b, c, a, b, c` in circular order (either orientation), one palette of three colours for both circles |
| Y2-W4, Y2-W4e | "covering pair" per §0 (sizes (3, 3) or (2, 4)); "`P(u)`" of unnamed kind beside "`P_cl(w)`" — flagged; "no arc of `Γ` at `w`" read as Y2-W4's hypothesis (neither `ω(u)` nor `ω(v)` runs along a boundary into `w`) |
| Y2-S1, Y2-S1i | "(S1)" is the owner's configuration (fenced note); I read it from Y2-S1's parenthesis: a bowtie at `u` with boundary unit arcs of `ω(u)` through `w, w′`, a generic trivalent partner `v`, `w, w′` two-colour edge points |
| Y2-T2F, Y2-BB, Y2-MX | fragments; "tight" = some same-colour pair has 1 as an endpoint of its range (§0, D-SLACK, read on a fragment) |
| Y2-LAT | "one candidate, not the question" — scope stated |

### 1.3 Restatements (my words)

- **Fragments S1, T2, BB, MX:** finite families of open tiles, each bounded by segments and circular arcs with vertices in ℚ(√3), coloured by the
  given map; claimed: for every same-colour pair (a tile with itself included), 1 is not interior to the exact range of cross-distances, and some
  pair has an endpoint exactly 1.
- **Y2-W4:** where two circles `ω(u)`, `ω(v)` of a covering pair cross at `w` through tile interiors, the four half-branches at `w` carry four
  colours: the two `ω(v)`-branches carry two different colours of `u`'s type (the one inside `ω(u)` a colour that faces `w` at `u`, the other one
  that faces away), and symmetrically; hence `w` has at least four closure colours; and `ω(w)` near `u` is coloured by the leftover colour of `u`.
- **Y2-W4e:** (i) if `u` escapes strongly at `w`, then `ω(w)` near `v` is one colour or boundary; (ii) at a (2, 4) pair `ω(w)` runs along
  boundaries at the two-colour vertex.
- **Y2-S1i:** in any realisation of (S1) with `w` an edge point: the unit arc's two sides are `u`'s facing and away colours; `u`'s third colour
  fills both side cones (strong escape); where the arc stops on `ω(u)` there is a vertex with a colour of `v`'s type.
- **Y-T2W:** if T2 saves the pair at `w₀`, then `w₀` is a vertex of degree `≥ 4`, `ω(u)`, `ω(v)` alternate there, and the two `u`-colours at `w₀`
  are `u`'s inner arc colour (Siamese with it) and an outer colour (outer contact).
- **Y-BLOCK:** a list of shapes of `B_u(s) ∩ B(w₀, c)`; with it, C-TAN-POS at the level of disjointness.
- **Y-BIKE-3C:** no three-colouring of the bicycle whose restriction to each circle is a six-arc three-cycle pattern, for any `d ∈ (1, 2)`.
- **Y2-LAT:** the translation-invariant triangular-lattice extension of `BB` fails at its four-colour points.

### 1.4 Registered expectations (before any derivation; both outcomes named reachable)

| item | expected | P | the other outcome is reachable because |
|---|---|---|---|
| S1, T2, BB, MX rebuilt | ACCEPT, tight, each | 0.85 each | a closing segment of a tile can leave its angular sector, a quadrant square of side `1/10` can reach a blocking wedge, and a contact can sit on the wrong side of 1 at second order (T1 against T2) |
| Y2-W4 | first two clauses TRUE; the "one colour" clause MISSTATED at (2, 4) sizes or when `w` carries a third colour of `u` | 0.6 | the clause is a set difference whose size is not fixed by the hypotheses |
| Y2-W4e | TRUE, possibly weaker than what follows | 0.6 | it depends on Y2-W4's third clause |
| Y2-S1i | TRUE at (3, 3) | 0.65 | the arc's end can be a colour change along `ω(u)` rather than a vertex of `P(v)` |
| Y-T2W | TRUE under Y2-W4's hypothesis; GAP otherwise | 0.55 | T2 does not by definition exclude a unit arc of `ω(u)` into `w₀` |
| Y-BLOCK's "hence" | GAP at completeness | 0.7 | the shapes may be exhaustive after all |
| Y-BIKE-3C | TRUE or GAP | 0.5 | a colouring whose cross curve passes through grid vertices is not excluded by a band argument |
| Y2-LAT | TRUE for its candidate | 0.6 | the over-constraint may be a counting slip |

## Stage 1 — SAVED

## Stage 2 — SAVED: my own exact checker, its controls and plants, and the four fragments rebuilt from their formulas

### 2.1 The checker (`tools/fs110_yb_check.py`, written blind; digest `d672b5a6a3235987`)

Tiles are closed regions bounded by segments and circular arcs with vertices in ℚ(√3), arithmetic exact (`Fraction` pairs `a + b√3`). For a pair
of tiles the cross-distance range `[min, max]` has both ends on the boundaries, at a pair where each point is a piece end or satisfies the
first-order condition on its piece. The complete candidate list: **VV** (end–end), **VS** (end–interior foot on a segment), **VA** (end–nearest and
end–farthest point of an arc, the directions `±(p − C)`, kept only if on the arc), **SA** (segment interior–arc interior: `q = C ± r n̂`, `p` its
foot), **AA** (arc interior–arc interior, both on the line of the centres, four sign choices). Segment–segment interior pairs are parallel and
dominated by VS; concentric arc–arc interior pairs are dominated by VA (the overlap of the antipodal ranges ends at an arc end). Every candidate is a
genuine pair of closure points, so `min` and `max` are the extremes over candidates, exactly. Values are squared distances in ℚ(√3) or
`|√R² + k|` with `R², k ∈ ℚ(√3)`, compared with 1 exactly by squaring with sign guards. A pair REJECTs iff `min < 1 < max`; a contact is an end
exactly 1. **Pairs are generated from the colour map** — every same-colour pair, each tile with itself — and the count is asserted equal to
`Σ_c n_c(n_c + 1)/2`. For connected tiles "1 not interior" is exactly the Siamese-or-`≥ 1` rule for distinct tiles and diameter `≤ 1` for a tile
with itself; the checker reports which (`siamese`, `far`, `self`).

### 2.2 Controls and planted faults (`tools/fs110_yb_fragments.py selftest`; output `data/fs110/fs110-yb/selftest.out`) — SELF-TEST PASS

| check | result |
|---|---|
| ACCEPT control: the tight hexagonal seven-colouring, circumradius `1/2`, a 7 × 7 patch | ACCEPT, 196 pairs = expected, 49 contacts (every self diameter exactly 1); class density `1/7 ≤ 0.2470` |
| known-REJECT control: the same at circumradius `11/20` | REJECT, 49 rejecting self pairs (diameter `1.1`) |
| six candidate-type controls (VV, VS, VAfar, VAnear, AA, SA), each a same-colour pair designed so that exactly one candidate type shows `1` interior | each REJECTs through its own type |
| plants drop-VV, drop-VS, drop-VAfar, drop-VAnear, drop-AA, drop-SA | each flips its own control's pair to ACCEPT and changes no other control: fired for its own reason |
| plant arcs-as-full-circles | T2 goes REJECT (the arc-range test is live) |
| plant lost-self-pairs | the known-REJECT control's rejects fall to 0 (it would read ACCEPT) and **the count assertion fires** |
| plant lost-cross-pairs | the count assertion fires |

### 2.3 The fragments rebuilt from the instance block's formulas (`data/fs110/fs110-yb/fragments.out`)

Readings where the formulas are silent (mine, stated so the side's can be compared at stage 4): straight sectors "truncated at `1/4`" read as disc
sectors (arc of radius `1/4`), and checked again closed by chords; T2's and MX's arc-bounded tiles at `u` closed by segments from the arc ends
(half-angle `α = 2 arctan(1/8)`, `cos α = 63/65`, `sin α = 16/65`) to apexes at distance `1/4` from `u` in the directions 60°, 180°, 270° (T2) or
along the straight rays 60°, 240° (MX), and checked again with apexes at `1/5`; S1's `w`-tiles closed by the two segments to `(9/10)w`, `(11/10)w` as
written; `v = R(u)` and `w′ = R(w)` built by the half-turn `z ↦ (1, 0) − z` with `(1 4)(2 5)(3 6)`; MX's `w′` quadrants as listed.

| fragment | tiles | pairs (expected) | verdict | contacts at exactly 1 | variant |
|---|---|---|---|---|---|
| S1 | 11 | 18 (18) | **ACCEPT** | 4 | same with chord-closed sectors |
| T2 | 14 | 24 (24) | **ACCEPT** | 8 | same with apexes at `1/5` |
| BB | 16 | 30 (30) | **ACCEPT** | 8 | same with chord-closed sectors |
| MX | 15 | 27 (27) | **ACCEPT** | 8 | same with apexes at `1/5` |

Every contact is between a tile at `u` (or `v`) and a tile at `w` (or `w′`), at the vertex pair itself (`|u − w| = 1`); every other same-colour
pair has 1 outside its range with margin. **The side's four fragment plants, rebuilt from their one-line descriptions, each REJECT at the pairs the
side names:** T2 flip → `(u_1, wQ3)`, `(u_3, wQ1)`; T2 flat → `(u_1, wQ1)` with range `[0.9923, 1.3716]` (the side: `≈[0.992, 1.372]`); T2 six →
`(v_3, wQ2)`; BB rot → `(u_2, wQ3)`, `(u_3, wQ1)`.

**Map sanity** (`tools/fs110_yb_mapsanity.py`, float, not a verdict; output `data/fs110/fs110-yb/mapsanity.out`): no two tiles of any fragment
overlap on a 260 × 260 sample, and circles of radius `0.01` about `u, v, w, w′` are covered, with colours `u: {1,2,3}`, `v: {4,5,6}`, and at `w, w′`:
S1 `{2,3}`, `{2,3}` (two-colour edge points); T2 `{1,3,4,5}`, `{1,2,4,6}`; BB `{2,3,5,6}` both; MX `{2,3,4,5}`, `{2,3,4,6}` — as the formulas say.
Its plants (a duplicated tile; a removed sector) fire.

### 2.4 G21 audit of the ACCEPTs

An ACCEPT here is the flattering verdict, and a derived-distance checker fails toward it (a lost pair, a lost candidate type, an arc read too
short). Each of those failure modes has a plant that fired (§2.2). The fragments' verdicts are robust to the two closings I tried, and the contacts
are exactly where the local calculus puts them (TS-U's facing/away wedges, T2's inner arc colour against the inner quadrant). **What the ACCEPTs do
not show:** that any fragment extends to a map of the plane; they are local certificates at `u, v, w, w′` only, their truncation corners being
artefacts, as the side's scope ("fragment level", "locally") says.
## Stage 2 — SAVED

## Stage 3 — SAVED: my verdicts, derived from the statements alone (committed before opening the side's record)

Notation: `ê = w − u` for a common unit point `w`; "inside `ω(w)`" is the open unit disc about `w`. One lemma carries most of what follows.

**Lemma YB-L (branch exclusion)** [hand, one mind]. In a full tight a.e.-proper map colouring, let `z(t) → w` (t ↓ 0) be tile-interior points of
colour `j` on a curve through `w` transversal to `ω(u)`, and `S` a `j`-tile with `u ∈ S̄`. If the `z(t)` lie inside `ω(u)`, then `S ∩ B(u, ρ)` lies in
the closed disc `D̄(w, 1)`; if they lie outside, `S ∩ B(u, ρ)` lies outside the open disc. *Proof.* Inside: `|p − z(t)| → |u − z(t)| < 1` as `p → u`
in `S`; a point `p ∈ S` with `|p − z(t)| > 1` would give, along a path in the open connected `S`, a `p*` with `|p* − z(t)| = 1`, both points interior
to `j`-tiles, hence a positive measure of monochromatic unit pairs. So `|p − z(t)| ≤ 1` on `S` for all small `t`; let `t → 0`. Outside: the same with
the inequalities reversed. ∎ (Only interior points of `S` accumulating at `u` are used, so cusp tiles are included.)

### 3.1 Verdicts

| claim | verdict | grade, minds (mine) | the derivation, or where it fails |
|---|---|---|---|
| **Y-AEX** | **TRUE** with the interior reading; the disjointness consequence TRUE | [hand], one | Meeting an open tile is an open condition in `z`, so `B_u(s)` is open; a tile-interior `z ∈ B_u(s)` of colour `j ∈ P_cl(u)` meets a `j`-tile interior at distance 1. For a covering pair a point of `B_u ∩ B_v` has no admissible colour, so the open set `B_u ∩ B_v` lies in the null boundary: empty. With the closure reading every `z ∈ ω(u)` is in `B_u(s)`, so the set is neither open nor coloured outside `P_cl(u)` at tile-interior points of cusps' closures — the side's caveat is right |
| **Y-CIRC** | **TRUE**, cusp colours included | [hand], one | `x` tile-interior on `ω(u)` in a `j`-tile `T`, `j ∈ P_cl(u)`: a disc `D(x, r) ⊂ T`; points `p` of a `j`-tile at `u` with `|p − u| < r/2` have `|p − x| ∈ (1 − r/2, 1 + r/2)`, so `D(x, r)` holds points at distance exactly 1 from `p`, an open set of pairs. Uses only interior points accumulating at `u` |
| **Y-SIX** | **TRUE** | [read + hand], one | TS l. 258's proof uses the sizes once, at "(all six classes are in `P(u) ∪ P(v)`)"; its failure-set paragraph ("for three sectors") is size-specific, and I did not redo it for sizes 2, 4 |
| **Y-TYPE** | **TRUE** | [hand], one, trivial | a tile with a corner of positive angle at `u` has density `≍ angle/2π` there; a tile all of whose corners at `u` are cusps between arcs with one-sided tangents has area `O(r³)` in `B(u, r)` |
| **Y2-W4**, clauses 1–2 | **TRUE** | [hand], one | The `ω(v)`-branches at `w` are tile-interior near `w` (finitely many arcs in `𝓜_K`, none along `ω(v)` by hypothesis); by Y-CIRC their colours avoid `P_cl(v)`, so lie in `P(u)` (either kind of covering type). By YB-L, the branch inside `ω(u)` has a colour `j₁` all of whose `u`-tiles lie inside `ω(w)`, the outer branch a colour `j₂` all of whose `u`-tiles lie outside; an open tile cannot do both, so `j₁ ≠ j₂`. Likewise for `ω(u)`'s branches and `P(v)`. Four distinct colours, all in `P_cl(w)` |
| **Y2-W4**, clause 3 ("every tile-interior point of `ω(w)` near `u` has the one colour `P(u) ∖ P_cl(w)`") | **MISSTATED** | [hand], one | What holds (Y-CIRC at `w`, local finiteness at `u`): *every tile-interior point of `ω(w)` near `u` has a colour in `P_cl(u) ∖ P_cl(w)`; at a (3, 3) pair of closure types with `\|P_cl(w) ∩ P_cl(u)\| = 2` this is one colour, and if `P_cl(w) ⊇ P_cl(u)` there are no such points (`ω(w)` runs along boundaries at `u`).* As written it fails at a (4, 2) pair with `u` the four-colour end (two colours remain), and with essential types (a cusp colour at `u` lies in `P_cl(u)`, not in `P_ess(u)`) |
| **YB-V5X** (mine, new) | **TRUE** | [hand], one | *Under Y2-W4's hypotheses each end of the pair carries one colour all of whose tiles there lie inside `ω(w)` and another all of whose tiles lie outside. So a bichromatic vertex of degree `≥ 4` (sectors of positive angle) is never an end of a covering pair at a common unit point where `ω(u)`, `ω(v)` cross through tile interiors:* its two colours alternate, so between its two sectors of the "inside" colour lies a sector of the other colour, inside too. Bears on C-V5-K: (2, 4) pairs live only where a unit arc of `ω(u)` or `ω(v)` runs into `w`, or at cusps |
| **Y2-W4e** | **TRUE, weaker than what holds** | [hand], one | At (3, 3), closure types: by clauses 1–2, `P_cl(v) ∖ P_cl(w)` has at most one colour, so `ω(w)` near `v` is one colour or boundary — for **every** covering pair at such a `w`, strong escape or not. Its second half is vacuous under the hypothesis: by YB-V5X the bichromatic end cannot occur. With essential types it is a GAP at a cusp colour of `v` |
| **Y2-S1i** | **TRUE when `u`'s three colours have sectors of positive angle; GAP at cusps (clause (c))** | [hand], one | (a) `ω(v)` crosses the arc at `w` into both side tiles, so by Y-CIRC their colours `c, c′` lie in `P(u)`; TS-U puts `c` in the facing wedge, `c′` in the away wedge. (b) TS-U (iii): the two side cones hold neither; near `u` only `P_cl(u) = {a, c, c′}` occurs, so `a` fills both, straddling the tangent line with margin (the arc's angular half-widths at `w`): a strong escape. Needs `\|P_cl(u)\| = 3` (the trivalent partner gives it); at a (4, 2) pair the two cones may hold two colours — an escape, not a strong one. (c) At an end `x` of the arc the boundary cannot leave `ω(u)` with the same sides (`ω(u)` beyond `x` would be interior to `c` or `c′`, against Y-CIRC), nor continue along `ω(u)` with sides `(a \| c)`, `(a \| c′)`, `(c \| a)`, `(c′ \| a)` (TS-U on the continuation arc `[θ₂, θ₃]` excludes `a` from one of the old side cones, which `a` fills). **The swap `(c′ \| c)` is not excluded:** TS-U on the two arcs confines `c′` near `u` to the one direction `θ₂ + 90°` and `c` to `θ₂ − 90°`, which cusp tiles satisfy; then `x` is a bichromatic degree-4 vertex `c, c′, c, c′` meeting no colour of `P(v)`. So (c) holds when `c, c′ ∈ P_ess(u)`, and is a GAP for closure types at cusps |
| **Y-T2W** | **TRUE at (3, 3), closure types; GAP at (2, 4)** | [hand], one | At (3, 3) T2 excludes a unit arc of `ω(u)` into `w₀`: its sides `p, q` lie in `P_cl(u)` (Y-CIRC at `v`), and TS-U at `u` bars them from `u`'s side cones, which hold the sides `x, y` of the arc of `ω(w₀)` through `u`; so `P_cl(u) ⊇ {p, q, x, y}`, four colours. Then Y2-W4 applies: `w₀` has `≥ 4` colours, the branches alternate (transversal), and by YB-L the `P(u)`-colour on the branch inside `ω(u)` has all its `u`-tiles inside `ω(w₀)` (an inner colour of `u`'s arc; Siamese with contact at `(u, w₀)`), the other all outside (outer contact). "The inner arc colour" should read "an inner colour": `u` may have two colours inside `ω(w₀)` (MX's `u`: 1 and 2), the excluded one straddling. At (4, 2) the four-colour end can carry the unit arc into `w₀` (`P_cl(u) = {p, q, x, y}`), and then the `P(u)`-colours at `w₀` are the arc's sides, not `u`'s arc colours; not excluded here |
| **Y-BLOCK**, the shapes | **TRUE for the shapes I rederived; not all rederived** | [hand], one, partial | Rederived: the generic trivalent one-sided band (the chord of `ω(z)` near `u` at offset `h` meets every sector meeting the open half-plane on its side, so all three iff the third sector lies on that side); the escape; at (3, 3) **an escape is a strong escape** (a colour missed at `h > 0` lies in the closed far half-plane, one missed at `h < 0` in the near one, so the third colour holds neighbourhoods of both tangent directions); T2's thin double wedge about the tangent line of `ω(u)` at `w₀`; two-sided only at degree `≥ 4`. Not rederived: the depth constants of T1 and the cusp |
| **Y-BLOCK**, "Hence C-TAN-POS TRUE at the level of A-EXACT's disjointness" | **GAP at the list's completeness** | [hand], one | Two nonempty blocking sets that are one-sided bands, balls or T1 bands along transversal curves always meet near `w₀`; T2 wedges about different tangent lines do not; so the "hence" holds for the listed shapes. It needs the list complete, which the side does not claim. A named hole: the cusp shape `≍ s·\|τ·e_u\|` degenerates at `τ ⊥ e_u` (a cusp along the tangent line), where the list gives no shape |
| **Y-BIKE-3C** | **GAP at grid-vertex passages; TRUE for grids in general position** | [hand + measured], one | (1) A six-arc three-cycle colouring proper on one unit circle has every arc of exactly 60° (an arc longer than 60° holds a unit pair; six arcs sum to 360°). So the circles carry `f(θ) = σ⌊(θ − φ)/60°⌋`, `g(η) = σ′⌊(η − ψ)/60°⌋ + k` (mod 3). (2) The cross pairs form one closed curve `C` in `(θ, η)` (a non-Grashof four-bar `u, x, y, v`), and `f ≠ g` on `C`. Away from grid vertices the lift `F − G` moves by ±1 per grid line and must stay in two consecutive integers. For `σσ′ = +1` that needs range(`θ − η`) `< 180°` on `C`; measured `241°–359°` at `d = 1.01, …, 1.99`. For `σσ′ = −1`, on each line `θ − η = const` the admissible set of `θ + η` is a half-open interval of length exactly 120°, and the swap symmetry `(θ, η) ↦ (180° − η, 180° − θ)` of `C` keeps `θ − η` and puts two points of `C` on one such line `R` apart, `R` the range of `θ + η`; measured `R = 120.67°–327.7°`, above 120° at every sampled `d`. (3) **The GAP:** where `C` passes through a grid vertex the lift can jump by 2 without touching the forbidden value; `C` moves in both diagonal directions (measured), so these tunnels are available in both cases, and I did not exclude them. One derived candidate (a vertex at the point of `C` with `θ + η = 240°`, its swap partner then a vertex too) fails at `d = 1.9`; that is one candidate, not the case. The two range facts are measured at seven values of `d`, not proved |
| **Y2-S1** (fragment), **Y2-T2F**, **Y2-BB**, **Y2-MX** | **TRUE at fragment level**, tight | [tools, exact], my checker (§2) | 18, 24, 30, 27 pairs ACCEPT with 4, 8, 8, 8 contacts, robust to two closings each; the side's four plants REJECT at the pairs it names. C-T2 (i)'s cascade inside T2 is empty: `P(w) = {1, 3, 4, 5}`, `P(w′) = {1, 2, 4, 6}` meet each other and `P(u)`, `P(v)`, so no further covering pair among `u, v, w, w′` |
| **Y2-LAT** | **TRUE for the candidate as I read it** | [tools, exact], one reading | My reading (not in my instance block): BB's tiles translated over the three cosets of the index-3 sublattice of the unit triangular lattice (`u`'s at class 0, `v`'s at 1, `w`'s quadrants at 2). REJECT: 36 of 521 pairs, all between a `u`-type tile and a four-colour point's quadrant, at four-colour points placed relative to the `u`-point as BB's `w′` is (`data/fs110/fs110-yb/lattice.out`, `tools/fs110_yb_lattice.py`) — BB's `w′ = R(w)` is not a translate of `w`, which is the over-constraint |
| **Y-CHK** | not assessed (the side's tool is not used by a blind verifier); outputs compared at stage 4 | — | — |

### 3.2 Theorems this phase proved (mine)

- **YB-CHK** — an exact same-colour cross-distance checker for segment/arc tiles over ℚ(√3) with a complete candidate list, six type controls, the
  tight hexagonal ACCEPT control, a REJECT control, eight plants each firing for its own reason — [tools, exact], §2.
- **YB-FRAG** — S1, T2, BB, MX rebuilt from their formulas ACCEPT, tight, under two closings each — [tools, exact], §2.3.
- **YB-L** — branch exclusion — [hand, one mind], §3.
- **YB-W4** — Y2-W4 clauses 1–2, and clause 3 in the corrected form — [hand, one mind], §3.1.
- **YB-V5X** — no bichromatic vertex of degree `≥ 4` ends a covering pair at a transversal common unit point — [hand, one mind], §3.1.
- **YB-ESC** — at (3, 3) an escape is a strong escape — [hand, one mind], §3.1.
- **YB-S1i-cusp** — the cusp swap at the end of (S1)'s unit arc (a bichromatic degree-4 end meeting no colour of `P(v)`) is not excluded by TS-U — [hand, one mind; a GAP located, not a construction], §3.1.
- **YB-BIKE-gen** — no six-arc three-cycle colouring of the bicycle whose cross curve meets no grid vertex, at the seven sampled `d` — [hand + measured], §3.1.
- **YB-LAT** — my reading of the lattice extension of BB REJECTs — [tools, exact], §3.1.

### 3.3 Registered expectations scored

S1, T2, BB, MX: ACCEPT ×4 (as registered). Y2-W4: clauses 1–2 TRUE, clause 3 MISSTATED (as registered). Y2-W4e: TRUE, weaker (as
registered). Y2-S1i: GAP at cusps (registered TRUE at 0.65, the arc-end outcome I named reachable). Y-T2W: as registered. Y-BLOCK: GAP (as
registered). Y-BIKE-3C: GAP (one of the two registered). Y2-LAT: TRUE for my reading.

## Stage 3 — SAVED

## Stage 4 — SAVED: the side's record read (after stage 3 was committed); divergences and proposed edits

Read: `plans/FS110-Y-construction.md` l. 1–30 (table), l. 216–226 (Y-BIKE-3C), l. 296–400 (Y2-W4, Y2-W4e, Y2-S1i), and
`data/fs110/fs110-y/y2_fragments_none.out`. Not read for lack of budget: the rest of the record, `tools/fs110_y_*` (never run). **Quotation check
of the instance block:** the table lines l. 27, 263, 272, 279 match the instance block's text (checked by prefix); not checked line by line.

| # | item | kind | the side | mine | proposed edit for the close |
|---|---|---|---|---|---|
| 1 | Y-BIKE-3C | **truth** | TRUE: "each component of the allowed region, lifted, is a band whose section at fixed `α` is one half-open interval of exactly `120°` … `C` lies in one component" | GAP at grid-corner passages | The allowed half-open cells of adjacent bands meet at grid corners (the closure of cell `(i, j)` holds the corner that belongs to `(i+1, j+1)`), so the allowed region is **connected across the forbidden stripes**, and a cross curve passing diagonally through a corner stays proper there; the lift then jumps by 2 without touching the forbidden value. The side's "C lies in one component" is the missing step. Its section argument at `α = 0` (partners `2γ` apart, `γ = arccos((d − 1)/2) > 60°` iff `d < 2`) is exact and better than my measured ranges: adopt it. Edit: **"TRUE for offsets `(φ, ψ)` whose cross curve meets no grid corner; GAP at corner passages"** [hand, two minds for the generic case (Y's route and mine), the GAP one mind] |
| 2 | Y2-W4 (d) | **truth (scope)** | "colours are in `P(u) ∖ P_cl(w)`, **at most one colour** `m_u(w)` (none when `\|P(u)\| = 2`)" | at most `\|P(u)\| − 2` | False at the four-colour end of a (4, 2) pair: two colours remain. Edit: "at most `\|P(u)\| − 2` colours: one at (3, 3), none at the two-colour end, two at the four-colour end" |
| 3 | Y2-W4e, the (2, 4) bullet | **scope** | "a bichromatic degree-`≥ 4` vertex in a (2, 4) covering pair is the crossing point of two unit arcs, centred at `w` and `w′`" | vacuous: **YB-V5X** — under the same hypothesis no such pair exists | Y2-W4 (b) makes one of the bichromatic end's colours lie wholly inside `ω(w)` at it and the other wholly outside; alternating sectors forbid it. So a V5 end of a covering pair needs an arc of Γ at every common unit point with transversal branches — the (S1) mechanism — or cusps. Edit: state YB-V5X, and C-V5-K's live case as "(2, 4) pairs only at arcs of Γ or cusps" [hand, one mind; the side's (b) is the same lemma as my YB-L, so two minds for the lemma] |
| 4 | Y2-W4e, escape partner | **scope** | "If `u` is a strong escape at `w` … `v` must be `ω(w)`-monochromatic … A generic trivalent `v` … is excluded" | holds for **every** (3, 3) covering pair at such a `w`, escape or not | (d) at `v` does not use `u`'s escape. Edit: "at a common unit point with no arc of Γ, both ends of a (3, 3) covering pair are `ω(w)`-monochromatic or boundary-lined; a generic trivalent vertex is never an end" |
| 5 | Y2-S1i item 4 | **truth** | TRUE: "past its ends, tile-interior points of `ω(u)` carry colours outside `P(u)` … so each end on `ω(u)` is a vertex meeting a colour of `P(v)`" | GAP at cusps | Past an end, `ω(u)` may continue **along another boundary** instead of into tile interiors. TS-U excludes every continuation with sides in `P(u)` except the swap `(c′ \| c)`, which confines `c′` and `c` near `u` to the rays `θ₂ ± 90°` — admissible for cusp tiles. Then the end is a bichromatic degree-4 vertex `c, c′, c, c′` meeting no colour of `P(v)`. Edit: "TRUE when the arc's side colours have sectors of positive angle at `u`; GAP when both are cusps at `u`" |
| 6 | Y-T2W | scope (unchecked against the side's text) | "a pair saved at `w₀` by T2 makes `w₀` a vertex of degree `≥ 4`" | TRUE at (3, 3); GAP at (2, 4) | At (4, 2) the four-colour end can carry a unit arc of `ω(u)` into `w₀`; then the `P(u)`-colours at `w₀` are that arc's sides. "The inner arc colour" should read "an inner colour" |
| 7 | Y-BLOCK "hence C-TAN-POS TRUE" | grade | TRUE "at the level of A-EXACT's disjointness", completeness not claimed | GAP at completeness | The inference needs the complete list; a named hole is the cusp tangent to the tangent line (`τ ⊥ e_u`), where "`≍ s·\|τ·e_u\|`" degenerates |
| 8 | the fragments S1, T2, BB, MX | agreement | ACCEPT, 18 / 24 / 30 / 27 pairs, tight | same, with my own checker and closings; T2's 8 contacts; the four plants REJECT at the pairs the side names; `t2_flat` range `[0.9923, 1.3716]` against `≈[0.992, 1.372]`; S1's ranges equal the side's to six places | Grade Y2-S1 (fragment), Y2-T2F, Y2-BB, Y2-MX **[tools, exact, two independent checkers]** |
| 9 | Y2-LAT | agreement (reading) | fails at its four-colour points | my reading REJECTs, 36 pairs, all `u`-type against a four-colour point placed as `w′` | Compare the side's formula with mine at the close; I did not |
| 10 | claims list | correction owed | — | — | `data/fs110/claims.md` §0 "Siamese and outer": the source is `plans/FS106-TQ-derivation.md` l. 348, not `plans/FS107-stability.md` l. 348 |

**Where the divergences come from:** items 1 and 5 are the same shape — a proof that follows a curve through tile interiors (or through cell
interiors) and misses the measure-zero passage where it runs along a boundary (a grid corner; an arc of `ω(u)` continuing past the end). Both are
the flattering direction (G21): each missed case is a possible escape for the construction side's opponent, so the side's TRUEs close more than
they prove.

## Stage 4 — SAVED

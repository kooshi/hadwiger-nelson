# FS110-Y — the construction side of FS-110 (the tangency seam)

*Job FS110-Y (de Bruijn, Opus 5.5), 2026-09-27. Brief: `data/fs110/briefs/Y110-construction.md` with `data/fs110/briefs/STANDING-RULES.md`.
Claim list: `data/fs110/claims.md` (quoted, never paraphrased). Blind to the proof side (FS110-N) until hand-back. Working files:
`data/fs110/fs110-y/`; tools `tools/fs110_y_*.py`.*

## Theorems this phase proved

*(one line each; grade; address)*
- **Y-AEX** — A-EXACT TRUE with "meets a tile" read as "meets the interior of a tile" (false for the closure reading exactly at cusps and
  transversal passes through `u`); its consequence, disjointness of `B_u(s)`, `B_v(s)` for a covering pair, TRUE — [hand, one mind here; two with
  FS110-A's], §1.3.
- **Y-CIRC** — A-CIRC TRUE for every colour of `P_cl(u)`, cusp colours included (the argument needs only interior points of the tile accumulating
  at `u`, never an angle) — [hand, one mind here; two with FS110-A's], §1.3.
- **Y-SIX** — A-SIX TRUE: C-T-TAN's proof uses the type sizes only through "all six classes are in `P(u) ∪ P(v)`"; the sizes enter only its
  failure-set analysis, which I redo for sizes 2 and 4 — [read + hand, one mind here; two with FS110-A's], §1.3.
- **Y-TYPE** — D-TYPE TRUE for `𝓜_K` maps (and any locally finite map whose boundary arcs have one-sided tangents at `u`): `P_cl(u) ∖ P_ess(u)` is
  exactly the set of colours all of whose corners at `u` have angle 0 — [hand, one mind, trivial], §1.3.
- **Y-BLOCK** (as corrected at stage 3) — the blocking set `B_u(s) ∩ B(w₀, c)` of an `𝓜_K` vertex takes the shapes: one-sided band of depth
  `≍ s·margin` (generic trivalent), `≍ |1 − κ|s²/2` (T1) or `≍ s·|τ·e_u|` (cusp); a two-sided ball only at vertices of degree `≥ 4` with no
  escape; a thin double wedge of angle `≍ s` about the tangent line of `ω(u)` at `w₀` (T2); empty (escape). Completeness of this list is not
  claimed. Hence C-TAN-POS TRUE at the level of A-EXACT's disjointness test — [hand, one mind], §1.4, §3.
- **Y-CHK** — `tools/fs110_y_check.py`: exact min/max cross-distance for tiles bounded by segments and circular arcs over ℚ(√3), seven controls
  (three curved), four planted faults each firing for its own reason — [tools, exact], §2.2.
- **Y-T2W** — a pair saved at `w₀` by T2 makes `w₀` a vertex of degree `≥ 4` whose branches of `ω(u)`, `ω(v)` alternate, with `P(u)`-colours at
  `w₀` in Siamese contact with `u` (inner arc colour) or outer contact (outer colour) — [hand, one mind], §2.3.
- **Y-BIKE-3C** — no six-arc three-cycle colouring of each circle colours the bicycle, at any `d ∈ (1, 2)` — [hand, one mind], §2.4.

## Fence log (standing rule 13)

- **Touch 1 (09:25 UTC, disclosed):** my first command, `ls -la` on `data/fs110/` and its subdirectories, listed the **file names** in
  `data/fs110/reports/` (`FS110-A.md`, `FS110-P.md`) and `data/fs110/briefs/` (the other briefs' names). No file there was opened or read; no
  content seen. The listing of `data/fs110/` also showed the directory name `fs110-a` (not listed inside).
- Nothing else fenced opened, listed or grepped. `git log` read only at start-up (`git log --oneline -3`).

## Would-have-searched-here log (standing rule 3)

- C-T-BIKE: a scan over offsets and cell patterns → the band-section argument (§2.4).
- C-T2 (i): a scan over the free ray angles of the four rhombus vertices → the derived constraints (§2.3).

## Stage 1 — SAVED: quotation check; the local calculus of §1b

### 1.1 Files read from disk (this order)

`data/fs110/briefs/Y110-construction.md`, `data/fs110/briefs/STANDING-RULES.md`; `CLAUDE.md` § The aim (l. 74–113), § Counter-priors (l. 115–137),
G82 (l. 1591); G79, G71, G21, G15, G13, G46 from the loaded copy (G79 checked on disk, l. 1582); `LEDGER.md` rows 131–133; `data/fs110/claims.md` in
full; `plans/FS110-tangency-seam.md` §G part 3, §PA, §IQ (l. 328–414); `plans/STUB-tangency-seam.md`; `plans/FS107-derivation.md` in full;
`plans/FS106-TS-derivation.md` l. 11–37, §2.2–2.6 (l. 114–224), l. 246–279; `plans/FS107-V-verification.md` §4.3; `plans/FS107-VW-verification.md`
§2b.4, stage 4; `plans/FS107-W-near-colourings.md` §2.1–2.6, §4.2–4.4; `plans/FS107-R-stability.md` §3.2–3.6; `plans/FS106-V-verification.md`
l. 360–378; `[SokolovVoronov2025]` (held PDF, text extracted to my scratch) l. 140–160 (Conditions 5–8), Prop. 5, Lemma 3, Question 2.
Not yet read: Townsend's manuscript, Woodall §3, Coulson, Voronov Prop. 2.2 and Lemma 6.1 (for the bicycle stage, if reached).

### 1.2 Quotation check (standing rule 5)

| quotation (in the brief or the claim list) | source | result |
|---|---|---|
| Kooshi: "My goal is to fully solve, and then verify in Lean, HN. Then we publish." / "Let's see some ambition. I know we can do it." | `CLAUDE.md` l. 76, l. 120 | match |
| Kooshi: "search for a finite graph is out. It would be huge, not feasible." | `CLAUDE.md` § Publication | match |
| Q-full, "Does a full tight a.e.-proper six-colouring …" | `plans/STUB-tangency-seam.md` § The question | match |
| S–V Question 2; Conditions 5, 6 | held PDF, text l. 148–153, l. 1016–1018 | match (line breaks only) |
| `𝓜_K` definition | `plans/FS107-derivation.md` header | match |
| C-T-TAN, "Let `k = 6` … does not occur." | `plans/FS106-TS-derivation.md` l. 258 | match |
| TS-U | `plans/FS106-TS-derivation.md` l. 15–16 | match |
| C-T-BIKE; K-KILL's second half | TS l. 257, l. 275 | match |
| V-C5 and its killing test | `plans/FS107-derivation.md` §1; `plans/FS107-V-verification.md` §4.3 | match |
| W-TAN; R-CP; RR; W-EQ-K; W-POLY; W-RATE; R-SW; R-OB2; HX-STALL; K-C6; K-BICH | `plans/FS107-derivation.md` | match |
| VW §2b.4 ("But a bichromatic vertex …"); VW §4 item 4 (cusp) | `plans/FS107-VW-verification.md` | match |
| R §3.6 ("pure `π/3`-arc ansatz fails narrowly there"; "general tight 2-colourings …"); R §3.4 (A″) | `plans/FS107-R-stability.md` | match |
| W §2.5 (Act One) | `plans/FS107-W-near-colourings.md` l. 219–222 | match |
| Townsend ⅔π ("So the counterexample is right, and **sharp at `2π/3`**…") | `plans/FS106-V-verification.md` l. 373–374 | match |
| A-EXACT, A-CIRC, A-SIX, C-TAN-POS, C-BOW-K, `P_ess`/`P_cl`, the §1.7 hunch | the advisor's record and messages | **not checkable: fenced** (logged, not a failure) |
| "Siamese and outer" (`plans/FS107-stability.md` l. 348) | not opened | unchecked (not needed at stage 1) |

### 1.3 The local calculus — verdicts

Setting throughout: a full tight a.e.-proper six-colouring by a locally finite map (tiles closures of open sets with connected interiors,
boundaries finitely many arcs with one-sided tangents at the vertices, null); `ω(z)` the unit circle about `z`.

**A-EXACT — TRUE with one reading fixed; the consequence TRUE.** [hand; one mind here; two with FS110-A's]
- *First clause.* If `z ∈ int τ`, `z′ ∈ int τ′`, one colour, `|z − z′| = 1`: discs `B(z, r) ⊂ τ`, `B(z′, r) ⊂ τ′`; for each `p ∈ B(z, r/2)`,
  `ω(p) ∩ B(z′, r)` is an arc of length `≳ r`, so the monochromatic unit pairs have positive `Leb ⊗ σ` measure. Contradiction. (W-EQ-K's step 4.)
- *The set `B_u(s)`.* "`ω(z)` meets a tile of every colour of `P_cl(u)` inside `B(u, s)`" must be read **"meets the interior of such a tile"**. Then
  `B_u(s)` is a finite intersection of sets `{z : ω(z) ∩ U ≠ ∅}` with `U` open, hence open; a tile-interior point of `B_u(s)` of a colour `j ∈
  P_cl(u)` has an interior point of a colour-`j` tile at distance 1 — excluded by the first clause. Since boundaries are nowhere dense, `B_u(s)` is
  coloured outside `P_cl(u)` off the null boundary set.
- *The closure reading is false exactly where it matters:* a point `z` with `|z − u| = 1` has `ω(z)` through `u`, so meeting the closure of every
  tile at `u`; with a cusp colour `j` at `u` whose horn is transversal to `ω(z)`, `ω(z)` meets no interior point of the horn near `u`, and `z` may
  carry colour `j`. So the interior reading is the statement.
- *Consequence.* For a covering pair (`P_cl(u) ∩ P_cl(v) = ∅`, union all six), an interior point of `B_u(s) ∩ B_v(s)` would carry a colour outside
  all six. So `B_u(s) ∩ B_v(s) = ∅` for every `s`. TRUE.

**A-CIRC — TRUE, cusp colours included.** [hand; one mind here; two with FS110-A's] Let `x ∈ ω(u)` be interior to a tile `τ` of colour `c`, and
`σ` a tile of colour `c` with `u ∈ cl σ`. Let `D` be a disc about `x` in `int τ` and `Σ` a component of `int σ ∩ B(u, r)` whose closure contains `u`
(for a cusp tile: the horn). `D × Σ` is connected; `f(p, q) = |p − q|` is continuous on it. With `e = x − u`: `f(x + δe, q) → 1 + δ` and
`f(x − δe, q) → 1 − δ` as `q → u` in `Σ`. So `f` takes 1 on `D × Σ`: an interior monochromatic unit pair. Contradiction. **No angle of `Σ` is
used, only interior points of `σ` accumulating at `u`**; a zero-angle tile has them. So every tile-interior point of `ω(u)` has a colour outside
`P_cl(u)`.

**A-SIX — TRUE.** [read + hand; one mind here; two with FS110-A's] In TS l. 258's proof the sizes appear nowhere: `T_u`, `T_v` are defined for any
types; `Π` needs only `e_u ∦ e_v`; "some class `j` fills at least `|Π|/6`" holds for any six classes; "say `j ∈ P(u)`" needs exactly `j ∈ P(u) ∪
P(v)` for every `j`. So the non-occurrence holds for every covering pair. **The failure set does depend on the sizes** (TS's analysis is for three
sectors); redone for cone blow-ups of any size: `T_u` is null iff two classes of `P(u)` lie in opposite closed half-planes of `e_u^⊥`. For
`|P(u)| = 2` with degree `≥ 4` (`a, b, a, b`): null only if every `a`-sector lies on one closed side of `e_u^⊥` and every `b`-sector on the other —
impossible when the sectors alternate around `u` with positive angles (an `a`-sector lies between two `b`-sectors on each side), so **a bichromatic
vertex of degree `≥ 4` blocks every direction at the blow-up level**. For `|P(u)| = 4` (sectors `a, b, c, d` in order): `a` and `c` are
separated by every line through `u` whose two rays lie in `b` and `d` — an **open** set of directions whenever `b` and `d` contain opposite rays:
the four-colour vertex escapes on an open set, like a bowtie (the advisor's "A four-colour vertex in a bowtie direction is an escape the stub does
not list" — derived here).

**D-TYPE — TRUE for `𝓜_K` maps.** [hand, one mind, trivial] Near `u` each tile `σ` with `u ∈ cl σ` is a finite union of corners, each between two
arcs from `u` with one-sided tangents `θ₁, θ₂`. A corner of angle `> 0` contains a truncated cone: positive density. A corner of angle 0 lies
between two arcs with one tangent, `|f₁ − f₂| = o(x)`, area `o(r²)` in `B(u, r)` (`O(r³)` for circular arcs): density 0. So `P_cl(u) ∖ P_ess(u)` is
exactly the set of colours **all** of whose corners at `u` are cusps (a colour with one cusp corner and one fat corner, two Siamese tiles touching
at `u`, is essential). "They differ exactly at cusps": TRUE in this form.

### 1.4 C-TAN-POS — the blocking sets at `w₀`, derived (Y-BLOCK)

Coordinates: `u = 0`, `e_u = (0, 1)`, `w₀ = e_u`, `z = w₀ + ζ`. Near `u`, `ω(z) = ω(w₀) + ζ`, i.e. `y = ζ_y + (x − ζ_x)²/2 + O(|x|³)`; `ω(w₀)` is
`y = x²/2`. Let `u` be a vertex of `𝓜_K` with closure type `{1, 2, 3}`, scale `s` (tiles within `O(Ks²)` of their cones in `B(u, s)`). The set
`B_u(s) ∩ B(w₀, c)`, `c ≪ s`, has one of five shapes:

| `u` at `w₀` | `B_u(s)` near `w₀` | why |
|---|---|---|
| **fat** (all three sectors meet both open half-planes of `e_u^⊥`) | contains the whole ball `B(w₀, c s·margin)` (a slab `\|ζ·e_u\| < c s`) | a near-line at offset `\|h\| ≪ s` crosses all three sectors |
| **T1, κ ≠ 1** (the `1\|2` interface tangent at `u`, curvature `κ` against `ω(w₀)`'s 1) | a **one-sided band** `ζ·e_u ∈ (−\|1 − κ\|s²/2, 0)` (side by the sign of `1 − κ`) | V-C5's mechanism: the shifted circle dips across the interface and recrosses within `B(u, s)` |
| **cusp** (colour 3 a horn of tangent `τ`) | a one-sided band of depth `≍ s\|τ·e_u\|`, or `≍ \|κ₁ − κ₂\|s²/2` when `τ ⊥ e_u` | `ω(z)` meets the horn only on one side of the slab (VW §4 item 4) |
| **T2** (the `1\|2` interface **is** an arc of `ω(w₀)`, either side) | a **thin double wedge** about the line `w₀ + ℝe_u^⊥`, half-angle `≍ s` (the arc's angular width seen from `w₀`), vertex `w₀` excluded | `ω(z)` crosses `ω(w₀)` near `u` only when `ζ` is within angle `≍ s` of `e_u^⊥`; this set is `(arc ⊕ S¹)` near `w₀` |
| **strong escape** (bowtie `4,5,4,6`, or a four-colour vertex, whose repeated or extra colour holds two sectors straddling every line of tilt `< µ` from `e_u^⊥`) | **empty** in `B(w₀, c)` | every near-line through the straddling sectors misses one of the other two colours (C-BOW-K (i): TRUE here, one mind) |

**Pairs** (A-EXACT: `B_u ∩ B_v = ∅`; `e_u, e_v` at angle `ψ = 2 arcsin(d/2)`, `d = |u − v| ∈ (0, 2)`):
- fat vs anything non-empty near `w₀`: fails (the ball meets it).
- one-sided band vs one-sided band: the quadrant `{σζ·e_u ∈ (−a, 0), σ′ζ·e_v ∈ (−b, 0)}` is a non-empty open cone at `w₀`: fails.
- band vs thin wedge: the wedge's line `e_v^⊥` is transversal to `e_u^⊥` (`ψ ≠ 0`), so it enters the band at distance `< a/sin ψ`, on the side the
  band lies (the wedge is two-sided): fails, **for every positive band depth** (so near-T2, `κ = 1 ± η`, fails too).
- thin wedge vs thin wedge: disjoint in `B(w₀, c)` when both half-angles are `< ψ/2`: **survives**.
- empty vs anything: survives.

**Verdict: C-TAN-POS TRUE** at the level of A-EXACT's disjointness test, for pairs of trivalent, bowtie, four-colour and cusp vertices of `𝓜_K`:
at `w₀` the pair survives only if one side is a strong escape or **both** are T2 (both `u` and `v` emit arcs of `ω(w₀)`). [hand, one mind; the
claim is the advisor's] Consequences for the seams: **C-TAN-K (T1 closed) TRUE at the pair level; C-CUSP-K TRUE at the pair level** (the advisor's
hunch "the cusp seam reduces to the tangent seam" holds, and the reduction goes further: to T2 or a strong escape). This is a necessary condition
only: T2–T2 and strong escapes **pass** it, so they are the construction side's live seams (C-T2, C-BOW-K). Grade note: `B_u` is computed from the
cone plus curvature at scale `s`; the error `O(Ks²)` is below every quantity used except the band depth `|1 − κ|s²/2` in the T1 row, where it is the
same order — so the T1 row needs `|1 − κ|` against `K`-dependent constants (a GAP only in constants, which the two-sided fail argument does not use:
any positive depth fails against a wedge, and for T1 vs T1 the quadrant is non-empty at every depth).

### 1.5 What every T2 realisation carries (X13, G79's flip)

A pair `(u, v)` saved at both unit points by T2 carries the **spindle's rhombus of vertices** `u w₀ v w₀′` (as the claim list says), and more:
- `u` emits two unit arcs, of `ω(w₀)` and of `ω(w₀′)`; so does `v`. Four unit arcs meet `{u, v}`.
- By TS-U at `w₀` for `u`'s arc (colours `a | b ⊂ P(u)`): the side cones at `w₀` — about the directions `±e_u^⊥`, **along `ω(u)`'s tangent at
  `w₀`** — hold neither `a` nor `b`; likewise for `v`'s arc along `ω(v)`'s tangent.
- By A-CIRC, interior points of `ω(u)` near `w₀` carry `P(v)`'s colours and interior points of `ω(v)` near `w₀` carry `P(u)`'s colours; `ω(u)`,
  `ω(v)` cross at `w₀` at angle `ψ`. So **`w₀` is a vertex whose closure type meets both `P(u)` and `P(v)`**, unless `ω(u)` (or `ω(v)`) runs along
  a boundary near `w₀` — a unit arc centred at `u` through `w₀`, the reciprocal arc.
- So T2 cascades: `w₀`, `w₀′` are vertices with mixed types at distance `√(4 − d²)` from each other, and their own close pairs must be seams.

## Stage 1 — SAVED

## Stage 2 — SAVED: the generator image; the exact checker and its controls; T2 at `w₀`; one bicycle no-go

### 2.1 The generator image (X5, X17 — written before any candidate)

My candidates are **tiles bounded by segments and circular arcs whose endpoints, centres and radii lie in ℚ(√3)**, same-colour pairs listed by
the builder, checked by `tools/fs110_y_check.py`. **What the image cannot represent** (so a zero from it says nothing there): arcs whose data leave
ℚ(√3) — among T2 rhombi `u w₀ v w₀′` it holds exactly those with all four vertices in ℚ(√3), e.g. `d = |u − v| = 1` (two equilateral triangles)
and `d = √3` (`|w₀ − w₀′| = 1`), not a generic `d`; non-circular boundaries; infinitely many tiles. **Parameter count for C-T2 (i) at a fixed
rhombus**: each of `u, v` is a vertex with two unit-arc rays fixed by T2 (at `w₀` and `w₀′`) and at least one free ray (one angle); `w₀, w₀′` are
vertices of degree `≥ 4` (§2.3) with at least four free ray angles each; the constraints are the tight same-colour contacts across the four unit
pairs `u w₀, w₀ v, v w₀′, w₀′ u` and the Siamese/outer alternative for every same-colour pair within the fragment. The count is not closed here.

### 2.2 The checker — `tools/fs110_y_check.py` [tools, exact]

Q(√3) arithmetic with exact sign; every candidate distance is `|√A + B|`, `A, B ∈ ℚ(√3)`, compared with 1 exactly. The candidate list holds
every critical pair (endpoint–endpoint, endpoint–primitive foot or radial point, segment–arc common normals through the centre, arc–arc pairs on
the line of centres, concentric/same-arc radial pairs), each with its direction condition checked, so min and max over candidates are the true
extremes. **Stated hypothesis (the map hypothesis):** boundaries of distinct tiles meet only at listed endpoints; then two tiles touch iff they
share an endpoint. REJECT iff `min < 1 < max` (a tile against itself: iff its diameter exceeds 1).

| control | want | clean | `noself` | `endpoints_only` | `closed_interval` | `cw_arcs` |
|---|---|---|---|---|---|---|
| tight hexagonal 7-colouring, side 1/2 (diameter exactly 1) | ACCEPT | ACCEPT | · | · | **REJECT** | · |
| hexagonal 7-colouring, side 11/20 (diameter 1.1) | REJECT | REJECT | **ACCEPT** | · | · | · |
| index-4 hexagonal 4-colouring (same colour `√3` apart) | REJECT | REJECT | · | · | · | · |
| Reuleaux triangle of width 1 (curved, diameter exactly 1) | ACCEPT | ACCEPT | · | · | **REJECT** | **REJECT** |
| minor circular segment on a unit chord | ACCEPT | ACCEPT | · | · | **REJECT** | **REJECT** |
| major circular segment (diameter `2/√3` at interior antipodes) | REJECT | REJECT | **ACCEPT** | **ACCEPT** | · | **ACCEPT** |
| two Reuleaux triangles with gap exactly 1 (arc–arc minimum on the line of centres) | ACCEPT | ACCEPT | · | · | **REJECT** | **REJECT** |

("·" = unchanged.) Each plant fires for its own reason: `noself` loses exactly the two self-pair REJECTs; `endpoints_only` loses exactly the
REJECT whose maximum sits at interior points (X17's suspect ACCEPT, seen); `closed_interval` turns every exactly-tight ACCEPT into a REJECT;
`cw_arcs` swaps minor and major arcs. Outputs: `data/fs110/fs110-y/check_controls_*.out`. A defect found by reading before the first run and
repaired: the concentric/same-arc branch had the same- and opposite-direction values swapped and lacked negated directions. The checker certifies
members; a family's claim is a derivation.

### 2.3 C-T2 (i), the double unit-arc seam, at `w₀` — what a realisation must carry [hand, one mind]

Beyond §1.5, derived from A-CIRC, TS-U and A-EXACT (P(u) = {1,2,3}, P(v) = {4,5,6}):
- **`w₀` has degree `≥ 4`, with alternating branches.** Near `w₀` the curves `ω(u)` (along `±e_u^⊥`) and `ω(v)` (along `±e_v^⊥`) cross at angle
  `ψ`. Interior points of `ω(u)` carry colours of `{4,5,6}` and of `ω(v)` colours of `{1,2,3}` (A-CIRC), so no tile contains interior points of
  both, and each of the four sectors between consecutive branches holds a boundary ray from `w₀` — unless a branch is itself a boundary (a unit arc
  centred at `u` or `v` through `w₀`, the reciprocal arc).
- **A colour of `P(u)` present at `w₀` is a Siamese contact across the unit pair `u w₀`.** Its sector at `u` and its sector at `w₀` are at
  distance exactly 1 at the closure points; cross-distances straddling 1 are excluded (A-EXACT), so to first order either both face each other
  (Siamese: all `≤ 1`) or both face away (outer: all `≥ 1`), with curvature conditions on rays along `e_u^⊥`. TS-U fixes which: `u`'s inner arc
  colour `a` appears at `w₀` only facing `u` (Siamese), the outer colour `b` only facing away (outer).
- **`u`'s third colour `c₃`** (not on the `ω(w₀)` arc) can appear near `w₀` only if its sector at `u` lies in a closed half-plane of `e_u^⊥`, and
  then only on one side.
- So the fragment is a **local rule on four vertices of degree `≥ 3, 3, ≥ 4, ≥ 4`** with every unit pair of the rhombus a tight contact. I find no
  contradiction; the named next step is a formula fragment at `d = 1` (all four vertices in ℚ(√3): `u = 0`, `v = (1, 0)`, `w₀ = (1/2, √3/2)`,
  `w₀′ = (1/2, −√3/2)`), each vertex a finite fan of sectors truncated by segments with ℚ(√3) endpoints, checked by §2.2. **Not built** (budget).
  C-T2 (i): **GAP at that construction**; C-T2 (ii) untouched.

### 2.4 C-T-BIKE — a no-go for one generator family [hand, one mind]

**Y-BIKE-3C.** For no `d ∈ (1, 2)` is the bicycle `T₁(u) ∪ T₁(v)` properly coloured by colouring each circle with six `60°` arcs cycling through
three colours (any offsets, either orientation, any colour permutation). *Proof.* With the colours as `ℤ/3`, the colour of a point of `T₁(u)` at
angle `α` is `⌊(α − φ)/60°⌋ + k` and of `T₁(v)` at angle `β` is `±⌊(β − ψ)/60°⌋ + k′`. The cross pairs form a closed curve `C` in the `(α, β)`
torus that does not wind (its projections are the two facing arcs). The forbidden cells (equal colours) are diagonal stripes of slope `±1`, and each
component of the allowed region, lifted, is a band whose section at fixed `α` is one half-open interval of exactly `120°` in `β`. `C` lies in one
component. At `α = 0` (the point `x = u + (1, 0)`, always in the facing arc) the two partners of `x` on `T₁(v)` lie at `β = 180° ± γ`,
`γ = arccos((d − 1)/2) > 60°` for `d < 2`: `2γ > 120°` apart on one lift of `C`. Contradiction. ∎ This is the mechanism of R's "fails narrowly"
(FS107-R §3.6, a different family: each circle two-coloured): at `d = 1.9`, `2γ = 126.6°` against `120°`. **What it leaves:** colourings not
periodic in `60°` cells on either circle — R's `E ∪ (E′ + 60°) ∪ …` freedom and colourings using three colours unevenly. Killing test 10 stays open.

*Would have searched here (added):* C-T-BIKE — a scan over the offsets and cell patterns; instead the stripe/band section argument above.
C-T2 (i) — a scan over the free ray angles at `u, v, w₀, w₀′`; instead the constraints of §2.3.

## Stage 2 — SAVED

## Stage 3 — SAVED: retractions after FS110-A2's card 1 (free; counted by A2, G51)

1. **§1.4's "fat" row is empty for trivalent vertices** (A2's point 3, checked): three sectors, and a line through `u` has two rays, so at most
   two sectors contain a direction `±e_u^⊥` and the third lies in one open half-plane. The generic trivalent vertex blocks a **one-sided band** of
   depth `≍ s·margin` (V-C5's "on one side or the other"). A two-sided set (a ball about `w₀`) arises only at vertices of degree `≥ 4` with no
   escape (e.g. bichromatic `a, b, a, b`). **"Exactly five shapes" is withdrawn**: the shapes are the ones found, completeness not claimed.
   **C-TAN-POS's verdict is unchanged**: one-sided band against one-sided band fails by the quadrant argument (the map `ζ ↦ (ζ·e_u, ζ·e_v)` is a
   linear isomorphism, so the two half-open bands meet in the preimage of a rectangle adjacent to 0), and a band against a thin wedge fails.
2. **"Strong escape" is MISSTATED in the claim list** (A2's point 2, checked): a vertex of type size 4 with sectors `c, d, c′, f` of four distinct
   colours, each below `180°`, has `B_u ∩ B(w₀, c) = ∅` for every direction whose near-lines pass through `d` and `f` (a near-line then misses `c`
   or `c′`) — an open escape with no colour repeated. Corrected definition: **"two sectors straddling every line of tilt `< µ` from the tangent line,
   with at least one colour of `P(u)` lying wholly on each side"**; the bowtie is its case with the straddling colour repeated. My §1.4 table row
   ("whose repeated or extra colour holds two sectors") is replaced by this definition.
3. **Disjointness vs union** (A2's point 1): every statement of mine uses only "`P(u) ∪ P(v)` holds all six colours" — A-EXACT's consequence,
   A-SIX, C-TAN-POS — so they hold verbatim for **overlapping** pairs whose types cover the six colours. For families of three or more vertices at
   distance 1 from one `w₀`, A-EXACT still gives `⋂ B_{u_i} = ∅` when the types cover the six, but the pair argument does not transfer: three
   one-sided bands through `w₀` can have empty common intersection near `w₀`.
4. **C-TAN-POS's scope, one line each:** at `u` and `v` — trivalent (generic, T1, T2), bowtie, four-colour and cusp vertices of `𝓜_K` (C¹ arcs,
   one-sided tangents), and bichromatic degree-`≥ 4` vertices against a four-set; nothing assumed at `w₀`; general Jordan boundaries not covered.
   It rests on one necessary condition only: A-EXACT's `B_u(s) ∩ B_v(s) = ∅`, with `B_u` computed from the cone plus curvature at scale `s`.

## Stage 3 — SAVED

## § Continuation — FS110-Y2

*Job FS110-Y2 (de Bruijn, Opus 5.5), 2026-09-27. Brief: `data/fs110/briefs/Y2-110-construction-continued.md` with FS110-Y's brief and
`data/fs110/briefs/STANDING-RULES.md`. Start-up snapshot `aad1d747`. Earlier verdicts above are FS110-Y's and are not rewritten; where I add to or
disagree with one, I say so here. Working files `data/fs110/fs110-y/y2_*`; tool `tools/fs110_y_fragments.py` (imports `tools/fs110_y_check.py`,
unedited).*

### Theorems this phase proved (FS110-Y2)

- **Y2-W4** — at a common unit point `w` of a covering pair `(u, v)`, `|u − v| ∈ (0, 2)`, with neither `ω(u)` nor `ω(v)` running along a
  boundary into `w`: the four branches carry four distinct colours, two of `P(u)` (one facing `u`, one away) and two of `P(v)`; so
  `|P_cl(w)| ≥ 4`, and every tile-interior point of `ω(w)` near `u` has the one colour `P(u) ∖ P_cl(w)` (near `v` likewise) — [hand, one mind], §4.3.
- **Y2-W4e** — hence the partner of a strong escape at `w` (with no arc of Γ at `w`) must be `ω(w)`-monochromatic at its own vertex (both
  directions of `ω(w)` in tiles of one colour, or along boundaries); and at a (2, 4) covering pair the bichromatic vertex must carry boundaries
  along `ω(w)` in both directions — [hand, one mind], §4.3.
- **Y2-S1** — the owner's (S1) is realisable locally: fragment `S1` (a bowtie centred on two boundary unit arcs through `w`, `w′`; a generic
  trivalent partner; `w`, `w′` two-colour edge points), exact over ℚ(√3), all 18 same-colour pairs ACCEPT, tight — [tools, exact; the family
  claim hand, one mind], §4.5.
- **Y2-S1i** — every realisation of (S1) with `w` an edge point carries: the arc's sides are `u`'s facing and away colours at `w`; `u` is a strong
  escape at `w`; the arc's ends on `ω(u)` are vertices meeting a colour of `P(v)` — [hand, one mind], §4.5.
- **Y2-T2F** — C-T2 (i) TRUE at fragment level: fragment `T2` (the `d = 1` rhombus, `u`, `v` on unit arcs of `ω(w)`, `ω(w′)`; `w`, `w′`
  four-colour), all 24 same-colour pairs ACCEPT, tight — [tools, exact; derivation hand, one mind], stage 5.
- **Y2-BB** — C-BOW-K (i) TRUE in its double form: fragment `BB` (two straight bowties escaping at both unit points, `30°` margins), 30 pairs
  ACCEPT, tight — [tools, exact; hand, one mind], stage 5.
- **Y2-MX** — one pair can mix the seams: fragment `MX` (T2 at `w`, a bowtie's escape at `w′`), 27 pairs ACCEPT, tight — [tools, exact], stage 5.
- **Y2-LAT** — the translation-invariant triangular-lattice extension of `BB` fails at its four-colour points: six covering pairs through one point
  over-constrain it — [hand, one mind; one candidate, not the question], stage 5.
- *Retracted at stage 6:* §4.4's GAP (ii) in the owner's switch-point step (card 3: it holds only in the disjoint sense).

### Fence log (FS110-Y2)

- **Touch 1 (disclosed):** my first command `ls data/fs110/briefs/ data/fs110/reports/` listed the file names in both directories (the other
  briefs' and reports' names; no content opened). I then read `data/fs110/reports/FS110-Y.md`, which the continuation brief names (permitted there).
- **Touch 2 (disclosed):** a `git log --oneline -1` after start-up showed one commit subject beyond the snapshot: "FS110-N2: stage 5" (the other
  side's neutral subject; nothing else). I use only commit outputs for hashes from here on.
- Nothing else fenced opened, listed or grepped.

### Would-have-searched-here log (FS110-Y2)

- Fragments: a scan over sector angles and arc lengths for an ACCEPT → the angles and sizes derived first (§4.3's facing/away wedges, 30° margins),
  the parameters fixed once (`t = 1/8`, `ρ_u = 1/4`, `ρ_w = 1/10`) and checked; no second value tried.

## Stage 4 — SAVED (FS110-Y2): card 1; the seam-point lemma Y2-W4; the frame facts checked; the (S1) fragment

### 4.1 Read from disk, quotation check

Read: both briefs, `STANDING-RULES.md`, `CLAUDE.md` § The aim and § Counter-priors (l. 74–137, **newer than the copy loaded into my context**:
the aim's links 4–6 and the program paragraph now carry rows 131–133 and FS-110/111), FS110-Y's record in full and its report, `claims.md` in
full, the plan's §G part 3 and §IQ (l. 328–413), `plans/FS106-TS-derivation.md` l. 1–40, §2.2 (l. 114–160), l. 250–280, `tools/fs110_y_check.py`.

| quotation (continuation brief, owner notes, advisor cards) | source | result |
|---|---|---|
| Y's retractions "exactly five shapes", the "fat" row | this record, stage 3 item 1 | match |
| C-TAN-POS, C-BOW-K (i)/(ii), C-T2 (i)/(ii), A-EXACT, A-CIRC, TS-U, C-T-TAN, C-T-BIKE | `claims.md` §1b, §2, §3; TS l. 15, l. 258 | match |
| TS §5: "`|P(x)| ≥ 5` happens only on the null set `X_E`" | TS l. 271 | match |
| A2-V56 ("every vertex has `|P_cl(v)| ≤ 4`" …) and card 1, verbatim from FS110-A2's message | the advisor's record (fenced) | **not checkable at source**; the message's text is what I work |
| the owner's frame fact and its correction ("a four-colour vertex's circle meets at most two colours, and a switch point on it is a covering pair at distance 1 …") | the advisor's record (fenced), via the owner | not checkable at source |

### 4.2 Card 1 (FS110-A2), resent to me verbatim

FS110-Y's stage 3 answered all four points; I leave its verdicts as they are. Two additions, each a new statement, not a retraction:
- *Point 1 (disjointness vs union):* Y2-W4 (§4.3) **uses disjointness**: its count "four distinct colours at `w`" needs `P(u) ∩ P(v) = ∅`; its parts
  (a), (b), (d) need only the union.
- *Point 4 (C-TAN-POS's scope):* Y's verdict rests on A-EXACT's disjointness at `w₀` alone. Y2-W4 adds a **stronger necessary condition from
  A-CIRC at `w₀` itself**: it does not change "only by an escape or T2 at both", but it constrains the partner of an escape (Y2-W4e).

### 4.3 Y2-W4 — what the seam point carries [hand, one mind]

Setting: a full tight a.e.-proper six-colouring by a locally finite map with C¹ boundary arcs having one-sided tangents at vertices; `(u, v)` a
covering pair of closure types, `d = |u − v| ∈ (0, 2)`; `w` a common unit point; `e_u = w − u`, `e_v = w − v`. **Hypothesis (no arc of Γ at `w`):**
neither `ω(u)` nor `ω(v)` runs along a boundary on either side of `w`.

(a) Each branch of `ω(u)` at `w` (tangent `±e_u^⊥`) has tile-interior points accumulating at `w`, lying in finitely many tiles, so some tile `τ`
with `w ∈ cl τ` contains points of that branch; by A-CIRC at `u` its colour is outside `P(u)`, hence in `P(v)` (union). Likewise `ω(v)`'s
branches carry colours of `P(u)`.

(b) The two `ω(u)`-branch colours differ. Let `j` sit on the `+e_u^⊥` branch; `e_u^⊥·e_v ≠ 0` since `d ∈ (0, 2)`; say `> 0`. For any colour-`j` tile
`σ` at `v`: A-EXACT's first clause and connectedness put the cross-distance range of `(τ, σ)` on one side of 1. With `p = v + a ∈ σ`,
`q = w + b ∈ τ`: `|q − p|² = 1 + 2(b − a)·e_v + |b − a|²`, and `τ` holds points `b = t e_u^⊥ + O(t²)` with `b·e_v ≍ t > 0`; letting `b → 0` gives
`|p − w| ≥ 1` for every `p ∈ σ` near `v`: **`σ` lies outside `D(w)`** (faces away). The colour `j′` on the `−e_u^⊥` branch has every tile at `v`
inside `D(w)` (faces `w`). If `j = j′`, every colour-`j` tile at `v` lies in `ω(w)`: not a tile. So `j ≠ j′` — **cusp colours included** (a horn
at `v` would have to lie on `ω(w)`). The same for `ω(v)`'s branches against `u`.

(c) With `P(u) ∩ P(v) = ∅`, the four colours are distinct: **`|P_cl(w)| ≥ 4`**, two from each side, and one of each pair faces its vertex.

(d) A-CIRC at `w`: tile-interior points of `ω(w)` near `u` lie in tiles at `u`, so their colours are in `P(u) ∖ P_cl(w)`, **at most one colour**
`m_u(w)` (none when `|P(u)| = 2`). So near `u`, `ω(w)` runs in tiles of the single colour `m_u(w)` or along boundaries; near `v` likewise.

**Y2-W4e (consequences).**
- *Escape partner.* If `u` is a strong escape at `w` (a bowtie, `ω(w)` through its two `a`-sectors), then `m_u(w) = a` and `P_cl(w) ∩ P(u) =
  P(u) ∖ {a}`; and **`v` must be `ω(w)`-monochromatic**: both directions `±e_v^⊥` at `v` in tiles of the single colour `m_v(w)`, or along
  boundaries. A generic trivalent `v` (the two directions in two sectors of two colours) is excluded. This is sharper than C-TAN-POS's pair
  analysis (FS110-Y §1.4), which lets the partner of an escape be anything.
- *(2, 4) pairs (V5).* If `|P(u)| = 2`, then `m_u(w)` does not exist: `ω(w)` near `u` runs along boundaries **in both directions**, and so does
  `ω(w′)`: a bichromatic degree-`≥ 4` vertex in a (2, 4) covering pair is the crossing point of two unit arcs, centred at `w` and `w′`.
- *The exception is the hypothesis.* With an arc of Γ at `w` (a boundary along `ω(u)` or `ω(v)` through `w`), (a) fails on that branch and `w`
  may carry fewer colours: this is the owner's (S1), §4.5.
- Controls: fragment T2 (stage 5) has `P(w) = {1, 3, 4, 5}`, `m_u(w) = 2` (the arc through `u` is a boundary, so nothing is required) and
  `m_v(w) = 6` (the `210°` direction at `v` lies in `v`'s colour-6 tile); both as (d) requires. The seven-colour control: a seventh colour at `w`
  breaks "outside `P(u)` hence in `P(v)`" in (a); the lemma says nothing there, as it must.

### 4.4 The frame facts, checked (card 2's question and the owner's note)

- **A2-V56** ("every vertex has `|P_cl(v)| ≤ 4`"): **TRUE off `X_E`** (vertices `v` with `σ(ω(v) ∩ E) = 0`, i.e. no boundary arc of positive
  length on `ω(v)`). It is TS §5's own result (TS l. 271: `|P(x)| ≥ 5` forces `σ(ω(x) ∩ E) ≥ 1/2`). **At a centre of arcs of Γ it is a GAP**: `|P(v)| = 5`
  needs boundary arcs on `ω(v)` of total length at least half the circle, and nothing I hold excludes that (FS110-A3's card 2 is right that the
  60° step needs two tile-interior points `60°` apart). [read + hand, one mind]
- **The owner's combined step** (a switch point on a four-colour vertex's circle is a covering pair at distance 1): **GAP at two steps** [hand, one
  mind]: (i) arcs of Γ on `ω(v)` can separate the two outside colours (card 2's point); (ii) **a switch point can be a vertex `x` carrying a third
  colour `j ∈ P(v)`**: `ω(v)` passes from the `m`-sector straight into the `m′`-sector at `x`, with the `j`-sector beside it on one side of
  `ω(v)`; then `P(x) ∩ P(v) = {j}` and `(v, x)` is not a covering pair. I find nothing that excludes (ii): A-CIRC at `v` holds (no interior point of
  `ω(v)` is coloured `j`), the `j`-sectors at `v` and `x` can face each other consistently, and A-CIRC at `x` only asks that `ω(x)` avoid `j`
  near `v`. So "Act One is open only for maps with at most three colours per vertex" is not yet earned.

### 4.5 The (S1) fragment — a unit arc through `w₀` centred at a bowtie (the owner's first priority) [tools, exact; hand, one mind]

**Formula** (d = 1; `u = 0`, `v = (1, 0)`, `w = e₆₀`, `w′ = e₃₀₀`; colours `a, b, c = 1, 2, 3`; `e_θ` the unit vector at `θ°`; `ρ = 1/4`;
`t = 1/8`, the arc half-angle `2 arctan t ≈ 14.25°`):
- `u`: bowtie, straight sectors truncated at `ρ`: `a` on `(300°, 60°)` and `(120°, 240°)`; `b` on `(60°, 120°)`; `c` on `(240°, 300°)`. The escape
  lines at `w` (`150°/330°`) and at `w′` (`30°/210°`) lie in the `a`-sectors with margin `30°`.
- `v`: **generic trivalent**, `4` on `(300°, 60°)`, `5` on `(60°, 180°)`, `6` on `(180°, 300°)` (no ray along any tangent that matters).
- `w`: a boundary **arc of `ω(u)`** (centre `u`, radius 1) from `e_{60°−α}` to `e_{60°+α}`, `α = 2 arctan(1/8)`, endpoints in ℚ(√3); inner side
  (toward `u`) colour `b`, outer side colour `c`, each tile closed by two segments to `(9/10)w` resp. `(11/10)w`. `w` is **a two-colour edge
  point**, not a vertex.
- `w′`: the mirror: an arc of `ω(u)` through `w′`, inner `c`, outer `b`.
- Symmetry: the reflection `y ↦ −y` with colour permutation `(2 3)(5 6)`; group of order 2.

**Exact check** (`tools/fs110_y_fragments.py --frag S1`): 11 tiles, all 18 same-colour pairs generated from the colour map (every tile against
itself included): **ACCEPT**. Tight: four contacts at exactly 1 (`u_b`–`w_in` Siamese `[0.65, 1]`, `u_b`–`w′_out` outer `[1, 1.35]`, and the two `c`
mirrors); the checker's `closed_interval` plant turns the fragment REJECT, which certifies the exact contacts. **Plant `s1_flat`** (the arc through
`w` replaced by its chord path, so the interface is no longer an arc of `ω(u)`): REJECT at `(u_c, w_out)`, range `≈ [0.992, 1.35]` — the outer
colour's tile now reaches inside `D(u)`, for its own reason. Float geometry guard: no overlaps, each flower covers a disc of radius `0.05`.

**What every (S1) realisation carries (X13; Y2-S1i)** [hand, one mind], when `w` is an edge point of the arc:
1. `ω(v)` crosses the arc transversally at `w`; its two branches lie on the two sides, carry `P(u)`-colours (A-CIRC at `v`), so **the arc's two
   side colours are `u`'s facing and away colours at `w`** (Y2-W4 (b)), both in `P(u)`; TS-U at `u` agrees (inner facing, outer away, neither in
   the side cones about `±e_u^⊥`).
2. Every point near `w` has a colour of `P(u)`, so `B_u(s) ∩ B(w, c)` must be empty: **`u` is a strong escape at `w`**; with A-CIRC at `w`,
   `ω(w)` near `u` runs in the third colour `a`, the bowtie's repeated one.
3. **The partner `v` is free**: nothing at `w` involves `P(v)` (fragment S1's `v` is generic). The whole seam sits at `u`.
4. The arc of Γ must end: past its ends, tile-interior points of `ω(u)` carry colours outside `P(u)` (A-CIRC at `u`), so **each end on `ω(u)` is a
   vertex meeting a colour of `P(v)`**, at distance 1 from `u`, of type `⊇ {b, c, j}`.

**What it answers.** A covering pair can be saved at both unit points with **no vertex at the seam point and no four-colour vertex anywhere in the
fragment**; the fragment has at most four colours per vertex, and only at `u` (a bowtie, three colours). So the seam point `w₀` need not be a vertex:
any argument that works at `w₀` as a vertex (Y-T2W, N-X, Y2-W4) sees nothing at (S1). A kill of (S1) has to act at `u` or at the arc's ends
(item 4). C-BOW-K (i) in this form: **TRUE** (a strong escape with arcs of Γ, realised locally). C-BOW-K (ii): untouched.

## Stage 4 — SAVED (FS110-Y2)

## Stage 5 — SAVED (FS110-Y2): the T2 rhombus, the double bowtie, the mixed pair — three fragments by formula, checked exactly

All on the `d = 1` rhombus of §4.5, colours `P(u) = {1, 2, 3}`, `P(v) = {4, 5, 6}`, arcs with half-angle `2 arctan(1/8)`, straight rays at `u, v`
truncated at `1/4`, quadrant squares of side `1/10` at `w, w′`. `R` is the half-turn about `(1/2, 0)` (`u ↔ v`, `w ↔ w′`), with the colour involution
`(1 4)(2 5)(3 6)`. Tool: `tools/fs110_y_fragments.py`; outputs `data/fs110/fs110-y/y2_fragments_*.out`. **Every same-colour pair is generated
from the colour map**, including each tile against itself.

| fragment | formula | symmetry | pairs | verdict | planted faults (each REJECT for its own reason) |
|---|---|---|---|---|---|
| **T2** (C-T2 (i)) | `u` lies on a full arc of `ω(w)` (rays `150°, 330°`: inner `3`; outer `1` on the `150°` half, `2` on the `330°` half) plus a ray along `ω(w′)` at `210°` (inner `2`, outer `1`); `v = R(u)`; `w`: `(0°,90°) 1, (90°,180°) 4, (180°,270°) 3, (270°,360°) 5`; `w′ = R(w)` | `{1, R}` | 24 | **ACCEPT**, tight (8 contacts at exactly 1) | `t2_flip` (swap `1, 3` at `w`: facing colour put away) → `(u_1,w_2)`, `(u_3,w_0)`; `t2_flat` (the arcs of `ω(w)` at `u` replaced by chords: a T1 interface, curvature 0 against 1) → `(u_1, w_0)` range `≈[0.992, 1.372]`; `t2_six` (colour 6 at `w`: `v`'s 6-sector straddles `e_v^⊥`) → `(v_3, w_1)` |
| **BB** (C-BOW-K (i)) | `u`: bowtie `1` on `(300°,60°)` and `(120°,240°)`, `2` on `(60°,120°)`, `3` on `(240°,300°)`, all straight; `v = R(u)`; `w`: `3, 5, 2, 6` by quadrant; `w′ = R(w)` | Klein four: `R` and `y ↦ −y` with `(2 3)(5 6)` | 30 | **ACCEPT**, tight | `bb_rot` (`u`'s bowtie turned `60°`: its repeated colour no longer holds the escape lines) → `(u_b, w_2)`, `(u_c, w_0)` |
| **MX** (the mixed pair) | `u`: bowtie `1` on `(330°,60°)` and `(150°,240°)`, `2` on `(60°,150°)`, `3` on `(240°,330°)`, **lying on a full arc of `ω(w)`** (rays `150°, 330°` exact; `60°, 240°` straight): T2 at `w`, strong escape at `w′`; `v` = T2's `v`; `w`: `3, 4, 2, 5`; `w′`: `6, 3, 4, 2` | none | 27 | **ACCEPT**, tight | (the T2 and BB plants cover its two mechanisms) |

The checker's `closed_interval` plant turns all four fragments (with S1) REJECT: each has contacts at exactly 1. Its `noself` and `endpoints_only`
plants cannot fire here (every tile's diameter is below 1, and no extreme sits only at an interior point): unreachable, so they test nothing on
these fragments (they were tested on FS110-Y's controls). Float geometry guard: no overlaps; each flower covers a disc of radius `0.05`.

**Derivations behind the formulas** [hand, one mind]. Every sector was placed by §4.3's facing/away rule before any check: at `w`, a colour of `P(u)`
whose tiles at `u` face `w` (inside `D(w)`) sits only in `{x·e_u ≤ 0}`, one that faces away only in `{x·e_u ≥ 0}`, a colour whose sector at `u`
straddles `e_u^⊥` not at all; TS-U adds the side cones. In T2 this forces `w`'s four quadrants up to the choice `1` or `2` on the `30°` branch
(taken `1`), and excludes `6` from `w` (the `t2_six` plant shows it). In BB the margins are `30°` everywhere, so the fragment is robust: it is
entirely polygonal.

**Verdicts.**
- **C-T2 (i): TRUE at fragment level** [tools, exact, for the member; hand, one mind, for the derivation]: the double unit-arc seam is consistent at
  `u, v, w₀, w₀′`. Its cascade inside the fragment closes: `w, w′` are four-colour vertices (`P(w) = {1, 3, 4, 5}`, `P(w′) = {1, 2, 4, 6}`), and every
  other close pair among the four points has intersecting types. This answers FS110-Y's GAP at the formula fragment.
- **C-BOW-K (i): TRUE** [tools, exact; hand, one mind]: a strong escape at a bowtie, in two forms: the double bowtie BB (both vertices escape at both
  unit points), and (S1) (§4.5). Neither is a refutation of the NO, which must win at (ii).
- **The mixed map (item 3 of my brief): a single pair can mix the two seams** [tools, exact]: MX saves `(u, v)` at `w` by T2 at both vertices and at
  `w′` by `u`'s escape. Y2-W4e's constraint on an escape's partner is met by `v`'s full arc of `ω(w′)`.
- **Y2-W4 (d) on the three fragments** (a control, not a proof): T2 has `m_u(w) = 2` (the arc through `u` is a boundary) and `m_v(w) = 6` (`v_3`
  holds the `210°` direction); BB has `m_u = 1` and `m_v = 4`, each the bowtie's repeated colour; MX has `m_u = 1`, `m_v(w) = 6` and `m_v(w′) = 5`
  (the full arc through `v`). All as required.

**The invariant each carries (X13, G79's flip)** [hand, one mind]:
- **T2:** `u, v` emit arcs of `ω(w)` and `ω(w′)`. `w, w′` are four-colour vertices, and **`ω(w)`'s tile-interior points are two-coloured by
  `P(w)`'s complement**, with `c(x + 60°) ≠ c(x)` (TS §5, the four-colour case). Near `u` it runs along the arc or in `m_u(w)`.
- **BB:** both vertices are bowties whose repeated colours hold both escape lines. `w, w′` are four-colour vertices whose circles are two-coloured
  by the two repeated colours `{a, a′}`. On `ω(w)`, `u` (at `240°`) and `v` (at `300°`) sit `60°` apart, with `a ≠ a′`, as the alternation requires.
- **(S1):** a bowtie centred on arcs of Γ. The seam point is an edge point and the partner is free. The arcs' ends are vertices meeting `P(v)`.
- **The lattice warning (a measurement of one candidate, not of the question):** extending BB translation-invariantly over the unit triangular
  lattice (all unit `A`–`B` pairs covering, `C`-points four-colour) fails at the `C`-points. Six neighbours put six unit circles through each
  `C`-point, so its sectors alternate `{b, c}` and `{b′, c′}` in six `60°` sectors. Two of the three `{b, c}` sectors then share a colour, and that
  colour lies in both the facing and the away half-plane of one `A`-neighbour. This names a cost for the global form (C-BOW-K (ii)): a seam point
  with more than two covering pairs through it is over-constrained.

**Left for a successor** (brief items not reached; budget):
- C-T-BIKE beyond Y-BIKE-3C's family (item 4).
- The global forms C-T2 (ii) and C-BOW-K (ii): how the arcs of Γ in (S1) end, and whether four-colour circles (T2, BB) close up.
- The GAP in A2-V56 at centres of arcs of Γ (§4.4).

## Stage 5 — SAVED (FS110-Y2)

## Stage 6 — SAVED (FS110-Y2): card 3 (FS110-A3, "which covering pair?") — one free retraction

**Retracted: §4.4's GAP (ii)** in the owner's switch-point step. I set the switch vertex `x = {m, m′, j}`, `j ∈ P(v)`, aside as "not a covering
pair" because `P(x) ∩ P(v) = {j}`. That is true only in `claims.md` §0's disjoint sense. In the union sense, `P(v) ∪ P(x) = [6]`. The machinery a
covering pair feeds needs only the union: A-EXACT's `B_v ∩ B_x = ∅` (a point in both would need a colour outside the union), and C-T-TAN through
A-SIX ("all six classes are in `P(u) ∪ P(v)`"). **So a switch point at such a vertex is still a covering pair at distance 1 for every purpose the
frame fact serves.** The owner's combined step keeps **one** GAP, card 2's: arcs of Γ on `ω(v)` separating the two outside colours. [hand, one mind]

**Which sense each of my round-2 statements uses** (card 3's question):
- Y2-W4 (a), (b), (d): the union. (a) needs "outside `P(u)` implies in `P(v)`". (b) needs only the colour's tiles at one vertex. (d) needs
  `|P_cl(w) ∩ P(u)| ≥ 2`, which (b) gives in the union sense: two distinct colours outside `P(v)`, hence in `P(u)`.
- Y2-W4 (c) ("four distinct colours"): **disjointness**, as §4.2 says. Under the union alone, `|P_cl(w)| ≥ 3` when the types overlap in one colour.
- Y2-W4e and Y2-S1i: the union. The escape-partner rule runs through (d). "`u` must escape at `w`" runs through A-EXACT's `B_u` alone.
- Fragments S1, T2, BB, MX: disjoint types (`{1,2,3}`, `{4,5,6}`), so both senses hold.

## Stage 6 — SAVED (FS110-Y2)

## § Continuation — FS110-Y3

*Job FS110-Y3 (de Bruijn, Opus 5.5), 2026-09-27, round 3 (the winding question W-3). Brief: `data/fs110/briefs/Y3-110-round3.md` (wins where they
differ) with `data/fs110/briefs/Y110-construction.md` and `data/fs110/briefs/STANDING-RULES.md`. Start-up snapshot `2d4c49f8`. Earlier verdicts above
are FS110-Y's and FS110-Y2's and are not rewritten. Working files `data/fs110/fs110-y/y3_*`; tools `tools/fs110_y_*.py`; scratch
`scratchpad/fs110-y3/`.*

### The pre-round question (answered before my first saved stage; sent to "main" word for word)

*"Before your first saved stage of round 3, name the step of the proof side's programme on W-3 that you expect to fail, and say what would show you
wrong."* (my brief, § Your task)

I do not hold the proof side's programme on W-3 (fenced); I answer against `claims.md` §7's list. **The step I expect to fail is the passage from the
local winding data to a global contradiction, at the vertices that data does not constrain:** the trichromatic vertices of degree `≥ 4` (bowties
`a, b, a, c`, which Condition 5 allows and S–V's Condition 6 forbids) and the bichromatic vertices of degree `≥ 4`. W-3's hypotheses put the ring
condition (`|W| ≥ 2`, consistent along edges) on **trivalent** vertices only. In print, Condition 6 enters S–V's Theorem 1 exactly there (Lemma 4,
Props. 9–10, Cor. 2; `plans/FS110-PA-prior-art.md` stage 2 item 5), and their Lemma 3 (the bicycle kill) assumes "the boundaries between each pair of
colors in their multicolor extend from each of them" (S–V p. 17, via FS110-PA stage 2 item 4), which a bowtie `a, b, a, c` fails (no `b|c` boundary).
So I expect a winding map, if one exists, to carry its global count through degree-`≥ 4` vertices whose rings need not wind, and a NO to stall at
pricing them. **What would show me wrong:** a lemma, under Condition 5 in `𝓜_K`, that every trichromatic and every bichromatic vertex of degree `≥ 4`
is absent from a winding map or carries a ring of `|W| ≥ 2` with the consistent sign (so the count closes over all vertices); or a kill of bowtie
same-type pairs in `(1, 2)` that does not use Lemma 3's extension hypothesis.

### Which Condition 5 I use

The print's: "If any boundary intersects with a circle of unit radius at a finite set of points, we say that arcs of unit curvature are forbidden."
(`[SokolovVoronov2025]` p. 4, quoted in `claims.md` §1). **In `𝓜_K` it coincides with the claim list's gloss "no boundary arc of radius 1"**
[hand, one mind, trivial]: a boundary is a finite union of straight or circular arcs (at most `K` per tile, at most `K` tiles per unit disc, so a unit
circle, being compact, meets finitely many arcs); a segment meets a circle in at most two points, and a circular arc meets a unit circle in at most two
points unless it lies on it, i.e. has radius 1 and that centre. The same holds for LIM with the same arc bounds. (Beyond `𝓜_K`, e.g. for arcs with
infinitely many wiggles, the print's form is the weaker hypothesis on the map; nothing here uses that case.)

### Theorems this phase proved (FS110-Y3)

- **Y3-RING** — `tools/fs110_y_ring.py`: Y3-GP checked exactly on six named rings (three aligned, three in general position, `W = 0, 2, 3, 3, −3, 9`),
  two plants each firing for its own reason — [tools, exact], stage 9.
- **Y3-C5** — in `𝓜_K`, the print's Condition 5 and "no boundary arc of radius 1" coincide — [hand, one mind, trivial], above.
- **Y3-GP** — a ring (§7.1's) whose change points are never at angular distance `≡ 0 (mod 60°)` from one another winds `W ≡ 3 (mod 6)`; so
  `W ∈ {0, ±1, ±2}` needs two change points at distance 1, `√3` or 2 — [hand, one mind; `tools/fs110_y_ring.py` checks it on named rings], §8.2.
- **Y3-PROP** — N2-TRANS rederived from NB-4 and NB-5 at both ends of the edge, at every vertex with `|P_cl| = 3` (bowties included) and through
  bichromatic vertices on edges of one colour pair; `|W|` is one constant on a connected map — [hand, one mind; N2-TRANS's second derivation], §8.3.
- **Y3-FLIP** — a tile with all boundary vertices of type `{a, b_{i−1}, b_i}` returns the ring orientation with sign `(−1)^k`, `k` the same-type steps
  — [hand, one mind, derived before §7.1 arrived; agrees with N2-FLIP's statement], §8.3.
- **Y3-BOW** — at a bowtie `(a, b, a, c)`, tile `b`'s flanking vertices `{a, b, x}`, `{a, b, y}` (next trichromatic vertices along its two `b|a` edges)
  satisfy `x = y` or `c ∈ {x, y}` in a winding map, else `W = 0`; so the bowtie counts as one merged neighbour of tile `b`, a same-type step iff
  `x = y` — the count extended to bowtie-flanked tiles — [hand, one mind], §8.4.
- **Y3-SIX** — no vertex of degree 3 with three essential sectors has a ring of exactly six arcs (the aligned `|W| = 2` ring), in a tight six-map in
  `𝓜_K` under Condition 5 with NB-4 and NB-5 — [hand, one mind; the distances exact], §8.5.

### Fence log (FS110-Y3)

- **Touch 1 (10:4x UTC, disclosed):** an `rg -l` for the round-2 labels "N2-TRANS|N2-FLIP|N2-SWAP", with the fenced paths excluded, returned the
  **file name** `tools/fs110_nb_ring.py` (the blind verifier NB's tool, which my exclusion list missed: it named `tools/fs110_n_*` only). No content
  was printed or opened. I treat the verifier's tools as fenced from here on.
- **Touch 2 (10:42 UTC, disclosed):** a `git log --oneline -1` printed one commit subject beyond the start-up snapshot: "FS110-YB: stage 2" (the
  construction side's blind verifier's neutral subject; nothing else). I take hashes from commit outputs only from here on.

### Would-have-searched-here log (FS110-Y3)

- (none yet)

## Stage 7 — SAVED (FS110-Y3): the pre-round answer, Condition 5, the definitions requested

The pre-round answer and the Condition-5 statement above, sent to "main" at 10:4x UTC with a request for the round-2 definitions W-3 is stated in
("ring", `W`, N2-TRANS's "consistently along edges", N2-FLIP's "count"/"even", N2-SWAP's "swap", A4-BAND, "same-type monotone pair", "transposed
swap"): `claims.md` §7 names them, and every source that defines them is fenced for me. Retractions are counted from here on.

## Stage 7 — SAVED (FS110-Y3)

## Stage 8 — SAVED (FS110-Y3): the winding frame rederived; Y3-GP, Y3-BOW, Y3-SIX

### 8.1 Reconciliation with `claims.md` §7.1 (read from disk after commit `dacc10e3`)

My first-principles reading (sent to "main" at stage 7) and §7.1 **agree** on the ring (`ω(u)°` coloured by `t^c`), on `W` (the lift's turn count
over 3), on N2-TRANS (the third colour of `u′` replaced by that of `u`) and on the count `k` with parity `(−1)^k` (Y3-FLIP was derived before §7.1
arrived; its bookkeeping is §7.1's). **Differences:** (i) N2-TRANS's hypothesis is "an Act-One-free map without unit arcs"; mine is NB-4 and NB-5 at
both ends of the edge, which is what the homotopy uses (the list of bad types below). (ii) I work, as card 4 asks and N3 answered, with "trivalent"
read as `|P_cl(u)| = 3` at any degree. (iii) §7.1's swap point I do not use.

### 8.2 Y3-GP — the winding of a ring in general position [hand, one mind]

Ring colours `ℤ/3`, lift `h` (`±1` at each change point), `D(θ) = h(θ + 60°) − h(θ)`, defined off change points and their `−60°` translates. `D ≢ 0
(mod 3)` there (N-E0). **General position:** no two change points at angular distance `≡ 0 (mod 60°)`. Then `D` changes by `±1` at one event at a
time, so it stays in one window `{3m + 1, 3m + 2}`. At the six points `θ + 60°k` the values `D_k` sum to `3W`. When `θ + 60°k` crosses a change point,
`D_k` and `D_{k−1}` move by `∓1` and `±1`: the number `n₂ = #{k : D_k = 3m + 2}` is invariant, and `n₂ ∈ {0, 6}` is impossible (the first event would
push a `D` to `3m` or `3m + 3`; every ring has change points, its arcs being `≤ 60°`). Closure `Σ D_k ≡ 0 (mod 3)` gives `n₂ ≡ 0 (mod 3)`, so
`n₂ = 3` and **`3W = 18m + 6 + n₂ = 18m + 9`: `W = 6m + 3`.** Hence `|W| ≥ 3` for every ring in general position, and `W ∈ {0, ±1, ±2}` needs two
change points of `ω(u)` at distance 1, `√3` or 2. Controls: the alternating two-colour ring (six arcs of `60°`, `W = 0`) and the ring `4,5,6,4,5,6`
of six `60°` arcs (`W = 2`) are both aligned; nine arcs of `40°` give `W = 3`. **Consequence for W-3:** "`|W| ≥ 2`" is automatic at a ring in general
position; it constrains only aligned rings.

### 8.3 Y3-PROP and Y3-FLIP — N2-TRANS and the count, rederived [hand, one mind; a second derivation of N2-TRANS's statement]

Along an edge with colours `{a, b}` from `u = {a, b, c}` to `u′ = {a, b, d}`, every circle `ω(z)`, `z` on the edge, has its tile-interior points
coloured in `[6] ∖ {a, b}` (A-CIRC at `z`). Merge `c ~ d`; the three classes are `[cd]` and the two others `e, f`. The colouring of the swept region
maps continuously to `|K₃|` off points whose closure type meets all three classes, i.e. of type `{c, e, f}` (complementary to `u′`) or `{d, e, f}`
(complementary to `u`) — NB-4 excludes the four-sets. Every swept point is within distance `≤ 2` of both `u` and `u′` (the edge lies in a tile of
diameter `≤ 1`), so NB-5 excludes both types (the case of distance exactly 2 is W-TAN's separate `d = 2` configuration). The rings `ω(u)`, `ω(u′)` are
homotopic in the good set: `W(u)` on `(d, e, f)` equals `W(u′)` on `(c, e, f)`. The argument never uses the degree of `u` or `u′`, so it holds at
bowties, and along a path of edges of one colour pair through bichromatic vertices. On a connected map `|W|` is therefore one constant. Y3-FLIP is
§7.1's bookkeeping, found independently (the two outside labels leapfrog; the ring's parity is `(−1)^k`).

### 8.4 Y3-BOW — extending the count to a tile flanked by a bowtie's repeated colour [hand, one mind]

Bowtie `β = (a, b, a, c)`; tile `B` of colour `b` meets `β` between the two `a`-sectors, along two `b|a` edges; `v = {a, b, x}` and `v′ = {a, b, y}` the
next trichromatic vertices along them. **One path:** every circle about a point of the two edges avoids `{a, b}`; merging `x ~ y` and applying 8.3's
argument (bad types `{c, y, ·}`, `{c, x, ·}` complementary to `v`, `v′`; the path lies in `cl B`, diameter `≤ 1`) gives `W(v)` on `(c, y, z) = W(v′)` on
`(c, x, z)`, the map `y ↦ x`. **Two steps:** N2-TRANS from `v` to `β` then from `β` to `v′` gives the map `c ↦ x, y ↦ c`. The two differ by the
transposition `(x c)` of the target unless `x = y` (both identity) or `c ∈ {x, y}` (both `y ↦ c` or both `c ↦ x`). **If `x, y, c` are distinct, both
homotopies are valid and disagree, so `W(v′) = −W(v′) = 0`**: a winding map has `x = y` or `c ∈ {x, y}` at every bowtie flank. In count terms: merge the
bowtie's two `a`-neighbours of `B` into one (as at a bichromatic vertex); the merged step is same-type iff `x = y`, and the parity rule `(−1)^k` then
holds for `B`. Controls: at a bichromatic vertex on a `b|a` edge the same one-path argument is 8.3's; at a trivalent corner the two edges have different
colour pairs and no single merge exists, so no extra constraint arises there.

### 8.5 Y3-SIX — no ring of exactly six arcs at a vertex of degree 3 [hand, one mind]

`u = 0` of type `{1, 2, 3}`, three essential sectors; ring of exactly six arcs. Each arc is `≤ 60°` (A-EXACT's first clause), so all are exactly `60°`;
by Y3-GP's closure the colours run `r₀ r₁ r₂ r₀ r₁ r₂` (`W = ±2`; a two-colour ring winds 0). Put the change points at `p_θ = e_θ`, `θ = 0°, 60°, …, 300°`.
1. **Lens.** Every tile of colour `r` whose closure contains `p_θ` and which carries the arc `(θ, θ + 60°)` lies in `D̄(p_{θ+60°})` (diameter `≤ 1`;
   Siamese for a second such tile). So at `p_θ` the two arc colours are confined to `D̄(p_{θ−60°})`, `D̄(p_{θ+60°})`, and the **outward wedge** of
   directions `(θ − 30°, θ + 30°)` lies outside both: it carries a third colour `j(θ)`, so `p_θ` is a vertex of type `{r_prev, r, j(θ)}` (NB-4), and
   `j(θ) ∈ {1, 2, 3}` (NB-5: `{r₀, r₁, r₂}` is complementary to `u` at distance 1).
2. **Facing away.** The `j(θ)`-tile at `u` and the one in the outward wedge at `p_θ` are distinct (a tile joining them crosses `ω(u)`, against A-CIRC
   at `u`); their cross-distance near `(u, p_θ)` is `1 + 2e_θ·(v − w) + …` with `e_θ·v > 0` on the wedge, so they are outer, and **`S_{j(θ)} ⊂ [θ + 90°,
   θ + 270°]`**. Antipodal change points give `j(θ) ≠ j(θ + 180°)` (else `S_j` has angle 0).
3. **Adjacent change points differ.** `ω(p_{60°})` passes through `p₀` along `30°/210°`. Its branch at `30°` lies in a tile at `p₀`, of colour in
   `P_cl(p₀) ∖ P_cl(p_{60°}) ⊆ {r_prev, j(0°)} ∖ {j(60°)}` (A-CIRC at `p_{60°}`; a boundary along the branch is a unit arc, excluded by Condition 5).
   Colour `r_prev` is impossible: such a tile lies in `D̄(p_{300°})` (step 1), while `|p₀ + s e_{30°} − p_{300°}|² = |e_{60°} + s e_{30°}|² = 1 + √3 s + s²
   > 1`. So the branch is in the outward `j(0°)`-tile and **`j(0°) ≠ j(60°)`**; by rotation, `j(θ) ≠ j(θ + 60°)` for every `θ`.
4. **No room.** The six change points with "adjacent or antipodal ⟹ different" form `K_{3,3}` (odd differences), whose colour classes lie within
   `{0°, 120°, 240°}` or `{60°, 180°, 300°}`. A class of two change points `120°` apart confines its sector to a `60°` wedge (step 2); a class of three is
   empty. So the three sectors total at most `3 × 60° = 180° < 360°`. **Contradiction.** ∎

The inputs: A-EXACT's first clause, A-CIRC, tile diameter `≤ 1`, Siamese-or-outer, Condition 5 (step 3), NB-4 and NB-5 (step 1). **Scope:** degree 3
with three essential sectors. At a bowtie the sector count changes (four sectors, one colour twice) and step 4 is open. **What it kills:** the aligned
`|W| = 2` world with six-arc rings — the rigid "triangular lattice" picture, in which every trivalent vertex's six unit neighbours are its change
points (types `2Λ`-periodic, the stars of `K₄`) — dies at every vertex, not only globally.

### 8.6 A free retraction, counted (the pre-round answer)

My pre-round answer said a winding map could carry its count "through degree-`≥ 4` vertices whose rings need not wind". **Withdrawn for trichromatic
ones:** by Y3-PROP a bowtie's ring is joined by N2-TRANS to its neighbours' rings, so it carries the same `|W|` (and N3's reading of card 4 puts it
under the ring condition anyway); Y3-BOW adds a constraint at bowtie flanks. **Standing for bichromatic ones:** their rings are four-coloured, carry no
`W`, and are free in the count. The question "what would show me wrong" now asks for a lemma on bichromatic degree-`≥ 4` vertices only, and for a kill of
bowtie pairs without S–V Lemma 3's extension hypothesis.

### 8.7 W-3 on the construction side: no YES; what a winding map must now carry (X13, G79's flip)

No winding map is proposed: I hold no formula whose rings, tiles and distances meet the list below, and none was searched for. What every winding map
must carry, from rounds 1–3:
- **every ring with `|P_cl| = 3`** (any degree) winds one global `|W|` (Y3-PROP); **`|W| ≥ 3` (odd, `≡ 3 mod 6`) unless some ring is aligned** (Y3-GP);
  so a ring has at least nine arcs (`|W| = 3`) or at least eight with a unit-distance pair of change points (`|W| = 2`);
- **no degree-3 ring of exactly six arcs** (Y3-SIX): the smallest aligned ring is dead;
- every tile even (N2-FLIP), extended at bowtie flanks with `x = y` or `c ∈ {x, y}` (Y3-BOW);
- no four-colour vertex (NB-4), no close covering pair (NB-5), no boundary arc of radius 1 (Condition 5), not polygonal (W-POLY, bar `d = 2`).
**The obstruction my constructions meet** [a reading, one mind]: the rigid designs available by formula — lattice-periodic, aligned rings, change
points at unit distance, the only kind I can check exactly with tight contacts — are exactly the aligned rings Y3-GP and Y3-SIX constrain; the generic
`|W| = 3` ring has nine or more arcs whose change points are nowhere at unit distance, so its tight contacts must come from elsewhere. **Killing test:**
a winding map with every ring aligned, or a tight six-map in `𝓜_K` with a ring of eight aligned arcs at a degree-3 vertex.

### Would-have-searched-here (added)

- Y3-SIX step 4: enumerate the `3⁶` assignments of third colours to the six change points → the `K_{3,3}` independent-set argument.
- A winding map: a scan over lattice-periodic curved designs for rings of `|W| ≥ 2` → the necessary list of §8.7, and no candidate.

## Stage 8 — SAVED (FS110-Y3)

## Stage 9 — SAVED (FS110-Y3): the ring checker; hand-back

`tools/fs110_y_ring.py` [tools, exact]: rings given by formula (change points in exact rational degrees), validity `c(θ) ≠ c(θ + 60°)` tested on every
cell of the refined partition, `W` from the signed lift, general position, and Y3-GP's implication. Outputs `data/fs110/fs110-y/y3_ring_*.out`.

| ring (formula) | valid | `W` | general | Y3-GP |
|---|---|---|---|---|
| alternating two colours, six `60°` arcs | yes | 0 | no | not applicable |
| `r₀ r₁ r₂` twice, six `60°` arcs | yes | 2 | no | not applicable |
| `r₀ r₁ r₂` three times, nine `40°` arcs | yes | 3 | no | not applicable |
| change points `41°k`, `k < 9` | yes | 3 | yes | holds |
| the same, colours reversed | yes | −3 | yes | holds |
| change points `40°k/3 + k/1000`, `k < 27` | yes | 9 | yes | holds |

**Plants.** `nogp` (Y3-GP applied without its general-position hypothesis) fires on exactly the two aligned rings with `W ≢ 3 (mod 6)` — the hypothesis
is load-bearing. `nolift` (unsigned change count) fires on the alternating ring (`2` for `0`) and on the reversed ring (`+3` for `−3`); it cannot reach a
ring whose steps all go one way (noted, G21). **A slip of mine, found by the checker:** the first formula for the `W = 9` ring (change points `13°k`)
was invalid — its last arc is `22°`, so a `60°` window there spans three arcs and repeats a colour; the checker read `valid=False` and I replaced it by
the derived near-uniform spacing `40°k/3 + k/1000` (no second value tried).

**Left for a successor:** Y3-SIX at bowties (four sectors, step 4); the eight-arc aligned `|W| = 2` ring at degree 3 (Y3-SIX's argument uses unit
distance between every pair of adjacent change points, which eight arcs do not give); whether the generic `|W| = 3` ring (nine or more arcs, no
unit-distance change points) is realisable at a vertex at all — the construction side's next question, and the one a winding map must answer first.

## Stage 9 — SAVED (FS110-Y3)

## § Continuation — FS110-Y4

*Job FS110-Y4 (de Bruijn, Opus 5.5), 2026-09-27, round 4 (the `d = 2` seam, W-4). Brief: `data/fs110/briefs/Y4-110-round4.md` (wins where they
differ) with `data/fs110/briefs/Y110-construction.md` and `data/fs110/briefs/STANDING-RULES.md`. Start-up state: `e89d35d6` (the owner's hand-off
commit; the harness's own snapshot line read `58bf282a`, one commit earlier). Earlier verdicts above are FS110-Y's, Y2's and Y3's and are not
rewritten. Working files `data/fs110/fs110-y/y4_*`; tools `tools/fs110_y_*.py`; scratch `scratchpad/fs110-y3/`.*

### The pre-round question (answered before my first saved stage; sent to "main" 11:5x UTC)

*"before your first saved stage of round 4, name the step of the proof side's programme on W-4 that you expect to fail, and say what would show you
wrong."* (my brief, § Your task)

I do not hold the proof side's programme (fenced); I answer against `claims.md` §8. **The step I expect to fail is turning G-CONE into a pair that a
pair argument decides**: "the two out-contacts `N = v + n`, `S′ = v − n` form a same-multicolour pair at distance 2", which would make G-CONE an instance
of G-d2, or of a bicycle at `d = 2` with `v` at the circles' tangency point. Nothing local forces `N` and `S′` to be vertices, or their types to agree.
I expect a local fragment in which `N`, `S′` are two-colour edge points with different types `{c, p}`, `{c, q}`; then `ω(N)`, `ω(S′)` each avoid
only two colours and no bicycle arises. Behind it, a second expectation: **no local kill of the cone at `v`, `N`, `S′` under Condition 5.** By my
derivation (§10.2), an out-type `c`-tile whose boundary has curvature `λ` at `N` (bending away from `v`) forbids `c` near `v` only above
`y = μ t²/2`, with `μ = λ/(1 + λ)` (`μ = 1` at a corner of that tile). So `c`-horns with bounding curvatures `κ₁ < κ₂` fit whenever
`−μ_S ≤ κ₁ < κ₂ ≤ μ_N`: room with every curvature strictly inside `(−1, 1)`, and no arc of radius 1 is needed.

**What would show me wrong:** (a) a derivation that an out-type contact at `N` forces `N` to be a vertex of the same type as `S′`, or forces a
four-colour vertex, a close covering pair or a unit arc among `v`, `N`, `S′` (NB-4, NB-5, Condition 5); (b) my exact check rejecting the fragment for
a reason the curvature inequality does not explain; (c) a lemma that `v`'s ring (`ω(v)` coloured by the three colours outside `P_cl(v)`) or the horns'
own tiles cannot close near `v ± a`.

### Which Condition 5 I use

The print's: "If any boundary intersects with a circle of unit radius at a finite set of points, we say that arcs of unit curvature are forbidden."
(`[SokolovVoronov2025]` p. 4, as quoted in `claims.md` §1). In `𝓜_K` it coincides with the gloss "no boundary arc of radius 1" (Y3-C5, above:
[hand, one mind, trivial]). Every fragment below has no arc of radius 1 at all.

### Theorems this phase proved (FS110-Y4)

- **Y4-MU** — an out-type `c`-contact at `N = v + n` whose tile's boundary has curvature `λ > −1` there (away from `v`; `λ = ∞` at a corner)
  forbids `c` near `v` exactly above `y = μ t²/2 + O(t³)`, `μ = λ/(1 + λ)`; so `c`-horns at `v` with bounding curvatures `κ₁ < κ₂` need
  `−μ_S ≤ κ₁ < κ₂ ≤ μ_N` (one-sided, per side of `v`), with equality decided at the next order — [hand, one mind; sufficiency realised and
  both directions planted, `tools/fs110_y_cone.py`], §11.2.
- **Y4-WC** — N3-DEG's configuration is realisable locally under Condition 5 with every curvature strictly inside `(−1, 1)`, together with `v`'s
  whole ring (nine pieces, `W = 3`): fragments `WC` (double horn, a trichromatic vertex of degree 4) and `WC1` (single horn, degree 3), ACCEPT,
  tight; `WCEQ` realises the equality `κ = ±μ` with contact arcs — [tools, exact, for the members], §11.3.
- **Y4-TIP** — a cone vertex loses its cone to a one-tile recolouring of a horn tip into `v`'s essential colour on either side unless that colour
  reaches a zero-width window at the opposite contact (`R_y` at `N` for the colour `y` on `S′`'s side; `R_x` at `S′`); recolouring into a colour of
  `v`'s ring is always blocked — [hand, one mind; checked on named fragments], §11.4.
- **Y4-HARD** — tip-hard cones exist locally: fragments `WCH` (cusps of `y`, `x` at `N`, `S′`) and `WC1H` (`N`, `S′` ordinary trivalent vertices
  `{1,3,4}`, `{1,2,5}`; only `v` degenerate) ACCEPT, tight, and every tip recolouring REJECTs for the derived reason — [tools, exact; derivation
  hand, one mind], §11.4.
- **Y4-D2** — at a tip-hard cone the two antipodal contacts `N`, `S′` never have the same closure type (`y ∈ P_cl(N) ∖ P_cl(S′)`); so G-CONE is
  never an instance of the same-multicolour `d = 2` configuration G-d2 — [hand, one mind], §11.5.

### Fence log (FS110-Y4)

- **Touch 1 (11:3x UTC, disclosed):** my first command, `ls data/fs110/briefs/ data/fs110/reports/`, listed the file names in both directories (the
  other briefs' and reports' names; no content opened).
- **Touch 2 (11:3x UTC, disclosed):** an `ls` of the harness scratchpad's root (to create my subdirectory) listed the names of files I did not create
  (`a0.txt` … `a4.txt`, `a2.out`, `a3.out`, `a4.out`, `a3new`, `a3old`). No content opened. I work only in `scratchpad/fs110-y3/`.
- **Touch 3 (disclosed):** a `git log --oneline -1` printed `e89d35d6 Handoff: FS-110 round 4`, the owner's commit preceding my launch; I take it as
  my start-up state and take hashes from commit outputs from here on.

### Would-have-searched-here log (FS110-Y4)

- Fragment parameters (horn and out-tile curvatures, ring directions, window horns): a scan for an ACCEPT → each value derived first from
  Y4-MU and the windows `R_x`, `R_y` with a stated margin, then checked once; no second value tried except where a slip is recorded (§11.3).
- The recolouring moves: enumerating recolourings of the tiles about `v` → Y4-TIP's case split by the target colour.

## Stage 10 — SAVED (FS110-Y4): the pre-round answer; Condition 5

The pre-round answer and the Condition-5 statement above, sent to "main" before this stage was saved. Retractions are counted from here on.

## Stage 10 — SAVED (FS110-Y4)

## Stage 11 — SAVED (FS110-Y4): Y4-MU; the cone realised with its ring; soft and tip-hard cones; the contacts' types

### 11.1 The terms, as I read them (N3's definitions are fenced)

Coordinates `v = 0`, `a = (1, 0)`, `n = (0, 1)`, `N = v + n`, `S′ = v − n`, `c = 1`. **A `c`-horn along `+a`**: a zero-angle corner of a
`c`-tile at `v` between two arcs tangent to `a`, `y = κ₁t²/2` below and `y = κ₂t²/2` above (`κ₁ < κ₂`). **An out-type contact at `N`**: a `c`-tile
`τ` with `N ∈ cl τ`, lying outside `D(v)` near `N` (all cross-distances to `v`'s `c`-tiles `≥ 1`: outer, tight at `(v, N)`). **`D_c(v)`**: I do
not hold N3's definition; I read `int D_c(v) = ∅` as "no direction at `v` admits a `c`-sector of positive angle", which is what Woodall's step 3
(`[Woodall1973]` Thm 6, step 3, read here: "unless X and Y are completely contained within the "cone" outside two unit discs touching each other
at P") excludes. **Hard**: N3-DEG's two bullets, in my brief's words; §11.4 separates *soft* cones (removable by one tile's recolouring) from
*tip-hard* ones, and asks the owner which N3-RED counts.

### 11.2 Y4-MU — what an out-type contact forbids [hand, one mind]

Let `τ` be an out-type `c`-contact at `N` whose boundary on the side `t > 0` is an arc through `N` tangent to `a` with curvature `λ > −1`
(positive: bending away from `v`), `τ` on the far side; a corner of `τ` at `N` with both rays strictly above the tangent line counts as `λ = ∞`.
- *Sufficiency.* If `τ ∩ B(N, r₀) ⊆ D̄(N + n/λ, 1/λ)` (`λ > 0`), then by the triangle inequality every `z` outside the open disc of radius
  `1 + 1/λ = 1/μ` about `N + n/λ` (tangent to the `a`-axis at `v`) has `dist(z, τ ∩ B(N, r₀)) ≥ 1`. At a corner the nearest point of `τ` to `z`
  near `v` is `N` itself, so the allowed region is the exterior of `D(N)`: `μ = 1`.
- *Necessity.* The curve at distance 1 from `Y = λT²/2` on `v`'s side is the parallel curve `y = μt²/2 + O(t³)`, `μ = λ/(1 + λ)` (radius
  `1/λ + 1`). A point `z = (t, y)`, `t > 0`, above it is at distance `< 1` from interior points of `τ` near `N` and `> 1` from others; `int τ` is
  connected, so `z` is at distance exactly 1 from an interior point of `τ`, and `z` is not an interior point of a `c`-tile (A-EXACT's first clause).
- *Hence*, per side: a `c`-horn along `+a` needs `κ₂ ≤ μ(λ_N⁺)` and `κ₁ ≥ −μ(λ_S⁺)`; along `−a` the same with the contacts' other sides.
  `μ < 1` for finite `λ` and `μ = 1` at a corner, so `κ₂ ≤ 1`, and `κ₂ = 1` needs a horn boundary of radius 1 (excluded by Condition 5): N3-DEG's
  strict `(−1, 1)`, derived. `μ → −∞` as `λ → −1` (a unit arc of `ω(v)`). **Invariant (X13):** `μ(λ_N) + μ(λ_S) > 0` on each side carrying a
  horn, so at least one of the two contacts is a strictly convex boundary point or a corner of its `c`-tile.

### 11.3 The cone, realised with its ring [tools, exact, for the members; the formulas hand, one mind]

`tools/fs110_y_cone.py` (imports `tools/fs110_y_check.py`, unedited; data rational). Every same-colour pair is generated from the colour map, each
tile against itself included. Outputs `data/fs110/fs110-y/y4_cone_*.out`.

| fragment | formula | symmetry | pairs | verdict |
|---|---|---|---|---|
| **WC** | `v`: horns `h±` (colour 1) between the circles of radius 2 about `(0, ±2)` (`κ₂ = 1/2`, `κ₁ = −1/2`), length `≈ 0.1`; colour 2 above, 3 below, in the box `[−1/10, 1/10]²`: closure type `{1,2,3}`, essential `{2,3}`, degree 4. `N`: colour-1 tile above the arc of radius `1/2` about `(0, 3/2)` (`λ = 2`, `μ = 2/3`). `S′`: its mirror. **`v`'s ring**: the band `9/10 ≤ r ≤ 11/10`, nine pieces cut at the directions `2 atan t`, `t = ±3/17, ±4/7, ±6/5, ±11/4` and `180°`, coloured `6,5,4,6,5,4,6,5,4` counter-clockwise from the piece about `0°` (`W = 3`); the piece about `90°` (colour 4) wraps `N`'s tile, the piece about `270°` (colour 5) wraps `S′`'s | `y ↦ −y` with `(2 3)(4 5)` | 30 | **ACCEPT**, tight (4 contacts at exactly 1) |
| **WC1** | WC with `h−` removed, the `2\|3` boundary along `−a`: degree 3 | none | 26 | **ACCEPT**, tight |
| **WCEQ** | horns between the circles of radius 3 about `(0, ±3)` (`κ = ±1/3`); contacts bounded by the arcs of radius 2 about `(0, ±3)` (`λ = 1/2`, `μ = 1/3`): **equality**; each horn arc and its contact's arc are concentric at distance exactly 1 (contact arcs) | `y ↦ −y` | 30 | **ACCEPT**, tight |

`N` and `S′` are edge points of types `{1, 4}` and `{1, 5}`: different. No arc anywhere has radius 1 (radii 2, 3, 1/2, 9/10, 11/10); no vertex
carries four colours; no two vertices within distance `< 2` have complementary types. Float geometry guard: no overlaps, discs of radius `0.05` about
`v`, `N`, `S′` and the band `0.93 ≤ r ≤ 1.07` covered (4,917 samples each).

**Planted faults, each REJECT for its own reason:** `wc_flat` (both contacts' arcs of radius 2 about `(0, ±3)`: `μ = 1/3 < 1/2`) → the four
horn–contact pairs, minimum `0.99917`; `wc_fat` (`h+`'s upper boundary a segment of slope `1/10`: a colour-1 sector of positive angle) → `(N1,
h+)` only; `wc_col2` (the ring piece at `90°` coloured 2) → `(r2, v2)` (A-CIRC at `v`); `eq_steep` (WCEQ's upper horn arcs of radius 2: `1/2 >
1/3`) → the `N` side only. The checker's `closed_interval` plant REJECTs exactly the exact contacts (tightness certified); `noself` and
`endpoints_only` cannot fire here (every diameter `< 1`; no extreme only at interior points), so they test nothing on these fragments; `cw_arcs`
fires broadly. **A slip of mine, found by the checker:** WCEQ as first built kept `WC`'s lower horn arc (`κ₁ = −1/2`) against `μ_S = 1/3` and
REJECTed at `(S1, h±)`, range from `0.99917` — the inequality of §11.2 on the `S′` side, for its own reason. Repaired by the derived lower arc
(radius 3 about `(0, −3)`); no other value tried.

### 11.4 Soft and tip-hard cones (Y4-TIP, Y4-HARD) [hand, one mind; tools, exact, on the named fragments]

**The move.** Recolour the tip `Θ = h+ ∩ B(v, t₀)` into a colour `j`. It is legal iff no interior point of a `j`-tile lies at distance exactly 1
from an interior point of `Θ`. Let `x`, `y` be `v`'s essential colours on `N`'s and `S′`'s sides.
- *`j` in `v`'s ring.* `Θ ⊕ S¹` is `ω(v)` translated by at most `t₀` along `a`: a band about `ω(v)` meeting every ring tile's interior off `±n`.
  **Blocked** for every colour the ring uses (all three in a three-colour ring).
- *`j = x`.* A point `q` off the directions `±n` has `ω(q)` crossing the horn transversally, hence meeting `x`'s interior: not `x` (A-EXACT
  against `v`'s `x`-tile; for `q ∈ B_v(s)` also by A-EXACT's second clause). Near `N`, `ω(q)` curves up through the tip into `x` (`κ₂ < 1`): not
  `x`. Near `S′`, with `q = S′ + (T, Y)` (`Y` toward `v`), `ω(q)` curves down: it misses `x` iff `Y ≤ κ₂T²/(2(1 + κ₂))` and enters the tip iff
  `Y > κ₁T²/(2(1 + κ₁))` (maximising `y(t) − boundary(t)` over `t`), with `T = O(t₀)`. So the recolouring is **blocked for every `t₀` iff
  `x`-interior points accumulate at `S′` inside `R_x = {κ₁T²/(2(1 + κ₁)) < Y ≤ κ₂T²/(2(1 + κ₂))}`** (on each side carrying a horn).
- *`j = y`.* The mirror: blocked for every `t₀` iff `y`-interior points accumulate at `N` inside `R_y = {κ₁T²/(2(1 − κ₁)) ≤ Y < κ₂T²/(2(1 −
  κ₂))}` (`Y` away from `v`).
- *Consistency.* `R_y` lies strictly between `ω(v)` (`Y = −T²/2`) and every admissible contact boundary (`Y = λT²/2` with `λ/(1 + λ) ≥ κ₂`, i.e.
  `λ ≥ κ₂/(1 − κ₂)`); at the extreme the two coincide, which needs `λ = 1`, a unit arc, exactly when `κ₂ = 1/2`.

**So N3-DEG's two bullets give *soft* cones:** in `WC` the tips recolour into 2 or 3 legally (tip tests ACCEPT) and into 4 not (REJECT against
three ring pieces). **A *tip-hard* cone carries `y` at `N` and `x` at `S′`, each reaching a zero-width window tangent to `a`.** Both kinds are
realised:

| fragment | formula | pairs | verdict | tip → 2 | tip → 3 | tip → 4 |
|---|---|---|---|---|---|---|
| **WC** | §11.3 | 30 | ACCEPT | ACCEPT (soft) | ACCEPT (soft) | REJECT (ring) |
| **WCH** | WC plus a double colour-3 horn at `N` in `R_y = [−T²/6, T²/2)` (boundaries: circle of radius 2 about `(0, 3)`, `Y ≈ T²/4`; radius 4 about `(0, −3)`, `Y ≈ −T²/8`), wrapped by the ring piece; its mirror in colour 2 at `S′`. `N`: `{1, 3, 4}`, `S′`: `{1, 2, 5}` | 40 | **ACCEPT**, tight | REJECT at `(tip, xS+)` | REJECT at `(tip, yN+)` | — |
| **WC1H** | the single horn; at `N` the colour-1 contact is the sector `(60°, 180°)` (a corner toward `h+`: `μ = 1`), colour 3 the sector `(0°, 60°)` with its lower ray along `+a` (inside `R_y`), the ring piece below `y = 1`; `S′` the mirror with `(2 3)(4 5)`. **`N` and `S′` ordinary trivalent vertices, all sectors essential; only `v` degenerate** | 30 | **ACCEPT**, tight | REJECT at `(tip, xS)` | REJECT at `(tip, yN)` | REJECT (ring) |

Plants: `wch_ywide` (the colour-3 horns' lower boundary at `Y ≈ −T²/4`, below `R_y`) → `(v3, yN±)`, `(v2, xS±)`; `wc1h_ylow` (colour 3 at `N`
turned to reach `−30°`, below the tangent line) → `(v3, yN)`, `(v2, xS)`. Both for their own reason: colour `y` below `R_y` at `N` sees `v`'s
`y`-tile at distance exactly 1.

### 11.5 What every hard cone carries (X13; G79's flip), and W-4 on the construction side

**Carried by every cone** (N3-DEG's bullets): the curvature sandwich of Y4-MU (one contact at least strictly convex or a corner); `ω(v)` near
`N`, `S′` in colours outside `P_cl(v)`; `ω(N)` near `v` in `x` on both sides and `ω(S′)` in `y` (so `x ∉ P_cl(N)`, `y ∉ P_cl(S′)`); `v`'s ring a
three-colouring of a band about `ω(v)` (A-EXACT's `B_v`), pinched to one-sided regions at `N`, `S′`. **Carried in addition by a tip-hard cone:**
`y ∈ P_cl(N)` and `x ∈ P_cl(S′)`, each reaching its window; so `P_cl(N) ⊇ {c, y, r_N}`, `P_cl(S′) ⊇ {c, x, r_S}` (`r` the ring colour there),
`= ` by NB-4.

**Y4-D2** [hand, one mind]: at a tip-hard cone `y ∈ P_cl(N)` and `y ∉ P_cl(S′)`, so the antipodal contacts never share a closure type: **G-CONE
is not an instance of G-d2**, and no bicycle at `d = 2` about `N`, `S′` arises (their circles avoid different colour sets). At a soft cone the
contacts may be two-colour edge points (WC: `{1, 4}`, `{1, 5}`).

**W-4, construction side — YES locally at G-CONE** [tools, exact, for five members; hand, one mind, for the families]: a vertex whose colour `c`
occurs only as cusp horns along `±a` with bounding curvatures strictly inside `(−1, 1)`, with out-type `c`-contacts at `v ± n`, occurs in a tight
local fragment under Condition 5, with its whole ring, at most three colours per vertex and no close covering pair; tip-hard as well (WCH, WC1H).
**A local fragment is not a map.** What a NO at G-CONE must use is therefore non-local. The places named for a construction (and for the proof
side's aim), each where the fragments stop:
1. the horn tile beyond the contacts' reach (the horn is squeezed into the cusp between the two parallel circles only while `|t|` is below the
   contacts' half-widths; the `c`-tile must fatten after that, all its cross-distances to both contacts `≥ 1`);
2. `v`'s ring closing (here `W = 3`, nine pieces with slack) together with the rings of `N` and `S′`, which pass through `v`;
3. at a tip-hard cone, the contacts' own sectors: `N` carries `y`, which the next cone condition along the `n`-axis may cascade (at `WCH`'s `N`,
   colour 3 is itself a cusp with an out-type contact at `N − n = v` only).
G-d2 is not worked here (CB's circle-only reduction is fenced from me).

**Pre-round answer, scored on my side only** (the proof side's programme is fenced): (a) nothing I derived forces `N`, `S′` to share a type
(Y4-D2 forbids it at tip-hard cones); (b) every REJECT in this stage is explained by Y4-MU, A-CIRC or the windows, including my own WCEQ slip;
(c) the ring closes (nine pieces). None of the three "what would show me wrong" items fired here. Retractions this round: none.

## Stage 11 — SAVED (FS110-Y4)

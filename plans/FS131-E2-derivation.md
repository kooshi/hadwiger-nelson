# FS131-E2 — the cusp case of the both-kind four-colour clause

*Job FS131-E2, Ephodos (Opus 5.5), 2026-10-04. Brief: `data/fs131/briefs/FS131-E2-cusp-case.md`, with `plans/STANDING-RULES.md`. Claim list:
`data/fs131/claims-E2.md`. Working files: `data/fs131/e2/`; tools `tools/fs131_e2_*.py`. Nothing in this milestone is blind (the brief's fences:
none). No agents, no search, no Lean builds.*

## Theorems this phase proved

- **FS131-E2-U1-CUSP** — FS116-V5-U1's four-colour clause holds when a tile at `z` has a cusp there (non-Siamese simple valid fragments, any
  `k`). [hand], one mind; § 2.1, argument § 2.4. Answers Q1: **derived**.
- **FS131-E2-NOBOTH-CUSP** — FS112-N3-NOBOTH holds when a sector at the centre is a cusp (valid maps and fragments, any `k`, Siamese pairs
  allowed, simplicity not assumed). [derived], one mind; § 2.1, argument § 2.5. Answers Q2: **derived**; its own two minds had the case in a
  clause.
- **FS131-E2-SECT** — the sector structure at a point of a segment-and-arc map, with the cone of each sector and the separation of sectors
  (no direction of one sector's open cone lies in another sector's cone). [hand], one mind; § 2.2.
- **FS131-E2-ONESECT** — in a simple map a tile meets a small disc about a point of its closure in one sector. [derived], one mind; § 2.3.
- **FS131-E2-SEP** — in a simple map a tile's cone at a point is a closed interval whose open part meets no other tile's cone there. [derived],
  one mind; § 2.3.
- **FS131-E2-MONSTER** — a valid non-Siamese fragment, simple but for one tile, with a both-kind unit arc at `0`, a cusp at `0`, and three
  colours at `0`; it refutes `four_of_bothKind` as stated at commit `05cb0a3e` (cones `β₁ ≤ β₂`). [tools] exact with the hand validity proof,
  one mind; § 2.6, `tools/fs131_e2_frag.py --variant monster`.
- **FS131-E2-MODEL** — a non-Siamese simple valid fragment with a both-kind unit arc at `0`, a cusp at `0`, and four colours at `0`: the cusp
  case of Q1 is inhabited. [tools] exact with the hand validity proof, one mind; § 2.6, `--variant model`.

## Stage 1 — SAVED

### 1.1 Readback: the quotations

`tools/fs131_e2_quotes.py` checks, by exact substring, every quotation of the claim list against its source and the brief's three quotations
against the claim list; its planted fault (`--plant`, one doubled space inside the V5-U1 statement) turns it red.

```
ok    V5-U1 statement field (claims block 1) in plans/FS116-derivation.md
ok    V5-U1 not-claimed field (claims block 1) in plans/FS116-derivation.md
ok    those fields are FS116-V5-U1's entry
ok    Lean block 2 chunk 1 in RingGerm.lean @ 05cb0a3e
ok    Lean block 2 chunk 2 in RingGerm.lean @ 05cb0a3e
ok    Lean block 3 chunk 1 in RingGerm.lean @ 4f7b949d
ok    Lean block 3 chunk 2 in RingGerm.lean @ 4f7b949d
ok    inventory item 112 in plans/FS131-close-inventory.md
ok    FS112-N3-NOBOTH entry in plans/FS112-derivation.md
ok    brief quotation '**Q1 — the cusp case of FS116-V5-U1's fo…' in the claim list
ok    brief quotation '**Q2 — the same for FS112-N3-NOBOTH.** I…' in the claim list
ok    brief quotation '**Q3 — the consumers.** For each result …' in the claim list
checks: 12  QUOTES ALL OK
```

Every quotation matches. One remark, not a mismatch: the claim list's first block is two fields of FS116-V5-U1's entry (`statement:` and
`not claimed:`); in the source its `uses only:` line sits between them. The first version of the checker tested the block as one substring and
failed for that reason alone; the checker now tests the two fields separately and checks that they belong to that entry.

### 1.2 The questions, restated in the claim list's words

The common setting (`data/fs131/claims-E2.md` § The questions): a non-Siamese simple valid fragment; `z` a point of the domain; `A` an arc of `Γ`
on `ω(z)` of extent `[θ₁, θ₂]`, `ℓ = θ₂ − θ₁ > 0`, inner side colour `c`, outer `c′`; `z` carries both. A **cusp at `z`** is a tile with `z` in
its closure whose cone at `z` is a single direction.

- **Q1.** Does `z` carry at least four colours, with no further hypothesis, also when some tile with `z` in its closure has a cusp at `z`?
- **Q2.** Is the centre of a both-kind unit arc a vertex with at least four colours or a repeated colour, also when a tile at the centre has a
  cusp there?
- **Q3.** For each consumer — FS116-V5-DICHO, FS116-V5-CROSS-S, V5's second derivations of FS116-N3-SEMI, -PAIR, -CROSS; FS112-N3-COR3, -PAIRS,
  -END — does it read the clause at a point where a cusp can occur, and what is its fate?

### 1.3 What I read, with addresses

- **FS116-V5-U1** — entry `plans/FS116-derivation.md` l. 1538; argument `plans/FS116-V5-verification.md` § V5-U1's argument (l. 533–552):
  "The two side cones are separated by the facing and away cones, each of which holds a sector of `c` (resp. `c′`); a sector meeting both side
  cones would contain one of those sectors; so (one sector per tile, one tile per colour) two more colours." The argument is about **sectors**,
  and "one sector per tile" is V5's reading of *simple* (V5-DICHO's `uses only`: "simple (one sector per tile at p)").
- **FS112-U1** — `plans/FS112-derivation.md` l. 42: "an inner side colour in `P_cl(P)` has its **sectors** at `P` in the closed cone of width
  `π − ℓ` facing `α`".
- **FS112-N3-NOBOTH** — `plans/FS112-N-proof.md` l. 731–737 (N3 stage N3-3): "One sector (an open angular interval) meeting both side cones
  contains the whole facing or the whole away cone, hence the direction of an inner- or outer-colour sector **(a cusp horn included)**:
  impossible. So the two side cones carry two further colours, or one colour twice." NB3, blind (`plans/FS112-NB3-verification.md` l. 89–95):
  "One colour `γ` in both would need one sector spanning `F` or `A` — impossible, since `s_in`'s sector **(or horn)** lies in `F` and `s_out`'s
  in `A`, and **a horn inside a `γ`-sector already splits it** — so `γ` has two sectors (repeated)". **Both FS-112 minds treated the cusp case
  explicitly**, and both close it the same way.
- **Definitions.**
  - *Valid fragment*: `data/fs116/claims.md` § 0 (from `data/fs114/claims.md` § 0): "a map of an open set containing `D`, bounded by segments
    and circular arcs, six-coloured with no two interior points of one colour at distance exactly 1". The domain is **open**, so `z` is
    interior to it (formally `ArcMap.dom` is open, `Plane/ArcMap.lean` l. 75–77 on `fs131-w3`).
  - *`Γ`, tiles*: "`Γ ⊂ ℝ²` a locally finite union of arcs, C¹ with one-sided tangents at their endpoints …; **Tiles** are the components of
    `ℝ² ∖ Γ`" (`plans/FS110-N-proof.md` § 1.3, as quoted in `data/fs116/claims.md` § 0).
  - *Simple*: "every tile an open disc whose closure meets each other tile's closure in a connected set or not at all, **and does not meet
    itself** — the plane form of `μ = 0`" (`plans/FS114-N-proof.md` l. 444). Formally (`Plane/ArcMap.lean` on `fs131-w3`, `Simple`): every tile
    a Jordan domain (`IsJordanDomain`: its closure a closed disc with the tile as interior), distinct tiles' closures meeting in a preconnected
    set.
  - *Non-Siamese*: no pair of distinct tiles of one colour "that lie entirely within each other's annulus of exclusion" (de Grey, `[10.59]`);
    formally (`Siamese`) distinct tiles of one colour with every cross distance below 1. With validity, two distinct tiles of one colour have
    all cross distances below 1 or all above 1 (the distance is continuous on the connected `T × T′` and never equals 1), so in the
    non-Siamese class they are more than 1 apart and **at most one tile of each colour has `z` in its closure** (the notation paragraph of
    `data/fs116/claims.md` § 13 says the same).
  - *Cusp*: FS-110's "a cusp is a cone point whose tile has angle 0" (`data/fs110/claims.md` § 0, from `plans/FS107-VW-verification.md` § 4
    item 4); FS-116's notation: "a tile's cone at a vertex is one closed interval of directions (possibly a single direction, a cusp)".
  - *Repeated colour*: FS-110/112's "one colour holds two non-adjacent sectors" (`plans/FS110-N-proof.md` l. 511–515, 619: "lowers
    `Σ_v Σ_c (#c-sectors at v − 1)`"); a cubic trichromatic vertex has "three colours, one sector each (**cusp sectors allowed**)"
    (`plans/FS112-N-proof.md` l. 724). Formally (`Plane/ValidMap/Basic.lean` on `fs131-w4`): `IsSector v r S` — a component of the interior
    points in `B(v, r)` whose closure holds `v` ("a cusp horn is one"); `HasRepeatedColour v` — some colour has at least two sectors at every
    small radius; `noBoth`'s conclusion is `4 ≤ ncard ∨ HasRepeatedColour P`.
- **The formal route** (`plans/FS131-w3-kernel-plan.md` on `fs131-w3`, l. 547): "`four_of_bothKind` | one tile per colour, interval cones: a
  colour in both side cones would have an interval cone containing a facing cone, overlapping `c`'s or `c′`'s tile's cone in an interval —
  disjoint open tiles have cones with disjoint interiors". `Simple.coneAt_eq_angleIcc`'s docstring (`Plane/LocalStructure.lean` on `fs131-w4`):
  "near the point the tile's boundary is a Jordan curve with exactly two branches, each a segment or a circular arc, and **the tile is the
  sector between them**" — but its statement exports only "the cone is one closed angular interval".

### 1.4 The shape of the question, before any derivation

The hand arguments (V5-U1, NOBOTH) reason with **sectors**: the components of `B(z, r) ∖ Γ` for small `r`, each lying between two consecutive
branches of `Γ` at `z`. The formal route reasons with **cones**, the sets of limit directions. The two agree except exactly at a cusp: a tile
lying on both sides of a cusp has two sectors at `z` but one interval as its cone, and the cusp's direction lies inside that interval. So the
implementer's local picture (inventory item 112: "a `d`-tile whose interval cone covers both side cones and the facing cone around the cusp")
is a tile with **two sectors** at `z`. Whether the hand clause survives therefore turns on whether *simple* forbids a tile two sectors at `z`.
I expect it does, through "does not meet itself" (a Jordan domain's boundary passes through `z` once).

### 1.5 Registered predictions (before the written derivation)

Registered at 2026-10-04 12:06 UTC, after reading the arguments and definitions above and before writing any entry. Each names the decision
it bears on.

| # | prediction | p | decides |
|---|---|---|---|
| P1 | Q1 **derived**: the four-colour clause holds with cusps in the non-Siamese simple class, by the sector form of V5-U1's own argument | 0.88 | whether the Lean's `hnc` can be dropped (a stronger `four_of_bothKind_simple`) and whether any consumer must be re-read |
| P2 | Q2 **derived**: NOBOTH holds with cusps, by its own argument; the cusp is "one colour twice" | 0.93 | whether wave 4's `noBoth` keeps its statement |
| P3 | Q3: **no consumer changes**; no ledger row and no `CLAUDE.md` statement changes | 0.88 | whether Keryx files corrections |
| P4 | the implementer's local picture is **realizable** as an exact valid fragment, non-Siamese and simple except at the tile wrapped round the cusp, refuting the skeleton's general `four_of_bothKind` (`05cb0a3e`, `β₁ ≤ β₂`) | 0.75 | whether "interval cone" is shown strictly weaker than "one sector" — that is, whether the repair to the general form was needed and what must replace it |

## Stage 2 — SAVED

*The derivations. Angles in degrees, counter-clockwise; `e(θ)` the unit vector; `a = arcsin(5/13)` in the fragments. Side cones
`S₁ = (θ₁ − 90°, θ₂ − 90°)`, `S₂ = (θ₁ + 90°, θ₂ + 90°)`, facing cone `F = [θ₂ − 90°, θ₁ + 90°]`, away cone `W = [θ₂ + 90°, θ₁ + 270°]`;
counter-clockwise they come in the order `S₁, F, S₂, W`.*

### 2.1 The entries

derivation: FS131-E2-SECT
  statement: let z be a point of the domain of a map bounded by a locally finite family of segments and circular arcs; there is r > 0 such that
    Γ ∩ B(z, r), with z removed, is the union of finitely many pairwise disjoint branches b₁, …, b_m (m ≥ 0), each a piece of one segment or
    circular arc through z, meeting every circle |w − z| = s, 0 < s < r, in one point b_i(s), with a tangent direction τ_i at z, the cyclic order of
    the points b_i(s) on that circle being the same for every s; when m ≥ 1 the components of B(z, r) ∖ Γ are the m open sectors between
    cyclically consecutive branches, each with z in its closure; and, with g_i ∈ [0°, 360°] the limit as s → 0 of the counter-clockwise angle from
    b_i(s) to b_{i+1}(s) (indices mod m, g₁ = 360° when m = 1), the sector between b_i and b_{i+1} has cone [τ_i, τ_i + g_i] at z (one direction
    when g_i = 0, a cusp), and every other sector's cone at z lies in [τ_i + g_i, τ_i + 360°], so contains no direction of the open interval
    (τ_i, τ_i + g_i)
  uses only: local finiteness; z interior to the domain; a segment or circular arc through z has at most two branches at z, along each of which
    the distance to z increases strictly near z; two distinct lines or circles meet in at most two points; the branches move continuously with s
  not claimed: anything about tiles — a tile may hold several sectors at z (FS131-E2-MONSTER); the curvature order of tangent branches (never
    used); anything for boundaries that are not locally finite unions of segments and circular arcs
  argument: § 2.2 FS131-E2-SECT's argument
  verdict: derived
  grade: hand
  minds: 1
  model: FS131-E2-MONSTER at 0 — branches T′'s right ray (τ = −a), h₊ and h₋ (τ = 90°, g = 0 between them), T′'s left ray (τ = 180° + a); sectors D's
    right [−a, 90°], H's cusp {90°}, D's left [90°, 180° + a], T′ [180° + a, 360° − a] — control fs131-e2-monster
  prior art: partly: `localSectors` as wave 3's plan specifies it (plans/FS131-w3-kernel-plan.md § 6.1 item 3, on branch fs131-w3), which states the
    branches and the sectors; the cone clause and the separation are added here
  handoff: de Bruijn — the cone clause and the separation, as corollaries of `localSectors`; the plan's child `coneAt_interiors_disjoint` does not
    carry the cusp case, since a cusp's cone has empty interior

derivation: FS131-E2-ONESECT
  statement: in a simple map, let z be a point of the domain and T a tile with z in its closure; then, for r as in FS131-E2-SECT taken smaller if
    need be, T ∩ B(z, r) is one sector of z — all of B(z, r) when z lies in T, and otherwise the open sector between two cyclically consecutive
    branches
  uses only: FS131-E2-SECT; that T is a Jordan domain (formally `IsJordanDomain`; the hand definition's "an open disc whose closure … does not meet
    itself"), so that ∂T is a simple closed curve J, lying in Γ near z, and T is the bounded component of ℂ ∖ J; that J's two sides near a point
    where J is a C¹ arc lie in different components of ℂ ∖ J
  not claimed: the same for a tile that is not a Jordan domain (FS131-E2-MONSTER's D holds two sectors at 0); that the two branches are not tangent
    (a cusp tile is the sector between two tangent branches); anything from simple's second clause, closures meeting in connected sets (not used)
  argument: § 2.3 FS131-E2-ONESECT's argument
  verdict: derived
  grade: derived from: FS131-E2-SECT
  minds: 1
  model: FS131-E2-MODEL at 0 — H the cusp sector between h₊ and h₋, D_R the sector [−a, 90°], D_L [90°, 180° + a], T′ [180° + a, 360° − a], each
    tile one sector — control fs131-e2-model
  prior art: partly: wave 3's planned child `jordan_two_branches` (plans/FS131-w3-kernel-plan.md, the `Simple.coneAt_eq_angleIcc` row: "a Jordan
    boundary meets a small ball in exactly two branches at each of its points … the tile is the sector between them"), whose last clause is not
    exported by the statement it serves
  handoff: de Bruijn — `jordan_two_branches`, with "the tile is the sector between them" exported

derivation: FS131-E2-SEP
  statement: in a simple map, let z be a point of the domain and T a tile with z in its closure; then T's cone at z is a closed interval [β₁, β₂],
    β₁ ≤ β₂ ≤ β₁ + 360°, such that no other tile with z in its closure has a direction of its cone at z in the open interval (β₁, β₂), and every
    direction of T's cone at z that is no branch's tangent lies in (β₁, β₂); in particular no other tile's cusp at z points into T's open cone
  uses only: FS131-E2-ONESECT (T and any other tile at z are two distinct sectors of z); FS131-E2-SECT's cone and separation clauses, with
    [β₁, β₂] = [τ_i, τ_i + g_i] for T's sector (or every direction, from any β₁, when z lies in T and T is alone at z)
  not claimed: the same for a non-simple map — false: FS131-E2-MONSTER's D has cone [−a, 180° + a], whose interior holds H's cusp direction 90°; the
    separation for an arbitrary representation [β₁, β₁ + 360°] of a full cone (only the sector's own endpoints are claimed)
  argument: § 2.3 FS131-E2-ONESECT's argument
  verdict: derived
  grade: derived from: FS131-E2-ONESECT, FS131-E2-SECT
  minds: 1
  model: FS131-E2-MODEL at 0 — D_R's cone [−a, 90°] and D_L's [90°, 180° + a] meet H's cusp direction 90° only at an end — control fs131-e2-model
  prior art: partly: V5's reading of simple, "one sector per tile at p" (plans/FS116-V5-verification.md § V5-DICHO's argument, its uses only)
  handoff: de Bruijn — the separated-interval statement of § 2.7, from which `four_of_bothKind_simple` follows without `hnc`

derivation: FS131-E2-U1-CUSP
  statement: in a non-Siamese simple valid k-coloured fragment, for any k, let z be a point of its domain and A an arc of Γ on ω(z) of angular extent
    [θ₁, θ₂] about z, θ₂ − θ₁ = ℓ > 0, with inner side colour c and outer side colour c′; if z carries both c and c′, then z carries at least four
    colours, whether or not some tile with z in its closure has a cusp at z
  uses only: FS116-V5-U1's cone clauses (validity only; for every tile, cusps included; in Lean `ringArc_cone_inner`, `ringArc_cone_outer`,
    `ringArc_sideCone_inner`, `ringArc_sideCone_outer` on branch fs131-w3); FS131-E2-SECT (finitely many branch tangents); FS131-E2-SEP; non-Siamese
    with validity (at most one tile of each colour has z in its closure)
  not claimed: the same in a non-simple fragment (FS131-E2-MONSTER: non-Siamese, valid, three colours); anything when ℓ = 0; that a cusp at z ever
    raises or lowers z's colour count; anything about tiles at z of other colours beyond the two that hold the side cones
  argument: § 2.4 FS131-E2-U1-CUSP's argument
  verdict: derived
  grade: derived from: FS131-E2-SECT, FS131-E2-SEP
  minds: 1
  model: FS131-E2-MODEL — non-Siamese, simple, valid, A at 0 both-kind, H a cusp at 0, four colours at 0 (control fs131-e2-model)
  prior art: partly: FS116-V5-U1's own argument read in sectors (plans/FS116-V5-verification.md § V5-U1's argument: "one sector per tile, one tile
    per colour") and FS112-N3-NOBOTH's (plans/FS112-N-proof.md l. 731–737: "a cusp horn included"); the cusp case written out not found elsewhere
  handoff: de Bruijn — `four_of_bothKind_simple` without `hnc`, its skeleton statement of commit 05cb0a3e, through § 2.7's separated-interval lemma;
    § 2.4 is the proof's shape

derivation: FS131-E2-NOBOTH-CUSP
  statement: in a valid k-coloured map or fragment, for any k, Siamese pairs allowed and simplicity not assumed, let P be a point of the domain that
    centres an arc of Γ on ω(P) of positive length whose inner and outer side colours are both carried at P; then some colour holds at least two
    sectors at P (a repeated colour) or P carries at least four colours, whether or not a sector at P is a cusp
  uses only: FS116-V5-U1's cone clauses (validity only), read for sectors — a sector of colour c is a set of points of tiles of colour c, so its
    cone lies in the cone of c's class; FS131-E2-SECT, its separation clause included
  not claimed: four colours (FS131-E2-MONSTER has three, with a repeated colour); that the repeated colour's two sectors lie in two tiles (in the
    monster they are one tile's); anything when the arc has length 0
  argument: § 2.5 FS131-E2-NOBOTH-CUSP's argument
  verdict: derived
  grade: derived from: FS131-E2-SECT
  minds: 1
  model: FS131-E2-MONSTER at 0 — three colours, colour d on two sectors either side of H's cusp (control fs131-e2-monster)
  prior art: known: FS112-N3-NOBOTH — N3 (plans/FS112-N-proof.md l. 731–737, "(a cusp horn included)") and NB3, blind
    (plans/FS112-NB3-verification.md l. 89–95, "a horn inside a γ-sector already splits it"); this entry writes out the separation step both state in
    a clause
  handoff: de Bruijn — wave 4's `noBoth` keeps its statement; its proof runs on sectors (`IsSector`) with FS131-E2-SECT's separation, never on tile
    cones, which cannot see on which side of a cusp a tile lies

derivation: FS131-E2-MONSTER
  statement: there is a valid six-coloured fragment, non-Siamese, on an open domain containing B̄(0, 1/3), with an arc A of Γ on ω(0) of extent
    [90° − a, 90° + a], a = arcsin(5/13), inner side colour c and outer side colour c′, both carried at 0, in which 0 carries three colours; one tile,
    H, has a cusp at 0 along 90°; one tile, D, lies on both sides of that cusp (two sectors at 0, its closure meeting itself there, so it is no Jordan
    domain); every other tile is a Jordan domain, and the closures of distinct tiles meet in connected sets; at 0 each colour has one tile, and each
    tile's cone at 0 is one closed interval — {90°}, [180° + a, 360° − a] and [−a, 180° + a]
  uses only: the formulas of § 2.6; exact identities and inequalities (sympy, Fraction): the horn circles' |w|² = (13/5)|Re w|, cos 2a = 119/169 >
    1/2, the T′/T_out angle window (−270°, −90°), T_out's bound 19769/28561 and V's bound 12996/13520
  not claimed: that it is simple (D is no Jordan domain); that a simple fragment has three colours at a both-kind centre (FS131-E2-U1-CUSP forbids
    it); that the repaired general form fails — its hypothesis, cones of positive length, excludes H; anything about a disc of radius above 1
  argument: § 2.6 The two fragments
  verdict: derived
  grade: computed over: the exact identities and inequalities of tools/fs131_e2_frag.py --variant monster, under § 2.6's hand validity proof
  minds: 1
  model: the fragment itself, exhibited by formula in § 2.6 (control fs131-e2-monster)
  prior art: partly: inventory item 112's local picture (FS131-I3e, "a local picture, not a built fragment"), here built and checked
  handoff: de Bruijn — the skeleton's `four_of_bothKind` (commit 05cb0a3e, cones `β₁ ≤ β₂`) is false; the repaired `β₁ < β₂` stays, or § 2.7's
    separated-interval hypothesis replaces `hint`

derivation: FS131-E2-MODEL
  statement: there is a non-Siamese simple valid six-coloured fragment on an open domain containing B̄(0, 1/3), with an arc A of Γ on ω(0) of extent
    [90° − a, 90° + a], a = arcsin(5/13), whose inner and outer side colours c and c′ are both carried at 0, in which one tile has a cusp at 0 and 0
    carries four colours
  uses only: the formulas of § 2.6 (the monster with D cut along the imaginary axis into D_R and D_L of two further colours, T′ widened to radius
    1/2); the same exact facts
  not claimed: that a cusp at a both-kind centre forces more than four colours; anything about a disc of radius above 1 about 0 (so nothing about
    FS-116's rings)
  argument: § 2.6 The two fragments
  verdict: derived
  grade: computed over: the exact identities and inequalities of tools/fs131_e2_frag.py --variant model, under § 2.6's hand validity proof
  minds: 1
  model: the fragment itself, exhibited by formula in § 2.6 (control fs131-e2-model)
  prior art: partly: FS-116's held positives with four-colour vertices carrying both-kind unit arcs (the disk's corners, FS116-V5-U1's model line),
    none with a cusp at the centre
  handoff: none — the model of FS131-E2-U1-CUSP: its hypotheses are met with a cusp present, so the cusp case is not vacuous

control: fs131-e2-monster
  of: FS131-E2-MONSTER — every same-coloured pair certified, three colours at 0, D on both sides of H's cusp and in both side cones
  run: python3 ../tools/fs131_e2_frag.py --variant monster | tail -n 1
  expect: variant monster: FRAG ALL OK
  fault: python3 ../tools/fs131_e2_frag.py --variant monster --plant recolour | tail -n 1

control: fs131-e2-model
  of: FS131-E2-MODEL — every same-coloured pair certified and far where two tiles share a colour, four colours at 0, D_R and D_L in the side cones
  run: python3 ../tools/fs131_e2_frag.py --variant model | tail -n 1
  expect: variant model: FRAG ALL OK
  fault: python3 ../tools/fs131_e2_frag.py --variant model --plant widen | tail -n 1

control: fs131-e2-quotes
  of: FS131-E2-U1-CUSP — the quotations this record reads, the claim list against its sources and the brief against the claim list
  run: python3 ../tools/fs131_e2_quotes.py | tail -n 1
  expect: checks: 12 QUOTES ALL OK
  fault: python3 ../tools/fs131_e2_quotes.py --plant | tail -n 1

### 2.2 FS131-E2-SECT's argument

Local finiteness gives a neighbourhood of `z` meeting finitely many arcs of the family. Those not containing `z` are compact and miss `z`, so
they lie at positive distance; take `r` below it. An arc through `z` (a segment, or a circular arc of radius `ρ`) gives one branch if `z` is an
end and two if `z` is interior: its parts on either side of `z`. Along each, the distance to `z` increases strictly near `z`: for a segment
trivially, for a circle `|w − z| = 2ρ sin(φ/2)` in the angle `φ` subtended at the centre, increasing for `φ < 180°`. So, for small `r`, each
branch meets every circle `|w − z| = s`, `0 < s < r`, once, at a point `b_i(s)` continuous in `s`, and it has a tangent direction `τ_i`, the
arc's one-sided tangent at `z`. Two branches on distinct lines or circles meet in at most one point besides `z`, since two such curves meet in at
most two points. That point lies at positive distance, so smaller `r` excludes it. Two branches on the same line or circle either coincide
near `z`, and are counted once, or leave `z` in opposite senses, and are disjoint. So the distinct branches are pairwise disjoint in
`B(z, r) ∖ {z}`. On each circle the `m` points `b_i(s)` are distinct and move continuously in `s`, so their cyclic order is constant: a change
would need two of them to coincide.

In polar coordinates `(s, φ)` about `z`, the set `B(z, r) ∖ ({z} ∪ ⋃ b_i)` is `{(s, φ) : 0 < s < r, φ ≠ arg(b_i(s) − z)}`. When `m ≥ 1` its
components are the `m` regions `S_i = {φ_i(s) < φ < φ_i(s) + gap_i(s)}`, with `φ_i(s) = arg(b_i(s) − z)` and `gap_i(s) ∈ (0°, 360°)` the
counter-clockwise angle from `b_i(s)` to `b_{i+1}(s)`. Each is path-connected, a polar strip between two continuous graphs over `(0, r)`, and
each has `z` in its closure. Since `z ∈ Γ` when `m ≥ 1`, `B(z, r) ∖ Γ` is exactly this set. Each `gap_i` is continuous with values in
`(0°, 360°)`, the gaps sum to `360°` for each `s`, and modulo `360°` each gap tends to `τ_{i+1} − τ_i`. When `τ_{i+1} ≠ τ_i` the limit
`g_i ∈ (0°, 360°)` is determined. When `τ_{i+1} = τ_i` the gap approaches `{0°, 360°}`, so being continuous on the connected `(0, ε)` it
eventually stays near one of the two values: `g_i` exists in `[0°, 360°]` in every case, and `Σ g_i = 360°`.

*The cone.* A point of `S_i` at radius `s` has argument in `(φ_i(s), φ_i(s) + gap_i(s))`, so the limits of the directions of points of `S_i`
tending to `z` lie in `[τ_i, τ_i + g_i]`. Conversely, for a direction `δ` in the open `(τ_i, τ_i + g_i)`, the point `z + s e(δ)` lies in `S_i`
for small `s`, because `φ_i(s) → τ_i` and `gap_i(s) → g_i`. The cone is closed, so it is `[τ_i, τ_i + g_i]`. When `g_i = 0` it is `{τ_i}`,
non-empty because `S_i` has `z` in its closure: a cusp. *The separation.* Every other sector `S_j` has its arguments at radius `s` in
`(φ_{i+1}(s), φ_i(s) + 360°)`, the arc of the circle complementary to `S_i`'s. Its limit directions therefore lie in the closed arc
`[τ_i + g_i, τ_i + 360°]`, which contains no point of the open `(τ_i, τ_i + g_i)`. ∎

### 2.3 FS131-E2-ONESECT's argument

If `z ∈ T`, then `z ∉ Γ`, `m = 0`, and `B(z, r) ⊂ T` once `r` is small, since `T` is open: one sector, the only tile at `z`. Otherwise
`z ∈ ∂T`. A point of `∂T` in the domain lies in `Γ`: it is not in `T`, and a point of another tile `T″` has a neighbourhood inside `T″`,
disjoint from `T`. `T` is a Jordan domain: `cl T` is homeomorphic to the closed disc, with `T` the image of the open disc. So `J = ∂T` is a
simple closed curve, and `T` is the bounded component of `ℂ ∖ J`, being open, connected, bounded, disjoint from `J`, with boundary `J`.

Take a small open arc of `J` about `z`. The rest of `J` is compact and misses `z`, so for small `r`, `J ∩ B(z, r)` lies in that arc, and inside
`B(z, r)` it lies in the branches. The arc's two halves, minus `z`, are connected subsets of the disjoint union of the open branches, so each
lies in one branch, and the two branches differ, `b_i ≠ b_j`: `J` is injective, and two initial pieces of one branch overlap. Shrinking `r`,
`J ∩ B(z, r) = {z} ∪ ((b_i ∪ b_j) ∩ B(z, r))`. These two branches cut `B(z, r)` into two open regions: `U₁` (the sectors and open branches
counter-clockwise from `b_i` to `b_j`) and `U₂` (from `b_j` to `b_i`). Each is connected, a chain of polar strips joined across open branches,
and disjoint from `J`, so each lies inside `T` or outside `cl T`. They lie on opposite sides: near a point of the open branch `b_i`, `J` is a
C¹ arc, and points just on either side of it lie in different components of `ℂ ∖ J`. So `T ∩ B(z, r)` is one of them, say `U₁`. Being inside
`T`, `U₁` misses `Γ`, so it contains no branch: `b_i` and `b_j` are consecutive, and `U₁` is the single sector between them. ∎

**FS131-E2-SEP.** Take `[β₁, β₂] = [τ_i, τ_i + g_i]`, the cone of `T`'s sector (FS131-E2-SECT). When `z ∈ T`, `T` is alone at `z` and there is
nothing to separate. Another tile `T′` with `z` in its closure is another sector `S′` of `z`, distinct from `T`'s because `T ∩ T′ = ∅`, so by
the separation clause its cone misses `(τ_i, τ_i + g_i)`. A direction of `[τ_i, τ_i + g_i]` that is no branch's tangent is neither `τ_i` nor
`τ_i + g_i`, so it lies in the open interval. ∎

### 2.4 FS131-E2-U1-CUSP's argument

*The cone clauses (FS116-V5-U1, validity only).* A point `z + s e(δ)` of a `c`-tile at `z`, against the inner points `z + (1 − η) e(θ)`,
`θ ∈ (θ₁, θ₂)`, gives a distance `1 − η − s cos(δ − θ) + O(s² + η²)`. If `cos(δ − θ) < 0`, a small `s` and continuity in `η` give two interior
points of colour `c` at distance exactly 1. So every direction of the cone of any `c`-tile at `z` lies in `F`, and the same holds for the
`c′`-tiles and `W`. This holds for a cusp tile as for any other: it needs one point of the tile near `z` in a direction near `δ`, which a cusp
supplies. It is proved in Lean for the cone of the whole class (`ringArc_cone_inner`, `ringArc_cone_outer`), together with the two open side
cones holding neither colour (`ringArc_sideCone_inner`, `_outer`).

*The four colours.* The branch tangents at `z` are finitely many (FS131-E2-SECT). Choose `σ ∈ S₁` and `σ′ ∈ S₂`, neither a branch tangent
(`ℓ > 0` makes both cones open and non-empty). The points `z + s e(σ)` lie, for small `s`, off `Γ` in one sector, so in one tile `D`, with `σ`
in `D`'s open interval `(β₁, β₂)` (FS131-E2-SEP). Likewise `σ′` gives a tile `E`. By the cone clauses, neither `D` nor `E` has colour `c` or
`c′`. Suppose `D` and `E` have one colour. Then `D = E`, since non-Siamese with validity allows one tile of each colour at `z`. So the open
interval `(β₁, β₂)`, of length at most `360°`, holds `σ ∈ S₁` and `σ′ ∈ S₂`. Going from `σ` to `σ′` inside it passes through all of `F` or all
of `W`. Say `F` (`W` is the same with `c′`). The `c`-tile `C` at `z` (`z` carries `c`) has a non-empty cone inside `F` — perhaps the single
direction of a cusp — so its cone meets `(β₁, β₂)`. Since `C ≠ D`, this contradicts FS131-E2-SEP. So `D` and `E` have colours `d ≠ e`, both
outside `{c, c′}`, and `z` carries `c, c′, d, e`. ∎

**Where the cusp enters, and why it does no harm.** Only at "`C`'s cone meets `(β₁, β₂)`". A cusp makes `C`'s cone a single direction, and
FS131-E2-SEP excludes a single direction exactly as it excludes an interval. The formal route as planned — "`c`'s tile's cone overlaps in an
interval; disjoint tiles have cones with disjoint interiors" — loses this, because a cusp's cone has empty interior. **Where six is spent:**
nowhere, so the statement holds at every `k`. **What simple supplies:** FS131-E2-SEP, and nothing else. Simple's second clause (closures meeting
in connected sets) is not used.

### 2.5 FS131-E2-NOBOTH-CUSP's argument

The same argument with sectors in place of tiles, and no simplicity. A sector of colour `c` consists of points of `c`-tiles, so its cone lies
in the cone of `c`'s class, inside `F`. Likewise `c′` and `W`. Choose `σ, σ′` as in § 2.4. They lie in the open cones of sectors `S_D`, `S_E`
(FS131-E2-SECT), whose colours are not `c` or `c′`. If `S_D = S_E`, its open cone `(τ_i, τ_i + g_i)` contains `F` or `W`, and so contains a
direction of a sector of colour `c` or `c′`: the class carried at `P` has a tile with `P` in its closure, that tile's part near `P` is a union
of sectors of `P`, at least one of them a sector at `P`, and its cone is non-empty, a cusp's single direction included. This contradicts the
separation clause. If `S_D ≠ S_E` and they share a colour, that colour has two sectors at `P`: a repeated colour. The two sectors stay
distinct sectors at every smaller radius (the sector structure is the same on `(0, r)`), so the formal `HasRepeatedColour` holds. Otherwise
`P` carries `c, c′` and two further colours. ∎

This is N3's and NB3's argument, which both state the cusp case in a clause. The separation step written out above is what a formal proof
has to prove: a statement about tile cones is blind to it.

### 2.6 The two fragments

**Data** (exact; `z = 0`, `a = arcsin(5/13)`, so `sin a = 5/13`, `cos a = 12/13`; the ends of `A` are `P₁ = (5/13, 12/13) = e(90° − a)` and
`P₂ = (−5/13, 12/13) = e(90° + a)`).

| tile | set | colour (monster) | colour (model) |
|---|---|---|---|
| `H` | `{Im w > 0, |w| < 1, |w − 13/10| > 13/10, |w + 13/10| > 13/10}` — the horn: its sides are arcs of the circles of radius `13/10` about `±13/10`, through `0` and tangent there to the imaginary axis, ending at `P₁`, `P₂`; its top is `A` | `c = 0` | `c = 0` |
| `T′` | `{0 < |w| < ρ_T, arg w ∈ (180° + a, 360° − a)}`, `ρ_T = 1/4` (monster), `1/2` (model) | `c′ = 1` | `c′ = 1` |
| `T_out` | `{1 < |w| < 14/13, arg w ∈ (90° − a, 90° + a)}` | `c′ = 1` | `c′ = 1` |
| `D` (monster) | `B(0, 1/2) ∖ (cl H ∪ cl T′)` — connected through `1/4 < |w| < 1/2` below `T′` | `d = 2` | — |
| `D_R`, `D_L` (model) | `B(0, 1/2) ∖ (cl H ∪ cl T′)` with `Re w > 0`, `< 0` — meeting only at `0` | — | `2`, `3` |
| `Q_R`, `Q_L` | `V ∖ (cl H ∪ cl T_out)` with `Re w > 0`, `< 0`, where `V = {Im w > 0, 2|Re w| < Im w, 51/52 < |w| < 57/52}` | `3`, `4` | `4`, `5` |

The domain is `U = B(0, 1/2) ∪ H ∪ V`, which is open and contains `B̄(0, 1/3)`. The arcs are `A = r([90° − a, 90° + a])`, the two horn sides
`h₊`, `h₋` from `0` to `P₁`, `P₂`, `T′`'s two rays (and its arc of radius `1/4` in the monster), `T_out`'s two radial segments and its outer arc
of radius `14/13`, and the segment `{0} × [14/13, 57/52]` dividing the strip above `T_out`. Every point of `U` off the arcs lies in exactly one
listed tile (checked on a grid, below).

**Validity, pair by pair** (every same-coloured pair of tiles; colours not listed twice need only their own tile):
- `H`. Each horn side satisfies `|w|² = (13/5)|Re w|` (the circle `|w ∓ 13/10| = 13/10` expanded), so along it
  `sin(angle from the vertical) = |Re w|/|w| = (5/13)|w| ≤ 5/13`, with equality only at `P₁`, `P₂`. So `∂H` lies in the closed sector
  `Σ̄ = {s e(θ) : 0 ≤ s ≤ 1, |θ − 90°| ≤ a}`, which is convex, so `H ⊂ Σ̄`, and `H` lies in `Σ̄`'s interior, being open. For two points
  `s e(α)`, `t e(β)` of that interior, the squared distance is at most `f = s² + t² − 2st cos 2a`, with `cos 2a = 119/169 > 1/2`. With `s ≥ t > 0`:
  `f ≤ s² + ts(1 − 2 cos 2a) < s² < 1`. Every pair is below 1.
- `T′`: inside `B(0, ρ_T)`, `ρ_T ≤ 1/2`, so every pair is below 1. `D`, `D_R`, `D_L`: inside `B(0, 1/2)`, the same.
- `T_out`: `|w₁ − w₂|² = (s − t)² + 2st(1 − cos(α − β)) ≤ (1/13)² + 2(14/13)²(50/169) = 19769/28561 < 1`.
- `T′` against `T_out` (both `c′`): for `w = s e(α) ∈ T_out` and `v = t e(φ) ∈ T′`, `α − φ ∈ (θ₁ − (360° − a), θ₂ − (180° + a)) = (−270°, −90°)`,
  where the cosine is negative. So `|w − v|² = s² − 2st cos(α − φ) + t² > s² > 1`. Every cross distance is above 1, so the pair is valid and not
  Siamese.
- `Q_R`, `Q_L`: inside `V`, two points have angular separation below `2 atan(1/2)`, whose cosine is `3/5`. So the squared distance is below
  `s² + t² − (6/5)st`, whose maximum over `[51/52, 57/52]²` is at a corner, `12996/13520 < 1`.

So the colouring is valid. The only colour with two tiles is `c′`, and those tiles are more than 1 apart: **non-Siamese**.

**The arc and the colours at 0.** `A ⊂ V ⊂ U` (on `A`, `|Re w|/Im w ≤ 5/12 < 1/2`). At an interior point `e(θ)` of `A`, `|cos θ| < 5/13`, so
`(1 − η) e(θ)` lies outside both horn circles for small `η` (`(1 − η)² > (13/5)(1 − η)|cos θ|`). The inner side is therefore `H` alone, and
the outer side is `T_out` alone: `IsRingArc 0 (90° − a) (90° + a) c c′` in the formal reading. The tiles with `0` in their closure are `H`, `T′`
and `D` (monster), or `H`, `T′`, `D_R`, `D_L` (model); `T_out`, `Q_R` and `Q_L` lie at distance at least `51/52` from `0`. So `0` carries
`{c, c′, d}`, three colours, in the monster and `{c, c′, 2, 3}`, four colours, in the model. Each colour has one tile at `0`.

**Cones at 0.** `H`: near `0`, `|Re w| < 13/10 − √((13/10)² − (Im w)²) = O((Im w)²)`, so the cone is `{90°}`: a cusp. `T′`:
`[180° + a, 360° − a]`. Monster `D`: every direction of `(−a, 180° + a)` other than `90°` has its points at small radius in `D` (the horn there
is thinner than any fixed angle), and none of `(180° + a, 360° − a)` does, so the cone is `[−a, 180° + a]`. It contains `H`'s cusp direction
in its interior: FS131-E2-SEP fails, as it must, the monster not being simple. Model: `D_R` has `[−a, 90°]` and `D_L` has `[90°, 180° + a]`.
The open side cones are `S₁ = (−a, a)` and `S₂ = (180° − a, 180° + a)`: the monster's `D` holds both, while the model's `D_R` holds `S₁` and
`D_L` holds `S₂`.

**Simple, clause by clause.** `H`, `T′`, `T_out`, `Q_R`, `Q_L`, and the model's `D_R`, `D_L`, are Jordan domains: each boundary is one simple
closed curve, made of arcs and pieces of `∂U`. Closures of distinct tiles meet in connected sets:
- `cl H ∩ cl D` is the horn sides in `|w| ≤ 1/2`, joined at `0`.
- `cl H ∩ cl T′ = {0}`, and `cl H ∩ cl T_out = A`.
- `cl H ∩ cl Q_R` is the end of `h₊` in `|w| ≥ 51/52`, up to `P₁`.
- `cl T′ ∩ cl D` is `∂T′`, and in the model `cl T′ ∩ cl D_R` is `T′`'s right ray.
- `cl T_out ∩ cl Q_R` is the right radial segment and the right half of the outer arc, joined at `(14/13)P₁`.
- `cl Q_R ∩ cl Q_L` is the dividing segment, and in the model `cl D_R ∩ cl D_L = {0}`.
- Every other pair is disjoint.

**In the model every clause holds: it is simple.** In the monster one clause fails, for one tile: `D` is an open disc (its complement in the
plane, `cl H ∪ cl T′ ∪ (ℂ ∖ B(0, 1/2))`, is connected), but its closure meets itself at `0`. It is approached from both sides of the cusp, so
its boundary passes through `0` twice, and it is no Jordan domain. That is the "does not meet itself" clause of the hand definition, and the
formal `IsJordanDomain`.

**The formal hypotheses of commit `05cb0a3e`'s `four_of_bothKind`, met by the monster.** `hF`: valid. `hz`: `0 ∈ U`. `hA`: above. `hc`, `hc′`:
`0 ∈ cl H`, `0 ∈ cl T′`. `hone`: one tile of each colour at `0`. `hint`: `coneAt H 0 = angleIcc 90° 90°`, `coneAt T′ 0 = angleIcc (180° + a)
(360° − a)`, `coneAt D 0 = angleIcc (−a) (180° + a)`, each with `β₁ ≤ β₂ ≤ β₁ + 360°`. Its conclusion, `4 ≤ ncard (coloursAt 0)`, fails: the
statement is false. Under the repair (`β₁ < β₂`) the hypothesis `hint` fails at `H`, so the repaired form is not refuted. `four_of_bothKind_simple`
with no `hnc` is not refuted either: the monster fails `Simple`, and FS131-E2-U1-CUSP proves that form.

**What the tool checks** (`tools/fs131_e2_frag.py`, sympy and `Fraction`):
- exactly: every identity and inequality above; that every same-coloured pair of tiles has a certificate, and a far one where two tiles share a
  colour; the colours at `0`;
- as sanity only: the cyclic word of tiles round `0` read on a circle of radius `1/1000` (monster `D, H, D, T′`; model `D_R, H, D_L, T′`; `H`
  shows at the one sample at exactly `90°`); which tiles hold the side cones; and a grid of 4,137 domain points, none in two tiles, each inside
  the shape its tile's certificate uses.

Planted faults, each red:
- `--plant recolour` gives `Q_R` the colour of `H`. No certificate covers `(H, Q_R)`, and an exact witness pair is printed: `h = (0, 1/26) ∈ H`
  and `w = h + (39/89, 80/89) ∈ Q_R`, at distance exactly 1.
- `--plant widen` widens `T′` to the directions `(180° − a, 360° + a)`, and the far certificate `(T′, T_out)` fails.

Output (both variants, both plants):

```
variant monster: FRAG ALL OK                         (exit 0)
variant model: FRAG ALL OK                           (exit 0)
variant monster, plant recolour: FRAG FAIL (3)       (exit 1)
variant model, plant recolour: FRAG FAIL (3)         (exit 1)
variant monster, plant widen: FRAG FAIL (4)          (exit 1)
variant model, plant widen: FRAG FAIL (4)            (exit 1)
```

The widen plant's fourth failure is the side-cone readout: the widened `T′` covers `S₁` and `S₂` itself.

### 2.7 For the formal route (a proposal; the statements are de Bruijn's to fix)

The planned route for `four_of_bothKind` reads "interval cones, … disjoint open tiles have cones with disjoint interiors". That is true in any
map, but it cannot fire against a cusp. The monster shows that interval cones alone (`hint` with `β₁ ≤ β₂`) do not give four colours. What
does give them is the separated interval of FS131-E2-SEP, in Lean's words:

```lean
/-- In a simple map, a tile's cone at a point of its closure is one closed interval whose open part meets no other tile's
cone at that point (FS131-E2-SEP: the tile is one sector, between consecutive branches; a cusp of another tile is a sector
of its own and points into no other sector). -/
theorem Simple.coneAt_eq_angleIcc_sep (hS : F.Simple) {T : Set ℂ} (hT : F.IsTile T) {x : ℂ} (hxd : x ∈ F.dom)
    (hx : x ∈ closure T) :
    ∃ β₁ β₂, β₁ ≤ β₂ ∧ β₂ ≤ β₁ + 2 * π ∧ coneAt T x = angleIcc β₁ β₂ ∧
      ∀ T', F.IsTile T' → T' ≠ T → x ∈ closure T' → Disjoint (coneAt T' x) (angleIoo β₁ β₂)
```

Its proof: `localSectors` (FS131-E2-SECT, with the cone and separation clauses as corollaries) and the planned `jordan_two_branches`, with "the tile
is the sector between them" exported (FS131-E2-ONESECT). With it, `four_of_bothKind` can take, in place of `hint`, the hypothesis that each tile at
`z` has such a separated interval. Its proof is § 2.4: choose `σ ∈ S₁` and `σ′ ∈ S₂` off the finitely many end directions of the tiles' intervals
(finitely many tiles near `z`, `finite_tiles_near`). Then each lies in the open interval of the tile whose cone holds it, and the rest is as
written. `four_of_bothKind_simple` then holds **without `hnc`** — its skeleton statement at `05cb0a3e`. Wave 4's `noBoth` needs the same
separation for sectors (`IsSector`), which is FS131-E2-SECT itself.

## Stage 3 — SAVED

### 3.1 Q3 — the consumers

The verdicts of Q1 and Q2 are **derived**, so no consumer can fail by the cusp case. The question left is where each consumer reads the clause,
whether a cusp can occur there, and whether its wording carries the mechanism right: "one sector per tile" (which holds at a cusp) or "one
cone per tile" (which does not).

| consumer | where it reads the clause | a cusp there? | fate |
|---|---|---|---|
| FS116-V5-DICHO (`plans/FS116-V5-verification.md` § V5-DICHO's argument) | V5-U1's cone clauses at `p`, then its own exclusions "both lie in the fourth tile, on both sides of the shared tile — two sectors" at `p`: the four-colour clause's mechanism, not its conclusion | yes: a tile of `p` may be a cusp at `p`, the shared tile included; nothing in the setting excludes it | **survives as stated.** The step is FS131-E2-SEP: a tile on both sides of a cusp is two sectors, against simple. A formalization through interval cones alone would miss it, as `four_of_bothKind`'s did |
| FS116-V5-CROSS-S (§ 3.4) | V5-U1's **cone clauses** at `p` only (step 1: "each side cone holds neither colour of its arc and only one of the other two fits it"), and V5-OUT2 | yes, but the cone clauses hold for every tile, cusps included, and no sector step is used | **survives as stated**, independent of Q1 |
| V5's second derivation of FS116-N3-SEMI (§ 3.2) | the **four-colour clause at `v` or `u`**, alternative (b): "both side colours carried at `v`, and `v` has at least four colours (V5-U1)"; and, in the parallel case, "the two other tiles fill the two gaps, one each" at `p` | yes, at `v`, at `u` and at `p` | **survives as stated**: FS131-E2-U1-CUSP at `u`, `v`; FS131-E2-SEP for "one each" |
| V5's second derivation of FS116-N3-PAIR (§ 3.3) | **nowhere**: it reads V5-QCOL and V5-NE1 only ("'Simple' and the four colours' count beyond V5-QCOL are not used") | — | **survives**; V5-U1's "Rests on it" line overstates by this entry |
| V5's second derivation of FS116-N3-CROSS (§ 3.4) | V5-U1's cone clauses at `p` (step 1); step 6's "(Q) arc" uses `y`'s four colours as a hypothesis and the definition of (Q), not the clause | at `p`, harmless as above; at `y`, CROSS's own first clause ("every tile of p at y has a cone at y of zero angle") is vacuous by CROSS-S | **survives as stated** |
| FS112-N3-COR3 (`plans/FS112-N-proof.md` l. 773–781) | NOBOTH at the cubic trichromatic `u`, `u′`, to forbid a both-kind arc there | yes: a cubic trichromatic vertex has "three colours, one sector each (cusp sectors allowed)" (l. 724) | **survives as stated**: FS131-E2-NOBOTH-CUSP; a cubic trichromatic vertex has neither four colours nor a repeated colour |
| FS112-N3-PAIRS (l. 771–789) | NOBOTH at `y` (N3-II) and at the cubic `p′` (N3-P′) | yes | **survives as stated** |
| FS112-N3-END (l. 860–869) | NOBOTH at `P_{−2}` (item 4); U1's side cone at `P_{−1}` (item 3, a cone clause) | yes: the chain's vertices carry horns, cusp sectors by construction | **survives as stated** |

**Readers the claim list does not name** (found by grep; each survives as stated):
- **FS112-N3-BASE**'s pseudo-colouring and its eleventh point (l. 783–798): NOBOTH at a cubic `u`.
- **FS116-N3-CONE (c)** (`plans/FS116-N3-proof.md` l. 212–215), and through it **FS116-N3-SEMI**'s first derivation and
  **FS116-RING-TRANSFER-QC**: NOBOTH at `u` or `v`, then "four colours, the class being non-Siamese". *Wording:* removing the repeated colour
  needs simple as well. A colour on two sectors at `w` may be one tile, and simple excludes that; non-Siamese excludes two tiles. The entry's
  `uses only:` names both, so the result stands.
- **FS129-SR1-BENDLE3** (`plans/FS129-derivation.md` l. 647–649): V5-U1's four-colour clause at `p`, any `k`. *Wording:* its gloss "one tile per
  colour at a point and **one cone per tile** at a vertex" is the cone reading. That reading does not carry the cusp case: the monster has one
  interval cone per tile. It should read "one sector per tile".
- **FS129-OR1-DISCF-NS** (l. 997): "one tile twice at a vertex has a closure that meets itself", which is FS131-E2-ONESECT, read correctly.
- **FS114-L60-WALK** and **FS121-O1-ENDS** (Lean backlog rows 70, 169): NOBOTH as stated. O1-ENDS's step from "or a repeated colour" to four
  colours is its own (density-0 colours excluded, FS111-W-NOREP / FS121-DB1-L3), outside this question.

**Filed rows and frontier statements.** `LEDGER.md` rows 135, 137, 147, 149 and 150, which rest on these chains, are unchanged. So is every
statement of `CLAUDE.md` § Where the problem stands, item 31. **No correction to the ledger or to `CLAUDE.md` is owed.**

**What does change is in the Lean.**
1. `four_of_bothKind_simple`'s `hnc` is removable (§ 2.7). Until it is removed, every formal consumer that goes through it carries "no cusp at
   the point" and so proves a weaker theorem than the hand one. The backlog's C17 (FS129-SR1-BENDLE3, which needs FS116-V5-U1) is one, and
   DICHO and SEMI are others if they route through it.
2. The general `four_of_bothKind` keeps `β₁ < β₂` or takes § 2.7's separated interval. With `β₁ ≤ β₂` alone it is false (FS131-E2-MONSTER).
3. Wave 4's `noBoth` keeps its statement; its proof runs on sectors.

### 3.2 Attack on the questions themselves

- **Does the setting make the cusp case vacuous?** No. A cusp tile is a Jordan domain, so simple allows it. FS131-E2-MODEL has a cusp at a
  both-kind centre, in a non-Siamese simple valid fragment. The cusp case is inhabited, and it is fine because of a hypothesis already stated:
  simple forbids a tile on both sides of a cusp, which is what the implementer's picture needs.
- **Is "simple" used only there?** Yes. Of simple, the clause reads only "each tile one sector at `z`" (FS131-E2-SEP). The second clause,
  closures meeting in connected sets, is idle. So the clause holds in the class "non-Siamese, every tile at `z` one sector at `z`", a local
  condition at `z` (a generalization, below).
- **The statement's wording, a monster in Lakatos's sense.** FS116-V5-U1 says "so if z carries both c and c′ (A is both-kind), the side cones hold
  two further colours and, in a non-Siamese simple fragment, z has at least four colours". The clause "the side cones hold two further colours"
  sits outside "in a non-Siamese simple fragment". Read as "two different further colours", it is false there: FS131-E2-MONSTER is valid and
  non-Siamese, and one colour fills both side cones. Read as "a further colour in each side cone", it is true and is what the Lean states
  (`ringArc_sideCone_other`). The monster exposes the unfixed term; the correction is a wording one (§ 3.4 draft 2).
- **Is the hand argument itself in cones or in sectors?** In sectors. V5-U1's says "a sector meeting both side cones would contain one of
  those sectors", and N3's and NB3's name the horn. The defect was only in the formal route's translation, sectors to cones, which is exact
  except at a cusp.

### 3.3 Predictions scored

| # | registered | p | outcome | Brier |
|---|---|---|---|---|
| P1 | Q1 derived | 0.88 | **met** — FS131-E2-U1-CUSP | 0.0144 |
| P2 | Q2 derived | 0.93 | **met** — FS131-E2-NOBOTH-CUSP | 0.0049 |
| P3 | no consumer changes; no ledger or `CLAUDE.md` correction | 0.88 | **met** — § 3.1 (two wording errata and one overstated "Rests on it", no statement) | 0.0144 |
| P4 | the implementer's picture realizable as an exact valid fragment, non-Siamese and simple but for one tile, refuting the 05cb0a3e form | 0.75 | **met** — FS131-E2-MONSTER | 0.0625 |

Mean Brier 0.024. All four point the same way, toward the derivation I had seen before registering (§ 1.4). They measure how far reading the
arguments had settled the question before the entries were written, more than any risk taken.

### 3.4 Drafts for the coordinator (each names its slot; Keryx's pen)

1. **`plans/FS131-close-inventory.md`, a new item after the last** (it answers item 112's "Correction owed"):
   > **FS131-E2 answered item 112** (report `data/fs131/reports/FS131-E2.md`; record `plans/FS131-E2-derivation.md`): the four-colour clause of
   > FS116-V5-U1 **holds with cusps** in the non-Siamese simple class (FS131-E2-U1-CUSP, [hand], one mind); FS112-N3-NOBOTH holds with cusps in
   > every valid map (FS131-E2-NOBOTH-CUSP; its two minds had the case in a clause). Item 112's "held only with no cusp at `z`" is withdrawn; no
   > hand consumer inherits anything (§ 3.1); no ledger row or `CLAUDE.md` statement changes. The skeleton's general `four_of_bothKind` (05cb0a3e,
   > `β₁ ≤ β₂`) is **false**: FS131-E2-MONSTER, an exact valid non-Siamese fragment, simple but for one tile wrapped round a cusp, three colours at a
   > both-kind centre — so the ruling's `β₁ < β₂` was needed there. `four_of_bothKind_simple` holds **without `hnc`** through a separated-interval
   > lemma on `localSectors` (`Simple.coneAt_eq_angleIcc_sep`, record § 2.7).
2. **`plans/FS116-derivation.md`, a dated paragraph after the paragraph that follows derivation FS116-V5-U1** (the one beginning "V5's lemma,
   one mind; known (FS112-U1). Rests on it:"), the entry left standing:
   > *Note (2026-10-04, FS131-E2, `plans/FS131-E2-derivation.md`):* the four-colour clause holds when a tile at `z` has a cusp there
   > (FS131-E2-U1-CUSP): of simple it reads only "one sector per tile at `z`" (FS131-E2-SEP), which a tile wrapped round a cusp violates. "The side
   > cones hold two further colours" is true as "each side cone holds a colour other than `c` and `c′`"; as "two different further colours" it needs
   > the class's hypotheses — FS131-E2-MONSTER (valid, non-Siamese, one tile not a Jordan domain) has one colour in both side cones. FS116-V5's
   > second derivation of FS116-N3-PAIR does not read this entry.
3. **`plans/FS116-N3-proof.md` § 2.1 (c)**, after "— four colours, the class being non-Siamese.": a dated note: "*(2026-10-04, FS131-E2:)* and
   simple — a repeated colour may be one tile on two sectors, which simple excludes and non-Siamese does not; the § 2.4 uses line names both."
4. **`plans/FS129-derivation.md`, under derivation FS129-SR1-BENDLE3**, a dated note after its "Rests on it" paragraph: "*(2026-10-04,
   FS131-E2:)* in `uses only:`, 'one cone per tile at a vertex' should read 'one sector per tile at a vertex' — at a cusp an interval cone does not
   give one sector (FS131-E2-MONSTER); the statement is unchanged."

No ledger row, no `CLAUDE.md` text, no grokking and no bibliography row is drafted: none changes. No external literature was read. Every
statement here is a lemma about this project's own class, and the prior-art lines name in-house sources.

# FS131-E2 — the cusp case of the both-kind four-colour clause

*Job FS131-E2, Ephodos (Opus 5.5), 2026-10-04. Brief: `data/fs131/briefs/FS131-E2-cusp-case.md`, with `plans/STANDING-RULES.md`. Claim list:
`data/fs131/claims-E2.md`. Working files: `data/fs131/e2/`; tools `tools/fs131_e2_*.py`. Nothing in this milestone is blind (the brief's fences:
none). No agents, no search, no Lean builds.*

## Theorems this phase proved

*(filled at the last stage)*

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

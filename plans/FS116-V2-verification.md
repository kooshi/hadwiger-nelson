# FS116-V2 — a blind second mind on three round-2 claims of FS-116's list

*Job FS116-V2, Ephodos in its verification form (Opus 5.5), launched 2026-09-29 06:30 UTC. Brief: `data/fs116/briefs/FS116-V2-verify.md`, with
`plans/STANDING-RULES.md`. The statements: `data/fs116/claims.md` § 10 (frozen by Keryx 2026-09-29 06:28 UTC). Working files: `data/fs116/v2/`;
exact checks: `tools/fs116_v2_*.py`. Blind, the same model as the minds whose work I compare against after my verdicts are committed.*

## Theorems this phase proved

*Stage 1: none. Stage 2: § 2.4. Stage 3: § 3.5.*

## Fence log

- No fenced path opened. Disclosed, though not in the fence list: the brief lets me read `plans/FS114-derivation.md` "(its entries' statements;
  not the records their `argument:` lines point to)". I read its header and § 3 as whole entries — the `statement:`, `uses only:`, `not claimed:`,
  `minds:` and `model:` lines, not only the statements — at about 06:35–06:45 UTC. No record an `argument:` line points to was opened. What
  those lines carried that bears here is listed under *given* below.

## Stage 1 — SAVED

### 1.1 Readback

The brief's three quotations (§ The statements) were compared character for character with `data/fs116/claims.md` § 10 by a script
(2026-09-29, about 06:50 UTC): **RING-GERM identical (1,144 characters), RING-TWIST-C identical (1,445), FS116-N1-TWIST-LIT identical (491).**
The source notes ("data/fs116/claims.md § 10. Added at round 2") are right. One note on the brief's own prose, not a quotation: § Why this job
says FS-116 "asks whether an explicit radius exists within which no valid six-coloured fragment with unit arcs survives about a vertex of at
least four colours (`data/fs116/claims.md` § 1)"; § 1's C114-LOCAL-F adds "one `R` for every complexity, Siamese pairs allowed". Not a
mismatch in anything I verify; logged for the coordinator.

The statements, verbatim from `data/fs116/claims.md` § 10:

> **RING-GERM** *(proposed at round 1)*: in a non-Siamese valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, let y be a change point of the ring, X the colour of the ring just counter-clockwise of y and X̄ the colour just clockwise, and u⁻, u⁺, v⁻, v⁺ the arcs of ω(p) just clockwise and just counter-clockwise of the ring points y + 60° and y − 60°; then p has four colours and no more, X and X̄ are the colours absent at p, and (i) if neither v⁻ nor u⁺ lies on a (Q) arc, every direction at y in the open cone of 60° about the direction to p lies in the cone of a tile of p; (ii) if neither u⁻ nor v⁺ lies on a (Q) arc, every direction at y in the open cone of 60° about the direction away from p lies in the cone of a tile of a colour of p that is not a tile of p; (iii) if none of the four lies on a (Q) arc, y is a vertex of at least four colours *Not claimed:* anything at k ≥ 7; that a change point with a germ on a (Q) arc has fewer than four colours (the strip's P₂ has four, with u⁺ and v⁻ on (Q) arcs); that the ring's change points are 60° apart (N6-RING60's conclusion, for (Q)-free rings)

> **RING-TWIST-C** *(proposed at round 1)*: at a vertex p of at least four colours of a valid fragment on a closed disc of radius above 1 about p (Siamese pairs allowed, any degree), the set D of points of ω(p) in the closure of a tile of one of p's colours is closed and lies in the union of the arcs of Γ on ω(p) and finitely many points; and for every half-open 60° window W of ω(p) with W ∪ σ(W) disjoint from D: p has four colours and no more; off a finite set, every point of W ∪ σ(W) lies in the closures of tiles of a single colour, one of the two colours absent at p, and this colour differs at θ and at θ + 60° for θ in W; every arc of Γ on ω(p) meeting W ∪ σ(W) in an arc has one colour on both sides; W holds an odd number of colour changes — points of W at which that colour differs on the two sides — each lying in the closures of tiles of the two absent colours and of no other colour; every change point in W is a colour change, and a colour change in W that is not a change point lies on an arc of Γ on ω(p) with one colour on both sides; so W holds an odd number of change points when no such arc meets W, in particular in every non-Siamese simple fragment *Not claimed:* anything at k ≥ 7; that any fragment of the class has a qualifying window (no held fragment has one: the strip's and the disk's D-free arcs are at most 60° and 87.83°); the parity of change points when a seam meets W (FS116-N1-TWIST-LIT: then it can fail)

> **FS116-N1-TWIST-LIT** *(proposed at round 1)*: RING-TWIST's parity clause as posed — every half-open 60° window W of ω(p) with W ∪ σ(W) disjoint from D holds an odd number of change points — holds on every fragment of RING-TWIST's class if and only if no fragment of that class has a half-open 60° window W with W ∪ σ(W) disjoint from D *Not claimed:* that the class has a fragment with a qualifying window; anything in the non-Siamese simple class, where the clause holds by RING-TWIST-C

RING-TWIST's class, which FS116-N1-TWIST-LIT names, is § 5's (verbatim): "at a vertex `p` of at least four colours of a valid fragment on a
closed disc of radius above 2 about `p` (Siamese pairs allowed, any degree)".

### 1.2 Definitions used, and three terms asked

Used as quoted in `data/fs116/claims.md` § 0: valid fragment, (Q), Siamese, `Γ` and tiles, ring and change point, simple. From FS-110/FS-112's
notation (`plans/FS112-N-proof.md` header; `data/fs110/claims.md` § 0): `P_cl(x)`, the colours of tiles whose closure contains `x`; a **tile
of `p`** is a tile whose closure contains `p`; `ω(x)` the unit circle about `x`. Siamese is read as the project reads it
(`data/fs110/claims.md` § 0, quoting `plans/FS107-stability.md`): two distinct tiles of one colour have all cross-distances `≥ 1`, or all `≤ 1`
(Siamese).

Three terms are not fixed by the statements' words. I sent the author three questions through "main" (2026-09-29, about 06:55 UTC) and work
under these readings until answered, stating each verdict under the alternative too:
- **Q1, change point.** Reading **L**: a change point has ring points off `Γ` arbitrarily close to it on *both* sides (it is an isolated point
  of `Γ ∩ ω(p)`), and X, X̄ are those points' colours; a point on, or at an end of, an arc of `Γ` on `ω(p)` is not a change point. The
  alternative **G**: a side's "colour of the ring off `Γ`" is that of the nearest off-`Γ` ring point on that side, however far.
- **Q2, arc of `Γ`.** Reading: an edge of the map (one tile on each side all along it), not a longer circular arc of `Γ` through vertices.
- **Q3, orientation.** Reading: `y + 60°` is the ring point counter-clockwise of `y`.

**The answers** (the coordinator, 2026-09-29, before this stage's commit; the author is past its line, so the coordinator read the proposing
record for definitions only), quoted as received:
- Q1: "reading (L) is the record's. Its one sentence on it, verbatim: "A change point in W has the ring off `Γ` on both sides with different
  colours" (plans/FS116-N1-proof.md l. 181). So a point on, or at an end of, an arc of Γ on ω(p) is not a change point, and X, X̄ are the colours
  of the ring off Γ on the two sides. Report (G) too where a verdict differs."
- Q2: "the record gives no definition of "arc of Γ on ω(p)". Work your stated reading (an edge of the map lying on ω(p)), and say where a verdict
  depends on it."
- Q3: "your orientation matches the record's notation, verbatim: "`σ` the rotation by `60°` about `p`, `r(θ) = p + e(θ)` the ring point at angle
  `θ`" (l. 9–10), angles in the usual counter-clockwise sense, so y + 60° is counter-clockwise of y."

So the working readings are the author's for Q1 and Q3, and mine, sanctioned, for Q2. The two sentences quoted from the fenced record are
*given* (§ 1.3).

### 1.3 Given (everything seen before any verdict)

- The brief, with the three statements, their purpose ("Its next phase follows the ring of such a vertex … outward to a contradiction"), and the
  note that another mind works the same list; no verdict, sketch or route of FS-116's round 1.
- `data/fs116/claims.md` in full. It carries, in § 8 (FS114-N7-3T's statement, verbatim from `plans/FS114-derivation.md`), a sketch of N7-HUB —
  the (Q)-free ancestor of RING-GERM (iii): "the directions toward `p` there lie in tiles of `p` reaching `y_k`, a tip, which meets
  `B(y_{k−1},1) ∩ B(y_{k+1},1)`, so its colour is carried at `y_{k±1}` by no other tile, and the outward directions in tiles of `p`'s colours outside
  `B̄(p,1)` whose `p`-tiles face away". And § 5's RING-TWIST, the ancestor of RING-TWIST-C.
- `data/fs114/claims.md` in full; `plans/FS114-derivation.md` header and § 3 as whole entries (see the fence log). Statements there that bear
  here: FS114-N3-LOCAL's **N3-ODD** ("Off `Γ`-arcs of `ω(p)`, every half-open 60° window of the ring of a four-colour vertex holds an odd number of
  change points") and **N3-FLANK**; FS114-Y4-LUNE's **Y4-UPDOWN** ("If `|u − v| = 1`, a tile at `u` with a direction `ψ` at `u` with
  `cos(ψ − arg(v − u)) > 0` has points within `< 1` of `v`, hence of every tile at `v`: in a non-Siamese map its colour is absent at `v` unless it is
  that tile"); FS114-N4-LEMMAS' **N4-LENS**; FS114-N6-NOQ's **N6-RING60**; FS114-N7-QOPP's **N7-FLANK** and **N7-CHAIN**. No argument of any of them.
- `plans/FS112-derivation.md` header and its first entries (FS112-U1, -SIX, -NB4P); `plans/FS112-N-proof.md` lines 1–12 (N-E0, N-E1, N-E2 as
  stated there); `data/fs112/claims.md` § 0; `data/fs110/claims.md` lines 20–35; `LEDGER.md` rows 135–138; `CLAUDE.md` and the grokkings (G83–G86
  name rings, N7-HUB and Siamese pairs).
- `data/fs112/fs112-yb/strip-objects.txt` (FS112-YB's exact listing of the uncapped strip: vertices, sectors, colours, arcs) — read to build a
  control, after the questions were sent.
- From the coordinator's answers (§ 1.2), two sentences of the round-1 proof record (`plans/FS116-N1-proof.md` l. 181 and l. 9–10), quoted
  there as definitions: "A change point in W has the ring off `Γ` on both sides with different colours" and "`σ` the rotation by `60°` about
  `p`, `r(θ) = p + e(θ)` the ring point at angle `θ`". The first is a sentence the round-1 argument may use as a step; I received it before
  deriving.
- **Timing, honestly.** The predictions below were registered after reading the lists and about twenty minutes of reasoning in my head, in
  which I sketched arguments for all three statements. They are informed predictions, not naive ones, and their score is weak evidence of
  calibration.

### 1.4 Predictions (registered before any written derivation)

| statement | expected verdict | probability | likeliest break |
|---|---|---|---|
| RING-GERM | derived (TRUE) | 0.85 | the reading of "change point" when y ends an arc of Γ on ω(p) (under reading G, (i) loses the ring colour it needs just beside y); second, the edge of the 60° cones |
| RING-TWIST-C | derived (TRUE) | 0.80 | clause "every arc of Γ on ω(p) meeting W ∪ σ(W) in an arc has one colour on both sides" if an arc of Γ runs past the window into D; "every change point in W is a colour change" under reading G; the closed end of the half-open window, where D's closedness must be spent |
| FS116-N1-TWIST-LIT | derived (TRUE) | 0.90 | the "only if" direction needs a fragment of the class with a seam laid on the ring; if the class excluded seams, that construction would not be available |

### 1.5 Would have searched here

- *(none at stage 1)*

## Stage 2 — SAVED

### 2.1 Frame and lemmas (for all three statements)

Six colours. `p = 0`, `e(θ) = (cos θ, sin θ)`, angles counter-clockwise (Q3). The fragment is a map of an open set `Ω ⊇ B̄(p, R)`, `R > 1`;
tiles are the components of `Ω ∖ Γ`. Everything below reads only `B̄(p, 1 + ε)`.

**V2-L0 (one-colour distances).** For tiles `S, T` of one colour the set `{|s − t| : s ∈ S, t ∈ T}` is connected (`S × T` is) and misses 1
(validity). So one tile has `diam cl T ≤ 1`, and two distinct tiles of one colour have all cross-distances `< 1` (Siamese) or all `> 1`. In
particular two distinct tiles of one colour whose closures share a point are Siamese.

**V2-L1 (the ring's own colour; N-E1 re-derived).** A tile meeting `ω(p)` has a colour absent at `p`: if `z ∈ ω(p) ∩ T` with `B(z, ρ) ⊆ T`, and
`T′` of `T`'s colour has `p ∈ cl T′`, pick `t′ ∈ T′` with `|t′| < ρ/2`; then `z + t′ ∈ T` and `|(z + t′) − t′| = 1`.

**Germs.** Finitely many arcs of `Γ` meet the annulus `1/2 ≤ |x| ≤ 3/2`. Let `E ⊂ ω(p)` be the finite set of points lying on an arc of `Γ` not
contained in `ω(p)` (a line or another circle meets `ω(p)` at most twice) and of endpoints of arcs of `Γ` contained in `ω(p)`. A **germ** at
`e(θ₀)`, just counter-clockwise (clockwise), is `e(θ)` for `θ` in `(θ₀, θ₀ + δ)` (`(θ₀ − δ, θ₀)`), `δ` so small that the interval misses `E`. Near
such a germ the only boundary is `ω(p)` itself or nothing, so it has an **inner** and an **outer** side tile; write `sides(g)` for their two
colours. Either the germ is off `Γ` (one tile, `sides(g)` one colour, absent at `p` by V2-L1), or it lies on an arc of `Γ` contained in `ω(p)` — a
unit arc about `p` — whose side colours are `sides(g)`.

**V2-L2 (a germ with only `p`'s colours is (Q)).** If both side colours of a germ are colours of `p`, the germ is not off `Γ` (V2-L1), so it lies
on an arc of `Γ` on `ω(p)` whose centre `p` carries both side colours and at least four colours: a (Q) arc (`data/fs116/claims.md` § 0). [Under
Q2's reading the arc is the edge holding the germ.]

**V2-L3 (the ring's 60° rule, on germs).** For a germ `g` at `e(θ₀)` and the germ `g + 60°` on the same side of `e(θ₀ + 60°)`,
`sides(g) ∩ sides(g + 60°) = ∅`. *Proof.* Take a compact interval `J` of angles inside `g` with a radial band `1 − η₀ < |x| < 1 + η₀` over `J`
and over `J + 60°` in which the only boundary is `ω(p)`. For `ρ₁, ρ₂` on the chosen sides of 1 (inner or outer, independently), within `η` of
1, the equation `ρ₁² + ρ₂² − 2ρ₁ρ₂ cos Δ = 1` has a root `Δ(ρ₁, ρ₂) → 60°` as `η → 0`; for `η` small it lies in `(J + 60°) − J`, an open
interval about 60°, so points `ρ₁ e(φ)`, `ρ₂ e(φ + Δ)` with `φ ∈ J`, `φ + Δ ∈ J + 60°` are interior points of the two side tiles at distance
exactly 1. ∎

**V2-L4 (the two sides of a unit circle).** Let `T` be a tile at a point `y` with an interior direction `ψ` (an open sector
`{y + r e(ψ′) : 0 < r < ρ, |ψ′ − ψ| < δ} ⊆ T`), `|w − y| = 1`, and `κ = cos(ψ − arg(w − y)) ≠ 0`. Then there is `ρ₀ > 0` such that no
interior point `x` of `T`'s colour has `|x − w| < ρ₀` and `(|x − y| − 1)·κ > 0`: near `w`, `T` forbids its colour on the far side of `ω(y)`
when `κ > 0` and on the near side when `κ < 0`. *Proof.* `g(r)² = |x − y − r e(ψ)|² = |x − y|² − 2r κ_x + r²`, `κ_x = (x − y)·e(ψ) → κ`
as `x → w`. If `κ > 0` and `|x − y| > 1` the smaller root `r* = κ_x − √(κ_x² − (|x − y|² − 1))` of `g(r)² = 1` is positive and tends to 0 as
`x → w`; if `κ < 0` and `|x − y| < 1`, `r* = −|κ_x| + √(κ_x² + 1 − |x − y|²)` likewise. So `y + r* e(ψ) ∈ T` is at distance 1 from `x`. ∎

**V2-L5 (the near side of a unit circle, colour for tile; Y4-UPDOWN's content).** With `T`, `y`, `ψ`, `w` as in V2-L4 and `κ > 0`, `T` has
points within `< 1` of `w`, hence within `< 1` of points of every tile at `w`; a tile at `w` of `T`'s colour is `T` itself or Siamese with it
(V2-L0).

### 2.2 RING-GERM, derived (reading L)

Rotate so that `y = e(0)`. By reading L both germs of `y` are off `Γ`: the counter-clockwise one, `(0, δ)`, lies in a tile of colour `X`, the
clockwise one in a tile of colour `X̄`, and `X ≠ X̄` (change point).

**(0a), (0b).** `X, X̄` are absent at `p` (V2-L1) and distinct, so at most four colours are at `p`; with at least four, exactly four, and
`{X, X̄}` is the set of absent colours. So every tile has a colour of `p` or `X` or `X̄` (six colours: this is where "six" is spent).

The four germs: `u⁻ = (60° − δ, 60°)`, `u⁺ = (60°, 60° + δ)`, `v⁻ = (−60° − δ, −60°)`, `v⁺ = (−60°, −60° + δ)` — `u⁺, v⁻` the two farther
from `y`, `u⁻, v⁺` the two nearer.

**(R1)**, by V2-L3 from `y`'s germs (`(0, δ)` is `u⁺ − 60°` and `v⁺ + 60°`; `(−δ, 0)` is `u⁻ − 60°` and `v⁻ + 60°`):
`X ∉ sides(u⁺) ∪ sides(v⁺)` and `X̄ ∉ sides(u⁻) ∪ sides(v⁻)`.

Let `T` be a tile at `y` with an interior direction `ψ`, colour `c`. From `y`, `e(60°) − y = e(120°)`, `e(−60°) − y = e(240°)`, `p − y = e(180°)`.
The far side of `ω(y)` near `e(60°)` holds `u⁺`'s two sides (`|e(60° + s) − y| = 2 sin(30° + s/2) > 1`) and the near side holds `u⁻`'s; near
`e(−60°)` the far side holds `v⁻`'s and the near side `v⁺`'s.

**(i).** For `ψ ∈ (150°, 210°)`: `cos(ψ − 120°) > 0` and `cos(ψ − 240°) > 0` — the open inward cone is exactly the set of directions where
both are positive. By V2-L4, **(R2)** `c ∉ sides(u⁺) ∪ sides(v⁻)`. If `c = X`: `sides(v⁻)` misses `X` (R2) and `X̄` (R1), so it holds only
colours of `p`, and `v⁻` lies on a (Q) arc (V2-L2). If `c = X̄`: `sides(u⁺)` misses `X̄` (R2) and `X` (R1): `u⁺` on a (Q) arc. So under
(i)'s hypothesis `c` is a colour of `p`. As `cos(ψ − 180°) > 0`, V2-L5 at `w = p` makes `T` a tile of `p` or Siamese with `p`'s tile of colour
`c`; **non-Siamese** leaves the first. A direction of the open cone that is no tile's interior direction is an edge direction at `y`
(finitely many, local finiteness); it lies in the closed cones of the tiles beside it, which have interior directions in the open cone. ∎(i)

**(ii).** For `ψ ∈ (−30°, 30°)`: `cos(ψ − 120°) < 0` and `cos(ψ − 240°) < 0`. By V2-L4, **(R3)** `c ∉ sides(u⁻) ∪ sides(v⁺)`. If `c = X`:
`sides(u⁻)` misses `X` (R3) and `X̄` (R1) — `u⁻` on a (Q) arc. If `c = X̄`: `sides(v⁺)` misses `X̄` (R3) and `X` (R1) — `v⁺` on a (Q) arc. So
under (ii)'s hypothesis `c` is a colour of `p`. `T` is not a tile of `p`: its points `y + r e(ψ)` have `|y + r e(ψ)|² = 1 + 2r cos ψ + r² > 1`,
so `p ∈ cl T` would give `diam cl T > 1` (V2-L0). Edge directions as in (i). ∎(ii) — **no use of non-Siamese.**

**(iii).** `X, X̄` are colours at `y` (its two ring germs' tiles). By (i) a tile `T_in` at `y` in the inward cone is a tile of `p`, colour
`a`; by (ii) a tile `T_out` in the outward cone has a colour `b` of `p` and is not a tile of `p`. They are distinct tiles; if `a = b` their
closures share `y`, so they are Siamese (V2-L0), which **non-Siamese** excludes. So `y` carries `X, X̄, a, b`, four colours, and at least three
tiles meet there: a vertex. ∎(iii)

**Where each hypothesis is spent.** Six colours: (0a) and the three-way split `c ∈ P_cl(p) ∪ {X, X̄}`. Non-Siamese: the last step of (i) and
`a ≠ b` in (iii) only. Radius above 1: only `B̄(p, 1 + ε)` is read. The (Q)-hypotheses: each of (i)'s two germs is spent on one absent colour
(`v⁻` on `c = X`, `u⁺` on `c = X̄`), each of (ii)'s likewise (`u⁻` on `X`, `v⁺` on `X̄`). Reading L: in (R1), through `y`'s two germs being off
`Γ` with the colours `X`, `X̄`.

### 2.3 Attack on RING-GERM

- **The one held model, exactly** (`tools/fs116_v2_strip.py`; controls `strip-listing` and `strip-ring-germ` below). The uncapped strip
  (`[AxenovichEtAl2014]` Thm 4.2, LEDGER row 136) rebuilt by formula from FS-112's listing, the rebuild checked against all 48 vertex sectors
  of that listing (0 disagreements; the plant recolouring `U₁` gives 5). It is a non-Siamese valid fragment on `B̄(P₀, R)` for every
  `R < √15/4 + √3/2 ≈ 1.834` (FS112-YB: every same-colour pair within reach touches at exactly 1, none closer). The ring of the midline vertex
  `P₀` (colours `{P, B, M, O}`) has, under reading L, two change points, `P_{±2} = (±1, 0)`: at `P₂`, `X = G`, `X̄ = R` — the absent colours
  (0a, 0b hold); `u⁺` and `v⁻` lie on (Q) arcs and `u⁻`, `v⁺` do not (as the not-claimed line says of "the strip's P₂"; the list does not give its indexing, and `P_{±2}` are the only change points on `P₀`'s ring); (ii)'s
  hypothesis holds and its conclusion holds (the outward cone lies in `U₂` (B) and `D₂` (O), colours of `P₀`, tiles not of `P₀`); `P₂` has four
  colours. **The attack succeeds on (i) without its hypothesis:** at `P_{±2}` the inward cone lies in `U₁` (G) and `D₁` (R), colours absent at
  `P₀` — (i)'s conclusion fails exactly where its hypothesis fails, so the hypothesis is spent, and the nearest false statement is (i) with it
  dropped (or with it put on the near germs `u⁻, v⁺`, which is what the clockwise orientation would read: the tool's `--cw` fault finds the
  violation at both points).
- **The term the statement did not fix (a monster, settled by the author).** Under reading G the strip refutes RING-GERM: the apex
  `(1/4, √15/4) = e(arccos ¼)` of `P₀`'s ring ends the (Q) arc `U₀ | T₁` on its clockwise side, so under G it is a change point with
  `X = R`, `X̄ = G`; all four germs at `±60°` from it are off `Γ` (hypotheses (i)–(iii) hold), yet the outward cone meets `T₀` (R, absent at
  `P₀`) — (ii) fails — and the apex has three colours `{P, R, O}` — (iii) fails. The same at the three mirror images. Under G, interior points
  of the four (Q) arcs are change points too, and (iii) fails there (two colours). Under reading L (the author's, Q1) none of these is a change
  point. So the verdict is **derived under L; refuted under G** (the strip's apexes); the argument's break under G is (R1), which needs `y`'s own
  germs off `Γ`.
- **Each hypothesis removed.** The (Q)-hypotheses: spent (above, on the strip). Non-Siamese: spent in (i) and (iii) by the argument; I hold no
  model with Siamese pairs to show the failure. It is **idle for (0a), (0b) and (ii)**: those hold in every valid fragment, Siamese pairs allowed
  — a thin truth for the content, reported for the class. Radius above 1: idle beyond `1 + ε`.
- **The cones' edges.** At `ψ = 150°` (the edge of (i)'s cone) `cos(ψ − 240°) = 0`: V2-L4 is silent at first order at `e(−60°)`, and the
  argument stops. The open 60° cones are exactly the directions where both first-order signs are right; no model shows a failure just outside.
- **Six colours.** At `k ≥ 7`, (0a) and (0b) fail trivially (a four-colour `p` has three absent colours); not claimed.
- **Smallest cases.** A change point at a tangency (the strip's `P_{±2}`: the vertical edge through `P₂` is tangent to `ω(P₀)` there) is
  covered: V2-L4 and V2-L3 read germs, not crossings. A cusp at `y` in a cone: its tile holds a curve leaving `y` in direction `ψ`, and V2-L4's
  root argument runs along it.

### 2.4 Theorems this stage proved

- **RING-GERM**, as stated, under reading L — [hand; one derivation here, blind to the round-1 argument; the minds count is written after the
  comparison]. § 2.2.
- **V2-RG-THIN**: RING-GERM's (0a), (0b) and (ii) hold in every valid fragment on a closed disc of radius above 1 about a vertex of at least
  four colours, Siamese pairs allowed — [hand, one mind]. § 2.2 (ii).
- **V2-RG-G**: under reading G of "change point", RING-GERM is false: the strip's apex `(1/4, √15/4)` of `P₀`'s ring violates (ii) and (iii) —
  [computed over: the strip's ring of `P₀`, `tools/fs116_v2_strip.py`, rational sample points, exact colour oracle].
- **V2-RG-STRIP**: on the strip, (i)'s conclusion fails at `P_{±2}`, where its hypothesis fails; (0a), (0b), (ii) hold there — [computed over:
  the same].

### 2.5 Would have searched here

- None. The strip check reads one fixed object given by formula (no enumeration of maps or colourings).


## Stage 3 — SAVED

Frame, germs and lemmas V2-L0 … V2-L5 as in § 2.1. "Arc of `Γ` on `ω(p)`" is read as an edge of the map lying on `ω(p)` (Q2); "change point"
by reading L (Q1).

### 3.1 RING-TWIST-C, derived (reading L, Q2's edge reading)

**(D) `D` is closed and lies in the arcs of `Γ` on `ω(p)` and finitely many points.** Finitely many arcs of `Γ` meet the annulus
`A = {1/2 ≤ |x| ≤ 3/2} ⊂ Ω`, so `int A ∖ Γ` has finitely many components, each inside one tile, and a tile whose closure meets `ω(p)` meets
`int A`. So `D = ω(p) ∩ ⋃ cl T` over finitely many tiles `T` of `p`'s colours: closed. A point of `ω(p)` off `Γ` lies in one tile `T`, the only
tile whose closure holds it, and `T`'s colour is absent at `p` (V2-L1): so `D ⊆ Γ ∩ ω(p)`, which is the arcs of `Γ` on `ω(p)` together with the
finite set `E` of § 2.1. No six-colour count and no Siamese hypothesis are used.

**The window.** Let `W` be half-open, say `W = [θ₀, θ₀ + 60°)` (the case `(θ₀, θ₀ + 60°]` is its mirror image), with `W ∪ σ(W)` disjoint from
`D`. As `D` is closed and `θ₀ ∉ D`, some `δ > 0` makes the extended window `Ŵ = (θ₀ − δ, θ₀ + 120°)` disjoint from `D` — **the one place
`D`'s closedness is spent** (it gives the colour just before the closed end of `W`). Write `Ŵ₁ = (θ₀ − δ, θ₀ + 60°)`, so `Ŵ₁` and
`Ŵ₁ + 60°` lie in `Ŵ`, `W ⊆ Ŵ₁` and `σ(W) ⊆ Ŵ₁ + 60°`. For `φ ∉ E` let `S(φ)` be the colours of the side tiles at `e(φ)` (one tile if off
`Γ`); these are exactly the tiles whose closure holds `e(φ)`, and for `φ ∈ Ŵ ∖ E` they have absent colours.

**(a) Four colours and no more.** Take `φ ∈ W` with `φ, φ + 60° ∉ E`. `S(φ)` and `S(φ + 60°)` are non-empty sets of absent colours and are
disjoint (V2-L3). With six colours at `p` there is no absent colour; with five, one, and the two sets would meet. So `p` has four, and two
absent colours `X, Y`.

**(b) One colour, alternating.** For `φ ∈ Ŵ₁` with `φ, φ + 60° ∉ E`, `S(φ)` and `S(φ + 60°)` are disjoint non-empty subsets of `{X, Y}`, so
each is a singleton and they differ: write `c(φ)` for the colour, `c(φ + 60°) ≠ c(φ)`. So off the finite set `E ∪ (E ± 60°)` every point of
`W ∪ σ(W)` (indeed of `Ŵ`) lies in the closures of tiles of the single colour `c(φ) ∈ {X, Y}`, and it differs at `θ` and `θ + 60°`.

**(c) Arcs of `Γ` in the window are seams.** An edge of `Γ` on `ω(p)` meeting `W ∪ σ(W)` (or `Ŵ`) in an arc has, at the points of that arc
off the finite set, `S(φ) = {c(φ)}`: its inner and outer tiles have one colour; an edge has one tile on each side all along it, so they have
one colour all along. *Under a reading of "arc of `Γ`" as any circular arc contained in `Γ`, possibly through vertices, the clause is not
derived for the part of such an arc outside `Ŵ`* (its side colours there are unconstrained); no held fragment has a qualifying window, so I
have no model either way — a wording point, § 3.2.

**(d) Odd, and bichromatic.** On each component of `Ŵ ∖ E` the side tiles are constant, so `c` is locally constant off a finite set and has
one-sided limits `c(φ⁻)`, `c(φ⁺)` at every `φ ∈ Ŵ`; a colour change is a point where they differ, and there are finitely many. `c` takes two
values, so the number of colour changes in `[θ₀, θ₀ + 60°)` — the flips between `c(θ₀⁻)` and `c((θ₀ + 60°)⁻)` — is odd iff these differ, and
they do: points just below `θ₀` lie in `Ŵ₁`, so `c(φ + 60°) ≠ c(φ)` there. At a colour change `z ∈ W` the two limits are realised by tiles
whose closures hold `z`, so both absent colours are there; `z ∉ D`, so no colour of `p` is.

**(e) Change points and colour changes.** A change point `y ∈ W` (reading L: ring off `Γ` on both sides near `y`, different colours) has those
off-`Γ` colours equal to `c(y⁻)` and `c(y⁺)`: a colour change. Conversely `c` is locally constant off `Γ` (a point off `Γ` has a tile
neighbourhood), so a colour change `z` lies on `Γ`; if the ring were off `Γ` on both sides near `z`, `z` would be a change point; so on at
least one side the germ at `z` lies on an edge of `Γ` on `ω(p)` with `z` in its closure, and that edge meets `Ŵ` in an arc, so by (c) it has one
colour on both sides.

**(f) The parity of change points.** If no edge of `Γ` on `ω(p)` with one colour on both sides meets `W`, every colour change in `W` is a change
point by (e) (its edge would meet `W` at `z`), and every change point is a colour change: the change points in `W` are the colour changes,
an odd number by (d). In a non-Siamese simple fragment no edge has one colour on both sides: its two sides are two distinct tiles of one
colour with a common boundary arc — Siamese (V2-L0) — or one tile on both sides of an arc, whose closure then meets itself along it, which
simplicity forbids (I read "does not meet itself" as excluding that).

**Where each hypothesis is spent.** Six colours: (a) and (d) (two absent colours, so each flip flips). `D ∩ (W ∪ σ(W)) = ∅`: (a), (b) (every
side colour absent), and — with `D` closed — the colour just outside the closed end of `W` in (d). Siamese pairs and degree: nowhere; the
class is as wide as stated. Reading L: (e)'s first half and (f). Q2: (c) and (e)'s second half.

### 3.2 Attack on RING-TWIST-C

- **The first clause on the one held model** (`tools/fs116_v2_strip.py --D`; control `strip-D`). On the strip's ring of `P₀`, `D` is the four
  (Q) arcs (total 62.09°) and the two points `P_{±2}` (whose tiles `U_{±2}`, `D_{±2}` carry `B, O` or `P, M`, colours of `P₀`): closed, in the
  arcs of `Γ` on `ω(P₀)` and two points, as stated. Its six `D`-free arcs are at most 60° long (exactly 60° four times), so the strip has no
  qualifying window — the not-claimed line's "the strip's … D-free arcs are at most 60°", confirmed; the disk's "87.83°" is not checked here
  (the disk is not rebuilt in this job).
- **The window clauses have no model.** No held fragment has a qualifying window, and whether any fragment does is open (not claimed). Every
  window clause is a conditional over a class that may be empty; its verdict says it carries a conditional, nothing more.
- **Where the attack succeeds.**
  (1) *The parity of change points with a seam in `W`* — not claimed, and it does fail: § 3.3's construction turns any qualifying window into
  one whose change points are even.
  (2) *Reading G of "change point"* — (e)'s first half fails: on a seam in `W` across which `c` changes, every point of the seam has
  different nearest off-`Γ` colours on its two sides, so it is a G-change point and not a colour change (and the count is infinite). (f)
  survives under G (with no seam in `W`, every point of `Γ ∩ ω(p) ∩ W` is isolated or an end of an edge that meets `W` only at an excluded end,
  and nearest off-`Γ` colours are the adjacent ones). A G-counterexample needs a qualifying-window fragment, from which § 3.3's slit would then build one, so
  under G the clause is equivalent to "no qualifying window with room for a seam"; the author's reading is L.
  (3) *Reading an arc of `Γ` as a circular arc through vertices* — (c) is then not derived beyond `Ŵ` (§ 3.1 (c)).
  (4) *Drop "and `σ(W)`"* (only `W` disjoint from `D`): (a) and (b) lose V2-L3's partner germ inside the window, and nothing I hold forces four
  colours or the alternation; no model either way.
  (5) *`k ≥ 7`* — (a), (b), (d) fail (three absent colours), as the not-claimed line says (R7).
- **Smallest cases.** A window whose closed end is a colour change: handled by `D`'s closedness (the extension `Ŵ`). A window containing a
  tangency of an edge with `ω(p)` (as at the strip's `P_{±2}`): an isolated point of `Γ ∩ ω(p)`; a change point iff the colours differ.

### 3.3 FS116-N1-TWIST-LIT, derived (under reading L, and under G)

The class is RING-TWIST's (§ 5: radius above 2, Siamese pairs allowed, any degree; simplicity not required).

**If.** If no fragment of the class has a qualifying window, the parity clause has no instance: it holds vacuously.

**Only if**, by the contrapositive. Let `F` be a fragment of the class with a qualifying window `W`. If the number of change points in `W` is
not odd, `F` itself violates the clause. Otherwise let `z ∈ W` be a change point (reading L: ring off `Γ` on both sides near `z`, colours
`c(z⁻) ≠ c(z⁺)`), and `T` the tile holding the ring just clockwise of `z`. Choose `η > 0` so small that the ring arc `J = e([θ_z − η, θ_z])`
meets `Γ` only at `z`, lies in `T` but for `z`, lies in the extended window `Ŵ`, and — if `z` is not `W`'s closed end — has `θ_z − η` in `W`.
Let `F′` be `F` with `Γ′ = Γ ∪ J` (a **slit**: an arc of the unit circle about `p`, admitted by the definition of `Γ` in § 0, which asks only
for a locally finite union of arcs).

- `T ∖ J` is connected (an arc attached to `∂T` at one end does not separate `T`), so the tiles of `F′` are those of `F` with `T` replaced by
  `T ∖ J`, same colours, same closures. The interior points of each colour are a subset of `F`'s: **`F′` is valid**, on the same disc, with the
  same `p`, the same colours at `p`, the same Siamese pairs (none new), the same degree at `p`.
- `D′ = D` (closures and colours unchanged), so `W` is still a qualifying window.
- Under reading L, `z` is now an end of an arc of `Γ′` on `ω(p)`, so not a change point; `e(θ_z − η)` is the other end, not a change point;
  nothing else near the ring changes. **`W` holds one change point fewer: an even number.** So `F′` violates the clause.

Under reading G the same slit makes every point of `J` a change point (nearest off-`Γ′` colours `c(z⁻)` and `c(z⁺)` on its two sides): infinitely
many, not an odd number. So the equivalence holds under both readings. ∎

**What the construction keeps, beyond the statement.** `F′` is non-Siamese whenever `F` is: the "only if" holds inside the non-Siamese part of the
class too — **it is simplicity, not non-Siamese, that RING-TWIST-C's parity clause needs** (the slit tile meets itself along `J`). With Siamese
pairs one can instead cut off a sliver of `T` along `J` as a second tile of `T`'s colour (a seam between two tiles); every version I tried
breaks simplicity somewhere (the sliver's cut meets the neighbour across the edge through `z` in two pieces, or pinches `T` at `z`), so I claim
nothing for the simple class with Siamese pairs.

### 3.4 Attack on FS116-N1-TWIST-LIT

- **Where it could fail.** Only if the class forbade the modification. The class does not require simplicity (RING-TWIST-C's own "in particular
  in every non-Siamese simple fragment" presumes non-simple members), and § 0's `Γ` admits a slit. If the class were the non-Siamese simple
  class, the "only if" would be false whenever that class had a qualifying window (RING-TWIST-C (f) makes the clause true there) — the
  not-claimed line says as much.
- **Is it a thin truth?** It is an equivalence between a clause and the emptiness of its own hypothesis — it carries no geometry, and says that
  RING-TWIST's parity clause, as posed on the wide class, is exactly as strong as "no qualifying window exists", which is open. Its content is
  the correction it motivates (RING-TWIST-C's "when no such arc meets W"); § 3.3 sharpens it to the non-Siamese class.
- **Degenerate case.** A qualifying window whose only change point is its closed end `θ₀`: the slit runs clockwise from `θ₀` out of `W` into
  `Ŵ ∖ W`, still `D`-free; `θ₀` stops being a change point and no new one appears in `W`. Covered.

### 3.5 Theorems this stage proved

- **RING-TWIST-C**, as stated, under reading L and Q2's edge reading — [hand; one derivation here, blind to the round-1 argument]. § 3.1.
- **FS116-N1-TWIST-LIT**, as stated, under reading L and under reading G — [hand; one derivation here]. § 3.3.
- **V2-TL-NS**: the "only if" of FS116-N1-TWIST-LIT holds inside the non-Siamese fragments of RING-TWIST's class (the slit keeps non-Siamese) —
  [hand, one mind]. § 3.3.
- **V2-STRIP-D**: on the strip's ring of `P₀`, `D` is four (Q) arcs and two points and every `D`-free arc is at most 60° — [computed over: the
  strip's ring, `tools/fs116_v2_strip.py --D`].

### 3.6 Would have searched here

- A search for a fragment with a qualifying window (a model for RING-TWIST-C's window clauses): out under the ban and not attempted; the
  clauses are verdicted as the conditionals they are.


verification: RING-GERM
  statement: in a non-Siamese valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, let y be a change point of the ring, X the colour of the ring just counter-clockwise of y and X̄ the colour just clockwise, and u⁻, u⁺, v⁻, v⁺ the arcs of ω(p) just clockwise and just counter-clockwise of the ring points y + 60° and y − 60°; then p has four colours and no more, X and X̄ are the colours absent at p, and (i) if neither v⁻ nor u⁺ lies on a (Q) arc, every direction at y in the open cone of 60° about the direction to p lies in the cone of a tile of p; (ii) if neither u⁻ nor v⁺ lies on a (Q) arc, every direction at y in the open cone of 60° about the direction away from p lies in the cone of a tile of a colour of p that is not a tile of p; (iii) if none of the four lies on a (Q) arc, y is a vertex of at least four colours
  given: the statement and its not-claimed line; the claim list with N7-HUB's one-line sketch (§ 8) and FS114-derivation.md § 3's entries,
    Y4-UPDOWN's statement among them; one definition sentence of the round-1 record, quoted by the coordinator (§ 1.3); not the round-1 argument
  committed: 2026-09-29 — the stage-2 commit (subject "FS116-V2: stage 2")
  predicted: derived — 0.85 — likeliest break: y at an end of an arc of Γ on ω(p) (reading G)
  verdict: derived
  method: germ calculus on the ring — the 60° rule on germs (V2-L3) and the two sides of a unit circle (V2-L4) at y ± 60°, each absent colour
    killed by one (Q)-free germ; the round-1 route is unread until stage 4
  attack: § 2.3 Attack on RING-GERM
  divergences: none — the comparison with the round-1 derivation opens at stage 4, after all three verdicts are committed
  counterexamples: monster: the strip's apex (1/4, √15/4) on the ring of P₀, a change point only under reading G, where (ii) and (iii) fail —
    local at (R1), which needs y's own germs off Γ; reading L, the author's, excludes it; thin truth: (0a), (0b) and (ii) in any valid fragment
    with Siamese pairs — non-Siamese is spent only in (i)'s last step and (iii)
  minds: 2 — blind to: the round-1 argument (fenced until this commit); method: the same model, a route of its own, compared at stage 4
  grade: hand

control: strip-listing
  of: RING-GERM — the model's rebuild: the strip by formula against every vertex sector of FS112-YB's exact listing
  run: python3 ../tools/fs116_v2_strip.py --listing
  expect: listing: vertices compared 15, sectors compared 48, disagreements 0
  fault: python3 ../tools/fs116_v2_strip.py --listing --plant

control: strip-ring-germ
  of: RING-GERM — every change point of the strip's ring of P₀ under reading L (no violation; (i) fails where its hypothesis fails) and under
    reading G (the monster)
  run: python3 ../tools/fs116_v2_strip.py --summary
  expect: P_0: colours BMOP, tiles ['D-1', 'D0', 'U-1', 'U0']; ring breakpoints 10
    L: change points 2, (0a) 2, (0b) 2, hypotheses (i) 0 (ii) 2 (iii) 0, violations 0 at [], (i) failing where its hypothesis fails 2
    G: change points 14, (0a) 14, (0b) 14, hypotheses (i) 12 (ii) 10 (iii) 8, violations 12 at [67.8, 75.5, 104.5, 112.2, 247.8, 255.5, 284.5,
    292.2], (i) failing where its hypothesis fails 2
  fault: python3 ../tools/fs116_v2_strip.py --summary --cw

verification: RING-TWIST-C
  statement: at a vertex p of at least four colours of a valid fragment on a closed disc of radius above 1 about p (Siamese pairs allowed, any degree), the set D of points of ω(p) in the closure of a tile of one of p's colours is closed and lies in the union of the arcs of Γ on ω(p) and finitely many points; and for every half-open 60° window W of ω(p) with W ∪ σ(W) disjoint from D: p has four colours and no more; off a finite set, every point of W ∪ σ(W) lies in the closures of tiles of a single colour, one of the two colours absent at p, and this colour differs at θ and at θ + 60° for θ in W; every arc of Γ on ω(p) meeting W ∪ σ(W) in an arc has one colour on both sides; W holds an odd number of colour changes — points of W at which that colour differs on the two sides — each lying in the closures of tiles of the two absent colours and of no other colour; every change point in W is a colour change, and a colour change in W that is not a change point lies on an arc of Γ on ω(p) with one colour on both sides; so W holds an odd number of change points when no such arc meets W, in particular in every non-Siamese simple fragment
  given: the statement and its not-claimed line; the claim list with RING-TWIST (§ 5) and FS114-derivation.md § 3's entries, N3-ODD's
    statement among them; one definition sentence of the round-1 record, quoted by the coordinator (§ 1.3); not the round-1 argument
  committed: 2026-09-29 — the stage-3 commit (subject "FS116-V2: stage 3")
  predicted: derived — 0.80 — likeliest break: an arc of Γ on ω(p) running past W ∪ σ(W) into D; reading G of change point
  verdict: derived
  method: germ calculus on the ring — the 60° rule on germs (V2-L3) over the window extended past its closed end by D's closedness, then a
    two-colour flip count; the round-1 route is unread until stage 4
  attack: § 3.2 Attack on RING-TWIST-C
  divergences: none — the comparison with the round-1 derivation opens at stage 4, after all three verdicts are committed
  counterexamples: none — the strip's ring of P₀ read exactly for the first clause (D closed, four (Q) arcs and two points; no qualifying
    window, every D-free arc at most 60°); no held fragment has a qualifying window, so the window clauses were attacked by readings and by
    removing hypotheses (§ 3.2), not by objects; under reading G (not the author's) the clause "every change point in W is a colour change"
    fails on any seam in a qualifying window, and under a through-vertex reading of "arc of Γ" the seam clause is not derived beyond the window
  minds: 2 — blind to: the round-1 argument (fenced until this commit); method: the same model, a route of its own, compared at stage 4
  grade: hand

control: strip-D
  of: RING-TWIST-C — its first clause on the strip's ring of P₀, and the not-claimed line's "the strip's … D-free arcs are at most 60°"
  run: python3 ../tools/fs116_v2_strip.py --D
  expect: D: arcs 4 (total 62.09 deg), isolated points 2 at [0.0, 180.0]; D-free arcs 6, longest 60.00 deg; qualifying window: none
  fault: python3 ../tools/fs116_v2_strip.py --D --plant

verification: FS116-N1-TWIST-LIT
  statement: RING-TWIST's parity clause as posed — every half-open 60° window W of ω(p) with W ∪ σ(W) disjoint from D holds an odd number of change points — holds on every fragment of RING-TWIST's class if and only if no fragment of that class has a half-open 60° window W with W ∪ σ(W) disjoint from D
  given: the statement and its not-claimed line; the claim list, with RING-TWIST (§ 5) and RING-TWIST-C's not-claimed line ("the parity of
    change points when a seam meets W … then it can fail"); one definition sentence of the round-1 record (§ 1.3); not the round-1 argument
  committed: 2026-09-29 — the stage-3 commit (subject "FS116-V2: stage 3")
  predicted: derived — 0.90 — likeliest break: whether a seam laid on the ring keeps the fragment in the class
  verdict: derived
  method: the "if" is vacuous; the "only if" lays a slit — an arc of ω(p) inside one tile, ending at a change point — which removes one change
    point and keeps the fragment valid, non-Siamese if it was, and its window qualifying; the round-1 route is unread until stage 4
  attack: § 3.4 Attack on FS116-N1-TWIST-LIT
  divergences: none — the comparison with the round-1 derivation opens at stage 4, after all three verdicts are committed
  counterexamples: none — the class was read for what could stop the slit (simplicity is not required, § 0's Γ admits it); under reading G the
    slit breaks the clause too (infinitely many change points)
  minds: 2 — blind to: the round-1 argument (fenced until this commit); method: the same model, a route of its own, compared at stage 4
  grade: hand

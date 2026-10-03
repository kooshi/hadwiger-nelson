# FS116-V4 — a blind second mind on FS116-S1-KAPPA, FS116-S1-RUNG and FS116-S1-QF

*Job FS116-V4 (Ephodos, verification form), brief `data/fs116/briefs/FS116-V4-verify.md` with its Amendment 1. Opened 2026-10-03 15:13 UTC.
Blind, the same model (Opus 5.5) as the minds whose records stage 4 opens. The brief first listed six statements. **The coordinator withdrew
FS116-Y3-NBTIP, FS116-Y3-TIGHTLENS and FS116-Y3-STARFORCE from this job (Amendment 1, 15:14 UTC)**, because they were frozen without the
setting they are stated in (FS116-Y3-TIPS and its labels). They were withdrawn, not left undone.*

## Theorems this phase proved

All at [hand], each one mind here (this job's), with the three statements' minds as their verification blocks count them:
- **FS116-S1-KAPPA**, re-derived as ruled (reading B, κ's change points), Siamese pairs allowed but for the last clause (§ 2.2).
- **FS116-S1-RUNG**, re-derived with Siamese pairs allowed. Its main clause holds for any saturated segment edge from any point (§ 2.3; a thin
  truth).
- **FS116-S1-QF**, re-derived (§ 2.4). Saturation is needed only on `p`'s four edges.
- The lemmas, each an entry above: V4-CHORD, V4-DICHOTOMY, V4-MEET, V4-TWIST, V4-PARTNER, V4-OUTER.

## Fence log

No fenced path read, listed or searched, as of stage 1. Every file read so far: the brief, `plans/STANDING-RULES.md`,
`data/fs116/claims.md`, `data/fs114/claims.md`, `plans/FS114-derivation.md` § 3 (statements and fields, with every `argument:` line filtered out
before display), the gate script `.claude/skills/ephodos/scripts/derive_gate.py` and its `example-verification.md`. Searched with `grep` on
`CLAUDE.md`, `LEDGER.md`, the grokkings, `data/fs114/claims.md` and `plans/FS114-derivation.md` for "TIPS", "HEX3", "STRIPCEIL", "S1-LENS", "NBTIP",
"STARFORCE", "TIGHTLENS": no hits.

## "Would have searched here" log

None yet. No program enumerates anything in this job. The checks are exact evaluations of named quantities (stage 2's controls).

## Stage 1 — SAVED (2026-10-03 15:33 UTC)

### 1.1 The readback

Each of the six statements in the brief's § The statements was compared character for character with its line in `data/fs116/claims.md` § 12,
by a short script that matched the line beginning "- **<name>**". **All six match.** The three statements of this job, as the list holds them:

> - **FS116-S1-KAPPA** *(proposed at round 3)*: at a vertex p of four colours and no more of a valid fragment on a closed disc of radius above 1 about p, Siamese pairs allowed, whose ring carries no (Q) arc, every germ of ω(p) (an arc just clockwise or just counter-clockwise of a ring point) lies in the closure of tiles of exactly one colour absent at p, κ, and the germ 60° on carries the other; so κ's change points form a finite non-empty set invariant under the rotation by 60° about p, each half-open 60° window of ω(p) holds an odd number of them, and antipodal germs carry different colours; in a non-Siamese fragment the change points are exactly y + 60°ℤ for one ring point y *Not claimed:* anything when the ring carries a (Q) arc; anything at k ≥ 7 (at k = 9 SQ9's r(45°) and r(225°) carry one colour); that any vertex of the class exists at six colours
> — `data/fs116/claims.md` § 12

> - **FS116-S1-RUNG** *(proposed at round 3)*: let p be a degree-4 vertex of four colours of a valid fragment whose four edges are segments along the four half-axes, with tiles coloured c_I, c_II, c_III, c_IV by quadrant, and suppose the fragment saturated at every point of the east edge's first segment [p, p + (ℓ, 0)], 0 < ℓ ≤ L_E; if a tile of colour c_IV has a point w in its closure with |w − q_N| < 1, q_N = p + (0, 1), then |w − p − (s, 1)| ≤ 1 for every s in [0, ℓ]; and the same at each edge and axis point, turned and reflected with the quadrants; in particular a contact of c_IV at r(φ), 90° < φ < 150°, gives ℓ ≤ cos φ + √(sin φ (2 − sin φ)), which at φ = 120° is FS116-Y1-STRIPCEIL's x* = √(√3 − 3/4) − 1/2 *Not claimed:* anything at a partner point where the edge is not saturated; anything for edges that are not segments; that a contact exists in quadrant II in any fragment of SAT-STRIP's class (FS116-S1-LENS supplies one where the ring carries no (Q) arc)
> — `data/fs116/claims.md` § 12

> - **FS116-S1-QF** *(proposed at round 3)*: no non-Siamese valid fragment on B̄(p, 2), saturated on B̄(p, 1), whose ring ω(p) carries no (Q) arc, has at p a degree-4 vertex of four colours whose four edges are segments at right angles *Not claimed:* SAT-STRIP itself (rings with (Q) arcs, Siamese fragments, crosses not at right angles stay open: § 2.5's G1–G3); anything at k ≥ 7 (at k = 9 SQ9 meets every other hypothesis); that the class is non-empty at six colours without the cross
> — `data/fs116/claims.md` § 12

**Terms the statements use, and where they are fixed.** Valid fragment, (Q), tiles, Γ, ring, change point, Siamese, saturated: the list's § 0,
quoted there. "Change point" is read as the brief directs (§ 10's reading: the ring off Γ on both sides). Three terms are the statements' own and
are read as written: a *germ* (KAPPA's parenthesis), *κ's change points* (points of ω(p) where κ differs on the two germs), and a *contact of
c_IV at r(φ)* (RUNG: read as "r(φ) lies in the closure of a tile of colour c_IV", the only reading under which its "in particular" follows from its
main clause). `r(φ)` is `p + (cos φ, sin φ)`; `L_E` is read as the length of the east edge's first segment. Two names inside the statements
are not on the list and are not needed: FS116-Y1-STRIPCEIL's x* (RUNG gives it by formula, which is what is checked) and FS116-S1-LENS (in a
*not claimed* line).

**Questions sent to the coordinator** (by message, between 15:15 and 15:33 UTC; the exact minutes were not logged):
1. *(about the withdrawn statements)* FS116-Y3-TIPS's setting and labels: answered by Amendment 1, which withdrew the three statements.
2. *(KAPPA, two wording points)*: (a) does "lies in the closure of tiles of exactly one colour absent at p" mean
   exactly one of the two absent colours has a tile whose closure holds the germ (reading B), or that the germ lies in the closures of tiles of
   one colour in all, an absent one (reading A)? (b) In the last clause, are "the change points" κ's change points or § 10's ring change points?
   **Answered by the coordinator (received about 15:37 UTC), from the author's record's definitions, verbatim, with nothing of its argument:**
   (a) "Let `K(g)` be the set of absent colours among the colours of the tiles whose closure holds the whole germ `g`." and "A **germ** of `ω(p)`
   at `θ` is the arc `(θ, θ + δ)` or `(θ − δ, θ)` of `ω(p)` for small `δ`" — that is reading B; (b) "A change point is a `θ` with `κ(θ^−) ≠ κ(θ^+)`."
   — and the coordinator's ruling, labelled as an inference of its own, that the last clause's "the change points" are κ's, superseding within
   KAPPA the brief's pointer to § 10. These definitions are added to the `given:` line below; they arrived after stage 1's predictions were
   written and before any verdict.

### 1.2 What this mind was given (the `given:` line, in full)

Before any verdict: the three statements and their *not claimed* lines (the brief and the list's § 12); the list's §§ 0–11 in full, which hold
earlier statements of the same programme, among them FS116-N1-AXIS (a lemma QF and RUNG plainly build on: "(b) a tile of colour c_IV approaches q_N
along 0⁺ and one of colour c_III along 180⁻, both above the line y = 1"), FS116-O1-SATPIN (the tangent type: "x + ν(x) in the closure of colour a and
x − ν(x) in the closure of colour b"), RING-TWIST-C and RING-GERM; `data/fs114/claims.md`; the statements of `plans/FS114-derivation.md` § 3,
among them FS114-N6-NOQ's N6-RING60 ("a four-colour vertex whose ring carries no (Q) arc has ring change points exactly y + 60°ℤ, six ring tiles
alternating the absent colours") and FS114-N7-3T's N7-HUB. **These were read as statements, with no argument and no verdict on any of the three,
and they are informed priors:** N6-RING60 is close to KAPPA's last clause, AXIS (b) to RUNG's setting, and SATPIN's tangent type to the rung itself.
The brief said the three are round 3's "two strongest partial results" and that "SAT-STRIP decided in one class (the last statement of the first
three below, with two lemmas it rests on)". That sentence carries the author's verdict on QF ("decided"), and it tells me that KAPPA and RUNG are
the lemmas QF rests on. So on QF I am blind to the argument and **not** blind to the author's verdict. No sketch, route or record of the author's
was seen.

### 1.3 The registered expectations

*Written at 15:33 UTC, after about twenty minutes of thinking about the statements (the setting, the twist at 60°, the partner of an edge point).
So these are informed predictions, not naive ones. They come before any derivation is written down, but not before I had thought about routes.
The commit order shows they come before the stage 2 derivation.*

| statement | predicted verdict | probability | likeliest break |
|---|---|---|---|
| KAPPA | derived | 0.70 | the wording, not the mathematics: "exactly one colour absent at p" read as "of one colour in all" fails at an arc of Γ on ω(p) with one of p's colours on one side; and "the change points" read as § 10's ring change points fails where a κ change point ends an arc of Γ on ω(p). The parity and the twist themselves I expect to hold with Siamese pairs allowed |
| RUNG | derived | 0.75 | the Siamese case. The statement does not assume non-Siamese, so the colour-c_IV tiles along the line y = 1 may be several tiles. Then w's tile need not be any of them, and "≤ 1" could fail between w and a far rung point |
| QF | derived | 0.60 | the step from "a change point in each open 60° arc beside an axis point" to "its outer tile is the rung tile at that axis point". It needs the axis point not to be a change point, and it needs the outer colour to be forced. A ring arc of Γ with one of p's colours on a side, or a non-simple tile, might let the outer colour escape. The second break is the final topological step |

### 1.4 The one relay-lemma every later step uses

derivation: V4-CHORD
  statement: two points r(α), r(β) of a unit circle about p, at angular separation δ = |α − β| ∈ [0°, 180°], are at distance 2 sin(δ/2); so
    the distance is 1 at δ = 60°, below 1 for δ < 60° and above 1 for 60° < δ ≤ 180°; and for β > α the chord from r(α) to r(β)
    points in the direction (α + β)/2 + 90°
  uses only: the law of cosines on the isosceles triangle p, r(α), r(β)
  not claimed: anything about circles of other radii
  argument: § 1.4 argument
  verdict: derived
  grade: hand
  minds: 1
  model: α = 0°, β = 60° — r(0°) = (1, 0), r(60°) = (1/2, √3/2), distance 1
  prior art: known — elementary
  handoff: none — a relay-result for stage 2

control: v4-chord
  of: V4-CHORD — the chord is 1 at 60°, below 1 at 59°, above 1 at 61°, checked in exact arithmetic (sympy)
  run: python3 -c "import sympy as s;d=lambda a,b:s.sqrt((s.cos(a)-s.cos(b))**2+(s.sin(a)-s.sin(b))**2);r=s.pi/180;print(s.nsimplify(s.simplify(d(0,60*r)))==1, bool(d(0,59*r)<1), bool(d(0,61*r)>1))"
  expect: True True True
  fault: python3 -c "import sympy as s;d=lambda a,b:s.sqrt((s.cos(a)-s.cos(b))**2+(s.sin(a)-s.sin(b))**2);r=s.pi/180;print(s.nsimplify(s.simplify(d(0,90*r)))==1, bool(d(0,59*r)<1), bool(d(0,61*r)>1))"

## 1.4 argument

|r(α) − r(β)|² = 1 + 1 − 2 cos δ = 4 sin²(δ/2). On [0°, 180°], sin(δ/2) increases, and 2 sin 30° = 1. The midpoint of the chord lies in the
direction (α + β)/2 from p, and the chord is perpendicular to that direction, pointing ccw (+90°) when going from the smaller angle to the larger.

## Stage 2 — SAVED (2026-10-03, written from 15:43 UTC)

*KAPPA, RUNG and QF: derivation, attack, verdicts. Each was derived from its statement alone, by a route of my own, before any record
of the first derivation was opened. My route for all three rests on four small lemmas, filed first as entries.*

### 2.0 Conventions

`p = 0`, `r(θ) = (cos θ, sin θ)`, `ω = ω(p)`, `σ` the rotation by 60° about `p`. A *c-tile* is a tile of colour `c`. Tiles are open and
connected, `Γ` is null, and the map is locally finite. For a germ `g` (an arc `(θ, θ + δ)` or `(θ − δ, θ)` of `ω`, `δ` small), `K(g)` is the
set of absent colours among the colours of the tiles whose closure holds the whole of `g` (the author's definition, § 1.1). For small `δ`
a germ either misses `Γ` or lies inside one arc of `Γ` on `ω`, because `Γ ∩ ω` is a finite set of points together with finitely many arcs.
**Siamese** is read as § 0 quotes de Grey: two distinct tiles of one colour that lie inside each other's exclusion zone, which by V4-DICHOTOMY
below means every distance between them is below 1. In a non-Siamese fragment, distinct tiles of one colour are therefore at distance above
1 everywhere. **Saturated at `x`** is read as: for each colour `j` of `x`'s essential multicolour, some point of `supp j` (the closure of the
union of the j-tiles) lies at distance exactly 1 from `x`. This is the only reading under which an edge point can be saturated, since `x` itself
lies in the support of both its side colours, so "the distance from `x` to `supp j` is 1" is impossible for those colours.

derivation: V4-DICHOTOMY
  statement: in a valid k-coloured fragment, for tiles A, B of one colour (A = B allowed), either every point of A is at distance below 1 from
    every point of B (write A ~ B) or every point of A is at distance above 1 from every point of B (A ⊥ B); A ~ A, so the closure of a tile has
    diameter at most 1; if points z ∈ cl A, z′ ∈ cl B have |z − z′| < 1 then A ~ B, and if |z − z′| > 1 then A ⊥ B; in a non-Siamese fragment
    A ~ B forces A = B
  uses only: that A × B is connected and the distance is continuous on it
  not claimed: anything for tiles of different colours
  argument: § 2.1 The four lemmas
  verdict: derived
  grade: hand
  minds: 1
  model: FS111-W-SQ9 (k = 9, squares of side 1/2): two squares of one colour three squares apart are at distance above 1 throughout
  prior art: owed — elementary; no search run by this job
  handoff: none — a relay-result for KAPPA, RUNG and QF

derivation: V4-MEET
  statement: if tiles A, B of one colour have a common closure point z, then for every tile T of that colour, T ~ A holds if and only if T ~ B
  uses only: V4-DICHOTOMY, and that an open set is not contained in a circle
  not claimed: anything when cl A and cl B are disjoint
  converse: § 2.1 The four lemmas
  argument: § 2.1 The four lemmas
  verdict: derived
  grade: hand
  minds: 1
  model: two adjacent squares of one colour in a periodic colouring (Siamese), and any third square of that colour
  prior art: owed — elementary; no search run by this job
  handoff: none — RUNG's Siamese case rests on it

derivation: V4-TWIST
  statement: at a point p of a valid k-coloured fragment on a disc of radius above 1 about p, for any k, Siamese pairs allowed, no colour has a
    tile whose closure holds a germ g of ω(p) and a tile (the same or another) whose closure holds σg or σ⁻¹g; and a point of ω(p) inside a
    tile has that tile's colour absent at p when p is a vertex
  uses only: V4-DICHOTOMY, V4-CHORD
  not claimed: anything about germs lying on Γ with the colour on neither side
  argument: § 2.1 The four lemmas
  verdict: derived
  grade: hand
  minds: 1
  model: FS111-W-SQ9 at p = (0, 0): the germ of ω just counter-clockwise of r(0°) lies in square (1, 0), colour (1, 0), and the germ just
    counter-clockwise of r(60°) in square (1, 1), colour (1, 1) — different, as the lemma requires
  prior art: owed — no search run by this job; the list's RING-TWIST-C (§ 10) states a relative of it
  handoff: none — KAPPA rests on it

derivation: V4-PARTNER
  statement: let x be an interior point of a segment edge of a valid k-coloured fragment from a point p, of direction u and first-segment
    length L, with tile T_a on its clockwise side and T_b on its counter-clockwise side, and ν = u turned by +90°; if the fragment is
    saturated at x, then x + ν lies in the closure of a tile of T_a's colour and x − ν in the closure of a tile of T_b's colour, and every
    tile of T_a's colour other than T_a whose closure meets ω(x) is far from T_a (⊥)
  uses only: V4-DICHOTOMY, the half-discs of T_a and T_b at x, and T_a, T_b running along the whole open segment
  not claimed: anything when the edge is curved; anything at p itself or at the segment's far end (closure gives those points of supp only)
  argument: § 2.3 Derivation of RUNG
  verdict: derived
  grade: hand
  minds: 1
  model: FS111-W-SQ9's east edge at p = (0, 0): (s, 1 + 1/1000) carries c_IV = (0, 2) for 0 < s < 1/2 (control `v4-sq9rung`)
  prior art: owed — no search run by this job; the list's FS116-O1-SATPIN (§ 3) states the same as its tangent type
  handoff: none — RUNG and QF rest on it

### 2.1 The four lemmas

**V4-DICHOTOMY.** `A × B` is connected, and `(a, b) ↦ |a − b|` is continuous on it, so its image is an interval. The interval cannot contain 1,
because no two interior points of one colour are at distance 1. For `A = B` it contains values near 0, so it lies below 1. If `z ∈ cl A` and
`z′ ∈ cl B` have `|z − z′| < 1`, points of `A` near `z` and of `B` near `z′` are within distance below 1, so the interval lies below 1; the case `> 1`
is the same. A non-Siamese fragment has no distinct `A ~ B`, by the reading of Siamese in § 2.0.

**V4-MEET.** Suppose `T ~ A` but `T ⊥ B` (so `T ≠ B`). For `t ∈ T`, points `a_n ∈ A` tending to `z` give `|t − a_n| < 1`, so `|t − z| ≤ 1`.
Points `b_n ∈ B` tending to `z` give `|t − b_n| > 1`, so `|t − z| ≥ 1`. Then every point of the open set `T` lies on the circle `ω(z)`,
which is impossible. The converse direction is the same with `A` and `B` exchanged.

**V4-TWIST.** *First clause.* Let `g = (θ, θ + δ)`, and let the closures of the c-tiles `T` and `T″` hold `g` and `σg = (θ + 60°, θ + 60° + δ)`.
Take `z₁ = r(θ + δ/2) ∈ g`, `z₂ = r(θ + 60° + δ/4)` and `z₃ = r(θ + 60° + 3δ/4)` in `σg`. The separations are `60° − δ/4` and `60° + δ/4`, so
`|z₁ − z₂| < 1 < |z₁ − z₃|` (V4-CHORD). Points of `T` near `z₁` and of `T″` near `z₂`, `z₃` give distances on both sides of 1, against V4-DICHOTOMY.
The case `T = T″` is included. Clockwise germs and `σ⁻¹` are the same argument. *Second clause.* Let `z ∈ ω` lie in a tile `T`, with `B(z, ρ) ⊂ T`,
and let `T′` be a tile at `p` of `T`'s colour, with points `t_n → p`. Then `z ± (ρ/2) z` lie in `T`, and their distances to `t_n` tend to
`1 ± ρ/2`. These lie on both sides of 1, a contradiction.

**V4-PARTNER** is derived in § 2.3, where RUNG uses it.

### 2.2 Derivation of KAPPA

*Setting:* `p` a vertex of exactly four colours of a valid (six-coloured) fragment on a disc of radius above 1, Siamese pairs allowed, and no
(Q) arc on `ω`. So exactly two colours are absent at `p`; call them `X` and `X̄`.

**K1. Every germ has an absent colour: `K(g) ≠ ∅`.** If `g` misses `Γ`, it lies in one tile, whose colour is absent at `p` (V4-TWIST, second
clause). If `g` lies on an arc of `Γ` on `ω`, the tiles whose closures hold all of `g` are the arc's two side tiles. Suppose neither side colour
were absent. Then `p`, the arc's centre, carries both side colours (possibly one colour twice) and has four colours, so the arc is a (Q) arc.
That is excluded.

**K2. `|K(g)| = 1` and `K(σg)` is the other absent colour.** By V4-TWIST, `K(g) ∩ K(σg) = ∅`. Both are non-empty subsets of `{X, X̄}` (K1).
So each is a single colour, and the two colours differ. This is the first clause, with `κ(g)` the one element of `K(g)` (reading B, ruled by the
author's definition). The same holds for `σ⁻¹`.

**K3. κ's change points are finite.** Let `F` be the finite set of points of `ω` that are vertices of the map, isolated points of `Γ ∩ ω`, or
ends of arcs of `Γ` on `ω`. Off `F`, the two germs at a point belong to one tile, or lie on one arc of `Γ` with the same side tiles. So κ agrees
on them, and the change points lie in `F`.

**K4. Non-empty and σ-invariant.** At `θ`: `κ((θ + 60°)^±)` is the other of `κ(θ^±)` (K2). So `θ + 60°` is a change point exactly when `θ`
is. If there were no change point, κ would be constant around `ω`, against K2.

**K5. Odd in each half-open window, and different at antipodes.** Take `W = [ψ, ψ + 60°)`. Walking counter-clockwise from the germ `ψ^−` to the
germ `(ψ + 60°)^−`, κ flips exactly at the change points in `W`. The end value is the other of the start value (K2), so the number of flips is
odd. For `(ψ, ψ + 60°]`, walk from `ψ^+` to `(ψ + 60°)^+`. Antipodal germs are related by `σ³`, so κ flips three times, an odd number.
Control `v4-parity` checks this step's combinatorics over sampled labellings.

**K6. Non-Siamese: the change points are one σ-orbit.** The change-point set is σ-invariant, so it is a union of `m` orbits of six points each.
Each orbit puts exactly one point in each half-open 60° window, so a window holds `m` points and `m` is odd (K5). Suppose `m ≥ 3`. Then
there are three consecutive change points `c₁ < c₂ < c₃` with `c₃ − c₁ < 60°`. Let `a` be κ just clockwise of `c₁`. Then κ is `a` on
`J₀ = (c₁ − ε, c₁)`, the other colour `b` on `J₁ = (c₁, c₂)`, `a` on `J₂ = (c₂, c₃)`, and `a` on `σJ₁ = (c₁ + 60°, c₂ + 60°)` (K2).
- In a non-Siamese fragment, all a-tiles holding the germs of `J₂` are one tile, because any two points of `J₂` are under 60° apart (V4-DICHOTOMY,
  V4-CHORD). The same holds for `σJ₁`.
- Separations between `J₀` and `J₂` lie in `(c₂ − c₁, c₃ − c₁ + ε)`, below 60°. Separations between `J₂` and `σJ₁` lie in
  `(c₁ + 60° − c₃, 60°)`, below 60°. So one a-tile `A` holds `J₀`, `J₂` and `σJ₁`.
- Separations between `J₀` and `σJ₁` lie in `(60°, c₂ − c₁ + 60° + ε)`, above 60° and below 180°. So `A` has points at distance above 1,
  against V4-DICHOTOMY.
So `m = 1`, and κ's change points are `y + 60°ℤ` for one ring point `y` (control `v4-three` checks the interval arithmetic).

**The § 10 reading of the last clause** (not the ruled reading). A § 10 change point needs both germs off `Γ`, where the colour is κ. So the
§ 10 change points are the points of `y + 60°ℤ` with both germs off `Γ`. The clause in that reading holds exactly when no point of the orbit
lies on, or ends, an arc of `Γ` on `ω`. Whether a non-Siamese fragment of the class can have such an arc there is not decided here. That reading
is a GAP at that step, and on a ring that carries no arc of `Γ` the two readings agree.

### 2.3 Derivation of RUNG

*Setting:* `p = 0` with the east edge's first segment `[0, L_E] × {0}`, `T_I` above it and `T_IV` below, and saturation at every point of
`[p, p + (ℓ, 0)]`.

**R1 (V4-PARTNER at the east edge).** Let `x = (s, 0)` with `0 < s < ℓ`. At `x` both side tiles have density 1/2, so `c_IV` is in the essential
multicolour, and saturation gives a point `z ∈ ω(x)` in the closure of a c_IV-tile `T`. `T_IV` contains a half-disc
`H = {x + v : |v| < ρ, v₂ < 0}`.
- *If `z − x = e` has `e₁ ≠ 0`.* Take `v^± = (±τ sgn e₁, −η)` with `0 < η ≪ τ ≪ ρ`. Then `⟨v^±, e⟩ = ±τ|e₁| − ηe₂` has the sign `±`, so
  `|e − v^+| < 1 < |e − v^−|` for small `τ`. With `z_n ∈ T` near `z`, the pairs (`z_n`, `x + v^±`) give distances on both sides of 1, against
  V4-DICHOTOMY.
- *If `z = (s, −1)`.* `T_IV` contains `x + (0, −τ)`, at distance about `1 − τ` from `z`. It also contains points `(s′, −τ′)`, `s′ ≠ s` in
  `(0, L_E)`, `τ′` small, at distance about `√(1 + (s − s′)²) > 1`. Both sides of 1 again.
- So `z = (s, 1)`: every `(s, 1)` with `0 < s < ℓ` lies in `supp c_IV`, held by a c_IV-tile `T` with `T ⊥ T_IV` (`T` near `(s, 1)` against `T_IV`
  near `(s′, 0)` gives distances above 1). The support is closed, so the same holds at `s = 0` and `s = ℓ`.

The same argument with `T_I` places `c_I` at `(s, −1)`. For a general segment edge it reads as V4-PARTNER's statement, since nothing used the
other edges, the degree or the colour count.

**R2 (the main clause).** Let `Σ = [0, ℓ] × {1}`, and let `𝒯` be the c_IV-tiles whose closures meet `Σ`. By R1 and local finiteness, `𝒯` is
finite and `Σ ⊂ ⋃_{T∈𝒯} cl T`. The closed sets `cl T ∩ Σ` cover the connected `Σ`, so the graph on `𝒯` joining tiles whose closures meet on `Σ`
is connected. Let `T_w` be the c_IV-tile with `w ∈ cl T_w`, and `T₀ ∈ 𝒯` a tile with `q_N ∈ cl T₀`. Since `|w − q_N| < 1`, `T_w ~ T₀`
(V4-DICHOTOMY). By V4-MEET along the connected graph, `T_w ~ T` for every `T ∈ 𝒯`. For each `s`, `(s, 1) ∈ cl T` for some `T ∈ 𝒯`, so
`|w − (s, 1)| ≤ 1`. This holds with Siamese pairs allowed. In a non-Siamese fragment `𝒯` is one tile and V4-MEET is not needed.

**R3 (the "in particular").** Read "a contact of c_IV at r(φ)" as `r(φ) ∈ cl` of a c_IV-tile. For `90° < φ < 150°`,
`|r(φ) − q_N| = 2 sin((φ − 90°)/2) < 1` (V4-CHORD). R2 at `s = ℓ` gives `(cos φ − ℓ)² + (sin φ − 1)² ≤ 1`, that is
`(ℓ − cos φ)² ≤ sin φ (2 − sin φ)`, so `ℓ ≤ cos φ + √(sin φ (2 − sin φ))`. At `φ = 120°` this is `−1/2 + √(√3 − 3/4)` exactly (control
`v4-ceil`), the stated `x*`. Whether that is FS116-Y1-STRIPCEIL's `x*` was not checked, since that statement is not open to me. The formula is
what was checked.

**R4 (the rider: "the same at each edge and axis point").** R1 and R2 used only the east edge and the side tile whose colour is carried at
`x + ν`. Applied to each edge with its own `ν`, and to the other side's colour at `x − ν`, they give the turned and reflected statements. For
example, at `q_N` the west edge carries `c_III` along `[−ℓ_W, 0] × {1}`.

### 2.4 Derivation of QF

*Setting:* a non-Siamese valid fragment on `B̄(p, 2)`, saturated on `B̄(p, 1)`, with no (Q) arc on `ω`. Suppose, for contradiction, that `p`
is a degree-4 vertex of four colours whose four edges are segments at right angles. In coordinates, the edges run along the half-axes, with
first-segment lengths `L_E, L_N, L_W, L_S > 0`. The quadrant tiles are `T_I … T_IV`, of colours 1, 2, 3, 4, and 5, 6 are absent. Near `p`, each
quadrant tile contains the open quadrant sector, so each edge lies in the closure of its side tiles and has length at most 1
(V4-DICHOTOMY). The open edge segments therefore lie in `B(p, 1)`, where saturation holds.

**Q1 (rungs at `q_N`).** By R1 on the east edge, every `(s, 1)`, `0 < s < L_E`, is in the closure of a 4-tile. Non-Siamese: any two such points
are within distance below 1, so one tile `T4N` holds them all. The reflected R1 on the west edge (side tiles `T_II` above, `T_III` below) gives one
3-tile `T3N` holding `(−s, 1)`, `0 < s < L_W`. Both have `q_N` in their closures. Every 4-tile other than `T_IV` meets the strip
`(0, L_E) × (−1, 1]` nowhere, because it is far from `T_IV`, which contains `(X, −τ)` for small `τ`. So `T4N` lies above the segment
`(0, L_E) × {1}`, which is therefore in `Γ`. `T4N` has a sector at `q_N` bounded by the direction 0°. Likewise `T3N` has one bounded by the
direction 180°.

**Q2 (the ring, by KAPPA).** κ's change points are `C = y + 60°ℤ` (K6). The open arc between consecutive change points is held by one tile `R_k`
of colour `κ_k`, since its points are under 60° apart.

**Q3 (V4-OUTER: the outer colour at a change point).** Let `c = r(γ) ∈ C`, with `R_{k−1}` holding `(γ − 60°, γ)` and `R_k` holding `(γ, γ + 60°)`.
- (a) Every 5- or 6-tile with `c` in its closure is `R_{k−1}` or `R_k` (non-Siamese).
- (b) Neither contains a point `c + td`, `t > 0` small, with `d` within 30° of the outward direction `ĉ`. `R_{k−1}`'s closure holds
  `r(γ − 60°)`, and `c − r(γ − 60°)` is the unit vector `e(γ + 60°)` (V4-CHORD). The angle between `d` and `γ + 60°` is in `(30°, 90°)`, so
  `|c + td − r(γ − 60°)| > 1`, against the diameter. `R_k` is the same, with `r(γ + 60°)` and `e(γ − 60°)`.
- (c) No quadrant tile contains such a point either, since `|c + td| > 1` while `p` is in its closure.
- (d) So the tiles in the outward cone at `c` carry one of the colours 1–4 and are not tiles of `p`. Such a tile `K` of colour `j` is far from
  `T_j`, so `|x − te(θ)| > 1` for `x ∈ K` and every point `te(θ)` of `T_j`'s sector. Hence `K ⊂ {|x| > 1}`, and a closure point `x` of `K` on `ω`
  has `⟨x, e(θ)⟩ ≤ 0` for every `θ` in quadrant `j`.
- (e) For `γ` in an open quadrant, the only quadrant whose closed cone lies at least 90° from `γ` is the opposite one (control `v4-outer`).
  Non-Siamese makes the outward cone one tile `O_c`.
So for `c` in open quadrant I, `O_c` has colour 3; for `c` in open quadrant II, colour 4.

**Q4 (an axis point that is not a change point).** `90° ∈ C` iff `y ≡ 30°` and `0° ∈ C` iff `y ≡ 0° (mod 60°)`, which cannot both hold. The
hypotheses and the contradiction are unchanged by rotating the cross by 90° and relabelling the colours. So take `q_N ∉ C`. Then `C` has exactly
one point `c = r(γ)` in `(30°, 90°)` and exactly one `c′ = r(γ′)` in `(90°, 150°)`. If instead `q_E ∉ C`, the same argument runs at `q_E`, with the
north and south edges' rungs.

**Q5 (the outer tiles are the rung tiles, crossed).** `|c − q_N| < 1` and `|c′ − q_N| < 1` (V4-CHORD). So `O_c` (colour 3) is near `T3N`, and
`O_{c′}` (colour 4) is near `T4N`. Non-Siamese then gives `O_c = T3N` and `O_{c′} = T4N`. The 3-tile on the west rung reaches the change point
east of `q_N`, and the 4-tile on the east rung reaches the one west of it.

**Q6 (both live in a crescent).** By Q3 (d) and the diameter, `T3N, T4N ⊂ Λ = B(q_N, 1) ∖ B̄(p, 1)`.

**Q7 (they must cross).**
- Join `q_N` to `c` by a simple arc `α₃` whose interior lies in `T3N`. Its first piece runs from `q_N` inside `T3N`'s sector at 180°, meeting
  each small circle about `q_N` once. Its last piece is a segment in the outward cone at `c`. Join `q_N` to `c′` likewise by `α₄` in `T4N`,
  starting inside the sector at 0°.
- Let `ρ` be the closed arc of `ω` from `c` to `q_N` (angles `[γ, 90°]`). Then `J = α₃ ∪ ρ` is a Jordan curve, since `α₃` meets `ω` only at its
  ends.
- `J` lies in `{y > 0}` (`Λ` does, apart from `p ∉ J`). So the downward ray from `p` misses `J`, and the disc `B(p, 1)`, which misses `J`, lies
  outside it.
- Near `q_N`, `J` is two arcs, `ρ` leaving at direction 0⁻ and `α₃` leaving at about 180⁻. They cut a small disc about `q_N` into two pieces.
  The one through direction 270° meets `B(p, 1)`, so it lies outside `J`. The other, through the directions from 0⁺ round to `α₃`'s, lies inside
  `J`, because `q_N` is on the boundary of both sides.
- `α₄` starts in that inside piece, at direction 0⁺, and ends at `c′`. `c′` is on `ω` but not on `J`, and `B(p, 1)` is outside `J` next to it,
  so `c′` is outside `J`. So `α₄ ∖ {q_N}` meets `J`. But its interior lies in `T4N`, which misses `T3N ⊃ α₃°` and misses `ω ⊃ ρ`, and its end
  `c′` is not on `J`. **Contradiction.**

So no such fragment exists. Six colours are spent at Q2 (KAPPA's two absent colours) and at Q3 (a), (b): the two ring tiles are the only
absent-coloured tiles at `c`, so the outward cone must carry one of `p`'s colours.

derivation: V4-OUTER
  statement: in a non-Siamese valid fragment on a disc of radius above 1 about a degree-4 vertex p of four colours whose four edges are segments
    at right angles and whose ring carries no (Q) arc, at each of κ's change points c in an open quadrant, the directions within 30° of the
    outward direction at c lie in one tile, not a tile of p, of the colour of the quadrant tile opposite to c's quadrant
  uses only: KAPPA's K6 (as derived in § 2.2), V4-DICHOTOMY, V4-CHORD
  not claimed: anything at a change point on an axis; anything for crosses not at right angles (there the colour of the tile above the far edge
    can qualify as well: § Attack on QF)
  argument: § 2.4 Derivation of QF
  verdict: derived
  grade: hand
  minds: 1
  model: none at six colours — the class is the one QF empties; the step's arithmetic is checked on its own (control `v4-outer`)
  prior art: owed — no search run by this job; the list's RING-GERM (ii) (§ 10) states a relative of it
  handoff: none — QF rests on it

control: v4-parity
  of: V4-TWIST and KAPPA's K5 — on a ring cut into 6m germ slots, every labelling with label(i + m) = 1 − label(i) has an odd number of
    changes in every half-open window; the count of windows with an even count, over 2,000 sampled labellings
  run: python3 ../tools/fs116_v4_checks.py parity
  expect: 0
  fault: python3 ../tools/fs116_v4_checks.py parity --plant

control: v4-three
  of: KAPPA's K6 — the separations of J₀, J₂ and σJ₁ on a rational grid of c₁ < c₂ < c₃ with c₃ − c₁ < 60°; violations counted
  run: python3 ../tools/fs116_v4_checks.py three
  expect: 0
  fault: python3 ../tools/fs116_v4_checks.py three --plant

control: v4-sq9anti
  of: KAPPA's not claimed line — in FS111-W-SQ9 (k = 9) the ring points r(45°) and r(225°) carry one colour
  run: python3 ../tools/fs116_v4_checks.py sq9anti
  expect: True
  fault: python3 ../tools/fs116_v4_checks.py sq9anti --plant

control: v4-sq9rung
  of: V4-PARTNER on an inhabitant — in FS111-W-SQ9 the points (s, 1 + 1/1000), 0 < s < 1/2, carry c_IV, the colour below the east edge at p = 0
  run: python3 ../tools/fs116_v4_checks.py sq9rung
  expect: True
  fault: python3 ../tools/fs116_v4_checks.py sq9rung --plant

control: v4-ceil
  of: RUNG's "in particular" — cos 120° + √(sin 120° (2 − sin 120°)) = √(√3 − 3/4) − 1/2, exactly (sympy)
  run: python3 ../tools/fs116_v4_checks.py ceil
  expect: True
  fault: python3 ../tools/fs116_v4_checks.py ceil --plant

control: v4-outer
  of: V4-OUTER's step (e) — for ring directions g off the axes, on a half-degree grid, the only quadrant whose closed cone lies at least 90° from g
    is the opposite one; failures counted
  run: python3 ../tools/fs116_v4_checks.py outer
  expect: 0
  fault: python3 ../tools/fs116_v4_checks.py outer --plant

## Attack on KAPPA

Each attempt is listed cheapest first, with what it showed.
1. **Five colours at `p`.** Then one colour is absent. K1 and V4-TWIST would give two disjoint non-empty subsets of a one-colour set, which is
   impossible. So at six colours, no five-colour vertex has a (Q)-free ring on a disc of radius above 1. This is consistent with the held
   FS112-SIX ("A vertex with five colours has unit arcs centred at it of total length at least 180°"); those arcs cannot all avoid (Q). Not a
   counterexample: "four colours and no more" is a hypothesis, and it is used.
2. **Drop "no (Q) arc".** A germ on a (Q) arc may have `K(g) = ∅` (both sides `p`'s colours), and K1 fails there. The capped strip's midline
   vertices, whose rings carry four (Q) arcs (§ 0), are the control. The hypothesis is used, at K1 only.
3. **Drop six colours.** At `k ≥ 7`, V4-TWIST still makes `K(g)` and `K(σg)` disjoint, but with three or more absent colours they need not be
   complementary. At `k = 9`, FS111-W-SQ9's `r(45°)` and `r(225°)` carry one colour (control `v4-sq9anti`), so the antipode clause fails, as the
   *not claimed* line says. Six colours are spent at K2.
4. **Closed windows (where the attack succeeds).** The parity clause fails for closed 60° windows. With `m = 1`, the window `[y, y + 60°]` holds
   two change points. Control `v4-parity --plant` finds 37,380 even closed windows. "Half-open" is exactly what K5 needs.
5. **The non-Siamese clause with Siamese pairs allowed.** My K6 uses non-Siamese twice (one tile per arc of κ, and `J₀`, `J₂`, `σJ₁` held by one
   tile). With a Siamese pair, `A₀ ~ A₂` may be distinct, and the diameter contradiction is gone. So the nearest statement left open is "the
   change points are one orbit, Siamese pairs allowed". KAPPA does not claim it. Whether some Siamese fragment of the class has three orbits is
   not decided here, since no object was constructed.
6. **Reading A of the first clause** (now ruled out by the author's definition). It would assert that no tile of `p`'s colours holds a germ.
   Nothing in K1–K6 gives that, and an arc of `Γ` on `ω` with one of `p`'s colours on one side (for instance a tile at `p` bounded by a 60° arc
   of `ω`) is not excluded by any step. It is a wording point, settled by the definition of `K(g)`.
7. **The § 10 reading of the last clause.** It is a GAP at "no point of the orbit ends an arc of `Γ` on `ω`" (§ 2.2). It holds when the ring
   carries no arc of `Γ`. The coordinator ruled κ's change points, under which the clause is derived.

No counterexample to KAPPA, as ruled, was found.

## Attack on RUNG

1. **The Siamese case (the predicted break).** With Siamese pairs, the c_IV-tiles along `y = 1` may be several, and `T_w` need not be one of
   them. Two such tiles `A`, `B` meeting at `(s*, 1)` with `T_w ~ A`, `T_w ⊥ B` would make `|w − (s, 1)| > 1` beyond `s*` possible. V4-MEET
   rules this out: it would put the open `T_w` on `ω((s*, 1))`. The predicted break did not occur.
2. **"< 1" made "≤ 1" (where the attack succeeds).** Take `w = p ∈ cl T_IV`, a point of a c_IV-tile with `|w − q_N| = 1`. Then
   `|p − (s, 1)| = √(1 + s²) > 1` for every `s > 0`. The conclusion fails at the boundary of the hypothesis, so the strict inequality is exactly
   what is needed.
3. **Drop saturation.** R1 has no partner, and nothing places `c_IV` on `y = 1`. The control is the capped strip, which is not saturated at its
   midline edges (FS111-VM2-STRIP-MID: "at the midpoint of every edge A_j | B_j both side colours are free"). Saturation is used at R1 only.
4. **Curved edges.** R1's exclusion of `(s, −1)` uses edge points `(s′, 0)` at distance `√(1 + (s − s′)²) > 1` from it, which is a property of a
   straight edge. On a curved edge the normal lines turn. That is not claimed, as the statement says.
5. **The bound near `φ = 150°`.** `cos φ + √(sin φ (2 − sin φ))` tends to 0 as `φ → 150°⁻` (`−√3/2 + √(3/4) = 0`). So a contact just short of
   150° forces the edge's first segment almost to vanish. This is consistent: at 150° itself, `|r(150°) − q_N| = 1` and the hypothesis fails
   (item 2).
6. **Idle hypotheses (a thin truth).** R1 and R2 never use that `p` has degree 4, that it has four colours, or that the other three edges are
   segments along half-axes. The main clause holds for any segment edge from any point `p`, saturated along its first `ℓ` (V4-PARTNER with R2).
   These hypotheses serve only to name the quadrants and the rider.
7. **A positive control on an inhabitant.** In FS111-W-SQ9 (`k = 9`, saturated), the partners of the east edge's points are at `(s, 1)`, carrying
   `c_IV` (control `v4-sq9rung`; the plant at `(s, −1 − 1/1000)` fails).

No counterexample to RUNG was found.

## Attack on QF

1. **The objects that meet all hypotheses but one or two, and the step each fails at.**
   - FS111-W-SQ9 (`k = 9`) meets every hypothesis but six colours (the *not claimed* line). It fails at Q2, where K2 needs exactly two absent
     colours, and at Q3 (a)–(b), where with five absent colours the outward cone at a ring point may carry an absent colour.
   - The capped strip's midline vertex is degree 4, four colours, four segment edges, but not saturated (Q1 fails) and with four (Q) arcs
     (Q2 fails).
   - The disk's corners carry (Q) arcs. FS114-Y2-BOWTIE's centre has unit-arc edges, not segments.
   - The killing tests carried by the list: "six" is spent at Q2 and Q3 (a)–(b). On the strip the argument fails at Q1, saturation, and Q2,
     (Q) arcs. The hexagonal seven-colouring has no degree-4 vertex, and at `k = 7` K2 fails.
2. **Crosses not at right angles (where the argument's attack succeeds).** Keep the east and west edges opposite, so that both rungs still meet at
   `q_N`. Put the other two edges at angles `α ∈ (0°, 180°)` and `β ∈ (180°, 360°)`. The tiles are `A` (`0°..α`), `B` (`α..180°`), `C`
   (`180°..β`) and `D` (`β..360°`), and the rungs at `q_N` carry `D` (right) and `C` (left).
   - For `c = r(γ)`, `γ ∈ (30°, 90°)`, Q3 (e) admits `C` when `β ≤ 270° + γ`, and also admits `B` when `α ≥ γ + 90°`.
   - So the outer tile at `c` may be the colour of `B`, not of the left rung. The crossing of Q5 then has nothing to cross.
   That is where the argument stops for non-right crosses, matching the *not claimed* line. It is not a counterexample to QF, which assumes
   right angles.
3. **Non-Siamese** is used at Q1 (one tile per rung), Q2 (K6), Q3 (a), (e) and Q5. Without it, `O_c` and `T3N` may be distinct Siamese 3-tiles,
   and Q5 fails. QF's *not claimed* line names Siamese fragments as open.
4. **The axis point.** If `q_N ∈ C`, then `30°`, `90°`, `150°` are change points and `(30°, 90°)` holds none, so Q4 moves to `q_E`. Since `C` is
   one orbit, at least one of `q_N`, `q_E` is free of `C`. Without K6 (several orbits) Q4 would fail, but Q4 assumes non-Siamese.
5. **Idle hypotheses (a thin truth).** Saturation is used only at the points of the four edges' first segments (Q1). The fragment is read only on
   `B̄(p, 1)` and on the closed crescent `B̄(q, 1) ∖ B(p, 1)` at one axis point `q`, inside `B̄(p, 2)`. So QF holds with "saturated on `B̄(p, 1)`"
   weakened to "saturated at the points of `p`'s four edges".

No counterexample to QF was found. The statement is a non-existence claim, and no object meets all its hypotheses.

## "Would have searched here" — stage 2

None. No move here would have been made by search. The controls evaluate named quantities. `v4-parity` samples abstract labellings of germ
slots, not maps or colourings of the plane.

## The verdicts

verification: FS116-S1-KAPPA
  statement: at a vertex p of four colours and no more of a valid fragment on a closed disc of radius above 1 about p, Siamese pairs allowed,
    whose ring carries no (Q) arc, every germ of ω(p) (an arc just clockwise or just counter-clockwise of a ring point) lies in the closure of
    tiles of exactly one colour absent at p, κ, and the germ 60° on carries the other; so κ's change points form a finite non-empty set
    invariant under the rotation by 60° about p, each half-open 60° window of ω(p) holds an odd number of them, and antipodal germs carry
    different colours; in a non-Siamese fragment the change points are exactly y + 60°ℤ for one ring point y
  given: the statement with its not claimed line; data/fs116/claims.md §§ 0–12 and data/fs114/claims.md; the statements of
    plans/FS114-derivation.md § 3, N6-RING60 among them; three definitions from the first record's § 2.1 (K(g), germ, change point), quoted
    by the coordinator with nothing of its argument; the brief's remark that QF rests on KAPPA and RUNG — in full § 1.2
  committed: 2026-10-03, the stage 2 commit
  predicted: derived — 0.70 — likeliest break: the wording, reading A of "exactly one colour absent at p" or § 10's reading of the last
    clause's "change points"
  verdict: derived
  method: V4-DICHOTOMY and V4-TWIST (chord lengths on ω) for the first clause, a walk round ω for the parity, and a three-arc diameter
    contradiction (K6) for the non-Siamese clause; how this differs from the first route is stage 4's to say
  attack: § Attack on KAPPA
  divergences: none — the first derivation is opened only at stage 4, after this commit
  counterexamples: none — searched five colours at p, the (Q) case, k = 9 (FS111-W-SQ9, control v4-sq9anti), closed windows, the Siamese
    case of the last clause, and the two wording readings (§ Attack on KAPPA); each failure found lies outside the hypotheses or is named by
    the not claimed line; under § 10's reading the last clause is a gap, at whether a point of the orbit can end an arc of Γ on ω(p)
  minds: 2 — blind to: the first derivation's argument, route and record (only the proposer's belief, implicit in proposing it, was seen); method:
    my own route, its difference from the first unknown until stage 4; blind, the same model (Opus 5.5)
  grade: hand

verification: FS116-S1-RUNG
  statement: let p be a degree-4 vertex of four colours of a valid fragment whose four edges are segments along the four half-axes, with tiles
    coloured c_I, c_II, c_III, c_IV by quadrant, and suppose the fragment saturated at every point of the east edge's first segment
    [p, p + (ℓ, 0)], 0 < ℓ ≤ L_E; if a tile of colour c_IV has a point w in its closure with |w − q_N| < 1, q_N = p + (0, 1), then
    |w − p − (s, 1)| ≤ 1 for every s in [0, ℓ]; and the same at each edge and axis point, turned and reflected with the quadrants; in particular
    a contact of c_IV at r(φ), 90° < φ < 150°, gives ℓ ≤ cos φ + √(sin φ (2 − sin φ)), which at φ = 120° is FS116-Y1-STRIPCEIL's
    x* = √(√3 − 3/4) − 1/2
  given: the statement with its not claimed line; data/fs116/claims.md §§ 0–12 (FS116-O1-SATPIN's tangent type and FS116-N1-AXIS among
    them) and data/fs114/claims.md; the brief's remark that QF rests on KAPPA and RUNG — in full § 1.2
  committed: 2026-10-03, the stage 2 commit
  predicted: derived — 0.75 — likeliest break: the Siamese case, several c_IV tiles along y = 1 with w's tile related differently to them
  verdict: derived
  method: the partner of an edge point found by the two half-discs (V4-PARTNER), then V4-MEET along the connected cover of the rung by tile
    closures, which carries the Siamese case; the formula checked exactly (control v4-ceil); FS116-Y1-STRIPCEIL's own x* not read
  attack: § Attack on RUNG
  divergences: none — the first derivation is opened only at stage 4, after this commit
  counterexamples: thin truth: any segment edge from any point p, saturated along its first ℓ, with no condition on the degree, the colours or
    the other edges — R1 and R2 read only the east edge and its two side tiles (§ Attack on RUNG, item 6)
  minds: 2 — blind to: the first derivation's argument, route and record (only the proposer's belief, implicit in proposing it, was seen); method:
    my own route, its difference from the first unknown until stage 4; blind, the same model (Opus 5.5)
  grade: hand

verification: FS116-S1-QF
  statement: no non-Siamese valid fragment on B̄(p, 2), saturated on B̄(p, 1), whose ring ω(p) carries no (Q) arc, has at p a degree-4 vertex of
    four colours whose four edges are segments at right angles
  given: the statement with its not claimed line; data/fs116/claims.md §§ 0–12 and data/fs114/claims.md; the statements of
    plans/FS114-derivation.md § 3; and the brief's sentence calling SAT-STRIP "decided in one class (the last statement of the first three
    below, with two lemmas it rests on)", which is the author's verdict on QF — in full § 1.2
  committed: 2026-10-03, the stage 2 commit
  predicted: derived — 0.60 — likeliest break: the outer colour at the change points beside an axis point, or the final topological step
  verdict: derived
  method: the rungs at an axis point by V4-PARTNER, KAPPA's single orbit, the outer colour at a change point (V4-OUTER), then a Jordan-curve
    crossing in the crescent B(q_N, 1) ∖ B̄(p, 1); how this differs from the first route is stage 4's to say
  attack: § Attack on QF
  divergences: none — the first derivation is opened only at stage 4, after this commit
  counterexamples: thin truth: fragments saturated only at the points of p's four edges — saturation is used at Q1 alone (§ Attack on QF, item 5)
  minds: 1 — a checking reading on the verdict axis only: blind to the first derivation's argument, route and record, but given its verdict
    ("decided") in the brief; the derivation is my own route; blind otherwise, the same model (Opus 5.5)
  grade: hand

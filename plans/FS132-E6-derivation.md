# FS132-E6 — the seed card: what a point's unit circle forces in the balls about its ring points

*Ephodos, 2026-10-07 (UTC). Brief: `data/fs132/briefs/FS132-E6-seed-card.md`. Card: `plans/STUB-six-by-the-nerve.md` § The
question, re-posed after the second round. One mind throughout; every inherited entry is one mind's, hours old, and is named
where it is used. Scripts and outputs: `data/fs132/e6/`.*

## Theorems this phase proved

*(filled at each saved stage; addresses are sections of this file)*

- Stage 1 proved none: it states the claims.
- **C132-SHADOW** — [hand], one mind — Stage 2, § Argument — the shadow of an open piece.
- **C132-LENS** — [derived] from C132-SHADOW, over C132-PLACE (`plans/FS132-E4-derivation.md` Stage 3; [hand], one mind,
  inherited, its geometry re-checked here and its transfer not) — Stage 2, § Argument — the lens.
- **C132-LENS-SIDE** — [derived] from C132-LENS — Stage 2, § Argument — counts over sides.
- **C132-LENS-FOUR** — [derived] from C132-LENS — Stage 2, § Argument — counts over sides.
- **C132-LENS-GERM** — [derived] from C132-LENS-SIDE — Stage 2, § Argument — counts over sides.
- **C132-LENS-II** (the card's clause (ii) as posed) — **GAP** at "pure sides are opposite at antipodes" — Stage 2, § The gap in clause (ii).
- **C132-PLACED-RING** — [hand], one mind, over C132-PLACE — Stage 3, § Argument — the placed point's ring at its two neighbours.
- **C132-PLACED** (as posed, a list) — answered line by line, one line open: **GAP** at whether any pair containing a label of
  `T` is a witnessed edge at the placed point — Stage 3, § The list.
- C132-ARC — not reached; no line of it was worked.

## Stage 1 — SAVED: the readback, what I expect, recognition, and the claims stated

### 1.1 Readback

`python3 data/fs132/e6/readback.py` — twelve quotations of the brief, each found once in its source, each a whole line
(`quotations=12 unmatched=0`; with `--fault`, one character of the first changed, `unmatched=1`). **No mismatch.** Read whole:
the claim list with every dated line; the stub's section (ll. 275–398); `plans/FS132-E4-derivation.md` § 1.4 and Stages 2–3;
`plans/FS132-E5-derivation.md` C132-WIT-SIDE, its argument and the two arguments after it; `plans/SEARCH-2026-10-07.md`
Stages 1, 3 and 4; the asking lane's record § 1.3 findings C–E and § 3.1; the inventory's items 15, 16, 18, 20, 21, 23.
Read against the source: `[OAIMath2026]`, the release's `palettes.tex` ll. 20–68 (typical points, circle samplings,
Definition 5.1) and ll. 111–135 (Lemma 5.2's statement) — its proof not re-read by me (two earlier minds read it: FS132-E3's
T2 and FS132-E4's P1). Not read: the asking lane's record outside those sections; `LEDGER.md` rows 135–136 (read only as the
stub and that record quote them).

### 1.2 What I expect (registered 2026-10-07 — **not blind**)

Honest order of events: while reading the ring card's Stage 3 I worked the first claim's composition through in my head, and
before this section was written I had also run the seven-label re-run and read the search's kept model. So these are
expectations with the first argument already seen, and for the two riding controls I register nothing.

- **C132-LENS, first sentence**: derived (0.97) — it is one use of properness between two open sets, with the far wedges the
  ring card already placed.
- **C132-LENS (i)**: derived (0.97).
- **C132-LENS (ii) as posed**: not derived as posed (0.85): its composition takes "pure sides are opposite at antipodes" both
  ways, and only one way is true. Derived in a narrower form (0.90).
- **C132-PLACED**: the first night's exclusion does not apply on the orbit through `x` — the placed point's ring carries the
  point's own labels there (0.80); a four-cycle of witnessed edges forced closed (0.10).
- **C132-ARC**: not reached in this context (0.60).

*What each decides*: (ii)'s form decides what the claim list should carry (the posed sentence or the narrower one);
C132-PLACED's branch decides whether the next card is FS-124's question at a measurable instance.

### 1.3 Recognition (`ephodos-recognition`, invoked fresh)

**The stall, read.** There is none of mine yet; the card's own is "does a composition of four lines hold". The shape to
watch is the ring card's: every statement there is a clause per wedge and per pattern of sides.

**For a stranger** (someone who works on measurable independent sets of the unit-distance graph). *A measurable colouring of
an open set of the plane is proper at almost every pair of points at distance 1. Two points `p`, `p′` are at distance 1. An
open set `W`, almost all of one colour `i`, reaches `p′` along a segment that leaves the unit circle about `p` transversally.
Which points near `p` are then almost surely not of colour `i`?* Words that reader would stop at: "wedge", "lens", "pure
side", "ring point", "turning seed" — all of them accompaniments. **This is a unit shadow**: the set of points whose unit
circle meets `W` in positive length is open and almost free of the colour `i`; near `p` it is exactly one side of the unit
circle about `p′`. In this project's words it is G84's shadow identity (`int F = ℝ² ∖ (F + S¹)`) read for an open piece, and
it is the stub's "side rule" for open pieces, which no entry states: C132-WIT-SIDE has it for exclusion sets and
C132-WITNESS turns a connected one-label region into exclusion sets; composed, with the far wedge at `y_1` as the region
and a radial segment as the set, they give the same statement.

**The features, sorted.**

| feature | sort | receipt |
|---|---|---|
| the colour fills an **open** set reaching `p′` along a transversal segment | determines | the argument consumes it (a point of the circle about `z` in `W`, then an arc); control `seeing`, fault: a non-adjacent ring point — no pair left |
| on which side of the unit circle about `p` the segment leaves | determines (one sign) | control `seeing`: the 18 pairs are a product of sides; control `shadow`, fault: the wedge on the other side — 480 of 600 lens points miss it |
| six labels | accompanies the shadow; determines only "three labels outside `T`, two of them in the palettes, leave one" (C132-PLACE) | the shadow's statement has any finite number of labels |
| the turning order | determines which labels the two far wedges carry (`a` and `b`, different) | list line L4 against L5 of the ring card |
| the witnessed triangle at `x` | consumed only through its consequence "the outer side at `y_{±1}` carries no label of `T`" | C132-PLACE's P2 |
| which side is pure at `y_0` itself | accompanies | the argument reads nothing at `y_0` |
| the lens lying inside the ring | accompanies | each half holds on a whole side of a neighbour's circle, across the ring |
| the orbit's angle `ψ` | accompanies | `shadow --psi 0.7` prints the same line |
| "germs only measurable" | accompanies, **for this claim** | the seed's ring is a step by definition, so the forced pieces are open wedges; it determines elsewhere (the search's steps 3–4, § 2) |

**Homes.** (1) This project's own: C132-WITNESS then C132-WIT-SIDE with the centre moved to the ring point — holds, and is the
dictionary above. (2) G84's unit shadow — the same statement for a class; nothing to change. (3) The map class's ring
calculus (G91: "four-colour vertices propagate along the unit triangular lattice until a (Q) arc intervenes") — the
statement predicted a neighbour, which is the second claim's subject: a seed's forced wedges at its ring points are data on
*those* points' unit circles, and the first thing they show at the placed point is an arc of its own unit circle carrying
both side labels. **Different from the plan's picture in one respect**: the card reads the lens through a chart and the
transfer; the forced description reads no chart and, for the two ring labels, no palette at `y_0` — only open sets and one
sign. The transfer is consumed once, inside C132-PLACE.

**The class.** The statement belongs at "an open one-label set, two points at distance 1, a transversal segment" — entry
C132-SHADOW; C132-LENS is its instance at the two far wedges, and the card's clauses (i) and (ii) are counts over sides.

**A defect seen at this stage, in a line this claim rests on** (sent to the coordinator with the statements). The card's
clause (ii) rests on "pure sides are opposite at antipodes (that record's l. 578), so the six read O O O I I I or
O I O I O I". With the sides as defined (`plans/FS132-E4-derivation.md` § 1.4: blocked by *some* point of the set) only one
direction holds: a point of `K_j` strictly inside the unit circle about `y` is strictly outside the one about `2x − y`; a
point strictly outside the first need not be inside the second (`|q − x| > 2` is outside all six). Three two-point sets
`{x, q_j}` with `|q_j − x| = 3` give six pure inner sides and no pure outer side (control `sides`: `IIIIII`). So
`plans/FS132-E4-derivation.md` l. 577–579 ("Every pattern of sides has such a point when all six ring points have a pure
side") is true for sets whose blocking points are near `x` — a limiting direction perpendicular to no ring direction gives
that — and false as written. C132-TURN-EDGE's entry does not use the sentence; the stall's item (i) does, and so does the
card's (ii).

### 1.4 The claims, as my verdicts will be about them (sent to the coordinator)

*Terms*: as in `plans/FS132-E4-derivation.md` § 1.4 and the stub's section (a weak colouring, `H_i`, `Δ(K)`, the palette
`P_x(e)`, a witnessed triangle, a six-sector turning seed, `y_k = x + e(ψ + kπ/3)`; a label is **present** at a point when
the point lies in the label's closed essential support). The statements are the `statement:` lines of Stage 2's entries,
written there in full; in short:

- **C132-SHADOW** (the class; a relay-result). A weak colouring of an open set, any finite number of labels; `|p − p′| = 1`;
  an open set `W`, almost everywhere of label `i`, containing `p′ + sv` for `0 < s < r`, with `v·(p′ − p) ≠ 0`. Then near
  `p` almost every point strictly inside the unit circle about `p′` (if `v·(p′ − p) > 0`), or strictly outside it (if
  `< 0`), has a label other than `i`.
- **C132-LENS** (the card's first sentence, in two halves). On a six-sector turning seed: a pure outer side at `y_1` keeps
  `a` and `n` off almost every point near `y_0` inside the unit circle about `y_1`; a pure outer side at `y_{−1}` keeps `b`
  and `n` off almost every point near `y_0` inside the unit circle about `y_{−1}`; with both, the lens carries only `T`.
- **C132-LENS-SIDE** (the card's (i)): with both, `y_0` has no pure inner side.
- **C132-LENS-FOUR** (what (ii) needs, locally): three consecutive ring points with pure outer sides — the middle one has
  four labels present, `a`, `b`, `n` and a label of `T`.
- **C132-LENS-GERM** (the existence clause, at the hypothesis the argument reads): if each `K_j` has a point strictly inside
  three of the six unit circles about the ring points and strictly outside the other three, three consecutive ring points
  have pure outer sides.
- **C132-LENS-II**: the card's clause (ii), verbatim. Expected verdict: a gap at the antipodal step.
- **C132-PLACED** and **C132-ARC**: as posed, taken only as far as this context carries; C132-PLACED's verdict will be about
  the stub's sentence, with one entry of mine on the way (**C132-PLACED-RING**: what the placed point's unit circle carries
  at the two neighbouring ring points).

*The gate at this stage*: `derive_gate.py all` reports "no derivation entry" — nothing is entered yet; green from Stage 2.

## Stage 1 — SAVED

## Stage 2 — SAVED: C132-LENS

*Setting.* As the ring card's Stage 3 (`plans/FS132-E4-derivation.md` ll. 355–370): `x = 0`; `ψ_k = ψ + kπ/3`,
`y_k = e(ψ_k)`; the chart `Z(α, d) = e(α) + e(α − 2π/3 − d)` and its statement (W). The identities used below:
`e(ψ_{k+1}) − e(ψ_k) = e(ψ_{k+2})` and `e(ψ_{k−1}) − e(ψ_k) = e(ψ_{k−2})`. The six wedges at a ring point are named as the
search names them: outside the ring `O_cw`, `O_far`, `O_ccw`; inside it `I_ccw`, `I_lens`, `I_cw`.

**Verdicts.** The card's first sentence: **TRUE** (C132-LENS). Its clause (i): **TRUE** (C132-LENS-SIDE). Its clause (ii):
**GAP as posed** (C132-LENS-II) — true where three consecutive ring points have pure outer sides (C132-LENS-FOUR), which is
forced when each edge set has a point near `x` in general position (C132-LENS-GERM); the composition's step from "each ring
point has a pure side" to those three is false. No colouring by formula was built, and none was needed.

### The entries

derivation: C132-SHADOW
  statement: let U be an open set of the plane, c a measurable map from U to a finite set of labels with c(z) ≠ c(z + u) for almost every pair of a point z of U and a unit vector u with z + u in U, i a label, p and p′ two points of U with |p − p′| = 1, v a unit vector with v·(p′ − p) ≠ 0, r > 0, and W an open subset of U that contains the points p′ + sv for 0 < s < r and almost every point of which has the label i; then there is η > 0 such that, if v·(p′ − p) > 0, almost every point z of B(p, η) with |z − p′| < 1 has a label other than i, and, if v·(p′ − p) < 0, almost every point z of B(p, η) with |z − p′| > 1 has a label other than i
  uses only: the intermediate value theorem for s ↦ |p′ + sv − z| on (0, r); that W is open; Fubini for (z, u) ↦ z + u; weak properness in its measure form. It reads no palette, no chart, no exclusion set, no connectedness of W, and nothing of the number of labels
  not claimed: anything when v is tangent at p′ to the unit circle about p — then only the points whose unit circle crosses that circle inside W are reached, a sub-wedge whose opening shrinks with the size of W (control `seeing`: 0.194, 0.083, 0.000); anything for a set W that is not open (a set of positive density reaching p′ gives the statement for the points whose unit circles meet it in positive length, which need not be almost all points of a side); anything about the other side of the unit circle about p′
  argument: § Argument — the shadow of an open piece
  verdict: derived
  grade: hand
  minds: 1
  model: the search's kept four-label fragment (`data/search/2026-10-07/KEEP-turning-4label-arcs.json`, [cert]): p = y_0, p′ = y_1, W its wedge O_far at y_1 (a label of x), v radial — the wedges at y_0 inside the unit circle about y_1 carry b, b, b; over its six adjacent pairs of ring points, all 108 pairs of wedges on matching sides carry different labels (control `kept-model`)
  prior art: partly: in this project it is C132-WITNESS (`plans/FS132-E4-derivation.md` Stage 2) followed by C132-WIT-SIDE (`plans/FS132-E5-derivation.md`) with the centre at p′ and a segment of W as the set, and G84's shadow identity read for an open piece; in the map class it is the ring calculus's "a tile of p′ tips p" (G91); in print the mechanism is `[OAIMath2026]` Lemma 8.1 by FS132-E5's reading (not read by me); this form not searched for in print by this job — owed
  handoff: de Bruijn — the statement as written: one intermediate value, one open set, one Fubini; no colouring theory beyond weak properness. It gives the strips their second half (from an open piece instead of an exclusion set) and is the only tool C132-LENS adds to C132-PLACE

derivation: C132-LENS
  statement: let U be an open set of the plane containing the closed unit disc about a point x, c a measurable map from U to six labels with c(z) ≠ c(z + u) for almost every pair of a point z of U and a unit vector u with z + u in U, T a set of three labels and K_0, K_1, K_2 compact sets containing x such that for each of the three pairs of labels of T one of the sets K_j has Δ(K_j) disjoint from the closed essential supports of both labels of the pair, a, b, n the three labels outside T, ψ an angle such that for almost every θ the palette P_x(e(θ)) contains a if θ lies in (ψ − π/3, ψ) or in (ψ + 2π/3, ψ + π), b if θ lies in (ψ, ψ + π/3) or in (ψ + π, ψ + 4π/3), and n if θ lies in (ψ + π/3, ψ + 2π/3) or in (ψ + 4π/3, ψ + 5π/3), and y_k = x + e(ψ + kπ/3); if at least two of the sets K_j have a point strictly inside the unit circle about y_1, then there is η > 0 such that almost every point z of B(y_0, η) with |z − y_1| < 1 has its label outside {a, n}; if at least two of the sets K_j have a point strictly inside the unit circle about y_{−1}, then there is η > 0 such that almost every point z of B(y_0, η) with |z − y_{−1}| < 1 has its label outside {b, n}; and if both hold, there is η > 0 such that almost every point z of B(y_0, η) with |z − y_1| < 1 and |z − y_{−1}| < 1 has its label in T
  uses only: C132-PLACE on the outer side at y_1 and at y_{−1} (inherited: `plans/FS132-E4-derivation.md` Stage 3, [hand], one mind), which is where the palettes, the witnessed triangle and the six labels are consumed; of the palettes, their values just before and just after ψ, ψ + 2π/3 and ψ − 2π/3 — nothing at ψ ± π/3; the statement (W) of that record at y_1 and y_{−1} (re-checked: control `lens-shadow`, 1,681 samples); C132-SHADOW four times; four inner products of unit vectors. It reads nothing at y_0: no side there, no palette there, no witness there
  not claimed: anything when y_1 or y_{−1} has only a pure inner side, or no pure side (an edge set of x on its unit circle and the two others blocked on opposite sides — the kept model's case at its three four-label points); that any label of T is the one in the lens, or that the lens is of one label; that y_0 is a cyclic centre, or carries any witnessed edge; anything for an outside state that is not a step at ψ and ψ ± 2π/3; that a six-sector turning seed exists
  argument: § Argument — the lens
  verdict: derived
  grade: derived from: C132-SHADOW
  minds: 1
  model: none satisfying every hypothesis is known — no weak six-colouring with a turning seed is held, and the kept fragment has no ring point with a pure outer side (control `kept-model`: sides I-I-I-). What is exhibited: the geometry (control `lens-shadow`: of 600 lens points none whose unit circle misses either far wedge), and the mechanism without the hypothesis — at the kept fragment's point y_1 the outer wedges of both neighbours carry the labels C132-PLACE would force there (n, b, a at y_2 and a, n, b at y_0, in the order O_cw, O_far, O_ccw) and its lens carries a label of x
  prior art: partly: its composition was posed by the asking lane (`plans/POROS-2026-10-07-fs132-round2.md` § 1.3 E, through a chart and the transfer); the search's hand argument has its three pair rules as rows of an exact table in the wedge family (`plans/SEARCH-2026-10-07.md` § 1.5, steps 1–3); in the map class the statement is the ring calculus at a hub (G91; FS116-RING-TWIST-C); at five labels the release's lemma "Polynomial three-label region" is the neighbouring statement (by FS132-E4's reading, not mine); for a weak six-colouring not searched in print by this job — owed
  handoff: de Bruijn — after C132-PLACE's module: two charts read at y_1 and y_{−1}, then C132-SHADOW with the four segments the argument names

derivation: C132-LENS-SIDE
  statement: let U, x, c, T, K_0, K_1, K_2, a, b, n, ψ and the points y_k be as in C132-LENS, and suppose that at least two of the sets K_j have a point strictly inside the unit circle about y_1 and at least two of them have a point strictly inside the unit circle about y_{−1}; then it is not the case that at least two of the sets K_j have a point strictly outside the unit circle about y_0
  uses only: C132-LENS; C132-WIT-SIDE at w = y_0 for two of the sets (inherited: `plans/FS132-E5-derivation.md`, [hand], one mind — its argument is four lines and I re-derived it); that two edges of a triangle have its three labels among their endpoints; that the lens at y_0 is a non-empty open set inside the unit circle about x
  not claimed: that y_0 has a pure outer side; anything at a ring point one of whose neighbours has no pure outer side
  argument: § Argument — counts over sides
  verdict: derived
  grade: derived from: C132-LENS
  minds: 1
  model: none can exist (a non-existence); the count it rests on, as a pattern: among 46,656 triples of witness points at distance 1/10 from x the sides read O I O I O I in 2,592, and in each of those the statement applies at every inner-pure point (control `side-patterns`)
  prior art: partly: as C132-LENS; the statement is the asking lane's clause (i)
  handoff: de Bruijn — a corollary of C132-LENS and the strips' entry by one open set of positive measure

derivation: C132-LENS-FOUR
  statement: let U, x, c, T, K_0, K_1, K_2, a, b, n, ψ and the points y_k be as in C132-LENS, and k an integer such that for each of m = k − 1, k, k + 1 at least two of the sets K_j have a point strictly inside the unit circle about y_m; then y_k lies in the closed essential supports of a, of b, of n and of a label of T, and there is η > 0 such that almost every point of B(y_k, η) outside the unit circle about x has its label in {a, b, n} and almost every point of B(y_k, η) inside the unit circles about y_{k−1} and y_{k+1} has its label in T
  uses only: C132-LENS at y_k, after turning the seed by kπ/3 (which carries its hypotheses to themselves with a, b, n permuted cyclically); C132-PLACE on the outer side at y_k and list line L4 of that record (the three outer wedges carry the three outside labels, one each); that the lens and the three outer wedges meet every ball about y_k in a non-empty open set
  not claimed: which label of T is present, or that only one is; that the inner wedges beside the lens carry any label of T; that y_k is a cyclic centre in the release's sense (its transition graph is not computed); anything when k − 1, k, k + 1 are not all outer-pure
  argument: § Argument — counts over sides
  verdict: derived
  grade: derived from: C132-LENS
  minds: 1
  model: none is known (as C132-LENS); the kept fragment has no ring point with the labels a, b, n and one label of T — its four-label points carry two labels of x and two of the ring (control `kept-model`)
  prior art: partly: as C132-LENS; the conclusion "a four-label point is placed" is the asking lane's clause (ii) at the pattern O O O
  handoff: de Bruijn — a corollary of C132-LENS and C132-PLACE; the formal statement to read back is "four closed essential supports contain y_k"

derivation: C132-LENS-GERM
  statement: let U, x, c, T, K_0, K_1, K_2, a, b, n, ψ and the points y_k be as in C132-LENS, and suppose that each of the sets K_0, K_1, K_2 has a point that lies strictly inside the unit circles about three of the six points y_0, …, y_5 and strictly outside the unit circles about the other three; then there is an integer k such that for each of m = k − 1, k, k + 1 at least two of the sets K_j have a point strictly inside the unit circle about y_m
  uses only: that a point strictly inside the unit circle about y is strictly outside the unit circle about 2x − y; a count of three three-element sets over three antipodal pairs; C132-LENS-SIDE at a ring point between two outer-pure ones, to exclude the alternating pattern
  not claimed: anything for sets whose points off the six circles are all outside four or more of them — sets that witness from far away (the card's clause (ii) is open there: C132-LENS-II); that the hypothesis holds for the continua of an extraction — it does when each has a limiting direction at x perpendicular to none of the six directions e(ψ + kπ/3), and fails when a set lies on the unit circle about a ring point
  argument: § Argument — counts over sides
  verdict: derived
  grade: derived from: C132-LENS-SIDE
  minds: 1
  model: none is known (as C132-LENS); the count as a pattern: 46,656 triples of witness points at distance 1/10 from x give three outer-pure points in a row in 44,064 and the alternating pattern in 2,592, nothing else (control `side-patterns`)
  prior art: partly: the count is the ring card's (`plans/FS132-E4-derivation.md` l. 578), there without the hypothesis it needs
  handoff: de Bruijn — a finite count on ℤ/6 and one inequality; with C132-LENS-FOUR it is the card's clause (ii) at the hypothesis the argument reads

derivation: C132-LENS-II
  statement: On a six-sector turning seed, if each of the six ring points has a pure side, some ring point has four labels present: `a`, `b`, `n` and a label of `T`
  uses only: nothing is carried to the statement as posed. Derived of it: C132-LENS-FOUR (wherever three consecutive ring points have pure outer sides) and C132-LENS-GERM (which gives those three when every edge set has a point inside three of the six circles and outside three)
  not claimed: its truth or its falsity for the sixteen patterns of sides § The gap in clause (ii) lists; no seed with such sides was built, and none was excluded
  argument: § The gap in clause (ii)
  verdict: gap: the step "pure sides are opposite at antipodes, so the six read O O O I I I or O I O I O I" — a point of a set strictly inside the unit circle about y is strictly outside the one about 2x − y, and not conversely; three sets {x, q_j} with |q_j − x| = 3 give six pure inner sides and no pure outer side (control `side-patterns`: IIIIII)
  grade: hand
  minds: 1
  model: the hypothesis alone is met by the three two-point sets of the gap, as a pattern of sides and not as a colouring
  prior art: partly: the sentence is the asking lane's (`plans/STUB-six-by-the-nerve.md` § The first claims a deriver takes, C132-LENS (ii)); the step is the ring card's l. 578
  handoff: Poros — not derived as posed; gap at the antipodal step; the smallest open form is the last paragraph of § The gap in clause (ii)

control: lens-shadow
  of: C132-LENS — the card's falsifier, computed: on a polar grid in B(y_0, 0.02), the points of the lens (and all points inside the unit circle about either neighbour) whose unit circle meets the far wedge at that neighbour, within radius 0.2, in zero length; and (W) at y_1 against distances
  run: python3 ../data/fs132/e6/lens_checks.py shadow
  expect: lens-points=600 missing-the-wedge-at-y1=0 missing-the-wedge-at-y-1=0 points-inside-y1=1800 missing=0 points-inside-y-1=1800 missing=0 least-arc-over-depth=11 chart-samples=1681 chart-mismatches=0
  fault: python3 ../data/fs132/e6/lens_checks.py shadow --fault

control: seeing
  of: C132-SHADOW — which wedges at y_0 have every point's unit circle through which wedges at y_1, and back; and, for the two pairs of the search's steps 3 and 4, the fraction of the looking wedge that sees the other, at sizes 0.2, 0.05, 0.0125 of the wedge seen
  run: python3 ../data/fs132/e6/lens_checks.py seeing
  expect: full-pairs=18 [I_ccw+I_lens+O_ccw]x[I_ccw+O_ccw+O_far] and [I_cw+O_cw+O_far]x[I_cw+I_lens+O_cw] product=True same-pairs-back=True lens1-seeing-Occw0=0.194,0.083,0.000 far1-seeing-far0=0.167,0.083,0.000
  fault: python3 ../data/fs132/e6/lens_checks.py seeing --fault

control: side-patterns
  of: C132-LENS-GERM — the patterns of sides for three witness points at distance 1/10 from x on a grid of directions, for three witness points at distance 3, for one outer-pure point, and the number of sets of outer-pure points the card's clause (ii) leaves open
  run: python3 ../data/fs132/e6/lens_checks.py sides
  expect: near-witness-triples=46656 three-in-a-row=44064 alternating=2592 other=0 far-witnesses=IIIIII one-outer=OIIIII outer-sets-left-open=16
  fault: python3 ../data/fs132/e6/lens_checks.py sides --fault

control: kept-model
  of: C132-SHADOW — the search's kept four-label fragment: its 108 pairs of wedges on matching sides at adjacent ring points, its labels at each ring point, where its lens carries a label of x, its interfaces at x and its sides
  run: python3 ../data/fs132/e6/lens_checks.py model
  expect: first-order-pairs=108 equal-labels=0 labels=012,1234,012,0145,012,0235 lens-in-T-at=[1, 3, 5] points-with-a-b-n-and-one-of-T=[] interfaces-of-x=3 on-unit-circles-about=[1, 3, 5] sides=I-I-I- points-with-both-neighbours-outer-pure=[]
  fault: python3 ../data/fs132/e6/lens_checks.py model --fault

control: hex-half-crossings
  of: C132-LENS — riding: the ring card's control `hex7-crossings` on the honeycomb at circumradius 1/2 (the fault is the original radius 2/5, whose line must be the second round's)
  run: python3 ../data/fs132/e6/hex_half.py hex7
  expect: radius=0.5 vertex-pairs=216 crossings=432 least-shared-outside=1 own-label-near-crossing=36
  fault: python3 ../data/fs132/e6/hex_half.py hex7 --radius 0.4

control: hex-half-sides
  of: C132-LENS — riding: at circumradius 1/2, every sample near a common unit point that carries a label of one of the two vertices lies inside that vertex's unit circle (the fault is circumradius 0.45, where no such sample exists)
  run: python3 ../data/fs132/e6/lens_checks.py hexcross
  expect: radius=0.5 crossings=432 crossings-with-an-own-label=36 own-label-samples=5760 own-label-samples-outside-the-vertex's-unit-circle=0
  fault: python3 ../data/fs132/e6/lens_checks.py hexcross --fault

control: hex-half-margin
  of: C132-LENS — riding: the witness card's control `margin-witness` at circumradius 1/2 (the fault is the original radius)
  run: python3 ../data/fs132/e6/hex_half.py witness
  expect: radius=0.5 colourings=3 points=13 samples=982800 vertex-labels-on-annulus=6672 labels-seen=0123456
  fault: python3 ../data/fs132/e6/hex_half.py witness --radius 0.4

control: hex-half-relation
  of: C132-LENS — riding: the first round's control `hex7-relation` at circumradius 1/2, the three vertices on the unit circle counted inside it (the fault is the original radius)
  run: python3 ../data/fs132/e6/hex_half.py hexrel --closed
  expect: radius=0.5 own-labels=[0, 2, 3] ring-labels=[1, 4, 5, 6] own-on-rings=[[0, 2, 3], [], []] crossings=9 ring-walk=654164514 two-jumps-60-apart=False vertices-inside=13 relation-holds=True
  fault: python3 ../data/fs132/e6/hex_half.py hexrel --closed --radius 0.4

### Argument — the shadow of an open piece

Put `m = |v·(p′ − p)| > 0` and take `η > 0` with `B(p, η) ⊂ U`, `η ≤ m/4`, `η < m²/6`, `η ≤ 1` and `3η/m < r`. For
`z ∈ B(p, η)` put `g(s) = |p′ + sv − z|² − 1 = g(0) + 2s v·(p′ − z) + s²`, where `|v·(p′ − z) − v·(p′ − p)| < η`.

*Case `v·(p′ − p) = m`, `|z − p′| < 1`.* Then `−2η ≤ g(0) < 0` (as `|z − p′| > 1 − η`) and `v·(p′ − z) ≥ 3m/4`, so
`g(3η/m) ≥ −2η + (9/2)η > 0`. *Case `v·(p′ − p) = −m`, `|z − p′| > 1`.* Then `0 < g(0) ≤ 3η` and `v·(p′ − z) ≤ −3m/4`, so
`g(3η/m) ≤ 3η − (9/2)η + 9η²/m² < 0`. In both cases `g` vanishes at some `s* ∈ (0, 3η/m) ⊂ (0, r)`: the point
`w* = p′ + s*v` lies in `W` and on the unit circle about `z`.

Let `S` be the set of `z` of the case in hand, an open set, and `G = {(z, u) : z ∈ S, |u| = 1, z + u ∈ W}`, open in
`S × S¹`. Each fibre `G_z` is open in the circle and contains `w* − z`, so it has positive length. The pairs of `G` with
`c(z + u) ≠ i` are null (for each `u`, the `z` with `z + u` in the null set `W ∖ c⁻¹(i)` form a translate of a null set),
and the pairs with `c(z) = c(z + u)` are null (weak properness; both points are in `U`). Off both, `c(z) ≠ i`. By Fubini,
for almost every `z ∈ S` almost every `u ∈ G_z` is off both, and `G_z` is not null; so `c(z) ≠ i` for almost every
`z ∈ S`. ∎

*What the control adds* (`seeing`). Read on the six wedges at two adjacent ring points, the statement says: each wedge at
`y_0` inside the unit circle about `y_1` (`O_ccw`, `I_ccw`, `I_lens`) has **every** point's unit circle through each wedge at
`y_1` outside the unit circle about `y_0` (`O_far`, `O_ccw`, `I_ccw`), and the three others at `y_0` through the three
others at `y_1`: eighteen pairs, a product of sides, the same read back from `y_1`. The other eighteen pairs meet only where
a unit circle crosses the dividing circle inside the wedge seen: a sub-wedge of the looking wedge whose share falls with
the size of the wedge seen (0.194, 0.083, 0.000 at sizes 0.2, 0.05, 0.0125, grid-limited).

### Argument — the lens

*First half.* Suppose two of the `K_j` have a point strictly inside the unit circle about `y_1`. C132-PLACE at the ring
point `y_1` gives `κ ∈ (0, π/6)` such that for almost every `(t, d)` with `|t| < κ`, `−κ < d < 0` the label of
`Z(ψ_2 + t, d)` is one of `a, b, n` and lies in neither palette of its ring neighbours, which are at the angles `ψ_2 + t`
and `ψ_0 + t − d`. Angular null sets pull back to null sets under `(t, d) ↦ ψ_2 + t` and `(t, d) ↦ ψ_0 + t − d`. So, almost
everywhere:

- where `d < t < 0`: the palettes hold `n` (an angle just before `ψ_2`) and `b` (just after `ψ_0`) — **the label is `a`**;
- where `t > 0`: they hold `a` (just after `ψ_2`) and `b` (just after `ψ_0`) — **the label is `n`**.

`Z` is a diffeomorphism near `(ψ_2, 0)` with `Z(ψ_2, 0) = y_1`, so the image of `{|t| < κ, −κ < d < 0}` contains the part of
a ball `B(y_1, κ_1)` outside the unit circle about `x`; and by (W) read at `y_1` (whose forward ring point is `y_2` and
backward ring point `y_0`), `t > 0` is "inside the unit circle about `y_2`" and `t − d > 0` is "outside the unit circle about
`y_0`". Hence the open sets

> `W_a = {w ∈ B(y_1, κ_1) : |w − y_0| > 1, |w − y_2| > 1}` and `W_n = {w ∈ B(y_1, κ_1) : |w − x| > 1, |w − y_2| < 1}`

are almost everywhere of label `a` and of label `n` (on `W_a`: `d < t < 0`, so `d < 0`). Now C132-SHADOW with `p = y_0`,
`p′ = y_1`:

- `v = e(ψ_1)`: `|y_1 + sv − y_0|² = |y_1 + sv − y_2|² = 1 + s + s² > 1`, so `y_1 + sv ∈ W_a` for `0 < s < κ_1`; and
  `v·(y_1 − y_0) = 1/2 > 0`. So almost every `z` near `y_0` with `|z − y_1| < 1` has a label other than `a`.
- `v = e(ψ_2)`: `|y_1 + sv − x|² = 1 + s + s² > 1` and `|y_1 + sv − y_2|² = |e(ψ_0) + s e(ψ_2)|² = 1 − s + s² < 1`, so
  `y_1 + sv ∈ W_n` for `0 < s < κ_1`; and `v·(y_1 − y_0) = e(ψ_2)·e(ψ_2) = 1 > 0`. So almost every such `z` has a label
  other than `n`.

*Second half.* Suppose two of the `K_j` have a point strictly inside the unit circle about `y_{−1}`. C132-PLACE at `y_{−1}`:
the points are `Z(ψ_0 + t, d)`, `d < 0`, with ring neighbours at `ψ_0 + t` and `ψ_{−2} + t − d`, and almost everywhere:

- where `d < t < 0`: the palettes hold `a` (just before `ψ_0`) and `n` (just after `ψ_{−2}`) — **the label is `b`**;
- where `t < d`: they hold `a` (just before `ψ_0`) and `b` (just before `ψ_{−2}`) — **the label is `n`**.

By (W) at `y_{−1}` (forward ring point `y_0`, backward `y_{−2}`): `W_b = {w ∈ B(y_{−1}, κ_1) : |w − y_0| > 1, |w − y_{−2}| > 1}`
is almost everywhere `b` and `W′_n = {w ∈ B(y_{−1}, κ_1) : |w − x| > 1, |w − y_{−2}| < 1}` almost everywhere `n`.
C132-SHADOW with `p = y_0`, `p′ = y_{−1}`, `v = e(ψ_{−1})` (in `W_b`; `v·(y_{−1} − y_0) = 1/2`) and `v = e(ψ_{−2})` (in `W′_n`;
`v·(y_{−1} − y_0) = 1`): almost every `z` near `y_0` with `|z − y_{−1}| < 1` has a label other than `b` and other than `n`.

*Both.* A point inside both circles has a label outside `{a, b, n}`. ∎

**The card's falsifier, computed.** "A set of positive measure in that lens whose points' unit circles miss, in length, both
the `a`-wedge at `y_1` and the `b`-wedge at `y_{−1}`": the set is **empty**, and more is true — every point near `y_0`
strictly inside the unit circle about `y_1` has its unit circle through `W_a` in positive length (the point `w*` of the
shadow's argument), lens or not. Control `lens-shadow`: 600 lens points and 1,800 points inside each neighbour's circle, none
missing; the least arc is 11 times the point's depth inside the neighbour's circle; with the wedge on the other side of the
unit circle about `y_0` planted as the target, 480 of the 600 lens points miss it.

**How it differs from the asking lane's four lines.** (1) Their third line keeps `n` out of the lens by the transfer at `x`
(both ring neighbours of a lens point have `n` in their palettes): true — P1 of the ring card holds on either side of the
ring — and it needs no side at all. The argument above does not use it; it gets `n` from the neighbours' `O_ccw` and `O_cw`
wedges, so that the whole statement reads C132-PLACE and properness and nothing else. Either route serves. (2) The
exclusions of `a` and `b` hold on a whole side of a neighbour's unit circle, across the ring, not only in the lens: outside
the ring they say what the transfer already said (`O_ccw` is without `a`, `O_cw` without `b`).

### Argument — counts over sides

**C132-LENS-SIDE.** Suppose two of the `K_j` have a point strictly outside the unit circle about `y_0`. By C132-WIT-SIDE at
`w = y_0`, for each of the two there is a ball about `y_0` in which almost every point inside the unit circle about `x` has
its label outside the two labels of that edge; two edges of a triangle carry its three labels, so almost every such point
has its label outside `T`. The lens `{z ∈ B(y_0, η) : |z − y_1| < 1, |z − y_{−1}| < 1}` is open, contains `y_0 − s e(ψ)` for
small `s > 0` (`|y_0 − s e(ψ) − y_{±1}|² = 1 − s + s²`), and by (W) lies inside the unit circle about `x` (`0 < t < d`). By
C132-LENS almost every point of it has its label in `T`. A non-empty open set cannot be almost everywhere both. ∎

**C132-LENS-FOUR.** Turning by `π/3`: with `ψ′ = ψ + π/3` the palettes hold `b` on `(ψ′ − π/3, ψ′)` and `(ψ′ + 2π/3, ψ′ + π)`,
`n` on `(ψ′, ψ′ + π/3)` and `(ψ′ + π, ψ′ + 4π/3)`, and `a` on the two other arcs; so the hypotheses of C132-LENS hold at
`ψ′` with `(a, b, n)` replaced by `(b, n, a)`, and by induction at every `ψ_k`. Take `k = 0`. *Outside the ring.* C132-PLACE
at `y_0` (its outer side is pure): the points are `Z(ψ_1 + t, d)`, `d < 0`, with neighbours at `ψ_1 + t` and `ψ_{−1} + t − d`;
almost everywhere the label is one of `a, b, n`, and it is `n` where `d < t < 0` (palettes `b`, `a`), `a` where `t < d`
(palettes `b`, `n`), `b` where `t > 0` (palettes `n`, `a`) — list line L4 of the ring card. Each of the three sets is open
and meets every ball about `y_0`, so `y_0` lies in the supports of `a`, `n` and `b`. *The lens.* By C132-LENS almost every
point of it has its label in `T`, and it meets every ball about `y_0` in a non-empty open set; so for every `m` some label
of `T` has positive measure in the lens within `B(y_0, 1/m)`, one label serves infinitely many `m`, and `y_0` lies in its
support. ∎

**C132-LENS-GERM.** Let `q_j ∈ K_j` be the point of the hypothesis and `O_j` the set of `k` (modulo 6) with
`|y_k − q_j| < 1`: three elements, and `q_j` is strictly outside the unit circle about `y_k` for `k ∉ O_j`. If `|y − q| < 1`
and `|y − x| = 1` then `2(y − x)·(q − x) > |q − x|² > 0`, so `|2x − y − q|² = 1 + |q − x|² + 2(y − x)·(q − x) > 1`: `O_j`
holds at most one of `k`, `k + 3`, hence one of each. With `n_k` the number of `j` with `k ∈ O_j`: `n_k + n_{k+3} = 3`. So
the set `𝒪` of `k` with `n_k ≥ 2` has one element of each antipodal pair; at `k ∈ 𝒪` two of the sets have a point strictly
inside the unit circle about `y_k`, and at `k ∉ 𝒪` two of them have a point strictly outside it. A set with one element of
each of the three antipodal pairs is three in a row or one of the two alternating sets (eight sets: six and two). If it is
alternating, a `k ∉ 𝒪` has `k ± 1 ∈ 𝒪`, against C132-LENS-SIDE at `y_k` (turned as above). So `𝒪 = {k − 1, k, k + 1}`. ∎
*(Where the hypothesis comes from: a set with points `x + s_m w_m`, `s_m → 0`, `w_m → v`, and `v` perpendicular to none of
the six `e(ψ_k)`, has `|y_k − q_m|² − 1 = s_m(s_m − 2 e(ψ_k)·w_m)` of the sign of `−e(ψ_k)·v` for large `m`: inside three,
outside three.)*

### The gap in clause (ii)

The card: "pure sides are opposite at antipodes (that record's l. 578), so the six read O O O I I I or O I O I O I up to
rotation". A side is defined by *some* point of a set (`plans/FS132-E4-derivation.md` § 1.4). The inequality of
C132-LENS-GERM gives: outer-blocked at `y` ⟹ inner-blocked at `2x − y`. The converse fails: `|q − y| > 1` and
`|q − (2x − y)| > 1` together say `|(y − x)·(q − x)| < |q − x|²/2`, true of every `q` with `|q − x| > 2` and of points near
`x` in directions nearly perpendicular to `y − x`. So a ring point may have both pure sides, and all six may be inner-pure
with none outer-pure (three sets `{x, q_j}`, `|q_j − x| = 3`: control `side-patterns`, `IIIIII`; with two witnesses at `1.5 y_0`
and `1.4 y_0`: `OIIIII`).

**What is derived of (ii), and what is left.** Write `𝒪` for the set of outer-pure ring points, and suppose every ring point
has a pure side. If `k − 1, k + 1 ∈ 𝒪` then `y_k` has no pure inner side (C132-LENS-SIDE), so its pure side is outer and
`y_k` has four labels present (C132-LENS-FOUR). So (ii) holds unless **no two members of `𝒪` are two apart**: `𝒪` empty, one
point, two adjacent points or two antipodal points — sixteen sets (control `side-patterns`). In each of them at least four
ring points have a pure inner side and no pure outer side, and no entry of this record or of the ring card's says anything
at a ring point whose neighbours are not outer-pure. These are seeds whose sets witness from far away: each inner block
without its antipodal outer block needs a point `q` of the set with `|(y − x)·(q − x)| < |q − x|²/2`. For the extraction's
continua with limiting directions in general position they do not occur (C132-LENS-GERM).

**Smallest open form.** *A six-sector turning seed in which every ring point has a pure inner side and no ring point has
both neighbours outer-pure: is some ring point a four-label point — or does such a seed not exist?* One remark, not entered:
when every witnessing point is farther than 2 from `x`, the labels of `T` are excluded from the whole open unit disc about
`x`, which three labels cannot colour (a Moser spindle has circumradius `3/√11 < 1`); between that and the germ case the
question is real.

**The correction owed to the ring card's record** (a draft for the coordinator; the record is not mine).
`plans/FS132-E4-derivation.md`, § Where C132-TURN stalls, item (i), the sentence "Every pattern of sides has such a point
when all six ring points have a pure side: the side is opposite at antipodes, so the six read O O O I I I (take the middle
O) or O I O I O I (take any I)." — to follow it, a dated line: *"2026-10-07, FS132-E6: true when each of the three sets has
a point strictly inside three of the six unit circles about the ring points and strictly outside the other three (so when
each has a limiting direction at `x` perpendicular to no ring direction); false as written — sets `{x, q_j}` with
`|q_j − x| > 2` make all six sides inner-pure and none outer-pure. The entry C132-TURN-EDGE does not use the sentence. And by
C132-LENS-SIDE the pattern O I O I O I does not occur at all. Source: `plans/FS132-E6-derivation.md` Stage 2, § The gap in
clause (ii)."*

### The two things the brief asks to carry visibly

**(1) The search's hand argument** (`plans/SEARCH-2026-10-07.md` § 1.5), step by step, for germs that are only measurable.
My reading agrees with its pair rules wherever they are among the eighteen every-point pairs, and those are the ones
C132-LENS uses.

- *Step 1* (`O_far` carries neither ring label) and *step 2* (`I_lens` does not carry the third outside label): its rows
  (`O_far`; `O_cw`, `I_cw`) and (`I_lens`; `O_ccw`, `I_ccw`) are every-point pairs. For measurable germs both conclusions hold
  with no wedge at all: they are the transfer (the ring card's P1) on either side of the ring.
- *Step 3, first rule* — (`O_far` at `y_k`, `I_lens` at `y_{k+1}`) rejects: an every-point pair; with the far wedge an open
  one-label piece it holds for a lens that is only measurable. This rule, mirrored at both neighbours, is C132-LENS.
- *Step 3, second rule* — (`O_ccw` at `y_k`, `I_lens` at `y_{k+1}`) rejects, "so `I_lens` at `y_{k+1}` is not `L_{k+1}`":
  **this is the step that fails for germs that are only measurable.** It is not an every-point pair: only the lens points
  whose unit circle crosses the unit circle about `y_{k+1}` inside the wedge seen are reached — a sub-wedge along the lens's
  side on the unit circle about `y_k`, of opening about the arcsine of the wedge's size (control `seeing`: 0.194, 0.083,
  0.000 of the lens). For a lens of one label that is enough; for a measurable lens, or a lens split by a curve (which the
  search lists as outside its family), the label `L_{k+1}` is excluded from that sub-wedge only. C132-LENS gets the same
  exclusion from the far wedge at the *other* neighbour, an every-point pair, at the price of a pure outer side there.
- *Step 4* — (`O_far`, `O_far`) rejects: the same kind of pair (0.167, 0.083, 0.000); for measurable germs it is the ring
  card's O, O case of C132-ALT, with its shift.
- *Step 5* (three labels of `x` cannot serve six far wedges through half-planes): reads `x`, not the ring germs. Not checked
  by me.

So the search's null is, as it says, its family's: steps 3 and 4 are about one-label wedges. What survives into the
measurable class is what C132-LENS-FOUR and C132-LENS-GERM state.

**(2) Which side of the line each statement sits on** (the line: an interface of `x` on a unit circle about a ring point).
C132-SHADOW: no side — it reads open sets and no edge set. C132-LENS and C132-LENS-SIDE: hypotheses at the two neighbours
only — each must have two edge sets with a point strictly inside its unit circle, so at most one edge set of `x` on its
circle — and **none at `y_0`**: they hold at a ring point on whose unit circle an edge set of `x` lies. That is the first
conclusion of this milestone at a ring point of the hard kind, reached from neighbours of the easy kind. C132-LENS-FOUR:
the same at three points. C132-LENS-GERM: the arc-free side — its hypothesis fails for a set lying on a unit circle about a
ring point. The kept model, which is the hard case (three interfaces of `x` on the unit circles about `y_1, y_3, y_5`): no
statement of this stage applies to it — its sides read `I - I - I -`, no ring point is outer-pure.

### The two riding controls

**The seven-label controls at circumradius 1/2** (every tile of diameter exactly 1; each vertex's three tiles touch its
unit circle at the three opposite vertices). Run by `data/fs132/e6/hex_half.py`, which executes the second round's own
scripts with the one line that sets the radius replaced; at radius 2/5 it reproduces their recorded lines.

| control | at 2/5 (recorded) | at 1/2 | reading |
|---|---|---|---|
| `hex7-crossings` (C132-CROSS) | pairs 342, crossings 684, least-shared-outside 1, own-label-near-crossing **0** | 216, 432, 1, **36** | **moved.** At 36 of 432 common unit points a label of one of the two vertices is seen: the point is that vertex's opposite vertex in a tile. Every one of the 5,760 such samples lies inside that vertex's unit circle (control `hex-half-sides`), as the blocking rule requires. The entry is untouched; the zero at 2/5 was the margin |
| `margin-witness` (C132-WIT-MARGIN) | vertex-labels-on-annulus **0**, labels seen 1456 | **6,672**, all seven | **moved**: the entry's hypothesis (labels off an annulus) fails; at 1/2 no witness comes from a margin. (Witnesses remain, by C132-WITNESS on the tiles.) |
| `hex7-relation` (C132-REL) | own-on-rings none; 13 vertices inside; relation holds | own labels on the ring of radius 0.98; **11, False** as the script stands; **13, True** with the three vertices on the circle counted inside | the unit circle about a vertex passes through three vertices, outside C132-REL's hypothesis; the script's strict comparison counts them by rounding. Ring walk and crossings unchanged |

So two counts move, both where the asking lane expected (its record § 3.1: `margin-witness` finds the vertex's labels, 0.8)
and one where it did not (`hex7-crossings`' fourth count; it expected that control unchanged), and none against an entry:
at 1/2 the second round's exclusions still hold, and what the 2/5 controls' zeros recorded beyond them was the margin.

**The search's kept four-label model** (control `kept-model`). *It is not what the claim predicts, and it does not
contradict it.* The claim's four-label point carries `a, b, n` outside the ring and a label of `T` in the lens, between two
outer-pure neighbours. The model's four-label points (`y_1, y_3, y_5`) carry two labels of `x` and two ring labels, and
are the points on whose unit circles the interfaces of `x` lie; its three other ring points carry `a, b, n` and nothing
else, with pure inner sides only. No ring point is outer-pure, so no hypothesis of this stage is met anywhere in it. Two
things it does show: all 108 every-point pairs carry different labels (C132-SHADOW, checked on a held object), and at each
of its four-label points the lens carries a label of `x` *for the reason C132-LENS gives* — both neighbours' outer wedges
happen to carry the labels a pure outer side would force — without the hypothesis that forces them.

### Expectations scored at this stage

C132-LENS first sentence derived (0.97): met. (i) derived (0.97): met. (ii) not derived as posed (0.85): met — a gap, with
two derived entries under it. The asking lane's: C132-LENS derived (0.65) — met for the first sentence and (i), not for (ii)
as posed; "stalls at a line of one chart" (0.25) — no; the line that failed is a count of sides, not a chart.

## Stage 2 — SAVED

## Stage 3 — SAVED: C132-PLACED, as far as this context carried

*Setting.* C132-LENS-FOUR's, with `k = 0`: `y = y_0`, and `y_{−1}, y_0, y_1` each have a pure outer side.

**Verdict.** The list is derived but for one line, and the card's table is answered at its second row: **the placed point's
ring carries the point's own labels toward `x` — a mixed ring.** No four-cycle of witnessed edges is closed at `y` by
anything derived, and if one were, the first night's exclusion would still say nothing on the orbit through `x`.

### The entries

derivation: C132-PLACED-RING
  statement: let U, x, c, T, K_0, K_1, K_2, a, b, n, ψ and the points y_k be as in C132-LENS, and suppose that at least two of the sets K_j have a point strictly inside the unit circle about y_1 and at least two of them have a point strictly inside the unit circle about y_{−1}; then there is κ > 0 such that almost every point w of B(y_1, κ) with |w − x| > 1 and |w − y_2| > 1 has the label b when |w − y_0| < 1 and the label a when |w − y_0| > 1, and almost every point w of B(y_{−1}, κ) with |w − x| > 1 and |w − y_{−2}| > 1 has the label a when |w − y_0| < 1 and the label b when |w − y_0| > 1; and if U contains the unit circle about y_0, then for almost every θ in (ψ + 2π/3 − κ, ψ + 2π/3) and almost every θ in (ψ − 2π/3, ψ − 2π/3 + κ) the palette P_{y_0}(e(θ)) is contained in {a, b}
  uses only: C132-PLACE on the outer side at y_1 and y_{−1} with (W) (as in C132-LENS's argument); that the points y_0 + e(θ) of the two arcs lie in the two open regions named (control `placed-arcs`); the release's definition of a typical point (density one of its own label, `palettes.tex` l. 20) and of the palette (Definition 5.1, ll. 47–68), read by me
  not claimed: that the two palettes contain both a and b (each is present on one side of the arc, which gives it for samplings from that side; not written out); anything on the rest of the unit circle about y_0 — in particular at x, at y_0 + e(ψ ± π/3) and at y_0 + e(ψ); that y_0 has a pure outer side (with one, a and b are present at y_0 by C132-LENS-FOUR, and the two arcs then carry both their side labels at their centre)
  argument: § Argument — the placed point's ring at its two neighbours
  verdict: derived
  grade: hand
  minds: 1
  model: none is known (as C132-LENS); the geometry is exhibited — 400 points of the two arcs, none outside its region, with O_cw and O_far of y_1 on the two sides of the unit circle about y_0, and O_ccw and O_far of y_{−1} (control `placed-arcs`)
  prior art: partly: in the map class this is row 135's unit arc "centred at a vertex of at least four colours carrying both its side colours" with the vertex placed by the ring (G91), read by me only as `plans/STUB-six-by-the-nerve.md` and the asking lane's record quote it; the two regions are the ring card's list line L4 at y_{±1}; for a weak colouring not searched in print — owed
  handoff: de Bruijn — only with a consumer; two charts and the definition of the palette

derivation: C132-PLACED
  statement: At the four-label ring point `y` of C132-LENS (ii): in the grammar of C132-PLACE's list, the labels present in each of the six wedges at `y` cut by the unit circles about `x`, `y_1` and `y_{−1}`, and which labels of `T` the sides at `y` allow in the lens; then, using C132-WITNESS only on wedges the list forces to be of one label, which pairs of the four labels are witnessed edges at `y`, whether they close a four-cycle, and — if they do — what the first night's exclusion (C132-M-ORBIT in C132-WIT's four-point form) says on the orbit of `y`'s ring through `x`. Each line derived or marked open
  uses only: for the lines derived — C132-LENS and C132-LENS-FOUR; C132-WIT-SIDE at y; C132-WITNESS on the three outer wedges (inherited); C132-TURN-EDGE (inherited, [hand], one mind, its argument read and not reworked); C132-PLACED-RING
  not claimed: that the witnessed edges at y close a four-cycle, or that they do not; which labels fill the two inner wedges beside the lens; anything on an orbit of y's ring other than the one through x
  argument: § The list
  verdict: gap: whether any pair containing a label of T is a witnessed edge at y — the two inner wedges beside the lens are not forced to one label, and the closure of the lens meets the closures of the three outer wedges at y alone, so C132-WITNESS gives the path a – n – b and nothing through T
  grade: hand
  minds: 1
  model: none is known (as C132-LENS)
  prior art: partly: the sentence is the asking lane's (`plans/STUB-six-by-the-nerve.md` § The first claims a deriver takes)
  handoff: Poros — the list with its open line; the branch of the card's table that occurred is "a mixed ring"; the smallest open forms are under § The list

control: placed-arcs
  of: C132-PLACED-RING — the points y_0 + e(θ) just before the direction of y_1 and just after that of y_{−1}: outside the unit circle about x and about y_2 (y_{−2}), and the wedges at y_{±1} just inside and just outside the unit circle about y_0 there
  run: python3 ../data/fs132/e6/lens_checks.py ringarc
  expect: arc-points=400 outside-the-region=0 wedges=[(-1, 'in', 'O_ccw'), (-1, 'out', 'O_far'), (1, 'in', 'O_cw'), (1, 'out', 'O_far')]
  fault: python3 ../data/fs132/e6/lens_checks.py ringarc --fault

### Argument — the placed point's ring at its two neighbours

*Near `y_1`.* As in C132-LENS's first half, with the chart `Z(ψ_2 + t, d)`, `d < 0`: where `d < t < 0` the label is `a`; where
`t < d` the neighbours' palettes hold `n` (just before `ψ_2`) and `a` (at `ψ_0 + t − d`, just before `ψ_0`), so the label is
`b`. By (W), `t < 0` is "outside the unit circle about `y_2`" and the sign of `t − d` is the side of the unit circle about
`y_0`. So on `{w ∈ B(y_1, κ) : |w − x| > 1, |w − y_2| > 1}` the label is `b` inside the unit circle about `y_0` and `a`
outside it. *Near `y_{−1}`*, chart `Z(ψ_0 + t, d)`, `d < 0`: where `d < t < 0` the label is `b`; where `t > 0` the palettes
hold `b` (just after `ψ_0`) and `n` (just after `ψ_{−2}`), so the label is `a`; `t − d > 0` is "outside the unit circle about
`y_{−2}`" and the sign of `t` the side of the unit circle about `y_0`: `a` inside, `b` outside. *The palettes.* For `θ` in
`(ψ + 2π/3 − κ, ψ + 2π/3)` the point `y_0 + e(θ)` is `y_1` moved along the unit circle about `y_0` in the direction
`e(ψ + π/6)`, which has positive inner product with `e(ψ_1)` and with `y_1 − y_2 = e(ψ)`: it lies in the open region just
described, and for `θ` in a compact part of the arc a whole neighbourhood of fixed radius does. A typical point has density
one of its label, so in that region its label is `a` or `b`. For typical circle samplings `(y_m, r_m) → (y_0, 1)` and large
`m` the points `y_m + r_m e(θ)` are in the region, so the traces of the four other labels vanish there, and so do their
weak-* limits; the essential union defining the palette is one of null sets on the arc. The other arc is the mirror
image. ∎

### The list

At `y = y_0`, in the ring card's grammar; O and I wedges as the search names them.

- **PL1 — outside the ring: `O_cw = a`, `O_far = n`, `O_ccw = b`**, almost everywhere, each an open 60° wedge. *Derived*
  (C132-LENS-FOUR; the ring card's L4).
- **PL2 — the lens carries only labels of `T`.** *Derived* (C132-LENS).
- **PL3 — `I_ccw` carries `b` or labels of `T`; `I_cw` carries `a` or labels of `T`.** *Derived*: `I_ccw` is inside the unit
  circle about `y_1` (no `a`, no `n`), `I_cw` inside the one about `y_{−1}` (no `b`, no `n`) — C132-LENS's two halves.
  **Open**: which of the two occurs; nothing derived forces either wedge to one label.
- **PL4 — the labels of `T` the sides allow.** A label `t` of `T` has positive measure inside the ring near `y` only if
  neither of the two sets `K_j` whose pair holds `t` has a point strictly outside the unit circle about `y` (C132-WIT-SIDE).
  At most one set has such a point (C132-LENS-SIDE). If one has: inside the ring near `y` the one label of `T` is the label
  `t*` its pair does not hold, **the lens is `t*` almost everywhere**, `I_cw ⊂ {a, t*}`, `I_ccw ⊂ {b, t*}`. If none has: all
  three labels of `T` are allowed. *Derived.*
- **PL5 — witnessed edges at `y` from one-label wedges.** `{a, n}`, with a set on the unit circle about `y_{−1}` (the common
  side of `O_cw` and `O_far`), and `{n, b}`, with a set on the unit circle about `y_1` (C132-WITNESS; the ring card's l. 470).
  `{a, b}` is **not** a witnessed edge at `y` (C132-TURN-EDGE, whose hypotheses hold here). A pair containing a label of
  `T`: **open** — even when the lens is one label `t*`, its closure meets the closures of `O_cw`, `O_far`, `O_ccw` at `y`
  alone, and `I_cw`, `I_ccw` are not forced to one label. So what is given is the path `a – n – b`; **no four-cycle is
  closed.**
- **PL6 — the first night's exclusion on the orbit of `y`'s ring through `x`.** Its hypothesis asks, at all six points of an
  orbit, for palettes of `y` that hold one of the two labels outside the cycle. On the orbit through `x` two of the six
  points are `y_1` and `y_{−1}`, and on a one-sided neighbourhood of each the palette of `y` lies inside `{a, b}`
  (C132-PLACED-RING). **So the exclusion says nothing on that orbit, whatever cycle is witnessed at `y`.** *Derived.*

**What the placed point is, as far as derived.** A point with four labels present, three of them in open wedges outside
`x`'s ring; on its own unit circle, at `y_1` and at `y_{−1}`, an interface between `a` and `b` runs along that circle — `b`
inside and `a` outside at `y_1`, `a` inside and `b` outside at `y_{−1}` — and the point carries both labels. In the map
class's words: the centre of two unit arcs, each carrying both its side colours ((Q), row 135), **forced by the seed, with
every hypothesis derived from the centre's circle**. That is the card's second row: FS-124's first question — what a (Q)
ring passes to the vertices it places — has a measurable instance. The two arcs have opposite orientation.

**Smallest open forms.** (a) At the placed point, are `I_cw` and `I_ccw` of one label each, and which? (b) What does the
placed point's unit circle carry at `x`, at `y_0 + e(ψ ± π/3)` and at `2y_0 − x` — the four other points of the orbit?
(c) The same question one step on: `y_1` is outer-pure with an outer-pure neighbour `y_0` on one side only; what C132-LENS's
one half gives there is that the lens at `y_1` carries `b` or labels of `T`.

**Read off, not entered.** On the *alternating* ring `a, b, a, b, a, b` the far wedge at an outer-pure ring point is `n`
(the ring card's L5), so C132-SHADOW keeps `n` off the lens at each neighbour, where the transfer already keeps `a` and `b`
off: the lens there carries only `T`, and a neighbour of an outer-pure point is never inner-pure. That is C132-ALT's cases
O, I and I, O by a second route with no unit-pair shift — a check of two of that inherited entry's four cases, by different
mathematics; its cases O, O and I, I are not reached this way.

### Expectations scored

- C132-PLACED: "the exclusion does not apply on the orbit through `x`; the ring carries the point's own labels" (0.80) —
  **met**. "A four-cycle of witnessed edges forced closed" (0.10) — not forced; open.
- C132-ARC: "not reached" (0.60) — **met**.
- The asking lane's: C132-PLACED "a mixed ring" (0.55) — the branch that occurred; "the exclusion applies on an orbit"
  (0.25) — no, on the one orbit examined.

## Stage 3 — SAVED

## Where a successor takes over

- **C132-ARC**: untouched. Its control (R7's vertices and arcs by formula, `plans/FS111-derivation.md`) was not run. A tool
  it did not have when posed: C132-SHADOW — an open one-label piece on one side of a unit arc keeps its label off a whole
  side of a unit circle near every point at distance 1 from the piece's corner.
- **C132-LENS-II**: the sixteen patterns of § The gap in clause (ii).
- **C132-PLACED**: the open forms (a)–(c) above.
- **Not verified by me in what I inherit**: the proof of the release's Lemma 5.2 (the transfer inside C132-PLACE);
  C132-CONFINE (inside C132-TURN-EDGE, which only PL5's "`{a, b}` is not witnessed" uses); C132-WITNESS's argument (read,
  not reworked; only PL5 uses it — C132-LENS does not).

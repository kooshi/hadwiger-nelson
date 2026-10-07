# FS132-E6 — the seed card: what a point's unit circle forces in the balls about its ring points

*Ephodos, 2026-10-07 (UTC). Brief: `data/fs132/briefs/FS132-E6-seed-card.md`. Card: `plans/STUB-six-by-the-nerve.md` § The
question, re-posed after the second round. One mind throughout; every inherited entry is one mind's, hours old, and is named
where it is used. Scripts and outputs: `data/fs132/e6/`.*

## Theorems this phase proved

*(filled at each saved stage; addresses are sections of this file)*

- Stage 1 proved none: it states the claims.

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

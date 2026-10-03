# FS116-S1 — SAT-STRIP from both sides: a fresh mind on its stalled form (SAT-STRIP, Y-SAT)

*Ephodos (Opus 5.5), job FS116-S1, launched 2026-09-29 07:12 UTC, stopped at 07:42 UTC by an account halt with nothing committed, resumed
2026-10-03 14:36 UTC on the coordinator's message ("resume from where you stopped (your stage 1)"). Brief `data/fs116/briefs/FS116-S1-satstrip.md`,
with `plans/STANDING-RULES.md` as part of it (both read in full). Identity and procedure: `.claude/agents/ephodos.md` § A derivation job. Frozen
claims: `data/fs116/claims.md` (its § 0 definitions used verbatim; "valid fragment" is six-coloured unless `k` is named). I touch only this record,
`data/fs116/s1/`, `tools/fs116_s1_*.py` and `data/fs116/reports/FS116-S1.md`. Resuming check (standing rule 2): no record existed; the uncommitted
`data/fs116/s1/quotes*.out` and `tools/fs116_s1_quotes.py` are this job's and are re-run below. Grades are my identity's grammar (`hand` = [hand],
`derived from` = [derived], `computed over` = [tools]).*

**Notation** (FS116-N1's, `plans/FS116-N1-proof.md` header; nothing new is meant by it). `p` the vertex, put at the origin; `ω(z)` the unit circle
about `z`; `r(θ) = p + e(θ)` the ring point at angle `θ`; `C(z)` the colours of the tiles whose closure holds `z`; `P` the four colours of `p`;
`X, X̄` the two colours absent at `p`. **N-E1**: if `z` is an interior point of a tile of colour `c` and `|z − w| = 1` then `c ∉ C(w)`. **CL**
(non-Siamese): two tiles of one colour with points less than 1 apart are one tile. For the right-angled cross: `p`'s edges are segments along the
four half-axes, of lengths `L_E, L_N, L_W, L_S`; its tiles by quadrant `T_I, …, T_IV` with colours `c_I, …, c_IV`; the axis points
`q_E = (1, 0)`, `q_N = (0, 1)`, `q_W`, `q_S`.

## Theorems this phase proved

- *Stage 1:* FS116-S1-QT — the brief's two block quotations and its inline quotation are verbatim at their sources, its seven unquoted
  attributions present — computed over the three quotations (`tools/fs116_s1_quotes.py`), § 1.1. No mathematical theorem at this stage.

## Would-have-searched-here log (standing rule 5)

*The rule's text still names 2026-10-01 as the ban's end and is unchanged in the standing rules; I run no search regardless.*
- Stage 1: none (reading and recognition).

## Fence log (standing rule 8)

- My brief fences nothing. I write about my work only here, in `data/fs116/s1/`, in `tools/fs116_s1_*.py` and in my report, so nothing reaches
  FS116-V3 or FS121-V3. The harness's start-up context included the auto-memory index (status lines, no proof content). I read no session
  transcript. Read on resuming: `data/fs116/reports/FS116-N2.md` (N2's report, its STAR lemma bears below) and the close inventory's items 55–73.

## G87 lookout

- Stage 1: none seen as two truths in collision. One near-miss classed in § 1.3: FS116-Y1-STRIPCEIL (the strip's arches force the wedge above
  `V_{−1}`) and FS116-N1-AXIS (the axis structure) read as two different obstructions; they are one mechanism (§ 1.3, the recognition), a finding about
  description, not a collision.

## Stage 1 — SAVED: the readback, and recognition on both claims

### 1.1 Readback of the brief (standing rule 3)

`tools/fs116_s1_quotes.py` checks the brief's two block quotations against `data/fs116/claims.md` (whitespace, `> ` prefixes and backticks normalised,
nothing else), its inline quotation ("a geometry differing from the strip inside the unit disc, saturated on `B̄(p, 1)`") against
`data/fs116/reports/FS116-Y1.md`, and seven unquoted attributions for a phrase at their sources: **2 of 2, 1 of 1, 7 of 7**
(`data/fs116/s1/quotes.out`, exit 0). Self-test (`--selftest`, `quotes-selftest.out`): "segments" changed to "arcs" reads MISSING, the faithful twin
FOUND, the faithful quotation against the standing rules MISSING — PASS. By hand: the brief's "the capped strip cannot be saturated at radius 1" is
weaker than FS116-Y1-STRIPCEIL, which caps the saturation radius of every fragment agreeing with the strip on `B(P_0, 1)` below `0.491`: faithful. The
brief's "a fresh mind on that stalled form, not a fourth push" is N1's provisional drop (§ 4.3 there) in other words: faithful.

**My claims, restated beside the quotations.** SAT-STRIP: no valid six-coloured fragment on `B̄(p, 2)`, saturated on `B̄(p, 1)`, has at `p` a degree-4
vertex of four colours whose four edges are segments (any angles, Siamese pairs and (Q) arcs allowed). Y-SAT: a valid fragment on `B̄(p, R)` saturated
on `B̄(p, R − 1)` about a vertex of at least four colours, read with a geometry differing from the strip inside the unit disc, or a derived obstruction
at a named radius. The two are one question at `R = 2` about this vertex.

### 1.2 The plan and the inputs, read; the object unchanged since §G

Read in full at their sources: the plan § 4.1–4.7 and § 5.1; the frozen list in full, its § 9 controls and killing tests; FS116-N1 § 4 (4.0–4.5, the
entries); FS116-Y1 header, § 1.3, § 2; FS116-Y2 header, § 1.4, § 3; FS116-V1 § 2.3–2.5, § 4.2 (SATPIN's corrected wording: "edge" between two
different colours, "at least one of two types"; two minds); `plans/FS111-derivation.md` M-SATC, M-PINCH, M-C11, W-NOBEND, W-NOREP, W-SQ9, W-HEX9,
W-KB-DIR, W-LADDER, W-HEXSAT, M2-INTRAD, VM2-STRIP-MID; `plans/FS111-M-regularity.md` § 2.1–2.3; `plans/FS114-N6-proof.md` § 2.2 (N6-KAPPA, N6-WIN,
N6-RING60). On resuming: FS116-N2's report. The object is the one the plan's §G read (a four-colour vertex's ring, in the saturated class); no re-walk
of the grokkings is owed. N2's FS116-N2-STAR is the same observation as the colour exclusion at a ring point used in § 1.3 (a ring point `r(ψ)` cannot
carry the colours of `p`'s tiles in the directions `ψ ± 90°`, because `ω(r(ψ))` passes through `p` in those directions).

### 1.3 Recognition (`ephodos-recognition`, invoked fresh with the Skill tool)

**The stall.** N1 stalled three times on "exclude the cross's axis structure" and dropped provisionally; Y1 and Y2 found no family with a free
parameter meeting the demands. The stall's shape is "a wall describes what a counterexample must carry" (the touch point and the (Q)-fed change point):
the cue to ask what every solution carries, not to sharpen the axis types.

**For a stranger** (a discrete geometer who colours the plane avoiding distance 1, and a second reader from morphology): *An open set containing the
closed disc of radius 2 about the origin is cut by finitely many segments and circular arcs near each point into regions, each of one of six colours,
no two interior points of one colour exactly 1 apart; every boundary point within distance 1 of the origin is at distance exactly 1 from the closure of
each colour of positive density there. Four regions of four colours meet at the origin along four straight segments. Contradiction?* Words the reader
stops at: "(Q) arc", "touch point", "ring type" — costume, struck; "essential multicolour" — defined (the colours of positive density at the point).

**This is** a colouring of the unit circle `ω(p)` by the two absent colours — every point off the boundary carries one (FS116-N1-TWIST-D) — which is
forced to be a proper 2-colouring of the circle's own unit-distance graph (points `60°` apart), seen from every point of `B(p, 2)`: a point `z` with
`0 < |z| < 2` is at distance 1 from exactly two ring points, `r(φ ± arccos(|z|/2))`, `φ` the direction of `z`, and the colours there are excluded at `z`.
Where the two ring points carry different absent colours, `z` can carry only colours of `p`. So the ring's colouring decides, everywhere in `B(p, 2)`, where
`X` and `X̄` may lie; and the four straight edges' first rungs (SATPIN's tangent partners, one unit along each normal, carrying the far tile's colour —
`c_IV` above `q_N` on the east edge's side) must fit the colours the ring forces outside it.

**Features, sorted** (receipts named; derivations in stage 2):

| feature | sort | receipt |
|---|---|---|
| the ring's colouring by `X, X̄`, its change points | determines | the two-point exclusion consumes it at every point of `B(p, 2)`; the strip and F(1/5) read their axis types off it |
| the four edges' tangent partners (the first rung of each ladder) | determines | SATPIN; the collision below needs a rung of length above a computable bound |
| six colours | determines | spent where two ring points with different absent colours leave `z` only `P`; at `k = 9` (SQ9) five colours are absent and the exclusion of two leaves three |
| contacts of `p`'s colours on the ring from outside | determines | outside the ring in the open quadrant II only `c_IV` can touch the ring (the tile `T_c` of `p` must miss `B(w, 1)`) |
| the strip's arches | accompanies | FS116-Y1-STRIPCEIL used them only to force a `c_IV` tile at `r(120°)` from outside; any such contact does the same work |
| the axis points' types (touch or (Q)-fed change point) | accompanies | consequences of the ring's colouring at four angles; the kill reads the change points, not the axis points |
| right angles | unsorted | the partner points coincide in pairs at the axis points; the general cross has eight partner points |
| non-Siamese | unsorted | used below only to fix the ring's change set to `60°ℤ`-translates of one point (N6-WIN's step); the straddle itself needs no CL (the cluster lemma) |
| (Q) arcs on the ring | unsorted | a (Q) arc both feeds an axis change point and widens a contact; the strip shows both |

**Homes, each tested.**
1. *The project's ring theory* (N-E1, N6-KAPPA, TWIST-D, GERM-S, N2-STAR). Adopted for the ring's colouring. **It predicts a neighbour:** on a
   (Q)-free ring the colouring is defined on every germ and anti-periodic under `σ`, with no non-Siamese hypothesis and no bends (stage 2, KAPPA-G).
2. *Circle geometry: the two points of `ω(p)` at distance 1 from `z`* (the map `z ↦ {φ − α, φ + α}`, `α = arccos(|z|/2)`, a double cover of
   `B(p, 2) ∖ {p}` by chords). Its theorem here is elementary and decides where the absent colours may lie: on a (Q)-free non-Siamese ring with change
   points `y_k = r(ψ_1 + 60°k)` the unit disc splits into six thin lenses `B(y_{k−1}, 1) ∩ B(y_{k+1}, 1)` from `p` to `y_k` (only colours of `p`) and six
   concave triangles `p y_k y_{k+1}` (one absent colour each). The old proofs apply at once (GERM-S's 60° cones are the lenses' tips). Adopted.
3. *Mathematical morphology* (tangent partners, unit parallels: SATPIN, W-LADDER, M2-INTRAD). Adopted for the rungs; silent about colours.
4. *The interval argument lifted to connected families* (two tiles' distances form an interval). Adopted: a closure-connected family of tiles of one
   colour lies on one side of every other tile of that colour (stage 2, CLUSTER). It is what makes the straddle Siamese-proof.
5. *Graph theory (fall colourings, idomatic partitions)*: Y1's costume verdict stands; no theorem applies to the infinite-degree graph. Killed.

**The recognition, and where it differs from the plan.** SAT-STRIP is a collision between a rung and a contact: the east edge's tangent partner
carries `c_IV` along `y = 1` from `q_N` out to `(L_E, 1)`, while the ring forces a tile of `c_IV` against `ω(p)` from outside somewhere in quadrant II;
one connected family of `c_IV` tiles cannot be within distance below 1 of that tile at `q_N` and above 1 at `(L_E, 1)`. FS116-Y1-STRIPCEIL is this
collision's instance at the contact `r(120°)` (`L_E = 1/2 > 0.491`); the plan's axis types are its symptoms. The kill therefore reads two numbers per
quadrant — how far the ring forces a rung to reach (a lower bound from the two-point exclusion), and where the ring forces a contact (an upper bound
from the straddle) — and the six-colour step is the two-point exclusion. This differs from the plan's frame (§ 4.3: "follow a ring's placements
outward to a straddle"): the straddle is between a placement and a rung of `p`'s own ladder, inside radius 2, not along a chain of placed vertices.
Reported to the coordinator as a finding.

derivation: FS116-S1-QT
  statement: the brief's two block quotations (SAT-STRIP, Y-SAT) are verbatim in data/fs116/claims.md, its inline quotation is verbatim in
    data/fs116/reports/FS116-Y1.md, and its seven unquoted attributions each have their named phrase at their sources
  uses only: string containment after normalising whitespace, the brief's quotation prefixes and backticks
  not claimed: that the attributions' paraphrases are faithful (read by hand, § 1.1); anything about the statements' truth
  argument: § 1.1 Readback of the brief (standing rule 3)
  verdict: derived
  grade: computed over: the brief's three quotations and seven attributions
  minds: 1
  model: the brief itself
  prior art: known: a readback, no mathematics
  handoff: none — a bookkeeping check on a brief

control: fs116-s1-quotes
  of: FS116-S1-QT — every quotation found; with one word of the SAT-STRIP quotation altered the check reports it missing
  run: python3 ../tools/fs116_s1_quotes.py --line
  expect: block quotations 2 found True; inline 1 found True; attributions 7 present True
  fault: python3 ../tools/fs116_s1_quotes.py --line --plant

## Stage 1 — SAVED

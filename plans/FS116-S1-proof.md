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
- *Stage 2:*
- **FS116-S1-KAPPA** — on a (Q)-free ring at a four-colour vertex every germ carries exactly one absent colour, flipped 60° on; change points
  60°-invariant, odd per window, antipodes opposite; exactly `y + 60°ℤ` when non-Siamese; Siamese pairs allowed, no bends — [hand], one mind, § 2.1.
- **FS116-S1-PAIR** — the two ring points at distance 1 from `z` exclude their colours at `z`; where they differ only `p`'s colours remain —
  [derived], one mind, § 2.2.
- **FS116-S1-CLUSTER** — a closure-connected family of one colour is within distance 1 of a tile of that colour as soon as one point is — [hand],
  one mind, § 2.3.
- **FS116-S1-RUNG** — a `c_IV` contact within 1 of `q_N` caps the east edge's saturated length by `|w − (ℓ, 1)| ≤ 1`; STRIPCEIL is its instance at
  `r(120°)` — [derived], one mind, § 2.3.
- **FS116-S1-LENS** — in the (Q)-free non-Siamese right-angled class the lens about the east edge carries only `T_I`, `T_IV`, with the contacts at
  `c_+ + 60°`, `c_− − 60°` — [derived], one mind, § 2.4.
- **FS116-S1-EXIT** — a curve leaving the lens with both partners in their discs has a partner at a lens centre — [hand; identities tools-exact], one
  mind, § 2.4.
- **FS116-S1-QF** — **SAT-STRIP holds for right angles, (Q)-free rings and non-Siamese fragments** — [derived], one mind, § 2.5.
- **SAT-STRIP** — GAP, narrowed to rings with (Q) arcs, Siamese fragments, crosses not at right angles, § 2.5. **Y-SAT** — no construction; the
  obstruction QF in its class, § 2.5.

## Would-have-searched-here log (standing rule 5)

*The rule's text still names 2026-10-01 as the ban's end and is unchanged in the standing rules; I run no search regardless.*
- Stage 1: none (reading and recognition).
- Stage 2: (a) I would have searched curves with `|κ| ≤ 1` for one that leaves the edge's lens with its partners in their discs; instead I ran a
  discretised reachable-set exploration of the derived constraints (`tools/fs116_s1_reach.py`: no colouring, no fragment, no solver), saw that the only
  meeting with the side was tangential, and derived FS116-S1-EXIT, which the exploration does not enter. (b) I would have searched ring colourings
  for a (Q)-free one beating the lens; instead KAPPA fixes them.

## Fence log (standing rule 8)

- My brief fences nothing. I write about my work only here, in `data/fs116/s1/`, in `tools/fs116_s1_*.py` and in my report, so nothing reaches
  FS116-V3 or FS121-V3. The harness's start-up context included the auto-memory index (status lines, no proof content). I read no session
  transcript. Read on resuming: `data/fs116/reports/FS116-N2.md` (N2's report, its STAR lemma bears below) and the close inventory's items 55–73.

## G87 lookout

- Stage 2: none seen as a collision. Classed: RUNG's cap and the strip's L_E = 1/2 collide only because the strip keeps its arches; that is
  STRIPCEIL's content restated, not two truths.
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

## Stage 2 — SAVED: the ring's colouring, the two-point exclusion, clusters and the rung; SAT-STRIP in the (Q)-free non-Siamese class

*Frame: the right-angled cross of § 1's notation, `p = 0`, `e(θ)` the unit vector at angle `θ`, `y_θ` written `r(θ)`. A* **germ** *of `ω(p)` at
`θ` is the arc `(θ, θ + δ)` or `(θ − δ, θ)` of `ω(p)` for small `δ`; by local finiteness it lies in one tile or in one arc of `Γ` on `ω(p)`.*

### 2.1 The ring's colouring on a (Q)-free ring (FS116-S1-KAPPA)

Let `K(g)` be the set of absent colours among the colours of the tiles whose closure holds the whole germ `g`. *(a) `K(g) ≠ ∅`.* A germ off `Γ`
lies in one tile, whose colour is not `p`'s (N-E1 at `p`, which is at distance 1). A germ on an arc of `Γ` on `ω(p)` has two side tiles; if both side
colours were `p`'s, the arc would be (Q) (its centre `p` carries both side colours and at least four colours), which the ring does not carry. *(b)
`K(θ^+) ∩ K((θ + 60°)^+) = ∅`, and the same for `θ^−`.* Let `X ∈ K(θ^+)` through a tile `T`, and `w = r(θ + 60° + ε)` a point of the germ
`(θ + 60°)^+`. `ω(w)` meets `ω(p)` at `r(θ + ε)` and crosses it there transversally (two unit circles whose centres are 1 apart meet at 60°), so it holds
interior points of `T` — `r(θ + ε)` itself if the germ is off `Γ`, points on `T`'s side if it lies on an arc of `Γ`. By N-E1, `X ∉ C(w)`. *(c)* With
two absent colours, (a) and (b) force every `K(g)` to be a singleton `{κ(g)}` and `κ((θ + 60°)^±)` to be the other absent colour. So `κ(θ^±)` at
`θ + 180°` is the other colour too. A change point is a `θ` with `κ(θ^−) ≠ κ(θ^+)`. Away from the finitely many ring points where `Γ ∩ ω(p)` is neither
empty nor an open arc of `ω(p)`, the two germs at a point lie in one tile or on one arc, so change points are finitely many. They are invariant under
`θ ↦ θ + 60°` by (c), and `κ` flips across every half-open 60° window, so each window holds an odd number of them. *(d) Non-Siamese.* Let `y` be a
change point, `κ = Ā` just clockwise and `A` just counter-clockwise, and suppose `y′` is the next change point in `(y, y + 60°)`. The `Ā`-tiles holding
the germs `y^−` and `y′^+`, and the germ `(y + 60°)^+` (whose `κ` is `κ̄(y^+) = Ā`), have points pairwise less than 1 apart, so they are one tile
(CL). That tile has closure points near `r(y − δ)` and `r(y + 60° + δ)`, more than 1 apart. A tile has diameter at most 1, a contradiction. ∎

*Six colours are spent at (c)*: with three or more absent colours `K` need not be a singleton. At `k = 9` the step fails on a held object. In
FS111-W-SQ9 about a grid point, `r(45°)` and `r(225°)` both lie in squares of colour `(1, 1)`, so the antipodal clause is false there (control
`sq9-antipode`), while N-E1's clause (`r(45°)`, `r(105°)` differ) holds.

### 2.2 The two-point exclusion (FS116-S1-PAIR)

For `0 < |z| < 2` let `φ` be the direction of `z` and `α = arccos(|z|/2)`. The two ring points at distance 1 from `z` are `r(φ ± α)`, and `θ ↦ θ ± α`
are continuous and open in `z`. Suppose a tile `T` of colour `κ(φ + α)` has `z` in its closure, `φ + α` not a change point. Then `T` has an interior
point `z′` near `z` whose ring point `θ′ = φ′ + α′` lies in the same cell and off the finite exceptional set: `r(θ′)` is an interior point of a tile
of colour `κ(θ′) = κ(φ + α)`, or lies on an arc of `Γ` on `ω(p)` with a side tile of that colour, which `ω(z′)` enters transversally. Either way, `T`
has an interior point at distance exactly 1 from an interior point of its own colour: invalid. ∎ **So where the two ring points lie in cells of
different colours, `z` carries colours of `p` only.** The plan's map of `B(p, 2)` follows. On a non-Siamese (Q)-free ring with change points
`y_k = r(ψ + 60°k)`, the unit disc is six thin lenses `B(y_{k−1}, 1) ∩ B(y_{k+1}, 1)` from `p` to `y_k`, which carry only colours of `p`, and six
concave triangles `p y_k y_{k+1}`, each carrying the colour of its ring cell and colours of `p`. The lenses' tips at `y_k` are GERM-S (i)'s 60° cones.

### 2.3 Clusters (FS116-S1-CLUSTER) and the rung (FS116-S1-RUNG); STRIPCEIL recovered

**CLUSTER.** *Argument.* Two tiles of one colour have distances forming an interval (the image of a connected product) that avoids 1. So each `T ∈ 𝒯`
other than `U` is *near* `U` (all distances below 1) or *far* (all above 1). Let `N` be the union of `cl U` (if `U ∈ 𝒯`) and the near tiles' closures,
and `F` the far tiles' closures. Both are closed (finite unions), and `N ∪ F` is the connected union. If both were non-empty, a point `x ∈ N ∩ F` would
be either in a near and a far closure, so at distance exactly 1 from every point of the open set `U`, which is impossible; or in `cl U` and a far
closure, where interior points of `U` and of the far tile lie arbitrarily close, which is impossible too. The hypothesis' point at distance below 1 lies
in a near closure or in `cl U`. So `F = ∅`. Near tiles' closures lie within 1 of `cl U`, and `cl U` has diameter at most 1. ∎

**RUNG.** SATPIN in its corrected wording (FS116-V1, two minds): a segment edge is not a unit arc, so the east edge is of the tangent type. Every
`(s, 1)`, `0 < s < ℓ`, lies in the closure of a tile of colour `c_IV`. The finitely many `c_IV` tiles whose closures meet `[0, ℓ] × {1}` have a
connected union of closures containing that segment and `q_N`. CLUSTER with `U`, `a` a point `(s, 1)` near `q_N`, and `u = w`, gives the claim. ∎ The same
holds at the other three axis points, turned with the quadrants, and for the west edge at `q_N` with `c_III` (reflected).

**FS116-Y1-STRIPCEIL is RUNG's instance.** In any fragment with a tile of colour `c_IV` holding `V_{−1} = r(120°)` in its closure, saturation on the east
edge's first `ℓ` forces `|V_{−1} − (ℓ, 1)| ≤ 1`, i.e. `ℓ ≤ x* = √(√3 − 3/4) − 1/2 ≈ 0.49098` (control `rung-ceil`, exact). STRIPCEIL used the strip's arches
only to put `D_0`'s colour on the wedge above `V_{−1}`; any `c_IV` contact there does the same, and a contact at `r(φ)`, `90° < φ < 150°`, caps `ℓ` at
`g(φ) = cos φ + √(sin φ (2 − sin φ))`, from 1 at `90°` to 0 at `150°`. F(1/5) (`ℓ = 1/5`) is inside the cap. Its `M*` and the tile over `V_{−1}` are a
near pair, which is CLUSTER's model.

### 2.4 The two-tile lens about the east edge (FS116-S1-LENS) and the exit (FS116-S1-EXIT)

**LENS.** *Argument.* No change point is an axis point: at `q_N`, GERM-S (i) (its germs lie on no (Q) arc) would put the inward 60° cone in tiles of a
colour of `p`, and AXIS (a) (two minds, FS116-V3) gives that cone only absent colours. The window `(−90°, −30°]` holds an odd number of change points,
so `c_−` exists and lies in `(−90°, −30°)`; the window `(30°, 90°)` gives `c_+`. For `z ∈ Λ` the open arc of ring points within distance 1 of `z` has
length `2α < 180°` and holds `y_−` and `y_+`. The change point after `c_+` is `c_− + 180°` and the one before `c_−` is `c_+ − 180°` (by
60°-invariance, with none on the axes), both `180°` from the arc's points `c_−`, `c_+`; so the arc holds exactly the change points of `[c_−, c_+]`, those of
the open window `(−90°, 90°)`, three half-open windows' worth: an odd number. So the arc's two ends lie
in cells of different colours, and PAIR leaves only colours of `p` at `z`. GERM-S (ii) at `y_−` (open quadrant IV) gives an outward tile of a colour
whose tile of `p` lies in the closed half-plane facing away. Only `T_II`'s cone fits, so `T_II ∩ B(y_−, 1) = ∅`; at `y_+`, `T_III ∩ B(y_+, 1) = ∅`. In a
non-Siamese fragment a tile of colour `c_II` meeting `Λ ⊂ B(p, 1)` is `T_II` (CL), which misses `B(y_−, 1) ⊃ Λ`; likewise for `c_III`. Of colours
`c_I`, `c_IV`, only `T_I` and `T_IV` meet `Λ` (CL). The contacts follow the same way: GERM-S (ii) at `y_3` (open quadrant II, since
`c_+ + 60° ∈ (90°, 150°)`) and at `y_5` (open quadrant III). Then `|q_N − y_3| = 2 sin((c_+ − 30°)/2) < 1` and `|q_S − y_5| = 2 sin(|c_− + 30°|/2) < 1`, the angles
between them being `c_+ − 30° ∈ (0°, 60°)` and `|c_− + 30°| < 60°`. ∎

**EXIT.** *Argument.* Let `x_e = γ(t_e)`. *On `ω(y_b)`* (the tip `y_a + y_b` included): `|γ − y_b|²` is below 1 before `t_e` and equals 1 at `t_e`, so its
left derivative is `≥ 0`: `T(t_e) · (x_e − y_b) ≥ 0`. Write `x_e = y_b + e(φ)`, `φ ∈ (b + 180°, a + 360°]`, and `τ = φ + 90°` (the side's direction away
from 0). The exit condition is `β_e ∈ [τ − 180°, τ]`. The set of headings `β` with `x_e + e(β + 90°) ∈ B̄(y_3, 1)` is a closed arc of length at most `120°`,
because `|x_e − y_3| ≥ 1`. At `β = τ`, `ν = −e(φ)` and `P = y_b`, which lies on `ω(y_3)`. So `τ` is an end of the arc, and
`d|P − y_3|²/dβ` at `τ` equals `−2 cos(φ − b + 150°)` (control `exit-identities`, symbolic). Here `φ − b ∈ (180°, 300°)` since `a − b < −60°`, so the
derivative is negative and the arc is `[τ, τ + w]`, `w ≤ 120°`. The two sets meet only at `τ`: `P = y_b`. *On the open arc of `ω(y_a)`*: the mirror.
`x_e = y_a + e(g)`, `g ∈ (b, a + 180°)`, `τ′ = g − 90°`; exit forces `β_e ∈ [τ′, τ′ + 180°]`. `Q = y_a` at `τ′`, `|y_a − y_5| = 1`,
`d|Q − y_5|²/dβ = 2 cos(g − a − 150°) > 0` because `g − a ∈ (60°, 180°)`. So the feasible arc is `[τ′ − w′, τ′]` and `Q = y_a`. ∎

### 2.5 SAT-STRIP in the (Q)-free non-Siamese class (FS116-S1-QF)

*Argument.* Suppose the fragment exists. LENS gives `c_±`, `Λ`, `y_3`, `y_5`, the contacts `U_3` (colour `c_IV`) and `U_5` (colour `c_I`), and
`Λ ⊂ cl(T_I ∪ T_IV)`.
- *The interface is a curve that must leave `Λ`.* At a point of `Γ ∩ Λ` the sectors belong to `T_I` or `T_IV`. They cannot alternate
  `T_I, T_IV, T_I, T_IV`: a path in `T_I` joining two of its sectors closes, through the point, into a Jordan curve separating two sectors of the connected
  `T_IV`. So `∂T_I ∩ ∂T_IV ∩ Λ` passes through each of its points as one arc. At each such point (H1) and (H2) hold (two colours, each one connected set
  near the point), and the point is saturated (`Λ ⊂ B(p, 1)`). So W-NOBEND forbids a corner, and SATPIN's open-and-closed argument keeps the tangent type of
  the east edge along the whole component `γ` of the east edge. `γ` cannot end in `Λ` and cannot return to `p` (`p` has one `T_I | T_IV` edge). It is a
  finite chain of segments and arcs (local finiteness on `cl Λ`), so it reaches `∂Λ ∖ {p}` at a first point `x_e = γ(t_e)`, `C¹` up to it.
- *Its partners.* On `[0, t_e)`, `P = γ + ν` lies in the closure of colour `c_IV` and `Q = γ − ν` in that of `c_I`. These are FS116-V1's L1 "out"
  partners: the tile at `P` is far from `T_IV`, so `dist(P, T_IV) ≥ 1`, and `dist(Q, T_I) ≥ 1`. CLUSTER along the connected curves `P([0, t])` and
  `Q([0, t])`, which start at `q_N` and `q_S`, against `U_3` and `U_5` gives `|P − y_3| ≤ 1` and `|Q − y_5| ≤ 1`. From `γ ⊂ cl T_IV ∩ cl T_I` and GERM-S
  (ii): `|γ − y_3| ≥ 1` and `|γ − y_5| ≥ 1`. All of these pass to `t_e` by continuity.
- *The kill.* EXIT gives `P(t_e) = y_+` or `Q(t_e) = y_−`. But `T_IV` holds `(s, −s²)` for small `s > 0`, at distance `1 − 2s cos c_+ + O(s²) < 1`
  from `y_+` (`cos c_+ > 0`), and `T_I` holds `(s, s²)`, within `1 − 2s cos c_− + O(s²) < 1` of `y_−`. Either way a `dist ≥ 1` fails. ∎

**Where it fails on the controls (the killing tests carried).**
- *SQ9 at `k = 9`* has every hypothesis but six colours: grid point, right angles, (Q)-free ring (it meets `Γ` in finitely many points), non-Siamese,
  saturated. It fails at KAPPA (c), where six is spent (control `sq9-antipode`).
- *R7 and the slack hexagonal 7-colouring* have no four-segment degree-4 vertex. At `k = 7`, KAPPA (c) fails with three absent colours.
- *The capped strip and F(1/5)* carry four (Q) arcs on the midline ring, outside the class. The route meets them at KAPPA: `κ` is undefined on (Q) arcs.
  The quadrant-II contact is then the outer tile of a (Q) arc (at `104.48°`–`120°`), not a change point 60° beyond the lens's side centre. RUNG still
  kills the strip itself (STRIPCEIL's bound).
- *The plane beyond them is spent* (C-BEYOND) only at the partners `P`, `Q` and the contacts just outside `ω(p)`, inside `B̄(p, 2)`.

**Exploration, recorded (not a control).** Before EXIT was found, a discretised reachable set of curves with `|κ| ≤ 1` under the two cluster
constraints alone (`tools/fs116_s1_reach.py`, `data/fs116/s1/reach.out`) never left `Λ` at `ψ = 15°` (largest `|γ|` 0.496, angular margin 2.85° to the
lower side). A coarser run at `ψ = 29°` met the side once, at the side's own tangent heading. EXIT says this is the only way to meet it, and the far
partners kill that meeting.

**Verdicts.**
- **SAT-STRIP: GAP**, narrower than round 1's. It is TRUE in the class "right angles, ring carrying no (Q) arc, non-Siamese" (FS116-S1-QF). This kills
  the touch point of N1's stalled form in that class: there every axis point is one.
- Left open:
  - **(G1)** rings with (Q) arcs — N1's (Q)-fed change point and the strip-like class. KAPPA's 60° rule breaks on (Q) arcs, and the quadrant-II contact
    need not sit 60° beyond the lens's side centre.
  - **(G2)** Siamese fragments with (Q)-free rings. Two named steps: a `c_II` or `c_III` tile Siamese-near `T_II` or `T_III` inside `Λ`; and a vertex of
    `γ` with four sectors of two colours, where the partner curves may jump. KAPPA, PAIR, CLUSTER, RUNG and EXIT hold with Siamese pairs.
  - **(G3)** crosses not at right angles.
- **Y-SAT: not landed as a construction.** A derived obstruction at `R = 2` in FS116-S1-QF's class. The construction side's target is now a ring with
  a (Q) arc (G1), or a Siamese pair inside the edge's lens (G2).
- **P1** (SAT-STRIP TRUE, 0.55) is not scored.

derivation: FS116-S1-KAPPA
  statement: at a vertex p of four colours and no more of a valid fragment on a closed disc of radius above 1 about p, Siamese pairs allowed, whose
    ring carries no (Q) arc, every germ of ω(p) (an arc just clockwise or just counter-clockwise of a ring point) lies in the closure of tiles of
    exactly one colour absent at p, κ, and the germ 60° on carries the other; so κ's change points form a finite non-empty set invariant under the
    rotation by 60° about p, each half-open 60° window of ω(p) holds an odd number of them, and antipodal germs carry different colours; in a
    non-Siamese fragment the change points are exactly y + 60°ℤ for one ring point y
  uses only: N-E1; local finiteness (a germ lies in one tile or on one arc of Γ on ω(p)); the definition of a (Q) arc; that ω(w) crosses ω(p)
    transversally at the ring points 60° from w; two absent colours, spent once, at (c); CL and a tile's diameter at most 1, for the last clause only
  not claimed: anything when the ring carries a (Q) arc; anything at k ≥ 7 (at k = 9 SQ9's r(45°) and r(225°) carry one colour); that any vertex of
    the class exists at six colours
  argument: § 2.1 The ring's colouring on a (Q)-free ring (FS116-S1-KAPPA)
  verdict: derived
  grade: hand
  minds: 1
  model: SQ9 at k = 9 about a grid point satisfies every hypothesis but the colour count, and its N-E1 clause holds while its antipodal clause fails —
    control sq9-antipode; no vertex of the class is held at six colours (as FS116-N1 and FS116-N2 report)
  prior art: partly: FS114-N6-KAPPA and FS114-N6-RING60 (non-Siamese, after FS-112's bends), RING-TWIST-C (qualifying windows only); this form's search
    is owed
  handoff: de Bruijn — with N-E1 and the germ convention; queued behind D6's map type

control: sq9-antipode
  of: FS116-S1-KAPPA — at k = 9 the antipodal clause fails in SQ9 (r(45°) and r(225°) both colour (1, 1)) while r(45°), r(105°) differ; reading
    r(255°) for r(225°) gives a different colour
  run: python3 ../tools/fs116_s1_check.py sq9
  expect: SQ9 k=9: r(45)=(1, 1) r(225)=(1, 1) same True; r(105)=(2, 1) differs from r(45) True
  fault: python3 ../tools/fs116_s1_check.py sq9 --plant

derivation: FS116-S1-PAIR
  statement: in a valid fragment as in FS116-S1-KAPPA, let z be a point with 0 < |z − p| < 2, φ its direction from p and α = arccos(|z − p|/2), so
    that r(φ + α) and r(φ − α) are the ring points at distance 1 from z; if neither φ + α nor φ − α is a change point, no tile of colour κ(φ + α) or
    κ(φ − α) has z in its closure; in particular where κ(φ + α) ≠ κ(φ − α) only colours of p are carried at z
  uses only: FS116-S1-KAPPA; N-E1 at an interior point z′ of a hypothetical tile near z, whose ring points lie in the same cells and off the finite
    exceptional set (z ↦ φ ± α is continuous and open); that ω(z′) crosses ω(p) transversally for 0 < |z′ − p| < 2
  not claimed: anything at a point whose ring point is a change point; which colours of p are carried
  argument: § 2.2 The two-point exclusion (FS116-S1-PAIR)
  verdict: derived
  grade: derived from: FS116-S1-KAPPA
  minds: 1
  model: SQ9 at k = 9 shows the contrapositive's content: there the two ring points' colours exclude two of five absent colours and leave three; no
    six-colour model is held
  prior art: owed: the two points of a circle at a given distance from a point are classical; its use as a colour map of B(p, 2) not searched
  handoff: de Bruijn — with FS116-S1-KAPPA

derivation: FS116-S1-CLUSTER
  statement: in a valid k-coloured fragment, for any k, Siamese pairs allowed, let 𝒯 be a finite family of tiles of one colour c the union of whose
    closures is connected, and U a tile of colour c; if some point of that union is at distance below 1 from some point of cl U, every point of the
    union is at distance at most 1 from every point of cl U
  uses only: validity; tiles are open and connected; the distances between two tiles form an interval; no point is at distance exactly 1 from every
    point of an open set
  not claimed: anything for an infinite family; that the tiles of 𝒯 are pairwise near
  argument: § 2.3 Clusters (FS116-S1-CLUSTER) and the rung (FS116-S1-RUNG); STRIPCEIL recovered
  verdict: derived
  grade: hand
  minds: 1
  model: F(1/5) (FS116-Y1-F15): its M* and the tile over V_{−1}, both of D_0's colour, within distance below 1 near (1/5, 1) and V_{−1}, and near
    throughout — control rung-ceil reads 1/5 inside the cap
  prior art: owed (an interval argument lifted to a connected family; the search is in the words of distance graphs of connected sets)
  handoff: de Bruijn — a short lemma on connected families of open sets; it crosses with RUNG

derivation: FS116-S1-RUNG
  statement: let p be a degree-4 vertex of four colours of a valid fragment whose four edges are segments along the four half-axes, with tiles coloured
    c_I, c_II, c_III, c_IV by quadrant, and suppose the fragment saturated at every point of the east edge's first segment [p, p + (ℓ, 0)], 0 < ℓ ≤ L_E;
    if a tile of colour c_IV has a point w in its closure with |w − q_N| < 1, q_N = p + (0, 1), then |w − p − (s, 1)| ≤ 1 for every s in [0, ℓ]; and the
    same at each edge and axis point, turned and reflected with the quadrants; in particular a contact of c_IV at r(φ), 90° < φ < 150°, gives
    ℓ ≤ cos φ + √(sin φ (2 − sin φ)), which at φ = 120° is FS116-Y1-STRIPCEIL's x* = √(√3 − 3/4) − 1/2
  uses only: FS116-O1-SATPIN in FS116-V1's corrected wording (two minds: the edge is of tangent type, so (s, 1) lies in the closure of colour c_IV);
    local finiteness; FS116-S1-CLUSTER
  not claimed: anything at a partner point where the edge is not saturated; anything for edges that are not segments; that a contact exists in
    quadrant II in any fragment of SAT-STRIP's class (FS116-S1-LENS supplies one where the ring carries no (Q) arc)
  argument: § 2.3 Clusters (FS116-S1-CLUSTER) and the rung (FS116-S1-RUNG); STRIPCEIL recovered
  verdict: derived
  grade: derived from: FS116-O1-SATPIN, FS116-S1-CLUSTER
  minds: 1
  model: F(1/5): ℓ = 1/5 and the contact V_{−1} = r(120°), with |V_{−1} − (1/5, 1)| < 1 — control rung-ceil
  prior art: partly: FS116-Y1-STRIPCEIL is its instance at r(120°) for fragments keeping the strip in B(P_0, 1); the general form's search is owed
  handoff: de Bruijn — with SATPIN; a rung-and-contact lemma

control: rung-ceil
  of: FS116-S1-RUNG — the cap at the contact r(120°) is exactly x* = √(√3 − 3/4) − 1/2, F(1/5)'s 1/5 lies inside it and the strip's 1/2 outside; with
    the contact moved to r(110°) the exact identity fails
  run: python3 ../tools/fs116_s1_check.py ceil
  expect: RUNG-CEIL: |V-(x*,1)|=1 True; 1/5 inside True; 1/2 outside True; x*=0.49098477
  fault: python3 ../tools/fs116_s1_check.py ceil --plant

derivation: FS116-S1-LENS
  statement: let p be a degree-4 vertex of four colours of a non-Siamese valid fragment on a closed disc of radius above 1 about p whose four edges are
    segments along the four half-axes and whose ring carries no (Q) arc; then no change point of κ lies on an axis; the least change point c_− and the
    greatest c_+ in (−90°, 90°) satisfy −90° < c_− < −30° and 30° < c_+ < 90°; the open lens Λ = B(r(c_−), 1) ∩ B(r(c_+), 1) meets no tile but T_I and
    T_IV; and r(c_+ + 60°) and r(c_− − 60°) are change points in the open quadrants II and III at distance below 1 from q_N and q_S, each holding in its
    closure an outward tile, of colour c_IV and c_I, while T_IV misses B(r(c_+ + 60°), 1) and T_I misses B(r(c_− − 60°), 1)
  uses only: FS116-S1-KAPPA; FS116-S1-PAIR; FS116-N1-GERM-S (i), (ii) (two minds, FS116-V3) at change points, whose germs lie on no (Q) arc;
    FS116-N1-AXIS (a) (two minds, FS116-V3); CL; that a tile of p in B̄(y, 1), or missing B(y, 1), has its cone in the closed half-plane facing y, or
    facing away
  not claimed: rings with (Q) arcs; Siamese fragments (a tile Siamese-near T_II or T_III may meet Λ); crosses not at right angles; saturation is not
    used
  argument: § 2.4 The two-tile lens about the east edge (FS116-S1-LENS) and the exit (FS116-S1-EXIT)
  verdict: derived
  grade: derived from: FS116-S1-KAPPA, FS116-S1-PAIR, FS116-N1-GERM-S, FS116-N1-AXIS
  minds: 1
  model: SQ9 at k = 9 meets every hypothesis but six colours, and there the lens about its east edge meets squares of five colours — the step that
    fails is KAPPA (c), control sq9-antipode
  prior art: owed
  handoff: de Bruijn — with KAPPA, PAIR and GERM-S; queued behind D6's map type

derivation: FS116-S1-EXIT
  statement: let 30° < b < 90° and −90° < a < −30°, y_b = e(b), y_a = e(a), y_3 = e(b + 60°), y_5 = e(a − 60°) and Λ = B(y_a, 1) ∩ B(y_b, 1); let γ on
    [0, t_e] be a C¹ curve with γ(0) = 0, γ(t) in Λ for 0 < t < t_e and γ(t_e) in ∂Λ other than 0, with left unit normal ν; if at t_e
    |γ + ν − y_3| ≤ 1, |γ − ν − y_5| ≤ 1, |γ − y_3| ≥ 1 and |γ − y_5| ≥ 1, then γ(t_e) + ν(t_e) = y_b or γ(t_e) − ν(t_e) = y_a
  uses only: the left derivative of |γ − y_b|² (or |γ − y_a|²) at the first exit, which is non-negative; that the headings putting γ + ν in B̄(y_3, 1)
    form an arc of length at most 120° when |γ − y_3| ≥ 1; the identities P = y_b at the side's tangent heading, |y_b − y_3| = 1 and
    d|P − y_3|²/dβ = −2 cos(φ − b + 150°) there, with their mirrors for Q, checked symbolically; the signs on b − a > 60°
  not claimed: anything about colourings (it is a lemma on curves and four points); that such a curve exists
  argument: § 2.4 The two-tile lens about the east edge (FS116-S1-LENS) and the exit (FS116-S1-EXIT)
  verdict: derived
  grade: hand
  minds: 1
  model: the reach exploration at ψ = 29° (tools/fs116_s1_reach.py, coarse run): its one meeting with the side was at the side's tangent heading, as
    EXIT predicts; the identities are control exit-identities
  prior art: owed (a two-disc exit lemma for curves with unit normals)
  handoff: de Bruijn — an elementary plane-geometry lemma; mechanical

control: exit-identities
  of: FS116-S1-EXIT — the six identities hold symbolically and the derivatives have the derived signs at 3,675 rational points a side; with y_3 put at
    e(b − 60°) the derivative identity fails and the lower sign flips
  run: python3 ../tools/fs116_s1_check.py exit
  expect: EXIT: P=y_b True; |y_b-y_3|=1 True; dP-form True; Q=y_a True; |y_a-y_5|=1 True; dQ-form True; lower d<0 at 3675/3675; upper d>0 at
    3675/3675
  fault: python3 ../tools/fs116_s1_check.py exit --plant

derivation: FS116-S1-QF
  statement: no non-Siamese valid fragment on B̄(p, 2), saturated on B̄(p, 1), whose ring ω(p) carries no (Q) arc, has at p a degree-4 vertex of four
    colours whose four edges are segments at right angles
  uses only: FS116-S1-LENS; FS116-S1-EXIT; FS116-S1-CLUSTER; FS116-O1-SATPIN in FS116-V1's wording and V1's L1 (the tangent partners are "out", so
    far from the tile they face); FS111-W-NOBEND and SATPIN's open-and-closed step along the interface (saturation on Λ ⊂ B(p, 1)); the Jordan curve
    theorem (two tiles cannot alternate four times about a point); local finiteness; that T_IV and T_I hold points near p within distance below 1 of
    r(c_+) and r(c_−)
  not claimed: SAT-STRIP itself (rings with (Q) arcs, Siamese fragments, crosses not at right angles stay open: § 2.5's G1–G3); anything at k ≥ 7 (at
    k = 9 SQ9 meets every other hypothesis); that the class is non-empty at six colours without the cross
  argument: § 2.5 SAT-STRIP in the (Q)-free non-Siamese class (FS116-S1-QF)
  verdict: derived
  grade: derived from: FS116-S1-LENS, FS116-S1-EXIT, FS116-S1-CLUSTER, FS116-O1-SATPIN
  minds: 1
  model: SQ9 at k = 9, which holds the configuration with every hypothesis but six colours — where the argument fails at KAPPA (c), control
    sq9-antipode
  prior art: owed: this job ran no search; FS-111's gate ("chromatic & plane & (measurable | map) & (tight | saturat* | maximal)", 7 hits, recalled
    from plans/FS111-derivation.md, not rerun) found nothing on saturated colourings; the search is owed in the words of distance-avoiding colourings
    whose classes are maximal
  handoff: de Bruijn — the composition of LENS, EXIT and CLUSTER, queued behind SATPIN, M-PINCH and D6's map type

derivation: SAT-STRIP
  statement: no valid fragment on B̄(p, 2) saturated on B̄(p, 1) has at p a degree-4 vertex of four colours whose four edges are segments
  not claimed: anything at k ≥ 7 (at k = 9 the square nine-colouring of side 1/2 has such vertices, saturated); anything about unsaturated fragments
    (the capped strip holds such a vertex to φ²/√2, FS114-Y-DIAL)
  argument: § 2.5 SAT-STRIP in the (Q)-free non-Siamese class (FS116-S1-QF)
  verdict: gap: TRUE where the edges meet at right angles, the ring carries no (Q) arc and the fragment is non-Siamese (FS116-S1-QF); open on rings
    with (Q) arcs (the strip-like class, where κ's 60° rule breaks and the quadrant-II contact is a (Q) arc's outer tile), on Siamese fragments (a
    Siamese tile of c_II or c_III inside the edge's lens, or a four-sector vertex on its interface) and on crosses not at right angles

derivation: Y-SAT
  statement: a valid fragment on B̄(p, R), saturated on B̄(p, R − 1), about a vertex p of at least four colours, for the largest R reached (first: the
    capped strip made saturated at its midline, which decides SAT-STRIP from the other side) — or a derived obstruction at a named radius
  argument: § 2.5 SAT-STRIP in the (Q)-free non-Siamese class (FS116-S1-QF)
  verdict: stalls at: no construction this job; the obstruction FS116-S1-QF at R = 2 holds only in its class, and a positive at SAT-STRIP's
    configuration must carry a (Q) arc on its ring, a Siamese pair inside an edge's lens, or edges not at right angles

## Stage 2 — SAVED

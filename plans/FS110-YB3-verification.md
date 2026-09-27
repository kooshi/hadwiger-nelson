# FS110-YB3 — blind verification of the construction side's round 3 (FS110-Y3)

*Job FS110-YB3, Opus 5.5, 2026-09-27. Brief: `data/fs110/briefs/YB110-verify-construction.md` with its instance block
`data/fs110/briefs/YB3-110-instance.md` and `data/fs110/briefs/STANDING-RULES.md`. Blind until stage 3 is committed: FS110-Y3's record and tools,
both earlier verifiers' records, the plan, every advisor record and the proof side's files stay unopened until then.*

## Theorems this phase proved

*(One line per theorem, its grade, its address. Stage 1 proves nothing.)*

- **YB3-C5** — in `𝓜_K`, Condition 5 holds iff no boundary arc has radius 1 — [hand, trivial; second mind, blind], §2.1.
- **YB3-GP** — a §7.1 ring whose change points are pairwise at angular distance `≢ 0 (mod 60°)` has `W ≡ 3 (mod 6)`; mechanism: `g(θ) =
  c̃(θ+60°) − c̃(θ)` takes two consecutive values, `m = 3` — [hand; second mind, blind; `tools/fs110_yb3_ring.py` exact on six rings of mine,
  two plants and a known-REJECT control], §2.2.
- **YB3-GP′** (stage 4) — a §7.1 ring with **no two change points exactly `60°` apart** (chord exactly 1) has `W ≡ 3 (mod 6)`: Y3-GP with a
  strictly weaker hypothesis; so `W ∈ {0, ±1, ±2}` needs a pair of change points at distance exactly 1 — [hand, one mind; exact on R3 and R7, whose
  only coincidences are `120°`/`180°`], §4.3.
- **YB3-EVENT** — the window lemma: along a path with `{a,b} ⊆ P_cl(p)`, a merged winding changes only where `ω(p)` passes through a vertex whose
  closure type meets all three merge classes — [hand, one mind], §2.3.
- **YB3-TRANS** — N2-TRANS for `c ≠ d`, along any path in the `a|b` interface (through bichromatic points and through vertices whose closure type
  contains `{a,b}`, bowties and cusps included), in a tight six-map in `𝓜_K` under C5 with NB-4 and NB-5, **off the collinear `d = 2`
  configuration** — [hand; second mind, blind], §2.3.
- **YB3-SAME (GAP)** — the same argument does not transport `W` across a same-type edge (`c = d`): every merge meets an event type
  `{c, r_i, r_j}` that no hypothesis excludes, and a `c`-tile ringed by `d, e, f` swept by the family `ω(p)` changes `W` by `±1` — [hand, one
  mind; a GAP with the local picture that would falsify, not a counterexample], §2.4.
- **YB3-FLIP** — the label algebra: with transport at `c ≠ d` steps and the identity at same-type steps, the orientation returns with sign
  `(−1)^k` — [hand + `tools/fs110_yb3_perm.py`, exact on nine named faces, three plants]; its use (`k` odd ⟹ `W = 0`) needs `k ≥ 1` same-type
  steps, i.e. YB3-SAME's open step, §2.5.
- **YB3-BOW** — at a bowtie `(a,b,a,c)` with flanks `{a,b,x}`, `{a,b,y}`: `x ≠ y ∧ c ∉ {x,y}` ⟹ `W = 0`, by three `c ≠ d` transports only; the
  transport `w₁ → w₂` through the bowtie vertex is YB3-TRANS verbatim — [hand; orientation algebra exhaustive over 1,920 colour assignments,
  `tools/fs110_yb3_perm.py`], §2.6.
- **YB3-SIX** — at a degree-3 vertex with three essential sectors, in a tight six-map in `𝓜_K` with NB-4 and NB-5, a six-arc ring forces a
  boundary arc of radius 1 (so none exists under C5) — [hand, second mind, blind; ℚ(√3) geometry and the counting lemma checked exactly by
  `tools/fs110_yb3_six.py`], §2.7.

## Stage 1 — SAVED

### 1.1 Resume check

No record, directory or tool of this job existed at start (`ls` 11:1x UTC): a fresh start.

### 1.2 Fence log

- **Touch 1 (11:20 UTC, disclosed).** Checking the tree before writing, I ran `git log --oneline -1`, which printed the **subject of the latest
  commit**, beyond the start-up snapshot: `b141228d FS-110: Cor. 1 blind-check brief; inventory`. One subject line; no content, no path, nothing
  of FS110-Y3's. Logged and not used.
- Nothing else fenced was opened, listed or grepped. Every grep of this job excludes `plans/FS110-Y-construction.md`, `data/fs110/fs110-y*`,
  `tools/fs110_y_*`, `tools/fs110_n*`, `tools/fs110_nb*`, `plans/FS110-N*`, `plans/FS110-NB*`, `plans/FS110-YB-*`, `data/fs110/fs110-n*`,
  `data/fs110/fs110-a*`, `data/fs110/fs110-yb/`, `plans/POROS-*fs110*`, `plans/FS110-tangency-seam.md`, `plans/FS110-close-inventory.md`,
  `data/fs110/reports/`, the other briefs, the transcripts and `chats-bak/`.

### 1.3 Quotation check (standing rule 5)

| quotation | source | result |
|---|---|---|
| the seven Y3 statements in the instance block | FS110-Y3's theorem list (fenced) | **deferred to stage 4**, when the record opens |
| `𝓜_K`: "periodic designs with at most `K` circular or straight arcs per tile, arc radii at least `1/K`, …" (claims §0) | `plans/FS107-derivation.md` l. 11 | **matches** |
| NB-4, NB-5, the W-3 question (claims §7) | FS110-A4's record, `plans/POROS-2026-09-27-fs110-competition.md` (fenced for this job) | not checkable; used as quoted by the owner |
| §7.1's ring, `W`, swap point, N2-TRANS, the count (claims §7.1) | `plans/FS110-N-proof.md` (fenced for this job) | not checkable; used as quoted by the owner, the list's §7.1 being "sent to both sides word for word" |
| `[SokolovVoronov2025]` Condition 5 (claims §1) | the held PDF | not re-read at stage 1; the equivalence YB3-C5 uses the quoted words only |

### 1.4 The statements against the claim list's definitions

| id | type used | covering pair | `𝓜_K` / object | verdict on the match |
|---|---|---|---|---|
| Y3-C5 | none | none | "in `𝓜_K`" — circular or straight arcs, radii `≥ 1/K` | matches |
| Y3-GP | none: a ring of §7.1 (colours in `t^c`, `t = P_cl(u)`) | none | a ring, i.e. a colouring of a circle; no map needed | matches; note the statement is purely about circle colourings satisfying N-E0 |
| Y3-RING | as Y3-GP | none | six named rings | matches (rings deferred to stage 4) |
| Y3-PROP | `|P_cl| = 3` — closure types | NB-5 (closure types) | a tight six-map in `𝓜_K`, Condition 5 | matches; "connected map" is undefined in the list — read as "the boundary `Γ` is connected" |
| Y3-FLIP | "type `{a, b_{i−1}, b_i}`" — kind unnamed; read as closure (§7.1's count) | none | a tile | matches §7.1's scope note (count defined only at such tiles) |
| Y3-BOW | "trichromatic vertices", bowtie `(a,b,a,c)` of claims §0 — kind unnamed; read as closure | none directly (NB-5 enters the proof) | a winding map | matches; "winding map" is W-3's term (§7) |
| Y3-SIX | "three essential sectors" (positive angle, `P_ess`) with degree 3; NB-5 in closure types | NB-5 | a tight six-map in `𝓜_K`, Condition 5, NB-4, NB-5 | matches |

### 1.5 Restatements and registered expectations

*Registered after one reading pass in thought and before any tool was written or run. Both outcomes named reachable.*

| id | my restatement | expected | P | the other outcome, and how it is reached |
|---|---|---|---|---|
| Y3-C5 | in `𝓜_K`, "every boundary meets every unit circle in finitely many points" ⟺ "no boundary arc is an arc of radius 1" | TRUE | 0.95 | FALSE if a non-unit arc could meet a unit circle infinitely often (it cannot: two distinct circles, or a line and a circle, share ≤ 2 points) |
| Y3-GP | a §7.1 ring with no two change points `60°`, `120°` or `180°` apart has `W ≡ 3 (mod 6)`; so `W ∈ {0,±1,±2}` needs a pair at chord 1, √3 or 2 | TRUE | 0.8 | FALSE by a GP ring with `W ≢ 3 (mod 6)`; my checker computes `W` exactly and would exhibit one |
| Y3-PROP | `W` transports along an `a|b` edge between two closure-trichromatic vertices (bowties included, through bichromatic points), and `|W|` is constant on each component of `Γ` | first clause TRUE for `c ≠ d`; second clause GAP at same-type edges | 0.7 / 0.55 | TRUE outright if the same-type edge has its own argument; FALSE if an event type the proof does not exclude can change `W` |
| Y3-FLIP | around a tile whose vertices are all `{a, b_{i−1}, b_i}`, transport returns the orientation with sign `(−1)^k` | TRUE as label algebra; its use needs same-type transport | 0.85 / 0.55 | GAP if same-type transport is unproved; FALSE (as algebra) if my simulation of the labels disagrees with `(−1)^k` on a named face |
| Y3-BOW | at a bowtie with flanks `{a,b,x}`, `{a,b,y}`: `x ≠ y ∧ c ∉ {x,y}` ⟹ `W = 0`; the bowtie then counts as one neighbour `a` of tile `b` | TRUE | 0.7 | FALSE if the three transports' orientations compose to a consistent (non-zero) `W`; GAP if the transport through the bowtie vertex needs more than N2-TRANS's argument |
| Y3-SIX | no degree-3 vertex with three positive-angle sectors has a six-arc ring | TRUE | 0.6 | FALSE by a local six-arc configuration consistent with C5, NB-4, NB-5 and the Siamese rule |

### 1.6 "Would have searched here" log

- (none yet)

## Stage 2 — SAVED

*Every verdict derived from the statements alone, before FS110-Y3's record was opened. Conventions: `u` a vertex, `t = P_cl(u)`, `ω(u)` the unit
circle about `u`, `ω(u)°` its tile-interior points; N-E1 (`ω(u)°` avoids `P_cl(u)`) and N-E0 (`c(θ) ≠ c(θ+60°)`) are A-EXACT applied to open tiles
(an interior point of a colour-`j` tile at distance exactly 1 from one of a colour-`j` tile gives a positive-measure set of monochromatic unit
pairs). The Siamese rule and `diam ≤ 1` for every tile are the same fact for two tiles and for one.*

### 2.1 Y3-C5 — TRUE [hand, trivial; my mind blind, two minds in all]

In `𝓜_K` every boundary is a finite union of circular arcs (radius `≥ 1/K`) and straight segments. A segment, or an arc of radius `r ≠ 1`, or an
arc of radius 1 whose centre is not `x`, meets `ω(x)` in at most two points (two distinct circles, or a line and a circle). A compact `ω(x)` meets
finitely many arcs (local finiteness), so without radius-1 arcs every boundary meets every unit circle finitely. Conversely an arc of radius 1 lies
on the unit circle about its own centre and meets it in an arc. So Condition 5 ⟺ no boundary arc of radius 1. ∎

### 2.2 Y3-GP — TRUE [hand; my mind blind; tools exact]

**Proof.** Let `c̃` be §7.1's lift on `ℝ` (`c̃(θ+360°) = c̃(θ) + 3W`) and `g(θ) = c̃(θ+60°) − c̃(θ)`. By N-E0, `g(θ) ≢ 0 (mod 3)` for generic `θ`.
`g` changes only when `θ` or `θ + 60°` crosses a change point, by `∓1` or `±1`. In general position no two change points are `60°` apart, so the two
kinds of event never coincide and every event moves `g` by exactly one. From a value `≡ 1` the only allowed move is up, from `≡ 2` only down; so
`g ∈ {3j+1, 3j+2}` for one fixed `j`. Write `s_k(θ) = c(θ+60(k+1)) − c(θ+60k) ∈ {±1}` and `m(θ) = #{k : s_k = −1}`; then
`3W = Σ_{k=0}^{5} g(θ+60k) = 18j + 6 + m`, and `Σ_k s_k ≡ 0 (mod 3)` forces `m ∈ {0, 3, 6}`. `m` is constant: at an event exactly one of the six
points `θ + 60k` crosses a change point (general position), its colour moves `α → β` between two neighbours both equal to the third colour `γ`
(each neighbour differs from `α` and from `β`), and `s_{k−1} + s_k` is `0` before and after. `m = 0` (or `6`) everywhere means
`c(θ+60°) = c(θ) ± 1` identically, so the change-point set is invariant under `60°` rotation — not general position (a ring has change points,
N-E0 forbidding a constant colour). Hence `m = 3` and `W = 6j + 3 ≡ 3 (mod 6)`. The corollary: `0, ±1, ±2 ≢ 3 (mod 6)`, and change points at
angular distance `60°, 120°, 180°` are at chord distance `1, √3, 2`. ∎

**Exact check** (`tools/fs110_yb3_ring.py`, rings given by formula, my own, built before seeing the side's six): R1 `0,1,0,1,0,1` on six `60°`
arcs (aligned, `W = 0`, `m = 3`); R2 `0,1,2,0,1,2` (aligned, `W = 2`, `m = 0` — the non-GP escape of the proof, reached); R3 nine `40°` arcs (aligned
through `120°`, `W = 3`); R4 nine arcs perturbed off the `40°` grid (GP, `W = 3`); R5 its mirror (GP, `W = −3`); R6 27 perturbed arcs (GP,
`W = 9`). Every GP ring: `W ≡ 3 (mod 6)`, `g` in two consecutive values, `m = 3`. Known-REJECT control X1 (a `70°` arc) rejected. Plant A (validity
sampled at arc midpoints only) passes X1 — caught by the control; plant B (a `−1` step lifted as `+2`) caught by the registered `W` values and by
Y3-GP itself on R5. Both plants fire for their own reason; faithful run exit 0.

### 2.3 Y3-PROP's first clause (N2-TRANS) — TRUE for `c ≠ d`, off `d = 2` [hand; my mind blind]

**YB3-EVENT (the window lemma).** Let `p(t)`, `t ∈ [0,1]`, be a path with `{a,b} ⊆ P_cl(p(t))` for every `t`. Then `ω(p(t))°` is coloured in
`Q = [6] ∖ {a,b}` (N-E1). Merge two colours of `Q` into one class `X`; the merged colouring has a winding `W_X(t)` (net `±1` steps over the three
classes, divided by 3). **Claim:** `W_X` is constant except at parameters where `ω(p(t))` passes through a vertex `v` whose closure type meets all
three classes. *Proof.* Under C5, `Γ ∩ ω(p(t₀))` is finite. Cover `ω(p(t₀))` by small discs `B_j` about those points, each meeting `Γ` only in the
star at its centre and meeting `ω(p(t₀))` in one arc with tile-interior ends, plus closed arcs lying in tile interiors. For `t` near `t₀` the
interior arcs stay in their tiles, and in each `B_j` the circle is one arc from the same entry tile to the same exit tile, whose colour word walks
in `P_cl(v_j) ∩ Q`. The change of `W_X` is the winding of a closed walk in the merged classes of `P_cl(v_j) ∩ Q`; if they are at most two classes it
is 0. Events are isolated: the path runs along `Γ`-arcs, none of radius 1 (C5), so `{t : |p(t) − v| = 1}` is finite for each `v`. ∎

**YB3-TRANS.** Let `u` (closure type `{a,b,c}`) and `u′` (`{a,b,d}`), `c ≠ d`, be joined by a path in the `a|b` interface. Merge `X = {c,d}`. At
`u` the ring has no `c`, so `W_X(0) = W(u)` on `(d,e,f)`; at `u′` no `d`, so `W_X(1) = W(u′)` on `(c,e,f)`. An event vertex has a closure type
meeting `X`, `{e}` and `{f}`; by NB-4 it has three colours, so it is `{d,e,f}` (the complement of `u`'s type) or `{c,e,f}` (of `u′`'s). It lies at
distance 1 from a path point `p`, and `|p − u|, |p − u′| ≤ 1` (all three in the closure of one tile of colour `a` — or, at a bowtie, of `b`, §2.6).
So it is within distance 2 of `u` (resp. `u′`), with equality only when `|p − u| = 1` and `u, p, v` are collinear: off that collinear `d = 2`
configuration it is a close covering pair, excluded by NB-5. So `W_X` is constant and `W(u)` on `(d,e,f)` = `W(u′)` on `(c,e,f)`. ∎ Nothing in the
argument asks `p` to avoid vertices: bichromatic points (`P_cl = {a,b}`) and vertices whose closure type contains `{a,b}` are on the path's
footing, and the endpoints may be any closure-trichromatic vertices (bowties, cusps). So **Y3-PROP's first clause is TRUE** as I read it, with one
scope divergence: **the collinear `d = 2` configuration** (an event vertex at distance exactly 2 from an endpoint, the path point realising the
tile's diameter 1) is not excluded by NB-5, which is about pairs at distance `< 2`.

### 2.4 Y3-PROP's second clause and the same-type step — GAP [hand, one mind]

"`|W|` is one constant on a connected map" needs transport across **every** edge, including edges whose two ends have one type
`{a,b,c}` (a same-type step; N2-TRANS's statement, "`u′`'s third colour `d` replaced by `u`'s third colour `c`", presupposes `c ≠ d`, since `u`'s
ring must contain `d`). The merge argument then fails. The ring colours at both ends are `R = {d,e,f}`; on the edge's interior circles `c` appears
too. Merging `c` with `r ∈ R` leaves events of type `{c} ∪ (R ∖ {r})`; that type is complementary to `{a,b,r}`, which **neither end has**, so NB-5
does not exclude it (only `{d,e,f}` is excluded, against both ends). Switching the merge where `c` is absent from the ring helps only if the three
event types `{c,e,f}`, `{c,d,f}`, `{c,d,e}` never all occur in one `c`-bearing stretch.

**The local picture that would falsify transport** (named, not built — the ban): a `c`-tile `C″` ringed by one `d`-, one `e`- and one `f`-tile,
its vertices of types `{c,d,e}`, `{c,e,f}`, `{c,f,d}`, lying inside `D°(v_i) ∖ D̄(v_{i+1})` near the band swept by `ω(p)`, `p` on the edge. The
family sweeps across `C″` entirely; before and after, the words through that region are walks in `{d,e,f}` whose difference winds once round
`C″`: `W(v_{i+1}) = W(v_i) ± 1`. Against the hypotheses: no vertex of `C″` is complementary to `{a,b,c}`; `C″` versus the `c`-tiles at the two
ends is Siamese-consistent (distances `< 1` to the first end, `> 1` to the second, when those tiles are small); C5, NB-4 hold. I found nothing that
excludes it. **Verdict: Y3-PROP's second clause GAP at the same-type step** — unless the side's §8.3 carries an argument I did not find (to be
compared at stage 4). If the step is false, `|W|` need not be constant, and W-3's "consistently along edges" and "even count" bullets are not
theorems of every tight six-map under C5 — the reduction "Q-full under C5 is one question: does a winding map exist?" (claims §7) inherits the GAP.

Smaller scope notes for "connected map": the list does not define it (read: `Γ` connected); transport also needs every edge to be a two-colour
interface, so an edge between two tiles of one colour must first be removed by merging (Siamese-adjacent tiles merge into one tile of diameter
`≤ 1`, at complexity up to `2K`).

### 2.5 Y3-FLIP — the algebra TRUE; as a theorem about `W`, GAP at the same-type step [hand + tools exact]

The label argument of §7.1 is right: with transport `d → c` in place at `c ≠ d` steps and the identity at same-type steps, the orientation returns
with sign `(−1)^k`. I checked it by simulating the orientation step by step, with no sign formula, on nine named faces (`tools/fs110_yb3_perm.py`):
`k = 0` on the triangle, the pentagon, the heptagon and the hexagon `2,3,4,2,3,4` (the one §7.1's plant could not reach); `k = 2, 4` on four faces
with same-type steps; `k = 3` (reversed) on `(5; 1,2,1,3,1,4)`. Plants: S (reverse at a same-type step) and R (the new colour appended rather than
put in `d`'s slot) caught by the faces; faithful exit 0. **But** `(−1)^k = −1` needs `k` odd, hence at least one same-type step, and there the
identity is the unproved convention of §2.4. So "an odd tile forces `W = 0`" rests on YB3-SAME's open step: **GAP at the same-type step.**

### 2.6 Y3-BOW — TRUE [hand; my mind blind; algebra exhaustive]

At a bowtie `u = (a,b,a,c)` (closure type `{a,b,c}`), tile `b`'s two edges at `u` are `b|a` edges; walk each to the next trichromatic vertex,
`w₁ = {a,b,x}`, `w₂ = {a,b,y}` (the walk may cross bichromatic points). Suppose `x ≠ y` and `c ∉ {x,y}`; let `g` be the sixth colour. Three
transports, each YB3-TRANS with distinct third colours: `u → w₁` (`c ≠ x`), `u → w₂` (`c ≠ y`), and `w₁ → w₂` along the path `w₁ → u → w₂`
(`x ≠ y`). The last path lies in the `a|b` interface throughout — at `u`, `P_cl(u) = {a,b,c} ⊇ {a,b}` — so YB3-EVENT applies with the merge
`{x,y}`; its possible events are `{x,c,g}` and `{y,c,g}`, the complements of `w₂`'s and `w₁`'s types, at distance `≤ 1 + |p − w_i| ≤ 2` since `p`
and `w_i` lie in the closure of tile `b` (`diam ≤ 1`): excluded by NB-5 off `d = 2`. Composing: `W(w₁)` on `(c,y,g)` = `W(u)` on `(x,y,g)` = `W`;
`W(w₂)` on `(c,g,x)` = `W(u)` on `(y,g,x)` = `W`; and the direct transport gives `W(w₁)` on `(y,c,g)` = `W(w₂)` on `(x,c,g)`, i.e. `−W = W`. So
`W = 0`. ∎ The tool checks the orientation algebra over all 1,920 assignments of `(a,b,c)` distinct and `x, y ∉ {a,b}`: the three transports are
inconsistent at exactly the 720 with `x ≠ y ∧ c ∉ {x,y}`, never elsewhere; plant D (the corner at `u` reverses orientation) is caught.

**The side's question, answered from my derivation:** the single homotopy along both `b|a` edges through the bowtie vertex needs nothing beyond
the ordinary edge: YB3-EVENT asks only that every path point have `{a,b}` in its closure type, and that event vertices be complementary to an
endpoint within distance `< 2`. The corner at `u` is not an event (events are points of the circles, not of the path). It meets exactly the rigour
of YB3-TRANS, with the same `d = 2` caveat. (I cannot compare it with N2-TRANS's nerve step itself: that record is fenced for this job.)
**"So the bowtie counts as one merged neighbour of tile `b`, a same-type step iff `x = y`"**: as bookkeeping, consistent with the algebra (the tool's
table is consistent at `x = y` and at `c ∈ {x,y}` under §7.1's conventions); its `x = y` case inherits YB3-SAME's GAP, and its `c ∈ {x,y}` case uses
only the `x ≠ y` transport through `u`, which is proved.

### 2.7 Y3-SIX — TRUE [hand; my mind blind; exact geometry]

Let `u` have degree 3, sectors `a, b, c` of positive angles, and a ring of exactly six arcs. (1) An arc longer than `60°` holds a generic pair
`θ, θ+60°`, against N-E0; so all six arcs are `60°`, change points `z_k = u + e^{i(φ+60k)}`, `|z_k − z_{k+1}| = 1`, and `W ∈ {0, ±2}`. (2) Let
`r_k` be arc `k`'s colour. Every `r_k`-tile at `z_k` lies in `D̄(z_{k+1}, 1)` and every `r_{k−1}`-tile in `D̄(z_{k−1}, 1)`: a tile with a point
outside would, against the tile holding arc `k` near `z_{k+1}`, have cross-distances on both sides of 1 (or break `diam ≤ 1` if it is that tile).
The two unit circles `ω(z_{k±1})` cross at `z_k` with tangents `φ+60k ± 30°`, so the open region outside both discs is a `60°` wedge `O_k` about the
outward radial. (3) `O_k` carries a third colour `s_k`; by NB-4, `P_cl(z_k) = {r_{k−1}, r_k, s_k}`; `s_k` is not the third ring colour, or
`P_cl(z_k) = t^c` at distance 1 from `u` (NB-5); so `s_k ∈ {a,b,c}`. The `s_k`-tile in `O_k` and `u`'s `s_k`-sector are distinct (a pair of their
points is `> 1` apart) and so Siamese at `≥ 1`: `u`'s `s_k`-sector lies in `{|y − z_k| ≥ 1}`, its tangent cone in the closed half-plane opposite
`z_k`. (4) **Counting lemma.** A sector of angle `α` fits a closed half-plane opposite direction `n` for `n` in a closed arc of length
`L = 180° − α` (empty if `α > 180°`), which holds at most three of the six directions. If `s_k ≠ s_{k+1}` for every `k`, each sector is assigned at
most two directions, non-adjacent, so exactly two, needing `L ≥ 120°` for all three sectors, i.e. `Σα ≤ 180°` — false. So some `s_k = s_{k+1} = s`.
(5) Then every `s`-tile at `z_k` is distinct from the `s`-tile in `O_{k+1}` (diameter) and Siamese at `≥ 1` with it, so lies outside
`D°(z_{k+1}, 1)`. Near `z_k`: `O_k` is `s`-coloured (only colour left); the region inside `D°(z_{k+1})` and outside `D̄(z_{k−1})` is `r_k`-coloured
(not `s`, not `r_{k−1}`, NB-4). Their common boundary near `z_k` is the arc of `ω(z_{k+1})` leaving `z_k` at `φ+60k+30°`: a boundary arc of radius 1,
against C5. ∎ **Uses:** C5, NB-4 at every `z_k`, NB-5 at `(u, z_k)` (distance 1), degree 3 with three essential sectors (the counting), the
Siamese rule and `diam ≤ 1`. `tools/fs110_yb3_six.py` checks (1)–(3)'s ℚ(√3) facts exactly, the counting lemma exhaustively over all 4,699
admissible triples of served-direction intervals, and the tight configuration (`120°` sectors with edges at `30°, 150°, 270°`: served sets
`{240,300}, {0,60}, {120,180}`, so `s_0 = s_1` forced); plants P1 (`72°` spacing) and P2 (the size cap and length budget dropped: a proper
assignment appears) caught.

### 2.8 Killing tests of claims §4 that apply

- **Test 3 (the seven-colour control).** Where "six" is spent: in every argument above, the ring has `|t^c| = 3` colours and NB-5 needs two
  complementary three-sets. On the hexagonal seven-colouring each vertex's ring has four colours, `W` is undefined, and YB3-SIX's step (3) has two
  candidate third colours: the arguments do not run there, as they must not.
- **Tests 6, 7 (exact check, class density).** No candidate map exists in round 3 (the side's claimed verdict: no winding map built); there is no
  tiling to rebuild. My exact checker is the ring checker; its ACCEPT controls are rings R1–R6, its REJECT control X1.
- **Test 8 (G71).** Y3-BOW's `W = 0` at a mixed bowtie is an index argument that fails without a swap; it does not use one. Not a refutation of G71's
  reading: the bowtie there is excluded (forced to `W = 0`), not a seam that defeats the index.

### 2.9 "Would have searched here" log

- Would have searched random GP rings for a counterexample to Y3-GP; instead proved it and checked six rings given by formula.
- Would have scanned sector angles and offsets for a six-arc configuration; instead proved the counting lemma and checked it exhaustively over
  its finite family of served-direction intervals (a finite lemma, seconds).
- Would have searched for a local fragment where `W` jumps across a same-type edge; instead named the picture (§2.4) and left it a GAP.

### 2.10 Runs and a slip

All runs of stage 2 are in `data/fs110/fs110-yb3/stage2-runs.txt`: three faithful runs exit 0; seven plants each caught for its own reason (exit 0
in plant mode). **Slip (mine, repaired):** my first batch of plant runs read exit statuses through `| tail -1` (standing rule 8); I discarded that
batch and re-ran every tool with its status read directly into the file.

## Stage 3 — SAVED (verdicts committed before FS110-Y3's record, directory and tools are opened)

| id | my verdict | grade, minds | the step it turns on |
|---|---|---|---|
| Y3-C5 | **TRUE** | [hand, trivial]; my mind blind | two distinct circles share ≤ 2 points |
| Y3-GP | **TRUE** | [hand]; my mind blind; exact on six rings of mine | `g` confined to two consecutive values; `m` constant, `= 3` in GP |
| Y3-RING | my six rings reproduce `W = 0, 2, 3` (aligned) and `3, −3, 9` (GP); the side's rings to be rebuilt at stage 4 | [tools, exact] | — |
| Y3-PROP, first clause | **TRUE for `c ≠ d`**, with a **scope divergence at `d = 2`** (collinear event vertex at distance exactly 2 from an endpoint; NB-5 covers `< 2`) | [hand]; my mind blind | YB3-EVENT + NB-4 + NB-5 at both ends |
| Y3-PROP, second clause ("`|W|` one constant on a connected map") | **GAP at the same-type step** (`c = d`): the merge leaves an event type `{c, r_i, r_j}` no hypothesis excludes; a swept `c`-tile ringed by `d, e, f` changes `W` by `±1` | [hand, one mind] | YB3-SAME |
| Y3-FLIP | **algebra TRUE; as a statement about `W`, GAP at the same-type step** (`k` odd needs `k ≥ 1` same-type steps) | [hand + tools exact] | YB3-SAME |
| Y3-BOW | **TRUE** (the `W = 0` clause, three `c ≠ d` transports); the single homotopy through the bowtie meets YB3-TRANS's rigour exactly; the "merged neighbour, same-type iff `x = y`" bookkeeping is consistent, its `x = y` case inheriting YB3-SAME's GAP; `d = 2` caveat as above | [hand]; my mind blind; algebra exhaustive | YB3-EVENT through `u` |
| Y3-SIX | **TRUE** | [hand]; my mind blind; exact geometry | counting lemma ⟹ `s_k = s_{k+1}` ⟹ a unit arc on `ω(z_{k+1})` |

Registered expectations (§1.5) scored now, before the opening: Y3-C5, Y3-GP, Y3-PROP (both clauses), Y3-FLIP, Y3-BOW, Y3-SIX all landed on the
registered outcome. None moved.

## Stage 4 — SAVED: FS110-Y3's record opened; divergences

*Opened after commit `4bcc8bee` (stage 3): `plans/FS110-Y-construction.md` § Continuation — FS110-Y3 (l. 475–666), `tools/fs110_y_ring.py`,
`data/fs110/fs110-y/y3_ring_*.out`. Nothing else fenced opened.*

### 4.1 Fence log, continued

- **Touch 2 (after stage 3, disclosed).** My `ls data/fs110/fs110-y* tools/fs110_y_*` glob also matched `data/fs110/fs110-yb/` — the earlier verifier
  FS110-YB's directory — and printed its four **file names** (`fragments.out`, `lattice.out`, `mapsanity.out`, `selftest.out`). Names only, no
  content; after my verdicts were committed.

### 4.2 Quotation check (deferred from §1.3)

The seven statements in my instance block match FS110-Y3's theorem list (l. 507–522) **verbatim**.

### 4.3 Divergences, item by item

| # | claim | side | me | kind | the difference |
|---|---|---|---|---|---|
| D1 | **Y3-PROP**, second clause ("`|W|` is one constant on a connected map") | TRUE [hand, one mind] | **GAP at the same-type step** | **truth-status** | §8.3 merges `c ~ d`; at `c = d` there is nothing to merge and the interior circles carry four colours. The event types `{c, r_i, r_j}` are complementary to `{a, b, r_k}`, which neither end has, so NB-5 does not exclude them. §8.3 does not treat the case. My falsifying picture (§2.4, a swept `c`-tile ringed by `d, e, f`) meets every hypothesis I hold. |
| D2 | **Y3-FLIP** as a statement about `W` | TRUE [hand, one mind] | algebra **TRUE**; about `W`, **GAP at the same-type step** | truth-status | the sign `(−1)^k = −1` needs `k` odd, so at least one same-type step, whose transport is D1's open step. The label algebra is right: two minds, mine blind, and tools on nine faces including the hexagon `2,3,4,2,3,4`. |
| D3 | **Y3-PROP**, first clause (N2-TRANS) | TRUE; §8.3's body notes "the case of distance exactly 2 is W-TAN's separate `d = 2` configuration" | TRUE for `c ≠ d`, **off `d = 2`** | **MISSTATED (minor)** | the theorem line drops the body's `d = 2` exclusion (the brief's M3 rule). Corrected: "… at every vertex with `|P_cl| = 3` …, for edges whose ends have different third colours, off the collinear `d = 2` configuration". Two minds (§8.3; my YB3-TRANS, blind, different write-up: the window lemma YB3-EVENT is the nerve step spelled out). |
| D4 | **Y3-BOW** | TRUE [hand, one mind] | TRUE; `d = 2` caveat inherited | scope (minor) | same route (one path vs two steps, disagreeing by `(x c)`). **The side's question answered:** the single homotopy through the bowtie meets exactly the rigour of the ordinary edge. YB3-EVENT needs only `{a,b} ⊆ P_cl(p)` along the path; the corner at the bowtie vertex is not an event, since events are points of the circles, not of the path; its event types are complementary to `v, v′` within `cl B`. The "merged neighbour" bookkeeping at `x = y` inherits D1. |
| D5 | **Y3-GP** | TRUE, hypothesis "never at angular distance `≡ 0 (mod 60°)`" | TRUE; **the hypothesis can be weakened to "no pair exactly `60°` apart"** (YB3-GP′) | route / strength | only `60°` coincidences make `g` jump by 2. `Σ_k g(θ+60k) = 3W` for every `θ` makes `m` constant with no six-point invariance, and `m ∈ {0,6}` would make `g` constant, which a change point forbids. Needed by the side's own §8.7 bullet "at least eight with a **unit-distance** pair of change points (`|W| = 2`)", which Y3-GP, giving "1, √3 or 2", does not support. Checked on R3 (`40°k`) and R7 (a `180°` pair, no `60°` pair): `W = 3`. |
| D6 | **Y3-SIX** | TRUE [hand, one mind] | TRUE | route (two routes now) | side: `j(θ) ≠ j(θ+60°)` directly (the branch of `ω(p_{60°})` at `p₀`, C5) then `K_{3,3}` room count; mine: a counting lemma forces `s_k = s_{k+1}`, which forces a unit arc. Both use C5 at the same place. **One inaccuracy, unused by the proof:** "by Y3-GP's closure the colours run `r₀ r₁ r₂ r₀ r₁ r₂` (… a two-colour ring winds 0)" — six-arc **three-colour** rings with `W = 0` exist (`0,1,0,2,1,2`, checked valid), and Y3-GP says nothing of aligned rings; the theorem covers every six-arc ring, as does mine. |
| D7 | **Y3-RING** | [tools, exact] | TRUE | — | the side's six rings rebuilt from its formulas and run through **my** checker (`tools/fs110_yb3_theirs.py`): valid, `W`, GP and `m = 3` all agree. Its tool read in full: no defect found. Its plant `nolift` cannot reach monotone rings (the side noted it); my plant B reaches one (R5), so the two checkers' plants are complementary. |
| D8 | **Y3-C5** | TRUE | TRUE | — | the same argument. |

### 4.4 Proposed edits for the close (I edit nothing outside my files)

1. **Y3-PROP's line:** "… for edges whose ends have different third colours, off the collinear `d = 2` configuration; `|W|` is constant along
   different-type edges; across a same-type edge it is open (YB3-SAME)." Grade of the first clause: [hand, two minds, one blind].
2. **Y3-FLIP's line:** "given transport at same-type steps" — or split it: the algebra [hand, two minds, one blind; tools], the consequence "`k` odd
   ⟹ `W = 0`" GAP at the same-type step.
3. **Claims §7 / W-3's frame:** "consistently along edges (N2-TRANS)" is a theorem at `c ≠ d` edges only. "Every tile has an even count" rests on
   same-type transport, so the reduction "Q-full under Condition 5 is one question: does a winding map exist?" carries YB3-SAME's GAP. The same
   applies to N2-FLIP if its proof treats the same-type step as the identity; its record is fenced for me.
4. **A stub item (FS-110 or its successor):** *same-type transport* — prove `W(v_i) = W(v_{i+1})` across an `a|b` edge between two `{a,b,c}`
   vertices, or refute it by an exact local fragment given by formula: a `c`-tile ringed by `d, e, f` inside `D°(v_i) ∖ D̄(v_{i+1})`, swept by the
   family `ω(p)`. Such a check is allowed under the ban.
5. **Y3-GP's line:** add YB3-GP′ (hypothesis "no two change points exactly `60°` apart"; conclusion "`W ∈ {0,±1,±2}` needs a pair at distance exactly
   1"). Then §8.7's "eight arcs with a unit-distance pair" is supported.
6. **Y3-SIX:** grade [hand, two minds, one blind, two routes]; drop the sentence on the colour pattern (D6).
7. **A lead for the successor's eight-arc question** [a reading, one mind]: by YB3-GP′ every ring with `|W| ≤ 2` has two change points exactly
   `60°` apart, which is where both Y3-SIX proofs start their lens. Whether the pair must bound one arc is open.

### 4.5 My tool defect, found and fixed at stage 4

My `mechanism()` partitioned the circle by `X ∪ (X − 60°)` only. So when two change points were `120°` or `180°` apart, a six-point sample could
land on a change point. The first such ring, R7, **crashed** the tool (the crash is loud: exit 2, "not a catch"). I fixed the partition to
`X − 60°k`, `k < 6`, and re-ran all rings and plants: `data/fs110/fs110-yb3/stage4-runs.txt`, faithful exit 0, plants A and B caught. The stage-2
results are unaffected: every ring then had only `60°`-multiple coincidences, which the old partition covered, and none crashed.

### 4.6 Registered expectations, scored

Every stage-1 expectation landed on its registered outcome (§3). One thing I did not register: that Y3-GP's hypothesis could be weakened (D5).

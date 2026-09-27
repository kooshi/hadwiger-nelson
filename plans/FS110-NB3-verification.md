# FS110-NB3 — blind verification of the proof side's round 3 (FS110-N3), FS-110 (the tangency seam)

*Job FS110-NB3 (de Bruijn), Opus 5.5, 2026-09-27. Brief `data/fs110/briefs/NB110-verify-proof.md` with its instance block
`data/fs110/briefs/NB3-110-instance.md` and `data/fs110/briefs/STANDING-RULES.md` (rule 0 first: `CLAUDE.md` § The aim and § Counter-priors read
from disk; `CLAUDE.md` on disk is newer than the session's loaded copy, and G82 was read from disk). Blind until stage 3 is committed. Working files:
`data/fs110/fs110-nb3/`; exact checks `tools/fs110_nb3_check.py`. Resuming check: no record existed, so this is a fresh start.*

## Theorems this phase proved

| id | statement (one line) | grade | address |
|---|---|---|---|
| NB3-AC | A-CIRC holds for closure types, cusps included (the translation lemma) | [hand, one mind: this job] | §2.1 |
| NB3-CONF | N3-CONF as quoted, both clauses | [hand, one mind] | §2.1 |
| NB3-CLEAR | N3-CLEAR as quoted; the recoloured set also misses the closures | [hand, one mind] | §2.1 |
| NB3-UP | N3-UP's main clause, read locally at the contact; the lens is `{w ∈ B̄(x,1)}` | [hand, one mind; exact check C1–C2] | §2.1 |
| NB3-SAND | at a ray of `∂D_c(v)` the `c`-sector bounding the gap is a horn, and the tangent contacts are of one monotone type | [hand, one mind] | §2.2 |
| NB3-MERGE | W-MERGE as quoted, with `ρ` off finitely many values and a hole fill (Woodall's step 1) | [hand, one mind] | §2.2 |
| NB3-DEG | N3-DEG as quoted | [hand, one mind] | §2.3 |
| NB3-P17 | N3-P17 as quoted, by the bracketing pair (no Prop. 16) | [hand, one mind; exact check C3–C4] | §2.4 |
| NB3-RED | N3-RED as quoted, with its inputs listed; uses no tightness, winding or even counts | [hand, one mind, over FS106-V2's Cor. 1] | §2.5 |

## Would-have-searched-here log

- Stage 2: none. One would have been a float scan of horn curvatures against tangent in-horns for the sandwich; done by hand as a discriminant
  (`c₁(κ − 1) < 1`, §2.2).

## Fence log

- No fenced path opened, listed or grepped before stage 3. Opened under the brief: `plans/FS106-V-verification.md` § Continuation — FS106-V2 (the Cor. 1
  repair), and also l. 355–376 (the brief's reading list names l. 368–374, Townsend's ⅔π sector) and V3 stage 4 (l. 480–556: the verdicts on V2's Cor. 1
  repair against FS106-VB, and the `d = 2` edge case, which is N3-RED's G-d2). **Disclosed**: the instance opens this file "for the Cor. 1 repair only";
  I read V3 stage 4 as part of that repair's record.

## Stage 1 — SAVED: quotation check, restatements, registered expectations

### 1.1 Quotation check (standing rule 5)

| quotation | source | result |
|---|---|---|
| `𝓜_K`: "periodic designs with at most `K` circular or straight arcs per tile, arc radii at least `1/K`, …" (claims §0) | `plans/FS107-derivation.md` l. 11 | matches |
| Condition 5, Condition 6, Question 2 (claims §1) | `[SokolovVoronov2025]` v1 pp. 4, 26 (held PDF, `library/pdf/arXiv-2502.01958-maptype.pdf`) | match verbatim |
| Townsend ⅔π: "sharp at `2π/3` … It uses a boundary that is a unit arc" (claims §3) | `plans/FS106-V-verification.md` l. 372 | matches |
| instance: Cor. 1 "for cubic maps (one mind, bar `d = 2`)" | FS106-V2 table, SV-1 row and last theorem line; V3 stage 4 ("SV-2 stands repaired at one mind … one step open (d = 2)") | matches |
| instance: W-MERGE "is Woodall 1973's step 3" | `[Woodall1973]` pp. 197 (Step 3), held PDF | matches the step (content checked in §2.2) |
| the theorem table (instance) | `plans/FS110-N-proof.md` (fenced) | **deferred to stage 3** |

### 1.2 The statements in my words

- **N3-CONF.** For a colour `c` at a vertex `v`, the finitely many points `w` of `ω(v)` in the closure of colour `c` each see all their `c`-tiles on one
  side of `ω(v)`; every `c`-sector at `v` points into the cone `D_c(v)` the half-planes of those contacts cut out.
- **N3-CLEAR.** Points near `v` in directions strictly inside `D_c(v)` (compactly) are at distance other than 1 from every `c`-tile point.
- **N3-UP.** At a contact perpendicular to a direction `a` (so at `v ± n`), clearance from an in-type contact at `v + n` or an out-type contact at `v − n`
  survives moving the point in `+n`.
- **W-MERGE.** If `D_c(v)` has interior, two non-adjacent `c`-sectors at `v` can be joined by recolouring with `c` the other sectors between them inside
  `D_c(v)`, within a small ball; the result is again an a.e.-proper map colouring under Condition 5, with smaller types, new vertices cubic and
  trichromatic, and no other vertex's `D_c` altered.
- **N3-DEG.** `D_c(v)` has empty interior only when all `c`-sectors at `v` are horns along one line `±a`, strictly between the unit circles `ω(v ± n)`,
  and colour `c` touches `ω(v)` from outside at both `v + n` and `v − n` (Woodall's cone).
- **N3-P17.** A three-sector vertex cannot carry a ring of six 60° arcs in rotating order: an outward cone at a change point would be bounded by a unit
  arc lying on a tile boundary.
- **N3-RED.** In a tight six-map in `𝓜_K` under Condition 5, every disc of radius 3 holds a cone vertex that no merge removes, or, after the merges,
  S–V's `d = 2` configuration — given S–V's Cor. 1 as repaired by FS106-V.

### 1.3 Registered expectations, both outcomes reachable

*Honest timing (G21): these are registered at stage 1's commit, but my reading of Woodall's step 3 and S–V §7 had already worked most of
the verdicts in outline, so they are not blind priors; they are scored at stage 4 all the same.*

| id | expected | what would make it the other outcome |
|---|---|---|
| N3-CONF | TRUE (0.75) | a contact whose `c`-tiles lie on both sides while a cusp `c`-horn at `v` along the tangent sees neither (a curvature window) |
| N3-CLEAR | TRUE (0.85) | a `c`-tile approaching `ω(v)` away from every contact (compactness failing) |
| N3-UP | TRUE (0.7) for the main clause; the parenthetical regions unclear | a clear point whose `+n` translate meets a tile at the contact |
| W-MERGE | TRUE with a scope remark (0.55) | a gap direction on `∂D_c(v)` not sandwiched by a `c`-horn; a new contact created at another vertex; a hole |
| N3-DEG | TRUE (0.7) | an empty-interior `D_c(v)` from two in-type contacts at `v ± n` |
| N3-P17 | TRUE (0.7) | a cone position where the outer cone takes two colours of `u` |
| N3-RED | TRUE as a reduction (0.6); W-3 GAP at G-CONE and G-d2 (0.65) | a merged vertex that is neither cubic nor a cone vertex; S–V's disc needing more than radius 3 |

## Stage 2 — SAVED: verdicts derived from the statements alone

*Coordinates throughout: `v = 0`, a contact `w` with `e_w = w − v`; for a tangent pair `n ⊥ a`, `w = v + n`. For `x = v + p` near `v`, the height of
`ω(x)` above `ω(v)` near `w`, at tangential offset `X`, is `g(X) = g(0) + p_x X + O(|p|X² + |p|³)` with `g(0) = p_y − 1 + √(1 − p_x²)`; so
`g(0) ≥ 0 ⟺ |p|² ≤ 2p_y ⟺ w ∈ B̄(x,1)` (C1), and at a horn point `p = (s, κs²/2)`, `g(0) = (κ − 1)s²/2 + O(s³)` (C2). Tiles are open; at a point
each tile is a sector (positive angle) or a horn between two arcs with one tangent and different curvatures (𝓜_K arcs are circular or straight).*

### 2.1 N3-CONF, N3-CLEAR, N3-UP, and A-CIRC

**The translation lemma (used everywhere).** If `c ∈ P_cl(v)` and `z` is a `c`-tile interior point with `|z − v| = 1`, pick `y` in a `c`-tile `T ∋`
near `v` (`v ∈ cl T`); `z′ = z + (y − v)` is a `c`-interior point for `y` close to `v`, and `|z′ − y| = 1`: two `c`-interior points at distance 1,
against A-EXACT. So `ω(v)` meets no `c`-tile interior. **A-CIRC for closure types, cusps included, is this lemma** (the tile `T` at `v` may be a horn).
[hand, one mind]

**N3-CONF — TRUE.** *Finitely many:* `cl(C_c°) ∩ ω(v)` lies in the boundary arcs (the lemma), finitely many near `ω(v)` (local finiteness), each meeting
`ω(v)` finitely (Condition 5). *One side per tile:* each `c`-tile at a contact is connected and misses `ω(v)`. *One side per contact:* for `x` in a
`c`-sector at `v` in direction `d`, `ω(x)` near `w` sits at height `≈ r d·e_w`. (i) If some `c`-direction has `d·e_w > 0`, `ω(x)` runs outside `ω(v)`
at height `h > 0` near `w` and meets every out-type `c`-tile at `w`: a sector with an outward direction `f` is met on the ray at distance `≈ h/(f·e_w)`;
a horn tangent to `ω(v)` lies at relative heights `(c₁X²/2, c₂X²/2)` with `c₁ > 0` (**`c₁ = 0` would be an arc of `ω(v)`: Condition 5**), and a curve
at height `h` crosses it at `X ≈ √(2h/c)`. So out-types are excluded; symmetrically `d·e_w < 0` excludes in-types. (ii) If every `c`-direction has
`d·e_w = 0`, the `c`-sectors are horns along `±a`, `a ⊥ e_w`, with curvature window `(κ₁, κ₂)`; a horn point with `κ < 1` has `g(0) < 0` and meets every
in-type tile at `w` (positive-angle: by the ray argument at depth `(1 − κ)s²/2`; tangent in-horns: the line `g` starts below the horn's tip and ends
above it), and `κ > 1` meets every out-type tile. Since `κ₁ < κ₂`, one side is excluded. *Second clause:* (i) is exactly `c`-directions `⊂ D_c(v)`.
[hand, one mind]

**N3-CLEAR — TRUE.** Take `δ` so that the `c`-tiles within `δ` of a contact `w` are those with `w` in their closure; `ω(v) ∖ ⋃B(w_i, δ)` is compact and
misses the closed set `cl(C_c°)`, at distance `η(δ) > 0`. For `d ∈ Λ`, `d·f_w ≥ µ > 0` at every contact (`f_w = e_w` in, `−e_w` out); for `r < η` the
part of `ω(v + rd)` within `δ` of `w` is on the far side of `ω(v)` from `w`'s tiles (`|x − y|² = 1 + 2r d·e + r²` along it, `e` within `O(δ + r)` of
`e_w`), and the rest misses `cl(C_c°)`. It also misses **closures**: `cl(T_in) ⊂ B̄(v,1)` while `ω(x)` is strictly outside near `w`. [hand, one mind]

**N3-UP — TRUE for its main clause, read locally at the contact; the parenthetical half-matches.** Let `T` be an in-type tile at `w = v + n`, `U` a
small ball at `w`. For `x` near `v`, `ω(x) ∩ U` is a graph with `B(x,1) ∩ U` below it. If `ω(x)` misses `T ∩ U` (connected), then `T ∩ U` is wholly
below or wholly above; above is impossible for `x` near `v` (then `g(0) < 0` and the line crosses `T` as in N3-CONF (ii)). So clear `⟺ T ∩ U ⊂ B(x,1)`,
and `B(x + tn, 1) ∩ U ⊇ B(x,1) ∩ U` for small `t ≥ 0`: upward closed. At `v − n` the graph is the bottom of `ω(x)`, the out-type tiles lie below it,
and raising `x` raises the graph: upward closed. By reflection, out-type at `v + n` and in-type at `v − n` are downward closed. *The parenthetical:*
the lens `|p|² ≤ 2p_y` is exactly `{g(0) ≥ 0} = {w ∈ B̄(x,1)}` (C1), a necessary condition at an in-type contact of positive angle. The out-type analogue
I derive is `|p + n| ≥ 1`, i.e. `p_y ≥ −|p|²/2` near `v`; **"lune `p_y ≤ −1/2`" I cannot derive from the statement** (it is a far region, not near
`v`); to compare at stage 4. "Clear" read as clear of the tiles at that contact inside `U`: a tile with a second contact elsewhere on `ω(v)` is
governed there by that contact's own half-plane, so the global reading would be false in general. [hand, one mind; exact check C1–C2]

### 2.2 W-MERGE — TRUE, with two refinements (priority 1)

Let `S₁, S₂` be non-adjacent `c`-sectors at `v`, `int D_c(v) ≠ ∅`, and `G` the angular gap between them inside the convex cone `D_c(v)`.
1. **Clearance of the recoloured set.** A recoloured `x` near `v` can be at distance 1 only from `c`-points within `|x − v|` of `ω(v)`, hence (for `ρ < η`)
   near a contact. Directions of `G` compactly inside `int D_c`: N3-CLEAR. **Directions near a ray `α ∈ ∂D_c(v)`** (**NB3-SAND**): `α ⊥ f_w` for the
   contacts cutting that ray, so they are the tangent contacts at `v ± n`, `n ⊥ α`; since `int D_c ≠ ∅` they are all of one monotone type (an
   upward and a downward one together force `D_c ⊂ line(α)`). If the `c`-sector bounding `G` at `α` had positive angle, `D_c` would contain directions on
   both sides of `α`, so `α` would be interior; hence **it is a horn along `α`**, lying below the gap in the monotone direction (or above it for the
   downward type). Every gap point near `α` is that horn's point translated in the monotone direction; the horn's points are clear (A-EXACT), so the gap
   point is clear of the tangent contacts (N3-UP), and of every other contact by strictness (`α·f ≥ µ > 0` there, uniform on a neighbourhood of `α`).
   Horn-only gaps between two `c`-horns along `α` are sandwiched the same way. A check that the monotone step is not vacuous: at an in-type tangent
   contact with a tangent in-horn along `−a` of relative curvature `c₁`, a horn point of curvature `κ > 1` meets that in-horn iff `c₁(κ − 1) < 1`; the
   `c`-horn itself being clear forces `c₁(κ₂(S₁) − 1) ≥ 1`, and every gap point above it (larger `κ`) then satisfies it — consistent.
2. **Recoloured points against one another:** within `B(v, ρ)`, `ρ < 1/2`. Other colours only lose points. So the result is a.e.-proper.
3. **"No other vertex's `D_c` changes" — TRUE for `ρ` off finitely many values.** For a vertex `u` with `c ∈ P_cl(u)`, the new region meets `ω(u)` in no
   interior point (translation lemma against the clearance). If `|u − v| = 1`, the contact `v` of `u` keeps its side (the merged region is connected and
   misses `ω(u)`). **But if `|u − v| = 1 ± ρ` exactly, `ω(u)` touches `∂B(v, ρ)`; when that touching point lies over `G`, `u` gains a new contact (out-type
   for `+`), which can empty `int D_c(u)`.** Also `ω(u)` through a new corner. Both occur for finitely many `ρ` (finitely many `u` within 2); `ρ` is
   chosen off them. *Refinement (a).*
4. **Types only shrink; new vertices cubic with three colours:** a crossing of `∂B(v,ρ)` with an arc between gap sectors of colours `d ≠ e` has sectors
   `c, d, e` (adjacent tiles differ); a crossing with `S₁`'s or `S₂`'s edge is a two-colour corner, not a vertex. Old vertices lie outside `B̄(v, ρ)`.
   Other colours' `D` can only grow (contacts vanish). Condition 5 holds: the new arc has radius `ρ ≠ 1`.
5. **Holes — refinement (b).** If `S₁` and `S₂` lie in one tile, or if an earlier merge already joined their tiles elsewhere, the merged tile encloses a
   region `H`. Woodall's step 1 fills it; the fill is clear a.e.: the enclosing tile is a connected `c`-set, so of diameter `≤ 1`, `H` lies in its hull,
   a unit circle through `z ∈ H` must leave `H`, and off finitely many tangencies and the pinch points it crosses `∂H` into the tile. Contacts of `c` at
   other vertices are unchanged (`∂H` was already in `cl C_c°`); vertices inside `H` vanish. Whether a fill is needed for "a map" depends on the map
   definition: S–V's Condition 2 takes regions as faces, and a face with a hole needs a boundary curve with no vertex, which Condition 2's "boundaries …
   terminating at vertices" does not provide. So the fill belongs in W-MERGE's statement or in N3-RED's use of it.
6. **Relation to Woodall.** Woodall's criterion ("each unit circle through `Q` … passes through `X` or `Y`", angle `< π`) is replaced by the actual
   contacts of `c` on `ω(v)`; this merges also across gaps of angle `≥ π`, and in Woodall's cone whenever the out-type contacts at `v ± n` are absent.
   FS106-V3 stage 4 (this repository) named Woodall's step 3 as the tool for SV-1's open step with the cone as its exception.

**Verdict: TRUE** with (a) `ρ` generic and (b) a fill when a merge closes a cycle of same-coloured tiles — [hand, one mind]. *Killing tests:* the
seven-colour controls — W-MERGE is colour-count-free (it is valid on any a.e.-proper map; it merges nothing on the tight or slack hexagonal
seven-colourings, whose vertices are cubic and trichromatic), so it spends no "six"; the full argument spends six in S–V's Cor. 3 / Lemma 4 (§2.5).
Townsend's ⅔π sector: its unit arc violates Condition 5; W-MERGE's clearance does not need Condition 5 (a unit arc of contacts still gives a closed cone
`D_c`), but N3-CONF's finiteness and N3-DEG's strictness do; the sector bears on Woodall's step 4 (band colouring), not step 3. Strip, pinhole and
Parts tests: not applicable (no area is counted). **Can a merge land a recoloured point at distance exactly 1 from a same-coloured tile? No** — from any
tile point (clearance), and in fact from any point of `cl(C_c°)`: near non-tangent contacts `ω(x)` is strictly on the other side of `ω(v)` from the
tiles' closures; at tangent contacts the gap's curvatures stay off `±1` (in-type at `v + n` forces `κ > 1` on the `c`-horns and so on the gap above
them), so no gap point lies on `ω(v ± n)`.

### 2.3 N3-DEG — TRUE (priority 2: merging fails only in Woodall's cone)

`D_c(v) = {d : d·f_i ≥ 0}` has empty interior iff `0 ∈ conv{f_i}` (Gordan). It contains a direction `a` (a `c`-sector exists), so all `f_i` lie in
`{f·a ≥ 0}`, and `0` is in their hull only if both `n` and `−n` occur (`n ⊥ a`). `f = n` comes from in-type at `v + n` or out-type at `v − n`;
`f = −n` from in-type at `v − n` or out-type at `v + n`. Same-contact pairs are excluded by N3-CONF. **In-type at both `v ± n` is impossible:** the
`c`-sectors are horns along `±a`; in-type at `v + n` needs `κ ≥ 1` on every horn point (`κ < 1` gives `g(0) < 0`, meeting it), in-type at `v − n`
needs `κ ≤ −1`. So only out-type at both: horn points need `κ ≤ 1` and `κ ≥ −1`; `κ₂ = 1` or `κ₁ = −1` would make a bounding arc an arc of
`ω(v ± n)`, so strict (Condition 5). **Merging (W-MERGE's) fails at `v` exactly when every repeated colour at `v` is in this configuration.** Bichromatic
vertices of degree `≥ 4` never are: some colour has a positive-angle sector there. [hand, one mind]

### 2.4 N3-P17 — TRUE, by a second route (priority 4)

`u` with three sectors of colours `j, k, l`; ring of six 60° arcs, change points `x_i = u + e_i` (a regular hexagon), consecutive arcs carrying `x_i`'s
two colours. Outer cone `U(x_i) = ext ω(x_{i+1}) ∩ ext ω(x_{i−1})` near `x_i`: the directions within 30° of `e_i` (C3). For `z ∈ U(x_i)`:
`ω(z)` meets the ring just inside the arc `(x_i, x_{i+1})` near `x_{i+1}` and just inside `(x_{i−1}, x_i)` near `x_{i−1}`, in tile interiors, so `z`
avoids both of `x_i`'s colours; the third ring colour would put `{1,2,3} ⊆ P_cl(x_i)` at distance 1 from `P_cl(u) = {4,5,6}` (excluded by NB-5).
`ω(z)` passes `u` at offset `|z − u| − 1` toward `e_i` and meets every sector of `u` whose directions meet the open half-turn about `e_i`.
**Route:** pick a boundary direction `b_{jk}` between two of `u`'s sectors; the two change points bracketing it are each within 60° of it (C4), so both
their outer cones avoid `j` and `k`, and both are `l`. With `R ⊇ U(x_i)`, `R′ ⊇ U(x_{i+1})` the `l`-tiles: if `R` had a point inside `ω(x_{i+1})`,
`R` would hold points at distance `< 1` and `> 1` from a `q ∈ U(x_{i+1})` near `x_{i+1}` (`> 1` since `(x_i − x_{i+1})·e_{i+1} = −½`, C3), so a point
at distance 1 (connectedness), against A-EXACT. So `R` misses the disc, and the arc of `ω(x_{i+1})` bounding `U(x_i)` lies in `∂R`: a unit arc on a
boundary, against Condition 5. This avoids S–V's Prop. 16 and its equal-angle case (FS106-V2: Prop. 16 MISSTATED); the last step is FS106-V2's.
[hand, one mind: this job; the statement's other derivations are the side's and FS106-V2's]

### 2.5 N3-RED — TRUE as a reduction; what it rests on (priority 3)

Merge at every mergeable vertex near the disc (finitely many; each merge keeps other vertices' mergeability, since `D_c` is unchanged and other `D`
only grow; `ρ`'s chosen successively, small and generic; fills as needed). Every vertex left is cubic and trichromatic (types of `≤ 3` colours by NB-4
and the trivial `≥ 5` bound — a vertex with five colours leaves one colour on `ω(v)°`, which holds interior points at distance 1) or a cone vertex no
merge removes. If a disc of radius 3 has none, S–V's argument runs there (S–V §8: "Lemma 4 to any circle of radius 3"; its trichromatic `u` within 1 of
the centre is SV-L4 (a), TRUE for cubic maps) and ends in Lemma 3, Cor. 3 or the one residual, the `d = 2` configuration. Cusps at merged cubic
vertices are covered: S–V's `A(u)` (Props. 9–10) is built from the boundary points at distance `δ`, not from sector angles. **It rests on:**
(1) W-MERGE with refinements (a)–(b) and N3-CONF/CLEAR/UP; (2) N3-DEG (to name the hard case); (3) NB-4 (two minds, one blind); (4) FS106-V2's Cor. 1 for
cubic maps, region-only (one mind; two of its repairs at two minds, one blind; the SV-L3 bicycle for `√3 ≤ d < 2` a sketch, constants not computed;
the Prop. 19 fill route for degree `≤ 3`); (5) S–V's claim that radius 3 suffices (read, not re-derived). **It does not use tightness, winding or even
counts**: its NO would be about every a.e.-proper six-colouring by a Condition-5 map in `𝓜_K`. [hand, one mind]

**W-3 — GAP at G-CONE and G-d2, as the side says; NO given both *and* S–V Lemma 3 at `√3 ≤ d < 2` at full grade** (FS-108 item 2, shared). The
answer to Question 2's Condition-5 half, a.e. at bounded `K`, is then: seven, bar the cone vertex and `d = 2`. Act One (C-ACT1) is S–V's Lemma 4 on the
merged cubic map, proved apart from its kills (Lemma 3, Cor. 3). C-SEAMLIST's residuals under Condition 5 reduce to two of its entries: the cusp
(the cone vertex) and `d = 2`.

### 2.6 Verdict summary (stage 2)

| id | verdict | minds / grade |
|---|---|---|
| N3-CONF | TRUE | 1 (this job) / [hand] |
| N3-CLEAR | TRUE (also clear of closures) | 1 / [hand] |
| N3-UP | TRUE (local reading); lens matches; "lune `p_y ≤ −1/2`" not derivable | 1 / [hand; C1–C2] |
| W-MERGE | TRUE with refinements (a) generic `ρ`, (b) a fill | 1 / [hand] |
| N3-DEG | TRUE | 1 / [hand] |
| N3-P17 | TRUE (second route, bracketing pair) | 1 / [hand; C3–C4] |
| N3-RED | TRUE as a reduction, over FS106-V2's Cor. 1 (one mind) | 1 / [hand] |
| W-3 | GAP at G-CONE and G-d2 (and SV-L3's sketch) | 1 / [hand] |

## Stage 3 — SAVED: verdicts committed

Verdicts committed at `859a6468` (stage 2). Only now do I open `plans/FS110-N-proof.md` (§ Continuation — FS110-N3), `data/fs110/fs110-n/` and
`tools/fs110_n_*`. Every other fence stands (the earlier and concurrent verifiers' records, the plan, the advisors, the inventory, the reports).

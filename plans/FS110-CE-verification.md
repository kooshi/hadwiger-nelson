# FS110-CE — a second mind on FS110-CB's route at cusp vertices: D4's bicycle and D5 items 1–4, 6

*Coxeter (Opus 5.5), 2026-09-27. Brief: `data/fs110/briefs/CE110-cusp-scope-rest.md`, with `data/fs110/briefs/STANDING-RULES.md`. Rule 0 first:
`CLAUDE.md` § The aim and § Counter-priors read before anything else. Sources read: `plans/FS110-CB-verification.md` in full;
`plans/FS110-CC-verification.md` in full; `tools/fs110_cc_cusp.py` in full; FS110-CD's §4.1 (E3)/(β) row (l. 411) only;
`[SokolovVoronov2025]` (`~/source/library/pdf/arXiv-2502.01958-maptype.pdf`, text layer) Lemma 4 statement and §7.1 (pp. 19–24: Def. 7,
Props. 14–19, Lemma 5, Lemma 6) and the Appendix (proofs of Props. 18, 19 and Lemma 4, pp. 26–28).*

## Theorems this phase proved

(filled at stage 3)

## Stage 1 — SAVED

### 1.1 The quotation and address check (standing rule 5)

| brief says | source | verdict |
|---|---|---|
| "D4, Lemma 3's bicycle (CB's lines 135–158)" | D4 is CB l. 135–157 (l. 158 blank) | **matches** |
| "D5 items 1–4 and 6, the circle-only reduction and its pigeonhole (CB's lines 159–199)" | D5 is l. 159–193 (items 1–4: l. 168–177; item 6: l. 186–190; the conclusion l. 192–193); l. 195–201 are D6 | **overshoots into D6 by six lines; harmless** |
| "A first check, FS110-CC … found that CB's route covers cusp and double-cusp vertices at D2's strip, D5 item 5 and D1's (P′)" | CC stage 3 table and l. 180: "No step fails at cusps, so no local repair is needed … CB's route covers cusp vertices, and double cusps, as written" | **matches** |
| "It did not check the remaining steps" | CC l. 189–190: "**Not checked, not asked:** D4's bicycle and D5 items 1–4, 6 at cusps." | **matches** |
| "including the overshoot case `d > √3`" | CB l. 147: "for d > √3 overshoots and reaches z1 from outside" | **matches** |
| "the (E3) and (β) configurations FS110-CD flagged, where an endpoint is a V-in vertex on `ω(u)`" | CD l. 411: "In both cases the endpoint is a **V-in vertex on `ω(u)`**, which Theorem D2 handles" | **matches** |
| a cusp vertex "exists locally; it has been checked exactly (`data/fs110/fs110-a6/a6_c2_single_horn.py`)" | the file exists; CC reran it ("ALL AS PREDICTED"); I did not rerun it | **present; not re-run by me** |
| "FS110-CD's route takes S–V's Props. 9–11 and 17 from print" | CD's record is fenced beyond §4.1's (E3)/(β) row | **not checked (fenced)**; consistent with CC's aside, l. 193 |

The statements I work from, verbatim:
- CB D5 item 1 (l. 168–169): "A *circle-to-circle path* is an {a,b}-boundary path inside the open disc joining two points of Ω with `c′ ⊇ {a,b}` (a
  vertex on Ω counts). Its ends are < 1 apart (the a-tile along it has diameter ≤ 1; = 1 is (P′)); paths do not cross; their arcs (< 60°) nest or are
  disjoint."
- CB item 2 (l. 170): "Recolour each maximal such arc [p1, p2] of the pseudo-colouring by a, the colour of the tile beside the path outside Q (it is also
  Ω's colour just outside the arc at both ends)."
- CB item 4 (l. 176–177): "**Every surviving colour change's inward path ends at a trichromatic vertex of the OPEN disc** (a path that met Ω again would
  have made it an arc end); its third colour is in {4,5,6} (a {1,2,3} vertex is at distance < 2 from u, Cor. 3)."
- CB item 6 (l. 186–190): "two same-pair endpoints p, p′ have `|p − p′| ≥ 1` … and ≠ 1 (P′), and < 2 (open disc): Lemma 3 (D4). … Its disjoint partner is
  an open-disc endpoint, so the distance is < 2: Cor. 3."
- CD §4.1 (l. 411), (E3): "a surviving colour change `b` that is itself a vertex `{a,c,i}` with its `i`-sector inside the disc and its `a|c` edge leaving
  outward has **no inward path** at all — CB's item 4 presumes every change has one; its endpoint is `b ∈ ω(u)`." (β): "a path arriving at a vertex
  `v′ ∈ ω(u)` whose three edges all enter the disc (`i`-sector inside, both arcs of `ω(u)` in one sector `S ∈ {a, c}`): CB's item 1 counts it … but item
  2's 'also Ω's colour just outside the arc at both ends' fails when the minor arc lies on the `S`-side of the path".

### 1.2 Fence log (standing rule 13) — one slip, disclosed

To find §4.1's row I ran `grep -n "^#\|4\.1\|(E3)\|(β)"` on FS110-CD's record. Its output printed, besides the headings and the permitted l. 411, one
line each from l. 285, 332, 359, 361, 365, 374, 414, 425, 428, 438, 448 of that record. What those lines carried, so a reader can discount it: CD has a
"Lemma H (a region of a colour of `u` that enters the disc)" with a "cone condition", said to "kill every antipodal collision"; its (E3) configuration puts
"the `i`-sector [at `u`] in the wedge `|arg z| < 40°`"; its pairing rule (l. 414) is "pair only **circle-bichromatic** returns (regular points, V-out
vertices); these always have beyond-colour `a` at both ends". I opened nothing further of CD's record. **Effect on independence:** my repair of item 2
(stage 2, R2) coincides with CD's l. 414 rule and was not derived blind to it; my Antipodal Lemma (stage 2, AL) is a different statement from a cone
condition at `u` and rests on CB's D2 strip alone, but I knew that CD closes the antipodal cases by some lemma. Scratchpad: I work in
`scratchpad/fs110-ce/` only (it holds `sv.txt`, the S–V text layer).

### 1.3 Registered expectation (formed after one pass through CB's D4–D5 and CD's row, before any written derivation or check)

| item | expectation | what would move me |
|---|---|---|
| D4 at cusps | **TRUE**: the bicycle uses the map only through (i), (ii), `|c′| ≤ 2`, closedness and D2 at the centres; a cusp at `u1`, `u2`, `x1`, `y1` or `z1` enters only there (CC covers D2 at cusps), 0.85 | a cusp on a circle producing a point whose `c′` is two colours with no colour change (a spike) at which (ii) or the band argument fails |
| D5 items 1, 3 at cusps | TRUE, 0.8 | a horn corner of a path that breaks item 3's exit argument |
| D5 item 2 | **FALSE as stated at (β)** (CD's configuration), and at every point where a path touches Ω without Ω changing colour there, 0.7 | the beyond-colour at the far end always matching |
| D5 item 4 | **GAP at (E3) and (β)**, with more cusp instances of (E3) (a horn tangent to Ω), 0.75 | (E3) excluded by the strip or by (P) from the V-in vertex |
| the conclusion "every pair handed to Lemma 3 or Cor. 3 is at distance < 2" | **TRUE after a local repair**: two points of Ω at distance 2 cannot both be V-in, because both would need the strip outside, 0.6 | a cusp at `u` whose horn arcs, perpendicular to the diameter, vote "outside" at both ends |

### Would have searched here (standing rule 3)

- (none yet)

## Stage 2 — SAVED (the derivations, and their exact checks)

Setting and notation are CB's (§1.2, D1–D2): after merging, every vertex is a trichromatic cubic vertex; `M = c(u) = {4,5,6}`, `Ω = ω(u)`,
`c′ = c ∩ {1,2,3}`. A **cusp vertex** has two equal boundary tangents (a horn: a sector of angle 0); a **double cusp** has three. A **spike** is a point
`x ∈ Ω` with `|c′(x)| = 2` and the same circle colour on both sides of it. Cusps produce spikes (a horn tangent to Ω; a vertex on Ω whose two circle
directions lie in one sector), and so do plain tangencies (a boundary arc tangent to Ω). A vertex `{a,c,i}` on Ω with `i ∈ M` is **V-in** if its
`i`-sector lies inside the disc, and **V-out** otherwise. By (P) from u, Ω never enters an `i`-sector, so every such vertex is one or the other.

### E1 — D4, Lemma 3's bicycle, at cusps

**What the bicycle takes from the map.** Read line by line, CB's D4 (l. 137–157) uses only these facts about the map:
- (M1) (i) and (ii) under transversality. These come from D2's strip at the centres `u1`, `u2`, and CC's C1–C3 extend that strip to cusp and
  double-cusp centres.
- (M2) `|c′| ≤ 2` on each circle. This is Cor. 3 AE with the circle point itself as a centre; CC covers it when that point is a cusp.
- (M3) `{x : a ∈ c′(x)}` is closed. This needs local finiteness only.
- (M4) Only finitely many points have `|c′| = 2`. This needs Conditions 3 and 5 only.

Everything else in D4 is geometry of two circles: C3's turning locus `cos θ* = (3+d²)/(4d)` and the overshoot. None of it looks at a sector at
`u1`, `u2`, `x1`, `y1` or `z1`. So a cusp can enter D4 only through spikes, in three places. I checked each.
- **The bands.** A spike is a special time at which neither lift jumps, so D does not change there. The band is fixed between special times by (i)
  at points with one-colour `c′`. The ±2 step still needs both points to be genuine colour changes, and there (ii) applies. At the partner's
  turning time (d > √3), `ω(z)` is tangent to Ω1 at x. But `ω(x)` crosses Ω2 at z transversally, because `|x − u2| < 2` there, so (i) and (ii)
  still hold.
- **(ii) at a spike holds.** Take x a spike with `c′(x) = {a,b}`, and y with `c′(y) = {a,b}`, `|x − y| = 1`, the crossing transversal. Then `ω(y)`
  enters `N_x` strictly on side `σ_x`, and there it meets the interior of a tile whose closure contains x. That tile's colour lies in
  `{1,2,3} ∩ c(x) = {a,b} ⊆ c(y)`, which contradicts (P). This is CB's proof word for word; it never uses that x is a colour change.
- **The endpoint cases, exhausted.** The sets `c′(x1)` and `c′(z1)` are known only from below: from the one-sided limits and from G. A point
  whose known colours are a single colour may carry an unknown second one (a spike). Treating that unknown adversarially, the exhaustion BIKE
  finds **0 surviving assignments** for `d ≤ √3` and for `d > √3`. Every case closes on fully known sets, exactly as CB's four cases do.
- **A completion CB owes.** CB writes "WLOG n = −1 (negating colours)". The E band can have any n. Write each 60° step as `3k + e`, `e ∈ {1,2}`. Then
  `D_y − D_z = 6k + e1 + e2 − J + J_z`, which lies in `{−1,0,1}` only for `k ∈ {0, −1}`, and `k = −1` is `k = 0` negated. BIKE runs
  `k ∈ [−3, 3]`: still 0 survivors.
- **Plants.** `noII`: 48 assignments survive, all in the overshoot regime. This matches CB, whose d ≤ √3 case closes by closedness alone.
  `noClosure`: 16 and 48 survive.

**D4 at cusps is TRUE.** The cusp enters only through D2 (CC) and through spikes (harmless, as above).

### E2 — D5 item 1 at cusps

TRUE. Corners of a path, cusp corners included, keep one a-tile beside the path, and a tile has diameter ≤ 1. **One small misstatement:** "= 1 is
(P′)" fails when the two ends are vertices `{a,c,i}` and `{a,c,j}` with `i ≠ j`, because those multicolours do not nest. Distance 1 is excluded there
by (ii) instead (both ends have `c′ = {a,c}` on one circle).

### E3 — D5 item 2: its parenthetical is FALSE at (β) and at spike returns

Item 2 says: "Recolour each maximal such arc [p1, p2] … by a, the colour of the tile beside the path outside Q (it is also Ω's colour just outside
the arc at both ends)".
- **At (β)**, CD's configuration in rational form (BETA, exact). `v′ = (1,0)`. The edges run a|c along `(−4,3)/5`, a|i along `(−1,0)`, c|i along
  `(−4,−3)/5`. P is the circle of centre `(4/3, 4/9)` and radius `5/9`, tangent to the a|c edge at `v′` and passing through `b = (4/5, 3/5)`.
  Its arc between them lies in the open disc: 902 rational points were checked, and `⟨C, w⟩` has no maximum inside the arc. At `v′` the circle's
  two directions and the Q-wedge all lie in sector c. The tile beside P outside Q is a. So item 2 recolours `[b, v′]` by a while Ω just beyond `v′`
  is c, and `v′` becomes a new colour change whose inward path P returns to the absorbed point b. **FALSE; two minds (CD, and me with a
  rational instance).**
- **At a spike return (new here, one mind).** The path can touch Ω without Ω changing colour, in two ways. It can be tangent to Ω from inside at
  a regular boundary point (SPIKE: the circle of radius 1/2 tangent at `s = (1,0)` meets Ω only at s). Or it can pass through a spike corner, where
  both circle directions lie in one sector and the other sector, a wedge or a horn, lies inside. CB's item 1 counts such an s as a return
  ("`c′ ⊇ {a,b}`"). There the tile between P and Ω is Ω's colour S, P's far side is `T ≠ S`, and Ω beyond s is S. The mismatch is the same, and s
  becomes a change whose path is P's continuation past s. Cusps add instances: a horn of colour T tangent to Ω from inside.
- **Where the parenthetical holds** [hand]. It holds at the start point, and at every return where Ω changes colour: a transversal crossing, a
  corner that Ω crosses, or a V-out vertex. There the arc side of the return is P's Q-side colour and the far side is P's other colour a, because
  Ω's two directions at the return lie in different sectors, one on each side of P.

**Local repair (R).** Four rules, applied in order:
- (R1) An inward a|c path continues through every spike it meets. At a spike the continuation stays inside, because the non-S sector lies inside.
- (R2) The path ends at its first trichromatic vertex, which may be a V-in vertex on Ω. A V-out vertex cannot be reached from inside unless Ω
  changes colour there.
- (R3) Only returns at colour changes of the circle are circle-to-circle, and only their arcs are recoloured. There the parenthetical holds.
- (R4) A selected change that is itself a V-in vertex is its own endpoint.

R3 coincides with CD's pairing rule (l. 414), and I saw that line before deriving mine (§1.2).

### E4 — D5 item 3 at cusps, for the repaired reduction

TRUE. `ω(w)` enters Q at x transversally (at 60°) and meets the arc only at x. Take the boundary point p of the component of `ω(w) ∩ Q` that
starts at x. Then p lies on P, and just past p `ω(w)` is on P's outside-Q side, which is the a-tile at a regular point and at any corner. Two cases
need a remark:
- If P touches the minor arc at a spike (R1), Q is pinched there, the Q-side colour equals S, and the argument runs on each piece.
- If `ω(w)` leaves through a spike of P on Ω (then `x ± 120°` is that spike), it can pass straight out of the disc. That happens for finitely many
  x, and there (i) follows by rotating the pair within the arc, as for spikes in E1.

### E5 — D5 item 4: GAP at (E3) and (β), with cusp instances

**The statement.** CB's item 4 says: "Every surviving colour change's inward path ends at a trichromatic vertex of the OPEN disc".

**(E3).** A selected change that is itself a V-in vertex has its a|c edge on the side away from its i-sector, so outside the disc. It therefore has
no inward path, and its trichromatic point lies on Ω. **GAP; two minds, CD's and mine.** Cusps give more instances:
- **E3H, exact.** The i-sector is a horn tangent to Ω from inside, with edge curvatures 2 and 3, and the a|c edge leaves along +x.
- The circle's direction runs inside an a-horn whose edges have curvatures on either side of 1; the a|c edge is then the outer edge and leaves
  tangentially outward.
- A double cusp tangent to Ω, with the circle's branch inside one horn and the other horn inside the disc.

**(β).** Under item 2 as written, `v′` survives as a change whose path returns (E3). **GAP.**

**The third colour.** Item 4's "its third colour is in {4,5,6}" is TRUE, for endpoints on Ω too, because `|c′| ≤ 2`.

### E6 — the Antipodal Lemma, and D5 item 6

**Antipodal Lemma (AL).** Let u be a trichromatic cubic vertex; cusps and double cusps are allowed. Call `x ∈ Ω` **M-in** if some tile of a colour in
M has x in its closure and has interior points strictly inside Ω arbitrarily close to x. Then **no two M-in points of Ω are at distance 2.**

*Proof.* Take an M-in point `x = u + e`.
- The strip's majority side `σ_e` is outside. If it were inside, the M-coloured interior points near x would contradict D2's strip.
- So at least two of u's arcs vote "outside" at e: `|u + e − x_ij(δ)| < 1`, for every small δ by CC's C2, including along a horn's normal.
- An arc point `x ≠ u` cannot be within 1 of both `u + e` and `u − e`: that would give `2 = |2e| ≤ |u+e−x| + |x−u+e| < 2`.
- So the votes "outside" at e and at −e number at most three, not four. ∎

No tangent is used, so cusps enter nowhere. AL's exact check covers an ordinary vertex, three cusps (the a6 horn among them) and a double cusp, over
46 directions including the horn normal. The `nearAntipodal` plant fires: for directions `(s, ±c)`, which are not antipodal, an arc votes outside at
both. **AL is one-sided.** At the a6 cusp all three arcs vote *inside* at both ±n, so two antipodal V-out points are not excluded. That is why (R2) ends
paths only at V-in vertices.

**Consequences for item 6.**
- V-in vertices on Ω are M-in (i ∈ M).
- The eleventh point w, when it lies on Ω, is M-in. CB's R lies inside every γ(u), hence in the closed disc, so R's tiles at w, being open, lie in
  the open disc.
- Under (R1)–(R4) the pigeonhole points are u, endpoints in the open disc, V-in vertices on Ω, and w. Two of them at distance 2 would have to be two
  antipodal M-in points, which AL excludes. **So every pair handed to Lemma 3 or Cor. 3 is at distance < 2, at cusps too.**

**Item 6's other steps at cusps.**
- **`|p − p′| ≥ 1`.** The a-side curves argument holds with a self-endpoint (R4: a constant curve in the a-sector). It also holds at a cusp
  endpoint whose a-sector is a horn, since the curve ends within any ε of p inside the horn, as in CC's C1.
- **`≠ 1`.** (P′) holds, since the multicolours are equal.
- **The eleventh point.** Its existence uses only that R's outer boundary carries two colours of M after hole-filling. That is a topological fact;
  a horn changes nothing in it.

### Would have searched here

- BIKE: I would have fuzzed pseudo-colourings on two circles for a bicycle that escapes. Instead I derived the lift relations and exhausted the
  finite residue system they leave, with spikes adversarial.
- AL: I would have sampled random cusp centres numerically. Instead I derived the two-disc inequality and confirmed the exact votes on rational arcs.

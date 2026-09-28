# BASE-V — blind re-derivation of the printed steps under row 134's base, in FS-112's setting

*Job BASE-V, blind verifier (de Bruijn, Opus 5.5), 2026-09-27. Brief: `data/night-2026-09-27/brief-BASE-V.md` (commit 8963f7c2); standing
rules `data/fs112/briefs/STANDING-RULES.md`. Touches only this file, `data/base-v/`, `tools/base_v_*.py`. Grades are `CLAUDE.md` § Notation's;
"minds" counts independent derivations.*

**Status:** Stage 1a — SAVED (statements 1–3, blind). Stage 1b — SAVED (statement 4, blind). Stage 2 (comparison) below when saved.

## Theorems this phase proved

| id | statement (one line) | grade | minds | address |
|---|---|---|---|---|
| BV-H1 | Band lemma: a finite 3-colouring of the unit circle satisfying (i) at generic points and (ii) lifts to a height `h` (steps ±1) whose `D(x) = h(x+60°) − h(x)` stays in one band `{3k+1, 3k+2}`; `W/6 ∈ [3k+1, 3k+2]` for the winding `W`, so `W ≠ 0` and `W ∈ {6, 9, 12} + 18k` (up to orientation) | [hand; tools check on formula examples] | 1 | §1a.2 |
| BV-L5 | Lemma 5, strongest reading: the running-maximum recolouring `h' = max_{y ≤ x} h(y)` is proper and cyclic; its bichromatic points are a subset of the old ones and **each kept point keeps its pair of colours** | [hand; tools check] | 1 | §1a.2 |
| BV-C6 | A cyclic proper colouring has `n ≡ 6, 9, 12 (mod 18)` bichromatic points; `n < 9` forces `n = 6` at exact 60° spacing (`D ≡ 1`) | [hand; tools check] | 1 | §1a.3 |
| BV-P18 | Prop. 18 (cyclic, proper, `n = 3m ≥ 9`): for each pair, the boundaries `P_j, P_{j+k+1}, P_{j+2k+2}` of that pair are pairwise more than 1 apart | [hand; tools check] | 1 | §1a.3 |
| BV-HEX | Lemma 6's `< 9` branch under H: the regular hexagon of kept points cannot occur at a cubic trichromatic `u` in a valid map (unit arcs allowed) when `x_1, …, x_6` are cubic; no Condition 5, no strip `A(u)`, no unit-arc step | [hand; exact identities by sympy] | 1 | §1a.4 |
| BV-L6 | Lemma 6, given the inputs (i), (ii) and finiteness for the pseudo-colouring of `ω(u)` and H at the six hexagon points | [hand] | 1 | §1a.4 |
| BV-ND | NoDouble: two points `x₀ ∈ ω(u₁)`, `y₀ ∈ ω(u₂)` at distance 1 cannot both switch between the same pair {α, β} in opposite senses along the unit-distance linkage, when at each the two sectors traversed are adjacent (plain point, cubic vertex, degree-4 bichromatic vertex); **holds with unit arcs**, at cusps | [hand; exact identities] | 1 | §1b.2 |
| BV-L3 | Lemma 3, a.e., curved, cusps and double cusps at `u₁, u₂`: no two points with the same multicolour at distance in (1, 2) whose unit circles carry proper finite circle colourings in the complementary triple; route: the unit-distance four-bar linkage and the band lemma, no angle at `u₁, u₂` used | [hand; exact identities] | 1 | §1b.3 |
| BV-C3 | Corollary 3 at cusp and double-cusp vertices, under Condition 5 (the two {complement}-strips cross near an intersection point) | [hand] | 1 | §1b.4 |

## Stage 1a — SAVED (statements 1–3, blind)

### 1a.0 Quotation check (standing rule 5)

Checked against `pdftotext -layout ~/source/library/pdf/arXiv-2502.01958-maptype.pdf` (statement lines only):

| brief quotation | source | result |
|---|---|---|
| Lemma 5 | PDF §7.1 (text lines 826–830) | verbatim ✓ |
| Prop. 18 "(3.2, [11])", including the doubled "{1, 3}, {1, 3}" | text lines 949–952 | verbatim ✓ (the doubled pair is the print's typo; read as {1,2}, {2,3}, {1,3}) |
| Lemma 6 | text lines 965–967 | verbatim ✓ |
| Lemma 3 | §6.1, text lines 689–693 | verbatim ✓ |
| Lemma 4 | §7, text lines 740–743 | verbatim ✓ |
| Prop. 17's last step ("the boundary between colors 4 and 2 … A contradiction with Condition 5.") | inside Prop. 17's printed proof | **deferred to stage 2** (checking it means reading the proof) |
| "no two interior points of one colour at distance exactly 1" | `data/fs112/claims.md` §0, "Valid" | verbatim ✓ |
| N3-BASE's hypothesis and NB3 §2.3 quotation | fenced files (`plans/FS112-*`) | **deferred to stage 2** |

### 1a.1 Reading log (blindness)

- Read before deriving: the brief; standing rules; `CLAUDE.md` § The aim and § Counter-priors (from disk); `data/fs112/claims.md` §0–§1 only;
  the PDF's §2–§4 (Conditions 1–8, Definitions 1–3, Observations 1–2, Props 1–5 with proofs, Lemma 1), §6 up to §6.1 (Props 9–11, Corollaries 2–3,
  i.e. the construction of `A(u)`), §7's opening and §7.1 up to Lemma 5's statement (the circle-colouring definitions, Definitions 7–8, Props 14–15
  with proofs), and the **statement lines only** of Props 16–19 and Lemmas 3, 4, 6.
- **Not read before stage 1a was written:** the printed proofs of Lemma 5, Props 16–17, Prop. 18 (Appendix), Lemma 6, Lemma 3 (§6.1, Fig. 5), Lemma 4
  (Appendix); §5; §8. Row 132 and rows 134–136 of `LEDGER.md` were not opened.
- **Fence touches: none.** Work files in the scratchpad subdirectory `base-v/` (the PDF text) only.

### 1a.2 Statement 1 — Lemma 5 (derived blind; printed proof not read)

**Setting.** A circle colouring (print, §7.1): finitely many arcs of the unit circle, colours in {1, 2, 3}, adjacent arcs different. Angles in
degrees; two points are at distance exactly 1 iff their angular separation is exactly 60°. Proper = (i) no two monochromatic points at distance 1
share a colour; (ii) no two bichromatic points at distance 1 share a pair. **I use (i) only at generic points** (both `x` and `x + 60°` interior
to arcs), which is weaker than the print's (i).

**Height.** Going counterclockwise, each boundary changes the colour by `+1` or `−1` mod 3; lift to a step function `h` on ℝ (the universal cover),
`h ≡ colour (mod 3)`, jumps `±1`, `h(x + 360) = h(x) + W` with `W` the winding. Let `D(x) = h(x + 60) − h(x)` at generic `x`.

**BV-H1 (band lemma).**
1. (i) at generic points ⟺ `D(x) ≢ 0 (mod 3)` for generic `x`.
2. As `x` moves, `D` changes only when `x` or `x + 60` crosses a boundary: by `±1` when one does; when both do at once (boundaries `b` and `b + 60`)
   by `s − s′ ∈ {−2, 0, 2}` (`s` the step entering at `x + 60`, `s′` the step leaving at `x`).
3. A `±2` jump crosses the value `D − s′`. The pair at `b` is `{h, h + s′}` and at `b + 60` is `{h + D, h + D − s′}` (all mod 3, `h = h(b⁻)`);
   these are equal iff `D ≡ s′`, i.e. iff the crossed value is `≡ 0`. So (ii) forbids exactly the jumps across a multiple of 3.
4. Hence `D` never enters or crosses a multiple of 3: it stays in one band `{3k+1, 3k+2}`.
5. `∫₀³⁶⁰ D = ∫₀³⁶⁰ (h(x+60) − h(x)) dx = ∫₀⁶⁰ (h(y + 360) − h(y)) dy = 60 W`, so the mean of `D` is `W/6 ∈ [3k+1, 3k+2]`. Hence `W ≠ 0`, and
   since `3 | W`, `W ∈ {18k+6, 18k+9, 18k+12}`; with `W > 0` (orientation) `k ≥ 0` and `D ≥ 1`.

Corollaries: a proper circle colouring uses all three colours and is never 2-coloured (`W = 0`); the monochromatic circle is improper.

**BV-L5 (Lemma 5, strongest reading).** Orient so `W > 0`. Put `h′(x) = max_{y ≤ x} h(y)` (finite and attained: `h` drops by `W` per lap leftward).
- `h′` is non-decreasing, jumps only at old boundaries, and only by `+1` (`h′(b⁺) ≤ max(h′(b⁻), h(b⁺)) ≤ h′(b⁻) + 1`). So the new colouring
  `h′ mod 3` is cyclic, constant on each old arc (a recolouring of whole arcs), and creates no new bichromatic point.
- **Kept points keep their pair:** a kept boundary `b` has `h(b⁺) > h′(b⁻) ≥ h(b⁻)`, so `h(b⁻) = h′(b⁻)` and `h(b⁺) = h(b⁻) + 1`; the new pair
  `{h′(b⁻), h′(b⁻)+1}` is the old pair. Every other old boundary becomes an interior point of an arc.
- **Proper.** Let `x` be generic, `M = h′(x)`, attained at `y₀ ≤ x` with `y₀, y₀ + 60` generic (the attaining set is an interval of positive length).
  If `y₀ + 60 ≤ x` then `h(y₀ + 60) = M + D(y₀) > M`, contradicting the maximum; so `y₀ + 60 ∈ (x, x+60]` and `h′(x+60) ≥ M + 3k + 1`. For
  `y ∈ (x, x+60]`, `h(y) = h(y−60) + D(y−60) ≤ M + 3k + 2`. So `D′(x) ∈ [3k+1, 3k+2]`: (i) holds at every monochromatic point (an old boundary
  that became interior sees the same `D′` as its generic neighbours). For (ii): new boundaries `b` and `b + 60` carry `{H, H+1}` and
  `{H + D′(b⁻), H + D′(b⁻) + 1}` with `D′(b⁻) ≢ 0`, so their pairs differ.

**Verdict: TRUE**, in the strongest reading of "remain unchanged" (same position **and** same pair). [hand; 1 mind (BASE-V)]. The pair-preservation is
what Lemma 6's proof needs downstream (a Prop. 18 point of the recoloured colouring must carry the same **pseudo-colour** in the original); a
recolouring that moved an island to the third colour would change the pair — and (plant 1 below) can even be improper, so the merge is the move.

### 1a.3 Statement 2 — Prop. 18 (derived blind; Appendix proof not read)

"Regular" is read as **proper** (the print defines no "regular" circle colouring; without properness the statement is false: nine arcs with three of
them tiny violate (i)).

**BV-C6.** For a cyclic colouring `n = W` (every step `+1`), so by BV-H1 `n ∈ {6, 9, 12} + 18k`: `n = 6, 9, 12, 24, 27, 30, 42, …`. If `n < 9` then
`n = 6`, `k = 0`, the mean of `D` is 1 and `D ∈ {1, 2}`, so `D ≡ 1`: every half-open 60° window holds exactly one boundary, so the six boundaries are
at exact 60° spacing (a regular hexagon) with pairs `{1,2}, {2,3}, {3,1}, {1,2}, {2,3}, {3,1}` in order.

**BV-P18.** Let `n = 3m ≥ 9` (so `m ∈ {3, 4}` with `k = 0`, or `m ≥ 8`). The boundaries of one pair are every third boundary: `P_1, …, P_m` in
order. A window `(P_j, P_j + 60]` holds at most `max D ≤ 3k+2` boundaries, while `(P_j, P_{j+r}]` holds `3r`; so index gap `r ≥ k+1` puts
`P_{j+r}` more than 60° after `P_j`. Choose `P_j, P_{j+k+1}, P_{j+2k+2}`: the three gaps are `k+1, k+1, m − 2k − 2 ≥ k+1` (since `m ≥ 6k+2 ≥ 3k+3`
for `k ≥ 1`, and `m ≥ 3` for `k = 0`). Each of the three arcs between them is `> 60°` and hence `< 240°`, so every chord is `> 1`. **Verdict: TRUE**
[hand; 1 mind]. For `n = 6` the statement fails (two points per pair), which is why the print needs a separate `< 9` branch.

**Exact check** (`tools/base_v_circle.py`, seconds; colourings **given by formula**, never generated): fourteen examples — the hexagon both
orientations; `9×40°`, `12×30°`, `24×15°`, `27` arcs; the same with one or with periodic backtracking islands (`W = 6` with 18 bichromatic points,
`W = 12` with 36, `W = 9` with 27); and improper controls `15×24°`, `18×20°` (BV-C6's excluded `m = 5, 6`), the two-colour hexagon, a single island in
the hexagon, islands at `(20°, 23°)`. On every proper example: band lemma, running-max recolouring proper + cyclic + pairs kept, then Prop. 18's
construction or the hexagon. ALL OK. **Plants, each seen to fail for its own reason (exit 1):** (1) recolour an island to the third colour → "pair
changed at 10" (and that recolouring is improper: colour 2 at 11° and 71°); (2) index gap `k` instead of `k+1` → a degenerate triple; (3) disable (ii)
→ the two-colour hexagon is accepted, the expectation check fires; (4) band lemma fed `18×20°` → "D hits 0 mod 3". One expectation of mine was wrong
and is recorded as such: islands at `(20°, 23°)` in every arc of `9×40°` are improper (they land on the next-but-one island), not proper; the proper
family is `(5°, 8°)` (derived: needs `a < 20°` and `a + len ≤ 20°`).

### 1a.4 Statement 3 — Lemma 6, and the `< 9` branch under H (derived blind; printed proofs of Lemma 6 and Props 16–17 not read)

**The route.** Recolour by BV-L5. The recoloured colouring is cyclic and proper; its bichromatic points are old ones **with the same pseudo-colour**.
- `n ≥ 9`: BV-P18 gives, for each pair, three kept points pairwise more than 1 apart; they are original points with that pseudo-colour. Done.
- `n < 9`: by BV-C6, `n = 6` and the kept points form a regular hexagon `x_1, …, x_6` on `ω(u)` (`|x_k − x_{k+1}| = 1`), with pseudo-colours
  `c′(x_k) = {a_k, a_k + 1}`, `a_{k+1} = a_k + 1` (mod 3). In the **original** pseudo-colouring the arc just before `x_k` has colour `a_k` and just
  after has `a_k + 1` (kept boundary: `h(x_k⁻) = h′(x_k⁻)`), so colour `a_k + 1` sits on `ω(u)` just after `x_k` and just before `x_{k+1}`. (The
  original may have more bichromatic points: e.g. `W = 6` with an island in every sector has 18.)

**BV-HEX: the hexagon cannot occur, under H, with no Condition 5.** Setting: a valid map (a.e.-proper six-colouring, boundaries segments and circular
arcs, unit arcs allowed), `u` a cubic trichromatic vertex with colours {4, 5, 6}, H at `u`. Write `D̄(z, 1)` for the closed unit disc about `z`.

1. **Colour `a_k + 1` near `x_k` lies in `D̄(x_{k+1}, 1)`.** Let `T′` be the colour-`(a_k+1)` tile at `x_{k+1}` adjacent to the arc of `ω(u)` just before
   `x_{k+1}`. Suppose some tile `T` of colour `a_k + 1` has a point `q` within `ρ` of `x_k` with `|q − x_{k+1}| > 1`. For fixed `q`, the continuous
   function `q′ ↦ |q − q′|` on the connected open `T′` exceeds 1 as `q′ → x_{k+1}`, and is `< 1` at points of `T′` near `ω(u)` at angle `ε` before
   `x_{k+1}` (the chord of `60° − ε` is short of 1 by about `(√3/2)ε`, and `ρ ≪ ε ≪ ρ′`). So two interior points of colour `a_k + 1` are at distance
   exactly 1. Symmetrically colour `a_k` near `x_k` lies in `D̄(x_{k−1}, 1)`.
2. **The outward cone.** `K_k := B(x_k, ρ) \ (D̄(x_{k+1}, 1) ∪ D̄(x_{k−1}, 1))` is an open curvilinear sector at `x_k` of angle 60°, containing the outward
   radial segment (`|x_k + s n_k − x_{k±1}|² = 1 + s + s²`). By 1 it holds no colour `a_k` or `a_k + 1`; the third colour of {1, 2, 3} is not in
   `c(x_k)`; so `K_k` is coloured from {4, 5, 6} and `x_k` has at least three colours, hence is a vertex in `B̄(u, 2)`.
3. **H is used here, and only here:** `x_k` is not a vertex of `≥ 4` colours nor one with a repeated colour, so it is cubic trichromatic,
   `c(x_k) = {a_k, a_k + 1, c_k}`, and the open set `K_k` (which meets no edge, since an edge in it would put a colour-`a_k` or `a_k+1` tile in it) lies in
   the single tile `T_{c_k}(x_k)`. Without H, `K_k` could be split among two or three of {4, 5, 6}.
4. **Consecutive cones have different colours.** Let `e = x_{k+1} − x_k` and `t` the unit vector `⊥ e` with `t · n_k > 0`. For `0 < s < ρ`,
   `x_k + s t ∈ K_k` and `x_{k+1} + s t ∈ K_{k+1}` (exact: `|st − e|² = |st + e|² = 1 + s²`, and the other two distances are `1 + √3 s + s²`), and the two
   points are exactly 1 apart. So `c_k ≠ c_{k+1}`.
5. **Each cone's colour faces away at `u`.** Let `C_c` be the closed tangent cone at `u` of the sector of colour `c` (angles `θ_4 + θ_5 + θ_6 = 360°`; a
   horn has `θ = 0`). If `C_{c_k}` holds a direction `d` with `d · n_k > 0`, take `p` in that sector near `u` with `(p − u) · n_k > 0` dominating
   `|p − u|²`; along the radial segment `x_k + s n_k ⊂ K_k`, `|q − p|` is `< 1` at `s → 0` (`|n_k − w|² = 1 − 2 n_k·w + |w|²`) and `> 1` at `s > |p − u|`:
   a violation. So `C_{c_k} ⊂ {d · n_k ≤ 0}`: `n_k` lies in the closed arc of length `L_c = 180° − θ_c` opposite `C_c` (empty if `θ_c > 180°`).
6. **Count.** The directions `n_k` of one colour are pairwise non-adjacent hexagon directions (by 4), i.e. at least 120° apart, inside an arc of length
   `L_c`: at most 1 if `L_c < 120°`, at most 2 if `120° ≤ L_c ≤ 180°`. Six points need every `L_c ≥ 120°`, i.e. `Σ L_c ≥ 360°`; but `Σ L_c ≤ 540° − 360°
   = 180°` (a colour with `θ_c > 180°` contributes no points, and then the other two have `L < 180°` each, at most 2 + 2). **Contradiction.**

Exact identities of steps 2, 4, 5: `tools/base_v_hexagon.py` (sympy, all six `k`); plant `t ↦ −t` fails for its own reason (the inward ray lies inside
`D̄(x_{k−1}, 1)`: `s² − √3 s < 0`).

**What replaces the print's last step.** The print ends Prop. 17 with a 4|2 boundary forced to be a unit arc, contradicted by Condition 5. BV-HEX
never reaches that configuration: H makes each `x_k` cubic, and the cone colours then cannot be placed around `u` at all. **With unit arcs allowed,
H replaces Condition 5 in the `< 9` branch completely**, and nothing in steps 1–6 uses Condition 5, the strip `A(u)`, Prop. 16, or any unit-arc
analysis. Steps 1–6 hold at a cusp or double-cusp `u` (horn sectors enter step 6 with `θ = 0`; the count still closes: e.g. `θ = (0, 180, 180)` gives
at most `2 + 1 + 1 = 4`).

**Verdict on statement 3: TRUE, given its inputs** [hand; 1 mind]: Lemma 6 holds at a cubic trichromatic `u` of a valid map with unit arcs, **given**
that the pseudo-colouring of `ω(u)` is a finite circle colouring satisfying (i) at generic points and (ii), and H at the six points `x_k` (which H at `u`
supplies: `x_k ∈ ω(u) ⊂ B̄(u, 2)`). **Inputs not re-derived here, in the unit-arc setting:** finiteness (with unit arcs, `ω(u)` may carry a boundary arc;
one between two colours of {1, 2, 3} would give a whole arc of two-element pseudo-colour and the circle model breaks); (ii), whose print proof (Prop. 14 via
Prop. 5) uses "Since the arc of ω(y) is not a boundary" and the strip; and (i). These belong to the steps the brief lists as N112-U1 and N2-TOWARD; I
have not read them.

## Stage 1b — SAVED (statement 4, blind)

### 1b.1 Reading log (still blind)

Read nothing new of the paper for 1b. The printed proofs of Lemma 3 (§6.1, Props 12–13, Fig. 5), of Lemma 4 and Props 18–19 (Appendix), and §5
remain unread; no fence touched.

### 1b.2 BV-ND — the NoDouble lemma

**Setting.** `u₁, u₂` with `1 < t = |u₁ − u₂| < 2`; `f₁, f₂` the pseudo-colourings of `ω(u₁)`, `ω(u₂)` in a common triple {1, 2, 3}. The **linkage**
`Φ = {(x, y) ∈ ω(u₁) × ω(u₂) : |x − y| = 1}`. A **double event** is `(x₀, y₀) ∈ Φ` at which, as the linkage moves, `f₁` switches `α → β` at `x₀` and
`f₂` switches `β → α` at `y₀` at the same instant (the height difference `g = h₁(x) − h₂(y)` then jumps by ±2).

**Statement.** No double event exists when, at `x₀` and at `y₀`, the α-sector and the β-sector the circle passes between are adjacent (share an edge):
true at plain points, cubic vertices, and degree-4 bichromatic vertices. **Condition 5 is not used.**

**Proof.** Let `e = x₀ − y₀`, `τᵢ` the unit tangent of `ω(uᵢ)`, velocities `λ₁τ₁`, `λ₂τ₂` (`λᵢ ≠ 0`: at a turning point nothing switches), and
`μ := e·λ₁τ₁ = e·λ₂τ₂` (differentiate `|x − y| = 1`).
1. `μ ≠ 0`: `μ = 0` forces `τ₁ ⊥ e` and `τ₂ ⊥ e`, i.e. `x₀ − u₁ = s₁e`, `y₀ − u₂ = s₂e`, so `u₁ − u₂ = (1 − s₁ + s₂)e` has length 1 or 3, not in (1, 2).
2. Say `μ < 0`. The α-sector `S_α(x₀)` holds the back half-tangent `−λ₁τ₁`, with `e·(−λ₁τ₁) > 0`; so it has points `q` with `|q − y₀| > 1` near `x₀`.
   For α-sectors `S_α(x₀)`, `S_α(y₀)` (connected, open) the distances of interior pairs form an interval avoiding 1 (a.e.-properness), so they are
   **all > 1**. The β-sector `S_β(x₀)` holds `λ₁τ₁` with `e·λ₁τ₁ < 0`, so its pairs with `S_β(y₀)` are **all < 1**. (`μ > 0`: swap α, β.)
3. Letting the partner point tend to its vertex: `S_α(y₀) ⊂ ℝ² \ D(x₀, 1)`, `S_β(y₀) ⊂ D̄(x₀, 1)`, and symmetrically at `x₀` with `y₀`. The α|β edge
   at `y₀` lies in `cl S_α ∩ cl S_β ⊂ ω(x₀)`, and the α|β edge at `x₀` lies in `ω(y₀)`: **two unit arcs, each centred at the other point.** Under
   Condition 5 this is already the contradiction.
4. **With unit arcs allowed**, the two edges leave `x₀` and `y₀` tangentially (`⊥ e`), in directions `σ₁τ`, `σ₂τ` (at a plain point both directions are
   available). With `y₀ = 0`, `x₀ = (1, 0)`, edge points `a(θ) = (cos θ, sin θ)` and `b(φ) = (1 − cos φ, sin φ)`: `|a(s) − b(s)|² = (2 cos s − 1)² < 1`
   and `|a(s) − b(−s)|² = (2 cos s − 1)² + 4 sin² s > 1` for small `s > 0`. If `σ₁ = σ₂`, α-points just off the two edges are at distance `< 1`,
   contradicting "all > 1"; if `σ₁ = −σ₂`, β-points just off the edges are at distance `> 1`, contradicting "all < 1". (Points just on the α-side of
   an α|β edge lie in `S_α`, a horn included: two distinct tangent arcs separate at order `s²`.) ∎

Exact identities: `tools/base_v_linkage.py` (K3, K4). **Cusps are irrelevant** (step 4 needs only one edge direction per point). **Where the hypothesis
bites:** a bichromatic vertex of degree ≥ 6 can be crossed between two non-adjacent sectors; H excludes every vertex of degree ≥ 4 in `B̄(u₁, 2)`
(each has four colours or a repeated colour), and the linkage's `x₀, y₀` lie in `B̄(u₁, 2)` (`|y − u₁| ≤ 2` on `Φ`).

### 1b.3 BV-L3 — Lemma 3 by the unit-distance linkage

**Statement derived.** Let `u₁, u₂` have the same multicolour {4, 5, 6} and `1 < t < 2`. Suppose the pseudo-colourings `f₁, f₂` of `ω(u₁)`, `ω(u₂)`
are finite proper circle colourings in {1, 2, 3} whose generic points are interior points of tiles of their pseudo-colour, and the double-event points
satisfy BV-ND's adjacency. Then a.e.-properness fails. Hence Lemma 3, wherever the print supplies those inputs.

**Proof.**
1. **The linkage is one loop, and neither circle is swept.** `y` ranges over `Y = {y ∈ ω(u₂) : |y − u₁| ≤ 2}`, a proper arc (the far point of
   `ω(u₂)` is at distance `t + 1 > 2`); over interior `y` there are two `x`, merging at the ends of `Y`; so `Φ` is a circle. Likewise `x` ranges over a
   proper arc. The height lifts `h₁`, `h₂` are single-valued functions of position there (K1).
2. **At an intersection point** `P ∈ ω(u₁) ∩ ω(u₂)` (generic, in a tile `T`): `f₁(P) = f₂(P) = colour(T)`, so `c₀ := h₁(P) − h₂(P) ∈ 3ℤ`. The two
   linkage partners of `x = P` are `y = R_{u₂}^{±60°}P` (K2): configurations `A`, `B` of `Φ`.
3. **Band.** Orient `ω(u₂)` so `W₂ > 0`; by BV-H1, `D₂ ≥ 1`. So `g_A = c₀ − D₂(P) ≤ c₀ − 1` and `g_B = c₀ + D₂(R^{−60°}P) ≥ c₀ + 1`: along `Φ`
   from `A` to `B`, `y` sweeps the 120° arc through `P` (step 1), and `x` leaves `P` and returns (net zero).
4. **No way through `c₀`.** At a generic pair `f₁(x) ≠ f₂(y)` (two interior points of one colour at distance 1), so `g ≢ 0 (mod 3)` on open sets; a
   ±1 jump cannot pass `c₀`; a ±2 jump across `c₀` is exactly a double event (the same computation as (ii) in BV-H1). BV-ND excludes it. ∎
   Non-generic `P`: take `x*` near `P` on `ω(u₁)` and `Q` near `P` on `ω(u₂)`, both in the tile `T` beside the boundary through `P`, generic; then
   `g` at `(x*, y*₊)` is `≤ c₀* − 1` or `≡ 0` (itself a violation), and symmetrically at `(x*, y*₋)`.

**What it uses.** Same multicolour enters once: both circles are coloured in the one triple {1, 2, 3}, so `f₁(x) ≠ f₂(y)` is a real constraint (with a
seventh colour the complement has four colours and there is no band, which is why the hexagonal 7-colouring has same-multicolour vertices at distance
≈ 1.83). `1 < t` enters in steps 1 and BV-ND.1; `t < 2` in step 2. **Nothing about the angles or cusps at `u₁`, `u₂` is used**: cusp and double-cusp
vertices are covered verbatim. The hypothesis "boundaries extend from each" enters only through the inputs (the strips). Condition 5 enters **only**
through the inputs: the strip existence (Props 9–10), finiteness, and the properness of `f₁, f₂` (Props 14–15).

**The inputs at cusps, under Condition 5** (re-derived for the cusp question, from the print's statements, whose proofs I read):
- Prop. 9 holds a.e.: its engine, Prop. 2, holds for interior points `z` (the unit circle about a point near `z` crosses the α-side of the α|β curve
  unless that curve lies on a unit circle); nothing uses the sector angles, so a horn (`x₄₅(δ) ≈ x₄₆(δ)`) is harmless.
- Prop. 10 at a cusp: `v ∉ Int A ∪ Int B` forces `h_δ(v) = 1` for every small `δ` (as `A_δ`, `B_δ` are open), so an edge at `u` meets `ω(u + v)` in
  infinitely many points accumulating at `u`, hence is a unit arc: Condition 5. The argument never uses that the three `x_{ij}` are apart.
- At a double cusp (`θ = (0, 0, 360°)`) colour 6 straddles every normal and is excluded near all of `ω(u)`; horns 4, 5 are confined to the inner side on
  the half toward the cusp direction and the outer side on the other half, consistent with the strip on the opposite side.

**Unit arcs under H.** BV-ND holds with unit arcs. H makes every vertex of `B̄(u₁, 2)` cubic, which is BV-ND's adjacency. **Not replaced by H:** the
strip. With unit arcs, Prop. 10 fails exactly at the points `y ∈ ω(u)` that centre a unit-arc edge at `u` (at most one per edge), and the finiteness
of `f` fails if `ω(u)` carries a boundary arc between two colours of {1, 2, 3}. Those are inputs of the kind the brief assigns to N112-U1 and
N2-TOWARD. I have not derived them.

### 1b.4 BV-C3 — Corollary 3 at cusps (Condition 5)

`u₁` {4, 5, 6}, `u₂` {1, 2, 3}, `t < 2`. At an intersection point `P` the two strips (one-sided bands of width `η`, coloured {1, 2, 3} beside `ω(u₁)` and
{4, 5, 6} beside `ω(u₂)`) cross in a small curvilinear quadrilateral, since the circles cross transversally for `0 < t < 2`. Its interior must be
coloured from `{1, 2, 3} ∩ {4, 5, 6} = ∅`. Only the strips near `P` are needed (not the closed curves of Prop. 11), and the strips exist at cusps
(1b.3). **Verdict: TRUE** at cusp and double-cusp vertices, under Condition 5 [hand; 1 mind]. With unit arcs, a strip may pinch at `P` if `P` centres a
unit-arc edge at `u₁` or `u₂`; the other intersection point `P′` then serves unless it pinches too. That case is not closed here.

### 1b.5 Lemma 4 at cusps — what I derived, and the GAP

Derived: (a) at a cusp or double-cusp `u`, the pseudo-colouring route to Lemma 6 is unchanged (BV-H1, BV-L5, BV-P18 are circle-abstract; BV-HEX's count
closes with horns); (b) the strips exist at cusps (1b.3); (c) the two refuters Lemma 4 feeds, Lemma 3 and Corollary 3, hold at cusps (BV-L3, BV-C3).
(d) Two facts I would use: a tile has diameter `≤ 1`, and the common boundary of two tiles of colours `a`, `b` has diameter `≤ 1` (Prop. 1 a.e.). So from
each of Lemma 6's three `{a, b}`-points `x_i` (pairwise `> 1` apart) the `a|b` boundaries are distinct, and their endpoint vertices `{a, b, c}` lie
within 1 of `x_i`. If `c` is the third colour of {1, 2, 3} and the endpoint is within `< 2` of `u`, Corollary 3's case is reached.

**GAP (mine, blind):** I did not derive Prop. 19(b) ("the bichromatic boundaries extending from their point on the circle end at a tricolor point
inside the circle"), nor the final step of Lemma 4 that turns the nine endpoint vertices `{a, a+1, c}`, `c ∈ {4, 5, 6}`, into either a
same-multicolour pair at distance in (1, 2) or a disjoint pair within 2. The pigeonhole I tried (nine vertices, nine possible multicolours) does
not close. A second-circle route looks promising: a vertex `{1, 2, 4}` near `ω(u)` has complement {3, 5, 6}; Lemma 6 on its own circle gives three
`{5, 6}`-points pairwise `> 1` apart; an endpoint `{4, 5, 6}` in `(1, 2)` from `u` is (a). But it needs the endpoint positions, which is Prop. 19(b)'s
content. **So Lemma 4 at cusps: GAP at Prop. 19(b) and the final selection, as far as this blind stage goes.** Stage 2 reads the Appendix and asks
whether its steps use anything a horn breaks.

### Would-have-searched-here log

| move I would have made by search | what I did instead |
|---|---|
| random property test of Lemma 5 / Prop. 18 over generated circle colourings | hand proofs BV-H1, BV-L5, BV-P18; exact check on 14 colourings given by formula, plus 4 plants |
| numeric sampling of placements of the hexagon's cone colours around `u` | the counting argument BV-HEX step 6 (a closed-form bound) |
| floating-point test of the cone/ray geometry | exact sympy identities (`tools/base_v_hexagon.py`) |
| numeric search for a double event on sampled circle colourings (to test BV-ND) | the first-order motion + exact disc-inclusion proof, and the closed-form edge distances (K4) |
| a search for the Lemma 4 configuration (nine endpoint vertices) on sampled maps | named the GAP (1b.5) instead |

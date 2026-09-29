# FS116-V3 — a blind second mind on five round-3 statements of FS-116's list

*Job FS116-V3 (Ephodos, verification form; blind, the same model as the minds whose work it will later compare against, Opus 5.5).
Brief: `data/fs116/briefs/FS116-V3-verify.md`; standing rules `plans/STANDING-RULES.md`. The statements are `data/fs116/claims.md` § 11,
frozen by Keryx 2026-09-29 07:09 UTC. Record written 2026-09-29 from 07:10 UTC.*

## Theorems this phase proved

*(Filled at each stage. Stage 1 proved nothing: it is the readback and the registered expectations.)*

- **V3-GERM-R** — FS116-N1-GERM-R as stated: TRUE — [hand], § 2.2; bookkeeping by `tools/fs116_v3_germ.py` (exact at the ends).
- **V3-GERM-R-EDGE** — GERM-R with any end of `v⁻`'s or `v⁺`'s interval closed is FALSE (and by the mirror `u±`'s): four pairs of one-colour
  tiles by formula, each with a hand bound — [hand], § 2.3 item 3; sampled by `tools/fs116_v3_boundary.py` (a check of the bound, not a proof).
- **V3-GERM-S** — FS116-N1-GERM-S as stated: TRUE — [hand], § 2.4, over V3-GERM-R.
- **V3-TOUCH** — FS116-N1-TOUCH as stated: TRUE, its hypothesis "`w` in the closure of a tile of one of `p`'s colours" idle — [hand], § 3.1.
- **V3-ECHO-ONLY** — under ECHO's ring hypothesis alone (any `k`, no saturation, no density): every point of `ω(w)` in the closure of an
  `X`-tile is `2w − p` — [hand], § 3.3.
- **V3-ECHO-B** — FS116-N1-ECHO corrected (`w` an essential boundary point, saturated there): TRUE — [hand], § 3.3, over V3-ECHO-ONLY.
- **V3-ECHO-A** — FS116-N1-ECHO read with saturation at `w` vacuous off the essential boundary: FALSE, the hexagonal seven-colouring —
  [hand] (validity) + [tools] at named points (`tools/fs116_v3_echo.py`), § 3.3.
- **V3-AXIS** — FS116-N1-AXIS as stated: TRUE; (a) and (d) need no saturation — [hand], § 3.5.
- **V3-AXIS-STRIP** — at the strip's midline vertex (unsaturated) AXIS (a), (c), (d) hold and (b) fails; at SQ9 (`k = 9`) (a)–(c) hold and
  (d) fails — [tools] at named points (`tools/fs116_v3_axis.py`, floats with margins), § 3.6.

## Would-have-searched-here log (standing rule 5)

- Stage 1: none — a readback and predictions.
- Stage 2: would have sampled random one-colour tile pairs near `y` to probe GERM-R's ends → instead derived the second-order bounds of § 2.3
  by hand and built four pairs by formula; the tool evaluates those four objects only.
- Stage 3: would have scanned angles `ψ` and colourings for an ECHO-(A) counterexample → instead took the one colouring the list names as a
  control (the hexagonal seven-colouring), fixed `ψ = 20°`, and checked that point only. Would have searched unsaturated fragments for a
  (Q) arc at AXIS (c)'s germs → instead read the one held unsaturated object with such a vertex (the strip), which does not decide it.

## Fence log (standing rule 8)

- Stage 3 (07:33 UTC on): no fenced path opened; reads were `LEDGER.md` rows 135–136 (by `grep`) and `plans/FS112-Y-construction.md` § 1.3 (open).
- Stage 2 (07:26–07:32 UTC; corrected from `git log`): no fenced path opened; reads were `plans/FS111-M-regularity.md` § 2.4–2.6 (R7, open).
- 2026-09-29 07:10–07:24 UTC: no fenced path opened. Searches this stage were `grep` for headings inside open files
  (`plans/FS114-derivation.md`, `plans/FS110-N-proof.md`, `plans/FS112-N-proof.md`, `plans/FS111-M-regularity.md`,
  `.claude/skills/ephodos/scripts/derive_gate.py`, `.claude/agents/ephodos.md`) and printed no fenced text.

## Stage 1 — SAVED: the readback and the registered expectations

### 1.1 Files read, in order

1. The brief, `data/fs116/briefs/FS116-V3-verify.md` (in full), and `plans/STANDING-RULES.md` (in full).
2. `data/fs116/claims.md` (in full: §§ 0–11), and `data/fs114/claims.md` (in full).
3. `plans/FS114-derivation.md`: the header and § 3's entries (lines 1–23, 411–770) — statements, *uses only*, *not claimed*, minds,
   models; not the records their `argument:` lines point to.
4. `plans/FS112-derivation.md`, header and § 1's first entries (FS112-WALK, FS112-U1, FS112-SIX, FS112-NB4P).
5. `plans/FS110-N-proof.md` § 1.3–1.4 (N-E0, N-E1, N-E2 with their proofs); `plans/FS112-N-proof.md` headings and the lines naming N-E0–N-E2.
6. `plans/FS111-M-regularity.md` § 2.1–2.2 (the two readings of saturation, M-SATC) and § 3 (M-PINCH's setting and proof).
7. `.claude/skills/ephodos/scripts/derive_gate.py` (the grammar and the verification lint), `example-verification.md`, and
   `.claude/agents/ephodos.md` lines 490–520 (the two vocabularies).

### 1.2 Quotation check (standing rule 3)

`tools/fs116_v3_quotes.py` extracts each of the five statements the brief quotes and the same statement from the claim list's § 11 and
compares them character for character: **identical: 5 of 5** (731, 1204, 834, 547 and 1144 characters). Planted fault (one character
of the first quotation changed in memory): **identical: 4 of 5** — it fires (control `v3-quotes` below). Each of the five `> — source:`
lines names `data/fs116/claims.md § 11`, which holds the statements.

**One slip in the brief, not in a quotation:** § Fences reads "Until your verdicts on all three statements are committed"; the job has
five statements. I read it as five: nothing fenced opens before all five verdicts are committed.

### 1.3 The statements restated (the readback)

Notation mine, fixed here: `p` the centre, `r(θ) = p + e(θ)`, `e(θ) = (cos θ, sin θ)`, angles counter-clockwise; "just clockwise of
`r(θ)`" is the germ `{r(θ − t) : 0 < t < t₀}` of `ω(p)`, "just counter-clockwise" `{r(θ + t)}`. A tile *approaches* a point `y` along
`β` when it has points `y + s·d` with `s → 0⁺` and `d → e(β)`, equivalently when `β` lies in the closed cone of one of its sectors at
`y` (a cusp horn along `β` included). `P_cl(x)` is the set of colours of tiles whose closure contains `x` ("the colours of `x`");
"absent at `p`" means not in `P_cl(p)`. An arc of `Γ` on `ω(p)` is an arc of radius 1 centred at `p`, so it is (Q) exactly when `p`
carries both of its side colours (`p` having at least four colours).

- **GERM-R.** For any `k`, any point `p`, any `y = r(ψ)`: if the germ `v⁻` (just clockwise of `r(ψ − 60°)`) lies in the closure of a
  colour-`c` tile, no colour-`c` tile approaches `y` along any `β` with `β − ψ ∈ (150°, 330°)`; the other three germs likewise, with
  the intervals as stated. The six boundary directions are not claimed.
- **GERM-S.** Six colours, `p` with at least four colours, `y` a change point (the ring off `Γ` on both sides of `y`, colours `X`
  counter-clockwise and `X̄` clockwise, `X ≠ X̄`). Then `|P_cl(p)| = 4` and `{X, X̄}` is the absent pair; (i) with `v⁻`, `u⁺` off (Q)
  arcs, each direction of the open 60° cone at `y` about the direction to `p` is in the cone of a tile whose colour `c` is a colour of
  `p` and every `c`-tile at `p` lies in `B̄(y, 1)`; (ii) with `u⁻`, `v⁺` off (Q) arcs, each direction of the open 60° cone about the
  direction away from `p` is in the cone of a tile that is not a tile at `p`, whose colour `c` is a colour of `p`, and every `c`-tile
  at `p` misses `B(y, 1)`; (iii) with all four off (Q) arcs, `y` has at least four colours.
- **TOUCH.** Six colours, `|P_cl(p)| = 4`, `w ∈ ω(p) ∩ cl(T)` for a tile `T` of a colour of `p`, `w` not a change point and on no
  arc of `Γ` on `ω(p)`, the four germs at `w ± 60°` off (Q) arcs. Then both ring germs at `w` are in tiles of one absent colour `X`;
  each of the four germs is in the closure of an `X̄`-tile and of no `X`-tile; no `X̄`-tile has `w` in its closure.
- **ECHO.** Any `k`, disc of radius above 2, `w ∈ ω(p)` with both ring germs at `w` in tiles of one colour `X ∉ P_cl(p)`; if the
  fragment is saturated at `w` and `X ∈ P(w)`, then `2w − p ∈ cl` of an `X`-tile. Not claimed: `X` of density 0 at `w`.
- **AXIS.** Six colours, `p` a degree-4 vertex of four colours, edges the four half-axes, quadrant tiles `T_I … T_IV` of colours
  `c_I … c_IV`, absent `X, X̄`, the fragment saturated on some disc about `p`. At `q_N = (0, 1)` (with `p` the origin): (a) tiles
  approaching along directions in `(180°, 360°)` are `X` or `X̄`; (b) a `c_IV`-tile approaches along `0⁺` and a `c_III`-tile along
  `180⁻`, both above `y = 1`; (c) the germs just counter-clockwise of `r(30°)` and just clockwise of `r(150°)` lie on no (Q) arc;
  (d) if the germs just clockwise of `r(30°)` and just counter-clockwise of `r(150°)` lie on no (Q) arc, the tiles approaching along
  `(180°, 360°)` have one colour and `q_N` is not a change point; the same at `q_E, q_W, q_S` turned.

**Terms not fixed, asked, and ruled** (asked 2026-09-29 07:22 UTC; Keryx's answer, quoted in part: *"Treat it as an ambiguity of the
statement: give ECHO's verdict under (A) and under (B), and say which reading the statement should name (MISSTATED with the corrected
wording is a finding). (2) Your reading of "at distance exactly 1 from the support of each colour" stands: the unit circle T₁(x) meets
supp S_j, as FS111-M-regularity § 2.1 derives it"*):
- **"saturated at w"** (ECHO). (A) § 0's property at the one point `w`: if `w` is an essential boundary point, it is at distance
  exactly 1 from the support of each colour of `P(w)`; otherwise nothing to check. (B) `w` is an essential boundary point
  (`|P(w)| ≥ 2`) and is so saturated (FS111-M's "saturated point", which presupposes `x ∈ ∂_e S_j`). ECHO is worked under both.
- **"at distance exactly 1 from the support"** (ECHO, AXIS): `ω(x) ∩ supp S_j ≠ ∅`, `supp S_j = cl S̃_j` — the contact reading. The
  literal `dist(x, supp S_j) = 1` is empty for `j ∈ P(x)`.

### 1.4 What I was given (the `given:` line's long form)

Before any verdict: the five statements verbatim; the whole frozen claim list (§§ 0–11), which holds, beside definitions, the statements
of RING-GERM (§ 10: the non-Siamese form GERM-S extends) and of FS114-N7-3T (§ 8), whose statement carries N7-HUB's one-sentence sketch
("the directions toward `p` there lie in tiles of `p` reaching `y_k`, a tip, which meets `B(y_{k−1},1) ∩ B(y_{k+1},1)`, so its colour
is carried at `y_{k±1}` by no other tile, and the outward directions in tiles of `p`'s colours outside `B̄(p,1)` whose `p`-tiles face
away"); FS114-N3-LOCAL's lemma statements (N3-FACE, -HALF, -SEC, -FLANK, -PAIR, -ODD) and the other § 3 entries of
`plans/FS114-derivation.md` (N6-RING60, N7-QOPP, N7-FLANK, N7-CHAIN among them); N-E0–N-E2 with proofs; M-PINCH with its proof; the
brief's sentence that "two extend a ring lemma to fragments with Siamese pairs, which the question allows, and three describe the
configurations its saturated-class claims stall at". Not given: any verdict on these five, their proposing record, any sketch of their
proofs, the round-1 and round-2 records. I had met none of the five statements before this session.

### 1.5 The registered expectations (honest about their timing)

These were written at 07:24–07:25 UTC (the stage-1 commit is 02:25:26; times corrected at stage 3 from `git log`), **after** reading the statements and the held inputs and after working the arguments in my head
during the readback for about twenty minutes — so they are informed predictions, not naive ones, and a high hit rate here measures
little. Nothing of the derivations was written before them.

| statement | expected verdict | probability | likeliest break |
|---|---|---|---|
| GERM-R | derived | 0.95 | a tile reaching `y` only along a boundary direction, or a cusp at `y` — both outside the claim as posed |
| GERM-S | derived | 0.90 | a germ at `y ± 60°` on a non-(Q) arc of `Γ` whose absent side colour is not the one the exclusion needs |
| TOUCH | derived | 0.85 | an idle hypothesis ("in the closure of a tile of one of `p`'s colours" looks unused: a thin truth, not a break), or `w` an end of a `Γ`-arc on `ω(p)` |
| ECHO | refuted (a monster at "saturated at `w`") | 0.75 | reading (A) with `w` inside an `X`-tile, where saturation at `w` checks nothing; under (B) I expect it true |
| AXIS | derived | 0.85 | (b)'s "above the line `y = 1`", or (d) when the germ at `r(30°)` lies on `Γ` with both absent colours |

### 1.6 The blocks

The `verification:` blocks and the controls live in § The verification blocks and controls, at the end of this record, and are
updated in place at each stage (git holds each stage's state). Their `predicted:` lines are stage 1's and are never edited; at stage 1
their verdict lines were placeholders ("stalls at: stage 1 — not yet derived"), which the stage-1 gate scored and which count for nothing.

## Stage 1 — SAVED

## Stage 2 — SAVED: GERM-R and GERM-S — derivation, attack, verdicts

Written 2026-09-29, 07:26–07:32 UTC (corrected at stage 3 from `git log`: the stage-2 commit is 02:32:35; the draft said "from 02:30"). Tools of this stage: `tools/fs116_v3_germ.py` (the first-order bookkeeping, exact at the ends of
each interval), `tools/fs116_v3_boundary.py` (the boundary models of § 2.3). Neither searches: each evaluates objects given by formula.

### 2.1 Three facts used throughout (the held calculus, re-read)

- **(S) the straddle.** If `T`, `T′` are tiles of one colour (possibly `T = T′`) and `T′ × T` holds one pair at distance below 1 and
  one above, the fragment is invalid: `T′ × T` is connected and the distance continuous, so some pair of interior points of one colour
  is at distance exactly 1. This is N-E0 with N-E2's connectivity step; it reads no angle and no density, and no non-Siamese hypothesis.
- **(E1)** N-E1: if `u ∈ cl T`, `T` of colour `j`, then `ω(u)` meets no tile of colour `j`. So `ω(p)` off `Γ` lies in tiles of colours
  absent at `p`.
- **(E2)** N-E2: two tiles `T`, `T′` of one colour with `u ∈ cl T`, `u′ ∈ cl T′` and `|u − u′| = 1` are **Siamese** (`T ⊆ B̄(u′, 1)`, `T′ ⊆ B̄(u, 1)`) or
  **outer** (`T ∩ B(u′, 1) = ∅`, `T′ ∩ B(u, 1) = ∅`); `T = T′` is Siamese.
- **(G) germs.** `Γ` is a locally finite union of segments and circular arcs, so near any point `ω(p) ∩ Γ` is finite or contains an arc:
  each germ of `ω(p)` lies in one tile or in one arc of `Γ` on `ω(p)` — an arc of radius 1 about `p` — whose points are in the closures
  of exactly its two side tiles (one tile twice for a slit). Such an arc is (Q) iff `p` carries both side colours (`p` has ≥ 4 colours).

### 2.2 GERM-R — derived

Rotate so that `ψ = 0`, `p = 0`, `y = r(0)`. A germ `g` is `z_g(t) = r(60°σ + τt)`, `0 < t < t₀`, with `σ = −1` for `v`, `+1` for `u`,
`τ = −1` for "just clockwise", `+1` for "just counter-clockwise". The angle from `y` to `z_g(t)` at `p` is `60° + στt`, so

  `|z_g(t) − y|² = 2 − 2cos(60° + στt) = 1 + √3·στ·t + O(t²)`,

and `u_g := z_g(0) − y` is a unit vector: `r(−120°)` for `v±`, `r(120°)` for `u±`. Put `s_g = στ` (`+1`: the germ is just outside
`ω(y)`, for `v⁻` and `u⁺`; `−1`: just inside, for `v⁺` and `u⁻`) and `F_g = {β : s_g⟨e(β), u_g⟩ > 0}` — the directions along which a
point leaving `y` moves across `ω(z_g(0))` toward the germ's side. By hand, `⟨e(β), r(−120°)⟩ > 0 ⟺ β ∈ (150°, 330°)`, so
`F_{v⁻} = (150°, 330°)`, `F_{v⁺} = (−30°, 150°)`; `⟨e(β), r(120°)⟩ > 0 ⟺ β ∈ (30°, 210°)`, so `F_{u⁺} = (30°, 210°)`,
`F_{u⁻} = (−150°, 30°)` — the four intervals of the statement. `tools/fs116_v3_germ.py intervals` checks the signs `s_g` and the vectors
`u_g` symbolically, the inner products at every stated endpoint exactly (all 0), and `F_g` against the stated interval on a 0.05° grid:
**0 of 4 mismatched**; with the intervals of `v⁺` and `u⁻` exchanged (the plant), **4 of 4** (control `v3-germ-intervals`).

*The step.* Let `g ⊆ cl T`, `T` of colour `c`, and let a tile `T′` of colour `c` approach `y` along `β ∈ F_g`: there are `a_n ∈ T′`,
`a_n → y`, `d_n := (a_n − y)/σ_n → e(β)`, `σ_n := |a_n − y|`, and `κ := s_g⟨e(β), u_g⟩ > 0`. For `t` small,

  `|z_g(t) − a_n|² − 1 = s_g(√3 t − 2σ_n κ_n) + O(t² + σ_n t + σ_n²)`,   `κ_n := s_g⟨u_g, d_n⟩ → κ`,

(using `z_g(t) − y = u_g + O(t)` and `s_g² = 1`). At `t = σ_n²` the bracket is `−2σ_nκ_n + O(σ_n²)`; at `√3 t = 4σ_n` it is
`σ_n(4 − 2κ_n) + O(σ_n²) ≥ σ_n(2 − o(1))`. So for `n` large the quantity takes both signs as `t` varies; replacing `z_g(t) ∈ cl T` by a
point of `T` close enough keeps both signs, and (S) makes the fragment invalid. Hence no such `T′`. ∎

*Uses only:* validity (no two interior points of one colour at distance exactly 1) and that tiles are open and connected; not `k`, not
non-Siamese, not the degree or the colours of `p`, and not the radius beyond a neighbourhood of `ω(p)` (§ 2.3).

### 2.3 Attack on GERM-R

1. **Smallest cases.** `k = 1`: no valid fragment on a disc of radius above 1 exists (it holds interior points at distance 1), so the
   statement is vacuous; `k = 2` onward it has content. `y` a vertex, `y` off `Γ`, `T = T′`, a cusp `T′`: the step reads only a sequence
   `a_n → y` along `β`, so each is covered.
2. **Each hypothesis removed.** "Radius above 1": the step reads points near `y` and near the germs, all on `ω(p)`, and a fragment on
   `B̄(p, 1)` is a map of an open set containing `ω(p)` — so the statement holds at radius exactly 1 too (a thin truth of no consequence).
   "Siamese pairs allowed", "for any `k`": nothing to remove; neither is used. "`v⁻` in the closure of a colour-`c` tile": needed —
   without it nothing constrains colour `c` at `y`.
3. **Where the attack succeeds: the closed intervals.** The statement's *not claimed* line excludes the six boundary directions; I tested
   whether that exclusion is needed or merely cautious. It is needed: at each end of `v⁻`'s interval and at each end of `v⁺`'s, a
   colour-`c` tile holds the germ in its closure while another colour-`c` tile approaches `y` exactly along the end direction, with no
   unit pair between them. With `p = 0`, `y = (1, 0)`, `z₀ = r(−60°)`, `H = S = 0.2`:
   - `T_out = {ρ r(−60° − τ) : 0 < τ < H, 1 < ρ < 1 + H}` (its closure holds `v⁻`), and the horn
     `T′ = {y + s r(150° + φ) : 0 < s < S, |sin φ| < s/4}` between the two circles of radius 2 tangent at `y` to the ray along
     `ψ + 150°` (its only direction at `y` is `ψ + 150°`). With `ρ = 1 + r` and `z₀ − y = r(−120°)`:
     `|z − y|² − 1 = ρ(r + 1 − 2cos(60° + τ)) ≥ r + √3 sin τ ≥ r + 1.7τ` (for `τ ≤ 0.2`), `⟨z₀ − y, r(150° + φ)⟩ = sin φ`, and
     `|⟨z − z₀, ·⟩| ≤ |z − z₀| ≤ r + τ`, so
     **`|z − a|² − 1 ≥ r(1 − 2s) + τ(1.7 − 2s) + s²/2 > 0`** on `T_out × T′`: all distances exceed 1 (an outer pair).
   - The same `T_out` with the horn along `ψ + 330°` (`⟨z₀ − y, r(330° + φ)⟩ = −sin φ`): the same bound.
   - `T_in = {ρ r(−60° + τ) : 0 < τ < H, 1 − H < ρ < 1}` (its closure holds `v⁺`) with the crescent horn
     `{y + s r(150° + φ) : 0 < s < S, s < sin φ < 2s}` (inside the circle of radius 1/2 and outside the circle of radius 1/4 tangent
     at `y` to the ray, on `z₀`'s side): `|z − y|² − 1 = −ρ(r + √3 sin τ − (1 − cos τ)) ≤ −0.8(r + 1.6τ)`, so
     **`|z − a|² − 1 ≤ −r(0.8 − 2s) − τ(1.28 − 2s) − s² < 0`**: all distances below 1 (a Siamese pair). The end `ψ − 30°` of `v⁺`'s
     interval: the mirror horn (`−2s < sin φ < −s`), the same bound.
   Each pair of tiles has diameter below 1 (`T_out`, `T_in`: 0.296; horns: below 0.4). Cut the rest of an open disc of radius 1.2 about
   `p` into finitely many pieces of diameter below 1 by segments, each its own colour: a valid `k`-coloured fragment, `k` finite, in which
   the one repeated colour is the pair's. `tools/fs116_v3_boundary.py` samples each pair on grids dense at the corner and finds `F`
   of one sign, the hand bound holding at every sample, **4 of 4**; with each horn moved to the wrong side (the plant), **0 of 4**
   (control `v3-germ-endpoints`). The mirror in the line through `p` and `y` carries these to `u⁺`'s and `u⁻`'s ends. **So GERM-R with
   any closed end is FALSE**: the *not claimed* line is the statement's edge, not caution. These objects confirm that line and are not
   counterexamples to the statement.
4. **The germ on `Γ` with colour `c` on neither side** (the second *not claimed* clause): then `v⁻` lies in the closure of no colour-`c`
   tile, and the statement's hypothesis fails — the clause excludes nothing the hypothesis admitted. Wording only; no finding.

**Verdict: GERM-R derived** (TRUE), [hand], its bookkeeping checked by `v3-germ-intervals`; its open intervals sharp by `v3-germ-endpoints`.

### 2.4 GERM-S — derived

Six colours; `p` with `|P_cl(p)| ≥ 4`; `y = r(ψ)` a change point: the ring germs `r(ψ − t)` and `r(ψ + t)` lie in tiles `R⁻` (colour
`X̄`) and `R⁺` (colour `X`), `X ≠ X̄`.

*Step 0 (the colours of `p`).* By (E1) `X, X̄ ∉ P_cl(p)`; with six colours and `|P_cl(p)| ≥ 4`, `|P_cl(p)| = 4` and the absent pair is
`{X, X̄}`.

*Step 1 (each germ's absent colour).* Each germ at `y ± 60°` is 60° from one ring germ at `y`: `z_g(t)` and `r(ψ + τt)` are at distance
exactly 1, and `r(ψ + τt) ∈ R^τ`. By (E1) at `z_g(t)`, no tile with `z_g(t)` in its closure has `R^τ`'s colour: `v⁻`, `u⁻` (`τ = −1`)
carry no `X̄`; `v⁺`, `u⁺` (`τ = +1`) carry no `X`. A germ on no (Q) arc lies in the closure of a tile of an absent colour — off `Γ` by
(E1), on a non-(Q) arc because `p` misses a side colour (G). With exactly two absent colours: **`v⁻, u⁻ ⊆ cl(X-tile)` and
`v⁺, u⁺ ⊆ cl(X̄-tile)`**. (`tools/fs116_v3_germ.py cones` re-does this pairing and the cone inclusions below mechanically: 2 of 2;
plant — `u⁺` paired with the wrong ring germ — 1 of 2; control `v3-germ-cones`.)

*Step 2, (i).* With `v⁻`, `u⁺` off (Q) arcs, GERM-R (§ 2.2) forbids `X` along `ψ + (150°, 330°)` and `X̄` along `ψ + (30°, 210°)`;
both contain the inward cone `ψ + (150°, 210°)`. Every direction at `y` lies in the closed cone of some tile (the sectors at `y` cover
the circle of directions), so each inward `β` lies in the cone of a tile `T` whose colour `c` is a colour of `p`. `T` has points
`y + s d`, `d → e(β)`, and `|y + sd − p|² = 1 + 2s cos(β − ψ) + s² < 1` for small `s` (`cos(β − ψ) < −√3/2`), so `T` meets `B(p, 1)`
and the outer alternative of (E2) fails for `T` against any tile `T_c` at `p` of colour `c`: **`T_c ⊆ B̄(y, 1)`**.

*Step 3, (ii).* With `u⁻`, `v⁺` off (Q) arcs, GERM-R forbids `X` along `ψ + (−150°, 30°)` and `X̄` along `ψ + (−30°, 150°)`; both
contain the outward cone `ψ + (−30°, 30°)`. A tile `T` in whose cone an outward `β` lies has a colour `c` of `p` and points outside
`B̄(p, 1)` (`cos(β − ψ) > √3/2`), so the Siamese alternative fails: **`T_c ∩ B(y, 1) = ∅`** for every `c`-tile `T_c` at `p`; and **`T`
is not a tile of `p`**, since `p ∈ cl T` would make `T` Siamese with itself, `T ⊆ B̄(p, 1)`.

*Step 4, (iii).* An inward colour `c₁` and an outward colour `c₂` differ: if equal, a tile at `p` of that colour (one exists, the
colour being `p`'s) would lie in `B̄(y, 1)` and miss `B(y, 1)`, so lie in `ω(y)` — impossible for a non-empty open set. So
`P_cl(y) ⊇ {X, X̄, c₁, c₂}`, four colours: `y` is a vertex of at least four colours. ∎

*Uses only:* (S), (E1), (E2), (G), GERM-R, six colours (Step 1's "exactly two absent colours"); not non-Siamese, not the degree of `p`.

### 2.5 Attack on GERM-S

1. **Where six is spent.** Step 1 alone: "a germ carries an absent colour, and not the ring germ's, so it carries the other one". At
   `k = 7` with four colours at `p` there are three absent colours; `v⁻` may carry the third, `Z`, and then nothing keeps `X` out of the
   inward cone. The statement disclaims `k ≥ 7`; this is the step.
2. **Each (Q) hypothesis removed.** If `v⁻` lies on a (Q) arc, its side colours are colours of `p`, none of them `X̄` (Step 1 still
   applies), and no germ puts `X` in its closure: the exclusion of `X` from the inward cone has no source, so (i)'s proof stops at Step
   2. Whether (i) then fails in some fragment is not decided here; the claim list's RING-GERM *not claimed* line records that at the
   strip's `P₂`, with `u⁺` and `v⁻` on (Q) arcs, the conclusion of (iii) still holds.
3. **The nearest stronger statement: the tile in (i) a tile of `p`.** (E2)'s Siamese alternative allows `T ≠ T_c` with `T ⊆ B̄(p, 1)`
   and `T_c ⊆ B̄(y, 1)`; the non-Siamese hypothesis is exactly what closes it (RING-GERM). With Siamese pairs allowed, GERM-S's weaker
   conclusion is what the argument carries; I did not build a six-coloured fragment realising the difference.
4. **The (ii) side's "not a tile of p"**: forced, as Step 3 shows; no weaker reading needed.
5. **Radius.** As for GERM-R, radius exactly 1 suffices (the steps read neighbourhoods of `ω(p)`): a thin truth of no consequence.
6. **A model of the hypotheses.** FS114-Y2-BOWTIE (held, `plans/FS114-derivation.md` § 3, on `B̄(p, 3√3/5)`, radius above 1): a
   degree-4 vertex of four colours whose ring carries no (Q) arc (FS114-N7-3T's model line). GERM-S (iii) then says each change point of
   its ring has at least four colours, as FS114-N7-3T's N7-HUB says for its class (one mind there). Not re-checked here.

**Verdict: GERM-S derived** (TRUE), [hand], over GERM-R (§ 2.2).

*On the count.* The gate warns that my `given:` names a sketch: it is N7-HUB's one sentence inside FS114-N7-3T's statement in the claim list,
an argument for GERM-S's non-Siamese, (Q)-free ancestor (a tip meeting a lens intersection). My route does not use it (Steps 1–4 run on
GERM-R's exclusions and N-E2's alternatives, and no lens intersection appears). I count GERM-S at two minds on that condition; a reader who
counts a related sketch as given may count one.

## Stage 2 — SAVED

## Stage 3 — SAVED: TOUCH, ECHO and AXIS — derivation, attack, verdicts

Written 2026-09-29, 07:33–07:39 UTC and after (times from `date`). Tools of this stage: `tools/fs116_v3_echo.py` (ECHO's reading-(A) counterexample, the hexagonal
seven-colouring by formula) and `tools/fs116_v3_axis.py` (AXIS's clauses read on the rebuilt strip and on the square nine-colouring, both
by formula). Neither searches. Facts (S), (E1), (E2), (G) and GERM-R are § 2's.

### 3.1 TOUCH — derived

Six colours, `|P_cl(p)| = 4`, so exactly two absent colours; `w = r(ψ) ∈ ω(p)`, on no arc of `Γ` on `ω(p)` (arcs of `Γ` are closed:
the list's `Γ` is a union of arcs "with one-sided tangents at their endpoints"), not a change point, `w ∈ cl T_c` for a tile `T_c` of a
colour `c` of `p`, the four germs at `w ± 60°` on no (Q) arc.

*Step 1 (the ring at `w`).* By (G), both ring germs at `w` are off `Γ`, each in one tile, of an absent colour (E1). If `w ∉ Γ`, `w` lies in
a tile, which must be `T_c` (a point off `Γ` in a tile's closure is in that tile), against (E1) at `p`; so `w ∈ Γ`, and "not a change
point" says the two ring germs have one colour, `X`. **The ring just clockwise and just counter-clockwise of `w` lies in `X`-tiles.**
*Step 2 (the four germs).* Each germ at `w ± 60°` is 60° from one ring germ at `w`, both of which are `X`: by (E1) at the germ's points no
`X`-tile has them in its closure. On no (Q) arc, a germ lies in the closure of a tile of an absent colour (§ 2.4 Step 1's argument), not
`X`: **each germ lies in the closure of an `X̄`-tile and of no `X`-tile.**
*Step 3 (`X̄` at `w`).* GERM-R at `y = w` with all four germs in the closure of `X̄`-tiles forbids `X̄` along
`ψ + (150°, 330°) ∪ (−30°, 150°) ∪ (−150°, 30°) ∪ (30°, 210°)`: the first two leave out only `ψ + 150°` and `ψ + 330°`, which lie in the
fourth and the third. Every tile with `w` in its closure approaches `w` along some direction (it holds a sector at `w`), so **no
`X̄`-tile has `w` in its closure.** ∎
*Uses only:* (E1), (G), GERM-R, exactly two absent colours. **Not used: `w ∈ cl T_c`** — Step 1 used it only to place `w` on `Γ`, and
every conclusion holds as well when `w` lies inside an `X`-tile (then Steps 2 and 3 run unchanged, and Step 3 is immediate).

### 3.2 Attack on TOUCH

1. **Each hypothesis removed.** "`w` in the closure of a tile of one of `p`'s colours": idle — the conclusions hold for every point of
   `ω(p)` that is on no arc of `Γ` on `ω(p)`, is not a change point, and has its four germs off (Q) arcs, e.g. a point inside a ring tile.
   A **thin truth**: the hypothesis marks the case of interest (a point of `D`, RING-TWIST's set) and carries no weight in the argument.
   "Four colours and no more": needed to name `X̄` (with five colours at `p` there is one absent colour, and a germ off (Q) arcs would
   need an absent colour other than `X` — none — so the class is empty there). "No germ on a (Q) arc": needed (a germ on a (Q) arc
   carries two colours of `p` and may carry no absent colour at all).
2. **"Lies on no arc of `Γ` on `ω(p)`" read with open arcs.** Then `w` could be an end of an arc of `Γ` on `ω(p)`, not a change point
   under § 10's reading (the ring is on `Γ` on one side), and the first conclusion ("the ring just clockwise and just counter-clockwise
   of `w` lies in tiles") would fail on that side. The list fixes arcs as closed, so this is no counterexample; I note it as the one
   word a reader could misread.
3. **`k ≥ 7`** (disclaimed): Step 2's "an absent colour, not `X`, so `X̄`" is where six is spent.
4. **Where the attack succeeds: a change point in place of `w`.** Drop "not a change point" and the germs split between both absent
   colours (GERM-S Step 1), so conclusions two and three fail — which is GERM-S's case, not a defect of TOUCH.

**Verdict: TOUCH derived** (TRUE), [hand], over GERM-R; one idle hypothesis (a thin truth).

### 3.3 ECHO — derived under reading (B), refuted under reading (A); MISSTATED

Any `k`; a disc of radius above 2 about `p`; `w = r(ψ)`; the ring germs `r(ψ ∓ t)` in tiles `R⁻`, `R⁺` of colour `X ∉ P_cl(p)`.

**V3-ECHO-ONLY (a relay lemma; no saturation, no density used).** *Every point of `ω(w)` in the closure of an `X`-tile is `2w − p`.*
Let `z = w + e(θ) ∈ cl T′`, `T′` an `X`-tile. By (E1) at `w` (`w ∈ cl R^±`), `T′` misses `ω(w)`, so `T′` lies inside `B(w, 1)` or outside
`B̄(w, 1)`, being connected. `θ = ψ + 180°` gives `z = p`, excluded because `X` is absent at `p`. Otherwise let `sin(θ − ψ) ≠ 0`, and
`a_t := r(ψ + εt) ∈ R^ε` for a side `ε = ±1` to be chosen; `a_t − w = εt·e(ψ + 90°) + O(t²)`. For `b ∈ T′` near `z`, put `η := |b − w|² − 1`
(`η > 0` if `T′` is outside, `< 0` inside). Then

  `|b − a_t|² − 1 = η − 2εt⟨b − w, e(ψ + 90°)⟩ + O(t²) = η − 2εt·sin(θ − ψ) + O(t|b − z| + t²)`.

Choose `ε` so that `εη·sin(θ − ψ) > 0`. As `t → 0⁺` the expression has `η`'s sign; at `t = |η|/|sin(θ − ψ)|` (small once `b` is close
to `z`) it is `−η + O(η·|b − z| + η²)`, of the other sign. So `T′ × R^ε` straddles 1, and (S) makes the fragment invalid. Hence
`sin(θ − ψ) = 0`, `θ = ψ`, `z = 2w − p`. ∎ (Both ring tiles are used: which one depends on the sign of `η·sin(θ − ψ)`.)

**Under (B)** (`w` an essential boundary point, saturated for each colour of `P(w)`; `X ∈ P(w)`): saturation for `X` gives a point
`z ∈ ω(w) ∩ supp S_X` (the contact reading, § 1.3); `supp S_X = cl S̃_X` lies in the closure of the union of the `X`-tiles (`Γ` is null),
and by local finiteness `z` is in the closure of one `X`-tile; by V3-ECHO-ONLY `z = 2w − p`. **So `2w − p` lies in the closure of an
`X`-tile: TRUE.** The radius above 2 keeps `ω(w)` inside the fragment's domain.

**Under (A)** (saturation at `w` checks nothing when `w` is not an essential boundary point): **FALSE**. `tools/fs116_v3_echo.py`: the
hexagonal seven-colouring with hexagons of circumradius `a = 0.45` (the Voronoi cells of the triangular lattice of spacing `a√3`, the cell
about `m b₁ + n b₂` coloured `(m + 3n) mod 7`) is valid — same-colour centres differ by a vector of the index-7 sublattice, of least length
`√21·a = 2.062` (checked over `|m|, |n| ≤ 6`), so same-colour hexagons are more than `2.062 − 0.9 = 1.162` apart, and each has diameter
`0.9`. With `p` the origin (a centre, colour 0) and `w = r(20°)`: `w` lies inside a hexagon of colour `X = 1` (margin 0.013 to its
boundary), so both ring germs are in one `X`-tile and `X ≠ 0` is absent at `p`; `P(w) = {X}`, so `w` is no essential boundary point
and (A)'s saturation at `w` holds with nothing to check, and `X ∈ P(w)`; but `2w − p` lies inside a hexagon of colour 5 (margin 0.32),
in the closure of no `X`-tile. With the colouring `(m − n) mod 3` planted, the validity certificate fails and the tool says so (control
`v3-echo-a`). The same holds under (A′), "saturated on a disc about `w`": a small disc about `w` holds no essential boundary point.

**Which reading the statement should name: (B).** Corrected statement (MISSTATED → TRUE): *"… if `w` is an essential boundary point at
which the fragment is saturated — each colour of `P(w)` has a point of its support at distance exactly 1 from `w` — and `X` is in `w`'s
essential multicolour, the point `2w − p` lies in the closure of a tile of colour `X`."* Equivalently: add "`|P(w)| ≥ 2`". With
V3-ECHO-ONLY it can be said sharper: **`ω(w) ∩ supp S_X ⊆ {2w − p}` always, and saturation at `w` for `X` makes it `{2w − p}`.**

### 3.4 Attack on ECHO

1. **The monster, placed.** The counterexample breaks no step of the argument under (B); it lives in the term "saturated at `w`", which
   the list defines only for a colouring and for a disc. Its place is § 3.3's first line under (B): the existence of a contact `z`.
2. **Each hypothesis removed (under B).** "`X ∈ P(w)`": saturation constrains only colours of `P(w)`; with `X` of density 0 at `w` (both
   ring tiles cusps at `w`) no `X`-contact is promised — disclaimed. "Both ring germs `X`": V3-ECHO-ONLY uses the ring tile on the side
   fixed by the sign of `η·sin(θ − ψ)`; with `X` on one side only, contacts on the other side's half of `ω(w)` are no longer excluded.
   "`X` absent at `p`": used once, to exclude `z = p`. "Any `k`", "Siamese allowed": unused.
3. **k = 7 inhabitant under (B)?** R7 (FS111-M § 2.4) is saturated everywhere; at a lattice point `p` its absent colour is one up colour,
   and a point `w` of `ω(p)` with the ring in that colour on both sides and `|P(w)| ≥ 2` would need `ω(p)` tangent to an up's boundary
   from inside. I did not locate one; the (B) form is derived, not exhibited.

**Verdict: ECHO — refuted as written, with a monster** (the term "saturated at `w`"): FALSE under (A) by the hexagonal seven-colouring,
TRUE under (B); **MISSTATED**, the corrected statement TRUE, [hand], with V3-ECHO-ONLY.

### 3.5 AXIS — derived

`p = 0`; `T_I, …, T_IV` the quadrant tiles (each the only tile at `p` of its colour: degree 4, four colours); six colours, so the absent
pair is `{X, X̄}`; the fragment saturated on `B̄(p, ρ)`, `ρ > 0`. At `q_N = (0, 1)`, `ψ = 90°`.

*(a), no saturation used.* A tile `T` approaching `q_N` along `β ∈ (180°, 360°)` has points `q_N + sd` with `|q_N + sd|² = 1 + 2s sin β′ +
s² < 1` (`d = e(β′)`, `β′ → β`), so it meets `B(p, 1)`. If its colour were `p`'s, (E2) against the quadrant tile of that colour would be
Siamese, putting that quadrant tile inside `B̄(q_N, 1)`; but each quadrant tile holds points `ε e(d)` with `d` as close as we like to the
`x`-axis (`d → 0°` or `180°` for `T_I`, `T_II`; any `d` for `T_III`, `T_IV`), at distance `√(1 − 2ε sin d + ε²) > 1` from `q_N` once
`sin d < ε/2`. So **`T` is `X` or `X̄`.**

*(b), saturation at the edge points.* For `0 < s < s₀` (within `ρ` and the edge along `0°`), `x_s = (s, 0)` has `P(x_s) = {c_I, c_IV}`;
saturation for `c_IV` gives `z = x_s + e(θ) ∈ cl T′`, `T′` a `c_IV`-tile, and `T′` misses `ω(x_s)` by (E1) (`x_s ∈ cl T_IV`), so `η :=
|b − x_s|² − 1` has one sign on `T′`. `T_IV` holds `x_s + σd` for every `d` in the open lower half-plane. If `θ ∉ {90°, 270°}`, some such
`d₁`, `d₂` have `⟨e(θ), d₁⟩ > 0 > ⟨e(θ), d₂⟩`, and `|b − x_s − σd|² − 1 = η − 2σ⟨b − x_s, d⟩ + σ²` takes both signs for `σ ≫ |η|`: (S).
If `θ = 270°`, (E2) for `T_IV` and `T′`: not outer (`(s, −σ) ∈ T_IV` is within 1 of `z = (s, −1)`), not Siamese (`T_IV`'s points near `p`
are about `√(1 + s²) > 1` from `z`). So `θ = 90°`, `z = (s, 1)`, and (E2) is outer (`(s, −σ)` is `1 + σ` from `z`): every point of `T′` is
more than 1 from every point of `T_IV`, which holds `(x, −σ)` for `0 < x < s₀` and small `σ`, so `T′` misses `{0 < x < s₀, y < 1}`. Every
`(s, 1)`, `0 < s < s₀`, is then on `Γ` (off `Γ` it would be inside a `c_IV`-tile reaching below `y = 1`), so `(0, s₀) × {1}` is a segment of
`Γ` leaving `q_N` along `0°`, and the tile above it is `c_IV`; near `q_N` that tile is the one holding the sector just counter-clockwise
of `0°`. **A `c_IV`-tile approaches `q_N` along `0⁺`, above `y = 1`.** The edge along `180°` (`T_II` above, `T_III` below) gives **a
`c_III`-tile along `180⁻`**, the same way.

*(c), over (b).* Let the germ just counter-clockwise of `r(30°)` lie on a (Q) arc: its side colours are colours of `p`. The inner side
tile meets `B(p, 1)`, so by (E2) the quadrant tile of its colour lies in `B̄(z, 1)` for the germ's points `z = r(30° + t)`, which forces
that quadrant's directions into `[t − 60°, t + 120°]`: quadrant I. The outer side tile has points outside `B̄(p, 1)`, so the quadrant tile
of its colour misses `B(z, 1)`, which forces its directions into `[t + 120°, t + 300°]`: quadrant III. So the outer side colour is
`c_III`, and GERM-R at `q_N` with this germ as `v⁺` (just counter-clockwise of `r(ψ − 60°)`) forbids `c_III` along `ψ + (−30°, 150°) =
(60°, 240°)`, which holds `180⁻` — against (b). The germ just clockwise of `r(150°)` (as `u⁻`): inner quadrant II, outer quadrant IV,
`c_IV` forbidden along `ψ + (−150°, 30°) = (−60°, 120°) ∋ 0⁺` — against (b). **Neither germ lies on a (Q) arc.**

*(d), no saturation used.* The germ just clockwise of `r(30°)` (`v⁻` at `q_N`) and the one just counter-clockwise of `r(150°)` (`u⁺`), on no
(Q) arc, each lie in the closure of a tile of an absent colour, say `Y` and `Y′`. GERM-R forbids `Y` along `(240°, 420°)` and `Y′` along
`(120°, 300°)`; the tile holding the direction `270°` at `q_N` is `X` or `X̄` by (a) and neither `Y` nor `Y′`, so `Y = Y′ =: Z` and neither
germ lies in the closure of a tile of the other absent colour `Z̄`. `Z` is forbidden along `(120°, 420°)`, which holds `(180°, 360°)`: **every
tile approaching `q_N` from below the horizontal is `Z̄`**. If the ring is off `Γ` on both sides of `q_N`, its two germ tiles approach `q_N`
along `0°` and `180°`, are absent-coloured (E1) and not `Z` (both directions are forbidden to `Z`): both `Z̄`, **so `q_N` is not a change
point** (and if the ring lies on `Γ` on a side, `q_N` is none by § 10's reading). ∎

The turned points `q_E`, `q_W`, `q_S`: the hypotheses are invariant under the quarter-turn about `p` with the quadrants relabelled.
*Uses only:* (S), (E1), (E2), (G), GERM-R, six colours in (a) and (d), saturation at the four edges' points near `p` in (b) (and so in (c)).

### 3.6 Attack on AXIS

1. **Saturation removed: the strip.** `[AxenovichEtAl2014]`'s strip as rebuilt in `plans/FS112-Y-construction.md` § 1.3 (arches of
   width 1/2 on the midline, top row `C_j`, colours `A` 1, 2, 3 / `B` 4, 5, 6 / `C` 5, 6, 4 / `D` 2, 3, 1): its midline vertex
   `P_1 = (1/2, 0)` is a degree-4 vertex of four colours `{1, 2, 4, 5}` whose four edges are the half-axes (the midline and the arch
   sides `x = 1/2`), valid on `B(P_1, 1.834)` (row 136) and **not saturated on its midline** (FS111-VM2-STRIP-MID). `tools/fs116_v3_axis.py`
   reads it at `q_N = (1/2, 1)`, which lies inside the top tile `C_1` (colour 6): (a) holds (below `q_N` only 6, absent); **(b) fails** —
   along `0⁺` and `180⁻` the tile is `C_1`, colour 6, not `c_IV = 5` or `c_III = 4`; (c) holds (both germs inside tiles); (d)'s hypothesis
   holds (both germs inside colour-3 tiles) and its conclusion holds (one colour, 6; the ring is 6 on both sides). So **(b) needs the
   saturation hypothesis**, and (a), (d) do not: the strip is an object outside AXIS's hypotheses satisfying (a) and (d) — a **thin
   truth** for those two clauses (they hold in every valid fragment with such a vertex, saturated or not). Whether (c) needs saturation
   is not decided (the strip satisfies it without).
2. **k = 9: SQ9** (the square nine-colouring of side 1/2, about the grid vertex `(0, 0)`; saturated, the list's § 4 and § 9): (a), (b),
   (c) hold (below `q_N` the colours `(0,1)`, `(2,1)`, absent; along `0⁺` `(0,2) = c_IV`, along `180⁻` `(2,2) = c_III`; the germs inside
   squares); **(d) fails** — its hypothesis holds (both germs inside `(1,0)`-squares, so `Y = Y′` as § 3.5 requires) but two colours lie
   below `q_N` and `q_N` is a change point: at `k = 9` there are five absent colours, and (d)'s step "the tile at `270°` is `X` or `X̄`, so
   `Y = Y′` leaves one colour" is where six is spent. The statement disclaims `k ≥ 7` for (d) (naming SQ9); (a) is stated with "`X` or
   `X̄`", so at `k = 9` it reads "absent at `p`", which holds.
3. **Four segments not at right angles** (disclaimed): (a) uses that each quadrant tile reaches the horizontal through `p`; at other
   angles the tiles whose sectors avoid a closed half-plane facing `q_N` are no longer all of `p`'s tiles.
4. Both tools' faults fire (`v3-axis`: the strip's top-row colours read as the `B` row's turn (a) into "fails").

**Verdict: AXIS derived** (TRUE), [hand]; (a) and (d) hold without saturation (thin truth); (b) is where saturation is spent.

## Stage 3 — SAVED

## The verification blocks and controls

verification: FS116-N1-GERM-R
  statement: in a valid k-coloured fragment on a closed disc of radius above 1 about a point p, for any k, Siamese pairs allowed, let y = r(ψ) be a
    point of ω(p), c a colour, and v⁻, v⁺, u⁻, u⁺ the arcs of ω(p) just clockwise and just counter-clockwise of r(ψ − 60°) and r(ψ + 60°); if v⁻ lies
    in the closure of a tile of colour c, no tile of colour c approaches y along a direction β with β − ψ in (150°, 330°); for v⁺ the interval is
    (−30°, 150°), for u⁻ (−150°, 30°), and for u⁺ (30°, 210°) *Not claimed:* anything about tiles that approach y only along the boundary directions ψ
    + 150°, ψ + 330°, ψ − 30°, ψ + 30°, ψ + 210°, ψ − 150°; anything when a germ lies on Γ with colour c on neither side
  given: the statement verbatim, the whole frozen claim list (with RING-GERM's statement and N7-HUB's one-sentence sketch in FS114-N7-3T's),
    FS114-derivation § 3's entry statements, N-E0–N-E2 and M-PINCH with their proofs, the brief's one-line description of the five; no verdict, no
    proposing record, no sketch of these statements' proofs (§ 1.4)
  committed: 2026-09-29, stage 2 (commit "FS116-V3: stage 2")
  predicted: derived — 0.95 — likeliest break: a tile reaching y only along a boundary direction, or a cusp at y (both outside the claim as posed)
  verdict: derived
  method: a straddle (N-E0 on the connected set T′ × T) at first order in the germ parameter and the approach distance; the first derivation's route
    is not known to me (fenced)
  attack: § 2.3 Attack on GERM-R
  divergences: none — the first derivation is fenced until all five verdicts are committed (stage 4)
  counterexamples: thin truth: a valid k-coloured fragment on B̄(p, 1) — § 2.2's step reads only neighbourhoods of ω(p), so radius exactly 1 suffices
    (no consequence); the boundary-direction models of § 2.3 confirm the not claimed line and are not counterexamples
  minds: 2 — blind to: the first derivation's record, route and verdict (fenced until all five verdicts are committed); method: derived from the
    statement alone by the route of § 2; the same model (Opus 5.5) — blind, the same model
  grade: hand

verification: FS116-N1-GERM-S
  statement: in a valid fragment on a closed disc of radius above 1 about a vertex p of at least four colours, Siamese pairs allowed, let y be a
    change point of the ring, X the colour of the ring just counter-clockwise of y and X̄ the colour just clockwise, and u⁻, u⁺, v⁻, v⁺ the arcs of
    ω(p) just clockwise and just counter-clockwise of the ring points y + 60° and y − 60°; then p has four colours and no more, X and X̄ are the
    colours absent at p, and (i) if neither v⁻ nor u⁺ lies on a (Q) arc, every direction at y in the open cone of 60° about the direction to p lies in
    the cone of a tile of a colour c of p every tile of p of which colour lies in B̄(y, 1); (ii) if neither u⁻ nor v⁺ lies on a (Q) arc, every
    direction at y in the open cone of 60° about the direction away from p lies in the cone of a tile, not a tile of p, of a colour c of p every tile
    of p of which colour misses B(y, 1); (iii) if none of the four lies on a (Q) arc, y is a vertex of at least four colours *Not claimed:* anything
    at k ≥ 7; that the tile in (i) is a tile of p (that is RING-GERM, in the non-Siamese class); that a change point with a germ on a (Q) arc has
    fewer than four colours
  given: the statement verbatim, the whole frozen claim list (with RING-GERM's statement and N7-HUB's one-sentence sketch in FS114-N7-3T's),
    FS114-derivation § 3's entry statements, N-E0–N-E2 and M-PINCH with their proofs, the brief's one-line description of the five; no verdict, no
    proposing record, no sketch of these statements' proofs (§ 1.4)
  committed: 2026-09-29, stage 2 (commit "FS116-V3: stage 2")
  predicted: derived — 0.90 — likeliest break: a germ at y ± 60° on a non-(Q) arc whose absent side colour is not the one the exclusion needs
  verdict: derived
  method: each germ's absent colour by N-E1 against the ring germ 60° away, then GERM-R's exclusions and N-E2's two alternatives; the first
    derivation's route is not known to me (fenced)
  attack: § 2.5 Attack on GERM-S
  divergences: none — the first derivation is fenced until all five verdicts are committed (stage 4)
  counterexamples: thin truth: a valid fragment on B̄(p, 1) — the steps read only neighbourhoods of ω(p), so radius exactly 1 suffices (no
    consequence)
  minds: 2 — blind to: the first derivation's record, route and verdict (fenced until all five verdicts are committed); method: derived from the
    statement alone by the route of § 2; the same model (Opus 5.5) — blind, the same model
  grade: hand

verification: FS116-N1-TOUCH
  statement: in a valid fragment on a closed disc of radius above 1 about a vertex p of four colours and no more, Siamese pairs allowed, let w be a
    point of ω(p) in the closure of a tile of one of p's colours which is not a change point of the ring and lies on no arc of Γ on ω(p), and suppose
    none of the four arcs of ω(p) just clockwise and just counter-clockwise of w + 60° and w − 60° lies on a (Q) arc; then the ring just clockwise and
    just counter-clockwise of w lies in tiles of one colour X absent at p, each of the four arcs lies in the closure of a tile of the other absent
    colour X̄ and of no tile of colour X, and no tile of colour X̄ has w in its closure *Not claimed:* that such a point exists in any fragment of
    SAT-QFREE's class; anything at k ≥ 7; anything when a germ lies on a (Q) arc
  given: the statement verbatim, the whole frozen claim list (with RING-GERM's statement and N7-HUB's one-sentence sketch in FS114-N7-3T's),
    FS114-derivation § 3's entry statements, N-E0–N-E2 and M-PINCH with their proofs, the brief's one-line description of the five; no verdict, no
    proposing record, no sketch of these statements' proofs (§ 1.4)
  committed: 2026-09-29, stage 3 (commit "FS116-V3: stage 3")
  predicted: derived — 0.85 — likeliest break: an idle hypothesis (a thin truth, not a break), or w an end of a Γ-arc on ω(p)
  verdict: derived
  method: the ring germs at w by N-E1 and 'not a change point', each ±60° germ's colour by N-E1 against the X ring germ 60° away, then GERM-R's four
    exclusions, whose union is every direction; the first derivation's route is not known to me (fenced)
  attack: § 3.2 Attack on TOUCH
  divergences: none — the first derivation is fenced until all five verdicts are committed (stage 4)
  counterexamples: thin truth: a point of ω(p) inside an X ring tile, on no arc of Γ on ω(p), its four germs off (Q) arcs — the hypothesis 'w in the
    closure of a tile of one of p's colours' is idle (§ 3.1 Step 1 uses it only to place w on Γ)
  minds: 2 — blind to: the first derivation's record, route and verdict (fenced until all five verdicts are committed); method: derived from the
    statement alone by the route of § 3.1; the same model (Opus 5.5) — blind, the same model
  grade: hand

verification: FS116-N1-ECHO
  statement: in a valid k-coloured fragment on a closed disc of radius above 2 about a point p, for any k, Siamese pairs allowed, let w be a point of
    ω(p) whose ring just clockwise and just counter-clockwise of w lies in tiles of one colour X absent at p; if the fragment is saturated at w and X
    is in w's essential multicolour, the point 2w − p lies in the closure of a tile of colour X *Not claimed:* anything when X has density 0 at w (a
    cusp); that the X-tile at 2w − p exists in any fragment of SAT-STRIP's class
  given: the statement verbatim, the whole frozen claim list (with RING-GERM's statement and N7-HUB's one-sentence sketch in FS114-N7-3T's),
    FS114-derivation § 3's entry statements, N-E0–N-E2 and M-PINCH with their proofs, the brief's one-line description of the five; no verdict, no
    proposing record, no sketch of these statements' proofs (§ 1.4)
  committed: 2026-09-29, stage 3 (commit "FS116-V3: stage 3")
  predicted: refuted — 0.75 — likeliest break: a monster at "saturated at w" (reading A, w inside an X-tile); under reading B I expect it true
  verdict: refuted: monster at the term 'saturated at w' — under reading (A) FALSE by the hexagonal seven-colouring (w inside an X-hexagon, no
    essential boundary point); under reading (B) TRUE; MISSTATED, corrected statement § 3.3
  method: V3-ECHO-ONLY (every point of ω(w) in the closure of an X-tile is 2w − p, by a straddle against the ring tile on the side fixed by the sign
    of η·sin(θ − ψ)), then saturation's contact; the first derivation's route is not known to me (fenced)
  attack: § 3.4 Attack on ECHO
  divergences: none — the first derivation is fenced until all five verdicts are committed (stage 4)
  counterexamples: monster: the hexagonal seven-colouring of circumradius 0.45, p a hexagon centre, w = r(20°) inside a colour-1 hexagon, 2w − p
    inside a colour-5 hexagon (tools/fs116_v3_echo.py) — the term 'saturated at w', which checks nothing at a point that is no essential boundary
    point (reading A); under reading B the hypothesis excludes it and the statement holds
  minds: 1 — this mind's verdict on the statement as written (refuted, a monster) and on its reading (B) (derived); blind to the first derivation
    (fenced); the count against it is stage 4's
  grade: hand

verification: FS116-N1-AXIS
  statement: let p be a degree-4 vertex of four colours of a valid fragment on a closed disc of radius above 1 about p, saturated on a disc about p,
    whose four edges are segments along the four half-axes, with tiles coloured c_I, c_II, c_III, c_IV by quadrant and absent colours X, X̄; then at
    q_N = p + (0, 1): (a) every tile approaching q_N along a direction below the horizontal has colour X or X̄; (b) a tile of colour c_IV approaches
    q_N along 0⁺ and one of colour c_III along 180⁻, both above the line y = 1; (c) the arcs of ω(p) just counter-clockwise of r(30°) and just
    clockwise of r(150°) lie on no (Q) arc; (d) if the arcs just clockwise of r(30°) and just counter-clockwise of r(150°) lie on no (Q) arc, every
    tile approaching q_N along a direction below the horizontal has one colour, and q_N is not a change point; and at each of the axis points q_E,
    q_W, q_S, read with the quadrants turned with it *Not claimed:* anything for four segments not at right angles; anything at k ≥ 7 for (d) (at k =
    9 SQ9 fails it); that the axis points are touch points in any fragment saturated on B̄(p, 1); SAT-STRIP
  given: the statement verbatim, the whole frozen claim list (with RING-GERM's statement and N7-HUB's one-sentence sketch in FS114-N7-3T's),
    FS114-derivation § 3's entry statements, N-E0–N-E2 and M-PINCH with their proofs, the brief's one-line description of the five; no verdict, no
    proposing record, no sketch of these statements' proofs (§ 1.4)
  committed: 2026-09-29, stage 3 (commit "FS116-V3: stage 3")
  predicted: derived — 0.85 — likeliest break: (b)'s "above the line y = 1", or (d) when the germ at r(30°) lies on Γ with both absent colours
  verdict: derived
  method: (a) by N-E2 against the quadrant tiles; (b) saturation's contact at the edge points (s, 0), placed at (s, 1) by straddles and N-E2; (c) by
    N-E2 fixing a (Q) arc's side colours as c_I | c_III, then GERM-R against (b); (d) by GERM-R at q_N and the direction 270°; the first derivation's
    route is not known to me (fenced)
  attack: § 3.6 Attack on AXIS
  divergences: none — the first derivation is fenced until all five verdicts are committed (stage 4)
  counterexamples: thin truth: the strip's midline vertex P_1 = (1/2, 0) (row 136, as rebuilt in plans/FS112-Y-construction.md § 1.3), unsaturated (tools/fs116_v3_axis.py) — (a) and (d) hold there and
    their steps in § 3.5 use no saturation; (b) fails there, so saturation is spent in (b)
  minds: 2 — blind to: the first derivation's record, route and verdict (fenced until all five verdicts are committed); method: derived from the
    statement alone by the route of § 3.5; the same model (Opus 5.5) — blind, the same model
  grade: hand

control: v3-quotes
  of: FS116-N1-GERM-R — the readback: the five statements the brief quotes against the claim list's § 11, character for character
  run: python3 ../tools/fs116_v3_quotes.py --root .. | tail -1
  expect: identical: 5 of 5
  fault: python3 ../tools/fs116_v3_quotes.py --root .. --plant | tail -1

control: v3-germ-intervals
  of: FS116-N1-GERM-R — the four forbidden sets s_g⟨e(β), u_g⟩ > 0 against the statement's intervals, exact at the ends, on a 0.05° grid between
  run: python3 ../tools/fs116_v3_germ.py intervals | tail -1
  expect: intervals mismatched: 0 of 4
  fault: python3 ../tools/fs116_v3_germ.py intervals --plant | tail -1

control: v3-germ-endpoints
  of: FS116-N1-GERM-R — the not claimed line's boundary directions are realised: four pairs of one-colour tiles by formula, no unit pair in any
  run: python3 ../tools/fs116_v3_boundary.py | tail -1
  expect: models with F of one sign (no unit pair): 4 of 4
  fault: python3 ../tools/fs116_v3_boundary.py --plant | tail -1

control: v3-germ-cones
  of: FS116-N1-GERM-S — Step 1's pairing of each germ with a ring germ, and the inward and outward cones inside the two forbidden sets
  run: python3 ../tools/fs116_v3_germ.py cones | tail -1
  expect: cones closed: 2 of 2
  fault: python3 ../tools/fs116_v3_germ.py cones --plant | tail -1

control: v3-echo-a
  of: FS116-N1-ECHO — reading (A)'s counterexample: the hexagonal seven-colouring certified valid, the hypotheses checked at w = r(20°), 2w − p in no X-tile's closure
  run: python3 ../tools/fs116_v3_echo.py | tail -1
  expect: ECHO-A: hypotheses hold and 2w - p lies in the closure of no X-tile
  fault: python3 ../tools/fs116_v3_echo.py --plant | tail -1

control: v3-axis
  of: FS116-N1-AXIS — the four clauses read on the unsaturated strip about P_1 and on SQ9 (k = 9) at q_N
  run: python3 ../tools/fs116_v3_axis.py | tail -1
  expect: summary: (a) holds, (b) fails, (c) holds, (d) holds | (a) holds, (b) holds, (c) holds, (d) fails
  fault: python3 ../tools/fs116_v3_axis.py --plant | tail -1

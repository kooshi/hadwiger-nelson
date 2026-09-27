# FS110-NB4 — blind verification of FS110-N4 (round 4, the proof side: G-CONE)

*Job FS110-NB4, Opus 5.5, 2026-09-27. Brief `data/fs110/briefs/NB110-verify-proof.md` with the instance block
`data/fs110/briefs/NB4-110-instance.md` and `data/fs110/briefs/STANDING-RULES.md`. Blind: FS110-N4's record, tools and directory, the
construction side's record, every other verifier's record, the plan, the advisors' records, the close inventory, the reports and the other
briefs stay unopened until Stage 3 is committed. Work files: `data/fs110/fs110-nb4/`; tools `tools/fs110_nb4_*.py`.*

## Theorems this phase proved

| id | statement (one line, mine) | grade | address |
|---|---|---|---|
| NB4-SH | a tile touching `ω(v)` at `x` casts near `v` a finite union of sets, each one side of a circle through `v`; for an arc tangent to `ω(v)` at `x` with centre `C` the circle is the one through `v` centred at `C` (concentric), curvature `f(λ)` from `N`, `f̃(υ)` from `S′`, `k/(k−1) > 1` for an in-type arc of curvature `k > 1`; a corner gives `ω(x)` | [hand, one mind (mine, blind); exact C1] | Stage 2 §2.1; `tools/fs110_nb4_check.py` C1 |
| NB4-FL | a shadow component meeting a `c`-horn's tip arbitrarily near `v` and not containing the flank colour's own points adjacent to the horn is one side of a circle tangent to `a`: below one, from an out-type tile at `S′` (upper flank), above one, from an out-type tile at `N` (lower flank); true for flanks of any shape (sector or horn) | [hand, one mind] | §2.2 |
| NB4-SV | a tip split exists iff no tip point is doubly shadowed iff `σ_h ≥ σ_g`; validity alone gives `λ₀ ≤ σ_h` and `σ_g ≤ υ₀` | [hand, one mind] | §2.3 |
| NB4-RY | two valid `c`-horns on one ray bound a `c`-clear region near `v` | [hand, one mind] | §2.4 |
| NB4-ST | at a vertex with no move, a colour with two sectors is a Woodall cone with one horn on each of `±a`, degree 4, and the closure types and double sectors at `N`, `S′` as N4-STUCK states | [hand, one mind, over NB-4 and W-MERGE] | §2.5 |
| NB4-CH | the chain's curvatures satisfy FIN's inequalities by **validity** of the flanks alone (not by the blocking condition) | [hand, one mind] | §2.6 |
| NB4-FN | FIN, with the step bounds `⌈1/υ⌉`, `⌈1/\|λ\|⌉`; strictness `λ_k < υ_k` is necessary (the constant `(0, 0)` otherwise) | [hand + exact, one mind; C2 and its plant] | §2.7 |
| NB4-TM | a fair schedule of moves converges to a terminal valid map in `𝓜_{O(K)}` under Condition 5, each point changed at most finitely often (`Φ` never rises) | [hand, one mind] | §2.8 |
| NB4-CS | adding SHAVE on single horns (horn count falls, `Φ` never rises) gives a terminal cubic map whose every cusp horn is doubly shadowed; with N4's wedge-opening (sketch) the residue is the doubly-shadowed single-horn Woodall cone | [hand, one mind; a proposal] | §2.9, §4.1 D3 |
| NB4-SC | straight cuts in SHAVE, MERGE, MERGE-RAY keep the modified map in `𝓜_{O(K)}` with the radius bound (dividing arcs have curvature in `(−1, 1)`) | [hand, one mind] | §4.1 D4 |
| NB4-HEXa | N4-HEX (a): `A_1`, `A_2` are not both tile points | [hand, one mind; checked] | §4 |
| NB4-WCH | in WCH, `v` is stuck in N4's sense (no MERGE, no MERGE-RAY, SHAVE blocked), `N` and `S′` are not (colour 4 has three sectors at `N`), and colour 1 cannot sit directly above `N`'s 3-horn | [tools, exact witnesses; the reading hand] | §2.10; C3 |
| NB4-WC1H | in WC1H, `v` is cubic with a cusp (not a two-sector cone); `σ_h = σ_g = 0`, so SHAVE applies (split along `+a`), though both single-colour tip recolourings are refused | [tools, exact; hand] | §2.10; C4 |

## Stage 1 — SAVED

### 1.1 Quotation check (standing rule 5)

| quotation | source | result |
|---|---|---|
| `[SokolovVoronov2025]` Question 2, Condition 5, Condition 6 (claims §1) | held PDF `~/source/library/pdf/arXiv-2502.01958-maptype.pdf`, pdftotext l. 148–153, 1016–1018 | verbatim ✓ |
| Kooshi's counter-priors sentence (standing rule 0) | `CLAUDE.md` § Counter-priors, on disk | verbatim ✓ |
| The theorem table of FS110-N4 (instance block) | `plans/FS110-N-proof.md` § Continuation — FS110-N4 | **fenced until Stage 3**; checked at Stage 4 |
| N3-DEG, N3-RED (claims §8) | `plans/FS110-N-proof.md` § Continuation — FS110-N3 | **fenced until Stage 3**; checked at Stage 4 |
| FS110-Y4 §11.3–§11.4 fragments (instance block) | `plans/FS110-Y-construction.md` | **fenced (the other side)**; not opened by this job; used as given |
| CB's three theorem lines (claims §8, first update) | `plans/FS110-CB-verification.md` | fenced (a verifier's record); used as quoted |

### 1.2 The statements against the claim list's definitions

- **Types.** Every type in the N4 table is a closure type (`P_cl`): N4-STUCK writes `P_cl(N)`, `P_cl(S′)`; N4-HEX's "type `{α, β, i}`" and
  N4-PROP's "type `{a_{k−1}, a_k, a_{k+1}}`" are closure types by context (a cone colour is a cusp colour, so it is in `P_cl` and not in `P_ess`).
  Consistent with claims §0 (`P_ess ⊆ P_cl`, equal off cusps).
- **Covering pairs** do not occur in N4: its route is a modification to a cubic map plus the base, not C-T-TAN. C-SEAMLIST is not used.
- **`𝓜_K`** (claims §0) is used by N4-RED; the modified map must stay in `𝓜_{K′}` with `K′ = O(K)` (checked at N4-TERM, Stage 2).
- **Terms the claim list does not define, and the definitions this job uses** (to be compared with N4's at Stage 4):
  - *valid*: a full map (open tiles, null boundaries) coloured with six colours such that no two interior points of one colour are at
    distance exactly 1 (A-EXACT's hypothesis). By K-TIGHT every valid six-map is tight, so NB-4 applies to every valid six-map in `𝓜_{K′}`
    under Condition 5.
  - *sector* of colour `c` at `v`: a germ at `v` of a `c`-tile, of positive angle or a cusp horn (angle 0, two boundary arcs tangent at `v`).
  - *shadow* of a tile `A` near `v`: `{p ∈ B(v, t) : ω(p) ∩ A ≠ ∅}` (open). A point in the shadow of a `j`-tile cannot take colour `j`.
  - *`D_c(v)`* (N3's own definition is fenced): the set of directions at `v` along which `c` can lie without meeting the shadow of any
    `c`-tile touching `ω(v)`. It is `S¹` minus one open half-circle per contact (out-type at `v + e`: the half-circle about `e`; in-type:
    about `−e`).
  - *`Φ(v)`*: `Σ_c (#c-sectors at v − 1)⁺`. *Cubic*: `Φ ≡ 0`; with NB-4 every vertex then has degree `|P_cl| ≤ 3`.
  - *MERGE*: recolour, inside `B(v, t₀)`, the sectors lying between two `c`-sectors on the side inside `D_c(v)`, to `c`. *MERGE-RAY*: the
    same for two `c`-horns on one ray. *SHAVE*: recolour the tip `h⁺ ∩ B(v, t₀)` of a `c`-horn by its flanks, split along one curve.
    *Stuck*: no MERGE, MERGE-RAY or SHAVE applies at `v`. *Terminal*: no move applies at any vertex.

### 1.3 Restatements, in my words

- **SHADOW.** A tile touching `ω(v)` from outside at `N = v + n`, whose boundary there is an arc tangent to `a` with centre `C` on the line
  `vN`, casts near `v` exactly the side of the circle through `v` centred at `C` that contains `N`; with signed curvature `λ` of the arc (away
  from `v` positive), that circle has curvature `f(λ) = λ/(1+λ)` at `v`; from `S′ = v − n` the analogue is `f̃(υ) = υ/(1−υ)`.
- **FLANK.** Near the tip of a `c`-horn along `+a` at `v`, with `g` the sector above and `h` below, a `g`-tile can shadow tip points only if it
  touches `ω(v)` at `S′` from outside with its boundary tangent to `a` (shadow below a curve `σ_g`), and an `h`-tile only at `N` likewise
  (shadow above `σ_h`).
- **SHAVE.** The tip can be recoloured, `g` above a dividing curve and `h` below, validly, keeping Condition 5 and lowering `Φ(v)` by one,
  unless `σ_h` lies strictly below `σ_g` inside the horn; if `g = h` it is never blocked.
- **RAY.** Two `c`-horns on the same ray at `v` can be merged: everything between them near `v` is out of every `c`-shadow.
- **STUCK.** At a vertex where no move applies and `c` has two sectors: `c` has exactly one horn on `+a` and one on `−a`; `v` has degree 4,
  `g` filling the upper half and `h` the lower; `N` has closure type `{c, h, r}` and `S′` has `{c, g, r′}`; `h` has two sectors at `N` and
  `g` two at `S′`.
- **PROP.** In a terminal map a stuck vertex starts a chain of stuck vertices `P_k = P_0 + kn`, `k ∈ ℤ`, with cone colours `a_k` and closure
  types `{a_{k−1}, a_k, a_{k+1}}`.
- **FIN.** There is no bi-infinite sequence of pairs `−1 < λ_k < υ_k < 1` with `λ_k ≤ f(λ_{k+1})` and `f̃(υ_{k−1}) ≤ υ_k`.
- **TERM.** Every valid map can be modified by moves into a valid map where no move applies anywhere, each point recoloured finitely often.
- **CONE.** In a terminal valid map no colour has two sectors at a vertex; every vertex is cubic, possibly with cusp horns.
- **RED.** Every tight six-map in `𝓜_K` under Condition 5 has a valid cubic modification; the base (S–V Cor. 1 a.e.) must then hold for
  cubic maps with cusp horns.
- **HEX.** A partial result on S–V's `d = 2` configuration; moot for W-4 now that G-d2 does not arise (claims §8, second update).

### 1.4 Registered expectations (before any derivation is written; both outcomes named reachable)

| claim | expected | P | what the other outcome would look like (reachable) |
|---|---|---|---|
| SHADOW | TRUE | 0.95 | FALSE: a contact tile whose shadow boundary at `v` is not the concentric circle (e.g. a centre off the normal line) |
| FLANK | TRUE, possibly MISSTATED for omitting "flanks of positive angle" | 0.55 TRUE as stated | FALSE: a flank shadowed through a contact not at `S′`/`N`, e.g. an in-type contact, or a flank that is itself a horn |
| SHAVE | TRUE | 0.85 | GAP: a tip that is not doubly shadowed yet cannot be split validly |
| RAY | TRUE | 0.8 | FALSE: a `c`-shadow entering between two valid `c`-horns on one ray |
| STUCK | TRUE over NB-4, W-MERGE, N3-DEG | 0.75 | GAP at "degree 4" or at "`h` has two sectors at `N`" |
| PROP | TRUE given STUCK | 0.85 | GAP: `N` stuck but with its horns off `±a`, or its cone colour not `h` |
| FIN | TRUE | 0.95 | FALSE: a bi-infinite solution (one exists if `λ_k = υ_k` were allowed: the constant 0) |
| TERM | TRUE | 0.7 | GAP: a move raising `Φ` elsewhere, or a limit that is not terminal |
| CONE | TRUE over its inputs | 0.7 | GAP inherited from the above |
| RED ⟹ W-4 NO | the modification TRUE; **W-4 NO a GAP at the base's scope (cusp horns)** unless the base covers them | 0.6 | TRUE outright if the base's proof is blind to cusps |
| WCH (control) | `v` stuck (SHAVE blocked, doubly shadowed); `N` not stuck | 0.8 | SHAVE applies at `v` (then the tip-hard claim measures single-colour moves only) |
| WC1H (control) | `v` is already cubic with a cusp sector, not a two-sector cone; SHAVE applies | 0.7 | SHAVE blocked (`σ_h < σ_g`) |

### 1.5 "Would have searched here" log

- none yet.

## Stage 2 — SAVED (derivations from the statements alone)

Frame: `v = 0`, `a = (1, 0)`, `n = (0, 1)`, `N = n`, `S′ = −n`; `p = (T, Y)` a point near `v`; "above" means `+n`. Validity is A-EXACT's
condition. For `p` near `v`, `ω(p)` is `t`-close to `ω(v)`, so only tiles touching `ω(v)` matter (tiles at positive distance from `ω(v)` are
cleared by taking the move's scale `t₀` small); by A-CIRC a colour of `P_cl(v)` meets `ω(v)` only at finitely many **contact points**
(Condition 5 and finite complexity: a circular arc meets `ω(v)` in at most two points unless it is a unit arc).

### 2.1 SHADOW (N4-SHADOW) — TRUE
For a connected open tile `A` touching `ω(v)` at `x` from outside, `ω(p) ∩ A ≠ ∅` iff `dist(p, A) < 1` for `p` near `v` (the far side of `A` is
beyond distance 1), so the shadow is `⋃_{a ∈ A} D(a, 1)` locally. If `A` near `x` is the region beyond an arc of centre `C` on the line `vx`:
for a disc `D(C, R)` (`λ = 1/R > 0`, `|C − v| = 1 + R`) the shadow is `{|p − C| < 1 + R}`; for a disc complement (`−1 < λ < 0`, `C` beyond `v`,
`|C − v| = 1/|λ| − 1`) it is `{|p − C| > |C − v|}`. Either way: the side containing `x` of the circle through `v` centred at `C`, curvature
`f(λ) = λ/(1+λ)` toward `x` (C1a, C1b exact); from `S′`, `f̃(υ) = υ/(1−υ)`; the second-order forms agree (C1c, C1d: `max_x` gives `Y − fT²/2`,
`min_x` gives `Y − f̃T²/2`, attained at `x = T/(1+λ)`, `T/(1−υ)`, i.e. on the same side as `T`). An in-type arc of curvature `k > 1` gives the far
side of a circle of curvature `k/(k−1) > 1` (C1e); a corner at `x` gives `ω(x)` (curvature `±1`). `f: (−1, ∞) → (−∞, 1)`, `f̃: (−∞, 1) → (−1, ∞)`,
inverse to one another. So **every shadow near `v` is a finite union of one-sided circle regions through `v`** (used throughout below).

### 2.2 FLANK (N4-FLANK) — TRUE, and for flanks of any shape
Let the `c`-horn along `+a` be `{λ₀T²/2 < Y < υ₀T²/2}` (second order; exactly between two circles), `g` the colour across its upper arc, `h`
across its lower arc. A `g`-shadow component `S_Γ` (one side of a circle `Γ` through `v`) that meets the tip arbitrarily near `v`:
(i) if `Γ` is transversal to `a`, the side of `Γ` containing the tip contains a full angular neighbourhood of `+a`, hence the `g`-points just above
the horn — invalid; (ii) so `Γ` is tangent to `a`; if `S_Γ` is above `Γ` and `Γ` cuts into the horn (`curv Γ < υ₀`), it contains the `g`-points
just above the upper arc — invalid; so `S_Γ` is below `Γ`. By §2.1 the below-sides come from out-type tangent arcs at `S′` (`f̃(υ) > −1`), corners
at `S′` (`−1`, below the horn: harmless), and in-type arcs at `N` (curvature `> 1 > υ₀`: contains `g`-points above the horn — invalid). Only
out-type `g`-tiles at `S′` tangent to `a` remain; mirror for `h` at `N`. This uses only that `g` is the colour **adjacent** above the arc, so it
holds whether the flank is a sector or itself a horn.

### 2.3 SHAVE (N4-SHAVE) — TRUE
Let `σ_g` be the highest `g`-shadow boundary and `σ_h` the lowest `h`-shadow boundary (§2.2). Validity of the flanks themselves gives
`σ_g ≤ υ₀` and `λ₀ ≤ σ_h`. A tip point can take `g` iff it is on or above `σ_g`, and `h` iff on or below `σ_h`; the other ring colours are refused
(`Θ ⊕ S¹` crosses the ring) and so is nothing else relevant. Hence a valid recolouring of the tip by the flanks exists iff no tip point lies strictly
between `σ_h < σ_g`, i.e. iff `σ_h ≥ σ_g`; then split along the circle through `v` tangent to `a` of any curvature in `[σ_g, σ_h] ⊂ (−1, 1)`
(Condition 5 holds; the cut at `|z| ≈ t₀` a straight segment), and with `σ_h < σ_g` both lie in the closed horn automatically. `g = h`: a `g`-shadow
cutting into the horn from above contains the lower flank's adjacent points, from below the upper flank's: no `g`-shadow cuts in, recolour the
whole tip `g`. The new vertex at the tip's end is trivalent (the remaining horn blunt, the dividing arc transversal); `Φ(v)` falls by one when `c`
has two sectors (or `g = h`).

### 2.4 RAY (N4-RAY) — TRUE
Two valid `c`-horns `H₁` (lower), `H₂` (upper) on `+a`; `R` the region between them in `B(v, t₀)`. For a `c`-shadow component `S_Γ`: if `Γ` is
transversal to `a`, `R`, `H₁`, `H₂` lie on one side near `v`, the non-shadow side; if `Γ` is tangent to `a` and `S_Γ` lies above `Γ`, then `H₂ ∩ S_Γ = ∅`
puts `H₂` below `Γ` and `R` (below `H₂`) with it; mirror for below. Finite union: `R` is `c`-clear for small `t₀`.

### 2.5 STUCK (N4-STUCK) — TRUE, over NB-4, W-MERGE and N3-DEG
`D_x(v)` (my definition, §1.2) is `S¹` minus open half-circles, one per contact; it is an arc, or the antipodal pair `{±a}` when two shadows have
antipodal centres. With `c` in `P_cl(v)` and its sectors inside `D_c(v)`, the only way to get empty interior with a horn surviving is out-type contacts at
both `v ± n` (the pairs (out N, in N), (in S′, out S′), (in N, in S′) leave an empty horn region: in-type curvatures exceed 1 in modulus, out-type
ones do not — C1e). That is N3-DEG, re-derived. Now at a vertex with no move:
1. every colour with two sectors has `int D = ∅` (W-MERGE), so all its sectors are horns along one line `±a_x` (N3-DEG), at most one per ray (RAY);
2. so a colour with a sector of positive angle has exactly one sector;
3. two cone colours would need four positive sectors between four horns (or, on one line, two cone colours plus two flanks): `≥ 4` colours, against
   NB-4; so `c` is the only cone colour, with one horn on `+a` and one on `−a`;
4. the upper and lower half each need a positive sector, each of a distinct single-sector colour; with NB-4, `P_cl(v) = {c, g, h}`, degree 4, `g ≠ h`.
No SHAVE on either horn gives (§2.3) out-type `h`-tiles at `N` tangent to `a` on **both** sides (`σ_h^± < σ_g^±`) and `g`-tiles at `S′` likewise.
At `N`: `ω(v)` passes (off `N`) through tiles of colours outside `P_cl(v)` on both sides, so with `c, h ∈ P_cl(N)` and NB-4, `P_cl(N) = {c, h, r}`.
No in-type `c` or `h` at `N` (their shadows, curvature `> 1`, cover `v`'s horns, resp. `v`'s lower sector: invalid), so below `ω(v)` near `N` is `r`
only. A `c`-horn at `N` between `r` and `h` on either side would cast `f(λ_c) < f(λ_h) < υ₀`: into `v`'s own horn, invalid; so `c` lies above both
`h`'s, and the two `h`'s at `N` are separated by `c` above and `r` below: **two `h`-sectors at `N`**. Mirror at `S′`. (If the upper half at `N` were one
`h`-sector, `c` would have nowhere to be.)

### 2.6 PROP (N4-PROP) — TRUE; and the chain inequalities are validity
In a terminal map `N` has `Φ(N) > 0` and no move, so §2.5 applies at `N` to `h`: its horns lie on the line through `N` tangent to the `+a`-side
`h`-arc, i.e. `±a` again, its contacts are `N ± n = v, v + 2n`; its upper flank is `c` (outside `ω(v)`; `c` below would put `c`-points of `ω(v)`'s
neighbourhood inside the tile), its lower flank the ring colour `r`. So `P_1 = N`, `a_1 = h`, `a_2 = r`, and at `P_k` the upper flank is `a_{k−1}`,
the lower `a_{k+1}`; induction in both directions. **The inequalities FIN needs come from validity alone**: `P_k`'s lower flank `{Y < λ_kT²/2}`
must avoid the shadow `{Y > f(λ_{k+1})T²/2}` of the `a_{k+1}`-horn at `P_{k+1}` (the shadow of a horn is that of the region above its lower arc,
C1c), so `λ_k ≤ f(λ_{k+1})`; the upper flank against the `a_{k−1}`-horn at `P_{k−1}` gives `f̃(υ_{k−1}) ≤ υ_k` (C1d); N3-DEG gives
`−1 < λ_k < υ_k < 1` (positive width: an open tile). The blocking condition is used only to build the chain.

### 2.7 FIN (N4-FIN) — TRUE
`1/f(λ) = 1/λ + 1`, `1/f̃(υ) = 1/υ − 1`, both increasing (C2a). If some `υ_k > 0`: `υ_{k+1} ≥ f̃(υ_k) > 0` and `1/υ_{k+1} ≤ 1/υ_k − 1`, so
`υ_{k+m} ≥ 1` within `⌈1/υ_k⌉` steps. Otherwise every `υ_k ≤ 0`, so every `λ_k < 0`, and going down `1/|λ_{k−1}| ≤ 1/|λ_k| − 1`: `λ ≤ −1`
within `⌈1/|λ_k|⌉` steps. Exact rationals on a 193×193 grid of starts: no survivor, no bound exceeded (C2b, C2c). **Plant:** with `λ_k = υ_k`
allowed, `(0, 0)` survives (fires). Note: one direction of the chain, of length `⌈max(1/υ₀, 1/|λ₀|)⌉`, already suffices.

### 2.8 TERM (N4-TERM) — TRUE
Moves at `u` act inside `B(u, t₀(u))`, `t₀` below the distance to every other vertex and to every tile not touching `ω(u)`; each is checked valid
against the current map (validity is symmetric, so a later move is checked against earlier ones). A move lowers `Φ(u)` by one and changes no other
`Φ`: new vertices are trivalent with transversal arcs (`Φ = 0`), and no other vertex lies in the changed set. So at most `Σ Φ₀` moves ever touch a
bounded set. Fair schedule (vertices enumerated, round `m` exhausts `v_1…v_m`): in the limit every point changes finitely often, the limit is valid
(a pair at distance 1 is settled after finitely many stages), locally finite with `O(K)` arcs per unit disc and new radii `> 1` (dividing arcs of
curvature in `(−1, 1)`, straight cuts), Condition 5 kept, tiles connected. Terminal: a move available at `v` in the limit reads only `B(v, 3)`, which
is final after a finite stage, so it would have been applied. By K-TIGHT every valid six-map is tight, so NB-4 applies to every stage.

### 2.9 CONE and RED (N4-CONE, N4-RED) — TRUE over their inputs; W-4 NO is a GAP at the base's scope
CONE: in a terminal map a vertex with a two-sector colour is stuck (§2.5), so starts a chain (§2.6) that FIN forbids (§2.7). Every vertex then has
degree `|P_cl| ≤ 3` (NB-4): S–V Condition 7 with bichromatic points no longer vertices. RED: TERM plus CONE. **But the terminal map keeps single
cusp horns** (a cubic vertex whose third colour is a horn, like WC1H's `v`): no move of N4's lowers `Φ` there, and they exist in tight maps from the
start (FS110-Y4's WC1, degree 3). So **W-4 NO needs the base (S–V Cor. 1 a.e., FS110-CB/CD) for cubic maps with cusp horns** — N4 says so itself.
S–V's own §6 construction reads only boundary points (their Prop. 2, points `x₄₅, x₄₆, x₅₆` on a small circle), which on its face does not use
positive angles; I have not walked CB/CD's repair (fenced), so this stays a scope item for them. **Proposal (NB4-CS):** add SHAVE on single horns
(the horn count falls, `Φ` never rises; the §2.3 criterion is unchanged); then every surviving cusp horn is doubly shadowed (`σ_h < σ_g`), a narrower
case for the base. WC1H's cusp is removed this way (§2.10).
**Sign of the partial answer.** W-4 NO means no six-map exists, i.e. **seven colours are needed**: the Condition-5 half of S–V Question 2 ("Is it true
that 7 colors are needed …") is answered **YES**, a.e., for maps with circular or straight arcs of bounded complexity. The instance block's "answered
NO" is a sign slip (a wording correction owed; claims §7's "decides" is neutral and right).

### 2.10 The controls (FS110-Y4's fragments, rebuilt from their formulas; `tools/fs110_nb4_check.py`, output `data/fs110/fs110-nb4/check.out`)
- **WCH.** At `v`: `λ₀ = −1/2`, `υ₀ = 1/2`; `N`'s 3-horn `λ₁ = −1/4`, `υ₁ = 1/2`; `S′`'s 2-horn `λ₋₁ = −1/2`, `υ₋₁ = 1/4`. `σ_h = f(−1/4) = −1/3`,
  `σ_g = f̃(1/4) = 1/3`: `σ_h < σ_g`, SHAVE **blocked**; exact witnesses: `p = (T, 0)`, `T = 1/100, 1/1000`, is in the horn and `ω(p)` has rational
  points strictly inside `N`'s 3-horn and `S′`'s 2-horn (C3). Colour 1's contacts at `N`, `S′` are out-type (`λ = 2`, `f = 2/3`): Woodall cone, no MERGE;
  one horn per ray: no MERGE-RAY. **So `v` is stuck in N4's sense, and N4-STUCK's conclusions hold at `v`** (degree 4, `P_cl(N) = {1,3,4}`,
  `P_cl(S′) = {1,2,5}`, 3 two sectors at `N`, 2 two at `S′`). **`N` is not stuck**: colour 4 has three sectors there (above each 3-horn, between the
  arcs of curvature `1/2` and `2`, and below); in the fragment no colour-4 tile touches `ω(N)` (`ω(N)` meets the ring band only at directions
  `26.9°–37.3°` and `142.7°–153.1°` from `v`, colour-5 pieces), so MERGE of colour 4 is available. And colour 1 cannot be directly above `N`'s 3-horn:
  `q = N + (1/100, 4·10⁻⁵)` has a rational point of `ω(q)` inside `v`'s 1-horn (C3) — FIN's first upward step failing, `f̃(υ₀) = 1 > υ₁`. So WCH is
  consistent with STUCK and cannot sit in a terminal map with `v` stuck. **Plant:** `N`'s 3-horn raised into the band `(1/2, 2)`: the 3-witness
  fails, the 2-witness holds (fires for its reason: `σ_h = f(1/2) = 1/3`, `p` off the `h`-shadow).
- **WC1H.** `v` has colour 1 in **one** horn (on `+a`), 2 above, 3 below, the `2|3` boundary along `−a`: degree 3, **cubic with a cusp sector, not a
  two-sector cone**; `Φ(v) = 0`, outside N4-CONE's scope and inside the base's. `N`'s 3-sector has its lower ray along `+a` (`λ = 0`), `S′`'s 2-sector
  its upper ray (`υ = 0`): `σ_h = σ_g = 0`, **SHAVE applies**, split along `+a`: the colour-2 half has `y > 0` against `S′`'s 2-sector in `y < −1`,
  the colour-3 half `y < 0` against `N`'s 3-sector in `y > 1`, so every cross-distance exceeds 1 (`|p − q| ≥ |p_y − q_y|`). Both single-colour
  recolourings are refused, exactly (C4: `ω(p)`'s lowest/highest point lies in the opposite sector). **Plant:** the 3-sector turned to `−30°`: the
  half-plane check fails (fires).

### 2.11 Killing tests on N4's shape (the brief's extra duty)
- **Seven-colour control.** Tight and slack hexagonal seven-colourings: every vertex trivalent, no horns — no move applies, CONE is vacuous, and RED
  hands the map to the base, which must fail at seven (`ω(u)` then carries four colours). "Six" is spent at NB-4 (used at §2.5 for degree 4 and for
  `P_cl(N) = {c, h, r}`) and in the base. FIN and SHADOW are colour-free; a seven-colour map with a bi-infinite chain of such cones is forbidden too,
  which is consistent (no seven-colouring needs one). Townsend's ⅔π sector has a unit arc: Condition 5 fails, `f(−1)` is undefined, the strict bounds
  `|λ|, |υ| < 1` fail, and N4 correctly does not apply.
- **Strip, pinhole, Parts.** N4 makes no area or hole-count claim and its objects are full maps (LIM); the tests do not apply. A strip map has no
  trichromatic vertex, so by K-BICH it uses two colours and is invalid: nothing for N4 to do.
- **C-SEAMLIST.** N4's route does not use C-T-TAN. Its failures at a vertex are handled so: four colours by NB-4; V5 vertices, bowties and cones (a
  colour in two sectors) by the modification (a bichromatic point of degree `≥ 4` has a positive-angle colour in two sectors: MERGE); cusps, tangent
  interfaces, slivers and `d = 2` pass to the base. Completeness is the base's.
- **Act One.** Supplied by the base (cubic maps need seven), a theorem apart from the kills — at two blind minds, with the cusp scope above.

### 2.12 "Would have searched here" log
- WCH's horn lengths at `N` are not given in the fragment: instead of scanning for a witness scale, the witness is computed at `x ≈ 4T/3` and the
  scale `T → 0` argument used (any positive horn length contains it).
- Nothing else.

## Stage 3 — SAVED (verdicts committed before opening anything fenced)

| claim | verdict | minds (with N4) | grade | note |
|---|---|---|---|---|
| N4-SHADOW | **TRUE** | two (one blind) | [hand + exact] | §2.1, C1 |
| N4-FLANK | **TRUE** (holds for flanks of any shape: the colour adjacent across the arc) | two (one blind) | [hand] | §2.2 |
| N4-SHAVE | **TRUE**; "both inside the horn" is automatic given validity and `σ_h < σ_g` | two (one blind) | [hand] | §2.3 |
| N4-RAY | **TRUE** | two (one blind) | [hand] | §2.4 |
| N4-STUCK | **TRUE over NB-4, W-MERGE and N3-DEG** (N3-DEG re-derived with my `D_c`) | two (one blind) | [hand] | §2.5 |
| N4-PROP | **TRUE** | two (one blind) | [hand] | §2.6 — FIN's inequalities come from validity, not blocking |
| N4-FIN | **TRUE**; strictness `λ_k < υ_k` necessary | two (one blind) | [hand + exact] | §2.7, C2 + plant |
| N4-TERM | **TRUE** | two (one blind) | [hand] | §2.8 |
| N4-CONE | **TRUE over its inputs** | two (one blind) | [hand] | §2.9 |
| N4-RED | **TRUE** as the cubic modification | two (one blind) | [hand] | §2.9 |
| W-4 NO (the claimed consequence) | **GAP at the base's scope**: the terminal map keeps single cusp horns (they exist in tight maps from the start, WC1); the base must be confirmed for cubic maps with cusp horns (N4 says so itself); proposal NB4-CS narrows it to doubly-shadowed cusps | — | — | §2.9 |
| "the Condition-5 half of S–V Question 2 is answered NO" (instance block) | **MISSTATED (sign)**: W-4 NO answers S–V's "Is it true that 7 colors are needed" **YES** in that half, a.e., at bounded complexity, for circular/straight arcs | — | — | §2.9 |
| N4-HEX | not examined (moot: G-d2 does not arise, claims §8 second update) | — | — | — |
| Controls | **WCH**: `v` stuck in N4's sense, SHAVE blocked (`σ_h = −1/3 < σ_g = 1/3`), `N` not stuck; **WC1H**: `v` cubic with a cusp, not a two-sector cone; SHAVE applies (`σ_h = σ_g = 0`) | — | [tools, exact] | §2.10, C3–C4 |

**Registered expectations scored:** all as predicted, except FLANK (I registered 0.55 on "TRUE as stated", with a MISSTATED possible for horn flanks;
it is TRUE for flanks of any shape — my expectation was too pessimistic) and WC1H (registered "SHAVE applies" at 0.7: met).

**Correction to §2.10 (found while re-reading, before opening anything):** `ω(N)` meets the ring band `0.9 ≤ |z| ≤ 1.1` where `|z|² = 2y`, i.e.
`y ∈ [0.405, 0.605]`, at directions `26.7°–33.4°` and `146.6°–153.3°` from `v` (not `26.9°–37.3°`, `142.7°–153.1°`); both inside the colour-5
pieces, so the conclusion (no colour-4 contact on `ω(N)`) stands.

## Stage 4 — SAVED (after opening `plans/FS110-N-proof.md` § Continuation — FS110-N4, `tools/fs110_n_*`, `data/fs110/fs110-n/`)

**Quotation check, completed.** The instance block's N4 table is verbatim to `plans/FS110-N-proof.md` l. 716–726 (`diff`, exit 0); N3-DEG and N3-RED
in claims §8 are verbatim to l. 529, 531. N4's `tools/fs110_n_shadow.py` (sympy, exact) passes C1–C4 here, and its three plants fire (`wrongf`,
`nearside`, `downward`).

**Agreement, item by item.** SHADOW, FLANK, SHAVE, PROP, FIN, TERM (as a count of `Φ`-lowering moves), CONE and RED: same statements, same truth; N4's
definitions (`D_c(v)` an intersection of closed half-planes; `Φ`; valid; terminal) coincide with mine (§1.2). N4 derives FIN's inequalities from
validity (N-E0) too (its §2.6), as I did (§2.6). N4-FLANK's setting ("the tile directly above `H`") is already shape-free, which is why my expectation of
a missing hypothesis lost. N4-HEX (a) checked here: `A_1 ∈ ω(u) ∩ ω(p_+)`, `A_2 ∈ ω(u) ∩ ω(p_−)`, `|A_1 − A_2| = 1`, and the only colour left is `γ`:
TRUE; (b), (c) not examined (moot).

### 4.1 Divergences

| # | kind | where | N4 | this job | proposed edit for the close |
|---|---|---|---|---|---|
| D1 | **truth (sign)** | N4-4, and the instance block | "the Condition-5 half of `[SokolovVoronov2025]` Question 2 is answered **NO**" | S–V ask "Is it true that 7 colors are needed …?"; no six-map exists, so the answer in that half is **YES** | "… Question 2 is answered **YES — seven colours are needed** — almost everywhere, for locally finite maps with circular or straight arcs of bounded complexity: a partial answer" |
| D2 | **MISSTATED (headline drops a hypothesis; FS-107's M3)** | N4-4 "**W-4: NO** [hand; N4 one mind, over its bases]"; instance block "W-4 is NO" | the cusp scope is named two paragraphs below, not in the headline | the headline must carry it | "**W-4: NO, given the base for cubic maps with cusp sectors** (FS110-CB/CD not yet read for them; N4-P3 at 0.6)" |
| D3 | scope / precision | N4-TERM vs §2.8, N4-4 item 1 | TERM counts moves by "`Φ(v)` down by at least one"; §2.8 says the surviving cusps are "a single horn whose flanks both shadow it" — which presumes SHAVE on single horns, a move that does not lower `Φ` | count `Φ + #horns` (horns never increase: SHAVE, MERGE, MERGE-RAY and N4's wedge-opening create none); then SHAVE on single horns and the opening remedy both join the moves | state the residue exactly: **a single cusp horn at a cubic vertex survives only if it is doubly shadowed (`σ_h < σ_g`) and `D_c(v)` is the line `±a` (out-type `c`-contacts at both `N` and `S′`)** — a single-horn Woodall cone. The base need only cover that |
| D4 | scope (repair) | N4-4 item 2 (no radius lower bound) | new arcs `∂B(v, ρ)` of radius `ρ < 1/K` may leave `𝓜_K` | cut with straight chords (a small convex polygon about `v`) in SHAVE, MERGE and MERGE-RAY; the dividing arc `Σ` has curvature in `(−1, 1)`, radius `> 1` | item 2 dissolves: `M* ∈ 𝓜_{K′}`, radius bound kept, `K′ = O(K)` [hand, one mind] |
| D5 | route | N4-RAY | "the escape bound in the second-order model" | exact: every `c`-shadow near `v` is a finite union of one-sided circle regions through `v` (§2.1); for a component above `Γ` tangent to `a`, `H₂` below `Γ` puts the region between the horns below it; transversal `Γ` misses the stack | replace the second-order bound by this (§2.4 here) |
| D6 | route | N4-STUCK (ii) | identifies `g_+ = g_−`, `h_+ = h_−` from the contact types (N3-CONF) | from no-MERGE for **every** colour at `v` (W-MERGE, N3-DEG) plus NB-4 | none; two routes to one statement |
| D7 | control, new | FS110-Y4's WCH, WC1H (N4 was blind to them) | N4-P2: "any hard cone fragment … admits a SHAVE at one of its horns, or has an antipode that is not a cone vertex" | WCH: `v` stuck, SHAVE blocked (`σ_h = −1/3 < σ_g = 1/3`), and `N` is not a cone vertex (colour 4 has three sectors, `D_3(N)` a half-plane) — second disjunct; WC1H: `v` cubic with a cusp, SHAVE applies (`σ_h = σ_g = 0`) — first disjunct | N4-P2 **met** on both (scored by this job, one mind); the construction side's "tip-hard" (every single-colour tip recolouring refused) does not stop the two-colour split |

**Registered N4 predictions, scored here:** N4-P1 (a blind verifier finds N4-CONE TRUE, possibly with repairs at RAY's escape bound or TERM's limit)
**met** — TRUE, with RAY's bound replaced (D5) and TERM's count made precise (D3). N4-P2 **met** (D7). N4-P3 (the base extends to cusp horns) **open**,
narrowed by D3 to single-horn Woodall cones that are doubly shadowed. My own: 11 of 12 as registered; FLANK's MISSTATED risk did not materialise.

**Grades after this check:** N4-SHADOW, FLANK, SHAVE, RAY, STUCK, PROP, FIN, TERM, CONE, RED: [hand, two minds, one blind]; **N3-DEG now two minds, one
blind** (re-derived here, §2.5); W-MERGE and NB-4 as before. W-4 NO: at that grade **given the base for cubic maps with cusp sectors**.

### 4.2 Proposed ledger wording (for the close; not written by me)

"Under Condition 5, every full a.e.-proper six-colouring by a locally finite map with circular or straight arcs has a valid modification that is
cubic at every vertex (G-CONE closed: MERGE, MERGE-RAY, SHAVE, and the chain along the normal line that FIN forbids). With S–V Cor. 1 almost everywhere
for curved cubic maps (FS110-CB, FS110-CD), and once that base is read for cubic vertices with a cusp sector (the residue: doubly-shadowed single-horn
Woodall cones), no tight six-map in `𝓜_K` satisfies Condition 5: seven colours are needed — the Condition-5 half of `[SokolovVoronov2025]` Question 2
answered **yes**, a.e., at bounded complexity. [hand; the reduction two minds, one blind (FS110-N4, FS110-NB4); the base two blind minds; the cusp
scope owed.]" Prior art to cite beside it: `[SokolovVoronov2025]` Props. 7–8 (the polygonal reduction of a vertex's degree), of which W-MERGE and SHAVE
are the curved-arc forms.

### 4.3 Fence log
- At start-up, one `ls` of the shared harness scratchpad root printed ten file **names** (`a0.txt`, `a1.txt`, `a2.out`, … `a4.txt`) of files this job
  did not create. Names only; none opened. Disclosed.
- After Stage 3: opened only `plans/FS110-N-proof.md` (N3 §2.1–§2.6 and all of § Continuation — FS110-N4), `tools/fs110_n_shadow.py` (run, and its
  plants), the listing of `tools/fs110_n_*` and `data/fs110/fs110-n/` (empty). Nothing of the construction side, the other verifiers, the plan, the
  advisors, the inventory, the reports or other briefs was opened; `git log` beyond my own commits not read.

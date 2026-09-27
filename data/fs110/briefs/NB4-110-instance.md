*Instance block for job **FS110-NB4**, the round-4 blind verifier of the proof side. Its brief is `data/fs110/briefs/NB110-verify-proof.md`; this file
is part of it and is not fenced. Filled in by the product owner on 2026-09-27, when FS110-N4 handed back.*

## Overrides of the brief for this instance

- **Your job id** is FS110-NB4.
- **Your record** is `plans/FS110-NB4-verification.md`.
- **Your working directory** is `data/fs110/fs110-nb4/`.
- **Your tools** are `tools/fs110_nb4_*.py`.
- **Your commit subjects** are "FS110-NB4: stage n".
- **Your report** goes to `data/fs110/reports/FS110-NB4.md`.
- **Your scratch** is `scratchpad/fs110-nb4/`.

## Scope

- **The side verified:** round 4 of the proof side, FS110-N4. Its work is the section "§ Continuation — FS110-N4" of `plans/FS110-N-proof.md`.
  - The whole record stays fenced until your stage 3 is committed, and so do its tools.
  - Every other verifier's record is fenced too.
- **What round 4 asks:** W-4, the `d = 2` seam, in `data/fs110/claims.md` §8 with its two updates. §7.1 defines the terms. Read §7, §7.1 and §8
  first. Two blind minds have settled that G-d2 does not arise, so W-4 is now G-CONE alone.
- **The side's claimed verdict: G-CONE is CLOSED** (N4-CONE, one mind). With the base (S–V Cor. 1 a.e., no `d = 2` exception, two blind minds),
  W-4 is NO: the Condition-5 half of S–V Question 2 is answered NO almost everywhere at bounded `K`. That is a partial answer to a question in print.
  **It is held at one mind until you report.** Audit it at the rate of a result you would like (G21).
- **The load-bearing chain, in priority order:**
  1. **N4-STUCK and N4-PROP.** A stuck vertex forces a bi-infinite chain of stuck vertices along the normal line.
  2. **N4-FIN.** Curvature monotonicity forbids that chain.
  3. **N4-SHAVE**, with N4-FLANK and N4-SHADOW.
  4. **N4-RAY.**
  5. **N4-TERM:** a terminal modification exists on the whole plane, each point changed finitely often.
  6. **N4-CONE.**
- **Control objects.** The construction side built "tip-hard" cones locally (fragments WCH and WC1H, below), in which every single-colour tip
  recolouring REJECTs.
  - **Test N4-SHAVE and N4-STUCK against them:** does SHAVE, which recolours a tip with its flank colours, apply to each, or is each stuck in N4's
    sense?
  - In WC1H the antipodes are ordinary trivalent vertices. Is WC1H's `v` a two-sector cone vertex at all, or already cubic with a cusp sector?
  - Build the fragments with your own exact checker, from the formulas.
- **The base's scope:** N4 says the base must hold for cubic maps whose sectors may be cusp horns. Say whether your derivation needs that, and why.

## The side's theorem table (FS110-N4), verbatim

| id | statement (one line) | grade | address |
|---|---|---|---|
| N4-SHADOW | the shadow at `v` (on the `+a` side, near `v`) of a tile at `N = v + n` lying beyond an arc tangent to `a` at `N` with centre `C` on the normal line is exactly the `N`-side of the circle through `v` centred at `C`; concentric curvature `f(λ) = λ/(1+λ)` going down, `f̃(υ) = υ/(1−υ)` going up | [hand, one mind; exact check C1–C2, `tools/fs110_n_shadow.py`] | stage N4-2, §2.1 |
| N4-FLANK | a horn of `c` along `a` at `v` with flanks `g` (above), `h` (below) is shadowed by a flank colour only through out-type `g`-tiles at `S′` tangent to `a` (shadow below `σ_g`) and out-type `h`-tiles at `N` tangent to `a` (shadow above `σ_h`) | [hand, one mind] | §2.2 |
| N4-SHAVE | the horn tip can be recoloured by its flanks (valid, Condition 5, `Φ(v)` down by one) unless `σ_h < σ_g` with both inside the horn (doubly shadowed); `g = h` never blocks | [hand, one mind] | §2.2 |
| N4-RAY | two `c`-horns on one ray at `v` merge (the horns between them are `c`-clear near `v`) | [hand, one mind; N3 §2.3 (i) completed; the escape bound in the second-order model] | §2.3 |
| N4-STUCK | at a vertex admitting no MERGE, MERGE-RAY or SHAVE, a colour `c` with two sectors has exactly two horns `±a`, the vertex has degree 4 (`g` above, `h` below), `P_cl(N) = {c, h, r}`, `P_cl(S′) = {c, g, r′}`, and `h` has two sectors at `N`, `g` two at `S′` | [hand, one mind] | §2.4 |
| N4-PROP | in a terminal map a stuck vertex `P_0` forces stuck vertices `P_k = P_0 + kn` for all `k ∈ ℤ`, cone colours `a_k`, type `{a_{k−1}, a_k, a_{k+1}}` | [hand, one mind] | §2.5 |
| N4-FIN | no bi-infinite sequence `−1 < λ_k < υ_k < 1` with `λ_k ≤ f(λ_{k+1})` and `f̃(υ_{k−1}) ≤ υ_k`: upward at most `1/υ` steps when `υ > 0`, downward at most `1/\|λ\|` when `λ < 0` | [hand, one mind; exact check C3] | §2.6 |
| N4-TERM | every valid map has a terminal valid modification (all vertices, whole plane; each point changed finitely often) | [hand, one mind] | §2.7 |
| N4-CONE | **in a terminal valid map no colour has two sectors at any vertex: every vertex is cubic (sectors possibly cusp horns). G-CONE is closed.** | [hand, one mind, over NB-4 (two minds, one blind), W-MERGE (two, one blind), N3-DEG (one)] | §2.8 |
| N4-HEX | in S–V's `d = 2` configuration (antipodes `p_±` of a trivalent `u`, one type `{α, β, i}`): of `σp_+, σ²p_+` (and of `σ⁻¹p_+, σ⁻²p_+`) not both are tile points; if both antipodes are ring change points, all four are, the antipodes change the same way, and each side carries pattern R or R′; R–R dies (N2-HEX, N3-P17), R′–R′ dies ((in, in)); mixed and non-change antipodes undecided | [hand, one mind; over N2-SWAP, NB-5] | stage N4-3 |
| N4-RED | every tight six-map in `𝓜_K` under Condition 5 has a valid cubic modification on the whole plane; N3-RED's residue is G-d2 alone, and the base must hold for cubic maps whose sectors may be cusp horns | [hand, one mind, over FS106-V's repaired S–V Cor. 1] | §2.8 |


## Control objects: the construction side's cone fragments, verbatim (FS110-Y4's §11.3 and §11.4)

### 11.3 The cone, realised with its ring [tools, exact, for the members; the formulas hand, one mind]

`tools/fs110_y_cone.py` (imports `tools/fs110_y_check.py`, unedited; data rational). Every same-colour pair is generated from the colour map, each
tile against itself included. Outputs `data/fs110/fs110-y/y4_cone_*.out`.

| fragment | formula | symmetry | pairs | verdict |
|---|---|---|---|---|
| **WC** | `v`: horns `h±` (colour 1) between the circles of radius 2 about `(0, ±2)` (`κ₂ = 1/2`, `κ₁ = −1/2`), length `≈ 0.1`; colour 2 above, 3 below, in the box `[−1/10, 1/10]²`: closure type `{1,2,3}`, essential `{2,3}`, degree 4. `N`: colour-1 tile above the arc of radius `1/2` about `(0, 3/2)` (`λ = 2`, `μ = 2/3`). `S′`: its mirror. **`v`'s ring**: the band `9/10 ≤ r ≤ 11/10`, nine pieces cut at the directions `2 atan t`, `t = ±3/17, ±4/7, ±6/5, ±11/4` and `180°`, coloured `6,5,4,6,5,4,6,5,4` counter-clockwise from the piece about `0°` (`W = 3`); the piece about `90°` (colour 4) wraps `N`'s tile, the piece about `270°` (colour 5) wraps `S′`'s | `y ↦ −y` with `(2 3)(4 5)` | 30 | **ACCEPT**, tight (4 contacts at exactly 1) |
| **WC1** | WC with `h−` removed, the `2\|3` boundary along `−a`: degree 3 | none | 26 | **ACCEPT**, tight |
| **WCEQ** | horns between the circles of radius 3 about `(0, ±3)` (`κ = ±1/3`); contacts bounded by the arcs of radius 2 about `(0, ±3)` (`λ = 1/2`, `μ = 1/3`): **equality**; each horn arc and its contact's arc are concentric at distance exactly 1 (contact arcs) | `y ↦ −y` | 30 | **ACCEPT**, tight |

`N` and `S′` are edge points of types `{1, 4}` and `{1, 5}`: different. No arc anywhere has radius 1 (radii 2, 3, 1/2, 9/10, 11/10); no vertex
carries four colours; no two vertices within distance `< 2` have complementary types. Float geometry guard: no overlaps, discs of radius `0.05` about
`v`, `N`, `S′` and the band `0.93 ≤ r ≤ 1.07` covered (4,917 samples each).

**Planted faults, each REJECT for its own reason:** `wc_flat` (both contacts' arcs of radius 2 about `(0, ±3)`: `μ = 1/3 < 1/2`) → the four
horn–contact pairs, minimum `0.99917`; `wc_fat` (`h+`'s upper boundary a segment of slope `1/10`: a colour-1 sector of positive angle) → `(N1,
h+)` only; `wc_col2` (the ring piece at `90°` coloured 2) → `(r2, v2)` (A-CIRC at `v`); `eq_steep` (WCEQ's upper horn arcs of radius 2: `1/2 >
1/3`) → the `N` side only. The checker's `closed_interval` plant REJECTs exactly the exact contacts (tightness certified); `noself` and
`endpoints_only` cannot fire here (every diameter `< 1`; no extreme only at interior points), so they test nothing on these fragments; `cw_arcs`
fires broadly. **A slip of mine, found by the checker:** WCEQ as first built kept `WC`'s lower horn arc (`κ₁ = −1/2`) against `μ_S = 1/3` and
REJECTed at `(S1, h±)`, range from `0.99917` — the inequality of §11.2 on the `S′` side, for its own reason. Repaired by the derived lower arc
(radius 3 about `(0, −3)`); no other value tried.


### 11.4 Soft and tip-hard cones (Y4-TIP, Y4-HARD) [hand, one mind; tools, exact, on the named fragments]

**The move.** Recolour the tip `Θ = h+ ∩ B(v, t₀)` into a colour `j`. It is legal iff no interior point of a `j`-tile lies at distance exactly 1
from an interior point of `Θ`. Let `x`, `y` be `v`'s essential colours on `N`'s and `S′`'s sides.
- *`j` in `v`'s ring.* `Θ ⊕ S¹` is `ω(v)` translated by at most `t₀` along `a`: a band about `ω(v)` meeting every ring tile's interior off `±n`.
  **Blocked** for every colour the ring uses (all three in a three-colour ring).
- *`j = x`.* A point `q` off the directions `±n` has `ω(q)` crossing the horn transversally, hence meeting `x`'s interior: not `x` (A-EXACT
  against `v`'s `x`-tile; for `q ∈ B_v(s)` also by A-EXACT's second clause). Near `N`, `ω(q)` curves up through the tip into `x` (`κ₂ < 1`): not
  `x`. Near `S′`, with `q = S′ + (T, Y)` (`Y` toward `v`), `ω(q)` curves down: it misses `x` iff `Y ≤ κ₂T²/(2(1 + κ₂))` and enters the tip iff
  `Y > κ₁T²/(2(1 + κ₁))` (maximising `y(t) − boundary(t)` over `t`), with `T = O(t₀)`. So the recolouring is **blocked for every `t₀` iff
  `x`-interior points accumulate at `S′` inside `R_x = {κ₁T²/(2(1 + κ₁)) < Y ≤ κ₂T²/(2(1 + κ₂))}`** (on each side carrying a horn).
- *`j = y`.* The mirror: blocked for every `t₀` iff `y`-interior points accumulate at `N` inside `R_y = {κ₁T²/(2(1 − κ₁)) ≤ Y < κ₂T²/(2(1 −
  κ₂))}` (`Y` away from `v`).
- *Consistency.* `R_y` lies strictly between `ω(v)` (`Y = −T²/2`) and every admissible contact boundary (`Y = λT²/2` with `λ/(1 + λ) ≥ κ₂`, i.e.
  `λ ≥ κ₂/(1 − κ₂)`); at the extreme the two coincide, which needs `λ = 1`, a unit arc, exactly when `κ₂ = 1/2`.

**So N3-DEG's two bullets give *soft* cones:** in `WC` the tips recolour into 2 or 3 legally (tip tests ACCEPT) and into 4 not (REJECT against
three ring pieces). **A *tip-hard* cone carries `y` at `N` and `x` at `S′`, each reaching a zero-width window tangent to `a`.** Both kinds are
realised:

| fragment | formula | pairs | verdict | tip → 2 | tip → 3 | tip → 4 |
|---|---|---|---|---|---|---|
| **WC** | §11.3 | 30 | ACCEPT | ACCEPT (soft) | ACCEPT (soft) | REJECT (ring) |
| **WCH** | WC plus a double colour-3 horn at `N` in `R_y = [−T²/6, T²/2)` (boundaries: circle of radius 2 about `(0, 3)`, `Y ≈ T²/4`; radius 4 about `(0, −3)`, `Y ≈ −T²/8`), wrapped by the ring piece; its mirror in colour 2 at `S′`. `N`: `{1, 3, 4}`, `S′`: `{1, 2, 5}` | 40 | **ACCEPT**, tight | REJECT at `(tip, xS+)` | REJECT at `(tip, yN+)` | — |
| **WC1H** | the single horn; at `N` the colour-1 contact is the sector `(60°, 180°)` (a corner toward `h+`: `μ = 1`), colour 3 the sector `(0°, 60°)` with its lower ray along `+a` (inside `R_y`), the ring piece below `y = 1`; `S′` the mirror with `(2 3)(4 5)`. **`N` and `S′` ordinary trivalent vertices, all sectors essential; only `v` degenerate** | 30 | **ACCEPT**, tight | REJECT at `(tip, xS)` | REJECT at `(tip, yN)` | REJECT (ring) |

Plants: `wch_ywide` (the colour-3 horns' lower boundary at `Y ≈ −T²/4`, below `R_y`) → `(v3, yN±)`, `(v2, xS±)`; `wc1h_ylow` (colour 3 at `N`
turned to reach `−30°`, below the tangent line) → `(v3, yN)`, `(v2, xS)`. Both for their own reason: colour `y` below `R_y` at `N` sees `v`'s
`y`-tile at distance exactly 1.



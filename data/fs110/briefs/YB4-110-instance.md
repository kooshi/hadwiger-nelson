*Instance block for job **FS110-YB4**, the round-4 blind verifier of the construction side. Its brief is `data/fs110/briefs/YB110-verify-construction.md`;
this file is part of it and is not fenced. Filled in by the product owner on 2026-09-27, when FS110-Y4 handed back.*

## Overrides of the brief for this instance

- **Your job id** is FS110-YB4.
- **Your record** is `plans/FS110-YB4-verification.md`.
- **Your working directory** is `data/fs110/fs110-yb4/`.
- **Your tools** are `tools/fs110_yb4_*.py`.
- **Your commit subjects** are "FS110-YB4: stage n".
- **Your report** goes to `data/fs110/reports/FS110-YB4.md`.
- **Your scratch** is `scratchpad/fs110-yb4/`.

## Scope

- **The side verified:** round 4 of the construction side (FS110-Y4), meaning the section "§ Continuation — FS110-Y4" of
  `plans/FS110-Y-construction.md`.
  - **The fragment formulas are quoted below from its §11.3 and §11.4.** They are the one part of the record you may read now.
  - The rest of the record stays fenced until your stage 3 is committed, and so do `tools/fs110_y_*` and `data/fs110/fs110-y/`.
  - Every other verifier's record is fenced too.
  - Build your own checker. Never use the side's.
- **What round 4 asks:** W-4, the `d = 2` seam, in `data/fs110/claims.md` §8 and its update. §7.1 defines the terms. Read §7, §7.1 and §8 first.
- **The side's claimed verdict:** W-4 is YES locally at G-CONE. Tip-hard cones exist locally, and G-CONE is never an instance of G-d2 (Y4-D2).
  **This is a local fragment, not a map, and it moves no value.** It does decide which kind of argument a NO needs, so audit it at the rate of a result
  you would like (G21).
- **Priority order:**
  1. Rebuild **WC1H** and **WCH** from the formulas and check them with your own exact checker. Include every tip recolouring, each of which the side
     says REJECTs, and check that each rejects for the reason the side derived.
  2. **Y4-MU.**
  3. **Y4-D2.**
  4. Rebuild **WC**, **WC1** and **WCEQ**.
  5. **Y4-TIP.**

## The side's theorem list (FS110-Y4), verbatim

- **Y4-MU** — an out-type `c`-contact at `N = v + n` whose tile's boundary has curvature `λ > −1` there (away from `v`; `λ = ∞` at a corner)
  forbids `c` near `v` exactly above `y = μ t²/2 + O(t³)`, `μ = λ/(1 + λ)`; so `c`-horns at `v` with bounding curvatures `κ₁ < κ₂` need
  `−μ_S ≤ κ₁ < κ₂ ≤ μ_N` (one-sided, per side of `v`), with equality decided at the next order — [hand, one mind; sufficiency realised and
  both directions planted, `tools/fs110_y_cone.py`], §11.2.
- **Y4-WC** — N3-DEG's configuration is realisable locally under Condition 5 with every curvature strictly inside `(−1, 1)`, together with `v`'s
  whole ring (nine pieces, `W = 3`): fragments `WC` (double horn, a trichromatic vertex of degree 4) and `WC1` (single horn, degree 3), ACCEPT,
  tight; `WCEQ` realises the equality `κ = ±μ` with contact arcs — [tools, exact, for the members], §11.3.
- **Y4-TIP** — a cone vertex loses its cone to a one-tile recolouring of a horn tip into `v`'s essential colour on either side unless that colour
  reaches a zero-width window at the opposite contact (`R_y` at `N` for the colour `y` on `S′`'s side; `R_x` at `S′`); recolouring into a colour of
  `v`'s ring is always blocked — [hand, one mind; checked on named fragments], §11.4.
- **Y4-HARD** — tip-hard cones exist locally: fragments `WCH` (cusps of `y`, `x` at `N`, `S′`) and `WC1H` (`N`, `S′` ordinary trivalent vertices
  `{1,3,4}`, `{1,2,5}`; only `v` degenerate) ACCEPT, tight, and every tip recolouring REJECTs for the derived reason — [tools, exact; derivation
  hand, one mind], §11.4.
- **Y4-D2** — at a tip-hard cone the two antipodal contacts `N`, `S′` never have the same closure type (`y ∈ P_cl(N) ∖ P_cl(S′)`); so G-CONE is
  never an instance of the same-multicolour `d = 2` configuration G-d2 — [hand, one mind], §11.5.

### Fence log (FS110-Y4)

- **Touch 1 (11:3x UTC, disclosed):** my first command, `ls data/fs110/briefs/ data/fs110/reports/`, listed the file names in both directories (the
  other briefs' and reports' names; no content opened).
- **Touch 2 (11:3x UTC, disclosed):** an `ls` of the harness scratchpad's root (to create my subdirectory) listed the names of files I did not create

## The fragments' formulas, verbatim from the side's §11.3 and §11.4

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


# FS110-YB4 — blind verification of the construction side's round 4 (FS110-Y4), the `d = 2` seam

*Job FS110-YB4, blind verifier (Opus 5.5), 2026-09-27. Brief: `data/fs110/briefs/YB110-verify-construction.md` with its instance block
`data/fs110/briefs/YB4-110-instance.md` and `data/fs110/briefs/STANDING-RULES.md`. Scope: the section "§ Continuation — FS110-Y4" of
`plans/FS110-Y-construction.md`, whose theorem list and fragment formulas (§11.3, §11.4) the instance quotes. Working files:
`data/fs110/fs110-yb4/`; tools `tools/fs110_yb4_*.py`; scratch `scratchpad/fs110-yb4/`.*

## Theorems this phase proved

- **YB4-MU** — Y4-MU re-derived blind (unit offset: `μ = λ/(1+λ)`, `λ > −1`), and discriminated exactly (`κ₂ = 3/10` ACCEPT, `9/25` REJECT at
  `μ = 1/3`) — [hand + tools exact; two minds with the side's, this one blind] — Stage 2 §2.3.
- **YB4-MEMBERS** — WC, WC1, WCEQ, WCH, WC1H, rebuilt from the formulas (completions stated), ACCEPT with 4, 2, 4 (arcs), 8, 4 exact tight
  pairs; every tip recolouring and every side plant gives the side's verdict at the side's pair — [tools, exact, my checker] — §2.2.
- **YB4-WINDOW** — `R_y = [−T²/6, T²/2)` at `κ = ±1/2`: both ends confirmed on four exact members; a window colour above `R_y` leaves the
  tip recolouring legal — [hand + tools exact; blind] — §2.2, §2.3.
- **YB4-TIP** — Y4-TIP re-derived blind at second order; precision: a double-horn cone needs one recolouring per horn — [hand, two minds, this
  one blind] — §2.3.
- **YB4-D2** — at any Woodall cone `y ∉ P_cl(S′)`, `x ∉ P_cl(N)`; so tip-hard ⇒ `P_cl(N) ≠ P_cl(S′)`, and `P_cl(N) = P_cl(S′)` ⇒ both windows
  empty — [hand, two minds with the side's, this one blind] — §2.3.
- **YB4-WC-WORDING** — Y4-WC's "every curvature strictly inside `(−1, 1)`" is false literally (`N1`'s arc: 2; the ring: `10/9`); true for
  the horn-bounding curvatures — [hand, exact] — §2.3.

## Fence log

- **Touch 1 (12:1x UTC, disclosed).** To learn why `data/fs110/claims.md` had changed on disk after my start, I ran
  `git log --oneline -3 -- data/fs110/claims.md`, which printed three commit subjects of the owner's claim-list commits, one of them
  ("FS-110: claims 8 second update") after my start-up snapshot. `git log` beyond the snapshot is fenced; no other commit subject or
  content was seen. The file itself is my reading, and I read its second update to §8.
- **Permitted read (disclosed).** To check the instance's quotation of the side's §11.3–§11.4 (standing rule 5), a script located the headings
  `### 11.3` and `### 11.4` in `plans/FS110-Y-construction.md`, extracted the text from `### 11.3` to the next heading after `### 11.4`, and
  printed only line counts and a diff against the instance (43 content lines each, **zero differing lines**). Nothing else of the record was
  displayed.

## Would have searched here

- Scanning the horn curvatures `κ₂` against `μ` to locate the threshold numerically: instead derived `μ = λ/(1+λ)` (offset curve) and
  checked two exact members on either side of `μ = 1/3` (`κ₂ = 3/10`, `9/25`).
- Scanning the window colour's position at `N` to find where the tip recolouring becomes legal: instead derived `R_y` and checked four
  exact members placed inside, below and above it.
- Varying the free completion parameters (cap radius, horn length, sector radius, `t₀`) over a grid: instead two fixed alternative
  settings each, stated in advance (`tools/fs110_yb4_run.py` `robust`).

## Stage 1 — SAVED

### 1.1 Quotations checked (standing rule 5)

| quotation | source | result |
|---|---|---|
| Kooshi, "From here on out, you may doubt your ability …" (standing rule 0) | `CLAUDE.md` § Counter-priors | verbatim |
| Kooshi, "to eliminate the crutch of feeling like we're accomplishing something by …" (rule 3) | `CLAUDE.md` § Toolchain | verbatim |
| Kooshi, "search for a finite graph is out. It would be huge, not feasible." (rule 3) | `CLAUDE.md` | verbatim |
| Kooshi, "A proven theorem about why its impossible is also valid. All novel knowledge is a success." (rule 4) | `CLAUDE.md` | verbatim |
| the side's §11.3 and §11.4, quoted in the instance | `plans/FS110-Y-construction.md` §11.3–§11.4 | verbatim (script diff, 0 lines) |
| the side's theorem list (Y4-MU … Y4-D2), quoted in the instance | the record's "Theorems this phase proved" | **fenced until stage 3**; checked there |
| N3-DEG, N3-RED (claims §8) | `plans/FS110-N-proof.md` | **fenced** (the other side's record); not checked by me — noted |

### 1.2 The statements against the claim list's definitions

- **Types.** Y4-D2 names its type ("`y ∈ P_cl(N) ∖ P_cl(S′)`": closure types, `data/fs110/claims.md` §0). Y4-WC names v's types in the formula
  ("closure type `{1,2,3}`, essential `{2,3}`"), matching §0's `P_cl`/`P_ess` (they differ at the cusp horns, as D-TYPE says they should).
  Y4-HARD's "`{1,3,4}`, `{1,2,5}`" at `N`, `S′` are closure types (read so below). Y4-MU and Y4-TIP use no type.
- **`𝓜_K`.** Every fragment is a local fragment of finitely many circular and straight arcs with radii `≥ 1/10`; the claims are local
  (Y4-HARD: "exist locally"), so `𝓜_K`'s periodicity and tile-count bounds do not apply and are not claimed. Consistent with W-4's YES clause
  ("a local fragment realising one … is a local realisation, not a map").
- **Condition 5** (claims §1, verbatim: "If any boundary intersects with a circle of unit radius at a finite set of points, we say that arcs of
  unit curvature are forbidden"): every arc radius in the formulas is `2, 3, 4, 1/2, 9/10, 11/10` or the unspecified cap radii I choose
  (`1/10`, `1/20`); none is 1.
- **Covering pairs, `d = 2`.** G-CONE and G-d2 are defined in claims §8 (verbatim, A5-5.4). N3-DEG's "Woodall's cone" and "out-type contact"
  are defined only in the fenced `plans/FS110-N-proof.md`; I work from N3-DEG's quoted statement and define "out-type `c`-contact at `N`"
  below, before first use.
- **Terms I define before use** (none is in the claim list): *out-type `c`-contact at `N = v + n`*: a `c`-tile `T_N` with `N ∈ cl T_N`, lying on
  the far side of the tangent line to `ω(v)` at `N` near `N`, i.e. `T_N ⊆ {(X, 1 + Y) : Y > b(X)}` locally with `b(0) = b′(0) = 0` in
  coordinates `v = 0`, `n = (0, 1)`, `a = (1, 0)`; its curvature `λ = b″(0)` (positive when the boundary bends away from `v`). A *`c`-horn at
  `v` along `+a`*: a `c`-tile `{(t, y) : 0 < t < t₁, κ₁t²/2 + O(t³) < y < κ₂t²/2 + O(t³)}`.

### 1.3 Each statement in my own words

- **Y4-MU.** A `c`-tile touching `ω(v)` from outside at `N = v + n` with boundary curvature `λ > −1` at `N` forbids colour `c` at the points
  `v + (t, y)` with `y > μt²/2` (to second order), `μ = λ/(1 + λ)`, and forbids nothing below; the same at `S′ = v − n` mirrored. Hence
  cusp horns of colour `c` at `v` along `±a` with bounding curvatures `κ₁ < κ₂` need `κ₂ ≤ μ_N` and `κ₁ ≥ −μ_S`, each side of `v` separately,
  equality undecided at second order.
- **Y4-WC.** Five fragments (WC double horn, degree 4; WC1 single horn, degree 3; WCEQ at the equality `κ = ±μ`) each pass the exact
  same-colour check, each pair of same-colour tiles (a tile with itself included) having `1` outside the interior of its distance range, with
  some contacts at exactly 1; `v`'s ring of nine pieces winds `W = 3`.
- **Y4-TIP.** At a cone, recolouring one horn's tip `Θ = h₊ ∩ B(v, t₀)` into `j` is legal for all small `t₀` unless: `j` is a ring colour
  (always illegal); `j = x` and `x` has interior points accumulating at `S′` inside `R_x`; `j = y` and `y` has interior points accumulating
  at `N` inside `R_y` (the windows as quoted).
- **Y4-HARD.** Fragments WCH and WC1H pass the exact check, and every recolouring of the tip into 2, 3 (and 4 in WC1H) fails it, at the pairs
  named, because the recoloured tip meets the window colour at exactly distance 1.
- **Y4-D2.** At a tip-hard cone, `y` is in `N`'s closure type and not in `S′`'s, so `N` and `S′` (the only antipodal pair G-CONE supplies)
  never have equal closure types; hence G-CONE is not an instance of G-d2.

### 1.4 Registered expectations (before any derivation; both outcomes reachable)

| claim | expected | what the other outcome would look like (reachable) |
|---|---|---|
| Y4-MU | TRUE at second order | a constant other than `λ/(1+λ)` (e.g. `λ/(2(1+λ))`); decidable at WC's numbers: `wc_flat` (`μ = 1/3 < κ₂ = 1/2`) must REJECT and WC (`μ = 2/3`) ACCEPT |
| Y4-WC | members ACCEPT, tight; a wording precision likely ("every curvature strictly inside `(−1, 1)`" read literally is false for `λ = 2` and the ring radii `9/10`) | a same-colour pair with 1 interior to its range (a lost pair would hide it: I enumerate pairs from the colour map and assert the counts 30, 26, 30) |
| Y4-TIP | TRUE locally, with a scope precision (at a double-horn cone one tip recolouring leaves the other horn) | a tip recolouring legal although the window colour is present, or illegal although absent |
| Y4-HARD | WCH, WC1H ACCEPT; each tip recolouring REJECT at the named pair | a tip recolouring that ACCEPTs, or a REJECT at a pair other than the one named (a wrong reason) |
| Y4-D2 | TRUE for closure types; a scope note if G-d2 reads essential types | a tip-hard cone with `P_cl(N) = P_cl(S′)` |

Probability that at least one of the five carries a divergence of truth or scope: 0.6 (an instrument for G21, scored at stage 4).

## Stage 2 — SAVED

### 2.1 My checker (built before looking at the side's; `tools/fs110_yb4_check.py`)

- **The rule** (claims §4 test 6, exactly): for each pair of same-colour tiles, a tile with itself included, the exact range `[m, M]` of
  cross-distances over the closures must have `m ≥ 1` or `M ≤ 1` (a tile with itself: `M ≤ 1`). For open connected tiles the distances
  between interior points form the open interval `(m, M)`, so this is A-EXACT exactly, and it is the Siamese-or-`≥ 1` rule.
- **How `m`, `M` are found.** They are attained at critical pairs of the distance on the product of the boundaries, or at a common point.
  The checker enumerates all of them: endpoint–endpoint; endpoint–piece (the foot on a segment; the two radial points on an arc);
  arc–arc on the line of centres (concentric arcs: the radial pairs, `|R₁ − R₂|` and `R₁ + R₂`); arc–segment along the segment's normal
  through the centre; and piece–piece intersections (distance 0). Every candidate is a genuine pair of closure points, so the minimum and
  maximum over the candidates are `m` and `M` exactly.
- **Arithmetic.** Exact in `ℚ` or in one field `ℚ(√d)` (Fractions); otherwise a rigorous 60-digit interval. A comparison with 1 is exact,
  or decided by interval separation, or reported AMBIG (none occurred: `amb_cmp = 0` in every run). Equality with 1 is asserted only
  exactly; every tight contact found is exact (rational or in `ℚ(√d)`).
- **One instrument defect, found and repaired before any verdict was read.** An arc-membership test left undecided by the interval
  arithmetic was first treated as "the candidate is an arc endpoint"; a probe showed some undecided cases 4.27 (in squared distance) from
  both endpoints: exact collinearities (a candidate exactly antipodal to an arc's start) computed through intervals. Repaired: such a case
  is decided by 60-digit angles when it is at least `10⁻³⁰` (in angle) from both endpoints (139 cases in the full run), and only otherwise
  identified with the endpoint (1,450 cases, every one at angle gap below `10⁻³⁰`). This defect could only drop candidates, i.e. it
  biased toward ACCEPT (G21's direction); after the repair all verdicts were unchanged.
- **Controls** (all PASS, `data/fs110/fs110-yb4/run.out`): the tight hexagonal seven-colouring (side `1/2`, colours `(m + 3n) mod 7`, 49
  hexagons, exact in `ℚ(√3)`) ACCEPTs with every self-pair tight at diameter exactly 1 and class density `1/7 ≤ 0.2470`; known REJECTs:
  side `51/100` (diameter), colours `(m + n) mod 7` (same-colour neighbours), two discs of radius `1/4` at distance `149/100`, two
  crossing bars; tight ACCEPT: the discs at `3/2`.
- **Planted faults in my checker, each seen to fire for its own reason:** `no_self` (the diameter REJECT turns ACCEPT); `no_arc_arc`
  (the disc REJECT, whose minimum is interior to both arcs, turns ACCEPT); `no_vertex_arc` (a vertex at distance `0.99` from an arc's
  interior: REJECT turns OK); `no_intersect` (crossing bars: REJECT turns OK); `closed_interval` (REJECTs exactly the tight cross pairs:
  4 in WC, 8 in WCH, 4 in WC1H, 4 in WCEQ — tightness certified). A first control for `no_vertex_arc` (the side's `wc_flat`) could not
  fire: its horn endpoint is also within `1` of the contact tile's cap corner (`d² = 0.9999969`), so the pair REJECTs through an
  endpoint pair too — noted, and replaced by a control where only the vertex–arc candidate is below 1.
- **Float guard on my construction** (`tools/fs110_yb4_sample.py`, predicates written independently of the boundary pieces): WCH and
  WC1H have no overlaps and no gaps on 200,000 samples in each of the discs of radius `0.05` about `v`, `N`, `S′` and 400,000 in the band
  `0.93 ≤ r ≤ 1.07`; every same-colour pair's sampled distances lie inside the exact `[m, M]`, within `0.022` of its ends.

### 2.2 The fragments rebuilt from the formulas alone

`tools/fs110_yb4_fragments.py`. Coordinates `v = 0`, `a = (1, 0)`, `n = (0, 1)`, `N = (0, 1)`, `S′ = (0, −1)`, box `[−1/10, 1/10]²`,
ring `9/10 ≤ r ≤ 11/10` cut at `2 atan t` (exact rational directions, e.g. `t = 4/7` gives `(33/65, 56/65)`), colours `6,5,4,6,5,4,6,5,4`
counter-clockwise from the piece about `0°`.

**What the formulas leave open, and my choices** (each varied once more in the robustness pass; no verdict moved):
1. **The contact tiles' extent.** "colour-1 tile above the arc of radius `1/2` about `(0, 3/2)`" does not bound the tile. The whole disc
   cut by the band reaches angle `103.4°`, past the piece about `90°` (which is `(59.49°, 100.39°)`, not centred on `90°`), so "wraps"
   fails for it. I cut it by `B(N, 1/10)` (angles `90° ± 5.8°`); variant `1/20`.
2. **WCH's horn length**: `|T| < 1/20`; variants `1/40`, `1/10`.
3. **WC1H's sector radius**: `1/20`; variants `1/10`, `1/40`.
4. **The tip radius**: `t₀ = 1/20, 1/100` (and `1/1000` in the robustness pass).
5. **`wc1h_ylow`**: I read "turned to reach `−30°`" as the colour-3 sector rotated to `(−30°, 30°)`, the ring piece filling `(30°, 60°)`.

**Results** (all exact; pairs enumerated from the colour map, counts asserted):

| fragment | pairs (asserted) | verdict | tight contacts (exact) |
|---|---|---|---|
| WC | 30 | **ACCEPT** | 4: `(h±, N1)` at `(v, N)`, `(h±, S1)` at `(v, S′)` |
| WC1 | 26 | **ACCEPT** | 2 |
| WCEQ | 30 | **ACCEPT** | 4 pairs, each along a contact arc (concentric radii 3, 2: every radial pair at exactly 1, e.g. the horn's end `(1/10, 3 − √899/10)` at exactly 1 from `N1`) |
| WCH | 40 | **ACCEPT** | 8: the 4 of WC and `(v3, yN±)` at `(v, N)`, `(v2, xS±)` at `(v, S′)` |
| WC1H | 30 | **ACCEPT** | 4: `(h+, N1)`, `(h+, S1)`, `(v3, yN)`, `(v2, xS)` |

**Tip recolourings**, `Θ = h ∩ B(v, t₀)` made a tile of colour `j`, the rest of the horn kept colour 1:

| fragment | tip → 2 | tip → 3 | tip → 4 |
|---|---|---|---|
| WC (`h+` and `h−`) | ACCEPT | ACCEPT | REJECT at `r2`, `r5`, `r8` (the three colour-4 ring pieces) |
| WCH (`h+`; `h−` mirrored) | REJECT at `(xS+, tip)` only (`xS−` for `h−`) | REJECT at `(yN+, tip)` only (`yN−`) | REJECT at `r2, r5, r8` |
| WC1H | REJECT at `(xS, tip)` only | REJECT at `(yN, tip)` only | REJECT at `r2, r5, r8` |

**The side's plants, rebuilt:** `wc_flat` REJECTs at exactly the four horn–contact pairs, minimum `√0.9983328 = 0.99917` at the horn's end
against `N1`'s arc (the side's number); `wc_fat` at `(h+, N1)` only; `wc_col2` at `(v2, r2)` only; `eq_steep` at `(h±, N1)` only (the `N`
side); WCEQ's first build (WC's lower arc against `μ_S = 1/3`) at `(h±, S1)` only; `wch_ywide` at `(v3, yN±)` and `(v2, xS±)`;
`wc1h_ylow` at `(v3, yN)` and `(v2, xS)`. Every one for the reason the side gives.

**My own sharp tests (not the side's):**
- *`μ = λ/(1 + λ)`*: with a contact of curvature `λ = 1/2` (`μ = 1/3`), horns with `κ₂ = 3/10` ACCEPT and with `κ₂ = 9/25` REJECT on the `N`
  side only. This separates `λ/(1+λ)` from `λ/2` (which would reject `3/10`) and from `λ` (which would accept `9/25`). A contact of
  curvature `λ = −1/2` (`μ = −1`) REJECTs WC's horns on the `N` side.
- *`R_y = [−T²/6, T²/2)` at WC's `κ = ±1/2`*: a colour-3 double horn at `N` spanning `Y ∈ (−3/20, 1/4)·T²` ACCEPTs and makes tip → 3
  REJECT; spanning `(−9/50, 1/4)·T²` (below `−1/6`) the fragment itself REJECTs at `(v3, yN±)`; spanning `(3/5, 4/5)·T²` (above `R_y`,
  below `N1`'s `T²`) the fragment ACCEPTs and **tip → 3 ACCEPTs** (the cone is soft on that side although `y ∈ P_cl(N)`); spanning
  `(2/5, 4/5)·T²` (meeting `R_y`'s top) tip → 3 REJECTs. Both ends of the window are where Y4-TIP puts them, at `t₀ = 1/20` and `1/200`.

### 2.3 Hand derivations and verdicts (before opening the side's record)

**Y4-MU — TRUE** at second order [hand; my derivation, the side's one mind: two minds, this one blind; tools exact on members].
The set of points `q` whose unit circle meets `T_N` near `N` is bounded by the inner unit offset of `∂T_N`. An offset at distance `d` of a
curve of curvature `λ` (bending away from the side offset to) has curvature `λ/(1 + dλ)`; at `d = 1` this is `μ = λ/(1 + λ)`, finite iff
`λ > −1`. Directly: `ω(v + (t, y))` near `N` is `(t + s, 1 + y − s²/2 + O(s⁴))`, and `T_N = {Y > λX²/2 + O(X³)}`, so `ω(q)` enters `T_N` iff
`y > min_s [s² + λ(t + s)²]/2 = λt²/(2(1+λ))` (minimum at `s = −λt/(1+λ)`, valid iff `1 + λ > 0`; for `λ ≤ −1` every `q` is hit). By A-EXACT
such `q` are not `c`. Mirrored at `S′`. So `κ₂ ≤ μ_N`, `κ₁ ≥ −μ_S`, equality at the next order. **Precision:** "`λ = ∞` at a corner" is
per side of `v`: in WC1H the corner's ray at `60°` gives `μ = 1` for `t > 0`, while its ray along `180°` (tangent to `a`) gives `λ = 0`,
`μ = 0` for `t < 0` — which is why WC1H has one horn. The statement's "one-sided, per side of `v`" covers this.

**Y4-WC — TRUE for the members; MISSTATED in one phrase** [tools, exact, my checker; the formulas completed as in 2.2]. All three
ACCEPT, tight; `W = 3` (the nine ring changes are all `−1` in `ℤ/3`, `W = −9/3`); `N-E0` holds (pieces `39.5°–41°` wide, so
`θ, θ + 60°` lie one or two pieces apart); no arc of radius 1. **The phrase "with every curvature strictly inside `(−1, 1)`" is false
read literally**: `N1`'s arc has curvature `2`, WCEQ's contact arcs `1/2` are fine but the ring's inner arc has curvature `10/9`.
Corrected statement: "with every horn-bounding curvature strictly inside `(−1, 1)`" (`±1/2`; `±1/3` in WCEQ) — which is N3-DEG's
condition. Also: the contact tiles are not bounded by the formula (choice 1 above); the verdict does not depend on the choice made.

**Y4-TIP — TRUE at second order, with one precision** [hand, two minds, this one blind; tools exact on eight members].
- *Ring colour:* `Θ ⊕ S¹` contains, for each point `z` of `ω(v)` at angle `θ` with `cos θ ≠ 0`, interior pairs at distance below and
  above 1 (`|z − (t, 0)|² = 1 − 2t cos θ + t²`, and `z` moved off `ω(v)`), so every ring tile with interior on `ω(v)` off `±n` is at
  distance exactly 1 from `Θ`: blocked.
- *`j = x`:* off `±n`, `ω(q)` crosses the horn transversally near `v` and meets `x`'s sector, so no `x` there; near `N`, `ω(p)` meets `v`'s
  `x`-sector for every `p` (the condition `Y + s²/2 > κ₂(T+s)²/2` holds for large `s` since `κ₂ < 1`), so no `x` at `N`; at `S′`, `x` is
  allowed exactly where `Y ≤ κ₂T²/(2(1+κ₂))` (A-EXACT against `v`'s `x`-sector, minimising `s² + κ₂(T+s)²`), and the tip's circles
  sweep exactly `Y > min_{0<t<t₀}[κ₁t² + (T−t)²]/2 = κ₁T²/(2(1+κ₁))` (minimiser `t = T/(1+κ₁)`, inside `(0, t₀)` iff
  `0 < T < (1+κ₁)t₀`; for `T < 0` the sweep starts at `T²/2`, above the allowed region). So blocked for every `t₀` iff `x`-interior
  accumulates at `S′` inside `R_x`, as stated.
- *`j = y`:* the mirror: `y` allowed at `N` iff `Y ≥ κ₁T²/(2(1−κ₁))` (maximising `κ₁(T+s)² − s²`), swept iff `Y < κ₂T²/(2(1−κ₂))`
  (minimiser `t = T/(1−κ₂)`). My four `R_y` members confirm both ends exactly.
- *Consistency bullet:* correct (`R_y`'s top is below the contact iff `λ ≥ κ₂/(1−κ₂)`, which is `μ_N ≥ κ₂`; above `ω(v)` always).
- **Precision (scope):** at a double-horn cone (WC, WCH) one tip recolouring removes one horn; `v` keeps the other and is still a Woodall
  cone (N3-DEG: "every `c`-sector at `v` is a cusp horn along `±a`" — one sector qualifies). The cone is lost only when every horn's tip
  is recoloured: two one-tile moves, each legal under the same window test on its own side (`T < 0` for `h−`). "loses its cone to a
  one-tile recolouring" is literally true for single-horn cones only. Blocking is unaffected (a blocked tip on either side keeps the cone).

**Y4-HARD — TRUE** [tools, exact; the reason derived by hand and confirmed by my window members]. WCH and WC1H ACCEPT, tight; every tip
recolouring REJECTs at exactly the pair the side names, and the REJECT is caused by the window colour: moving the `y`-horn out of `R_y`
(above it) makes tip → 3 legal, inside it REJECTs. `N`, `S′` in WC1H are ordinary trivalent vertices with sectors `120°, 60°, 180°`, closure =
essential types `{1,3,4}`, `{1,2,5}`; only `v` is degenerate. In WCH, `N`'s closure type `{1,3,4}` differs from its essential type
`{1,4}` (the `y`-cusp), so `N` is itself a cusp vertex; WC1H is the member that avoids this, as the side says.

**Y4-D2 — TRUE for closure types, with a scope note** [hand; my derivation, the side's one mind: two minds, this one blind].
At **any** cone (tip-hard or not), `y ∉ P_cl(S′)`: every `p` near `S′` has `ω(p)` through `v`'s `y`-sector (the condition
`Y − s²/2 < κ₁(T+s)²/2` holds for large `s` since `κ₁ > −1`), so a `y`-tile with `S′` in its closure violates A-EXACT; likewise
`x ∉ P_cl(N)`. A tip-hard cone has `y`-interior accumulating at `N` (so `y ∈ P_cl(N)`, which needs `x ≠ y`) and `x` at `S′`. Hence
`y ∈ P_cl(N) ∖ P_cl(S′)`. Stronger, and worth recording: **at any cone, `P_cl(N) = P_cl(S′)` forces both windows empty**, so the cone
is soft (both tips recolour legally into `y` or `x`, given the window test). **Scope notes:** (i) the "so" clause concerns the pair
`(N, S′)` and tip-hard cones; whether N3-RED's "hard" is tip-hard I cannot check (its definition is in the fenced N-side record);
(ii) read with **essential** types the conclusion can fail: `y` sits in a zero-angle window at `N`, so `P_ess(N) = {1, r_N}` and
`P_ess(S′) = {1, r_S}`, equal when the ring has one colour at `±n`; nothing forbids that locally. Moot if G-d2 reads closure types, and
moot altogether given claims §8's second update (G-d2 does not arise; two blind minds).

## Stage 3 — SAVED (verdicts committed before opening the side's record, tools and directory)

| claim | my verdict | grade, minds |
|---|---|---|
| Y4-MU | **TRUE** (second order; "`λ = ∞` at a corner" is per side) | [hand + tools exact]; two minds, this one blind |
| Y4-WC | **TRUE for the members; MISSTATED phrase** ("every curvature strictly inside `(−1, 1)`" → "every horn-bounding curvature …"); the contact tiles' extent is not fixed by the formula | [tools, exact, my checker] |
| Y4-TIP | **TRUE** at second order; **precision**: at a double-horn cone the cone is lost only after one recolouring per horn | [hand]; two minds, this one blind |
| Y4-HARD | **TRUE** (members ACCEPT; every tip recolouring REJECTs at the named pair, for the window reason, confirmed by moving the window colour out of `R_y`) | [tools, exact; reason hand]; blind |
| Y4-D2 | **TRUE for closure types**; scope: tip-hard cones and the pair `(N, S′)`; fails for essential types if the ring has one colour at `±n` (moot: G-d2 does not arise) | [hand]; two minds, this one blind |

Registered expectation scored: I gave 0.6 to "at least one divergence of truth or scope"; found: one misstated phrase and two scope
precisions, no divergence of truth before reading the side.

## Stage 4 — SAVED (after opening the side's record §§ Continuation — FS110-Y4, `tools/fs110_y_cone.py` in part, `y4_cone_none.out` in part)

Read after stage 3 (`1664a5ef`): the side's § Continuation — FS110-Y4 in full (lines 668–861), `tools/fs110_y_cone.py`'s header and its
`n_tile` and `build_trivalent_hard`, and the WC block of `data/fs110/fs110-y/y4_cone_none.out`. The side's theorem list in the instance is
verbatim against the record's "Theorems this phase proved (FS110-Y4)" (read line by line).

### 4.1 Divergences of truth

**None.** Every verdict the side claims holds on my independent rebuild and checker, and every hand statement re-derives. Where both of us
computed the same number, it agrees: the ring pieces' exact ranges to six decimals (e.g. `(r0, r3)` `[1.161499, 2.166743]`, `(r2, r2)` max
`0.768641`), `wc_flat`'s minimum `0.99917`.

### 4.2 Divergences of scope and wording (item by item)

| # | where | the side | mine | proposed edit (the close writes it) |
|---|---|---|---|---|
| S1 | Y4-WC's theorem line (also the pre-round answer) | "with every curvature strictly inside `(−1, 1)`" | false literally: `N1`'s arc has curvature 2, the ring's inner arc `10/9`; true for the horns' bounding curvatures | "with every horn-bounding curvature strictly inside `(−1, 1)`" |
| S2 | Y4-TIP's line; §11.5 held item ("fragment `WC` is a cone that one tile's recolouring removes") | one tip recolouring removes the cone | at a double-horn cone (WC, WCH) one tip recolouring leaves the other horn, and `v` is still a Woodall cone (single horn, as WC1); I checked `h−`'s tip separately (WC tip(`h−`) → 2 ACCEPT; WCH's `h−` tips REJECT at `xS−`, `yN−`) | "loses each horn to a one-tile recolouring of its tip … (a double-horn cone needs one per horn)"; §11.5: "two tiles' recolourings, one per horn" |
| S3 | §11.2's definition of `λ = ∞` | "a corner of `τ` at `N` with both rays strictly above the tangent line counts as `λ = ∞`" | WC1H's corner has its `180°` ray **on** the tangent line; the side's `μ = 1` there is right on `h+`'s side only (the `60°` ray), with `μ = 0` on the other side, which is why WC1H has one horn | "per side: a boundary ray of `τ` leaving `N` strictly above the tangent line on that side counts as `λ = ∞`" |
| S4 | Y4-WC / Y4-HARD formulas | the contact tiles' extent away from `N`, `S′` is not in the formula ("the arc of radius `1/2` about `(0, 3/2)`" bounds the tile below only) | a completion is needed; the whole disc cut by the band does not fit inside the piece about `90°` (`(59.49°, 100.39°)`) | add the side's completion to the formula (its tool: the arc from `(−10/101, 102/101)` to `(10/101, 102/101)`, then vertical sides to `y = TOP`); verdicts do not depend on it (mine: the disc cut by `B(N, 1/10)` or `B(N, 1/20)`) |
| S5 | Y4-D2's "so" clause | "G-CONE is never an instance of G-d2" | TRUE for closure types at tip-hard cones and the pair `(N, S′)`; with essential types it can fail when the ring has one colour at `±n` (`P_ess(N) = {1, r_N}`, `P_ess(S′) = {1, r_S}`); and whether N3-RED's "hard" is tip-hard is open (the side holds the same question for the owner) | add "(closure types; the pair `N`, `S′`; tip-hard cones)"; moot given claims §8's second update |

### 4.3 Divergences of route

- **Y4-MU:** the side proves sufficiency by the triangle inequality with the osculating disc and necessity by the parallel curve; I used the
  offset-curve curvature and a direct minimisation over the circle's parameter. Same constant, same domain `λ > −1`.
- **Y4-D2:** the side reads `x ∉ P_cl(N)`, `y ∉ P_cl(S′)` from A-CIRC at `N`, `S′` (`ω(N)` near `v` lies in `x`); I read them from A-EXACT
  at points near `S′` against `v`'s `y`-sector. Equivalent.
- **Completions:** the side's contact tiles are boxes above the arc; mine discs cut by a small disc. The side's WC1H sectors are polygons cut
  by the box `[−1/10, 1/10] × [1, 11/10]`; mine circular sectors. The side's `wc1h_ylow` turns only the lower ray to `−30°` (sector
  `(−30°, 60°)`); I rotated the sector to `(−30°, 30°)`. Same verdicts, same reject pairs.
- **What I add that the side did not test:** the windows' ends. The side's plants test each window from one side only (`wch_ywide`: below
  `R_y`). My members test both ends: a `y`-cusp at `N` spanning `(3/5, 4/5)·T²` — above `R_y`, below the contact — leaves the fragment ACCEPT
  **and the tip recolouring into `y` legal**, so `y ∈ P_cl(N)` does not by itself make a cone tip-hard; the window's position does. And the
  `μ` discrimination (`κ₂ = 3/10` ACCEPT, `9/25` REJECT at `μ = 1/3`), which a plant at WC's own numbers (`μ = 2/3` against `κ₂ = 1/2`) cannot
  separate from `μ = λ/2` or `μ = λ`.

### 4.4 Proposed edits for the close

- Grades: Y4-MU, Y4-TIP, Y4-D2 → **[hand], two minds, one blind** (FS110-Y4; FS110-YB4). Y4-WC, Y4-HARD → **[tools, exact], two independent
  checkers** (the side's; `tools/fs110_yb4_check.py`), the reason for each tip REJECT confirmed blind by moving the window colour.
- Wording: S1, S2, S3, S5 above; S4 the completion.
- A new line for the claim list or the ledger (the close decides): **YB4-WINDOW** — "at WC's curvatures `κ = ±1/2`, a `y`-cusp at `N` inside
  `R_y = [−T²/6, T²/2)` blocks the tip recolouring into `y`, and one above `R_y` (below the contact `Y = λT²/2`) does not; below `−T²/6` it
  violates A-EXACT" — [hand + tools exact, one mind (blind)].
- **Tool defect (mine, repaired before any verdict was read):** an undecided arc-membership test was taken as "at an endpoint"; some were exact
  collinearities far from the endpoints. Its bias was toward ACCEPT; repaired in `tools/fs110_yb4_check.py` (`_member`), verdicts unchanged.

### 4.5 Registered expectations, scored

| claim | expected | found |
|---|---|---|
| Y4-MU | TRUE | TRUE (+ S3's per-side precision) |
| Y4-WC | members ACCEPT; a wording precision likely | as expected (S1), plus S4 |
| Y4-TIP | TRUE with the double-horn precision | as expected (S2) |
| Y4-HARD | ACCEPT; REJECT at the named pairs | as expected |
| Y4-D2 | TRUE for closure types; an essential-type note | as expected (S5) |

The 0.6 on "at least one divergence of truth or scope": scope divergences found (five), truth none. My blind expectations matched every
outcome, which says the claims were stated close to what the objects show; it also says the discriminating tests that mattered were the
ones I added (4.3), not the expectations.

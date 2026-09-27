*Instance block for job **FS110-YB** (brief `data/fs110/briefs/YB110-verify-construction.md`). This file is part of your brief and is not fenced.
Filled in by the product owner on 2026-09-27, when the construction side handed back.*

## Scope

- **The side verified:** the construction side, meaning FS110-Y (stages 1–3) and its successor FS110-Y2 (stages 4–6). Where the brief says
  "FS110-Y's record", it means the whole of `plans/FS110-Y-construction.md`, including its section "§ Continuation — FS110-Y2". Its tools
  `tools/fs110_y_*` and its data `data/fs110/fs110-y/` stay fenced until your stage 3 is committed. Build your own exact checker; never use the side's.
- **The side's claimed verdicts on the claims:**
  - C-T2 (i) TRUE at fragment level;
  - C-BOW-K (i) TRUE (the fragments BB and S1);
  - one pair mixes the two seams (MX);
  - C-TAN-POS TRUE at the level of A-EXACT's disjointness;
  - C-T-BIKE a GAP, with the no-go Y-BIKE-3C for one family;
  - C-T2 (ii) and C-BOW-K (ii) GAP;
  - A2-V56 TRUE off the centres of arcs of `Γ`, and a GAP there.
- **Priority order:**
  1. Rebuild the four fragments, **S1, T2, BB and MX**, from the formulas below, and check each with your own checker. Your checker needs its
     planted faults, a known-REJECT control, and the tight hexagonal seven-colouring as an ACCEPT control. Check every same-colour pair, including
     each tile against itself, plus the class densities and the Siamese-or-`≥ 1` rule.
  2. Derive **Y2-W4** and **Y2-W4e**, then **Y2-S1i**.
  3. Then **Y-T2W**, **Y-BLOCK** and **Y-BIKE-3C**.
  4. Then Y2-LAT, which covers one candidate only.

## The side's theorem tables, verbatim

### FS110-Y (stages 1–3)

- **Y-AEX** — A-EXACT TRUE with "meets a tile" read as "meets the interior of a tile" (false for the closure reading exactly at cusps and
  transversal passes through `u`); its consequence, disjointness of `B_u(s)`, `B_v(s)` for a covering pair, TRUE — [hand, one mind here; two with
  FS110-A's], §1.3.
- **Y-CIRC** — A-CIRC TRUE for every colour of `P_cl(u)`, cusp colours included (the argument needs only interior points of the tile accumulating
  at `u`, never an angle) — [hand, one mind here; two with FS110-A's], §1.3.
- **Y-SIX** — A-SIX TRUE: C-T-TAN's proof uses the type sizes only through "all six classes are in `P(u) ∪ P(v)`"; the sizes enter only its
  failure-set analysis, which I redo for sizes 2 and 4 — [read + hand, one mind here; two with FS110-A's], §1.3.
- **Y-TYPE** — D-TYPE TRUE for `𝓜_K` maps (and any locally finite map whose boundary arcs have one-sided tangents at `u`): `P_cl(u) ∖ P_ess(u)` is
  exactly the set of colours all of whose corners at `u` have angle 0 — [hand, one mind, trivial], §1.3.
- **Y-BLOCK** (as corrected at stage 3) — the blocking set `B_u(s) ∩ B(w₀, c)` of an `𝓜_K` vertex takes the shapes: one-sided band of depth
  `≍ s·margin` (generic trivalent), `≍ |1 − κ|s²/2` (T1) or `≍ s·|τ·e_u|` (cusp); a two-sided ball only at vertices of degree `≥ 4` with no
  escape; a thin double wedge of angle `≍ s` about the tangent line of `ω(u)` at `w₀` (T2); empty (escape). Completeness of this list is not
  claimed. Hence C-TAN-POS TRUE at the level of A-EXACT's disjointness test — [hand, one mind], §1.4, §3.
- **Y-CHK** — `tools/fs110_y_check.py`: exact min/max cross-distance for tiles bounded by segments and circular arcs over ℚ(√3), seven controls
  (three curved), four planted faults each firing for its own reason — [tools, exact], §2.2.
- **Y-T2W** — a pair saved at `w₀` by T2 makes `w₀` a vertex of degree `≥ 4` whose branches of `ω(u)`, `ω(v)` alternate, with `P(u)`-colours at
  `w₀` in Siamese contact with `u` (inner arc colour) or outer contact (outer colour) — [hand, one mind], §2.3.
- **Y-BIKE-3C** — no six-arc three-cycle colouring of each circle colours the bicycle, at any `d ∈ (1, 2)` — [hand, one mind], §2.4.

## Fence log (standing rule 13)

### FS110-Y2 (stages 4–6)

- **Y2-W4** — at a common unit point `w` of a covering pair `(u, v)`, `|u − v| ∈ (0, 2)`, with neither `ω(u)` nor `ω(v)` running along a
  boundary into `w`: the four branches carry four distinct colours, two of `P(u)` (one facing `u`, one away) and two of `P(v)`; so
  `|P_cl(w)| ≥ 4`, and every tile-interior point of `ω(w)` near `u` has the one colour `P(u) ∖ P_cl(w)` (near `v` likewise) — [hand, one mind], §4.3.
- **Y2-W4e** — hence the partner of a strong escape at `w` (with no arc of Γ at `w`) must be `ω(w)`-monochromatic at its own vertex (both
  directions of `ω(w)` in tiles of one colour, or along boundaries); and at a (2, 4) covering pair the bichromatic vertex must carry boundaries
  along `ω(w)` in both directions — [hand, one mind], §4.3.
- **Y2-S1** — the owner's (S1) is realisable locally: fragment `S1` (a bowtie centred on two boundary unit arcs through `w`, `w′`; a generic
  trivalent partner; `w`, `w′` two-colour edge points), exact over ℚ(√3), all 18 same-colour pairs ACCEPT, tight — [tools, exact; the family
  claim hand, one mind], §4.5.
- **Y2-S1i** — every realisation of (S1) with `w` an edge point carries: the arc's sides are `u`'s facing and away colours at `w`; `u` is a strong
  escape at `w`; the arc's ends on `ω(u)` are vertices meeting a colour of `P(v)` — [hand, one mind], §4.5.
- **Y2-T2F** — C-T2 (i) TRUE at fragment level: fragment `T2` (the `d = 1` rhombus, `u`, `v` on unit arcs of `ω(w)`, `ω(w′)`; `w`, `w′`
  four-colour), all 24 same-colour pairs ACCEPT, tight — [tools, exact; derivation hand, one mind], stage 5.
- **Y2-BB** — C-BOW-K (i) TRUE in its double form: fragment `BB` (two straight bowties escaping at both unit points, `30°` margins), 30 pairs
  ACCEPT, tight — [tools, exact; hand, one mind], stage 5.
- **Y2-MX** — one pair can mix the seams: fragment `MX` (T2 at `w`, a bowtie's escape at `w′`), 27 pairs ACCEPT, tight — [tools, exact], stage 5.
- **Y2-LAT** — the translation-invariant triangular-lattice extension of `BB` fails at its four-colour points: six covering pairs through one point
  over-constrain it — [hand, one mind; one candidate, not the question], stage 5.
- *Retracted at stage 6:* §4.4's GAP (ii) in the owner's switch-point step (card 3: it holds only in the disjoint sense).

## The fragments' formulas, verbatim from the side's record

### S1 (the record's §4.5)

**Formula** (d = 1; `u = 0`, `v = (1, 0)`, `w = e₆₀`, `w′ = e₃₀₀`; colours `a, b, c = 1, 2, 3`; `e_θ` the unit vector at `θ°`; `ρ = 1/4`;
`t = 1/8`, the arc half-angle `2 arctan t ≈ 14.25°`):
- `u`: bowtie, straight sectors truncated at `ρ`: `a` on `(300°, 60°)` and `(120°, 240°)`; `b` on `(60°, 120°)`; `c` on `(240°, 300°)`. The escape
  lines at `w` (`150°/330°`) and at `w′` (`30°/210°`) lie in the `a`-sectors with margin `30°`.
- `v`: **generic trivalent**, `4` on `(300°, 60°)`, `5` on `(60°, 180°)`, `6` on `(180°, 300°)` (no ray along any tangent that matters).
- `w`: a boundary **arc of `ω(u)`** (centre `u`, radius 1) from `e_{60°−α}` to `e_{60°+α}`, `α = 2 arctan(1/8)`, endpoints in ℚ(√3); inner side
  (toward `u`) colour `b`, outer side colour `c`, each tile closed by two segments to `(9/10)w` resp. `(11/10)w`. `w` is **a two-colour edge
  point**, not a vertex.
- `w′`: the mirror: an arc of `ω(u)` through `w′`, inner `c`, outer `b`.
- Symmetry: the reflection `y ↦ −y` with colour permutation `(2 3)(5 6)`; group of order 2.

**Exact check** (`tools/fs110_y_fragments.py --frag S1`): 11 tiles, all 18 same-colour pairs generated from the colour map (every tile against

### T2, BB and MX (the record's stage 5)

All on the `d = 1` rhombus of §4.5, colours `P(u) = {1, 2, 3}`, `P(v) = {4, 5, 6}`, arcs with half-angle `2 arctan(1/8)`, straight rays at `u, v`
truncated at `1/4`, quadrant squares of side `1/10` at `w, w′`. `R` is the half-turn about `(1/2, 0)` (`u ↔ v`, `w ↔ w′`), with the colour involution
`(1 4)(2 5)(3 6)`. Tool: `tools/fs110_y_fragments.py`; outputs `data/fs110/fs110-y/y2_fragments_*.out`. **Every same-colour pair is generated
from the colour map**, including each tile against itself.

| fragment | formula | symmetry | pairs | verdict | planted faults (each REJECT for its own reason) |
|---|---|---|---|---|---|
| **T2** (C-T2 (i)) | `u` lies on a full arc of `ω(w)` (rays `150°, 330°`: inner `3`; outer `1` on the `150°` half, `2` on the `330°` half) plus a ray along `ω(w′)` at `210°` (inner `2`, outer `1`); `v = R(u)`; `w`: `(0°,90°) 1, (90°,180°) 4, (180°,270°) 3, (270°,360°) 5`; `w′ = R(w)` | `{1, R}` | 24 | **ACCEPT**, tight (8 contacts at exactly 1) | `t2_flip` (swap `1, 3` at `w`: facing colour put away) → `(u_1,w_2)`, `(u_3,w_0)`; `t2_flat` (the arcs of `ω(w)` at `u` replaced by chords: a T1 interface, curvature 0 against 1) → `(u_1, w_0)` range `≈[0.992, 1.372]`; `t2_six` (colour 6 at `w`: `v`'s 6-sector straddles `e_v^⊥`) → `(v_3, w_1)` |
| **BB** (C-BOW-K (i)) | `u`: bowtie `1` on `(300°,60°)` and `(120°,240°)`, `2` on `(60°,120°)`, `3` on `(240°,300°)`, all straight; `v = R(u)`; `w`: `3, 5, 2, 6` by quadrant; `w′ = R(w)` | Klein four: `R` and `y ↦ −y` with `(2 3)(5 6)` | 30 | **ACCEPT**, tight | `bb_rot` (`u`'s bowtie turned `60°`: its repeated colour no longer holds the escape lines) → `(u_b, w_2)`, `(u_c, w_0)` |
| **MX** (the mixed pair) | `u`: bowtie `1` on `(330°,60°)` and `(150°,240°)`, `2` on `(60°,150°)`, `3` on `(240°,330°)`, **lying on a full arc of `ω(w)`** (rays `150°, 330°` exact; `60°, 240°` straight): T2 at `w`, strong escape at `w′`; `v` = T2's `v`; `w`: `3, 4, 2, 5`; `w′`: `6, 3, 4, 2` | none | 27 | **ACCEPT**, tight | (the T2 and BB plants cover its two mechanisms) |

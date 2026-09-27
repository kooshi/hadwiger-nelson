# FS106-SB — blind second mind on FS106-TS's verdicts (Coxeter, verifier)

*Job FS106-SB, 2026-09-27. Brief: `data/fs106/briefs/B106-blind-second.md`; instance sheet `data/fs106/briefs/SB106-instance.md`; standing rules
`data/fs106/briefs/STANDING-RULES.md`. Blind: nothing fenced opened before stage 3 is committed. Papers read first-hand from their text layers
(`pdftotext -layout`): `[SokolovVoronov2025]` (arXiv:2502.01958v1, all 29 pp.), `[Coulson2004]` (J. Aust. Math. Soc. 77, pp. 191–196, all),
`[Voronov2023]` §6 (Lemma 6.1 and its proof, pp. 12–13 of arXiv:2304.10163) only.*

## Theorems this phase proved

*(filled at stage 3)*

## Stage 1 — SAVED

### 1.1 Quotation check (standing rule 5)

| quoted in | text | source | result |
|---|---|---|---|
| sheet item 1 | "No polygonal colouring (D-SV Condition 8) with 6 colours is a.e.-proper (D-AEMAP)." | `data/fs106/claims.md` l. 119 | verbatim ✓ |
| sheet item 2 | "seven colours for locally finite convex tilings, almost everywhere" | said to be at `claims.md` l. 127 | **not there.** l. 127 states no theorem: "the a.e. forms of `[Thomassen1999]`'s nice-map theorem and `[Coulson2004]`'s convex-tiling theorem, stated by the reading job in this list's form … once the printed statements are quoted". The reading job's statement is fenced. **And `[Coulson2004]`'s printed theorem is six, not seven**: Thm 3.5, p. 196, "A tile based colouring with excluded distance D must employ at least 6 colours." So "seven for convex tilings" is not the a.e. form of Coulson's theorem; it is SV-2 restricted to tilings. I verify the sheet's gloss, with my own precise statement (§2.2). |
| sheet item 3 | original wording of C-T-IND | `claims.md` l. 146–148 | the sheet's pointer ✓; the quoted S–V Prop. 12, "If γ1 ∼ γ2 , then \| Ind γ1 − Ind γ2 \| ≤ 1.", matches the text layer (p. 15) ✓. The corrected form is the deriver's; its source is fenced, so it is taken as the sheet gives it. |
| sheet items 4–8 | TS-C, TS-T, TS-U, TS-L1, C5 | the deriver's list (fenced) | cannot be checked against source until stage 4; taken as the sheet gives them. "SV-L4 (a)": `[SokolovVoronov2025]` Lemma 4 (p. 19) has no labelled step (a); I read it as the first sentence of Lemma 4's discussion, p. 20: "It is straightforward to verify that within a distance of at most 1 from any point, there exists a trichromatic point." |
| claims.md D-SV | Conditions 1–8, Definition 2 | S–V pp. 3–4 | verbatim ✓ (symbols as in the text layer) |
| claims.md SV-L1, SV-L4, SV-2, SV-C3 | as quoted | S–V pp. 5, 6, 14, 19 | verbatim ✓ |
| brief | "Given MR, Hadwiger–Nelson is whether a tight, non-closed measurable colouring …" | `CLAUDE.md` § The aim, link 5 | a gloss, not in quotation marks; faithful to link 5 ✓ |

Two defects of the printed S–V text noticed while checking (not quotations of the brief): Theorem 2's proof cites "Lemma 8" (p. 25), which is
Proposition 8 (p. 10); and S–V's appendix (p. 28) speaks of "the union of three regions of colors 1, 2, 3 whose vertex is u", where `u` has
multicolour {4, 5, 6} — the colours are 4, 5, 6 (§2.1, step A11).

### 1.2 Expectations, registered before the derivations were written

Honest timing: registered after reading the three papers and a first pass of thought, before any derivation was written down.

| claim | expectation | confidence | the control |
|---|---|---|---|
| C-AE-POLY | TRUE: S–V's argument is local and uses multicolours; the three places that use a colour at a boundary point (Lemma 1, Prop. 7, Prop. 12 at a swap) can be repaired | medium | point each repaired step at a configuration where the printed step's conclusion is known false without its hypothesis (C5's configuration for Prop. 5) |
| C-AE-CONV | TRUE as a corollary of C-AE-POLY | medium-low: merged tiles need not be polygons in S–V's sense | the tile-to-map conversion checked against Conditions 2–4, 8 one by one |
| C-T-IND (corrected) | mixed: the bound is TRUE given no swap; the "iff" is definition-dependent | medium | an explicit trace with infinitely many changes, lifted by hand |
| TS-C | TRUE | high | a two-region chain touching at a vertex, done by hand |
| TS-T | TRUE | medium-high | the Lebesgue covering theorem's hypothesis checked against diameter ≤ 1 |
| TS-U | TRUE with the wedge made exact (second order) | medium | the sampling check of C5 plants a colour in a side cone and must go red |
| TS-L1 | TRUE, by a countability argument on circles, with local finiteness | medium-high | the argument must fail where local finiteness fails (checked by naming the step) |
| C5 | TRUE: a configuration exists; I expect it to need an extra colour pair in the two side cones at `y` | medium | `tools/fs106_sb_c5_check.py`, with a plant that must fire |

### 1.3 Would have searched here

- C5: would have asked a solver for local colourings of two unit-spaced discs meeting the pair constraints. Instead: constructed by hand
  from the second-order unit-arc analysis, then checked by a seconds-long exact-geometry sampling script (a check of a derived claim, not a search).

## Stage 2 — SAVED

### 2.0 Set-up and two lemmas used throughout

A map-type colouring (Conditions 2–4) that is a.e.-proper (D-AEMAP). `O_j` = the union of the open regions of colour `j`; `B` = boundaries and
vertices; `c(x)` = the multicolour (S–V Definition 2: colours of the regions whose closure contains `x`). `ω(x)` = the unit circle about `x`.
(LF) local finiteness gives: a compact set meets finitely many boundaries, hence (the finite plane graph they form being tame, by Schoenflies)
finitely many regions; each point has a neighbourhood meeting only regions whose closures contain it.

- **L0 (the pointwise core).** If `O` is open and no two of its points are at distance 1, then `ω(p) ∩ O = ∅` for every `p ∈ cl O`.
  *Proof.* If `q ∈ O`, `|p − q| = 1`, take `B(q, ρ) ⊆ O` and `p′ ∈ O` with `|p′ − p| < ρ`; `ω(p′)` meets `B(q, ρ)`. ∎
  Hence **(M)**: `j ∈ c(x) ⟹ ω(x) ∩ O_j = ∅`.
- **L0′ (connected sets).** If `C ⊆ cl O` is connected and `a ∈ C ∩ O`, then `C ⊆ B(a, 1)`. *Proof.* `x ↦ |x − a|` is continuous on connected
  `C` and takes 0; if it reached a value `≥ 1` it would take the value 1 at some `p ∈ C ⊆ cl O`, and `a ∈ ω(p) ∩ O`, against L0. ∎
  (Sets `R ∪ {p}` with `R` connected and `p ∈ cl R` are connected; this replaces every "monochromatic curve" of S–V Props. 1–4.)

### 2.1 C-AE-POLY — the S–V proof of Theorem 2, step by step in the a.e. setting

Every step of S–V that uses a colour **at a boundary point** (Condition 1 at `B`, via Observation 1) is marked ★; each ★ is repaired.

| # | S–V step | use of Condition 1 at `B` | a.e. form | status |
|---|---|---|---|---|
| A1 | Props. 1, 3 | curves may run through coloured boundary points | L0′, (M) | ✓ |
| A2 | Prop. 2 (`u, v` on the boundary of the *same* two regions) | none essential | `u₁, v₁` in the region, joined inside it; L0′ | ✓ |
| A3 | Prop. 4 | curves `zx`, `xw` coloured 1 | the connected set `R_z ∪ {x} ∪ R_w`; `ω(u′)` separates `z` from `w` and misses `x`, so it meets `O_1` | ✓ |
| A4 | Prop. 5 | none | as printed with "half-neighbourhood coloured `i`" read "lies in `O_i`"; the last line ("the arc of `ω(y)` is not a boundary") is **Condition 5** — without it the conclusion fails (C5, §2.8) | ✓ with Cond. 5 |
| A5 | Prop. 6, Lemma 2 (no point of chromaticity ≥ 4) | none (uses Props. 3–6) | (M) + Condition 5 (a unit circle meets `B` finitely often); Prop. 4 via A3; the half-plane step: colour `a` adjacent to `x_i` from inside `ω(u)` forces `O_a` near `u` into the open half-plane `α_i` (a point `u′` off it has `|x_i − u′| > 1`, and the region near `x_i` contains points at distance `> 1` and `< 1` from `u′`, so L0′ fails). **Printed defect:** the last sentence says four sectors of angle `≤ π/3` "cannot fit" in a neighbourhood of `u`; they fit (`4π/3 < 2π`). The contradiction is that they cannot **cover** it, the neighbourhood of `u` carrying only colours 3–6 off `B` | ✓ (repaired wording) |
| A6 | Prop. 7 (recolour a triangle `pqz`) | ★ "by the properties of the given coloring, we must have c(u) ≠ 1" for `ω(u)` meeting a segment coloured 1 | hypothesis read "open segments `zx`, `zy` ⊆ `cl O_1`"; then `[z,x] ∪ [z,y] ⊆ cl O_1` (closed); by (M) no `u ∈ O_1` has `ω(u)` through any point of them; a unit circle cannot reach `int(pqz)` crossing only the side `xy` (the sagitta bound that defines `l`), provided `|zx|, |zy| < 1/2` so no major arc fits. S–V's second case ("z ∈ ω(u) …, Prop. 4") is then immediate from (M). New region stays a polygon; pairs inside the triangle are at distance `< 1` | ✓ |
| A7 | Prop. 8 ("Lemma 8") | via A6 | at a vertex of degree ≥ 4 with a colour on two non-adjacent sectors, recolour the in-between sector of angle `< π` (one exists: the two sectors have positive angle) | ✓, but see A12 |
| A8 | Props. 9–10, Cor. 2, Prop. 11 (the 1,2,3-annulus about `u` with `c(u) = {4,5,6}`) | none | Prop. 9 via A2 gives "no point of `O_4 ∪ O_5 ∪ O_6`" on the rays; Prop. 10 is local finiteness + Condition 5, unchanged; Prop. 11's curve can be taken to meet `B` in finitely many transversal points, so it lies in `O_1 ∪ O_2 ∪ O_3` off a finite set | ✓ |
| A9 | Cor. 3 | ★ "none of the six colours can be assigned" at a crossing | the curve about `v` crosses the curve about `u` (Jordan: it has points at distance `< 1 − η` and `> 1 + η` from `u`); the crossing can be moved off the finite set `B ∩ γ(u)` by the radius choice, and a point of `O_{123}` is in no `O_{456}` | ✓ |
| A10 | Prop. 12 (index) and Lemma 3 | ★ **"if F(t′) ≡ 0 (mod 3) … then c(γ1(t′)) = c(γ2(t′))"**: false at a time where both curves change colour at once (a *swap*), since the lift disagrees with the colour at finitely many points. **This is a gap in the printed proof, not only in the a.e. form**: §2.8's configuration makes it fail locally when Conditions 5 and 6 are dropped | at a swap `x = γ₁(t*)`, `y = γ₂(t*)` are bichromatic boundary points (curves in general position cross `B` off vertices) with one multicolour at distance 1, excluded by **TS-L1** (§2.7). With no swap `F` never crosses `3ℤ` (§2.3 (c)) | ✓ (gap closed by TS-L1) |
| A11 | Lemma 4: its first step, Lemma 5, Props. 14–19, Lemma 6, the appendix | Prop. 14's and Prop. 16's arguments are (M)-based | the trichromatic point within 1: **TS-T** (§2.5). Props. 14–17 transfer with (M) and Condition 5 (Prop. 16: the open sector outside `ω`, `ω(x)`, `ω(z)` near `y` is nonempty — directions within `90°` of `0°, ±60°` from `y − u` — so it carries colour 3). Lemma 5, Props. 18–19 are circle combinatorics. **Printed defect (appendix, p. 28):** "If the multicolors of two points p_j coincide, we immediately get the desired one" gives distance `< 2`, while Lemma 3 needs `(1, 2)`. Repair, as `[Voronov2023]` Lemma 6.1 does with its "continuity" sentence: two `p_j` of one multicolour `{a, b, i}` end two `a|b` boundaries starting at bichromatic points of `ω(u)` more than 1 apart; along the two boundaries the distance runs continuously from `> 1` down to `|p_j − p_k|`, so if `|p_j − p_k| < 1` it equals 1 at two bichromatic `{a,b}` points — excluded by TS-L1; and `= 1` exactly is excluded at degree-3 vertices by (M) (a unit circle through a degree-3 vertex enters one of its sectors off finitely many points, Condition 5). So the pair is at distance in `(1, 2)` | ✓ with repair |
| A12 | the appendix's eleventh point (p. 28, Fig. 6) | none | "on the boundary of the union of three regions of colors 1, 2, 3 whose vertex is u" — the colours must be 4, 5, 6. The step needs a colour change among 4, 5, 6 along the outer boundary of the {4,5,6}-cluster at `u`; if one region lined it, that region would contain a loop about `u` enclosing points of the other two, i.e. it would **not be simply connected**. `[Voronov2023]`'s own proof states the hypothesis ("all regions are 1-connected", p. 13); S–V leave it implicit. Polygons in Condition 8 read as simple polygons supply it at the start, **but A7's recolouring can destroy it**: when one region touches the recoloured vertex from two non-adjacent sectors, filling the triangle closes it round the pocket between them | **GAP** — in the printed chain, not created by the a.e. transfer |

**Verdict C-AE-POLY: TRUE relative to SV-2's printed chain** — every step that uses a colour at a boundary point (A6, A9, A10) is repaired, and
A4, A5, A11 transfer with Condition 5, which polygons satisfy. **It inherits one GAP of the printed chain (A12):** simple connectivity of the regions
at the eleventh-point step after Prop. 8's recolouring. Two further printed gaps are closed here: A10 (swaps in Prop. 12, closed by TS-L1) and A11
(same-multicolour distance, closed by continuity plus TS-L1). [hand, one mind]. Steps taken from the text as printed without full re-derivation:
Prop. 10's and Prop. 13's geometry, Lemma 3's choice of `p, q_i′`, Lemma 5 and Props. 17–19. Each is colour-independent or uses only (M).

### 2.2 C-AE-CONV

*Statement fixed here* (the sheet's gloss "seven colours for locally finite convex tilings, almost everywhere", made precise): let the plane be
tiled by convex polygons, locally finitely (`[Coulson2004]` §2's scheme, with or without his area bound), and let each tile's interior carry one of
6 colours. Say the colouring is a.e.-proper if no two points of the open set `O_j` (the interior of the union of the colour-`j` tiles) are at
distance 1. Then no such colouring exists. (`[Coulson2004]` Thm 3.5 as printed gives only 6: "A tile based colouring with excluded distance D must
employ at least 6 colours.")

*Derivation.* Merge the tiles by colour. The regions are the components of the `O_j`; the boundaries are the edges between tiles of different colours,
cut at the points where three or more of them meet; the vertices are those points. This is a map-type colouring (Conditions 2–4) with
piecewise-linear boundaries, so Condition 5 holds. It is a.e.-proper in D-AEMAP's sense. So it is a polygonal colouring, **provided the regions
are polygons** (and a colour class bounded by a closed loop with no vertex is admitted). The proof of §2.1 then applies. Convexity and the area
bound are used only for local finiteness. **But merged tiles give non-simply-connected regions as a matter of course**: a ring of colour-1 tiles
round a colour-2 tile. That is exactly A12's hypothesis.

**Verdict C-AE-CONV: GAP at A12** (simple connectivity of the colour regions). It is TRUE, [hand, one mind] relative to §2.1, for every tile
colouring whose colour regions are simply connected. Hand-back item: whether a.e.-properness excludes annular colour regions near the eleventh-point
configuration. No small annular region is excluded locally.

### 2.3 C-T-IND (corrected form)

*Definitions made explicit* (the claim leaves them to the deriver). Let `γ : [0,1] → ℝ²` be rectifiable. Its **trace** is `τ(t) = j` when `γ(t) ∈ S̃_j`,
defined for `H¹`-a.e. `t` on C-T-ANN's curves. A **lift** is a continuous `f : [0,1] → ℝ` with `c(f(t)) = τ(t)`, where
`c(s) = (⌊s + 1/2⌋ mod 3) + 1` (S–V Def. 6), and with `f(0), f(1) ∈ ℤ`. Then `Ind γ = f(1) − f(0)`. Agreement can be read two ways.
- **(A)** Agreement for a.e. `t`.
- **(B)** Agreement for all `t` except finitely many, colours being undefined where `γ(t) ∈ E`.

*Well-definedness under (A).* Suppose `f, g` are two lifts. Then `f − g ∉ ⋃_m (3m+1, 3m+2)` at a.e. `t`. By continuity (a preimage of an open
interval is open), this holds at every `t`. So `f − g` stays in one `[3m − 1, 3m + 1]`. At the endpoints both values are integers of one colour,
so `f − g = 3m` there, and the two indices agree.

(a) **"an index exists iff the traces change colour finitely often": FALSE as an iff, under either reading.**
- Under (A), "if" holds: a step trace lifts piecewise.
- Under (A), "only if" fails. Let `C ⊂ [0,1]` be a fat Cantor set. Take `τ = 1` on the gaps, `τ = 2` on `C` (a.e.), and let the ends lie in gaps.
  The lift `f(t) = 1/2 − dist(t, C)` near `C`, run to integers at the ends, is continuous with `c ∘ f = τ` a.e. There are infinitely many changes,
  and `Ind` exists (here 0).
  - The mechanism: two colours meet only at the half-integers `1/2 + 3m`, and `f` is pinned there on `C`.
- Under (B), "if" fails. Let the trace be a.e. constant while infinitely many curve points lie in `E`: at points `x_n → x*` of the curve, place
  off-curve discs of a second class at scales `r_{n,k} → 0` with density bounded below. Then `d̄ > 0` for two classes at each `x_n`, while the curve
  meets only the first class.
- What holds under (A): an index exists iff `τ = c ∘ f` a.e. for some continuous `f`.

(b) **"K3 gives traces with no index on an open family of curves": depends on K3's colours.**
- Under (A), a two-colour K3 (one class on a fat Cantor set, one on its gaps) **has** an index, by (a).
- Under (A), a three-colour K3 has none: gaps coloured 1 and 3 each accumulate at every point of `C`, and `C` is coloured 2. Then `f` on `C` would
  have to equal both `1/2 + 3m` and `3/2 + 3m′`.
- Under (B), K3's traces have no index: gap endpoints are in `E`, infinitely many on every transversal.
- The family of transversal curves is open in either case.

(c) **The bound.** I prove the conditional form and refute the implicit claim about swaps.

*The conditional form: TRUE, [hand, one mind].* Let `γ₁, γ₂` be complementary (`|γ₁(t) − γ₂(t)| = 1`) with lifts `f₁, f₂`. Let the endpoint
colours be defined and differ, and suppose no swap occurs. Then `|Ind γ₁ − Ind γ₂| ≤ 1`.

Proof. Let `F = f₁ − f₂`.
1. Where both colours are defined they differ (D-NF: the `S̃_j` avoid distance 1). With `f₁ ∈ [a − 1/2, a + 1/2)` and `f₂ ∈ [b − 1/2, b + 1/2)`,
   where `a ≢ b` mod 3, `F` lies in an open interval containing no multiple of 3.
2. To cross `3m`, `f₁` and `f₂ + 3m` must pass one half-integer in opposite directions.
3. If they pass at different times, then on the interval between, both lie on one side of it, so the colours are equal on a set of positive measure,
   which is impossible. So they pass at one instant: a swap.
4. With no swap, `F` stays in one `[3m, 3m + 3]`. `F(0)` and `F(1)` are integers `≢ 0` mod 3, so `|F(1) − F(0)| ≤ 1`. ∎

This holds for any continuous lifts, so **finitely many changes are not needed.**

*The implicit claim that "C-T-L1 at the swaps" removes every swap: FALSE locally.* Take §2.8's configuration and the two translate curves
`γ₁(t) = x + t d`, `γ₂(t) = y + t d`, with `d` at `−70°`.
- They are complementary.
- `γ₁` goes from colour 1 to colour 2 and `γ₂` from colour 2 to colour 1. They never share a colour.
- `Ind γ₁ = +1`, `Ind γ₂ = −1`, so `|Ind γ₁ − Ind γ₂| = 2` (`tools/fs106_sb_c5_check.py`, line (I)).
- At the swap, `P(x) = {1,2}` but `P(y) = {1,2,3}` (a bowtie), or `{1,2,3,4}`. C-T-L1b ("`P(x) = P(y)`, `|P(x)| = 2`") is silent.

The swap needs a unit-arc interface at `x`. The sweep argument proves this whenever the curves cross non-tangentially (`κ = (x − y)·γ₁′(t*) ≠ 0`):
- the circles about `γ₂(t)`, `t < t*`, sweep one side of `ω(y)` near `x`;
- the `S̃_b`-points of `γ₂` then forbid `S_b` there, off a null set (the sweep is a local diffeomorphism when `κ ≠ 0`);
- so near `x`, `S_a` and `S_b` lie on opposite sides of `ω(y)`, and near `y`, on opposite sides of `ω(x)`.

**Verdict C-T-IND: MISSTATED.** Corrected statement, [hand, one mind]: *under (A), `Ind` is well defined whenever a lift exists, and complementary
curves with no swap satisfy `|Ind γ₁ − Ind γ₂| ≤ 1`.* Two further findings:
- the "iff" is FALSE, with the explicit traces above;
- a swap can occur, with the bound failing, at a unit-arc interface facing a bowtie or a 4-chromatic point. So the no-swap input must come from a
  lemma about such configurations (C-T-TAN's bowtie and tangent cases, or Condition-6-like input), not from C-T-L1b.

### 2.4 TS-C — TRUE

*A chain of same-colour regions whose closures meet pairwise in sequence has diameter ≤ 1*, for any a.e.-proper map-type colouring.

Proof. `R₁ ∪ {p₁} ∪ R₂ ∪ {p₂} ∪ ⋯ ∪ R_n`, with `p_i ∈ cl R_i ∩ cl R_{i+1}`, is connected and lies in `cl O_j`. By L0′, for any
`a ∈ R_1 ∪ ⋯ ∪ R_n` the whole set lies in the open ball `B(a, 1)`. So distances between region points are `< 1`, and the closure has diameter
`≤ 1`. ∎

Only L0 is used: no Condition 5, no local finiteness, and no accessibility of boundary points (connectedness replaces paths). [hand, one mind]

### 2.5 TS-T — TRUE

*First half:* in any a.e.-proper map-type colouring, every point `z` has a point of chromaticity `≥ 3` within distance `≤ 1`; in fact within
`1/√2 + ε` for every `ε > 0`.

Proof.
1. Let `Q` be the closed square of side `s ∈ (1, √2]` centred at `z`. Its points are within `s/√2 ≤ 1` of `z`.
2. Group the regions of each colour into chain components `K`. Closures of distinct components of one colour are disjoint, by maximality.
3. For each component, let `F_K` be the union of `cl R ∩ Q` over the finitely many `R ∈ K` meeting `Q` (LF).
4. The `F_K` are finitely many closed sets covering `Q`, since every point of `B` is in the closure of a region.
5. Each `F_K` has diameter `≤ 1 < s` (TS-C), so no `F_K` meets two opposite sides of `Q`.
6. By the **Lebesgue covering theorem** (a closed `n`-cube covered by finitely many closed sets none meeting two opposite faces has a point in
   `n + 1` of them; Hurewicz–Wallman, *Dimension Theory*, Thm IV 2), some point lies in three `F_K`.
7. Those three have three distinct colours, by step 2. ∎

*Second half:* with ≤ 6 colours and Condition 5, a.e. Lemma 2 (A5) caps chromaticity at 3, so the point is trichromatic. A trichromatic point is a
vertex, since a non-vertex boundary point has chromaticity ≤ 2. **Condition 6** then makes it of degree 3, so a boundary between each pair of its
colours emanates from it (S–V's "extend from each point"). This closes S–V's unproved sentence on p. 20. Condition 6 is not needed for
chromaticity exactly 3. [hand, one mind]

### 2.6 TS-U — TRUE, in an exact form

Let `A ⊂ ω(z)` be an open arc of angular extent `θ ∈ (0, π)`, with direction set `E` seen from `z`. Suppose that for some `ρ > 0` the points
within `ρ` of `A` on the `z`-side (`|p − z| < 1`) lie in `O_c`, and those on the far side lie in `O_{c′}`. Then there is `r > 0` such that for
`|t| < r`:
- `z + t ∈ O_c ⟹ z + t ∈ ⋂_{p ∈ A} D(p, 1)`;
- `z + t ∈ O_{c′} ⟹ z + t ∉ ⋃_{p ∈ A} D̄(p, 1)`.

To first order these are the **wedge facing the arc** `W₊ = {t : e·t > 0 ∀ e ∈ E}` (opening `π − θ`) and the opposite wedge `−W₊`. The two
**side cones** between them meet neither `O_c` nor `O_{c′}`.

Proof, for `b ∈ O_c` near `z` and `p ∈ A`:
1. If `|p − b| = 1`, then (M) is violated (`p ∈ cl O_c`).
2. If `|p − b| > 1`, the points `a = p − s(p − z)`, `0 < s < ρ`, lie in `O_c`, and `|a − b|` runs continuously from about `|p − b| > 1` down to
   below 1, since `|a − b| ≈ 1 − s + O(|b − z|)`. This contradicts L0′.
3. The case of `O_{c′}` is symmetric, using the outer points. ∎

A reading of the sheet's wording: "the wedge facing it" is `c`'s wedge, where `c` is the colour on the concave side, the side facing `z`.
[hand, one mind]

### 2.7 TS-L1 — TRUE

*S–V Lemma 1 for a.e.-proper map-type colourings, with no Condition 5 and no Condition 6, any number of colours.*

Proof. Let `c(x) = c(y) = {a, b}` with `|x − y| = 1`. Choose `r < 1/4` so that `B(x, r)` and `B(y, r)` meet only regions whose closures contain
`x`, resp. `y` (LF).
1. Every `z ∈ B ∩ B(x, r)` has `c(z) = {a, b}`: its regions have colour `a` or `b`, and a boundary through `z` separates two different colours.
2. By (M), for `z ∈ B ∩ B(x, r/2)` the set `ω(z) ∩ B(y, r)` misses `O_a ∪ O_b`, so it lies in `B`.
3. That set contains a nondegenerate arc `σ_z`, because `|z − y| ∈ (1 − r/2, 1 + r/2)`.
4. `B ∩ cl B(y, r)` is a finite union of Jordan arcs `J_1, …, J_m` (LF). By Baire, some `J_i ∩ σ_z` has interior in `σ_z`, so it contains a
   sub-arc of `σ_z` that is a nondegenerate interval of `J_i ≅ [0,1]`.
5. Distinct `z` give distinct circles, which share at most 2 points, so these intervals have disjoint interiors. At most countably many `z` are
   therefore possible.
6. But `B ∩ B(x, r/2)` is uncountable: `x` lies on a boundary arc, or is a vertex with at least three arcs. Contradiction. ∎

Uses: each boundary is a Jordan arc; local finiteness. [hand, one mind]

### 2.8 C5 — TRUE (a counterexample to S–V Prop. 5 without Condition 5)

The configuration:
- **Points.** `u = (0,0)`, `x = (1,0)`, `y = (1/2, √3/2)`.
- **Near `x`** (radius `r = 0.02`): colour 1 where `|p − y| < 1`, colour 2 where `|p − y| > 1`. The boundary is an arc of `ω(y)`, a unit arc.
- **Near `y`**, by the direction `ψ` of `p − y`: colour 1 on `(−140°, 20°)`, colour 3 on `(20°, 40°)`, colour 2 on `(40°, 200°)`, colour 3 (or
  4) on `(200°, 220°)`.

Checks:
- **Prop. 5's hypothesis.** On `ω(u)`, the half toward `y` at `x` lies in colour 1 and the other half in colour 2; the half toward `x` at `y` lies
  in colour 1 and the other half in colour 2.
- **Every pairwise constraint.** For colour 1, the direction of `a − y` is within `1.2°` of `−60°`, so `(a − y)·t ≥ 0.149|t|` and
  `|a − b|² ≤ 1 − 0.298|t| + |t|² < 1`. For colour 2, the angle between `t` and `a − y` exceeds `98°`, so `|a − b|² > |a − y|² > 1`. Colours 3 and
  4 do not occur near `x`.
- **Prop. 5's conclusion fails at `x`**, both inside and outside `ω(u)`: only colours 1 and 2 occur there.

Machine check: `tools/fs106_sb_c5_check.py` passes. Each of its three plants fails for its own reason:
- colour 1 widened into a side cone: colour-1 sign change;
- colour 2 given a side cone: colour-2 sign change;
- colours swapped at `y`: the hypothesis fails.

TS-U's exact form shows the side cones at `y` are nonempty and carry neither 1 nor 2. So `y` is either a degree-4 trichromatic vertex (the bowtie
Condition 6 forbids) or a 4-chromatic vertex, which Condition 6 allows. **C5 therefore survives Condition 6; only Condition 5 kills it.** It is the
local picture behind the swap in §2.3 (c). [hand, one mind; the float check is a check, not a proof]

### 2.9 Would have searched here (continued)

- C-T-IND: would have searched random measurable traces for an index-bound violation. Instead: derived the swap mechanism and read it off C5's
  configuration.

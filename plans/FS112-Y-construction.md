# FS112-Y — the construction side of FS-112 (the unit-arc half)

*Job FS112-Y, de Bruijn on Opus 5.5, launched 2026-09-27 at HEAD `799131a2`. Brief: `data/fs112/briefs/Y112-construction.md` with
`data/fs112/briefs/STANDING-RULES.md`. Claims: `data/fs112/claims.md` (quoted, never paraphrased). Working files: `data/fs112/fs112-y/`; tools:
`tools/fs112_y_*.py`. Every fragment below is **a local fragment, not a map**.*

## Theorems this phase proved

| id | statement (one line) | grade | address |
|---|---|---|---|
| Y112-STRIP-RULE | `[AxenovichEtAl2014]` Thm 4.2's strip, rebuilt from its printed words (geometry) and Fig. 4 (combinatorics, by eye): arches of width 1/2 with unit arcs centred at the opposite bottom corners, apex height `√15/4`, top and bottom rows fixed by "distance 1 between the point of intersection of circular arcs and the opposite corner", total height `√15/2 + √3` exactly | hand, one mind (stage 1); exact check owed to stage 2 | §1.3 |
| Y112-STRIP-KINDS | every unit arc of the strip is centred at a midline vertex, which is a four-colour vertex of degree 4, and every arc is of kind **both** (self in-contact and out-contact) | hand, one mind; checker owed | §1.3 |
| Y112-NB4-MIS | NB-4's general form as filed ("a four-colour vertex needs an arc of `Γ` of `ω(y)` or `ω(σ_v^{±1}y)` through a change point of every orbit of its ring") is MISSTATED: it omits arcs of `ω(v)` itself; the strip's midline vertex escapes in the orbit of its apex change points by an arc of `ω(v)` alone | hand, one mind; rests on the strip's validity (stage 2) | §1.4 row 1 |
| Y112-WALK | the chain walk: first break at C-CHAIN-1 (NB-4), locally, with C-CHAIN-2 (NB-5) and C-CHAIN-10's "every vertex is cubic" broken by the same object; per-step verdicts and circles in §1.4 | hand, one mind | §1.4 |
| Y112-T2-SQRT3 | the strip carries T2 at `d = √3`, arc-closed: the valley `(1, √3/2)` `{2,3,4}` and its mirror `{1,5,6}` both emit arcs of `ω((1/2,0))` and `ω((3/2,0))`, whose points are four-colour vertices `{1,2,4,5}`, `{1,3,4,6}` | hand, one mind; checker owed | §1.3 |
| Y112-EDGE | the strip's top edge passes through the upper common unit point `Q = (1/4, H/2)` of the close complementary pair `V₀ = (0, √3/2)` `{1,3,5}`, `A₁ = (3/4, √15/4)` `{2,4,6}` (distance `√(9 − 3√5)/2 ≈ 0.757`), and no colour is available just above `Q` without changing the sectors at `V₀` or `A₁` | hand, one mind | §1.5 |

## Fence log (standing rule 13; brief § Fences)

1. Stage 1, first minutes: `ls data/fs112/` printed the directory **names** `fs112-a` and `reports` (fenced paths) among others; no file in them was
   listed or opened. 2. The same moment, `ls plans/FS112*` printed the **name** `plans/FS112-close-inventory.md` (fenced); not opened. Nothing else.

## Would-have-searched-here log (standing rule 3)

- The strip: I would have fitted Fig. 4's pixels (its arches look more curved than the rule gives); instead every number comes from the printed words,
  and only the colour pattern is read from the figure.
- The chain walk: I would have scanned horn curvatures in `[−1, 1]` at N3-DEG/N4 steps for a unit-arc horn fragment; instead the verdicts name the
  exception (`κ = ±1`, an out-contact arc centred at `N` or `S′`) by derivation, and a fragment is left to a later stage with its formula fixed first.

## Stage 1 — SAVED: quotation check; the strip (the object the walk uses); the chain walk

### 1.1 Read from disk, in this order

`STANDING-RULES.md` (rule 0 first); `CLAUDE.md` § The aim and § Counter-priors (at `df120f6b`, differs from my context's snapshot in link 2 only),
G82, G22 (and the other grokkings the brief names, unchanged from my snapshot); `LEDGER.md` rows 131–134; `data/fs112/claims.md` in full;
`plans/FS112-unit-arc-half.md` §1.3, §G part 3, §PA, §IQ, §5.1, §5.2, §5.4 (**not §5.3**); `plans/FS112-PA-reading.md` in full (the extracts file by
its quoted locators); `plans/FS110-derivation.md` in full; `data/fs110/claims.md` §§0–3, §9; `plans/FS110-Y-construction.md` §§2.1–2.4, 4.5, 5, 11;
`tools/fs110_y_check.py`; FS-110's proof record `plans/FS110-N-proof.md` N3 §2.1–2.4 and N4 §2.1–2.7 and `plans/FS110-NB-verification.md` §2.2–2.6 (FS-110's
records, not fenced), to find where Condition 5 enters each step; `[AxenovichEtAl2014]` p. 8 (text and Fig. 4, viewed at 300 dpi); `[SokolovVoronov2025]`
Conditions 5–8, Cor. 1, Cor. 3, Lemma 3's statement, Question 2 (text).

### 1.2 Quotation check (standing rule 5)

`tools/fs112_y_quotes.py` (output `data/fs112/fs112-y/quotes.out`): 33 quotations — Kooshi's three in my brief, Q-full, the eighteen C-CHAIN statements
(against `plans/FS110-derivation.md`), CAL-STRIP's two printed sentences, CAL-DISK's two, `[Polymath2021]` p. 194's tactic, `[07.10]`, `[11.34]`, TS-U,
`[Thomassen1999]` p. 850, S–V's Question 2 and Cor. 3 — **all found verbatim** (whitespace, typographic quotes and line-final hyphens normalised; two PDF
quotations break across a hyphenated line, "unit-/edge" and "multi-/colors"). The brief's three numbers check (`3.668542`, `2.124255`, `1.834271`).
`--self-test`: a one-word alteration of C-CHAIN-1 is MISSING while the faithful twin is FOUND. **No paraphrase found in my brief.**

### 1.3 The strip, rebuilt from the printed rule (hand; the exact check is stage 2's first product)

**Rule** (`[AxenovichEtAl2014]` p. 8, verbatim): "The symmetric tiles have width 1/2, with the rounded boundary being a circular arc of radius 1 centered at
the opposite corner of the tile. The tiles used in the top and bottom rows are determined by the distance 1 between the point of intersection of circular
arcs and the opposite corner of a tile." With `x_j = j/2` and `H/2 = √3/2 + √15/4`:
- `A_j` (above the midline): the segment `[(x_j,0),(x_{j+1},0)]`; the sides `x = x_j`, `x = x_{j+1}` for `0 ≤ y ≤ √3/2` (a unit arc from `(x_j, √3/2)` centred
  at the opposite bottom corner `(x_{j+1}, 0)` starts at height `√(1 − 1/4)`); the arc from `(x_j, √3/2)` to the apex `(x_j + 1/4, √15/4)` centred at
  `(x_{j+1}, 0)`, and from the apex to `(x_{j+1}, √3/2)` centred at `(x_j, 0)`. `B_j`: its mirror in `y = 0`.
- `C_j` (top row, centred on `x = x_j`): below, the two arcs meeting at the valley `(x_j, √3/2)` (the point of intersection of circular arcs), i.e. `A_{j−1}`'s
  right arc and `A_j`'s left arc; sides `x = x_j ± 1/4` from `√15/4` up; top at `y = H/2`, fixed by "distance 1" from the valley to the top corners:
  `H/2 = √3/2 + √(1 − 1/16) = √3/2 + √15/4`, so **height `√15/2 + √3`**, the printed `ω(6)` bound. `D_j`: the mirror.
- **Colours** (Fig. 4's pattern, read by eye; period 3 in `j`): `A_j` = 1, 2, 3; `B_j` = 4, 5, 6; `C_j` = 5, 6, 4; `D_j` = 2, 3, 1 for `j ≡ 0, 1, 2`. Symmetries:
  `x ↦ x + 3/2`; `y ↦ −y` with `(1 4)(2 5)(3 6)`; `x ↦ −x` with `(1 3)(4 6)`.
- The same rule, from the threads: `[07.10]` "The curved lines are arcs at constant radius 1 from the opposite corner, so each vertex down the middle mandates
  four such curved edges, but they interdigitate without problems." — matched: each midline vertex is the centre of four arcs.

**What the rebuild shows (hand; each claim to be confirmed by the checker):**
1. **Every tile has diameter exactly 1** (arches: a bottom corner to the opposite arc; `C_j`: the valley to the top corners, and a top corner to the far lower arc's
   two ends — its interior points are nearer, by the law of cosines at `ψ = ±7.76°` about the direction `112.24°` from the arc's centre).
2. **Every unit arc is centred at a midline vertex `P_j = (x_j, 0)`**, which has four colours (`A_{j−1}, A_j, B_{j−1}, B_j`; e.g. `P_1 = (1/2, 0)`: `{1,2,4,5}`),
   degree 4, one sector per colour. `ω(P_1)` carries four arcs of `Γ`, at directions `[60°, arccos(1/4)]`, `[180° − arccos(1/4), 120°]` and their mirrors,
   total `4(arccos(1/4) − 60°) ≈ 62.1°`. **Each arc is of kind both**: its inner tile (an arch) has `P_j` as a corner (self in-contact), and its outer tile
   (`C_{j±1}`, `D_{j±1}`) has the colour of the arch across the midline at `P_j` (out-contact: `C_{j+1}`'s colour is `B_{j−1}`'s). The two same-colour tiles
   at distance exactly 1 along each arc are the `[Polymath2021]` p. 194 tactic.
3. **Vertices.** Midline: four colours, degree 4. Valley `(x_j, √3/2)`: `A_{j−1}, A_j, C_j`, three colours, cubic. Apex `(x_j + 1/4, √15/4)`: `A_j, C_j, C_{j+1}`,
   three colours, cubic. The rest are on the strip's edge.
4. **T2 at `d = √3`, arc-closed** (Y112-T2-SQRT3): the valley `W = (1, √3/2)`, `P_cl = {2,3,4}`, and `W′ = (1, −√3/2)`, `{1,5,6}`, complementary at distance `√3`,
   both emit arcs of `ω(P_1)` and `ω(P_2)` (`P_2 = (3/2, 0)`, `{1,3,4,6}`); `P_1 W P_2 W′` is a unit rhombus of vertices, `ω(P_1) ∩ ω(P_2) = {W, W′}`, and both
   seam points are four-colour vertices whose branches of `ω(W)`, `ω(W′)` alternate (`30°, 150°, 210°, 330°` at `P_1`, colours 2, 1, 4, 5: each outside the
   circle's owner's type) — C-SEAMS-TWO's picture and Y-T2W's conclusion, with every arc's ends interior to the strip. FS-110's T2 was at `d = 1`, open-ended.
5. **Close covering pairs abound**: `(P_1, P_2)` at distance 1 (types overlapping in `{1,4}`, union `[6]`), common unit points `W`, `W′`; `(W, W′)` above;
   `(V₀, A₁)` at `≈ 0.757` (§1.5).

### 1.4 The chain walk (C-CHAIN-1 … C-CHAIN-18, unit arcs allowed) [hand, one mind; the strip's clauses rest on stage 2's exact check]

A unit arc centred at `P` breaks Condition 5 on `ω(P)` alone. "Reads" names the circles the step's proof reads; "C5 used" names where the FS-110 proof
used Condition 5 (from the proof records of §1.1). Verdicts: **(a)** holds as written; **(b)** holds off a named exception; **(c)** fails, with the configuration.

| step | verdict | reads | C5 used | exception or configuration |
|---|---|---|---|---|
| 1 NB-4 | **(c) fails, locally** | `ω(v)`; for one `σ_v`-orbit of change points `y_k`: `ω(y_k)` (first step at `y_k`), `ω(y_{k±1})` at `y_k` | `ω(v) ∩ Γ` finite, so the ring is two-coloured with isolated change points, each a swap with `σ_v^{±1}y` (NB §2.3); no arc of `ω(y_{k±1})` at `y_k`; `ω(y_k) ∩ Γ` finite | **The strip's midline vertex `P_1`, `{1,2,4,5}`**, valid in `B(P_1, 1.834)`: its ring runs `3 | Γ | 6 | Γ | 3 | 6 | Γ | 3 | Γ | 6` with the four arcs of `ω(P_1)`; at `σ_v y` the type is the valley's `{2,3,4} ⊉ {3,6}`, so "every change point is a swap" fails at the arcs' ends. Kind **both**. **And the general form is MISSTATED** (Y112-NB4-MIS): in the orbit of the apex `A₁ = P_1 + e^{i·arccos(1/4)}`, the change points are `A₁` and its mirror; no arc of `Γ` lies on `ω(A₁)`, `ω(σ^{±1}A₁)` (every arc of the strip is centred on the midline), yet `P_1` has four colours — the escape is the arc of `ω(v)` ending at `A₁`. Corrected: "an arc of `Γ` of `ω(v)` or of `ω(σ_v^{±1}y)` through a change point `y`, or an arc of `ω(y)`, in every orbit" (the printed "`ω(y_k)` … passes through `y_k`" is the MISSTATED-suspect FS112-A named). So no argument confined to `B(v, 1.834)` excludes a four-colour vertex |
| 2 NB-5 | **(c) fails, locally** | `ω(u)`, `ω(v)` at `w₀`; `ω(w₀)` near `u`, `v` (N-X (c)); NB-4's circles at `w₀` | N-SEAM: a non-vertex seam needs a unit arc of `ω(u)`/`ω(v)` through `w₀` ((S1)); N-X: half-arcs of `ω(u)`, `ω(v)` at `w₀` in tiles, of `ω(w₀)` at `u` in tiles; NB-4 at `w₀` | **Arc-closed in the strip**: `(W, W′)` complementary at `√3`, saved at both common unit points by T2 with four-colour seam points (§1.3 item 4); and `(V₀, A₁)` saved at `P_1` by N-X's alternation **without bowties** — N-X (c)'s bowtie is replaced by "along `Γ`": `ω(P_1)`'s half-arc at `V₀` is the arc `[180° − arccos(1/4), 120°]` ending at `V₀`. FS-110's S1, T2, BB, MX realise it open-ended. Kinds: both (strip), out (S1) |
| 3 N3-CONF | **(a)** holds, "finite" read "compact" | `ω(v)` | "`W_c(v) … ⊆ Γ ∩ ω(v)`, finite by Condition 5" | The in/out dichotomy (N-E1, N-E2, connectedness), the half-planes and N3-UP's lens and lune use no Condition 5; with contact arcs `D_c(v)` is an intersection over a compact set of directions and N3-CLEAR holds uniformly. The strip at `P_1`: colour 2 has self in-contacts along `[60°, 75.5°]`, `D_2 ⊆ [−14.5°, 150°] ∋` its sector `[0°, 90°]`; colour 4 out-contacts along the same arc, `D_4 ⊆ [165.5°, 330°] ∋ [180°, 270°]` |
| 4 W-MERGE | **(b)**, with a GAP at one clause | `ω(v)`; `ω(v′)` for `v′` near distance 1; `ω(N)`, `ω(S′)` at a cusp end | "new boundary arcs of radius `ρ < 1`, so Condition 5 … hold" (now vacuous); "An end can lie on `∂D_c(v)` only if … cusp horn … contacts … tangent ones at `N` or `S′`" | Clearance survives (step 3). **GAP at "for every other vertex `v′`, `D_c(v′)` is unchanged"** when `v` lies on a unit arc of `ω(v′)` bounding a sector of the recoloured gap, `c ∈ P_cl(v′)` (in- or out-contact at centre `v′`): the merged region gains boundary on `ω(v′)`, a new contact of `c` there. Termination is unaffected (the potential still drops); what a later step reads of `D_c(v′)` may change. Untested by the strip (no colour has two sectors at any strip vertex) |
| 5 N3-DEG | **(b)** | `ω(v)`, `ω(N)`, `ω(S′)` | "strictly `−1 < κ₁`, `κ₂ < 1` by Condition 5 (an arc of curvature exactly `±1` tangent to `a` at `v` lies on `ω(N)` or `ω(S′)`)" | The cone survives (in+in, in+out at one point impossible without Condition 5); **exception: horn curvatures `κ = ±1`**, a horn bounded by a unit arc centred at `N` or `S′` with the horn outside — kind **out-contact** (the out-type `c`-tile at `N` and the horn are at distance exactly 1 along the arc); valid locally (the `N`-tile's points beyond `N` stay at distance `> 1` from the arc) |
| 6 N4-SHADOW | **(b)**, the formula extended | `ω(v)`; the circle through `v` concentric with the tile's arc | "`C = 0` is an arc of radius 1: excluded" | At `C = 0` (the tile at `N` beyond an arc of `ω(v)`, out-contact at centre `v`) the shadow near `v` is the open cone of directions within `90°` of the arc — wider than a half-plane: `f(−1) = −∞` (the limit of `f` from above). N4-FLANK's "only through out-type tiles at `S′` and `N` tangent to `a`" still holds (`ω(v)` is tangent to `a` at `N`) |
| 7 N4-SHAVE | **(b)**, GAP at `κ = ±1` | `ω(v)`, `ω(N)`, `ω(S′)` | N4-FLANK: "in-type `g` at `N` … Siamese with the flank sector, which has points just above `κ_+ ∈ (−1, 1)`, outside both `B̄(N, 1)` and `B̄(S′, 1)`"; the new arc `Σ` has radius `≠ 1`; N4-RAY: "a curve through `v` … tangent to `a` with curvature `±1`, outside the stack" and "a circle and an arc of different curvature … do not cross" | At `κ_+ = 1` the flank above the horn lies inside `B(N, 1)`, so an in-type flank contact at `N` is no longer excluded and FLANK's shadow list is incomplete; N4-RAY's two steps fail when a stack boundary or `M`'s boundary is a unit arc (the circle can run along it). Off horns with unit-arc boundaries (centres `N`, `S′`), (a) |
| 8 N4-STUCK / PROP | **(c)** as a derivation: GAP | `ω(v)`, `ω(N)`, `ω(S′)`; NB-4's circles at `v` and `N`; along PROP every `ω(P_k)` | "NB-4: `P_cl(v) = {c, g_+, h_+}`"; "The two arcs of `ω(v)` leaving `N` lie in tiles at `N` (Condition 5: `Γ ∩ ω(v)` is finite), so some ring colour `r` is at `N`" | Inherits step 1: at a four-colour vertex the structure (ii) is not derived; with a unit arc of `ω(v)` through `N` no ring colour need be at `N`, so (iv)'s `P_cl(N) = {c, h, r}` fails to follow. Holds off unit arcs centred at `v`, `N`, `S′` (each `P_k` along PROP) and off NB-4's exception |
| 9 N4-FIN | **(a)**, and its closed form holds | none (arithmetic) | none | As written TRUE. With unit arcs the chain's curvatures lie in `[−1, 1]` with `f(−1) = −∞`, `f̃(1) = +∞`; the same count ends the chain (`υ` reaches 1 in finitely many steps, then `υ_next ≥ +∞`; mirror for `λ`). So N4-FIN is not where the chain breaks |
| 10 N4-TERM | **(c)** at "every vertex is cubic" | as steps 4, 7, 8 | through NB-4 and the operations' Condition 5 clauses | **The strip is terminal** (no colour has two sectors at any vertex: no MERGE, MERGE-RAY or SHAVE applies) **and not cubic**: its midline vertices have degree 4 and four colours. The first clause ("no colour has two sectors") holds there; "cubic" was NB-4 |
| 11 NB4-CS | **(b)**, GAP at `κ = ±1` | `ω(v)`, `ω(N)`, `ω(S′)` | through SHAVE, RAY, N3-DEG's strictness | Holds off horns bounded by unit arcs centred at `N`, `S′` and off four-colour vertices |
| 12 P17 | **(b)**; fails at named arcs | `ω(u)`; `ω(x_{i±1})` at the rotation points `x_i` | "The arc of `Γ` between them leaves `x₁` tangent to `ω(x₂)` with curvature `≠ 1`" | Exception: a unit arc of `ω(x₂)` through `x₁` (kind: out-contact for `g`, which is outer to `x₂`'s `g`-tile) — N2-HEX's "the pure rotating ring is locally consistent" is this case (NB3: it "stands without Condition 5"). No fragment held; a candidate for a later stage |
| 13 COR1-NOD2 | **(b)** | `ω(u)`, `ω(v)` of the pair, pseudo-coloured | the pseudo-colouring of `ω(u)` has finitely many breakpoints (S–V: Cor. 3 "cannot [be asserted] unless the Condition 5 is satisfied") | Holds off pairs with a unit arc centred at `u` or `v` (any kind). The strip holds Cor. 3's configuration (`V₀`, `A₁`, cubic, disjoint, `≈ 0.757`, boundaries extending) and Lemma 3's (`V₀`, `(3/2, √3/2)`, `{1,3,5}` both, distance `3/2`), but **not** their circles: `ω(V₀)` reaches height `√3/2 + 1 > H/2`, and the escape at `P_1` is a non-cubic vertex. So the strip does not refute the cubic statement |
| 14 CB-LEMMA3 | **(b)** | `ω(u₁)`, `ω(u₂)` (the bicycle) | finitely many breakpoints on the two circles | Off unit arcs centred at `u₁`, `u₂`; an arc centred elsewhere meets each circle in at most two points |
| 15 CE5 | **(b)**, GAP at arcs centred at `u` | `ω(u)`; `u`'s own boundary curves | none explicit ("No tangent is used") | With a unit arc centred at `u` the M-in points of `ω(u)` include whole arcs (self in-contact) and the "votes" of `u`'s arcs are not read there; boundaries at `u` that are unit arcs centred elsewhere do not enter. Not tested by the strip (its unit-arc centres are four-colour, not cubic) |
| 16 CE6 | **(b)** | `ω(u)` (D5's circle-only reduction) | the circle's colour changes are isolated | Off unit arcs centred at `u` |
| 17 CUSP-BASE | **(b)** | `ω(u)`, `ω(u ± n)` | through N3-DEG's strictness | At `R = 1` the identity gives `|u ± n − x(m)| = 1` identically on one side: a cusp boundary of radius 1 centred at `u ± n` (out-contact) is exactly where D2's strict inequality is lost |
| 18 the headline | **(c)**: its proof does not transfer | all of the above | — | The chain breaks first at step 1, locally, and step 10's "cubic" with it; whether its conclusion holds with unit arcs is Q-full itself. Row 134's only unbounded step (N4-PROP) is not where it breaks |

**The first break, in chain order: C-CHAIN-1, NB-4, locally, at an arc-closed object held in print** — `[AxenovichEtAl2014]`'s strip (Thm 4.2), whose every
midline vertex is a four-colour vertex that is the centre of four unit arcs of kind both. The same object breaks C-CHAIN-2 (close covering pairs saved at
both common unit points, T2 at `d = √3`) and C-CHAIN-10's "cubic" (terminal and degree 4). Steps 3, 9 survive as written; steps 4–8, 11–17 survive off unit
arcs centred at the named points (`v`, `N`, `S′`, `P_k`, the pair `u, v`, the rotation points), with GAPs at `κ = ±1` horns and at W-MERGE's "`D_c(v′)`
unchanged". **Grade: hand, one mind; every strip clause waits on stage 2's exact check (a REJECT there would withdraw rows 1, 2, 10).**

### 1.5 Why the strip stops, read off the rebuild (Y112-EDGE) [hand, one mind]

The valley `V₀ = (0, √3/2)`, `{1,3,5}` (sectors `A_{−1}`: 3 on `[150°, 270°]`, `A_0`: 1 on `[270°, 30°]`, `C_0`: 5 on `[30°, 150°]`), and the apex `A₁ = (3/4, √15/4)`,
`{2,4,6}` (`A_1`: 2 on `[194.5°, 345.5°]`, `C_2`: 4 on `[345.5°, 90°]`, `C_1`: 6 on `[90°, 194.5°]`), are complementary, cubic, at distance `√(9 − 3√5)/2 ≈ 0.757`.
Their common unit points are `P_1` (saved: §1.4 row 2) and **`Q = (1/4, H/2)`, a top corner of `C_0` and `C_1` on the strip's edge** (`|Q − V₀|² = 1/16 + 15/16`,
`|Q − A₁|² = 1/4 + 3/4`) — the printed rule's "distance 1" is this pair's second seam. Just above `Q`, a point `z` is outside `B(V₀, 1)` and `B(A₁, 1)`, and
`ω(z)` passes beyond `V₀` in direction `≈ 75.5°` (inside `C_0`'s sector: not 5) with its near-tangent line reaching `A_0`'s and `A_{−1}`'s sectors (not 1, not 3),
and beyond `A₁` in direction `≈ 120°` (inside `C_1`'s: not 6) reaching `C_2`'s and `A_1`'s (not 4, not 2): **no colour**. So the strip is locally maximal at `Q`:
an extension must change the sectors at `V₀` or `A₁`. This is C-BEYOND's step made concrete for the strip: a NO route must read the neighbourhood of `Q`
above the strip; and it is Sirgedas's words (`[16.346]`–`[16.347]`, "all 6 colors are within two “steps” of the new vertex") located at one pair.

### 1.6 Carried to stage 2

The checker in ℚ(√3, √5) (a tower of quadratic extensions with exact sign, reusable for the disk's `ℚ(√5, √(10 + 2√5))`); its order: FS-110's fragments
(same verdicts as the frozen checkers), CAL-7, CAL-STRIP (height, contact kinds, pairs examined against pairs present), planted faults beside faithful twins.
**Before the first REJECT I rely on — what I will do if the strip is refused:** read the named pair; (i) a wrong rebuild shows as a REJECT at a pair whose
colours come from Fig. 4's pattern (then the pattern, not the geometry, is re-read by eye, with no second guess tried by solver); (ii) a wrong checker
shows as the same pair ACCEPTed by a hand computation of its exact range, or as a control flipping; (iii) a wrong print survives both (the exact range
recomputed by hand straddles 1) — then the rows of §1.4 that rest on the strip are withdrawn and the print's Thm 4.2 is reported refuted.

## Stage 1 — SAVED

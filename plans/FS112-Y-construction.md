# FS112-Y — the construction side of FS-112 (the unit-arc half)

*Job FS112-Y, de Bruijn on Opus 5.5, launched 2026-09-27 at HEAD `799131a2`. Brief: `data/fs112/briefs/Y112-construction.md` with
`data/fs112/briefs/STANDING-RULES.md`. Claims: `data/fs112/claims.md` (quoted, never paraphrased). Working files: `data/fs112/fs112-y/`; tools:
`tools/fs112_y_*.py`. Every fragment below is **a local fragment, not a map**.*

## Theorems this phase proved

| id | statement (one line) | grade | address |
|---|---|---|---|
| Y112-STRIP-RULE | `[AxenovichEtAl2014]` Thm 4.2's strip, rebuilt from its printed words (geometry) and Fig. 4 (colour pattern, by eye), is a valid six-colouring of the strip `|y| ≤ √15/4 + √3/2`: 60 of 60 same-colour pairs within reach ACCEPT; every contact exact at 1 (tight); height exactly `√15/2 + √3` | tools, exact, one checker (`tools/fs112_y_check.py`); the rebuild hand, one mind | §1.3, §2.2 |
| Y112-STRIP-KINDS | every unit arc of the strip (22 read in columns −1…4) is centred at a midline vertex with four colours and is of kind **both** (self in-contact and out-contact) | tools, exact | §2.2 |
| Y112-NB4-MIS | NB-4's general form as filed omits arcs of `ω(v)`; corrected per orbit (W1): the proof runs in an orbit `y₀…y₅` if (α) no arc of `Γ` on `ω(v)` contains an orbit point, (β) no arc of `ω(y_{k±1})` runs along `Γ` at `y_k`, (γ) `Γ ∩ ω(y_k)` has measure `< 180°`; the strip's midline vertex fails (α) in every orbit | hand, one mind; the strip exact | §1.4 row 1, §2.3 W1 |
| Y112-WALK | the chain walk: first break C-CHAIN-1, locally; C-CHAIN-2 and C-CHAIN-10's "cubic" broken by the same exact object; after Card W: W-MERGE and N4-RAY hold as written (two retractions), P17's exception is of kind both, the base's circles as in §2.3 W4 | hand, one mind | §1.4, §2.3 |
| Y112-T2-SQRT3 | the strip carries T2 at `d = √3`, arc-closed: `W = (1, √3/2)` `{2,3,4}`, `W′` `{1,5,6}`, seam points `P_1` `{1,2,4,5}`, `P_2` `{1,3,4,6}` | tools, exact (types and validity) | §1.3, §2.2 |
| Y112-EDGE | the strip's top edge passes through the upper common unit point `Q = (1/4, H/2)` of `V₀` `{1,3,5}`, `A₁` `{2,4,6}`, `|V₀ − A₁|² = (9 − 3√5)/4`; no colour is available just above `Q` without changing the sectors at `V₀` or `A₁` | the identities tools, exact; the no-colour step hand, one mind | §1.5, §2.2 |
| Y112-CHK | the exact tower checker reproduces the frozen FS-110 checker's verdict on every pair of 14 fragment builds (390 pairs, 6 REJECTs, 0 disagreements) and CAL-7's three controls | tools, exact | §2.1 |

## Fence log (standing rule 13; brief § Fences)

1. Stage 1, first minutes: `ls data/fs112/` printed the directory **names** `fs112-a` and `reports` (fenced paths) among others; no file in them was
   listed or opened. 2. The same moment, `ls plans/FS112*` printed the **name** `plans/FS112-close-inventory.md` (fenced); not opened.
3. Not a fence touch, but held for the owner: my one SendMessage to FS112-A2's raw agent id (the pre-round answer) **resumed that agent under
   this session** ("Resuming agent a8d6b60"), and its hand-backs ("FS112-A2 idle; no content in this hand-back") arrived here as if from my
   child. I launched nothing; I sent no further message to A2. Standing rule 1 may need a harness note (reply through "main"?).
4. §5.3 read after the owner lifted its fence (stage 2), after my stage 1 was committed (`3fdae23d`).

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

## Stage 2 — SAVED: the exact checker, calibrated in the claim list's order; CAL-STRIP ACCEPTs; Card W answered

### 2.0 The generator image (written before any object; G21)

My objects are tiles bounded by segments and circular arcs whose endpoints, centres and radii lie in a **tower of real quadratic fields**
`Q(√d₁)…(√d_K)` (stage 2: `Q(√3)` and `Q(√3)(√5)`); colours by a finite pattern, possibly periodic in one direction. **What the image cannot
represent:** data outside a quadratic tower (a disc whose radius generates a non-2-power extension); non-circular boundaries; tilings not given by a
finite formula. **The strip's free parameters against the rule's:** none — every length is fixed by "width 1/2", "radius 1 centred at the opposite
corner" and "distance 1 … to the opposite corner"; the colour pattern is Fig. 4's. So the strip calibrates what it contains (arcs of kind both at
four-colour centres, straight self-contacts at diameter 1, outer segment contacts at gap 1) and nothing else.

### 2.1 The checker — `tools/fs112_y_check.py` [tools, exact]

A field is a tower; an element of level `k` is `a + b√d_k` with `a, b` of level `k − 1`; the sign is exact by recursion (`sign(a + b√d)` from
`sign a`, `sign b` and `sign(a² − d b²)`). The geometry is FS110-Y's candidate list, made generic (every candidate distance `|√A + B|`, `A, B ∈ F`);
`closure_type` computes `P_cl` exactly; a float partition guard (never a verdict) samples a period for overlaps and holes. Calibration
(`tools/fs112_y_calibrate.py`; outputs `data/fs112/fs112-y/calibrate_*.out`), in the claim list's order:

| # | object | pairs examined / present | verdict | against |
|---|---|---|---|---|
| 1 | FS-110's S1, T2, BB, MX, WC, WC1, WCEQ, WCH, WC1H, A6-C2, A6-C2 tip→2, A6-C2 plant deep, S1 plant `s1_flat`, T2 plant `t2_flat` — built by FS-110's own builders (imported, unedited), converted to the tower `Q(√3)` | 390 / 390 (generated from each colour map, self pairs included) | 6 REJECT pairs where the frozen checker has them, **0 disagreements pair by pair** | `tools/fs110_y_check.py` |
| 2 | CAL-7: the tight hexagonal 7-colouring, side 1/2; side 11/20; the index-4 colouring | 7, 7, 13 | ACCEPT, REJECT, REJECT | as wanted |
| 3 | **CAL-STRIP** (§1.3), columns −4…7 | **60 / 60** ordered same-colour pairs with `T` in one period and horizontal gap `≤ 1` (exact rational extents; a window twice as wide adds none) | **ACCEPT** | the printed Thm 4.2 |

### 2.2 CAL-STRIP, read off the exact object

- Height `2(√3/2 + √15/4) = √15/2 + √3` **exactly** (in `Q(√3, √5)`). Every tile has diameter exactly 1; the checker's `closed_interval` plant
  REJECTs **all 60 pairs**: every same-colour pair within reach touches at exactly 1 — the strip is tight everywhere it could be.
- Float partition guard, one period: 4,896 samples, 0 overlaps, 0 holes.
- **Contact kinds:** 22 unit arcs read in columns −1…4; every one is centred at a midline vertex with `|P_cl| = 4` and is of kind **both**
  (Y112-STRIP-KINDS). `P_cl` exact: `P_1` `{1,2,4,5}`, `P_2` `{1,3,4,6}`, `W` `{2,3,4}`, `V₀` `{1,3,5}`, `A₁` `{2,4,6}`, `W′` `{1,5,6}`.
  So CAL-STRIP calibrates self in-contact **and** out-contact, at four-colour centres; it holds no inert arc, no in-only or out-only arc, and no
  unit-arc centre with three colours.
- Y112-EDGE's identities exact: `|Q − V₀| = |Q − A₁| = |P_1 − V₀| = |P_1 − A₁| = 1`, `|V₀ − A₁|² = (9 − 3√5)/4`.
- **CAL-PLANT**, each beside the faithful strip (which ACCEPTs), each firing for its named reason: `tall` (`H/2 + 1/100`) → REJECT at exactly the six
  C/D self pairs (diameter > 1); `flat` (shared arcs → chords) → 24 REJECT pairs, all `(C, B)` or `(D, A)` (each top tile reaches inside the unit disc
  of its out-contact centre); `swap` (the colours of `C_j`, `j ≡ 1, 2`, exchanged) → REJECT at `(B_0, C_1)`, `(B_2, C_2)` only, each holding a swapped
  tile. Checker plants: `closed_interval` REJECTs all 60 (tightness); `noself` on `tall` → ACCEPT (it loses exactly the self REJECTs); `cw_arcs` →
  42 REJECTs; `endpoints_only` → ACCEPT: **unreachable on this object** (it can only lose REJECTs and the faithful strip has none), so it tests
  nothing here — it was tested on FS110-Y's controls.
- **E7 scored (plan §5.3):** rebuilt by formula and accepted: met; "carries out-contacts": met (all 22 arcs).
- **The three REJECT causes** (§1.6) were not needed: no REJECT occurred.

### 2.3 Card W (FS112-A2, "where your two stage-1 chain walks disagree") — my verdicts again [hand, one mind]

**W1 — NB-4's corrected exception.** (i) **Yes, an arc of `ω(v)` that ends at an orbit point must be named, per orbit.** NB §2.3's first move ("every
change point `y` is a swap with `σ_v y` and `σ_v^{-1}y`") needs the points of `ω(v)` near `σ_v^{±1}y` to be tile-interior; if an arc of `Γ` on `ω(v)`
contains or ends at `σ_v^{±1}y` (or at `y`), the 60° constraint `c(θ + 60°) ≠ c(θ)`, which binds tile-interior points only, forces nothing there. In the
strip every orbit of change points of `ω(P_1)` meets an arc end: the orbit of `0°` (change points `P_2`, `P_0`) at `σ^{±1}P_2 = W, W′` (ends of arcs of
`ω(P_1)`); the orbit of `arccos(1/4)` at `A₁` itself; the orbit of `180° − arccos(1/4)` at its apex. (ii) **Yes, the alternation uses
`|P_cl(y_k)| ≤ 4`:** with `P_cl(y_k) = {e, f, i_k, o_k}` the four half-arcs of `ω(y_{k±1})` at `y_k` lie in `{i_k, o_k}`, one inner and one outer, and
consecutive pairs `{i_k, o_k}` are disjoint 2-subsets of `P_cl(v)`. A fifth colour at `y_k` lets the two inner half-arcs carry two colours and breaks
the disjointness. And `|P_cl(y_k)| ≥ 5` needs the tile-interior set `S ⊂ ω(y_k)` to satisfy `S ∩ (S + 60°) = ∅` (one colour for all of it), so
`Γ ∩ ω(y_k)` must have measure `≥ 180°`. **Corrected statement** (Y112-NB4-MIS): *a four-colour vertex needs, in every `σ_v`-orbit of change points,
(α) an arc of `Γ` on `ω(v)` containing an orbit point, or (β) an arc of `ω(y_{k±1})` along `Γ` at some `y_k`, or (γ) `Γ`-arcs of total measure `≥ 180°`
on some `ω(y_k)`.* Both walks' forms are special cases; the "arc of `ω(y)` through `y`" of the printed form is empty. **TRUE at one mind.**

**W2 — W-MERGE: I retract my GAP; it holds as written** (with "Condition 5 kept" vacuous). A unit arc of `ω(v′)` through `v` (`v′` a `c`-contact at
`v + n`) has tangent `a` at `v`, on the boundary line of the contact's half-plane, so it can bound a sector of `G` only at an end of `G` on `∂D_c(v)`,
where the adjacent `c`-sector is a horn along `a`. An in-type contact puts that horn inside `B̄(v′, 1)` (Siamese with the `c`-tile at `v′`) and `G` on
the `+n` side above it; an out-type contact puts the horn outside `B(v′, 1)` and `G` on the `−n` side below it (a horn outside `B(v′,1)` against an
in-type tile would straddle 1). Either way the unit arc bounds the horn on its far side from `G`, `cl R ∩ ω(v′) = {v}`, and `D_c(v′)` is unchanged.
A `G` lying between a horn and the tangent line across a unit arc needs a second horn along `a` on its other side — MERGE-RAY's case, not W-MERGE's.
**Retraction 1 (free, counted).**

**W3 — N4-RAY: I retract; it holds as written.** RAY reads (1) the stack's outermost curvatures `κ₁`, `κ₄` only to say a unit circle through `t`
leaves the stack, (2) that no unit circle through `v` tangent to `a` passes through `t` (those are `ω(N)`, `ω(S′)`, the stack's outer boundaries;
`t` is strictly inside), and (3) the boundary arcs of `M`, the inner boundaries of the two `c`-horns. Those have curvatures strictly between the
stack's outer ones, which lie in `[−1, 1]`, so strictly inside `(−1, 1)`: step (3)'s "different curvature" holds, and a curvature-1 circle through
`t` rises above `M`'s top (relative curvature `1 − κ_M > 0`) within `O(|t − v|)`, long before `∂B(v, ρ)`. Step (1) as printed ("outside
`[κ₁, κ₄]ρ²/2`") fails at `κ₄ = 1`, but the argument needs only `M`'s boundaries. **Retraction 2 (free, counted).** FLANK at `κ = ±1` stands as
before (both walks agree).

**W4 — the base's circles, from `plans/FS110-CB-verification.md` D1–D5 (lines 89–193):**
- **D1 (P′), l. 94–98:** `ω(y)` near `x` for every unit pair `(x, y)` the chain uses ("each meets `ω(y)` finitely (Condition 5)");
- **D2, l. 105–109:** `ω(u + e)` for every `e ∈ Ω`, i.e. every unit circle through `u` ("which move with δ because no arc from u lies on a unit circle
  (Condition 5)"): the exception is **a boundary arc leaving `u` that is a unit arc, centred on `ω(u)`**; l. 115: `Ω = ω(u)` itself (finitely many
  `|c′| = 2` points); l. 118–120 ((i)/(ii)): `ω(y)` at `x` and `ω(x)` at `y` for pairs `x ∈ ω(u₁)`, `y ∈ ω(u₂)`;
- **D3–D4, l. 124–158:** `ω(u₁)`, `ω(u₂)` and the partner circles `ω(x(t))` along the bicycle;
- **D5, l. 170–193:** `Ω`; item 3 `ω(w)` for `w = x ± 60°` on `Ω`; item 5 `ω(x_{i±1})` at `x_i` and `ω(z)` for `z` near `x_i`; item 6 (P′) at the pigeonhole pairs.
So the other walk is right and my row 13 understated: **the base reads every unit circle through `u` (D2), `ω(u)`, and `ω(y)` at each unit pair it
uses.** Its exceptions: unit arcs centred at `u` or `v`; **unit arcs leaving `u` or `v` (centred on their circles)**; unit arcs of `ω(y)` at the pair
points. **The strip realises the second at both ends of Cor. 3's configuration:** every boundary arc at `V₀` and at `A₁` is a unit arc centred at a
midline vertex on their circles (`P_0`, `P_1`; `P_1`, `P_2`), and the directions where D2's six directions fail to move are exactly those of the
four-colour vertices — the same places. **Row 13's verdict: (b), with the exception list above.**

**W5 — P17's exception is of kind both** (I retract "out-contact for g"; **retraction 3**). N3 §2.4 confines the sector across the `ω(x₂)`-tangent
ray at `x₁` to `B̄(x₂, 1)` because it is Siamese with `x₂`'s `q`-tile, so `q ∈ P_cl(x₂)`; the arc of `ω(x₂)` at `x₁` has inner colour `q ∈ P_cl(x₂)`
(in-contact; self if one tile holds both) and outer colour `g ∈ P_cl(x₂)` (out-contact): **both**. One mind.

**W6 — the held positives at each (b)/(c) step's own reading radius** (killing test 8; C-BEYOND):

| step | reading radius | CAL-STRIP (exact) | FS-110's fragments | CAL-DISK (printed words only) |
|---|---|---|---|---|
| 1 NB-4 | `ω(v)` (1), `ω(y_k)` whole (2) | realises exception (α) at `P_1` with the whole of `ω(P_1)` coloured; reaches radius 1.834 about `P_1`, **not 2**: the top of `ω(y_k)` for `y_k` near `90°` leaves the strip | T2, BB, MX: four-colour `w, w′` with rings uncoloured (flowers of radius 1/10): cannot reach radius 1 | a `{1,3,5,6}` junction "at 2 o'clock on the central tile" (`[16.106]`): would reach NB-4's radius 2 only if it lies within 0.124 of the centre — unknown until rebuilt |
| 2 NB-5 | near `w₀` on `ω(u)`, `ω(v)`; NB-4 at `w₀` | realises (`W, W′`) saved at both seams, whole rings of `P_1`, `P_2` coloured; not radius 2 about the seams | S1 (out), T2 (both at `d = 1`), BB, MX: open-ended, near `w₀` only | not decidable from words |
| 5 N3-DEG, 6, 7, 11, 17 (`κ = ±1`) | `ω(v)`, `ω(N)`, `ω(S′)` | no horns: cannot realise | WC family: horn radii 2, 3 (`κ` strictly inside): cannot realise | — |
| 8 N4-STUCK | `B(v, 2)` and along PROP | no stuck vertex (no colour has two sectors) | WCH is STUCK (iv) truncated, `κ` inside `(−1, 1)` | — |
| 10 N4-TERM "cubic" | as 4, 7, 8 | **realises**: terminal and degree 4 at every midline vertex | — | — |
| 12 P17 | `ω(u)`, `ω(x_{i±1})` | the valleys' and apices' rings leave the strip (`ω(V₀)` reaches `√3/2 + 1 > H/2`): cannot reach | — | — |
| 13–16 base | every unit circle through `u`, `ω(u)`, `ω(y)` at pairs | realises D2's exception (unit arcs leaving `V₀`, `A₁`) and Cor. 3's point configuration, **not** the circles `γ(V₀)`, `γ(A₁)` need (they leave the strip at `Q`'s height), and its escape at `P_1` is non-cubic | — | — |

**What W6 says about C-BEYOND for the strip:** every step the strip breaks, it breaks within radius 1.834 of a midline vertex; every step it cannot
reach needs a circle about a valley or apex, which leaves the strip exactly at the top edge — the same place as Y112-EDGE's `Q`.

### 2.4 Retractions this stage: 3 (W2, W3, W5), all free (nothing built on them).

### 2.5 Left for a successor (my context is at its limit; brief § Rules)

1. **CAL-DISK** in three separated steps (owner's ruling: transcribe `[Polymath2021]` Fig. 10's combinatorics by eye first; report ambiguity, never
   resolve it by a solver): render p. 199's figure from `~/source/library/geombinatorics/geombinatorics-v30-n4-2021-04.pdf`, list tiles, adjacencies,
   unit arcs and their centres against `[11.34]`'s five-pentagon skeleton and `[16.346]`'s dual rule; then the exact system in the tower
   `Q(√5)(√(10 + 2√5))` (or larger if the radius demands; `r² = (25 + 9√5)/10` is not a square there — checked by hand), the checker already generic.
2. **The dial (E6):** grow an arc-closed patch past `√15/2 + √3`: the obstruction to beat is Y112-EDGE's `Q` (change the sectors at `V₀` or `A₁`).
3. **A `κ = ±1` horn fragment** (N3-DEG's exception, out-contact at `N`): WC with the horn's upper arc on `ω(N)`; it is the first object that can reach
   steps 5–7, 11, 17.
4. **§6's killing tests:** C-UA-CHAIN — the strip already carries a bi-infinite periodic zigzag chain of unit arcs (arcs meeting at valleys and apices),
   valid in the strip: every local monotone quantity along it is periodic (a reading of the exact object, one mind; the closed cycle of E10 not built);
   C-UA-WEDGE as literally stated ("the `c`-tiles at `P` face the arc") is **MISSTATED** for the outer side colour: in the strip the outer colour's
   tile at `P_1` (`B_0`, colour 4, directions `[180°, 270°]`) faces away, as TS-U says (one mind); C-UA-BUDGET's second branch ("the arcs sit on
   `ω(σ_v^{±1}y)`") fails at `P_1`, which has covering pairs at `P_1 ± (1, 0)` and all its arcs on `ω(P_1)` (one mind; exact object). C-HOCK on A6-C2's
   radius-9/10 arc (seconds, in-ban).

## Stage 2 — SAVED

# § Continuation — FS112-Y2

*Job FS112-Y2, de Bruijn on Opus 5.5, launched 2026-09-27 at HEAD `6cf6bdeb`. Brief: `data/fs112/briefs/Y2-112-construction-continued.md` with
`data/fs112/briefs/Y112-construction.md` and `STANDING-RULES.md`. I continue Y's record here and never rewrite a verdict above; where I disagree with one I
say so in this section. Working files: `data/fs112/fs112-y/` (prefix `y2_`); tools `tools/fs112_y2_*.py`. Every fragment is **a local fragment, not a map**.*

## Y2 — Theorems this phase proved

| id | statement (one line) | grade | address |
|---|---|---|---|
| Y2-NB4 | NB-4 corrected (supersedes Y112-NB4-MIS's (γ)): a four-colour vertex `v` needs, in every `σ_v`-orbit of change points `y₀…y₅`, (α) an arc of `Γ` on `ω(v)` containing or ending at an orbit point, or (β) an arc of `ω(y_{k±1})` along `Γ` at some `y_k`. Off (α), (β): `P_cl(y_k) ∩ P_cl(v)` is exactly a 2-set, so `|P_cl(y_k)| = 4` is a consequence of the alternation, not an input; the proof reads only `ω(v)` and neighbourhoods of `v` and the `y_k`: radius `1 + ε` | hand, one mind (mine), agreeing with the proof side's two minds on the bound (card X3) | §3.2 |
| Y2-X4 | the strip realises the Q-rule's (S2) with arcs, exactly and arc-closed: the covering pair `(P_1, P_3)` (distance 1, types `{1,2,4,5}`, `{1,3,4,6}`) at the valleys `W`, `W′`, and `(P_1, P_2)` (distance `1/2`, `{1,2,4,5}`, `{2,3,5,6}`) at the apexes `A_1`, `A′_1`: at each seam point each circle has one half-arc along `Γ` (an arc ending at the seam) and the other in a tile whose colour belongs only to the other point | tools, exact | §3.5 |
| Y2-D3 | FS112-Y's checker ACCEPTs CAL-7's brick (row 33's), REJECTs YB's two plants at the same pairs, and certifies its tightness at the same three contacts; 0 disagreements with FS112-YB's checker pair by pair | tools, exact | §3.3 |
| Y2-D4S | FS112-Y's strip object passes FS112-YB's checker (exact meeting test, no map hypothesis): 60 of 60 pairs ACCEPT, 0 distinct same-colour tiles meet, 60 exact contacts | tools, exact | §3.3 |
| Y2-D6 | the strip's arc count is 24 in columns −1…4; Y's 22 is a window effect (the right arcs of `A_4`, `B_4`, whose outer tiles `C_5`, `D_5` lay outside Y's tile window) | tools, exact | §3.4 |
| Y2-X2 | the unit circles about the strip's unit-arc end vertices leave it exactly through edge vertices: `ω(V_0)` crosses the top line at `(±1/4, top)`, reaching `1 − √15/4 ≈ 0.0318` above; `ω(A_0)` at `(−1/4, top)`, `(3/4, top)`, `≈ 0.1340` above | tools, exact | §3.6 |

## Y2 — Fence log

1. At start-up `ls data/fs112/briefs/` (with `wc -c`) printed the **file names and sizes** of the fenced briefs (A112, A2-112, A3-112, N112, N2-112,
   NB112-instance, NB112-verify-proof, P112, PA112, YB112-instance, YB112-verify-construction); none was opened. A listing of a fenced directory's names: logged.
2. My scratch directory is `scratchpad/fs112-y2/` (its `ls -la` printed only `.` and `..`); nothing else in the shared scratchpad was listed or opened.

## Y2 — Would-have-searched-here log

- CAL-DISK transcription (stage 4): I would have fitted Fig. 10's vertices to pixels; instead each vertex is defined by a rule read from the figure's
  topology and the printed skeleton, and pixel positions (Fig. 10 rendered at 400 dpi) were used only to recognise which skeleton point a tile corner is
  (each recognition checked by eye to about 2 % of a unit, never adjusted). Disclosed in §4.

## Stage 3 — SAVED: quotation check; card X part 1; housekeeping (A3-2.3 item 0)

### 3.1 Read from disk; quotation check

Read: `STANDING-RULES.md` (rule 0 first), `CLAUDE.md` § The aim and § Counter-priors (at `6cf6bdeb`; link 2 differs from my context's snapshot by one
sentence of attribution), Y's brief and mine, this record in full (stages 1–2, §2.5), Y's and YB's reports, `plans/FS112-YB-verification.md` in full,
`data/fs112/claims.md` in full, the plan's §1.3, §G part 3, §PA, §IQ, stage 5 (§5.1–5.7 and the addendum; §5.3 is open to my side since Y's stage 1),
`plans/FS112-PA-reading.md` stages 3–6 (the disk's skeleton `[11.34]`), `plans/FS110-NB-verification.md` §2.1–2.5 (NB-4's proof, for X3), the tools
`tools/fs112_y_check.py`, `fs112_y_calibrate.py` (strip and kinds), `fs112_yb_check.py` (header, field, pair verdict), `fs112_yb_calib.py` (the brick),
`[Polymath2021]` pp. 197–199 (text) and Fig. 10 (PDF p. 36, rendered at 150, 400 and 800 dpi).
**Quotation check (standing rule 5).** My brief's two block quotations (card X part 1, `data/fs112/fs112-a3/card-X.md`; A3-2.3, the advisor's record)
come from sources fenced for me: **not checked**, logged. The quotations my brief inherits from Y's are re-checked at today's HEAD by Y's tool
(`python3 tools/fs112_y_quotes.py`): 33 found, 0 missing. X3's summary of my side ("`|P_cl(y_k)| ≤ 4` … unit arcs of total `≥ 180°` on some `ω(y_k)`")
matches this record's §2.3 W1 (ii).

### 3.2 X3 — W1 (ii) re-derived with the neighbours' circles in view [hand, one mind]: **I retract (γ); the bound is a consequence**

Setting (NB §2.3): `P_cl(v) = [6] ∖ {e, f}`; off (α) the ring of `ω(v)` is two-coloured `{e, f}` near each orbit point, every change point `y_k` a swap,
`e, f ∈ P_cl(y_k)` for every `k`. At `y_k` four half-arcs start: two of `ω(y_{k+1})` (tangents `θ_k + 30°` outward, `θ_k + 210°` inward) and two of
`ω(y_{k−1})` (`θ_k + 330°` outward, `θ_k + 150°` inward). Off (β) each is tile-interior near `y_k` (isolated points aside). Write `H_k^±` for the colours on
the half-arcs of `ω(y_{k±1})` at `y_k`, `H_k = H_k^+ ∪ H_k^−`.
1. `H_k^± ∩ P_cl(y_{k±1}) = ∅` (A-CIRC: tile-interior points of `ω(y)` avoid `P_cl(y)`), so `H_k ⊆ [6] ∖ {e, f} = P_cl(v)`; and `H_k ⊆ P_cl(y_k)` (they are
   tiles at `y_k`).
2. Each `H_k^±` holds an **inner** colour (its half-arc enters `B(v, 1)`) and an **outer** one, distinct: a colour of `P_cl(v)` with a tile meeting `B(v, 1)`
   has its tiles at `v` facing `y_k`, one with a tile outside `B̄(v, 1)` facing away (N-E2), and a sector at `v` cannot do both. So `|H_k^±| ≥ 2`.
3. **The step X3 asks for:** `H_{k+1}^−` lies on `ω(y_k)`, so `H_{k+1}^− ∩ P_cl(y_k) = ∅`. Then `P_cl(y_k) ∩ P_cl(v) ⊆ P_cl(v) ∖ H_{k+1}^−`, a set of at most
   `4 − 2 = 2` colours, and it contains `H_k^+`, of at least 2. **So `P_cl(y_k) ∩ P_cl(v) = H_k^+ = H_k^− = H_k`, a 2-set, and `P_cl(y_k) = {e, f} ∪ H_k`.**
   A third colour of `P_cl(v)` at `y_k` would leave at most one colour for `H_{k+1}^−`, against step 2 at `y_{k+1}`. Nothing about `ω(y_k)`'s `Γ`-trace is used.
4. Hence `H_k ∩ H_{k+1} = ∅`, the pairs alternate `{A, B}`, `{C, D}`, and NB's count finishes (each colour confined to `60°` at `v` by the half-planes of
   `y_0, y_2, y_4`, `240° < 360°`).
**Verdict:** the other side is right (card X3's "two minds"); my W1 (ii) and Y112-NB4-MIS's clause (γ) are **withdrawn as unnecessary**: (γ) is implied by
nothing and needed by nothing — a fifth colour at `y_k` is already excluded off (β) at `y_{k±1}`. **Y2-NB4** (table above) replaces Y112-NB4-MIS. Its
reading radius is `1 + ε` about `v` (ω(v), and neighbourhoods of `v` and of the `y_k`): card X2's question for NB-4 has the answer "inside every strip
about a midline vertex", and the strip's `P_j` sits in its exception (α) there (§2.3 W1 (i), unchanged). **Retraction 4 (free; nothing built on (γ)).**

### 3.3 D3 and D4 on held objects (`tools/fs112_y2_house.py brick ystrip`; `data/fs112/fs112-y/y2_house.out`) [tools, exact]

| object | pairs examined / present | FS112-Y's checker | FS112-YB's checker | disagreements |
|---|---|---|---|---|
| CAL-7, row 33's brick (YB's builder, imported) | 11 / 11 (cell `(0,0)` with itself and each same-colour cell `|i|,|j| ≤ 4`; YB's exact gap bound dismisses the rest) | ACCEPT | ACCEPT | 0 |
| plant: colour `(i + 2j) mod 7` | 11 / 11 | REJECT at `(−2, 1)`, `(2, −1)` | same | 0 |
| plant: cell `81/100 × 3/5` | 11 / 11 | REJECT at the self pair | same | 0 |
| CAL-7 under `closed_interval` | 11 / 11 | contacts at 1: the self pair, `(±1, ±2)` | same | 0 |
| Y's strip object, converted exactly into YB's field `ℚ(√3, √5)` | 60 / 60 (Y's population) | ACCEPT | ACCEPT; exact meeting test: no two distinct same-colour tiles meet; 60 contacts at 1 | 0 |

So D3 is met (Y's checker now calibrated on the named brick, not only the hexagonal 7-colouring) and D4's model divergence is closed on the strip: YB's
exact meeting test confirms, on Y's own object, the map hypothesis Y's verdict assumed.

### 3.4 D6 reconciled (`arcs` section) [tools, exact]

Y's reading keyed each arc by (centre, endpoints) over tiles of columns −1…4 and kept an arc only when **both** its tiles were in that window. The right arcs
of `A_4` and `B_4` are shared with `C_5` and `D_5`, outside it: 24 − 2 = 22. Read with outer tiles from columns −1…5: **24 arcs, all kind both, every
centre `|P_cl| = 4`**. The plant `--plant arcs_window` (Y's window) returns 22 with exactly `A_4`, `B_4` missing their outer tile.

### 3.5 X4 on the strip: **confirmed at the valleys and at the apexes** — filed as a seam realisation (`x4` section) [tools, exact]

X4's reading: T2 at a pair `(u, v)` with seam points `w₀, w₀′` may be the Q-rule's (S2) with arcs at the other diagonal pair `(w₀, w₀′)`. On the strip:
- **Valleys.** The rhombus `P_1 W P_3 W′` (`W = (1, √3/2)`): T2 at `(W, W′)` (Y112-T2-SQRT3) is, read at the other diagonal, the covering pair `(P_1, P_3)`
  (distance 1, types `{1,2,4,5}`, `{1,3,4,6}`, overlap `{1,4}`) saved at `W` (`P_cl = {2,3,4}`, trivalent) and `W′` (`{1,5,6}`).
- **Apexes** (YB's thin rhombus): the covering pair `(P_1, P_2)`, `P_2 = (1, 0)` (distance `1/2`, `{1,2,4,5}`, `{2,3,5,6}`, overlap `{2,5}`) saved at
  `A_1 = (3/4, √15/4)` (`{2,4,6}`) and `A′_1` (`{1,3,5}`).
At each of the four seam points, exactly: **each of `ω(u)`, `ω(v)` has one tangent direction that starts an arc of `Γ` on that circle (the arc of the arch
ending at the seam point) and the other inside a tile whose colour belongs only to the other point** — e.g. at `W`: `ω(P_1)` starts `A_1`'s right arc
(to `A_1`) and runs into `A_2` (colour 3 ∈ `P_cl(P_3)` only); `ω(P_3)` starts `A_2`'s left arc and runs into `A_1` (colour 2 ∈ `P_cl(P_1)` only); and every
tile at the seam lies on one side of `ω(x)` for each `x` holding its colour (the arches inside, the top tile outside). **This is the (S2)-with-arcs pattern
"one arc of each circle ending at the seam", realised exactly and arc-closed** (the arcs' other ends are the apexes and valleys, interior to the strip) —
a pattern claim list §1 records as "GAP at every pattern but N-X's". The plant `x4_wrongpair` (W asked for `(P_1, P_2)`, not its pair) fails for its own
reason: `W ∉ ω(P_2)`, and two tangent tiles carry colours of both points. **So on the strip T2 and (S2)-with-arcs are one configuration seen from its two
diagonals** (X4 TRUE on the strip; one mind, exact). Whether that identity holds in every tight map is not claimed.

### 3.6 X2 on the exact strip (`x2` section) [tools, exact]

- The strip's unit-arc end vertices are the valleys and apexes. Their unit circles leave the strip **exactly through edge vertices**: `ω(V_0)` meets
  `y = top` at `(±1/4, top)` and rises `1 − √15/4 ≈ 0.0318` above it; `ω(A_0)` meets it at `(−1/4, top)` and `(3/4, top)` and rises `1 − √3/2 ≈ 0.1340`
  above. Each crossing point is an edge vertex with two colours. The midline vertices' circles stay inside (height 1 < 1.834).
- Per step (with W6 of §2.3): **NB-4 corrected** reads radius `1 + ε` about `v` — inside the strip at `P_j`, where its exception (α) is realised. **NB-5** reads
  NB-4 at the seam points: at `P_j` inside the strip; at a valley or apex seam point (X4's patterns) the step's circles `ω(u)`, `ω(v)` are midline circles,
  inside. **P17, the base (13–16), CUSP-BASE**: every configuration they forbid that the strip holds (same-type trivalent pairs, YB's `C-CHAIN-14` row)
  needs the circle of a valley or apex, which leaves the strip exactly at the edge vertices above it — the same points as Y112-EDGE's `Q`.
- **The forbidden configurations inside the strip are all at four-colour vertices or their seams; every one outside is reached only through the edge
  vertices.** This is C-BEYOND for the strip, now exact on both halves.

## Stage 3 — SAVED

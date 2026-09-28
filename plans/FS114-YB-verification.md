# FS114-YB — blind verification of FS-114's construction side (the capped strip, the disk, the moved disk; the printed geometries' rigidity; statements about every valid map)

*Job FS114-YB, de Bruijn on Opus 5.5, launched early on 2026-09-28 (UTC) at HEAD `d96e60e4`. Brief: `data/fs114/briefs/YB114-verify-construction.md`;
instance `data/fs114/briefs/YB114-instance.md` (read from disk, uncommitted at start); `data/fs114/briefs/STANDING-RULES.md`. Every object is rebuilt from
its rule in words and checked by my own exact checker (`tools/fs114_yb_exact.py`), written without reading any FS114-Y file; FS-112's tools are run as
they are, never edited. Stage 1 (my verdicts) is committed before I open `plans/FS114-Y-construction.md`, `data/fs114/fs114-y/` or `tools/fs114_y_*`.*

## Theorems this phase proved

The full tables are at the end of stage 1c (thirteen lines) and of stage 2 (two lines). In one line each:
- YB114-CHK [tools] — an exact segment-and-arc checker over towers of square roots; five plants fire as predicted; five held objects accepted (1b).
- YB114-CAP [tools, exact; second mind, blind] — the capped strip is valid and holds `B̄(P_j, R)` for every `R < φ²/√2`, attained only at the edge vertices (1c §1).
- YB114-EDGE-SPOT [tools, exact] — FS112-EDGE's cone at `Q_0` confirmed at 13 exact points (1c §1).
- YB114-PENT [tools, exact + hand over COR3; second mind] — PENT, every clause; C114-PENT's first question: no (1c §2).
- YB114-ROUTES [tools, exact; second mind] — ROUTES at named points; its region-wide reading false at 3 of 11 points (1c §3).
- YB114-STRIPK6, YB114-STRIPRIGID, YB114-DISKRIGID [tools + hand; second mind, different routes] (1c §§4–6); YB114-LOCAL: the nine tiles at `B_k` do not force complementarity (1c §6).
- YB114-PAIRSHARE, YB114-K6 [hand over COR3; second mind] (1c §§7–8).
- YB114-DUAL [hand] — C114-DUAL-COUNT corrected: `2n + 2p₅ + 6p₆` distinct emitted unit arcs of kind both; the opposite tile is never the emitting edge-neighbour (1c §9).
- YB114-RB3 [hand + tools, exact] — C114-RAINBOW corrected (trichotomy); its third case realised on an exact valid fragment (1c §10).
- YB114-ERB, YB114-RB1 [hand; second mind] — C114-EDGE-RAINBOW; C114-REDBLOCK's first clause (1c §11).
- YB114-SAME, YB114-THEIRPTS [tools, exact] — the rebuilds equal the side's objects; the side's 18 ROUTES points reproduce exactly (2).

## Would have searched here (standing rule 3)

- Stage 1: the four entries at the end of stage 1c.
- Stage 2: none (the side's objects compared by their builders; their named points rebuilt by their formulas).

## Fence log (standing rule 13; brief § Rules)

- Start-up: `ls data/fs114/` listed directory **names**, among them the fenced `fs114-n`, `fs114-nb`, `fs114-y`, `reports`, and `ls data/fs114/briefs/`
  listed the brief **file names** (among them fenced briefs); nothing in any fenced directory was listed, opened or grepped, and no fenced brief was
  opened. The start-up `git status` (harness snapshot) showed the untracked names `data/fs114/fs114-nb/`, `tools/fs114_nb_count.py`,
  `tools/fs114_nb_quotes.py` — names only, not opened.
- `git log --oneline -5` at start-up (the snapshot's own five subjects); no further `git log`, no `git log -p`.
- Stage 2 (after `8ac5aa39`): FS114-Y's record, tools and `routes.out` opened as listed in stage 2's header; plan §5.3 read. Nothing of the proof
  side (`plans/FS114-N-proof.md`, `data/fs114/fs114-n*`, `tools/fs114_n*`), of CV, of FS-111, of the close inventory or of `data/fs114/reports/` other
  than my own report file was opened, listed or grepped; BASE-V's record was not needed and not opened.

## Stage 1a — SAVED: reading; the quotation check

### 1a.1 Read from disk, in this order

`STANDING-RULES.md` (rule 0 first); my brief and instance file; `CLAUDE.md` § The aim, § Counter-priors, G83, G79, G71, G46, G22, G21, G20, G51 (from the
session's load of the file at start-up); `LEDGER.md` rows 133–136 in full; `data/fs114/claims.md` in full; `plans/FS114-unit-arc-question.md` §G part 3,
§PA, §IQ and stage 5b (**not 5.3**); the construction side's brief `data/fs114/briefs/Y114-construction.md` in full (its § Reading's sources: FS-112's
§4 and records as below; the Google group thread `Z50mmulkXCQ` at the posts of 2020-09-13, 2020-10-17, 2021-06-27 and 2022-05-01, and the claim
list's `J_Tw1_hUxQI` sentences by grep); `plans/FS112-derivation.md` §4 in full; `plans/FS112-YB-verification.md` stages 3–4 (the strip's rebuild);
`plans/FS112-YB2-verification.md` stages 1–4 (the disk's transcription and formula, YB2 labels); `plans/FS112-Y-construction.md` §§4–5.3 and 6.2–6.3
lines 400–600 (the disk's rules and tiles in **Y2's labels**, which the instance uses: `T1_k`, `T2_k`, `R_k`, `U_k`, `U′_k`, `Z^L_k`, `Z^R_k`); the data
layout (constructors only) of `tools/fs112_yb2_check.py` (`Seg`, `Arc`), `tools/fs112_yb2_objects.py` (`Strip`, `Disk` docstring) and
`tools/fs112_yb3_frags.py` (`bowtie`), so that held objects can be converted and compared; `Proofs/HadwigerNelson/Instances/Seven.lean`'s header (the
brick). Not read: FS-112's checker logic (pair and sign code), which my checker does not borrow.

**Labels used below.** The strip: YB's (`P_j = (j/2, 0)`, arch `U_j` over `[j/2, (j+1)/2]`, valley `V_m = (m/2, √3/2)`, apex `A_j = (j/2 + 1/4, √15/4)`,
top tile `T_m` over `V_m`, inverted arch `D_j`, bottom tile `B_m`), with the instance's `Q_m = (m/2 + 1/4, Y)`, `Y = √3/2 + √15/4`, the top corner
shared by `T_m` and `T_{m+1}`. The disk: Y2's (`plans/FS112-Y-construction.md` §4.1–4.4).

### 1a.2 The quotation check (standing rule 5) — `tools/fs114_yb_quotes.py`, `data/fs114/fs114-yb/quotes.tsv`, output `quotes.out`

20 quotations: the standing rules' five Kooshi quotations; the claim list's Sirgedas quotations I verify (C114-DUAL-COUNT, C114-EDGE-RAINBOW's
"Degree 6 …", C114-REDBLOCK's four, the degree-4 sentence), de Grey's Siamese definition, and the FS-112 statements my verdicts rest on (FS112-N3-COR3,
FS112-C-PARTNERS, FS112-N3-NOBOTH, the definition of a valid map, FS112-N3-DENSE3, FS112-DISC) and `[Polymath2021]` p. 194's tactic (PDF p. 30, text
layer). **20 of 20 FOUND** under the tool's stated normalisation (typographic quotes unified; backticks and `**` dropped; whitespace collapsed).
`--self-test`: an altered word turns FOUND into MISSING (`quotes-selftest.out`). One punctuation point, not a paraphrase: standing rule 4's Kooshi
quotation ends "a success." with a period inside the quotation marks; `CLAUDE.md` (Frontier item 23) has none — the words are exact.

**The instance file's statements** are quoted from FS114-Y's record, which is fenced until my stage 1 is committed; their quotation check is stage 2's
first step. **No paraphrase found in my brief.** One reading point, recorded before any verdict: the instance's statement 3 names `C_0 + e(72°)/100`;
with Y2's placement the colourless cone at `C_0` after the move is `(54°, 90°)` (FS112-MOVE), so 72° lies in it.

## Stage 1a — SAVED

## Stage 1b — SAVED: my exact checker, its controls and plants, and its calibration on the five held objects

**The checker** `tools/fs114_yb_exact.py` (written for this job; no FS114-Y file and no FS-112 pair or sign code read). *Arithmetic:* towers of
quadratic extensions `ℚ(√d₁)…(√d_n)`, an element of level k a pair `a + b√d_k`; **the sign exact by recursion** (`sign a` when `b = 0`, `sign b` when
`a = 0`, the common sign when they agree, `sign(a)·sign(a² − b²d)` when they differ — true of real numbers even if a radicand is a square lower
down); equality is sign 0; inversion raises rather than guess. *Verdict* for two tiles of one colour (a tile with itself included): **REJECT iff
m < 1 < M**, m and M the exact minimum and maximum distance between the closed tiles, decided from a complete list of realised candidate pairs —
every critical point of the squared distance on (piece) × (piece): endpoint pairs, an endpoint against a segment's foot or an arc's two radial
points, a segment against an arc along the segment's normal through the centre, two arcs on their line of centres (radial and antipodal pairs when
concentric) — plus an **exact intersection test** of every two pieces (a crossing gives m = 0 where no critical candidate need lie). Every candidate
is `√S` or `|√D + k|` in the tower and is compared with 1 exactly. No map hypothesis. *Points:* a point straddles a tile iff min < 1 < max over the
closed tile, inside-ness by an exact ray count (retried on any degeneracy); a colour is free at a point iff no tile of that colour straddles it.

**Self-test** (`python3 tools/fs114_yb_run.py selftest`, `data/fs114/fs114-yb/selftest.out`; exit 0): exact arithmetic checks (√2's bounds,
`√(3+√2)²`, inversion), eight controls (a Reuleaux triangle of width 1; rectangles of diagonal 0.99 and 1.06; squares at gap 9/10 and exactly 1; two
long bars crossing with every critical candidate ≥ 1.9; a unit cap facing a bar, nearest pair 0.9 interior to both; the same against a wide bar,
where only the interior–interior pair is below 1), and **five checker plants, each flipping exactly the controls predicted in the code before the
first run**: `noself` → the 1.06 rectangle; `closed_interval` → the two tight controls; `no_intersect` → the crossing bars; `endpoints_only` → both
cap controls; `no_interior` → the wide-bar control only. The point routine: a straddle, and the ray count inside the Reuleaux triangle's bulge.

**Calibration** (`python3 tools/fs114_yb_run.py calib`, `data/fs114/fs114-yb/calib.out`, under `scripts/slot.py --mem 2 --cpus 1`; about 45 s).
Every object plant's rejected pairs were written down before the run (the disk's `swap` prediction is Y2's, re-derived here by hand: `U_0`, made
yellow, is within `L ≈ 0.786` of `A_0 ∈ T1_4`; `U′_0`, made purple, holds `X_0` at `L` from `A_1 ∈ T1_1`).

| object | built from | pairs the object has / examined exactly / dismissed by an exact bounding-box gap ≥ 1 | verdict | tight at 1 | plant beside the faithful twin → rejected pairs (all as predicted) |
|---|---|---|---|---|---|
| brick (row 33) | `Seven.lean`'s words: `4/5 × 3/5`, shear `2/5`, colour `(i + 3j) mod 7`; cell (0,0) against the window `|i|, |j| ≤ 5` | 17 / 3 / 14 | **ACCEPT** | the cell's diagonal; the cosets `(±1, ±2)` | cells `1/2` wide (mine) → exactly `(0,0)|(−3,1)`, `(0,0)|(3,−1)` |
| hexagonal 7-colouring | side `1/2`, centres `q a₁ + r a₂`, colour `(q + 3r) mod 7`, in `ℚ(√3)` | 11 / 3 / 8 | **ACCEPT** | the diameter | side `11/20` → exactly the hexagon with itself |
| the strip | FS-112's rule (YB's words, stage 3 of `plans/FS112-YB-verification.md`), in `ℚ(√3)(√5)`; the 12 tiles of a period against columns −9…11, orbit pairs under the colour period `3/2` | 90 / 24 / 66 | **ACCEPT** | 12 self-maxima, 12 out-contact minima; the 12 like tiles three columns apart are the pairs dismissed at gap exactly 1 (36 in all, YB's count) | `U_0` recoloured G → exactly `(U0,U−2)`, `(U0,B0)`, `(U0,U1)` (YB's) |
| the disk | Y2's rules (`plans/FS112-Y-construction.md` §4), tower `ℚ(√5)(√(10+2√5))(√(1/φ))(r)` | 71 / 52 / 19 | **ACCEPT** | 26 self-maxima (every tile of diameter exactly 1), 20 minima (the 20 unit arcs' out-contacts); `closed_interval` shows exactly those 46 | `swap` → exactly `(T1_4,U_0)`, `(T1_1,U′_0)`; `chords` → exactly the five `(T1_k, T2_{k+3})` |
| FS112-BOWTIE | FS112-YB3's builder (imported, never edited), converted exactly (over ℚ) | 21 / 18 / 3 | **ACCEPT** | 2 maxima, 4 minima; `closed_interval` shows exactly six (YB3's) | `h_is_g` → exactly `(G, H)` (touching at `E`) |

Map consistency (exact): the disk, 125 pieces, every non-rim piece shared by exactly two tiles in opposite directions, 15 rim pieces; the strip's
base period, 54 of 60 pieces shared with a window tile, the other 6 on `y = ±Y`. Float guards: the disk's 26 areas sum to `πr²` (14.176314892); the
strip's 12 base areas to period × height (5.502813721). **Identities of the disk's rule: 87 of 87 exact**, among them `B_k = E_{k+1}` ("connected"),
`r² = (25 + 9√5)/10 = φ²(15 + √5)/10`, `|Z^L_kD_k| = |Z^R_kC_k| = 1`, `B_k` on the ray of `u_k`, and **`A_k + A_{k+1} − B_k = A_{k+3}`** (PENT's last
clause, exact, all five k).

**Against FS-112's held builders** (`python3 tools/fs114_yb_compare.py`, `compare.out`; FS112-YB2's `fs112_yb2_objects.py` imported and run, never
edited): **26 of 26 disk tiles and 36 of 36 strip tiles (columns −3…5) match a held tile piece for piece** (ends, centres, radii to 1e-9) **and colour
for colour**. Label map, mine (Y2's) → FS112-YB2's: `C0→Z`, `T1_k→P_k`, `T2_k→W_k`, `R_k→R_k`, `U_k→S_k`, `U′_k→T_{k+1}`; the strip's labels coincide.

## Stage 1b — SAVED

## Stage 1c — SAVED: my verdicts on the instance's eleven items (blind: no FS114-Y file opened)

*Outputs: `data/fs114/fs114-yb/capped.out`, `capped-float.out`, `pent.out`, `move.out`, `straddle-strip.out`, `straddle-disk.out`, `local-b0.out`,
`rainbow.out`; drivers `python3 tools/fs114_yb_run.py capped|pent|move|straddle-strip|straddle-disk|rainbow` (code in `tools/fs114_yb_run2.py`).
Grades as `CLAUDE.md` § Notation; "mine" is one mind.* **Erratum to stage 1b** (my own wording): "every object plant's rejected pairs were written
down before the run" — they were derived by hand before the run, in my working notes, and not committed before it; the self-test's plant
predictions were in the code before its first run.

### Summary of verdicts

| # | item | verdict | grade, minds |
|---|---|---|---|
| 1 | the capped strip | **TRUE** — valid; holds `B̄(P_j, R)` for every `R² < (7 + 3√5)/4`, the distance from `P_j` to the fragment's boundary being exactly `φ²/√2`, attained only at the four edge vertices `Q_{j−1}, Q_j` (top and bottom); the half "no valid extension … at `R ≥ φ²/√2`" TRUE over FS112-EDGE, whose cone I confirm at 13 exact points | [tools, exact; mine] + [hand over FS112-EDGE, two minds there] |
| 2 | PENT | **TRUE**, every clause (geometry exact, the exclusion over FS112-N3-COR3); and C114-PENT's first question is answered **no** by the same count | [tools, exact] + [hand over COR3]; mine |
| 3 | ROUTES | **TRUE as stated ("at named points")**, with a precision: the free set is exactly the cut tile's colour at 8 of my 11 points, and **not throughout** `T2_0 ∩ B(C_0,1)` or `T1_0 ∩ B(C_0,1)` (purple free near `Z^L_0`, green near the side `X_4Z^R_0`, blue at `B_0 + (3/10, −1/50)`); one own-colour-only point in the region to be recoloured suffices for the route's failure | [tools, exact; mine] |
| 4 | STRIPK6 | **TRUE** | [tools, exact] + [hand over COR3]; mine |
| 5 | STRIPRIGID | **TRUE** | [hand over exact straddle facts]; mine |
| 6 | DISKRIGID | **TRUE**; "near any `B_k`" holds for the **whole** disk's geometry, **not** for the nine tiles at `B_k` and its two partners (one non-straddling cross pair per partner) | [tools, exact] + [hand: a 20-step forced propagation, no branching]; mine |
| 7 | PAIRSHARE | **TRUE** | [hand over COR3]; mine |
| 8 | K6 | **TRUE** | [hand over COR3]; mine |
| 9 | C114-DUAL-COUNT | **MISSTATED** as the claim list states it (it drops Sirgedas's own premise "only triangles and quadrilaterals"); TRUE under that premise; corrected form below | [hand]; mine |
| 10 | C114-RAINBOW | **MISSTATED**: a third case occurs; the corrected trichotomy is TRUE, and the third case is realised on an exact valid fragment | [hand] + [tools, exact]; mine |
| 11 | C114-EDGE-RAINBOW; C114-REDBLOCK first clause | **TRUE**; **TRUE** (with "Siamese" read as de Grey's words say: two tiles of one colour at maximum distance ≤ 1) | [hand]; mine |

### 1. The capped strip [tools, exact; one rebuild and one checker, mine]

**Rule and rebuild.** FS-112's strip (stage 1b, matched to FS112-YB2's builder tile for tile) with each top tile `T_m`'s top segment `Q_mQ_{m−1}`
replaced by the unit arc about its valley `V_m` from `Q_m` to `Q_{m−1}` (`|V_m − Q_m| = |V_m − Q_{m−1}| = 1`, asserted exactly by the arc's
constructor), bottom tiles by the mirror image; colours unchanged. Tower `ℚ(√3)(√5)`.
**The capped self-pairs first:** `T0, T1, T2, B0, B1, B2` each against itself: **ACCEPT, maximum exactly 1** (a cap point's distance to `V_m` is 1;
`|A_{m−1} − Q_m| = |A_m − Q_{m−1}| = 1`). Float guard, 400 samples per piece: sampled diameters 1.000000000000 (`capped-float.out`).
**Every orbit pair** (the 12 base tiles against columns −9…11, orbits under the colour period `3/2`): **ACCEPT — 90 orbit pairs, 24 examined
exactly, 66 dismissed by an exact bounding-box gap ≥ 1** (tiles beyond the window are ≥ 3 away in `x`); tight at 1: 12 self-maxima, 12 minima (the
out-contacts `T_m|D_{m+1}`, `T_m|D_{m−2}` and mirrors); the like tiles three columns apart are dismissed at gap exactly 1 — the caps keep
`x ∈ [m/2 − 1/4, m/2 + 1/4]` — so the caps add **no new contact**. `closed_interval` shows exactly the 24 examined tight pairs.
**Plant beside the faithful twin:** `cap_bulge` (arcs of radius 5/12 through the same two corners, centre `(m/2, Y − 1/3)`) → REJECT at exactly the
six capped self-pairs, as predicted (the cap's top at `Y + 1/12`, beyond distance 1 from `V_m`); under the checker plant `noself` the same object
ACCEPTs — the self-pairs carry the verdict.
**The disc.** Every candidate distance from `P_j` (`j = 0, 1, 2`) to every cap of the window, top and bottom, against `R₀ = √((7 + 3√5)/4)` exactly
(tower extended by `R₀`): **none below `R₀`; eight equal to it**, all cap ends — the points `Q_{j−1}`, `Q_j` and their mirrors, each the end of two
caps. `|P_1 − Q_0|² = (7 + 3√5)/4 = φ⁴/2` exactly. The fragment's boundary is the two chains of caps (the strip is unbounded sideways), so
`B̄(P_j, R)` lies in its interior for every `R < φ²/√2 ≈ 1.8512`, and not for `R = φ²/√2`.
**The other half.** For `R ≥ φ²/√2` the closed disc holds `Q_{j−1}` and `Q_j`; an open set containing it holds a neighbourhood of `Q`, where, by
FS112-EDGE (no-colour step two minds, one blind; exact cone one mind), no extension of the strip's colouring has a colour in the open cone
`(arcsin ¼, 180° − arcsin ¼)` above `Q`. **My exact spot checks at `Q_0 + v`** (uncapped strip, 13 vectors): no free colour at 16.17°, 16.70°,
19.80°, 45°, 90°, 135°, 160.20°, 163.30°, 163.83°; orange free at 5.71° and 9.65°, red at 170.35° and 174.29° — exactly EDGE's cone, and the
caps of `T_1` (orange) and `T_0` (red) are what occupies the directions `(0°, 14.48°)` and `(165.52°, 180°)`: **the capped strip is the strip
extended by exactly the colourable part of those two side cones.** Verdict **TRUE**.
**Bearing:** C114-DIAL is met by the capped strip at every radius below `φ²/√2 ≈ 1.8512` about a four-colour vertex (the claim list's bound 1.834
rises to 1.8512 for C114-LOCAL-F and C114-LOCAL-FR), and `φ²/√2` is the exact limit for extensions of the strip.

### 2. PENT [tools, exact (`pent.out`) + hand over FS112-N3-COR3; mine]

For every `k`: `|B_k − Z^R_k|² = |B_k − Z^L_{k+1}|² ≈ 1.381966 < 4`; the eight unit distances `|B_kA_k|, |B_kC_k|, |Z^R_kA_k|, |Z^R_kC_k|,
|B_kA_{k+1}|, |B_kD_{k+1}|, |Z^L_{k+1}A_{k+1}|, |Z^L_{k+1}D_{k+1}|` are exactly 1, so (two unit circles meeting in at most two points)
`ω(B_k) ∩ ω(Z^R_k) = {A_k, C_k}` and `ω(B_k) ∩ ω(Z^L_{k+1}) = {A_{k+1}, D_{k+1}}`, **four distinct points**; exactly `Z^R_k = A_k + C_k − B_k` and
`Z^L_{k+1} = A_{k+1} + D_{k+1} − B_k` (the rhombi); the colours at `B_k`, `Z^R_k`, `Z^L_{k+1}` (tiles whose boundary holds the point, exact) are
three each and complementary (e.g. `B_0` {orange, purple, yellow}, both partners {blue, green, red}); `B_k` has three boundary curves, two unit arcs
centred `A_{k+1}` and `A_k`, one segment; and **`A_k + A_{k+1} − B_k = A_{k+3}`**, a four-colour vertex. **The exclusion:** by COR3 both common unit
points of each pair are leaving centres of `B_k` (centres of unit arcs ending at `B_k`); a cubic vertex has at most three (one per boundary curve);
four distinct points are needed — so no valid map agrees with the disk near `B_k, Z^R_k, Z^L_{k+1}`, and no third unit-arc boundary at `B_k`, nor
any choice of the three curves, repairs it (three curves give at most three centres). **C114-PENT's first question** ("can the trivalent `B_k` … be
given a third unit-arc boundary whose completions are exactly their complementary partners"): **no** — with leaving centres `{A_k, A_{k+1}, w}` the
completions are `A_{k+3}` (not a partner) and `A_k + w − B_k`, `A_{k+1} + w − B_k`; `Z^R_k` needs `w = C_k`, `Z^L_{k+1}` needs `w = D_{k+1}`, and one
`w` cannot be both. Verdict **TRUE**.

### 3. ROUTES on the moved disk [tools, exact (`move.out`); mine]

The moved disk (FS112-MOVE: `R_k`'s straight sides replaced by the unit arcs of `ω(C_k)` from `Z^R_k` to `D_k` and of `ω(D_k)` from `C_k` to `Z^L_k`,
the lenses to `R_k`): **ACCEPT, 71 of 71 same-colour pairs (52 exact, 19 dismissed), 26 + 20 tight contacts** — FS112-MOVE's validity confirmed.
At `z₀ = C_0 + e(72°)/100` **no colour is free**, each colour blocked by exactly one tile: blue `T2_0`, green `U′_4`, orange `T1_0`, purple `U_0`,
red `R_0`, yellow `U′_0`. So **the only blue straddler is `T2_0` and the only orange one `T1_0`: TRUE.**
Free sets with the cut tile ignored, at my own points (each checked exactly to lie in the tile and inside `B(C_0,1)`):

| cut tile | point (exact) | `|z − C_0|²` | free |
|---|---|---|---|
| `T2_0` | `A_0 + (9/10)(Z^L_0 − A_0)` | 0.5156 | blue |
| `T2_0` | `(Z^L_0 + Z^R_0)/2` | 0.5955 | blue |
| `T2_0` | `A_0 + ½(Z^L_0 − A_0) + ¼(Z^R_0 − A_0)` | 0.8602 | blue |
| `T2_0` | `Z^R_0 + (−3/100, −1/100)` | 0.9642 | blue |
| `T2_0` | `Z^L_0 + (A_0 − Z^L_0)/100` | 0.3944 | **blue, purple** (`U_0` does not straddle it) |
| `T2_0` | `A_0 + (97/100)(Z^R_0 − A_0) + (2/100)(Z^L_0 − A_0)` | 0.9865 | **blue, green** |
| `T1_0` | `B_0 + (1/20, 0)`, `B_0 + (1/10, ∓1/100)`, `B_0 + (1/5, 0)` | 0.916–0.972 | orange |
| `T1_0` | `B_0 + (3/10, −1/50)` | 0.9430 | **blue, orange** |

**Verdict: TRUE as stated** ("at named points"): at named points of each region the free set is exactly the tile's own colour, and since the part
of the cut tile inside `B(C_0, 1)` is what the route must recolour, **one such point suffices for the route to fail** (a point with no other free
colour cannot change colour). **Precision:** the regions are not uniformly own-colour-only — near `Z^L_0` purple is free (a Siamese extension of
`U_0`), near `T2_0`'s side toward `X_4` green is free, and deeper in `T1_0` blue is free — so a reading of ROUTES as "every point of the region can
only keep its colour" is FALSE (3 of my 11 points). The route's failure does not depend on that reading. Not examined: the other way of cutting
(recolouring the part of the tile outside `B(C_0,1)` and keeping the inside) — the statement does not claim it.

### 4. STRIPK6 [tools, exact (`straddle-strip.out`) + hand over COR3; mine]

On the strip's geometry (36 tiles of columns −3…5, 630 pairs, exact): for `m = 0, 1, 2`, `{U_{m−1}, U_m, T_m, U_{m+1}, T_{m+1}, T_{m+2}}` **pairwise
straddle** (and the mirror six). `|V_0 − A_1|² ≈ 0.5729 < 4`; `|V_0 − Q_0| = |A_1 − Q_0| = |V_0 − P_1| = |A_1 − P_1| = 1` exactly, so the pair's
common unit points are `P_1` and `Q_0`; `V_0`'s three boundary curves are a segment and unit arcs about `P_{−1}` and `P_1` — **none on `ω(Q_0)`**.
Under every colouring the six get six colours, so `V_m` and `A_{m+1}` are complementary cubic trichromatic vertices at distance `< 2`; COR3 then
makes `Q_m` a leaving centre of `V_m`, which none of its curves allows. **TRUE**: no valid map contains these six tiles, under any colouring.

### 5. STRIPRIGID [hand over the exact straddle facts of `straddle-strip.out`; mine]

Facts used (exact, for `m = 0, 1, 2`, hence all `m` by the translation `x ↦ x + 1/2`, which preserves the geometry): (a) the upper six-cliques
`K(m) = {U_{m−1}, U_m, U_{m+1}, T_m, T_{m+1}, T_{m+2}}` and their mirrors; (b) `U_{m+2}` straddles `T_m` (and `D_{m+2}` straddles `B_m`); (c) `U_j`
straddles `D_{j−2}, …, D_{j+2}`; (d) `T_m` straddles `D_{m−1}`, `D_m` and not `D_{m+1}`; `B_m` straddles `U_{m−1}`, `U_m` and not `U_{m+1}`.
**Derivation.** `K(m)` and `K(m+1)` share `U_m, U_{m+1}, T_{m+1}, T_{m+2}`, so `{c(U_{m+2}), c(T_{m+3})} = {c(U_{m−1}), c(T_m)}`, and (b) excludes
`c(U_{m+2}) = c(T_m)`: so `c(U_{m+2}) = c(U_{m−1})` and `c(T_{m+3}) = c(T_m)` — the upper half is fixed by `K(0)`'s six colours, arches on a palette
`A`, tops on its complement. The same below: inverted arches on a palette `A′`, bottom tiles on its complement. By (c) `c(U_j)` avoids the three
colours of `D_{j−1}, D_j, D_{j+1}` (distinct, in a lower clique), i.e. all of `A′`; so `A′` is the top palette and the bottom palette is `A`. By (d),
`c(T_m) ∉ {c(D_{m−1}), c(D_m)}` forces `c(T_m) = c(D_{m+1})`, and `c(B_m) = c(U_{m+1})`. Every tile's colour is thus a function of `K(0)`'s labelling:
**every valid colouring is `[AxenovichEtAl2014]`'s up to a permutation of the six colours** (which satisfies all of it, CAL-STRIP). **TRUE.**

### 6. DISKRIGID [tools, exact (`straddle-disk.out`, 325 pairs) + hand; mine]

`C0, T1_0, …, T1_4` **pairwise straddle** (a six-clique). Each other tile misses exactly: `T2_k` — only `T1_{k+2}`; `R_k` — `C0` and three `T1`'s;
`U_k`, `U′_k` — three `T1`'s each. **Forced propagation from the clique, 20 steps, no branch** (each step: the tile straddles tiles of five distinct
determined colours): `T2_k` ≡ `T1_{k+2}`; then `R_k` ≡ `C0` (it straddles `T2_k`, `T2_{k+1}` and two `T1`'s…); then `U_k` ≡ `T1_{k+1}`; then
`U′_k` ≡ `T1_{k−1}` — all 26 determined, **the same-colour classes identical to the printed colouring's**. So every valid colouring is the printed one
up to a permutation, PENT's complementarity holds under every colouring, and **no valid map contains the disk's geometry** (all 26 tiles). **TRUE.**
**Precision (`local-b0.out`):** the nine tiles at `B_0`, `Z^R_0`, `Z^L_1` do **not** force complementarity by themselves: each triple straddles
internally, but `(U′_0, U′_4)` (between `B_0`'s and `Z^R_0`'s tiles) and `(U_0, U_1)` (between `B_0`'s and `Z^L_1`'s) do not straddle. So "near any
`B_k`" holds with "the disk's geometry" read as the whole disk (or a set through which the propagation passes), not as the tiles at `B_k` and its
partners.

### 7. PAIRSHARE [hand over FS112-N3-COR3; mine]

A **leaving centre** of `u` is the centre of a unit arc with endpoint `u` (`plans/FS112-N-proof.md` l. 725); a cubic `u` has three boundary curves,
each on at most one unit circle, so at most three leaving centres `W`. For a close complementary cubic trichromatic partner `u′` (`0 < d < 2`),
`ω(u) ∩ ω(u′)` is exactly two points, and by COR3 both lie in `W`. Distinct partners `u′ ≠ u″` give distinct two-point subsets of `W` (the two
points determine the partner: `u′ = q₊ + q₋ − u`); two distinct 2-subsets of a set of at most three points meet. **TRUE.** (The same pigeonhole is
FS112-C-PARTNERS's proof; PENT is its contrapositive at `B_k`.)

### 8. K6 [hand over COR3; mine]

Six tiles pairwise straddling get six distinct colours in every valid colouring, so `u`'s three are distinct (trichromatic), `u′`'s likewise, and
the two sets are disjoint: complementary; with `d < 2`, COR3 makes each of the two common unit points a leaving centre of both. **TRUE** (a design
screen that needs no colouring: STRIPK6 is its instance).

### 9. C114-DUAL-COUNT [hand; mine]

**Setting.** A doubly periodic valid map with no Siamese pair (distinct tiles of one colour at minimum distance ≥ 1), every tile with five
edge-neighbours; `n` tiles per period. (i) *Rainbow:* a tile and its edge-neighbours have six distinct colours (item 11), so each other colour
appears exactly once among a tile's neighbours. (ii) *Vertices:* tiles meeting at a map vertex `v` have distinct colours (touching same-colour tiles
are Siamese), so `v` has `d ≤ 6` tiles, `d` colours. (iii) *Emission:* let `v` have tiles `t_1…t_d` in cyclic order, `d ≥ 4`, and `t_j` not adjacent
to `t_i` around `v`. Then `t_i`'s unique edge-neighbour `s` of colour `c(t_j)` satisfies `s ≠ t_j`, `s ∩ B(v,1) = ∅` (non-Siamese against `t_j ∋ v` in
closure) and `t_i ⊂ B̄(v,1)` (diameter ≤ 1), so **the whole common boundary of `t_i` and `s` lies on `ω(v)`: a unit arc centred at `v`, of kind both**
(`v` carries `c(t_i)` and `c(s) = c(t_j)`). `s ≠ t_j`: were `t_j` an edge-neighbour of `t_i`, a closed curve through `v` inside `cl t_i ∪ cl t_j ⊂
B̄(v,1)` would enclose a tile `t_k` at `v`; `t_k`'s neighbour of the colour of a tile `t_l` at `v` on the other side is neither `t_l` (separated by the
curve) nor `t_i`, `t_j` (other colours), so it is enclosed, inside `B̄(v,1)`, and non-Siamese against `t_l` puts it outside `B(v,1)`: an open tile on
a circle, impossible. (iv) *Distinct:* an arc on two unit circles has at most two points, and at one `v`, `s` cannot be a tile at `v`. (v) *Count
(torus):* with five sides per tile, `E = 5n/2`, `V = 3n/2`, `Σ(d − 3) = n/2`, i.e. `p₄ + 2p₅ + 3p₆ = n/2`; a vertex of `d` tiles emits `d(d − 3)`,
so the emitted edges number `4p₄ + 10p₅ + 18p₆ = 2n + 2p₅ + 6p₆`.
**Verdict: MISSTATED** as the claim list states it. **"Emits" must mean (iii)**, and then every emitted edge is a unit arc centred at the emitting
vertex, of kind both. **Corrected:** *the emitted unit arcs are pairwise distinct and number `2n + 2p₅ + 6p₆` per period, so at least 80% of the
edges are unit arcs; exactly `2n` (the quads' `4·(n/2)`) iff no vertex has five or six tiles* — which is Sirgedas's own premise in the quoted post
("Assuming the graph has only triangles and quadrilaterals", `Z50mmulkXCQ`, 2022-05-01), dropped by the claim list; under it the statement is
TRUE. In general the quads alone emit `2n − 8p₅ − 12p₆`. **Precision:** the count uses five *sides* per tile (each pair of edge-neighbours sharing one
edge); two tiles sharing two separate edges are not excluded by (i)–(iv).

### 10. C114-RAINBOW [hand + tools, exact (`rainbow.out`); mine]

**Derivation.** Two faces `n₁, n₂` of one colour both meet `cl x`. If one is `x`, they touch, so validity forces maximum ≤ 1: Siamese. Otherwise, with
contact sets `K_i = cl n_i ∩ cl x`, every `p₁ ∈ K₁`, `p₂ ∈ K₂` has `|p₁ − p₂| ≤ diam x ≤ 1`, so the minimum distance is ≤ 1 and validity leaves:
maximum ≤ 1 (Siamese), or minimum = 1 with **every** cross distance `|p₁ − p₂| = 1`. In the latter, if `K₁` holds an arc of positive length, `K₂` lies
on the unit circles about all its points, hence is one point `q` and `K₁ ⊂ ω(q)` — the unit-radius tactic; else **both contact sets are finite and
every cross pair is at distance exactly 1** (e.g. the two ends of a diameter of `x`). **Verdict: MISSTATED; corrected:** *Siamese, or the unit-radius
tactic (one face shares a unit arc of `ω(q)` with `x`, the other meets `cl x` only at `q`), or both meet `cl x` only in finite sets at mutual distance
exactly 1* — TRUE [hand]. **The third case is realised** by an exact valid fragment by formula on the closed disc of radius 3/5 about `(1/2, 0)`
(seven convex polygons over ℚ covering `[−1/5, 6/5] × [−7/10, 7/10]`: `x` the rhombus `(0,0), (1/2, ±1/10), (1,0)` of diameter exactly 1; colour-2
triangles `n₁` at `(0,0)` pointing left and `n₂` at `(1,0)` pointing right, meeting `cl x` only at those corners; four more tiles of colours 3–6):
**ACCEPT, 8 same-colour pairs, 7 examined exactly, 1 (`n₁|n₂`) at minimum exactly 1**; no arc anywhere. So no argument reading a disc of radius 3/5
excludes the third case; whether it occurs in a valid map is as open as the maps.

### 11. C114-EDGE-RAINBOW and C114-REDBLOCK's first clause [hand; mine]

**EDGE-RAINBOW: TRUE.** If one face is `x`, it and the other touch, so maximum ≤ 1 (Siamese). Otherwise shared arcs `α₁ ⊂ cl n₁ ∩ cl x`,
`α₂ ⊂ cl n₂ ∩ cl x` of positive length give cross distances ≤ `diam x ≤ 1`, so the minimum is ≤ 1; minimum = 1 would put `α₂` on the unit circles
about two points of `α₁` (at most two points): so maximum ≤ 1, Siamese. **Reading:** "Siamese" as de Grey's words (`[10.59]`: tiles within each
other's exclusion annulus, i.e. maximum distance ≤ 1); under the narrower gloss "the two meet at a vertex" the statement is FALSE (two small
same-colour tiles on opposite sides of a small `x` need not touch). The claim list's C114-SIRGEDAS-FORM gloss "no Siamese pair (every vertex of
`R(M)` absent)" has the same one-way gap: no Siamese pair implies no `R(M)` vertex, not conversely.
**REDBLOCK, first clause: TRUE.** With five neighbours per tile, each closed neighbourhood is six tiles of six distinct colours, so it holds exactly one
red tile; a red tile lies in its own block and in no other (two reds in one neighbourhood), a non-red tile in the block of the one red neighbour.

### Theorems this phase proved (stage 1)

| id | statement (one line) | grade, minds | address |
|---|---|---|---|
| YB114-CHK | an exact checker for segment-and-arc maps over towers of square roots, complete candidate list plus exact intersections; five checker plants fire as predicted; accepts the five held objects, 26/26 and 36/36 tiles matching FS112-YB2's builders | tools | stage 1b; `tools/fs114_yb_exact.py` |
| YB114-CAP | the capped strip is a valid fragment holding `B̄(P_j, R)` for `R < φ²/√2`, the bound attained only at the edge vertices | tools, exact; mine | §1; `capped.out` |
| YB114-EDGE-SPOT | FS112-EDGE's cone at `Q_0` confirmed at 13 exact points | tools, exact; mine | §1 |
| YB114-PENT | PENT, every clause; C114-PENT's first question answered no | tools, exact + hand over COR3; mine | §2; `pent.out` |
| YB114-ROUTES | ROUTES at named points; the region-wide reading false at 3 of 11 points | tools, exact; mine | §3; `move.out` |
| YB114-STRIPK6, -STRIPRIGID | as items 4, 5 | tools, exact + hand; mine | §4–5; `straddle-strip.out` |
| YB114-DISKRIGID, -LOCAL | item 6; the nine tiles at `B_k` do not force complementarity | tools, exact + hand; mine | §6; `straddle-disk.out`, `local-b0.out` |
| YB114-PAIRSHARE, -K6 | items 7, 8 | hand over COR3; mine | §7–8 |
| YB114-DUAL | C114-DUAL-COUNT corrected: `2n + 2p₅ + 6p₆` distinct emitted unit arcs of kind both | hand; mine | §9 |
| YB114-RB3 | C114-RAINBOW corrected (trichotomy); its third case realised exactly | hand + tools; mine | §10; `rainbow.out` |
| YB114-ERB, -RB1 | C114-EDGE-RAINBOW; C114-REDBLOCK's first clause | hand; mine | §11 |

### Would have searched here (stage 1)

- Object 1: I would have scanned radii for the largest disc about `P_j`; instead the exact candidate distances to the caps against `φ²/√2`.
- Object 3: I would have sampled `T2_0 ∩ B(C_0,1)` on a grid; instead eleven points named by formula (combinations of vertices), each exact.
- Item 6: I would have asked a colourer for every colouring of the disk's geometry; instead a forced propagation from the six-clique, 20 printed
  steps, no branching.
- Item 10: I would have searched for a configuration; instead one fragment written down by formula.

## Stage 1c — SAVED

## Stage 2 — SAVED: FS114-Y's record and tools read; the two rebuilds compared; every divergence

*Opened only after stage 1's commit `8ac5aa39`: `plans/FS114-Y-construction.md` in full; `tools/fs114_y_dial.py` (header, `CappedStrip`),
`tools/fs114_y_pent.py` (imports, `routes`), the function lists of `fs114_y_conflicts.py`, `fs114_y_insert.py`; `data/fs114/fs114-y/routes.out`;
`plans/FS114-unit-arc-question.md` §5.3. Outputs: `compare-stage2.out`, `routes-theirs.out`, `moved-partition.out`, `strip-rows.out`,
`quotes-instance.out`, `quotes-instance-diff.out`.*

### 2.1 The instance's quotations against FS114-Y's record (standing rule 5)

`tools/fs114_yb_quotes.py data/fs114/fs114-yb/quotes-instance.tsv`: **1 of 8 verbatim** (STRIPRIGID); the other seven are the owner's abridgements of
the record's table (word diff in `quotes-instance-diff.out`): DIAL drops "`= φ⁴/2 (R < φ²/√2 ≈ 1.85123)`" and "C114-DIAL met, marginally"; PENT turns
"— C114-PENT's first question answered **no**. The completion" into "; and"; ROUTES "straddler of" → "tile straddling", "its" → "the tile's"; STRIPK6
drops "`Q_m` the pair's second common unit point"; PAIRSHARE "have … in common" → "share"; K6 drops "A design screen, about every valid map:" into the
item's title. **One abridgement drops a load-bearing clause:** DISKRIGID's reason, in the record "the central tile and the five ring-1 tiles pairwise
straddle distance 1, **and each other tile, in a fixed order, then has exactly one colour left**", reads in the instance "(its central tile and five
ring-1 tiles pairwise straddle distance 1)" — the clique alone does not force the colouring (`R_k` misses `C0` and three ring-1 tiles, `U_k`, `U′_k`
three each; stage 1c §6). No verdict of mine used the abridged reason.

### 2.2 The rebuilds compared (label maps)

| object | my rebuild | FS114-Y's (or the object it runs) | agreement |
|---|---|---|---|
| the capped strip | `tools/fs114_yb_objects.py Strip(capped=True)` | `tools/fs114_y_dial.py CappedStrip` (FS112-YB2's strip with the cap swapped in) | **36 of 36 tiles** (columns −3…5) equal, same names and colours (vertex sets and arc circles to 1e-9); labels identical |
| the moved disk | `Disk(moved=True)` (Y2's labels) | FS112-Y2's `MovedDisk` (`tools/fs112_y2_dial.py`), which FS114-Y's `routes` runs | **26 of 26 tiles** match, colours included; labels identical (`U′` = `Up`) |
| the disk | `Disk()` | FS112-YB2's builder (FS114-Y's conflicts table runs it) | 26 of 26 (stage 1b); map `C0→Z`, `T1_k→P_k`, `T2_k→W_k`, `U_k→S_k`, `U′_k→T_{k+1}` |
| the strip's straddle rows | `U0`, `T0` against columns −7…9, exact (`strip-rows.out`) | FS114-Y §2.2's table ("`U_0` conflicts with `U_{±1}`, `U_{±2}`, `D_{−2…2}`, `T_{−2…3}`, `B_0`, `B_1`; `T_0` with `T_{±1}`, `T_{±2}`, `U_{−3…2}`, `D_{−1}`, `D_0`") | **identical** |
| ROUTES' named points | FS114-Y's 18 points rebuilt by their formulas in my tower, each checked exactly (`routes-theirs.out`) | `data/fs114/fs114-y/routes.out` | **identical free sets at all 18**; all 18 lie **exactly** in the tile named (their membership was a float guard) |

The moved disk's partition is exact on my side (`moved-partition.out`: every non-rim piece shared by two tiles in opposite directions; area sum
`πr²` to 1e-9).

### 2.3 Divergences, each with both addresses

| # | kind | FS114-Y | mine | resolution |
|---|---|---|---|---|
| D1 | **verdict (truth as stated)** | C114-DUAL-COUNT "**TRUE as stated**" (record, table FS114-Y-DUALCOUNT; §3.2; derivation §2.3 F3: "with only cubic vertices and quads, `n/2` quads") | **MISSTATED** (stage 1c §9) | the derivation carries a premise the verdict drops (Sirgedas's own, in the post quoted: "Assuming the graph has only triangles and quadrilaterals"). Without it the quads emit `2n − 8p₅ − 12p₆` and all emitting vertices `2n + 2p₅ + 6p₆`; whether five- or six-tile vertices occur in this class is not decided (a quick attempt here: the five tiles at such a vertex cannot fill `B(v,1)` alone, each being a sector of angle at most 60° if its outer boundary lies on `ω(v)` — so tiles of the sixth colour lie inside; no contradiction reached). **"TRUE as stated" is an over-grade**; "at least 80%" is TRUE in general |
| D2 | rigour (a gap closed) | the emission step "the tile opposite a tile `t` at `w` carries the colour of an edge-neighbour of `t`" (§2.3 F3) presupposes that neighbour is not the opposite tile itself | stage 1c §9 (iii): the opposite tile is never an edge-neighbour (an enclosure argument inside `B̄(v,1)` against the non-Siamese rule) | Y's step is TRUE; its missing justification is supplied |
| D3 | scope | RAINBOW corrected, case (ii): "both touch `x` only at single points, vertices of at least four colours" (table FS114-Y-RAINBOW; §3.1 says "in a non-Siamese map") | stage 1c §10: finite contact sets with every cross distance exactly 1 (a face may touch `x` at two points, both at distance 1 from the other's contact) | Y's (ii) is the one-point-each subcase; its "four colours" holds under Y's stated non-Siamese hypothesis, which the table's one-line statement drops ("or a repeated colour" otherwise) |
| D4 | an open item closed | "Not built: a fragment realising (ii)" (§3.1; successor item (3), §3.4) | **built**: the exact valid fragment of `rainbow.out` (radius 3/5), whose contact points `(0,0)`, `(1,0)` have four colours each and together all six — consistent with Y's covering-pair consequence | Y's further consequence (unit arcs on `ω(p)` by NB4P or FS112-SIX) reads the whole ring of `p`, radius 1, which my fragment does not hold: **untested**, and a fragment holding `B̄(p, 1+ε)` with no unit arc would test it |
| D5 | wording against own data | ROUTES' one-line statement: "at named exact points … the free set with the cut tile ignored is exactly its own colour" (table) | Y's own §1.3 data: `{Bl, P}` at two of its nine blue points (reproduced exactly); mine: a second free colour at 3 of my 11 points (purple near `Z^L_0`, green near `T2_0`'s side toward `X_4`, blue at `B_0 + (3/10, −1/50)`) | the route's failure stands (Y's own check is "some named point … within {Bl}"); the statement should say "at seven of nine named points of `T2_0` and all nine of `T1_0`" — the regions are not own-colour-only |
| D6 | grade | ROUTES' "named exact points": inside `B(C_0,1)` exact, **tile membership by a float polyline guard** | tile membership exact at all 18 of Y's points and my 11 | promoted: membership exact |
| D7 | tool defect (a frozen FS-112 guard, not a verdict) | `routes.out`: the guard `locate` (FS112-Y2's `tile_poly`) places `B_0 + s e(0)` in `['T1_0', 'R_4', 'U_4']`; Y recorded it as a guard artefact | exact: only `T1_0`, not on any boundary (`moved-partition.out`) | the polyline guard misplaces points on the moved disk (`R_4`, `U_4` lie in the opposite sector) — FS112-Y2's guard, not to be trusted as a membership test there |
| D8 | scope | F1: "no doubly periodic design contains a row of `[AxenovichEtAl2014]`'s arches, however the rows are stacked, shifted or recoloured" (§2.3) | STRIPK6 reads six tiles, three of them top tiles | F1 excludes maps containing the **six** tiles (three arches **and** the three top tiles over them); a row of arches with other tiles in its valleys is not in F1 |
| D9 | none (agreement, precision) | DISKRIGID "near any `B_k`"; F2 "the disk's tiles near some `B_k` … and those the rigidity chain reads"; "(The disk is not a clique argument: `T_0` and `T_1` may share a colour)" | the nine tiles at `B_0`, `Z^R_0`, `Z^L_1` leave `(U′_0, U′_4)` and `(U_0, U_1)` unforced (`local-b0.out`) | the same fact, from two sides (`U′_4`, `U′_0` are YB2's `T_0`, `T_1`) |
| D10 | minds (grade) | one mind on DIAL, PENT, ROUTES, STRIPK6, STRIPRIGID, DISKRIGID, PAIRSHARE, K6, EDGE-RAINBOW, REDBLOCK1 | each TRUE here, blind | **two minds, one blind** on each; different routes on STRIPRIGID (Y: four consecutive arches under three top tiles; mine: overlapping six-cliques) and DISKRIGID (different propagation orders), on DIAL's disc (Y: an identity; mine: exact candidates) and on the plants (`cap_high` vs `cap_bulge`, both firing at exactly the six capped self-pairs) |

**No divergence of mathematical truth** on any object or on any theorem Y states with its hypotheses; one **over-grade** (D1: TRUE as stated, on a
premise the verdict drops), one closed gap (D2), two scope corrections to one-line statements (D3, D5), one scope correction to a family (D8), one
promoted grade (D6), one open item closed (D4), one tool defect in a frozen FS-112 guard (D7).

### 2.4 The families that failed (brief item 3)

Y's C114-TORUS families (§2.3): **F1** — every map containing the strip's valley–apex six tiles; **F2** — every map containing the disk's tiles through
which the rigidity chain passes near some `B_k`; **F3** — Sirgedas's class, a budget, no verdict. **Free parameters against the configuration's.** F1
and F2 are not formula families with a finite parameter image: each member is "the configuration plus anything", the configuration fixed exactly
(zero free parameters), the rest unbounded — so G21's image question is moot: **the exclusion covers every member, because the obstruction reads
only the configuration and no colouring** (STRIPK6; DISKRIGID with PENT). **The reason each member fails is the reason Y gave**, verified here
blind (stage 1c §§4, 6), with D8's scope correction to F1's gloss and D9's precision to F2's. F3's count is D1's.

### 2.5 Registrations touched (for the close; I score none)

E6 (C114-RAINBOW TRUE as stated, 0.5): both sides MISSTATED — **not met**. E10 (the pentagon admits the third arc, 0.3): **not met** here too
(stage 1c §2). E11 (the dial beyond 1.834, 0.25): **met**, at two minds (`φ²/√2`). E15 (a blind verifier finds a divergence of truth, 0.6): **D1 is
the candidate** — a verdict "TRUE as stated" on a statement proved only under a dropped premise; I do not find a false mathematical statement in the
construction side's record. The owner scores it.

### 2.6 Proposed edits for the close (I edit none of these files)

- `data/fs114/claims.md`: C114-DUAL-COUNT — restore Sirgedas's premise ("only triangles and quadrilaterals") or state the corrected count
  (`2n + 2p₅ + 6p₆` emitted unit arcs, all distinct, each of kind both, centred at its emitting vertex); C114-RAINBOW — the corrected trichotomy
  (stage 1c §10); the gloss of C114-SIRGEDAS-FORM "no Siamese pair (every vertex of `R(M)` absent)" is one-way (no Siamese pair ⇒ no `R(M)` vertex,
  not conversely); C114-LOCAL-F's "any such `R` exceeds `√15/4 + √3/2 ≈ 1.834`" → "at least `φ²/√2 ≈ 1.8512`" (the capped strip).
- `LEDGER.md`: FS114-Y's DIAL, PENT, ROUTES (as D5 words it), STRIPK6, STRIPRIGID, DISKRIGID, PAIRSHARE, K6, EDGE-RAINBOW, REDBLOCK1 at two minds,
  one blind; DUAL-COUNT as corrected; RAINBOW's third case realised (`rainbow.out`).
- A tool note for FS112-Y2's `tile_poly` guard (D7).

### Theorems this phase proved (stage 2)

| id | statement | grade, minds | address |
|---|---|---|---|
| YB114-SAME | my capped strip, moved disk and disk equal FS114-Y's objects (and the FS-112 builders they run) tile for tile; Y's strip straddle rows equal mine | tools | §2.2 |
| YB114-THEIRPTS | all 18 of FS114-Y's ROUTES points lie exactly in the tile named; their free sets reproduce exactly | tools, exact | §2.2; `routes-theirs.out` |

## Stage 2 — SAVED

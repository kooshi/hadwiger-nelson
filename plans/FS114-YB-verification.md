# FS114-YB — blind verification of FS-114's construction side (the capped strip, the disk, the moved disk; the printed geometries' rigidity; statements about every valid map)

*Job FS114-YB, de Bruijn on Opus 5.5, launched early on 2026-09-28 (UTC) at HEAD `d96e60e4`. Brief: `data/fs114/briefs/YB114-verify-construction.md`;
instance `data/fs114/briefs/YB114-instance.md` (read from disk, uncommitted at start); `data/fs114/briefs/STANDING-RULES.md`. Every object is rebuilt from
its rule in words and checked by my own exact checker (`tools/fs114_yb_exact.py`), written without reading any FS114-Y file; FS-112's tools are run as
they are, never edited. Stage 1 (my verdicts) is committed before I open `plans/FS114-Y-construction.md`, `data/fs114/fs114-y/` or `tools/fs114_y_*`.*

## Theorems this phase proved

(Filled at the end of stage 1; one line per theorem, grade and address.)

## Would have searched here (standing rule 3)

- (stage 1) none yet.

## Fence log (standing rule 13; brief § Rules)

- Start-up: `ls data/fs114/` listed directory **names**, among them the fenced `fs114-n`, `fs114-nb`, `fs114-y`, `reports`, and `ls data/fs114/briefs/`
  listed the brief **file names** (among them fenced briefs); nothing in any fenced directory was listed, opened or grepped, and no fenced brief was
  opened. The start-up `git status` (harness snapshot) showed the untracked names `data/fs114/fs114-nb/`, `tools/fs114_nb_count.py`,
  `tools/fs114_nb_quotes.py` — names only, not opened.
- `git log --oneline -5` at start-up (the snapshot's own five subjects); no further `git log`.

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

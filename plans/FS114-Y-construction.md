# FS114-Y — the construction side of FS-114 (the unit-arc question)

*Job FS114-Y (de Bruijn, Opus 5.5), 2026-09-27, from the brief `data/fs114/briefs/Y114-construction.md` and `data/fs114/briefs/STANDING-RULES.md`
(both read in full, rule 0 first), with the owner's two notes (5.3 closed until this stage is committed; BASE-V reported, its record unfenced).
Working files `data/fs114/fs114-y/`; exact checks `tools/fs114_y_*.py`; my scratch `scratchpad/fs114-y/` (regenerable only). Every verdict here is
about a possible object: the class of valid maps is not known to be non-empty.*

## Theorems this phase proved

| id | statement (one line) | grade | address |
|---|---|---|---|
| FS114-Y-PAIRSHARE | In a valid map, any two close complementary cubic trichromatic partners `u′`, `u″` of a cubic trichromatic vertex `u` have a common unit point with `u` in common: `(ω(u) ∩ ω(u′)) ∩ (ω(u) ∩ ω(u″)) ≠ ∅` | [hand; one mind, over FS112-N3-COR3 (two minds, one blind)] | §1.3 |
| FS114-Y-PENT | On `[Polymath2021]` Fig. 10's disk (FS112-CAL-DISK) `B_k`'s two close complementary partners `Z^R_k`, `Z^L_{k+1}` meet `ω(B_k)` at four distinct points `A_k, C_k, A_{k+1}, D_{k+1}`; so no valid map agrees with the disk near `B_k, Z^R_k, Z^L_{k+1}`, and no third unit-arc boundary at `B_k` (nor any choice of arcs) repairs it — C114-PENT's first question answered **no**. The completion `A_k + A_{k+1} − B_k` is the central corner `A_{k+3}` | [hand + tools, exact; one mind] | §1.3; `tools/fs114_y_pent.py pent` |
| FS114-Y-ROUTES | On the moved disk (FS112-MOVE) the blue and orange routes to a fourth colour at `C_0` fail with the rest of the disk unchanged: the only blue straddler of `ω(C_0 + e(72°)/100)` is `T2_0`, the only orange one `T1_0`, and at named exact points of `T2_0 ∩ B(C_0,1)` and `T1_0 ∩ B(C_0,1)` the free set with the cut tile ignored is exactly its own colour | [tools, exact at named points; one mind] | §1.3; `tools/fs114_y_pent.py routes` |
| FS114-Y-DIAL | The strip with each top (bottom) tile capped by the unit arc about its own valley between its two top corners is a valid fragment, and it holds the closed disc `B̄(P_j, R)` about every midline four-colour vertex for every `R` with `R² < (7 + 3√5)/4 = φ⁴/2` (`R < φ²/√2 ≈ 1.85123`); no valid extension of the strip holds that disc at `R ≥ φ²/√2` (the disc then holds the stop point `Q`) — C114-DIAL met, marginally, above `≈ 1.834` | [tools, exact: 90 orbit pairs ACCEPT, plant fires at exactly the six capped self-pairs; the disc containment an exact identity, hand; the bound over extensions over FS112-EDGE; one mind] | §2.1; `tools/fs114_y_dial.py` |
| FS114-Y-STRIPK6 | In the strip's geometry the six tiles at a valley `V_m` (the arches `U_{m−1}`, `U_m` and the top tile `T_m`) and at the apex of `U_{m+1}` (`U_{m+1}`, `T_{m+1}`, `T_{m+2}`) pairwise straddle distance 1, so the two vertices are complementary under **every** colouring; `V_m`'s three boundary curves lie on `ω(P_{m−1})`, `ω(P_{m+1})` and a segment, none on `ω(Q_m)`, `Q_m` the pair's second common unit point; so by FS112-N3-COR3 **no valid map contains these six tiles, under any colouring** | [tools, exact relations; hand; one mind, over COR3's two] | §2.2; `tools/fs114_y_conflicts.py strip` |
| FS114-Y-STRIPRIGID | Every valid colouring of the strip's geometry is `[AxenovichEtAl2014]`'s, up to a permutation of the six colours | [hand over exact relations; one mind] | §2.2 |
| FS114-Y-DISKRIGID | Every valid colouring of the disk's geometry (`[Polymath2021]` Fig. 10, its 26 tiles) is the printed one up to a permutation of the six colours: the central tile and the five ring-1 tiles pairwise straddle distance 1, and each other tile, in a fixed order, then has exactly one colour left; so FS114-Y-PENT holds under **every** colouring: **no valid map contains the disk's geometry** near any `B_k` | [tools, exact relations; the chain of deductions asserted exact, each with one outcome; hand; one mind] | §2.2; `tools/fs114_y_conflicts.py disk` |
| FS114-Y-K6 | A design screen, about every valid map: if two cubic vertices `u`, `u′` at distance `< 2` have six incident tiles that pairwise straddle distance 1, they are complementary under every colouring, and each common unit point of `ω(u)`, `ω(u′)` must be a leaving centre of both (FS112-N3-COR3) — a geometry failing that is not part of any valid map, whatever its colours | [hand; one mind, over COR3] | §2.3 |
| FS114-Y-EDGE | C114-EDGE-RAINBOW TRUE: in a valid map, two faces of one colour that each share a boundary arc of positive length with a face `x` (either may be `x`) are Siamese; so a face with six or more edge-neighbours forces a Siamese pair (Sirgedas's "Degree 6 isn't possible with only 6 colors", for non-Siamese maps) | [hand; one mind] | §3.2 |
| FS114-Y-RAINBOW | C114-RAINBOW MISSTATED; corrected: two faces `T₁`, `T₂` of one colour meeting `cl x` are Siamese, or touch `cl x` at the two ends `p`, `q` of a diameter of `x` (`\|p − q\| = 1 = diam x`) and either (i) one shares a boundary arc with `x`, which then lies on the unit circle about the other's contact point (the tactic), or (ii) both touch `x` only at single points, vertices of at least four colours; in (ii) a unit arc is centred at `p` or `q`, or `(p, q)` is a covering pair — and then NB4P (four colours) or FS112-SIX (five or six) puts unit arcs on `ω(p)` or on circles about its ring points | [hand; one mind] | §3.1 |
| FS114-Y-REDBLOCK1 | C114-REDBLOCK's first clause TRUE: in a non-Siamese valid map in which every tile has five edge-neighbours, the red tiles' closed edge-neighbourhoods partition the tiles | [hand; one mind] | §3.2 |
| FS114-Y-DUALCOUNT | C114-DUAL-COUNT TRUE as stated (doubly periodic, non-Siamese, five edge-neighbours per tile): `n/2` quads, each emitting four distinct unit-arc edges, `2n` of `5n/2` edges; with `f₄` tiles of four edge-neighbours, `(n + f₄)/2` of excess vertex degree and at least `2n − 2f₄` unit-arc edges when only cubic vertices and quads occur | [hand; one mind] | §3.2 |

## Would-have-searched-here log (standing rule 3)

- Stage 1: (a) C114-PENT's third arc — I would have scanned the third centre over `ω(B_0)`; instead the two centres the partners need were derived
  (`C_0` and `D_1`) and counted. (b) The routes at `C_0` — I would have searched recolourings of the region near `C_0`; instead the one region each
  route must vacate was derived (the part of the one straddling tile inside `B(C_0, 1)`) and read at named exact points.
- Stage 2: (a) the dial — I would have searched cap shapes and radii; instead the cap is the one arc the stop point's colourless cone allows
  (its lower edge is the tangent of `ω(V_m)` at `Q`, FS112-EDGE), and the radius is the exact identity `1/4 + √3 Y = (7 + 3√5)/4`.
  (b) Other colourings of the strip's and the disk's geometries — I would have enumerated colourings; instead the exact conflict relations were
  read and the colourings derived by hand (a clique, then a fixed chain of forced steps, each asserted to have one outcome). (c) Torus designs —
  I would have searched periodic tilings; instead each family is killed by a local, colour-free derived obstruction, or its budget derived.
- Stage 3: (a) ENCLOSED3 — I would have searched insertions of small tiles; instead the one condition for an insertion (a colour free with margin
  at a cubic vertex) was read exactly at the strip's twelve cubic vertices of a period. (b) The index at BOWTIE — I would have scanned curve
  pairs; instead FS106-IND-X's hypothesis was read off BOWTIE's formula.

## Fence log (standing rule 13; the brief's § Fences)

1. At start-up `ls data/fs114/` listed the directory names `briefs`, `claims.md`, `fs114-p`, `reports` — the fenced `reports/` by name only, not its
   contents. Name-only touch.
2. At start-up `git log --oneline -8` showed three commit subjects beyond the five of the start-up snapshot (`73acb104 FS114-P: stage 6`,
   `fb9509fa FS111-P: stage 3a`, `9b9f0e47 FS114-P: stage 5b`) — subjects only, all the planner's or FS-111's; no fenced record read.
3. The harness saved the output of one of my own reads (a `sed` of `plans/FS112-derivation.md`, over its size limit) to a file under
   `~/.claude/projects/-home-kooshi-source-lean-dir/…/tool-results/`. I did not open it; I re-read the file directly in pieces.
4. `git status` after my stage-1 commit listed an untracked `data/fs114/briefs/NB114-instance.md` (a fenced brief) by name only; not opened.
5. `[Mohar2002]` and Ágoston's paper were already in `~/source/library/pdf/`, written at 23:10 tonight by another session (not a fenced path); I read
   those copies and fetched nothing.

## Stage 1 — SAVED: reading, the quotation check, calibration, and C114-PENT derived

### 1.1 Read from disk, in this order (reading status per section, G50)

- `data/fs114/briefs/STANDING-RULES.md` (rule 0 first); `CLAUDE.md` § The aim, § Counter-priors, G83, G82, G79, G72, G71, G68, G60, G29, G24, G21, G17,
  G15, G13 (in context from disk at start-up); `DEBRUIJN.md`.
- `LEDGER.md` rows 131–136, in full.
- `data/fs114/claims.md`, in full (§8 included).
- `plans/FS114-unit-arc-question.md`: §1.3, §G part 3, §PA, §IQ, 5.0, 5.1, 5.2, 5.4, stage 5b (5.3 not opened — owner's note 1). Stage 5b names two
  registrations by number and probability (E18, E19); read as part of 5b, as the brief directs.
- `plans/FS112-derivation.md`, in full; `data/fs112/claims.md` §0, §7, §8, §11; `plans/FS112-N-proof.md` §1.3, §2.2, stage N2-4, stages N3-3 and N3-4
  in full; `plans/FS112-Y-construction.md` §1.3, §1.5, stages 4–6 (the disk and the dial); `plans/FS112-Y3-construction.md` stages 2 and 4;
  `plans/FS112-YB2-verification.md` stages 2 and 4.
- `plans/FS106-V-verification.md` §2.1–2.2 and V3 stage 2.
- `[Thomassen1999]`, the held OCR text, all four pages (the page images not re-checked; nothing quoted from it here but the claim list's quotations).
- `[SokolovVoronov2025]` (`~/source/library/pdf/arXiv-2502.01958-maptype.pdf`, `pdftotext`): §3 (Theorem 1, Corollary 1, Theorem 2), the Conditions,
  §8's proofs of Theorems 1–2, §9 (Question 2) — read; Props. 7–19 located and skimmed by statement only (Prop. 10, 17, 18, 19; Lemma 5, 6), not
  re-walked (they are row 134's base, walked at FS-110 and by BASE-V).
- The Google group: `threads/Z50mmulkXCQ.txt` **in full** (every message body; quoted replies stripped by script, the images not held);
  `threads/J_Tw1_hUxQI.txt` lines 1–40, 589–770, 885–945, 4150–4200, 4455–4545 (the plan's stage-5b sections).
- `[Mohar2002]` (held copy `~/source/library/pdf/Mohar-2002-light-structures-infinite-planar.pdf`): abstract, §1, §2, §3's opening (the charge and
  inequality (1)) — read; §§3.1–6 not read.
- Ágoston 2025 = arXiv:2404.14398v2 (held copy `~/source/library/pdf/arXiv-2404.14398-agoston-nicely-colour-sphere.pdf`): abstract, §1 (1.1–1.3), §2's
  outline and §2.1's opening (Lemmas 4–5) — read; §2.1's remainder, §2.2 onward not read. For the record: its own remark that the plane case "also
  follows from a relatively easy proof using Lemma 7 and the fact that a triangulated planar graph has 3n − 6 edges" (p. 3) is the curvature count of
  route T for **nice** colourings.
- `[Sirgedas2021]` (Geombinatorics XXX(3) pp. 138–151, PDF pages 34–47 of `geombinatorics-v30-n3-2021-01.pdf`; no text layer, read as rendered page
  images at 130 dpi): pp. 1–11 and 13 read (the abstract, §1.1–1.4, §2.1–2.5, §3.2); pp. 12 and 14 not read. **What it holds for this side:** the
  "stitch" is a **seven**-colour device — along an icoedge of a Goldberg polyhedron two Isbell colourings mismatch by a swap of two colours, and the
  seam is repaired by contracting some boundaries to points where four tiles meet and drawing some boundaries as unit arcs, the pattern repeating
  every seven hexagons (p. 9, Figs. 7–8); its Fig. 2 is "an interesting unscalable tiling of the plane" in which each tile has diameter exactly 1 and
  is less than 1 from 16 other tiles (Isbell: 18). Nothing in it is a six-colour construction; its vocabulary (unscalable tiles, a tile abutting two
  tiles of one colour at a boundary and at a point) is the unit-radius tactic's.

### 1.2 Quotation check (standing rule 5)

`tools/fs114_y_quotes.py` (normalises quotes, backticks, bold, italics, line-break hyphens and whitespace on both sides): **28 of 28 FOUND**
(`data/fs114/fs114-y/quotes.out`) — every quotation of my brief (Kooshi's three; Question 2 in the claim list and in the paper's text), of the standing
rules (four), the claim-list statements this record works (seven, against `plans/FS112-derivation.md` and `plans/STUB-global-step.md`), and the
Sirgedas quotations of claim list §8 against the two held threads (twelve). Self-test: the first quotation with one word altered reads MISSING, its
faithful twin FOUND, and the faithful quotation against the wrong file MISSING (PASS). The paper's text is `pdftotext` of the held PDF into my scratch
(`sv.txt`); a successor regenerates it with `pdftotext -layout ~/source/library/pdf/arXiv-2502.01958-maptype.pdf`.
**Findings (none changes a statement):** (i) Question 2 as quoted in the brief and the claim list is word for word the paper's §9. (ii) The claim list's
§8 quotation "Similarly the metagraph can't have a quadrilateral. (Well, I'm pretty certain, but the proof below is a bit sloppy(?))." ends in the
thread with ")." after "(?)" — the claim list reproduces it exactly.

### 1.3 Calibration and C114-PENT

**Calibration (claim list §6; FS-112's checkers run as they are, never edited).**

| object | tool | verdict | pairs examined / present | output |
|---|---|---|---|---|
| the YB2 checker's self-test (ten controls, seven plants registered in its record) | `tools/fs112_yb2_check.py --selftest` | ALL AS PREDICTED | — | `cal-selftest.out` |
| the brick (row 33) and its Lean-recorded variants; the hexagonal seven-colouring (tight, side 1/2), its `11/20` and index-4 plants | `tools/fs112_yb2_calib.py cal7` | CALIBRATION: ALL AGREE (brick ACCEPT, 17 pairs, exact contacts at 1: the cell's diagonal and `(±1, ±2)`; hex7 ACCEPT, 7 pairs; plants REJECT) | 17 / 17; 7 / 7 | `cal-cal7.out` |
| the strip (`[AxenovichEtAl2014]` Thm 4.2) | `tools/fs112_yb2_objects.py strip` | ACCEPT; height `√15/2 + √3` exact; 36 exact contacts at 1 | 90 orbit pairs (every tile beyond the window dismissed by an exact `x`-gap 4.75) | `cal-strip.out` |
| the disk (`[Polymath2021]` Fig. 10) | `tools/fs112_yb2_objects.py disk` (4 min, under `scripts/slot.py`) | ACCEPT; 78 of 78 identities, `r² = (25 + 9√5)/10` three forms; 46 tight pairs | 71 / 71 | `cal-disk.out` |
| FS112-BOWTIE | `tools/fs112_yb3_frags.py bowtie` | ACCEPT; `E` stuck, doubly shadowed at five named points; tight pairs `(C±, CN)`, `(C±, CS)`, `(G, G)`, `(H, H)` | 21 / 21 | `cal-bowtie.out` |

All five controls ACCEPT with the pair counts equal to the pairs present. No new checker was written at this stage; any wrapper of stage 2 re-earns
the calibration on all five first (D7).

**C114-PENT, first question** (`plans/STUB-global-step.md` open item 3, verbatim): "on the disk's pentagon skeleton, can the trivalent `B_k` (two
unit-arc boundaries, centres `A_k`, `A_{k+1}`) be given a third unit-arc boundary whose completions are exactly their complementary partners
(`B_0`'s current partners `Z^R_0`, `Z^L_1` are not completions)?" — **No, and no choice of arcs at all repairs the configuration.** [hand + tools,
exact; one mind]

*Derivation.* In FS112-Y2's naming (`plans/FS112-Y-construction.md` §4.3), `B_0` is the corner of `T1_0` (orange), `U_0` (purple), `U′_0` (yellow), and
`Z^R_0` (of `T2_0`, `R_0`, `U′_4`: blue, red, green) and `Z^L_1` (of `T2_1`, `R_1`, `U_1`: green, red, blue) are cubic trichromatic and complementary to it,
at distance `√(2 − 1/φ) ≈ 1.1756 < 2`. Exactly (`tools/fs114_y_pent.py pent`, `data/fs114/fs114-y/pent.out`): `ω(B_0) ∩ ω(Z^R_0) = {A_0, C_0}` and
`ω(B_0) ∩ ω(Z^L_1) = {A_1, D_1}`, four distinct points. FS112-N3-COR3 (two minds, one blind) makes every common unit point of a close complementary
pair of cubic trichromatic vertices a leaving centre of both; a cubic vertex has at most three leaving centres (a boundary curve leaving it lies on
at most one unit circle — FS112-C-PARTNERS's count). So `B_0` would need four: **no valid map agrees with the disk near `B_0`, `Z^R_0`, `Z^L_1`**
(their neighbourhoods lie inside the disk, radius `≤ 1.51 < r`), whatever its arcs. The third centre each partner would need is exactly determined —
`Z^R_0 = A_0 + C_0 − B_0`, `Z^L_1 = A_1 + D_1 − B_0` (checked; pairing `Z^R_0` with `A_1` instead would need a centre at squared distance ≈ 2.382 from
`B_0`) — and `C_0 ≠ D_1`. `B_0`'s present leaving centres are `A_0` and `A_1`, and their completion `A_0 + A_1 − B_0` is **exactly the central corner
`A_3`** (a four-colour vertex, not a partner) — a precision of Y3 §4.2 item 4's "lies inside the central tile". **Control** (the same code on a twin):
a second partner `A_1 + C_0 − B_0` sharing the centre `C_0` gives three common unit points in all and no obstruction. **Plant** `wrongpts` (claim
`ω(B_0) ∩ ω(Z^L_1) = {A_1, C_0}`): refused exactly (`pent-plant-wrongpts.out`).

**The statement about every valid map (G79; reported to the owner):**
- **FS114-Y-PAIRSHARE.** *In a valid map, any two close complementary cubic trichromatic partners of a cubic trichromatic vertex `u` share a common
  unit point with `u`.* Proof: each partner's two common unit points with `u` are leaving centres of `u` (FS112-N3-COR3); `u` has at most three; two
  2-element subsets of a set of at most three points meet. ∎ [hand; one mind, over COR3's two] It is the pairwise form of FS112-C-PARTNERS, and it is
  what the disk violates at every `B_k`: its two partners face `B_k` from the two sides of the mirror line through `B_k`, and the mirror sends the
  common points `{A_k, C_k}` to `{A_{k+1}, D_{k+1}}`, disjoint. **Design rule it gives a YES:** a cubic trichromatic vertex `u` on a mirror line `L` of the
  design can have mirror-image complementary partners `u′ ≠ σu′` only if their shared centre `p` lies on `L` (a set `{p, q}` meets `{σp, σq}` only
  if `p = σp`, or `q = σp`, which puts `u′` on `L`); the unit arc of `ω(p)` through `u` then crosses `L` at right angles at `u`, both of its halves
  boundaries of `u`, and `u`'s third boundary runs along `L`. The disk's `B_k` has its third boundary along `L` but its two arcs centred off `L`.

**C114-PENT, second question** (verbatim): "And the disk's blue and orange routes to a fourth colour at `C_0`, never analysed (Y3 §4.4 (ii))." —
**Both fail one ring deeper, as yellow's did** [tools, exact at named points; one mind]. On the moved disk (FS112-MOVE: green freed, colourless wedge
`(54°, 90°)` at `C_0`), `tools/fs114_y_pent.py routes` (`data/fs114/fs114-y/routes.out`):
- the straddlers of `ω(C_0 + e(θ)/100)` for `θ = 54°, 72°, 90°` are one tile per colour — red `R_0`, blue `T2_0`, green `U′_4` (not at 90°), yellow
  `U′_0`, orange `T1_0`, purple `U_0` — so blue is freed only by `T2_0` leaving `B(C_0, 1)` and orange only by `T1_0` doing so;
- **blue:** at nine named points of `T2_0 ∩ B(C_0, 1)` (under the midpoint of `T2_0`'s top arc of `ω(A_0)`, under its 104° point, and on the
  diagonal from `Z^L_0` toward `A_0`, at depths 1/50, 1/20, 1/10), with `T2_0` ignored, the free set is `{Bl}` at seven points and `{Bl, P}` at two
  near `Z^L_0`; red is blocked by the central tile `C0` (the arc's out-contact), green by `U′_4` (and `T2_1`), yellow by `U′_0` and `T1_4`, orange by
  `T1_0` (and `U_4`), purple by `U_0` — so the part cannot be recoloured with the rest unchanged;
- **orange:** at nine named points of `T1_0 ∩ B(C_0, 1)` (beside `B_0` in the directions `−9°, 0°, 9°`, where `T1_0`'s sector `(234°, 18°)` at `B_0`
  meets the half-plane facing `C_0`), with `T1_0` ignored, the free set is exactly `{O}` at every point: red by `C0`, `R_0`, `R_1`; blue by `T2_0`;
  green by `T2_1`; yellow by `U′_0`, `T1_4`; purple by `T1_1`.
- *The instrument's controls:* on the moved disk the free-set test finds green free at `C_0 + e(126°)/100` (FS112-MOVE's known positive) and nothing
  at `C_0 + e(72°)/100` (the known wedge); plant `unmoved` (the same test on the unmoved disk) finds green blocked there (`routes-plant-unmoved.out`),
  the move's lens being the reason. The float guard `locate` reported two extra tiles at three points (its polyline inside-test; a guard, never a
  verdict).
- **What the two answers say together.** Every route to a fourth colour at `C_0` (yellow — FS112-Y3-PIN; blue, orange — here) fails with the rest of
  the disk unchanged, and by FS114-Y-PENT the disk's interior near every `B_k` is not part of any valid map anyway. The routes bear only on fragments
  (Mixon's thread-7 radius), never on a map: **to grow the disk into a map its design must change within radius ≈ 1.51 of its centre**.

**What this stage changes for stage 2.** The strip and the disk both violate FS112-C-PARTNERS inside their own interiors (the strip at its `(V, A)`
pairs, FS112-Y3-T2-BUDGET; the disk at `B_k`, here), so neither is a piece of any valid map, and a YES needs a design in which every cubic
trichromatic vertex's complementary partners pairwise share a leaving centre. Stage 2 asks that of a periodic design first (the torus) and reads the
dial on the strip, whose stop is at its edge.

## Stage 1 — SAVED

## Stage 2 — SAVED: the dial, the rigidity of both printed geometries, the torus families, the non-Siamese form

*The owner's scope note (received during stage 2): a YES is one valid map of the whole plane, locally finite, possibly with complexity growing
without bound; a family of maps is not a YES; each verdict names the class its objects lie in.*

### 2.1 C114-DIAL — met, marginally: the capped strip holds every disc about a four-colour vertex of radius below `φ²/√2 ≈ 1.85123`

**Derived first.** At the strip's stop point `Q = (1/4, Y)`, `Y = √3/2 + √15/4`, the colourless set is the open cone
`(arcsin ¼, 180° − arcsin ¼)` (FS112-EDGE). Its lower edge `arcsin ¼ ≈ 14.48°` is exactly the tangent at `Q` of the unit circle about the valley
`V_1 = (1/2, √3/2)`, on which both top corners of the top tile `T_1` lie (`|V_1 − Q|² = 1/16 + 15/16`). So `T_1` can be extended upward by the
**cap** bounded by the arc of `ω(V_1)` between its top corners: every cap point is within 1 of every point of `T_1` (the valley is `T_1`'s corner,
and moving along the arc from a corner decreases the distance to the far apex), and the cap's `x`-range is `T_1`'s, so it stays an exact 1 or more
from the other tiles of its colour. The disc: a point `z` of `B̄(P_1, R)` with `y ≥ Y` has `|z − V_1|² = |z − P_1|² − √3 y + 3/4 ≤ R² − √3 Y + 3/4`,
and `1/4 + √3 Y = (7 + 3√5)/4 = |P_1 − Q|² = Y² + 1/16` (exact); so for `R² < (7 + 3√5)/4` the part of the disc above the strip lies strictly inside
the cap (and strictly inside `x ∈ (1/4, 3/4)`), and the closed disc lies in the interior of the capped strip. `(7 + 3√5)/4 = φ⁴/2`.

**Checked exactly** (`tools/fs114_y_dial.py`, `data/fs114/fs114-y/dial.out`): the capped strip, every top and bottom tile capped, ACCEPTs — **90 orbit
pairs** (each same-colour orbit pair with a tile in one period and the other in columns −9…11), every tile beyond dismissed by an exact `x`-gap
4.75; 36 exact contacts at 1; each capped tile has diameter exactly 1 (self-pair maximum `= 1`); no Siamese pair (no distinct same-colour pair
has maximum `≤ 1`). The identities `1/4 + √3 Y = (7 + 3√5)/4`, `|P_1 − Q|² = (7 + 3√5)/4`, `Y² + 1/16 = (7 + 3√5)/4` hold exactly, and `R = 1.85`
and `1.851` lie below the bound, `1.852` above. **Plant** `cap_high` (every cap lifted by 1/20): REJECT at exactly the six capped self-pairs of the
period, registered before the run (`dial-plant-cap_high.out`).

**The bound over extensions.** Any valid extension of the strip (its tiles kept) holding `B̄(P_1, R)` with `R² ≥ (7 + 3√5)/4` holds `Q` in its
open domain, hence a neighbourhood of `Q`, which meets the colourless cone of FS112-EDGE (adding tiles only blocks more colours). So over
extensions of the strip the dial about a four-colour vertex is exactly the open interval up to `φ²/√2`, not attained (FS112-DISC's `φ` for the
disk is attained). **Class:** a fragment (the strip band plus caps: an open set of the plane, not the plane), periodic in one direction, bounded
complexity (at most six boundary pieces per tile), no Siamese pair. **E11** (0.25): met.

### 2.2 The printed geometries are rigid, and neither is part of any valid map under any colouring

**Method** (no colouring enumerated). `tools/fs114_y_conflicts.py` reads, exactly, for each pair of tiles of a geometry whether their cross distances
straddle 1 (`conflict`: never one colour), or not (`tight`, `siamese`, `far`). Controls: the printed colouring separates every conflict pair; plant
`shrink` (the geometry scaled by 1/2) changes the table (`conflicts-strip-plant-shrink.out`) — the table is read from the shapes, not the colours.
The derivations below use only the relations the tool asserts.

**The strip** (FS112-YB2's rebuild; `U` arches up, `D` arches down, `T` top tiles over the valleys `V_m`, `B` bottom tiles). Exact
(`conflicts-strip.out`): `U_0` conflicts with `U_{±1}`, `U_{±2}`, `D_{−2…2}`, `T_{−2…3}`, `B_0`, `B_1`; `T_0` with `T_{±1}`, `T_{±2}`, `U_{−3…2}`,
`D_{−1}`, `D_0`, and is tight with `D_{−2}`, `D_1`; `U_0` may share a colour with `U_{±3}`, `D_{±3}`; tiles six columns away are more than 1 away.
(My hand premises said `T_m` meets four arches; the exact table says six — corrected before any derivation used it.)
- **FS114-Y-STRIPK6.** The six tiles `U_{m−1}, U_m, U_{m+1}, T_m, T_{m+1}, T_{m+2}` pairwise conflict (asserted exactly for `m = 0`; the strip is
  invariant under `x ↦ x + 1/2` column by column), so in **every** valid colouring the valley `V_m` (tiles `U_{m−1}, U_m, T_m`) and the apex of
  `U_{m+1}` (tiles `U_{m+1}, T_{m+1}, T_{m+2}`) are complementary cubic trichromatic vertices at distance `√(9 − 3√5)/2 ≈ 0.757`. Their common
  unit points are `P_{m+1}` and `Q_m = (m/2 + 1/4, Y)`; FS112-N3-COR3 needs `Q_m` to be a leaving centre of `V_m`; the three boundary curves at `V_m`
  are arcs of `ω(P_{m−1})`, `ω(P_{m+1})` and a vertical segment. So **no valid map contains these six tiles**, whatever their colours and whatever
  else it holds. [tools, exact relations; hand; one mind, over COR3's two]
- **FS114-Y-STRIPRIGID** (the whole colouring). Any three consecutive top tiles `T_m, T_{m+1}, T_{m+2}` are pairwise distinct and each avoids the
  colours of `U_{m−1…m+2}` (four consecutive arches, at least three colours, as `U` conflicts at offsets 1 and 2); so those four arches use exactly
  three colours, `U_{m−1} = U_{m+2}` for every `m`: the arch row is 3-periodic on three colours `A`, the top row 3-periodic on the other three `B`.
  `D_j` conflicts with `U_{j−2…j+2}` (all of `A`), so the down row is 3-periodic on `B`; `T_m` avoids `D_{m−1}`, `D_m`, so `T_m` is `D_{m+1}`'s
  colour; by the mirror `y ↦ −y` the bottom row is `U_{m+1}`'s. Unique up to permuting the six colours. [hand over exact relations; one mind]
  This answers FS112-Y3-T2-BUDGET's "Not claimed: that no other colouring of the strip's geometry (a row with more than three colours) avoids
  complementary `(V, A)` pairs": **none does.**

**The disk** (FS112-YB2's rebuild; `Z` central, `P_k` ring 1 on the side `A_kA_{k+1}`, `W_k` ring 2 at `A_k`, `R_k`, `S_k`, `T_k` rim; 325 pairs;
`conflicts-disk.out`, 22 minutes under `scripts/slot.py`).
- **FS114-Y-DISKRIGID.** `Z` and the five `P_k` pairwise conflict — six colour classes, named by them. Then, in the fixed order `W_0…W_4`,
  `R_0…R_4`, `S_0…S_4`, `T_0…T_4`, each tile's conflicts with tiles already classed leave **exactly one** class (asserted for each of the twenty):
  `W_k` takes `P_{k+2}`'s, `R_k` takes `Z`'s, `S_k` takes `P_{k+1}`'s, `T_k` takes `P_{k+3}`'s. The forced partition is exactly the printed one
  (control). So the disk's geometry has one valid colouring up to permutation, and `B_0` (`P_0, S_0, T_1`) is complementary to `Z^R_0`
  (`W_0, R_0, T_0`) and to `Z^L_1` (`W_1, R_1, S_1`) under every colouring (asserted). With FS114-Y-PENT (the four common unit points `A_0, C_0,
  A_1, D_1`): **no valid map contains the disk's geometry near `B_k`**, under any colouring. [tools, exact relations; hand; one mind] (The disk is
  not a clique argument: `T_0` and `T_1` may share a colour; the rigidity comes from the chain.)

### 2.3 C114-TORUS — three families, and the screen they leave

**The screen (FS114-Y-K6, about every valid map).** Two cubic vertices `u`, `u′` at distance `< 2` whose six incident tiles pairwise straddle
distance 1 are complementary under every colouring, so each common unit point of `ω(u)`, `ω(u′)` must be a leaving centre of both (COR3); a geometry
failing that is part of no valid map, under any colouring. It is colour-free and local (it reads the six tiles), so it screens a design before any
colouring is chosen — and with FS114-Y-PAIRSHARE (partners pairwise share a centre) it is the design rule a YES must meet at every close pair.

| family (class) | free parameters vs the configuration's | verdict |
|---|---|---|
| **F1** — every map, periodic or not, of any complexity, containing six consecutive-column tiles of the strip around a valley and the apex beside it | the rest of the map: unbounded; the obstruction reads six tiles | **excluded** (FS114-Y-STRIPK6): no member is valid. So no doubly periodic design contains a row of `[AxenovichEtAl2014]`'s arches, however the rows are stacked, shifted or recoloured |
| **F2** — every map containing the disk's tiles near some `B_k` (`P_k, S_k, T_{k+1}`, the tiles at `Z^R_k`, `Z^L_{k+1}`, and those the rigidity chain reads) | the rest: unbounded | **excluded** (FS114-Y-DISKRIGID with FS114-Y-PENT): no member is valid; no periodic design contains the disk's centre |
| **F3** — doubly periodic valid maps with no Siamese pair in which every tile has exactly five edge-neighbours (Sirgedas's class, `[16.346]`, `Z50mmulkXCQ`) | not a formula family: its members are the torus maps of that combinatorial type | **budget derived, not decided.** Per tile (`n` tiles): the dual is 5-regular, the map's vertices are the dual's faces; on the torus `V − E + F = 0` gives `Σ_v (d_v − 3) = 3n − E = n/2`; with only cubic vertices and quads, `n/2` quads. Each quad `w` emits one unit arc centred at `w` per tile around it (the tile opposite a tile `t` at `w` carries the colour of an edge-neighbour of `t`, the pair is non-Siamese, so their contacts with `t` are the ends of a diameter of `t` and the shared edge lies on `ω(w)` — FS114-Y-EDGE below); distinct quads' arcs are distinct edges (two unit circles share at most two points), so at least `2n` of the `5n/2` edges are unit arcs (Sirgedas's 80%), and `4n` of the `5n` vertex–edge incidences are unit-arc ends. No contradiction follows at this level; the pair screen (FS114-Y-K6, PAIRSHARE) is the constraint no count has used yet |

**No torus member was built**: every candidate I could write by formula contains F1's or F2's configuration, and I have no F3 design; stated as a
stop, not a verdict on the torus. **E4** (a NO for doubly periodic maps at one mind, 0.3) is the proof side's to score.

### 2.4 C114-SIRGEDAS-FORM — not landed

Both held positives are non-Siamese: the disk (radius `√((25 + 9√5)/10) ≈ 2.1246`) has no distinct same-colour pair with maximum distance `≤ 1`
among its 45 distinct pairs (`cal-disk.out`), and neither has the capped strip (§2.1). So the non-Siamese record stays the disk's `≈ 2.1246`
(`[Polymath2021]`'s, not ours). I built no fragment beyond it. **The stops, as statements about every valid map:** the disk's geometry is part of no
valid map (FS114-Y-DISKRIGID with PENT), and every route to a fourth colour at its rim corner fails one ring deeper (FS114-Y-ROUTES, FS112-Y3-PIN) —
so a larger non-Siamese fragment needs a new skeleton, not an extension of the disk.

## Stage 2 — SAVED

## Stage 3 — SAVED: the killing tests

### 3.1 §IQ's candidates (a)–(c)

**(a) C114-RAINBOW** (the rainbow deficit; killing test: "a valid local fragment by formula with a face of map-degree at least 7 whose closed
neighbourhood repeats a colour with neither a Siamese pair nor a unit arc"). **MISSTATED; corrected as FS114-Y-RAINBOW** [hand; one mind].
*Derivation.* Let `T₁ ≠ T₂` have one colour and meet `cl x` at `p`, `q`. The interior cross distances of `T₁`, `T₂` fill an interval avoiding 1
(N-E0); if they are below 1 the pair is Siamese. Otherwise every cross distance is at least 1, while `|p − q| ≤ diam x ≤ 1`: so `|p − q| = 1 = diam x`,
`x ⊂ B̄(p, 1) ∩ B̄(q, 1)`, `T₁ ∩ B(q, 1) = ∅`, `T₂ ∩ B(p, 1) = ∅`. (i) If `T₁` shares a boundary arc with `x` near `p`, every point of that arc is a limit
of points of `x` (within 1 of `q`) and of `T₁` (at least 1 from `q`): the arc lies on `ω(q)` — the tactic, with `T₂` touching `x` at `q` only (two
positive-length arcs cannot both be at distance exactly 1 from each other point to point: FS114-Y-EDGE). (ii) Otherwise both touch `x` only at
single points, `p` and `q`, where `x` and the same-colour face are non-adjacent sectors; in a non-Siamese map the two sectors between them at `p`
carry two further colours, so `p` (and `q`) has at least four colours. Near `q`, `x` lies inside `B̄(p, 1)` and `T₂` outside it, so `ω(p)` leaves `q`
through the sectors between them: either it runs along a boundary there (a unit arc centred at `p`), or those sectors' colours avoid `P_cl(p)` (N-E1),
and then `P_cl(p) ∪ P_cl(q)` is all six: a covering pair at distance 1, where NB4P (exactly four colours) or FS112-SIX (five or six) puts arcs of
`Γ` on `ω(p)` or on unit circles about its ring points. **So the killing test as posed cannot fire in the strong sense** (a repeat always costs a
Siamese pair or a unit arc within distance 2 of the face), **but the arc need not separate the two faces**: case (ii) is the third option the claim
omits. Not built: a fragment realising (ii). In both printed positives every repeat is case (i) (the strip: `x = U_0`, `T_0` and `D_1` share red
across the arc of `ω(P_1)`; `T_1` and `D_{−1}` across `ω(P_0)`).

**(b) C114-SKELETON** (killing test: a valid fragment whose four-colour vertices violate a rule the skeleton asserts). **Did not fire on any held
fragment.** Every four-colour vertex whose unit circle lies inside a held fragment emits four unit arcs centred at it (the strip's midline
vertices, 62.09°; the disk's corners, 112.35°; the capped strip adds none); every close complementary pair whose rhombus lies inside a held
fragment is a rhombus completion with four-colour corners (FS112-Y3-R3, N3-P1 met). The positives break the skeleton's rules only at their edges —
which is exactly what FS114-Y-STRIPK6 and FS114-Y-PENT turn into obstructions. A caution for the proof side, derived: the cap arcs of §2.1 are unit
arcs centred at **cubic** vertices (the valleys), of kind in only; so "arrows" are not emitted by quads alone in fragments — in a map N3-NOBOTH
forbids them only when both-kind.

**(c) C114-BUDGET** (killing test: a four-colour vertex carrying arcs below the budget a charge rule assumes). **Did not fire.** The held
four-colour vertices with whole rings inside a fragment carry 62.09° (strip) and 112.35° (disk), four arcs each, above FS112-A4SIX's 60°.
FS112-BOWTIE's four-colour neighbours `N`, `S` carry one centred unit arc of 45.24° each, but their unit circles leave the fragment, so A4SIX's
hypothesis cannot be read there: **no held fragment tests the budget at a four-colour vertex below 60°**, and building one is the test's open form.

### 3.2 §8's claims

- **C114-EDGE-RAINBOW: TRUE** (FS114-Y-EDGE) [hand; one mind]. If `T₁ ≠ T₂` share one colour and arcs `α₁`, `α₂` of positive length with `x` and are
  not Siamese, every `p ∈ α₁`, `q ∈ α₂` has `1 ≤ |p − q| ≤ diam x ≤ 1`, so `α₂ ⊂ ω(p) ∩ ω(p′)` for two points `p ≠ p′` of `α₁`: at most two points.
  If `T₂ = x`, `T₁` and `x` are adjacent across an arc, so their cross distances reach 0 and all are below 1: Siamese. ∎ **No refuting fragment can
  exist.** Corollary: a face with six or more edge-neighbours has a Siamese pair among them and itself.
- **C114-DUAL-COUNT: TRUE as stated** (FS114-Y-DUALCOUNT) [hand; one mind]; derivation §2.3 F3. **With tiles of four edge-neighbours** (`f₄` of
  them, the rest five, only cubic vertices and quads): `2E = 5n − f₄`, so `Σ_v (d_v − 3) = 3n − E = (n + f₄)/2` quads — Sirgedas's "it creates
  another quad" is exactly `f₄/2` more — while a quad emits an arc only for the tiles around it that have five edge-neighbours, so the unit-arc edges
  number at least `4Q − 4f₄ = 2n − 2f₄`, against `E = (5n − f₄)/2` edges. **With Siamese pairs** the rainbow step fails (FS114-Y-EDGE is the only
  source of an emitted arc) and no count replaces it here.
- **C114-REDBLOCK:** first clause **TRUE** (FS114-Y-REDBLOCK1) [hand; one mind]: each tile's closed edge-neighbourhood has six tiles, rainbow by
  FS114-Y-EDGE, so exactly one red; so every non-red tile has exactly one red edge-neighbour and no two red tiles are edge-adjacent, and the blocks
  (a red tile with its five neighbours) partition the tiles. "Also this graph can't have pentagons": **GAP** at the post's step "The 5 rigid EDs
  have length 1, but then the "pentagon" will have at least one "edge" with length > 1." What is derived at a pentagon's common point `p` (five
  tiles, one per block, five colours): `ω(p)` meets only red open tiles (N-E1), the red tiles meeting it take arcs of angular width at most 60°
  pairwise at least 60° apart, and unit arcs centred at `p` total at least 180° (FS112-SIX) — no contradiction at that level. The quadrilateral clause
  ("a bit sloppy(?)", in the post's words): **GAP** at its step "the combined red/orange region will have width > 1 and this region can't actually be
  two-colored". "The red metagraph must have only triangles": **GAP**, resting on both.
- **C114-ENCLOSED3: GAP** (not derived, not refuted). Derived route to a local refutation [hand; one mind]: at a cubic trichromatic vertex `v`
  of a valid fragment, if some colour `d` is **free with margin** (every `d`-tile at distance strictly below 1 or strictly above 1 from all of it
  near `v`), a small enough triangular tile of colour `d` can be inserted at `v`, giving a valid fragment with an enclosed tile of exactly three
  edge-neighbours. **On the strip no cubic vertex has such a colour**: at each of its twelve cubic vertices of a period, each of the three
  complementary colours has a tile straddling distance 1 from the vertex (`tools/fs114_y_insert.py`, `data/fs114/fs114-y/insert.out`, exact;
  control: every colour is free with margin at `(1/2, 7/2)`). So the strip gives no local counterexample; the disk was not read (budget).

### 3.3 G71's E12 at FS112-BOWTIE's seam (the plan's E16)

**BOWTIE satisfies FS106-IND-X's hypothesis exactly, read from its formula** [hand; one mind, over IND-X's one]: the boundary at `E` between `G`
(colour 1) and the horns (colour 2) is the arc of `ω(N)` of angular width `2 arcsin(5/13) ≈ 45.24°`; `N` has four colours; the arc's side cones at
`N` (width 45.24°, about 0° and 180°, FS112-U1) hold colour 4 (`XR`, directions `[292.6°, 45°]`) and colour 5 (`XL`, `[135°, 247.4°]`), while the
inner colour 1 lies in the facing cone and the outer colour 2 (`CN`, `[45°, 135°]`) in the away cone. That is IND-X's configuration C5 "with a
colour in the side cones at y", where IND-X (one mind, SB, with a checker) makes complementary translate curves swap with `|ΔInd| = 2`. **Not built
here:** the explicit pair of curves on BOWTIE and its index trace. So E16 ("G71's index survives the bowtie seam with unit arcs", 0.75) reads
**not met at IND-X's grade**, pending that explicit check — a GAP, handed on.

### 3.4 Where the construction side stands (for the owner)

- **Scored registrations:** E10 (the pentagon admits the third arc, 0.3) — **not met**, a derived obstruction (FS114-Y-PENT). E11 (the dial
  beyond 1.834, 0.25) — **met**, to `φ²/√2`. E12 (a YES by formula, 0.03) — not met. E16 — see §3.3.
- **What a YES now must avoid, as statements about every valid map:** any six tiles in the strip's valley–apex configuration (FS114-Y-STRIPK6);
  the disk's centre (DISKRIGID with PENT); any close cubic pair failing the K6 screen; any cubic vertex whose close partners do not pairwise share a
  leaving centre (PAIRSHARE). Both printed positives fail these inside their own radii, so a YES needs a new skeleton, not an extension.
- **Left for a successor:** (1) the disk's cubic vertices read for a colour free with margin (ENCLOSED3's local form); (2) the explicit curve pair at
  BOWTIE's seam (E16); (3) a fragment realising FS114-Y-RAINBOW's case (ii); (4) a four-colour vertex with its whole ring inside a fragment and under
  60° of centred arcs (the budget's test); (5) a candidate skeleton meeting the K6 screen and PAIRSHARE at every close pair — the first design a
  torus attempt could start from.

**Proposed edits for the close** (I edit none of these files): `LEDGER.md` — the theorems of this record at their grades, and row 136's "Not
claimed: … any region larger than print" kept (nothing larger built, but the dial's vertex-centred radius moves to `φ²/√2`); `plans/FS112-derivation.md`
errata — Y3 §4.2 item 4's "the completion `A_0 + A_1 − B_0` lies inside the central tile" is exactly the corner `A_3`; FS112-Y3-T2-BUDGET's "Not
claimed … other colouring of the strip's geometry" answered (none, FS114-Y-STRIPRIGID); `data/fs114/claims.md` — C114-RAINBOW's corrected form.
`BIBLIOGRAPHY.md` rows: `[Mohar2002]` — held (`~/source/library/pdf/Mohar-2002-light-structures-infinite-planar.pdf`), abstract, §§1–2 and §3's
opening read; Ágoston 2025 — its arXiv version is arXiv:2404.14398v2, held (`~/source/library/pdf/arXiv-2404.14398-agoston-nicely-colour-sphere.pdf`),
§1, §2's outline and §2.1's opening read; `[Sirgedas2021]` — pp. 1–11 and 13 read (rendered images), its "stitch" a seven-colour device; the group
thread `Z50mmulkXCQ` read in full.

## Stage 3 — SAVED

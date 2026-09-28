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

## Would-have-searched-here log (standing rule 3)

- Stage 1: (a) C114-PENT's third arc — I would have scanned the third centre over `ω(B_0)`; instead the two centres the partners need were derived
  (`C_0` and `D_1`) and counted. (b) The routes at `C_0` — I would have searched recolourings of the region near `C_0`; instead the one region each
  route must vacate was derived (the part of the one straddling tile inside `B(C_0, 1)`) and read at named exact points.

## Fence log (standing rule 13; the brief's § Fences)

1. At start-up `ls data/fs114/` listed the directory names `briefs`, `claims.md`, `fs114-p`, `reports` — the fenced `reports/` by name only, not its
   contents. Name-only touch.
2. At start-up `git log --oneline -8` showed three commit subjects beyond the five of the start-up snapshot (`73acb104 FS114-P: stage 6`,
   `fb9509fa FS111-P: stage 3a`, `9b9f0e47 FS114-P: stage 5b`) — subjects only, all the planner's or FS-111's; no fenced record read.
3. The harness saved the output of one of my own reads (a `sed` of `plans/FS112-derivation.md`, over its size limit) to a file under
   `~/.claude/projects/-home-kooshi-source-lean-dir/…/tool-results/`. I did not open it; I re-read the file directly in pieces.
4. `[Mohar2002]` and Ágoston's paper were already in `~/source/library/pdf/`, written at 23:10 tonight by another session (not a fenced path); I read
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

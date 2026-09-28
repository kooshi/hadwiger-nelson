# FS114-Y5 — the construction side of FS-114, round 5 (K1's other killing tests: the pinwheel first)

*Job FS114-Y5 (de Bruijn, Opus 5.5), 2026-09-28, from `data/fs114/briefs/Y5-114-construction-round5.md`, the cards `ROUND2-card.md`, `ROUND3-card.md`,
`ROUND4-card.md`, FS114-Y's brief `Y114-construction.md` and `STANDING-RULES.md` (all read in full, rule 0 first). Working files
`data/fs114/fs114-y5/`; exact checks `tools/fs114_y5_*.py`; my scratch `scratchpad/fs114-y5/` (regenerable only). Resuming check: no record, working
directory, tool or report of this job existed at start. Every statement about a valid map is about a possible object: the class is not known to be
non-empty.*

*Notation (the pinwheel).* `p = 0`; `e(φ)` the unit vector at angle `φ`; angles at a point are directions from it, counter-clockwise from the positive
`x`-axis; a tile's **sector** at a vertex is the closed cone of directions it fills there; `ω(u)` the unit circle about `u`, `B(u, 1)` the open unit
disc, **the ring** is `ω(p)`. The four tactic centres are `q_j = e(φ_j)`, `j = 1 … 4` counter-clockwise, `α_{j+1} = φ_{j+1} − φ_j ∈ [60°, 180°]`
(indices mod 4). Edge `j` at `p` leaves `p` in direction `θ_j = φ_j − 90°` along `ω(q_j)`. The tile `t_{j+1}` (colour `j + 1`) is the tile at `p`
between edges `j` and `j + 1` (sector `[θ_j, θ_{j+1}]` at `p`, of width `α_{j+1}`): **inner** for edge `j` (`t_{j+1} ⊂ B̄(q_j, 1)`, `q_j ∈ cl t_{j+1}`)
and **outer** for edge `j + 1` (`t_{j+1} ∩ B(q_{j+1}, 1) = ∅`); this is the brief's pinwheel ("each tile at `p` inner for one tactic edge"), with the
brief's `q_j = p + e(θ_j + 90°)`. `T_j` is the tactic tile of colour `j` at `q_j`, meeting `t_{j+1}` at `q_j` alone. **The class:** the owner's
message of 2026-09-28 (verbatim): *"Start at the 120° cone" meant the class of pinwheels with at least one cone at `p` of exactly 120°. That is the stub
named K1-PIN120 in the round-4 record list. It does not mean one specific member.* Every result below states the class it covers.

## Theorems this phase proved

| id | statement (one line) | grade | address |
|---|---|---|---|
| FS114-Y5-QT | every quotation of my brief set and of this record is found at its source (24 of 24); the self-test's plant fires | [tools] | §1.2; `tools/fs114_y5_quotes.py` |
| FS114-Y5-RAINBOW | in a non-Siamese valid map two distinct tiles of one colour cannot both share a boundary arc of positive length with one tile (C114-EDGE-RAINBOW's non-Siamese form: each tile's edge-neighbours carry distinct colours) | [hand; one mind] | §2.1 |
| FS114-Y5-REGION | in a non-Siamese pinwheel `t_{j+1} ⊂ B̄(p, 1) ∩ B̄(q_j, 1) ∖ B(q_{j+1}, 1)` (N5-PIN0's region, re-derived) | [hand; one mind] | §2.1 |
| **FS114-Y5-PIN120-60** | no non-Siamese simple valid fragment containing a neighbourhood of `B̄(p, 1)` holds a pinwheel at `p` in which the tile across the outer edge of a 120° tile has a 60° cone — the alternating member `(120°, 60°, 120°, 60°)` included; radius `1 + ε` | [hand; one mind; tools exact at named values] | §2.2–2.3; `tools/fs114_y5_pin.py` |
| FS114-Y5-D90 | the four-fold 90° pinwheel with maximal Reuleaux blades admits no fragment containing a neighbourhood of `B̄(p, 1)` (one design) | [hand; one mind] | §2.3 |
| FS114-Y5-CHK | the inequalities PIN120-60 rests on, at named points with germ wedges: 31 of 31 as registered, a plant flipping the "both" block | [tools, exact at named values] | §2.4; `data/fs114/fs114-y5/pin.out` |

## Would-have-searched-here log (standing rule 3)

- Stage 2: I would have laid out pinwheel tiles near the ring (the 90° four-fold design, then the alternating member) and run the checker on each
  layout; instead one design (D90) was derived to its stop by hand, and the alternating member's sectors at `r = q_a + q_b` were read against the germs
  at `q_a`, `q_b`, `q_c` until RAINBOW closed it; the exact check was run once, on named wedges and probes.

## Fence log (standing rule 13; the brief's § Fences)

1. The harness's start-up context (not a command of mine) included the auto-memory index, a file under
   `~/.claude/projects/-home-kooshi-source-lean-dir/` (fenced): its lines name FS-112's and FS-114's milestone status and the standing rules; no proof
   content. No file under that path was opened by me.
2. The harness's start-up `git status` named FS-111's untracked `data/fs111/fs111-w/*.out` and my brief; five commit subjects. Names only.
3. At start-up `ls data/fs114/briefs/` listed every brief's file name (the proof side's `N*-114-*.md`, the verifiers' `NB*`, `YB*`, `CV*`, the advisor's,
   `L60-114-audit.md`); `ls data/fs114/` listed the fenced directory names `fs114-n*`, `fs114-nb*`, `fs114-yb3`, `fs114-cv*`, `reports`; `ls tools/fs114_y*`
   listed the names `tools/fs114_yb3_check.py`, `fs114_yb3_cusp.py`, `fs114_yb3_run.py` (the running verifier's). **Names only**; nothing in them opened,
   listed inside or grepped.
4. `git log --oneline -8` at start-up printed one subject past the snapshot ("FS-114: the Reuleaux bowtie family closed at root 3 by two blind routes;
   construction round 5 launched"). Subject only; no `git log -p`.

## Stage 1 — SAVED: reading, the quotation check, calibration, the owner's clarification

### 1.1 Read from disk (reading status, G50)

- `STANDING-RULES.md` (rule 0 first: `CLAUDE.md` § The aim and § Counter-priors, in context from disk at start-up), my round-5 brief, the three cards,
  FS114-Y's brief: **in full**.
- `plans/FS114-Y4-construction.md`: **in full** (SIDES, UPDOWN, W, LUNE, DIAG, RSTOPALL, CHK). `plans/FS114-Y2-construction.md`: **in full** (the design
  method). `plans/FS114-Y3-construction.md`: **in full**. `plans/FS114-YB2-verification.md`: **in full** (stages 1a–1c; its checker's header).
  `plans/FS114-L60-audit.md`: the header, theorem table, logs and §1.1–1.3(ii) **in full** (L60-LE, L60-EQ); the rest not read.
- `data/fs114/claims.md`: **in full**.
- Tools, data layout first (G46): `tools/fs114_y4_quotes.py` **in full**; `tools/fs114_yb_exact.py` lines 1–340 and 470–720 (arithmetic, pieces, the
  pair verdict, points, consistency); `tools/fs114_y2_k1.py` header and builder signatures.

### 1.2 Quotation check (standing rule 5)

`tools/fs114_y5_quotes.py`: **24 of 24 FOUND** (`data/fs114/fs114-y5/quotes.out`): Kooshi's seven quotations; Question 2 against the claim list and the
paper's text; K1 on the round-4 card against the round-2 card; K1-PIN on the round-4 card; repeat (A) and the tactic-edge sentence on the round-2 card;
FS112-U1, L60-LE, FS114-Y2-GAPS (both halves), FS114-Y4-UPDOWN, N-E1, FS114-Y4-RSTOPALL, FS112-SIX, C114-LOCAL-F, de Grey's Siamese. Self-test PASS
(`quotes-selftest.out`: an altered word MISSING, its faithful twin FOUND, the faithful quotation against the wrong file MISSING). **Not checkable:** my
brief's summary of N5-PIN0 (centres, cones `α_j ∈ [60°, 180°]`, "`t_j ⊂ B̄(p, 1) ∩ B̄(q_{j−1}, 1) ∖ B(q_j, 1)`, its ring contacts within 60° of `q_{j−1}`
and at least 60° from `q_j`") summarises a fenced record; I work it as stated (my indexing: `t_{j+1}` inner at `q_j`). My brief quotes nothing else but
its hand-back sentence.

### 1.3 Calibration (claim list §6)

Run unedited in this session under `scripts/slot.py --mem 2 --cpus 1`:
- **FS114-YB's checker**: `tools/fs114_yb_run.py selftest` → SELF-TEST PASSED, every checker plant flipping its predicted controls (`yb-selftest.out`);
  `calib` → brick, hexagonal seven-colouring, strip, disk, FS112-BOWTIE **all ACCEPT**, pairs examined printed against pairs held (3/17, 3/11, 24/90,
  52/71, 18/21), each object plant REJECT (`yb-calib.out`).
- **FS114-YB2's checker**: `tools/fs114_yb2_run.py selftest` → SELFTEST PASSED (`yb2-selftest.out`); `calib` → the same five **all ACCEPT** (11/11, 11/11,
  82/82, 71/71, 21/21 examined), plants AS PREDICTED (`yb2-calib.out`).
- `tools/fs114_y2_k1.py all` → FS114-Y2-BOWTIE ACCEPT (46 pairs, 40 examined), plants `v5`, `wide_t1`, `wide_t1b` as in Y2's record (`y2-k1-rerun.out`).

### 1.4 The owner's clarification (asked, answered)

I asked what "Start at the 120° cone" meant, proposing the member with cones `60°, 120°, 60°, 120°` (centres at `0°, 60°, 180°, 240°`). Answer (verbatim
in the header): the class **K1-PIN120**, every pinwheel with at least one cone of exactly `120°`; my member lies in it; state the class each result covers.

## Stage 1 — SAVED

## Stage 2 — SAVED: the pinwheel with a 120° cone followed by a 60° cone has no fragment at radius `1 + ε`

*Setting (hand; one mind). A non-Siamese, simple valid fragment containing a neighbourhood of the closed unit disc `B̄(p, 1)`, with a pinwheel at `p`
(notation of the header). Name the 120° tile `t_B` and rotate so that its inner centre is `q_a = e(300°)` and its outer centre is `q_b = e(60°)`.
Then `t_B` has sector `[210°, 330°]` at `p`, edge `a` (`t_A | t_B`) leaves `p` at `210°` along `ω(q_a)`, and edge `b` (`t_B | t_C`) leaves at `330°` along
`ω(q_b)`. The next centre is `q_c = e(60° + α_C)`, and `t_C` (sector `[330°, 330° + α_C]`) is inner at `q_b` and outer at `q_c`. The point
`r = q_a + q_b = e(0°)` lies on the ring, on `ω(q_a)` and on `ω(q_b)`: the three circles cross there, as `ω(p)`, `ω(q1)`, `ω(q4)` cross at `top` in the
bowtie. The two colours absent at `p` are `{5, 6}`; for `x ∈ {5, 6}`, `x̄` is the other one. Throughout I use:
- the **straddle computation** (Y3 §2);
- **UPDOWN** and **N-E1**;
- **FS114-Y2-GAPS** (both halves; quoted in §1.2);
- the **diameter bound** (a tile's closure has diameter at most 1);
- **one tile per colour at a vertex** (non-Siamese);
- and **EDGE-RAINBOW** (below).*

### 2.1 Two general lemmas [hand; one mind each]

**FS114-Y5-RAINBOW** (C114-EDGE-RAINBOW, non-Siamese form). In a non-Siamese valid map, two distinct tiles of one colour cannot both share a boundary
arc of positive length with one tile `x`. *Proof.* `cl x` has diameter at most 1, so points `x₁ ∈ s₁`, `x₂ ∈ s₂` of the two shared arcs satisfy
`|x₁ − x₂| ≤ 1`. Equality for all pairs would put `s₁` inside `ω(x₂) ∩ ω(x₂′)` for two points `x₂ ≠ x₂′` of `s₂`, a finite set. So some pair has
`|x₁ − x₂| < 1`, and interior points of the two tiles near them are closer than 1. Distinct tiles of one colour at minimum distance below 1 are Siamese.
∎ *(Sirgedas's statement, "Degree 6 isn't possible with only 6 colors", is its consequence: each tile's edge-neighbours carry distinct colours.)*

**FS114-Y5-REGION.** In a non-Siamese pinwheel, `t_{j+1} ⊂ B̄(p, 1) ∩ B̄(q_j, 1) ∖ B(q_{j+1}, 1)` (N5-PIN0's statement, re-derived).
*Proof.* The first two by the diameter bound, since `p, q_j ∈ cl t_{j+1}`. For the third: `T_{j+1}` has `t_{j+1}`'s colour and `q_{j+1} ∈ cl T_{j+1}`.
`T_{j+1} ≠ t_{j+1}`, because `T_{j+1}` meets the inner tile `t_{j+2}` at `q_{j+1}` alone while `t_{j+1}` shares edge `j + 1` with it. Non-Siamese then gives
distance at least 1. ∎

### 2.2 The steps at `r` [hand; one mind]

**The sectors at `r`.** The tangent directions of the three circles at `r` are `90°/270°` (the ring), `150°/330°` (`ω(q_a)`) and `30°/210°` (`ω(q_b)`). They
cut six sectors:

| sector | directions | inside `B(p, 1)` | inside `B(q_a, 1)` | inside `B(q_b, 1)` |
|---|---|---|---|---|
| `S0` | `(330°, 30°)` | no | no | no |
| `S_b` | `(30°, 90°)` | no | no | yes |
| `S_pb` | `(90°, 150°)` | yes | no | yes |
| `S_pab` | `(150°, 210°)` | yes | yes | yes |
| `S_pa` | `(210°, 270°)` | yes | yes | no |
| `S_a` | `(270°, 330°)` | no | yes | no |

1. **Tiles at `p` near `r`.** `t_B ∌ r`: otherwise `t_B ⊂ Reul(p, q_a, r)`, whose sector at `p` is `[270°, 30°]`, not `[210°, 330°]`. `t_A` and `t_D`
   lie in unit discs about centres more than 1 from `r`. So inside `B(p, 1)` near `r` the tiles are 5/6 or `t_C`, and `t_C ⊂ B̄(q_b, 1)` misses `S_pa`.
   Outside `B̄(p, 1)` near `r`: `t_B` (at `330°`) and `t_C` point toward `r` and block `B`, `C`. `t_D` (at `30° + (α_C − 60°)`) blocks `D` when
   `α_C < 120°`. `t_A` blocks `A` exactly when `α_A > 120°`.
2. **`q_b`'s inner gap.** At `q_b` the directions `(150°, s_C)` are inside `B(p, 1)` and not `t_C`, where `s_C ≥ 270°` is the start of `t_C`'s sector
   (REGION: `t_C` avoids `B(q_c, 1)`). No other tile at `p` is at `q_b`:
   - `t_B` is excluded by REGION and `T_b`;
   - `t_A` lies in a unit disc about `q_z = e(300° − α_A)`, and `|q_b − q_z| > 1`;
   - `t_D ∌ q_b` when `α_C = 60°`: `t_D` borders edge `d`, an arc of `ω(q_d)` whose points other than `p` lie outside `B̄(q_b, 1)` (they are
     `q_d + e(60° + τ)` with `q_d = −q_b`).

   So the inner gap holds 5/6 tiles only.
3. **Its colour at `q_c`, when `α_C = 60°`.** Now `|q_b − q_c| = 1`, and the direction from `q_b` to `q_c` is `180°`, so every inner-gap tile at `q_b` has
   points closer than 1 to `q_c`. At `q_c = e(120°)` the tile `I_c` just past the ring tangent `210°` is inside `B(p, 1)` and is not `t_D` (GAPS), so it is
   5/6. Its direction `210°⁺` points away from `q_b`, so `I_c ∌ q_b`. Hence the colour of `I_c` is carried by no inner-gap tile at `q_b`. So the inner gap
   at `q_b` has **one colour**, hence one tile `G` of colour `g`, with sector `⊇ (150°, 270°)`. This sector holds directions away from `r` (`(150°, 210°)`)
   and toward `r` (`(210°, 270°)`; the direction from `q_b` to `r` is `300°`), so **no tile at `r` has colour `g`**.
4. **`K`.** `S_pa` is 5/6 (step 1) and not `g`, so it is a tile `K` of colour `ḡ`, and `r ∈ cl K`.
5. **`t_C` reaches the ring tangent at `q_b`, and `O_b`.**
   - If `t_C`'s sector at `q_b` ended before `330°`, the tile `h` between would be inside `B(p, 1)` and of colour `ḡ` (a simple map has no second
     sector of `G`). It would point toward `r` at `330°⁻`, so `h = K`. But `K` has points in `S_pa`, outside `B̄(q_b, 1)`. So `t_C` reaches `330°`.
   - The tile `O_b` just past `330°` is outside `B(p, 1)` and points toward `r`. Its colour is not `C`, `g` or `B`. It is not `B` because `T_b` starts at
     `330° + β_b` (GAPS), and colour `B` in `(330°, 330° + β_b)` straddles edge `b`'s points. It is not `D` (`t_D` points at `q_b`).
   - It is not `ḡ`: it would equal `K`, which has points outside `B̄(q_b, 1)`.
   - So **`O_b` has colour `A`**, which colour `A` allows at `q_b` only if `t_A` does not point toward `q_b`, i.e. **`α_A ≤ 60°`** (for `α_A > 60°`, `t_A`'s
     directions near `150°` straddle it).

   **If `α_A > 60°` this is already the contradiction.**
6. **`S0` and `I_a`.**
   - `S0` lies outside `B̄(q_b, 1)`, so it is not `O_b`. It is not colour `A`: `O_b` points toward `r`, so every `A`-tile at `r` is `O_b`. It is not `g`,
     and `D` is blocked (`α_C = 60° < 120°`). So **`S0` is `ḡ`, part of `K`.**
   - `I_a`, the tile at `q_a` just past the ring tangent `30°`, is inside `B(p, 1)`. It is not `t_B` (GAPS: `t_B ⊂ [30° + β_a, 210°]`) and not `t_A`
     (`t_A ∋ q_a` would make `t_A` and `T_a` two `A`-tiles at `q_a`). So it is 5/6.
   - `I_a` points toward `r` (direction `60°`). It is not `K`, since `K ⊃ S0` lies outside `B̄(q_a, 1)`. So **`I_a` has colour `g`**.
7. **`t_B` reaches the ring tangent at `q_a`.** Otherwise the tile between `t_B`'s sector and `210°` at `q_a` is 5/6 and not `g` (`I_a`), so it is `ḡ`.
   It has points just inside the ring at angles `300°⁻`. `K` covers `S_pa ∪ S_a` at `r`, so it crosses the ring at angles `360°⁻`. Points of the two at
   angular distance 60°, with the inner depth and the outer height matched, are at distance exactly 1 (`|(1 − δ)e(ψ) − (1 + δ′)e(ψ + 60°)|² = 1 − δ + δ′ +
   O(δ², δ′²)`). This holds for both interiors, and the colour is the same. So `t_B` borders the ring from `q_a` clockwise to some `v`, and `v ≠ q_d`: at
   `q_d = e(240°)` the tile would contain `p, q_d, q_a`, and its side from `p` along `ω(q_d)` would be tangent to edge `b` at `p` with opposite curvature.
8. **RAINBOW on `t_B`.** `t_B`'s boundary is:
   - edge `a` (`p → w_a`, along `ω(q_a)`);
   - a clockwise side `w_a → v`, bordered by tiles inside `B(p, 1)` other than tiles at `p`, so 5/6 (a second contact with `t_A` is not simple);
   - the ring `v → q_a`;
   - a counter-clockwise side `q_a → w_b`, bordered likewise by 5/6 tiles;
   - edge `b` (`w_b → p`).

   `I_a` is `t_B`'s neighbour at `q_a`: a tile between them at `q_a` would be `ḡ` pointing toward `r`, hence `K`, which is impossible. So `t_B`'s
   `g`-neighbour is `I_a`, and the clockwise side's tiles, being 5/6 and on the other side of `t_B`, are `ḡ`. Hence the counter-clockwise side's tiles
   are all `g`, i.e. `I_a`: **`w_b ∈ cl I_a`**.
9. **RAINBOW on `t_C`.**
   - `G` is `t_C`'s neighbour at `q_b` (step 3: the inner gap is `G` alone).
   - `t_C`'s side from `w_b` toward the ring is bordered by 5/6 tiles. `w_b` is not on the ring: that would make `w_b = r`, and `t_B ∋ r`. These tiles are
     not `g`: they are not `G`, and there is only one `g`-neighbour. So they are `ḡ`.
   - `t_C`'s side from `w_c` (edge `c`'s end, `≠ q_b`, since `t_D ∌ q_b`) to `q_b` is bordered by 5/6 tiles, all `g`, i.e. `G`: **`w_c ∈ cl G`**.
10. **The contradiction.** `w_b` and `w_c` are interior points of two sides of the crescent `Cr_C = B̄(p, 1) ∩ B̄(q_b, 1) ∖ B(q_c, 1)`. This set lies in
    `Reul(p, q_b, r)`, where distance 1 needs a corner. So `|w_b − w_c| < 1`. `I_a` and `G` are distinct (`|q_a − q_b| = √3`), both of colour `g`, with
    points closer than 1. That contradicts non-Siamese. ∎

### 2.3 The results

**FS114-Y5-PIN120-60** [hand; one mind]. *No non-Siamese simple valid fragment containing a neighbourhood of the closed unit disc about `p` holds a
pinwheel at `p` in which the tile across the outer edge of a 120° tile has a 60° cone.* The case `α_A > 60°` ends at step 5, and `α_A = 60°`, the
alternating member `(120°, 60°, 120°, 60°)`, ends at step 10.
- **Class covered:** every member of K1-PIN120 with a 120° tile whose outer-edge neighbour has a 60° cone. This includes my stage-1 reading, the
  alternating member (centres at `0°, 60°, 180°, 240°`), and `(120°, 60°, 60°, 120°)`. With the cones listed counter-clockwise from the 120° tile, it is
  every member of the form `(120°, 60°, x, y)`, `x + y = 180°`.
- **Radius:** `1 + ε`. It reads neighbourhoods of `r`, `q_a`, `q_b`, `q_c` and the tiles inside `B̄(p, 1)`.
- **What it uses:** non-Siamese (RAINBOW; one tile per colour at a vertex; REGION); simple (step 5's "no second sector of `G`", step 8's "no second
  contact with `t_A`"); GAPS; the straddle computation. No count and no symmetry.
- **Where six is spent** (killing test 1): with a seventh colour, step 4's `K`, step 5's `O_b` and step 6's `S0` each take colour 7, and RAINBOW allows
  a third 5/6/7 neighbour. So six is spent at steps 4–6 and 8–9.

**FS114-Y5-D90** [hand; one mind; one design]. The four-fold 90° pinwheel with maximal Reuleaux blades, `t_{j+1} = Reul(p, e(φ_j − 60°), q_j) ∖
B(q_{j+1}, 1)` (edge `j + 1` of length 30°), admits no fragment containing a neighbourhood of `B̄(p, 1)`. The four pockets `g_j` (corners `q_j`,
`e(φ_j + 30°)` and `e(φ_j − 60°) + q_{j+1}`) must alternate in colour, since adjacent pockets meet at distance below 1 near `e(φ_j + 30°)`. Then at
`u = e(φ_j − 60°)` the sector inside `B(q_j, 1)` and outside the ring is forced to colour `j − 1`, and the outer-gap directions `(φ_j − 90°, φ_j − 60°)` at
`q_j` have no colour:
- colour `j − 1` would be the same tile as that sector's, within 1 of `T_{j−1}` at `q_{j−1}`, since `|q_{j−1} − u| = 2 sin 15° < 1`;
- colour `ā_j` would be within 1 of the pocket at `u`.

This is a statement about one design, recorded as a stop; the general 90° member is not decided here.

### 2.4 FS114-Y5-CHK (`tools/fs114_y5_pin.py`, `data/fs114/fs114-y5/pin.out`)

YB's checker imported unedited; every tile a germ wedge (sector of radius `1/5`) or a probe (triangle of size `1/1000`) in `ℚ(√3)`; predictions
registered in the docstring before the run. **31 of 31 as registered:** step 1 (`t_B ∌ r`; the `t_B`-, `t_C`-, `t_D`-wedges block probes in `S0`, `S_a`,
`S_b`; the `t_A`-wedge does not, control); step 3 (the `[150°, 270°]` wedge at `q_b` meets the `I_c`-wedge; a wedge pointing away from `q_c` does not,
control; the `[150°, 270°]` wedge blocks probes in `S0`, `S_pa`, `S_pab`, `S_b`; an away-only wedge does not block `S_pa`, control); step 5 (the `O_b`-wedge
blocks `S_pa` and `S0`, not `S_b`, control; at `α_A = 90°` the `t_A`-wedge blocks colour `A` in `q_b`'s outer gap, at `α_A = 60°` it does not, control);
step 6 (the `I_a`-wedge blocks `S0`, not `S_pa`, control); step 7 (`f(1/100, 0) < 1 < f(1/100, 2/100)`); step 10 (`|w_b − w_c|² = 0.268, 0.800, 0.501`
at `β = 30°/30°, 53.13°/53.13°, 53.13°/16.26°`). **Plant** `g_away` (the `[150°, 270°]` wedge replaced by `[150°, 196.26°]`,
`pin-plant-g_away.out`): B3 flips at `S0` **and** `S_pa`. I registered only `S0`. `S_pa` is also outside `B(q_b, 1)`, so it flips for the same reason, and
control B4 already shows it: a registration miss of mine, named. The checks confirm the inequalities at named values; the proofs are §2.2's derivations.

**Where it bears.** K1 is not refuted by any object of this job. The meeting point moves: every pinwheel in which a 120° tile's outer neighbour has a
60° cone is excluded at radius `1 + ε`, the smallest radius any fragment needs. What is left of K1-PIN120 is the members whose 120° tiles all have outer
neighbours of cone strictly between `60°` and `120°` (an outer neighbour of `120°` forces `(120°, 120°, 60°, 60°)`, excluded at its second 120° tile), for
example `(120°, 90°, 60°, 90°)` and `(120°, 80°, 80°, 80°)`.
The general pinwheel (no 120° cone) is untouched.

## Stage 2 — SAVED

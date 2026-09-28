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
| FS114-Y5-MU | for a blade `t_{j+1}` whose clockwise edge `j` is shorter than 60°: every 5/6 tile bordering its counter-clockwise side `M_j` (from `q_j` to `w_{j+1}`) is one tile `μ_j`, and every 5/6 tile bordering the inside part of its clockwise side `L_j` is one tile of the other colour; so `w_{j+1} ∈ cl μ_j` | [hand; one mind] | §3.1 |
| FS114-Y5-ALT | consecutive pocket colours differ, `m_j ≠ m_{j+1}`, unless `t_{j+2}`'s side `M_{j+1}` is a unit arc centred at `w_{j+1}` (exception E2) | [hand; one mind] | §3.1 |
| FS114-Y5-POCKET | outside E2 the tile bordering `t_{j+1}`'s side `M_j` also borders the whole inside part of `t_{j+2}`'s side `L_{j+1}` (`μ_j = Λ_{j+1}`) | [hand; one mind] | §3.1 |
| **FS114-Y5-CASE** | at each centre `q_k`, outside E1 and E2: either (B) `α_k = 60°` and `μ_{k−1} ∋ q_k`, or (A) `t_{k+1}` borders the ring clockwise from `q_k` for `λ_k ∈ [α_k − 60°, 60°]`, the outside tile there has colour `k − 1`, and `α_{k−1} + α_k ≤ 180°`; so every cone is at most `120°` | [hand; one mind] | §3.2 |
| **FS114-Y5-REDUCE** | outside E1 and E2, every pinwheel at radius `1 + ε` has cones `(x, 180° − x, x, 180° − x)` with `60° < x < 120°` (the family `P_x`) | [hand; one mind, over PIN120-60] | §3.3 |
| **FS114-Y5-PIN120** | K1-PIN120 is closed at radius `1 + ε`: no member exists unless E2 holds at the blade two past the 120° tile | [hand; one mind, over PIN120-60] | §3.3 |
| FS114-Y5-PX | in `P_x` (outside E2): `λ_k = α_k − 60°`, `v_{k+1} = e(φ_k + 60°)`, each `q_k` is a degree-4 vertex with exactly the tiles `O_k` (colour `k − 1`), `T_k` (`k`), `μ_k` (`m_k`), `t_{k+1}`; `μ_k` crosses the ring at `q_k`; `T_k`'s sector lies in `[φ_k − 90° + β_k, φ_k + 30°]`; the pocket colours alternate | [hand; one mind] | §3.4 |
| **FS114-Y5-PXKILL** | no non-Siamese simple valid fragment containing a neighbourhood of `B̄(p, 1)` holds a pinwheel of the family `P_x` (`60° < x < 120°`), outside E2: `T_k` and `O_{k+1}`, both of colour `k`, border the pocket tile `μ_k` along `ω(v_{k+1})` from `q_k` and along `ω(q_k)` from `v_{k+1}`, both outward, and come within `√(1 − 2tt′) < 1` | [hand; one mind; tools exact at named values] | §4.1–4.2; `tools/fs114_y5_px.py` |
| **FS114-Y5-PINALL** | **no non-Siamese simple valid fragment containing a neighbourhood of the closed unit disc about `p` holds a pinwheel at `p`**, except possibly under E1 (an edge at `p` of length exactly `60°`) or E2 (a blade's counter-clockwise side a unit arc centred at its clockwise edge end) | [hand; one mind, over REDUCE, PIN120-60, PXKILL] | §4.3 |
| FS114-Y5-CHK4 | the inequalities PXKILL rests on at named values in `P_90`'s frame: 11 of 11 as registered; the plant (one arc turned inward) accepts, as registered | [tools, exact at named values] | §4.2; `data/fs114/fs114-y5/px.out` |

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

## Stage 3 — SAVED: every pinwheel at radius `1 + ε` is `(x, 180° − x, x, 180° − x)`; K1-PIN120 is closed

*Setting (hand; one mind): a non-Siamese, simple valid fragment containing a neighbourhood of `B̄(p, 1)`, with a pinwheel at `p` in the header's notation.
Every tile's closure has diameter at most 1. The blade `t_{j+1}` has two edges at `p`:
- edge `j`, its **clockwise edge**, along `ω(q_j)`, of length `β_j` at `q_j`, ending at `w_j`;
- edge `j + 1`, its **counter-clockwise edge**, ending at `w_{j+1}`.

Traversed with its interior on the left, its boundary is:
- edge `j` (`p → w_j`);
- the side `L_j` (`w_j → q_j`), which arrives at `q_j` from the ring's clockwise side;
- the side `M_j` (`q_j → w_{j+1}`), which leaves `q_j` on the inner-gap side;
- edge `j + 1` (`w_{j+1} → p`).

FS112-U1 (inner colour `j + 1 ∈ P_cl(p)`, whose sector at `p` must face the arc) puts every ring contact of `t_{j+1}` clockwise of `q_j`. So `M_j` runs
inside the disc and is bordered by 5/6 tiles; `L_j` is an inside part, bordered by 5/6 tiles, followed by a ring part `[v_j, q_j]` (`v_j = e(φ_j − λ_j)`,
`λ_j ≥ 0`), bordered by outside tiles.

The four blades meet at `p` and reach the ring. So they cut the disc into four **pockets**: `Π_{j+1}` lies between `t_{j+1}`'s `M_j` and `t_{j+2}`'s
`L_{j+1}`, over the ring arc from `q_j` counter-clockwise. A simple map's tiles are open discs, so no tile lies on both sides of a blade. `μ_j` is `q_j`'s
inner-gap tile adjacent to `t_{j+1}` (it exists: GAPS gives the inner gap width at least `β_j > 0`), and `m_j` is its colour.

**The two exceptions.**
- **E1:** an edge at `p` of length exactly `60°`. By L60-EQ its outer tile then lies in the Reuleaux cap of the edge's ends, whose sector at `p` forces
  that tile's cone to be `60°`, and the edge ends at the tile's inner centre.
- **E2:** a blade `t_{j+2}` whose side `M_{j+1}` is an arc of `ω(w_{j+1})`.*

### 3.1 FS114-Y5-MU, -ALT, -POCKET [hand; one mind each]

**MU.** Edge `j` is shorter than `60°`, so `w_j` is inside the open disc and `L_j` has an inside part, bordered by some 5/6 tile.
- By RAINBOW that tile's colour is not `m_j`: the only `m_j`-neighbour is `μ_j`, which is on the other side.
- So every inside-`L_j` neighbour is one tile `Λ_j` of colour `m̄_j`.
- Then no `M_j`-neighbour has colour `m̄_j`, so all of them are `μ_j`. Hence `μ_j` borders `M_j` to its end: **`w_{j+1} ∈ cl μ_j`**. ∎

**ALT.**
- `μ_j` and `μ_{j+1}` are distinct: they lie in different pockets.
- `w_{j+1} ∈ cl μ_j`, and `μ_{j+1}` borders the arc `M_{j+1} ⊂ cl t_{j+2}`.
- Every point of `M_{j+1}` is within 1 of `w_{j+1}`, because `t_{j+2}`'s diameter is at most 1. The distance is exactly 1 at every point only when
  `M_{j+1} ⊂ ω(w_{j+1})`, which is E2.
- Otherwise the two tiles have points closer than 1, so **`m_j ≠ m_{j+1}`**. ∎

**POCKET.** At `w_{j+1}` the tiles are `t_{j+1}`, `t_{j+2}`, and pocket tiles, at most one of each colour 5, 6. The pocket tile next to `t_{j+1}` is `μ_j`,
and the one next to `t_{j+2}` is `Λ_{j+1}`, of colour `m̄_{j+1}`. If they differed, then `m_j ≠ m̄_{j+1}`, i.e. `m_j = m_{j+1}`, which contradicts ALT.
So **`μ_j = Λ_{j+1}`**: one tile borders `t_{j+1}`'s `M_j` and the whole inside part of `t_{j+2}`'s `L_{j+1}`. ∎

### 3.2 FS114-Y5-CASE — at each centre `q_k`, one of two cases [hand; one mind]

Let `k = j + 1`.
- **(B) `t_{k+1}` does not reach the ring's clockwise tangent at `q_k`.** The inside tile `h` between them borders `t_{k+1}`'s `L_k`, so `h = Λ_k = μ_{k−1}`
  (POCKET). Then `μ_{k−1} ∋ q_{k−1}, q_k`, and the diameter bound gives **`α_k = 60°`**.
- **(A) `t_{k+1}` borders the ring clockwise from `q_k`** on `[v_k, q_k]`, `λ_k > 0`. Then `μ_{k−1} ∋ v_k` and `μ_{k−1} ∋ q_{k−1}`, so `α_k − λ_k ≤ 60°`.
  Also `t_{k+1} ∋ q_k, v_k`, so `λ_k ≤ 60°`; hence **`α_k ≤ 120°`**.
  - `t_{k+1}` already has both 5/6 colours as neighbours (`μ_k`, `μ_{k−1}`). So the outside tiles along its ring contact carry colours 1–4 other than
    `k + 1`.
  - Just outside the ring at angle `φ_k − ε`, the tiles at `p` block `k + 1`, `k + 2` (`α_{k+1} < 180°`) and `k`.
  - They block `k − 1` exactly when `α_{k−1} + α_k > 180°`: `t_{k−1}`'s clockwise boundary direction is `φ_k + 270° − α_{k−1} − α_k`. At equality its
    boundary is the edge along `ω(−q_k)`, curving away, so the tangent case is free.
  - So the outside tile there has **colour `k − 1`, and `α_{k−1} + α_k ≤ 180°`**. ∎

### 3.3 FS114-Y5-REDUCE and FS114-Y5-PIN120 [hand; one mind]

**REDUCE.** CASE gives four conditions: for each `k`, `α_k = 60°` or `α_{k−1} + α_k ≤ 180°`. Every `α_k ∈ [60°, 120°]` and `Σ α_k = 360°`.
- **No `60°` cone.** Then summing `α_{k−1} + α_k ≤ 180°` over `k` gives `720° ≤ 720°`. So every sum is exactly `180°`: the cones are
  `(x, 180° − x, x, 180° − x)`.
- **One `60°` cone**, cones `(60°, a, b, c)`. If `b, c > 60°`: `a + b ≤ 180°` and `b + c ≤ 180°`, so `c ≥ 120°`, and then `b ≤ 60°`: impossible. If `b = 60°`:
  `a = c = 120°`, the alternating member, excluded by PIN120-60. If `c = 60°`: `a = b = 120°`, but `b > 60°` needs `a + b ≤ 180°`.
- **Two adjacent `60°` cones:** the other two sum to `240°`, so both are `120°`, and `a + b ≤ 180°` fails as above.

So, **outside E1 and E2, the only pinwheels at radius `1 + ε` are `P_x = (x, 180° − x, x, 180° − x)` with `60° < x < 120°`.** The 90° four-fold member is
`P_90`. E1 cannot occur in `P_x`, since it forces a `60°` cone.

**PIN120.** Let `t_k` have `α_k = 120°`, with `t_{k+1}` across its outer edge `k`. Apply CASE at `q_{k+1}` (blade `t_{k+2}`, pocket `μ_k`).
- **Case (A):** `α_k + α_{k+1} ≤ 180°`, so `α_{k+1} = 60°`. If edge `k + 1` has length `60°`, E1 gives `α_{k+1} = 60°` directly.
- **Case (B):** `h = Λ_{k+1}`. If `h = μ_k`, then `α_{k+1} = 60°`. If `h ≠ μ_k`, then `m_k = m_{k+1}`, and ALT puts us in E2 at `t_{k+2}`.

So `α_{k+1} = 60°` unless E2 holds at `t_{k+2}`, and PIN120-60 excludes `α_{k+1} = 60°`. **K1-PIN120 is closed at radius `1 + ε`, except under E2 at
the blade two past the 120° tile.** E1 needs no exception here.
- **Class covered:** every pinwheel with a `120°` cone (K1-PIN120), and via REDUCE every pinwheel outside `P_x`, E1 and E2.
- **Radius** `1 + ε`: it reads neighbourhoods of the four centres, of the edge ends, of the ring arcs near the centres, and the tiles inside the disc.
- **Where six is spent:** RAINBOW's "both 5/6 colours used" (MU, CASE (A)): a seventh colour would give each blade a third free neighbour colour.

### 3.4 FS114-Y5-PX — the forced shape of `P_x` near the ring [hand; one mind]

In `P_x` (no cone is `60°`, so case (A) holds at every `q_k`), outside E2:
1. **`O_k` and `λ_k`.** The outside tile along `t_{k+1}`'s ring contact has colour `k − 1`. Colour `k + 2` is blocked on the whole arc, because
   `α_k + α_{k+1} = 180°`. By RAINBOW it is one tile `O_k`, so `O_k ∋ v_k, q_k`. `O_k` and `T_{k−1}` (colour `k − 1`, at `q_{k−1}`) are distinct, since
   `|q_{k−1} − q_k| > 1`. So `|q_{k−1} − v_k| ≥ 1`, i.e. `λ_k ≤ α_k − 60°`. With CASE (A), **`λ_k = α_k − 60°`, `v_k = e(φ_{k−1} + 60°)`, and
   `|q_{k−1} − v_k| = 1`**: `μ_{k−1} ⊂ B̄(q_{k−1}, 1) ∩ B̄(v_k, 1)`.
2. **`T_k`** avoids `B(v_{k+1}, 1)` (`O_{k+1} ∋ v_{k+1}`, `|q_k − v_{k+1}| = 1`), so **`T_k ⊂ [φ_k − 90° + β_k, φ_k + 30°]`**.
3. **`μ_k` crosses the ring at `q_k`.** The outside directions `(φ_k + 30°, φ_k + 90°)` at `q_k` must be covered. The candidate colours:
   - `k − 1` is `O_k` again (a second sector: not simple);
   - `k` is `T_k`, which lies below `φ_k + 30°`;
   - `k + 1` is `t_{k+1}`, inside;
   - `k + 2` is blocked by `t_{k+2}`;
   - `m̄_k` would be within 1 of `v_k ∈ cl μ_{k−1}`, since `|q_k − v_k| = 2 sin((α_k − 60°)/2) < 1`.

   So **`μ_k` covers them**, and `q_k` has exactly the four tiles `O_k`, `T_k`, `μ_k`, `t_{k+1}`, of four colours.
4. **The pocket colours alternate** (ALT): `m_1 = m_3 ≠ m_2 = m_4`. So `μ_k` and `μ_{k+2}` share a colour and must be at least 1 apart. With equal edge
   lengths `β` in `P_90` this needs `|w_{k+1} − w_{k+3}| = 4 sin(β/2) ≥ 1`, i.e. `β ≥ 28.96°`. Blade diameter needs adjacent edge ends at most 1 apart:
   `2√2 sin(β/2) ≤ 1`, i.e. `β ≤ 41.41°`, with E2 at equality.

**Where it bears.**
- K1 in the pinwheel case, read at radius `1 + ε`, reduces to one one-parameter family `P_x` and the two named exceptions. Every other pinwheel, K1-PIN120
  included, is excluded at the smallest radius a fragment has.
- The forced shape (3.4) is the construction target: `P_x` near the ring is rigid up to the edge lengths and the shapes of the pockets, caps and wedges.
- **Next:** build `P_90` by formula at radius `1 + ε`, check it exactly, and push its radius.

## Stage 3 — SAVED

## Stage 4 — SAVED: `P_x` is excluded at radius `1 + ε`, so no pinwheel survives outside E1 and E2

### 4.1 FS114-Y5-PXKILL [hand; one mind]

*Setting:* `P_x`, `60° < x < 120°`, outside E2, with the forced shape of §3.4. Every cone lies in `(60°, 120°)`, so `|q_k − q_{k+1}| > 1`; `v_{k+1} = e(φ_k +
60°)` is on `ω(q_k)`; `O_{k+1}` (colour `k`) borders `t_{k+2}`'s ring contact `[v_{k+1}, q_{k+1}]`; `μ_k` (colour `m_k`) contains `q_k` and `v_{k+1}`.
1. **`T_k` stays out of `B(v_{k+1}, 1)`.** `T_k` and `O_{k+1}` are distinct tiles of colour `k`, since `O_{k+1} ∋ q_{k+1}`. `O_{k+1}` contains `v_{k+1}`.
2. **`T_k` borders `μ_k` along `ω(v_{k+1})` from `q_k`.** By §3.4 step 3, `μ_k` covers the outside directions at `q_k` next to `T_k`, so they share a curve
   from `q_k`. That curve lies in `cl μ_k ⊂ B̄(v_{k+1}, 1)` (`μ_k ∋ v_{k+1}`, diameter) and outside `B(v_{k+1}, 1)` (step 1). So it is an arc of
   `ω(v_{k+1})`, leaving `q_k` at `φ_k + 30°`, outward.
3. **The sectors at `v_{k+1}`** (frame `φ_k = 0°`: `ω(p)` and `ω(q_k)` cross at `v_{k+1}` at 60°):
   - `(210°, 330°)`, inside both discs: `μ_k` (the pocket).
   - `(150°, 210°)`, inside `B(p, 1)` only: `t_{k+2}`, since `μ_k ⊂ B̄(q_k, 1)`.
   - `(330°, 30°)`, outside the ring, inside `B(q_k, 1)`. Only colours `k`, 5, 6 are free outside the ring on the arc `(φ_k, φ_{k+1})` (§3.4).
     - Colour `k` would be within 1 of `q_k ∈ cl T_k`, by a tile other than `T_k` (step 1).
     - `m̄_k` would be within 1 of `q_{k+1} ∈ cl μ_{k+1}` (`|v_{k+1} − q_{k+1}| = 2 sin((α_{k+1} − 60°)/2) < 1`). It is not `μ_{k+1}`: that tile contains
       `v_{k+2}`, more than 1 away.
     - So the sector is **`μ_k`**.
   - `(30°, 150°)`, outside both. Colour `m̄_k` is excluded as before. `m_k` is excluded: `μ_k ⊂ B̄(q_k, 1)`, and any other `m_k`-tile is within 1 of
     `μ_k`. So the sector is colour `k`, **`O_{k+1}`**, the one `k`-tile at `v_{k+1}`.
   - So `μ_k` and `O_{k+1}` share a curve from `v_{k+1}` in `cl μ_k ⊂ B̄(q_k, 1)` and outside `B(q_k, 1)` (step 1's symmetric fact). It is an arc of
     `ω(q_k)`, leaving `v_{k+1}` outward.
4. **The contradiction.** `v_{k+1} = q_k + e(b)`, `q_k = v_{k+1} + e(b + 180°)`. Points `v_{k+1} + e(b + 180° + t)` of `T_k`'s arc and `q_k + e(b − t′)` of
   `O_{k+1}`'s arc are at distance `|e(t) − 1 + e(−t′)| = √(1 − 2tt′ + O(3)) < 1` (YB2-DE's computation). Both tiles have colour `k` and are distinct, and
   they also have points more than 1 apart. So they straddle, which no valid map allows, Siamese or not. ∎

*Equivalently:* RAINBOW on `μ_k`, which would have two edge-neighbours of colour `k`.

### 4.2 FS114-Y5-CHK4 (`tools/fs114_y5_px.py`, `data/fs114/fs114-y5/px.out`)

The frame is `P_90`, `k = 1`: `q_1 = (0, 1)`, `v_2 = e(150°)`. YB's checker is imported unedited, with this job's stage-2 wedges and probes. Predictions
were registered in the docstring before the run. **11 of 11 as registered:**
- PX-1: just outside the ring clockwise of `q_1`, the `t_1`, `t_2`, `t_3` wedges block and the `t_4` wedge does not (control).
- `|q_4 − v_1|² = 1` exactly and `|q_1 − v_1|² < 1`.
- At `v_2`, a `T_1`-wedge `[36.87°, 120°]` blocks colour 1 in the sector inside `B(q_1, 1)` and not in the sector outside it (control).
- **The kill.** A colour-1 tile with an arc of `ω(v_2)` from `q_1` outward (to `v_2 + e(46.26°)`), and a colour-1 tile with an arc of `ω(q_1)` from `v_2`
  outward (to `q_1 + e(193.74°)`): **REJECT**, with min < 1 < max. A wedge at `v_2` pointing away from `q_1` does not (control).

**Plant** `inward` (`px-plant-inward.out`): the second arc taken into the disc (to `q_1 + e(226.26°)`) gives min exactly 1 and no pair below. So the pair
ACCEPTs, as registered: the outward direction of both arcs is what fires.

### 4.3 FS114-Y5-PINALL — no pinwheel at radius `1 + ε` [hand; one mind]

REDUCE (§3.3) leaves only `P_x`, `60° < x < 120°`, outside E1 and E2, and PXKILL excludes `P_x` outside E2. So **no non-Siamese simple valid fragment
containing a neighbourhood of the closed unit disc about `p` holds a pinwheel at `p`, outside E1 and E2.**
- **Class covered:** K1-PIN's pinwheel, every member (every cone sequence), K1-PIN120 included, outside E1 and E2.
- **Radius** `1 + ε`: every step reads neighbourhoods of `p`'s four centres, of the points `v_k` on the ring, of the edge ends, and the tiles inside the disc.
- **What it uses:**
  - non-Siamese (RAINBOW; one tile per colour at a vertex; REGION; the distinctness steps);
  - simple (tiles are open discs, so no tile lies on both sides of a blade; connected sectors);
  - GAPS, FS112-U1, L60-EQ (for E1's shape), the straddle computation.

  It uses no count, no symmetry and no radius beyond `1 + ε`.
- **Where six is spent:** RAINBOW with two free colours at every blade and pocket: MU, CASE (A)'s colour `k − 1`, §3.4 step 3's exclusion of `m̄_k`, and
  step 3 of 4.1. A seventh colour gives each blade a third free neighbour colour and each sector at `v_{k+1}` a third candidate.
- **Killing test 8 (the local positives):** the strip and the disk hold no degree-4 vertex with four tactic edges, so PINALL says nothing about them.
- **G79 reading** (an example invariant of every valid map): around a degree-4 vertex whose four edges are tactic, a non-Siamese simple valid map never has
  the pinwheel incidence (each tile inner for exactly one edge). Counting, for each tile, the edges it is inner for gives `(1, 1, 1, 1)` (the pinwheel), `(2, 1, 1, 0)` or `(2, 0, 2, 0)` (the bowtie family); two adjacent
  2's would give one edge two inner tiles. So the vertex's pattern is `(2, 1, 1, 0)` or `(2, 0, 2, 0)`, or it is in E1 or E2. By Y4-RSTOPALL and
  N4-BOWTIE the Reuleaux members of `(2, 0, 2, 0)` stop at `√3`.

**What is left of K1's four-tactic-edge case:**
- E1 and E2 for the pinwheel;
- the non-Reuleaux lenses (tiles inner for both their edges but not Reuleaux triangles);
- the non-simple bowtie.

The three-tactic-edge patterns `(2, 1, 1, 0)` are untouched. This job has not built a pinwheel fragment at any radius: none exists outside E1 and E2.

## Stage 4 — SAVED
